/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/

import StringFormal.NoGhost.DDF

/-!
# 顶点算子的共形权

对应图节点：`worldsheet.ddf-operators`（`formal/TODO.md` 项 `ddf-operators` 的 (3)）。

约定：与 `NoGhost/VertexOperator.lean`、`NoGhost/Sugawara.lean` 相同。

## 本文件已证

* `Fock.creaExp_euler` — 产生指数
  `E_-(z) = exp(Σ_{l ≥ 1} (η_μ b^μ / l) α^μ_{-l} z^l) = Σ_{M ≥ 0} Φ_M z^M`
  满足欧拉型（`z ∂_z`）递推
  `M · Φ_M = Σ_{l = 1}^{M} Σ_μ η_μ b^μ · α^μ_{-l} Φ_{M-l}`，
  其中 `Φ_M = creaExp η b M`、`α^μ_{-l} = creation R μ l`。
  证明在 `coeff` 层面：把两边在单项式 `X^d` 上展开，用
  `Fock.expWeight_add_single`（指数权的一步递推）与 `MvPolynomial.coeff_X_mul'`。

辅助引理：`Fock.level_sub_single_add`、`Fock.expWeight_sub_single`。

## 尚缺（本文件的最终目标尚未开始）

* `[L_m, V_J]` 的共形权公式。它需要把上面的递推与 `NoGhost/Sugawara.lean` 的
  `Lop` 以及 `NoGhost/VertexOperator.lean` 的 `vertexOsc` 结合；本轮未做。
* 因此本文件目前**不**支撑图上任何 `formalized` 的推导；`Fock.creaExp_euler`
  本身只是将来共形权推导的一步引理。
-/

namespace StringFormal.NoGhost

open MvPolynomial

namespace Fock

variable {D : ℕ} {R : Type*} [CommRing R]

/-- Deleting one factor `X v` from a monomial drops its level by the mode number of `v`. -/
lemma level_sub_single_add (d : Osc D →₀ ℕ) {v : Osc D} (hv : d v ≠ 0) :
    level D (d - Finsupp.single v 1) + ((v.2 : ℕ)) = level D d := by
  classical
  conv_rhs => rw [← Finsupp.sub_add_single_one_cancel hv]
  rw [level_add, level_single]
  simp [oscLevel]

section CreaExp

variable [Algebra ℚ R]

/-- The one-step recursion for the exponential weights, in the "delete one oscillator" form:
`η_μ b^μ · w(d - v) = n(v) · d(v) · w(d)` for `v = (μ, n)` occurring in `d`. -/
lemma expWeight_sub_single (η b : Fin D → R) (d : Osc D →₀ ℕ) {v : Osc D} (hv : d v ≠ 0) :
    (η v.1 * b v.1) * expWeight η b (d - Finsupp.single v 1)
      = ((v.2 : ℕ) : R) * (((d v : ℕ) : R) * expWeight η b d) := by
  classical
  have hde : (d - Finsupp.single v 1) + Finsupp.single v 1 = d :=
    Finsupp.sub_add_single_one_cancel hv
  have h1 : (d - Finsupp.single v 1 : Osc D →₀ ℕ) v + 1 = d v := by
    have h := Finsupp.add_apply (d - Finsupp.single v 1) (Finsupp.single v 1) v
    rw [hde] at h
    simpa using h.symm
  have hev : (((d - Finsupp.single v 1 : Osc D →₀ ℕ) v : ℕ) : R) + 1 = ((d v : ℕ) : R) := by
    exact_mod_cast congrArg (fun n : ℕ => (n : R)) h1
  have h := expWeight_add_single η b (d - Finsupp.single v 1) v
  rw [hde, hev] at h
  have hm : (((v.2 : ℕ)) : R) * invNat R ((v.2 : ℕ)) = 1 := natCast_mul_invNat v.2.ne_zero
  calc (η v.1 * b v.1) * expWeight η b (d - Finsupp.single v 1)
      = (((v.2 : ℕ) : R) * invNat R ((v.2 : ℕ)))
          * ((η v.1 * b v.1) * expWeight η b (d - Finsupp.single v 1)) := by
        rw [hm, one_mul]
    _ = ((v.2 : ℕ) : R)
          * ((η v.1 * b v.1 * invNat R ((v.2 : ℕ))) * expWeight η b (d - Finsupp.single v 1)) := by
        ring
    _ = ((v.2 : ℕ) : R) * (expWeight η b d * ((d v : ℕ) : R)) := by rw [← h]
    _ = ((v.2 : ℕ) : R) * (((d v : ℕ) : R) * expWeight η b d) := by ring

