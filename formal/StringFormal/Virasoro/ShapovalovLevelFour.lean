/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import StringFormal.Virasoro.ShapovalovLevelThree

/-!
# The level-4 Gram matrix and the Kac determinant at `N = 4`

Graph node: `worldsheet.shapovalov-form`, `worldsheet.kac-determinant`.
Convention: `conv.virasoro-standard`
  `[L_m, L_n] = (m - n) L_{m+n} + (c/12) m (m² - 1) δ_{m+n,0}`

This continues `ShapovalovLevelThree.lean` one level further.  Level `4` is the first level at
which `p(N) = 5 > N`, at which a Kac weight with `rs = 4` and *rational* `h_{r,s}` appears
(`h₂₂ = (1-c)/8`), and at which a root of the Kac polynomial occurs with multiplicity `> 1`
in a genuinely new way (`p(4-2) = p(2) = 2` for the `rs = 2` pair).

For the five level-4 descendants

* `desc4    = L₋₄ |c,h⟩`,
* `desc31   = L₋₃ L₋₁ |c,h⟩`,
* `desc22   = L₋₂² |c,h⟩`,
* `desc211  = L₋₂ L₋₁² |c,h⟩`,
* `desc1111 = L₋₁⁴ |c,h⟩`,

we compute all `15` independent entries of the Gram matrix of an arbitrary normalised
contravariant form, its `5 × 5` determinant, and check that the determinant is the `N = 4`
Kac polynomial.

## Main results

* `IsContravariant.gram_level_four_*`: the fifteen independent entries.
* `IsContravariant.gram_level_four_matrix`: the whole `5 × 5` matrix at once.
* `IsContravariant.gram_level_four_det`:
  `det = 384 h³ (c + 8h - 1) (16h² + 2h(c-5) + c)² (3h² + h(c-7) + c + 2)`
  `      · (16h² + 10ch - 82h + 15c + 66)`.
* `IsContravariant.gram_level_four_det_eq_kac`: the same in Kac's factored shape,
  `K₄ · (h-h₁₁)³ ((h-h₁₂)(h-h₂₁))² (h-h₁₃)(h-h₃₁) (h-h₂₂) (h-h₁₄)(h-h₄₁)`
  with `K₄ = 37748736 = 2²² · 3²`.

## Caveat (inherited from `Shapovalov.lean`)

`levelSpan R c h 4` is spanned by the eight *compositions* of `4`, and the five vectors above
span it.  That they are linearly *independent* is exactly PBW, which is not available here; so
as in `gram_level_two_det` and `gram_level_three_det` this is the determinant of an explicit
`5 × 5` matrix of inner products, not yet formally "the Kac determinant of `V₄`".
-/

namespace StringFormal.Virasoro

section Level4

variable (R : Type*) [CommRing R] [Algebra ℚ R] (c h : R)

/-- The level-4 descendant `L₋₄|c,h⟩`. -/
noncomputable def desc4 : VermaModule R c h := ⁅VirasoroAlgebra.lgen R (-4), hwv R c h⁆

/-- The level-4 descendant `L₋₃L₋₁|c,h⟩`. -/
noncomputable def desc31 : VermaModule R c h := ⁅VirasoroAlgebra.lgen R (-3), desc1 R c h⁆

/-- The level-4 descendant `L₋₂²|c,h⟩`. -/
noncomputable def desc22 : VermaModule R c h := ⁅VirasoroAlgebra.lgen R (-2), desc2 R c h⁆

/-- The level-4 descendant `L₋₂L₋₁²|c,h⟩`. -/
noncomputable def desc211 : VermaModule R c h := ⁅VirasoroAlgebra.lgen R (-2), desc11 R c h⁆

/-- The level-4 descendant `L₋₁⁴|c,h⟩`. -/
noncomputable def desc1111 : VermaModule R c h := ⁅VirasoroAlgebra.lgen R (-1), desc111 R c h⁆

/-! ### Brackets of generators needed at level 4 -/

/-- `(4³ - 4)/12 = 5`: the level-4 central coefficient is an integer. -/
lemma centralTerm_four : centralTerm R 4 = 5 := by
  have h60 : (((4 : ℤ) ^ 3 - 4 : ℤ) : R) = 60 := by norm_num
  rw [centralTerm, h60, show inv12 R * (60 : R) = 5 * (12 * inv12 R) by ring,
    twelve_mul_inv12, mul_one]

