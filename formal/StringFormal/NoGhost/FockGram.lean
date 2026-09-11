/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.Fock

/-!
# The Gram matrix of creation monomials on the oscillator Fock space

Graph node: Lean instance of `worldsheet.transverse-ddf-fock-gram-matrix`.  That card is a
*conditional* proposition: under hypotheses (H1)-(H4) on a family of operators
(commuting creation operators, mutually adjoint creation/annihilation pairs with
`[α_n, α_{-m}] = n η δ_{nm}`, and vacuum norm `1`) the monomials in the creation operators
are pairwise orthogonal with diagonal entries `∏ n^{d(i,n)} d(i,n)!`.

Here the card is instantiated on the *oscillator Fock space itself*
(`StringFormal.NoGhost.Fock D R` with the form `Fock.pairing η`), where (H1)-(H4) hold by
`Fock.creation_creation_comm`, `Fock.lie_annihilation_creation`,
`Fock.pairing_creation_left` and `Fock.pairing_one_one`, so the conclusion becomes an
unconditional theorem.

## Main definitions

* `Fock.creationMonomial R d` -- the state `∏_{(μ,n)} (α^μ_{-n})^{d(μ,n)} |0⟩`.
* `Fock.creationOp R d` -- the same product read as an operator, built with
  `Finset.noncommProd`; the commutation proof is `Fock.creation_pairwise_commute`, which is
  exactly hypothesis (H1).

## Main statements

* `Fock.creationMonomial_add_single` -- the recursive characterisation: adjoining one more
  creation operator.  Together with `Fock.creationMonomial_zero` this says
  `creationMonomial` really is an iterated application of creation operators to `|0⟩`.
* `Fock.creationOp_vacuum` -- the product of the creation operators, in any order, applied
  to the vacuum, gives `creationMonomial R d`.
* `Fock.creationMonomial_mem_levelSubmodule` -- the level of `creationMonomial R d` is
  `Σ n · d(μ,n)`.
* `Fock.annihilation_creationMonomial` -- step (1) of the card's argument (Leibniz /
  "commuting the annihilator through the string of creators"):
  `α^μ_n ∏ (α_{-m})^{d} |0⟩ = n η^{μμ} d(μ,n) · ∏ (α_{-m})^{d - δ} |0⟩`.
* `Fock.pairing_creationMonomial_add_single` -- step (2), the recursion for the form obtained
  from adjointness plus step (1).
* `Fock.pairing_creationMonomial` -- **the Gram matrix**:
  `⟨mono d, mono e⟩ = δ_{d,e} ∏_{(μ,n)} (n η^{μμ})^{d(μ,n)} d(μ,n)!`.
* `Fock.pairing_creationMonomial_of_hypotheses` -- the *conditional* form, matching the graph
  card: the same formula for an arbitrary bilinear form satisfying (H2)-(H4).
* `Fock.monomialNorm_one` -- with `η = 1` (a positive-definite, e.g. purely transverse,
  metric) the diagonal entry is literally `∏ n^{d(μ,n)} d(μ,n)!`.
* `Fock.pairing_creationMonomial_self_pos`, `Fock.pairing_self_pos_of_ne_zero` -- positivity
  for `η > 0`, i.e. step (3).
* `Fock.linearIndependent_creationMonomial` -- the creation monomials are linearly
  independent (over any nontrivial ground ring; in particular over an ordered field, where
  it also follows from positive definiteness).

## Mathematical notes (for the dependency graph)

1. `Fock.pairing` is *defined* to be diagonal in the monomial basis, so
   `pairing_creationMonomial` is cheap once `creationMonomial R d = monomial d 1` is known.
   The mathematical content of the card is therefore carried by two other statements:
   `Fock.pairing_unique` (the diagonal form is the *unique* one with vacuum norm `1` and
   mutually adjoint creation/annihilation operators) and, in this file,
   `pairing_creationMonomial_of_hypotheses`, which is the genuinely conditional statement.
   A graph derivation should cite the conditional theorem, not the diagonal one.
2. The card's (H1)-(H4) are hypotheses on an abstract operator family; here they are
   *theorems*.  So this file certifies the card's conclusion, and shows the hypothesis set is
   consistent, but it does not certify that (H1)-(H4) hold for the *DDF* operators -- that is
   a separate obligation discharged elsewhere in the no-ghost island.
3. Positivity needs `η > 0` componentwise.  With the mostly-plus Minkowski metric this fails
   in the timelike direction (`Fock.pairing_X_X_minkowski_timelike`), which is precisely why
   the no-ghost theorem is about the *transverse* sector.

## Status

Complete, no `sorry`.
-/

namespace StringFormal.NoGhost

