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

* `Fock.Lop_apply_creaExp_of_pos` — 真空上正模 Virasoro 生成元在相干态系数上的作用：
  对 `m ≥ 1`、任意 `J : ℤ`，
  `L_m Φ_J = (a · b + ½ (m - 1) (b · b) + (J - m)) · Φ_{J-m}`，
  其中 `a · b = Σ_μ η_μ a^μ b^μ`、`b · b = Σ_μ η_μ b^μ b^μ`，`a^μ = α^μ_0` 是零模标量。
  证明把 Sugawara 和 `L_m = ½ Σ_j :α_{m-j} · α_j:` 的求和指标分成五段
  （`j ≤ -1`、`j = 0`、`1 ≤ j ≤ m-1`、`j = m`、`j ≥ m+1`），两条产生尾用
  `Fock.sum_mode_creaExp_eq_smul`（`creaExp_euler` 的 `mode` 形式）求和。
* `Fock.Lop_apply_creaExp_of_pos_shifted` — 把零模参数换成 `a + b`（顶点算子移动动量）后的
  同一等式：`L_m^{(a+b)} Φ_J = (J - m + a·b + ½ (m+1) (b·b)) Φ_{J-m}`。这正是共形权恒等式
  `L_m^{(a+b)} V_J - V_J L_m^{(a)} = (J + a·b - m + (m+1)·½ b·b) V_{J-m}` 在真空上的特例
  （用 `V_J|k⟩ = Φ_J` 与 `m ≥ 1` 时 `L_m^{(a)}|k⟩ = 0`），与 `formal/TODO.md` (3) 记录的
  文献形式逐项相符；权 `h = ½ (b·b) = α' k_0²`，DDF 归一化 `k_0² = 0` 使其为零。
* `Fock.Lop_zero_apply_creaExp` — `m = 0` 的情形 `L_0 Φ_J = (α'k² + J) Φ_J`。它**不是**上式在
  `m = 0` 的特例：`m ≥ 1` 时 `j = 0` 与 `j = m` 是两项、各出 `½ (a·b)`，`m = 0` 时二者并成
  一项 `½ :α_0·α_0: = ½ (a·a)`，且中间段为空。把 `m = 0` 代入上式会得到错误的
  `a·b - ½ (b·b) + J`。因为 `Φ_J` 是 level `J` 的齐次元，这一条直接由
  `Fock.Lop_zero_apply_of_mem_levelSubmodule`（`L_0 = α'k² + N`）得到。
* `Fock.Lop_one_apply_creaExp_one` / `Fock.Lop_one_apply_creaExp_one_via_mode` —
  `m = J = 1` 的两条独立计算（Sugawara 求和 vs. 对易子 `Fock.Lop_apply_mode_one`），
  给出同一答案 `(a · b) |k⟩`，用来交叉验证上面的常数。

辅助引理：`Fock.level_sub_single_add`、`Fock.expWeight_sub_single`、`Fock.sum_Ioc_split`、
`Fock.mode_creaExp_of_pos`、`Fock.nordPair_creaExp_of_pos_pos`、
`Fock.nordPair_creaExp_of_neg_pos`、`Fock.nordPair_creaExp_zero_pos`、
`Fock.sum_mode_creaExp_eq_smul`。

## 尚缺（本文件的最终目标尚未完成）

* `m < 0`。这不只是"分段计算换个写法"：`m < 0` 时 `L_m^{(a)}|k⟩ ≠ 0`，所以真空上的等式
  **不再**形如 `L_m Φ_J = c · Φ_{J-m}`——共形权恒等式右边多出 `V_J L_m^{(a)}|k⟩` 一项，
  它是真正含产生算子的向量。要处理 `m < 0` 必须把 `vertexOsc`（而不只是 `creaExp`）
  一起搬过来。本轮未做。
* `[L_m, V_K]` 的共形权公式。上面只是**真空上**的作用；一般态上的对易子还要把
  `NoGhost/VertexOperator.lean` 的 `vertexOsc`（湮灭半 `vertexAnn`）一起搬过来。
* 因此本文件目前**不**支撑图上任何 `formalized` 的推导；以上都是将来共形权推导的中间步。
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

/-! ### The action of `L_m` on the coherent-state coefficients (`m ≥ 1`)

Pen-and-paper computation, recorded here before it is formalised below.

