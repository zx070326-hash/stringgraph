/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.LevelTwoSpan
import StringFormal.NoGhost.Assembly
import StringFormal.NoGhost.LightConeResolution

/-!
# Level two: towards the `N = 2` spanning elimination (blueprint §B.6 (c))

This file starts on the one blocker left open by `LevelTwoSpan.lean`'s docstring: proving
`towerPhys_bigrade_two_le_ddfSpan_sup_spurious`, i.e. that every physical state on the slice
`towerBigrade D R (-2) 2` lies in `ddfSpan ⊔ towerSpuriousSubmodule`.

**This file does not complete that theorem.** It delivers the pieces that compile:

* the tower-level lift of `Fock.Lop_neg_one_apply_polState`, describing the image of
  `towerLop η a b (-1)` on the *entire* level-one fiber of a rung (not just the vacuum), and
  its membership in `towerSpuriousSubmodule`;
* the atom `X_one_eq_polState_single`, identifying the raw coordinate generator `α^μ_{-1}` as
  `polState η (Pi.single μ (η μ))`, and the resulting reformulation of the level-two
  "quadratic" building block `Σ_μ X_{(μ,1)} * polState η (v μ)` as a sum of
  `polState η _ * polState η _` products — i.e. a genuinely *bilinear symmetric* pairing on
  the level-one fiber `Fin D → R`;
* **the `hFullSpan` hypothesis** `FrameSpansFull` — the "resolution of the identity"
  strengthening of `FrameSpansOrthogonal` that blueprint §B.6 (c) needs (`{b, b̃, ε_i}` spans
  *all* of `Fin D → R`, not just `v^⊥`), stated as an *explicit* dot-product formula (no
  `Classical.choose`) since the full Gram matrix of the frame is already pinned down by
  `LightConeFrame`/`TransverseFrame`. **This is now a theorem, not just a hypothesis, when the
  frame comes from a `DDFLightConeFrame`**: `DDFLightConeFrame.frameSpansFull`
  (`NoGhost/LightConeResolution.lean`, needs `[Field R] [Algebra ℚ R]` and `hD : 2 ≤ D`) derives
  it from `(F1)`–`(F8)` alone, via `DDFLightConeFrame.conj_eq_light_sub_momentum` (`b̃ = b - a`,
  forced) and `DDFLightConeFrame.resolution`;
* **`sum_X_one_mul_polState_eq_frame_decomp`**: given `hFullSpan`, the quadratic block collapses
  to exactly *three* `polState * polState` products — `polState η A * polState η b`,
  `polState η B * polState η B.conj`, and `Σᵢ polState η (Γᵢ) * polState η (Ε.vec i)` — where
  `A`, `B`, `Γᵢ` are explicit column-collapsed vectors (`sum_smul_polState_single_eq_polState`).
  This decomposes only the *row* index of `v`; the coordinate index `μ` is never itself
  decomposed into the frame, which is what keeps this to three products instead of the naive
  six `(b,b) (b,b̃) (b,ε) (b̃,b̃) (b̃,ε) (ε,ε)` pairings one would get by decomposing both indices.

## Gaps / what remains for `(c)`

`sum_X_one_mul_polState_eq_frame_decomp` is as far as pure linear algebra against the frame
goes. What is *not* done, and is a genuinely nontrivial amount of remaining work, is
identifying the three products above with the known spurious/DDF generators of
`LevelTwoSpan.lean`:

1. The `Σᵢ polState η (Γᵢ) * polState η (Ε.vec i)` summand is close to
   `single_ddfPair_mem_ddfSpan`/`single_ddfSecond_mem_ddfSpan` (the transverse DDF generators),
   but those are stated for a *fixed* polarisation pair, not for the `Γᵢ` produced here; matching
   requires further identities relating `Γᵢ` to `ε_i` itself (using `levelTwoL1 = 0`).
