/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import StringFormal.Virasoro.Shapovalov

/-!
# The level-3 Gram matrix and the Kac determinant at `N = 3`

Graph node: `worldsheet.shapovalov-form`.
Convention: `conv.virasoro-standard`
  `[L_m, L_n] = (m - n) L_{m+n} + (c/12) m (m² - 1) δ_{m+n,0}`

This file continues `Shapovalov.lean` (which stops at `N ≤ 2`, with the level-2 determinant
`2h(16h² + 2h(c-5) + c)`) one level further.  For the three level-3 descendants

* `desc3   = L₋₃ |c,h⟩`,
* `desc21  = L₋₂ L₋₁ |c,h⟩`,
* `desc111 = L₋₁³ |c,h⟩`,

we compute all nine entries of the Gram matrix of an arbitrary normalised contravariant form,
its `3 × 3` determinant, and check that the determinant is the `N = 3` Kac polynomial.

## Main results

* `IsContravariant.gram_level_three_*`: the six independent entries.
* `IsContravariant.gram_level_three_det`: `det = 48h²(16h² + 2h(c-5) + c)(3h² + h(c-7) + c + 2)`.
* `IsContravariant.gram_level_three_det_eq_kac`: the same in Kac's factored shape.

## Caveat (inherited from `Shapovalov.lean`)

`levelSpan R c h 3` is spanned by the four *compositions* of `3`, and the three vectors above
span it (`L₋₁L₋₂|c,h⟩ = desc21 + desc3` by the bracket relation `[L₋₁, L₋₂] = L₋₃`).  That they are linearly
*independent* is exactly PBW, which is not available; so as in `gram_level_two_det` this is the
determinant of an explicit `3 × 3` matrix of inner products, not yet formally "the Kac
determinant of `V₃`".
-/

namespace StringFormal.Virasoro

section Level3

variable (R : Type*) [CommRing R] [Algebra ℚ R] (c h : R)

/-- The level-3 descendant `L₋₃|c,h⟩`. -/
noncomputable def desc3 : VermaModule R c h := ⁅VirasoroAlgebra.lgen R (-3), hwv R c h⁆

/-- The level-3 descendant `L₋₂L₋₁|c,h⟩`. -/
noncomputable def desc21 : VermaModule R c h := ⁅VirasoroAlgebra.lgen R (-2), desc1 R c h⁆

/-- The level-3 descendant `L₋₁³|c,h⟩`. -/
noncomputable def desc111 : VermaModule R c h := ⁅VirasoroAlgebra.lgen R (-1), desc11 R c h⁆

/-! ### Brackets and actions needed at level 3 -/

/-- `(3³ - 3)/12 = 2`: the level-3 central coefficient is an integer. -/
lemma centralTerm_three : centralTerm R 3 = 2 := by
  have h24 : (((3 : ℤ) ^ 3 - 3 : ℤ) : R) = 24 := by norm_num
  rw [centralTerm, h24, show inv12 R * (24 : R) = 2 * (12 * inv12 R) by ring,
    twelve_mul_inv12, mul_one]

lemma lie_lgen_three_neg_three : ⁅VirasoroAlgebra.lgen R 3, VirasoroAlgebra.lgen R (-3)⁆
    = (6 : R) • VirasoroAlgebra.lgen R 0 + centralTerm R 3 • VirasoroAlgebra.cgen R := by
  rw [VirasoroAlgebra.lie_lgen_lgen]
  norm_num

lemma lie_lgen_three_neg_two : ⁅VirasoroAlgebra.lgen R 3, VirasoroAlgebra.lgen R (-2)⁆
    = (5 : R) • VirasoroAlgebra.lgen R 1 := by
  rw [VirasoroAlgebra.lie_lgen_lgen]
  norm_num

lemma lie_lgen_three_neg_one : ⁅VirasoroAlgebra.lgen R 3, VirasoroAlgebra.lgen R (-1)⁆
    = (4 : R) • VirasoroAlgebra.lgen R 2 := by
  rw [VirasoroAlgebra.lie_lgen_lgen]
  norm_num

