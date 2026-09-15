"""Reproduce (in pure Python, no Lean) the numerical failure of
`formal/StringFormal/NoGhost/LevelSixCount.lean`'s `levelSix_count_identity_gen`.

That theorem claims `F(m+1) = F(m)` for the 11-term expression `F` written out below
(transcribed literally from the Lean source, RHS shape with `m` in place of `m`). This
script shows `F` is strictly increasing (never satisfies `F(m+1)=F(m)`), independently
confirming the `lake build` failure recorded in `proof.md` section 5. See `proof.md`
section 3 for why: by Claim 3, `kappa_6(m) = m+1 != 0` for every `m`, so no fixed-shape
`F` can satisfy `F(m+1)=F(m)` -- the identity is structurally, not just numerically,
wrong.
"""
from math import comb


def F(M):
    """The RHS of `levelSix_count_identity_gen` as literally written in the Lean
    source (11 terms, `m` playing the role of the smaller index)."""
    return (M + 2 * M * M + M * comb(M + 1, 2) + comb(M + 1, 2) + M ** 3
            + M * comb(M + 2, 3) + comb(M + 2, 3) + comb(M + 1, 2) ** 2
            + M * comb(M + 3, 4) + M * comb(M + 4, 5) + comb(M + 5, 6))


if __name__ == "__main__":
    print(f"{'m':>3} {'F(m)':>8} {'F(m+1)':>8} {'F(m+1)==F(m)?':>15}")
    for m in range(0, 6):
        print(f"{m:>3} {F(m):>8} {F(m + 1):>8} {str(F(m + 1) == F(m)):>15}")
    print("\nF is strictly increasing: the claimed identity F(m+1)=F(m) never holds.")
