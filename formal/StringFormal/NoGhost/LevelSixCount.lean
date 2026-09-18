/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.LevelFiveCount

/-!
# The level-six counting identity

This file establishes the counting identity for `N = 6`, correcting two errors found by
review in an earlier version of this file.

## The correct 10-term, 11-shape parametrisation

`p_m(6)` has **eleven** partition shapes of `6` (`p(6) = 11`), but two of them — `5+1` and
`4+2` — give the *same* colour-counting monomial `m²` (a single part of one colour and a
single part of another, distinct, colour), so they combine into one algebraic term `2m²`.
The correct closed form therefore has **ten** terms:

`p_m(6) = m + 2m² + m·C(m+1,2) + C(m+1,2) + m³ + m·C(m+2,3) + C(m+2,3)
          + C(m+1,2)² + m·C(m+3,4) + C(m+5,6)`

matching the eleven shapes
`[6] [5,1] [4,2] [4,1,1] [3,3] [3,2,1] [3,1,1,1] [2,2,2] [2,2,1,1] [2,1,1,1,1] [1⁶]`.

**Reviewer finding**: an earlier version of this file had a spurious eleventh term
`m·C(m+4,5)`, purportedly for a shape "one part of size `x` plus five parts of size `y`,
`x ≠ y`" — but the only solution of `x + 5y = 6` in positive integers is `x = y = 1`, which
is *not* `x ≠ y`; there is no such shape.  That term is simply removed (it is not replaced by
anything: `1^6` is already counted once, by the `C(m+5,6)` term).

Numerically: at `m = 1` every one of the ten terms evaluates to `1` except the `2m²` term
(which evaluates to `2`), so `p_1(6) = 1·9 + 2 = 11 = p(6)`.  At `m = 2` the ten terms are
`2, 8, 6, 3, 8, 8, 4, 9, 10, 7`, summing to `p_2(6) = 65`.  At `m = 3` they are
`3, 18, 18, 6, 27, 30, 10, 36, 45, 28`, summing to `p_3(6) = 221`.

## The recursive form

Rather than proving the closed form directly (which is not needed anywhere else in the
repository), this file states and proves the **recursive Pascal identity**

`p_{m+1}(6) + (m + 1) = p_m(6) + p_{m+1}(5) + p_{m+1}(4)`,

the `N = 6` analogue of `LevelFiveCount.levelFive_count_identity_gen`
(`p_{m+1}(5) + 1 = p_m(5) + p_{m+1}(4) + p_{m+1}(3)`).  As at `N = 5`, the identity is *not*
the "clean" Pascal recursion `p_{m+1}(N) = p_m(N) + p_{m+1}(N−1) + p_{m+1}(N−2)` that holds
unconditionally for `N ≤ 4`: the excess grows from `1` (`N = 5`) to `m + 1` (`N = 6`).
Verified numerically: at `m = 0`, `11 + 1 = 0 + 7 + 5`; at `m = 1`, `65 + 2 = 11 + 36 + 20`;
at `m = 2`, `221 + 3 = 65 + 108 + 51`; at `m = 3`, `574 + 4 = 221 + 252 + 105`.

## Contents

* `levelSix_count_identity_gen` — the corrected recursive identity, valid for all `m`.
* `levelSix_count_identity` — specialization at `m = D − 2`.
* `levelSix_count_identity_full` — specialization at `m = D − 1`.
* `Finsupp.oscWeight_eq_six_cases` — the eleven-shape classification of level-six occupation
  functions, added 2026-09-18.  Mirrors `LevelFiveCount.oscWeight_eq_five_cases` exactly: one
  `Finsupp.exists_peel` to strip an oscillator of mode `v₂ ∈ {1,…,6}`, then dispatch to the
  classification one level down (`oscWeight_eq_{five,four,three,two,one}_cases` /
  `eq_zero_of_oscWeight_eq_zero`).  `D` never appears — this is pure combinatorics on an
  arbitrary index type `ι`.

## The `LevelSixIdx` machinery and the generic (K6)/(N6) bounds

Mirroring `LevelFiveCount`'s `LevelFiveIdx` exactly (mode-count-profile injectivity dispatch,
case-by-case surjectivity onto `Finsupp.oscWeight_eq_six_cases`), this file also builds:

* `LevelSixIdx` / `levelSixIndex` / `levelSixIndex_injective` / `levelSixIndex_surjOn` —
  the eleven-branch index family for level-six occupation functions and the **exact** count
  `card_ddfLevel_six_eq`, plus the upper bound `card_conjFree_six_le` (U6).
* `finrank_ker_descPair_six_le` / `finrank_ker_seedPair_six_le` — the generic (K6) bound
  `dim ker T₆ ≤ D`, from `DescendantKernel.finrank_ker_descPair_add_le` plus
  `levelSix_count_identity_full` (`κ₆ = D`, i.e. `κ_N(D) = p_D(N-5)`; at `N = 6` this is
  `p_D(1) = D`, genuinely linear in `D`, unlike `κ₅ = p_D(0) = 1`).
* `le_finrank_towerNull_inf_towerBigrade_six` — **(c0)/(N6)**: the rank–nullity argument
  combining (K6) with the two null-membership lemmas
  `NullSeedsTwo.towerLop_neg_one_mem_towerNullSubmodule_of_mem_towerBigrade` (`j+N=-1`, the
  `L_{-1}`-image) and `LevelThreeCount.descTwo_mem_towerNullSubmodule_of_mem_towerBigrade`
  (`j+N=-2`, the `𝒟₂`-image), instantiated at `j = -6`.  Gives
  `dim(H_null ⊓ V_{-6,6}) ≥ dim(H_phys ⊓ V_{-6,6}) − D` with **generic slack `D`**, mirroring
  `le_finrank_towerNull_inf_towerBigrade_five`'s structure exactly (levels 5→6, 4→5, 3→4).

## ⚠ The precise remaining gap: `b26_six` needs the slack sharpened from `D` to `D − 1`

