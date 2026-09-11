/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.LightConeResolution

/-!
# Light-cone resolution of identity and the light-cone spanning set (blueprint §B′ PR3)

Graph node: `worldsheet.ddf-light-cone-frame` (the frame side) and
`worldsheet.ddf-spanning-hypothesis` (the consumer).  Blueprint
`formal/BLUEPRINT-noghost.md` §B′.4, PR3.

This is the "general `N`" replacement for step 1 of blueprint §B.4.  §B.4 proposed a ring
automorphism (`AlgEquiv`) of the whole `MvPolynomial` generator set, estimated there at
400–700 lines; §B′.4 observed that only a *spanning* statement is needed, and that it follows
from a resolution of identity on `Fin D → R` pushed through the multiplicative structure.
Nothing here needs linear independence, determinants, or a ring isomorphism.

**File name and relation to `NoGhost/LightConeResolution.lean`.**  The blueprint calls this PR
`NoGhost/LightConeResolution.lean`.  That name was taken by a concurrent `N = 2` task, which
landed `DDFLightConeFrame.conj_eq_light_sub_momentum` and `DDFLightConeFrame.resolution` there
(both with `[Field R] [Algebra ℚ R]` and `hD : 2 ≤ D`).  **Neither is restated here.**  This
file imports that one and supplies the general-`N` remainder of PR3, plus the two
generalisations the `[Field]` route hides (see deviation 1).

## Main results

* `DDFLightConeFrame.exists_frame_decomp` — every `e : Fin D → R` decomposes as
  `lam • b + mu • b̃ + ∑ i, c i • ε_i`, **over an arbitrary commutative ring and with no
  dimension hypothesis**.  This is the frame completeness that `NoGhost/LevelTwoElim.lean`'s
  gap list guessed had to be *assumed* (`hFullSpan` / `FrameSpansFull`).
* `DDFLightConeFrame.frame_decomp_coeff` — that decomposition is unique, with explicit
  coefficients `lam = -(b̃·e)`, `mu = -(b·e)`, `c j = ε_j·e`.  Same hypotheses.  Combined with
  the previous item this *reproves* `DDFLightConeFrame.resolution` without `[Field R]`,
  `[Algebra ℚ R]` or `hD`.
* `DDFLightConeFrame.conjSpan_coeff_left` (`β = -1`) and
  `DDFLightConeFrame.two_mul_conjSpan_coeff_right` (`2 γ = η(a,a)`) — the two halves of
  `conj_eq_light_sub_momentum`, isolated so that the characteristic-`2` obstruction is a
  single visible equation rather than a remark.
* `DDFLightConeFrame.dotVec_conj_towerMomentum` — `b̃ · p_j = -1 - j`, i.e. `N - 1` on rung
  `j = -N`.  **The zero-mode coefficient of `α^{b̃}` is rung-dependent**; only the `b`-side
  coefficient `-(b · p_j) = -1` is rung-independent (`conjCoeff_towerMomentum`).  §B′.9 item
  1(b) flags getting this backwards as a way to produce a false leading-term lemma.
* `DDFLightConeFrame.dotVec_trans_towerMomentum` — `ε_i · p_j = 0`, rung-independent.
* `lcCrea η w n` — the light-cone creation operator `α^w_{-n} = ∑_μ η_μ w^μ X_{(μ,n)}`, with
  its linearity in `w` (`lcCreaₗ` is the bundled linear map) and the `n = 1` identification
  with `Fock.polState`.
* `X_eq_lcCrea_single` — `X_{(μ,n)} = lcCrea η (Pi.single μ η_μ) n`, the general-`n` form of
  `LevelTwoElim.X_one_eq_polState_single`.
* `frameVec` / `lcMonomial` / `lcSpan` — the light-cone direction table (`b`, `b̃`,
  `ε_1, …, ε_{D-2}` listed as a map `Fin D → (Fin D → R)`), the associated monomials, and
  their span.
