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
* `ddfSpans_of_forall_slice` — **the main glue lemma**: `DDFSpansOn` on every slice gives
  `DDFSpans`.
* `ddfSpans_of_forall_antidiagonal_slice` — the same with the quantifier restricted to the
  slices the mass shell allows, `(j : R) + N = 0`; over a `CharZero` ring this is the single
  antidiagonal `j = -N` (`ddfSpans_of_forall_antidiagonal_slice_int`).
* `towerLevelLESubmodule D R Nmax`, `ddfSpansOn_towerLevelLE`,
  `ddfSpansOn_towerLevelLE_of_antidiagonal` — the **level-truncated** form, which is what a
  partial §B.6 induction (currently `N = 1`, with `N = 2` in progress) actually proves.

## Gaps

* Nothing here proves `DDFSpansOn` on any slice other than the ones already available
  (`(-1,1)` from `Assembly.ddfSpans_bigrade_neg_one_one`).  `D = 26` still does not appear
  anywhere; it is inside the per-slice hypotheses.
* The bigrading is handled by explicit projections, **not** by a `DirectSum.Decomposition`
  instance on `TowerFock D R`.  Directness is never asserted; only the (weaker, and all that
  is needed) statements "the projections reproduce the vector" and "the projections land in
  the pieces" are proved.
* `towerLevelLESubmodule` is defined as a join of slices, not as a kernel/`Finsupp`-support
  condition; no comparison with "oscillator degree `≤ Nmax`" as a polynomial-degree bound is
  made (it would be true but is not needed).
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

/-! ### The glue lemma: slice by slice implies everywhere -/

section Glue

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]
variable {η a b : Fin D → R} {hη : ∀ μ, η μ * η μ = 1} {Ε : TransverseFrame η b}

/-- **The main glue lemma of blueprint §B.**  If the DDF spanning lemma holds on every
bigraded slice `(rung j, oscillator level N)`, it holds globally.

The content is `towerPhys_le_iSup_bigrade`: the physical subspace is the join of its
bigraded slices, so a `⊓`-restricted statement can be assembled across slices.  The
hypotheses `hη`, `Ε` are only carried along; nothing about `D` is used. -/
theorem ddfSpans_of_forall_slice
    (h : ∀ (j : ℤ) (N : ℕ), DDFSpansOn η a b hη Ε (towerBigrade D R j N)) :
    DDFSpans η a b hη Ε :=
  le_trans (towerPhys_le_iSup_bigrade η a b)
    (iSup_le fun j => iSup_le fun N => le_trans (le_of_eq (inf_comm _ _)) (h j N))

/-- **The mass shell restricts the quantifier to one antidiagonal.**

A nonzero physical vector in the slice `(j, N)` forces `α' k² + j + N = a₀`, and at the
ground-state intercept `a₀ = α' k²` this is `j + N = 0` in `R`
(`massShell_of_mem_towerBigrade`).  So only the slices satisfying that equation need to be
checked; all other slices meet `H_phys` in `0`.

`NoZeroDivisors R` is inherited from `massShell_of_mem_towerBigrade`, where it is what turns
"the scalar `α' k² + j + N - a₀` annihilates `x`" into "the scalar vanishes". -/
theorem ddfSpans_of_forall_antidiagonal_slice [NoZeroDivisors R]
    (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1)
    (h : ∀ (j : ℤ) (N : ℕ), (j : R) + (N : R) = 0 →
      DDFSpansOn η a b hη Ε (towerBigrade D R j N)) :
    DDFSpans η a b hη Ε := by
  refine ddfSpans_of_forall_slice fun j N => ?_
  intro x hx
  obtain ⟨hphys, hbig⟩ := Submodule.mem_inf.1 hx
  rcases eq_or_ne x 0 with rfl | hne
  · exact Submodule.zero_mem _
  · refine h j N ?_ hx
    have hm := massShell_of_mem_towerBigrade η a b hη hbb hba hbig
      (Submodule.mem_inf.1 hphys).1 hne
    have hm' : invTwo R * Fock.zeroModeSq η a + ((j : R) + (N : R))
        = invTwo R * Fock.zeroModeSq η a + 0 := by
      rw [add_zero, ← add_assoc]; exact hm
    exact add_left_cancel hm'

/-- The antidiagonal restriction in its integer form: over a `CharZero` ring the surviving
slices are exactly `(rung -N, level N)`, i.e. a DDF state built with `N` units of `k_0` sits
at rung `-N` and oscillator level `N`.  This is the shape the graded induction of §B.6
actually produces. -/
theorem ddfSpans_of_forall_antidiagonal_slice_int [NoZeroDivisors R] [CharZero R]
    (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1)
    (h : ∀ N : ℕ, DDFSpansOn η a b hη Ε (towerBigrade D R (-(N : ℤ)) N)) :
    DDFSpans η a b hη Ε := by
  refine ddfSpans_of_forall_antidiagonal_slice hbb hba fun j N hjn => ?_
  have h0 : j + (N : ℤ) = 0 := by exact_mod_cast hjn
  have hj : j = -(N : ℤ) := by omega
  subst hj
  exact h N

end Glue

/-! ### The level-truncated statement

For the partial results of blueprint §B.6 (which at the time of writing reach `N = 1`, with
`N = 2` in progress) the honest global statement is not `DDFSpans` but `DDFSpansOn` on the
subspace spanned by the slices of oscillator level at most `Nmax`. -/

section Truncation

variable (D : ℕ) (R : Type*) [CommRing R]

