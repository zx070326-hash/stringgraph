/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

/-!
# Green–Schwarz anomaly cancellation: the purely algebraic content

Lean island 2 (seed). This is a standalone island: it imports only Mathlib and nothing
from `StringFormal`. It isolates the parts of Green–Schwarz (1984) that are *pure algebra
or pure arithmetic* — no differential forms, no index theory, no anomaly-polynomial
machinery. All the physics lives in the graph, not here.

Convention: `conv.gauge-trace-normalization` (the graph's normalisation of gauge traces).

## Contents

* `gs_factorization_so32`, `gs_factorization_e8`, `gs_factorization_nested_eq_expanded` —
  graph node `math.anomaly-twelve-form-factorization`.
* `mixed_anomaly_trace_conditions_n32`, `mixed_anomaly_no_solution_l_one` —
  graph node `math.mixed-anomaly-trace-conditions-n32`.
* `tr_f6_coefficient_vanishing`, `tr_f6_usp_positive` —
  graph node `math.tr-f6-coefficient-vanishing`.

## What this file does NOT prove

The trace identities themselves — `math.so-usp-adjoint-fundamental-trace-identities`
(the `so(N)`/`usp(N)` adjoint-vs-fundamental relations carrying the parameter `l = ∓1`)
and `math.e8-adjoint-trace-identities` — are Lie-theoretic facts about the specific
algebras, and are **separate graph nodes**. Here they enter only through the *numerical
coefficients hard-coded into the statements below*. Likewise, why these particular
equations are the anomaly-cancellation conditions is physics, carried by
`consistency.anomaly-cancellation-so32-effective-theory`; the statements here take the
equations as given.
-/

namespace StringFormal.Math

/-! ### Mixed gauge/gravitational anomaly: the trace conditions force `N = 32`

Graph node `math.mixed-anomaly-trace-conditions-n32`. Green–Schwarz (1984), PLB p.120
(reprint 611), the sentence after (22)(23): "The cancellation requires that `N + 8l = 24`
and `N + 2l = 30` in eq. (12)." GS assert the two equations and do not solve them; that
step is what is made explicit here.
-/

/-- The two mixed-anomaly trace conditions `N + 8l = 24` and `N + 2l = 30` have the
unique integer solution `(N, l) = (32, -1)`, i.e. `so(32)`.

In the notation of `math.so-usp-adjoint-fundamental-trace-identities`, `l = -1` selects
`so(N)` and `l = +1` selects `usp(N)`; so the unique solution lies on the `so` branch.
Specialising `l = -1` in each equation separately gives `N - 8 = 24` and `N - 2 = 30`,
*each* of which yields `N = 32` on its own — this is the arithmetic content of the
"two independent confirmations" of GS. -/
theorem mixed_anomaly_trace_conditions_n32 (N l : ℤ)
    (h₁ : N + 8 * l = 24) (h₂ : N + 2 * l = 30) : N = 32 ∧ l = -1 := by
  omega

/-- On the `usp(N)` branch (`l = +1`) the two mixed-anomaly conditions are inconsistent:
they demand `N = 16` and `N = 28` simultaneously. So no symplectic gauge algebra passes
the mixed-anomaly test.

(GS never write this conclusion out; it is a consequence of their (12)(13). The graph
records the corresponding edge as `inferred`.) -/
theorem mixed_anomaly_no_solution_l_one : ¬ ∃ N : ℤ, N + 8 = 24 ∧ N + 2 = 30 := by
  rintro ⟨N, h₁, h₂⟩
  omega

/-! ### The `tr F⁶` coefficient `N + 32l`

Graph node `math.tr-f6-coefficient-vanishing`. In `Ω₁₂ = (N + 32l) tr F⁶ + 15 tr F² tr F⁴`
the coefficient of `tr F⁶` is `N + 32l`. GS (1984) PLB p.119 (reprint 610), (12c) with
(13a)(13b): the first term of (12c) "corresponds to anomalies that cannot be cancelled by
the addition of local interactions to the effective action. However, it is absent if the
gauge group is chosen to be `SO(32)`."

This is the only algebraic entry point to "why 32" along the pure gauge-anomaly route.
-/

/-- `so(N)` branch (`l = -1`): the `tr F⁶` coefficient `N + 32·(-1) = N - 32` vanishes
**iff** `N = 32`. GS state only the `←` direction ("absent if the gauge group is
`SO(32)`"); the converse is read off the linear coefficient. -/
theorem tr_f6_coefficient_vanishing (N : ℤ) : N + 32 * (-1) = 0 ↔ N = 32 := by
  omega

/-- `usp(N)` branch (`l = +1`): the `tr F⁶` coefficient is `N + 32 ≥ 33 > 0`, hence never
vanishes for any `N ≥ 1`. So the offending anomaly is present for every symplectic gauge
algebra. -/
theorem tr_f6_usp_positive (N : ℤ) (hN : 1 ≤ N) : 0 < N + 32 := by
  omega


/-! ### The twelve-form factorisation `Ω₁₂ = (1/48) Ω₄ [Ω₈ − (1/300) Ω₄²]`

Graph node `math.anomaly-twelve-form-factorization`. GS (1984) PLB p.120 (reprint 611),
eq. (19), stated there in exactly this nested form and with no proof.

**Read the scope carefully.** These are identities about the *specific polynomial
expressions written into the statements*, valid for all `x, y` in a field of
characteristic zero (equivalently: formal identities in `ℚ[x, y]`). They are **not**
theorems about abstract Lie algebras. The step "for `so(32)` the invariants really are
`Ω₄ = 30 tr F²`, `Ω₈ = 24 tr F⁴ + 3 (tr F²)²`, `Ω₁₂ = 15 tr F² tr F⁴`" is the content of
`math.so-usp-adjoint-fundamental-trace-identities` (together with
`tr_f6_coefficient_vanishing` above, which kills the `tr F⁶` term at `N = 32`), and
"for `E₈`, `Tr F⁴` and `Tr F⁶` are determined by `Tr F²`" is
`math.e8-adjoint-trace-identities`. Both are independent graph nodes; here their output
appears only as hard-coded rational coefficients. Nothing here asserts any uniqueness or
classification statement ("only `SO(32)` and `E₈ × E₈` factorise" is *not* a
Green–Schwarz 1984 result, see the node's `notes`).

A characteristic-zero *field* is assumed only so that `48⁻¹`, `300⁻¹`, `/100`, `/7200`
denote what they should; the coefficients are rational, so this loses nothing. -/

section Factorization

variable {K : Type*} [Field K] [CharZero K]

/-- **`SO(32)` branch of the GS factorisation.** With
`Ω₄ = 30 x`, `Ω₈ = 24 y + 3 x²`, `Ω₁₂ = 15 x y` (where `x = tr F²`, `y = tr F⁴`, and the
`tr F⁶` term has already dropped out because `N + 32l = 0` at `N = 32`, `l = -1`):

  `Ω₁₂ = (1/48) · Ω₄ · (Ω₈ − (1/300) · Ω₄²)`.

The mechanism is that `(1/300) Ω₄² = (1/300)(30x)² = 3x²` exactly cancels the `3x²` in
`Ω₈`, leaving `(1/48)(30x)(24y) = 15xy`. -/
theorem gs_factorization_so32 (x y : K) :
    15 * x * y = 48⁻¹ * (30 * x) * ((24 * y + 3 * x ^ 2) - 300⁻¹ * (30 * x) ^ 2) := by
  have h48 : (48 : K) ≠ 0 := by norm_num
  have h300 : (300 : K) ≠ 0 := by norm_num
  field_simp
  ring

/-- **`E₈` branch of the GS factorisation.** With `Ω₄ = x`, `Ω₈ = x²/100`,
`Ω₁₂ = x³/7200` (where `x = Tr F² = tr F²`):

  `Ω₁₂ = (1/48) · Ω₄ · (Ω₈ − (1/300) · Ω₄²)`.

Here nothing cancels: `x²/100 − x²/300 = x²/150`, and `(1/48)·x·(x²/150) = x³/7200`. -/
theorem gs_factorization_e8 (x : K) :
    x ^ 3 / 7200 = 48⁻¹ * x * (x ^ 2 / 100 - 300⁻¹ * x ^ 2) := by
  have h100 : (100 : K) ≠ 0 := by norm_num
  have h300 : (300 : K) ≠ 0 := by norm_num
  have h7200 : (7200 : K) ≠ 0 := by norm_num
  field_simp
  ring

/-- The nested form of the factorisation and the expanded form
`Ω₁₂ = (1/48) Ω₄ Ω₈ − (1/14400) Ω₄³` agree, for arbitrary `Ω₄`, `Ω₈`.

GS (1984) write the nested form; the expanded form is the one usually quoted second-hand.
This lemma says the two are the same identity, so neither branch above depends on which
form the graph node records. -/
theorem gs_factorization_nested_eq_expanded (Ω₄ Ω₈ : K) :
    48⁻¹ * Ω₄ * (Ω₈ - 300⁻¹ * Ω₄ ^ 2) = 48⁻¹ * Ω₄ * Ω₈ - 14400⁻¹ * Ω₄ ^ 3 := by
  have h48 : (48 : K) ≠ 0 := by norm_num
  have h300 : (300 : K) ≠ 0 := by norm_num
  have h14400 : (14400 : K) ≠ 0 := by norm_num
  field_simp
  ring

end Factorization

end StringFormal.Math
