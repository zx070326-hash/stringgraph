/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.LevelFourCount
import StringFormal.NoGhost.SingularVectorsSix
import StringFormal.NoGhost.SeedTransferSix

/-!
# `x₄` and `y₃` are each injective on the whole level-one slice

Graph nodes: `worldsheet.ddf-spanning-hypothesis`, `worldsheet.no-ghost-theorem-v4`.  This file
transcribes into Lean the mathematics of `research/attempts/s6-injectivity-level-six/proof.md`
("Form A" of that attempt): for **every** `D`, every `η` with `hη`, every rung `j` and every
`u` in the *whole* level-one slice `towerBigrade D R j 1` (not just a seed satisfying any extra
condition), `x₄ η a b u = 0 ⟹ u = 0` and `y₃ η a b u = 0 ⟹ u = 0`; hence the pair map
`u ↦ (x₄ u, y₃ u)` is injective on that slice.

## Scope: this is Form A only

`research/attempts/s6-injectivity-level-six/` also states a *second*, independently-reviewed
proposition ("Form B", `SixSeedKernelSharp` in `NoGhost/LevelSixClosure.lean`) about the kernel
of `descPair`/`seedPair` at `N = 6`.  **This file does not prove Form B and does not attempt the
bridge from Form A to Form B.**  That connection is bookkeeping about how the `N = 6` seed
criterion packages a level-1 vector as a `descPair`/`seedPair` argument; it is optional, low
priority, and out of scope for this PR by the task book that produced this file.

## Route chosen: moment functionals, not the oscillator-count grading

`proof.md`'s hand proof is built on a secondary "oscillator-count" grading `F(p) = ⊕_r F(p)^{(r)}`
(its Fact 0) and a monotonicity sub-lemma for that grading, then reads off the leading
single-oscillator coefficient of each `L_{-n}`-word (Lemma A/B) via that grading.  **None of that
machinery exists in this codebase, and none of it is needed**: `NoGhost/LevelThreeCount.lean`
and `NoGhost/LevelFourCount.lean` already contain a *moment-functional* toolbox — the polarised
annihilation operator `towerModeVec η a b ε p = A_ε(p)` (`NoGhost/DDFOperator.lean`) together
with:

* `towerModeVec_apply_towerLop` — the exact Lean analogue of `proof.md`'s **Lemma 0**
  (`A_ε(p)(L_n x) = L_n(A_ε(p)x) + p·A_ε(n+p)x`), already proved from the Virasoro/oscillator
  commutation relations (`NoGhost/DDFAlgebra.lean`), no re-derivation needed;
* `towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt` (`NoGhost/TypeOneFamily.lean`) — the
  exact analogue of `proof.md`'s **Consequence of Fact 0/Fact 1** ("a moment functional of order
  higher than the level of its argument annihilates it"), which is *definitional* here (levels are
  the eigengrading of the mode-number operator on `MvPolynomial (Osc D) R`) rather than something
  requiring a secondary grading and a monotonicity induction;
* `towerLop_mem_towerBigrade` (`NoGhost/Glue.lean`) — the Lean analogue of `proof.md`'s **Fact 1**
  (level bookkeeping for `L_{-n}`);
* `eq_zero_of_towerModeVec_eq_zero` (`NoGhost/LevelFourCount.lean`) — the nondegeneracy conclusion
  ("if every positive moment kills `x` on a slice of level `N ≠ 0`, `x = 0`"), proved there for
  **every** `N ≠ 0`, not just the specific level target needed there.

So every ingredient `proof.md` builds from scratch (Fact 0, its sub-lemma, Lemma A) is either
already a theorem in this repository or is bypassed entirely by working with the *whole* slice
via the nondegeneracy lemma instead of exhibiting an explicit spanning set and reading off a
leading coefficient.  This is a strictly shorter route to the same conclusion, and it is the one
taken below: each of `y₃`'s three words and `x₄`'s five words is evaluated by repeatedly commuting
a single *fixed* outer moment functional (`A_ε(4)` for `y₃`, `A_ε(5)` for `x₄`) past each
`L_{-n}` factor, exactly mirroring the recursive commutator bookkeeping of `proof.md`'s Lemma 0,
using the induction already available in the toolbox rather than reproving it.

