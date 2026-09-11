/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.DDF

/-!
# A witness for the DDF geometric hypotheses

Graph nodes: `worldsheet.ddf-operators-v6`, `worldsheet.no-ghost-theorem-v4`;
blueprint `formal/BLUEPRINT-noghost.md` §C.2.

Every theorem of the DDF island is a *conditional* statement, carrying the four geometric
hypotheses

| Lean | physics |
|---|---|
| `hη : ∀ μ, η μ * η μ = 1` | diagonal metric, `η_{μμ} = η^{μμ}` (`conv.metric-mostly-plus`) |
| `hbb : dotVec η b b = 0` | `k_0² = 0`, light-like reference direction |
| `hba : dotVec η b a = 1` | `2α' k_0 · k = 1`, the DDF normalisation |
| `hεb : dotVec η ε b = 0` | `ε · k_0 = 0`, transversality |

Before this file the repository contained **no** proof that the four can hold at once, so in
principle the whole island could have been vacuous.  Here we exhibit the standard light-cone
frame in `D ≥ 3` dimensions and check the hypotheses on it:

```
η   = diag(-1, +1, …, +1)        (`Fock.minkowski`)
b   = ( 1 ,  1 , 0, …, 0)        light-like
a   = (1/2, 3/2, 0, …, 0)        tachyonic shell, `α' k² = 1`, i.e. `a₀ = 1`
b̃   = (1/2, -1/2, 0, …, 0)       conjugate light-like direction, `b·b̃ = -1`
ε_i = Pi.single i 1  (i ≥ 2)     transverse polarisations, Gram = identity
```

## Main results

* `noghost_hypotheses_satisfiable` — the four hypotheses hold simultaneously, together with
  `ε·ε = 1` and the mass-shell condition `α' k² = 1` (`invTwo R * Fock.zeroModeSq η a = 1`).
* `noghost_lightcone_frame_satisfiable` — the same, with the conjugate direction `b̃`
  (`b·b̃ = -1`, `b̃·b̃ = 0`) added; this is the light-cone frame `{b, b̃, ε_i}`.
* `noghost_transverse_gram_satisfiable` — the `D - 2` transverse polarisations `ε_i = e_i`
  (`i ≥ 2`) are all transverse to `b` and have Gram matrix `δ_{ij}`, hence a positive definite
  transverse Gram over an ordered field.

## Scope

Everything is stated for an arbitrary commutative `ℚ`-algebra `R` (the halves are genuinely
needed: `b·a = 1` together with `a·a = 2` forces `a = (1/2, 3/2, 0, …)` in this frame).
Positivity of the transverse Gram is expressed as "Gram `= δ_{ij}`", which over an ordered
field gives positive definiteness but is stated here without any order hypothesis.
-/

namespace StringFormal.NoGhost

section DotVecAux

variable {D : ℕ} {R : Type*} [CommRing R]

/-- `dotVec` is additive in its left argument. -/
lemma dotVec_add_left (η x y z : Fin D → R) :
    dotVec η (x + y) z = dotVec η x z + dotVec η y z := by
  rw [dotVec, dotVec, dotVec, ← Finset.sum_add_distrib]
  exact Finset.sum_congr rfl fun μ _ => by simp only [Pi.add_apply]; ring

/-- `dotVec` is additive in its right argument. -/
lemma dotVec_add_right (η x y z : Fin D → R) :
    dotVec η x (y + z) = dotVec η x y + dotVec η x z := by
  rw [dotVec_comm, dotVec_add_left, dotVec_comm η y x, dotVec_comm η z x]

/-- Contracting a basis vector: `e_i·y = η_i c y^i`. -/
lemma dotVec_single_left (η : Fin D → R) (i : Fin D) (c : R) (y : Fin D → R) :
    dotVec η (Pi.single i c) y = η i * c * y i := by
  classical
  rw [dotVec, Finset.sum_eq_single_of_mem i (Finset.mem_univ i)
      (fun μ _ hμ => by rw [Pi.single_eq_of_ne hμ, mul_zero, zero_mul]), Pi.single_eq_same]

/-- Contracting two basis vectors: `e_i·e_j = δ_{ij} η_i c d`. -/
lemma dotVec_single_single (η : Fin D → R) (i j : Fin D) (c d : R) :
    dotVec η (Pi.single i c) (Pi.single j d) = if i = j then η i * c * d else 0 := by
  classical
  rw [dotVec_single_left]
  rcases eq_or_ne i j with rfl | h
  · rw [if_pos rfl, Pi.single_eq_same]
  · rw [if_neg h, Pi.single_eq_of_ne h, mul_zero]

