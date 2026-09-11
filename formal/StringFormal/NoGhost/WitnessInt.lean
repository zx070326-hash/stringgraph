/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.Witness

/-!
# An **integer** witness for the DDF geometric hypotheses

Graph nodes: `worldsheet.ddf-operators-v6`, `worldsheet.no-ghost-theorem-v4`;
blueprint `formal/BLUEPRINT-noghost.md` §C.2; reviewer batch 26.

`NoGhost/Witness.lean` exhibits a light-cone frame over an arbitrary commutative
`ℚ`-algebra and remarks that "`b·a = 1` together with `a·a = 2` forces `a = (1/2, 3/2, 0, …)`
in this frame, so `ℚ`-algebra is not laziness".  That remark is **about that particular
frame only**, and the reviewer is right that the stronger reading — "no witness exists over
`ℤ`" — is false.  Here is the counterexample:

```
η = diag(-1, +1, …, +1)
b = (1, 1, 0, 0, …)        light-like, b·b = 0
a = (0, 1, 1, 0, …)        b·a = 1 and a·a = 2
ε = e₂ = (0, 0, 1, 0, …)   ε·b = 0, ε·ε = 1
```

Every entry is an integer, and all five conditions hold over **any** commutative ring.  The
only reason `NoGhost/Witness.lean` needs `[Algebra ℚ R]` for the mass-shell clause is that it
writes it as `invTwo R * zeroModeSq η a = 1`; written in the equivalent denominator-free form
`zeroModeSq η a = 2` (i.e. `α' k² = 1` cleared of the `α' = 1/2` normalisation) the clause is
a statement about `2`, not about `1/2`.

## Main results

* `noghost_hypotheses_satisfiable_int` — the four DDF hypotheses plus `ε·ε = 1` plus the
  mass shell in the form `zeroModeSq η a = 2`, over an arbitrary `CommRing` with `D ≥ 3`.
* `noghost_hypotheses_satisfiable_int_ℤ` — the same, spelled out over `ℤ`.
* `noghost_hypotheses_satisfiable_int_transverse_momentum` — a `D ≥ 4` refinement with a
  polarisation that is in addition orthogonal to `k` (`ε·k = 0`), the extra condition that
  `NoGhost/LightCone.lean`'s `ddfOp_neg_one_apply_towerVacuum` needs.
* `invTwo_mul_zeroModeSq_of_eq_two` — over a `ℚ`-algebra the denominator-free mass shell
  implies the form used in the rest of the island.

## Scope

This says only that the *hypotheses* are satisfiable over `ℤ`.  The DDF **operators**
themselves (`Fock.Lop`, `ddfOp`, …) still require `[Algebra ℚ R]`, because the Sugawara
generator carries an explicit `½` and the vertex operator carries `1/(m^k k!)`.  So this is a
statement about the hypothesis set, not a claim that the island can be run over `ℤ`.
-/

namespace StringFormal.NoGhost

section IntWitness

variable {D : ℕ} {R : Type*} [CommRing R]

/-- The contraction of two vectors, each supported on a (possibly different) pair of basis
directions. -/
lemma dotVec_pair_pair (η : Fin D → R) (i j k l : Fin D) (c d c' d' : R) :
    dotVec η (Pi.single i c + Pi.single j d) (Pi.single k c' + Pi.single l d')
      = (if i = k then η i * c * c' else 0) + (if i = l then η i * c * d' else 0)
        + ((if j = k then η j * d * c' else 0) + (if j = l then η j * d * d' else 0)) := by
  classical
  rw [dotVec_add_left, dotVec_add_right, dotVec_add_right, dotVec_single_single,
    dotVec_single_single, dotVec_single_single, dotVec_single_single]

variable (D R)

/-- **The integer on-shell momentum** `k = (0, 1, 1, 0, …)`.  It satisfies `k_0·k = 1` and
`k·k = 2`, i.e. `α' k² = 1` with `α' = 1/2` — the same tachyonic shell as
`witnessMomentum`, but with no denominators. -/
noncomputable def witnessMomentumInt (hD : 3 ≤ D) : Fin D → R :=
  Pi.single (frameSpace D hD) 1 + Pi.single (frameTrans D hD) 1

/-- The second transverse index `μ = 3`, available once `D ≥ 4`. -/
def frameTrans' (hD : 4 ≤ D) : Fin D := ⟨3, by omega⟩

variable {D R}

lemma minkowski_frameTrans (hD : 3 ≤ D) : Fock.minkowski D R (frameTrans D hD) = 1 :=
  Fock.minkowski_spacelike D R (μ := frameTrans D hD) (by simp [frameTrans])

/-- `k_0 · k = 1`: the DDF normalisation, over any commutative ring. -/
theorem dotVec_witnessLight_witnessMomentumInt (hD : 3 ≤ D) :
    dotVec (Fock.minkowski D R) (witnessLight D R hD) (witnessMomentumInt D R hD) = 1 := by
  rw [witnessLight, witnessMomentumInt, dotVec_pair_pair,
    if_neg (frameTime_ne_frameSpace hD), if_neg (Ne.symm (frameTrans_ne_frameTime hD)),
    if_pos rfl, if_neg (Ne.symm (frameTrans_ne_frameSpace hD)), minkowski_frameSpace]
  ring

