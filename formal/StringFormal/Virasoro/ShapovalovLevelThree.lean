/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import StringFormal.Virasoro.Shapovalov

/-!
# The level-3 Gram matrix and the Kac determinant at `N = 3`

Graph node: `worldsheet.shapovalov-form`.
Convention: `conv.virasoro-standard`
  `[L_m, L_n] = (m - n) L_{m+n} + (c/12) m (m² - 1) δ_{m+n,0}`

This file continues `Shapovalov.lean` (which stops at `N ≤ 2`, with the level-2 determinant
`2h(16h² + 2h(c-5) + c)`) one level further.  For the three level-3 descendants

* `desc3   = L₋₃ |c,h⟩`,
* `desc21  = L₋₂ L₋₁ |c,h⟩`,
* `desc111 = L₋₁³ |c,h⟩`,

we compute all nine entries of the Gram matrix of an arbitrary normalised contravariant form,
its `3 × 3` determinant, and check that the determinant is the `N = 3` Kac polynomial.

## Main results

* `IsContravariant.gram_level_three_*`: the six independent entries.
* `IsContravariant.gram_level_three_det`: `det = 48h²(16h² + 2h(c-5) + c)(3h² + h(c-7) + c + 2)`.
* `IsContravariant.gram_level_three_det_eq_kac`: the same in Kac's factored shape.

## Caveat (inherited from `Shapovalov.lean`)

`levelSpan R c h 3` is spanned by the four *compositions* of `3`, and the three vectors above
span it (`L₋₁L₋₂|c,h⟩ = desc21 - desc3` by the bracket relation).  That they are linearly
*independent* is exactly PBW, which is not available; so as in `gram_level_two_det` this is the
determinant of an explicit `3 × 3` matrix of inner products, not yet formally "the Kac
determinant of `V₃`".
-/

namespace StringFormal.Virasoro

section Level3

variable (R : Type*) [CommRing R] [Algebra ℚ R] (c h : R)

/-- The level-3 descendant `L₋₃|c,h⟩`. -/
noncomputable def desc3 : VermaModule R c h := ⁅VirasoroAlgebra.lgen R (-3), hwv R c h⁆

/-- The level-3 descendant `L₋₂L₋₁|c,h⟩`. -/
noncomputable def desc21 : VermaModule R c h := ⁅VirasoroAlgebra.lgen R (-2), desc1 R c h⁆

/-- The level-3 descendant `L₋₁³|c,h⟩`. -/
noncomputable def desc111 : VermaModule R c h := ⁅VirasoroAlgebra.lgen R (-1), desc11 R c h⁆

end Level3

end StringFormal.Virasoro