* `levelSubmodule_eq_span_lcMonomial` — **the light-cone monomials of level `N` span the
  level-`N` Fock fiber**.  Spanning only; linear independence is deliberately out of scope
  (blueprint §B′.9 item 2: it has no free proof and is not on the critical path).

## Deviations from the blueprint's §B′.4 draft (also appended to the blueprint's "§B′ 订正")

1. **The resolution of the identity needs neither a field nor `2 ≤ D`.**  Both the blueprint
   and `NoGhost/LightConeResolution.lean` route it through `conj_eq_light_sub_momentum`
   (hence `dotVec_self_eq_two`, hence `[Field]`, `(2 : R) ≠ 0` and `2 ≤ D`).  That detour is
   avoidable: (F4)'s span half plus `b·a = 1` already give `β = -1` in `b̃ = β • a + γ • b`
   (`conjSpan_coeff_left`), so `a - b = (γ - 1) • b - b̃` lies in `span{b, b̃}` **without
   knowing `γ`** (`towerMomentum_neg_one_eq`), which is all the (F8) completeness statement
   — phrased on `(a-b)^⊥` — needs.  The coefficients are then pinned by pairing against `b`,
   `b̃`, `ε_j`, which is division-free.  Hence `exists_frame_decomp` and
   `frame_decomp_coeff` over `[CommRing R]`.
2. `conj_eq_light_sub_momentum` needs `(2 : R) ≠ 0` on top of `[Field R]`; the blueprint's
   draft signature listed only `[Field K]`.  The frame data give exactly `2 γ = η(a,a)`
   (`two_mul_conjSpan_coeff_right`), so with `dotVec_self_eq_two` the equation to solve is
   `2 γ = 2`.  In characteristic `2` the conditions (F1)–(F8) genuinely do not pin `b̃`.
3. The blueprint's `lcMonomial` is indexed by an unspecified `frameVec F : Fin D → (Fin D → K)`
   "copying the index shuffling of `LightCone.transIdx`".  Here the shuffle is a `dite` on the
   numeral value of the index (`0 ↦ b`, `1 ↦ b̃`, `μ ↦ ε_{μ-2}`), which needs only `2 ≤ D` and
   avoids `transIdx`'s `3 ≤ D`.  Crucially **no bijection `Fin D ≃ Unit ⊕ Unit ⊕ Fin (D-2)` is
   ever built**: the spanning proof only needs `span (range (frameVec F)) = ⊤`, for which it
   suffices that `b`, `b̃` and each `ε_i` are *in* the range.  Consequence: the index type of
   the light-cone monomials is literally `Osc D = Fin D × ℕ+`, the same as for the standard
   monomials, so the two sides of §B′.8's counting comparison are indexed by the *same* set.
4. `levelSubmodule_eq_span_lcMonomial` is an equality of submodules of `Fock D R` for an
   arbitrary `[CommRing R]`; the blueprint asked only for `[Field K]`.  (It is not vacuous
   over a general ring: `NoGhost/WitnessInt.lean` exhibits a frame over `ℤ`.)

## Scope and gaps

* **Spanning only.**  `LinearIndependent` for the light-cone monomials is not proved and is
  not attempted (blueprint §B′.9 item 2).  Consequently nothing here upgrades
  `towerKerK_inf_towerBigrade_eq_conjFree` beyond its cheap `⊇` half.
* Nothing here is about the tower: `lcMonomial` lives in a single `Fock D R` fiber.  The rung
  bookkeeping (`towerBigrade`) enters only in PR4.
* The `b̃`-degree/weighted-degree pair `(β, ω)` of blueprint §B′.5 is *not* defined here; it
  belongs with the elimination induction of PR4.
* `towerLop_neg_conjDegree_leading` (the §B′.4 leading-term lemma) is PR4 and is not started.
-/

namespace StringFormal.NoGhost

open MvPolynomial

/-! ### Bilinearity helpers for `dotVec`

