/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.Assembly

/-!
# Gluing the graded pieces: "slice by slice" implies "everywhere"

Graph nodes: `worldsheet.no-ghost-theorem-v4` (clause (1b), the bigrading),
`worldsheet.ddf-spans-physical-states`.  This is §B of `formal/BLUEPRINT-noghost.md`, the
bookkeeping step that lets the graded induction of §B.6 be run one bigraded slice at a time.

Conventions: `graph/conventions/metric-mostly-plus.yaml`, `graph/conventions/alpha-prime.yaml`
(same as the rest of `NoGhost/`).  Intercept `a₀ = α' k²` throughout `DDFSpans`.

## The problem this file solves

`Assembly.lean` states the spanning lemma both globally (`DDFSpans`) and on a subspace
(`DDFSpansOn … W`), and `LightCone.lean`/`Assembly.lean` prove it on the single slice
`W = towerBigrade D R (-1) 1`.  The graded induction of blueprint §B.6 produces exactly such
per-slice statements.  What is missing — and what is proved here — is the implication

> if `DDFSpansOn` holds on **every** bigraded slice `towerBigrade D R j N`, then `DDFSpans`
> holds.

This is not formal nonsense: `DDFSpansOn … W` is *not* monotone in `W` in a way that would
make `⊤` follow from a supremum of subspaces for free, because the left-hand side of
`DDFSpansOn` is `H_phys ⊓ W`, and `⨆ W` on the right of an `⊓` does not distribute.  What
makes it work is that `H_phys` is itself spanned by its bigraded pieces
(`towerPhys_le_iSup_bigrade`), which in turn is the statement that `L_0` and the `L_m`
(`m ≥ 1`) are **homogeneous for the bigrading**.

## What is here

