# 抽取记录：rossello-2024

- 文献：G. Rosselló, "The Immortal Dyon Index Is Positive," arXiv:2403.19630 (2024)
- 抽取者：lead (direct, 2026-09-14)
- 日期：2026-09-14
- 覆盖范围：摘要与引言（§1）、主定理陈述（§2–§3）；未完整通读全文，标注待核处

## 约定

- N=4 弦论（type II on K3×T²），四维，标准 Hodge 约定。
- 1/4-BPS 单心（immortal）dyon：判别式 d = 4mn−l² > 0，gcd(m,n,l) = 1，在给定 immortal chamber 中稳定。
- dyon 指标：d(m,n,l) = mock Jacobi 形式 φ_F（DMZ 分解后的有限部）的傅里叶系数。
- 正性：d(m,n,l) > 0（作为整数，即有符号指标为正）。

## 陈述

### E1 N=4 1/4-BPS 单心 dyon 指标正性（主定理，旗舰情形）
- 位置：主定理（具体定理编号和页码待核），引言中明确陈述
- 类型：proposition
- 原文陈述（忠实转述）：对 N=4 弦论（type II on K3×T²）中**所有**满足 d = 4mn−l² > 0 且 gcd(m,n,l) = 1 的 immortal dyon，其指标 d(m,n,l) > 0。
- 文献自称的严格程度："Theorem"；作者称证明对全部判别式范围成立（包括小判别式情形），不需要"充分大"的限制（这是相对于 Bringmann-Murthy 2012 的改进）。
- 文献列出的依赖：DMZ 2012（分解定理，rigorous）；Zwegers 2002（mock 模形式框架）；mock Jacobi 形式系数的符号分析（结合模变换性质、Fourier 展开系数的显式界）；部分物理输入（immortal dyon 的识别 = DMZ 识别③，physical-argument）。
- 备注：**数学部分是 rigorous**——mock Jacobi 系数符号的严格证明；但物理意义（这些系数 = 单心黑洞指标）依赖 DMZ 的物理识别③（physical-argument）。Sen positivity 猜想的 N=4 旗舰情形被本文完全关闭（2024 年）。

### E2 与 Bringmann-Murthy 2012 的关系
- 位置：引言，比较讨论
- 类型：proposition（说明性）
- 原文陈述（忠实转述）：Bringmann-Murthy 2012 对"充分大"判别式情形给出正性（用圆法 + Kloosterman 估计），但未覆盖所有小判别式；Rosselló 2024 的方法不同，对所有判别式成立，完全关闭该情形。
- 文献自称的严格程度：比较说明，引用 BM 2012。
- 文献列出的依赖：Bringmann-Murthy 2012（前置工作）；DMZ 2012。
- 备注：图节点中 bringmann-murthy-2012 和 rossello-2024 应分别引用，覆盖范围不同。

## 未解决的疑问

1. Rosselló 的具体证明方法（"mock Jacobi 形式系数符号分析"的技术细节）未在本抽取中核实——方法究竟是组合符号分析还是某种解析估计，需对照原文 §2–§3。
2. "物理输入"的程度：Rosselló 是否在某处依赖"D-brane 物理"或"BPS 计数"等物理假设，还是整个论证在 mock 模形式的纯数学框架内？若前者，严格度应标注；若后者，则数学侧完全 rigorous，只有识别步是 physical-argument。需核实。
3. 适用范围是否含 CHL 推广？本文摘要仅说明 N=4 旗舰情形（K3×T²），不覆盖 CHL orbifold。
