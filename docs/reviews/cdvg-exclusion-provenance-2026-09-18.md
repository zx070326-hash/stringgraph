# 优先权裁定：CDvG 全纯 Ansatz 排除论证——Witten 2015 vs. Dunin-Barkowski–Fedorov–Sleptsov 2025

- 审计人：physics-auditor
- 日期：2026-09-18
- 裁定对象：`graph/statements/math/supermoduli-genus-3-cdvg-ansatz-excluded-by-pole.yaml`
  （及其推导 `graph/derivations/math/supermoduli-genus-3-cdvg-ansatz-excluded-by-pole--via-dunin-barkowski-fedorov-sleptsov.yaml`、
  依赖卡 `graph/statements/math/supermoduli-witten-genus-3-hyperelliptic-pole.yaml` 及其推导）
- 本报告**不改动 `graph/**`**，只交付建议。写入范围仅 `docs/reviews/**`。

结论先说：**Q1 现在可以给出非条件性回答**——本轮我直接调取了 DBFS 2025 原文 PDF（pp.1–10 Introduction 全节 + pp.42–52 References 全节），把此前卡片 gaps 里标注的"极强间接证据"升级为**直接核对确认**：DBFS [20] 就是 Witten [24]（arXiv:0801.2543）。同时发现一个此前未被记录的关键事实：**DBFS 在同一段落里明确引用 Witten 2015 Appendix C.4 作为"极点存在"这一前提的出处，但没有引用/提及 Witten 在同一 Appendix C.4 里已经针对同一篇论文（[24]/[20]）做出的几乎相同的排除结论**。Q2 建议方案 **(c)**：立一张新卡专记 Witten 自己的排除句，不改动、不换代现有 DBFS 卡。Q3 裁定：**faithful**（回译与 DBFS 原文逐字一致），且 title 里的作者括号按本项目既有约定应理解为"来源标注"而非"首创权声明"。

---

## 0. 本轮新增的一手核实（方法论说明）

任务书要求"拿不到的原文标 L0，不要靠推测填空"。已有的卡片/抽取记录已经对 Witten 2015 做了全文 L1 核实，但对 **DBFS 2025 原文本身**只核实到摘要 + p.5 那一句孤立引文，**没有核实那句引文前后的完整段落**——而这正是回答"DBFS 有没有引用 Witten 的这条排除"这一问的关键证据所在地。因此本轮我直接下载了 arXiv:2505.02950v2 的 PDF 并用 `Read(pages=...)` 逐页核实：

```
curl -sL -o <tmp>/dbfs2025.pdf https://arxiv.org/pdf/2505.02950v2
Read(<tmp>/dbfs2025.pdf, pages="4-6")   # 印刷页 2–4（§1.1–§1.6 前段）
Read(<tmp>/dbfs2025.pdf, pages="6-7")   # 印刷页 4–5（§1.5–§1.6 排除论证全段 + 脚注 3/4）
Read(<tmp>/dbfs2025.pdf, pages="49-52") # 印刷页 47–50（Acknowledgments + References [1]–[52]）
```

这是**只读**操作，产物只是本地临时文件与本报告引用的逐字文本，不写入 `literature/**`（那是另一个 agent 的写入范围，我没有触碰 `literature/extractions/` 或 `sources.bib`）。以下所有 DBFS 原文引用均标注"印刷页码 + 本次 L1 直接核实"。

---

## 1. Q1（事实层）：这两条排除是不是同一条？

### 1.1 [20]（DBFS）与 [24]（Witten）身份——本轮直接核实，从"强间接证据"升级为"确认"

DBFS 2025 印刷 p.4（§1.5 首句，本次 L1 直接核实）：

> "In [20, 21] the authors observed that Ξ^(2) is the unique holomorphic Siegel modular form (of genus 2, level Γ_2(1,2) and weight 8) satisfying the following factorization condition... They then tried to find a holomorphic Siegel modular form (of level Γ_3(1,2) and weight 8) satisfying the analogous factorization condition for genus 3... And indeed they could prove that such a modular form exists, is unique and enjoys some other properties that one would expect from a genus 3 analogue of ψ_1/φ_1 and π_*ψ_2/φ_2 on physical grounds [20, 21]."

