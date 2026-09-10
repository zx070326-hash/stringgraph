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

end Level4

end StringFormal.Virasoro