Write `Φ_J = creaExp η b J` for the `z^J` coefficient of
`E_-(z) = exp(Σ_{l ≥ 1} (η_μ b^μ / l) α^μ_{-l} z^l)`, and abbreviate the `η`-contractions
`a · b = Σ_μ η_μ a^μ b^μ`, `b · b = Σ_μ η_μ b^μ b^μ`.  For `m ≥ 1` the Sugawara sum
`L_m = ½ Σ_{j ∈ ℤ} :α_{m-j} · α_j:` splits into four regions of the summation index `j`:

* `1 ≤ j ≤ m - 1` — both `α_{m-j}` and `α_j` annihilate, each contributing a factor `b`;
  the `m - 1` such terms give `½ (m - 1) (b · b) Φ_{J-m}`;
* `j = 0` and `j = m` — one `α_0 = a` and one annihilator, giving `2 · ½ (a · b) Φ_{J-m}`;
* `j ≤ -1` and `j ≥ m + 1` — one creation operator `α_{-l}` (`l ≥ 1`) and one annihilator
  `α_{m+l}`; both families give `Σ_{l ≥ 1} Σ_μ η_μ b^μ α^μ_{-l} Φ_{(J-m)-l}`, which by the
  Euler recursion `creaExp_euler` is `(J - m) Φ_{J-m}`; together `2 · ½ (J - m) Φ_{J-m}`.

Hence, for every `m ≥ 1` and every `J ∈ ℤ` (both sides vanish when `J < m`):

`L_m Φ_J = (a · b + ½ (m - 1) (b · b) + (J - m)) · Φ_{J-m}`.

Checks: `m = 1, J = 1` gives `L_1 (η_μ b^μ α^μ_{-1}|k⟩) = (a · b) |k⟩`, matching
`Sugawara.Lop_apply_mode_one`; `m = 2, J = 2` gives `a · b + ½ b · b`, the value obtained by
commuting `L_2` twice past `Σ_μ η_μ b^μ α^μ_{-1}`.

The `m = 0` and `m < 0` cases are *not* covered by the computation above (for `m = 0` the two
terms `j = 0` and `j = m` coincide, and for `m < 0` the middle region is replaced by a
double-creation region); they are left for a later step.
-/

section LopCreaExp

variable [Algebra ℚ R]

/-- Splitting a `Finset.Ioc` of integers at an intermediate point. -/
lemma sum_Ioc_split {M : Type*} [AddCommMonoid M] (f : ℤ → M) {p q r : ℤ}
    (hpq : p ≤ q) (hqr : q ≤ r) :
    ∑ j ∈ Finset.Ioc p q, f j + ∑ j ∈ Finset.Ioc q r, f j = ∑ j ∈ Finset.Ioc p r, f j := by
  classical
  rw [← Finset.Ioc_union_Ioc_eq_Ioc hpq hqr, Finset.sum_union]
  exact Finset.disjoint_left.mpr fun x hx hx' => by
    simp only [Finset.mem_Ioc] at hx hx'
    omega

