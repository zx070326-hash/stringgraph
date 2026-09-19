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

/-- ⭐ **`dim Q_{j,1} ≤ D - 1`** on any rung with non-null momentum.

The level-one seed space is the image of the transversality hyperplane `{e | e · p_j = 0}`
under `e ↦ (e·α_{-1})|0; p_j⟩`, and `LevelThreeCount.finrank_ker_transFunctional` computes that
hyperplane to have dimension `D - 1`.  (With `oneSeedₗ_injective` this is in fact an equality,
but only `≤` is needed downstream.) -/
theorem finrank_towerSeed_one_le (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    (hpp : dotVec η (towerMomentum a b j) (towerMomentum a b j) ≠ 0) :
    Module.finrank K ↥(towerSeed η a b j 1) ≤ D - 1 := by
  classical
  have hWle : (LinearMap.ker (transFunctional η a b j)).map (oneSeedₗ η j)
      ≤ towerBigrade D K j 1 := by
    rintro _ ⟨e, -, rfl⟩
    exact oneSeed_mem_towerBigrade j e
  have hWfin : FiniteDimensional K
      ↥((LinearMap.ker (transFunctional η a b j)).map (oneSeedₗ η j)) :=
    Submodule.finiteDimensional_of_le hWle
  have hle : towerSeed η a b j 1
      ≤ (LinearMap.ker (transFunctional η a b j)).map (oneSeedₗ η j) := by
    intro u hu
    obtain ⟨hpos, hbig⟩ := mem_towerSeed.1 hu
    obtain ⟨hu1, hu2⟩ := mem_towerBigrade.1 hbig
    obtain ⟨e, he⟩ := Fock.exists_polState_of_mem_levelSubmodule_one hη hu2
    have hue : u = oneSeed η j e := by rw [oneSeed, ← he, ← hu1]
    have h1 : dotVec η e (towerMomentum a b j) = 0 := by
      have h2 := hpos 1 (by norm_num)
      rw [hue, towerLop_one_apply_oneSeed a b hη] at h2
      refine (smul_eq_zero.1 h2).resolve_right ?_
      exact Finsupp.single_ne_zero.2 one_ne_zero
    exact ⟨e, LinearMap.mem_ker.2 h1, hue.symm⟩
  calc Module.finrank K ↥(towerSeed η a b j 1)
      ≤ Module.finrank K ↥((LinearMap.ker (transFunctional η a b j)).map (oneSeedₗ η j)) :=
        Submodule.finrank_mono hle
    _ ≤ Module.finrank K ↥(LinearMap.ker (transFunctional η a b j)) :=
        Submodule.finrank_map_le _ _
    _ = D - 1 := finrank_ker_transFunctional hpp

end LevelOneDimensions

/-! ### Step 2b: the transfer map exhausts the whole-slice kernel -/

section Surjectivity

variable {D : ℕ} {K : Type*} [Field K] [CharZero K] [Algebra ℚ K] {η a b : Fin D → K}

/-- ⭐⭐⭐ **Step 2b of the bridge**: the syzygy transfer map is *onto* the whole-slice kernel,

`S₆(V_{-6,1}) = ker (descPair η a b (-6) 6)`.

A `D`-dimensional subspace (step 2a: `S₆` is injective and `dim V_{-6,1} = D`) sitting inside a
space of dimension at most `D` (the generic count `LevelSixCount.finrank_ker_descPair_six_le`,
which is `κ₆ = p_D(1) = D`) must be the whole thing.

⭐ **No `(D : K) = 26` here.**  Both inputs are central-charge free: Form A holds for every `D`,
and `κ₆ = D` is an Euler-pentagonal count valid for every `D`.

⚠ The `IsNoetherian` detour is the `Prod` instance-path problem documented in
`DescendantKernel.finrank_ker_seedPair_le`: `AddCommGroup ↥(ker (descPair …))` is not found by
instance search on its own. -/
theorem range_sixTransfer_eq_ker_descPair (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) :
    LinearMap.range (sixTransfer η a b) = LinearMap.ker (descPair η a b (-6) 6) := by
  classical
  have hfin1 : FiniteDimensional K ↥(towerBigrade D K (-6) ((6 : ℕ) - 1)) :=
    towerBigrade_finite _ _
  have hfin2 : FiniteDimensional K ↥(towerBigrade D K (-6) ((6 : ℕ) - 2)) :=
    towerBigrade_finite _ _
  have hfinprod : FiniteDimensional K
      (↥(towerBigrade D K (-6) ((6 : ℕ) - 1)) × ↥(towerBigrade D K (-6) ((6 : ℕ) - 2))) :=
    inferInstanceAs (Module.Finite K
      (↥(towerBigrade D K (-6) ((6 : ℕ) - 1)) × ↥(towerBigrade D K (-6) ((6 : ℕ) - 2))))
  have hnoeth : IsNoetherian K
      (↥(towerBigrade D K (-6) ((6 : ℕ) - 1)) × ↥(towerBigrade D K (-6) ((6 : ℕ) - 2))) :=
    isNoetherian_of_isNoetherianRing_of_finite K
      (↥(towerBigrade D K (-6) ((6 : ℕ) - 1)) × ↥(towerBigrade D K (-6) ((6 : ℕ) - 2)))
  have h1 : Module.finrank K ↥(LinearMap.range (sixTransfer η a b)) = D := by
    rw [LinearMap.finrank_range_of_inj (sixTransfer_injective F.hη),
      finrank_towerBigrade_one F.hη]
  refine Submodule.eq_of_le_of_finrank_le
    (V := ↥(towerBigrade D K (-6) ((6 : ℕ) - 1)) × ↥(towerBigrade D K (-6) ((6 : ℕ) - 2)))
    (range_sixTransfer_le_ker_descPair F.hη) ?_
  rw [h1]
  exact finrank_ker_descPair_six_le hD F (-6)

/-- Step 2b in the form actually used below: every element of `ker (descPair η a b (-6) 6)` is
`S₆ v` for some `v` on the level-one slice. -/
theorem exists_sixTransfer_eq (hD : 2 ≤ D) (F : DDFLightConeFrame η a b)
    {w : ↥(towerBigrade D K (-6) 5) × ↥(towerBigrade D K (-6) 4)}
    (hw : w ∈ LinearMap.ker (descPair η a b (-6) 6)) :
    ∃ v : ↥(towerBigrade D K (-6) 1), sixTransfer η a b v = w := by
  have h := (range_sixTransfer_eq_ker_descPair hD F).ge hw
  exact h

end Surjectivity

/-! ### Steps 3 and 4: from the whole-slice kernel down to the seed kernel -/

section Bridge

variable {D : ℕ} {K : Type*} [Field K] [CharZero K] [Algebra ℚ K] {η a b : Fin D → K}

/-- ⭐⭐ **Step 3 of the bridge**: an `S₆`-preimage of a *seed* pair is itself a seed.

If `S₆ v = (φ, ψ)` with `ψ ∈ Q_{-6,4}` then `L_1(y₃v) = L_1ψ = 0`, and the converse half of
`SeedCriterionSix.mem_towerSeed_neg_six_one_iff` puts `v` in `Q_{-6,1}`.

⭐ **`(D : K) = 26` is not consumed here.**  Only the `←` direction of that criterion is used,
namely `mem_towerSeed_neg_six_one_of_towerLop_one_apply_y3_eq_zero`, which its own docstring
certifies to be central-charge free.  (The task roadmap expected *both* directions and therefore
a `D = 26` hypothesis on the bridge; see this file's module docstring.) -/
theorem mem_towerSeed_one_of_sixTransfer_eq_seedInclusion (F : DDFLightConeFrame η a b)
    (haa : Fock.zeroModeSq η a = 2) {v : ↥(towerBigrade D K (-6) 1)}
    {z : ↥(LinearMap.ker (seedPair η a b (-6) 6))}
    (h : sixTransfer η a b v = seedInclusion η a b (-6) 6 z.val) :
    (v : TowerFock D K) ∈ towerSeed η a b (-6) 1 := by
  refine mem_towerSeed_neg_six_one_of_towerLop_one_apply_y3_eq_zero F.hη F.frame.isotropic
    F.hba haa v.2 ?_
  have h2 : y3 η a b (v : TowerFock D K) = ((z.val.2 : ↥(towerSeed η a b (-6) 4)) :
      TowerFock D K) := by
    have h3 := congrArg
      (fun w : ↥(towerBigrade D K (-6) 5) × ↥(towerBigrade D K (-6) 4) =>
        (w.2 : TowerFock D K)) h
    simp only [sixTransfer_snd] at h3
    exact h3
  rw [h2]
  exact (mem_towerSeed.1 (z.val.2 : ↥(towerSeed η a b (-6) 4)).2).1 1 (by norm_num)

/-- ⭐⭐⭐ **The Form A ⟹ Form B bridge**: `LevelSixClosure.SixSeedKernelSharp η a b` holds for
every `DDFLightConeFrame` in every dimension `D ≥ 2`,

`dim ker (seedPair η a b (-6) 6) ≤ D - 1`.

Step 4 of the roadmap.  `S₆` transports `ker (seedPair η a b (-6) 6)` injectively into
`Q_{-6,1}`: the seed pair `z` sits in `ker (descPair …)` (`seedPair_eq_comp`), step 2b writes it
as `S₆ v` for a unique `v ∈ V_{-6,1}`, and step 3 says that `v` is a seed.  Since
`dim Q_{-6,1} ≤ D - 1` (`finrank_towerSeed_one_le`, using `p_{-6}·p_{-6} = -10 ≠ 0`), the claim
follows.

⭐ **No `(D : K) = 26`.**  Every ingredient — Form A, the count `κ₆ = D`, the seed criterion's
`←` direction, and the level-one dimension count — is central-charge free. -/
theorem sixSeedKernelSharp_of_frame (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) :
    SixSeedKernelSharp η a b := by
  classical
  have haa : Fock.zeroModeSq η a = 2 := F.dotVec_self_eq_two hD
  have hinj : Function.Injective (sixTransfer η a b) := sixTransfer_injective F.hη
  have hincl : Function.Injective (seedInclusion η a b (-6) 6) := by
    rintro ⟨u₁, u₂⟩ ⟨v₁, v₂⟩ hu
    have h1 := congrArg (fun w => (w.1 : TowerFock D K)) hu
    have h2 := congrArg (fun w => (w.2 : TowerFock D K)) hu
    exact Prod.ext (Subtype.ext h1) (Subtype.ext h2)
  have hmemrange : ∀ z : ↥(LinearMap.ker (seedPair η a b (-6) 6)),
      ((seedInclusion η a b (-6) 6).comp
          (LinearMap.ker (seedPair η a b (-6) 6)).subtype) z
        ∈ LinearMap.range (sixTransfer η a b) := by
    intro z
    rw [range_sixTransfer_eq_ker_descPair hD F, LinearMap.mem_ker, LinearMap.comp_apply,
      ← LinearMap.comp_apply, ← seedPair_eq_comp]
    exact z.2
  set ιmap : ↥(LinearMap.ker (seedPair η a b (-6) 6)) →ₗ[K]
      ↥(LinearMap.range (sixTransfer η a b)) :=
    LinearMap.codRestrict _ ((seedInclusion η a b (-6) 6).comp
      (LinearMap.ker (seedPair η a b (-6) 6)).subtype) hmemrange with hιmap
  set gmap : ↥(LinearMap.ker (seedPair η a b (-6) 6)) →ₗ[K] ↥(towerBigrade D K (-6) 1) :=
    (LinearEquiv.ofInjective (sixTransfer η a b) hinj).symm.toLinearMap.comp ιmap with hgmap
  have hgapply : ∀ z : ↥(LinearMap.ker (seedPair η a b (-6) 6)),
      sixTransfer η a b (gmap z) = seedInclusion η a b (-6) 6 z.val := by
    intro z
    rw [hgmap]
    simp [hιmap]
  set fmap : ↥(LinearMap.ker (seedPair η a b (-6) 6)) →ₗ[K] ↥(towerSeed η a b (-6) 1) :=
    LinearMap.codRestrict _ ((towerBigrade D K (-6) 1).subtype.comp gmap)
      (fun z => mem_towerSeed_one_of_sixTransfer_eq_seedInclusion F haa (hgapply z)) with hfmap
  have hfinj : Function.Injective fmap := by
    intro z z' hz
    have h1 : ((gmap z : TowerFock D K)) = ((gmap z' : TowerFock D K)) := by
      have h0 : ((fmap z : ↥(towerSeed η a b (-6) 1)) : TowerFock D K)
          = ((fmap z' : ↥(towerSeed η a b (-6) 1)) : TowerFock D K) := congrArg Subtype.val hz
      rw [hfmap] at h0
      exact h0
    have h2 : gmap z = gmap z' := Subtype.ext h1
    have h3 : seedInclusion η a b (-6) 6 z.val = seedInclusion η a b (-6) 6 z'.val := by
      rw [← hgapply z, ← hgapply z', h2]
    exact Subtype.ext (hincl h3)
  have hfinseed : Module.Finite K ↥(towerSeed η a b (-6) 1) :=
    Submodule.finiteDimensional_of_le (K := K) (V := TowerFock D K)
      (S₁ := towerSeed η a b (-6) 1) (S₂ := towerBigrade D K (-6) 1) inf_le_right
  have hpp : dotVec η (towerMomentum a b (-6)) (towerMomentum a b (-6)) ≠ 0 := by
    rw [dotVec_towerMomentum_self F.frame.isotropic F.hba haa]
    norm_num
  show Module.finrank K ↥(LinearMap.ker (seedPair η a b (-6) 6)) ≤ D - 1
  exact le_trans (LinearMap.finrank_le_finrank_of_injective (f := fmap) hfinj)
    (finrank_towerSeed_one_le F.hη hpp)

end Bridge

/-! ### `B26 6` and the level-six slice of `ddf-spans`, unconditionally -/

section Closure

variable {D : ℕ} {K : Type*} [Field K] [LinearOrder K] [IsStrictOrderedRing K] [Algebra ℚ K]
variable {η a b : Fin D → K}

/-- ⭐⭐⭐ **`B26 6` at `D = 26`, unconditionally.**

`LevelSixClosure.b26_six_of_sixSeedKernelSharp` with its named hypothesis discharged by
`sixSeedKernelSharp_of_frame`.  The sixth antidiagonal slice of the counting chain is therefore
closed on the same footing as `N ≤ 5`: the only hypotheses are `2 ≤ D`, a DDF light-cone frame,
and `(D : K) = 26`.

⭐ **Where `D = 26` is consumed**: not in the bridge, but exactly where it is consumed for
`N = 2, …, 5`, namely in the Type-2 null state
`LevelThreeCount.descTwo_mem_towerNullSubmodule_of_mem_towerBigrade` (via
`NullSeedsTwo.towerLop_two_apply_descTwo`), which enters through
`LevelSixClosure.le_finrank_towerNull_inf_towerBigrade_six_of_sixSeedKernelSharp`. -/
theorem b26_six_of_D26 (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (hD26 : (D : K) = 26) :
    B26 η a b F.hη F.trans 6 :=
  b26_six_of_sixSeedKernelSharp hD F hD26 (sixSeedKernelSharp_of_frame hD F)

/-- ⭐⭐⭐ **The DDF spanning lemma on the level-six slice `(rung -6, level 6)`, at `D = 26`,
unconditionally.**

The sixth antidiagonal slice of `ddf-spans`, after `LevelFiveCount.ddfSpans_bigrade_neg_five_five`
and with the same hypotheses — the named hypothesis of `LevelSixClosure` is discharged by
`sixSeedKernelSharp_of_frame`. -/
theorem ddfSpans_bigrade_neg_six_six (hD : 2 ≤ D) (F : DDFLightConeFrame η a b)
    (hD26 : (D : K) = 26) :
    DDFSpansOn η a b F.hη F.trans (towerBigrade D K (-((6 : ℕ) : ℤ)) 6) :=
  ddfSpans_bigrade_neg_six_six_of_sixSeedKernelSharp hD F hD26 (sixSeedKernelSharp_of_frame hD F)

end Closure

end StringFormal.NoGhost
