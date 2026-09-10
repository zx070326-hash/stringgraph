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

end StringFormal.Math
