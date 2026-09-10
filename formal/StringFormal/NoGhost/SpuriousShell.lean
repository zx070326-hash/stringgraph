/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.PhysicalStates

/-!
# Spurious states on the mass shell, and null states

Graph node: `worldsheet.ocq-spurious-states-v2` (Polchinski §4.1, eq. (4.1.8)/(4.1.9)).

`StringFormal/NoGhost/PhysicalStates.lean` already has the *off-shell* spurious subspace
`Fock.spuriousSubmodule η a = Σ_{n ≥ 1} range (L_{-n})`, which the graph carries as the separate
card `worldsheet.spurious-subspace`.  Polchinski's spurious states carry in addition the mass
shell condition `(L_0 - a₀) χ = 0`.  This file adds exactly that intersection and the resulting
notion of null state:

* `Fock.spuriousShell η a a₀` — **`S(k) = S ∩ ker (L_0 - a₀)`**, the on-shell spurious states.
* `Fock.nullStates η a a₀` — **`N(k) = S(k) ∩ H_phys`**, Polchinski's null states.
* `Fock.nullStates_le_nullSubmodule` — **every null state in this sense is orthogonal to all of
  `H_phys`** (in particular has zero norm), i.e. `N(k) ⊆ H_0(k)`, the radical of `H_phys`, which
  is what `Fock.nullSubmodule` formalises.
* `Fock.nullStates_eq` — **`N(k) = S ∩ H_phys`**: the definition of a null state does not care
  whether the mass shell condition is imposed on `S`, because `H_phys ⊆ ker (L_0 - a₀)` already.
  This is the "两种读法给出同一个 N(k)" clause of the graph node.

## Conventions

