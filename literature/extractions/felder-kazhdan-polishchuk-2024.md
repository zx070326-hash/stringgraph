# 抽取记录：felder-kazhdan-polishchuk-2024

- 文献：Giovanni Felder, David Kazhdan, and Alexander Polishchuk, "Superperiods and Superstring Measure
  Near the Boundary of the Moduli Space of Supercurves", arXiv:2408.11136v1 (2024)
- 抽取者：researcher (agent/researcher/supermoduli-post-2024)
- 日期：2026-09-18
- 覆盖范围：摘要 + 目录 + Introduction §1.1/§1.2（pp.1–4），L1 直接读取；**§2 起正文未读**

## 约定

紧化亏格二无穿孔超模叠记 𝔖̄_2（论文用 𝒮̄_g 记号，本抽取沿用论文自己的记号 𝒮_g / 𝒮̄_g，与
correa-noja-2026 / donagi-witten-2013 的 𝔐_g / 𝔐̄_g 记号是同一对象的不同符号约定，指称相同）。
第二障碍类同样是 Green 意义下的类，ω₂ ∈ H¹(M, T₊ ⊗ Λ²V*)。

## 陈述

### E1 摘要（逐字核实，经 arXiv API 验证）
- 位置：摘要
- 类型：proposition（论文自身对全文结果的概括）
- 原文陈述（逐字，经 export.arxiv.org API 二次核验）：
  "We study the behavior of the superperiod map near the boundary of the moduli space of stable
  supercurves and prove that it is similar to the behavior of periods of classical curves. We consider
  two applications to the geometry of this moduli space in genus 2, denoted as S̄₂. First, we
  characterize the canonical projection of S̄₂ in terms of its behavior near the boundary, proving in
  particular that S̄₂ is not projected. Secondly, we combine the information on superperiods with the
  explicit calculation of genus 2 Mumford isomorphism, due to Witten, to study the expansion of the
  superstring measure for genus 2 near the boundary. We also present the proof, due to Deligne, of
  regularity of the superstring measure on S̄_g for any genus."
- 文献自称的严格程度："we prove"（非投影性结论）；正则性结论明确归功于他人（"due to Deligne"，
  "We reproduce his argument"）。
- 文献列出的依赖：无（摘要层面）。
- 备注：**关键范围澄清**——摘要**只在"genus 2"（S̄₂）语境下**宣称非投影性结果，未在摘要中对任意/
  更高亏格的非投影性做出断言。"any genus"的断言**仅限于正则性**（regularity），与可投影性
  （projectedness）是两个不同的技术命题（正则性是"测度不发散/不多值"，可投影性是"是否存在到约化
  空间的全纯投影"，参见 `research/attempts/genus-five-supermeasure/proof.md` §2.5 表格已正确区分
  这两者，本条独立核实此区分成立）。

### E2 目录/引言核实：Theorem 6.3 是本文的核心非投影性定理，专属亏格 2
- 位置：目录（Contents, p.1）+ §1.2.3（p.4）
- 类型：definition（范围核实）
- 原文陈述（忠实转述 + 局部逐字）：目录第 6 节标题为"Canonical projection for genus 2 moduli of
  supercurves"，其中 6.2 为"Regularity of the canonical projection"；§1.2.3 引言逐字写道：
  "We apply our results on superperiods to the study of the canonical projection π^can: S₂ → S_{2,bos}
  induced by the superperiod map (see Sec. 6). Note that there exists no projection on S_g for g ≥ 5
  (see [11]), and there seems to be no canonical projection for g > 2 (for g = 3 the projection given
  by the superperiod map is only defined away from the hyperelliptic locus). We show that π^can extends
  to a regular projection on S̄₂ away from the (−,−) separating node divisor D^{−,−}...i.e., the divisor
  corresponding to reducible curves with a pair of odd spin structures on its components (see Theorem
  6.3). In fact, we show that π^can is the unique projection regular at a generic point of each
  boundary divisor corresponding to a non-separating node. As a consequence, we derive that S̄₂ is not
  projected."
- 文献自称的严格程度："we show"，"we derive"——完整证明性陈述。
- 文献列出的依赖：本文 §2–§5 建立的超周期映射边界行为结果；引用 [11]（本抽取未核实其具体身份，
  疑似 Donagi–Witten 或相关非投影性文献，供 g≥5 情形的背景对照，非本文自己的定理）。
