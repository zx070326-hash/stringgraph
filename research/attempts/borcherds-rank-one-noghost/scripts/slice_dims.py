"""机器核验 scoping.md §5.4 的反例（以及 §5.4 末尾关于前件 (C) 的推论）。

核验的对象是**一片**：动量塔 T(a;b) = ⊕_j F(a+jb) 的双分次片 (rung, level) = (−1, 1)。
在这一片上三个子空间都是有限维的、可以显式写成矩阵，故本脚本是**精确有理数**计算，
不是数值估计。

记号（逐字沿用 graph/statements/worldsheet/ddf-spanning-hypothesis.yaml 的【设定】）：
  η = diag(−1, +1, …, +1)          （conv.metric-mostly-plus）
  η(b,b) = 0                        (N)
  η(a,b) = 1                        (S)
  a₀ := ½η(a,a)
  H_phys := {Ψ : (L₀ − a₀)Ψ = 0, L_mΨ = 0 ∀m ≥ 1}
  D(Ε)   := span{A^{ε_{i1}}_{−n1}⋯|0;a⟩}
  H_null := H_phys ∩ H_phys^⊥

在片 (−1,1) 上（记 v := a − b 为该层动量）：
  · 质量壳 L₀ = a₀ 在该片上等价于 j + N = 0，自动满足（L₀ = a₀ + j + N）；
  · 态 = ζ·α_{−1}|v⟩，ζ ∈ R^D；
  · L₁(ζ·α_{−1}|v⟩) = η(ζ, v)|v⟩，L_{m≥2} 自动为零  ⟹  H_phys∩片 ≅ v^⊥；
  · 形式 ⟨ζ·α_{−1}|v⟩, ζ′·α_{−1}|v⟩⟩ = η(ζ, ζ′)  ⟹  H_null∩片 ≅ rad(η|_{v^⊥}) = v^⊥ ∩ Rv；
  · A^{ε}_{−1}|0;a⟩ = (ε·α_{−1} + η(ε, ·)·(0 阶项))|v⟩；在本脚本取的标架上 η(ε_i, a) = 0
    与 η(ε_i, b) = 0（前件 (T)、(T′)），故 0 阶项消失，DDF 态恰是 ε_i·α_{−1}|v⟩
    ⟹ D(Ε)∩片 ≅ span(Ε)。
  （rung −1 里的 DDF 单项式只有 Σn_j = 1 一种，即单个 A^ε_{−1}，故上面是等号不是包含。）

于是整片的比较退化为 R^D 里三个子空间的维数比较，脚本逐例核验之。

运行：
  cd "D:/physics/string"
  uv run python research/attempts/borcherds-rank-one-noghost/scripts/slice_dims.py
（只用标准库 fractions，无第三方依赖。）
"""

from fractions import Fraction as F
from itertools import product


# ---------- 基础线性代数（精确有理数） ----------

def eta_ip(x, y):
    """η = diag(−1, +1, …, +1)。"""
    return -x[0] * y[0] + sum(xi * yi for xi, yi in zip(x[1:], y[1:]))


def rank(rows):
    """有理数矩阵的秩（高斯消元）。rows 是 list of list of Fraction。"""
    rows = [list(r) for r in rows]
    if not rows:
        return 0
    ncols = len(rows[0])
    r = 0
    for c in range(ncols):
        piv = None
        for i in range(r, len(rows)):
            if rows[i][c] != 0:
                piv = i
                break
        if piv is None:
            continue
        rows[r], rows[piv] = rows[piv], rows[r]
        pr = rows[r]
        for i in range(len(rows)):
            if i != r and rows[i][c] != 0:
                f = rows[i][c] / pr[c]
                rows[i] = [a - f * bb for a, bb in zip(rows[i], pr)]
        r += 1
        if r == len(rows):
            break
    return r


def nullspace_basis(rows, ncols):
    """解 rows·x = 0 的一组基（精确有理数）。"""
    M = [list(r) for r in rows]
    piv_cols = []
    r = 0
    for c in range(ncols):
        piv = None
        for i in range(r, len(M)):
            if M[i][c] != 0:
                piv = i
                break
        if piv is None:
            continue
        M[r], M[piv] = M[piv], M[r]
        pr = M[r]
        inv = F(1) / pr[c]
        M[r] = [a * inv for a in pr]
        pr = M[r]
        for i in range(len(M)):
            if i != r and M[i][c] != 0:
                f = M[i][c]
                M[i] = [a - f * bb for a, bb in zip(M[i], pr)]
        piv_cols.append(c)
        r += 1
        if r == len(M):
            break
    free_cols = [c for c in range(ncols) if c not in piv_cols]
    basis = []
    for fc in free_cols:
        vec = [F(0)] * ncols
        vec[fc] = F(1)
        for i, pc in enumerate(piv_cols):
            vec[pc] = -M[i][fc]
        basis.append(vec)
    return basis


# ---------- 片上的三个子空间 ----------

def slice_dims(D, a, b, frame):
    """返回 (dim H_phys∩片, dim D(Ε)∩片, dim H_null∩片, a0, eta(v,v))。"""
    v = [ai - bi for ai, bi in zip(a, b)]
    a0 = F(1, 2) * eta_ip(a, a)

    # H_phys ∩ 片 = v^⊥ = ker(ζ ↦ η(ζ,v))
    row = [(-v[0] if mu == 0 else v[mu]) for mu in range(D)]  # η(ζ,v) 的系数行
    vperp = nullspace_basis([row], D)
    dim_phys = len(vperp)

    # D(Ε) ∩ 片 = span(Ε)
    dim_ddf = rank(frame) if frame else 0

    # H_null ∩ 片 = rad(η|_{v^⊥})
    # ζ ∈ v^⊥ 且 η(ζ, ζ′) = 0 ∀ζ′ ∈ v^⊥
    if dim_phys == 0:
        dim_null = 0
    else:
        gram = [[eta_ip(x, y) for y in vperp] for x in vperp]
        dim_null = dim_phys - rank(gram)

    return dim_phys, dim_ddf, dim_null, a0, eta_ip(v, v)


