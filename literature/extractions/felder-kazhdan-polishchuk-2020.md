# 抽取记录：felder-kazhdan-polishchuk-2020

- 文献：G. Felder, D. Kazhdan, A. Polishchuk, "The Moduli Space of Stable Supercurves and Its
  Canonical Line Bundle", arXiv:2006.13271（v1 2020-06-23, v2 2020-07-15, v3 2023-03-06）；
  Amer. J. Math. **145** (2023) no. 6, 1777–1886。
- 抽取者：researcher
- 日期：2026-09-18
- 覆盖范围：全文 74 页（PDF `pdftotext -layout` 落盘 5133 行文本 + 第 1 页原始图像核实关键记号）。
  重点通读 §1 引言（Theorem A/B/C）、§2.2（Definition 2.1/2.4）、§2.6（与经典自旋曲线模叠的关系）、
  §5.1/§5.4（Theorem A 证明骨架）；§3（变形理论）、§4（相对丰满线丛）、§6–§8（Kodaira–Spencer、
  边界因子、典范线丛计算，即 Theorem B/C 的证明）通读但未逐行核对每条引理编号，标注于下方相应条目。

⚠ **任务动机**：本文是 `research/attempts/supermoduli-compactified-punctured/`（原创证明轨道）推论
A/B 的地基性依赖（紧化 + 任意穿孔数超模叠的存在性，即 Theorem A）。该轨道的 prover 此前已直接读取
本文 pp.1–6 做 prior-art 核查（见 `research/attempts/supermoduli-compactified-punctured/prior-art.md`
第 12 条），但本文此前**未登记入 `literature/sources.bib`，也无独立 `literature/extractions/` 记录**。
本条目补齐这一缺口，独立于 prover 的转述重新核实原文。

⚠ **与已登记的 `felder-kazhdan-polishchuk-2024`（arXiv:2408.11136）区分**：那篇标题为
"Superperiods and Superstring Measure Near the Boundary of the Moduli Space of Supercurves"，摘要
自陈**只处理亏格 2**（superperiod 在边界附近的行为）。**本条（arXiv:2006.13271）是完全不同的一篇
论文**：构造任意亏格 g、任意 NS/Ramond 穿孔数 $(n_{NS}, n_R)$ 的紧化超模叠本身（存在性 + 光滑固有性
+ 典范线丛的 Mumford 型同构），是三位作者更早（2020，v3 修订至 2023）、覆盖面远大于 2024 年那篇
的基础性构造论文。

## 约定

本文使用度规无关的代数几何语言（superscheme / superstack over $\mathbb{C}$），不涉及世界面 CFT
的度规号差或 $\alpha'$ 归一化，与本项目 `conv.metric-mostly-plus` / `conv.alpha-prime-regge` 无直接
对应关系需要换算——本文与物理侧约定的接口仅在引言处提及"superstring supermeasure"背景动机，正文
未使用任何物理场论记号。

## 陈述

### E1 Theorem A：紧化 + 穿孔超模叠的存在性与光滑固有性 —— 全文最核心陈述
- 位置：p.1（引言第 4 段之后，无编号定理环境，标题 "Theorem A."）。原始图像核实（`Read` 工具直接
  渲染 PDF 第 1 页，非 `pdftotext` 文本抽取——`pdftotext` 会丢失记号中的上划线，见下方"记号"备注）。
- 类型：proposition（定理，本文正文给出完整证明，见 E6）
- 原文陈述（逐字，记号照抄，$\overline{S}$ 表示 $S$ 头上带上划线；下标 $g, n_{NS}, n_R$）：
  > **Theorem A.** There exists a smooth and proper DM-stack $\overline{S}_{g,n_{NS},n_R}$ over
  > $\mathbb{C}$ representing the functor of families of stable supercurves of genus $g$ with
  > $n_{NS}$ NS punctures and $n_R$ Ramond punctures.
- 文献自称的严格程度：定理（Theorem），全文以此为核心目标之一，证明分布在 §2（定义）、§3（变形
  理论、光滑性）、§4（相对丰满线丛）、§5（存在性：可表性、étale atlas、光滑固有性）。§5.4 是
  证明的收尾一步（见 E6）。
- 文献列出的依赖：证明策略"避开 Artin 判据，改用 Cornalba–Jarvis 对纯偶模问题的既有解"（引言
  逐字："In the rest of the proof we avoid using the Artin's criterion and give a more direct
  proof based on the existing solution of the corresponding purely even moduli problem due to
  Cornalba and Jarvis."）；properness 最终归约到 Cornalba [11]、Jarvis [22] 两篇既有文献的结果
  （见 E6）。
- 备注（**精确记号，逐字核实**）：
  - 紧化叠写作 $\overline{S}_{g,n_{NS},n_R}$，**带上划线**（第 1 页原始 PDF 图像逐字确认，
    `pdftotext -layout` 抽取的纯文本会把上划线丢失、渲染成裸 "Sg,nNS,nR"——**引用本文记号时
    必须用图像核实过的带 bar 版本，不要照抄 pdftotext 输出**，这是本轮抽取过程中发现的一个
    真实的 OCR/文本抽取陷阱，特此记录防止后来者照抄纯文本版）。
  - 未紧化的模空间在引言首句写作不带 bar 的 $S_g$（"The moduli space $S_g$ of supercurves of
    genus $g$..."，p.1 第一段），紧化后加 bar 得 $\overline{S}_g$ / $\overline{S}_{g,n_{NS},n_R}$——
    这与本项目已有节点 `math.supermoduli-space-not-projected` 等使用的 $\mathfrak{M}_g$ /
    $\overline{\mathfrak{M}}_g$ 记号族是**不同的记号系统**（FKP 用花体 $S$，Donagi–Witten/
    Corrêa–Noja 系用花体 $\mathfrak{M}$），curator 若要并列引用两套文献须显式注明记号差异。
  - 引言紧接 Theorem A 之后逐字："After we finished this work we learned about the work of
    Moosavian and Zhou [27], where Theorem A is also proved."——**Theorem A 有独立的第二个证明**
    （Moosavian–Zhou，本条目未追查该文献书目或是否已登记，供 curator/lead 参考）。同段落还提到
    "Another work with some foundational results, including the existence of Hilbert and Picard
    superschemes, is the forthcoming paper [7]"——第三方相关但非同一结果的另一篇（本条目未展开）。