2. The `polState η A * polState η b` and `polState η B * polState η B.conj` summands are **not**
   directly `towerLop_neg_one_apply_single_polState_mem_towerSpuriousSubmodule`: that spurious
   generator pairs a *single* polarisation `e` against the actual momentum `p_j` (a *fixed*
   `b`/`b̃` mixture, `b̃`-coefficient pinned to `-1` by `conjCoeff_eq_neg_dotVec`), not against
   `b` and `B.conj` separately. Reconstituting the momentum-paired form (or showing the physical
   constraints force `A`, `B` into the right combination) requires solving
   `Fock.levelTwoL1 η p v w = 0`, `Fock.levelTwoL2 η p v w = 0`
   (`mem_towerPhys_bigrade_two_iff`) together with the mass shell — the genuine "medium
   difficulty" linear system of blueprint §B.6 (c), not attempted here.
3. Assemble the final membership proof and wire it to `ddfSpansOn_towerLevelLE_of_antidiagonal`
   the way `ddfSpans_bigrade_neg_one_one` does at `N = 1`.

`formal/TODO.md` under `noghost-n2` records this breakdown.
-/

namespace StringFormal.NoGhost

open MvPolynomial

/-! ### The image of `L_{-1}` on the whole level-one fiber, transported to the tower -/

section TowerSpuriousLevelOne

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

