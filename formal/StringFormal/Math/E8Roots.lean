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


/-! ## Dot products with the two families of roots

Both families are handled by a rewrite that turns `∑ i, α i * x i` into a short linear
expression *before* any expansion, which is what keeps the degree-six computation below
within reach of `ring`. -/

/-- Contracting a vector-type root with `x` picks out two coordinates. (No hypothesis
`i ≠ j` is needed: `vroot` is a sum of two one-slot terms.) -/
theorem vroot_dot (i j : Fin 8) (a b : ℚ) (x : Fin 8 → ℚ) :
    (∑ k, vroot i j a b k * x k) = a * x i + b * x j := by
  simp [vroot, add_mul, Finset.sum_add_distrib, ite_mul]

/-- The standard pairing of four-element tuples. -/
def dot4 (s y : Fin 4 → ℚ) : ℚ := ∑ i, s i * y i

/-- The first four coordinates of `x : ℚ⁸`. -/
def fst4 (x : Fin 8 → ℚ) : Fin 4 → ℚ := ![x 0, x 1, x 2, x 3]

/-- The last four coordinates of `x : ℚ⁸`. -/
def snd4 (x : Fin 8 → ℚ) : Fin 4 → ℚ := ![x 4, x 5, x 6, x 7]

/-- Contracting a spinor-type root with `x` splits into the two halves. -/
theorem spinRoot_dot (s t : Fin 4 → ℚ) (x : Fin 8 → ℚ) :
    (∑ i, spinRoot s t i * x i) = (dot4 s (fst4 x) + dot4 t (snd4 x)) / 2 := by
  simp [spinRoot, dot4, fst4, snd4, Fin.sum_univ_eight, Fin.sum_univ_four]
  ring

/-- Sums over a `flatMap` regroup as iterated sums. (Mathlib has `Multiset.prod_join` but
no list-level version of this.) -/
theorem sum_map_flatMap {α β M : Type*} [AddCommMonoid M] (L : List α) (F : α → List β)
    (g : β → M) : (((L.flatMap F).map g).sum) = (L.map fun a => ((F a).map g).sum).sum := by
  induction L with
  | nil => simp
  | cons a L ih => simp [List.flatMap_cons, List.map_append, List.sum_append, ih]

/-! ## Power sums over the sign patterns of one half

`evenSum k y` and `oddSum k y` are the `k`-th power sums of `s ⬝ y` over the eight even
(resp. odd) sign patterns `s ∈ {±1}⁴`. Both families are stable under `s ↦ -s`
(negating all four signs changes the number of minus signs from `m` to `4 - m`, preserving
its parity), so all *odd* power sums vanish; the `inner_*` lemmas below record the
resulting binomial expansions, and it is `ring` that verifies the cancellation. -/

/-- `k`-th power sum over the eight even sign patterns. -/
def evenSum (k : ℕ) (y : Fin 4 → ℚ) : ℚ := (ev4.map fun s => (dot4 s y) ^ k).sum

/-- `k`-th power sum over the eight odd sign patterns. -/
def oddSum (k : ℕ) (y : Fin 4 → ℚ) : ℚ := (od4.map fun s => (dot4 s y) ^ k).sum

set_option maxHeartbeats 1000000 in
theorem inner_ev_two (A : ℚ) (y : Fin 4 → ℚ) :
    (ev4.map fun t => ((A + dot4 t y) / 2) ^ 2).sum = (8 * A ^ 2 + evenSum 2 y) / 4 := by
  simp only [ev4, evenSum, dot4, List.map_cons, List.map_nil, List.sum_cons, List.sum_nil,
    Fin.sum_univ_four, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.tail_cons]
  ring

set_option maxHeartbeats 1000000 in
theorem inner_od_two (A : ℚ) (y : Fin 4 → ℚ) :
    (od4.map fun t => ((A + dot4 t y) / 2) ^ 2).sum = (8 * A ^ 2 + oddSum 2 y) / 4 := by
  simp only [od4, oddSum, dot4, List.map_cons, List.map_nil, List.sum_cons, List.sum_nil,
    Fin.sum_univ_four, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.tail_cons]
  ring