### E2 穿孔的精确定义：NS 穿孔（截面）与 Ramond 穿孔（相对 Cartier 除子）
- 位置：§2.2, Definition 2.1（p.4–5）与 Definition 2.4（pp.5–6）
- 类型：definition
- 原文陈述（逐字，Definition 2.4(i)）：
  > A supercurve with punctures over $S$, is a superscheme $X$ of finite type over $S$, flat and
  > relatively Cohen–Macaulay, together with
  > • a collection of disjoint closed subschemes called NS-punctures and R-punctures
  >   $P_i \subset X, i = 1,\dots,n_{NS}$; $R_i \subset X, i = 1,\dots,n_R$,
  >   such that the projection $P_i \to S$ is an isomorphism, and each $R_i$ is a Cartier divisor
  >   (flat over $S$);
  > • a derivation $\partial: O_X \to \omega_{X/S}(R)$, trivial on pull-backs of functions on $S$,
  >   where $R = \sum R_i$. …
  > We impose the following additional properties.
  > • There is an open fiberwise dense subset $U \subset X$ such that $U/S$ is smooth of
  >   dimension $1|1$, and $P_i \subset U$, $R_i \not\subset U$;
  > • the derivation $\partial$ corresponds to a structure of a smooth supercurve with Ramond
  >   punctures on $(U, (R_i))$ over $S$;
  > • on every geometric fiber $X_s$, $\partial^-$ induces an isomorphism
  >   $O_{X_s}^- \xrightarrow{\sim} \omega_{X_s}(\sum R_{i,s})^-$;  (2.4)
- 文献自称的严格程度：定义（Definition），后续引理/定理逐步验证其良定性。
- 文献列出的依赖：Ramond 穿孔的局部结构依赖 §2.1（superstack 基础，引 [8]、[6, Sec.2]）与 §2.4
  （supercurve with Ramond punctures 的局部标准形式，Definition 2.1，p.4–5）。
- 备注：NS 穿孔 $P_i$ 是**截面**（像通常的 marked points），Ramond 穿孔 $R_i$ 是**相对 Cartier
  除子**（p.1 引言已先给出直观描述："NS punctures are like marked points... Ramond punctures have
  a different nature: they are given by relative Cartier divisors $R \subset X$ such that the
  projection $R \to S$ is smooth of dimension $0|1$"）。这一结构性区分是 Theorem A 陈述中
  $n_{NS}$ 与 $n_R$ 两个独立量词分别计数"两类不同东西"的原因，不是记号上任意的区分。

### E3 稳定性定义：把 $(g, n_{NS}, n_R)$ 的隐含约束落到「玻色化后是通常稳定曲线」
- 位置：§2.2, Definition 2.4(ii)（p.6）
- 类型：definition
- 原文陈述（逐字）：
  > (ii) A supercurve with punctures $(X \to S, P, R)$ is called stable (resp., prestable) if $X$
  > is proper over $S$ and for every geometric fiber $X_s$, passing to the bosonic truncation
  > $(X_s)_{bos}$ with the marked points induced by $(P_i)$ and $(R_i)$ one gets a usual stable
  > (resp., prestable) pointed curve.
- 文献自称的严格程度：定义。
- 文献列出的依赖：依赖经典（非超）稳定标点曲线的标准稳定性定义（未在本文重新展开，视为已知）。
- 备注：⚠ **这是 Theorem A 对 $(g, n_{NS}, n_R)$ 三个量词唯一的约束来源，但本文正文没有把它写成
  一条显式数值不等式**（例如通常代数几何教材里的 $2g-2+n>0$）。本文只说"玻色化后按通常标点曲线
  的稳定性判据即可"，把 $n_{NS}$ 个 NS 穿孔与 $n_R$ 个 Ramond 穿孔**都**算作玻色化曲线上的
  marked points（"the marked points induced by $(P_i)$ and $(R_i)$"）。**逐字复述这条定义即可
  推出**通常意义下需要 $2g - 2 + n_{NS} + n_R > 0$（亏格 0 时至少 3 个穿孔、亏格 1 时至少 1 个、
  亏格 ≥2 时无额外约束），**但这是本抽取记录读者的复述/常识性代入，不是本文逐字写出的不等式**——
  本文全文（`pdftotext` grep 核实，见"未解决的疑问"第 1 条）**没有出现** "$2g-2+n$" 或等价的
  显式数值表达式。curator 若要在图节点里写出这条数值不等式，应标注为从 Definition 2.4(ii) 的
  文字定义**推出**（可视为 `inferred: false` 的直接展开，因为是标准定义的直接代入，但**不能**
  声称"本文逐字给出该不等式"）。
  ⚠ 另外，本文全文也**没有**对 $g, n_{NS}, n_R$ 的非负整数性给出显式声明（如 "for all
  $g, n_{NS}, n_R \geq 0$ satisfying..."）——这是代数几何论文里默认的记号习惯（下标本身即隐含
  非负整数），未见反例迹象，但严格按"逐字"标准，本文没有专门写这句话。

