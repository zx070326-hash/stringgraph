/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.HeisenbergGram
import StringFormal.NoGhost.DDFAlgebra
import StringFormal.NoGhost.VertexAdjoint
import StringFormal.NoGhost.DDFOperatorAll

/-!
# The Gram matrix of the transverse DDF states

Graph node: `worldsheet.transverse-ddf-fock-gram-matrix`.  This is §C.4 of
`formal/BLUEPRINT-noghost.md`, i.e. the instantiation of the abstract recursion
`StringFormal.gram_of_heisenberg_family` (§C.3, `StringFormal/NoGhost/HeisenbergGram.lean`) at
the DDF operators `A^ε_n` of `StringFormal/NoGhost/DDFOperator.lean`.

## Conventions

`conv.metric-signature-mostly-plus` through the diagonal signature `η` with `η μ * η μ = 1`;
`conv.alpha-prime-regge` through `a^μ = α^μ_0 = (2α')^{1/2} k^μ` and
`b^μ = (2α')^{1/2} k_0^μ`.  The DDF normalisations are hypotheses: `k_0² = 0` is
`dotVec η b b = 0`, `2α' k_0 · p = 1` is `dotVec η b a = 1`, transversality `ε_i · k_0 = 0` is
`hεb`, and the orthonormal transverse frame `ε_i · ε_j = δ_{ij}` is `horth`.
`StringFormal/NoGhost/Witness.lean` shows all of these are simultaneously satisfiable
(`noghost_transverse_gram_satisfiable`), so none of them is vacuous.

## Main definitions

* `towerVacuum D R` — the tower vacuum `|0; k⟩ = Finsupp.single 0 1`, the Fock vacuum sitting on
  rung `0` of the momentum tower.
* `ddfFamily η a b ε hη hεb` — the DDF operators packaged as a Heisenberg family
  `ι → ℤ → Module.End R (TowerFock D R)`, `i ↦ n ↦ A^{ε_i}_n`.
* `ddfMonomial` — the DDF state `∏_{(i,n)} (A^{ε_i}_{-n})^{d(i,n)} |0; k⟩`.

## Main statements

* `Fock.towerPairing_towerVacuum_self` — `⟨0;k|0;k⟩ = 1` (hypothesis (H3)).
* `ddfOp_towerVacuum_of_pos` — `A^ε_n |0;k⟩ = 0` for `n > 0` (hypothesis (H4)).  The proof is
  the one line predicted by the blueprint: `ddfWindow n towerVacuum = Finset.Icc n 0 = ∅`.
* `ddfFamily_ccr`, `ddfFamily_adj` — hypotheses (H1)/(H2) from `lie_ddfOp_ddfOp` and
  `Fock.towerPairing_ddfOp_left`.  It is the orthonormality `ε_i · ε_j = δ_{ij}` that turns the
  central term `m (ε·δ) δ_{m+n,0}` of `lie_ddfOp_ddfOp` into the Heisenberg normalisation
  `m δ_{ij} δ_{m+n,0}`.
* **`ddf_gram_diagonal`** — the Gram matrix of the DDF states is diagonal with entries
  `heisNorm R d = ∏_{(i,n)} n^{d(i,n)} d(i,n)!`.
* `ddf_gram_pos` — over an ordered ring the diagonal entries are positive, so the DDF sector
  of the momentum tower is positive definite on each state.
* `linearIndependent_ddfMonomial` — over a field of characteristic zero the DDF states are
  linearly independent.  This is the input to `ch H^⊥ = φ(q)^{-(D-2)}` in §B.3 of the blueprint.
* `ddfMonomial_mem_towerPhysSubmodule` — every DDF state is an old covariant physical state of
  the tower, with intercept `a₀ = α' k²` read off the vacuum.

## Mathematical notes (for the dependency graph)

1. **Orthonormality of the frame, not just transversality, is what makes the Gram matrix
   diagonal.**  `lie_ddfOp_ddfOp` gives `⁅A^ε_m, A^δ_n⁆ = m (ε·δ) δ_{m+n,0}` for *any* pair of
   transverse polarisations; the hypothesis `horth` is a genuine extra input, and the card
   should say so.  Over `ℝ` with `D ≥ 3` such a frame exists
   (`noghost_transverse_gram_satisfiable`), which is where "`D - 2` transverse directions"
   enters; nothing here requires `D = 26`.
