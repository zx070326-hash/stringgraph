/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import Mathlib.Tactic.Module
import StringFormal.NoGhost.VertexWeight
import StringFormal.NoGhost.PhysicalStates

/-!
# The transverse DDF operators `A^i_n`

Graph nodes: `worldsheet.ddf-operators-v5` (the definition),
`worldsheet.ddf-transversality-gives-local-finiteness` (the sum is finite on each state),
`worldsheet.ddf-commute-with-virasoro` (the `m ≥ 1` half).
`formal/TODO.md` item `ddf-operators`.

## Conventions

`conv.metric-signature-mostly-plus` via the diagonal signature `η : Fin D → R` with
`η μ * η μ = 1`; `conv.alpha-prime-regge` via `a^μ = α^μ_0 = (2α')^{1/2} k^μ` and
`b^μ = (2α')^{1/2} k_0^μ`.  The DDF normalisations are hypotheses, not part of the
definitions: `k_0² = 0` is `dotVec η b b = 0`, `2α' k_0 · p = 1` is `dotVec η b a = 1`,
and transversality `ε · k_0 = 0` is `dotVec η ε b = 0`.

## What is here

* `Fock.levelBound`, `towerLevelBound`, `towerModeBound` — crude bounds on a state: no
  monomial has level above `levelBound`, no oscillator index above `modeBound`.  These make
  the two-sided cut-off of the DDF sum explicit.
* `towerModeVec η a b ε p` — the polarised mode `α^ε_p = Σ_μ η_μ ε^μ α^μ_p`.
* `ddfSummand η a b ε n j = α^ε_j ∘ V^{(n)}_j` and the shifted family
  `ddfShifted η a b ε n m i = α^ε_{m+i} ∘ V^{(n)}_i` used in the telescoping.
* `ddfWindow n x` — the finite window `n - levelBound x ≤ j ≤ modeBound x` outside which the
  `j`-th summand kills `x`.
* **`ddfSummand_apply_eq_zero_of_notMem_window`** — local finiteness.  This is
  `worldsheet.ddf-transversality-gives-local-finiteness`: below the window the *vertex*
  operator kills the state (it cannot lower the oscillator level below the vacuum), above the
  window *transversality* lets one move `α^ε_j` to the right, where it is an annihilator of
  index larger than the state's mode bound.  Without `ε · k_0 = 0` the upper cut-off fails.
* `ddfOp η a b ε hη hεb n` — the DDF operator `A^ε_n = Σ_{j ∈ ℤ} α^ε_j V^{(n)}_j`, assembled
  with `lsumLocFin`; `ddfOp_apply` computes it on any sufficiently large finite window.
* **`lie_towerLop_ddfOp_of_pos`** — `⁅L_m, A^ε_n⁆ = 0` for `m ≥ 1`, given `k_0² = 0`,
  `2α' k_0 · p = 1`, `ε · k_0 = 0`.

## What is NOT here (gaps for the dependency graph)

1. **`m ≤ -1` and `m = 0`.**  `StringFormal/NoGhost/VertexWeight.lean` only proves the
   conformal-weight identity `⁅L_m, V^{(n)}_K⁆ = (K - m) V^{(n)}_{K-m}` for `m ≥ 1`
   (`Fock.lie_Lop_vertexOsc_of_pos` assumes `0 < m`).  So `ddf-commute-with-virasoro` is only
   half formalised here.  Note that the `m ≥ 1` half is exactly what the no-ghost argument
   needs for the *Virasoro primary* conditions `L_m ψ = 0`, `m ≥ 1`; the `L_0` condition needs
   `m = 0` and is genuinely missing.
2. **`[A^i_m, A^j_n] = m δ^{ij} δ_{m+n,0}`** — the transverse oscillator algebra
   (`worldsheet.ddf-transverse-oscillator-algebra`) is not formalised.
3. **`A^ε_n` preserves the physical subspace.**  This needs (1), and moreover
   `physSubmodule` in `StringFormal/NoGhost/PhysicalStates.lean` lives on a single Fock space,
   not on the tower, so even stating it needs a tower-level `physSubmodule` first.
4. **Spectrum-generating property** (the DDF states span the transverse physical spectrum)
   is not formalised; nothing here says `A^ε_n ≠ 0`.
-/

namespace StringFormal.NoGhost

open MvPolynomial

/-! ### The commutator bracket of endomorphisms -/

section EndBracket

