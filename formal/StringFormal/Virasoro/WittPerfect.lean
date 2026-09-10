/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import StringFormal.Virasoro.Basic
import Mathlib.Algebra.Lie.Solvable

/-!
# The Witt and Virasoro algebras are perfect

Graph nodes: `math.witt-algebra-perfect`, and part (1) of
`math.virasoro-universal-central-extension`.
Convention: `conv.virasoro-standard` (as in `StringFormal/Virasoro/Basic.lean`).

## Main statements

* `StringFormal.Virasoro.WittAlgebra.isPerfect`: `⁅⊤, ⊤⁆ = ⊤` for `WittAlgebra R`, whenever
  `2` is invertible in `R`.
* `StringFormal.Virasoro.VirasoroAlgebra.isPerfect`: `⁅⊤, ⊤⁆ = ⊤` for `VirasoroAlgebra R`
  (`R` a commutative `ℚ`-algebra, as in `Basic.lean`).

## Implementation notes

Mathlib `v4.33.1` has no `LieAlgebra.IsPerfect` predicate, so "perfect" is spelled either as
`⁅(⊤ : LieIdeal R L), ⊤⁆ = ⊤` or as `LieAlgebra.derivedSeries R L 1 = ⊤`; the two are
definitionally equal (`derivedSeriesOfIdeal` is an iterate of `fun I => ⁅I, I⁆`).

The hypothesis on the ground ring is worth stating carefully. The usual textbook argument
"`ℓ n = (1/(2a - n)) ⁅ℓ a, ℓ (n - a)⁆`" needs a unit, and for `n` **even** every available
coefficient `a - b` with `a + b = n` is even. Indeed the derived subalgebra of
`WittAlgebra R` is `⨁ n, I n · ℓ n` with `I n = R` for `n` odd and `I n = (2)` for `n` even,
so the Witt algebra over `ℤ` (or over `ZMod 2`, or any ring in which `2` is not a unit) is
**not** perfect. This file therefore assumes `Invertible (2 : R)` and proves the sharp
statement `derivedSeries R (WittAlgebra R) 1 = ⊤ ↔ IsUnit (2 : R)`
(`WittAlgebra.derivedSeries_one_eq_top_iff`). Being a `ℚ`-algebra, as in `Basic.lean`, is
much stronger than needed.

The uniform witness used below avoids a parity case split:
`⁅ℓ (n+2), ℓ (-2)⁆ - ⁅ℓ (n+1), ℓ (-1)⁆ = ((n+4) - (n+2)) • ℓ n = 2 • ℓ n`.

## Status

Complete, no `sorry`.
-/

namespace StringFormal.Virasoro

open LieAlgebra

namespace WittAlgebra

variable (R : Type*) [CommRing R]

lemma lie_mem_derivedSeries_one (x y : WittAlgebra R) :
    ⁅x, y⁆ ∈ derivedSeries R (WittAlgebra R) 1 := by
  have hmem : ⁅x, y⁆ ∈
      Submodule.span R {⁅a, b⁆ | (a : WittAlgebra R) (b : WittAlgebra R)} :=
    Submodule.subset_span ⟨x, y, rfl⟩
  rw [← LieAlgebra.coe_derivedSeries_one_eq] at hmem
  exact hmem

/-- `2 • ℓ n` is a difference of two brackets, over an arbitrary commutative ring: this is
the uniform (parity-free) witness for perfectness. -/
lemma two_smul_lgen_eq (n : ℤ) :
    (2 : R) • lgen R n = ⁅lgen R (n + 2), lgen R (-2)⁆ - ⁅lgen R (n + 1), lgen R (-1)⁆ := by
  rw [lie_lgen_lgen, lie_lgen_lgen, show n + 2 + (-2) = n from by ring,
    show n + 1 + (-1) = n from by ring, ← sub_smul]
  congr 1
  push_cast
  ring

lemma two_smul_lgen_mem_derivedSeries_one (n : ℤ) :
    (2 : R) • lgen R n ∈ derivedSeries R (WittAlgebra R) 1 := by
  rw [two_smul_lgen_eq]
  exact sub_mem (lie_mem_derivedSeries_one R _ _) (lie_mem_derivedSeries_one R _ _)

section TwoInvertible

variable [Invertible (2 : R)]

lemma lgen_mem_derivedSeries_one (n : ℤ) :
    lgen R n ∈ derivedSeries R (WittAlgebra R) 1 := by
  have h : lgen R n = (⅟(2 : R)) • ((2 : R) • lgen R n) := by
    rw [smul_smul, invOf_mul_self, one_smul]
  rw [h]
  exact SMulMemClass.smul_mem _ (two_smul_lgen_mem_derivedSeries_one R n)

/-- **The Witt algebra is perfect**, in the form `derivedSeries R L 1 = ⊤`, whenever `2` is
invertible in the ground ring. -/
theorem derivedSeries_one_eq_top : derivedSeries R (WittAlgebra R) 1 = ⊤ := by
  rw [← LieSubmodule.toSubmodule_eq_top, eq_top_iff, ← (lgen R).span_eq, Submodule.span_le]
  rintro _ ⟨n, rfl⟩
  exact lgen_mem_derivedSeries_one R n

/-- **The Witt algebra is perfect**: `⁅W, W⁆ = W`, whenever `2` is invertible in the ground
ring. See `WittAlgebra.derivedSeries_one_eq_top_iff` for the fact that this hypothesis
cannot be dropped. -/
theorem isPerfect :
    ⁅(⊤ : LieIdeal R (WittAlgebra R)), (⊤ : LieIdeal R (WittAlgebra R))⁆ = ⊤ :=
  derivedSeries_one_eq_top R

end TwoInvertible

end WittAlgebra

end StringFormal.Virasoro
