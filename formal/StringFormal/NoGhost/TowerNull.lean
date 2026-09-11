/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import Mathlib.LinearAlgebra.BilinearForm.Orthogonal
import StringFormal.NoGhost.TowerPairing
import StringFormal.NoGhost.TowerPhysical

/-!
# Spurious, null and quotient states on the DDF momentum tower

Graph nodes: `worldsheet.ocq-spurious-states`, `worldsheet.spurious-orthogonal-to-physical`,
`worldsheet.momentum-tower-fock-space`.  This is §C.1 of `formal/BLUEPRINT-noghost.md`.
Convention: `conv.metric-signature` (mostly-plus); `η` is an arbitrary sign vector.  The form is
`R`-bilinear, **not** sesquilinear, so no reality or positivity assumption enters.

## Why this file exists

`StringFormal/NoGhost/PhysicalStates.lean` and `StringFormal/NoGhost/QuotientForm.lean` build
`Fock.orthComplement`, `Fock.spuriousSubmodule`, `Fock.nullSubmodule` and the induced form on
`H_phys ⧸ H_null` — but only on a **single** Fock space `F(k)`.  The DDF construction lives on
the momentum tower `TowerFock D R = ℤ →₀ Fock D R`, where `TowerPhysical.lean` provides
`towerPhysSubmodule` and nothing beyond it.  Without the objects below the statement of the
no-ghost theorem cannot be written down on the tower at all.

## Part 1: the quotient by the radical, for an arbitrary module

`StringFormal.radicalIn`, `StringFormal.QuotRadical`, `StringFormal.quotRadicalForm` do, for an
arbitrary `R`-module `M`, a bilinear form `B` and a submodule `P`, what `QuotientForm.lean` does
for `Fock.pairing` and `H_phys`: they build `P ⧸ (P ⊓ B.orthogonal P)` and the induced form on
it, with `quotRadicalForm_mk` the computation rule.  The only hypothesis is
`LinearMap.IsRefl B` (reflexivity: `B x y = 0 → B y x = 0`), which is weaker than symmetry.

This generality is not gratuitous.  Stating it for a *variable* module is the only way the
construction elaborates at `M := TowerFock D R` at all:

> **Elaboration note (a real Mathlib-level obstruction, not a style choice).**  For
> `M = ℤ →₀ k` with `k` a semiring — which is what `TowerFock D R = ℤ →₀ Fock D R` is —
> instance synthesis for `HasQuotient ↥P (Submodule R ↥P)` **fails**, because `ℤ →₀ k` is
> also an `AddMonoidAlgebra` and the two routes to `AddCommMonoid (ℤ →₀ k)`
> (`AddCommGroup.toAddCommMonoid ∘ Finsupp.instAddCommGroup` versus
> `Finsupp.instAddCommMonoid`) are not reducibly defeq.  Minimal repro against plain Mathlib:
> `example (R : Type) [CommRing R] (p : Submodule R (ℤ →₀ R)) (q : Submodule R p) : Type :=
> p ⧸ q` fails, while the same statement with `ℤ →₀ M` for an abstract `[AddCommGroup M]`
> `[Module R M]`, or with `MvPolynomial ℕ R` in place of `ℤ →₀ R`, succeeds.  Forcing the
> instances through unification, by proving everything for an abstract `M` and instantiating,
> avoids the search entirely.  Writing `↥(towerPhysSubmodule …) ⧸ …` directly does not
> elaborate, and spelling `@Submodule.hasQuotient` by hand makes the *later* `liftQ` calls
> diverge at `whnf`.

`QuotRadical.mk` and `QuotRadical.mk_surjective` are provided for the same reason: every
tower-level statement must go through generic wrappers, never through bare
`Submodule.Quotient.mk` at the tower type.

## Part 2: the tower

