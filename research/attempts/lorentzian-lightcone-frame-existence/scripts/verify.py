"""verify.py — proof.md 里所有可机检断言的独立复算。

用法（无第三方依赖，标准库 fractions / random 足够；球面环那一节用浮点抽样）：

    python research/attempts/lorentzian-lightcone-frame-existence/scripts/verify.py

每个 check_* 函数对应 proof.md 的一节，失败即抛 AssertionError。
最后打印一行 ALL CHECKS PASSED。

约定：向量是 Fraction 的 tuple，长度 D；eta 是 ±1 的 list（条件 (F1)）。
"""

from __future__ import annotations

import math
import random
import sys
from fractions import Fraction as F

# Windows 控制台默认 GBK，编不出 ℤ / ⟹ 之类；统一切到 UTF-8。
try:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
except AttributeError:  # pragma: no cover
    pass

# ---------------------------------------------------------------- 基本运算


def dot(eta, x, y):
    return sum(e * a * b for e, a, b in zip(eta, x, y))


def add(x, y):
    return tuple(a + b for a, b in zip(x, y))


def sub(x, y):
    return tuple(a - b for a, b in zip(x, y))


def smul(c, x):
    return tuple(c * a for a in x)


def zeros(D):
    return tuple(F(0) for _ in range(D))


def basis_vec(D, mu):
    return tuple(F(1) if i == mu else F(0) for i in range(D))


def det(mat):
    """分数域上的行列式（高斯消元）。mat 是 list of list of Fraction。"""
    n = len(mat)
    m = [row[:] for row in mat]
    d = F(1)
    for col in range(n):
        piv = None
        for r in range(col, n):
            if m[r][col] != 0:
                piv = r
                break
        if piv is None:
            return F(0)
        if piv != col:
            m[col], m[piv] = m[piv], m[col]
            d = -d
        d *= m[col][col]
        inv = F(1) / m[col][col]
        for r in range(col + 1, n):
            if m[r][col] != 0:
                f = m[r][col] * inv
                for c in range(col, n):
                    m[r][c] -= f * m[col][c]
    return d


def solve(mat, rhs):
    """解 mat · x = rhs（方阵，分数域）。无解/奇异返回 None。"""
    n = len(mat)
    aug = [row[:] + [rhs[i]] for i, row in enumerate(mat)]
    for col in range(n):
        piv = None
        for r in range(col, n):
            if aug[r][col] != 0:
                piv = r
                break
        if piv is None:
            return None
        aug[col], aug[piv] = aug[piv], aug[col]
        inv = F(1) / aug[col][col]
        for c in range(col, n + 1):
            aug[col][c] *= inv
        for r in range(n):
            if r != col and aug[r][col] != 0:
                f = aug[r][col]
                for c in range(col, n + 1):
                    aug[r][c] -= f * aug[col][c]
    return [aug[r][n] for r in range(n)]


def gram(eta, vecs):
    return [[dot(eta, x, y) for y in vecs] for x in vecs]


# ---------------------------------------------------------------- §1 定理 1


def check_detG_of_frame(eta, a, b, eps, label):
    """定理 1：(F1)(N)(S)(T)(O) ⟹ det Gram(a,b,ε…) = −1，且 (a,b,ε) 是基。"""
    D = len(eta)
    assert dot(eta, b, b) == 0, f"{label}: (N) 失败"
    assert dot(eta, b, a) == 1, f"{label}: (S) 失败"
    for i, e in enumerate(eps):
        assert dot(eta, e, b) == 0, f"{label}: (T) 失败 i={i}"
        for j, f_ in enumerate(eps):
            want = F(1) if i == j else F(0)
            assert dot(eta, e, f_) == want, f"{label}: (O) 失败 {i},{j}"
    vecs = [a, b] + list(eps)
    assert len(vecs) == D, f"{label}: 向量个数 {len(vecs)} ≠ D={D}"
    G = gram(eta, vecs)
    assert det(G) == -1, f"{label}: det G = {det(G)} ≠ −1"
    B = [[vecs[k][mu] for k in range(D)] for mu in range(D)]  # 第 k 列是 vecs[k]
    dB = det(B)
    assert dB in (F(1), F(-1)), f"{label}: det B = {dB} 不是单位"
    return dB


# ---------------------------------------------------------------- §2 定理 2


def null_shift(eta, a, b, eps):
    """ε'_i := ε_i − η(ε_i,a)·b。"""
    return [sub(e, smul(dot(eta, e, a), b)) for e in eps]


