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
      = ∑ μ : Fin D, (η μ * a μ) • mode η a μ m (1 : Fock D R) := by
    rw [nordPair_apply_of_le η a hm.le]
    exact Finset.sum_congr rfl fun μ _ => by rw [mode_zero_apply, map_smul, smul_smul]
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

end Fock

end StringFormal.NoGhost