* `towerBigradeProj D R j N` — the explicit projection `x ↦ single j ((x j)_N)` onto the
  bigraded piece, built from `Fock.levelComponent` (Mathlib's `weightedHomogeneousComponent`).
  Using projections rather than an abstract `DirectSum.Decomposition` keeps everything
  computational: "the components of a physical state are physical" becomes a `rw`.
* `towerLop_mem_towerBigrade`, `towerLop_apply_eq_zero_of_mem_towerBigrade_of_lt` — **`L_m` is
  homogeneous of bidegree `(0, -m)`**: it preserves the rung and lowers the level by `m`,
  killing everything of level `< m`.
* `towerBigradeProj_towerLop` — the resulting intertwining relation, the tower analogue of
  `Fock.levelComponent_Lop`.
* `towerBigradeProj_mem_towerPhysSubmodule` — **the bigraded components of a physical state
  are physical**.
* `towerPhys_le_iSup_bigrade`, `towerPhysSubmodule_eq_iSup_inf_towerBigrade` — the physical
  subspace of the tower is spanned by its bigraded slices.

## Gaps

* Nothing here proves `DDFSpansOn` on any slice other than the ones already available
  (`(-1,1)` from `Assembly.ddfSpans_bigrade_neg_one_one`).  `D = 26` still does not appear
  anywhere; it is inside the per-slice hypotheses.
* The bigrading is handled by explicit projections, **not** by a `DirectSum.Decomposition`
  instance on `TowerFock D R`.  Directness is never asserted; only the (weaker, and all that
  is needed) statements "the projections reproduce the vector" and "the projections land in
  the pieces" are proved.
-/

namespace StringFormal.NoGhost

/-! ### The bigraded projection -/

section Proj

variable (D : ℕ) (R : Type*) [CommRing R]

/-- **The projection onto the bigraded piece `(rung j, oscillator level N)`**:
`x ↦ single j ((x j)_N)`, where `(·)_N` is `Fock.levelComponent` (Mathlib's
`weightedHomogeneousComponent` for the oscillator weight).

This is the concrete replacement for a `DirectSum.Decomposition` on `TowerFock D R`: it is a
genuine linear projection whose image is `towerBigrade D R j N` and which reproduces any
vector when summed over the finitely many `(j, N)` in its support. -/
noncomputable def towerBigradeProj (j : ℤ) (N : ℕ) :
    TowerFock D R →ₗ[R] TowerFock D R :=
  (Finsupp.lsingle j).comp ((Fock.levelComponent D R N).comp (Finsupp.lapply j))

variable {D R}

lemma towerBigradeProj_apply (j : ℤ) (N : ℕ) (x : TowerFock D R) :
    towerBigradeProj D R j N x = Finsupp.single j (Fock.levelComponent D R N (x j)) :=
  rfl

lemma towerBigradeProj_apply' (j : ℤ) (N : ℕ) (x : TowerFock D R) :
    towerBigradeProj D R j N x
      = Finsupp.lsingle (R := R) j (Fock.levelComponent D R N (x j)) :=
  rfl

/-- The projection lands in the bigraded piece it names. -/
theorem towerBigradeProj_mem (j : ℤ) (N : ℕ) (x : TowerFock D R) :
    towerBigradeProj D R j N x ∈ towerBigrade D R j N :=
  single_mem_towerBigrade (Fock.levelComponent_mem N _)

/-- The projection is the identity on its own piece. -/
theorem towerBigradeProj_of_mem_self {j : ℤ} {N : ℕ} {y : TowerFock D R}
    (hy : y ∈ towerBigrade D R j N) : towerBigradeProj D R j N y = y := by
  obtain ⟨hy1, hy2⟩ := mem_towerBigrade.1 hy
  rw [towerBigradeProj_apply, Fock.levelComponent_of_mem_self hy2, ← hy1]

/-- The projection kills the other pieces. -/
theorem towerBigradeProj_of_mem_ne {j j' : ℤ} {N N' : ℕ} {y : TowerFock D R}
    (hy : y ∈ towerBigrade D R j' N') (h : j ≠ j' ∨ N ≠ N') :
    towerBigradeProj D R j N y = 0 := by
  obtain ⟨hy1, hy2⟩ := mem_towerBigrade.1 hy
  have hoff : ∀ i : ℤ, i ≠ j' → y i = 0 := fun i hi => by
    conv_lhs => rw [hy1]
    exact Finsupp.single_eq_of_ne (Ne.symm hi).symm
  rcases h with h | h
  · rw [towerBigradeProj_apply, hoff j h, map_zero, Finsupp.single_zero]
  · rcases eq_or_ne j j' with rfl | hjj
    · rw [towerBigradeProj_apply, Fock.levelComponent_of_mem_ne h hy2, Finsupp.single_zero]
    · rw [towerBigradeProj_apply, hoff j hjj, map_zero, Finsupp.single_zero]

/-- **Every tower vector is the finite sum of its bigraded components.**  The rung index runs
over the `Finsupp` support, the level index over the levels occurring on that rung. -/
theorem sum_towerBigradeProj (x : TowerFock D R) :
    ∑ j ∈ x.support, ∑ N ∈ (x j).support.image (Fock.level D),
        towerBigradeProj D R j N x = x := by
  classical
  conv_rhs => rw [← Finsupp.sum_single x]
  refine Finset.sum_congr rfl fun j _ => ?_
  simp only [towerBigradeProj_apply']
  rw [← map_sum (Finsupp.lsingle (R := R) (M := Fock D R) j), Fock.sum_levelComponent,
    Finsupp.lsingle_apply]

end Proj

/-! ### `L_m` is homogeneous for the bigrading -/

section Homogeneous

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] (η a b : Fin D → R)

/-- **`L_m` has bidegree `(0, -m)`**: it preserves the rung (it is `towerDiag` of the
single-Fock `L_m`, which does not move momentum) and lowers the oscillator level by `m`. -/
theorem towerLop_mem_towerBigrade {j : ℤ} {N : ℕ} {y : TowerFock D R}
    (hy : y ∈ towerBigrade D R j N) {m : ℤ} {N' : ℕ} (hN' : (N' : ℤ) = (N : ℤ) - m) :
    towerLop η a b m y ∈ towerBigrade D R j N' := by
  obtain ⟨hy1, hy2⟩ := mem_towerBigrade.1 hy
  rw [hy1, towerLop_single]
  exact single_mem_towerBigrade (Fock.Lop_mem_levelSubmodule η _ hy2 hN')

/-- `L_m` annihilates the slices of level `< m`. -/
theorem towerLop_apply_eq_zero_of_mem_towerBigrade_of_lt {j : ℤ} {N : ℕ} {y : TowerFock D R}
    (hy : y ∈ towerBigrade D R j N) {m : ℤ} (hm : (N : ℤ) < m) :
    towerLop η a b m y = 0 := by
  obtain ⟨hy1, hy2⟩ := mem_towerBigrade.1 hy
  rw [hy1, towerLop_single, Fock.Lop_apply_eq_zero_of_level_lt η _ hy2 hm, Finsupp.single_zero]

/-- **`L_m` intertwines the bigraded projections**: `(L_m x)_{(j, N - m)} = L_m (x_{(j,N)})`.
The tower analogue of `Fock.levelComponent_Lop`; the rung index is untouched because
`towerLop` is diagonal in the rung. -/
theorem towerBigradeProj_towerLop (m : ℤ) {N N' : ℕ} (hN : (N' : ℤ) = (N : ℤ) - m) (j : ℤ)
    (x : TowerFock D R) :
    towerBigradeProj D R j N' (towerLop η a b m x)
      = towerLop η a b m (towerBigradeProj D R j N x) := by
  classical
  have key : towerBigradeProj D R j N' ∘ₗ (towerLop η a b m : TowerFock D R →ₗ[R] _)
      = (towerLop η a b m : TowerFock D R →ₗ[R] _) ∘ₗ towerBigradeProj D R j N := by
    refine Finsupp.lhom_ext fun i P => ?_
    rw [LinearMap.comp_apply, LinearMap.comp_apply, towerLop_single, towerBigradeProj_apply,
      towerBigradeProj_apply, Finsupp.single_apply, Finsupp.single_apply]
    rcases eq_or_ne i j with rfl | hij
    · rw [if_pos rfl, if_pos rfl, towerLop_single, Fock.levelComponent_Lop η _ m hN]
    · rw [if_neg hij, if_neg hij, map_zero, map_zero, Finsupp.single_zero]
      exact (map_zero _).symm
  exact congrArg (fun f : TowerFock D R →ₗ[R] TowerFock D R => f x) key

end Homogeneous

/-! ### The physical subspace is spanned by its bigraded slices -/

section PhysBigrade

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] (η a b : Fin D → R) {a₀ : R}

/-- **The bigraded components of a physical state are physical.**

Both physical-state conditions are homogeneous: the `L_0` condition because `L_0` has
bidegree `(0,0)`, the `L_m` conditions (`m ≥ 1`) because `L_m` has bidegree `(0,-m)` and
kills the slices below level `m`.  No hypothesis on `η`, `a`, `b` is needed. -/
theorem towerBigradeProj_mem_towerPhysSubmodule {x : TowerFock D R}
    (hx : x ∈ towerPhysSubmodule η a b a₀) (j : ℤ) (N : ℕ) :
    towerBigradeProj D R j N x ∈ towerPhysSubmodule η a b a₀ := by
  obtain ⟨h0, hpos⟩ := mem_towerPhysSubmodule.1 hx
  refine mem_towerPhysSubmodule.2 ⟨?_, fun m hm => ?_⟩
  · rw [← towerBigradeProj_towerLop η a b 0 (N := N) (N' := N) (by simp) j x, h0, map_smul]
  · by_cases hlt : (N : ℤ) < m
    · exact towerLop_apply_eq_zero_of_mem_towerBigrade_of_lt η a b
        (towerBigradeProj_mem j N x) hlt
    · rw [← towerBigradeProj_towerLop η a b m (N := N) (N' := ((N : ℤ) - m).toNat) (by omega)
        j x, hpos m hm, map_zero]

/-- **The physical subspace of the momentum tower is spanned by its bigraded slices**
(blueprint §B.1).  This is what makes the per-slice induction of §B.6 sufficient. -/
theorem towerPhys_le_iSup_bigrade :
    towerPhysSubmodule η a b a₀
      ≤ ⨆ (j : ℤ) (N : ℕ), towerBigrade D R j N ⊓ towerPhysSubmodule η a b a₀ := by
  classical
  intro x hx
  rw [← sum_towerBigradeProj x]
  refine Submodule.sum_mem _ fun j _ => Submodule.sum_mem _ fun N _ => ?_
  refine Submodule.mem_iSup_of_mem j (Submodule.mem_iSup_of_mem N ?_)
  exact Submodule.mem_inf.2 ⟨towerBigradeProj_mem j N x,
    towerBigradeProj_mem_towerPhysSubmodule η a b hx j N⟩

/-- The equality form of `towerPhys_le_iSup_bigrade`. -/
theorem towerPhysSubmodule_eq_iSup_inf_towerBigrade :
    towerPhysSubmodule η a b a₀
      = ⨆ (j : ℤ) (N : ℕ), towerBigrade D R j N ⊓ towerPhysSubmodule η a b a₀ :=
  le_antisymm (towerPhys_le_iSup_bigrade η a b)
    (iSup_le fun _ => iSup_le fun _ => inf_le_right)

end PhysBigrade

end StringFormal.NoGhost