def check_D6_shift():
    """proof.md §2 注 2.3：coordinator 给的 D = 6 例子及其平移。"""
    D = 6
    eta = [-1] + [1] * 5
    b = tuple(map(F, (1, 1, 0, 0, 0, 0)))
    a = tuple(map(F, (0, 1, 1, 0, 0, 0)))
    eps = [basis_vec(D, mu) for mu in (2, 3, 4, 5)]
    assert dot(eta, b, b) == 0 and dot(eta, b, a) == 1 and dot(eta, a, a) == 2
    check_detG_of_frame(eta, a, b, eps, "D6 原标架")
    # (T′) 在原标架上失效
    gammas = [dot(eta, e, a) for e in eps]
    assert gammas == [F(1), F(0), F(0), F(0)], gammas
    epsp = null_shift(eta, a, b, eps)
    assert epsp[0] == tuple(map(F, (-1, -1, 1, 0, 0, 0))), epsp[0]
    for e in epsp:
        assert dot(eta, e, a) == 0 and dot(eta, e, b) == 0
    check_detG_of_frame(eta, a, b, epsp, "D6 平移标架")
    check_F8(eta, a, b, epsp, expected=True, label="D6 平移标架")
    check_F8(eta, a, b, eps, expected=False, label="D6 原标架")


# ---------------------------------------------------------------- §3 定理 3


def check_F8(eta, a, b, eps, expected, label):
    """(F8)：∀ e 与 v = a − b 正交 ⟹ e ∈ span{ε_i, v}（系数在分数域里找）。

    这里在 ℚ 上检验（定理 3 的等价判据是 t = 2 且全部 η(ε_i,a) = 0）。
    """
    D = len(eta)
    v = sub(a, b)
    # 生成 v^⊥ 的一组张成向量：D 个 e_μ 减去它在 v 方向上的分量不一定落在 v^⊥ …
    # 直接解线性方程：找 v^⊥ 的基。
    perp_basis = []
    # η(e,v) = Σ_μ η_μ e_μ v_μ = 0，即系数向量 c_μ = η_μ v_μ
    coeff = [eta[mu] * v[mu] for mu in range(D)]
    piv = next((mu for mu in range(D) if coeff[mu] != 0), None)
    assert piv is not None, f"{label}: v 与 η 全正交，设定退化"
    for mu in range(D):
        if mu == piv:
            continue
        e = [F(0)] * D
        e[mu] = F(1)
        e[piv] = -coeff[mu] / coeff[piv]
        perp_basis.append(tuple(e))
    gens = list(eps) + [v]
    M = [[g[mu] for g in gens] for mu in range(D)]  # D × (m+1)
    ok = True
    for e in perp_basis:
        # 最小二乘式精确解：解 M c = e（超定，用高斯消元判相容）
        if not solve_rect(M, list(e)):
            ok = False
            break
    assert ok == expected, f"{label}: (F8) 实测 {ok}，预期 {expected}"


def solve_rect(M, rhs):
    """M（D×k，Fraction）· c = rhs 是否有解。"""
    D = len(M)
    k = len(M[0])
    aug = [M[r][:] + [rhs[r]] for r in range(D)]
    row = 0
    for col in range(k):
        piv = None
        for r in range(row, D):
            if aug[r][col] != 0:
                piv = r
                break
        if piv is None:
            continue
        aug[row], aug[piv] = aug[piv], aug[row]
        inv = F(1) / aug[row][col]
        for c in range(col, k + 1):
            aug[row][c] *= inv
        for r in range(D):
            if r != row and aug[r][col] != 0:
                f = aug[r][col]
                for c in range(col, k + 1):
                    aug[r][c] -= f * aug[row][c]
        row += 1
    for r in range(row, D):
        if aug[r][k] != 0:
            return False
    return True


# ---------------------------------------------------------------- §6.0 ℤ 见证


