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

/-! ### Transversality of the two families

The new mathematical content of this file: the `𝒟₂`-images of the level-one seeds meet the
`L_{-1}`-images of the level-two slice only in `0`. -/

section Independence

variable {D : ℕ} {K : Type*} [Field K] [CharZero K] [Algebra ℚ K] {η a b : Fin D → K}

omit [CharZero K] in
lemma oneSeed_eq_towerModeVec (j : ℤ) (e : Fin D → K) :
    oneSeed η j e = towerModeVec η a b e (-1) (Finsupp.single j (1 : Fock D K)) := by
  rw [oneSeed, towerModeVec_neg_one_apply_single, mul_one]

omit [CharZero K] in
/-- `A_δ(1) (e·α_{-1})|0;p_j⟩ = (δ·e) |0;p_j⟩`: the level-one seeds are read off by the
first-mode functionals, the transition matrix being the frame Gram matrix. -/
lemma towerModeVec_one_oneSeed (hη : ∀ μ, η μ * η μ = 1) (j : ℤ) (δ e : Fin D → K) :
    towerModeVec η a b δ 1 (oneSeed η j e)
      = dotVec η δ e • (Finsupp.single j (1 : Fock D K)) := by
  have hvac : (Finsupp.single j (1 : Fock D K)) ∈ towerBigrade D K j 0 :=
    single_mem_towerBigrade (Fock.one_mem_levelSubmodule D K)
  have h := congrArg (fun T : Module.End K (TowerFock D K) => T (Finsupp.single j (1 : Fock D K)))
    (lie_towerModeVec_towerModeVec η a b δ e hη 1 (-1))
  simp only [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
    LinearMap.smul_apply, LinearMap.id_coe, id_eq] at h
  rw [if_pos (by norm_num : (1 : ℤ) + -1 = 0),
    towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b δ hvac (by norm_num), map_zero,
    sub_zero] at h
  rw [oneSeed_eq_towerModeVec (a := a) (b := b), h]
  norm_num

/-- ⭐ **Transversality of the Type-1 and Type-2 families on the level-three slice.**

If `L_{-1}φ + 𝒟₂((e·α_{-1})|0;p_j⟩) = 0` for a level-two `φ` and a polarisation `e` transverse
to the rung momentum, and `p_j·p_j ≠ 0`, then `e = 0` and `φ = 0`.

