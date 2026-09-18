/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.SingularVectorsSix
import StringFormal.NoGhost.TypeOneFamily

/-!
# `x₄` and `y₃` on a seed slice: `u ∈ Q_{-6,1} ⟹ x₄u ∈ Q_{-6,5} ∧ y₃u ∈ Q_{-6,4}`

Graph nodes: `worldsheet.ddf-spanning-hypothesis`, `worldsheet.no-ghost-theorem-v4`.
The slice form of the transverse half of blueprint `formal/BLUEPRINT-noghost.md` §B⁗.9's
`[GAP-N6-seed]`.  `NoGhost/SingularVectorsSix.lean` proves the two operator statements
("`y₃φ` and `x₄φ` are singular vectors of `V(26,-4)`") for an abstract seed `φ` of weight
`h = -4`; this file discharges the two abstract hypotheses on an actual bigraded slice and does
the level bookkeeping.

## The arithmetic that makes `h = -4` appear

On the slice `(rung j, level M)` at intercept `a₀ = 1` (i.e. `k·k = 2`), `L_0` acts by
`1 + j + M` (`NullSeedsTwo.towerLop_zero_apply_of_mem_towerBigrade_of_zeroModeSq_eq_two`).  So

`h = -4  ⟺  j + M = -5`,

and at `(j, M) = (-6, 1)` — the slice §B⁗.9's `u` lives on — this holds:
`-6 + 1 = -5`.  Both `y₃` (bidegree `(0, +3)`) and `x₄` (bidegree `(0, +4)`) keep the rung and
raise the level, landing on `(-6, 4)` and `(-6, 5)`.

## Main results

* `y3_mem_towerBigrade` / `x4_mem_towerBigrade` — bidegrees `(0, +3)` and `(0, +4)`, for **every**
  `D`, `R`, `η, a, b` (pure bookkeeping, no hypotheses at all).
* ⭐⭐ `y3_mem_towerSeed` / `x4_mem_towerSeed` — `Q_{j,M} = towerSeed` is `TypeOneFamily`'s
  `towerPositiveModeSubmodule ⊓ towerBigrade`; for `(D : R) = 26` and `j + M = -5`,
  `u ∈ Q_{j,M} ⟹ y₃u ∈ Q_{j,M+3}` and `x₄u ∈ Q_{j,M+4}`.
* ⭐⭐⭐ `x4_y3_mem_towerSeed_neg_six_one` — the `(j, M) = (-6, 1)` instance, which is verbatim
  the transverse half of §B⁗.9's seed criterion.

## What is **not** done here

The *converse* — §B⁗.9's actual criterion `x₄u ∈ Q_{-6,5} ∧ y₃u ∈ Q_{-6,4} ⟹ u ∈ Q_{-6,1}` — is
not proved in this file; it is `NoGhost/SeedCriterionSix.lean`
(`mem_towerSeed_neg_six_one_of_towerLop_one_apply_y3_eq_zero`, packaged with this file's forward
half as `mem_towerSeed_neg_six_one_iff`).  That converse turns out to be **central-charge free**
and to need only the `y₃` half; `(D : R) = 26` is consumed *here*, in `y3_mem_towerSeed` /
`x4_mem_towerSeed`, and nowhere else in the criterion.

Still open: the `N = 6` count itself (`b26_six`, `ddfSpans_bigrade_neg_six_six`); see
`formal/TODO.md` entry `noghost-pr-d2`.
-/

namespace StringFormal.NoGhost

section Bigrade

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] (η a b : Fin D → R)

