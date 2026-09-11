/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.LightCone
import Mathlib.LinearAlgebra.Dimension.Constructions
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas

/-!
# The DDF light-cone frame, bundled

Graph node: `worldsheet.ddf-light-cone-frame`; blueprint `formal/BLUEPRINT-noghost.md` §B.1,
§C.2.

`NoGhost/LightCone.lean` defines `LightConeFrame` (the pair `(b, b̃)`, conditions (F2) and the
isotropy/pairing half of (F4)) and `TransverseFrame` (the polarisations `ε_i`, conditions (F5)
and (F7)) as two separate structures, and states the completeness hypothesis
`FrameSpansOrthogonal` (F8) and the extra transversality hypothesis `ε·a = 0` (F6) as loose
side conditions on individual theorems.  No single Lean declaration bundled all eight
conditions (F1)–(F8) of the card together, which is why the card was `rigorous` rather than
`formalized`.  This file supplies that bundling.

## Main definitions

* `DDFLightConeFrame η a b` — the eight conditions (F1)–(F8) of the card, packaged: `frame :
  LightConeFrame η b` and `trans : TransverseFrame η b` account for (F2), (F5), (F7) and the
  isotropy/pairing half of (F4); the remaining fields `hη`, `hba`, `hconjSpan`, `hεa`, `hspan`
  are (F1), (F3), the span half of (F4), (F6), (F8) respectively.
* `witnessDDFLightConeFrame` — the explicit light-cone witness of `NoGhost/Witness.lean` and
  `NoGhost/LightCone.lean` instantiates `DDFLightConeFrame`, so the card's definition is
  non-vacuous (its "非空性" clause).

## Bonus: (F9) and the loose hypothesis of `lie_conjOp_transOp`

* `dotVec_polarization_conj_eq_zero` — (F9) `η(ε_i, b̃) = 0`, by bilinearity of `dotVec` alone
  from the span half of (F4) and (F5)+(F6).  This is exactly the loose hypothesis `hεconj`
  that `lie_conjOp_transOp` carries and that `TransverseFrame` does not provide.
* `DDFLightConeFrame.lie_conjOp_transOp` — the corollary discharging that hypothesis from a
  `DDFLightConeFrame`: `⁅α^b̃_m, α^{ε_i}_n⁆ = 0` needs no hypothesis beyond the frame data.

## Bonus: completeness forces the tachyonic mass shell

* `DDFLightConeFrame.dotVec_self_eq_two` — the curator's hand computation "(F6)(F7)(F8) over a
  field force `η(a,a) = 2`" (card notes, item (ii)): a codimension-one orthogonal-complement
  argument (rank–nullity for the linear functional `e ↦ η(e,v)`, `v := a - b`, plus a
  spanning-set dimension bound for `{ε_i}`).  Needs `[Field R]` (not just `[CommRing R]`); the
  card's condition table is left unchanged (`(F8)` is still stated as a hypothesis, not
  weakened to this consequence), per the card's explicit "不断言" (d).

## Scope and gaps

* This file does not touch `NoGhost/Witness.lean`; the three small `witnessConjugate_*`
  component lemmas needed for `hconjSpan` are proved locally here, mirroring the existing
  `witnessMomentum_*`/`witnessLight_*` lemmas of `NoGhost/LightCone.lean`.
-/

namespace StringFormal.NoGhost

/-! ### The bundled structure -/

section DDFFrame

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

/-- **A DDF light-cone frame** (graph card `worldsheet.ddf-light-cone-frame`, conditions
(F1)–(F8)): a base momentum `a`, a light-cone pair `(b, b̃)`, and `D - 2` transverse
polarisations `ε_1, …, ε_{D-2}`, satisfying all eight of the card's conditions.