`NoGhost/Witness.lean` has `dotVec_add_left` / `dotVec_add_right` / `dotVec_single_left`, and
`NoGhost/LightCone.lean` has `dotVec_smul_right`; the three below are the remaining slots.
(`NoGhost/LightConeFrame.lean` proves two of them `private`, so they are not reusable.) -/

section DotVecAux

variable {D : ℕ} {R : Type*} [CommRing R]

/-- `dotVec` is homogeneous in its left argument. -/
lemma dotVec_smul_left (η x y : Fin D → R) (c : R) :
    dotVec η (c • x) y = c * dotVec η x y := by
  rw [dotVec_comm, dotVec_smul_right, dotVec_comm η y x]

/-- `dotVec` is additive in its left argument (subtraction form). -/
lemma dotVec_sub_left (η x y z : Fin D → R) :
    dotVec η (x - y) z = dotVec η x z - dotVec η y z := by
  rw [sub_eq_add_neg, dotVec_add_left, sub_eq_add_neg]
  congr 1
  rw [show (-y) = (-1 : R) • y by funext μ; simp, dotVec_smul_left, neg_one_mul]

/-- `dotVec` is additive in its right argument (subtraction form). -/
lemma dotVec_sub_right (η x y z : Fin D → R) :
    dotVec η x (y - z) = dotVec η x y - dotVec η x z := by
  rw [dotVec_comm, dotVec_sub_left, dotVec_comm η y x, dotVec_comm η z x]

/-- `dotVec` distributes over a finite sum in its left argument. -/
lemma dotVec_sum_left {ι : Type*} (s : Finset ι) (f : ι → Fin D → R) (η y : Fin D → R) :
    dotVec η (∑ i ∈ s, f i) y = ∑ i ∈ s, dotVec η (f i) y := by
  simp only [dotVec, Finset.sum_apply, Finset.mul_sum, Finset.sum_mul]
  rw [Finset.sum_comm]

end DotVecAux

/-! ### The resolution of identity attached to a DDF light-cone frame -/

section Resolution

variable {D : ℕ} {R : Type*} [CommRing R] {η a b : Fin D → R}

/-- **The conjugate direction has `a`-coefficient `-1`.**  Pairing the (F4) span condition
`b̃ = β • a + γ • b` with `b` and using (F3) `b·a = 1`, (F2) `b·b = 0` and the (F4)
normalisation `b·b̃ = -1` gives `β = -1` outright; `γ` is *not* pinned by this argument (see
`DDFLightConeFrame.conj_eq_light_sub_momentum` in `NoGhost/LightConeResolution.lean`, which
needs a field of characteristic `≠ 2`). -/
theorem DDFLightConeFrame.conjSpan_coeff_left (F : DDFLightConeFrame η a b) {β γ : R}
    (hbt : F.frame.conj = β • a + γ • b) : β = -1 := by
  have h : dotVec η b F.frame.conj = β * dotVec η b a + γ * dotVec η b b := by
    rw [hbt, dotVec_add_right, dotVec_smul_right, dotVec_smul_right]
  rw [F.frame.pairing, F.hba, F.frame.isotropic, mul_one, mul_zero, add_zero] at h
  exact h.symm

/-- **The rung `-1` momentum lies in the light-cone plane**: `a - b = (γ - 1) • b - b̃`, where
`γ` is the `b`-coefficient of `b̃`.  This is the observation that makes `resolution` work over
an arbitrary commutative ring: the (F8) completeness statement is phrased on `(a-b)^⊥`, and
`a - b` is a combination of `b` and `b̃` **whatever `γ` is**. -/
theorem DDFLightConeFrame.towerMomentum_neg_one_eq (F : DDFLightConeFrame η a b) {β γ : R}
    (hbt : F.frame.conj = β • a + γ • b) :
    towerMomentum a b (-1) = (γ - 1) • b - F.frame.conj := by
  have hβ : β = -1 := F.conjSpan_coeff_left hbt
  funext μ
  have hμ : F.frame.conj μ = -a μ + γ * b μ := by
    rw [hbt, hβ]
    simp only [Pi.add_apply, Pi.smul_apply, smul_eq_mul]
    ring
  simp only [towerMomentum_apply, Pi.sub_apply, Pi.smul_apply, smul_eq_mul, hμ]
  push_cast
  ring

