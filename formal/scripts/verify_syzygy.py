#!/usr/bin/env python3
"""BLUEPRINT-noghost §B⁗.2 的 syzygy 恒等式独立复核。

验证 `L_{-1} x₄ + 𝒟₂ y₃ = 0` 在 U(Vir⁻) 中逐项为零，其中
    𝒟₂ = 2 L_{-2} + 3 L_{-1}²
    y₃ = 12 L_{-3} + 6 L_{-2}L_{-1} + L_{-1}³
    x₄ = -76 L_{-4} - 52 L_{-3}L_{-1} - 12 L_{-2}² - 20 L_{-2}L_{-1}² - 3 L_{-1}⁴

实现要点：这是从零写的 PBW 正规序，与 §B⁗.2 所用脚本互相独立。
词用正整数元组 `(n1 <= n2 <= ...)` 表示 `L_{-n1} L_{-n2} ...`（有序基「小下标在左」）。
全部下标为负，`[L_a, L_b] = (a-b) L_{a+b}` 不含中心项，故与 c、h 无关。

本脚本同时是 `verify_n6_numerical.py` 的回归测试基准：任何 Virasoro 作用的实现
都必须在这条恒等式上给出精确零。
"""

from collections import defaultdict
from fractions import Fraction as F


def _push(m, w):
    """正规序 L_{-m} * (word w)，返回 {word: coeff}。"""
    if not w or m <= w[0]:
        return {(m,) + w: F(1)}
    n1, rest = w[0], w[1:]
    res = defaultdict(F)
    # L_{-m} L_{-n1} = L_{-n1} L_{-m} + (n1 - m) L_{-(m+n1)}
    for w2, c2 in _push(m, rest).items():
        for w3, c3 in _push(n1, w2).items():
            res[w3] += c2 * c3
    for w2, c2 in _push(m + n1, rest).items():
        res[w2] += F(n1 - m) * c2
    return {w: c for w, c in res.items() if c != 0}


def mul(a, b):
    """两个元素相乘，元素表示为 {word: coeff}。"""
    res = defaultdict(F)
    for wa, ca in a.items():
        for wb, cb in b.items():
            cur = {wb: F(1)}
            for m in reversed(wa):
                nxt = defaultdict(F)
                for w, c in cur.items():
                    for w2, c2 in _push(m, w).items():
                        nxt[w2] += c * c2
                cur = nxt
            for w, c in cur.items():
                res[w] += ca * cb * c
    return {w: c for w, c in res.items() if c != 0}


def add(*xs):
    res = defaultdict(F)
    for x in xs:
        for w, c in x.items():
            res[w] += c
    return {w: c for w, c in res.items() if c != 0}


def scale(k, x):
    return {w: F(k) * c for w, c in x.items() if F(k) * c != 0}


L = lambda n: {(n,): F(1)}  # noqa: E731  -- L_{-n}


def main() -> int:
    L1, L2, L3, L4 = L(1), L(2), L(3), L(4)

    y3 = add(scale(12, L3), scale(6, mul(L2, L1)), mul(L1, mul(L1, L1)))
    x4 = add(
        scale(-76, L4),
        scale(-52, mul(L3, L1)),
        scale(-12, mul(L2, L2)),
        scale(-20, mul(L2, mul(L1, L1))),
        scale(-3, mul(L1, mul(L1, mul(L1, L1)))),
    )
    D2 = add(scale(2, L2), scale(3, mul(L1, L1)))

    lhs = add(mul(L1, x4), mul(D2, y3))

    print("y3 =", dict(sorted(y3.items())))
    print("x4 =", dict(sorted(x4.items())))
    print("L_-1 x4 + D2 y3 =", dict(sorted(lhs.items())))
    ok = not lhs
    print("ZERO?", ok)
    return 0 if ok else 1


if __name__ == "__main__":
    raise SystemExit(main())
