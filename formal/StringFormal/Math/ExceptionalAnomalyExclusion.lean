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
# Exceptional Lie Algebras and D=10 Anomaly Exclusion (PARTIAL)

This file formalizes the computational exclusion of exceptional Lie algebras
from the D=10 anomaly cancellation condition.

## Current status: G₂, F₄, E₆

* `g2_violates_anomaly`: G₂ does not satisfy the anomaly identity ✓
* `f4_violates_anomaly`: F₄ does not satisfy the anomaly identity ✓
* `e6_violates_anomaly`: E₆ does not satisfy the anomaly identity ✓

All power-sum theorems are proved by unfolding the finite root list at a
fixed witness Cartan element with `simp only [...]; norm_num` (kernel-checked,
no `native_decide`, no non-standard axioms).

## Postmortem: the earlier "native_decide computes incorrect values" claim for E₆

An earlier version of this file enumerated E₆'s 72 roots as a list literal and
reported (in this docstring) that `native_decide` "computes incorrect values"
for E₆, as if the tool/tactic were at fault. **That diagnosis was wrong.** The
actual bug was in the root table itself:

* The "D₅ block" (`±eᵢ ± eⱼ`) is supposed to range over the 10 pairs `i < j`
  drawn from a fixed set of **5** coordinates (Bourbaki: indices `1..5`,
  0-indexed here `0..4`), giving `C(5,2) · 4 = 40` roots. The old list instead
  used pairs drawn from **6** coordinates `{0,...,5}` but only listed 10 of
  the 15 possible such pairs (it happened to omit `(2,4),(2,5),(3,4),(3,5),(4,5)`),
  so it had the right *length* (40) but the *wrong vectors*: index 5 leaks
  into the "short root" block where it must not appear, and several genuine
  short roots are missing.
* The "half/spinor block" `½(e₈−e₇−e₆+Σ ±eᵢ)` is supposed to sum over the
  same **5** coordinates `i = 0..4` (with `0..4` alternating sign, an *even*
  number of minus signs) while coordinates `5,6,7` (`e₆,e₇,e₈`) stay **fixed**
  at `(-1/2,-1/2,+1/2)`. The old list instead let the sum range over `i = 0..5`
  (six coordinates, an off-by-one in the upper limit inherited from the same
  bug as above) and only fixed the last **two** coordinates, so coordinate 5
  varied when it should have been pinned at `-1/2`.

Both defects trace back to the same off-by-one confusion between the
Bourbaki 1-indexed range `i ≤ 5` (meaning 5 coordinates `1..5`) and a 0-indexed
range `i ≤ 5` (which wrongly reads as 6 coordinates `0..5`). The E₆ embedding
in `R⁸` is fully rational (all coordinates are `0, ±1, ±1/2`; no `√3` or other
irrational is needed — that only shows up in the *unrelated* 6-dimensional
presentation of E₆, which this file does not use), so there was never a
"can't write E₆ over ℚ" obstruction; the fix below is exactly the standard
Bourbaki 8-dimensional root list with the index range corrected. As a
consistency check, the corrected list reproduces *exactly* the power-sum
values (`S₂=24, S₄=18, S₆=33/2`, anomaly RHS `201/25`) that the old,
never-successfully-checked docstring already claimed — i.e. whoever wrote the
original file had the right target numbers in mind and only mis-transcribed
the root list that was supposed to produce them.

## E₇: still NOT IMPLEMENTED

`E₇ (126 roots)` times out during elaboration of a direct list unfold
(600k+ heartbeats insufficient) even after fixing indexing bugs of the same
kind as E₆'s. Follow the pattern from `StringFormal/Math/E8Roots.lean` if
this is revisited:

1. Define helper functions to build roots programmatically
   (e.g., `vroot`, `pairs`, sign patterns)
2. Prove power sum identities **algebraically** for arbitrary Cartan elements
   using structured decomposition of the root system
3. Specialize to witness points for the violation proofs

## References

* research/attempts/d10-anomaly-full-classification/proof.md §6.5
* formal/StringFormal/Math/E8Roots.lean (successful pattern; also the source
  of the `Matrix.cons_val` dsimproc trick used below for `Fin 8` indices ≥ 4)
* formal/BLUEPRINT-d10-anomaly.md lines 15-16, 166 (Killing-Cartan note)
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
  [ ![1, -1, 0], ![-1, 1, 0], ![1, 0, -1], ![-1, 0, 1], ![0, 1, -1], ![0, -1, 1],
    ![2, -1, -1], ![-2, 1, 1], ![-1, 2, -1], ![1, -2, 1], ![-1, -1, 2], ![1, 1, -2] ]

/-- Dot product in R³ -/
def dot3 (v w : Fin 3 → ℚ) : ℚ := v 0 * w 0 + v 1 * w 1 + v 2 * w 2

