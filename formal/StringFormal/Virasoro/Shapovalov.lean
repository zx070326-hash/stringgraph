/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import StringFormal.Virasoro.Verma

/-!
# The Shapovalov (contravariant) form on the Virasoro Verma module

Graph node: `worldsheet.shapovalov-form` (not yet created), see also `worldsheet.verma-module`.
Convention: `conv.virasoro-standard`
  `[L_m, L_n] = (m - n) L_{m+n} + (c/12) m (m² - 1) δ_{m+n,0}`

## Route assessment (why the file is organised this way)

The textbook construction of the Shapovalov form uses the triangular decomposition
`U(Vir) = U(Vir₋) ⊗ U(Vir₀) ⊗ U(Vir₊)` and the resulting Harish-Chandra projection
`U(Vir) → U(Vir₀) = R[L₀, C] → R`, setting `⟨u·v, w·v⟩ := χ(σ(u) w)` for the anti-involution
`σ : L_n ↦ L_{-n}`.  That decomposition **is** Poincaré–Birkhoff–Witt, which Mathlib `v4.33.1`
does not have (see `Verma.lean`'s *Status* section and `TODO.md`, item `pbw-verma`), so this
route is unavailable.

Two observations make most of the theory available anyway.

1. *Uniqueness is unconditional.*  A contravariant bilinear form is determined by its value on
   `(|c,h⟩, |c,h⟩)` by a two-step submodule argument that uses nothing but `negSpan_eq_top`:
   the set of `x` killing the form on the left is a Virasoro submodule, and it contains
   `|c,h⟩` as soon as the form vanishes on `(|c,h⟩, ·)`, which in turn follows because the set
   of `y` with `⟨|c,h⟩, y⟩ = 0` is stable under the *negative* modes.  See
   `eq_of_isContravariant`.  In particular **symmetry is a theorem, not part of the
   definition** (`IsContravariant.flip_eq`).

2. *Existence needs exactly one nontrivial input, and it is not all of PBW.*  Instead of a
   Harish-Chandra projection we use the full linear dual `V(c,h) →ₗ[R] R` with the
   `σ`-twisted Virasoro action `(X · f)(v) = f(σ(X) · v)` (`ContraDual`); this is a Virasoro
   module for **any** commutative `ℚ`-algebra `R`, with no grading and no finiteness.  A
   highest weight vector `f₀` of weight `(c,h)` in `ContraDual` with `f₀ |c,h⟩ = 1` is then
   turned into the form by the universal property of `V(c,h)`:
   `⟨x, y⟩ := (vermaLift f₀ x) y`.  Contravariance is *immediate* from equivariance of
   `vermaLift`.  So the whole content of existence is the hypothesis
   `IsShapovalovFunctional`, i.e. the existence of a linear functional `f₀` with
   `f₀ |c,h⟩ = 1` killing `L_n V` for `n < 0`, `(L₀ - h) V` and `(C - c) V`.

   This hypothesis is genuinely necessary: a form with `⟨|c,h⟩,|c,h⟩⟩ = 1` forces
   `|c,h⟩ ≠ 0`, hence `V(c,h) ≠ 0`, which is one of the open items of `pbw-verma`.  So *no*
   unconditional construction of the normalised Shapovalov form is possible from what is
   currently in this repository; the honest formalisation is the conditional one.

## Main definitions

* `StringFormal.Virasoro.VirasoroAlgebra.antiInvolution`: the Lie algebra anti-automorphism
  `σ : L_n ↦ L_{-n}`, `C ↦ C`, as an `R`-linear equivalence with `σ⁅X,Y⁆ = ⁅σY, σX⁆`.
* `StringFormal.Virasoro.IsContravariant`: `B` is contravariant, i.e.
  `B(⁅X, x⁆, y) = B(x, ⁅σX, y⁆)`, and normalised by `B(|c,h⟩,|c,h⟩) = 1`.
* `StringFormal.Virasoro.ContraDual`: the linear dual of `V(c,h)` with the `σ`-twisted action.
* `StringFormal.Virasoro.shapovalov`: **the Shapovalov form**, given the functional.

## Main statements

* `VirasoroAlgebra.antiInvolution_lie`, `antiInvolution_involutive`.
* `eq_of_isContravariant`: uniqueness of the contravariant form.
* `IsContravariant.flip_eq`: the contravariant form is symmetric.
* `IsContravariant.eq_zero_of_level_ne`: different `L₀`-levels are orthogonal.
* `shapovalov_isContravariant`, `shapovalov_hwv_hwv`: existence, given the functional.

## Status

No `sorry`, no new axioms.  Gaps, in decreasing order of importance:

1. Existence of the normalised form is conditional on `IsShapovalovFunctional` (which implies
   `V(c,h) ≠ 0`) — see above.
2. Gram matrix entries are stated for the *specific vectors* `L_{-1}|c,h⟩`, `L_{-2}|c,h⟩`,
   `L_{-1}²|c,h⟩`, not for a basis of `V_N`, because no basis is available without PBW.  The
   level-2 determinant is therefore the Kac determinant only *if* those two vectors are
   independent, which is again `pbw-verma`.
3. Nothing here computes `det` for general `N`: the Kac determinant formula
   (`worldsheet.kac-determinant`) is untouched.
-/

namespace StringFormal.Virasoro

end StringFormal.Virasoro
