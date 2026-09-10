/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import Mathlib.Algebra.MvPolynomial.PDeriv
import Mathlib.RingTheory.MvPolynomial.Basic
import Mathlib.RingTheory.MvPolynomial.WeightedHomogeneous
import Mathlib.LinearAlgebra.Basis.Bilinear
import Mathlib.Algebra.Lie.OfAssociative

/-!
# The Fock space of `D` free bosonic oscillators and its `η`-induced indefinite form

Graph node: to be created (suggested id `worldsheet.bosonic-fock-space`); part of the
no-ghost island, see `formal/TODO.md` item `fock-space` and
`StringFormal/NoGhost/Statement.lean`.

Convention (`conv.metric-mostly-plus`): the spacetime metric is diagonal,
`η = diag(-1, +1, …, +1)` (`minkowski`), and the oscillator algebra is normalised by

  `[α^μ_m, α^ν_n] = m η^{μν} δ_{m+n,0}`.

Only the *oscillator* part of the Fock space is built here: the momentum `k` labelling the
vacuum `|k⟩` is inert for everything in this file (it enters first through `L₀` in the
Sugawara construction), so `|k⟩` is represented by `1` and `k` is not a parameter. See
"Mathematical gaps" below.

## Main definitions

* `StringFormal.NoGhost.Osc D` — oscillator labels `(μ, n)`, `μ : Fin D`, `n : ℕ+`;
  `(μ, n)` names the creation operator `α^μ_{-n}`.
* `StringFormal.NoGhost.Fock D R` — the Fock space, realised as the polynomial algebra
  `MvPolynomial (Osc D) R`, i.e. the symmetric algebra on the creation operators, acting on
  the vacuum `1`.
* `Fock.creation R μ n` — `α^μ_{-n}`, multiplication by the variable `X (μ, n)`.
* `Fock.annihilation η μ n` — `α^μ_{n}`, the derivation `n η^{μμ} ∂/∂X_{μ,n}`.
* `Fock.levelSubmodule D R N` — the level-`N` graded piece, `N = Σ n · (exponent of X_{μ,n})`.
* `Fock.monomialNorm η d` — `∏_{(μ,n)} (n η^{μμ})^{d(μ,n)} · d(μ,n)!`.
* `Fock.pairing η` — the bilinear form on `Fock D R` determined by `⟨0|0⟩ = 1` and
  `(α^μ_n)† = α^μ_{-n}`.
* `Fock.minkowski D R` — the mostly-plus diagonal metric.

## Main statements

* `Fock.lie_annihilation_creation`, `.lie_creation_creation`,
  `.lie_annihilation_annihilation` — the oscillator algebra, as Lie brackets in
  `Module.End R (Fock D R)`; the elementwise form is `Fock.annihilation_creation_sub`.
* `Fock.pairing_comm` — the form is symmetric.
* `Fock.pairing_creation_left` / `.pairing_creation_right` — `(α^μ_{-n})† = α^μ_n` and
  `(α^μ_n)† = α^μ_{-n}`; this is the defining property of the form.
* `Fock.pairing_eq_zero_of_level_ne` — different levels are orthogonal.
* `Fock.pairing_monomial_monomial` — the explicit diagonal formula in the monomial basis:
  `⟨x^d, x^e⟩ = δ_{d,e} ∏ (n η^{μμ})^{d(μ,n)} d(μ,n)!`.
* `Fock.pairing_unique` — `pairing η` is the *unique* bilinear form with `⟨0|0⟩ = 1` for
  which creation and annihilation operators are mutually adjoint.  This is what justifies
  calling it *the* Fock inner product.
* `Fock.pairing_X_X_minkowski_timelike` — with the mostly-plus metric the state
  `α^0_{-n}|k⟩` has norm `-n`: the form really is indefinite (a "ghost").
* `Fock.creation_mem_levelSubmodule`, `.annihilation_mem_levelSubmodule` — the operators
  shift the level by `∓n`.
* `Fock.apply_le_of_level_eq`, `Fock.mode_le_of_mem_support_of_level_eq` — a level-`N`
  monomial only involves oscillators of mode number `≤ N`, each with exponent `≤ N`.
* `Fock.finite_setOf_level_eq`, `Fock.levelSubmodule_fg`, `Fock.levelSubmodule_finite` —
  each level piece is a finite module; over a field, finite-dimensional.

## Implementation notes

* The ground ring is an arbitrary `CommRing R`.  No denominators occur: the diagonal entries
  of the form are `∏ (n η^{μμ})^{k} k!`, which are integers once `η^{μμ} = ±1`.  Positivity
  statements (signature, "no negative-norm states") need an ordered field and are *not* made
  here; the Sugawara construction will additionally need a `ℚ`-algebra because of the `1/2`
  in `L_n = ½ Σ :α·α:`.
* The metric is given as a *diagonal* function `η : Fin D → R` rather than a general
  symmetric bilinear form.  Over `ℝ` this is no loss (diagonalise), and it is what makes the
  form diagonal in the monomial basis.  A general `η^{μν}` would need a change of basis.
