/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import Mathlib.LinearAlgebra.Vandermonde
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
import Mathlib.LinearAlgebra.Matrix.BilinearForm
import Mathlib.Tactic.Abel
import Mathlib.Tactic.LinearCombination

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
For four closed-string tachyons, `α' mᵢ² = -4`, the same substitution gives `α'(s+t+u) = -16`.

## Status

Both parts are proved, `sorry`-free, with the standard axioms only.
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

/-! ### B. The Mandelstam sum rule -/

section Mandelstam

variable {K : Type*} [CommRing K] {M : Type*} [AddCommGroup M] [Module K M]

/-- `s = -(k₁+k₂)²` for four momenta `k : Fin 4 → M` measured with the bilinear form `B`.
Indices are `0`-based, so `k 0 = k₁`, …, `k 3 = k₄`.  The overall minus sign is the
mostly-plus convention `conv.metric-mostly-plus`: with `η = (-,+,…,+)` an on-shell momentum
has `k² = -m²`, and `s` is defined so that it is `+M²` for a timelike total momentum. -/
def mandelstamS (B : LinearMap.BilinForm K M) (k : Fin 4 → M) : K := -B (k 0 + k 1) (k 0 + k 1)

/-- `t = -(k₁+k₃)²`; see `mandelstamS`. -/
def mandelstamT (B : LinearMap.BilinForm K M) (k : Fin 4 → M) : K := -B (k 0 + k 2) (k 0 + k 2)

/-- `u = -(k₁+k₄)²`; see `mandelstamS`. -/
def mandelstamU (B : LinearMap.BilinForm K M) (k : Fin 4 → M) : K := -B (k 0 + k 3) (k 0 + k 3)

/-- **Mandelstam sum rule.**  For four momenta with `Σᵢ kᵢ = 0` (all momenta incoming) and
on-shell conditions `kᵢ² = -mᵢ²` (mostly-plus), the three invariants satisfy
`s + t + u = Σᵢ mᵢ²`.

This is pure kinematics: `B` is an arbitrary *symmetric bilinear form* on an arbitrary module,
no nondegeneracy, no signature, no field, not even `2` invertible is needed.  The physical
content that does *not* appear here, and so must be supplied by the graph, is that `B` is the
Minkowski form and that `mᵢ` are the masses of the external states. -/
theorem mandelstam_sum (B : LinearMap.BilinForm K M) (hB : ∀ x y, B x y = B y x)
    (k : Fin 4 → M) (m : Fin 4 → K)
    (hk : ∑ i, k i = 0)
    (hmass : ∀ i, B (k i) (k i) = -(m i) ^ 2) :
    mandelstamS B k + mandelstamT B k + mandelstamU B k = ∑ i, (m i) ^ 2 := by
  rw [Fin.sum_univ_four] at hk
  have hsum : k 1 + k 2 + k 3 = -k 0 := by
    have h : k 0 + (k 1 + k 2 + k 3) = 0 := by rw [← hk]; abel
    exact eq_neg_of_add_eq_zero_right h
  have hcross : B (k 0) (k 1) + B (k 0) (k 2) + B (k 0) (k 3) = -B (k 0) (k 0) := by
    have h : B (k 0) (k 1 + k 2 + k 3) = B (k 0) (-k 0) := by rw [hsum]
    simpa using h
  simp only [mandelstamS, mandelstamT, mandelstamU, map_add, LinearMap.add_apply,
    Fin.sum_univ_four]
  rw [hB (k 1) (k 0), hB (k 2) (k 0), hB (k 3) (k 0)]
  linear_combination (-2 : K) * hcross - hmass 0 - hmass 1 - hmass 2 - hmass 3

/-- **Four open-string tachyons.**  Feeding the ground-state mass shell `α' mᵢ² = -1`
(`conv.alpha-prime-regge` with `N = 0` and intercept `a = 1`, `conv.intercept-sign-a`) into the
sum rule gives `α'(s + t + u) = -4`. -/
theorem mandelstam_sum_four_tachyons (B : LinearMap.BilinForm K M) (hB : ∀ x y, B x y = B y x)
    (k : Fin 4 → M) (m : Fin 4 → K) (α : K)
    (hk : ∑ i, k i = 0)
    (hmass : ∀ i, B (k i) (k i) = -(m i) ^ 2)
    (htach : ∀ i, α * (m i) ^ 2 = -1) :
    α * (mandelstamS B k + mandelstamT B k + mandelstamU B k) = -4 := by
  rw [mandelstam_sum B hB k m hk hmass, Fin.sum_univ_four]
  linear_combination htach 0 + htach 1 + htach 2 + htach 3

/-- Same statement in Regge-trajectory form, with the intercept `a` kept as a parameter:
for `α_c(x) = a + α' x` one gets `α_c(s) + α_c(t) + α_c(u) = 3a - 4`.  Only the `-4` is
kinematics; the value of `a` is the separate proposition `worldsheet.open-string-intercept`. -/
theorem regge_trajectory_sum_four_tachyons (B : LinearMap.BilinForm K M)
    (hB : ∀ x y, B x y = B y x) (k : Fin 4 → M) (m : Fin 4 → K) (α a : K)
    (hk : ∑ i, k i = 0)
    (hmass : ∀ i, B (k i) (k i) = -(m i) ^ 2)
    (htach : ∀ i, α * (m i) ^ 2 = -1) :
    (a + α * mandelstamS B k) + (a + α * mandelstamT B k) + (a + α * mandelstamU B k)
      = 3 * a - 4 := by
  linear_combination mandelstam_sum_four_tachyons B hB k m α hk hmass htach

