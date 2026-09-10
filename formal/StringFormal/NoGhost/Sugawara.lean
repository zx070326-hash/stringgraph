/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import Mathlib.Algebra.MvPolynomial.Derivation
import Mathlib.Data.Int.Interval
import Mathlib.Tactic.NoncommRing
import Mathlib.Tactic.LinearCombination
import StringFormal.NoGhost.Fock
import StringFormal.Virasoro.Basic

/-!
# The Virasoro generators of `D` free bosons, and the central charge `c = D`

Graph nodes: `worldsheet.virasoro-generators-free-boson` (the definition of `L_m`) and
`worldsheet.free-boson-central-charge-d` (the Virasoro relations with `c = D`).
See `formal/TODO.md` item `sugawara`; builds on `StringFormal/NoGhost/Fock.lean`.

## Conventions

* `conv.metric-mostly-plus`: the target-space metric is diagonal, `η : Fin D → R`, and the
  oscillator algebra is `[α^μ_m, α^ν_n] = m η^{μν} δ_{m+n,0}` with `η^{μν} = δ^{μν} η^μ`.
  The *same* function `η` is used to contract the spacetime indices in `α_p · α_q`, which is
  correct precisely when `η_{μμ} = η^{μμ}`, i.e. under the hypothesis `hη : ∀ μ, η μ * η μ = 1`
  carried by every substantive statement below.  `Fock.minkowski` satisfies it.
* `conv.alpha-prime-regge`: the zero mode is a *parameter* `a : Fin D → R`, standing for
  `a^μ = α^μ_0 = (2α')^{1/2} k^μ` on the momentum-`k` vacuum.  Hence
  `½ α_0 · α_0 = α' k²` — this is `invTwo R * zeroModeSq η a` in the statements below, and
  taking `α' = 1/2` gives `a = k`.  The operators `x^μ` are *not* introduced (the no-ghost
  theorem does not need them; see "Mathematical gaps").
* `conv.virasoro-standard`: `[L_m, L_n] = (m - n) L_{m+n} + (c/12) m(m² - 1) δ_{m+n,0}`.
* Normal ordering is creation–annihilation ordering with **no** normal-ordering constant
  (`a^X = 0`): `L_0 |k⟩ = α' k² |k⟩`.

## Main definitions

* `Fock.mode η a μ j` — the mode `α^μ_j` for arbitrary `j : ℤ`: annihilation for `j > 0`,
  creation for `j < 0`, the scalar `a^μ` for `j = 0`.
* `Fock.nordPair η a i j` — the normal-ordered contraction `:α_i · α_j:`.
* `Fock.Lop η a n` — **the Virasoro generator** `L_n = ½ Σ_{j ∈ ℤ} :α_{n-j} · α_j:`.
  The sum over all of `ℤ` is realised by `lsumLocFin`: on each vector of the *algebraic* Fock
  space only finitely many terms are nonzero (`nordPair_apply_eq_zero_of_modeBound_lt`), so no
  convergence hypothesis is needed.
* `Fock.zeroModeSq η a = α_0 · α_0`; `invTwo R * zeroModeSq η a = α' k²`.
* `Fock.vircoeff η a m n` — the central term `z(m,n)` of `[L_m, L_n] - (m-n) L_{m+n}`.
* `Fock.wittRep`, `Fock.virRep` — the linear maps `ℓ n ↦ L_n` and `L n ↦ L_n`, `C ↦ D · id`.

## Main statements

* `Fock.lie_mode_mode` — `[α^μ_m, α^ν_p] = m η^{μν} δ_{m+p,0}` for all modes at once.
* `Fock.Lop_apply` — `L_n` is computed by *any* sufficiently large finite sum.
* `Fock.lie_Lop_mode` — **`[L_m, α^ν_p] = -p α^ν_{m+p}`**.
* `Fock.eq_smul_id_of_lie_mode` — rigidity: an endomorphism commuting with every mode is a
  scalar (irreducibility of the Fock module over the oscillator algebra).
* `Fock.Lop_apply_one_of_pos`, `Fock.Lop_zero_apply_one` — `L_n|k⟩ = 0` for `n ≥ 1` and
  `L_0|k⟩ = α' k² |k⟩`.
* `Fock.Lop_zero_apply_of_mem_levelSubmodule` — **`L_0 = α' k² + N` on the level-`N` piece.**
* `Fock.lie_Lop_Lop` — **the Virasoro relations**
  `[L_m, L_n] = (m - n) L_{m+n} + D · (m³ - m)/12 · δ_{m+n,0}`, i.e. `c = D`.
* `Fock.virRep_lgen`, `Fock.virRep_cgen`, `Fock.virRep_lie` — the Fock space is a
  representation of `VirasoroAlgebra R` with `C ↦ D · id`.

## Proof outline

The Virasoro relations are *not* obtained by a direct reordering computation.  Instead:

1. `[L_m, α_p] = -p α_{m+p}` is proved from the definition (only two terms of the Sugawara sum
   survive the commutator).
2. Hence `W_{m,n} := [L_m, L_n] - (m-n) L_{m+n}` commutes with every mode (Jacobi), so by
   rigidity `W_{m,n} = z(m,n) · id` for a scalar `z(m,n)`.
3. `z(m,0) = 0` for every `m` (constant terms of `L_n P` vanish for `n < 0`), and the Jacobi
   identity turns into the `2`-cocycle identity for `z`, which forces `z(m,n) = 0` whenever
   `m + n ≠ 0` and gives the recursion `(m-1) z(m+1) = (m+2) z(m)` on the diagonal.
4. The two base values `z(1,-1) = 0` and `z(2,-2) = D/2` are computed on the vacuum; the
   factor `D` enters exactly once, as `Σ_{μ} η^{μμ} η_{μμ} = D`.  The recursion then gives
   `z(m,-m) = D (m³ - m)/12`.

## Mathematical gaps (for the dependency graph)

1. **No `x^μ`.** Only the momentum eigenvalue `a^μ = (2α')^{1/2} k^μ` appears, as a parameter;
   the zero-mode operators `x^μ` and the direct integral over `k` are not formalised.  This is
   enough for the Virasoro action and for the no-ghost theorem, but the full string Fock space
   is a family of these spaces.
2. **Diagonal metric with `η² = 1`.**  See above; a general `η^{μν}` would require carrying the
   inverse metric separately.  Over `ℝ` this is no loss of generality.
3. **Algebraic Fock space.**  No completion is taken (inherited from `Fock.lean`).
4. **No `LieHom`.**  `Module.End R M` is a `LieRing` in Mathlib `v4.33.1` only through a
   `local instance`, so the homomorphism property is stated as `virRep_lie` rather than
   bundled.  The mathematical content is identical.
5. **Not proved here.**  That `L_m` agrees with the Laurent modes of the holomorphic
   energy-momentum tensor (that is the content of the *other* derivation of
   `worldsheet.free-boson-central-charge-d`, `--via-ope`); positivity/unitarity statements;
   the adjointness `L_m^† = L_{-m}` for `Fock.pairing`.

## Status

Complete, no `sorry`; axioms are `propext`, `Classical.choice`, `Quot.sound` only.
-/

namespace StringFormal.NoGhost

open MvPolynomial

/-! ### Locally finite sums of endomorphisms -/

section LocFin

variable {R : Type*} [CommRing R] {M : Type*} [AddCommGroup M] [Module R M]
variable {ι : Type*} [DecidableEq ι]

/-- Two finite sums of a family of endomorphisms evaluated at the same vector agree as soon as
both index sets contain everything that acts nontrivially on that vector. -/
lemma sum_apply_congr_of_eq_zero (f : ι → M →ₗ[R] M) (x : M) {s t : Finset ι}
    (hs : ∀ i ∉ s, f i x = 0) (ht : ∀ i ∉ t, f i x = 0) :
    ∑ i ∈ s, f i x = ∑ i ∈ t, f i x := by
  have h1 : ∑ i ∈ s, f i x = ∑ i ∈ s ∪ t, f i x :=
    Finset.sum_subset Finset.subset_union_left fun i _ hni => hs i hni
  have h2 : ∑ i ∈ t, f i x = ∑ i ∈ s ∪ t, f i x :=
    Finset.sum_subset Finset.subset_union_right fun i _ hni => ht i hni
  rw [h1, h2]

