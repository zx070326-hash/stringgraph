/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph theorem-prover (research/attempts/level-n-count-generalization)

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.LevelFiveCount

/-!
# The level-seven counting identity (SCRATCH DRAFT, not a `formal/` deliverable)

**This file deliberately lives in `research/attempts/level-n-count-generalization/`, not
in `formal/StringFormal/NoGhost/`.** It was originally drafted as
`formal/StringFormal/NoGhost/LevelSevenCount.lean`, with the three theorem statements
below and `sorry` proof bodies, exactly as the assigning task requested ("只写签名，证明体
全部 `sorry`"). Attempting to commit that file was **rejected by
`scripts/pre-commit.sh` → `scripts/check_sorry.py`**, which unconditionally refuses any
`sorry` occurrence in any `formal/*.lean` file — no override flag, no path exemption.
This is not a bug to route around: `formal/CLAUDE.md` states the same rule in prose
("禁止为了让 `validate` 通过而写带 `sorry` 的陈述。没准备好就不写声明"), and per this
project's rules an agent-to-agent task message cannot authorize bypassing a project's
enforced configuration (no `--no-verify`). `research/CLAUDE.md` explicitly names this
file's location as the correct home for exactly this situation: "允许 Lean scratch
实验……不受 `formal/` 的'不许 sorry'约束——这是草稿，不是正式产出." So: the mathematical
content below (three theorem **statements**, numerically verified term-for-term in
`scripts/check_lean_skeleton_literal.py`, see `proof.md` §7) is a ready-to-use blueprint;
`lean-formalizer` should copy it into a new `formal/StringFormal/NoGhost/LevelSevenCount.lean`
**only once actual proofs replace the `sorry`s** (or once each `sorry` is closed
one at a time, each closed theorem committed separately, so that no commit ever
introduces a `sorry` into `formal/`).

**Status: all three theorems below are `sorry`, by design — this is a proof-obligation
blueprint, not a finished result.** This file was produced by the `theorem-prover` agent
as a companion to `research/attempts/level-n-count-generalization/proof.md` (the full
derivation, with elementary proofs of the general formula and independent triple
numerical verification, lives there — `research/` is not yet allowed to be
`depends_on`'d by `graph/` or by `formal/`, see `research/CLAUDE.md`). Filling in the
`sorry`s is left to `lean-formalizer`, who should do so directly in a new `formal/`
file (not here) with each theorem's proof landing in its own commit.

## The identity

`p_m(N)` denotes the number of `m`-colored partitions of `N` (occupation functions
`d : ι × ℕ₊ →₀ ℕ` with `oscWeight d = N`, `|ι| = m`; same notion as in
`LevelTwo/Three/Four/FiveCount.lean`). The Pascal identity `p_{m+1}(N) = p_m(N) +
p_{m+1}(N-1) + p_{m+1}(N-2)` that holds unconditionally for `N ≤ 4`, and picks up a
constant `+1` correction at `N = 5` (`LevelFiveCount.levelFive_count_identity_gen`),
picks up a **non-constant** correction at `N = 6` and `N = 7`:

`κ_N(m) := p_m(N) + p_{m+1}(N-1) + p_{m+1}(N-2) - p_{m+1}(N)`,
`κ_6(m) = m + 1`,   `κ_7(m) = C(m+3,2)`

(derived and triple-numerically-verified in `proof.md` §3/§4/§6; `κ_6` is the **first** `N`
where the correction depends on `m` rather than being a fixed integer). The theorem below is

`levelSeven_count_identity_gen (m : ℕ) : p_{m+1}(7) + C(m+3,2) = p_m(7) + p_{m+1}(6) + p_{m+1}(5)`

where

`p_m(7) = m + 3m² + 3m·C(m+1,2) + m³ + 2m·C(m+2,3) + m²·C(m+1,2) + m·C(m+3,4)
          + C(m+1,2)·C(m+2,3) + m·C(m+4,5) + C(m+6,7)`

(10 shapes, from the 15 partitions of 7 — full shape-by-partition correspondence table
in `claim.md`), and `p_m(6)` is the **correct** 10-shape formula

`p_m(6) = m + 2m² + m·C(m+1,2) + C(m+1,2) + m³ + m·C(m+2,3) + C(m+2,3)
          + C(m+1,2)² + m·C(m+3,4) + C(m+5,6)`

— **not** the 11-shape formula currently (and, per `proof.md` §5, incorrectly) claimed by
`StringFormal.NoGhost.LevelSixCount.levelSix_count_identity_gen`. This file therefore
does **not** `import StringFormal.NoGhost.LevelSixCount`: that file currently fails
`lake build` (confirmed, error trace in `proof.md` §5), and even if it built, its stated
theorem asserts a different (false) identity `F(m+1) = F(m)` for `p_x(6)` that this file's
`levelSeven_count_identity_gen` does not need and must not cite. Instead this file states
`p_{m+1}(6)` afresh (inlined, no separate `p_m(6)` declaration) using the correct formula
above, exactly parallel to how `LevelFiveCount.lean` inlines `p_{m+1}(5)`.

## Contents

* `levelSeven_count_identity_gen` — the `m`-form identity (all `m`, `sorry`).
* `levelSeven_count_identity` — specialisation at `m = D - 2` (`hD : 2 ≤ D`, `sorry`).
* `levelSeven_count_identity_full` — specialisation at `m = D - 1` (`hD : 1 ≤ D`, `sorry`).

## Status

All three theorems are `sorry`. Numerically verified true (not merely "expected true") in
`research/attempts/level-n-count-generalization/proof.md` §4/§6 and
`scripts/check_level_seven_identity.py` (m = 0..7, exact integer match). A Lean proof of
`levelSeven_count_identity_gen` is expected to follow the same pattern as
`levelFive_count_identity_gen` (a chain of `Nat.choose_succ_succ` rewrites turning every
`Nat.choose (m+k+1) (k+1)` on the right into `Nat.choose (m+k) k + Nat.choose (m+k) (k+1)`,
then `ring`), but this has **not** been attempted here — this file is a skeleton, per task
scope. **Not done**: `levelSeven_count_identity`/`_full`'s own `obtain ⟨m, rfl⟩; simp only
[...]; exact levelSeven_count_identity_gen m` reduction (the arithmetic `show _ = _ from
rfl` side conditions have not been checked to typecheck; left for the formalizer along with
the `sorry`s).
-/


namespace StringFormal.NoGhost

section CountIdentity

/-- **The level-seven counting identity**, `m`-form:

`p_{m+1}(7) + C(m+3,2) = p_m(7) + p_{m+1}(6) + p_{m+1}(5)`.

See the file docstring for the `p_m(7)`/`p_m(6)` shape formulas and
`research/attempts/level-n-count-generalization/proof.md` §3/§6 for the derivation of the
correction term `C(m+3,2)` and the numerical verification. **Proof body deliberately left
as `sorry`**: this is a skeleton, the real proof is future `lean-formalizer` work. -/
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
  sorry

variable {D : ℕ}

/-- **`levelSeven_count_identity_gen` at `m = D − 2`**, i.e. the level-seven account of the
`(rung -7, level 7)` slice: `p_{D−1}(7) + C(D+1,2) = p_{D−2}(7) + p_{D−1}(6) + p_{D−1}(5)`.
Numerically at `D = 26`: verify via
`research/attempts/level-n-count-generalization/scripts/check_level_seven_identity.py`
(pass `m = D - 2 = 24`). **`sorry`.** -/
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
  sorry

/-- **`levelSeven_count_identity_gen` at `m = D − 1`**, i.e. `κ₇ = C(D+2,2)`: the counting
input a kernel-bound argument for `N = 7` (analogous to `LevelFiveCount`'s `(K5)`, not
attempted here) would need. **`sorry`.** -/
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
  sorry

end CountIdentity

end StringFormal.NoGhost
