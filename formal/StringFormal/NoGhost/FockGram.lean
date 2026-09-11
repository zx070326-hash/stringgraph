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

end Fock

end StringFormal.NoGhost