/-- Power sum Sₖ = Σ_{α∈Φ} α(H)^k for a Cartan element H -/
def powerSum3 (roots : List (Fin 3 → ℚ)) (H : Fin 3 → ℚ) (k : ℕ) : ℚ :=
  (roots.map (fun α => (dot3 α H) ^ k)).sum

/-- G₂ witness point: H = (1, 0, -1) -/
def g2Witness : Fin 3 → ℚ := ![1, 0, -1]

def g2PowerSumTwo : ℚ := powerSum3 g2Roots g2Witness 2
def g2PowerSumFour : ℚ := powerSum3 g2Roots g2Witness 4
def g2PowerSumSix : ℚ := powerSum3 g2Roots g2Witness 6

theorem g2_power_sum_two_value : g2PowerSumTwo = 48 := by
  simp only [g2PowerSumTwo, powerSum3, g2Roots, g2Witness, dot3, List.map_cons, List.map_nil,
    List.sum_cons, List.sum_nil, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons,
    Matrix.cons_val_two, Matrix.tail_cons]
  norm_num

theorem g2_power_sum_four_value : g2PowerSumFour = 360 := by
  simp only [g2PowerSumFour, powerSum3, g2Roots, g2Witness, dot3, List.map_cons, List.map_nil,
    List.sum_cons, List.sum_nil, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons,
    Matrix.cons_val_two, Matrix.tail_cons]
  norm_num

theorem g2_power_sum_six_value : g2PowerSumSix = 3048 := by
  simp only [g2PowerSumSix, powerSum3, g2Roots, g2Witness, dot3, List.map_cons, List.map_nil,
    List.sum_cons, List.sum_nil, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons,
    Matrix.cons_val_two, Matrix.tail_cons]
  norm_num

theorem g2_rhs_value : (1/48) * g2PowerSumFour * g2PowerSumTwo - (1/14400) * g2PowerSumTwo^3 = 8808/25 := by
  rw [g2_power_sum_two_value, g2_power_sum_four_value]
  norm_num

/-- G₂ violates the anomaly identity -/
theorem g2_violates_anomaly : ∃ H, ¬ anomalyRHS
    (powerSum3 g2Roots H 2)
    (powerSum3 g2Roots H 4)
    (powerSum3 g2Roots H 6) := by
  use g2Witness
  show ¬ anomalyRHS g2PowerSumTwo g2PowerSumFour g2PowerSumSix
  rw [anomalyRHS, g2_power_sum_two_value, g2_power_sum_four_value, g2_power_sum_six_value]
  norm_num

/-! ### F₄ root system -/

/-- F₄ has rank 4. Roots are:
- D₄ roots: ±eᵢ ± eⱼ for i < j (24 roots)
- Short roots: ±eᵢ for i = 0..3 (8 roots)
- Half-roots: (±1/2, ±1/2, ±1/2, ±1/2) (16 roots)
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

theorem f4_power_sum_two_value : f4PowerSumTwo = 18 := by
  simp only [f4PowerSumTwo, powerSum4, f4Roots, f4RootsD4, f4RootsShort, f4RootsHalf, f4Witness,
    dot4, List.cons_append, List.nil_append, List.map_cons, List.map_nil,
    List.sum_cons, List.sum_nil, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.tail_cons]
  norm_num

theorem f4_power_sum_four_value : f4PowerSumFour = 15 := by
  simp only [f4PowerSumFour, powerSum4, f4Roots, f4RootsD4, f4RootsShort, f4RootsHalf, f4Witness,
    dot4, List.cons_append, List.nil_append, List.map_cons, List.map_nil,
    List.sum_cons, List.sum_nil, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.tail_cons]
  norm_num

theorem f4_power_sum_six_value : f4PowerSumSix = 57/4 := by
  simp only [f4PowerSumSix, powerSum4, f4Roots, f4RootsD4, f4RootsShort, f4RootsHalf, f4Witness,
    dot4, List.cons_append, List.nil_append, List.map_cons, List.map_nil,
    List.sum_cons, List.sum_nil, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.tail_cons]
  norm_num

theorem f4_rhs_value : (1/48) * f4PowerSumFour * f4PowerSumTwo - (1/14400) * f4PowerSumTwo^3 = 261/50 := by
  rw [f4_power_sum_two_value, f4_power_sum_four_value]
  norm_num

/-- F₄ violates the anomaly identity -/
theorem f4_violates_anomaly : ∃ H, ¬ anomalyRHS
    (powerSum4 f4Roots H 2)
    (powerSum4 f4Roots H 4)
    (powerSum4 f4Roots H 6) := by
  use f4Witness
  show ¬ anomalyRHS f4PowerSumTwo f4PowerSumFour f4PowerSumSix
  rw [anomalyRHS, f4_power_sum_two_value, f4_power_sum_four_value, f4_power_sum_six_value]
  norm_num

