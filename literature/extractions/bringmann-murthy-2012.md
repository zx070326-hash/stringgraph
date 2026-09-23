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

---

## 追加抽取（researcher, 2026-09-23, 附录 A 数值表 — L1 逐页图核对）

- 抽取者：researcher agent（分支 `agent/researcher/arxiv-2510-05219`，本轮次要目标）
- 可信度分级：**L1**（官方 PDF 原件 + `pdftoppm -r 220` 渲染页图 + PIL 局部放大后逐位读数）
- 取件方式：`curl -sL https://arxiv.org/pdf/1208.3476`，30 页；PDF 页码 = 印刷页码（页眉/页脚数字核对一致）。
  `pdftotext` **仅**用于定位页码与做否定性搜索，所有落地数字均以页图为准。
- 说明：本文件上方 2026-09-14 核实段记"PDF 为压缩流，未能提取正文文本"。**本轮已取得全文并渲染页图**，
  该限制不再成立。上方 E1–E3 与 C1 全部保留不动。

### E4 附录 A：m = 1,2,3,4 的黑洞简并度数值表
- 位置：Appendix A "Black hole degeneracies for m = 1, 2, 3, 4"，印刷页 28–29（= PDF 页 28–29）。
- 类型：数值表（definition / data）
- 原文引言逐字（p.28，表格上方整段）：
  > "For the black holes in string theory on K3 × T², the degeneracies are a function of the
  > T-duality invariants (M²/2, N²/2, M·N) = (m, n, ℓ). As explained in §3, they are the Fourier
  > coefficient c(n, ℓ) of the mock Jacobi form ψ_m of index m for n ≥ m. By the elliptic invariance,
  > it is enough to consider ℓ = 0, ..., m + 1. We list the first few coefficients of the mock Jacobi
  > forms ψ_m for the first four positive values of m."
- 逐字表格数据（只录本轮用到的部分，均经页图放大逐位核对）：

  **m = 1**（p.28，第一张表，列 n = −1, 0, 1, 2, 3, 4, 5, 6）

  | ℓ | n=−1 | n=0 | n=1 | n=2 | n=3 | n=4 | n=5 | n=6 |
  |---|---|---|---|---|---|---|---|---|
  | 0 | −48 | 648 | **50064** | 1127472 | 16491600 | **185738352** | 1737283968 | 14086119024 |
  | 1 | 3 | 600 | 25353 | 561576 | 8533821 | 100390104 | 977183520 | 8203464720 |

  **m = 2**（p.28，列 n = −1, 0, 1, 2, 3, 4, 5）

  | ℓ | n=−1 | n=0 | n=1 | n=2 | n=3 | n=4 | n=5 |
  |---|---|---|---|---|---|---|---|
  | 0 | −648 | 12800 | 1127472 | **32861184** | **632078672** | **9337042944** | **113477152800** |
  | 1 | 72 | 8376 | 561576 | 18458000 | 392427528 | 6216536784 | 79330416536 |
  | 2 | −4 | −1152 | 50064 | 3859456 | 110910300 | 2073849984 | 29495727056 |

  **m = 3**（p.28，列 n = −1, 0, 1, 2, 3, 4）

  | ℓ | n=−1 | n=0 | n=1 | n=2 | n=3 | n=4 |
  |---|---|---|---|---|---|---|
  | 0 | −6404 | 153900 | 16491600 | **632078672** | 16193130552 | 315614079072 |
  | 1 | 972 | 85176 | 8533821 | 392427528 | 11232685725 | 233641003920 |
  | 2 | −96 | −15600 | 1127472 | 110910300 | 4173501828 | 100673013264 |
  | 3 | 5 | 1728 | 130329 | 18458000 | 920577636 | 26563753008 |

  **m = 4**（p.29，第一张表，列 n = −1, 0, 1, 2, 3, 4）

  | ℓ | n=−1 | n=0 | n=1 | n=2 | n=3 | n=4 |
  |---|---|---|---|---|---|---|
  | 0 | −51396 | 1410048 | **185738352** | **9337042944** | 315614079072 | **7999169992704** |
  | 1 | 9600 | 700776 | 100390104 | 6216536784 | 233641003920 | 6264458136216 |
  | 2 | −1296 | −154752 | 16491600 | 2073849984 | 100673013264 | 3093523125120 |
  | 3 | 120 | 23328 | 1598376 | 392427528 | 26563753008 | 987647838816 |
  | 4 | −6 | −2304 | −209304 | 32861184 | 4173501828 | 203003283456 |

  m=4 第二张表（p.29）ℓ=0 行：n=5 → 161166049715136，n=6 → 2690630398144512，
  n=7 → 38396325233501604，**n=8 → 479643192755712000**。

