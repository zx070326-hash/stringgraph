/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.DDF
import StringFormal.NoGhost.PhysicalStates

/-!
# The bilinear form on the DDF momentum tower

Graph node: `worldsheet.momentum-tower-fock-space`, items (2) (the indefinite bilinear form on
the tower) and (4) (the adjoint of the zero-mode shift `e^{i n k_0·x}`).
Convention: `conv.metric-signature` (mostly-plus), `η` an arbitrary sign vector with
`η μ * η μ = 1`; the form is `R`-bilinear, **not** sesquilinear, so no reality assumption on
`η` or on the momenta is used anywhere below.

## What is here

`StringFormal/NoGhost/DDF.lean` builds the momentum tower `TowerFock D R = ℤ →₀ Fock D R`,
i.e. `⨁_{j ∈ ℤ} F(a + j·b)`, together with the operators acting on it: the zero-mode shift
`towerShift n = e^{i n k_0·x}` (rung `j ↦ j + n`), and the momentum-preserving `towerMode`
(`α^μ_p`) and `towerLop` (`L_n`), both of the diagonal form `towerDiag`.  What was missing is
the inner product.  This file adds it:

* `Fock.towerPairing η` — the bilinear form `⟨v, w⟩ = Σ_j ⟨v j, w j⟩` on `TowerFock D R`,
  as a genuine `LinearMap.BilinForm R (TowerFock D R)` (so bilinearity is by construction;
  `towerPairing_add_left` and friends just expose it).
* `Fock.towerPairing_single_single_of_ne` — **different rungs are orthogonal**: the tower is
  an orthogonal direct sum of its momentum levels.  This is the algebraic content of
  "states of different momentum do not pair", which on the DDF tower replaces the
  `δ^D(k - k')` of the continuum treatment.
* `Fock.towerPairing_comm` — symmetry, inherited rung-by-rung from `Fock.pairing_comm`.
* `Fock.towerPairing_towerShift_left` — **`(e^{i n k_0·x})^† = e^{-i n k_0·x}`**, graph item
  (4).  Note this is an adjointness statement between *different* rungs, so unlike the
  oscillator adjoints it is not a consequence of anything in `Fock.lean`; it is the statement
  that the rung-sum is taken with unit weights.
* `Fock.towerPairing_towerMode_left` — `(α^μ_p)^† = α^μ_{-p}` on the tower, inherited
  rung-by-rung from `Fock.pairing_mode_left`.  Note that rung `j` carries its own momentum
  `towerMomentum a b j`, and `α^μ_0` is the *rung-dependent* scalar `(a + j b)^μ`; the
  statement is nevertheless uniform in `j` because `towerMode` does not move rungs.
* `Fock.towerPairing_towerLop_left` — **`L_m^† = L_{-m}` on the tower**, inherited from
  `Fock.pairing_Lop_left`.

Also proved here, because `DDF.lean` only has the action on rung-supported vectors
(`towerShift_single`, `towerDiag_single`): the pointwise formulas `towerShift_apply`,
`towerDiag_apply`, `towerMode_apply`, `towerLop_apply`.

## Gaps

1. **No positivity, no Hilbert space.**  `towerPairing` is a bilinear form over a commutative
   ring; there is no topology, no completion, and no claim that it is nondegenerate.  The
   no-ghost theorem needs positivity on the DDF subspace, which is not here.
2. **(Resolved in `VertexAdjoint.lean`: `towerPairing_towerVertex_left`, `towerPairing_ddfOp_left`.)** Original text:
   **The vertex operator is not yet self-adjoint.**  `towerVertex` is `towerShift n` composed
   with an oscillator part, and its adjoint involves the oscillator adjoint of `vertexOsc`,
   which is not proved (graph node `worldsheet.vertex-operator-adjoint`).  Consequently the
   adjointness of the DDF operators `A^i_n` themselves is **not** available: only the three
   adjoints above are.
3. **`towerLop` needs `[Algebra ℚ R]`** (as in `Sugawara.lean`, because of the `½` in
   `L_n = ½ Σ :α·α:`); `towerPairing`, `towerShift` and `towerMode` do not.
-/

namespace StringFormal.NoGhost

open MvPolynomial

section TowerApply

variable {D : ℕ} {R : Type*} [CommRing R]

/-- Pointwise formula for the zero-mode shift: `(e^{i n k_0·x} w)_j = w_{j - n}`. -/
lemma towerShift_apply (n : ℤ) (w : TowerFock D R) (j : ℤ) :
    towerShift D R n w j = w (j - n) := by
  have hf : Function.Injective (fun i : ℤ => i + n) := fun x y h => by
    simpa using h
  have h : towerShift D R n w ((j - n) + n) = w (j - n) := by
    rw [towerShift, Finsupp.lmapDomain_apply]
    exact Finsupp.mapDomain_apply hf w (j - n)
  simpa using h

