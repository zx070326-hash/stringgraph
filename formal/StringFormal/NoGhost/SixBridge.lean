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

end Transfer

end StringFormal.NoGhost
