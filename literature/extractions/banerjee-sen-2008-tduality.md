# 抽取记录：banerjee-sen-2008-tduality

- **文献**：`banerjee-sen-2008-tduality` = Sandip Banerjee and Ashoke Sen, "S-duality Action on Discrete T-duality Invariants", JHEP 09 (2008) 027, arXiv:0801.0149.
- **抽取者**：researcher
- **日期**：2026-09-18
- **覆盖范围**：全文定向关键词检索。
- **证据等级**：**L1** — ar5iv HTML 版 `https://ar5iv.labs.arxiv.org/html/0801.0149` 全文可读，通过 WebFetch 获取。

## 背景

原任务要求核查"Sen 的 CHL/挠 dyon 系列，尤其讨论挠 I>1 的部分"；本文（Banerjee-Sen，Sen 为作者之一）是该系列中专门研究挠不变量 r 在 S-duality 下变换性质的一篇，与已有抽取记录 `dgm-eq51-eq52-third-party-crosscheck.md` 中核实过的 `banerjee-sen-srivastava-2008a/b`（Sen 三人组）形成互补——本文是 Banerjee 与 Sen 二人合著，聚焦 T-duality 不变量分类而非配分函数构造本身。

## 约定

- (Q,P) = 电磁荷对，O(6,22;ℝ) 不变量 Q²,P²,Q·P
- r = 挠不变量（torsion）
- Γ⁰(r) = SL(2,ℤ) 的一个同余子群

## 陈述

### E1 — 挠 r 与子群 Γ⁰(r) 的关联（正文，转述+部分逐字）

> "...for dyons with torsion r, the degeneracy formula is required to be manifestly invariant under only a subgroup of the S-duality group isomorphic to Γ⁰(r)."

- **位置**：正文（S-duality 约束挠 r dyon 简并度公式部分）。
- **类型**：约束条件陈述。
- **文献自称的严格程度**：约束推导，非猜想式陈述。

### E2 — 否定证据：全文定向检索（逐字确认）

- **位置**：全文。
- **类型**：negative evidence（L1，全文检索）。
- **检索结果（逐条）**：
  - **"automorphism"**：不出现。
  - **"Borcherds"**：不出现于正文；仅出现在一条引用文献标题中（"Spectrum of dyons and black holes in CHL orbifolds using Borcherds lift"，引用 [18]），**非本文正文自己的论述**。
  - **"Kac-Moody" / "BKM"**：不出现。
  - **"Weyl vector"**：不出现。
  - **"Hecke operator"**：不出现。

### E3 — 结尾推测性陈述（Conclusion，转述）

- **位置**：Conclusion。
- **类型**：作者自述未决问题，推测性（非构造性）。
- **陈述**：结尾讨论 r>1 情形时，作者认为"配分函数的被积核应当是 Sp(2,ℤ) 中包含 Γ⁰(r) 的某个子群下的模形式"，类比 r=1 时 Sp(2,ℤ) 与 Igusa 尖点形式的关系；原文明确用"it remains to be seen if this constraint...can fix the form of the integrand"这类推测性措辞，**未给出具体的自同构构造或 Hecke 算子构造**。

## 对 GAP-BKM 的影响（⟨judgment⟩）与对 Sub-question 1 的影响

**GAP-BKM 未被抢先**：本文完全不涉及 BKM 代数、自同构或 Weyl 向量语言，其挠 r 分析停留在"S-duality 子群约束"层面。

**Sub-question 1（挠 I dyon 计数是否已被明确写成 1/Φ₁₀ 上的 Hecke 算子）**：本文**不使用"Hecke"字样**，是该 sub-question 的又一负面数据点（另见 `banerjee-sen-srivastava-2008b` 的核查，见下方交叉引用）。

## 与 sources.bib 已登记的 BSS 2008b 的交叉核实（补充）

已对 `banerjee-sen-srivastava-2008b`（arXiv:0802.1556，"Partition Functions of Torsion >1 Dyons in Heterotic String Theory on T^6"）做了专门的"Hecke"字样全文检索（L1，ar5iv HTML）：**全文不出现"Hecke"字样**。该文用 Σ_{s|r} g(s)·s̄^{-3}·Σ_k Σ_l Φ₁₀(...)^{-1} 的除子和构造挠 r 配分函数（结构上类似 Hecke 算子的陪集平均），但**文献自己从未用"Hecke"语言描述这个构造**，全篇陈述为"由 S-duality 不变性、wall crossing、黑洞熵、规范理论极限等一致性条件确定的提议"（consistency-fixed proposal），不是从 Hecke 理论出发推导。

## 未解决的疑问

1. 是否存在别的、更晚近的文献（如 Bossard-Cosnier-Horeau-Pioline 系列，已被 `dgm-eq51-eq52-third-party-crosscheck.md` 部分核查）明确把挠 r 的除子和构造**命名**为 Hecke 算子？本次未专门重新核查该系列的这一术语点，留待后续。