* `Fock D R` is an `abbrev` for `MvPolynomial (Osc D) R` so that the whole `MvPolynomial`
  API applies directly.

## Mathematical gaps (for the dependency graph)

1. **Momentum.** The full string Fock space is a family (direct sum / direct integral over
   `k`) of copies of this space; the zero-mode operators `x^μ, p^μ` are absent here.
   Nothing in this file depends on `k`, but `L₀ = α'k²/4 + Σ …` does, so `k` must be added
   before the Virasoro action, and the physical-state conditions are `k`-dependent.
2. **Completion.** This is the *algebraic* Fock space (finite linear combinations); no
   topology/Hilbert-space completion is taken.  Goddard–Thorn is an algebraic statement, so
   this is the right object, but it is not the physicists' Hilbert space.
3. **Diagonal metric.** See above.
4. **Hermiticity vs. symmetry.** Over `ℝ` the physical form is symmetric bilinear, which is
   what is formalised.  The usual complex Fock space carries a sesquilinear form; the two
   agree on the real span of the monomials, but the complex statement is *not* proved here.

## Status

Complete, no `sorry`.
-/

namespace StringFormal.NoGhost

open MvPolynomial

/-- Oscillator labels.  The pair `(μ, n)` labels the creation operator `α^μ_{-n}`: `μ` is a
spacetime direction and `n ≥ 1` a mode number. -/
abbrev Osc (D : ℕ) : Type := Fin D × ℕ+

/-- The Fock space of `D` free bosonic oscillators over a fixed-momentum vacuum, realised as
the symmetric algebra on the creation operators `α^μ_{-n}` (`n ≥ 1`), i.e. as a polynomial
algebra with one variable per oscillator.  The vacuum `|k⟩` is the constant `1`. -/
abbrev Fock (D : ℕ) (R : Type*) [CommRing R] : Type _ := MvPolynomial (Osc D) R

namespace Fock

/-! ### Level grading -/

/-- The level of an oscillator label: `α^μ_{-n}` raises the level by `n`. -/
def oscLevel (D : ℕ) : Osc D → ℕ := fun v => (v.2 : ℕ)

@[simp]
lemma oscLevel_apply (D : ℕ) (μ : Fin D) (n : ℕ+) : oscLevel D (μ, n) = (n : ℕ) := rfl

lemma oscLevel_ne_zero (D : ℕ) (v : Osc D) : oscLevel D v ≠ 0 := v.2.ne_zero

/-- The level of a monomial: `Σ n · d(μ, n)`. -/
noncomputable def level (D : ℕ) (d : Osc D →₀ ℕ) : ℕ := Finsupp.weight (oscLevel D) d

lemma level_apply (D : ℕ) (d : Osc D →₀ ℕ) :
    level D d = Finsupp.sum d fun v k => k * oscLevel D v :=
  Finsupp.weight_apply _ _

@[simp]
lemma level_zero (D : ℕ) : level D (0 : Osc D →₀ ℕ) = 0 := map_zero _

@[simp]
lemma level_add (D : ℕ) (d e : Osc D →₀ ℕ) : level D (d + e) = level D d + level D e :=
  map_add _ _ _

@[simp]
lemma level_single (D : ℕ) (v : Osc D) (k : ℕ) :
    level D (Finsupp.single v k) = k * oscLevel D v :=
  Finsupp.weight_single _ _ _

/-- The level-`N` graded piece of the Fock space. -/
def levelSubmodule (D : ℕ) (R : Type*) [CommRing R] (N : ℕ) : Submodule R (Fock D R) :=
  weightedHomogeneousSubmodule R (oscLevel D) N

lemma mem_levelSubmodule (D : ℕ) (R : Type*) [CommRing R] (N : ℕ) (P : Fock D R) :
    P ∈ levelSubmodule D R N ↔ ∀ ⦃d : Osc D →₀ ℕ⦄, coeff d P ≠ 0 → level D d = N :=
  Iff.rfl

/-! ### The vacuum, the metric, and the oscillator operators -/

/-- The Fock vacuum `|k⟩`.  (The momentum `k` is inert in this file; see the module doc.) -/
noncomputable def vacuum (D : ℕ) (R : Type*) [CommRing R] : Fock D R := 1

@[simp]
lemma vacuum_def (D : ℕ) (R : Type*) [CommRing R] : vacuum D R = (1 : Fock D R) := rfl

/-- The mostly-plus Minkowski metric `η = diag(-1, +1, …, +1)`, convention
`conv.metric-mostly-plus`. -/
def minkowski (D : ℕ) (R : Type*) [CommRing R] : Fin D → R :=
  fun μ => if (μ : ℕ) = 0 then -1 else 1

lemma minkowski_timelike (D : ℕ) (R : Type*) [CommRing R] {μ : Fin D} (hμ : (μ : ℕ) = 0) :
    minkowski D R μ = -1 := by simp [minkowski, hμ]

