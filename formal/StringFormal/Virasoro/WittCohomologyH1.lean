/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import StringFormal.Virasoro.WittPerfect
import Mathlib.Algebra.Lie.Cochain
import Mathlib.LinearAlgebra.Dual.Lemmas

/-!
# `H¹(W, k) = 0` for the Witt algebra, with trivial coefficients

Graph node: `math.witt-algebra-perfect`, part **(2)** and the dictionary **(1) ⟺ (2)**.
Part (1) (perfectness, `⁅W, W⁆ = W`) is already in `StringFormal/Virasoro/WittPerfect.lean`
and is *reused* here, not reproved.
Convention: `conv.virasoro-standard` (as in `StringFormal/Virasoro/Basic.lean`).

## What the card says (and what we formalise)

The card fixes the definition of `H¹` verbatim:

> 1-上循环就是满足 `f([x, y]) = 0` 的线性泛函 `f : 𝓛 → k`，而 1-上边缘只有 `0`，故
> `H¹(𝓛, k) = (𝓛 / [𝓛, 𝓛])^*`；域上一个向量空间的对偶为零当且仅当该空间为零，于是
> `H¹(𝓛, k) = 0 ⟺ 𝓛 = [𝓛, 𝓛]`.

Accordingly:

* `oneCocyclesTrivial R L` is *literally* `{f : L →ₗ[R] R | ∀ x y, f ⁅x, y⁆ = 0}`;
* `oneCoboundariesTrivial R L` is the range of the degree-0 differential, which with trivial
  coefficients is the zero map, so it equals `⊥`;
* `H1Trivial R L` is the quotient `Z¹ / B¹`.

Because "define `B¹` to be `0`" would be circular on its own, the two definitions are
**checked against Mathlib's Chevalley–Eilenberg complex** (`Mathlib/Algebra/Lie/Cochain.lean`,
which supplies `oneCochain`, `twoCochain` and `d₁₂` but, as of `v4.33.1`, *no* degree-0
differential, no coboundaries and no cohomology — see its own `TODO`):

* `d₀₁` (new here) is the Chevalley–Eilenberg differential `C⁰ = M → C¹`, `(d⁰ m)(x) = ⁅x, m⁆`,
  for an arbitrary Lie module `M`, together with `d₁₂_comp_d₀₁ : d₁₂ ∘ₗ d₀₁ = 0`;