set_option maxHeartbeats 1000000 in
theorem inner_ev_four (A : ℚ) (y : Fin 4 → ℚ) :
    (ev4.map fun t => ((A + dot4 t y) / 2) ^ 4).sum
      = (8 * A ^ 4 + 6 * A ^ 2 * evenSum 2 y + evenSum 4 y) / 16 := by
  simp only [ev4, evenSum, dot4, List.map_cons, List.map_nil, List.sum_cons, List.sum_nil,
    Fin.sum_univ_four, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.tail_cons]
  ring

set_option maxHeartbeats 1000000 in
theorem inner_od_four (A : ℚ) (y : Fin 4 → ℚ) :
    (od4.map fun t => ((A + dot4 t y) / 2) ^ 4).sum
      = (8 * A ^ 4 + 6 * A ^ 2 * oddSum 2 y + oddSum 4 y) / 16 := by
  simp only [od4, oddSum, dot4, List.map_cons, List.map_nil, List.sum_cons, List.sum_nil,
    Fin.sum_univ_four, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.tail_cons]
  ring

set_option maxHeartbeats 1000000 in
theorem inner_ev_six (A : ℚ) (y : Fin 4 → ℚ) :
    (ev4.map fun t => ((A + dot4 t y) / 2) ^ 6).sum
      = (8 * A ^ 6 + 15 * A ^ 4 * evenSum 2 y + 15 * A ^ 2 * evenSum 4 y + evenSum 6 y) / 64 := by
  simp only [ev4, evenSum, dot4, List.map_cons, List.map_nil, List.sum_cons, List.sum_nil,
    Fin.sum_univ_four, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.tail_cons]
  ring

set_option maxHeartbeats 1000000 in
theorem inner_od_six (A : ℚ) (y : Fin 4 → ℚ) :
    (od4.map fun t => ((A + dot4 t y) / 2) ^ 6).sum
      = (8 * A ^ 6 + 15 * A ^ 4 * oddSum 2 y + 15 * A ^ 2 * oddSum 4 y + oddSum 6 y) / 64 := by
  simp only [od4, oddSum, dot4, List.map_cons, List.map_nil, List.sum_cons, List.sum_nil,
    Fin.sum_univ_four, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.tail_cons]
  ring

/-! ## The two blocks separately

Neither block is proportional to `(∑ x_i²)^(k/2)` on its own; only their sum is. Writing
`p_k = ∑_i x_i^k`, the identities `∑_{i≠j} x_i⁴x_j² = p₂p₄ − p₆` and
`∑_{i<j<l} x_i²x_j²x_l² = (p₂³ − 3p₂p₄ + 2p₆)/6` have been folded into the statements. -/

set_option maxHeartbeats 1000000 in
/-- `∑_{α vector type} (α ⬝ x)² = 28 p₂`. -/
theorem vectorRoots_power_sum_two (x : Fin 8 → ℚ) :
    (e8VectorRoots.map fun α => (∑ i, α i * x i) ^ 2).sum = 28 * (∑ i, x i ^ 2) := by
  simp only [e8VectorRoots, pairs28, List.flatMap_cons, List.flatMap_nil, List.map_cons,
    List.map_nil, List.map_append, List.sum_append, List.sum_cons, List.sum_nil,
    List.append_nil, vroot_dot]
  rw [Fin.sum_univ_eight]
  ring

set_option maxHeartbeats 1000000 in
/-- `∑_{α vector type} (α ⬝ x)⁴ = 16 p₄ + 12 p₂²`. -/
theorem vectorRoots_power_sum_four (x : Fin 8 → ℚ) :
    (e8VectorRoots.map fun α => (∑ i, α i * x i) ^ 4).sum
      = 16 * (∑ i, x i ^ 4) + 12 * (∑ i, x i ^ 2) ^ 2 := by
  simp only [e8VectorRoots, pairs28, List.flatMap_cons, List.flatMap_nil, List.map_cons,
    List.map_nil, List.map_append, List.sum_append, List.sum_cons, List.sum_nil,
    List.append_nil, vroot_dot]
  rw [Fin.sum_univ_eight, Fin.sum_univ_eight]
  ring

