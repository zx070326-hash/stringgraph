/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.NullSeedsTwo

/-!
# The `N = 6` syzygy pair: `x₄`, `y₃`, and the universal identity `L_{-1}x₄ + 𝒟₂y₃ = 0`

Graph nodes: `worldsheet.ddf-spanning-hypothesis`, `worldsheet.no-ghost-theorem-v4`.  This is
**PR-D1 of blueprint `formal/BLUEPRINT-noghost.md` §B⁗.2 / §B⁗.9** (the `[GAP-N6-seed]` closure,
2026-09-17): §B⁗.9 states the `N = 6` seed criterion is true and sharp exactly at `D = 26`, and
names its first Lean-facing prerequisite as *fact 3*, the syzygy pair `(x₄, y₃)` and the identity
`L_{-1}x₄ + 𝒟₂y₃ = 0` in `U(Vir⁻)`.  This file supplies exactly that piece.

Cross-check performed before writing any Lean: the coefficients of `x₄`, `y₃` and the identity
`L_{-1}x₄ + 𝒟₂y₃ = 0` are stated **identically** in §B⁗.2 (where they are derived, by solving a
rank-`7` linear system on the level-5 PBW basis `U_5`), in §B⁗.9's "前置事实 3" (which reuses
§B⁗.2's operators verbatim), and in `BLUEPRINT-noghost-N6.md` (lines 281, 337-338, 386, 404-407,
461, all citing the same `§B⁗.2` computation).  **No discrepancy found.**

## Main definitions

