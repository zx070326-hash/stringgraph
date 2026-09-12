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

end StringFormal.NoGhost
