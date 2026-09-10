/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.PhysicalStates

/-!
# The induced form on `H_phys / H_null` is well defined

Graph node: `worldsheet.spurious-orthogonal-to-physical`, second half ("hence the inner
product descends to the quotient `H_phys / H_null`").
Convention: `conv.metric-signature` (mostly-plus); the form is `R`-bilinear, not
sesquilinear, so no reality/positivity assumption on `η` or on the momentum `a` is used.

## What is here

`StringFormal/NoGhost/PhysicalStates.lean` has `Fock.physSubmodule η a a₀` (`H_phys`),
`Fock.nullSubmodule η a a₀` (`H_null`, the physical states orthogonal to all physical states)
and `Fock.nullSubmodule_le_physSubmodule`.  This file supplies the quotient:

* `Fock.pairing_add_null_left`, `Fock.pairing_add_null_right`, `Fock.pairing_add_null` —
  **`⟨ψ + χ, ψ' + χ'⟩ = ⟨ψ, ψ'⟩`** for `ψ, ψ' ∈ H_phys` and `χ, χ' ∈ H_null`.  Note the
  statement needs `χ' ∈ H_null` *and* `ψ + χ ∈ H_phys`; the latter uses
  `nullSubmodule_le_physSubmodule`, i.e. null states are themselves physical.  Without that
  inclusion the cross term `⟨χ, χ'⟩` would not obviously vanish.
* `Fock.pairing_eq_of_sub_mem_nullSubmodule` — the same fact phrased as well-definedness:
  the pairing only depends on the classes mod `H_null`.
* `Fock.nullInPhys`, `Fock.PhysQuot` — `H_null` viewed inside `H_phys`, and the quotient
  `H_phys ⧸ H_null` as an `R`-module.
* `Fock.quotientPairing` — **the induced bilinear form on `H_phys ⧸ H_null`**, built by
  `Submodule.liftQ` in each argument, with `Fock.quotientPairing_mk` the computation rule
  `⟨[ψ], [φ]⟩ = ⟨ψ, φ⟩` and `Fock.quotientPairing_comm` its symmetry.

## Gaps

1. **Nondegeneracy is not proved here, and is not automatic.**  By construction
   `quotientPairing` is nondegenerate *if* `H_null` is exactly the radical of the form
   restricted to `H_phys`.  That is true by definition of `nullSubmodule` as
   `H_phys ⊓ orthComplement η H_phys`, but the corresponding Lean statement
   (`∀ q, (∀ q', quotientPairing q q' = 0) → q = 0`) is **not** formalised: extracting it
   needs to go from "the class of ψ pairs to zero with every class" back to "ψ pairs to zero
   with every physical state", which is immediate, and then to `ψ ∈ nullInPhys`; this is
   routine but not done.
2. **No positivity.**  The no-ghost theorem asserts `quotientPairing` is positive definite at
   `D = 26`, `a₀ = 1`.  Nothing here speaks to that; over a general commutative ring there is
   not even an order.
3. **`H_null = H_spurious ∩ H_phys` is only one inclusion** (see `PhysicalStates.lean` gaps).
   So `PhysQuot` is the quotient by the *orthogonal radical*, which is the right object, but
   identifying it with "physical states modulo spurious states" still needs the hard half.
-/

namespace StringFormal.NoGhost

open MvPolynomial

namespace Fock

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

/-! ### Shifting by a null state does not change the pairing -/

section AddNull

variable {η a : Fin D → R} {a₀ : R}

/-- A null state pairs to zero with every physical state. -/
theorem pairing_eq_zero_of_mem_nullSubmodule {χ ψ : Fock D R}
    (hχ : χ ∈ nullSubmodule η a a₀) (hψ : ψ ∈ physSubmodule η a a₀) :
    pairing η χ ψ = 0 :=
  (mem_nullSubmodule.mp hχ).2 ψ hψ

/-- A physical state pairs to zero with every null state. -/
theorem pairing_eq_zero_of_mem_nullSubmodule' {ψ χ : Fock D R}
    (hψ : ψ ∈ physSubmodule η a a₀) (hχ : χ ∈ nullSubmodule η a a₀) :
    pairing η ψ χ = 0 := by
  rw [pairing_comm]
  exact pairing_eq_zero_of_mem_nullSubmodule hχ hψ

/-- `⟨ψ + χ, φ⟩ = ⟨ψ, φ⟩` for `χ` null and `φ` physical. -/
theorem pairing_add_null_left {ψ χ φ : Fock D R} (hχ : χ ∈ nullSubmodule η a a₀)
    (hφ : φ ∈ physSubmodule η a a₀) :
    pairing η (ψ + χ) φ = pairing η ψ φ := by
  rw [map_add, LinearMap.add_apply, pairing_eq_zero_of_mem_nullSubmodule hχ hφ, add_zero]

/-- `⟨ψ, φ + χ⟩ = ⟨ψ, φ⟩` for `ψ` physical and `χ` null. -/
theorem pairing_add_null_right {ψ φ χ : Fock D R} (hψ : ψ ∈ physSubmodule η a a₀)
    (hχ : χ ∈ nullSubmodule η a a₀) :
    pairing η ψ (φ + χ) = pairing η ψ φ := by
  rw [map_add, pairing_eq_zero_of_mem_nullSubmodule' hψ hχ, add_zero]

/-- **`⟨ψ + χ, φ + χ'⟩ = ⟨ψ, φ⟩`** for `ψ, φ ∈ H_phys` and `χ, χ' ∈ H_null`: the inner
product of physical states depends only on their classes modulo null states.  Graph node
`worldsheet.spurious-orthogonal-to-physical`, second half. -/
theorem pairing_add_null {ψ φ χ χ' : Fock D R} (hψ : ψ ∈ physSubmodule η a a₀)
    (hφ : φ ∈ physSubmodule η a a₀) (hχ : χ ∈ nullSubmodule η a a₀)
    (hχ' : χ' ∈ nullSubmodule η a a₀) :
    pairing η (ψ + χ) (φ + χ') = pairing η ψ φ := by
  rw [pairing_add_null_right (add_mem hψ (nullSubmodule_le_physSubmodule hχ)) hχ',
    pairing_add_null_left hχ hφ]

/-- Well-definedness, phrased with differences: the pairing of physical states only depends on
their classes modulo `H_null`. -/
theorem pairing_eq_of_sub_mem_nullSubmodule {ψ ψ' φ φ' : Fock D R}
    (hψ : ψ ∈ physSubmodule η a a₀) (hφ : φ ∈ physSubmodule η a a₀)
    (hψ' : ψ - ψ' ∈ nullSubmodule η a a₀) (hφ' : φ - φ' ∈ nullSubmodule η a a₀) :
    pairing η ψ φ = pairing η ψ' φ' := by
  have hn1 : ψ' - ψ ∈ nullSubmodule η a a₀ := by
    rw [← neg_sub]; exact neg_mem hψ'
  have hn2 : φ' - φ ∈ nullSubmodule η a a₀ := by
    rw [← neg_sub]; exact neg_mem hφ'
  have e1 : ψ' = ψ + (ψ' - ψ) := by abel
  have e2 : φ' = φ + (φ' - φ) := by abel
  rw [e1, e2, pairing_add_null hψ hφ hn1 hn2]

end AddNull

/-! ### The quotient `H_phys / H_null` and the induced form -/

section Quotient

variable (η a : Fin D → R) (a₀ : R)

/-- `H_null` regarded as a submodule of `H_phys` (legitimate by
`nullSubmodule_le_physSubmodule`). -/
noncomputable def nullInPhys : Submodule R (physSubmodule η a a₀) :=
  (nullSubmodule η a a₀).comap (physSubmodule η a a₀).subtype

@[simp]
lemma mem_nullInPhys {ψ : physSubmodule η a a₀} :
    ψ ∈ nullInPhys η a a₀ ↔ (ψ : Fock D R) ∈ nullSubmodule η a a₀ := Iff.rfl

/-- **`H_phys / H_null`.** -/
abbrev PhysQuot : Type _ := physSubmodule η a a₀ ⧸ nullInPhys η a a₀

/-- The Fock form restricted to `H_phys`. -/
noncomputable def physPairing : LinearMap.BilinForm R (physSubmodule η a a₀) :=
  (pairing η).compl₁₂ (physSubmodule η a a₀).subtype (physSubmodule η a a₀).subtype

@[simp]
lemma physPairing_apply (ψ φ : physSubmodule η a a₀) :
    physPairing η a a₀ ψ φ = pairing η (ψ : Fock D R) (φ : Fock D R) := by
  rw [physPairing, LinearMap.compl₁₂_apply, Submodule.subtype_apply, Submodule.subtype_apply]

theorem nullInPhys_le_ker_physPairing :
    nullInPhys η a a₀ ≤ LinearMap.ker (physPairing η a a₀) := by
  intro χ hχ
  rw [LinearMap.mem_ker]
  refine LinearMap.ext fun φ => ?_
  rw [physPairing_apply, LinearMap.zero_apply]
  exact pairing_eq_zero_of_mem_nullSubmodule hχ φ.2

/-- Auxiliary: the form with the *first* argument already descended to the quotient. -/
noncomputable def quotientPairingAux :
    PhysQuot η a a₀ →ₗ[R] physSubmodule η a a₀ →ₗ[R] R :=
  (nullInPhys η a a₀).liftQ (physPairing η a a₀) (nullInPhys_le_ker_physPairing η a a₀)

@[simp]
lemma quotientPairingAux_mk (ψ φ : physSubmodule η a a₀) :
    quotientPairingAux η a a₀ (Submodule.Quotient.mk ψ) φ
      = pairing η (ψ : Fock D R) (φ : Fock D R) := by
  rw [quotientPairingAux, Submodule.liftQ_apply, physPairing_apply]

theorem nullInPhys_le_ker_quotientPairingAux_flip :
    nullInPhys η a a₀ ≤ LinearMap.ker (quotientPairingAux η a a₀).flip := by
  intro χ hχ
  rw [LinearMap.mem_ker]
  refine LinearMap.ext fun q => ?_
  obtain ⟨φ, rfl⟩ := Submodule.Quotient.mk_surjective (nullInPhys η a a₀) q
  rw [LinearMap.flip_apply, quotientPairingAux_mk, LinearMap.zero_apply]
  exact pairing_eq_zero_of_mem_nullSubmodule' φ.2 hχ

/-- **The induced bilinear form on `H_phys / H_null`.**  Graph node
`worldsheet.spurious-orthogonal-to-physical`, second half: the inner product descends to the
quotient by the null states. -/
noncomputable def quotientPairing : LinearMap.BilinForm R (PhysQuot η a a₀) :=
  (nullInPhys η a a₀).liftQ (quotientPairingAux η a a₀).flip
    (nullInPhys_le_ker_quotientPairingAux_flip η a a₀)

/-- **The computation rule, i.e. well-definedness**: the induced form of two classes is the
Fock pairing of any two representatives. -/
@[simp]
theorem quotientPairing_mk (ψ φ : physSubmodule η a a₀) :
    quotientPairing η a a₀ (Submodule.Quotient.mk ψ) (Submodule.Quotient.mk φ)
      = pairing η (ψ : Fock D R) (φ : Fock D R) := by
  rw [quotientPairing, Submodule.liftQ_apply, LinearMap.flip_apply, quotientPairingAux_mk]
  exact pairing_comm η _ _

/-- The induced form is symmetric. -/
theorem quotientPairing_comm (q q' : PhysQuot η a a₀) :
    quotientPairing η a a₀ q q' = quotientPairing η a a₀ q' q := by
  obtain ⟨ψ, rfl⟩ := Submodule.Quotient.mk_surjective (nullInPhys η a a₀) q
  obtain ⟨φ, rfl⟩ := Submodule.Quotient.mk_surjective (nullInPhys η a a₀) q'
  rw [quotientPairing_mk, quotientPairing_mk]
  exact pairing_comm η _ _

/-- A null representative gives the zero class, hence the zero row of the induced form. -/
theorem quotientPairing_mk_eq_zero_of_mem_nullSubmodule {ψ : physSubmodule η a a₀}
    (hψ : (ψ : Fock D R) ∈ nullSubmodule η a a₀) (q : PhysQuot η a a₀) :
    quotientPairing η a a₀ (Submodule.Quotient.mk ψ) q = 0 := by
  obtain ⟨φ, rfl⟩ := Submodule.Quotient.mk_surjective (nullInPhys η a a₀) q
  rw [quotientPairing_mk]
  exact pairing_eq_zero_of_mem_nullSubmodule hψ φ.2

end Quotient

end Fock

end StringFormal.NoGhost
