/-
# Green–Schwarz anomaly cancellation: the purely algebraic content

Lean island 2 (seed). This file isolates the parts of Green–Schwarz (1984) that are
*pure algebra / arithmetic*, with no differential geometry, no index theory, and no
anomaly polynomial machinery. Everything physical lives in the graph, not here.

Status: seed. Contains only the module header; theorems land in follow-up commits.

Graph nodes this file is intended to serve (`formal.lean_decl` links to be filled in
as each declaration compiles):

* the factorisation of the twelve-form anomaly polynomial into `X₄ ∧ X₈`, once the
  trace identities are *assumed*;
* the mixed gauge/gravitational trace conditions that pin the gauge group rank;
* the sign/vanishing arithmetic for the `tr F⁶` coefficient.

## What this file does NOT prove

The trace identities themselves (e.g. `Tr F⁴ = (1/300)(Tr F²)² + ...` for `SO(32)`,
and the `E₈ × E₈` analogues) are Lie-theoretic facts about the specific groups and
are separate graph nodes. Here they enter only as the *numerical coefficients* that
are written into the statements by hand.
-/

namespace StringFormal

end StringFormal
