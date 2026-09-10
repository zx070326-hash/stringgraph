/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import Mathlib.LinearAlgebra.Vandermonde
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse

/-!
# Two algebraic lemmas behind tree-level open-string amplitudes

This is a standalone island (imports only Mathlib; imports nothing from `StringFormal`).
It collects the two purely algebraic facts that the §6 amplitude branch of the graph rests on.

## A. Möbius three-point fixing

Suggested graph node: `math.mobius-three-point-fixing-jacobian`.

An infinitesimal `PSL(2,ℝ)` / `PSL(2,ℂ)` transformation of the boundary coordinate is
`δz = a₀ + a₁ z + a₂ z²`.  Fixing three punctures `z₁, z₂, z₃` amounts to solving the linear
system `a₀ + a₁ zᵢ + a₂ zᵢ² = wᵢ` for `(a₀, a₁, a₂)`; its matrix is the 3×3 Vandermonde matrix
and its determinant is

  `det [[1, z₁, z₁²], [1, z₂, z₂²], [1, z₃, z₃²]] = (z₂ - z₁) (z₃ - z₁) (z₃ - z₂)`,

so the gauge fixing is possible and unique exactly when the three points are pairwise
distinct.  Up to sign this is the Faddeev–Popov Jacobian `|z₁₂ z₁₃ z₂₃|` multiplying the
Koba–Nielsen integrand.

## B. Mandelstam sum rule

Suggested graph node: `spectrum.mandelstam-invariants-sum-rule`.

For four momenta with `Σ kᵢ = 0` and `kᵢ² = -mᵢ²` (mostly-plus signature,
`graph/conventions/metric-signature`), the invariants
`s = -(k₁+k₂)²`, `t = -(k₁+k₃)²`, `u = -(k₁+k₄)²` satisfy `s + t + u = Σ mᵢ²`.
Specialised to four open-string tachyons, `α' mᵢ² = -1`, this gives `α'(s+t+u) = -4`,
i.e. `α_c(s) + α_c(t) + α_c(u) = -1` for the Regge trajectory `α_c(x) = 1 + α' x`.

## Status

Part A is proved.  Part B is added in a following commit.  Nothing here is `sorry`ed:
declarations appear only once proved.
-/

namespace StringFormal.Math

open Matrix

/-! ### A. The Möbius three-point fixing Jacobian -/

section Mobius

variable {K : Type*} [CommRing K]

/-- The `3 × 3` matrix of the linear system `a₀ + a₁ zᵢ + a₂ zᵢ² = wᵢ` is the Vandermonde
matrix of `z`.  Spelled out for readability. -/
theorem vandermonde_fin_three (z : Fin 3 → K) :
    Matrix.vandermonde z = !![1, z 0, z 0 ^ 2; 1, z 1, z 1 ^ 2; 1, z 2, z 2 ^ 2] := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp

/-- **Möbius three-point fixing Jacobian.**  The determinant of the `3 × 3` matrix whose rows
are `(1, zᵢ, zᵢ²)` is `(z₂ - z₁)(z₃ - z₁)(z₃ - z₂)`.  This is the `n = 3` case of
`Matrix.det_vandermonde`; with `z 0 = z₁`, `z 1 = z₂`, `z 2 = z₃` it is the Jacobian of the
`PSL(2)` gauge fixing of three punctures, i.e. the Faddeev–Popov factor accompanying the
Koba–Nielsen integrand. -/
theorem mobius_three_point_jacobian (z : Fin 3 → K) :
    (Matrix.vandermonde z).det = (z 1 - z 0) * (z 2 - z 0) * (z 2 - z 1) := by
  rw [Matrix.det_vandermonde]
  simp only [Fin.prod_univ_three,
    show Finset.Ioi (0 : Fin 3) = {1, 2} from by decide,
    show Finset.Ioi (1 : Fin 3) = {2} from by decide,
    show Finset.Ioi (2 : Fin 3) = (∅ : Finset (Fin 3)) from by decide,
    Finset.prod_pair (show (1 : Fin 3) ≠ 2 from by decide),
    Finset.prod_singleton, Finset.prod_empty]
  ring

/-- The same determinant with the three points spelled out as separate variables. -/
theorem det_mobius_matrix (z₁ z₂ z₃ : K) :
    (!![1, z₁, z₁ ^ 2; 1, z₂, z₂ ^ 2; 1, z₃, z₃ ^ 2] : Matrix (Fin 3) (Fin 3) K).det
      = (z₂ - z₁) * (z₃ - z₁) * (z₃ - z₂) := by
  rw [Matrix.det_fin_three]
  simp
  ring

/-- Sign bookkeeping: in terms of the physicists' `z_{ij} = zᵢ - zⱼ`, the determinant is
`-z₁₂ z₁₃ z₂₃`.  The Faddeev–Popov factor quoted in the literature is the absolute value
`|z₁₂ z₁₃ z₂₃|`, so the sign here is convention-dependent (it flips under a transposition of
two punctures) and must not be read as part of the physical statement. -/
theorem mobius_three_point_jacobian_eq_neg (z : Fin 3 → K) :
    (Matrix.vandermonde z).det = -((z 0 - z 1) * (z 0 - z 2) * (z 1 - z 2)) := by
  rw [mobius_three_point_jacobian]; ring

end Mobius

section MobiusField

variable {K : Type*} [Field K] {z : Fin 3 → K}

/-- The Jacobian is nonzero exactly when the three punctures are pairwise distinct. -/
theorem mobius_three_point_det_ne_zero
    (h01 : z 0 ≠ z 1) (h02 : z 0 ≠ z 2) (h12 : z 1 ≠ z 2) :
    (Matrix.vandermonde z).det ≠ 0 := by
  rw [Matrix.det_vandermonde_ne_zero_iff]
  intro i j hij
  fin_cases i <;> fin_cases j <;> simp_all

/-- **Three-point gauge fixing is possible and unique.**  For pairwise distinct punctures the
linear map sending the parameters `(a₀, a₁, a₂)` of an infinitesimal Möbius transformation
`δz = a₀ + a₁ z + a₂ z²` to its values at the three punctures is a bijection.  Injectivity is
"no residual gauge freedom fixes the three points", surjectivity is "any three prescribed
displacements are attainable". -/
theorem mobius_three_point_fixing_bijective
    (h01 : z 0 ≠ z 1) (h02 : z 0 ≠ z 2) (h12 : z 1 ≠ z 2) :
    Function.Bijective
      (fun a : Fin 3 → K => fun i : Fin 3 => a 0 + a 1 * z i + a 2 * z i ^ 2) := by
  have hEq : (fun a : Fin 3 → K => fun i : Fin 3 => a 0 + a 1 * z i + a 2 * z i ^ 2)
      = (Matrix.vandermonde z).mulVec := by
    funext a i
    simp [Matrix.mulVec, dotProduct, Fin.sum_univ_three]
    ring
  rw [hEq]
  have hu : IsUnit (Matrix.vandermonde z) :=
    (Matrix.isUnit_iff_isUnit_det _).mpr
      (isUnit_iff_ne_zero.mpr (mobius_three_point_det_ne_zero h01 h02 h12))
  exact ⟨Matrix.mulVec_injective_iff_isUnit.mpr hu, Matrix.mulVec_surjective_iff_isUnit.mpr hu⟩

end MobiusField

end StringFormal.Math