### E4 §2.6：与经典"稳定自旋曲线模叠"的关系 —— "$n_R$ necessarily even" 的精确归属
- 位置：§2.6 "Supercurves over even bases and spin curves"（p.13–14）
- 类型：proposition/remark（正文段落陈述，非独立编号定理）
- 原文陈述（逐字）：
  > If we only consider even bases, the functor of (stable) supercurves with punctures coincides
  > with the functor of stable curves with punctures equipped with generalized spin structures
  > i.e., coherent sheaves $L$ as in Lemma 2.6. Note that in the setting of Lemma 2.6 we still
  > refer to the two kinds of marked points $p$ and $r$ and NS and Ramond punctures.
  >
  > The moduli stack $S_{g,n_{NS},n_R}$ of stable spin curves of genus $g$ with $n_{NS}$
  > NS-punctures and $n_R$ Ramond punctures (**where $n_R$ is necessarily even**) was studied in
  > [22], [23], as a particular case of the stack of stable $r$-spin curves. In particular, it
  > [is] shown to be a smooth proper Deligne-Mumford stack.
- 文献自称的严格程度：正文陈述，引用 [22]、[23]（Jarvis 的两篇文章，本条目未逐一核实完整书目）
  对经典（非超）"稳定自旋曲线模叠" $S_{g,n_{NS},n_R}$ 已有的固有性/光滑性结果，本文**引用**该
  结果作为 Theorem A 证明中 properness 归约的落点（见 E6），不是本文自证。
- 文献列出的依赖：[22]、[23]（Jarvis 关于 $r$-spin 曲线模叠的文章，本条目未核实完整书目条目）；
  Remark 2.17（紧邻其后，p.14）进一步指出 [22]/[23] 的粗模空间与 Cornalba [11] 构造的经典自旋
  曲线模空间给出同一个紧化。
- 备注：⚠⚠ **本条是本轮抽取发现的一个真实、容易被后续引用者读错的陷阱**——"$n_R$ is necessarily
  even" 这句话**逐字只附着于 [22]/[23] 此前研究的经典对象** $S_{g,n_{NS},n_R}$（不带 bar，且是
  "限制到偶基"之后与本文超曲线构造重合的**那个特定对象**），**本文正文没有在任何其他地方**（含
  Theorem A 自身的陈述、引言、§5 证明部分）**重申或声称 $\overline{S}_{g,n_{NS},n_R}$（带 bar，
  Theorem A 构造的对象）本身要求 $n_R$ 为偶数**。两种可能的读法：
  (a) 因为限制到偶基后两个函子重合（本段第一句逐字所说），$n_R$ 必须偶数这一约束**对 [22]/[23]
      构造的对象成立，逻辑上也应对本文的 $\overline{S}_{g,n_{NS},n_R}$ 的偶部分成立**（即
      $\overline{S}_{g,n_{NS},n_R}$ 若 $n_R$ 为奇数，其偶部分/粗模空间可能是空的或退化的）；
  (b) 但本文的 $\overline{S}_{g,n_{NS},n_R}$ 是**超**空间（superstack），不只是偶基上的经典
      自旋曲线模叠，"必须偶数"这条对经典对象成立的约束**是否原样搬到超情形**本文未明说。
  **本条目不做 (a)/(b) 之间的判定**——这属于"我觉得它其实依赖 X"式的推断，按 `literature/CLAUDE.md`
  规则 2 留给 curator 处理，标 `inferred` 并附此条备注。**若 `research/attempts/
  supermoduli-compactified-punctured/` 的推论 A/B 在任何步骤里用到"$n_R$ 必为偶数"这一约束，
  必须显式核实其来源是本条（[22]/[23] 限定的经典对象），而不能默认它对 Theorem A 本身的
  $\overline{S}_{g,n_{NS},n_R}$ 无条件成立。**

### E5 Theorem A 的证明落点：光滑性（Corollary 3.20）+ 固有性归约到偶部分（Cornalba/Jarvis）
- 位置：§5.4 "Properties of the stack of stable supercurves"（p.31–32，紧接 §5.1–§5.3 可表性/
  étale atlas 论证之后）
- 类型：proposition（证明段落）
- 原文陈述（逐字）：
  > Corollary 3.20 shows that the stack of stable supercurves is smooth. Since it is of finite
  > type (for each fixed genus and fixed number of punctures), the fact that it is proper can be
  > checked for its even part, i.e., for the stack of stable curves with spin structures. But this
  > is known due to works of Cornalba [11] and Jarvis [22].
- 文献自称的严格程度：这是 Theorem A 证明的最后一步，本文自己完成"光滑性"的证明（引 Corollary
  3.20，本文内部结果），但"固有性（properness）"这一步**外包给** Cornalba [11]、Jarvis [22]
  对经典自旋曲线模叠固有性的既有证明（"it is known due to..."——即本文自认这一步不是本文原创，
  是复用既有文献结果）。
- 文献列出的依赖：Corollary 3.20（本文内部，§3 变形理论一节，本条目未展开核实其证明细节）；
  Cornalba [11]；Jarvis [22]。
- 备注：这是判断"Theorem A 的证明严格程度"最关键的一段——**Theorem A 并非从零开始独立证明**，
  它把"任意亏格、任意穿孔数"的**超**情形的固有性问题，**归约**到经典（非超）"稳定自旋曲线模叠"
  固有性这一**已被 Cornalba、Jarvis 证明过**的事实。这与 E4 揭示的"限制到偶基与经典自旋曲线模叠
  重合"是同一机制的两处体现（E4 是函子层面的等同，E5 是用这个等同完成 properness 证明）。
  若 `research/` 原创轨道要引用 Theorem A 作为"已证明"的前提，应知道它的证明链条最终触底在
  Cornalba 1991（或类似年份，本条目未核实完整书目）与 Jarvis 的两篇论文，而不是本文独立发明的
  全新固有性论证。