/-- The contraction of two vectors living in the plane spanned by two distinct basis
directions. -/
lemma dotVec_pair (η : Fin D → R) {i j : Fin D} (hij : i ≠ j) (c d c' d' : R) :
    dotVec η (Pi.single i c + Pi.single j d) (Pi.single i c' + Pi.single j d')
      = η i * c * c' + η j * d * d' := by
  classical
  rw [dotVec_add_left, dotVec_single_left, dotVec_single_left]
  simp only [Pi.add_apply, Pi.single_eq_same, Pi.single_eq_of_ne hij,
    Pi.single_eq_of_ne hij.symm, add_zero, zero_add]

/-- A basis direction outside the plane spanned by two other basis directions is orthogonal to
everything in that plane. -/
lemma dotVec_single_pair_of_ne (η : Fin D → R) {k i j : Fin D} (hki : k ≠ i) (hkj : k ≠ j)
    (c₀ c d : R) : dotVec η (Pi.single k c₀) (Pi.single i c + Pi.single j d) = 0 := by
  classical
  rw [dotVec_single_left]
  simp only [Pi.add_apply, Pi.single_eq_of_ne hki, Pi.single_eq_of_ne hkj, add_zero, mul_zero]

end DotVecAux

/-! ### The light-cone frame in `D ≥ 3` dimensions -/

section Frame

variable (D : ℕ) (R : Type*) [CommRing R]

/-- The timelike index `μ = 0`. -/
def frameTime (hD : 3 ≤ D) : Fin D := ⟨0, by omega⟩

/-- The first spacelike index `μ = 1`; together with `frameTime` it spans the light-cone
plane. -/
def frameSpace (hD : 3 ≤ D) : Fin D := ⟨1, by omega⟩

/-- The first transverse index `μ = 2`. -/
def frameTrans (hD : 3 ≤ D) : Fin D := ⟨2, by omega⟩

variable {D R}

lemma frameTime_ne_frameSpace (hD : 3 ≤ D) : frameTime D hD ≠ frameSpace D hD := by
  simp [frameTime, frameSpace, Fin.ext_iff]

lemma frameTrans_ne_frameTime (hD : 3 ≤ D) : frameTrans D hD ≠ frameTime D hD := by
  simp [frameTrans, frameTime, Fin.ext_iff]

lemma frameTrans_ne_frameSpace (hD : 3 ≤ D) : frameTrans D hD ≠ frameSpace D hD := by
  simp [frameTrans, frameSpace, Fin.ext_iff]

lemma minkowski_frameTime (hD : 3 ≤ D) : Fock.minkowski D R (frameTime D hD) = -1 :=
  Fock.minkowski_timelike D R (μ := frameTime D hD) rfl

lemma minkowski_frameSpace (hD : 3 ≤ D) : Fock.minkowski D R (frameSpace D hD) = 1 :=
  Fock.minkowski_spacelike D R (μ := frameSpace D hD) (by simp [frameSpace])

/-- The mostly-plus metric squares to `1` componentwise: hypothesis `hη`. -/
theorem minkowski_sq (D : ℕ) (R : Type*) [CommRing R] (μ : Fin D) :
    Fock.minkowski D R μ * Fock.minkowski D R μ = 1 := by
  rcases eq_or_ne (μ : ℕ) 0 with h | h
  · rw [Fock.minkowski_timelike D R h]; ring
  · rw [Fock.minkowski_spacelike D R h]; ring

variable (D R)

/-- The light-like reference vector `k_0 = (1, 1, 0, …, 0)`. -/
noncomputable def witnessLight (hD : 3 ≤ D) : Fin D → R :=
  Pi.single (frameTime D hD) 1 + Pi.single (frameSpace D hD) 1

/-- The on-shell momentum `k = (1/2, 3/2, 0, …, 0)`; it satisfies `α' k² = 1`, the tachyonic
mass shell of the bosonic string at intercept `a₀ = 1`. -/
noncomputable def witnessMomentum [Algebra ℚ R] (hD : 3 ≤ D) : Fin D → R :=
  Pi.single (frameTime D hD) (invTwo R) + Pi.single (frameSpace D hD) (3 * invTwo R)

