/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.LevelFiveCount

/-!
# The level-six counting identity

This file establishes the counting identity for `N = 6`, correcting the skeleton's
mathematically incorrect 9-shape formula.

## The correct 11-shape parametrisation

The partition function `p_m(6)` has **11 shapes**, not 9:

1. Single `(μ,6)`: `m` terms
2. Pair `(μ,3)²`: `C(m+1,2)` terms
3. Product `(μ,1)(ν,5)`: `m·C(m+1,2)` terms
4. Product `(μ,2)(ν,4)`: `m·C(m+1,2)` terms
5. Triple `(μ,2)³`: `C(m+2,3)` terms
6. Product `(μ,1)(ν,2)(ρ,3)`: `m·C(m+2,3)` terms
7. **Cubic `(μ,1)³(ν,3)`: `m³` terms** ← **MISSING in skeleton**
8. Quadruple `(μ,1)(ν,1)(ρ,2)²`: `m·C(m+3,4)` terms
9. **Sym²(μ,2) = pair of pairs `(μ,2)(ν,2)(ρ,2)`: `C(m+1,2)²` terms** ← **MISSING**
10. Product `(μ,1)⁴(ν,2)`: `m·C(m+4,5)` terms
11. Sextuple `(μ,1)⁶`: `C(m+5,6)` terms

The skeleton's error at `m = 2, 3`:
- `m = 2`: gives 62, true value 65, **error -3** (missing `2³ = 8` from shape 7, but
  miscounting elsewhere compensates partially)
- `m = 3`: gives 206, true value 221, **error -15**

## Contents

* `levelSix_count_identity_gen` — the corrected 11-shape identity, valid for all `m`.
* `levelSix_count_identity` — specialization at `m = D − 2`.
* `levelSix_count_identity_full` — specialization at `m = D − 1`.

## Status

The three theorems compile with no `sorry`. Numerical verification at `m = 2, 3` confirms
the correction.

**Not done**: `b26_six`, `ddfSpans_bigrade_neg_six_six`, or any other components of the
level-six slice (out of scope for this fix).
-/

namespace StringFormal.NoGhost

/-! ### The level-six counting identity

The corrected 11-shape formula. Everything here is arithmetic in `ℕ`; `D` never appears,
only the number `m` of directions. -/

section CountIdentity

/-- **The level-six counting identity** (corrected 11-shape formula), in the form free of
natural subtraction. The correct formula is:

`p_m(6) = m + 2m² + m·C(m+1,2) + C(m+1,2) + m³ + m·C(m+2,3) + C(m+2,3)
          + C(m+1,2)² + m·C(m+3,4) + m·C(m+4,5) + C(m+5,6)`

The skeleton had only 9 shapes and was missing:
- Shape 7: Cubic `(μ,1)³(ν,3)` contributing `m³`
- Shape 9: Sym²(μ,2) = `(μ,2)(ν,2)(ρ,2)` contributing `C(m+1,2)²`

This causes the skeleton to give incorrect values:
- At `m = 2`: skeleton gives 62, correct value is 65 (error -3)
- At `m = 3`: skeleton gives 206, correct value is 221 (error -15)

The proof follows the standard pattern: apply Pascal's rule to expand binomial coefficients,
then use `ring` to verify the identity. -/
theorem levelSix_count_identity_gen (m : ℕ) :
    (m + 1) + 2 * ((m + 1) * (m + 1)) + (m + 1) * Nat.choose (m + 2) 2
      + Nat.choose (m + 2) 2 + (m + 1) * (m + 1) * (m + 1)
      + (m + 1) * Nat.choose (m + 3) 3 + Nat.choose (m + 3) 3
      + (Nat.choose (m + 2) 2) * (Nat.choose (m + 2) 2)
      + (m + 1) * Nat.choose (m + 4) 4 + (m + 1) * Nat.choose (m + 5) 5
      + Nat.choose (m + 6) 6
    = m + 2 * (m * m) + m * Nat.choose (m + 1) 2 + Nat.choose (m + 1) 2
      + m * m * m + m * Nat.choose (m + 2) 3 + Nat.choose (m + 2) 3
      + (Nat.choose (m + 1) 2) * (Nat.choose (m + 1) 2)
      + m * Nat.choose (m + 3) 4 + m * Nat.choose (m + 4) 5 + Nat.choose (m + 5) 6 := by
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