/-- `L₃ L₋₁|c,h⟩ = 0`. -/
lemma lie_lgen_three_desc1 : ⁅VirasoroAlgebra.lgen R 3, desc1 R c h⁆ = 0 := by
  rw [desc1, leibniz_lie, lie_lgen_hwv_of_pos R c h (by norm_num : (0:ℤ) < 3), lie_zero,
    add_zero, lie_lgen_three_neg_one, smul_lie,
    lie_lgen_hwv_of_pos R c h (by norm_num : (0:ℤ) < 2), smul_zero]

/-- `L₃ L₋₁²|c,h⟩ = 0`. -/
lemma lie_lgen_three_desc11 : ⁅VirasoroAlgebra.lgen R 3, desc11 R c h⁆ = 0 := by
  rw [desc11, leibniz_lie, lie_lgen_three_desc1, lie_zero, add_zero, lie_lgen_three_neg_one,
    smul_lie, lie_lgen_two_desc1, smul_zero]

/-- `L₀ L₋₁²|c,h⟩ = (h+2) L₋₁²|c,h⟩`. -/
lemma lie_lgen_zero_desc11 : ⁅VirasoroAlgebra.lgen R 0, desc11 R c h⁆
    = (h + 2) • desc11 R c h := by
  rw [desc11, leibniz_lie, lie_lgen_zero_desc1, lie_lgen_zero_neg_one, one_smul, lie_smul]
  module

/-- `L₃ L₋₃|c,h⟩ = (6h + 2c)|c,h⟩`. -/
lemma lie_lgen_three_desc3 : ⁅VirasoroAlgebra.lgen R 3, desc3 R c h⁆
    = (6 * h + 2 * c) • hwv R c h := by
  rw [desc3, leibniz_lie, lie_lgen_hwv_of_pos R c h (by norm_num : (0:ℤ) < 3), lie_zero,
    add_zero, lie_lgen_three_neg_three, add_lie, smul_lie, smul_lie, lie_lgen_zero_hwv,
    lie_cgen_hwv, smul_smul, smul_smul, ← add_smul, centralTerm_three]

/-- `L₃ L₋₂L₋₁|c,h⟩ = 10h |c,h⟩`. -/
lemma lie_lgen_three_desc21 : ⁅VirasoroAlgebra.lgen R 3, desc21 R c h⁆
    = (10 * h) • hwv R c h := by
  rw [desc21, leibniz_lie, lie_lgen_three_desc1, lie_zero, add_zero, lie_lgen_three_neg_two,
    smul_lie, lie_lgen_one_desc1, smul_smul]
  congr 1
  ring

/-- `L₃ L₋₁³|c,h⟩ = 24h |c,h⟩`. -/
lemma lie_lgen_three_desc111 : ⁅VirasoroAlgebra.lgen R 3, desc111 R c h⁆
    = (24 * h) • hwv R c h := by
  rw [desc111, leibniz_lie, lie_lgen_three_desc11, lie_zero, add_zero, lie_lgen_three_neg_one,
    smul_lie, lie_lgen_two_desc11, smul_smul]
  congr 1
  ring

/-- `L₂ L₋₂L₋₁|c,h⟩ = (4(h+1) + c/2) L₋₁|c,h⟩`. -/
lemma lie_lgen_two_desc21 : ⁅VirasoroAlgebra.lgen R 2, desc21 R c h⁆
    = (4 * (h + 1) + centralTerm R 2 * c) • desc1 R c h := by
  rw [desc21, leibniz_lie, lie_lgen_two_desc1, lie_zero, add_zero, lie_lgen_two_neg_two,
    add_lie, smul_lie, smul_lie, lie_lgen_zero_desc1, lie_cgen_eq, smul_smul, smul_smul,
    ← add_smul]

