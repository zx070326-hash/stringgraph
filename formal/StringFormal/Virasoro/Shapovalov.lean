/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import Mathlib.Tactic.LinearCombination
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
* `StringFormal.Virasoro.IsShapovalovFunctional`: the one open input (see above).
* `StringFormal.Virasoro.shapovalov`: **the Shapovalov form**, given the functional.
* `StringFormal.Virasoro.desc1`, `desc2`, `desc11`: `L₋₁|c,h⟩`, `L₋₂|c,h⟩`, `L₋₁²|c,h⟩`.

## Main statements

* `VirasoroAlgebra.antiInvolution_lie`, `antiInvolution_involutive`.
* `eq_of_isContravariant`: uniqueness of the contravariant form.
* `IsContravariant.flip_eq`: the contravariant form is symmetric.
* `IsContravariant.eq_zero_of_level_ne`: different `L₀`-levels are orthogonal.
* `shapovalov_isContravariant`, `shapovalov_hwv_hwv`, `existsUnique_isContravariant`:
  existence and uniqueness, given the functional.
* `hwv_ne_zero_of_isContravariant`: a normalised form forces `V(c,h) ≠ 0`.
* `IsContravariant.gram_level_one`: `⟨L₋₁|c,h⟩, L₋₁|c,h⟩⟩ = 2h`.
* `IsContravariant.gram_level_two_aa/ab/bb`: `4h + c/2`, `6h`, `8h² + 4h`.
* `IsContravariant.gram_level_two_det`: `2h(16h² + 2h(c-5) + c)`, the `N = 2` Kac
  determinant.

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

/-! ### Contravariant forms: definition, uniqueness, symmetry, level orthogonality -/

section Contravariant

variable (R : Type*) [CommRing R] [Algebra ℚ R] (c h : R)

/-- A submodule of `V(c,h)` containing `|c,h⟩` and stable under the *negative* modes is all of
`V(c,h)`.  (Immediate from `negSpan_eq_top`, but used three times below.) -/
lemma eq_top_of_hwv_mem_of_lie_neg (P : Submodule R (VermaModule R c h))
    (h0 : hwv R c h ∈ P)
    (hstab : ∀ n : ℤ, n < 0 → ∀ x ∈ P, ⁅VirasoroAlgebra.lgen R n, x⁆ ∈ P) : P = ⊤ := by
  rw [eq_top_iff, ← negSpan_eq_top, negSpan_eq_span]
  refine Submodule.span_le.mpr ?_
  rintro x ⟨l, hl, rfl⟩
  induction l with
  | nil => exact h0
  | cons a t ih =>
    rw [wordAct_cons]
    exact hstab a (hl a (by simp)) _ (ih fun n hn => hl n (by simp [hn]))

/-- A bilinear form on `V(c,h)` is **contravariant** when `⟨L_n x, y⟩ = ⟨x, L_{-n} y⟩` for
every `n : ℤ`, i.e. when the adjoint of the action of `X` is the action of
`σ X` (`VirasoroAlgebra.antiInvolution`) on the generators. -/
def IsContravariant (B : VermaModule R c h →ₗ[R] VermaModule R c h →ₗ[R] R) : Prop :=
  ∀ (n : ℤ) (x y : VermaModule R c h),
    B ⁅VirasoroAlgebra.lgen R n, x⁆ y = B x ⁅VirasoroAlgebra.lgen R (-n), y⁆

variable {R c h}

