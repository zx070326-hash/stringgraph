/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.VertexWeightedSum

/-!
# The DDF transverse oscillator algebra

Graph node: `worldsheet.ddf-transverse-oscillator-algebra`; `formal/TODO.md` item
`ddf-operators`, sub-item (5).

**`[A^ε_m, A^δ_n] = m (ε·δ) δ_{m+n,0}`** for the DDF operators
`A^ε_n = Σ_j α^ε_j V^{(n)}_j` built on the momentum tower of a light-like reference vector
(`k_0² = 0`) normalised by `2α' k_0·p = 1`, with transverse polarisations
(`ε·k_0 = δ·k_0 = 0`).

## Conventions

`conv.metric-mostly-plus`, `conv.alpha-prime-regge`, as in `StringFormal/NoGhost/DDF.lean`;
`dotVec η x y = Σ_μ η_μ x^μ y^μ` and `b^μ = (2α')^{1/2} k_0^μ`.

## The assembly

Everything analytic has already happened in the three input files; what is left is
bookkeeping of two nested locally finite sums.

1. `lie_towerModeVec_towerModeVec` — the polarised CCR
   `[α^ε_j, α^δ_l] = j (ε·δ) δ_{j+l,0}`, obtained from `Fock.lie_mode_mode` rung by rung.
   Here `η_μ² = 1` is used to turn `Σ_μ η_μ³ ε_μ δ_μ` into `ε·δ`.
2. `ddfOp_mul_ddfOp_apply` — the composite `A^ε_m A^δ_n` as an explicit double sum
   `Σ_{j,l} α^ε_j α^δ_l V^{(m)}_j V^{(n)}_l`.  Transversality of `δ` is what lets
   `V^{(m)}_j` move past `α^δ_l` (`towerModeVec_mul_towerVertex_of_transverse`); the window
   for the outer sum is obtained as a `Finset.biUnion` of the windows of the finitely many
   inner vectors, so no explicit level/mode bound for `α^δ_l V^{(n)}_l x` is needed.
3. `lie_ddfOp_ddfOp` — subtract the two orders on a *common* index set, symmetric under
   `j ↦ -j` and large enough for step (5b).  The vertex operators commute
   (`towerVertex_comm_of_isotropic`, needs `k_0² = 0`), so the whole difference collapses
   onto the CCR, and the residual weighted sum `Σ_j j V^{(m)}_j V^{(n)}_{-j}` is evaluated
   by `sum_weighted_towerVertex_towerVertex` (step (5b)).

## Mathematical remarks (for the dependency graph)

1. **Each hypothesis is used, and used where physics says it should be.**  `k_0² = 0` makes
   the two vertex operators commute and fuses them in (5a)/(5b); `2α' k_0·p = 1` is the sole
   source of the `m` on the right-hand side (through (5b)); `ε·k_0 = 0` and `δ·k_0 = 0` are
   used *separately*: `δ·k_0 = 0` in the product `A^ε_m A^δ_n`, `ε·k_0 = 0` in the reversed
   product, and both again for the mere existence of the two operators.
2. **The `η_μ² = 1` hypothesis** (`hη`) is not a convention artefact: the polarised CCR
   contracts three metric factors, and only `η² = 1` collapses them to one.  It holds for the
   mostly-plus Minkowski metric `η = (-1, 1, …, 1)` used throughout.
3. **No positivity, no reality, no unitarity** enters: the identity is an identity of
   `R`-endomorphisms for any `ℚ`-algebra `R`.  The Goddard–Thorn application needs `R = ℝ`
   and the signature of `ε·δ` on the transverse subspace; that is a separate statement.

## Status

Complete as stated, no `sorry`; axioms are `propext`, `Classical.choice`, `Quot.sound` only.
-/

namespace StringFormal.NoGhost

open MvPolynomial

section TowerCCR

variable {D : ℕ} {R : Type*} [CommRing R]