set_option maxHeartbeats 1000000 in
/-- `∑_{α vector type} (α ⬝ x)⁶ = 60 p₂p₄ − 32 p₆`. -/
theorem vectorRoots_power_sum_six (x : Fin 8 → ℚ) :
    (e8VectorRoots.map fun α => (∑ i, α i * x i) ^ 6).sum
      = 60 * (∑ i, x i ^ 2) * (∑ i, x i ^ 4) - 32 * (∑ i, x i ^ 6) := by
  simp only [e8VectorRoots, pairs28, List.flatMap_cons, List.flatMap_nil, List.map_cons,
    List.map_nil, List.map_append, List.sum_append, List.sum_cons, List.sum_nil,
    List.append_nil, vroot_dot]
  rw [Fin.sum_univ_eight, Fin.sum_univ_eight, Fin.sum_univ_eight]
  ring

set_option maxHeartbeats 1000000 in
/-- `∑_{α spinor type} (α ⬝ x)² = 32 p₂`. -/
theorem spinorRoots_power_sum_two (x : Fin 8 → ℚ) :
    (e8SpinorRoots.map fun α => (∑ i, α i * x i) ^ 2).sum = 32 * (∑ i, x i ^ 2) := by
  simp only [e8SpinorRoots, List.map_append, List.sum_append, sum_map_flatMap, List.map_map,
    Function.comp_def, spinRoot_dot, inner_ev_two, inner_od_two]
  simp only [evenSum, oddSum, ev4, od4, List.map_cons, List.map_nil, List.sum_cons,
    List.sum_nil]
  simp only [dot4, fst4, snd4, Fin.sum_univ_four, Matrix.cons_val_zero, Matrix.cons_val_one,
    Matrix.head_cons, Matrix.cons_val_two, Matrix.cons_val_three, Matrix.tail_cons]
  rw [Fin.sum_univ_eight]
  ring

set_option maxHeartbeats 1000000 in
/-- `∑_{α spinor type} (α ⬝ x)⁴ = 24 p₂² − 16 p₄`. -/
theorem spinorRoots_power_sum_four (x : Fin 8 → ℚ) :
    (e8SpinorRoots.map fun α => (∑ i, α i * x i) ^ 4).sum
      = 24 * (∑ i, x i ^ 2) ^ 2 - 16 * (∑ i, x i ^ 4) := by
  simp only [e8SpinorRoots, List.map_append, List.sum_append, sum_map_flatMap, List.map_map,
    Function.comp_def, spinRoot_dot, inner_ev_four, inner_od_four]
  simp only [evenSum, oddSum, ev4, od4, List.map_cons, List.map_nil, List.sum_cons,
    List.sum_nil]
  simp only [dot4, fst4, snd4, Fin.sum_univ_four, Matrix.cons_val_zero, Matrix.cons_val_one,
    Matrix.head_cons, Matrix.cons_val_two, Matrix.cons_val_three, Matrix.tail_cons]
  rw [Fin.sum_univ_eight, Fin.sum_univ_eight]
  ring

set_option maxHeartbeats 2000000 in
/-- `∑_{α spinor type} (α ⬝ x)⁶ = 30 p₂³ − 60 p₂p₄ + 32 p₆`. -/
theorem spinorRoots_power_sum_six (x : Fin 8 → ℚ) :
    (e8SpinorRoots.map fun α => (∑ i, α i * x i) ^ 6).sum
      = 30 * (∑ i, x i ^ 2) ^ 3 - 60 * (∑ i, x i ^ 2) * (∑ i, x i ^ 4)
        + 32 * (∑ i, x i ^ 6) := by
  simp only [e8SpinorRoots, List.map_append, List.sum_append, sum_map_flatMap, List.map_map,
    Function.comp_def, spinRoot_dot, inner_ev_six, inner_od_six]
  simp only [evenSum, oddSum, ev4, od4, List.map_cons, List.map_nil, List.sum_cons,
    List.sum_nil]
  simp only [dot4, fst4, snd4, Fin.sum_univ_four, Matrix.cons_val_zero, Matrix.cons_val_one,
    Matrix.head_cons, Matrix.cons_val_two, Matrix.cons_val_three, Matrix.tail_cons]
  rw [Fin.sum_univ_eight, Fin.sum_univ_eight, Fin.sum_univ_eight]
  ring

/-! ## The power sums of the whole root system -/

/-- `e8PowerSum k x = ∑_{α ∈ Φ(E₈)} (α ⬝ x)^k`. -/
def e8PowerSum (k : ℕ) (x : Fin 8 → ℚ) : ℚ :=
  (e8Roots.map fun α => (∑ i, α i * x i) ^ k).sum