lemma minkowski_spacelike (D : ℕ) (R : Type*) [CommRing R] {μ : Fin D} (hμ : (μ : ℕ) ≠ 0) :
    minkowski D R μ = 1 := by simp [minkowski, hμ]

/-- The creation operator `α^μ_{-n}`: multiplication by the variable `X (μ, n)`. -/
noncomputable def creation (R : Type*) [CommRing R] {D : ℕ} (μ : Fin D) (n : ℕ+) :
    Fock D R →ₗ[R] Fock D R :=
  LinearMap.mulLeft R (X (μ, n))

variable {D : ℕ} {R : Type*} [CommRing R]

@[simp]
lemma creation_apply (μ : Fin D) (n : ℕ+) (P : Fock D R) :
    creation R μ n P = X ((μ, n) : Osc D) * P := rfl

/-- The one-oscillator normalisation constant `n η^{μμ}`: it is the norm of the state
`α^μ_{-n}|k⟩`. -/
def oscWeight (η : Fin D → R) (v : Osc D) : R := ((v.2 : ℕ) : R) * η v.1

@[simp]
lemma oscWeight_apply (η : Fin D → R) (μ : Fin D) (n : ℕ+) :
    oscWeight η (μ, n) = ((n : ℕ) : R) * η μ := rfl

/-- The annihilation operator `α^μ_{n}` for `n ≥ 1`, normalised so that
`[α^μ_n, α^ν_{-n}] = n η^{μν}`: it is `n η^{μμ} ∂/∂X_{μ,n}`. -/
noncomputable def annihilation (η : Fin D → R) (μ : Fin D) (n : ℕ+) :
    Fock D R →ₗ[R] Fock D R :=
  oscWeight η (μ, n) • (pderiv ((μ, n) : Osc D)).toLinearMap

lemma annihilation_apply (η : Fin D → R) (μ : Fin D) (n : ℕ+) (P : Fock D R) :
    annihilation η μ n P = oscWeight η (μ, n) • pderiv ((μ, n) : Osc D) P := rfl

/-- Annihilation operators kill the vacuum. -/
@[simp]
lemma annihilation_one (η : Fin D → R) (μ : Fin D) (n : ℕ+) :
    annihilation η μ n (1 : Fock D R) = 0 := by
  rw [annihilation_apply, pderiv_one, smul_zero]

lemma annihilation_vacuum (η : Fin D → R) (μ : Fin D) (n : ℕ+) :
    annihilation η μ n (vacuum D R) = 0 := annihilation_one η μ n

lemma coeff_annihilation (η : Fin D → R) (μ : Fin D) (n : ℕ+) (Q : Fock D R)
    (d : Osc D →₀ ℕ) :
    coeff d (annihilation η μ n Q)
      = oscWeight η (μ, n) *
          (coeff (d + Finsupp.single ((μ, n) : Osc D) 1) Q *
            ((d ((μ, n) : Osc D) : R) + 1)) := by
  rw [annihilation_apply, coeff_smul, smul_eq_mul, coeff_pderiv]

/-! ### The oscillator algebra -/

lemma creation_creation_comm (μ ν : Fin D) (m n : ℕ+) (P : Fock D R) :
    creation R μ m (creation R ν n P) = creation R ν n (creation R μ m P) := by
  simp only [creation_apply]
  ring

lemma pderiv_comm (u v : Osc D) (P : Fock D R) :
    pderiv u (pderiv v P) = pderiv v (pderiv u P) := by
  classical
  by_cases h : u = v
  · rw [h]
  · ext m
    rw [coeff_pderiv, coeff_pderiv, coeff_pderiv, coeff_pderiv,
      add_right_comm m (Finsupp.single u 1) (Finsupp.single v 1), Finsupp.add_apply,
      Finsupp.add_apply, Finsupp.single_eq_of_ne h, Finsupp.single_eq_of_ne (Ne.symm h)]
    push_cast
    ring

lemma annihilation_annihilation_comm (η : Fin D → R) (μ ν : Fin D) (m n : ℕ+) (P : Fock D R) :
    annihilation η μ m (annihilation η ν n P) = annihilation η ν n (annihilation η μ m P) := by
  simp only [annihilation_apply, map_smul, smul_smul, pderiv_comm ((μ, m) : Osc D)]
  rw [mul_comm]

/-- The canonical commutation relation `[α^μ_m, α^ν_{-n}] = m η^{μν} δ_{m,n}`, elementwise. -/
theorem annihilation_creation_sub (η : Fin D → R) (μ ν : Fin D) (m n : ℕ+) (P : Fock D R) :
    annihilation η μ m (creation R ν n P) - creation R ν n (annihilation η μ m P)
      = (if ((μ, m) : Osc D) = (ν, n) then oscWeight η (μ, m) else 0) • P := by
  classical
  have h1 : annihilation η μ m (creation R ν n P)
      = oscWeight η (μ, m) • (pderiv ((μ, m) : Osc D) (X ((ν, n) : Osc D)) * P)
        + X ((ν, n) : Osc D) * (oscWeight η (μ, m) • pderiv ((μ, m) : Osc D) P) := by
    rw [creation_apply, annihilation_apply, pderiv_mul, smul_add]
    congr 1
    rw [mul_smul_comm]
  rw [h1, creation_apply, annihilation_apply, add_sub_cancel_right, pderiv_X, Pi.single_apply]
  by_cases h : ((μ, m) : Osc D) = (ν, n)
  · rw [if_pos h, if_pos h.symm, one_mul]
  · rw [if_neg h, if_neg (Ne.symm h), zero_mul, smul_zero, zero_smul]