lemma lie_lgen_four_neg_four : ⁅VirasoroAlgebra.lgen R 4, VirasoroAlgebra.lgen R (-4)⁆
    = (8 : R) • VirasoroAlgebra.lgen R 0 + centralTerm R 4 • VirasoroAlgebra.cgen R := by
  rw [VirasoroAlgebra.lie_lgen_lgen]
  norm_num

lemma lie_lgen_four_neg_three : ⁅VirasoroAlgebra.lgen R 4, VirasoroAlgebra.lgen R (-3)⁆
    = (7 : R) • VirasoroAlgebra.lgen R 1 := by
  rw [VirasoroAlgebra.lie_lgen_lgen]
  norm_num

lemma lie_lgen_four_neg_two : ⁅VirasoroAlgebra.lgen R 4, VirasoroAlgebra.lgen R (-2)⁆
    = (6 : R) • VirasoroAlgebra.lgen R 2 := by
  rw [VirasoroAlgebra.lie_lgen_lgen]
  norm_num

lemma lie_lgen_four_neg_one : ⁅VirasoroAlgebra.lgen R 4, VirasoroAlgebra.lgen R (-1)⁆
    = (5 : R) • VirasoroAlgebra.lgen R 3 := by
  rw [VirasoroAlgebra.lie_lgen_lgen]
  norm_num

lemma lie_lgen_one_neg_two : ⁅VirasoroAlgebra.lgen R 1, VirasoroAlgebra.lgen R (-2)⁆
    = (3 : R) • VirasoroAlgebra.lgen R (-1) := by
  rw [VirasoroAlgebra.lie_lgen_lgen]
  norm_num

lemma lie_lgen_zero_neg_two : ⁅VirasoroAlgebra.lgen R 0, VirasoroAlgebra.lgen R (-2)⁆
    = (2 : R) • VirasoroAlgebra.lgen R (-2) := by
  rw [VirasoroAlgebra.lie_lgen_lgen]
  norm_num

/-! ### Action of `L₄` on level 4: everything lands on `|c,h⟩` -/

/-- `L₄ L₋₁|c,h⟩ = 0`. -/
lemma lie_lgen_four_desc1 : ⁅VirasoroAlgebra.lgen R 4, desc1 R c h⁆ = 0 := by
  rw [desc1, leibniz_lie, lie_lgen_hwv_of_pos R c h (by norm_num : (0:ℤ) < 4), lie_zero,
    add_zero, lie_lgen_four_neg_one, smul_lie,
    lie_lgen_hwv_of_pos R c h (by norm_num : (0:ℤ) < 3), smul_zero]

/-- `L₄ L₋₂|c,h⟩ = 0`. -/
lemma lie_lgen_four_desc2 : ⁅VirasoroAlgebra.lgen R 4, desc2 R c h⁆ = 0 := by
  rw [desc2, leibniz_lie, lie_lgen_hwv_of_pos R c h (by norm_num : (0:ℤ) < 4), lie_zero,
    add_zero, lie_lgen_four_neg_two, smul_lie,
    lie_lgen_hwv_of_pos R c h (by norm_num : (0:ℤ) < 2), smul_zero]

/-- `L₄ L₋₁²|c,h⟩ = 0`. -/
lemma lie_lgen_four_desc11 : ⁅VirasoroAlgebra.lgen R 4, desc11 R c h⁆ = 0 := by
  rw [desc11, leibniz_lie, lie_lgen_four_desc1, lie_zero, add_zero, lie_lgen_four_neg_one,
    smul_lie, lie_lgen_three_desc1, smul_zero]

/-- `L₄ L₋₁³|c,h⟩ = 0`. -/
lemma lie_lgen_four_desc111 : ⁅VirasoroAlgebra.lgen R 4, desc111 R c h⁆ = 0 := by
  rw [desc111, leibniz_lie, lie_lgen_four_desc11, lie_zero, add_zero, lie_lgen_four_neg_one,
    smul_lie, lie_lgen_three_desc11, smul_zero]

/-- `L₄ L₋₄|c,h⟩ = (8h + 5c)|c,h⟩`. -/
lemma lie_lgen_four_desc4 : ⁅VirasoroAlgebra.lgen R 4, desc4 R c h⁆
    = (8 * h + 5 * c) • hwv R c h := by
  rw [desc4, leibniz_lie, lie_lgen_hwv_of_pos R c h (by norm_num : (0:ℤ) < 4), lie_zero,
    add_zero, lie_lgen_four_neg_four, add_lie, smul_lie, smul_lie, lie_lgen_zero_hwv,
    lie_cgen_hwv, smul_smul, smul_smul, ← add_smul, centralTerm_four]

