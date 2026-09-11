/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import Mathlib.LinearAlgebra.Matrix.Nondegenerate
import StringFormal.Virasoro.ShapovalovLevelFour
import StringFormal.Virasoro.VermaPBW

/-!
# Linear independence of the low-level descendants at generic `(c,h)`

Graph node: `worldsheet.verma-module-pbw-basis` (the linear-independence half, (b)),
`worldsheet.kac-determinant`.
Convention: `conv.virasoro-standard`
  `[L_m, L_n] = (m - n) L_{m+n} + (c/12) m (m² - 1) δ_{m+n,0}`

`VermaPBW.lean` proves the *spanning* half of PBW (`dim V_N ≤ p(N)`); the linear-independence
half is not available in Mathlib `v4.33.1`.  This file supplies a **generic substitute for
`N ≤ 4`**: a nonvanishing Gram determinant forces linear independence, and the level `≤ 4`
Gram determinants have already been computed in closed form in `Shapovalov.lean`,
`ShapovalovLevelThree.lean`, `ShapovalovLevelFour.lean`.

The logic is pure linear algebra: if `∑ᵢ aᵢ vᵢ = 0` then `∑ᵢ aᵢ B(vᵢ, v_j) = 0` for every `j`,
i.e. `a ᵥ* Gram = 0`, so `det Gram ≠ 0` gives `a = 0`.

## Main results

* `StringFormal.gramMatrix`, `StringFormal.linearIndependent_of_gram_det_ne_zero`:
  the general lemma (any bilinear form over any commutative domain; no symmetry, no
  nondegeneracy on the ambient module, no finite-dimensionality).  Mathlib has the analogous
  statement only for real/complex inner products
  (`Matrix.linearIndependent_of_det_gram_ne_zero`).
* `descFamily2`, `descFamily3`, `descFamily4`: the `p(N)` standard descendants at `N = 2, 3, 4`
  packaged as `Fin p(N)`-families, and `IsContravariant.gram_det_descFamily{2,3,4}`: their Gram
  determinants are the level-`N` Kac polynomials (restatements of the determinants proved in
  `Shapovalov.lean`, `ShapovalovLevelThree.lean`, `ShapovalovLevelFour.lean`).
* `IsContravariant.linearIndependent_descFamily{2,3,4}`: **generic PBW (b) for `N ≤ 4`** — the
  standard descendants are linearly independent whenever the level-`N` Kac polynomial is
  nonzero at `(c,h)`.
* `levelSpan_two_eq_span_descFamily2`, `levelSpan_three_eq_span_descFamily3`,
  `levelSpan_four_eq_span_descFamily4`: unconditionally `V_N = span` of the `p(N)` standard
  descendants for `N = 2, 3, 4` — e.g. `V₂ = span {L₋₂|c,h⟩, L₋₁²|c,h⟩}`.  At `N = 2` this is
  immediate from the two compositions of `2` (`composition_two_blocks`); at `N = 3, 4` it uses
  the straightening of `VermaPBW.lean` (`levelSpan_eq_ordSpan`) plus the arithmetic enumerations
  `ordWord_sum_three`, `ordWord_sum_four` of the *ordered* words of total mode `-3`, `-4`.
* `IsContravariant.finrank_levelSpan_two`, `finrank_levelSpan_three`, `finrank_levelSpan_four`:
  **`dim V_N = p(N)` for `N = 2, 3, 4` at generic `(c,h)`** (`2`, `3`, `5`) — the PBW equality,
  of which `VermaPBW.lean` had only `≤`.  The upper bound here does *not* go through
  `finrank_levelSpan_le_card_partition`: the partition counts `p(3) = 3`, `p(4) = 5` are never
  needed, because the spanning set is cut down to an explicit finite list of ordered words.
  (Mathlib has no cardinality lemmas for `Nat.Partition`, and `decide` does not reduce the
  `Fintype.ofSurjective` instance, so that route is blocked.)
  `IsContravariant.three_le_finrank_levelSpan_three`,
  `IsContravariant.five_le_finrank_levelSpan_four` are the `≥` halves, kept as named corollaries.
* `kac_level_two_pos`, `kac_level_two_nonneg`, `kac_level_two_at_c_one`: on `h > 0`, `c ≥ 1` the
  level-2 Kac determinant is `≥ 0`, and `> 0` as soon as `c > 1`.  Note there is **no upper
  restriction on `c`**: for `c > 25` the Kac quadratic does have two real roots, but both are
  negative (sum `(5-c)/8 < 0`, product `c/16 > 0`).  The only zero in the closed region is
  `c = 1, h = 1/4`, where the determinant is `2h(4h-1)²`.
  Hence `IsContravariant.linearIndependent_descFamily2_of_pos` and
  `IsContravariant.finrank_levelSpan_two_of_pos` need no determinant hypothesis.
* `IsContravariant.desc2_sub_desc11_orthogonal_levelSpan_two`: at that one zero `c = 1`,
  `h = 1/4` the whole level-2 Gram matrix is the constant `3/2`, and `(L₋₂ - L₋₁²)|c,h⟩` is
  orthogonal to all of `V₂` — the degeneracy is real, and the Gram criterion is *not*
  reversible (`det = 0` does not make the vectors dependent).

## What this does and does not give

