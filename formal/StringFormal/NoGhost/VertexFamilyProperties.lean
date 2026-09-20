/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.DDFOperator

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
* `towerVertex_property_C2` — Property (C2): oscillator commutator, for every `h ∈ 𝔥`
* `towerVertex_property_C2_coord` — the coordinate-direction special case of (C2)
* `towerVertex_property_C3` — Property (C3): vacuum normalization

## What this file is and is not

It is a **repackaging**, not new mathematics. (C1) is `towerVertex_single_mem_levelSubmodule`
and (C2) is `lie_towerModeVec_towerVertex`, both pre-existing; only (C3) is new, and it is a
one-line `rw`. The point of the file is to state the three properties **against proof.md §3.3's
wording**, so that the hypotheses of that document's Theorem 3.5 (absolute uniqueness of the
n-type vertex family) can be checked against Lean objects rather than against prose.

It does **not** establish Theorem 3.5 itself, which lives in an `under-review` attempt and has
not been audited. Nothing here licenses any graph node to move status.

## Two scope caveats

1. **ν = 1 is hardcoded.** proof.md carries a general `ν := 2α'(k₀·p)`; `towerVertex η b n K`
   uses the oscillator index `K - n`, i.e. `nν` with `ν = 1`. That matches the normalization
   `2α' k₀·p = 1` declared by the graph card `worldsheet.ddf-operators-v6`, so the Lean family
   is proof.md's family **at ν = 1** and nowhere else.
2. **(C1) is stated as the exact single-rung computation** (`towerVertex` on `Finsupp.single`
   plus the level membership), which is what `towerVertex_single_mem_levelSubmodule` gives;
   proof.md phrases it as a subspace inclusion. The former implies the latter by linearity,
   but that implication is not written down here.
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

For every `h ∈ 𝔥` (here: every vector `ε : Fin D → R`) and every `p ∈ ℤ`:
  [h·α_p, V^{(n)}_K] = ⟨h, n k₀⟩ · V^{(n)}_{K-p}

This is property (C2) from proof.md §3.3 **verbatim**, including its quantifier over all of `𝔥`:
`towerModeVec η a b ε p = Σ_μ η_μ ε^μ α^μ_p` is the metric contraction `h·α_p`, and the
right-hand coefficient `n · dotVec η ε b = Σ_μ η_μ ε^μ (n b)^μ` is `⟨h, n k₀⟩` — the metric
factor `η_μ` is carried on **both** sides, so nothing is dropped.

This is directly `lie_towerModeVec_towerVertex` (`NoGhost/DDFOperator.lean`).

⚠ The coordinate-direction version `towerVertex_property_C2_coord` below is the special case
`ε = e_ν`; it reads `[α^ν_p, V] = (n b^ν) V` with **no** `η_ν`, because the `η_ν` produced by
the contraction on the left cancels the one on the right. It is *not* a faithful rendering of
(C2) on its own — (C2) quantifies over all of `𝔥`, and recovering that from the coordinate
version needs the linearity step that `lie_towerModeVec_towerVertex` already performs. -/
theorem towerVertex_property_C2 (η a b ε : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (n K p : ℤ) :
    ⁅towerModeVec η a b ε p, towerVertex η b n K⁆
      = ((n : R) * dotVec η ε b) • towerVertex η b n (K - p) :=
  lie_towerModeVec_towerVertex η a b ε hη n K p

/-- The coordinate-direction special case of `towerVertex_property_C2` (`ε = e_ν`, with the
`η_ν` cancelled off both sides). Recorded for use against the single-index form of the moment
machinery; see the warning in `towerVertex_property_C2`'s docstring. -/
theorem towerVertex_property_C2_coord (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
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