DBFS 2025 印刷 p.49（References，本次 L1 直接核实），条目 [20]：

> "[20] S.L. Cacciatori, F. Dalla Piazza and B. van Geemen, *Modular forms and three loop superstring amplitudes*, Nucl. Phys. B **800** (2008) 565 [**0801.2543**]."

比对本卡已有的 Witten References [24] 条目（Witten p.59，卡片 gaps 已逐字记录）：

> "[24] S. L. Cacciatori, F. Della Piazza, and B. van Geemen, 'Modular Forms And Three Loop Superstring Amplitudes,' arXiv:0801.2543, Nucl.Phys. B800 (2008) 565-590."

**同一 arXiv 号（0801.2543）、同一期刊卷页（Nucl. Phys. B800 (2008) 565）、同一篇名（逐字，仅大小写差异）、同一批作者**（"Della Piazza" vs "Dalla Piazza" 是拼写变体，指同一人 Filippo Dalla Piazza——这处不一致出现在 Witten 自己的参考文献表里，是 Witten 论文自身的笔误，不影响身份判定）。**结论：[20] = [24] = arXiv:0801.2543，本轮已直接核实，不再是待核事项。**

顺带确认一条卡片 gaps 里原本猜测但未定论的旁支：DBFS 的 [21] 实际是 F. Dalla Piazza and B. van Geemen, *Siegel modular forms and finite symplectic groups*, arXiv:**0804.3769**（印刷 p.49，References [21]，本次核实）——**不是**此前抽取记录候选列表里猜测的 arXiv:0804.0457（"Genus four superstring measures"）。这篇 0804.0457 根本没有出现在 DBFS 的参考文献表里；此前的"候选范围"讨论到此可以关闭，不再需要在 [20]/[21] 之间纠结。

### 1.2 逻辑结构对比：Witten「沿 D′ 全纯」vs. DBFS「在整个 H_3 上全纯」

Witten 2015 p.56，(C.22) 之后（卡片已逐字记录，本项目此前 L1 核实）：

> "The literature actually contains a proposal [24] for a holomorphic measure on M_{3,spin+}... **This formula is holomorphic along D′, so it does not coincide with π_*(Υ).**"

DBFS 2025 印刷 p.5，本次 L1 直接核实的**完整段落**（此前卡片只摘录了最后一句）：

> "Another objection refers to genus 3. The superperiod map does define a meromorphic projection π : S_3 → M_3^+ in this case, although this projection is not everywhere holomorphic but has poles over the hyperelliptic divisor H_3 ⊂ M_3 [27, appendix C.3] (cf. [28, theorem 6.3]). So for genus 3 one may still consider the form π_*ψ_3, but a priori it is only well defined outside of the locus of hyperelliptic curves, while it may in principle have poles over H_3.
>
> In [27, appendix C.4] Witten showed that π_*ψ_3 does indeed have a pole and computed the order of the pole.³ φ_3 has no poles and no zeros, so π_*ψ_3/φ_3 has a pole too (of the same order as π_*ψ_3). **On the other hand, the Ansatz of [20] is holomorphic everywhere on the Siegel upper half-space H_3, so this Ansatz cannot be a formula for π_*ψ_3/φ_3.**"

（脚注 3，同页）："In an earlier preprint Witten stated without proof that π_*ψ_3 should be holomorphic on M_3^+ [2, the end of section 3]. The results of [27, appendix C.4] refute that earlier statement."

**两条排除的逻辑结构确实是同一个骨架**（"前提 A：真实测度在超椭圆轨迹上有极点" + "前提 B：CDvG Ansatz 处处全纯" ⟹ "CDvG Ansatz ≠ 真实测度"），但前提 B 的**强度不同**：