`frame : LightConeFrame η b` packages (F2) `η(b,b) = 0` and the isotropy/pairing half of (F4)
(`η(b̃,b̃) = 0`, `η(b,b̃) = -1`); `trans : TransverseFrame η b` packages (F5) `η(ε_i,b) = 0` and
(F7) `η(ε_i,ε_j) = δ_{ij}`.  The remaining fields are, in the card's numbering: `hη` is (F1),
`hba` is (F3), `hconjSpan` is the span half of (F4) (`b̃ ∈ span_R{a,b}`), `hεa` is (F6), and
`hspan` is (F8) (completeness on `v^⊥`, `v := a - b` the rung `-1` momentum). -/
structure DDFLightConeFrame (η a b : Fin D → R) where
  /-- (F2) and the isotropy/pairing half of (F4). -/
  frame : LightConeFrame η b
  /-- (F5) and (F7). -/
  trans : TransverseFrame η b
  /-- (F1) the metric squares to `1` componentwise. -/
  hη : ∀ μ, η μ * η μ = 1
  /-- (F3) the DDF normalisation `η(b, a) = 1`. -/
  hba : dotVec η b a = 1
  /-- (F4), span half: `b̃ ∈ span_R{a, b}`. -/
  hconjSpan : ∃ β γ : R, frame.conj = β • a + γ • b
  /-- (F6) the transverse polarisations are orthogonal to the base momentum `a`. -/
  hεa : ∀ i, dotVec η (trans.vec i) a = 0
  /-- (F8) completeness: `{ε_i}` together with `v = a - b` spans `v^⊥`. -/
  hspan : FrameSpansOrthogonal η trans (towerMomentum a b (-1))

end DDFFrame

/-! ### Non-emptiness: the explicit witness -/

section Witness

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

@[simp]
private lemma witnessConjugate_frameTime (hD : 3 ≤ D) :
    witnessConjugate D R hD (frameTime D hD) = invTwo R := by
  rw [witnessConjugate, Pi.add_apply, Pi.single_eq_same,
    Pi.single_eq_of_ne (frameTime_ne_frameSpace hD), add_zero]

@[simp]
private lemma witnessConjugate_frameSpace (hD : 3 ≤ D) :
    witnessConjugate D R hD (frameSpace D hD) = -invTwo R := by
  rw [witnessConjugate, Pi.add_apply, Pi.single_eq_of_ne (Ne.symm (frameTime_ne_frameSpace hD)),
    Pi.single_eq_same, zero_add]

private lemma witnessConjugate_apply_of_ne (hD : 3 ≤ D) {μ : Fin D}
    (h1 : μ ≠ frameTime D hD) (h2 : μ ≠ frameSpace D hD) :
    witnessConjugate D R hD μ = 0 := by
  rw [witnessConjugate, Pi.add_apply, Pi.single_eq_of_ne h1, Pi.single_eq_of_ne h2, add_zero]

/-- **The conjugate direction of the explicit witness lies in `span{a, b}`**:
`b̃ = -1 • k + 1 • k_0` (equivalently `b̃ = b - a`, matching the hand computation of the card's
notes, item (i): `b̃ = (η(a,a)/2)·b - a` with `η(a,a) = 2` on this witness). This is the (F4)
span condition. -/
theorem witnessConjugate_eq_neg_witnessMomentum_add_witnessLight (hD : 3 ≤ D) :
    witnessConjugate D R hD
      = (-1 : R) • witnessMomentum D R hD + (1 : R) • witnessLight D R hD := by
  funext μ
  rcases eq_or_ne μ (frameTime D hD) with h1 | h1
  · subst h1
    simp only [Pi.add_apply, Pi.smul_apply, smul_eq_mul]
    rw [witnessConjugate_frameTime, witnessMomentum_frameTime, witnessLight_frameTime]
    linear_combination two_mul_invTwo R
  rcases eq_or_ne μ (frameSpace D hD) with h2 | h2
  · subst h2
    simp only [Pi.add_apply, Pi.smul_apply, smul_eq_mul]
    rw [witnessConjugate_frameSpace, witnessMomentum_frameSpace, witnessLight_frameSpace]
    linear_combination two_mul_invTwo R
  · simp only [Pi.add_apply, Pi.smul_apply, smul_eq_mul]
    rw [witnessConjugate_apply_of_ne hD h1 h2, witnessMomentum_apply_of_ne hD h1 h2,
      witnessLight_apply_of_ne hD h1 h2]
    ring

