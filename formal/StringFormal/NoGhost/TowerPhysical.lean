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
* `towerL0Submodule η a b a₀`, `towerPhysSubmodule η a b a₀` — the mass-shell condition and
  the full old covariant physical subspace of the tower, with unfolding lemmas.  **No
  preservation theorem is proved for these**; see the next section.
* `invTwo_zeroModeSq_towerMomentum_add_shift_cancel` — the `L_0` eigenvalue bookkeeping that
  says the rung shift `+n` and the level shift `-n` of `A^ε_n` cancel.

## Why the `L_0` condition is separated off

`Fock.physSubmodule η a a₀` imposes both `L_m ψ = 0` (`m ≥ 1`) and `(L_0 - a₀) ψ = 0`.  Here
the two halves are split, but *not* because the `L_0` half fails to make sense on the tower:
`towerLop η a b 0` already evaluates `L_0` rung by rung with the rung's own momentum
`p_j = a + j·b`, so `(L_0 - a₀) Ψ = 0` is a perfectly uniform condition on a tower vector.
The split is there because *proving* that `A^ε_n` preserves the `L_0` condition needs
`⁅L_0, A^ε_n⁆ = 0`, i.e. the `m = 0` case of the conformal-weight identity
`⁅L_m, V^{(n)}_K⁆ = (K - m) V^{(n)}_{K-m}`, and that case is **not formalised**:
`Fock.lie_Lop_vertexOsc_of_pos` assumes `0 < m` and `Fock.lie_Lop_vertexOsc_of_ne` assumes
`m ≠ 0`.  Only the `m ≥ 1` half is available, hence only the `m ≥ 1` half is proved.

The arithmetic that makes the `L_0` condition work out is recorded below as
`invTwo_zeroModeSq_towerMomentum_add_shift_cancel`, and is worth spelling out because it is
the reason `A^ε_n` is a weight-`0` operator.  On rung `j` at oscillator level `N`,
`Lop_zero_apply_of_mem_levelSubmodule` gives the eigenvalue `α' p_j² + N`, and under the DDF
normalisations `k_0² = 0`, `2α' k_0 · k = 1` the lemma
`invTwo_mul_zeroModeSq_towerMomentum` gives `α' p_j² = α' k² + j`, so the eigenvalue is
`α' k² + j + N`.  The summand `ddfSummand η a b ε n j = α^ε_j ∘ V^{(n)}_j` shifts

* the rung by `+n` (`towerVertex_single`: `j' ↦ j' + n`; `α^ε_j` does not move the rung), and
* the oscillator level by `(j - n)` from the vertex operator (`towerVertex_single`: level
  `N ↦ N + (K - n)` with `K = j`) and by `-j` from `α^ε_j`, i.e. by `-n` in total,

so the eigenvalue becomes `α' k² + (j' + n) + (N - n) = α' k² + j' + N`: **unchanged**, and
independently of the summation index `j`.  So the expected statement is that `A^ε_n` preserves
`towerL0Submodule η a b a₀` as well, and the rung-dependence is not an obstruction — what is
missing is purely the `m = 0` bracket.  A corollary of the same arithmetic: the `L_0`
condition pins the oscillator level rung by rung to `N = a₀ - α' k² - j`, which is why a DDF
state at tower rung `j = -N_{mass}` sits at oscillator level `N_{mass}`.
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


/-! ### The `L_0` condition on the tower

The definitions below are stated but **no preservation theorem is proved for them**: that needs
`⁅L_0, A^ε_n⁆ = 0`, i.e. the `m = 0` conformal-weight identity, which is not formalised.  See
the module docstring. -/

section LZero

variable (η a b : Fin D → R) (a₀ : R)

/-- **The mass-shell (`L_0`) condition on the momentum tower:** `{Ψ | (L_0 - a₀) Ψ = 0}`.

`towerLop η a b 0` evaluates `L_0` on rung `j` with that rung's own momentum `a + j·b`, so
this is a uniform condition on a tower vector even though the momentum varies along the
tower.  Compare the `L_0` factor of `Fock.physSubmodule η a a₀`. -/
noncomputable def towerL0Submodule : Submodule R (TowerFock D R) :=
  LinearMap.ker (towerLop η a b 0 - a₀ • (LinearMap.id : Module.End R (TowerFock D R)))

variable {η a b a₀}

lemma mem_towerL0Submodule {Ψ : TowerFock D R} :
    Ψ ∈ towerL0Submodule η a b a₀ ↔ towerLop η a b 0 Ψ = a₀ • Ψ := by
  simp only [towerL0Submodule, LinearMap.mem_ker, LinearMap.sub_apply, LinearMap.smul_apply,
    LinearMap.id_coe, id_eq, sub_eq_zero]

variable (η a b a₀)

/-- **The old covariant physical subspace of the momentum tower**, the tower analogue of
`Fock.physSubmodule`: `{Ψ | (L_0 - a₀) Ψ = 0 and L_m Ψ = 0 for all m ≥ 1}`.

`ddfOp_mem_towerPositiveModeSubmodule` shows the DDF operators preserve the second factor;
whether they preserve the first is the missing `m = 0` bracket. -/
noncomputable def towerPhysSubmodule : Submodule R (TowerFock D R) :=
  towerL0Submodule η a b a₀ ⊓ towerPositiveModeSubmodule η a b

variable {η a b a₀}

lemma mem_towerPhysSubmodule {Ψ : TowerFock D R} :
    Ψ ∈ towerPhysSubmodule η a b a₀ ↔
      towerLop η a b 0 Ψ = a₀ • Ψ ∧ ∀ m : ℤ, 0 < m → towerLop η a b m Ψ = 0 := by
  rw [towerPhysSubmodule, Submodule.mem_inf, mem_towerL0Submodule,
    mem_towerPositiveModeSubmodule]

/-- **The DDF shift cancellation, at the level of `L_0` eigenvalues.**

Under `k_0² = 0` and `2α' k_0 · k = 1`, moving up `n` rungs and down `n` oscillator levels
leaves the `L_0` eigenvalue `α' p_j² + N` unchanged.  This is exactly the shift performed by
`ddfSummand η a b ε n j = α^ε_j ∘ V^{(n)}_j` (rung `+n`, level `(j - n) + (-j) = -n`), and it
is the arithmetic reason `A^ε_n` is a weight-`0` operator.  Note the result does not depend on
`j`, the summation index of the DDF sum, nor on `N` being a natural number. -/
theorem invTwo_zeroModeSq_towerMomentum_add_shift_cancel
    (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1) (j n : ℤ) (N : R) :
    invTwo R * Fock.zeroModeSq η (towerMomentum a b (j + n)) + (N - (n : R))
      = invTwo R * Fock.zeroModeSq η (towerMomentum a b j) + N := by
  rw [invTwo_mul_zeroModeSq_towerMomentum η a b hbb hba (j + n),
    invTwo_mul_zeroModeSq_towerMomentum η a b hbb hba j]
  push_cast
  ring

end LZero

end StringFormal.NoGhost
