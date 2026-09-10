/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.DDFOperator
import StringFormal.NoGhost.PhysicalStates

/-!
# The positive-mode (Virasoro primary) subspace of the momentum tower

Graph nodes: `worldsheet.old-covariant-physical-states` (the single-Fock version, already
formalised as `Fock.physSubmodule`), `worldsheet.ddf-commute-with-positive-virasoro`.
`formal/TODO.md` item (4).

## What is here

* `towerPositiveModeSubmodule η a b` — **the positive-mode subspace of the tower**,
  `{Ψ : L_m Ψ = 0 for all m ≥ 1}`, as an intersection of kernels of `towerLop`.
* `mem_towerPositiveModeSubmodule` — the unfolding lemma.
* **`ddfOp_mem_towerPositiveModeSubmodule`** — the DDF operators preserve it.

## Why the `L_0` condition is *not* here

`Fock.physSubmodule η a a₀` imposes both `L_m ψ = 0` (`m ≥ 1`) and `(L_0 - a₀) ψ = 0`.  On
the tower `TowerFock D R = ℤ →₀ Fock D R` the rung-`j` summand carries momentum
`p_j = a + j·b`, and `L_0` on that rung is `α' p_j² + N`; by
`invTwo_mul_zeroModeSq_towerMomentum` the zero-mode part shifts by `j` from rung to rung, so
a *single* intercept `a₀` cannot be imposed uniformly on the tower.  The correct
rung-dependent statement is deliberately left undefined here rather than guessed.
-/

namespace StringFormal.NoGhost

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]


/-! ### The positive-mode subspace -/

section PositiveMode

variable (η a b : Fin D → R)

/-- **The positive-mode (Virasoro primary) subspace of the momentum tower:**

`{Ψ ∈ TowerFock D R | L_m Ψ = 0 for all m ≥ 1}`.

This is one half of the old covariant physical-state conditions of
`worldsheet.old-covariant-physical-states`; the missing half is the mass-shell condition
`(L_0 - a₀) Ψ = 0`, which on the tower is rung-dependent (see the module docstring).  It is a
submodule because it is an intersection of kernels of linear maps.

Compare `Fock.physSubmodule η a a₀`, which imposes both conditions but only on a single Fock
space `F(a)`. -/
noncomputable def towerPositiveModeSubmodule : Submodule R (TowerFock D R) :=
  ⨅ m : ℤ, ⨅ _ : 0 < m, LinearMap.ker (towerLop η a b m)

variable {η a b}

@[simp]
lemma mem_towerPositiveModeSubmodule {Ψ : TowerFock D R} :
    Ψ ∈ towerPositiveModeSubmodule η a b ↔ ∀ m : ℤ, 0 < m → towerLop η a b m Ψ = 0 := by
  simp only [towerPositiveModeSubmodule, Submodule.mem_iInf, LinearMap.mem_ker]

end PositiveMode


/-! ### The DDF operators preserve the positive-mode subspace -/

/-- **The DDF operators preserve the Virasoro primary conditions.**

If `Ψ` satisfies `L_m Ψ = 0` for all `m ≥ 1`, then so does `A^ε_n Ψ`, given the DDF
normalisations `k_0² = 0` (`hbb`), `2α' k_0 · p = 1` (`hba`) and transversality `ε · k_0 = 0`
(`hεb`).

The proof is one line of algebra on top of `lie_towerLop_ddfOp_of_pos`:
`L_m (A^ε_n Ψ) = A^ε_n (L_m Ψ) + ⁅L_m, A^ε_n⁆ Ψ = A^ε_n 0 + 0 = 0`.

This is the "positive-mode half" of the statement that the DDF operators map physical states
to physical states.  The `L_0` half is **not** proved here and is not even stated: see the
module docstring. -/
theorem ddfOp_mem_towerPositiveModeSubmodule (η a b ε : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1) (hεb : dotVec η ε b = 0) (n : ℤ)
    {Ψ : TowerFock D R} (hΨ : Ψ ∈ towerPositiveModeSubmodule η a b) :
    ddfOp η a b ε hη hεb n Ψ ∈ towerPositiveModeSubmodule η a b := by
  rw [mem_towerPositiveModeSubmodule] at hΨ ⊢
  intro m hm
  have h := lie_towerLop_ddfOp_of_pos η a b ε hη hbb hba hεb hm n
  have h' := congrArg (fun T : Module.End R (TowerFock D R) => T Ψ) h
  simp only [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
    LinearMap.zero_apply, sub_eq_zero] at h'
  rw [h', hΨ m hm, map_zero]

end StringFormal.NoGhost