### E6 Theorem B / Theorem C（典范线丛，供背景参考，非本轮核实重点）
- 位置：p.2–3（引言），正式证明分别在 §6–§8
- 类型：proposition
- 原文陈述（Theorem B，逐字，部分下标因 `pdftotext` 丢失渲染标注 `[OCR:丢失上下标]`）：
  > **Theorem B.** Let $S = \overline{S}_{g,n_{NS},n_R}$. There exists a canonical isomorphism
  > $K_S \cong SM_S \otimes Ber_1^{\otimes 5} \otimes \bigotimes_{i=1}^{n_{NS}} \mathcal{L}_i
  > \otimes O(-2\Delta_{NS} - \Delta_R)$ [OCR:丢失上下标，公式结构据 p.2 文字推断复原，
  > **未逐符号核对原始图像，仅供背景参考**]，where $\Delta_{NS}$ and $\Delta_R$ are the
  > components of the boundary divisor corresponding to nodes of NS and Ramond type, and
  > $\mathcal{L}_i$ is the line bundle associated with the $i$-th NS puncture $P_i$:
  > $\mathcal{L}_i = P_i^* \omega_{X/S}$.
  > In the case when there are no punctures the isomorphism becomes
  > $K_{\overline{S}_g} \cong Ber_1^{\otimes 5}(-2\Delta_{NS} - \Delta_R)$.
- 文献自称的严格程度：定理，证明见 §6–§8。
- 文献列出的依赖：Theorem A（作为空间存在性前提）；§6 Kodaira–Spencer 映射；§7 边界除子构造；
  §8 典范线丛计算。
- 备注：⚠ **Theorem B/C 的公式本轮未逐符号核对原始图像**（不同于 E1 对 Theorem A 记号的图像
  核实）——`pdftotext -layout` 对这两条定理的张量积/指数/下标符号丢失严重（见"未解决的疑问"
  第 2 条），本条目转录的公式结构基于文本上下文推断复原，**不保证与原文逐符号一致**，仅作背景
  参考记录"本文除 Theorem A 外还证明了典范线丛的 Mumford 型公式"这一事实，**不建议 curator 直接
  引用本条目的 Theorem B 公式作为图节点来源**，除非另行用图像核实原文。Theorem C（p.3，边界除子
  上正规丛与低亏格模空间典范丛的关系）同样未核实，仅记录其存在与大致内容（粘接映射的法丛识别）。

## 未解决的疑问

1. **本文全文是否出现显式数值不等式 $2g-2+n_{NS}+n_R>0$**：`pdftotext` 关键词检索（`grep -n
   "2g - 2 +"` 及变体）未命中任何形如该不等式的显式表达式；本条目判断这一约束是从 Definition
   2.4(ii)（E3）的文字定义**隐含**得到，本文**没有**把它单独写成一条不等式陈述。若后续需要
   "本文逐字给出稳定性数值范围"这一更强的断言，本轮结论是：**没有，只有文字定义。**
2. **Theorem B/C 的公式因 `pdftotext` 符号丢失未逐符号核对**（见 E6 备注）。若 curator 需要引用
   Theorem B/C 的精确公式作为图节点来源，应安排后续轮次用 `Read` 工具直接渲染对应页面图像核实
   （仿照本轮对 Theorem A/第 1 页的做法），本轮时间预算全部给了 Theorem A（任务书明确要求）。
3. **$n_R$ 奇偶性约束对 Theorem A 本身是否成立**（E4 备注 (a)/(b) 两种读法未判定）——这是留给
   curator 的开放问题，若 `research/attempts/supermoduli-compactified-punctured/` 的证明依赖此
   约束，必须先在那里显式核实，不能想当然地从 §2.6 关于经典自旋曲线模叠的陈述外推到本文自己的
   超曲线模叠。
4. **[22]、[23]（Jarvis）、[11]（Cornalba）的完整书目信息本轮未核实**（E4/E5 提到的依赖来源）。
   若 curator 需要在图节点里给出这两条依赖的独立来源，需要另外核实本文参考文献表 [11]/[22]/[23]
   的完整书目条目（本轮受任务书时间预算限制，聚焦 Theorem A 本身，未展开核实参考文献表）。
5. **Moosavian–Zhou [27]（Theorem A 的独立平行证明，E1 备注）与 forthcoming paper [7]**（Hilbert/
   Picard superscheme 存在性）的完整书目信息本轮未核实，供后续参考。

---

# 第二轮抽取（2026-09-18）：§7.5 / §8.4 / §9 的粘接机器

- 抽取者：researcher（agent/researcher/fkp-deep-gluing）
- 日期：2026-09-18
- 版本：arXiv:2006.13271**v3**（2023-03-07 编译，74 页；`curl -sL https://arxiv.org/pdf/2006.13271v3`）
- 页码约定：**PDF 页码 = 排版页眉页码**（已在 pp.45/47/49/56/58/59/61 逐页核对页眉数字，例如 PDF 第 58 页
  页眉印 "58"）。本节所有页码均指该编号，**不是** AJM 145 (2023) 1777–1886 的期刊页码。
- 方法等级（沿用 `alvarez-gaume-witten-1984.md` §0 的 L0–L4 制）：
  **本轮 E7–E15 的每一条公式与逐字引文均为 L1**——用 `Read` 工具直接渲染 PDF 页图像逐字核对
  （pp.2–3、45–50、56–61、70–71），`pdftotext -layout` 只用于定位与 ASCII 骨架交叉校验。
  (9.6) 与 Example 8.9 的公式另外用 `pdftoppm -r 400` 局部放大复核。
- 覆盖范围：§7.3（(7.6) 边界线丛定义）、§7.4（Prop 7.8）、§7.5（Lemma 7.9、(7.8)、(7.9)、Lemma 7.10）、
  §7.6 开头（Ramond 粘接，Lemma 7.11–7.13）、§8.3 末（Prop 8.5、Theorem 8.6）、§8.4（Lemma 8.7、
  Cor 8.8、Example 8.9、Remark 8.10、Lemma 8.11、(8.11)）、§9.1（全节）、§9.2 抬头、§9.3（Ramond 猜想）、
  §1 引言里的 Theorem B / Theorem C。
