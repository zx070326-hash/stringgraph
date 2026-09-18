# 抽取记录：donagi-ott-2023

- 文献：Ron Donagi and Nadia Ott, "Supermoduli Space with Ramond punctures is not projected",
  arXiv:2308.07957v1（**标题/作者经 export.arxiv.org API 逐字核对**）
- 抽取者：researcher (agent/researcher/supermoduli-post-2024)
- 日期：2026-09-18
- 覆盖范围：pp.1–6（标题页、摘要、§1"Preliminaries: Split and projected supermanifolds"、Theorem 1
  逐字、Lemma 2、直至 Corollary 4 与一个应用示例），L1 直接读取。**pp.7 起（论文其余部分，含主定理
  完整证明的技术细节）未读**。全文共 21 页（据 arXiv comment "21 pages"）。

## 约定

带 Ramond 穿孔的超模叠记 𝔐_{g,0,2r}（g=亏格，2r=Ramond 穿孔个数，偶数因 Ramond 穿孔需成对出现以
保持整体 GSO/边界条件一致性——此为本抽取者对记号的合理解读，非逐字核实到论文明确解释这一点，标记为
推断）。与既有图节点 `math.supermoduli-space-not-projected`（无穿孔 𝔐_g）、correa-noja-2026（紧化
无穿孔 𝔐̄_g）在"是否带穿孔"这一维度上互补。

## 陈述

### E1 摘要 + 正文 Theorem 1（逐字核实，经 arXiv API 与 PDF 双重核对）
- 位置：摘要；p.1 正文 Theorem 1（原文页码需以 PDF 渲染结果核对，本抽取者读到的位置在标题页之后的
  第一条定理陈述）
- 类型：proposition
- 原文陈述（逐字，经 export.arxiv.org API 核验的摘要文本）："The supermoduli space
  $\mathfrak{M}_{g,0,2r}$ is not projected for all $g \ge 5r + 1 \ge 6$."
  正文 Theorem 1（本抽取者 L1 读取 PDF 得到的措辞，与摘要一致或几乎逐字一致）："Let r > 0. The
  supermoduli space 𝔐_{g,0,2r} is not projected for all g ≥ 5r + 1 ≥ 6."
- 文献自称的严格程度：定理（"Theorem 1"），证明性文章，非猜测。
- 文献列出的依赖：Donagi–Witten arXiv:1304.7798（原始 g≥5 无穿孔非投影性结果与障碍理论框架，本文
  标题/摘要"improve the result of Donagi, Witten, and Ott"——**注意本文自己就是 Donagi–Ott 团队之一
  的作者 Ott，"Donagi, Witten, and Ott"这一并列提法出现在后续 Wang 论文摘要里，指代 Donagi-Witten
  2013 + 本文 Donagi-Ott 2023 两篇合并起来的既有结果基线，见 wang-2025 抽取文件的交叉引用**）。
- 备注：**量词精确核对**——条件是 "g ≥ 5r+1 且此值 ≥6"，等价于 r≥1 时 g≥5r+1（r=1 时 g≥6，r=2 时
  g≥11，以此类推），**不是"g≥6 对所有 r 成立"这种更弱/更强的误读**；"r>0"排除了 r=0（无穿孔）情形，
  该情形回到 Donagi-Witten 2013 的范围。此定理**只覆盖"纯 Ramond 穿孔、无 Neveu-Schwarz 穿孔"
  （n=0, 2r>0）的情形**，不涉及 NS 穿孔——NS+Ramond 混合穿孔情形由后续 wang-2025 处理。

### E2 §1 结构性核实：split/projected 定义与基本引理（Lemma 2）
- 位置：§1"Preliminaries: Split and projected supermanifolds"（pp.1–3 左右，具体页码待核）
- 类型：definition
- 原文陈述（忠实转述）：回顾 split 与 projected 两个概念的标准定义（split ⟹ projected，但反之不然，
  与既有图节点约定一致）；Lemma 2 给出关于障碍类或投影存在性的一个基础性技术引理（本抽取者已读到该
  引理陈述文字，但**未逐字摘录其精确数学表述**，仅确认其角色是为 Theorem 1 的证明搭建基础工具）。
- 文献自称的严格程度："Lemma"，证明性。
- 文献列出的依赖：P. Green 1982 障碍理论；Donagi–Witten 障碍框架。
- 备注：本条目对 Lemma 2 的记录**精确度不足以支撑 curator 直接转录定理文本**，只能确认其存在与
  大致定位，若需要精确引用须补读。

### E3 Corollary 4 + 应用示例（结构性核实，非逐字定理文本）
- 位置：约 pp.4–6（Corollary 4 与随后的一个应用示例）
- 类型：proposition
- 原文陈述（忠实转述，非逐字）：Corollary 4 从 Lemma 2/前置结果推出一个关于带 Ramond 穿孔超模空间
  的推论（具体内容本抽取者已读但**未记录到可逐字复核的精度**）；随后给出一个具体应用示例说明该推论
  的用法。
- 文献自称的严格程度：推论性质（"Corollary"），证明性。
- 文献列出的依赖：Lemma 2（E2）。
- 备注：**这部分内容本轮只做了结构性确认（"这里有个 Corollary 4，后面跟一个例子"），未深入到可
  逐字引用的精度**，若 curator 需要精确依赖边，建议补读。

## 未解决的疑问

1. **pp.7 起（全文 21 页中的绝大部分，含 Theorem 1 完整证明的核心技术步骤）完全未读**——本抽取者
   只核实到"存在这样一条定理、量词范围是 g≥5r+1≥6、覆盖纯 Ramond 穿孔情形"这一层级，**Theorem 1
   证明本身用的具体方法（是否与 Donagi-Witten 2013 的分歧覆盖方法类似，或另有新技术）未核实**。若
   curator 需要标注证明方法/技术依赖，必须先补读全文。
2. **Lemma 2、Corollary 4 的精确数学陈述未逐字核实**（见 E2/E3 备注），仅做结构性定位。
3. **"g,0,2r"记号中"0"代表 NS 穿孔数为零"这一解读是本抽取者基于记号惯例的推断，未见论文正文
   明确逐字解释记号含义**（本轮阅读范围内未遇到显式的记号说明段落，可能在未读的后续页面中），
   标记为推断（inferred），不作为确定结论。
4. **与既有图节点 `math.supermoduli-space-not-projected` 红线(1)(4)的关系**：本文处理的是**带
   Ramond 穿孔**的超模空间，该既有图节点覆盖的是**无穿孔**情形（红线未明确提及穿孔情形是否被排除
   在外，但节点标题/Donagi-Witten 2013 原文本身只处理无穿孔情形），故本文是该节点范围之外的独立
   补充结果，不构成对该节点红线(1)(4)的直接修订，但填补了"带穿孔"这一此前完全未提及的维度。
