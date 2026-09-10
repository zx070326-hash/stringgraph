/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.DDFOperatorNeg
import StringFormal.NoGhost.VertexWeightZero
import StringFormal.NoGhost.TowerPhysical

/-!
# `⁅L_m, A^ε_n⁆ = 0` for **every** `m : ℤ`

Graph nodes: `worldsheet.ddf-commute-with-virasoro` (this file closes it: the formalised
range goes from `m ≠ 0` to all of `ℤ`), `worldsheet.ddf-operators-v5` (the definition of
`A^ε_n`).  `formal/TODO.md` item `ddf-operators`, sub-item (4).

## The last case

`StringFormal/NoGhost/DDFOperator.lean` had `m ≥ 1`, `StringFormal/NoGhost/DDFOperatorNeg.lean`
widened it to `m ≠ 0`, and both were blocked at `m = 0` only because the single-Fock
conformal-weight identity was.  `StringFormal/NoGhost/VertexWeightZero.lean` has since supplied
`Fock.lie_Lop_vertexOsc`, valid for every `m : ℤ` with the *same* polynomial coefficient
`J - m + a·b + ½ (m+1)(b·b)`.  Since `hm : m ≠ 0` entered `lie_towerLop_ddfOp_of_ne` at exactly
one place — the appeal to `lie_towerLop_ddfSummand_of_ne` — everything downstream goes through
verbatim once that one input is unconditional.

So this file is the `m ≠ 0` file with the hypothesis deleted:

* `lie_towerLop_towerVertex` — `⁅L_m, V^{(n)}_K⁆ = (K - m - n + n (k_0·p)) V^{(n)}_{K-m}` on the
  DDF momentum tower, for every `m`.  Isotropy `k_0² = 0` is still needed, and for the same
  reason as before (otherwise the coefficient depends on the rung `j`).
* `lie_towerLop_towerVertex_normalized` — with `2α' k_0 · p = 1` this is the weight-`0` primary
  law `⁅L_m, V^{(n)}_K⁆ = (K - m) V^{(n)}_{K-m}`, all `m`.
* `lie_towerLop_ddfSummand_all` — the telescoping form, all `m`.  (The unsuffixed name
  `lie_towerLop_ddfSummand` is already taken by the `m > 0` version in `DDFOperator.lean`.)
* **`lie_towerLop_ddfOp`** — `⁅L_m, A^ε_n⁆ = 0` for **every** `m : ℤ`.
* `ddfOp_mem_towerL0Submodule` / **`ddfOp_mem_towerPhysSubmodule`** — the corollary that
  `A^ε_n` maps the old covariant physical subspace of the tower into itself.  `TowerPhysical.lean`
  could only do the `m ≥ 1` half; the `L_0` half is exactly what `m = 0` buys.

## Why `m = 0` is `0` and not a multiple of `A^ε_n`

`A^ε_n` is the zero mode of a weight-`1` current, and for a weight-`h` current
`⁅L_m, j_r⁆ = ((h-1) m - r) j_{m+r}`; at `h = 1`, `r = 0` this vanishes identically in `m`.
Concretely, in the telescoping proof each summand's bracket is `g (j - m) - g j`, which at
`m = 0` is `0` term by term — the boundary strips are empty and the window analysis is
vacuous.  The proof below does not special-case this: the `m ≠ 0` window argument, run with
slack `|m| = 0`, degenerates to it correctly.

This is what makes DDF states automatically satisfy the `L_0` mass-shell condition, so
together with `m ≥ 1` it gives "`A^ε_n` preserves the physical subspace".
-/

namespace StringFormal.NoGhost

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]


/-! ### The conformal weight on the DDF momentum tower, for every `m` -/

/-- **The conformal-weight identity on the DDF momentum tower, for every `m : ℤ`.**

`⁅L_m, V^{(n)}_K⁆ = (K - m - n + n (k_0 · p)) V^{(n)}_{K-m}`.

Same statement and same proof as `lie_towerLop_towerVertex_of_ne`, with the single-Fock input
widened from `Fock.lie_Lop_vertexOsc_of_ne` to `Fock.lie_Lop_vertexOsc`.  Note that this is the
*only* place in the whole `m = 0` upgrade where anything has to be re-checked: the coefficient
polynomial `J - m + a·b + ½ (m+1)(b·b)` is literally the same function of `m` in both inputs,
so the rung-by-rung computation below is unchanged.