/-- A positive mode acts on `Φ_J` by lowering the index and multiplying by `b^μ`.  This is
`Fock.annihilation_creaExp` rewritten in terms of `Fock.mode`. -/
lemma mode_creaExp_of_pos (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (μ : Fin D)
    {p : ℤ} (hp : 0 < p) (J : ℤ) :
    mode η a μ p (creaExp η b J) = b μ • creaExp η b (J - p) := by
  have hcoe : (((p.toNat.toPNat' : ℕ+) : ℕ) : ℤ) = p := by
    rw [toPNat'_coe_of_pos hp]; omega
  rw [mode_of_pos η a hp, annihilation_creaExp η b hη, hcoe]

/-- Two annihilation modes on `Φ_J`: `:α_i · α_j: Φ_J = (b · b) Φ_{J-i-j}` for `i, j ≥ 1`. -/
lemma nordPair_creaExp_of_pos_pos (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    {i j : ℤ} (hi : 0 < i) (hj : 0 < j) (J : ℤ) :
    nordPair η a i j (creaExp η b J)
      = (∑ μ : Fin D, η μ * b μ * b μ) • creaExp η b (J - i - j) := by
  have key : ∀ i' j' : ℤ, 0 < i' → 0 < j' → i' ≤ j' →
      nordPair η a i' j' (creaExp η b J)
        = (∑ μ : Fin D, η μ * b μ * b μ) • creaExp η b (J - i' - j') := by
    intro i' j' hi' hj' hij
    rw [nordPair_apply_of_le η a hij, Finset.sum_smul]
    refine Finset.sum_congr rfl fun μ _ => ?_
    rw [mode_creaExp_of_pos η a b hη μ hj', map_smul, mode_creaExp_of_pos η a b hη μ hi',
      show J - j' - i' = J - i' - j' from by ring, smul_smul, smul_smul]
  rcases le_total i j with h | h
  · exact key i j hi hj h
  · rw [nordPair_comm η a, key j i hj hi h, show J - j - i = J - i - j from by ring]

/-- One creation and one annihilation mode on `Φ_J`. -/
lemma nordPair_creaExp_of_neg_pos (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    {i j : ℤ} (hi : i < 0) (hj : 0 < j) (J : ℤ) :
    nordPair η a i j (creaExp η b J)
      = ∑ μ : Fin D, (η μ * b μ) • mode η a μ i (creaExp η b (J - j)) := by
  rw [nordPair_apply_of_le η a (by omega : i ≤ j)]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [mode_creaExp_of_pos η a b hη μ hj, map_smul, smul_smul]

/-- The zero mode together with an annihilation mode: `:α_0 · α_p: Φ_J = (a · b) Φ_{J-p}`. -/
lemma nordPair_creaExp_zero_pos (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    {p : ℤ} (hp : 0 < p) (J : ℤ) :
    nordPair η a 0 p (creaExp η b J)
      = (∑ μ : Fin D, η μ * a μ * b μ) • creaExp η b (J - p) := by
  rw [nordPair_apply_of_le η a (by omega : (0 : ℤ) ≤ p), Finset.sum_smul]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [mode_creaExp_of_pos η a b hη μ hp, map_smul, mode_zero_apply, smul_smul, smul_smul]
  congr 1
  ring

/-- **The Euler recursion in `mode` form.**  For any cut-off `N ≥ K`,
`Σ_{l = 1}^{N} Σ_μ η_μ b^μ α^μ_{-l} Φ_{K-l} = K · Φ_K`.  This is `Fock.creaExp_euler`
transported from `Finset.range` to an integer interval, and extended to `K < 0` where both
sides vanish. -/
lemma sum_mode_creaExp_eq_smul (η a b : Fin D → R) {K N : ℤ} (hKN : K ≤ N) :
    ∑ l ∈ Finset.Ioc (0 : ℤ) N, ∑ μ : Fin D,
        (η μ * b μ) • mode η a μ (-l) (creaExp η b (K - l))
      = (K : R) • creaExp η b K := by
  classical
  rcases lt_or_ge K 0 with hK | hK
  · rw [creaExp_of_neg η b hK, smul_zero]
    refine Finset.sum_eq_zero fun l hl => Finset.sum_eq_zero fun μ _ => ?_
    rw [Finset.mem_Ioc] at hl
    rw [creaExp_of_neg η b (by omega : K - l < 0), map_zero, smul_zero]
  · obtain ⟨M, rfl⟩ : ∃ M : ℕ, K = (M : ℤ) := ⟨K.toNat, (Int.toNat_of_nonneg hK).symm⟩
    have hres : ∑ l ∈ Finset.Ioc (0 : ℤ) N, ∑ μ : Fin D,
        (η μ * b μ) • mode η a μ (-l) (creaExp η b ((M : ℤ) - l))
        = ∑ l ∈ Finset.Ioc (0 : ℤ) (M : ℤ), ∑ μ : Fin D,
            (η μ * b μ) • mode η a μ (-l) (creaExp η b ((M : ℤ) - l)) := by
      refine (Finset.sum_subset ?_ ?_).symm
      · intro l hl
        rw [Finset.mem_Ioc] at hl ⊢
        omega
      · intro l hl hl2
        rw [Finset.mem_Ioc] at hl
        simp only [Finset.mem_Ioc, not_and, not_le] at hl2
        have hlt : (M : ℤ) < l := hl2 hl.1
        refine Finset.sum_eq_zero fun μ _ => ?_
        rw [creaExp_of_neg η b (by omega : (M : ℤ) - l < 0), map_zero, smul_zero]
    rw [hres]
    have hbij : ∑ l ∈ Finset.Ioc (0 : ℤ) (M : ℤ), ∑ μ : Fin D,
        (η μ * b μ) • mode η a μ (-l) (creaExp η b ((M : ℤ) - l))
        = ∑ l ∈ Finset.range M, ∑ μ : Fin D,
            (η μ * b μ) • creation R μ l.succPNat
              (creaExp η b ((M : ℤ) - ((l : ℤ) + 1))) := by
      refine Finset.sum_nbij' (i := fun l : ℤ => (l - 1).toNat) (j := fun n : ℕ => (n : ℤ) + 1)
        ?_ ?_ ?_ ?_ ?_
      · intro l hl
        rw [Finset.mem_Ioc] at hl
        rw [Finset.mem_range]
        omega
      · intro n hn
        rw [Finset.mem_range] at hn
        rw [Finset.mem_Ioc]
        omega
      · intro l hl
        rw [Finset.mem_Ioc] at hl
        omega
      · intro n _
        omega
      · intro l hl
        rw [Finset.mem_Ioc] at hl
        refine Finset.sum_congr rfl fun μ _ => ?_
        have hmode : mode η a μ (-l) = creation R μ ((l - 1).toNat).succPNat := by
          rw [mode_of_neg η a (by omega : (-l : ℤ) < 0)]
          congr 1
          refine PNat.coe_injective ?_
          rw [toPNat'_coe_of_pos (by omega : (0 : ℤ) < -(-l)), Nat.succPNat_coe]
          omega
        rw [hmode, show (M : ℤ) - l = (M : ℤ) - ((((l - 1).toNat : ℕ) : ℤ) + 1) from by omega]
    rw [hbij, ← creaExp_euler η b M]
    push_cast
    ring

/-- **The action of `L_m` (`m ≥ 1`) on the coherent-state coefficients.**  With
`Φ_J = creaExp η b J` the `z^J`-coefficient of `E_-(z)` and the contractions
`a · b = Σ_μ η_μ a^μ b^μ`, `b · b = Σ_μ η_μ b^μ b^μ`:

`L_m Φ_J = (a · b + ½ (m - 1) (b · b) + (J - m)) Φ_{J-m}`.

The three contributions come from the three regions of the Sugawara sum
`L_m = ½ Σ_j :α_{m-j} · α_j:` described in the section docstring above: the two terms
`j ∈ {0, m}` give `2 · ½ (a · b)`, the `m - 1` terms `1 ≤ j ≤ m - 1` give
`½ (m - 1) (b · b)`, and the two creation tails `j ≤ -1`, `j ≥ m + 1` each give
`½ (J - m)` by `Fock.sum_mode_creaExp_eq_smul`. -/
theorem Lop_apply_creaExp_of_pos (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    {m : ℤ} (hm : 0 < m) (J : ℤ) :
    Lop η a m (creaExp η b J)
      = ((∑ μ : Fin D, η μ * a μ * b μ)
          + invTwo R * ((m : R) - 1) * (∑ μ : Fin D, η μ * b μ * b μ)
          + ((J : R) - (m : R))) • creaExp η b (J - m) := by
  classical
  obtain ⟨N, hNm, hNJ, hNB⟩ : ∃ N : ℤ, m ≤ N ∧ J ≤ N ∧
      (modeBound (creaExp η b J) : ℤ) ≤ N :=
    ⟨max m (max J (modeBound (creaExp η b J) : ℤ)), by omega, by omega, by omega⟩
  have hs : ∀ j ∉ Finset.Ioc (m - N - 1) N,
      nordPair η a (m - j) j (creaExp η b J) = 0 := by
    intro j hj
    simp only [Finset.mem_Ioc, not_and, not_le] at hj
    refine nordPair_apply_eq_zero_of_modeBound_lt η a _ _ ?_
    rcases lt_or_ge (m - N - 1) j with h | h
    · have := hj h
      omega
    · omega
  have hsplit :
      ∑ j ∈ Finset.Ioc (m - N - 1) N, nordPair η a (m - j) j (creaExp η b J)
        = ∑ j ∈ Finset.Ioc (m - N - 1) (-1 : ℤ), nordPair η a (m - j) j (creaExp η b J)
          + ∑ j ∈ Finset.Ioc (-1 : ℤ) 0, nordPair η a (m - j) j (creaExp η b J)
          + ∑ j ∈ Finset.Ioc (0 : ℤ) (m - 1), nordPair η a (m - j) j (creaExp η b J)
          + ∑ j ∈ Finset.Ioc (m - 1) m, nordPair η a (m - j) j (creaExp η b J)
          + ∑ j ∈ Finset.Ioc m N, nordPair η a (m - j) j (creaExp η b J) := by
    rw [sum_Ioc_split _ (show m - N - 1 ≤ (-1 : ℤ) by omega) (show (-1 : ℤ) ≤ 0 by omega),
      sum_Ioc_split _ (show m - N - 1 ≤ (0 : ℤ) by omega) (show (0 : ℤ) ≤ m - 1 by omega),
      sum_Ioc_split _ (show m - N - 1 ≤ m - 1 by omega) (show m - 1 ≤ m by omega),
      sum_Ioc_split _ (show m - N - 1 ≤ m by omega) hNm]
  have hIoc0 : Finset.Ioc (-1 : ℤ) 0 = {0} := by
    ext x
    simp only [Finset.mem_Ioc, Finset.mem_singleton]
    omega
  have hIocm : Finset.Ioc (m - 1) m = {m} := by
    ext x
    simp only [Finset.mem_Ioc, Finset.mem_singleton]
    omega
  have hpiece2 : nordPair η a m 0 (creaExp η b J)
      = (∑ μ : Fin D, η μ * a μ * b μ) • creaExp η b (J - m) := by
    rw [nordPair_comm η a m 0, nordPair_creaExp_zero_pos η a b hη hm]
  have hpiece4 : nordPair η a 0 m (creaExp η b J)
      = (∑ μ : Fin D, η μ * a μ * b μ) • creaExp η b (J - m) :=
    nordPair_creaExp_zero_pos η a b hη hm J
  have hcard : (((Finset.Ioc (0 : ℤ) (m - 1)).card : ℕ) : R) = (m : R) - 1 := by
    have h1 : (((Finset.Ioc (0 : ℤ) (m - 1)).card : ℕ) : ℤ) = m - 1 := by
      rw [Int.card_Ioc]
      omega
    have h2 := congrArg (fun z : ℤ => (z : R)) h1
    push_cast at h2
    exact h2
  have hpiece3 : ∑ j ∈ Finset.Ioc (0 : ℤ) (m - 1), nordPair η a (m - j) j (creaExp η b J)
      = ((m : R) - 1) • ((∑ μ : Fin D, η μ * b μ * b μ) • creaExp η b (J - m)) := by
    have hconst : ∀ j ∈ Finset.Ioc (0 : ℤ) (m - 1),
        nordPair η a (m - j) j (creaExp η b J)
          = (∑ μ : Fin D, η μ * b μ * b μ) • creaExp η b (J - m) := by
      intro j hj
      rw [Finset.mem_Ioc] at hj
      rw [nordPair_creaExp_of_pos_pos η a b hη (by omega : (0 : ℤ) < m - j)
        (by omega : (0 : ℤ) < j), show J - (m - j) - j = J - m from by ring]
    rw [Finset.sum_congr rfl hconst, Finset.sum_const, ← Nat.cast_smul_eq_nsmul R, hcard]
  have hpiece5 : ∑ j ∈ Finset.Ioc m N, nordPair η a (m - j) j (creaExp η b J)
      = ∑ l ∈ Finset.Ioc (0 : ℤ) (N - m), ∑ μ : Fin D,
          (η μ * b μ) • mode η a μ (-l) (creaExp η b (J - m - l)) := by
    refine Finset.sum_nbij' (i := fun j : ℤ => j - m) (j := fun l : ℤ => l + m) ?_ ?_ ?_ ?_ ?_
    · intro j hj
      rw [Finset.mem_Ioc] at hj ⊢
      omega
    · intro l hl
      rw [Finset.mem_Ioc] at hl ⊢
      omega
    · intro j _
      omega
    · intro l _
      omega
    · intro j hj
      rw [Finset.mem_Ioc] at hj
      rw [nordPair_creaExp_of_neg_pos η a b hη (by omega : m - j < 0) (by omega : (0 : ℤ) < j)]
      refine Finset.sum_congr rfl fun μ _ => ?_
      rw [show -(j - m) = m - j from by ring, show J - m - (j - m) = J - j from by ring]
  have hpiece1 : ∑ j ∈ Finset.Ioc (m - N - 1) (-1 : ℤ),
        nordPair η a (m - j) j (creaExp η b J)
      = ∑ l ∈ Finset.Ioc (0 : ℤ) (N - m), ∑ μ : Fin D,
          (η μ * b μ) • mode η a μ (-l) (creaExp η b (J - m - l)) := by
    refine Finset.sum_nbij' (i := fun j : ℤ => -j) (j := fun l : ℤ => -l) ?_ ?_ ?_ ?_ ?_
    · intro j hj
      rw [Finset.mem_Ioc] at hj ⊢
      omega
    · intro l hl
      rw [Finset.mem_Ioc] at hl ⊢
      omega
    · intro j _
      omega
    · intro l _
      omega
    · intro j hj
      rw [Finset.mem_Ioc] at hj
      rw [nordPair_comm η a, nordPair_creaExp_of_neg_pos η a b hη (by omega : j < 0)
        (by omega : (0 : ℤ) < m - j)]
      refine Finset.sum_congr rfl fun μ _ => ?_
      rw [show -(-j) = j from by ring, show J - m - -j = J - (m - j) from by ring]
  rw [Lop_apply η a m (creaExp η b J) hs, hsplit, hIoc0, hIocm]
  simp only [Finset.sum_singleton, sub_zero, sub_self]
  rw [hpiece1, hpiece2, hpiece3, hpiece4, hpiece5,
    sum_mode_creaExp_eq_smul η a b (show J - m ≤ N - m by omega), smul_smul, ← add_smul,
    ← add_smul, ← add_smul, ← add_smul, smul_smul]
  congr 1
  push_cast
  linear_combination (((J : R) - (m : R)) + (∑ μ : Fin D, η μ * a μ * b μ)) * two_mul_invTwo R

/-- **Consistency check** for `Fock.Lop_apply_creaExp_of_pos` at `m = J = 1`.  The theorem
predicts `L_1 Φ_1 = (a · b) |k⟩`. -/
theorem Lop_one_apply_creaExp_one (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) :
    Lop η a 1 (creaExp η b 1) = (∑ μ : Fin D, η μ * a μ * b μ) • (1 : Fock D R) := by
  rw [Lop_apply_creaExp_of_pos η a b hη (by norm_num : (0 : ℤ) < 1) 1,
    show (1 : ℤ) - 1 = 0 from by ring, creaExp_zero]
  congr 1
  push_cast
  ring

/-- The same value computed along a different route: `Φ_1 = Σ_μ η_μ b^μ α^μ_{-1}|k⟩` and
`L_1 α^μ_{-1}|k⟩ = α^μ_0|k⟩ = a^μ|k⟩` by the mode commutator `Fock.Lop_apply_mode_one`.  This
does *not* use the Sugawara index bookkeeping of `Fock.Lop_apply_creaExp_of_pos`, so together
with `Fock.Lop_one_apply_creaExp_one` it cross-checks that computation. -/
theorem Lop_one_apply_creaExp_one_via_mode (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) :
    Lop η a 1 (creaExp η b 1) = (∑ μ : Fin D, η μ * a μ * b μ) • (1 : Fock D R) := by
  have h := creaExp_euler η b 1
  simp only [Nat.cast_one, one_smul, Finset.sum_range_one, Nat.cast_zero, zero_add, sub_self,
    creaExp_zero] at h
  have hpn : Nat.succPNat 0 = (1 : ℕ+) := rfl
  rw [hpn] at h
  have hstep : ∀ μ : Fin D,
      Lop η a 1 (creation R μ 1 (1 : Fock D R)) = a μ • (1 : Fock D R) := by
    intro μ
    have hc : creation R μ 1 (1 : Fock D R) = mode η a μ (-1) (1 : Fock D R) := by
      rw [show (-1 : ℤ) = -(((1 : ℕ+) : ℕ) : ℤ) from by norm_num, mode_neg_pnat]
    rw [hc, Lop_apply_mode_one η a hη (by norm_num : (0 : ℤ) < 1) μ (-1),
      show (1 : ℤ) + -1 = 0 from by ring, mode_zero_apply]
    simp
  rw [h, map_sum, Finset.sum_smul]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [map_smul, hstep μ, smul_smul]
  congr 1
  ring

/-- The form in which the computation feeds the conformal-weight identity.  The vacuum
specialisation of `L_m^{(a+b)} V_J - V_J L_m^{(a)} = (J + a · b - m + (m+1) ½ (b · b)) V_{J-m}`
is obtained from `Fock.Lop_apply_creaExp_of_pos` by replacing the zero-mode parameter `a` by
`a + b` (the vertex operator shifts the momentum) and using `V_J |k⟩ = Φ_J`,
`L_m^{(a)} |k⟩ = 0` for `m ≥ 1`:

`L_m^{(a+b)} Φ_J = (J - m + a · b + ½ (m+1) (b · b)) Φ_{J-m}`.

Reading off the `J`-independent, `m`-linear part gives the conformal weight `h = ½ (b · b)`,
i.e. `h = α' k_0²` in the conventions of `conv.alpha-prime-regge`; the DDF normalisation
`k_0² = 0` is exactly what makes the weight vanish. -/
theorem Lop_apply_creaExp_of_pos_shifted (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    {m : ℤ} (hm : 0 < m) (J : ℤ) :
    Lop η (a + b) m (creaExp η b J)
      = (((J : R) - (m : R)) + (∑ μ : Fin D, η μ * a μ * b μ)
          + invTwo R * ((m : R) + 1) * (∑ μ : Fin D, η μ * b μ * b μ))
        • creaExp η b (J - m) := by
  rw [Lop_apply_creaExp_of_pos η (a + b) b hη hm J]
  have hsum : ∑ μ : Fin D, η μ * (a + b) μ * b μ
      = (∑ μ : Fin D, η μ * a μ * b μ) + ∑ μ : Fin D, η μ * b μ * b μ := by
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun μ _ => ?_
    rw [Pi.add_apply]
    ring
  rw [hsum]
  congr 1
  linear_combination (-(∑ μ : Fin D, η μ * b μ * b μ)) * two_mul_invTwo R

/-- **The `m = 0` case**, which is *not* the `m = 0` specialisation of
`Fock.Lop_apply_creaExp_of_pos`: `L_0 Φ_J = (α' k² + J) Φ_J`.

The two formulas genuinely differ.  For `m ≥ 1` the indices `j = 0` and `j = m` of the
Sugawara sum are distinct and each contributes `½ (a · b)`; at `m = 0` they coincide into the
single term `½ :α_0 · α_0: = ½ (a · a)`, and the middle region `1 ≤ j ≤ m - 1` is empty.
Substituting `m = 0` into `Fock.Lop_apply_creaExp_of_pos` would give the wrong value
`a · b - ½ (b · b) + J` instead of `½ (a · a) + J`, so the hypothesis `0 < m` there is
essential.

Since `Φ_J` is homogeneous of level `J` (`Fock.creaExp_mem_levelSubmodule`), this case is just
`Fock.Lop_zero_apply_of_mem_levelSubmodule`, i.e. `L_0 = α' k² + N`. -/
theorem Lop_zero_apply_creaExp (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (J : ℤ) :
    Lop η a 0 (creaExp η b J)
      = (invTwo R * zeroModeSq η a + (J : R)) • creaExp η b J := by
  rcases lt_or_ge J 0 with hJ | hJ
  · rw [creaExp_of_neg η b hJ, map_zero, smul_zero]
  · obtain ⟨N, rfl⟩ : ∃ N : ℕ, J = (N : ℤ) := ⟨J.toNat, (Int.toNat_of_nonneg hJ).symm⟩
    rw [Lop_zero_apply_of_mem_levelSubmodule η a hη (creaExp_mem_levelSubmodule η b rfl)]
    congr 1
    push_cast
    ring

end LopCreaExp

section LopVertexOsc

variable [Algebra ℚ R]

/-! ### The conformal-weight identity on a general state (`m ≥ 1`)

Work in progress: statements are added one at a time, each with a complete proof.
-/

/-- Moving a creation operator past `L_m`: the pointwise form of `⁅L_m, α^μ_p⁆ = -p α^μ_{m+p}`
at `p = -l`, namely `L_m (α^μ_{-l} Q) = α^μ_{-l} (L_m Q) + l α^μ_{m-l} Q`.  Here
`α^μ_{-l} Q = X (μ, l) * Q` is multiplication by the corresponding Fock variable. -/
lemma Lop_apply_X_mul (η a : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (m : ℤ) (v : Osc D)
    (Q : Fock D R) :
    Lop η a m (X v * Q)
      = X v * Lop η a m Q + (((v.2 : ℕ) : R)) • mode η a v.1 (m - ((v.2 : ℕ) : ℤ)) Q := by
  obtain ⟨μ, n⟩ := v
  have hml : m + -(((n : ℕ)) : ℤ) = m - (((n : ℕ)) : ℤ) := by ring
  have h := congrArg (fun T : Module.End R (Fock D R) => T Q)
    (lie_Lop_mode η a hη m μ (-(((n : ℕ)) : ℤ)))
  simp only [LieRing.of_associative_ring_bracket, LinearMap.sub_apply,
    Module.End.mul_apply, LinearMap.smul_apply, mode_neg_pnat, creation_apply, Int.cast_neg,
    neg_neg, Int.cast_natCast, hml] at h
  rw [← h]
  abel

/-- **The conformal-weight identity on a general state, for `m ≥ 1`.**

`L_m^{(a+b)} V_J - V_J L_m^{(a)} = (J - m + a·b + ½ (m+1) (b·b)) V_{J-m}`,

where `V_J = vertexOsc η b J` is the `z^J` Laurent coefficient of the oscillator part of
`:e^{i c·X(z)}:`, the left Virasoro generator carries the shifted zero mode `a + b` and the
right one the original zero mode `a` (the two-momentum bookkeeping of
`Fock.mode_vertexOsc_sub`).

Proof: both sides, as families of endomorphisms indexed by `J`, satisfy the *same*
creation-mode recursion.  For the left side this uses `Fock.lie_Lop_mode` (through
`Fock.Lop_apply_X_mul`) together with `Fock.mode_vertexOsc_sub`; for the right side only
`Fock.mode_vertexOsc_sub`.  The coefficient is affine in `J` with slope `1`, which is exactly
what compensates the `l · V_{J+l-m}` term produced by `⁅α^μ_{-l}, L_m⁆ = -l α^μ_{m-l}`.  On
the vacuum the two sides agree by `Fock.Lop_apply_creaExp_of_pos_shifted` and
`Fock.Lop_apply_one_of_pos`.  `Fock.eq_zero_of_vertex_recursion` then forces equality.

The `m < 0` case is *not* of this shape and is not covered here (see the file header). -/
theorem lie_Lop_vertexOsc_of_pos (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    {m : ℤ} (hm : 0 < m) (J : ℤ) :
    Lop η (a + b) m ∘ₗ vertexOsc η b J - vertexOsc η b J ∘ₗ Lop η a m
      = (((J : R) - (m : R)) + (∑ μ : Fin D, η μ * a μ * b μ)
          + invTwo R * ((m : R) + 1) * (∑ μ : Fin D, η μ * b μ * b μ))
        • vertexOsc η b (J - m) := by
  have hzero := eq_zero_of_vertex_recursion b
    (fun K : ℤ => (Lop η (a + b) m ∘ₗ vertexOsc η b K - vertexOsc η b K ∘ₗ Lop η a m)
      - (((K : R) - (m : R)) + (∑ μ : Fin D, η μ * a μ * b μ)
          + invTwo R * ((m : R) + 1) * (∑ μ : Fin D, η μ * b μ * b μ))
        • vertexOsc η b (K - m)) ?_ ?_ J
  · rwa [sub_eq_zero] at hzero
  · intro v K P
    have hidx1 : K - m + ((v.2 : ℕ) : ℤ) = K + ((v.2 : ℕ) : ℤ) - m := by ring
    have hidx2 : K - (m - ((v.2 : ℕ) : ℤ)) = K + ((v.2 : ℕ) : ℤ) - m := by ring
    have hmv := mode_vertexOsc_sub η a b hη v.1 (m - ((v.2 : ℕ) : ℤ)) K P
    rw [hidx2] at hmv
    have hT2 : mode η (a + b) v.1 (m - ((v.2 : ℕ) : ℤ)) (vertexOsc η b K P)
        = vertexOsc η b K (mode η a v.1 (m - ((v.2 : ℕ) : ℤ)) P)
          + b v.1 • vertexOsc η b (K + ((v.2 : ℕ) : ℤ) - m) P := by
      rw [← hmv]; abel
    simp only [LinearMap.sub_apply, LinearMap.comp_apply, LinearMap.smul_apply]
    rw [vertexOsc_X_mul η b v K P, map_sub, map_smul,
      Lop_apply_X_mul η (a + b) hη m v (vertexOsc η b K P),
      Lop_apply_X_mul η a hη m v P, map_add, map_smul,
      vertexOsc_X_mul η b v K (Lop η a m P),
      vertexOsc_X_mul η b v (K - m) P, hT2, hidx1]
    simp only [mul_sub, mul_add, mul_smul_comm]
    push_cast
    module
  · intro K
    simp only [LinearMap.sub_apply, LinearMap.comp_apply, LinearMap.smul_apply,
      vertexOsc_apply_one]
    rw [Lop_apply_one_of_pos η a hm, map_zero,
      Lop_apply_creaExp_of_pos_shifted η a b hη hm K]
    abel

/-- **The isotropic (`b · b = 0`) case**, which is the DDF normalisation: the vertex operator
is a weight-`1` primary, `L_m^{(a+b)} V_J - V_J L_m^{(a)} = (J - m + a·b) V_{J-m}` for `m ≥ 1`.

The conformal weight of `:e^{i c·X}:` is `h = ½ (b · b) = α' k_0²`, so `k_0² = 0` is exactly
what makes the `m`-quadratic term drop out and leaves the weight-`1` transformation law used
by the DDF construction. -/
theorem lie_Lop_vertexOsc_of_pos_isotropic (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hb : (∑ μ : Fin D, η μ * b μ * b μ) = 0) {m : ℤ} (hm : 0 < m) (J : ℤ) :
    Lop η (a + b) m ∘ₗ vertexOsc η b J - vertexOsc η b J ∘ₗ Lop η a m
      = (((J : R) - (m : R)) + (∑ μ : Fin D, η μ * a μ * b μ)) • vertexOsc η b (J - m) := by
  rw [lie_Lop_vertexOsc_of_pos η a b hη hm J, hb]
  congr 1
  ring

end LopVertexOsc

end Fock

end StringFormal.NoGhost
