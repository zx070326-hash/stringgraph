/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.TowerPairing
import StringFormal.NoGhost.VertexOperator
import StringFormal.NoGhost.DDFOperator

/-!
# The adjoint of the vertex operator for the Fock and tower forms

Graph nodes: `worldsheet.vertex-operator-adjoint`, `worldsheet.ddf-operators-adjoint`.
This file closes gap (3) of `StringFormal/NoGhost/VertexOperator.lean` and gap (2) of
`StringFormal/NoGhost/TowerPairing.lean`.

## Status

Skeleton only; see the git history of this file for what is actually proved.  No `sorry`.
-/
