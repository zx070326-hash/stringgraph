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
  `E_-(z) = Σ_M Φ_M z^M` in a shape one can `rw` with, and the resulting exact expansions of
  `A^ε_{-2}|0;k⟩` and `A^ε_{-1} A^δ_{-1}|0;k⟩`;
* **(b)** the *complete* solution of `L_1 ψ = L_2 ψ = 0` on the level-two slice, both for a
  single Fock space and on the momentum tower — not just the `SO(D-1)` scalar trial family
  of `NoGhost/LevelTwo.lean`.

The `N = 2` spanning statement itself (`towerPhys_bigrade_two_le_ddfSpan_sup_spurious`) is
**not** proved here; see the gaps section below.

## Conventions

Inherited verbatim from `Sugawara.lean` / `PhysicalStates.lean` / `LightCone.lean`:
`conv.metric-mostly-plus` (`hη : ∀ μ, η μ * η μ = 1`), `conv.alpha-prime-regge`
(`a^μ = α^μ_0 = (2α')^{1/2} k^μ`, `b^μ = (2α')^{1/2} k_0^μ`), `conv.virasoro-standard`,
`conv.intercept-sign-a`.

## Main results

### (a) The creation exponential and the level-two DDF states

* `Fock.creaExp_one` — `Φ_1 = b·α_{-1}` (i.e. `Fock.polState η b`).
* `Fock.two_smul_creaExp_two` — `2 Φ_2 = (b·α_{-1})² + (b·α_{-2})`; `Fock.creaExp_two` is
  the divided form.
* `Fock.vertexOsc_apply_polState` — `V_K (ζ·α_{-1})|k⟩ = (ζ·α_{-1}) Φ_K - (ζ·c) Φ_{K+1}`.
* `ddfOp_neg_two_apply_towerVacuum` —
  `A^ε_{-2}|0;k⟩ = [ε·α_{-2} - 2 (ε·α_{-1})(k_0·α_{-1})]|0;k-2k_0⟩`.
* `ddfOp_neg_one_mul_ddfOp_neg_one_apply_towerVacuum` —
  `A^ε_{-1}A^δ_{-1}|0;k⟩ = [(ε·α_{-1})(δ·α_{-1}) + ½(ε·δ)((k_0·α_{-1})² - k_0·α_{-2})]
  |0;k-2k_0⟩`.  The correction is symmetric in `ε ↔ δ`, as `⁅A^ε_{-1},A^δ_{-1}⁆ = 0`
  demands.
* `single_ddfSecond_mem_ddfSpan`, `single_ddfPair_mem_ddfSpan` — those two families as
  explicit members of `ddfSpan`.

### (b) The level-two physical states

* `Fock.level_two_cases` — a monomial of level `2` is `α^μ_{-2}` or `α^μ_{-1}α^ν_{-1}`.
* `Fock.exists_levelTwoGen_of_mem_levelSubmodule_two` — every level-two state is
  `Σ_μ α^μ_{-1}(v_μ·α_{-1})|k⟩ + (w·α_{-2})|k⟩` (`Fock.levelTwoGen`).
* `Fock.Lop_one_apply_levelTwoGen`, `Fock.Lop_two_apply_levelTwoGen` — `L_1 ψ` is the
  level-one state with polarisation `Fock.levelTwoL1`, and `L_2 ψ` is the scalar
  `Fock.levelTwoL2`; `L_n ψ = 0` for `n ≥ 3`.
* `Fock.mem_physSubmodule_inf_levelSubmodule_two_iff` — hence the level-two slice of
  `H_phys` is cut out by the mass shell plus the `D` equations `levelTwoL1 = 0` and the one
  equation `levelTwoL2 = 0`.
* `mem_towerPhys_bigrade_two_iff` — the same on the bigraded piece `(rung j, level 2)` of
  the momentum tower.

## Gaps