* `towerOrthComplement η W` — the orthogonal complement for `Fock.towerPairing`.  It is
  *defined* to be Mathlib's `LinearMap.BilinForm.orthogonal`; `mem_towerOrthComplement` restates
  membership with the tested vector on the left, which is how `Fock.orthComplement` is phrased.
  `Fock.orthComplement_eq_orthogonal` records that the hand-rolled single-Fock version of
  `PhysicalStates.lean` is the same Mathlib object.
* `towerSpuriousSubmodule η a b` — **spurious states on the tower**, `⨆_{n > 0} range L_{-n}`;
  independent of the intercept, exactly as in the single-Fock case.
* `towerNullSubmodule η a b a₀` — **null states**, `H_phys ⊓ H_phys^⊥`.
* `towerSpuriousSubmodule_le_towerOrthComplement` — **spurious ⊥ physical**, whose only input is
  `L_m^† = L_{-m}` (`Fock.towerPairing_towerLop_left`).
* `towerSpurious_inf_towerPhys_le_towerNull` — **spurious ∩ physical ⊆ null**, the easy half of
  the identification flagged in the `gaps` of
  `worldsheet.no-ghost-theorem-v4--via-goddard-thorn`.
* `towerPairing_add_null`, `towerPairing_eq_of_sub_mem_towerNullSubmodule` — the pairing of
  physical states depends only on their classes mod null states.
* `TowerPhysQuot`, `towerQuotientPairing`, `towerQuotientPairing_mk`,
  `towerQuotientPairing_comm` — **the induced bilinear form on `H_phys ⧸ H_null` of the tower**,
  the object whose positive definiteness the no-ghost theorem asserts.

## Gaps

1. **`H_null = H_spurious ∩ H_phys` is only one inclusion.**  The reverse inclusion (every null
   physical state is spurious) is part of the no-ghost theorem itself and needs the DDF
   decomposition.  `TowerPhysQuot` is therefore the quotient by the *orthogonal radical* — the
   right object for the no-ghost statement — but it is not yet known to agree with "physical
   modulo spurious".
2. **No nondegeneracy statement.**  `towerQuotientPairing` is nondegenerate by construction, but
   `∀ q, (∀ q', towerQuotientPairing q q' = 0) → q = 0` is not extracted.  Same gap as
   `QuotientForm.lean` item 1.
3. **No positivity.**  Over a general commutative ring there is no order; the assertion that
   this form is positive definite at `D = 26`, `a₀ = 1` is untouched.
4. **Nothing relates `towerSpuriousSubmodule` to the DDF operators**, and there is no tower
   analogue of `SpuriousShell.lean`'s on-shell refinement `S ⊓ ker (L_0 - a₀)`.
5. **`QuotientForm.lean` is not refactored** through Part 1, although it is literally the
   `M := Fock D R`, `B := Fock.pairing η`, `P := Fock.physSubmodule η a a₀` instance.  Doing so
   would delete `Fock.nullInPhys`, `Fock.physPairing`, `Fock.quotientPairingAux` and
   `Fock.quotientPairing` in favour of the generic ones; it is left alone here to keep this
   branch to one concern.
-/

namespace StringFormal

/-! ## Part 1: the quotient of a submodule by the radical of a bilinear form -/

section QuotRadical

variable {R M : Type*} [CommRing R] [AddCommGroup M] [Module R M]

/-- **The radical of `B` restricted to `P`, viewed inside `P`**: the vectors of `P` that pair to
zero with all of `P`.  For `P = H_phys` and `B` the Fock form this is the space of null physical
states, sitting inside the physical states. -/
noncomputable def radicalIn (B : LinearMap.BilinForm R M) (P : Submodule R M) :
    Submodule R P :=
  (P ⊓ LinearMap.BilinForm.orthogonal B P).comap P.subtype

lemma mem_radicalIn {B : LinearMap.BilinForm R M} {P : Submodule R M} {χ : P} :
    χ ∈ radicalIn B P ↔ ∀ ψ ∈ P, B ψ (χ : M) = 0 := by
  simp only [radicalIn, Submodule.mem_comap, Submodule.subtype_apply, Submodule.mem_inf,
    LinearMap.BilinForm.mem_orthogonal_iff, and_iff_right χ.2]

