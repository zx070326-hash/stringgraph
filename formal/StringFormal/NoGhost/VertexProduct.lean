/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.VertexCommute
import StringFormal.NoGhost.DDFOperator

/-!
# Same-point product of vertex operators with orthogonal momenta

Graph node: `worldsheet.ddf-transverse-oscillator-algebra`; `formal/TODO.md` item
`ddf-operators`, sub-item (5a).

Target: for `b · b' = 0`,
`∑_{J + K = L} V^{(b)}_J V^{(b')}_K = V^{(b+b')}_L`,
i.e. the two exponential vertex operators may be multiplied at the same point and the
result is the vertex operator of the summed momentum.  This is the input to (5b), the
weighted sum `∑_j j V^{(m)}_j V^{(n)}_{-j} = m δ_{m+n,0}` which *is* the DDF bracket.

## Status

Work in progress; this header records what is present.  No `sorry`.
-/

namespace StringFormal.NoGhost

open MvPolynomial

namespace Fock

/-! ### The annihilation half lowers the oscillator level

`Ψ^b_M = vertexAnn b M` is the `T^M` coefficient of the substitution
`X_{μ,l} ↦ X_{μ,l} - b^μ T^l`, so each power of `T` traded in comes from deleting one
creation generator: `Ψ^b_M` maps the level-`N` piece into the level-`(N - M)` piece and
kills it as soon as `M > N`.  This is the fact the naive level count for the same-point
product is missing: `V^{(b')}_K P` has level `levelBound P + K`, growing with `K`, but the
*annihilation half* `Ψ^{b'}_M P` stays below `levelBound P` uniformly in `M`. -/

section AnnLevel

variable {D : ℕ} {R : Type*} [CommRing R]

