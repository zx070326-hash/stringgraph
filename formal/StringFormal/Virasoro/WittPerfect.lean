/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import StringFormal.Virasoro.Verma
import Mathlib.Algebra.Lie.Solvable
import Mathlib.Data.ZMod.Basic

/-!
# The Witt and Virasoro algebras are perfect

Graph nodes: `math.witt-algebra-perfect`, and part (1) of
`math.virasoro-universal-central-extension`.
Convention: `conv.virasoro-standard` (as in `StringFormal/Virasoro/Basic.lean`).

## Main statements

* `StringFormal.Virasoro.WittAlgebra.isPerfect`: `⁅⊤, ⊤⁆ = ⊤` for `WittAlgebra R`, whenever
  `2` is invertible in `R`.
* `StringFormal.Virasoro.WittAlgebra.derivedSeries_one_eq_top_iff`: the sharp form,
  `⁅⊤, ⊤⁆ = ⊤ ↔ IsUnit (2 : R)`, together with the counterexample
  `WittAlgebra.derivedSeries_one_ne_top_zmod_two`.
* `StringFormal.Virasoro.VirasoroAlgebra.isPerfect`: `⁅⊤, ⊤⁆ = ⊤` for `VirasoroAlgebra R`
  (`R` a commutative `ℚ`-algebra, as in `Basic.lean`); in particular the central element `C`
  itself is a bracket combination (`VirasoroAlgebra.cgen_eq`), which is the part of
  `math.virasoro-universal-central-extension` that says the extension is not split off by a
  direct summand.

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
The same witness works in the Virasoro algebra for `n ≠ 0` (no central term, since the mode
numbers do not add to zero); `L 0` comes from `⁅L 1, L (-1)⁆ = 2 L 0` (the central term
`(1³ - 1)/12` vanishes) and `C` from `2⁅L 2, L (-2)⁆ - 4⁅L 1, L (-1)⁆`.

This file imports `Virasoro/Verma.lean` only for `VirasoroAlgebra.span_lgen_cgen_eq_top`
(and `ofWitt`), which are `Basic.lean`-level facts that happen to live in `Verma.lean`;
moving them to `Basic.lean` would remove this import.

## Status

Complete, no `sorry`.
-/

namespace StringFormal.Virasoro

open LieAlgebra Module

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

/-! ### Sharpness: `2` must be invertible

Every bracket has an even `ℓ 0`-coefficient, so `ℓ 0` itself is in the derived subalgebra
only when `2` is a unit. -/

/-- The `ℓ 0`-coefficient of any bracket lies in the ideal `(2)`: on basis vectors,
`⁅ℓ a, ℓ b⁆` contributes to `ℓ 0` only when `b = -a`, with coefficient `a - b = 2a`. -/
lemma coord_zero_lie_mem_span_two (x y : WittAlgebra R) :
    (lgen R).coord 0 ⁅x, y⁆ ∈ Ideal.span {(2 : R)} := by
  have hcoord : ∀ k : ℤ, (lgen R).coord 0 (lgen R k) = if k = 0 then 1 else 0 := by
    intro k
    rw [Basis.coord_apply, Basis.repr_self, Finsupp.single_apply]
  have h1 : ∀ a b : ℤ, (lgen R).coord 0 ⁅lgen R a, lgen R b⁆ ∈ Ideal.span {(2 : R)} := by
    intro a b
    rw [lie_lgen_lgen, map_smul, smul_eq_mul, hcoord]
    by_cases hab : a + b = 0
    · rw [if_pos hab, mul_one, show b = -a from by omega]
      refine Ideal.mem_span_singleton.mpr ⟨(a : R), ?_⟩
      push_cast
      ring
    · rw [if_neg hab, mul_zero]
      exact Submodule.zero_mem _
  have h2 : ∀ (a : ℤ) (z : WittAlgebra R),
      (lgen R).coord 0 ⁅lgen R a, z⁆ ∈ Ideal.span {(2 : R)} := by
    intro a z
    have hle : Submodule.span R (Set.range (lgen R))
        ≤ Submodule.comap (((lgen R).coord 0).comp (bracket R (lgen R a)))
            (Ideal.span {(2 : R)}) := by
      rw [Submodule.span_le]
      rintro _ ⟨b, rfl⟩
      exact h1 a b
    exact hle (by rw [(lgen R).span_eq]; trivial)
  have hle : Submodule.span R (Set.range (lgen R))
      ≤ Submodule.comap (((lgen R).coord 0).comp ((bracket R).flip y))
          (Ideal.span {(2 : R)}) := by
    rw [Submodule.span_le]
    rintro _ ⟨a, rfl⟩
    exact h2 a y
  exact hle (by rw [(lgen R).span_eq]; trivial)