/-- `L₂ L₋₁³|c,h⟩ = (18h + 6) L₋₁|c,h⟩`. -/
lemma lie_lgen_two_desc111 : ⁅VirasoroAlgebra.lgen R 2, desc111 R c h⁆
    = (18 * h + 6) • desc1 R c h := by
  rw [desc111, leibniz_lie, lie_lgen_two_desc11, lie_smul, ← desc1, lie_lgen_two_neg_one,
    smul_lie, lie_lgen_one_desc11, smul_smul, ← add_smul]
  congr 1
  ring

/-- `L₁ L₋₁³|c,h⟩ = (6h + 6) L₋₁²|c,h⟩`. -/
lemma lie_lgen_one_desc111 : ⁅VirasoroAlgebra.lgen R 1, desc111 R c h⁆
    = (6 * h + 6) • desc11 R c h := by
  rw [desc111, leibniz_lie, lie_lgen_one_desc11, lie_smul, ← desc11, lie_lgen_one_neg_one,
    smul_lie, lie_lgen_zero_desc11, smul_smul, ← add_smul]
  congr 1
  ring

/-! ### `levelSpan` membership -/

lemma desc3_mem_levelSpan : desc3 R c h ∈ levelSpan R c h 3 := by
  refine Submodule.subset_span ⟨Composition.single 3 (by norm_num), ?_⟩
  rw [levelWord, Composition.single_blocks]
  rfl

lemma desc21_mem_levelSpan : desc21 R c h ∈ levelSpan R c h 3 := by
  refine Submodule.subset_span ⟨⟨[2, 1], by simp, rfl⟩, ?_⟩
  rw [levelWord]
  rfl

lemma desc111_mem_levelSpan : desc111 R c h ∈ levelSpan R c h 3 := by
  refine Submodule.subset_span ⟨Composition.ones 3, ?_⟩
  rw [levelWord, Composition.ones_blocks]
  rfl

/-! ### The nine entries of the level-3 Gram matrix -/

variable {R c h}
variable {B : VermaModule R c h →ₗ[R] VermaModule R c h →ₗ[R] R}

/-- `⟨L₋₃|c,h⟩, L₋₃|c,h⟩⟩ = 6h + 2c`. -/
theorem IsContravariant.gram_level_three_33 (hB : IsContravariant R c h B)
    (hB1 : B (hwv R c h) (hwv R c h) = 1) :
    B (desc3 R c h) (desc3 R c h) = 6 * h + 2 * c := by
  have key := hB (-3) (hwv R c h) (desc3 R c h)
  rw [← desc3] at key
  rw [key, neg_neg, lie_lgen_three_desc3, LinearMap.map_smul, smul_eq_mul, hB1, mul_one]

/-- `⟨L₋₃|c,h⟩, L₋₂L₋₁|c,h⟩⟩ = 10h`. -/
theorem IsContravariant.gram_level_three_3_21 (hB : IsContravariant R c h B)
    (hB1 : B (hwv R c h) (hwv R c h) = 1) :
    B (desc3 R c h) (desc21 R c h) = 10 * h := by
  have key := hB (-3) (hwv R c h) (desc21 R c h)
  rw [← desc3] at key
  rw [key, neg_neg, lie_lgen_three_desc21, LinearMap.map_smul, smul_eq_mul, hB1, mul_one]

/-- `⟨L₋₃|c,h⟩, L₋₁³|c,h⟩⟩ = 24h`. -/
theorem IsContravariant.gram_level_three_3_111 (hB : IsContravariant R c h B)
    (hB1 : B (hwv R c h) (hwv R c h) = 1) :
    B (desc3 R c h) (desc111 R c h) = 24 * h := by
  have key := hB (-3) (hwv R c h) (desc111 R c h)
  rw [← desc3] at key
  rw [key, neg_neg, lie_lgen_three_desc111, LinearMap.map_smul, smul_eq_mul, hB1, mul_one]