- Witten 的前提 B 是"[24] 沿 **D′**（M_{3,spin+} 中超椭圆轨迹分裂出的一支既约除子）全纯"——这是他直接检视 [24] 给出的具体公式后的针对性断言。
- DBFS 的前提 B 是"[20] 在**整个 Siegel 上半空间 H_3**（对应 M_3^+ 的全空间）上全纯"——这是一个更强的断言（"处处全纯"蕴含"沿 D′ 全纯"，反之不成立）。

**任务书提示的方向是对的：DBFS 的前提在逻辑上蕴含 Witten 所需要的前提，而不是相反。** 也就是说，若只看"排除 [20]/[24] 所需要的最小前提"，Witten 的版本（沿 D′ 全纯即可导出矛盾）已经是**充分且更精确**的论证；DBFS 的版本用了一个不必要地更强的前提（处处全纯）来得到同一个矛盾，是**更粗糙但仍然有效**的复述。换句话说：DBFS 的论证不是 Witten 论证的推广，而是被 Witten 论证所蕴含的一个特例式重述（因为"处处全纯"本身已经默认蕴含"沿 D′ 全纯"，一旦有了 D′ 上的矛盾就够用，不需要处处全纯这么强的断言）。

这与卡片既有 notes（"DBFS 转述不精确"一节）的判断一致并进一步坐实：DBFS 把 Witten 原文里 D/D′ 两支不对称的精细结构（D′ 有极点，D 只是"expect"的零点）抹平成"沿超椭圆轨迹有极点"的笼统单数表述，本次核实的完整段落证实这不是抽取误记，而是 DBFS 论文本身在这一段落里就是这样笼统处理的（DBFS 全篇 §1.6 未出现 "D′" 或 "D" 这两个记号，只用"the hyperelliptic divisor H_3 ⊂ M_3"、"the locus of hyperelliptic curves"这类不加区分的说法）。

### 1.3 Witten 那句话是顺带一提还是正式结论？

如卡片推导 `--via-witten-2015` 已记录：Witten Appendix C 全篇无编号 Theorem/Proposition，是一段有显式公式支撑（(C.19)–(C.25)）的正文叙述。但这句排除句不是"顺带一提的旁白"——它紧跟在 (C.22)（"Thus π_*(Υ) is of order 1/ε⁴ or 1/q² along D′."）之后，**在同一段落里**，点名文献编号 [24]、给出具体理由（"holomorphic along D′"）、给出明确结论（"does not coincide with π_*(Υ)"）。这是作者在计算完成后**主动、有意地**把结果拿去核对文献中一个具体的、已发表的提案，并给出否定结论——属于"正文计算的直接推论陈述"，不是脚注式的、无实质内容的客套提及。

### 1.4 DBFS 有没有引用 Witten 的这条排除？——本轮最重要的新发现

**没有。** 本次直接核实 DBFS 印刷 p.5 完整段落（见 1.2）确认：DBFS **明确引用** Witten [27, appendix C.4] ——但引用的对象是"Witten 证明了 π_*ψ_3 有极点、并算出了极点的阶数"这一**前提事实**（对应本卡的"前提 A"）。DBFS 自己另外补了一步（"φ_3 没有极点也没有零点，所以 π_*ψ_3/φ_3 也有同阶的极点"）把这个事实从 π_*ψ_3 转移到 π_*ψ_3/φ_3 上，然后**才**接上"[20] 处处全纯，所以不能是 π_*ψ_3/φ_3 的公式"这句结论。

**DBFS 全篇（至少本次已读的 pp.1–10 Introduction 全节，恰好覆盖 §1.6"Criticisms of the Ansatz"整节）从未提及 Witten 本人已经在被引用的同一个 Appendix C.4 里，针对同一篇论文 [24]=[20]，说过几乎相同的话**（"This formula is holomorphic along D′, so it does not coincide with π_*(Υ)."）。DBFS 甚至在脚注 3 里表现出对 C.4 内容相当细致的阅读（提到 C.4 反驳了 Witten 自己 2013 年的早期猜测），却没有提到 C.4 里紧接着同一计算之后就已经点名排除了 [24]。