/-- **The oscillator algebra on the momentum tower**:
`[α^μ_m, α^ν_p] = m η^{μν} δ_{m+p,0}`, rung by rung from `Fock.lie_mode_mode`.  The zero
modes are central, and the central term does not depend on the rung. -/
theorem lie_towerMode_towerMode (η a b : Fin D → R) (μ ν : Fin D) (m p : ℤ) :
    ⁅towerMode η a b μ m, towerMode η a b ν p⁆
      = (if m + p = 0 ∧ μ = ν then (m : R) * η μ else 0)
          • (LinearMap.id : Module.End R (TowerFock D R)) := by
  classical
  refine Finsupp.lhom_ext fun j P => ?_
  rw [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
    Module.End.mul_apply, towerMode_single, towerMode_single, towerMode_single,
    towerMode_single, ← Finsupp.single_sub, LinearMap.smul_apply, LinearMap.id_apply,
    Finsupp.smul_single]
  congr 1
  have h := congrArg (fun T : Module.End R (Fock D R) => T P)
    (Fock.lie_mode_mode η (towerMomentum a b j) μ ν m p)
  simp only [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
    LinearMap.smul_apply, LinearMap.id_apply] at h
  exact h

/-- **The polarised canonical commutation relation** `[α^ε_j, α^δ_l] = j (ε·δ) δ_{j+l,0}`.

