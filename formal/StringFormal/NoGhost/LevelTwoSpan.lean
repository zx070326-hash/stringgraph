/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.LightCone
import StringFormal.NoGhost.LevelTwo

/-!
# Level two: the explicit vertex-operator coefficients and the level-two physical states

This file removes the two blockers recorded in `formal/TODO.md` (item `noghost-b`) for the
`N = 2` increment of the spanning lemma (blueprint §B.6):

* **(a)** the level-one and level-two Laurent coefficients of the creation exponential
  `E_-(z) = Σ_M Φ_M z^M` in a shape one can `rw` with, and the resulting exact expansion of
  `A^ε_{-2}|0;k⟩`;
* **(b)** the *complete* solution of `L_1 ψ = L_2 ψ = 0` on the level-two slice of a single
  Fock space (not just the `SO(D-1)` scalar family of `NoGhost/LevelTwo.lean`).

## Conventions

Inherited verbatim from `Sugawara.lean` / `PhysicalStates.lean` / `LightCone.lean`.

## Main results

* `Fock.creaExp_one` — `Φ_1 = b·α_{-1}` (i.e. `Fock.polState η b`).
* `Fock.two_smul_creaExp_two` — `2 Φ_2 = (b·α_{-1})² + (b·α_{-2})`, and `Fock.creaExp_two`
  for the divided form.
-/

namespace StringFormal.NoGhost

open MvPolynomial

namespace Fock

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

/-! ### (a) The level-one and level-two coefficients of the creation exponential -/

section CreaExpComponents

variable (η b : Fin D → R)

/-- **The level-one Laurent coefficient of the creation exponential is `b·α_{-1}`.**
`Φ_1 = Σ_μ η_μ b^μ α^μ_{-1} = ` `Fock.polState η b`.  Immediate from the Euler recursion
`Fock.creaExp_euler` at `M = 1`, whose only term is `l = 0`. -/
theorem creaExp_one : creaExp η b (1 : ℤ) = polState η b := by
  have h := creaExp_euler η b 1
  rw [Nat.cast_one, one_smul, Finset.sum_range_one] at h
  rw [Nat.cast_one] at h
  rw [h, polState]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [show ((1 : ℤ) - ((0 : ℕ) + 1)) = 0 by norm_num, creaExp_zero,
    show (Nat.succPNat 0) = 1 from rfl, creation_apply, mul_one]

/-- **The level-two Laurent coefficient of the creation exponential**, with the `2` cleared:
`2 Φ_2 = (b·α_{-1})² + (b·α_{-2})`.  Again the Euler recursion, now with the two terms
`l = 0` (which reproduces `Φ_1 = b·α_{-1}` by `Fock.creaExp_one`) and `l = 1`. -/
theorem two_smul_creaExp_two :
    (2 : R) • creaExp η b (2 : ℤ) = polState η b * polState η b + secondState η b := by
  have hsq : ∀ P : Fock D R,
      ∑ μ : Fin D, (η μ * b μ) • ((X ((μ, 1) : Osc D) : Fock D R) * P) = polState η b * P := by
    intro P
    rw [polState, Finset.sum_mul]
    exact Finset.sum_congr rfl fun μ _ => (smul_mul_assoc _ _ _).symm
  have h := creaExp_euler η b 2
  rw [Finset.sum_range_succ, Finset.sum_range_one] at h
  norm_num at h
  have h1 : ∀ μ : Fin D,
      (η μ * b μ) • ((X ((μ, Nat.succPNat 0) : Osc D) : Fock D R) * creaExp η b 1)
        = (η μ * b μ) • ((X ((μ, 1) : Osc D) : Fock D R) * polState η b) := fun μ => by
    rw [creaExp_one, show (Nat.succPNat 0) = 1 from rfl]
  have h2 : ∀ μ : Fin D, (η μ * b μ) • (X ((μ, Nat.succPNat 1) : Osc D) : Fock D R)
      = (η μ * b μ) • (X ((μ, 2) : Osc D) : Fock D R) := fun μ => by
    rw [show (Nat.succPNat 1) = 2 from rfl]
  rw [h, Finset.sum_congr rfl fun μ _ => h1 μ, Finset.sum_congr rfl fun μ _ => h2 μ,
    hsq (polState η b), ← secondState]

/-- The divided form of `Fock.two_smul_creaExp_two`:
`Φ_2 = ½ (b·α_{-1})² + ½ (b·α_{-2})`. -/
theorem creaExp_two :
    creaExp η b (2 : ℤ) = invTwo R • (polState η b * polState η b + secondState η b) := by
  rw [← two_smul_creaExp_two, smul_smul, invTwo_mul_two, one_smul]

end CreaExpComponents

section VecLinear

variable (η : Fin D → R)

omit [Algebra ℚ R]

@[simp]
lemma secondState_zero : secondState η (0 : Fin D → R) = 0 := by
  rw [secondState]
  exact Finset.sum_eq_zero fun μ _ => by simp

lemma secondState_smul (c : R) (e : Fin D → R) :
    secondState η (c • e) = c • secondState η e := by
  rw [secondState, secondState, Finset.smul_sum]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [smul_smul]
  congr 1
  simp only [Pi.smul_apply, smul_eq_mul]
  ring

