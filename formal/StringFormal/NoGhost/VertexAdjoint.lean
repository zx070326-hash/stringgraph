/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import Mathlib.Algebra.MvPolynomial.CommRing
import StringFormal.NoGhost.TowerPairing
import StringFormal.NoGhost.VertexOperator
import StringFormal.NoGhost.DDFOperator

/-!
# The adjoint of the vertex operator for the Fock and tower forms

Graph nodes: `worldsheet.vertex-operator-adjoint`, `worldsheet.ddf-operators-adjoint`.
This file closes gap (3) of `StringFormal/NoGhost/VertexOperator.lean` and gap (2) of
`StringFormal/NoGhost/TowerPairing.lean`.

## Status

Work in progress; no `sorry`.
-/

namespace StringFormal.NoGhost

open MvPolynomial

namespace Fock

variable {D : ℕ} {R : Type*} [CommRing R]

/-- Pairing against the vacuum extracts the constant term. -/
lemma pairing_one_left (η : Fin D → R) (Q : Fock D R) :
    pairing η (1 : Fock D R) Q = coeff 0 Q := by
  have h : (1 : Fock D R) = monomial (0 : Osc D →₀ ℕ) 1 := by rw [monomial_zero', C_1]
  rw [h, pairing_monomial_left, monomialNorm_zero, one_mul, one_mul]

private lemma coeff_zero_mul_X (Q : Fock D R) (u : Osc D) :
    coeff (0 : Osc D →₀ ℕ) (Q * X u) = 0 := by
  classical
  rw [coeff_mul_X', if_neg (by simp)]

section CreaExpAdjoint

variable [Algebra ℚ R]

/-- **The vacuum matrix element of the creation exponential.**  `⟨Φ_j(b), w⟩ = ` the constant
term of `Ψ_j(-b) w`.  This is the one computation behind every adjointness statement in this
file; both sides satisfy the same recursion in `w`. -/
theorem pairing_creaExp_one_left (η b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (j : ℤ)
    (w : Fock D R) :
    pairing η (creaExp η b j) w = coeff 0 (vertexAnn (-b) j w) := by
  classical
  induction w using MvPolynomial.induction_on generalizing j with
  | C a =>
      have hCa : (C a : Fock D R) = a • (1 : Fock D R) := by
        rw [MvPolynomial.smul_eq_C_mul, mul_one]
      rw [hCa, map_smul, smul_eq_mul, map_smul, coeff_smul, smul_eq_mul, vertexAnn_one,
        pairing_comm, pairing_one_left, coeff_creaExp]
      by_cases h : j = 0
      · subst h
        rw [if_pos rfl, if_pos (by simp), expWeight_zero, coeff_one, if_pos rfl]
      · rw [if_neg h, if_neg (fun hc => h hc.symm), coeff_zero]
  | add p q hp hq =>
      rw [map_add (pairing η (creaExp η b j)), map_add (vertexAnn (-b) j), coeff_add, hp, hq]
  | mul_X p u hp =>
      have hcre : (p * X u : Fock D R) = creation R u.1 u.2 p := by
        rw [creation_apply, mul_comm]
      rw [hcre, pairing_creation_right, annihilation_creaExp η b hη, map_smul,
        LinearMap.smul_apply, smul_eq_mul, hp, ← hcre, vertexAnn_mul_X, coeff_sub,
        coeff_zero_mul_X, coeff_smul, smul_eq_mul, Pi.neg_apply]
      ring

end CreaExpAdjoint

end Fock

end StringFormal.NoGhost
