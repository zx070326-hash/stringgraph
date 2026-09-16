/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.LevelFiveCount

/-!
# The level-seven counting identity

This file establishes the counting identity for `N = 7`, filling in with real proofs the
skeleton drafted in `research/attempts/level-n-count-generalization/scratch.lean` (three
theorem statements, verified numerically and by an independent `graph-reviewer` pass —
see `research/attempts/level-n-count-generalization/{claim,proof}.md` and `status.yaml`,
`state: verified`).

## The ten-shape closed form

`p(7) = 15`, grouped into **ten** distinct partition shapes:

`p_m(7) = m + 3m² + 3m·C(m+1,2) + m³ + 2m·C(m+2,3) + m²·C(m+1,2) + m·C(m+3,4)
          + C(m+1,2)·C(m+2,3) + m·C(m+4,5) + C(m+6,7)`

(shapes `[7] [6,1] [5,2] [5,1,1] [4,3] [4,2,1] [4,1,1,1] [3,3,1] [3,2,1,1] [3,1,1,1,1,1]`
reversed — full shape-by-partition correspondence table in
`research/attempts/level-n-count-generalization/claim.md`).

## The recursive form

As at `N = 5, 6`, the "clean" Pascal recursion `p_{m+1}(N) = p_m(N) + p_{m+1}(N−1) +
p_{m+1}(N−2)` that holds unconditionally for `N ≤ 4` needs a correction term
`κ_N(m) := p_m(N) + p_{m+1}(N−1) + p_{m+1}(N−2) − p_{m+1}(N)`. This file proves

`p_{m+1}(7) + C(m+3,2) = p_m(7) + p_{m+1}(6) + p_{m+1}(5)`,

i.e. `κ_7(m) = C(m+3,2)` — **not a constant** (`κ_5 = 1` is constant, `κ_6(m) = m+1` and
`κ_7(m) = C(m+3,2)` both grow with `m`; `κ_6` is the first `N` where this happens). See
`research/attempts/level-n-count-generalization/proof.md` §3 for the derivation of
`κ_7(m) = C(m+3,2)` from Euler's pentagonal-number correction terms `Δ(5) = Δ(6) = 1`,
`Δ(7) = 3` (computed directly from `p(0..7)`, no general pentagonal-number theorem needed).

`p_m(6)` here is the **corrected** ten-term formula of
`LevelSixCount.levelSix_count_identity_gen` (inlined afresh, not imported — this file does
not `import StringFormal.NoGhost.LevelSixCount`, matching the scratch draft's reasoning:
at drafting time that file was broken; it has since been fixed at commit `f45fe14` and
builds cleanly, but there is no benefit to importing it here since its own theorem is an
*equation* relating `p_{m+1}(6)` to `p_m(6)/p_{m+1}(5)/p_{m+1}(4)`, not a standalone
definition of `p_x(6)` that could be reused as a term).

## Contents

* `levelSeven_count_identity_gen` — the `m`-form identity (all `m`).
* `levelSeven_count_identity` — specialisation at `m = D − 2`.
* `levelSeven_count_identity_full` — specialisation at `m = D − 1`.

## Status

The three theorems compile with no `sorry`. Proof strategy for `_gen`: six
`Nat.choose_succ_succ` Pascal-rule rewrites (`h2 .. h7`) collapse every `Nat.choose (m+k+1) k`
appearing in the `p_{m+1}(·)` summands down to the primitive atoms `Nat.choose (m+1) 2`,
`Nat.choose (m+2) 3`, ..., `Nat.choose (m+6) 7` shared with `p_m(7)`/`p_m(6)`/`p_m(5)`
themselves, after which `ring` closes the resulting polynomial identity — the same pattern
as `LevelFiveCount.levelFive_count_identity_gen` and (the fixed)
`LevelSixCount.levelSix_count_identity_gen`, extended by one more Pascal level (`h7`, for
the new `Nat.choose (m+7) 7` atom that appears at `N = 7`).

**Not done**: `b26_seven`, `ddfSpans_bigrade_neg_seven_seven`, or any other components of
the level-seven slice (`N ≥ 6` needs the seed-condition argument of blueprint §B⁗.7, not
attempted anywhere in the repository yet).
-/

namespace StringFormal.NoGhost

/-! ### The level-seven counting identity

Everything here is arithmetic in `ℕ`; `D` never appears, only the number `m` of directions. -/

section CountIdentity

/-- **The level-seven counting identity**, in the recursive form free of natural subtraction:

`p_{m+1}(7) + C(m+3,2) = p_m(7) + p_{m+1}(6) + p_{m+1}(5)`

