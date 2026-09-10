/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.PhysicalStates

/-!
# The level-two scalar physical state and the negative norm above `D = 26`

Graph nodes: `worldsheet.ocq-level-two-scalar-norm` (the closed form of the norm) and clause
(2) of `worldsheet.no-ghost-theorem-v4` (for `D > 26` and intercept `a₀ = 1` the physical
subspace contains a negative-norm vector).  See `formal/TODO.md` item
`negative-norm-above-26`.

## Conventions

Inherited verbatim from `Sugawara.lean` / `PhysicalStates.lean`: `conv.metric-mostly-plus`
(diagonal `η : Fin D → R` with `hη : ∀ μ, η μ * η μ = 1`), `conv.alpha-prime-regge` (the zero
mode is the parameter `a : Fin D → R` standing for `a^μ = α^μ_0 = (2α')^{1/2} k^μ`, so that
`invTwo R * zeroModeSq η a = α' k²` and, at `α' = 1/2`, `a = k`), `conv.virasoro-standard`,
and `conv.intercept-sign-a` (the intercept is `a₀`, Polchinski's `-A`).

## Main definitions

* `Fock.traceState η` — `α_{-1} · α_{-1} |k⟩ = η_{μν} α^μ_{-1} α^ν_{-1} |k⟩`.
* `Fock.secondState η a` — `(a · α_{-2}) |k⟩`.
* `Fock.polSqState η a` — `(a · α_{-1})² |k⟩`.
* `Fock.levelTwoScalar η a c₂ c₃` — the level-two scalar trial state
  `[α_{-1}·α_{-1} + c₂ (a·α_{-2}) + c₃ (a·α_{-1})²] |k⟩`.

## Status

Skeleton: the definitions and their level-two homogeneity.  The `L_1`, `L_2` computations, the
norm and the negative-norm corollary follow in this file.
-/

namespace StringFormal.NoGhost

open MvPolynomial

namespace Fock

variable {D : ℕ} {R : Type*} [CommRing R]

section Defs

variable (η a : Fin D → R)

/-- `α_{-1} · α_{-1} |k⟩ = η_{μν} α^μ_{-1} α^ν_{-1} |k⟩`. -/
noncomputable def traceState : Fock D R :=
  ∑ μ : Fin D, η μ • (X ((μ, 1) : Osc D) * X ((μ, 1) : Osc D) : Fock D R)

/-- `(a · α_{-2}) |k⟩ = η_{μν} a^μ α^ν_{-2} |k⟩`. -/
noncomputable def secondState : Fock D R :=
  ∑ μ : Fin D, (η μ * a μ) • (X ((μ, 2) : Osc D) : Fock D R)

/-- `(a · α_{-1})² |k⟩`, the square of the level-one state `Fock.polState η a`. -/
noncomputable def polSqState : Fock D R := polState η a * polState η a

/-- **The level-two scalar trial state**
`[α_{-1}·α_{-1} + c₂ (a·α_{-2}) + c₃ (a·α_{-1})²] |k⟩`, with free coefficients `c₂ c₃ : R`.
This is the state of `worldsheet.ocq-level-two-scalar-norm`. -/
noncomputable def levelTwoScalar (c₂ c₃ : R) : Fock D R :=
  traceState η + c₂ • secondState η a + c₃ • polSqState η a

end Defs

/-! ### Level-two homogeneity -/

section Level

variable (η a : Fin D → R)

lemma X_mem_levelSubmodule (μ : Fin D) (n : ℕ+) :
    (X ((μ, n) : Osc D) : Fock D R) ∈ levelSubmodule D R (n : ℕ) := by
  have h := creation_mem_levelSubmodule (R := R) μ n (one_mem_levelSubmodule D R)
  rw [creation_apply, mul_one] at h
  simpa using h

lemma traceState_mem_levelSubmodule_two : traceState η ∈ levelSubmodule D R 2 := by
  refine Submodule.sum_mem _ fun μ _ => Submodule.smul_mem _ _ ?_
  have h := creation_mem_levelSubmodule (R := R) μ 1 (X_mem_levelSubmodule (R := R) μ 1)
  rw [creation_apply] at h
  simpa using h

lemma secondState_mem_levelSubmodule_two : secondState η a ∈ levelSubmodule D R 2 := by
  refine Submodule.sum_mem _ fun μ _ => Submodule.smul_mem _ _ ?_
  simpa using X_mem_levelSubmodule (R := R) μ 2

lemma polSqState_mem_levelSubmodule_two : polSqState η a ∈ levelSubmodule D R 2 :=
  (polState_mem_levelSubmodule_one (η := η) a).mul (polState_mem_levelSubmodule_one (η := η) a)

lemma levelTwoScalar_mem_levelSubmodule_two (c₂ c₃ : R) :
    levelTwoScalar η a c₂ c₃ ∈ levelSubmodule D R 2 :=
  Submodule.add_mem _
    (Submodule.add_mem _ (traceState_mem_levelSubmodule_two η)
      (Submodule.smul_mem _ _ (secondState_mem_levelSubmodule_two η a)))
    (Submodule.smul_mem _ _ (polSqState_mem_levelSubmodule_two η a))

end Level

/-! ### The three pieces in terms of the oscillator modes -/

section ModeAlgebra

variable (η a : Fin D → R)

/-- The applied form of the oscillator algebra for an **arbitrary pair** of directions
(`Fock.mode_apply_mode` only covers `μ = ν`). -/
lemma mode_apply_mode_gen (μ ν : Fin D) (m p : ℤ) (Y : Fock D R) :
    mode η a μ m (mode η a ν p Y)
      = (if m + p = 0 ∧ μ = ν then (m : R) * η μ else 0) • Y
        + mode η a ν p (mode η a μ m Y) := by
  have h := congrArg (fun T : Module.End R (Fock D R) => T Y) (lie_mode_mode η a μ ν m p)
  simp only [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
    LinearMap.smul_apply, LinearMap.id_coe, id_eq] at h
  rw [← h]
  abel

lemma mode_neg_one_apply (μ : Fin D) (P : Fock D R) :
    mode η a μ (-1) P = (X ((μ, 1) : Osc D) : Fock D R) * P := by
  rw [show (-1 : ℤ) = -(((1 : ℕ+) : ℕ) : ℤ) by norm_num, mode_neg_pnat, creation_apply]

lemma mode_neg_two_apply (μ : Fin D) (P : Fock D R) :
    mode η a μ (-2) P = (X ((μ, 2) : Osc D) : Fock D R) * P := by
  rw [show (-2 : ℤ) = -(((2 : ℕ+) : ℕ) : ℤ) by norm_num, mode_neg_pnat, creation_apply]

lemma traceState_eq_sum_mode :
    traceState η
      = ∑ μ : Fin D, η μ • mode η a μ (-1) (mode η a μ (-1) (1 : Fock D R)) := by
  rw [traceState]
  exact Finset.sum_congr rfl fun μ _ => by
    rw [mode_neg_one_apply η a, mode_neg_one_apply η a, mul_one]

lemma secondState_eq_sum_mode :
    secondState η a = ∑ μ : Fin D, (η μ * a μ) • mode η a μ (-2) (1 : Fock D R) := by
  rw [secondState]
  exact Finset.sum_congr rfl fun μ _ => by rw [mode_neg_two_apply η a, mul_one]

lemma polSqState_eq_sum_mode :
    polSqState η a = ∑ μ : Fin D, (η μ * a μ) • mode η a μ (-1) (polState η a) := by
  have h : (∑ μ : Fin D, (η μ * a μ) • mode η a μ (-1) (polState η a))
      = (∑ μ : Fin D, (η μ * a μ) • (X ((μ, 1) : Osc D) : Fock D R)) * polState η a := by
    rw [Finset.sum_mul]
    exact Finset.sum_congr rfl fun μ _ => by rw [mode_neg_one_apply η a, smul_mul_assoc]
  rw [polSqState, h, ← polState]

/-! ### `α^μ_1` on the level-two states -/

lemma mode_one_apply_mode_neg_one_one (μ ν : Fin D) :
    mode η a μ 1 (mode η a ν (-1) (1 : Fock D R))
      = (if μ = ν then η μ else 0) • (1 : Fock D R) := by
  classical
  rw [mode_apply_mode_gen η a μ ν 1 (-1),
    mode_apply_one_eq_zero η a (by norm_num : (0 : ℤ) < 1), map_zero, add_zero]
  congr 1
  by_cases h : μ = ν
  · rw [if_pos ⟨by ring, h⟩, if_pos h]
    push_cast
    ring
  · rw [if_neg (fun hc => h hc.2), if_neg h]

lemma mode_one_apply_polState (hη : ∀ μ, η μ * η μ = 1) (e : Fin D → R) (μ : Fin D) :
    mode η a μ 1 (polState η e) = e μ • (1 : Fock D R) := by
  classical
  rw [polState_eq_sum_mode η a, map_sum,
    Finset.sum_eq_single μ
      (fun ν _ hν => by
        rw [map_smul, mode_one_apply_mode_neg_one_one η a μ ν, if_neg (Ne.symm hν), zero_smul,
          smul_zero])
      (fun h => absurd (Finset.mem_univ μ) h),
    map_smul, mode_one_apply_mode_neg_one_one η a μ μ, if_pos rfl, smul_smul]
  congr 1
  linear_combination (e μ) * hη μ

lemma mode_one_apply_creaSq (μ ν : Fin D) :
    mode η a μ 1 (mode η a ν (-1) (mode η a ν (-1) (1 : Fock D R)))
      = (if μ = ν then (2 : R) * η μ else 0) • mode η a ν (-1) (1 : Fock D R) := by
  classical
  rw [mode_apply_mode_gen η a μ ν 1 (-1) (mode η a ν (-1) 1),
    mode_one_apply_mode_neg_one_one η a μ ν, map_smul]
  by_cases h : μ = ν
  · rw [if_pos ⟨by ring, h⟩, if_pos h, if_pos h, ← add_smul]
    congr 1
    push_cast
    ring
  · rw [if_neg (fun hc => h hc.2), if_neg h, if_neg h, zero_smul, add_zero]

lemma mode_one_apply_traceState (hη : ∀ μ, η μ * η μ = 1) (μ : Fin D) :
    mode η a μ 1 (traceState η) = (2 : R) • mode η a μ (-1) (1 : Fock D R) := by
  classical
  rw [traceState_eq_sum_mode η a, map_sum,
    Finset.sum_eq_single μ
      (fun ν _ hν => by
        rw [map_smul, mode_one_apply_creaSq η a μ ν, if_neg (Ne.symm hν), zero_smul, smul_zero])
      (fun h => absurd (Finset.mem_univ μ) h),
    map_smul, mode_one_apply_creaSq η a μ μ, if_pos rfl, smul_smul]
  congr 1
  linear_combination (2 : R) * hη μ

lemma mode_one_apply_secondState (μ : Fin D) : mode η a μ 1 (secondState η a) = 0 := by
  rw [secondState_eq_sum_mode η a, map_sum]
  refine Finset.sum_eq_zero fun ν _ => ?_
  rw [map_smul, mode_apply_mode_gen η a μ ν 1 (-2),
    if_neg (fun h => by have := h.1; omega), zero_smul,
    mode_apply_one_eq_zero η a (by norm_num : (0 : ℤ) < 1), map_zero, add_zero, smul_zero]

lemma mode_one_apply_polSqState (hη : ∀ μ, η μ * η μ = 1) (μ : Fin D) :
    mode η a μ 1 (polSqState η a) = ((2 : R) * a μ) • polState η a := by
  classical
  have hterm : ∀ ν : Fin D,
      mode η a μ 1 ((η ν * a ν) • mode η a ν (-1) (polState η a))
        = (if μ = ν then a μ else 0) • polState η a
          + (η ν * a ν * a μ) • mode η a ν (-1) (1 : Fock D R) := by
    intro ν
    rw [map_smul, mode_apply_mode_gen η a μ ν 1 (-1) (polState η a),
      mode_one_apply_polState η a hη a μ, map_smul, smul_add, smul_smul, smul_smul]
    congr 1
    by_cases h : μ = ν
    · rw [if_pos ⟨by ring, h⟩, if_pos h]
      congr 1
      push_cast
      rw [h]
      linear_combination (a ν) * hη ν
    · rw [if_neg (fun hc => h hc.2), if_neg h, mul_zero, zero_smul]
  rw [polSqState_eq_sum_mode η a, map_sum, Finset.sum_congr rfl fun ν _ => hterm ν,
    Finset.sum_add_distrib,
    Finset.sum_eq_single μ
      (fun ν _ hν => by rw [if_neg (Ne.symm hν), zero_smul])
      (fun h => absurd (Finset.mem_univ μ) h),
    if_pos rfl]
  have hsum : (∑ ν : Fin D, (η ν * a ν * a μ) • mode η a ν (-1) (1 : Fock D R))
      = a μ • polState η a := by
    rw [polState_eq_sum_mode η a, Finset.smul_sum]
    refine Finset.sum_congr rfl fun ν _ => ?_
    rw [smul_smul]
    congr 1
    ring
  rw [hsum, ← add_smul]
  congr 1
  ring

/-! ### `α^μ_2` on the level-two states -/

lemma mode_two_apply_mode_neg_one_one (μ ν : Fin D) :
    mode η a μ 2 (mode η a ν (-1) (1 : Fock D R)) = 0 := by
  rw [mode_apply_mode_gen η a μ ν 2 (-1), if_neg (fun h => by have := h.1; omega), zero_smul,
    mode_apply_one_eq_zero η a (by norm_num : (0 : ℤ) < 2), map_zero, add_zero]

lemma mode_two_apply_polState (e : Fin D → R) (μ : Fin D) :
    mode η a μ 2 (polState η e) = 0 := by
  rw [polState_eq_sum_mode η a, map_sum]
  refine Finset.sum_eq_zero fun ν _ => ?_
  rw [map_smul, mode_apply_mode_gen η a μ ν 2 (-1), if_neg (fun h => by have := h.1; omega),
    zero_smul, mode_apply_one_eq_zero η a (by norm_num : (0 : ℤ) < 2), map_zero, add_zero,
    smul_zero]

lemma mode_two_apply_traceState (μ : Fin D) : mode η a μ 2 (traceState η) = 0 := by
  rw [traceState_eq_sum_mode η a, map_sum]
  refine Finset.sum_eq_zero fun ν _ => ?_
  rw [map_smul, mode_apply_mode_gen η a μ ν 2 (-1) (mode η a ν (-1) 1),
    if_neg (fun h => by have := h.1; omega), zero_smul,
    mode_two_apply_mode_neg_one_one η a μ ν, map_zero, add_zero, smul_zero]

lemma mode_two_apply_polSqState (μ : Fin D) : mode η a μ 2 (polSqState η a) = 0 := by
  rw [polSqState_eq_sum_mode η a, map_sum]
  refine Finset.sum_eq_zero fun ν _ => ?_
  rw [map_smul, mode_apply_mode_gen η a μ ν 2 (-1) (polState η a),
    if_neg (fun h => by have := h.1; omega), zero_smul,
    mode_two_apply_polState η a a μ, map_zero, add_zero, smul_zero]

lemma mode_two_apply_secondState (hη : ∀ μ, η μ * η μ = 1) (μ : Fin D) :
    mode η a μ 2 (secondState η a) = ((2 : R) * a μ) • (1 : Fock D R) := by
  classical
  have hterm : ∀ ν : Fin D,
      mode η a μ 2 ((η ν * a ν) • mode η a ν (-2) (1 : Fock D R))
        = (if μ = ν then (2 : R) * a μ else 0) • (1 : Fock D R) := by
    intro ν
    rw [map_smul, mode_apply_mode_gen η a μ ν 2 (-2),
      mode_apply_one_eq_zero η a (by norm_num : (0 : ℤ) < 2), map_zero, add_zero, smul_smul]
    by_cases h : μ = ν
    · rw [if_pos ⟨by ring, h⟩, if_pos h]
      congr 1
      push_cast
      rw [h]
      linear_combination ((2 : R) * a ν) * hη ν
    · rw [if_neg (fun hc => h hc.2), if_neg h, mul_zero, zero_smul]
  rw [secondState_eq_sum_mode η a, map_sum, Finset.sum_congr rfl fun ν _ => hterm ν,
    Finset.sum_eq_single μ (fun ν _ hν => by rw [if_neg (Ne.symm hν), zero_smul])
      (fun h => absurd (Finset.mem_univ μ) h),
    if_pos rfl]

end ModeAlgebra

/-! ### The Fock form on the level-two states

The six independent inner products, and the resulting closed form for the norm of the trial
state.  All of them come from `Fock.pairing_mode_left` (`(α^μ_j)† = α^μ_{-j}`) together with
the action of `α^μ_1`, `α^μ_2` computed above; no monomial bookkeeping is needed. -/

section Pairing

variable (η a : Fin D → R)

lemma pairing_one_smul_one (c : R) : pairing η (1 : Fock D R) (c • (1 : Fock D R)) = c := by
  rw [map_smul, pairing_one_one, smul_eq_mul, mul_one]

lemma pairing_polState_left (e : Fin D → R) (w : Fock D R) :
    pairing η (polState η e) w
      = ∑ μ : Fin D, (η μ * e μ) * pairing η (1 : Fock D R) (mode η a μ 1 w) := by
  rw [polState_eq_sum_mode η a, map_sum, LinearMap.sum_apply]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [map_smul, LinearMap.smul_apply, smul_eq_mul, pairing_mode_left η a μ (-1),
    show -(-1 : ℤ) = 1 by norm_num]

lemma pairing_traceState_left (w : Fock D R) :
    pairing η (traceState η) w
      = ∑ μ : Fin D, η μ * pairing η (1 : Fock D R) (mode η a μ 1 (mode η a μ 1 w)) := by
  rw [traceState_eq_sum_mode η a, map_sum, LinearMap.sum_apply]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [map_smul, LinearMap.smul_apply, smul_eq_mul, pairing_mode_left η a μ (-1),
    pairing_mode_left η a μ (-1), show -(-1 : ℤ) = 1 by norm_num]

lemma pairing_secondState_left (w : Fock D R) :
    pairing η (secondState η a) w
      = ∑ μ : Fin D, (η μ * a μ) * pairing η (1 : Fock D R) (mode η a μ 2 w) := by
  rw [secondState_eq_sum_mode η a, map_sum, LinearMap.sum_apply]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [map_smul, LinearMap.smul_apply, smul_eq_mul, pairing_mode_left η a μ (-2),
    show -(-2 : ℤ) = 2 by norm_num]

lemma pairing_polSqState_left (w : Fock D R) :
    pairing η (polSqState η a) w
      = ∑ μ : Fin D, (η μ * a μ) * pairing η (polState η a) (mode η a μ 1 w) := by
  rw [polSqState_eq_sum_mode η a, map_sum, LinearMap.sum_apply]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [map_smul, LinearMap.smul_apply, smul_eq_mul, pairing_mode_left η a μ (-1),
    show -(-1 : ℤ) = 1 by norm_num]

include a in
/-- `⟨ζ·α_{-1}k, ξ·α_{-1}k⟩ = ζ · ξ`. -/
lemma pairing_polState_polState (hη : ∀ μ, η μ * η μ = 1) (e f : Fin D → R) :
    pairing η (polState η e) (polState η f) = ∑ μ : Fin D, η μ * e μ * f μ := by
  rw [pairing_polState_left η a e]
  exact Finset.sum_congr rfl fun μ _ => by
    rw [mode_one_apply_polState η a hη f μ, pairing_one_smul_one]

lemma pairing_polState_self (hη : ∀ μ, η μ * η μ = 1) :
    pairing η (polState η a) (polState η a) = zeroModeSq η a := by
  rw [pairing_polState_polState η a hη a a, zeroModeSq]

include a in
/-- `⟨α_{-1}·α_{-1}k, α_{-1}·α_{-1}k⟩ = 2D`: the only place where the dimension enters. -/
theorem pairing_traceState_traceState (hη : ∀ μ, η μ * η μ = 1) :
    pairing η (traceState η) (traceState η) = 2 * (D : R) := by
  rw [pairing_traceState_left η a]
  have hterm : ∀ μ : Fin D,
      η μ * pairing η (1 : Fock D R) (mode η a μ 1 (mode η a μ 1 (traceState η)))
        = 2 * (η μ * η μ) := by
    intro μ
    rw [mode_one_apply_traceState η a hη μ, map_smul, mode_one_apply_mode_neg_one_one η a μ μ,
      if_pos rfl, smul_smul, pairing_one_smul_one]
    ring
  rw [Finset.sum_congr rfl fun μ _ => hterm μ, ← Finset.mul_sum, sum_eta_sq η hη]

theorem pairing_traceState_secondState :
    pairing η (traceState η) (secondState η a) = 0 := by
  rw [pairing_traceState_left η a]
  exact Finset.sum_eq_zero fun μ _ => by
    rw [mode_one_apply_secondState η a μ, map_zero, map_zero, mul_zero]

theorem pairing_traceState_polSqState (hη : ∀ μ, η μ * η μ = 1) :
    pairing η (traceState η) (polSqState η a) = 2 * zeroModeSq η a := by
  rw [pairing_traceState_left η a]
  have hterm : ∀ μ : Fin D,
      η μ * pairing η (1 : Fock D R) (mode η a μ 1 (mode η a μ 1 (polSqState η a)))
        = 2 * (η μ * a μ * a μ) := by
    intro μ
    rw [mode_one_apply_polSqState η a hη μ, map_smul, mode_one_apply_polState η a hη a μ,
      smul_smul, pairing_one_smul_one]
    ring
  rw [Finset.sum_congr rfl fun μ _ => hterm μ, ← Finset.mul_sum, ← zeroModeSq]

theorem pairing_secondState_secondState (hη : ∀ μ, η μ * η μ = 1) :
    pairing η (secondState η a) (secondState η a) = 2 * zeroModeSq η a := by
  rw [pairing_secondState_left η a]
  have hterm : ∀ μ : Fin D,
      (η μ * a μ) * pairing η (1 : Fock D R) (mode η a μ 2 (secondState η a))
        = 2 * (η μ * a μ * a μ) := by
    intro μ
    rw [mode_two_apply_secondState η a hη μ, pairing_one_smul_one]
    ring
  rw [Finset.sum_congr rfl fun μ _ => hterm μ, ← Finset.mul_sum, ← zeroModeSq]

theorem pairing_secondState_polSqState :
    pairing η (secondState η a) (polSqState η a) = 0 := by
  rw [pairing_secondState_left η a]
  exact Finset.sum_eq_zero fun μ _ => by
    rw [mode_two_apply_polSqState η a μ, map_zero, mul_zero]

theorem pairing_polSqState_polSqState (hη : ∀ μ, η μ * η μ = 1) :
    pairing η (polSqState η a) (polSqState η a) = 2 * zeroModeSq η a * zeroModeSq η a := by
  rw [pairing_polSqState_left η a]
  have hterm : ∀ μ : Fin D,
      (η μ * a μ) * pairing η (polState η a) (mode η a μ 1 (polSqState η a))
        = (2 * zeroModeSq η a) * (η μ * a μ * a μ) := by
    intro μ
    rw [mode_one_apply_polSqState η a hη μ, map_smul, smul_eq_mul, pairing_polState_self η a hη]
    ring
  rw [Finset.sum_congr rfl fun μ _ => hterm μ, ← Finset.mul_sum, ← zeroModeSq]

theorem pairing_secondState_traceState :
    pairing η (secondState η a) (traceState η) = 0 := by
  rw [pairing_comm, pairing_traceState_secondState η a]

theorem pairing_polSqState_traceState (hη : ∀ μ, η μ * η μ = 1) :
    pairing η (polSqState η a) (traceState η) = 2 * zeroModeSq η a := by
  rw [pairing_comm, pairing_traceState_polSqState η a hη]

theorem pairing_polSqState_secondState :
    pairing η (polSqState η a) (secondState η a) = 0 := by
  rw [pairing_comm, pairing_secondState_polSqState η a]

/-- **The norm of the level-two scalar trial state, for arbitrary coefficients.**
With `s = α_0 · α_0 = 2α' k²` (`Fock.zeroModeSq`),
`⟨ψ₂, ψ₂⟩ = 2D + 2 s c₂² + 2 s² c₃² + 4 s c₃`.
No physical-state condition is used here. -/
theorem pairing_levelTwoScalar_self (hη : ∀ μ, η μ * η μ = 1) (c₂ c₃ : R) :
    pairing η (levelTwoScalar η a c₂ c₃) (levelTwoScalar η a c₂ c₃)
      = 2 * (D : R) + 2 * zeroModeSq η a * c₂ ^ 2
        + 2 * zeroModeSq η a ^ 2 * c₃ ^ 2 + 4 * zeroModeSq η a * c₃ := by
  simp only [levelTwoScalar, map_add, map_smul, LinearMap.add_apply, LinearMap.smul_apply,
    smul_eq_mul, pairing_traceState_traceState η a hη, pairing_traceState_secondState η a,
    pairing_traceState_polSqState η a hη, pairing_secondState_secondState η a hη,
    pairing_secondState_polSqState η a, pairing_polSqState_polSqState η a hη,
    pairing_secondState_traceState η a, pairing_polSqState_traceState η a hη,
    pairing_polSqState_secondState η a]
  ring

end Pairing

/-! ### The Virasoro conditions on the trial state -/

section Lop

variable [Algebra ℚ R] (η a : Fin D → R)

lemma Lop_one_apply_creaSq (hη : ∀ μ, η μ * η μ = 1) (μ : Fin D) :
    Lop η a 1 (mode η a μ (-1) (mode η a μ (-1) (1 : Fock D R)))
      = ((2 : R) * a μ) • mode η a μ (-1) (1 : Fock D R) := by
  rw [Lop_apply_mode η a hη 1 μ (-1),
    Lop_apply_mode_one η a hη (by norm_num : (0 : ℤ) < 1) μ (-1),
    show (1 : ℤ) + -1 = 0 by ring, mode_zero_apply, mode_zero_apply]
  simp only [map_smul, smul_smul]
  rw [← add_smul]
  congr 1
  push_cast
  ring

/-- `L_1 (α_{-1}·α_{-1}|k⟩) = 2 (a·α_{-1})|k⟩`. -/
theorem Lop_one_apply_traceState (hη : ∀ μ, η μ * η μ = 1) :
    Lop η a 1 (traceState η) = (2 : R) • polState η a := by
  rw [traceState_eq_sum_mode η a, map_sum, polState_eq_sum_mode η a, Finset.smul_sum]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [map_smul, Lop_one_apply_creaSq η a hη μ, smul_smul, smul_smul]
  congr 1
  ring

/-- `L_1 ((a·α_{-2})|k⟩) = 2 (a·α_{-1})|k⟩`. -/
theorem Lop_one_apply_secondState (hη : ∀ μ, η μ * η μ = 1) :
    Lop η a 1 (secondState η a) = (2 : R) • polState η a := by
  rw [secondState_eq_sum_mode η a, map_sum, polState_eq_sum_mode η a, Finset.smul_sum]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [map_smul, Lop_apply_mode_one η a hη (by norm_num : (0 : ℤ) < 1) μ (-2),
    show (1 : ℤ) + -2 = -1 by ring, smul_smul, smul_smul]
  congr 1
  push_cast
  ring

/-- `L_1 ((a·α_{-1})²|k⟩) = 2 (α_0·α_0) (a·α_{-1})|k⟩`. -/
theorem Lop_one_apply_polSqState (hη : ∀ μ, η μ * η μ = 1) :
    Lop η a 1 (polSqState η a) = ((2 : R) * zeroModeSq η a) • polState η a := by
  have hterm : ∀ μ : Fin D,
      Lop η a 1 ((η μ * a μ) • mode η a μ (-1) (polState η a))
        = (η μ * a μ * a μ) • polState η a
          + (η μ * a μ * zeroModeSq η a) • mode η a μ (-1) (1 : Fock D R) := by
    intro μ
    rw [map_smul, Lop_apply_mode η a hη 1 μ (-1) (polState η a),
      Lop_one_apply_polState η a hη a, show (1 : ℤ) + -1 = 0 by ring, mode_zero_apply,
      ← zeroModeSq]
    simp only [map_smul, smul_add, smul_smul]
    congr 2
    push_cast
    ring
  rw [polSqState_eq_sum_mode η a, map_sum, Finset.sum_congr rfl fun μ _ => hterm μ,
    Finset.sum_add_distrib, ← Finset.sum_smul, ← zeroModeSq]
  have hsum : (∑ μ : Fin D, (η μ * a μ * zeroModeSq η a) • mode η a μ (-1) (1 : Fock D R))
      = zeroModeSq η a • polState η a := by
    rw [polState_eq_sum_mode η a, Finset.smul_sum]
    refine Finset.sum_congr rfl fun μ _ => ?_
    rw [smul_smul]
    congr 1
    ring
  rw [hsum, ← add_smul]
  congr 1
  ring

lemma Lop_two_apply_creaSq (hη : ∀ μ, η μ * η μ = 1) (μ : Fin D) :
    Lop η a 2 (mode η a μ (-1) (mode η a μ (-1) (1 : Fock D R))) = η μ • (1 : Fock D R) := by
  rw [Lop_apply_mode η a hη 2 μ (-1), show (2 : ℤ) + -1 = 1 by ring,
    Lop_apply_mode_one η a hη (by norm_num : (0 : ℤ) < 2) μ (-1),
    show (2 : ℤ) + -1 = 1 by ring, mode_apply_one_eq_zero η a (by norm_num : (0 : ℤ) < 1),
    smul_zero, map_zero, add_zero, mode_apply_mode η a μ 1 (-1),
    mode_apply_one_eq_zero η a (by norm_num : (0 : ℤ) < 1), map_zero, add_zero,
    if_pos (by ring : (1 : ℤ) + -1 = 0), smul_smul]
  congr 1
  push_cast
  ring

/-- `L_2 (α_{-1}·α_{-1}|k⟩) = D |k⟩`: the anomaly term that makes the level-two norm
dimension-dependent. -/
theorem Lop_two_apply_traceState (hη : ∀ μ, η μ * η μ = 1) :
    Lop η a 2 (traceState η) = (D : R) • (1 : Fock D R) := by
  have hterm : ∀ μ : Fin D,
      Lop η a 2 (η μ • mode η a μ (-1) (mode η a μ (-1) (1 : Fock D R)))
        = (η μ * η μ) • (1 : Fock D R) := fun μ => by
    rw [map_smul, Lop_two_apply_creaSq η a hη μ, smul_smul]
  rw [traceState_eq_sum_mode η a, map_sum, Finset.sum_congr rfl fun μ _ => hterm μ,
    ← Finset.sum_smul, sum_eta_sq η hη]

/-- `L_2 ((a·α_{-2})|k⟩) = 2 (α_0·α_0) |k⟩`. -/
theorem Lop_two_apply_secondState (hη : ∀ μ, η μ * η μ = 1) :
    Lop η a 2 (secondState η a) = ((2 : R) * zeroModeSq η a) • (1 : Fock D R) := by
  have hterm : ∀ μ : Fin D,
      Lop η a 2 ((η μ * a μ) • mode η a μ (-2) (1 : Fock D R))
        = ((2 : R) * (η μ * a μ * a μ)) • (1 : Fock D R) := fun μ => by
    rw [map_smul, Lop_apply_mode_one η a hη (by norm_num : (0 : ℤ) < 2) μ (-2),
      show (2 : ℤ) + -2 = 0 by ring, mode_zero_apply, smul_smul, smul_smul]
    congr 1
    push_cast
    ring
  rw [secondState_eq_sum_mode η a, map_sum, Finset.sum_congr rfl fun μ _ => hterm μ,
    ← Finset.sum_smul, ← Finset.mul_sum, ← zeroModeSq]

/-- `L_2 ((a·α_{-1})²|k⟩) = (α_0·α_0) |k⟩`. -/
theorem Lop_two_apply_polSqState (hη : ∀ μ, η μ * η μ = 1) :
    Lop η a 2 (polSqState η a) = zeroModeSq η a • (1 : Fock D R) := by
  have hterm : ∀ μ : Fin D,
      Lop η a 2 ((η μ * a μ) • mode η a μ (-1) (polState η a))
        = (η μ * a μ * a μ) • (1 : Fock D R) := fun μ => by
    rw [map_smul, Lop_apply_mode η a hη 2 μ (-1), show (2 : ℤ) + -1 = 1 by ring,
      Lop_apply_polState_of_two_le η a hη (le_refl (2 : ℤ)) a, map_zero, add_zero,
      mode_one_apply_polState η a hη a μ, smul_smul, smul_smul]
    congr 1
    push_cast
    ring
  rw [polSqState_eq_sum_mode η a, map_sum, Finset.sum_congr rfl fun μ _ => hterm μ,
    ← Finset.sum_smul, ← zeroModeSq]

/-- **The `L_1` condition.**  `L_1 ψ₂ = (2 + 2c₂ + 2 c₃ s) (a·α_{-1})|k⟩`, `s = α_0·α_0`. -/
theorem Lop_one_apply_levelTwoScalar (hη : ∀ μ, η μ * η μ = 1) (c₂ c₃ : R) :
    Lop η a 1 (levelTwoScalar η a c₂ c₃)
      = ((2 : R) + 2 * c₂ + 2 * c₃ * zeroModeSq η a) • polState η a := by
  simp only [levelTwoScalar, map_add, map_smul, Lop_one_apply_traceState η a hη,
    Lop_one_apply_secondState η a hη, Lop_one_apply_polSqState η a hη, smul_smul]
  rw [← add_smul, ← add_smul]
  congr 1
  ring

/-- **The `L_2` condition.**  `L_2 ψ₂ = (D + 2 c₂ s + c₃ s) |k⟩`, `s = α_0·α_0`. -/
theorem Lop_two_apply_levelTwoScalar (hη : ∀ μ, η μ * η μ = 1) (c₂ c₃ : R) :
    Lop η a 2 (levelTwoScalar η a c₂ c₃)
      = ((D : R) + 2 * c₂ * zeroModeSq η a + c₃ * zeroModeSq η a) • (1 : Fock D R) := by
  simp only [levelTwoScalar, map_add, map_smul, Lop_two_apply_traceState η a hη,
    Lop_two_apply_secondState η a hη, Lop_two_apply_polSqState η a hη, smul_smul]
  rw [← add_smul, ← add_smul]
  congr 1
  ring

/-- `L_n ψ₂ = 0` for `n ≥ 3`: automatic, because `ψ₂` has level `2`. -/
theorem Lop_apply_levelTwoScalar_of_three_le (c₂ c₃ : R) {n : ℤ} (hn : 3 ≤ n) :
    Lop η a n (levelTwoScalar η a c₂ c₃) = 0 :=
  Lop_apply_eq_zero_of_level_lt η a (levelTwoScalar_mem_levelSubmodule_two η a c₂ c₃)
    (by push_cast; omega)

/-- **The physical-state conditions for the level-two scalar.**  Mass shell `α' k² + 2 = a₀`
together with the two Virasoro conditions `L_1 ψ₂ = 0`, `L_2 ψ₂ = 0` puts `ψ₂` in `H_phys`;
the conditions `L_n ψ₂ = 0` for `n ≥ 3` are automatic. -/
theorem levelTwoScalar_mem_physSubmodule (hη : ∀ μ, η μ * η μ = 1) (a₀ c₂ c₃ : R)
    (hmass : invTwo R * zeroModeSq η a + 2 = a₀)
    (h1 : (2 : R) + 2 * c₂ + 2 * c₃ * zeroModeSq η a = 0)
    (h2 : (D : R) + 2 * c₂ * zeroModeSq η a + c₃ * zeroModeSq η a = 0) :
    levelTwoScalar η a c₂ c₃ ∈ physSubmodule η a a₀ := by
  refine (mem_physSubmodule_iff_of_mem_levelSubmodule η a a₀ hη
    (levelTwoScalar_mem_levelSubmodule_two η a c₂ c₃)).mpr ⟨?_, ?_⟩
  · have hz : invTwo R * zeroModeSq η a + ((2 : ℕ) : R) - a₀ = 0 := by
      push_cast
      rw [← hmass]
      ring
    rw [hz, zero_smul]
  · intro n hn
    rcases lt_trichotomy n 2 with h | h | h
    · have hn1 : n = 1 := by omega
      subst hn1
      rw [Lop_one_apply_levelTwoScalar η a hη, h1, zero_smul]
    · subst h
      rw [Lop_two_apply_levelTwoScalar η a hη, h2, zero_smul]
    · exact Lop_apply_levelTwoScalar_of_three_le η a c₂ c₃ (by omega)

end Lop

end Fock

end StringFormal.NoGhost