It gives linear independence of the `p(N)` standard descendants for those `(c,h)` at which the
level-`N` Kac polynomial does **not** vanish, i.e. for generic `(c,h)`.  It says nothing at the
Kac zeros (where the vectors are genuinely dependent only after quotienting — at a Kac zero the
Gram matrix is singular but the vectors may still be independent, the form merely degenerates),
and it still presupposes the existence of a normalised contravariant form, which by
`exists_isContravariant_iff_hwv_ne_zero` is equivalent to `hwv ≠ 0`, i.e. to `V(c,h) ≠ 0` —
itself a consequence of the full PBW.  So this is a *conditional* generic PBW (b), not PBW (b).
-/

namespace StringFormal

section GramIndependence

open Matrix

variable {R M ι : Type*} [CommRing R] [AddCommGroup M] [Module R M] [Fintype ι] [DecidableEq ι]

/-- The **Gram matrix** `(B (v i) (v j))_{i,j}` of a finite family `v` with respect to a
bilinear form `B`. -/
def gramMatrix (B : M →ₗ[R] M →ₗ[R] R) (v : ι → M) : Matrix ι ι R :=
  Matrix.of fun i j => B (v i) (v j)

omit [Fintype ι] [DecidableEq ι] in
@[simp]
lemma gramMatrix_apply (B : M →ₗ[R] M →ₗ[R] R) (v : ι → M) (i j : ι) :
    gramMatrix B v i j = B (v i) (v j) := rfl

omit [DecidableEq ι] in
/-- A vanishing linear combination of the `vᵢ` is annihilated by the Gram matrix. -/
lemma vecMul_gramMatrix_eq_zero {B : M →ₗ[R] M →ₗ[R] R} {v : ι → M} {g : ι → R}
    (hg : ∑ i, g i • v i = 0) : g ᵥ* gramMatrix B v = 0 := by
  funext j
  have h0 : B (∑ i, g i • v i) (v j) = 0 := by rw [hg, map_zero, LinearMap.zero_apply]
  simp only [map_sum, LinearMap.map_smul, LinearMap.sum_apply, LinearMap.smul_apply,
    smul_eq_mul] at h0
  simpa [Matrix.vecMul, dotProduct] using h0

/-- **Nonvanishing Gram determinant implies linear independence.**  Over a domain, if the Gram
matrix of a finite family `v` with respect to *some* bilinear form has nonzero determinant, then
`v` is linearly independent.  No symmetry, no nondegeneracy of `B` on the whole module, and no
finite-dimensionality is needed. -/
theorem linearIndependent_of_gram_det_ne_zero [NoZeroDivisors R] (B : M →ₗ[R] M →ₗ[R] R)
    (v : ι → M) (hdet : (gramMatrix B v).det ≠ 0) : LinearIndependent R v := by
  rw [Fintype.linearIndependent_iff]
  intro g hg
  exact congrFun
    (Matrix.eq_zero_of_vecMul_eq_zero hdet (vecMul_gramMatrix_eq_zero (B := B) hg))

end GramIndependence

namespace Virasoro

/-! ### Level 2 -/

section Level2

variable (R : Type*) [CommRing R] [Algebra ℚ R] (c h : R)

/-- The two standard level-2 descendants `L₋₂|c,h⟩`, `L₋₁²|c,h⟩` as a family indexed by
`Fin 2`, one entry per composition (equivalently, per partition) of `2`. -/
noncomputable def descFamily2 : Fin 2 → VermaModule R c h :=
  ![desc2 R c h, desc11 R c h]

variable {R c h}
variable {B : VermaModule R c h →ₗ[R] VermaModule R c h →ₗ[R] R}

/-- The `2 × 2` Gram determinant of `descFamily2` is the level-2 Kac polynomial
`2h(16h² + 2h(c-5) + c)`.  Restatement of `IsContravariant.gram_level_two_det` with the
matrix packaged as `gramMatrix`. -/
theorem IsContravariant.gram_det_descFamily2 (hB : IsContravariant R c h B)
    (hB1 : B (hwv R c h) (hwv R c h) = 1) :
    (gramMatrix B (descFamily2 R c h)).det
      = 2 * h * (16 * h ^ 2 + 2 * h * (c - 5) + c) := by
  rw [Matrix.det_fin_two]
  simp only [gramMatrix_apply, descFamily2, Matrix.cons_val_zero, Matrix.cons_val_one]
  exact hB.gram_level_two_det hB1

/-- **Generic PBW at level 2.**  If the level-2 Kac polynomial `2h(16h² + 2h(c-5) + c)` is
nonzero, then `L₋₂|c,h⟩` and `L₋₁²|c,h⟩` are linearly independent, so `dim V₂ = 2 = p(2)`.

The hypothesis is a nonvanishing *polynomial* in `(c,h)`, hence holds at generic `(c,h)`; it
fails exactly on the level-2 Kac locus (`h = 0` or `h = h₁₂, h₂₁`), where these two vectors may
still be independent but the Shapovalov form degenerates.  This is a *substitute* for the
linear-independence half of PBW, not a proof of it: it assumes a normalised contravariant form
exists, which is equivalent to `hwv ≠ 0` (`exists_isContravariant_iff_hwv_ne_zero`). -/
theorem IsContravariant.linearIndependent_descFamily2 [NoZeroDivisors R]
    (hB : IsContravariant R c h B) (hB1 : B (hwv R c h) (hwv R c h) = 1)
    (hdet : 2 * h * (16 * h ^ 2 + 2 * h * (c - 5) + c) ≠ 0) :
    LinearIndependent R (descFamily2 R c h) :=
  linearIndependent_of_gram_det_ne_zero B _ (by
    rw [hB.gram_det_descFamily2 hB1]; exact hdet)

