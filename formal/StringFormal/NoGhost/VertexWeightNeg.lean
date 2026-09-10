/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/

import StringFormal.NoGhost.VertexWeight

/-!
# 顶点算子的共形权：`m < 0` 的一半

对应图节点：`worldsheet.ddf-operators`（`formal/TODO.md` 项 `ddf-operators` 的 (3f)）。
约定与 `NoGhost/VertexWeight.lean`、`NoGhost/Sugawara.lean` 相同。

`VertexWeight.lean` 证了共形权恒等式的 `m ≥ 1` 一半。那里能归约到真空，靠的是
`m ≥ 1` 时 `L_m^{(a)} |k⟩ = 0`（`Fock.Lop_apply_one_of_pos`）。`m < 0` 时这条不成立：
`L_m^{(a)} |k⟩` 是一个真正含产生算子的向量，于是真空上的等式形如

`L_m^{(a+b)} Φ_J = c(m, J) · Φ_{J-m} + V_J (L_m^{(a)} |k⟩)`，

右边第二项不是 `Φ_*` 的标量倍。本文件的目标就是把这一项算清楚。

## 本文件已证

* `Fock.nordPair_apply_of_neg_left` — `i < 0` 时 `:α_i · α_j: = Σ_μ η^μ α^μ_i α^μ_j`
  对**任意** `j` 成立（不需要 `i ≤ j`）：`j ≤ i` 时两个因子对易，因为 `i + j ≤ 2i < 0`。
* `Fock.Lop_apply_one_of_neg` — `m ≤ -1` 时真空上的显式有限和
  `L_m |k⟩ = (α_m · α_0)|k⟩ + ½ Σ_{j=m+1}^{-1} (α_{m-j} · α_j)|k⟩`。
  Sugawara 求和的指标集在真空上是 `Finset.Icc m 0`；两个端点项 `j = m`、`j = 0` 相等，
  合起来抵掉 `½`；中间段 `Finset.Ioo m 0` 在 `m = -1` 时为空。

* `Fock.nordPair_neg_zero_apply` — `m < 0` 时 `:α_m · α_0: P = Σ_μ η^μ a^μ α^μ_m P`。
* `Fock.Lop_apply_creaExp_of_neg` — `m ≤ -1` 时 `L_m^{(a)} Φ_J` 的显式表达式
  （`Φ_J = creaExp η b J` 是相干态系数）：

  `L_m Φ_J = Σ_μ η^μ a^μ α^μ_m Φ_J + [(J-m) Φ_{J-m} - Σ_{l=1}^{-m} Σ_μ η^μ b^μ α^μ_{-l} Φ_{J-m-l}]
             + ½ Σ_{j=m+1}^{-1} Σ_μ η^μ α^μ_{m-j} α^μ_j Φ_J`。

  与 `m ≥ 1` 的 `Fock.Lop_apply_creaExp_of_pos` 相比多出两样东西：中间段 `m+1 ≤ j ≤ -1`
  两个因子都是产生算子（非标量项），以及两条产生尾 `j ≤ m-1`、`j ≥ 1` 换元后只覆盖
  `l ≥ -m+1`，所以欧拉递推 `Fock.sum_mode_creaExp_eq_smul` 要减掉头 `-m` 项。

## 尚缺

* `lie_Lop_vertexOsc_of_neg` —— 一般态上的 `m < 0` 恒等式。
-/

namespace StringFormal.NoGhost

open MvPolynomial

namespace Fock

variable {D : ℕ} {R : Type*} [CommRing R]

section LopVacuumNeg

variable (η a : Fin D → R)

/-- Normal ordering with a **creation operator on the left** is already ordered: if `i < 0`
then `:α_i · α_j: = Σ_μ η^μ α^μ_i α^μ_j` for *every* `j`, with no `max` swap.  For `i ≤ j`
this is the definition; for `j ≤ i` the two factors commute because `i + j ≤ 2i < 0`, so the
commutator `[α^μ_j, α^μ_i] = j η^μ δ_{i+j,0}` vanishes. -/
lemma nordPair_apply_of_neg_left {i : ℤ} (hi : i < 0) (j : ℤ) (P : Fock D R) :
    nordPair η a i j P = ∑ μ : Fin D, η μ • mode η a μ i (mode η a μ j P) := by
  rcases le_total i j with h | h
  · exact nordPair_apply_of_le η a h P
  · rw [nordPair_comm η a, nordPair_apply_of_le η a h]
    refine Finset.sum_congr rfl fun μ _ => ?_
    rw [mode_apply_mode η a μ j i P, if_neg (by omega), zero_smul, zero_add]

