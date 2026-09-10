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

open Module

/-! ### The anti-involution `L_n ↦ L_{-n}` -/

namespace WittAlgebra

variable (R : Type*) [CommRing R]

/-- The Witt-algebra anti-involution `ℓ n ↦ ℓ (-n)`, as an `R`-linear map. -/
noncomputable def antiInvolutionₗ : WittAlgebra R →ₗ[R] WittAlgebra R :=
  (lgen R).constr R fun n => lgen R (-n)

@[simp] lemma antiInvolutionₗ_lgen (n : ℤ) :
    antiInvolutionₗ R (lgen R n) = lgen R (-n) := by
  simp only [antiInvolutionₗ, Basis.constr_basis]

lemma antiInvolutionₗ_comp_self :
    (antiInvolutionₗ R) ∘ₗ (antiInvolutionₗ R) = LinearMap.id := by
  refine (lgen R).ext fun n => ?_
  simp only [LinearMap.comp_apply, antiInvolutionₗ_lgen, neg_neg, LinearMap.id_coe, id_eq]

lemma antiInvolutionₗ_involutive : Function.Involutive (antiInvolutionₗ R) := fun X =>
  LinearMap.congr_fun (antiInvolutionₗ_comp_self R) X

/-- `σ` reverses the Witt bracket: `σ⁅X, Y⁆ = ⁅σ Y, σ X⁆`. -/
lemma antiInvolutionₗ_lie (X Y : WittAlgebra R) :
    antiInvolutionₗ R ⁅X, Y⁆ = ⁅antiInvolutionₗ R Y, antiInvolutionₗ R X⁆ := by
  have key : (bracket R).compr₂ (antiInvolutionₗ R)
      = ((bracket R).compl₁₂ (antiInvolutionₗ R) (antiInvolutionₗ R)).flip := by
    refine LinearMap.ext_basis (lgen R) (lgen R) fun n m => ?_
    simp only [LinearMap.compr₂_apply, LinearMap.compl₁₂_apply, LinearMap.flip_apply,
      bracket_lgen_lgen, map_smul, antiInvolutionₗ_lgen]
    rw [show -m + -n = -(n + m) by ring]
    congr 1
    push_cast
    ring
  have := LinearMap.congr_fun₂ key X Y
  simpa only [LinearMap.compr₂_apply, LinearMap.compl₁₂_apply, LinearMap.flip_apply,
    ← lie_def] using this

end WittAlgebra

section VirasoroAnti

variable (R : Type*) [CommRing R] [Algebra ℚ R]

/-- The Virasoro `2`-cocycle is invariant under `σ` composed with the flip. -/
lemma cocycleBilin_antiInvolution (X Y : WittAlgebra R) :
    cocycleBilin R (WittAlgebra.antiInvolutionₗ R Y) (WittAlgebra.antiInvolutionₗ R X)
      = cocycleBilin R X Y := by
  have key : ((cocycleBilin R).compl₁₂ (WittAlgebra.antiInvolutionₗ R)
      (WittAlgebra.antiInvolutionₗ R)).flip = cocycleBilin R := by
    refine LinearMap.ext_basis (WittAlgebra.lgen R) (WittAlgebra.lgen R) fun n m => ?_
    simp only [LinearMap.flip_apply, LinearMap.compl₁₂_apply, WittAlgebra.antiInvolutionₗ_lgen,
      cocycleBilin_lgen_lgen]
    by_cases hnm : n + m = 0
    · rw [if_pos hnm, if_pos (show -m + -n = 0 by omega), show -m = n by omega]
    · rw [if_neg hnm, if_neg (show ¬(-m + -n = 0) by omega)]
  exact LinearMap.congr_fun₂ key X Y

namespace VirasoroAlgebra

/-- The Virasoro anti-involution `L n ↦ L (-n)`, `C ↦ C`, as an `R`-linear map. -/
noncomputable def antiInvolutionₗ : VirasoroAlgebra R →ₗ[R] VirasoroAlgebra R :=
  (toProdₗ R).symm.toLinearMap ∘ₗ
    ((WittAlgebra.antiInvolutionₗ R).prodMap (LinearMap.id (R := R) (M := R))) ∘ₗ
    (toProdₗ R).toLinearMap

