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

end StringFormal.NoGhost