- ⚠ **本轮未做**：§9.2 的 Lemma 9.3–9.6 的证明细节（只记录了 Lemma 9.3 的陈述位置）；Theorem C
  证明的收尾（§9.2 末）；§3/§6 的变形理论；参考文献表书目核实。

## 陈述（第二轮）

### E7 §9 开篇与 §9.1 setup：法丛 $N_B \cong \Psi_1^{-1}\otimes\Psi_2^{-1}$ 的**启发式比较论证**
- 位置：p.58，§9 标题段 + §9.1 "NS boundary components" 开头至 p.59 第 3 个公式。L1（页图逐字）。
- 类型：definition + proposition（正文推导段落，无编号）
- 原文陈述（逐字）：
  > **9. Splitting at the boundary divisor**
  >
  > Now we are going to study the restriction of the isomorphism of Theorem B to the boundary
  > divisor. Using our presentation of the line bundle corresponding to the boundary divisor as a
  > Berezinian (see Sec. 7.2) we find a natural identification of the normal line bundle to the
  > boundary divisor. Then we give a proof of Theorem C concerning the NS boundary component.
  > We also give a conjectural statement for the Ramond boundary component.
  >
  > **9.1. NS boundary components.** Let $\iota : B \to \overline{\mathcal{S}}$ be the standard
  > gluing map covering an NS type boundary component, i.e., one of the maps (7.8) or (7.9),
  > restricted to the locus of smooth supercurves. Let $X_B \to B$ denote the universal stable
  > supercurve, which is obtained by identifying two NS punctures $P_1, P_2$ on a smooth supercurve
  > $\widetilde{X} \to B$ into a node $Q \subset X_B$. Let $D_1, D_2 \subset \widetilde{X}$ be the
  > corresponding divisors. Note that we have a finite morphism $\rho : \widetilde{X} \to X_B$, and
  > an exact sequence on $X_B$,
  > $$0 \to \mathcal{O}_{X_B} \to \rho_*\mathcal{O}_{\widetilde{X}} \to \mathcal{O}_Q \to 0.$$
  > In particular, the Berezinian line bundle $\mathcal{B}(\mathcal{O}_{X_B})$ for the family
  > $X_B \to B$ is naturally identified with $\mathcal{B}(\mathcal{O}_{\widetilde{X}})$ defined for
  > the family $\widetilde{X} \to B$.
  >
  > Note that in the case of a separating node, where $B = \mathcal{S}_1 \times \mathcal{S}_2$, the
  > line bundle $\mathcal{B}(\mathcal{O}_{\widetilde{X}})$ is the exterior product of two similar
  > line bundles on the factors $\mathcal{S}_1$ and $\mathcal{S}_2$.
  >
  > We can rewrite (8.11) near $B$ as an isomorphism
  > $$K_{\overline{\mathcal{S}}}(2\Delta_{NS}) \simeq \mathcal{B}(\mathcal{O}_X)^5.$$
  > Thus, pulling it back to $B$ leads to an isomorphism
  > $$K_B \otimes N_B \simeq \mathcal{B}(\mathcal{O}_{X_B})^5,$$
  > where $N_B$ is the normal bundle defined as the pull-back of $\mathcal{O}(\Delta_{NS})$ to $B$.
  > Note that the universal supercurve over $B$ is equipped with two NS punctures $P_1, P_2$ and the
  > isomorphism (8.11) in smaller genus gives
  > $$K_B \simeq \mathcal{B}(\mathcal{O}_{\widetilde{X}})^5 \otimes \Psi_1 \otimes \Psi_2.$$
  > Comparing with the previous isomorphism we get an isomorphism
  > $$N_B \simeq \Psi_1^{-1} \otimes \Psi_2^{-1}.$$
  > Below we will define such a canonical isomorphism independently and then will check its
  > compatibility with two above isomorphisms.
- 文献自称的严格程度：正文推导（非编号定理）。最后一句**明确声明这只是启发式比较**，真正的定义在
  下文独立给出（即 (9.6)，见 E9），并在 Theorem 9.2（E10）里检验两者相容。
- 文献列出的依赖：(8.11)（即带穿孔版的 Theorem B 公式，p.58 上半页）；Sec. 7.2（边界除子的
  Berezinian 表示，即 (7.6)）；(7.8)/(7.9)（粘接映射，见 E12）。
- 备注（**穿孔判定，逐字证据**）：
  - **支持"与穿孔数无关"的一侧**：setup 句逐字允许 $\iota$ 是 "**one of the maps (7.8) or (7.9)**"，
    而 (7.8)/(7.9) 的定义域/陪域**都带一般的 $(m,n)$ 穿孔指标**（见 E12），setup 本身**没有**加
    "$m=n=0$" 之类的限制。
  - **反面 / 必须如实记下的一侧**：紧接着的比较论证把 (8.11) "near $B$" 重写成
    $K_{\overline{\mathcal{S}}}(2\Delta_{NS}) \simeq \mathcal{B}(\mathcal{O}_X)^5$，**丢掉了 (8.11)
    里的 $\bigotimes_{i=1}^{m}\Psi_i$ 因子**（(8.11) 逐字为
    $K_{\overline{\mathcal{S}}} \simeq \mathrm{Ber}_1^5 \otimes \bigotimes_{i=1}^{m}\Psi_i(-2\Delta_{NS}-\Delta_R)$，
    见 E11 备注）；同样地，下一句只说 $B$ 上的普适超曲线带 "**two** NS punctures $P_1, P_2$"，
    于是 $K_B \simeq \mathcal{B}(\mathcal{O}_{\widetilde{X}})^5 \otimes \Psi_1 \otimes \Psi_2$
    也**只有两个 $\Psi$**。**即：这段比较论证逐字写的是 $m=0$（靶无穿孔）的情形。**
  - 本抽取**不判定**"把 $m$ 个 $\Psi_i$ 加回两边是否相消"——那是推断，留给 curator（若做，须标
    `inferred: true`）。本条只如实记录：**作者在这段里写的是无穿孔形式**。
  - 另注：$\mathcal{B}(\mathcal{O}_{X_B}) \simeq \mathcal{B}(\mathcal{O}_{\widetilde{X}})$ 这一步
    的依据是节点处的正合列 $0 \to \mathcal{O}_{X_B} \to \rho_*\mathcal{O}_{\widetilde{X}} \to
    \mathcal{O}_Q \to 0$，$\mathcal{O}_Q$ 支撑在**节点**上——这是"只用节点邻域局部数据"的第一处
    逐字证据。

