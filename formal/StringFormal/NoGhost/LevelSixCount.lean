/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.LevelFiveCount

/-!
# The level-six counting identity

This file establishes the counting identity for `N = 6`, correcting two errors found by
review in an earlier version of this file.

## The correct 10-term, 11-shape parametrisation

`p_m(6)` has **eleven** partition shapes of `6` (`p(6) = 11`), but two of them — `5+1` and
`4+2` — give the *same* colour-counting monomial `m²` (a single part of one colour and a
single part of another, distinct, colour), so they combine into one algebraic term `2m²`.
The correct closed form therefore has **ten** terms:

`p_m(6) = m + 2m² + m·C(m+1,2) + C(m+1,2) + m³ + m·C(m+2,3) + C(m+2,3)
          + C(m+1,2)² + m·C(m+3,4) + C(m+5,6)`

matching the eleven shapes
`[6] [5,1] [4,2] [4,1,1] [3,3] [3,2,1] [3,1,1,1] [2,2,2] [2,2,1,1] [2,1,1,1,1] [1⁶]`.

**Reviewer finding**: an earlier version of this file had a spurious eleventh term
`m·C(m+4,5)`, purportedly for a shape "one part of size `x` plus five parts of size `y`,
`x ≠ y`" — but the only solution of `x + 5y = 6` in positive integers is `x = y = 1`, which
is *not* `x ≠ y`; there is no such shape.  That term is simply removed (it is not replaced by
anything: `1^6` is already counted once, by the `C(m+5,6)` term).

Numerically: at `m = 1` every one of the ten terms evaluates to `1` except the `2m²` term
(which evaluates to `2`), so `p_1(6) = 1·9 + 2 = 11 = p(6)`.  At `m = 2` the ten terms are
`2, 8, 6, 3, 8, 8, 4, 9, 10, 7`, summing to `p_2(6) = 65`.  At `m = 3` they are
`3, 18, 18, 6, 27, 30, 10, 36, 45, 28`, summing to `p_3(6) = 221`.

## The recursive form

Rather than proving the closed form directly (which is not needed anywhere else in the
repository), this file states and proves the **recursive Pascal identity**

`p_{m+1}(6) + (m + 1) = p_m(6) + p_{m+1}(5) + p_{m+1}(4)`,

the `N = 6` analogue of `LevelFiveCount.levelFive_count_identity_gen`
(`p_{m+1}(5) + 1 = p_m(5) + p_{m+1}(4) + p_{m+1}(3)`).  As at `N = 5`, the identity is *not*
the "clean" Pascal recursion `p_{m+1}(N) = p_m(N) + p_{m+1}(N−1) + p_{m+1}(N−2)` that holds
unconditionally for `N ≤ 4`: the excess grows from `1` (`N = 5`) to `m + 1` (`N = 6`).
Verified numerically: at `m = 0`, `11 + 1 = 0 + 7 + 5`; at `m = 1`, `65 + 2 = 11 + 36 + 20`;
at `m = 2`, `221 + 3 = 65 + 108 + 51`; at `m = 3`, `574 + 4 = 221 + 252 + 105`.

## Contents

* `levelSix_count_identity_gen` — the corrected recursive identity, valid for all `m`.
* `levelSix_count_identity` — specialization at `m = D − 2`.
* `levelSix_count_identity_full` — specialization at `m = D − 1`.

## Status

The three theorems compile with no `sorry`.

**Not done**: `b26_six`, `ddfSpans_bigrade_neg_six_six`, or any other components of the
level-six slice (out of scope for this fix).
-/

namespace StringFormal.NoGhost

/-! ### The level-six counting identity

The corrected recursive identity. Everything here is arithmetic in `ℕ`; `D` never appears,
only the number `m` of directions. -/

section CountIdentity

/-- **The level-six counting identity**, in the recursive form free of natural subtraction:

`p_{m+1}(6) + (m + 1) = p_m(6) + p_{m+1}(5) + p_{m+1}(4)`