No quasi-physicality of `φ` is used, and `D = 26` does not appear: this is a statement about the
oscillator algebra alone.  Blueprint §B‴.5 shows that no `(β,ω)`-compatible leading-index order
can prove it; what does prove it is that the `α_{-2}α_{-1}` tensor of an `L_{-1}`-image is
`p ⊗ w + 2T` with `T` symmetric, so its antisymmetric part is determined by `w`, whereas for a
`𝒟₂`-image the two coefficients are `5` and `6` and the antisymmetric part survives. -/
theorem eq_zero_of_towerLop_neg_one_add_descTwo_oneSeed (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1) {j : ℤ}
    {φ : TowerFock D K} (hφ : φ ∈ towerBigrade D K j 2) {e : Fin D → K}
    (he : dotVec η e (towerMomentum a b j) = 0)
    (hpp : dotVec η (towerMomentum a b j) (towerMomentum a b j) ≠ 0)
    (hzero : towerLop η a b (-1) φ + descTwo η a b (oneSeed η j e) = 0) :
    e = 0 ∧ φ = 0 := by
  have hψ : oneSeed η j e ∈ towerBigrade D K j 1 := oneSeed_mem_towerBigrade j e
  have hvne : (Finsupp.single j (1 : Fock D K)) ≠ 0 := Finsupp.single_ne_zero.2 one_ne_zero
  -- Step 1: the `α_{-3}` functional.
  have hE1 : ∀ ε : Fin D → K, (3 : K) • towerModeVec η a b ε 2 φ
      = (-24 * dotVec η ε e) • (Finsupp.single j (1 : Fock D K)) := by
    intro ε
    have h := congrArg (towerModeVec η a b ε 3) hzero
    rw [map_add, map_zero, towerModeVec_three_towerLop_neg_one hη hφ,
      towerModeVec_three_descTwo hη hψ, towerModeVec_one_oneSeed hη] at h
    linear_combination (norm := module) h
  -- Step 2: the antisymmetrised `α_{-2}α_{-1}` functional.
  have hE3 : ∀ ε δ : Fin D → K,
      dotVec η ε (towerMomentum a b j) * dotVec η δ e
        = dotVec η δ (towerMomentum a b j) * dotVec η ε e := by
    intro ε δ
    have hεδ := congrArg (fun x => towerModeVec η a b ε 2 (towerModeVec η a b δ 1 x)) hzero
    have hδε := congrArg (fun x => towerModeVec η a b δ 2 (towerModeVec η a b ε 1 x)) hzero
    simp only [map_add, map_zero] at hεδ hδε
    rw [towerModeVec_two_one_towerLop_neg_one hη hφ, towerModeVec_two_one_descTwo hη hψ,
      towerModeVec_one_oneSeed hη, towerModeVec_one_oneSeed hη] at hεδ
    rw [towerModeVec_two_one_towerLop_neg_one hη hφ, towerModeVec_two_one_descTwo hη hψ,
      towerModeVec_one_oneSeed hη, towerModeVec_one_oneSeed hη] at hδε
    have hcomm : towerModeVec η a b ε 1 (towerModeVec η a b δ 1 φ)
        = towerModeVec η a b δ 1 (towerModeVec η a b ε 1 φ) :=
      towerModeVec_apply_towerModeVec_of_add_ne_zero η a b ε δ hη (by norm_num) φ
    have hkey : ((18 : K) * (dotVec η ε (towerMomentum a b j) * dotVec η δ e)
        - 18 * (dotVec η δ (towerMomentum a b j) * dotVec η ε e))
          • (Finsupp.single j (1 : Fock D K)) = 0 := by
      linear_combination (norm := module) (3 : K) • hεδ - (3 : K) • hδε - (6 : K) • hcomm
        - dotVec η δ (towerMomentum a b j) • hE1 ε + dotVec η ε (towerMomentum a b j) • hE1 δ
    rcases smul_eq_zero.1 hkey with h | h
    · have h' : (18 : K) * (dotVec η ε (towerMomentum a b j) * dotVec η δ e
          - dotVec η δ (towerMomentum a b j) * dotVec η ε e) = 0 := by linear_combination h
      rcases mul_eq_zero.1 h' with h2 | h2
      · exact absurd h2 (by norm_num)
      · exact sub_eq_zero.1 h2
    · exact absurd h hvne
  -- Step 3: `e = 0`, hence `φ = 0`.
  have hE : e = 0 := by
    funext i
    have hηi : η i ≠ 0 := by
      intro h0
      have h1 := hη i
      rw [h0, zero_mul] at h1
      exact zero_ne_one h1
    have h := hE3 (towerMomentum a b j) (Pi.single i 1)
    rw [dotVec_single_left, dotVec_single_left,
      dotVec_comm η (towerMomentum a b j) e, he, mul_zero] at h
    rcases mul_eq_zero.1 h with h1 | h1
    · exact absurd h1 hpp
    · rcases mul_eq_zero.1 h1 with h2 | h2
      · rcases mul_eq_zero.1 h2 with h3 | h3
        · exact absurd h3 hηi
        · exact absurd h3 one_ne_zero
      · simpa using h2
  refine ⟨hE, ?_⟩
  rw [hE] at hzero
  simp only [oneSeed, Fock.polState_zero, Finsupp.single_zero, map_zero, add_zero] at hzero
  exact towerLop_neg_one_injective η a b hη hbb hba hφ hzero

end Independence

/-! ### The null lower bound on the level-three slice -/

section NullBoundThree

variable {D : ℕ} {K : Type*} [Field K] [CharZero K] [Algebra ℚ K] {η a b : Fin D → K}

/-- `p_{-3} · p_{-3} = -4`: the level-three shell (`h = 1 - N = -2`). -/
lemma dotVec_momentum_neg_three_self (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) :
    dotVec η (towerMomentum a b (-3)) (towerMomentum a b (-3)) = -4 := by
  rw [← zeroModeSq_eq_dotVec, zeroModeSq_towerMomentum, zeroModeSq_eq_dotVec,
    F.dotVec_self_eq_two hD, F.hba, F.frame.isotropic]
  push_cast
  ring