/-- **Sharp form**: the Witt algebra over `R` is perfect **iff** `2` is a unit of `R`. -/
theorem derivedSeries_one_eq_top_iff :
    derivedSeries R (WittAlgebra R) 1 = ⊤ ↔ IsUnit (2 : R) := by
  constructor
  · intro h
    have h0 : lgen R 0 ∈ Submodule.span R
        {⁅a, b⁆ | (a : WittAlgebra R) (b : WittAlgebra R)} := by
      rw [← LieAlgebra.coe_derivedSeries_one_eq, h]
      trivial
    have hle : Submodule.span R {⁅a, b⁆ | (a : WittAlgebra R) (b : WittAlgebra R)}
        ≤ Submodule.comap ((lgen R).coord 0) (Ideal.span {(2 : R)}) := by
      rw [Submodule.span_le]
      rintro _ ⟨a, b, rfl⟩
      exact coord_zero_lie_mem_span_two R a b
    have h1 : (lgen R).coord 0 (lgen R 0) ∈ Ideal.span {(2 : R)} := hle h0
    rw [Basis.coord_apply, Basis.repr_self, Finsupp.single_apply, if_pos rfl] at h1
    exact isUnit_of_dvd_one (Ideal.mem_span_singleton.mp h1)
  · intro h
    obtain ⟨_i⟩ := h.nonempty_invertible
    exact derivedSeries_one_eq_top R

/-- A concrete counterexample: over `ZMod 2` the Witt algebra is **not** perfect (only
`2 ℓ n = 0`, not `ℓ n`, is a combination of brackets). The same holds over `ℤ`. -/
theorem derivedSeries_one_ne_top_zmod_two :
    derivedSeries (ZMod 2) (WittAlgebra (ZMod 2)) 1 ≠ ⊤ := by
  intro h
  rw [derivedSeries_one_eq_top_iff, show (2 : ZMod 2) = 0 by decide] at h
  exact absurd (isUnit_zero_iff.mp h) (by decide)

end WittAlgebra

/-- In a commutative `ℚ`-algebra, `2` is invertible. Kept as a `def` (not an `instance`) to
avoid creating `Invertible` diamonds downstream; use it with `letI`. -/
@[instance_reducible]
noncomputable def invertibleTwo (R : Type*) [CommRing R] [Algebra ℚ R] :
    Invertible (2 : R) where
  invOf := algebraMap ℚ R (1 / 2)
  invOf_mul_self := by
    rw [← map_ofNat (algebraMap ℚ R) 2, ← map_mul, show (1 / 2 : ℚ) * 2 = 1 by norm_num, map_one]
  mul_invOf_self := by
    rw [← map_ofNat (algebraMap ℚ R) 2, ← map_mul, show (2 : ℚ) * (1 / 2) = 1 by norm_num,
      map_one]

namespace VirasoroAlgebra

variable (R : Type*) [CommRing R] [Algebra ℚ R]

lemma lie_mem_derivedSeries_one (x y : VirasoroAlgebra R) :
    ⁅x, y⁆ ∈ derivedSeries R (VirasoroAlgebra R) 1 := by
  have hmem : ⁅x, y⁆ ∈
      Submodule.span R {⁅a, b⁆ | (a : VirasoroAlgebra R) (b : VirasoroAlgebra R)} :=
    Submodule.subset_span ⟨x, y, rfl⟩
  rw [← LieAlgebra.coe_derivedSeries_one_eq] at hmem
  exact hmem

/-- `2 • L n = ⁅L (n+2), L (-2)⁆ - ⁅L (n+1), L (-1)⁆` for `n ≠ 0`; both brackets have
vanishing central term because the mode numbers do not add to zero. -/
lemma two_smul_lgen_eq {n : ℤ} (hn : n ≠ 0) :
    (2 : R) • lgen R n = ⁅lgen R (n + 2), lgen R (-2)⁆ - ⁅lgen R (n + 1), lgen R (-1)⁆ := by
  rw [lie_lgen_lgen, lie_lgen_lgen, show n + 2 + (-2) = n from by ring,
    show n + 1 + (-1) = n from by ring]
  simp only [if_neg hn, zero_smul, add_zero, ← sub_smul]
  congr 1
  push_cast
  ring

