/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import Mathlib.Analysis.Complex.UpperHalfPlane.MoebiusAction
import Mathlib.LinearAlgebra.Matrix.ProjectiveSpecialLinearGroup
import Mathlib.NumberTheory.ModularForms.DedekindEta
import Mathlib.NumberTheory.LSeries.HurwitzZetaValues

/-!
# Bridge layer: Mathlib objects restated verbatim in the graph's conventions

Graph nodes: `math.dedekind-eta-function`, `worldsheet.modular-group-psl2z`.

## Why this file exists

Both cards are **definition** cards whose objects already exist in Mathlib.  The graph tooling
requires `formal.lean_decl` to name a declaration living under `formal/` (`lean_file` must be a
path inside this repository), so a card cannot point directly at `ModularForm.eta` or at
`Matrix.ProjectiveSpecialLinearGroup`.  Rather than re-defining the objects (which would create a
second, unverified copy), this file contains a **thin bridge**: for each card, one or more
theorems that state the card's formula *verbatim* and whose proof is "this is Mathlib's
definition".

**Bridge-layer rule** (see `formal/CLAUDE.md`): if Mathlib already has the definition or theorem,
do not re-define it — state one verbatim restatement here under `StringFormal.Bridge` and let the
card's `lean_decl` point at that restatement.

## Main results

### `math.dedekind-eta-function`

* `dedekindEta_eq_qpow_mul_tprod` : `η(z) = q^{1/24} ∏_{n ≥ 0} (1 − q^{n+1})` with Mathlib's
  `Function.Periodic.qParam`, i.e. the unfolding of `ModularForm.eta`.
* `qParam_one_eq_exp`, `qParam_24_eq_exp`, `qParam_24_eq_exp_pi_I_div_twelve` : the card's
  branch conventions `q = e^{2πiτ}` and `q^{1/24} = e^{2πiτ/24} = e^{πiτ/12}`.
* `dedekindEta_eq_exp_mul_tprod` : the card's formula with every `q` expanded into `exp`,
  `η(τ) = e^{πiτ/12} ∏_{n ≥ 1} (1 − e^{2πiτ n})`.
* `dedekindEta_ne_zero`, `differentiableAt_dedekindEta` : the two analytic assertions the card
  makes about `η` on `H` (no zeros; holomorphic).

### `worldsheet.modular-group-psl2z`

* `PSL2Z` : notation for Mathlib's `PSL(2, ℤ) = SL(2,ℤ) ⧸ Z(SL(2,ℤ))`.
* `center_eq_pm_one` : `Z(SL(2,ℤ)) = {±I}` **as a set**, so Mathlib's quotient really is the
  card's `SL(2,ℤ)/{±I}`.  (This is *not* in Mathlib and *not* in
  `StringFormal/Math/ModularGroupGenerators.lean`, which deliberately only used `−I ∈ Z`.)
* `psl2z_eq_quotient_pm_one`, `center_eq_zpowers_neg_one` : the same as an identity of
  **subgroups**, `Z(SL(2,ℤ)) = ⟨−I⟩`.
* `pslMk_eq_iff` : **extensionality of the quotient**, `pslMk g = pslMk h ↔ g = h ∨ g = −h` —
  the `±`-identification the cards write down, with no mention of the centre.
* `psl2z_smul_eq` : `γ · τ = (aτ + b)/(cτ + d)` with the matrix entries written out.
* `psl2z_im_smul_eq` : `Im(γ·τ) = Im τ / |cτ + d|²`, the card's reason the action preserves `H`.
* `psl2z_im_pos` : `Im(γ·τ) > 0`, i.e. the action really lands in `H`
  (`math.mobius-action-preserves-upper-half-plane` item (2), which otherwise lives only in the
  *type* of `psl2z_im_smul_eq`).
* `psl2z_T_smul`, `psl2z_S_smul` : `T : τ ↦ τ + 1` and `S : τ ↦ −1/τ`.
* `neg_smul_eq`, `neg_one_smul_eq` : `γ` and `−γ` induce the same map, `−I` acts trivially.
* `smul_eq_of_pslMk_eq` and the `MulAction PSL2Z ℍ` instance (`pslMk_smul`) : the action
  **descends to `PSL(2,ℤ)`** — the card's "the group acting effectively is `PSL(2,ℤ)`".

