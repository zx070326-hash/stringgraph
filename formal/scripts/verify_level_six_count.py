#!/usr/bin/env python3
"""Numerical verification for deliverable (b) of the N=6 counting layer.

Verifies, by exact integer arithmetic (no floats), the level-6 occupation-count
formula `p_m(6)` (grouped by the eleven partition shapes of 6) against the
"count distinct-multiset-per-part-value" formula used throughout
`formal/StringFormal/NoGhost/Level*Count.lean`, and then checks the target
counting identity

    p_{D-1}(5) + p_{D-1}(4) - (D-1) = p_{D-1}(6) - p_{D-2}(6)

for a range of `D`, plus the `kappa_6 = p_D(1) = D` claim from blueprint
§B⁗.7/§B⁗.9.
"""
from math import comb
from collections import Counter


def partitions(n, minpart=1):
    if n == 0:
        yield ()
        return
    for i in range(minpart, n + 1):
        for tail in partitions(n - i, i):
            yield (i,) + tail


def p(m, N):
    """dim V_{j,N} on `m` transverse directions, by summing over partitions of N
    the product over distinct part-values v (with multiplicity mu_v) of
    C(m + mu_v - 1, mu_v)."""
    total = 0
    for part in partitions(N):
        cnt = Counter(part)
        prod = 1
        for v, mult in cnt.items():
            prod *= comb(m + mult - 1, mult)
        total += prod
    return total


def p6_formula(m):
    """The closed form claimed for the Lean file, grouped exactly as the eleven
    shapes 6 / 5+1 / 4+2 / 4+1+1 / 3+3 / 3+2+1 / 3+1^3 / 2^3 / 2^2+1^2 / 2+1^4 / 1^6."""
    C = comb
    return (
        m                                      # [6]
        + m * m                                # [5,1]
        + m * m                                # [4,2]
        + m * C(m + 1, 2)                      # [4,1,1]
        + C(m + 1, 2)                          # [3,3]
        + m * m * m                            # [3,2,1]
        + m * C(m + 2, 3)                      # [3,1,1,1]
        + C(m + 2, 3)                          # [2,2,2]
        + C(m + 1, 2) * C(m + 1, 2)            # [2,2,1,1]
        + m * C(m + 3, 4)                      # [2,1,1,1,1]
        + C(m + 5, 6)                          # [1^6]
    )


def main():
    print("=== p6_formula vs partition-sum p(.,6), m = 0..12 ===")
    ok = True
    for m in range(0, 13):
        a, b = p(m, 6), p6_formula(m)
        status = "OK" if a == b else "MISMATCH"
        if a != b:
            ok = False
        print(f"  m={m:3d}  partition-sum={a:8d}  closed-form={b:8d}  {status}")
    assert ok, "p6_formula does not match the partition-sum definition!"

    print("\n=== target identity: p_{D-1}(5)+p_{D-1}(4)-(D-1) = p_{D-1}(6)-p_{D-2}(6) ===")
    ok2 = True
    for D in range(2, 30):
        m1, m2 = D - 1, D - 2
        lhs = p(m1, 5) + p(m1, 4) - m1
        rhs = p(m1, 6) - p(m2, 6)
        status = "OK" if lhs == rhs else "MISMATCH"
        if lhs != rhs:
            ok2 = False
        print(f"  D={D:3d}  lhs={lhs:10d}  rhs={rhs:10d}  {status}")
    assert ok2, "target counting identity fails!"

    print("\n=== kappa_6 = p_D(5)+p_D(4)+p_{D-1}(6)-p_D(6) =?= D ===")
    ok3 = True
    for D in range(1, 30):
        kappa6 = p(D, 5) + p(D, 4) + p(D - 1, 6) - p(D, 6)
        status = "OK" if kappa6 == D else f"MISMATCH (got {kappa6})"
        if kappa6 != D:
            ok3 = False
        print(f"  D={D:3d}  kappa_6={kappa6:6d}  target D={D:3d}  {status}")
    assert ok3, "kappa_6 = D identity fails!"

    print("\nAll checks passed.")


if __name__ == "__main__":
    main()
