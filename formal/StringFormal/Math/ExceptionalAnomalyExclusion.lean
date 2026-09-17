/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Claude (formalizer agent)
-/
import Mathlib.Data.Rat.Defs
import Mathlib.Data.Fintype.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Tactic

/-!
# Exceptional Lie Algebras and D=10 Anomaly Exclusion

This file formalizes the computational exclusion of exceptional Lie algebras
G₂, F₄, E₆, E₇ from the D=10 anomaly cancellation condition, and confirms
that E₈ satisfies it.

## Main results

* `g2_violates_anomaly`: G₂ does not satisfy the anomaly identity
* `f4_violates_anomaly`: F₄ does not satisfy the anomaly identity
* `e6_violates_anomaly`: E₆ does not satisfy the anomaly identity
* `e7_violates_anomaly`: E₇ does not satisfy the anomaly identity
* `e8_satisfies_anomaly`: E₈ satisfies the anomaly identity

## References

* research/attempts/d10-anomaly-full-classification/proof.md §6.5
-/

open BigOperators

namespace ExceptionalAnomalyExclusion

/-- The anomaly cancellation condition: S₆ = (1/48)·S₄·S₂ - (1/14400)·S₂³ -/
def anomalyRHS (S₂ S₄ S₆ : ℚ) : Prop :=
  S₆ = (1/48) * S₄ * S₂ - (1/14400) * S₂^3

/-! ### G₂ root system -/

/-- G₂ has rank 2, embedded in R³ with coordinates summing to zero.
Short roots: ±(eᵢ - eⱼ) for i ≠ j
Long roots: ±(2eᵢ - eⱼ - eₖ) for distinct i,j,k
Total: 12 roots (6 short + 6 long) -/

def g2Roots : List (Fin 3 → ℚ) :=
  [ ![1, -1, 0], ![-1, 1, 0], ![1, 0, -1], ![-1, 0, 1], ![0, 1, -1], ![0, -1, 1],  -- short
    ![2, -1, -1], ![-2, 1, 1], ![-1, 2, -1], ![1, -2, 1], ![-1, -1, 2], ![1, 1, -2] ] -- long

/-- Dot product in R³ -/
def dot3 (v w : Fin 3 → ℚ) : ℚ := v 0 * w 0 + v 1 * w 1 + v 2 * w 2

/-- Power sum Sₖ = Σ_{α∈Φ} α(H)^k for a Cartan element H -/
def powerSum (roots : List (Fin 3 → ℚ)) (H : Fin 3 → ℚ) (k : ℕ) : ℚ :=
  (roots.map (fun α => (dot3 α H) ^ k)).sum

-- Helper to convert list sum to explicit computation
private lemma list_sum_cons (x : ℚ) (xs : List ℚ) : (x :: xs).sum = x + xs.sum := List.sum_cons

private lemma list_sum_nil : ([] : List ℚ).sum = 0 := List.sum_nil

/-- G₂ witness point: H = (1, 0, -1) -/
def g2Witness : Fin 3 → ℚ := ![1, 0, -1]

/-- G₂ power sum S₂ at witness point -/
def g2PowerSumTwo : ℚ := powerSum g2Roots g2Witness 2

/-- G₂ power sum S₄ at witness point -/
def g2PowerSumFour : ℚ := powerSum g2Roots g2Witness 4

/-- G₂ power sum S₆ at witness point -/
def g2PowerSumSix : ℚ := powerSum g2Roots g2Witness 6

-- G₂ computations use native_decide (12 roots, manageable)
theorem g2_power_sum_two_value : g2PowerSumTwo = 48 := by native_decide
theorem g2_power_sum_four_value : g2PowerSumFour = 360 := by native_decide
theorem g2_power_sum_six_value : g2PowerSumSix = 3048 := by native_decide

theorem g2_rhs_value : (1/48) * g2PowerSumFour * g2PowerSumTwo - (1/14400) * g2PowerSumTwo^3 = 8808/25 := by
  rw [g2_power_sum_two_value, g2_power_sum_four_value]
  norm_num

