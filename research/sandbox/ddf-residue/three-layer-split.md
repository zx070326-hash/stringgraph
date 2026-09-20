# DDF 围道积分的三层拆解

## 问题

`worldsheet.ddf-contour-equals-mode-sum` 断言：
```
(1/2πi)∮ ε·P(z) V(n k₀, z) dz = Σ_m α^ε_m V^{(n)}_m
```

左端是文献的围道积分写法（Goddard 2008 (5.1)），右端是 Lean 的 `ddfOp`（已 formalized）。

当前状态：整张卡 `effective: physical-argument`，压低整条无鬼定理链。

## 三层拆解

### Layer 1: 形式留数定义（trivial，定义级）

**Res_z A(z) = [z^{-1}] 系数**

- Schottenloher Def 10.1，定义
- 在任何形式 Laurent 级数环上都成立
- 不是待证的定理，是符号的意义

### Layer 2: 算子值级数的留数分配律（数学，可形式化）

**断言**：在横向性 `ε·k₀ = 0` 保证的局部有限条件下，
```
Res_z [A(z) · B(z)] = Σ_m A_m B_{-1-m}
```
其中 `A(z) = Σ_m A_m z^m`、`B(z) = Σ_K B_K z^K` 是塔上的算子值级数，
右端的和对每个向量只有有限项非零。

**来源**：
- Schottenloher Def 10.9（正规序积的模态卷积公式）
- Schottenloher Thm 10.10(N=0)（无奇异 → 普通积 = 正规序积）
- Bakalov-Kac (2.22)（零模 = 卷积和）
- GN (2.32) 正规性公理（场作用逐向量有限）

**现状**：
- `--via-voa-residue` 推导的 own status 是 `rigorous`（这些步骤严格）
- 但没有对应的 Lean 声明
- 局部有限性已 `formalized`（`ddfSummand_apply_eq_zero_of_notMem_window`）

**形式化可行性**：
- 不涉及任何物理记号解读
- 纯算子代数 + 形式级数
- 已有 `ddfOp_apply` 给出右端的显式公式
- 需要定义算子值级数的乘积并证明留数分配

### Layer 3: 文献记号的解读（解释性，不可形式化）

**断言**：Goddard (5.1) 写的 `(1/2πi)∮ P^i(z) V(nk,z) dz` 里的 `∮` 
应该读作形式留数 `Res_z`。

**状态**：
- 这是从物理文本到数学对象的翻译
- Goddard 2008 只写符号，不定义语义（是复积分还是形式留数）
- Lean 不能表达"文献里这个符号指称什么"
- 这是 1 比特的不可约信息

**为什么不可形式化**：
- Lean 定理的陈述是数学对象之间的关系
- "文献的符号 S 指称对象 O"不是 Lean 可表达的命题
- 这属于元理论（关于理论的理论）

## 拆解的价值

**当前**：一个 `physical-argument` 节点，外界看不出瓶颈在哪。

**拆解后**：
- Layer 2: `rigorous` 或 `formalized`（可验证的数学）
- Layer 3: `physical-argument`（明确标识为记号解读）
- **首次精确量化**："无鬼定理剩下的缺口里，多少是数学（可补），多少是解释（不可约）"

## 实施计划

### 图侧（立卡）

1. **新建** `worldsheet.ddf-residue-distribution`（Layer 2）
   - `kind: proposition`
   - 陈述算子值级数的留数分配律
   - 指向 Schottenloher / Bakalov-Kac 来源
   - 目标 `status: formalized`

2. **新建** `worldsheet.ddf-contour-interpretation`（Layer 3）
   - `kind: proposition`
   - 陈述"Goddard (5.1) 的 ∮ 应读作 Res_z"
   - `status: physical-argument`（诚实标记）
   - 指向 Goddard 2008 (5.1)

3. **修改** `worldsheet.ddf-contour-equals-mode-sum`
   - 添加依赖：Layer 2 + Layer 3
   - `effective` 会被 Layer 3 压到 `physical-argument`（预期中）
   - 但下游能看见是哪一层在压

### Lean 侧（形式化 Layer 2）

**不从零开始**。先读：
- `formal/StringFormal/NoGhost/DDFOperator.lean`（`ddfOp`、`ddfOp_apply`）
- `formal/StringFormal/NoGhost/VertexOperator.lean`（`Fock.vertexOsc`）
- `formal/StringFormal/NoGhost/DDF.lean`（`towerVertex`、`towerModeVec`）
- `formal/StringFormal/NoGhost/VertexProduct.lean`（可能有乘积相关）

**目标定理**（初步，读完现有代码后可能调整）：
```lean
-- 可能已有类似的东西
theorem ddfOp_as_residue (η : Fin D → R) (a b ε : Fin D → R) 
    (hη : ∀ μ, η μ * η μ = 1) (hεb : dotVec η ε b = 0) (n : ℤ) :
  ddfOp η a b ε hη hεb n = 
    -- 这里需要定义"算子值级数的 z^{-1} 系数"
    -- 可能形式就是 lsumLocFin，但要明确是"留数"语义
```

**技术要点**：
- 模态指标**不是**全局有限支撑（不用 `ℤ →₀`）
- 局部有限性已有（`ddfSummand_apply_eq_zero_of_notMem_window`）
- 可能不需要新类型，直接用 `ℤ → Module.End R M` 即可

## 结论

这个拆解不是逃避问题，而是精确定位问题：
- Layer 2 是可验证数学，应该且能够形式化
- Layer 3 是不可约解释，诚实标记即可
- 当前把它们混在一起，既让可做的部分没人做，又让不可约的部分说不清

拆解本身就是对"一个物理定理的认识论结构"的首次量化。