2. **The intercept is not free.**  `ddfMonomial_mem_towerPhysSubmodule` holds with
   `a₀ = ½ α_0² = α' k²` — the value forced by the vacuum, not an independent parameter.  The
   tachyonic normalisation `α' k² = 1` of `Witness.lean` is what makes it `a₀ = 1`.
3. **Positivity is stated per state, not on the span.**  `ddf_gram_pos` says each diagonal entry
   is positive; "every nonzero element of the span of the DDF states has positive norm"
   additionally uses orthogonality and is not proved here (see the gaps).
4. **No spanning.**  Nothing here says the DDF states exhaust the transverse physical spectrum;
   that is `ddf-spans` (§B of the blueprint) and remains the hard half of no-ghost.

## Gaps

1. **No positivity on the span.**  `⟨Σ c_d |d⟩, Σ c_d |d⟩⟩ = Σ c_d² heisNorm d > 0` for
   `c ≠ 0` follows formally from `ddf_gram_diagonal`, but is not stated; it is what blueprint
   §C.5 (`no_ghost_semidefinite`) will need, together with a submodule `ddfSpan`.
2. The frame index type `ι` is arbitrary.  Tying `ι` to `Fin (D - 2)` requires a bijection with
   `{i : Fin D // 2 ≤ (i : ℕ)}`, which is bookkeeping without mathematical content and is not
   done.
-/

namespace StringFormal.NoGhost

open MvPolynomial

/-! ### The tower vacuum -/

section TowerVacuum

variable {D : ℕ} {R : Type*} [CommRing R]

/-- **The tower vacuum** `|0; k⟩`: the Fock vacuum of `StringFormal/NoGhost/Fock.lean` placed on
rung `0` of the momentum tower, i.e. at momentum parameter `towerMomentum a b 0 = a`. -/
noncomputable def towerVacuum (D : ℕ) (R : Type*) [CommRing R] : TowerFock D R :=
  Finsupp.single 0 (Fock.vacuum D R)

lemma towerVacuum_def : towerVacuum D R = Finsupp.single 0 (Fock.vacuum D R) := rfl

@[simp]
lemma towerVacuum_apply_zero : (towerVacuum D R) 0 = Fock.vacuum D R := by
  simp [towerVacuum]

lemma support_towerVacuum_subset : (towerVacuum D R).support ⊆ {0} :=
  Finsupp.support_single_subset

namespace Fock

/-- The vacuum has no monomial above level `0`
(`levelBound_one` is in `StringFormal/NoGhost/VertexProduct.lean`). -/
@[simp]
lemma levelBound_vacuum : levelBound (vacuum D R) = 0 := levelBound_one

@[simp]
lemma modeBound_vacuum : modeBound (vacuum D R) = 0 := modeBound_one

/-- **The tower vacuum is normalised**: `⟨0;k|0;k⟩ = 1`.  This is hypothesis (H3) of
`worldsheet.transverse-ddf-fock-gram-matrix`, and it is what pins the overall scale of the
whole DDF Gram matrix. -/
@[simp]
theorem towerPairing_towerVacuum_self (η : Fin D → R) :
    towerPairing η (towerVacuum D R) (towerVacuum D R) = 1 := by
  rw [towerVacuum_def, towerPairing_single_single, if_pos rfl, pairing_vacuum_vacuum]

end Fock

@[simp]
lemma towerLevelBound_towerVacuum : towerLevelBound (towerVacuum D R) = 0 := by
  refine Nat.le_zero.mp (Finset.sup_le fun j hj => ?_)
  rw [Finset.mem_singleton.mp (support_towerVacuum_subset hj)]
  simp

@[simp]
lemma towerModeBound_towerVacuum : towerModeBound (towerVacuum D R) = 0 := by
  refine Nat.le_zero.mp (Finset.sup_le fun j hj => ?_)
  rw [Finset.mem_singleton.mp (support_towerVacuum_subset hj)]
  simp