/-! ### E₆ root system -/

/-- E₆ has rank 6, embedded in R⁸ (Bourbaki convention, coordinates `0..7`).
- D₅ block: `±eᵢ ± eⱼ` for `0 ≤ i < j ≤ 4` (40 roots, only 5 of the 8
  coordinates are ever touched)
- Half/spinor block: `±(1/2)(ε₀,ε₁,ε₂,ε₃,ε₄,-1,-1,1)` with `εᵢ = ±1` and an
  even number of `εᵢ = -1` among `i = 0..4` (32 roots: 16 sign patterns × 2)
Total: 72 roots. See the file docstring for the index-range bug this fixes
relative to an earlier (incorrect) version of this list. -/
def e6RootsD5 : List (Fin 8 → ℚ) :=
  [ ![1,1,0,0,0,0,0,0], ![1,-1,0,0,0,0,0,0], ![-1,1,0,0,0,0,0,0], ![-1,-1,0,0,0,0,0,0],
    ![1,0,1,0,0,0,0,0], ![1,0,-1,0,0,0,0,0], ![-1,0,1,0,0,0,0,0], ![-1,0,-1,0,0,0,0,0],
    ![1,0,0,1,0,0,0,0], ![1,0,0,-1,0,0,0,0], ![-1,0,0,1,0,0,0,0], ![-1,0,0,-1,0,0,0,0],
    ![1,0,0,0,1,0,0,0], ![1,0,0,0,-1,0,0,0], ![-1,0,0,0,1,0,0,0], ![-1,0,0,0,-1,0,0,0],
    ![0,1,1,0,0,0,0,0], ![0,1,-1,0,0,0,0,0], ![0,-1,1,0,0,0,0,0], ![0,-1,-1,0,0,0,0,0],
    ![0,1,0,1,0,0,0,0], ![0,1,0,-1,0,0,0,0], ![0,-1,0,1,0,0,0,0], ![0,-1,0,-1,0,0,0,0],
    ![0,1,0,0,1,0,0,0], ![0,1,0,0,-1,0,0,0], ![0,-1,0,0,1,0,0,0], ![0,-1,0,0,-1,0,0,0],
    ![0,0,1,1,0,0,0,0], ![0,0,1,-1,0,0,0,0], ![0,0,-1,1,0,0,0,0], ![0,0,-1,-1,0,0,0,0],
    ![0,0,1,0,1,0,0,0], ![0,0,1,0,-1,0,0,0], ![0,0,-1,0,1,0,0,0], ![0,0,-1,0,-1,0,0,0],
    ![0,0,0,1,1,0,0,0], ![0,0,0,1,-1,0,0,0], ![0,0,0,-1,1,0,0,0], ![0,0,0,-1,-1,0,0,0] ]

/-- The 32 half/spinor roots of E₆: for each of the 16 sign patterns
`(ε₀,...,ε₄)` with an even number of minus signs, both `½(ε,-1,-1,1)` and its
negation. -/
def e6RootsHalf : List (Fin 8 → ℚ) :=
  [ ![1/2,1/2,1/2,1/2,1/2,-1/2,-1/2,1/2], ![-1/2,-1/2,-1/2,-1/2,-1/2,1/2,1/2,-1/2],
    ![-1/2,-1/2,1/2,1/2,1/2,-1/2,-1/2,1/2], ![1/2,1/2,-1/2,-1/2,-1/2,1/2,1/2,-1/2],
    ![-1/2,1/2,-1/2,1/2,1/2,-1/2,-1/2,1/2], ![1/2,-1/2,1/2,-1/2,-1/2,1/2,1/2,-1/2],
    ![-1/2,1/2,1/2,-1/2,1/2,-1/2,-1/2,1/2], ![1/2,-1/2,-1/2,1/2,-1/2,1/2,1/2,-1/2],
    ![-1/2,1/2,1/2,1/2,-1/2,-1/2,-1/2,1/2], ![1/2,-1/2,-1/2,-1/2,1/2,1/2,1/2,-1/2],
    ![1/2,-1/2,-1/2,1/2,1/2,-1/2,-1/2,1/2], ![-1/2,1/2,1/2,-1/2,-1/2,1/2,1/2,-1/2],
    ![1/2,-1/2,1/2,-1/2,1/2,-1/2,-1/2,1/2], ![-1/2,1/2,-1/2,1/2,-1/2,1/2,1/2,-1/2],
    ![1/2,-1/2,1/2,1/2,-1/2,-1/2,-1/2,1/2], ![-1/2,1/2,-1/2,-1/2,1/2,1/2,1/2,-1/2],
    ![1/2,1/2,-1/2,-1/2,1/2,-1/2,-1/2,1/2], ![-1/2,-1/2,1/2,1/2,-1/2,1/2,1/2,-1/2],
    ![1/2,1/2,-1/2,1/2,-1/2,-1/2,-1/2,1/2], ![-1/2,-1/2,1/2,-1/2,1/2,1/2,1/2,-1/2],
    ![1/2,1/2,1/2,-1/2,-1/2,-1/2,-1/2,1/2], ![-1/2,-1/2,-1/2,1/2,1/2,1/2,1/2,-1/2],
    ![1/2,-1/2,-1/2,-1/2,-1/2,-1/2,-1/2,1/2], ![-1/2,1/2,1/2,1/2,1/2,1/2,1/2,-1/2],
    ![-1/2,1/2,-1/2,-1/2,-1/2,-1/2,-1/2,1/2], ![1/2,-1/2,1/2,1/2,1/2,1/2,1/2,-1/2],
    ![-1/2,-1/2,1/2,-1/2,-1/2,-1/2,-1/2,1/2], ![1/2,1/2,-1/2,1/2,1/2,1/2,1/2,-1/2],
    ![-1/2,-1/2,-1/2,1/2,-1/2,-1/2,-1/2,1/2], ![1/2,1/2,1/2,-1/2,1/2,1/2,1/2,-1/2],
    ![-1/2,-1/2,-1/2,-1/2,1/2,-1/2,-1/2,1/2], ![1/2,1/2,1/2,1/2,-1/2,1/2,1/2,-1/2] ]

