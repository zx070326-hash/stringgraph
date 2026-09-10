/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import Mathlib.LinearAlgebra.Vandermonde

/-!
# Two algebraic lemmas behind tree-level open-string amplitudes

This is a standalone island (imports only Mathlib; imports nothing from `StringFormal`).
It collects the two purely algebraic facts that the §6 amplitude branch of the graph rests on.

## A. Möbius three-point fixing

Suggested graph node: `math.mobius-three-point-fixing-jacobian`.

An infinitesimal `PSL(2,ℝ)` / `PSL(2,ℂ)` transformation of the boundary coordinate is
`δz = a₀ + a₁ z + a₂ z²`.  Fixing three punctures `z₁, z₂, z₃` amounts to solving the linear
system `a₀ + a₁ zᵢ + a₂ zᵢ² = wᵢ` for `(a₀, a₁, a₂)`; its matrix is the 3×3 Vandermonde matrix
and its determinant is

  `det [[1, z₁, z₁²], [1, z₂, z₂²], [1, z₃, z₃²]] = (z₂ - z₁) (z₃ - z₁) (z₃ - z₂)`,

so the gauge fixing is possible and unique exactly when the three points are pairwise
distinct.  Up to sign this is the Faddeev–Popov Jacobian `|z₁₂ z₁₃ z₂₃|` multiplying the
Koba–Nielsen integrand.

## B. Mandelstam sum rule

Suggested graph node: `spectrum.mandelstam-invariants-sum-rule`.

For four momenta with `Σ kᵢ = 0` and `kᵢ² = -mᵢ²` (mostly-plus signature,
`graph/conventions/metric-signature`), the invariants
`s = -(k₁+k₂)²`, `t = -(k₁+k₃)²`, `u = -(k₁+k₄)²` satisfy `s + t + u = Σ mᵢ²`.
Specialised to four open-string tachyons, `α' mᵢ² = -1`, this gives `α'(s+t+u) = -4`,
i.e. `α_c(s) + α_c(t) + α_c(u) = -1` for the Regge trajectory `α_c(x) = 1 + α' x`.

## Status

Skeleton; statements are added one declaration per commit.  Nothing here is `sorry`ed:
declarations appear only once proved.
-/

namespace StringFormal.Math

end StringFormal.Math
