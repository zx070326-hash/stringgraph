#!/usr/bin/env python3
"""BLUEPRINT-noghost §B⁗.9 的 `N = 6` 种子判据：Fock 模上的精确判定。

问题（rung `j = -6`，level 1）：
    u = c_μ α^μ_{-1}|0;p_{-6}⟩,   求 {c : x₄u ∈ Q_{-6,5} 且 y₃u ∈ Q_{-6,4}},
其中 `Q_{j,N}` 是被所有 `L_m (m ≥ 1)` 零化的子空间（种子空间），
`x₄`、`y₃` 是 §B⁗.2 的 syzygy 对。目标是这个解空间**恰好**等于
`Q_{-6,1} = {c : c · p_{-6} = 0}`（维数 `D - 1`）。

约定：`α' = 1/2`（即 `α_0^μ = p^μ`），`η = diag(-1, +1, …, +1)`，
`a·a = 2, a·b = 1, b·b = 0`，`p_j = a + j b`，故 `p_j² = 2(j+1)`，
`L_0|_{V_{j,N}} = ½p_j² + N = (j+1) + N`。在 `j = -6` 上层真空 `h = -5`，
level-1 态 `h = -4`——正是 §B⁗.2 里两个奇异矢量所在的 `V(26, -4)`。

全部用 `Fraction` 精确算，不涉及浮点。

结果（见文件末注释）：
    D = 26 :  rank = 1,  nullspace = 25 = D - 1，且那条唯一约束正比于 c·p。
    D ≠ 26 :  rank = D,  nullspace = 0。
即判据在**且仅在** D = 26 时是紧的。
"""

from collections import defaultdict
from fractions import Fraction as F
import sys


def build(D):
    eta = [F(-1)] + [F(1)] * (D - 1)
    a = [F(0)] * D
    a[1] = F(1)
    a[2] = F(1)
    b = [F(0)] * D
    b[0] = F(1)
    b[1] = F(1)
    p = [a[i] - 6 * b[i] for i in range(D)]
    assert sum(eta[i] * p[i] * p[i] for i in range(D)) == -10, "p_{-6}² must be -10"
    return eta, p


# Fock 态：{ 排序后的 (n, μ) 多重集 : 系数 }
def make_ops(D, eta, p):
    def creat(mu, n, st):
        out = defaultdict(F)
        for w, c in st.items():
            out[tuple(sorted(w + ((n, mu),)))] += c
        return out

    def annih(mu, n, st):  # n >= 1
        out = defaultdict(F)
        for w, c in st.items():
            k = w.count((n, mu))
            if k:
                w2 = list(w)
                w2.remove((n, mu))
                out[tuple(w2)] += c * k * n * eta[mu]
        return out

    def alpha(mu, k, st):
        if k < 0:
            return creat(mu, -k, st)
        if k == 0:
            return {w: c * p[mu] for w, c in st.items()}
        return annih(mu, k, st)

    def dot(k1, k2, st):  # α_{k1} · α_{k2}，先作用 k2
        out = defaultdict(F)
        for mu in range(D):
            for w, c in alpha(mu, k1, alpha(mu, k2, st)).items():
                out[w] += eta[mu] * c
        return {w: c for w, c in out.items() if c != 0}

    return creat, dot


def addd(*xs):
    r = defaultdict(F)
    for x in xs:
        for w, c in x.items():
            r[w] += c
    return {w: c for w, c in r.items() if c != 0}


def scale(k, x):
    return {w: F(k) * c for w, c in x.items() if F(k) * c != 0}


def lvl(st):
    return max((sum(n for n, _ in w) for w in st), default=0)


def make_L(dot):
    """L_m = ½ Σ_{j=0}^{m} α_{m-j}·α_j + Σ_{k≥1} α_{-k}·α_{m+k}  (m > 0)，
    负模对称；正规序已在指标范围里体现。"""

    def L(m, st):
        if not st:
            return {}
        t = []
        if m > 0:
            for j in range(0, m + 1):
                t.append(scale(F(1, 2), dot(m - j, j, st)))
            for k in range(1, lvl(st) + 1):
                t.append(dot(-k, m + k, st))
        elif m == 0:
            t.append(scale(F(1, 2), dot(0, 0, st)))
            for k in range(1, lvl(st) + 1):
                t.append(dot(-k, k, st))
        else:
            M = -m
            for j in range(0, M + 1):
                t.append(scale(F(1, 2), dot(-M + j, -j, st)))
            for k in range(1, lvl(st) + 1):
                t.append(dot(-M - k, k, st))
        return addd(*t)

    return L


def rank_exact(rows, D):
    M = [r for r in rows if any(r)]
    r = 0
    piv = []
    for col in range(D):
        pr = next((i for i in range(r, len(M)) if M[i][col] != 0), None)
        if pr is None:
            continue
        M[r], M[pr] = M[pr], M[r]
        pv = M[r][col]
        for i in range(len(M)):
            if i != r and M[i][col] != 0:
                f = M[i][col] / pv
                M[i] = [M[i][j] - f * M[r][j] for j in range(D)]
        piv.append(col)
        r += 1
    return r, piv, M


def run(D):
    eta, p = build(D)
    creat, dot = make_ops(D, eta, p)
    L = make_L(dot)

    def opw(ns, st):  # 算符序「大下标在左」：最右先作用
        e = st
        for n in reversed(ns):
            e = L(-n, e)
        return e

    y3 = lambda s: addd(scale(12, opw([3], s)), scale(6, opw([2, 1], s)), opw([1, 1, 1], s))  # noqa: E731
    x4 = lambda s: addd(  # noqa: E731
        scale(-76, opw([4], s)), scale(-52, opw([3, 1], s)), scale(-12, opw([2, 2], s)),
        scale(-20, opw([2, 1, 1], s)), scale(-3, opw([1, 1, 1, 1], s)))

    vac = {(): F(1)}
    rows = defaultdict(lambda: [F(0)] * D)
    for mu in range(D):
        um = creat(mu, 1, vac)
        Ym, Xm = y3(um), x4(um)
        for m in (1, 2, 3, 4):
            for w, cc in L(m, Ym).items():
                rows[('y', m, w)][mu] += cc
        for m in (1, 2, 3, 4, 5):
            for w, cc in L(m, Xm).items():
                rows[('x', m, w)][mu] += cc

    r, piv, M = rank_exact(list(rows.values()), D)
    null = D - r
    print(f"D = {D:3d} :  rows = {len(rows):5d}  rank = {r:3d}  nullspace = {null:3d}"
          f"   (dim Q_-6,1 = {D - 1})   {'SHARP' if null == D - 1 else 'not sharp'}")
    if r == 1:
        g = [x / M[0][piv[0]] for x in M[0]]
        pn = [x / p[piv[0]] for x in p]
        print(f"          唯一约束 ∝ c·p ? {g == pn}")
    return null == D - 1


if __name__ == "__main__":
    ds = [int(x) for x in sys.argv[1:]] or [3, 4, 10, 25, 26, 27]
    ok = [d for d in ds if run(d)]
    print("\nsharp exactly at D =", ok)