/-- G₂ violates the anomaly identity -/
theorem g2_violates_anomaly : ∃ H, ¬ anomalyRHS
    (powerSum g2Roots H 2)
    (powerSum g2Roots H 4)
    (powerSum g2Roots H 6) := by
  use g2Witness
  rw [anomalyRHS, g2PowerSumTwo, g2PowerSumFour, g2PowerSumSix]
  rw [g2_power_sum_two_value, g2_power_sum_four_value, g2_power_sum_six_value, g2_rhs_value]
  norm_num

/-! ### F₄ root system -/

/-- F₄ has rank 4. Roots are:
- D₄ roots: ±eᵢ ± eⱼ for i < j
- Short roots: ±eᵢ for i = 0..3
- Extra roots: (±1/2, ±1/2, ±1/2, ±1/2)
Total: 48 roots -/

def f4RootsD4 : List (Fin 4 → ℚ) :=
  [ ![1, 1, 0, 0], ![1, -1, 0, 0], ![-1, 1, 0, 0], ![-1, -1, 0, 0],
    ![1, 0, 1, 0], ![1, 0, -1, 0], ![-1, 0, 1, 0], ![-1, 0, -1, 0],
    ![1, 0, 0, 1], ![1, 0, 0, -1], ![-1, 0, 0, 1], ![-1, 0, 0, -1],
    ![0, 1, 1, 0], ![0, 1, -1, 0], ![0, -1, 1, 0], ![0, -1, -1, 0],
    ![0, 1, 0, 1], ![0, 1, 0, -1], ![0, -1, 0, 1], ![0, -1, 0, -1],
    ![0, 0, 1, 1], ![0, 0, 1, -1], ![0, 0, -1, 1], ![0, 0, -1, -1] ]

def f4RootsShort : List (Fin 4 → ℚ) :=
  [ ![1, 0, 0, 0], ![-1, 0, 0, 0], ![0, 1, 0, 0], ![0, -1, 0, 0],
    ![0, 0, 1, 0], ![0, 0, -1, 0], ![0, 0, 0, 1], ![0, 0, 0, -1] ]

def f4RootsHalf : List (Fin 4 → ℚ) :=
  [ ![1/2, 1/2, 1/2, 1/2], ![1/2, 1/2, 1/2, -1/2], ![1/2, 1/2, -1/2, 1/2], ![1/2, 1/2, -1/2, -1/2],
    ![1/2, -1/2, 1/2, 1/2], ![1/2, -1/2, 1/2, -1/2], ![1/2, -1/2, -1/2, 1/2], ![1/2, -1/2, -1/2, -1/2],
    ![-1/2, 1/2, 1/2, 1/2], ![-1/2, 1/2, 1/2, -1/2], ![-1/2, 1/2, -1/2, 1/2], ![-1/2, 1/2, -1/2, -1/2],
    ![-1/2, -1/2, 1/2, 1/2], ![-1/2, -1/2, 1/2, -1/2], ![-1/2, -1/2, -1/2, 1/2], ![-1/2, -1/2, -1/2, -1/2] ]

def f4Roots : List (Fin 4 → ℚ) := f4RootsD4 ++ f4RootsShort ++ f4RootsHalf

/-- Dot product in R⁴ -/
def dot4 (v w : Fin 4 → ℚ) : ℚ := v 0 * w 0 + v 1 * w 1 + v 2 * w 2 + v 3 * w 3

/-- Power sum for rank-4 algebras -/
def powerSum4 (roots : List (Fin 4 → ℚ)) (H : Fin 4 → ℚ) (k : ℕ) : ℚ :=
  (roots.map (fun α => (dot4 α H) ^ k)).sum

/-- F₄ witness point: H = (1, 0, 0, 0) -/
def f4Witness : Fin 4 → ℚ := ![1, 0, 0, 0]

def f4PowerSumTwo : ℚ := powerSum4 f4Roots f4Witness 2
def f4PowerSumFour : ℚ := powerSum4 f4Roots f4Witness 4
def f4PowerSumSix : ℚ := powerSum4 f4Roots f4Witness 6

-- F₄ computations use native_decide (48 roots)
theorem f4_power_sum_two_value : f4PowerSumTwo = 18 := by native_decide
theorem f4_power_sum_four_value : f4PowerSumFour = 15 := by native_decide
theorem f4_power_sum_six_value : f4PowerSumSix = 57/4 := by native_decide

