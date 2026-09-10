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

end Fock

end StringFormal.NoGhost