lemma mem_radicalIn_of {B : LinearMap.BilinForm R M} {P : Submodule R M} {χ : P}
    (h : ∀ ψ ∈ P, B ψ (χ : M) = 0) : χ ∈ radicalIn B P :=
  mem_radicalIn.mpr h

/-- **`P ⧸ rad(B|_P)`.**  Introduced generically in `M` so that the `HasQuotient` instance is
fixed by unification rather than by a search that fails on `TowerFock`; see the module
docstring. -/
abbrev QuotRadical (B : LinearMap.BilinForm R M) (P : Submodule R M) : Type _ :=
  P ⧸ radicalIn B P

/-- The class of `ψ ∈ P` in `P ⧸ rad(B|_P)`.  Always use this rather than
`Submodule.Quotient.mk`: see the module docstring. -/
noncomputable abbrev QuotRadical.mk (B : LinearMap.BilinForm R M) (P : Submodule R M) (ψ : P) :
    QuotRadical B P :=
  Submodule.Quotient.mk ψ

theorem QuotRadical.mk_surjective (B : LinearMap.BilinForm R M) (P : Submodule R M) :
    Function.Surjective (QuotRadical.mk B P) :=
  Submodule.Quotient.mk_surjective _

theorem radicalIn_le_ker_restrict_flip (B : LinearMap.BilinForm R M) (P : Submodule R M) :
    radicalIn B P ≤ LinearMap.ker (LinearMap.BilinForm.restrict B P).flip := by
  intro χ hχ
  rw [LinearMap.mem_ker]
  refine LinearMap.ext fun φ => ?_
  simp only [LinearMap.zero_apply]
  exact mem_radicalIn.mp hχ _ φ.2

/-- Auxiliary: the form with its *second* argument already descended to the quotient. -/
noncomputable def quotRadicalFormAux (B : LinearMap.BilinForm R M) (P : Submodule R M) :
    QuotRadical B P →ₗ[R] P →ₗ[R] R :=
  (radicalIn B P).liftQ (LinearMap.BilinForm.restrict B P).flip
    (radicalIn_le_ker_restrict_flip B P)

@[simp]
lemma quotRadicalFormAux_mk (B : LinearMap.BilinForm R M) (P : Submodule R M) (χ φ : P) :
    quotRadicalFormAux B P (QuotRadical.mk B P χ) φ = B (φ : M) (χ : M) := by
  rw [quotRadicalFormAux, QuotRadical.mk, Submodule.liftQ_apply]
  rfl

theorem radicalIn_le_ker_quotRadicalFormAux_flip (B : LinearMap.BilinForm R M)
    (P : Submodule R M) (hB : LinearMap.IsRefl B) :
    radicalIn B P ≤ LinearMap.ker (quotRadicalFormAux B P).flip := by
  intro χ hχ
  rw [LinearMap.mem_ker]
  refine LinearMap.ext fun q => ?_
  obtain ⟨φ, rfl⟩ := QuotRadical.mk_surjective B P q
  rw [LinearMap.flip_apply, quotRadicalFormAux_mk, LinearMap.zero_apply]
  exact hB _ _ (mem_radicalIn.mp hχ _ φ.2)

/-- **The induced bilinear form on `P ⧸ rad(B|_P)`.**  Only reflexivity of `B` is used. -/
noncomputable def quotRadicalForm (B : LinearMap.BilinForm R M) (P : Submodule R M)
    (hB : LinearMap.IsRefl B) : LinearMap.BilinForm R (QuotRadical B P) :=
  (radicalIn B P).liftQ (quotRadicalFormAux B P).flip
    (radicalIn_le_ker_quotRadicalFormAux_flip B P hB)

