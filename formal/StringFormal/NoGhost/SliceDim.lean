/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.SliceRank

/-!
# The dimension of the DDF sector on one slice

Graph nodes: `worldsheet.transverse-ddf-fock-gram-matrix` (item (3)),
`worldsheet.ddf-spanning-hypothesis`.  This is **PR2 of blueprint §B′** in
`formal/BLUEPRINT-noghost.md`: the term `finrank (ddfSpan ⊓ V_N)` of `B26` is computed.

## What this file does

`DDFGram.lean` placed the DDF state `|d⟩` on rung `-N(d)` and explicitly recorded "rung and
level are not yet tied together" as a gap.  `frameMonomial_mem_towerBigrade` closes it: the
argument is *not* a computation of the oscillator level of `ddfOp`, but the observation that
`|d⟩` is physical, that physicality is inherited by each bigraded component
(`Glue.towerBigradeProj_mem_towerPhysSubmodule`), and that the mass shell
(`massShell_of_mem_towerBigrade`) then permits only one component to be nonzero.

With the level pinned down, `ddfSpan ⊓ V_N` is the span of the finitely many DDF monomials of
level `N`, these are linearly independent (`linearIndependent_ddfMonomial`), and the dimension
is the number of `(D−2)`-coloured partitions of `N` — recorded here as the cardinality of the
indexing subtype, never evaluated (blueprint §B′.8: *no partition number is ever computed*).

## Main results

* `frameMonomial_mem_towerBigrade` — **`|d⟩` lies in the bigraded slice
  `(rung -N(d), level N(d))`.**
* `ddfSpan_inf_towerBigrade_eq_span` — `ddfSpan ⊓ V_N` is spanned by the DDF monomials of
  level `N`.
* `ddfLevelFintype` — the level-`N` DDF occupation functions form a finite type.
* `finrank_ddfSpan_inf_towerBigrade` — `dim (ddfSpan ⊓ V_N) = #{d | N(d) = N}` (`= p_{D−2}(N)`).
* `towerPairing_towerBigradeProj_left` / `_right` — **distinct slices are orthogonal**, in the
  form "the form only couples a projected vector to the matching projection".
* `towerBigradeProj_mem_ddfSpan`, `towerBigradeProj_mem_towerNullSubmodule` — `ddfSpan` and
  `H_null` are homogeneous for the bigrading.
* `b26_of_ddfSpansOn_bigrade`, **`ddfSpansOn_bigrade_iff_b26`** — the converse of
  `SliceRank.ddfSpansOn_bigrade_of_b26` and the resulting equivalence: `B26 N` loses no
  information relative to the slice spanning lemma, so it is a faithful rewriting of the
  `(B-26)` gap and not a strengthening of it.

## Deviation from blueprint §B′

§B′.7 draws the dependency PR1 → PR2 as PR2 → PR1.  It is the other way round here: PR1
(`SliceRank.lean`) needs nothing from this file, whereas the converse of
`SliceRank.ddfSpansOn_bigrade_of_b26` does need `frameMonomial_mem_towerBigrade`, because it
has to project a decomposition `x = d + z` back onto the slice.  See the note in
`SliceRank.lean`.

## Conventions

Mostly-plus metric with `η μ * η μ = 1`, `b·b = 0`, `b·a = 1`; intercept
`a₀ = invTwo R * Fock.zeroModeSq η a` (`= α' k²`), as in `Assembly.lean`.  `NoZeroDivisors` and
`CharZero` are exactly what `massShell_of_mem_towerBigrade` needs to turn the scalar equation
`α'k² + j + N = a₀` into the integer equation `j + N = 0`.  `D = 26` does not occur.

## Status

Complete, no `sorry`; axioms are `propext`, `Classical.choice`, `Quot.sound` only.
-/

namespace StringFormal.NoGhost

open Module

/-! ### Elementary bounds on the DDF level -/

section LevelBounds

variable {ι : Type*}

