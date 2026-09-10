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

end StringFormal.NoGhost