这不是"DBFS 引了 Witten 并说'如 Witten 所述'"（那样就没有优先权问题），而是"DBFS 引用了 Witten 的一个**前提**（极点存在），但独立地重新做了'前提 A + 前提 B ⟹ 排除 [20]'这个**组合推理步骤**，而这个组合推理步骤 Witten 本人早在同一处文献里已经对同一篇被排除的论文做过一次"。这正是需要报告给 lead 的**实质性**发现，而不只是"措辞漏署名"这么简单。

### Q1 小结

| 子问题 | 结论 | 确定程度 |
|---|---|---|
| [20]（DBFS）= [24]（Witten）？ | 是，= arXiv:0801.2543 | **确认**（本轮直接核对 DBFS 与 Witten 各自的 References 条目原文，非推断） |
| 逻辑结构是否相同？ | 骨架相同（前提 A + 前提 B ⟹ 排除），但 DBFS 前提 B（处处全纯）严格强于 Witten 前提 B（沿 D′ 全纯）；DBFS 版本被 Witten 版本蕴含，是更粗糙的重述而非推广 | 确认（本轮直读双方原文段落） |
| Witten 那句话的性质 | 正文中紧跟计算之后的、点名文献的、有意的排除陈述，非脚注式旁白；但无编号定理标签 | 确认 |
| DBFS 是否引用了 Witten 的这条排除？ | **否**——DBFS 只引用 Witten 作为"极点存在"这一前提的出处，未提及/未引用 Witten 已对同一篇论文做过相同排除 | 确认（基于已读的 Introduction 全节 pp.1–10，含排除论证所在的 §1.6 整节）；**唯一残留的不确定性**见"不确定性"一节第 1 条 |

---

## 2. Q2（规则层）：卡该怎么处理

### 2.1 title 是否算"陈述文本"（不可变）——本裁定给出的判例意见

本项目此前没有就"title 是否受根 CLAUDE.md 原则 1 约束"给出过明确判例（`graph/CLAUDE.md` 里 2026-09-12 的判例只处理"陈述正文内嵌 id"，未涉及 title）。**我的判断：title 应当与 statement 正文同等对待，纳入原则 1 的不可变范围**，理由：

1. title 是节点在 `search`、`report`、`why` 等工具输出与人类阅读中的第一手识别符，其信息量不亚于 statement 正文的摘要；若 title 可以自由改写而不留痕迹，"回译审计"制度本身会被绕过——审计员可以只审 statement 正文而title 被静默篡改，或反之。
2. 本项目已有的 title 惯例（见 `math.supermoduli-space-not-projected` 的 "超黎曼面模空间不可全纯投影（Donagi–Witten）"、`worldsheet.super-virasoro-kac-determinant` 的 "（MRC 1986 Sect. 3...）" 等）表明 title 承载的不只是标签，还包含精确的量词、条件范围（本卡 title 里的"条件性排除论证，前提为 Witten 2015..."就是量词/条件层面的实质信息）——这些内容如果不受不可变约束，等于给 statement 正文的不可变性开了一个后门。
3. 因此：**任何改变 title 语义内容（包括增删署名）的操作，都构成"改陈述文本"，必须走换代（新 id + `superseded_by`），不得就地编辑。**

按此判例，若要在本卡 title 里加上"Witten 2015"的署名（原第 3 问提到的方案 (b)），**必须换代**，不能就地改字——这也是我不推荐方案 (b) 的程序性理由之一（见下）。

### 2.2 三个方案的取舍

**不推荐 (a)（什么都不做，只留 notes）**：现状已经在 notes 里做了相当详尽的记录（见卡片 2026-09-18 "优先权发现"段），这部分工作质量很高、如实、克制，**不需要否定**。但 (a) 的问题是：Witten 本人那句排除陈述（"This formula is holomorphic along D′, so it does not coincide with π_*(Υ)."）本身是一条**完整的、可独立引用的数学论断**，目前只以"引文摘录"的形式挂在别的卡的 notes/gaps 文字段落里，**没有自己的图节点**，不能被 `search`、`status`、未来任何下游推导直接引用或依赖。这与 `graph/CLAUDE.md` "一个节点一个命题"的写节点判据相悖——按该判据，Witten 的排除论证本来就该有自己的节点，而不是永久寄居在 DBFS 卡的 notes 里。仅仅"记笔记"不是这条缺口的正确终态，只是权宜之计。

