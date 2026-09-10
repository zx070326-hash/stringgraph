/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import Mathlib.Combinatorics.Enumerative.Partition.Glaisher
import Mathlib.RingTheory.PowerSeries.Inverse

/-!
# Euler's partition generating function

Suggested graph node: `math.euler-partition-generating-function` (a pure-mathematics
prerequisite; no string-theory convention enters).  It is used implicitly by the Verma-module
character `ch V(c,h) = q^h ∏_{n≥1}(1-q^n)^{-1}` and hence by
`worldsheet.no-ghost-theorem-subcritical--via-lian-zuckerman`.

## Statement

In the ring `R⟦X⟧` of formal power series (`X` plays the role of the physicists' `q`),

  `Σ_{N ≥ 0} p(N) X^N  =  ∏_{n ≥ 1} (1 - X^n)⁻¹`,

where `p(N)` is the number of partitions of `N`.  We write `p(N)` as
`Fintype.card (Nat.Partition N)`, matching `StringFormal/Virasoro/VermaPBW.lean`
(`finrank_levelSpan_le_card_partition : dim V_N ≤ p(N)`).

The infinite product is the one for the coefficientwise (product) topology on `R⟦X⟧`, which is
Mathlib's `PowerSeries.WithPiTopology`.  Since the right-hand side involves an inverse, the
identity is stated in several equivalent ways, in decreasing order of generality:

* `partitionGF_mul_tprod_one_sub_X_pow` : over any commutative ring,
  `(Σ p(N) X^N) · ∏_{n≥1}(1 - X^n) = 1`.  This is the inverse-free form and needs no
  hypotheses on `R` beyond `CommRing` (plus a topology to make `∏'` meaningful).
* `partitionGF_eq_invOfUnit` : over any commutative ring, `Σ p(N) X^N` is *the* inverse
  (`PowerSeries.invOfUnit`) of `∏_{n≥1}(1 - X^n)`.
* `partitionGF_eq` : over a field, `Σ p(N) X^N = (∏_{n≥1}(1 - X^n))⁻¹`.
* `partitionGF_eq_tprod_inv` : over a field, `Σ p(N) X^N = ∏_{n≥1} (1 - X^n)⁻¹`, i.e. with the
  inverse taken factor by factor — the literal form of the physicists' formula.

`coeff_partitionGF_mul_prod_one_sub_X_pow_eventually_eq` restates the first of these with no
topology at all: the coefficients of `(Σ p(N) X^N) · ∏_{n ∈ s}(1 - X^{n+1})` are eventually
constant in the finite set `s`, with value the coefficients of `1`.

## What is *not* here

Nothing about the asymptotics of `p(N)` (Hardy–Ramanujan), nothing about `η`-function
modularity, and no connection to the Verma module (`Math/` is a standalone island and does not
import `Virasoro/`).

## Provenance

Everything hard is Mathlib's: `Nat.Partition.hasProd_powerSeriesMk_card_restricted`
(`Mathlib/Combinatorics/Enumerative/Partition/Glaisher.lean`), itself a specialisation of
`Nat.Partition.hasProd_genFun` (`Mathlib/Combinatorics/Enumerative/Partition/GenFun.lean`),
whose module docstring lists the `f = 1` specialisation proved below as a TODO.  What this file
adds is that specialisation together with the passage from the geometric series
`∑_j X^{nj}` to the inverse `(1 - X^n)⁻¹`.
-/

noncomputable section

namespace StringFormal.Math

open Finset PowerSeries
open scoped PowerSeries.WithPiTopology

/-- The partition generating function `Σ_{N ≥ 0} p(N) X^N ∈ R⟦X⟧`, where `p(N)` is the number
of partitions of `N`. -/
def partitionGF (R : Type*) [CommSemiring R] : PowerSeries R :=
  PowerSeries.mk fun N ↦ (Fintype.card (Nat.Partition N) : R)

section Semiring

variable (R : Type*) [CommSemiring R]

@[simp]
theorem coeff_partitionGF (N : ℕ) :
    coeff N (partitionGF R) = (Fintype.card (Nat.Partition N) : R) :=
  PowerSeries.coeff_mk _ _

@[simp]
theorem constantCoeff_partitionGF : constantCoeff (partitionGF R) = (1 : R) := by
  rw [← coeff_zero_eq_constantCoeff_apply, coeff_partitionGF]
  simp

variable [TopologicalSpace R] [T2Space R] [IsTopologicalSemiring R]

/-- **Euler's product formula**, geometric-series form: `Σ_N p(N) X^N = ∏_{n ≥ 1} Σ_j X^{nj}`.

This is the `f = 1` specialisation of `Nat.Partition.hasProd_genFun`, listed as a TODO in the
Mathlib module docstring of `Combinatorics/Enumerative/Partition/GenFun.lean`. -/
theorem hasProd_partitionGF :
    HasProd (fun n : ℕ ↦ ∑' j : ℕ, (X : PowerSeries R) ^ ((n + 1) * j)) (partitionGF R) := by
  have h := Nat.Partition.hasProd_powerSeriesMk_card_restricted R (fun _ : ℕ ↦ True)
  simpa [partitionGF, Nat.Partition.restricted] using h

theorem multipliable_geomSeries :
    Multipliable fun n : ℕ ↦ ∑' j : ℕ, (X : PowerSeries R) ^ ((n + 1) * j) :=
  (hasProd_partitionGF R).multipliable

theorem partitionGF_eq_tprod_geomSeries :
    partitionGF R = ∏' n : ℕ, ∑' j : ℕ, (X : PowerSeries R) ^ ((n + 1) * j) :=
  (hasProd_partitionGF R).tprod_eq.symm

end Semiring

section Ring

variable (R : Type*) [CommRing R] [TopologicalSpace R] [T2Space R] [IsTopologicalRing R]

/-- Each Euler factor `1 - X^{n+1}` is inverted by the geometric series `Σ_j X^{(n+1)j}`. -/
theorem one_sub_X_pow_mul_geomSeries (n : ℕ) :
    (1 - X ^ (n + 1) : PowerSeries R) * ∑' j : ℕ, (X : PowerSeries R) ^ ((n + 1) * j) = 1 := by
  have hpow : ∀ j : ℕ, (X : PowerSeries R) ^ ((n + 1) * j) = ((X : PowerSeries R) ^ (n + 1)) ^ j :=
    fun j ↦ pow_mul X (n + 1) j
  simp_rw [hpow]
  exact PowerSeries.WithPiTopology.one_sub_mul_tsum_pow_of_constantCoeff_eq_zero (by simp)

/-- **Euler's product formula**, inverse-free form:
`(Σ_{N ≥ 0} p(N) X^N) · ∏_{n ≥ 1} (1 - X^n) = 1`. -/
theorem partitionGF_mul_tprod_one_sub_X_pow :
    partitionGF R * ∏' n : ℕ, (1 - X ^ (n + 1) : PowerSeries R) = 1 := by
  rw [partitionGF_eq_tprod_geomSeries, ← (multipliable_geomSeries R).tprod_mul
    (PowerSeries.WithPiTopology.multipliable_one_sub_X_pow R)]
  calc ∏' n : ℕ, ((∑' j : ℕ, (X : PowerSeries R) ^ ((n + 1) * j)) * (1 - X ^ (n + 1)))
      = ∏' _ : ℕ, (1 : PowerSeries R) := by
        refine tprod_congr fun n ↦ ?_
        rw [mul_comm, one_sub_X_pow_mul_geomSeries]
    _ = 1 := tprod_one