variable {R : Type*} [CommRing R] {M : Type*} [AddCommGroup M] [Module R M]

/-- Leibniz rule for the commutator bracket of endomorphisms:
`⁅a, b * c⁆ = ⁅a, b⁆ * c + b * ⁅a, c⁆`. -/
lemma lie_mul_end (a b c : Module.End R M) : ⁅a, b * c⁆ = ⁅a, b⁆ * c + b * ⁅a, c⁆ := by
  simp only [LieRing.of_associative_ring_bracket]
  noncomm_ring

lemma lie_smul_end (c : R) (a b : Module.End R M) : ⁅a, c • b⁆ = c • ⁅a, b⁆ := by
  simp only [LieRing.of_associative_ring_bracket, mul_smul_comm, smul_mul_assoc, smul_sub]

lemma smul_lie_end (c : R) (a b : Module.End R M) : ⁅c • a, b⁆ = c • ⁅a, b⁆ := by
  simp only [LieRing.of_associative_ring_bracket, mul_smul_comm, smul_mul_assoc, smul_sub]

lemma lie_sum_end {ι : Type*} (x : Module.End R M) (s : Finset ι) (f : ι → Module.End R M) :
    ⁅x, ∑ i ∈ s, f i⁆ = ∑ i ∈ s, ⁅x, f i⁆ := by
  simp only [LieRing.of_associative_ring_bracket, Finset.sum_sub_distrib, Finset.mul_sum,
    Finset.sum_mul]

lemma sum_lie_end {ι : Type*} (x : Module.End R M) (s : Finset ι) (f : ι → Module.End R M) :
    ⁅∑ i ∈ s, f i, x⁆ = ∑ i ∈ s, ⁅f i, x⁆ := by
  simp only [LieRing.of_associative_ring_bracket, Finset.sum_sub_distrib, Finset.mul_sum,
    Finset.sum_mul]

end EndBracket

namespace Fock

variable {D : ℕ} {R : Type*} [CommRing R]

/-- A crude upper bound on the oscillator level of a Fock vector: no monomial of `P` has
level above `levelBound P`.  Together with `Fock.modeBound` this gives the two-sided cut-off
of the DDF sum. -/
noncomputable def levelBound (P : Fock D R) : ℕ := P.support.sup (level D)

lemma level_le_levelBound {P : Fock D R} {d : Osc D →₀ ℕ} (hd : d ∈ P.support) :
    level D d ≤ levelBound P :=
  Finset.le_sup hd

/-- **The vertex operator kills any state once its Laurent index is below minus the level
bound**: `V_K` raises the level by `K`, and the level cannot go below the vacuum. -/
theorem vertexOsc_apply_eq_zero_of_levelBound_lt [Algebra ℚ R] (η c : Fin D → R)
    {P : Fock D R} {K : ℤ} (hK : (levelBound P : ℤ) + K < 0) : vertexOsc η c K P = 0 := by
  classical
  conv_lhs => rw [P.as_sum]
  rw [map_sum]
  refine Finset.sum_eq_zero fun d hd => ?_
  have hle : (level D d : ℤ) ≤ (levelBound P : ℤ) := by
    exact_mod_cast level_le_levelBound hd
  exact vertexOsc_apply_eq_zero_of_level η c (monomial_mem_levelSubmodule d (coeff d P))
    (by omega)

end Fock

/-! ### Bounds on the momentum tower -/

section TowerBounds

variable {D : ℕ} {R : Type*} [CommRing R]

/-- The level bound of a tower vector: the largest `Fock.levelBound` over the occupied
rungs. -/
noncomputable def towerLevelBound (x : TowerFock D R) : ℕ :=
  x.support.sup fun j => Fock.levelBound (x j)

/-- The mode bound of a tower vector: the largest `Fock.modeBound` over the occupied
rungs. -/
noncomputable def towerModeBound (x : TowerFock D R) : ℕ :=
  x.support.sup fun j => Fock.modeBound (x j)

lemma sum_single_eq (x : TowerFock D R) :
    ∑ j ∈ x.support, Finsupp.single j (x j) = x :=
  Finsupp.sum_single x

