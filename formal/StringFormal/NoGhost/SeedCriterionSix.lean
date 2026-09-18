/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.SingularVectorsSixSlice
import StringFormal.NoGhost.LevelThreeCount

/-!
# `[GAP-N6-seed]`: `y₃u ∈ Q_{-6,4} ⟹ u ∈ Q_{-6,1}`

Graph nodes: `worldsheet.ddf-spanning-hypothesis`, `worldsheet.no-ghost-theorem-v4`.
This file closes the **converse** half of blueprint `formal/BLUEPRINT-noghost.md` §B⁗.9's
`[GAP-N6-seed]`, the criterion that identifies the kernel of the `N = 6` transfer map.
`NoGhost/SingularVectorsSix.lean` + `NoGhost/SingularVectorsSixSlice.lean` did the easy
direction (`u ∈ Q_{-6,1} ⟹ x₄u ∈ Q_{-6,5} ∧ y₃u ∈ Q_{-6,4}`, which *does* use `c = 26`);
what is proved here is

`u ∈ V_{-6,1}`, `L_1(y₃u) = 0`  ⟹  `u ∈ Q_{-6,1}`.

## ⭐ The converse is central-charge free

Both halves of §B⁗.9's criterion are `c`-independent:

* the **longitudinal** half is `SeedTransferSix.towerLop_one_apply_y3_towerLop_neg_one_of_eq_neg_five`
  (`L_1(y₃L_{-1}v) = 2h • y₃v` at `h = -5`), already known to be `c`-free;
* the **transverse** half used here is `SingularVectorsSix.towerLop_one_apply_y3_of_eq_neg_four`
  (`L_1(y₃φ) = 0` at `h = -4`), which holds for **every** central charge — see
  `SingularVectorsSix`'s module docstring: `c` enters the `N = 6` story *only* through the `L_2`
  conditions, via the single Gram entry `⁅L_2, L_{-2}⁆ = 4L_0 + c/2`.

So `D = 26` is **not** an input to `[GAP-N6-seed]`; it is only an input to the forward
direction (`y3_mem_towerSeed`), i.e. to the statement that the transfer map is defined on
`Q_{-6,1}` at all.  The `iff` packaging `mem_towerSeed_neg_six_one_iff` therefore needs
`(D : K) = 26` for `→` but not for `←`.

## The argument

Write `u = (e · α_{-1})|0; p_{-6}⟩` (`Fock.exists_polState_of_mem_levelSubmodule_one`) and split
the polarisation along the rung momentum, `e = e_⊥ + λ p` with `λ = (e·p)/(p·p)` and
`p = p_{-6}`; this needs `p·p = 2 + 2j = -10 ≠ 0`.  Then

* `u_⊥` is a seed of weight `1 + (-6) + 1 = -4`, so `L_1(y₃u_⊥) = 0` (transverse half);
* `λ p`'s state is `λ • L_{-1}v` with `v = |0; p_{-6}⟩` a seed of weight `1 + (-6) + 0 = -5`,
  so `L_1(y₃L_{-1}v) = -10 • y₃v` (longitudinal half).

Hence `0 = L_1(y₃u) = (-10λ) • y₃v`, and `y₃v ≠ 0` forces `λ = 0`, i.e. `e · p = 0`, i.e.
`L_1 u = 0`.

## `y₃|0; p_j⟩ ≠ 0`

The remaining input, `y3_apply_ne_zero_of_mem_towerBigrade_zero`, is the `N = 6` analogue of
`LevelTwoCount.descTwo_single_neg_two_ne_zero`, but proved by the *polarised-mode* toolbox of
`LevelThreeCount` instead of by extracting an `MvPolynomial` coefficient:

`A_ε(3)(y₃v) = 60 (ε·p_j) • v`

(`towerModeVec_three_apply_y3_of_mem_towerBigrade_zero`, valid for every `D`, `R`, `j`), so
taking `ε := p_j` and using `p_j·p_j ≠ 0` gives the claim.  The coefficient `60` is `3 ×` the
`α^ε_{-3}` component `20 p_j` of `y₃v = (12L_{-3} + 6L_{-2}L_{-1} + L_{-1}³)v`
(`12·1 + 6·1 + 1·2 = 20`).