end Level2

/-! ### Level 3 -/

section Level3

variable (R : Type*) [CommRing R] [Algebra ℚ R] (c h : R)

/-- The three standard level-3 descendants `L₋₃|c,h⟩`, `L₋₂L₋₁|c,h⟩`, `L₋₁³|c,h⟩`. -/
noncomputable def descFamily3 : Fin 3 → VermaModule R c h :=
  ![desc3 R c h, desc21 R c h, desc111 R c h]

variable {R c h}
variable {B : VermaModule R c h →ₗ[R] VermaModule R c h →ₗ[R] R}

/-- The `3 × 3` Gram determinant of `descFamily3` is the level-3 Kac polynomial
`48h²(16h² + 2h(c-5) + c)(3h² + h(c-7) + c + 2)`.  Restatement of
`IsContravariant.gram_level_three_det` with the matrix packaged as `gramMatrix`. -/
theorem IsContravariant.gram_det_descFamily3 (hB : IsContravariant R c h B)
    (hB1 : B (hwv R c h) (hwv R c h) = 1) :
    (gramMatrix B (descFamily3 R c h)).det
      = 48 * h ^ 2 * (16 * h ^ 2 + 2 * h * (c - 5) + c)
          * (3 * h ^ 2 + h * (c - 7) + c + 2) := by
  rw [Matrix.det_fin_three]
  simp only [gramMatrix_apply, descFamily3, Matrix.cons_val_zero, Matrix.cons_val_one,
    Matrix.cons_val_two, Matrix.head_cons, Matrix.tail_cons]
  linear_combination hB.gram_level_three_det hB1

/-- **Generic PBW at level 3.**  If the level-3 Kac polynomial is nonzero then
`L₋₃|c,h⟩`, `L₋₂L₋₁|c,h⟩`, `L₋₁³|c,h⟩` are linearly independent, so `dim V₃ = 3 = p(3)`.
Same caveats as `IsContravariant.linearIndependent_descFamily2`. -/
theorem IsContravariant.linearIndependent_descFamily3 [NoZeroDivisors R]
    (hB : IsContravariant R c h B) (hB1 : B (hwv R c h) (hwv R c h) = 1)
    (hdet : 48 * h ^ 2 * (16 * h ^ 2 + 2 * h * (c - 5) + c)
        * (3 * h ^ 2 + h * (c - 7) + c + 2) ≠ 0) :
    LinearIndependent R (descFamily3 R c h) :=
  linearIndependent_of_gram_det_ne_zero B _ (by
    rw [hB.gram_det_descFamily3 hB1]; exact hdet)

end Level3

/-! ### Level 4 -/

section Level4

variable (R : Type*) [CommRing R] [Algebra ℚ R] (c h : R)

/-- The five standard level-4 descendants `L₋₄|c,h⟩`, `L₋₃L₋₁|c,h⟩`, `L₋₂²|c,h⟩`,
`L₋₂L₋₁²|c,h⟩`, `L₋₁⁴|c,h⟩`. -/
noncomputable def descFamily4 : Fin 5 → VermaModule R c h :=
  ![desc4 R c h, desc31 R c h, desc22 R c h, desc211 R c h, desc1111 R c h]

variable {R c h}
variable {B : VermaModule R c h →ₗ[R] VermaModule R c h →ₗ[R] R}

/-- The Gram matrix of `descFamily4` is the explicit `5 × 5` matrix of inner products used in
`IsContravariant.gram_level_four_det`. -/
theorem gramMatrix_descFamily4 (B : VermaModule R c h →ₗ[R] VermaModule R c h →ₗ[R] R) :
    gramMatrix B (descFamily4 R c h) =
      !![B (desc4 R c h) (desc4 R c h), B (desc4 R c h) (desc31 R c h),
             B (desc4 R c h) (desc22 R c h), B (desc4 R c h) (desc211 R c h),
             B (desc4 R c h) (desc1111 R c h);
           B (desc31 R c h) (desc4 R c h), B (desc31 R c h) (desc31 R c h),
             B (desc31 R c h) (desc22 R c h), B (desc31 R c h) (desc211 R c h),
             B (desc31 R c h) (desc1111 R c h);
           B (desc22 R c h) (desc4 R c h), B (desc22 R c h) (desc31 R c h),
             B (desc22 R c h) (desc22 R c h), B (desc22 R c h) (desc211 R c h),
             B (desc22 R c h) (desc1111 R c h);
           B (desc211 R c h) (desc4 R c h), B (desc211 R c h) (desc31 R c h),
             B (desc211 R c h) (desc22 R c h), B (desc211 R c h) (desc211 R c h),
             B (desc211 R c h) (desc1111 R c h);
           B (desc1111 R c h) (desc4 R c h), B (desc1111 R c h) (desc31 R c h),
             B (desc1111 R c h) (desc22 R c h), B (desc1111 R c h) (desc211 R c h),
             B (desc1111 R c h) (desc1111 R c h)] := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp [gramMatrix, descFamily4]