/-- **The DDF window on the vacuum is empty for `n > 0`**: it is `Finset.Icc n 0`, because both
the level bound and the mode bound of the vacuum are `0`. -/
theorem ddfWindow_towerVacuum_of_pos {n : ℤ} (hn : 0 < n) :
    ddfWindow n (towerVacuum D R) = (∅ : Finset ℤ) := by
  rw [ddfWindow, towerLevelBound_towerVacuum, towerModeBound_towerVacuum]
  exact Finset.Icc_eq_empty (by push_cast; omega)

end TowerVacuum

/-! ### The DDF operators annihilate the vacuum -/

section Annihilation

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

/-- **The DDF operators of positive mode annihilate the tower vacuum**: `A^ε_n |0;k⟩ = 0` for
`n > 0`.  This is hypothesis (H4) of `worldsheet.transverse-ddf-fock-gram-matrix`.

The proof is a one-liner given local finiteness: the DDF sum on `|0;k⟩` runs over
`ddfWindow n |0;k⟩ = Finset.Icc n 0`, which is empty for `n > 0`.  Concretely, each summand
`α^ε_j V^{(n)}_j` kills the vacuum either because `V^{(n)}_j` would lower the oscillator level
below the vacuum (`j < n`), or because `α^ε_j` is an annihilator (`j > 0`). -/
theorem ddfOp_towerVacuum_of_pos (η a b ε : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hεb : dotVec η ε b = 0) {n : ℤ} (hn : 0 < n) :
    ddfOp η a b ε hη hεb n (towerVacuum D R) = 0 := by
  classical
  have hs : ∀ j ∉ (∅ : Finset ℤ), ddfSummand η a b ε n j (towerVacuum D R) = 0 := by
    intro j _
    refine ddfSummand_apply_eq_zero_of_notMem_window η a b ε hη hεb n (towerVacuum D R) j ?_
    rw [ddfWindow_towerVacuum_of_pos hn]
    exact Finset.notMem_empty j
  rw [ddfOp_apply η a b ε hη hεb n (towerVacuum D R) hs, Finset.sum_empty]

end Annihilation

/-! ### The DDF family as an abstract Heisenberg family -/

section Family

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] {ι : Type*} [DecidableEq ι]
variable (η a b : Fin D → R) (ε : ι → Fin D → R)

/-- **The DDF operators packaged as a Heisenberg family.**  `ddfFamily η a b ε hη hεb i n` is
`A^{ε_i}_n`; this is exactly the shape `ι → ℤ → Module.End R M` that
`StringFormal.gram_of_heisenberg_family` consumes.

The transversality proof `hεb` is an argument of `ddfOp` itself (it is what makes the DDF sum
locally finite), hence an argument here. -/
noncomputable def ddfFamily (hη : ∀ μ, η μ * η μ = 1) (hεb : ∀ i, dotVec η (ε i) b = 0) :
    ι → ℤ → Module.End R (TowerFock D R) :=
  fun i n => ddfOp η a b (ε i) hη (hεb i) n

omit [DecidableEq ι] in
lemma ddfFamily_apply (hη : ∀ μ, η μ * η μ = 1) (hεb : ∀ i, dotVec η (ε i) b = 0)
    (i : ι) (n : ℤ) :
    ddfFamily η a b ε hη hεb i n = ddfOp η a b (ε i) hη (hεb i) n := rfl

variable {η a b ε}

/-- **Hypothesis (H1): the canonical commutation relations.**
`⁅A^{ε_i}_m, A^{ε_j}_n⁆ = m δ_{ij} δ_{m+n,0}`.

This is `lie_ddfOp_ddfOp` — which gives the central term `m (ε_i · ε_j) δ_{m+n,0}` for any pair
of transverse polarisations — *plus* the orthonormality of the frame.  Orthonormality is a real
extra hypothesis: without it the DDF Gram matrix is the (constant) transverse Gram matrix
tensored with the Heisenberg one, and is diagonal only after diagonalising `ε_i · ε_j`. -/
theorem ddfFamily_ccr (hη : ∀ μ, η μ * η μ = 1) (hbb : dotVec η b b = 0)
    (hba : dotVec η b a = 1) (hεb : ∀ i, dotVec η (ε i) b = 0)
    (horth : ∀ i j : ι, dotVec η (ε i) (ε j) = if i = j then 1 else 0) :
    ∀ (i j : ι) (m n : ℤ), ⁅ddfFamily η a b ε hη hεb i m, ddfFamily η a b ε hη hεb j n⁆
      = (if m + n = 0 ∧ i = j then (m : R) else 0)
          • (LinearMap.id : Module.End R (TowerFock D R)) := by
  intro i j m n
  rw [ddfFamily_apply, ddfFamily_apply,
    lie_ddfOp_ddfOp η a b (ε i) (ε j) hη hbb hba (hεb i) (hεb j) m n, horth i j]
  by_cases h1 : m + n = 0 <;> by_cases h2 : i = j <;> simp [h1, h2]