/-- The canonical commutation relation as a Lie bracket in `Module.End R (Fock D R)`:
`[α^μ_m, α^ν_{-n}] = m η^{μν} δ_{m,n}`. -/
theorem lie_annihilation_creation (η : Fin D → R) (μ ν : Fin D) (m n : ℕ+) :
    ⁅(annihilation η μ m : Module.End R (Fock D R)),
        (creation R ν n : Module.End R (Fock D R))⁆
      = (if ((μ, m) : Osc D) = (ν, n) then oscWeight η (μ, m) else 0) •
          (LinearMap.id : Fock D R →ₗ[R] Fock D R) := by
  by_cases h : ((μ, m) : Osc D) = (ν, n)
  · rw [if_pos h]
    refine LinearMap.ext fun P => ?_
    rw [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
      Module.End.mul_apply, LinearMap.smul_apply, LinearMap.id_coe, id_eq]
    have hs := annihilation_creation_sub η μ ν m n P
    rw [if_pos h] at hs
    exact hs
  · rw [if_neg h, zero_smul]
    refine LinearMap.ext fun P => ?_
    rw [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
      Module.End.mul_apply, LinearMap.zero_apply]
    have hs := annihilation_creation_sub η μ ν m n P
    rw [if_neg h, zero_smul] at hs
    exact hs

/-- `[α^μ_{-m}, α^ν_{-n}] = 0`. -/
theorem lie_creation_creation (μ ν : Fin D) (m n : ℕ+) :
    ⁅(creation R μ m : Module.End R (Fock D R)),
        (creation R ν n : Module.End R (Fock D R))⁆ = 0 := by
  refine LinearMap.ext fun P => ?_
  rw [LieRing.of_associative_ring_bracket]
  simpa [sub_eq_zero] using creation_creation_comm μ ν m n P

/-- `[α^μ_m, α^ν_n] = 0` for `m, n > 0`. -/
theorem lie_annihilation_annihilation (η : Fin D → R) (μ ν : Fin D) (m n : ℕ+) :
    ⁅(annihilation η μ m : Module.End R (Fock D R)),
        (annihilation η ν n : Module.End R (Fock D R))⁆ = 0 := by
  refine LinearMap.ext fun P => ?_
  rw [LieRing.of_associative_ring_bracket]
  simpa [sub_eq_zero] using annihilation_annihilation_comm η μ ν m n P

/-! ### How the operators act on the level grading -/

theorem one_mem_levelSubmodule (D : ℕ) (R : Type*) [CommRing R] :
    (1 : Fock D R) ∈ levelSubmodule D R 0 :=
  isWeightedHomogeneous_one R (oscLevel D)

theorem creation_mem_levelSubmodule (μ : Fin D) (n : ℕ+) {N : ℕ} {P : Fock D R}
    (hP : P ∈ levelSubmodule D R N) :
    creation R μ n P ∈ levelSubmodule D R ((n : ℕ) + N) := by
  rw [creation_apply]
  exact (isWeightedHomogeneous_X (R := R) (oscLevel D) ((μ, n) : Osc D)).mul hP

theorem annihilation_mem_levelSubmodule (η : Fin D → R) (μ : Fin D) (n : ℕ+) {N : ℕ}
    {P : Fock D R} (hP : P ∈ levelSubmodule D R (N + (n : ℕ))) :
    annihilation η μ n P ∈ levelSubmodule D R N := by
  intro d hd
  have hd' : coeff (d + Finsupp.single ((μ, n) : Osc D) 1) P ≠ 0 := by
    intro h
    rw [coeff_annihilation, h, zero_mul, mul_zero] at hd
    exact hd rfl
  have hlev := hP hd'
  rw [show (Finsupp.weight (oscLevel D)) (d + Finsupp.single ((μ, n) : Osc D) 1)
      = Finsupp.weight (oscLevel D) d + (n : ℕ) by
    rw [map_add, Finsupp.weight_single]; simp] at hlev
  exact Nat.add_right_cancel hlev

/-! ### The monomial normalisation constants -/

/-- `monomialNorm η d = ∏_{(μ,n)} (n η^{μμ})^{d(μ,n)} · d(μ,n)!`: the diagonal entry of the
Fock form at the monomial `x^d`. -/
noncomputable def monomialNorm (η : Fin D → R) (d : Osc D →₀ ℕ) : R :=
  d.prod fun v k => oscWeight η v ^ k * (k.factorial : R)