## What is **not** done here

The `N = 6` count itself (`b26_six`, `ddfSpans_bigrade_neg_six_six`) is *not* closed; see
`formal/TODO.md`.  This file supplies the seed criterion that §B⁗.9 needs, not the counting.
-/

namespace StringFormal.NoGhost

/-! ### `y₃` on a rung vacuum: the `α_{-3}` moment -/

section VacuumMoment

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] (η a b ε : Fin D → R)

/-- ⭐ **The `α_{-3}` moment of `y₃` on a level-zero state**: `A_ε(3)(y₃v) = 60 (ε·p_j) • v`.

`A_ε(p) = towerModeVec η a b ε p` is the polarised oscillator mode.  No hypothesis beyond `hη`:
this holds for every `D`, every `ℚ`-algebra `R`, every rung `j`, and every central charge.

The three words of `y₃ = 12L_{-3} + 6L_{-2}L_{-1} + L_{-1}³` contribute `12·3 + 6·3 + 6 = 60`
times `(ε·p_j)`; equivalently, the `α^ε_{-3}` component of `y₃v` is `20 p_j` and `A_ε(3)` picks
it up with the CCR factor `3`. -/
theorem towerModeVec_three_apply_y3_of_mem_towerBigrade_zero (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    {v : TowerFock D R} (hv : v ∈ towerBigrade D R j 0) :
    towerModeVec η a b ε 3 (y3 η a b v)
      = (60 * dotVec η ε (towerMomentum a b j)) • v := by
  have h1 : towerLop η a b (-1) v ∈ towerBigrade D R j 1 :=
    towerLop_mem_towerBigrade η a b hv (by norm_num)
  have h2 : towerLop η a b (-1) (towerLop η a b (-1) v) ∈ towerBigrade D R j 2 :=
    towerLop_mem_towerBigrade η a b h1 (by norm_num)
  have hA0 : towerModeVec η a b ε 0 v = dotVec η ε (towerMomentum a b j) • v :=
    towerModeVec_zero_apply_of_mem_towerBigrade η a b ε hv
  have hA1v : towerModeVec η a b ε 1 v = 0 :=
    towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hv (by norm_num)
  have hA3v : towerModeVec η a b ε 3 v = 0 :=
    towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hv (by norm_num)
  have hA3L1 : towerModeVec η a b ε 3 (towerLop η a b (-1) v) = 0 :=
    towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε h1 (by norm_num)
  have hA3L1L1 :
      towerModeVec η a b ε 3 (towerLop η a b (-1) (towerLop η a b (-1) v)) = 0 :=
    towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε h2 (by norm_num)
  -- `A_ε(3) L_{-3} v = 3 (ε·p) v`
  have ha : towerModeVec η a b ε 3 (towerLop η a b (-3) v)
      = (3 * dotVec η ε (towerMomentum a b j)) • v := by
    rw [towerModeVec_apply_towerLop η a b ε hη (-3) 3, hA3v, map_zero, zero_add,
      show (-3 : ℤ) + 3 = 0 by ring, hA0, smul_smul]
    match_scalars
    ring
  -- `A_ε(1) L_{-1} v = (ε·p) v`
  have hb : towerModeVec η a b ε 1 (towerLop η a b (-1) v)
      = dotVec η ε (towerMomentum a b j) • v := by
    rw [towerModeVec_apply_towerLop η a b ε hη (-1) 1, hA1v, map_zero, zero_add,
      show (-1 : ℤ) + 1 = 0 by ring, hA0, smul_smul]
    match_scalars
    ring
  -- `A_ε(3) L_{-2} L_{-1} v = 3 (ε·p) v`
  have hd : towerModeVec η a b ε 3 (towerLop η a b (-2) (towerLop η a b (-1) v))
      = (3 * dotVec η ε (towerMomentum a b j)) • v := by
    rw [towerModeVec_apply_towerLop η a b ε hη (-2) 3, hA3L1, map_zero, zero_add,
      show (-2 : ℤ) + 3 = 1 by ring, hb, smul_smul]
    match_scalars
    ring
  -- `A_ε(2) L_{-1}² v = 2 (ε·p) v`
  have he : towerModeVec η a b ε 2 (towerLop η a b (-1) (towerLop η a b (-1) v))
      = (2 * dotVec η ε (towerMomentum a b j)) • v := by
    rw [towerModeVec_two_towerLop_neg_one hη h1, hb, smul_smul]
  -- `A_ε(3) L_{-1}³ v = 6 (ε·p) v`
  have hf : towerModeVec η a b ε 3
        (towerLop η a b (-1) (towerLop η a b (-1) (towerLop η a b (-1) v)))
      = (6 * dotVec η ε (towerMomentum a b j)) • v := by
    rw [towerModeVec_apply_towerLop η a b ε hη (-1) 3, hA3L1L1, map_zero, zero_add,
      show (-1 : ℤ) + 3 = 2 by ring, he, smul_smul]
    match_scalars
    ring
  rw [y3_apply, map_add, map_add, map_smul, map_smul, ha, hd, hf]
  match_scalars
  ring

end VacuumMoment

/-! ### `y₃|0; p_j⟩ ≠ 0` -/

section VacuumNonzero

variable {D : ℕ} {K : Type*} [Field K] [Algebra ℚ K] {η a b : Fin D → K}

/-- **`y₃` does not annihilate a nonzero level-zero state** as soon as `p_j · p_j ≠ 0`.

The `N = 6` analogue of `LevelTwoCount.descTwo_single_neg_two_ne_zero`, and like it the Gram
criterion is useless here (the state is null); the `α_{-3}` moment supplies it instead. -/
theorem y3_apply_ne_zero_of_mem_towerBigrade_zero (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    {v : TowerFock D K} (hv : v ∈ towerBigrade D K j 0) (hv0 : v ≠ 0)
    (hp : (60 : K) * dotVec η (towerMomentum a b j) (towerMomentum a b j) ≠ 0) :
    y3 η a b v ≠ 0 := by
  intro hzero
  have h := towerModeVec_three_apply_y3_of_mem_towerBigrade_zero η a b
    (towerMomentum a b j) hη hv
  rw [hzero, map_zero] at h
  refine hv0 ?_
  have hinv : ((60 : K) * dotVec η (towerMomentum a b j) (towerMomentum a b j))⁻¹
      • (((60 : K) * dotVec η (towerMomentum a b j) (towerMomentum a b j)) • v) = v := by
    rw [smul_smul, inv_mul_cancel₀ hp, one_smul]
  rw [← hinv, ← h, smul_zero]

omit [Algebra ℚ K] in
/-- `p_j · p_j = 2 + 2j` on the intercept-`1` shell (`k·k = 2`, `b·b = 0`, `b·a = 1`). -/
lemma dotVec_towerMomentum_self (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1)
    (haa : Fock.zeroModeSq η a = 2) (j : ℤ) :
    dotVec η (towerMomentum a b j) (towerMomentum a b j) = 2 + 2 * (j : K) := by
  rw [← zeroModeSq_eq_dotVec, zeroModeSq_towerMomentum, haa, hba, hbb]
  ring

end VacuumNonzero

/-! ### The seed criterion at `(rung -6, level 1)` -/

section Criterion

variable {D : ℕ} {K : Type*} [Field K] [CharZero K] [Algebra ℚ K] {η a b : Fin D → K}
variable (hη : ∀ μ, η μ * η μ = 1) (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1)
variable (haa : Fock.zeroModeSq η a = 2)

omit [CharZero K] in
include hη hbb hba haa in
/-- On a slice with `j + M = -6`, `L_0` acts by `-5`.  Companion of
`SingularVectorsSixSlice.towerLop_zero_apply_eq_neg_four`; it is the weight of the rung-`-6`
Fock vacuum, i.e. of the highest-weight vector `V(26, -5)` of blueprint §B⁗.9. -/
lemma towerLop_zero_apply_eq_neg_five {j : ℤ} {M : ℕ} (hjM : j + (M : ℤ) = -6)
    {u : TowerFock D K} (hu : u ∈ towerBigrade D K j M) :
    towerLop η a b 0 u = (-5 : K) • u := by
  have hc : (j : K) + (M : K) = -6 := by
    have h := congrArg (fun z : ℤ => (z : K)) hjM
    push_cast at h
    exact h
  rw [towerLop_zero_apply_of_mem_towerBigrade_of_zeroModeSq_eq_two η a b hη hbb hba haa hu,
    show ((1 : K) + (j : K) + (M : K)) = -5 from by linear_combination hc]

include hη hbb hba haa in
/-- ⭐⭐ **The longitudinal generator of the `N = 6` kernel test.**

`v = |0; p_{-6}⟩` is a seed of weight `-5`, so `L_1(y₃(L_{-1}v)) = -10 • y₃v`, and `y₃v ≠ 0`
because `p_{-6}·p_{-6} = -10 ≠ 0`.  Packaged here as the single scalar statement that is
actually used: if `λ • L_1(y₃(L_{-1}v)) = 0` then `λ = 0`. -/
theorem eq_zero_of_smul_towerLop_one_apply_y3_towerLop_neg_one_vacuum {lam : K}
    (hlam : lam • towerLop η a b 1
        (y3 η a b (towerLop η a b (-1) (Finsupp.single (-6) (1 : Fock D K)))) = 0) :
    lam = 0 := by
  set v : TowerFock D K := Finsupp.single (-6) (1 : Fock D K) with hvdef
  have hv : v ∈ towerBigrade D K (-6) 0 :=
    single_mem_towerBigrade (Fock.one_mem_levelSubmodule D K)
  have hpos : ∀ n : ℤ, 0 < n → towerLop η a b n v = 0 := by
    intro n hn
    rw [hvdef, towerLop_single, Fock.Lop_apply_one_of_pos η _ hn, Finsupp.single_zero]
  have h0 : towerLop η a b 0 v = (-5 : K) • v :=
    towerLop_zero_apply_eq_neg_five hη hbb hba haa (by norm_num) hv
  rw [towerLop_one_apply_y3_towerLop_neg_one_of_eq_neg_five η a b hη hpos h0 rfl,
    smul_smul] at hlam
  have hpp : dotVec η (towerMomentum a b (-6)) (towerMomentum a b (-6)) = -10 := by
    rw [dotVec_towerMomentum_self hbb hba haa]
    push_cast
    ring
  have hv0 : v ≠ 0 := by
    rw [hvdef]
    exact Finsupp.single_ne_zero.2 one_ne_zero
  have hy3 : y3 η a b v ≠ 0 :=
    y3_apply_ne_zero_of_mem_towerBigrade_zero hη hv hv0 (by rw [hpp]; norm_num)
  have hzero : lam * (2 * (-5 : K)) = 0 := (smul_eq_zero.1 hlam).resolve_right hy3
  have h10 : (2 * (-5 : K)) ≠ 0 := by norm_num
  exact (mul_eq_zero.1 hzero).resolve_right h10

include hη hbb hba haa in
/-- ⭐⭐⭐ **`[GAP-N6-seed]`, the converse half of blueprint §B⁗.9's criterion.**

For `u` on the slice `(rung -6, level 1)`: if `L_1(y₃u) = 0` then `u` is already a seed.

⭐ **This direction does not use the central charge.**  Both ingredients — the transverse
`L_1(y₃φ) = 0` at `h = -4` and the longitudinal `L_1(y₃L_{-1}v) = 2h • y₃v` at `h = -5` — are
central-charge free (see the module docstring), so the criterion holds for every `D`.  What does
use `(D : K) = 26` is the *forward* direction, `SingularVectorsSixSlice.y3_mem_towerSeed`. -/
theorem mem_towerSeed_neg_six_one_of_towerLop_one_apply_y3_eq_zero {u : TowerFock D K}
    (hu : u ∈ towerBigrade D K (-6) 1) (hy : towerLop η a b 1 (y3 η a b u) = 0) :
    u ∈ towerSeed η a b (-6) 1 := by
  classical
  obtain ⟨hu1, hu2⟩ := mem_towerBigrade.1 hu
  obtain ⟨e, he⟩ := Fock.exists_polState_of_mem_levelSubmodule_one hη hu2
  have hue : u = oneSeed η (-6) e := by
    rw [oneSeed, ← he, ← hu1]
  set p : Fin D → K := towerMomentum a b (-6) with hpdef
  have hpp : dotVec η p p = -10 := by
    rw [hpdef, dotVec_towerMomentum_self hbb hba haa]
    push_cast
    ring
  have hppne : dotVec η p p ≠ 0 := by rw [hpp]; norm_num
  set lam : K := dotVec η e p / dotVec η p p with hlamdef
  set f : Fin D → K := e - lam • p with hfdef
  have hf : dotVec η f p = 0 := by
    rw [hfdef, dotVec_sub_left, dotVec_smul_left, hlamdef, div_mul_cancel₀ _ hppne, sub_self]
  have hsplit : u = oneSeed η (-6) f + lam • oneSeed η (-6) p := by
    rw [hue, ← oneSeed_smul, ← oneSeed_add, hfdef]
    congr 1
    abel
  -- the transverse piece is a seed of weight `-4`
  have hfbi : oneSeed η (-6) f ∈ towerBigrade D K (-6) 1 := oneSeed_mem_towerBigrade (-6) f
  have hfpos : ∀ n : ℤ, 0 < n → towerLop η a b n (oneSeed η (-6) f) = 0 :=
    fun n hn => towerLop_apply_single_polState_eq_zero_of_pos hη hf hn
  have hf0 : towerLop η a b 0 (oneSeed η (-6) f) = (-4 : K) • oneSeed η (-6) f :=
    towerLop_zero_apply_eq_neg_four η a b hη hbb hba haa (by norm_num) hfbi
  have hftrans : towerLop η a b 1 (y3 η a b (oneSeed η (-6) f)) = 0 :=
    towerLop_one_apply_y3_of_eq_neg_four η a b hη hfpos hf0 rfl
  -- the longitudinal piece is `L_{-1}` of the rung vacuum
  have hlong : oneSeed η (-6) p
      = towerLop η a b (-1) (Finsupp.single (-6) (1 : Fock D K)) := by
    rw [towerLop_single, Fock.Lop_neg_one_apply_one_eq_polState, oneSeed, hpdef]
  -- split `L_1 (y₃ u)` and read off `lam = 0`
  have hkey : lam • towerLop η a b 1
      (y3 η a b (towerLop η a b (-1) (Finsupp.single (-6) (1 : Fock D K)))) = 0 := by
    rw [hsplit, map_add, map_add, hftrans, zero_add, map_smul, map_smul, hlong] at hy
    exact hy
  have hlam0 : lam = 0 :=
    eq_zero_of_smul_towerLop_one_apply_y3_towerLop_neg_one_vacuum hη hbb hba haa hkey
  have hep : dotVec η e p = 0 := by
    have : dotVec η e p / dotVec η p p = 0 := hlamdef ▸ hlam0
    exact (div_eq_zero_iff.1 this).resolve_right hppne
  rw [hue]
  exact oneSeed_mem_towerSeed a b hη hep

include hη hbb hba haa in
/-- ⭐⭐⭐ **Blueprint §B⁗.9's `[GAP-N6-seed]`, verbatim and in both directions.**

For `u` on the slice `(rung -6, level 1)` in critical dimension:

`u ∈ Q_{-6,1}  ⟺  x₄u ∈ Q_{-6,5} ∧ y₃u ∈ Q_{-6,4}`.

`(D : K) = 26` is used **only** for `→` (see `SingularVectorsSixSlice.y3_mem_towerSeed`); `←`
already follows from the `y₃` half alone and holds for every `D`
(`mem_towerSeed_neg_six_one_of_towerLop_one_apply_y3_eq_zero`). -/
theorem mem_towerSeed_neg_six_one_iff (hD26 : (D : K) = 26) {u : TowerFock D K}
    (hu : u ∈ towerBigrade D K (-6) 1) :
    u ∈ towerSeed η a b (-6) 1 ↔
      (x4 η a b u ∈ towerSeed η a b (-6) 5 ∧ y3 η a b u ∈ towerSeed η a b (-6) 4) := by
  refine ⟨fun h => x4_y3_mem_towerSeed_neg_six_one η a b hη hbb hba haa hD26 h, fun h => ?_⟩
  refine mem_towerSeed_neg_six_one_of_towerLop_one_apply_y3_eq_zero hη hbb hba haa hu ?_
  exact (mem_towerSeed.1 h.2).1 1 (by norm_num)

end Criterion

end StringFormal.NoGhost