`b26_six` (`B26 6` in `SliceRank.lean`'s sense) needs
`dim(H_null ⊓ V_{-6,6}) ≥ D − 1`, not merely `≥ (generic bound) − D`.  Chasing the arithmetic:

* (K6)'s own slack is exactly `D` (`levelSix_count_identity_full`: `κ₆ = p_D(1) = D`), one
  more than the target `D − 1`.  This is the precise sense in which `N = 6` is the first level
  where the *generic* two-family kernel bound is **not** sharp enough — at `N ≤ 5`,
  `κ_N(D) = p_D(N-5)` happened to be `D`-independent (`κ_{≤4}=0`, `κ_5=p_D(0)=1`), so the
  generic bound was automatically exact; at `N = 6`, `κ_6 = p_D(1) = D` is genuinely linear
  in `D`, and using the *generic* (K6) bound loses exactly one dimension of slack relative to
  `[GAP-N6-seed]`'s `dim Q_{-6,1} = D - 1` (`SeedCriterionSix.mem_towerSeed_neg_six_one_iff`).
* Closing the gap needs the **sharp** bound `dim ker(seedPair η a b (-6) 6) ≤ D − 1`, i.e.
  restricting `descPair` to the **seed** domain `Q_{-6,5} × Q_{-6,4}` (not the whole slices
  `V_{-6,5} × V_{-6,4}`) must not lose dimension relative to the target `D − 1 = dim Q_{-6,1}`.
  Combined with `x4_y3_mem_towerSeed_neg_six_one` (`u ∈ Q_{-6,1} ⟹ (x₄u, y₃u)` is a seed pair)
  and `[GAP-N6-seed]`'s converse, this reduces to: **the map**
  `S₆ : Q_{-6,1} → Q_{-6,5} × Q_{-6,4}, u ↦ (x₄u, y₃u)` **is injective on the whole slice**
  `V_{-6,1}` (dimension `D`, not just `Q_{-6,1}`, dimension `D-1`) — equivalently
  `ker(seedPair) = S₆(Q_{-6,1})` exactly.
* This `S₆`-injectivity fact is **explicitly flagged as an unverified route judgement** by
  `formal/BLUEPRINT-noghost.md` §B⁗.7/§B⁗.9 (`⟨路线判断，未验证⟩`), and is **not proved
  anywhere in this repository**.  It is genuinely new mathematics — either a PBW-triangularity
  argument (showing `x₄`, `y₃` applied to a *non-seed* vector of `V_{-6,1}` cannot land in the
  seed subspace of the target, i.e. picks up a nonzero non-seed / non-positive-mode component)
  or a fresh explicit moment computation in the style of `LevelThreeCount`/`LevelFourCount`,
  not mechanical Lean bookkeeping — and is **out of scope for this file**.

`b26_six` and `ddfSpans_bigrade_neg_six_six` are therefore **not stated** in this file (per
repository discipline: no `sorry`, and no theorem statement without a completed proof).  See
`formal/TODO.md` entry `noghost-pr-d2` for the itemised status.

## Status

No `sorry`, no `native_decide`.  All declarations `check_axioms`-clean (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

namespace StringFormal.NoGhost

/-! ### The level-six counting identity

The corrected recursive identity. Everything here is arithmetic in `ℕ`; `D` never appears,
only the number `m` of directions. -/

section CountIdentity

/-- **The level-six counting identity**, in the recursive form free of natural subtraction:

`p_{m+1}(6) + (m + 1) = p_m(6) + p_{m+1}(5) + p_{m+1}(4)`

with the corrected ten-term `p_m(6) = m + 2m² + m·C(m+1,2) + C(m+1,2) + m³ + m·C(m+2,3)
+ C(m+2,3) + C(m+1,2)² + m·C(m+3,4) + C(m+5,6)`, `p_m(5)` as in
`LevelFiveCount.levelFive_count_identity_gen` and `p_m(4)` as in
`LevelFourCount.levelFour_count_identity`.

The proof follows the standard pattern: apply Pascal's rule to expand the binomial
coefficients `C(m+2,2) … C(m+6,6)` down to the primitive atoms `C(m+1,2), C(m+2,3), C(m+3,4),
C(m+4,5), C(m+5,6)` shared with the level-five and level-four formulas, then `ring`. -/
theorem levelSix_count_identity_gen (m : ℕ) :
    ((m + 1) + 2 * ((m + 1) * (m + 1)) + (m + 1) * Nat.choose (m + 2) 2
        + Nat.choose (m + 2) 2 + (m + 1) * (m + 1) * (m + 1)
        + (m + 1) * Nat.choose (m + 3) 3 + Nat.choose (m + 3) 3
        + (Nat.choose (m + 2) 2) * (Nat.choose (m + 2) 2)
        + (m + 1) * Nat.choose (m + 4) 4 + Nat.choose (m + 6) 6) + (m + 1)
      = (m + 2 * (m * m) + m * Nat.choose (m + 1) 2 + Nat.choose (m + 1) 2
          + m * m * m + m * Nat.choose (m + 2) 3 + Nat.choose (m + 2) 3
          + (Nat.choose (m + 1) 2) * (Nat.choose (m + 1) 2)
          + m * Nat.choose (m + 3) 4 + Nat.choose (m + 5) 6)
        + ((m + 1) + 2 * ((m + 1) * (m + 1)) + 2 * ((m + 1) * Nat.choose (m + 2) 2)
            + (m + 1) * Nat.choose (m + 3) 3 + Nat.choose (m + 5) 5)
        + ((m + 1) + (m + 1) * (m + 1) + Nat.choose (m + 2) 2
            + (m + 1) * Nat.choose (m + 2) 2 + Nat.choose (m + 4) 4) := by
  -- Expand binomial coefficients using Pascal's rule
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
  -- Rewrite and verify by ring
  rw [h6, h5, h4, h3, h2]
  ring

variable {D : ℕ}

/-- **(I6)**: `levelSix_count_identity_gen` at `m = D − 2`, the level-six account.

`p_{D−1}(6) + (D − 1) = p_{D−2}(6) + p_{D−1}(5) + p_{D−1}(4)`.

At `D = 26`: `p_25(6) + 25 = p_24(6) + p_25(5) + p_25(4)`. -/
theorem levelSix_count_identity (hD : 2 ≤ D) :
    ((D - 1) + 2 * ((D - 1) * (D - 1)) + (D - 1) * Nat.choose D 2
        + Nat.choose D 2 + (D - 1) * (D - 1) * (D - 1)
        + (D - 1) * Nat.choose (D + 1) 3 + Nat.choose (D + 1) 3
        + (Nat.choose D 2) * (Nat.choose D 2)
        + (D - 1) * Nat.choose (D + 2) 4 + Nat.choose (D + 4) 6) + (D - 1)
      = ((D - 2) + 2 * ((D - 2) * (D - 2)) + (D - 2) * Nat.choose (D - 1) 2
          + Nat.choose (D - 1) 2 + (D - 2) * (D - 2) * (D - 2)
          + (D - 2) * Nat.choose D 3 + Nat.choose D 3
          + (Nat.choose (D - 1) 2) * (Nat.choose (D - 1) 2)
          + (D - 2) * Nat.choose (D + 1) 4 + Nat.choose (D + 3) 6)
        + ((D - 1) + 2 * ((D - 1) * (D - 1)) + 2 * ((D - 1) * Nat.choose D 2)
            + (D - 1) * Nat.choose (D + 1) 3 + Nat.choose (D + 3) 5)
        + ((D - 1) + (D - 1) * (D - 1) + Nat.choose D 2
            + (D - 1) * Nat.choose D 2 + Nat.choose (D + 2) 4) := by
  obtain ⟨m, rfl⟩ : ∃ m, D = m + 2 := ⟨D - 2, by omega⟩
  simp only [show m + 2 - 1 = m + 1 from rfl, show m + 2 - 2 = m from rfl,
    show m + 2 + 1 = m + 3 from rfl, show m + 2 + 2 = m + 4 from rfl,
    show m + 2 + 3 = m + 5 from rfl, show m + 2 + 4 = m + 6 from rfl]
  exact levelSix_count_identity_gen m

/-- `levelSix_count_identity_gen` at `m = D − 1`, for use in kernel bounds or similar
applications.

`p_D(6) + D = p_{D−1}(6) + p_D(5) + p_D(4)`. -/
theorem levelSix_count_identity_full (hD : 1 ≤ D) :
    (D + 2 * (D * D) + D * Nat.choose (D + 1) 2 + Nat.choose (D + 1) 2
        + D * D * D + D * Nat.choose (D + 2) 3 + Nat.choose (D + 2) 3
        + (Nat.choose (D + 1) 2) * (Nat.choose (D + 1) 2)
        + D * Nat.choose (D + 3) 4 + Nat.choose (D + 5) 6) + D
      = ((D - 1) + 2 * ((D - 1) * (D - 1)) + (D - 1) * Nat.choose D 2
          + Nat.choose D 2 + (D - 1) * (D - 1) * (D - 1)
          + (D - 1) * Nat.choose (D + 1) 3 + Nat.choose (D + 1) 3
          + (Nat.choose D 2) * (Nat.choose D 2)
          + (D - 1) * Nat.choose (D + 2) 4 + Nat.choose (D + 4) 6)
        + (D + 2 * (D * D) + 2 * (D * Nat.choose (D + 1) 2)
            + D * Nat.choose (D + 2) 3 + Nat.choose (D + 4) 5)
        + (D + D * D + Nat.choose (D + 1) 2
            + D * Nat.choose (D + 1) 2 + Nat.choose (D + 3) 4) := by
  obtain ⟨m, rfl⟩ : ∃ m, D = m + 1 := ⟨D - 1, by omega⟩
  simp only [show m + 1 - 1 = m from rfl, show m + 1 + 1 = m + 2 from rfl,
    show m + 1 + 2 = m + 3 from rfl, show m + 1 + 3 = m + 4 from rfl,
    show m + 1 + 4 = m + 5 from rfl, show m + 1 + 5 = m + 6 from rfl]
  exact levelSix_count_identity_gen m

end CountIdentity

/-! ### The classification of level-six occupation functions

Eleven shapes, `[6] [5,1] [4,2] [4,1,1] [3,3] [3,2,1] [3,1,1,1] [2,2,2] [2,2,1,1] [2,1,1,1,1]
[1⁶]`.  As at levels three through five, the proof is one `Finsupp.exists_peel` plus the
classifications at levels `≤ 5` (`LevelFiveCount.oscWeight_eq_five_cases` down to
`LevelTwoCount.oscWeight_eq_two_cases` and `LevelThreeCount.oscWeight_eq_one_cases`). -/

namespace Finsupp

variable {ι : Type*}

/-- A `ℕ+` is determined by its coercion (the `Prod.ext` helper of the classification). -/
private lemma pnat_eq_six {m n : ℕ+} (h : (m : ℕ) = (n : ℕ)) : m = n := PNat.coe_injective h

/-- **The classification of level-six occupation functions.** -/
theorem oscWeight_eq_six_cases {d : (ι × ℕ+) →₀ ℕ} (h : oscWeight d = 6) :
    (∃ i : ι, d = Finsupp.single (i, 6) 1) ∨
      (∃ i j : ι, d = Finsupp.single (i, 5) 1 + Finsupp.single (j, 1) 1) ∨
        (∃ i j : ι, d = Finsupp.single (i, 4) 1 + Finsupp.single (j, 2) 1) ∨
          (∃ i j k : ι, d = Finsupp.single (i, 4) 1
            + (Finsupp.single (j, 1) 1 + Finsupp.single (k, 1) 1)) ∨
            (∃ i j : ι, d = Finsupp.single (i, 3) 1 + Finsupp.single (j, 3) 1) ∨
              (∃ i j k : ι, d = Finsupp.single (i, 3) 1 + Finsupp.single (j, 2) 1
                + Finsupp.single (k, 1) 1) ∨
                (∃ i j k l : ι, d = Finsupp.single (i, 3) 1
                  + (Finsupp.single (j, 1) 1
                    + (Finsupp.single (k, 1) 1 + Finsupp.single (l, 1) 1))) ∨
                  (∃ i j k : ι, d = Finsupp.single (i, 2) 1 + Finsupp.single (j, 2) 1
                    + Finsupp.single (k, 2) 1) ∨
                    (∃ i j k l : ι, d = Finsupp.single (i, 2) 1 + Finsupp.single (j, 2) 1
                      + (Finsupp.single (k, 1) 1 + Finsupp.single (l, 1) 1)) ∨
                      (∃ i j k l m : ι, d = Finsupp.single (i, 2) 1
                        + (Finsupp.single (j, 1) 1
                          + (Finsupp.single (k, 1) 1
                            + (Finsupp.single (l, 1) 1 + Finsupp.single (m, 1) 1)))) ∨
                        (∃ i j k l m n : ι, d = Finsupp.single (i, 1) 1
                          + (Finsupp.single (j, 1) 1
                            + (Finsupp.single (k, 1) 1
                              + (Finsupp.single (l, 1) 1
                                + (Finsupp.single (m, 1) 1 + Finsupp.single (n, 1) 1))))) := by
  obtain ⟨v, d', hd, hw⟩ := exists_peel (N := 5) (by simpa using h)
  have hpos : 0 < (v.2 : ℕ) := v.2.pos
  have hle : (v.2 : ℕ) ≤ 6 := by omega
  interval_cases hv : (v.2 : ℕ)
  · -- `v₂ = 1`: the rest has weight five
    have hv1 : ((v.1, 1) : ι × ℕ+) = v := Prod.ext rfl (pnat_eq_six (by simpa using hv.symm))
    rcases oscWeight_eq_five_cases (d := d') (by omega) with
      ⟨i, hi⟩ | ⟨i, j, hi⟩ | ⟨i, j, hi⟩ | ⟨i, j, k, hi⟩ | ⟨i, j, k, hi⟩ | ⟨i, j, k, l, hi⟩ |
        ⟨i, j, k, l, n, hi⟩
    · -- rest = [5] → [5,1]
      right; left
      exact ⟨i, v.1, by rw [hd, hi, hv1]; try abel⟩
    · -- rest = [4,1] → [4,1,1]
      right; right; right; left
      exact ⟨i, j, v.1, by rw [hd, hi, hv1]; try abel⟩
    · -- rest = [3,2] → [3,2,1]
      right; right; right; right; right; left
      exact ⟨i, j, v.1, by rw [hd, hi, hv1]; try abel⟩
    · -- rest = [3,1,1] → [3,1,1,1]
      right; right; right; right; right; right; left
      exact ⟨i, j, k, v.1, by rw [hd, hi, hv1]; try abel⟩
    · -- rest = [2,2,1] → [2,2,1,1]
      right; right; right; right; right; right; right; right; left
      exact ⟨i, j, k, v.1, by rw [hd, hi, hv1]; try abel⟩
    · -- rest = [2,1,1,1] → [2,1,1,1,1]
      right; right; right; right; right; right; right; right; right; left
      exact ⟨i, j, k, l, v.1, by rw [hd, hi, hv1]; try abel⟩
    · -- rest = [1⁵] → [1⁶]
      right; right; right; right; right; right; right; right; right; right
      exact ⟨i, j, k, l, n, v.1, by rw [hd, hi, hv1]; try abel⟩
  · -- `v₂ = 2`: the rest has weight four
    have hv2 : ((v.1, 2) : ι × ℕ+) = v := Prod.ext rfl (pnat_eq_six (by simpa using hv.symm))
    rcases oscWeight_eq_four_cases (d := d') (by omega) with
      ⟨i, hi⟩ | ⟨i, j, hi⟩ | ⟨i, j, hi⟩ | ⟨i, j, k, hi⟩ | ⟨i, j, k, l, hi⟩
    · -- rest = [4] → [4,2]
      right; right; left
      exact ⟨i, v.1, by rw [hd, hi, hv2]; try abel⟩
    · -- rest = [3,1] → [3,2,1]
      right; right; right; right; right; left
      exact ⟨i, v.1, j, by rw [hd, hi, hv2]; try abel⟩
    · -- rest = [2,2] → [2,2,2]
      right; right; right; right; right; right; right; left
      exact ⟨i, j, v.1, by rw [hd, hi, hv2]; try abel⟩
    · -- rest = [2,1,1] → [2,2,1,1]
      right; right; right; right; right; right; right; right; left
      exact ⟨i, v.1, j, k, by rw [hd, hi, hv2]; try abel⟩
    · -- rest = [1,1,1,1] → [2,1,1,1,1]
      right; right; right; right; right; right; right; right; right; left
      exact ⟨v.1, i, j, k, l, by rw [hd, hi, hv2]; try abel⟩
  · -- `v₂ = 3`: the rest has weight three
    have hv3 : ((v.1, 3) : ι × ℕ+) = v := Prod.ext rfl (pnat_eq_six (by simpa using hv.symm))
    rcases oscWeight_eq_three_cases (d := d') (by omega) with ⟨i, hi⟩ | ⟨i, j, hi⟩ | ⟨i, j, k, hi⟩
    · -- rest = [3] → [3,3]
      right; right; right; right; left
      exact ⟨i, v.1, by rw [hd, hi, hv3]; try abel⟩
    · -- rest = [2,1] → [3,2,1]
      right; right; right; right; right; left
      exact ⟨v.1, i, j, by rw [hd, hi, hv3]; try abel⟩
    · -- rest = [1,1,1] → [3,1,1,1]
      right; right; right; right; right; right; left
      exact ⟨v.1, i, j, k, by rw [hd, hi, hv3]; try abel⟩
  · -- `v₂ = 4`: the rest has weight two
    have hv4 : ((v.1, 4) : ι × ℕ+) = v := Prod.ext rfl (pnat_eq_six (by simpa using hv.symm))
    rcases oscWeight_eq_two_cases (d := d') (by omega) with ⟨i, hi⟩ | ⟨i, j, hi⟩
    · -- rest = [2] → [4,2]
      right; right; left
      exact ⟨v.1, i, by rw [hd, hi, hv4]; try abel⟩
    · -- rest = [1,1] → [4,1,1]
      right; right; right; left
      exact ⟨v.1, i, j, by rw [hd, hi, hv4]; try abel⟩
  · -- `v₂ = 5`: the rest has weight one
    have hv5 : ((v.1, 5) : ι × ℕ+) = v := Prod.ext rfl (pnat_eq_six (by simpa using hv.symm))
    obtain ⟨i, hi⟩ := oscWeight_eq_one_cases (d := d') (by omega)
    right; left
    exact ⟨v.1, i, by rw [hd, hi, hv5]; try abel⟩
  · -- `v₂ = 6`: the rest is empty
    have hv6 : ((v.1, 6) : ι × ℕ+) = v := Prod.ext rfl (pnat_eq_six (by simpa using hv.symm))
    have hd' : d' = 0 := eq_zero_of_oscWeight_eq_zero (by omega)
    left
    exact ⟨v.1, by rw [hd, hd', add_zero, hv6]⟩

end Finsupp

/-! ### The `LevelSixIdx` parametrisation

Eleven branches, one per partition shape of `6`.  Mirrors `LevelFiveCount`'s `LevelFiveIdx`
exactly: shapes with a **repeated** mode value use `Sym ι k` (the mode value no longer
distinguishes which oscillator is which); shapes with **pairwise distinct** mode values use
ordered products `ι × ι` / `ι × ι × ι` (the mode value itself already distinguishes the
factors, so there is no overcount to quotient by).

`[5,1]` and `[4,2]` both contribute `m²`; the other nine shapes are each their own monomial
(`m`, `m·C(m+1,2)`, `C(m+1,2)`, `m³`, `m·C(m+2,3)`, `C(m+2,3)`, `C(m+1,2)²`, `m·C(m+3,4)`,
`C(m+5,6)`), matching `levelSix_count_identity_full`'s ten-term formula exactly. -/

section LevelSixIndex

variable {ι : Type*} [DecidableEq ι]

/-- Six mode-`n` oscillators from an unordered sextuple. -/
lemma symModeIndex_mk_six (n : ℕ+) (a c e f g h : ι)
    (hcard : Multiset.card ({a, c, e, f, g, h} : Multiset ι) = 6) :
    symModeIndex ι n ⟨{a, c, e, f, g, h}, hcard⟩
      = Finsupp.single ((a, n) : ι × ℕ+) 1
        + (Finsupp.single ((c, n) : ι × ℕ+) 1
          + (Finsupp.single ((e, n) : ι × ℕ+) 1
            + (Finsupp.single ((f, n) : ι × ℕ+) 1
              + (Finsupp.single ((g, n) : ι × ℕ+) 1
                + Finsupp.single ((h, n) : ι × ℕ+) 1)))) := by
  have hm : ({a, c, e, f, g, h} : Multiset ι)
      = a ::ₘ (c ::ₘ (e ::ₘ (f ::ₘ (g ::ₘ {h})))) := by simp [Multiset.insert_eq_cons]
  show Finsupp.mapDomain _ (Multiset.toFinsupp ({a, c, e, f, g, h} : Multiset ι)) = _
  rw [hm, mapDomain_toFinsupp_cons, mapDomain_toFinsupp_cons, mapDomain_toFinsupp_cons,
    mapDomain_toFinsupp_cons, mapDomain_toFinsupp_cons, Multiset.toFinsupp_singleton,
    Finsupp.mapDomain_single]

variable (ι)

/-- The level-six index type. -/
abbrev LevelSixIdx : Type _ :=
  ι ⊕ (ι × ι) ⊕ (ι × ι) ⊕ (ι × Sym ι 2) ⊕ Sym ι 2 ⊕ (ι × ι × ι) ⊕ (ι × Sym ι 3) ⊕ Sym ι 3
    ⊕ (Sym ι 2 × Sym ι 2) ⊕ (ι × Sym ι 4) ⊕ Sym ι 6

/-- The level-six index map. -/
noncomputable def levelSixIndex : LevelSixIdx ι → ((ι × ℕ+) →₀ ℕ)
  | Sum.inl i => Finsupp.single (i, 6) 1
  | Sum.inr (Sum.inl p) => Finsupp.single (p.1, 5) 1 + Finsupp.single (p.2, 1) 1
  | Sum.inr (Sum.inr (Sum.inl p)) => Finsupp.single (p.1, 4) 1 + Finsupp.single (p.2, 2) 1
  | Sum.inr (Sum.inr (Sum.inr (Sum.inl p))) =>
      Finsupp.single (p.1, 4) 1 + symModeIndex ι 1 p.2
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl s)))) => symModeIndex ι 3 s
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl p))))) =>
      Finsupp.single (p.1, 3) 1 + Finsupp.single (p.2.1, 2) 1 + Finsupp.single (p.2.2, 1) 1
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl p)))))) =>
      Finsupp.single (p.1, 3) 1 + symModeIndex ι 1 p.2
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl s))))))) =>
      symModeIndex ι 2 s
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl p)))))))) =>
      symModeIndex ι 2 p.1 + symModeIndex ι 1 p.2
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr
      (Sum.inr (Sum.inl p))))))))) => Finsupp.single (p.1, 2) 1 + symModeIndex ι 1 p.2
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr
      (Sum.inr (Sum.inr t))))))))) => symModeIndex ι 1 t