@[simp]
lemma monomialNorm_zero (η : Fin D → R) : monomialNorm η (0 : Osc D →₀ ℕ) = 1 :=
  Finsupp.prod_zero_index

lemma monomialNorm_of_support_subset (η : Fin D → R) (d : Osc D →₀ ℕ) {s : Finset (Osc D)}
    (hs : d.support ⊆ s) :
    monomialNorm η d = ∏ u ∈ s, oscWeight η u ^ (d u) * (((d u).factorial : ℕ) : R) :=
  Finsupp.prod_of_support_subset d hs _ (fun i _ => by simp)

lemma monomialNorm_add_single (η : Fin D → R) (d : Osc D →₀ ℕ) (v : Osc D) :
    monomialNorm η (d + Finsupp.single v 1)
      = monomialNorm η d * (oscWeight η v * ((d v : R) + 1)) := by
  classical
  set e : Osc D →₀ ℕ := d + Finsupp.single v 1 with he
  have hvs : v ∈ insert v d.support := Finset.mem_insert_self _ _
  have hds : d.support ⊆ insert v d.support := Finset.subset_insert _ _
  have hds' : e.support ⊆ insert v d.support := by
    rw [he]
    refine Finsupp.support_add.trans (Finset.union_subset hds ?_)
    intro x hx
    have hxv : x = v := by simpa using Finsupp.support_single_subset hx
    exact hxv ▸ hvs
  have hoff : ∀ u : Osc D, u ≠ v → e u = d u := by
    intro u hu
    simp [he, hu]
  have hat : e v = d v + 1 := by rw [he]; simp
  rw [monomialNorm_of_support_subset η e hds', monomialNorm_of_support_subset η d hds,
    ← Finset.mul_prod_erase (insert v d.support)
      (fun u : Osc D => oscWeight η u ^ e u * (((e u).factorial : ℕ) : R)) hvs,
    ← Finset.mul_prod_erase (insert v d.support)
      (fun u : Osc D => oscWeight η u ^ d u * (((d u).factorial : ℕ) : R)) hvs]
  have hrest : ∀ u ∈ (insert v d.support).erase v,
      oscWeight η u ^ e u * (((e u).factorial : ℕ) : R)
        = oscWeight η u ^ d u * (((d u).factorial : ℕ) : R) := by
    intro u hu
    rw [hoff u (Finset.ne_of_mem_erase hu)]
  rw [Finset.prod_congr rfl hrest, hat, Nat.factorial_succ, pow_succ]
  push_cast
  ring

lemma monomialNorm_single_one (η : Fin D → R) (v : Osc D) :
    monomialNorm η (Finsupp.single v 1) = oscWeight η v := by
  have h := monomialNorm_add_single η 0 v
  rw [zero_add] at h
  simpa using h

/-! ### The Fock form -/

lemma basisMonomials_apply (d : Osc D →₀ ℕ) :
    (MvPolynomial.basisMonomials (Osc D) R) d = (monomial d 1 : Fock D R) := rfl

/-- The bilinear form on the Fock space determined by `⟨0|0⟩ = 1` and
`(α^μ_n)† = α^μ_{-n}`.  It is diagonal in the monomial basis with diagonal entries
`monomialNorm η d`; see `pairing_unique` for the characterisation. -/
noncomputable def pairing (η : Fin D → R) : Fock D R →ₗ[R] Fock D R →ₗ[R] R :=
  (MvPolynomial.basisMonomials (Osc D) R).constr R fun d =>
    monomialNorm η d • MvPolynomial.lcoeff R d

lemma pairing_def (η : Fin D → R) :
    pairing η = (MvPolynomial.basisMonomials (Osc D) R).constr R fun d =>
      monomialNorm η d • MvPolynomial.lcoeff R d := rfl

lemma pairing_monomial_one_left (η : Fin D → R) (d : Osc D →₀ ℕ) (Q : Fock D R) :
    pairing η (monomial d 1) Q = monomialNorm η d * coeff d Q := by
  rw [← basisMonomials_apply, pairing_def, Module.Basis.constr_basis, LinearMap.smul_apply,
    MvPolynomial.lcoeff_apply, smul_eq_mul]

@[simp]
lemma pairing_monomial_left (η : Fin D → R) (d : Osc D →₀ ℕ) (a : R) (Q : Fock D R) :
    pairing η (monomial d a) Q = a * monomialNorm η d * coeff d Q := by
  have h : (monomial d a : Fock D R) = a • monomial d 1 := by
    rw [smul_monomial, smul_eq_mul, mul_one]
  rw [h, map_smul, LinearMap.smul_apply, pairing_monomial_one_left, smul_eq_mul, ← mul_assoc]

/-- The explicit diagonal formula for the Fock form in the monomial basis. -/
theorem pairing_monomial_monomial (η : Fin D → R) (d e : Osc D →₀ ℕ) (a b : R) :
    pairing η (monomial d a) (monomial e b)
      = if d = e then a * b * monomialNorm η d else 0 := by
  classical
  rw [pairing_monomial_left, coeff_monomial]
  by_cases h : d = e
  · rw [if_pos h, if_pos h.symm]
    ring
  · rw [if_neg h, if_neg (Ne.symm h), mul_zero]