theorem tprod_one_sub_X_pow_mul_partitionGF :
    (∏' n : ℕ, (1 - X ^ (n + 1) : PowerSeries R)) * partitionGF R = 1 := by
  rw [mul_comm]; exact partitionGF_mul_tprod_one_sub_X_pow R

theorem isUnit_tprod_one_sub_X_pow :
    IsUnit (∏' n : ℕ, (1 - X ^ (n + 1) : PowerSeries R)) :=
  ⟨⟨_, partitionGF R, tprod_one_sub_X_pow_mul_partitionGF R,
      partitionGF_mul_tprod_one_sub_X_pow R⟩, rfl⟩

@[simp]
theorem constantCoeff_tprod_one_sub_X_pow :
    constantCoeff (∏' n : ℕ, (1 - X ^ (n + 1) : PowerSeries R)) = 1 := by
  have h := congrArg constantCoeff (tprod_one_sub_X_pow_mul_partitionGF R)
  simpa using h

/-- **Euler's product formula** over an arbitrary commutative ring: `Σ_N p(N) X^N` is the
inverse (`PowerSeries.invOfUnit`, the inverse of a power series with unit constant term) of
`∏_{n ≥ 1} (1 - X^n)`. -/
theorem partitionGF_eq_invOfUnit :
    partitionGF R
      = PowerSeries.invOfUnit (∏' n : ℕ, (1 - X ^ (n + 1) : PowerSeries R)) 1 := by
  have hc : constantCoeff (∏' n : ℕ, (1 - X ^ (n + 1) : PowerSeries R)) = ((1 : Rˣ) : R) := by
    simp
  have hinv := PowerSeries.mul_invOfUnit
    (∏' n : ℕ, (1 - X ^ (n + 1) : PowerSeries R)) 1 hc
  calc partitionGF R
      = partitionGF R * ((∏' n : ℕ, (1 - X ^ (n + 1) : PowerSeries R)) *
          PowerSeries.invOfUnit (∏' n : ℕ, (1 - X ^ (n + 1) : PowerSeries R)) 1) := by
        rw [hinv, mul_one]
    _ = (partitionGF R * ∏' n : ℕ, (1 - X ^ (n + 1) : PowerSeries R)) *
          PowerSeries.invOfUnit (∏' n : ℕ, (1 - X ^ (n + 1) : PowerSeries R)) 1 := by
        rw [mul_assoc]
    _ = PowerSeries.invOfUnit (∏' n : ℕ, (1 - X ^ (n + 1) : PowerSeries R)) 1 := by
        rw [partitionGF_mul_tprod_one_sub_X_pow, one_mul]

end Ring

/-- **Euler's product formula**, topology-free form: the coefficients of
`(Σ_N p(N) X^N) · ∏_{n ∈ s} (1 - X^{n+1})` are eventually (in the finite set `s`) those of `1`.

Compare `PowerSeries.coeff_prod_one_sub_X_pow_eventually_eq`, the analogous topology-free form
of the pentagonal number theorem in Mathlib. -/
theorem coeff_partitionGF_mul_prod_one_sub_X_pow_eventually_eq
    (S : Type*) [CommRing S] (N : ℕ) :
    ∀ᶠ s : Finset ℕ in Filter.atTop,
      coeff N (partitionGF S * ∏ n ∈ s, (1 - X ^ (n + 1) : PowerSeries S))
        = if N = 0 then 1 else 0 := by
  let _ : TopologicalSpace S := ⊥
  have _ : DiscreteTopology S := ⟨rfl⟩
  have hprod : Filter.Tendsto
      (fun s : Finset ℕ ↦ ∏ n ∈ s, (1 - X ^ (n + 1) : PowerSeries S)) Filter.atTop
      (nhds (∏' n : ℕ, (1 - X ^ (n + 1) : PowerSeries S))) :=
    (PowerSeries.WithPiTopology.multipliable_one_sub_X_pow S).hasProd
  have hmul := hprod.const_mul (partitionGF S)
  rw [partitionGF_mul_tprod_one_sub_X_pow] at hmul
  have hcoeff := ((PowerSeries.WithPiTopology.continuous_coeff S N).tendsto _).comp hmul
  simpa [Function.comp_def, PowerSeries.coeff_one] using hcoeff

section Field

variable (K : Type*) [Field K] [TopologicalSpace K] [T2Space K] [IsTopologicalRing K]

/-- **Euler's partition generating function** over a field:
`Σ_{N ≥ 0} p(N) X^N = (∏_{n ≥ 1} (1 - X^n))⁻¹`. -/
theorem partitionGF_eq :
    partitionGF K = (∏' n : ℕ, (1 - X ^ (n + 1) : PowerSeries K))⁻¹ :=
  (PowerSeries.eq_inv_iff_mul_eq_one (by simp)).mpr (partitionGF_mul_tprod_one_sub_X_pow K)

theorem inv_one_sub_X_pow (n : ℕ) :
    ((1 - X ^ (n + 1) : PowerSeries K))⁻¹ = ∑' j : ℕ, (X : PowerSeries K) ^ ((n + 1) * j) := by
  refine (PowerSeries.inv_eq_iff_mul_eq_one ?_).mpr ?_
  · simp
  · rw [mul_comm]; exact one_sub_X_pow_mul_geomSeries K n

/-- **Euler's partition generating function**, in the physicists' shape:
`Σ_{N ≥ 0} p(N) q^N = ∏_{n ≥ 1} (1 - q^n)^{-1}`, with the inverse taken factor by factor. -/
theorem partitionGF_eq_tprod_inv :
    partitionGF K = ∏' n : ℕ, ((1 - X ^ (n + 1) : PowerSeries K))⁻¹ := by
  simp_rw [inv_one_sub_X_pow]
  exact partitionGF_eq_tprod_geomSeries K

end Field

end StringFormal.Math