/-- The conjugate light-like direction `k̃ = (1/2, -1/2, 0, …, 0)`, normalised by
`k_0 · k̃ = -1`. -/
noncomputable def witnessConjugate [Algebra ℚ R] (hD : 3 ≤ D) : Fin D → R :=
  Pi.single (frameTime D hD) (invTwo R) + Pi.single (frameSpace D hD) (-invTwo R)

/-- The transverse polarisation `ε_i = e_i` for a transverse index `i` (`i ≥ 2`). -/
noncomputable def witnessPolarization (i : Fin D) : Fin D → R := Pi.single i 1

variable {D R}

@[simp]
lemma dotVec_witnessLight_self (hD : 3 ≤ D) :
    dotVec (Fock.minkowski D R) (witnessLight D R hD) (witnessLight D R hD) = 0 := by
  rw [witnessLight, dotVec_pair _ (frameTime_ne_frameSpace hD), minkowski_frameTime,
    minkowski_frameSpace]
  ring

@[simp]
lemma dotVec_witnessLight_witnessMomentum [Algebra ℚ R] (hD : 3 ≤ D) :
    dotVec (Fock.minkowski D R) (witnessLight D R hD) (witnessMomentum D R hD) = 1 := by
  rw [witnessLight, witnessMomentum, dotVec_pair _ (frameTime_ne_frameSpace hD),
    minkowski_frameTime, minkowski_frameSpace]
  linear_combination two_mul_invTwo R

@[simp]
lemma dotVec_witnessConjugate_self [Algebra ℚ R] (hD : 3 ≤ D) :
    dotVec (Fock.minkowski D R) (witnessConjugate D R hD) (witnessConjugate D R hD) = 0 := by
  rw [witnessConjugate, dotVec_pair _ (frameTime_ne_frameSpace hD), minkowski_frameTime,
    minkowski_frameSpace]
  ring

@[simp]
lemma dotVec_witnessLight_witnessConjugate [Algebra ℚ R] (hD : 3 ≤ D) :
    dotVec (Fock.minkowski D R) (witnessLight D R hD) (witnessConjugate D R hD) = -1 := by
  rw [witnessLight, witnessConjugate, dotVec_pair _ (frameTime_ne_frameSpace hD),
    minkowski_frameTime, minkowski_frameSpace]
  linear_combination -two_mul_invTwo R

/-- The tachyonic mass shell `α' k² = 1` (equivalently `a₀ = 1` for the ground state of the
tower, `worldsheet.no-ghost-theorem-v4` (1b)). -/
theorem invTwo_mul_zeroModeSq_witnessMomentum [Algebra ℚ R] (hD : 3 ≤ D) :
    invTwo R * Fock.zeroModeSq (Fock.minkowski D R) (witnessMomentum D R hD) = 1 := by
  rw [zeroModeSq_eq_dotVec, witnessMomentum, dotVec_pair _ (frameTime_ne_frameSpace hD),
    minkowski_frameTime, minkowski_frameSpace]
  linear_combination (4 * invTwo R ^ 2 + 2 * invTwo R + 1) * two_mul_invTwo R

/-- Transversality `ε_i · k_0 = 0` for every transverse index `i ≥ 2`. -/
theorem dotVec_witnessPolarization_witnessLight {i : Fin D} (hD : 3 ≤ D) (hi : 2 ≤ (i : ℕ)) :
    dotVec (Fock.minkowski D R) (witnessPolarization D R i) (witnessLight D R hD) = 0 := by
  refine dotVec_single_pair_of_ne _ ?_ ?_ _ _ _
  · simp only [ne_eq, Fin.ext_iff, frameTime]; omega
  · simp only [ne_eq, Fin.ext_iff, frameSpace]; omega

/-- The transverse Gram matrix is the identity: `ε_i·ε_j = δ_{ij}` for transverse `i`. -/
theorem dotVec_witnessPolarization_witnessPolarization {i j : Fin D} (hi : 2 ≤ (i : ℕ)) :
    dotVec (Fock.minkowski D R) (witnessPolarization D R i) (witnessPolarization D R j)
      = if i = j then 1 else 0 := by
  classical
  rw [witnessPolarization, witnessPolarization, dotVec_single_single]
  rcases eq_or_ne i j with rfl | h
  · rw [if_pos rfl, if_pos rfl, Fock.minkowski_spacelike D R (μ := i) (by omega)]
    ring
  · rw [if_neg h, if_neg h]

end Frame

/-! ### The satisfiability statements -/