/-- Each occupied mode contributes at most the whole level. -/
theorem mul_apply_le_ddfLevel (d : (ι × ℕ+) →₀ ℕ) (v : ι × ℕ+) :
    (v.2 : ℕ) * d v ≤ ddfLevel d := by
  classical
  rcases eq_or_ne (d v) 0 with h | h
  · simp [h]
  · rw [ddfLevel, Finsupp.sum]
    exact Finset.single_le_sum (f := fun u : ι × ℕ+ => (u.2 : ℕ) * d u)
      (fun u _ => Nat.zero_le _) (Finsupp.mem_support_iff.2 h)

/-- Occupation numbers are bounded by the level. -/
theorem apply_le_ddfLevel (d : (ι × ℕ+) →₀ ℕ) (v : ι × ℕ+) : d v ≤ ddfLevel d := by
  have h := mul_apply_le_ddfLevel d v
  have h1 : 1 ≤ (v.2 : ℕ) := v.2.2
  nlinarith

/-- Modes above the level are unoccupied. -/
theorem apply_eq_zero_of_ddfLevel_lt {d : (ι × ℕ+) →₀ ℕ} {v : ι × ℕ+}
    (h : ddfLevel d < (v.2 : ℕ)) : d v = 0 := by
  by_contra hne
  have hle := mul_apply_le_ddfLevel d v
  have h1 : 1 ≤ d v := Nat.one_le_iff_ne_zero.2 hne
  nlinarith

/-- The encoding used to prove finiteness: an occupation function of level `≤ N` is determined
by its values on the finitely many pairs `(i, m+1)` with `m < N`, and those values are `≤ N`.
The `min` is only there to avoid a dependent proof inside the function; on the subtype it is
the identity. -/
def ddfLevelEncode (N : ℕ) (d : (ι × ℕ+) →₀ ℕ) : ι × Fin N → Fin (N + 1) :=
  fun v => ⟨min (d (v.1, (v.2.val).succPNat)) N, Nat.lt_succ_of_le (Nat.min_le_right _ _)⟩

/-- **The DDF occupation functions of a fixed level form a finite type.**  Blueprint §B′.4,
PR2; this is the index set whose cardinality is `p_{D−2}(N)`, a number this development never
evaluates. -/
noncomputable instance ddfLevelFintype (ι : Type*) [Fintype ι] [DecidableEq ι] (N : ℕ) :
    Fintype {d : (ι × ℕ+) →₀ ℕ // ddfLevel d = N} := by
  refine Fintype.ofInjective (fun d => ddfLevelEncode N (d : (ι × ℕ+) →₀ ℕ)) ?_
  rintro ⟨d, hd⟩ ⟨e, he⟩ h
  refine Subtype.ext (Finsupp.ext fun v => ?_)
  show d v = e v
  by_cases hv : (v.2 : ℕ) ≤ N
  · have hpos : 0 < (v.2 : ℕ) := v.2.2
    have hm : (v.2 : ℕ) - 1 < N := by omega
    have hval := congrFun h (v.1, (⟨(v.2 : ℕ) - 1, hm⟩ : Fin N))
    have hpnat : ((((v.2 : ℕ) - 1 : ℕ)).succPNat) = v.2 := by
      refine PNat.coe_injective ?_
      rw [Nat.succPNat_coe]
      omega
    have hval' : min (d (v.1, (((v.2 : ℕ) - 1 : ℕ)).succPNat)) N
        = min (e (v.1, (((v.2 : ℕ) - 1 : ℕ)).succPNat)) N := congrArg Fin.val hval
    rw [hpnat] at hval'
    have hdb : d v ≤ N := hd ▸ apply_le_ddfLevel d v
    have heb : e v ≤ N := he ▸ apply_le_ddfLevel e v
    have hval'' : min (d v) N = min (e v) N := hval'
    rwa [min_eq_left hdb, min_eq_left heb] at hval''
  · rw [apply_eq_zero_of_ddfLevel_lt (by omega : ddfLevel d < (v.2 : ℕ)),
      apply_eq_zero_of_ddfLevel_lt (by omega : ddfLevel e < (v.2 : ℕ))]

end LevelBounds

/-! ### DDF states are bigraded -/

section Bigrade

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] [NoZeroDivisors R] [CharZero R]
variable {η a b : Fin D → R}
variable (hη : ∀ μ, η μ * η μ = 1) (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1)
variable (Ε : TransverseFrame η b)

