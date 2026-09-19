# Φ₁₀ 墙穿越留数公式核实备忘

- 任务：闭合 `graph/statements/holography/phi10-wall-crossing-poles-v2.yaml` 内部矛盾
- 执行者：researcher agent
- 日期：2026-09-20
- 状态：**已闭合**

## 问题陈述

卡片 v2 的 (a) 正确写了**二阶极点**（`Div(Φ₁₀)=2H₁`），但 (b) 仍写着形如 `Res (1/Φ₁₀) = f·g` 的**单乘积形式**——这是简单极点的留数写法，两者互相矛盾。

## 核心发现

### 1. Φ₁₀ 的零点阶数：**确认为二重零点**（三条独立证据）

**证据 A（数学）**：Sen 2008 (arXiv:0708.1270v4) Appendix C，(C.25)/(C.26)，pp.162：
- 原文逐字：`Φ̂(ρ,σ,v) = −4π² v² g(ρ)g(σ) + O(v⁴)` … (C.25)
- 原文逐字：`Φ̃(ρ,σ,v) = −4π² v² f₁(Nρ)f₂(σ/N) + O(v⁴)` … (C.26)
- **判定**：在 v=0（即 Humbert 面 H₁={z₂=0}）附近，Φ̂ 与 Φ̃（N=1 时即标准 Φ₁₀）展开的首项是 **v² 阶**，系数非零 ⇒ **二重零点**。

**证据 B（数学）**：Gritsenko-Nikulin 1996 的 `Div(Φ₁₀)=2H₁`（已在项目 `literature/extractions/gritsenko-nikulin-1996-phi10.md` 中抽取）。

**证据 C（对偶性）**：Sen 2008 (C.1) 定义 Ω=(ρ v; v σ)，v 对应 Humbert 坐标 z₂（矩阵反对角元），与 GN1996 的 Z=(z₁ z₂; z₂ z₃) 记号同构 ⇒ 物理推导与代数几何结论**在局部完全一致**。

### 2. 墙穿越跳变公式：**线性正比于 Q·P**（Sen 2007 明确给出）

**DVV 1997 §4（pp.8-12）**：
- 原文 (3.10)：`d(qₑ,qₘ) = ∮ dρdσdv e^{iπ(q²ₘρ+q²ₑσ+2qₑ·qₘv)} / Φ(ρ,σ,v)`
- **未明确给出留数的因子化形式**，只说"zeros lead to poles in the integrand" (p.5)。

**Sen 2007（arXiv:hep-th/0702141）摘要 + §1-§3**：
- 摘要逐字："the spectrum of quarter BPS dyons … can change as the asymptotic moduli cross walls of marginal stability … We argue that … **the change in the degeneracy** … in the limit of large charges the change in the degeneracy is exponentially suppressed…"
- **关键**：Sen 2007 讨论的是**跨墙的跳变 Δd**，而非单个留数的显式形式。

**Sen 2007 §2（p.6）+ 项目现有抽取记录**：
- `literature/extractions/sen-2007-wall-crossing.md` E1 转述：
  `Δd(m,n,l) = (−1)^{Q·P+1} (Q·P) · d_{1/2}(Q²/2) · d_{1/2}(P²/2)`
- **判定**：跳变公式**线性含 Q·P 因子**——这正是**二阶极点留数对参数求导产生的线性项**。

### 3. 二阶极点留数的数学结构（从跳变公式反推）

对 `1/(w²h(w))` 型二阶极点（w=0 处 h(0)≠0），配指数核 `e^{−2πi·l·w}` 做围道积分，留数公式为：
```
Res = d/dw [e^{−2πi·l·w} / h(w)]|_{w=0} 
    = [−2πi·l / h(0)] − [h'(0) / h(0)²]
    = [−2πi·l·f(0)] − g(0)  （其中 f=1/h，g 含导数项）
```

**在 Φ₁₀ 情形**：
- w ↔ v（或一般的 mρ+nσ+lv 方向）
- l ↔ Q·P
- **Q·P 的线性出现是二阶极点的直接后果**

### 4. 文献未给出的内容（诚实记录）

