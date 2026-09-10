/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.Sugawara

/-!
# Old covariant physical states, the adjoint `L_m^† = L_{-m}`, and null states

Graph nodes: `worldsheet.old-covariant-physical-states` (the definition of `H_phys` and of
null states); `worldsheet.open-string-intercept` (derivation `--via-null-state-decoupling`, the
level-one half); and the OCQ nodes `worldsheet.ocq-spurious-states`,
`worldsheet.spurious-orthogonal-to-physical` being added by the curator from Polchinski §4.1
(ids as announced on the bus on 2026-09-10; not yet on `main` when this file was written).
See `formal/TODO.md` item `physical-states`; builds on `StringFormal/NoGhost/Fock.lean` and
`StringFormal/NoGhost/Sugawara.lean`.

## Conventions

Inherited verbatim from `Sugawara.lean`: `conv.metric-mostly-plus` (diagonal `η : Fin D → R`,
with the hypothesis `hη : ∀ μ, η μ * η μ = 1` on every substantive statement),
`conv.alpha-prime-regge` (the zero mode is the *parameter* `a : Fin D → R` standing for
`a^μ = α^μ_0 = (2α')^{1/2} k^μ`, so `invTwo R * zeroModeSq η a = α' k²`),
`conv.virasoro-standard`, and creation–annihilation normal ordering with no normal-ordering
constant.  The intercept is called `a₀ : R` here, not `a`, because `a` is already the zero-mode
parameter; `conv.intercept-sign-a` fixes its sign (`a₀ = -A` of Polchinski).

## Main definitions

* `Fock.levelComponent D R N` — the level-`N` projection (Mathlib's
  `weightedHomogeneousComponent`).
* `Fock.physSubmodule η a a₀` — **`H_phys = {ψ : (L_0 - a₀)ψ = 0, L_n ψ = 0 ∀ n ≥ 1}`.**
* `Fock.orthComplement η W` — the `pairing`-orthogonal complement of a submodule.
* `Fock.nullSubmodule η a a₀` — the null (zero-norm) physical states
  `H_0 = {χ ∈ H_phys : ⟨χ, ψ⟩ = 0 ∀ ψ ∈ H_phys}`.
* `Fock.spuriousSubmodule η a` — the span of the images of `L_{-n}`, `n ≥ 1`.
* `Fock.polState η e` — the level-one state `ζ·α_{-1}|k⟩ = η_{μν} ζ^μ α^ν_{-1}|k⟩`, `ζ = e`.

## Main statements

* `Fock.pairing_mode_left` — `(α^μ_j)^† = α^μ_{-j}` for every `j : ℤ` (including `j = 0`).
* `Fock.pairing_nordPair_left` — the same for `:α_i · α_j:`.
* `Fock.pairing_Lop_left` — **`⟨L_m v, w⟩ = ⟨v, L_{-m} w⟩`, i.e. `L_m^† = L_{-m}`.**  This is
  the gap listed under "Not proved here" in `Sugawara.lean`; it is what makes old covariant
  quantisation work and is needed throughout the no-ghost theorem.
* `Fock.mode_mem_levelSubmodule`, `Fock.nordPair_mem_levelSubmodule`,
  `Fock.Lop_mem_levelSubmodule`, `Fock.levelComponent_Lop` — **`α^μ_j` and `L_n` are
  homogeneous** of degrees `-j` and `-n` for the level grading.
* `Fock.levelComponent_mem_physSubmodule`, `Fock.physSubmodule_eq_iSup_inf_levelSubmodule` —
  **`H_phys` is graded by level**: the level components of a physical state are physical, and
  `H_phys = ⨆_N (H_phys ⊓ F_N)`.
* `Fock.mem_physSubmodule_iff_of_mem_levelSubmodule`,
  `Fock.mem_physSubmodule_inf_levelSubmodule_iff` — on the level-`N` piece the `L_0` condition
  is the scalar mass-shell condition `α' k² + N = a₀`.
* `Fock.massShell_of_mem_physSubmodule` — over a ring without zero divisors, a nonzero physical
  state of level `N` forces `α' k² + N = a₀` on the nose.
* `Fock.spuriousSubmodule_le_orthComplement` — **spurious states are orthogonal to physical
  states** (immediate from `pairing_Lop_left`).
* `Fock.spurious_inf_physSubmodule_le_nullSubmodule` — **spurious ∩ physical ⊆ null.**
* `Fock.mem_physSubmodule_inf_levelSubmodule_one_iff` — the level-one slice of `H_phys`:
  exactly the transverse polarisations `ζ · k = 0` on the shell `α' k² + 1 = a₀`.
* `Fock.Lop_neg_one_apply_one_mem_nullSubmodule` — at intercept `a₀ = 1` and on the massless
  shell `k² = 0`, `L_{-1}|k⟩` is a physical *null* state: the longitudinal photon decouples.

## Mathematical gaps (for the dependency graph)

1. **The level grading is a `⨆`, not a `DirectSum`.**  `physSubmodule_eq_iSup_inf_levelSubmodule`
   says `H_phys = ⨆_N (H_phys ⊓ F_N)`; that this supremum is *internally direct* is true (the
   `F_N` are the weighted-homogeneous pieces of a polynomial ring) but is not packaged as a
   `DirectSum.IsInternal` here, because `Fock.lean` does not provide it for the Fock space
   itself.  Nothing below needs it.
2. **Only one half of "spurious ∩ physical = null".**  The reverse inclusion (every null
   physical state is spurious) is a genuinely hard part of the no-ghost theorem and is *not*
   proved here.
3. **The bilinear, not sesquilinear, form.**  `Fock.pairing` is `R`-bilinear, so `†` means
   transpose.  Over `ℝ` with real polarisations this agrees with the physical Hermitian form;
   a complex Fock space with conjugation is not formalised.
4. **The null photon is one direction only.**  `Lop_neg_one_apply_one_mem_nullSubmodule` shows
   that at `a₀ = 1`, `k² = 0` the state `L_{-1}|k⟩` *is* null.  That `a₀ = 1` is the *only*
   intercept for which the level-one longitudinal state decouples, and the level-two analysis
   that also forces `D = 26`, are not formalised.
5. **Zero modes.**  Inherited from `Sugawara.lean`: the momentum enters only as the parameter
   `a`; there is no `x^μ`, and no direct integral over `k`.  In particular `physSubmodule` is
   the physical subspace of *one* momentum tower; the graph node
   `worldsheet.old-covariant-physical-states` speaks of the whole Fock space.