/-- The zero mode paired with a negative mode: `:α_m · α_0: P = Σ_μ η^μ a^μ α^μ_m P` for
`m < 0` (normal ordering puts the creation operator `α_m` on the left). -/
lemma nordPair_neg_zero_apply {m : ℤ} (hm : m < 0) (P : Fock D R) :
    nordPair η a m 0 P = ∑ μ : Fin D, (η μ * a μ) • mode η a μ m P := by
  rw [nordPair_apply_of_le η a hm.le]
  exact Finset.sum_congr rfl fun μ _ => by rw [mode_zero_apply, map_smul, smul_smul]

variable [Algebra ℚ R]

/-- **`L_m` on the vacuum for `m ≤ -1`.**  Unlike the case `m ≥ 1` (`Lop_apply_one_of_pos`,
which gives `0`), the negative modes do not annihilate `|k⟩`; the Sugawara sum collapses to
the finite range `m ≤ j ≤ 0` and gives

`L_m |k⟩ = (α_m · α_0) |k⟩ + ½ Σ_{j = m+1}^{-1} (α_{m-j} · α_j) |k⟩`.

The two extreme terms `j = m` and `j = 0` are equal (normal ordering is symmetric) and
together cancel the `½`; the middle range is empty exactly when `m = -1`, so
`L_{-1}|k⟩ = (α_{-1} · α_0)|k⟩` (`Fock.Lop_neg_one_apply_one`). -/
theorem Lop_apply_one_of_neg {m : ℤ} (hm : m < 0) :
    Lop η a m (1 : Fock D R)
      = (∑ μ : Fin D, (η μ * a μ) • mode η a μ m (1 : Fock D R))
        + invTwo R • ∑ j ∈ Finset.Ioo m 0, ∑ μ : Fin D,
            η μ • mode η a μ (m - j) (mode η a μ j (1 : Fock D R)) := by
  classical
  have hzero : nordPair η a m 0 (1 : Fock D R)
      = ∑ μ : Fin D, (η μ * a μ) • mode η a μ m (1 : Fock D R) :=
    nordPair_neg_zero_apply η a hm 1
  have hs : ∀ j ∉ Finset.Icc m 0, nordPair η a (m - j) j (1 : Fock D R) = 0 := by
    intro j hj
    rw [Finset.mem_Icc, not_and_or] at hj
    refine nordPair_apply_eq_zero_of_modeBound_lt η a _ _ ?_
    rw [modeBound_one, Nat.cast_zero]
    rcases hj with h | h
    · exact lt_of_lt_of_le (by omega) (le_max_left (m - j) j)
    · exact lt_of_lt_of_le (by omega) (le_max_right (m - j) j)
  have e1 : nordPair η a (m - m) m (1 : Fock D R)
      = ∑ μ : Fin D, (η μ * a μ) • mode η a μ m (1 : Fock D R) := by
    rw [sub_self, nordPair_comm η a 0 m, hzero]
  have e2 : nordPair η a (m - 0) 0 (1 : Fock D R)
      = ∑ μ : Fin D, (η μ * a μ) • mode η a μ m (1 : Fock D R) := by
    rw [sub_zero, hzero]
  have e3 : ∑ j ∈ Finset.Ioo m 0, nordPair η a (m - j) j (1 : Fock D R)
      = ∑ j ∈ Finset.Ioo m 0, ∑ μ : Fin D,
          η μ • mode η a μ (m - j) (mode η a μ j (1 : Fock D R)) := by
    refine Finset.sum_congr rfl fun j hj => ?_
    rw [Finset.mem_Ioo] at hj
    exact nordPair_apply_of_neg_left η a (by omega) j 1
  rw [Lop_apply η a m 1 hs, ← Finset.Ioc_insert_left hm.le,
    Finset.sum_insert (by simp), ← Finset.Ioo_insert_right hm,
    Finset.sum_insert (by simp), e1, e2, e3,
    show ∀ T1 T2 : Fock D R, T1 + (T1 + T2) = (2 : R) • T1 + T2 from fun T1 T2 => by
      rw [two_smul]; abel,
    smul_add, smul_smul, invTwo_mul_two, one_smul]

end LopVacuumNeg

section LopCreaExpNeg

variable [Algebra ℚ R]

/-- **The action of `L_m` (`m ≤ -1`) on the coherent-state coefficients `Φ_J = creaExp η b J`.**

For `m ≥ 1` (`Fock.Lop_apply_creaExp_of_pos`) the answer is a scalar multiple of `Φ_{J-m}`.
For `m < 0` two new features appear and the answer is *not* of that shape:

* the middle region of the Sugawara sum, `m + 1 ≤ j ≤ -1`, now has a *creation* operator in
  both factors, so it contributes the genuinely non-scalar term
  `½ Σ_{j=m+1}^{-1} Σ_μ η^μ α^μ_{m-j} α^μ_j Φ_J`;