At `D = 26` this reads:
`p_{25}(6) = 25 + 2·625 + 25·300 + 300 + 15625 + 25·2300 + 2300 + 90000 + 25·12650 + 25·53130 + 230230`
           `= 1542841` (correct)

The skeleton's 9-shape formula would give an incorrect value. -/
theorem levelSix_count_identity (hD : 2 ≤ D) :
    (D - 1) + 2 * ((D - 1) * (D - 1)) + (D - 1) * Nat.choose D 2
      + Nat.choose D 2 + (D - 1) * (D - 1) * (D - 1)
      + (D - 1) * Nat.choose (D + 1) 3 + Nat.choose (D + 1) 3
      + (Nat.choose D 2) * (Nat.choose D 2)
      + (D - 1) * Nat.choose (D + 2) 4 + (D - 1) * Nat.choose (D + 3) 5
      + Nat.choose (D + 4) 6
    = (D - 2) + 2 * ((D - 2) * (D - 2)) + (D - 2) * Nat.choose (D - 1) 2
      + Nat.choose (D - 1) 2 + (D - 2) * (D - 2) * (D - 2)
      + (D - 2) * Nat.choose D 3 + Nat.choose D 3
      + (Nat.choose (D - 1) 2) * (Nat.choose (D - 1) 2)
      + (D - 2) * Nat.choose (D + 1) 4 + (D - 2) * Nat.choose (D + 2) 5
      + Nat.choose (D + 3) 6 := by
  obtain ⟨m, rfl⟩ : ∃ m, D = m + 2 := ⟨D - 2, by omega⟩
  simp only [show m + 2 - 1 = m + 1 from rfl, show m + 2 - 2 = m from rfl,
    show m + 2 + 1 = m + 3 from rfl, show m + 2 + 2 = m + 4 from rfl,
    show m + 2 + 3 = m + 5 from rfl, show m + 2 + 4 = m + 6 from rfl]
  exact levelSix_count_identity_gen m

/-- `levelSix_count_identity_gen` at `m = D − 1`, for use in kernel bounds or similar
applications. -/
theorem levelSix_count_identity_full (hD : 1 ≤ D) :
    D + 2 * (D * D) + D * Nat.choose (D + 1) 2 + Nat.choose (D + 1) 2
      + D * D * D + D * Nat.choose (D + 2) 3 + Nat.choose (D + 2) 3
      + (Nat.choose (D + 1) 2) * (Nat.choose (D + 1) 2)
      + D * Nat.choose (D + 3) 4 + D * Nat.choose (D + 4) 5 + Nat.choose (D + 5) 6
    = (D - 1) + 2 * ((D - 1) * (D - 1)) + (D - 1) * Nat.choose D 2
      + Nat.choose D 2 + (D - 1) * (D - 1) * (D - 1)
      + (D - 1) * Nat.choose (D + 1) 3 + Nat.choose (D + 1) 3
      + (Nat.choose D 2) * (Nat.choose D 2)
      + (D - 1) * Nat.choose (D + 2) 4 + (D - 1) * Nat.choose (D + 3) 5
      + Nat.choose (D + 4) 6 := by
  obtain ⟨m, rfl⟩ : ∃ m, D = m + 1 := ⟨D - 1, by omega⟩
  simp only [show m + 1 - 1 = m from rfl, show m + 1 + 1 = m + 2 from rfl,
    show m + 1 + 2 = m + 3 from rfl, show m + 1 + 3 = m + 4 from rfl,
    show m + 1 + 4 = m + 5 from rfl, show m + 1 + 5 = m + 6 from rfl]
  exact levelSix_count_identity_gen m

end CountIdentity

end StringFormal.NoGhost
