# claim: GAP 10.2b Route A — attractor 围道避开 Φ₁₀ 零点（Sen D.19 参数化）

本文件是原创证明尝试的**目标命题**。对应 `research/attempts/torsion-immortal-positivity-hecke/proof.md`
§10.5.4 "Route A（围道搬运）" 段落所称的缺失砖块：*Φ₁₀ 零点分布的定量信息*，
以及 [GAP 10.5.a]/[GAP 10.5.b] 所需的"n≥m ⟹ 不跨 ρ-极点"。

---

## 0. 记号（与上游 attempt 及文献抽取记录一致）

- Siegel 上半空间元素 Ω=(ρ,v;v,σ)（Rosselló/GN1996 约定，与
  `research/attempts/torsion-immortal-positivity-hecke/claim.md` §1.1 一致）。
- Φ₁₀：Sp(4,ℤ) 权 10 Igusa 尖点形式。
- T := [[m,ℓ/2],[ℓ/2,n]]，Δ := 4mn−ℓ² = det(2T)。
- attractor 围道（`torsion-immortal-positivity-hecke/claim.md` (R5)）的虚部部分：
  Im ρ = 2nΛ，Im σ = 2mΛ，Im v = εℓΛ（ε=±1 为符号约定；上游用 ε=−1，
  本任务委托书用 ε=+1；因 **Φ₁₀(ρ,σ,−v)=Φ₁₀(ρ,σ,v)**（v-偶性，见
  `torsion-immortal-positivity-hecke/claim.md` §3 条目 2，经典 Igusa 1962/GN 结果），
  两个约定给出的"零点除子"完全相同，本文件统一取 **ε=+1**，即
  ```
  Im ρ = 2nΛ,  Im σ = 2mΛ,  Im v = ℓΛ.
  ```
  实部 (ρ₁,σ₁,v₁) 遍历闭方体 [0,1]³（Rosselló (R5) 的傅里叶围道，闭区间，
  两端点 0,1 在环面上重合）。

- **Sen 2008 (arXiv:0708.1270v4) Appendix D, eq. (D.19)**（逐字核对，见 proof.md §1；
  本任务此前抽取记录 `literature/extractions/sen-2008-precision-counting.md` §S7
  只给出摘要，本次通过 WebFetch+Read 工具重新下载 PDF 并逐页读取 pp.164-169 完成
  逐字核对，见 proof.md §1 的核对记录）：对 N=1（K3，标准 Φ₁₀ 情形），

  > Div(Φ₁₀) = ⋃ 2·{(ρ,σ,v) : n₂(σρ−v²) + jv + n₁σ − m₁ρ + m₂ = 0}

  其中并集取遍所有整数五元组 (m₁,n₁,m₂,n₂,j)，j 为奇数，满足判别式条件

  > 4m₁n₁ + 4m₂n₂ + j² = 1.

  每个分支的重数为 2（与 GN1996 Div(Φ₁₀)=2H₁ 的重数结构一致，交叉验证见 proof.md §1.3）。

---

## 1. 委托书原始目标命题（as commissioned）

> **命题（原始）**：对任意整数 n≥m≥1、0≤ℓ≤m、Δ=4mn−ℓ²>0，存在 Λ₀=Λ₀(m,n,ℓ) 使得
> ∀Λ>Λ₀，attractor 围道 {(ρ,σ,v) : Im ρ=2nΛ, Im σ=2mΛ, Im v=ℓΛ, (ρ₁,σ₁,v₁)∈[0,1]³}
> 与 Div(Φ₁₀) 不相交。

**本证明的结论（诚实前置摘要，详见 proof.md）**：此命题**在 ℓ=0 处不成立**——
proof.md §3 给出显式反例：ℓ=0 时围道恒过 v=0（对**任意** Λ），而 v=0 是 Φ₁₀ 的零点
（GN1996 Div(Φ₁₀)⊇2{v=0}）。故原始命题需**改为 0<ℓ≤m**（下述命题 A），
ℓ=0 的情形需要独立处理（不在本次任务范围内，proof.md §3.3 留 [GAP]）。

## 2. 修正后命题 A（本次尝试实际证明目标）

> 对任意整数 n≥m≥1、**0<ℓ≤m**、Δ=4mn−ℓ²>0，存在 Λ₀=Λ₀(m,n,ℓ) 使得 ∀Λ>Λ₀，
> 上述 attractor 围道与 Div(Φ₁₀) 不相交。

**证明状态（诚实摘要，详见 proof.md）**：
- n₂=0 分支（"线性壁"，对应 GN1996 H₁ 的 SL(2,ℤ) 像 + v-平移）：**完全证明**对
  ℓ 为奇数的情形（宇称论证）；对 ℓ 为偶数、ℓ>0 的情形，证明搜索范围**归约为有限**
  （|j| ≤ 2√(mn/Δ)），且 **j=±1 严格排除**；j=±3,±5,... 的排除留 [GAP]（有限、
  可数值枚举，但未给出一般 j 的解析排除论证）。
- n₂≠0 分支（"二次壁"）：建立了 Ω 代入后 Re(F)、Im(F) 的**精确**（非渐近）分解，
  给出必要的增长阶估计（(A) 式），并给出一个"移位技巧"部分论证，但**未完成**
  对所有 (n,m,ℓ) 一致的 Λ₀ 的构造——留 [GAP]，详见 proof.md §4。

---

## 3. 允许使用的砖块

1. Sen 2008 Appendix D eq. (D.19)（本任务逐字核对，物理文献的数学陈述，见上）。
2. Sen 2008 Appendix C eq. (C.1)-(C.32)（同一文献，用于确认 Φ̃ 在 N=1 情形与标准
   Φ₁₀ 的等同，及 v→0 处二重零点系数非零的经典乘积公式结构）。
3. GN1996（`literature/extractions/gritsenko-nikulin-1996-phi10.md`）：Div(Φ₁₀)=2H₁，
   H₁={z₂=0}=({v=0} 在本文件坐标下)，用于交叉验证 D.19 在 n₁=n₂=m₁=0,j=1,m₂=0
   分支的退化情形。
4. Φ₁₀ 的 v-偶性 Φ₁₀(ρ,σ,−v)=Φ₁₀(ρ,σ,v)（经典 Igusa 1962 事实，
   `torsion-immortal-positivity-hecke/claim.md` §3 已列为允许砖块）。

**不使用**：任何 conjecture/physical-argument 状态的图节点（本证明尝试独立于图，
所引用文献均作为陈述本身的数学内容使用，不作为"已验证图节点"引用）。

---

## 4. 与上游 attempt 的关系

本尝试若能完全闭合命题 A（含 [GAP] 部分），可为
`torsion-immortal-positivity-hecke/proof.md` §10.5 的 [GAP 10.5.a]/[GAP 10.5.b]
提供**部分**支持：n₂=0 情形关闭对应 GN1996 型"线性壁"不被跨越；n₂≠0 情形
（未完全关闭）对应"二次壁"，是 Route A 障碍的真正核心，本次未完全解决。
即使命题 A 完全证明，**仍不能直接推出** Theorem 10.5（[GAP 10.5.a] 要求的是
FJ 级数收敛性，"围道避开零点"只是该收敛性论证的**必要**几何前提，不是其
充分条件——proof.md §5 讨论此点）。