/-- Pointwise formula for a diagonal operator on the tower. -/
lemma towerDiag_apply (f : ℤ → Module.End R (Fock D R)) (w : TowerFock D R) (j : ℤ) :
    towerDiag f w j = f j (w j) := by
  have key : (Finsupp.lapply j).comp (towerDiag f) = (f j).comp (Finsupp.lapply j) := by
    refine Finsupp.lhom_ext fun i P => ?_
    simp only [LinearMap.comp_apply, Finsupp.lapply_apply, towerDiag_single,
      Finsupp.single_apply]
    by_cases h : i = j
    · subst h; simp
    · rw [if_neg h, if_neg h, map_zero]
  exact LinearMap.congr_fun key w

/-- Pointwise formula for `α^μ_p` on the tower: rung `j` uses rung `j`'s momentum. -/
lemma towerMode_apply (η a b : Fin D → R) (μ : Fin D) (p : ℤ) (w : TowerFock D R) (j : ℤ) :
    towerMode η a b μ p w j = Fock.mode η (towerMomentum a b j) μ p (w j) :=
  towerDiag_apply _ w j

/-- Pointwise formula for `L_n` on the tower. -/
lemma towerLop_apply [Algebra ℚ R] (η a b : Fin D → R) (n : ℤ) (w : TowerFock D R) (j : ℤ) :
    towerLop η a b n w j = Fock.Lop η (towerMomentum a b j) n (w j) :=
  towerDiag_apply _ w j

end TowerApply

namespace Fock

section TowerPairing

variable {D : ℕ} {R : Type*} [CommRing R]

/-- **The bilinear form on the DDF momentum tower**: `⟨v, w⟩ = Σ_j ⟨v_j, w_j⟩`, the
orthogonal direct sum of the single-momentum forms `Fock.pairing η` over the rungs.
Graph node `worldsheet.momentum-tower-fock-space` item (2). -/
noncomputable def towerPairing (η : Fin D → R) :
    LinearMap.BilinForm R (TowerFock D R) :=
  Finsupp.lsum R fun j => (pairing η).compl₂ (Finsupp.lapply j)

/-- The defining sum: only the rungs in the support of `v` contribute. -/
lemma towerPairing_apply (η : Fin D → R) (v w : TowerFock D R) :
    towerPairing η v w = v.sum fun j P => pairing η P (w j) := by
  rw [towerPairing, Finsupp.lsum_apply]
  simp only [Finsupp.sum, LinearMap.sum_apply, LinearMap.compl₂_apply, Finsupp.lapply_apply]

@[simp]
lemma towerPairing_single_left (η : Fin D → R) (i : ℤ) (P : Fock D R) (w : TowerFock D R) :
    towerPairing η (Finsupp.single i P) w = pairing η P (w i) := by
  rw [towerPairing, Finsupp.lsum_single, LinearMap.compl₂_apply, Finsupp.lapply_apply]

/-- Rung-supported vectors pair by the single-momentum form, and only on the diagonal. -/
lemma towerPairing_single_single (η : Fin D → R) (i j : ℤ) (P Q : Fock D R) :
    towerPairing η (Finsupp.single i P) (Finsupp.single j Q)
      = if i = j then pairing η P Q else 0 := by
  rw [towerPairing_single_left, Finsupp.single_apply]
  by_cases h : i = j
  · subst h; simp
  · rw [if_neg (Ne.symm h), if_neg h, map_zero]

/-- **Different rungs of the momentum tower are orthogonal.**  Graph node
`worldsheet.momentum-tower-fock-space` item (2): the tower is an *orthogonal* direct sum of
its momentum levels. -/
theorem towerPairing_single_single_of_ne (η : Fin D → R) {i j : ℤ} (hij : i ≠ j)
    (P Q : Fock D R) :
    towerPairing η (Finsupp.single i P) (Finsupp.single j Q) = 0 := by
  rw [towerPairing_single_single, if_neg hij]

/-! ### Bilinearity

`towerPairing` is a `LinearMap.BilinForm` by construction; these lemmas only expose it. -/

lemma towerPairing_add_left (η : Fin D → R) (u v w : TowerFock D R) :
    towerPairing η (u + v) w = towerPairing η u w + towerPairing η v w := by
  rw [map_add, LinearMap.add_apply]

lemma towerPairing_add_right (η : Fin D → R) (u v w : TowerFock D R) :
    towerPairing η u (v + w) = towerPairing η u v + towerPairing η u w :=
  map_add _ v w

lemma towerPairing_smul_left (η : Fin D → R) (c : R) (v w : TowerFock D R) :
    towerPairing η (c • v) w = c * towerPairing η v w := by
  rw [map_smul, LinearMap.smul_apply, smul_eq_mul]

lemma towerPairing_smul_right (η : Fin D → R) (c : R) (v w : TowerFock D R) :
    towerPairing η v (c • w) = c * towerPairing η v w := by
  rw [map_smul, smul_eq_mul]

@[simp]
lemma towerPairing_zero_left (η : Fin D → R) (w : TowerFock D R) :
    towerPairing η 0 w = 0 := by
  rw [map_zero, LinearMap.zero_apply]

@[simp]
lemma towerPairing_zero_right (η : Fin D → R) (v : TowerFock D R) :
    towerPairing η v 0 = 0 :=
  map_zero _

