/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.PhysicalStates

/-!
# The level-two scalar physical state and the negative norm above `D = 26`

Graph nodes: `worldsheet.ocq-level-two-scalar-norm` (the closed form of the norm) and clause
(2) of `worldsheet.no-ghost-theorem-v4` (for `D > 26` and intercept `a₀ = 1` the physical
subspace contains a negative-norm vector).  See `formal/TODO.md` item
`negative-norm-above-26`.

## Conventions

Inherited verbatim from `Sugawara.lean` / `PhysicalStates.lean`: `conv.metric-mostly-plus`
(diagonal `η : Fin D → R` with `hη : ∀ μ, η μ * η μ = 1`), `conv.alpha-prime-regge` (the zero
mode is the parameter `a : Fin D → R` standing for `a^μ = α^μ_0 = (2α')^{1/2} k^μ`, so that
`invTwo R * zeroModeSq η a = α' k²` and, at `α' = 1/2`, `a = k`), `conv.virasoro-standard`,
and `conv.intercept-sign-a` (the intercept is `a₀`, Polchinski's `-A`).

## Main definitions

* `Fock.traceState η` — `α_{-1} · α_{-1} |k⟩ = η_{μν} α^μ_{-1} α^ν_{-1} |k⟩`.
* `Fock.secondState η a` — `(a · α_{-2}) |k⟩`.
* `Fock.polSqState η a` — `(a · α_{-1})² |k⟩`.
* `Fock.levelTwoScalar η a c₂ c₃` — the level-two scalar trial state
  `[α_{-1}·α_{-1} + c₂ (a·α_{-2}) + c₃ (a·α_{-1})²] |k⟩`.

## Status

Skeleton: the definitions and their level-two homogeneity.  The `L_1`, `L_2` computations, the
norm and the negative-norm corollary follow in this file.
-/

namespace StringFormal.NoGhost

open MvPolynomial

namespace Fock

variable {D : ℕ} {R : Type*} [CommRing R]

section Defs

variable (η a : Fin D → R)

/-- `α_{-1} · α_{-1} |k⟩ = η_{μν} α^μ_{-1} α^ν_{-1} |k⟩`. -/
noncomputable def traceState : Fock D R :=
  ∑ μ : Fin D, η μ • (X ((μ, 1) : Osc D) * X ((μ, 1) : Osc D) : Fock D R)

/-- `(a · α_{-2}) |k⟩ = η_{μν} a^μ α^ν_{-2} |k⟩`. -/
noncomputable def secondState : Fock D R :=
  ∑ μ : Fin D, (η μ * a μ) • (X ((μ, 2) : Osc D) : Fock D R)

/-- `(a · α_{-1})² |k⟩`, the square of the level-one state `Fock.polState η a`. -/
noncomputable def polSqState : Fock D R := polState η a * polState η a

/-- **The level-two scalar trial state**
`[α_{-1}·α_{-1} + c₂ (a·α_{-2}) + c₃ (a·α_{-1})²] |k⟩`, with free coefficients `c₂ c₃ : R`.
This is the state of `worldsheet.ocq-level-two-scalar-norm`. -/
noncomputable def levelTwoScalar (c₂ c₃ : R) : Fock D R :=
  traceState η + c₂ • secondState η a + c₃ • polSqState η a

end Defs

/-! ### Level-two homogeneity -/

section Level

variable (η a : Fin D → R)

lemma X_mem_levelSubmodule (μ : Fin D) (n : ℕ+) :
    (X ((μ, n) : Osc D) : Fock D R) ∈ levelSubmodule D R (n : ℕ) := by
  have h := creation_mem_levelSubmodule (R := R) μ n (one_mem_levelSubmodule D R)
  rw [creation_apply, mul_one] at h
  simpa using h

lemma traceState_mem_levelSubmodule_two : traceState η ∈ levelSubmodule D R 2 := by
  refine Submodule.sum_mem _ fun μ _ => Submodule.smul_mem _ _ ?_
  have h := creation_mem_levelSubmodule (R := R) μ 1 (X_mem_levelSubmodule (R := R) μ 1)
  rw [creation_apply] at h
  simpa using h

lemma secondState_mem_levelSubmodule_two : secondState η a ∈ levelSubmodule D R 2 := by
  refine Submodule.sum_mem _ fun μ _ => Submodule.smul_mem _ _ ?_
  simpa using X_mem_levelSubmodule (R := R) μ 2

lemma polSqState_mem_levelSubmodule_two : polSqState η a ∈ levelSubmodule D R 2 :=
  (polState_mem_levelSubmodule_one (η := η) a).mul (polState_mem_levelSubmodule_one (η := η) a)

lemma levelTwoScalar_mem_levelSubmodule_two (c₂ c₃ : R) :
    levelTwoScalar η a c₂ c₃ ∈ levelSubmodule D R 2 :=
  Submodule.add_mem _
    (Submodule.add_mem _ (traceState_mem_levelSubmodule_two η)
      (Submodule.smul_mem _ _ (secondState_mem_levelSubmodule_two η a)))
    (Submodule.smul_mem _ _ (polSqState_mem_levelSubmodule_two η a))

end Level

end Fock

end StringFormal.NoGhost