### `worldsheet.zeta-regularized-sum-of-integers` (analytic-continuation clause only)

* `riemannZeta_neg_one` : `ζ(−1) = −1/12`, the `k = 1` case of Mathlib's
  `riemannZeta_neg_nat_eq_bernoulli` (Mathlib has no named `ζ(−1)`).
* `riemannZeta_neg_one_eq_bernoulli` : the same with `B₂` left visible.
* `lightCone_normalOrderingConstant`, `lightCone_normalOrderingConstant_of_26` : the arithmetic
  `((D−2)/2)·ζ(−1) = −(D−2)/24`, and `= −1` at `D = 26`
  (card `worldsheet.light-cone-normal-ordering-constant`).

## What is *not* claimed here

Nothing about modular transformations of `η` (those are `StringFormal/Math/DedekindEta{S,T}.lean`
and the corresponding cards), and nothing about `η` as a weight-`1/2` modular form.

On the `PSL(2,ℤ)` side: no faithfulness of the `PSL(2,ℤ)`-action (true, but the card does not
assert it), no generation by `S`, `T` (that is
`StringFormal/Math/ModularGroupGenerators.lean` / `worldsheet.modular-group-generated-by-s-and-t`),
no fundamental domain, and no claim that `PSL(2,ℤ)` is the modular equivalence of the torus.

On the `ζ` side: **no** assertion that `ζ(−1)` "is" the divergent sum `Σ_{n≥1} n`, and **no**
assertion that it is a physical zero-point energy.  See the `RiemannZeta` section docstring.
-/

namespace StringFormal.Bridge

open Complex ModularForm
open scoped Real

/-! ### `math.dedekind-eta-function` -/

/-- **The Dedekind eta function of the graph card is Mathlib's `ModularForm.eta`.**

`η(z) = q^{1/24} ∏_{n = 0}^{∞} (1 − q^{n+1})`, where `𝕢 h z = exp (2πi z / h)`, so that
`Function.Periodic.qParam 24 z = q^{1/24}` and `Function.Periodic.qParam 1 z = q`.  This is
literally Mathlib's definition of `ModularForm.eta`; it is stated here so that the graph card
`math.dedekind-eta-function` has a declaration under `formal/` to point at. -/
theorem dedekindEta_eq_qpow_mul_tprod (z : ℂ) :
    ModularForm.eta z =
      Function.Periodic.qParam 24 z * ∏' n : ℕ, (1 - Function.Periodic.qParam 1 z ^ (n + 1)) :=
  rfl

/-- `q = e^{2πiτ}` — the card's normalisation of `q`. -/
theorem qParam_one_eq_exp (z : ℂ) :
    Function.Periodic.qParam 1 z = Complex.exp (2 * π * I * z) := by
  simp [Function.Periodic.qParam]

/-- `q^{1/24} = e^{2πiτ/24}` — the card's *choice of branch* for the 24th root: it is the
single-valued function `exp (2πiτ/24)`, not a multivalued radical. -/
theorem qParam_24_eq_exp (z : ℂ) :
    Function.Periodic.qParam 24 z = Complex.exp (2 * π * I * z / 24) := rfl

/-- `q^{1/24} = e^{πiτ/12}`, the form in which the prefactor is usually written in string
theory (Polchinski (7.2.10)). -/
theorem qParam_24_eq_exp_pi_I_div_twelve (z : ℂ) :
    Function.Periodic.qParam 24 z = Complex.exp (π * I * z / 12) := by
  rw [qParam_24_eq_exp]
  ring_nf

/-- **The card's formula with all `q`'s expanded.**

`η(τ) = e^{πiτ/12} ∏_{n = 0}^{∞} (1 − (e^{2πiτ})^{n+1})`, i.e.
`η(τ) = q^{1/24} ∏_{n ≥ 1} (1 − q^n)` with `q = e^{2πiτ}` and `q^{1/24} = e^{πiτ/12}`. -/
theorem dedekindEta_eq_exp_mul_tprod (z : ℂ) :
    ModularForm.eta z =
      Complex.exp (π * I * z / 12) *
        ∏' n : ℕ, (1 - Complex.exp (2 * π * I * z) ^ (n + 1)) := by
  rw [dedekindEta_eq_qpow_mul_tprod, qParam_24_eq_exp_pi_I_div_twelve, qParam_one_eq_exp]