def e6Roots : List (Fin 8 → ℚ) := e6RootsD5 ++ e6RootsHalf

/-- Dot product in R⁸ -/
def dot8 (v w : Fin 8 → ℚ) : ℚ :=
  v 0 * w 0 + v 1 * w 1 + v 2 * w 2 + v 3 * w 3 + v 4 * w 4 + v 5 * w 5 + v 6 * w 6 + v 7 * w 7

/-- Power sum for rank-8 (E₆/E₇/E₈) algebras -/
def powerSum8 (roots : List (Fin 8 → ℚ)) (H : Fin 8 → ℚ) (k : ℕ) : ℚ :=
  (roots.map (fun α => (dot8 α H) ^ k)).sum

/-- E₆ witness point: H = (1, 0, 0, 0, 0, 0, 0, 0) -/
def e6Witness : Fin 8 → ℚ := ![1, 0, 0, 0, 0, 0, 0, 0]

def e6PowerSumTwo : ℚ := powerSum8 e6Roots e6Witness 2
def e6PowerSumFour : ℚ := powerSum8 e6Roots e6Witness 4
def e6PowerSumSix : ℚ := powerSum8 e6Roots e6Witness 6

theorem e6_power_sum_two_value : e6PowerSumTwo = 24 := by
  simp only [e6PowerSumTwo, powerSum8, e6Roots, e6RootsD5, e6RootsHalf, e6Witness,
    dot8, List.cons_append, List.nil_append, List.map_cons, List.map_nil,
    List.sum_cons, List.sum_nil, Matrix.cons_val]
  norm_num

theorem e6_power_sum_four_value : e6PowerSumFour = 18 := by
  simp only [e6PowerSumFour, powerSum8, e6Roots, e6RootsD5, e6RootsHalf, e6Witness,
    dot8, List.cons_append, List.nil_append, List.map_cons, List.map_nil,
    List.sum_cons, List.sum_nil, Matrix.cons_val]
  norm_num

theorem e6_power_sum_six_value : e6PowerSumSix = 33/2 := by
  simp only [e6PowerSumSix, powerSum8, e6Roots, e6RootsD5, e6RootsHalf, e6Witness,
    dot8, List.cons_append, List.nil_append, List.map_cons, List.map_nil,
    List.sum_cons, List.sum_nil, Matrix.cons_val]
  norm_num

theorem e6_rhs_value : (1/48) * e6PowerSumFour * e6PowerSumTwo - (1/14400) * e6PowerSumTwo^3 = 201/25 := by
  rw [e6_power_sum_two_value, e6_power_sum_four_value]
  norm_num

/-- E₆ violates the anomaly identity -/
theorem e6_violates_anomaly : ∃ H, ¬ anomalyRHS
    (powerSum8 e6Roots H 2)
    (powerSum8 e6Roots H 4)
    (powerSum8 e6Roots H 6) := by
  use e6Witness
  show ¬ anomalyRHS e6PowerSumTwo e6PowerSumFour e6PowerSumSix
  rw [anomalyRHS, e6_power_sum_two_value, e6_power_sum_four_value, e6_power_sum_six_value]
  norm_num

end ExceptionalAnomalyExclusion