/-- **The explicit light-cone witness of `NoGhost/Witness.lean` and `NoGhost/LightCone.lean`
is a `DDFLightConeFrame`.**  The card's definition is therefore non-vacuous. -/
noncomputable def witnessDDFLightConeFrame (hD : 3 ≤ D) :
    DDFLightConeFrame (Fock.minkowski D R) (witnessMomentum D R hD) (witnessLight D R hD) where
  frame := witnessLightConeFrame D R hD
  trans := witnessTransverseFrame D R hD
  hη := minkowski_sq D R
  hba := dotVec_witnessLight_witnessMomentum hD
  hconjSpan := ⟨-1, 1, witnessConjugate_eq_neg_witnessMomentum_add_witnessLight hD⟩
  hεa := dotVec_witnessTransverseFrame_witnessMomentum hD
  hspan := witness_frameSpansOrthogonal hD

end Witness

/-! ### Bonus: (F9) and the loose hypothesis of `lie_conjOp_transOp` -/

section F9

variable {D : ℕ} {R : Type*} [CommRing R]

/-- **(F9)**: `η(ε_i, b̃) = 0`, purely from bilinearity of `dotVec`, the span half of (F4)
(`b̃ ∈ span{a,b}`), and (F5)+(F6) (`ε_i·b = 0`, `ε_i·a = 0`).  This is exactly the loose
hypothesis `hεconj` of `lie_conjOp_transOp`, which `TransverseFrame` alone does not provide
(card notes, "本卡解决的问题"). -/
theorem dotVec_polarization_conj_eq_zero (η a b bt ε : Fin D → R) {β γ : R}
    (hbt : bt = β • a + γ • b) (hεa : dotVec η ε a = 0) (hεb : dotVec η ε b = 0) :
    dotVec η ε bt = 0 := by
  rw [hbt, dotVec_add_right, dotVec_smul_right, dotVec_smul_right, hεa, hεb, mul_zero, mul_zero,
    add_zero]

variable [Algebra ℚ R]

omit [Algebra ℚ R] in
/-- The (F9) conclusion for a `DDFLightConeFrame`. -/
theorem DDFLightConeFrame.dotVec_trans_conj_eq_zero {η a b : Fin D → R}
    (F : DDFLightConeFrame η a b) (i : Fin (D - 2)) :
    dotVec η (F.trans.vec i) F.frame.conj = 0 := by
  obtain ⟨β, γ, hbt⟩ := F.hconjSpan
  exact dotVec_polarization_conj_eq_zero η a b F.frame.conj (F.trans.vec i) hbt (F.hεa i)
    (F.trans.transverse i)

omit [Algebra ℚ R] in
/-- **Discharges the loose hypothesis `hεconj` of `lie_conjOp_transOp` from a
`DDFLightConeFrame`**: `⁅α^b̃_m, α^{ε_i}_n⁆ = 0` needs no hypothesis beyond the frame data. -/
theorem DDFLightConeFrame.lie_conjOp_transOp {η a b : Fin D → R}
    (F : DDFLightConeFrame η a b) (i : Fin (D - 2)) (m n : ℤ) :
    ⁅conjOp η a b F.frame m, transOp η a b (F.trans.vec i) n⁆ = 0 :=
  StringFormal.NoGhost.lie_conjOp_transOp η a b F.frame (F.trans.vec i)
    (by rw [dotVec_comm]; exact F.dotVec_trans_conj_eq_zero i) F.hη m n

end F9

/-! ### Bonus: completeness forces the tachyonic mass shell -/

section MassShellAux

variable {D : ℕ} {R : Type*} [CommRing R]