/-- **`η` has no zeros on the upper half-plane** — the second analytic assertion of the card
(each factor `1 − q^n` is nonzero and `q^{1/24} ≠ 0`).  Mathlib: `ModularForm.eta_ne_zero`. -/
theorem dedekindEta_ne_zero {z : ℂ} (hz : 0 < z.im) : ModularForm.eta z ≠ 0 :=
  ModularForm.eta_ne_zero hz

/-- **`η` is holomorphic on the upper half-plane** — the first analytic assertion of the card
(locally uniform convergence of the product).  Mathlib:
`ModularForm.differentiableAt_eta_of_mem_upperHalfPlaneSet`. -/
theorem differentiableAt_dedekindEta {z : ℂ} (hz : 0 < z.im) :
    DifferentiableAt ℂ ModularForm.eta z :=
  ModularForm.differentiableAt_eta_of_mem_upperHalfPlaneSet hz

/-! ### `worldsheet.modular-group-psl2z` -/

section ModularGroup

open Matrix Matrix.SpecialLinearGroup UpperHalfPlane
open scoped MatrixGroups UpperHalfPlane

/-- `PSL(2,ℤ)`, the modular group of the card, is Mathlib's
`Matrix.ProjectiveSpecialLinearGroup (Fin 2) ℤ = SL(2,ℤ) ⧸ Z(SL(2,ℤ))`.  That this quotient is
the card's `SL(2,ℤ)/{±I}` is `center_eq_pm_one` below. -/
abbrev PSL2Z := PSL(2, ℤ)

/-- The quotient map `SL(2,ℤ) → PSL(2,ℤ)`. -/
abbrev pslMk : SL(2, ℤ) →* PSL2Z := QuotientGroup.mk' (Subgroup.center SL(2, ℤ))

/-- **The Möbius action of the card.**  For `γ = ((a,b),(c,d)) ∈ SL(2,ℤ)` and `τ ∈ H`,
`γ · τ = (aτ + b)/(cτ + d)`.  This is Mathlib's `MulAction SL(2,R) ℍ`, restated with the matrix
entries written out; the proof is `UpperHalfPlane.coe_specialLinearGroup_apply`. -/
theorem psl2z_smul_eq (g : SL(2, ℤ)) (τ : ℍ) :
    ((g • τ : ℍ) : ℂ) =
      ((g 0 0 : ℂ) * (τ : ℂ) + (g 0 1 : ℂ)) / ((g 1 0 : ℂ) * (τ : ℂ) + (g 1 1 : ℂ)) := by
  rw [UpperHalfPlane.coe_specialLinearGroup_apply]
  simp only [algebraMap_int_eq, eq_intCast, Complex.ofReal_intCast]

/-- **The action preserves `H`**, quantitatively: `Im(γ·τ) = Im τ / |cτ + d|²`.  This is the
identity the card lists as the self-consistency of the definition.  Mathlib:
`ModularGroup.im_smul_eq_div_normSq`. -/
theorem psl2z_im_smul_eq (g : SL(2, ℤ)) (τ : ℍ) :
    (g • τ).im = τ.im / ‖(g 1 0 : ℂ) * (τ : ℂ) + (g 1 1 : ℂ)‖ ^ 2 := by
  rw [ModularGroup.im_smul_eq_div_normSq, Complex.normSq_eq_norm_sq]
  simp [ModularGroup.denom_apply]

/-- **The action preserves `H`**, qualitatively: `Im(γ·τ) > 0` — item (2) of the card
`math.mobius-action-preserves-upper-half-plane`.  In Mathlib this is carried by the *type* of
`g • τ` (`ℍ = {z : ℂ // 0 < z.im}`, and the `MulAction SL(2,ℝ) ℍ` instance proves positivity
when it is built); this restatement extracts it as a named proposition so that the card's
item (2) has its own declaration instead of living only in the type of `psl2z_im_smul_eq`.
Mathlib: `UpperHalfPlane.im_pos`. -/
theorem psl2z_im_pos (g : SL(2, ℤ)) (τ : ℍ) : 0 < (g • τ).im :=
  (g • τ).im_pos