/-- The `5 × 5` Gram determinant of `descFamily4` is the level-4 Kac polynomial
`384h³(8h + c - 1)(16h² + 2h(c-5) + c)²(3h² + h(c-7) + c + 2)(16h² + 10ch - 82h + 15c + 66)`.
Restatement of `IsContravariant.gram_level_four_det` with the matrix packaged as
`gramMatrix`. -/
theorem IsContravariant.gram_det_descFamily4 (hB : IsContravariant R c h B)
    (hB1 : B (hwv R c h) (hwv R c h) = 1) :
    (gramMatrix B (descFamily4 R c h)).det
      = 384 * h ^ 3 * (8 * h + c - 1) * (16 * h ^ 2 + 2 * h * (c - 5) + c) ^ 2
          * (3 * h ^ 2 + h * (c - 7) + c + 2)
          * (16 * h ^ 2 + 10 * c * h - 82 * h + 15 * c + 66) := by
  rw [gramMatrix_descFamily4]
  exact hB.gram_level_four_det hB1

/-- **Generic PBW at level 4.**  If the level-4 Kac polynomial is nonzero then the five standard
level-4 descendants are linearly independent, so `dim V₄ = 5 = p(4)`.
Same caveats as `IsContravariant.linearIndependent_descFamily2`. -/
theorem IsContravariant.linearIndependent_descFamily4 [NoZeroDivisors R]
    (hB : IsContravariant R c h B) (hB1 : B (hwv R c h) (hwv R c h) = 1)
    (hdet : 384 * h ^ 3 * (8 * h + c - 1) * (16 * h ^ 2 + 2 * h * (c - 5) + c) ^ 2
        * (3 * h ^ 2 + h * (c - 7) + c + 2)
        * (16 * h ^ 2 + 10 * c * h - 82 * h + 15 * c + 66) ≠ 0) :
    LinearIndependent R (descFamily4 R c h) :=
  linearIndependent_of_gram_det_ne_zero B _ (by
    rw [hB.gram_det_descFamily4 hB1]; exact hdet)

end Level4

/-! ### Dimensions of the level subspaces -/

section Finrank

variable (R : Type*) [CommRing R] [Algebra ℚ R] (c h : R)

lemma descFamily2_mem_levelSpan (i : Fin 2) : descFamily2 R c h i ∈ levelSpan R c h 2 := by
  fin_cases i
  · exact desc2_mem_levelSpan R c h
  · exact desc11_mem_levelSpan R c h

lemma descFamily3_mem_levelSpan (i : Fin 3) : descFamily3 R c h i ∈ levelSpan R c h 3 := by
  fin_cases i
  · exact desc3_mem_levelSpan R c h
  · exact desc21_mem_levelSpan R c h
  · exact desc111_mem_levelSpan R c h

lemma descFamily4_mem_levelSpan (i : Fin 5) : descFamily4 R c h i ∈ levelSpan R c h 4 := by
  fin_cases i
  · exact desc4_mem_levelSpan R c h
  · exact desc31_mem_levelSpan R c h
  · exact desc22_mem_levelSpan R c h
  · exact desc211_mem_levelSpan R c h
  · exact desc1111_mem_levelSpan R c h

lemma span_descFamily2_le_levelSpan :
    Submodule.span R (Set.range (descFamily2 R c h)) ≤ levelSpan R c h 2 := by
  rw [Submodule.span_le]
  rintro x ⟨i, rfl⟩
  exact descFamily2_mem_levelSpan R c h i

lemma span_descFamily3_le_levelSpan :
    Submodule.span R (Set.range (descFamily3 R c h)) ≤ levelSpan R c h 3 := by
  rw [Submodule.span_le]
  rintro x ⟨i, rfl⟩
  exact descFamily3_mem_levelSpan R c h i

lemma span_descFamily4_le_levelSpan :
    Submodule.span R (Set.range (descFamily4 R c h)) ≤ levelSpan R c h 4 := by
  rw [Submodule.span_le]
  rintro x ⟨i, rfl⟩
  exact descFamily4_mem_levelSpan R c h i

/-- A composition of `2` is `[2]` or `[1,1]`: the two level-2 descendants `desc2`, `desc11`
exhaust the generators of `V₂`, with no straightening needed.  (At level `3` the analogous list
contains `[1,2]`, i.e. `L₋₁L₋₂|c,h⟩`, which is *not* one of the three standard descendants; for
`N = 3, 4` the argument therefore goes through the ordered words of `VermaPBW.lean` instead —
see `ordWord_sum_three`, `ordWord_sum_four`.) -/
lemma composition_two_blocks (cmp : Composition 2) : cmp.blocks = [2] ∨ cmp.blocks = [1, 1] := by
  obtain ⟨l, hpos, hsum⟩ := cmp
  match l with
  | [] => simp at hsum
  | [a] =>
      left
      have ha : a = 2 := by simpa using hsum
      simp [ha]
  | [a, b] =>
      right
      have ha := hpos (i := a) (by simp)
      have hb := hpos (i := b) (by simp)
      have hab : a + b = 2 := by simpa using hsum
      have h1 : a = 1 := by omega
      have h2 : b = 1 := by omega
      simp [h1, h2]
  | a :: b :: d :: t =>
      exfalso
      have ha := hpos (i := a) (by simp)
      have hb := hpos (i := b) (by simp)
      have hd := hpos (i := d) (by simp)
      simp only [List.sum_cons] at hsum
      omega