* **`N = 2` spanning is not done.**  What is missing is the linear algebra: given `(v, w)`
  satisfying the `D + 1` constraints, exhibit the physical state as a combination of the
  `(D-2) + (D-2)(D-1)/2` DDF vectors above and the `D + 1` spurious vectors
  `L_{-1}(level 1)`, `L_{-2}|0;p_{-2}⟩`.  Both sides are now explicit, but the elimination
  (which needs the light-cone decomposition `b`, `b̃`, `ε_i` and hence
  `FrameSpansOrthogonal`) is not carried out.
* **`ε·k = 0` is used again.**  As at `N = 1` (`ddfOp_neg_one_apply_towerVacuum`), the
  exact expansions of `A^ε_{-2}` and `A^ε_{-1}A^δ_{-1}` need `hεa : dotVec η ε a = 0`, which
  the four standing DDF hypotheses do **not** imply.
* The representation `ψ = levelTwoGen η v w` is **not unique** (only the symmetric part of
  `v` and the trace-shift are determined); the characterisation is an `∃`, so this is
  harmless, but no canonical form is provided.
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

/-- **`L_{-1}` on a general level-one state** (the creation-direction complement of
`Lop_neg_two_apply_one`, which only covers `L_{-2}` on the vacuum): `L_{-1}` applied to
`ζ · α_{-1}|k⟩` produces `(ζ · α_{-2})|k⟩ + (ζ·α_{-1})(k·α_{-1})|k⟩`. This characterises the
image of `L_{-1}` on the entire level-one fiber, needed for the `n = 1` piece of the spurious
submodule at level two. -/
lemma Lop_neg_one_apply_polState (hη : ∀ μ, η μ * η μ = 1) (e : Fin D → R) :
    Lop η a (-1) (polState η e) = secondState η e + polState η e * polState η a := by
  have hsq : ∀ (c : Fin D → R) (P : Fock D R),
      ∑ μ : Fin D, (η μ * c μ) • ((X ((μ, 1) : Osc D) : Fock D R) * P) = polState η c * P := by
    intro c P
    rw [polState, Finset.sum_mul]
    exact Finset.sum_congr rfl fun μ _ => (smul_mul_assoc _ _ _).symm
  have hL : Lop η a (-1) (1 : Fock D R) = polState η a := by
    rw [Lop_neg_one_apply_one, polState_eq_sum_mode η a a]
  have hterm : ∀ μ : Fin D,
      Lop η a (-1) ((η μ * e μ) • mode η a μ (-1) (1 : Fock D R))
        = (η μ * e μ) • ((X ((μ, 2) : Osc D) : Fock D R)
            + (X ((μ, 1) : Osc D) : Fock D R) * polState η a) := by
    intro μ
    rw [map_smul, Lop_apply_mode η a hη (-1) μ (-1) 1,
      show (-1 : ℤ) + -1 = -2 by ring, mode_neg_two_apply η a, mul_one, hL,
      mode_neg_one_apply η a]
    congr 2
    norm_num
  conv_lhs => rw [polState_eq_sum_mode η a e, map_sum, Finset.sum_congr rfl fun μ _ => hterm μ]
  simp_rw [smul_add]
  rw [Finset.sum_add_distrib, hsq e (polState η a)]
  rfl

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


/-! ### The vertex operator on a level-one state -/

section VertexOnPolState

variable (η c e : Fin D → R)

/-- `V_K` on a single oscillator: `V_K α^μ_{-1}|k⟩ = α^μ_{-1} Φ_K - c^μ Φ_{K+1}`. -/
lemma vertexOsc_apply_X_one (K : ℤ) (μ : Fin D) :
    vertexOsc η c K (X ((μ, 1) : Osc D) : Fock D R)
      = (X ((μ, 1) : Osc D) : Fock D R) * creaExp η c K - c μ • creaExp η c (K + 1) := by
  have h := vertexOsc_X_mul η c ((μ, 1) : Osc D) K 1
  rw [mul_one, vertexOsc_apply_one] at h
  rw [h, vertexOsc_apply_one]
  norm_num