def check_D3_integer_witness():
    """proof.md §6.0：WitnessInt 的 D=3 见证违反 (T′)(F8)；平移后是完整标架。"""
    D = 3
    eta = [-1, 1, 1]
    b = tuple(map(F, (1, 1, 0)))
    a = tuple(map(F, (0, 1, 1)))
    eps_bad = [tuple(map(F, (0, 0, 1)))]
    assert dot(eta, b, b) == 0 and dot(eta, b, a) == 1 and dot(eta, a, a) == 2
    dB = check_detG_of_frame(eta, a, b, eps_bad, "D3 原见证")
    assert dB == -1, dB  # proof.md §1.2 里写的 det B = −1
    assert dot(eta, eps_bad[0], a) == 1  # (T′) 失效
    check_F8(eta, a, b, eps_bad, expected=False, label="D3 原见证")
    # 平移
    epsp = null_shift(eta, a, b, eps_bad)
    assert epsp[0] == tuple(map(F, (-1, -1, 1))), epsp[0]
    # 系数仍是整数（不需要 ½ ∈ R）
    assert all(x.denominator == 1 for x in epsp[0])
    check_detG_of_frame(eta, a, b, epsp, "D3 修好的见证")
    assert dot(eta, epsp[0], a) == 0
    check_F8(eta, a, b, epsp, expected=True, label="D3 修好的见证")
    # (Fc)：b̃ = b − a
    bt = sub(b, a)
    assert bt == tuple(map(F, (1, 0, -1))), bt
    assert dot(eta, bt, bt) == 0 and dot(eta, b, bt) == -1
    # §6.0 显式分解系数：e = (e0, e1, −e0)，c1 = −e1、c0 = e1 − e0
    v = sub(a, b)
    for _ in range(200):
        e0 = F(random.randint(-9, 9))
        e1 = F(random.randint(-9, 9))
        e = (e0, e1, -e0)
        assert dot(eta, e, v) == 0
        c1, c0 = -e1, e1 - e0
        assert add(smul(c1, epsp[0]), smul(c0, v)) == e


# ---------------------------------------------------------------- §5 定理 5


def reflection(eta, r):
    """τ_r，返回作用函数。要求 η(r,r) ≠ 0。"""
    nr = dot(eta, r, r)
    assert nr != 0
    return lambda x: sub(x, smul(2 * dot(eta, x, r) / nr, r))


def eichler(eta, b, w):
    """E_{b,w}，要求 η(b,b) = 0、η(b,w) = 0。"""
    assert dot(eta, b, b) == 0 and dot(eta, b, w) == 0
    nw = dot(eta, w, w)

    def E(x):
        A = dot(eta, x, b)
        B = dot(eta, x, w) + nw / 2 * A
        return sub(add(x, smul(A, w)), smul(B, b))

    return E


def compose(*fs):
    def g(x):
        for f in reversed(fs):
            x = f(x)
        return x

    return g


BRANCH = {1: 0, 2: 0, 3: 0}


def map_null_pair(eta, b, ahat, b0, ahat0):
    """命题 5.5 的构造：返回等距 g（函数），g(b) = b0、g(ahat) = ahat0。"""
    # 引理 5.3
    if dot(eta, b, b0) != 0:
        BRANCH[1] += 1
        g1 = reflection(eta, sub(b0, b))
    elif dot(eta, b0, ahat) != 0:
        BRANCH[2] += 1
        c = ahat
        g1 = compose(reflection(eta, sub(b0, c)), reflection(eta, sub(c, b)))
    else:
        BRANCH[3] += 1
        s = dot(eta, b, ahat0)
        q = dot(eta, ahat, ahat0)
        kappa = None
        for cand in (F(1), F(2), F(-1), F(3), F(1, 2)):
            if cand != 0 and 1 + cand * s != 0:
                kappa = cand
                break
        assert kappa is not None
        lam = -kappa * q / (1 + kappa * s)
        c = add(add(ahat, smul(kappa, ahat0)), smul(lam, b))
        assert dot(eta, c, c) == 0
        assert dot(eta, b, c) != 0 and dot(eta, b0, c) != 0
        g1 = compose(reflection(eta, sub(b0, c)), reflection(eta, sub(c, b)))
    assert g1(b) == b0, "引理 5.3 失败"
    # 引理 5.4
    y = g1(ahat)
    assert dot(eta, y, y) == 0 and dot(eta, b0, y) == 1
    d = sub(ahat0, y)
    E = eichler(eta, b0, d)
    g = compose(E, g1)
    assert g(b) == b0 and g(ahat) == ahat0, "引理 5.4 失败"
    return g


def random_isometry(eta, k=3, rng=None):
    """随机等距：k 个随机非迷向向量的反射之积。"""
    rng = rng or random
    D = len(eta)
    fs = []
    while len(fs) < k:
        r = tuple(F(rng.randint(-4, 4)) for _ in range(D))
        if dot(eta, r, r) != 0:
            fs.append(reflection(eta, r))
    return compose(*fs)


