# Attribution — `StringFormal/Virasoro/`

## What is derived from where

The construction in `Witt.lean` and `Basic.lean` is **not** a code port, but its design is
directly derived from prior work. Concretely:

### Kalle Kytölä, `VirasoroProject`

- Repository: <https://github.com/kkytola/VirasoroProject>
- Companion paper: Kalle Kytölä, *Virasoro algebra and Sugawara constructions formally in Lean*,
  [arXiv:2510.21741](https://arxiv.org/abs/2510.21741) (2025).
- License: **Apache License 2.0**. Source files carry
  `Copyright (c) 2024 Kalle Kytölä. All rights reserved. Released under Apache 2.0 license as
  described in the file LICENSE.`
- Version there: Lean `v4.27.0-rc1`, Mathlib `master` @ `b9b7d0bade32`.

Ideas taken from `VirasoroProject/WittAlgebra.lean` and `VirasoroProject/VirasoroCocycle.lean`:

1. Represent the Witt algebra as a type synonym for `ℤ →₀ 𝕜` and define the bracket by
   bilinear extension from the standard basis using `Module.Basis.constr`.
2. Reduce the Jacobi identity and the 2-cocycle identity to identities on basis *triples* by
   bundling them as trilinear maps and applying `LinearMap.ext_basis` followed by `Basis.ext`,
   then substituting the "degree zero" relation and closing with `ring`.
3. Define the Virasoro algebra as the central extension of the Witt algebra by the 2-cocycle
   `γ (ℓ m) (ℓ n) = δ_{m+n,0} · (m³ − m)/12`, with generators `L n` and central element `C`.

No file from `VirasoroProject` is copied into this repository. The differences are deliberate:

- The central-extension and Lie-algebra-cohomology machinery is taken from **Mathlib** (see
  below), not from `VirasoroProject`'s own `LieCohomologySmallDegree.lean` /
  `CentralExtension.lean` / `IsCentralExtension.lean` / `SectionSES.lean`, which predate the
  upstream API and are marked by their author as needing clean-up.
- Our brackets and cochains are defined as antisymmetrisations `A − Aᵀ`, which makes
  `lie_self` / the alternating condition hold by `sub_self` for every element. This removes
  `VirasoroProject`'s `[CharZero 𝕜]` and `[NoZeroSMulDivisors 𝕜 (WittAlgebra 𝕜)]` hypotheses
  on the Witt algebra (ours works over any `CommRing`) and weakens `[Field 𝕜] [CharZero 𝕜]`
  to `[CommRing R] [Algebra ℚ R]` for the Virasoro algebra.
- `VirasoroProject` additionally proves that the Virasoro cocycle is cohomologically nontrivial
  and that `H²(Witt, 𝕜)` is one-dimensional. **We do not** — see the "Status" section of
  `Basic.lean` and `formal/NOTES-virasoro-reuse.md`.

### Scott Carnahan, via Mathlib

The central extension itself is Mathlib's, used as a library:

- `Mathlib/Algebra/Lie/Cochain.lean` — `LieModule.Cohomology.twoCochain`, `d₁₂`, `d₂₃`,
  `twoCocycle`. `Copyright (c) 2025 Scott Carnahan`, Apache-2.0.
- `Mathlib/Algebra/Lie/Extension.lean` — `LieAlgebra.ofTwoCocycle` (with its `LieRing` and
  `LieAlgebra` instances), `LieAlgebra.Extension.ofTwoCocycle`, `LieAlgebra.IsExtension`.
  `Copyright (c) 2024 Scott Carnahan`, Apache-2.0. (Upstreamed as Mathlib PR #20206.)

## License of this directory

Same as the rest of this repository, and compatible with both sources above: Apache-2.0.
The file headers of `Witt.lean` and `Basic.lean` carry the Apache-2.0 notice and point here.
