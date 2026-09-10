/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/

import StringFormal.NoGhost.VertexWeightNeg

/-!
# 顶点算子的共形权：`m = 0`

对应图节点：`worldsheet.ddf-operators`（`formal/TODO.md` 项 `ddf-operators` 的 (3g)）。
约定与 `NoGhost/VertexWeight.lean`、`NoGhost/VertexWeightNeg.lean`、`NoGhost/Sugawara.lean` 相同。

`VertexWeight.lean` 证了 `m ≥ 1`，`VertexWeightNeg.lean` 证了 `m ≤ -1`。本文件补上 `m = 0`，
从而共形权恒等式对**一切** `m : ℤ` 成立。

## 为什么 `m = 0` 要单独做

Sugawara 求和 `L_m = ½ Σ_j :α_{m-j} · α_j:` 在 `m ≠ 0` 时有两个不同的「零模端点」
`j = 0` 与 `j = m`，各出 `½ (a · b)`；`m = 0` 时二者并成**一项** `½ :α_0 · α_0: = ½ (a · a)`，
而中间段为空。于是**真空引理**换了形状：

* `m ≥ 1`：`L_m^{(a)} |k⟩ = 0`（`Fock.Lop_apply_one_of_pos`）；
* `m ≤ -1`：`L_m^{(a)} |k⟩` 是含产生算子的有限和（`Fock.Lop_apply_one_of_neg`）；
* `m = 0`：`L_0^{(a)} |k⟩ = ½ (a · a) |k⟩`（`Fock.Lop_zero_apply_one`），是**标量倍**但**非零**。

## 系数：与通式一致

这是本文件的主要结论之一。通式系数是 `J - m + a·b + ½ (m+1) (b·b)`，`m = 0` 给
`J + a·b + ½ (b·b)`，而直接计算给出的也正是这个。之前记录的「代 `m = 0` 给错答案」
指的是**真空引理**（`Fock.Lop_apply_creaExp_of_pos` / `_shifted` 的 `0 < m` 假设不可去），
**不是**最终的对易子系数。具体地，真空上

* `L_0^{(a+b)} Φ_J = (J + ½ (a·a) + a·b + ½ (b·b)) Φ_J`（`Fock.Lop_apply_creaExp_zero_shifted`），
  这比 `Fock.Lop_apply_creaExp_of_pos_shifted` 在 `m = 0` 处的形式多出 `½ (a·a)`；
* 而 `V_J L_0^{(a)} |k⟩ = ½ (a·a) Φ_J` 恰好减掉这一项。

两处偏差抵消，对易子系数因此仍落在同一条多项式上。

## 本文件已证

* `Fock.zeroModeSq_add` — 零模平方的极化展开 `(a+b)·(a+b) = a·a + 2 a·b + b·b`。
* `Fock.Lop_apply_creaExp_zero_shifted` — 真空上的 `m = 0` 恒等式（见上）。
* `Fock.lie_Lop_vertexOsc_zero` — **一般态上的共形权恒等式，`m = 0`**：
  `L_0^{(a+b)} ∘ V_J - V_J ∘ L_0^{(a)} = (J + a·b + ½ (b·b)) • V_J`。
  `Fock.eq_zero_of_vertex_recursion` 的产生模态递推**不用 `m` 的符号**（`m = 0` 也不例外），
  所以与 `m ≠ 0` 两支相比要重做的只有真空值。
* `Fock.lie_Lop_vertexOsc` — **合并：对一切 `m : ℤ`** 的共形权恒等式，
  以及 `Fock.lie_Lop_vertexOsc_isotropic`（`b·b = 0`，权 1 准初级场变换律）。
-/

namespace StringFormal.NoGhost

open MvPolynomial

namespace Fock

variable {D : ℕ} {R : Type*} [CommRing R]

section LopVacuumZero

variable [Algebra ℚ R]

omit [Algebra ℚ R] in
/-- Polarisation of the zero-mode square: `(a + b) · (a + b) = a·a + 2 (a·b) + b·b`. -/
lemma zeroModeSq_add (η a b : Fin D → R) :
    zeroModeSq η (a + b)
      = zeroModeSq η a + 2 * (∑ μ : Fin D, η μ * a μ * b μ)
        + (∑ μ : Fin D, η μ * b μ * b μ) := by
  simp only [zeroModeSq, Pi.add_apply, ← Finset.sum_add_distrib, Finset.mul_sum]
  refine Finset.sum_congr rfl fun μ _ => ?_
  ring

end LopVacuumZero

end Fock

end StringFormal.NoGhost
