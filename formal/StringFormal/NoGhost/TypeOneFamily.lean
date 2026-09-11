/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.SpuriousElimination
import StringFormal.NoGhost.NullSeedsTwo
import StringFormal.Virasoro.VermaPBW

/-!
# The Type-1 family: a `D`-independent lower bound on the null states (blueprint §B‴ PR6′)

Graph nodes: `worldsheet.ddf-spanning-hypothesis` (the consumer, through
`NoGhost/SliceRank.lean`'s `B26`), `worldsheet.gt-longitudinal-k-algebra` (the `K`-algebra
input).  Blueprint `formal/BLUEPRINT-noghost.md` §B‴.9 (PR6′) and §B‴.12.

**`D = 26` occurs nowhere in this file.**  The intercept `a₀ = 1` (`k·k = 2`) enters only in
the last theorem, through the Type-1 null lemma of `NoGhost/NullSeedsTwo.lean`.

## Main results

* `towerLop_neg_one_injective` — **`L_{-1}` is injective on every bigraded piece `(j, M)`**.
  Only the `K`-algebra is used: `⁅L_{-1}, K_1⁆ = -K_0 = -1` gives
  `L_{-1} K_1^{k+1} x = -(k+1) K_1^k x` for `L_{-1} x = 0`, and `K_1^{M+1} x = 0` on level `M`
  forces `x = 0` by descent.  Needs only a `ℚ`-algebra (no `CharZero` hypothesis).
-/

namespace StringFormal.NoGhost

open MvPolynomial

/-! ### A `ℚ`-algebra has no `ℕ`-torsion in its modules -/

section RatTorsion

/-- Over a `ℚ`-algebra, `k • y = 0` with `k ≠ 0` a natural number forces `y = 0`. -/
lemma eq_zero_of_natCast_smul_eq_zero {R : Type*} [CommRing R] [Algebra ℚ R] {W : Type*}
    [AddCommGroup W] [Module R W] {k : ℕ} (hk : k ≠ 0) {y : W} (h : (k : R) • y = 0) :
    y = 0 := by
  have hunit : algebraMap ℚ R ((k : ℚ)⁻¹) * (k : R) = 1 := by
    rw [← map_natCast (algebraMap ℚ R) k, ← map_mul,
      inv_mul_cancel₀ (by exact_mod_cast hk), map_one]
  calc y = (algebraMap ℚ R ((k : ℚ)⁻¹) * (k : R)) • y := by rw [hunit, one_smul]
    _ = algebraMap ℚ R ((k : ℚ)⁻¹) • ((k : R) • y) := mul_smul _ _ _
    _ = 0 := by rw [h, smul_zero]

end RatTorsion

/-! ### `K_1` is homogeneous for the bigrading -/

section ModeVecBigrade

variable {D : ℕ} {R : Type*} [CommRing R]