/-- `dotVec` is additive in its left argument for a finite sum. -/
private lemma dotVec_sum_left {ι : Type*} (s : Finset ι) (f : ι → Fin D → R) (η y : Fin D → R) :
    dotVec η (∑ i ∈ s, f i) y = ∑ i ∈ s, dotVec η (f i) y := by
  simp only [dotVec, Finset.sum_apply, Finset.mul_sum, Finset.sum_mul]
  rw [Finset.sum_comm]

/-- `dotVec` is linear in its left argument (scalar half). -/
private lemma dotVec_smul_left (η x y : Fin D → R) (c : R) :
    dotVec η (c • x) y = c * dotVec η x y := by
  rw [dotVec_comm, dotVec_smul_right, dotVec_comm η y x]

/-- Bilinearity of `dotVec` against the rung-`j` momentum, in an arbitrary left slot
(generalising `dotVec_towerMomentum_right`, which only treats the left slot `b`). -/
private lemma dotVec_towerMomentum_right_of (η x a b : Fin D → R) (j : ℤ) :
    dotVec η x (towerMomentum a b j) = dotVec η x a + (j : R) * dotVec η x b := by
  have hj : towerMomentum a b j = a + (j : R) • b := by
    funext μ; simp [towerMomentum_apply]
  rw [hj, dotVec_add_right, dotVec_smul_right]

end MassShellAux

/-! The main bonus (ii) theorem needs `[Field R]`.  It is kept in its own section, without a
separate `[CommRing R]` variable, to avoid two overlapping instance paths to the same ring
structure on `R` (Lean's `overlappingInstances` linter flags `[CommRing R]` together with
`[Field R]` in one declaration as unsafe: the two give defeq-but-not-syntactically-equal
instances for `Add R`, `Zero R`, etc., which broke several `rw`/term-mode steps below in an
earlier draft).  The `MassShellAux` lemmas above, proved for a generic `[CommRing R]`, apply
here through the `CommRing` that `Field.toCommRing` supplies — no second instance is declared. -/

section MassShell

variable {D : ℕ} {R : Type*} [Field R]

/-- **Bonus (ii) of the curator's hand computation** (card `worldsheet.ddf-light-cone-frame`,
notes item (ii)): over a field, (F6)+(F7)+(F8) force the tachyonic mass shell `η(a,a) = 2`.

