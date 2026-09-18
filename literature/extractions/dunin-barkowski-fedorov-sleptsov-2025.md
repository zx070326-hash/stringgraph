# 抽取记录：dunin-barkowski-fedorov-sleptsov-2025

- 文献：Petr Dunin-Barkowski, Igor Fedorov, and Alexey Sleptsov, "RNS superstring measure for genus 3",
  arXiv:2505.02950v2（**确切标题、作者全名经 export.arxiv.org API 核对**，J. High Energ. Phys. 2025,
  193 (2025)）
- 抽取者：researcher (agent/researcher/supermoduli-post-2024)
- 日期：2026-09-18
- 覆盖范围：摘要（经 arXiv API 逐字核对）+ pp.1–10（封面、目录、Introduction §1.1–§1.8，含关键 CDvG
  批评段落）+ pp.42–52（全部参考文献列表 pp.48–52），L1 直接读取（Read 工具渲染 PDF 页面）。
  **pp.11–41（技术推导 §2–§6 与附录 A–D）未读**，属公式密集的计算细节，本轮未覆盖。

## 约定

亏格 3 RNS 超弦测度记 π_*ψ_3（或 μ_3），Siegel 上半空间 H_3；Mumford 同构/形式记 φ_3。约定与
witten-2013-holomorphic-measures、donagi-witten-2013 等既有图节点文献一致（本文延续 Witten
2013/2015 系列论文的记号）。

## 陈述

### E0 摘要（逐字核实，经 export.arxiv.org API 校验；修正本抽取者此前对 E2 严格程度的误记）
- 位置：摘要
- 类型：proposition
- 原文陈述（逐字）："We propose a new formula for the RNS supersting measure for genus 3. Our
  derivation is based on invariant theory. We follow Witten's idea of using an algebraic
  parametrization of the moduli space (which he applied to re-derive D'Hoker and Phong's formula for
  the RNS superstring measure for genus 2); but the particular parametrization that we use has not
  been applied to superstring theory before. We prove that the superstring measure is a linear
  combinaition (with complex coefficients) of three known functions. Furthermore, we conjecture the
  values of the coefficients of this linear combination and provide evidence for this conjecture.
  Unlike the Ansatz of Cacciatori, Dalla Piazza and van Geemen from 2008, our formula has a polar
  singularity along the hyperelliptic locus; the existence of this singularity was established by
  Witten in 2015. Moreover, our formula is not an Ansatz but follows from first principles, except for
  the values of the three coefficients."
- 文献自称的严格程度："we prove"用于"测度是三个已知函数的线性组合"这一**形式**；"we conjecture"
  用于**三个系数的具体数值**（全部三个系数都是猜测值，非"两证一猜"）——**本条修正了本抽取者此前
  （压缩前会话）在 E2 里记录的"两个系数证明+一个猜测"这一误记，正确表述应为"线性组合的形式本身被
  证明，三个系数的具体取值全部是猜测（有证据支持但未证明）"**，见 E2 更正版。
- 文献列出的依赖：D'Hoker–Phong 亏格二公式（本文方法论所本）；Witten 用代数参数化重新推导 D'Hoker–
  Phong 亏格二公式的先例工作；Witten 2015 关于超椭圆轨迹极点存在性的结果。
- 备注：无。

### E1 §1（引言）核实：CDvG 2008 亏格三 Ansatz 缺失奇点的精确措辞（逐字，未替作者加强）
- 位置：p.5，§1 引言中讨论既有构造的段落
- 类型：definition（对既有文献的批评性论证，非本文自己的新定理，但本文据此立论）
- 原文陈述（逐字，L1 直接读取 PDF）："the Ansatz of [20] is holomorphic everywhere on the Siegel upper
  half-space H_3, so this Ansatz cannot be a formula for π_*ψ_3/φ_3."
  摘要（E0）里对应的表述是："Unlike the Ansatz of Cacciatori, Dalla Piazza and van Geemen from 2008,
  our formula has a polar singularity along the hyperelliptic locus; the existence of this singularity
  was established by Witten in 2015."