/-- **`y₃` has bidegree `(0, +3)`**: it keeps the rung and raises the oscillator level by `3`.
No hypothesis on `η, a, b, D, R` whatsoever — the level count of `L_{-3}`, `L_{-2}L_{-1}` and
`L_{-1}³` is the same. -/
theorem y3_mem_towerBigrade {j : ℤ} {N : ℕ} {y : TowerFock D R}
    (hy : y ∈ towerBigrade D R j N) {N' : ℕ} (hN' : (N' : ℤ) = (N : ℤ) + 3) :
    y3 η a b y ∈ towerBigrade D R j N' := by
  rw [y3_apply]
  refine Submodule.add_mem _ (Submodule.add_mem _ (Submodule.smul_mem _ _ ?_)
    (Submodule.smul_mem _ _ ?_)) ?_
  · exact towerLop_mem_towerBigrade η a b hy (by omega)
  · exact towerLop_mem_towerBigrade η a b
      (towerLop_mem_towerBigrade (N' := N + 1) η a b hy (by push_cast; ring))
      (by push_cast; omega)
  · exact towerLop_mem_towerBigrade η a b
      (towerLop_mem_towerBigrade (N' := N + 2) η a b
        (towerLop_mem_towerBigrade (N' := N + 1) η a b hy (by push_cast; ring))
        (by push_cast; ring))
      (by push_cast; omega)

/-- **`x₄` has bidegree `(0, +4)`** — the level-4 partner of `y3_mem_towerBigrade`, again with no
hypotheses. -/
theorem x4_mem_towerBigrade {j : ℤ} {N : ℕ} {y : TowerFock D R}
    (hy : y ∈ towerBigrade D R j N) {N' : ℕ} (hN' : (N' : ℤ) = (N : ℤ) + 4) :
    x4 η a b y ∈ towerBigrade D R j N' := by
  have h1 : towerLop η a b (-1) y ∈ towerBigrade D R j (N + 1) :=
    towerLop_mem_towerBigrade η a b hy (by push_cast; ring)
  have h2 : towerLop η a b (-1) (towerLop η a b (-1) y) ∈ towerBigrade D R j (N + 2) :=
    towerLop_mem_towerBigrade η a b h1 (by push_cast; ring)
  have h3 : towerLop η a b (-1) (towerLop η a b (-1) (towerLop η a b (-1) y))
      ∈ towerBigrade D R j (N + 3) :=
    towerLop_mem_towerBigrade η a b h2 (by push_cast; ring)
  rw [x4_apply]
  refine Submodule.add_mem _ (Submodule.add_mem _ (Submodule.add_mem _ (Submodule.add_mem _
    (Submodule.smul_mem _ _ ?_) (Submodule.smul_mem _ _ ?_)) (Submodule.smul_mem _ _ ?_))
    (Submodule.smul_mem _ _ ?_)) (Submodule.smul_mem _ _ ?_)
  · exact towerLop_mem_towerBigrade η a b hy (by omega)
  · exact towerLop_mem_towerBigrade η a b h1 (by push_cast; omega)
  · exact towerLop_mem_towerBigrade η a b
      (towerLop_mem_towerBigrade (N' := N + 2) η a b hy (by push_cast; ring))
      (by push_cast; omega)
  · exact towerLop_mem_towerBigrade η a b h2 (by push_cast; omega)
  · exact towerLop_mem_towerBigrade η a b h3 (by push_cast; omega)

end Bigrade

section Seed

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] (η a b : Fin D → R)
variable (hη : ∀ μ, η μ * η μ = 1) (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1)
variable (haa : Fock.zeroModeSq η a = 2)

include hη hbb hba haa in
/-- On the slice `(rung j, level M)` at intercept `a₀ = 1`, `j + M = -5` is exactly the condition
`h = -4` needed by `SingularVectorsSix`.  Isolated as its own lemma because it is the *only*
arithmetic input that ties §B⁗.9's slice `(-6, 1)` to `V(26, -4)`. -/
lemma towerLop_zero_apply_eq_neg_four {j : ℤ} {M : ℕ} (hjM : j + (M : ℤ) = -5)
    {u : TowerFock D R} (hu : u ∈ towerBigrade D R j M) :
    towerLop η a b 0 u = (-4 : R) • u := by
  have hc : (j : R) + (M : R) = -5 := by
    have h := congrArg (fun z : ℤ => (z : R)) hjM
    push_cast at h
    exact h
  rw [towerLop_zero_apply_of_mem_towerBigrade_of_zeroModeSq_eq_two η a b hη hbb hba haa hu,
    show ((1 : R) + (j : R) + (M : R)) = -4 from by linear_combination hc]

include hη hbb hba haa in
/-- ⭐⭐ **`y₃` maps seeds to seeds, three levels up, exactly in critical dimension.**

`Q_{j,M} = towerSeed η a b j M` is `towerPositiveModeSubmodule ⊓ towerBigrade`.  With `(D : R) = 26`
and `j + M = -5` (i.e. `h = -4`), `u ∈ Q_{j,M} ⟹ y₃u ∈ Q_{j,M+3}`. -/
theorem y3_mem_towerSeed (hD26 : (D : R) = 26) {j : ℤ} {M : ℕ} (hjM : j + (M : ℤ) = -5)
    {u : TowerFock D R} (hu : u ∈ towerSeed η a b j M) {M' : ℕ} (hM' : (M' : ℤ) = (M : ℤ) + 3) :
    y3 η a b u ∈ towerSeed η a b j M' := by
  obtain ⟨hpos, hbi⟩ := mem_towerSeed.1 hu
  refine mem_towerSeed.2 ⟨?_, y3_mem_towerBigrade η a b hbi hM'⟩
  exact mem_towerPositiveModeSubmodule.1 (y3_mem_towerPositiveModeSubmodule η a b hη hpos
    (towerLop_zero_apply_eq_neg_four η a b hη hbb hba haa hjM hbi) hD26 rfl)

include hη hbb hba haa in
/-- ⭐⭐ **`x₄` maps seeds to seeds, four levels up, exactly in critical dimension** — the
level-4 partner of `y3_mem_towerSeed`. -/
theorem x4_mem_towerSeed (hD26 : (D : R) = 26) {j : ℤ} {M : ℕ} (hjM : j + (M : ℤ) = -5)
    {u : TowerFock D R} (hu : u ∈ towerSeed η a b j M) {M' : ℕ} (hM' : (M' : ℤ) = (M : ℤ) + 4) :
    x4 η a b u ∈ towerSeed η a b j M' := by
  obtain ⟨hpos, hbi⟩ := mem_towerSeed.1 hu
  refine mem_towerSeed.2 ⟨?_, x4_mem_towerBigrade η a b hbi hM'⟩
  exact mem_towerPositiveModeSubmodule.1 (x4_mem_towerPositiveModeSubmodule η a b hη hpos
    (towerLop_zero_apply_eq_neg_four η a b hη hbb hba haa hjM hbi) hD26 rfl)

include hη hbb hba haa in
/-- ⭐⭐⭐ **The transverse half of blueprint §B⁗.9's `[GAP-N6-seed]`, verbatim**:

for `u ∈ Q_{-6,1}` in critical dimension, `x₄u ∈ Q_{-6,5}` and `y₃u ∈ Q_{-6,4}`.

The slice `(-6, 1)` satisfies `j + M = -5`, hence carries `L_0`-weight `h = -4`; `(D : R) = 26`
is `c = 26`.  So this is the statement "`x₄v` and `y₃v` are the two singular vectors of
`V(26, -4)`" transported onto the actual `N = 6` slice.

⚠ This is the **easy direction**.  §B⁗.9's criterion is the *converse*
(`x₄u ∈ Q_{-6,5} ∧ y₃u ∈ Q_{-6,4} ⟹ u ∈ Q_{-6,1}`), proved in `NoGhost/SeedCriterionSix.lean`. -/
theorem x4_y3_mem_towerSeed_neg_six_one (hD26 : (D : R) = 26) {u : TowerFock D R}
    (hu : u ∈ towerSeed η a b (-6) 1) :
    x4 η a b u ∈ towerSeed η a b (-6) 5 ∧ y3 η a b u ∈ towerSeed η a b (-6) 4 :=
  ⟨x4_mem_towerSeed η a b hη hbb hba haa hD26 (by norm_num) hu (by norm_num),
    y3_mem_towerSeed η a b hη hbb hba haa hD26 (by norm_num) hu (by norm_num)⟩

end Seed

end StringFormal.NoGhost