/-- The mode profile `(#1, #2, #3, #4, #5, #6)` of each of the eleven shapes. -/
def levelSixShape : LevelSixIdx ι → ℕ × ℕ × ℕ × ℕ × ℕ × ℕ
  | Sum.inl _ => (0, 0, 0, 0, 0, 1)
  | Sum.inr (Sum.inl _) => (1, 0, 0, 0, 1, 0)
  | Sum.inr (Sum.inr (Sum.inl _)) => (0, 1, 0, 1, 0, 0)
  | Sum.inr (Sum.inr (Sum.inr (Sum.inl _))) => (2, 0, 0, 1, 0, 0)
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl _)))) => (0, 0, 2, 0, 0, 0)
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl _))))) => (1, 1, 1, 0, 0, 0)
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl _)))))) => (3, 0, 1, 0, 0, 0)
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl _))))))) =>
      (0, 3, 0, 0, 0, 0)
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl _)))))))) =>
      (2, 2, 0, 0, 0, 0)
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr
      (Sum.inr (Sum.inl _))))))))) => (4, 1, 0, 0, 0, 0)
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr
      (Sum.inr (Sum.inr _))))))))) => (6, 0, 0, 0, 0, 0)

variable {ι}

lemma oscWeight_levelSixIndex (x : LevelSixIdx ι) :
    Finsupp.oscWeight (levelSixIndex ι x) = 6 := by
  match x with
  | Sum.inl i => simp [levelSixIndex]
  | Sum.inr (Sum.inl p) => simp [levelSixIndex]
  | Sum.inr (Sum.inr (Sum.inl p)) => simp [levelSixIndex]
  | Sum.inr (Sum.inr (Sum.inr (Sum.inl p))) => simp [levelSixIndex]
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl s)))) => simp [levelSixIndex]
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl p))))) => simp [levelSixIndex]
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl p)))))) => simp [levelSixIndex]
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl s))))))) =>
      simp [levelSixIndex]
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl p)))))))) =>
      simp [levelSixIndex]
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr
      (Sum.inr (Sum.inl p))))))))) => simp [levelSixIndex]
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr
      (Sum.inr (Sum.inr t))))))))) => simp [levelSixIndex]

