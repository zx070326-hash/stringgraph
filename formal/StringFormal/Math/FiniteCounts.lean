/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import Mathlib.Data.Nat.Choose.Sum

/-!
# Finite decidable counts appearing in string consistency arguments

Lean island 2, arithmetic corner. Everything here is a *finite, decidable* computation:
the statements are closed formulas over explicit finite index sets, settled by `decide`.
No physics enters; the physics is carried by the graph nodes named in each docstring,
which quote these numbers.

This file imports only Mathlib.

## Contents

* `hexagon_odd_twist_count` — graph node `math.hexagon-odd-twist-count`.
-/

namespace StringFormal.Math

open Finset

/-- **The "32" of the type I hexagon.**

In the hexagon anomaly diagram of Green–Schwarz (1984) each of the six internal
open-string propagators of the hexagon may or may not be twisted, and the diagrams
contributing to the non-orientable amplitude are those with an **odd** number of twisted
internal lines. The number of such twist assignments is
`∑_{k odd, k ≤ 6} C(6, k) = C(6,1) + C(6,3) + C(6,5) = 6 + 20 + 6 = 32`,
the relative factor `32` between the planar and non-orientable hexagons, i.e. the factor
that singles out `n = 32` for `SO(n)` (Green–Schwarz 1984, eq. (12c); GSW vol. 2, p. 165).

The identity is the odd half of the binomial theorem: `∑_{k odd} C(n,k) = 2^(n-1)` for
`n ≥ 1`, here `2^5 = 32`. Only the arithmetic is formalised; that this count is the
combinatorial origin of the coefficient in (12c) is the content of the graph node
`math.hexagon-odd-twist-count` and is *not* proved here. -/
theorem hexagon_odd_twist_count :
    ∑ k ∈ (range 7).filter Odd, Nat.choose 6 k = 32 := by
  decide

end StringFormal.Math