/-- **`V_K` on a level-one state**:
`V_K (ζ·α_{-1})|k⟩ = (ζ·α_{-1}) Φ_K - (ζ·c) Φ_{K+1}`. -/
lemma vertexOsc_apply_polState (K : ℤ) :
    vertexOsc η c K (polState η e)
      = polState η e * creaExp η c K - dotVec η e c • creaExp η c (K + 1) := by
  have hmul : polState η e * creaExp η c K
      = ∑ μ : Fin D, (η μ * e μ) • ((X ((μ, 1) : Osc D) : Fock D R) * creaExp η c K) := by
    rw [polState, Finset.sum_mul]
    exact Finset.sum_congr rfl fun μ _ => smul_mul_assoc _ _ _
  have hdot : dotVec η e c • creaExp η c (K + 1)
      = ∑ μ : Fin D, (η μ * e μ * c μ) • creaExp η c (K + 1) := by
    rw [dotVec, Finset.sum_smul]
  have hterm : ∀ μ : Fin D,
      vertexOsc η c K ((η μ * e μ) • (X ((μ, 1) : Osc D) : Fock D R))
        = (η μ * e μ) • ((X ((μ, 1) : Osc D) : Fock D R) * creaExp η c K)
          - (η μ * e μ * c μ) • creaExp η c (K + 1) := fun μ => by
    rw [map_smul, vertexOsc_apply_X_one η c K μ, smul_sub, smul_smul]
  conv_lhs => rw [polState]
  rw [map_sum, Finset.sum_congr rfl fun μ _ => hterm μ, Finset.sum_sub_distrib, ← hmul, ← hdot]

variable {η}

