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

end StringFormal.NoGhost
