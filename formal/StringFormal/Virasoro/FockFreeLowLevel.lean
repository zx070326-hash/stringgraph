/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import StringFormal.Virasoro.GenericIndependence
import StringFormal.NoGhost.PhysicalStates

/-!
# Freeness of the Fock module over `Vir⁻` at levels `N ≤ 4`

Graph nodes (low-level *instance* of): `worldsheet.verma-module-free-over-negative-part`,
`math.kac-determinant-v2`.
Convention: `conv.virasoro-standard`, `conv.alpha-prime-regge`.

## What this file proves

For the Fock space of `D` free bosons at a fixed momentum (encoded by the zero mode `a^μ`),
the `p(N)` standard descendants

* `N = 1`: `L₋₁|k⟩`
* `N = 2`: `L₋₂|k⟩`, `L₋₁²|k⟩`
* `N = 3`: `L₋₃|k⟩`, `L₋₂L₋₁|k⟩`, `L₋₁³|k⟩`
* `N = 4`: `L₋₄|k⟩`, `L₋₃L₋₁|k⟩`, `L₋₂²|k⟩`, `L₋₂L₋₁²|k⟩`, `L₋₁⁴|k⟩`

are **linearly independent in the Fock space** whenever the Kac determinant of level `N`,
evaluated at the Fock values `c = D` and `h = α'k² = ½ α₀²`, is nonzero
(`Fock.linearIndependent_fockDesc{1,2,3,4}`).  That is exactly the statement "the Fock module
is free over `U(Vir⁻)` in degrees `≤ 4`", restricted to a single momentum.

## Route

Not a new Gram computation.  The whole point is to *reuse* the Verma-side Kac determinants
`IsContravariant.gram_det_descFamily{2,3,4}`:

1. `FockVir` makes `Fock D R` a genuine `LieRingModule`/`LieModule` over `VirasoroAlgebra R`
   via the Sugawara representation `Fock.virRep` (whose Lie-homomorphism property is
   `Fock.virRep_lie`, which needs `η² = 1`).  A type synonym is unavoidable: the action
   depends on the parameters `η, a`, which are invisible in the type `Fock D R`, so no
   instance on `Fock D R` itself could be found by typeclass resolution.
2. The Fock vacuum `1` is a highest weight vector of weight `(c, h) = (D, ½α₀²)`
   (`Fock.isHighestWeightVector_one`), so the universal property of the Verma module gives an
   equivariant `Fock.vermaToFock : V(D, ½α₀²) →ₗ[R] Fock D R` sending `|c,h⟩ ↦ |k⟩`.
3. Pulling the Fock form `Fock.pairing η` back along that map gives a **normalised
   contravariant form on the Verma module** (`Fock.fockForm_isContravariant`,
   `Fock.fockForm_hwv_hwv`).  Note this *constructs* what `Shapovalov.lean` could only assume:
   the existence of a normalised contravariant form, equivalently `V(c,h) ≠ 0`, is here a
   theorem at `(c,h) = (D, ½α₀²)` for every `D` and every `a`, because the Fock space provides
   the required realisation (`Fock.hwv_ne_zero`).
4. Gram matrices transport on the nose (`Fock.gramMatrix_vermaToFock`), so the Fock Gram
   determinant of the standard descendants *is* the Kac determinant at `(D, ½α₀²)`, and
   `linearIndependent_of_gram_det_ne_zero` finishes.

## Mathematical gaps (for the dependency graph)

1. **Low levels only.**  `N ≤ 4`, because the Verma-side Kac determinant is only formalised for
   `N ≤ 4` (`ShapovalovLevelThree.lean`, `ShapovalovLevelFour.lean`).  General `N` needs the
   general Kac determinant formula, which needs PBW; see `BLUEPRINT-noghost.md` §B.2.  Nothing
   here shortens the `no-ghost-theorem-v4` bottleneck.
2. **Sufficient, not necessary.**  Nonvanishing of the Kac determinant is a *sufficient*
   condition for independence in the Fock module; the standard descendants can be independent
   in `Fock` while the Shapovalov form degenerates (the Fock module is not the Verma module:
   `vermaToFock` need not be injective, and independence of the images is what is proved, not
   injectivity).
3. **One momentum, no zero mode operator.**  Inherited from `Sugawara.lean`: `a^μ` is a
   parameter, `x^μ` is absent, so this is freeness of a single-momentum Fock module.