Inherited verbatim from `StringFormal/NoGhost/PhysicalStates.lean` and
`StringFormal/NoGhost/Sugawara.lean`: `conv.metric-mostly-plus` (through the sign function
`η : Fin D → R`), `conv.virasoro-standard`, `conv.alpha-prime-regge`, and `conv.intercept-sign-a`
(the intercept is the `a₀ : R` of `physSubmodule`; Polchinski's `A` is `-a₀`).  As everywhere in
this island the Fock space has **no zero modes**: `a : Fin D → R` is a scalar parameter standing
for `α^μ_0 = (2α')^{1/2} k^μ`, so all of this happens inside one fixed-momentum sector `F(k)` and
there is no integral over `k`.  See the gaps section of `StringFormal/NoGhost/Fock.lean`.

## Gaps

* The reverse inclusion `H_0(k) ⊆ N(k)` ("every zero-norm physical state is spurious") is **not**
  here and is not a formality: it is a critical-dimension statement (`D = 26`, `a₀ = 1`).  The
  graph node records that it has no card yet.
* `spuriousShell` is *not* shown to equal `Σ_{n ≥ 1} L_{-n} (ker (L_0 - a₀ + n))`, i.e. we do not
  decompose an on-shell spurious state into pieces that are individually on shell.  That needs
  the `L_0`-eigenspace decomposition of `S`, which is not assembled here.
-/

namespace StringFormal.NoGhost

namespace Fock

variable {D : ℕ} {R : Type*} [CommRing R]

section SpuriousShell

variable [Algebra ℚ R] (η a : Fin D → R) (a₀ : R)

/-- **Spurious states on the mass shell** (graph node `worldsheet.ocq-spurious-states-v2`,
Polchinski (4.1.8)):

`S(k) = S ∩ ker (L_0 - a₀) = {χ ∈ Σ_{n ≥ 1} range L_{-n} : (L_0 - a₀) χ = 0}`.

Unlike `spuriousSubmodule`, this *does* depend on the intercept `a₀`. -/
noncomputable def spuriousShell : Submodule R (Fock D R) :=
  spuriousSubmodule η a ⊓
    LinearMap.ker (Lop η a 0 - a₀ • (LinearMap.id : Module.End R (Fock D R)))

/-- **Null states** in Polchinski's sense (4.1.9): states that are both physical and spurious. -/
noncomputable def nullStates : Submodule R (Fock D R) :=
  spuriousShell η a a₀ ⊓ physSubmodule η a a₀

variable {η a a₀}

lemma mem_spuriousShell {χ : Fock D R} :
    χ ∈ spuriousShell η a a₀ ↔ χ ∈ spuriousSubmodule η a ∧ Lop η a 0 χ = a₀ • χ := by
  simp only [spuriousShell, Submodule.mem_inf, LinearMap.mem_ker, LinearMap.sub_apply,
    LinearMap.smul_apply, LinearMap.id_coe, id_eq, sub_eq_zero]

lemma Lop_zero_apply_of_mem_spuriousShell {χ : Fock D R} (hχ : χ ∈ spuriousShell η a a₀) :
    Lop η a 0 χ = a₀ • χ := (mem_spuriousShell.mp hχ).2

variable (η a a₀)

lemma spuriousShell_le_spuriousSubmodule : spuriousShell η a a₀ ≤ spuriousSubmodule η a :=
  inf_le_left

/-- `H_phys` sits inside the mass shell; this is the first half of the definition of
`physSubmodule`. -/
lemma physSubmodule_le_ker_Lop_zero_sub :
    physSubmodule η a a₀ ≤
      LinearMap.ker (Lop η a 0 - a₀ • (LinearMap.id : Module.End R (Fock D R))) := by
  intro ψ hψ
  simp only [LinearMap.mem_ker, LinearMap.sub_apply, LinearMap.smul_apply, LinearMap.id_coe,
    id_eq, sub_eq_zero]
  exact Lop_zero_apply_of_mem_physSubmodule hψ

/-- **On-shell spurious states are orthogonal to all physical states**, because already the
off-shell ones are (`spuriousSubmodule_le_orthComplement`). -/
theorem spuriousShell_le_orthComplement :
    spuriousShell η a a₀ ≤ orthComplement η (physSubmodule η a a₀) :=
  le_trans (spuriousShell_le_spuriousSubmodule η a a₀)
    (spuriousSubmodule_le_orthComplement η a a₀)

/-- **`N(k) = S ∩ H_phys`**: imposing the mass shell condition on the spurious subspace does not
change the set of null states, because physical states are on shell anyway.  This is the graph
node's "零态的定义对『S 带不带质量壳』不敏感". -/
theorem nullStates_eq : nullStates η a a₀ = spuriousSubmodule η a ⊓ physSubmodule η a a₀ := by
  refine le_antisymm (inf_le_inf_right _ (spuriousShell_le_spuriousSubmodule η a a₀)) ?_
  refine le_inf (le_inf inf_le_left ?_) inf_le_right
  exact le_trans inf_le_right (physSubmodule_le_ker_Lop_zero_sub η a a₀)

/-- **A null state in Polchinski's sense lies in the radical of `H_phys`**: it is physical and
orthogonal to every physical state.  The reverse inclusion is a critical-dimension statement and
is *not* proved here. -/
theorem nullStates_le_nullSubmodule : nullStates η a a₀ ≤ nullSubmodule η a a₀ := by
  rw [nullStates_eq]
  exact spurious_inf_physSubmodule_le_nullSubmodule η a a₀

theorem nullStates_le_physSubmodule : nullStates η a a₀ ≤ physSubmodule η a a₀ := inf_le_right

theorem nullStates_le_spuriousShell : nullStates η a a₀ ≤ spuriousShell η a a₀ := inf_le_left

variable {η a a₀}

lemma mem_nullStates {χ : Fock D R} :
    χ ∈ nullStates η a a₀ ↔ χ ∈ spuriousSubmodule η a ∧ χ ∈ physSubmodule η a a₀ := by
  rw [nullStates_eq, Submodule.mem_inf]

/-- **Null states have zero norm.** -/
theorem pairing_self_eq_zero_of_mem_nullStates {χ : Fock D R} (hχ : χ ∈ nullStates η a a₀) :
    pairing η χ χ = 0 :=
  pairing_self_eq_zero_of_mem_nullSubmodule (nullStates_le_nullSubmodule η a a₀ hχ)

/-- The concrete form: if `L_{-n} ψ` (`n ≥ 1`) happens to be physical, then it is a null state in
the sense of this file. -/
theorem Lop_neg_apply_mem_nullStates {n : ℤ} (hn : 0 < n) (ψ : Fock D R)
    (hmem : Lop η a (-n) ψ ∈ physSubmodule η a a₀) :
    Lop η a (-n) ψ ∈ nullStates η a a₀ :=
  mem_nullStates.mpr ⟨Lop_neg_mem_spuriousSubmodule η a hn ψ, hmem⟩

end SpuriousShell

end Fock

end StringFormal.NoGhost