/-- The open-string case `a = 1`, i.e. `α_c(x) = 1 + α' x`:
`α_c(s) + α_c(t) + α_c(u) = -1`, the constraint behind the Veneziano amplitude's
`s`-`t`-`u` structure. -/
theorem regge_intercept_sum_four_tachyons (B : LinearMap.BilinForm K M)
    (hB : ∀ x y, B x y = B y x) (k : Fin 4 → M) (m : Fin 4 → K) (α : K)
    (hk : ∑ i, k i = 0)
    (hmass : ∀ i, B (k i) (k i) = -(m i) ^ 2)
    (htach : ∀ i, α * (m i) ^ 2 = -1) :
    (1 + α * mandelstamS B k) + (1 + α * mandelstamT B k) + (1 + α * mandelstamU B k) = -1 := by
  have h := regge_trajectory_sum_four_tachyons B hB k m α 1 hk hmass htach
  rw [h]
  norm_num

/-- **Four closed-string tachyons.**  The closed-string ground state has `α' mᵢ² = -4`
(`conv.alpha-prime-regge`: the closed-string mass formula `α' m²/4 = N - a` with `N = Ñ = 0`
and intercept `a = 1`, `conv.intercept-sign-a`), i.e. `α' kᵢ² = 4` in the mostly-plus
convention.  Feeding it into the sum rule gives `α'(s + t + u) = -16`, the constraint behind
the `s`-`t`-`u` structure of the Virasoro–Shapiro amplitude.  The proof is the open-string
one with `-1` replaced by `-4`. -/
theorem mandelstam_sum_four_closed_tachyons (B : LinearMap.BilinForm K M)
    (hB : ∀ x y, B x y = B y x)
    (k : Fin 4 → M) (m : Fin 4 → K) (α : K)
    (hk : ∑ i, k i = 0)
    (hmass : ∀ i, B (k i) (k i) = -(m i) ^ 2)
    (htach : ∀ i, α * (m i) ^ 2 = -4) :
    α * (mandelstamS B k + mandelstamT B k + mandelstamU B k) = -16 := by
  rw [mandelstam_sum B hB k m hk hmass, Fin.sum_univ_four]
  linear_combination htach 0 + htach 1 + htach 2 + htach 3

end Mandelstam

section DiagonalMetric

variable {K : Type*} [CommRing K] {D : ℕ}

/-- The diagonal ("Minkowski", once `η = (-1,1,…,1)`) bilinear form on `Fin D → K`.
Same shape as `StringFormal.NoGhost.DDF.dotVec`; that file is deliberately *not* imported —
islands stay independent — so the agreement is recorded here in `minkowskiForm_apply`. -/
noncomputable def minkowskiForm (η : Fin D → K) : LinearMap.BilinForm K (Fin D → K) :=
  Matrix.toBilin' (Matrix.diagonal η)

@[simp]
theorem minkowskiForm_apply (η x y : Fin D → K) :
    minkowskiForm η x y = ∑ μ, η μ * x μ * y μ := by
  rw [minkowskiForm, Matrix.toBilin'_apply]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.sum_eq_single i]
  · simp only [Matrix.diagonal_apply_eq]; ring
  · intro j _ hj; simp [Matrix.diagonal_apply_ne _ (Ne.symm hj)]
  · simp

theorem minkowskiForm_symm (η x y : Fin D → K) :
    minkowskiForm η x y = minkowskiForm η y x := by
  simp only [minkowskiForm_apply]
  exact Finset.sum_congr rfl fun i _ => by ring

/-- The sum rule for concrete `D`-dimensional momenta and a diagonal metric `η`: entirely
elementary once written out.  Taking `η 0 = -1`, `η μ = 1` for `μ ≥ 1` gives the physical
mostly-plus statement. -/
theorem mandelstam_sum_diagonal_metric (η : Fin D → K) (k : Fin 4 → (Fin D → K))
    (m : Fin 4 → K)
    (hk : ∀ μ, ∑ i, k i μ = 0)
    (hmass : ∀ i, ∑ μ, η μ * k i μ * k i μ = -(m i) ^ 2) :
    (-∑ μ, η μ * (k 0 μ + k 1 μ) * (k 0 μ + k 1 μ))
      + (-∑ μ, η μ * (k 0 μ + k 2 μ) * (k 0 μ + k 2 μ))
      + (-∑ μ, η μ * (k 0 μ + k 3 μ) * (k 0 μ + k 3 μ)) = ∑ i, (m i) ^ 2 := by
  have hk' : ∑ i, k i = 0 := by
    funext μ
    simpa using hk μ
  have hmass' : ∀ i, minkowskiForm η (k i) (k i) = -(m i) ^ 2 := by
    intro i; rw [minkowskiForm_apply]; exact hmass i
  have e : ∀ a b : Fin D → K, (∑ μ, η μ * (a μ + b μ) * (a μ + b μ))
      = minkowskiForm η (a + b) (a + b) := by
    intro a b; rw [minkowskiForm_apply]; simp only [Pi.add_apply]
  rw [e (k 0) (k 1), e (k 0) (k 2), e (k 0) (k 3)]
  exact mandelstam_sum (minkowskiForm η) (minkowskiForm_symm η) k m hk' hmass'

end DiagonalMetric

end StringFormal.Math