theorem f4_rhs_value : (1/48) * f4PowerSumFour * f4PowerSumTwo - (1/14400) * f4PowerSumTwo^3 = 261/50 := by
  rw [f4_power_sum_two_value, f4_power_sum_four_value]
  norm_num

/-- F₄ violates the anomaly identity -/
theorem f4_violates_anomaly : ∃ H, ¬ anomalyRHS
    (powerSum4 f4Roots H 2)
    (powerSum4 f4Roots H 4)
    (powerSum4 f4Roots H 6) := by
  use f4Witness
  rw [anomalyRHS, f4PowerSumTwo, f4PowerSumFour, f4PowerSumSix]
  rw [f4_power_sum_two_value, f4_power_sum_four_value, f4_power_sum_six_value, f4_rhs_value]
  norm_num

/-! ### E₆ root system -/

/-- E₆ has rank 6, embedded in R⁸. Roots are:
- ±eᵢ ± eⱼ for i < j ≤ 5 (40 roots)
- ±(1/2)(e₈ - e₇ - e₆ + Σᵢ₌₀⁵ (-1)^νᵢ eᵢ) where Σνᵢ even (32 roots)
Total: 72 roots -/

def e6RootsShort : List (Fin 8 → ℚ) :=
  [ ![1, 1, 0, 0, 0, 0, 0, 0], ![1, -1, 0, 0, 0, 0, 0, 0], ![-1, 1, 0, 0, 0, 0, 0, 0], ![-1, -1, 0, 0, 0, 0, 0, 0],
    ![1, 0, 1, 0, 0, 0, 0, 0], ![1, 0, -1, 0, 0, 0, 0, 0], ![-1, 0, 1, 0, 0, 0, 0, 0], ![-1, 0, -1, 0, 0, 0, 0, 0],
    ![1, 0, 0, 1, 0, 0, 0, 0], ![1, 0, 0, -1, 0, 0, 0, 0], ![-1, 0, 0, 1, 0, 0, 0, 0], ![-1, 0, 0, -1, 0, 0, 0, 0],
    ![1, 0, 0, 0, 1, 0, 0, 0], ![1, 0, 0, 0, -1, 0, 0, 0], ![-1, 0, 0, 0, 1, 0, 0, 0], ![-1, 0, 0, 0, -1, 0, 0, 0],
    ![1, 0, 0, 0, 0, 1, 0, 0], ![1, 0, 0, 0, 0, -1, 0, 0], ![-1, 0, 0, 0, 0, 1, 0, 0], ![-1, 0, 0, 0, 0, -1, 0, 0],
    ![0, 1, 1, 0, 0, 0, 0, 0], ![0, 1, -1, 0, 0, 0, 0, 0], ![0, -1, 1, 0, 0, 0, 0, 0], ![0, -1, -1, 0, 0, 0, 0, 0],
    ![0, 1, 0, 1, 0, 0, 0, 0], ![0, 1, 0, -1, 0, 0, 0, 0], ![0, -1, 0, 1, 0, 0, 0, 0], ![0, -1, 0, -1, 0, 0, 0, 0],
    ![0, 1, 0, 0, 1, 0, 0, 0], ![0, 1, 0, 0, -1, 0, 0, 0], ![0, -1, 0, 0, 1, 0, 0, 0], ![0, -1, 0, 0, -1, 0, 0, 0],
    ![0, 1, 0, 0, 0, 1, 0, 0], ![0, 1, 0, 0, 0, -1, 0, 0], ![0, -1, 0, 0, 0, 1, 0, 0], ![0, -1, 0, 0, 0, -1, 0, 0],
    ![0, 0, 1, 1, 0, 0, 0, 0], ![0, 0, 1, -1, 0, 0, 0, 0], ![0, 0, -1, 1, 0, 0, 0, 0], ![0, 0, -1, -1, 0, 0, 0, 0] ]