This is where the three metric factors of `α^ε_j = Σ_μ η_μ ε^μ α^μ_j`,
`α^δ_l = Σ_ν η_ν δ^ν α^ν_l` and the central term `η^{μν}` collapse to the single one of
`ε·δ = Σ_μ η_μ ε^μ δ^μ`, using `η_μ² = 1`. -/
theorem lie_towerModeVec_towerModeVec (η a b ε δ : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (m p : ℤ) :
    ⁅towerModeVec η a b ε m, towerModeVec η a b δ p⁆
      = (if m + p = 0 then (m : R) * dotVec η ε δ else 0)
          • (LinearMap.id : Module.End R (TowerFock D R)) := by
  classical
  rw [towerModeVec, sum_lie_end]
  have hstep : ∀ μ : Fin D,
      ⁅(η μ * ε μ) • towerMode η a b μ m, towerModeVec η a b δ p⁆
        = (if m + p = 0 then (m : R) * (η μ * ε μ * δ μ) else 0)
            • (LinearMap.id : Module.End R (TowerFock D R)) := by
    intro μ
    rw [smul_lie_end, towerModeVec, lie_sum_end]
    have hν : ∀ ν : Fin D, ⁅towerMode η a b μ m, (η ν * δ ν) • towerMode η a b ν p⁆
        = (if ν = μ then (if m + p = 0 then (η μ * δ μ) * ((m : R) * η μ) else 0) else 0)
            • (LinearMap.id : Module.End R (TowerFock D R)) := by
      intro ν
      rw [lie_smul_end, lie_towerMode_towerMode, smul_smul]
      rcases eq_or_ne ν μ with rfl | hne
      · rcases eq_or_ne (m + p) 0 with hmp | hmp
        · rw [if_pos rfl, if_pos hmp, if_pos ⟨hmp, rfl⟩]
        · rw [if_pos rfl, if_neg hmp, if_neg (fun h => hmp h.1), mul_zero]
      · rw [if_neg hne, if_neg (fun h : m + p = 0 ∧ μ = ν => hne h.2.symm), mul_zero]
    rw [Finset.sum_congr rfl fun ν _ => hν ν, ← Finset.sum_smul,
      Finset.sum_ite_eq' Finset.univ μ
        (fun _ => if m + p = 0 then (η μ * δ μ) * ((m : R) * η μ) else 0),
      if_pos (Finset.mem_univ μ), smul_smul]
    rcases eq_or_ne (m + p) 0 with hmp | hmp
    · rw [if_pos hmp, if_pos hmp]
      congr 1
      linear_combination ((m : R) * ε μ * δ μ * η μ) * hη μ
    · rw [if_neg hmp, if_neg hmp, mul_zero]
  rw [Finset.sum_congr rfl fun μ _ => hstep μ, ← Finset.sum_smul]
  congr 1
  rcases eq_or_ne (m + p) 0 with hmp | hmp
  · rw [if_pos hmp, dotVec, Finset.mul_sum]
    refine Finset.sum_congr rfl fun μ _ => ?_
    rw [if_pos hmp]
  · rw [if_neg hmp]
    exact Finset.sum_eq_zero fun μ _ => if_neg hmp

end TowerCCR

/-! ### The composite of two DDF operators as an explicit double sum -/

section Product

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

/-- **`A^ε_m A^δ_n` as a doubly finite sum** `Σ_{j,l} α^ε_j α^δ_l V^{(m)}_j V^{(n)}_l`.

The index sets are arbitrary, subject only to the two local-finiteness hypotheses: `t` must
exhaust the window of the inner operator on `x`, and `s` the windows of the outer operator on
each of the finitely many vectors `α^δ_l V^{(n)}_l x`.  (Such an `s` always exists: take the
`Finset.biUnion` of those windows, which is what `lie_ddfOp_ddfOp` does.)

The reordering `V^{(m)}_j α^δ_l = α^δ_l V^{(m)}_j` is **transversality of the inner
polarisation** `δ · k_0 = 0`. -/
theorem ddfOp_mul_ddfOp_apply (η a b ε δ : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hεb : dotVec η ε b = 0) (hδb : dotVec η δ b = 0) (m n : ℤ) (x : TowerFock D R)
    {s t : Finset ℤ} (ht : ∀ l ∉ t, ddfSummand η a b δ n l x = 0)
    (hs : ∀ l ∈ t, ∀ j ∉ s, ddfSummand η a b ε m j (ddfSummand η a b δ n l x) = 0) :
    ddfOp η a b ε hη hεb m (ddfOp η a b δ hη hδb n x)
      = ∑ j ∈ s, ∑ l ∈ t, (towerModeVec η a b ε j * towerModeVec η a b δ l *
          (towerVertex η b m j * towerVertex η b n l)) x := by
  classical
  have key : ∀ j l : ℤ, ddfSummand η a b ε m j (ddfSummand η a b δ n l x)
      = (towerModeVec η a b ε j * towerModeVec η a b δ l *
          (towerVertex η b m j * towerVertex η b n l)) x := by
    intro j l
    simp only [ddfSummand]
    rw [← Module.End.mul_apply]
    congr 1
    have hc := towerModeVec_mul_towerVertex_of_transverse η a b δ hη hδb m j l
    calc towerModeVec η a b ε j * towerVertex η b m j *
          (towerModeVec η a b δ l * towerVertex η b n l)
        = towerModeVec η a b ε j *
            (towerVertex η b m j * towerModeVec η a b δ l * towerVertex η b n l) := by
          noncomm_ring
      _ = towerModeVec η a b ε j *
            (towerModeVec η a b δ l * towerVertex η b m j * towerVertex η b n l) := by
          rw [hc]
      _ = towerModeVec η a b ε j * towerModeVec η a b δ l *
            (towerVertex η b m j * towerVertex η b n l) := by noncomm_ring
  rw [ddfOp_apply η a b δ hη hδb n x ht, map_sum, Finset.sum_comm (s := s) (t := t)]
  refine Finset.sum_congr rfl fun l hl => ?_
  rw [ddfOp_apply η a b ε hη hεb m _ (hs l hl)]
  exact Finset.sum_congr rfl fun j _ => key j l

end Product

/-! ### The DDF transverse oscillator algebra -/

section Algebra

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

/-- **The DDF transverse oscillator algebra**
(`worldsheet.ddf-transverse-oscillator-algebra`):

`⁅A^ε_m, A^δ_n⁆ = m (ε·δ) δ_{m+n,0}`

on the momentum tower of a light-like reference vector `k_0` (`dotVec η b b = 0`) normalised
by `2α' k_0 · p = 1` (`dotVec η b a = 1`), for transverse polarisations
`ε · k_0 = δ · k_0 = 0`.

The right-hand side is a *scalar*: the DDF operators generate a Heisenberg algebra with the
same central term as the transverse oscillators `α^i_m`, which is what the Goddard–Thorn
argument needs. -/
theorem lie_ddfOp_ddfOp (η a b ε δ : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1) (hεb : dotVec η ε b = 0)
    (hδb : dotVec η δ b = 0) (m n : ℤ) :
    ⁅ddfOp η a b ε hη hεb m, ddfOp η a b δ hη hδb n⁆
      = (if m + n = 0 then (m : R) * dotVec η ε δ else 0)
          • (LinearMap.id : Module.End R (TowerFock D R)) := by
  classical
  refine LinearMap.ext fun x => ?_
  set N : ℤ := (towerLevelBound x : ℤ) with hN
  set Mb : ℤ := (towerModeBound x : ℤ) with hMb
  set t₁ : Finset ℤ := ddfWindow n x with ht₁def
  set s₁ : Finset ℤ := t₁.biUnion fun l => ddfWindow m (ddfSummand η a b δ n l x) with hs₁def
  set t₂ : Finset ℤ := ddfWindow m x with ht₂def
  set s₂ : Finset ℤ := t₂.biUnion fun l => ddfWindow n (ddfSummand η a b ε m l x) with hs₂def
  set V : Finset ℤ := s₁ ∪ t₁ ∪ s₂ ∪ t₂ ∪ Finset.Icc (m - N - Mb) (N - n) with hVdef
  set U : Finset ℤ := V ∪ V.image fun j => -j with hUdef
  have hVU : V ⊆ U := Finset.subset_union_left
  have hmem : ∀ z : ℤ, z ∈ s₁ ∨ z ∈ t₁ ∨ z ∈ s₂ ∨ z ∈ t₂ ∨
      (m - N - Mb ≤ z ∧ z ≤ N - n) → z ∈ U := by
    intro z hz
    refine hVU ?_
    rw [hVdef]
    simp only [Finset.mem_union, Finset.mem_Icc]
    tauto
  have hUsymm : ∀ j ∈ U, -j ∈ U := by
    intro j hj
    rw [hUdef, Finset.mem_union] at hj ⊢
    rcases hj with h | h
    · exact Or.inr (Finset.mem_image.mpr ⟨j, h, rfl⟩)
    · obtain ⟨k, hk, rfl⟩ := Finset.mem_image.mp h
      exact Or.inl (by simpa using hk)
  have hA : ddfOp η a b ε hη hεb m (ddfOp η a b δ hη hδb n x)
      = ∑ j ∈ U, ∑ l ∈ U, (towerModeVec η a b ε j * towerModeVec η a b δ l *
          (towerVertex η b m j * towerVertex η b n l)) x := by
    refine ddfOp_mul_ddfOp_apply η a b ε δ hη hεb hδb m n x (fun l hl => ?_)
      (fun l _ j hj => ?_)
    · exact ddfSummand_apply_eq_zero_of_notMem_window η a b δ hη hδb n x l
        fun hc => hl (hmem l (Or.inr (Or.inl hc)))
    · by_cases hl' : l ∈ t₁
      · exact ddfSummand_apply_eq_zero_of_notMem_window η a b ε hη hεb m _ j
          fun hc => hj (hmem j (Or.inl (Finset.mem_biUnion.mpr ⟨l, hl', hc⟩)))
      · rw [ddfSummand_apply_eq_zero_of_notMem_window η a b δ hη hδb n x l hl', map_zero]
  have hB : ddfOp η a b δ hη hδb n (ddfOp η a b ε hη hεb m x)
      = ∑ j ∈ U, ∑ l ∈ U, (towerModeVec η a b δ j * towerModeVec η a b ε l *
          (towerVertex η b n j * towerVertex η b m l)) x := by
    refine ddfOp_mul_ddfOp_apply η a b δ ε hη hδb hεb n m x (fun l hl => ?_)
      (fun l _ j hj => ?_)
    · exact ddfSummand_apply_eq_zero_of_notMem_window η a b ε hη hεb m x l
        fun hc => hl (hmem l (Or.inr (Or.inr (Or.inr (Or.inl hc)))))
    · by_cases hl' : l ∈ t₂
      · exact ddfSummand_apply_eq_zero_of_notMem_window η a b δ hη hδb n _ j
          fun hc => hj (hmem j (Or.inr (Or.inr (Or.inl (Finset.mem_biUnion.mpr ⟨l, hl', hc⟩)))))
      · rw [ddfSummand_apply_eq_zero_of_notMem_window η a b ε hη hεb m x l hl', map_zero]
  have hterm : ∀ j l : ℤ,
      (towerModeVec η a b ε j * towerModeVec η a b δ l *
          (towerVertex η b m j * towerVertex η b n l)) x
        - (towerModeVec η a b δ l * towerModeVec η a b ε j *
          (towerVertex η b n l * towerVertex η b m j)) x
      = if l = -j then ((j : R) * dotVec η ε δ) •
          ((towerVertex η b m j * towerVertex η b n l) x) else 0 := by
    intro j l
    have hccr : towerModeVec η a b ε j * towerModeVec η a b δ l
        - towerModeVec η a b δ l * towerModeVec η a b ε j
        = (if j + l = 0 then (j : R) * dotVec η ε δ else 0)
            • (LinearMap.id : Module.End R (TowerFock D R)) := by
      have h := lie_towerModeVec_towerModeVec η a b ε δ hη j l
      rwa [LieRing.of_associative_ring_bracket] at h
    have hccry := congrArg (fun T : Module.End R (TowerFock D R) =>
      T (towerVertex η b m j (towerVertex η b n l x))) hccr
    simp only [LinearMap.sub_apply, Module.End.mul_apply, LinearMap.smul_apply,
      LinearMap.id_apply] at hccry
    rw [towerVertex_comm_of_isotropic η b hbb n m l j]
    simp only [Module.End.mul_apply]
    rw [hccry]
    rcases eq_or_ne l (-j) with rfl | hl
    · rw [if_pos (by omega : j + -j = 0), if_pos rfl]
    · rw [if_neg fun h : j + l = 0 => hl (by omega), if_neg hl, zero_smul]
  rw [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
    Module.End.mul_apply, hA, hB, Finset.sum_comm (s := U) (t := U)
      (f := fun j l => (towerModeVec η a b δ j * towerModeVec η a b ε l *
        (towerVertex η b n j * towerVertex η b m l)) x),
    LinearMap.smul_apply, LinearMap.id_apply, ← Finset.sum_sub_distrib]
  have hinner : ∀ j ∈ U, (∑ l ∈ U, (towerModeVec η a b ε j * towerModeVec η a b δ l *
        (towerVertex η b m j * towerVertex η b n l)) x
      - ∑ l ∈ U, (towerModeVec η a b δ l * towerModeVec η a b ε j *
        (towerVertex η b n l * towerVertex η b m j)) x)
      = dotVec η ε δ • ((j : R) • ((towerVertex η b m j * towerVertex η b n (-j)) x)) := by
    intro j hj
    rw [← Finset.sum_sub_distrib, Finset.sum_congr rfl fun l _ => hterm j l,
      Finset.sum_ite_eq' U (-j) fun l => ((j : R) * dotVec η ε δ) •
        ((towerVertex η b m j * towerVertex η b n l) x),
      if_pos (hUsymm j hj), mul_comm, mul_smul]
  rw [Finset.sum_congr rfl hinner, ← Finset.smul_sum,
    sum_weighted_towerVertex_towerVertex η a b hη hbb hba m n x
      (s := U) fun j h1 h2 => hmem j (Or.inr (Or.inr (Or.inr (Or.inr ⟨h1, h2⟩))))]
  rcases eq_or_ne (m + n) 0 with hmn | hmn
  · rw [if_pos hmn, if_pos hmn, smul_smul, mul_comm]
  · rw [if_neg hmn, if_neg hmn, zero_smul, smul_zero]

end Algebra

end StringFormal.NoGhost