## Honest disclosure: the computed constants differ from `proof.md` by a normalisation factor

`proof.md`'s Lemma B computes, via the oscillator-count grading, the raw leading coefficients
`30` (`y₃`) and `-408` (`x₄`) of the single-oscillator monomial `α^μ_{-4}|0;p⟩` /
`α^μ_{-5}|0;p⟩` inside `y₃(α^μ_{-1}|0;p⟩)` / `x₄(α^μ_{-1}|0;p⟩)`.

**This file instead computes `120` (`y₃`, via `A_ε(4)`) and `-2040` (`x₄`, via `A_ε(5)`)** —
genuinely computed inside Lean by `towerModeVec_four_y3_of_level_one` /
`towerModeVec_five_x4_of_level_one`, term by term, exactly as claimed below (**not** assumed as
hypotheses anywhere in this file). These are exactly `4×30` and `5×(-408)`, i.e. the extra factor
is precisely the *target* oscillator mode number (`4` for `y₃`, `5` for `x₄`). The reason is a
normalisation mismatch between the two extraction conventions, not a computational error:
`proof.md` reads off the coefficient of the monomial `α^μ_{-p}|0;p⟩` itself, whereas the moment
functional `A_ε(p) = towerModeVec η a b ε p` is built from `towerMode`/`Fock.annihilation`, whose
convention is the CCR-normalised one `[α_m, α_n] = m η^{..}δ_{m+n,0}`, so that
`A_ε(p)(α^μ_{-p}|0;p⟩) = p · η_μ ε_μ · |0;p⟩` — an extra factor of `p` relative to `proof.md`'s
raw-coefficient convention. Since `120 ≠ 0` and `-2040 ≠ 0` exactly when `30 ≠ 0` and
`-408 ≠ 0` (both are nonzero rationals, and the extra factor `4`/`5` is itself a nonzero
constant), the injectivity conclusion is identical either way; only the intermediate numeral
differs. This discrepancy is recorded here rather than hidden because the task book explicitly
requires distinguishing "genuinely computed" from "assumed" constants, and because a future
formalizer connecting this file's `towerModeVec_four_y3_of_level_one` /
`towerModeVec_five_x4_of_level_one` to any code that expects the raw `proof.md` constants `30`/
`-408` needs to know to divide by the target level.

## What is proved (Form A only)

* `towerModeVec_four_y3_of_level_one`, `towerModeVec_five_x4_of_level_one` — the two moment
  identities carrying all of the arithmetic (Lean-internal analogues of `proof.md`'s Lemma B).
* `y3_eq_zero_of_mem_towerBigrade_one`, `x4_eq_zero_of_mem_towerBigrade_one` — `y₃`/`x₄` restricted
  to the level-one slice have trivial kernel, in the direct "membership + maps-to-zero ⟹ is-zero"
  style already used by `TypeOneFamily.towerLop_neg_one_injective` for the same kind of statement
  (chosen over a `Set.InjOn`/`Function.Injective` packaging to match that precedent, and because
  linearity makes "trivial kernel on a submodule" and "injective on that submodule" the same fact
  without any further wrapper).
* `eq_zero_of_mem_towerBigrade_one_of_x4_eq_zero_of_y3_eq_zero` — the pair map `S₆ = (x₄, y₃)` has
  the same property (immediate from `x4_eq_zero_of_mem_towerBigrade_one` alone, as `proof.md`
  itself observes at the end of its Main theorem).

No `sorry`. No new axioms beyond the standard three (`propext`, `Classical.choice`,
`Quot.sound`), checked declaration-by-declaration in the accompanying report.
-/

namespace StringFormal.NoGhost

/-! ### Two new atomic moment/`L_{-n}` commutations

Everything else needed is already in `NoGhost/LevelThreeCount.lean` /
`NoGhost/LevelFourCount.lean` (`towerModeVec_two_towerLop_neg_one`,
`towerModeVec_three_towerLop_neg_one`, `towerModeVec_four_towerLop_neg_one`). These two fill the
two gaps the `x₄`/`y₃` word list needs beyond that ladder: descending three levels via `L_{-2}`
(rather than `L_{-1}`), and climbing the ladder one more rung to level five. -/

section ModeToolboxSix

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] {η a b ε : Fin D → R}