variable (η a b) in
/-- The transversality functional `e ↦ e · p_j` on polarisations. -/
noncomputable def transFunctional (j : ℤ) : (Fin D → K) →ₗ[K] K where
  toFun e := dotVec η e (towerMomentum a b j)
  map_add' x y := dotVec_add_left η x y _
  map_smul' c x := by simpa using dotVec_smul_left η x (towerMomentum a b j) c

variable (η) in
/-- The level-one seeds as a linear map of the polarisation. -/
noncomputable def oneSeedₗ (j : ℤ) : (Fin D → K) →ₗ[K] TowerFock D K where
  toFun e := oneSeed η j e
  map_add' x y := oneSeed_add j x y
  map_smul' c x := oneSeed_smul j c x

/-- `dim {e | e · p_j = 0} = D - 1` whenever `p_j · p_j ≠ 0`. -/
theorem finrank_ker_transFunctional {j : ℤ}
    (hpp : dotVec η (towerMomentum a b j) (towerMomentum a b j) ≠ 0) :
    Module.finrank K ↥(LinearMap.ker (transFunctional η a b j)) = D - 1 := by
  have hsurj : LinearMap.range (transFunctional η a b (K := K) j) = ⊤ := by
    refine LinearMap.range_eq_top.2 fun c => ⟨(c * (dotVec η (towerMomentum a b j)
      (towerMomentum a b j))⁻¹) • towerMomentum a b j, ?_⟩
    show dotVec η _ _ = c
    rw [dotVec_smul_left]
    field_simp
  have h := LinearMap.finrank_range_add_finrank_ker (transFunctional η a b (K := K) j)
  rw [hsurj, finrank_top, Module.finrank_fin_fun, Module.finrank_self] at h
  omega

variable (η a b) in
/-- The combined Type-1 ⊕ Type-2 map `(φ, e) ↦ L_{-1}φ + 𝒟₂((e·α_{-1})|0;p_{-3}⟩)`. -/
noncomputable def typeTwoAugRaw :
    (↥(towerSeed η a b (-3) 2) × ↥(LinearMap.ker (transFunctional η a b (-3))))
      →ₗ[K] TowerFock D K :=
  (towerLop η a b (-1)).comp
      ((towerSeed η a b (-3) 2).subtype.comp (LinearMap.fst K _ _))
    + (descTwo η a b).comp ((oneSeedₗ η (-3)).comp
        ((LinearMap.ker (transFunctional η a b (-3))).subtype.comp (LinearMap.snd K _ _)))

lemma typeTwoAugRaw_apply (x : ↥(towerSeed η a b (-3) 2)
    × ↥(LinearMap.ker (transFunctional η a b (-3)))) :
    typeTwoAugRaw η a b x = towerLop η a b (-1) (x.1 : TowerFock D K)
      + descTwo η a b (oneSeed η (-3) (x.2 : Fin D → K)) := by
  simp only [typeTwoAugRaw, LinearMap.add_apply, LinearMap.coe_comp, Function.comp_apply,
    LinearMap.fst_apply, LinearMap.snd_apply, Submodule.subtype_apply, oneSeedₗ,
    LinearMap.coe_mk, AddHom.coe_mk]

/-- The combined map is injective — this is `eq_zero_of_towerLop_neg_one_add_descTwo_oneSeed`
packaged. -/
theorem typeTwoAugRaw_injective (hη : ∀ μ, η μ * η μ = 1) (hbb : dotVec η b b = 0)
    (hba : dotVec η b a = 1)
    (hpp : dotVec η (towerMomentum a b (-3)) (towerMomentum a b (-3)) ≠ 0) :
    Function.Injective (typeTwoAugRaw η a b (K := K)) := by
  have hker : ∀ x : ↥(towerSeed η a b (-3) 2)
      × ↥(LinearMap.ker (transFunctional η a b (-3))),
      typeTwoAugRaw η a b (K := K) x = 0 → x = 0 := by
    rintro ⟨⟨φ, hφ⟩, ⟨e, he⟩⟩ hx
    rw [typeTwoAugRaw_apply] at hx
    have he' : dotVec η e (towerMomentum a b (-3)) = 0 := he
    obtain ⟨he0, hφ0⟩ := eq_zero_of_towerLop_neg_one_add_descTwo_oneSeed hη hbb hba
      (mem_towerSeed.1 hφ).2 he' hpp hx
    simp only [Prod.mk_eq_zero, Submodule.mk_eq_zero]
    exact ⟨hφ0, he0⟩
  exact fun u v huv => sub_eq_zero.1 (hker _ (by rw [map_sub, huv, sub_self]))