omit [DecidableEq ι] in
/-- **Hypothesis (H2): mutual adjointness** `(A^{ε_i}_n)^† = A^{ε_i}_{-n}` with respect to the
tower form.  This is `Fock.towerPairing_ddfOp_left`. -/
theorem ddfFamily_adj (hη : ∀ μ, η μ * η μ = 1) (hεb : ∀ i, dotVec η (ε i) b = 0) :
    ∀ (i : ι) (n : ℤ) (x y : TowerFock D R),
      Fock.towerPairing η (ddfFamily η a b ε hη hεb i n x) y
        = Fock.towerPairing η x (ddfFamily η a b ε hη hεb i (-n) y) :=
  fun i n x y => Fock.towerPairing_ddfOp_left η a b (ε i) hη (hεb i) n x y

omit [DecidableEq ι] in
/-- **Hypothesis (H4): the vacuum condition** `A^{ε_i}_n |0;k⟩ = 0` for `n > 0`. -/
theorem ddfFamily_ann (hη : ∀ μ, η μ * η μ = 1) (hεb : ∀ i, dotVec η (ε i) b = 0) :
    ∀ (i : ι) (n : ℤ), 0 < n → ddfFamily η a b ε hη hεb i n (towerVacuum D R) = 0 :=
  fun i _ hn => ddfOp_towerVacuum_of_pos η a b (ε i) hη (hεb i) hn

/-- The creation operators `A^{ε_i}_{-n}` (`n > 0`) commute; a consequence of `ddfFamily_ccr`,
not an extra assumption. -/
theorem commute_heisCreation_ddfFamily (hη : ∀ μ, η μ * η μ = 1) (hbb : dotVec η b b = 0)
    (hba : dotVec η b a = 1) (hεb : ∀ i, dotVec η (ε i) b = 0)
    (horth : ∀ i j : ι, dotVec η (ε i) (ε j) = if i = j then 1 else 0) :
    ∀ u v : ι × ℕ+, Commute (heisCreation (ddfFamily η a b ε hη hεb) u)
      (heisCreation (ddfFamily η a b ε hη hεb) v) :=
  commute_heisCreation (ddfFamily_ccr hη hbb hba hεb horth)

end Family

/-! ### The DDF states and their Gram matrix -/

section Gram

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] {ι : Type*} [DecidableEq ι]
variable {η a b : Fin D → R} {ε : ι → Fin D → R}
variable (hη : ∀ μ, η μ * η μ = 1) (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1)
variable (hεb : ∀ i, dotVec η (ε i) b = 0)
variable (horth : ∀ i j : ι, dotVec η (ε i) (ε j) = if i = j then 1 else 0)

/-- **The DDF state** `∏_{(i,n)} (A^{ε_i}_{-n})^{d(i,n)} |0;k⟩`, indexed by an occupation
function `d : (ι × ℕ+) →₀ ℕ`.  The order of the factors is immaterial by
`commute_heisCreation_ddfFamily`. -/
noncomputable def ddfMonomial (d : (ι × ℕ+) →₀ ℕ) : TowerFock D R :=
  heisMonomial (ddfFamily η a b ε hη hεb) (towerVacuum D R)
    (commute_heisCreation_ddfFamily hη hbb hba hεb horth) d

@[simp]
theorem ddfMonomial_zero : ddfMonomial hη hbb hba hεb horth 0 = towerVacuum D R :=
  heisMonomial_zero _ _

