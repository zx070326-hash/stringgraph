/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import Mathlib.NumberTheory.ModularForms.DedekindEta

/-!
# Bridge layer: Mathlib objects restated verbatim in the graph's conventions

Graph nodes: `math.dedekind-eta-function`, `worldsheet.modular-group-psl2z`.

## Why this file exists

Both cards are **definition** cards whose objects already exist in Mathlib.  The graph tooling
requires `formal.lean_decl` to name a declaration living under `formal/` (`lean_file` must be a
path inside this repository), so a card cannot point directly at `ModularForm.eta` or at
`Matrix.ProjectiveSpecialLinearGroup`.  Rather than re-defining the objects (which would create a
second, unverified copy), this file contains a **thin bridge**: for each card, one or more
theorems that state the card's formula *verbatim* and whose proof is "this is Mathlib's
definition".

**Bridge-layer rule** (see `formal/CLAUDE.md`): if Mathlib already has the definition or theorem,
do not re-define it — state one verbatim restatement here under `StringFormal.Bridge` and let the
card's `lean_decl` point at that restatement.

## Main results

### `math.dedekind-eta-function`

* `dedekindEta_eq_qpow_mul_tprod` : `η(z) = q^{1/24} ∏_{n ≥ 0} (1 − q^{n+1})` with Mathlib's
  `Function.Periodic.qParam`, i.e. the unfolding of `ModularForm.eta`.
* `qParam_one_eq_exp`, `qParam_24_eq_exp`, `qParam_24_eq_exp_pi_I_div_twelve` : the card's
  branch conventions `q = e^{2πiτ}` and `q^{1/24} = e^{2πiτ/24} = e^{πiτ/12}`.
* `dedekindEta_eq_exp_mul_tprod` : the card's formula with every `q` expanded into `exp`,
  `η(τ) = e^{πiτ/12} ∏_{n ≥ 1} (1 − e^{2πiτ n})`.
* `dedekindEta_ne_zero`, `differentiableAt_dedekindEta` : the two analytic assertions the card
  makes about `η` on `H` (no zeros; holomorphic).

## What is *not* claimed here

Nothing about modular transformations of `η` (those are `StringFormal/Math/DedekindEta{S,T}.lean`
and the corresponding cards), and nothing about `η` as a weight-`1/2` modular form.
-/

namespace StringFormal.Bridge

open Complex ModularForm
open scoped Real

/-! ### `math.dedekind-eta-function` -/

/-- **The Dedekind eta function of the graph card is Mathlib's `ModularForm.eta`.**

`η(z) = q^{1/24} ∏_{n = 0}^{∞} (1 − q^{n+1})`, where `𝕢 h z = exp (2πi z / h)`, so that
`Function.Periodic.qParam 24 z = q^{1/24}` and `Function.Periodic.qParam 1 z = q`.  This is
literally Mathlib's definition of `ModularForm.eta`; it is stated here so that the graph card
`math.dedekind-eta-function` has a declaration under `formal/` to point at. -/
theorem dedekindEta_eq_qpow_mul_tprod (z : ℂ) :
    ModularForm.eta z =
      Function.Periodic.qParam 24 z * ∏' n : ℕ, (1 - Function.Periodic.qParam 1 z ^ (n + 1)) :=
  rfl

/-- `q = e^{2πiτ}` — the card's normalisation of `q`. -/
theorem qParam_one_eq_exp (z : ℂ) :
    Function.Periodic.qParam 1 z = Complex.exp (2 * π * I * z) := by
  simp [Function.Periodic.qParam]

/-- `q^{1/24} = e^{2πiτ/24}` — the card's *choice of branch* for the 24th root: it is the
single-valued function `exp (2πiτ/24)`, not a multivalued radical. -/
theorem qParam_24_eq_exp (z : ℂ) :
    Function.Periodic.qParam 24 z = Complex.exp (2 * π * I * z / 24) := rfl

/-- `q^{1/24} = e^{πiτ/12}`, the form in which the prefactor is usually written in string
theory (Polchinski (7.2.10)). -/
theorem qParam_24_eq_exp_pi_I_div_twelve (z : ℂ) :
    Function.Periodic.qParam 24 z = Complex.exp (π * I * z / 12) := by
  rw [qParam_24_eq_exp]
  ring_nf

/-- **The card's formula with all `q`'s expanded.**

`η(τ) = e^{πiτ/12} ∏_{n = 0}^{∞} (1 − (e^{2πiτ})^{n+1})`, i.e.
`η(τ) = q^{1/24} ∏_{n ≥ 1} (1 − q^n)` with `q = e^{2πiτ}` and `q^{1/24} = e^{πiτ/12}`. -/
theorem dedekindEta_eq_exp_mul_tprod (z : ℂ) :
    ModularForm.eta z =
      Complex.exp (π * I * z / 12) *
        ∏' n : ℕ, (1 - Complex.exp (2 * π * I * z) ^ (n + 1)) := by
  rw [dedekindEta_eq_qpow_mul_tprod, qParam_24_eq_exp_pi_I_div_twelve, qParam_one_eq_exp]

/-- **`η` has no zeros on the upper half-plane** — the second analytic assertion of the card
(each factor `1 − q^n` is nonzero and `q^{1/24} ≠ 0`).  Mathlib: `ModularForm.eta_ne_zero`. -/
theorem dedekindEta_ne_zero {z : ℂ} (hz : 0 < z.im) : ModularForm.eta z ≠ 0 :=
  ModularForm.eta_ne_zero hz

/-- **`η` is holomorphic on the upper half-plane** — the first analytic assertion of the card
(locally uniform convergence of the product).  Mathlib:
`ModularForm.differentiableAt_eta_of_mem_upperHalfPlaneSet`. -/
theorem differentiableAt_dedekindEta {z : ℂ} (hz : 0 < z.im) :
    DifferentiableAt ℂ ModularForm.eta z :=
  ModularForm.differentiableAt_eta_of_mem_upperHalfPlaneSet hz

end StringFormal.Bridge
