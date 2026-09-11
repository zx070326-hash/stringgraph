/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.Longitudinal
import StringFormal.NoGhost.Witness

/-!
# The light-cone frame on the DDF momentum tower

Graph nodes: `worldsheet.no-ghost-theorem-v4` (1b), `worldsheet.ddf-operators-v6`;
blueprint `formal/BLUEPRINT-noghost.md` §B.1 and §B.4.

This file supplies the *grading infrastructure* that the spanning lemma `ddf-spans` needs, and
the *light-cone oscillator algebra* in which the unitriangular change of basis of blueprint
§B.4 is stated.

## Main definitions

* `towerVacuum D R` — the tower ground state `|0; k⟩ = single 0 1`.
* `towerRungSubmodule D R j` — vectors concentrated on rung `j`.
* `towerLevelSubmodule D R N` — vectors whose every rung has oscillator level `N`.
* `towerBigrade D R j N` — the bigraded piece (rung `j`, oscillator level `N`); it is the
  intersection of the previous two (`towerBigrade_eq_inf`) and is a finite `R`-module
  (`towerBigrade_finite`).
* `LightConeFrame η b` — a light-cone pair `(b, b̃)` with `b·b = b̃·b̃ = 0`, `b·b̃ = -1`.
* `TransverseFrame η b` — `D - 2` polarisations, `η`-orthonormal and transverse to `b`.
* `ddfSpan η a b hη Ε` — the submodule spanned by the DDF states
  `A^{ε_{i_1}}_{-n_1} ⋯ A^{ε_{i_r}}_{-n_r}|0; k⟩`.

## Main results

* `towerVacuum_mem_towerPhysSubmodule` — the ground state is physical at intercept
  `a₀ = α' k²` (blueprint §B.1).
* `massShell_of_mem_towerBigrade` — **the mass shell collapses the bigrading to a single
  antidiagonal**: a nonzero physical vector in `towerBigrade j N` satisfies
  `α' k² + j + N = a₀`.  This is the submodule form of the "`N = a - α' p²`" clause of
  `worldsheet.no-ghost-theorem-v4` (1b), and the reason a DDF state at rung `-N` sits at
  oscillator level `N`.
* `lie_kOp_kOp`, `lie_conjOp_conjOp`, `lie_kOp_conjOp`, `lie_transOp_transOp`,
  `lie_conjOp_transOp` — **the light-cone oscillator algebra**
  `[α^b_m, α^b_n] = [α^b̃_m, α^b̃_n] = 0`, `[α^b_m, α^b̃_n] = -m δ_{m+n,0}`,
  `[α^{ε_i}_m, α^{ε_j}_n] = m δ_{ij} δ_{m+n,0}`, `[α^b̃_m, α^{ε_i}_n] = 0`; all are
  specialisations of `lie_towerModeVec_towerModeVec`.
* `conjCoeff_eq_neg_dotVec` — **the `b̃`-component of a vector is `-(b·v)`**, which is what
  pins the leading coefficient of `L_{-n}` to `-1` (blueprint §B.4, third leading-term
  lemma): the momentum `a` has `b·a = 1` by the DDF normalisation, so its `b̃`-component is
  exactly `-1`, on every rung of the tower (`conjCoeff_towerMomentum`).
* `towerLop_neg_one_apply_single_vacuum`, `towerLop_neg_two_apply_single_vacuum` — the
  **leading-term expansions of `L_{-1}` and `L_{-2}` on a rung vacuum**, in the form
  `L_{-n}|0;p⟩ = α^p_{-n}|0;p⟩ + (≥ 2 oscillators)`; combined with
  `conjCoeff_towerMomentum` this is the `n ≤ 2` case of `L_{-n} = -α^{b̃}_{-n} + …`.
* `ddfOp_neg_one_apply_towerVacuum` — **`A^ε_{-1}|0; k⟩ = α^ε_{-1}|0; k - k_0⟩` exactly**
  (blueprint §B.4, second leading-term lemma, at `n = 1`), under the *extra* hypothesis
  `ε·k = 0`; see the gaps below.
* `ddfSpan_le_towerPhysSubmodule`, `ddfSpan_le_towerKerK`, `ddfSpan_le_ddfCharacterization` —
  the easy inclusion of blueprint §B.0: every DDF state is physical and satisfies the
  Goddard–Thorn `K`-conditions.
* `towerPhys_bigrade_one_le_ddfSpan_sup_spurious` — **blueprint §B.6 at `N = 1`**: on the
  bigraded piece (rung `-1`, level `1`) every physical state is a DDF state plus a spurious
  state `L_{-1}|0; k-k_0⟩`.  `D = 26` does not enter (§B.5); two *extra* hypotheses do, see
  the gaps.
* `witnessLightConeFrame`, `witnessTransverseFrame` — the explicit frame of
  `NoGhost/Witness.lean` instantiates **both** structures, so none of the frame-conditional
  results above is vacuous; `dotVec_witnessTransverseFrame_witnessMomentum` also discharges
  the extra `ε·k = 0` hypothesis for it.

## Scope and gaps

* **The leading term of `A^ε_{-1}` needs `ε·k = 0`, not just `ε·k_0 = 0`.**  The DDF island's
  four standing hypotheses (`hη`, `hbb`, `hba`, `hεb`) do *not* imply it, and without it
  `A^ε_{-1}|0;k⟩` acquires an extra term `(ε·k) Φ_1|0; k-k_0⟩`.  The light-cone witness of
  `NoGhost/Witness.lean` does satisfy `ε·k = 0`; this should be recorded in the graph as part
  of the DDF frame convention rather than left implicit.
* The leading-term expansion of `L_{-n}` is proved only for `n = 1, 2`, because
  `Fock.Lop_neg_one_apply_one` and `Fock.Lop_neg_two_apply_one` are the only rung-vacuum
  formulas available; a general `n` needs the Sugawara sum on the vacuum for arbitrary `n`,
  which is not formalised.  `n ≤ 2` is exactly what the `N ≤ 2` increment of blueprint §B.6
  uses.
* `conjCoeff_eq_neg_dotVec` does **not** assume that `{b, b̃, ε_i}` is a basis: it extracts
  the `b̃`-coefficient of a *given* decomposition.  Completeness of the light-cone frame
  (every vector decomposes) is a further statement, not needed here and not proved.
* **`TransverseFrame` does not imply completeness.**  The `N = 1` spanning theorem therefore
  carries the explicit hypothesis `FrameSpansOrthogonal`, which says that the `D - 2`
  transverse vectors together with `p_{-1}` span `p_{-1}^⊥`.  It is the **only** hypothesis of
  that theorem still undischarged for the explicit witness (`witnessTransverseFrame` and
  `dotVec_witnessTransverseFrame_witnessMomentum` handle the others).  Discharging it is a
  concrete `Pi.single` computation: for the witness, `e ⊥ p_{-1}` reads `e_0 + e_1 = 0` and
  then `e = (-2 e_0) • p_{-1} + Σ_{i} e_{i+2} • ε_i`.