### E8 Lemma 9.1（i)–(iv)：(9.6) 的全部技术输入，**证明逐字自陈只在节点的形式/平展邻域里做**
- 位置：p.59（陈述 + (9.1)–(9.5)）、p.60（证明）。L1（页图逐字）。
- 类型：proposition
- 原文陈述（逐字，含 (9.1)–(9.5)）：
  > First, recall that we have a line bundle $\omega^2_{X/S}$ defined on the universal curve of
  > $\overline{\mathcal{S}}$ by extending from the smooth locus (see Theorem 4.1).
  >
  > **Lemma 9.1.** *(i) For any integer $m$ let us set*
  > $$\omega^{2m}_{X_B/B} := \omega^{2m}_{X/\overline{\mathcal{S}}}|_B.$$
  > *Then one has an exact sequence on $X_B$,*
  > $$0 \to \omega^{2m}_{X_B/B} \to \rho_*\omega^{2m}_{\widetilde{X}/B}(mD_1 + mD_2) \to
  >   \mathcal{O}_Q \to 0 \qquad (9.1)$$
  > *where $Q \subset X_B$ is the relative node obtained by gluing $P_1 \simeq B \simeq P_2$. Here we
  > use the canonical trivializations of the restrictions of $\omega^2_{\widetilde{X}/B}(D_1+D_2)$ to
  > $P_1$ and $P_2$ (see Corollary 8.8). Hence, we have a natural isomorphism*
  > $$\mathcal{B}(\omega^{2m}_{X/\overline{\mathcal{S}}})|_B \simeq
  >   \mathcal{B}(\omega^{2m}_{\widetilde{X}/B}(mD_1+mD_2)). \qquad (9.2)$$
  > *(ii) Let us set $\omega^{2m+1}_{X_B/B} := \omega^{2m}_{X_B/B} \otimes \omega_{X_B/B}$. Then one
  > has an exact sequence on $X_B$,*
  > $$0 \to \rho_*\omega^{2m+1}_{\widetilde{X}/B}(mD_1+mD_2) \to \omega^{2m+1}_{X_B/B} \to
  >   Q_*\mathcal{O}_S \to 0. \qquad (9.3)$$
  > *Hence, we have a natural isomorphism*
  > $$\mathcal{B}(\omega^{2m+1}_{X/\overline{\mathcal{S}}})|_B \simeq
  >   \mathcal{B}(\omega^{2m+1}_{\widetilde{X}/B}(mD_1+mD_2)). \qquad (9.4)$$
  > *In addition, we have a natural exact sequence*
  > $$0 \to \omega^{2m+1}_{X_B/B} \to \rho_*\omega^{2m+1}_{\widetilde{X}/B}((m+1)D_1+(m+1)D_2)
  >   \to \mathcal{C} \to 0,$$
  > *where $\mathcal{C}$ is a sheaf supported on the node fitting into an exact sequence*
  > $$0 \to Q_*\mathcal{O}_S \to \mathcal{C} \to Q_*(\Psi_1^{-1} \oplus \Psi_2^{-1}) \to 0.
  >   \qquad (9.5)$$
  > *(iii) One has an exact sequence on $X_B$,*
  > $$0 \to \mathcal{K} \to \Omega_{X_B/B} \to \rho_*\Omega_{\widetilde{X}/B} \to 0,$$
  > *where the sheaf $\mathcal{K}$ is supported on the node, and has a filtration with the subfactors*
  > $$Q_*(\Psi_1^2\Psi_2^2), \; Q_*(\Psi_1^2\Psi_2), \; Q_*(\Psi_1\Psi_2^2), \; Q_*(\Psi_1\Psi_2).$$
  > *In particular, $\mathrm{Ber}\,\pi_*\mathcal{K}$ is canonically trivial, so*
  > $$\mathrm{Ber}\,R\pi_*(\Omega_{X_B/B}) \simeq \mathrm{Ber}\,R\pi_*\Omega_{\widetilde{X}/B}.$$
  > *(iv) One has an exact sequence over the smooth locus of $B$,*
  > $$0 \to j_*\Omega_{U/\overline{\mathcal{S}}}|_{X_B} \to \Omega_{\widetilde{X}/B}(D_1+D_2) \to
  >   \widetilde{\mathcal{C}} \to 0,$$
  > *where $U \subset X$ is the smooth locus of $X \to \overline{\mathcal{S}}$, and the sheaf
  > $\widetilde{\mathcal{C}}$ is supported on the node and has a filtration with the subfactors*
  > $$\mathcal{O}_Q, \; \mathcal{O}_Q, \; Q_*(\Psi_1^{-1} \oplus \Psi_2^{-1}).$$