def check(name, D, a, b, frame, expect_spans):
    a = [F(x) for x in a]
    b = [F(x) for x in b]
    frame = [[F(x) for x in e] for e in frame]

    # 前件核验
    assert eta_ip(b, b) == 0, f"{name}: (N) 失败"
    assert eta_ip(a, b) == 1, f"{name}: (S) 失败"
    for i, e in enumerate(frame):
        assert eta_ip(e, b) == 0, f"{name}: (T) 在 ε_{i} 上失败"
        assert eta_ip(e, a) == 0, f"{name}: (T′) 在 ε_{i} 上失败"
    for i, e in enumerate(frame):
        for j, f in enumerate(frame):
            assert eta_ip(e, f) == (1 if i == j else 0), f"{name}: (O) 在 ({i},{j}) 上失败"
    assert len(frame) == D - 2, f"{name}: 标架个数不是 D−2"

    dp, dd, dn, a0, vv = slice_dims(D, a, b, frame)
    spans = dp <= dd + dn
    ok = "OK " if spans == expect_spans else "!! "
    print(f"{ok}{name}")
    print(f"      D = {D}   a₀ = {a0}   η(v,v) = {vv}  (= 2(a₀−1) ⟹ {2*(a0-1)})")
    print(f"      dim(H_phys∩片) = {dp}   dim(D(Ε)∩片) = {dd}   dim(H_null∩片) = {dn}")
    print(f"      H_phys ⊆ D(Ε)+H_null 在本片上：{'成立' if spans else '**不成立**'}"
          f"   ({dp} {'≤' if spans else '>'} {dd}+{dn})")
    assert spans == expect_spans, f"{name}: 与预期不符"
    return dp, dd, dn


def make_frame(D):
    """ε_i = 第 (i+2) 个坐标向量，i = 0..D−3。与只支撑在坐标 0,1 上的 a,b 自动横向。"""
    out = []
    for i in range(D - 2):
        e = [0] * D
        e[i + 2] = 1
        out.append(e)
    return out


if __name__ == "__main__":
    print("=" * 78)
    print("scoping.md §5.4：a₀ ≠ 1 时 worldsheet.ddf-spanning-hypothesis 在片 (−1,1) 上为假")
    print("=" * 78)

    # ---- 反例族：a = (n−1/2, n+1/2, 0, …)，b = (1,1,0,…) ----
    # η(b,b) = 0；η(a,b) = −(n−1/2) + (n+1/2) = 1；η(a,a) = −(n−1/2)² + (n+1/2)² = 2n
    # ⟹ a₀ = n。n = 1 给 a₀ = 1（项目的见证），n ≥ 2 给反例。
    print()
    for D in (3, 4, 26):
        for n in (1, 2, 3):
            a = [F(2 * n - 1, 2), F(2 * n + 1, 2)] + [0] * (D - 2)
            b = [1, 1] + [0] * (D - 2)
            check(f"D = {D}, a₀ = {n}", D, a, b, make_frame(D),
                  expect_spans=(n == 1))
            print()

    # ---- 任务书 §5.4 里写出的那一组具体数 ----
    print("-" * 78)
    print("scoping.md §5.4 逐字写出的反例（D = 3）：a = (3/2, 5/2, 0)，b = (1, 1, 0)")
    check("§5.4 逐字", 3, [F(3, 2), F(5, 2), 0], [1, 1, 0], make_frame(3),
          expect_spans=False)
    print()

    print("-" * 78)
    print("scoping.md §5.4 末：前件 (C)「Ε 在 v^⊥ 上完备」蕴含 a₀ = 1")
    print("  (C) 逐字（transverse-frame-spans-orthogonal-complement）：")
    print("      η(e, v) = 0  ⟹  e = Σ c_i ε_i + c₀ v")
    print("  在 (T)(T′) 下 span(Ε) ⊆ v^⊥，故 (C) ⟺ v^⊥ = span(Ε) + (Rv ∩ v^⊥)。")
    print("  逐例核验 dim v^⊥ 与 dim(span(Ε) + (Rv ∩ v^⊥))：")
    print()
    for D in (3, 4, 26):
        for n in (1, 2):
            a = [F(2 * n - 1, 2), F(2 * n + 1, 2)] + [F(0)] * (D - 2)
            b = [F(1), F(1)] + [F(0)] * (D - 2)
            v = [ai - bi for ai, bi in zip(a, b)]
            frame = [[F(x) for x in e] for e in make_frame(D)]
            row = [(-v[0] if mu == 0 else v[mu]) for mu in range(D)]
            vperp = nullspace_basis([row], D)
            gens = list(frame)
            if eta_ip(v, v) == 0:          # v ∈ v^⊥ 才计入
                gens = gens + [v]
            lhs, rhs = len(vperp), rank(gens)
            status = "(C) 可能成立" if lhs == rhs else "(C) **不可能成立**"
            print(f"  D = {D}, a₀ = {n}:  dim v^⊥ = {lhs}, "
                  f"dim(span(Ε)+(Rv∩v^⊥)) = {rhs}   ⟹ {status}")
            assert (lhs == rhs) == (n == 1)
        print()

    print("=" * 78)
    print("全部断言通过。")
    print("=" * 78)