/-- `L₄ L₋₃L₋₁|c,h⟩ = 14h |c,h⟩`. -/
lemma lie_lgen_four_desc31 : ⁅VirasoroAlgebra.lgen R 4, desc31 R c h⁆
    = (14 * h) • hwv R c h := by
  rw [desc31, leibniz_lie, lie_lgen_four_desc1, lie_zero, add_zero, lie_lgen_four_neg_three,
    smul_lie, lie_lgen_one_desc1, smul_smul]
  congr 1
  ring

/-- `L₄ L₋₂²|c,h⟩ = (24h + 3c)|c,h⟩`. -/
lemma lie_lgen_four_desc22 : ⁅VirasoroAlgebra.lgen R 4, desc22 R c h⁆
    = (24 * h + 3 * c) • hwv R c h := by
  rw [desc22, leibniz_lie, lie_lgen_four_desc2, lie_zero, add_zero, lie_lgen_four_neg_two,
    smul_lie, lie_lgen_two_desc2, smul_smul]
  congr 1
  linear_combination (3 * c) * two_mul_centralTerm_two R

/-- `L₄ L₋₂L₋₁²|c,h⟩ = 36h |c,h⟩`. -/
lemma lie_lgen_four_desc211 : ⁅VirasoroAlgebra.lgen R 4, desc211 R c h⁆
    = (36 * h) • hwv R c h := by
  rw [desc211, leibniz_lie, lie_lgen_four_desc11, lie_zero, add_zero, lie_lgen_four_neg_two,
    smul_lie, lie_lgen_two_desc11, smul_smul]
  congr 1
  ring

/-- `L₄ L₋₁⁴|c,h⟩ = 120h |c,h⟩`. -/
lemma lie_lgen_four_desc1111 : ⁅VirasoroAlgebra.lgen R 4, desc1111 R c h⁆
    = (120 * h) • hwv R c h := by
  rw [desc1111, leibniz_lie, lie_lgen_four_desc111, lie_zero, add_zero, lie_lgen_four_neg_one,
    smul_lie, lie_lgen_three_desc111, smul_smul]
  congr 1
  ring

/-! ### Action of `L₃` on level 4: everything lands on `L₋₁|c,h⟩` -/

/-- `L₁ L₋₂|c,h⟩ = 3 L₋₁|c,h⟩`. -/
lemma lie_lgen_one_desc2 : ⁅VirasoroAlgebra.lgen R 1, desc2 R c h⁆ = (3 : R) • desc1 R c h := by
  rw [desc2, leibniz_lie, lie_lgen_hwv_of_pos R c h one_pos, lie_zero, add_zero,
    lie_lgen_one_neg_two, smul_lie, ← desc1]

/-- `L₃ L₋₂|c,h⟩ = 0`. -/
lemma lie_lgen_three_desc2 : ⁅VirasoroAlgebra.lgen R 3, desc2 R c h⁆ = 0 := by
  rw [desc2, leibniz_lie, lie_lgen_hwv_of_pos R c h (by norm_num : (0:ℤ) < 3), lie_zero,
    add_zero, lie_lgen_three_neg_two, smul_lie,
    lie_lgen_hwv_of_pos R c h one_pos, smul_zero]

/-- `L₃ L₋₃L₋₁|c,h⟩ = (6h + 6 + 2c) L₋₁|c,h⟩`. -/
lemma lie_lgen_three_desc31 : ⁅VirasoroAlgebra.lgen R 3, desc31 R c h⁆
    = (6 * h + 6 + 2 * c) • desc1 R c h := by
  rw [desc31, leibniz_lie, lie_lgen_three_desc1, lie_zero, add_zero, lie_lgen_three_neg_three,
    add_lie, smul_lie, smul_lie, lie_lgen_zero_desc1, lie_cgen_eq, smul_smul, smul_smul,
    ← add_smul, centralTerm_three]
  congr 1
  ring

/-- `L₃ L₋₂²|c,h⟩ = 15 L₋₁|c,h⟩`. -/
lemma lie_lgen_three_desc22 : ⁅VirasoroAlgebra.lgen R 3, desc22 R c h⁆
    = (15 : R) • desc1 R c h := by
  rw [desc22, leibniz_lie, lie_lgen_three_desc2, lie_zero, add_zero, lie_lgen_three_neg_two,
    smul_lie, lie_lgen_one_desc2, smul_smul]
  congr 1
  norm_num

