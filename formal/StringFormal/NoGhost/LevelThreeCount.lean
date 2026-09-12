/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.TypeOneFamily
import StringFormal.NoGhost.LevelTwoCount

/-!
# The level-three antidiagonal slice: the Type-1 ⊕ Type-2 null family

Blueprint `formal/BLUEPRINT-noghost.md` §B‴.5.  On the slice `(rung -3, level 3)` the counting
gap that `TypeOneFamily.le_finrank_towerNull_inf_towerBigrade_succ` leaves open is

`p_{D−1}(3) − p_{D−2}(3) − p_{D−1}(2) = D − 1`,

and §B‴.5 identifies the missing `D − 1` null states as the `𝒟₂`-images of the level-one
quasi-physical seeds `(e·α_{-1})|0; p_{-3}⟩` with `e · p_{-3} = 0`.  §B‴.5 also records that the
*leading-index* (triangularity) argument **cannot** separate those from the Type-1 family:
all `D − 1` of their leading indices are already occupied by `L_{-1}`-images.

This file supplies a separator that is not a leading index.  Write `A_ε(p)` for the polarised
oscillator mode `towerModeVec η a b ε p`.  For `x` on the slice `(-3, 3)` the two functionals

* `A_ε(3) x` — the `α_{-3}` component, generalising `LevelTwoCount.alphaTwoCoeff`; and
* `A_ε(2) A_δ(1) x − A_δ(2) A_ε(1) x` — the **antisymmetric part** of the `α_{-2}α_{-1}`
  component,

evaluate on the two families by pure commutator algebra (no coefficient extraction, no basis):

```
A_ε(3) L_{-1}φ = 3 A_ε(2) φ                    A_ε(3) 𝒟₂ψ = 24 A_ε(1) ψ
antisym A_ε(2)A_δ(1) L_{-1}φ = (δ·p)A_ε(2)φ − (ε·p)A_δ(2)φ
antisym A_ε(2)A_δ(1) 𝒟₂ψ     = 2(δ·p)A_ε(1)ψ − 2(ε·p)A_δ(1)ψ
```

The first functional is blind to the difference (both families have an `α_{-3}` component); the
second is not, because `L_{-1}` produces its `α_{-2}α_{-1}` tensor as `p ⊗ w + 2T` with `T`
**symmetric**, while `𝒟₂` produces `5 p ⊗ v + 6 v ⊗ p`, whose antisymmetric part survives.
Eliminating `A_ε(2)φ` between the two gives `(ε·p) A_δ(1)ψ = (δ·p) A_ε(1)ψ`, and `p·p = -4 ≠ 0`
then forces `ψ = 0`.

`D = 26` enters **only** through `NullSeedsTwo.towerLop_two_apply_descTwo`, i.e. only through the
statement that the Type-2 vectors are null at all; the separator, the counting and the Type-1
family are all `D`-independent.

## Status

No `sorry`.  See the section headers for what is and is not proved.
-/

namespace StringFormal.NoGhost

open Module

/-! ### Type 2 on an arbitrary rung: `j + N = -2` -/

section TypeTwoSlice

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] (η a b : Fin D → R)
variable (hη : ∀ μ, η μ * η μ = 1) (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1)
variable (haa : Fock.zeroModeSq η a = 2)

include hη hbb hba haa in
/-- **Type 2 on an arbitrary slice** (blueprint §B‴.5), generalising
`NullSeedsTwo.descTwo_mem_towerNullSubmodule_of_mem_towerBigrade_neg_two` from the rung `-2`
vacuum to any seed on a rung/level pair with `j + N = -2`.