- 文献自称的严格程度：数值表，无证明；是正文定理所讨论对象的显式系数列表。
- 文献列出的依赖：§3（ψ_m^F 的定义与单心识别），引用 [17]（= Dabholkar–Murthy–Zagier）。
- 备注：`pdftotext -layout` 会把 m=1/2/3 的表头行与数据行错位重排，**不可直接采信**；上表是页图读数。

### E5 单心识别与符号关系（§3，印刷页 11）
- 位置：§3，印刷页 11 = PDF 页 11，"The single-centered black hole degeneracies are found by…" 整段。
- 类型：definition + proposition（引用他人结果）
- 原文逐字（页图核对）：
  > "The single-centered black hole degeneracies are found by subtracting the polar part from the
  > original meromorphic Jacobi form ψ_m. The two functions ψ_m and ψ_m^P have, by construction,
  > the same poles and residues, so the difference is holomorphic in z, and has an unambiguous
  > Fourier expansion. The finite or Fourier part of ψ_m
  >
  >     ψ_m^F := ψ_m − ψ_m^P ,
  >
  > is a mock Jacobi form of index m. It was shown in [17] that the indexed degeneracies of the
  > single centered black hole of magnetic charge invariant N²/2 = m, as defined by the attractor
  > mechanism, are Fourier coefficients of the function ψ_m^F. More precisely, we have that the
  > microscopic indexed degeneracies d_micro(n, r, m) corresponding to the single-centered black holes
  > are related to the Fourier coefficients of this function ψ_m^F = Σ_{n,r} c(n, r) qⁿ ζ^r, as
  > d_micro(n, r, m) = (−1)^{r+1} c(n, r), the overall sign coming from an analysis of the fermion zero
  > modes described in the introduction."
- 文献自称的严格程度：单心识别明确归于 [17]（DMZ），非本文证明；本文只做正性分析。
- 文献列出的依赖：[17] = Dabholkar–Murthy–Zagier。
- 备注（**抽取者判读，不是文献自述**）：E4 附录 A 的表格印的应当是 d_micro，不是裸 c(n,r)——
  附录引言写作"they are the Fourier coefficient c(n, ℓ)"，与此处 (−1)^{r+1} 的符号因子不一致。
  判据：ℓ=0 时 (−1)^{0+1} = −1，若表格印的是 c，则 ℓ=0 行的 d_micro 全为负，与本文正性定理直接矛盾。
  curator 引用时应标 `inferred`。

### E6 本轮核对目标：`research/papers/torsion-dyon-shift-positivity/paper.md` §3 的五个基准值
（背景：该论文 `NOTES-for-captain.md` §4.4 记录"五个基准简并度在 1/4-BPS 文献中流传，但本项目未能核到可引用的表格出处"。）

| paper.md §3 的写法 | (Q²,P²,Q·P) | 本文附录 A 的位置 | 数值 | 裁定 |
|---|---|---|---|---|
| d_*(1,1,0) = 50064 | (2,2,0) | m=1 表，ℓ=0，n=1 | 50064 | **SUPPORT** |
| d_*(2,2,0) = 32861184 | (4,4,0) | m=2 表，ℓ=0，n=2 | 32861184 | **SUPPORT** |
| d_*(3,2,0) = 632078672 | (6,4,0) | m=3 表 ℓ=0 n=2，并 m=2 表 ℓ=0 n=3 | 632078672 | **SUPPORT**（双重出现，互为交叉验证） |
| d_*(4,2,0) = 9337042944 | (8,4,0) | m=4 表 ℓ=0 n=2，并 m=2 表 ℓ=0 n=4 | 9337042944 | **SUPPORT**（双重出现） |
| d_*(5,2,0) = 113477152800 | (10,4,0) | m=2 表，ℓ=0，n=5 | 113477152800 | **SUPPORT** |