4. **Levels are treated separately.**  Independence of the union over `N ≤ 4` is not stated;
   it would follow from `L₀`-eigenvalue orthogonality, which is available
   (`IsContravariant.eq_zero_of_level_ne`) but not assembled here.

## File placement

The file is in `Virasoro/` because that is the path assigned to the task, but it imports
`NoGhost/`; its natural home is `NoGhost/`.  Declarations live in `StringFormal.NoGhost.Fock`.

## Status

Complete, no `sorry`; axioms are `propext`, `Classical.choice`, `Quot.sound` only.
-/

namespace StringFormal.NoGhost

open StringFormal.Virasoro

/-! ### The Fock space as a Virasoro module -/

section FockVir

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

set_option linter.unusedVariables false in
/-- `Fock D R` carrying the Sugawara Virasoro-module structure attached to the metric signs
`η` and the zero mode `a`.  A type synonym is needed because typeclass resolution cannot
recover `η` and `a` from `Fock D R`; `hη` is a parameter for the same reason (the Lie
homomorphism property `Fock.virRep_lie` needs it). -/
def FockVir (D : ℕ) (R : Type*) [CommRing R] [Algebra ℚ R] (η a : Fin D → R)
    (hη : ∀ μ, η μ * η μ = 1) : Type _ :=
  Fock D R

namespace FockVir

noncomputable section

variable {η a : Fin D → R} {hη : ∀ μ, η μ * η μ = 1}

instance : AddCommGroup (FockVir D R η a hη) := inferInstanceAs (AddCommGroup (Fock D R))

instance : Module R (FockVir D R η a hη) := inferInstanceAs (Module R (Fock D R))

/-- The identity linear map `FockVir → Fock`, used to state results about the Fock space
without mentioning the synonym. -/
def toFock : FockVir D R η a hη →ₗ[R] Fock D R := LinearMap.id

/-- The identity linear map `Fock → FockVir`. -/
def ofFock : Fock D R →ₗ[R] FockVir D R η a hη := LinearMap.id

@[simp] lemma toFock_ofFock (v : Fock D R) :
    toFock (ofFock (η := η) (a := a) (hη := hη) v) = v := rfl

@[simp] lemma ofFock_toFock (v : FockVir D R η a hη) : ofFock (toFock v) = v := rfl

lemma toFock_injective :
    Function.Injective (toFock : FockVir D R η a hη →ₗ[R] Fock D R) := fun _ _ h => h

lemma ofFock_injective :
    Function.Injective (ofFock : Fock D R →ₗ[R] FockVir D R η a hη) := fun _ _ h => h

/-- The Sugawara action of the Virasoro algebra on the Fock space. -/
instance instLieRingModule : LieRingModule (VirasoroAlgebra R) (FockVir D R η a hη) where
  bracket X v := ofFock (Fock.virRep η a X (toFock v))
  add_lie X Y v := by
    show ofFock (Fock.virRep η a (X + Y) (toFock v)) = _
    rw [map_add]
    show ofFock (Fock.virRep η a X (toFock v) + Fock.virRep η a Y (toFock v)) = _
    rw [map_add]
  lie_add X v w := by
    show ofFock (Fock.virRep η a X (toFock (v + w))) = _
    rw [map_add, map_add, map_add]
  leibniz_lie X Y v := by
    have key : Fock.virRep η a X (Fock.virRep η a Y (toFock v))
        = Fock.virRep η a ⁅X, Y⁆ (toFock v)
          + Fock.virRep η a Y (Fock.virRep η a X (toFock v)) := by
      rw [Fock.virRep_lie η a hη, LieRing.of_associative_ring_bracket, LinearMap.sub_apply,
        Module.End.mul_apply, Module.End.mul_apply]
      abel
    show ofFock (Fock.virRep η a X (toFock (ofFock (Fock.virRep η a Y (toFock v)))))
      = ofFock (Fock.virRep η a ⁅X, Y⁆ (toFock v))
        + ofFock (Fock.virRep η a Y (toFock (ofFock (Fock.virRep η a X (toFock v)))))
    rw [toFock_ofFock, toFock_ofFock, key, map_add]

