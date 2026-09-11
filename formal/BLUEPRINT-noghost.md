# 无鬼定理（Goddard–Thorn）剩余部分的 Lean 蓝图

对应图节点 `worldsheet.no-ghost-theorem-v4`、推导 `worldsheet.no-ghost-theorem-v4--via-goddard-thorn`、
里程碑 `ms.no-ghost-theorem`；对应 `formal/TODO.md` 的 `ddf-spans` 与 `no_ghost_theorem` 两项。

**本文件是规划文档，不是 Lean 源码。** 下面所有代码块都是**签名草案**：没有编译过，命名和
隐式参数一定要在真正写文件时再调。它的用途是把「无鬼定理 v4 变成 Lean 定理」剩下的部分
拆成有依赖顺序的、每条都能单独立项的引理，并对每条给出：依赖的**现有**声明名、预估难度、
Mathlib 缺什么。

写这份蓝图时的三条判断（详见 §D「对图的建议」）：

1. **纵向算子这一节几乎是白送的**。Goddard 2008 §6 (6.2)(6.3) 真正用的纵向对象是
   `K_m = k_0 · α_m`，不是 Brower 的 `A^L_n = Ã_n + F_n`。而 `K_m` 在本仓库里就是
   `towerModeVec η a b b m`（偏振取 `ε := b` 自身），它的全部代数关系都是现有引理在
   `ε := b` 处的特例——因为类光条件 `dotVec η b b = 0` 恰好就是 `b` 对自己的横向性。
   Brower 的 `A^L_n` 代价极大且**不在关键路径上**（见 §A.3）。
2. **D = 26 不在你以为的地方进来**。它**不**在特征标/计数里（`φ(q)^{-D} = φ(q)^{-1}φ(q)^{-1}φ(q)^{-(D-2)}`
   对任意 `D` 成立），也不在 DDF 代数、伴随关系、横向 Gram 正定里（这些对任意 `D ≥ 3`
   与任意 ℚ-代数成立）。它只在**「H_phys 中 DDF 之外的部分是零模态」**这一步进来，
   数值见证已经在 `LevelTwo.lean`：`⟨ψ₂,ψ₂⟩ = -2(D-26)(D-1)/25`。
3. **`ddf-spans` 的两条候选路线里，FGZ Prop 2.6(i) 那条在 Lean 里是死路**（卡在一般 `N`
   的 Kac 行列式，本仓库只到 `N ≤ 4`）；GT 原始的计数路线可行但真正的成本不是计数，
   而是**幺三角基变换**。详见 §B。

---

## 0. 现状与记号

### 0.1 已有的对象（全部无 sorry，公理只有标准三条）

命名空间：`towerLop`、`towerMode`、`towerModeVec`、`towerVertex`、`ddfOp`、
`towerPhysSubmodule` 等在 `StringFormal.NoGhost` 下；`Fock.towerPairing`、
`Fock.pairing`、`Fock.physSubmodule` 等在 `StringFormal.NoGhost.Fock` 下。

```lean
variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]
variable (η a b ε : Fin D → R)
```

四个几何假设（全线程共用，下面一律沿用这些名字）：

| Lean | 物理 |
|---|---|
| `hη : ∀ μ, η μ * η μ = 1` | 对角度规，`η_{μμ} = η^{μμ}`（`conv.metric-mostly-plus`） |
| `hbb : dotVec η b b = 0` | `k_0² = 0`，类光参考方向 |
| `hba : dotVec η b a = 1` | `2α' k_0 · k = 1`，DDF 归一化 |
| `hεb : dotVec η ε b = 0` | `ε · k_0 = 0`，横向性 |

关键既有声明（本蓝图反复引用）：

* 塔与算子：`TowerFock D R = ℤ →₀ Fock D R`、`towerMomentum a b j = a + j•b`、
  `towerShift`、`towerMode`、`towerLop`、`towerVertex`、`towerModeVec η a b ε p`（= `α^ε_p`）。
