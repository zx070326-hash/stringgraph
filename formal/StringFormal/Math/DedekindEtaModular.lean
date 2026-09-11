/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import StringFormal.Math.DedekindEtaS
import StringFormal.Math.DedekindEtaT
import StringFormal.Math.ModularGroupGenerators

/-!
# Full `SL(2,ℤ)` invariance of `τ₂ |η(τ)|⁴`

Graph nodes: `math.dedekind-eta-s-transformation`, `math.dedekind-eta-t-transformation`,
`worldsheet.modular-group-generated-by-s-and-t` (this file is where the last one is *used*;
it is proved in `StringFormal/Math/ModularGroupGenerators.lean`).

`StringFormal/Math/DedekindEtaS.lean` and `StringFormal/Math/DedekindEtaT.lean` prove that
`τ ↦ Im τ · ‖η(τ)‖⁴` is invariant under the two generators

* `S · τ = −1/τ` (`im_mul_norm_eta_pow_four_modular_S_smul`), and
* `T · τ = τ + 1` (`im_mul_norm_eta_pow_four_modular_T_smul`).

This file upgrades that to invariance under **every** `g ∈ SL(2,ℤ)`.

## Where the group theory comes from

Mathlib `v4.33.1` already contains the generation statement:

```
SpecialLinearGroup.SL2Z_generators : Subgroup.closure {ModularGroup.S, ModularGroup.T} = ⊤
```

(`Mathlib/LinearAlgebra/Matrix/FixedDetMatrices.lean`, Chris Birkbeck, proved by a Euclidean
reduction `FixedDetMatrices.induction_on` on integral matrices of determinant `1`).  So the
generation theorem is *not* reproved here; `StringFormal/Math/ModularGroupGenerators.lean`
re-exports it as `ModularGroupGen.sl_closure_S_T` (and pushes it, together with the relations
`S² = (ST)³ = 1`, to `PSL(2,ℤ)`).  The only work in this file is the induction over
`Subgroup.closure`.

## Main results

* `im_mul_norm_eta_pow_four_modular_invariant` :
  `(g • τ).im * ‖η(g • τ)‖⁴ = τ.im * ‖η(τ)‖⁴` for every `g : SL(2,ℤ)`, `τ : ℍ`.
* `norm_eta_pow_four_modular` : the solved form `‖η(g • τ)‖⁴ = (τ.im / (g • τ).im) · ‖η(τ)‖⁴`.
* `im_mul_norm_eta_pow_four_isInvariant` : the same fact packaged as
  "`τ ↦ τ.im * ‖η τ‖⁴` is constant on `SL(2,ℤ)`-orbits".

## Scope remarks

* The statement is about `SL(2,ℤ)`, not `PSL(2,ℤ)`.  Nothing is lost: `−1` acts trivially on `ℍ`,
  so the invariance descends, but the Lean statement quantifies over `SL(2,ℤ)` because that is the
  group Mathlib's action and generation theorem are stated for.
* This gives **no** information about `η` itself under a general `g`: the multiplier system
  (Dedekind sums, a 24-th root of unity times `(cτ+d)^{1/2}`) is still not formalised.  Only the
  modulus `‖η‖`, in the specific combination `τ₂|η|⁴`, is controlled here — which is exactly what
  one-loop modular invariance of the bosonic partition function needs.
-/

namespace StringFormal.DedekindEta

open Complex
open scoped Real MatrixGroups

/-- Invariance of `τ₂ |η(τ)|⁴` under all of `SL(2,ℤ)`, in the `∀ τ` form that the induction over
`Subgroup.closure` needs (the `inv` step applies the inductive hypothesis at a *different* point
`g⁻¹ • τ`, so the quantifier must be inside). -/
theorem im_mul_norm_eta_pow_four_modular_forall (g : SL(2, ℤ)) :
    ∀ τ : UpperHalfPlane,
      (g • τ).im * ‖ModularForm.eta ((g • τ : UpperHalfPlane) : ℂ)‖ ^ 4
        = τ.im * ‖ModularForm.eta (τ : ℂ)‖ ^ 4 := by
  have hg : g ∈ Subgroup.closure ({ModularGroup.S, ModularGroup.T} : Set SL(2, ℤ)) := by
    rw [ModularGroupGen.sl_closure_S_T]
    exact Subgroup.mem_top g
  induction hg using Subgroup.closure_induction with
  | mem x hx =>
      simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hx
      rcases hx with h | h
      · subst h; exact im_mul_norm_eta_pow_four_modular_S_smul
      · subst h; exact im_mul_norm_eta_pow_four_modular_T_smul
  | one => intro τ; rw [one_smul]
  | mul x y _ _ ihx ihy => intro τ; rw [mul_smul, ihx (y • τ), ihy τ]
  | inv x _ ihx =>
      intro τ
      have h := ihx (x⁻¹ • τ)
      rw [smul_inv_smul] at h
      exact h.symm

/-- **Modular invariance of `τ₂ |η(τ)|⁴`.**  For every `g ∈ SL(2,ℤ)` and every `τ` in the upper
half-plane, `Im(g · τ) · ‖η(g · τ)‖⁴ = Im τ · ‖η(τ)‖⁴`.