lemma modeVec_levelSixIndex (x : LevelSixIdx ι) :
    (modeCount ι 1 (levelSixIndex ι x), modeCount ι 2 (levelSixIndex ι x),
        modeCount ι 3 (levelSixIndex ι x), modeCount ι 4 (levelSixIndex ι x),
        modeCount ι 5 (levelSixIndex ι x), modeCount ι 6 (levelSixIndex ι x))
      = levelSixShape ι x := by
  match x with
  | Sum.inl i => simp [levelSixIndex, levelSixShape]
  | Sum.inr (Sum.inl p) => simp [levelSixIndex, levelSixShape, modeCount_add]
  | Sum.inr (Sum.inr (Sum.inl p)) => simp [levelSixIndex, levelSixShape, modeCount_add]
  | Sum.inr (Sum.inr (Sum.inr (Sum.inl p))) =>
      simp [levelSixIndex, levelSixShape, modeCount_add]
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl s)))) =>
      simp [levelSixIndex, levelSixShape]
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl p))))) =>
      simp [levelSixIndex, levelSixShape, modeCount_add]
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl p)))))) =>
      simp [levelSixIndex, levelSixShape, modeCount_add]
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl s))))))) =>
      simp [levelSixIndex, levelSixShape]
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl p)))))))) =>
      simp [levelSixIndex, levelSixShape, modeCount_add]
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr
      (Sum.inr (Sum.inl p))))))))) => simp [levelSixIndex, levelSixShape, modeCount_add]
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr
      (Sum.inr (Sum.inr t))))))))) => simp [levelSixIndex, levelSixShape]