/-- **A polarised mode has bidegree `(0, -m)`**: `α^w_m` preserves the rung and lowers the
oscillator level by `m`.  (Compare `Glue.towerLop_mem_towerBigrade` for `L_m`.) -/
theorem towerModeVec_mem_towerBigrade (η a b w : Fin D → R) {j : ℤ} {N : ℕ}
    {x : TowerFock D R} (hx : x ∈ towerBigrade D R j N) {m : ℤ} {N' : ℕ}
    (hN' : (N' : ℤ) = (N : ℤ) - m) :
    towerModeVec η a b w m x ∈ towerBigrade D R j N' := by
  obtain ⟨hx1, hx2⟩ := mem_towerBigrade.1 hx
  rw [hx1, towerModeVec, LinearMap.sum_apply]
  refine Submodule.sum_mem _ fun μ _ => ?_
  rw [LinearMap.smul_apply, towerMode_single]
  exact Submodule.smul_mem _ _
    (single_mem_towerBigrade (Fock.mode_mem_levelSubmodule η _ hx2 hN' μ))

/-- A polarised mode of index above the level kills the slice. -/
theorem towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt (η a b w : Fin D → R) {j : ℤ}
    {N : ℕ} {x : TowerFock D R} (hx : x ∈ towerBigrade D R j N) {m : ℤ} (hm : (N : ℤ) < m) :
    towerModeVec η a b w m x = 0 := by
  obtain ⟨hx1, hx2⟩ := mem_towerBigrade.1 hx
  rw [hx1, towerModeVec, LinearMap.sum_apply]
  refine Finset.sum_eq_zero fun μ _ => ?_
  rw [LinearMap.smul_apply, towerMode_single, Fock.mode_apply_eq_zero_of_level_lt η _ hx2 hm μ,
    Finsupp.single_zero, smul_zero]

end ModeVecBigrade

/-! ### `L_{-1}` is injective on each bigraded piece -/

section LopNegOneInjective

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] (η a b : Fin D → R)
variable (hη : ∀ μ, η μ * η μ = 1) (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1)

include hη hbb hba in
/-- `L_{-1} K_1 v = K_1 L_{-1} v - v`: the `K`-algebra relation `⁅L_{-1}, K_1⁆ = -K_0` with
`K_0 = 1` (blueprint §B‴.9, the "three lines"). -/
lemma towerLop_neg_one_apply_kOp_one (v : TowerFock D R) :
    towerLop η a b (-1) (kOp η a b 1 v) = kOp η a b 1 (towerLop η a b (-1) v) - v := by
  have h := congrArg (fun T : Module.End R (TowerFock D R) => T v)
    (lie_towerLop_kOp η a b hη (-1) 1)
  simp only [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
    LinearMap.smul_apply] at h
  rw [show (-1 : ℤ) + 1 = 0 by norm_num, kOp_zero_eq_one η a b hbb hba,
    Module.End.one_apply, Int.cast_one, neg_smul, one_smul] at h
  rw [sub_eq_iff_eq_add] at h
  rw [h, sub_eq_add_neg, add_comm]

include hη hbb hba in
/-- `L_{-1} K_1^{k+1} x = -(k+1) • K_1^k x` whenever `L_{-1} x = 0`. -/
lemma towerLop_neg_one_apply_kOp_one_pow {x : TowerFock D R}
    (hx : towerLop η a b (-1) x = 0) (k : ℕ) :
    towerLop η a b (-1) ((kOp η a b 1 ^ (k + 1)) x)
      = (-((k + 1 : ℕ) : R)) • (kOp η a b 1 ^ k) x := by
  induction k with
  | zero =>
      rw [pow_one, pow_zero, Module.End.one_apply, towerLop_neg_one_apply_kOp_one η a b hη hbb hba,
        hx, map_zero, zero_sub]
      simp
  | succ k ih =>
      rw [pow_succ', Module.End.mul_apply, towerLop_neg_one_apply_kOp_one η a b hη hbb hba, ih,
        map_smul, pow_succ' (kOp η a b 1) k, Module.End.mul_apply, sub_eq_add_neg,
        ← neg_one_smul R (kOp η a b 1 ((kOp η a b 1 ^ k) x)), ← add_smul]
      congr 1
      push_cast
      ring

include hη hbb hba in
/-- **`L_{-1}` is injective on every bigraded piece** (blueprint §B‴.9's
`towerLop_neg_one_injective`).

With `x_k := K_1^k x` the previous lemma gives `L_{-1} x_{k+1} = -(k+1) x_k`; since `K_1`
lowers the level by one, `x_{M+1} = 0` on the piece `(j, M)`, and descending through
`x_M, x_{M-1}, …, x_0 = x` (each step dividing by a non-zero natural number, possible in a
`ℚ`-algebra) gives `x = 0`.  `D` does not appear, nor does the intercept. -/
theorem towerLop_neg_one_injective {j : ℤ} {M : ℕ} {x : TowerFock D R}
    (hx : x ∈ towerBigrade D R j M) (h : towerLop η a b (-1) x = 0) : x = 0 := by
  have hmem : ∀ k, k ≤ M → (kOp η a b 1 ^ k) x ∈ towerBigrade D R j (M - k) := by
    intro k
    induction k with
    | zero => intro _; simpa using hx
    | succ k ih =>
        intro hk
        rw [pow_succ', Module.End.mul_apply, kOp_eq_towerModeVec]
        exact towerModeVec_mem_towerBigrade η a b b (ih (by omega)) (by omega)
  have htop : (kOp η a b 1 ^ (M + 1)) x = 0 := by
    rw [pow_succ', Module.End.mul_apply, kOp_eq_towerModeVec]
    exact towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b b (hmem M le_rfl)
      (by simp)
  have hdesc : ∀ i, i ≤ M + 1 → (kOp η a b 1 ^ (M + 1 - i)) x = 0 := by
    intro i
    induction i with
    | zero => intro _; simpa using htop
    | succ i ih =>
        intro hi
        have h1 := ih (by omega)
        rw [show M + 1 - i = (M - i) + 1 by omega] at h1
        have h2 := towerLop_neg_one_apply_kOp_one_pow η a b hη hbb hba h (M - i)
        rw [h1, map_zero, neg_smul, eq_comm, neg_eq_zero] at h2
        rw [show M + 1 - (i + 1) = M - i by omega]
        exact eq_zero_of_natCast_smul_eq_zero (Nat.succ_ne_zero _) h2
  have := hdesc (M + 1) le_rfl
  rwa [Nat.sub_self, pow_zero, Module.End.one_apply] at this

end LopNegOneInjective

end StringFormal.NoGhost