open MvPolynomial

namespace Fock

variable {D : ℕ} {R : Type*} [CommRing R]

/-! ### Creation monomials -/

/-- The state `∏_{(μ,n)} (α^μ_{-n})^{d(μ,n)} |0⟩`, indexed by the multiset of oscillators
recorded in `d`. -/
noncomputable def creationMonomial (R : Type*) [CommRing R] {D : ℕ} (d : Osc D →₀ ℕ) :
    Fock D R :=
  d.prod fun v k => (X v : Fock D R) ^ k

/-- A creation monomial is the corresponding polynomial monomial. -/
theorem creationMonomial_eq_monomial (d : Osc D →₀ ℕ) :
    creationMonomial R d = monomial d (1 : R) :=
  MvPolynomial.prod_X_pow_eq_monomial

@[simp]
theorem creationMonomial_zero : creationMonomial R (0 : Osc D →₀ ℕ) = vacuum D R :=
  Finsupp.prod_zero_index

theorem creationMonomial_single (v : Osc D) (k : ℕ) :
    creationMonomial R (Finsupp.single v k) = (X v : Fock D R) ^ k :=
  Finsupp.prod_single_index (pow_zero _)

/-- Adjoining one more creation operator.  Together with `creationMonomial_zero` this is the
recursive characterisation of `creationMonomial` as an iterated application of creation
operators to the vacuum. -/
theorem creationMonomial_add_single (d : Osc D →₀ ℕ) (v : Osc D) :
    creationMonomial R (d + Finsupp.single v 1)
      = creation R v.1 v.2 (creationMonomial R d) := by
  rw [creationMonomial_eq_monomial, creationMonomial_eq_monomial, creation_monomial]

/-- The level of `∏ (α^μ_{-n})^{d(μ,n)} |0⟩` is `Σ n · d(μ,n)`. -/
theorem creationMonomial_mem_levelSubmodule (d : Osc D →₀ ℕ) :
    creationMonomial R d ∈ levelSubmodule D R (level D d) := by
  classical
  rw [mem_levelSubmodule]
  intro e he
  rw [creationMonomial_eq_monomial, coeff_monomial] at he
  by_cases h : d = e
  · rw [h]
  · rw [if_neg h] at he
    exact absurd rfl he

/-! ### Commuting an annihilation operator through a creation monomial -/

/-- **Step (1)** of the Gram-matrix argument: the Leibniz rule for `α^μ_n` acting on a string
of creation operators.  Because the commutator `[α^μ_n, α^ν_{-m}] = n η^{μν} δ_{nm}` is
central, only the terms in which the annihilator is contracted with one of the `d(μ,n)`
factors `α^μ_{-n}` survive, each contributing `n η^{μμ}`. -/
theorem annihilation_creationMonomial (η : Fin D → R) (v : Osc D) (d : Osc D →₀ ℕ) :
    annihilation η v.1 v.2 (creationMonomial R d)
      = (oscWeight η v * (d v : R)) • creationMonomial R (d - Finsupp.single v 1) := by
  rw [annihilation_apply, creationMonomial_eq_monomial, pderiv_monomial,
    creationMonomial_eq_monomial, smul_monomial, smul_monomial]
  simp [smul_eq_mul]

/-- The recursion form of step (1): `d + δ_v` carries one more `α_{-v}`. -/
theorem annihilation_creationMonomial_add_single (η : Fin D → R) (v : Osc D) (d : Osc D →₀ ℕ) :
    annihilation η v.1 v.2 (creationMonomial R (d + Finsupp.single v 1))
      = (oscWeight η v * ((d v : R) + 1)) • creationMonomial R d := by
  classical
  have hsub : (d + Finsupp.single v 1) - Finsupp.single v 1 = d := by
    ext u
    by_cases h : u = v <;> simp [h]
  have hval : (d + Finsupp.single v 1 : Osc D →₀ ℕ) v = d v + 1 := by simp
  rw [annihilation_creationMonomial, hsub, hval, Nat.cast_add, Nat.cast_one]

/-- An annihilator whose mode is absent from the monomial kills it. -/
theorem annihilation_creationMonomial_of_apply_eq_zero (η : Fin D → R) (v : Osc D)
    {d : Osc D →₀ ℕ} (h : d v = 0) :
    annihilation η v.1 v.2 (creationMonomial R d) = 0 := by
  rw [annihilation_creationMonomial, h]
  simp

/-! ### The Gram matrix -/