end LevelSixIndex

/-! ### Injectivity of the level-six parametrisation

Mirrors `LevelFiveCount`'s injectivity proof: the mode profile `levelSixShape` settles all but
the eleven diagonal (same-shape) cases; those eleven are settled by `Finsupp.single`
injectivity and `symModeIndex_injective`.  Two cases are genuinely new relative to levels
`≤ 5`: `[3,2,1]` needs a three-point (rather than two-point) cross-elimination, and
`[2,2,1,1]` needs a `Finsupp.ext` argument since **both** factors are `Sym`, so there is no
single evaluation point that isolates one factor from the other — instead, the mode value `2`
itself does the separating (`symModeIndex_apply_of_ne`, plus the vanishing of the mode-`1`
part off mode `2`, are used pointwise for every `v`). -/

section LevelSixInjective

variable {ι : Type*} [DecidableEq ι]

private lemma single_apply_mode_ne (i j : ι) (m n : ℕ+) (hmn : m ≠ n) :
    (Finsupp.single ((j, n) : ι × ℕ+) (1 : ℕ)) ((i, m) : ι × ℕ+) = 0 := by
  refine Finsupp.single_eq_of_ne fun hc => hmn ?_
  have hc2 := congrArg (fun v : ι × ℕ+ => v.2) hc
  simp only at hc2
  first | exact hc2 | exact hc2.symm

private lemma fst_of_single_apply (i j : ι) (n : ℕ+)
    (h : (Finsupp.single ((j, n) : ι × ℕ+) (1 : ℕ)) ((i, n) : ι × ℕ+) = 1) : j = i := by
  by_contra hc
  rw [Finsupp.single_eq_of_ne (fun hcc => hc (by
      have hz := congrArg (fun v : ι × ℕ+ => v.1) hcc
      simp only at hz
      first | exact hz | exact hz.symm))] at h
  exact zero_ne_one h