/-- **Frame completeness is a theorem, not a hypothesis** (blueprint §B′ judgement 3):
every vector decomposes along `b`, `b̃` and the transverse frame.

`NoGhost/LevelTwoElim.lean`'s gap list calls this `hFullSpan` and flags it as an extra
assumption "strictly stronger than the `v^⊥`-only `FrameSpansOrthogonal`".  It is not: (F8)
on `(a-b)^⊥` plus `towerMomentum_neg_one_eq` give it.  The coefficients are made explicit in
`resolution`. -/
theorem DDFLightConeFrame.exists_frame_decomp (F : DDFLightConeFrame η a b) (e : Fin D → R) :
    ∃ (lam mu : R) (c : Fin (D - 2) → R),
      e = lam • b + mu • F.frame.conj + ∑ i, c i • F.trans.vec i := by
  obtain ⟨β, γ, hbt⟩ := F.hconjSpan
  have hv : towerMomentum a b (-1) = (γ - 1) • b - F.frame.conj :=
    F.towerMomentum_neg_one_eq hbt
  have hbv : dotVec η b (towerMomentum a b (-1)) = 1 := by
    rw [dotVec_towerMomentum_right, F.hba, F.frame.isotropic, mul_zero, add_zero]
  have he' : dotVec η (e - (dotVec η e (towerMomentum a b (-1))) • b)
      (towerMomentum a b (-1)) = 0 := by
    rw [dotVec_sub_left, dotVec_smul_left, hbv, mul_one, sub_self]
  obtain ⟨c, c₀, hdec⟩ := F.hspan _ he'
  refine ⟨dotVec η e (towerMomentum a b (-1)) + c₀ * (γ - 1), -c₀, c, ?_⟩
  funext μ
  have h1 := congrFun hdec μ
  have h2 := congrFun hv μ
  simp only [Pi.sub_apply, Pi.add_apply, Pi.smul_apply, smul_eq_mul, Finset.sum_apply] at h1 h2 ⊢
  rw [h2] at h1
  linear_combination h1

/-- **The resolution of identity of the DDF light-cone frame** (blueprint §B′ judgement 3,
PR3): **the frame decomposition is unique, with explicit coefficients.**  If
`e = lam • b + mu • b̃ + ∑ i, c i • ε_i` then necessarily

`lam = -(b̃·e)`, `mu = -(b·e)`, `c j = ε_j·e`.

The coefficients are read off by pairing the given decomposition against `b`, `b̃` and `ε_j`;
the six relevant contractions are (F2) `b·b = 0`, (F4) `b·b̃ = -1` and `b̃·b̃ = 0`,
(F5) `ε_i·b = 0`, (F7) `ε_i·ε_j = δ_{ij}` and (F9) `ε_i·b̃ = 0`
(`DDFLightConeFrame.dotVec_trans_conj_eq_zero`).  No division.

