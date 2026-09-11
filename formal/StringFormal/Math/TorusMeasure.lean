/-
Modular invariance of the torus measure `dτ dτ̄ / τ₂²`.

Graph node: `spectrum.torus-measure-modular-invariant`
  (Polchinski vol. 1, §7.3, eq. (7.3.7): "it is easy to check that dτdτ̄/τ₂² is
   modular-invariant as well" — the book gives no computation).

Conventions: `conv.worldsheet-euclidean`, `conv.worldsheet-complex-coords`.  The card is a
*ratio* identity, so the normalisation `d²τ = 2 dτ₁dτ₂` versus `d²τ = dτ₁dτ₂` is irrelevant
(the constant cancels on both sides); nothing here depends on it.

Status: complete, no `sorry`.  Two layers:
* pointwise/algebraic, proved from scratch here: `mobius_deriv` (`dτ'/dτ = 1/(cτ+d)²`),
  `im_smul_mul_normSq` (`τ₂' |cτ+d|² = τ₂`), and the card's identity
  `measure_density_modular_invariant` (`|dτ'/dτ|² / (τ₂')² = 1/τ₂²`);
* measure-theoretic: `measure_smul_eq` / `lintegral_inv_im_sq_smul`, i.e. `vol(g·s) = vol(s)`
  for `vol = dτ₁dτ₂/τ₂²`.  This layer is a *restatement of Mathlib*
  (`Mathlib.Analysis.Complex.UpperHalfPlane.Measure`, David Loeffler 2026), which already
  proves `SMulInvariantMeasure (GL (Fin 2) ℝ) ℍ volume` by the Jacobian change-of-variables
  formula; the only work here is `volume_eq_lintegral_inv_im_sq` (pinning Mathlib's weight
  `(1/‖y‖₊)²` to the card's `1/τ₂²`) and the transport `GL(2,ℝ) ⇝ SL(2,ℤ)`.

Gaps / what is *not* proved here:
* No statement about `τ₂|η(τ)|⁴` (that is `math.eta-modular-invariant-combination`,
  `StringFormal/Math/DedekindEtaModular.lean`); this file is η-free.
* No fundamental domain, no convergence of any integral, no uniqueness of the invariant
  density (the card explicitly excludes all three).
* Orientation: the measure layer is stated for the *positive* measure `dτ₁dτ₂/τ₂²`, i.e. for
  `|dτ ∧ dτ̄|`, not for the oriented 2-form `dτ ∧ dτ̄`.  `SL(2,ℤ)` acts holomorphically hence
  orientation-preservingly, so the signed statement follows, but it is not formalised.
-/
import Mathlib.Analysis.Calculus.Deriv.Inv
import Mathlib.Analysis.Complex.UpperHalfPlane.MoebiusAction
import Mathlib.Analysis.Complex.UpperHalfPlane.Measure

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

section Measure

open MeasureTheory
open scoped NNReal ENNReal Pointwise

/-- The weight appearing in Mathlib's `UpperHalfPlane` volume, `(1/‖y‖₊)²`, is the card's
density `1/τ₂²`.  (Unconditional: at `y = 0` both sides are `0`.) -/
theorem coe_inv_nnnorm_sq (x : ℝ) :
    (((1 / ‖x‖₊) ^ 2 : ℝ≥0) : ℝ≥0∞) = ENNReal.ofReal (1 / x ^ 2) := by
  have h : (1 / ‖x‖₊ : ℝ≥0) ^ 2 = Real.toNNReal (1 / x ^ 2) := by
    apply NNReal.coe_injective
    rw [Real.coe_toNNReal _ (by positivity)]
    push_cast
    rw [Real.norm_eq_abs, div_pow, one_pow, sq_abs]
  rw [h]
  rfl

/-- **Mathlib's `ℍ`-volume is the card's measure `dτ₁ dτ₂ / τ₂²`.**  Restatement of
`UpperHalfPlane.volume_eq_lintegral` with the weight written as `1/τ₂²`:
`vol(s) = ∫_{s ⊆ ℂ} dτ₁dτ₂ / τ₂²`, the outer integral being the plain Lebesgue `volume` on `ℂ`. -/
theorem volume_eq_lintegral_inv_im_sq (s : Set ℍ) :
    (volume : Measure ℍ) s
      = ∫⁻ z : ℂ in ((↑) : ℍ → ℂ) '' s, ENNReal.ofReal (1 / z.im ^ 2) := by
  rw [UpperHalfPlane.volume_eq_lintegral]
  exact lintegral_congr fun z => coe_inv_nnnorm_sq z.im

/-- The measure `dτ₁dτ₂/τ₂²` is `SL(2,ℤ)`-invariant, transported from Mathlib's
`GL(2,ℝ)`-invariance along `ModularGroup.sl_moeb : g • z = (g : GL (Fin 2) ℝ) • z`. -/
instance : SMulInvariantMeasure SL(2, ℤ) ℍ (volume : Measure ℍ) where
  measure_preimage_smul g _ hs :=
    SMulInvariantMeasure.measure_preimage_smul (g : GL (Fin 2) ℝ) hs

/-- **The card, measure-theoretically.**  For every `g ∈ SL(2,ℤ)` and every `s ⊆ H`,
`vol(g·s) = vol(s)` for the measure `dτ dτ̄ / τ₂²`.  No measurability hypothesis is needed
(`MeasureTheory.measure_smul`).  The change-of-variables content is Mathlib's
(`Mathlib.Analysis.Complex.UpperHalfPlane.Measure`, via the Jacobian formula
`lintegral_image_eq_lintegral_abs_det_fderiv_mul`); what is added here is only the
identification with Polchinski (7.3.7). -/
theorem measure_smul_eq (g : SL(2, ℤ)) (s : Set ℍ) :
    (volume : Measure ℍ) (g • s) = volume s :=
  measure_smul volume g s

/-- **The card spelled out on subsets of `ℂ`**:
`∫_{g·s} dτ₁dτ₂/τ₂² = ∫_s dτ₁dτ₂/τ₂²` for every `g ∈ SL(2,ℤ)` and every `s ⊆ H`. -/
theorem lintegral_inv_im_sq_smul (g : SL(2, ℤ)) (s : Set ℍ) :
    ∫⁻ z : ℂ in ((↑) : ℍ → ℂ) '' (g • s), ENNReal.ofReal (1 / z.im ^ 2)
      = ∫⁻ z : ℂ in ((↑) : ℍ → ℂ) '' s, ENNReal.ofReal (1 / z.im ^ 2) := by
  rw [← volume_eq_lintegral_inv_im_sq, ← volume_eq_lintegral_inv_im_sq, measure_smul_eq]

end Measure

end StringFormal.TorusMeasure
