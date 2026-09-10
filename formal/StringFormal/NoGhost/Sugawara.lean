/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import Mathlib.Algebra.MvPolynomial.Derivation
import Mathlib.Data.Int.Interval
import Mathlib.Tactic.NoncommRing
import StringFormal.NoGhost.Fock
import StringFormal.Virasoro.Basic

/-!
# The Sugawara construction on the free-boson Fock space

Work in progress; see `formal/TODO.md` item `sugawara`.
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

end Fock

end StringFormal.NoGhost