/-- `A_ε(3) L_{-2} u = 3 A_ε(1) u` for `u` of level one. -/
lemma towerModeVec_three_towerLop_neg_two_of_level_one (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    {u : TowerFock D R} (hu : u ∈ towerBigrade D R j 1) :
    towerModeVec η a b ε 3 (towerLop η a b (-2) u) = (3 : R) • towerModeVec η a b ε 1 u := by
  rw [towerModeVec_apply_towerLop η a b ε hη (-2) 3,
    towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hu (by norm_num), map_zero,
    zero_add, show (-2 : ℤ) + 3 = 1 by ring]
  norm_num

/-- `A_ε(5) L_{-1} φ = 5 A_ε(4) φ` for `φ` of level four. -/
lemma towerModeVec_five_towerLop_neg_one (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    {φ : TowerFock D R} (hφ : φ ∈ towerBigrade D R j 4) :
    towerModeVec η a b ε 5 (towerLop η a b (-1) φ) = (5 : R) • towerModeVec η a b ε 4 φ := by
  rw [towerModeVec_apply_towerLop η a b ε hη (-1) 5,
    towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hφ (by norm_num), map_zero,
    zero_add, show (-1 : ℤ) + 5 = 4 by ring]
  norm_num

end ModeToolboxSix

/-! ### `y₃`'s three words, evaluated by `A_ε(4)` on a level-one seed -/

section WordsSix

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] {η a b ε : Fin D → R}

/-- `A_ε(4) L_{-3} u = 4 A_ε(1) u` for `u` of level one. -/
lemma towerModeVec_four_towerLop_neg_three_of_level_one (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    {u : TowerFock D R} (hu : u ∈ towerBigrade D R j 1) :
    towerModeVec η a b ε 4 (towerLop η a b (-3) u) = (4 : R) • towerModeVec η a b ε 1 u := by
  rw [towerModeVec_apply_towerLop η a b ε hη (-3) 4,
    towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hu (by norm_num), map_zero,
    zero_add, show (-3 : ℤ) + 4 = 1 by ring]
  norm_num

/-- `A_ε(4) L_{-2} L_{-1} u = 8 A_ε(1) u` for `u` of level one. -/
lemma towerModeVec_four_towerLop_neg_two_towerLop_neg_one_of_level_one
    (hη : ∀ μ, η μ * η μ = 1) {j : ℤ} {u : TowerFock D R} (hu : u ∈ towerBigrade D R j 1) :
    towerModeVec η a b ε 4 (towerLop η a b (-2) (towerLop η a b (-1) u))
      = (8 : R) • towerModeVec η a b ε 1 u := by
  have hu1 : towerLop η a b (-1) u ∈ towerBigrade D R j 2 :=
    towerLop_mem_towerBigrade η a b hu (by norm_num)
  rw [towerModeVec_apply_towerLop η a b ε hη (-2) 4,
    towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hu1 (by norm_num), map_zero,
    zero_add, show (-2 : ℤ) + 4 = 2 by ring, towerModeVec_two_towerLop_neg_one hη hu, smul_smul]
  norm_num

/-- `A_ε(4) L_{-1}³ u = 24 A_ε(1) u` for `u` of level one. -/
lemma towerModeVec_four_towerLop_neg_one_cube_of_level_one (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    {u : TowerFock D R} (hu : u ∈ towerBigrade D R j 1) :
    towerModeVec η a b ε 4
        (towerLop η a b (-1) (towerLop η a b (-1) (towerLop η a b (-1) u)))
      = (24 : R) • towerModeVec η a b ε 1 u := by
  have hu1 : towerLop η a b (-1) u ∈ towerBigrade D R j 2 :=
    towerLop_mem_towerBigrade η a b hu (by norm_num)
  have hu2 : towerLop η a b (-1) (towerLop η a b (-1) u) ∈ towerBigrade D R j 3 :=
    towerLop_mem_towerBigrade η a b hu1 (by norm_num)
  have h1 : towerModeVec η a b ε 2 (towerLop η a b (-1) u) = (2 : R) • towerModeVec η a b ε 1 u :=
    towerModeVec_two_towerLop_neg_one hη hu
  have h2 : towerModeVec η a b ε 3 (towerLop η a b (-1) (towerLop η a b (-1) u))
      = (3 : R) • towerModeVec η a b ε 2 (towerLop η a b (-1) u) :=
    towerModeVec_three_towerLop_neg_one hη hu1
  rw [towerModeVec_apply_towerLop η a b ε hη (-1) 4,
    towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hu2 (by norm_num), map_zero,
    zero_add, show (-1 : ℤ) + 4 = 3 by ring, h2, h1, smul_smul, smul_smul]
  norm_num

/-- **`y₃`'s leading moment**: `A_ε(4) (y₃ u) = 120 A_ε(1) u` for `u` of level one.

This is the Lean-internal analogue of `proof.md`'s Lemma B for `y₃`; see the file docstring for
why the constant is `120` rather than `proof.md`'s `30` (a factor of the target level `4`, a
normalisation artifact, not a discrepancy in the conclusion). -/
theorem towerModeVec_four_y3_of_level_one (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    {u : TowerFock D R} (hu : u ∈ towerBigrade D R j 1) :
    towerModeVec η a b ε 4 (y3 η a b u) = (120 : R) • towerModeVec η a b ε 1 u := by
  rw [y3_apply, map_add, map_add, map_smul, map_smul,
    towerModeVec_four_towerLop_neg_three_of_level_one hη hu,
    towerModeVec_four_towerLop_neg_two_towerLop_neg_one_of_level_one hη hu,
    towerModeVec_four_towerLop_neg_one_cube_of_level_one hη hu,
    smul_smul, smul_smul, ← add_smul, ← add_smul]
  norm_num

end WordsSix

/-! ### `x₄`'s five words, evaluated by `A_ε(5)` on a level-one seed -/

section WordsSixX4

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] {η a b ε : Fin D → R}

/-- `A_ε(5) L_{-4} u = 5 A_ε(1) u` for `u` of level one. -/
lemma towerModeVec_five_towerLop_neg_four_of_level_one (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    {u : TowerFock D R} (hu : u ∈ towerBigrade D R j 1) :
    towerModeVec η a b ε 5 (towerLop η a b (-4) u) = (5 : R) • towerModeVec η a b ε 1 u := by
  rw [towerModeVec_apply_towerLop η a b ε hη (-4) 5,
    towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hu (by norm_num), map_zero,
    zero_add, show (-4 : ℤ) + 5 = 1 by ring]
  norm_num

/-- `A_ε(5) L_{-3} L_{-1} u = 10 A_ε(1) u` for `u` of level one. -/
lemma towerModeVec_five_towerLop_neg_three_towerLop_neg_one_of_level_one
    (hη : ∀ μ, η μ * η μ = 1) {j : ℤ} {u : TowerFock D R} (hu : u ∈ towerBigrade D R j 1) :
    towerModeVec η a b ε 5 (towerLop η a b (-3) (towerLop η a b (-1) u))
      = (10 : R) • towerModeVec η a b ε 1 u := by
  have hu1 : towerLop η a b (-1) u ∈ towerBigrade D R j 2 :=
    towerLop_mem_towerBigrade η a b hu (by norm_num)
  rw [towerModeVec_apply_towerLop η a b ε hη (-3) 5,
    towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hu1 (by norm_num), map_zero,
    zero_add, show (-3 : ℤ) + 5 = 2 by ring, towerModeVec_two_towerLop_neg_one hη hu, smul_smul]
  norm_num

/-- `A_ε(5) L_{-2}² u = 15 A_ε(1) u` for `u` of level one. -/
lemma towerModeVec_five_towerLop_neg_two_sq_of_level_one (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    {u : TowerFock D R} (hu : u ∈ towerBigrade D R j 1) :
    towerModeVec η a b ε 5 (towerLop η a b (-2) (towerLop η a b (-2) u))
      = (15 : R) • towerModeVec η a b ε 1 u := by
  have hu1 : towerLop η a b (-2) u ∈ towerBigrade D R j 3 :=
    towerLop_mem_towerBigrade η a b hu (by norm_num)
  rw [towerModeVec_apply_towerLop η a b ε hη (-2) 5,
    towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hu1 (by norm_num), map_zero,
    zero_add, show (-2 : ℤ) + 5 = 3 by ring,
    towerModeVec_three_towerLop_neg_two_of_level_one hη hu, smul_smul]
  norm_num

/-- `A_ε(5) L_{-2} L_{-1}² u = 30 A_ε(1) u` for `u` of level one. -/
lemma towerModeVec_five_towerLop_neg_two_towerLop_neg_one_sq_of_level_one
    (hη : ∀ μ, η μ * η μ = 1) {j : ℤ} {u : TowerFock D R} (hu : u ∈ towerBigrade D R j 1) :
    towerModeVec η a b ε 5
        (towerLop η a b (-2) (towerLop η a b (-1) (towerLop η a b (-1) u)))
      = (30 : R) • towerModeVec η a b ε 1 u := by
  have hu1 : towerLop η a b (-1) u ∈ towerBigrade D R j 2 :=
    towerLop_mem_towerBigrade η a b hu (by norm_num)
  have hu2 : towerLop η a b (-1) (towerLop η a b (-1) u) ∈ towerBigrade D R j 3 :=
    towerLop_mem_towerBigrade η a b hu1 (by norm_num)
  have h1 : towerModeVec η a b ε 2 (towerLop η a b (-1) u) = (2 : R) • towerModeVec η a b ε 1 u :=
    towerModeVec_two_towerLop_neg_one hη hu
  have h2 : towerModeVec η a b ε 3 (towerLop η a b (-1) (towerLop η a b (-1) u))
      = (3 : R) • towerModeVec η a b ε 2 (towerLop η a b (-1) u) :=
    towerModeVec_three_towerLop_neg_one hη hu1
  rw [towerModeVec_apply_towerLop η a b ε hη (-2) 5,
    towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hu2 (by norm_num), map_zero,
    zero_add, show (-2 : ℤ) + 5 = 3 by ring, h2, h1, smul_smul, smul_smul]
  norm_num

/-- `A_ε(5) L_{-1}⁴ u = 120 A_ε(1) u` for `u` of level one. -/
lemma towerModeVec_five_towerLop_neg_one_pow_four_of_level_one
    (hη : ∀ μ, η μ * η μ = 1) {j : ℤ} {u : TowerFock D R} (hu : u ∈ towerBigrade D R j 1) :
    towerModeVec η a b ε 5
        (towerLop η a b (-1)
          (towerLop η a b (-1) (towerLop η a b (-1) (towerLop η a b (-1) u))))
      = (120 : R) • towerModeVec η a b ε 1 u := by
  have hu3 : towerLop η a b (-1) (towerLop η a b (-1) (towerLop η a b (-1) u))
      ∈ towerBigrade D R j 4 := by
    have hu1 : towerLop η a b (-1) u ∈ towerBigrade D R j 2 :=
      towerLop_mem_towerBigrade η a b hu (by norm_num)
    have hu2 : towerLop η a b (-1) (towerLop η a b (-1) u) ∈ towerBigrade D R j 3 :=
      towerLop_mem_towerBigrade η a b hu1 (by norm_num)
    exact towerLop_mem_towerBigrade η a b hu2 (by norm_num)
  rw [towerModeVec_apply_towerLop η a b ε hη (-1) 5,
    towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hu3 (by norm_num), map_zero,
    zero_add, show (-1 : ℤ) + 5 = 4 by ring,
    towerModeVec_four_towerLop_neg_one_cube_of_level_one hη hu, smul_smul]
  norm_num

/-- **`x₄`'s leading moment**: `A_ε(5) (x₄ u) = -2040 A_ε(1) u` for `u` of level one.

This is the Lean-internal analogue of `proof.md`'s Lemma B for `x₄`; see the file docstring for
why the constant is `-2040` rather than `proof.md`'s `-408` (a factor of the target level `5`, a
normalisation artifact, not a discrepancy in the conclusion). -/
theorem towerModeVec_five_x4_of_level_one (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    {u : TowerFock D R} (hu : u ∈ towerBigrade D R j 1) :
    towerModeVec η a b ε 5 (x4 η a b u) = (-2040 : R) • towerModeVec η a b ε 1 u := by
  rw [x4_apply, map_add, map_add, map_add, map_add, map_smul, map_smul, map_smul, map_smul,
    map_smul,
    towerModeVec_five_towerLop_neg_four_of_level_one hη hu,
    towerModeVec_five_towerLop_neg_three_towerLop_neg_one_of_level_one hη hu,
    towerModeVec_five_towerLop_neg_two_sq_of_level_one hη hu,
    towerModeVec_five_towerLop_neg_two_towerLop_neg_one_sq_of_level_one hη hu,
    towerModeVec_five_towerLop_neg_one_pow_four_of_level_one hη hu,
    smul_smul, smul_smul, smul_smul, smul_smul, smul_smul,
    ← add_smul, ← add_smul, ← add_smul, ← add_smul]
  norm_num

end WordsSixX4

/-! ### Main theorem: `x₄`, `y₃`, and their pair, injective on the whole level-one slice -/

section MainInjectivitySix

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] [NoZeroDivisors R] [CharZero R]
  {η a b : Fin D → R}

/-- If every polarised `1`-moment of `u` vanishes and `u` is of level one, `u = 0`. Wraps
`eq_zero_of_towerModeVec_eq_zero` (valid at any positive level) down to the single moment order
that is nonzero a priori on a level-one vector: every `A_ε(p)` with `p > 1` already vanishes by
`towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt`. -/
private lemma eq_zero_of_towerModeVec_one_eq_zero_of_mem_towerBigrade_one
    (hη : ∀ μ, η μ * η μ = 1) {j : ℤ} {u : TowerFock D R} (hu : u ∈ towerBigrade D R j 1)
    (h : ∀ ε : Fin D → R, towerModeVec η a b ε 1 u = 0) : u = 0 := by
  refine eq_zero_of_towerModeVec_eq_zero (a := a) (b := b) hη one_ne_zero hu fun ε p hp => ?_
  by_cases hp1 : p = 1
  · rw [hp1]; exact h ε
  · exact towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hu (by omega)

/-- **`x₄` is injective on the whole level-one slice** (`proof.md`'s Main theorem, `x₄` half). -/
theorem x4_eq_zero_of_mem_towerBigrade_one (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    {u : TowerFock D R} (hu : u ∈ towerBigrade D R j 1) (h : x4 η a b u = 0) : u = 0 := by
  refine eq_zero_of_towerModeVec_one_eq_zero_of_mem_towerBigrade_one (a := a) (b := b) hη hu
    fun ε => ?_
  have hkey := congrArg (towerModeVec η a b ε 5) h
  rw [map_zero, towerModeVec_five_x4_of_level_one hη hu] at hkey
  exact eq_zero_of_intCast_smul_eq_zero' (R := R) (M := TowerFock D R) (k := -2040)
    (by norm_num) (by exact_mod_cast hkey)

/-- **`y₃` is injective on the whole level-one slice** (`proof.md`'s Main theorem, `y₃` half). -/
theorem y3_eq_zero_of_mem_towerBigrade_one (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    {u : TowerFock D R} (hu : u ∈ towerBigrade D R j 1) (h : y3 η a b u = 0) : u = 0 := by
  refine eq_zero_of_towerModeVec_one_eq_zero_of_mem_towerBigrade_one (a := a) (b := b) hη hu
    fun ε => ?_
  have hkey := congrArg (towerModeVec η a b ε 4) h
  rw [map_zero, towerModeVec_four_y3_of_level_one hη hu] at hkey
  exact eq_zero_of_natCast_smul_eq_zero (R := R) (W := TowerFock D R) (k := 120) (by norm_num)
    (by exact_mod_cast hkey)

/-- **The pair map `S₆ = (x₄, y₃)` is injective on the whole level-one slice**: immediate from
`x4_eq_zero_of_mem_towerBigrade_one` alone, exactly as `proof.md`'s Main theorem observes
("since `x₄` alone is injective, `S` is a fortiori injective"). -/
theorem eq_zero_of_mem_towerBigrade_one_of_x4_eq_zero_of_y3_eq_zero
    (hη : ∀ μ, η μ * η μ = 1) {j : ℤ} {u : TowerFock D R} (hu : u ∈ towerBigrade D R j 1)
    (hx : x4 η a b u = 0) (_hy : y3 η a b u = 0) : u = 0 :=
  x4_eq_zero_of_mem_towerBigrade_one hη hu hx

end MainInjectivitySix

end StringFormal.NoGhost
