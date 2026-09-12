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

end MomentsDetermine

end StringFormal.NoGhost