/-- The sum of a *locally finite* family of endomorphisms: `b x` is a finite index set outside
which `f i x = 0`.  This is how the formally infinite sums of the Sugawara construction are
realised: on each vector of the algebraic Fock space only finitely many terms survive. -/
noncomputable def lsumLocFin (f : ι → M →ₗ[R] M) (b : M → Finset ι)
    (hb : ∀ (x : M) (i : ι), i ∉ b x → f i x = 0) : M →ₗ[R] M where
  toFun x := ∑ i ∈ b x, f i x
  map_add' x y := by
    have hxy : ∀ i ∉ b (x + y) ∪ b x ∪ b y, f i (x + y) = 0 := by
      intro i hi
      simp only [Finset.mem_union, not_or] at hi
      rw [map_add, hb x i hi.1.2, hb y i hi.2, add_zero]
    have h1 : ∑ i ∈ b (x + y), f i (x + y)
        = ∑ i ∈ b (x + y) ∪ b x ∪ b y, f i (x + y) :=
      sum_apply_congr_of_eq_zero f (x + y) (fun i hi => hb (x + y) i hi) hxy
    have h2 : ∑ i ∈ b x, f i x = ∑ i ∈ b (x + y) ∪ b x ∪ b y, f i x :=
      sum_apply_congr_of_eq_zero f x (fun i hi => hb x i hi) (by
        intro i hi
        simp only [Finset.mem_union, not_or] at hi
        exact hb x i hi.1.2)
    have h3 : ∑ i ∈ b y, f i y = ∑ i ∈ b (x + y) ∪ b x ∪ b y, f i y :=
      sum_apply_congr_of_eq_zero f y (fun i hi => hb y i hi) (by
        intro i hi
        simp only [Finset.mem_union, not_or] at hi
        exact hb y i hi.2)
    rw [h1, h2, h3, ← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun i _ => map_add _ _ _
  map_smul' c x := by
    have hcx : ∀ i ∉ b (c • x) ∪ b x, f i (c • x) = 0 := by
      intro i hi
      simp only [Finset.mem_union, not_or] at hi
      rw [map_smul, hb x i hi.2, smul_zero]
    have h1 : ∑ i ∈ b (c • x), f i (c • x) = ∑ i ∈ b (c • x) ∪ b x, f i (c • x) :=
      sum_apply_congr_of_eq_zero f (c • x) (fun i hi => hb (c • x) i hi) hcx
    have h2 : ∑ i ∈ b x, f i x = ∑ i ∈ b (c • x) ∪ b x, f i x :=
      sum_apply_congr_of_eq_zero f x (fun i hi => hb x i hi) (by
        intro i hi
        simp only [Finset.mem_union, not_or] at hi
        exact hb x i hi.2)
    rw [h1, h2, Finset.smul_sum]
    exact Finset.sum_congr rfl fun i _ => map_smul _ _ _

/-- The defining property of `lsumLocFin`: it is computed by *any* finite index set large
enough for the given vector. -/
lemma lsumLocFin_apply (f : ι → M →ₗ[R] M) (b : M → Finset ι)
    (hb : ∀ (x : M) (i : ι), i ∉ b x → f i x = 0) (x : M) {s : Finset ι}
    (hs : ∀ i ∉ s, f i x = 0) :
    lsumLocFin f b hb x = ∑ i ∈ s, f i x :=
  sum_apply_congr_of_eq_zero f x (fun i hi => hb x i hi) hs

end LocFin

/-! ### `1/2` and unit scalars in a `ℚ`-algebra -/

section Rationals

variable (R : Type*) [CommRing R] [Algebra ℚ R]

/-- `1/2` in a commutative `ℚ`-algebra; the `½` of `L_n = ½ Σ :α·α:`. -/
noncomputable def invTwo : R := algebraMap ℚ R 2⁻¹

lemma two_mul_invTwo : (2 : R) * invTwo R = 1 := by
  rw [invTwo, ← map_ofNat (algebraMap ℚ R) 2, ← map_mul,
    show (2 : ℚ) * 2⁻¹ = 1 by norm_num, map_one]

lemma invTwo_mul_two : invTwo R * (2 : R) = 1 := by rw [mul_comm, two_mul_invTwo]

lemma six_mul_inv12 : (6 : R) * Virasoro.inv12 R = invTwo R := by
  rw [Virasoro.inv12, invTwo, ← map_ofNat (algebraMap ℚ R) 6, ← map_mul]
  congr 1
  norm_num

/-- Nonzero integers are invertible in a `ℚ`-algebra.  Used to solve the recursion that pins
down the central term. -/
lemma isUnit_intCast {n : ℤ} (hn : n ≠ 0) : IsUnit ((n : ℤ) : R) := by
  have h : ((n : ℤ) : R) = algebraMap ℚ R ((n : ℤ) : ℚ) := by
    rw [map_intCast]
  rw [h]
  exact (Ne.isUnit (by exact_mod_cast hn)).map (algebraMap ℚ R)

end Rationals

namespace Fock

variable {D : ℕ} {R : Type*} [CommRing R]

/-! ### The mode bound of a Fock vector -/

/-- The largest oscillator mode number occurring in `P`.  Every annihilation operator
`α^μ_j` with `j > modeBound P` kills `P`; this is what makes the Sugawara sums locally
finite. -/
noncomputable def modeBound (P : Fock D R) : ℕ := P.vars.sup fun v => (v.2 : ℕ)

@[simp]
lemma modeBound_one : modeBound (1 : Fock D R) = 0 := by
  classical
  simp [modeBound, MvPolynomial.vars_one]

lemma pderiv_eq_zero_of_modeBound_lt {P : Fock D R} {μ : Fin D} {n : ℕ+}
    (h : modeBound P < (n : ℕ)) : pderiv ((μ, n) : Osc D) P = 0 := by
  classical
  refine MvPolynomial.pderiv_eq_zero_of_notMem_vars fun hmem => ?_
  have := Finset.le_sup (f := fun v : Osc D => (v.2 : ℕ)) hmem
  exact absurd this (by simpa [modeBound] using h)

lemma annihilation_apply_eq_zero_of_modeBound_lt (η : Fin D → R) {P : Fock D R} {μ : Fin D}
    {n : ℕ+} (h : modeBound P < (n : ℕ)) : annihilation η μ n P = 0 := by
  rw [annihilation_apply, pderiv_eq_zero_of_modeBound_lt h, smul_zero]

/-! ### All modes `α^μ_j`, `j : ℤ` -/

section Mode

variable (η a : Fin D → R)

/-- The oscillator mode `α^μ_j` for arbitrary `j : ℤ`, as an endomorphism of the Fock space:
annihilation for `j > 0`, creation for `j < 0`, and the scalar `α^μ_0 = a^μ` for `j = 0`.

Convention: `a^μ = α^μ_0 = (2α')^{1/2} k^μ` where `k` is the momentum of the vacuum
(`conv.alpha-prime-regge`).  Taking `α' = 1/2` gives `a = k`. -/
noncomputable def mode (μ : Fin D) (j : ℤ) : Module.End R (Fock D R) :=
  if 0 < j then annihilation η μ j.toNat.toPNat'
  else if j < 0 then creation R μ (-j).toNat.toPNat'
  else a μ • LinearMap.id

lemma mode_of_pos {j : ℤ} (hj : 0 < j) (μ : Fin D) :
    mode η a μ j = annihilation η μ j.toNat.toPNat' := by
  rw [mode, if_pos hj]

lemma mode_of_neg {j : ℤ} (hj : j < 0) (μ : Fin D) :
    mode η a μ j = creation R μ (-j).toNat.toPNat' := by
  rw [mode, if_neg (by omega), if_pos hj]

@[simp]
lemma mode_zero (μ : Fin D) : mode η a μ 0 = a μ • LinearMap.id := by
  rw [mode, if_neg (by omega), if_neg (by omega)]

lemma toPNat'_coe_of_pos {j : ℤ} (hj : 0 < j) : ((j.toNat.toPNat' : ℕ+) : ℕ) = j.toNat := by
  rw [Nat.toPNat'_coe, if_pos (by omega)]

@[simp]
lemma mode_pnat (n : ℕ+) (μ : Fin D) : mode η a μ ((n : ℕ) : ℤ) = annihilation η μ n := by
  rw [mode_of_pos η a (by exact_mod_cast n.2) μ]
  congr 1
  refine PNat.coe_injective ?_
  rw [toPNat'_coe_of_pos (by exact_mod_cast n.2)]
  simp

@[simp]
lemma mode_neg_pnat (n : ℕ+) (μ : Fin D) : mode η a μ (-((n : ℕ) : ℤ)) = creation R μ n := by
  rw [mode_of_neg η a (by simp) μ]
  congr 1
  refine PNat.coe_injective ?_
  rw [Nat.toPNat'_coe, if_pos (by simp)]
  simp

lemma mode_apply_eq_zero_of_modeBound_lt {P : Fock D R} {j : ℤ} (μ : Fin D)
    (h : (modeBound P : ℤ) < j) : mode η a μ j P = 0 := by
  have hj : 0 < j := lt_of_le_of_lt (by positivity) h
  rw [mode_of_pos η a hj]
  refine annihilation_apply_eq_zero_of_modeBound_lt η ?_
  rw [toPNat'_coe_of_pos hj]
  omega

/-! ### The canonical commutation relations for all modes -/

lemma lie_smul_id_left {M : Type*} [AddCommGroup M] [Module R M] (c : R)
    (X : Module.End R M) : ⁅c • (LinearMap.id : Module.End R M), X⁆ = 0 := by
  rw [LieRing.of_associative_ring_bracket, ← Module.End.one_eq_id, smul_mul_assoc,
    mul_smul_comm, one_mul, mul_one, sub_self]

lemma lie_smul_id_right {M : Type*} [AddCommGroup M] [Module R M] (c : R)
    (X : Module.End R M) : ⁅X, c • (LinearMap.id : Module.End R M)⁆ = 0 := by
  rw [LieRing.of_associative_ring_bracket, ← Module.End.one_eq_id, smul_mul_assoc,
    mul_smul_comm, one_mul, mul_one, sub_self]

lemma lie_end_comm {M : Type*} [AddCommGroup M] [Module R M] (X Y : Module.End R M) :
    ⁅X, Y⁆ = -⁅Y, X⁆ := by
  rw [LieRing.of_associative_ring_bracket, LieRing.of_associative_ring_bracket, neg_sub]

/-- **The oscillator algebra**, for all modes at once:
`[α^μ_m, α^ν_p] = m η^{μν} δ_{m+p,0}` with `η^{μν} = δ^{μν} η^μ` diagonal.  The zero modes
`α^μ_0 = a^μ` are central. -/
theorem lie_mode_mode (μ ν : Fin D) (m p : ℤ) :
    ⁅mode η a μ m, mode η a ν p⁆
      = (if m + p = 0 ∧ μ = ν then (m : R) * η μ else 0)
          • (LinearMap.id : Module.End R (Fock D R)) := by
  classical
  rcases eq_or_ne m 0 with rfl | hm
  · rw [mode_zero, lie_smul_id_left]
    simp
  rcases eq_or_ne p 0 with rfl | hp
  · rw [mode_zero, lie_smul_id_right, if_neg (fun h => hm (by have := h.1; omega)), zero_smul]
  rcases hm.lt_or_gt with hmneg | hmpos
  · rcases hp.lt_or_gt with hpneg | hppos
    · rw [mode_of_neg η a hmneg, mode_of_neg η a hpneg, lie_creation_creation,
        if_neg (fun h => by have := h.1; omega), zero_smul]
    · -- `m < 0 < p`
      rw [lie_end_comm, mode_of_pos η a hppos, mode_of_neg η a hmneg,
        lie_annihilation_creation]
      have hcoe : ((p.toNat : ℕ) : R) = (p : R) := by
        rw [← Int.cast_natCast, Int.toNat_of_nonneg hppos.le]
      by_cases h : m + p = 0 ∧ μ = ν
      · have hmp : ((-m).toNat.toPNat' : ℕ+) = p.toNat.toPNat' := by
          refine PNat.coe_injective ?_
          rw [toPNat'_coe_of_pos (by omega), toPNat'_coe_of_pos hppos]
          omega
        rw [if_pos (show ((ν, p.toNat.toPNat') : Osc D) = (μ, (-m).toNat.toPNat') from
            by rw [hmp, h.2]), if_pos h, oscWeight_apply, toPNat'_coe_of_pos hppos, hcoe,
          ← h.2]
        have hmv : m = -p := by omega
        rw [hmv]
        push_cast
        rw [neg_mul]
        exact (neg_smul ((p : R) * η μ) (LinearMap.id : Module.End R (Fock D R))).symm
      · have hcond : ¬ (((ν, p.toNat.toPNat') : Osc D) = (μ, (-m).toNat.toPNat')) := by
          intro hc
          refine h ⟨?_, ?_⟩
          · have h1 : ((p.toNat.toPNat' : ℕ+) : ℕ) = (((-m).toNat.toPNat' : ℕ+) : ℕ) :=
              congrArg (fun w : Osc D => ((w.2 : ℕ+) : ℕ)) hc
            rw [toPNat'_coe_of_pos hppos, toPNat'_coe_of_pos (by omega)] at h1
            omega
          · exact (congrArg (fun w : Osc D => w.1) hc).symm
        rw [if_neg hcond, zero_smul, neg_zero, if_neg h, zero_smul]
  · rcases hp.lt_or_gt with hpneg | hppos
    · -- `p < 0 < m`
      rw [mode_of_pos η a hmpos, mode_of_neg η a hpneg, lie_annihilation_creation]
      have hcoe : ((m.toNat : ℕ) : R) = (m : R) := by
        rw [← Int.cast_natCast, Int.toNat_of_nonneg hmpos.le]
      by_cases h : m + p = 0 ∧ μ = ν
      · have hmp : ((m.toNat.toPNat' : ℕ+)) = (-p).toNat.toPNat' := by
          refine PNat.coe_injective ?_
          rw [toPNat'_coe_of_pos hmpos, toPNat'_coe_of_pos (by omega)]
          omega
        rw [if_pos (show ((μ, m.toNat.toPNat') : Osc D) = (ν, (-p).toNat.toPNat') from
            by rw [hmp, h.2]), if_pos h, oscWeight_apply, toPNat'_coe_of_pos hmpos, hcoe]
      · have hcond : ¬ (((μ, m.toNat.toPNat') : Osc D) = (ν, (-p).toNat.toPNat')) := by
          intro hc
          refine h ⟨?_, ?_⟩
          · have h1 : ((m.toNat.toPNat' : ℕ+) : ℕ) = (((-p).toNat.toPNat' : ℕ+) : ℕ) :=
              congrArg (fun w : Osc D => ((w.2 : ℕ+) : ℕ)) hc
            rw [toPNat'_coe_of_pos hmpos, toPNat'_coe_of_pos (by omega)] at h1
            omega
          · exact congrArg (fun w : Osc D => w.1) hc
        rw [if_neg hcond, if_neg h, zero_smul]
    · rw [mode_of_pos η a hmpos, mode_of_pos η a hppos, lie_annihilation_annihilation,
        if_neg (fun h => by have := h.1; omega), zero_smul]

/-! ### The normal-ordered contraction `:α_i · α_j:` -/

/-- The normal-ordered contraction `:α_i · α_j: = η_{μν} :α^μ_i α^ν_j:` of two oscillator
modes, for the diagonal metric `η`.  Normal ordering puts the mode with the smaller index
(the creation operator, in the mixed case) on the left, exactly as in
`worldsheet.virasoro-generators-free-boson`:
`:α^μ_p α^ν_q: = α^μ_p α^ν_q` if `p ≤ q` and `= α^ν_q α^μ_p` if `p > q`.

The metric is used both to contract the spacetime indices and (through `annihilation`) to
normalise the modes; the two uses agree with the physical `η_{μν} α^μ α^ν` exactly when
`η^{μμ} η_{μμ} = 1`, i.e. under the hypothesis `∀ μ, η μ * η μ = 1` satisfied by
`Fock.minkowski`.  All statements below carry that hypothesis. -/
noncomputable def nordPair (i j : ℤ) : Module.End R (Fock D R) :=
  if i ≤ j then ∑ μ : Fin D, η μ • (mode η a μ i * mode η a μ j)
  else ∑ μ : Fin D, η μ • (mode η a μ j * mode η a μ i)

lemma nordPair_of_le {i j : ℤ} (hij : i ≤ j) :
    nordPair η a i j = ∑ μ : Fin D, η μ • (mode η a μ i * mode η a μ j) := by
  rw [nordPair, if_pos hij]

/-- Normal ordering is symmetric. -/
lemma nordPair_comm (i j : ℤ) : nordPair η a i j = nordPair η a j i := by
  rcases le_total i j with h | h
  · by_cases h' : j ≤ i
    · rw [le_antisymm h h']
    · rw [nordPair, if_pos h, nordPair, if_neg h']
  · by_cases h' : i ≤ j
    · rw [le_antisymm h' h]
    · rw [nordPair, if_neg h', nordPair, if_pos h]

lemma nordPair_apply_of_le {i j : ℤ} (hij : i ≤ j) (P : Fock D R) :
    nordPair η a i j P = ∑ μ : Fin D, η μ • mode η a μ i (mode η a μ j P) := by
  rw [nordPair_of_le η a hij, LinearMap.sum_apply]
  exact Finset.sum_congr rfl fun μ _ => by rw [LinearMap.smul_apply, Module.End.mul_apply]

/-- Local finiteness of the Sugawara sum: `:α_i · α_j:` kills `P` as soon as one of the two
indices exceeds the mode bound of `P`, because normal ordering puts that mode on the right. -/
lemma nordPair_apply_eq_zero_of_modeBound_lt (i j : ℤ) {P : Fock D R}
    (h : (modeBound P : ℤ) < max i j) : nordPair η a i j P = 0 := by
  rcases le_total i j with hij | hij
  · rw [nordPair_apply_of_le η a hij]
    refine Finset.sum_eq_zero fun μ _ => ?_
    have hz : mode η a μ j P = 0 :=
      mode_apply_eq_zero_of_modeBound_lt η a μ (by rwa [max_eq_right hij] at h)
    rw [hz, map_zero, smul_zero]
  · rw [nordPair_comm η a, nordPair_apply_of_le η a hij]
    refine Finset.sum_eq_zero fun μ _ => ?_
    have hz : mode η a μ i P = 0 :=
      mode_apply_eq_zero_of_modeBound_lt η a μ (by rwa [max_eq_left hij] at h)
    rw [hz, map_zero, smul_zero]

end Mode

/-! ### The Virasoro generators `L_n` -/

section Lop

variable [Algebra ℚ R] (η a : Fin D → R)

/-- The index set outside which the `n`-th Sugawara sum vanishes on `P`. -/
noncomputable def LopIdx (n : ℤ) (P : Fock D R) : Finset ℤ :=
  Finset.Icc (n - (modeBound P : ℤ)) (modeBound P : ℤ)

omit [Algebra ℚ R] in
lemma nordPair_apply_eq_zero_of_notMem_LopIdx (n : ℤ) (P : Fock D R) {j : ℤ}
    (hj : j ∉ LopIdx n P) : nordPair η a (n - j) j P = 0 := by
  rw [LopIdx, Finset.mem_Icc, not_and_or] at hj
  refine nordPair_apply_eq_zero_of_modeBound_lt η a _ _ ?_
  rcases hj with h | h
  · exact lt_of_lt_of_le (by omega) (le_max_left (n - j) j)
  · exact lt_of_lt_of_le (by omega) (le_max_right (n - j) j)

/-- **The Virasoro generators of the free boson**, `L_n = ½ Σ_{j ∈ ℤ} :α_{n-j} · α_j:`
(graph node `worldsheet.virasoro-generators-free-boson`).  The sum over all of `ℤ` makes sense
because on each vector of the algebraic Fock space only finitely many terms are nonzero; this
is packaged by `lsumLocFin`. -/
noncomputable def Lop (n : ℤ) : Module.End R (Fock D R) :=
  invTwo R • lsumLocFin (fun j => nordPair η a (n - j) j) (LopIdx n)
    (fun P _j hj => nordPair_apply_eq_zero_of_notMem_LopIdx η a n P hj)

/-- `L_n` is computed by *any* sufficiently large finite sum. -/
theorem Lop_apply (n : ℤ) (P : Fock D R) {s : Finset ℤ}
    (hs : ∀ j ∉ s, nordPair η a (n - j) j P = 0) :
    Lop η a n P = invTwo R • ∑ j ∈ s, nordPair η a (n - j) j P := by
  rw [Lop, LinearMap.smul_apply, lsumLocFin_apply _ _ _ P hs]

theorem Lop_apply_LopIdx (n : ℤ) (P : Fock D R) :
    Lop η a n P = invTwo R • ∑ j ∈ LopIdx n P, nordPair η a (n - j) j P :=
  Lop_apply η a n P fun _ hj => nordPair_apply_eq_zero_of_notMem_LopIdx η a n P hj

end Lop

/-! ### The bracket of `L_n` with a single mode -/

section LieAux

variable {M : Type*} [AddCommGroup M] [Module R M]

lemma lie_smul_left (c : R) (X B : Module.End R M) : ⁅c • X, B⁆ = c • ⁅X, B⁆ := by
  rw [LieRing.of_associative_ring_bracket, LieRing.of_associative_ring_bracket,
    smul_mul_assoc, mul_smul_comm, smul_sub]

lemma lie_sum_left {ι : Type*} (s : Finset ι) (f : ι → Module.End R M) (B : Module.End R M) :
    ⁅∑ i ∈ s, f i, B⁆ = ∑ i ∈ s, ⁅f i, B⁆ := by
  rw [LieRing.of_associative_ring_bracket, Finset.sum_mul, Finset.mul_sum,
    ← Finset.sum_sub_distrib]
  exact Finset.sum_congr rfl fun i _ => (LieRing.of_associative_ring_bracket _ _).symm

/-- Leibniz rule for a product of two operators whose brackets with `B` are central. -/
lemma lie_mul_of_central {X Y B : Module.End R M} {cx cy : R}
    (hx : ⁅X, B⁆ = cx • (LinearMap.id : Module.End R M))
    (hy : ⁅Y, B⁆ = cy • (LinearMap.id : Module.End R M)) :
    ⁅X * Y, B⁆ = cy • X + cx • Y := by
  rw [LieRing.of_associative_ring_bracket] at hx hy ⊢
  rw [← Module.End.one_eq_id] at hx hy
  have h1 : X * Y * B - B * (X * Y) = X * (Y * B - B * Y) + (X * B - B * X) * Y := by
    noncomm_ring
  rw [h1, hx, hy, mul_smul_comm, smul_mul_assoc, mul_one, one_mul]

end LieAux

section Bracket

variable (η a : Fin D → R)

/-- `[:α_i · α_j:, α^ν_p] = j δ_{j+p,0} α^ν_i + i δ_{i+p,0} α^ν_j`.  This is the only place the
hypothesis `η^{μμ} η_{μμ} = 1` (i.e. `η μ * η μ = 1`) is used: it is what makes the contraction
of the two metric factors give `1` rather than `(η^{μμ})²`. -/
lemma lie_nordPair_mode_of_le (hη : ∀ μ, η μ * η μ = 1) {i j : ℤ} (hij : i ≤ j) (ν : Fin D)
    (p : ℤ) :
    ⁅nordPair η a i j, mode η a ν p⁆
      = (if j + p = 0 then (j : R) • mode η a ν i else 0)
          + (if i + p = 0 then (i : R) • mode η a ν j else 0) := by
  classical
  have key : ∀ k l : ℤ,
      ∑ μ : Fin D, η μ • ((if k + p = 0 ∧ μ = ν then (k : R) * η μ else 0)
        • mode η a μ l) = if k + p = 0 then (k : R) • mode η a ν l else 0 := by
    intro k l
    by_cases hk : k + p = 0
    · rw [if_pos hk, Finset.sum_eq_single_of_mem ν (Finset.mem_univ ν)
        (fun b _ hb => by rw [if_neg (fun h => hb h.2), zero_smul, smul_zero]),
        if_pos ⟨hk, rfl⟩, smul_smul]
      congr 1
      rw [← mul_assoc, mul_comm (η ν) ((k : R)), mul_assoc, hη ν, mul_one]
    · rw [if_neg hk]
      exact Finset.sum_eq_zero fun μ _ => by
        rw [if_neg (fun h => hk h.1), zero_smul, smul_zero]
  rw [nordPair_of_le η a hij, lie_sum_left]
  have hterm : ∀ μ : Fin D, ⁅η μ • (mode η a μ i * mode η a μ j), mode η a ν p⁆
      = η μ • ((if j + p = 0 ∧ μ = ν then (j : R) * η μ else 0) • mode η a μ i)
        + η μ • ((if i + p = 0 ∧ μ = ν then (i : R) * η μ else 0) • mode η a μ j) := by
    intro μ
    rw [lie_smul_left, lie_mul_of_central (lie_mode_mode η a μ ν i p)
      (lie_mode_mode η a μ ν j p), smul_add]
  rw [Finset.sum_congr rfl fun μ _ => hterm μ, Finset.sum_add_distrib, key j i, key i j]

lemma lie_nordPair_mode (hη : ∀ μ, η μ * η μ = 1) (i j : ℤ) (ν : Fin D) (p : ℤ) :
    ⁅nordPair η a i j, mode η a ν p⁆
      = (if j + p = 0 then (j : R) • mode η a ν i else 0)
          + (if i + p = 0 then (i : R) • mode η a ν j else 0) := by
  rcases le_total i j with h | h
  · exact lie_nordPair_mode_of_le η a hη h ν p
  · rw [nordPair_comm η a, lie_nordPair_mode_of_le η a hη h ν p]
    exact add_comm _ _

variable [Algebra ℚ R]

/-- **`[L_m, α^ν_p] = -p α^ν_{m+p}`**: the modes `α^ν_p` form a weight-`1` primary field for the
Sugawara Virasoro action.  Together with `Lop_apply_one` and the rigidity of the Fock
representation this is what forces the Virasoro relations. -/
theorem lie_Lop_mode (hη : ∀ μ, η μ * η μ = 1) (n : ℤ) (ν : Fin D) (p : ℤ) :
    ⁅Lop η a n, mode η a ν p⁆ = (-(p : R)) • mode η a ν (n + p) := by
  classical
  refine LinearMap.ext fun P => ?_
  set Q := mode η a ν p P with hQdef
  set s : Finset ℤ := (LopIdx n P ∪ LopIdx n Q) ∪ {-p, n + p} with hsdef
  have hsP : ∀ j ∉ s, nordPair η a (n - j) j P = 0 := fun j hj =>
    nordPair_apply_eq_zero_of_notMem_LopIdx η a n P fun h => hj
      (Finset.mem_union_left _ (Finset.mem_union_left _ h))
  have hsQ : ∀ j ∉ s, nordPair η a (n - j) j Q = 0 := fun j hj =>
    nordPair_apply_eq_zero_of_notMem_LopIdx η a n Q fun h => hj
      (Finset.mem_union_left _ (Finset.mem_union_right _ h))
  have hmem1 : (-p) ∈ s := Finset.mem_union_right _ (Finset.mem_insert_self _ _)
  have hmem2 : (n + p) ∈ s :=
    Finset.mem_union_right _ (Finset.mem_insert_of_mem (Finset.mem_singleton_self _))
  -- the summand: bracket of one normal-ordered pair with the mode
  have hterm : ∀ j : ℤ, nordPair η a (n - j) j Q - mode η a ν p (nordPair η a (n - j) j P)
      = (if j = -p then ((j : ℤ) : R) • mode η a ν (n - j) P else 0)
        + (if j = n + p then ((n - j : ℤ) : R) • mode η a ν j P else 0) := by
    intro j
    have hbr : nordPair η a (n - j) j Q - mode η a ν p (nordPair η a (n - j) j P)
        = (⁅nordPair η a (n - j) j, mode η a ν p⁆ : Module.End R (Fock D R)) P := by
      rw [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
        Module.End.mul_apply, hQdef]
    rw [hbr, lie_nordPair_mode η a hη, LinearMap.add_apply]
    congr 1
    · by_cases h : j + p = 0
      · rw [if_pos h, if_pos (show j = -p by omega), LinearMap.smul_apply]
      · rw [if_neg h, if_neg (show ¬ j = -p by omega), LinearMap.zero_apply]
    · by_cases h : (n - j) + p = 0
      · rw [if_pos h, if_pos (show j = n + p by omega), LinearMap.smul_apply]
      · rw [if_neg h, if_neg (show ¬ j = n + p by omega), LinearMap.zero_apply]
  have hbracket : ⁅Lop η a n, mode η a ν p⁆ P
      = Lop η a n Q - mode η a ν p (Lop η a n P) := by
    rw [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
      Module.End.mul_apply, hQdef]
  rw [hbracket, Lop_apply η a n Q hsQ, Lop_apply η a n P hsP, map_smul, map_sum, ← smul_sub,
    ← Finset.sum_sub_distrib, Finset.sum_congr rfl fun j _ => hterm j, Finset.sum_add_distrib,
    Finset.sum_ite_eq_of_mem' s (-p) _ hmem1, Finset.sum_ite_eq_of_mem' s (n + p) _ hmem2]
  have h1 : n - -p = n + p := by omega
  have h2 : ((n - (n + p) : ℤ) : R) = -(p : R) := by
    rw [show n - (n + p) = -p by omega]
    push_cast
    ring
  rw [h1, h2, show (((-p : ℤ)) : R) = -(p : R) by push_cast; ring, LinearMap.smul_apply,
    ← two_smul R ((-(p : R)) • mode η a ν (n + p) P), smul_smul, invTwo_mul_two, one_smul]

end Bracket

/-! ### The vacuum and the constant term -/

section Vacuum

variable (η a : Fin D → R)

/-- `α_0 · α_0 = η_{μν} a^μ a^ν`.  With `a^μ = (2α')^{1/2} k^μ` this is `2α' k²`, so that
`½ α_0² = α' k²` is the momentum contribution to `L_0` (`conv.alpha-prime-regge`). -/
def zeroModeSq : R := ∑ μ : Fin D, η μ * a μ * a μ

lemma nordPair_zero_zero : nordPair η a 0 0 = zeroModeSq η a • LinearMap.id := by
  rw [nordPair_of_le η a le_rfl, zeroModeSq, Finset.sum_smul]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [mode_zero, smul_mul_assoc, mul_smul_comm, ← Module.End.one_eq_id, mul_one, smul_smul,
    smul_smul, mul_assoc]

/-- The constant term of `:α_i · α_j: P` vanishes as soon as the left factor is a creation
operator, i.e. as soon as `min i j < 0`. -/
lemma constantCoeff_nordPair_apply (i j : ℤ) (h : min i j < 0) (P : Fock D R) :
    constantCoeff (nordPair η a i j P) = 0 := by
  have main : ∀ i' j' : ℤ, i' ≤ j' → i' < 0 →
      constantCoeff (nordPair η a i' j' P) = 0 := by
    intro i' j' hij hi'
    rw [nordPair_apply_of_le η a hij, map_sum]
    refine Finset.sum_eq_zero fun μ _ => ?_
    rw [mode_of_neg η a hi', creation_apply, smul_eq_C_mul, map_mul, map_mul, constantCoeff_X,
      zero_mul, mul_zero]
  rcases le_total i j with hij | hij
  · exact main i j hij (by rwa [min_eq_left hij] at h)
  · rw [nordPair_comm η a]
    exact main j i hij (by rwa [min_eq_right hij] at h)

variable [Algebra ℚ R]

/-- Positive Virasoro modes annihilate the vacuum: `L_n |k⟩ = 0` for `n ≥ 1`.  With the
convention `a^X = 0` (no normal-ordering constant) this is immediate from local finiteness:
the index set of the Sugawara sum is empty on the vacuum. -/
@[simp]
theorem Lop_apply_one_of_pos {n : ℤ} (hn : 0 < n) : Lop η a n (1 : Fock D R) = 0 := by
  rw [Lop_apply_LopIdx, LopIdx, modeBound_one]
  rw [Finset.Icc_eq_empty (by omega), Finset.sum_empty, smul_zero]

/-- `L_0 |k⟩ = ½ α_0² |k⟩ = α' k² |k⟩`: the vacuum has `L_0`-eigenvalue `α' k²`, i.e. the
normal-ordering constant is zero. -/
theorem Lop_zero_apply_one :
    Lop η a 0 (1 : Fock D R) = (invTwo R * zeroModeSq η a) • (1 : Fock D R) := by
  rw [Lop_apply_LopIdx, LopIdx, modeBound_one]
  norm_num
  rw [nordPair_zero_zero, LinearMap.smul_apply, LinearMap.id_coe, id_eq, smul_smul]

/-- The constant term of `L_n P` vanishes for `n < 0`: every term of the Sugawara sum then has
a creation operator on the left. -/
theorem constantCoeff_Lop_apply_of_neg {n : ℤ} (hn : n < 0) (P : Fock D R) :
    constantCoeff (Lop η a n P) = 0 := by
  rw [Lop_apply_LopIdx, smul_eq_C_mul, map_mul, map_sum]
  rw [Finset.sum_congr rfl fun j _ =>
    constantCoeff_nordPair_apply η a (n - j) j (by omega) P]
  rw [Finset.sum_const_zero, mul_zero]

end Vacuum

/-! ### Rigidity of the Fock representation -/

section Rigidity

variable (η a : Fin D → R)

/-- An endomorphism commuting with all creation operators is multiplication by its value on
the vacuum. -/
theorem apply_eq_mul_apply_one (Z : Module.End R (Fock D R))
    (hZ : ∀ (μ : Fin D) (n : ℕ+) (P : Fock D R),
      Z (creation R μ n P) = creation R μ n (Z P)) (P : Fock D R) :
    Z P = P * Z 1 := by
  induction P using MvPolynomial.induction_on with
  | C r =>
      have hCr : (C r : Fock D R) = r • 1 := by rw [smul_eq_C_mul, mul_one]
      conv_lhs => rw [hCr]
      rw [map_smul, smul_eq_C_mul]
  | add p q hp hq => rw [map_add, hp, hq, add_mul]
  | mul_X p v hp =>
      obtain ⟨μ, n⟩ := v
      have hv : p * X ((μ, n) : Osc D) = creation R μ n p := by rw [creation_apply, mul_comm]
      rw [hv, hZ, creation_apply, hp, creation_apply]
      ring

variable [Algebra ℚ R]

lemma isUnit_oscWeight (hη : ∀ μ, η μ * η μ = 1) (μ : Fin D) (n : ℕ+) :
    IsUnit (oscWeight η ((μ, n) : Osc D)) := by
  rw [oscWeight_apply]
  refine IsUnit.mul ?_ ⟨⟨η μ, η μ, hη μ, hη μ⟩, rfl⟩
  have h : (((n : ℕ) : ℤ) : R) = ((n : ℕ) : R) := by push_cast; ring
  rw [← h]
  exact isUnit_intCast R (by exact_mod_cast n.ne_zero)

/-- A polynomial all of whose partial derivatives vanish is constant (over a `ℚ`-algebra). -/
lemma eq_C_constantCoeff_of_pderiv_eq_zero {F : Fock D R}
    (h : ∀ v : Osc D, pderiv v F = 0) : F = C (constantCoeff F) := by
  classical
  refine MvPolynomial.ext _ _ fun d => ?_
  rw [coeff_C]
  by_cases hd : d = 0
  · rw [hd, if_pos rfl, constantCoeff_eq]
  · rw [if_neg (Ne.symm hd)]
    obtain ⟨v, hv⟩ : ∃ v : Osc D, d v ≠ 0 := by
      by_contra hc
      exact hd (Finsupp.ext fun v => by simpa using not_not.mp (not_exists.mp hc v))
    set e : Osc D →₀ ℕ := d - Finsupp.single v 1 with he
    have hev : e v = d v - 1 := by
      rw [he]
      simp only [Finsupp.tsub_apply, Finsupp.single_eq_same]
    have hkey := congrArg (coeff e) (h v)
    rw [coeff_pderiv, coeff_zero] at hkey
    have hsub : e + Finsupp.single v 1 = d := by
      refine Finsupp.ext fun u => ?_
      by_cases hu : u = v
      · subst hu
        rw [Finsupp.add_apply, Finsupp.single_eq_same, hev]
        omega
      · have hz : (Finsupp.single v 1 : Osc D →₀ ℕ) u = 0 := Finsupp.single_eq_of_ne hu
        rw [Finsupp.add_apply, hz, add_zero, he]
        simp [Finsupp.tsub_apply, hz]
    have hdv : ((e v : ℕ) : R) + 1 = ((d v : ℕ) : R) := by
      rw [hev]
      have h1 : 1 ≤ d v := Nat.one_le_iff_ne_zero.mpr hv
      rw [← Nat.cast_one (R := R), ← Nat.cast_add, Nat.sub_add_cancel h1]
    rw [hsub, hdv] at hkey
    have hunit : IsUnit ((d v : ℕ) : R) := by
      have h : (((d v : ℕ) : ℤ) : R) = ((d v : ℕ) : R) := by push_cast; ring
      rw [← h]
      exact isUnit_intCast R (by exact_mod_cast hv)
    exact hunit.mul_left_cancel (by rw [mul_zero, mul_comm]; exact hkey)

/-- **Rigidity of the Fock representation.**  An endomorphism commuting with every oscillator
mode is a scalar.  (This is irreducibility of the Fock module over the oscillator algebra.)
It is what turns the commutator identity `[L_m, α_p] = -p α_{m+p}` into the Virasoro
relations. -/
theorem eq_smul_id_of_lie_mode (hη : ∀ μ, η μ * η μ = 1) (Z : Module.End R (Fock D R))
    (hZ : ∀ (μ : Fin D) (j : ℤ), ⁅Z, mode η a μ j⁆ = 0) :
    Z = constantCoeff (Z 1) • (LinearMap.id : Module.End R (Fock D R)) := by
  have hcomm : ∀ (μ : Fin D) (j : ℤ) (P : Fock D R),
      ⁅Z, mode η a μ j⁆ = 0 → Z (mode η a μ j P) = mode η a μ j (Z P) := by
    intro μ j P hj
    have h2 := congrArg (fun T : Module.End R (Fock D R) => T P) hj
    simp only [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
      LinearMap.zero_apply, sub_eq_zero] at h2
    exact h2
  have hcre : ∀ (μ : Fin D) (n : ℕ+) (P : Fock D R),
      Z (creation R μ n P) = creation R μ n (Z P) := by
    intro μ n P
    have h := hcomm μ (-((n : ℕ) : ℤ)) P (hZ μ _)
    rwa [mode_neg_pnat] at h
  have hF : ∀ v : Osc D, pderiv v (Z 1) = 0 := by
    rintro ⟨μ, n⟩
    have h := hcomm μ ((n : ℕ) : ℤ) 1 (hZ μ _)
    rw [mode_pnat, annihilation_one, map_zero, annihilation_apply] at h
    exact ((isUnit_oscWeight η hη μ n).smul_left_cancel).mp (by rw [← h, smul_zero])
  have hZ1 : Z 1 = C (constantCoeff (Z 1)) := eq_C_constantCoeff_of_pderiv_eq_zero hF
  refine LinearMap.ext fun P => ?_
  rw [apply_eq_mul_apply_one Z hcre P, LinearMap.smul_apply, LinearMap.id_coe, id_eq,
    smul_eq_C_mul, mul_comm, ← hZ1]

end Rigidity

/-! ### The Virasoro relations -/

section Virasoro

variable {M : Type*} [AddCommGroup M] [Module R M]

lemma lie_add_left (X Y Z : Module.End R M) : ⁅X + Y, Z⁆ = ⁅X, Z⁆ + ⁅Y, Z⁆ := by
  simp only [LieRing.of_associative_ring_bracket]
  noncomm_ring

lemma lie_add_right (X Y Z : Module.End R M) : ⁅X, Y + Z⁆ = ⁅X, Y⁆ + ⁅X, Z⁆ := by
  simp only [LieRing.of_associative_ring_bracket]
  noncomm_ring

lemma lie_sub_left (X Y Z : Module.End R M) : ⁅X - Y, Z⁆ = ⁅X, Z⁆ - ⁅Y, Z⁆ := by
  simp only [LieRing.of_associative_ring_bracket]
  noncomm_ring

lemma lie_smul_right (c : R) (X Y : Module.End R M) : ⁅X, c • Y⁆ = c • ⁅X, Y⁆ := by
  simp only [LieRing.of_associative_ring_bracket]
  rw [mul_smul_comm, smul_mul_assoc, smul_sub]

lemma lie_end_self (X : Module.End R M) : ⁅X, X⁆ = 0 := by
  rw [LieRing.of_associative_ring_bracket, sub_self]

lemma lie_lie_left (X Y Z : Module.End R M) : ⁅⁅X, Y⁆, Z⁆ = ⁅X, ⁅Y, Z⁆⁆ - ⁅Y, ⁅X, Z⁆⁆ := by
  simp only [LieRing.of_associative_ring_bracket]
  noncomm_ring

lemma lie_jacobi_end (X Y Z : Module.End R M) :
    ⁅⁅X, Y⁆, Z⁆ + ⁅⁅Y, Z⁆, X⁆ + ⁅⁅Z, X⁆, Y⁆ = 0 := by
  simp only [LieRing.of_associative_ring_bracket]
  noncomm_ring

end Virasoro

section Central

variable [Algebra ℚ R] (η a : Fin D → R)

omit [Algebra ℚ R] in
lemma constantCoeff_smul (c : R) (P : Fock D R) :
    constantCoeff (c • P) = c * constantCoeff P := by
  rw [smul_eq_C_mul, map_mul, constantCoeff_C]

/-- The obstruction to the naive Witt relation: `W_{m,n} = [L_m, L_n] - (m-n) L_{m+n}`. -/
noncomputable def virW (m n : ℤ) : Module.End R (Fock D R) :=
  ⁅Lop η a m, Lop η a n⁆ - ((m : R) - n) • Lop η a (m + n)

/-- The central term `z(m,n)` of the Virasoro relation, read off from the vacuum. -/
noncomputable def vircoeff (m n : ℤ) : R := constantCoeff (virW η a m n (1 : Fock D R))

lemma virW_apply (m n : ℤ) (P : Fock D R) :
    virW η a m n P
      = Lop η a m (Lop η a n P) - Lop η a n (Lop η a m P)
        - ((m : R) - n) • Lop η a (m + n) P := by
  rw [virW, LinearMap.sub_apply, LieRing.of_associative_ring_bracket, LinearMap.sub_apply,
    Module.End.mul_apply, Module.End.mul_apply, LinearMap.smul_apply]

lemma vircoeff_eq (m n : ℤ) :
    vircoeff η a m n
      = constantCoeff (Lop η a m (Lop η a n (1 : Fock D R)))
        - constantCoeff (Lop η a n (Lop η a m (1 : Fock D R)))
        - ((m : R) - n) * constantCoeff (Lop η a (m + n) (1 : Fock D R)) := by
  rw [vircoeff, virW_apply, map_sub, map_sub, constantCoeff_smul]

lemma virW_neg (m n : ℤ) : virW η a n m = -virW η a m n := by
  have hns : (-((m : R) - n)) • Lop η a (m + n) = -(((m : R) - n) • Lop η a (m + n)) :=
    neg_smul ((m : R) - n) (Lop η a (m + n))
  rw [virW, virW, lie_end_comm (Lop η a n) (Lop η a m), show n + m = m + n by ring,
    show ((n : R) - m) = -((m : R) - n) by ring, hns]
  abel

lemma vircoeff_neg (m n : ℤ) : vircoeff η a n m = -vircoeff η a m n := by
  rw [vircoeff, vircoeff, virW_neg, LinearMap.neg_apply, map_neg]

lemma vircoeff_self (m : ℤ) : vircoeff η a m m = 0 := by
  rw [vircoeff, virW, lie_end_self, sub_self, zero_smul, sub_zero, LinearMap.zero_apply,
    map_zero]

/-- `W_{m,n}` commutes with every oscillator mode: this is the Jacobi identity together with
`[L_m, α_p] = -p α_{m+p}`. -/
theorem lie_virW_mode (hη : ∀ μ, η μ * η μ = 1) (m n : ℤ) (ν : Fin D) (p : ℤ) :
    ⁅virW η a m n, mode η a ν p⁆ = 0 := by
  have h1 : ⁅⁅Lop η a m, Lop η a n⁆, mode η a ν p⁆
      = ((p : R) * ((n : R) - m)) • mode η a ν (m + n + p) := by
    rw [lie_lie_left, lie_Lop_mode η a hη n ν p, lie_Lop_mode η a hη m ν p,
      lie_smul_right, lie_smul_right, lie_Lop_mode η a hη m ν (n + p),
      lie_Lop_mode η a hη n ν (m + p), smul_smul, smul_smul,
      show m + (n + p) = m + n + p by ring, show n + (m + p) = m + n + p by ring, ← sub_smul]
    congr 1
    push_cast
    ring
  have h2 : ⁅((m : R) - n) • Lop η a (m + n), mode η a ν p⁆
      = ((p : R) * ((n : R) - m)) • mode η a ν (m + n + p) := by
    rw [lie_smul_left, lie_Lop_mode η a hη (m + n) ν p, smul_smul]
    congr 1
    ring
  rw [virW, lie_sub_left, h1, h2, sub_self]

/-- **`[L_m, L_n] - (m-n) L_{m+n}` is a scalar.**  Everything else is bookkeeping: it remains
to identify the scalar. -/
theorem virW_eq_smul_id (hη : ∀ μ, η μ * η μ = 1) (m n : ℤ) :
    virW η a m n = vircoeff η a m n • (LinearMap.id : Module.End R (Fock D R)) :=
  eq_smul_id_of_lie_mode η a hη _ fun μ j => lie_virW_mode η a hη m n μ j

lemma lie_Lop_Lop_eq (hη : ∀ μ, η μ * η μ = 1) (m n : ℤ) :
    ⁅Lop η a m, Lop η a n⁆
      = ((m : R) - n) • Lop η a (m + n)
        + vircoeff η a m n • (LinearMap.id : Module.End R (Fock D R)) := by
  have h := virW_eq_smul_id η a hη m n
  rw [virW, sub_eq_iff_eq_add] at h
  rw [h, add_comm]

end Central

/-! ### The central term -/

section CentralValue

variable [Algebra ℚ R] (η a : Fin D → R)

theorem constantCoeff_Lop_zero_apply (P : Fock D R) :
    constantCoeff (Lop η a 0 P) = invTwo R * zeroModeSq η a * constantCoeff P := by
  have hmem : (0 : ℤ) ∈ LopIdx 0 P := by
    rw [LopIdx, Finset.mem_Icc]
    omega
  rw [Lop_apply_LopIdx, constantCoeff_smul, map_sum,
    Finset.sum_eq_single_of_mem 0 hmem fun b _ hb =>
      constantCoeff_nordPair_apply η a (0 - b) b (by omega) P,
    sub_zero, nordPair_zero_zero, LinearMap.smul_apply, LinearMap.id_coe, id_eq,
    constantCoeff_smul, mul_assoc]

/-- `z(m, 0) = 0` for every `m`: the central term vanishes whenever one of the two modes is
`L_0`. -/
theorem vircoeff_zero_right (m : ℤ) : vircoeff η a m 0 = 0 := by
  rw [vircoeff_eq, add_zero]
  rcases lt_trichotomy m 0 with hm | rfl | hm
  · rw [constantCoeff_Lop_apply_of_neg η a hm (Lop η a 0 1), constantCoeff_Lop_zero_apply,
      constantCoeff_Lop_apply_of_neg η a hm 1]
    ring
  · ring
  · rw [Lop_zero_apply_one, map_smul, Lop_apply_one_of_pos η a hm]
    simp

/-- The `2`-cocycle identity satisfied by the central term, a consequence of the Jacobi
identity for `[L_m, L_n] = (m-n) L_{m+n} + z(m,n)`. -/
theorem vircoeff_cocycle (hη : ∀ μ, η μ * η μ = 1) (x y z : ℤ) :
    ((x : R) - y) * vircoeff η a (x + y) z + ((y : R) - z) * vircoeff η a (y + z) x
      + ((z : R) - x) * vircoeff η a (z + x) y = 0 := by
  set s : ℤ := x + y + z with hs
  have key : ∀ u v w : ℤ, u + v + w = s →
      constantCoeff ((⁅⁅Lop η a u, Lop η a v⁆, Lop η a w⁆ : Module.End R (Fock D R))
          (1 : Fock D R))
        = ((u : R) - v) * ((u : R) + v - w) * constantCoeff (Lop η a s (1 : Fock D R))
          + ((u : R) - v) * vircoeff η a (u + v) w := by
    intro u v w huvw
    rw [lie_Lop_Lop_eq η a hη u v, lie_add_left, lie_smul_left, lie_smul_id_left, add_zero,
      lie_Lop_Lop_eq η a hη (u + v) w, huvw, smul_add, smul_smul, smul_smul,
      LinearMap.add_apply, LinearMap.smul_apply, LinearMap.smul_apply, LinearMap.id_coe,
      id_eq, map_add, constantCoeff_smul, constantCoeff_smul,
      show constantCoeff (1 : Fock D R) = 1 from map_one _, mul_one]
    push_cast
    ring
  have hjac := congrArg
    (fun T : Module.End R (Fock D R) => constantCoeff (T (1 : Fock D R)))
    (lie_jacobi_end (Lop η a x) (Lop η a y) (Lop η a z))
  simp only [LinearMap.add_apply, map_add, LinearMap.zero_apply, map_zero] at hjac
  rw [key x y z (by omega), key y z x (by omega), key z x y (by omega)] at hjac
  have hz : ((x : R) - y) * ((x : R) + y - z) + ((y : R) - z) * ((y : R) + z - x)
      + ((z : R) - x) * ((z : R) + x - y) = 0 := by ring
  linear_combination hjac - constantCoeff (Lop η a s (1 : Fock D R)) * hz

/-- **The central term vanishes unless `m + n = 0`.** -/
theorem vircoeff_eq_zero_of_add_ne_zero (hη : ∀ μ, η μ * η μ = 1) {m n : ℤ} (h : m + n ≠ 0) :
    vircoeff η a m n = 0 := by
  have hc := vircoeff_cocycle η a hη m 0 n
  rw [add_zero, zero_add, vircoeff_zero_right, vircoeff_neg η a m n] at hc
  have h2 : ((m + n : ℤ) : R) * vircoeff η a m n = 0 := by
    push_cast
    linear_combination hc
  exact (isUnit_intCast R h).mul_left_cancel (by rw [h2, mul_zero])

end CentralValue

/-! ### The two base values of the central term, and `c = D` -/

section BaseValues

variable [Algebra ℚ R] (η a : Fin D → R)

omit [Algebra ℚ R] in
@[simp]
lemma mode_apply_one_eq_zero {j : ℤ} (hj : 0 < j) (μ : Fin D) :
    mode η a μ j (1 : Fock D R) = 0 :=
  mode_apply_eq_zero_of_modeBound_lt η a μ (by rw [modeBound_one]; exact_mod_cast hj)

omit [Algebra ℚ R] in
lemma mode_zero_apply (μ : Fin D) (Y : Fock D R) : mode η a μ 0 Y = a μ • Y := by
  rw [mode_zero, LinearMap.smul_apply, LinearMap.id_coe, id_eq]

omit [Algebra ℚ R] in
/-- `α^μ_m α^μ_p Y = m η^{μμ} δ_{m+p,0} Y + α^μ_p α^μ_m Y`: the commutation relation in the
form used to move annihilation operators to the right. -/
lemma mode_apply_mode (μ : Fin D) (m p : ℤ) (Y : Fock D R) :
    mode η a μ m (mode η a μ p Y)
      = (if m + p = 0 then (m : R) * η μ else 0) • Y + mode η a μ p (mode η a μ m Y) := by
  have h := congrArg (fun T : Module.End R (Fock D R) => T Y) (lie_mode_mode η a μ μ m p)
  simp only [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
    LinearMap.smul_apply, LinearMap.id_coe, id_eq, and_true] at h
  rw [← h]
  abel

/-- `L_n α^μ_p Y = -p α^μ_{n+p} Y + α^μ_p L_n Y`. -/
lemma Lop_apply_mode (hη : ∀ μ, η μ * η μ = 1) (n : ℤ) (μ : Fin D) (p : ℤ) (Y : Fock D R) :
    Lop η a n (mode η a μ p Y)
      = (-(p : R)) • mode η a μ (n + p) Y + mode η a μ p (Lop η a n Y) := by
  have h := congrArg (fun T : Module.End R (Fock D R) => T Y) (lie_Lop_mode η a hη n μ p)
  simp only [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
    LinearMap.smul_apply] at h
  rw [← h]
  abel

lemma Lop_apply_mode_one (hη : ∀ μ, η μ * η μ = 1) {n : ℤ} (hn : 0 < n) (μ : Fin D) (p : ℤ) :
    Lop η a n (mode η a μ p (1 : Fock D R))
      = (-(p : R)) • mode η a μ (n + p) (1 : Fock D R) := by
  rw [Lop_apply_mode η a hη n μ p 1, Lop_apply_one_of_pos η a hn, map_zero, add_zero]

/-- `L_{-1}|k⟩ = α_{-1} · α_0 |k⟩`. -/
lemma Lop_neg_one_apply_one :
    Lop η a (-1) (1 : Fock D R)
      = ∑ μ : Fin D, (η μ * a μ) • mode η a μ (-1) (1 : Fock D R) := by
  have hnp : nordPair η a (-1) 0 (1 : Fock D R)
      = ∑ μ : Fin D, (η μ * a μ) • mode η a μ (-1) (1 : Fock D R) := by
    rw [nordPair_apply_of_le η a (by norm_num : (-1 : ℤ) ≤ 0)]
    exact Finset.sum_congr rfl fun μ _ => by
      rw [mode_zero_apply, map_smul, smul_smul]
  have hs : ∀ j ∉ ({-1, 0} : Finset ℤ), nordPair η a (-1 - j) j (1 : Fock D R) = 0 := by
    intro j hj
    simp only [Finset.mem_insert, Finset.mem_singleton, not_or] at hj
    obtain ⟨h1, h2⟩ := hj
    refine nordPair_apply_eq_zero_of_modeBound_lt η a _ _ ?_
    rw [modeBound_one, Nat.cast_zero]
    omega
  rw [Lop_apply η a (-1) 1 hs, Finset.sum_pair (show (-1 : ℤ) ≠ 0 by norm_num),
    show (-1 : ℤ) - (-1) = 0 by ring, show (-1 : ℤ) - 0 = -1 by ring,
    nordPair_comm η a 0 (-1), hnp, ← two_smul R _, smul_smul, invTwo_mul_two, one_smul]

/-- `L_{-2}|k⟩ = α_{-2} · α_0 |k⟩ + ½ α_{-1} · α_{-1} |k⟩`. -/
lemma Lop_neg_two_apply_one :
    Lop η a (-2) (1 : Fock D R)
      = (∑ μ : Fin D, (η μ * a μ) • mode η a μ (-2) (1 : Fock D R))
        + invTwo R •
          ∑ μ : Fin D, η μ • mode η a μ (-1) (mode η a μ (-1) (1 : Fock D R)) := by
  have hnp1 : nordPair η a (-2) 0 (1 : Fock D R)
      = ∑ μ : Fin D, (η μ * a μ) • mode η a μ (-2) (1 : Fock D R) := by
    rw [nordPair_apply_of_le η a (by norm_num : (-2 : ℤ) ≤ 0)]
    exact Finset.sum_congr rfl fun μ _ => by
      rw [mode_zero_apply, map_smul, smul_smul]
  have hnp2 : nordPair η a (-1) (-1) (1 : Fock D R)
      = ∑ μ : Fin D, η μ • mode η a μ (-1) (mode η a μ (-1) (1 : Fock D R)) :=
    nordPair_apply_of_le η a le_rfl 1
  have hs : ∀ j ∉ ({-2, -1, 0} : Finset ℤ), nordPair η a (-2 - j) j (1 : Fock D R) = 0 := by
    intro j hj
    simp only [Finset.mem_insert, Finset.mem_singleton, not_or] at hj
    obtain ⟨h1, h2, h3⟩ := hj
    refine nordPair_apply_eq_zero_of_modeBound_lt η a _ _ ?_
    rw [modeBound_one, Nat.cast_zero]
    omega
  rw [Lop_apply η a (-2) 1 hs,
    Finset.sum_insert (by norm_num : (-2 : ℤ) ∉ ({-1, 0} : Finset ℤ)),
    Finset.sum_pair (show (-1 : ℤ) ≠ 0 by norm_num),
    show (-2 : ℤ) - (-2) = 0 by ring, show (-2 : ℤ) - (-1) = -1 by ring,
    show (-2 : ℤ) - 0 = -2 by ring, nordPair_comm η a 0 (-2), hnp1, hnp2]
  rw [show ∀ T1 T2 : Fock D R, T1 + (T2 + T1) = (2 : R) • T1 + T2 from fun T1 T2 => by
    rw [two_smul]; abel, smul_add, smul_smul, invTwo_mul_two, one_smul]

omit [Algebra ℚ R] in
lemma sum_eta_sq (hη : ∀ μ, η μ * η μ = 1) : (∑ μ : Fin D, η μ * η μ) = (D : R) := by
  rw [Finset.sum_congr rfl fun μ _ => hη μ]
  simp

lemma Lop_one_apply_Lop_neg_one_apply_one (hη : ∀ μ, η μ * η μ = 1) :
    Lop η a 1 (Lop η a (-1) (1 : Fock D R)) = zeroModeSq η a • (1 : Fock D R) := by
  rw [Lop_neg_one_apply_one, map_sum, zeroModeSq, Finset.sum_smul]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [map_smul, Lop_apply_mode_one η a hη (by norm_num : (0 : ℤ) < 1),
    show (1 : ℤ) + -1 = 0 by ring, mode_zero_apply, smul_smul, smul_smul]
  congr 1
  push_cast
  ring

lemma Lop_two_apply_Lop_neg_two_apply_one (hη : ∀ μ, η μ * η μ = 1) :
    Lop η a 2 (Lop η a (-2) (1 : Fock D R))
      = ((2 : R) * zeroModeSq η a + invTwo R * (D : R)) • (1 : Fock D R) := by
  have hone : ∀ μ : Fin D, Lop η a 2 (mode η a μ (-1) (mode η a μ (-1) (1 : Fock D R)))
      = η μ • (1 : Fock D R) := by
    intro μ
    rw [Lop_apply_mode η a hη 2 μ (-1), show (2 : ℤ) + -1 = 1 by ring,
      Lop_apply_mode_one η a hη (by norm_num : (0 : ℤ) < 2) μ (-1),
      show (2 : ℤ) + -1 = 1 by ring, mode_apply_one_eq_zero η a (by norm_num : (0 : ℤ) < 1),
      smul_zero, map_zero, add_zero, mode_apply_mode η a μ 1 (-1),
      mode_apply_one_eq_zero η a (by norm_num : (0 : ℤ) < 1), map_zero, add_zero,
      if_pos (by ring : (1 : ℤ) + -1 = 0), smul_smul]
    congr 1
    push_cast
    ring
  have hstep : ∀ μ : Fin D,
      Lop η a 2 (η μ • mode η a μ (-1) (mode η a μ (-1) (1 : Fock D R)))
        = (η μ * η μ) • (1 : Fock D R) := fun μ => by rw [map_smul, hone μ, smul_smul]
  rw [Lop_neg_two_apply_one, map_add, map_sum, map_smul, map_sum, add_smul,
    show ((invTwo R * (D : R)) • (1 : Fock D R)) = invTwo R • ((D : R) • (1 : Fock D R)) from
      mul_smul _ _ _]
  congr 1
  · rw [zeroModeSq, Finset.mul_sum, Finset.sum_smul]
    refine Finset.sum_congr rfl fun μ _ => ?_
    rw [map_smul, Lop_apply_mode_one η a hη (by norm_num : (0 : ℤ) < 2),
      show (2 : ℤ) + -2 = 0 by ring, mode_zero_apply, smul_smul, smul_smul]
    congr 1
    push_cast
    ring
  · congr 1
    rw [Finset.sum_congr rfl fun μ _ => hstep μ, ← Finset.sum_smul, sum_eta_sq η hη]

theorem vircoeff_one_neg_one (hη : ∀ μ, η μ * η μ = 1) : vircoeff η a 1 (-1) = 0 := by
  rw [vircoeff_eq, show (1 : ℤ) + -1 = 0 by ring,
    Lop_apply_one_of_pos η a (by norm_num : (0 : ℤ) < 1), map_zero, map_zero,
    Lop_one_apply_Lop_neg_one_apply_one η a hη, Lop_zero_apply_one, constantCoeff_smul,
    constantCoeff_smul, show constantCoeff (1 : Fock D R) = 1 from map_one _]
  push_cast
  linear_combination (-(zeroModeSq η a)) * two_mul_invTwo R

theorem vircoeff_two_neg_two (hη : ∀ μ, η μ * η μ = 1) :
    vircoeff η a 2 (-2) = (D : R) * invTwo R := by
  rw [vircoeff_eq, show (2 : ℤ) + -2 = 0 by ring,
    Lop_apply_one_of_pos η a (by norm_num : (0 : ℤ) < 2), map_zero, map_zero,
    Lop_two_apply_Lop_neg_two_apply_one η a hη, Lop_zero_apply_one, constantCoeff_smul,
    constantCoeff_smul, show constantCoeff (1 : Fock D R) = 1 from map_one _]
  have h4 : (4 : R) * invTwo R = 2 := by
    rw [show (4 : R) = 2 * 2 by ring, mul_assoc, mul_comm (2 : R) (invTwo R), invTwo_mul_two,
      mul_one]
  push_cast
  linear_combination (-(zeroModeSq η a)) * h4

end BaseValues

/-! ### The recursion, and the value of the central charge -/

section CentralCharge

variable [Algebra ℚ R] (η a : Fin D → R)

lemma centralTerm_neg (n : ℤ) :
    Virasoro.centralTerm R (-n) = -Virasoro.centralTerm R n := by
  rw [Virasoro.centralTerm, Virasoro.centralTerm]
  push_cast
  ring

/-- The recursion satisfied by the central term, from the cocycle identity at `(m, 1, -m-1)`
together with `z(1,-1) = 0`. -/
theorem vircoeff_succ (hη : ∀ μ, η μ * η μ = 1) (m : ℤ) :
    ((m : R) - 1) * vircoeff η a (m + 1) (-(m + 1))
      = ((m : R) + 2) * vircoeff η a m (-m) := by
  have hc := vircoeff_cocycle η a hη m 1 (-m - 1)
  rw [show (1 : ℤ) + (-m - 1) = -m by ring, show (-m - 1) + m = -1 by ring,
    show (-m - 1 : ℤ) = -(m + 1) by ring, vircoeff_neg η a m (-m), vircoeff_neg η a 1 (-1),
    vircoeff_one_neg_one η a hη] at hc
  push_cast at hc
  linear_combination hc

/-- **`z(m, -m) = D (m³ - m)/12`**: the central charge of the free-boson Virasoro
representation is `c = D`. -/
theorem vircoeff_diag (hη : ∀ μ, η μ * η μ = 1) (m : ℤ) :
    vircoeff η a m (-m) = (D : R) * Virasoro.centralTerm R m := by
  have key : ∀ k : ℕ, vircoeff η a ((k : ℤ) + 1) (-((k : ℤ) + 1))
        = (D : R) * Virasoro.centralTerm R ((k : ℤ) + 1)
      ∧ vircoeff η a ((k : ℤ) + 2) (-((k : ℤ) + 2))
        = (D : R) * Virasoro.centralTerm R ((k : ℤ) + 2) := by
    intro k
    induction k with
    | zero =>
        refine ⟨?_, ?_⟩
        · simp only [Nat.cast_zero, zero_add]
          rw [vircoeff_one_neg_one η a hη, Virasoro.centralTerm]
          norm_num
        · simp only [Nat.cast_zero, zero_add]
          rw [vircoeff_two_neg_two η a hη, Virasoro.centralTerm,
            show (((2 : ℤ) ^ 3 - 2 : ℤ) : R) = 6 by push_cast; ring]
          linear_combination (-(D : R)) * six_mul_inv12 R
    | succ k ih =>
        have hcast1 : ((k + 1 : ℕ) : ℤ) + 1 = (k : ℤ) + 2 := by push_cast; ring
        have hcast2 : ((k + 1 : ℕ) : ℤ) + 2 = (k : ℤ) + 3 := by push_cast; ring
        refine ⟨by rw [hcast1]; exact ih.2, ?_⟩
        rw [hcast2]
        have hrec := vircoeff_succ η a hη ((k : ℤ) + 2)
        rw [show (k : ℤ) + 2 + 1 = (k : ℤ) + 3 by ring, ih.2] at hrec
        refine (isUnit_intCast R (show (k : ℤ) + 1 ≠ 0 by omega)).mul_left_cancel ?_
        simp only [Virasoro.centralTerm] at hrec ⊢
        push_cast at hrec ⊢
        linear_combination hrec
  have hpos : ∀ j : ℤ, 0 < j → vircoeff η a j (-j) = (D : R) * Virasoro.centralTerm R j := by
    intro j hj
    obtain ⟨k, rfl⟩ : ∃ k : ℕ, j = (k : ℤ) + 1 := ⟨(j - 1).toNat, by omega⟩
    exact (key k).1
  rcases lt_trichotomy m 0 with hm | rfl | hm
  · have h := hpos (-m) (by omega)
    rw [neg_neg, vircoeff_neg η a m (-m), centralTerm_neg] at h
    linear_combination -h
  · rw [neg_zero, vircoeff_self, Virasoro.centralTerm]
    norm_num
  · exact hpos m hm

/-- **The Virasoro relations for the free boson, with central charge `c = D`.**

`[L_m, L_n] = (m - n) L_{m+n} + (D/12) m(m² - 1) δ_{m+n,0}`

(graph node `worldsheet.free-boson-central-charge-d`, convention `conv.virasoro-standard`;
`Virasoro.centralTerm R m = (m³ - m)/12`). -/
theorem lie_Lop_Lop (hη : ∀ μ, η μ * η μ = 1) (m n : ℤ) :
    ⁅Lop η a m, Lop η a n⁆
      = ((m : R) - n) • Lop η a (m + n)
        + (if m + n = 0 then (D : R) * Virasoro.centralTerm R m else 0)
          • (LinearMap.id : Module.End R (Fock D R)) := by
  rw [lie_Lop_Lop_eq η a hη m n]
  congr 1
  by_cases h : m + n = 0
  · rw [if_pos h, show n = -m by omega, vircoeff_diag η a hη]
  · rw [if_neg h, vircoeff_eq_zero_of_add_ne_zero η a hη h]

end CentralCharge

/-! ### The Fock space as a representation of the Virasoro algebra -/

section Representation

open StringFormal.Virasoro

/-- The commutator of `Module.End S M`, as an `S`-bilinear map. -/
noncomputable def endComm (S : Type*) [CommRing S] (M : Type*) [AddCommGroup M] [Module S M] :
    Module.End S M →ₗ[S] Module.End S M →ₗ[S] Module.End S M :=
  LinearMap.mul S (Module.End S M) - (LinearMap.mul S (Module.End S M)).flip

lemma endComm_apply {S : Type*} [CommRing S] {M : Type*} [AddCommGroup M] [Module S M]
    (X Y : Module.End S M) : endComm S M X Y = ⁅X, Y⁆ := by
  rw [endComm, LinearMap.sub_apply, LinearMap.sub_apply, LinearMap.flip_apply,
    LinearMap.mul_apply', LinearMap.mul_apply', LieRing.of_associative_ring_bracket]

variable [Algebra ℚ R] (η a : Fin D → R)

/-- The linear map `ℓ n ↦ L_n` from the Witt algebra to operators on the Fock space. -/
noncomputable def wittRep : WittAlgebra R →ₗ[R] Module.End R (Fock D R) :=
  (WittAlgebra.lgen R).constr R fun n => Lop η a n

@[simp]
lemma wittRep_lgen (n : ℤ) : wittRep η a (WittAlgebra.lgen R n) = Lop η a n := by
  rw [wittRep, Module.Basis.constr_basis]

private noncomputable def bilRep :
    WittAlgebra R →ₗ[R] WittAlgebra R →ₗ[R] Module.End R (Fock D R) :=
  ((endComm R (Fock D R)).compl₂ (wittRep η a)).comp (wittRep η a)

private noncomputable def bilRep' :
    WittAlgebra R →ₗ[R] WittAlgebra R →ₗ[R] Module.End R (Fock D R) :=
  LinearMap.compr₂ (WittAlgebra.bracket R) (wittRep η a)
    + LinearMap.compr₂ (cocycleBilin R)
        (LinearMap.toSpanSingleton R (Module.End R (Fock D R))
          ((D : R) • (LinearMap.id : Module.End R (Fock D R))))

private lemma bilRep_apply (w w' : WittAlgebra R) :
    bilRep η a w w' = ⁅wittRep η a w, wittRep η a w'⁆ := by
  rw [bilRep, LinearMap.comp_apply, LinearMap.compl₂_apply, endComm_apply]

private lemma bilRep'_apply (w w' : WittAlgebra R) :
    bilRep' η a w w'
      = wittRep η a ⁅w, w'⁆
        + (cocycleBilin R w w') • ((D : R) • (LinearMap.id : Module.End R (Fock D R))) := by
  rw [bilRep', LinearMap.add_apply, LinearMap.add_apply, LinearMap.compr₂_apply,
    LinearMap.compr₂_apply, LinearMap.toSpanSingleton_apply, WittAlgebra.lie_def]

/-- **The Sugawara operators represent the Virasoro cocycle.**  On the Witt algebra the
assignment `ℓ n ↦ L_n` fails to be a Lie map exactly by the Virasoro cocycle, multiplied by
the central charge `D`. -/
theorem wittRep_lie (hη : ∀ μ, η μ * η μ = 1) (w w' : WittAlgebra R) :
    ⁅wittRep η a w, wittRep η a w'⁆
      = wittRep η a ⁅w, w'⁆
        + (cocycleBilin R w w') • ((D : R) • (LinearMap.id : Module.End R (Fock D R))) := by
  have key : bilRep η a = bilRep' η a := by
    apply LinearMap.ext_basis (WittAlgebra.lgen R) (WittAlgebra.lgen R)
    intro n m
    rw [bilRep_apply, bilRep'_apply, wittRep_lgen, wittRep_lgen, lie_Lop_Lop η a hη,
      WittAlgebra.lie_lgen_lgen, map_smul, wittRep_lgen, cocycleBilin_lgen_lgen, smul_smul]
    congr 1
    congr 1
    by_cases h : n + m = 0
    · rw [if_pos h, if_pos h, mul_comm]
    · rw [if_neg h, if_neg h, zero_mul]
  rw [← bilRep_apply, key, bilRep'_apply]

/-- The central component `X ↦ (toProd X).2` of the Virasoro algebra, as a linear map. -/
noncomputable def centralPart : VirasoroAlgebra R →ₗ[R] R where
  toFun X := (VirasoroAlgebra.toProd R X).2
  map_add' X Y := by rw [VirasoroAlgebra.toProd_add]; rfl
  map_smul' c X := by rw [VirasoroAlgebra.toProd_smul]; rfl

@[simp] lemma centralPart_apply (X : VirasoroAlgebra R) :
    centralPart X = (VirasoroAlgebra.toProd R X).2 := rfl

/-- The linear map `VirasoroAlgebra R → Module.End R (Fock D R)` sending `L n` to the Sugawara
operator `L_n` and the central element `C` to `D · id`. -/
noncomputable def virRep : VirasoroAlgebra R →ₗ[R] Module.End R (Fock D R) :=
  (wittRep η a).comp (VirasoroAlgebra.toWitt R).toLinearMap
    + (LinearMap.toSpanSingleton R (Module.End R (Fock D R))
        ((D : R) • (LinearMap.id : Module.End R (Fock D R)))).comp
      (centralPart (R := R))

lemma virRep_apply (X : VirasoroAlgebra R) :
    virRep η a X
      = wittRep η a (VirasoroAlgebra.toWitt R X)
        + (VirasoroAlgebra.toProd R X).2
          • ((D : R) • (LinearMap.id : Module.End R (Fock D R))) := by
  rw [virRep, LinearMap.add_apply, LinearMap.comp_apply, LinearMap.comp_apply,
    LinearMap.toSpanSingleton_apply, centralPart_apply]
  rfl

@[simp]
lemma virRep_lgen (n : ℤ) : virRep η a (VirasoroAlgebra.lgen R n) = Lop η a n := by
  rw [virRep_apply, VirasoroAlgebra.toWitt_lgen, wittRep_lgen, VirasoroAlgebra.toProd_lgen,
    zero_smul, add_zero]

@[simp]
lemma virRep_cgen :
    virRep η a (VirasoroAlgebra.cgen R)
      = (D : R) • (LinearMap.id : Module.End R (Fock D R)) := by
  rw [virRep_apply, VirasoroAlgebra.toWitt_cgen, map_zero, VirasoroAlgebra.toProd_cgen,
    one_smul, zero_add]

/-- **The Fock space of `D` free bosons is a representation of the Virasoro algebra with
central charge `c = D`** (graph nodes `worldsheet.virasoro-generators-free-boson` and
`worldsheet.free-boson-central-charge-d`): `virRep` is `R`-linear (by construction),
sends `L n ↦ L_n` and `C ↦ D · id` (`virRep_lgen`, `virRep_cgen`) and preserves the Lie
bracket.

This is the homomorphism property of a Lie algebra map; it is *not* bundled as a `LieHom`
because Mathlib `v4.33.1` makes `Module.End R M` a `LieRing` only through a `local instance`
(`LieRing.ofAssociativeRing`), so the bundled type is not available outside that file. -/
theorem virRep_lie (hη : ∀ μ, η μ * η μ = 1) (X Y : VirasoroAlgebra R) :
    virRep η a ⁅X, Y⁆ = ⁅virRep η a X, virRep η a Y⁆ := by
  have hw : VirasoroAlgebra.toWitt R ⁅X, Y⁆
      = ⁅VirasoroAlgebra.toWitt R X, VirasoroAlgebra.toWitt R Y⁆ :=
    LieHom.map_lie (VirasoroAlgebra.toWitt R) X Y
  have hs : (VirasoroAlgebra.toProd R ⁅X, Y⁆).2
      = cocycleBilin R (VirasoroAlgebra.toWitt R X) (VirasoroAlgebra.toWitt R Y) := by
    rw [VirasoroAlgebra.toProd_lie]
    simp
  rw [virRep_apply, virRep_apply, virRep_apply, hw, hs, ← wittRep_lie η a hη,
    smul_smul, smul_smul, lie_add_left, lie_add_right, lie_add_right]
  simp only [lie_smul_id_left, lie_smul_id_right, add_zero]

end Representation

/-! ### `L_0` and the level grading -/

section LevelZero

variable [Algebra ℚ R] (η a : Fin D → R)

omit [Algebra ℚ R] in
lemma single_add_tsub_single {d : Osc D →₀ ℕ} {v : Osc D} (hv : d v ≠ 0) :
    Finsupp.single v 1 + (d - Finsupp.single v 1) = d := by
  classical
  refine Finsupp.ext fun u => ?_
  by_cases hu : u = v
  · subst hu
    simp only [Finsupp.add_apply, Finsupp.single_eq_same, Finsupp.tsub_apply]
    omega
  · have hz : (Finsupp.single v 1 : Osc D →₀ ℕ) u = 0 := Finsupp.single_eq_of_ne hu
    rw [Finsupp.add_apply, hz, zero_add, Finsupp.tsub_apply, hz, Nat.sub_zero]

/-- `L_0` acts on a monomial by `α' k² + N`, where `N` is its level.  (With
`a^μ = (2α')^{1/2} k^μ` one has `½ α_0² = α' k²`; see `zeroModeSq`.) -/
theorem Lop_zero_apply_monomial (hη : ∀ μ, η μ * η μ = 1) (d : Osc D →₀ ℕ) (c : R) :
    Lop η a 0 (monomial d c)
      = (invTwo R * zeroModeSq η a + ((level D d : ℕ) : R)) • (monomial d c : Fock D R) := by
  classical
  suffices h : ∀ N : ℕ, ∀ d : Osc D →₀ ℕ, level D d = N → ∀ c : R,
      Lop η a 0 (monomial d c)
        = (invTwo R * zeroModeSq η a + ((level D d : ℕ) : R)) • (monomial d c : Fock D R) from
    h _ d rfl c
  intro N
  induction N using Nat.strong_induction_on with
  | _ N ih =>
    intro d hd c
    by_cases hd0 : d = 0
    · subst hd0
      have h1 : (monomial (0 : Osc D →₀ ℕ) c : Fock D R) = c • 1 := by
        rw [monomial_zero', smul_eq_C_mul, mul_one]
      rw [h1, map_smul, Lop_zero_apply_one, level_zero, Nat.cast_zero, add_zero, smul_smul,
        smul_smul]
      congr 1
      ring
    · obtain ⟨v, hv⟩ : ∃ v : Osc D, d v ≠ 0 := by
        by_contra hc
        exact hd0 (Finsupp.ext fun v => by simpa using not_not.mp (not_exists.mp hc v))
      obtain ⟨μ, n⟩ := v
      set e : Osc D →₀ ℕ := d - Finsupp.single ((μ, n) : Osc D) 1 with he
      have hsplit : Finsupp.single ((μ, n) : Osc D) 1 + e = d := single_add_tsub_single hv
      have hlev : level D d = (n : ℕ) + level D e := by
        rw [← hsplit, level_add, level_single]
        simp
      have hmono : (monomial d c : Fock D R)
          = mode η a μ (-((n : ℕ) : ℤ)) (monomial e c) := by
        rw [mode_neg_pnat, creation_apply, ← hsplit, monomial_single_add, pow_one]
      have hn : 0 < (n : ℕ) := n.2
      have hlt : level D e < N := by omega
      rw [hmono, Lop_apply_mode η a hη 0 μ (-((n : ℕ) : ℤ)), zero_add,
        ih (level D e) hlt e rfl c, map_smul, ← add_smul]
      congr 1
      rw [hlev]
      push_cast
      ring

/-- **`L_0 = α' k² + N` on the level-`N` piece of the Fock space** (`a^X = 0`: there is no
normal-ordering constant in this convention). -/
theorem Lop_zero_apply_of_mem_levelSubmodule (hη : ∀ μ, η μ * η μ = 1) {N : ℕ}
    {P : Fock D R} (hP : P ∈ levelSubmodule D R N) :
    Lop η a 0 P = (invTwo R * zeroModeSq η a + (N : R)) • P := by
  classical
  conv_lhs => rw [P.as_sum]
  conv_rhs => rw [P.as_sum]
  rw [map_sum, Finset.smul_sum]
  refine Finset.sum_congr rfl fun d hd => ?_
  have hlv : level D d = N := hP (mem_support_iff.mp hd)
  rw [Lop_zero_apply_monomial η a hη, hlv]

end LevelZero

end Fock

end StringFormal.NoGhost