- 证明梗概（p.60，**局部性的逐字证据**）：
  > *Proof.* (i) We just have to identify the pull-back of the line bundle $\omega^2_{X_B/B}$ to
  > $\widetilde{X}$, $\rho^*\omega^2_{X_B/B}$ with $\omega^2_{\widetilde{X}/B}(D_1+D_2)$. Note that we
  > have a natural identification of these line bundles over the smooth locus of $\widetilde{X}$.
  > Thus, we need to check that it extends to an isomorphism over the node. **For this, it is enough
  > to study these line bundles in an étale neighborhood of the node.** Thus, we can place ourselves
  > in the framework of Sec. 6.2 and use a generator $e$ of $\omega^2_{X/S}$ (see (6.13)). Since
  > $\rho^*e$ is a generator of $\omega^2_{\widetilde{X}/B}(D_1+D_2)$, the assertion follows.
  >
  > (ii) […] We claim that $\omega_{X_B/B}/\omega_{\widetilde{X}/B}$ coincides with the kernel of the
  > addition map $\mathcal{O}_Q \oplus \mathcal{O}_Q \to \mathcal{O}_Q$. **Indeed, this is a local
  > statement.** In local coordinates the generators of two summands $\mathcal{O}_Q$ are
  > $\frac{\theta_i}{z_i}[dz_i|d\theta_i]$, and the generator $s_0$ of
  > $\omega_{X_B/B}/\omega_{\widetilde{X}/B}$ is mapped to their difference. […] To derive the case
  > of arbitrary $m$ from that of $m = 0$, we tensor the sequence (9.5) with the line bundle
  > $\omega^{2m}_{X_B/B}$. By the triviality of $Q^*(\omega^{2m}_{X_B/B})$, we get the sequence of the
  > required form.
  >
  > (iii) First, we note that **$\mathcal{K}$ is supported on the node, so it is enough to prove the
  > assertion after replacing $X_B$ with the formal neighborhood of the node.** Then $\widetilde{X}$
  > becomes the union of two branches $X_1 \sqcup X_2$, so that $P_1 \in X_1$, $P_2 \in X_2$. […]
  > Using Lemma 7.2(ii), one checks that $\kappa$ is an isomorphism, and the assertion follows.
  >
  > (iv) This follows from parts (i), (ii) and from the exact sequence (7.1) (and a similar exact
  > sequence for $\Omega_{\widetilde{X}/B}$ which holds over the smooth locus).
- 文献自称的严格程度：编号引理 + 完整证明（"the assertion follows"，无外包）。
- 文献列出的依赖：Theorem 4.1（$\omega^2_{X/\overline{\mathcal{S}}}$ 的延拓）；Corollary 8.8（$P_i$
  处的典范平凡化）；Remark 8.10（p.60 证明里用到 $\Psi_i^{-1} \simeq P_i^*\omega_{\widetilde{X}/B}(D_i)$）；
  Sec. 6.2 与 (6.13)（节点的平展局部模型）；Lemma 7.2(ii)；(7.1)。
- 备注（**穿孔判定**）：Lemma 9.1 的**陈述与证明中出现的唯一除子是 $D_1, D_2$（粘接用的那两个 NS
  穿孔）**，$\Psi$ 也只有 $\Psi_1,\Psi_2$；**全篇未出现其他穿孔 $P_i$ / $R_j$ 的任何指标**。
  证明里三处逐字自陈局部性（上文加粗处：étale neighborhood of the node / this is a local statement /
  formal neighborhood of the node）。⚠ 但要注意 (iii)、(iv) 的**结论形式**不是纯局部的：它们把局部
  计算**接到全局 Berezinian** $\mathrm{Ber}\,R\pi_*(-)$ 上（$\pi$ 是到 $B$ 的投影，整条曲线），
  局部性保证的是"两个层的差只支撑在节点"，不是"整个同构与曲线其余部分无关"。**本条不替作者
  推断这一差别是否影响带穿孔情形。**

### E9 ★ 式 (9.6)：法丛的**独立**典范同构 —— 承重条目
- 位置：p.60 末段（推导）→ p.61 顶（公式 (9.6)）。L1（页图逐字；(9.6) 另用 `pdftoppm -r 400`
  局部放大二次核对）。
- 类型：proposition
- 原文陈述（逐字；推导段在 p.60，(9.6) 在 p.61）：
  > We can use the definition of the NS boundary line bundle (7.6) to compute the normal bundle over
  > the smooth part of $B$. From the above Lemma we get
  > $$\mathrm{Ber}\,R\pi_*(j_*\Omega_{U/S})|_B \simeq
  >   \mathrm{Ber}\,R\pi_*(\Omega_{\widetilde{X}/B}(D_1+D_2)) \otimes \Psi_1^{-1}\Psi_2^{-1},$$
  > $$\mathrm{Ber}\,R\pi_*(\Omega_{X/S}|_B) \simeq \mathrm{Ber}\,R\pi_*\Omega_{\widetilde{X}/B}.$$
  > Finally the exact sequence
  > $$0 \to \omega^2_{\widetilde{X}/B} \to \Omega_{\widetilde{X}/B} \to \omega_{\widetilde{X}/B} \to 0$$
  > near $D_1, D_2$, together with Lemma 8.7, show that
  > $$\mathrm{Ber}\,R\pi_*\Omega_{\widetilde{X}/B}(D_1+D_2) \simeq
  >   \mathrm{Ber}\,R\pi_*\Omega_{\widetilde{X}/B}.$$
  >
  > Hence, we deduce an isomorphism
  > $$\mathcal{O}(\Delta)|_B \simeq \mathrm{Ber}\,R\pi_*(j_*\Omega_{U/S})|_B \otimes
  >   \mathrm{Ber}^{-1}R\pi_*(\Omega_{X/S}|_B) \simeq \Psi_1^{-1}\Psi_2^{-1}. \qquad (9.6)$$
- 输入的 (7.6)（逐字，p.45，L1）：
  > We define the effective Cartier divisor $\Delta$ to be the vanishing divisor of this global
  > section. Note that by definition, we have an isomorphism
  > $$\mathcal{O}(\Delta) \simeq \mathcal{L} \simeq \mathrm{Ber}\,R\pi_*(j_*\Omega_{U/\overline{S}})
  >   \otimes \mathrm{Ber}^{-1}R\pi_*(\Omega_{X/\overline{S}}). \qquad (7.6)$$
  （其中 $\mathcal{L} := \mathrm{Ber}\,\pi_*[\Omega_{X/\overline{\mathcal{S}}} \to
  j_*\Omega_{U/\overline{\mathcal{S}}}]$，p.45 上方逐字。）