theorem e8PowerSum_split (k : ℕ) (x : Fin 8 → ℚ) :
    e8PowerSum k x = (e8VectorRoots.map fun α => (∑ i, α i * x i) ^ k).sum
      + (e8SpinorRoots.map fun α => (∑ i, α i * x i) ^ k).sum := by
  simp [e8PowerSum, e8Roots, List.map_append, List.sum_append]

/-- **`k = 2`.** `∑_{α ∈ Φ(E₈)} (α ⬝ x)² = 60 ∑_i x_i²`. The `60` is the index of the
adjoint representation of `E₈` (`2h^∨ = 60`); cf. van Ritbergen–Schellekens–Vermaseren
Table 3, `I₂ = 60`. -/
theorem e8_power_sum_two (x : Fin 8 → ℚ) : e8PowerSum 2 x = 60 * (∑ i, x i ^ 2) := by
  rw [e8PowerSum_split, vectorRoots_power_sum_two, spinorRoots_power_sum_two]; ring

/-- **`k = 4`.** `∑_{α ∈ Φ(E₈)} (α ⬝ x)⁴ = 36 (∑_i x_i²)²`: the fourth power sum is a
square, which is the root-system shadow of "`E₈` has no independent fourth-order Casimir
invariant". -/
theorem e8_power_sum_four (x : Fin 8 → ℚ) : e8PowerSum 4 x = 36 * (∑ i, x i ^ 2) ^ 2 := by
  rw [e8PowerSum_split, vectorRoots_power_sum_four, spinorRoots_power_sum_four]; ring

/-- **`k = 6`.** `∑_{α ∈ Φ(E₈)} (α ⬝ x)⁶ = 30 (∑_i x_i²)³`: likewise for the sixth order. -/
theorem e8_power_sum_six (x : Fin 8 → ℚ) : e8PowerSum 6 x = 30 * (∑ i, x i ^ 2) ^ 3 := by
  rw [e8PowerSum_split, vectorRoots_power_sum_six, spinorRoots_power_sum_six]; ring

/-! ## The trace identities

Under the hypothesis discussed in the module docstring — `Tr_248 F^k = ∑_{α ∈ Φ} (α ⬝ x)^k`
for `F` the Cartan element `diag(x)` and `k ≥ 1` — the following are Green–Schwarz (1984)
eqs. (12b′)(12c′) and van Ritbergen–Schellekens–Vermaseren (1998) eqs. (176)(177). What is
added here over `e8_power_sum_*` is only that the normalisation-dependent factor `∑ x_i²`
cancels, leaving the pure numbers `1/100` and `1/7200`. -/

/-- **GS (12b′) / vRSV (176)**: `Tr F⁴ = (1/100)(Tr F²)²`. -/
theorem e8_trace_four (x : Fin 8 → ℚ) :
    e8PowerSum 4 x = (1 / 100) * (e8PowerSum 2 x) ^ 2 := by
  rw [e8_power_sum_four, e8_power_sum_two]; ring

/-- **GS (12c′) / vRSV (177)**: `Tr F⁶ = (1/7200)(Tr F²)³`. -/
theorem e8_trace_six (x : Fin 8 → ℚ) :
    e8PowerSum 6 x = (1 / 7200) * (e8PowerSum 2 x) ^ 3 := by
  rw [e8_power_sum_six, e8_power_sum_two]; ring

/-- The two `E₈` trace identities of Green–Schwarz (1984), (12b′)(12c′), in one statement:
with `Ω₄ = Tr F²`, `Ω₈ = Tr F⁴`, `Ω₁₂ = Tr F⁶` evaluated on a Cartan element,
`Ω₈ = Ω₄²/100` and `Ω₁₂ = Ω₄³/7200`. These are exactly the two coefficients fed to
`StringFormal.Math.gs_factorization_e8`. -/
theorem e8_trace_identities (x : Fin 8 → ℚ) :
    e8PowerSum 4 x = (1 / 100) * (e8PowerSum 2 x) ^ 2 ∧
      e8PowerSum 6 x = (1 / 7200) * (e8PowerSum 2 x) ^ 3 :=
  ⟨e8_trace_four x, e8_trace_six x⟩

end StringFormal.Math.E8