instance instLieModule : LieModule R (VirasoroAlgebra R) (FockVir D R η a hη) where
  smul_lie t X v := by
    show ofFock (Fock.virRep η a (t • X) (toFock v)) = t • ofFock (Fock.virRep η a X (toFock v))
    rw [map_smul]
    show ofFock (t • Fock.virRep η a X (toFock v)) = _
    rw [map_smul]
  lie_smul t X v := by
    show ofFock (Fock.virRep η a X (toFock (t • v))) = t • ofFock (Fock.virRep η a X (toFock v))
    rw [map_smul, map_smul, map_smul]

lemma lie_def (X : VirasoroAlgebra R) (v : FockVir D R η a hη) :
    ⁅X, v⁆ = ofFock (Fock.virRep η a X (toFock v)) := rfl

@[simp] lemma toFock_lie_lgen (n : ℤ) (v : FockVir D R η a hη) :
    toFock ⁅VirasoroAlgebra.lgen R n, v⁆ = Fock.Lop η a n (toFock v) := by
  rw [lie_def, toFock_ofFock, Fock.virRep_lgen]

@[simp] lemma toFock_lie_cgen (v : FockVir D R η a hη) :
    toFock ⁅VirasoroAlgebra.cgen R, v⁆ = (D : R) • toFock v := by
  rw [lie_def, toFock_ofFock, Fock.virRep_cgen]
  rfl

end

end FockVir

end FockVir

/-! ### The Fock vacuum as a highest weight vector -/

namespace Fock

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] (η a : Fin D → R)

/-- The Virasoro weight of the Fock vacuum: `h = ½ α₀² = α'k²`.  There is no normal-ordering
constant in this convention (`Fock.Lop_zero_apply_one`). -/
noncomputable def vacuumWeight : R := invTwo R * zeroModeSq η a

lemma vacuumWeight_def : vacuumWeight η a = invTwo R * zeroModeSq η a := rfl

variable {η a}

/-- **The Fock vacuum `|k⟩` is a highest weight vector of weight `(c, h) = (D, α'k²)`.**
This packages `Fock.virRep_cgen` (central charge `D`), `Fock.Lop_zero_apply_one`
(`L₀|k⟩ = α'k²|k⟩`) and `Fock.Lop_apply_one_of_pos` (`L_n|k⟩ = 0` for `n > 0`). -/
theorem isHighestWeightVector_one (hη : ∀ μ, η μ * η μ = 1) :
    IsHighestWeightVector R (D : R) (vacuumWeight η a) (FockVir D R η a hη)
      (FockVir.ofFock (1 : Fock D R)) where
  lie_cgen := FockVir.toFock_injective (by
    rw [FockVir.toFock_lie_cgen, map_smul, FockVir.toFock_ofFock])
  lie_lgen_zero := FockVir.toFock_injective (by
    rw [FockVir.toFock_lie_lgen, FockVir.toFock_ofFock, map_smul, FockVir.toFock_ofFock,
      Lop_zero_apply_one, vacuumWeight_def])
  lie_lgen_pos n hn := FockVir.toFock_injective (by
    rw [FockVir.toFock_lie_lgen, FockVir.toFock_ofFock, Lop_apply_one_of_pos η a hn, map_zero])

/-- The Virasoro-equivariant map `V(D, α'k²) → Fock D R` sending `|c,h⟩` to the vacuum `|k⟩`,
from the universal property of the Verma module (`StringFormal.Virasoro.vermaLift`). -/
noncomputable def vermaToFock (hη : ∀ μ, η μ * η μ = 1) :
    VermaModule R (D : R) (vacuumWeight η a) →ₗ[R] Fock D R :=
  (FockVir.toFock (η := η) (a := a) (hη := hη)).comp
    (vermaLift R (D : R) (vacuumWeight η a) (FockVir D R η a hη) (isHighestWeightVector_one hη))

variable {hη : ∀ μ, η μ * η μ = 1}

@[simp] lemma vermaToFock_hwv :
    vermaToFock hη (hwv R (D : R) (vacuumWeight η a)) = (1 : Fock D R) := by
  rw [vermaToFock, LinearMap.comp_apply, vermaLift_hwv, FockVir.toFock_ofFock]

