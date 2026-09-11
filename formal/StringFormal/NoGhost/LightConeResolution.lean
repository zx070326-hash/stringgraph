/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.LightConeFrame
import StringFormal.NoGhost.Sugawara

/-!
# The `DDFLightConeFrame` resolution of the identity

Graph node: `worldsheet.ddf-light-cone-frame`; blueprint `formal/BLUEPRINT-noghost.md` §B′.4
(PR3).

`LightConeFrame.lean`'s `DDFLightConeFrame` bundles conditions (F1)–(F8), including the span
hypothesis `hspan : FrameSpansOrthogonal η trans (towerMomentum a b (-1))` (F8): every vector
orthogonal to the momentum-tower direction `v := towerMomentum a b (-1)` decomposes into
`{ε_i, v}`.  Over a field this already pins down *two* facts that `NoGhost/LevelTwoElim.lean`'s
`FrameSpansFull` needed as a bare extra hypothesis:

* **`DDFLightConeFrame.conj_eq_light_sub_momentum`** — the conjugate direction bundled in
  `F.frame.conj` (`b̃`) is *forced* to be `b - a` (equivalently `-v`).  `hconjSpan` (F4) only
  says `b̃ = β•a + γ•b` for *some* `β, γ`; pairing that against `b` and against itself, using
  `hba` (F3) and `dotVec_self_eq_two` (the bonus (ii) theorem, itself from (F6)(F7)(F8)), pins
  `β = -1` unconditionally and `γ = 1` *given `(2:R) ≠ 0`* (available here from `[Algebra ℚ R]`,
  via `two_mul_invTwo`).  **This is a genuine extra hypothesis over the blueprint's bare
  `[Field K]` sketch**: in characteristic `2` the quadratic pairing equation `2β² + 2βγ = 0`
  degenerates to `0 = 0` for every `γ`, so `b̃` is *not* uniquely forced — see the Gaps note
  below.
* **`DDFLightConeFrame.resolution`** — combining the previous point with `hspan` (F8) itself
  applied to `e - (dotVec η e v)•b` (which is `⊥ v`, since `b·v = 1` from `hba` and `b·b = 0`)
  gives the full resolution of the identity `e = -(b̃·e)•b - (b·e)•b̃ + Σᵢ(εᵢ·e)•εᵢ` for
  *every* `e : Fin D → R`, i.e. `{b, b̃, ε_i}` spans everything, not just `v^⊥`.  This is
  exactly `NoGhost/LevelTwoElim.lean`'s `FrameSpansFull η b F.frame F.trans`
  (`DDFLightConeFrame.frameSpansFull`), so that hypothesis is no longer a bare assumption at
  `N = 2` when the frame comes from a `DDFLightConeFrame`.

## Gaps

* Both theorems need `hD : 2 ≤ D` (for `dotVec_self_eq_two`) **and** `[Algebra ℚ R]` (for
  `(2:R) ≠ 0`, via `two_mul_invTwo`) on top of the `[Field R]` that the blueprint's PR3 sketch
  stated. The `[Algebra ℚ R]` hypothesis is not cosmetic: over a field of characteristic `2`,
  `DDFLightConeFrame`'s own axioms (F1)–(F8) do **not** force `b̃ = b - a`, because the
  self-pairing equation used to solve for `γ` collapses to a tautology. Every other
  `DDFLightConeFrame` fact in this file's dependency chain already needs `[Algebra ℚ R]`
  (`dotVec_self_eq_two`'s own proof goes through `zeroModeSq`, and `DDFLightConeFrame` itself
  is only meaningfully instantiated in that scope in this codebase), so this does not shrink
  the applicability of the no-ghost formalisation island.
-/

namespace StringFormal.NoGhost

section Resolution

variable {D : ℕ} {R : Type*} [Field R] [Algebra ℚ R]

omit [Algebra ℚ R] in
/-- `dotVec` is linear in its left argument against a scalar multiple (private re-derivation:
the corresponding lemma in `LightConeFrame.lean` is `private` and not visible here). -/
private lemma dotVec_smul_left (η x y : Fin D → R) (c : R) :
    dotVec η (c • x) y = c * dotVec η x y := by
  rw [dotVec_comm η (c • x) y, dotVec_smul_right, dotVec_comm η y x]

omit [Algebra ℚ R] in
/-- `dotVec` is linear in its right argument against negation. -/
private lemma dotVec_neg_right (η x y : Fin D → R) : dotVec η x (-y) = -dotVec η x y := by
  rw [← neg_one_smul R y, dotVec_smul_right]
  ring

omit [Algebra ℚ R] in
/-- `dotVec` distributes over a finite sum in its right argument. -/
private lemma dotVec_sum_right {ι : Type*} (s : Finset ι) (f : ι → Fin D → R) (η x : Fin D → R) :
    dotVec η x (∑ i ∈ s, f i) = ∑ i ∈ s, dotVec η x (f i) := by
  simp only [dotVec, Finset.sum_apply, Finset.mul_sum]
  rw [Finset.sum_comm]