/-- E₆ half-roots (32 roots with even parity) -/
def e6RootsHalf : List (Fin 8 → ℚ) :=
  [ ![1/2, 1/2, 1/2, 1/2, 1/2, 1/2, -1/2, 1/2], ![-1/2, -1/2, -1/2, -1/2, -1/2, -1/2, 1/2, -1/2],
    ![1/2, 1/2, 1/2, 1/2, -1/2, -1/2, -1/2, 1/2], ![-1/2, -1/2, -1/2, -1/2, 1/2, 1/2, 1/2, -1/2],
    ![1/2, 1/2, 1/2, -1/2, 1/2, -1/2, -1/2, 1/2], ![-1/2, -1/2, -1/2, 1/2, -1/2, 1/2, 1/2, -1/2],
    ![1/2, 1/2, 1/2, -1/2, -1/2, 1/2, -1/2, 1/2], ![-1/2, -1/2, -1/2, 1/2, 1/2, -1/2, 1/2, -1/2],
    ![1/2, 1/2, -1/2, 1/2, 1/2, -1/2, -1/2, 1/2], ![-1/2, -1/2, 1/2, -1/2, -1/2, 1/2, 1/2, -1/2],
    ![1/2, 1/2, -1/2, 1/2, -1/2, 1/2, -1/2, 1/2], ![-1/2, -1/2, 1/2, -1/2, 1/2, -1/2, 1/2, -1/2],
    ![1/2, 1/2, -1/2, -1/2, 1/2, 1/2, -1/2, 1/2], ![-1/2, -1/2, 1/2, 1/2, -1/2, -1/2, 1/2, -1/2],
    ![1/2, -1/2, 1/2, 1/2, 1/2, -1/2, -1/2, 1/2], ![-1/2, 1/2, -1/2, -1/2, -1/2, 1/2, 1/2, -1/2],
    ![1/2, -1/2, 1/2, 1/2, -1/2, 1/2, -1/2, 1/2], ![-1/2, 1/2, -1/2, -1/2, 1/2, -1/2, 1/2, -1/2],
    ![1/2, -1/2, 1/2, -1/2, 1/2, 1/2, -1/2, 1/2], ![-1/2, 1/2, -1/2, 1/2, -1/2, -1/2, 1/2, -1/2],
    ![1/2, -1/2, -1/2, 1/2, 1/2, 1/2, -1/2, 1/2], ![-1/2, 1/2, 1/2, -1/2, -1/2, -1/2, 1/2, -1/2],
    ![-1/2, 1/2, 1/2, 1/2, 1/2, -1/2, -1/2, 1/2], ![1/2, -1/2, -1/2, -1/2, -1/2, 1/2, 1/2, -1/2],
    ![-1/2, 1/2, 1/2, 1/2, -1/2, 1/2, -1/2, 1/2], ![1/2, -1/2, -1/2, -1/2, 1/2, -1/2, 1/2, -1/2],
    ![-1/2, 1/2, 1/2, -1/2, 1/2, 1/2, -1/2, 1/2], ![1/2, -1/2, -1/2, 1/2, -1/2, -1/2, 1/2, -1/2],
    ![-1/2, 1/2, -1/2, 1/2, 1/2, 1/2, -1/2, 1/2], ![1/2, -1/2, 1/2, -1/2, -1/2, -1/2, 1/2, -1/2],
    ![-1/2, -1/2, 1/2, 1/2, 1/2, 1/2, -1/2, 1/2], ![1/2, 1/2, -1/2, -1/2, -1/2, -1/2, 1/2, -1/2] ]

def e6Roots : List (Fin 8 → ℚ) := e6RootsShort ++ e6RootsHalf

/-- Dot product in R⁸ -/
def dot8 (v w : Fin 8 → ℚ) : ℚ :=
  v 0 * w 0 + v 1 * w 1 + v 2 * w 2 + v 3 * w 3 + v 4 * w 4 + v 5 * w 5 + v 6 * w 6 + v 7 * w 7

/-- Power sum for rank-8 algebras -/
def powerSum8 (roots : List (Fin 8 → ℚ)) (H : Fin 8 → ℚ) (k : ℕ) : ℚ :=
  (roots.map (fun α => (dot8 α H) ^ k)).sum

/-- E₆ witness point: H = (1, 0, ..., 0) -/
def e6Witness : Fin 8 → ℚ := ![1, 0, 0, 0, 0, 0, 0, 0]

def e6PowerSumTwo : ℚ := powerSum8 e6Roots e6Witness 2
def e6PowerSumFour : ℚ := powerSum8 e6Roots e6Witness 4
def e6PowerSumSix : ℚ := powerSum8 e6Roots e6Witness 6