with the ten-term `p_m(7) = m + 3m² + 3m·C(m+1,2) + m³ + 2m·C(m+2,3) + m²·C(m+1,2)
+ m·C(m+3,4) + C(m+1,2)·C(m+2,3) + m·C(m+4,5) + C(m+6,7)`, `p_m(6)` the corrected ten-term
formula of `LevelSixCount.levelSix_count_identity_gen` (inlined, see file docstring), and
`p_m(5)` as in `LevelFiveCount.levelFive_count_identity_gen`.

The proof expands the binomial coefficients `Nat.choose (m+2) 2 .. Nat.choose (m+7) 7` down
to the primitive atoms `Nat.choose (m+1) 2 .. Nat.choose (m+6) 7` shared with the `p_m`
formulas, then `ring`. -/
theorem levelSeven_count_identity_gen (m : ℕ) :
    ((m + 1) + 3 * ((m + 1) * (m + 1)) + 3 * ((m + 1) * Nat.choose (m + 2) 2)
        + (m + 1) * (m + 1) * (m + 1) + 2 * ((m + 1) * Nat.choose (m + 3) 3)
        + (m + 1) * (m + 1) * Nat.choose (m + 2) 2 + (m + 1) * Nat.choose (m + 4) 4
        + Nat.choose (m + 2) 2 * Nat.choose (m + 3) 3
        + (m + 1) * Nat.choose (m + 5) 5 + Nat.choose (m + 7) 7)
      + Nat.choose (m + 3) 2
    = (m + 3 * (m * m) + 3 * (m * Nat.choose (m + 1) 2) + m * m * m
        + 2 * (m * Nat.choose (m + 2) 3) + m * m * Nat.choose (m + 1) 2
        + m * Nat.choose (m + 3) 4 + Nat.choose (m + 1) 2 * Nat.choose (m + 2) 3
        + m * Nat.choose (m + 4) 5 + Nat.choose (m + 6) 7)
      + ((m + 1) + 2 * ((m + 1) * (m + 1)) + (m + 1) * Nat.choose (m + 2) 2
          + Nat.choose (m + 2) 2 + (m + 1) * (m + 1) * (m + 1)
          + (m + 1) * Nat.choose (m + 3) 3 + Nat.choose (m + 3) 3
          + Nat.choose (m + 2) 2 * Nat.choose (m + 2) 2
          + (m + 1) * Nat.choose (m + 4) 4 + Nat.choose (m + 6) 6)
      + ((m + 1) + 2 * ((m + 1) * (m + 1)) + 2 * ((m + 1) * Nat.choose (m + 2) 2)
          + (m + 1) * Nat.choose (m + 3) 3 + Nat.choose (m + 5) 5) := by
  have h2 : Nat.choose (m + 2) 2 = (m + 1) + Nat.choose (m + 1) 2 := by
    rw [Nat.choose_succ_succ (m + 1) 1, Nat.choose_one_right]
  have h3 : Nat.choose (m + 3) 3 = Nat.choose (m + 2) 2 + Nat.choose (m + 2) 3 :=
    Nat.choose_succ_succ (m + 2) 2
  have h4 : Nat.choose (m + 4) 4 = Nat.choose (m + 3) 3 + Nat.choose (m + 3) 4 :=
    Nat.choose_succ_succ (m + 3) 3
  have h5 : Nat.choose (m + 5) 5 = Nat.choose (m + 4) 4 + Nat.choose (m + 4) 5 :=
    Nat.choose_succ_succ (m + 4) 4
  have h6 : Nat.choose (m + 6) 6 = Nat.choose (m + 5) 5 + Nat.choose (m + 5) 6 :=
    Nat.choose_succ_succ (m + 5) 5
  have h7 : Nat.choose (m + 7) 7 = Nat.choose (m + 6) 6 + Nat.choose (m + 6) 7 :=
    Nat.choose_succ_succ (m + 6) 6
  have hk : Nat.choose (m + 3) 2 = (m + 2) + Nat.choose (m + 2) 2 := by
    rw [Nat.choose_succ_succ (m + 2) 1, Nat.choose_one_right]
  rw [h7, h6, h5, h4, h3, hk, h2]
  ring

variable {D : ℕ}

/-- **(I7)**: `levelSeven_count_identity_gen` at `m = D − 2`, the level-seven account of the
`(rung -7, level 7)` slice:

`p_{D−1}(7) + C(D+1,2) = p_{D−2}(7) + p_{D−1}(6) + p_{D−1}(5)`.

