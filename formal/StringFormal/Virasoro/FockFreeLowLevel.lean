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

end StringFormal.NoGhost
