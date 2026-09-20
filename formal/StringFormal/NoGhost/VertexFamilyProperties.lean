/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.DDF

/-!
# Vertex family characterization properties (C1), (C2), (C3)

This file formalizes the three properties (C1), (C2), (C3) from
`research/attempts/physical-exponential-equals-lattice-voa/proof.md` §3.3, which uniquely
characterize the n-type vertex operator family on the momentum tower.

From the proof document:
> **Definition (n-type vertex family).** A family {A_K}_{K ∈ ℤ} ⊆ End(T) is called an
> **n-type vertex family** if:
>
> - **(C1) Layer shift + exact level raising**: For all N ∈ ℤ, M ≥ 0, K ∈ ℤ,
>     A_K(T_N^{(M)}) ⊆ T_{N+n}^{(M + K - nν)}
>
> - **(C2) Oscillator commutator**: For all h ∈ 𝔥 and all m ∈ ℤ,
>     [h·α_m, A_K] = ⟨h, nk⟩ · A_{K-m}
>
> - **(C3) Vacuum normalization**: A_{nν}|0;N⟩ = |0;N+n⟩ for all N ∈ ℤ

The proof document establishes (Theorem 3.5) that these three properties uniquely characterize
the family {𝒫_{n,K}}_{K∈ℤ} where 𝒫_{n,K} = S_n ∘ V^{(b_n)}_{K-nν}, which in Lean is
`towerVertex η b n K` with the DDF normalization ν=1 (so K-nν = K-n).

## Main results

* `towerVertex_property_C1` — Property (C1): layer shift and exact level raising
* `towerVertex_property_C2` — Property (C2): oscillator commutator
* `towerVertex_property_C3` — Property (C3): vacuum normalization

## Notes

- Property (C1) is directly provided by the existing `towerVertex_single_mem_levelSubmodule`.
- Property (C2) is directly provided by the existing `lie_towerMode_towerVertex`.
- Property (C3) requires a new proof using `Fock.vertexOsc_apply_one` and the fact that
  `creaExp η b 0 = 1`.

The DDF normalization condition 2α'k₀·p = 1 (i.e., ν=1 in the proof document) is built into
Lean's indexing: `towerVertex η b n K` uses index `K - n` for the oscillator part, where
`n` plays the role of `nν` with ν=1.
-/

namespace StringFormal.NoGhost

open MvPolynomial

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

/-- **Property (C1): Layer shift + exact level raising.**

The vertex operator `towerVertex η b n K` maps the level-M subspace of rung j to the
level-(M + K - n) subspace of rung (j + n). With the DDF normalization ν=1, this is exactly
property (C1) from proof.md §3.3:

  V^{(n)}_K : T_j^{(M)} → T_{j+n}^{(M + K - nν)}  with nν = n·1 = n

This is an immediate consequence of `towerVertex_single_mem_levelSubmodule`. -/
theorem towerVertex_property_C1 (η b : Fin D → R) (n K : ℤ) (j : ℤ) {N M : ℕ}
    {P : Fock D R} (hP : P ∈ Fock.levelSubmodule D R N) (hM : (M : ℤ) = (N : ℤ) + (K - n)) :
    towerVertex η b n K (Finsupp.single j P) = Finsupp.single (j + n)
      (Fock.vertexOsc η (vertexMomentum b n) (K - n) P) ∧
    Fock.vertexOsc η (vertexMomentum b n) (K - n) P ∈ Fock.levelSubmodule D R M :=
  towerVertex_single_mem_levelSubmodule η b n K j hP hM

/-- **Property (C2): Oscillator commutator.**

For all μ ∈ Fin D and all p ∈ ℤ:
  [α^μ_p, V^{(n)}_K] = (n b^μ) V^{(n)}_{K-p}

With h = e_μ (the μ-th coordinate vector), this is property (C2) from proof.md §3.3:
  [h·α_m, A_K] = ⟨h, nk⟩ · A_{K-m}

where ⟨h, nk⟩ = η_μ·h^μ·(nk)^μ = n·b^μ (since b = k in rescaled units and h^μ = δ^μ_ν).

This is directly `lie_towerMode_towerVertex`. -/
theorem towerVertex_property_C2 (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (μ : Fin D) (n K p : ℤ) :
    ⁅towerMode η a b μ p, towerVertex η b n K⁆ = ((n : R) * b μ) • towerVertex η b n (K - p) :=
  lie_towerMode_towerVertex η a b hη μ n K p

/-- **Property (C3): Vacuum normalization.**

The vertex operator V^{(n)}_{nν} maps the vacuum |0;j⟩ on rung j to the vacuum |0;j+n⟩ on
rung j+n. With the DDF normalization ν=1, this is property (C3) from proof.md §3.3:
  A_{nν}|0;N⟩ = |0;N+n⟩

In Lean: `towerVertex η b n n` applied to `Finsupp.single j (1 : Fock D R)` equals
`Finsupp.single (j + n) (1 : Fock D R)`.

The proof uses:
- `towerVertex_single`: definition of `towerVertex` on a single rung
- `Fock.vertexOsc_apply_one`: `vertexOsc η b K (1 : Fock D R) = creaExp η b K`
- `Fock.creaExp_zero`: `creaExp η b 0 = 1` -/
theorem towerVertex_property_C3 (η b : Fin D → R) (n : ℤ) (j : ℤ) :
    towerVertex η b n n (Finsupp.single j (1 : Fock D R)) =
      Finsupp.single (j + n) (1 : Fock D R) := by
  rw [towerVertex_single, Fock.vertexOsc_apply_one, show n - n = 0 from by ring,
    Fock.creaExp_zero]

end StringFormal.NoGhost