/-- **The conjugate direction is forced to be `b - a`.** See the file docstring for the
characteristic-2 caveat: `[Algebra ℚ R]` (giving `(2:R) ≠ 0`) is genuinely used, not just
`[Field R]`. -/
theorem DDFLightConeFrame.conj_eq_light_sub_momentum {η a b : Fin D → R} (hD : 2 ≤ D)
    (F : DDFLightConeFrame η a b) : F.frame.conj = b - a := by
  classical
  obtain ⟨β, γ, hbt⟩ := F.hconjSpan
  have haa : dotVec η a a = 2 := F.dotVec_self_eq_two hD
  have hab : dotVec η a b = 1 := by rw [dotVec_comm]; exact F.hba
  have hbb : dotVec η b b = 0 := F.frame.isotropic
  have hβ : β = -1 := by
    have h1 : dotVec η b F.frame.conj = β * dotVec η b a + γ * dotVec η b b := by
      rw [hbt, dotVec_add_right, dotVec_smul_right, dotVec_smul_right]
    rw [F.frame.pairing, F.hba, hbb, mul_zero, add_zero, mul_one] at h1
    exact h1.symm
  have hγ : γ = 1 := by
    have hexpand : dotVec η (β • a + γ • b) (β • a + γ • b)
        = β ^ 2 * dotVec η a a + β * γ * dotVec η a b + γ * β * dotVec η b a
            + γ ^ 2 * dotVec η b b := by
      simp only [dotVec_add_left, dotVec_add_right, dotVec_smul_left, dotVec_smul_right]
      ring
    have h2 : dotVec η F.frame.conj F.frame.conj
        = β ^ 2 * dotVec η a a + β * γ * dotVec η a b + γ * β * dotVec η b a
            + γ ^ 2 * dotVec η b b := by
      rw [hbt]; exact hexpand
    rw [F.frame.conj_isotropic, haa, dotVec_comm η b a, hab, hbb, hβ] at h2
    have h2ne : (2 : R) ≠ 0 := by
      intro h
      have h1 := two_mul_invTwo R
      rw [h, zero_mul] at h1
      exact zero_ne_one h1
    have hfact : (2 : R) * (1 - γ) = 0 := by linear_combination -h2
    rcases mul_eq_zero.mp hfact with h | h
    · exact absurd h h2ne
    · linear_combination -h
  rw [hbt, hβ, hγ]
  module

/-- **Resolution of the identity in a `DDFLightConeFrame`.** Every `e : Fin D → R` decomposes
into `{b, b̃, ε_i}`, with the coefficients pinned by the frame's Gram matrix — this is
`NoGhost/LevelTwoElim.lean`'s `FrameSpansFull η b F.frame F.trans` (see
`DDFLightConeFrame.frameSpansFull` in `LevelTwoElim.lean`), proved rather than assumed. -/
theorem DDFLightConeFrame.resolution {η a b : Fin D → R} (hD : 2 ≤ D)
    (F : DDFLightConeFrame η a b) (e : Fin D → R) :
    e = (-(dotVec η F.frame.conj e)) • b + (-(dotVec η b e)) • F.frame.conj
        + ∑ i : Fin (D - 2), dotVec η (F.trans.vec i) e • F.trans.vec i := by
  classical
  have hbv : dotVec η b (towerMomentum a b (-1)) = 1 := by
    rw [dotVec_towerMomentum_right_of_isotropic η a b F.frame.isotropic (-1), F.hba]
  have he' : dotVec η (e + (-(dotVec η e (towerMomentum a b (-1)))) • b)
      (towerMomentum a b (-1)) = 0 := by
    rw [dotVec_add_left, dotVec_smul_left, hbv, mul_one]
    ring
  obtain ⟨c, c₀, hdecomp⟩ :=
    F.hspan (e + (-(dotVec η e (towerMomentum a b (-1)))) • b) he'
  have htower0 : towerMomentum a b (-1) = a - b := by
    funext μ
    simp only [towerMomentum_apply, Pi.sub_apply]
    push_cast
    ring
  have hvconj : towerMomentum a b (-1) = -F.frame.conj := by
    rw [htower0, F.conj_eq_light_sub_momentum hD, neg_sub]
  rw [hvconj, dotVec_neg_right, neg_neg, smul_neg, dotVec_comm η e F.frame.conj] at hdecomp
  have heDecomp : e = (-(dotVec η F.frame.conj e)) • b + (-c₀) • F.frame.conj
      + ∑ i, c i • F.trans.vec i := by
    linear_combination (norm := module) hdecomp
  have hb_b : dotVec η b b = 0 := F.frame.isotropic
  have hb_conj : dotVec η b F.frame.conj = -1 := F.frame.pairing
  have hb_trans : ∀ i, dotVec η b (F.trans.vec i) = 0 := fun i => by
    rw [dotVec_comm]; exact F.trans.transverse i
  have htrans_b : ∀ j, dotVec η (F.trans.vec j) b = 0 := F.trans.transverse
  have htrans_conj : ∀ j, dotVec η (F.trans.vec j) F.frame.conj = 0 :=
    F.dotVec_trans_conj_eq_zero
  have htrans_trans : ∀ j i, dotVec η (F.trans.vec j) (F.trans.vec i)
      = if j = i then 1 else 0 := F.trans.orthonormal
  have hpair : ∀ w : Fin D → R, dotVec η w e
      = (-(dotVec η F.frame.conj e)) * dotVec η w b + (-c₀) * dotVec η w F.frame.conj
          + ∑ i, c i * dotVec η w (F.trans.vec i) := by
    intro w
    conv_lhs => rw [heDecomp]
    simp only [dotVec_add_right, dotVec_smul_right, dotVec_sum_right]
  have hc0 : c₀ = dotVec η b e := by
    have h := hpair b
    simp only [hb_b, hb_conj, hb_trans, mul_zero, zero_add, mul_neg, mul_one, neg_neg,
      Finset.sum_const_zero, add_zero] at h
    exact h.symm
  have hc : ∀ j, c j = dotVec η (F.trans.vec j) e := by
    intro j
    have h := hpair (F.trans.vec j)
    rw [htrans_b j, htrans_conj j] at h
    simp only [mul_zero, zero_add, htrans_trans j, mul_ite, mul_one] at h
    simpa using h.symm
  conv_lhs => rw [heDecomp]
  rw [hc0]
  simp_rw [hc]

end Resolution

end StringFormal.NoGhost