/-- `2 • L 0 = ⁅L 1, L (-1)⁆`: the central term `(1³ - 1)/12` vanishes. -/
lemma two_smul_lgen_zero_eq : (2 : R) • lgen R 0 = ⁅lgen R 1, lgen R (-1)⁆ := by
  have hc : centralTerm R 1 = 0 := by
    rw [centralTerm]
    norm_num
  rw [lie_lgen_lgen, show (1 : ℤ) + (-1) = 0 from by ring, if_pos rfl, hc, zero_smul, add_zero]
  congr 1
  push_cast
  ring

/-- The central element is a combination of brackets:
`C = 2 • ⁅L 2, L (-2)⁆ - 4 • ⁅L 1, L (-1)⁆`, using `⁅L 2, L (-2)⁆ = 4 L 0 + C/2` and
`⁅L 1, L (-1)⁆ = 2 L 0`. -/
lemma cgen_eq :
    cgen R = (2 : R) • ⁅lgen R 2, lgen R (-2)⁆ - (4 : R) • ⁅lgen R 1, lgen R (-1)⁆ := by
  have hc1 : centralTerm R 1 = 0 := by
    rw [centralTerm]
    norm_num
  have hc2 : (2 : R) * centralTerm R 2 = 1 := by
    rw [centralTerm, show ((2 ^ 3 - 2 : ℤ) : R) = (6 : R) by norm_num,
      show (2 : R) * (inv12 R * 6) = 12 * inv12 R by ring, twelve_mul_inv12]
  rw [lie_lgen_lgen, lie_lgen_lgen, show (2 : ℤ) + (-2) = 0 from by ring,
    show (1 : ℤ) + (-1) = 0 from by ring, if_pos rfl, if_pos rfl]
  simp only [smul_add, smul_smul, hc1, hc2, zero_smul, add_zero, one_smul]
  rw [show (2 : R) * (((2 : ℤ) : R) - ((-2 : ℤ) : R))
      = (4 : R) * (((1 : ℤ) : R) - ((-1 : ℤ) : R)) by push_cast; ring]
  abel

lemma lgen_mem_derivedSeries_one (n : ℤ) :
    lgen R n ∈ derivedSeries R (VirasoroAlgebra R) 1 := by
  obtain ⟨u, hu, -⟩ := invertibleTwo R
  have h2 : (2 : R) • lgen R n ∈ derivedSeries R (VirasoroAlgebra R) 1 := by
    rcases eq_or_ne n 0 with rfl | hn
    · rw [two_smul_lgen_zero_eq]
      exact lie_mem_derivedSeries_one R _ _
    · rw [two_smul_lgen_eq R hn]
      exact sub_mem (lie_mem_derivedSeries_one R _ _) (lie_mem_derivedSeries_one R _ _)
  have h : lgen R n = u • ((2 : R) • lgen R n) := by
    rw [smul_smul, hu, one_smul]
  rw [h]
  exact SMulMemClass.smul_mem _ h2

lemma cgen_mem_derivedSeries_one : cgen R ∈ derivedSeries R (VirasoroAlgebra R) 1 := by
  rw [cgen_eq]
  exact sub_mem (SMulMemClass.smul_mem _ (lie_mem_derivedSeries_one R _ _))
    (SMulMemClass.smul_mem _ (lie_mem_derivedSeries_one R _ _))

/-- **The Virasoro algebra is perfect**, in the form `derivedSeries R L 1 = ⊤`. -/
theorem derivedSeries_one_eq_top : derivedSeries R (VirasoroAlgebra R) 1 = ⊤ := by
  rw [← LieSubmodule.toSubmodule_eq_top, eq_top_iff, ← span_lgen_cgen_eq_top R,
    Submodule.span_le]
  rintro x (rfl | ⟨n, rfl⟩)
  · exact cgen_mem_derivedSeries_one R
  · exact lgen_mem_derivedSeries_one R n

/-- **The Virasoro algebra is perfect**: `⁅Vir, Vir⁆ = Vir`. Part (1) of
`math.virasoro-universal-central-extension`: in particular the central element `C` itself
is a bracket combination, `C = 2⁅L 2, L (-2)⁆ - 4⁅L 1, L (-1)⁆`. -/
theorem isPerfect :
    ⁅(⊤ : LieIdeal R (VirasoroAlgebra R)), (⊤ : LieIdeal R (VirasoroAlgebra R))⁆ = ⊤ :=
  derivedSeries_one_eq_top R

end VirasoroAlgebra

end StringFormal.Virasoro