**不推荐 (b)（换代出 v2，title 同时署 Witten 与 DBFS）**：如 1.2 节所论证，Witten 与 DBFS 的排除论证在前提强度、记号对象（Υ vs π_*ψ_3/φ_3，二者的等同关系本项目自己已经标注为 `inferred: true`、未见任何文献逐字确认）、结论范围（D′ 单支 vs "整个 H_3"）上并不完全相同，把两者塞进同一个 title/statement 会违反"一个节点一个命题"，而且需要在 statement 正文里同时装下两套不完全等价的论证逻辑，容易造出一张表述含混、审计起来两头不讨好的卡。**换代的成本（新 id、旧卡 superseded_by、所有引用它的推导边要跟着改）在这里买不到相应的收益**——事实内容用 (c) 就能完整、干净地表达。

**推荐 (c)（Witten 的排除论证单独立卡，与 DBFS 卡并列）**：

- 完全符合"一个节点一个命题"：这本来就是发表在两篇不同论文里的两条独立数学论断（同一核心洞见，不同论文、不同记号、不同前提强度），拆开记录是诚实的做法，而不是过度拆分。
- 不需要碰现有 DBFS 卡的 title/statement 一个字——DBFS 卡忠实记录的是"DBFS 论文自己怎么论证"，这个事实描述本身没有错（见 Q3），不需要因为"Witten 更早"而改写它。
- 参照卡片已有先例：`math.supermoduli-witten-genus-3-hyperelliptic-pole` 正是本任务之前就已经为"前提 A"单独立卡、而不是把它塞进 DBFS 卡的正文——同样的处理方式应该延伸到"排除结论"这一步。
- 成本最低、收益最直接：新卡建好后，未来任何人 `search witten` 或 `search 排除` 都能直接找到 Witten 本人这条论断，不必先找到 DBFS 卡再去挖 notes。

### 2.3 给 lead 的可直接执行的新卡内容建议

**新 statement 节点**：