/-- `α^μ_1` on a product of a level-one state and a creation exponential (Leibniz). -/
lemma mode_one_apply_polState_mul_creaExp (p : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (μ : Fin D) (K : ℤ) :
    mode η p μ 1 (polState η e * creaExp η c K)
      = e μ • creaExp η c K + c μ • (polState η e * creaExp η c (K - 1)) := by
  have hm : mode η p μ (1 : ℤ) = annihilation η μ 1 := by
    simpa using mode_pnat η p (1 : ℕ+) μ
  have hpol : annihilation η μ 1 (polState η e) = e μ • (1 : Fock D R) := by
    rw [← hm]
    exact mode_one_apply_polState η p hη e μ
  have hcre : annihilation η μ 1 (creaExp η c K) = c μ • creaExp η c (K - 1) := by
    simpa using annihilation_creaExp η c hη μ 1 K
  rw [hm, annihilation_mul, hpol, hcre, smul_mul_assoc, one_mul, mul_smul_comm]

end VertexOnPolState

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

/-! ### `A^ε_{-1} A^δ_{-1}` on the ground state -/

section DDFProduct

variable {D : ℕ} {R : Type*} [CommRing R]

/-- A polarised mode on a rung vector, written out. -/
lemma towerModeVec_apply_single (η a b ε : Fin D → R) (p i : ℤ) (Q : Fock D R) :
    towerModeVec η a b ε p (Finsupp.single i Q)
      = Finsupp.single i
          (∑ μ : Fin D, (η μ * ε μ) • Fock.mode η (towerMomentum a b i) μ p Q) := by
  rw [towerModeVec, LinearMap.sum_apply, Finsupp.single_finsetSum]
  exact Finset.sum_congr rfl fun μ _ => by
    rw [LinearMap.smul_apply, towerMode_single, Finsupp.smul_single]

lemma towerLevelBound_single_le (j : ℤ) (P : Fock D R) :
    towerLevelBound (Finsupp.single j P) ≤ Fock.levelBound P := by
  classical
  refine Finset.sup_le fun i hi => ?_
  have hij : i = j := by simpa using Finsupp.support_single_subset hi
  subst hij
  rw [Finsupp.single_eq_same]

lemma towerModeBound_single_le (j : ℤ) (P : Fock D R) :
    towerModeBound (Finsupp.single j P) ≤ Fock.modeBound P := by
  classical
  refine Finset.sup_le fun i hi => ?_
  have hij : i = j := by simpa using Finsupp.support_single_subset hi
  subst hij
  rw [Finsupp.single_eq_same]

lemma levelBound_le_of_mem_levelSubmodule {N : ℕ} {P : Fock D R}
    (hP : P ∈ Fock.levelSubmodule D R N) : Fock.levelBound P ≤ N := by
  classical
  exact Finset.sup_le fun d hd => le_of_eq (hP (MvPolynomial.mem_support_iff.mp hd))

variable [Algebra ℚ R]

/-- The DDF vertex operator on a level-one rung vector, using transversality of `δ`. -/
lemma towerVertex_apply_single_polState (η b δ : Fin D → R) (hδb : dotVec η δ b = 0)
    (n K j : ℤ) :
    towerVertex η b n K (Finsupp.single j (Fock.polState η δ))
      = Finsupp.single (j + n)
          (Fock.polState η δ * Fock.creaExp η (vertexMomentum b n) (K - n)) := by
  rw [towerVertex_single, Fock.vertexOsc_apply_polState, dotVec_vertexMomentum_right, hδb,
    mul_zero, zero_smul, sub_zero]

/-- `α^ε_1` on `(δ·α_{-1}) Φ_K`, when `ε` is orthogonal to the vertex momentum. -/
lemma towerModeVec_one_apply_single_polState_mul_creaExp (η a b ε δ c : Fin D → R)
    (hη : ∀ μ, η μ * η μ = 1) (hεc : dotVec η ε c = 0) (i K : ℤ) :
    towerModeVec η a b ε 1
        (Finsupp.single i (Fock.polState η δ * Fock.creaExp η c K))
      = Finsupp.single i (dotVec η ε δ • Fock.creaExp η c K) := by
  rw [towerModeVec_apply_single]
  congr 1
  have hterm : ∀ μ : Fin D,
      (η μ * ε μ) • Fock.mode η (towerMomentum a b i) μ 1
          (Fock.polState η δ * Fock.creaExp η c K)
        = (η μ * ε μ * δ μ) • Fock.creaExp η c K
          + (η μ * ε μ * c μ) • (Fock.polState η δ * Fock.creaExp η c (K - 1)) := fun μ => by
    rw [Fock.mode_one_apply_polState_mul_creaExp (c := c) (e := δ)
      (p := towerMomentum a b i) hη μ K, smul_add, smul_smul, smul_smul]
  rw [Finset.sum_congr rfl fun μ _ => hterm μ, Finset.sum_add_distrib, ← Finset.sum_smul,
    ← Finset.sum_smul, ← dotVec, ← dotVec, hεc, zero_smul, add_zero]

/-- **`A^ε_{-1}` on a transverse level-one rung vector.**  The window is `{-2,-1,0,1}`; only
`j = -1` and `j = 1` survive, and the `j = 1` term is the new feature compared with the
ground state: it is the central term `(ε·δ) Φ_2` of the DDF algebra. -/
theorem ddfOp_neg_one_apply_single_polState (η a b ε δ : Fin D → R)
    (hη : ∀ μ, η μ * η μ = 1) (hεb : dotVec η ε b = 0) (hδb : dotVec η δ b = 0)
    (hεa : dotVec η ε a = 0) :
    ddfOp η a b ε hη hεb (-1) (Finsupp.single (-1) (Fock.polState η δ))
      = Finsupp.single (-2) (Fock.polState η ε * Fock.polState η δ
          + dotVec η ε δ • Fock.creaExp η (vertexMomentum b (-1)) 2) := by
  classical
  set x : TowerFock D R := Finsupp.single (-1) (Fock.polState η δ) with hx
  have hεc : dotVec η ε (vertexMomentum b (-1)) = 0 := by
    rw [dotVec_vertexMomentum_right, hεb, mul_zero]
  have hlb : towerLevelBound x ≤ 1 :=
    le_trans (towerLevelBound_single_le _ _)
      (levelBound_le_of_mem_levelSubmodule (Fock.polState_mem_levelSubmodule_one δ))
  have hmb : towerModeBound x ≤ 1 :=
    le_trans (towerModeBound_single_le _ _)
      (Fock.modeBound_le_of_mem_levelSubmodule (Fock.polState_mem_levelSubmodule_one δ))
  have hs : ∀ j ∉ ({-2, -1, 0, 1} : Finset ℤ), ddfSummand η a b ε (-1) j x = 0 := by
    intro j hj
    simp only [Finset.mem_insert, Finset.mem_singleton, not_or] at hj
    obtain ⟨h1, h2, h3, h4⟩ := hj
    refine ddfSummand_apply_eq_zero_of_notMem_window η a b ε hη hεb (-1) x j ?_
    rw [ddfWindow, Finset.mem_Icc, not_and_or]
    rcases lt_or_ge j 0 with h | h
    · exact Or.inl (by omega)
    · exact Or.inr (by omega)
  have hterm : ∀ j : ℤ, ddfSummand η a b ε (-1) j x
      = towerModeVec η a b ε j (Finsupp.single (-2)
          (Fock.polState η δ * Fock.creaExp η (vertexMomentum b (-1)) (j + 1))) := by
    intro j
    rw [ddfSummand, Module.End.mul_apply, hx,
      towerVertex_apply_single_polState η b δ hδb (-1) j (-1),
      show (-1 : ℤ) + -1 = -2 by ring, show j - (-1) = j + 1 by ring]
  have hm2 : ddfSummand η a b ε (-1) (-2) x = 0 := by
    rw [hterm, Fock.creaExp_of_neg _ _ (show (-2 : ℤ) + 1 < 0 by norm_num), mul_zero,
      Finsupp.single_zero, map_zero]
  have hm1 : ddfSummand η a b ε (-1) (-1) x
      = Finsupp.single (-2) (Fock.polState η ε * Fock.polState η δ) := by
    rw [hterm, show (-1 : ℤ) + 1 = 0 by ring, Fock.creaExp_zero, mul_one,
      towerModeVec_neg_one_apply_single]
  have hz : ddfSummand η a b ε (-1) 0 x = 0 := by
    rw [hterm, towerModeVec_zero_apply_single, dotVec_vec_towerMomentum, hεa, hεb, mul_zero,
      add_zero, zero_smul]
  have hp1 : ddfSummand η a b ε (-1) 1 x
      = Finsupp.single (-2) (dotVec η ε δ • Fock.creaExp η (vertexMomentum b (-1)) 2) := by
    rw [hterm, show (1 : ℤ) + 1 = 2 by ring,
      towerModeVec_one_apply_single_polState_mul_creaExp η a b ε δ _ hη hεc (-2) 2]
  rw [ddfOp_apply η a b ε hη hεb (-1) x hs,
    Finset.sum_insert (by decide), Finset.sum_insert (by decide), Finset.sum_insert (by decide),
    Finset.sum_singleton, hm2, hm1, hz, hp1, zero_add, zero_add, ← Finsupp.single_add]

/-- `Φ_2` at vertex momentum `-k_0`:
`Φ_2 = ½[(k_0·α_{-1})² - (k_0·α_{-2})]`. -/
lemma creaExp_two_vertexMomentum_neg_one (η b : Fin D → R) :
    Fock.creaExp η (vertexMomentum b (-1)) 2
      = invTwo R • (Fock.polState η b * Fock.polState η b - Fock.secondState η b) := by
  have h1 : (((-1 : ℤ)) : R) = -1 := by norm_num
  rw [Fock.creaExp_two, Fock.polState_vertexMomentum, Fock.secondState_vertexMomentum, h1,
    neg_one_smul, neg_one_smul, neg_mul_neg, ← sub_eq_add_neg]

/-- **`A^ε_{-1} A^δ_{-1}` on the ground state** (`formal/TODO.md` item `noghost-b`,
blocker (a), second half):

`A^ε_{-1} A^δ_{-1}|0;k⟩ = [(ε·α_{-1})(δ·α_{-1})
    + ½ (ε·δ) ((k_0·α_{-1})² - (k_0·α_{-2}))] |0; k - 2k_0⟩`.

The correction is manifestly symmetric under `ε ↔ δ`, as it must be:
`⁅A^ε_{-1}, A^δ_{-1}⁆ = -(ε·δ) δ_{-2,0} = 0` (`lie_ddfOp_ddfOp`). -/
theorem ddfOp_neg_one_mul_ddfOp_neg_one_apply_towerVacuum (η a b ε δ : Fin D → R)
    (hη : ∀ μ, η μ * η μ = 1) (hεb : dotVec η ε b = 0) (hδb : dotVec η δ b = 0)
    (hεa : dotVec η ε a = 0) (hδa : dotVec η δ a = 0) :
    ddfOp η a b ε hη hεb (-1) (ddfOp η a b δ hη hδb (-1) (towerVacuum D R))
      = Finsupp.single (-2) (Fock.polState η ε * Fock.polState η δ
          + dotVec η ε δ • (invTwo R • (Fock.polState η b * Fock.polState η b
              - Fock.secondState η b))) := by
  rw [ddfOp_neg_one_apply_towerVacuum η a b δ hη hδb hδa,
    towerModeVec_neg_one_apply_single_vacuum,
    ddfOp_neg_one_apply_single_polState η a b ε δ hη hεb hδb hεa,
    creaExp_two_vertexMomentum_neg_one]

end DDFProduct

/-! ### The level-two DDF states, explicitly -/

section DDFSpanLevelTwo

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

/-- **The `A^ε_{-2}` DDF state at level two, explicitly.**  Together with
`single_ddfPair_mem_ddfSpan` these are the `(D-2) + (D-2)(D-1)/2` generators of the
level-two part of `ddfSpan` (blueprint §B.5's counting), now available as concrete vectors
in the Fock space. -/
theorem single_ddfSecond_mem_ddfSpan (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (Ε : TransverseFrame η b) (hεa : ∀ i, dotVec η (Ε.vec i) a = 0) (i : Fin (D - 2)) :
    (Finsupp.single (-2) (Fock.secondState η (Ε.vec i)
        - (2 : R) • (Fock.polState η (Ε.vec i) * Fock.polState η b)) : TowerFock D R)
      ∈ ddfSpan η a b hη Ε := by
  have h := ddfOp_towerVacuum_mem_ddfSpan η a b hη Ε i 2
  rwa [show (-(((2 : ℕ+) : ℕ) : ℤ)) = -2 by norm_num,
    ddfOp_neg_two_apply_towerVacuum η a b (Ε.vec i) hη (Ε.transverse i) (hεa i)] at h

/-- **The `A^ε_{-1} A^δ_{-1}` DDF states at level two, explicitly.**  The frame
orthonormality turns the correction term of
`ddfOp_neg_one_mul_ddfOp_neg_one_apply_towerVacuum` into a Kronecker delta. -/
theorem single_ddfPair_mem_ddfSpan (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (Ε : TransverseFrame η b) (hεa : ∀ i, dotVec η (Ε.vec i) a = 0) (i j : Fin (D - 2)) :
    (Finsupp.single (-2) (Fock.polState η (Ε.vec i) * Fock.polState η (Ε.vec j)
        + (if i = j then (1 : R) else 0) • (invTwo R • (Fock.polState η b * Fock.polState η b
            - Fock.secondState η b))) : TowerFock D R)
      ∈ ddfSpan η a b hη Ε := by
  have h := mem_ddfSpan_of_list η a b hη Ε [(i, 1), (j, 1)]
  simp only [List.foldr_cons, List.foldr_nil] at h
  rwa [show (-(((1 : ℕ+) : ℕ) : ℤ)) = -1 by norm_num,
    ddfOp_neg_one_mul_ddfOp_neg_one_apply_towerVacuum η a b (Ε.vec i) (Ε.vec j) hη
      (Ε.transverse i) (Ε.transverse j) (hεa i) (hεa j), Ε.orthonormal i j] at h

end DDFSpanLevelTwo

/-! ### The complete level-two slice of the tower physical subspace -/

section TowerLevelTwo

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

/-- **Blueprint §B.6, the `N = 2` physical-state analysis on the momentum tower.**

The bigraded piece `(rung j, level 2)` of `H_phys` consists exactly of the rung vectors
`|ψ⟩ = Σ_μ α^μ_{-1}(v_μ·α_{-1})|0;p_j⟩ + (w·α_{-2})|0;p_j⟩` whose parameters satisfy the
mass shell together with the `D + 1` linear equations `Fock.levelTwoL1 = 0`,
`Fock.levelTwoL2 = 0` for the rung momentum `p_j = k + j k_0`.  This is
`Fock.mem_physSubmodule_inf_levelSubmodule_two_iff` transported along
`single_mem_towerPhysSubmodule_iff`. -/
theorem mem_towerPhys_bigrade_two_iff (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (a₀ : R)
    (j : ℤ) {x : TowerFock D R} :
    x ∈ towerPhysSubmodule η a b a₀ ⊓ towerBigrade D R j 2 ↔
      ∃ (v : Fin D → Fin D → R) (w : Fin D → R),
        x = Finsupp.single j (Fock.levelTwoGen η v w) ∧
          (invTwo R * Fock.zeroModeSq η (towerMomentum a b j) + 2 - a₀) • x = 0 ∧
            Fock.levelTwoL1 η (towerMomentum a b j) v w = 0 ∧
              Fock.levelTwoL2 η (towerMomentum a b j) v w = 0 := by
  classical
  constructor
  · intro hmem
    obtain ⟨hphys, hbig⟩ := Submodule.mem_inf.1 hmem
    obtain ⟨hx1, hx2⟩ := mem_towerBigrade.1 hbig
    rw [hx1] at hphys
    rw [single_mem_towerPhysSubmodule_iff η a b a₀ j (x j)] at hphys
    obtain ⟨v, w, hvw, h0, h1, h2⟩ :=
      (Fock.mem_physSubmodule_inf_levelSubmodule_two_iff η (towerMomentum a b j) hη a₀).1
        (Submodule.mem_inf.2 ⟨hphys, hx2⟩)
    refine ⟨v, w, by rw [hx1, hvw], ?_, h1, h2⟩
    rw [hx1, Finsupp.smul_single, h0, Finsupp.single_zero]
  · rintro ⟨v, w, rfl, h0, h1, h2⟩
    rw [Finsupp.smul_single] at h0
    have h0' : (invTwo R * Fock.zeroModeSq η (towerMomentum a b j) + 2 - a₀)
        • Fock.levelTwoGen η v w = 0 := by
      have := congrArg (fun y : TowerFock D R => y j) h0
      simpa using this
    refine Submodule.mem_inf.2 ⟨?_, single_mem_towerBigrade
      (Fock.levelTwoGen_mem_levelSubmodule_two η v w)⟩
    rw [single_mem_towerPhysSubmodule_iff η a b a₀ j]
    exact ((Fock.mem_physSubmodule_inf_levelSubmodule_two_iff η (towerMomentum a b j) hη
      a₀).2 ⟨v, w, rfl, h0', h1, h2⟩).1

end TowerLevelTwo

end StringFormal.NoGhost
