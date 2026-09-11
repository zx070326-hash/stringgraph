/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import Mathlib.LinearAlgebra.Matrix.Nondegenerate
import StringFormal.Virasoro.ShapovalovLevelFour

/-!
# Linear independence of the low-level descendants at generic `(c,h)`

Graph node: `worldsheet.verma-module-pbw-basis` (the linear-independence half, (b)),
`worldsheet.kac-determinant`.
Convention: `conv.virasoro-standard`
  `[L_m, L_n] = (m - n) L_{m+n} + (c/12) m (m² - 1) δ_{m+n,0}`

`VermaPBW.lean` proves the *spanning* half of PBW (`dim V_N ≤ p(N)`); the linear-independence
half is not available in Mathlib `v4.33.1`.  This file supplies a **generic substitute for
`N ≤ 4`**: a nonvanishing Gram determinant forces linear independence, and the level `≤ 4`
Gram determinants have already been computed in closed form in `Shapovalov.lean`,
`ShapovalovLevelThree.lean`, `ShapovalovLevelFour.lean`.

The logic is pure linear algebra: if `∑ᵢ aᵢ vᵢ = 0` then `∑ᵢ aᵢ B(vᵢ, v_j) = 0` for every `j`,
i.e. `a ᵥ* Gram = 0`, so `det Gram ≠ 0` gives `a = 0`.

## Main results

* `StringFormal.gramMatrix`, `StringFormal.linearIndependent_of_gram_det_ne_zero`:
  the general lemma (any bilinear form over a domain).

## What this does and does not give

It gives linear independence of the `p(N)` standard descendants for those `(c,h)` at which the
level-`N` Kac polynomial does **not** vanish, i.e. for generic `(c,h)`.  It says nothing at the
Kac zeros (where the vectors are genuinely dependent only after quotienting — at a Kac zero the
Gram matrix is singular but the vectors may still be independent, the form merely degenerates),
and it still presupposes the existence of a normalised contravariant form, which by
`exists_isContravariant_iff_hwv_ne_zero` is equivalent to `hwv ≠ 0`, i.e. to `V(c,h) ≠ 0` —
itself a consequence of the full PBW.  So this is a *conditional* generic PBW (b), not PBW (b).
-/

namespace StringFormal

section GramIndependence

open Matrix

variable {R M ι : Type*} [CommRing R] [AddCommGroup M] [Module R M] [Fintype ι] [DecidableEq ι]

/-- The **Gram matrix** `(B (v i) (v j))_{i,j}` of a finite family `v` with respect to a
bilinear form `B`. -/
def gramMatrix (B : M →ₗ[R] M →ₗ[R] R) (v : ι → M) : Matrix ι ι R :=
  Matrix.of fun i j => B (v i) (v j)

omit [Fintype ι] [DecidableEq ι] in
@[simp]
lemma gramMatrix_apply (B : M →ₗ[R] M →ₗ[R] R) (v : ι → M) (i j : ι) :
    gramMatrix B v i j = B (v i) (v j) := rfl

omit [DecidableEq ι] in
/-- A vanishing linear combination of the `vᵢ` is annihilated by the Gram matrix. -/
lemma vecMul_gramMatrix_eq_zero {B : M →ₗ[R] M →ₗ[R] R} {v : ι → M} {g : ι → R}
    (hg : ∑ i, g i • v i = 0) : g ᵥ* gramMatrix B v = 0 := by
  funext j
  have h0 : B (∑ i, g i • v i) (v j) = 0 := by rw [hg, map_zero, LinearMap.zero_apply]
  simp only [map_sum, LinearMap.map_smul, LinearMap.sum_apply, LinearMap.smul_apply,
    smul_eq_mul] at h0
  simpa [Matrix.vecMul, dotProduct] using h0

/-- **Nonvanishing Gram determinant implies linear independence.**  Over a domain, if the Gram
matrix of a finite family `v` with respect to *some* bilinear form has nonzero determinant, then
`v` is linearly independent.  No symmetry, no nondegeneracy of `B` on the whole module, and no
finite-dimensionality is needed. -/
theorem linearIndependent_of_gram_det_ne_zero [NoZeroDivisors R] (B : M →ₗ[R] M →ₗ[R] R)
    (v : ι → M) (hdet : (gramMatrix B v).det ≠ 0) : LinearIndependent R v := by
  rw [Fintype.linearIndependent_iff]
  intro g hg
  exact congrFun
    (Matrix.eq_zero_of_vecMul_eq_zero hdet (vecMul_gramMatrix_eq_zero (B := B) hg))

end GramIndependence

namespace Virasoro

/-! ### Level 2 -/

section Level2

variable (R : Type*) [CommRing R] [Algebra ℚ R] (c h : R)

/-- The two standard level-2 descendants `L₋₂|c,h⟩`, `L₋₁²|c,h⟩` as a family indexed by
`Fin 2`, one entry per composition (equivalently, per partition) of `2`. -/
noncomputable def descFamily2 : Fin 2 → VermaModule R c h :=
  ![desc2 R c h, desc11 R c h]

variable {R c h}
variable {B : VermaModule R c h →ₗ[R] VermaModule R c h →ₗ[R] R}

/-- The `2 × 2` Gram determinant of `descFamily2` is the level-2 Kac polynomial
`2h(16h² + 2h(c-5) + c)`.  Restatement of `IsContravariant.gram_level_two_det` with the
matrix packaged as `gramMatrix`. -/
theorem IsContravariant.gram_det_descFamily2 (hB : IsContravariant R c h B)
    (hB1 : B (hwv R c h) (hwv R c h) = 1) :
    (gramMatrix B (descFamily2 R c h)).det
      = 2 * h * (16 * h ^ 2 + 2 * h * (c - 5) + c) := by
  rw [Matrix.det_fin_two]
  simp only [gramMatrix_apply, descFamily2, Matrix.cons_val_zero, Matrix.cons_val_one]
  exact hB.gram_level_two_det hB1

/-- **Generic PBW at level 2.**  If the level-2 Kac polynomial `2h(16h² + 2h(c-5) + c)` is
nonzero, then `L₋₂|c,h⟩` and `L₋₁²|c,h⟩` are linearly independent, so `dim V₂ = 2 = p(2)`.

The hypothesis is a nonvanishing *polynomial* in `(c,h)`, hence holds at generic `(c,h)`; it
fails exactly on the level-2 Kac locus (`h = 0` or `h = h₁₂, h₂₁`), where these two vectors may
still be independent but the Shapovalov form degenerates.  This is a *substitute* for the
linear-independence half of PBW, not a proof of it: it assumes a normalised contravariant form
exists, which is equivalent to `hwv ≠ 0` (`exists_isContravariant_iff_hwv_ne_zero`). -/
theorem IsContravariant.linearIndependent_descFamily2 [NoZeroDivisors R]
    (hB : IsContravariant R c h B) (hB1 : B (hwv R c h) (hwv R c h) = 1)
    (hdet : 2 * h * (16 * h ^ 2 + 2 * h * (c - 5) + c) ≠ 0) :
    LinearIndependent R (descFamily2 R c h) :=
  linearIndependent_of_gram_det_ne_zero B _ (by
    rw [hB.gram_det_descFamily2 hB1]; exact hdet)

end Level2

end Virasoro

end StringFormal