The isotropy hypothesis `hbb : k_0² = 0` is still essential, and for the same reason as for
`m ≠ 0`: without it the coefficient produced on rung `j` carries a `j n (b·b)` term, so the
bracket is only rung-wise proportional to `V^{(n)}_{K-m}` and not an operator identity. -/
theorem lie_towerLop_towerVertex (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (m n K : ℤ) :
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
    (Fock.lie_Lop_vertexOsc η (towerMomentum a b j) (vertexMomentum b n) hη m (K - n))
  simp only [LinearMap.sub_apply, LinearMap.comp_apply, LinearMap.smul_apply, hmom] at hkey
  rw [hkey, h1 j, h2, hidx]
  congr 1
  push_cast
  ring

/-- **The DDF-normalised form for every `m : ℤ`**: with `k_0² = 0` and `2α' k_0 · p = 1` the
tower vertex operator `:e^{i n k_0·X}:` is a weight-`0` primary,
`⁅L_m, V^{(n)}_K⁆ = (K - m) V^{(n)}_{K-m}`.

At `m = 0` this reads `⁅L_0, V^{(n)}_K⁆ = K V^{(n)}_K`, i.e. `V^{(n)}_K` lowers the `L_0`
eigenvalue by `K`; summing `α^ε_j V^{(n)}_j` over `j` is exactly what makes the two `L_0`
shifts cancel in `A^ε_n`. -/
theorem lie_towerLop_towerVertex_normalized (η a b : Fin D → R)
    (hη : ∀ μ, η μ * η μ = 1) (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1)
    (m n K : ℤ) :
    ⁅towerLop η a b m, towerVertex η b n K⁆
      = ((K : R) - (m : R)) • towerVertex η b n (K - m) := by
  rw [lie_towerLop_towerVertex η a b hη hbb m n K, hba]
  congr 1
  ring


/-! ### `⁅L_m, A^ε_n⁆ = 0` for every `m : ℤ` -/

/-- The bracket of `L_m` with a single DDF summand, in telescoping form
`⁅L_m, α^ε_j V^{(n)}_j⁆ = (j - m) · α^ε_j V^{(n)}_{j-m} - j · α^ε_{m+j} V^{(n)}_j`,
now for every `m : ℤ`.  Identical to `lie_towerLop_ddfSummand_of_ne` except that the
weight-`0` primary law is taken from `lie_towerLop_towerVertex_normalized`; the Leibniz rule
and `⁅L_m, α^ε_j⁆ = -j α^ε_{m+j}` never cared about the value of `m`.

At `m = 0` the two terms on the right are literally equal, so each summand's bracket vanishes
on its own — the telescoping below is then trivial rather than merely convergent. -/
theorem lie_towerLop_ddfSummand_all (η a b ε : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1) (m n j : ℤ) :
    ⁅towerLop η a b m, ddfSummand η a b ε n j⁆
      = ((j - m : ℤ) : R) • ddfShifted η a b ε n m (j - m)
        - ((j : ℤ) : R) • ddfShifted η a b ε n m j := by
  simp only [ddfSummand, ddfShifted, show m + (j - m) = j from by ring]
  rw [lie_mul_end, lie_towerLop_towerModeVec η a b ε hη m j,
    lie_towerLop_towerVertex_normalized η a b hη hbb hba m n j,
    smul_mul_assoc, mul_smul_comm]
  push_cast
  module

/-- **The DDF operators commute with the whole Virasoro algebra.**
`⁅L_m, A^ε_n⁆ = 0` for *every* `m : ℤ`, given `k_0² = 0`, `2α' k_0 · p = 1` and transversality
`ε · k_0 = 0`.  This is the graph node `worldsheet.ddf-commute-with-virasoro` in full.

The proof is the telescoping of `lie_towerLop_ddfOp_of_ne` with the hypothesis `m ≠ 0` simply
deleted; it was used there only to invoke `lie_towerLop_ddfSummand_of_ne`, which is now
unconditional.  Writing `G_i = α^ε_{m+i} V^{(n)}_i` and `g i = i • G_i x`, the Leibniz rule
gives `⁅L_m, α^ε_j V^{(n)}_j⁆ x = g (j - m) - g j`, so the sum over `[lo, up]` collapses to
`∑_{[lo-m, up-m]} g - ∑_{[lo,up]} g`, and both are compared to the common enlarged window
`[min lo (lo-m), max up (up-m)]`.  Strips below the window are killed by the vertex-operator
cut-off (the level cannot go below the vacuum), strips above by the transversality cut-off.

At `m = 0` the two windows coincide, the four boundary strips are empty and the argument
degenerates to `∑ (g j - g j) = 0`; nothing special has to be said.

Physically: `A^ε_n` is the zero mode of the weight-`1` current `ε·∂X e^{i n k_0·X}`, and the
zero mode of a weight-`1` current commutes with *all* of Virasoro, `m = 0` included.  It is
the `m = 0` case that makes DDF states satisfy the `L_0` mass-shell condition automatically. -/
theorem lie_towerLop_ddfOp (η a b ε : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1) (hεb : dotVec η ε b = 0)
    (m n : ℤ) :
    ⁅towerLop η a b m, ddfOp η a b ε hη hεb n⁆ = 0 := by
  classical
  refine LinearMap.ext fun x => ?_
  obtain ⟨lo, hlox, hloy⟩ : ∃ lo : ℤ,
      lo + (m.natAbs : ℤ) ≤ n - (towerLevelBound x : ℤ) ∧
      lo + (m.natAbs : ℤ) ≤ n - (towerLevelBound (towerLop η a b m x) : ℤ) :=
    ⟨min (n - (towerLevelBound x : ℤ)) (n - (towerLevelBound (towerLop η a b m x) : ℤ))
        - (m.natAbs : ℤ), by omega, by omega⟩
  obtain ⟨up, hupx, hupy⟩ : ∃ up : ℤ,
      (towerModeBound x : ℤ) + (m.natAbs : ℤ) ≤ up ∧
      (towerModeBound (towerLop η a b m x) : ℤ) + (m.natAbs : ℤ) ≤ up :=
    ⟨max (towerModeBound x : ℤ) (towerModeBound (towerLop η a b m x) : ℤ) + (m.natAbs : ℤ),
      by omega, by omega⟩
  have hwin : ∀ z : TowerFock D R, lo ≤ n - (towerLevelBound z : ℤ) →
      (towerModeBound z : ℤ) ≤ up → ∀ j ∉ Finset.Icc lo up,
      ddfSummand η a b ε n j z = 0 := by
    intro z hz1 hz2 j hj
    rw [Finset.mem_Icc, not_and, not_le] at hj
    rw [ddfSummand_eq_ddfShifted]
    rcases lt_or_ge j lo with h | h
    · exact ddfShifted_apply_eq_zero_of_lt η a b ε n 0 j z (by omega)
    · exact ddfShifted_apply_eq_zero_of_gt η a b ε hη hεb n 0 j z (by have := hj h; omega)
  have hAx := ddfOp_apply η a b ε hη hεb n x (hwin x (by omega) (by omega))
  have hAy := ddfOp_apply η a b ε hη hεb n (towerLop η a b m x)
    (hwin _ (by omega) (by omega))
  set g : ℤ → TowerFock D R := fun i => ((i : ℤ) : R) • ddfShifted η a b ε n m i x with hgdef
  have hglo : ∀ i : ℤ, i < n - (towerLevelBound x : ℤ) → g i = 0 := by
    intro i hi
    simp only [hgdef]
    rw [ddfShifted_apply_eq_zero_of_lt η a b ε n m i x hi, smul_zero]
  have hgup : ∀ i : ℤ, (towerModeBound x : ℤ) < m + i → g i = 0 := by
    intro i hi
    simp only [hgdef]
    rw [ddfShifted_apply_eq_zero_of_gt η a b ε hη hεb n m i x hi, smul_zero]
  have hterm : ∀ j : ℤ, towerLop η a b m (ddfSummand η a b ε n j x)
      - ddfSummand η a b ε n j (towerLop η a b m x) = g (j - m) - g j := by
    intro j
    have h := congrArg (fun T : Module.End R (TowerFock D R) => T x)
      (lie_towerLop_ddfSummand_all η a b ε hη hbb hba m n j)
    simp only [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
      LinearMap.smul_apply] at h
    simp only [hgdef]
    exact h
  rw [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
    Module.End.mul_apply, LinearMap.zero_apply, hAx, hAy, map_sum, ← Finset.sum_sub_distrib]
  refine Eq.trans (Finset.sum_congr rfl fun j _ => hterm j) ?_
  rw [Finset.sum_sub_distrib]
  have e1 : ∑ j ∈ Finset.Icc lo up, g (j - m) = ∑ j ∈ Finset.Icc (lo - m) (up - m), g j := by
    refine Finset.sum_nbij' (fun j => j - m) (fun j => j + m) ?_ ?_ ?_ ?_ ?_
    · intro j hj
      simp only [Finset.mem_Icc] at hj ⊢
      omega
    · intro j hj
      simp only [Finset.mem_Icc] at hj ⊢
      omega
    · intro j _
      omega
    · intro j _
      omega
    · intro j _
      rfl
  have eA : ∑ j ∈ Finset.Icc (lo - m) (up - m), g j
      = ∑ j ∈ Finset.Icc (min lo (lo - m)) (max up (up - m)), g j := by
    refine Finset.sum_subset (fun i hi => ?_) (fun i _ hni => ?_)
    · simp only [Finset.mem_Icc] at hi ⊢
      omega
    · simp only [Finset.mem_Icc, not_and, not_le] at hni
      rcases lt_or_ge i (lo - m) with h | h
      · exact hglo i (by omega)
      · exact hgup i (by have := hni h; omega)
  have eB : ∑ j ∈ Finset.Icc lo up, g j
      = ∑ j ∈ Finset.Icc (min lo (lo - m)) (max up (up - m)), g j := by
    refine Finset.sum_subset (fun i hi => ?_) (fun i _ hni => ?_)
    · simp only [Finset.mem_Icc] at hi ⊢
      omega
    · simp only [Finset.mem_Icc, not_and, not_le] at hni
      rcases lt_or_ge i lo with h | h
      · exact hglo i (by omega)
      · exact hgup i (by have := hni h; omega)
  rw [e1, eA, eB, sub_self]

/-- The remaining case, stated on its own: `⁅L_0, A^ε_n⁆ = 0`.  Together with
`lie_towerLop_ddfOp_of_pos` and `lie_towerLop_ddfOp_of_neg` this is what
`lie_towerLop_ddfOp` merges. -/
theorem lie_towerLop_ddfOp_zero (η a b ε : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1) (hεb : dotVec η ε b = 0) (n : ℤ) :
    ⁅towerLop η a b 0, ddfOp η a b ε hη hεb n⁆ = 0 :=
  lie_towerLop_ddfOp η a b ε hη hbb hba hεb 0 n



/-! ### The DDF operators preserve the physical subspace of the tower -/

/-- **The DDF operators preserve the mass-shell condition.**

If `(L_0 - a₀) Ψ = 0` then `(L_0 - a₀) (A^ε_n Ψ) = 0`.  This is the half of "`A^ε_n` maps
physical states to physical states" that `TowerPhysical.lean` had to leave open, and it is
exactly the payload of the `m = 0` bracket: `L_0 A^ε_n Ψ = A^ε_n L_0 Ψ = a₀ • A^ε_n Ψ`.

Note the intercept `a₀` is *unchanged*: `A^ε_n` moves a state `n` rungs up the momentum tower
and `n` oscillator levels down, and `invTwo_zeroModeSq_towerMomentum_add_shift_cancel` is the
arithmetic identity saying those two shifts cancel in `α' p² + N`. -/
theorem ddfOp_mem_towerL0Submodule (η a b ε : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1) (hεb : dotVec η ε b = 0) {a₀ : R} (n : ℤ)
    {Ψ : TowerFock D R} (hΨ : Ψ ∈ towerL0Submodule η a b a₀) :
    ddfOp η a b ε hη hεb n Ψ ∈ towerL0Submodule η a b a₀ := by
  rw [mem_towerL0Submodule] at hΨ ⊢
  have h' := congrArg (fun T : Module.End R (TowerFock D R) => T Ψ)
    (lie_towerLop_ddfOp η a b ε hη hbb hba hεb 0 n)
  simp only [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
    LinearMap.zero_apply, sub_eq_zero] at h'
  rw [h', hΨ, map_smul]

/-- **The DDF operators preserve the old covariant physical subspace of the momentum tower.**

`Ψ ∈ towerPhysSubmodule η a b a₀ → A^ε_n Ψ ∈ towerPhysSubmodule η a b a₀`, under the DDF
normalisations `k_0² = 0`, `2α' k_0 · p = 1` and transversality `ε · k_0 = 0`.

This is the operator-theoretic content of `worldsheet.ddf-operators-v5`: starting from a
physical state of the tower one may apply `A^ε_n` freely and stay physical, which is what
produces the transverse DDF spectrum used in Goddard-Thorn.  Both halves are corollaries of
`⁅L_m, A^ε_n⁆ = 0`: the `m ≥ 1` half was already available
(`ddfOp_mem_towerPositiveModeSubmodule`), the `m = 0` half is `ddfOp_mem_towerL0Submodule`.

What is *not* claimed here: that the DDF states span the physical subspace (that is the hard
half of no-ghost), nor the `⁅A^ε_m, A^ε'_n⁆` oscillator algebra. -/
theorem ddfOp_mem_towerPhysSubmodule (η a b ε : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1) (hεb : dotVec η ε b = 0) {a₀ : R} (n : ℤ)
    {Ψ : TowerFock D R} (hΨ : Ψ ∈ towerPhysSubmodule η a b a₀) :
    ddfOp η a b ε hη hεb n Ψ ∈ towerPhysSubmodule η a b a₀ :=
  Submodule.mem_inf.2
    ⟨ddfOp_mem_towerL0Submodule η a b ε hη hbb hba hεb n (Submodule.mem_inf.1 hΨ).1,
      ddfOp_mem_towerPositiveModeSubmodule η a b ε hη hbb hba hεb n (Submodule.mem_inf.1 hΨ).2⟩

end StringFormal.NoGhost