/-- `⟨L₋₂L₋₁|c,h⟩, L₋₂L₋₁|c,h⟩⟩ = 8h² + ch + 8h`. -/
theorem IsContravariant.gram_level_three_21_21 (hB : IsContravariant R c h B)
    (hB1 : B (hwv R c h) (hwv R c h) = 1) :
    B (desc21 R c h) (desc21 R c h) = 8 * h ^ 2 + c * h + 8 * h := by
  have key := hB (-2) (desc1 R c h) (desc21 R c h)
  rw [← desc21] at key
  rw [key, neg_neg, lie_lgen_two_desc21, LinearMap.map_smul, smul_eq_mul,
    hB.gram_level_one hB1]
  linear_combination (c * h) * two_mul_centralTerm_two R

/-- `⟨L₋₂L₋₁|c,h⟩, L₋₁³|c,h⟩⟩ = 36h² + 12h`. -/
theorem IsContravariant.gram_level_three_21_111 (hB : IsContravariant R c h B)
    (hB1 : B (hwv R c h) (hwv R c h) = 1) :
    B (desc21 R c h) (desc111 R c h) = 36 * h ^ 2 + 12 * h := by
  have key := hB (-2) (desc1 R c h) (desc111 R c h)
  rw [← desc21] at key
  rw [key, neg_neg, lie_lgen_two_desc111, LinearMap.map_smul, smul_eq_mul,
    hB.gram_level_one hB1]
  ring

/-- `⟨L₋₁³|c,h⟩, L₋₁³|c,h⟩⟩ = 48h³ + 72h² + 24h`. -/
theorem IsContravariant.gram_level_three_111_111 (hB : IsContravariant R c h B)
    (hB1 : B (hwv R c h) (hwv R c h) = 1) :
    B (desc111 R c h) (desc111 R c h) = 48 * h ^ 3 + 72 * h ^ 2 + 24 * h := by
  have key := hB (-1) (desc11 R c h) (desc111 R c h)
  rw [← desc111] at key
  rw [key, neg_neg, lie_lgen_one_desc111, LinearMap.map_smul, smul_eq_mul,
    hB.gram_level_two_bb hB1]
  ring

/-- **All nine entries of the level-3 Gram matrix at once**, in the basis
`(L₋₃, L₋₂L₋₁, L₋₁³)|c,h⟩`.  The three off-diagonal pairs are equal by
`IsContravariant.comm`. -/
theorem IsContravariant.gram_level_three_entries (hB : IsContravariant R c h B)
    (hB1 : B (hwv R c h) (hwv R c h) = 1) :
    B (desc3 R c h) (desc3 R c h) = 6 * h + 2 * c ∧
    B (desc3 R c h) (desc21 R c h) = 10 * h ∧
    B (desc3 R c h) (desc111 R c h) = 24 * h ∧
    B (desc21 R c h) (desc3 R c h) = 10 * h ∧
    B (desc21 R c h) (desc21 R c h) = 8 * h ^ 2 + c * h + 8 * h ∧
    B (desc21 R c h) (desc111 R c h) = 36 * h ^ 2 + 12 * h ∧
    B (desc111 R c h) (desc3 R c h) = 24 * h ∧
    B (desc111 R c h) (desc21 R c h) = 36 * h ^ 2 + 12 * h ∧
    B (desc111 R c h) (desc111 R c h) = 48 * h ^ 3 + 72 * h ^ 2 + 24 * h :=
  ⟨hB.gram_level_three_33 hB1, hB.gram_level_three_3_21 hB1, hB.gram_level_three_3_111 hB1,
    (hB.comm _ _).trans (hB.gram_level_three_3_21 hB1),
    hB.gram_level_three_21_21 hB1, hB.gram_level_three_21_111 hB1,
    (hB.comm _ _).trans (hB.gram_level_three_3_111 hB1),
    (hB.comm _ _).trans (hB.gram_level_three_21_111 hB1),
    hB.gram_level_three_111_111 hB1⟩

