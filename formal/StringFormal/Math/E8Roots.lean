/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import Mathlib.Data.Fin.VecNotation
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.Ring

/-!
# The `E₈` root system and its power sums `∑_α (α ⬝ x)^k` for `k = 2, 4, 6`

Lean island 2, arithmetic corner (imports only Mathlib).

The 240 roots of `E₈` are listed following Humphreys, *Reflection Groups and Coxeter
Groups*, §2.10 (pp. 42–43): in the standard basis of `ℚ⁸` they are

* `± ε_i ± ε_j` for `i < j` (112 of them), and
* `½ ∑_{i} ± ε_i` with an **even number of minus signs** (128 of them).

For `x ∈ ℚ⁸` put `P_k(x) = ∑_{α ∈ Φ} (α ⬝ x)^k`. This file proves

* `e8_power_sum_two`   : `P₂ = 60 (∑ x_i²)`,
* `e8_power_sum_four`  : `P₄ = 36 (∑ x_i²)²`,
* `e8_power_sum_six`   : `P₆ = 30 (∑ x_i²)³`,

for an **arbitrary** `x : Fin 8 → ℚ`, and the two corollaries

* `e8_trace_four` : `P₄ = (1/100) P₂²`,
* `e8_trace_six`  : `P₆ = (1/7200) P₂³`,

which are the coefficients of Green–Schwarz (1984) eqs. (12b′)(12c′)
`Ω₈ = (1/100)(tr F²)²`, `Ω₁₂ = (1/7200)(tr F²)³` and of van Ritbergen–Schellekens–
Vermaseren, *Group theory factors for Feynman diagrams* (1998), eqs. (176)(177).

## What is **not** in Lean

The step from the adjoint trace `Tr_{248} F^k` to the root power sum `∑_α (α ⬝ x)^k` is a
mathematical *hypothesis* here, not a theorem: it uses that the 248 weights of the adjoint
representation are the 240 roots together with 8 zero weights (`dim E₈ = 240 + 8`, evaluated
on a Cartan element `F = diag(x)`, the zero weights contributing nothing for `k ≥ 1`), and,
if one wants the identity for all `F` rather than only for `F` in a Cartan subalgebra, the
Chevalley restriction theorem. Neither is formalised. The graph carries those steps
separately; this file is only the root-system arithmetic, which is what makes the *numbers*
`1/100` and `1/7200` come out.

Similarly, "these 240 vectors are exactly the roots of `E₈`" is here a *definition*
(the Humphreys list), not a theorem about a Lie algebra: no Lie theory is used or proved.

## Convention

No `α'`, no metric: this is Euclidean `ℚ⁸` with the standard inner product, and `α ⬝ x`
denotes `∑ i, α i * x i`.

## Graph nodes

`math.e8-adjoint-trace-identities` (target), used by `math.anomaly-twelve-form-factorization`
via `StringFormal.Math.GreenSchwarzAlgebra.gs_factorization_e8`.
-/

namespace StringFormal.Math.E8

open Finset

/-! ## The root list -/

/-- The 28 index pairs `i < j` of `Fin 8`. -/
def pairs28 : List (Fin 8 × Fin 8) :=
  [(0,1),(0,2),(0,3),(0,4),(0,5),(0,6),(0,7),
   (1,2),(1,3),(1,4),(1,5),(1,6),(1,7),
   (2,3),(2,4),(2,5),(2,6),(2,7),
   (3,4),(3,5),(3,6),(3,7),
   (4,5),(4,6),(4,7),
   (5,6),(5,7),
   (6,7)]

/-- `vroot i j a b` is the vector with `a` in slot `i`, `b` in slot `j` and `0` elsewhere
(for `i ≠ j`). -/
def vroot (i j : Fin 8) (a b : ℚ) : Fin 8 → ℚ :=
  fun k => (if k = i then a else 0) + (if k = j then b else 0)

/-- The 112 vector-type roots `± ε_i ± ε_j`, `i < j`. -/
def e8VectorRoots : List (Fin 8 → ℚ) :=
  pairs28.flatMap fun p =>
    [vroot p.1 p.2 1 1, vroot p.1 p.2 1 (-1), vroot p.1 p.2 (-1) 1, vroot p.1 p.2 (-1) (-1)]

/-- The eight sign patterns of length four with an **even** number of `-1`s. -/
def ev4 : List (Fin 4 → ℚ) :=
  [![1,1,1,1], ![1,1,-1,-1], ![1,-1,1,-1], ![1,-1,-1,1],
   ![-1,1,1,-1], ![-1,1,-1,1], ![-1,-1,1,1], ![-1,-1,-1,-1]]

/-- The eight sign patterns of length four with an **odd** number of `-1`s. -/
def od4 : List (Fin 4 → ℚ) :=
  [![1,1,1,-1], ![1,1,-1,1], ![1,-1,1,1], ![1,-1,-1,-1],
   ![-1,1,1,1], ![-1,1,-1,-1], ![-1,-1,1,-1], ![-1,-1,-1,1]]

/-- `spinRoot s t = ½ (s, t)`, the half of the concatenation of two four-element sign
patterns. -/
def spinRoot (s t : Fin 4 → ℚ) : Fin 8 → ℚ :=
  ![s 0 / 2, s 1 / 2, s 2 / 2, s 3 / 2, t 0 / 2, t 1 / 2, t 2 / 2, t 3 / 2]

/-- The 128 spinor-type roots `½ ∑ ± ε_i` with an even number of minus signs.

An eight-element sign pattern has an even number of minus signs iff its two halves have
the *same* parity, whence the two blocks below. -/
def e8SpinorRoots : List (Fin 8 → ℚ) :=
  (ev4.flatMap fun s => ev4.map fun t => spinRoot s t) ++
  (od4.flatMap fun s => od4.map fun t => spinRoot s t)

/-- The root system of `E₈`, as the explicit list of Humphreys §2.10. -/
def e8Roots : List (Fin 8 → ℚ) := e8VectorRoots ++ e8SpinorRoots

/-- `|Φ(E₈)| = 240 = 112 + 128`. -/
theorem e8Roots_length : e8Roots.length = 240 := by rfl

/-- `dim E₈ = |Φ| + rank = 240 + 8 = 248`: the dimension of the adjoint representation
used in the trace identities. (That `dim E₈` *is* `|Φ| + rank` is Lie theory and is not
proved here.) -/
theorem e8_dim_248 : e8Roots.length + 8 = 248 := by rfl

end StringFormal.Math.E8
