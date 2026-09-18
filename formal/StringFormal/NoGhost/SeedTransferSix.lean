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

## What is **not** done here (explicitly out of scope for this PR)

* The **transverse half**: that `x₄v`, `y₃v` are singular vectors of `V(26,-4)` (`v` the rung-`-5`
  Fock vacuum) is *not* formalised.  This is the bulk of the remaining work towards `b26_six` /
  `ddfSpans_bigrade_neg_six_six` per §B⁗.9's "下一步", and is out of scope for this file.
* The **longitudinal half** (`L_1(y₃ L_{-1}v) = 2h·y₃v` at `h = -5`, `c = 26`) is *not* attempted:
  it needs `L_1 y₃ φ = 0`/`L_2 y₃ φ = 3(c-26)L_{-1}φ` (§B⁗.2's "两条新的 `c-26` 方程", the level-3
  twin of `NullSeedsTwo`'s intercept/critical-dimension equations), which are not in this file and
  would roughly double its size; deferred to a follow-up PR.
* The `N = 6` seed criterion itself (`x₄u ∈ Q_{-6,5} ∧ y₃u ∈ Q_{-6,4} ⟹ u ∈ Q_{-6,1}`, §B⁗.9's
  main theorem) is untouched: this file only supplies its "前置事实 3".
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

end StringFormal.NoGhost