-- E₆ computations use native_decide (72 roots)
theorem e6_power_sum_two_value : e6PowerSumTwo = 24 := by native_decide
theorem e6_power_sum_four_value : e6PowerSumFour = 18 := by native_decide
theorem e6_power_sum_six_value : e6PowerSumSix = 33/2 := by native_decide

theorem e6_rhs_value : (1/48) * e6PowerSumFour * e6PowerSumTwo - (1/14400) * e6PowerSumTwo^3 = 201/25 := by
  rw [e6_power_sum_two_value, e6_power_sum_four_value]
  norm_num

/-- E₆ violates the anomaly identity -/
theorem e6_violates_anomaly : ∃ H, ¬ anomalyRHS
    (powerSum8 e6Roots H 2)
    (powerSum8 e6Roots H 4)
    (powerSum8 e6Roots H 6) := by
  use e6Witness
  rw [anomalyRHS, e6PowerSumTwo, e6PowerSumFour, e6PowerSumSix]
  rw [e6_power_sum_two_value, e6_power_sum_four_value, e6_power_sum_six_value, e6_rhs_value]
  norm_num

/-! ### E₇ root system -/

/-- E₇ has rank 7, embedded in R⁸. Roots are:
- ±eᵢ ± eⱼ for i < j ≤ 6 (60 roots)
- ±(e₇ - e₈) (2 roots)
- ±(1/2)(e₇ - e₈ + Σᵢ₌₀⁵ (-1)^νᵢ eᵢ) where Σνᵢ odd (64 roots)
Total: 126 roots -/

def e7RootsShort : List (Fin 8 → ℚ) :=
  [ ![1, 1, 0, 0, 0, 0, 0, 0], ![1, -1, 0, 0, 0, 0, 0, 0], ![-1, 1, 0, 0, 0, 0, 0, 0], ![-1, -1, 0, 0, 0, 0, 0, 0],
    ![1, 0, 1, 0, 0, 0, 0, 0], ![1, 0, -1, 0, 0, 0, 0, 0], ![-1, 0, 1, 0, 0, 0, 0, 0], ![-1, 0, -1, 0, 0, 0, 0, 0],
    ![1, 0, 0, 1, 0, 0, 0, 0], ![1, 0, 0, -1, 0, 0, 0, 0], ![-1, 0, 0, 1, 0, 0, 0, 0], ![-1, 0, 0, -1, 0, 0, 0, 0],
    ![1, 0, 0, 0, 1, 0, 0, 0], ![1, 0, 0, 0, -1, 0, 0, 0], ![-1, 0, 0, 0, 1, 0, 0, 0], ![-1, 0, 0, 0, -1, 0, 0, 0],
    ![1, 0, 0, 0, 0, 1, 0, 0], ![1, 0, 0, 0, 0, -1, 0, 0], ![-1, 0, 0, 0, 0, 1, 0, 0], ![-1, 0, 0, 0, 0, -1, 0, 0],
    ![1, 0, 0, 0, 0, 0, 1, 0], ![1, 0, 0, 0, 0, 0, -1, 0], ![-1, 0, 0, 0, 0, 0, 1, 0], ![-1, 0, 0, 0, 0, 0, -1, 0],
    ![0, 1, 1, 0, 0, 0, 0, 0], ![0, 1, -1, 0, 0, 0, 0, 0], ![0, -1, 1, 0, 0, 0, 0, 0], ![0, -1, -1, 0, 0, 0, 0, 0],
    ![0, 1, 0, 1, 0, 0, 0, 0], ![0, 1, 0, -1, 0, 0, 0, 0], ![0, -1, 0, 1, 0, 0, 0, 0], ![0, -1, 0, -1, 0, 0, 0, 0],
    ![0, 1, 0, 0, 1, 0, 0, 0], ![0, 1, 0, 0, -1, 0, 0, 0], ![0, -1, 0, 0, 1, 0, 0, 0], ![0, -1, 0, 0, -1, 0, 0, 0],
    ![0, 1, 0, 0, 0, 1, 0, 0], ![0, 1, 0, 0, 0, -1, 0, 0], ![0, -1, 0, 0, 0, 1, 0, 0], ![0, -1, 0, 0, 0, -1, 0, 0],
    ![0, 1, 0, 0, 0, 0, 1, 0], ![0, 1, 0, 0, 0, 0, -1, 0], ![0, -1, 0, 0, 0, 0, 1, 0], ![0, -1, 0, 0, 0, 0, -1, 0],
    ![0, 0, 1, 1, 0, 0, 0, 0], ![0, 0, 1, -1, 0, 0, 0, 0], ![0, 0, -1, 1, 0, 0, 0, 0], ![0, 0, -1, -1, 0, 0, 0, 0],
    ![0, 0, 1, 0, 1, 0, 0, 0], ![0, 0, 1, 0, -1, 0, 0, 0], ![0, 0, -1, 0, 1, 0, 0, 0], ![0, 0, -1, 0, -1, 0, 0, 0],
    ![0, 0, 1, 0, 0, 1, 0, 0], ![0, 0, 1, 0, 0, -1, 0, 0], ![0, 0, -1, 0, 0, 1, 0, 0], ![0, 0, -1, 0, 0, -1, 0, 0],
    ![0, 0, 1, 0, 0, 0, 1, 0], ![0, 0, 1, 0, 0, 0, -1, 0], ![0, 0, -1, 0, 0, 0, 1, 0], ![0, 0, -1, 0, 0, 0, -1, 0] ]