def check_theorem5_constructive(trials=40, D=6, seed=20260925):
    """定理 5 (⟸) 的构造在 ℚ 上端到端跑通：随机双曲对 → 标架 → 逐条核验。"""
    rng = random.Random(seed)
    eta = [-1] + [1] * (D - 1)
    f = [basis_vec(D, mu) for mu in range(D)]
    b0 = add(f[0], f[1])
    ahat0 = smul(F(1, 2), sub(f[1], f[0]))
    eps0 = [f[i] for i in range(2, D)]
    assert dot(eta, b0, b0) == 0 and dot(eta, ahat0, ahat0) == 0
    assert dot(eta, b0, ahat0) == 1
    for _ in range(trials):
        h = random_isometry(eta, k=rng.choice([1, 2, 3]), rng=rng)
        b = h(b0)
        ahat = h(ahat0)
        assert dot(eta, b, b) == 0 and dot(eta, ahat, ahat) == 0
        assert dot(eta, b, ahat) == 1
        g = map_null_pair(eta, b, ahat, b0, ahat0)
        # g 的矩阵与逆
        cols = [g(basis_vec(D, mu)) for mu in range(D)]
        M = [[cols[mu][nu] for mu in range(D)] for nu in range(D)]
        assert det(M) in (F(1), F(-1)), det(M)
        eps = []
        for e0 in eps0:
            sol = solve(M, list(e0))
            assert sol is not None
            eps.append(tuple(sol))
        for t in (F(2), F(0), F(-4), F(7, 3)):
            a = add(ahat, smul(t / 2, b))
            assert dot(eta, a, a) == t
            assert dot(eta, b, a) == 1
            check_detG_of_frame(eta, a, b, eps, f"定理5 构造 t={t}")
            for e in eps:
                assert dot(eta, e, a) == 0, "(T′) 应当自动成立"
            check_F8(eta, a, b, eps, expected=(t == 2), label=f"定理5 t={t}")
            if t == 2:
                bt = sub(b, a)
                assert dot(eta, bt, bt) == 0 and dot(eta, b, bt) == -1


# ---------------------------------------------------------------- §5 引理 5.3 情形 3


def check_lemma53_case3():
    """引理 5.3 的情形 3（η(b,b′) = η(b′,â) = 0）在 mostly-plus 的 ℚ 空间里**不可达**，
    必须换一个横向部分迷向的空间才能真正测到——这里用 η = ⟨−1,−1,1,1⟩。

    不可达性的理由（也写在 proof.md §5 注里）：η = ⟨−1,1,…,1⟩、K = ℚ 时
    η(b,b₀) = 0 与 η(b,b) = 0 联立迫使 b 的横向分量平方和为 0，横向部分正定
    ⟹ 横向分量全零 ⟹ b ∥ b₀，于是 η(b₀,â) = 1/λ ≠ 0，落进情形 2。
    情形 3 只在 Witt 指数 ≥ 2 时出现；命题 5.5 对任意非退化型都成立，故此测试合法。
    """
    eta = [-1, -1, 1, 1]
    b0 = tuple(map(F, (1, 0, 1, 0)))
    ahat0 = (F(-1, 2), F(0), F(1, 2), F(0))
    b = tuple(map(F, (0, 1, 0, 1)))
    ahat = (F(0), F(-1, 2), F(0), F(1, 2))
    for x in (b, ahat, b0, ahat0):
        assert dot(eta, x, x) == 0
    assert dot(eta, b, ahat) == 1 and dot(eta, b0, ahat0) == 1
    # 情形 3 的判据
    assert dot(eta, b, b0) == 0 and dot(eta, b0, ahat) == 0
    before = BRANCH[3]
    g = map_null_pair(eta, b, ahat, b0, ahat0)
    assert BRANCH[3] == before + 1, "没走到情形 3"
    assert g(b) == b0 and g(ahat) == ahat0
    # g 确实是等距（在一组基上验证 Gram 不变）
    D = len(eta)
    cols = [g(basis_vec(D, mu)) for mu in range(D)]
    for mu in range(D):
        for nu in range(D):
            want = F(eta[mu]) if mu == nu else F(0)
            assert dot(eta, cols[mu], cols[nu]) == want, (mu, nu)


# ---------------------------------------------------------------- §6.1 球面环


