/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import Mathlib.Analysis.SpecificLimits.Normed
import Mathlib.Analysis.SpecialFunctions.Trigonometric.DerivHyp
import Mathlib.RingTheory.PowerSeries.WellKnown

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
* `tendsto_shiftedSinh`, `tendsto_twoSinh_div`, `tendsto_invSinhSq_sub_invSq` : the three
  factors of the exact factorisation
  `1/(4s²) - 1/u² = [(u - 2s)/u³]·[1 + 2s/u]·[(2s/u)⁻¹]²` (`s = sinh(u/2)`) and their limits
  `-1/24`, `2`, `1`.
* `tendsto_regulatedSum_sub_invSq` : **the card's constant term**,
  `Σ_{n≥1} n e^{-un} - 1/u² → -1/12` as `u → 0⁺`.
  Since the limit of `f(u) - 1/u²` exists and is finite, this simultaneously says there is no
  `1/u` term and pins the constant.
* `powerSeries_nat_mul_one_sub_sq` : the algebraic shadow `(Σ_{n≥0} n Xⁿ)·(1-X)² = X` in
  `R⟦X⟧` for any commutative ring `R` (no convergence, no `u`).

## Conventions / indexing

The sums below run over `n : ℕ` starting at `0`, which is harmless: the `n = 0` summand is
`0 * e^0 = 0`, so `∑' n : ℕ, n e^{-un}` **is** the card's `Σ_{n≥1}`.
This file uses no physics convention; it is a pure analysis lemma (see the card's `notes`).

## What is *not* here

* The `O(u²)` refinement of the remainder (`tendsto_regulatedSum_sub_invSq` gives only the
  limit, which is what "the constant term is `-1/12` and there is no `1/u` term" means).
  Upgrading to `Asymptotics.IsBigO` needs the next order of the `sinh` expansion; not done.
* A **Laurent-series** treatment in `u`.  `powerSeries_nat_mul_one_sub_sq` lives in `R⟦X⟧` with
  `X = e^{-u}` a formal variable, where `u → 0⁺` (i.e. `X → 1`) is meaningless; the pole at
  `X = 1` is exactly what the analytic statements above see.  Formalising "the Laurent expansion
  in `u`" would need `LaurentSeries` plus the substitution `X = e^{-u}`; not done.
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

/-! ### A third-order Taylor bound for `sinh` -/

/-- **`|sinh x - (x + x³/6)| ≤ |x|⁵/100` for `|x| ≤ 1`.**

Mathlib's `Real.exp_bound` at `n = 5` bounds `exp y` against its degree-`4` Taylor polynomial by
`|y|⁵·(6/(5!·5)) = |y|⁵/100`.  Applying it at `y = x` and `y = -x` and halving the difference,
the *even* Taylor terms cancel and the degree-`4` polynomial contributes exactly `x + x³/6`, so
the same constant `1/100` bounds the `sinh` error. -/
theorem abs_sinh_sub_taylor_le {x : ℝ} (hx : |x| ≤ 1) :
    |sinh x - (x + x ^ 3 / 6)| ≤ |x| ^ 5 / 100 := by
  have hsum : ∀ y : ℝ, ∑ m ∈ Finset.range 5, y ^ m / (Nat.factorial m : ℝ)
      = 1 + y + y ^ 2 / 2 + y ^ 3 / 6 + y ^ 4 / 24 := by
    intro y
    simp [Finset.sum_range_succ, Nat.factorial]
  have h1 := Real.exp_bound hx (n := 5) (by norm_num)
  have h2 := Real.exp_bound (x := -x) (by rwa [abs_neg]) (n := 5) (by norm_num)
  rw [hsum] at h1
  rw [hsum, abs_neg] at h2
  have hneg : (1 : ℝ) + (-x) + (-x) ^ 2 / 2 + (-x) ^ 3 / 6 + (-x) ^ 4 / 24
      = 1 - x + x ^ 2 / 2 - x ^ 3 / 6 + x ^ 4 / 24 := by ring
  rw [hneg] at h2
  norm_num [Nat.factorial] at h1 h2
  obtain ⟨h1l, h1r⟩ := abs_le.mp h1
  obtain ⟨h2l, h2r⟩ := abs_le.mp h2
  rw [Real.sinh_eq, abs_le]
  constructor <;> linarith

/-! ### The Laurent constant `-1/12` -/

/-- The third-order Taylor bound, rewritten for the quantity `(u - 2 sinh(u/2))/u³` whose limit
is the coefficient we are after: `|(u - 2 sinh(u/2))/u³ + 1/24| ≤ u²/1600` for `0 < |u| ≤ 2`. -/
theorem abs_shiftedSinh_add_le {u : ℝ} (hu : u ≠ 0) (hu2 : |u| ≤ 2) :
    |(u - 2 * sinh (u / 2)) / u ^ 3 + 1 / 24| ≤ u ^ 2 / 1600 := by
  have hx : |u / 2| ≤ 1 := by rw [abs_div, abs_two]; linarith
  have h := abs_sinh_sub_taylor_le hx
  have habs : |u / 2| ^ 5 / 100 = |u| ^ 5 / 3200 := by
    rw [abs_div, abs_two]; ring
  rw [habs] at h
  have key : (u - 2 * sinh (u / 2)) / u ^ 3 + 1 / 24
      = -2 * (sinh (u / 2) - (u / 2 + (u / 2) ^ 3 / 6)) / u ^ 3 := by
    field_simp
    ring
  have hpos : (0 : ℝ) < |u| ^ 3 := by positivity
  have h5 : |u| ^ 5 = |u| ^ 3 * u ^ 2 := by rw [← sq_abs u]; ring
  rw [key, abs_div, abs_mul, abs_pow u 3, div_le_iff₀ hpos]
  have h2 : |(-2 : ℝ)| = 2 := by norm_num
  rw [h2]
  nlinarith [abs_nonneg (sinh (u / 2) - (u / 2 + (u / 2) ^ 3 / 6))]

/-- `(u - 2 sinh(u/2))/u³ → -1/24` as `u → 0⁺`.  (This is the `sinh` Taylor coefficient
`sinh x = x + x³/6 + …` read off at `x = u/2`.) -/
theorem tendsto_shiftedSinh :
    Tendsto (fun u : ℝ => (u - 2 * sinh (u / 2)) / u ^ 3) (𝓝[>] (0 : ℝ)) (𝓝 (-1 / 24)) := by
  have hg : Tendsto (fun u : ℝ => u ^ 2 / 1600) (𝓝[>] (0 : ℝ)) (𝓝 0) := by
    have hc : Continuous fun u : ℝ => u ^ 2 / 1600 := by fun_prop
    have := hc.tendsto (0 : ℝ)
    simp only [ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow, zero_div] at this
    exact this.mono_left nhdsWithin_le_nhds
  have hev : ∀ᶠ u in 𝓝[>] (0 : ℝ),
      ‖(u - 2 * sinh (u / 2)) / u ^ 3 - (-1 / 24)‖ ≤ u ^ 2 / 1600 := by
    filter_upwards [Ioo_mem_nhdsGT (show (0:ℝ) < 2 by norm_num)] with u hu
    have hu0 : (0 : ℝ) < u := hu.1
    have habs : |u| ≤ 2 := by rw [abs_of_pos hu0]; exact hu.2.le
    have := abs_shiftedSinh_add_le hu0.ne' habs
    rw [Real.norm_eq_abs]
    convert this using 3
    ring
  have h0 := squeeze_zero_norm' hev hg
  rwa [tendsto_sub_nhds_zero_iff] at h0

/-- `2 sinh(u/2)/u → 1` as `u → 0⁺`.  Obtained from `tendsto_shiftedSinh` via the exact identity
`2 sinh(u/2)/u = 1 - u²·(u - 2 sinh(u/2))/u³`, so no second squeeze argument is needed. -/
theorem tendsto_twoSinh_div :
    Tendsto (fun u : ℝ => 2 * sinh (u / 2) / u) (𝓝[>] (0 : ℝ)) (𝓝 1) := by
  have hu2 : Tendsto (fun u : ℝ => u ^ 2) (𝓝[>] (0 : ℝ)) (𝓝 0) := by
    have hc : Continuous fun u : ℝ => u ^ 2 := by fun_prop
    have := hc.tendsto (0 : ℝ)
    simp only [ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow] at this
    exact this.mono_left nhdsWithin_le_nhds
  have hone : Tendsto (fun _ : ℝ => (1 : ℝ)) (𝓝[>] (0 : ℝ)) (𝓝 1) := tendsto_const_nhds
  have h := hone.sub (hu2.mul tendsto_shiftedSinh)
  simp only [zero_mul, sub_zero] at h
  refine Tendsto.congr' ?_ h
  filter_upwards [self_mem_nhdsWithin] with u hu
  have hu0 : u ≠ 0 := (Set.mem_Ioi.mp hu).ne'
  field_simp
  ring

/-- **The card's Laurent constant, `sinh` form**: `1/(4 sinh²(u/2)) - 1/u² → -1/12` as `u → 0⁺`.

Proof is the exact factorisation, valid for `u > 0`,
`1/(4s²) - 1/u² = [(u - 2s)/u³] · [1 + 2s/u] · [(2s/u)⁻¹]²` with `s = sinh(u/2)`,
whose three factors tend to `-1/24`, `2` and `1`. -/
theorem tendsto_invSinhSq_sub_invSq :
    Tendsto (fun u : ℝ => 1 / (4 * sinh (u / 2) ^ 2) - 1 / u ^ 2) (𝓝[>] (0 : ℝ))
      (𝓝 (-1 / 12)) := by
  have hT := tendsto_twoSinh_div
  have hinv : Tendsto (fun u : ℝ => (2 * sinh (u / 2) / u)⁻¹) (𝓝[>] (0 : ℝ)) (𝓝 1) := by
    simpa using hT.inv₀ one_ne_zero
  have hone : Tendsto (fun _ : ℝ => (1 : ℝ)) (𝓝[>] (0 : ℝ)) (𝓝 1) := tendsto_const_nhds
  have hprod := (tendsto_shiftedSinh.mul (hone.add hT)).mul (hinv.pow 2)
  have hval : (-1 / 24 : ℝ) * (1 + 1) * 1 ^ 2 = -1 / 12 := by norm_num
  rw [hval] at hprod
  refine Tendsto.congr' ?_ hprod
  filter_upwards [self_mem_nhdsWithin] with u hu
  have hu0 : (0 : ℝ) < u := Set.mem_Ioi.mp hu
  have hs : sinh (u / 2) ≠ 0 :=
    Real.sinh_ne_zero.mpr (div_ne_zero hu0.ne' two_ne_zero)
  field_simp
  ring

/-- **`worldsheet.regulated-sum-laurent-expansion`, constant-term half**:
`Σ_{n≥1} n e^{-un} - 1/u² → -1/12` as `u → 0⁺`.

Because the limit exists and is finite, this says at once that `1/u²` is the *entire* singular
part (no `1/u` term survives) and that the constant term is exactly `-1/12`.

The card's stronger `+ O(u²)` for the remainder is **not** proved here; see the module docstring. -/
theorem tendsto_regulatedSum_sub_invSq :
    Tendsto (fun u : ℝ => (∑' n : ℕ, (n : ℝ) * exp (-(u * n))) - 1 / u ^ 2) (𝓝[>] (0 : ℝ))
      (𝓝 (-1 / 12)) := by
  refine Tendsto.congr' ?_ tendsto_invSinhSq_sub_invSq
  filter_upwards [self_mem_nhdsWithin] with u hu
  rw [tsum_nat_mul_exp_neg_mul_eq_inv_sinh_sq (Set.mem_Ioi.mp hu)]

/-! ### The formal power series avatar -/

open PowerSeries in
/-- **`Σ_{n≥0} n Xⁿ = X/(1-X)²` as formal power series**, in the inverse-free form
`(Σ n Xⁿ)·(1-X)² = X`, over **any** commutative ring.

This is the algebraic shadow of `hasSum_nat_mul_exp_neg_mul` (put `X = e^{-u}`): the same rational
function, with no convergence hypothesis.  Mathlib supplies the hard half,
`PowerSeries.mk_add_choose_mul_one_sub_pow_eq_one` at `d = 1`
(`Σ (n+1) Xⁿ · (1-X)² = 1`); what is added here is the shift `Σ n Xⁿ = X · Σ (n+1) Xⁿ`.

**Scope**: the analytic Laurent expansion around `u = 0` is *not* visible at this level — a
formal power series in `X` has no notion of `X → 1`.  Extracting `1/u² - 1/12` from the
`X = e^{-u}` substitution is genuinely an analytic statement (`tendsto_regulatedSum_sub_invSq`);
a formal treatment would need `LaurentSeries` in `u` plus the composition `X = e^{-u}`, which is
not formalised here. -/
theorem powerSeries_nat_mul_one_sub_sq (R : Type*) [CommRing R] :
    (PowerSeries.mk fun n => (n : R)) * (1 - PowerSeries.X) ^ 2 = (PowerSeries.X : R⟦X⟧) := by
  have hB : (PowerSeries.mk fun n => ((n : R) + 1)) * (1 - PowerSeries.X) ^ 2 = 1 := by
    have h := PowerSeries.mk_add_choose_mul_one_sub_pow_eq_one (S := R) (d := 1)
    have he : (PowerSeries.mk fun n => ((Nat.choose (1 + n) 1 : ℕ) : R))
        = (PowerSeries.mk fun n => ((n : R) + 1)) := by
      ext n
      simp [Nat.choose_one_right, add_comm]
    rw [he] at h
    simpa using h
  have hA : (PowerSeries.mk fun n => (n : R))
      = PowerSeries.X * (PowerSeries.mk fun n => ((n : R) + 1)) := by
    ext n
    cases n with
    | zero => simp
    | succ m => simp [PowerSeries.coeff_succ_X_mul]
  rw [hA, mul_assoc, hB, mul_one]

end StringFormal.RegulatedSum