Proof sketch (matching the card's hand derivation exactly): let `v := a - b`
(`towerMomentum a b (-1)`).  The functional `L e := η(e,v)` has `finrank (range L) ≤ 1`, so
rank–nullity gives `finrank (ker L) ≥ D - 1`.  The span of the `D - 2` polarisations has
`finrank ≤ D - 2 < D - 1 ≤ finrank (ker L)`, so `ker L ⊄ span{ε_i}`: pick `e ∈ ker L` outside
that span.  Completeness (F8) writes `e = Σ c_i ε_i + c_0 v` with `c_0 ≠ 0` (else `e` would lie
in `span{ε_i}`).  Pairing this decomposition with `v` and using `η(ε_i, v) = 0` (from (F6) and
`ε_i·b = 0`) collapses `0 = η(e,v)` to `c_0 · η(v,v) = 0`, so `η(v,v) = 0`; expanding
`η(v,v) = η(a,a) - 2η(a,b) + η(b,b) = η(a,a) - 2` via (F2)(F3) finishes. -/
theorem DDFLightConeFrame.dotVec_self_eq_two {η a b : Fin D → R} (hD : 2 ≤ D)
    (F : DDFLightConeFrame η a b) : dotVec η a a = 2 := by
  classical
  -- η(v,v) = η(a,a) - 2, from (F2)(F3) and bilinearity, `v := towerMomentum a b (-1) = a - b`.
  have hvv_eq : dotVec η (towerMomentum a b (-1)) (towerMomentum a b (-1))
      = dotVec η a a - 2 := by
    rw [← zeroModeSq_eq_dotVec, zeroModeSq_towerMomentum, zeroModeSq_eq_dotVec, F.hba,
      F.frame.isotropic]
    push_cast
    ring
  -- Each polarisation is orthogonal to `v`, from (F5)(F6).
  have hεv : ∀ i, dotVec η (F.trans.vec i) (towerMomentum a b (-1)) = 0 := by
    intro i
    rw [dotVec_towerMomentum_right_of, F.hεa i, F.trans.transverse i]
    ring
  -- The pairing functional `L e := η(e,v)` as a linear map.
  let L : (Fin D → R) →ₗ[R] R :=
    { toFun := fun e => dotVec η e (towerMomentum a b (-1))
      map_add' := fun x y => dotVec_add_left η x y _
      map_smul' := fun c x => by
        show dotVec η (c • x) (towerMomentum a b (-1))
          = c • dotVec η x (towerMomentum a b (-1))
        rw [dotVec_smul_left, smul_eq_mul] }
  have hLker : ∀ e, e ∈ LinearMap.ker L ↔ dotVec η e (towerMomentum a b (-1)) = 0 :=
    fun e => Iff.rfl
  -- `finrank (range L) ≤ 1`, since `R` is one-dimensional over itself.
  have hrange : Module.finrank R (LinearMap.range L) ≤ 1 := by
    have := Submodule.finrank_le (R := R) (M := R) (LinearMap.range L)
    rwa [CommSemiring.finrank_self R] at this
  -- Rank–nullity: `finrank (range L) + finrank (ker L) = D`.
  have hrn : Module.finrank R (LinearMap.range L) + Module.finrank R (LinearMap.ker L) = D := by
    have h := LinearMap.finrank_range_add_finrank_ker (K := R) L
    rwa [Module.finrank_pi R, Fintype.card_fin] at h
  -- `finrank (span {ε_i}) ≤ D - 2`.
  have hspanle : Module.finrank R (Submodule.span R (Set.range F.trans.vec)) ≤ D - 2 := by
    have h := finrank_range_le_card (R := R) F.trans.vec
    rwa [Fintype.card_fin] at h
  -- Hence `ker L` cannot sit inside `span {ε_i}`: its dimension is strictly bigger.
  have hgt : Module.finrank R (Submodule.span R (Set.range F.trans.vec))
      < Module.finrank R (LinearMap.ker L) := by omega
  have hfin : Module.Finite R (Submodule.span R (Set.range F.trans.vec)) :=
    Module.Finite.span_of_finite R (Set.finite_range _)
  have hnle : ¬ (LinearMap.ker L ≤ Submodule.span R (Set.range F.trans.vec)) := by
    intro hle
    have := Submodule.finrank_mono (R := R) (M := Fin D → R) hle
    omega
  obtain ⟨e, heker, henotin⟩ := SetLike.not_le_iff_exists.mp hnle
  have he0 : dotVec η e (towerMomentum a b (-1)) = 0 := (hLker e).mp heker
  obtain ⟨c, c₀, hdecomp⟩ := F.hspan e he0
  -- `c₀ ≠ 0`: otherwise `e ∈ span {ε_i}`, contradicting the choice of `e`.
  have hc0 : c₀ ≠ 0 := by
    intro hc0
    apply henotin
    rw [hc0, zero_smul, add_zero] at hdecomp
    rw [hdecomp]
    exact Submodule.sum_mem _ fun i _ =>
      Submodule.smul_mem _ _ (Submodule.subset_span ⟨i, rfl⟩)
  -- Pair the decomposition with `v`: `0 = η(e,v) = c₀ · η(v,v)`.
  have hspan0 : dotVec η (∑ i, c i • F.trans.vec i) (towerMomentum a b (-1)) = 0 := by
    rw [dotVec_sum_left]
    exact Finset.sum_eq_zero fun i _ => by rw [dotVec_smul_left, hεv i, mul_zero]
  rw [hdecomp, dotVec_add_left, hspan0, zero_add, dotVec_smul_left] at he0
  have hvv0 : dotVec η (towerMomentum a b (-1)) (towerMomentum a b (-1)) = 0 :=
    (mul_eq_zero.mp he0).resolve_left hc0
  exact sub_eq_zero.mp (hvv_eq.symm.trans hvv0)

end MassShell

end StringFormal.NoGhost