/-- Equivariance in the form actually used: `L_n` on the Verma side becomes the Sugawara `L_n`
on the Fock side. -/
@[simp] lemma vermaToFock_lie_lgen (n : ℤ) (w : VermaModule R (D : R) (vacuumWeight η a)) :
    vermaToFock hη ⁅VirasoroAlgebra.lgen R n, w⁆ = Lop η a n (vermaToFock hη w) := by
  rw [vermaToFock, LinearMap.comp_apply, LinearMap.comp_apply, vermaLift_lie,
    FockVir.toFock_lie_lgen]

/-- **`V(D, α'k²) ≠ 0` for every `D` and every momentum**, because the Fock realisation sends
`|c,h⟩` to the vacuum, which is nonzero.  This is one of the open items of the `pbw-verma`
TODO, settled here at these particular weights (and only there). -/
theorem hwv_ne_zero [Nontrivial R] (hη : ∀ μ, η μ * η μ = 1) :
    hwv R (D : R) (vacuumWeight η a) ≠ 0 := by
  intro hz
  have h1 : (1 : Fock D R) = 0 := by
    rw [← vermaToFock_hwv (hη := hη), hz, map_zero]
  exact one_ne_zero h1

/-! ### The Fock form as the Shapovalov form -/

/-- The Fock bilinear form pulled back to `V(D, α'k²)` along `vermaToFock`. -/
noncomputable def fockForm (hη : ∀ μ, η μ * η μ = 1) :
    VermaModule R (D : R) (vacuumWeight η a) →ₗ[R]
      VermaModule R (D : R) (vacuumWeight η a) →ₗ[R] R :=
  (pairing η).compl₁₂ (vermaToFock hη) (vermaToFock hη)

@[simp] lemma fockForm_apply (x y : VermaModule R (D : R) (vacuumWeight η a)) :
    fockForm hη x y = pairing η (vermaToFock hη x) (vermaToFock hη y) := rfl

/-- **The pullback of the Fock form is contravariant**, because `L_m† = L_{-m}` on the Fock
space (`Fock.pairing_Lop_left`) and `vermaToFock` is Virasoro-equivariant. -/
theorem fockForm_isContravariant :
    IsContravariant R (D : R) (vacuumWeight η a) (fockForm hη) := by
  intro n x y
  rw [fockForm_apply, fockForm_apply, vermaToFock_lie_lgen, vermaToFock_lie_lgen,
    pairing_Lop_left]

/-- The pullback form is normalised: `⟨|c,h⟩, |c,h⟩⟩ = ⟨|k⟩, |k⟩⟩ = 1`.  Together with
`fockForm_isContravariant` this says the Fock form *is* the Shapovalov form of
`V(D, α'k²)` (`StringFormal.Virasoro.eq_of_isContravariant`). -/
@[simp] theorem fockForm_hwv_hwv :
    fockForm hη (hwv R (D : R) (vacuumWeight η a)) (hwv R (D : R) (vacuumWeight η a)) = 1 := by
  rw [fockForm_apply, vermaToFock_hwv, pairing_one_one]

/-- Gram matrices transport along `vermaToFock` on the nose. -/
lemma gramMatrix_vermaToFock {ι : Type*} [Fintype ι] [DecidableEq ι]
    (v : ι → VermaModule R (D : R) (vacuumWeight η a)) :
    gramMatrix (pairing η) (fun i => vermaToFock hη (v i)) = gramMatrix (fockForm hη) v := rfl

/-! ### The Kac determinant polynomials for `N ≤ 4` -/

section KacPolynomials

variable (c hw : R)

/-- Level-1 Kac determinant `2h` (the `1 × 1` Gram determinant; it does not involve `c`). -/
def kacDet1 : R := 2 * hw

/-- Level-2 Kac determinant `2h(16h² + 2h(c-5) + c)`; see
`StringFormal.Virasoro.IsContravariant.gram_det_descFamily2`. -/
def kacDet2 : R := 2 * hw * (16 * hw ^ 2 + 2 * hw * (c - 5) + c)

/-- Level-3 Kac determinant `48h²(16h² + 2h(c-5) + c)(3h² + h(c-7) + c + 2)`; see
`StringFormal.Virasoro.IsContravariant.gram_det_descFamily3`. -/
def kacDet3 : R :=
  48 * hw ^ 2 * (16 * hw ^ 2 + 2 * hw * (c - 5) + c) * (3 * hw ^ 2 + hw * (c - 7) + c + 2)

