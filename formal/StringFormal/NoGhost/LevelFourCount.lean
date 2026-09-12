/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.LevelThreeCount

/-!
# The level-four antidiagonal slice

Blueprint `formal/BLUEPRINT-noghost.md` §B‴ 订正 item 5.  On the slice `(rung -4, level 4)` the
counting gap left open by `TypeOneFamily.le_finrank_towerNull_inf_towerBigrade_succ` is

`p_{D−1}(4) − p_{D−2}(4) − p_{D−1}(3) = p_{D−1}(2)`,

and the missing null states are the `𝒟₂`-images of the *level-two* quasi-physical seeds on
rung `-4`.  So the level-four account needs the two families `L_{-1} Q_{-4,3}` and
`𝒟₂ Q_{-4,2}` to be independent — the **transversality** statement — and the counting identity
`p_{D−1}(4) = p_{D−2}(4) + p_{D−1}(3) + p_{D−1}(2)`.

## The transversality argument

`LevelThreeCount`'s separator (the antisymmetrised `α_{-2}α_{-1}` coefficient) does **not**
carry over: with `φ` of level three `A_ε(3)φ ≠ 0`, and the `α_{-2}α_{-1}` tensor of a level-four
state has no symmetry.  Following the blueprint we instead push the moments onto *three*
annihilation operators.  Writing `A_ε(p) = towerModeVec η a b ε p` and `p = p_j`, for
`L_{-1}φ + 𝒟₂ψ = 0` with `φ ∈ V_{j,3}`, `ψ ∈ V_{j,2}` the four moment equations are

```
A_ε(4)             :  4 a_ε + 44 m_ε = 0
A_ε(3)A_δ(1)       :  3 b_{εδ} + (δ·p) a_ε + 24 n_{εδ} + 18 (δ·p) m_ε = 0
A_ε(2)A_δ(2)       :  2(b_{εδ}+b_{δε}) + 10(ε·p)m_δ + 10(δ·p)m_ε + 24 n_{εδ} = 0
A_ε(2)A_δ(1)A_ρ(1) :  2 c_{εδρ} + (δ·p)b_{ερ} + (ρ·p)b_{εδ}
                      + 10(ε·p)n_{δρ} + 12(δ·p)n_{ερ} + 12(ρ·p)n_{εδ}
                      + 2(δ·ρ)m_ε + 6(δ·p)(ρ·p)m_ε = 0
```

with `a_ε = A_ε(3)φ`, `b_{εδ} = A_ε(2)A_δ(1)φ`, `c_{εδρ} = A_ε(1)A_δ(1)A_ρ(1)φ` (totally
symmetric), `m_ε = A_ε(2)ψ`, `n_{εδ} = A_ε(1)A_δ(1)ψ` (symmetric).  Antisymmetrising the last
one in `ε ↔ δ` kills `c` and `n`, and after eliminating `a` and `b` leaves

`−(8/3)(ρ·p)[(δ·p)m_ε − (ε·p)m_δ] + 2[(δ·ρ)m_ε − (ε·ρ)m_δ] = 0`.

Taking `ρ := p` the coefficient is `2 − (8/3)p²`, which at `p_{-4}·p_{-4} = −6` is `18 ≠ 0`;
so `m ≡ 0`, hence `n ≡ 0`, and then the moment-nondegeneracy lemma of the first section gives
`ψ = 0` and `L_{-1}` injectivity gives `φ = 0`.  As in `LevelThreeCount`, **`D` and physicality
never enter the transversality argument**; the only hypotheses are `p·p ≠ 0` and
`2 − (8/3)p² ≠ 0` (`3 ≤ D` is used once, to have a transverse polarisation with `ε·ε = 1`).

## Status

No `sorry`.  See the section headers for what is and is not proved.
-/

namespace StringFormal.NoGhost

open Module

/-! ### Moments determine a state

`A_ε(p) x = 0` for all polarisations `ε` and all `p ≥ 1` forces `x = 0` on any slice of positive
level.  The mechanism is completely elementary: a polarised mode with `ε = e_ν` is `η_ν` times
the Fock annihilation operator `α^ν_n = n η_ν ∂/∂X_{(ν,n)}`, so the hypothesis says every partial
derivative of the polynomial vanishes, and `Fock.coeff_annihilation` turns that into "every
coefficient with nonzero exponent vanishes".  Positive level removes the constant term. -/

section MomentsDetermine

variable {D : ℕ} {R : Type*} [CommRing R]

/-- Peeling one unit off an exponent vector, in the form `Fock.coeff_annihilation` wants. -/
private lemma update_add_single {ι : Type*} [DecidableEq ι] {e : ι →₀ ℕ} {v : ι}
    (hv : 1 ≤ e v) : Finsupp.update e v (e v - 1) + Finsupp.single v 1 = e := by
  refine Finsupp.ext fun x => ?_
  rw [Finsupp.add_apply, Finsupp.single_apply, Finsupp.update_apply]
  by_cases hx : x = v
  · rw [if_pos hx, if_pos hx.symm, hx]; omega
  · rw [if_neg hx, if_neg fun hc => hx hc.symm]; omega

variable [NoZeroDivisors R] [CharZero R]

/-- The one-oscillator normalisation `n η^{μμ}` is never zero in characteristic zero.  (This is
the single factor of `Fock.monomialNorm_ne_zero`, isolated for reuse.) -/
lemma Fock.oscWeight_ne_zero {η : Fin D → R} (hη : ∀ μ, η μ * η μ = 1) (v : Osc D) :
    Fock.oscWeight η v ≠ 0 := by
  refine mul_ne_zero (Nat.cast_ne_zero.mpr v.2.ne_zero) fun hz => ?_
  have h := hη v.1
  rw [hz, mul_zero] at h
  exact one_ne_zero h.symm

