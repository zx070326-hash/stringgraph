/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import Mathlib.Analysis.SpecificLimits.Normed
import Mathlib.Analysis.SpecialFunctions.Trigonometric.DerivHyp

/-!
# The exponentially regulated sum `Σ_{n ≥ 1} n e^{-un}` and its Laurent constant `-1/12`

Graph node: `worldsheet.regulated-sum-laurent-expansion` (status `rigorous`).

The card states, for `u > 0`,
`Σ_{n≥1} n e^{-un} = e^{-u}/(1-e^{-u})² = 1/(4 sinh²(u/2)) = 1/u² - 1/12 + O(u²)` as `u → 0⁺`,
i.e. the divergence is `1/u²`, there is **no** `1/u` term, and the constant term is exactly
`-1/12`.

## Main results

* `hasSum_nat_mul_exp_neg_mul`, `tsum_nat_mul_exp_neg_mul` : the closed form
  `Σ_{n≥1} n e^{-un} = e^{-u}/(1-e^{-u})²` (Mathlib's
  `hasSum_coe_mul_geometric_of_norm_lt_one` at `r = e^{-u}`).
* `exp_neg_div_one_sub_sq_eq_inv_sinh_sq`, `tsum_nat_mul_exp_neg_mul_eq_inv_sinh_sq` : the
  `sinh` form `= 1/(4 sinh²(u/2))`.
* `abs_sinh_sub_taylor_le` : `|sinh x - (x + x³/6)| ≤ |x|⁵/100` for `|x| ≤ 1` (from Mathlib's
  `Real.exp_bound` at `n = 5`; the even Taylor terms cancel in `sinh`).
* `tendsto_regulatedSum_sub_inv_sq` : **the card's constant term**,
  `Σ_{n≥1} n e^{-un} - 1/u² → -1/12` as `u → 0⁺`.
  Since the limit of `f(u) - 1/u²` exists and is finite, this simultaneously says there is no
  `1/u` term and pins the constant.

## Conventions / indexing

The sums below run over `n : ℕ` starting at `0`, which is harmless: the `n = 0` summand is
`0 * e^0 = 0`, so `∑' n : ℕ, n e^{-un}` **is** the card's `Σ_{n≥1}`.
This file uses no physics convention; it is a pure analysis lemma (see the card's `notes`).

## What is *not* here

* The `O(u²)` refinement of the remainder (`tendsto_regulatedSum_sub_inv_sq` gives only the
  limit, which is what "the constant term is `-1/12` and there is no `1/u` term" means).
  Upgrading to `Asymptotics.IsBigO` needs the next order of the `sinh` expansion; not done.
* The `θ`-generalisation `Σ_{n≥1}(n-θ)e^{-(n-θ)u}` of Headrick's exercise 1.5.
* **Anything physical.**  Discarding the `1/u²` term and declaring the remaining `-1/12` to be
  the zero-point energy is the separate card `worldsheet.zeta-regularized-sum-of-integers`
  (`physical-argument`), which has no Lean counterpart.  Nothing in this file bears on it.
* The relation to `ζ(-1) = -1/12` (`StringFormal/Math/MathlibBridges.lean`,
  `StringFormal.Bridge.riemannZeta_neg_one`).  That is a *different* theorem about analytic
  continuation; the graph keeps the two on separate cards and so does Lean.
-/

namespace StringFormal.RegulatedSum

open Real Filter Topology

/-! ### The closed form -/

/-- **`Σ_{n≥1} n e^{-un} = e^{-u}/(1-e^{-u})²` for `u > 0`**, as a `HasSum` (so summability is
part of the statement).  This is Mathlib's `hasSum_coe_mul_geometric_of_norm_lt_one` at
`r = e^{-u}`, whose norm is `< 1` exactly because `u > 0`.

First equality of card `worldsheet.regulated-sum-laurent-expansion`. -/
theorem hasSum_nat_mul_exp_neg_mul {u : ℝ} (hu : 0 < u) :
    HasSum (fun n : ℕ => (n : ℝ) * exp (-(u * n))) (exp (-u) / (1 - exp (-u)) ^ 2) := by
  have hr : ‖exp (-u)‖ < 1 := by
    rw [Real.norm_eq_abs, abs_of_pos (exp_pos _)]
    exact exp_lt_one_iff.mpr (by linarith)
  have h := hasSum_coe_mul_geometric_of_norm_lt_one hr
  refine h.congr_fun fun n => ?_
  rw [← Real.exp_nat_mul]
  ring_nf

/-- `tsum` form of `hasSum_nat_mul_exp_neg_mul`. -/
theorem tsum_nat_mul_exp_neg_mul {u : ℝ} (hu : 0 < u) :
    ∑' n : ℕ, (n : ℝ) * exp (-(u * n)) = exp (-u) / (1 - exp (-u)) ^ 2 :=
  (hasSum_nat_mul_exp_neg_mul hu).tsum_eq

/-- **`e^{-u}/(1-e^{-u})² = 1/(4 sinh²(u/2))`** for `u ≠ 0`.  Purely algebraic:
`1 - e^{-u} = e^{-u/2}·2 sinh(u/2)`.

Second equality of card `worldsheet.regulated-sum-laurent-expansion`. -/
theorem exp_neg_div_one_sub_sq_eq_inv_sinh_sq {u : ℝ} (hu : u ≠ 0) :
    exp (-u) / (1 - exp (-u)) ^ 2 = 1 / (4 * sinh (u / 2) ^ 2) := by
  have ha : (0 : ℝ) < exp (u / 2) := exp_pos _
  have ha0 : exp (u / 2) ≠ 0 := ha.ne'
  have hsinh : sinh (u / 2) ≠ 0 := Real.sinh_ne_zero.mpr (div_ne_zero hu two_ne_zero)
  have hone : (1 : ℝ) - exp (-u) ≠ 0 := by
    intro h
    have h1 : exp (-u) = 1 := by linarith
    rw [Real.exp_eq_one_iff] at h1
    exact hu (by linarith)
  have hu' : exp (-u) = (exp (u / 2))⁻¹ * (exp (u / 2))⁻¹ := by
    rw [← Real.exp_neg, ← Real.exp_add]
    ring_nf
  have hs : sinh (u / 2) = (exp (u / 2) - (exp (u / 2))⁻¹) / 2 := by
    rw [Real.sinh_eq, Real.exp_neg]
  rw [div_eq_div_iff (pow_ne_zero 2 hone) (by positivity), hu', hs]
  field_simp
  ring

/-- **The card's first line in one statement**: for `u > 0`,
`Σ_{n≥1} n e^{-un} = e^{-u}/(1-e^{-u})² = 1/(4 sinh²(u/2))`. -/
theorem tsum_nat_mul_exp_neg_mul_eq_inv_sinh_sq {u : ℝ} (hu : 0 < u) :
    ∑' n : ℕ, (n : ℝ) * exp (-(u * n)) = 1 / (4 * sinh (u / 2) ^ 2) := by
  rw [tsum_nat_mul_exp_neg_mul hu, exp_neg_div_one_sub_sq_eq_inv_sinh_sq hu.ne']

end StringFormal.RegulatedSum
