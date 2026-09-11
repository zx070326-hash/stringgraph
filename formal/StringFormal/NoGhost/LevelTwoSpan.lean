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



/-! ### (b) The general level-two state -/

section LevelTwoGeneral

variable (η : Fin D → R)

omit [Algebra ℚ R]

/-- Only the zero monomial has level `0`. -/
lemma eq_zero_of_level_eq_zero {d : Osc D →₀ ℕ} (hd : level D d = 0) : d = 0 := by
  classical
  refine Finsupp.ext fun v => ?_
  by_contra hv
  have hmem : v ∈ d.support := Finsupp.mem_support_iff.mpr (by simpa using hv)
  have hle := mode_le_of_mem_support_of_level_eq hd hmem
  have := v.2.pos
  omega

/-- **The two shapes of a level-two monomial**: a single `α^μ_{-2}`, or a product
`α^μ_{-1} α^ν_{-1}` (the case `μ = ν` being the square).  Proved by deleting one oscillator
and appealing to `Fock.exists_eq_single_of_level_eq_one`. -/
lemma level_two_cases {d : Osc D →₀ ℕ} (hd : level D d = 2) :
    (∃ μ : Fin D, d = Finsupp.single ((μ, 2) : Osc D) 1) ∨
      ∃ μ ν : Fin D, d = Finsupp.single ((μ, 1) : Osc D) 1
          + Finsupp.single ((ν, 1) : Osc D) 1 := by
  classical
  obtain ⟨v, hv⟩ : ∃ v : Osc D, v ∈ d.support := by
    by_contra hc
    simp only [not_exists] at hc
    have hz : d = 0 := Finsupp.ext fun u => Finsupp.notMem_support_iff.mp (hc u)
    rw [hz, level_zero] at hd
    exact absurd hd (by norm_num)
  have hdv : d v ≠ 0 := Finsupp.mem_support_iff.mp hv
  have hcancel : (d - Finsupp.single v 1) + Finsupp.single v 1 = d :=
    Finsupp.sub_add_single_one_cancel hdv
  have hlev := level_sub_single_add d hdv
  rw [hd] at hlev
  have hpos := v.2.pos
  have hub := mode_le_of_mem_support_of_level_eq hd hv
  rcases (show (v.2 : ℕ) = 1 ∨ (v.2 : ℕ) = 2 by omega) with h1 | h2
  · have hl1 : level D (d - Finsupp.single v 1) = 1 := by omega
    obtain ⟨μ, hμ⟩ := exists_eq_single_of_level_eq_one hl1
    refine Or.inr ⟨μ, v.1, ?_⟩
    have hvv : ((v.1, (1 : ℕ+)) : Osc D) = v :=
      Prod.ext rfl (PNat.coe_injective (by simpa using h1.symm))
    rw [← hcancel, hμ, hvv]
  · have hl0 : level D (d - Finsupp.single v 1) = 0 := by omega
    refine Or.inl ⟨v.1, ?_⟩
    have hvv : ((v.1, (2 : ℕ+)) : Osc D) = v :=
      Prod.ext rfl (PNat.coe_injective (by simpa using h2.symm))
    rw [← hcancel, eq_zero_of_level_eq_zero hl0, zero_add, hvv]

/-- **The general level-two state**
`ψ = Σ_μ α^μ_{-1} (v_μ · α_{-1}) |k⟩ + (w · α_{-2}) |k⟩`.
The family `v : Fin D → Fin D → R` is the symmetric-tensor part written with its first index
spelled out, `w` the `α_{-2}` part; no symmetry is imposed on `v`, and the representation is
correspondingly not unique. -/
noncomputable def levelTwoGen (v : Fin D → Fin D → R) (w : Fin D → R) : Fock D R :=
  (∑ μ : Fin D, (X ((μ, 1) : Osc D) : Fock D R) * polState η (v μ)) + secondState η w

@[simp]
lemma levelTwoGen_zero : levelTwoGen η (0 : Fin D → Fin D → R) (0 : Fin D → R) = 0 := by
  rw [levelTwoGen, secondState_zero, add_zero]
  exact Finset.sum_eq_zero fun μ _ => by
    rw [show (0 : Fin D → Fin D → R) μ = 0 from rfl, polState_zero, mul_zero]