* `N = 2` of blueprint §B.6 is **not** done.  The two missing pieces are (a) the analogue of
  `ddfOp_neg_one_apply_towerVacuum` at `n = 2` and for `A^ε_{-1}A^δ_{-1}` (window `{-2,…,0}`,
  so the vertex operator's level-1 and level-2 coefficients `Φ_1`, `Φ_2` actually contribute)
  and (b) the level-2 analogue of `Fock.mem_physSubmodule_inf_levelSubmodule_one_iff`, i.e.
  the *complete* solution of the `L_1`/`L_2` conditions at level 2 — `NoGhost/LevelTwo.lean`
  only covers the `SO(D-1)`-scalar trial family, as its own docstring says.
* The unitriangularity of the transition matrix (blueprint §B.4 step 3) is **not** proved.
-/

namespace StringFormal.NoGhost

/-! ### The tower ground state -/

section TowerVacuum

variable {D : ℕ} {R : Type*} [CommRing R]

/-- **The ground state of the momentum tower** `|0; k⟩`: the oscillator vacuum on rung `0`,
whose momentum parameter is `towerMomentum a b 0 = a`. -/
noncomputable def towerVacuum (D : ℕ) (R : Type*) [CommRing R] : TowerFock D R :=
  Finsupp.single 0 (Fock.vacuum D R)

lemma towerVacuum_def : towerVacuum D R = Finsupp.single 0 (1 : Fock D R) := rfl

@[simp]
lemma towerVacuum_apply_zero : (towerVacuum D R) 0 = 1 := by
  rw [towerVacuum_def, Finsupp.single_eq_same]

lemma towerVacuum_apply_of_ne {j : ℤ} (hj : j ≠ 0) : (towerVacuum D R) j = 0 := by
  rw [towerVacuum_def, Finsupp.single_eq_of_ne hj]

end TowerVacuum

/-! ### The bigrading of the tower: rung and oscillator level -/

section Bigrade

variable (D : ℕ) (R : Type*) [CommRing R]

/-- **The rung-`j` piece of the tower**: vectors supported on the single rung `j`. -/
noncomputable def towerRungSubmodule (j : ℤ) : Submodule R (TowerFock D R) :=
  ⨅ i : ℤ, ⨅ _ : i ≠ j, LinearMap.ker (Finsupp.lapply (M := Fock D R) (R := R) i)

/-- **The oscillator-level-`N` piece of the tower**: vectors whose component on every rung is
homogeneous of `Fock.level` equal to `N`. -/
noncomputable def towerLevelSubmodule (N : ℕ) : Submodule R (TowerFock D R) :=
  ⨅ i : ℤ, Submodule.comap (Finsupp.lapply (M := Fock D R) (R := R) i)
    (Fock.levelSubmodule D R N)

/-- **The bigraded piece `(rung j, oscillator level N)`** of the momentum tower (blueprint
§B.1 `towerBigrade`). -/
noncomputable def towerBigrade (j : ℤ) (N : ℕ) : Submodule R (TowerFock D R) :=
  Submodule.map (Finsupp.lsingle (M := Fock D R) (R := R) j) (Fock.levelSubmodule D R N)

variable {D R}

lemma mem_towerRungSubmodule {j : ℤ} {x : TowerFock D R} :
    x ∈ towerRungSubmodule D R j ↔ ∀ i : ℤ, i ≠ j → x i = 0 := by
  simp only [towerRungSubmodule, Submodule.mem_iInf, LinearMap.mem_ker, Finsupp.lapply_apply]

lemma mem_towerLevelSubmodule {N : ℕ} {x : TowerFock D R} :
    x ∈ towerLevelSubmodule D R N ↔ ∀ i : ℤ, x i ∈ Fock.levelSubmodule D R N := by
  simp only [towerLevelSubmodule, Submodule.mem_iInf, Submodule.mem_comap,
    Finsupp.lapply_apply]

lemma mem_towerBigrade {j : ℤ} {N : ℕ} {x : TowerFock D R} :
    x ∈ towerBigrade D R j N ↔
      x = Finsupp.single j (x j) ∧ x j ∈ Fock.levelSubmodule D R N := by
  constructor
  · rintro ⟨P, hP, rfl⟩
    rw [Finsupp.lsingle_apply, Finsupp.single_eq_same]
    exact ⟨rfl, hP⟩
  · rintro ⟨hx, hlev⟩
    exact ⟨x j, hlev, by rw [Finsupp.lsingle_apply, ← hx]⟩

lemma single_mem_towerBigrade {j : ℤ} {N : ℕ} {P : Fock D R}
    (hP : P ∈ Fock.levelSubmodule D R N) : Finsupp.single j P ∈ towerBigrade D R j N :=
  ⟨P, hP, rfl⟩

/-- The bigraded piece is the intersection of the rung filtration with the level
filtration. -/
theorem towerBigrade_eq_inf (j : ℤ) (N : ℕ) :
    towerBigrade D R j N = towerRungSubmodule D R j ⊓ towerLevelSubmodule D R N := by
  refine le_antisymm (fun x hx => ?_) (fun x hx => ?_)
  · obtain ⟨hx1, hx2⟩ := mem_towerBigrade.1 hx
    refine Submodule.mem_inf.2 ⟨mem_towerRungSubmodule.2 fun i hi => ?_,
      mem_towerLevelSubmodule.2 fun i => ?_⟩
    · rw [hx1, Finsupp.single_eq_of_ne hi]
    · rcases eq_or_ne i j with rfl | hi
      · exact hx2
      · rw [hx1, Finsupp.single_eq_of_ne hi]
        exact Submodule.zero_mem _
  · obtain ⟨h1, h2⟩ := Submodule.mem_inf.1 hx
    refine mem_towerBigrade.2 ⟨?_, mem_towerLevelSubmodule.1 h2 j⟩
    refine Finsupp.ext fun i => ?_
    rcases eq_or_ne i j with rfl | hi
    · rw [Finsupp.single_eq_same]
    · rw [Finsupp.single_eq_of_ne hi, mem_towerRungSubmodule.1 h1 i hi]

/-- **Each bigraded piece is a finite module** (over a field: finite-dimensional).  This is
the finiteness that makes the unitriangular argument of blueprint §B.4 a statement about
finite matrices. -/
instance towerBigrade_finite (j : ℤ) (N : ℕ) : Module.Finite R (towerBigrade D R j N) :=
  Module.Finite.iff_fg.mpr ((Fock.levelSubmodule_fg D R N).map _)

variable (D R)

/-- The tower ground state sits in the bigraded piece `(rung 0, level 0)`. -/
theorem towerVacuum_mem_towerBigrade : towerVacuum D R ∈ towerBigrade D R 0 0 :=
  single_mem_towerBigrade (Fock.one_mem_levelSubmodule D R)

end Bigrade

/-! ### The ground state is physical, and the mass shell collapses the bigrading -/

section MassShell

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

/-- `L_0` acts on the bigraded piece `(j, N)` by the scalar `α' p_j² + N`, and under the DDF
normalisations `k_0² = 0`, `2α' k_0·k = 1` this is `α' k² + j + N`. -/
theorem towerLop_zero_apply_of_mem_towerBigrade (η a b : Fin D → R)
    (hη : ∀ μ, η μ * η μ = 1) (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1) {j : ℤ} {N : ℕ}
    {x : TowerFock D R} (hx : x ∈ towerBigrade D R j N) :
    towerLop η a b 0 x = (invTwo R * Fock.zeroModeSq η a + (j : R) + (N : R)) • x := by
  obtain ⟨hx1, hx2⟩ := mem_towerBigrade.1 hx
  conv_lhs => rw [hx1]
  conv_rhs => rw [hx1]
  rw [towerLop_single, Fock.Lop_zero_apply_of_mem_levelSubmodule η _ hη hx2,
    Finsupp.smul_single, invTwo_mul_zeroModeSq_towerMomentum η a b hbb hba j]

/-- **The ground state of the tower is physical** at intercept `a₀ = α' k²` (blueprint §B.1).
At the tachyonic normalisation `α' k² = 1` of `NoGhost/Witness.lean` this is the intercept
`a₀ = 1` of `worldsheet.open-string-intercept`. -/
theorem towerVacuum_mem_towerPhysSubmodule (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1) :
    towerVacuum D R ∈ towerPhysSubmodule η a b (invTwo R * Fock.zeroModeSq η a) := by
  refine mem_towerPhysSubmodule.2 ⟨?_, fun m hm => ?_⟩
  · have h := towerLop_zero_apply_of_mem_towerBigrade η a b hη hbb hba
      (towerVacuum_mem_towerBigrade D R)
    rw [h]
    norm_num
  · rw [towerVacuum_def, towerLop_single, Fock.Lop_apply_one_of_pos η _ hm,
      Finsupp.single_zero]

/-- **The mass shell collapses the bigrading onto a single antidiagonal** (blueprint §B.1,
`towerPhys_le_iSup_antidiagonal`; the "`N = a - α' p²`" clause of
`worldsheet.no-ghost-theorem-v4` (1b)).

A *nonzero* vector of the bigraded piece `(rung j, level N)` that satisfies the `L_0`
condition at intercept `a₀` must have `α' k² + j + N = a₀`.  In particular, at
`α' k² = a₀` (the ground-state normalisation) only `j + N = 0` survives: a DDF state built
with `n` units of `k_0` sits at rung `-N` and oscillator level `N`. -/
theorem massShell_of_mem_towerBigrade [NoZeroDivisors R] (η a b : Fin D → R)
    (hη : ∀ μ, η μ * η μ = 1) (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1) {a₀ : R}
    {j : ℤ} {N : ℕ} {x : TowerFock D R} (hx : x ∈ towerBigrade D R j N)
    (hphys : x ∈ towerL0Submodule η a b a₀) (hne : x ≠ 0) :
    invTwo R * Fock.zeroModeSq η a + (j : R) + (N : R) = a₀ := by
  classical
  have h0 := mem_towerL0Submodule.1 hphys
  rw [towerLop_zero_apply_of_mem_towerBigrade η a b hη hbb hba hx] at h0
  have hsub : (invTwo R * Fock.zeroModeSq η a + (j : R) + (N : R) - a₀) • x = 0 := by
    rw [sub_smul, h0, sub_self]
  obtain ⟨i, hi⟩ : ∃ i : ℤ, x i ≠ 0 := by
    by_contra hc
    exact hne (Finsupp.ext fun i => by simpa using not_not.mp (not_exists.mp hc i))
  obtain ⟨d, hd⟩ : ∃ d : Osc D →₀ ℕ, MvPolynomial.coeff d (x i) ≠ 0 := by
    by_contra hc
    exact hi (MvPolynomial.ext _ _ fun d => by
      rw [MvPolynomial.coeff_zero]
      exact not_not.mp (not_exists.mp hc d))
  have := congrArg (fun y : TowerFock D R => MvPolynomial.coeff d (y i)) hsub
  simp only [Finsupp.smul_apply, MvPolynomial.coeff_smul, smul_eq_mul,
    Finsupp.coe_zero, Pi.zero_apply, MvPolynomial.coeff_zero] at this
  exact sub_eq_zero.1 ((mul_eq_zero.1 this).resolve_right hd)

end MassShell

/-! ### The light-cone frame -/

section Frame

variable {D : ℕ} {R : Type*} [CommRing R]

/-- **A light-cone pair** `(b, b̃)`: two isotropic directions normalised by `b·b̃ = -1`.  The
sign is the one forced by the mostly-plus metric and by `b·k = 1` (see
`conjCoeff_eq_neg_dotVec`); the explicit witness is
`NoGhost/Witness.lean`'s `noghost_lightcone_frame_satisfiable`. -/
structure LightConeFrame (η b : Fin D → R) where
  /-- The conjugate light-like direction `b̃`. -/
  conj : Fin D → R
  /-- `b` is light-like. -/
  isotropic : dotVec η b b = 0
  /-- `b̃` is light-like. -/
  conj_isotropic : dotVec η conj conj = 0
  /-- The light-cone normalisation `b·b̃ = -1`. -/
  pairing : dotVec η b conj = -1

/-- **A transverse frame**: `D - 2` polarisations that are `η`-orthonormal and transverse to
the light-like direction `b` (blueprint §B.1).  Transversality has to be packed into the
structure because it is an argument of the *definition* of `ddfOp`. -/
structure TransverseFrame (η b : Fin D → R) where
  /-- The polarisation vectors. -/
  vec : Fin (D - 2) → (Fin D → R)
  /-- Each polarisation is transverse to `b`: `ε_i · k_0 = 0`. -/
  transverse : ∀ i, dotVec η (vec i) b = 0
  /-- The transverse Gram matrix is the identity. -/
  orthonormal : ∀ i j, dotVec η (vec i) (vec j) = if i = j then 1 else 0

/-- The longitudinal oscillator `α^b_m`; by `Longitudinal.lean` this is the Goddard–Thorn
operator `K_m`. -/
noncomputable abbrev transOp (η a b ε : Fin D → R) (m : ℤ) : Module.End R (TowerFock D R) :=
  towerModeVec η a b ε m

/-- The conjugate light-cone oscillator `α^b̃_m`. -/
noncomputable abbrev conjOp (η a b : Fin D → R) (B : LightConeFrame η b) (m : ℤ) :
    Module.End R (TowerFock D R) :=
  towerModeVec η a b B.conj m

/-- `[α^b̃_m, α^b̃_n] = 0`: the conjugate direction is light-like too. -/
theorem lie_conjOp_conjOp (η a b : Fin D → R) (B : LightConeFrame η b)
    (hη : ∀ μ, η μ * η μ = 1) (m n : ℤ) : ⁅conjOp η a b B m, conjOp η a b B n⁆ = 0 := by
  classical
  rw [conjOp, conjOp, lie_towerModeVec_towerModeVec η a b B.conj B.conj hη m n,
    B.conj_isotropic, mul_zero, ite_self, zero_smul]

/-- **`[K_m, α^b̃_n] = -m δ_{m+n,0}`** — the only non-vanishing bracket of the light-cone
pair.  The `-1` is `b·b̃`. -/
theorem lie_kOp_conjOp (η a b : Fin D → R) (B : LightConeFrame η b) (hη : ∀ μ, η μ * η μ = 1)
    (m n : ℤ) :
    ⁅kOp η a b m, conjOp η a b B n⁆
      = (if m + n = 0 then -(m : R) else 0)
          • (LinearMap.id : Module.End R (TowerFock D R)) := by
  classical
  rw [kOp, conjOp, lie_towerModeVec_towerModeVec η a b b B.conj hη m n, B.pairing]
  rcases eq_or_ne (m + n) 0 with h | h
  · rw [if_pos h, if_pos h, mul_neg, mul_one]
  · rw [if_neg h, if_neg h]

/-- `[α^{ε_i}_m, α^{ε_j}_n] = m δ_{ij} δ_{m+n,0}`: the transverse oscillators form `D - 2`
independent Heisenberg algebras with *positive* central term. -/
theorem lie_transOp_transOp (η a b : Fin D → R) (Ε : TransverseFrame η b)
    (hη : ∀ μ, η μ * η μ = 1) (i j : Fin (D - 2)) (m n : ℤ) :
    ⁅transOp η a b (Ε.vec i) m, transOp η a b (Ε.vec j) n⁆
      = (if m + n = 0 then (if i = j then (m : R) else 0) else 0)
          • (LinearMap.id : Module.End R (TowerFock D R)) := by
  classical
  rw [transOp, transOp, lie_towerModeVec_towerModeVec η a b (Ε.vec i) (Ε.vec j) hη m n,
    Ε.orthonormal i j]
  rcases eq_or_ne (m + n) 0 with h | h
  · rw [if_pos h, if_pos h]
    rcases eq_or_ne i j with rfl | hij
    · rw [if_pos rfl, if_pos rfl, mul_one]
    · rw [if_neg hij, if_neg hij, mul_zero]
  · rw [if_neg h, if_neg h]

/-- `[K_m, α^{ε_i}_n] = 0`: transversality `ε_i · k_0 = 0` kills the central term. -/
theorem lie_kOp_transOp (η a b : Fin D → R) (Ε : TransverseFrame η b)
    (hη : ∀ μ, η μ * η μ = 1) (i : Fin (D - 2)) (m n : ℤ) :
    ⁅kOp η a b m, transOp η a b (Ε.vec i) n⁆ = 0 := by
  classical
  rw [kOp, transOp, lie_towerModeVec_towerModeVec η a b b (Ε.vec i) hη m n,
    dotVec_comm η b (Ε.vec i), Ε.transverse i, mul_zero, ite_self, zero_smul]

/-- `[α^b̃_m, α^{ε_i}_n] = 0` **provided** the transverse polarisations are also orthogonal to
the conjugate direction.  That extra orthogonality is *not* part of `TransverseFrame` (which
only requires `ε·b = 0`), so it is a hypothesis here; the explicit witness of
`NoGhost/Witness.lean` satisfies it. -/
theorem lie_conjOp_transOp (η a b : Fin D → R) (B : LightConeFrame η b)
    (ε : Fin D → R) (hεconj : dotVec η B.conj ε = 0) (hη : ∀ μ, η μ * η μ = 1) (m n : ℤ) :
    ⁅conjOp η a b B m, transOp η a b ε n⁆ = 0 := by
  classical
  rw [conjOp, transOp, lie_towerModeVec_towerModeVec η a b B.conj ε hη m n, hεconj, mul_zero,
    ite_self, zero_smul]

end Frame

/-! ### The `b̃`-component and the leading terms of `L_{-n}` -/

section Leading

variable {D : ℕ} {R : Type*} [CommRing R]

lemma dotVec_smul_right (η x y : Fin D → R) (c : R) :
    dotVec η x (c • y) = c * dotVec η x y := by
  rw [dotVec, dotVec, Finset.mul_sum]
  exact Finset.sum_congr rfl fun μ _ => by
    simp only [Pi.smul_apply, smul_eq_mul]; ring

/-- **The `b̃`-component of a vector in a light-cone frame is `-(b·v)`.**

If `v = c • b + c' • b̃ + w` with `w` orthogonal to `b`, then `c' = -(b·v)`, because
`b·b = 0` and `b·b̃ = -1` leave only the `b̃` term.  Nothing is assumed about completeness of
the frame: this extracts the coefficient of a *given* decomposition, which is all the
leading-term argument of blueprint §B.4 needs. -/
theorem conjCoeff_eq_neg_dotVec (η b : Fin D → R) (B : LightConeFrame η b) (v w : Fin D → R)
    (c c' : R) (hw : dotVec η b w = 0) (hv : v = c • b + c' • B.conj + w) :
    c' = -dotVec η b v := by
  rw [hv, dotVec_add_right, dotVec_add_right, hw, add_zero, dotVec_smul_right,
    dotVec_smul_right, B.isotropic, B.pairing]
  ring

/-- **The `b̃`-component of the momentum is `-1`, on every rung of the tower.**

This is the coefficient that blueprint §B.4 says is "pinned by `hba` and `b·b̃ = -1`": the
single-oscillator (leading) term of `L_{-n}` on a rung vacuum is `α^{p_j}_{-n}`
(`towerLop_neg_one_apply_single_vacuum`, `towerLop_neg_two_apply_single_vacuum`), and the
`b̃`-component of the polarisation `p_j` is `-1` for every `j`, because `k_0² = 0` makes
`k_0·p_j = k_0·k` rung-independent and the DDF normalisation fixes that to `1`.

So `L_{-n} = -α^{b̃}_{-n} + (terms with ≥ 2 oscillators)` in the light-cone frame — the sign
is not a convention, it is forced. -/
theorem conjCoeff_towerMomentum (η a b : Fin D → R) (B : LightConeFrame η b)
    (hba : dotVec η b a = 1) (j : ℤ) (w : Fin D → R) (c c' : R) (hw : dotVec η b w = 0)
    (hv : towerMomentum a b j = c • b + c' • B.conj + w) : c' = -1 := by
  rw [conjCoeff_eq_neg_dotVec η b B (towerMomentum a b j) w c c' hw hv,
    dotVec_towerMomentum_right_of_isotropic η a b B.isotropic j, hba]

variable [Algebra ℚ R]

/-- **`L_{-1}|0; p_j⟩ = α^{p_j}_{-1}|0; p_j⟩`** on every rung of the tower: at level one the
Sugawara sum has only the single-oscillator term, and its polarisation is the rung's own
momentum.  Combined with `conjCoeff_towerMomentum` this is the `n = 1` case of the third
leading-term lemma of blueprint §B.4. -/
theorem towerLop_neg_one_apply_single_vacuum (η a b : Fin D → R) (j : ℤ) :
    towerLop η a b (-1) (Finsupp.single j (Fock.vacuum D R))
      = towerModeVec η a b (towerMomentum a b j) (-1)
          (Finsupp.single j (Fock.vacuum D R)) := by
  have hR : towerModeVec η a b (towerMomentum a b j) (-1)
        (Finsupp.single j (Fock.vacuum D R))
      = Finsupp.single j (∑ μ : Fin D, (η μ * towerMomentum a b j μ) •
          Fock.mode η (towerMomentum a b j) μ (-1) (1 : Fock D R)) := by
    rw [towerModeVec, LinearMap.sum_apply, Finsupp.single_finsetSum]
    exact Finset.sum_congr rfl fun μ _ => by
      rw [LinearMap.smul_apply, towerMode_single, Finsupp.smul_single, Fock.vacuum_def]
  rw [hR, towerLop_single, Fock.vacuum_def, Fock.Lop_neg_one_apply_one]

/-- **`L_{-2}|0; p_j⟩ = α^{p_j}_{-2}|0; p_j⟩ + ½ Σ_μ η_μ α^μ_{-1} α^μ_{-1}|0; p_j⟩`**: the
leading single-oscillator term plus an explicit two-oscillator remainder.  This is the
`n = 2` case of the third leading-term lemma of blueprint §B.4, and the input to the `N = 2`
increment of §B.6. -/
theorem towerLop_neg_two_apply_single_vacuum (η a b : Fin D → R) (j : ℤ) :
    towerLop η a b (-2) (Finsupp.single j (Fock.vacuum D R))
      = towerModeVec η a b (towerMomentum a b j) (-2)
            (Finsupp.single j (Fock.vacuum D R))
        + invTwo R • ∑ μ : Fin D, η μ • towerMode η a b μ (-1)
            (towerMode η a b μ (-1) (Finsupp.single j (Fock.vacuum D R))) := by
  have hR1 : towerModeVec η a b (towerMomentum a b j) (-2)
        (Finsupp.single j (Fock.vacuum D R))
      = Finsupp.single j (∑ μ : Fin D, (η μ * towerMomentum a b j μ) •
          Fock.mode η (towerMomentum a b j) μ (-2) (1 : Fock D R)) := by
    rw [towerModeVec, LinearMap.sum_apply, Finsupp.single_finsetSum]
    exact Finset.sum_congr rfl fun μ _ => by
      rw [LinearMap.smul_apply, towerMode_single, Finsupp.smul_single, Fock.vacuum_def]
  have hR2 : (∑ μ : Fin D, η μ • towerMode η a b μ (-1)
        (towerMode η a b μ (-1) (Finsupp.single j (Fock.vacuum D R))))
      = Finsupp.single j (∑ μ : Fin D, η μ • Fock.mode η (towerMomentum a b j) μ (-1)
          (Fock.mode η (towerMomentum a b j) μ (-1) (1 : Fock D R))) := by
    rw [Finsupp.single_finsetSum]
    exact Finset.sum_congr rfl fun μ _ => by
      rw [Fock.vacuum_def, towerMode_single, towerMode_single, Finsupp.smul_single]
  rw [hR1, hR2, towerLop_single, Fock.vacuum_def, Fock.Lop_neg_two_apply_one,
    Finsupp.smul_single, ← Finsupp.single_add]

end Leading


/-! ### The DDF span and the leading term of `A^ε_{-1}` -/

section DDFSpan

variable {D : ℕ} {R : Type*} [CommRing R]

/-- `v · p_j = v·a + j (v·b)` for an arbitrary polarisation `v` (the `v = b` case is
`dotVec_towerMomentum_right`). -/
lemma dotVec_vec_towerMomentum (η a b v : Fin D → R) (j : ℤ) :
    dotVec η v (towerMomentum a b j) = dotVec η v a + (j : R) * dotVec η v b := by
  rw [dotVec, dotVec, dotVec, Finset.mul_sum, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun μ _ => ?_
  simp only [towerMomentum_apply]
  ring

/-- The zero mode `α^ε_0` acts on rung `j` by the scalar `ε · p_j`. -/
lemma towerModeVec_zero_apply_single (η a b ε : Fin D → R) (j : ℤ) (P : Fock D R) :
    towerModeVec η a b ε 0 (Finsupp.single j P)
      = dotVec η ε (towerMomentum a b j) • Finsupp.single j P := by
  rw [towerModeVec, LinearMap.sum_apply, dotVec, Finset.sum_smul]
  refine Finset.sum_congr rfl fun μ _ => ?_
  simp only [LinearMap.smul_apply, towerMode_single, Fock.mode_zero_apply, Finsupp.smul_single,
    smul_smul, mul_assoc]

/-- A positive polarised mode annihilates every rung vacuum. -/
lemma towerModeVec_apply_single_vacuum_of_pos (η a b ε : Fin D → R) {j : ℤ} (hj : 0 < j)
    (i : ℤ) : towerModeVec η a b ε j (Finsupp.single i (Fock.vacuum D R)) = 0 := by
  rw [towerModeVec, LinearMap.sum_apply]
  refine Finset.sum_eq_zero fun μ _ => ?_
  rw [LinearMap.smul_apply, towerMode_single, Fock.vacuum_def,
    Fock.mode_apply_one_eq_zero η (towerMomentum a b i) hj μ, Finsupp.single_zero, smul_zero]

variable [Algebra ℚ R]

/-- On a rung vacuum the vertex operator reduces to the creation exponential. -/
lemma towerVertex_apply_single_vacuum (η b : Fin D → R) (n K j : ℤ) :
    towerVertex η b n K (Finsupp.single j (Fock.vacuum D R))
      = Finsupp.single (j + n) (Fock.creaExp η (vertexMomentum b n) (K - n)) := by
  rw [towerVertex_single, Fock.vacuum_def, Fock.vertexOsc_apply_one]

/-- Below the window the vertex operator alone kills a rung vacuum. -/
lemma ddfSummand_apply_single_vacuum_eq_zero_of_lt (η a b ε : Fin D → R) (n j i : ℤ)
    (hj : j < n) : ddfSummand η a b ε n j (Finsupp.single i (Fock.vacuum D R)) = 0 := by
  rw [ddfSummand, Module.End.mul_apply, towerVertex_apply_single_vacuum,
    Fock.creaExp_of_neg _ _ (show j - n < 0 by omega), Finsupp.single_zero, map_zero]

/-- Above the window transversality moves `α^ε_j` to the right, where it annihilates a rung
vacuum. -/
lemma ddfSummand_apply_single_vacuum_eq_zero_of_pos (η a b ε : Fin D → R)
    (hη : ∀ μ, η μ * η μ = 1) (hεb : dotVec η ε b = 0) (n j i : ℤ) (hj : 0 < j) :
    ddfSummand η a b ε n j (Finsupp.single i (Fock.vacuum D R)) = 0 := by
  rw [ddfSummand, towerModeVec_mul_towerVertex_of_transverse η a b ε hη hεb n j j,
    Module.End.mul_apply, towerModeVec_apply_single_vacuum_of_pos η a b ε hj i, map_zero]

/-- **The leading term of `A^ε_{-1}` on the ground state**
(blueprint §B.4, second leading-term lemma, at `n = 1`):

`A^ε_{-1}|0; k⟩ = α^ε_{-1}|0; k - k_0⟩`, *exactly* — there is no correction term.

The DDF sum on the ground state has only two terms in its window, `j = -1` and `j = 0`; the
`j = 0` term is the scalar `ε·p_{-1}` times a level-one state, and it vanishes **only because
of the extra hypothesis `hεa : ε·k = 0`**.  Transversality `ε·k_0 = 0` alone does *not*
suffice: without `ε·k = 0` the DDF operator produces the additional state
`(ε·k) Φ_1 |0; k - k_0⟩`.  This is a genuine extra condition on the light-cone frame — the
witness of `NoGhost/Witness.lean` satisfies it (`ε_i = e_i` with `i ≥ 2` while `k` lies in
the `0`–`1` plane), but the DDF island's four standing hypotheses do not imply it. -/
theorem ddfOp_neg_one_apply_towerVacuum (η a b ε : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hεb : dotVec η ε b = 0) (hεa : dotVec η ε a = 0) :
    ddfOp η a b ε hη hεb (-1) (towerVacuum D R)
      = towerModeVec η a b ε (-1) (Finsupp.single (-1) (Fock.vacuum D R)) := by
  classical
  have hs : ∀ j ∉ ({-1, 0} : Finset ℤ), ddfSummand η a b ε (-1) j (towerVacuum D R) = 0 := by
    intro j hj
    simp only [Finset.mem_insert, Finset.mem_singleton, not_or] at hj
    obtain ⟨h1, h2⟩ := hj
    rcases lt_or_ge j 0 with h | h
    · exact ddfSummand_apply_single_vacuum_eq_zero_of_lt η a b ε (-1) j 0 (by omega)
    · exact ddfSummand_apply_single_vacuum_eq_zero_of_pos η a b ε hη hεb (-1) j 0 (by omega)
  have hone : ddfSummand η a b ε (-1) (-1) (towerVacuum D R)
      = towerModeVec η a b ε (-1) (Finsupp.single (-1) (Fock.vacuum D R)) := by
    rw [ddfSummand, Module.End.mul_apply, towerVacuum, towerVertex_apply_single_vacuum,
      show (0 : ℤ) + -1 = -1 by ring, show (-1 : ℤ) - -1 = 0 by ring, Fock.creaExp_zero]
    rfl
  have hzero : ddfSummand η a b ε (-1) 0 (towerVacuum D R) = 0 := by
    rw [ddfSummand, Module.End.mul_apply, towerVacuum, towerVertex_apply_single_vacuum,
      towerModeVec_zero_apply_single, dotVec_vec_towerMomentum, hεa, hεb, mul_zero, add_zero,
      zero_smul]
  rw [ddfOp_apply η a b ε hη hεb (-1) (towerVacuum D R) hs,
    Finset.sum_pair (show (-1 : ℤ) ≠ 0 by decide), hone, hzero, add_zero]

/-- **The submodule spanned by the DDF states**
`A^{ε_{i_1}}_{-n_1} ⋯ A^{ε_{i_r}}_{-n_r}|0; k⟩` (blueprint §B.1).  Transversality is an
argument of the *definition* of `ddfOp`, which is why `TransverseFrame` has to carry it. -/
noncomputable def ddfSpan (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (Ε : TransverseFrame η b) : Submodule R (TowerFock D R) :=
  Submodule.span R
    {x | ∃ l : List (Fin (D - 2) × ℕ+),
          x = l.foldr (fun q y => ddfOp η a b (Ε.vec q.1) hη (Ε.transverse q.1)
                                   (-((q.2 : ℕ) : ℤ)) y) (towerVacuum D R)}

lemma mem_ddfSpan_of_list (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (Ε : TransverseFrame η b) (l : List (Fin (D - 2) × ℕ+)) :
    l.foldr (fun q y => ddfOp η a b (Ε.vec q.1) hη (Ε.transverse q.1)
      (-((q.2 : ℕ) : ℤ)) y) (towerVacuum D R) ∈ ddfSpan η a b hη Ε :=
  Submodule.subset_span ⟨l, rfl⟩

/-- **The DDF states are physical** (the easy inclusion of blueprint §B.0): induction on DDF
monomials, using `ddfOp_mem_towerPhysSubmodule` and the fact that the ground state is
physical.  The intercept is the ground-state one, `a₀ = α' k²`. -/
theorem ddfSpan_le_towerPhysSubmodule (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1) (Ε : TransverseFrame η b) :
    ddfSpan η a b hη Ε ≤ towerPhysSubmodule η a b (invTwo R * Fock.zeroModeSq η a) := by
  refine Submodule.span_le.2 ?_
  rintro x ⟨l, rfl⟩
  induction l with
  | nil => exact towerVacuum_mem_towerPhysSubmodule η a b hη hbb hba
  | cons q l ih =>
      exact ddfOp_mem_towerPhysSubmodule η a b (Ε.vec q.1) hη hbb hba (Ε.transverse q.1) _ ih

/-- **The DDF states satisfy the Goddard–Thorn `K`-conditions** `K_n Ψ = 0` (`n > 0`), by
`⁅K_m, A^ε_n⁆ = 0` and `K_n|0;k⟩ = 0`.  Together with the previous theorem this gives
`ddfSpan ≤ ddfCharacterization`; the converse is the spanning lemma and is **not** proved. -/
theorem ddfSpan_le_towerKerK (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (Ε : TransverseFrame η b) :
    ddfSpan η a b hη Ε ≤ towerKerK η a b := by
  refine Submodule.span_le.2 ?_
  rintro x ⟨l, rfl⟩
  induction l with
  | nil => exact single_vacuum_mem_towerKerK η a b 0
  | cons q l ih =>
      exact ddfOp_mem_towerKerK η a b (Ε.vec q.1) hη hbb (Ε.transverse q.1) _ ih

/-- `ddfSpan ≤ ddfCharacterization` (Goddard 2008 (6.2), the inclusion that *is* provable
without the spanning lemma). -/
theorem ddfSpan_le_ddfCharacterization (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1) (Ε : TransverseFrame η b) :
    ddfSpan η a b hη Ε ≤ ddfCharacterization η a b (invTwo R * Fock.zeroModeSq η a) :=
  le_inf (ddfSpan_le_towerPhysSubmodule η a b hη hbb hba Ε)
    (ddfSpan_le_towerKerK η a b hη hbb Ε)

end DDFSpan


/-! ### The `N ≤ 1` increment of the spanning lemma (blueprint §B.6) -/

section LevelOneSpan

open MvPolynomial

variable {D : ℕ} {R : Type*} [CommRing R]

namespace Fock

@[simp]
lemma polState_zero (η : Fin D → R) : polState η (0 : Fin D → R) = 0 := by
  rw [polState]
  exact Finset.sum_eq_zero fun μ _ => by
    simp only [Pi.zero_apply, mul_zero, zero_smul]

lemma polState_add (η e f : Fin D → R) :
    polState η (e + f) = polState η e + polState η f := by
  rw [polState, polState, polState, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [← add_smul]
  congr 1
  simp only [Pi.add_apply]
  ring

lemma polState_smul (η : Fin D → R) (c : R) (e : Fin D → R) :
    polState η (c • e) = c • polState η e := by
  rw [polState, polState, Finset.smul_sum]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [smul_smul]
  congr 1
  simp only [Pi.smul_apply, smul_eq_mul]
  ring

lemma polState_sum {ι : Type*} (η : Fin D → R) (s : Finset ι) (f : ι → Fin D → R) :
    polState η (∑ i ∈ s, f i) = ∑ i ∈ s, polState η (f i) := by
  classical
  rw [polState]
  have h : ∀ μ : Fin D, (η μ * (∑ i ∈ s, f i) μ) • (X ((μ, 1) : Osc D) : Fock D R)
      = ∑ i ∈ s, (η μ * f i μ) • (X ((μ, 1) : Osc D) : Fock D R) := fun μ => by
    rw [Finset.sum_apply, Finset.mul_sum, Finset.sum_smul]
  rw [Finset.sum_congr rfl fun μ _ => h μ, Finset.sum_comm]
  exact Finset.sum_congr rfl fun i _ => rfl

end Fock

/-- `α^ε_{-1}` applied to a rung vacuum is the level-one state with polarisation `ε`. -/
lemma towerModeVec_neg_one_apply_single_vacuum (η a b ε : Fin D → R) (j : ℤ) :
    towerModeVec η a b ε (-1) (Finsupp.single j (Fock.vacuum D R))
      = Finsupp.single j (Fock.polState η ε) := by
  rw [towerModeVec, LinearMap.sum_apply,
    Fock.polState_eq_sum_mode η (towerMomentum a b j) ε, Finsupp.single_finsetSum]
  exact Finset.sum_congr rfl fun μ _ => by
    rw [LinearMap.smul_apply, towerMode_single, Finsupp.smul_single, Fock.vacuum_def]

lemma single_inj_iff (j : ℤ) (P Q : Fock D R) :
    (Finsupp.single j P : TowerFock D R) = Finsupp.single j Q ↔ P = Q := by
  constructor
  · intro h
    have := congrArg (fun x : TowerFock D R => x j) h
    simpa only [Finsupp.single_eq_same] using this
  · rintro rfl; rfl

variable [Algebra ℚ R]

/-- A rung vector is physical on the tower iff its component is physical for that rung's
momentum.  (`towerLop` acts rung by rung, so this is purely bookkeeping.) -/
lemma single_mem_towerPhysSubmodule_iff (η a b : Fin D → R) (a₀ : R) (j : ℤ) (P : Fock D R) :
    (Finsupp.single j P : TowerFock D R) ∈ towerPhysSubmodule η a b a₀ ↔
      P ∈ Fock.physSubmodule η (towerMomentum a b j) a₀ := by
  rw [mem_towerPhysSubmodule, Fock.mem_physSubmodule]
  constructor
  · rintro ⟨h0, hpos⟩
    refine ⟨?_, fun m hm => ?_⟩
    · rw [towerLop_single, Finsupp.smul_single, single_inj_iff] at h0
      exact h0
    · have := hpos m hm
      rw [towerLop_single, ← Finsupp.single_zero (a := j)] at this
      exact (single_inj_iff j _ _).1 this
  · rintro ⟨h0, hpos⟩
    refine ⟨?_, fun m hm => ?_⟩
    · rw [towerLop_single, h0, Finsupp.smul_single]
    · rw [towerLop_single, hpos m hm, Finsupp.single_zero]

/-- **`L_{-1}` on the rung-`(-1)` vacuum is the spurious level-one state with longitudinal
polarisation `p_{-1}`.** -/
lemma towerLop_neg_one_apply_single_vacuum_eq (η a b : Fin D → R) (j : ℤ) :
    towerLop η a b (-1) (Finsupp.single j (Fock.vacuum D R))
      = Finsupp.single j (Fock.polState η (towerMomentum a b j)) := by
  rw [towerLop_single, Fock.vacuum_def, Fock.Lop_neg_one_apply_one_eq_polState]

/-- **Completeness of the light-cone frame on `v^⊥`**: every polarisation orthogonal to `v`
is a combination of the transverse frame vectors and `v` itself.

This is a *hypothesis*, not a theorem: `TransverseFrame` only records orthonormality and
transversality, and those do not imply that the `D - 2` vectors together with `v` span
`v^⊥`.  For the explicit light-cone witness of `NoGhost/Witness.lean` it does hold, but the
statement below is kept conditional so that the spanning theorem is honest about what it
uses. -/
def FrameSpansOrthogonal (η : Fin D → R) {b : Fin D → R} (Ε : TransverseFrame η b)
    (v : Fin D → R) : Prop :=
  ∀ e : Fin D → R, dotVec η e v = 0 →
    ∃ (c : Fin (D - 2) → R) (c₀ : R), e = (∑ i, c i • Ε.vec i) + c₀ • v

lemma ddfOp_towerVacuum_mem_ddfSpan (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (Ε : TransverseFrame η b) (i : Fin (D - 2)) (n : ℕ+) :
    ddfOp η a b (Ε.vec i) hη (Ε.transverse i) (-((n : ℕ) : ℤ)) (towerVacuum D R)
      ∈ ddfSpan η a b hη Ε := by
  have h := mem_ddfSpan_of_list η a b hη Ε [(i, n)]
  simp only [List.foldr_cons, List.foldr_nil] at h
  exact h

/-- **The level-one DDF states are exactly `α^{ε_i}_{-1}|0; k - k_0⟩`.** -/
theorem single_polState_vec_mem_ddfSpan (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (Ε : TransverseFrame η b) (hεa : ∀ i, dotVec η (Ε.vec i) a = 0) (i : Fin (D - 2)) :
    (Finsupp.single (-1) (Fock.polState η (Ε.vec i)) : TowerFock D R)
      ∈ ddfSpan η a b hη Ε := by
  have h := ddfOp_towerVacuum_mem_ddfSpan η a b hη Ε i 1
  rw [show (-(((1 : ℕ+) : ℕ) : ℤ)) = -1 by norm_num,
    ddfOp_neg_one_apply_towerVacuum η a b (Ε.vec i) hη (Ε.transverse i) (hεa i),
    towerModeVec_neg_one_apply_single_vacuum] at h
  exact h

/-- **Blueprint §B.6, the `N = 1` increment of the spanning lemma `ddf-spans`.**

At oscillator level `1` on rung `-1` — the first nontrivial slice of the tower, and the one
carrying the photon — every physical state is a DDF state plus a spurious state:

`H_phys ∩ (rung -1, level 1) ≤ span{A^{ε_i}_{-1}|0;k⟩} + span{L_{-1}|0; k - k_0⟩}`.

The intercept is the ground-state one `a₀ = α' k²`; with the tachyonic normalisation
`α' k² = 1` of `NoGhost/Witness.lean` this is `a₀ = 1`, and then `L_{-1}|0; k-k_0⟩` is the
familiar *null* photon state (`Fock.Lop_neg_one_apply_one_mem_nullSubmodule`), so the
right-hand side is "DDF span ⊕ null states" as in Goddard (6.4).

Two hypotheses beyond the four standing DDF ones are needed, and both are genuine:

* `hεa` — the transverse polarisations are orthogonal to the momentum `k`, without which
  `A^ε_{-1}|0;k⟩ ≠ α^ε_{-1}|0;k-k_0⟩` (see `ddfOp_neg_one_apply_towerVacuum`);
* `hspan` — the frame is *complete* on `p_{-1}^⊥`, which `TransverseFrame` does not record.

The `D = 26` condition does **not** appear: at level `1` the counting `(D-1) = (D-2) + 1`
works for every `D`, exactly as blueprint §B.5 predicts.  Neither do `hbb`/`hba`: the
mass-shell bookkeeping they control is already contained in the hypothesis "`x` is
physical", so the inclusion holds for the tower built on *any* `(a, b)`. -/
theorem towerPhys_bigrade_one_le_ddfSpan_sup_spurious (η a b : Fin D → R)
    (hη : ∀ μ, η μ * η μ = 1)
    (Ε : TransverseFrame η b) (hεa : ∀ i, dotVec η (Ε.vec i) a = 0)
    (hspan : FrameSpansOrthogonal η Ε (towerMomentum a b (-1))) :
    towerPhysSubmodule η a b (invTwo R * Fock.zeroModeSq η a) ⊓ towerBigrade D R (-1) 1
      ≤ ddfSpan η a b hη Ε ⊔
          Submodule.span R
            {towerLop η a b (-1) (Finsupp.single (-1) (Fock.vacuum D R))} := by
  classical
  rintro x hx
  obtain ⟨hphys, hbig⟩ := Submodule.mem_inf.1 hx
  obtain ⟨hx1, hx2⟩ := mem_towerBigrade.1 hbig
  set P : Fock D R := x (-1) with hP
  rw [hx1] at hphys
  rw [(single_mem_towerPhysSubmodule_iff η a b _ (-1) P)] at hphys
  obtain ⟨e, hPe, -, htrans⟩ :=
    (Fock.mem_physSubmodule_inf_levelSubmodule_one_iff η (towerMomentum a b (-1)) hη
      (invTwo R * Fock.zeroModeSq η a)).1 (Submodule.mem_inf.2 ⟨hphys, hx2⟩)
  obtain ⟨c, c₀, hc⟩ := hspan e htrans
  have hpol : Fock.polState η e
      = (∑ i : Fin (D - 2), c i • Fock.polState η (Ε.vec i))
        + c₀ • Fock.polState η (towerMomentum a b (-1)) := by
    rw [hc, Fock.polState_add, Fock.polState_smul, Fock.polState_sum]
    exact congrArg (· + c₀ • Fock.polState η (towerMomentum a b (-1)))
      (Finset.sum_congr rfl fun i _ => Fock.polState_smul η (c i) (Ε.vec i))
  rw [hx1, hPe, hpol, Finsupp.single_add, Finsupp.single_finsetSum]
  refine Submodule.add_mem _ (Submodule.sum_mem _ fun i _ => ?_) ?_
  · rw [← Finsupp.smul_single]
    exact Submodule.mem_sup_left
      (Submodule.smul_mem _ _ (single_polState_vec_mem_ddfSpan η a b hη Ε hεa i))
  · rw [← Finsupp.smul_single]
    refine Submodule.mem_sup_right (Submodule.smul_mem _ _ ?_)
    rw [← towerLop_neg_one_apply_single_vacuum_eq η a b (-1)]
    exact Submodule.subset_span rfl

end LevelOneSpan


/-! ### The explicit light-cone witness satisfies the two frame structures

Without these the frame-based results above could be vacuous: nothing in `LightConeFrame` or
`TransverseFrame` is obviously satisfiable, and `TransverseFrame` in particular demands
`D - 2` mutually orthonormal vectors. -/

section FrameWitness

variable (D : ℕ) (R : Type*) [CommRing R]

/-- The `i`-th transverse index, `μ = i + 2`. -/
def transIdx (hD : 3 ≤ D) (i : Fin (D - 2)) : Fin D := ⟨(i : ℕ) + 2, by omega⟩

variable {D}

lemma transIdx_injective (hD : 3 ≤ D) : Function.Injective (transIdx D hD) := by
  intro i j h
  have hv := congrArg Fin.val h
  simp only [transIdx] at hv
  exact Fin.ext (by omega)

lemma two_le_transIdx (hD : 3 ≤ D) (i : Fin (D - 2)) :
    2 ≤ ((transIdx D hD i : Fin D) : ℕ) := by
  simp [transIdx]

variable (D)

/-- **The light-cone pair of `NoGhost/Witness.lean` is a `LightConeFrame`.** -/
noncomputable def witnessLightConeFrame [Algebra ℚ R] (hD : 3 ≤ D) :
    LightConeFrame (Fock.minkowski D R) (witnessLight D R hD) where
  conj := witnessConjugate D R hD
  isotropic := dotVec_witnessLight_self hD
  conj_isotropic := dotVec_witnessConjugate_self hD
  pairing := dotVec_witnessLight_witnessConjugate hD

/-- **The `D - 2` polarisations `e_2, …, e_{D-1}` form a `TransverseFrame`.**  In particular
`ddfSpan` and all the frame-conditional results above are non-vacuous. -/
noncomputable def witnessTransverseFrame (hD : 3 ≤ D) :
    TransverseFrame (Fock.minkowski D R) (witnessLight D R hD) where
  vec i := witnessPolarization D R (transIdx D hD i)
  transverse i := dotVec_witnessPolarization_witnessLight hD (two_le_transIdx hD i)
  orthonormal i j := by
    classical
    rw [dotVec_witnessPolarization_witnessPolarization (two_le_transIdx hD i)]
    by_cases h : i = j
    · subst h; rw [if_pos rfl, if_pos rfl]
    · rw [if_neg h, if_neg fun hc => h (transIdx_injective hD hc)]

variable {D R}

/-- **The witness polarisations are orthogonal to the momentum too**: `ε_i · k = 0`.  This
discharges the extra hypothesis `hεa` of `ddfOp_neg_one_apply_towerVacuum` and of the `N = 1`
spanning theorem for the explicit frame. -/
theorem dotVec_witnessPolarization_witnessMomentum [Algebra ℚ R] (hD : 3 ≤ D)
    {i : Fin D} (hi : 2 ≤ (i : ℕ)) :
    dotVec (Fock.minkowski D R) (witnessPolarization D R i) (witnessMomentum D R hD) = 0 := by
  rw [witnessPolarization, witnessMomentum]
  refine dotVec_single_pair_of_ne _ ?_ ?_ _ _ _
  · simp only [ne_eq, Fin.ext_iff, frameTime]; omega
  · simp only [ne_eq, Fin.ext_iff, frameSpace]; omega

/-- The `hεa` hypothesis, for the witness transverse frame. -/
theorem dotVec_witnessTransverseFrame_witnessMomentum [Algebra ℚ R] (hD : 3 ≤ D)
    (i : Fin (D - 2)) :
    dotVec (Fock.minkowski D R) ((witnessTransverseFrame D R hD).vec i)
      (witnessMomentum D R hD) = 0 :=
  dotVec_witnessPolarization_witnessMomentum hD (two_le_transIdx hD i)

end FrameWitness

end StringFormal.NoGhost