lemma secondState_add (e f : Fin D → R) :
    secondState η (e + f) = secondState η e + secondState η f := by
  rw [secondState, secondState, secondState, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [← add_smul]
  congr 1
  simp only [Pi.add_apply]
  ring

/-- `Φ_1` for the vertex momentum `n k_0` is `n` times the one for `k_0`. -/
lemma polState_vertexMomentum (b : Fin D → R) (n : ℤ) :
    polState η (vertexMomentum b n) = (n : R) • polState η b := by
  rw [polState, polState, Finset.smul_sum]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [smul_smul, vertexMomentum_apply]
  ring_nf

lemma secondState_vertexMomentum (b : Fin D → R) (n : ℤ) :
    secondState η (vertexMomentum b n) = (n : R) • secondState η b := by
  rw [secondState, secondState, Finset.smul_sum]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [smul_smul, vertexMomentum_apply]
  ring_nf

end VecLinear


end Fock

/-! ### The exact expansion of `A^ε_{-2}` on the ground state -/

section DDFLevelTwo

variable {D : ℕ} {R : Type*} [CommRing R]

/-- `α^ε_{-1}` on a rung vector is multiplication by the level-one state `ε·α_{-1}`. -/
lemma towerModeVec_neg_one_apply_single (η a b ε : Fin D → R) (j : ℤ) (P : Fock D R) :
    towerModeVec η a b ε (-1) (Finsupp.single j P)
      = Finsupp.single j (Fock.polState η ε * P) := by
  rw [towerModeVec, LinearMap.sum_apply, Fock.polState, Finset.sum_mul,
    Finsupp.single_finsetSum]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [LinearMap.smul_apply, towerMode_single, Fock.mode_neg_one_apply, Finsupp.smul_single,
    smul_mul_assoc]

/-- `α^ε_{-2}` on a rung vector is multiplication by the level-two state `ε·α_{-2}`. -/
lemma towerModeVec_neg_two_apply_single (η a b ε : Fin D → R) (j : ℤ) (P : Fock D R) :
    towerModeVec η a b ε (-2) (Finsupp.single j P)
      = Finsupp.single j (Fock.secondState η ε * P) := by
  rw [towerModeVec, LinearMap.sum_apply, Fock.secondState, Finset.sum_mul,
    Finsupp.single_finsetSum]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [LinearMap.smul_apply, towerMode_single, Fock.mode_neg_two_apply, Finsupp.smul_single,
    smul_mul_assoc]

variable [Algebra ℚ R]

/-- **The exact expansion of `A^ε_{-2}` on the ground state** (blueprint §B.4, the `n = 2`
leading-term lemma; `formal/TODO.md` item `noghost-b`, blocker (a)):

`A^ε_{-2}|0; k⟩ = [ε·α_{-2} - 2 (ε·α_{-1})(k_0·α_{-1})] |0; k - 2k_0⟩`.

Unlike the `n = 1` case there *is* a correction term: the DDF window on the ground state is
`{-2, -1, 0}` and the middle term is the level-one coefficient `Φ_1` of the creation
exponential at vertex momentum `-2 k_0` (`Fock.creaExp_one`,
`Fock.polState_vertexMomentum`).  The `j = 0` term still drops out, and again **only**
because of the extra hypothesis `hεa : ε·k = 0` (see
`ddfOp_neg_one_apply_towerVacuum`). -/
theorem ddfOp_neg_two_apply_towerVacuum (η a b ε : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hεb : dotVec η ε b = 0) (hεa : dotVec η ε a = 0) :
    ddfOp η a b ε hη hεb (-2) (towerVacuum D R)
      = Finsupp.single (-2) (Fock.secondState η ε
          - (2 : R) • (Fock.polState η ε * Fock.polState η b)) := by
  classical
  have hs : ∀ j ∉ ({-2, -1, 0} : Finset ℤ),
      ddfSummand η a b ε (-2) j (towerVacuum D R) = 0 := by
    intro j hj
    simp only [Finset.mem_insert, Finset.mem_singleton, not_or] at hj
    obtain ⟨h1, h2, h3⟩ := hj
    rcases lt_or_ge j 0 with h | h
    · exact ddfSummand_apply_single_vacuum_eq_zero_of_lt η a b ε (-2) j 0 (by omega)
    · exact ddfSummand_apply_single_vacuum_eq_zero_of_pos η a b ε hη hεb (-2) j 0 (by omega)
  have hm2 : ddfSummand η a b ε (-2) (-2) (towerVacuum D R)
      = Finsupp.single (-2) (Fock.secondState η ε) := by
    rw [ddfSummand, Module.End.mul_apply, towerVacuum, towerVertex_apply_single_vacuum,
      show (0 : ℤ) + -2 = -2 by ring, show (-2 : ℤ) - -2 = 0 by ring, Fock.creaExp_zero,
      towerModeVec_neg_two_apply_single, mul_one]
  have hm1 : ddfSummand η a b ε (-2) (-1) (towerVacuum D R)
      = Finsupp.single (-2) ((-2 : R) • (Fock.polState η ε * Fock.polState η b)) := by
    rw [ddfSummand, Module.End.mul_apply, towerVacuum, towerVertex_apply_single_vacuum,
      show (0 : ℤ) + -2 = -2 by ring, show (-1 : ℤ) - -2 = 1 by ring,
      towerModeVec_neg_one_apply_single, Fock.creaExp_one, Fock.polState_vertexMomentum,
      mul_smul_comm]
    norm_num
  have hz : ddfSummand η a b ε (-2) 0 (towerVacuum D R) = 0 := by
    rw [ddfSummand, Module.End.mul_apply, towerVacuum, towerVertex_apply_single_vacuum,
      towerModeVec_zero_apply_single, dotVec_vec_towerMomentum, hεa, hεb, mul_zero, add_zero,
      zero_smul]
  rw [ddfOp_apply η a b ε hη hεb (-2) (towerVacuum D R) hs,
    Finset.sum_insert (by decide), Finset.sum_insert (by decide), Finset.sum_singleton,
    hm2, hm1, hz, add_zero, ← Finsupp.single_add]
  congr 1
  module

end DDFLevelTwo

end StringFormal.NoGhost