/-- ⭐ **The null lower bound on the level-three slice at `D = 26`**:

`dim (H_null ⊓ V_3) ≥ dim Q_{-3,2} + (D - 1)`.

The `Q_{-3,2}` summand is the Type-1 family of `TypeOneFamily`; the `D - 1` summand is the
Type-2 family `𝒟₂((e·α_{-1})|0;p_{-3}⟩)` over polarisations transverse to `p_{-3}`.  The two
families are transverse by `eq_zero_of_towerLop_neg_one_add_descTwo_oneSeed`, which is where
blueprint §B‴.5's leading-index collision is bypassed; `D = 26` enters only through
`NullSeedsTwo.towerLop_two_apply_descTwo`. -/
theorem le_finrank_towerNull_inf_towerBigrade_three (hD : 2 ≤ D) (F : DDFLightConeFrame η a b)
    (haa : Fock.zeroModeSq η a = 2) (hD26 : (D : K) = 26) :
    Module.finrank K ↥(towerSeed η a b (-3) 2) + (D - 1)
      ≤ Module.finrank K
          ↥(towerNullSubmodule η a b (1 : K) ⊓ towerBigrade D K (-3) 3) := by
  classical
  have hpp : dotVec η (towerMomentum a b (-3)) (towerMomentum a b (-3)) ≠ 0 := by
    rw [dotVec_momentum_neg_three_self hD F]
    norm_num
  have hVfin : FiniteDimensional K ↥(towerBigrade D K (-3) 3) := towerBigrade_finite _ _
  have hWfin : FiniteDimensional K
      ↥(towerNullSubmodule η a b (1 : K) ⊓ towerBigrade D K (-3) 3) :=
    Submodule.finiteDimensional_of_le (K := K) (V := TowerFock D K)
      (S₁ := towerNullSubmodule η a b (1 : K) ⊓ towerBigrade D K (-3) 3)
      (S₂ := towerBigrade D K (-3) 3) inf_le_right
  have hQfin : FiniteDimensional K ↥(towerSeed η a b (-3) 2) :=
    Submodule.finiteDimensional_of_le (K := K) (V := TowerFock D K)
      (S₁ := towerSeed η a b (-3) 2) (S₂ := towerBigrade D K (-3) 2) inf_le_right
  -- the range of the combined map lands in the null slice
  have hmem : ∀ x : ↥(towerSeed η a b (-3) 2)
      × ↥(LinearMap.ker (transFunctional η a b (-3))),
      typeTwoAugRaw η a b x
        ∈ towerNullSubmodule η a b (1 : K) ⊓ towerBigrade D K (-3) 3 := by
    rintro ⟨⟨φ, hφ⟩, ⟨e, he⟩⟩
    obtain ⟨hpos, hbig⟩ := mem_towerSeed.1 hφ
    have h1 := towerLop_neg_one_mem_towerNullSubmodule_of_mem_towerBigrade η a b F.hη
      F.frame.isotropic F.hba haa (j := -3) (N := 2) (by norm_num) hbig hpos
    have he' : dotVec η e (towerMomentum a b (-3)) = 0 := he
    have h2 := descTwo_mem_towerNullSubmodule_of_mem_towerBigrade η a b F.hη F.frame.isotropic
      F.hba haa hD26 (j := -3) (N := 1) (by norm_num) (oneSeed_mem_towerBigrade (η := η) (-3) e)
      (mem_towerSeed.1 (oneSeed_mem_towerSeed a b F.hη he')).1 (N' := 3) (by norm_num)
    rw [typeTwoAugRaw_apply]
    refine Submodule.add_mem _ ?_ h2
    have : (2 : ℕ) + 1 = 3 := by norm_num
    rw [this] at h1
    exact h1
  have hinj := typeTwoAugRaw_injective (K := K) (η := η) (a := a) (b := b) F.hη
    F.frame.isotropic F.hba hpp
  have hcod : Function.Injective ((typeTwoAugRaw η a b (K := K)).codRestrict _ hmem) := by
    intro u v huv
    exact hinj (congrArg Subtype.val huv)
  have hle := LinearMap.finrank_le_finrank_of_injective hcod
  haveI : Module.Free K ↥(towerSeed η a b (-3) 2) :=
    Module.Free.of_divisionRing K ↥(towerSeed η a b (-3) 2)
  haveI : FiniteDimensional K ↥(LinearMap.ker (transFunctional η a b (-3) (K := K))) :=
    FiniteDimensional.finiteDimensional_submodule _
  rwa [Module.finrank_prod, finrank_ker_transFunctional hpp] at hle

end NullBoundThree

/-! ### The classification of level-three occupation functions

Everything in this section is about `Finsupp`s on `ι × ℕ+`; no string theory.  Rather than
redo `LevelTwoCount.Finsupp.oscWeight_eq_two_cases`'s case analysis one level up, we peel one
oscillator off and recurse — `exists_peel` below — which keeps the level-three classification to
a dozen lines and would keep any fixed level the same size. -/

namespace Finsupp

variable {ι : Type*}

/-- **Peeling one oscillator**: an occupation function of positive weight is `α^v_{-v₂}` times
one of weight smaller by `v₂`. -/
lemma exists_peel {d : (ι × ℕ+) →₀ ℕ} {N : ℕ} (h : oscWeight d = N + 1) :
    ∃ (v : ι × ℕ+) (d' : (ι × ℕ+) →₀ ℕ),
      d = Finsupp.single v 1 + d' ∧ (v.2 : ℕ) + oscWeight d' = N + 1 := by
  classical
  obtain ⟨v, hv⟩ : ∃ v : ι × ℕ+, v ∈ d.support := by
    by_contra hc
    push_neg at hc
    have : d = 0 := Finsupp.ext fun u => Finsupp.notMem_support_iff.1 (hc u)
    rw [this, oscWeight_zero] at h
    omega
  have hdv : 1 ≤ d v := Nat.one_le_iff_ne_zero.2 (Finsupp.mem_support_iff.1 hv)
  refine ⟨v, Finsupp.update d v (d v - 1), ?_, ?_⟩
  · refine Finsupp.ext fun x => ?_
    rw [Finsupp.add_apply, Finsupp.single_apply, Finsupp.update_apply]
    by_cases hx : x = v
    · rw [if_pos hx.symm, if_pos hx, hx]
      omega
    · rw [if_neg (fun hc => hx hc.symm), if_neg hx]
      omega
  · have := congrArg oscWeight
      (show d = Finsupp.single v 1 + Finsupp.update d v (d v - 1) from Finsupp.ext fun x => by
        rw [Finsupp.add_apply, Finsupp.single_apply, Finsupp.update_apply]
        by_cases hx : x = v
        · rw [if_pos hx.symm, if_pos hx, hx]; omega
        · rw [if_neg (fun hc => hx hc.symm), if_neg hx]; omega)
    rw [oscWeight_add, oscWeight_single, one_mul] at this
    omega

lemma eq_zero_of_oscWeight_eq_zero {d : (ι × ℕ+) →₀ ℕ} (h : oscWeight d = 0) : d = 0 := by
  classical
  have := card_support_le_oscWeight d
  rw [h, Nat.le_zero, Finset.card_eq_zero, Finsupp.support_eq_empty] at this
  exact this

/-- A `ℕ+` whose coercion is `n` is `n` itself, packaged for the `Prod.ext` steps below. -/
private lemma pnat_eq_of_coe_eq {m : ℕ+} {n : ℕ+} (h : (m : ℕ) = (n : ℕ)) : m = n :=
  PNat.coe_injective h

/-- **The classification of level-one occupation functions.** -/
theorem oscWeight_eq_one_cases {d : (ι × ℕ+) →₀ ℕ} (h : oscWeight d = 1) :
    ∃ i : ι, d = Finsupp.single (i, 1) 1 := by
  obtain ⟨v, d', hd, hw⟩ := exists_peel (N := 0) (by simpa using h)
  have hpos : 0 < (v.2 : ℕ) := v.2.pos
  have hv2 : (v.2 : ℕ) = 1 := by omega
  have hd' : d' = 0 := eq_zero_of_oscWeight_eq_zero (by omega)
  refine ⟨v.1, ?_⟩
  rw [hd, hd', add_zero, show ((v.1, 1) : ι × ℕ+) = v from
    Prod.ext rfl (pnat_eq_of_coe_eq (by simpa using hv2.symm))]

/-- **The classification of level-three occupation functions**: three shapes, `α^i_{-3}`,
`α^i_{-2}α^j_{-1}` and `α^i_{-1}α^j_{-1}α^k_{-1}`.  This is the combinatorial content of
`p_m(3) = m + m² + binom(m+2, 3)`. -/
theorem oscWeight_eq_three_cases {d : (ι × ℕ+) →₀ ℕ} (h : oscWeight d = 3) :
    (∃ i : ι, d = Finsupp.single (i, 3) 1) ∨
      (∃ i j : ι, d = Finsupp.single (i, 2) 1 + Finsupp.single (j, 1) 1) ∨
        (∃ i j k : ι, d = Finsupp.single (i, 1) 1 + Finsupp.single (j, 1) 1
          + Finsupp.single (k, 1) 1) := by
  obtain ⟨v, d', hd, hw⟩ := exists_peel (N := 2) (by simpa using h)
  have hpos : 0 < (v.2 : ℕ) := v.2.pos
  have hle : (v.2 : ℕ) ≤ 3 := by omega
  interval_cases hv : (v.2 : ℕ)
  · -- `v₂ = 1`: the rest has weight two
    rcases oscWeight_eq_two_cases (d := d') (by omega) with ⟨i, hi⟩ | ⟨i, j, hi⟩
    · refine Or.inr (Or.inl ⟨i, v.1, ?_⟩)
      rw [hd, hi, show ((v.1, 1) : ι × ℕ+) = v from
        Prod.ext rfl (pnat_eq_of_coe_eq (by simpa using hv.symm)), add_comm]
    · refine Or.inr (Or.inr ⟨v.1, i, j, ?_⟩)
      rw [hd, hi, show ((v.1, 1) : ι × ℕ+) = v from
        Prod.ext rfl (pnat_eq_of_coe_eq (by simpa using hv.symm)), add_assoc]
  · -- `v₂ = 2`: the rest has weight one
    obtain ⟨j, hj⟩ := oscWeight_eq_one_cases (d := d') (by omega)
    refine Or.inr (Or.inl ⟨v.1, j, ?_⟩)
    rw [hd, hj, show ((v.1, 2) : ι × ℕ+) = v from
      Prod.ext rfl (pnat_eq_of_coe_eq (by simpa using hv.symm))]
  · -- `v₂ = 3`: the rest is empty
    have hd' : d' = 0 := eq_zero_of_oscWeight_eq_zero (by omega)
    refine Or.inl ⟨v.1, ?_⟩
    rw [hd, hd', add_zero, show ((v.1, 3) : ι × ℕ+) = v from
      Prod.ext rfl (pnat_eq_of_coe_eq (by simpa using hv.symm))]

end Finsupp

/-! ### Occupation functions on the `b̃`-free directions

A single reusable bridge: `Finsupp.mapDomain` along the inclusion `κ ↪ Fin D` of the
non-`b̃` directions is an injection from the level-`N` occupation functions on `κ` into the
`b̃`-free level-`N` occupation functions on `Fin D`.  It supplies the *lower* bound on the
`conjFree` count at every level (the upper bound needs the classification, see below). -/

section ConjFreeEmbed

variable {D : ℕ}

/-- The inclusion of the non-`b̃` directions, at the level of occupation functions. -/
noncomputable def conjFreeEmbed (hD : 2 ≤ D)
    (d : ({μ : Fin D // μ ≠ conjIdx D hD} × ℕ+) →₀ ℕ) : Osc D →₀ ℕ :=
  Finsupp.mapDomain (fun v => (((v.1 : Fin D), v.2) : Osc D)) d

lemma conjFreeEmbed_injective (hD : 2 ≤ D) : Function.Injective (conjFreeEmbed hD) := by
  refine Finsupp.mapDomain_injective fun u v h => ?_
  exact Prod.ext (Subtype.ext (congrArg (fun p : Osc D => p.1) h))
    (congrArg (fun p : Osc D => p.2) h)

lemma level_conjFreeEmbed (hD : 2 ≤ D)
    (d : ({μ : Fin D // μ ≠ conjIdx D hD} × ℕ+) →₀ ℕ) :
    Fock.level D (conjFreeEmbed hD d) = ddfLevel d := by
  classical
  rw [level_eq_oscWeight, ddfLevel_eq_oscWeight, Finsupp.oscWeight_apply,
    Finsupp.oscWeight_apply, conjFreeEmbed,
    Finsupp.sum_mapDomain_index (h := fun (v : Osc D) (k : ℕ) => k * (v.2 : ℕ))
      (fun _ => by ring) (fun _ _ _ => by ring)]

lemma conjDeg_conjFreeEmbed (hD : 2 ≤ D)
    (d : ({μ : Fin D // μ ≠ conjIdx D hD} × ℕ+) →₀ ℕ) :
    conjDeg hD (conjFreeEmbed hD d) = 0 := by
  classical
  rw [conjDeg, Finsupp.weight_apply, conjFreeEmbed,
    Finsupp.sum_mapDomain_index
      (h := fun (v : Osc D) (k : ℕ) => k • (if v.1 = conjIdx D hD then 1 else 0))
      (fun _ => zero_smul _ _) (fun _ m₁ m₂ => add_smul m₁ m₂ _)]
  rw [Finsupp.sum]
  refine Finset.sum_eq_zero fun v _ => ?_
  rw [if_neg v.1.2, smul_zero]

/-- The level-`N` occupation functions on the non-`b̃` directions inject into the `b̃`-free
level-`N` occupation functions. -/
theorem card_ddfLevel_le_card_conjFree (hD : 2 ≤ D) (N : ℕ) :
    Fintype.card {d : ({μ : Fin D // μ ≠ conjIdx D hD} × ℕ+) →₀ ℕ // ddfLevel d = N}
      ≤ Fintype.card {d : Osc D →₀ ℕ // Fock.level D d = N ∧ conjDeg hD d = 0} := by
  classical
  refine Fintype.card_le_of_injective
    (fun x => (⟨conjFreeEmbed hD (x : _), ?_, conjDeg_conjFreeEmbed hD _⟩ :
      {d : Osc D →₀ ℕ // Fock.level D d = N ∧ conjDeg hD d = 0})) ?_
  · rw [level_conjFreeEmbed hD, x.2]
  · intro x y hxy
    exact Subtype.ext (conjFreeEmbed_injective hD (congrArg Subtype.val hxy))

/-- **`p_{D−1}(2) ≥ (D−1) + binom(D, 2)`**, the lower bound companion to
`LevelTwoCount.card_conjFree_two_le`.  It is what turns the Type-1 half of the level-three null
bound into a number. -/
theorem card_conjFree_two_ge (hD : 2 ≤ D) :
    (D - 1) + Nat.choose D 2
      ≤ Fintype.card {d : Osc D →₀ ℕ // Fock.level D d = 2 ∧ conjDeg hD d = 0} := by
  classical
  have hκ : Fintype.card {μ : Fin D // μ ≠ conjIdx D hD} = D - 1 := by
    rw [Fintype.card_subtype_compl, Fintype.card_subtype_eq, Fintype.card_fin]
  have h1 := card_ddfLevel_two_ge {μ : Fin D // μ ≠ conjIdx D hD}
  have h2 := card_ddfLevel_le_card_conjFree hD 2
  rw [hκ, show D - 1 + 1 = D by omega] at h1
  omega

end ConjFreeEmbed

end StringFormal.NoGhost
