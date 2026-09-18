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
