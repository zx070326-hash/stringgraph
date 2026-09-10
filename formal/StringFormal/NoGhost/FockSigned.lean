/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import StringFormal.NoGhost.Fock

/-!
# Indefiniteness of the Fock form over an ordered ground ring

Graph node: `worldsheet.fock-indefinite-form`, part (4), last sentence.

`StringFormal/NoGhost/Fock.lean` works over an arbitrary `CommRing R`, which has no order, so
it can only compute the two *values* `⟨α^0_{-n}|k⟩, α^0_{-n}|k⟩⟩ = -n` and
`⟨α^i_{-n}|k⟩, α^i_{-n}|k⟩⟩ = +n` (`Fock.pairing_X_X_minkowski_timelike` and
`Fock.pairing_X_X_minkowski_spacelike`).  The graph node additionally asserts that *over an
ordered field and for `D ≥ 2` the form is therefore indefinite*; that last step was recorded as
gap (v) of the derivation `worldsheet.fock-indefinite-form--via-lean`.  This file closes it.

Nothing here touches `Fock.lean`; it only adds order hypotheses on the ground ring.

## Main statements

* `Fock.pairing_timelike_neg` / `Fock.pairing_spacelike_pos`: the explicit ghost and the
  explicit positive-norm state, at every level `n ≥ 1`.
* `Fock.exists_pairing_self_neg` (needs `D ≥ 1`), `Fock.exists_pairing_self_pos`
  (needs `D ≥ 2`).
* `Fock.pairing_indefinite`: **for `D ≥ 2` over an ordered ring the form takes both signs**.
* `Fock.pairing_indefinite_field`: the same, stated with the hypotheses of the graph node
  (`K` an ordered field).
* `Fock.not_forall_pairing_self_nonneg` / `Fock.not_forall_pairing_self_nonpos`: the form is
  neither positive nor negative semidefinite.
* `Fock.exists_mem_levelSubmodule_pairing_self_neg`: there is a negative-norm state in *every*
  level `n ≥ 1`, i.e. the ghosts are not confined to one graded piece.

## Conventions and hypotheses

* Metric convention `conv.metric-mostly-plus`: `η = diag(-1, +1, …, +1)` (`Fock.minkowski`).
* The ground ring is `[CommRing R] [PartialOrder R] [IsStrictOrderedRing R]`.  Mathlib
  `v4.33.1` has no `LinearOrderedField` class any more; the graph node's "ordered field" is
  `[Field K] [LinearOrder K] [IsStrictOrderedRing K]`, which is a special case
  (`pairing_indefinite_field`).  Nothing here needs division or totality of the order, so the
  general ordered-ring form is proved and the field form is a specialisation.
* `D ≥ 1` is what makes the timelike direction `μ = 0` exist, `D ≥ 2` what makes a spacelike
  direction `μ = 1` exist.  Both are necessary: for `D = 0` the space is `R` with the form
  `⟨a, b⟩ = a b`, and for `D = 1` the form is negative semidefinite on the whole space, so
  neither conclusion holds without its hypothesis.

## Status

Complete, no `sorry`.  Inherits all the gaps of `Fock.lean` (no zero modes, no completion,
diagonal metric only, real-bilinear rather than Hermitian).
-/

namespace StringFormal.NoGhost

open MvPolynomial

namespace Fock

section Ordered

variable {D : ℕ} {R : Type*} [CommRing R] [PartialOrder R] [IsStrictOrderedRing R]

/-- The timelike oscillator `α^0_{-n}` exists as soon as `D ≥ 1`. -/
private def timeDir (hD : 1 ≤ D) : Fin D := ⟨0, hD⟩

/-- A spacelike oscillator `α^1_{-n}` exists as soon as `D ≥ 2`. -/
private def spaceDir (hD : 2 ≤ D) : Fin D := ⟨1, hD⟩

private lemma coe_timeDir (hD : 1 ≤ D) : ((timeDir hD : Fin D) : ℕ) = 0 := rfl

private lemma coe_spaceDir (hD : 2 ≤ D) : ((spaceDir hD : Fin D) : ℕ) = 1 := rfl

/-- **The ghost.** With the mostly-plus metric the timelike one-oscillator state
`α^0_{-n}|k⟩` has strictly negative norm `-n < 0`. -/
theorem pairing_timelike_neg (D : ℕ) (R : Type*) [CommRing R] [PartialOrder R]
    [IsStrictOrderedRing R] {μ : Fin D} (hμ : (μ : ℕ) = 0) (n : ℕ+) :
    pairing (minkowski D R) (X ((μ, n) : Osc D)) (X ((μ, n) : Osc D)) < 0 := by
  rw [pairing_X_X_minkowski_timelike D R hμ n, neg_neg_iff_pos, Nat.cast_pos]
  exact n.pos

/-- With the mostly-plus metric a spacelike one-oscillator state has strictly positive
norm `+n > 0`. -/
theorem pairing_spacelike_pos (D : ℕ) (R : Type*) [CommRing R] [PartialOrder R]
    [IsStrictOrderedRing R] {μ : Fin D} (hμ : (μ : ℕ) ≠ 0) (n : ℕ+) :
    0 < pairing (minkowski D R) (X ((μ, n) : Osc D)) (X ((μ, n) : Osc D)) := by
  rw [pairing_X_X_minkowski_spacelike D R hμ n, Nat.cast_pos]
  exact n.pos