```
id: math.supermoduli-witten-genus-3-cdvg-exclusion-remark
kind: proposition
title: Witten 2015：文献中已有的 CDvG 亏格三全纯测度提案（[24]=arXiv:0801.2543）因沿 D′ 全纯而与 π_*(Υ) 不重合（Witten）
statement: |
  **对象**（记号同 `math.supermoduli-witten-genus-3-hyperelliptic-pole`：Υ、π_*(Υ)、D′ ⊂ M_{3,spin+}）：

  **论证**（Witten, arXiv:1501.02499, Appendix C.4, p.56, 紧接 (C.22) 之后，逐字）：
  "The literature actually contains a proposal [24] for a holomorphic measure on M_{3,spin+} that is
  supposed to arise by integrating over the odd variables in some fashion that has not been specified.
  This formula is holomorphic along D′, so it does not coincide with π_*(Υ)."

  [24] = Cacciatori, Dalla Piazza, van Geemen, "Modular Forms And Three Loop Superstring Amplitudes,"
  arXiv:0801.2543, Nucl.Phys. B800 (2008) 565-590（Witten 论文 References [24], p.59，逐字条目见本卡
  sources；本项目已独立核实同一篇论文即 Dunin-Barkowski–Fedorov–Sleptsov 2025 的 References [20]，
  见 `math.supermoduli-genus-3-cdvg-ansatz-excluded-by-pole` 与本卡 notes）。

  **本节点断言的精确范围**：这是一条条件性排除论证——(前提，本文自己刚证明，见
  `math.supermoduli-witten-genus-3-hyperelliptic-pole`) π_*(Υ) 沿 D′ 有极点（阶 1/q²）；(前提，本文
  自己对 [24] 公式的检视) [24] 的提案沿 D′ 全纯；(结论) 故 [24] 的提案与 π_*(Υ) 不重合。**本节点不
  断言 [24] 处处全纯**（这是 DBFS 2025 独立做出的更强断言，见 `math.supermoduli-genus-3-cdvg-ansatz-
  excluded-by-pole`，两者前提强度不同，不应合并为一张卡）。**本节点也不是编号定理**——Witten 全文
  Appendix C 无 Theorem/Proposition 标签，这是紧跟 (C.19)–(C.22) 计算之后的正文陈述。
uses_conventions: []
sources:
  - ref: witten-2015-ramond-period-matrix
    loc: "Appendix C.4, p.56, 紧接 (C.22) 之后；References [24], p.59"
    note: L1，同 `math.supermoduli-witten-genus-3-hyperelliptic-pole` 的抽取记录（E7/E8）。
tags: [supermoduli, superstring-measure, genus-3, math-input, witten, exclusion-argument]
notes: |
  **优先权说明**：本节点记录的排除论证比 Dunin-Barkowski–Fedorov–Sleptsov 2025（见
  `math.supermoduli-genus-3-cdvg-ansatz-excluded-by-pole`）早十年，且针对同一篇被排除的论文
  （[24]=[20]=arXiv:0801.2543，两处身份对应已由 auditor 2026-09-18 直接核对双方 References 条目
  原文确认，见 docs/reviews/cdvg-exclusion-provenance-2026-09-18.md）。**DBFS 2025 在引用 Witten
  [27, appendix C.4] 时只引用了"极点存在"这一前提，未引用/未提及 Witten 本人已在同一处文献对同一篇
  论文做过的这条排除陈述**——两条排除论证是各自独立、逻辑结构相似但前提强度不同（本节点前提"沿 D′
  全纯"严格弱于 DBFS 的前提"处处全纯"，本节点是更精确、更经济的版本）的两条命题，按"一个节点一个
  命题"原则分立两卡，不合并。
author: physics-auditor（建议稿，需 lead 或 curator 实际创建）
created: "2026-09-18"
```

**新 derivation 节点**：

```
id: math.supermoduli-witten-genus-3-cdvg-exclusion-remark--via-witten-2015
target: math.supermoduli-witten-genus-3-cdvg-exclusion-remark
kind: physical-argument
status: physical-argument   # 与 math.supermoduli-witten-genus-3-hyperelliptic-pole--via-witten-2015 同理由：
                             # 无编号定理、建立在 D' 支极点结果（同样是 physical-argument）之上
depends_on:
  - id: math.supermoduli-witten-genus-3-hyperelliptic-pole
    inferred: false   # 就是同一段落、紧接着的下一句话，不是记号对接式的 inferred
sources:
  - ref: witten-2015-ramond-period-matrix
    loc: "Appendix C.4, p.56, 紧接 (C.22) 之后"
    note: L1，见 statement sources note。
summary: |
  记账 Witten 论文 Appendix C.4 在给出 D′ 支极点阶数计算之后，紧接着做的一步文献核对：把刚算出的
  "π_*(Υ) 沿 D′ 有极点"这一事实拿去检验文献中一个具体的、已发表的全纯提案（[24]），发现矛盾，
  给出排除结论。这一步本身是初等的逻辑组合（"沿 D′ 全纯"与"沿 D′ 有极点"矛盾），不额外引入新的
  数学工具，故本推导自身不构成拖累目标卡 effective status 的新瓶颈；目标卡的 effective status
  由其依赖的 `math.supermoduli-witten-genus-3-hyperelliptic-pole`（physical-argument）决定。
author: physics-auditor（建议稿，需 lead 或 curator 实际创建）
created: "2026-09-18"
```

**对现有 DBFS 卡的建议改动：无**（title、statement 均不改）。仅建议在其 notes 里追加一句指向新卡的交叉引用（可选，由 lead/curator 执行，不强制）：

> 补充（若 lead 采纳本报告方案 (c)）：Witten 本人对同一篇论文（[24]=[20]）的排除陈述已独立立卡，见
> `math.supermoduli-witten-genus-3-cdvg-exclusion-remark`。

