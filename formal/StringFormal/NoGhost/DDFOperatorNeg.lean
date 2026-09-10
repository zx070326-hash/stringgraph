/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.DDFOperator
import StringFormal.NoGhost.VertexWeightNeg

/-!
# `⁅L_m, A^ε_n⁆ = 0` for every `m ≠ 0`

Graph nodes: `worldsheet.ddf-commute-with-virasoro` (this file upgrades the formalised part
from `m ≥ 1` to all `m ≠ 0`), `worldsheet.ddf-operators-v6`.
`formal/TODO.md` item `ddf-operators`, sub-item (4).

## What is here

`StringFormal/NoGhost/DDFOperator.lean` proved `⁅L_m, A^ε_n⁆ = 0` only for `m ≥ 1`, because
the single-Fock conformal-weight identity was available only there
(`Fock.lie_Lop_vertexOsc_of_pos`).  `StringFormal/NoGhost/VertexWeightNeg.lean` has since
supplied the `m ≤ -1` half (`Fock.lie_Lop_vertexOsc_of_neg`) and the merged
`Fock.lie_Lop_vertexOsc_of_ne`.  This file transports that to the DDF momentum tower and
reruns the telescoping sum:

* `lie_towerLop_towerVertex_of_ne` / `_of_neg` — `⁅L_m, V^{(n)}_K⁆ =
  (K - m - n + n (k_0·p)) V^{(n)}_{K-m}` on the tower, for every `m ≠ 0`; the isotropy
  hypothesis `k_0² = 0` is needed for exactly the same reason as in the `m ≥ 1` case (the
  rung-dependence of the coefficient), see `lie_towerLop_towerVertex_of_pos`.
* `lie_towerLop_towerVertex_of_ne_normalized` / `_of_neg_normalized` — the DDF-normalised
  weight-`0` form `⁅L_m, V^{(n)}_K⁆ = (K - m) V^{(n)}_{K-m}`.
* `lie_towerLop_ddfSummand_of_ne` — the telescoping form of the bracket with one summand.
* **`lie_towerLop_ddfOp_of_ne`** / `lie_towerLop_ddfOp_of_neg` — `⁅L_m, A^ε_n⁆ = 0` for
  every `m ≠ 0`.

## The window, for both signs of `m`

The telescoping in `lie_towerLop_ddfOp_of_pos` summed `g (j - m) - g j` over a window
`[lo, up]` and used that the two boundary strips vanish.  For `m > 0` the strips are
`[lo - m, lo - 1]` (killed by the *lower* cut-off: the vertex operator cannot lower the
level below the vacuum) and `[up - m + 1, up]` (killed by the *upper*, transversality
cut-off).  For `m < 0` the shift `j ↦ j - m` runs the other way and the two strips **swap
sides**: they become `[lo, lo - m - 1]` — which now sits *above* `lo` yet still has to be
killed by the *lower* cut-off — and `[up + 1, up - m]`, still to be killed by the upper one.

Nothing is lost, but the window can no longer be the minimal one: it must carry slack `|m|`
at both ends, i.e. `lo ≤ (level cut-off) - |m|` and `up ≥ (mode cut-off) + |m|`.  Since
`ddfOp_apply` computes `A^ε_n` on *any* sufficiently large window this costs nothing, and
the enlarged window serves both signs at once — so the telescoping below is run directly for
`m ≠ 0`, with `m ≤ -1` a corollary.

## What is still missing

`m = 0`.  The single-Fock identity `Fock.lie_Lop_vertexOsc_of_ne` genuinely excludes it (at
`m = 0` the `j = 0` and `j = m` terms of the Sugawara normal ordering collide), so
`⁅L_0, A^ε_n⁆ = 0` — equivalently the statement that `A^ε_n` shifts the `L_0` eigenvalue by
`-n` — is not available here.  This is the one remaining gap in
`worldsheet.ddf-commute-with-virasoro`.
-/

namespace StringFormal.NoGhost

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

/-! ### The conformal weight on the DDF momentum tower, for `m ≠ 0` -/

/-- **The conformal-weight identity on the DDF momentum tower, for every `m ≠ 0`.**

`⁅L_m, V^{(n)}_K⁆ = (K - m - n + n (k_0 · p)) V^{(n)}_{K-m}`.

