/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import Mathlib.Analysis.Complex.UpperHalfPlane.MoebiusAction
import Mathlib.LinearAlgebra.Matrix.ProjectiveSpecialLinearGroup
import Mathlib.NumberTheory.ModularForms.DedekindEta

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
* `psl2z_smul_eq` : `γ · τ = (aτ + b)/(cτ + d)` with the matrix entries written out.
* `psl2z_im_smul_eq` : `Im(γ·τ) = Im τ / |cτ + d|²`, the card's reason the action preserves `H`.
* `psl2z_im_pos` : `Im(γ·τ) > 0`, i.e. the action really lands in `H`
  (`math.mobius-action-preserves-upper-half-plane` item (2), which otherwise lives only in the
  *type* of `psl2z_im_smul_eq`).
* `psl2z_T_smul`, `psl2z_S_smul` : `T : τ ↦ τ + 1` and `S : τ ↦ −1/τ`.
* `neg_smul_eq`, `neg_one_smul_eq` : `γ` and `−γ` induce the same map, `−I` acts trivially.
* `smul_eq_of_pslMk_eq` and the `MulAction PSL2Z ℍ` instance (`pslMk_smul`) : the action
  **descends to `PSL(2,ℤ)`** — the card's "the group acting effectively is `PSL(2,ℤ)`".

## What is *not* claimed here

Nothing about modular transformations of `η` (those are `StringFormal/Math/DedekindEta{S,T}.lean`
and the corresponding cards), and nothing about `η` as a weight-`1/2` modular form.

On the `PSL(2,ℤ)` side: no faithfulness of the `PSL(2,ℤ)`-action (true, but the card does not
assert it), no generation by `S`, `T` (that is
`StringFormal/Math/ModularGroupGenerators.lean` / `worldsheet.modular-group-generated-by-s-and-t`),
no fundamental domain, and no claim that `PSL(2,ℤ)` is the modular equivalence of the torus.
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

end StringFormal.Bridge
