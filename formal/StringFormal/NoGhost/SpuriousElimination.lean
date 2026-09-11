/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.LightConeResolutionGen
import StringFormal.NoGhost.SliceDim

/-!
# The `b̃`-degree elimination (blueprint §B′ PR4)

Work in progress; see the file docstring at the end of the branch for the final scope.
-/

namespace StringFormal.NoGhost

open MvPolynomial

/-! ### The `b̃`-row index and the two degrees `(β, ω)` -/

section Degrees

variable {D : ℕ}

/-- The index of the `b` row in the light-cone direction table `frameVec`. -/
def lightIdx (D : ℕ) (hD : 2 ≤ D) : Fin D := ⟨0, by omega⟩

/-- The index of the `b̃` row in the light-cone direction table `frameVec`. -/
def conjIdx (D : ℕ) (hD : 2 ≤ D) : Fin D := ⟨1, by omega⟩

lemma lightIdx_ne_conjIdx (hD : 2 ≤ D) : lightIdx D hD ≠ conjIdx D hD := by
  simp [lightIdx, conjIdx, Fin.ext_iff]

/-- **`β`, the `b̃`-degree** of a light-cone occupation function: the total number of `α^{b̃}`
factors (blueprint §B′.5). -/
noncomputable def conjDeg (hD : 2 ≤ D) (d : Osc D →₀ ℕ) : ℕ :=
  Finsupp.weight (fun v : Osc D => if v.1 = conjIdx D hD then 1 else 0) d

/-- **`ω`, the weighted `b̃`-degree**: `∑_n n · d(b̃, n)` (blueprint §B′.5). -/
noncomputable def conjWt (hD : 2 ≤ D) (d : Osc D →₀ ℕ) : ℕ :=
  Finsupp.weight (fun v : Osc D => if v.1 = conjIdx D hD then (v.2 : ℕ) else 0) d

@[simp]
lemma conjDeg_zero (hD : 2 ≤ D) : conjDeg hD (0 : Osc D →₀ ℕ) = 0 := map_zero _

@[simp]
lemma conjWt_zero (hD : 2 ≤ D) : conjWt hD (0 : Osc D →₀ ℕ) = 0 := map_zero _

@[simp]
lemma conjDeg_add (hD : 2 ≤ D) (d e : Osc D →₀ ℕ) :
    conjDeg hD (d + e) = conjDeg hD d + conjDeg hD e := map_add _ _ _

@[simp]
lemma conjWt_add (hD : 2 ≤ D) (d e : Osc D →₀ ℕ) :
    conjWt hD (d + e) = conjWt hD d + conjWt hD e := map_add _ _ _

lemma conjDeg_single (hD : 2 ≤ D) (v : Osc D) (k : ℕ) :
    conjDeg hD (Finsupp.single v k) = k * (if v.1 = conjIdx D hD then 1 else 0) :=
  Finsupp.weight_single _ _ _

lemma conjWt_single (hD : 2 ≤ D) (v : Osc D) (k : ℕ) :
    conjWt hD (Finsupp.single v k) = k * (if v.1 = conjIdx D hD then (v.2 : ℕ) else 0) :=
  Finsupp.weight_single _ _ _

@[simp]
lemma conjDeg_single_conj (hD : 2 ≤ D) (n : ℕ+) :
    conjDeg hD (Finsupp.single ((conjIdx D hD, n) : Osc D) 1) = 1 := by
  rw [conjDeg_single]; simp

@[simp]
lemma conjWt_single_conj (hD : 2 ≤ D) (n : ℕ+) :
    conjWt hD (Finsupp.single ((conjIdx D hD, n) : Osc D) 1) = (n : ℕ) := by
  rw [conjWt_single]; simp

lemma conjDeg_single_of_ne (hD : 2 ≤ D) {v : Osc D} (hv : v.1 ≠ conjIdx D hD) (k : ℕ) :
    conjDeg hD (Finsupp.single v k) = 0 := by
  rw [conjDeg_single, if_neg hv, mul_zero]

lemma conjWt_single_of_ne (hD : 2 ≤ D) {v : Osc D} (hv : v.1 ≠ conjIdx D hD) (k : ℕ) :
    conjWt hD (Finsupp.single v k) = 0 := by
  rw [conjWt_single, if_neg hv, mul_zero]

/-- The `b̃`-weight is bounded by the oscillator level: each `α^{b̃}_{-n}` factor contributes
`n` to both. -/
lemma conjWt_le_level (hD : 2 ≤ D) (d : Osc D →₀ ℕ) : conjWt hD d ≤ Fock.level D d := by
  rw [Fock.level_apply, conjWt, Finsupp.weight_apply]
  refine Finset.sum_le_sum fun v _ => ?_
  by_cases hv : v.1 = conjIdx D hD <;> simp [hv, Fock.oscLevel, mul_comm]

/-- **The induction variable of blueprint §B′.5**: `μ(d) = β(d)·(N+1) + ω(d)`.  For a fixed
target level `N` it is additive in `d`, and a single `α^{b̃}_{-n}` factor costs `N + 1 + n`,
strictly more than any number of `α^b` or `α^{ε_i}` factors at that level can. -/
noncomputable def lcMeasure (hD : 2 ≤ D) (N : ℕ) (d : Osc D →₀ ℕ) : ℕ :=
  conjDeg hD d * (N + 1) + conjWt hD d

lemma lcMeasure_add (hD : 2 ≤ D) (N : ℕ) (d e : Osc D →₀ ℕ) :
    lcMeasure hD N (d + e) = lcMeasure hD N d + lcMeasure hD N e := by
  simp only [lcMeasure, conjDeg_add, conjWt_add, add_mul]
  ring

@[simp]
lemma lcMeasure_zero (hD : 2 ≤ D) (N : ℕ) : lcMeasure hD N (0 : Osc D →₀ ℕ) = 0 := by
  simp [lcMeasure]

lemma lcMeasure_single_conj (hD : 2 ≤ D) (N : ℕ) (n : ℕ+) :
    lcMeasure hD N (Finsupp.single ((conjIdx D hD, n) : Osc D) 1) = N + 1 + (n : ℕ) := by
  simp [lcMeasure]

lemma lcMeasure_le_level_of_conjDeg_eq_zero (hD : 2 ≤ D) {N : ℕ} {d : Osc D →₀ ℕ}
    (h : conjDeg hD d = 0) : lcMeasure hD N d ≤ Fock.level D d := by
  simp only [lcMeasure, h, zero_mul, zero_add]
  exact conjWt_le_level hD d

end Degrees

/-! ### The three spans cut out by the degrees -/

section Spans

variable {D : ℕ} {R : Type*} [CommRing R] {η a b : Fin D → R}