/-- **`V₂` is spanned by the two standard level-2 descendants** (not just by the compositions of
`2`): `V₂ = span {L₋₂|c,h⟩, L₋₁²|c,h⟩}`.  Unconditional; no PBW and no form needed. -/
lemma levelSpan_two_eq_span_descFamily2 :
    levelSpan R c h 2 = Submodule.span R (Set.range (descFamily2 R c h)) := by
  refine le_antisymm ?_ (span_descFamily2_le_levelSpan R c h)
  rw [levelSpan, Submodule.span_le]
  rintro x ⟨cmp, rfl⟩
  rcases composition_two_blocks cmp with hb | hb
  · have hw : levelWord R c h 2 cmp = desc2 R c h := by rw [levelWord, hb]; rfl
    rw [hw]
    exact Submodule.subset_span ⟨0, rfl⟩
  · have hw : levelWord R c h 2 cmp = desc11 R c h := by rw [levelWord, hb]; rfl
    rw [hw]
    exact Submodule.subset_span ⟨1, rfl⟩

/-! #### Enumerating the ordered words at levels 3 and 4

`VermaPBW.levelSpan_eq_ordSpan` has already done the straightening: `V_N` is spanned by the
**ordered** words `L_{-b₁} ⋯ L_{-b_k}|c,h⟩` with `b₁ ≥ ⋯ ≥ b_k ≥ 1` and `Σ bᵢ = N`.  (The
identity that makes this work is `⁅L_a, L_b⁆ = (a-b) L_{a+b}` with no central term for
`a, b < 0`, e.g. `L₋₁L₋₂|c,h⟩ = L₋₂L₋₁|c,h⟩ + L₋₃|c,h⟩`.)  So upgrading `dim V_N ≥ p(N)` to an
equality only needs the *list* of those words, which is pure arithmetic on non-decreasing lists
of negative integers — no Virasoro relation and no `Nat.Partition` cardinality. -/

/-- The ordered words of total mode `-3` are exactly `[-3]`, `[-2,-1]`, `[-1,-1,-1]`, i.e. the
three standard level-3 descendants `L₋₃|c,h⟩`, `L₋₂L₋₁|c,h⟩`, `L₋₁³|c,h⟩`.  Note `[-1,-2]` is
*not* ordered, which is exactly why `Composition 3` (four blocks) overcounts. -/
lemma ordWord_sum_three {l : List ℤ} (hl : IsOrdWord l) (hs : l.sum = -3) :
    l = [-3] ∨ l = [-2, -1] ∨ l = [-1, -1, -1] := by
  match l with
  | [] => simp at hs
  | [a] =>
      left
      simp only [List.sum_cons, List.sum_nil, add_zero] at hs
      simp [hs]
  | [a, b] =>
      right; left
      have ha := hl.neg a (by simp)
      have hb := hl.neg b (by simp)
      have hab : a ≤ b := (List.pairwise_cons.mp hl.sorted).1 b (by simp)
      simp only [List.sum_cons, List.sum_nil, add_zero] at hs
      have h1 : a = -2 := by omega
      have h2 : b = -1 := by omega
      simp [h1, h2]
  | [a, b, d] =>
      right; right
      have ha := hl.neg a (by simp)
      have hb := hl.neg b (by simp)
      have hd := hl.neg d (by simp)
      simp only [List.sum_cons, List.sum_nil, add_zero] at hs
      have h1 : a = -1 := by omega
      have h2 : b = -1 := by omega
      have h3 : d = -1 := by omega
      simp [h1, h2, h3]
  | a :: b :: d :: e :: t =>
      exfalso
      have ha := hl.neg a (by simp)
      have hb := hl.neg b (by simp)
      have hd := hl.neg d (by simp)
      have he := hl.neg e (by simp)
      have hts : t.sum ≤ 0 := sum_nonpos_of_neg fun n hn => hl.neg n (by simp [hn])
      simp only [List.sum_cons] at hs
      omega

/-- **`V₃` is spanned by the three standard level-3 descendants**:
`V₃ = span {L₋₃|c,h⟩, L₋₂L₋₁|c,h⟩, L₋₁³|c,h⟩}`.  Unconditional; no PBW and no form needed.
The straightening is supplied by `levelSpan_eq_ordSpan`, the enumeration by
`ordWord_sum_three`. -/
lemma levelSpan_three_eq_span_descFamily3 :
    levelSpan R c h 3 = Submodule.span R (Set.range (descFamily3 R c h)) := by
  refine le_antisymm ?_ (span_descFamily3_le_levelSpan R c h)
  rw [levelSpan_eq_ordSpan, ordSpan_eq_span, Submodule.span_le]
  rintro x ⟨l, hl, hsum, rfl⟩
  have hs : l.sum = -3 := by simpa using hsum
  rcases ordWord_sum_three hl hs with rfl | rfl | rfl
  · exact Submodule.subset_span ⟨0, rfl⟩
  · exact Submodule.subset_span ⟨1, rfl⟩
  · exact Submodule.subset_span ⟨2, rfl⟩