/-- A mode of index above the mode bound kills the tower vector: this is the *upper* cut-off
of the DDF sum, once transversality has been used to move `α^ε` to the right. -/
theorem towerMode_apply_eq_zero_of_lt (η a b : Fin D → R) (μ : Fin D) (p : ℤ)
    (x : TowerFock D R) (hp : (towerModeBound x : ℤ) < p) : towerMode η a b μ p x = 0 := by
  classical
  conv_lhs => rw [← sum_single_eq x]
  rw [map_sum]
  refine Finset.sum_eq_zero fun j hj => ?_
  have hle : (Fock.modeBound (x j) : ℤ) ≤ (towerModeBound x : ℤ) := by
    exact_mod_cast Finset.le_sup (f := fun j => Fock.modeBound (x j)) hj
  rw [towerMode_single,
    Fock.mode_apply_eq_zero_of_modeBound_lt η (towerMomentum a b j) μ (by omega),
    Finsupp.single_zero]

/-- **The polarised mode** `α^ε_p = Σ_μ η_μ ε^μ α^μ_p`.  The polarisation `ε` enters only
through this contraction; the DDF transversality condition `ε · k_0 = 0` is
`dotVec η ε b = 0`. -/
noncomputable def towerModeVec (η a b ε : Fin D → R) (p : ℤ) :
    Module.End R (TowerFock D R) :=
  ∑ μ : Fin D, (η μ * ε μ) • towerMode η a b μ p

theorem towerModeVec_apply_eq_zero_of_lt (η a b ε : Fin D → R) (p : ℤ) (x : TowerFock D R)
    (hp : (towerModeBound x : ℤ) < p) : towerModeVec η a b ε p x = 0 := by
  rw [towerModeVec, LinearMap.sum_apply]
  refine Finset.sum_eq_zero fun μ _ => ?_
  rw [LinearMap.smul_apply, towerMode_apply_eq_zero_of_lt η a b μ p x hp, smul_zero]

variable [Algebra ℚ R]

/-- Below the window the vertex operator itself kills the state: this is the *lower* cut-off
of the DDF sum, and it needs no transversality. -/
theorem towerVertex_apply_eq_zero_of_lt (η b : Fin D → R) (n K : ℤ) (x : TowerFock D R)
    (hK : K < n - (towerLevelBound x : ℤ)) : towerVertex η b n K x = 0 := by
  classical
  conv_lhs => rw [← sum_single_eq x]
  rw [map_sum]
  refine Finset.sum_eq_zero fun j hj => ?_
  have hle : (Fock.levelBound (x j) : ℤ) ≤ (towerLevelBound x : ℤ) := by
    exact_mod_cast Finset.le_sup (f := fun j => Fock.levelBound (x j)) hj
  rw [towerVertex_single,
    Fock.vertexOsc_apply_eq_zero_of_levelBound_lt η (vertexMomentum b n) (by omega),
    Finsupp.single_zero]

end TowerBounds

/-! ### The commutators of the polarised mode -/

section DDF

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