/-- **`L_{-1}` on a general rung-`j` level-one state, on the momentum tower.** The tower lift
of `Fock.Lop_neg_one_apply_polState`. -/
theorem towerLop_neg_one_apply_single_polState (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (j : ℤ) (e : Fin D → R) :
    towerLop η a b (-1) (Finsupp.single j (Fock.polState η e))
      = Finsupp.single j (Fock.secondState η e
          + Fock.polState η e * Fock.polState η (towerMomentum a b j)) := by
  rw [towerLop_single, Fock.Lop_neg_one_apply_polState η (towerMomentum a b j) hη e]

/-- The image of `towerLop η a b (-1)` on the level-one fiber of rung `j` lies in
`towerSpuriousSubmodule η a b`, for *every* polarisation `e : Fin D → R` (not just an
`e` adapted to a light-cone frame). This is the `n = 1` piece of the spurious submodule at
level two. -/
theorem towerLop_neg_one_apply_single_polState_mem_towerSpuriousSubmodule
    (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (j : ℤ) (e : Fin D → R) :
    (Finsupp.single j (Fock.secondState η e
        + Fock.polState η e * Fock.polState η (towerMomentum a b j)) : TowerFock D R)
      ∈ towerSpuriousSubmodule η a b := by
  rw [← towerLop_neg_one_apply_single_polState η a b hη j e]
  exact towerLop_neg_mem_towerSpuriousSubmodule (by norm_num) _

end TowerSpuriousLevelOne

/-! ### The level-two quadratic building block as a bilinear pairing -/

section BilinearReform

variable {D : ℕ} {R : Type*} [CommRing R]

/-- **The raw coordinate creation operator `α^μ_{-1}` is `polState η` of the `μ`-th standard
basis vector, raised once by `η`.** This turns the "outer sum over the coordinate basis" in
`Fock.levelTwoGen` into a sum of `polState η _ * polState η _` products (see
`sum_X_one_mul_polState_eq_sum_polState_mul_polState` below), which is what makes the
`N = 2` quadratic building block a genuinely *bilinear symmetric* pairing on `Fin D → R`,
rather than requiring a ring-level change of basis (blueprint §B.4). -/
theorem X_one_eq_polState_single (η : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (μ : Fin D) :
    (X ((μ, 1) : Osc D) : Fock D R) = Fock.polState η (Pi.single μ (η μ)) := by
  classical
  rw [Fock.polState, Finset.sum_eq_single μ]
  · rw [Pi.single_eq_same, hη μ, one_smul]
  · intro ν _ hν
    rw [Pi.single_eq_of_ne hν, mul_zero, zero_smul]
  · intro h
    exact absurd (Finset.mem_univ μ) h

/-- **The level-two quadratic block, reformulated as a sum of `polState * polState`
products.** Rewrites `Σ_μ α^μ_{-1} (v_μ · α_{-1})` (the non-`secondState` half of
`Fock.levelTwoGen`) so that both factors of every summand are `Fock.polState η` of an
explicit element of `Fin D → R`; this is the identity blueprint §B.6 (c) uses to reduce the
`N = 2` elimination to linear algebra on `Fin D → R` against the light-cone frame, instead of
a ring-level basis change on the whole `MvPolynomial` generators. -/
theorem sum_X_one_mul_polState_eq_sum_polState_mul_polState
    (η : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (v : Fin D → Fin D → R) :
    (∑ μ : Fin D, (X ((μ, 1) : Osc D) : Fock D R) * Fock.polState η (v μ))
      = ∑ μ : Fin D, Fock.polState η (Pi.single μ (η μ)) * Fock.polState η (v μ) :=
  Finset.sum_congr rfl fun μ _ => by rw [X_one_eq_polState_single η hη μ]

end BilinearReform

/-! ### The `hFullSpan` hypothesis: a resolution of the identity in the light-cone frame -/

section FrameDecomposition

variable {D : ℕ} {R : Type*} [CommRing R]

/-- **Resolution of the identity in a light-cone frame** — the strengthening of
`FrameSpansOrthogonal` needed at `N = 2` (item 1 of this file's Gaps section, `hFullSpan`).
`FrameSpansOrthogonal` only says `{ε_i, v}` spans `v^⊥`; this says `{b, b̃, ε_i}` spans *all* of
`Fin D → R`, with the coefficients pinned by the frame's own Gram matrix
(`b·b = 0`, `b̃·b̃ = 0`, `b·b̃ = -1`, `ε_i·b = ε_i·b̃ = 0`, `ε_i·ε_j = δ_ij`): every
`e : Fin D → R` decomposes as `e = -(b̃·e)•b - (b·e)•b̃ + Σᵢ (εᵢ·e)•εᵢ`. This is an *explicit*
formula (no `Classical.choose` needed to extract it), and over a general `CommRing` it is a
genuine extra hypothesis: bare `FrameSpansOrthogonal` (spanning `v^⊥`, one dimension short of
everything) does not give it. **Over a field with `[Algebra ℚ R]`, `DDFLightConeFrame.conj` and
`DDFLightConeFrame.resolution` (`NoGhost/LightConeResolution.lean`) prove `FrameSpansFull` from
`DDFLightConeFrame` itself** (`DDFLightConeFrame.frameSpansFull` below) — the frame's own Gram
matrix already pins `b̃ = b - a` and the full resolution, so this is no longer a bare assumption
when the frame comes from a `DDFLightConeFrame`; it is stated abstractly here (for a general
`LightConeFrame`/`TransverseFrame` pair over a `CommRing`) because blueprint §B.6 (c)'s later
lemmas only need the resolution formula itself, not where it came from. -/
def FrameSpansFull (η b : Fin D → R) (B : LightConeFrame η b) (Ε : TransverseFrame η b) : Prop :=
  ∀ e : Fin D → R,
    e = (-(dotVec η B.conj e)) • b + (-(dotVec η b e)) • B.conj
        + ∑ i : Fin (D - 2), dotVec η (Ε.vec i) e • Ε.vec i

/-- The `polState` image of `FrameSpansFull`'s decomposition, via linearity of `polState`. -/
theorem polState_eq_of_frameSpansFull (η b : Fin D → R) (B : LightConeFrame η b)
    (Ε : TransverseFrame η b) (hFull : FrameSpansFull η b B Ε) (e : Fin D → R) :
    Fock.polState η e
      = (-(dotVec η B.conj e)) • Fock.polState η b + (-(dotVec η b e)) • Fock.polState η B.conj
          + ∑ i : Fin (D - 2), dotVec η (Ε.vec i) e • Fock.polState η (Ε.vec i) := by
  conv_lhs => rw [hFull e]
  rw [Fock.polState_add, Fock.polState_add, Fock.polState_smul, Fock.polState_smul,
    Fock.polState_sum]
  congr 1
  exact Finset.sum_congr rfl fun i _ => Fock.polState_smul η _ _

end FrameDecomposition

section FrameDecompositionDDF

variable {D : ℕ} {R : Type*} [Field R] [Algebra ℚ R]

/-- **`hFullSpan` discharged for a `DDFLightConeFrame`.** `FrameSpansFull` is no longer a bare
extra hypothesis once the frame comes from a `DDFLightConeFrame`
(`NoGhost/LightConeResolution.lean`'s `DDFLightConeFrame.resolution`); the Gram matrix of `(F1)`–
`(F8)` alone forces the resolution of the identity, given `hD : 2 ≤ D` and `[Algebra ℚ R]`
(see that file's Gaps note on the characteristic-`2` caveat). -/
theorem DDFLightConeFrame.frameSpansFull {η a b : Fin D → R} (hD : 2 ≤ D)
    (F : DDFLightConeFrame η a b) : FrameSpansFull η b F.frame F.trans :=
  fun e => F.resolution hD e

end FrameDecompositionDDF

/-! ### Collapsing a column sum of raw creation operators back into `polState` -/

section ColumnCollapse

variable {D : ℕ} {R : Type*} [CommRing R]

/-- **A weighted sum of the `η`-raised standard basis vectors `e_μ = Pi.single μ (η μ)` is a
single vector.** This is the "column collapse" identity: `Σ_μ f(μ) e_μ = (ν ↦ f(ν) η(ν))`,
used to turn a sum over the *row* index `μ` of frame-decomposition coefficients back into a
single polarisation once the row-wise decomposition has been pushed through
`Σ_μ α^μ_{-1} (v_μ · α_{-1})`. -/
theorem sum_smul_single_eq (η f : Fin D → R) :
    (∑ μ : Fin D, f μ • Pi.single μ (η μ) : Fin D → R) = fun ν => f ν * η ν := by
  classical
  funext ν
  rw [Finset.sum_apply, Finset.sum_eq_single ν]
  · rw [Pi.smul_apply, smul_eq_mul, Pi.single_eq_same]
  · intro μ _ hμν
    rw [Pi.smul_apply, smul_eq_mul, Pi.single_eq_of_ne (Ne.symm hμν), mul_zero]
  · intro h
    exact absurd (Finset.mem_univ ν) h

/-- The `polState` version of `sum_smul_single_eq`: a weighted sum of the raw coordinate
generators `α^μ_{-1}` (as `polState η e_μ`, via `X_one_eq_polState_single`) collapses to
`polState η` of a single explicit vector. -/
theorem sum_smul_polState_single_eq_polState (η f : Fin D → R) :
    (∑ μ : Fin D, f μ • Fock.polState η (Pi.single μ (η μ)))
      = Fock.polState η (fun ν => f ν * η ν) := by
  rw [← sum_smul_single_eq η f, Fock.polState_sum]
  exact Finset.sum_congr rfl fun μ _ => (Fock.polState_smul η (f μ) _).symm

end ColumnCollapse

/-! ### The level-two quadratic block in frame components -/

section FrameQuadraticBlock

variable {D : ℕ} {R : Type*} [CommRing R]

/-- **The level-two quadratic block `Σ_μ α^μ_{-1} (v_μ · α_{-1})`, pushed through a full
light-cone frame decomposition.** Given `hFullSpan` (`FrameSpansFull`), every row `v μ` of the
level-two tensor decomposes into the frame `{b, b̃, ε_i}`; feeding that through the bilinear
reformulation `sum_X_one_mul_polState_eq_sum_polState_mul_polState` and collapsing the column
sums with `sum_smul_polState_single_eq_polState` lands the whole block on exactly the `D` pairs
`(A, b)`, `(B, b̃)`, `(Γ_i, ε_i)` — i.e. blueprint §B.6 (c) items 1–2 of this file's Gaps
section. What is *not* done is identifying these three `polState * polState` products with the
spurious/DDF generators of `LevelTwoSpan.lean` (`towerLop_neg_one_apply_single_polState`,
`single_ddfSecond_mem_ddfSpan`, `single_ddfPair_mem_ddfSpan`) — Gaps item 3, which needs the
physical constraints `levelTwoL1 = 0`/`levelTwoL2 = 0` together with the mass shell, not just
this change of basis. -/
theorem sum_X_one_mul_polState_eq_frame_decomp
    (η b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (B : LightConeFrame η b)
    (Ε : TransverseFrame η b) (hFull : FrameSpansFull η b B Ε) (v : Fin D → Fin D → R) :
    (∑ μ : Fin D, (X ((μ, 1) : Osc D) : Fock D R) * Fock.polState η (v μ))
      = Fock.polState η (fun ν => (-(dotVec η B.conj (v ν))) * η ν) * Fock.polState η b
        + Fock.polState η (fun ν => (-(dotVec η b (v ν))) * η ν) * Fock.polState η B.conj
        + ∑ i : Fin (D - 2),
            Fock.polState η (fun ν => dotVec η (Ε.vec i) (v ν) * η ν)
              * Fock.polState η (Ε.vec i) := by
  classical
  rw [sum_X_one_mul_polState_eq_sum_polState_mul_polState η hη v]
  have hstep : ∀ μ : Fin D,
      Fock.polState η (Pi.single μ (η μ)) * Fock.polState η (v μ)
        = (-(dotVec η B.conj (v μ))) • (Fock.polState η (Pi.single μ (η μ)) * Fock.polState η b)
          + (-(dotVec η b (v μ))) •
              (Fock.polState η (Pi.single μ (η μ)) * Fock.polState η B.conj)
          + ∑ i : Fin (D - 2), dotVec η (Ε.vec i) (v μ) •
              (Fock.polState η (Pi.single μ (η μ)) * Fock.polState η (Ε.vec i)) := by
    intro μ
    rw [polState_eq_of_frameSpansFull η b B Ε hFull (v μ)]
    simp only [mul_add, mul_smul_comm, Finset.mul_sum]
  simp_rw [hstep]
  rw [Finset.sum_add_distrib, Finset.sum_add_distrib]
  have hA : (∑ μ : Fin D, (-(dotVec η B.conj (v μ))) •
        (Fock.polState η (Pi.single μ (η μ)) * Fock.polState η b))
      = Fock.polState η (fun ν => (-(dotVec η B.conj (v ν))) * η ν) * Fock.polState η b := by
    simp_rw [← smul_mul_assoc]
    rw [← Finset.sum_mul, sum_smul_polState_single_eq_polState]
  have hB : (∑ μ : Fin D, (-(dotVec η b (v μ))) •
        (Fock.polState η (Pi.single μ (η μ)) * Fock.polState η B.conj))
      = Fock.polState η (fun ν => (-(dotVec η b (v ν))) * η ν) * Fock.polState η B.conj := by
    simp_rw [← smul_mul_assoc]
    rw [← Finset.sum_mul, sum_smul_polState_single_eq_polState]
  have hC : (∑ μ : Fin D, ∑ i : Fin (D - 2), dotVec η (Ε.vec i) (v μ) •
        (Fock.polState η (Pi.single μ (η μ)) * Fock.polState η (Ε.vec i)))
      = ∑ i : Fin (D - 2), Fock.polState η (fun ν => dotVec η (Ε.vec i) (v ν) * η ν)
          * Fock.polState η (Ε.vec i) := by
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun i _ => ?_
    simp_rw [← smul_mul_assoc]
    rw [← Finset.sum_mul, sum_smul_polState_single_eq_polState]
  rw [hA, hB, hC]

end FrameQuadraticBlock

end StringFormal.NoGhost