/-- Levels `2` and `3` are orthogonal, an instance of `IsContravariant.eq_zero_of_level_ne`. -/
theorem IsContravariant.gram_level_two_three (hB : IsContravariant R c h B)
    {x y : VermaModule R c h} (hx : x ∈ levelSpan R c h 2) (hy : y ∈ levelSpan R c h 3) :
    B x y = 0 :=
  hB.eq_zero_of_level_ne (by norm_num) hx hy

/-- Levels `1` and `3` are orthogonal. -/
theorem IsContravariant.gram_level_one_three (hB : IsContravariant R c h B)
    {x y : VermaModule R c h} (hx : x ∈ levelSpan R c h 1) (hy : y ∈ levelSpan R c h 3) :
    B x y = 0 :=
  hB.eq_zero_of_level_ne (by norm_num) hx hy

/-! ### The determinant, and the Kac formula at `N = 3` -/

/-- **The level-3 Kac determinant.**  The `3 × 3` determinant (expanded along the first row)
of the Gram matrix of `L₋₃|c,h⟩`, `L₋₂L₋₁|c,h⟩`, `L₋₁³|c,h⟩` equals

`48 h² (16h² + 2h(c-5) + c) (3h² + h(c-7) + c + 2)`.

The middle factor is exactly the level-2 determinant divided by `2h`
(`IsContravariant.gram_level_two_det`), as Kac's product formula predicts: the `rs = 2` roots
reappear at level `3` with multiplicity `p(3-2) = p(1) = 1`.

As with `gram_level_two_det`, linear independence of the three vectors is PBW and is not
available here, so this is the determinant of an explicit matrix of inner products. -/
theorem IsContravariant.gram_level_three_det (hB : IsContravariant R c h B)
    (hB1 : B (hwv R c h) (hwv R c h) = 1) :
    B (desc3 R c h) (desc3 R c h)
        * (B (desc21 R c h) (desc21 R c h) * B (desc111 R c h) (desc111 R c h)
            - B (desc21 R c h) (desc111 R c h) * B (desc111 R c h) (desc21 R c h))
      - B (desc3 R c h) (desc21 R c h)
        * (B (desc21 R c h) (desc3 R c h) * B (desc111 R c h) (desc111 R c h)
            - B (desc21 R c h) (desc111 R c h) * B (desc111 R c h) (desc3 R c h))
      + B (desc3 R c h) (desc111 R c h)
        * (B (desc21 R c h) (desc3 R c h) * B (desc111 R c h) (desc21 R c h)
            - B (desc21 R c h) (desc21 R c h) * B (desc111 R c h) (desc3 R c h))
      = 48 * h ^ 2 * (16 * h ^ 2 + 2 * h * (c - 5) + c)
          * (3 * h ^ 2 + h * (c - 7) + c + 2) := by
  obtain ⟨e33, e3a, e3b, ea3, eaa, eab, eb3, eba, ebb⟩ := hB.gram_level_three_entries hB1
  rw [e33, e3a, e3b, ea3, eaa, eab, eb3, eba, ebb]
  ring

omit [Algebra ℚ R] in
/-- The two Kac roots at `rs = 3`, `h₁₃` and `h₃₁`, are the roots of
`3X² + (c-7)X + (c+2)`; equivalently `h₁₃ + h₃₁ = (7-c)/3` and `h₁₃h₃₁ = (c+2)/3`.
This lemma is the corresponding factorisation, with denominators cleared. -/
lemma kac_factor_rs_three {h13 h31 : R}
    (hs : 3 * (h13 + h31) = 7 - c) (hp : 3 * (h13 * h31) = c + 2) :
    3 * ((h - h13) * (h - h31)) = 3 * h ^ 2 + h * (c - 7) + c + 2 := by
  linear_combination (-h) * hs + hp