/-- Level-4 Kac determinant
`384h³(8h + c - 1)(16h² + 2h(c-5) + c)²(3h² + h(c-7) + c + 2)(16h² + 10ch - 82h + 15c + 66)`;
see `StringFormal.Virasoro.IsContravariant.gram_det_descFamily4`. -/
def kacDet4 : R :=
  384 * hw ^ 3 * (8 * hw + c - 1) * (16 * hw ^ 2 + 2 * hw * (c - 5) + c) ^ 2
    * (3 * hw ^ 2 + hw * (c - 7) + c + 2)
    * (16 * hw ^ 2 + 10 * c * hw - 82 * hw + 15 * c + 66)

end KacPolynomials

/-! ### The standard Fock descendants and their Gram determinants -/

section Descendants

variable (η a)

/-- `L₋₁|k⟩`. -/
noncomputable def fockDesc1 : Fin 1 → Fock D R := ![Lop η a (-1) 1]

/-- `L₋₂|k⟩`, `L₋₁²|k⟩`. -/
noncomputable def fockDesc2 : Fin 2 → Fock D R :=
  ![Lop η a (-2) 1, Lop η a (-1) (Lop η a (-1) 1)]

/-- `L₋₃|k⟩`, `L₋₂L₋₁|k⟩`, `L₋₁³|k⟩`. -/
noncomputable def fockDesc3 : Fin 3 → Fock D R :=
  ![Lop η a (-3) 1, Lop η a (-2) (Lop η a (-1) 1),
    Lop η a (-1) (Lop η a (-1) (Lop η a (-1) 1))]

/-- `L₋₄|k⟩`, `L₋₃L₋₁|k⟩`, `L₋₂²|k⟩`, `L₋₂L₋₁²|k⟩`, `L₋₁⁴|k⟩`. -/
noncomputable def fockDesc4 : Fin 5 → Fock D R :=
  ![Lop η a (-4) 1,
    Lop η a (-3) (Lop η a (-1) 1),
    Lop η a (-2) (Lop η a (-2) 1),
    Lop η a (-2) (Lop η a (-1) (Lop η a (-1) 1)),
    Lop η a (-1) (Lop η a (-1) (Lop η a (-1) (Lop η a (-1) 1)))]

variable {η a}

lemma vermaToFock_descFamily2 :
    (fun i => vermaToFock hη (descFamily2 R (D : R) (vacuumWeight η a) i)) = fockDesc2 η a := by
  funext i
  fin_cases i <;>
    simp [descFamily2, fockDesc2, desc2, desc11, desc1]

lemma vermaToFock_descFamily3 :
    (fun i => vermaToFock hη (descFamily3 R (D : R) (vacuumWeight η a) i)) = fockDesc3 η a := by
  funext i
  fin_cases i <;>
    simp [descFamily3, fockDesc3, desc3, desc21, desc111, desc11, desc1]

lemma vermaToFock_descFamily4 :
    (fun i => vermaToFock hη (descFamily4 R (D : R) (vacuumWeight η a) i)) = fockDesc4 η a := by
  funext i
  fin_cases i <;>
    simp [descFamily4, fockDesc4, desc4, desc31, desc22, desc211, desc1111, desc111, desc11,
      desc1, desc2]

variable (hη)

include hη in
/-- **The level-2 Fock Gram determinant is the Kac determinant at `(c, h) = (D, α'k²)`.** -/
theorem gram_det_fockDesc2 :
    (gramMatrix (pairing η) (fockDesc2 η a)).det = kacDet2 (D : R) (vacuumWeight η a) := by
  rw [← vermaToFock_descFamily2 (hη := hη), gramMatrix_vermaToFock, kacDet2]
  exact (fockForm_isContravariant (hη := hη)).gram_det_descFamily2 fockForm_hwv_hwv

include hη in
/-- **The level-3 Fock Gram determinant is the Kac determinant at `(c, h) = (D, α'k²)`.** -/
theorem gram_det_fockDesc3 :
    (gramMatrix (pairing η) (fockDesc3 η a)).det = kacDet3 (D : R) (vacuumWeight η a) := by
  rw [← vermaToFock_descFamily3 (hη := hη), gramMatrix_vermaToFock, kacDet3]
  exact (fockForm_isContravariant (hη := hη)).gram_det_descFamily3 fockForm_hwv_hwv