- 备注：**"Theorem 6.3"确认是 correa-noja-2026 的 E2/E4 条目所指的"Felder–Kazhdan–Polishchuk
  genus-two even non-projectedness theorem"、"[10, Theorem 6.3(i)]"**——身份链条至此完全闭合：
  Corrêa–Noja 引用的 [10, Theorem 6.3(i)] 就是本文 §6 的 Theorem 6.3，其断言范围**明确限定在
  亏格 2**（S̄₂），不是 g≥3 的一般结果。**本文正文（§1.2.3）自己也明确说"seems to be no canonical
  projection for g > 2"，暗示作者本人也认为亏格 3 及以上是不同/更难的问题，未在本文中处理。**

### E3 亏格≤11 正则性结果的出处修正（区分本文与另一篇 FKP 论文）
- 位置：§1.1（p.2）
- 类型：definition（文献学澄清）
- 原文陈述（逐字）："In [14] we proved that μ extends regularly across this divisor for g ≤ 11. Recently,
  Pierre Deligne gave a simple proof of the regularity of μ for any genus. We reproduce his argument in
  Section 2."
- 文献自称的严格程度：明确区分"本文之前的另一篇 FKP 论文 [14]"（证明 g≤11 的正则性）与"本文转述的
  Deligne 论证"（覆盖任意亏格）。
- 文献列出的依赖：参考文献 [14]（本抽取未获取该条目具体书目信息，因参考文献列表页未读——见"未解决的
  疑问"）；Deligne 未发表的论证（本文声称"reproduce"）。
- 备注：**这修正了 `research/attempts/genus-five-supermeasure/proof.md` 附录里的一处未核实猜测**：
  该文档曾写"FKP 亏格≤11 正则性结果（Selecta Math 2021）的具体 arXiv 号——本轮只核实到 2024 年的
  后续论文 arXiv:2408.11136"，暗示 2408.11136 本身就是那篇 g≤11 论文；**本条目 L1 核实到的正确关系
  是：g≤11 结果在一篇更早的、本文引用为 [14] 的独立论文里，本文（2408.11136）是引用/转述 Deligne
  推广论证的后续论文，不是同一篇**。经 correa-noja-2026 抽取文件 E8 交叉核对，FKP 另有一篇
  "The moduli space of stable supercurves and its canonical line bundle"，Amer. J. Math. 145 (2023)
  1777–1886，arXiv:2006.13271——**该文极可能就是这里的 [14]**（发表时间 2023 早于本文 2024，主题
  "moduli of stable supercurves"与正则性论证的语境吻合），但本抽取者**未直接核对本文参考文献列表
  第 [14] 条目的具体书目信息**来确认这一推测，故此对应关系标记为待核（见"未解决的疑问"）。

## 未解决的疑问

1. **§2 起正文完全未读**（仅读了摘要 + 目录 + §1.1/§1.2，即前 4 页），Theorem 6.3 的具体陈述文本、
   Corollary 5.10(ii) 的具体内容（correa-noja-2026 E2 引用"[10, Corollary 5.10(ii)]"用于 gluing
   coordinate 展开）均**未直接核实原文**，只从 Corrêa–Noja 论文的转述与本文目录/引言的间接印证中
   确认了大致范围和结论文字。若 curator 要把 Theorem 6.3 做成独立图节点并标注精确依赖，**必须先补读
   本文 §6 全文**，本抽取只能支撑"存在这样一条定理、其范围是亏格 2、其大致断言是 S̄₂ 非投影"这一
   层级的引用，不足以支撑逐字的定理文本转录。
2. **参考文献 [11]、[14] 的具体身份未核实**（未读参考文献列表页），[11] 疑似与"g≥5 无投影"相关
   （很可能是 donagi-witten-2013 或 donagi-noja-2026，但未证实），[14] 疑似是
   arXiv:2006.13271（见 E3 备注），**均标记为推测，不作为确定结论引用**。
3. **本文与 correa-noja-2026 的关系是否真的是"correa-noja-2026 Theorem 4.3 完全等价于本文
   Theorem 6.3(i)"，还是"correa-noja-2026 用不同方法独立证明了同一命题的一个变体"**：
   correa-noja-2026 E2 原文明确说"Our argument is not independent of [10] though, as it relies on
   their boundary expansion of the superperiod map and the elementary hyperelliptic invariant-theoretic
   vanishing entering their analysis of projections"——这说明 Corrêa–Noja 的论证**部分依赖**（不是
   完全独立于、但也不是简单抄录）本文的具体技术引理（超周期映射边界展开 + 超椭圆不变量论消没），
   而不是仅仅"复述同一个定理"。精确的技术依赖关系（哪个具体命题被直接借用）需要补读本文 §3/§4/§6
   与 correa-noja-2026 §4 做逐条对照才能确认，本轮未做这一步。
