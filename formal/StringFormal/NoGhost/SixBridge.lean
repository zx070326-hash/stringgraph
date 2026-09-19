/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.LevelSixClosure
import StringFormal.NoGhost.SeedCriterionSix
import StringFormal.NoGhost.SixSliceInjective

/-!
# The Form A ⟹ Form B bridge at `N = 6`

Graph nodes: `worldsheet.ddf-spanning-hypothesis`, `worldsheet.no-ghost-theorem-v4`.
This file is **under construction**; the module docstring is finalised in the last commit of
the branch.  What is in place so far is recorded below, declaration by declaration.
-/

namespace StringFormal.NoGhost

/-! ### The syzygy transfer map `S₆ : V_{-6,1} → V_{-6,5} × V_{-6,4}` -/

section Transfer

variable {D : ℕ} {K : Type*} [Field K] [CharZero K] [Algebra ℚ K] {η a b : Fin D → K}

variable (η a b) in
/-- The level-4 half of the transfer map, `v ↦ x₄v`, as a map between bigraded slices.
`x4_mem_towerBigrade` supplies the bidegree `(0, +4)`; no hypothesis at all is needed. -/
noncomputable def x4Slice :
    ↥(towerBigrade D K (-6) 1) →ₗ[K] ↥(towerBigrade D K (-6) 5) :=
  LinearMap.codRestrict _ ((x4 η a b).comp (towerBigrade D K (-6) 1).subtype)
    (fun v => x4_mem_towerBigrade η a b v.2 (by norm_num))

variable (η a b) in
/-- The level-3 half of the transfer map, `v ↦ y₃v` (bidegree `(0, +3)`). -/
noncomputable def y3Slice :
    ↥(towerBigrade D K (-6) 1) →ₗ[K] ↥(towerBigrade D K (-6) 4) :=
  LinearMap.codRestrict _ ((y3 η a b).comp (towerBigrade D K (-6) 1).subtype)
    (fun v => y3_mem_towerBigrade η a b v.2 (by norm_num))

variable (η a b) in
/-- ⭐ **The `N = 6` syzygy transfer map** `S₆ : V_{-6,1} → V_{-6,5} × V_{-6,4}`,
`v ↦ (x₄v, y₃v)`.

Its codomain is exactly the domain of `DescendantKernel.descPair η a b (-6) 6` (`6 - 1 = 5`,
`6 - 2 = 4`).  No hypothesis on `η, a, b, D` enters the definition. -/
noncomputable def sixTransfer :
    ↥(towerBigrade D K (-6) 1) →ₗ[K]
      (↥(towerBigrade D K (-6) 5) × ↥(towerBigrade D K (-6) 4)) :=
  (x4Slice η a b).prod (y3Slice η a b)

omit [CharZero K] in
@[simp]
lemma sixTransfer_fst (v : ↥(towerBigrade D K (-6) 1)) :
    ((sixTransfer η a b v).1 : TowerFock D K) = x4 η a b (v : TowerFock D K) := rfl

omit [CharZero K] in
@[simp]
lemma sixTransfer_snd (v : ↥(towerBigrade D K (-6) 1)) :
    ((sixTransfer η a b v).2 : TowerFock D K) = y3 η a b (v : TowerFock D K) := rfl

/-- ⭐⭐ **Step 1 of the bridge**: the image of the transfer map lands in the kernel of the
whole-slice descendant map, for **every** `v` on the level-one slice and with **no** hypothesis
beyond `hη`.

This is nothing but the syzygy identity `L_{-1}x₄ + 𝒟₂y₃ = 0` of
`SeedTransferSix.towerLop_neg_one_mul_x4_add_descTwo_mul_y3`, read as a statement about the pair
`(x₄v, y₃v)`: `descPair (φ, ψ) = L_{-1}φ + 𝒟₂ψ`. -/
theorem sixTransfer_mem_ker_descPair (hη : ∀ μ, η μ * η μ = 1)
    (v : ↥(towerBigrade D K (-6) 1)) :
    sixTransfer η a b v ∈ LinearMap.ker (descPair η a b (-6) 6) := by
  have h := congrArg (fun T : Module.End K (TowerFock D K) => T (v : TowerFock D K))
    (towerLop_neg_one_mul_x4_add_descTwo_mul_y3 η a b hη)
  simp only [LinearMap.add_apply, Module.End.mul_apply, LinearMap.zero_apply] at h
  rw [LinearMap.mem_ker, descPair_apply]
  simpa using h

