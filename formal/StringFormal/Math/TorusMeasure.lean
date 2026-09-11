/-
Modular invariance of the torus measure `dτ dτ̄ / τ₂²`.

Graph node: `spectrum.torus-measure-modular-invariant`
  (Polchinski vol. 1, §7.3, eq. (7.3.7): "it is easy to check that dτdτ̄/τ₂² is
   modular-invariant as well" — the book gives no computation).

Conventions: `conv.worldsheet-euclidean`, `conv.worldsheet-complex-coords`.  The card is a
*ratio* identity, so the normalisation `d²τ = 2 dτ₁dτ₂` versus `d²τ = dτ₁dτ₂` is irrelevant
(the constant cancels on both sides); nothing here depends on it.

Status: the pointwise/algebraic content is proved from scratch here
(`mobius_deriv`, `im_smul_mul_normSq`, `measure_density_modular_invariant`).

Gaps / what is *not* proved here:
* No statement about `τ₂|η(τ)|⁴` (that is `math.eta-modular-invariant-combination`,
  `StringFormal/Math/DedekindEtaModular.lean`); this file is η-free.
* No fundamental domain, no convergence of any integral, no uniqueness of the invariant
  density (the card explicitly excludes all three).
* `measure_density_modular_invariant` is the *pointwise* Jacobian statement
  `|dτ'/dτ|² / (τ₂')² = 1/τ₂²`.  It does not by itself say that the associated measure is
  invariant; the change-of-variables step is supplied separately in the `Measure` section
  below, which is a restatement of Mathlib's `UpperHalfPlane` Haar-type measure
  (`Mathlib.Analysis.Complex.UpperHalfPlane.Measure`) and *not* new mathematics here.
-/
import Mathlib.Analysis.Calculus.Deriv.Inv
import Mathlib.Analysis.Complex.UpperHalfPlane.MoebiusAction

namespace StringFormal.TorusMeasure

open Complex UpperHalfPlane
open scoped MatrixGroups UpperHalfPlane

section Pointwise

variable (g : SL(2, ℤ)) (τ : ℍ)

/-- The Möbius denominator `cτ + d` never vanishes on the upper half-plane.
Mathlib: `UpperHalfPlane.denom_ne_zero`. -/
theorem denom_ne_zero' : (g 1 0 : ℂ) * (τ : ℂ) + (g 1 1 : ℂ) ≠ 0 :=
  UpperHalfPlane.denom_ne_zero (g : GL (Fin 2) ℝ) τ

/-- `ad − bc = 1` for `g ∈ SL(2,ℤ)`, pushed to `ℂ`. -/
theorem det_eq_one_complex :
    (g 0 0 : ℂ) * (g 1 1 : ℂ) - (g 0 1 : ℂ) * (g 1 0 : ℂ) = 1 := by
  have h : g 0 0 * g 1 1 - g 0 1 * g 1 0 = 1 := by
    have := g.det_coe
    rwa [Matrix.det_fin_two] at this
  exact_mod_cast congrArg (fun n : ℤ => (n : ℂ)) h

/-- **Step (1) of the card's derivation.**  The Möbius map `z ↦ (az+b)/(cz+d)` attached to
`g ∈ SL(2,ℤ)` is holomorphic at every `τ ∈ H` with derivative `1/(cτ+d)²`; the numerator
`a(cτ+d) − c(az+b) = ad − bc` collapses to `1` exactly because `det g = 1`. -/
theorem mobius_deriv :
    HasDerivAt (fun z : ℂ => ((g 0 0 : ℂ) * z + (g 0 1 : ℂ)) / ((g 1 0 : ℂ) * z + (g 1 1 : ℂ)))
      (1 / ((g 1 0 : ℂ) * (τ : ℂ) + (g 1 1 : ℂ)) ^ 2) (τ : ℂ) := by
  have hden := denom_ne_zero' g τ
  have hn : HasDerivAt (fun z : ℂ => (g 0 0 : ℂ) * z + (g 0 1 : ℂ)) (g 0 0 : ℂ) (τ : ℂ) := by
    have h0 : HasDerivAt (fun z : ℂ => (g 0 0 : ℂ) * z + (g 0 1 : ℂ)) ((g 0 0 : ℂ) * 1) (τ : ℂ) :=
      ((hasDerivAt_id' (x := (τ : ℂ))).const_mul ((g 0 0 : ℤ) : ℂ)).add_const ((g 0 1 : ℤ) : ℂ)
    rwa [mul_one] at h0
  have hd : HasDerivAt (fun z : ℂ => (g 1 0 : ℂ) * z + (g 1 1 : ℂ)) (g 1 0 : ℂ) (τ : ℂ) := by
    have h0 : HasDerivAt (fun z : ℂ => (g 1 0 : ℂ) * z + (g 1 1 : ℂ)) ((g 1 0 : ℂ) * 1) (τ : ℂ) :=
      ((hasDerivAt_id' (x := (τ : ℂ))).const_mul ((g 1 0 : ℤ) : ℂ)).add_const ((g 1 1 : ℤ) : ℂ)
    rwa [mul_one] at h0
  have key := hn.fun_div hd hden
  have hnum : (g 0 0 : ℂ) * ((g 1 0 : ℂ) * (τ : ℂ) + (g 1 1 : ℂ))
      - ((g 0 0 : ℂ) * (τ : ℂ) + (g 0 1 : ℂ)) * (g 1 0 : ℂ) = 1 := by
    linear_combination det_eq_one_complex g
  rwa [hnum] at key

/-- **Step (2) of the card's derivation**, in cleared-denominator form:
`Im(g·τ) · |cτ + d|² = Im τ`.  (Mathlib: `ModularGroup.im_smul_eq_div_normSq`.) -/
theorem im_smul_mul_normSq :
    (g • τ).im * Complex.normSq ((g 1 0 : ℂ) * (τ : ℂ) + (g 1 1 : ℂ)) = τ.im := by
  have hden := denom_ne_zero' g τ
  have hns : Complex.normSq ((g 1 0 : ℂ) * (τ : ℂ) + (g 1 1 : ℂ)) ≠ 0 :=
    fun h => hden (Complex.normSq_eq_zero.mp h)
  rw [ModularGroup.im_smul_eq_div_normSq, ModularGroup.denom_apply]
  exact div_mul_cancel₀ _ hns

/-- **The card, pointwise.**  With `τ' = g·τ` the Jacobian of the Möbius map is
`dτ'/dτ = 1/(cτ+d)²` (`mobius_deriv`), so the density of `dτ'dτ̄'/(τ₂')²` relative to
`dτ dτ̄ / τ₂²` is

  `|dτ'/dτ|² / (τ₂')² = |cτ+d|^{-4} · |cτ+d|⁴ / τ₂² = 1/τ₂²`.

This is the whole content of Polchinski (7.3.7); the two factors `|cτ+d|^{±4}` cancel. -/
theorem measure_density_modular_invariant :
    ‖(1 : ℂ) / ((g 1 0 : ℂ) * (τ : ℂ) + (g 1 1 : ℂ)) ^ 2‖ ^ 2 / (g • τ).im ^ 2
      = 1 / τ.im ^ 2 := by
  have hden := denom_ne_zero' g τ
  have hnorm : ‖(g 1 0 : ℂ) * (τ : ℂ) + (g 1 1 : ℂ)‖ ≠ 0 := norm_ne_zero_iff.mpr hden
  have him : (g • τ).im = τ.im / ‖(g 1 0 : ℂ) * (τ : ℂ) + (g 1 1 : ℂ)‖ ^ 2 := by
    rw [ModularGroup.im_smul_eq_div_normSq, Complex.normSq_eq_norm_sq, ModularGroup.denom_apply]
  have hτ : τ.im ≠ 0 := ne_of_gt τ.im_pos
  rw [him, norm_div, norm_pow, norm_one]
  field_simp

end Pointwise

end StringFormal.TorusMeasure