/-- The ordered words of total mode `-4` are exactly `[-4]`, `[-3,-1]`, `[-2,-2]`, `[-2,-1,-1]`,
`[-1,-1,-1,-1]`, i.e. the five standard level-4 descendants `L₋₄|c,h⟩`, `L₋₃L₋₁|c,h⟩`,
`L₋₂²|c,h⟩`, `L₋₂L₋₁²|c,h⟩`, `L₋₁⁴|c,h⟩`.  (`Composition 4` has eight blocks; the three
unordered ones `[1,3]`, `[1,2,1]`, `[1,1,2]` are removed by straightening.) -/
lemma ordWord_sum_four {l : List ℤ} (hl : IsOrdWord l) (hs : l.sum = -4) :
    l = [-4] ∨ l = [-3, -1] ∨ l = [-2, -2] ∨ l = [-2, -1, -1] ∨ l = [-1, -1, -1, -1] := by
  match l with
  | [] => simp at hs
  | [a] =>
      left
      simp only [List.sum_cons, List.sum_nil, add_zero] at hs
      simp [hs]
  | [a, b] =>
      have ha := hl.neg a (by simp)
      have hb := hl.neg b (by simp)
      have hab : a ≤ b := (List.pairwise_cons.mp hl.sorted).1 b (by simp)
      simp only [List.sum_cons, List.sum_nil, add_zero] at hs
      have hcase : (a = -3 ∧ b = -1) ∨ (a = -2 ∧ b = -2) := by omega
      rcases hcase with ⟨h1, h2⟩ | ⟨h1, h2⟩
      · exact Or.inr (Or.inl (by simp [h1, h2]))
      · exact Or.inr (Or.inr (Or.inl (by simp [h1, h2])))
  | [a, b, d] =>
      refine Or.inr (Or.inr (Or.inr (Or.inl ?_)))
      have ha := hl.neg a (by simp)
      have hb := hl.neg b (by simp)
      have hd := hl.neg d (by simp)
      have hab : a ≤ b := (List.pairwise_cons.mp hl.sorted).1 b (by simp)
      have had : a ≤ d := (List.pairwise_cons.mp hl.sorted).1 d (by simp)
      have hbd : b ≤ d := (List.pairwise_cons.mp hl.tail.sorted).1 d (by simp)
      simp only [List.sum_cons, List.sum_nil, add_zero] at hs
      have h1 : a = -2 := by omega
      have h2 : b = -1 := by omega
      have h3 : d = -1 := by omega
      simp [h1, h2, h3]
  | [a, b, d, e] =>
      refine Or.inr (Or.inr (Or.inr (Or.inr ?_)))
      have ha := hl.neg a (by simp)
      have hb := hl.neg b (by simp)
      have hd := hl.neg d (by simp)
      have he := hl.neg e (by simp)
      simp only [List.sum_cons, List.sum_nil, add_zero] at hs
      have h1 : a = -1 := by omega
      have h2 : b = -1 := by omega
      have h3 : d = -1 := by omega
      have h4 : e = -1 := by omega
      simp [h1, h2, h3, h4]
  | a :: b :: d :: e :: f :: t =>
      exfalso
      have ha := hl.neg a (by simp)
      have hb := hl.neg b (by simp)
      have hd := hl.neg d (by simp)
      have he := hl.neg e (by simp)
      have hf := hl.neg f (by simp)
      have hts : t.sum ≤ 0 := sum_nonpos_of_neg fun n hn => hl.neg n (by simp [hn])
      simp only [List.sum_cons] at hs
      omega

/-- **`V₄` is spanned by the five standard level-4 descendants**:
`V₄ = span {L₋₄|c,h⟩, L₋₃L₋₁|c,h⟩, L₋₂²|c,h⟩, L₋₂L₋₁²|c,h⟩, L₋₁⁴|c,h⟩}`.  Unconditional; no PBW
and no form needed. -/
lemma levelSpan_four_eq_span_descFamily4 :
    levelSpan R c h 4 = Submodule.span R (Set.range (descFamily4 R c h)) := by
  refine le_antisymm ?_ (span_descFamily4_le_levelSpan R c h)
  rw [levelSpan_eq_ordSpan, ordSpan_eq_span, Submodule.span_le]
  rintro x ⟨l, hl, hsum, rfl⟩
  have hs : l.sum = -4 := by simpa using hsum
  rcases ordWord_sum_four hl hs with rfl | rfl | rfl | rfl | rfl
  · exact Submodule.subset_span ⟨0, rfl⟩
  · exact Submodule.subset_span ⟨1, rfl⟩
  · exact Submodule.subset_span ⟨2, rfl⟩
  · exact Submodule.subset_span ⟨3, rfl⟩
  · exact Submodule.subset_span ⟨4, rfl⟩

end Finrank

section FinrankField

variable {K : Type*} [Field K] [CharZero K] {c h : K}
variable {B : VermaModule K c h →ₗ[K] VermaModule K c h →ₗ[K] K}

lemma levelSpan_moduleFinite (N : ℕ) : Module.Finite K (levelSpan K c h N) :=
  Module.Finite.iff_fg.mpr (levelSpan_fg K c h N)

/-- **`dim V₂ = 2 = p(2)` at generic `(c,h)`.**  This is the `N = 2` case of the PBW statement
`dim V_N = p(N)`: `VermaPBW.lean` gives `≤`, and the nonvanishing of the level-2 Kac polynomial
gives `≥` through the Gram determinant.  Conditional on the existence of a normalised
contravariant form, i.e. on `hwv ≠ 0` (`exists_isContravariant_iff_hwv_ne_zero`). -/
theorem IsContravariant.finrank_levelSpan_two (hB : IsContravariant K c h B)
    (hB1 : B (hwv K c h) (hwv K c h) = 1)
    (hdet : 2 * h * (16 * h ^ 2 + 2 * h * (c - 5) + c) ≠ 0) :
    Module.finrank K (levelSpan K c h 2) = 2 := by
  rw [levelSpan_two_eq_span_descFamily2]
  simpa using finrank_span_eq_card (hB.linearIndependent_descFamily2 hB1 hdet)