include hη hbb hba in
/-- **A DDF state of level `N(d)` lies in the bigraded slice `(rung -N(d), level N(d))`.**

This closes the gap "rung and level are not yet tied together" recorded in `DDFGram.lean`.
The proof does *not* compute the oscillator level of `ddfOp`.  Instead: `|d⟩` sits on rung
`-N(d)` (`frameMonomial_mem_towerRungSubmodule`) and is physical
(`ddfMonomial_mem_towerPhysSubmodule`); each of its bigraded components is again physical
(`Glue.towerBigradeProj_mem_towerPhysSubmodule`); and a nonzero physical vector in the slice
`(j, M)` must satisfy `α'k² + j + M = a₀ = α'k²` (`massShell_of_mem_towerBigrade`), which at
`j = -N(d)` forces `M = N(d)`.  Summing the components back up
(`Glue.sum_towerBigradeProj`) gives the claim. -/
theorem frameMonomial_mem_towerBigrade (d : (Fin (D - 2) × ℕ+) →₀ ℕ) :
    frameMonomial hη hbb hba Ε d ∈ towerBigrade D R (-(ddfLevel d : ℤ)) (ddfLevel d) := by
  classical
  set n := ddfLevel d with hn
  set x := frameMonomial hη hbb hba Ε d with hxdef
  have hrung : x ∈ towerRungSubmodule D R (-(n : ℤ)) :=
    frameMonomial_mem_towerRungSubmodule hη hbb hba Ε d
  have hphys : x ∈ towerPhysSubmodule η a b (invTwo R * Fock.zeroModeSq η a) :=
    ddfMonomial_mem_towerPhysSubmodule hη hbb hba Ε.transverse Ε.orthonormal d
  rw [← sum_towerBigradeProj x]
  refine Submodule.sum_mem _ fun j _ => Submodule.sum_mem _ fun M _ => ?_
  rcases eq_or_ne j (-(n : ℤ)) with rfl | hj
  · rcases eq_or_ne M n with rfl | hM
    · exact towerBigradeProj_mem _ _ _
    · have hzero : towerBigradeProj D R (-(n : ℤ)) M x = 0 := by
        by_contra hne
        have hms := massShell_of_mem_towerBigrade η a b hη hbb hba
          (towerBigradeProj_mem (-(n : ℤ)) M x)
          (Submodule.mem_inf.1
            (towerBigradeProj_mem_towerPhysSubmodule η a b hphys (-(n : ℤ)) M)).1 hne
        have hcd : (((-(n : ℤ)) : ℤ) : R) + (M : R) = 0 :=
          add_left_cancel (a := invTwo R * Fock.zeroModeSq η a)
            (by rw [← add_assoc, hms, add_zero])
        push_cast at hcd
        exact hM (Nat.cast_injective (R := R) (neg_add_eq_zero.mp hcd)).symm
      rw [hzero]
      exact Submodule.zero_mem _
  · have hzero : towerBigradeProj D R j M x = 0 := by
      rw [towerBigradeProj_apply, mem_towerRungSubmodule.1 hrung j hj, map_zero,
        Finsupp.single_zero]
    rw [hzero]
    exact Submodule.zero_mem _

include hη hbb hba in
/-- **`ddfSpan ⊓ V_N` is spanned by the DDF monomials of level `N`.**  Blueprint §B′.4, PR2.