- 文献自称的严格程度：正文推导（"Hence, we deduce an isomorphism"），输入全是已证引理，**无
  "one expects" / "conjecturally" 等弱化措辞**。
- 文献列出的依赖：(7.6)（$\Delta$ 的 Berezinian 表示，§7.3）；Lemma 9.1(iii)(iv)（E8）；
  Lemma 8.7（$\Psi_i$ 与 $\mathrm{Ber}$ 的关系，p.56）。
- 备注（★★ **任务书的关键判定，逐字证据全列在此**）：
  **判定：本抽取在 (9.6) 的推导链条里没有找到任何显式依赖穿孔数目 $(m,n)$ 的步骤；但作者也
  从未把 (9.6) 写成"对任意穿孔数成立"，(9.6) 所在的上下文（§9.1 前半的比较论证 E7、下文的
  Theorem 9.2 E10、以及被证的 Theorem C E11）逐字都是无穿孔靶的形式。两边的逐字证据如下。**

  **(a) 支持"只用节点邻域局部数据"的逐字证据：**
  1. Lemma 9.1(i) 证明：*"For this, it is enough to study these line bundles in an étale
     neighborhood of the node."*（p.60）
  2. Lemma 9.1(ii) 证明：*"Indeed, this is a local statement."*（p.60）
  3. Lemma 9.1(iii) 证明：*"First, we note that $\mathcal{K}$ is supported on the node, so it is
     enough to prove the assertion after replacing $X_B$ with the formal neighborhood of the
     node."*（p.60）
  4. Lemma 9.1(iii)(iv) 的陈述本身：*"the sheaf $\mathcal{K}$ is supported on the node"*、
     *"the sheaf $\widetilde{\mathcal{C}}$ is supported on the node"*（p.59）。
  5. (9.5) 的 $\mathcal{C}$：*"where $\mathcal{C}$ is a sheaf supported on the node"*（p.59）。
  6. §9.1 开头的 $0 \to \mathcal{O}_{X_B} \to \rho_*\mathcal{O}_{\widetilde{X}} \to
     \mathcal{O}_Q \to 0$，余项 $\mathcal{O}_Q$ 支撑在节点（p.58）。
  7. (9.6) 推导的最后一步只在 $D_1, D_2$ **附近**用正合列：*"near $D_1, D_2$, together with
     Lemma 8.7"*（p.60）——$D_1,D_2$ 就是粘接用的两个 NS 除子。
  8. Lemma 9.1 与 (9.6) 的**记号里除 $D_1,D_2$、$\Psi_1,\Psi_2$、$Q$ 外不出现任何其他穿孔符号**。

  **(b) 反面 / 限制条件的逐字证据（同等重要，不可略）：**
  1. (9.6) 左端是 $\mathcal{O}(\Delta)|_B$ 而**不是** $\mathcal{O}(\Delta_{NS})|_B$。$\Delta$ 是
     §7.2/§7.3 定义的**全部**边界除子；$N_B$ 在 E7 里被定义为 $\mathcal{O}(\Delta_{NS})$ 到 $B$ 的
     拉回。二者的衔接靠 **Proposition 7.8(i)** 逐字：*"The ideal sheaf $\mathcal{I}_\delta$ defines
     an effective Cartier divisor $\Delta_{NS}$ on $\overline{\mathcal{S}}$, which coincides with
     $\Delta$ in a neighborhood of any point $[X_0]$ corresponding to a stable supercurve $X_0$ with
     only NS nodes."*（p.47）——即 $\Delta|_B = \Delta_{NS}|_B$ **只在"只有 NS 节点"的邻域成立**，
     而 §9.1 已把 $B$ 限制到 "the locus of smooth supercurves"，故此条在此上下文中满足。
     **但 curator 引用 (9.6) 作为"法丛 = $\Psi_1^{-1}\Psi_2^{-1}$"时必须带上这个限制。**
  2. $\mathrm{Ber}\,R\pi_*(-)$ 是**整条曲线上的**高阶推出的 Berezinian（$\pi : X \to$ 基），不是
     节点处的局部对象；局部性论证保证的是两个层的**商**支撑在节点，见 E8 备注的 ⚠。
  3. 全套推导写在 §9.1，其 setup（E7）自陈 $\iota$ 是 (7.8)/(7.9) **限制到光滑超曲线轨迹**——
     即 $B$ 只允许**一个**节点，且是 NS 型。Ramond 节点的类比在 §9.3 **只是猜想**（见 E15）。
  4. 作者在 §9.1 里唯一一次显式点穿孔数的地方（E7）用的是 $m=0$ 形式。
  - ⚠ **未尝试 / 未核实**：本轮**没有**追进 §9.2 的 Lemma 9.3–9.6 的证明细节，因此**不能**断言
    "Theorem 9.2 的相容性证明也与穿孔数无关"；(9.6) 本身的推导链条（(7.6) + Lemma 9.1 + Lemma 8.7）
    是本轮逐页读完的部分。
  - ⚠ **记号疑点（L1 核实）**：(9.6) 与 p.60 的三个显示式里，基底写作**不带上划线的 $S$**
    （$\Omega_{U/S}$、$\Omega_{X/S}$），而 §9.1 setup 与 (7.6) 写的是**带上划线的
    $\overline{\mathcal{S}}$**。400 dpi 放大复核确认 (9.6) 里确实**无上划线**。按上下文这应指同一个
    $\overline{\mathcal{S}}$（(9.6) 就是 (7.6) 的限制），判为**排印上的上划线遗漏**，但本条如实记录
    原文形态，不替作者改。