* `d₀₁_eq_zero_of_isTrivial`: for a trivial module the degree-0 differential is `0`
  (this is the card's "1-上边缘只有 0", as a theorem);
* `mem_ker_d₁₂_iff_of_isTrivial`: for a trivial module, `ker d₁₂` is exactly
  `{f | ∀ x y, f ⁅x, y⁆ = 0}` (this is the card's description of `Z¹`, as a theorem).

Instantiating at `M = TrivialLieModule R L R` (Mathlib's type synonym carrying the zero action)
gives `d₀₁_trivialLieModule_eq_zero` and `mem_ker_d₁₂_trivialLieModule_iff`, i.e. the two
card-level definitions used below coincide with genuine Chevalley–Eilenberg data.

## Main statements

General Lie algebras (`namespace StringFormal.LieCohomology`):

* `oneCocyclesTrivial_eq_dualAnnihilator`: `Z¹(𝓛, k) = ann([𝓛, 𝓛])`.
* `h1TrivialEquivDualQuot`: `H¹(𝓛, k) ≃ₗ (𝓛 / [𝓛, 𝓛])^*` — the card's dictionary, first half.
* `oneCocyclesTrivial_eq_bot_of_derivedSeries_eq_top`: `(1) ⟹ (2)` over **any** commutative ring.
* `oneCocyclesTrivial_eq_bot_iff`, `subsingleton_H1Trivial_iff_derivedSeries_eq_top`:
  `H¹(𝓛, k) = 0 ⟺ 𝓛 = [𝓛, 𝓛]` over a **field** — the card's dictionary, second half.

Witt algebra (`namespace StringFormal.Virasoro.WittAlgebra`):

* `oneCocyclesTrivial_eq_bot` and `subsingleton_H1Trivial`: **`H¹(W(k), k) = 0`** whenever `2`
  is invertible in the ground ring (in particular for every field of characteristic `≠ 2`,
  so in particular for the card's characteristic-zero field).
* `oneCocyclesTrivial_eq_bot_of_two_regular`: the *sharper* hypothesis actually needed —
  `2` only has to be a non-zero-divisor.
* `oneCocyclesTrivial_eq_bot_iff_of_field`, `subsingleton_H1Trivial_iff_of_field`:
  over a field, `H¹(W, k) = 0 ⟺ 2 ∈ k^×`, matching `WittPerfect.derivedSeries_one_eq_top_iff`.

## Mathematical findings (suggested for the graph card's `notes` / `gaps`)

1. **`H¹(W, R) = 0` needs strictly less than perfectness.** Perfectness of `W(R)` holds iff
   `2 ∈ R^×` (`WittPerfect.derivedSeries_one_eq_top_iff`), but the vanishing of `Z¹` only needs
   `2` to be a *non-zero-divisor*: `2 · f(ℓ n) = f(2 ℓ n) = 0` already forces `f(ℓ n) = 0`.
2. **The card's dictionary "(1) ⟺ (2)" is genuinely field-specific; it fails over `ℤ`.**
   `witt_int_h1_vanishes_but_not_perfect` records the machine-checked counterexample:
   `Z¹(W(ℤ), ℤ) = 0` while `⁅W(ℤ), W(ℤ)⁆ ≠ W(ℤ)`. (Reason: `W(ℤ)/⁅W(ℤ), W(ℤ)⁆` is
   `2`-torsion, and `Hom(ℤ/2, ℤ) = 0`; the card's step "域上一个向量空间的对偶为零当且仅当
   该空间为零" is exactly what breaks.) This does not affect the card, whose ground field has
   characteristic `0`, but the parenthetical claim that the dictionary holds "对任意李代数 𝓛
   与平凡模 k" must be read with `k` a **field**.
3. **Characteristic two really is excluded on both sides.**
   `oneCocyclesTrivial_ne_bot_of_two_eq_zero` exhibits an explicit nonzero cocycle when
   `2 = 0` (namely the `ℓ 0`-coordinate functional), so `H¹(W(k), k) ≠ 0` there.

## Implementation notes

`Submodule.hasQuotient` cannot be synthesised directly for `↥Z ⧸ B` when the ambient module is
`L →ₗ[R] R` (instance search fails on `AddCommGroup ↥Z` after chasing
`NonUnitalNonAssocRing (L →ₗ[R] R)`; this is the same Mathlib defect recorded in
`formal/MATHLIB-ISSUE-quotient-finsupp.md` and worked around in `NoGhost/TowerNull.lean`).
The fix is the same: form the quotient once in a section where the ambient module is an
abstract variable (`SubQuot`), then instantiate.

## Status

Complete, no `sorry`. Both halves of the card's part (2) are formalised: the vanishing
`H¹(W, k) = 0`, and the dictionary `H¹(𝓛, k) ≅ (𝓛/[𝓛,𝓛])^*` together with
`H¹ = 0 ⟺ 𝓛 = [𝓛, 𝓛]` over a field.

[GAP] Not done: higher cohomology (`H²` is a different card,
`worldsheet.virasoro-unique-central-extension`); adjoint coefficients `H¹(W, W)`; any comparison
with a full Chevalley–Eilenberg *complex* in all degrees (Mathlib has only degrees `≤ 2`, and we
add only degree `0`); the one-sided Witt algebras `W_r = Der k[x₁,…,x_r]`.
-/

namespace StringFormal.LieCohomology

open LieAlgebra LieModule.Cohomology

/-! ### The degree-0 Chevalley–Eilenberg differential

Mathlib `v4.33.1` has `d₁₂ : C¹ → C²` and `d₂₃` but no `d₀₁`; we supply it, for an arbitrary
Lie module, and check `d₁₂ ∘ d₀₁ = 0`. -/

section Coboundary

variable (R : Type*) [CommRing R] (L : Type*) [LieRing L] [LieAlgebra R L]
  (M : Type*) [AddCommGroup M] [Module R M] [LieRingModule L M] [LieModule R L M]

/-- The Chevalley–Eilenberg coboundary operator in degree `0`: a `0`-cochain is an element
`m : M`, and `(d⁰ m)(x) = ⁅x, m⁆`. -/
def d₀₁ : M →ₗ[R] oneCochain R L M where
  toFun m :=
    { toFun := fun x => ⁅x, m⁆
      map_add' := fun x y => add_lie x y m
      map_smul' := fun t x => smul_lie t x m }
  map_add' m₁ m₂ := by ext x; exact lie_add x m₁ m₂
  map_smul' t m := by ext x; exact lie_smul t x m

@[simp]
lemma d₀₁_apply (m : M) (x : L) : d₀₁ R L M m x = ⁅x, m⁆ := rfl

/-- `d¹ ∘ d⁰ = 0`, pointwise form. This is the Leibniz identity of the Lie module `M`. -/
lemma d₁₂_d₀₁_apply_apply (m : M) (x y : L) : d₁₂ R L M (d₀₁ R L M m) x y = 0 := by
  rw [d₁₂_apply_apply, d₀₁_apply, d₀₁_apply, d₀₁_apply, leibniz_lie x y m]
  abel

/-- `d¹ ∘ d⁰ = 0`. (`simp` closes the pointwise goal via `lie_lie`; the explicit Leibniz
computation is `d₁₂_d₀₁_apply_apply`.) -/
lemma d₁₂_comp_d₀₁ : (d₁₂ R L M) ∘ₗ (d₀₁ R L M) = 0 := by
  refine LinearMap.ext fun m => Subtype.ext (LinearMap.ext fun x => LinearMap.ext fun y => ?_)
  simp

/-- **With trivial coefficients the degree-0 differential vanishes**: this is the card's
"1-上边缘只有 0", proved rather than assumed. -/
lemma d₀₁_eq_zero_of_isTrivial [LieModule.IsTrivial L M] : d₀₁ R L M = 0 := by
  refine LinearMap.ext fun m => LinearMap.ext fun x => ?_
  simp [trivial_lie_zero]

/-- **With trivial coefficients the 1-cocycles are exactly the linear maps killing all
brackets**: this is the card's description of `Z¹`, proved rather than assumed. -/
lemma mem_ker_d₁₂_iff_of_isTrivial [LieModule.IsTrivial L M] (f : oneCochain R L M) :
    f ∈ LinearMap.ker (d₁₂ R L M) ↔ ∀ x y : L, f ⁅x, y⁆ = 0 := by
  rw [LinearMap.mem_ker]
  constructor
  · intro h x y
    have hxy : d₁₂ R L M f x y = 0 := by rw [h]; rfl
    rw [d₁₂_apply_apply_ofTrivial] at hxy
    exact neg_eq_zero.mp hxy
  · intro h
    refine Subtype.ext (LinearMap.ext fun x => LinearMap.ext fun y => ?_)
    simp [trivial_lie_zero, h x y]

end Coboundary

/-! ### A quotient of a submodule by a submodule

Only to work around the instance-synthesis defect described in the module docstring. -/

section AbstractQuot

variable {R : Type*} [CommRing R] {N : Type*} [AddCommGroup N] [Module R N]

/-- The quotient of a submodule `Z ≤ N` by a submodule `B ≤ Z`. Nothing but `↥Z ⧸ B`; it exists
only so that the `HasQuotient` instance is resolved once, with `N` an abstract variable. -/
abbrev SubQuot (Z : Submodule R N) (B : Submodule R Z) : Type _ := Z ⧸ B

end AbstractQuot

/-! ### `Z¹`, `B¹` and `H¹` with trivial coefficients, exactly as on the card -/

section Trivial

variable (R : Type*) [CommRing R] (L : Type*) [LieRing L] [LieAlgebra R L]

/-- **1-cocycles with trivial coefficients**, verbatim from the card: the linear functionals
`f : 𝓛 →ₗ[k] k` with `f ⁅x, y⁆ = 0` for all `x, y`. See `mem_ker_d₁₂_trivialLieModule_iff`
for the check that this is Mathlib's Chevalley–Eilenberg condition `d¹ f = 0`. -/
def oneCocyclesTrivial : Submodule R (L →ₗ[R] R) where
  carrier := {f | ∀ x y : L, f ⁅x, y⁆ = 0}
  add_mem' {f g} hf hg x y := by simp [hf x y, hg x y]
  zero_mem' x y := by simp
  smul_mem' t f hf x y := by simp [hf x y]

@[simp]
lemma mem_oneCocyclesTrivial {f : L →ₗ[R] R} :
    f ∈ oneCocyclesTrivial R L ↔ ∀ x y : L, f ⁅x, y⁆ = 0 := Iff.rfl

/-- The degree-0 differential with trivial coefficients: a `0`-cochain is a scalar `c : k` and
`(d⁰ c)(x) = x · c = 0`, the action being trivial. That this is the genuine Chevalley–Eilenberg
`d⁰` is `d₀₁_trivialLieModule_eq_zero`. -/
def zeroCoboundaryTrivial : R →ₗ[R] (L →ₗ[R] R) := 0

/-- **1-coboundaries with trivial coefficients**: the range of `zeroCoboundaryTrivial`, i.e.
just `0` — the card's "1-上边缘只有 0". -/
def oneCoboundariesTrivial : Submodule R (L →ₗ[R] R) :=
  LinearMap.range (zeroCoboundaryTrivial R L)

@[simp]
lemma oneCoboundariesTrivial_eq_bot : oneCoboundariesTrivial R L = ⊥ :=
  LinearMap.range_zero

lemma oneCoboundariesTrivial_le_oneCocyclesTrivial :
    oneCoboundariesTrivial R L ≤ oneCocyclesTrivial R L := by
  rw [oneCoboundariesTrivial_eq_bot]
  exact bot_le

/-- The Chevalley–Eilenberg `d⁰` of the trivial module `TrivialLieModule R L R` is the zero
map: `zeroCoboundaryTrivial` is not an ad hoc choice. -/
lemma d₀₁_trivialLieModule_eq_zero : d₀₁ R L (TrivialLieModule R L R) = 0 :=
  d₀₁_eq_zero_of_isTrivial R L _

/-- The Chevalley–Eilenberg 1-cocycle condition for the trivial module `TrivialLieModule R L R`
is the card's condition `f ⁅x, y⁆ = 0`: `oneCocyclesTrivial` is not an ad hoc choice. -/
lemma mem_ker_d₁₂_trivialLieModule_iff (f : oneCochain R L (TrivialLieModule R L R)) :
    f ∈ LinearMap.ker (d₁₂ R L (TrivialLieModule R L R)) ↔ ∀ x y : L, f ⁅x, y⁆ = 0 :=
  mem_ker_d₁₂_iff_of_isTrivial R L _ f

/-- `B¹` regarded as a submodule of `Z¹`. -/
def oneCoboundariesIn : Submodule R (oneCocyclesTrivial R L) :=
  (oneCoboundariesTrivial R L).comap (oneCocyclesTrivial R L).subtype

@[simp]
lemma oneCoboundariesIn_eq_bot : oneCoboundariesIn R L = ⊥ := by
  rw [oneCoboundariesIn, oneCoboundariesTrivial_eq_bot, Submodule.comap_bot,
    Submodule.ker_subtype]

/-- **`H¹(𝓛, k) = Z¹ / B¹`** with trivial coefficients. -/
abbrev H1Trivial : Type _ := SubQuot (oneCocyclesTrivial R L) (oneCoboundariesIn R L)

/-- Since `B¹ = 0`, the natural map `Z¹ → H¹` is an isomorphism. -/
def h1TrivialEquivOneCocycles : H1Trivial R L ≃ₗ[R] oneCocyclesTrivial R L :=
  Submodule.quotEquivOfEqBot _ (oneCoboundariesIn_eq_bot R L)

/-- `H¹(𝓛, k) = 0` is the same thing as `Z¹(𝓛, k) = 0`, because `B¹ = 0`. -/
theorem subsingleton_H1Trivial_iff :
    Subsingleton (H1Trivial R L) ↔ oneCocyclesTrivial R L = ⊥ := by
  rw [(h1TrivialEquivOneCocycles R L).toEquiv.subsingleton_congr,
    Submodule.subsingleton_iff_eq_bot]

/-! ### The card's dictionary `H¹(𝓛, k) = (𝓛 / [𝓛, 𝓛])^*` -/

/-- A linear functional kills every bracket iff it annihilates the derived subalgebra. -/
theorem oneCocyclesTrivial_eq_dualAnnihilator :
    oneCocyclesTrivial R L = (derivedSeries R L 1).toSubmodule.dualAnnihilator := by
  ext f
  rw [mem_oneCocyclesTrivial, Submodule.mem_dualAnnihilator,
    ← LieIdeal.toLieSubalgebra_toSubmodule]
  constructor
  · intro hf w hw
    rw [coe_derivedSeries_one_eq] at hw
    have hle : Submodule.span R {⁅x, y⁆ | (x : L) (y : L)} ≤ LinearMap.ker f := by
      rw [Submodule.span_le]
      rintro _ ⟨x, y, rfl⟩
      exact hf x y
    exact hle hw
  · intro hf x y
    refine hf _ ?_
    rw [coe_derivedSeries_one_eq]
    exact Submodule.subset_span ⟨x, y, rfl⟩

/-- **The card's dictionary**: `H¹(𝓛, k) ≅ (𝓛 / [𝓛, 𝓛])^*`. -/
def h1TrivialEquivDualQuot :
    H1Trivial R L ≃ₗ[R] Module.Dual R (L ⧸ (derivedSeries R L 1).toSubmodule) :=
  (h1TrivialEquivOneCocycles R L).trans
    ((LinearEquiv.ofEq _ _ (oneCocyclesTrivial_eq_dualAnnihilator R L)).trans
      (Submodule.dualQuotEquivDualAnnihilator _).symm)

/-- **"(1) ⟹ (2)" over an arbitrary commutative ring**: a perfect Lie algebra has no nonzero
1-cocycles with trivial coefficients. -/
theorem oneCocyclesTrivial_eq_bot_of_derivedSeries_eq_top (h : derivedSeries R L 1 = ⊤) :
    oneCocyclesTrivial R L = ⊥ := by
  rw [oneCocyclesTrivial_eq_dualAnnihilator]
  have ht : (derivedSeries R L 1).toSubmodule = ⊤ := by rw [h]; rfl
  rw [ht, Submodule.dualAnnihilator_top]

/-- Corollary of the previous statement, in terms of `H¹`. -/
theorem subsingleton_H1Trivial_of_derivedSeries_eq_top (h : derivedSeries R L 1 = ⊤) :
    Subsingleton (H1Trivial R L) :=
  (subsingleton_H1Trivial_iff R L).mpr (oneCocyclesTrivial_eq_bot_of_derivedSeries_eq_top R L h)

end Trivial

section Field

variable (K : Type*) [Field K] (L : Type*) [LieRing L] [LieAlgebra K L]

/-- **The card's dictionary "(1) ⟺ (2)", over a field**: `Z¹(𝓛, k) = 0 ⟺ 𝓛 = [𝓛, 𝓛]`.

The "`⟸`" half holds over any commutative ring
(`oneCocyclesTrivial_eq_bot_of_derivedSeries_eq_top`); the "`⟹`" half is exactly the card's
step "域上一个向量空间的对偶为零当且仅当该空间为零" and is **false** over `ℤ`, see
`StringFormal.Virasoro.WittAlgebra.witt_int_h1_vanishes_but_not_perfect`. -/
theorem oneCocyclesTrivial_eq_bot_iff :
    oneCocyclesTrivial K L = ⊥ ↔ derivedSeries K L 1 = ⊤ := by
  rw [oneCocyclesTrivial_eq_dualAnnihilator, Submodule.dualAnnihilator_eq_bot_iff,
    LieSubmodule.toSubmodule_eq_top]

/-- **`H¹(𝓛, k) = 0 ⟺ 𝓛 = [𝓛, 𝓛]`** over a field: the card's part (1) ⟺ part (2). -/
theorem subsingleton_H1Trivial_iff_derivedSeries_eq_top :
    Subsingleton (H1Trivial K L) ↔ derivedSeries K L 1 = ⊤ :=
  (subsingleton_H1Trivial_iff K L).trans (oneCocyclesTrivial_eq_bot_iff K L)

end Field

end StringFormal.LieCohomology

namespace StringFormal.Virasoro

open LieAlgebra LieCohomology Module

namespace WittAlgebra

variable (R : Type*) [CommRing R]

/-- Every 1-cocycle `f` of the Witt algebra satisfies `2 · f(ℓ n) = 0`, because
`2 ℓ n = ⁅ℓ (n+2), ℓ (-2)⁆ - ⁅ℓ (n+1), ℓ (-1)⁆` (`WittPerfect.two_smul_lgen_eq`). No hypothesis
on the ground ring. -/
lemma two_mul_apply_lgen_of_mem_oneCocyclesTrivial {f : WittAlgebra R →ₗ[R] R}
    (hf : f ∈ oneCocyclesTrivial R (WittAlgebra R)) (n : ℤ) :
    (2 : R) * f (lgen R n) = 0 := by
  have hf' : ∀ x y : WittAlgebra R, f ⁅x, y⁆ = 0 := hf
  have h := congrArg f (two_smul_lgen_eq R n)
  rw [map_smul, smul_eq_mul, map_sub, hf' _ _, hf' _ _, sub_zero] at h
  exact h

/-- **`Z¹(W(R), R) = 0` whenever `2` is a non-zero-divisor in `R`.**

This is *weaker* than the hypothesis needed for perfectness (`2 ∈ R^×`, see
`WittPerfect.derivedSeries_one_eq_top_iff`): over `ℤ`, for instance, `W(ℤ)` is not perfect but
still has no nonzero 1-cocycles. -/
theorem oneCocyclesTrivial_eq_bot_of_two_regular (h2 : ∀ r : R, (2 : R) * r = 0 → r = 0) :
    oneCocyclesTrivial R (WittAlgebra R) = ⊥ := by
  rw [Submodule.eq_bot_iff]
  intro f hf
  refine (lgen R).ext fun n => ?_
  rw [LinearMap.zero_apply]
  exact h2 _ (two_mul_apply_lgen_of_mem_oneCocyclesTrivial R hf n)

/-- **`Z¹(W(R), R) = 0` when `2` is invertible** (in particular over any field of characteristic
`≠ 2`, so in particular over the card's characteristic-zero field `k`). -/
theorem oneCocyclesTrivial_eq_bot [Invertible (2 : R)] :
    oneCocyclesTrivial R (WittAlgebra R) = ⊥ :=
  oneCocyclesTrivial_eq_bot_of_derivedSeries_eq_top R _ (derivedSeries_one_eq_top R)

/-- **`H¹(W(k), k) = 0`** — part (2) of the graph card `math.witt-algebra-perfect`, for any
commutative ring in which `2` is invertible (so in particular for every field of characteristic
zero). -/
theorem subsingleton_H1Trivial [Invertible (2 : R)] :
    Subsingleton (H1Trivial R (WittAlgebra R)) :=
  (subsingleton_H1Trivial_iff R _).mpr (oneCocyclesTrivial_eq_bot R)

/-- `H¹(W(R), R) = 0` under the sharper hypothesis that `2` is a non-zero-divisor. -/
theorem subsingleton_H1Trivial_of_two_regular (h2 : ∀ r : R, (2 : R) * r = 0 → r = 0) :
    Subsingleton (H1Trivial R (WittAlgebra R)) :=
  (subsingleton_H1Trivial_iff R _).mpr (oneCocyclesTrivial_eq_bot_of_two_regular R h2)

/-! ### Sharpness in characteristic two -/

/-- In characteristic `2` the `ℓ 0`-coordinate functional is a 1-cocycle: every bracket has an
even `ℓ 0`-coefficient (`WittPerfect.coord_zero_lie_mem_span_two`). -/
lemma coord_zero_mem_oneCocyclesTrivial_of_two_eq_zero (h2 : (2 : R) = 0) :
    (lgen R).coord 0 ∈ oneCocyclesTrivial R (WittAlgebra R) := by
  show ∀ x y : WittAlgebra R, (lgen R).coord 0 ⁅x, y⁆ = 0
  intro x y
  have h := coord_zero_lie_mem_span_two R x y
  rw [h2, Ideal.mem_span_singleton, zero_dvd_iff] at h
  exact h

/-- **In characteristic `2` there *are* nonzero 1-cocycles**, so `H¹(W(k), k) ≠ 0` there: the
hypothesis `2 ≠ 0` in `oneCocyclesTrivial_eq_bot` cannot be dropped. -/
theorem oneCocyclesTrivial_ne_bot_of_two_eq_zero [Nontrivial R] (h2 : (2 : R) = 0) :
    oneCocyclesTrivial R (WittAlgebra R) ≠ ⊥ := by
  intro h
  have hmem := coord_zero_mem_oneCocyclesTrivial_of_two_eq_zero R h2
  rw [h, Submodule.mem_bot] at hmem
  have hone : (lgen R).coord 0 (lgen R 0) = 1 := by
    rw [Basis.coord_apply, Basis.repr_self, Finsupp.single_apply, if_pos rfl]
  rw [hmem, LinearMap.zero_apply] at hone
  exact zero_ne_one hone

/-- Over a field, `H¹(W(k), k) = 0` **iff** `2` is a unit, matching
`WittPerfect.derivedSeries_one_eq_top_iff` for perfectness. -/
theorem oneCocyclesTrivial_eq_bot_iff_of_field (K : Type*) [Field K] :
    oneCocyclesTrivial K (WittAlgebra K) = ⊥ ↔ IsUnit (2 : K) := by
  rw [oneCocyclesTrivial_eq_bot_iff, derivedSeries_one_eq_top_iff]

/-- Over a field, `H¹(W(k), k) = 0 ⟺ 2 ∈ k^× ⟺ ⁅W, W⁆ = W`: the card's "(1) ⟺ (2)" made
explicit for the Witt algebra. -/
theorem subsingleton_H1Trivial_iff_of_field (K : Type*) [Field K] :
    Subsingleton (H1Trivial K (WittAlgebra K)) ↔ IsUnit (2 : K) :=
  (subsingleton_H1Trivial_iff K _).trans (oneCocyclesTrivial_eq_bot_iff_of_field K)

/-! ### The dictionary "(1) ⟺ (2)" fails over `ℤ` -/

/-- `Z¹(W(ℤ), ℤ) = 0`: over `ℤ` the Witt algebra has no nonzero 1-cocycle even though it is not
perfect. -/
theorem oneCocyclesTrivial_int_eq_bot : oneCocyclesTrivial ℤ (WittAlgebra ℤ) = ⊥ :=
  oneCocyclesTrivial_eq_bot_of_two_regular ℤ fun r hr => by omega

/-- **A counterexample to the card's dictionary over a non-field ground ring**: over `ℤ`,
`H¹(W, ℤ) = 0` holds while `⁅W, W⁆ = W` fails. The implication "(2) ⟹ (1)" therefore really
does need the ground ring to be a field (the card's step "域上一个向量空间的对偶为零当且仅当
该空间为零"). -/
theorem witt_int_h1_vanishes_but_not_perfect :
    Subsingleton (H1Trivial ℤ (WittAlgebra ℤ)) ∧ derivedSeries ℤ (WittAlgebra ℤ) 1 ≠ ⊤ :=
  ⟨(subsingleton_H1Trivial_iff ℤ _).mpr oneCocyclesTrivial_int_eq_bot,
    derivedSeries_one_ne_top_int⟩

end WittAlgebra

end StringFormal.Virasoro