At `D = 26`: `p_25(7) + C(27,2) = p_24(7) + p_25(6) + p_25(5)`. -/
theorem levelSeven_count_identity (hD : 2 ≤ D) :
    (((D - 1) + 3 * ((D - 1) * (D - 1)) + 3 * ((D - 1) * Nat.choose D 2)
        + (D - 1) * (D - 1) * (D - 1) + 2 * ((D - 1) * Nat.choose (D + 1) 3)
        + (D - 1) * (D - 1) * Nat.choose D 2 + (D - 1) * Nat.choose (D + 2) 4
        + Nat.choose D 2 * Nat.choose (D + 1) 3
        + (D - 1) * Nat.choose (D + 3) 5 + Nat.choose (D + 5) 7)
      + Nat.choose (D + 1) 2)
    = ((D - 2) + 3 * ((D - 2) * (D - 2)) + 3 * ((D - 2) * Nat.choose (D - 1) 2)
        + (D - 2) * (D - 2) * (D - 2) + 2 * ((D - 2) * Nat.choose D 3)
        + (D - 2) * (D - 2) * Nat.choose (D - 1) 2
        + (D - 2) * Nat.choose (D + 1) 4 + Nat.choose (D - 1) 2 * Nat.choose D 3
        + (D - 2) * Nat.choose (D + 2) 5 + Nat.choose (D + 4) 7)
      + ((D - 1) + 2 * ((D - 1) * (D - 1)) + (D - 1) * Nat.choose D 2
          + Nat.choose D 2 + (D - 1) * (D - 1) * (D - 1)
          + (D - 1) * Nat.choose (D + 1) 3 + Nat.choose (D + 1) 3
          + Nat.choose D 2 * Nat.choose D 2
          + (D - 1) * Nat.choose (D + 2) 4 + Nat.choose (D + 4) 6)
      + ((D - 1) + 2 * ((D - 1) * (D - 1)) + 2 * ((D - 1) * Nat.choose D 2)
          + (D - 1) * Nat.choose (D + 1) 3 + Nat.choose (D + 3) 5) := by
  obtain ⟨m, rfl⟩ : ∃ m, D = m + 2 := ⟨D - 2, by omega⟩
  simp only [show m + 2 - 1 = m + 1 from rfl, show m + 2 - 2 = m from rfl,
    show m + 2 + 1 = m + 3 from rfl, show m + 2 + 2 = m + 4 from rfl,
    show m + 2 + 3 = m + 5 from rfl, show m + 2 + 4 = m + 6 from rfl,
    show m + 2 + 5 = m + 7 from rfl]
  exact levelSeven_count_identity_gen m

/-- `levelSeven_count_identity_gen` at `m = D − 1`, i.e. `κ₇ = C(D+2,2)`: the counting input
a kernel-bound argument for `N = 7` (analogous to `LevelFiveCount`'s `(K5)`, not attempted
here) would need.

`p_D(7) + C(D+2,2) = p_{D−1}(7) + p_D(6) + p_D(5)`. -/
theorem levelSeven_count_identity_full (hD : 1 ≤ D) :
    ((D + 3 * (D * D) + 3 * (D * Nat.choose (D + 1) 2) + D * D * D
        + 2 * (D * Nat.choose (D + 2) 3) + D * D * Nat.choose (D + 1) 2
        + D * Nat.choose (D + 3) 4 + Nat.choose (D + 1) 2 * Nat.choose (D + 2) 3
        + D * Nat.choose (D + 4) 5 + Nat.choose (D + 6) 7)
      + Nat.choose (D + 2) 2)
    = ((D - 1) + 3 * ((D - 1) * (D - 1)) + 3 * ((D - 1) * Nat.choose D 2)
        + (D - 1) * (D - 1) * (D - 1) + 2 * ((D - 1) * Nat.choose (D + 1) 3)
        + (D - 1) * (D - 1) * Nat.choose D 2 + (D - 1) * Nat.choose (D + 2) 4
        + Nat.choose D 2 * Nat.choose (D + 1) 3
        + (D - 1) * Nat.choose (D + 3) 5 + Nat.choose (D + 5) 7)
      + (D + 2 * (D * D) + D * Nat.choose (D + 1) 2 + Nat.choose (D + 1) 2
          + D * D * D + D * Nat.choose (D + 2) 3 + Nat.choose (D + 2) 3
          + Nat.choose (D + 1) 2 * Nat.choose (D + 1) 2
          + D * Nat.choose (D + 3) 4 + Nat.choose (D + 5) 6)
      + (D + 2 * (D * D) + 2 * (D * Nat.choose (D + 1) 2) + D * Nat.choose (D + 2) 3
          + Nat.choose (D + 4) 5) := by
  obtain ⟨m, rfl⟩ : ∃ m, D = m + 1 := ⟨D - 1, by omega⟩
  simp only [show m + 1 - 1 = m from rfl, show m + 1 + 1 = m + 2 from rfl,
    show m + 1 + 2 = m + 3 from rfl, show m + 1 + 3 = m + 4 from rfl,
    show m + 1 + 4 = m + 5 from rfl, show m + 1 + 5 = m + 6 from rfl,
    show m + 1 + 6 = m + 7 from rfl]
  exact levelSeven_count_identity_gen m

end CountIdentity

end StringFormal.NoGhost