private lemma vertexAnn_monomial_aux (b : Fin D → R) :
    ∀ (N : ℕ) (d : Osc D →₀ ℕ), level D d = N → ∀ (c : R) (M : ℤ),
      (∀ N' : ℕ, (N' : ℤ) + M = (N : ℤ) →
        vertexAnn b M (monomial d c) ∈ levelSubmodule D R N')
      ∧ ((N : ℤ) < M → vertexAnn b M (monomial d c) = 0) := by
  classical
  intro N
  induction N using Nat.strong_induction_on with
  | _ N ih =>
    intro d hd c M
    rcases eq_or_ne d 0 with rfl | hdne
    · have hN : N = 0 := by rw [← hd, level_zero]
      subst hN
      have hmon : (monomial (0 : Osc D →₀ ℕ) c : Fock D R) = c • 1 := by
        rw [MvPolynomial.smul_eq_C_mul, mul_one, monomial_zero']
      rw [hmon, map_smul, vertexAnn_one]
      refine ⟨fun N' hN' => ?_, fun hM => ?_⟩
      · rcases eq_or_ne M 0 with rfl | hM0
        · rw [if_pos rfl]
          have : N' = 0 := by omega
          subst this
          exact Submodule.smul_mem _ _ (one_mem_levelSubmodule D R)
        · rw [if_neg hM0, smul_zero]
          exact Submodule.zero_mem _
      · rw [if_neg (by omega), smul_zero]
    · obtain ⟨v, hv⟩ := Finsupp.support_nonempty_iff.mpr hdne
      have hv' : d v ≠ 0 := Finsupp.mem_support_iff.mp hv
      have hsplit : Finsupp.single v 1 + (d - Finsupp.single v 1) = d :=
        single_add_tsub_single hv'
      set d' : Osc D →₀ ℕ := d - Finsupp.single v 1 with hd'def
      have hlev : ((v.2 : ℕ)) + level D d' = N := by
        conv_lhs => rw [show ((v.2 : ℕ)) = level D (Finsupp.single v 1) by
          rw [level_single]; simp [oscLevel]]
        rw [← level_add, hsplit, hd]
      have hmon : (monomial d c : Fock D R) = monomial d' c * X v := by
        conv_lhs => rw [← hsplit]
        rw [monomial_single_add, pow_one]
        ring
      have hvpos : 0 < ((v.2 : ℕ)) := v.2.pos
      have hlt : level D d' < N := by omega
      have ihd' := fun (M' : ℤ) => ih (level D d') hlt d' rfl c M'
      rw [hmon, vertexAnn_mul_X]
      constructor
      · intro N' hN'
        refine Submodule.sub_mem _ ?_ (Submodule.smul_mem _ _ ?_)
        · rcases le_or_gt M (level D d' : ℤ) with hle | hgt
          · obtain ⟨N'', hN''⟩ : ∃ N'' : ℕ, (N'' : ℤ) = (level D d' : ℤ) - M :=
              ⟨((level D d' : ℤ) - M).toNat, by omega⟩
            have hmem := (ihd' M).1 N'' (by omega)
            have hXv : (X v : Fock D R) ∈ levelSubmodule D R ((v.2 : ℕ)) :=
              isWeightedHomogeneous_X (R := R) (oscLevel D) v
            have heq : N'' + ((v.2 : ℕ)) = N' := by omega
            exact heq ▸ hmem.mul hXv
          · rw [(ihd' M).2 hgt, zero_mul]
            exact Submodule.zero_mem _
        · exact (ihd' (M - ((v.2 : ℕ) : ℤ))).1 N' (by omega)
      · intro hM
        rw [(ihd' M).2 (by omega), zero_mul,
          (ihd' (M - ((v.2 : ℕ) : ℤ))).2 (by omega), smul_zero, sub_zero]

/-- **`Ψ^b_M` maps the level-`N` piece into the level-`(N - M)` piece**: the annihilation
half of the vertex operator *lowers* the oscillator level by exactly `M`. -/
theorem vertexAnn_mem_levelSubmodule (b : Fin D → R) {N : ℕ} {P : Fock D R}
    (hP : P ∈ levelSubmodule D R N) {M : ℤ} {N' : ℕ} (hN' : (N' : ℤ) + M = (N : ℤ)) :
    vertexAnn b M P ∈ levelSubmodule D R N' := by
  classical
  have hPsum : vertexAnn b M P = ∑ d ∈ P.support, vertexAnn b M (monomial d (coeff d P)) := by
    conv_lhs => rw [P.as_sum]
    rw [map_sum]
  rw [hPsum]
  refine Submodule.sum_mem _ fun d hd => ?_
  have hlev : level D d = N := hP (mem_support_iff.mp hd)
  exact (vertexAnn_monomial_aux b N d hlev (coeff d P) M).1 N' hN'

/-- **`Ψ^b_M` annihilates the level-`N` piece as soon as `M > N`**: one cannot trade in more
powers of `T` than there are creation generators. -/
theorem vertexAnn_apply_eq_zero_of_level (b : Fin D → R) {N : ℕ} {P : Fock D R}
    (hP : P ∈ levelSubmodule D R N) {M : ℤ} (hM : (N : ℤ) < M) :
    vertexAnn b M P = 0 := by
  classical
  have hPsum : vertexAnn b M P = ∑ d ∈ P.support, vertexAnn b M (monomial d (coeff d P)) := by
    conv_lhs => rw [P.as_sum]
    rw [map_sum]
  rw [hPsum]
  refine Finset.sum_eq_zero fun d hd => ?_
  have hlev : level D d = N := hP (mem_support_iff.mp hd)
  exact (vertexAnn_monomial_aux b N d hlev (coeff d P) M).2 hM

/-- **The level bound never grows under the annihilation half**, uniformly in `M`.  This is
the missing input for the local finiteness of the same-point product: the naive estimate on
`V^{(b')}_K P` grows with `K`, but `Ψ^{b'}_M P` does not. -/
theorem levelBound_vertexAnn_le (b : Fin D → R) (M : ℤ) (P : Fock D R) :
    levelBound (vertexAnn b M P) ≤ levelBound P := by
  classical
  rcases lt_or_ge M 0 with hM0 | hM0
  · rw [vertexAnn_of_neg b hM0, LinearMap.zero_apply]
    simp [levelBound]
  refine Finset.sup_le fun d hd => ?_
  by_contra hcon
  rw [not_le] at hcon
  -- `P` splits into its levels; the piece of level `N ≤ levelBound P` contributes
  -- to level `N - M ≤ levelBound P`, so no monomial of level `> levelBound P` survives.
  have hzero : coeff d (vertexAnn b M P) = 0 := by
    have hPsum : vertexAnn b M P
        = ∑ e ∈ P.support, vertexAnn b M (monomial e (coeff e P)) := by
      conv_lhs => rw [P.as_sum]
      rw [map_sum]
    rw [hPsum, coeff_sum]
    refine Finset.sum_eq_zero fun e he => ?_
    have hle : level D e ≤ levelBound P := level_le_levelBound he
    rcases le_or_gt M (level D e : ℤ) with hM | hM
    · obtain ⟨N'', hN''⟩ : ∃ N'' : ℕ, (N'' : ℤ) + M = (level D e : ℤ) :=
        ⟨((level D e : ℤ) - M).toNat, by omega⟩
      have hmem := (vertexAnn_monomial_aux b (level D e) e rfl (coeff e P) M).1 N'' hN''
      by_contra hne
      have hcoeff : level D d = N'' := hmem hne
      omega
    · rw [(vertexAnn_monomial_aux b (level D e) e rfl (coeff e P) M).2 hM, coeff_zero]
  exact (mem_support_iff.mp hd) hzero

end AnnLevel

/-! ### Local finiteness of the same-point product

For fixed `P` and `L` only finitely many `K` contribute to `Σ_{J+K=L} V^{(b)}_J V^{(b')}_K P`.
The lower end is the usual level bound on `V^{(b')}_K P`.  The **upper end genuinely needs
`b · b' = 0`**: the naive estimate is useless because `V^{(b')}_K P` sits at level
`levelBound P + K`, which grows with `K`, so `V^{(b)}_{L-K}` never gets a chance to kill it.
Orthogonality lets one pull the coherent-state factors `Φ^{b'}_{K+M}` of `V^{(b')}_K P` out
to the left past `V^{(b)}_{L-K}` (`Fock.vertexOsc_creaExp_mul_of_dotVec_zero`); what is left
inside is `Ψ^{b'}_M P`, whose level bound does *not* grow with `K`
(`Fock.levelBound_vertexAnn_le`). -/

section Window

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

omit [Algebra ℚ R] in
@[simp]
lemma levelBound_one : levelBound (1 : Fock D R) = 0 := by
  classical
  refine Nat.le_zero.mp (Finset.sup_le fun d hd => ?_)
  have hd0 : d = 0 := by
    by_contra hne
    rw [mem_support_iff, coeff_one, if_neg (Ne.symm hne)] at hd
    exact hd rfl
  rw [hd0, level_zero]

/-- **Lower end of the window**: `V^{(b')}_K` already kills `P` once `K` is below minus the
level bound.  No hypothesis on the momenta. -/
theorem vertexOsc_vertexOsc_apply_eq_zero_of_lt (η b b' : Fin D → R) {J K : ℤ} {P : Fock D R}
    (hK : (levelBound P : ℤ) + K < 0) :
    vertexOsc η b J (vertexOsc η b' K P) = 0 := by
  rw [vertexOsc_apply_eq_zero_of_levelBound_lt η b' hK, map_zero]

/-- **Upper end of the window, and the whole point of orthogonality**: for `b · b' = 0` the
composite `V^{(b)}_J V^{(b')}_K` vanishes on `P` as soon as `J` is below minus the level
bound of `P`, *uniformly in `K`*.  Without `b · b' = 0` this is false: the contraction
`E_+(b) E_-(b')` produces the factor `exp((b·b') Σ_l (w/z)^l / l)`, which mixes all Laurent
indices and destroys the uniform bound. -/
theorem vertexOsc_vertexOsc_apply_eq_zero_of_gt (η b b' : Fin D → R)
    (hdot : dotVec η b' b = 0) {J : ℤ} (K : ℤ) {P : Fock D R}
    (hJ : (levelBound P : ℤ) + J < 0) :
    vertexOsc η b J (vertexOsc η b' K P) = 0 := by
  classical
  rw [vertexOsc_apply η b' K P
      (fun L hL => vertexAnn_apply_eq_zero_of_notMem_vertexIdx b' P hL), map_sum]
  refine Finset.sum_eq_zero fun M _ => ?_
  rw [vertexOsc_creaExp_mul_of_dotVec_zero η b b' hdot (K + M) J (vertexAnn b' M P)]
  have hle : (levelBound (vertexAnn b' M P) : ℤ) ≤ (levelBound P : ℤ) := by
    exact_mod_cast levelBound_vertexAnn_le b' M P
  rw [vertexOsc_apply_eq_zero_of_levelBound_lt η b (P := vertexAnn b' M P) (K := J) (by omega),
    mul_zero]

/-- The finite window `-levelBound P ≤ K ≤ L + levelBound P` of the same-point product. -/
noncomputable def vertexProdIdx (L : ℤ) (P : Fock D R) : Finset ℤ :=
  Finset.Icc (-(levelBound P : ℤ)) (L + (levelBound P : ℤ))

theorem vertexOsc_vertexOsc_apply_eq_zero_of_notMem_vertexProdIdx (η b b' : Fin D → R)
    (hdot : dotVec η b' b = 0) (L : ℤ) (P : Fock D R) {K : ℤ} (hK : K ∉ vertexProdIdx L P) :
    vertexOsc η b (L - K) (vertexOsc η b' K P) = 0 := by
  simp only [vertexProdIdx, Finset.mem_Icc, not_and, not_le] at hK
  rcases lt_or_ge K (-(levelBound P : ℤ)) with h | h
  · exact vertexOsc_vertexOsc_apply_eq_zero_of_lt η b b' (by omega)
  · exact vertexOsc_vertexOsc_apply_eq_zero_of_gt η b b' hdot K
      (by have := hK (by omega); omega)

end Window

/-! ### The same-point product

`W_L := Σ_{J+K=L} V^{(b)}_J V^{(b')}_K` is well defined by the previous section.  Both `W_L`
and `V^{(b+b')}_L` satisfy the creation-mode recursion of `Fock.vertexOsc_unique` for the
momentum `b + b'`: each `V` shifts its own Laurent index, and after re-indexing one of the
two correction sums the two shifts merge into `W_{L+n}` with coefficient `b + b'`.  On the
vacuum `W_L` is the convolution `Σ_{p+q=L} Φ^b_p Φ^{b'}_q`, which is
`Fock.creaExpPair_eq_creaExp_add`.  Hence `W_L = V^{(b+b')}_L`. -/

section Product

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

/-- Re-indexing a locally finite sum over `ℤ` by a shift.  Both index sets must contain the
support window `w`; then the shifted and unshifted sums agree. -/
private lemma sum_add_right_eq_sum {M₀ : Type*} [AddCommMonoid M₀] (g : ℤ → M₀) (n : ℤ)
    (s w : Finset ℤ) (hg : ∀ K ∉ w, g K = 0) (hws : w ⊆ s) (hwsn : ∀ K ∈ w, K - n ∈ s) :
    ∑ K ∈ s, g (K + n) = ∑ K ∈ s, g K := by
  classical
  have hinj : ∀ x ∈ w, ∀ y ∈ w, x - n = y - n → x = y := fun x _ y _ h => by omega
  have hsub : w.image (fun x => x - n) ⊆ s := by
    intro K hK
    rw [Finset.mem_image] at hK
    obtain ⟨K₀, hK₀, rfl⟩ := hK
    exact hwsn K₀ hK₀
  have h1 : ∑ K ∈ s, g (K + n) = ∑ K ∈ w.image (fun x => x - n), g (K + n) := by
    refine (Finset.sum_subset hsub ?_).symm
    intro K _ hK
    refine hg _ fun hmem => hK ?_
    rw [Finset.mem_image]
    exact ⟨K + n, hmem, by omega⟩
  have h2 : ∑ K ∈ w.image (fun x => x - n), g (K + n) = ∑ K ∈ w, g K := by
    rw [Finset.sum_image hinj]
    exact Finset.sum_congr rfl fun K _ => by rw [sub_add_cancel]
  have h3 : ∑ K ∈ s, g K = ∑ K ∈ w, g K :=
    (Finset.sum_subset hws fun K _ hK => hg K hK).symm
  rw [h1, h2, h3]

/-- **The same-point product of two vertex operators with orthogonal momenta**,
`W_L = Σ_{J+K=L} V^{(b)}_J V^{(b')}_K`, assembled as a locally finite sum over `K`.  The
hypothesis `b · b' = 0` is what makes the sum locally finite
(`Fock.vertexOsc_vertexOsc_apply_eq_zero_of_gt`). -/
noncomputable def vertexProduct (η b b' : Fin D → R) (hdot : dotVec η b' b = 0) (L : ℤ) :
    Module.End R (Fock D R) :=
  lsumLocFin (fun K : ℤ => vertexOsc η b (L - K) ∘ₗ vertexOsc η b' K) (vertexProdIdx L)
    (fun P K hK => by
      rw [LinearMap.comp_apply]
      exact vertexOsc_vertexOsc_apply_eq_zero_of_notMem_vertexProdIdx η b b' hdot L P hK)

/-- `vertexProduct` is computed by *any* finite index set containing the window. -/
theorem vertexProduct_apply (η b b' : Fin D → R) (hdot : dotVec η b' b = 0) (L : ℤ)
    (P : Fock D R) {s : Finset ℤ}
    (hs : ∀ K : ℤ, -(levelBound P : ℤ) ≤ K → K ≤ L + (levelBound P : ℤ) → K ∈ s) :
    vertexProduct η b b' hdot L P
      = ∑ K ∈ s, vertexOsc η b (L - K) (vertexOsc η b' K P) := by
  classical
  rw [vertexProduct, lsumLocFin_apply _ _ _ P (s := s) (fun K hK => by
    rw [LinearMap.comp_apply]
    refine vertexOsc_vertexOsc_apply_eq_zero_of_notMem_vertexProdIdx η b b' hdot L P ?_
    intro hmem
    rw [vertexProdIdx, Finset.mem_Icc] at hmem
    exact hK (hs K hmem.1 hmem.2))]
  exact Finset.sum_congr rfl fun K _ => by rw [LinearMap.comp_apply]

/-- **The vacuum value of the same-point product is the convolution of the two coherent-state
coefficients**, i.e. `Φ^{b+b'}_L` by `Fock.creaExpPair_eq_creaExp_add`. -/
theorem vertexProduct_apply_one (η b b' : Fin D → R) (hdot : dotVec η b' b = 0) (L : ℤ) :
    vertexProduct η b b' hdot L (1 : Fock D R) = creaExp η (b + b') L := by
  classical
  rw [vertexProduct_apply η b b' hdot L 1 (s := Finset.Icc (0 : ℤ) L)
      (fun K h1 h2 => by
        rw [levelBound_one] at h1 h2
        rw [Finset.mem_Icc]
        omega)]
  have hterm : ∀ K ∈ Finset.Icc (0 : ℤ) L,
      vertexOsc η b (L - K) (vertexOsc η b' K (1 : Fock D R))
        = creaExp η b' K * creaExp η b (L - K) := by
    intro K _
    rw [vertexOsc_apply_one, vertexOsc_apply_creaExp_of_dotVec_zero η b b' hdot (L - K) K,
      mul_comm]
  rw [Finset.sum_congr rfl hterm,
    creaExpPair_eq_sum_Icc η b' b (le_refl (0 : ℤ)) (le_refl L),
    creaExpPair_eq_creaExp_add η b' b L, add_comm b' b]

/-- **The creation-mode recursion for the same-point product**, with the momentum `b + b'`:
`V^{(b)}` shifts the index of the left factor and `V^{(b')}` that of the right factor, and
after re-indexing the second correction sum both become `W_{L+n}`, so the two coefficients
`b^μ` and `b'^μ` add. -/
theorem vertexProduct_X_mul (η b b' : Fin D → R) (hdot : dotVec η b' b = 0) (v : Osc D)
    (L : ℤ) (P : Fock D R) :
    vertexProduct η b b' hdot L (X v * P)
      = X v * vertexProduct η b b' hdot L P
        - (b + b') v.1 • vertexProduct η b b' hdot (L + ((v.2 : ℕ) : ℤ)) P := by
  classical
  set n : ℤ := ((v.2 : ℕ) : ℤ) with hndef
  have hnpos : 0 < n := by rw [hndef]; exact_mod_cast v.2.pos
  set Mx : ℕ := max (levelBound P) (levelBound (X v * P)) with hMxdef
  have hM1 : (levelBound P : ℤ) ≤ (Mx : ℤ) := by exact_mod_cast le_max_left _ _
  have hM2 : (levelBound (X v * P) : ℤ) ≤ (Mx : ℤ) := by exact_mod_cast le_max_right _ _
  set s : Finset ℤ := Finset.Icc (-(Mx : ℤ) - n) (L + n + (Mx : ℤ) + n) with hsdef
  have hsmem : ∀ K : ℤ, -(Mx : ℤ) - n ≤ K → K ≤ L + n + (Mx : ℤ) + n → K ∈ s := by
    intro K h1 h2
    rw [hsdef, Finset.mem_Icc]
    exact ⟨h1, h2⟩
  have hg : ∀ K ∉ vertexProdIdx (L + n) P,
      vertexOsc η b (L + n - K) (vertexOsc η b' K P) = 0 := fun K hK =>
    vertexOsc_vertexOsc_apply_eq_zero_of_notMem_vertexProdIdx η b b' hdot (L + n) P hK
  have hsub : vertexProdIdx (L + n) P ⊆ s := by
    intro K hK
    rw [vertexProdIdx, Finset.mem_Icc] at hK
    exact hsmem K (by omega) (by omega)
  have hsub2 : ∀ K ∈ vertexProdIdx (L + n) P, K - n ∈ s := by
    intro K hK
    rw [vertexProdIdx, Finset.mem_Icc] at hK
    exact hsmem (K - n) (by omega) (by omega)
  have hshift0 := sum_add_right_eq_sum
    (fun J : ℤ => vertexOsc η b (L + n - J) (vertexOsc η b' J P)) n s
    (vertexProdIdx (L + n) P) hg hsub hsub2
  have hshift : ∑ K ∈ s, vertexOsc η b (L - K) (vertexOsc η b' (K + n) P)
      = ∑ K ∈ s, vertexOsc η b (L + n - K) (vertexOsc η b' K P) := by
    rw [← hshift0]
    refine Finset.sum_congr rfl fun K _ => ?_
    show vertexOsc η b (L - K) (vertexOsc η b' (K + n) P)
      = vertexOsc η b (L + n - (K + n)) (vertexOsc η b' (K + n) P)
    rw [show L + n - (K + n) = L - K from by ring]
  have hterm : ∀ K : ℤ, vertexOsc η b (L - K) (vertexOsc η b' K (X v * P))
      = X v * vertexOsc η b (L - K) (vertexOsc η b' K P)
        - b v.1 • vertexOsc η b (L + n - K) (vertexOsc η b' K P)
        - b' v.1 • vertexOsc η b (L - K) (vertexOsc η b' (K + n) P) := by
    intro K
    rw [vertexOsc_X_mul η b' v K P, map_sub, map_smul, vertexOsc_X_mul η b v (L - K) _,
      show L - K + n = L + n - K from by ring]
  rw [vertexProduct_apply η b b' hdot L (X v * P) (s := s)
      (fun K h1 h2 => hsmem K (by omega) (by omega)),
    vertexProduct_apply η b b' hdot L P (s := s)
      (fun K h1 h2 => hsmem K (by omega) (by omega)),
    vertexProduct_apply η b b' hdot (L + n) P (s := s)
      (fun K h1 h2 => hsmem K (by omega) (by omega))]
  simp only [hterm]
  rw [Finset.sum_sub_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum, ← Finset.smul_sum,
    ← Finset.smul_sum, hshift, Pi.add_apply, add_smul]
  abel

/-- **The same-point product of two vertex operators with orthogonal momenta is the vertex
operator of the summed momentum**: for `b · b' = 0`,
`Σ_{J+K=L} V^{(b)}_J V^{(b')}_K = V^{(b+b')}_L`.

This is step (5a) of the DDF transverse algebra.  Orthogonality is used twice and in an
essential way: once for the local finiteness of the sum
(`Fock.vertexOsc_vertexOsc_apply_eq_zero_of_gt`), once for the vacuum value.  The creation
halves would multiply correctly for *any* pair of momenta
(`Fock.creaExpPair_eq_creaExp_add`); it is the annihilation half that contracts. -/
theorem vertexProduct_eq_vertexOsc_add (η b b' : Fin D → R) (hdot : dotVec η b' b = 0)
    (L : ℤ) : vertexProduct η b b' hdot L = vertexOsc η (b + b') L :=
  vertexOsc_unique η (b + b') (vertexProduct η b b' hdot)
    (fun v J P => vertexProduct_X_mul η b b' hdot v J P)
    (fun J => vertexProduct_apply_one η b b' hdot J) L

/-- The same statement as an identity between honest finite sums: **any** index set
containing the window `-levelBound P ≤ K ≤ L + levelBound P` computes
`Σ_{J+K=L} V^{(b)}_J V^{(b')}_K P = V^{(b+b')}_L P`. -/
theorem sum_vertexOsc_vertexOsc_of_dotVec_zero (η b b' : Fin D → R)
    (hdot : dotVec η b' b = 0) (L : ℤ) (P : Fock D R) {s : Finset ℤ}
    (hs : ∀ K : ℤ, -(levelBound P : ℤ) ≤ K → K ≤ L + (levelBound P : ℤ) → K ∈ s) :
    ∑ K ∈ s, vertexOsc η b (L - K) (vertexOsc η b' K P) = vertexOsc η (b + b') L P := by
  rw [← vertexProduct_apply η b b' hdot L P hs, vertexProduct_eq_vertexOsc_add η b b' hdot L]

end Product

end Fock

end StringFormal.NoGhost
