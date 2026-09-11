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

## Scope and gaps

* The leading-term expansion of `L_{-n}` is proved only for `n = 1, 2`, because
  `Fock.Lop_neg_one_apply_one` and `Fock.Lop_neg_two_apply_one` are the only rung-vacuum
  formulas available; a general `n` needs the Sugawara sum on the vacuum for arbitrary `n`,
  which is not formalised.  `n ≤ 2` is exactly what the `N ≤ 2` increment of blueprint §B.6
  uses.
* `conjCoeff_eq_neg_dotVec` does **not** assume that `{b, b̃, ε_i}` is a basis: it extracts
  the `b̃`-coefficient of a *given* decomposition.  Completeness of the light-cone frame
  (every vector decomposes) is a further statement, not needed here and not proved.
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

end StringFormal.NoGhost
