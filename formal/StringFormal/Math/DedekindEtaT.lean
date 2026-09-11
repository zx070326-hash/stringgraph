/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import Mathlib.NumberTheory.ModularForms.DedekindEta
import Mathlib.Analysis.Complex.UpperHalfPlane.MoebiusAction
import Mathlib.Analysis.Complex.Trigonometric

/-!
# The Dedekind eta T-transformation

Graph node: `math.dedekind-eta-t-transformation` (`η(τ + 1) = e^{iπ/12} η(τ)`).

Companion of `StringFormal/Math/DedekindEtaS.lean`, which does the `S`-generator
(`η(−1/τ) = (−iτ)^{1/2} η(τ)`) by renormalising Mathlib's
`ModularForm.eta_comp_eq_csqrt_I_inv`.  Mathlib `v4.33.1` has **no** `eta_T`, so this one is proved
from the definition.

## Method

`ModularForm.eta z = 𝕢 24 z * ∏' n, (1 - (𝕢 1 z) ^ (n + 1))` with
`Function.Periodic.qParam h z = exp (2πi z / h)`.  Under `z ↦ z + 1`:

* `𝕢 1 (z + 1) = 𝕢 1 z` (period `1`), so the infinite product is **termwise** unchanged — no
  convergence input is needed, `tprod_congr` suffices;
* `𝕢 24 (z + 1) = e^{2πi/24} 𝕢 24 z = e^{πi/12} 𝕢 24 z`.

## Scope remark (a genuine strengthening over the graph statement)

The graph card, like every textbook, states the `T`-transformation for `Im τ > 0`.  **The identity
in fact holds for every `z : ℂ`**: `ModularForm.eta` is defined by the same formula off the upper
half-plane, the `q`-periodicity argument never looks at `Im z`, and the `tprod` is compared term by
term (so it does not matter whether the product converges).  `eta_add_one_eq` is the unconditional
version; `eta_add_one` is the graph statement verbatim, with the (unused) hypothesis kept so that
the node and the Lean declaration match literally.

This is a difference in kind from the `S`-transformation, where `Im z > 0` is essential (it is what
puts `−iz` in the right half-plane and makes the principal logarithm additive).

## Main results

* `eta_add_one_eq` : `η(z + 1) = e^{iπ/12} η(z)` for all `z : ℂ`.
* `eta_add_one` : the graph statement, `0 < z.im → η(z + 1) = e^{iπ/12} η(z)`.
* `eta_T`, `eta_modular_T_smul` : the `τ : ℍ` version, and the version phrased with
  `ModularGroup.T • τ` — the form that pairs with `eta_modular_S_smul` under
  `worldsheet.modular-group-generated-by-s-and-t`.
* `norm_eta_add_one` : `‖η(τ + 1)‖ = ‖η(τ)‖`.
* `im_mul_norm_eta_pow_four_T_invariant`, `im_mul_norm_eta_pow_four_modular_T_smul` :
  `T`-invariance of `τ₂ |η(τ)|⁴`.  Together with
  `DedekindEtaS.im_mul_norm_eta_pow_four_modular_S_smul` this gives invariance of `τ₂ |η(τ)|⁴`
  under both generators of `PSL(2,ℤ)` (full modular invariance still needs the generation
  statement, which is not formalised here).

## What is *not* here

* The multiplier system for a general element of `SL(2,ℤ)` (Dedekind sums).
* `worldsheet.modular-group-generated-by-s-and-t` itself.
-/

namespace StringFormal.DedekindEta

open Complex
open scoped Real

local notation "𝕢" => Function.Periodic.qParam

/-- `𝕢 1` has period `1`: `e^{2πi(z+1)} = e^{2πiz}`. -/
lemma qParam_one_add_one (z : ℂ) : 𝕢 1 (z + 1) = 𝕢 1 z := by
  simp only [Function.Periodic.qParam, Complex.ofReal_one, div_one, mul_add, mul_one,
    Complex.exp_add, Complex.exp_two_pi_mul_I, mul_one]

/-- Each factor of the eta product is unchanged by `z ↦ z + 1`. -/
lemma eta_q_add_one (n : ℕ) (z : ℂ) :
    ModularForm.eta_q n (z + 1) = ModularForm.eta_q n z := by
  simp only [ModularForm.eta_q, qParam_one_add_one]