/-- **The computation rule, i.e. well-definedness.** -/
@[simp]
theorem quotRadicalForm_mk (B : LinearMap.BilinForm R M) (P : Submodule R M)
    (hB : LinearMap.IsRefl B) (ψ φ : P) :
    quotRadicalForm B P hB (QuotRadical.mk B P ψ) (QuotRadical.mk B P φ)
      = B (ψ : M) (φ : M) := by
  rw [quotRadicalForm, QuotRadical.mk, Submodule.liftQ_apply, LinearMap.flip_apply,
    quotRadicalFormAux_mk]

/-- A radical representative gives a vanishing row of the induced form. -/
theorem quotRadicalForm_mk_eq_zero_of_mem_radicalIn (B : LinearMap.BilinForm R M)
    (P : Submodule R M) (hB : LinearMap.IsRefl B) {ψ : P} (hψ : ψ ∈ radicalIn B P)
    (q : QuotRadical B P) :
    quotRadicalForm B P hB (QuotRadical.mk B P ψ) q = 0 := by
  obtain ⟨φ, rfl⟩ := QuotRadical.mk_surjective B P q
  rw [quotRadicalForm_mk]
  exact hB _ _ (mem_radicalIn.mp hψ _ φ.2)

/-- If `B` is symmetric then so is the induced form. -/
theorem quotRadicalForm_comm (B : LinearMap.BilinForm R M) (P : Submodule R M)
    (hB : LinearMap.IsRefl B) (hsymm : ∀ x y : M, B x y = B y x)
    (q q' : QuotRadical B P) :
    quotRadicalForm B P hB q q' = quotRadicalForm B P hB q' q := by
  obtain ⟨ψ, rfl⟩ := QuotRadical.mk_surjective B P q
  obtain ⟨φ, rfl⟩ := QuotRadical.mk_surjective B P q'
  rw [quotRadicalForm_mk, quotRadicalForm_mk]
  exact hsymm _ _

end QuotRadical

end StringFormal

namespace StringFormal.NoGhost

/-! ## Part 2: the tower

### The orthogonal complement -/

section OrthComplement

variable {D : ℕ} {R : Type*} [CommRing R]

/-- The orthogonal complement of a submodule of the momentum tower for `Fock.towerPairing`.
This *is* Mathlib's `LinearMap.BilinForm.orthogonal`; the abbreviation exists only to match the
naming of `Fock.orthComplement`.  The form is indefinite, so this is not a complement: it can
meet `W` nontrivially, and for `W = H_phys` the intersection is exactly the null states. -/
noncomputable def towerOrthComplement (η : Fin D → R) (W : Submodule R (TowerFock D R)) :
    Submodule R (TowerFock D R) :=
  LinearMap.BilinForm.orthogonal (Fock.towerPairing η) W

/-- Membership with the tested vector on the **left**, matching `Fock.mem_orthComplement`.
(Mathlib's `mem_orthogonal_iff` puts it on the right; the two agree because
`Fock.towerPairing` is symmetric.) -/
lemma mem_towerOrthComplement (η : Fin D → R) {W : Submodule R (TowerFock D R)}
    {Χ : TowerFock D R} :
    Χ ∈ towerOrthComplement η W ↔ ∀ Ψ ∈ W, Fock.towerPairing η Χ Ψ = 0 := by
  rw [towerOrthComplement, LinearMap.BilinForm.mem_orthogonal_iff]
  exact ⟨fun h Ψ hΨ => by rw [Fock.towerPairing_comm]; exact h Ψ hΨ,
    fun h Ψ hΨ => by rw [Fock.towerPairing_comm]; exact h Ψ hΨ⟩

/-- `Fock.towerPairing` is reflexive, being symmetric. -/
theorem towerPairing_isRefl (η : Fin D → R) : LinearMap.IsRefl (Fock.towerPairing η) :=
  fun x y h => by rw [Fock.towerPairing_comm]; exact h

/-- `Fock.pairing` is reflexive, being symmetric. -/
theorem Fock.pairing_isRefl (η : Fin D → R) : LinearMap.IsRefl (Fock.pairing η) :=
  fun x y h => by rw [Fock.pairing_comm]; exact h

/-- **The hand-rolled `Fock.orthComplement` of `PhysicalStates.lean` is Mathlib's
`LinearMap.BilinForm.orthogonal`.**  Recorded here (rather than acted on) because rewriting
`PhysicalStates.lean` is out of scope for this file. -/
theorem Fock.orthComplement_eq_orthogonal (η : Fin D → R) (W : Submodule R (Fock D R)) :
    Fock.orthComplement η W = LinearMap.BilinForm.orthogonal (Fock.pairing η) W := by
  ext χ
  rw [Fock.mem_orthComplement, LinearMap.BilinForm.mem_orthogonal_iff]
  exact ⟨fun h ψ hψ => by rw [Fock.pairing_comm]; exact h ψ hψ,
    fun h ψ hψ => by rw [Fock.pairing_comm]; exact h ψ hψ⟩

end OrthComplement

/-! ### Spurious and null states on the tower -/

section SpuriousNull

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

variable (η a b : Fin D → R)

/-- **Spurious states on the momentum tower**: the span of the images of the lowering operators
`L_{-n}`, `n ≥ 1`.  As in the single-Fock case (`Fock.spuriousSubmodule`) this does not depend
on the intercept.  Graph node `worldsheet.ocq-spurious-states`. -/
noncomputable def towerSpuriousSubmodule : Submodule R (TowerFock D R) :=
  ⨆ n : ℤ, ⨆ _ : 0 < n, LinearMap.range (towerLop η a b (-n))

variable {η a b}

lemma towerLop_neg_mem_towerSpuriousSubmodule {n : ℤ} (hn : 0 < n) (Ψ : TowerFock D R) :
    towerLop η a b (-n) Ψ ∈ towerSpuriousSubmodule η a b :=
  Submodule.mem_iSup_of_mem n (Submodule.mem_iSup_of_mem hn ⟨Ψ, rfl⟩)

variable (η a b) (a₀ : R)

/-- **Null (zero-norm) physical states on the tower**: physical states orthogonal to every
physical state.  Compare `Fock.nullSubmodule`. -/
noncomputable def towerNullSubmodule : Submodule R (TowerFock D R) :=
  towerPhysSubmodule η a b a₀ ⊓ towerOrthComplement η (towerPhysSubmodule η a b a₀)

variable {η a b a₀}

lemma mem_towerNullSubmodule {Χ : TowerFock D R} :
    Χ ∈ towerNullSubmodule η a b a₀ ↔
      Χ ∈ towerPhysSubmodule η a b a₀ ∧
        ∀ Ψ ∈ towerPhysSubmodule η a b a₀, Fock.towerPairing η Χ Ψ = 0 := by
  rw [towerNullSubmodule, Submodule.mem_inf, mem_towerOrthComplement]

/-- A null state has zero norm. -/
theorem towerPairing_self_eq_zero_of_mem_towerNullSubmodule {Χ : TowerFock D R}
    (hΧ : Χ ∈ towerNullSubmodule η a b a₀) : Fock.towerPairing η Χ Χ = 0 :=
  (mem_towerNullSubmodule.mp hΧ).2 Χ (mem_towerNullSubmodule.mp hΧ).1

theorem towerNullSubmodule_le_towerPhysSubmodule :
    towerNullSubmodule η a b a₀ ≤ towerPhysSubmodule η a b a₀ :=
  inf_le_left

variable (η a b a₀)

/-- **Spurious states are orthogonal to physical states, on the tower.**  The only input is
`L_{-n}^† = L_n` (`Fock.towerPairing_towerLop_right`) together with `L_n Φ = 0` for `n ≥ 1` on
physical states.  Graph node `worldsheet.spurious-orthogonal-to-physical`, first half. -/
theorem towerSpuriousSubmodule_le_towerOrthComplement :
    towerSpuriousSubmodule η a b ≤ towerOrthComplement η (towerPhysSubmodule η a b a₀) := by
  refine iSup_le fun n => iSup_le fun hn => ?_
  rintro Χ ⟨Ψ, rfl⟩
  rw [mem_towerOrthComplement]
  intro Φ hΦ
  rw [Fock.towerPairing_towerLop_left η a b (-n) Ψ Φ, neg_neg,
    (mem_towerPhysSubmodule.mp hΦ).2 n hn, map_zero]

/-- **Spurious ∩ physical ⊆ null, on the tower.**  This is the half of
"spurious ∩ physical = null" that does not need the DDF/light-cone analysis; the reverse
inclusion is part of the no-ghost theorem (see the `gaps` of
`worldsheet.no-ghost-theorem-v4--via-goddard-thorn`). -/
theorem towerSpurious_inf_towerPhys_le_towerNull :
    towerSpuriousSubmodule η a b ⊓ towerPhysSubmodule η a b a₀
      ≤ towerNullSubmodule η a b a₀ := by
  intro Χ hΧ
  rw [Submodule.mem_inf] at hΧ
  exact Submodule.mem_inf.mpr
    ⟨hΧ.2, towerSpuriousSubmodule_le_towerOrthComplement η a b a₀ hΧ.1⟩

variable {η a b a₀}

/-- The concrete form of the previous statement: if `L_{-n} Ψ` (`n ≥ 1`) happens to be physical,
it is a null state. -/
theorem towerLop_neg_apply_mem_towerNullSubmodule {n : ℤ} (hn : 0 < n) (Ψ : TowerFock D R)
    (hmem : towerLop η a b (-n) Ψ ∈ towerPhysSubmodule η a b a₀) :
    towerLop η a b (-n) Ψ ∈ towerNullSubmodule η a b a₀ :=
  towerSpurious_inf_towerPhys_le_towerNull η a b a₀
    (Submodule.mem_inf.mpr ⟨towerLop_neg_mem_towerSpuriousSubmodule hn Ψ, hmem⟩)

end SpuriousNull

/-! ### Shifting by a null state does not change the pairing -/

section AddNull

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]
variable {η a b : Fin D → R} {a₀ : R}