/-- **`dim V₃ = 3 = p(3)` at generic `(c,h)`.**  Same shape as
`IsContravariant.finrank_levelSpan_two`: the upper bound comes from
`levelSpan_three_eq_span_descFamily3` (straightening, unconditional), the lower bound from the
nonvanishing of the level-3 Kac polynomial through the Gram determinant.  Conditional on the
existence of a normalised contravariant form, i.e. on `hwv ≠ 0`
(`exists_isContravariant_iff_hwv_ne_zero`).

Note the partition count `p(3) = 3` is never needed: the spanning set is cut down directly to
the three ordered words by `ordWord_sum_three`. -/
theorem IsContravariant.finrank_levelSpan_three (hB : IsContravariant K c h B)
    (hB1 : B (hwv K c h) (hwv K c h) = 1)
    (hdet : 48 * h ^ 2 * (16 * h ^ 2 + 2 * h * (c - 5) + c)
        * (3 * h ^ 2 + h * (c - 7) + c + 2) ≠ 0) :
    Module.finrank K (levelSpan K c h 3) = 3 := by
  rw [levelSpan_three_eq_span_descFamily3]
  simpa using finrank_span_eq_card (hB.linearIndependent_descFamily3 hB1 hdet)

/-- `dim V₃ ≥ 3 = p(3)` at generic `(c,h)`; the half of
`IsContravariant.finrank_levelSpan_three` that comes from the Gram determinant. -/
theorem IsContravariant.three_le_finrank_levelSpan_three (hB : IsContravariant K c h B)
    (hB1 : B (hwv K c h) (hwv K c h) = 1)
    (hdet : 48 * h ^ 2 * (16 * h ^ 2 + 2 * h * (c - 5) + c)
        * (3 * h ^ 2 + h * (c - 7) + c + 2) ≠ 0) :
    3 ≤ Module.finrank K (levelSpan K c h 3) :=
  (hB.finrank_levelSpan_three hB1 hdet).ge

/-- **`dim V₄ = 5 = p(4)` at generic `(c,h)`.**  Same remark as at level 3; `p(4) = 5` is not
needed, `ordWord_sum_four` lists the five ordered words directly. -/
theorem IsContravariant.finrank_levelSpan_four (hB : IsContravariant K c h B)
    (hB1 : B (hwv K c h) (hwv K c h) = 1)
    (hdet : 384 * h ^ 3 * (8 * h + c - 1) * (16 * h ^ 2 + 2 * h * (c - 5) + c) ^ 2
        * (3 * h ^ 2 + h * (c - 7) + c + 2)
        * (16 * h ^ 2 + 10 * c * h - 82 * h + 15 * c + 66) ≠ 0) :
    Module.finrank K (levelSpan K c h 4) = 5 := by
  rw [levelSpan_four_eq_span_descFamily4]
  simpa using finrank_span_eq_card (hB.linearIndependent_descFamily4 hB1 hdet)

/-- `dim V₄ ≥ 5 = p(4)` at generic `(c,h)`. -/
theorem IsContravariant.five_le_finrank_levelSpan_four (hB : IsContravariant K c h B)
    (hB1 : B (hwv K c h) (hwv K c h) = 1)
    (hdet : 384 * h ^ 3 * (8 * h + c - 1) * (16 * h ^ 2 + 2 * h * (c - 5) + c) ^ 2
        * (3 * h ^ 2 + h * (c - 7) + c + 2)
        * (16 * h ^ 2 + 10 * c * h - 82 * h + 15 * c + 66) ≠ 0) :
    5 ≤ Module.finrank K (levelSpan K c h 4) :=
  (hB.finrank_levelSpan_four hB1 hdet).ge

end FinrankField

/-! ### The unitary region at level 2 -/

section Positivity

variable {K : Type*} [Field K] [LinearOrder K] [IsStrictOrderedRing K] {c h : K}

omit [LinearOrder K] [IsStrictOrderedRing K] in
/-- Completing the square: `16 · (16h² + 2h(c-5) + c) = (16h + c - 5)² + (c-1)(25-c)`.  The
discriminant of the level-2 Kac quadratic in `h` is `4(c-1)(c-25)`, so the quadratic has no real
root exactly for `1 < c < 25`. -/
lemma kac_level_two_square (c h : K) :
    16 * (16 * h ^ 2 + 2 * h * (c - 5) + c)
      = (16 * h + c - 5) ^ 2 + (c - 1) * (25 - c) := by ring

/-- **The level-2 Kac determinant is strictly positive for `h > 0`, `c > 1`.**  Necessary (not
sufficient) for unitarity of `V(c,h)` in the standard region `c > 1`, `h > 0`.

Two regimes, and note that there is *no* upper restriction on `c`: for `c ≥ 5` positivity is
term-by-term, while for `1 < c < 5` it comes from the completed square, `(c-1)(25-c) > 0`.  For
`c > 25` the Kac quadratic does have two real roots `h₁₂, h₂₁`, but their sum `(5-c)/8` is
negative and their product `c/16` positive, so both are negative and irrelevant to `h > 0`. -/
lemma kac_level_two_pos (hh : 0 < h) (hc : 1 < c) :
    0 < 2 * h * (16 * h ^ 2 + 2 * h * (c - 5) + c) := by
  rcases le_or_gt 5 c with hc5 | hc5
  · have : 0 < 16 * h ^ 2 + 2 * h * (c - 5) + c := by nlinarith
    positivity
  · have : 0 < 16 * h ^ 2 + 2 * h * (c - 5) + c := by
      nlinarith [sq_nonneg (16 * h + c - 5), kac_level_two_square c h]
    positivity

