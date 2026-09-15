"""Literal, term-by-term transcription check of the three theorem statements in
`formal/StringFormal/NoGhost/LevelSevenCount.lean` (NOT a re-derivation from the closed
forms in proof.md -- this script mirrors the exact Lean source text, so it catches
transcription slips of the kind that (once) broke `LevelSixCount.lean`).

Caught and fixed one such slip while writing this file: `levelSeven_count_identity_gen`'s
p_{m+1}(5) summand originally had `Nat.choose (m + 3) 5` where it should be
`Nat.choose (m + 5) 5` (since p_{m+1}(5)'s last term, from p_m(5)'s `C(m+4,5)` with
m -> m+1, is `C(m+5,5)`, matching the existing, already-compiling
`levelFive_count_identity_gen`'s pattern `Nat.choose (m + 5) 5`). Fixed before commit;
this script's `lhs_gen`/`rhs_gen` now transcribe the corrected file and confirm equality.

Run: `python check_lean_skeleton_literal.py`. All three blocks below print `True` for
every tested value (gen: m=0..9; identity: D=2..11; full: D=1..11).
"""
from math import comb as C


def lhs_gen(m):
    return (((m + 1) + 3 * ((m + 1) * (m + 1)) + 3 * ((m + 1) * C(m + 2, 2))
        + (m + 1) * (m + 1) * (m + 1) + 2 * ((m + 1) * C(m + 3, 3))
        + (m + 1) * (m + 1) * C(m + 2, 2) + (m + 1) * C(m + 4, 4)
        + C(m + 2, 2) * C(m + 3, 3)
        + (m + 1) * C(m + 5, 5) + C(m + 7, 7))
      + C(m + 3, 2))


def rhs_gen(m):
    p7 = (m + 3 * (m * m) + 3 * (m * C(m + 1, 2)) + m * m * m
        + 2 * (m * C(m + 2, 3)) + m * m * C(m + 1, 2)
        + m * C(m + 3, 4) + C(m + 1, 2) * C(m + 2, 3)
        + m * C(m + 4, 5) + C(m + 6, 7))
    p6 = ((m + 1) + 2 * ((m + 1) * (m + 1)) + (m + 1) * C(m + 2, 2)
          + C(m + 2, 2) + (m + 1) * (m + 1) * (m + 1)
          + (m + 1) * C(m + 3, 3) + C(m + 3, 3)
          + C(m + 2, 2) * C(m + 2, 2)
          + (m + 1) * C(m + 4, 4) + C(m + 6, 6))
    p5 = ((m + 1) + 2 * ((m + 1) * (m + 1)) + 2 * ((m + 1) * C(m + 2, 2))
          + (m + 1) * C(m + 3, 3) + C(m + 5, 5))
    return p7 + p6 + p5


def lhs_identity(D):
    return ((((D - 1) + 3 * ((D - 1) * (D - 1)) + 3 * ((D - 1) * C(D, 2))
        + (D - 1) * (D - 1) * (D - 1) + 2 * ((D - 1) * C(D + 1, 3))
        + (D - 1) * (D - 1) * C(D, 2) + (D - 1) * C(D + 2, 4)
        + C(D, 2) * C(D + 1, 3)
        + (D - 1) * C(D + 3, 5) + C(D + 5, 7))
      + C(D + 1, 2)))


def rhs_identity(D):
    p7 = ((D - 2) + 3 * ((D - 2) * (D - 2)) + 3 * ((D - 2) * C(D - 1, 2))
        + (D - 2) * (D - 2) * (D - 2) + 2 * ((D - 2) * C(D, 3))
        + (D - 2) * (D - 2) * C(D - 1, 2)
        + (D - 2) * C(D + 1, 4) + C(D - 1, 2) * C(D, 3)
        + (D - 2) * C(D + 2, 5) + C(D + 4, 7))
    p6 = ((D - 1) + 2 * ((D - 1) * (D - 1)) + (D - 1) * C(D, 2)
          + C(D, 2) + (D - 1) * (D - 1) * (D - 1)
          + (D - 1) * C(D + 1, 3) + C(D + 1, 3)
          + C(D, 2) * C(D, 2)
          + (D - 1) * C(D + 2, 4) + C(D + 4, 6))
    p5 = ((D - 1) + 2 * ((D - 1) * (D - 1)) + 2 * ((D - 1) * C(D, 2))
          + (D - 1) * C(D + 1, 3) + C(D + 3, 5))
    return p7 + p6 + p5


def lhs_full(D):
    return ((D + 3 * (D * D) + 3 * (D * C(D + 1, 2)) + D * D * D
        + 2 * (D * C(D + 2, 3)) + D * D * C(D + 1, 2)
        + D * C(D + 3, 4) + C(D + 1, 2) * C(D + 2, 3)
        + D * C(D + 4, 5) + C(D + 6, 7))
      + C(D + 2, 2))


def rhs_full(D):
    p7 = ((D - 1) + 3 * ((D - 1) * (D - 1)) + 3 * ((D - 1) * C(D, 2))
        + (D - 1) * (D - 1) * (D - 1) + 2 * ((D - 1) * C(D + 1, 3))
        + (D - 1) * (D - 1) * C(D, 2) + (D - 1) * C(D + 2, 4)
        + C(D, 2) * C(D + 1, 3)
        + (D - 1) * C(D + 3, 5) + C(D + 5, 7))
    p6 = (D + 2 * (D * D) + D * C(D + 1, 2) + C(D + 1, 2)
          + D * D * D + D * C(D + 2, 3) + C(D + 2, 3)
          + C(D + 1, 2) * C(D + 1, 2)
          + D * C(D + 3, 4) + C(D + 5, 6))
    p5 = (D + 2 * (D * D) + 2 * (D * C(D + 1, 2)) + D * C(D + 2, 3)
          + C(D + 4, 5))
    return p7 + p6 + p5


if __name__ == "__main__":
    print("levelSeven_count_identity_gen, m = 0..9:")
    for m in range(0, 10):
        l, r = lhs_gen(m), rhs_gen(m)
        print(f"  m={m:2d}  lhs={l:6d}  rhs={r:6d}  match={l == r}")

    print("levelSeven_count_identity, D = 2..11 (m = D-2):")
    for D in range(2, 12):
        l, r = lhs_identity(D), rhs_identity(D)
        print(f"  D={D:2d}  lhs={l:6d}  rhs={r:6d}  match={l == r}")

    print("levelSeven_count_identity_full, D = 1..11 (m = D-1):")
    for D in range(1, 12):
        l, r = lhs_full(D), rhs_full(D)
        print(f"  D={D:2d}  lhs={l:6d}  rhs={r:6d}  match={l == r}")

    all_ok = (all(lhs_gen(m) == rhs_gen(m) for m in range(0, 10))
              and all(lhs_identity(D) == rhs_identity(D) for D in range(2, 12))
              and all(lhs_full(D) == rhs_full(D) for D in range(1, 12)))
    print(f"\nAll three Lean-literal statements verified: {all_ok}")