/-- **The level-`≤ Nmax` part of the tower**: the join of the bigraded slices of oscillator
level at most `Nmax` (all rungs).  Equivalently, the vectors all of whose rung components are
polynomials of oscillator level `≤ Nmax`. -/
noncomputable def towerLevelLESubmodule (Nmax : ℕ) : Submodule R (TowerFock D R) :=
  ⨆ (j : ℤ) (N : ℕ) (_ : N ≤ Nmax), towerBigrade D R j N

variable {D R}

theorem towerBigrade_le_towerLevelLESubmodule {Nmax : ℕ} (j : ℤ) {N : ℕ} (hN : N ≤ Nmax) :
    towerBigrade D R j N ≤ towerLevelLESubmodule D R Nmax :=
  le_iSup_of_le j (le_iSup_of_le N (le_iSup_of_le hN le_rfl))

/-- Above the truncation the bigraded projections vanish. -/
theorem towerBigradeProj_eq_zero_of_mem_towerLevelLESubmodule {Nmax : ℕ} {x : TowerFock D R}
    (hx : x ∈ towerLevelLESubmodule D R Nmax) (j : ℤ) {N : ℕ} (hN : Nmax < N) :
    towerBigradeProj D R j N x = 0 := by
  have hle : towerLevelLESubmodule D R Nmax ≤ LinearMap.ker (towerBigradeProj D R j N) :=
    iSup_le fun _ => iSup_le fun N' => iSup_le fun hN' => fun y hy =>
      LinearMap.mem_ker.2 (towerBigradeProj_of_mem_ne hy (Or.inr (by omega)))
  exact LinearMap.mem_ker.1 (hle hx)

variable [Algebra ℚ R]

/-- The truncated analogue of `towerPhys_le_iSup_bigrade`. -/
theorem towerPhys_inf_towerLevelLE_le_iSup_bigrade (η a b : Fin D → R) {a₀ : R} (Nmax : ℕ) :
    towerPhysSubmodule η a b a₀ ⊓ towerLevelLESubmodule D R Nmax
      ≤ ⨆ (j : ℤ) (N : ℕ) (_ : N ≤ Nmax),
          towerBigrade D R j N ⊓ towerPhysSubmodule η a b a₀ := by
  classical
  intro x hx
  obtain ⟨hphys, hle⟩ := Submodule.mem_inf.1 hx
  rw [← sum_towerBigradeProj x]
  refine Submodule.sum_mem _ fun j _ => Submodule.sum_mem _ fun N _ => ?_
  rcases le_or_gt N Nmax with hN | hN
  · exact Submodule.mem_iSup_of_mem j (Submodule.mem_iSup_of_mem N
      (Submodule.mem_iSup_of_mem hN (Submodule.mem_inf.2
        ⟨towerBigradeProj_mem j N x,
          towerBigradeProj_mem_towerPhysSubmodule η a b hphys j N⟩)))
  · rw [towerBigradeProj_eq_zero_of_mem_towerLevelLESubmodule hle j hN]
    exact Submodule.zero_mem _

variable {η a b : Fin D → R} {hη : ∀ μ, η μ * η μ = 1} {Ε : TransverseFrame η b}

/-- **The level-truncated glue lemma.**  Spanning on every slice of oscillator level `≤ Nmax`
gives spanning on the whole level-`≤ Nmax` part of the tower.  This is the statable form of a
partial §B.6 induction: with `Nmax = 1` its hypothesis is discharged by
`ddfSpans_bigrade_neg_one_one` together with the vanishing of the off-antidiagonal slices
(see `ddfSpansOn_towerLevelLE_of_antidiagonal`). -/
theorem ddfSpansOn_towerLevelLE (Nmax : ℕ)
    (h : ∀ (j : ℤ) (N : ℕ), N ≤ Nmax → DDFSpansOn η a b hη Ε (towerBigrade D R j N)) :
    DDFSpansOn η a b hη Ε (towerLevelLESubmodule D R Nmax) :=
  le_trans (towerPhys_inf_towerLevelLE_le_iSup_bigrade η a b Nmax)
    (iSup_le fun j => iSup_le fun N => iSup_le fun hN =>
      le_trans (le_of_eq (inf_comm _ _)) (h j N hN))

/-- The level-truncated glue lemma with the quantifier cut down to the mass-shell
antidiagonal: it suffices to know the spanning lemma on the `Nmax + 1` slices
`(rung -N, level N)`, `N ≤ Nmax`. -/
theorem ddfSpansOn_towerLevelLE_of_antidiagonal [NoZeroDivisors R] [CharZero R] (Nmax : ℕ)
    (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1)
    (h : ∀ N : ℕ, N ≤ Nmax → DDFSpansOn η a b hη Ε (towerBigrade D R (-(N : ℤ)) N)) :
    DDFSpansOn η a b hη Ε (towerLevelLESubmodule D R Nmax) := by
  refine ddfSpansOn_towerLevelLE Nmax fun j N hN => ?_
  intro x hx
  obtain ⟨hphys, hbig⟩ := Submodule.mem_inf.1 hx
  rcases eq_or_ne x 0 with rfl | hne
  · exact Submodule.zero_mem _
  · have hm := massShell_of_mem_towerBigrade η a b hη hbb hba hbig
      (Submodule.mem_inf.1 hphys).1 hne
    have hm' : invTwo R * Fock.zeroModeSq η a + ((j : R) + (N : R))
        = invTwo R * Fock.zeroModeSq η a + 0 := by
      rw [add_zero, ← add_assoc]; exact hm
    have hjn : (j : R) + (N : R) = 0 := add_left_cancel hm'
    have h0 : j + (N : ℤ) = 0 := by exact_mod_cast hjn
    have hj : j = -(N : ℤ) := by omega
    subst hj
    exact h N hN hx

end Truncation

end StringFormal.NoGhost