* the two creation tails `j ≤ m - 1` and `j ≥ 1` no longer exhaust the Euler recursion: after
  the substitution `l = j - m` (resp. `l = -j`) they cover only `l ≥ -m + 1`, so the Euler sum
  `Σ_{l ≥ 1} Σ_μ η^μ b^μ α^μ_{-l} Φ_{(J-m)-l} = (J-m) Φ_{J-m}`
  (`Fock.sum_mode_creaExp_eq_smul`) has to be corrected by its first `-m` terms.

The zero-mode term `j ∈ {0, m}` is `Σ_μ η^μ a^μ α^μ_m Φ_J` (the parameter `a` here is the
zero mode carried by `L_m`, which for the conformal-weight identity is the *shifted* momentum
`a + b`). -/
theorem Lop_apply_creaExp_of_neg (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    {m : ℤ} (hm : m < 0) (J : ℤ) :
    Lop η a m (creaExp η b J)
      = (∑ μ : Fin D, (η μ * a μ) • mode η a μ m (creaExp η b J))
        + (((J : R) - (m : R)) • creaExp η b (J - m)
            - ∑ l ∈ Finset.Ioc (0 : ℤ) (-m), ∑ μ : Fin D,
                (η μ * b μ) • mode η a μ (-l) (creaExp η b (J - m - l)))
        + invTwo R • ∑ j ∈ Finset.Ioo m 0, ∑ μ : Fin D,
            η μ • mode η a μ (m - j) (mode η a μ j (creaExp η b J)) := by
  classical
  obtain ⟨N, hN0, hNJ, hNB⟩ : ∃ N : ℤ, 0 ≤ N ∧ J ≤ N ∧
      (modeBound (creaExp η b J) : ℤ) ≤ N :=
    ⟨max 0 (max J (modeBound (creaExp η b J) : ℤ)), by omega, by omega, by omega⟩
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
        = ∑ j ∈ Finset.Ioc (m - N - 1) (m - 1), nordPair η a (m - j) j (creaExp η b J)
          + ∑ j ∈ Finset.Ioc (m - 1) m, nordPair η a (m - j) j (creaExp η b J)
          + ∑ j ∈ Finset.Ioc m (-1 : ℤ), nordPair η a (m - j) j (creaExp η b J)
          + ∑ j ∈ Finset.Ioc (-1 : ℤ) 0, nordPair η a (m - j) j (creaExp η b J)
          + ∑ j ∈ Finset.Ioc (0 : ℤ) N, nordPair η a (m - j) j (creaExp η b J) := by
    rw [sum_Ioc_split _ (show m - N - 1 ≤ m - 1 by omega) (show m - 1 ≤ m by omega),
      sum_Ioc_split _ (show m - N - 1 ≤ m by omega) (show m ≤ (-1 : ℤ) by omega),
      sum_Ioc_split _ (show m - N - 1 ≤ (-1 : ℤ) by omega) (show (-1 : ℤ) ≤ 0 by omega),
      sum_Ioc_split _ (show m - N - 1 ≤ (0 : ℤ) by omega) hN0]
  have hIocm : Finset.Ioc (m - 1) m = {m} := by
    ext x; simp only [Finset.mem_Ioc, Finset.mem_singleton]; omega
  have hIoc0 : Finset.Ioc (-1 : ℤ) 0 = {0} := by
    ext x; simp only [Finset.mem_Ioc, Finset.mem_singleton]; omega
  have hIocmid : Finset.Ioc m (-1 : ℤ) = Finset.Ioo m 0 := by
    ext x; simp only [Finset.mem_Ioc, Finset.mem_Ioo]; omega
  -- the two extreme terms `j = m` and `j = 0`
  have hpiecem : nordPair η a 0 m (creaExp η b J)
      = ∑ μ : Fin D, (η μ * a μ) • mode η a μ m (creaExp η b J) := by
    rw [nordPair_comm η a 0 m]
    exact nordPair_neg_zero_apply η a hm _
  have hpiece0 : nordPair η a m 0 (creaExp η b J)
      = ∑ μ : Fin D, (η μ * a μ) • mode η a μ m (creaExp η b J) :=
    nordPair_neg_zero_apply η a hm _
  -- the double-creation middle region
  have hmid : ∑ j ∈ Finset.Ioo m 0, nordPair η a (m - j) j (creaExp η b J)
      = ∑ j ∈ Finset.Ioo m 0, ∑ μ : Fin D,
          η μ • mode η a μ (m - j) (mode η a μ j (creaExp η b J)) := by
    refine Finset.sum_congr rfl fun j hj => ?_
    rw [Finset.mem_Ioo] at hj
    exact nordPair_apply_of_neg_left η a (by omega) j _
  -- the upper creation tail `j ≥ 1`, reindexed by `l = j - m`
  have hhigh : ∑ j ∈ Finset.Ioc (0 : ℤ) N, nordPair η a (m - j) j (creaExp η b J)
      = ∑ l ∈ Finset.Ioc (-m) (N - m), ∑ μ : Fin D,
          (η μ * b μ) • mode η a μ (-l) (creaExp η b (J - m - l)) := by
    refine Finset.sum_nbij' (i := fun j : ℤ => j - m) (j := fun l : ℤ => l + m) ?_ ?_ ?_ ?_ ?_
    · intro j hj; rw [Finset.mem_Ioc] at hj ⊢; omega
    · intro l hl; rw [Finset.mem_Ioc] at hl ⊢; omega
    · intro j _; omega
    · intro l _; omega
    · intro j hj
      rw [Finset.mem_Ioc] at hj
      rw [nordPair_creaExp_of_neg_pos η a b hη (by omega : m - j < 0) (by omega : (0 : ℤ) < j)]
      refine Finset.sum_congr rfl fun μ _ => ?_
      rw [show -(j - m) = m - j from by ring, show J - m - (j - m) = J - j from by ring]
  -- the lower creation tail `j ≤ m - 1`, reindexed by `l = -j`
  have hlow : ∑ j ∈ Finset.Ioc (m - N - 1) (m - 1), nordPair η a (m - j) j (creaExp η b J)
      = ∑ l ∈ Finset.Ioc (-m) (N - m), ∑ μ : Fin D,
          (η μ * b μ) • mode η a μ (-l) (creaExp η b (J - m - l)) := by
    refine Finset.sum_nbij' (i := fun j : ℤ => -j) (j := fun l : ℤ => -l) ?_ ?_ ?_ ?_ ?_
    · intro j hj; rw [Finset.mem_Ioc] at hj ⊢; omega
    · intro l hl; rw [Finset.mem_Ioc] at hl ⊢; omega
    · intro j _; omega
    · intro l _; omega
    · intro j hj
      rw [Finset.mem_Ioc] at hj
      rw [nordPair_comm η a, nordPair_creaExp_of_neg_pos η a b hη (by omega : j < 0)
        (by omega : (0 : ℤ) < m - j)]
      refine Finset.sum_congr rfl fun μ _ => ?_
      rw [show -(-j) = j from by ring, show J - m - -j = J - (m - j) from by ring]
  -- the two tails together only cover `l ≥ -m + 1`; complete them to the Euler recursion
  have hS : ∑ l ∈ Finset.Ioc (-m) (N - m), ∑ μ : Fin D,
        (η μ * b μ) • mode η a μ (-l) (creaExp η b (J - m - l))
      = ((J : R) - (m : R)) • creaExp η b (J - m)
        - ∑ l ∈ Finset.Ioc (0 : ℤ) (-m), ∑ μ : Fin D,
            (η μ * b μ) • mode η a μ (-l) (creaExp η b (J - m - l)) := by
    have heuler := sum_mode_creaExp_eq_smul η a b (K := J - m) (N := N - m) (by omega)
    push_cast at heuler
    rw [eq_sub_iff_add_eq, add_comm,
      sum_Ioc_split (fun l : ℤ => ∑ μ : Fin D,
        (η μ * b μ) • mode η a μ (-l) (creaExp η b (J - m - l)))
        (show (0 : ℤ) ≤ -m by omega) (show -m ≤ N - m by omega)]
    exact heuler
  rw [Lop_apply η a m (creaExp η b J) hs, hsplit, hIocm, hIoc0, hIocmid]
  simp only [Finset.sum_singleton, sub_zero, sub_self]
  rw [hlow, hpiecem, hmid, hpiece0, hhigh, hS]
  generalize ((J : R) - (m : R)) • creaExp η b (J - m)
      - ∑ l ∈ Finset.Ioc (0 : ℤ) (-m), ∑ μ : Fin D,
          (η μ * b μ) • mode η a μ (-l) (creaExp η b (J - m - l)) = T
  generalize (∑ μ : Fin D, (η μ * a μ) • mode η a μ m (creaExp η b J)) = P
  generalize (∑ j ∈ Finset.Ioo m 0, ∑ μ : Fin D,
      η μ • mode η a μ (m - j) (mode η a μ j (creaExp η b J))) = Mid
  rw [show T + P + Mid + P + T = (2 : R) • (P + T) + Mid from by rw [two_smul]; abel,
    smul_add, smul_smul, invTwo_mul_two, one_smul]

end LopCreaExpNeg

end Fock

end StringFormal.NoGhost