/-- A null state pairs to zero with every physical state. -/
theorem towerPairing_eq_zero_of_mem_towerNullSubmodule {Χ Ψ : TowerFock D R}
    (hΧ : Χ ∈ towerNullSubmodule η a b a₀) (hΨ : Ψ ∈ towerPhysSubmodule η a b a₀) :
    Fock.towerPairing η Χ Ψ = 0 :=
  (mem_towerNullSubmodule.mp hΧ).2 Ψ hΨ

/-- A physical state pairs to zero with every null state. -/
theorem towerPairing_eq_zero_of_mem_towerNullSubmodule' {Ψ Χ : TowerFock D R}
    (hΨ : Ψ ∈ towerPhysSubmodule η a b a₀) (hΧ : Χ ∈ towerNullSubmodule η a b a₀) :
    Fock.towerPairing η Ψ Χ = 0 := by
  rw [Fock.towerPairing_comm]
  exact towerPairing_eq_zero_of_mem_towerNullSubmodule hΧ hΨ

/-- `⟨Ψ + Χ, Φ⟩ = ⟨Ψ, Φ⟩` for `Χ` null and `Φ` physical. -/
theorem towerPairing_add_null_left {Ψ Χ Φ : TowerFock D R}
    (hΧ : Χ ∈ towerNullSubmodule η a b a₀) (hΦ : Φ ∈ towerPhysSubmodule η a b a₀) :
    Fock.towerPairing η (Ψ + Χ) Φ = Fock.towerPairing η Ψ Φ := by
  rw [map_add, LinearMap.add_apply, towerPairing_eq_zero_of_mem_towerNullSubmodule hΧ hΦ,
    add_zero]