- 文献自称的严格程度：作者明确的逻辑推断陈述（"so this Ansatz cannot be...")，依赖于本文引用的
  Witten 2015 关于极点存在性的既有结果，而非本文自己重新证明极点存在性；**这是一个条件性的排除论证
  （若 Witten 2015 的极点结果成立，则 CDvG Ansatz 不能是正确公式），不是"CDvG 的计算本身有误/计算
  错误"的断言**——CDvG 的构造本身没有被指出计算错误，只是被指出"不满足真实测度必须满足的一个额外
  解析性质（超椭圆轨迹处应有极点）"。
- 文献列出的依赖：[20] = Cacciatori, Dalla Piazza, van Geemen 2008（具体是哪一篇见备注）；Witten
  2015 关于极点存在性的结果（本抽取核实其 arXiv 号见 E3，[27] = arXiv:1501.02499）。
- 备注：**严格保留原文的限定性措辞，不做加强**——本条只忠实转述"CDvG 的 Ansatz 不能是 π_*ψ_3/φ_3
  的公式（因为它全纯，而真实测度应该有极点）"，**不写成"CDvG 2008 的结果被证明是错误的"这类更强的
  泛化断言**。**[20] 的准确身份（更新，见"未解决的疑问"1）**：经独立 WebSearch 核实，Cacciatori–
  Dalla Piazza–van Geemen 2008 年发表了两篇相关论文：(a) "Modular Forms and Three Loop Superstring
  Amplitudes"，arXiv:0801.2543，Nucl. Phys. B800 (2008) 565–590——**这一篇专门处理亏格三（"three
  loop"）**，与本文批评段落的"H_3"语境直接吻合；(b) "Genus four superstring measures"，
  arXiv:0804.0457，Lett. Math. Phys. 85 (2008) 185–193——**这一篇是亏格四**。**本抽取者此前
  （压缩前会话）曾把两者混淆，误以为[20]是"Genus four superstring measures"；现推断[20]更可能是
  (a) arXiv:0801.2543（因为语境是亏格三），但本抽取者仍未在 DBFS 参考文献表原文的[20]条目里直接
  核对到该数字串或篇名**，故仍标记为待核（见"未解决的疑问"1），此处只是把候选范围从"不确定是哪一篇"
  缩小到"很可能是(a)而非(b)"，不作为最终确定结论。

### E2 本文自身主结果：三个已知函数的线性组合，形式证明，系数猜测（更正版，取代此前误记）
- 位置：Introduction（约 p.2–p.4）+ 摘要（E0）
- 类型：proposition
- 原文陈述（忠实转述，基于 E0 逐字摘要 + 已读引言页面）：本文提出亏格三超弦测度的一个显式公式，
  证明它必为三个已知（此前文献中已出现过）函数的**某个复系数线性组合**这一**形式**；但该线性组合
  的三个具体复系数**全部**未被证明，只是猜测值，本文提供了支持该猜测的证据（间接论证/数值/一致性
  检验，具体证据形式未读到逐字精度）。
- 文献自称的严格程度：明确的"proven form + conjectured coefficients"二分——"we prove"仅用于线性
  组合的存在性/形式，"we conjecture"用于全部三个系数的取值。
- 文献列出的依赖：D'Hoker–Phong 亏格二公式；Witten 用代数参数化重导亏格二公式的方法论先例；[26]
  FKP Selecta 正则性结果（本抽取核实其 arXiv 号见 E3）；[29] Donagi–Witten arXiv:1304.7798。
- 备注：**curator 若要把这一结果做成图节点，必须严格区分"线性组合形式（proven）"与"三个系数数值
  （conjectured，全部）"，不能写成"两证一猜"（那是本抽取者压缩前的误记，已在此更正）**。具体哪个
  定理编号对应"形式证明"、猜测系数的具体数值与证据形式，需要补读 §2–§6 正文才能精确定位，本轮仅
  核实到摘要+引言级别的这一结构性描述。