omit [Algebra ℚ R] in
/-- The two Kac roots at `rs = 2`, `h₁₂` and `h₂₁`, are the roots of `16X² - 2(5-c)X + c`;
equivalently `h₁₂ + h₂₁ = (5-c)/8` and `h₁₂h₂₁ = c/16`. -/
lemma kac_factor_rs_two {h12 h21 : R}
    (hs : 8 * (h12 + h21) = 5 - c) (hp : 16 * (h12 * h21) = c) :
    16 * ((h - h12) * (h - h21)) = 16 * h ^ 2 + 2 * h * (c - 5) + c := by
  linear_combination (-2 * h) * hs + hp

/-- **The level-3 determinant is Kac's product.**  Given the Kac weights at `rs ≤ 3`
— `h₁₁ = 0`, the pair `{h₁₂, h₂₁}` with `h₁₂ + h₂₁ = (5-c)/8`, `h₁₂h₂₁ = c/16`, and the pair
`{h₁₃, h₃₁}` with `h₁₃ + h₃₁ = (7-c)/3`, `h₁₃h₃₁ = (c+2)/3` — the level-3 Gram determinant is

`2304 (h - h₁₁)^{p(2)} · (h - h₁₂)^{p(1)} (h - h₂₁)^{p(1)} · (h - h₁₃)^{p(0)} (h - h₃₁)^{p(0)}`

with `p(2) = 2`, `p(1) = p(0) = 1`, which is the Kac determinant formula at `N = 3`
with `K₃ = 48 · 16 · 3 = 2304` in this basis. -/
theorem IsContravariant.gram_level_three_det_eq_kac (hB : IsContravariant R c h B)
    (hB1 : B (hwv R c h) (hwv R c h) = 1) {h11 h12 h21 h13 h31 : R}
    (e11 : h11 = 0)
    (e2s : 8 * (h12 + h21) = 5 - c) (e2p : 16 * (h12 * h21) = c)
    (e3s : 3 * (h13 + h31) = 7 - c) (e3p : 3 * (h13 * h31) = c + 2) :
    B (desc3 R c h) (desc3 R c h)
        * (B (desc21 R c h) (desc21 R c h) * B (desc111 R c h) (desc111 R c h)
            - B (desc21 R c h) (desc111 R c h) * B (desc111 R c h) (desc21 R c h))
      - B (desc3 R c h) (desc21 R c h)
        * (B (desc21 R c h) (desc3 R c h) * B (desc111 R c h) (desc111 R c h)
            - B (desc21 R c h) (desc111 R c h) * B (desc111 R c h) (desc3 R c h))
      + B (desc3 R c h) (desc111 R c h)
        * (B (desc21 R c h) (desc3 R c h) * B (desc111 R c h) (desc21 R c h)
            - B (desc21 R c h) (desc21 R c h) * B (desc111 R c h) (desc3 R c h))
      = 2304 * (h - h11) ^ 2 * ((h - h12) * (h - h21)) * ((h - h13) * (h - h31)) := by
  rw [hB.gram_level_three_det hB1, ← kac_factor_rs_two e2s e2p,
    ← kac_factor_rs_three e3s e3p, e11]
  ring

omit [Algebra ℚ R] in
/-- Sanity check at `c = 1`, where the Kac weights degenerate to `h_{r,s} = (r-s)²/4`:
`h₁₁ = 0`, `h₁₂ = h₂₁ = 1/4`, `h₁₃ = h₃₁ = 1`.  The level-3 determinant becomes
`144 h² (4h-1)² (h-1)²`, a perfect square as it must be for coincident roots. -/
lemma kac_level_three_at_c_one (x : R) :
    48 * x ^ 2 * (16 * x ^ 2 + 2 * x * ((1 : R) - 5) + 1)
        * (3 * x ^ 2 + x * ((1 : R) - 7) + 1 + 2)
      = 144 * x ^ 2 * (4 * x - 1) ^ 2 * (x - 1) ^ 2 := by
  ring

end Level3

end StringFormal.Virasoro
