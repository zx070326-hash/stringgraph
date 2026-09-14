# 抽取记录：bringmann-murthy-2012

- 文献：K. Bringmann, S. Murthy, "On the Positivity of Black Hole Degeneracies in String Theory," Commun. Number Theory Phys. 7 (2013) 15–56, arXiv:1208.3476
- 抽取者：lead (direct, 2026-09-14)
- 日期：2026-09-14
- 覆盖范围：摘要与引言（§1）、主定理陈述（§3–§4）；未完整通读全文，标注待核处

## 约定

- N=4 弦论（type II on K3×T² 或等价的杂化 on T⁶），四维。
- 1/4-BPS 单心（immortal）dyon 的螺旋超迹 d(m,n,l)（= −B₆），由 DMZ 分解后的 mock Jacobi 部分系数给出。
- "positivity"指 d(m,n,l) > 0（作为整数）；注意这是有符号指标为正，文献中称此为"Kloosterman sum estimates give positivity"。
- Rademacher 圆法：将模形式系数表为 Kloosterman 和 × Bessel 函数的收敛级数。

## 陈述

### E1 一类 N=4 1/4-BPS 单心 dyon 指标的正性（主定理）
- 位置：§3–§4，主定理（具体定理编号待核）
- 类型：proposition
- 原文陈述（忠实转述）：对 type II on K3×T²（= 杂化 on T⁶，N=4 弦论）中，判别式 d = 4mn−l² 充分大且 gcd(m,n,l) = 1 的 1/4-BPS dyon（处于 immortal chamber），其 mock Jacobi 系数（即 DMZ 分解后的 φ_F 的傅里叶系数）d(m,n,l) > 0。
- 文献自称的严格程度："Theorem"；证明方法为 mock 模形式的圆法（Hardy-Ramanujan-Rademacher 展开）加上 Kloosterman 和估计（Deligne 型）；对"充分大"的判别式成立，有效界可以计算但文中可能未给出具体数值（待核）。
- 文献列出的依赖：DMZ 2012（分解定理，E1）；Zwegers 2002（mock 调和 Maass 框架）；Kloosterman 和的 Deligne 估计（Weil 猜想，数学定理）；Rademacher 收敛定理（圆法）。
- 备注：这是**严格数学定理（rigorous）**，依赖的数学工具（Kloosterman 估计、圆法）都是严格的；但"d(m,n,l) 是单心 dyon 指标"这一物理识别是 physical-argument（来自 DMZ 识别③）。图节点应将数学正性（rigorous）与物理识别（physical-argument）分开。

### E2 覆盖范围：N=8 和部分 CHL 模型
- 位置：引言，覆盖范围说明
- 类型：proposition（说明性）
- 原文陈述（忠实转述）：同样的方法适用于 N=8 弦论（type II on T⁶）以及若干 CHL（Chaudhuri-Hockney-Lykken）orbifold 模型的对应 mock 模形式系数；但对 N=4 的全部 1/4-BPS 指标（包含所有电荷格和全部大判别式范围）的完整证明在 2012 年尚未完成（N=4 旗舰情形由 Rosselló 2024 完成）。
- 文献自称的严格程度：定理（在适用范围内）；N=4 的完整情形明确说明为未证明。
- 文献列出的依赖：同 E1。
- 备注：本文覆盖"一类"情形，不是 N=4 全情形的完整证明。

## 未解决的疑问

1. "充分大的判别式"是否给出有效的数值界（使得所有小判别式情形可以有限计算机检验）？需核实 §4 的具体陈述。
2. Kloosterman 和估计所依赖的 Weil 猜想（Deligne 定理）是本文的核心输入；这本身已是数学定理，但引用链应在图节点的 depends_on 中写明。
3. 与 Rosselló 2024 的关系：本文处理 N=4 的一个子情形，Rosselló 处理完整 N=4 旗舰情形；图节点应同时引用并注明覆盖范围差异。

---

## 核实（researcher, task #17, 2026-09-14）

来源：Rosselló 2024（arXiv:2403.19630）引言与 Theorem 1 处对 [30]（=本文）的**直接引用**，
BM 摘要页 https://arxiv.org/abs/1208.3476 ，及 Murthy 综述 arXiv:2305.11732。上方 E1/E2 保留不动（审计痕迹）。

### 订正 C1 覆盖范围的准确刻画（重要）
- 初稿 E1/E2 及现有图节点把 BM 的覆盖范围写成"**判别式充分大**（Δ≫1）"。据一手核实，**这一刻画不准确**。
- Rosselló 2024 逐字陈述："**The cases m=1,2 of this theorem were proved in [30]**"，随后"so in this
  work we restrict ourselves to m≥3"。即 BM 证明的是 **mock Jacobi 形式指标 m=1、m=2 两个情形**
  （m = 磁荷不变量 P²/2 一类），而**对这两个 m 值覆盖全部判别式 Δ>0**（n≥m 全部 n），并非"只对充分大 Δ"。
- 分界线是**指标 m**，不是"判别式大小"：
  - BM 2012：m=1,2（此二值下全部 Δ>0，含小判别式）。
  - Rosselló 2024：m≥3（m=3,4,5 显式，m≥6 一般），补齐余下全部 m，从而 Corollary 覆盖所有 m,n≥1、Δ>0。
- 机理：Rademacher 展开里"最极端极态（most polar state）的非-mock 项"给出主导且恒正的贡献，远大于其余项之和；
  对 m=1,2 极系数已知，可对所有 n 完成定界。故"充分大 Δ 才为正"的说法对 m=1,2 并不成立——
  该说法是初稿凭一般印象所写，应予订正。

### E3 主结论（核实）
- 位置：摘要 + 正文定理（具体编号未从 BM PDF 独立 OCR 核到；PDF 为压缩流，未能提取正文文本）。
- 摘要逐字（分段）："Certain helicity trace indices of charged states in N=4 and N=8 superstring
  theory have been computed exactly … These indices are expected to count the exact quantum
  degeneracies of black holes … these indices should be positive integers. We prove this positivity
  property for a class of four/five dimensional black holes in type II string theory compactified on
  T^6/T^5 and on K3×T^2/S^1. The proof relies on the mock modular properties of the corresponding
  generating functions."
- 严格程度：Theorem（在所覆盖范围内）；方法为 mock 模形式 + 圆法（Rademacher 展开）+ Kloosterman 和估计，
  **纯解析数论，无物理前提**（物理仅为动机：指标应=黑洞简并度，故须为正）。
- 覆盖：N=4（K3×T²）的 m=1,2；N=8（T⁶）对应情形；不含完整 N=4（余下 m 由 Rosselló 2024 补齐）。

### 疑问解决
1.（原疑问1，"充分大 Δ"的有效数值界）**重新表述**：BM 的分界不是"Δ 是否够大"，而是指标 m∈{1,2}；
   在这两个 m 下对所有 Δ>0 成立，无需数值界。故原疑问 1 的前提（"小判别式需有限计算机检验"）不适用于 BM——
   小情形的空缺是"m≥3"，由 Rosselló 关闭。
2.（原疑问2，Weil/Deligne 依赖）Kloosterman 和的估计属标准解析数论工具，本身为数学定理；curator 转节点时可在
   depends_on 记明，但不影响 rigorous 定性。
3.（原疑问3，与 Rosselló 关系）见 C1：BM=m=1,2；Rosselló=m≥3，合并覆盖全部 Δ>0、gcd=1。