/-- `L₃ L₋₂L₋₁²|c,h⟩ = (20h + 10) L₋₁|c,h⟩`. -/
lemma lie_lgen_three_desc211 : ⁅VirasoroAlgebra.lgen R 3, desc211 R c h⁆
    = (20 * h + 10) • desc1 R c h := by
  rw [desc211, leibniz_lie, lie_lgen_three_desc11, lie_zero, add_zero, lie_lgen_three_neg_two,
    smul_lie, lie_lgen_one_desc11, smul_smul]
  congr 1
  ring

/-- `L₃ L₋₁⁴|c,h⟩ = (96h + 24) L₋₁|c,h⟩`. -/
lemma lie_lgen_three_desc1111 : ⁅VirasoroAlgebra.lgen R 3, desc1111 R c h⁆
    = (96 * h + 24) • desc1 R c h := by
  rw [desc1111, leibniz_lie, lie_lgen_three_desc111, lie_smul, ← desc1, lie_lgen_three_neg_one,
    smul_lie, lie_lgen_two_desc111, smul_smul, ← add_smul]
  congr 1
  ring

/-! ### Action of `L₂` on level 4: everything lands on level 2 -/

/-- `L₀ L₋₂|c,h⟩ = (h+2) L₋₂|c,h⟩`. -/
lemma lie_lgen_zero_desc2 : ⁅VirasoroAlgebra.lgen R 0, desc2 R c h⁆
    = (h + 2) • desc2 R c h := by
  rw [desc2, leibniz_lie, lie_lgen_zero_hwv, lie_lgen_zero_neg_two, smul_lie, lie_smul,
    ← desc2, add_comm, add_smul]

/-- `L₂ L₋₂²|c,h⟩ = (8h + 8 + c) L₋₂|c,h⟩`. -/
lemma lie_lgen_two_desc22 : ⁅VirasoroAlgebra.lgen R 2, desc22 R c h⁆
    = (8 * h + 8 + c) • desc2 R c h := by
  rw [desc22, leibniz_lie, lie_lgen_two_desc2, lie_smul, ← desc2, lie_lgen_two_neg_two,
    add_lie, smul_lie, smul_lie, lie_lgen_zero_desc2, lie_cgen_eq, smul_smul, smul_smul,
    ← add_smul, ← add_smul]
  congr 1
  linear_combination c * two_mul_centralTerm_two R

/-- `L₂ L₋₂L₋₁²|c,h⟩ = 6h L₋₂|c,h⟩ + (4h + 8 + c/2) L₋₁²|c,h⟩`. -/
lemma lie_lgen_two_desc211 : ⁅VirasoroAlgebra.lgen R 2, desc211 R c h⁆
    = (6 * h) • desc2 R c h + (4 * h + 8 + centralTerm R 2 * c) • desc11 R c h := by
  rw [desc211, leibniz_lie, lie_lgen_two_desc11, lie_smul, ← desc2, lie_lgen_two_neg_two,
    add_lie, smul_lie, smul_lie, lie_lgen_zero_desc11, lie_cgen_eq, smul_smul, smul_smul,
    ← add_smul, add_comm]
  congr 2
  ring

/-- `L₂ L₋₁⁴|c,h⟩ = (36h + 24) L₋₁²|c,h⟩`. -/
lemma lie_lgen_two_desc1111 : ⁅VirasoroAlgebra.lgen R 2, desc1111 R c h⁆
    = (36 * h + 24) • desc11 R c h := by
  rw [desc1111, leibniz_lie, lie_lgen_two_desc111, lie_smul, ← desc11, lie_lgen_two_neg_one,
    smul_lie, lie_lgen_one_desc111, smul_smul, ← add_smul]
  congr 1
  ring

/-! ### Action of `L₁` on `L₋₁⁴|c,h⟩` -/

/-- `L₀ L₋₁³|c,h⟩ = (h+3) L₋₁³|c,h⟩`. -/
lemma lie_lgen_zero_desc111 : ⁅VirasoroAlgebra.lgen R 0, desc111 R c h⁆
    = (h + 3) • desc111 R c h := by
  rw [desc111, leibniz_lie, lie_lgen_zero_desc11, lie_lgen_zero_neg_one, one_smul, lie_smul]
  module

/-- `L₁ L₋₁⁴|c,h⟩ = (8h + 12) L₋₁³|c,h⟩`. -/
lemma lie_lgen_one_desc1111 : ⁅VirasoroAlgebra.lgen R 1, desc1111 R c h⁆
    = (8 * h + 12) • desc111 R c h := by
  rw [desc1111, leibniz_lie, lie_lgen_one_desc111, lie_smul, ← desc111, lie_lgen_one_neg_one,
    smul_lie, lie_lgen_zero_desc111, smul_smul, ← add_smul]
  congr 1
  ring

end Level4

end StringFormal.Virasoro
