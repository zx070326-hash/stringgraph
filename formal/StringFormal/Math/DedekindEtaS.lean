/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import Mathlib.NumberTheory.ModularForms.Discriminant

/-!
# The Dedekind eta S-transformation in the string-theory normalisation

Graph node: `math.dedekind-eta-s-transformation`
(`η(−1/τ) = (−iτ)^{1/2} η(τ)`, principal branch, `Im τ > 0`).

## What is actually proved here, and where the content comes from

The mathematical content is **entirely Mathlib's**: `v4.33.1` contains

* `ModularForm.eta` (`Mathlib/NumberTheory/ModularForms/DedekindEta.lean`),
  `η(z) = e^{πiz/12} ∏_{n ≥ 1} (1 - q^n)` with `q = e^{2πiz}` — literally the convention of the
  graph node `math.dedekind-eta-function`;
* `ModularForm.eta_comp_eq_csqrt_I_inv`
  (`Mathlib/NumberTheory/ModularForms/Discriminant.lean`), which says
  `η(-1/z) = (√i)⁻¹ · √z · η(z)` on the upper half-plane, where `Complex.sqrt w = w ^ (2⁻¹ : ℂ)`
  is the principal branch.

What is missing is only the *normalisation*: string-theory texts (Polchinski (7.2.44b)) write the
automorphy factor as `(−iτ)^{1/2}` rather than as `(√i)⁻¹ √τ`. The two agree pointwise on `H`
because `arg(−iz) = arg z − π/2 ∈ (−π/2, π/2)` there, so the principal logarithm is additive:
`log(−iz) = log(−i) + log z`. That is `csqrt_neg_I_mul` below, and it is the only genuinely new
step in this file.

## Main results

* `csqrt_neg_I_mul` : `√(−i z) = (√i)⁻¹ √z` for `0 < z.im` (principal branch).
* `eta_neg_inv` : `η(−z⁻¹) = (−i z)^{1/2} · η(z)` for `0 < z.im` — the graph statement verbatim.
* `eta_S` : the same for `τ : ℍ`.
* `norm_eta_neg_inv_sq`, `norm_eta_neg_inv_pow_four` : `|η(−1/τ)|⁴ = |τ|² |η(τ)|⁴`.
* `im_mul_norm_eta_pow_four_S_invariant` : `Im(−1/τ) · |η(−1/τ)|⁴ = Im τ · |η(τ)|⁴`, i.e. the
  `S`-invariance of `τ₂ |η(τ)|⁴` — the form in which the transformation is used downstream
  (one-loop modular invariance).

## What is *not* here

* The `T`-transformation `η(τ+1) = e^{iπ/12} η(τ)` (graph node
  `math.dedekind-eta-t-transformation`); Mathlib has no `eta_T` either.
* The multiplier system for a general element of `SL(2,ℤ)` (Dedekind sums).
* Full modular invariance of `τ₂ |η|⁴`: that needs the `T` half plus
  `worldsheet.modular-group-generated-by-s-and-t`.
-/

namespace StringFormal.DedekindEta

open Complex
open scoped Real

/-- `√(−i) = (√i)⁻¹` for the principal branch. -/
lemma csqrt_neg_I : Complex.sqrt (-I) = (Complex.sqrt I)⁻¹ := by
  have h : Complex.sqrt (-I) * Complex.sqrt I = 1 := by
    rw [sqrt_eq_exp (neg_ne_zero.mpr I_ne_zero), sqrt_eq_exp I_ne_zero, ← Complex.exp_add,
      Complex.log_I, Complex.log_neg_I]
    rw [show -((π : ℂ) / 2) * I / 2 + (π : ℂ) / 2 * I / 2 = 0 by ring, Complex.exp_zero]
  exact eq_inv_of_mul_eq_one_left h

/-- On the upper half-plane the principal square root is multiplicative against `-i`:
`√(−i z) = (√i)⁻¹ √z`.  This is the only step needed to pass from Mathlib's normalisation of the
`η` transformation law to the string-theory one. -/
lemma csqrt_neg_I_mul {z : ℂ} (hz : 0 < z.im) :
    Complex.sqrt (-I * z) = (Complex.sqrt I)⁻¹ * Complex.sqrt z := by
  have hz0 : z ≠ 0 := by
    intro h
    rw [h] at hz
    simp at hz
  have hlog : Complex.log (-I * z) = Complex.log (-I) + Complex.log z := by
    refine Complex.log_mul (neg_ne_zero.mpr I_ne_zero) hz0 ?_
    rw [Complex.arg_neg_I]
    have h1 : 0 ≤ Complex.arg z := Complex.arg_nonneg_iff.2 hz.le
    have h2 : Complex.arg z ≤ π := Complex.arg_le_pi z
    have h3 : (0 : ℝ) < π := Real.pi_pos
    constructor <;> simp <;> linarith
  rw [sqrt_eq_exp (mul_ne_zero (neg_ne_zero.mpr I_ne_zero) hz0), hlog, add_div, Complex.exp_add,
    ← sqrt_eq_exp (neg_ne_zero.mpr I_ne_zero), ← sqrt_eq_exp hz0, csqrt_neg_I]