/-- The prefactor picks up exactly `e^{2πi/24} = e^{iπ/12}`. -/
lemma qParam_24_add_one (z : ℂ) :
    𝕢 24 (z + 1) = Complex.exp (π * I / 12) * 𝕢 24 z := by
  simp only [Function.Periodic.qParam, ← Complex.exp_add]
  congr 1
  push_cast
  ring

/-- **The Dedekind eta `T`-transformation**, unconditional form: for *every* `z : ℂ`,
`η(z + 1) = e^{iπ/12} η(z)`.  See the module docstring: the upper half-plane hypothesis of the
textbook statement is not needed. -/
theorem eta_add_one_eq (z : ℂ) :
    ModularForm.eta (z + 1) = Complex.exp (π * I / 12) * ModularForm.eta z := by
  have hprod : ∏' n : ℕ, (1 - ModularForm.eta_q n (z + 1))
      = ∏' n : ℕ, (1 - ModularForm.eta_q n z) :=
    tprod_congr fun n => by rw [eta_q_add_one]
  simp only [ModularForm.eta, hprod, qParam_24_add_one, mul_assoc]

set_option linter.unusedVariables false in
/-- **The Dedekind eta `T`-transformation**, graph statement `math.dedekind-eta-t-transformation`:
for `Im z > 0`, `η(z + 1) = e^{iπ/12} η(z)`.  The hypothesis is kept only to match the node; see
`eta_add_one_eq`. -/
theorem eta_add_one {z : ℂ} (hz : 0 < z.im) :
    ModularForm.eta (z + 1) = Complex.exp (π * I / 12) * ModularForm.eta z :=
  eta_add_one_eq z

/-- The `T`-transformation for `τ : ℍ`. -/
theorem eta_T (τ : UpperHalfPlane) :
    ModularForm.eta ((τ : ℂ) + 1) = Complex.exp (π * I / 12) * ModularForm.eta (τ : ℂ) :=
  eta_add_one_eq _

/-- The same, phrased with the modular group acting on `ℍ`: `η(T · τ) = e^{iπ/12} η(τ)`.
Companion of `StringFormal.DedekindEta.eta_modular_S_smul`. -/
theorem eta_modular_T_smul (τ : UpperHalfPlane) :
    ModularForm.eta ((ModularGroup.T • τ : UpperHalfPlane) : ℂ)
      = Complex.exp (π * I / 12) * ModularForm.eta (τ : ℂ) := by
  rw [UpperHalfPlane.modular_T_smul, UpperHalfPlane.coe_vadd, Complex.ofReal_one, add_comm]
  exact eta_add_one_eq _

/-- The `T`-multiplier is a phase. -/
lemma norm_exp_pi_I_div_twelve : ‖Complex.exp (π * I / 12)‖ = 1 := by
  rw [show (π : ℂ) * I / 12 = ((π / 12 : ℝ) : ℂ) * I by push_cast; ring]
  exact Complex.norm_exp_ofReal_mul_I _

/-- `|η(τ + 1)| = |η(τ)|`. -/
theorem norm_eta_add_one (z : ℂ) :
    ‖ModularForm.eta (z + 1)‖ = ‖ModularForm.eta z‖ := by
  rw [eta_add_one_eq, norm_mul, norm_exp_pi_I_div_twelve, one_mul]

/-- **`T`-invariance of `τ₂ |η(τ)|⁴`.**  With
`DedekindEtaS.im_mul_norm_eta_pow_four_S_invariant` this covers both generators of the modular
group. -/
theorem im_mul_norm_eta_pow_four_T_invariant (z : ℂ) :
    (z + 1).im * ‖ModularForm.eta (z + 1)‖ ^ 4 = z.im * ‖ModularForm.eta z‖ ^ 4 := by
  rw [norm_eta_add_one, Complex.add_im, Complex.one_im, add_zero]

/-- `T`-invariance of `τ₂ |η(τ)|⁴`, phrased with the modular group acting on `ℍ`. -/
theorem im_mul_norm_eta_pow_four_modular_T_smul (τ : UpperHalfPlane) :
    (ModularGroup.T • τ).im * ‖ModularForm.eta ((ModularGroup.T • τ : UpperHalfPlane) : ℂ)‖ ^ 4
      = τ.im * ‖ModularForm.eta (τ : ℂ)‖ ^ 4 := by
  rw [eta_modular_T_smul, UpperHalfPlane.modular_T_smul, UpperHalfPlane.vadd_im, norm_mul,
    norm_exp_pi_I_div_twelve, one_mul]

end StringFormal.DedekindEta