/-- `⟨Ψ, Φ + Χ⟩ = ⟨Ψ, Φ⟩` for `Ψ` physical and `Χ` null. -/
theorem towerPairing_add_null_right {Ψ Φ Χ : TowerFock D R}
    (hΨ : Ψ ∈ towerPhysSubmodule η a b a₀) (hΧ : Χ ∈ towerNullSubmodule η a b a₀) :
    Fock.towerPairing η Ψ (Φ + Χ) = Fock.towerPairing η Ψ Φ := by
  rw [map_add, towerPairing_eq_zero_of_mem_towerNullSubmodule' hΨ hΧ, add_zero]

/-- **`⟨Ψ + Χ, Φ + Χ'⟩ = ⟨Ψ, Φ⟩`** for `Ψ, Φ` physical and `Χ, Χ'` null: the inner product of
physical states on the tower depends only on their classes modulo null states.  Graph node
`worldsheet.spurious-orthogonal-to-physical`, second half. -/
theorem towerPairing_add_null {Ψ Φ Χ Χ' : TowerFock D R}
    (hΨ : Ψ ∈ towerPhysSubmodule η a b a₀) (hΦ : Φ ∈ towerPhysSubmodule η a b a₀)
    (hΧ : Χ ∈ towerNullSubmodule η a b a₀) (hΧ' : Χ' ∈ towerNullSubmodule η a b a₀) :
    Fock.towerPairing η (Ψ + Χ) (Φ + Χ') = Fock.towerPairing η Ψ Φ := by
  rw [towerPairing_add_null_right
      (add_mem hΨ (towerNullSubmodule_le_towerPhysSubmodule hΧ)) hΧ',
    towerPairing_add_null_left hΧ hΦ]

/-- Well-definedness, phrased with differences. -/
theorem towerPairing_eq_of_sub_mem_towerNullSubmodule {Ψ Ψ' Φ Φ' : TowerFock D R}
    (hΨ : Ψ ∈ towerPhysSubmodule η a b a₀) (hΦ : Φ ∈ towerPhysSubmodule η a b a₀)
    (hΨ' : Ψ - Ψ' ∈ towerNullSubmodule η a b a₀)
    (hΦ' : Φ - Φ' ∈ towerNullSubmodule η a b a₀) :
    Fock.towerPairing η Ψ Φ = Fock.towerPairing η Ψ' Φ' := by
  have hn1 : Ψ' - Ψ ∈ towerNullSubmodule η a b a₀ := by
    rw [← neg_sub]; exact neg_mem hΨ'
  have hn2 : Φ' - Φ ∈ towerNullSubmodule η a b a₀ := by
    rw [← neg_sub]; exact neg_mem hΦ'
  have e1 : Ψ' = Ψ + (Ψ' - Ψ) := by abel
  have e2 : Φ' = Φ + (Φ' - Φ) := by abel
  rw [e1, e2, towerPairing_add_null hΨ hΦ hn1 hn2]

end AddNull

/-! ### The quotient `H_phys ⧸ H_null` on the tower and the induced form -/

section Quotient

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]
variable (η a b : Fin D → R) (a₀ : R)