Together with `exists_frame_decomp` this *reproves* `DDFLightConeFrame.resolution`
(`NoGhost/LightConeResolution.lean`) **without `[Field R]`, without `[Algebra ℚ R]` and
without `hD : 2 ≤ D`**; that file's route goes through `conj_eq_light_sub_momentum`, which
genuinely needs all three, but the resolution itself does not (see the module docstring,
deviation 1).  The `[Field]` version is not restated here — only the two halves that carry
the extra generality. -/
theorem DDFLightConeFrame.frame_decomp_coeff (F : DDFLightConeFrame η a b) {e : Fin D → R}
    {lam mu : R} {c : Fin (D - 2) → R}
    (hdec : e = lam • b + mu • F.frame.conj + ∑ i, c i • F.trans.vec i) :
    lam = -(dotVec η F.frame.conj e) ∧ mu = -(dotVec η b e) ∧
      ∀ j, c j = dotVec η (F.trans.vec j) e := by
  classical
  have hεconj : ∀ i, dotVec η (F.trans.vec i) F.frame.conj = 0 :=
    F.dotVec_trans_conj_eq_zero
  have hbsum : dotVec η b (∑ i, c i • F.trans.vec i) = 0 := by
    rw [dotVec_comm, dotVec_sum_left]
    exact Finset.sum_eq_zero fun i _ => by
      rw [dotVec_smul_left, F.trans.transverse i, mul_zero]
  have hconjsum : dotVec η F.frame.conj (∑ i, c i • F.trans.vec i) = 0 := by
    rw [dotVec_comm, dotVec_sum_left]
    exact Finset.sum_eq_zero fun i _ => by rw [dotVec_smul_left, hεconj i, mul_zero]
  have hjsum : ∀ j, dotVec η (F.trans.vec j) (∑ i, c i • F.trans.vec i) = c j := by
    intro j
    rw [dotVec_comm, dotVec_sum_left,
      Finset.sum_congr rfl (fun i (_ : i ∈ Finset.univ) => by
        rw [dotVec_smul_left, F.trans.orthonormal i j])]
    simp
  have hbe : dotVec η b e = -mu := by
    rw [hdec, dotVec_add_right, dotVec_add_right, hbsum, add_zero, dotVec_smul_right,
      dotVec_smul_right, F.frame.isotropic, F.frame.pairing, mul_zero, zero_add, mul_neg,
      mul_one]
  have hconje : dotVec η F.frame.conj e = -lam := by
    rw [hdec, dotVec_add_right, dotVec_add_right, hconjsum, add_zero, dotVec_smul_right,
      dotVec_smul_right, F.frame.conj_isotropic, dotVec_comm η F.frame.conj b, F.frame.pairing,
      mul_zero, add_zero, mul_neg, mul_one]
  have hce : ∀ j, dotVec η (F.trans.vec j) e = c j := by
    intro j
    rw [hdec, dotVec_add_right, dotVec_add_right, hjsum j, dotVec_smul_right, dotVec_smul_right,
      F.trans.transverse j, hεconj j, mul_zero, mul_zero, zero_add, zero_add]
  exact ⟨by rw [hconje, neg_neg], by rw [hbe, neg_neg], fun j => (hce j).symm⟩