/-- **Light-cone monomials of level `N` with `β ≤ β₀` and `ω ≤ ω₀`.**  The bookkeeping device
of the elimination: every remainder produced by moving `L_{-n}` past a monomial lands in one
of these, with `β₀` strictly below the `β` of the target. -/
noncomputable def lcBound (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (N β₀ ω₀ : ℕ) :
    Submodule R (Fock D R) :=
  Submodule.span R
    (lcMonomial F '' {d : Osc D →₀ ℕ |
      Fock.level D d = N ∧ conjDeg hD d ≤ β₀ ∧ conjWt hD d ≤ ω₀})

/-- **Light-cone monomials of level `N` strictly below the measure `M`** (blueprint §B′.5's
`μ`).  This is the right-hand side of the leading-term lemma. -/
noncomputable def lcLow (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (N M : ℕ) :
    Submodule R (Fock D R) :=
  Submodule.span R
    (lcMonomial F '' {d : Osc D →₀ ℕ | Fock.level D d = N ∧ lcMeasure hD N d < M})

/-- **The `b̃`-free light-cone monomials of level `N`**, in a single Fock fiber. -/
noncomputable def conjFree (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (N : ℕ) :
    Submodule R (Fock D R) :=
  Submodule.span R (lcMonomial F '' {d : Osc D →₀ ℕ | Fock.level D d = N ∧ conjDeg hD d = 0})

/-- **`conjFreeSlice`** (blueprint §B′.4, PR4): the `b̃`-free light-cone monomials of level `N`
placed on rung `-N`, i.e. inside the antidiagonal bigraded piece `towerBigrade (-N) N`. -/
noncomputable def conjFreeSlice (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (N : ℕ) :
    Submodule R (TowerFock D R) :=
  Submodule.map (Finsupp.lsingle (M := Fock D R) (R := R) (-(N : ℤ))) (conjFree hD F N)

lemma lcMonomial_mem_lcBound (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) {N β₀ ω₀ : ℕ}
    {d : Osc D →₀ ℕ} (h1 : Fock.level D d = N) (h2 : conjDeg hD d ≤ β₀)
    (h3 : conjWt hD d ≤ ω₀) : lcMonomial F d ∈ lcBound (R := R) hD F N β₀ ω₀ :=
  Submodule.subset_span ⟨d, ⟨h1, h2, h3⟩, rfl⟩

lemma lcMonomial_mem_lcLow (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) {N M : ℕ}
    {d : Osc D →₀ ℕ} (h1 : Fock.level D d = N) (h2 : lcMeasure hD N d < M) :
    lcMonomial F d ∈ lcLow (R := R) hD F N M :=
  Submodule.subset_span ⟨d, ⟨h1, h2⟩, rfl⟩

lemma lcMonomial_mem_conjFree (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) {N : ℕ}
    {d : Osc D →₀ ℕ} (h1 : Fock.level D d = N) (h2 : conjDeg hD d = 0) :
    lcMonomial F d ∈ conjFree (R := R) hD F N :=
  Submodule.subset_span ⟨d, ⟨h1, h2⟩, rfl⟩

lemma lcBound_mono (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) {N β₀ ω₀ β₁ ω₁ : ℕ}
    (hβ : β₀ ≤ β₁) (hω : ω₀ ≤ ω₁) :
    lcBound (R := R) hD F N β₀ ω₀ ≤ lcBound (R := R) hD F N β₁ ω₁ := by
  refine Submodule.span_mono ?_
  rintro _ ⟨d, ⟨h1, h2, h3⟩, rfl⟩
  exact ⟨d, ⟨h1, h2.trans hβ, h3.trans hω⟩, rfl⟩

lemma lcLow_mono (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) {N M M' : ℕ} (hM : M ≤ M') :
    lcLow (R := R) hD F N M ≤ lcLow (R := R) hD F N M' := by
  refine Submodule.span_mono ?_
  rintro _ ⟨d, ⟨h1, h2⟩, rfl⟩
  exact ⟨d, ⟨h1, h2.trans_le hM⟩, rfl⟩

/-- The `(β, ω)`-box sits inside the measure filtration as soon as the box's own measure is
below the cut. -/
lemma lcBound_le_lcLow (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) {N β₀ ω₀ M : ℕ}
    (h : β₀ * (N + 1) + ω₀ < M) :
    lcBound (R := R) hD F N β₀ ω₀ ≤ lcLow (R := R) hD F N M := by
  refine Submodule.span_mono ?_
  rintro _ ⟨d, ⟨h1, h2, h3⟩, rfl⟩
  refine ⟨d, ⟨h1, ?_⟩, rfl⟩
  calc lcMeasure hD N d ≤ β₀ * (N + 1) + ω₀ := by
        exact Nat.add_le_add (Nat.mul_le_mul_right _ h2) h3
    _ < M := h

lemma conjFree_le_lcBound (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (N : ℕ) :
    conjFree (R := R) hD F N ≤ lcBound (R := R) hD F N 0 N := by
  refine Submodule.span_mono ?_
  rintro _ ⟨d, ⟨h1, h2⟩, rfl⟩
  exact ⟨d, ⟨h1, h2.le, h1 ▸ conjWt_le_level hD d⟩, rfl⟩

end Spans

/-! ### The completeness relation on contracted pairs of creation operators -/

section Completeness

variable {D : ℕ} {R : Type*} [CommRing R] {η a b : Fin D → R}

/-- `α^{(1 at μ)}_{-n} = η_μ α^μ_{-n}`; the companion of `X_eq_lcCrea_single`, with the
polarisation normalised to `1` instead of `η_μ` so that the two slots of a contracted pair
can be resolved independently. -/
lemma lcCrea_single_one (η : Fin D → R) (μ : Fin D) (n : ℕ+) :
    lcCrea η (Pi.single μ (1 : R)) n = η μ • (X ((μ, n) : Osc D) : Fock D R) := by
  classical
  rw [lcCrea_def, Finset.sum_eq_single μ]
  · rw [Pi.single_eq_same, mul_one]
  · intro ν _ hν
    rw [Pi.single_eq_of_ne hν, mul_zero, zero_smul]
  · intro h
    exact absurd (Finset.mem_univ μ) h

/-- **The completeness relation in the form used below**: `∑_μ (η_μ w^μ) e_μ^{(η)} = w`, where
`e_μ^{(η)} = Pi.single μ η_μ` is the polarisation for which `α^{e}_{-n} = α^μ_{-n}`.  Uses only
`η_μ² = 1`. -/
lemma sum_smul_single_eta (η : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (w : Fin D → R) :
    ∑ μ : Fin D, (η μ * w μ) • (Pi.single μ (η μ) : Fin D → R) = w := by
  classical
  funext ν
  rw [Finset.sum_apply, Finset.sum_eq_single ν]
  · simp only [Pi.smul_apply, Pi.single_eq_same, smul_eq_mul]
    rw [mul_comm (η ν) (w ν), mul_assoc, hη ν, mul_one]
  · intro μ _ hμ
    simp [Pi.single_eq_of_ne (Ne.symm hμ)]
  · intro h
    exact absurd (Finset.mem_univ ν) h

/-- Pulling a scalar family through the (linear) polarisation slot of `lcCrea`. -/
lemma sum_smul_lcCrea_single (η : Fin D → R) (n : ℕ+) (f : Fin D → R) :
    ∑ μ : Fin D, f μ • lcCrea η (Pi.single μ (η μ)) n
      = lcCrea η (∑ μ : Fin D, f μ • (Pi.single μ (η μ) : Fin D → R)) n := by
  rw [lcCrea_sum]
  exact Finset.sum_congr rfl fun μ _ => (lcCrea_smul η (f μ) _ n).symm

/-- **The resolution of identity on a coordinate direction.**  `Pi.single μ 1` decomposed
along `{b, b̃, ε_i}`; the coefficients come from `DDFLightConeFrame.frame_decomp_coeff`, so
this needs no field and no dimension hypothesis. -/
theorem DDFLightConeFrame.single_resolution (F : DDFLightConeFrame η a b) (μ : Fin D) :
    (Pi.single μ (1 : R) : Fin D → R)
      = (-(η μ * F.frame.conj μ)) • b + (-(η μ * b μ)) • F.frame.conj
        + ∑ i, (η μ * F.trans.vec i μ) • F.trans.vec i := by
  obtain ⟨lam, mu, c, hdec⟩ := F.exists_frame_decomp (Pi.single μ (1 : R))
  obtain ⟨h1, h2, h3⟩ := F.frame_decomp_coeff hdec
  have e1 : lam = -(η μ * F.frame.conj μ) := by
    rw [h1, dotVec_comm, dotVec_single_left, mul_one, mul_comm (η μ)]
  have e2 : mu = -(η μ * b μ) := by
    rw [h2, dotVec_comm, dotVec_single_left, mul_one, mul_comm (η μ)]
  have e3 : ∀ j, c j = η μ * F.trans.vec j μ := by
    intro j
    rw [h3 j, dotVec_comm, dotVec_single_left, mul_one]
  rw [← e1, ← e2]
  rw [hdec]
  congr 1
  exact Finset.sum_congr rfl fun j _ => by rw [e3 j]

/-- **The light-cone form of a contracted pair of creation operators**
`∑_μ η_μ α^μ_{-r} α^μ_{-s} = -α^b_{-r}α^{b̃}_{-s} - α^{b̃}_{-r}α^b_{-s} + ∑_i α^{ε_i}_{-r}α^{ε_i}_{-s}`
(blueprint §B′.4's "bilinearisation of `resolution`", at the level of creation operators).

This is the only place where the metric contraction is traded for the frame; everything
downstream is bookkeeping on the resulting monomials.  No field, no `2 ≤ D`, no `D = 26`. -/
theorem oscPair_eq_lightCone (F : DDFLightConeFrame η a b) (hη : ∀ μ, η μ * η μ = 1)
    (r s : ℕ+) :
    (∑ μ : Fin D, η μ • ((X ((μ, r) : Osc D) : Fock D R) * X ((μ, s) : Osc D)))
      = -(lcCrea η b r * lcCrea η F.frame.conj s)
        - (lcCrea η F.frame.conj r * lcCrea η b s)
        + ∑ i, lcCrea η (F.trans.vec i) r * lcCrea η (F.trans.vec i) s := by
  classical
  have hterm : ∀ μ : Fin D, η μ • ((X ((μ, r) : Osc D) : Fock D R) * X ((μ, s) : Osc D))
      = lcCrea η (Pi.single μ (1 : R)) r * lcCrea η (Pi.single μ (η μ)) s := by
    intro μ
    rw [lcCrea_single_one, ← X_eq_lcCrea_single η hη μ s, smul_mul_assoc]
  rw [Finset.sum_congr rfl fun μ _ => hterm μ]
  have hres : ∀ μ : Fin D, lcCrea η (Pi.single μ (1 : R)) r
      = (-(η μ * F.frame.conj μ)) • lcCrea η b r + (-(η μ * b μ)) • lcCrea η F.frame.conj r
        + ∑ i, (η μ * F.trans.vec i μ) • lcCrea η (F.trans.vec i) r := by
    intro μ
    conv_lhs => rw [F.single_resolution μ]
    rw [lcCrea_add, lcCrea_add, lcCrea_smul, lcCrea_smul, lcCrea_sum]
    congr 1
    exact Finset.sum_congr rfl fun i _ => lcCrea_smul η _ _ r
  rw [Finset.sum_congr rfl fun μ _ => by rw [hres μ]]
  have key : ∀ w : Fin D → R,
      ∑ μ : Fin D, (η μ * w μ) • lcCrea η (Pi.single μ (η μ)) s = lcCrea η w s := by
    intro w
    rw [sum_smul_lcCrea_single, sum_smul_single_eta η hη w]
  have pull : ∀ (A : Fock D R) (c : Fin D → R) (Y : Fin D → Fock D R),
      (∑ μ : Fin D, c μ • (A * Y μ)) = A * ∑ μ : Fin D, c μ • Y μ := by
    intro A c Y
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun μ _ => (mul_smul_comm _ _ _).symm
  have hneg : ∀ w : Fin D → R,
      ∑ μ : Fin D, (-(η μ * w μ)) • lcCrea η (Pi.single μ (η μ)) s = -lcCrea η w s := by
    intro w
    rw [← key w, ← Finset.sum_neg_distrib]
    exact Finset.sum_congr rfl fun μ _ => by rw [neg_smul]
  simp only [add_mul, Finset.sum_add_distrib, smul_mul_assoc, Finset.sum_mul]
  rw [pull, pull, hneg, hneg, Finset.sum_comm,
    Finset.sum_congr rfl fun i (_ : i ∈ Finset.univ) => by rw [pull, key (F.trans.vec i)]]
  ring

end Completeness

/-! ### `L_{-n}` on a rung vacuum, for every `n` -/

section LopVacuum

variable {D : ℕ} {R : Type*} [CommRing R]

/-- `|i|` as a positive natural, for `i < 0`; definitionally the index produced by
`Fock.mode_of_neg`. -/
def negPNat (i : ℤ) : ℕ+ := (-i).toNat.toPNat'

@[simp]
lemma negPNat_neg_coe (n : ℕ+) : negPNat (-((n : ℕ) : ℤ)) = n := by
  refine PNat.coe_injective ?_
  rw [negPNat, Nat.toPNat'_coe, if_pos (by simp)]
  simp

/-- A normal-ordered pair of two strictly negative modes on the vacuum is just the product of
the two variables; normal ordering is invisible because both factors are creation
operators. -/
lemma nordPair_apply_one_of_neg (η p : Fin D → R) {i j : ℤ} (hi : i < 0) (hj : j < 0) :
    Fock.nordPair η p i j (1 : Fock D R)
      = ∑ μ : Fin D, η μ •
          ((X ((μ, negPNat i) : Osc D) : Fock D R) * X ((μ, negPNat j) : Osc D)) := by
  rcases le_total i j with h | h
  · rw [Fock.nordPair_apply_of_le η p h]
    refine Finset.sum_congr rfl fun μ _ => ?_
    rw [Fock.mode_of_neg η p hj, Fock.mode_of_neg η p hi]
    simp [negPNat]
  · rw [Fock.nordPair_comm, Fock.nordPair_apply_of_le η p h]
    refine Finset.sum_congr rfl fun μ _ => ?_
    rw [Fock.mode_of_neg η p hi, Fock.mode_of_neg η p hj]
    simp only [Fock.creation_apply, mul_one, negPNat]
    rw [mul_comm]

/-- The zero-mode end of the Sugawara sum: `:α_{-n}·α_0:|0;p⟩ = α^p_{-n}|0;p⟩`. -/
lemma nordPair_neg_zero_apply_one (η p : Fin D → R) (n : ℕ+) :
    Fock.nordPair η p (-((n : ℕ) : ℤ)) 0 (1 : Fock D R) = lcCrea η p n := by
  rw [Fock.nordPair_apply_of_le η p (by simp : (-((n : ℕ) : ℤ)) ≤ 0), lcCrea_def]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [Fock.mode_zero_apply, Fock.mode_neg_pnat, map_smul, Fock.creation_apply, mul_one,
    smul_smul]

variable [Algebra ℚ R]

/-- **`L_{-n}` on the vacuum, for every `n ≥ 1`** (blueprint §B′.4; the repository previously
had only `Fock.Lop_neg_one_apply_one` and `Fock.Lop_neg_two_apply_one`):

`L_{-n}|0;p⟩ = α^p_{-n}|0;p⟩ + ½ ∑_{l=1}^{n-1} ∑_μ η_μ α^μ_{-(n-l)} α^μ_{-l}|0;p⟩`.

Only the terms with both mode indices `≤ 0` survive on the vacuum, and the two endpoints of
that range (`m = 0` and `m = -n`) are equal by symmetry of normal ordering, which is where the
`½` is spent. -/
theorem Lop_neg_apply_one (η p : Fin D → R) (n : ℕ+) :
    Fock.Lop η p (-((n : ℕ) : ℤ)) (1 : Fock D R)
      = lcCrea η p n
        + invTwo R • ∑ m ∈ Finset.Ioo (-((n : ℕ) : ℤ)) 0,
            ∑ μ : Fin D, η μ •
              ((X ((μ, negPNat (-((n : ℕ) : ℤ) - m)) : Osc D) : Fock D R)
                * X ((μ, negPNat m) : Osc D)) := by
  classical
  have hn : (0 : ℤ) < ((n : ℕ) : ℤ) := by exact_mod_cast n.2
  have hs : ∀ j ∉ Finset.Icc (-((n : ℕ) : ℤ)) 0,
      Fock.nordPair η p (-((n : ℕ) : ℤ) - j) j (1 : Fock D R) = 0 := by
    intro j hj
    rw [Finset.mem_Icc, not_and_or] at hj
    refine Fock.nordPair_apply_eq_zero_of_modeBound_lt η p _ _ ?_
    rw [Fock.modeBound_one, Nat.cast_zero]
    rcases hj with h | h
    · exact lt_of_lt_of_le (by omega) (le_max_left _ _)
    · exact lt_of_lt_of_le (by omega) (le_max_right _ _)
  rw [Fock.Lop_apply η p (-((n : ℕ) : ℤ)) 1 hs]
  rw [← Finset.Ioc_insert_left (by omega : (-((n : ℕ) : ℤ)) ≤ 0),
    ← Finset.Ioo_insert_right (by omega : (-((n : ℕ) : ℤ)) < 0),
    Finset.sum_insert (by simp), Finset.sum_insert (by simp)]
  have h0 : Fock.nordPair η p (-((n : ℕ) : ℤ) - 0) 0 (1 : Fock D R) = lcCrea η p n := by
    rw [sub_zero]
    exact nordPair_neg_zero_apply_one η p n
  have hend : Fock.nordPair η p (-((n : ℕ) : ℤ) - (-((n : ℕ) : ℤ))) (-((n : ℕ) : ℤ))
      (1 : Fock D R) = lcCrea η p n := by
    rw [sub_self, Fock.nordPair_comm]
    exact nordPair_neg_zero_apply_one η p n
  have hmid : ∀ m ∈ Finset.Ioo (-((n : ℕ) : ℤ)) 0,
      Fock.nordPair η p (-((n : ℕ) : ℤ) - m) m (1 : Fock D R)
        = ∑ μ : Fin D, η μ •
            ((X ((μ, negPNat (-((n : ℕ) : ℤ) - m)) : Osc D) : Fock D R)
              * X ((μ, negPNat m) : Osc D)) := by
    intro m hm
    rw [Finset.mem_Ioo] at hm
    exact nordPair_apply_one_of_neg η p (by omega) hm.2
  rw [h0, hend, Finset.sum_congr rfl hmid]
  rw [show lcCrea η p n + (lcCrea η p n + ∑ m ∈ Finset.Ioo (-((n : ℕ) : ℤ)) 0,
        ∑ μ : Fin D, η μ • ((X ((μ, negPNat (-((n : ℕ) : ℤ) - m)) : Osc D) : Fock D R)
          * X ((μ, negPNat m) : Osc D)))
      = (2 : R) • lcCrea η p n + ∑ m ∈ Finset.Ioo (-((n : ℕ) : ℤ)) 0,
        ∑ μ : Fin D, η μ • ((X ((μ, negPNat (-((n : ℕ) : ℤ) - m)) : Osc D) : Fock D R)
          * X ((μ, negPNat m) : Osc D)) from by rw [two_smul]; abel]
  rw [smul_add, smul_smul, invTwo_mul_two, one_smul]

end LopVacuum

/-! ### The light-cone form of `L_{-n}` on a rung vacuum -/

section Seed

variable {D : ℕ} {R : Type*} [CommRing R] {η a b : Fin D → R}

/-- The index of the `i`-th transverse row in the light-cone direction table. -/
def transIdxLc (D : ℕ) (hD : 2 ≤ D) (i : Fin (D - 2)) : Fin D :=
  ⟨(i : ℕ) + 2, by have := i.isLt; omega⟩

@[simp]
lemma frameVec_lightIdx (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) :
    frameVec F (lightIdx D hD) = b := frameVec_zero hD F

@[simp]
lemma frameVec_conjIdx (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) :
    frameVec F (conjIdx D hD) = F.frame.conj := frameVec_one hD F

@[simp]
lemma frameVec_transIdxLc (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (i : Fin (D - 2)) :
    frameVec F (transIdxLc D hD i) = F.trans.vec i := frameVec_trans hD F i

lemma transIdxLc_ne_conjIdx (hD : 2 ≤ D) (i : Fin (D - 2)) :
    transIdxLc D hD i ≠ conjIdx D hD := by
  simp [transIdxLc, conjIdx, Fin.ext_iff]

lemma lcMonomial_single_one (F : DDFLightConeFrame η a b) (v : Osc D) :
    lcMonomial F (Finsupp.single v 1) = lcCrea η (frameVec F v.1) v.2 := by
  rw [lcMonomial_single, pow_one]

lemma lcCrea_mul_lcCrea_eq_lcMonomial (F : DDFLightConeFrame η a b) (t t' : Fin D) (r s : ℕ+) :
    lcCrea η (frameVec F t) r * lcCrea η (frameVec F t') s
      = lcMonomial F (Finsupp.single ((t, r) : Osc D) 1 + Finsupp.single ((t', s) : Osc D) 1) := by
  rw [lcMonomial_add, lcMonomial_single, lcMonomial_single, pow_one, pow_one]

/-- **The seed space**: the light-cone monomials of level `n` that `L_{-n}|0;p⟩` produces
*besides* the leading `-α^{b̃}_{-n}`.  Every element of the defining set has either no `b̃`
factor at all, or exactly one whose mode number is `< n`; both cases lower the measure `μ` of
blueprint §B′.5 below that of `α^{b̃}_{-n}`. -/
noncomputable def lcSeed (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (n : ℕ+) :
    Submodule R (Fock D R) :=
  Submodule.span R (lcMonomial F '' {e : Osc D →₀ ℕ |
    Fock.level D e = (n : ℕ) ∧
      (conjDeg hD e = 0 ∨ (conjDeg hD e = 1 ∧ conjWt hD e < (n : ℕ)))})

lemma lcMonomial_mem_lcSeed (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) {n : ℕ+}
    {e : Osc D →₀ ℕ} (h1 : Fock.level D e = (n : ℕ))
    (h2 : conjDeg hD e = 0 ∨ (conjDeg hD e = 1 ∧ conjWt hD e < (n : ℕ))) :
    lcMonomial F e ∈ lcSeed (R := R) hD F n :=
  Submodule.subset_span ⟨e, ⟨h1, h2⟩, rfl⟩

/-- A contracted pair of creation operators whose mode numbers add up to `n` lies in the seed
space: the completeness relation turns it into `b`/`b̃` mixed terms (one `b̃` factor, mode
number `< n`) and purely transverse terms (no `b̃` factor). -/
theorem oscPair_mem_lcSeed (hD : 2 ≤ D) (F : DDFLightConeFrame η a b)
    (hη : ∀ μ, η μ * η μ = 1) {n r s : ℕ+} (hrs : (r : ℕ) + (s : ℕ) = (n : ℕ)) :
    (∑ μ : Fin D, η μ • ((X ((μ, r) : Osc D) : Fock D R) * X ((μ, s) : Osc D)))
      ∈ lcSeed hD F n := by
  classical
  have hr1 : 1 ≤ (r : ℕ) := r.2
  have hs1 : 1 ≤ (s : ℕ) := s.2
  rw [oscPair_eq_lightCone F hη r s]
  have hlev : ∀ t t' : Fin D,
      Fock.level D (Finsupp.single ((t, r) : Osc D) 1 + Finsupp.single ((t', s) : Osc D) 1)
        = (n : ℕ) := by
    intro t t'
    simp only [Fock.level_add, Fock.level_single, Fock.oscLevel_apply, one_mul]
    exact hrs
  have hmul : ∀ (t t' : Fin D) (w w' : Fin D → R), frameVec F t = w → frameVec F t' = w' →
      lcCrea η w r * lcCrea η w' s
        = lcMonomial F (Finsupp.single ((t, r) : Osc D) 1
            + Finsupp.single ((t', s) : Osc D) 1) := by
    intro t t' w w' hw hw'
    rw [← hw, ← hw', lcCrea_mul_lcCrea_eq_lcMonomial]
  refine Submodule.add_mem _ (Submodule.sub_mem _ (Submodule.neg_mem _ ?_) ?_)
    (Submodule.sum_mem _ fun i _ => ?_)
  · rw [hmul (lightIdx D hD) (conjIdx D hD) b F.frame.conj (frameVec_lightIdx hD F)
      (frameVec_conjIdx hD F)]
    refine lcMonomial_mem_lcSeed hD F (hlev _ _) (Or.inr ⟨?_, ?_⟩)
    · rw [conjDeg_add, conjDeg_single_of_ne hD (lightIdx_ne_conjIdx hD), conjDeg_single_conj,
        zero_add]
    · rw [conjWt_add, conjWt_single_of_ne hD (lightIdx_ne_conjIdx hD), conjWt_single_conj,
        zero_add]
      omega
  · rw [hmul (conjIdx D hD) (lightIdx D hD) F.frame.conj b (frameVec_conjIdx hD F)
      (frameVec_lightIdx hD F)]
    refine lcMonomial_mem_lcSeed hD F (hlev _ _) (Or.inr ⟨?_, ?_⟩)
    · rw [conjDeg_add, conjDeg_single_conj, conjDeg_single_of_ne hD (lightIdx_ne_conjIdx hD),
        add_zero]
    · rw [conjWt_add, conjWt_single_conj, conjWt_single_of_ne hD (lightIdx_ne_conjIdx hD),
        add_zero]
      omega
  · rw [hmul (transIdxLc D hD i) (transIdxLc D hD i) (F.trans.vec i) (F.trans.vec i)
      (frameVec_transIdxLc hD F i) (frameVec_transIdxLc hD F i)]
    refine lcMonomial_mem_lcSeed hD F (hlev _ _) (Or.inl ?_)
    rw [conjDeg_add, conjDeg_single_of_ne hD (transIdxLc_ne_conjIdx hD i),
      conjDeg_single_of_ne hD (transIdxLc_ne_conjIdx hD i), add_zero]

lemma negPNat_coe_of_neg {i : ℤ} (hi : i < 0) : ((negPNat i : ℕ+) : ℕ) = (-i).toNat := by
  rw [negPNat, Nat.toPNat'_coe, if_pos (by omega)]

/-- **The `b̃`-component of a rung momentum is `-1`, uniformly in the rung.**  The `b`
component `lam` is left unevaluated on purpose: it is rung-dependent
(`DDFLightConeFrame.dotVec_conj_towerMomentum` computes it as `1 + j` over a field) but the
elimination never needs its value, which is why nothing below requires `[Field R]`. -/
theorem lcCrea_towerMomentum (F : DDFLightConeFrame η a b) (n : ℕ+) (j : ℤ) :
    ∃ lam : R, lcCrea η (towerMomentum a b j) n
      = lam • lcCrea η b n - lcCrea η F.frame.conj n := by
  classical
  obtain ⟨lam, mu, c, hdec⟩ := F.exists_frame_decomp (towerMomentum a b j)
  obtain ⟨_, h2, h3⟩ := F.frame_decomp_coeff hdec
  have hmu : mu = -1 := by
    rw [h2, dotVec_towerMomentum_right_of_isotropic η a b F.frame.isotropic j, F.hba]
  have hc : ∀ i, c i = 0 := fun i => by rw [h3 i, F.dotVec_trans_towerMomentum i j]
  refine ⟨lam, ?_⟩
  rw [hdec, lcCrea_add, lcCrea_add, lcCrea_smul, lcCrea_smul, hmu, lcCrea_sum]
  rw [Finset.sum_congr rfl fun i (_ : i ∈ Finset.univ) => by rw [hc i, zero_smul, lcCrea_zero]]
  rw [Finset.sum_const_zero, add_zero, neg_one_smul, ← sub_eq_add_neg]

variable [Algebra ℚ R]

/-- **The leading term of `L_{-n}` on a rung vacuum** (blueprint §B′.4's
`towerLop_neg_conjDegree_leading`, at the vacuum):

`L_{-n}|0;p_j⟩ = -α^{b̃}_{-n}|0;p_j⟩ + (seed terms)`,

where the seed terms all have strictly smaller measure.  The coefficient of `α^{b̃}_{-n}` is
`-(b·p_j) = -1` and is **rung-independent**; the rung-dependent coefficient `-(b̃·p_j)` sits
in front of `α^b_{-n}`, i.e. inside the seed space (blueprint §B′.9 item 1(b)). -/
theorem Lop_neg_apply_one_add_conj_mem_lcSeed (hD : 2 ≤ D) (F : DDFLightConeFrame η a b)
    (hη : ∀ μ, η μ * η μ = 1) (n : ℕ+) (j : ℤ) :
    Fock.Lop η (towerMomentum a b j) (-((n : ℕ) : ℤ)) (1 : Fock D R)
        + lcCrea η F.frame.conj n ∈ lcSeed hD F n := by
  classical
  obtain ⟨lam, hlam⟩ := lcCrea_towerMomentum F n j
  rw [Lop_neg_apply_one η (towerMomentum a b j) n, hlam]
  rw [show ∀ S : Fock D R, lam • lcCrea η b n - lcCrea η F.frame.conj n + invTwo R • S
        + lcCrea η F.frame.conj n = lam • lcCrea η b n + invTwo R • S from fun S => by abel]
  refine Submodule.add_mem _ (Submodule.smul_mem _ _ ?_) (Submodule.smul_mem _ _ ?_)
  · have hbn : lcCrea η b n = lcMonomial F (Finsupp.single ((lightIdx D hD, n) : Osc D) 1) := by
      rw [lcMonomial_single_one, frameVec_lightIdx]
    rw [hbn]
    refine lcMonomial_mem_lcSeed hD F ?_ (Or.inl ?_)
    · simp
    · exact conjDeg_single_of_ne hD (lightIdx_ne_conjIdx hD) 1
  · refine Submodule.sum_mem _ fun m hm => ?_
    rw [Finset.mem_Ioo] at hm
    refine oscPair_mem_lcSeed hD F hη ?_
    rw [negPNat_coe_of_neg (by omega : (-((n : ℕ) : ℤ) - m) < 0), negPNat_coe_of_neg hm.2]
    omega

end Seed

/-! ### Moving `L_{-n}` past the creation operators of a light-cone monomial -/

section Leibniz

variable {D : ℕ} {R : Type*} [CommRing R] {η a b : Fin D → R}

/-- Multiplying a `(β, ω)`-box by one light-cone creation operator shifts all three gradings
by the gradings of that single factor. -/
lemma lcCrea_mul_mem_lcBound (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) {N β₀ ω₀ : ℕ}
    (v : Osc D) {x : Fock D R} (hx : x ∈ lcBound hD F N β₀ ω₀) :
    lcCrea η (frameVec F v.1) v.2 * x
      ∈ lcBound hD F (N + (v.2 : ℕ)) (β₀ + conjDeg hD (Finsupp.single v 1))
          (ω₀ + conjWt hD (Finsupp.single v 1)) := by
  classical
  have hle : lcBound (R := R) hD F N β₀ ω₀ ≤
      Submodule.comap (LinearMap.mulLeft R (lcCrea η (frameVec F v.1) v.2))
        (lcBound hD F (N + (v.2 : ℕ)) (β₀ + conjDeg hD (Finsupp.single v 1))
          (ω₀ + conjWt hD (Finsupp.single v 1))) := by
    rw [lcBound, Submodule.span_le]
    rintro _ ⟨e, ⟨h1, h2, h3⟩, rfl⟩
    have hprod : lcCrea η (frameVec F v.1) v.2 * lcMonomial F e
        = lcMonomial F (Finsupp.single v 1 + e) := by
      rw [lcMonomial_add, lcMonomial_single_one]
    rw [SetLike.mem_coe, Submodule.mem_comap, LinearMap.mulLeft_apply, hprod]
    refine lcMonomial_mem_lcBound hD F ?_ ?_ ?_
    · rw [Fock.level_add, h1, Fock.level_single, Fock.oscLevel, one_mul]
      omega
    · rw [conjDeg_add]
      omega
    · rw [conjWt_add]
      omega
  exact hle hx

variable [Algebra ℚ R]

/-- **`[L_{-n}, α^w_{-r}] = r α^w_{-n-r}`, in multiplicative form.**  The commutator of the
Sugawara generator with a single light-cone creation operator produces another creation
operator, so `L_{-n}` can be moved all the way through a light-cone monomial. -/
lemma Lop_neg_apply_lcCrea_mul (η p w : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (n r : ℕ+)
    (Y : Fock D R) :
    Fock.Lop η p (-((n : ℕ) : ℤ)) (lcCrea η w r * Y)
      = ((r : ℕ) : R) • (lcCrea η w (n + r) * Y)
        + lcCrea η w r * Fock.Lop η p (-((n : ℕ) : ℤ)) Y := by
  have hexp : ∀ (t : ℕ+) (Z : Fock D R), lcCrea η w t * Z
      = ∑ μ : Fin D, (η μ * w μ) • Fock.mode η p μ (-((t : ℕ) : ℤ)) Z := by
    intro t Z
    rw [lcCrea_def, Finset.sum_mul]
    exact Finset.sum_congr rfl fun μ _ => by
      rw [Fock.mode_neg_pnat, Fock.creation_apply, smul_mul_assoc]
  have h1 : (-((-((r : ℕ) : ℤ) : ℤ) : R)) = ((r : ℕ) : R) := by push_cast; ring
  have h2 : (-((n : ℕ) : ℤ)) + (-((r : ℕ) : ℤ)) = -(((n + r : ℕ+) : ℕ) : ℤ) := by
    push_cast; ring
  rw [hexp r Y, map_sum]
  have hterm : ∀ μ : Fin D,
      Fock.Lop η p (-((n : ℕ) : ℤ)) ((η μ * w μ) • Fock.mode η p μ (-((r : ℕ) : ℤ)) Y)
        = (η μ * w μ) • (((r : ℕ) : R) • Fock.mode η p μ (-(((n + r : ℕ+) : ℕ) : ℤ)) Y)
          + (η μ * w μ) • Fock.mode η p μ (-((r : ℕ) : ℤ))
              (Fock.Lop η p (-((n : ℕ) : ℤ)) Y) := by
    intro μ
    rw [map_smul, Fock.Lop_apply_mode η p hη _ μ _ Y, h1, h2, smul_add]
  rw [Finset.sum_congr rfl fun μ (_ : μ ∈ Finset.univ) => hterm μ, Finset.sum_add_distrib]
  congr 1
  · rw [hexp (n + r) Y, Finset.smul_sum]
    exact Finset.sum_congr rfl fun μ _ => smul_comm _ _ _
  · rw [hexp r (Fock.Lop η p (-((n : ℕ) : ℤ)) Y)]

/-- **`L_{-n}` on a light-cone monomial, modulo lower `β`** (the "Leibniz half" of blueprint
§B′.4's `towerLop_neg_conjDegree_leading`).

Moving `L_{-n}` through the monomial with `Lop_neg_apply_lcCrea_mul` leaves the vacuum term
`m(d)·L_{-n}|0;p⟩` plus one term per factor, each of which *replaces* a factor `α^w_{-l}` by
`α^w_{-(n+l)}`.  Replacing never creates a new `α^{b̃}`, so every remainder term has `β`
exactly `β(d)` — one less than the `β` of the target monomial in the elimination.  The
momentum `p` is arbitrary: this half is rung-independent. -/
theorem Lop_neg_apply_lcMonomial_sub_mem_lcBound (hD : 2 ≤ D) (F : DDFLightConeFrame η a b)
    (hη : ∀ μ, η μ * η μ = 1) (p : Fin D → R) (n : ℕ+) (d : Osc D →₀ ℕ) :
    Fock.Lop η p (-((n : ℕ) : ℤ)) (lcMonomial F d)
        - lcMonomial F d * Fock.Lop η p (-((n : ℕ) : ℤ)) 1
      ∈ lcBound hD F (Fock.level D d + (n : ℕ)) (conjDeg hD d) (conjWt hD d + (n : ℕ)) := by
  classical
  induction d using finsupp_addSingle_induction with
  | h0 =>
      rw [lcMonomial_zero, one_mul, sub_self]
      exact Submodule.zero_mem _
  | hstep d v ih =>
      have hlev : Fock.level D (d + Finsupp.single v 1) = Fock.level D d + (v.2 : ℕ) := by
        rw [Fock.level_add, Fock.level_single, Fock.oscLevel, one_mul]
      have hcomm : lcMonomial F (d + Finsupp.single v 1)
          = lcCrea η (frameVec F v.1) v.2 * lcMonomial F d := by
        rw [lcMonomial_add, lcMonomial_single_one, mul_comm]
      rw [hcomm, Lop_neg_apply_lcCrea_mul η p _ hη n v.2 (lcMonomial F d)]
      have hsplit : ((v.2 : ℕ) : R) • (lcCrea η (frameVec F v.1) (n + v.2) * lcMonomial F d)
            + lcCrea η (frameVec F v.1) v.2 * Fock.Lop η p (-((n : ℕ) : ℤ)) (lcMonomial F d)
            - lcCrea η (frameVec F v.1) v.2 * lcMonomial F d
                * Fock.Lop η p (-((n : ℕ) : ℤ)) 1
          = ((v.2 : ℕ) : R) • (lcCrea η (frameVec F v.1) (n + v.2) * lcMonomial F d)
            + lcCrea η (frameVec F v.1) v.2
                * (Fock.Lop η p (-((n : ℕ) : ℤ)) (lcMonomial F d)
                  - lcMonomial F d * Fock.Lop η p (-((n : ℕ) : ℤ)) 1) := by
        rw [mul_sub, mul_assoc]
        abel
      rw [hsplit]
      refine Submodule.add_mem _ (Submodule.smul_mem _ _ ?_) ?_
      · have hprod : lcCrea η (frameVec F v.1) (n + v.2) * lcMonomial F d
            = lcMonomial F (Finsupp.single ((v.1, n + v.2) : Osc D) 1 + d) := by
          rw [lcMonomial_add, lcMonomial_single_one]
        rw [hprod]
        refine lcMonomial_mem_lcBound hD F ?_ ?_ ?_
        · rw [Fock.level_add, hlev]
          simp only [Fock.level_single, Fock.oscLevel_apply, one_mul, PNat.add_coe]
          omega
        · rw [conjDeg_add, conjDeg_add, conjDeg_single, conjDeg_single]
          split_ifs <;> omega
        · rw [conjWt_add, conjWt_add, conjWt_single, conjWt_single]
          simp only [PNat.add_coe]
          split_ifs <;> omega
      · have hmem := lcCrea_mul_mem_lcBound hD F v ih
        have e1 : Fock.level D d + (n : ℕ) + (v.2 : ℕ)
            = Fock.level D (d + Finsupp.single v 1) + (n : ℕ) := by
          rw [hlev]; omega
        have e2 : conjDeg hD d + conjDeg hD (Finsupp.single v 1)
            = conjDeg hD (d + Finsupp.single v 1) := (conjDeg_add hD d _).symm
        have e3 : conjWt hD d + (n : ℕ) + conjWt hD (Finsupp.single v 1)
            = conjWt hD (d + Finsupp.single v 1) + (n : ℕ) := by
          rw [conjWt_add]; omega
        rw [e1, e2, e3] at hmem
        exact hmem

end Leibniz

/-! ### The leading-term lemma -/

section Leading

variable {D : ℕ} {R : Type*} [CommRing R] {η a b : Fin D → R}

/-- Multiplying the seed space by a light-cone monomial lands strictly below the measure of
the target monomial `d' + α^{b̃}_{-n}`: every seed generator has either no `b̃` factor (measure
at most its level `n`) or a single one of mode number `< n`. -/
lemma lcMonomial_mul_lcSeed_le_lcLow (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (n : ℕ+)
    (d' : Osc D →₀ ℕ) {N : ℕ} (hN : Fock.level D d' + (n : ℕ) = N) {z : Fock D R}
    (hz : z ∈ lcSeed hD F n) :
    lcMonomial F d' * z
      ∈ lcLow hD F N
          (lcMeasure hD N (d' + Finsupp.single ((conjIdx D hD, n) : Osc D) 1)) := by
  classical
  have hle : lcSeed (R := R) hD F n ≤
      Submodule.comap (LinearMap.mulLeft R (lcMonomial F d'))
        (lcLow hD F N
          (lcMeasure hD N (d' + Finsupp.single ((conjIdx D hD, n) : Osc D) 1))) := by
    rw [lcSeed, Submodule.span_le]
    rintro _ ⟨e, ⟨h1, h2⟩, rfl⟩
    rw [SetLike.mem_coe, Submodule.mem_comap, LinearMap.mulLeft_apply, ← lcMonomial_add]
    refine lcMonomial_mem_lcLow hD F ?_ ?_
    · rw [Fock.level_add, h1, hN]
    · have hkey : lcMeasure hD N e < N + 1 + (n : ℕ) := by
        rcases h2 with h2 | ⟨h2a, h2b⟩
        · have hw := conjWt_le_level hD e
          rw [h1] at hw
          simp only [lcMeasure, h2, zero_mul, zero_add]
          omega
        · simp only [lcMeasure, h2a, one_mul]
          omega
      rw [lcMeasure_add, lcMeasure_add, lcMeasure_single_conj]
      omega
  exact hle hz

variable [Algebra ℚ R]

/-- **The leading-term lemma** (blueprint §B′.4's `towerLop_neg_conjDegree_leading`, on a
single Fock fiber).

For a light-cone monomial `m(d')` and `n ≥ 1`,

`α^{b̃}_{-n} m(d') = -L_{-n} m(d') + (light-cone monomials of strictly smaller measure μ)`,

where `μ(d) = β(d)·(N+1) + ω(d)` is the induction variable of blueprint §B′.5 and `N` is the
common level `level(d') + n` of all terms.

Two things the blueprint's draft statement spells out are *absorbed* into the remainder here:
the explicit sum `∑_{l<n} α^b_{-(n-l)} α^{b̃}_{-l}` (its terms have `β` equal to the target's
but `ω` strictly smaller) and the zero-mode coefficient `-(b̃·p_j)` (rung-dependent, but it
multiplies `α^b_{-n}`, whose `β` is strictly smaller).  Consequently the statement is
uniform in the rung `j` and needs no field. -/
theorem lcMonomial_conj_add_Lop_mem_lcLow (hD : 2 ≤ D) (F : DDFLightConeFrame η a b)
    (hη : ∀ μ, η μ * η μ = 1) (n : ℕ+) (j : ℤ) (d' : Osc D →₀ ℕ) {N : ℕ}
    (hN : Fock.level D d' + (n : ℕ) = N) :
    lcMonomial F (d' + Finsupp.single ((conjIdx D hD, n) : Osc D) 1)
        + Fock.Lop η (towerMomentum a b j) (-((n : ℕ) : ℤ)) (lcMonomial F d')
      ∈ lcLow hD F N
          (lcMeasure hD N (d' + Finsupp.single ((conjIdx D hD, n) : Osc D) 1)) := by
  classical
  subst hN
  set p := towerMomentum a b j with hp
  have hfac : lcMonomial F (d' + Finsupp.single ((conjIdx D hD, n) : Osc D) 1)
      = lcMonomial F d' * lcCrea η F.frame.conj n := by
    rw [lcMonomial_add, lcMonomial_single_one, frameVec_conjIdx]
  have hsplit : lcMonomial F d' * lcCrea η F.frame.conj n
        + Fock.Lop η p (-((n : ℕ) : ℤ)) (lcMonomial F d')
      = (Fock.Lop η p (-((n : ℕ) : ℤ)) (lcMonomial F d')
          - lcMonomial F d' * Fock.Lop η p (-((n : ℕ) : ℤ)) 1)
        + lcMonomial F d'
            * (Fock.Lop η p (-((n : ℕ) : ℤ)) 1 + lcCrea η F.frame.conj n) := by
    ring
  rw [hfac, hsplit]
  refine Submodule.add_mem _ ?_ ?_
  · refine lcBound_le_lcLow hD F ?_
      (Lop_neg_apply_lcMonomial_sub_mem_lcBound hD F hη p n d')
    rw [lcMeasure_add, lcMeasure_single_conj]
    simp only [lcMeasure]
    omega
  · exact lcMonomial_mul_lcSeed_le_lcLow hD F n d' rfl
      (Lop_neg_apply_one_add_conj_mem_lcSeed hD F hη n j)

/-- The tower form of the leading-term lemma: the same statement, on rung `j`. -/
theorem towerLop_neg_conjDegree_leading (hD : 2 ≤ D) (F : DDFLightConeFrame η a b)
    (hη : ∀ μ, η μ * η μ = 1) (n : ℕ+) (j : ℤ) (d' : Osc D →₀ ℕ) {N : ℕ}
    (hN : Fock.level D d' + (n : ℕ) = N) :
    Finsupp.single j (lcMonomial F (d' + Finsupp.single ((conjIdx D hD, n) : Osc D) 1))
        + towerLop η a b (-((n : ℕ) : ℤ)) (Finsupp.single j (lcMonomial F d'))
      ∈ Submodule.map (Finsupp.lsingle (M := Fock D R) (R := R) j)
          (lcLow hD F N
            (lcMeasure hD N (d' + Finsupp.single ((conjIdx D hD, n) : Osc D) 1))) := by
  rw [towerLop_single, ← Finsupp.single_add]
  exact ⟨_, lcMonomial_conj_add_Lop_mem_lcLow hD F hη n j d' hN, rfl⟩

end Leading

/-! ### The `β`-elimination -/

section Elimination

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] {η a b : Fin D → R}

/-- **Every light-cone monomial of level `N`, placed on rung `-N`, is `b̃`-free modulo
spurious states** (blueprint §B′.5, the induction).

Strong induction on the measure `μ(d) = β(d)·(N+1) + ω(d)`.  If `β(d) = 0` the monomial is
already `b̃`-free.  Otherwise peel off one factor `α^{b̃}_{-n}`, write `d = d₀ + (b̃, n)` and
apply the leading-term lemma: `m(d)` equals `-L_{-n} m(d₀)` — a spurious state — plus light-cone
monomials of strictly smaller measure, which the induction hypothesis already handles. -/
theorem single_lcMonomial_mem_conjFreeSlice_sup_towerSpurious (hD : 2 ≤ D)
    (F : DDFLightConeFrame η a b) (hη : ∀ μ, η μ * η μ = 1) (N : ℕ) (d : Osc D →₀ ℕ)
    (hd : Fock.level D d = N) :
    Finsupp.single (-(N : ℤ)) (lcMonomial F d)
      ∈ conjFreeSlice hD F N ⊔ towerSpuriousSubmodule η a b := by
  classical
  suffices h : ∀ M : ℕ, ∀ e : Osc D →₀ ℕ, Fock.level D e = N → lcMeasure hD N e ≤ M →
      Finsupp.single (-(N : ℤ)) (lcMonomial F e)
        ∈ conjFreeSlice hD F N ⊔ towerSpuriousSubmodule η a b from
    h (lcMeasure hD N d) d hd le_rfl
  intro M
  induction M with
  | zero =>
      intro e he hM
      refine Submodule.mem_sup_left ⟨lcMonomial F e, lcMonomial_mem_conjFree hD F he ?_, rfl⟩
      simp only [lcMeasure] at hM
      have hz : conjDeg hD e * (N + 1) = 0 := by omega
      rcases Nat.mul_eq_zero.mp hz with h' | h'
      · exact h'
      · omega
  | succ M ih =>
      intro e he hM
      by_cases hc : conjDeg hD e = 0
      · exact Submodule.mem_sup_left ⟨lcMonomial F e, lcMonomial_mem_conjFree hD F he hc, rfl⟩
      obtain ⟨v, hvmem, hv1⟩ : ∃ v ∈ e.support, v.1 = conjIdx D hD := by
        by_contra hcon
        refine hc ?_
        rw [conjDeg, Finsupp.weight_apply]
        refine Finset.sum_eq_zero fun v hv => ?_
        show (e v) • (if v.1 = conjIdx D hD then (1 : ℕ) else 0) = 0
        rw [if_neg (fun h => hcon ⟨v, hv, h⟩), smul_zero]
      obtain ⟨t, n⟩ := v
      simp only at hv1
      subst hv1
      set e₀ := e - Finsupp.single ((conjIdx D hD, n) : Osc D) 1 with he₀
      have hsplit : e₀ + Finsupp.single ((conjIdx D hD, n) : Osc D) 1 = e := by
        rw [he₀, add_comm]
        exact Fock.single_add_tsub_single (Finsupp.mem_support_iff.mp hvmem)
      have hlev : Fock.level D e₀ + (n : ℕ) = N := by
        rw [← he, ← hsplit, Fock.level_add, Fock.level_single, Fock.oscLevel, one_mul]
      have hmeas : lcMeasure hD N e
          = lcMeasure hD N e₀ + lcMeasure hD N (Finsupp.single ((conjIdx D hD, n) : Osc D) 1) := by
        rw [← hsplit, lcMeasure_add]
      have hZ : Submodule.map (Finsupp.lsingle (M := Fock D R) (R := R) (-(N : ℤ)))
            (lcLow hD F N (lcMeasure hD N
              (e₀ + Finsupp.single ((conjIdx D hD, n) : Osc D) 1)))
          ≤ conjFreeSlice hD F N ⊔ towerSpuriousSubmodule η a b := by
        rw [lcLow, Submodule.map_span, Submodule.span_le]
        rintro _ ⟨_, ⟨f, ⟨h1, h2⟩, rfl⟩, rfl⟩
        rw [hsplit] at h2
        exact ih f h1 (by omega)
      have hlead := towerLop_neg_conjDegree_leading hD F hη n (-(N : ℤ)) e₀ hlev
      have hAB : Finsupp.single (-(N : ℤ)) (lcMonomial F e)
          = (Finsupp.single (-(N : ℤ))
                (lcMonomial F (e₀ + Finsupp.single ((conjIdx D hD, n) : Osc D) 1))
              + towerLop η a b (-((n : ℕ) : ℤ))
                  (Finsupp.single (-(N : ℤ)) (lcMonomial F e₀)))
            - towerLop η a b (-((n : ℕ) : ℤ))
                (Finsupp.single (-(N : ℤ)) (lcMonomial F e₀)) := by
        rw [hsplit]
        abel
      rw [hAB]
      exact Submodule.sub_mem _ (hZ hlead)
        (Submodule.mem_sup_right
          (towerLop_neg_mem_towerSpuriousSubmodule (by exact_mod_cast n.2) _))

/-- **`β`-elimination on the antidiagonal slice** (blueprint §B′.4's
`towerBigrade_le_conjFree_sup_spurious`): modulo spurious states, the whole bigraded piece
`(rung -N, level N)` is spanned by `b̃`-free light-cone monomials.

`D = 26` does not appear, and neither does the intercept: the only inputs are the frame
`F`, `η_μ² = 1` and `2 ≤ D`. -/
theorem towerBigrade_le_conjFreeSlice_sup_towerSpurious (hD : 2 ≤ D)
    (F : DDFLightConeFrame η a b) (hη : ∀ μ, η μ * η μ = 1) (N : ℕ) :
    towerBigrade D R (-(N : ℤ)) N ≤ conjFreeSlice hD F N ⊔ towerSpuriousSubmodule η a b := by
  classical
  rw [towerBigrade, levelSubmodule_eq_lcSpan hD F hη N, lcSpan, Submodule.map_span,
    Submodule.span_le]
  rintro _ ⟨_, ⟨f, hf, rfl⟩, rfl⟩
  exact single_lcMonomial_mem_conjFreeSlice_sup_towerSpurious hD F hη N f hf

end Elimination

/-! ### Nondegeneracy of the Fock and tower forms -/

section Nondegenerate

variable {D : ℕ} {R : Type*} [CommRing R]

/-- **The diagonal entries of the Fock Gram matrix are nonzero** over a characteristic-zero
ring without zero divisors: `monomialNorm η d = ∏ (n η_μ)^{d} d!`, and each factor is a
nonzero natural times a unit (`η_μ² = 1`).

`NoGhost/FockGram.lean` only has the *ordered* version `monomialNorm_pos` (which needs
`0 < η μ`, i.e. a Euclidean metric) and the characteristic-`2` counterexample; the
characteristic-zero statement for an indefinite `η` is what the nondegeneracy argument
needs. -/
theorem Fock.monomialNorm_ne_zero [NoZeroDivisors R] [CharZero R] {η : Fin D → R}
    (hη : ∀ μ, η μ * η μ = 1) (d : Osc D →₀ ℕ) : Fock.monomialNorm η d ≠ 0 := by
  classical
  rw [Fock.monomialNorm, Finsupp.prod]
  refine Finset.prod_ne_zero_iff.mpr fun v _ => ?_
  refine mul_ne_zero (pow_ne_zero _ ?_) (Nat.cast_ne_zero.mpr (Nat.factorial_ne_zero _))
  show ((v.2 : ℕ) : R) * η v.1 ≠ 0
  refine mul_ne_zero (Nat.cast_ne_zero.mpr v.2.ne_zero) fun hz => ?_
  have h := hη v.1
  rw [hz, mul_zero] at h
  exact one_ne_zero h.symm

/-- **The Fock form is nondegenerate** over a characteristic-zero ring without zero divisors
(graph node `worldsheet.covariant-fock-space-form`; `NoGhost/TowerNull.lean`'s gap list item 2
records the absence of this statement).  Pairing against the monomial `x^d` reads off the
coefficient of `x^d` up to the nonzero factor `monomialNorm η d`. -/
theorem Fock.eq_zero_of_pairing_left_eq_zero [NoZeroDivisors R] [CharZero R] {η : Fin D → R}
    (hη : ∀ μ, η μ * η μ = 1) {P : Fock D R}
    (h : ∀ Q : Fock D R, Fock.pairing η P Q = 0) : P = 0 := by
  classical
  refine MvPolynomial.ext _ _ fun d => ?_
  rw [MvPolynomial.coeff_zero]
  have h1 := h (MvPolynomial.monomial d 1)
  rw [Fock.pairing_comm, Fock.pairing_monomial_left, one_mul] at h1
  exact (mul_eq_zero.mp h1).resolve_left (Fock.monomialNorm_ne_zero hη d)

/-- **The tower form is nondegenerate**: rung by rung, by `Fock.eq_zero_of_pairing_left_eq_zero`
(the rungs are mutually orthogonal, so testing against a single-rung vector isolates one
component).  This closes gap item 2 of `NoGhost/TowerNull.lean`. -/
theorem Fock.eq_zero_of_towerPairing_left_eq_zero [NoZeroDivisors R] [CharZero R]
    {η : Fin D → R} (hη : ∀ μ, η μ * η μ = 1) {X : TowerFock D R}
    (h : ∀ Y : TowerFock D R, Fock.towerPairing η X Y = 0) : X = 0 := by
  refine Finsupp.ext fun j => ?_
  show X j = 0
  refine Fock.eq_zero_of_pairing_left_eq_zero hη fun Q => ?_
  have hj := h (Finsupp.single j Q)
  rw [Fock.towerPairing_comm, Fock.towerPairing_single_left] at hj
  rw [Fock.pairing_comm]
  exact hj

end Nondegenerate

/-! ### Physical states on the antidiagonal slice are exactly the spurious-orthogonal ones -/

section PhysOrthogonal

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

/-- **(P3), first half** (blueprint §B′.4's `towerPhys_inf_towerBigrade_eq_orthogonal`): on the
antidiagonal slice `(rung -N, level N)`, being physical is the *same* as being orthogonal to
every spurious state.

The `⊆` half is `towerSpuriousSubmodule_le_towerOrthComplement` plus symmetry of the form.
The `⊇` half uses `L_m† = L_{-m}` and the nondegeneracy of the tower form to turn
"`⟨Ψ, L_m x⟩ = 0` for all `Ψ`" into `L_m x = 0`; the `L_0` condition is automatic on the
antidiagonal, because `towerLop_zero_apply_of_mem_towerBigrade` gives the eigenvalue
`α'k² + j + N` and `j = -N`.

`D = 26` does not appear, and no light-cone frame is needed. -/
theorem towerPhys_inf_towerBigrade_eq_towerOrthComplement [NoZeroDivisors R] [CharZero R]
    (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (hbb : dotVec η b b = 0)
    (hba : dotVec η b a = 1) (N : ℕ) :
    towerPhysSubmodule η a b (invTwo R * Fock.zeroModeSq η a) ⊓ towerBigrade D R (-(N : ℤ)) N
      = towerOrthComplement η (towerSpuriousSubmodule η a b)
          ⊓ towerBigrade D R (-(N : ℤ)) N := by
  refine le_antisymm (fun x hx => ?_) (fun x hx => ?_)
  · obtain ⟨hphys, hbig⟩ := Submodule.mem_inf.mp hx
    refine Submodule.mem_inf.2 ⟨?_, hbig⟩
    rw [mem_towerOrthComplement]
    intro Ψ hΨ
    have h := towerSpuriousSubmodule_le_towerOrthComplement η a b
      (invTwo R * Fock.zeroModeSq η a) hΨ
    rw [mem_towerOrthComplement] at h
    rw [Fock.towerPairing_comm]
    exact h x hphys
  · obtain ⟨horth, hbig⟩ := Submodule.mem_inf.mp hx
    rw [mem_towerOrthComplement] at horth
    refine Submodule.mem_inf.2 ⟨mem_towerPhysSubmodule.2 ⟨?_, fun m hm => ?_⟩, hbig⟩
    · rw [towerLop_zero_apply_of_mem_towerBigrade η a b hη hbb hba hbig]
      congr 1
      push_cast
      ring
    · refine Fock.eq_zero_of_towerPairing_left_eq_zero hη fun Y => ?_
      rw [Fock.towerPairing_towerLop_left η a b m x Y]
      exact horth _ (towerLop_neg_mem_towerSpuriousSubmodule hm Y)

end PhysOrthogonal

/-! ### The form is nondegenerate on each slice -/

section SliceRadical

variable {D : ℕ} {R : Type*} [CommRing R] [NoZeroDivisors R] [CharZero R]

/-- **No slice has a radical**: a vector of the bigraded piece `(j, N)` orthogonal to that
whole piece is zero.  Distinct slices are already orthogonal
(`towerPairing_towerBigradeProj_left`), so orthogonality to one slice upgrades to orthogonality
to everything, and then `Fock.eq_zero_of_towerPairing_left_eq_zero` applies. -/
theorem eq_zero_of_mem_towerBigrade_of_orthogonal {η : Fin D → R} (hη : ∀ μ, η μ * η μ = 1)
    (j : ℤ) (N : ℕ) {x : TowerFock D R} (hx : x ∈ towerBigrade D R j N)
    (h : ∀ y ∈ towerBigrade D R j N, Fock.towerPairing η x y = 0) : x = 0 := by
  have hxp : towerBigradeProj D R j N x = x := towerBigradeProj_of_mem_self hx
  refine Fock.eq_zero_of_towerPairing_left_eq_zero hη fun y => ?_
  have hproj := towerPairing_towerBigradeProj_left η j N x y
  rw [hxp] at hproj
  rw [hproj]
  exact h _ (towerBigradeProj_mem j N y)

end SliceRadical

/-! ### Counting the `b̃`-free monomials -/

section Counting

variable {D : ℕ} {R : Type*} [CommRing R] {η a b : Fin D → R}

/-- The `b̃`-free level-`N` occupation functions form a finite set: they are a subset of the
level-`N` ones, and `Fock.finite_setOf_level_eq` already knows those are finite. -/
theorem finite_setOf_conjFreeIndex (hD : 2 ≤ D) (N : ℕ) :
    {d : Osc D →₀ ℕ | Fock.level D d = N ∧ conjDeg hD d = 0}.Finite :=
  (Fock.finite_setOf_level_eq D N).subset fun _ hd => hd.1

/-- The index set of blueprint §B′.4's `p_{D−1}(N)`, as a `Fintype`.  Its cardinality is never
evaluated (§B′.8). -/
noncomputable instance conjFreeIndexFintype {D : ℕ} (hD : 2 ≤ D) (N : ℕ) :
    Fintype {d : Osc D →₀ ℕ // Fock.level D d = N ∧ conjDeg hD d = 0} :=
  (finite_setOf_conjFreeIndex hD N).fintype

lemma conjFree_le_levelSubmodule (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (N : ℕ) :
    conjFree (R := R) hD F N ≤ Fock.levelSubmodule D R N := by
  rw [conjFree, Submodule.span_le]
  rintro _ ⟨d, ⟨h1, _⟩, rfl⟩
  exact h1 ▸ lcMonomial_mem_levelSubmodule F d

lemma conjFreeSlice_le_towerBigrade (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (N : ℕ) :
    conjFreeSlice (R := R) hD F N ≤ towerBigrade D R (-(N : ℤ)) N :=
  Submodule.map_mono (conjFree_le_levelSubmodule hD F N)

end Counting

section CountingField

variable {D : ℕ} {K : Type*} [Field K] {η a b : Fin D → K}

instance conjFree_finiteDimensional (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (N : ℕ) :
    FiniteDimensional K ↥(conjFree hD F N) := by
  have : FiniteDimensional K ↥(Fock.levelSubmodule D K N) := Fock.levelSubmodule_finite D K N
  exact Submodule.finiteDimensional_of_le (conjFree_le_levelSubmodule hD F N)

/-- **`dim (b̃-free level-`N` span) ≤ p_{D−1}(N)`**: the `b̃`-free light-cone monomials span it,
and they are indexed by the finite set of `b̃`-free level-`N` occupation functions.  (Only an
inequality: the light-cone monomials are not known to be linearly independent, blueprint §B′.9
item 2.) -/
theorem finrank_conjFree_le (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (N : ℕ) :
    Module.finrank K ↥(conjFree hD F N)
      ≤ Fintype.card {d : Osc D →₀ ℕ // Fock.level D d = N ∧ conjDeg hD d = 0} := by
  classical
  have hrange : conjFree (R := K) hD F N
      = Submodule.span K (Set.range fun d : {d : Osc D →₀ ℕ //
          Fock.level D d = N ∧ conjDeg hD d = 0} => lcMonomial F (d : Osc D →₀ ℕ)) := by
    rw [conjFree, Set.image_eq_range]
    rfl
  rw [hrange]
  exact finrank_range_le_card _

instance conjFreeSlice_finiteDimensional (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (N : ℕ) :
    FiniteDimensional K ↥(conjFreeSlice hD F N) :=
  Submodule.finiteDimensional_of_le (conjFreeSlice_le_towerBigrade hD F N)

theorem finrank_conjFreeSlice_le (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (N : ℕ) :
    Module.finrank K ↥(conjFreeSlice hD F N)
      ≤ Fintype.card {d : Osc D →₀ ℕ // Fock.level D d = N ∧ conjDeg hD d = 0} :=
  le_trans (Submodule.finrank_map_le _ _) (finrank_conjFree_le hD F N)

end CountingField

/-! ### (P3): the physical slice is no bigger than the `b̃`-free span -/

section P3

variable {D : ℕ} {K : Type*} [Field K] [CharZero K] [Algebra ℚ K] {η a b : Fin D → K}

omit [CharZero K] [Algebra ℚ K] in
/-- If a space embeds into the dual of a finite-dimensional space, it is no bigger.  Stated on
abstract vector spaces so that the `AddCommMonoid` instance path of `Module.Dual` matches
Mathlib's `Subspace.dual_finrank_eq` (on a `Submodule` coercion the two paths are only
defeq). -/
private theorem finrank_le_of_injective_toDualHom {V : Type*} [AddCommGroup V] [Module K V]
    {M : Type*} [AddCommGroup M] [Module K M] (W : Submodule K M) [FiniteDimensional K ↥W]
    {f : V →ₗ[K] (↥W →ₗ[K] K)} (hf : Function.Injective f) :
    Module.finrank K V ≤ Module.finrank K ↥W := by
  have hfin : Module.Finite K (↥W →ₗ[K] K) :=
    (inferInstance : FiniteDimensional K (Module.Dual K ↥W))
  exact le_trans (LinearMap.finrank_le_finrank_of_injective hf)
    (le_of_eq (Subspace.dual_finrank_eq (K := K) (V := ↥W)))

/-- A physical state on the slice that is orthogonal to every `b̃`-free light-cone monomial is
zero: it is orthogonal to the spurious states by
`towerPhys_inf_towerBigrade_eq_towerOrthComplement`, hence — by the `β`-elimination — to the
whole slice, hence zero by `eq_zero_of_mem_towerBigrade_of_orthogonal`. -/
theorem eq_zero_of_mem_towerPhys_inf_towerBigrade_of_orthogonal_conjFreeSlice (hD : 2 ≤ D)
    (F : DDFLightConeFrame η a b) (N : ℕ) {x : TowerFock D K}
    (hxH : x ∈ towerPhysSubmodule η a b (invTwo K * Fock.zeroModeSq η a)
      ⊓ towerBigrade D K (-(N : ℤ)) N)
    (hxC : ∀ c ∈ conjFreeSlice hD F N, Fock.towerPairing η x c = 0) : x = 0 := by
  have hxV : x ∈ towerBigrade D K (-(N : ℤ)) N := (Submodule.mem_inf.mp hxH).2
  have hxS : ∀ s ∈ towerSpuriousSubmodule η a b, Fock.towerPairing η x s = 0 := by
    have heq := towerPhys_inf_towerBigrade_eq_towerOrthComplement η a b F.hη
      F.frame.isotropic F.hba N
    rw [heq] at hxH
    rw [← mem_towerOrthComplement]
    exact (Submodule.mem_inf.mp hxH).1
  refine eq_zero_of_mem_towerBigrade_of_orthogonal F.hη (-(N : ℤ)) N hxV fun y hy => ?_
  obtain ⟨c, hc, s, hs, rfl⟩ := Submodule.mem_sup.mp
    (towerBigrade_le_conjFreeSlice_sup_towerSpurious hD F F.hη N hy)
  rw [map_add, hxC c hc, hxS s hs, add_zero]

/-- The pairing of the physical slice against the `b̃`-free span, packaged as a linear map into
the dual of that span.  Named rather than inlined so that its codomain is elaborated once and
the `Module.Finite` instance for it is found. -/
noncomputable def physSliceToDual (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (N : ℕ) :
    ↥(towerPhysSubmodule η a b (invTwo K * Fock.zeroModeSq η a)
        ⊓ towerBigrade D K (-(N : ℤ)) N) →ₗ[K] (↥(conjFreeSlice hD F N) →ₗ[K] K) :=
  LinearMap.domRestrict ((Fock.towerPairing η).compl₂ (conjFreeSlice hD F N).subtype) _

omit [CharZero K] in
@[simp]
lemma physSliceToDual_apply (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (N : ℕ)
    (x : ↥(towerPhysSubmodule η a b (invTwo K * Fock.zeroModeSq η a)
        ⊓ towerBigrade D K (-(N : ℤ)) N)) (c : ↥(conjFreeSlice hD F N)) :
    physSliceToDual hD F N x c
      = Fock.towerPairing η (x : TowerFock D K) (c : TowerFock D K) := rfl

/-- **(P3)** (blueprint §B′.4's `finrank_towerPhys_inf_towerBigrade_le`):

`dim (H_phys ⊓ V_N) ≤ p_{D−1}(N)`,

the right-hand side being the number of `b̃`-free level-`N` light-cone occupation functions.

The pairing against the `b̃`-free span embeds `H_phys ⊓ V_N` into the dual of that span, by the
previous lemma; the dual has the same dimension, and the span has at most `p_{D−1}(N)`
generators.

`D = 26` does not appear.  Together with `SliceDim.finrank_ddfSpan_inf_towerBigrade`
(`= p_{D−2}(N)`) this is the whole `D`-independent input of blueprint §B′.2; what is left is
(B-26), the statement that `H_null ⊓ V_N` makes up the difference. -/
theorem finrank_towerPhys_inf_towerBigrade_le (hD : 2 ≤ D) (F : DDFLightConeFrame η a b)
    (N : ℕ) :
    Module.finrank K ↥(towerPhysSubmodule η a b (invTwo K * Fock.zeroModeSq η a)
        ⊓ towerBigrade D K (-(N : ℤ)) N)
      ≤ Fintype.card {d : Osc D →₀ ℕ // Fock.level D d = N ∧ conjDeg hD d = 0} := by
  classical
  refine le_trans ?_ (finrank_conjFreeSlice_le hD F N)
  refine finrank_le_of_injective_toDualHom
    (V := ↥(towerPhysSubmodule η a b (invTwo K * Fock.zeroModeSq η a)
      ⊓ towerBigrade D K (-(N : ℤ)) N)) (conjFreeSlice hD F N)
    (f := physSliceToDual hD F N) ?_
  intro u v huv
  refine Subtype.ext (sub_eq_zero.mp ?_)
  have hmem : (u : TowerFock D K) - (v : TowerFock D K)
      ∈ towerPhysSubmodule η a b (invTwo K * Fock.zeroModeSq η a)
        ⊓ towerBigrade D K (-(N : ℤ)) N := Submodule.sub_mem _ u.2 v.2
  refine eq_zero_of_mem_towerPhys_inf_towerBigrade_of_orthogonal_conjFreeSlice hD F N hmem
    fun c hc => ?_
  have h1 := congrArg (fun g : ↥(conjFreeSlice hD F N) →ₗ[K] K => g ⟨c, hc⟩) huv
  simp only [physSliceToDual_apply] at h1
  have h2 : Fock.towerPairing η ((u : TowerFock D K) - (v : TowerFock D K)) c
      = Fock.towerPairing η (u : TowerFock D K) c
        - Fock.towerPairing η (v : TowerFock D K) c := by
    simp
  rw [h2]
  simpa using sub_eq_zero.mpr h1

end P3

end StringFormal.NoGhost