---

## 3. Q3（回译审计）：title + statement 是否忠实于 DBFS 原文？

### 3.1 回译（只读 title + statement，不看 notes/sources，独立翻回自然语言）

> 本节点记录 Dunin-Barkowski–Fedorov–Sleptsov 论文中的一条条件性排除论证：CDvG 2008 提出的亏格三 RNS
> 超弦测度 Ansatz（[20]），不可能是真实的亏格三超弦测度 π_*ψ_3/φ_3（Siegel 上半空间 H_3 上的一个截面）
> 的公式。论证依赖两个前提：(A) 引用自 Witten 2015 的既有结果——真实测度 π_*ψ_3/φ_3 在超椭圆轨迹上必须
> 有极点；(B) 本文自己的观察——[20] 的 Ansatz 在整个 H_3 上处处全纯，没有这样的极点。两者矛盾，故得出
> [20] 的 Ansatz 不能等于真实测度这一结论。这不是"CDvG 的计算本身有误"的断言，只是指出 [20] 的公式
> 不满足真实测度必须满足的一条额外解析性质。本节点不证明前提 A 本身。[20] 的确切 arXiv 号未被本节点
> 判定。

### 3.2 与 DBFS 原文比对

- 本次核实的完整段落（见 1.2）与上述回译**逐条对应**：前提 A（"In [27, appendix C.4] Witten showed
  that π_*ψ_3 does indeed have a pole"）、前提 B（"the Ansatz of [20] is holomorphic everywhere on
  the Siegel upper half-space H_3"）、结论（"so this Ansatz cannot be a formula for π_*ψ_3/φ_3"）——
  三者与卡片 statement 的"(前提 A)...(前提 B)...(结论)..."三段式完全对齐，量词（"everywhere"↔"处处"，
  "cannot be"↔"不能是"）没有被加强或减弱。
- 卡片逐字引用的那句话（"the Ansatz of [20] is holomorphic everywhere on the Siegel upper half-space
  H_3, so this Ansatz cannot be a formula for π_*ψ_3/φ_3."）经本次直接读取原文 PDF 核对，**逐字符
  完全一致**，包括标点。
- 卡片 statement 明确声明"不断言 CDvG 计算本身有误"，与 DBFS 原文的措辞（只说 "cannot be a formula
  for"，不说 "is wrong"/"the computation is incorrect"）一致，没有替作者加强。
- 卡片"未决事项"如实标注 [20] 的 arXiv 号未判定——**本报告已经把这一点解决**（见 1.1），但这是审计
  之后的新证据，不影响裁定"卡片写作当时如实标注了不确定性"这一事实本身是忠实的。

**裁定：faithful。** title 与 statement 的量词、条件、逻辑连接词（若/因为/所以）均与 DBFS 原文一一对应，没有发现"存在 vs 任意"、"等号 vs 不等号"这类量词/关系错位，也没有发现擅自加强或减弱的措辞。

### 3.3 title 末尾"（Dunin-Barkowski–Fedorov–Sleptsov）"括号的性质

对比本项目已有的同类 title 惯例（`math.supermoduli-space-not-projected` 的"（Donagi–Witten）"、
`worldsheet.super-virasoro-kac-determinant` 的"（MRC 1986 ...）"等，见 §2.1 引用），这一括号在全项目
范围内的**一贯用法是"这条记录抽取自哪篇论文/哪些作者"（来源标注），不是"这一数学洞见由谁首创"（首创权
声明）**——没有任何一张已有卡片的作者括号被用来断言"这是该作者独立于所有前人发现的"。按这一贯例读，
本卡 title 里的"（Dunin-Barkowski–Fedorov–Sleptsov）"是忠实的：这条记录**确实**抽取自 DBFS 2025
这篇论文，DBFS 论文里**确实**写了这段"前提 A + 前提 B ⟹ 排除"的论证（本次核实的完整段落证明这不是
转述失真，DBFS 自己就是这样论证的）。