/-- Step 1, packaged as a statement about submodules. -/
theorem range_sixTransfer_le_ker_descPair (hη : ∀ μ, η μ * η μ = 1) :
    LinearMap.range (sixTransfer η a b) ≤ LinearMap.ker (descPair η a b (-6) 6) := by
  rintro _ ⟨v, rfl⟩
  exact sixTransfer_mem_ker_descPair hη v

/-- ⭐⭐ **Step 2a of the bridge — Form A, verbatim**: the transfer map is injective on the
*whole* level-one slice (no seed condition, no `D = 26`).

This is `SixSliceInjective.x4_eq_zero_of_mem_towerBigrade_one` applied to the difference of two
vectors with the same image; only the `x₄` component is used. -/
theorem sixTransfer_injective (hη : ∀ μ, η μ * η μ = 1) :
    Function.Injective (sixTransfer η a b) := by
  intro u v huv
  have h1 : ((sixTransfer η a b u).1 : TowerFock D K)
      = ((sixTransfer η a b v).1 : TowerFock D K) :=
    congrArg (fun z : ↥(towerBigrade D K (-6) 5) × ↥(towerBigrade D K (-6) 4) =>
      (z.1 : TowerFock D K)) huv
  rw [sixTransfer_fst, sixTransfer_fst] at h1
  have hmem : (u : TowerFock D K) - (v : TowerFock D K) ∈ towerBigrade D K (-6) 1 :=
    Submodule.sub_mem _ u.2 v.2
  have hx : x4 η a b ((u : TowerFock D K) - (v : TowerFock D K)) = 0 := by
    rw [map_sub, h1, sub_self]
  exact Subtype.ext (sub_eq_zero.1 (x4_eq_zero_of_mem_towerBigrade_one hη hmem hx))

end Transfer

/-! ### The two dimensions of the level-one slice: `dim V_{j,1} = D` and `dim Q_{j,1} ≤ D - 1` -/

section LevelOneDimensions

variable {D : ℕ} {K : Type*} [Field K] [CharZero K] [Algebra ℚ K] {η a b : Fin D → K}

omit [CharZero K] [Algebra ℚ K] in
/-- The level-one seed map `e ↦ (e·α_{-1})|0; p_j⟩` is injective as soon as the metric is
invertible (`η_μ² = 1`). -/
theorem oneSeedₗ_injective (hη : ∀ μ, η μ * η μ = 1) (j : ℤ) :
    Function.Injective (oneSeedₗ (D := D) (K := K) η j) := by
  refine (injective_iff_map_eq_zero _).2 fun e he => ?_
  have h1 : Finsupp.single j (Fock.polState η e) = 0 := he
  exact (Fock.polState_eq_zero_iff η hη).1 (Finsupp.single_eq_zero.1 h1)

omit [CharZero K] [Algebra ℚ K] in
/-- The level-one slice is exactly the range of the seed map: every level-one state is
`(e · α_{-1})|0; p_j⟩` for a unique polarisation `e`. -/
theorem range_oneSeedₗ (hη : ∀ μ, η μ * η μ = 1) (j : ℤ) :
    LinearMap.range (oneSeedₗ (D := D) (K := K) η j) = towerBigrade D K j 1 := by
  refine le_antisymm ?_ ?_
  · rintro _ ⟨e, rfl⟩
    exact oneSeed_mem_towerBigrade j e
  · intro u hu
    obtain ⟨hu1, hu2⟩ := mem_towerBigrade.1 hu
    obtain ⟨e, he⟩ := Fock.exists_polState_of_mem_levelSubmodule_one hη hu2
    refine ⟨e, ?_⟩
    show oneSeed η j e = u
    rw [oneSeed, ← he, ← hu1]

omit [CharZero K] [Algebra ℚ K] in
/-- ⭐ **`dim V_{j,1} = D`** on every rung: the level-one slice is the space of polarisations. -/
theorem finrank_towerBigrade_one (hη : ∀ μ, η μ * η μ = 1) (j : ℤ) :
    Module.finrank K ↥(towerBigrade D K j 1) = D := by
  rw [← range_oneSeedₗ hη j,
    LinearMap.finrank_range_of_inj (oneSeedₗ_injective hη j), Module.finrank_fin_fun]

end LevelOneDimensions

end StringFormal.NoGhost
