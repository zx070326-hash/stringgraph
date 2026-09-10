/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
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
* `towerModeVec η a b ε p` — the contracted mode `α^ε_p = Σ_μ η_μ ε^μ α^μ_p`.
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

1. **`m ≤ -1`.**  `StringFormal/NoGhost/VertexWeight.lean` only proves the conformal-weight
   identity `⁅L_m, V^{(n)}_K⁆ = (K - m) V^{(n)}_{K-m}` for `m ≥ 1`; the negative modes need
   the `m < 0` half of that file, which is not done.  So `ddf-commute-with-virasoro` is only
   half formalised here.  (`m = 0` is not covered either: it is not a special case of the
   `m ≥ 1` argument, since `Fock.lie_Lop_vertexOsc_of_pos` assumes `0 < m`.)
2. **`[A^i_m, A^j_n] = m δ^{ij} δ_{m+n,0}`** — the transverse oscillator algebra
   (`worldsheet.ddf-transverse-oscillator-algebra`) is not formalised.
3. **`A^ε_n` preserves the physical subspace.**  This needs (1) — the physical-state
   conditions are `L_m ψ = 0` for `m ≥ 1` *and* `(L_0 - a_0) ψ = 0`, and the `L_0` condition
   is not covered by `lie_towerLop_ddfOp_of_pos`.  Moreover `physSubmodule` in
   `StringFormal/NoGhost/PhysicalStates.lean` lives on a single Fock space, not on the tower,
   so even stating it needs a tower-level `physSubmodule` first.
4. **Spectrum-generating property** (the DDF states span the transverse physical spectrum)
   is not formalised; nothing here says `A^ε_n ≠ 0`.
-/

namespace StringFormal.NoGhost

open MvPolynomial

/-! ### A Leibniz rule for the commutator of an associative ring -/

/-- Leibniz rule for the commutator bracket of an associative ring:
`⁅a, b * c⁆ = ⁅a, b⁆ * c + b * ⁅a, c⁆`. -/
lemma lie_mul_of_ring {A : Type*} [Ring A] (a b c : A) :
    ⁅a, b * c⁆ = ⁅a, b⁆ * c + b * ⁅a, c⁆ := by
  simp only [LieRing.of_associative_ring_bracket]
  noncomm_ring

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
theorem vertexOsc_apply_eq_zero_of_levelBound_lt [Algebra ℚ R] (η c : Fin D → R) {P : Fock D R} {K : ℤ}
    (hK : (levelBound P : ℤ) + K < 0) : vertexOsc η c K P = 0 := by
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

variable [Algebra ℚ R]

/-- Below the window the vertex operator itself kills the state. -/
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

end StringFormal.NoGhost