include hη in
/-- **The level-4 Fock Gram determinant is the Kac determinant at `(c, h) = (D, α'k²)`.** -/
theorem gram_det_fockDesc4 :
    (gramMatrix (pairing η) (fockDesc4 η a)).det = kacDet4 (D : R) (vacuumWeight η a) := by
  rw [← vermaToFock_descFamily4 (hη := hη), gramMatrix_vermaToFock, kacDet4]
  exact (fockForm_isContravariant (hη := hη)).gram_det_descFamily4 fockForm_hwv_hwv

/-- The level-1 Verma descendant packaged as a `Fin 1`-family, so that the level-1 case can be
run through the same Gram machinery. -/
noncomputable def vermaDesc1 : Fin 1 → VermaModule R (D : R) (vacuumWeight η a) :=
  ![desc1 R (D : R) (vacuumWeight η a)]

lemma vermaToFock_vermaDesc1 :
    (fun i => vermaToFock hη (vermaDesc1 (η := η) (a := a) i)) = fockDesc1 η a := by
  funext i
  fin_cases i
  simp [vermaDesc1, fockDesc1, desc1]

include hη in
/-- **The level-1 Fock Gram determinant is `2α'k²`**: `⟨L₋₁|k⟩, L₋₁|k⟩⟩ = 2h`. -/
theorem gram_det_fockDesc1 :
    (gramMatrix (pairing η) (fockDesc1 η a)).det = kacDet1 (vacuumWeight η a) := by
  rw [← vermaToFock_vermaDesc1 (hη := hη), gramMatrix_vermaToFock, kacDet1, Matrix.det_fin_one]
  simp only [gramMatrix_apply, vermaDesc1, Matrix.cons_val_zero]
  exact (fockForm_isContravariant (hη := hη)).gram_level_one fockForm_hwv_hwv

end Descendants

/-! ### Freeness over `Vir⁻` at levels `N ≤ 4` -/

section Freeness

variable [NoZeroDivisors R]
variable (hη)

include hη in
/-- **Level 1.**  `L₋₁|k⟩` is nonzero (indeed linearly independent as a one-element family) as
soon as the level-1 Kac determinant `2α'k²` is nonzero. -/
theorem linearIndependent_fockDesc1 (hdet : kacDet1 (vacuumWeight η a) ≠ 0) :
    LinearIndependent R (fockDesc1 η a) :=
  linearIndependent_of_gram_det_ne_zero (pairing η) _
    (by rw [gram_det_fockDesc1 hη]; exact hdet)

include hη in
/-- **Level 2: the Fock module is free over `Vir⁻` in degree 2 at generic momentum.**
`L₋₂|k⟩` and `L₋₁²|k⟩` are linearly independent in the Fock space whenever the level-2 Kac
determinant at `(c, h) = (D, α'k²)` is nonzero. -/
theorem linearIndependent_fockDesc2 (hdet : kacDet2 (D : R) (vacuumWeight η a) ≠ 0) :
    LinearIndependent R (fockDesc2 η a) :=
  linearIndependent_of_gram_det_ne_zero (pairing η) _
    (by rw [gram_det_fockDesc2 hη]; exact hdet)

include hη in
/-- **Level 3.**  The three standard descendants `L₋₃|k⟩`, `L₋₂L₋₁|k⟩`, `L₋₁³|k⟩` are linearly
independent in the Fock space when the level-3 Kac determinant at `(D, α'k²)` is nonzero. -/
theorem linearIndependent_fockDesc3 (hdet : kacDet3 (D : R) (vacuumWeight η a) ≠ 0) :
    LinearIndependent R (fockDesc3 η a) :=
  linearIndependent_of_gram_det_ne_zero (pairing η) _
    (by rw [gram_det_fockDesc3 hη]; exact hdet)

include hη in
/-- **Level 4.**  The five standard descendants are linearly independent in the Fock space when
the level-4 Kac determinant at `(D, α'k²)` is nonzero. -/
theorem linearIndependent_fockDesc4 (hdet : kacDet4 (D : R) (vacuumWeight η a) ≠ 0) :
    LinearIndependent R (fockDesc4 η a) :=
  linearIndependent_of_gram_det_ne_zero (pairing η) _
    (by rw [gram_det_fockDesc4 hη]; exact hdet)

end Freeness

/-! ### The criterion on the physical mass shell (`D = 26`, intercept `a₀ = 1`)