section Satisfiable

variable (D : ℕ) (R : Type*) [CommRing R] [Algebra ℚ R]

/-- **The four DDF hypotheses are simultaneously satisfiable** for every `D ≥ 3` and every
commutative `ℚ`-algebra: there are `η, a, b, ε` with `η_μ² = 1`, `b·b = 0` (light-like),
`b·a = 1` (DDF normalisation), `ε·b = 0` (transversality), `ε·ε = 1` (unit polarisation) and
`α' k² = 1` (the tachyonic mass shell at intercept `a₀ = 1`).

Blueprint §C.2.  Without this statement every theorem of the DDF island is a conditional whose
hypothesis set is not known to be non-empty. -/
theorem noghost_hypotheses_satisfiable (hD : 3 ≤ D) :
    ∃ η a b ε : Fin D → R,
      (∀ μ, η μ * η μ = 1) ∧ dotVec η b b = 0 ∧ dotVec η b a = 1 ∧ dotVec η ε b = 0 ∧
        dotVec η ε ε = 1 ∧ invTwo R * Fock.zeroModeSq η a = 1 :=
  ⟨Fock.minkowski D R, witnessMomentum D R hD, witnessLight D R hD,
    witnessPolarization D R (frameTrans D hD),
    minkowski_sq D R, dotVec_witnessLight_self hD, dotVec_witnessLight_witnessMomentum hD,
    dotVec_witnessPolarization_witnessLight hD (by simp [frameTrans]),
    by rw [dotVec_witnessPolarization_witnessPolarization (by simp [frameTrans] : 2 ≤ ((frameTrans D hD : Fin D) : ℕ)),
      if_pos rfl],
    invTwo_mul_zeroModeSq_witnessMomentum hD⟩

/-- **The full light-cone frame is satisfiable**: on top of the four DDF hypotheses there is a
second light-like direction `b̃` with `b·b̃ = -1` and `b̃·b̃ = 0` (the pair used by Brower's
longitudinal operator, blueprint §A.3, and by the unitriangular change of basis of §B.4). -/
theorem noghost_lightcone_frame_satisfiable (hD : 3 ≤ D) :
    ∃ η a b b' ε : Fin D → R,
      (∀ μ, η μ * η μ = 1) ∧ dotVec η b b = 0 ∧ dotVec η b a = 1 ∧ dotVec η ε b = 0 ∧
        dotVec η b b' = -1 ∧ dotVec η b' b' = 0 ∧ invTwo R * Fock.zeroModeSq η a = 1 :=
  ⟨Fock.minkowski D R, witnessMomentum D R hD, witnessLight D R hD, witnessConjugate D R hD,
    witnessPolarization D R (frameTrans D hD),
    minkowski_sq D R, dotVec_witnessLight_self hD, dotVec_witnessLight_witnessMomentum hD,
    dotVec_witnessPolarization_witnessLight hD (by simp [frameTrans]),
    dotVec_witnessLight_witnessConjugate hD, dotVec_witnessConjugate_self hD,
    invTwo_mul_zeroModeSq_witnessMomentum hD⟩

omit [Algebra ℚ R] in
/-- **The transverse polarisations exist in bulk with identity Gram**: all `D - 2` directions
`ε_i` (`i ≥ 2`) are transverse to the light-like `b`, and their Gram matrix is `δ_{ij}`.  Over
an ordered field this is the positive definiteness of the transverse Gram, which is what the
no-ghost theorem needs; here it is stated without any order hypothesis. -/
theorem noghost_transverse_gram_satisfiable (hD : 3 ≤ D) :
    ∃ (η b : Fin D → R) (ε : Fin D → Fin D → R),
      (∀ μ, η μ * η μ = 1) ∧ dotVec η b b = 0 ∧
        (∀ i : Fin D, 2 ≤ (i : ℕ) → dotVec η (ε i) b = 0) ∧
        (∀ i j : Fin D, 2 ≤ (i : ℕ) → dotVec η (ε i) (ε j) = if i = j then 1 else 0) :=
  ⟨Fock.minkowski D R, witnessLight D R hD, fun i => witnessPolarization D R i,
    minkowski_sq D R, dotVec_witnessLight_self hD,
    fun _ hi => dotVec_witnessPolarization_witnessLight hD hi,
    fun _ _ hi => dotVec_witnessPolarization_witnessPolarization hi⟩

end Satisfiable

end StringFormal.NoGhost