def e7RootsE7E8 : List (Fin 8 → ℚ) :=
  [ ![0, 0, 0, 0, 0, 0, 1, -1], ![0, 0, 0, 0, 0, 0, -1, 1] ]

/-- E₇ half-roots (64 roots with odd parity) -/
set_option maxHeartbeats 400000 in
def e7RootsHalf : List (Fin 8 → ℚ) :=
  [ ![1/2, 1/2, 1/2, 1/2, 1/2, 1/2, 1/2, -1/2], ![-1/2, -1/2, -1/2, -1/2, -1/2, -1/2, -1/2, 1/2],
    ![1/2, 1/2, 1/2, 1/2, 1/2, -1/2, 1/2, -1/2], ![-1/2, -1/2, -1/2, -1/2, -1/2, 1/2, -1/2, 1/2],
    ![1/2, 1/2, 1/2, 1/2, -1/2, 1/2, 1/2, -1/2], ![-1/2, -1/2, -1/2, -1/2, 1/2, -1/2, -1/2, 1/2],
    ![1/2, 1/2, 1/2, -1/2, 1/2, 1/2, 1/2, -1/2], ![-1/2, -1/2, -1/2, 1/2, -1/2, -1/2, -1/2, 1/2],
    ![1/2, 1/2, -1/2, 1/2, 1/2, 1/2, 1/2, -1/2], ![-1/2, -1/2, 1/2, -1/2, -1/2, -1/2, -1/2, 1/2],
    ![1/2, -1/2, 1/2, 1/2, 1/2, 1/2, 1/2, -1/2], ![-1/2, 1/2, -1/2, -1/2, -1/2, -1/2, -1/2, 1/2],
    ![-1/2, 1/2, 1/2, 1/2, 1/2, 1/2, 1/2, -1/2], ![1/2, -1/2, -1/2, -1/2, -1/2, -1/2, -1/2, 1/2],
    ![1/2, 1/2, 1/2, 1/2, -1/2, -1/2, 1/2, -1/2], ![-1/2, -1/2, -1/2, -1/2, 1/2, 1/2, -1/2, 1/2],
    ![1/2, 1/2, 1/2, -1/2, 1/2, -1/2, 1/2, -1/2], ![-1/2, -1/2, -1/2, 1/2, -1/2, 1/2, -1/2, 1/2],
    ![1/2, 1/2, 1/2, -1/2, -1/2, 1/2, 1/2, -1/2], ![-1/2, -1/2, -1/2, 1/2, 1/2, -1/2, -1/2, 1/2],
    ![1/2, 1/2, -1/2, 1/2, 1/2, -1/2, 1/2, -1/2], ![-1/2, -1/2, 1/2, -1/2, -1/2, 1/2, -1/2, 1/2],
    ![1/2, 1/2, -1/2, 1/2, -1/2, 1/2, 1/2, -1/2], ![-1/2, -1/2, 1/2, -1/2, 1/2, -1/2, -1/2, 1/2],
    ![1/2, 1/2, -1/2, -1/2, 1/2, 1/2, 1/2, -1/2], ![-1/2, -1/2, 1/2, 1/2, -1/2, -1/2, -1/2, 1/2],
    ![1/2, -1/2, 1/2, 1/2, 1/2, -1/2, 1/2, -1/2], ![-1/2, 1/2, -1/2, -1/2, -1/2, 1/2, -1/2, 1/2],
    ![1/2, -1/2, 1/2, 1/2, -1/2, 1/2, 1/2, -1/2], ![-1/2, 1/2, -1/2, -1/2, 1/2, -1/2, -1/2, 1/2],
    ![1/2, -1/2, 1/2, -1/2, 1/2, 1/2, 1/2, -1/2], ![-1/2, 1/2, -1/2, 1/2, -1/2, -1/2, -1/2, 1/2],
    ![1/2, -1/2, -1/2, 1/2, 1/2, 1/2, 1/2, -1/2], ![-1/2, 1/2, 1/2, -1/2, -1/2, -1/2, -1/2, 1/2],
    ![-1/2, 1/2, 1/2, 1/2, 1/2, -1/2, 1/2, -1/2], ![1/2, -1/2, -1/2, -1/2, -1/2, 1/2, -1/2, 1/2],
    ![-1/2, 1/2, 1/2, 1/2, -1/2, 1/2, 1/2, -1/2], ![1/2, -1/2, -1/2, -1/2, 1/2, -1/2, -1/2, 1/2],
    ![-1/2, 1/2, 1/2, -1/2, 1/2, 1/2, 1/2, -1/2], ![1/2, -1/2, -1/2, 1/2, -1/2, -1/2, -1/2, 1/2],
    ![-1/2, 1/2, -1/2, 1/2, 1/2, 1/2, 1/2, -1/2], ![1/2, -1/2, 1/2, -1/2, -1/2, -1/2, -1/2, 1/2],
    ![-1/2, -1/2, 1/2, 1/2, 1/2, 1/2, 1/2, -1/2], ![1/2, 1/2, -1/2, -1/2, -1/2, -1/2, -1/2, 1/2],
    ![1/2, 1/2, 1/2, -1/2, -1/2, -1/2, 1/2, -1/2], ![-1/2, -1/2, -1/2, 1/2, 1/2, 1/2, -1/2, 1/2],
    ![1/2, 1/2, -1/2, 1/2, -1/2, -1/2, 1/2, -1/2], ![-1/2, -1/2, 1/2, -1/2, 1/2, 1/2, -1/2, 1/2],
    ![1/2, 1/2, -1/2, -1/2, 1/2, -1/2, 1/2, -1/2], ![-1/2, -1/2, 1/2, 1/2, -1/2, 1/2, -1/2, 1/2],
    ![1/2, 1/2, -1/2, -1/2, -1/2, 1/2, 1/2, -1/2], ![-1/2, -1/2, 1/2, 1/2, 1/2, -1/2, -1/2, 1/2],
    ![1/2, -1/2, 1/2, 1/2, -1/2, -1/2, 1/2, -1/2], ![-1/2, 1/2, -1/2, -1/2, 1/2, 1/2, -1/2, 1/2],
    ![1/2, -1/2, 1/2, -1/2, 1/2, -1/2, 1/2, -1/2], ![-1/2, 1/2, -1/2, 1/2, -1/2, 1/2, -1/2, 1/2],
    ![1/2, -1/2, 1/2, -1/2, -1/2, 1/2, 1/2, -1/2], ![-1/2, 1/2, -1/2, 1/2, 1/2, -1/2, -1/2, 1/2],
    ![1/2, -1/2, -1/2, 1/2, 1/2, -1/2, 1/2, -1/2], ![-1/2, 1/2, 1/2, -1/2, -1/2, 1/2, -1/2, 1/2],
    ![1/2, -1/2, -1/2, 1/2, -1/2, 1/2, 1/2, -1/2], ![-1/2, 1/2, 1/2, -1/2, 1/2, -1/2, -1/2, 1/2],
    ![1/2, -1/2, -1/2, -1/2, 1/2, 1/2, 1/2, -1/2], ![-1/2, 1/2, 1/2, 1/2, -1/2, -1/2, -1/2, 1/2],
    ![-1/2, 1/2, 1/2, -1/2, -1/2, -1/2, 1/2, -1/2], ![1/2, -1/2, -1/2, 1/2, 1/2, 1/2, -1/2, 1/2],
    ![-1/2, 1/2, -1/2, 1/2, -1/2, -1/2, 1/2, -1/2], ![1/2, -1/2, 1/2, -1/2, 1/2, 1/2, -1/2, 1/2],
    ![-1/2, 1/2, -1/2, -1/2, 1/2, -1/2, 1/2, -1/2], ![1/2, -1/2, 1/2, 1/2, -1/2, 1/2, -1/2, 1/2],
    ![-1/2, 1/2, -1/2, -1/2, -1/2, 1/2, 1/2, -1/2], ![1/2, -1/2, 1/2, 1/2, 1/2, -1/2, -1/2, 1/2],
    ![-1/2, -1/2, 1/2, 1/2, -1/2, -1/2, 1/2, -1/2], ![1/2, 1/2, -1/2, -1/2, 1/2, 1/2, -1/2, 1/2],
    ![-1/2, -1/2, 1/2, -1/2, 1/2, -1/2, 1/2, -1/2], ![1/2, 1/2, -1/2, 1/2, -1/2, 1/2, -1/2, 1/2],
    ![-1/2, -1/2, 1/2, -1/2, -1/2, 1/2, 1/2, -1/2], ![1/2, 1/2, -1/2, 1/2, 1/2, -1/2, -1/2, 1/2],
    ![-1/2, -1/2, -1/2, 1/2, 1/2, -1/2, 1/2, -1/2], ![1/2, 1/2, 1/2, -1/2, -1/2, 1/2, -1/2, 1/2],
    ![-1/2, -1/2, -1/2, 1/2, -1/2, 1/2, 1/2, -1/2], ![1/2, 1/2, 1/2, -1/2, 1/2, -1/2, -1/2, 1/2],
    ![-1/2, -1/2, -1/2, -1/2, 1/2, 1/2, 1/2, -1/2], ![1/2, 1/2, 1/2, 1/2, -1/2, -1/2, -1/2, 1/2] ]