A level-`N` physical state of the open bosonic string satisfies `α'k² + N = a₀`, i.e.
`h = a₀ - N`.  At the critical dimension `D = c = 26` with the standard intercept `a₀ = 1`
the Kac determinant of level `N` evaluated at `h = 1 - N` is

| `N` | `h` | `det_N` |
|---|---|---|
| 1 | `0`  | `0` |
| 2 | `-1` | `0` |
| 3 | `-2` | `2304` |
| 4 | `-3` | `2649563136` |

So **the Gram criterion of this file is vacuous at exactly the two levels where the bosonic
string has its null states** (the `N = 1` photon null state `L₋₁|k⟩` at `α'k² = 0` and the
`N = 2` null state at `α'k² = -1`), and is decisive at `N = 3, 4`.  Vanishing of the
determinant does *not* say the descendants are dependent — it says this sufficient condition
gives nothing there; on the `N = 1` shell they really are dependent only in the degenerate
sense that `L₋₁|k⟩` is a null *vector of the form*, not that it is zero.
-/

section MassShell

variable (R)

omit [Algebra ℚ R] in
/-- Level-1: on the `N = 1` mass shell (`h = a₀ - 1 = 0`) the criterion is vacuous. -/
theorem kacDet1_massShell_26 : kacDet1 ((1 : R) - 1) = 0 := by
  rw [kacDet1]; ring

omit [Algebra ℚ R] in
/-- Level-2: on the `N = 2` mass shell (`c = 26`, `h = a₀ - 2 = -1`) the criterion is vacuous.
Note `16h² + 2h(c-5) + c = 16 - 42 + 26 = 0` there: it is the *second* factor that vanishes,
not `h`. -/
theorem kacDet2_massShell_26 : kacDet2 (26 : R) ((1 : R) - 2) = 0 := by
  rw [kacDet2]; ring

omit [Algebra ℚ R] in
/-- Level-3: on the `N = 3` mass shell (`c = 26`, `h = a₀ - 3 = -2`) the Kac determinant is
`2304 ≠ 0`, so the criterion *is* decisive. -/
theorem kacDet3_massShell_26 : kacDet3 (26 : R) ((1 : R) - 3) = 2304 := by
  rw [kacDet3]; ring

omit [Algebra ℚ R] in
/-- Level-4: on the `N = 4` mass shell (`c = 26`, `h = a₀ - 4 = -3`) the Kac determinant is
`2649563136 = 2⁸·3⁶·… ≠ 0`. -/
theorem kacDet4_massShell_26 : kacDet4 (26 : R) ((1 : R) - 4) = 2649563136 := by
  rw [kacDet4]; ring

variable {R}

/-- **`N = 3` at `D = 26` on shell.**  For a level-3 physical state of the critical open bosonic
string (`α'k² = a₀ - 3 = -2` with `a₀ = 1`), the three standard descendants
`L₋₃|k⟩, L₋₂L₋₁|k⟩, L₋₁³|k⟩` are linearly independent in the Fock space. -/
theorem linearIndependent_fockDesc3_massShell_26 [NoZeroDivisors R] [CharZero R]
    (hη : ∀ μ, η μ * η μ = 1) (hD : D = 26) (hk : vacuumWeight η a = 1 - 3) :
    LinearIndependent R (fockDesc3 η a) := by
  refine linearIndependent_fockDesc3 hη ?_
  rw [hk, hD]
  have hcast : ((26 : ℕ) : R) = 26 := by norm_num
  rw [hcast, kacDet3_massShell_26]
  norm_num

/-- **`N = 4` at `D = 26` on shell.**  Same for the five standard level-4 descendants at
`α'k² = a₀ - 4 = -3`. -/
theorem linearIndependent_fockDesc4_massShell_26 [NoZeroDivisors R] [CharZero R]
    (hη : ∀ μ, η μ * η μ = 1) (hD : D = 26) (hk : vacuumWeight η a = 1 - 4) :
    LinearIndependent R (fockDesc4 η a) := by
  refine linearIndependent_fockDesc4 hη ?_
  rw [hk, hD]
  have hcast : ((26 : ℕ) : R) = 26 := by norm_num
  rw [hcast, kacDet4_massShell_26]
  norm_num

end MassShell

end Fock

end StringFormal.NoGhost
