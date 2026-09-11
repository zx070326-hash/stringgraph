/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.LevelTwoSpan
import StringFormal.NoGhost.Assembly

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
  the level-one fiber `Fin D → R`.

## Gaps / what remains for `(c)`

The bilinear reformulation above is the key structural fact needed to finish the spanning
elimination *without* the full "unitriangular basis change" machinery of blueprint §B.4
(which changes basis on the whole `MvPolynomial` generator set via an `AlgEquiv`, and is
flagged there as the most expensive section of the blueprint, ~400–700 lines). Because a
level-two state's non-`secondState` part is, after this reformulation, *only* a bilinear
pairing of two elements of the level-one fiber `Fin D → R`, changing basis on that pairing is
**pure linear algebra** on `Fin D → R` (no ring automorphism needed): given a hypothesis that
`{b, B.conj, Ε.vec 0, …, Ε.vec (D-3)}` is a basis of `Fin D → R` (strictly stronger than the
`v^⊥`-only `FrameSpansOrthogonal` used at `N = 1`; call it `hFullSpan`), one can push the
bilinear pairing through the decomposition and land purely in the six pairings
`(b,b) (b,b̃) (b,ε_i) (b̃,b̃) (b̃,ε_i) (ε_i,ε_j)`, each of which is an explicit Fock element.

What is *not* done, and is a genuinely nontrivial amount of remaining work:

1. State `hFullSpan` and derive, from it, explicit coefficient *functions*
   `c c' : Fin D → R` and `cᵢ : Fin (D - 2) → Fin D → R` with
   `v μ = c μ • b + c' μ • B.conj + ∑ i, cᵢ i μ • Ε.vec i` for every row `μ` (this needs
   `Classical.choose` applied pointwise, then repackaged as functions of `μ` — routine but
   not short).
2. Push the bilinear pairing through that decomposition (`Finset.sum` reindexing,
   `polState_add`/`polState_smul`/`polState_sum`), landing on the six pairings above.
3. Identify which of the six pairings are already DDF generators
   (`single_ddfPair_mem_ddfSpan` handles exactly the `ε_i · ε_j` piece, up to the
   trace correction) and which must be absorbed into `towerSpuriousSubmodule`. The `b`- and
   `b̃`-touching pairings are **not** simply `L_{-1}` of a single state each: `L_{-1}` at
   rung `j` produces `polState η x * polState η (towerMomentum a b j)`, i.e. a *fixed*
   `b`/`b̃`-mixture (pinned by `conjCoeff_towerMomentum`'s `c' = -1`), not `b` and `b̃`
   separately. Disentangling requires solving the physical-state constraints
   `Fock.levelTwoL1 = 0`, `Fock.levelTwoL2 = 0` (`mem_towerPhys_bigrade_two_iff`)
   *together with* the mass shell, not just a change of basis. This is the actual linear
   system that blueprint §B.6 calls "medium difficulty" and is not attempted here.
4. Assemble the final membership proof and wire it to `ddfSpansOn_towerLevelLE_of_antidiagonal`
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

end StringFormal.NoGhost
