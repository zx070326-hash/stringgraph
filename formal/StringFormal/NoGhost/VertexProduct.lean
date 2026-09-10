/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.VertexCommute
import StringFormal.NoGhost.DDFOperator

/-!
# Same-point product of vertex operators with orthogonal momenta

Graph node: `worldsheet.ddf-transverse-oscillator-algebra`; `formal/TODO.md` item
`ddf-operators`, sub-item (5a).

Target: for `b · b' = 0`,
`∑_{J + K = L} V^{(b)}_J V^{(b')}_K = V^{(b+b')}_L`,
i.e. the two exponential vertex operators may be multiplied at the same point and the
result is the vertex operator of the summed momentum.  This is the input to (5b), the
weighted sum `∑_j j V^{(m)}_j V^{(n)}_{-j} = m δ_{m+n,0}` which *is* the DDF bracket.

## Status

Work in progress; this header records what is present.  No `sorry`.
-/

namespace StringFormal.NoGhost

namespace Fock

end Fock

end StringFormal.NoGhost