/-- `T = ((1,1),(0,1))` acts as `τ ↦ τ + 1` — the card's first standard element.
Mathlib: `UpperHalfPlane.modular_T_smul`. -/
theorem psl2z_T_smul (τ : ℍ) : ((ModularGroup.T • τ : ℍ) : ℂ) = (τ : ℂ) + 1 := by
  rw [UpperHalfPlane.modular_T_smul]
  simp [add_comm]

/-- `S = ((0,−1),(1,0))` acts as `τ ↦ −1/τ` — the card's second standard element.
Mathlib: `UpperHalfPlane.modular_S_smul`. -/
theorem psl2z_S_smul (τ : ℍ) : ((ModularGroup.S • τ : ℍ) : ℂ) = -(τ : ℂ)⁻¹ := by
  rw [UpperHalfPlane.modular_S_smul]
  simp [inv_neg]

/-- **`γ` and `−γ` give the same Möbius map** — the card's reason for passing to the quotient.
Mathlib: `ModularGroup.SL_neg_smul`. -/
theorem neg_smul_eq (g : SL(2, ℤ)) (τ : ℍ) : (-g) • τ = g • τ :=
  ModularGroup.SL_neg_smul g τ

/-- `−I` acts trivially on `H`. -/
theorem neg_one_smul_eq (τ : ℍ) : (-1 : SL(2, ℤ)) • τ = τ := by
  rw [neg_smul_eq, one_smul]

/-- `−I` is central in `SL(2,ℤ)`. -/
theorem neg_one_mem_center : (-1 : SL(2, ℤ)) ∈ Subgroup.center SL(2, ℤ) := by
  rw [Subgroup.mem_center_iff]
  intro g
  rw [mul_neg, neg_mul, mul_one, one_mul]

/-- **`Z(SL(2,ℤ)) = {±I}`**, so that Mathlib's `PSL(2,ℤ) = SL(2,ℤ) ⧸ Z(SL(2,ℤ))` really is the
card's `SL(2,ℤ)/{±I}`.

Proof: by `Matrix.SpecialLinearGroup.mem_center_iff` a central element is a scalar matrix
`r • I` with `r² = 1`; in `ℤ` that forces `r = ±1`. -/
theorem center_eq_pm_one :
    (Subgroup.center SL(2, ℤ) : Set SL(2, ℤ)) = {1, -1} := by
  ext A
  constructor
  · intro hA
    obtain ⟨r, hr, hrA⟩ := Matrix.SpecialLinearGroup.mem_center_iff.mp hA
    rw [Fintype.card_fin] at hr
    rcases Int.eq_one_or_neg_one_of_mul_eq_one (v := r) (by rw [← sq]; exact hr) with h | h
    · subst h
      exact Or.inl (Subtype.ext (by simpa using hrA.symm))
    · subst h
      refine Or.inr (Subtype.ext ?_)
      rw [Matrix.SpecialLinearGroup.coe_neg, Matrix.SpecialLinearGroup.coe_one, ← hrA]
      simp
  · rintro (rfl | rfl)
    · exact Subgroup.one_mem _
    · exact neg_one_mem_center

/-- **`Z(SL(2,ℤ))` is the subgroup generated by `−I`** — the subgroup-level (rather than
set-level) form of `center_eq_pm_one`.  Together with `pslMk_eq_iff` below this turns "Mathlib's
`PSL(2,ℤ) = SL(2,ℤ) ⧸ Z(SL(2,ℤ))` is the cards' `SL(2,ℤ)/{±I}`" from a human comparison of two
statements into a machine-checked identity of the two subgroups one is quotienting by.

Cards: `math.sl2z-center-is-pm-one`, `worldsheet.modular-group-psl2z`. -/
theorem psl2z_eq_quotient_pm_one :
    Subgroup.center SL(2, ℤ) = Subgroup.closure {(-1 : SL(2, ℤ))} := by
  apply le_antisymm
  · intro g hg
    have hg' : g ∈ ({1, -1} : Set SL(2, ℤ)) := center_eq_pm_one ▸ hg
    rcases hg' with rfl | rfl
    · exact one_mem _
    · exact Subgroup.subset_closure rfl
  · rw [Subgroup.closure_le]
    rintro g rfl
    exact neg_one_mem_center

/-- `Z(SL(2,ℤ)) = ⟨−I⟩` written with `Subgroup.zpowers`, i.e. `{(−I)^k : k ∈ ℤ} = {±I}`. -/
theorem center_eq_zpowers_neg_one :
    Subgroup.center SL(2, ℤ) = Subgroup.zpowers (-1 : SL(2, ℤ)) := by
  rw [psl2z_eq_quotient_pm_one, ← Subgroup.zpowers_eq_closure]