/-- **The transverse polarisations are orthogonal to every rung momentum**, from (F5) and
(F6).  (Blueprint §B′.4's `dotVec_trans_towerMomentum`.) -/
theorem DDFLightConeFrame.dotVec_trans_towerMomentum (F : DDFLightConeFrame η a b)
    (i : Fin (D - 2)) (j : ℤ) :
    dotVec η (F.trans.vec i) (towerMomentum a b j) = 0 := by
  rw [dotVec_vec_towerMomentum, F.hεa i, F.trans.transverse i, mul_zero, add_zero]

/-- **`2 γ = η(a,a)`**, where `γ` is the `b`-coefficient of `b̃`.  This is the whole
characteristic-`2` obstruction to `b̃ = b - a` in one line: over a ring where `2` is not a
zero divisor it pins `γ` once `η(a,a)` is known, and over a field of characteristic `2` it is
vacuous. -/
theorem DDFLightConeFrame.two_mul_conjSpan_coeff_right (F : DDFLightConeFrame η a b) {β γ : R}
    (hbt : F.frame.conj = β • a + γ • b) : 2 * γ = dotVec η a a := by
  have hβ : β = -1 := F.conjSpan_coeff_left hbt
  have ha : a = γ • b - F.frame.conj := by
    funext μ
    have hμ : F.frame.conj μ = -a μ + γ * b μ := by
      rw [hbt, hβ]
      simp only [Pi.add_apply, Pi.smul_apply, smul_eq_mul]
      ring
    simp only [Pi.sub_apply, Pi.smul_apply, smul_eq_mul, hμ]
    ring
  have h : dotVec η a a
      = γ * (γ * dotVec η b b - dotVec η b F.frame.conj)
        - (γ * dotVec η F.frame.conj b - dotVec η F.frame.conj F.frame.conj) := by
    conv_lhs => rw [ha]
    rw [dotVec_sub_left, dotVec_smul_left, dotVec_sub_right, dotVec_sub_right,
      dotVec_smul_right, dotVec_smul_right]
  rw [F.frame.isotropic, F.frame.conj_isotropic, F.frame.pairing,
    dotVec_comm η F.frame.conj b, F.frame.pairing] at h
  rw [h]
  ring

end Resolution

/-! ### `b̃ · p_j`

`DDFLightConeFrame.conj_eq_light_sub_momentum` (`b̃ = b - a`) lives in
`NoGhost/LightConeResolution.lean` and is *not* restated here.  The two ingredients its proof
needs beyond `[Field]` are isolated above as `conjSpan_coeff_left` (`β = -1`, no hypotheses)
and `two_mul_conjSpan_coeff_right` (`2 γ = η(a,a)`, no hypotheses); together with
`dotVec_self_eq_two` they show exactly where `(2 : R) ≠ 0` enters.

Kept in its own section with the `[Field R] [Algebra ℚ R]` of `LightConeResolution.lean` (no
separate `[CommRing R]` variable: see the comment before `MassShell` in
`NoGhost/LightConeFrame.lean` on the `overlappingInstances` linter). -/

section ConjEq

variable {D : ℕ} {R : Type*} [Field R] [Algebra ℚ R]

/-- **`b̃ · p_j = -1 - j`** (blueprint §B′.4, PR3).  On rung `j = -N` this is `N - 1`.

**This coefficient is rung-dependent.**  Blueprint §B′.9 item 1(b) singles this out: in the
light-cone expansion of `L_{-n}` it is the coefficient `-(η(b̃, p_j))` of the zero mode, and
writing it as a constant produces a *false* leading-term lemma.  The rung-independent
coefficient is the other one, `-(η(b, p_j)) = -1` (`conjCoeff_towerMomentum`).

Contrast `dotVec_trans_towerMomentum`, where the answer *is* rung-independent (namely `0`)
and no hypothesis beyond (F5)+(F6) is needed. -/
theorem DDFLightConeFrame.dotVec_conj_towerMomentum {η a b : Fin D → R} (hD : 2 ≤ D)
    (F : DDFLightConeFrame η a b) (j : ℤ) :
    dotVec η F.frame.conj (towerMomentum a b j) = -1 - (j : R) := by
  rw [F.conj_eq_light_sub_momentum hD, dotVec_vec_towerMomentum, dotVec_sub_left,
    dotVec_sub_left, F.hba, F.dotVec_self_eq_two hD, F.frame.isotropic, dotVec_comm η a b,
    F.hba]
  ring

end ConjEq

/-! ### Light-cone creation operators -/

section LcCrea

variable {D : ℕ} {R : Type*} [CommRing R]

/-- **The light-cone creation operator** `α^w_{-n} = ∑_μ η_μ w^μ α^μ_{-n}`, acting on the
Fock vacuum.  `n = 1` is `Fock.polState` (`lcCrea_one`, definitionally) and `n = 2` is
`Fock.secondState`; this is blueprint §B′.4's `lcCrea`.

The polarisation `w` is arbitrary: the frame enters only when `w` is taken from `frameVec`. -/
noncomputable def lcCrea (η w : Fin D → R) (n : ℕ+) : Fock D R :=
  ∑ μ : Fin D, (η μ * w μ) • (X ((μ, n) : Osc D) : Fock D R)

lemma lcCrea_def (η w : Fin D → R) (n : ℕ+) :
    lcCrea η w n = ∑ μ : Fin D, (η μ * w μ) • (X ((μ, n) : Osc D) : Fock D R) := rfl

/-- At mode number `1` the light-cone creation operator is the level-one state of
`NoGhost/PhysicalStates.lean`. -/
@[simp]
lemma lcCrea_one (η w : Fin D → R) : lcCrea η w 1 = Fock.polState η w := rfl

@[simp]
lemma lcCrea_zero (η : Fin D → R) (n : ℕ+) : lcCrea η (0 : Fin D → R) n = 0 := by
  rw [lcCrea_def]
  exact Finset.sum_eq_zero fun μ _ => by simp

lemma lcCrea_add (η w w' : Fin D → R) (n : ℕ+) :
    lcCrea η (w + w') n = lcCrea η w n + lcCrea η w' n := by
  rw [lcCrea_def, lcCrea_def, lcCrea_def, ← Finset.sum_add_distrib]
  exact Finset.sum_congr rfl fun μ _ => by
    simp only [Pi.add_apply, mul_add]
    rw [add_smul]

lemma lcCrea_smul (η : Fin D → R) (c : R) (w : Fin D → R) (n : ℕ+) :
    lcCrea η (c • w) n = c • lcCrea η w n := by
  rw [lcCrea_def, lcCrea_def, Finset.smul_sum]
  exact Finset.sum_congr rfl fun μ _ => by
    simp only [Pi.smul_apply, smul_eq_mul, smul_smul]
    ring_nf

lemma lcCrea_sum {ι : Type*} (η : Fin D → R) (s : Finset ι) (f : ι → Fin D → R) (n : ℕ+) :
    lcCrea η (∑ i ∈ s, f i) n = ∑ i ∈ s, lcCrea η (f i) n := by
  classical
  induction s using Finset.induction_on with
  | empty => simp
  | insert a s ha ih =>
      rw [Finset.sum_insert ha, Finset.sum_insert ha, lcCrea_add, ih]

/-- The bundled linear map `w ↦ α^w_{-n}`.  Used to push spans of polarisations forward to
spans of Fock vectors (`lcCrea_mem_span_range_frameVec`). -/
noncomputable def lcCreaₗ (η : Fin D → R) (n : ℕ+) : (Fin D → R) →ₗ[R] Fock D R where
  toFun w := lcCrea η w n
  map_add' := fun w w' => lcCrea_add η w w' n
  map_smul' := fun c w => lcCrea_smul η c w n

@[simp]
lemma lcCreaₗ_apply (η : Fin D → R) (n : ℕ+) (w : Fin D → R) :
    lcCreaₗ η n w = lcCrea η w n := rfl

/-- **`α^μ_{-n}` is a light-cone creation operator**, for the polarisation
`Pi.single μ η_μ`.  The `n = 1` case is `LevelTwoElim.X_one_eq_polState_single`; that file is
not imported, so the general statement is proved here from scratch (same two lines). -/
theorem X_eq_lcCrea_single (η : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (μ : Fin D) (n : ℕ+) :
    (X ((μ, n) : Osc D) : Fock D R) = lcCrea η (Pi.single μ (η μ)) n := by
  classical
  rw [lcCrea_def, Finset.sum_eq_single μ]
  · rw [Pi.single_eq_same, hη μ, one_smul]
  · intro ν _ hν
    rw [Pi.single_eq_of_ne hν, mul_zero, zero_smul]
  · intro h
    exact absurd (Finset.mem_univ μ) h

/-- `α^w_{-n}` raises the oscillator level by `n`. -/
theorem lcCrea_mem_levelSubmodule (η w : Fin D → R) (n : ℕ+) :
    lcCrea η w n ∈ Fock.levelSubmodule D R (n : ℕ) := by
  rw [lcCrea_def]
  refine Submodule.sum_mem _ fun μ _ => Submodule.smul_mem _ _ ?_
  exact isWeightedHomogeneous_X R (Fock.oscLevel D) ((μ, n) : Osc D)

end LcCrea

/-! ### The light-cone direction table -/

section FrameVec

variable {D : ℕ} {R : Type*} [CommRing R] {η a b : Fin D → R}

/-- **The light-cone direction table**: `b`, `b̃`, `ε_1, …, ε_{D-2}` listed as a single map
`Fin D → (Fin D → R)`, so that light-cone monomials can be indexed by the *same* type
`Osc D = Fin D × ℕ+` as the standard oscillator monomials.

The shuffle is the numeral one (`0 ↦ b`, `1 ↦ b̃`, `μ ↦ ε_{μ-2}`); unlike
`LightCone.transIdx` it needs no `3 ≤ D` (for `D ≤ 1` the later branches are simply
unreachable).  **No bijection `Fin D ≃ Unit ⊕ Unit ⊕ Fin (D-2)` is built**, and none is
needed: the spanning argument only uses that `b`, `b̃` and the `ε_i` are *in* the range of
this map (`span_range_frameVec_eq_top`). -/
def frameVec (F : DDFLightConeFrame η a b) (μ : Fin D) : Fin D → R :=
  if _ : (μ : ℕ) = 0 then b
  else if _ : (μ : ℕ) = 1 then F.frame.conj
  else F.trans.vec ⟨(μ : ℕ) - 2, by have h := μ.isLt; omega⟩

@[simp]
lemma frameVec_zero (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) :
    frameVec F ⟨0, by omega⟩ = b := by
  simp [frameVec]

@[simp]
lemma frameVec_one (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) :
    frameVec F ⟨1, by omega⟩ = F.frame.conj := by
  simp [frameVec]

@[simp]
lemma frameVec_trans (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (i : Fin (D - 2)) :
    frameVec F ⟨(i : ℕ) + 2, by have := i.isLt; omega⟩ = F.trans.vec i := by
  have h0 : ((i : ℕ) + 2) ≠ 0 := by omega
  have h1 : ((i : ℕ) + 2) ≠ 1 := by omega
  simp only [frameVec, dif_neg h0, dif_neg h1]
  congr 1

/-- **The light-cone directions span everything.**  Immediate from `exists_frame_decomp`: the
three groups of terms there are scalar multiples of `frameVec F ⟨0⟩`, `frameVec F ⟨1⟩` and the
`frameVec F ⟨i+2⟩`.  Only the *existence* of a decomposition is used, so this inherits
`exists_frame_decomp`'s `[CommRing R]` (no field, no `[Algebra ℚ R]`); `hD : 2 ≤ D` is needed
only to name the indices `0` and `1`. -/
theorem span_range_frameVec_eq_top (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) :
    Submodule.span R (Set.range (frameVec F)) = ⊤ := by
  rw [eq_top_iff]
  rintro e -
  obtain ⟨lam, mu, c, hdec⟩ := F.exists_frame_decomp e
  rw [hdec]
  refine Submodule.add_mem _ (Submodule.add_mem _ ?_ ?_) ?_
  · exact Submodule.smul_mem _ _ (Submodule.subset_span ⟨⟨0, by omega⟩, frameVec_zero hD F⟩)
  · exact Submodule.smul_mem _ _ (Submodule.subset_span ⟨⟨1, by omega⟩, frameVec_one hD F⟩)
  · exact Submodule.sum_mem _ fun i _ =>
      Submodule.smul_mem _ _ (Submodule.subset_span ⟨_, frameVec_trans hD F i⟩)

/-- Every light-cone creation operator, for **any** polarisation, is a combination of the
`D` frame ones at the same mode number.  This is `span_range_frameVec_eq_top` pushed through
the linear map `lcCreaₗ`. -/
theorem lcCrea_mem_span_range_frameVec (hD : 2 ≤ D) (F : DDFLightConeFrame η a b)
    (w : Fin D → R) (n : ℕ+) :
    lcCrea η w n ∈ Submodule.span R (Set.range fun t : Fin D => lcCrea η (frameVec F t) n) := by
  have hw : w ∈ Submodule.span R (Set.range (frameVec F)) := by
    rw [span_range_frameVec_eq_top hD F]
    trivial
  have h := Submodule.apply_mem_span_image_of_mem_span (lcCreaₗ η n) hw
  rw [← Set.range_comp] at h
  exact h

end FrameVec

end StringFormal.NoGhost