theorem ddfMonomial_add_single (d : (ι × ℕ+) →₀ ℕ) (v : ι × ℕ+) :
    ddfMonomial hη hbb hba hεb horth (d + Finsupp.single v 1)
      = ddfOp η a b (ε v.1) hη (hεb v.1) (-((v.2 : ℕ) : ℤ))
          (ddfMonomial hη hbb hba hεb horth d) :=
  heisMonomial_add_single _ _ d v

/-- **The Gram matrix of the transverse DDF states**
(`worldsheet.transverse-ddf-fock-gram-matrix`):

`⟨∏ (A^{ε_i}_{-n})^{d(i,n)} 0;k | ∏ (A^{ε_i}_{-n})^{e(i,n)} 0;k⟩ = δ_{d,e} ∏_{(i,n)} n^{d(i,n)} d(i,n)!`

over an arbitrary commutative `ℚ`-algebra `R`.  Distinct occupation patterns are orthogonal,
and the diagonal entry is the classical Heisenberg norm.

The four inputs of `StringFormal.gram_of_heisenberg_family` are supplied by `ddfFamily_ccr`
(from `lie_ddfOp_ddfOp` + orthonormality of the frame), `ddfFamily_adj` (from
`Fock.towerPairing_ddfOp_left`), `Fock.towerPairing_towerVacuum_self` and `ddfFamily_ann`. -/
theorem ddf_gram_diagonal (d e : (ι × ℕ+) →₀ ℕ) :
    Fock.towerPairing η (ddfMonomial hη hbb hba hεb horth d)
        (ddfMonomial hη hbb hba hεb horth e)
      = if d = e then heisNorm R d else 0 :=
  gram_of_heisenberg_family (ddfFamily_ccr hη hbb hba hεb horth) (ddfFamily_adj hη hεb)
    (Fock.towerPairing_towerVacuum_self η) (ddfFamily_ann hη hεb) _ d e

/-- Distinct DDF states are orthogonal. -/
theorem ddf_gram_of_ne {d e : (ι × ℕ+) →₀ ℕ} (hde : d ≠ e) :
    Fock.towerPairing η (ddfMonomial hη hbb hba hεb horth d)
      (ddfMonomial hη hbb hba hεb horth e) = 0 := by
  rw [ddf_gram_diagonal hη hbb hba hεb horth, if_neg hde]

/-- The diagonal entry of the DDF Gram matrix is `∏_{(i,n)} n^{d(i,n)} d(i,n)!`. -/
theorem ddf_gram_self (d : (ι × ℕ+) →₀ ℕ) :
    Fock.towerPairing η (ddfMonomial hη hbb hba hεb horth d)
      (ddfMonomial hη hbb hba hεb horth d) = heisNorm R d := by
  rw [ddf_gram_diagonal hη hbb hba hεb horth, if_pos rfl]

end Gram

/-! ### Positivity and linear independence -/

section Positivity

variable {D : ℕ} {R : Type*} [CommRing R] [PartialOrder R] [IsStrictOrderedRing R] [Algebra ℚ R]
variable {ι : Type*} [DecidableEq ι]
variable {η a b : Fin D → R} {ε : ι → Fin D → R}
variable (hη : ∀ μ, η μ * η μ = 1) (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1)
variable (hεb : ∀ i, dotVec η (ε i) b = 0)
variable (horth : ∀ i j : ι, dotVec η (ε i) (ε j) = if i = j then 1 else 0)

/-- **The transverse DDF sector is positive definite on states**: over an ordered commutative
ring every DDF state has strictly positive norm, `⟨d|d⟩ = ∏ n^{d(i,n)} d(i,n)! > 0`.

This is the half of the no-ghost theorem that the Gram matrix delivers directly: in the
indefinite Fock space of `StringFormal/NoGhost/FockSigned.lean` there are negative-norm states
at every level, but none of them lies in the DDF sector.  Note that positivity uses only the
*orthonormality* of the transverse frame, not `D = 26`. -/
theorem ddf_gram_pos (d : (ι × ℕ+) →₀ ℕ) :
    0 < Fock.towerPairing η (ddfMonomial hη hbb hba hεb horth d)
      (ddfMonomial hη hbb hba hεb horth d) := by
  rw [ddf_gram_self hη hbb hba hεb horth]
  exact heisNorm_pos d

end Positivity

section Independence