def check_sphere_ring(samples=2000, seed=7):
    """定理 6 第一、二步的恒等式（在 S² 上随机取点做浮点核验）。

    R = ℝ[x,y,z]/(x²+y²+z²−1) 的元素在每个实点上求值；断言是多项式恒等式，
    浮点抽样只作为算错的哨兵（真正的证明在 proof.md §6.1）。
    """
    rng = random.Random(seed)
    tol = 1e-10
    for _ in range(samples):
        while True:
            v = [rng.gauss(0, 1) for _ in range(3)]
            n = math.sqrt(sum(c * c for c in v))
            if n > 1e-6:
                break
        x, y, z = (c / n for c in v)
        eta = [-1.0, 1.0, 1.0, 1.0]
        b = (1.0, x, y, z)
        a = (0.5, 1.5 * x, 1.5 * y, 1.5 * z)
        bt = tuple(bi - ai for bi, ai in zip(b, a))
        d = lambda p, q: sum(e * p_ * q_ for e, p_, q_ in zip(eta, p, q))
        assert abs(d(b, b)) < tol
        assert abs(d(b, a) - 1) < tol
        assert abs(d(a, a) - 2) < tol
        assert abs(d(bt, bt)) < tol
        assert abs(d(b, bt) + 1) < tol
        # W 的刻画：η(w,b) = −w0 + u·w⃗，η(w,a) = ½(−w0 + 3u·w⃗)
        w = [rng.gauss(0, 1) for _ in range(4)]
        u = (x, y, z)
        uw = sum(ui * wi for ui, wi in zip(u, w[1:]))
        assert abs(d(w, b) - (-w[0] + uw)) < tol
        assert abs(d(w, a) - 0.5 * (-w[0] + 3 * uw)) < tol
        # w ∈ W ⟹ w0 = 0 且 u·w⃗ = 0
        # 造一个 W 中元素：w⃗ := (任意) − (u·任意)u，w0 := 0
        r = [rng.gauss(0, 1) for _ in range(3)]
        ur = sum(ui * ri for ui, ri in zip(u, r))
        wv = [ri - ur * ui for ri, ui in zip(r, u)]
        ww = (0.0, *wv)
        assert abs(d(ww, b)) < tol and abs(d(ww, a)) < tol
        # η|_W 就是标准点积
        assert abs(d(ww, ww) - sum(c * c for c in wv)) < tol


# ---------------------------------------------------------------- §1.1 注


def check_normalisation_c():
    """§1.1：η(b,a) = c 时 det G = −c²；c = 2 在 ℤ 上给出非基的例子。"""
    D = 4
    eta = [-1, 1, 1, 1]
    # b 类光，η(b,a) = 2：取 b = (1,1,0,0)，a = (0,2,0,0)+… 使 η(b,a) = 2
    b = tuple(map(F, (1, 1, 0, 0)))
    a = tuple(map(F, (0, 2, 1, 0)))
    assert dot(eta, b, b) == 0 and dot(eta, b, a) == 2
    eps = [basis_vec(D, 3)]
    # 造第二个横向向量使 m = D − 2 = 2
    e2 = tuple(map(F, (0, 0, 1, 0)))
    eps = [e2, basis_vec(D, 3)]
    for e in eps:
        assert dot(eta, e, b) == 0
    G = gram(eta, [a, b] + eps)
    assert det(G) == -4, det(G)
    B = [[v[mu] for v in [a, b] + eps] for mu in range(D)]
    assert det(B) in (F(2), F(-2)), det(B)  # 不是 ℤ 的单位 ⟹ 不张成 ℤ^D


# ---------------------------------------------------------------- 主程序


def main():
    check_D6_shift()
    print("[ok] §2 注 2.3   D = 6 标架与零向平移")
    check_D3_integer_witness()
    print("[ok] §1.2/§6.0  D = 3 整数见证：原版违反 (T′)(F8)，平移后是完整标架")
    check_normalisation_c()
    print("[ok] §1.1 注     η(b,a) = 2 ⟹ det G = −4、det B = ±2（ℤ 上不是基）")
    check_theorem5_constructive()
    print("[ok] §5 定理 5   反射 + Eichler 构造（D = 6，40 组随机双曲对）")
    print("                 顺带核验定理 1 (det G = −1)、定理 3 ((F8) ⟺ t = 2)")
    print(f"                 引理 5.3 分支命中：情形1={BRANCH[1]} 情形2={BRANCH[2]} 情形3={BRANCH[3]}")
    assert BRANCH[1] > 0 and BRANCH[2] > 0, BRANCH
    check_lemma53_case3()
    print("[ok] §5 引理 5.3 情形 3 在 η = ⟨−1,−1,1,1⟩ 上单独命中并核验为等距")
    check_sphere_ring()
    print("[ok] §6.1 定理 6 球面环上的 (F1)–(F4)、快子壳与 W 的刻画（2000 个随机点）")
    print("ALL CHECKS PASSED")


if __name__ == "__main__":
    main()
