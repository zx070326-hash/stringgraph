/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.LightConeFrame

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

**File name.** The blueprint calls this PR `NoGhost/LightConeResolution.lean`.  That name was
held by a concurrent `N = 2` task at the time of writing, so the general-`N` file is
`LightConeResolutionGen.lean`; the declarations are the ones the blueprint names.

## Main results

* `DDFLightConeFrame.exists_frame_decomp` — every `e : Fin D → R` decomposes as
  `lam • b + mu • b̃ + ∑ i, c i • ε_i`.  This is the frame completeness that
  `NoGhost/LevelTwoElim.lean`'s gap list guessed had to be *assumed* (`hFullSpan`): it is a
  theorem, over an arbitrary commutative ring, from (F1)–(F8).
* `DDFLightConeFrame.resolution` — the same decomposition with **explicit** coefficients,
  `e = -(b̃·e) • b - (b·e) • b̃ + ∑ i, (ε_i·e) • ε_i`.  No `Classical.choose`.
* `DDFLightConeFrame.conj_eq_light_sub_momentum` — `b̃ = b - a` (needs a field of
  characteristic `≠ 2`, see the deviations below).
* `DDFLightConeFrame.dotVec_conj_towerMomentum` — `b̃ · p_j = -1 - j`, i.e. `N - 1` on rung
  `j = -N`.  **The zero-mode coefficient of `α^{b̃}` is rung-dependent**; only the `b`-side
  coefficient `-(b · p_j) = -1` is rung-independent (`conjCoeff_towerMomentum`).  §B′.9 item
  1(b) flags getting this backwards as a way to produce a false leading-term lemma.
* `lcCrea η w n` — the light-cone creation operator `α^w_{-n} = ∑_μ η_μ w^μ X_{(μ,n)}`, with
  its linearity in `w` (`lcCreaₗ` is the bundled linear map) and the `n = 1` identification
  with `Fock.polState`.
* `X_eq_lcCrea_single` — `X_{(μ,n)} = lcCrea η (Pi.single μ η_μ) n`, the general-`n` form of
  `LevelTwoElim.X_one_eq_polState_single` (proved here independently; that file is not
  imported).
* `frameVec` / `lcMonomial` / `lcSpan` — the light-cone direction table (`b`, `b̃`,
  `ε_1, …, ε_{D-2}` listed as a map `Fin D → (Fin D → R)`), the associated monomials, and
  their span.
* `levelSubmodule_eq_span_lcMonomial` — **the light-cone monomials of level `N` span the
  level-`N` Fock fiber**.  Spanning only; linear independence is deliberately out of scope
  (blueprint §B′.9 item 2: it has no free proof and is not on the critical path).

## Deviations from the blueprint's §B′.4 draft (also appended to the blueprint's "§B′ 订正")

1. `resolution` needs **no** `[Field]` and **no** `2 ≤ D`.  The blueprint's route went through
   `conj_eq_light_sub_momentum` (hence through `dotVec_self_eq_two`, hence a field).  That is
   avoidable: (F4)'s span half plus `b·a = 1` already give `β = -1` in `b̃ = β • a + γ • b`,
   so `a - b = (γ - 1) • b - b̃` lies in `span{b, b̃}` **without knowing `γ`**, which is all
   the (F8) completeness statement (phrased on `(a-b)^⊥`) needs.  The coefficients are then
   pinned by pairing against `b`, `b̃`, `ε_j`, which is division-free.
2. `conj_eq_light_sub_momentum` needs `(2 : K) ≠ 0` on top of `[Field K]`.  The frame data
   only give `2 γ = η(a,a)`; with `dotVec_self_eq_two` that is `2 γ = 2`, and in
   characteristic `2` the conditions (F1)–(F8) genuinely do not pin `b̃`.  Stated here with
   `[CharZero K]` (the ambient DDF thread carries `[Algebra ℚ K]`, which is stronger).  The
   `2 ≤ D` hypothesis is inherited from `dotVec_self_eq_two`.
3. The blueprint's `lcMonomial` is indexed by an unspecified `frameVec F : Fin D → (Fin D → K)`
   "copying the index shuffling of `LightCone.transIdx`".  Here the shuffle is a `dite` on the
   numeral value of the index (`0 ↦ b`, `1 ↦ b̃`, `μ ↦ ε_{μ-2}`), which needs only `2 ≤ D` and
   avoids `transIdx`'s `3 ≤ D`.  Crucially **no bijection `Fin D ≃ Unit ⊕ Unit ⊕ Fin (D-2)` is
   ever built**: the spanning proof only needs `span (range (frameVec F)) = ⊤`, for which it
   suffices that `b`, `b̃` and each `ε_i` are *in* the range.  Consequence: the index type of
   the light-cone monomials is literally `Osc D = Fin D × ℕ+`, the same as for the standard
   monomials, so the two sides of §B′.8's counting comparison are indexed by the *same* set.
4. `levelSubmodule_eq_span_lcMonomial` is an equality of submodules of `Fock D R` for an
   arbitrary `[CommRing R]`; the blueprint asked only for `[Field K]`.

## Scope and gaps