variable {D : ℕ} {K : Type*} [Field K] [CharZero K] [Algebra ℚ K] {ι : Type*} [DecidableEq ι]
variable {η a b : Fin D → K} {ε : ι → Fin D → K}
variable (hη : ∀ μ, η μ * η μ = 1) (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1)
variable (hεb : ∀ i, dotVec η (ε i) b = 0)
variable (horth : ∀ i j : ι, dotVec η (ε i) (ε j) = if i = j then 1 else 0)

/-- **The transverse DDF states are linearly independent** over a field of characteristic zero:
the Gram matrix is diagonal with nonvanishing entries.

This is the input to the character count `ch H^⊥ = φ(q)^{-(D-2)}` of the Goddard-Thorn argument
(blueprint §B.3): it gives the lower bound `dim H^⊥_N ≥ p_{D-2}(N)`, the matching upper bound
being the (unformalised) spanning statement `ddf-spans`.

Characteristic zero is necessary, not decoration: `heisNorm_ne_zero` fails over `ZMod 2`, where
`FockGram.lean` exhibits a creation monomial of norm `2! = 0`. -/
theorem linearIndependent_ddfMonomial :
    LinearIndependent K (ddfMonomial hη hbb hba hεb horth) :=
  linearIndependent_heisMonomial (ddfFamily_ccr hη hbb hba hεb horth) (ddfFamily_adj hη hεb)
    (Fock.towerPairing_towerVacuum_self η) (ddfFamily_ann hη hεb) _

end Independence

/-! ### The DDF states are physical -/

section Physical

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] {ι : Type*} [DecidableEq ι]
variable {η a b : Fin D → R} {ε : ι → Fin D → R}
variable (hη : ∀ μ, η μ * η μ = 1) (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1)
variable (hεb : ∀ i, dotVec η (ε i) b = 0)
variable (horth : ∀ i j : ι, dotVec η (ε i) (ε j) = if i = j then 1 else 0)

/-- **The tower vacuum is an old covariant physical state**, with intercept
`a₀ = ½ α_0² = α' k²` read off the vacuum itself (`Fock.Lop_zero_apply_one`).  The intercept is
therefore *not* a free parameter of this statement; the tachyonic value `a₀ = 1` of
`Witness.lean` corresponds to the mass-shell condition `α' k² = 1`. -/
theorem towerVacuum_mem_towerPhysSubmodule (η a b : Fin D → R) :
    towerVacuum D R ∈ towerPhysSubmodule η a b (invTwo R * Fock.zeroModeSq η a) := by
  rw [mem_towerPhysSubmodule]
  constructor
  · rw [towerVacuum_def, towerLop_single, towerMomentum_zero, Fock.vacuum_def,
      Fock.Lop_zero_apply_one, Finsupp.smul_single]
  · intro m hm
    rw [towerVacuum_def, towerLop_single, towerMomentum_zero, Fock.vacuum_def,
      Fock.Lop_apply_one_of_pos η a hm, Finsupp.single_zero]

/-- **Every DDF state is physical.**  Induction on the occupation function: the vacuum is
physical (`towerVacuum_mem_towerPhysSubmodule`) and each creation operator `A^{ε_i}_{-n}`
preserves the physical subspace (`ddfOp_mem_towerPhysSubmodule`, itself a corollary of
`⁅L_m, A^ε_n⁆ = 0` for every `m`).

Together with `ddf_gram_pos` this says the DDF states are physical states of positive norm —
the "no ghosts among the DDF states" half of Goddard-Thorn.  The converse (every physical state
is a DDF state modulo null states) is `ddf-spans` and is not formalised. -/
theorem ddfMonomial_mem_towerPhysSubmodule (d : (ι × ℕ+) →₀ ℕ) :
    ddfMonomial hη hbb hba hεb horth d
      ∈ towerPhysSubmodule η a b (invTwo R * Fock.zeroModeSq η a) := by
  classical
  induction d using finsupp_addSingle_induction with
  | h0 => rw [ddfMonomial_zero]; exact towerVacuum_mem_towerPhysSubmodule η a b
  | hstep d v ih =>
    rw [ddfMonomial_add_single]
    exact ddfOp_mem_towerPhysSubmodule η a b (ε v.1) hη hbb hba (hεb v.1) _ ih

end Physical

end StringFormal.NoGhost