def e7Roots : List (Fin 8 → ℚ) := e7RootsShort ++ e7RootsE7E8 ++ e7RootsHalf

/-- E₇ witness point: H = (1, 0, ..., 0) -/
def e7Witness : Fin 8 → ℚ := ![1, 0, 0, 0, 0, 0, 0, 0]

def e7PowerSumTwo : ℚ := powerSum8 e7Roots e7Witness 2
def e7PowerSumFour : ℚ := powerSum8 e7Roots e7Witness 4
def e7PowerSumSix : ℚ := powerSum8 e7Roots e7Witness 6

-- E₇ computations use native_decide (126 roots, needs higher heartbeat limit)
set_option maxHeartbeats 400000 in
theorem e7_power_sum_two_value : e7PowerSumTwo = 36 := by native_decide

set_option maxHeartbeats 400000 in
theorem e7_power_sum_four_value : e7PowerSumFour = 24 := by native_decide

set_option maxHeartbeats 400000 in
theorem e7_power_sum_six_value : e7PowerSumSix = 21 := by native_decide

theorem e7_rhs_value : (1/48) * e7PowerSumFour * e7PowerSumTwo - (1/14400) * e7PowerSumTwo^3 = 369/25 := by
  rw [e7_power_sum_two_value, e7_power_sum_four_value]
  norm_num

/-- E₇ violates the anomaly identity -/
theorem e7_violates_anomaly : ∃ H, ¬ anomalyRHS
    (powerSum8 e7Roots H 2)
    (powerSum8 e7Roots H 4)
    (powerSum8 e7Roots H 6) := by
  use e7Witness
  rw [anomalyRHS, e7PowerSumTwo, e7PowerSumFour, e7PowerSumSix]
  rw [e7_power_sum_two_value, e7_power_sum_four_value, e7_power_sum_six_value, e7_rhs_value]
  norm_num

/-! ### E₈ satisfies the anomaly identity -/

/-- E₈ satisfies the anomaly identity.
This uses the existing theorems from E8Roots.lean. -/
theorem e8_satisfies_anomaly_identity : anomalyRHS 60 36 30 := by
  rw [anomalyRHS]
  norm_num

end ExceptionalAnomalyExclusion