/-- For `D ≥ 1` the Fock form takes a strictly negative value: a *negative-norm state*
("ghost") exists.  This is the object the no-ghost theorem has to remove. -/
theorem exists_pairing_self_neg (D : ℕ) (hD : 1 ≤ D) (R : Type*) [CommRing R] [PartialOrder R]
    [IsStrictOrderedRing R] :
    ∃ v : Fock D R, pairing (minkowski D R) v v < 0 :=
  ⟨X ((timeDir hD, 1) : Osc D), pairing_timelike_neg D R (coe_timeDir hD) 1⟩

/-- For `D ≥ 2` the Fock form takes a strictly positive value. -/
theorem exists_pairing_self_pos (D : ℕ) (hD : 2 ≤ D) (R : Type*) [CommRing R] [PartialOrder R]
    [IsStrictOrderedRing R] :
    ∃ v : Fock D R, 0 < pairing (minkowski D R) v v :=
  ⟨X ((spaceDir hD, 1) : Osc D),
    pairing_spacelike_pos D R (by rw [coe_spaceDir hD]; exact one_ne_zero) 1⟩

/-- **The Fock form is indefinite.**  Over an ordered ground ring and for `D ≥ 2` the form
`⟨·,·⟩` induced by the mostly-plus metric takes both strictly negative and strictly positive
values on the diagonal.  This is the last sentence of part (4) of the graph node
`worldsheet.fock-indefinite-form`. -/
theorem pairing_indefinite (D : ℕ) (hD : 2 ≤ D) (R : Type*) [CommRing R] [PartialOrder R]
    [IsStrictOrderedRing R] :
    (∃ v : Fock D R, pairing (minkowski D R) v v < 0) ∧
      ∃ w : Fock D R, 0 < pairing (minkowski D R) w w :=
  ⟨exists_pairing_self_neg D (le_trans one_le_two hD) R, exists_pairing_self_pos D hD R⟩

/-- The form is not positive semidefinite (`D ≥ 1` suffices). -/
theorem not_forall_pairing_self_nonneg (D : ℕ) (hD : 1 ≤ D) (R : Type*) [CommRing R]
    [PartialOrder R] [IsStrictOrderedRing R] :
    ¬ ∀ v : Fock D R, 0 ≤ pairing (minkowski D R) v v := by
  intro hall
  obtain ⟨v, hv⟩ := exists_pairing_self_neg D hD R
  exact lt_irrefl (0 : R) (lt_of_le_of_lt (hall v) hv)

/-- The form is not negative semidefinite either (`D ≥ 2`). -/
theorem not_forall_pairing_self_nonpos (D : ℕ) (hD : 2 ≤ D) (R : Type*) [CommRing R]
    [PartialOrder R] [IsStrictOrderedRing R] :
    ¬ ∀ v : Fock D R, pairing (minkowski D R) v v ≤ 0 := by
  intro hall
  obtain ⟨w, hw⟩ := exists_pairing_self_pos D hD R
  exact lt_irrefl (0 : R) (lt_of_lt_of_le hw (hall w))

/-- Ghosts occur at **every** level `n ≥ 1`, not just in one graded piece: the state
`α^0_{-n}|k⟩` lies in `levelSubmodule D R n` and has norm `-n`. -/
theorem exists_mem_levelSubmodule_pairing_self_neg (D : ℕ) (hD : 1 ≤ D) (R : Type*)
    [CommRing R] [PartialOrder R] [IsStrictOrderedRing R] (n : ℕ+) :
    ∃ v ∈ levelSubmodule D R (n : ℕ), pairing (minkowski D R) v v < 0 := by
  refine ⟨X ((timeDir hD, n) : Osc D), ?_, pairing_timelike_neg D R (coe_timeDir hD) n⟩
  have h := creation_mem_levelSubmodule (R := R) (timeDir hD) n (one_mem_levelSubmodule D R)
  rwa [creation_apply, mul_one, Nat.add_zero] at h

end Ordered

/-- The graph node phrases the indefiniteness over an **ordered field** (e.g. `ℝ`).  Mathlib
`v4.33.1` no longer has a `LinearOrderedField` class, so the hypotheses are spelled out; this
is the special case of `pairing_indefinite` in which the ground ring happens to be a field with
a total order. -/
theorem pairing_indefinite_field (D : ℕ) (hD : 2 ≤ D) (K : Type*) [Field K] [LinearOrder K]
    [IsStrictOrderedRing K] :
    (∃ v : Fock D K, pairing (minkowski D K) v v < 0) ∧
      ∃ w : Fock D K, 0 < pairing (minkowski D K) w w :=
  pairing_indefinite D hD K

/-- Sanity check on a concrete ordered field. -/
example :
    (∃ v : Fock 26 ℚ, pairing (minkowski 26 ℚ) v v < 0) ∧
      ∃ w : Fock 26 ℚ, 0 < pairing (minkowski 26 ℚ) w w :=
  pairing_indefinite_field 26 (by norm_num) ℚ

end Fock

end StringFormal.NoGhost