with the corrected ten-term `p_m(6) = m + 2m² + m·C(m+1,2) + C(m+1,2) + m³ + m·C(m+2,3)
+ C(m+2,3) + C(m+1,2)² + m·C(m+3,4) + C(m+5,6)`, `p_m(5)` as in
`LevelFiveCount.levelFive_count_identity_gen` and `p_m(4)` as in
`LevelFourCount.levelFour_count_identity`.

The proof follows the standard pattern: apply Pascal's rule to expand the binomial
coefficients `C(m+2,2) … C(m+6,6)` down to the primitive atoms `C(m+1,2), C(m+2,3), C(m+3,4),
C(m+4,5), C(m+5,6)` shared with the level-five and level-four formulas, then `ring`. -/
theorem levelSix_count_identity_gen (m : ℕ) :
    ((m + 1) + 2 * ((m + 1) * (m + 1)) + (m + 1) * Nat.choose (m + 2) 2
        + Nat.choose (m + 2) 2 + (m + 1) * (m + 1) * (m + 1)
        + (m + 1) * Nat.choose (m + 3) 3 + Nat.choose (m + 3) 3
        + (Nat.choose (m + 2) 2) * (Nat.choose (m + 2) 2)
        + (m + 1) * Nat.choose (m + 4) 4 + Nat.choose (m + 6) 6) + (m + 1)
      = (m + 2 * (m * m) + m * Nat.choose (m + 1) 2 + Nat.choose (m + 1) 2
          + m * m * m + m * Nat.choose (m + 2) 3 + Nat.choose (m + 2) 3
          + (Nat.choose (m + 1) 2) * (Nat.choose (m + 1) 2)
          + m * Nat.choose (m + 3) 4 + Nat.choose (m + 5) 6)
        + ((m + 1) + 2 * ((m + 1) * (m + 1)) + 2 * ((m + 1) * Nat.choose (m + 2) 2)
            + (m + 1) * Nat.choose (m + 3) 3 + Nat.choose (m + 5) 5)
        + ((m + 1) + (m + 1) * (m + 1) + Nat.choose (m + 2) 2
            + (m + 1) * Nat.choose (m + 2) 2 + Nat.choose (m + 4) 4) := by
  -- Expand binomial coefficients using Pascal's rule
  have h2 : Nat.choose (m + 2) 2 = (m + 1) + Nat.choose (m + 1) 2 := by
    rw [Nat.choose_succ_succ (m + 1) 1, Nat.choose_one_right]
  have h3 : Nat.choose (m + 3) 3 = Nat.choose (m + 2) 2 + Nat.choose (m + 2) 3 :=
    Nat.choose_succ_succ (m + 2) 2
  have h4 : Nat.choose (m + 4) 4 = Nat.choose (m + 3) 3 + Nat.choose (m + 3) 4 :=
    Nat.choose_succ_succ (m + 3) 3
  have h5 : Nat.choose (m + 5) 5 = Nat.choose (m + 4) 4 + Nat.choose (m + 4) 5 :=
    Nat.choose_succ_succ (m + 4) 4
  have h6 : Nat.choose (m + 6) 6 = Nat.choose (m + 5) 5 + Nat.choose (m + 5) 6 :=
    Nat.choose_succ_succ (m + 5) 5
  -- Rewrite and verify by ring
  rw [h6, h5, h4, h3, h2]
  ring

variable {D : ℕ}

/-- **(I6)**: `levelSix_count_identity_gen` at `m = D − 2`, the level-six account.

`p_{D−1}(6) + (D − 1) = p_{D−2}(6) + p_{D−1}(5) + p_{D−1}(4)`.