/-- **The Dedekind eta S-transformation, string-theory normalisation.**
For `Im z > 0`, `η(−1/z) = (−i z)^{1/2} η(z)`, the exponent being the principal branch
(`Re(−iz) = Im z > 0`, so `−iz` lies in the right half-plane). -/
theorem eta_neg_inv {z : ℂ} (hz : 0 < z.im) :
    ModularForm.eta (-z⁻¹) = (-I * z) ^ ((1 : ℂ) / 2) * ModularForm.eta z := by
  have h := ModularForm.eta_comp_eq_csqrt_I_inv (show z ∈ UpperHalfPlane.upperHalfPlaneSet from hz)
  simp only [Function.comp_apply, Pi.smul_apply, Pi.mul_apply, smul_eq_mul, neg_div,
    one_div] at h
  rw [h, ← mul_assoc, one_div, ← Complex.sqrt, csqrt_neg_I_mul hz]

/-- The `S`-transformation for `τ : ℍ`: `η(−1/τ) = (−iτ)^{1/2} η(τ)`. -/
theorem eta_S (τ : UpperHalfPlane) :
    ModularForm.eta (-(τ : ℂ)⁻¹) = (-I * (τ : ℂ)) ^ ((1 : ℂ) / 2) * ModularForm.eta (τ : ℂ) :=
  eta_neg_inv τ.im_pos

/-- The square of the principal square root. -/
private lemma csqrt_sq {w : ℂ} (hw : w ≠ 0) : Complex.sqrt w ^ 2 = w := by
  rw [sqrt_eq_exp hw, ← Complex.exp_nsmul]
  rw [show (2 : ℕ) • (Complex.log w / 2) = Complex.log w by
    rw [nsmul_eq_mul]; push_cast; ring]
  exact Complex.exp_log hw

/-- `|η(−1/τ)|² = |τ| · |η(τ)|²`. -/
theorem norm_eta_neg_inv_sq {z : ℂ} (hz : 0 < z.im) :
    ‖ModularForm.eta (-z⁻¹)‖ ^ 2 = ‖z‖ * ‖ModularForm.eta z‖ ^ 2 := by
  have hz0 : z ≠ 0 := by
    intro h
    rw [h] at hz
    simp at hz
  have hw : (-I * z) ≠ 0 := mul_ne_zero (neg_ne_zero.mpr I_ne_zero) hz0
  have hsq : ‖Complex.sqrt (-I * z)‖ ^ 2 = ‖z‖ := by
    rw [← norm_pow, csqrt_sq hw, norm_mul, norm_neg, norm_I, one_mul]
  rw [eta_neg_inv hz, one_div, ← Complex.sqrt, norm_mul, mul_pow, hsq]

/-- `|η(−1/τ)|⁴ = |τ|² |η(τ)|⁴`: the form quoted in the graph statement. -/
theorem norm_eta_neg_inv_pow_four {z : ℂ} (hz : 0 < z.im) :
    ‖ModularForm.eta (-z⁻¹)‖ ^ 4 = ‖z‖ ^ 2 * ‖ModularForm.eta z‖ ^ 4 := by
  have h := norm_eta_neg_inv_sq hz
  have : ‖ModularForm.eta (-z⁻¹)‖ ^ 4 = (‖ModularForm.eta (-z⁻¹)‖ ^ 2) ^ 2 := by ring
  rw [this, h]
  ring

/-- **`S`-invariance of `τ₂ |η(τ)|⁴`.**  This is the shape in which the `η` transformation law
enters one-loop modular invariance. -/
theorem im_mul_norm_eta_pow_four_S_invariant {z : ℂ} (hz : 0 < z.im) :
    (-z⁻¹).im * ‖ModularForm.eta (-z⁻¹)‖ ^ 4 = z.im * ‖ModularForm.eta z‖ ^ 4 := by
  have hz0 : z ≠ 0 := by
    intro h
    rw [h] at hz
    simp at hz
  have him : (-z⁻¹).im = z.im / ‖z‖ ^ 2 := by
    simp only [Complex.neg_im, Complex.inv_im, Complex.normSq_eq_norm_sq]
    ring
  have hnorm : ‖z‖ ≠ 0 := norm_ne_zero_iff.mpr hz0
  rw [him, norm_eta_neg_inv_pow_four hz]
  field_simp

end StringFormal.DedekindEta