/-- **Extensionality for `PSL(2,ℤ)`: two matrices have the same image iff they differ by a
sign**, `pslMk g = pslMk h ↔ g = h ∨ g = −h`.

This is the machine-checked form of the identification the graph cards
(`math.psl2z-s-t-relations`, `worldsheet.modular-group-generated-by-s-and-t-v2`) make in prose:
Mathlib's quotient `SL(2,ℤ) ⧸ Z(SL(2,ℤ))` identifies exactly the pairs `{g, −g}`, which is the
cards' `SL(2,ℤ)/{±I}`.  Previously those derivations had to cite `center_eq_pm_one` and let a
*human* conclude that the two quotients agree; this statement mentions no centre at all, only the
`±` relation the cards write down.

Proof: `QuotientGroup.mk'_eq_mk'` reduces equality in the quotient to `∃ z ∈ Z, g * z = h`, and
`center_eq_pm_one` says `z = ±I`. -/
theorem pslMk_eq_iff (g h : SL(2, ℤ)) : pslMk g = pslMk h ↔ g = h ∨ g = -h := by
  constructor
  · intro hgh
    obtain ⟨z, hz, rfl⟩ := (QuotientGroup.mk'_eq_mk' _).mp hgh
    have hz' : z ∈ ({1, -1} : Set SL(2, ℤ)) := center_eq_pm_one ▸ hz
    rcases hz' with rfl | rfl
    · exact Or.inl (mul_one g).symm
    · exact Or.inr (by rw [mul_neg, mul_one, neg_neg])
  · rintro (rfl | rfl)
    · rfl
    · refine (QuotientGroup.mk'_eq_mk' _).mpr ⟨-1, neg_one_mem_center, ?_⟩
      rw [neg_mul_neg, mul_one]

/-- Central elements act trivially on `H` (by `center_eq_pm_one`, they are `±I`). -/
theorem center_le_ker_toPermHom :
    Subgroup.center SL(2, ℤ) ≤ (MulAction.toPermHom SL(2, ℤ) ℍ).ker := by
  intro g hg
  have hg' : g ∈ ({1, -1} : Set SL(2, ℤ)) := center_eq_pm_one ▸ hg
  ext τ
  rcases hg' with rfl | rfl
  · simpa using one_smul SL(2, ℤ) τ
  · simpa using neg_one_smul_eq τ

/-- **The action descends to `PSL(2,ℤ)`**: if two matrices have the same image in `PSL(2,ℤ)`
they induce the same map of `H`.  This is the precise content of the card's "since `γ` and `−γ`
give the same fractional linear map, the group acting effectively is `PSL(2,ℤ)`". -/
theorem smul_eq_of_pslMk_eq {g h : SL(2, ℤ)} (hgh : pslMk g = pslMk h) (τ : ℍ) :
    g • τ = h • τ := by
  obtain ⟨z, hz, rfl⟩ := (QuotientGroup.mk'_eq_mk' _).mp hgh
  have hker := center_le_ker_toPermHom hz
  have hfix : z • τ = τ := by
    simpa using congrArg (fun e : Equiv.Perm ℍ => e τ) hker
  rw [mul_smul, hfix]

/-- The induced homomorphism `PSL(2,ℤ) → Perm H`; its existence is `center_le_ker_toPermHom`. -/
noncomputable def pslPermHom : PSL2Z →* Equiv.Perm ℍ :=
  QuotientGroup.lift _ (MulAction.toPermHom SL(2, ℤ) ℍ) center_le_ker_toPermHom

/-- **`PSL(2,ℤ)` acts on the upper half-plane** — the card's statement that the modular group,
not `SL(2,ℤ)`, is what acts effectively. -/
noncomputable scoped instance : MulAction PSL2Z ℍ := MulAction.compHom ℍ pslPermHom

/-- The `PSL(2,ℤ)`-action is the `SL(2,ℤ)`-action, read through the quotient map. -/
@[simp]
theorem pslMk_smul (g : SL(2, ℤ)) (τ : ℍ) : (pslMk g : PSL2Z) • τ = g • τ := rfl

end ModularGroup