/-- `H_null` regarded as a submodule of `H_phys`.  By construction this is the generic
`radicalIn` at `B := Fock.towerPairing η`, `P := towerPhysSubmodule η a b a₀`. -/
noncomputable def towerNullInPhys : Submodule R (towerPhysSubmodule η a b a₀) :=
  radicalIn (Fock.towerPairing η) (towerPhysSubmodule η a b a₀)

lemma mem_towerNullInPhys {Ψ : towerPhysSubmodule η a b a₀} :
    Ψ ∈ towerNullInPhys η a b a₀ ↔
      (Ψ : TowerFock D R) ∈ towerNullSubmodule η a b a₀ := by
  rw [towerNullInPhys, mem_radicalIn, mem_towerNullSubmodule,
    and_iff_right (Ψ.2 : (Ψ : TowerFock D R) ∈ towerPhysSubmodule η a b a₀)]
  exact ⟨fun h Φ hΦ => by rw [Fock.towerPairing_comm]; exact h Φ hΦ,
    fun h Φ hΦ => by rw [Fock.towerPairing_comm]; exact h Φ hΦ⟩

/-- **`H_phys ⧸ H_null` on the momentum tower.** -/
abbrev TowerPhysQuot : Type _ :=
  QuotRadical (Fock.towerPairing η) (towerPhysSubmodule η a b a₀)

