#!/usr/bin/env python3
"""Check the exact algebraic form of the level-six counting identity that will be
typed into Lean (`levelSix_count_identity_gen`), matching the `LevelFiveCount.lean`
style term-by-term (natural-subtraction-free, `m`-indexed).

Claim:
    p_{m+1}(6) + (m+1) = p_m(6) + p_{m+1}(5) + p_{m+1}(4)

with the eleven-term form of p_m(6) from `verify_level_six_count.py`, and the
seven-term / five-term forms of p_m(5), p_m(4) exactly as they appear in
`LevelFiveCount.lean` / `LevelFourCount.lean`:

    p_m(5) = m + 2m^2 + 2m*C(m+1,2) + m*C(m+2,3) + C(m+4,5)
    p_m(4) = m + m^2 + C(m+1,2) + m*C(m+1,2) + C(m+3,4)
"""
from math import comb as C


def p6(m):
    return (
        m + m * m + m * m + m * C(m + 1, 2) + C(m + 1, 2) + m * m * m
        + m * C(m + 2, 3) + C(m + 2, 3) + C(m + 1, 2) * C(m + 1, 2)
        + m * C(m + 3, 4) + C(m + 5, 6)
    )


def p5(m):
    return m + 2 * m * m + 2 * m * C(m + 1, 2) + m * C(m + 2, 3) + C(m + 4, 5)


def p4(m):
    return m + m * m + C(m + 1, 2) + m * C(m + 1, 2) + C(m + 3, 4)


def main():
    ok = True
    for m in range(0, 15):
        lhs = p6(m + 1) + (m + 1)
        rhs = p6(m) + p5(m + 1) + p4(m + 1)
        status = "OK" if lhs == rhs else "MISMATCH"
        if lhs != rhs:
            ok = False
        print(f"m={m:3d}  lhs={lhs:8d}  rhs={rhs:8d}  {status}")
    assert ok
    print("all OK")


if __name__ == "__main__":
    main()
