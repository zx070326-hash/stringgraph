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

end StringFormal.NoGhost
