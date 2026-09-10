/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.DDF

/-!
# Vertex operators with orthogonal momenta commute

Graph node: `worldsheet.ddf-transverse-oscillator-algebra`; `formal/TODO.md` item
`ddf-operators`, sub-item (5).  This is the **first step** towards the DDF transverse
oscillator algebra `[A^ε_m, A^δ_n] = m (ε·δ) δ_{m+n,0}`: before one can compute the bracket
of two DDF operators one needs to know that the two vertex operators
`V^{(m)}(z) = :e^{i m k_0·X}:` and `V^{(n)}(w) = :e^{i n k_0·X}:` entering them commute,
which for a light-like reference vector (`k_0² = 0`) they do, *without* any `z ≠ w`
prescription and without normal-ordering corrections.

## Conventions

`conv.metric-mostly-plus`, `conv.alpha-prime-regge`, as in `StringFormal/NoGhost/DDF.lean`;
`b^μ = (2α')^{1/2} c^μ` is the rescaled vertex momentum of
`StringFormal/NoGhost/VertexOperator.lean`, and `dotVec η x y = Σ_μ η_μ x^μ y^μ` is the
spacetime contraction of `StringFormal/NoGhost/DDF.lean`.

## Status

Skeleton: contents are added one declaration per commit.  No `sorry` at any point.
-/

namespace StringFormal.NoGhost

open MvPolynomial

namespace Fock

end Fock

end StringFormal.NoGhost