/-- `⁅L_m, α^ε_p⁆ = -p α^ε_{m+p}`: the polarised mode obeys the same Virasoro relation as
each `α^μ_p`. -/
theorem lie_towerLop_towerModeVec (η a b ε : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (m p : ℤ) :
    ⁅towerLop η a b m, towerModeVec η a b ε p⁆
      = (-(p : R)) • towerModeVec η a b ε (m + p) := by
  rw [towerModeVec, towerModeVec, lie_sum_end, Finset.smul_sum]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [lie_smul_end, lie_towerLop_towerMode η a b hη m μ p, smul_comm]

/-- `⁅α^ε_p, V^{(n)}_K⁆ = n (ε · k_0) V^{(n)}_{K-p}`: the polarised form of
`lie_towerMode_towerVertex`, zero mode included. -/
theorem lie_towerModeVec_towerVertex (η a b ε : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (n K p : ℤ) :
    ⁅towerModeVec η a b ε p, towerVertex η b n K⁆
      = ((n : R) * dotVec η ε b) • towerVertex η b n (K - p) := by
  rw [towerModeVec, sum_lie_end, dotVec, Finset.mul_sum, Finset.sum_smul]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [smul_lie_end, lie_towerMode_towerVertex η a b hη μ n K p, smul_smul]
  congr 1
  ring

/-- **Transversality makes `α^ε` commute with the whole vertex operator.**  This is the
`ε · k_0 = 0` of `worldsheet.ddf-operators-v5`, and it is the *only* input that makes the
DDF sum finite from above. -/
theorem towerModeVec_mul_towerVertex_of_transverse (η a b ε : Fin D → R)
    (hη : ∀ μ, η μ * η μ = 1) (hεb : dotVec η ε b = 0) (n K p : ℤ) :
    towerModeVec η a b ε p * towerVertex η b n K
      = towerVertex η b n K * towerModeVec η a b ε p := by
  have h := lie_towerModeVec_towerVertex η a b ε hη n K p
  rw [hεb, mul_zero, zero_smul, LieRing.of_associative_ring_bracket, sub_eq_zero] at h
  exact h

/-! ### The summands and the finite window -/

/-- The shifted product `α^ε_{m+i} ∘ V^{(n)}_i`.  The `⁅L_m, ·⁆` computation telescopes in
this family: `⁅L_m, ddfSummand j⁆ = (j - m) ddfShifted (j - m) - j ddfShifted j`. -/
noncomputable def ddfShifted (η a b ε : Fin D → R) (n m i : ℤ) :
    Module.End R (TowerFock D R) :=
  towerModeVec η a b ε (m + i) * towerVertex η b n i

/-- The `j`-th summand `α^ε_j ∘ V^{(n)}_j` of the DDF operator `A^ε_n`. -/
noncomputable def ddfSummand (η a b ε : Fin D → R) (n j : ℤ) :
    Module.End R (TowerFock D R) :=
  towerModeVec η a b ε j * towerVertex η b n j

lemma ddfSummand_eq_ddfShifted (η a b ε : Fin D → R) (n j : ℤ) :
    ddfSummand η a b ε n j = ddfShifted η a b ε n 0 j := by
  rw [ddfSummand, ddfShifted, zero_add]

theorem ddfShifted_apply_eq_zero_of_lt (η a b ε : Fin D → R) (n m i : ℤ) (x : TowerFock D R)
    (hi : i < n - (towerLevelBound x : ℤ)) : ddfShifted η a b ε n m i x = 0 := by
  rw [ddfShifted, Module.End.mul_apply, towerVertex_apply_eq_zero_of_lt η b n i x hi, map_zero]

theorem ddfShifted_apply_eq_zero_of_gt (η a b ε : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hεb : dotVec η ε b = 0) (n m i : ℤ) (x : TowerFock D R)
    (hi : (towerModeBound x : ℤ) < m + i) : ddfShifted η a b ε n m i x = 0 := by
  rw [ddfShifted, towerModeVec_mul_towerVertex_of_transverse η a b ε hη hεb n i (m + i),
    Module.End.mul_apply, towerModeVec_apply_eq_zero_of_lt η a b ε (m + i) x hi, map_zero]

/-- The finite window `n - levelBound x ≤ j ≤ modeBound x` of the DDF sum on `x`. -/
noncomputable def ddfWindow (n : ℤ) (x : TowerFock D R) : Finset ℤ :=
  Finset.Icc (n - (towerLevelBound x : ℤ)) ((towerModeBound x : ℤ))

/-- **Local finiteness of the DDF sum**
(`worldsheet.ddf-transversality-gives-local-finiteness`).  Outside the window
`ddfWindow n x` the `j`-th summand `α^ε_j V^{(n)}_j` annihilates `x`:

* below the window the vertex operator `V^{(n)}_j` alone kills `x`, because it would have to
  lower the oscillator level below the vacuum;
* above the window one uses **transversality** `ε · k_0 = 0` to move `α^ε_j` past `V^{(n)}_j`
  to the right, where it is an annihilation operator of index larger than the mode bound
  of `x`.

Without transversality the second half fails: `⁅α^ε_j, V^{(n)}_j⁆ = n (ε·k_0) V^{(n)}_0` does
not vanish, and the sum over `j` is genuinely infinite. -/
theorem ddfSummand_apply_eq_zero_of_notMem_window (η a b ε : Fin D → R)
    (hη : ∀ μ, η μ * η μ = 1) (hεb : dotVec η ε b = 0) (n : ℤ) (x : TowerFock D R) (j : ℤ)
    (hj : j ∉ ddfWindow n x) : ddfSummand η a b ε n j x = 0 := by
  rw [ddfWindow, Finset.mem_Icc, not_and, not_le] at hj
  rw [ddfSummand_eq_ddfShifted]
  rcases lt_or_ge j (n - (towerLevelBound x : ℤ)) with h | h
  · exact ddfShifted_apply_eq_zero_of_lt η a b ε n 0 j x h
  · exact ddfShifted_apply_eq_zero_of_gt η a b ε hη hεb n 0 j x (by have := hj h; omega)

/-! ### The DDF operator -/

/-- **The transverse DDF operator** `A^ε_n = Σ_{j ∈ ℤ} α^ε_j V^{(n)}_j`
(`worldsheet.ddf-operators-v5`).  The formally infinite sum is realised by `lsumLocFin`: by
`ddfSummand_apply_eq_zero_of_notMem_window` only the finitely many `j` in `ddfWindow n x`
contribute on a given vector `x`, and it is transversality `dotVec η ε b = 0` that supplies
the upper cut-off.  Both `hη` and `hεb` are arguments of the definition for this reason. -/
noncomputable def ddfOp (η a b ε : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hεb : dotVec η ε b = 0) (n : ℤ) : Module.End R (TowerFock D R) :=
  lsumLocFin (fun j => ddfSummand η a b ε n j) (ddfWindow n)
    (fun x j hj => ddfSummand_apply_eq_zero_of_notMem_window η a b ε hη hεb n x j hj)

/-- The DDF operator is computed by *any* finite window large enough for the given vector. -/
theorem ddfOp_apply (η a b ε : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hεb : dotVec η ε b = 0) (n : ℤ) (x : TowerFock D R) {s : Finset ℤ}
    (hs : ∀ j ∉ s, ddfSummand η a b ε n j x = 0) :
    ddfOp η a b ε hη hεb n x = ∑ j ∈ s, ddfSummand η a b ε n j x := by
  rw [ddfOp]
  exact lsumLocFin_apply _ _ _ x hs

/-! ### `⁅L_m, A^ε_n⁆ = 0` for `m ≥ 1` -/

/-- The bracket of `L_m` with a single summand, in the telescoping form
`⁅L_m, α^ε_j V^{(n)}_j⁆ = (j - m) · α^ε_j V^{(n)}_{j-m} - j · α^ε_{m+j} V^{(n)}_j`.

Both terms come from the Leibniz rule: `⁅L_m, α^ε_j⁆ = -j α^ε_{m+j}` and
`⁅L_m, V^{(n)}_j⁆ = (j - m) V^{(n)}_{j-m}` (the latter is the weight-`0` primary property of
the DDF vertex operator, `lie_towerLop_towerVertex_of_pos_normalized`, which needs `k_0² = 0`
and `2α' k_0 · p = 1`). -/
theorem lie_towerLop_ddfSummand (η a b ε : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1) {m : ℤ} (hm : 0 < m) (n j : ℤ) :
    ⁅towerLop η a b m, ddfSummand η a b ε n j⁆
      = ((j - m : ℤ) : R) • ddfShifted η a b ε n m (j - m)
        - ((j : ℤ) : R) • ddfShifted η a b ε n m j := by
  simp only [ddfSummand, ddfShifted, show m + (j - m) = j from by ring]
  rw [lie_mul_end, lie_towerLop_towerModeVec η a b ε hη m j,
    lie_towerLop_towerVertex_of_pos_normalized η a b hη hbb hba hm n j,
    smul_mul_assoc, mul_smul_comm]
  push_cast
  module

/-- **The DDF operators commute with the positive Virasoro modes.**
`⁅L_m, A^ε_n⁆ = 0` for `m ≥ 1`, given `k_0² = 0`, `2α' k_0 · p = 1` and transversality
`ε · k_0 = 0`.  This is the `m ≥ 1` half of `worldsheet.ddf-commute-with-virasoro`.

The proof is the classical telescoping: writing `G_i = α^ε_{m+i} V^{(n)}_i`, the Leibniz rule
gives `⁅L_m, α^ε_j V^{(n)}_j⁆ = (j-m) G_{j-m} - j G_j`, so summing over a window `[lo, up]`
leaves only boundary terms; the boundary terms vanish because `lo` is below the
vertex-operator cut-off and `up` is above the mode cut-off.  Transversality is used twice:
once for the upper cut-off, and once (through `ddfOp` itself) for the sum to exist at all. -/
theorem lie_towerLop_ddfOp_of_pos (η a b ε : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1) (hεb : dotVec η ε b = 0)
    {m : ℤ} (hm : 0 < m) (n : ℤ) :
    ⁅towerLop η a b m, ddfOp η a b ε hη hεb n⁆ = 0 := by
  classical
  refine LinearMap.ext fun x => ?_
  obtain ⟨lo, hlo1, hlo2⟩ : ∃ lo : ℤ, lo ≤ n - (towerLevelBound x : ℤ) ∧
      lo ≤ n - (towerLevelBound (towerLop η a b m x) : ℤ) :=
    ⟨_, min_le_left _ _, min_le_right _ _⟩
  obtain ⟨up, hup1, hup2⟩ : ∃ up : ℤ, (towerModeBound x : ℤ) ≤ up ∧
      (towerModeBound (towerLop η a b m x) : ℤ) ≤ up :=
    ⟨_, le_max_left _ _, le_max_right _ _⟩
  have hwin : ∀ z : TowerFock D R, lo ≤ n - (towerLevelBound z : ℤ) →
      (towerModeBound z : ℤ) ≤ up → ∀ j ∉ Finset.Icc lo up,
      ddfSummand η a b ε n j z = 0 := by
    intro z hz1 hz2 j hj
    rw [Finset.mem_Icc, not_and, not_le] at hj
    rw [ddfSummand_eq_ddfShifted]
    rcases lt_or_ge j lo with h | h
    · exact ddfShifted_apply_eq_zero_of_lt η a b ε n 0 j z (by omega)
    · exact ddfShifted_apply_eq_zero_of_gt η a b ε hη hεb n 0 j z (by have := hj h; omega)
  have hAx := ddfOp_apply η a b ε hη hεb n x (hwin x hlo1 hup1)
  have hAy := ddfOp_apply η a b ε hη hεb n (towerLop η a b m x) (hwin _ hlo2 hup2)
  set g : ℤ → TowerFock D R := fun i => ((i : ℤ) : R) • ddfShifted η a b ε n m i x with hgdef
  have hglo : ∀ i : ℤ, i < lo → g i = 0 := by
    intro i hi
    simp only [hgdef]
    rw [ddfShifted_apply_eq_zero_of_lt η a b ε n m i x (by omega), smul_zero]
  have hgup : ∀ i : ℤ, up - m < i → g i = 0 := by
    intro i hi
    simp only [hgdef]
    rw [ddfShifted_apply_eq_zero_of_gt η a b ε hη hεb n m i x (by omega), smul_zero]
  have hterm : ∀ j : ℤ, towerLop η a b m (ddfSummand η a b ε n j x)
      - ddfSummand η a b ε n j (towerLop η a b m x) = g (j - m) - g j := by
    intro j
    have h := congrArg (fun T : Module.End R (TowerFock D R) => T x)
      (lie_towerLop_ddfSummand η a b ε hη hbb hba hm n j)
    simp only [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
      LinearMap.smul_apply] at h
    simp only [hgdef]
    exact h
  rw [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
    Module.End.mul_apply, LinearMap.zero_apply, hAx, hAy, map_sum, ← Finset.sum_sub_distrib]
  refine Eq.trans (Finset.sum_congr rfl fun j _ => hterm j) ?_
  rw [Finset.sum_sub_distrib]
  have e1 : ∑ j ∈ Finset.Icc lo up, g (j - m) = ∑ j ∈ Finset.Icc (lo - m) (up - m), g j := by
    refine Finset.sum_nbij' (fun j => j - m) (fun j => j + m) ?_ ?_ ?_ ?_ ?_
    · intro j hj
      simp only [Finset.mem_Icc] at hj ⊢
      omega
    · intro j hj
      simp only [Finset.mem_Icc] at hj ⊢
      omega
    · intro j _
      omega
    · intro j _
      omega
    · intro j _
      rfl
  have e2 : ∑ j ∈ Finset.Icc (lo - m) (up - m), g j = ∑ j ∈ Finset.Icc lo (up - m), g j := by
    refine (Finset.sum_subset (fun i hi => ?_) (fun i hi hni => ?_)).symm
    · simp only [Finset.mem_Icc] at hi ⊢
      omega
    · simp only [Finset.mem_Icc] at hi
      simp only [Finset.mem_Icc, not_and, not_le] at hni
      rcases lt_or_ge i lo with h | h
      · exact hglo i h
      · exact absurd (hni h) (by omega)
  have e3 : ∑ j ∈ Finset.Icc lo up, g j = ∑ j ∈ Finset.Icc lo (up - m), g j := by
    refine (Finset.sum_subset (fun i hi => ?_) (fun i hi hni => ?_)).symm
    · simp only [Finset.mem_Icc] at hi ⊢
      omega
    · simp only [Finset.mem_Icc] at hi
      simp only [Finset.mem_Icc, not_and, not_le] at hni
      exact hgup i (hni hi.1)
  rw [e1, e2, e3, sub_self]

end DDF

end StringFormal.NoGhost
