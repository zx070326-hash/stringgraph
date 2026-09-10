/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

The design of this file (carrier `ℤ →₀ R`, bracket defined by bilinear extension from a
basis, reduction of the Jacobi identity to basis triples) follows Kalle Kytölä's
`VirasoroProject` (Apache-2.0, https://github.com/kkytola/VirasoroProject), see
`StringFormal/Virasoro/ATTRIBUTION.md`. The proofs here are written against Mathlib
`v4.33.1` and differ from the source in that antisymmetry of the bracket is built into the
definition, which removes the `CharZero` / `NoZeroSMulDivisors` hypotheses.
-/
import Mathlib.Algebra.Lie.Basic
import Mathlib.LinearAlgebra.Basis.Bilinear
import Mathlib.LinearAlgebra.Finsupp.VectorSpace

/-!
# The Witt algebra

Graph node: none of its own yet; used by `worldsheet.virasoro-algebra`.
Convention: `conv.virasoro-standard` (the Virasoro central term lives in
`StringFormal/Virasoro/Basic.lean`; here only `⁅ℓ m, ℓ n⁆ = (m - n) ℓ (m+n)`).

## Main definitions

* `StringFormal.Virasoro.WittAlgebra R`: the Witt algebra over a commutative ring `R`,
  with carrier `ℤ →₀ R`.
* `StringFormal.Virasoro.WittAlgebra.lgen`: the basis `{ℓ n : n ∈ ℤ}`.

## Main statements

* `StringFormal.Virasoro.WittAlgebra.instLieRing`, `instLieAlgebra`: `WittAlgebra R` is a
  Lie algebra over `R`, for **any** commutative ring `R`.
* `StringFormal.Virasoro.WittAlgebra.lie_lgen_lgen`: `⁅ℓ m, ℓ n⁆ = (m - n) • ℓ (m + n)`.

## Implementation notes

The bracket is defined as `A - Aᵀ` for the auxiliary bilinear map `A (ℓ m) (ℓ n) = m • ℓ (m+n)`.
Writing it this way makes `lie_self` literally `sub_self`, so no hypothesis on `R` beyond
`CommRing` is needed. (Deducing `⁅X, X⁆ = 0` from `⁅X, Y⁆ = -⁅Y, X⁆` would need `2` to be
cancellable, or a summation-by-pairs argument.)

## Status

Complete, no `sorry`.
-/

namespace StringFormal.Virasoro

open Module

variable (R : Type*) [CommRing R]

/-- The Witt algebra over `R`: the Lie algebra of "polynomial vector fields on the circle",
implemented as the free `R`-module on generators `ℓ n`, `n : ℤ`, with
`⁅ℓ m, ℓ n⁆ = (m - n) • ℓ (m + n)`. -/
def WittAlgebra : Type _ := ℤ →₀ R

namespace WittAlgebra

noncomputable instance : AddCommGroup (WittAlgebra R) := inferInstanceAs (AddCommGroup (ℤ →₀ R))

noncomputable instance : Module R (WittAlgebra R) := inferInstanceAs (Module R (ℤ →₀ R))

/-- The standard basis `{ℓ n : n ∈ ℤ}` of the Witt algebra. -/
noncomputable def lgen : Basis ℤ R (WittAlgebra R) :=
  Finsupp.basisSingleOne

/-- Auxiliary bilinear map with `bracketAux (ℓ m) (ℓ n) = m • ℓ (m + n)`. The Witt bracket is
its antisymmetrisation. -/
noncomputable def bracketAux : WittAlgebra R →ₗ[R] WittAlgebra R →ₗ[R] WittAlgebra R :=
  (lgen R).constr R fun n => (lgen R).constr R fun m => (n : R) • lgen R (n + m)

@[simp]
lemma bracketAux_lgen_lgen (n m : ℤ) :
    bracketAux R (lgen R n) (lgen R m) = (n : R) • lgen R (n + m) := by
  simp only [bracketAux, Basis.constr_basis]

/-- The Lie bracket of the Witt algebra, as a bilinear map. -/
noncomputable def bracket : WittAlgebra R →ₗ[R] WittAlgebra R →ₗ[R] WittAlgebra R :=
  bracketAux R - (bracketAux R).flip

lemma bracket_apply_apply (X Y : WittAlgebra R) :
    bracket R X Y = bracketAux R X Y - bracketAux R Y X := by
  simp only [bracket, LinearMap.sub_apply, LinearMap.flip_apply]

@[simp]
lemma bracket_lgen_lgen (n m : ℤ) :
    bracket R (lgen R n) (lgen R m) = ((n : R) - (m : R)) • lgen R (n + m) := by
  rw [bracket_apply_apply, bracketAux_lgen_lgen, bracketAux_lgen_lgen, add_comm m n, sub_smul]

lemma bracket_self (X : WittAlgebra R) : bracket R X X = 0 := by
  rw [bracket_apply_apply, sub_self]

lemma bracket_skew (X Y : WittAlgebra R) : bracket R X Y = - bracket R Y X := by
  rw [bracket_apply_apply, bracket_apply_apply, neg_sub]

/-- The failure of the Leibniz identity for the Witt bracket, bundled as a trilinear map so
that it can be checked on basis triples. -/
noncomputable def leibnizDefect :
    WittAlgebra R →ₗ[R] WittAlgebra R →ₗ[R] WittAlgebra R →ₗ[R] WittAlgebra R :=
  LinearMap.mk₂ R
    (fun X Y => (bracket R X) ∘ₗ (bracket R Y) - bracket R (bracket R X Y)
      - (bracket R Y) ∘ₗ (bracket R X))
    (fun X₁ X₂ Y => by
      ext Z
      simp only [LinearMap.sub_apply, LinearMap.comp_apply, LinearMap.add_apply, map_add]
      abel)
    (fun c X Y => by
      ext Z
      simp only [LinearMap.sub_apply, LinearMap.comp_apply, map_smul,
        LinearMap.smul_apply, smul_sub])
    (fun X Y₁ Y₂ => by
      ext Z
      simp only [LinearMap.sub_apply, LinearMap.comp_apply, LinearMap.add_apply, map_add]
      abel)
    (fun c X Y => by
      ext Z
      simp only [LinearMap.sub_apply, LinearMap.comp_apply, map_smul,
        LinearMap.smul_apply, smul_sub])

lemma leibnizDefect_apply (X Y Z : WittAlgebra R) :
    leibnizDefect R X Y Z = bracket R X (bracket R Y Z) - bracket R (bracket R X Y) Z
      - bracket R Y (bracket R X Z) := by
  simp only [leibnizDefect, LinearMap.mk₂_apply, LinearMap.sub_apply, LinearMap.comp_apply]

lemma leibnizDefect_eq_zero : leibnizDefect R = 0 := by
  apply LinearMap.ext_basis (lgen R) (lgen R)
  intro n m
  simp only [LinearMap.zero_apply]
  apply (lgen R).ext
  intro k
  rw [leibnizDefect_apply, LinearMap.zero_apply]
  simp only [bracket_lgen_lgen, map_smul, LinearMap.smul_apply, smul_smul]
  rw [show n + (m + k) = n + m + k by ring, show m + (n + k) = n + m + k by ring,
    ← sub_smul, ← sub_smul]
  convert zero_smul R (lgen R (n + m + k))
  push_cast
  ring

/-- The Witt algebra is a Lie ring, over an arbitrary commutative ring `R`. -/
noncomputable instance instLieRing : LieRing (WittAlgebra R) where
  bracket X Y := bracket R X Y
  add_lie X Y Z := by
    show bracket R (X + Y) Z = bracket R X Z + bracket R Y Z
    rw [map_add, LinearMap.add_apply]
  lie_add X Y Z := by
    show bracket R X (Y + Z) = bracket R X Y + bracket R X Z
    rw [map_add]
  lie_self X := bracket_self R X
  leibniz_lie X Y Z := by
    show bracket R X (bracket R Y Z)
      = bracket R (bracket R X Y) Z + bracket R Y (bracket R X Z)
    have h : bracket R X (bracket R Y Z) - bracket R (bracket R X Y) Z
        - bracket R Y (bracket R X Z) = 0 := by
      rw [← leibnizDefect_apply, leibnizDefect_eq_zero, LinearMap.zero_apply,
        LinearMap.zero_apply, LinearMap.zero_apply]
    rw [sub_sub, sub_eq_zero] at h
    exact h

/-- The Witt algebra is a Lie algebra over `R`. -/
noncomputable instance instLieAlgebra : LieAlgebra R (WittAlgebra R) where
  lie_smul c X Y := by
    show bracket R X (c • Y) = c • bracket R X Y
    rw [map_smul]

lemma lie_def (X Y : WittAlgebra R) : ⁅X, Y⁆ = bracket R X Y := rfl

/-- The defining relation of the Witt algebra: `⁅ℓ m, ℓ n⁆ = (m - n) • ℓ (m + n)`. -/
@[simp]
lemma lie_lgen_lgen (n m : ℤ) :
    ⁅lgen R n, lgen R m⁆ = ((n : R) - (m : R)) • lgen R (n + m) := by
  rw [lie_def, bracket_lgen_lgen]

end WittAlgebra

end StringFormal.Virasoro