Together with `Im(g · τ) = Im τ / |cτ + d|²` this is the statement that the one-loop measure
`d²τ / τ₂² · (τ₂ |η|⁴)^{-…}` is modular invariant; the two generator cases are
`DedekindEtaS.im_mul_norm_eta_pow_four_modular_S_smul` and
`DedekindEtaT.im_mul_norm_eta_pow_four_modular_T_smul`, and the passage to all of `SL(2,ℤ)` uses
`ModularGroupGen.sl_closure_S_T`. -/
theorem im_mul_norm_eta_pow_four_modular_invariant (g : SL(2, ℤ)) (τ : UpperHalfPlane) :
    (g • τ).im * ‖ModularForm.eta ((g • τ : UpperHalfPlane) : ℂ)‖ ^ 4
      = τ.im * ‖ModularForm.eta (τ : ℂ)‖ ^ 4 :=
  im_mul_norm_eta_pow_four_modular_forall g τ

/-- The solved form: `‖η(g · τ)‖⁴ = (Im τ / Im(g · τ)) · ‖η(τ)‖⁴`. -/
theorem norm_eta_pow_four_modular (g : SL(2, ℤ)) (τ : UpperHalfPlane) :
    ‖ModularForm.eta ((g • τ : UpperHalfPlane) : ℂ)‖ ^ 4
      = τ.im / (g • τ).im * ‖ModularForm.eta (τ : ℂ)‖ ^ 4 := by
  have hpos : (g • τ).im ≠ 0 := ne_of_gt (g • τ).im_pos
  have h := im_mul_norm_eta_pow_four_modular_invariant g τ
  field_simp
  linarith [h]

/-- The same fact packaged as invariance of the function `τ ↦ Im τ · ‖η(τ)‖⁴` under the
`SL(2,ℤ)`-action on `ℍ`. -/
theorem im_mul_norm_eta_pow_four_isInvariant (g : SL(2, ℤ)) :
    (fun τ : UpperHalfPlane => (g • τ).im * ‖ModularForm.eta ((g • τ : UpperHalfPlane) : ℂ)‖ ^ 4)
      = fun τ : UpperHalfPlane => τ.im * ‖ModularForm.eta (τ : ℂ)‖ ^ 4 :=
  funext (im_mul_norm_eta_pow_four_modular_forall g)

/-- Every power of the invariant is invariant: `(τ₂ |η(τ)|⁴)ⁿ` is `SL(2,ℤ)`-invariant. -/
theorem im_mul_norm_eta_pow_four_pow_modular (g : SL(2, ℤ)) (τ : UpperHalfPlane) (n : ℕ) :
    ((g • τ).im * ‖ModularForm.eta ((g • τ : UpperHalfPlane) : ℂ)‖ ^ 4) ^ n
      = (τ.im * ‖ModularForm.eta (τ : ℂ)‖ ^ 4) ^ n := by
  rw [im_mul_norm_eta_pow_four_modular_invariant]

/-- Expanded form of the previous lemma: `τ₂ⁿ |η(τ)|⁴ⁿ` is `SL(2,ℤ)`-invariant.

At `n = 12` this is `τ₂¹² |η(τ)|⁴⁸`, whose reciprocal is (up to the `τ`-independent constant
`(4π²α')^{-12}`) the integrand of the bosonic one-loop vacuum amplitude,
`Z(τ) = (4π² α' τ₂)^{-12} |η(τ)|^{-48}` — see `im_pow_twelve_mul_norm_eta_pow_48_modular`. -/
theorem im_pow_mul_norm_eta_pow_modular (g : SL(2, ℤ)) (τ : UpperHalfPlane) (n : ℕ) :
    (g • τ).im ^ n * ‖ModularForm.eta ((g • τ : UpperHalfPlane) : ℂ)‖ ^ (4 * n)
      = τ.im ^ n * ‖ModularForm.eta (τ : ℂ)‖ ^ (4 * n) := by
  have h := im_mul_norm_eta_pow_four_pow_modular g τ n
  rwa [mul_pow, mul_pow, ← pow_mul, ← pow_mul] at h

/-- **The `τ`-dependent part of the bosonic torus partition function is modular invariant.**
`τ₂¹² |η(τ)|⁴⁸` is `SL(2,ℤ)`-invariant, hence so is its reciprocal
`τ₂^{-12} |η(τ)|^{-48}`, which is the bosonic one-loop integrand up to the constant
`(4π²α')^{-12}`.

Caveat about what this does *and does not* say: the full statement of one-loop modular invariance
also requires invariance of the measure `d²τ / τ₂²`, which is a fact about the `SL(2,ℤ)`-action on
`ℍ` and is **not** formalised here; and `D = 26` enters only through the exponent `12 = (D − 2)/2`,
which is an input, not an output, of this lemma. -/
theorem im_pow_twelve_mul_norm_eta_pow_48_modular (g : SL(2, ℤ)) (τ : UpperHalfPlane) :
    (g • τ).im ^ 12 * ‖ModularForm.eta ((g • τ : UpperHalfPlane) : ℂ)‖ ^ 48
      = τ.im ^ 12 * ‖ModularForm.eta (τ : ℂ)‖ ^ 48 :=
  im_pow_mul_norm_eta_pow_modular g τ 12

end StringFormal.DedekindEta
