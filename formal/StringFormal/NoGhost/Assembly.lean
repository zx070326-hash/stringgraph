/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.DDFGram
import StringFormal.NoGhost.TowerNull

/-!
# The no-ghost theorem, conditional on the DDF spanning lemma

Graph node: `worldsheet.no-ghost-theorem-v4` (conditional form).  This is §C.5 of
`formal/BLUEPRINT-noghost.md`: the final assembly of the Goddard–Thorn no-ghost theorem out of

* §C.1 — the tower quotient `H_phys ⧸ H_null` and its induced form
  (`StringFormal/NoGhost/TowerNull.lean`);
* §C.4 — positivity of the DDF sector, `ddf_span_pos`
  (`StringFormal/NoGhost/DDFGram.lean`);
* §B — the **spanning lemma** `H_phys ≤ ddfSpan + H_null`, which is *not* proved here and is
  carried as the explicit hypothesis `DDFSpans`.

## What this file does and does not claim

Everything below is of the form "if `DDFSpans` holds, then …".  **The whole content of
`D = 26` sits inside `DDFSpans`**: the critical dimension never appears in the statements or
proofs of this file.  That is the correct bookkeeping and not an accident — blueprint §B.5
explains that the DDF states have the transverse character `φ(q)^{-(D-2)}` while the physical
states modulo null states have the covariant one, and the two agree only at `D = 26`,
`a₀ = 1`.  Everything *else* in Goddard–Thorn (the Gram matrix, positivity, orthogonality of
null states, well-definedness of the quotient form) is dimension-independent, and this file
makes that precise by proving it for every `D` under the single hypothesis `DDFSpans`.

Conversely, `DDFSpans` is **not** vacuous bookkeeping either: `ddfSpans_bigrade_neg_one_one`
below discharges it on the level-one slice of the tower (the photon), unconditionally in `D`,
from the §B.6 result of `StringFormal/NoGhost/LightCone.lean`.

## Main definitions

* `DDFSpans η a b hη Ε` — the spanning lemma as a `Prop`:
  `H_phys ≤ ddfSpan ⊔ H_null` at the ground-state intercept `a₀ = α' k²`.
* `DDFSpansOn η a b hη Ε W` — its restriction to a subspace `W` of the tower, used to state
  the graded increments of §B.6.

## Main results

* `towerPairing_self_nonneg_of_mem_towerPhys_of_spans` — **no-ghost (1a)**: every physical
  state of the tower has non-negative norm.
* `towerPairing_self_eq_zero_iff_mem_towerNullSubmodule_of_spans` — **no-ghost (1b)**: a
  physical state has zero norm iff it is null, i.e. the form is *definite* on physical states
  modulo its own radical.
* `no_ghost_of_spans` — **the no-ghost theorem**: the induced form on
  `H_phys ⧸ H_null` is positive definite.
* `ddfSpans_bigrade_neg_one_one` — `DDFSpansOn` at rung `-1`, oscillator level `1`, from the
  §B.6 increment `towerPhys_bigrade_one_le_ddfSpan_sup_spurious`; the passage from "modulo
  spurious" to "modulo null" is `mem_ddfSpan_sup_null_of_mem_ddfSpan_sup_spurious`.

## Conventions

Mostly-plus metric with `η μ * η μ = 1`, `b·b = 0`, `b·a = 1` as everywhere in the `NoGhost`
directory; the intercept is the ground-state one `a₀ = invTwo R * Fock.zeroModeSq η a`
(`= α' k²`), which is forced on us by `ddfMonomial_mem_towerPhysSubmodule` and is *not* a free
parameter.  The ordered-field hypotheses (`LinearOrder`, `IsStrictOrderedRing`) are what makes
"positive definite" meaningful; `Algebra ℚ K` is needed by the DDF operators themselves.

## Gaps

* `DDFSpans` itself is unproved in general (blueprint §B; this is the `ddf-spans` gap of
  `worldsheet.no-ghost-theorem-v4--via-goddard-thorn`).  Only the `(-1, 1)` bigrade is
  discharged, and even that needs the two extra hypotheses `hεa` and `FrameSpansOrthogonal`
  recorded in `LightCone.lean`.