/-- `k · k = 2`, i.e. `α' k² = 1`: the tachyonic mass shell, cleared of denominators. -/
theorem zeroModeSq_witnessMomentumInt (hD : 3 ≤ D) :
    Fock.zeroModeSq (Fock.minkowski D R) (witnessMomentumInt D R hD) = 2 := by
  rw [zeroModeSq_eq_dotVec, witnessMomentumInt,
    dotVec_pair _ (Ne.symm (frameTrans_ne_frameSpace hD)), minkowski_frameSpace,
    minkowski_frameTrans]
  ring

/-- **The four DDF hypotheses, `ε·ε = 1` and the mass shell `k·k = 2` hold over an arbitrary
commutative ring** as soon as `D ≥ 3` — in particular over `ℤ`.

Witness: `η = diag(-1,+1,…,+1)`, `b = k_0 = (1,1,0,…)`, `a = k = (0,1,1,0,…)`, `ε = e₂`.
This refutes the reading of `NoGhost/Witness.lean`'s remark under which the DDF hypothesis
set would force denominators; what forces `a = (1/2, 3/2, 0, …)` there is the extra choice of
putting `a` inside the light-cone plane spanned by `b` and `b̃`. -/
theorem noghost_hypotheses_satisfiable_int (D : ℕ) (R : Type*) [CommRing R] (hD : 3 ≤ D) :
    ∃ η a b ε : Fin D → R,
      (∀ μ, η μ * η μ = 1) ∧ dotVec η b b = 0 ∧ dotVec η b a = 1 ∧ dotVec η ε b = 0 ∧
        dotVec η ε ε = 1 ∧ Fock.zeroModeSq η a = 2 := by
  classical
  refine ⟨Fock.minkowski D R, witnessMomentumInt D R hD, witnessLight D R hD,
    witnessPolarization D R (frameTrans D hD), minkowski_sq D R,
    dotVec_witnessLight_self hD, dotVec_witnessLight_witnessMomentumInt hD,
    dotVec_witnessPolarization_witnessLight hD (by simp [frameTrans]), ?_,
    zeroModeSq_witnessMomentumInt hD⟩
  rw [dotVec_witnessPolarization_witnessPolarization
    (show 2 ≤ ((frameTrans D hD : Fin D) : ℕ) by simp [frameTrans]), if_pos rfl]

/-- The witness spelled out over `ℤ`. -/
theorem noghost_hypotheses_satisfiable_int_ℤ (D : ℕ) (hD : 3 ≤ D) :
    ∃ η a b ε : Fin D → ℤ,
      (∀ μ, η μ * η μ = 1) ∧ dotVec η b b = 0 ∧ dotVec η b a = 1 ∧ dotVec η ε b = 0 ∧
        dotVec η ε ε = 1 ∧ Fock.zeroModeSq η a = 2 :=
  noghost_hypotheses_satisfiable_int D ℤ hD

/-- **The `D ≥ 4` refinement**: taking `ε = e₃` instead of `e₂` gives in addition `ε·k = 0`,
the extra frame condition that `NoGhost/LightCone.lean` needs for the leading term
`A^ε_{-1}|0;k⟩ = α^ε_{-1}|0;k-k_0⟩`.  (With `ε = e₂` one has `ε·k = 1 ≠ 0`, so the `D = 3`
witness above does *not* satisfy it — a concrete illustration that `ε·k_0 = 0` does not imply
`ε·k = 0`.) -/
theorem noghost_hypotheses_satisfiable_int_transverse_momentum (D : ℕ) (R : Type*)
    [CommRing R] (hD : 4 ≤ D) :
    ∃ η a b ε : Fin D → R,
      (∀ μ, η μ * η μ = 1) ∧ dotVec η b b = 0 ∧ dotVec η b a = 1 ∧ dotVec η ε b = 0 ∧
        dotVec η ε ε = 1 ∧ dotVec η ε a = 0 ∧ Fock.zeroModeSq η a = 2 := by
  classical
  have hD3 : 3 ≤ D := by omega
  have h2 : 2 ≤ ((frameTrans' D hD : Fin D) : ℕ) := by simp [frameTrans']
  refine ⟨Fock.minkowski D R, witnessMomentumInt D R hD3, witnessLight D R hD3,
    witnessPolarization D R (frameTrans' D hD), minkowski_sq D R,
    dotVec_witnessLight_self hD3, dotVec_witnessLight_witnessMomentumInt hD3,
    dotVec_witnessPolarization_witnessLight hD3 h2, ?_, ?_,
    zeroModeSq_witnessMomentumInt hD3⟩
  · rw [dotVec_witnessPolarization_witnessPolarization h2, if_pos rfl]
  · rw [witnessPolarization, witnessMomentumInt]
    refine dotVec_single_pair_of_ne _ ?_ ?_ _ _ _
    · simp only [ne_eq, Fin.ext_iff, frameTrans', frameSpace]; omega
    · simp only [ne_eq, Fin.ext_iff, frameTrans', frameTrans]; omega

/-- Over a `ℚ`-algebra the denominator-free mass shell `k·k = 2` is the form
`α' k² = invTwo * k·k = 1` used throughout the DDF island. -/
theorem invTwo_mul_zeroModeSq_of_eq_two {R : Type*} [CommRing R] [Algebra ℚ R]
    {η a : Fin D → R} (h : Fock.zeroModeSq η a = 2) :
    invTwo R * Fock.zeroModeSq η a = 1 := by
  rw [h, invTwo_mul_two]

end IntWitness

end StringFormal.NoGhost