/-- **Moments determine a Fock state.**  A polynomial of level `N ≥ 1` annihilated by every
`α^μ_n` (`n ≥ 1`) is zero. -/
theorem Fock.eq_zero_of_annihilation_eq_zero {η : Fin D → R} (hη : ∀ μ, η μ * η μ = 1)
    {N : ℕ} (hN : N ≠ 0) {P : Fock D R} (hP : P ∈ Fock.levelSubmodule D R N)
    (h : ∀ (μ : Fin D) (n : ℕ+), Fock.annihilation η μ n P = 0) : P = 0 := by
  classical
  refine MvPolynomial.ext _ _ fun e => ?_
  rw [MvPolynomial.coeff_zero]
  rcases eq_or_ne e 0 with rfl | he
  · by_contra hc
    have hlev := (Fock.mem_levelSubmodule D R N P).1 hP hc
    rw [Fock.level, map_zero] at hlev
    exact hN hlev.symm
  · obtain ⟨v, hv⟩ : ∃ v, v ∈ e.support := by
      by_contra hcon
      push_neg at hcon
      exact he (Finsupp.ext fun u => Finsupp.notMem_support_iff.1 (hcon u))
    have hev : 1 ≤ e v := Nat.one_le_iff_ne_zero.2 (Finsupp.mem_support_iff.1 hv)
    have hkey := Fock.coeff_annihilation η v.1 v.2 P (Finsupp.update e v (e v - 1))
    rw [h v.1 v.2, MvPolynomial.coeff_zero] at hkey
    rw [show ((v.1, v.2) : Osc D) = v from rfl, update_add_single hev,
      Finsupp.update_apply, if_pos rfl] at hkey
    have hcast : ((e v - 1 : ℕ) : R) + 1 = ((e v : ℕ) : R) := by
      have : (e v - 1) + 1 = e v := by omega
      rw [← this]
      push_cast
      ring
    rw [hcast] at hkey
    have h1 := (mul_eq_zero.mp hkey.symm).resolve_left (Fock.oscWeight_ne_zero hη v)
    exact (mul_eq_zero.mp h1).resolve_right (Nat.cast_ne_zero.mpr (by omega))

/-- A polarised mode with `ε = e_ν` is `η_ν` times the plain mode `α^ν_p`. -/
lemma towerModeVec_pi_single (η a b : Fin D → R) (ν : Fin D) (p : ℤ) :
    towerModeVec η a b (Pi.single ν 1) p = η ν • towerMode η a b ν p := by
  classical
  rw [towerModeVec]
  refine (Finset.sum_eq_single_of_mem ν (Finset.mem_univ ν) ?_).trans ?_
  · intro μ _ hμ
    rw [Pi.single_apply, if_neg hμ, mul_zero, zero_smul]
  · rw [Pi.single_apply, if_pos rfl, mul_one]

/-- The plain mode at a positive integer index is the annihilation operator. -/
lemma towerMode_natCast_single (η a b : Fin D → R) (ν : Fin D) (n : ℕ+) (j : ℤ)
    (P : Fock D R) :
    towerMode η a b ν ((n : ℕ) : ℤ) (Finsupp.single j P)
      = Finsupp.single j (Fock.annihilation η ν n P) := by
  have hn : (((n : ℕ) : ℤ)).toNat.toPNat' = n := by
    refine PNat.coe_injective ?_
    rw [Int.toNat_natCast, Nat.toPNat'_coe, if_pos n.pos]
  rw [towerMode_single, Fock.mode_of_pos _ _ (by exact_mod_cast n.pos), hn]

/-- **Moments determine a state on a slice.**  If every polarised mode `A_ε(p)` with `p ≥ 1`
kills `x` and `x` lives on a slice of positive level, then `x = 0`.

This is the nondegeneracy input of the level-four transversality argument (blueprint §B‴ 订正
item 5, lemma (A)); it is stated for an arbitrary rung and an arbitrary positive level. -/
theorem eq_zero_of_towerModeVec_eq_zero {η a b : Fin D → R} (hη : ∀ μ, η μ * η μ = 1)
    {j : ℤ} {N : ℕ} (hN : N ≠ 0) {x : TowerFock D R} (hx : x ∈ towerBigrade D R j N)
    (h : ∀ (ε : Fin D → R) (p : ℤ), 0 < p → towerModeVec η a b ε p x = 0) : x = 0 := by
  obtain ⟨hsing, hlev⟩ := mem_towerBigrade.1 hx
  have hxj : x j = 0 := by
    refine Fock.eq_zero_of_annihilation_eq_zero hη hN hlev fun ν n => ?_
    have hpos : (0 : ℤ) < ((n : ℕ) : ℤ) := by exact_mod_cast n.pos
    have h0 := h (Pi.single ν 1) ((n : ℕ) : ℤ) hpos
    rw [towerModeVec_pi_single, LinearMap.smul_apply] at h0
    have h1 : towerMode η a b ν ((n : ℕ) : ℤ) x = 0 := by
      have := congrArg (fun y => η ν • y) h0
      simpa [smul_smul, hη ν] using this
    rw [hsing, towerMode_natCast_single] at h1
    exact (Finsupp.single_eq_zero).1 h1
  rw [hsing, hxj, Finsupp.single_zero]

end MomentsDetermine

/-! ### The four moment functionals at level four

`A_ε(4)`, `A_ε(3)A_δ(1)`, `A_ε(2)A_δ(2)` and `A_ε(2)A_δ(1)A_ρ(1)`, evaluated on the Type-1
family `L_{-1} V_{j,3}` and the Type-2 family `𝒟₂ V_{j,2}`.  Everything is commutator algebra,
using `LevelThreeCount`'s toolbox plus two new atoms: the `A_ε(2) 𝒟₂` evaluation on a level-zero
state, and the *central* commutator `⁅A_δ(1), A_ρ(-1)⁆ = (δ·ρ)`, which is the only place where
the `α`-algebra's central term enters the level-four account. -/

section MomentEquations

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] {η a b ε δ ρ : Fin D → R}