* `y3 η a b := 12 L_{-3} + 6 L_{-2}L_{-1} + L_{-1}³` — the `(3,1)` Kac singular-vector operator
  at level 3 (verbatim from §B⁗.2's derivation: it is the level-3 singular vector of `V(26,-4)`).
* `x4 η a b := -76 L_{-4} - 52 L_{-3}L_{-1} - 12 L_{-2}² - 20 L_{-2}L_{-1}² - 3 L_{-1}⁴` — its
  syzygy partner at level 4 (identified in §B⁗.2 as the `(1,4)` singular vector, via
  `L_{-1}`-injectivity rather than the general Kac formula).

Both are defined as `Module.End R (TowerFock D R)` built from `towerLop`, exactly as `descTwo` is
in `NoGhost/NullSeedsTwo.lean` (reused here, not redefined).

## Main result

* ⭐⭐⭐ `towerLop_neg_one_mul_x4_add_descTwo_mul_y3` — **the syzygy identity**
  `L_{-1} x₄ + 𝒟₂ y₃ = 0` as an operator equation on `TowerFock D R`, for *every* `D`, `R` (a
  `ℚ`-algebra) and every `η, a, b`.  This is a pure identity in the universal enveloping algebra
  of the negative-mode Witt subalgebra: no central term ever appears (every commutator used is
  between two negative modes, so `m + n ≠ 0` always), and it holds independently of the choice of
  highest weight `(c, h)`.

  **Proof strategy**: four elementary commutator identities (`towerLop_neg_one_apply_towerLop_neg_two`
  through `towerLop_neg_two_apply_towerLop_neg_three`, each a single instance of
  `TowerVirasoro.towerLop_apply_towerLop_of_ne_zero`) generate — by repeated `simp`-driven
  rewriting, which normal-orders every word to "larger mode magnitude on the outside" — a
  terminating rewriting system on words in `L_{-1}, L_{-2}, L_{-3}, L_{-4}` of total weight `5`.
  Both `L_{-1}(x₄v)` and `𝒟₂(y₃v)`, once fully normal-ordered by this system, land in the
  `7`-dimensional space spanned by the ordered words of `U_5` (blueprint §B⁗.2's basis
  `L_{-5}, L_{-4}L_{-1}, L_{-3}L_{-2}, L_{-3}L_{-1}², L_{-2}²L_{-1}, L_{-2}L_{-1}³, L_{-1}⁵`), with
  coefficients that are termwise negatives of each other — exactly the cancellation blueprint
  §B⁗.2 checked by hand (`-240`/`+240` on `L_{-5}`, `-180`/`+180` on `L_{-4}L_{-1}`, etc.).  The
  final arithmetic is closed by the `module` tactic.

## Longitudinal half (bonus item, done)

`towerLop_one_apply_y3_towerLop_neg_one_of_eq_neg_five` proves `L_1 (y₃ (L_{-1}φ)) = 2h • y₃φ` for
any seed `φ` of weight `h = -5` (any central charge).  **Discovered while proving it**: the
identity is `h`-sharp (only true at `h = -5`, not for general `h`) but is *independent of the
central charge* — see the section docstring above `Longitudinal` for the full explanation; this
refines (does not contradict) blueprint §B⁗.9's framing of the computation as living "in `V(26,
-5)`".

## What is **not** done here (explicitly out of scope for this PR)

* The **transverse half**: that `x₄v`, `y₃v` are singular vectors of `V(26,-4)` (`v` the rung-`-5`
  Fock vacuum) is *not* formalised in this file.  **Now done in
  `NoGhost/SingularVectorsSix.lean`** (`y3_mem_towerPositiveModeSubmodule`,
  `x4_mem_towerPositiveModeSubmodule`), transported onto the slice by
  `NoGhost/SingularVectorsSixSlice.lean`.
* The `N = 6` seed criterion itself (`x₄u ∈ Q_{-6,5} ∧ y₃u ∈ Q_{-6,4} ⟹ u ∈ Q_{-6,1}`, §B⁗.9's
  main theorem) is untouched here: this file only supplies its "前置事实 3" plus the longitudinal
  half.  **Now done in `NoGhost/SeedCriterionSix.lean`** (`mem_towerSeed_neg_six_one_iff`), which
  consumes `towerLop_one_apply_y3_towerLop_neg_one_of_eq_neg_five` below as its longitudinal input.
  Still open: the `N = 6` count itself (`b26_six`, `ddfSpans_bigrade_neg_six_six`); see
  `formal/TODO.md` entry `noghost-pr-d2`.
-/

namespace StringFormal.NoGhost

/-! ### The two syzygy operators `y₃`, `x₄` (blueprint §B⁗.2, "前置事实 3" of §B⁗.9) -/

section SyzygyOperators

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

/-- **`y₃ = 12 L_{-3} + 6 L_{-2}L_{-1} + L_{-1}³`**, the level-3 half of the syzygy pair of
blueprint §B⁗.2.  On the rung-`-5` Fock vacuum (`h = -4`, `c = 26`) this is exactly the Kac
`(3,1)` singular vector. -/
noncomputable def y3 (η a b : Fin D → R) : Module.End R (TowerFock D R) :=
  (12 : R) • towerLop η a b (-3)
    + (6 : R) • (towerLop η a b (-2) * towerLop η a b (-1))
    + towerLop η a b (-1) * towerLop η a b (-1) * towerLop η a b (-1)

lemma y3_apply (η a b : Fin D → R) (v : TowerFock D R) :
    y3 η a b v
      = (12 : R) • towerLop η a b (-3) v
        + (6 : R) • towerLop η a b (-2) (towerLop η a b (-1) v)
        + towerLop η a b (-1) (towerLop η a b (-1) (towerLop η a b (-1) v)) := rfl

/-- **`x₄ = -76 L_{-4} - 52 L_{-3}L_{-1} - 12 L_{-2}² - 20 L_{-2}L_{-1}² - 3 L_{-1}⁴`**, the
level-4 half of the syzygy pair of blueprint §B⁗.2, identified there (via `L_{-1}`-injectivity)
as the Kac `(1,4)` singular vector at `h = -4`, `c = 26`. -/
noncomputable def x4 (η a b : Fin D → R) : Module.End R (TowerFock D R) :=
  (-76 : R) • towerLop η a b (-4)
    + (-52 : R) • (towerLop η a b (-3) * towerLop η a b (-1))
    + (-12 : R) • (towerLop η a b (-2) * towerLop η a b (-2))
    + (-20 : R) • (towerLop η a b (-2) * towerLop η a b (-1) * towerLop η a b (-1))
    + (-3 : R) • (towerLop η a b (-1) * towerLop η a b (-1) * towerLop η a b (-1)
        * towerLop η a b (-1))

lemma x4_apply (η a b : Fin D → R) (v : TowerFock D R) :
    x4 η a b v
      = (-76 : R) • towerLop η a b (-4) v
        + (-52 : R) • towerLop η a b (-3) (towerLop η a b (-1) v)
        + (-12 : R) • towerLop η a b (-2) (towerLop η a b (-2) v)
        + (-20 : R) • towerLop η a b (-2) (towerLop η a b (-1) (towerLop η a b (-1) v))
        + (-3 : R) • towerLop η a b (-1) (towerLop η a b (-1)
            (towerLop η a b (-1) (towerLop η a b (-1) v))) := rfl

end SyzygyOperators

/-! ### Four elementary commutators between negative modes

Every commutator used below is between two *negative* modes, so `m + n ≠ 0` always and
`TowerVirasoro.towerLop_apply_towerLop_of_ne_zero` never has a central term to discard.  These
four facts, used as rewrite rules, normal-order any word in `L_{-1}, …, L_{-4}` of the shape
needed here to "larger mode magnitude outside" — the PBW convention of blueprint §B⁗.2. -/

section Atoms

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] (η a b : Fin D → R)
variable (hη : ∀ μ, η μ * η μ = 1)

include hη in
/-- `L_{-1}L_{-2} = L_{-2}L_{-1} + L_{-3}`. -/
lemma towerLop_neg_one_apply_towerLop_neg_two (v : TowerFock D R) :
    towerLop η a b (-1) (towerLop η a b (-2) v)
      = towerLop η a b (-2) (towerLop η a b (-1) v) + towerLop η a b (-3) v := by
  have h := towerLop_apply_towerLop_of_ne_zero η a b hη (m := -1) (n := -2) (by decide) v
  rw [show (-1 : ℤ) + -2 = -3 by decide] at h
  rw [h]
  module

include hη in
/-- `L_{-1}L_{-3} = L_{-3}L_{-1} + 2L_{-4}`. -/
lemma towerLop_neg_one_apply_towerLop_neg_three (v : TowerFock D R) :
    towerLop η a b (-1) (towerLop η a b (-3) v)
      = towerLop η a b (-3) (towerLop η a b (-1) v) + (2 : R) • towerLop η a b (-4) v := by
  have h := towerLop_apply_towerLop_of_ne_zero η a b hη (m := -1) (n := -3) (by decide) v
  rw [show (-1 : ℤ) + -3 = -4 by decide] at h
  rw [h]
  module

include hη in
/-- `L_{-1}L_{-4} = L_{-4}L_{-1} + 3L_{-5}`. -/
lemma towerLop_neg_one_apply_towerLop_neg_four (v : TowerFock D R) :
    towerLop η a b (-1) (towerLop η a b (-4) v)
      = towerLop η a b (-4) (towerLop η a b (-1) v) + (3 : R) • towerLop η a b (-5) v := by
  have h := towerLop_apply_towerLop_of_ne_zero η a b hη (m := -1) (n := -4) (by decide) v
  rw [show (-1 : ℤ) + -4 = -5 by decide] at h
  rw [h]
  module

include hη in
/-- `L_{-2}L_{-3} = L_{-3}L_{-2} + L_{-5}`. -/
lemma towerLop_neg_two_apply_towerLop_neg_three (v : TowerFock D R) :
    towerLop η a b (-2) (towerLop η a b (-3) v)
      = towerLop η a b (-3) (towerLop η a b (-2) v) + towerLop η a b (-5) v := by
  have h := towerLop_apply_towerLop_of_ne_zero η a b hη (m := -2) (n := -3) (by decide) v
  rw [show (-2 : ℤ) + -3 = -5 by decide] at h
  rw [h]
  module

end Atoms

/-! ### The syzygy identity -/

section SyzygyIdentity

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] (η a b : Fin D → R)
variable (hη : ∀ μ, η μ * η μ = 1)

include hη in
/-- ⭐⭐⭐ **The syzygy identity of blueprint §B⁗.2 / §B⁗.9**:

`L_{-1} x₄ + 𝒟₂ y₃ = 0` as an operator equation on `TowerFock D R`.

A universal identity in `U(Vir⁻)`: it holds for every `D`, every `ℚ`-algebra `R`, and every
`η, a, b` — no central charge, no highest weight, no seed hypothesis enters.  This is the
foundation of blueprint §B⁗.9's `N = 6` seed criterion: `(x₄, y₃)` is the syzygy pair whose
images must simultaneously avoid being seeds unless the level-1 state they came from already was
one. -/
theorem towerLop_neg_one_mul_x4_add_descTwo_mul_y3 :
    towerLop η a b (-1) * x4 η a b + descTwo η a b * y3 η a b = 0 := by
  refine LinearMap.ext fun v => ?_
  simp only [LinearMap.add_apply, Module.End.mul_apply, LinearMap.zero_apply]
  rw [x4_apply, y3_apply]
  simp only [map_add, map_smul, descTwo_apply,
    towerLop_neg_one_apply_towerLop_neg_two η a b hη,
    towerLop_neg_one_apply_towerLop_neg_three η a b hη,
    towerLop_neg_one_apply_towerLop_neg_four η a b hη,
    towerLop_neg_two_apply_towerLop_neg_three η a b hη]
  module

end SyzygyIdentity

/-! ### The longitudinal half of blueprint §B⁗.9: `L_1 (y₃ L_{-1}φ) = 2h • y₃φ`, sharp at `h = -5`

This is the "time permitting" bonus item of this PR.  Direct hand computation (done before writing
any Lean, mirroring `NullSeedsTwo`'s style) shows

`L_1 (y₃ (L_{-1}φ)) = 24h • L_{-3}φ + (24h + 60) • L_{-2}(L_{-1}φ) + (8h + 30) • L_{-1}³φ`

for **every** `h` (`φ` any seed of weight `h`), against `2h • y₃φ = 24h • L_{-3}φ + 12h •
L_{-2}(L_{-1}φ) + 2h • L_{-1}³φ`.  The `L_{-3}φ` coefficients already agree identically; the other
two force `h = -5` (`24h + 60 = 12h` and `8h + 30 = 2h` both solve to `h = -5`).  **No condition on
the central charge ever appears**: every commutator used is `⁅L_1, L_{-1}⁆ = 2L_0` (zero central
term, `centralTerm_one_eq_zero`), `⁅L_1, L_{-2}⁆ = 3L_{-1}`, or `⁅L_1, L_{-3}⁆ = 4L_{-2}` — none of
them diagonal at `±2`, so the central charge never enters.  This refines blueprint §B⁗.9's remark
that the identity is "算得干净的结果...在 Verma 模 `V(26,-5)`": the computation below shows `c = 26`
plays no role in *this particular* identity, only `h = -5` does (the `c = 26` dependence of the
overall `N = 6` argument enters elsewhere, e.g. through the syzygy identity's Kac-side use in the
transverse half, which this file does not attempt). -/

section Longitudinal

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] (η a b : Fin D → R)
variable (hη : ∀ μ, η μ * η μ = 1)

include hη in
/-- `L_1 L_{-1} x = L_{-1} L_1 x + 2 L_0 x` for **any** vector `x` (no seed hypothesis needed):
`⁅L_1, L_{-1}⁆ = 2L_0` has weight `0` in `m`, hence zero central term regardless of `x`
(`centralTerm_one_eq_zero`). -/
lemma towerLop_one_apply_towerLop_neg_one_of_any (x : TowerFock D R) :
    towerLop η a b 1 (towerLop η a b (-1) x)
      = towerLop η a b (-1) (towerLop η a b 1 x) + (2 : R) • towerLop η a b 0 x := by
  have h := towerLop_apply_towerLop_neg η a b hη 1 x
  rw [centralTerm_one_eq_zero, mul_zero, zero_smul, add_zero] at h
  rw [h]
  module

variable {h : R} {φ : TowerFock D R}
variable (hpos : ∀ n : ℤ, 0 < n → towerLop η a b n φ = 0)
variable (h0 : towerLop η a b 0 φ = h • φ)

include hη h0 in
/-- `L_0 (L_{-1}²φ) = (h + 2) • L_{-1}²φ`. -/
lemma towerLop_zero_apply_towerLop_neg_one_sq :
    towerLop η a b 0 (towerLop η a b (-1) (towerLop η a b (-1) φ))
      = (h + 2) • towerLop η a b (-1) (towerLop η a b (-1) φ) := by
  rw [towerLop_zero_apply_towerLop_neg_one η a b hη
    (towerLop_zero_apply_towerLop_neg_one η a b hη h0)]
  match_scalars; ring

include hη h0 in
/-- `L_0 (L_{-1}³φ) = (h + 3) • L_{-1}³φ`. -/
lemma towerLop_zero_apply_towerLop_neg_one_cube :
    towerLop η a b 0
        (towerLop η a b (-1) (towerLop η a b (-1) (towerLop η a b (-1) φ)))
      = (h + 3) • towerLop η a b (-1) (towerLop η a b (-1) (towerLop η a b (-1) φ)) := by
  rw [towerLop_zero_apply_towerLop_neg_one η a b hη
    (towerLop_zero_apply_towerLop_neg_one_sq η a b hη h0)]
  match_scalars; ring

include hη hpos h0 in
/-- `L_1 (L_{-1}²φ) = (4h + 2) • L_{-1}φ`. -/
lemma towerLop_one_apply_towerLop_neg_one_sq :
    towerLop η a b 1 (towerLop η a b (-1) (towerLop η a b (-1) φ))
      = (4 * h + 2) • towerLop η a b (-1) φ := by
  rw [towerLop_one_apply_towerLop_neg_one_of_any η a b hη (towerLop η a b (-1) φ),
    towerLop_one_apply_towerLop_neg_one η a b hη hpos h0,
    towerLop_zero_apply_towerLop_neg_one η a b hη h0, map_smul]
  match_scalars; ring

include hη hpos h0 in
/-- `L_1 (L_{-1}³φ) = (6h + 6) • L_{-1}²φ`. -/
lemma towerLop_one_apply_towerLop_neg_one_cube :
    towerLop η a b 1
        (towerLop η a b (-1) (towerLop η a b (-1) (towerLop η a b (-1) φ)))
      = (6 * h + 6) • towerLop η a b (-1) (towerLop η a b (-1) φ) := by
  rw [towerLop_one_apply_towerLop_neg_one_of_any η a b hη
      (towerLop η a b (-1) (towerLop η a b (-1) φ)),
    towerLop_one_apply_towerLop_neg_one_sq η a b hη hpos h0,
    towerLop_zero_apply_towerLop_neg_one_sq η a b hη h0, map_smul]
  match_scalars; ring

include hη hpos h0 in
/-- `L_1 (L_{-1}⁴φ) = (8h + 12) • L_{-1}³φ`. -/
lemma towerLop_one_apply_towerLop_neg_one_pow_four :
    towerLop η a b 1
        (towerLop η a b (-1) (towerLop η a b (-1)
          (towerLop η a b (-1) (towerLop η a b (-1) φ))))
      = (8 * h + 12) • towerLop η a b (-1) (towerLop η a b (-1) (towerLop η a b (-1) φ)) := by
  rw [towerLop_one_apply_towerLop_neg_one_of_any η a b hη
      (towerLop η a b (-1) (towerLop η a b (-1) (towerLop η a b (-1) φ))),
    towerLop_one_apply_towerLop_neg_one_cube η a b hη hpos h0,
    towerLop_zero_apply_towerLop_neg_one_cube η a b hη h0, map_smul]
  match_scalars; ring

include hη hpos h0 in
/-- `L_1 (L_{-3}(L_{-1}φ)) = 2h • L_{-3}φ + 4 • L_{-2}(L_{-1}φ)`. -/
lemma towerLop_one_apply_towerLop_neg_three_towerLop_neg_one :
    towerLop η a b 1 (towerLop η a b (-3) (towerLop η a b (-1) φ))
      = (2 * h) • towerLop η a b (-3) φ
        + (4 : R) • towerLop η a b (-2) (towerLop η a b (-1) φ) := by
  have hc := towerLop_apply_towerLop_of_ne_zero η a b hη
    (m := 1) (n := -3) (by decide) (towerLop η a b (-1) φ)
  rw [show (1 : ℤ) + -3 = -2 by decide] at hc
  rw [hc, towerLop_one_apply_towerLop_neg_one η a b hη hpos h0, map_smul]
  match_scalars <;> ring

include hη hpos h0 in
/-- `L_1 (L_{-2}(L_{-1}²φ)) = (4h + 2) • L_{-2}(L_{-1}φ) + 3 • L_{-1}³φ`. -/
lemma towerLop_one_apply_towerLop_neg_two_towerLop_neg_one_sq :
    towerLop η a b 1
        (towerLop η a b (-2) (towerLop η a b (-1) (towerLop η a b (-1) φ)))
      = (4 * h + 2) • towerLop η a b (-2) (towerLop η a b (-1) φ)
        + (3 : R) • towerLop η a b (-1) (towerLop η a b (-1) (towerLop η a b (-1) φ)) := by
  have hc := towerLop_apply_towerLop_of_ne_zero η a b hη
    (m := 1) (n := -2) (by decide) (towerLop η a b (-1) (towerLop η a b (-1) φ))
  rw [show (1 : ℤ) + -2 = -1 by decide] at hc
  rw [hc, towerLop_one_apply_towerLop_neg_one_sq η a b hη hpos h0, map_smul]
  match_scalars <;> ring

include hη hpos h0 in
/-- ⭐⭐ **The longitudinal half of blueprint §B⁗.9**, at `h = -5` (any central charge):

`L_1 (y₃ (L_{-1}φ)) = 2h • y₃φ`.

`φ` is any seed of weight `h`; the hypothesis `hh : h = -5` is exactly the weight forced by
`§B⁗.9`'s N = 6 construction (`φ` is the rung `-6` level-1 vacuum descendant, i.e. the
highest-weight vector has `h = -5`).  As the module docstring above explains, this is a genuinely
`h`-sharp identity — `L_{-3}φ`'s coefficient matches for every `h`, but `L_{-2}(L_{-1}φ)`'s and
`L_{-1}³φ`'s only match at `h = -5` — and is independent of the central charge. -/
theorem towerLop_one_apply_y3_towerLop_neg_one_of_eq_neg_five (hh : h = -5) :
    towerLop η a b 1 (y3 η a b (towerLop η a b (-1) φ)) = (2 * h) • y3 η a b φ := by
  simp only [y3_apply, map_add, map_smul]
  rw [towerLop_one_apply_towerLop_neg_three_towerLop_neg_one η a b hη hpos h0,
    towerLop_one_apply_towerLop_neg_two_towerLop_neg_one_sq η a b hη hpos h0,
    towerLop_one_apply_towerLop_neg_one_pow_four η a b hη hpos h0, hh]
  match_scalars <;> ring

end Longitudinal

end StringFormal.NoGhost