The hypothesis `j + N = -2` is exactly `L_0 y = -y` at intercept `a₀ = 1`, which is what
`NullSeedsTwo.towerLop_one_apply_descTwo` and `towerLop_two_apply_descTwo` need.  At
`(j, N) = (-3, 1)` this is the family of `D - 1` states that §B‴.5 adds to the Type-1 family on
the level-three slice. -/
theorem descTwo_mem_towerNullSubmodule_of_mem_towerBigrade (hD26 : (D : R) = 26)
    {j : ℤ} {N : ℕ} (hjN : j + (N : ℤ) = -2) {y : TowerFock D R}
    (hy : y ∈ towerBigrade D R j N) (hpos : ∀ n : ℤ, 0 < n → towerLop η a b n y = 0)
    {N' : ℕ} (hN' : (N' : ℤ) = (N : ℤ) + 2) :
    descTwo η a b y ∈ towerNullSubmodule η a b (1 : R) ⊓ towerBigrade D R j N' := by
  have hs : (1 : R) + (j : R) + (N : R) = -1 := by
    have hc : ((j + (N : ℤ) : ℤ) : R) = ((-2 : ℤ) : R) := by rw [hjN]
    push_cast at hc
    linear_combination hc
  have h0 : towerLop η a b 0 y = -y := by
    rw [towerLop_zero_apply_of_mem_towerBigrade_of_zeroModeSq_eq_two η a b hη hbb hba haa hy, hs,
      neg_one_smul]
  exact Submodule.mem_inf.2
    ⟨descTwo_mem_towerNullSubmodule η a b hη hpos hD26 h0,
      descTwo_mem_towerBigrade η a b hy hN'⟩

end TypeTwoSlice

/-! ### The level-one seeds `(e · α_{-1})|0; p_j⟩` -/

section OneSeed

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

variable (η) in
/-- The level-one state `(e · α_{-1})|0; p_j⟩` on rung `j`, as a vector of the tower. -/
noncomputable def oneSeed (j : ℤ) (e : Fin D → R) : TowerFock D R :=
  Finsupp.single j (Fock.polState η e)

variable {η : Fin D → R} (a b : Fin D → R)

omit [Algebra ℚ R] in
lemma oneSeed_mem_towerBigrade (j : ℤ) (e : Fin D → R) :
    oneSeed η j e ∈ towerBigrade D R j 1 :=
  single_mem_towerBigrade (Fock.polState_mem_levelSubmodule_one e)

omit [Algebra ℚ R] in
lemma oneSeed_add (j : ℤ) (e f : Fin D → R) :
    oneSeed η j (e + f) = oneSeed η j e + oneSeed η j f := by
  rw [oneSeed, oneSeed, oneSeed, Fock.polState_add, Finsupp.single_add]

omit [Algebra ℚ R] in
lemma oneSeed_smul (j : ℤ) (c : R) (e : Fin D → R) :
    oneSeed η j (c • e) = c • oneSeed η j e := by
  rw [oneSeed, oneSeed, Fock.polState_smul, Finsupp.smul_single]

/-- `L_1` on a level-one seed is the transversality contraction `e · p_j`. -/
lemma towerLop_one_apply_oneSeed (hη : ∀ μ, η μ * η μ = 1) (j : ℤ) (e : Fin D → R) :
    towerLop η a b 1 (oneSeed η j e)
      = dotVec η e (towerMomentum a b j) • (Finsupp.single j (1 : Fock D R)) := by
  rw [oneSeed, towerLop_single, Fock.Lop_one_apply_polState η _ hη, Finsupp.smul_single, dotVec]

/-- `L_n` annihilates a level-one seed for `n ≥ 2`. -/
lemma towerLop_apply_oneSeed_of_two_le (hη : ∀ μ, η μ * η μ = 1) {n : ℤ} (hn : 2 ≤ n) (j : ℤ)
    (e : Fin D → R) : towerLop η a b n (oneSeed η j e) = 0 := by
  rw [oneSeed, towerLop_single, Fock.Lop_apply_polState_of_two_le η _ hη hn, Finsupp.single_zero]

/-- A transverse level-one seed lies in the seed space `Q_{j,1}` of `TypeOneFamily`. -/
theorem oneSeed_mem_towerSeed (hη : ∀ μ, η μ * η μ = 1) {j : ℤ} {e : Fin D → R}
    (he : dotVec η e (towerMomentum a b j) = 0) : oneSeed η j e ∈ towerSeed η a b j 1 := by
  refine mem_towerSeed.2 ⟨fun n hn => ?_, oneSeed_mem_towerBigrade j e⟩
  rcases eq_or_lt_of_le (show (1 : ℤ) ≤ n by omega) with h | h
  · rw [← h, towerLop_one_apply_oneSeed a b hη, he, zero_smul]
  · exact towerLop_apply_oneSeed_of_two_le a b hη (by omega) j e

end OneSeed

/-! ### The polarised-mode toolbox

`A_ε(p) = towerModeVec η a b ε p`.  Everything below is commutator algebra from
`DDFOperator.lie_towerLop_towerModeVec` (`⁅L_n, A_ε(p)⁆ = -p A_ε(n+p)`) plus the two grading
facts of `TypeOneFamily` (`A_ε(p)` has bidegree `(0, -p)`, and kills levels below `p`). -/

section ModeToolbox

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] (η a b ε : Fin D → R)

/-- **Moving a polarised mode past a Virasoro generator**:
`A_ε(p) (L_n x) = L_n (A_ε(p) x) + p • A_ε(n+p) x`. -/
lemma towerModeVec_apply_towerLop (hη : ∀ μ, η μ * η μ = 1) (n p : ℤ) (x : TowerFock D R) :
    towerModeVec η a b ε p (towerLop η a b n x)
      = towerLop η a b n (towerModeVec η a b ε p x)
        + (p : R) • towerModeVec η a b ε (n + p) x := by
  have h := congrArg (fun T : Module.End R (TowerFock D R) => T x)
    (lie_towerLop_towerModeVec η a b ε hη n p)
  simp only [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
    LinearMap.smul_apply] at h
  rw [sub_eq_iff_eq_add'.mp h, neg_smul]
  abel

omit [Algebra ℚ R] in
/-- The zero mode acts on a slice by the momentum contraction `ε · p_j`. -/
lemma towerModeVec_zero_apply_of_mem_towerBigrade {j : ℤ} {N : ℕ} {x : TowerFock D R}
    (hx : x ∈ towerBigrade D R j N) :
    towerModeVec η a b ε 0 x = dotVec η ε (towerMomentum a b j) • x := by
  conv_lhs => rw [(mem_towerBigrade.1 hx).1]
  rw [towerModeVec_zero_apply_single, ← (mem_towerBigrade.1 hx).1]

variable {η a b ε}

/-- `A_ε(3) L_{-1} φ = 3 A_ε(2) φ` for `φ` of level two: the `α_{-3}` component of a Type-1
state is (twice) the `α_{-2}` component of its seed. -/
lemma towerModeVec_three_towerLop_neg_one (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    {φ : TowerFock D R} (hφ : φ ∈ towerBigrade D R j 2) :
    towerModeVec η a b ε 3 (towerLop η a b (-1) φ) = (3 : R) • towerModeVec η a b ε 2 φ := by
  rw [towerModeVec_apply_towerLop η a b ε hη (-1) 3,
    towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hφ (by norm_num), map_zero,
    zero_add, show (-1 : ℤ) + 3 = 2 by ring]
  norm_num

/-- `A_ε(2) L_{-1} ψ = 2 A_ε(1) ψ` for `ψ` of level one. -/
lemma towerModeVec_two_towerLop_neg_one (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    {ψ : TowerFock D R} (hψ : ψ ∈ towerBigrade D R j 1) :
    towerModeVec η a b ε 2 (towerLop η a b (-1) ψ) = (2 : R) • towerModeVec η a b ε 1 ψ := by
  rw [towerModeVec_apply_towerLop η a b ε hη (-1) 2,
    towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hψ (by norm_num), map_zero,
    zero_add, show (-1 : ℤ) + 2 = 1 by ring]
  norm_num

/-- `A_ε(3) L_{-1} ψ = 0` for `ψ` of level one. -/
lemma towerModeVec_three_towerLop_neg_one_of_level_one (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    {ψ : TowerFock D R} (hψ : ψ ∈ towerBigrade D R j 1) :
    towerModeVec η a b ε 3 (towerLop η a b (-1) ψ) = 0 := by
  rw [towerModeVec_apply_towerLop η a b ε hη (-1) 3,
    towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hψ (by norm_num), map_zero,
    zero_add, show (-1 : ℤ) + 3 = 2 by ring,
    towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hψ (by norm_num), smul_zero]

/-- `A_ε(3) 𝒟₂ ψ = 24 A_ε(1) ψ` for `ψ` of level one.  Together with
`towerModeVec_three_towerLop_neg_one` this is the first of the two separating functionals of
the module docstring. -/
lemma towerModeVec_three_descTwo (hη : ∀ μ, η μ * η μ = 1) {j : ℤ} {ψ : TowerFock D R}
    (hψ : ψ ∈ towerBigrade D R j 1) :
    towerModeVec η a b ε 3 (descTwo η a b ψ) = (24 : R) • towerModeVec η a b ε 1 ψ := by
  have hL2 : towerModeVec η a b ε 3 (towerLop η a b (-2) ψ)
      = (3 : R) • towerModeVec η a b ε 1 ψ := by
    rw [towerModeVec_apply_towerLop η a b ε hη (-2) 3,
      towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hψ (by norm_num), map_zero,
      zero_add, show (-2 : ℤ) + 3 = 1 by ring]
    norm_num
  have hL11 : towerModeVec η a b ε 3 (towerLop η a b (-1) (towerLop η a b (-1) ψ))
      = (6 : R) • towerModeVec η a b ε 1 ψ := by
    rw [towerModeVec_apply_towerLop η a b ε hη (-1) 3,
      towerModeVec_three_towerLop_neg_one_of_level_one hη hψ, map_zero, zero_add,
      show (-1 : ℤ) + 3 = 2 by ring, towerModeVec_two_towerLop_neg_one hη hψ, smul_smul]
    norm_num
  rw [descTwo_apply, map_add, map_smul, map_smul, hL2, hL11, smul_smul, smul_smul, ← add_smul]
  norm_num

end ModeToolbox

/-! ### The antisymmetrised `α_{-2}α_{-1}` functional

The second separating functional of the module docstring.  All four lemmas are evaluations of
`A_ε(2) A_δ(1)` on the two families; the *antisymmetrisation* in `(ε, δ)` is taken only in
`typeTwoAug_injective`, where it matters. -/

section AntisymFunctional

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] {η a b ε δ : Fin D → R}

/-- Two polarised modes commute unless their indices sum to zero. -/
lemma towerModeVec_apply_towerModeVec_of_add_ne_zero (η a b ε δ : Fin D → R)
    (hη : ∀ μ, η μ * η μ = 1) {m p : ℤ} (hmp : m + p ≠ 0) (x : TowerFock D R) :
    towerModeVec η a b ε m (towerModeVec η a b δ p x)
      = towerModeVec η a b δ p (towerModeVec η a b ε m x) := by
  have h := congrArg (fun T : Module.End R (TowerFock D R) => T x)
    (lie_towerModeVec_towerModeVec η a b ε δ hη m p)
  simp only [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
    LinearMap.smul_apply, LinearMap.id_coe, id_eq, if_neg hmp, zero_smul] at h
  exact sub_eq_zero.mp h

/-- `A_δ(1) L_{-1} x = L_{-1} A_δ(1) x + (δ·p_j) x` on any slice. -/
lemma towerModeVec_one_towerLop_neg_one (hη : ∀ μ, η μ * η μ = 1) {j : ℤ} {N : ℕ}
    {x : TowerFock D R} (hx : x ∈ towerBigrade D R j N) :
    towerModeVec η a b δ 1 (towerLop η a b (-1) x)
      = towerLop η a b (-1) (towerModeVec η a b δ 1 x)
        + dotVec η δ (towerMomentum a b j) • x := by
  rw [towerModeVec_apply_towerLop η a b δ hη (-1) 1, show (-1 : ℤ) + 1 = 0 by ring,
    towerModeVec_zero_apply_of_mem_towerBigrade η a b δ hx]
  norm_num

/-- `A_ε(2) L_{-1} L_{-1} z = 2 (ε·p_j) z` for `z` of level zero. -/
lemma towerModeVec_two_towerLop_neg_one_sq_of_level_zero (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    {z : TowerFock D R} (hz : z ∈ towerBigrade D R j 0) :
    towerModeVec η a b ε 2 (towerLop η a b (-1) (towerLop η a b (-1) z))
      = ((2 : R) * dotVec η ε (towerMomentum a b j)) • z := by
  have h2 : towerModeVec η a b ε 2 (towerLop η a b (-1) z) = 0 := by
    rw [towerModeVec_apply_towerLop η a b ε hη (-1) 2,
      towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hz (by norm_num), map_zero,
      zero_add, show (-1 : ℤ) + 2 = 1 by ring,
      towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hz (by norm_num), smul_zero]
  have h1 : towerModeVec η a b ε 1 (towerLop η a b (-1) z)
      = dotVec η ε (towerMomentum a b j) • z := by
    rw [towerModeVec_apply_towerLop η a b ε hη (-1) 1,
      towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hz (by norm_num), map_zero,
      zero_add, show (-1 : ℤ) + 1 = 0 by ring,
      towerModeVec_zero_apply_of_mem_towerBigrade η a b ε hz]
    norm_num
  rw [towerModeVec_apply_towerLop η a b ε hη (-1) 2, h2, map_zero, zero_add,
    show (-1 : ℤ) + 2 = 1 by ring, h1, smul_smul]
  norm_num

/-- **Type 1 under the second functional**:
`A_ε(2) A_δ(1) L_{-1} φ = 2 A_ε(1) A_δ(1) φ + (δ·p_j) A_ε(2) φ`.

The first summand is symmetric in `(ε, δ)` (two modes of index `1` commute), so the
antisymmetric part of the left-hand side is `(δ·p)A_ε(2)φ − (ε·p)A_δ(2)φ`. -/
theorem towerModeVec_two_one_towerLop_neg_one (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    {φ : TowerFock D R} (hφ : φ ∈ towerBigrade D R j 2) :
    towerModeVec η a b ε 2 (towerModeVec η a b δ 1 (towerLop η a b (-1) φ))
      = (2 : R) • towerModeVec η a b ε 1 (towerModeVec η a b δ 1 φ)
        + dotVec η δ (towerMomentum a b j) • towerModeVec η a b ε 2 φ := by
  have hφ1 : towerModeVec η a b δ 1 φ ∈ towerBigrade D R j 1 :=
    towerModeVec_mem_towerBigrade η a b δ hφ (by norm_num)
  rw [towerModeVec_one_towerLop_neg_one hη hφ, map_add, map_smul,
    towerModeVec_apply_towerLop η a b ε hη (-1) 2,
    towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hφ1 (by norm_num), map_zero,
    zero_add, show (-1 : ℤ) + 2 = 1 by ring]
  norm_num

/-- `A_ε(2) A_δ(1) L_{-2} ψ = 2 (ε·p_j) A_δ(1) ψ` for `ψ` of level one. -/
theorem towerModeVec_two_one_towerLop_neg_two (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    {ψ : TowerFock D R} (hψ : ψ ∈ towerBigrade D R j 1) :
    towerModeVec η a b ε 2 (towerModeVec η a b δ 1 (towerLop η a b (-2) ψ))
      = ((2 : R) * dotVec η ε (towerMomentum a b j)) • towerModeVec η a b δ 1 ψ := by
  have hz : towerModeVec η a b δ 1 ψ ∈ towerBigrade D R j 0 :=
    towerModeVec_mem_towerBigrade η a b δ hψ (by norm_num)
  have hcomm : towerModeVec η a b ε 2 (towerModeVec η a b δ (-1) ψ) = 0 := by
    rw [towerModeVec_apply_towerModeVec_of_add_ne_zero η a b ε δ hη (by norm_num),
      towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hψ (by norm_num), map_zero]
  rw [towerModeVec_apply_towerLop η a b δ hη (-2) 1, show (-2 : ℤ) + 1 = -1 by ring, map_add,
    map_smul, hcomm, smul_zero, add_zero, towerModeVec_apply_towerLop η a b ε hη (-2) 2,
    towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hz (by norm_num), map_zero,
    zero_add, show (-2 : ℤ) + 2 = 0 by ring,
    towerModeVec_zero_apply_of_mem_towerBigrade η a b ε hz, smul_smul]
  norm_num

/-- `A_ε(2) A_δ(1) L_{-1}² ψ = 2 (ε·p_j) A_δ(1) ψ + 4 (δ·p_j) A_ε(1) ψ` for `ψ` of level one. -/
theorem towerModeVec_two_one_towerLop_neg_one_sq (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    {ψ : TowerFock D R} (hψ : ψ ∈ towerBigrade D R j 1) :
    towerModeVec η a b ε 2 (towerModeVec η a b δ 1
        (towerLop η a b (-1) (towerLop η a b (-1) ψ)))
      = ((2 : R) * dotVec η ε (towerMomentum a b j)) • towerModeVec η a b δ 1 ψ
        + ((4 : R) * dotVec η δ (towerMomentum a b j)) • towerModeVec η a b ε 1 ψ := by
  have hz : towerModeVec η a b δ 1 ψ ∈ towerBigrade D R j 0 :=
    towerModeVec_mem_towerBigrade η a b δ hψ (by norm_num)
  have hψ2 : towerLop η a b (-1) ψ ∈ towerBigrade D R j 2 :=
    towerLop_mem_towerBigrade η a b hψ (by norm_num)
  have hstep : towerModeVec η a b δ 1 (towerLop η a b (-1) (towerLop η a b (-1) ψ))
      = towerLop η a b (-1) (towerLop η a b (-1) (towerModeVec η a b δ 1 ψ))
        + (2 * dotVec η δ (towerMomentum a b j)) • towerLop η a b (-1) ψ := by
    rw [towerModeVec_one_towerLop_neg_one hη hψ2, towerModeVec_one_towerLop_neg_one hη hψ,
      map_add, map_smul]
    module
  rw [hstep, map_add, map_smul, towerModeVec_two_towerLop_neg_one_sq_of_level_zero hη hz,
    towerModeVec_two_towerLop_neg_one hη hψ, smul_smul]
  module

/-- **Type 2 under the second functional**:
`A_ε(2) A_δ(1) 𝒟₂ ψ = 10 (ε·p_j) A_δ(1) ψ + 12 (δ·p_j) A_ε(1) ψ`, so the antisymmetric part is
`−2 (ε·p) A_δ(1)ψ + 2 (δ·p) A_ε(1)ψ` — nonzero, which is exactly what the leading-index argument
of blueprint §B‴.5 cannot see. -/
theorem towerModeVec_two_one_descTwo (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    {ψ : TowerFock D R} (hψ : ψ ∈ towerBigrade D R j 1) :
    towerModeVec η a b ε 2 (towerModeVec η a b δ 1 (descTwo η a b ψ))
      = ((10 : R) * dotVec η ε (towerMomentum a b j)) • towerModeVec η a b δ 1 ψ
        + ((12 : R) * dotVec η δ (towerMomentum a b j)) • towerModeVec η a b ε 1 ψ := by
  rw [descTwo_apply, map_add, map_smul, map_add, map_smul, map_smul, map_smul,
    towerModeVec_two_one_towerLop_neg_two hη hψ, towerModeVec_two_one_towerLop_neg_one_sq hη hψ]
  module

end AntisymFunctional

end StringFormal.NoGhost