/-- **The level-six parametrisation is injective.** -/
theorem levelSixIndex_injective : Function.Injective (levelSixIndex ι) := by
  have h61 : (6 : ℕ+) ≠ 1 := by decide
  have h51 : (5 : ℕ+) ≠ 1 := by decide
  have h41 : (4 : ℕ+) ≠ 1 := by decide
  have h42 : (4 : ℕ+) ≠ 2 := by decide
  have h32 : (3 : ℕ+) ≠ 2 := by decide
  have h31 : (3 : ℕ+) ≠ 1 := by decide
  have h21 : (2 : ℕ+) ≠ 1 := by decide
  intro x y h
  have hs : levelSixShape ι x = levelSixShape ι y := by
    rw [← modeVec_levelSixIndex x, ← modeVec_levelSixIndex y, h]
  obtain i | p | q | ps | s | pqr | pt | s3 | pp | pu | t := x <;>
      obtain i' | p' | q' | ps' | s' | pqr' | pt' | s3' | pp' | pu' | t' := y <;>
    simp only [levelSixShape, Prod.mk.injEq] at hs <;> try (exfalso; omega)
  · -- `[6]` versus `[6]`
    refine congrArg Sum.inl ?_
    have h1 := DFunLike.congr_fun h ((i, 6) : ι × ℕ+)
    rw [levelSixIndex, levelSixIndex, Finsupp.single_eq_same] at h1
    exact (fst_of_single_apply i i' 6 h1.symm).symm
  · -- `[5,1]` versus `[5,1]`
    refine congrArg (Sum.inr ∘ Sum.inl) ?_
    have h1 := DFunLike.congr_fun h ((p.1, 5) : ι × ℕ+)
    have h2 := DFunLike.congr_fun h ((p.2, 1) : ι × ℕ+)
    rw [levelSixIndex, levelSixIndex, Finsupp.add_apply, Finsupp.add_apply,
      Finsupp.single_eq_same, single_apply_mode_ne p.1 p.2 5 1 h51,
      single_apply_mode_ne p.1 p'.2 5 1 h51, add_zero, add_zero] at h1
    rw [levelSixIndex, levelSixIndex, Finsupp.add_apply, Finsupp.add_apply,
      Finsupp.single_eq_same, single_apply_mode_ne p.2 p.1 1 5 (Ne.symm h51),
      single_apply_mode_ne p.2 p'.1 1 5 (Ne.symm h51), zero_add, zero_add] at h2
    exact Prod.ext (fst_of_single_apply p.1 p'.1 5 h1.symm).symm
      (fst_of_single_apply p.2 p'.2 1 h2.symm).symm
  · -- `[4,2]` versus `[4,2]`
    refine congrArg (Sum.inr ∘ Sum.inr ∘ Sum.inl) ?_
    have h1 := DFunLike.congr_fun h ((q.1, 4) : ι × ℕ+)
    have h2 := DFunLike.congr_fun h ((q.2, 2) : ι × ℕ+)
    rw [levelSixIndex, levelSixIndex, Finsupp.add_apply, Finsupp.add_apply,
      Finsupp.single_eq_same, single_apply_mode_ne q.1 q.2 4 2 h42,
      single_apply_mode_ne q.1 q'.2 4 2 h42, add_zero, add_zero] at h1
    rw [levelSixIndex, levelSixIndex, Finsupp.add_apply, Finsupp.add_apply,
      Finsupp.single_eq_same, single_apply_mode_ne q.2 q.1 2 4 (Ne.symm h42),
      single_apply_mode_ne q.2 q'.1 2 4 (Ne.symm h42), zero_add, zero_add] at h2
    exact Prod.ext (fst_of_single_apply q.1 q'.1 4 h1.symm).symm
      (fst_of_single_apply q.2 q'.2 2 h2.symm).symm
  · -- `[4,1,1]` versus `[4,1,1]`
    refine congrArg (Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inl) ?_
    have h1 := DFunLike.congr_fun h ((ps.1, 4) : ι × ℕ+)
    rw [levelSixIndex, levelSixIndex, Finsupp.add_apply, Finsupp.add_apply,
      Finsupp.single_eq_same, symModeIndex_apply_of_ne 1 ps.2 (by simpa using h41),
      symModeIndex_apply_of_ne 1 ps'.2 (by simpa using h41), add_zero, add_zero] at h1
    have hfst : ps'.1 = ps.1 := fst_of_single_apply ps.1 ps'.1 4 h1.symm
    rw [levelSixIndex, levelSixIndex, hfst] at h
    exact Prod.ext hfst.symm (symModeIndex_injective 1 (add_left_cancel h))
  · -- `[3,3]` versus `[3,3]`
    exact congrArg (Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inl)
      (symModeIndex_injective 3 h)
  · -- `[3,2,1]` versus `[3,2,1]`: the new three-point cross-elimination
    refine congrArg (Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inl) ?_
    have h1 := DFunLike.congr_fun h ((pqr.1, 3) : ι × ℕ+)
    have h2 := DFunLike.congr_fun h ((pqr.2.1, 2) : ι × ℕ+)
    have h3 := DFunLike.congr_fun h ((pqr.2.2, 1) : ι × ℕ+)
    rw [levelSixIndex, levelSixIndex] at h1 h2 h3
    simp only [Finsupp.add_apply, Finsupp.single_eq_same,
      single_apply_mode_ne pqr.1 pqr.2.1 3 2 h32, single_apply_mode_ne pqr.1 pqr.2.2 3 1 h31,
      single_apply_mode_ne pqr.1 pqr'.2.1 3 2 h32, single_apply_mode_ne pqr.1 pqr'.2.2 3 1 h31,
      add_zero] at h1
    simp only [Finsupp.add_apply, Finsupp.single_eq_same,
      single_apply_mode_ne pqr.2.1 pqr.1 2 3 (Ne.symm h32),
      single_apply_mode_ne pqr.2.1 pqr.2.2 2 1 h21,
      single_apply_mode_ne pqr.2.1 pqr'.1 2 3 (Ne.symm h32),
      single_apply_mode_ne pqr.2.1 pqr'.2.2 2 1 h21,
      add_zero, zero_add] at h2
    simp only [Finsupp.add_apply, Finsupp.single_eq_same,
      single_apply_mode_ne pqr.2.2 pqr.1 1 3 (Ne.symm h31),
      single_apply_mode_ne pqr.2.2 pqr.2.1 1 2 (Ne.symm h21),
      single_apply_mode_ne pqr.2.2 pqr'.1 1 3 (Ne.symm h31),
      single_apply_mode_ne pqr.2.2 pqr'.2.1 1 2 (Ne.symm h21),
      add_zero, zero_add] at h3
    have hfst : pqr'.1 = pqr.1 := fst_of_single_apply pqr.1 pqr'.1 3 h1.symm
    have hsnd : pqr'.2.1 = pqr.2.1 := fst_of_single_apply pqr.2.1 pqr'.2.1 2 h2.symm
    have hthd : pqr'.2.2 = pqr.2.2 := fst_of_single_apply pqr.2.2 pqr'.2.2 1 h3.symm
    exact Prod.ext hfst.symm (Prod.ext hsnd.symm hthd.symm)
  · -- `[3,1,1,1]` versus `[3,1,1,1]`
    refine congrArg (Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inl) ?_
    have h1 := DFunLike.congr_fun h ((pt.1, 3) : ι × ℕ+)
    rw [levelSixIndex, levelSixIndex, Finsupp.add_apply, Finsupp.add_apply,
      Finsupp.single_eq_same, symModeIndex_apply_of_ne 1 pt.2 (by simpa using h31),
      symModeIndex_apply_of_ne 1 pt'.2 (by simpa using h31), add_zero, add_zero] at h1
    have hfst : pt'.1 = pt.1 := fst_of_single_apply pt.1 pt'.1 3 h1.symm
    rw [levelSixIndex, levelSixIndex, hfst] at h
    exact Prod.ext hfst.symm (symModeIndex_injective 1 (add_left_cancel h))
  · -- `[2,2,2]` versus `[2,2,2]`
    exact congrArg (Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inl)
      (symModeIndex_injective 2 h)
  · -- `[2,2,1,1]` versus `[2,2,1,1]`: the new `Sym × Sym` case
    refine congrArg (Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inr
      ∘ Sum.inr ∘ Sum.inl) ?_
    have hEq2 : symModeIndex ι 2 pp.1 = symModeIndex ι 2 pp'.1 := by
      ext v
      by_cases hv : v.2 = (2 : ℕ+)
      · have hv1 : v.2 ≠ (1 : ℕ+) := by rw [hv]; exact h21
        have hL := DFunLike.congr_fun h v
        rw [levelSixIndex, levelSixIndex, Finsupp.add_apply, Finsupp.add_apply,
          symModeIndex_apply_of_ne 1 pp.2 hv1, symModeIndex_apply_of_ne 1 pp'.2 hv1,
          add_zero, add_zero] at hL
        exact hL
      · rw [symModeIndex_apply_of_ne 2 pp.1 hv, symModeIndex_apply_of_ne 2 pp'.1 hv]
    have hpp1 : pp.1 = pp'.1 := symModeIndex_injective 2 hEq2
    rw [levelSixIndex, levelSixIndex, hpp1] at h
    exact Prod.ext hpp1 (symModeIndex_injective 1 (add_left_cancel h))
  · -- `[2,1,1,1,1]` versus `[2,1,1,1,1]`
    refine congrArg (Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inr
      ∘ Sum.inr ∘ Sum.inr ∘ Sum.inl) ?_
    have h1 := DFunLike.congr_fun h ((pu.1, 2) : ι × ℕ+)
    rw [levelSixIndex, levelSixIndex, Finsupp.add_apply, Finsupp.add_apply,
      Finsupp.single_eq_same, symModeIndex_apply_of_ne 1 pu.2 (by simpa using h21),
      symModeIndex_apply_of_ne 1 pu'.2 (by simpa using h21), add_zero, add_zero] at h1
    have hfst : pu'.1 = pu.1 := fst_of_single_apply pu.1 pu'.1 2 h1.symm
    rw [levelSixIndex, levelSixIndex, hfst] at h
    exact Prod.ext hfst.symm (symModeIndex_injective 1 (add_left_cancel h))
  · -- `[1⁶]` versus `[1⁶]`
    exact congrArg (Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inr
      ∘ Sum.inr ∘ Sum.inr ∘ Sum.inr) (symModeIndex_injective 1 h)

end LevelSixInjective

/-! ### Surjectivity of `levelSixIndex`, and the exact level-six count

Dispatches `Finsupp.oscWeight_eq_six_cases` directly; the witnesses are literal, except for the
three shapes with a `Sym`-valued factor of size `≥ 2`, which need `symModeIndex_mk_two/_three/
_four/_six`.  `[2,2,2]` is the one shape where the classification's left-associated triple sum
`(a + b) + c` disagrees with `symModeIndex_mk_three`'s right-associated form `a + (b + c)`; a
single `add_assoc` rewrite closes it. -/

section LevelSixSurjOn

variable {ι : Type*} [DecidableEq ι]

/-- The level-six parametrisation hits every level-six occupation function. -/
theorem levelSixIndex_surjOn {d : (ι × ℕ+) →₀ ℕ} (h : Finsupp.oscWeight d = 6) :
    ∃ x : LevelSixIdx ι, levelSixIndex ι x = d := by
  classical
  rcases Finsupp.oscWeight_eq_six_cases h with
    ⟨i, hd⟩ | ⟨i, j, hd⟩ | ⟨i, j, hd⟩ | ⟨i, j, k, hd⟩ | ⟨i, j, hd⟩ | ⟨i, j, k, hd⟩
      | ⟨i, j, k, l, hd⟩ | ⟨i, j, k, hd⟩ | ⟨i, j, k, l, hd⟩ | ⟨i, j, k, l, m, hd⟩
      | ⟨i, j, k, l, m, n, hd⟩
  · -- `[6]`
    exact ⟨Sum.inl i, hd.symm⟩
  · -- `[5,1]`
    exact ⟨Sum.inr (Sum.inl (i, j)), hd.symm⟩
  · -- `[4,2]`
    exact ⟨Sum.inr (Sum.inr (Sum.inl (i, j))), hd.symm⟩
  · -- `[4,1,1]`
    have hc : Multiset.card ({j, k} : Multiset ι) = 2 := by simp
    refine ⟨Sum.inr (Sum.inr (Sum.inr (Sum.inl (i, ⟨{j, k}, hc⟩)))), ?_⟩
    show Finsupp.single ((i, 4) : ι × ℕ+) 1 + symModeIndex ι 1 ⟨{j, k}, hc⟩ = d
    rw [symModeIndex_mk_two, hd]
  · -- `[3,3]`
    have hc : Multiset.card ({i, j} : Multiset ι) = 2 := by simp
    refine ⟨Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl ⟨{i, j}, hc⟩)))), ?_⟩
    show symModeIndex ι 3 ⟨{i, j}, hc⟩ = d
    rw [symModeIndex_mk_two, hd]
  · -- `[3,2,1]`
    exact ⟨Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl (i, j, k)))))), hd.symm⟩
  · -- `[3,1,1,1]`
    have hc : Multiset.card ({j, k, l} : Multiset ι) = 3 := by simp
    refine ⟨Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr
      (Sum.inl (i, ⟨{j, k, l}, hc⟩))))))), ?_⟩
    show Finsupp.single ((i, 3) : ι × ℕ+) 1 + symModeIndex ι 1 ⟨{j, k, l}, hc⟩ = d
    rw [symModeIndex_mk_three, hd]
  · -- `[2,2,2]`
    have hc : Multiset.card ({i, j, k} : Multiset ι) = 3 := by simp
    refine ⟨Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr
      (Sum.inl ⟨{i, j, k}, hc⟩))))))), ?_⟩
    show symModeIndex ι 2 ⟨{i, j, k}, hc⟩ = d
    rw [symModeIndex_mk_three, hd, add_assoc]
  · -- `[2,2,1,1]`
    have hc1 : Multiset.card ({i, j} : Multiset ι) = 2 := by simp
    have hc2 : Multiset.card ({k, l} : Multiset ι) = 2 := by simp
    refine ⟨Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr
      (Sum.inl (⟨{i, j}, hc1⟩, ⟨{k, l}, hc2⟩))))))))), ?_⟩
    show symModeIndex ι 2 ⟨{i, j}, hc1⟩ + symModeIndex ι 1 ⟨{k, l}, hc2⟩ = d
    rw [symModeIndex_mk_two, symModeIndex_mk_two, hd]
  · -- `[2,1,1,1,1]`
    have hc : Multiset.card ({j, k, l, m} : Multiset ι) = 4 := by simp
    refine ⟨Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr
      (Sum.inr (Sum.inl (i, ⟨{j, k, l, m}, hc⟩)))))))))), ?_⟩
    show Finsupp.single ((i, 2) : ι × ℕ+) 1 + symModeIndex ι 1 ⟨{j, k, l, m}, hc⟩ = d
    rw [symModeIndex_mk_four, hd]
  · -- `[1⁶]`
    have hc : Multiset.card ({i, j, k, l, m, n} : Multiset ι) = 6 := by simp
    refine ⟨Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr
      (Sum.inr (Sum.inr ⟨{i, j, k, l, m, n}, hc⟩))))))))), ?_⟩
    show symModeIndex ι 1 ⟨{i, j, k, l, m, n}, hc⟩ = d
    rw [symModeIndex_mk_six, hd]