omit [LinearOrder K] [IsStrictOrderedRing K] in
/-- At `c = 1` the level-2 Kac determinant degenerates to `2h(4h-1)²`: the two Kac weights
`h₁₂, h₂₁` collide at `h = 1/4`, so the determinant vanishes there and is otherwise `> 0` for
`h > 0`.  The degenerate direction is exhibited in
`IsContravariant.desc2_sub_desc11_orthogonal_levelSpan_two`. -/
lemma kac_level_two_at_c_one (h : K) :
    2 * h * (16 * h ^ 2 + 2 * h * ((1 : K) - 5) + 1) = 2 * h * (4 * h - 1) ^ 2 := by ring

/-- **The level-2 Kac determinant is nonnegative on the whole closed region `h > 0`, `c ≥ 1`**,
and it vanishes there only at `c = 1, h = 1/4` (see `kac_level_two_at_c_one`). -/
lemma kac_level_two_nonneg (hh : 0 < h) (hc : 1 ≤ c) :
    0 ≤ 2 * h * (16 * h ^ 2 + 2 * h * (c - 5) + c) := by
  rcases eq_or_lt_of_le hc with rfl | hc1
  · rw [kac_level_two_at_c_one]
    positivity
  · exact (kac_level_two_pos hh hc1).le

variable {B : VermaModule K c h →ₗ[K] VermaModule K c h →ₗ[K] K}

/-- **Generic PBW at level 2 on the unitary region.**  For `h > 0` and `c > 1` the two level-2
descendants are linearly independent and `dim V₂ = 2 = p(2)`: the hypothesis of
`IsContravariant.linearIndependent_descFamily2` is automatic there. -/
theorem IsContravariant.linearIndependent_descFamily2_of_pos (hB : IsContravariant K c h B)
    (hB1 : B (hwv K c h) (hwv K c h) = 1) (hh : 0 < h) (hc : 1 < c) :
    LinearIndependent K (descFamily2 K c h) :=
  hB.linearIndependent_descFamily2 hB1 (kac_level_two_pos hh hc).ne'

/-- `dim V₂ = 2 = p(2)` for `h > 0`, `c > 1`. -/
theorem IsContravariant.finrank_levelSpan_two_of_pos (hB : IsContravariant K c h B)
    (hB1 : B (hwv K c h) (hwv K c h) = 1) (hh : 0 < h) (hc : 1 < c) :
    Module.finrank K (levelSpan K c h 2) = 2 :=
  hB.finrank_levelSpan_two hB1 (kac_level_two_pos hh hc).ne'

end Positivity

/-! ### The degenerate direction at `c = 1`, `h = 1/4` -/

section NullVector

variable {K : Type*} [Field K] [CharZero K] {c h : K}
variable {B : VermaModule K c h →ₗ[K] VermaModule K c h →ₗ[K] K}

/-- **The level-2 null direction at `c = 1`, `h = 1/4`.**  At the collision point
`h₁₂ = h₂₁ = 1/4` of the two level-2 Kac weights at `c = 1`, the whole level-2 Gram matrix is
the constant matrix `3/2`, so `(L₋₂ - L₋₁²)|c,h⟩` is orthogonal to all of `V₂`.

This is the general level-2 singular vector `(L₋₂ - 3/(2(2h+1)) L₋₁²)|c,h⟩` at `h = 1/4`, where
the coefficient `3/(2(2h+1))` equals `1`.  Two consequences worth recording:

* the vanishing of the Kac determinant at a Kac zero is a genuine degeneracy of the form, not
  an artefact of the unnormalised basis;
* the Gram criterion `linearIndependent_of_gram_det_ne_zero` cannot be reversed: `det = 0` does
  *not* say the vectors are dependent (by PBW they are independent for every `(c,h)`), only that
  the form degenerates on their span. -/
theorem IsContravariant.desc2_sub_desc11_orthogonal_levelSpan_two (hB : IsContravariant K c h B)
    (hB1 : B (hwv K c h) (hwv K c h) = 1) (hc : c = 1) (hh : h = 1 / 4)
    {x : VermaModule K c h} (hx : x ∈ levelSpan K c h 2) :
    B (desc2 K c h - desc11 K c h) x = 0 := by
  have hker : Submodule.span K (Set.range (descFamily2 K c h))
      ≤ LinearMap.ker (B (desc2 K c h - desc11 K c h)) := by
    rw [Submodule.span_le]
    rintro y ⟨i, rfl⟩
    have h2 : B (desc2 K c h - desc11 K c h) (desc2 K c h) = 0 := by
      rw [map_sub, LinearMap.sub_apply, hB.gram_level_two_aa hB1,
        hB.comm (desc11 K c h) (desc2 K c h), hB.gram_level_two_ab hB1]
      subst hc
      subst hh
      linear_combination (1 / 2 : K) * two_mul_centralTerm_two K
    have h11 : B (desc2 K c h - desc11 K c h) (desc11 K c h) = 0 := by
      rw [map_sub, LinearMap.sub_apply, hB.gram_level_two_ab hB1,
        hB.gram_level_two_bb hB1]
      subst hh
      norm_num
    fin_cases i
    · exact h2
    · exact h11
  exact hker (by rwa [← levelSpan_two_eq_span_descFamily2])

end NullVector

end Virasoro

end StringFormal
