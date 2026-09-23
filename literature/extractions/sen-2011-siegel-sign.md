# 抽取记录：sen-2011-siegel-sign

- 文献：A. Sen, "How Do Black Holes Predict the Sign of the Fourier Coefficients of Siegel Modular
  Forms?", Gen. Rel. Grav. 43 (2011) 2171–2183, arXiv:1008.4209 [hep-th]
- 抽取者：researcher agent（分支 `agent/researcher/arxiv-2510-05219`）
- 日期：2026-09-23
- 可信度分级：**L1**（官方 arXiv PDF + `pdftoppm -r 220` 页图 + PIL 放大逐位读数）
- 取件方式：`curl -sL https://arxiv.org/pdf/1008.4209`，17 页，PDF 页码 = 印刷页码。
  `pdftotext` 仅用于定位页码；本记录的全部数字以页图为准。
- 覆盖范围：**仅 Table 1 及其说明文字（印刷页 11）**。全文其余部分（§2–§4 的壁/chamber 分析、
  §3.7/3.9/3.11 的约束条件、CHL 推广）本轮未抽取。
- 抽取动机：`research/papers/torsion-dyon-shift-positivity/NOTES-for-captain.md` §4.4 记录，
  §3 的五个基准简并度"在 1/4-BPS 文献中流传，但本项目未能核到可引用的表格出处"。

## 约定

- 杂化弦 on T⁶（= type II on K3×T²），四维 N=4，1/4-BPS dyon。
- 表中的量是 **−B₆**（六阶螺旋迹指标，取负号），**不是**单心/immortal 指标 d_*；
  −B₆ 依赖模空间 chamber（壁穿越时跳变），文献本身在 §2–§3 就是在讨论这件事。
- 电荷标号用 T-对偶不变量 (Q², P², Q·P)。与本项目 paper.md 的 (m,n,ℓ) 的换算为
  m = Q²/2，n = P²/2，ℓ = Q·P。

## 陈述

### S1 Table 1：杂化弦 on T⁶ 的 −B₆ 数值表
- 位置：**Table 1，印刷页 11 = PDF 页 11**（表格在页上半，表题在表下方）。
- 类型：数值表（data）
- 表头逐字：`(Q², P²)\Q.P` ｜ `-2` ｜ `0` ｜ `1` ｜ `2` ｜ `3` ｜ `4`
- 表体逐字（页图放大读数；**粗体项是文献自己加粗的**，含义见表题）：

  | (Q²,P²) | Q·P=−2 | Q·P=0 | Q·P=1 | Q·P=2 | Q·P=3 | Q·P=4 |
  |---|---|---|---|---|---|---|
  | (2,2) | −209304 | **50064** | **25353** | 648 | 327 | 0 |
  | (2,4) | −2023536 | **1127472** | **561576** | **50064** | 8376 | −648 |
  | (4,4) | −16620544 | **32861184** | **18458000** | **3859456** | **561576** | 12800 |
  | (2,6) | −15493728 | **16491600** | **8533821** | **1127472** | 130329 | −15600 |
  | (4,6) | −53249700 | **632078672** | **392427528** | **110910300** | **18458000** | **1127472** |
  | (6,6) | 2857656828 | **16193130552** | **11232685725** | **4173501828** | **920577636** | **110910300** |

- 表题逐字（页图核对）：
  > "Table 1: Some results for −B₆ in heterotic string theory on T⁶ for different values of Q², P²
  > and Q.P. The boldfaced entries are for charges which satisfy the constraints (3.7). We have
  > given the results only for Q² ≤ P² since the results are symmetric under Q² ↔ P². Note that some
  > of the entries are the same; this is a consequence of a ℤ₃ subgroup of S-duality transformation
  > τ → 1 − τ⁻¹ which maps R to R but changes the charges as
  > (Q², P², Q·P) → (P² + Q² − 2Q.P, Q², Q² − Q.P)."
- 文献自称的严格程度：数值表（由 1/Φ̃ 的傅里叶系数精确计算），无证明；表格是对正文猜测的检验数据。
- 文献列出的依赖：正文的约束 (3.7)（定义 R 区域的壁条件）；Φ̃ 的傅里叶展开。
- 备注 1：`pdftotext -layout` 把 `(4,6)` 行的数据错排到 `(6,6)` 标签上、并把 `(6,6)` 行挤成独立一行。
  **必须用页图读**。本记录的行/列归属是页图读数。
- 备注 2：表题里的 ℤ₃ 说明解释了为什么同一个整数在表中多处出现
  （例：1127472 出现在 (2,4,0)、(2,6,2)、(4,6,4) 三处）。

### S2 与 `paper.md` §3 五个基准值的对照
（本记录只做逐字对照，不对 −B₆ 与 d_* 是否相等作断言——该判断见下方"未解决的疑问"第 1 条。）

| paper.md §3 | (Q²,P²,Q·P) | Table 1 位置 | Table 1 数值 | 裁定 |
|---|---|---|---|---|
| d_*(1,1,0) = 50064 | (2,2,0) | 行 (2,2)，列 Q·P=0 | 50064 | **SUPPORT** |
| d_*(2,2,0) = 32861184 | (4,4,0) | 行 (4,4)，列 Q·P=0 | 32861184 | **SUPPORT** |
| d_*(3,2,0) = 632078672 | (6,4,0) | 行 (4,6)，列 Q·P=0（表只列 Q²≤P²，故写作 (4,6)） | 632078672 | **SUPPORT** |
| d_*(4,2,0) = 9337042944 | (8,4,0) | **表中无此行**（无 (4,8)） | — | **无定论（本文献不覆盖）** |
| d_*(5,2,0) = 113477152800 | (10,4,0) | **表中无此行**（无 (4,10)） | — | **无定论（本文献不覆盖）** |

即：本文献独立覆盖五个基准值中的**前三个**，与 `bringmann-murthy-2012` 附录 A 的相应格子逐位一致。
后两个只有 Bringmann–Murthy 覆盖。

## 未解决的疑问

1. **Table 1 印的是 −B₆（总指标，含双中心贡献），paper.md 的 d_* 是单心/immortal 指标。**
   paper.md §3 自己写了"at which the total and immortal indices coincide"（在 Q·P=0 处两者重合）。
   本抽取**不核实**这条重合断言——它是壁穿越公式的推论，属 curator/prover 的工作，
   而且如果只想要单心指标的可引用出处，`bringmann-murthy-2012` 附录 A 直接就是单心表，不需要这一步。
2. 本记录只覆盖 Table 1。文中 (3.7)/(3.9)/(3.11) 的具体约束、R 区域的定义、以及"黑洞物理预言
   Siegel 模形式系数符号"这一主命题，本轮**未抽取**。
3. 本文献是否与 `research/papers/torsion-dyon-shift-positivity/paper.md` 的挠 I>1 内容有交集：
   **本轮未做全文检索**（只取了 Table 1 一页），故不作任何"无交集"声明。