**DVV 1997 与 Sen 2007 两篇都没有逐字写出"(b) 在二阶极点下的留数因子化闭式"**：
- DVV (3.10) 给出围道积分公式，但未展开留数项
- Sen 2007 给出**最终跳变 Δd** = 两个半-BPS 指标之积 × (Q·P) 因子，但**没有给出"单个围道贡献的中间留数表达式"**

⇒ 文献只支撑**跳变的结果形式**，不支撑**单个留数的因子化中间步骤**。

## 裁决

### 对问题 1-4 的回答

**Q1**：DVV §4 与 Sen 2007 的跳变公式逐字是什么？
- **DVV (3.10)**：`d(qₑ,qₘ) = ∮ dρdσdv e^{iπ(...)} / Φ(ρ,σ,v)`（围道积分，p.11）
- **Sen 2007 E1（转述）**：`Δd = (−1)^{Q·P+1} (Q·P) · d₁/₂(Q²/2) · d₁/₂(P²/2)`
- **判定**：Sen 给出的是**跳变公式**，DVV 给出的是**生成函数**；两者都**不直接等于留数的显式因子化**。

**Q2**：原文是否含导数项 / 线性 Q·P 因子？
- **是**：Sen 2007 的 Δd 公式**线性正比于 Q·P**，这是二阶极点留数求导产生的特征。

**Q3**：(b) 在二阶极点下的正确闭式？
- **文献不支持任何闭式**：DVV 与 Sen 都没有给出"单个留数的中间因子化表达式"，只给出**最终物理跳变**。
- **建议**：将 (b) 拆成独立的 `status: open` 节点，标注"留数因子化的中间步骤在 DVV/Sen 原文中未明确给出，只有最终跳变公式"。

**Q4**：极点位于 Sp(4,ℤ)-轨道的完整性？
- **部分支撑，但不足以判定**：
  - Sen 2008 Appendix D (D.1)-(D.19) 给出**完整参数化**：零点由满足 `4m₁n₁+4m₂n₂+j²=1` 的整数五元组标记
  - 但**原文未明说"取一个本原向量的 Sp(4,ℤ)-轨道覆盖全部零点"**——这一步仍需数学证明
  - **仍未找到**对本原向量轨道传递性的逐字陈述

## 最终建议

**给 lead / curator 的图节点修改建议**：

1. **保留 (a)**："Φ₁₀ 在 {mρ+nσ+lv≡0 (mod ℤ)} 处有**二阶极点**"（已有三条独立证据支撑）

2. **拆分 (b)**：
   - 新建节点 `holography.dvv-wall-crossing-jump`：
     ```
     statement: 1/4-BPS dyon 指标跨墙跳变为 Δd = (−1)^{Q·P+1} (Q·P) · d₁/₂(Q²/2) · d₁/₂(P²/2)
     status: physical-argument
     sources: [{ref: sen-2007-wall-crossing, loc: "§2-§3, E1"}]
     depends_on: [phi10-wall-crossing-poles-v2, dvv-generating-function]
     ```
   - 原 (b) 改为：
     ```
     statement: 1/Φ₁₀ 在二阶极点的留数可因子化为两个半-BPS 生成函数的乘积（含导数项）
     status: open
     note: "DVV 1997 与 Sen 2007 给出最终跳变公式（含线性 Q·P 因子），但未明确给出单个留数的中间因子化表达式。该因子化是物理图像（留数=两个半-BPS 子系统的乘积）的数学实现，留作后续工作。"
     ```

3. **添加交叉引用**：在 `dvv-wall-crossing-identification` 的 notes 里写明"该节点的 `(Q·P)` 线性因子来自 Φ₁₀ 二阶极点留数的导数项，与 Sen 2008 (C.25)/(C.26) 的 v² 展开一致"。

## 文献获取路径（供复核）

- DVV 1997：arXiv:hep-th/9607026，已下载至 worktree，读 pp.1-12
- Sen 2007：arXiv:hep-th/0702141，已下载至 worktree，读 pp.1-8
- Sen 2008：arXiv:0708.1270v4，已有完整抽取记录 `sen-2008-precision-counting.md`（S1-S9），(C.25)/(C.26) 逐字核对