### E3 参考文献列表逐条核实（解决多个此前未核实的 arXiv 号）
- 位置：References，pp.48–52
- 类型：definition（文献学记录）
- 原文陈述（逐字/接近逐字摘录相关条目，L1 直接读取参考文献列表页）：
  - [20] Cacciatori, Dalla Piazza, van Geemen 2008 相关条目（**参考文献条目本身未见明确标注 arXiv
    号字符串**，具体是 arXiv:0801.2543 还是 arXiv:0804.0457 未直接核对到，见 E1 备注与"未解决的
    疑问"1，标记为待核）。
  - [22] Dunin-Barkowski, Sleptsov, Stern 相关早期论文，本抽取者读到条目但**未记录其确切标题/
    arXiv 号至可逐字复核的精度**，仅确认条目存在于 [22] 位置（待补核）。
  - [26] Felder, Kazhdan, Polishchuk, 正则性/Deligne-Mumford 紧化相关论文（Selecta Mathematica
    系列），本抽取者读到并核实其 arXiv 号为 **1905.12805**。
  - [27] Witten, Edward, "The super period matrix with Ramond punctures", arXiv:**1501.02499**。
  - [29] Donagi, Ron and Witten, Edward, "Supermoduli space is not projected", arXiv:**1304.7798**
    （与既有图节点 `math.supermoduli-space-not-projected` 所引同一篇）。
  - [34] Felder, Kazhdan, Polishchuk, "The moduli space of stable supercurves and its canonical line
    bundle", arXiv:**2006.13271**（与 correa-noja-2026 参考文献 [9] 为同一篇论文，本条目独立交叉
    确认了该 arXiv 号）。
  - [43] Felder, Kazhdan, Polishchuk, "Superperiods and superstring measure near the boundary of the
    moduli space of supercurves", arXiv:**2408.11136**（本项目 felder-kazhdan-polishchuk-2024，即
    correa-noja-2026 的 [10]）。
- 文献自称的严格程度：不适用（参考文献列表条目）。
- 文献列出的依赖：不适用。
- 备注：**[20]、[22] 的具体 arXiv 号本轮未能在参考文献表原文中直接、逐字核对到**，这两项标记为
  待核，**不作为确定结论写入 bib note**。[26]、[27]、[29]、[34]、[43] 均已逐字核对到明确的 arXiv
  号字符串，可视为确定结论。

## 未解决的疑问

1. **[20] CDvG 论文的确切 arXiv 号未在本文参考文献表中直接核对到**——独立 WebSearch 显示 CDvG 在
   2008 年有两篇候选论文：arXiv:0801.2543"Modular Forms and Three Loop Superstring Amplitudes"（亏格
   三）与 arXiv:0804.0457"Genus four superstring measures"（亏格四）；本文批评段落的"H_3"语境更贴合
   前者，但**本抽取者未在 DBFS 参考文献表 [20] 条目原文中直接核对到具体数字串或篇名**，此推断仅为
   缩小候选范围，不是确定结论。若 lead/curator 需要精确引用，建议直接核对 DBFS 论文参考文献表
   [20] 条目原文（本轮 Read 工具已渲染 pp.48–52，若需可重新定位该具体条目行）。
2. **pp.11–41（技术推导 §2–§6、附录 A–D）完全未读**——E2 中"形式证明+系数猜测"的具体定理编号、
   猜测系数的支持证据的具体形式，均未核实到逐字精度，只核实了摘要+引言级别的结构性描述。若 curator
   需要把这一结果做成图节点并标注精确的 status（proven-form vs conjectured-coefficients），**必须
   先补读 §2–§6 正文**。
3. **[22] Dunin-Barkowski–Sleptsov–Stern 条目的确切标题/arXiv 号未记录到逐字精度**（见 E3），仅
   确认条目存在，具体内容待补核。
4. **本抽取者此前（压缩前会话）在未成文的工作记录里曾误记 E2 的严格程度为"两证一猜"**——本文件的
   E0/E2 已用摘要原文逐字核实并更正为"形式证明+三系数全部猜测"，此为本轮自我纠错，记录在此供 lead
   参考（这类误记若已写入 sources.bib 需要一并检查修正，但截至本次抽取，sources.bib 尚未写入此
   论文的任何条目，无需回溯修正）。