五个值与电荷三元组全部逐位吻合，且 m↔n 对称性在表内自洽（(2,3)/(3,2) 与 (2,4)/(4,2) 两对各自在两张
不同的表里给出同一个整数，这是表格内部的独立一致性检验）。**本文是本轮找到的唯一一份同时覆盖全部五个值的
已发表表格**（Sen 的两张表各只覆盖其中三个，见 `sen-2008-precision-counting.md` 与
`sen-2011-siegel-sign.md`）。

附带（**不在 §4.4 的问题范围内，本轮顺手核到**）：paper.md §6 三个 D₂ 展示式的每一个被加数都在本附录中：

| paper.md 行 | 展开式 | 本文提供的被加数 | 算得 | paper.md 印的 |
|---|---|---|---|---|
| 306 | D₂(4,4,0) = d_*(4,4,0) + 2·d_*(1,4,0) | 7999169992704 (m=4,ℓ=0,n=4) + 2×185738352 (m=1,ℓ=0,n=4) | 7999541469408 | 7999541469408 ✅ |
| 307 | D₂(8,4,8) = d_*(8,4,8) + 2·d_*(2,4,4) | 7999169992704 + 2×32861184 | 7999235715072 | 7999235715072 ✅ |
| 314 | D₂(8,4,0) = d_*(8,4,0) + 2·d_*(2,4,0) | 479643192755712000 (m=4,ℓ=0,n=8) + 2×9337042944 | 479643211429797888 | 479643211429797888 ✅ |

第 307 行还用到 d_*(8,4,8) = d_*(4,4,0) 与 d_*(2,4,4) = d_*(2,2,0) 两个 GL(2,ℤ) 类等式
（[[8,4],[4,4]] ~ [[4,0],[0,4]]，[[2,2],[2,4]] ~ [[2,0],[0,2]]，各由一个初等幺模变换实现），
即 paper.md 自己的 Appendix A Prop A.1。**Prop A.1 本身不在本文中**：本文只给数值，不给该不变性命题。

## 追加的未解决疑问

4. 附录 A 引言的"c(n, ℓ)"与 §3 的 d_micro = (−1)^{r+1} c(n, r) 在 ℓ=0 时符号相反（见 E5 备注）。
   本文未自述这一点，也未出勘误。
5. 附录引言写"for n ≥ m"，但表格列出了 n = −1 起的全部列。本轮用到的五个基准值中，
   (m,n) = (1,1), (2,2), (2,3), (2,4), (2,5) 全部满足 n ≥ m，**不依赖 n < m 区域**；
   而 (3,2)、(4,2) 两格落在 n < m 区域，它们与 n ≥ m 区域的对应格数值相同。
   这与 paper.md Problem 9.5（"d_* = (−1)^{ℓ+1}c_m^F 在 n < m 时失效，反例 (5,1,4)"）不矛盾
   （"失效"是"不保证"而非"处处不等"），但提示失效域比 n < m 窄。本抽取不作断言，线索留给 prover/curator。
6. 参考文献 [3]（印刷页 29）作 "———, S-duality action on discrete T-duality invariants, JHEP 0804 (2008) 012"，
   破折号承接 [2] 的 "N. Banerjee"。据 INSPIRE（`/api/arxiv/0801.0149`）该文作者为
   **Banerjee, Shamik 与 Sen, Ashoke**，刊号 JHEP 04 (2008) 012 一致。即本文的书目项漏掉了 Sen、
   并把 Shamik 归并成了 N. Banerjee。记此供本项目 `sources.bib` 的 `banerjee-sen-2008-tduality` 条参照。
