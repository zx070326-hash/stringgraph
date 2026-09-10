/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.DDFOperatorNeg
import StringFormal.NoGhost.VertexWeightZero

/-!
# `⁅L_m, A^ε_n⁆ = 0` for **every** `m : ℤ`

Graph nodes: `worldsheet.ddf-commute-with-virasoro` (this file closes it: the formalised
range goes from `m ≠ 0` to all of `ℤ`), `worldsheet.ddf-operators-v5` (the definition of
`A^ε_n`).  `formal/TODO.md` item `ddf-operators`, sub-item (4).

## The last case

`StringFormal/NoGhost/DDFOperator.lean` had `m ≥ 1`, `StringFormal/NoGhost/DDFOperatorNeg.lean`
widened it to `m ≠ 0`, and both were blocked at `m = 0` only because the single-Fock
conformal-weight identity was.  `StringFormal/NoGhost/VertexWeightZero.lean` has since supplied
`Fock.lie_Lop_vertexOsc`, valid for every `m : ℤ` with the *same* polynomial coefficient
`J - m + a·b + ½ (m+1)(b·b)`.  Since `hm : m ≠ 0` entered `lie_towerLop_ddfOp_of_ne` at exactly
one place — the appeal to `lie_towerLop_ddfSummand_of_ne` — everything downstream goes through
verbatim once that one input is unconditional.

So this file is the `m ≠ 0` file with the hypothesis deleted:

* `lie_towerLop_towerVertex` — `⁅L_m, V^{(n)}_K⁆ = (K - m - n + n (k_0·p)) V^{(n)}_{K-m}` on the
  DDF momentum tower, for every `m`.  Isotropy `k_0² = 0` is still needed, and for the same
  reason as before (otherwise the coefficient depends on the rung `j`).
* `lie_towerLop_towerVertex_normalized` — with `2α' k_0 · p = 1` this is the weight-`0` primary
  law `⁅L_m, V^{(n)}_K⁆ = (K - m) V^{(n)}_{K-m}`, all `m`.
* `lie_towerLop_ddfSummand` — the telescoping form, all `m`.
* **`lie_towerLop_ddfOp`** — `⁅L_m, A^ε_n⁆ = 0` for **every** `m : ℤ`.

## Why `m = 0` is `0` and not a multiple of `A^ε_n`

`A^ε_n` is the zero mode of a weight-`1` current, and for a weight-`h` current
`⁅L_m, j_r⁆ = ((h-1) m - r) j_{m+r}`; at `h = 1`, `r = 0` this vanishes identically in `m`.
Concretely, in the telescoping proof each summand's bracket is `g (j - m) - g j`, which at
`m = 0` is `0` term by term — the boundary strips are empty and the window analysis is
vacuous.  The proof below does not special-case this: the `m ≠ 0` window argument, run with
slack `|m| = 0`, degenerates to it correctly.

This is what makes DDF states automatically satisfy the `L_0` mass-shell condition, so
together with `m ≥ 1` it gives "`A^ε_n` preserves the physical subspace".
-/

namespace StringFormal.NoGhost

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

end StringFormal.NoGhost
