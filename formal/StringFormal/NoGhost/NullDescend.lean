/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.DDFOperatorAll
import StringFormal.NoGhost.VertexAdjoint
import StringFormal.NoGhost.TowerNull

/-!
# DDF operators send null states to null states

Graph node: `worldsheet.ddf-operators-preserve-physical-states` (this is the null-state
companion of that card; see the note below).  This is **PR0 of blueprint §B′.4** in
`formal/BLUEPRINT-noghost.md`.

## The statement and its one-line proof

`A^ε_n` preserves the covariant physical subspace of the momentum tower
(`ddfOp_mem_towerPhysSubmodule`) and is *self-adjoint up to `n ↦ -n`* for the tower pairing
(`Fock.towerPairing_ddfOp_left`).  Null states are by definition the physical states
orthogonal to all physical states, so for `Χ` null and `Ψ` physical

`⟨A^ε_n Χ, Ψ⟩ = ⟨Χ, A^ε_{-n} Ψ⟩ = 0`,

because `A^ε_{-n} Ψ` is again physical.  Both inputs are already in the repository, so the
whole file is bookkeeping — but it is the *multiplicative structure* behind form (iii) of the
critical-dimension gap (B-26): it reduces "produce `p_{D−1}(N) − p_{D−2}(N)` independent null
states in the slice `(-N, N)`" to "produce `p(m)` longitudinal seeds for each `m ≤ N`", the
remaining factors being DDF descendants of the seeds.

## Main results

* `ddfOp_mem_towerNullSubmodule` — `A^ε_n` maps `H_null` into `H_null`.
* `ddfSpan_smul_null_le`-style corollaries are *not* given: the DDF operators do not form a
  submodule of `Module.End`, and the only consumer (PR5 of §B′) wants the single-operator
  statement.

## Deviation from blueprint §B′.4 (recorded per the "§B′ corrections" convention)

The blueprint states PR0 at the ground-state intercept `a₀ = invTwo R * Fock.zeroModeSq η a`.
Nothing in the proof uses the value of the intercept — `ddfOp_mem_towerPhysSubmodule` is
already stated for an arbitrary `a₀` — so the theorem below is proved for **every** `a₀ : R`,
which is strictly stronger and costs nothing.  Consumers that want the blueprint's form
instantiate `a₀ := invTwo R * Fock.zeroModeSq η a`.

## Conventions

Mostly-plus metric with `η μ * η μ = 1`, `b·b = 0`, `b·a = 1`, `ε·b = 0`, as everywhere in
`StringFormal/NoGhost/`.  `[Algebra ℚ R]` is needed by `ddfOp` itself.

## Status

Complete, no `sorry`; axioms are `propext`, `Classical.choice`, `Quot.sound` only.
-/

namespace StringFormal.NoGhost

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

/-- **DDF operators send null states to null states.**  Blueprint §B′.4, PR0.

`A^ε_n Χ` is physical because `A^ε_n` preserves the physical subspace, and it is orthogonal to
every physical `Ψ` because `(A^ε_n)^† = A^ε_{-n}` moves the operator onto `Ψ`, which stays
physical for the same reason.

Stated for an arbitrary intercept `a₀`; the blueprint's `a₀ = α' k²` is the special case
`a₀ = invTwo R * Fock.zeroModeSq η a`. -/
theorem ddfOp_mem_towerNullSubmodule (η a b ε : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1) (hεb : dotVec η ε b = 0) {a₀ : R} (n : ℤ)
    {Χ : TowerFock D R} (hΧ : Χ ∈ towerNullSubmodule η a b a₀) :
    ddfOp η a b ε hη hεb n Χ ∈ towerNullSubmodule η a b a₀ := by
  rw [mem_towerNullSubmodule] at hΧ ⊢
  refine ⟨ddfOp_mem_towerPhysSubmodule η a b ε hη hbb hba hεb n hΧ.1, fun Ψ hΨ => ?_⟩
  rw [Fock.towerPairing_ddfOp_left]
  exact hΧ.2 _ (ddfOp_mem_towerPhysSubmodule η a b ε hη hbb hba hεb (-n) hΨ)

end StringFormal.NoGhost