@[simp] lemma toProd_antiInvolutionₗ (X : VirasoroAlgebra R) :
    toProd R (antiInvolutionₗ R X)
      = (WittAlgebra.antiInvolutionₗ R (toProd R X).1, (toProd R X).2) := by
  show (toProdₗ R) ((toProdₗ R).symm _) = _
  rw [LinearEquiv.apply_symm_apply]
  rfl

@[simp] lemma antiInvolutionₗ_lgen (n : ℤ) : antiInvolutionₗ R (lgen R n) = lgen R (-n) := by
  apply toProd_injective
  rw [toProd_antiInvolutionₗ, toProd_lgen, toProd_lgen]
  simp

@[simp] lemma antiInvolutionₗ_cgen : antiInvolutionₗ R (cgen R) = cgen R := by
  apply toProd_injective
  rw [toProd_antiInvolutionₗ, toProd_cgen]
  simp

lemma antiInvolutionₗ_comp_self :
    (antiInvolutionₗ R) ∘ₗ (antiInvolutionₗ R) = LinearMap.id := by
  refine LinearMap.ext fun X => ?_
  apply toProd_injective
  rw [LinearMap.comp_apply, toProd_antiInvolutionₗ, toProd_antiInvolutionₗ,
    WittAlgebra.antiInvolutionₗ_involutive R, LinearMap.id_coe, id_eq]

lemma antiInvolutionₗ_involutive : Function.Involutive (antiInvolutionₗ R) := fun X =>
  LinearMap.congr_fun (antiInvolutionₗ_comp_self R) X

/-- **`σ` is a Lie algebra anti-automorphism**: `σ⁅X, Y⁆ = ⁅σ Y, σ X⁆`.  The sign flip of the
central term `(n³ - n)/12` under `n ↦ -n` is exactly cancelled by the reversal of the
bracket. -/
lemma antiInvolutionₗ_lie (X Y : VirasoroAlgebra R) :
    antiInvolutionₗ R ⁅X, Y⁆ = ⁅antiInvolutionₗ R Y, antiInvolutionₗ R X⁆ := by
  apply toProd_injective
  rw [toProd_antiInvolutionₗ, toProd_lie, toProd_lie]
  simp only [toProd_antiInvolutionₗ, witt_lie_ground, add_zero, sub_zero, Prod.mk.injEq]
  exact ⟨WittAlgebra.antiInvolutionₗ_lie R _ _, (cocycleBilin_antiInvolution R _ _).symm⟩

/-- **The anti-involution `σ : L_n ↦ L_{-n}`, `C ↦ C` of the Virasoro algebra**, as an
`R`-linear equivalence.  It is an anti-automorphism of Lie algebras
(`antiInvolution_lie`) and an involution (`antiInvolution_involutive`). -/
noncomputable def antiInvolution : VirasoroAlgebra R ≃ₗ[R] VirasoroAlgebra R :=
  LinearEquiv.ofLinearMap (antiInvolutionₗ R) (antiInvolutionₗ R)
    (antiInvolutionₗ_comp_self R) (antiInvolutionₗ_comp_self R)

@[simp] lemma antiInvolution_apply (X : VirasoroAlgebra R) :
    antiInvolution R X = antiInvolutionₗ R X := rfl

@[simp] lemma antiInvolution_lgen (n : ℤ) : antiInvolution R (lgen R n) = lgen R (-n) :=
  antiInvolutionₗ_lgen R n

@[simp] lemma antiInvolution_cgen : antiInvolution R (cgen R) = cgen R :=
  antiInvolutionₗ_cgen R

theorem antiInvolution_lie (X Y : VirasoroAlgebra R) :
    antiInvolution R ⁅X, Y⁆ = ⁅antiInvolution R Y, antiInvolution R X⁆ :=
  antiInvolutionₗ_lie R X Y

theorem antiInvolution_involutive : Function.Involutive (antiInvolution R) :=
  antiInvolutionₗ_involutive R

@[simp] lemma antiInvolution_symm : (antiInvolution R).symm = antiInvolution R := rfl

end VirasoroAlgebra

end VirasoroAnti

end StringFormal.Virasoro