Same statement and same proof as `lie_towerLop_towerVertex_of_pos`, with the single-Fock
input widened from `Fock.lie_Lop_vertexOsc_of_pos` to `Fock.lie_Lop_vertexOsc_of_ne`.  The
isotropy hypothesis `hbb : k_0² = 0` is still essential, and for the same reason: without it
the coefficient produced on rung `j` carries a `j n (b·b)` term, so the bracket is only
rung-wise proportional to `V^{(n)}_{K-m}` and not an operator identity. -/
theorem lie_towerLop_towerVertex_of_ne (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) {m : ℤ} (hm : m ≠ 0) (n K : ℤ) :
    ⁅towerLop η a b m, towerVertex η b n K⁆
      = ((K : R) - (m : R) - (n : R) + (n : R) * dotVec η b a)
        • towerVertex η b n (K - m) := by
  have hbb' : (∑ μ : Fin D, η μ * b μ * b μ) = 0 := hbb
  have h1 : ∀ j : ℤ, (∑ μ : Fin D,
      η μ * towerMomentum a b j μ * vertexMomentum b n μ) = (n : R) * dotVec η b a := by
    intro j
    have hsplit : (∑ μ : Fin D, η μ * towerMomentum a b j μ * vertexMomentum b n μ)
        = (n : R) * (∑ μ : Fin D, η μ * a μ * b μ)
          + ((j : R) * (n : R)) * (∑ μ : Fin D, η μ * b μ * b μ) := by
      rw [Finset.mul_sum, Finset.mul_sum, ← Finset.sum_add_distrib]
      refine Finset.sum_congr rfl fun μ _ => ?_
      simp only [towerMomentum_apply, vertexMomentum_apply]
      ring
    rw [hsplit, hbb', mul_zero, add_zero, dotVec_comm η b a]
    rfl
  have h2 : (∑ μ : Fin D, η μ * vertexMomentum b n μ * vertexMomentum b n μ) = 0 := by
    have hsq : (∑ μ : Fin D, η μ * vertexMomentum b n μ * vertexMomentum b n μ)
        = ((n : R) * (n : R)) * (∑ μ : Fin D, η μ * b μ * b μ) := by
      rw [Finset.mul_sum]
      refine Finset.sum_congr rfl fun μ _ => ?_
      simp only [vertexMomentum_apply]
      ring
    rw [hsq, hbb', mul_zero]
  have hidx : K - n - m = K - m - n := by ring
  refine Finsupp.lhom_ext fun j P => ?_
  rw [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
    Module.End.mul_apply, towerVertex_single, towerLop_single, towerLop_single,
    towerVertex_single, LinearMap.smul_apply, towerVertex_single, ← Finsupp.single_sub,
    Finsupp.smul_single]
  congr 1
  have hmom : towerMomentum a b j + vertexMomentum b n = towerMomentum a b (j + n) := by
    funext μ
    simp only [Pi.add_apply, towerMomentum_apply, vertexMomentum_apply]
    push_cast
    ring
  have hkey := congrArg (fun T : Module.End R (Fock D R) => T P)
    (Fock.lie_Lop_vertexOsc_of_ne η (towerMomentum a b j) (vertexMomentum b n) hη hm (K - n))
  simp only [LinearMap.sub_apply, LinearMap.comp_apply, LinearMap.smul_apply, hmom] at hkey
  rw [hkey, h1 j, h2, hidx]
  congr 1
  push_cast
  ring

/-- The `m ≤ -1` half of the tower conformal-weight identity, the mirror of
`lie_towerLop_towerVertex_of_pos`. -/
theorem lie_towerLop_towerVertex_of_neg (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) {m : ℤ} (hm : m < 0) (n K : ℤ) :
    ⁅towerLop η a b m, towerVertex η b n K⁆
      = ((K : R) - (m : R) - (n : R) + (n : R) * dotVec η b a)
        • towerVertex η b n (K - m) :=
  lie_towerLop_towerVertex_of_ne η a b hη hbb hm.ne n K

/-- **The DDF-normalised form for every `m ≠ 0`**: with `k_0² = 0` and `2α' k_0 · p = 1` the
tower vertex operator `:e^{i n k_0·X}:` is a weight-`0` primary,
`⁅L_m, V^{(n)}_K⁆ = (K - m) V^{(n)}_{K-m}`.

Weight `0` for the same reason as in `lie_towerLop_towerVertex_of_pos_normalized`: the
monodromy shift `z^{2α' n k_0·p} = z^n` built into `towerVertex` cancels the `n (k_0 · p)`
term of the single-Fock identity.  The cancellation is insensitive to the sign of `m`,
because neither of the two `n`-dependent contributions depends on `m`. -/
theorem lie_towerLop_towerVertex_of_ne_normalized (η a b : Fin D → R)
    (hη : ∀ μ, η μ * η μ = 1) (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1)
    {m : ℤ} (hm : m ≠ 0) (n K : ℤ) :
    ⁅towerLop η a b m, towerVertex η b n K⁆
      = ((K : R) - (m : R)) • towerVertex η b n (K - m) := by
  rw [lie_towerLop_towerVertex_of_ne η a b hη hbb hm n K, hba]
  congr 1
  ring

/-- The `m ≤ -1` half of the normalised weight-`0` transformation law. -/
theorem lie_towerLop_towerVertex_of_neg_normalized (η a b : Fin D → R)
    (hη : ∀ μ, η μ * η μ = 1) (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1)
    {m : ℤ} (hm : m < 0) (n K : ℤ) :
    ⁅towerLop η a b m, towerVertex η b n K⁆
      = ((K : R) - (m : R)) • towerVertex η b n (K - m) :=
  lie_towerLop_towerVertex_of_ne_normalized η a b hη hbb hba hm.ne n K

/-! ### `⁅L_m, A^ε_n⁆ = 0` for every `m ≠ 0` -/

/-- The bracket of `L_m` with a single DDF summand, in telescoping form
`⁅L_m, α^ε_j V^{(n)}_j⁆ = (j - m) · α^ε_j V^{(n)}_{j-m} - j · α^ε_{m+j} V^{(n)}_j`,
now for every `m ≠ 0`.  Identical to `lie_towerLop_ddfSummand` except that the weight-`0`
primary law is taken from `lie_towerLop_towerVertex_of_ne_normalized`; the Leibniz rule and
`⁅L_m, α^ε_j⁆ = -j α^ε_{m+j}` never cared about the sign of `m`. -/
theorem lie_towerLop_ddfSummand_of_ne (η a b ε : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1) {m : ℤ} (hm : m ≠ 0) (n j : ℤ) :
    ⁅towerLop η a b m, ddfSummand η a b ε n j⁆
      = ((j - m : ℤ) : R) • ddfShifted η a b ε n m (j - m)
        - ((j : ℤ) : R) • ddfShifted η a b ε n m j := by
  simp only [ddfSummand, ddfShifted, show m + (j - m) = j from by ring]
  rw [lie_mul_end, lie_towerLop_towerModeVec η a b ε hη m j,
    lie_towerLop_towerVertex_of_ne_normalized η a b hη hbb hba hm n j,
    smul_mul_assoc, mul_smul_comm]
  push_cast
  module

end StringFormal.NoGhost