/-! ### Symmetry -/

lemma towerPairing_flip (η : Fin D → R) : (towerPairing η).flip = towerPairing η := by
  refine Finsupp.lhom_ext fun i P => Finsupp.lhom_ext fun j Q => ?_
  rw [LinearMap.flip_apply, towerPairing_single_single, towerPairing_single_single]
  by_cases h : i = j
  · subst h
    rw [if_pos rfl, if_pos rfl, pairing_comm]
  · rw [if_neg (Ne.symm h), if_neg h]

/-- **The tower form is symmetric**, inherited rung-by-rung from `Fock.pairing_comm`. -/
theorem towerPairing_comm (η : Fin D → R) (v w : TowerFock D R) :
    towerPairing η v w = towerPairing η w v := by
  conv_lhs => rw [← towerPairing_flip η]
  rfl

/-! ### Adjoints -/

/-- **`(e^{i n k_0·x})^† = e^{-i n k_0·x}`**: the zero-mode shift operator of the DDF
construction is "unitary" for the tower form.  Graph node
`worldsheet.momentum-tower-fock-space` item (4). -/
theorem towerPairing_towerShift_left (η : Fin D → R) (n : ℤ) (v w : TowerFock D R) :
    towerPairing η (towerShift D R n v) w = towerPairing η v (towerShift D R (-n) w) := by
  have key : ((towerPairing η).flip w).comp (towerShift D R n)
      = (towerPairing η).flip (towerShift D R (-n) w) := by
    refine Finsupp.lhom_ext fun i P => ?_
    simp only [LinearMap.comp_apply, LinearMap.flip_apply, towerShift_single,
      towerPairing_single_left, towerShift_apply, sub_neg_eq_add]
  exact LinearMap.congr_fun key v

/-- `⟨v, e^{i n k_0·x} w⟩ = ⟨e^{-i n k_0·x} v, w⟩`. -/
theorem towerPairing_towerShift_right (η : Fin D → R) (n : ℤ) (v w : TowerFock D R) :
    towerPairing η v (towerShift D R n w) = towerPairing η (towerShift D R (-n) v) w := by
  rw [towerPairing_towerShift_left, neg_neg]

/-- **`(α^μ_p)^† = α^μ_{-p}` on the momentum tower**, for every `p : ℤ` including `p = 0`
(where both sides are the rung-dependent scalar `(a + j b)^μ`). -/
theorem towerPairing_towerMode_left (η a b : Fin D → R) (μ : Fin D) (p : ℤ)
    (v w : TowerFock D R) :
    towerPairing η (towerMode η a b μ p v) w
      = towerPairing η v (towerMode η a b μ (-p) w) := by
  have key : ((towerPairing η).flip w).comp (towerMode η a b μ p)
      = (towerPairing η).flip (towerMode η a b μ (-p) w) := by
    refine Finsupp.lhom_ext fun i P => ?_
    simp only [LinearMap.comp_apply, LinearMap.flip_apply, towerMode_single,
      towerPairing_single_left, towerMode_apply]
    exact pairing_mode_left η (towerMomentum a b i) μ p P (w i)
  exact LinearMap.congr_fun key v

/-- `⟨v, α^μ_p w⟩ = ⟨α^μ_{-p} v, w⟩` on the tower. -/
theorem towerPairing_towerMode_right (η a b : Fin D → R) (μ : Fin D) (p : ℤ)
    (v w : TowerFock D R) :
    towerPairing η v (towerMode η a b μ p w)
      = towerPairing η (towerMode η a b μ (-p) v) w := by
  rw [towerPairing_towerMode_left, neg_neg]

/-- **`L_m^† = L_{-m}` on the momentum tower.**  Inherited rung-by-rung from
`Fock.pairing_Lop_left`; each rung uses its own momentum `towerMomentum a b j`, which is
consistent because `L_m` does not move rungs. -/
theorem towerPairing_towerLop_left [Algebra ℚ R] (η a b : Fin D → R) (m : ℤ)
    (v w : TowerFock D R) :
    towerPairing η (towerLop η a b m v) w = towerPairing η v (towerLop η a b (-m) w) := by
  have key : ((towerPairing η).flip w).comp (towerLop η a b m)
      = (towerPairing η).flip (towerLop η a b (-m) w) := by
    refine Finsupp.lhom_ext fun i P => ?_
    simp only [LinearMap.comp_apply, LinearMap.flip_apply, towerLop_single,
      towerPairing_single_left, towerLop_apply]
    exact pairing_Lop_left η (towerMomentum a b i) m P (w i)
  exact LinearMap.congr_fun key v

/-- `⟨v, L_m w⟩ = ⟨L_{-m} v, w⟩` on the tower. -/
theorem towerPairing_towerLop_right [Algebra ℚ R] (η a b : Fin D → R) (m : ℤ)
    (v w : TowerFock D R) :
    towerPairing η v (towerLop η a b m w) = towerPairing η (towerLop η a b (-m) v) w := by
  rw [towerPairing_towerLop_left, neg_neg]

end TowerPairing

end Fock

end StringFormal.NoGhost