theorem pairing_apply (η : Fin D → R) (P Q : Fock D R) :
    pairing η P Q = ∑ d ∈ P.support, coeff d P * monomialNorm η d * coeff d Q := by
  conv_lhs => rw [P.as_sum]
  rw [map_sum, LinearMap.sum_apply]
  exact Finset.sum_congr rfl fun d _ => pairing_monomial_left η d (coeff d P) Q

@[simp]
theorem pairing_one_one (η : Fin D → R) : pairing η (1 : Fock D R) 1 = 1 := by
  classical
  have h : (1 : Fock D R) = monomial (0 : Osc D →₀ ℕ) 1 := by
    rw [monomial_zero', C_1]
  rw [h, pairing_monomial_left, monomialNorm_zero, coeff_monomial]
  simp

theorem pairing_vacuum_vacuum (η : Fin D → R) :
    pairing η (vacuum D R) (vacuum D R) = 1 := pairing_one_one η

/-- The Fock form is symmetric. -/
theorem pairing_flip (η : Fin D → R) : (pairing η).flip = pairing η := by
  classical
  apply LinearMap.ext_basis (MvPolynomial.basisMonomials (Osc D) R)
    (MvPolynomial.basisMonomials (Osc D) R)
  intro d e
  rw [LinearMap.flip_apply, basisMonomials_apply, basisMonomials_apply,
    pairing_monomial_monomial, pairing_monomial_monomial]
  by_cases h : d = e
  · rw [if_pos h, if_pos h.symm, h]
  · rw [if_neg h, if_neg (Ne.symm h)]

theorem pairing_comm (η : Fin D → R) (P Q : Fock D R) :
    pairing η P Q = pairing η Q P := by
  conv_lhs => rw [← pairing_flip η]
  rfl

/-- States of different level are orthogonal. -/
theorem pairing_eq_zero_of_level_ne (η : Fin D → R) {M N : ℕ} (hMN : M ≠ N) {P Q : Fock D R}
    (hP : P ∈ levelSubmodule D R M) (hQ : Q ∈ levelSubmodule D R N) :
    pairing η P Q = 0 := by
  rw [pairing_apply]
  refine Finset.sum_eq_zero fun d hd => ?_
  by_cases h : coeff d Q = 0
  · rw [h, mul_zero]
  · exact absurd ((hP (mem_support_iff.mp hd)).symm.trans (hQ h)) hMN

/-! ### Adjointness: `(α^μ_n)† = α^μ_{-n}` -/

lemma creation_monomial (μ : Fin D) (n : ℕ+) (d : Osc D →₀ ℕ) (a : R) :
    creation R μ n (monomial d a) = monomial (d + Finsupp.single ((μ, n) : Osc D) 1) a := by
  rw [creation_apply, add_comm d (Finsupp.single ((μ, n) : Osc D) 1), monomial_single_add,
    pow_one]

/-- Creation and annihilation operators are mutually adjoint for the Fock form:
`⟨α^μ_{-n} P, Q⟩ = ⟨P, α^μ_n Q⟩`.  Together with `⟨0|0⟩ = 1` this *characterises* the
form; see `pairing_unique`. -/
theorem pairing_creation_left (η : Fin D → R) (μ : Fin D) (n : ℕ+) (P Q : Fock D R) :
    pairing η (creation R μ n P) Q = pairing η P (annihilation η μ n Q) := by
  classical
  have key : ((pairing η).flip Q) ∘ₗ (creation R μ n)
      = (pairing η).flip (annihilation η μ n Q) := by
    apply (MvPolynomial.basisMonomials (Osc D) R).ext
    intro d
    rw [LinearMap.comp_apply, LinearMap.flip_apply, LinearMap.flip_apply, basisMonomials_apply,
      creation_monomial, pairing_monomial_left, pairing_monomial_left, coeff_annihilation,
      monomialNorm_add_single]
    ring
  have h := congrArg (fun f : Fock D R →ₗ[R] R => f P) key
  simpa using h

/-- `⟨P, α^μ_{-n} Q⟩ = ⟨α^μ_n P, Q⟩`. -/
theorem pairing_creation_right (η : Fin D → R) (μ : Fin D) (n : ℕ+) (P Q : Fock D R) :
    pairing η P (creation R μ n Q) = pairing η (annihilation η μ n P) Q := by
  rw [pairing_comm, pairing_creation_left, pairing_comm]

/-! ### Uniqueness -/

/-- The Fock form is the **unique** bilinear form on `Fock D R` giving the vacuum norm `1`
and for which `α^μ_{-n}` and `α^μ_n` are mutually adjoint.  This is the precise content of
"the inner product is determined by `⟨0|0⟩ = 1` and `(α_n)† = α_{-n}`". -/
theorem pairing_unique (η : Fin D → R) (B : Fock D R →ₗ[R] Fock D R →ₗ[R] R)
    (hvac : B 1 1 = 1)
    (hleft : ∀ (μ : Fin D) (n : ℕ+) (P Q : Fock D R),
      B (creation R μ n P) Q = B P (annihilation η μ n Q))
    (hright : ∀ (μ : Fin D) (n : ℕ+) (P Q : Fock D R),
      B P (creation R μ n Q) = B (annihilation η μ n P) Q) :
    B = pairing η := by
  have hone : ∀ Q : Fock D R, B 1 Q = pairing η 1 Q := by
    intro Q
    induction Q using MvPolynomial.induction_on with
    | C a =>
        have hCa : (C a : Fock D R) = a • 1 := by rw [smul_eq_C_mul, mul_one]
        rw [hCa, map_smul, map_smul, smul_eq_mul, smul_eq_mul, hvac, pairing_one_one]
    | add p q hp hq => rw [map_add, map_add, hp, hq]
    | mul_X p v hp =>
        obtain ⟨μ, n⟩ := v
        have hv : p * X ((μ, n) : Osc D) = creation R μ n p := by
          rw [creation_apply, mul_comm]
        rw [hv, hright, pairing_creation_right, annihilation_one]
        simp
  refine LinearMap.ext fun P => ?_
  refine LinearMap.ext fun Q => ?_
  induction P using MvPolynomial.induction_on generalizing Q with
  | C a =>
      have hCa : (C a : Fock D R) = a • 1 := by rw [smul_eq_C_mul, mul_one]
      rw [hCa, map_smul, map_smul, LinearMap.smul_apply, LinearMap.smul_apply, hone]
  | add p q hp hq =>
      rw [map_add, map_add, LinearMap.add_apply, LinearMap.add_apply, hp, hq]
  | mul_X p v hp =>
      obtain ⟨μ, n⟩ := v
      have hv : p * X ((μ, n) : Osc D) = creation R μ n p := by
        rw [creation_apply, mul_comm]
      rw [hv, hleft, hp, ← pairing_creation_left]

/-! ### Indefiniteness -/

@[simp]
theorem pairing_X_X (η : Fin D → R) (u v : Osc D) :
    pairing η (X u) (X v) = if u = v then oscWeight η u else 0 := by
  classical
  have hX : ∀ w : Osc D, (X w : Fock D R) = monomial (Finsupp.single w 1) 1 := by
    intro w
    rw [← C_mul_X_eq_monomial, C_1, one_mul]
  have hsingle : ((Finsupp.single u 1 : Osc D →₀ ℕ) = Finsupp.single v 1) ↔ u = v := by
    constructor
    · intro hc
      by_contra hne
      have h1 := congrArg (fun f : Osc D →₀ ℕ => f u) hc
      simp [Ne.symm hne] at h1
    · intro hc; rw [hc]
  rw [hX u, hX v, pairing_monomial_monomial, monomialNorm_single_one]
  by_cases h : u = v
  · rw [if_pos (hsingle.mpr h), if_pos h, one_mul, one_mul]
  · rw [if_neg (fun hc => h (hsingle.mp hc)), if_neg h]

/-- With the mostly-plus metric the one-oscillator state `α^0_{-n}|k⟩` has norm `-n`: the
Fock form is **indefinite**.  Over an ordered field this is a negative-norm state (a
"ghost"), which is what the no-ghost theorem has to remove. -/
theorem pairing_X_X_minkowski_timelike (D : ℕ) (R : Type*) [CommRing R] {μ : Fin D}
    (hμ : (μ : ℕ) = 0) (n : ℕ+) :
    pairing (minkowski D R) (X ((μ, n) : Osc D)) (X ((μ, n) : Osc D)) = -((n : ℕ) : R) := by
  rw [pairing_X_X, if_pos rfl, oscWeight_apply, minkowski_timelike D R hμ, mul_neg, mul_one]

/-- With the mostly-plus metric a spacelike one-oscillator state has norm `+n`. -/
theorem pairing_X_X_minkowski_spacelike (D : ℕ) (R : Type*) [CommRing R] {μ : Fin D}
    (hμ : (μ : ℕ) ≠ 0) (n : ℕ+) :
    pairing (minkowski D R) (X ((μ, n) : Osc D)) (X ((μ, n) : Osc D)) = ((n : ℕ) : R) := by
  rw [pairing_X_X, if_pos rfl, oscWeight_apply, minkowski_spacelike D R hμ, mul_one]

/-! ### Basic size properties of the level pieces -/

/-- In a monomial of level `N`, the exponent of any single oscillator is at most `N`. -/
lemma apply_le_of_level_eq {N : ℕ} {d : Osc D →₀ ℕ} (hd : level D d = N) (v : Osc D) :
    d v ≤ N := by
  classical
  rw [← hd]
  calc d v = d v * 1 := (mul_one _).symm
    _ ≤ d v * oscLevel D v :=
        Nat.mul_le_mul_left _ (Nat.one_le_iff_ne_zero.mpr (oscLevel_ne_zero D v))
    _ ≤ level D d := by
        rw [level_apply, Finsupp.sum]
        by_cases hv : v ∈ d.support
        · exact Finset.single_le_sum (f := fun u => d u * oscLevel D u)
            (fun _ _ => Nat.zero_le _) hv
        · rw [Finsupp.notMem_support_iff.mp hv, zero_mul]
          exact Nat.zero_le _

/-- Only oscillators of mode number `≤ N` can occur in a monomial of level `N`; in
particular a level-`N` state involves only finitely many of the infinitely many
oscillators. -/
lemma mode_le_of_mem_support_of_level_eq {N : ℕ} {d : Osc D →₀ ℕ} (hd : level D d = N)
    {v : Osc D} (hv : v ∈ d.support) : (v.2 : ℕ) ≤ N := by
  classical
  rw [← hd]
  calc (v.2 : ℕ) = 1 * oscLevel D v := (one_mul _).symm
    _ ≤ d v * oscLevel D v :=
        Nat.mul_le_mul_right _ (Nat.one_le_iff_ne_zero.mpr (Finsupp.mem_support_iff.mp hv))
    _ ≤ level D d := by
        rw [level_apply, Finsupp.sum]
        exact Finset.single_le_sum (f := fun u => d u * oscLevel D u)
          (fun _ _ => Nat.zero_le _) hv

/-! ### Finite-dimensionality of the level pieces -/

/-- The set of monomials of a given level is finite: it is the set of `D`-coloured partitions
of `N`.  (Mathlib's `Finsupp.finite_of_nat_weight_eq` needs a finite variable type; here the
variable type `Osc D` is infinite and finiteness comes from the fact that only oscillators of
mode number `≤ N` can occur.) -/
theorem finite_setOf_level_eq (D N : ℕ) : {d : Osc D →₀ ℕ | level D d = N}.Finite := by
  classical
  have hfin : Finite {d : Osc D →₀ ℕ | level D d = N} := by
    refine Finite.of_injective
      (fun d : {d : Osc D →₀ ℕ | level D d = N} =>
        (fun p : Fin D × Fin (N + 1) =>
          (⟨min (d.1 (p.1, ((p.2 : ℕ)).succPNat)) N,
            lt_of_le_of_lt (min_le_right _ _) (Nat.lt_succ_self N)⟩ : Fin (N + 1)))) ?_
    rintro ⟨d, hd⟩ ⟨d', hd'⟩ hfun
    refine Subtype.ext (Finsupp.ext ?_)
    rintro ⟨μ, n⟩
    by_cases hn : (n : ℕ) ≤ N
    · have hj : (n : ℕ) - 1 < N + 1 := by omega
      have hkey := congrFun hfun (μ, (⟨(n : ℕ) - 1, hj⟩ : Fin (N + 1)))
      have hnn : (((n : ℕ) - 1)).succPNat = n := by
        refine PNat.coe_injective ?_
        rw [Nat.succPNat_coe]
        have hn1 : 0 < (n : ℕ) := n.2
        omega
      simp only [Fin.mk.injEq, hnn] at hkey
      have h1 : d (μ, n) ≤ N := apply_le_of_level_eq hd _
      have h2 : d' (μ, n) ≤ N := apply_le_of_level_eq hd' _
      rwa [Nat.min_eq_left h1, Nat.min_eq_left h2] at hkey
    · have h1 : d (μ, n) = 0 := by
        by_contra hne
        exact hn (mode_le_of_mem_support_of_level_eq hd (Finsupp.mem_support_iff.mpr hne))
      have h2 : d' (μ, n) = 0 := by
        by_contra hne
        exact hn (mode_le_of_mem_support_of_level_eq hd' (Finsupp.mem_support_iff.mpr hne))
      rw [h1, h2]
  exact Set.toFinite _

/-- Each level piece is a finitely generated submodule. -/
theorem levelSubmodule_fg (D : ℕ) (R : Type*) [CommRing R] (N : ℕ) :
    (levelSubmodule D R N).FG := by
  classical
  have hset : {d : Osc D →₀ ℕ | Finsupp.weight (oscLevel D) d = N}.Finite :=
    finite_setOf_level_eq D N
  rw [levelSubmodule, weightedHomogeneousSubmodule_eq_finsupp_supported,
    ← Module.Finite.iff_fg]
  have := hset.to_subtype
  exact Module.Finite.of_basis
    (MvPolynomial.basisRestrictSupport R {d : Osc D →₀ ℕ | Finsupp.weight (oscLevel D) d = N})

/-- Each level piece is a finite module (over a field: finite-dimensional). -/
instance levelSubmodule_finite (D : ℕ) (R : Type*) [CommRing R] (N : ℕ) :
    Module.Finite R (levelSubmodule D R N) :=
  Module.Finite.iff_fg.mpr (levelSubmodule_fg D R N)

end Fock

end StringFormal.NoGhost