section RiemannZeta

open Complex

/-!
### `ζ(−1) = −1/12`

Graph cards touched: `worldsheet.zeta-regularized-sum-of-integers` (the *analytic-continuation*
half of its parenthetical "or equivalently the `ζ`-function continuation `Σ n^{-s}|_{s=-1}`")
and `worldsheet.light-cone-normal-ordering-constant` (the arithmetic `A = ((D−2)/2)·(−1/12)`).

Mathlib has the general formula `riemannZeta_neg_nat_eq_bernoulli` (in
`Mathlib/NumberTheory/LSeries/HurwitzZetaValues.lean`) but **no named `ζ(−1)` instance**; the only
named special values at non-positive integers are `riemannZeta_zero` and the trivial zeros
`riemannZeta_neg_two_mul_nat_add_one`.  So the specialisation below is the bridge.

**Scope warning — what this does *not* say.**  `riemannZeta (-1)` is the value of the *analytic
continuation* of `Σ_{n≥1} n^{-s}` at `s = -1`.  It is **not** a sum of the divergent series
`Σ_{n≥1} n`, and it is **not** the assertion that this number is a physical zero-point energy.
The card `worldsheet.zeta-regularized-sum-of-integers` is `physical-argument` precisely because of
that last step ("the finite remainder *is* the Casimir energy"), which has no Lean counterpart and
is untouched by anything in this section.  Formalising `ζ(−1)` must not be used to upgrade it.
Also note `ζ(−1) = −1/12` and the Laurent constant of `Σ_{n≥1} n e^{−un}`
(`StringFormal/Math/RegulatedSum.lean`, card `worldsheet.regulated-sum-laurent-expansion`) are two
*different* theorems that happen to give the same number; the graph keeps them on separate cards.
-/

/-- **`ζ(−1) = −1/12`.**  Specialisation of Mathlib's `riemannZeta_neg_nat_eq_bernoulli` to
`k = 1`, using `bernoulli 2 = 1/6`:  `ζ(−1) = (−1)^1 · B₂ / 2 = −(1/6)/2 = −1/12`.

Card: the `ζ`-continuation clause of `worldsheet.zeta-regularized-sum-of-integers`.  See the
section docstring for what this statement deliberately does **not** claim. -/
theorem riemannZeta_neg_one : riemannZeta (-1) = -1 / 12 := by
  have h := riemannZeta_neg_nat_eq_bernoulli 1
  rw [Nat.cast_one] at h
  rw [h]
  norm_num [bernoulli_two]

/-- The same value written as `ζ(−1) = −(1/12)` with an explicit `Bernoulli` witness: the general
Mathlib formula at `k = 1`.  Kept so that a reader can see the bridge really is one substitution. -/
theorem riemannZeta_neg_one_eq_bernoulli :
    riemannZeta (-1) = (-1 : ℂ) ^ (1 : ℕ) * (bernoulli 2 : ℚ) / 2 := by
  have h := riemannZeta_neg_nat_eq_bernoulli 1
  rw [Nat.cast_one] at h
  rw [h]
  norm_num

/-- **The arithmetic of `worldsheet.light-cone-normal-ordering-constant`**: with the divergent sum
`Σ_{n≥1} n` replaced by `ζ(−1)`, Polchinski's normal-ordering constant
`A = ((D−2)/2) · "Σ_{n≥1} n"` evaluates to `−(D−2)/24`.

This is the *numerical* half of that card and nothing more: the input `"Σ n" ⟶ ζ(−1)` is the
regularisation prescription, which is the card `worldsheet.zeta-regularized-sum-of-integers`
(`physical-argument`).  Lean here only checks `((D−2)/2)·(−1/12) = −(D−2)/24`. -/
theorem lightCone_normalOrderingConstant (D : ℂ) :
    (D - 2) / 2 * riemannZeta (-1) = -(D - 2) / 24 := by
  rw [riemannZeta_neg_one]; ring

/-- `D = 26` gives Polchinski's `A = −1` (equivalently the intercept `a = 1` under
`conv.intercept-sign-a`). -/
theorem lightCone_normalOrderingConstant_of_26 :
    ((26 : ℂ) - 2) / 2 * riemannZeta (-1) = -1 := by
  rw [lightCone_normalOrderingConstant]; norm_num

end RiemannZeta

end StringFormal.Bridge