"⊇" is `frameMonomial_mem_towerBigrade`.  "⊆" applies the bigraded projection to a finite
expansion in the generators: the projection fixes the level-`N` generators and kills all the
others. -/
theorem ddfSpan_inf_towerBigrade_eq_span (N : ℕ) :
    ddfSpan η a b hη Ε ⊓ towerBigrade D R (-(N : ℤ)) N
      = Submodule.span R (Set.range fun d : {d : (Fin (D - 2) × ℕ+) →₀ ℕ // ddfLevel d = N} =>
          frameMonomial hη hbb hba Ε (d : (Fin (D - 2) × ℕ+) →₀ ℕ)) := by
  classical
  refine le_antisymm (fun x hx => ?_) (Submodule.span_le.2 ?_)
  · obtain ⟨hspan, hbig⟩ := Submodule.mem_inf.1 hx
    rw [ddfSpan_eq_span_range_frameMonomial hη hbb hba Ε] at hspan
    obtain ⟨c, hc⟩ := Finsupp.mem_span_range_iff_exists_finsupp.mp hspan
    have hproj : towerBigradeProj D R (-(N : ℤ)) N x = x := towerBigradeProj_of_mem_self hbig
    have hrewrite : x = towerBigradeProj D R (-(N : ℤ)) N
        (c.sum fun d r => r • frameMonomial hη hbb hba Ε d) := by rw [hc, hproj]
    rw [hrewrite, Finsupp.sum, map_sum]
    refine Submodule.sum_mem _ fun d _ => ?_
    rw [map_smul]
    by_cases hdl : ddfLevel d = N
    · have hmem : frameMonomial hη hbb hba Ε d ∈ towerBigrade D R (-(N : ℤ)) N := by
        rw [← hdl]
        exact frameMonomial_mem_towerBigrade hη hbb hba Ε d
      rw [towerBigradeProj_of_mem_self hmem]
      exact Submodule.smul_mem _ _ (Submodule.subset_span ⟨⟨d, hdl⟩, rfl⟩)
    · rw [towerBigradeProj_of_mem_ne (frameMonomial_mem_towerBigrade hη hbb hba Ε d)
        (Or.inr (Ne.symm hdl)), smul_zero]
      exact Submodule.zero_mem _
  · rintro _ ⟨⟨d, hd⟩, rfl⟩
    refine Submodule.mem_inf.2 ⟨frameMonomial_mem_ddfSpan hη hbb hba Ε d, ?_⟩
    have hb := frameMonomial_mem_towerBigrade hη hbb hba Ε d
    rw [hd] at hb
    exact hb

end Bigrade

/-! ### The dimension of the DDF sector on a slice -/

section Dim

variable {D : ℕ} {K : Type*} [Field K] [CharZero K] [Algebra ℚ K]
variable {η a b : Fin D → K}
variable (hη : ∀ μ, η μ * η μ = 1) (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1)
variable (Ε : TransverseFrame η b)

/-- The frame-indexed DDF states are linearly independent: `linearIndependent_ddfMonomial`
with the transversality and orthonormality data read off the frame. -/
theorem linearIndependent_frameMonomial :
    LinearIndependent K (frameMonomial hη hbb hba Ε) :=
  linearIndependent_ddfMonomial hη hbb hba Ε.transverse Ε.orthonormal

include hη hbb hba in
/-- **`dim (ddfSpan ⊓ V_N) = #{d | N(d) = N}`**, blueprint §B′.2 (P2).

The right-hand side is `p_{D−2}(N)`, the number of `(D−2)`-coloured partitions of `N`; it is
deliberately left as a cardinality, because §B′.8 observes that no step of the argument needs
its value. -/
theorem finrank_ddfSpan_inf_towerBigrade (N : ℕ) :
    finrank K ↥(ddfSpan η a b hη Ε ⊓ towerBigrade D K (-(N : ℤ)) N)
      = Fintype.card {d : (Fin (D - 2) × ℕ+) →₀ ℕ // ddfLevel d = N} := by
  rw [ddfSpan_inf_towerBigrade_eq_span hη hbb hba Ε N]
  exact finrank_span_eq_card
    ((linearIndependent_frameMonomial hη hbb hba Ε).comp _ Subtype.val_injective)

end Dim

/-! ### Slices are mutually orthogonal, and `ddfSpan` / `H_null` are homogeneous

These are the ingredients of the converse of `SliceRank.ddfSpansOn_bigrade_of_b26`: a
decomposition `x = d + z` valid in the whole tower has to be pushed back onto the slice. -/

section Homogeneity

namespace Fock

open MvPolynomial

variable {D : ℕ} {R : Type*} [CommRing R]

/-- Against a vector of pure level `N`, only the level-`N` part of the other argument
contributes.  Immediate from the diagonal formula `Fock.pairing_apply`: the sum runs over the
support of `P`, on which the level is constantly `N`. -/
theorem pairing_levelComponent_right (η : Fin D → R) {N : ℕ} {P : Fock D R}
    (hP : P ∈ levelSubmodule D R N) (Q : Fock D R) :
    pairing η P (levelComponent D R N Q) = pairing η P Q := by
  classical
  rw [pairing_apply, pairing_apply]
  refine Finset.sum_congr rfl fun d hd => ?_
  have hlev : level D d = N := hP (mem_support_iff.mp hd)
  rw [coeff_levelComponent, if_pos hlev]

end Fock

variable {D : ℕ} {R : Type*} [CommRing R]

/-- **Distinct bigraded slices are orthogonal**, in the form needed below: pairing against a
projected vector only sees the corresponding projection of the other argument.  Rung
orthogonality is `Fock.towerPairing_single_single`, level orthogonality is
`Fock.pairing_levelComponent_right`. -/
theorem towerPairing_towerBigradeProj_left (η : Fin D → R) (j : ℤ) (N : ℕ)
    (x y : TowerFock D R) :
    Fock.towerPairing η (towerBigradeProj D R j N x) y
      = Fock.towerPairing η (towerBigradeProj D R j N x) (towerBigradeProj D R j N y) := by
  rw [towerBigradeProj_apply, towerBigradeProj_apply, Fock.towerPairing_single_left,
    Fock.towerPairing_single_left, Finsupp.single_eq_same]
  exact (Fock.pairing_levelComponent_right η (Fock.levelComponent_mem N (x j)) (y j)).symm

/-- The right-hand version of `towerPairing_towerBigradeProj_left`, by symmetry of the
form. -/
theorem towerPairing_towerBigradeProj_right (η : Fin D → R) (j : ℤ) (N : ℕ)
    (x y : TowerFock D R) :
    Fock.towerPairing η x (towerBigradeProj D R j N y)
      = Fock.towerPairing η (towerBigradeProj D R j N x) (towerBigradeProj D R j N y) := by
  rw [Fock.towerPairing_comm η x, towerPairing_towerBigradeProj_left,
    Fock.towerPairing_comm η (towerBigradeProj D R j N y)]

variable [Algebra ℚ R]

/-- **The null states are homogeneous for the bigrading.**  `towerNullSubmodule` is
`H_phys ⊓ H_phys^⊥`; physicality of the components is `Glue`, and orthogonality survives
because the form only couples a projected vector to the matching projection. -/
theorem towerBigradeProj_mem_towerNullSubmodule (η a b : Fin D → R) {a₀ : R} (j : ℤ) (N : ℕ)
    {z : TowerFock D R} (hz : z ∈ towerNullSubmodule η a b a₀) :
    towerBigradeProj D R j N z ∈ towerNullSubmodule η a b a₀ := by
  rw [mem_towerNullSubmodule] at hz ⊢
  refine ⟨towerBigradeProj_mem_towerPhysSubmodule η a b hz.1 j N, fun Ψ hΨ => ?_⟩
  rw [towerPairing_towerBigradeProj_left, ← towerPairing_towerBigradeProj_right]
  exact hz.2 _ (towerBigradeProj_mem_towerPhysSubmodule η a b hΨ j N)

end Homogeneity

section DdfHomogeneity

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] [NoZeroDivisors R] [CharZero R]
variable {η a b : Fin D → R}
variable (hη : ∀ μ, η μ * η μ = 1) (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1)
variable (Ε : TransverseFrame η b)

include hη hbb hba in
/-- **`ddfSpan` is homogeneous for the bigrading.**  Its generators are, by
`frameMonomial_mem_towerBigrade`, so the projection either fixes a generator or kills it. -/
theorem towerBigradeProj_mem_ddfSpan (j : ℤ) (M : ℕ) {x : TowerFock D R}
    (hx : x ∈ ddfSpan η a b hη Ε) :
    towerBigradeProj D R j M x ∈ ddfSpan η a b hη Ε := by
  classical
  rw [ddfSpan_eq_span_range_frameMonomial hη hbb hba Ε] at hx ⊢
  obtain ⟨c, hc⟩ := Finsupp.mem_span_range_iff_exists_finsupp.mp hx
  rw [← hc, Finsupp.sum, map_sum]
  refine Submodule.sum_mem _ fun d _ => ?_
  rw [map_smul]
  by_cases hjm : j = -(ddfLevel d : ℤ) ∧ M = ddfLevel d
  · obtain ⟨rfl, rfl⟩ := hjm
    rw [towerBigradeProj_of_mem_self (frameMonomial_mem_towerBigrade hη hbb hba Ε d)]
    exact Submodule.smul_mem _ _ (Submodule.subset_span ⟨d, rfl⟩)
  · rw [towerBigradeProj_of_mem_ne (frameMonomial_mem_towerBigrade hη hbb hba Ε d)
      (not_and_or.mp hjm), smul_zero]
    exact Submodule.zero_mem _

end DdfHomogeneity

/-! ### The converse of `ddfSpansOn_bigrade_of_b26`, and the equivalence -/

section Converse

variable {D : ℕ} {K : Type*} [Field K] [LinearOrder K] [IsStrictOrderedRing K] [Algebra ℚ K]
variable {η a b : Fin D → K} {hη : ∀ μ, η μ * η μ = 1} {Ε : TransverseFrame η b}
variable (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1)

include hη hbb hba in
/-- **The slice spanning lemma implies the rank inequality.**  The decomposition
`x = d + z` supplied by `DDFSpansOn` is projected onto the slice; both summands survive the
projection by `towerBigradeProj_mem_ddfSpan` and `towerBigradeProj_mem_towerNullSubmodule`. -/
theorem le_sup_inf_of_ddfSpansOn_bigrade {N : ℕ}
    (h : DDFSpansOn η a b hη Ε (towerBigrade D K (-(N : ℤ)) N)) :
    towerPhysSubmodule η a b (invTwo K * Fock.zeroModeSq η a) ⊓ towerBigrade D K (-(N : ℤ)) N
      ≤ (ddfSpan η a b hη Ε ⊓ towerBigrade D K (-(N : ℤ)) N)
        ⊔ (towerNullSubmodule η a b (invTwo K * Fock.zeroModeSq η a)
            ⊓ towerBigrade D K (-(N : ℤ)) N) := by
  intro x hx
  obtain ⟨d, hd, z, hz, hdz⟩ := Submodule.mem_sup.1 (h hx)
  have hproj : towerBigradeProj D K (-(N : ℤ)) N x = x :=
    towerBigradeProj_of_mem_self (Submodule.mem_inf.1 hx).2
  have hsplit : x = towerBigradeProj D K (-(N : ℤ)) N d + towerBigradeProj D K (-(N : ℤ)) N z := by
    rw [← map_add, hdz, hproj]
  rw [hsplit]
  exact Submodule.add_mem _
    (Submodule.mem_sup_left (Submodule.mem_inf.2
      ⟨towerBigradeProj_mem_ddfSpan hη hbb hba Ε _ _ hd, towerBigradeProj_mem _ _ _⟩))
    (Submodule.mem_sup_right (Submodule.mem_inf.2
      ⟨towerBigradeProj_mem_towerNullSubmodule η a b _ _ hz, towerBigradeProj_mem _ _ _⟩))

include hη hbb hba in
/-- The converse of `ddfSpansOn_bigrade_of_b26`. -/
theorem b26_of_ddfSpansOn_bigrade {N : ℕ}
    (h : DDFSpansOn η a b hη Ε (towerBigrade D K (-(N : ℤ)) N)) : B26 η a b hη Ε N :=
  le_trans (Submodule.finrank_mono (le_sup_inf_of_ddfSpansOn_bigrade hbb hba h))
    (Submodule.finrank_add_le_finrank_add_finrank _ _)

include hη hbb hba in
/-- **`B26 N` is exactly the slice spanning lemma** (blueprint §B′.3): the rank form of the
critical-dimension input loses no information. -/
theorem ddfSpansOn_bigrade_iff_b26 {N : ℕ} :
    DDFSpansOn η a b hη Ε (towerBigrade D K (-(N : ℤ)) N) ↔ B26 η a b hη Ε N :=
  ⟨b26_of_ddfSpansOn_bigrade hbb hba, ddfSpansOn_bigrade_of_b26 hbb hba⟩

end Converse

end StringFormal.NoGhost