lemma levelTwoGen_add (v v' : Fin D → Fin D → R) (w w' : Fin D → R) :
    levelTwoGen η (v + v') (w + w') = levelTwoGen η v w + levelTwoGen η v' w' := by
  rw [levelTwoGen, levelTwoGen, levelTwoGen, secondState_add]
  have h : ∀ μ : Fin D, (X ((μ, 1) : Osc D) : Fock D R) * polState η ((v + v') μ)
      = (X ((μ, 1) : Osc D) : Fock D R) * polState η (v μ)
        + (X ((μ, 1) : Osc D) : Fock D R) * polState η (v' μ) := fun μ => by
    rw [show (v + v') μ = v μ + v' μ from rfl, polState_add, mul_add]
  rw [Finset.sum_congr rfl fun μ _ => h μ, Finset.sum_add_distrib]
  abel

lemma levelTwoGen_smul (c : R) (v : Fin D → Fin D → R) (w : Fin D → R) :
    levelTwoGen η (c • v) (c • w) = c • levelTwoGen η v w := by
  rw [levelTwoGen, levelTwoGen, secondState_smul, smul_add, Finset.smul_sum]
  congr 1
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [show (c • v) μ = c • v μ from rfl, polState_smul, mul_smul_comm]

/-- The submodule of states of the general level-two shape. -/
noncomputable def levelTwoRange : Submodule R (Fock D R) where
  carrier := {P | ∃ (v : Fin D → Fin D → R) (w : Fin D → R), P = levelTwoGen η v w}
  add_mem' := by
    rintro P Q ⟨v, w, rfl⟩ ⟨v', w', rfl⟩
    exact ⟨v + v', w + w', (levelTwoGen_add η v v' w w').symm⟩
  zero_mem' := ⟨0, 0, (levelTwoGen_zero η).symm⟩
  smul_mem' := by
    rintro c P ⟨v, w, rfl⟩
    exact ⟨c • v, c • w, (levelTwoGen_smul η c v w).symm⟩

lemma mem_levelTwoRange {P : Fock D R} :
    P ∈ levelTwoRange η ↔ ∃ (v : Fin D → Fin D → R) (w : Fin D → R), P = levelTwoGen η v w :=
  Iff.rfl

variable {η}

/-- A polarisation concentrated on one direction gives back a single oscillator. -/
lemma polState_pi_single (hη : ∀ μ, η μ * η μ = 1) (ν : Fin D) (c : R) :
    polState η (Pi.single ν (η ν * c)) = c • (X ((ν, 1) : Osc D) : Fock D R) := by
  classical
  rw [polState, Finset.sum_eq_single ν]
  · rw [Pi.single_eq_same, ← mul_assoc, hη ν, one_mul]
  · intro μ _ hμ
    rw [Pi.single_eq_of_ne hμ, mul_zero, zero_smul]
  · intro h
    exact absurd (Finset.mem_univ ν) h

lemma secondState_pi_single (hη : ∀ μ, η μ * η μ = 1) (ν : Fin D) (c : R) :
    secondState η (Pi.single ν (η ν * c)) = c • (X ((ν, 2) : Osc D) : Fock D R) := by
  classical
  rw [secondState, Finset.sum_eq_single ν]
  · rw [Pi.single_eq_same, ← mul_assoc, hη ν, one_mul]
  · intro μ _ hμ
    rw [Pi.single_eq_of_ne hμ, mul_zero, zero_smul]
  · intro h
    exact absurd (Finset.mem_univ ν) h

lemma smul_X_two_mem_levelTwoRange (hη : ∀ μ, η μ * η μ = 1) (ν : Fin D) (c : R) :
    c • (X ((ν, 2) : Osc D) : Fock D R) ∈ levelTwoRange η := by
  refine ⟨0, Pi.single ν (η ν * c), ?_⟩
  rw [levelTwoGen, secondState_pi_single hη ν c,
    Finset.sum_eq_zero fun μ _ => by
      rw [show (0 : Fin D → Fin D → R) μ = 0 from rfl, polState_zero, mul_zero],
    zero_add]

lemma smul_X_one_mul_X_one_mem_levelTwoRange (hη : ∀ μ, η μ * η μ = 1) (μ ν : Fin D) (c : R) :
    c • ((X ((μ, 1) : Osc D) : Fock D R) * X ((ν, 1) : Osc D)) ∈ levelTwoRange η := by
  classical
  refine ⟨Pi.single μ (Pi.single ν (η ν * c)), 0, ?_⟩
  rw [levelTwoGen, secondState_zero, add_zero, Finset.sum_eq_single μ]
  · rw [Pi.single_eq_same, polState_pi_single hη ν c, mul_smul_comm]
  · intro ρ _ hρ
    rw [Pi.single_eq_of_ne hρ, polState_zero, mul_zero]
  · intro h
    exact absurd (Finset.mem_univ μ) h

/-- **Every level-two state has the general shape** (blocker (b) of `formal/TODO.md`,
first half): the classification of level-two monomials plus closure of `levelTwoRange` under
sums. -/
theorem exists_levelTwoGen_of_mem_levelSubmodule_two (hη : ∀ μ, η μ * η μ = 1)
    {ψ : Fock D R} (hψ : ψ ∈ levelSubmodule D R 2) :
    ∃ (v : Fin D → Fin D → R) (w : Fin D → R), ψ = levelTwoGen η v w := by
  classical
  have hmem : (∑ d ∈ ψ.support, (monomial d (coeff d ψ) : Fock D R)) ∈ levelTwoRange η := by
   refine Submodule.sum_mem _ fun d hd => ?_
   have hlev : level D d = 2 := hψ (MvPolynomial.mem_support_iff.mp hd)
   have hsm : (monomial d (coeff d ψ) : Fock D R) = coeff d ψ • (monomial d 1 : Fock D R) := by
     rw [MvPolynomial.smul_monomial, smul_eq_mul, mul_one]
   rcases level_two_cases hlev with ⟨μ, rfl⟩ | ⟨μ, ν, rfl⟩
   · rw [hsm, show (monomial (Finsupp.single ((μ, 2) : Osc D) 1) (1 : R) : Fock D R)
       = X ((μ, 2) : Osc D) from rfl]
     exact smul_X_two_mem_levelTwoRange hη μ _
   · rw [hsm, show (monomial (Finsupp.single ((μ, 1) : Osc D) 1
         + Finsupp.single ((ν, 1) : Osc D) 1) (1 : R) : Fock D R)
       = (X ((μ, 1) : Osc D) : Fock D R) * X ((ν, 1) : Osc D) by
         rw [show ((X ((μ, 1) : Osc D) : Fock D R) * X ((ν, 1) : Osc D))
           = monomial (Finsupp.single ((μ, 1) : Osc D) 1) (1 : R)
               * monomial (Finsupp.single ((ν, 1) : Osc D) 1) (1 : R) from rfl,
           MvPolynomial.monomial_mul, mul_one]]
     exact smul_X_one_mul_X_one_mem_levelTwoRange hη μ ν _
  obtain ⟨v, w, hvw⟩ := hmem
  exact ⟨v, w, (MvPolynomial.support_sum_monomial_coeff ψ).symm.trans hvw⟩

end LevelTwoGeneral

/-! ### The Virasoro conditions on the general level-two state -/

section LevelTwoLop

variable (η a : Fin D → R)

omit [Algebra ℚ R] in
/-- The coefficient of `α^μ_{-1}` in `ζ · α_{-1}|k⟩` is `η_μ ζ^μ`. -/
lemma coeff_polState (e : Fin D → R) (μ : Fin D) :
    coeff (Finsupp.single ((μ, 1) : Osc D) 1) (polState η e) = η μ * e μ := by
  classical
  rw [polState, coeff_sum, Finset.sum_eq_single μ]
  · rw [coeff_smul, smul_eq_mul, coeff_X, if_pos rfl, mul_one]
  · intro ν _ hν
    rw [coeff_smul, smul_eq_mul, coeff_X, if_neg, mul_zero]
    intro hc
    exact hν (congrArg Prod.fst (Finsupp.single_left_injective (b := (1 : ℕ)) one_ne_zero hc))
  · intro h
    exact absurd (Finset.mem_univ μ) h

omit [Algebra ℚ R] in
/-- `ζ · α_{-1}|k⟩ = 0` exactly when the polarisation vanishes (the metric is invertible). -/
lemma polState_eq_zero_iff (hη : ∀ μ, η μ * η μ = 1) {e : Fin D → R} :
    polState η e = 0 ↔ e = 0 := by
  constructor
  · intro h
    funext μ
    have hc := congrArg (coeff (Finsupp.single ((μ, 1) : Osc D) 1)) h
    rw [coeff_polState η e μ, coeff_zero] at hc
    calc e μ = (η μ * η μ) * e μ := by rw [hη μ, one_mul]
      _ = η μ * (η μ * e μ) := by ring
      _ = 0 := by rw [hc, mul_zero]
  · rintro rfl
    exact polState_zero η

omit [Algebra ℚ R] in
/-- Raising the index on the polarisation: `polState` of `η_μ c^μ` is `Σ_μ c^μ α^μ_{-1}`. -/
lemma polState_raise (hη : ∀ μ, η μ * η μ = 1) (c : Fin D → R) :
    polState η (fun μ => η μ * c μ) = ∑ μ : Fin D, c μ • (X ((μ, 1) : Osc D) : Fock D R) := by
  rw [polState]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [← mul_assoc, hη μ, one_mul]

omit [Algebra ℚ R] in
lemma secondState_eq_sum_mode_gen (w : Fin D → R) :
    secondState η w = ∑ μ : Fin D, (η μ * w μ) • mode η a μ (-2) (1 : Fock D R) := by
  rw [secondState]
  exact Finset.sum_congr rfl fun μ _ => by rw [mode_neg_two_apply η a, mul_one]

omit [Algebra ℚ R] in
lemma levelTwoGen_mem_levelSubmodule_two (v : Fin D → Fin D → R) (w : Fin D → R) :
    levelTwoGen η v w ∈ levelSubmodule D R 2 := by
  refine Submodule.add_mem _ (Submodule.sum_mem _ fun μ _ => ?_)
    (secondState_mem_levelSubmodule_two η w)
  exact (X_mem_levelSubmodule_one μ).mul (polState_mem_levelSubmodule_one (v μ))

/-- `L_1 (α^μ_{-1} (ζ·α_{-1})|k⟩) = k^μ (ζ·α_{-1})|k⟩ + (ζ·k) α^μ_{-1}|k⟩`. -/
lemma Lop_one_apply_X_one_mul_polState (hη : ∀ μ, η μ * η μ = 1) (μ : Fin D) (e : Fin D → R) :
    Lop η a 1 ((X ((μ, 1) : Osc D) : Fock D R) * polState η e)
      = a μ • polState η e + dotVec η e a • (X ((μ, 1) : Osc D) : Fock D R) := by
  rw [← mode_neg_one_apply η a, Lop_apply_mode η a hη 1 μ (-1),
    show (1 : ℤ) + -1 = 0 by ring, mode_zero_apply, Lop_one_apply_polState η a hη,
    map_smul, mode_neg_one_apply η a, mul_one, smul_smul]
  congr 2
  push_cast
  ring

/-- `L_2 (α^μ_{-1} (ζ·α_{-1})|k⟩) = ζ^μ |k⟩`. -/
lemma Lop_two_apply_X_one_mul_polState (hη : ∀ μ, η μ * η μ = 1) (μ : Fin D) (e : Fin D → R) :
    Lop η a 2 ((X ((μ, 1) : Osc D) : Fock D R) * polState η e) = e μ • (1 : Fock D R) := by
  rw [← mode_neg_one_apply η a, Lop_apply_mode η a hη 2 μ (-1),
    show (2 : ℤ) + -1 = 1 by ring, mode_one_apply_polState η a hη,
    Lop_apply_polState_of_two_le η a hη (le_refl (2 : ℤ)), map_zero, add_zero, smul_smul]
  congr 1
  push_cast; ring

/-- `L_1 ((w·α_{-2})|k⟩) = 2 (w·α_{-1})|k⟩`. -/
lemma Lop_one_apply_secondState_gen (hη : ∀ μ, η μ * η μ = 1) (w : Fin D → R) :
    Lop η a 1 (secondState η w) = (2 : R) • polState η w := by
  rw [secondState_eq_sum_mode_gen η a w, map_sum, polState_eq_sum_mode η a, Finset.smul_sum]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [map_smul, Lop_apply_mode_one η a hη (by norm_num : (0 : ℤ) < 1) μ (-2),
    show (1 : ℤ) + -2 = -1 by ring, smul_smul, smul_smul]
  congr 1
  push_cast; ring

/-- `L_2 ((w·α_{-2})|k⟩) = 2 (w·k) |k⟩`. -/
lemma Lop_two_apply_secondState_gen (hη : ∀ μ, η μ * η μ = 1) (w : Fin D → R) :
    Lop η a 2 (secondState η w) = (2 * dotVec η w a) • (1 : Fock D R) := by
  rw [secondState_eq_sum_mode_gen η a w, map_sum, dotVec, Finset.mul_sum, Finset.sum_smul]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [map_smul, Lop_apply_mode_one η a hη (by norm_num : (0 : ℤ) < 2) μ (-2),
    show (2 : ℤ) + -2 = 0 by ring, mode_zero_apply, smul_smul, smul_smul]
  congr 1
  push_cast; ring

/-- **The `L_1` constraint vector** of the general level-two state: `L_1 ψ` is the level-one
state with this polarisation.  Its vanishing is `D` linear equations on `(v, w)`. -/
def levelTwoL1 (v : Fin D → Fin D → R) (w : Fin D → R) : Fin D → R :=
  (∑ μ : Fin D, a μ • v μ) + (fun μ => η μ * dotVec η (v μ) a) + (2 : R) • w

/-- **The `L_2` constraint scalar** of the general level-two state.  Its vanishing is the
single remaining linear equation. -/
def levelTwoL2 (v : Fin D → Fin D → R) (w : Fin D → R) : R :=
  (∑ μ : Fin D, v μ μ) + 2 * dotVec η w a

/-- **`L_1` on the general level-two state.** -/
theorem Lop_one_apply_levelTwoGen (hη : ∀ μ, η μ * η μ = 1) (v : Fin D → Fin D → R)
    (w : Fin D → R) :
    Lop η a 1 (levelTwoGen η v w) = polState η (levelTwoL1 η a v w) := by
  rw [levelTwoGen, map_add, map_sum,
    Finset.sum_congr rfl fun μ _ => Lop_one_apply_X_one_mul_polState η a hη μ (v μ),
    Lop_one_apply_secondState_gen η a hη, Finset.sum_add_distrib, levelTwoL1,
    polState_add, polState_add, polState_sum, polState_raise η hη, polState_smul]
  congr 2
  exact Finset.sum_congr rfl fun μ _ => (polState_smul η (a μ) (v μ)).symm

/-- **`L_2` on the general level-two state.** -/
theorem Lop_two_apply_levelTwoGen (hη : ∀ μ, η μ * η μ = 1) (v : Fin D → Fin D → R)
    (w : Fin D → R) :
    Lop η a 2 (levelTwoGen η v w) = levelTwoL2 η a v w • (1 : Fock D R) := by
  rw [levelTwoGen, map_add, map_sum,
    Finset.sum_congr rfl fun μ _ => Lop_two_apply_X_one_mul_polState η a hη μ (v μ),
    Lop_two_apply_secondState_gen η a hη, levelTwoL2, ← Finset.sum_smul, add_smul]

/-- `L_n` annihilates a level-two state for `n ≥ 3`. -/
theorem Lop_apply_levelTwoGen_of_three_le (v : Fin D → Fin D → R) (w : Fin D → R) {n : ℤ}
    (hn : 3 ≤ n) : Lop η a n (levelTwoGen η v w) = 0 :=
  Lop_apply_eq_zero_of_level_lt η a (levelTwoGen_mem_levelSubmodule_two η v w)
    (by push_cast; omega)

end LevelTwoLop

/-! ### The complete level-two slice of the physical subspace -/

section LevelTwoPhys

variable (η a : Fin D → R)

/-- **The level-two slice of `H_phys`, completely** (`formal/TODO.md` item `noghost-b`,
blocker (b)).

Writing the most general level-two state as
`ψ = Σ_μ α^μ_{-1} (v_μ · α_{-1}) |k⟩ + (w · α_{-2}) |k⟩`
(`Fock.levelTwoGen`; always possible by
`Fock.exists_levelTwoGen_of_mem_levelSubmodule_two`), membership in `H_phys` is equivalent to

* the mass shell `α' k² + 2 = a₀`;
* the `D` equations `Σ_μ k^μ v_μ + η_μ (v_μ · k) + 2 w = 0` (`Fock.levelTwoL1`, the
  polarisation of `L_1 ψ`);
* the single equation `Σ_μ v_μ^μ + 2 (w·k) = 0` (`Fock.levelTwoL2`, the scalar `L_2 ψ`).

The conditions `L_n ψ = 0` for `n ≥ 3` are automatic by the level grading.  This is the
level-two analogue of `Fock.mem_physSubmodule_inf_levelSubmodule_one_iff`, and unlike
`NoGhost/LevelTwo.lean` it covers **all** level-two states, not the `SO(D-1)`-scalar trial
family. -/
theorem mem_physSubmodule_inf_levelSubmodule_two_iff (hη : ∀ μ, η μ * η μ = 1) (a₀ : R)
    {ψ : Fock D R} :
    ψ ∈ physSubmodule η a a₀ ⊓ levelSubmodule D R 2 ↔
      ∃ (v : Fin D → Fin D → R) (w : Fin D → R), ψ = levelTwoGen η v w ∧
        (invTwo R * zeroModeSq η a + 2 - a₀) • ψ = 0 ∧
          levelTwoL1 η a v w = 0 ∧ levelTwoL2 η a v w = 0 := by
  constructor
  · intro hmem
    rw [Submodule.mem_inf] at hmem
    obtain ⟨v, w, hvw⟩ := exists_levelTwoGen_of_mem_levelSubmodule_two hη hmem.2
    obtain ⟨h0, hpos⟩ := (mem_physSubmodule_iff_of_mem_levelSubmodule η a a₀ hη hmem.2).mp
      hmem.1
    refine ⟨v, w, hvw, by simpa using h0, ?_, ?_⟩
    · have h1 := hpos 1 (by norm_num)
      rw [hvw, Lop_one_apply_levelTwoGen η a hη] at h1
      exact (polState_eq_zero_iff η hη).mp h1
    · have h2 := hpos 2 (by norm_num)
      rw [hvw, Lop_two_apply_levelTwoGen η a hη, smul_eq_C_mul, mul_one] at h2
      exact MvPolynomial.C_eq_zero.mp h2
  · rintro ⟨v, w, rfl, h0, h1, h2⟩
    refine Submodule.mem_inf.mpr ⟨?_, levelTwoGen_mem_levelSubmodule_two η v w⟩
    refine (mem_physSubmodule_iff_of_mem_levelSubmodule η a a₀ hη
      (levelTwoGen_mem_levelSubmodule_two η v w)).mpr ⟨by simpa using h0, fun n hn => ?_⟩
    rcases lt_or_ge n 3 with h | h
    · rcases (show n = 1 ∨ n = 2 by omega) with rfl | rfl
      · rw [Lop_one_apply_levelTwoGen η a hη, h1, polState_zero]
      · rw [Lop_two_apply_levelTwoGen η a hη, h2, zero_smul]
    · exact Lop_apply_levelTwoGen_of_three_le η a v w h

end LevelTwoPhys

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