* **Spanning only.**  `LinearIndependent` for the light-cone monomials is not proved and is
  not attempted (blueprint §B′.9 item 2).  Consequently nothing here upgrades
  `towerKerK_inf_towerBigrade_eq_conjFree` beyond its cheap `⊇` half.
* Nothing here is about the tower: `lcMonomial` lives in a single `Fock D R` fiber.  The rung
  bookkeeping (`towerBigrade`) enters only in PR4.
* The `b̃`-degree/weighted-degree pair `(β, ω)` of blueprint §B′.5 is *not* defined here; it
  belongs with the elimination induction of PR4.
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
`conj_eq_light_sub_momentum`, which needs a field of characteristic `≠ 2`). -/
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
PR3): for every `e`,
`e = -(b̃·e) • b + -(b·e) • b̃ + ∑ i, (ε_i·e) • ε_i`.

The coefficients are read off by pairing the (existentially given) decomposition of
`exists_frame_decomp` against `b`, `b̃` and `ε_j`; the six relevant contractions are
(F2) `b·b = 0`, (F4) `b·b̃ = -1` and `b̃·b̃ = 0`, (F5) `ε_i·b = 0`, (F7) `ε_i·ε_j = δ_{ij}`
and (F9) `ε_i·b̃ = 0` (`DDFLightConeFrame.dotVec_trans_conj_eq_zero`).  No division and no
`Classical.choose`. -/
theorem DDFLightConeFrame.resolution (F : DDFLightConeFrame η a b) (e : Fin D → R) :
    e = (-(dotVec η F.frame.conj e)) • b + (-(dotVec η b e)) • F.frame.conj
        + ∑ i, dotVec η (F.trans.vec i) e • F.trans.vec i := by
  classical
  obtain ⟨lam, mu, c, hdec⟩ := F.exists_frame_decomp e
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
  refine hdec.trans ?_
  rw [hbe, hconje, neg_neg, neg_neg]
  congr 1
  exact (Finset.sum_congr rfl fun j _ => by rw [hce j]).symm

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

/-! ### `b̃ = b - a`

Kept in its own section with `[Field K]` only (no separate `[CommRing K]` variable): see the
comment before `MassShell` in `NoGhost/LightConeFrame.lean` on the `overlappingInstances`
linter. -/

section ConjEq

variable {D : ℕ} {K : Type*} [Field K] [CharZero K]

/-- **`b̃ = b - a`** (blueprint §B′.4, PR3).  From the (F4) span condition
`b̃ = β • a + γ • b` one gets `β = -1` (`conjSpan_coeff_left`) and `2 γ = η(a,a)`
(`two_mul_conjSpan_coeff_right`); `DDFLightConeFrame.dotVec_self_eq_two` turns the latter into
`2 γ = 2`.

**`(2 : K) ≠ 0` is genuinely needed**, which is why `[CharZero K]` appears (only `2 ≠ 0` is
used; the ambient DDF thread's `[Algebra ℚ K]` is stronger).  In characteristic `2` the
conditions (F1)–(F8) do not determine `γ`: `η(a,a) = 2 = 0` there, and `2 γ = 0` holds for
every `γ`.  The blueprint's draft signature listed only `[Field K]`.

`2 ≤ D` is inherited from `dotVec_self_eq_two` (whose rank–nullity argument needs it). -/
theorem DDFLightConeFrame.conj_eq_light_sub_momentum {η a b : Fin D → K} (hD : 2 ≤ D)
    (F : DDFLightConeFrame η a b) : F.frame.conj = b - a := by
  obtain ⟨β, γ, hbt⟩ := F.hconjSpan
  have hβ : β = -1 := F.conjSpan_coeff_left hbt
  have hγ : γ = 1 := by
    have h2 : (2 : K) * γ = 2 * 1 := by
      rw [F.two_mul_conjSpan_coeff_right hbt, F.dotVec_self_eq_two hD, mul_one]
    exact mul_left_cancel₀ (two_ne_zero) h2
  funext μ
  rw [hbt, hβ, hγ]
  simp only [Pi.add_apply, Pi.sub_apply, Pi.smul_apply, smul_eq_mul]
  ring

/-- **`b̃ · p_j = -1 - j`** (blueprint §B′.4, PR3).  On rung `j = -N` this is `N - 1`.

**This coefficient is rung-dependent.**  Blueprint §B′.9 item 1(b) singles this out: in the
light-cone expansion of `L_{-n}` it is the coefficient `-(η(b̃, p_j))` of the zero mode, and
writing it as a constant produces a *false* leading-term lemma.  The rung-independent
coefficient is the other one, `-(η(b, p_j)) = -1` (`conjCoeff_towerMomentum`). -/
theorem DDFLightConeFrame.dotVec_conj_towerMomentum {η a b : Fin D → K} (hD : 2 ≤ D)
    (F : DDFLightConeFrame η a b) (j : ℤ) :
    dotVec η F.frame.conj (towerMomentum a b j) = -1 - (j : K) := by
  rw [F.conj_eq_light_sub_momentum hD, dotVec_vec_towerMomentum, dotVec_sub_left,
    dotVec_sub_left, F.hba, F.dotVec_self_eq_two hD, F.frame.isotropic, dotVec_comm η a b,
    F.hba]
  ring

end ConjEq

end StringFormal.NoGhost