6. **`polState` uses a lowered polarisation.**  `polState η e = Σ_μ η^{μμ} e^μ α^μ_{-1}|k⟩`,
   i.e. `η_{μν} ζ^μ α^ν_{-1}`, so that transversality reads `Σ_μ η^{μμ} e^μ a^μ = ζ·k = 0`.
   Because `η² = 1`, the map `e ↦ polState η e` is onto the level-one piece
   (`exists_polState_of_mem_levelSubmodule_one`), so no generality is lost.

## Status

Complete, no `sorry`; axioms are `propext`, `Classical.choice`, `Quot.sound` only.
-/

namespace StringFormal.NoGhost

open MvPolynomial

namespace Fock

variable {D : ℕ} {R : Type*} [CommRing R]

/-! ### Adjointness of the oscillator modes -/

section Adjoint

variable (η a : Fin D → R)

/-- `(α^μ_j)^† = α^μ_{-j}` for **every** `j : ℤ`, including `j = 0` where both sides are the
scalar `a^μ`. -/
theorem pairing_mode_left (μ : Fin D) (j : ℤ) (v w : Fock D R) :
    pairing η (mode η a μ j v) w = pairing η v (mode η a μ (-j) w) := by
  rcases lt_trichotomy j 0 with hj | hj | hj
  · rw [mode_of_neg η a hj μ, mode_of_pos η a (by omega : (0 : ℤ) < -j) μ]
    exact pairing_creation_left η μ _ v w
  · subst hj
    rw [neg_zero, mode_zero, LinearMap.smul_apply, LinearMap.id_coe, id_eq,
      LinearMap.smul_apply, LinearMap.id_coe, id_eq, map_smul, LinearMap.smul_apply, map_smul]
  · rw [mode_of_pos η a hj μ, mode_of_neg η a (by omega : -j < 0) μ, neg_neg]
    exact (pairing_creation_right η μ _ v w).symm

/-- `⟨v, α^μ_j w⟩ = ⟨α^μ_{-j} v, w⟩`. -/
theorem pairing_mode_right (μ : Fin D) (j : ℤ) (v w : Fock D R) :
    pairing η v (mode η a μ j w) = pairing η (mode η a μ (-j) v) w := by
  rw [pairing_mode_left, neg_neg]

/-- The normal-ordered bilinear `:α_i · α_j:` has adjoint `:α_{-i} · α_{-j}:`. -/
theorem pairing_nordPair_left (i j : ℤ) (v w : Fock D R) :
    pairing η (nordPair η a i j v) w = pairing η v (nordPair η a (-i) (-j) w) := by
  have main : ∀ i' j' : ℤ, i' ≤ j' → ∀ v w : Fock D R,
      pairing η (nordPair η a i' j' v) w = pairing η v (nordPair η a (-i') (-j') w) := by
    intro i' j' hij v w
    rw [nordPair_apply_of_le η a hij, nordPair_comm η a (-i') (-j'),
      nordPair_apply_of_le η a (by omega : -j' ≤ -i'), map_sum, LinearMap.sum_apply, map_sum]
    refine Finset.sum_congr rfl fun μ _ => ?_
    rw [map_smul, LinearMap.smul_apply, map_smul, smul_eq_mul, smul_eq_mul,
      pairing_mode_left η a μ i', pairing_mode_left η a μ j']
  rcases le_total i j with hij | hij
  · exact main i j hij v w
  · rw [nordPair_comm η a i j, nordPair_comm η a (-i) (-j)]
    exact main j i hij v w

end Adjoint

/-! ### Adjointness of the Virasoro generators: `L_m^† = L_{-m}` -/

section AdjointLop

variable [Algebra ℚ R] (η a : Fin D → R)

omit [Algebra ℚ R] in
/-- A symmetric index interval large enough to compute both `L_m v` and `L_{-m} w`. -/
private lemma nordPair_apply_eq_zero_of_notMem_Icc (m : ℤ) (v w : Fock D R) :
    ∀ j ∉ Finset.Icc (-((max (modeBound v) (modeBound w) : ℤ) + |m|))
        ((max (modeBound v) (modeBound w) : ℤ) + |m|),
      nordPair η a (m - j) j v = 0 := by
  intro j hj
  set B : ℤ := (max (modeBound v) (modeBound w) : ℤ) + |m| with hB
  have hmb : (modeBound v : ℤ) ≤ (max (modeBound v) (modeBound w) : ℤ) := by
    exact_mod_cast Nat.le_max_left _ _
  have habs : -|m| ≤ m := neg_abs_le m
  have habs0 : (0 : ℤ) ≤ |m| := abs_nonneg m
  rw [Finset.mem_Icc, not_and_or] at hj
  refine nordPair_apply_eq_zero_of_modeBound_lt η a _ _ ?_
  rcases hj with h | h
  · exact lt_of_lt_of_le (by omega) (le_max_left (m - j) j)
  · exact lt_of_lt_of_le (by omega) (le_max_right (m - j) j)

/-- **`L_m^† = L_{-m}` for the Fock form**: `⟨L_m v, w⟩ = ⟨v, L_{-m} w⟩`.

This is the adjointness relation that makes the old covariant quantisation work; it is the
statement `(α^μ_n)^† = α^μ_{-n}` (`Fock.pairing_creation_left`) propagated through the
Sugawara sum.  Note that no reality/positivity assumption on `η` or on the zero mode `a` is
needed: the form is `R`-bilinear, not sesquilinear. -/
theorem pairing_Lop_left (m : ℤ) (v w : Fock D R) :
    pairing η (Lop η a m v) w = pairing η v (Lop η a (-m) w) := by
  classical
  set B : ℤ := (max (modeBound v) (modeBound w) : ℤ) + |m| with hB
  have hv : ∀ j ∉ Finset.Icc (-B) B, nordPair η a (m - j) j v = 0 :=
    nordPair_apply_eq_zero_of_notMem_Icc η a m v w
  have hw : ∀ j ∉ Finset.Icc (-B) B, nordPair η a (-m - j) j w = 0 := by
    have h := nordPair_apply_eq_zero_of_notMem_Icc η a (-m) w v
    rw [abs_neg, max_comm] at h
    exact h
  rw [Lop_apply η a m v hv, Lop_apply η a (-m) w hw, map_smul, LinearMap.smul_apply,
    map_smul, smul_eq_mul, smul_eq_mul, map_sum, LinearMap.sum_apply, map_sum]
  congr 1
  refine Finset.sum_equiv (Equiv.neg ℤ) (fun j => ?_) (fun j _ => ?_)
  · simp only [Equiv.neg_apply, Finset.mem_Icc]
    omega
  · rw [pairing_nordPair_left η a]
    simp only [Equiv.neg_apply]
    rw [show -(m - j) = -m - -j by ring]