**但**——这不意味着没有问题。真正的问题不在"署名括号有没有违反本项目的来源标注惯例"（没有违反），而在
于：**这条论证的核心数学洞见（"文献中那篇全纯的提案，因为全纯，所以不能是真实测度"）本身，作为一个
思想，并非 DBFS 首先提出**——Witten 2015 已经对同一篇被排除的论文做过几乎相同的论证（见 Q1）。这不是
title 措辞层面的"陈述与来源不符"问题（回译审计的标准范围），而是一个**科学史/优先权归属**问题——
这正是 Q2 建议方案 (c) 要解决的，不属于"回译是否忠实"这一问的范畴。**Q3 与 Q2 的结论要分开理解：卡片
对 DBFS 论文的转述是忠实的（Q3: faithful）；但仅记录 DBFS 一家的排除论证、而不给 Witten 本人已经做过
的同类论证单独立卡，是一个图谱完整性/科学优先权的缺口（Q2: 建议方案 (c) 补上）。**

---

## 4. 本裁定的不确定性

1. **DBFS 全文 pp.11–41（§2–§6 技术推导正文 + 附录 A–D）本轮未读**。本次核实覆盖了 pp.1–10（Introduction
   全节，含排除论证所在的 §1.6"Criticisms of the Ansatz"整节）与 pp.42–52（References 全节），这两处
   已经是"DBFS 是否引用了 Witten 的排除句"这一问最可能出现答案的地方（引言批评段落 + 参考文献表），
   但严格地说，不能 100% 排除 DBFS 在后文技术推导中某处又提到"如 Witten 所述，[24] 已被排除"这类
   话——只是这种情况在论文结构上不太可能（§2–§6 是 DBFS 自己推导新公式的技术细节，不是重访 CDvG 批评的
   地方），如果需要 100% 确定性，应由 researcher 补读这部分。
2. **Witten 参考文献表 [24] 条目里 "F. Della Piazza" 这一拼写**（vs. DBFS 与本人真实姓名 "F. Dalla
   Piazza"）被我判定为 Witten 论文自身的笔误而非另一人——这是基于 arXiv 号、期刊卷页完全一致这一强证据
   做出的合理判断，但我没有找到 Witten 本人或出版方就此拼写的勘误声明，严格意义上仍是"极强证据支持
   的推断"而非"逐字确认的官方勘误"。
3. **DBFS 的 [22]（Dunin-Barkowski, Sleptsov, Stern）与 Witten 的其他参考文献条目**本轮未逐一交叉
   核对（不在本任务范围内，只是顺带核实了与 [20]/[21]/[27] 相关的条目）。
4. **本报告提议的新卡文本（§2.3）是建议稿，未经 curator/lead 审阅、未过 `uv run stringgraph validate`**——
   字段格式、`kind`/`status` 取值等需要 lead 或 curator 在实际创建节点时按当前 schema 复核，我没有在
   graph/ 里试跑校验（我的写入范围不含 graph/）。

---

## 5. 给 lead 的执行建议（一句话版）

**建议采纳方案 (c)**：不改动 `math.supermoduli-genus-3-cdvg-ansatz-excluded-by-pole` 的 title/statement
（Q3 裁定 faithful，无需换代）；新增一张卡 `math.supermoduli-witten-genus-3-cdvg-exclusion-remark`
（内容见 §2.3，可直接复制执行）及其推导 `--via-witten-2015`，记录 Witten 2015 本人已对同一篇论文
（[24]=[20]=arXiv:0801.2543，身份本轮已直接核实确认）做出的排除论证；并顺带在 DBFS 卡与相关抽取记录/
bib note 里把"[20] 的确切 arXiv 号未定"这一长期悬置的"未决事项"标记为已解决（本报告 §1.1 给出的是
双方 References 条目的直接比对，不是间接推断）——这一条更新落在 `graph/statements/**`（DBFS 卡 statement
正文的"未决事项"段）与 `literature/**`（bib note、抽取记录），均不在我的写入范围内，需 curator 或 lead
执行。