/-- The class of a physical tower state in `H_phys ⧸ H_null`. -/
noncomputable abbrev towerPhysMk (Ψ : towerPhysSubmodule η a b a₀) :
    TowerPhysQuot η a b a₀ :=
  QuotRadical.mk (Fock.towerPairing η) (towerPhysSubmodule η a b a₀) Ψ

theorem towerPhysMk_surjective : Function.Surjective (towerPhysMk η a b a₀) :=
  QuotRadical.mk_surjective _ _

/-- **The induced bilinear form on `H_phys ⧸ H_null` of the momentum tower.**  Graph node
`worldsheet.spurious-orthogonal-to-physical`, second half; this is the object whose positive
definiteness the no-ghost theorem asserts at `D = 26`, `a₀ = 1`. -/
noncomputable def towerQuotientPairing :
    LinearMap.BilinForm R (TowerPhysQuot η a b a₀) :=
  quotRadicalForm (Fock.towerPairing η) (towerPhysSubmodule η a b a₀) (towerPairing_isRefl η)

/-- **The computation rule, i.e. well-definedness**: the induced form of two classes is the
tower pairing of any two representatives. -/
@[simp]
theorem towerQuotientPairing_mk (Ψ Φ : towerPhysSubmodule η a b a₀) :
    towerQuotientPairing η a b a₀ (towerPhysMk η a b a₀ Ψ) (towerPhysMk η a b a₀ Φ)
      = Fock.towerPairing η (Ψ : TowerFock D R) (Φ : TowerFock D R) :=
  quotRadicalForm_mk _ _ _ _ _

/-- The induced form is symmetric. -/
theorem towerQuotientPairing_comm (q q' : TowerPhysQuot η a b a₀) :
    towerQuotientPairing η a b a₀ q q' = towerQuotientPairing η a b a₀ q' q :=
  quotRadicalForm_comm _ _ _ (fun x y => Fock.towerPairing_comm η x y) q q'

/-- A null representative gives a vanishing row of the induced form. -/
theorem towerQuotientPairing_mk_eq_zero_of_mem_towerNullSubmodule
    {Ψ : towerPhysSubmodule η a b a₀}
    (hΨ : (Ψ : TowerFock D R) ∈ towerNullSubmodule η a b a₀) (q : TowerPhysQuot η a b a₀) :
    towerQuotientPairing η a b a₀ (towerPhysMk η a b a₀ Ψ) q = 0 :=
  quotRadicalForm_mk_eq_zero_of_mem_radicalIn _ _ _
    ((mem_towerNullInPhys η a b a₀).mpr hΨ) q

/-- **A spurious physical state is invisible in `H_phys ⧸ H_null`.**  Combines
`towerSpurious_inf_towerPhys_le_towerNull` with the previous lemma. -/
theorem towerQuotientPairing_mk_eq_zero_of_mem_towerSpuriousSubmodule
    {Ψ : towerPhysSubmodule η a b a₀}
    (hΨ : (Ψ : TowerFock D R) ∈ towerSpuriousSubmodule η a b) (q : TowerPhysQuot η a b a₀) :
    towerQuotientPairing η a b a₀ (towerPhysMk η a b a₀ Ψ) q = 0 :=
  towerQuotientPairing_mk_eq_zero_of_mem_towerNullSubmodule η a b a₀
    (towerSpurious_inf_towerPhys_le_towerNull η a b a₀ (Submodule.mem_inf.mpr ⟨hΨ, Ψ.2⟩)) q

end Quotient

end StringFormal.NoGhost