/-- `⟨v, L_m w⟩ = ⟨L_{-m} v, w⟩`. -/
theorem pairing_Lop_right (m : ℤ) (v w : Fock D R) :
    pairing η v (Lop η a m w) = pairing η (Lop η a (-m) v) w := by
  rw [pairing_Lop_left, neg_neg]

end AdjointLop

/-! ### Level components, and the homogeneity of the modes and of `L_n` -/

section Grading

/-- The level-`N` component of a Fock vector (Mathlib's `weightedHomogeneousComponent`). -/
noncomputable def levelComponent (D : ℕ) (R : Type*) [CommRing R] (N : ℕ) :
    Fock D R →ₗ[R] Fock D R :=
  weightedHomogeneousComponent (oscLevel D) N

lemma coeff_levelComponent (N : ℕ) (P : Fock D R) (d : Osc D →₀ ℕ) :
    coeff d (levelComponent D R N P) = if level D d = N then coeff d P else 0 :=
  coeff_weightedHomogeneousComponent N P d

lemma levelComponent_mem (N : ℕ) (P : Fock D R) :
    levelComponent D R N P ∈ levelSubmodule D R N :=
  weightedHomogeneousComponent_mem (oscLevel D) P N

lemma levelComponent_of_mem {M N : ℕ} {P : Fock D R} (hP : P ∈ levelSubmodule D R M) :
    levelComponent D R N P = if N = M then P else 0 :=
  weightedHomogeneousComponent_of_mem hP

lemma levelComponent_of_mem_self {N : ℕ} {P : Fock D R} (hP : P ∈ levelSubmodule D R N) :
    levelComponent D R N P = P := by
  rw [levelComponent_of_mem hP, if_pos rfl]

lemma levelComponent_of_mem_ne {M N : ℕ} (hNM : N ≠ M) {P : Fock D R}
    (hP : P ∈ levelSubmodule D R M) : levelComponent D R N P = 0 := by
  rw [levelComponent_of_mem hP, if_neg hNM]

lemma monomial_mem_levelSubmodule (d : Osc D →₀ ℕ) (c : R) :
    (monomial d c : Fock D R) ∈ levelSubmodule D R (level D d) :=
  isWeightedHomogeneous_monomial (oscLevel D) d c rfl

/-- Every Fock vector is the (finite) sum of its level components. -/
theorem sum_levelComponent (P : Fock D R) :
    ∑ N ∈ P.support.image (level D), levelComponent D R N P = P := by
  classical
  refine MvPolynomial.ext _ _ fun d => ?_
  rw [coeff_sum]
  simp only [coeff_levelComponent]
  rw [Finset.sum_ite_eq]
  by_cases hd : coeff d P = 0
  · rw [hd, ite_self]
  · rw [if_pos (Finset.mem_image_of_mem _ (mem_support_iff.mpr hd))]

/-- Level-`M` states involve only oscillators of mode number `≤ M`. -/
lemma modeBound_le_of_mem_levelSubmodule {M : ℕ} {P : Fock D R}
    (hP : P ∈ levelSubmodule D R M) : modeBound P ≤ M := by
  classical
  refine Finset.sup_le fun v hv => ?_
  obtain ⟨d, hd, hvd⟩ := (mem_vars_iff_mem_support v).mp hv
  exact mode_le_of_mem_support_of_level_eq (hP (mem_support_iff.mp hd)) hvd

variable (η a : Fin D → R)

/-- A mode `α^μ_j` of positive index larger than the level kills the state. -/
lemma mode_apply_eq_zero_of_level_lt {M : ℕ} {P : Fock D R} (hP : P ∈ levelSubmodule D R M)
    {j : ℤ} (hj : (M : ℤ) < j) (μ : Fin D) : mode η a μ j P = 0 :=
  mode_apply_eq_zero_of_modeBound_lt η a μ
    (lt_of_le_of_lt (by exact_mod_cast modeBound_le_of_mem_levelSubmodule hP) hj)

/-- **The modes are homogeneous**: `α^μ_j` lowers the level by `j`. -/
lemma mode_mem_levelSubmodule {M : ℕ} {P : Fock D R} (hP : P ∈ levelSubmodule D R M)
    {j : ℤ} {M' : ℕ} (hM' : (M' : ℤ) = M - j) (μ : Fin D) :
    mode η a μ j P ∈ levelSubmodule D R M' := by
  rcases lt_trichotomy j 0 with hj | rfl | hj
  · rw [mode_of_neg η a hj μ]
    have hM : M' = ((-j).toNat.toPNat' : ℕ) + M := by
      rw [Nat.toPNat'_coe, if_pos (by omega)]
      omega
    rw [hM]
    exact creation_mem_levelSubmodule μ _ hP
  · rw [mode_zero, LinearMap.smul_apply, LinearMap.id_coe, id_eq]
    have hM : M' = M := by omega
    rw [hM]
    exact Submodule.smul_mem _ _ hP
  · rw [mode_of_pos η a hj μ]
    refine annihilation_mem_levelSubmodule η μ _ ?_
    have hM : M' + (j.toNat.toPNat' : ℕ) = M := by
      rw [toPNat'_coe_of_pos hj]
      omega
    rw [hM]
    exact hP

/-- `:α_i · α_j:` kills states of level `< i + j`. -/
lemma nordPair_apply_eq_zero_of_level_lt {M : ℕ} {P : Fock D R} (hP : P ∈ levelSubmodule D R M)
    {i j : ℤ} (hij : (M : ℤ) < i + j) : nordPair η a i j P = 0 := by
  have main : ∀ i' j' : ℤ, i' ≤ j' → (M : ℤ) < i' + j' → nordPair η a i' j' P = 0 := by
    intro i' j' hle hlt
    rw [nordPair_apply_of_le η a hle]
    refine Finset.sum_eq_zero fun μ _ => ?_
    by_cases hj : (M : ℤ) < j'
    · rw [mode_apply_eq_zero_of_level_lt η a hP hj, map_zero, smul_zero]
    · have hmem := mode_mem_levelSubmodule η a hP (j := j')
        (M' := ((M : ℤ) - j').toNat) (by omega) μ
      rw [mode_apply_eq_zero_of_level_lt η a hmem (j := i') (by omega) μ, smul_zero]
  rcases le_total i j with h | h
  · exact main i j h hij
  · rw [nordPair_comm η a]
    exact main j i h (by omega)

/-- **`:α_i · α_j:` is homogeneous**: it lowers the level by `i + j`. -/
lemma nordPair_mem_levelSubmodule {M : ℕ} {P : Fock D R} (hP : P ∈ levelSubmodule D R M)
    {i j : ℤ} {M' : ℕ} (hM' : (M' : ℤ) = M - i - j) :
    nordPair η a i j P ∈ levelSubmodule D R M' := by
  have main : ∀ i' j' : ℤ, i' ≤ j' → (M' : ℤ) = M - i' - j' →
      nordPair η a i' j' P ∈ levelSubmodule D R M' := by
    intro i' j' hle hM
    rw [nordPair_apply_of_le η a hle]
    refine Submodule.sum_mem _ fun μ _ => Submodule.smul_mem _ _ ?_
    by_cases hj : (M : ℤ) < j'
    · rw [mode_apply_eq_zero_of_level_lt η a hP hj, map_zero]
      exact Submodule.zero_mem _
    · exact mode_mem_levelSubmodule η a
        (mode_mem_levelSubmodule η a hP (j := j') (M' := ((M : ℤ) - j').toNat) (by omega) μ)
        (j := i') (by omega) μ
  rcases le_total i j with h | h
  · exact main i j h hM'
  · rw [nordPair_comm η a]
    exact main j i h (by omega)

variable [Algebra ℚ R]

/-- `L_n` kills states of level `< n`. -/
theorem Lop_apply_eq_zero_of_level_lt {M : ℕ} {P : Fock D R} (hP : P ∈ levelSubmodule D R M)
    {n : ℤ} (hn : (M : ℤ) < n) : Lop η a n P = 0 := by
  rw [Lop_apply_LopIdx]
  rw [Finset.sum_eq_zero fun j _ =>
    nordPair_apply_eq_zero_of_level_lt η a hP (i := n - j) (j := j) (by omega)]
  rw [smul_zero]

/-- **`L_n` is homogeneous of degree `-n`**: it maps the level-`M` piece into the
level-`(M - n)` piece. -/
theorem Lop_mem_levelSubmodule {M : ℕ} {P : Fock D R} (hP : P ∈ levelSubmodule D R M) {n : ℤ}
    {M' : ℕ} (hM' : (M' : ℤ) = M - n) : Lop η a n P ∈ levelSubmodule D R M' := by
  rw [Lop_apply_LopIdx]
  refine Submodule.smul_mem _ _ (Submodule.sum_mem _ fun j _ => ?_)
  exact nordPair_mem_levelSubmodule η a hP (by omega)

/-- `L_n` intertwines the level projections: `(L_n P)_{N - n} = L_n (P_N)`. -/
theorem levelComponent_Lop (n : ℤ) {N N' : ℕ} (hN : (N' : ℤ) = N - n) (P : Fock D R) :
    levelComponent D R N' (Lop η a n P) = Lop η a n (levelComponent D R N P) := by
  classical
  have key : levelComponent D R N' ∘ₗ Lop η a n = Lop η a n ∘ₗ levelComponent D R N := by
    apply (MvPolynomial.basisMonomials (Osc D) R).ext
    intro d
    rw [basisMonomials_apply, LinearMap.comp_apply, LinearMap.comp_apply,
      levelComponent_of_mem (monomial_mem_levelSubmodule d 1)]
    by_cases hlt : (level D d : ℤ) < n
    · rw [Lop_apply_eq_zero_of_level_lt η a (monomial_mem_levelSubmodule d 1) hlt, map_zero,
        if_neg (by omega), map_zero]
    · rw [levelComponent_of_mem
        (Lop_mem_levelSubmodule η a (monomial_mem_levelSubmodule d 1)
          (M' := ((level D d : ℤ) - n).toNat) (by omega))]
      by_cases hN' : N = level D d
      · rw [if_pos hN', if_pos (by omega)]
      · rw [if_neg hN', if_neg (by omega), map_zero]
  exact congrArg (fun f : Fock D R →ₗ[R] Fock D R => f P) key

end Grading

/-! ### The physical state subspace -/

section Phys

variable [Algebra ℚ R] (η a : Fin D → R) (a₀ : R)

/-- **The old covariant physical state subspace** (graph node
`worldsheet.old-covariant-physical-states`):

`H_phys = {ψ : (L_0 - a₀) ψ = 0 and L_n ψ = 0 for all n ≥ 1}`.

Here `a₀ : R` is the intercept (called `a` in the physics literature; renamed to avoid a clash
with the zero-mode parameter `a : Fin D → R` of `Fock.Lop`, which stands for
`a^μ = α^μ_0 = (2α')^{1/2} k^μ`).  It is a submodule because it is an intersection of kernels
of linear maps. -/
noncomputable def physSubmodule : Submodule R (Fock D R) :=
  LinearMap.ker (Lop η a 0 - a₀ • (LinearMap.id : Module.End R (Fock D R))) ⊓
    ⨅ n : ℤ, ⨅ _ : 0 < n, LinearMap.ker (Lop η a n)

variable {η a a₀}

lemma mem_physSubmodule {ψ : Fock D R} :
    ψ ∈ physSubmodule η a a₀ ↔
      Lop η a 0 ψ = a₀ • ψ ∧ ∀ n : ℤ, 0 < n → Lop η a n ψ = 0 := by
  simp only [physSubmodule, Submodule.mem_inf, Submodule.mem_iInf, LinearMap.mem_ker,
    LinearMap.sub_apply, LinearMap.smul_apply, LinearMap.id_coe, id_eq, sub_eq_zero]

lemma Lop_zero_apply_of_mem_physSubmodule {ψ : Fock D R} (hψ : ψ ∈ physSubmodule η a a₀) :
    Lop η a 0 ψ = a₀ • ψ := (mem_physSubmodule.mp hψ).1

lemma Lop_apply_eq_zero_of_mem_physSubmodule {ψ : Fock D R} (hψ : ψ ∈ physSubmodule η a a₀)
    {n : ℤ} (hn : 0 < n) : Lop η a n ψ = 0 := (mem_physSubmodule.mp hψ).2 n hn

lemma mem_physSubmodule_of {ψ : Fock D R} (h0 : Lop η a 0 ψ = a₀ • ψ)
    (hpos : ∀ n : ℤ, 0 < n → Lop η a n ψ = 0) : ψ ∈ physSubmodule η a a₀ :=
  mem_physSubmodule.mpr ⟨h0, hpos⟩

/-! ### `H_phys` is graded by level -/

/-- **The level components of a physical state are physical.**  This is the content of
"`H_phys` decomposes into level pieces": it follows from the homogeneity of the `L_n`
(`levelComponent_Lop`), and needs no hypothesis on `η`. -/
theorem levelComponent_mem_physSubmodule {ψ : Fock D R} (hψ : ψ ∈ physSubmodule η a a₀)
    (N : ℕ) : levelComponent D R N ψ ∈ physSubmodule η a a₀ := by
  obtain ⟨h0, hpos⟩ := mem_physSubmodule.mp hψ
  refine mem_physSubmodule_of ?_ fun n hn => ?_
  · rw [← levelComponent_Lop η a 0 (N := N) (N' := N) (by simp) ψ, h0, map_smul]
  · by_cases hlt : (N : ℤ) < n
    · exact Lop_apply_eq_zero_of_level_lt η a (levelComponent_mem N ψ) hlt
    · rw [← levelComponent_Lop η a n (N := N) (N' := ((N : ℤ) - n).toNat) (by omega) ψ,
        hpos n hn, map_zero]

variable (η a a₀)

/-- A state is physical iff all its level components are. -/
theorem mem_physSubmodule_iff_levelComponent {ψ : Fock D R} :
    ψ ∈ physSubmodule η a a₀ ↔ ∀ N : ℕ, levelComponent D R N ψ ∈ physSubmodule η a a₀ := by
  refine ⟨fun h N => levelComponent_mem_physSubmodule h N, fun h => ?_⟩
  rw [← sum_levelComponent ψ]
  exact Submodule.sum_mem _ fun N _ => h N

/-- **`H_phys` is the sum of its level slices** `H_phys ⊓ F_N`.  (The sum is direct because
the `F_N` are; see `Fock.pairing_eq_zero_of_level_ne` for the orthogonality of distinct
slices.) -/
theorem physSubmodule_eq_iSup_inf_levelSubmodule :
    physSubmodule η a a₀ = ⨆ N : ℕ, physSubmodule η a a₀ ⊓ levelSubmodule D R N := by
  refine le_antisymm (fun ψ hψ => ?_) (iSup_le fun N => inf_le_left)
  rw [← sum_levelComponent ψ]
  refine Submodule.sum_mem _ fun N _ => Submodule.mem_iSup_of_mem N ?_
  exact Submodule.mem_inf.mpr ⟨levelComponent_mem_physSubmodule hψ N, levelComponent_mem N ψ⟩

variable {η a a₀}

/-! ### The physical states of a fixed level: the mass-shell condition -/

variable (η a a₀)

/-- On the level-`N` piece the `L_0` condition is multiplication by the *scalar*
`α' k² + N - a₀` (here `invTwo R * zeroModeSq η a` is `α' k²`, convention
`conv.alpha-prime-regge`). -/
theorem sub_intercept_apply_of_mem_levelSubmodule (hη : ∀ μ, η μ * η μ = 1) {N : ℕ}
    {ψ : Fock D R} (hψ : ψ ∈ levelSubmodule D R N) :
    (Lop η a 0 - a₀ • (LinearMap.id : Module.End R (Fock D R))) ψ
      = (invTwo R * zeroModeSq η a + (N : R) - a₀) • ψ := by
  rw [LinearMap.sub_apply, Lop_zero_apply_of_mem_levelSubmodule η a hη hψ,
    LinearMap.smul_apply, LinearMap.id_coe, id_eq, ← sub_smul]

/-- **The level characterisation of `H_phys`**: on the level-`N` piece the `L_0` condition
becomes the mass-shell condition `α' k² + N = a₀` (as a scalar annihilating `ψ`), and only the
`L_n`, `n ≥ 1`, conditions remain. -/
theorem mem_physSubmodule_iff_of_mem_levelSubmodule (hη : ∀ μ, η μ * η μ = 1) {N : ℕ}
    {ψ : Fock D R} (hψ : ψ ∈ levelSubmodule D R N) :
    ψ ∈ physSubmodule η a a₀ ↔
      (invTwo R * zeroModeSq η a + (N : R) - a₀) • ψ = 0 ∧
        ∀ n : ℤ, 0 < n → Lop η a n ψ = 0 := by
  have hkey := sub_intercept_apply_of_mem_levelSubmodule η a a₀ hη hψ
  rw [LinearMap.sub_apply, LinearMap.smul_apply, LinearMap.id_coe, id_eq] at hkey
  rw [mem_physSubmodule]
  constructor
  · rintro ⟨h0, hpos⟩
    exact ⟨by rw [← hkey, h0, sub_self], hpos⟩
  · rintro ⟨h0, hpos⟩
    refine ⟨?_, hpos⟩
    rw [h0] at hkey
    exact sub_eq_zero.mp hkey

/-- The description of the level-`N` slice of `H_phys`. -/
theorem mem_physSubmodule_inf_levelSubmodule_iff (hη : ∀ μ, η μ * η μ = 1) (N : ℕ)
    {ψ : Fock D R} :
    ψ ∈ physSubmodule η a a₀ ⊓ levelSubmodule D R N ↔
      ψ ∈ levelSubmodule D R N ∧
        (invTwo R * zeroModeSq η a + (N : R) - a₀) • ψ = 0 ∧
          ∀ n : ℤ, 0 < n → Lop η a n ψ = 0 := by
  rw [Submodule.mem_inf]
  constructor
  · rintro ⟨hphys, hlev⟩
    exact ⟨hlev, (mem_physSubmodule_iff_of_mem_levelSubmodule η a a₀ hη hlev).mp hphys⟩
  · rintro ⟨hlev, h⟩
    exact ⟨(mem_physSubmodule_iff_of_mem_levelSubmodule η a a₀ hη hlev).mpr h, hlev⟩

/-- **The mass shell.**  Over a ring without zero divisors a nonzero physical state of level
`N` satisfies `α' k² + N = a₀`; with `m² = -k²` this is `α' m² = N - a₀`
(conventions `conv.alpha-prime-regge`, `conv.intercept-sign-a`). -/
theorem massShell_of_mem_physSubmodule [NoZeroDivisors R] (hη : ∀ μ, η μ * η μ = 1) {N : ℕ}
    {ψ : Fock D R} (hlev : ψ ∈ levelSubmodule D R N) (hphys : ψ ∈ physSubmodule η a a₀)
    (hne : ψ ≠ 0) :
    invTwo R * zeroModeSq η a + (N : R) = a₀ := by
  classical
  have h := ((mem_physSubmodule_iff_of_mem_levelSubmodule η a a₀ hη hlev).mp hphys).1
  obtain ⟨d, hd⟩ : ∃ d : Osc D →₀ ℕ, coeff d ψ ≠ 0 := by
    by_contra hc
    exact hne (MvPolynomial.ext _ _ fun d => by
      rw [coeff_zero]
      exact not_not.mp (not_exists.mp hc d))
  have hcoeff : (invTwo R * zeroModeSq η a + (N : R) - a₀) * coeff d ψ = 0 := by
    have h' := congrArg (coeff d) h
    rwa [coeff_smul, smul_eq_mul, coeff_zero] at h'
  rcases mul_eq_zero.mp hcoeff with h' | h'
  · rw [sub_eq_zero] at h'
    exact h'
  · exact absurd h' hd

end Phys

/-! ### Null states -/

section Null

variable (η : Fin D → R)

/-- The orthogonal complement of a submodule for the Fock form.  (The form is indefinite, so
this is *not* a complement: it can meet `W` nontrivially — that intersection is exactly the
space of null states when `W = H_phys`.) -/
noncomputable def orthComplement (η : Fin D → R) (W : Submodule R (Fock D R)) :
    Submodule R (Fock D R) :=
  ⨅ ψ : W, LinearMap.ker ((pairing η).flip (ψ : Fock D R))

lemma mem_orthComplement {W : Submodule R (Fock D R)} {χ : Fock D R} :
    χ ∈ orthComplement η W ↔ ∀ ψ ∈ W, pairing η χ ψ = 0 := by
  simp only [orthComplement, Submodule.mem_iInf, LinearMap.mem_ker, LinearMap.flip_apply,
    Subtype.forall]

variable [Algebra ℚ R] (a : Fin D → R) (a₀ : R)

/-- **Null (zero-norm) physical states**: physical states orthogonal to every physical
state. -/
noncomputable def nullSubmodule : Submodule R (Fock D R) :=
  physSubmodule η a a₀ ⊓ orthComplement η (physSubmodule η a a₀)

variable {η a a₀}

lemma mem_nullSubmodule {χ : Fock D R} :
    χ ∈ nullSubmodule η a a₀ ↔
      χ ∈ physSubmodule η a a₀ ∧ ∀ ψ ∈ physSubmodule η a a₀, pairing η χ ψ = 0 := by
  rw [nullSubmodule, Submodule.mem_inf, mem_orthComplement]

/-- A null state has zero norm. -/
theorem pairing_self_eq_zero_of_mem_nullSubmodule {χ : Fock D R}
    (hχ : χ ∈ nullSubmodule η a a₀) : pairing η χ χ = 0 :=
  (mem_nullSubmodule.mp hχ).2 χ (mem_nullSubmodule.mp hχ).1

theorem nullSubmodule_le_physSubmodule : nullSubmodule η a a₀ ≤ physSubmodule η a a₀ :=
  inf_le_left

variable (η a)

/-- **Spurious states**: the span of the images of the lowering operators `L_{-n}`, `n ≥ 1`
(graph node `worldsheet.ocq-spurious-states`, pending).  This does not depend on the
intercept. -/
noncomputable def spuriousSubmodule : Submodule R (Fock D R) :=
  ⨆ n : ℤ, ⨆ _ : 0 < n, LinearMap.range (Lop η a (-n))

lemma Lop_neg_mem_spuriousSubmodule {n : ℤ} (hn : 0 < n) (ψ : Fock D R) :
    Lop η a (-n) ψ ∈ spuriousSubmodule η a :=
  Submodule.mem_iSup_of_mem n (Submodule.mem_iSup_of_mem hn ⟨ψ, rfl⟩)

variable (a₀)

/-- **Spurious states are orthogonal to physical states.**  This is the direct consequence of
`L_{-n}^† = L_n` (`pairing_Lop_left`) and `L_n ψ = 0` for `n ≥ 1` on physical states.  Graph
node `worldsheet.spurious-orthogonal-to-physical` (pending). -/
theorem spuriousSubmodule_le_orthComplement :
    spuriousSubmodule η a ≤ orthComplement η (physSubmodule η a a₀) := by
  refine iSup_le fun n => iSup_le fun hn => ?_
  rintro χ ⟨ψ, rfl⟩
  rw [mem_orthComplement]
  intro φ hφ
  rw [pairing_Lop_left η a (-n) ψ φ, neg_neg,
    Lop_apply_eq_zero_of_mem_physSubmodule hφ hn, map_zero]

/-- **Spurious ∩ physical ⊆ null.**  A physical state that is also spurious is a null state.
This is the half of "spurious ∩ physical = null" that does not need the DDF/light-cone
analysis; the reverse inclusion is part of the no-ghost theorem. -/
theorem spurious_inf_physSubmodule_le_nullSubmodule :
    spuriousSubmodule η a ⊓ physSubmodule η a a₀ ≤ nullSubmodule η a a₀ := by
  intro χ hχ
  rw [Submodule.mem_inf] at hχ
  exact Submodule.mem_inf.mpr ⟨hχ.2, spuriousSubmodule_le_orthComplement η a a₀ hχ.1⟩

variable {η a a₀}

/-- The concrete form of the previous statement: if `L_{-n} ψ` (`n ≥ 1`) happens to be
physical, it is a null state. -/
theorem Lop_neg_apply_mem_nullSubmodule {n : ℤ} (hn : 0 < n) (ψ : Fock D R)
    (hmem : Lop η a (-n) ψ ∈ physSubmodule η a a₀) :
    Lop η a (-n) ψ ∈ nullSubmodule η a a₀ :=
  spurious_inf_physSubmodule_le_nullSubmodule η a a₀
    (Submodule.mem_inf.mpr ⟨Lop_neg_mem_spuriousSubmodule η a hn ψ, hmem⟩)

end Null

/-! ### The level-one physical states -/

section LevelOne

variable (η : Fin D → R)

/-- The general level-one state `ζ · α_{-1}|k⟩ = η_{μν} ζ^μ α^ν_{-1}|k⟩`, with polarisation
`ζ = e`.  (The metric is written explicitly so that the physical transversality condition
comes out as the contraction `ζ · k = η_{μν} ζ^μ k^ν = 0`.) -/
noncomputable def polState (η e : Fin D → R) : Fock D R :=
  ∑ μ : Fin D, (η μ * e μ) • (X ((μ, 1) : Osc D) : Fock D R)

variable (a : Fin D → R)

lemma mode_neg_one_apply_one (μ : Fin D) :
    mode η a μ (-1) (1 : Fock D R) = (X ((μ, 1) : Osc D) : Fock D R) := by
  rw [show (-1 : ℤ) = -(((1 : ℕ+) : ℕ) : ℤ) by norm_num, mode_neg_pnat, creation_apply, mul_one]

lemma polState_eq_sum_mode (e : Fin D → R) :
    polState η e = ∑ μ : Fin D, (η μ * e μ) • mode η a μ (-1) (1 : Fock D R) := by
  rw [polState]
  exact Finset.sum_congr rfl fun μ _ => by rw [mode_neg_one_apply_one]

variable {η a}

lemma X_mem_levelSubmodule_one (μ : Fin D) :
    (X ((μ, 1) : Osc D) : Fock D R) ∈ levelSubmodule D R 1 := by
  have h := creation_mem_levelSubmodule (R := R) μ 1 (one_mem_levelSubmodule D R)
  rw [creation_apply, mul_one] at h
  simpa using h

lemma polState_mem_levelSubmodule_one (e : Fin D → R) :
    polState η e ∈ levelSubmodule D R 1 :=
  Submodule.sum_mem _ fun μ _ => Submodule.smul_mem _ _ (X_mem_levelSubmodule_one μ)

/-- A monomial of level `1` is a single oscillator `α^μ_{-1}`. -/
lemma exists_eq_single_of_level_eq_one {d : Osc D →₀ ℕ} (hd : level D d = 1) :
    ∃ μ : Fin D, d = Finsupp.single ((μ, 1) : Osc D) 1 := by
  classical
  obtain ⟨v, hv⟩ : ∃ v : Osc D, v ∈ d.support := by
    by_contra hc
    have hall : ∀ u : Osc D, u ∉ d.support := not_exists.mp hc
    have : d = 0 := Finsupp.ext fun u => Finsupp.notMem_support_iff.mp (hall u)
    rw [this, level_zero] at hd
    exact absurd hd (by norm_num)
  have hdv1 : d v = 1 := le_antisymm (apply_le_of_level_eq hd v)
    (Nat.one_le_iff_ne_zero.mpr (Finsupp.mem_support_iff.mp hv))
  have hlv1 : oscLevel D v = 1 := le_antisymm (mode_le_of_mem_support_of_level_eq hd hv)
    (Nat.one_le_iff_ne_zero.mpr (oscLevel_ne_zero D v))
  have hsupp : d.support = {v} := by
    refine Finset.eq_singleton_iff_unique_mem.mpr ⟨hv, fun u hu => ?_⟩
    by_contra hvu
    have hsub : ({v, u} : Finset (Osc D)) ⊆ d.support := by
      intro x hx
      simp only [Finset.mem_insert, Finset.mem_singleton] at hx
      rcases hx with rfl | rfl <;> assumption
    have hle : d v * oscLevel D v + d u * oscLevel D u ≤ level D d := by
      rw [level_apply, Finsupp.sum]
      calc d v * oscLevel D v + d u * oscLevel D u
          = ∑ x ∈ ({v, u} : Finset (Osc D)), d x * oscLevel D x :=
            (Finset.sum_pair (f := fun x : Osc D => d x * oscLevel D x) (Ne.symm hvu)).symm
        _ ≤ ∑ x ∈ d.support, d x * oscLevel D x :=
            Finset.sum_le_sum_of_subset hsub
    have h1 : 1 ≤ d u := Nat.one_le_iff_ne_zero.mpr (Finsupp.mem_support_iff.mp hu)
    have h2 : 1 ≤ oscLevel D u := Nat.one_le_iff_ne_zero.mpr (oscLevel_ne_zero D u)
    have := Nat.mul_le_mul h1 h2
    rw [hd, hdv1, hlv1] at hle
    omega
  have hv2 : ((v.1, (1 : ℕ+)) : Osc D) = v := by
    refine Prod.ext rfl (PNat.coe_injective ?_)
    simpa [oscLevel] using hlv1.symm
  refine ⟨v.1, Finsupp.ext fun u => ?_⟩
  rw [hv2]
  by_cases hu : u = v
  · subst hu
    rw [hdv1, Finsupp.single_eq_same]
  · have h0 : d u = 0 := Finsupp.notMem_support_iff.mp (by rw [hsupp]; simpa using hu)
    have h1 : (Finsupp.single v (1 : ℕ) : Osc D →₀ ℕ) u = 0 := Finsupp.single_eq_of_ne hu
    rw [h0, h1]

/-- Every level-one state is of the form `ζ · α_{-1}|k⟩`. -/
theorem exists_polState_of_mem_levelSubmodule_one (hη : ∀ μ, η μ * η μ = 1) {ψ : Fock D R}
    (hψ : ψ ∈ levelSubmodule D R 1) : ∃ e : Fin D → R, ψ = polState η e := by
  classical
  refine ⟨fun μ => η μ * coeff (Finsupp.single ((μ, 1) : Osc D) 1) ψ, ?_⟩
  rw [polState]
  have hcoef : ∀ μ : Fin D, η μ * (η μ * coeff (Finsupp.single ((μ, 1) : Osc D) 1) ψ)
      = coeff (Finsupp.single ((μ, 1) : Osc D) 1) ψ := by
    intro μ
    rw [← mul_assoc, hη μ, one_mul]
  simp only [hcoef]
  refine MvPolynomial.ext _ _ fun d => ?_
  rw [coeff_sum]
  simp only [coeff_smul, coeff_X, smul_eq_mul]
  by_cases hd : ∃ ν : Fin D, d = Finsupp.single ((ν, 1) : Osc D) 1
  · obtain ⟨ν, rfl⟩ := hd
    rw [Finset.sum_eq_single ν]
    · rw [if_pos rfl, mul_one]
    · intro μ _ hμν
      refine (if_neg fun h => hμν ?_).symm ▸ mul_zero _
      exact congrArg Prod.fst (Finsupp.single_left_injective (b := (1 : ℕ)) one_ne_zero h)
    · intro h
      exact absurd (Finset.mem_univ ν) h
  · have hd' : ∀ ν : Fin D, ¬(d = Finsupp.single ((ν, 1) : Osc D) 1) := fun ν h => hd ⟨ν, h⟩
    rw [Finset.sum_eq_zero fun μ _ => by rw [if_neg (fun h => hd' μ h.symm), mul_zero]]
    by_contra hc
    exact hd (exists_eq_single_of_level_eq_one (hψ hc))

variable [Algebra ℚ R] (η a)

/-- `L_n` annihilates every level-one state for `n ≥ 2`. -/
theorem Lop_apply_polState_of_two_le (hη : ∀ μ, η μ * η μ = 1) {n : ℤ} (hn : 2 ≤ n)
    (e : Fin D → R) : Lop η a n (polState η e) = 0 := by
  rw [polState_eq_sum_mode η a, map_sum]
  refine Finset.sum_eq_zero fun μ _ => ?_
  rw [map_smul, Lop_apply_mode_one η a hη (by omega : (0 : ℤ) < n) μ (-1),
    mode_apply_one_eq_zero η a (by omega : (0 : ℤ) < n + -1) μ, smul_zero, smul_zero]

/-- `L_1 (ζ·α_{-1}|k⟩) = (ζ·k) |k⟩` (up to the normalisation `a^μ = (2α')^{1/2} k^μ`): this is
the transversality condition. -/
theorem Lop_one_apply_polState (hη : ∀ μ, η μ * η μ = 1) (e : Fin D → R) :
    Lop η a 1 (polState η e)
      = (∑ μ : Fin D, η μ * e μ * a μ) • (1 : Fock D R) := by
  rw [polState_eq_sum_mode η a, map_sum, Finset.sum_smul]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [map_smul, Lop_apply_mode_one η a hη (by norm_num : (0 : ℤ) < 1) μ (-1),
    show (1 : ℤ) + -1 = 0 by ring, mode_zero_apply, smul_smul, smul_smul, mul_assoc]
  norm_num

/-- **The physical-state conditions on a level-one state.**  The `L_n`, `n ≥ 2`, conditions are
automatic; what remains is the mass shell `α' k² + 1 = a₀` and the transversality `ζ · k = 0`.
-/
theorem polState_mem_physSubmodule_iff (hη : ∀ μ, η μ * η μ = 1) (a₀ : R) (e : Fin D → R) :
    polState η e ∈ physSubmodule η a a₀ ↔
      (invTwo R * zeroModeSq η a + 1 - a₀) • polState η e = 0 ∧
        (∑ μ : Fin D, η μ * e μ * a μ) = 0 := by
  rw [mem_physSubmodule_iff_of_mem_levelSubmodule η a a₀ hη (polState_mem_levelSubmodule_one e),
    Nat.cast_one]
  constructor
  · rintro ⟨h0, hpos⟩
    refine ⟨h0, ?_⟩
    have h1 := hpos 1 (by norm_num)
    rw [Lop_one_apply_polState η a hη, smul_eq_C_mul, mul_one] at h1
    exact MvPolynomial.C_eq_zero.mp h1
  · rintro ⟨h0, htrans⟩
    refine ⟨h0, fun n hn => ?_⟩
    rcases eq_or_lt_of_le (show (1 : ℤ) ≤ n by omega) with h | h
    · rw [← h, Lop_one_apply_polState η a hη, htrans, zero_smul]
    · exact Lop_apply_polState_of_two_le η a hη (by omega) e

/-- **The level-one slice of `H_phys`**: exactly the transverse polarisations, on the mass
shell. -/
theorem mem_physSubmodule_inf_levelSubmodule_one_iff (hη : ∀ μ, η μ * η μ = 1) (a₀ : R)
    {ψ : Fock D R} :
    ψ ∈ physSubmodule η a a₀ ⊓ levelSubmodule D R 1 ↔
      ∃ e : Fin D → R, ψ = polState η e ∧
        (invTwo R * zeroModeSq η a + 1 - a₀) • ψ = 0 ∧
          (∑ μ : Fin D, η μ * e μ * a μ) = 0 := by
  constructor
  · rintro hmem
    rw [Submodule.mem_inf] at hmem
    obtain ⟨e, rfl⟩ := exists_polState_of_mem_levelSubmodule_one hη hmem.2
    obtain ⟨h0, htrans⟩ := (polState_mem_physSubmodule_iff η a hη a₀ e).mp hmem.1
    exact ⟨e, rfl, h0, htrans⟩
  · rintro ⟨e, rfl, h0, htrans⟩
    exact Submodule.mem_inf.mpr
      ⟨(polState_mem_physSubmodule_iff η a hη a₀ e).mpr ⟨h0, htrans⟩,
        polState_mem_levelSubmodule_one e⟩

/-! ### The null photon at intercept `a₀ = 1` -/

/-- `L_{-1}|k⟩` is the level-one state with longitudinal polarisation `ζ = k`. -/
theorem Lop_neg_one_apply_one_eq_polState :
    Lop η a (-1) (1 : Fock D R) = polState η a := by
  rw [Lop_neg_one_apply_one η a, polState_eq_sum_mode η a]

/-- **The `a₀ = 1` open-string photon null state.**  On the massless shell `k² = 0` the
spurious state `L_{-1}|k⟩` satisfies the physical-state conditions with intercept `a₀ = 1`
(graph node `worldsheet.open-string-intercept`, derivation `--via-null-state-decoupling`). -/
theorem Lop_neg_one_apply_one_mem_physSubmodule (hη : ∀ μ, η μ * η μ = 1)
    (hk : zeroModeSq η a = 0) :
    Lop η a (-1) (1 : Fock D R) ∈ physSubmodule η a (1 : R) := by
  rw [Lop_neg_one_apply_one_eq_polState η a]
  refine (polState_mem_physSubmodule_iff η a hη 1 a).mpr ⟨?_, ?_⟩
  · rw [hk, mul_zero, zero_add, sub_self, zero_smul]
  · exact hk

/-- **… and it is then a null state.**  This is the mechanism that fixes the open bosonic
string intercept to `a₀ = 1`: at `a₀ = 1` the longitudinal photon polarisation `ζ = k`
decouples. -/
theorem Lop_neg_one_apply_one_mem_nullSubmodule (hη : ∀ μ, η μ * η μ = 1)
    (hk : zeroModeSq η a = 0) :
    Lop η a (-1) (1 : Fock D R) ∈ nullSubmodule η a (1 : R) :=
  Lop_neg_apply_mem_nullSubmodule (n := 1) (by norm_num) (1 : Fock D R)
    (Lop_neg_one_apply_one_mem_physSubmodule η a hη hk)

end LevelOne

end Fock

end StringFormal.NoGhost