* No isometry `ddfSpan ≃ₗ H_phys ⧸ H_null` is constructed (blueprint's `noGhostEquiv`).
  Injectivity of `ddfSpan → H_phys ⧸ H_null` does follow from `ddf_span_pos`, but surjectivity
  is exactly `DDFSpans` again, so the equivalence would carry no information beyond the
  theorems below.
* Nothing here says the hypothesis set is *non-empty* as a whole: `Witness.lean` and
  `WitnessInt.lean` satisfy the four geometric hypotheses, and `witnessTransverseFrame` gives a
  frame, but no witness is known to this project for `DDFSpans` itself.
-/

namespace StringFormal.NoGhost

/-! ### The spanning lemma as a hypothesis -/

section Spanning

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

/-- **The DDF spanning lemma, as a `Prop`.**  "Every physical state of the momentum tower is a
DDF state plus a null state", at the ground-state intercept `a₀ = α' k²`.

This is blueprint §B and is *not* proved anywhere in this development: it is the single place
where `D = 26` enters Goddard–Thorn (blueprint §B.5).  Making it an explicit hypothesis is the
honest packaging recommended by the blueprint — compare
`Fock.pairing_creationMonomial_of_hypotheses`. -/
def DDFSpans (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (Ε : TransverseFrame η b) : Prop :=
  towerPhysSubmodule η a b (invTwo R * Fock.zeroModeSq η a)
    ≤ ddfSpan η a b hη Ε ⊔ towerNullSubmodule η a b (invTwo R * Fock.zeroModeSq η a)

/-- The spanning lemma restricted to a subspace `W` of the tower.  The graded increments of
blueprint §B.6 prove exactly this, with `W` a bigraded piece. -/
def DDFSpansOn (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (Ε : TransverseFrame η b)
    (W : Submodule R (TowerFock D R)) : Prop :=
  towerPhysSubmodule η a b (invTwo R * Fock.zeroModeSq η a) ⊓ W
    ≤ ddfSpan η a b hη Ε ⊔ towerNullSubmodule η a b (invTwo R * Fock.zeroModeSq η a)

variable {η a b : Fin D → R} {hη : ∀ μ, η μ * η μ = 1} {Ε : TransverseFrame η b}

theorem DDFSpansOn_top_iff : DDFSpansOn η a b hη Ε ⊤ ↔ DDFSpans η a b hη Ε := by
  rw [DDFSpansOn, DDFSpans, inf_top_eq]

theorem DDFSpans.ddfSpansOn (h : DDFSpans η a b hη Ε) (W : Submodule R (TowerFock D R)) :
    DDFSpansOn η a b hη Ε W :=
  le_trans inf_le_left h

end Spanning

/-! ### From "modulo spurious" to "modulo null"

The §B.6 increments come out as `H_phys ∩ W ≤ ddfSpan + (spurious states)`.  Upgrading the
spurious summand to a *null* summand is free: the DDF part is itself physical, so the spurious
part of a physical vector is physical, and `spurious ∩ physical ≤ null`. -/

section SpuriousToNull

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]
variable {η a b : Fin D → R} (hη : ∀ μ, η μ * η μ = 1)
variable (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1) (Ε : TransverseFrame η b)

include hbb hba in
/-- If a **physical** vector lies in `ddfSpan + S` for some submodule `S` of spurious states,
then it lies in `ddfSpan + H_null`.  Only `ddfSpan ≤ H_phys` and
`spurious ∩ physical ≤ null` are used. -/
theorem mem_ddfSpan_sup_null_of_mem_ddfSpan_sup_spurious
    {S : Submodule R (TowerFock D R)} (hS : S ≤ towerSpuriousSubmodule η a b)
    {x : TowerFock D R}
    (hphys : x ∈ towerPhysSubmodule η a b (invTwo R * Fock.zeroModeSq η a))
    (hx : x ∈ ddfSpan η a b hη Ε ⊔ S) :
    x ∈ ddfSpan η a b hη Ε ⊔ towerNullSubmodule η a b (invTwo R * Fock.zeroModeSq η a) := by
  obtain ⟨d, hd, s, hs, rfl⟩ := Submodule.mem_sup.1 hx
  have hdphys : d ∈ towerPhysSubmodule η a b (invTwo R * Fock.zeroModeSq η a) :=
    ddfSpan_le_towerPhysSubmodule η a b hη hbb hba Ε hd
  have hsphys : s ∈ towerPhysSubmodule η a b (invTwo R * Fock.zeroModeSq η a) := by
    have : s = d + s - d := by abel
    rw [this]
    exact sub_mem hphys hdphys
  exact Submodule.mem_sup.2 ⟨d, hd, s, towerSpurious_inf_towerPhys_le_towerNull η a b _
    (Submodule.mem_inf.2 ⟨hS hs, hsphys⟩), rfl⟩

end SpuriousToNull

/-! ### The no-ghost theorem, conditional on `DDFSpans` -/

section NoGhost

variable {D : ℕ} {K : Type*} [Field K] [LinearOrder K] [IsStrictOrderedRing K] [Algebra ℚ K]
variable {η a b : Fin D → K} (hη : ∀ μ, η μ * η μ = 1)
variable (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1) (Ε : TransverseFrame η b)

omit [LinearOrder K] [IsStrictOrderedRing K] in
include hbb hba in
/-- The decomposition `Ψ = d + χ` of a physical state into a DDF state and a null state
computes its norm: `⟨Ψ, Ψ⟩ = ⟨d, d⟩`.  The two cross terms and the `⟨χ, χ⟩` term vanish
because null states are orthogonal to *all* physical states, and `d` is physical. -/
theorem towerPairing_self_eq_of_spans (hspan : DDFSpans η a b hη Ε) {v : TowerFock D K}
    (hv : v ∈ towerPhysSubmodule η a b (invTwo K * Fock.zeroModeSq η a)) :
    ∃ d ∈ ddfSpan η a b hη Ε,
      Fock.towerPairing η v v = Fock.towerPairing η d d := by
  obtain ⟨d, hd, χ, hχ, rfl⟩ := Submodule.mem_sup.1 (hspan hv)
  refine ⟨d, hd, ?_⟩
  exact towerPairing_add_null (ddfSpan_le_towerPhysSubmodule η a b hη hbb hba Ε hd)
    (ddfSpan_le_towerPhysSubmodule η a b hη hbb hba Ε hd) hχ hχ

include hbb hba in
/-- **The no-ghost theorem, part (1a): no negative-norm physical states.**

Conditional on the spanning lemma `DDFSpans`, every physical state of the momentum tower has
non-negative norm, in every dimension `D`.  Blueprint §C.5. -/
theorem towerPairing_self_nonneg_of_mem_towerPhys_of_spans (hspan : DDFSpans η a b hη Ε)
    {v : TowerFock D K}
    (hv : v ∈ towerPhysSubmodule η a b (invTwo K * Fock.zeroModeSq η a)) :
    0 ≤ Fock.towerPairing η v v := by
  obtain ⟨d, hd, hvd⟩ := towerPairing_self_eq_of_spans hη hbb hba Ε hspan hv
  rw [hvd]
  rcases eq_or_ne d 0 with rfl | hdne
  · simp
  · exact (ddf_span_pos hη hbb hba Ε hd hdne).le

include hbb hba in
/-- **The no-ghost theorem, part (1b): zero norm exactly on the null states.**

Conditional on `DDFSpans`, a physical state has vanishing norm iff it is orthogonal to *every*
physical state.  The nontrivial direction is `→`: writing `Ψ = d + χ` one gets
`⟨d, d⟩ = 0`, and `ddf_span_pos` forces `d = 0`, so `Ψ = χ` is null. -/
theorem towerPairing_self_eq_zero_iff_mem_towerNullSubmodule_of_spans
    (hspan : DDFSpans η a b hη Ε) {v : TowerFock D K}
    (hv : v ∈ towerPhysSubmodule η a b (invTwo K * Fock.zeroModeSq η a)) :
    Fock.towerPairing η v v = 0 ↔
      v ∈ towerNullSubmodule η a b (invTwo K * Fock.zeroModeSq η a) := by
  refine ⟨fun h => ?_, towerPairing_self_eq_zero_of_mem_towerNullSubmodule⟩
  obtain ⟨d, hd, χ, hχ, rfl⟩ := Submodule.mem_sup.1 (hspan hv)
  have hdd : Fock.towerPairing η d d = 0 := by
    rw [← h]
    exact (towerPairing_add_null (ddfSpan_le_towerPhysSubmodule η a b hη hbb hba Ε hd)
      (ddfSpan_le_towerPhysSubmodule η a b hη hbb hba Ε hd) hχ hχ).symm
  have hd0 : d = 0 := by
    by_contra hne
    exact absurd hdd (ne_of_gt (ddf_span_pos hη hbb hba Ε hd hne))
  rw [hd0, zero_add]
  exact hχ

include hbb hba in
/-- **The no-ghost theorem (Goddard–Thorn), conditional on the DDF spanning lemma.**

The bilinear form induced on `H_phys ⧸ H_null` of the momentum tower is **positive definite**:
every class has non-negative norm, and only the zero class has norm zero.

`D = 26` does not appear: it is entirely absorbed into the hypothesis `DDFSpans`
(blueprint §B.5).  Graph node `worldsheet.no-ghost-theorem-v4`, conditional form. -/
theorem no_ghost_of_spans (hspan : DDFSpans η a b hη Ε) :
    ∀ x : TowerPhysQuot η a b (invTwo K * Fock.zeroModeSq η a),
      0 ≤ towerQuotientPairing η a b (invTwo K * Fock.zeroModeSq η a) x x ∧
        (towerQuotientPairing η a b (invTwo K * Fock.zeroModeSq η a) x x = 0 → x = 0) := by
  intro x
  obtain ⟨Ψ, rfl⟩ := towerPhysMk_surjective η a b (invTwo K * Fock.zeroModeSq η a) x
  rw [towerQuotientPairing_mk]
  refine ⟨towerPairing_self_nonneg_of_mem_towerPhys_of_spans hη hbb hba Ε hspan Ψ.2,
    fun h => ?_⟩
  have hnull : (Ψ : TowerFock D K)
      ∈ towerNullSubmodule η a b (invTwo K * Fock.zeroModeSq η a) :=
    (towerPairing_self_eq_zero_iff_mem_towerNullSubmodule_of_spans hη hbb hba Ε hspan Ψ.2).1 h
  exact (Submodule.Quotient.mk_eq_zero _).2
    ((mem_towerNullInPhys η a b (invTwo K * Fock.zeroModeSq η a)).2 hnull)

end NoGhost

/-! ### Discharging `DDFSpansOn` on the level-one slice

The §B.6 increment of `LightCone.lean` gives the spanning lemma on the bigraded piece
`(rung -1, oscillator level 1)` — the slice carrying the photon — for **every** `D`. -/

section LevelOne

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]
variable {η a b : Fin D → R} (hη : ∀ μ, η μ * η μ = 1)
variable (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1) (Ε : TransverseFrame η b)

include hbb hba in
/-- **`DDFSpansOn` at rung `-1`, oscillator level `1`.**

This is `towerPhys_bigrade_one_le_ddfSpan_sup_spurious` of `LightCone.lean` with the spurious
summand `span {L_{-1}|0; k - k_0⟩}` traded for the null states, via
`mem_ddfSpan_sup_null_of_mem_ddfSpan_sup_spurious`.

The two extra hypotheses are inherited verbatim from §B.6 and are both genuine:
`hεa` (the transverse polarisations annihilate the momentum) and `hframe`
(`FrameSpansOrthogonal`, completeness of the frame on `p^⊥`, which `TransverseFrame` does not
record).  `D = 26` does **not** appear — at level one the counting works in every dimension. -/
theorem ddfSpans_bigrade_neg_one_one (hεa : ∀ i, dotVec η (Ε.vec i) a = 0)
    (hframe : FrameSpansOrthogonal η Ε (towerMomentum a b (-1))) :
    DDFSpansOn η a b hη Ε (towerBigrade D R (-1) 1) := by
  intro x hx
  obtain ⟨hphys, -⟩ := Submodule.mem_inf.1 hx
  refine mem_ddfSpan_sup_null_of_mem_ddfSpan_sup_spurious hη hbb hba Ε ?_ hphys
    (towerPhys_bigrade_one_le_ddfSpan_sup_spurious η a b hη Ε hεa hframe hx)
  rw [Submodule.span_le, Set.singleton_subset_iff]
  exact towerLop_neg_mem_towerSpuriousSubmodule (by norm_num)
    (Finsupp.single (-1) (Fock.vacuum D R))

end LevelOne

end StringFormal.NoGhost