At `D = 26`: `p_25(6) + 25 = p_24(6) + p_25(5) + p_25(4)`. -/
theorem levelSix_count_identity (hD : 2 ≤ D) :
    ((D - 1) + 2 * ((D - 1) * (D - 1)) + (D - 1) * Nat.choose D 2
        + Nat.choose D 2 + (D - 1) * (D - 1) * (D - 1)
        + (D - 1) * Nat.choose (D + 1) 3 + Nat.choose (D + 1) 3
        + (Nat.choose D 2) * (Nat.choose D 2)
        + (D - 1) * Nat.choose (D + 2) 4 + Nat.choose (D + 4) 6) + (D - 1)
      = ((D - 2) + 2 * ((D - 2) * (D - 2)) + (D - 2) * Nat.choose (D - 1) 2
          + Nat.choose (D - 1) 2 + (D - 2) * (D - 2) * (D - 2)
          + (D - 2) * Nat.choose D 3 + Nat.choose D 3
          + (Nat.choose (D - 1) 2) * (Nat.choose (D - 1) 2)
          + (D - 2) * Nat.choose (D + 1) 4 + Nat.choose (D + 3) 6)
        + ((D - 1) + 2 * ((D - 1) * (D - 1)) + 2 * ((D - 1) * Nat.choose D 2)
            + (D - 1) * Nat.choose (D + 1) 3 + Nat.choose (D + 3) 5)
        + ((D - 1) + (D - 1) * (D - 1) + Nat.choose D 2
            + (D - 1) * Nat.choose D 2 + Nat.choose (D + 2) 4) := by
  obtain ⟨m, rfl⟩ : ∃ m, D = m + 2 := ⟨D - 2, by omega⟩
  simp only [show m + 2 - 1 = m + 1 from rfl, show m + 2 - 2 = m from rfl,
    show m + 2 + 1 = m + 3 from rfl, show m + 2 + 2 = m + 4 from rfl,
    show m + 2 + 3 = m + 5 from rfl, show m + 2 + 4 = m + 6 from rfl]
  exact levelSix_count_identity_gen m

/-- `levelSix_count_identity_gen` at `m = D − 1`, for use in kernel bounds or similar
applications.

`p_D(6) + D = p_{D−1}(6) + p_D(5) + p_D(4)`. -/
theorem levelSix_count_identity_full (hD : 1 ≤ D) :
    (D + 2 * (D * D) + D * Nat.choose (D + 1) 2 + Nat.choose (D + 1) 2
        + D * D * D + D * Nat.choose (D + 2) 3 + Nat.choose (D + 2) 3
        + (Nat.choose (D + 1) 2) * (Nat.choose (D + 1) 2)
        + D * Nat.choose (D + 3) 4 + Nat.choose (D + 5) 6) + D
      = ((D - 1) + 2 * ((D - 1) * (D - 1)) + (D - 1) * Nat.choose D 2
          + Nat.choose D 2 + (D - 1) * (D - 1) * (D - 1)
          + (D - 1) * Nat.choose (D + 1) 3 + Nat.choose (D + 1) 3
          + (Nat.choose D 2) * (Nat.choose D 2)
          + (D - 1) * Nat.choose (D + 2) 4 + Nat.choose (D + 4) 6)
        + (D + 2 * (D * D) + 2 * (D * Nat.choose (D + 1) 2)
            + D * Nat.choose (D + 2) 3 + Nat.choose (D + 4) 5)
        + (D + D * D + Nat.choose (D + 1) 2
            + D * Nat.choose (D + 1) 2 + Nat.choose (D + 3) 4) := by
  obtain ⟨m, rfl⟩ : ∃ m, D = m + 1 := ⟨D - 1, by omega⟩
  simp only [show m + 1 - 1 = m from rfl, show m + 1 + 1 = m + 2 from rfl,
    show m + 1 + 2 = m + 3 from rfl, show m + 1 + 3 = m + 4 from rfl,
    show m + 1 + 4 = m + 5 from rfl, show m + 1 + 5 = m + 6 from rfl]
  exact levelSix_count_identity_gen m

end CountIdentity

end StringFormal.NoGhost