* `ddfOp η a b ε hη hεb n : Module.End R (TowerFock D R)`（= `A^ε_n`），`ddfOp_apply`（任意够大窗口）。
* `lie_towerLop_ddfOp`（`⁅L_m, A^ε_n⁆ = 0`，**一切 `m : ℤ`**，`DDFOperatorAll.lean`）。
* `ddfOp_mem_towerPhysSubmodule`（`A^ε_n` 保持塔上物理子空间，`DDFOperatorAll.lean`）。
* `lie_ddfOp_ddfOp`（`⁅A^ε_m, A^δ_n⁆ = m (ε·δ) δ_{m+n,0}`，`DDFAlgebra.lean`）。
* `Fock.towerPairing_ddfOp_left`（`(A^ε_n)† = A^ε_{-n}`，`VertexAdjoint.lean`）。
* `Fock.towerPairing`、`Fock.towerPairing_comm`、`Fock.towerPairing_towerLop_left`
  （`L_m† = L_{-m}` 塔上版）、`Fock.towerPairing_towerModeVec_left`（`(α^ε_p)† = α^ε_{-p}` 塔上版）。
* `towerPhysSubmodule η a b a₀ = towerL0Submodule ⊓ towerPositiveModeSubmodule`（`TowerPhysical.lean`）。
* 单 Fock 侧：`Fock.physSubmodule`、`Fock.spuriousSubmodule`、`Fock.nullSubmodule`、
  `Fock.orthComplement`、`Fock.spuriousSubmodule_le_orthComplement`、
  `Fock.quotientPairing` / `Fock.quotientPairing_mk`（`QuotientForm.lean`）、
  `Fock.spuriousShell` / `Fock.nullStates`（`SpuriousShell.lean`）。
* Gram：`Fock.creationMonomial`、`Fock.monomialNorm`、
  `Fock.pairing_creationMonomial_of_hypotheses`（(H1)–(H4) 的条件版）、
  `Fock.pairing_self_pos_of_ne_zero`（`η > 0` 时正定）、`Fock.linearIndependent_creationMonomial`。
* 线性代数与组合：`StringFormal.linearIndependent_of_gram_det_ne_zero`
  （`Virasoro/GenericIndependence.lean`，任意交换整环、任意双线性型）、
  `StringFormal.partitionGF` 与 `partitionGF_mul_tprod_one_sub_X_pow`（`Math/EulerPartition.lean`）。

### 0.2 还**没有**的对象（后面要建的基础设施）

* 塔上的**伪态 / 零模态 / 正交补 / 商形式**：单 Fock 版在 `PhysicalStates.lean` +
  `QuotientForm.lean`，塔上一个都没有。**连无鬼定理的陈述都写不出来。** 见 §C.1。
* 塔上的**分级**（按「层 + 振子 level」）与塔上的**真空** `|k⟩ = single 0 1`：没有。见 §B.1。
* 纵向算子 `K_m`：没有（但基本白送，见 §A）。
* DDF 态张成的子模 `ddfSpan`：没有。见 §B.2。
* **四个几何假设的可满足性见证**：整个 DDF 岛的每条定理都是条件命题，
  而仓库里**没有任何一条**证明存在 `(η, a, b, ε)` 同时满足 `hη ∧ hbb ∧ hba ∧ hεb`
  且横向 Gram 正定。见 §C.2——这是一个廉价但必须补的窟窿。

### 0.3 本蓝图**不**处理的

* 无鬼定理 v4 第 (2) 条（`D > 26` 有负模物理态）：已由 `LevelTwo.lean` 的
  `Fock.exists_mem_physSubmodule_pairing_self_neg'` 机器验证，走的是 level-2 显式试探态，
  不是推导 summary 里的纵向算子构造。本蓝图只做第 (1) 条。
* Hermite / sesquilinear 结构：全线程是 `R`-双线性型。最终定理建议钉在有序域上
  （Mathlib v4.33.1 无 `LinearOrderedField`，写成 `[Field K] [LinearOrder K] [IsStrictOrderedRing K] [Algebra ℚ K]`），
  断言双线性型的半正定性。这是诚实的弱化，缺口已记在
  `worldsheet.ddf-operators-adjoint-v2--via-lean` 的 gaps。
* 完备化、连续动量本征态、`δ^D(p-p')` 归一化：图卡 `worldsheet.momentum-tower-fock-space`
  已声明层间正交是**定义规定**而非被证明，本蓝图沿用。