end LevelSixSurjOn

/-! ### The exact level-six count, and the `b̃`-free upper bound (U6) -/

section LevelCountsSix

variable (ι : Type*) [Fintype ι] [DecidableEq ι]

/-- **`p_m(6) = m + 2m² + m·C(m+1,2) + C(m+1,2) + m³ + m·C(m+2,3) + C(m+2,3) + C(m+1,2)²
+ m·C(m+3,4) + C(m+5,6)`**, the level-six count; the eleven index families of `LevelSixIdx` are
a bijective parametrisation. -/
theorem card_ddfLevel_six_eq :
    Fintype.card {d : (ι × ℕ+) →₀ ℕ // ddfLevel d = 6}
      = Fintype.card ι + 2 * (Fintype.card ι * Fintype.card ι)
        + Fintype.card ι * Nat.choose (Fintype.card ι + 1) 2 + Nat.choose (Fintype.card ι + 1) 2
        + Fintype.card ι * Fintype.card ι * Fintype.card ι
        + Fintype.card ι * Nat.choose (Fintype.card ι + 2) 3 + Nat.choose (Fintype.card ι + 2) 3
        + (Nat.choose (Fintype.card ι + 1) 2) * (Nat.choose (Fintype.card ι + 1) 2)
        + Fintype.card ι * Nat.choose (Fintype.card ι + 3) 4
        + Nat.choose (Fintype.card ι + 5) 6 := by
  classical
  have hcard : Fintype.card (LevelSixIdx ι)
      = Fintype.card ι + 2 * (Fintype.card ι * Fintype.card ι)
        + Fintype.card ι * Nat.choose (Fintype.card ι + 1) 2 + Nat.choose (Fintype.card ι + 1) 2
        + Fintype.card ι * Fintype.card ι * Fintype.card ι
        + Fintype.card ι * Nat.choose (Fintype.card ι + 2) 3 + Nat.choose (Fintype.card ι + 2) 3
        + (Nat.choose (Fintype.card ι + 1) 2) * (Nat.choose (Fintype.card ι + 1) 2)
        + Fintype.card ι * Nat.choose (Fintype.card ι + 3) 4
        + Nat.choose (Fintype.card ι + 5) 6 := by
    show Fintype.card (ι ⊕ (ι × ι) ⊕ (ι × ι) ⊕ (ι × Sym ι 2) ⊕ Sym ι 2 ⊕ (ι × ι × ι)
      ⊕ (ι × Sym ι 3) ⊕ Sym ι 3 ⊕ (Sym ι 2 × Sym ι 2) ⊕ (ι × Sym ι 4) ⊕ Sym ι 6) = _
    simp only [Fintype.card_sum, Fintype.card_prod, Sym.card_sym_eq_choose]
    rw [show Fintype.card ι + 2 - 1 = Fintype.card ι + 1 by omega,
      show Fintype.card ι + 3 - 1 = Fintype.card ι + 2 by omega,
      show Fintype.card ι + 4 - 1 = Fintype.card ι + 3 by omega,
      show Fintype.card ι + 6 - 1 = Fintype.card ι + 5 by omega]
    ring
  refine le_antisymm ?_ ?_
  · rw [← hcard]
    exact card_ddfLevel_le_of_surjOn (levelSixIndex ι) oscWeight_levelSixIndex
      fun _ hd => levelSixIndex_surjOn hd
  · rw [← hcard]
    refine Fintype.card_le_of_injective
      (fun x => (⟨levelSixIndex ι x, ?_⟩ : {d : (ι × ℕ+) →₀ ℕ // ddfLevel d = 6})) ?_
    · rw [ddfLevel_eq_oscWeight]; exact oscWeight_levelSixIndex x
    · intro x y hxy
      exact levelSixIndex_injective (congrArg Subtype.val hxy)

end LevelCountsSix

/-! ### From the level-six count to the `b̃`-free bound (U6) -/

section ConjFreeSix

variable {D : ℕ}

/-- ⭐ **(U6)**: `p_{D−1}(6) ≤ (D−1) + 2(D−1)² + (D−1)C(D,2) + C(D,2) + (D−1)³
+ (D−1)C(D+1,3) + C(D+1,3) + C(D,2)² + (D−1)C(D+2,4) + C(D+4,6)`, the upper bound on
`dim (H_phys ⊓ V_6)`. -/
theorem card_conjFree_six_le (hD : 2 ≤ D) :
    Fintype.card {d : Osc D →₀ ℕ // Fock.level D d = 6 ∧ conjDeg hD d = 0}
      ≤ (D - 1) + 2 * ((D - 1) * (D - 1)) + (D - 1) * Nat.choose D 2 + Nat.choose D 2
        + (D - 1) * (D - 1) * (D - 1) + (D - 1) * Nat.choose (D + 1) 3 + Nat.choose (D + 1) 3
        + (Nat.choose D 2) * (Nat.choose D 2) + (D - 1) * Nat.choose (D + 2) 4
        + Nat.choose (D + 4) 6 := by
  classical
  have hκ : Fintype.card {μ : Fin D // μ ≠ conjIdx D hD} = D - 1 := by
    rw [Fintype.card_subtype_compl, Fintype.card_subtype_eq, Fintype.card_fin]
  have h1 := card_ddfLevel_six_eq {μ : Fin D // μ ≠ conjIdx D hD}
  have h2 := card_conjFree_le_card_ddfLevel hD 6
  rw [hκ, show D - 1 + 1 = D by omega, show D - 1 + 2 = D + 1 by omega,
    show D - 1 + 3 = D + 2 by omega, show D - 1 + 5 = D + 4 by omega] at h1
  omega

end ConjFreeSix

/-! ### (K6): the two families overlap in at most `D` dimensions

Mirrors `LevelFiveCount`'s (K5) exactly, substituting `N = 6`.  The generic bound
`DescendantKernel.finrank_ker_descPair_add_le` gives
`dim ker T₆ + p_D(6) ≤ p_D(5) + p_D(4) + p_{D−1}(6)`, and `levelSix_count_identity_full` says
the right-hand side is `p_D(6) + D` (`κ₆ = D`, not the universal constant `κ₅ = 1`: this is the
`+1` versus `+D` gap the module docstring records).  **`D = 26` does not appear.** -/

section KernelSix

variable {D : ℕ} {K : Type*} [Field K] [CharZero K] [Algebra ℚ K] {η a b : Fin D → K}

/-- ⭐⭐ **(K6)**: `dim ker(T₆) ≤ D` on **every** rung, where
`T₆(φ, ψ) = L_{−1}φ + 𝒟₂ψ` on the whole slice `V_{j,5} × V_{j,4}`. -/
theorem finrank_ker_descPair_six_le (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (j : ℤ) :
    Module.finrank K ↥(LinearMap.ker (descPair η a b j 6)) ≤ D := by
  have h1 := finrank_ker_descPair_add_le hD F F.hη j 6 (by norm_num)
  simp only [show (6 : ℕ) - 1 = 5 from rfl, show (6 : ℕ) - 2 = 4 from rfl,
    nat_card_level_eq_card_ddfLevel] at h1
  have h2 := card_ddfLevel_six_eq (Fin D)
  have h3 := (card_ddfLevel_five_eq (Fin D)).le
  have h4 := card_ddfLevel_four_le (Fin D)
  have h5 := card_conjFree_six_le (D := D) hD
  have h6 := levelSix_count_identity_full (D := D) (by omega)
  rw [Fintype.card_fin] at h2 h3 h4
  omega

/-- (K6) restricted to the seeds: `dim ker(T₆|_{Q×Q}) ≤ D`. -/
theorem finrank_ker_seedPair_six_le (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (j : ℤ) :
    Module.finrank K ↥(LinearMap.ker (seedPair η a b j 6)) ≤ D :=
  le_trans (finrank_ker_seedPair_le j 6) (finrank_ker_descPair_six_le hD F j)

/-- ⭐ **(N6)**, the null lower bound on the level-six slice at `D = 26`:

`dim Q_{-6,5} + dim Q_{-6,4} ≤ dim (H_null ⊓ V_6) + D`.

Rank–nullity for `seedPair` on `Q_{-6,5} × Q_{-6,4}`: the image is contained in the null states
(Type 1 for the first factor, Type 2 for the second — again the only place `D = 26` is used),
and the kernel is at most `D`-dimensional by (K6).

⚠ This slack of `D` (as opposed to (N5)'s slack of `1`) is **exactly** the gap that keeps `B26 6`
from closing by the generic route: the assembly needs the slack sharpened to `D − 1`, i.e. a
genuine injectivity statement for `seedPair η a b (-6) 6` restricted to an appropriate summand,
which is new mathematics (see the module docstring `⟨路线判断，未验证⟩` note). -/
theorem le_finrank_towerNull_inf_towerBigrade_six (hD : 2 ≤ D) (F : DDFLightConeFrame η a b)
    (haa : Fock.zeroModeSq η a = 2) (hD26 : (D : K) = 26) :
    Module.finrank K ↥(towerSeed η a b (-6) 5) + Module.finrank K ↥(towerSeed η a b (-6) 4)
      ≤ Module.finrank K
          ↥(towerNullSubmodule η a b (1 : K) ⊓ towerBigrade D K (-6) 6) + D := by
  classical
  have hQ5fin : FiniteDimensional K ↥(towerSeed η a b (-6) ((6 : ℕ) - 1)) :=
    Submodule.finiteDimensional_of_le (K := K) (V := TowerFock D K)
      (S₁ := towerSeed η a b (-6) ((6 : ℕ) - 1))
      (S₂ := towerBigrade D K (-6) ((6 : ℕ) - 1)) inf_le_right
  have hQ4fin : FiniteDimensional K ↥(towerSeed η a b (-6) ((6 : ℕ) - 2)) :=
    Submodule.finiteDimensional_of_le (K := K) (V := TowerFock D K)
      (S₁ := towerSeed η a b (-6) ((6 : ℕ) - 2))
      (S₂ := towerBigrade D K (-6) ((6 : ℕ) - 2)) inf_le_right
  have hQ5free : Module.Free K ↥(towerSeed η a b (-6) ((6 : ℕ) - 1)) :=
    Module.Free.of_divisionRing K ↥(towerSeed η a b (-6) ((6 : ℕ) - 1))
  have hQ4free : Module.Free K ↥(towerSeed η a b (-6) ((6 : ℕ) - 2)) :=
    Module.Free.of_divisionRing K ↥(towerSeed η a b (-6) ((6 : ℕ) - 2))
  have hprod : FiniteDimensional K
      (↥(towerSeed η a b (-6) ((6 : ℕ) - 1)) × ↥(towerSeed η a b (-6) ((6 : ℕ) - 2))) :=
    inferInstanceAs (Module.Finite K
      (↥(towerSeed η a b (-6) ((6 : ℕ) - 1)) × ↥(towerSeed η a b (-6) ((6 : ℕ) - 2))))
  have hWfin : FiniteDimensional K
      ↥(towerNullSubmodule η a b (1 : K) ⊓ towerBigrade D K (-6) 6) :=
    Submodule.finiteDimensional_of_le (K := K) (V := TowerFock D K)
      (S₁ := towerNullSubmodule η a b (1 : K) ⊓ towerBigrade D K (-6) 6)
      (S₂ := towerBigrade D K (-6) 6) inf_le_right
  have hmem : ∀ x : ↥(towerSeed η a b (-6) ((6 : ℕ) - 1))
        × ↥(towerSeed η a b (-6) ((6 : ℕ) - 2)),
      seedPair η a b (-6) 6 x
        ∈ towerNullSubmodule η a b (1 : K) ⊓ towerBigrade D K (-6) 6 := by
    rintro ⟨⟨φ, hφ⟩, ⟨ψ, hψ⟩⟩
    have hpos5 : ∀ n : ℤ, 0 < n → towerLop η a b n φ = 0 := (mem_towerSeed.1 hφ).1
    have hbig5 : φ ∈ towerBigrade D K (-6) 5 := (mem_towerSeed.1 hφ).2
    have hpos4 : ∀ n : ℤ, 0 < n → towerLop η a b n ψ = 0 := (mem_towerSeed.1 hψ).1
    have hbig4 : ψ ∈ towerBigrade D K (-6) 4 := (mem_towerSeed.1 hψ).2
    have h1 := towerLop_neg_one_mem_towerNullSubmodule_of_mem_towerBigrade η a b F.hη
      F.frame.isotropic F.hba haa (j := -6) (N := 5) (by norm_num) hbig5 hpos5
    have h2 := descTwo_mem_towerNullSubmodule_of_mem_towerBigrade η a b F.hη F.frame.isotropic
      F.hba haa hD26 (j := -6) (N := 4) (by norm_num) hbig4 hpos4 (N' := 6) (by norm_num)
    rw [seedPair_apply]
    refine Submodule.add_mem _ ?_ h2
    have h56 : (5 : ℕ) + 1 = 6 := by norm_num
    rw [h56] at h1
    exact h1
  have hrk := LinearMap.finrank_range_add_finrank_ker
    (V := ↥(towerSeed η a b (-6) ((6 : ℕ) - 1)) × ↥(towerSeed η a b (-6) ((6 : ℕ) - 2)))
    (V₂ := TowerFock D K) (seedPair η a b (-6) 6)
  rw [Module.finrank_prod] at hrk
  have hrange : LinearMap.range (seedPair η a b (-6) 6)
      ≤ towerNullSubmodule η a b (1 : K) ⊓ towerBigrade D K (-6) 6 := by
    rintro _ ⟨x, rfl⟩
    exact hmem x
  have hle1 : Module.finrank K ↥(LinearMap.range (seedPair η a b (-6) 6))
      ≤ Module.finrank K ↥(towerNullSubmodule η a b (1 : K) ⊓ towerBigrade D K (-6) 6) :=
    Submodule.finrank_mono hrange
  have hker := finrank_ker_seedPair_six_le (K := K) (η := η) (a := a) (b := b) hD F (-6)
  have he : Module.finrank K ↥(towerSeed η a b (-6) ((6 : ℕ) - 1))
      = Module.finrank K ↥(towerSeed η a b (-6) 5) := rfl
  have hf : Module.finrank K ↥(towerSeed η a b (-6) ((6 : ℕ) - 2))
      = Module.finrank K ↥(towerSeed η a b (-6) 4) := rfl
  rw [he, hf] at hrk
  omega

end KernelSix

end StringFormal.NoGhost