lemma IsContravariant.sub {B B' : VermaModule R c h →ₗ[R] VermaModule R c h →ₗ[R] R}
    (hB : IsContravariant R c h B) (hB' : IsContravariant R c h B') :
    IsContravariant R c h (B - B') := by
  intro n x y
  simp only [LinearMap.sub_apply, hB n x y, hB' n x y]

/-- **Uniqueness of the contravariant form.**  Two contravariant forms that agree at
`(|c,h⟩, |c,h⟩)` are equal.  No hypothesis beyond `negSpan_eq_top` is used; in particular this
does *not* need PBW, a grading, or `V(c,h) ≠ 0`. -/
theorem eq_of_isContravariant {B B' : VermaModule R c h →ₗ[R] VermaModule R c h →ₗ[R] R}
    (hB : IsContravariant R c h B) (hB' : IsContravariant R c h B')
    (h1 : B (hwv R c h) (hwv R c h) = B' (hwv R c h) (hwv R c h)) : B = B' := by
  rw [← sub_eq_zero]
  set D := B - B' with hDdef
  have hD : IsContravariant R c h D := hB.sub hB'
  -- Step 1: `⟨|c,h⟩, ·⟩` vanishes, because it kills every nonempty negative word.
  have step1 : D (hwv R c h) = 0 := by
    refine LinearMap.ker_eq_top.mp (eq_top_of_hwv_mem_of_lie_neg R c h _ ?_ ?_)
    · rw [LinearMap.mem_ker, hDdef, LinearMap.sub_apply, LinearMap.sub_apply, h1, sub_self]
    · intro n hn x _
      rw [LinearMap.mem_ker]
      have key := hD (-n) (hwv R c h) x
      rw [neg_neg, lie_lgen_hwv_of_pos R c h (show (0 : ℤ) < -n by omega), map_zero,
        LinearMap.zero_apply] at key
      exact key.symm
  -- Step 2: the left kernel is a Virasoro submodule containing `|c,h⟩`.
  refine LinearMap.ker_eq_top.mp (eq_top_of_hwv_mem_of_lie_neg R c h _
    (LinearMap.mem_ker.mpr step1) ?_)
  intro n _ x hx
  rw [LinearMap.mem_ker] at hx ⊢
  exact LinearMap.ext fun y => by rw [hD n x y, hx, LinearMap.zero_apply, LinearMap.zero_apply]

/-- The flip of a contravariant form is contravariant. -/
lemma IsContravariant.flip {B : VermaModule R c h →ₗ[R] VermaModule R c h →ₗ[R] R}
    (hB : IsContravariant R c h B) : IsContravariant R c h B.flip := by
  intro n x y
  simp only [LinearMap.flip_apply]
  rw [hB (-n) y x, neg_neg]

/-- **A contravariant form is automatically symmetric.**  Symmetry is a consequence of
contravariance and the normalisation, not an extra axiom. -/
theorem IsContravariant.flip_eq {B : VermaModule R c h →ₗ[R] VermaModule R c h →ₗ[R] R}
    (hB : IsContravariant R c h B) : B.flip = B :=
  eq_of_isContravariant hB.flip hB rfl

theorem IsContravariant.comm {B : VermaModule R c h →ₗ[R] VermaModule R c h →ₗ[R] R}
    (hB : IsContravariant R c h B) (x y : VermaModule R c h) : B x y = B y x :=
  LinearMap.congr_fun₂ hB.flip_eq y x

/-- A nonzero integer is a unit in a `ℚ`-algebra. -/
lemma isUnit_intCast (R : Type*) [CommRing R] [Algebra ℚ R] {k : ℤ} (hk : k ≠ 0) :
    IsUnit ((k : R)) := by
  have h1 : IsUnit ((k : ℚ)) := isUnit_iff_ne_zero.mpr (Int.cast_ne_zero.mpr hk)
  simpa using h1.map (algebraMap ℚ R)

/-- **Different `L₀`-levels are orthogonal for any contravariant form.**  One line from
contravariance at `n = 0`. -/
theorem IsContravariant.eq_zero_of_level_ne
    {B : VermaModule R c h →ₗ[R] VermaModule R c h →ₗ[R] R} (hB : IsContravariant R c h B)
    {M N : ℕ} (hMN : M ≠ N) {x y : VermaModule R c h}
    (hx : x ∈ levelSpan R c h M) (hy : y ∈ levelSpan R c h N) : B x y = 0 := by
  have key := hB 0 x y
  rw [neg_zero, lie_lgen_zero_of_mem_levelSpan R c h M hx,
    lie_lgen_zero_of_mem_levelSpan R c h N hy, map_smul, LinearMap.smul_apply,
    LinearMap.map_smul, smul_eq_mul, smul_eq_mul] at key
  have hz : (((M : ℤ) - (N : ℤ) : ℤ) : R) * B x y = 0 := by
    push_cast
    have hsplit : ((M : R) - (N : R)) * B x y
        = (h + (M : R)) * B x y - (h + (N : R)) * B x y := by ring
    rw [hsplit, key, sub_self]
  have hne : ((M : ℤ) - (N : ℤ)) ≠ 0 := sub_ne_zero.mpr (by exact_mod_cast hMN)
  obtain ⟨u, hu⟩ := isUnit_intCast R hne
  calc B x y = (↑u⁻¹ : R) * (↑u * B x y) := by rw [← mul_assoc, Units.inv_mul, one_mul]
    _ = 0 := by rw [hu, hz, mul_zero]

end Contravariant

/-! ### The `σ`-twisted dual and the construction of the form -/

section Existence

variable (R : Type*) [CommRing R] [Algebra ℚ R] (c h : R)

/-- The central element acts by the scalar `c` on all of `V(c,h)`. -/
lemma lie_cgen_eq (x : VermaModule R c h) : ⁅VirasoroAlgebra.cgen R, x⁆ = c • x :=
  lie_cgen_of_mem_negSpan R c h (by rw [negSpan_eq_top]; trivial)

/-- The linear dual `V(c,h) →ₗ[R] R` with the **`σ`-twisted** Virasoro action
`(X · f)(v) = f(σ(X) · v)`.  This is a type synonym because Mathlib's
`Module.Dual.instLieRingModule` already puts the untwisted coadjoint action
`(X · f)(v) = -f(X · v)` on `V(c,h) →ₗ[R] R`. -/
def ContraDual : Type _ := VermaModule R c h →ₗ[R] R

namespace ContraDual

/-- An element of `ContraDual R c h` read as a linear functional. -/
def toLin (f : ContraDual R c h) : VermaModule R c h →ₗ[R] R := f

/-- A linear functional read as an element of `ContraDual R c h`. -/
def ofLin (f : VermaModule R c h →ₗ[R] R) : ContraDual R c h := f

@[simp] lemma toLin_ofLin (f : VermaModule R c h →ₗ[R] R) : toLin R c h (ofLin R c h f) = f := rfl

noncomputable instance : AddCommGroup (ContraDual R c h) :=
  inferInstanceAs (AddCommGroup (VermaModule R c h →ₗ[R] R))

noncomputable instance : Module R (ContraDual R c h) :=
  inferInstanceAs (Module R (VermaModule R c h →ₗ[R] R))

@[ext] lemma ext {f g : ContraDual R c h} (hfg : ∀ v, toLin R c h f v = toLin R c h g v) :
    f = g := LinearMap.ext hfg

@[simp] lemma toLin_add (f g : ContraDual R c h) :
    toLin R c h (f + g) = toLin R c h f + toLin R c h g := rfl

@[simp] lemma toLin_smul (t : R) (f : ContraDual R c h) :
    toLin R c h (t • f) = t • toLin R c h f := rfl

/-- `ContraDual` as a linear map to the honest dual; used to turn the lift into a form. -/
def toLinₗ : ContraDual R c h →ₗ[R] (VermaModule R c h →ₗ[R] R) where
  toFun := toLin R c h
  map_add' _ _ := rfl
  map_smul' _ _ := rfl

@[simp] lemma toLinₗ_apply (f : ContraDual R c h) : toLinₗ R c h f = toLin R c h f := rfl

noncomputable instance instLieRingModule :
    LieRingModule (VirasoroAlgebra R) (ContraDual R c h) where
  bracket X f := ofLin R c h
    { toFun := fun v => toLin R c h f ⁅VirasoroAlgebra.antiInvolution R X, v⁆
      map_add' := fun v w => by rw [lie_add, map_add]
      map_smul' := fun t v => by rw [lie_smul, LinearMap.map_smul, RingHom.id_apply] }
  add_lie X Y f := by
    refine ext R c h fun v => ?_
    show toLin R c h f ⁅VirasoroAlgebra.antiInvolution R (X + Y), v⁆ = _
    rw [map_add, add_lie, map_add]
    rfl
  lie_add X f g := by
    refine ext R c h fun v => ?_
    show toLin R c h (f + g) _ = _
    rw [toLin_add]
    rfl
  leibniz_lie X Y f := by
    refine ext R c h fun v => ?_
    show toLin R c h f ⁅VirasoroAlgebra.antiInvolution R Y,
      ⁅VirasoroAlgebra.antiInvolution R X, v⁆⁆ = _
    show _ = toLin R c h f ⁅VirasoroAlgebra.antiInvolution R ⁅X, Y⁆, v⁆
      + toLin R c h f ⁅VirasoroAlgebra.antiInvolution R X,
          ⁅VirasoroAlgebra.antiInvolution R Y, v⁆⁆
    rw [VirasoroAlgebra.antiInvolution_lie, lie_lie, map_sub]
    abel

lemma lie_apply (X : VirasoroAlgebra R) (f : ContraDual R c h) (v : VermaModule R c h) :
    toLin R c h ⁅X, f⁆ v = toLin R c h f ⁅VirasoroAlgebra.antiInvolution R X, v⁆ := rfl

noncomputable instance instLieModule : LieModule R (VirasoroAlgebra R) (ContraDual R c h) where
  smul_lie t X f := by
    refine ext R c h fun v => ?_
    rw [lie_apply, map_smul, smul_lie, LinearMap.map_smul, toLin_smul, LinearMap.smul_apply,
      lie_apply]
  lie_smul t X f := by
    refine ext R c h fun v => ?_
    simp only [lie_apply, toLin_smul, LinearMap.smul_apply]

end ContraDual

/-- The only unproved input to the construction of the Shapovalov form: a linear functional
picking out the `|c,h⟩`-coefficient.  Equivalently, a highest weight vector of weight `(c,h)`
in `ContraDual R c h` normalised at `|c,h⟩`.  Existence implies `|c,h⟩ ≠ 0`, hence
`V(c,h) ≠ 0`, which is open in this repository (`TODO.md`, `pbw-verma`). -/
structure IsShapovalovFunctional (f : VermaModule R c h →ₗ[R] R) : Prop where
  apply_hwv : f (hwv R c h) = 1
  apply_lie_neg : ∀ n : ℤ, n < 0 → ∀ v : VermaModule R c h,
    f ⁅VirasoroAlgebra.lgen R n, v⁆ = 0
  apply_lie_zero : ∀ v : VermaModule R c h,
    f ⁅VirasoroAlgebra.lgen R 0, v⁆ = h * f v

variable {R c h}

/-- A Shapovalov functional is exactly a highest weight vector in the `σ`-twisted dual. -/
lemma IsShapovalovFunctional.isHighestWeightVector {f : VermaModule R c h →ₗ[R] R}
    (hf : IsShapovalovFunctional R c h f) :
    IsHighestWeightVector R c h (ContraDual R c h) (ContraDual.ofLin R c h f) where
  lie_cgen := by
    refine ContraDual.ext R c h fun v => ?_
    rw [ContraDual.lie_apply, ContraDual.toLin_smul, LinearMap.smul_apply,
      VirasoroAlgebra.antiInvolution_cgen, ContraDual.toLin_ofLin, lie_cgen_eq, map_smul]
  lie_lgen_zero := by
    refine ContraDual.ext R c h fun v => ?_
    rw [ContraDual.lie_apply, ContraDual.toLin_smul, LinearMap.smul_apply,
      VirasoroAlgebra.antiInvolution_lgen, neg_zero, ContraDual.toLin_ofLin,
      hf.apply_lie_zero, smul_eq_mul]
  lie_lgen_pos n hn := by
    refine ContraDual.ext R c h fun v => ?_
    rw [ContraDual.lie_apply, VirasoroAlgebra.antiInvolution_lgen, ContraDual.toLin_ofLin,
      hf.apply_lie_neg (-n) (by omega)]
    rfl

/-- **The Shapovalov form** on `V(c,h)`, built from a Shapovalov functional by the universal
property of the Verma module: `⟨x, y⟩ = (vermaLift f₀ x) y`. -/
noncomputable def shapovalov {f : VermaModule R c h →ₗ[R] R}
    (hf : IsShapovalovFunctional R c h f) :
    VermaModule R c h →ₗ[R] VermaModule R c h →ₗ[R] R :=
  (ContraDual.toLinₗ R c h).comp
    (vermaLift R c h (ContraDual R c h) hf.isHighestWeightVector)

lemma shapovalov_apply {f : VermaModule R c h →ₗ[R] R} (hf : IsShapovalovFunctional R c h f)
    (x y : VermaModule R c h) :
    shapovalov hf x y =
      ContraDual.toLin R c h
        (vermaLift R c h (ContraDual R c h) hf.isHighestWeightVector x) y := rfl

/-- Normalisation: `⟨|c,h⟩, |c,h⟩⟩ = 1`. -/
@[simp] theorem shapovalov_hwv_hwv {f : VermaModule R c h →ₗ[R] R}
    (hf : IsShapovalovFunctional R c h f) :
    shapovalov hf (hwv R c h) (hwv R c h) = 1 := by
  rw [shapovalov_apply, vermaLift_hwv, ContraDual.toLin_ofLin, hf.apply_hwv]

/-- **Contravariance**: `⟨L_n x, y⟩ = ⟨x, L_{-n} y⟩`.  Immediate from equivariance of
`vermaLift`. -/
theorem shapovalov_isContravariant {f : VermaModule R c h →ₗ[R] R}
    (hf : IsShapovalovFunctional R c h f) : IsContravariant R c h (shapovalov hf) := by
  intro n x y
  rw [shapovalov_apply, shapovalov_apply, vermaLift_lie, ContraDual.lie_apply,
    VirasoroAlgebra.antiInvolution_lgen]

/-- **Existence and uniqueness of the Shapovalov form**, given a Shapovalov functional. -/
theorem existsUnique_isContravariant {f : VermaModule R c h →ₗ[R] R}
    (hf : IsShapovalovFunctional R c h f) :
    ∃! B : VermaModule R c h →ₗ[R] VermaModule R c h →ₗ[R] R,
      IsContravariant R c h B ∧ B (hwv R c h) (hwv R c h) = 1 :=
  ⟨shapovalov hf, ⟨shapovalov_isContravariant hf, shapovalov_hwv_hwv hf⟩,
    fun _ hB => eq_of_isContravariant hB.1 (shapovalov_isContravariant hf)
      (by rw [hB.2, shapovalov_hwv_hwv hf])⟩

/-- Existence of a normalised contravariant form forces `V(c,h) ≠ 0`, which is why the
construction cannot be made unconditional here. -/
theorem hwv_ne_zero_of_isContravariant [Nontrivial R]
    {B : VermaModule R c h →ₗ[R] VermaModule R c h →ₗ[R] R}
    (hB1 : B (hwv R c h) (hwv R c h) = 1) : hwv R c h ≠ 0 := by
  intro h0
  rw [h0, map_zero] at hB1
  exact zero_ne_one hB1

end Existence

/-! ### Low-level Gram matrices -/

section Levels

variable (R : Type*) [CommRing R] [Algebra ℚ R] (c h : R)

/-- The level-1 descendant `L_{-1}|c,h⟩`. -/
noncomputable def desc1 : VermaModule R c h := ⁅VirasoroAlgebra.lgen R (-1), hwv R c h⁆

/-- The level-2 descendant `L_{-2}|c,h⟩`. -/
noncomputable def desc2 : VermaModule R c h := ⁅VirasoroAlgebra.lgen R (-2), hwv R c h⁆

/-- The level-2 descendant `L_{-1}²|c,h⟩`. -/
noncomputable def desc11 : VermaModule R c h := ⁅VirasoroAlgebra.lgen R (-1), desc1 R c h⁆

lemma lie_lgen_one_neg_one : ⁅VirasoroAlgebra.lgen R 1, VirasoroAlgebra.lgen R (-1)⁆
    = (2 : R) • VirasoroAlgebra.lgen R 0 := by
  rw [VirasoroAlgebra.lie_lgen_lgen]
  norm_num [centralTerm]

lemma lie_lgen_zero_neg_one : ⁅VirasoroAlgebra.lgen R 0, VirasoroAlgebra.lgen R (-1)⁆
    = (1 : R) • VirasoroAlgebra.lgen R (-1) := by
  rw [VirasoroAlgebra.lie_lgen_lgen]
  norm_num

lemma lie_lgen_two_neg_two : ⁅VirasoroAlgebra.lgen R 2, VirasoroAlgebra.lgen R (-2)⁆
    = (4 : R) • VirasoroAlgebra.lgen R 0 + centralTerm R 2 • VirasoroAlgebra.cgen R := by
  rw [VirasoroAlgebra.lie_lgen_lgen]
  norm_num

lemma lie_lgen_two_neg_one : ⁅VirasoroAlgebra.lgen R 2, VirasoroAlgebra.lgen R (-1)⁆
    = (3 : R) • VirasoroAlgebra.lgen R 1 := by
  rw [VirasoroAlgebra.lie_lgen_lgen]
  norm_num

/-- `L₁ L₋₁ |c,h⟩ = 2h |c,h⟩`. -/
lemma lie_lgen_one_desc1 :
    ⁅VirasoroAlgebra.lgen R 1, desc1 R c h⁆ = (2 * h) • hwv R c h := by
  rw [desc1, leibniz_lie, lie_lgen_hwv_of_pos R c h one_pos, lie_zero, add_zero,
    lie_lgen_one_neg_one, smul_lie, lie_lgen_zero_hwv, smul_smul]

/-- `L₀ L₋₁ |c,h⟩ = (h+1) L₋₁ |c,h⟩`. -/
lemma lie_lgen_zero_desc1 :
    ⁅VirasoroAlgebra.lgen R 0, desc1 R c h⁆ = (h + 1) • desc1 R c h := by
  rw [desc1, leibniz_lie, lie_lgen_zero_hwv, lie_lgen_zero_neg_one, one_smul, lie_smul,
    add_comm, add_smul, one_smul]

/-- `L₂ L₋₁ |c,h⟩ = 0`. -/
lemma lie_lgen_two_desc1 : ⁅VirasoroAlgebra.lgen R 2, desc1 R c h⁆ = 0 := by
  rw [desc1, leibniz_lie, lie_lgen_hwv_of_pos R c h (by norm_num : (0:ℤ) < 2), lie_zero,
    add_zero, lie_lgen_two_neg_one, smul_lie,
    lie_lgen_hwv_of_pos R c h one_pos, smul_zero]

/-- `L₂ L₋₂ |c,h⟩ = (4h + c/2) |c,h⟩`. -/
lemma lie_lgen_two_desc2 : ⁅VirasoroAlgebra.lgen R 2, desc2 R c h⁆
    = (4 * h + centralTerm R 2 * c) • hwv R c h := by
  rw [desc2, leibniz_lie, lie_lgen_hwv_of_pos R c h (by norm_num : (0:ℤ) < 2), lie_zero,
    add_zero, lie_lgen_two_neg_two, add_lie, smul_lie, smul_lie, lie_lgen_zero_hwv,
    lie_cgen_hwv, smul_smul, smul_smul, ← add_smul]

/-- `L₂ L₋₁² |c,h⟩ = 6h |c,h⟩`. -/
lemma lie_lgen_two_desc11 : ⁅VirasoroAlgebra.lgen R 2, desc11 R c h⁆
    = (6 * h) • hwv R c h := by
  rw [desc11, leibniz_lie, lie_lgen_two_desc1, lie_zero, add_zero, lie_lgen_two_neg_one,
    smul_lie, lie_lgen_one_desc1, smul_smul]
  congr 1
  ring

/-- `L₁ L₋₁² |c,h⟩ = (4h + 2) L₋₁ |c,h⟩`. -/
lemma lie_lgen_one_desc11 : ⁅VirasoroAlgebra.lgen R 1, desc11 R c h⁆
    = (4 * h + 2) • desc1 R c h := by
  rw [desc11, leibniz_lie, lie_lgen_one_desc1, lie_lgen_one_neg_one, smul_lie,
    lie_lgen_zero_desc1, lie_smul, ← desc1, smul_smul, ← add_smul]
  congr 1
  ring

/-- `2 · (c/2) = 1`: the level-2 central coefficient. -/
lemma two_mul_centralTerm_two : (2 : R) * centralTerm R 2 = 1 := by
  have h6 : (((2 : ℤ) ^ 3 - 2 : ℤ) : R) = 6 := by norm_num
  rw [centralTerm, h6, show (2 : R) * (inv12 R * 6) = 12 * inv12 R by ring, twelve_mul_inv12]

lemma desc1_mem_levelSpan : desc1 R c h ∈ levelSpan R c h 1 := by
  refine Submodule.subset_span ⟨Composition.single 1 one_pos, ?_⟩
  rw [levelWord, Composition.single_blocks]
  rfl

lemma desc2_mem_levelSpan : desc2 R c h ∈ levelSpan R c h 2 := by
  refine Submodule.subset_span ⟨Composition.single 2 two_pos, ?_⟩
  rw [levelWord, Composition.single_blocks]
  rfl

lemma desc11_mem_levelSpan : desc11 R c h ∈ levelSpan R c h 2 := by
  refine Submodule.subset_span ⟨Composition.ones 2, ?_⟩
  rw [levelWord, Composition.ones_blocks]
  rfl

variable {R c h}
variable {B : VermaModule R c h →ₗ[R] VermaModule R c h →ₗ[R] R}

/-- **The level-1 Shapovalov element**: `⟨L₋₁|c,h⟩, L₋₁|c,h⟩⟩ = 2h`.  Vanishing at `h = 0`
is the level-1 null vector of the vacuum module. -/
theorem IsContravariant.gram_level_one (hB : IsContravariant R c h B)
    (hB1 : B (hwv R c h) (hwv R c h) = 1) :
    B (desc1 R c h) (desc1 R c h) = 2 * h := by
  have key := hB (-1) (hwv R c h) (desc1 R c h)
  rw [← desc1] at key
  rw [key, neg_neg, lie_lgen_one_desc1, LinearMap.map_smul, smul_eq_mul, hB1, mul_one]

theorem IsContravariant.gram_level_two_aa (hB : IsContravariant R c h B)
    (hB1 : B (hwv R c h) (hwv R c h) = 1) :
    B (desc2 R c h) (desc2 R c h) = 4 * h + centralTerm R 2 * c := by
  have key := hB (-2) (hwv R c h) (desc2 R c h)
  rw [← desc2] at key
  rw [key, neg_neg, lie_lgen_two_desc2, LinearMap.map_smul, smul_eq_mul, hB1, mul_one]

theorem IsContravariant.gram_level_two_ab (hB : IsContravariant R c h B)
    (hB1 : B (hwv R c h) (hwv R c h) = 1) :
    B (desc2 R c h) (desc11 R c h) = 6 * h := by
  have key := hB (-2) (hwv R c h) (desc11 R c h)
  rw [← desc2] at key
  rw [key, neg_neg, lie_lgen_two_desc11, LinearMap.map_smul, smul_eq_mul, hB1, mul_one]

theorem IsContravariant.gram_level_two_bb (hB : IsContravariant R c h B)
    (hB1 : B (hwv R c h) (hwv R c h) = 1) :
    B (desc11 R c h) (desc11 R c h) = 8 * h ^ 2 + 4 * h := by
  have key := hB (-1) (desc1 R c h) (desc11 R c h)
  rw [← desc11] at key
  rw [key, neg_neg, lie_lgen_one_desc11, LinearMap.map_smul, smul_eq_mul,
    hB.gram_level_one hB1]
  ring

/-- **The level-2 Kac determinant** `det = 2h(16h² + 2h(c-5) + c)` for the Gram matrix of
`L₋₂|c,h⟩` and `L₋₁²|c,h⟩`.  These two vectors span `V₂` (`levelSpan`), but their linear
independence — hence the identification of this determinant with the level-2 Kac determinant
proper — is exactly what PBW would supply and is not available here. -/
theorem IsContravariant.gram_level_two_det (hB : IsContravariant R c h B)
    (hB1 : B (hwv R c h) (hwv R c h) = 1) :
    B (desc2 R c h) (desc2 R c h) * B (desc11 R c h) (desc11 R c h)
        - B (desc2 R c h) (desc11 R c h) * B (desc11 R c h) (desc2 R c h)
      = 2 * h * (16 * h ^ 2 + 2 * h * (c - 5) + c) := by
  rw [hB.gram_level_two_aa hB1, hB.gram_level_two_bb hB1, hB.gram_level_two_ab hB1,
    hB.comm (desc11 R c h) (desc2 R c h), hB.gram_level_two_ab hB1]
  linear_combination (4 * c * h ^ 2 + 2 * c * h) * two_mul_centralTerm_two R

/-- Levels 1 and 2 are orthogonal, an instance of `IsContravariant.eq_zero_of_level_ne`. -/
theorem IsContravariant.gram_level_one_two (hB : IsContravariant R c h B) :
    B (desc1 R c h) (desc2 R c h) = 0 :=
  hB.eq_zero_of_level_ne (by norm_num) (desc1_mem_levelSpan R c h) (desc2_mem_levelSpan R c h)

end Levels

end StringFormal.Virasoro