/-- `A_ε(2) 𝒟₂ z = 10 (ε·p_j) z` for `z` of level zero. -/
lemma towerModeVec_two_descTwo_of_level_zero (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    {z : TowerFock D R} (hz : z ∈ towerBigrade D R j 0) :
    towerModeVec η a b ε 2 (descTwo η a b z)
      = ((10 : R) * dotVec η ε (towerMomentum a b j)) • z := by
  rw [towerModeVec_two_descTwo hη hz,
    towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hz (by norm_num),
    towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hz
      (show ((0 : ℕ) : ℤ) < 1 by norm_num),
    map_zero, map_zero, smul_zero, zero_add, zero_add]

/-- **The central term**: `A_δ(1) A_ρ(-1) x = A_ρ(-1) A_δ(1) x + (δ·ρ) x`.  This is the only
appearance of the oscillator central charge in the level-four moment equations. -/
lemma towerModeVec_one_apply_towerModeVec_neg_one (η a b : Fin D → R)
    (hη : ∀ μ, η μ * η μ = 1) (x : TowerFock D R) :
    towerModeVec η a b δ 1 (towerModeVec η a b ρ (-1) x)
      = towerModeVec η a b ρ (-1) (towerModeVec η a b δ 1 x) + dotVec η δ ρ • x := by
  have h := congrArg (fun T : Module.End R (TowerFock D R) => T x)
    (lie_towerModeVec_towerModeVec η a b δ ρ hη 1 (-1))
  simp only [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
    LinearMap.smul_apply, LinearMap.id_coe, id_eq, if_pos (show (1 : ℤ) + (-1) = 0 by ring),
    Int.cast_one, one_mul] at h
  rw [sub_eq_iff_eq_add'.mp h]

/-- `A_ε(3) L_{-1} ψ = 3 A_ε(2) ψ` for `ψ` of level two. -/
lemma towerModeVec_three_towerLop_neg_one_of_level_two (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    {ψ : TowerFock D R} (hψ : ψ ∈ towerBigrade D R j 2) :
    towerModeVec η a b ε 3 (towerLop η a b (-1) ψ) = (3 : R) • towerModeVec η a b ε 2 ψ := by
  rw [towerModeVec_apply_towerLop η a b ε hη (-1) 3,
    towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hψ (by norm_num), map_zero,
    zero_add, show (-1 : ℤ) + 3 = 2 by ring]
  norm_num

/-! #### `A_ε(4)` -/

/-- `A_ε(4) L_{-1} φ = 4 A_ε(3) φ` for `φ` of level three. -/
theorem towerModeVec_four_towerLop_neg_one (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    {φ : TowerFock D R} (hφ : φ ∈ towerBigrade D R j 3) :
    towerModeVec η a b ε 4 (towerLop η a b (-1) φ) = (4 : R) • towerModeVec η a b ε 3 φ := by
  rw [towerModeVec_apply_towerLop η a b ε hη (-1) 4,
    towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hφ (by norm_num), map_zero,
    zero_add, show (-1 : ℤ) + 4 = 3 by ring]
  norm_num

/-- `A_ε(4) 𝒟₂ ψ = 44 A_ε(2) ψ` for `ψ` of level two. -/
theorem towerModeVec_four_descTwo (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    {ψ : TowerFock D R} (hψ : ψ ∈ towerBigrade D R j 2) :
    towerModeVec η a b ε 4 (descTwo η a b ψ) = (44 : R) • towerModeVec η a b ε 2 ψ := by
  have hψ3 : towerLop η a b (-1) ψ ∈ towerBigrade D R j 3 :=
    towerLop_mem_towerBigrade η a b hψ (by norm_num)
  have hL2 : towerModeVec η a b ε 4 (towerLop η a b (-2) ψ)
      = (4 : R) • towerModeVec η a b ε 2 ψ := by
    rw [towerModeVec_apply_towerLop η a b ε hη (-2) 4,
      towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hψ (by norm_num), map_zero,
      zero_add, show (-2 : ℤ) + 4 = 2 by ring]
    norm_num
  have hL11 : towerModeVec η a b ε 4 (towerLop η a b (-1) (towerLop η a b (-1) ψ))
      = (12 : R) • towerModeVec η a b ε 2 ψ := by
    rw [towerModeVec_apply_towerLop η a b ε hη (-1) 4,
      towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hψ3 (by norm_num), map_zero,
      zero_add, show (-1 : ℤ) + 4 = 3 by ring,
      towerModeVec_three_towerLop_neg_one_of_level_two hη hψ, smul_smul]
    norm_num
  rw [descTwo_apply, map_add, map_smul, map_smul, hL2, hL11, smul_smul, smul_smul, ← add_smul]
  norm_num

/-! #### `A_ε(3) A_δ(1)` -/

/-- `A_ε(3) A_δ(1) L_{-1} φ = 3 A_ε(2) A_δ(1) φ + (δ·p_j) A_ε(3) φ` for `φ` of level three. -/
theorem towerModeVec_three_one_towerLop_neg_one (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    {φ : TowerFock D R} (hφ : φ ∈ towerBigrade D R j 3) :
    towerModeVec η a b ε 3 (towerModeVec η a b δ 1 (towerLop η a b (-1) φ))
      = (3 : R) • towerModeVec η a b ε 2 (towerModeVec η a b δ 1 φ)
        + dotVec η δ (towerMomentum a b j) • towerModeVec η a b ε 3 φ := by
  have hφ1 : towerModeVec η a b δ 1 φ ∈ towerBigrade D R j 2 :=
    towerModeVec_mem_towerBigrade η a b δ hφ (by norm_num)
  rw [towerModeVec_one_towerLop_neg_one hη hφ, map_add, map_smul,
    towerModeVec_three_towerLop_neg_one_of_level_two hη hφ1]

/-- `A_ε(3) A_δ(1) 𝒟₂ ψ = 24 A_ε(1) A_δ(1) ψ + 18 (δ·p_j) A_ε(2) ψ` for `ψ` of level two. -/
theorem towerModeVec_three_one_descTwo (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    {ψ : TowerFock D R} (hψ : ψ ∈ towerBigrade D R j 2) :
    towerModeVec η a b ε 3 (towerModeVec η a b δ 1 (descTwo η a b ψ))
      = (24 : R) • towerModeVec η a b ε 1 (towerModeVec η a b δ 1 ψ)
        + ((18 : R) * dotVec η δ (towerMomentum a b j)) • towerModeVec η a b ε 2 ψ := by
  have hψ1 : towerModeVec η a b δ 1 ψ ∈ towerBigrade D R j 1 :=
    towerModeVec_mem_towerBigrade η a b δ hψ (by norm_num)
  have hmid : towerModeVec η a b ε 3 (towerModeVec η a b δ (-1) ψ) = 0 := by
    rw [towerModeVec_apply_towerModeVec_of_add_ne_zero η a b ε δ hη (by norm_num),
      towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hψ (by norm_num), map_zero]
  rw [towerModeVec_one_descTwo hη hψ, map_add, map_add, map_smul, map_smul, hmid, smul_zero,
    towerModeVec_three_descTwo hη hψ1, towerModeVec_three_towerLop_neg_one_of_level_two hη hψ,
    smul_smul]
  push_cast
  module

/-! #### `A_ε(2) A_δ(2)` -/

/-- `A_ε(2) A_δ(2) L_{-1} φ = 2 A_δ(2) A_ε(1) φ + 2 A_ε(2) A_δ(1) φ` for `φ` of level three:
the symmetric combination `b_{εδ} + b_{δε}` of the module docstring. -/
theorem towerModeVec_two_two_towerLop_neg_one (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    {φ : TowerFock D R} (hφ : φ ∈ towerBigrade D R j 3) :
    towerModeVec η a b ε 2 (towerModeVec η a b δ 2 (towerLop η a b (-1) φ))
      = (2 : R) • towerModeVec η a b δ 2 (towerModeVec η a b ε 1 φ)
        + (2 : R) • towerModeVec η a b ε 2 (towerModeVec η a b δ 1 φ) := by
  have hφ2 : towerModeVec η a b δ 2 φ ∈ towerBigrade D R j 1 :=
    towerModeVec_mem_towerBigrade η a b δ hφ (by norm_num)
  have hstep : towerModeVec η a b δ 2 (towerLop η a b (-1) φ)
      = towerLop η a b (-1) (towerModeVec η a b δ 2 φ)
        + (2 : R) • towerModeVec η a b δ 1 φ := by
    rw [towerModeVec_apply_towerLop η a b δ hη (-1) 2, show (-1 : ℤ) + 2 = 1 by ring]
    norm_num
  rw [hstep, map_add, map_smul, towerModeVec_two_towerLop_neg_one hη hφ2,
    towerModeVec_apply_towerModeVec_of_add_ne_zero η a b ε δ hη
      (show (1 : ℤ) + 2 ≠ 0 by norm_num)]

/-- `A_ε(2) A_δ(2) 𝒟₂ ψ = 10 (ε·p_j) A_δ(2) ψ + 24 A_ε(1) A_δ(1) ψ + 10 (δ·p_j) A_ε(2) ψ`
for `ψ` of level two. -/
theorem towerModeVec_two_two_descTwo (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    {ψ : TowerFock D R} (hψ : ψ ∈ towerBigrade D R j 2) :
    towerModeVec η a b ε 2 (towerModeVec η a b δ 2 (descTwo η a b ψ))
      = ((10 : R) * dotVec η ε (towerMomentum a b j)) • towerModeVec η a b δ 2 ψ
        + ((24 : R) • towerModeVec η a b ε 1 (towerModeVec η a b δ 1 ψ)
          + ((10 : R) * dotVec η δ (towerMomentum a b j)) • towerModeVec η a b ε 2 ψ) := by
  have hψ0 : towerModeVec η a b δ 2 ψ ∈ towerBigrade D R j 0 :=
    towerModeVec_mem_towerBigrade η a b δ hψ (by norm_num)
  have hψ1 : towerModeVec η a b δ 1 ψ ∈ towerBigrade D R j 1 :=
    towerModeVec_mem_towerBigrade η a b δ hψ (by norm_num)
  rw [towerModeVec_two_descTwo hη hψ, map_add, map_add, map_smul, map_smul,
    towerModeVec_two_descTwo_of_level_zero hη hψ0, towerModeVec_two_towerLop_neg_one hη hψ1,
    smul_smul]
  push_cast
  module

/-! #### `A_ε(2) A_δ(1) A_ρ(1)` — the equation that is antisymmetrised -/

/-- `A_ε(2) A_δ(1) A_ρ(1) L_{-1} φ = 2 A_ε(1)A_δ(1)A_ρ(1) φ + (δ·p_j) A_ε(2)A_ρ(1) φ
+ (ρ·p_j) A_ε(2)A_δ(1) φ` for `φ` of level three.  The first summand is totally symmetric
(three modes of index `1` commute pairwise), so it drops out of the `ε ↔ δ` antisymmetrisation. -/
theorem towerModeVec_two_one_one_towerLop_neg_one (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    {φ : TowerFock D R} (hφ : φ ∈ towerBigrade D R j 3) :
    towerModeVec η a b ε 2
        (towerModeVec η a b δ 1 (towerModeVec η a b ρ 1 (towerLop η a b (-1) φ)))
      = (2 : R) • towerModeVec η a b ε 1
            (towerModeVec η a b δ 1 (towerModeVec η a b ρ 1 φ))
        + (dotVec η δ (towerMomentum a b j)
              • towerModeVec η a b ε 2 (towerModeVec η a b ρ 1 φ)
          + dotVec η ρ (towerMomentum a b j)
              • towerModeVec η a b ε 2 (towerModeVec η a b δ 1 φ)) := by
  have hρ2 : towerModeVec η a b ρ 1 φ ∈ towerBigrade D R j 2 :=
    towerModeVec_mem_towerBigrade η a b ρ hφ (by norm_num)
  have hδρ1 : towerModeVec η a b δ 1 (towerModeVec η a b ρ 1 φ) ∈ towerBigrade D R j 1 :=
    towerModeVec_mem_towerBigrade η a b δ hρ2 (by norm_num)
  rw [towerModeVec_one_towerLop_neg_one hη hφ]
  simp only [map_add, map_smul]
  rw [towerModeVec_one_towerLop_neg_one hη hρ2]
  simp only [map_add, map_smul]
  rw [towerModeVec_two_towerLop_neg_one hη hδρ1]
  module

/-- `A_ε(2) A_δ(1) A_ρ(1) 𝒟₂ ψ` for `ψ` of level two:

`10(ε·p) A_δ(1)A_ρ(1)ψ + 12(δ·p) A_ε(1)A_ρ(1)ψ + 12(ρ·p) A_ε(1)A_δ(1)ψ
  + [2(δ·ρ) + 6(δ·p)(ρ·p)] A_ε(2)ψ`.

The `(δ·ρ)` term comes from the oscillator central term `⁅A_δ(1), A_ρ(-1)⁆`; it is the term
that survives the `ε ↔ δ` antisymmetrisation together with the `(δ·p)(ρ·p)` one, and their
relative coefficient is what makes `2 − (8/3)p²` appear. -/
theorem towerModeVec_two_one_one_descTwo (hη : ∀ μ, η μ * η μ = 1) {j : ℤ}
    {ψ : TowerFock D R} (hψ : ψ ∈ towerBigrade D R j 2) :
    towerModeVec η a b ε 2
        (towerModeVec η a b δ 1 (towerModeVec η a b ρ 1 (descTwo η a b ψ)))
      = ((10 : R) * dotVec η ε (towerMomentum a b j))
            • towerModeVec η a b δ 1 (towerModeVec η a b ρ 1 ψ)
        + (((12 : R) * dotVec η δ (towerMomentum a b j))
              • towerModeVec η a b ε 1 (towerModeVec η a b ρ 1 ψ)
          + (((12 : R) * dotVec η ρ (towerMomentum a b j))
                • towerModeVec η a b ε 1 (towerModeVec η a b δ 1 ψ)
            + ((2 : R) * dotVec η δ ρ
                + (6 : R) * dotVec η δ (towerMomentum a b j)
                    * dotVec η ρ (towerMomentum a b j))
                • towerModeVec η a b ε 2 ψ)) := by
  have hρ1 : towerModeVec η a b ρ 1 ψ ∈ towerBigrade D R j 1 :=
    towerModeVec_mem_towerBigrade η a b ρ hψ (by norm_num)
  have hδ1 : towerModeVec η a b δ 1 ψ ∈ towerBigrade D R j 1 :=
    towerModeVec_mem_towerBigrade η a b δ hψ (by norm_num)
  have hδρ0 : towerModeVec η a b δ 1 (towerModeVec η a b ρ 1 ψ) ∈ towerBigrade D R j 0 :=
    towerModeVec_mem_towerBigrade η a b δ hρ1 (by norm_num)
  have hzeroA : towerModeVec η a b ε 2
      (towerModeVec η a b δ (-1) (towerModeVec η a b ρ 1 ψ)) = 0 := by
    rw [towerModeVec_apply_towerModeVec_of_add_ne_zero η a b ε δ hη
        (show (2 : ℤ) + (-1) ≠ 0 by norm_num),
      towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hρ1 (by norm_num), map_zero]
  have hzeroB : towerModeVec η a b ε 2
      (towerModeVec η a b ρ (-1) (towerModeVec η a b δ 1 ψ)) = 0 := by
    rw [towerModeVec_apply_towerModeVec_of_add_ne_zero η a b ε ρ hη
        (show (2 : ℤ) + (-1) ≠ 0 by norm_num),
      towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b ε hδ1 (by norm_num), map_zero]
  rw [towerModeVec_one_descTwo hη hψ]
  simp only [map_add, map_smul]
  rw [towerModeVec_one_descTwo hη hρ1, towerModeVec_one_apply_towerModeVec_neg_one η a b hη ψ,
    towerModeVec_one_towerLop_neg_one hη hψ]
  simp only [map_add, map_smul]
  rw [towerModeVec_two_descTwo_of_level_zero hη hδρ0, hzeroA, hzeroB,
    towerModeVec_two_towerLop_neg_one hη hρ1, towerModeVec_two_towerLop_neg_one hη hδ1]
  module

end MomentEquations

/-! ### Transversality of the two families on the level-four slice

The new mathematical content of this file (blueprint §B‴ 订正 item 5): `L_{-1} V_{j,3}` and
`𝒟₂ V_{j,2}` meet only in `0`, on every rung whose momentum satisfies `p·p ≠ 0` and
`3 − 4 p² ≠ 0`.  As at level three, `D` and physicality never enter. -/

section Transversality

variable {D : ℕ} {K : Type*} [Field K] [CharZero K] [Algebra ℚ K] {η a b : Fin D → K}

/-- ⭐ **The moment relations at level four.**

If `L_{-1}φ + 𝒟₂ψ = 0` with `φ` of level three and `ψ` of level two, then (1) the two-mode
moments of `ψ` are determined by the one-mode ones,

`A_ε(1)A_δ(1)ψ = (2/3)[(δ·p) A_ε(2)ψ + (ε·p) A_δ(2)ψ]`,

and (2) — the **antisymmetrised** moment identity — for all polarisations

`3 [(δ·ρ) A_ε(2)ψ − (ε·ρ) A_δ(2)ψ] = 4(ρ·p) [(δ·p) A_ε(2)ψ − (ε·p) A_δ(2)ψ]`.

This is the blueprint's `−(8/3)(ρ·p)[(δ·p)m_ε − (ε·p)m_δ] + 2[(δ·ρ)m_ε − (ε·ρ)m_δ] = 0`
cleared of denominators (multiplied by `3/2`).  The proof is the elimination of `a`, `b`, `c`
and `n` from the four moment equations, with the `ε ↔ δ` antisymmetrisation killing the totally
symmetric `c` and the symmetric `n`. -/
theorem moment_relations_of_towerLop_neg_one_add_descTwo (hη : ∀ μ, η μ * η μ = 1)
    {j : ℤ} {φ ψ : TowerFock D K} (hφ : φ ∈ towerBigrade D K j 3)
    (hψ : ψ ∈ towerBigrade D K j 2)
    (hzero : towerLop η a b (-1) φ + descTwo η a b ψ = 0) :
    (∀ w v : Fin D → K, towerModeVec η a b w 1 (towerModeVec η a b v 1 ψ)
        = (2 / 3 * dotVec η v (towerMomentum a b j)) • towerModeVec η a b w 2 ψ
          + (2 / 3 * dotVec η w (towerMomentum a b j)) • towerModeVec η a b v 2 ψ)
      ∧ (∀ ε δ ρ : Fin D → K, (3 : K) • (dotVec η δ ρ • towerModeVec η a b ε 2 ψ
          - dotVec η ε ρ • towerModeVec η a b δ 2 ψ)
        = (4 * dotVec η ρ (towerMomentum a b j))
            • (dotVec η δ (towerMomentum a b j) • towerModeVec η a b ε 2 ψ
              - dotVec η ε (towerMomentum a b j) • towerModeVec η a b δ 2 ψ)) := by
  -- the four moment equations
  have E1 : ∀ w : Fin D → K, (4 : K) • towerModeVec η a b w 3 φ
      + (44 : K) • towerModeVec η a b w 2 ψ = 0 := by
    intro w
    have h := congrArg (towerModeVec η a b w 4) hzero
    rwa [map_add, map_zero, towerModeVec_four_towerLop_neg_one hη hφ,
      towerModeVec_four_descTwo hη hψ] at h
  have E2 : ∀ w v : Fin D → K,
      (3 : K) • towerModeVec η a b w 2 (towerModeVec η a b v 1 φ)
        + dotVec η v (towerMomentum a b j) • towerModeVec η a b w 3 φ
        + (24 : K) • towerModeVec η a b w 1 (towerModeVec η a b v 1 ψ)
        + (18 * dotVec η v (towerMomentum a b j)) • towerModeVec η a b w 2 ψ = 0 := by
    intro w v
    have h := congrArg (fun x => towerModeVec η a b w 3 (towerModeVec η a b v 1 x)) hzero
    simp only [map_add, map_zero] at h
    rw [towerModeVec_three_one_towerLop_neg_one hη hφ, towerModeVec_three_one_descTwo hη hψ] at h
    linear_combination (norm := module) h
  have E3 : ∀ w v : Fin D → K,
      (2 : K) • towerModeVec η a b v 2 (towerModeVec η a b w 1 φ)
        + (2 : K) • towerModeVec η a b w 2 (towerModeVec η a b v 1 φ)
        + (10 * dotVec η w (towerMomentum a b j)) • towerModeVec η a b v 2 ψ
        + (24 : K) • towerModeVec η a b w 1 (towerModeVec η a b v 1 ψ)
        + (10 * dotVec η v (towerMomentum a b j)) • towerModeVec η a b w 2 ψ = 0 := by
    intro w v
    have h := congrArg (fun x => towerModeVec η a b w 2 (towerModeVec η a b v 2 x)) hzero
    simp only [map_add, map_zero] at h
    rw [towerModeVec_two_two_towerLop_neg_one hη hφ, towerModeVec_two_two_descTwo hη hψ] at h
    linear_combination (norm := module) h
  have E4 : ∀ w v z : Fin D → K,
      (2 : K) • towerModeVec η a b w 1
            (towerModeVec η a b v 1 (towerModeVec η a b z 1 φ))
        + dotVec η v (towerMomentum a b j)
            • towerModeVec η a b w 2 (towerModeVec η a b z 1 φ)
        + dotVec η z (towerMomentum a b j)
            • towerModeVec η a b w 2 (towerModeVec η a b v 1 φ)
        + (10 * dotVec η w (towerMomentum a b j))
            • towerModeVec η a b v 1 (towerModeVec η a b z 1 ψ)
        + (12 * dotVec η v (towerMomentum a b j))
            • towerModeVec η a b w 1 (towerModeVec η a b z 1 ψ)
        + (12 * dotVec η z (towerMomentum a b j))
            • towerModeVec η a b w 1 (towerModeVec η a b v 1 ψ)
        + (2 * dotVec η v z + 6 * dotVec η v (towerMomentum a b j)
            * dotVec η z (towerMomentum a b j)) • towerModeVec η a b w 2 ψ = 0 := by
    intro w v z
    have h := congrArg
      (fun x => towerModeVec η a b w 2 (towerModeVec η a b v 1 (towerModeVec η a b z 1 x))) hzero
    simp only [map_add, map_zero] at h
    rw [towerModeVec_two_one_one_towerLop_neg_one hη hφ,
      towerModeVec_two_one_one_descTwo hη hψ] at h
    linear_combination (norm := module) h
  -- the two symmetries
  have hnsym : ∀ w v : Fin D → K,
      towerModeVec η a b w 1 (towerModeVec η a b v 1 ψ)
        = towerModeVec η a b v 1 (towerModeVec η a b w 1 ψ) := fun w v =>
    towerModeVec_apply_towerModeVec_of_add_ne_zero η a b w v hη (by norm_num) ψ
  have hcsym : ∀ w v z : Fin D → K,
      towerModeVec η a b w 1 (towerModeVec η a b v 1 (towerModeVec η a b z 1 φ))
        = towerModeVec η a b v 1 (towerModeVec η a b w 1 (towerModeVec η a b z 1 φ)) :=
    fun w v z => towerModeVec_apply_towerModeVec_of_add_ne_zero η a b w v hη (by norm_num) _
  -- solved forms
  have hAsol : ∀ w : Fin D → K,
      towerModeVec η a b w 3 φ = (-11 : K) • towerModeVec η a b w 2 ψ := by
    intro w
    linear_combination (norm := module) (1 / 4 : K) • E1 w
  have hBsol : ∀ w v : Fin D → K,
      towerModeVec η a b w 2 (towerModeVec η a b v 1 φ)
        = (-8 : K) • towerModeVec η a b w 1 (towerModeVec η a b v 1 ψ)
          + (-7 / 3 * dotVec η v (towerMomentum a b j)) • towerModeVec η a b w 2 ψ := by
    intro w v
    linear_combination (norm := module) (1 / 3 : K) • E2 w v
      - (1 / 3 * dotVec η v (towerMomentum a b j)) • hAsol w
  have hNsol : ∀ w v : Fin D → K,
      towerModeVec η a b w 1 (towerModeVec η a b v 1 ψ)
        = (2 / 3 * dotVec η v (towerMomentum a b j)) • towerModeVec η a b w 2 ψ
          + (2 / 3 * dotVec η w (towerMomentum a b j)) • towerModeVec η a b v 2 ψ := by
    intro w v
    linear_combination (norm := module) (-1 / 8 : K) • E3 w v + (1 / 4 : K) • hBsol w v
      + (1 / 4 : K) • hBsol v w + (2 : K) • hnsym w v
  refine ⟨hNsol, fun ε δ ρ => ?_⟩
  linear_combination (norm := module) (3 / 2 : K) • E4 ε δ ρ - (3 / 2 : K) • E4 δ ε ρ
    - (3 : K) • hcsym ε δ ρ - (6 * dotVec η ρ (towerMomentum a b j)) • hnsym ε δ
    - (3 / 2 * dotVec η δ (towerMomentum a b j)) • hBsol ε ρ
    - (3 / 2 * dotVec η ρ (towerMomentum a b j)) • hBsol ε δ
    + (3 / 2 * dotVec η ε (towerMomentum a b j)) • hBsol δ ρ
    + (3 / 2 * dotVec η ρ (towerMomentum a b j)) • hBsol δ ε
    + (9 * dotVec η δ (towerMomentum a b j)) • hNsol ε ρ
    - (9 * dotVec η ε (towerMomentum a b j)) • hNsol δ ρ

/-- ⭐⭐ **Transversality of the Type-1 and Type-2 families at level four.**

If `L_{-1}φ + 𝒟₂ψ = 0` with `φ ∈ V_{j,3}` and `ψ ∈ V_{j,2}`, then `ψ = 0` and `φ = 0`,
provided the rung momentum satisfies `p·p ≠ 0` and `3 − 4 p² ≠ 0` and there is a unit
polarisation transverse to it.

On the antidiagonal slice `p_j·p_j = 2 − 2N`, so at `N = 4` the two numerical conditions read
`-6 ≠ 0` and `27 ≠ 0`.  Neither `D` nor physicality of the seeds is used: like
`LevelThreeCount.eq_zero_of_towerLop_neg_one_add_descTwo_oneSeed` this is a statement about the
oscillator algebra alone. -/
theorem eq_zero_of_towerLop_neg_one_add_descTwo_at_four (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1) {j : ℤ}
    {φ ψ : TowerFock D K} (hφ : φ ∈ towerBigrade D K j 3) (hψ : ψ ∈ towerBigrade D K j 2)
    (hpp : dotVec η (towerMomentum a b j) (towerMomentum a b j) ≠ 0)
    (hcoef : (3 : K) - 4 * dotVec η (towerMomentum a b j) (towerMomentum a b j) ≠ 0)
    {u : Fin D → K} (hu : dotVec η u (towerMomentum a b j) = 0) (huu : dotVec η u u = 1)
    (hzero : towerLop η a b (-1) φ + descTwo η a b ψ = 0) : ψ = 0 ∧ φ = 0 := by
  obtain ⟨hNsol, hstar⟩ :=
    moment_relations_of_towerLop_neg_one_add_descTwo hη hφ hψ hzero
  -- `(δ·p) m_ε = (ε·p) m_δ`, from `ρ := p` and `3 − 4p² ≠ 0`
  have hm1 : ∀ ε δ : Fin D → K,
      dotVec η δ (towerMomentum a b j) • towerModeVec η a b ε 2 ψ
        = dotVec η ε (towerMomentum a b j) • towerModeVec η a b δ 2 ψ := by
    intro ε δ
    have h := hstar ε δ (towerMomentum a b j)
    have h2 : ((3 : K) - 4 * dotVec η (towerMomentum a b j) (towerMomentum a b j))
        • (dotVec η δ (towerMomentum a b j) • towerModeVec η a b ε 2 ψ
          - dotVec η ε (towerMomentum a b j) • towerModeVec η a b δ 2 ψ) = 0 := by
      linear_combination (norm := module) h
    rcases smul_eq_zero.1 h2 with h3 | h3
    · exact absurd h3 hcoef
    · exact sub_eq_zero.1 h3
  -- back-substituting, `(δ·ρ) m_ε = (ε·ρ) m_δ` for *all* `ρ`
  have hg : ∀ ε δ ρ : Fin D → K,
      dotVec η δ ρ • towerModeVec η a b ε 2 ψ
        = dotVec η ε ρ • towerModeVec η a b δ 2 ψ := by
    intro ε δ ρ
    have h := hstar ε δ ρ
    rw [hm1 ε δ, sub_self, smul_zero] at h
    rcases smul_eq_zero.1 h with h3 | h3
    · exact absurd h3 (by norm_num)
    · exact sub_eq_zero.1 h3
  -- the transverse unit polarisation kills the longitudinal moment
  have hmp : towerModeVec η a b (towerMomentum a b j) 2 ψ = 0 := by
    have h := hg (towerMomentum a b j) u u
    rwa [huu, one_smul, dotVec_comm η (towerMomentum a b j) u, hu, zero_smul] at h
  have hm0 : ∀ ε : Fin D → K, towerModeVec η a b ε 2 ψ = 0 := by
    intro ε
    have h := hm1 ε (towerMomentum a b j)
    rw [hmp, smul_zero] at h
    exact (smul_eq_zero.1 h).resolve_left hpp
  -- hence the two-mode moments vanish, hence the one-mode ones, hence `ψ = 0`
  have hn0 : ∀ w v : Fin D → K,
      towerModeVec η a b w 1 (towerModeVec η a b v 1 ψ) = 0 := by
    intro w v
    rw [hNsol w v, hm0 w, hm0 v, smul_zero, smul_zero, add_zero]
  have hone : ∀ v : Fin D → K, towerModeVec η a b v 1 ψ = 0 := by
    intro v
    have hv1 : towerModeVec η a b v 1 ψ ∈ towerBigrade D K j 1 :=
      towerModeVec_mem_towerBigrade η a b v hψ (by norm_num)
    refine eq_zero_of_towerModeVec_eq_zero (a := a) (b := b) hη (by norm_num) hv1
      fun w q hq => ?_
    rcases eq_or_lt_of_le (show (1 : ℤ) ≤ q from hq) with hq1 | hq1
    · rw [← hq1]; exact hn0 w v
    · exact towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b w hv1 (by exact_mod_cast hq1)
  have hψ0 : ψ = 0 := by
    refine eq_zero_of_towerModeVec_eq_zero (a := a) (b := b) hη (by norm_num) hψ
      fun w q hq => ?_
    rcases eq_or_lt_of_le (show (1 : ℤ) ≤ q from hq) with hq1 | hq1
    · rw [← hq1]; exact hone w
    · rcases eq_or_lt_of_le (show (2 : ℤ) ≤ q from hq1) with hq2 | hq2
      · rw [← hq2]; exact hm0 w
      · exact towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b w hψ
          (by exact_mod_cast hq2)
  refine ⟨hψ0, ?_⟩
  rw [hψ0, map_zero, add_zero] at hzero
  exact towerLop_neg_one_injective η a b hη hbb hba hφ hzero

end Transversality

/-! ### The classification of level-four occupation functions

Five shapes: `α^i_{-4}`, `α^i_{-3}α^j_{-1}`, `α^i_{-2}α^j_{-2}`, `α^i_{-2}α^j_{-1}α^k_{-1}` and
`α^i_{-1}α^j_{-1}α^k_{-1}α^l_{-1}`.  As at level three the proof is one application of
`Finsupp.exists_peel` plus the level-≤ 3 classifications. -/

namespace Finsupp

variable {ι : Type*}

/-- A `ℕ+` is determined by its coercion (the `Prod.ext` helper of the classification). -/
private lemma pnat_eq {m n : ℕ+} (h : (m : ℕ) = (n : ℕ)) : m = n := PNat.coe_injective h

/-- **The classification of level-four occupation functions.** -/
theorem oscWeight_eq_four_cases {d : (ι × ℕ+) →₀ ℕ} (h : oscWeight d = 4) :
    (∃ i : ι, d = Finsupp.single (i, 4) 1) ∨
      (∃ i j : ι, d = Finsupp.single (i, 3) 1 + Finsupp.single (j, 1) 1) ∨
        (∃ i j : ι, d = Finsupp.single (i, 2) 1 + Finsupp.single (j, 2) 1) ∨
          (∃ i j k : ι, d = Finsupp.single (i, 2) 1
            + (Finsupp.single (j, 1) 1 + Finsupp.single (k, 1) 1)) ∨
            (∃ i j k l : ι, d = Finsupp.single (i, 1) 1
              + (Finsupp.single (j, 1) 1
                + (Finsupp.single (k, 1) 1 + Finsupp.single (l, 1) 1))) := by
  obtain ⟨v, d', hd, hw⟩ := exists_peel (N := 3) (by simpa using h)
  have hpos : 0 < (v.2 : ℕ) := v.2.pos
  have hle : (v.2 : ℕ) ≤ 4 := by omega
  interval_cases hv : (v.2 : ℕ)
  · -- `v₂ = 1`: the rest has weight three
    have hv1 : ((v.1, 1) : ι × ℕ+) = v := Prod.ext rfl (pnat_eq (by simpa using hv.symm))
    rcases oscWeight_eq_three_cases (d := d') (by omega) with
      ⟨i, hi⟩ | ⟨i, j, hi⟩ | ⟨i, j, k, hi⟩
    · exact Or.inr (Or.inl ⟨i, v.1, by rw [hd, hi, hv1] ; abel⟩)
    · exact Or.inr (Or.inr (Or.inr (Or.inl ⟨i, v.1, j, by rw [hd, hi, hv1]; abel⟩)))
    · exact Or.inr (Or.inr (Or.inr (Or.inr ⟨v.1, i, j, k, by rw [hd, hi, hv1]; abel⟩)))
  · -- `v₂ = 2`: the rest has weight two
    have hv2 : ((v.1, 2) : ι × ℕ+) = v := Prod.ext rfl (pnat_eq (by simpa using hv.symm))
    rcases oscWeight_eq_two_cases (d := d') (by omega) with ⟨i, hi⟩ | ⟨i, j, hi⟩
    · exact Or.inr (Or.inr (Or.inl ⟨v.1, i, by rw [hd, hi, hv2]⟩))
    · exact Or.inr (Or.inr (Or.inr (Or.inl ⟨v.1, i, j, by rw [hd, hi, hv2]⟩)))
  · -- `v₂ = 3`: the rest has weight one
    have hv3 : ((v.1, 3) : ι × ℕ+) = v := Prod.ext rfl (pnat_eq (by simpa using hv.symm))
    obtain ⟨i, hi⟩ := oscWeight_eq_one_cases (d := d') (by omega)
    exact Or.inr (Or.inl ⟨v.1, i, by rw [hd, hi, hv3]⟩)
  · -- `v₂ = 4`: the rest is empty
    have hv4 : ((v.1, 4) : ι × ℕ+) = v := Prod.ext rfl (pnat_eq (by simpa using hv.symm))
    have hd' : d' = 0 := eq_zero_of_oscWeight_eq_zero (by omega)
    exact Or.inl ⟨v.1, by rw [hd, hd', add_zero, hv4]⟩

end Finsupp

end StringFormal.NoGhost
