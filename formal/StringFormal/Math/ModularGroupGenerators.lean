/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import Mathlib.LinearAlgebra.Matrix.FixedDetMatrices
import Mathlib.LinearAlgebra.Matrix.ProjectiveSpecialLinearGroup

/-!
# `S` and `T` generate the modular group, and satisfy `S² = (ST)³ = 1` in `PSL(2,ℤ)`

Graph node: `worldsheet.modular-group-generated-by-s-and-t`
(*(1) `S : τ ↦ −1/τ` and `T : τ ↦ τ + 1` generate `PSL(2,ℤ)`; (2) `S² = 1` and `(ST)³ = 1` as
elements of `PSL(2,ℤ)`, i.e. up to `±I`.*  The node explicitly does **not** claim that these are a
*presentation*.)

## What comes from Mathlib and what is proved here

Mathlib `v4.33.1` provides the hard half, at the level of `SL(2,ℤ)`:

```
SpecialLinearGroup.SL2Z_generators : Subgroup.closure {ModularGroup.S, ModularGroup.T} = ⊤
```

(`Mathlib/LinearAlgebra/Matrix/FixedDetMatrices.lean`, Chris Birkbeck, by a Euclidean reduction
`FixedDetMatrices.induction_on`), together with `ModularGroup.S_mul_S_eq : (S : Matrix _ _ ℤ) * S
= -1`.  What this file adds is (a) the relation `(ST)³ = −1` in `SL(2,ℤ)`, (b) the passage from
`SL(2,ℤ)` to `PSL(2,ℤ) = SL(2,ℤ)/Z`, where `−1` dies and the two relations become `S² = 1`,
`(ST)³ = 1`, and (c) the transport of the generation statement along the quotient map.

## Main results

`SL(2,ℤ)` level:

* `sl_S_sq` : `S ^ 2 = -1`.
* `sl_ST_cube` : `(S * T) ^ 3 = -1`.
* `sl_closure_S_T` : `Subgroup.closure {S, T} = ⊤` (re-export of Mathlib's `SL2Z_generators`).
* `neg_one_mem_center` : `(-1 : SL(2,ℤ))` is central.

`PSL(2,ℤ)` level (`psl := QuotientGroup.mk'` onto `SL(2,ℤ) ⧸ center`):

* `psl_neg_one` : the image of `−1` is trivial.
* `psl_S_sq` : `(psl S) ^ 2 = 1` — part (2), first relation.
* `psl_ST_cube` : `(psl S * psl T) ^ 3 = 1` — part (2), second relation.
* `psl_closure_S_T` : `Subgroup.closure {psl S, psl T} = ⊤` — part (1).

## Scope remarks (these are the caveats to carry into the graph card)

* **No presentation claim.**  Nothing here says that `S² , (ST)³` generate *all* relations, i.e.
  that `PSL(2,ℤ) ≅ ℤ/2 ∗ ℤ/3`.  That is a strictly stronger statement (it needs, e.g., the
  ping-pong lemma on the fundamental domain) and is *not* in Mathlib `v4.33.1` either.  The graph
  card is careful to disclaim it too, so card and Lean agree.
* **`PSL` means `SL/Z(SL)` here**, Mathlib's `Matrix.ProjectiveSpecialLinearGroup`.  This file does
  **not** prove `Z(SL(2,ℤ)) = {±1}` (true, but unused): only `−1 ∈ Z` is needed, and that is all
  that the relations require.  Consequently `psl_S_sq` and `psl_ST_cube` are slightly *weaker* than
  "`S² = ±I` in `SL(2,ℤ)`" would be if one insisted on the precise center; they are exactly the
  statements "the relation holds modulo the center", which is what the physics card asserts.
* **Nothing here is about the action on `ℍ`.**  The identification of `S`, `T` with `τ ↦ −1/τ`,
  `τ ↦ τ + 1` is Mathlib's `UpperHalfPlane.modular_S_smul` / `modular_T_smul`, used in
  `StringFormal/Math/DedekindEtaModular.lean`.
-/

namespace StringFormal.ModularGroupGen

open scoped MatrixGroups
open ModularGroup Matrix

/-! ### Relations and generation inside `SL(2,ℤ)` -/

/-- `S² = −1` in `SL(2,ℤ)`.  (Mathlib has this at the level of the underlying matrices.) -/
theorem sl_S_sq : S ^ 2 = (-1 : SL(2, ℤ)) := by
  ext i j
  fin_cases i <;> fin_cases j <;> rfl

/-- `(ST)³ = −1` in `SL(2,ℤ)`. -/
theorem sl_ST_cube : (S * T) ^ 3 = (-1 : SL(2, ℤ)) := by
  ext i j
  fin_cases i <;> fin_cases j <;> rfl

/-- **`S` and `T` generate `SL(2,ℤ)`** — re-export of Mathlib's
`SpecialLinearGroup.SL2Z_generators`. -/
theorem sl_closure_S_T : Subgroup.closure ({S, T} : Set SL(2, ℤ)) = ⊤ :=
  SpecialLinearGroup.SL2Z_generators

/-- `−1` is central in `SL(2,ℤ)`; this is why the relations `S² = (ST)³ = −1` become
`S² = (ST)³ = 1` in `PSL(2,ℤ)`. -/
theorem neg_one_mem_center : (-1 : SL(2, ℤ)) ∈ Subgroup.center SL(2, ℤ) := by
  rw [Subgroup.mem_center_iff]
  intro g
  rw [mul_neg, neg_mul, mul_one, one_mul]

/-! ### The same statements in `PSL(2,ℤ) = SL(2,ℤ) / Z(SL(2,ℤ))` -/

/-- The quotient map `SL(2,ℤ) → PSL(2,ℤ)`. -/
abbrev psl : SL(2, ℤ) →* PSL(2, ℤ) := QuotientGroup.mk' (Subgroup.center SL(2, ℤ))

/-- `−1` becomes trivial in `PSL(2,ℤ)`. -/
@[simp]
theorem psl_neg_one : psl (-1 : SL(2, ℤ)) = 1 :=
  (QuotientGroup.eq_one_iff _).mpr neg_one_mem_center

/-- **`S² = 1` in `PSL(2,ℤ)`** — part (2) of `worldsheet.modular-group-generated-by-s-and-t`. -/
theorem psl_S_sq : (psl S) ^ 2 = 1 := by
  rw [← map_pow, sl_S_sq, psl_neg_one]

/-- **`(ST)³ = 1` in `PSL(2,ℤ)`** — part (2) of
`worldsheet.modular-group-generated-by-s-and-t`. -/
theorem psl_ST_cube : (psl S * psl T) ^ 3 = 1 := by
  rw [← map_mul, ← map_pow, sl_ST_cube, psl_neg_one]

/-- **`S` and `T` generate `PSL(2,ℤ)`** — part (1) of
`worldsheet.modular-group-generated-by-s-and-t`.  Transported from `SL(2,ℤ)` along the (surjective)
quotient map. -/
theorem psl_closure_S_T : Subgroup.closure ({psl S, psl T} : Set PSL(2, ℤ)) = ⊤ := by
  have hsurj : Function.Surjective (psl : SL(2, ℤ) → PSL(2, ℤ)) :=
    QuotientGroup.mk'_surjective _
  have h : Subgroup.map psl (Subgroup.closure ({S, T} : Set SL(2, ℤ)))
      = Subgroup.closure ({psl S, psl T} : Set PSL(2, ℤ)) := by
    rw [MonoidHom.map_closure, Set.image_pair]
  rw [← h, sl_closure_S_T, ← MonoidHom.range_eq_map, MonoidHom.range_eq_top]
  exact hsurj

end StringFormal.ModularGroupGen