/-- **Euler recursion for the creation exponential.**  Writing
`E_-(z) = Σ_M Φ_M z^M` with `Φ_M = creaExp η b M`, the identity
`z ∂_z E_- = (Σ_μ η_μ b^μ Σ_{l ≥ 1} α^μ_{-l} z^l) E_-` reads, on the `z^M` coefficient,
`M · Φ_M = Σ_{l=1}^{M} Σ_μ η_μ b^μ α^μ_{-l} Φ_{M-l}`.  Here the summation index `l` of the
statement is `l+1` for `l ∈ Finset.range M`, so that it runs over `1, …, M`. -/
theorem creaExp_euler (η b : Fin D → R) (M : ℕ) :
    (M : R) • creaExp η b (M : ℤ)
      = ∑ l ∈ Finset.range M, ∑ μ : Fin D,
          (η μ * b μ) • creation R μ l.succPNat (creaExp η b ((M : ℤ) - ((l : ℤ) + 1))) := by
  classical
  refine MvPolynomial.ext _ _ fun d => ?_
  obtain ⟨f, hf⟩ : ∃ f : Osc D → R, ∀ v : Osc D,
      f v = (η v.1 * b v.1) * coeff d (X v * creaExp η b ((M : ℤ) - ((v.2 : ℕ) : ℤ))) :=
    ⟨_, fun _ => rfl⟩
  have hRHS : coeff d (∑ l ∈ Finset.range M, ∑ μ : Fin D,
      (η μ * b μ) • creation R μ l.succPNat (creaExp η b ((M : ℤ) - ((l : ℤ) + 1))))
      = ∑ l ∈ Finset.range M, ∑ μ : Fin D, f (μ, l.succPNat) := by
    rw [coeff_sum]
    refine Finset.sum_congr rfl fun l _ => ?_
    rw [coeff_sum]
    refine Finset.sum_congr rfl fun μ _ => ?_
    have hcast : (M : ℤ) - ((l : ℤ) + 1) = (M : ℤ) - (((l.succPNat : ℕ+) : ℕ) : ℤ) := by
      simp only [Nat.succPNat_coe]
      push_cast
      ring
    rw [coeff_smul, smul_eq_mul, creation_apply, hcast, hf]
  rw [hRHS, coeff_smul, smul_eq_mul, coeff_creaExp]
  by_cases hlev : ((level D d : ℤ)) = (M : ℤ)
  · rw [if_pos hlev]
    have hlevN : level D d = M := by exact_mod_cast hlev
    have hsub : d.support ⊆
        (Finset.univ : Finset (Fin D)) ×ˢ ((Finset.range M).image Nat.succPNat) := by
      intro v hv
      rw [Finset.mem_product]
      refine ⟨Finset.mem_univ _, ?_⟩
      rw [Finset.mem_image]
      refine ⟨(v.2 : ℕ) - 1, ?_, ?_⟩
      · rw [Finset.mem_range]
        have hmode := mode_le_of_mem_support_of_level_eq hlevN hv
        have hpos := v.2.ne_zero
        omega
      · exact PNat.succPNat_natPred v.2
    have hswap : ∑ l ∈ Finset.range M, ∑ μ : Fin D, f (μ, l.succPNat)
        = ∑ v ∈ (Finset.univ : Finset (Fin D)) ×ˢ ((Finset.range M).image Nat.succPNat), f v := by
      rw [Finset.sum_product,
        Finset.sum_comm (s := Finset.range M) (t := (Finset.univ : Finset (Fin D)))]
      refine Finset.sum_congr rfl fun μ _ => ?_
      exact (Finset.sum_image (f := fun m : ℕ+ => f (μ, m)) (g := Nat.succPNat)
        (s := Finset.range M) (fun x _ y _ h => Nat.succPNat_injective h)).symm
    have hrestrict : ∑ v ∈ d.support, f v
        = ∑ v ∈ (Finset.univ : Finset (Fin D)) ×ˢ ((Finset.range M).image Nat.succPNat), f v := by
      refine Finset.sum_subset hsub fun v _ hv => ?_
      rw [hf, coeff_X_mul', if_neg hv, mul_zero]
    have hval : ∀ v ∈ d.support, f v = ((v.2 : ℕ) : R) * (((d v : ℕ) : R) * expWeight η b d) := by
      intro v hv
      have hdv : d v ≠ 0 := Finsupp.mem_support_iff.mp hv
      have hcond : ((level D (d - Finsupp.single v 1) : ℤ)) = (M : ℤ) - ((v.2 : ℕ) : ℤ) := by
        have hstep := level_sub_single_add d hdv
        omega
      rw [hf, coeff_X_mul', if_pos hv, coeff_creaExp, if_pos hcond]
      exact expWeight_sub_single η b d hdv
    have hlevel : (M : R) = ∑ v ∈ d.support, ((v.2 : ℕ) : R) * ((d v : ℕ) : R) := by
      have h1 : level D d = ∑ v ∈ d.support, d v * ((v.2 : ℕ)) := by
        rw [level_apply, Finsupp.sum]
        rfl
      rw [← hlevN, h1]
      push_cast
      exact Finset.sum_congr rfl fun v _ => by ring
    calc (M : R) * expWeight η b d
        = (∑ v ∈ d.support, ((v.2 : ℕ) : R) * ((d v : ℕ) : R)) * expWeight η b d := by
          rw [← hlevel]
      _ = ∑ v ∈ d.support, ((v.2 : ℕ) : R) * (((d v : ℕ) : R) * expWeight η b d) := by
          rw [Finset.sum_mul]
          exact Finset.sum_congr rfl fun v _ => by ring
      _ = ∑ v ∈ d.support, f v := (Finset.sum_congr rfl hval).symm
      _ = ∑ v ∈ (Finset.univ : Finset (Fin D)) ×ˢ ((Finset.range M).image Nat.succPNat), f v :=
          hrestrict
      _ = ∑ l ∈ Finset.range M, ∑ μ : Fin D, f (μ, l.succPNat) := hswap.symm
  · rw [if_neg hlev, mul_zero]
    refine (Finset.sum_eq_zero fun l _ => Finset.sum_eq_zero fun μ _ => ?_).symm
    rw [hf, coeff_X_mul']
    by_cases hv : ((μ, l.succPNat) : Osc D) ∈ d.support
    · have hdv : d ((μ, l.succPNat) : Osc D) ≠ 0 := Finsupp.mem_support_iff.mp hv
      have hstep := level_sub_single_add d hdv
      have hcond : ¬ ((level D (d - Finsupp.single ((μ, l.succPNat) : Osc D) 1) : ℤ))
          = (M : ℤ) - (((((μ, l.succPNat) : Osc D).2 : ℕ)) : ℤ) := by
        omega
      rw [if_pos hv, coeff_creaExp, if_neg hcond, mul_zero]
    · rw [if_neg hv, mul_zero]

end CreaExp

end Fock

end StringFormal.NoGhost