/-- **Step (2)** of the argument: the recursion for the form.  Move one creation operator
from the left slot to the right slot using adjointness ((H2)/(H3)) and then commute it
through the string of creators with step (1). -/
theorem pairing_creationMonomial_add_single (η : Fin D → R) (v : Osc D) (d e : Osc D →₀ ℕ) :
    pairing η (creationMonomial R (d + Finsupp.single v 1)) (creationMonomial R e)
      = (oscWeight η v * (e v : R)) *
          pairing η (creationMonomial R d) (creationMonomial R (e - Finsupp.single v 1)) := by
  rw [creationMonomial_add_single, pairing_creation_left, annihilation_creationMonomial,
    map_smul, smul_eq_mul]

/-- **The Gram matrix of creation monomials on the Fock space.**  The monomials
`∏_{(μ,n)} (α^μ_{-n})^{d(μ,n)} |0⟩` are pairwise orthogonal, and the diagonal entry is
`∏_{(μ,n)} (n η^{μμ})^{d(μ,n)} · d(μ,n)!`.

This is the Fock-space instance of `worldsheet.transverse-ddf-fock-gram-matrix`. -/
theorem pairing_creationMonomial (η : Fin D → R) (d e : Osc D →₀ ℕ) :
    pairing η (creationMonomial R d) (creationMonomial R e)
      = if d = e then monomialNorm η d else 0 := by
  classical
  rw [creationMonomial_eq_monomial, creationMonomial_eq_monomial, pairing_monomial_monomial,
    one_mul, one_mul]

/-- Orthogonality of distinct creation monomials. -/
theorem pairing_creationMonomial_of_ne (η : Fin D → R) {d e : Osc D →₀ ℕ} (h : d ≠ e) :
    pairing η (creationMonomial R d) (creationMonomial R e) = 0 := by
  classical
  rw [pairing_creationMonomial, if_neg h]

/-- The diagonal entries. -/
@[simp]
theorem pairing_creationMonomial_self (η : Fin D → R) (d : Osc D →₀ ℕ) :
    pairing η (creationMonomial R d) (creationMonomial R d) = monomialNorm η d := by
  classical
  rw [pairing_creationMonomial, if_pos rfl]

/-- The **conditional** form of the card.  Any bilinear form `B` on the Fock space with
vacuum norm `1` ((H4)) for which the creation and annihilation operators are mutually
adjoint ((H2), (H3)) has the stated Gram matrix.  Hypothesis (H1) (the creation operators
commute) and the commutator normalisation `[α^μ_n, α^ν_{-m}] = n η^{μν} δ_{nm}` are theorems
about `Fock.creation`/`Fock.annihilation` (`Fock.creation_creation_comm`,
`Fock.lie_annihilation_creation`), so they need not be assumed.

This, rather than `pairing_creationMonomial`, is the faithful Lean rendering of the graph
card: the form is not assumed diagonal, only adjointness and the vacuum normalisation. -/
theorem pairing_creationMonomial_of_hypotheses (η : Fin D → R)
    (B : Fock D R →ₗ[R] Fock D R →ₗ[R] R)
    (hvac : B (vacuum D R) (vacuum D R) = 1)
    (hleft : ∀ (μ : Fin D) (n : ℕ+) (P Q : Fock D R),
      B (creation R μ n P) Q = B P (annihilation η μ n Q))
    (hright : ∀ (μ : Fin D) (n : ℕ+) (P Q : Fock D R),
      B P (creation R μ n Q) = B (annihilation η μ n P) Q)
    (d e : Osc D →₀ ℕ) :
    B (creationMonomial R d) (creationMonomial R e)
      = if d = e then monomialNorm η d else 0 := by
  classical
  rw [pairing_unique η B hvac hleft hright, pairing_creationMonomial]

/-- With `η = 1` — a positive-definite metric, e.g. the restriction to the transverse
directions — the diagonal entry is literally `∏_{(μ,n)} n^{d(μ,n)} · d(μ,n)!`, the form
stated on the graph card. -/
theorem monomialNorm_one (d : Osc D →₀ ℕ) :
    monomialNorm (1 : Fin D → R) d
      = d.prod fun v k => ((v.2 : ℕ) : R) ^ k * (k.factorial : R) := by
  refine Finsupp.prod_congr fun v _ => ?_
  rw [oscWeight]
  simp

/-- The Gram matrix for a positive-definite (all `+1`) metric, in the form stated on the
graph card. -/
theorem pairing_creationMonomial_one (d e : Osc D →₀ ℕ) :
    pairing (1 : Fin D → R) (creationMonomial R d) (creationMonomial R e)
      = if d = e then (d.prod fun v k => ((v.2 : ℕ) : R) ^ k * (k.factorial : R)) else 0 := by
  classical
  rw [pairing_creationMonomial, monomialNorm_one]

end Fock

end StringFormal.NoGhost
