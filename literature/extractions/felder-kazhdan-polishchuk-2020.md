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

---

# 第三轮抽取（2026-09-18）：补齐 E10–E15

- 抽取者：researcher（agent/researcher/fkp-gluing-round3）
- 日期：2026-09-18
- 版本：arXiv:2006.13271**v3**（74 页，2023-03-07 编译，与第二轮同一份 PDF）
- 页码约定与方法等级：**沿用第二轮小节的约定**（PDF 页码 = 页眉印刷页码；L0–L4 制）。本轮已在
  pp.2、47、48、49、56、57、58、61、62、63、68、70、71 逐页核对页眉数字。
- ⚠ **关于第二轮小节的覆盖范围声明**：第二轮开头自称覆盖 "E7–E15"，但实际只落地了 **E7、E8、E9**
  三条（上一轮 agent 中途因 API 中断死亡）。**本轮不修改第二轮的任何既有文字**，只在此处如实说明：
  **E10–E15 由本轮补齐**，编号接续。
- 本轮所有逐字引文与公式均为 **L1**：用 `Read` 工具直接渲染 PDF 页图像逐字核对；关键公式
  （(8.11)、Theorem C 的靶、Example 8.9 的量词、§9.3 的 "conjecture" 措辞）另用
  `pdftoppm -r 400~500` 局部放大二次核对。`pdftotext -layout` **只用于定位行号与 ASCII 交叉校验**。
- ⚠ **本轮未做**：Lemma 9.3 / 9.4 / 9.5 的**证明**逐行核对（只核对陈述与证明首句的局部性自陈）；
  §9.2 里 Lemma 9.6 之后到 Theorem C 收尾的完整推导；§3/§6 变形理论；参考文献表书目核实。

## 陈述（第三轮）

### E10 Theorem 9.2：(9.6) 与两个超 Mumford 同构的**相容性**（已证，非猜想）
- 位置：**p.61**（陈述与图表）；证明分散在 Lemma 9.3（p.61–62）、Lemma 9.4（p.62–63）、
  Lemma 9.5（p.63–68）；"Proof of Theorem 9.2" 在 **p.68 上半页**。L1（页图逐字；Theorem 9.2 的
  图表另用 400 dpi 局部放大复核）。
- ⚠ **节号更正（与派工描述不符，如实记录）**：Theorem 9.2 **位于 §9.1 "NS boundary components"
  之内**（§9.1 起于 p.58，一直延伸到 p.68 上半页），**不在 §9.2**。§9.2 的标题是
  "**Splitting of the Kodaira-Spencer map at an NS boundary component**"，起于 **p.68 下半页**，
  其首条结果是 Lemma 9.6（编号式 (9.27)）。§9.3 "Ramond boundary components" 起于 p.70。
- 类型：proposition
- 原文陈述（逐字，含紧邻其前定义两个 Mumford 同构的段落）：
  > Now we can state a compatibility result between the super Mumford isomorphisms over
  > $\overline{\mathcal{S}}$ and over the NS boundary component $B$. Recall that we have the super
  > Mumford isomorphism
  > $$\mu_{\overline{\mathcal{S}}} : \mathcal{B}(\omega^{-2}_{X/\overline{\mathcal{S}}})
  >   \longrightarrow \mathcal{B}(\mathcal{O}_X)^5(-\Delta)$$
  > near $B$ (see Prop. 8.5). We also have the super Mumford isomorphism for the family
  > $\widetilde{X}/B$, over the smooth locus:
  > $$\mu_B : \mathcal{B}(\omega^{-2}_{\widetilde{X}/B}(-D_1-D_2)) \xrightarrow{\ \sim\ }
  >   \mathcal{B}(\mathcal{O}_{\widetilde{X}})^5 \otimes \Psi_1 \otimes \Psi_2$$
  > (see Lemma 8.11).
  >
  > **Theorem 9.2.** *The following diagram of isomorphisms of line bundles on $B$ is commutative up
  > to a sign*
  > $$\begin{array}{ccc}
  >   \mathcal{B}(\omega^{-2}_{X/\overline{\mathcal{S}}})|_B &
  >     \xrightarrow{\ \mu_{\overline{\mathcal{S}}}|_B\ } &
  >     \mathcal{B}(\mathcal{O}_X)^5(-\Delta)|_B \\
  >   \big\downarrow{\scriptstyle (9.2)} & & \big\downarrow{\scriptstyle (9.6)} \\
  >   \mathcal{B}(\omega^{-2}_{\widetilde{X}/B}(-D_1-D_2)) & \xrightarrow{\ \mu_B\ } &
  >     \mathcal{B}(\mathcal{O}_{\widetilde{X}})^5 \otimes \Psi_1 \otimes \Psi_2
  >   \end{array}$$
  紧随其后（p.61）作者说明证明的拆分方式，逐字：
  > Recall that to get $\mu_{\overline{\mathcal{S}}}$ we used three isomorphisms: the
  > Grothendieck-Serre duality isomorphism
  > $$SD_{X/\overline{\mathcal{S}}} : \mathcal{B}(\omega^{-2}_{X/\overline{\mathcal{S}}})
  >   \xrightarrow{\ \sim\ } \mathcal{B}(\omega^3_{X/\overline{\mathcal{S}}}),$$
  > the isomorphism
  > $$\mathcal{B}(\omega^3_{X/\overline{\mathcal{S}}}) \simeq
  >   \mathcal{B}(\omega^2_{X/\overline{\mathcal{S}}})^{-1} \otimes \mathcal{B}(\mathcal{O}_X)^2,$$
  > and the isomorphism
  > $$\mathcal{B}(\omega^2_{X/\overline{\mathcal{S}}}) \simeq
  >   \mathcal{B}(\omega_{X/\overline{\mathcal{S}}})^{-2} \otimes
  >   \mathcal{B}(\mathcal{O}_X)^{-1}(\Delta)$$
  > (see Sec. 8.3). Similarly, $\mu_B$ is a composition of similar three isomorphisms. So we can
  > reduce the proof of Theorem 9.2 to separate compatibilities involving each of these three
  > isomorphisms. We deal with this compatibilities in the next three lemmas.
- 文献自称的严格程度：**编号定理，给出完整证明**（p.68 "Proof of Theorem 9.2 … $\square$"），
  **无任何 "conjecture" / "one expects" 弱化措辞**。但注意结论本身只断言**相差一个符号**的交换性
  （逐字 "commutative **up to a sign**"），不是无条件严格交换。
- 文献列出的依赖（作者自列，逐字）：Prop. 8.5（$\mu_{\overline{\mathcal{S}}}$ 的存在，p.57–58）；
  Lemma 8.11（$\mu_B$ 的存在，p.57）；(9.2)（= Lemma 9.1(i)，见 E8）；(9.6)（见 E9）；
  Sec. 8.3（$\mu$ 的三段分解）；Lemma 9.3、Lemma 9.4、Lemma 9.5；(8.5)。

- **Lemma 9.3 陈述（逐字，p.61）**——⚠ **本轮只核对陈述，未追进证明**（证明跨 p.61–62，用
  Grothendieck–Serre 对偶的函子性 + 正合三角同构 (9.7)）：
  > **Lemma 9.3.** *For any $m \in \mathbb{Z}$, the following diagram of isomorphisms between line
  > bundles on $B$ is commutative:*
  > $$\begin{array}{ccc}
  >   \mathcal{B}(\omega^{-2m}_{X/\overline{\mathcal{S}}})|_B &
  >     \xrightarrow{\ SD_{X/\overline{\mathcal{S}}}|_B\ } &
  >     \mathcal{B}(\omega^{2m+1}_{X/\overline{\mathcal{S}}})|_B \\
  >   \big\downarrow{\scriptstyle (9.2)} & & \big\downarrow{\scriptstyle (9.4)} \\
  >   \mathcal{B}(\omega^{-2m}_{\widetilde{X}/B}(-mD_1-mD_2)) &
  >     \xrightarrow{\ SD_{\widetilde{X}/B}\ } &
  >     \mathcal{B}(\omega^{2m+1}_{\widetilde{X}/B}(mD_1+mD_2))
  >   \end{array}$$
  > *where the horizontal arrows are given by Grothendieck-Serre duality.*

  （与 Theorem 9.2 不同，本条逐字是**无条件交换**，没有 "up to a sign"。）

- **Lemma 9.4 陈述（逐字，p.62）**——⚠ 本轮只核对陈述与证明首句，未追进证明全文：
  > **Lemma 9.4.** *Let $\rho : Y \to X$ be a morphism of families of stable supercurves over $B$,
  > which is a fiberwise resolution of the node $Q : B \to X$ (so it is an isomorphism away from
  > $X \setminus Q(B)$). For any coherent sheaf $\mathcal{F}$ on $Y$ which is locally free of rank
  > $1|0$ over the smooth locus, and any line bundle $L$ on $X$ with a trivialization of $Q^*L$, we
  > have a commutative diagram of isomorphisms of line bundles on $B$,*
  > $$\begin{array}{ccc}
  >   \mathcal{B}(\rho_*\mathcal{F} \otimes L) & \xrightarrow{\ (8.5)\ } &
  >     \mathcal{B}(\rho_*\mathcal{F}) \otimes \mathcal{B}(L) \otimes
  >     \mathcal{B}(\mathcal{O}_X)^{-1} \\
  >   \big\downarrow & & \big\downarrow \\
  >   \mathcal{B}(\mathcal{F} \otimes \rho^*L) & \xrightarrow{\ (8.5)\ } &
  >     \mathcal{B}(\mathcal{F}) \otimes \mathcal{B}(\rho^*L) \otimes
  >     \mathcal{B}(\mathcal{O}_Y)^{-1}
  >   \end{array}$$
  > *where in the right vertical arrow we use isomorphisms
  > $\mathcal{B}(\mathcal{O}_X) \simeq \mathcal{B}(\mathcal{O}_Y)$ and
  > $\mathcal{B}(L) \simeq \mathcal{B}(\rho^*L)$ coming from the exact sequences*
  > $$0 \to \mathcal{O}_X \to \rho_*\mathcal{O}_Y \to \mathcal{O}_Q \to 0$$
  > $$0 \to L \to L \otimes \rho_*\mathcal{O}_Y \to L \otimes \mathcal{O}_Q \to 0$$
  > *and the trivialization of $Q^*L$.*

  证明首句（逐字，p.62，**局部性自陈**）：*"The question is local in the base, so we can assume
  that we can choose a relative divisor $D \subset X$ supported in the smooth locus of
  $\pi : X \to B$, and a global section $s$ of $L(D)$ such that the $E = \mathrm{div}(s)$ is also
  supported in the smooth locus."* ⚠ 注意这句说的是"**在基底上局部**（local **in the base**）"，
  **不是**"在节点的邻域里局部"——与 E8/E9 记录的那几处 "étale / formal neighborhood of the node"
  是**不同类型**的局部性断言，引用时不可混为一谈。

- **Lemma 9.5 陈述（逐字，p.63，图表编号 (9.8)）**——⚠ 证明跨 p.63–68（分 Step 1 起若干步），
  本轮只核对陈述与证明首句：
  > **Lemma 9.5.** *The following diagram is commutative up to a sign*
  > $$\begin{array}{ccc}
  >   \mathcal{B}(\omega^2_{X/\overline{\mathcal{S}}})|_B & \xrightarrow{\ \sim\ } &
  >     \mathcal{B}(\omega_{X/\overline{\mathcal{S}}})^{-2}|_B \otimes
  >     \mathcal{B}(\mathcal{O}_X)^{-1}(\Delta)|_B \\
  >   \big\downarrow{\scriptstyle \sim} & & \big\downarrow{\scriptstyle \sim} \\
  >   \mathcal{B}(\omega^2_{\widetilde{X}/B}(D_1+D_2)) & \xrightarrow{\ \sim\ } &
  >     \mathcal{B}(\omega_{\widetilde{X}/B})^{-2} \otimes
  >     \mathcal{B}(\mathcal{O}_{\widetilde{X}})^{-1} \otimes \Psi_1^{-1}\Psi_2^{-1}
  >   \end{array} \qquad (9.8)$$
  > *Proof.* Note that it is enough to prove the commutativity of this diagram working in an étale
  > neighborhood $S$ of a stable supercurve $X_s$ with **one NS node**. We also choose standard
  > presentation of the node on $X_s$, and use constructions of Sec. 8.3.

- **Proof of Theorem 9.2 的骨架（逐字，p.68）**：
  > *Proof of Theorem 9.2.* Let us consider the diagram
  > $$\begin{array}{ccccccc}
  >   \mathcal{B}(\omega^{-2}_X)|_B & \to & \mathcal{B}(\omega^3_X)|_B & \to &
  >     \mathcal{B}(\omega^2_X)^{-1}\mathcal{B}(\mathcal{O}_X)^2|_B & \to &
  >     \mathcal{B}(\omega_X)^2\mathcal{B}(\mathcal{O}_X)^3(-B)|_B \\
  >   \mathcal{B}(\omega^{-2}_{\widetilde{X}}(-D_1-D_2)) & \to &
  >     \mathcal{B}(\omega^3_{\widetilde{X}}(D_1+D_2)) & \to &
  >     \mathcal{B}(\omega^2_{\widetilde{X}}(D_1+D_2))^{-1}
  >     \mathcal{B}(\mathcal{O}_{\widetilde{X}})^2 & \to &
  >     \mathcal{B}(\omega_{\widetilde{X}})^2\mathcal{B}(\mathcal{O}_{\widetilde{X}})^3\Psi_1\Psi_2
  >   \end{array}$$
  > We claim that each square in this diagram is commutative. Indeed, the left square is commutative
  > by Lemma 9.3, while the right square is commutative by Lemma 9.5. The commutativity of the
  > middle square follows from the commutative diagram […]
  > Here the lower square is commutative by Lemma 9.4 applied to the morphism
  > $\rho : \widetilde{X} \to X_B$, the line bundle $\omega^2_{X_B/B}$ and the coherent sheaf
  > $\omega_{\widetilde{X}/B}$. The commutativity of the upper square can be checked using the
  > compatibility of the isomorphism (8.5) with the resolution
  > $[\omega_{X_B/B} \to \mathcal{O}_Q]$ for $\rho_*\omega_{\widetilde{X}/B}$. $\square$

  ⚠ **原文疑点（L1，500 dpi 复核）**：上面这个大图表的**右上角项**原文印作
  $\mathcal{B}(\omega_X)^2\mathcal{B}(\mathcal{O}_X)^3(-B)|_B$，**括号里是 $-B$**。按上下文
  （Sec. 8.3 的第三个同构里出现的是 $(\Delta)$，且 $B$ 在本节一直用作**边界分量/基底**的记号）
  这疑为 $(-\Delta)$ 的**排印错误**。本条如实记录原文形态，**不替作者改**，留给 curator。
- 备注（**穿孔判定，正反两侧逐字证据**）：
  - **反面（限制条件）一侧的逐字证据**：Theorem 9.2 的图表**四个角全部是"只有两个 $\Psi$"的
    形式**——$\mu_B$ 的靶逐字是 $\mathcal{B}(\mathcal{O}_{\widetilde{X}})^5 \otimes \Psi_1
    \otimes \Psi_2$，**没有 $\bigotimes_{i=1}^{m}\Psi_i$ 因子**；$\mu_{\overline{\mathcal{S}}}$ 的
    靶是 $\mathcal{B}(\mathcal{O}_X)^5(-\Delta)$，**也不带任何 $\Psi_i$ 因子，也不带 $\Delta_R$**。
    即：**Theorem 9.2 逐字写的同样是 $m=0$（靶无额外穿孔）的情形**，与 E7 的比较论证完全一致。
  - **支持"局部 / 与穿孔数无关"一侧的逐字证据**：
    1. Lemma 9.3 的量词逐字是 "*For any $m \in \mathbb{Z}$*"——⚠ 这里的 $m$ 是 $\omega$ 的**幂次**，
       **不是**穿孔数目，**切勿与 (8.11) 里的 $m$ 混淆**（同一篇论文里 $m$ 被复用于两个不同含义，
       这是本轮发现的一个真实的记号陷阱）。
    2. Lemma 9.5 的证明首句逐字自陈只需在"带**一个 NS 节点**的稳定超曲线的平展邻域"里做。
    3. Lemma 9.4 的陈述对**任意**相干层 $\mathcal{F}$ 与**任意**线丛 $L$ 成立，没有任何与穿孔
       数目相关的限制。
  - ⚠ 本抽取**不判定**"把 $m$ 个额外 $\Psi_i$ 加到 Theorem 9.2 图表两侧后是否仍交换"。
    **本轮没有追进 Lemma 9.3 / 9.4 / 9.5 的证明全文**（只读了陈述与证明首句），因此**不能**断言
    "Theorem 9.2 的证明与穿孔数无关"。需要该断言者留给 curator，并须标 `inferred: true`。

### E11 ★ Theorem C（§1 引言）与 (8.11)：**靶空间逐字是无穿孔的 $\overline{\mathcal{S}}_g$** —— 承重复核
- 位置：**Theorem C** 陈述在 **p.2 末（"Theorem C. Let $B \to \overline{\mathcal{S}}_g$ …"）**，
  交换图在 **p.3 顶**；**(8.11)** 在 **p.58 上半页**（Proof of Theorem B 的收尾式）。
  **Theorem B** 在 **p.2 中**。L1（三处都用 `pdftoppm -r 500` 局部放大逐符号复核下标）。
- 类型：proposition
- 原文陈述（Theorem C，逐字，跨 p.2–3）：
  > **Theorem C**. *Let $B \to \overline{\mathcal{S}}_g$ be the gluing map to one of the components
  > of $\Delta_{NS}$ from a lower genus (uncompactified) moduli space $B$. There exists a natural
  > isomorphism (see below) of the normal bundle*
  > $$N_B := \mathcal{O}(\Delta)|_B \simeq \Psi_1^{-1} \otimes \Psi_2^{-1},$$
  > *such that the following diagram is commutative up to a sign*
  > $$\begin{array}{ccc}
  >   K_{\overline{\mathcal{S}}_g}(2\Delta)|_B &
  >     \xrightarrow{\ SM_{\overline{\mathcal{S}}_g}|_B\ } & \mathrm{Ber}_1^5|_B \\
  >   \big\downarrow & & \big\downarrow \\
  >   K_B \otimes N_B & \xrightarrow{\ SM_B\ } & (\mathrm{Ber}_1^B)^5
  >   \end{array}$$
- 原文陈述（(8.11)，逐字，p.58；其上下文是 "Proof of Theorem B. Let
  $\overline{\mathcal{S}} = \overline{\mathcal{S}}_{g,n_{NS},n_R}$."）：
  > This gives the required isomorphism
  > $$K_{\overline{\mathcal{S}}} \simeq \mathrm{Ber}_1^5 \otimes \bigotimes_{i=1}^{m}
  >   \Psi_i(-2\Delta_{NS} - \Delta_R), \qquad (8.11)$$
  同页 (8.11) 之前作者自列的两个输入（逐字）：
  > We combine the isomorphism
  > $$K_{\overline{\mathcal{S}}} \simeq \mathrm{Ber}^{-1} R^1\pi_*\mathcal{L}(X,P_\bullet,R_\bullet)
  >   (-\Delta_{NS}-\Delta_R) \simeq \mathcal{B}(\mathcal{L}(X,P_\bullet,R_\bullet))
  >   (-\Delta_{NS}-\Delta_R)$$
  > (see Sec. 6.4) with Lemma 8.11 and the isomorphism
  > $$\mathcal{B}(\omega^3_{X/\overline{\mathcal{S}}}) \simeq \mathrm{Ber}_1^5(-\Delta_{NS}).$$
- 原文陈述（Theorem B，逐字，p.2 —— 作为对照，因为本条的判定正是 B 与 C 的对比）：
  > **Theorem B**. *Let $\overline{\mathcal{S}} = \overline{\mathcal{S}}_{g,n_{NS},n_R}$. There
  > exists a canonical isomorphism*
  > $$K_{\overline{\mathcal{S}}} \xrightarrow{\ SM_{\overline{\mathcal{S}}}\ } \mathrm{Ber}_1^5
  >   \otimes \bigotimes_{i=1}^{n_{NS}} \Psi_i(-2\Delta_{NS} - \Delta_R),$$
  > *where $\Delta_{NS}$ and $\Delta_R$ are the components of the boundary divisor corresponding to
  > nodes of NS and Ramond type, and $\Psi_i$ is the line bundle associated with the ith NS puncture
  > $P_i$:*
  > $$\Psi_i := P_i^*\omega_{X/\overline{\mathcal{S}}}.$$
  >
  > In the case when there are no punctures the isomorphism becomes
  > $$K_{\overline{\mathcal{S}}_g} \simeq \mathrm{Ber}_1^5(-2\Delta_{NS} - \Delta_R).$$
- 文献自称的严格程度：Theorem C 是**编号定理**（§1 引言），正文证明在 §9（"Combining the above
  Corollary with Theorem 9.2, we get the statement of Theorem C."，p.70）。**无弱化措辞。**
- 文献列出的依赖：Theorem 9.2（E10）+ §9.2 的 Corollary（p.70，源自 Lemma 9.6 的 Kodaira–Spencer
  分裂）；$N_B$ 的识别来自 §7.2 的 $\Delta$ 消没轨迹描述（p.3 逐字："The identification of $N_B$ in
  Theorem C comes from the identification of $\Delta$ as the vanishing locus of a morphism induced
  on Berezinians by the morphism $R\pi_*(\Omega_{X/\overline{\mathcal{S}}_g}) \to
  R\pi_*j_*(\Omega_{U/\overline{\mathcal{S}}_g})$, where $j : U \to X$ is the embedding of the
  smooth locus (see Sec. (7.2))."）。
- 备注（★★ **本轮最重要的独立复核，裁定如下**）：

  **裁定：SUPPORT（支持本项目既有结论）。FKP 的 Theorem C 的靶逐字确实是不带穿孔指标的
  $\overline{\mathcal{S}}_g$，而同页 Theorem B 的靶逐字是 $\overline{\mathcal{S}}_{g,n_{NS},n_R}$；
  两者的下标差异在 500 dpi 放大下清晰可辨，不是渲染/OCR 造成的假象。**

  **逐字证据（支持"FKP 刻意区分"的一侧）：**
  1. **Theorem B**（p.2）开篇即写 "*Let $\overline{\mathcal{S}} =
     \overline{\mathcal{S}}_{g,n_{NS},n_R}$*"——下标三元组完整出现，且其公式带
     $\bigotimes_{i=1}^{n_{NS}}\Psi_i$ 与 $-\Delta_R$，即**显式处理任意 NS/Ramond 穿孔数**。
  2. **Theorem C**（p.2 末）写的是 "*Let $B \to \overline{\mathcal{S}}_g$*"——**下标只有一个 $g$**
     （500 dpi 放大逐字符确认：$\overline{\mathcal{S}}$ 右下角只有一个斜体 $g$，其后紧接空格与
     "be the gluing map"，**没有 $,n_{NS},n_R$**）。
  3. 同一定理的交换图（p.3）**四个角一致地使用无穿孔形式**：左上 $K_{\overline{\mathcal{S}}_g}
     (2\Delta)|_B$（**下标同样只有 $g$**），右上 $\mathrm{Ber}_1^5|_B$（**无 $\Psi_i$ 因子**），
     右下 $(\mathrm{Ber}_1^B)^5$（**无 $\Psi_i$ 因子**）。若靶是带 $n_{NS}$ 个穿孔的
     $\overline{\mathcal{S}}_{g,n_{NS},n_R}$，按 Theorem B 右上角本应出现
     $\bigotimes_{i=1}^{n_{NS}}\Psi_i$——**它没有出现**。
  4. Theorem C 上面一段（p.2，逐字）：*"As in the classical case, each component of $\Delta_{NS}$ is
     an image of a natural gluing map $B \to \overline{\mathcal{S}}_g$, where $B$ is some lower genus
     moduli space **with more punctures** or a product of two such moduli spaces (see Sec. 7.5)."*
     ——**源** $B$ 明确"穿孔更多"，**靶**却始终写作 $\overline{\mathcal{S}}_g$。这说明作者在引言里
     考虑的是"**无穿孔的紧化超模叠**的边界分量由**带穿孔的**低亏格模空间粘出"这一情形。
  5. 交换图下行 $K_B \otimes N_B \xrightarrow{SM_B} (\mathrm{Ber}_1^B)^5$ 与 $N_B \simeq
     \Psi_1^{-1}\Psi_2^{-1}$ 联立，逐字只在 "$B$ 恰好带那两个被粘的 NS 穿孔、没有别的穿孔"时
     才与 Theorem B 的形状自洽（Theorem B 给 $K_B \simeq \mathrm{Ber}_1^5 \otimes \Psi_1
     \otimes \Psi_2$，$B$ 未紧化故无 $\Delta$ 项）。**这与 E7/E10 记录的 §9 正文里"只有两个 $\Psi$"
     的形态完全一致**——不是孤立的疏漏，而是全篇一贯的 $m=0$ 写法。

  **逐字证据（反面 / 不利于"FKP 刻意区分"的一侧，同等记录）：**
  1. **(8.11) 自身带穿孔**：$K_{\overline{\mathcal{S}}} \simeq \mathrm{Ber}_1^5 \otimes
     \bigotimes_{i=1}^{m}\Psi_i(-2\Delta_{NS}-\Delta_R)$，而 §9.1 的整套推导（E7、E10）**输入正是
     (8.11)**，即作者是从**带穿孔**的公式出发的。他们只是在 §9 里把它 "rewrite … near $B$" 成了
     无穿孔形式（E7 已逐字记录这一步丢掉了 $\bigotimes\Psi_i$ 与 $\Delta_R$）。
  2. **(7.8)/(7.9) 的粘接映射带一般穿孔指标 $(m,n)$**（见 E12），而 §9.1 的 setup 逐字允许
     $\iota$ 是 "one of the maps (7.8) or (7.9)"（E7）。即：**§9.1 的 setup 比 Theorem C 的陈述更宽**，
     Theorem C 的陈述是 setup 的一个特例写法。
  3. 作者**从未在任何地方写下**"Theorem C 只对无穿孔情形成立"或"Theorem C 对任意穿孔数成立"
     之类的显式量词声明——**两个方向的显式声明都不存在**。

  **⚠ 记号疑点（L1，500 dpi 复核，如实记录，不替作者改）**：
  - **(8.11) 用 $\bigotimes_{i=1}^{m}$，而引言的 Theorem B 用 $\bigotimes_{i=1}^{n_{NS}}$。**
    (8.11) 所在的 "Proof of Theorem B" 段开头逐字是 "Let $\overline{\mathcal{S}} =
    \overline{\mathcal{S}}_{g,n_{NS},n_R}$"，**没有在该段里把 $m$ 声明为 $= n_{NS}$**；$m$（与 $n$）
    是 §8.4 起沿用的穿孔数简写（见 E14）。按上下文 $m = n_{NS}$，但**本抽取不替作者补这条等式**，
    只记录原文的记号漂移。
  - **Theorem C 的 $N_B := \mathcal{O}(\Delta)|_B$ 用的是全部边界除子 $\Delta$，不是
    $\Delta_{NS}$**——与 (9.6) 的左端一致（见 E9 备注 (b) 第 1 条：二者的衔接靠 Prop. 7.8(i)，
    且只在"只有 NS 节点"的邻域成立）。
  - ⚠ **本抽取不判定** "Theorem C 是否实际上对任意 $(n_{NS}, n_R)$ 成立"。逐字层面能确定的只有：
    **作者写下来的 Theorem C 的靶是 $\overline{\mathcal{S}}_g$**。要把它推广到带穿孔的靶，属于
    推断，留给 curator（若做，须标 `inferred: true`，并把上面"反面证据"三条一并带上）。

### E12 ★ 粘接映射 (7.8) 与 (7.9)：**定义域/陪域都带一般穿孔指标 $(m,n)$**
- 位置：**p.48 中段**（记号 $\overline{\mathcal{S}}_{g;m,n}$ 的定义 + (7.8) + (7.9)），在
  §7.5 "**The NS node boundary components**"（该节起于 **p.47 下半页**）之内。L1（页图逐字；
  (7.8)/(7.9) 的全部下标另用 `pdftoppm -r 500` 局部放大逐符号复核）。
- 类型：definition
- 原文陈述（逐字，p.48，含记号定义与两条映射，顺序照原文）：
  > Let $\overline{\mathcal{S}}_{g;m,n}$ denote the moduli superspace of stable supercurves of genus
  > $g$ with $m$ NS marked points and $n$ Ramond marked points. Then we can apply the above gluing
  > construction to the pair of families of stable supercurves over
  > $\overline{\mathcal{S}}_{g_1;m_1+1,n_1} \times \overline{\mathcal{S}}_{g_2;m_2+1,n_2}$, pulled
  > back from each factor and using the last NS puncture on each of them. This leads to a morphism
  > $$\overline{\mathcal{S}}_{g_1;m_1+1,n_1} \times \overline{\mathcal{S}}_{g_2;m_2+1,n_2} \to
  >   \overline{\mathcal{S}}_{g_1+g_2;m_1+m_2,n_1+n_2}. \qquad (7.8)$$
  > Similarly, if $X/S$ is a stable supercurve with two disjoint NS-punctures $P, P' \subset X$, then
  > we can glue $P$ with $P'$ and get a new stable supercurve with a non-separating node. This leads
  > to a morphism
  > $$\overline{\mathcal{S}}_{g;m+2,n} \to \overline{\mathcal{S}}_{g+1;m,n} \qquad (7.9)$$
- **分离型 vs 非分离型的归属（逐字判定）**：
  - **(7.8) = 分离型（separating）NS 节点**。逐字依据有两条：(a) (7.8) 的源是**两个**模空间的**乘积**，
    靶的亏格与穿孔数是两者之和（$g_1+g_2$；$m_1+m_2$；$n_1+n_2$），正是分离型节点的形状；
    (b) Lemma 7.10 的后半句逐字写 "*near a stable supercurve with a single **separating** (resp.,
    **non-separating**) NS node, the divisor $\Delta_{NS}$ coincides with the schematic image of
    (7.8) (resp., (7.9))*"——即作者**显式**把 separating 配给 (7.8)、non-separating 配给 (7.9)。
  - **(7.9) = 非分离型（non-separating）NS 节点**。除上述 Lemma 7.10 的逐字配对外，(7.9) 前一句
    也逐字写明 "*get a new stable supercurve with a **non-separating** node*"，且亏格从 $g$ 升到
    $g+1$、NS 穿孔从 $m+2$ 降到 $m$（把两个 NS 穿孔粘掉），形状自洽。
- **穿孔指标（本条的承重信息，逐字）**：
  - (7.8) 的**源**是 $\overline{\mathcal{S}}_{g_1;m_1+1,n_1} \times
    \overline{\mathcal{S}}_{g_2;m_2+1,n_2}$：两个因子各自带 $m_i+1$ 个 NS 穿孔与 $n_i$ 个 **Ramond**
    穿孔；**陪域**是 $\overline{\mathcal{S}}_{g_1+g_2;m_1+m_2,n_1+n_2}$，即**靶带 $m_1+m_2$ 个 NS
    穿孔与 $n_1+n_2$ 个 Ramond 穿孔**——**靶不是无穿孔的 $\overline{\mathcal{S}}_g$**。
  - (7.9) 的**源**是 $\overline{\mathcal{S}}_{g;m+2,n}$，**陪域**是
    $\overline{\mathcal{S}}_{g+1;m,n}$——同样**靶带 $(m,n)$ 一般穿孔指标**。
  - 两条映射的陈述中**都没有**"$m=n=0$"或类似的限制；$m_i, n_i, m, n$ 是自由的一般指标。
- 文献自称的严格程度：正文构造（definition 级；粘接超概形的良定性由 §7.5 开头的一般构造 + Lemma 7.9
  保证，见 E13）。
- 文献列出的依赖：§7.5 开头的"沿闭子概形粘接两个超概形"的一般构造（p.47 下半页，逐字给出
  $\mathcal{O}_X$ 作为 $j_*\mathcal{O}_X \oplus j'_*\mathcal{O}_{X'}$ 中对角线原像的子层的定义）；
  Lemma 7.9（粘出来的 $Z/S$ 确实是稳定超曲线）。
- 备注（**记号与判定**）：
  - ⚠ **记号漂移（L1 逐字核实）**：§7.5 用**分号**写作 $\overline{\mathcal{S}}_{g;m,n}$（"genus $g$;
    $m$ NS marked points, $n$ Ramond marked points"），而 Theorem A / Theorem B（§1、§5）用**逗号**
    写作 $\overline{\mathcal{S}}_{g,n_{NS},n_R}$。按两处的文字说明这是**同一个对象的两套记号**
    （$m \leftrightarrow n_{NS}$，$n \leftrightarrow n_R$），但**本文没有在任何地方写下一句
    "$\overline{\mathcal{S}}_{g;m,n} = \overline{\mathcal{S}}_{g,m,n}$" 式的记号对照声明**。
    curator 跨节引用时须自行注明这一点。另注 §7.5 这里用的措辞是 "**marked points**" 而
    Definition 2.4 用的是 "**punctures**"。
  - ⚠ **本条与 E11 的张力，如实并列**：**(7.8)/(7.9) 的靶逐字带一般穿孔指标**（本条），而
    **Theorem C 的靶逐字是无穿孔的 $\overline{\mathcal{S}}_g$**（E11）、**§9.1 的比较论证与
    Theorem 9.2 逐字写的也是无穿孔形式**（E7、E10）。两者**不矛盾**（Theorem C 是 setup 允许范围内
    的一个特例写法），但**"作者是否证明了带穿孔靶的版本"这一问题，逐字层面在本文里没有答案**——
    本抽取不判定，留给 curator（若判定，须标 `inferred: true`）。
  - ⚠ Ramond 型节点的粘接**不在 §7.5**：§7.6 标题逐字是 "**The Ramond node boundary components**"，
    开篇第一句逐字 "*Gluing along two Ramond punctures is more subtle.*"（p.49）。即 (7.8)/(7.9)
    **只处理 NS 节点**。Ramond 的对应映射是 **(7.11)**（非分离型）与 **(7.12)**（分离型），位于
    **p.51**，逐字（L1，400 dpi 复核）：
    > $$\mathrm{Isom}(\mathcal{P}_{n+1}, [i]_*\mathcal{P}_{n+2}) \to
    >   \overline{\mathcal{S}}_{g+1;m,n} \qquad (7.11)$$
    > Similarly, we can glue the last Ramond punctures $R, R'$ on the stable supercurves $X, X'$ over
    > the moduli space $\overline{\mathcal{S}}_{g_1;m_1,n_1+1} \times
    > \overline{\mathcal{S}}_{g_2;m_2,n_2+1}$ pulled back from each factor. This gives a morphism
    > $$\mathrm{Isom}(\mathcal{P}_R, [i]_*\mathcal{P}_{R'}) \to
    >   \overline{\mathcal{S}}_{g_1+g_2;m_1+m_2,n_1+n_2}. \qquad (7.12)$$
    > Note that in this case $n_1$ and $n_2$ are odd, so $n_1 + n_2 \geq 2$.

    （(7.11) 的源是 $\overline{\mathcal{S}}_{g;m,n+2}$ 上的 $\mathbb{Z}/2 \ltimes
    \mathbb{A}^{0|1}$-主丛 $\mathrm{Isom}(\cdot,\cdot)$，**不是模空间本身**——这就是 §7.6 开头所谓
    "more subtle"、以及 p.3 引言所说 "*The components of the Ramond boundary divisor $\Delta_R$
    have a more complicated relation to lower genus moduli spaces*" 的具体内容。逐字注意
    (7.11)/(7.12) 的靶也**都带一般穿孔指标 $(m,n)$**。）
  - ⚠ **原文编号疑点（本轮发现，L1）**：§9.1 setup（E7）逐字说 $\iota$ 是 "one of the maps (7.8) or
    (7.9)"，与本条一致（两者都是 NS 粘接）；但 **§9.3（Ramond 边界分量，p.70）逐字写的是
    "a gluing map for the Ramond boundary component, i.e., one of the maps **(7.9)**"**——而 (7.9)
    是 **NS** 非分离粘接映射，Ramond 的应当是 (7.11)/(7.12)。**疑为编号笔误**（很可能想写
    (7.11)、(7.12) 或 "(7.11) or (7.12)"）。本抽取如实记录，**不替作者改**，详见 E15。

### E13 Lemma 7.9 与 Lemma 7.10：粘接的良定性与"(7.8)/(7.9) 的像 = $\Delta_{NS}$"
- 位置：**Lemma 7.9** 陈述在 **p.47 末**，证明在 **p.48 上半页**；**Lemma 7.10** 陈述在 **p.48
  中下部**（紧接 (7.9)），证明跨 **p.48 下半页–p.49 上半页**。L1（页图逐字）。
- 类型：proposition（两条都是编号引理，均给出完整证明）

#### (a) Lemma 7.9 —— 粘出来的东西**确实是**稳定超曲线
- 原文陈述（逐字，p.47；连同其前定义 $Z/S$ 的两句）：
  > We can apply this to gluing two stable supercurves along NS-punctures.
  >
  > Suppose $X/S$ and $X'/S$ is a pair of stable supercurves with NS-punctures $P \subset X$ and
  > $P' \subset X'$. We have an isomorphism $P \simeq S \simeq P'$, so we can define a new
  > superscheme $Z/S$ by gluing $X$ and $X'$ along $P \simeq P'$.
  >
  > **Lemma 7.9.** *The glued superscheme $Z/S$ has a natural stable supercurve structure such that
  > the derivation $\delta$ on $Z$ is defined as the composition*
  > $$\mathcal{O}_Z \to j_*\mathcal{O}_X \oplus j'_*\mathcal{O}_{X'}
  >   \xrightarrow{\ (j_*\delta, j'_*\delta')\ }
  >   j_*\omega_{X/S} \oplus j'_*\omega_{X'/S} \to \omega_{Z/S}.$$
- 证明梗概（逐字要点，p.48）：
  > *Proof.* If $U \subset X$, $U' \subset X'$ are smooth loci, then $(U \setminus P) \sqcup
  > (U' \setminus P')$ is an open subset of $Z$, which is a smooth supercurve over $S$. Next, we need
  > to check that in the case when $S$ is a point, $\delta^-$ induces an isomorphism of
  > $\mathcal{O}_{\widetilde{Z}}$ with $\omega_{\widetilde{Z}}$. Since the base is even, we have
  > identifications
  > $$\mathcal{O}_X = \mathcal{O}_C \oplus L, \quad \mathcal{O}_{X'} = \mathcal{O}_{C'} \oplus L',$$
  > […] Note that $L$ and $L'$ are generalized spin-structures, i.e., we have an isomorphism
  > $L \xrightarrow{\ \sim\ } \underline{\mathrm{Hom}}(L, \omega_C)$ (which corresponds to $\delta^-$
  > on $X$), and similarly, for $L'$. Furthermore, we know that $L$ (resp., $L'$) is locally free
  > near $P$ (resp., $P'$).
  >
  > The glued superscheme $Z$ has the underlying nodal curve $Z_0$, which is glued from $C$ and $C'$
  > along $P \simeq P'$, and
  > $$\mathcal{O}_Z \simeq \mathcal{O}_{Z_0} \oplus j_*L \oplus j'_*L'.$$
  > It is well known that the natural map
  > $$j_*L \oplus j'_*L' \to \underline{\mathrm{Hom}}(j_*L \oplus j'_*L', \omega_{Z_0})$$
  > is an isomorphism, i.e., $j_*L \oplus j'_*L'$ is a generalized spin-structure. It is easy to see
  > that above map is precisely $\delta^-$, so this proves that $Z/S$ is a stable supercurve.
  > $\square$
- 文献自称的严格程度：编号引理 + 完整证明，唯一外包的一步逐字自称 "**It is well known that** the
  natural map $j_*L \oplus j'_*L' \to \underline{\mathrm{Hom}}(j_*L \oplus j'_*L', \omega_{Z_0})$
  is an isomorphism"——**这一步以"众所周知"引入，本文未给引文，也未自证**（经典自旋曲线上广义
  自旋结构在节点处的标准事实）。如实记录。
- 文献列出的依赖：§7.5 开头的一般粘接构造（p.47）；"广义自旋结构"的概念（本文 Lemma 2.6，
  见 E4）；**上述 "well known" 的经典事实（无引文）**。
- **对穿孔数目的依赖（逐字）**：Lemma 7.9 的陈述**只提到被粘的那一对 NS 穿孔 $P \subset X$、
  $P' \subset X'$**，对 $X, X'$ 上**其余**穿孔的数目**不作任何限制，也不出现**。证明也只在
  $P, P'$ 的邻域讨论。**即：本条对穿孔数目没有任何显式依赖。**（但同样地，作者也**没有**写下
  "对任意穿孔数成立"这句话——只是陈述里根本没有出现穿孔数这个量。）

#### (b) Lemma 7.10 —— 切空间余维 $1|0$ 的嵌入 + $\Delta_{NS}$ 就是 (7.8)/(7.9) 的概形像
- 原文陈述（逐字，p.48；500 dpi 复核）：
  > **Lemma 7.10.** *Both morphisms (7.8) and (7.9) induce embeddings of codimension $1|0$ on tangent
  > spaces and factor through the divisor $\Delta_{NS}$. Furthermore, near a stable supercurve with a
  > single separating (resp., non-separating) NS node, the divisor $\Delta_{NS}$ coincides with the
  > schematic image of (7.8) (resp., (7.9)).*
- 证明梗概（逐字要点，p.48–49）：
  > *Proof.* The idea is to use exact sequences (3.9). Let $X$ be a stable supercurve with punctures
  > and a fixed NS-node $q \in X$, and let $\rho : \widetilde{X} \to X$ be the normalization at $q$,
  > equipped with the two NS punctures over $q$. Then by Proposition 3.11(i), we have
  > $$\mathcal{A}_X \simeq \rho_*\mathcal{A}_{\widetilde{X}}$$
  > (where we take into account all the punctures on both sides). Hence, the natural map
  > $$H^1(\widetilde{X}, \mathcal{A}_{\widetilde{X}}) \to H^1(X, \mathcal{A}_X)$$
  > is an isomorphism.
  >
  > Let $q_1, \dots, q_m$ be the nodes of $X$ different from $q$. Then we have a morphism of exact
  > sequences
  > $$\begin{array}{ccccccccc}
  >   0 & \to & H^1(\widetilde{X}, \mathcal{A}_{\widetilde{X}}) & \to & T_{\mathrm{Def}(\widetilde{X})}
  >     & \to & \bigoplus_{i=1}^{m} T_{\mathrm{Def}(\mathcal{O}_{X,q_i})} & \to & 0 \\
  >   0 & \to & H^1(X, \mathcal{A}_X) & \to & T_{\mathrm{Def}(X)} & \to &
  >     T_{\mathrm{Def}(\mathcal{O}_{X,q})} \oplus \bigoplus_{i=1}^{m}
  >     T_{\mathrm{Def}(\mathcal{O}_{X,q_i})} & \to & 0
  >   \end{array}$$
  > in which the right vertical arrow is the natural inclusion of codimension $1|0$. Since the left
  > vertical arrow is an isomorphism, the assertion about the map of tangent spaces follows.
  >
  > To check that our morphisms factor through $\Delta_{NS}$, we have to check that the pull-back of
  > the morphism $\mathcal{O} \to \mathcal{O}(\Delta_{NS})$ is zero. Since the sources are smooth, it
  > is enough to check this generically, so we can consider a neighborhood of the point corresponding
  > to a supercurve with a single NS node. Then we know that the local equation of $\Delta_{NS}$ will
  > be $(t = 0)$, where $t$ corresponds to the map to the universal deformation of the node. Since the
  > deformation of the node given by the source of the maps (7.8) and (7.9) is trivial, this proves
  > that the pull-back of $t$ with respect to one of these maps is zero. Using the fact that the
  > morphism on tangent spaces is an embedding with the image which is the orthogonal to $dt$, we
  > deduce that near this point $\Delta_{NS}$ is the schematic image of the morphism. $\square$
- 文献自称的严格程度：编号引理 + 完整证明（"the assertion follows" / "we deduce that…"，无外包、
  无弱化措辞）。
- 文献列出的依赖（作者自列，逐字）：(3.9)（§3 的正合列）；**Proposition 3.11(i)**（$\mathcal{A}_X
  \simeq \rho_*\mathcal{A}_{\widetilde{X}}$）；Proposition 7.8（$\Delta_{NS}$ 作为有效 Cartier
  除子的存在与局部方程，见下）；节点的普适形变理论（§3.5/3.6）。
- **对穿孔数目的依赖（★ 本条的承重信息，正反两侧逐字证据）**：
  **支持"与穿孔数无关"的一侧：**
  1. 证明第二句逐字：*"Let $X$ be a stable supercurve **with punctures** and a fixed NS-node
     $q \in X$"*——**明确允许 $X$ 带（任意多个）穿孔**，没有任何数量限制。
  2. Proposition 3.11(i) 的引用处作者**特意加了括注**，逐字：*"(where we take into account **all the
     punctures on both sides**)"*——即同构 $\mathcal{A}_X \simeq \rho_*\mathcal{A}_{\widetilde{X}}$
     是在"把两边**所有**穿孔都算进去"的意义下成立的。**这是本轮找到的、作者亲手写下的、最接近
     "本论证对任意穿孔数成立"的一句话**，但注意它**只是对 Lemma 7.10 证明中 $\mathcal{A}$ 层这一步
     的说明，不是对 (9.6)/Theorem C 的任何声明**。
  3. Lemma 7.10 的陈述本身逐字只谈 (7.8)/(7.9) 与 $\Delta_{NS}$，而 (7.8)/(7.9) 的定义域/陪域
     带一般 $(m,n)$ 指标（E12）——**故 Lemma 7.10 逐字就是"对任意穿孔数的 (7.8)/(7.9)"成立的**。
     ⚠ 这是 E7–E11 各条里**唯一**一条陈述层面就覆盖一般穿孔指标的结果。
  4. 证明里出现的 $m$ 是"**除 $q$ 以外的节点个数**"（$q_1,\dots,q_m$），**不是穿孔数**——⚠ 这是
     本文第三处 $m$ 的不同用法（(8.11) 里 $m$ = NS 穿孔数，Lemma 9.3 里 $m$ = $\omega$ 的幂次，
     这里 $m$ = 其余节点个数）。**记号陷阱，curator 引用时务必核对上下文。**

  **反面 / 限制条件的一侧：**
  1. Lemma 7.10 的第二句只断言"**在带单个（分离/非分离）NS 节点的稳定超曲线附近**，$\Delta_{NS}$
     与 (7.8)（resp. (7.9)）的概形像重合"——**是局部（"near"）断言，不是全局等式**。
  2. 证明中 "*Since the sources are smooth, it is enough to check this generically*" 一步用到了源的
     光滑性（来自 Theorem A 对每个 $(g;m,n)$ 的光滑性），**即本条在逻辑上仍依赖 Theorem A**。
  3. Lemma 7.10 **完全不涉及 Ramond 节点**——Ramond 的类比是 **Lemma 7.14**（p.51，逐字：
     "*Both morphisms (7.11) and (7.12) induce embeddings of codimension $1|0$ on tangent spaces and
     factor through the divisor $\Delta_R$. Furthermore, near a stable supercurve with a single
     non-separating Ramond node the divisor $\Delta_R$ coincides with the schematic image of
     (7.11).*"）。⚠ **注意 Lemma 7.14 的第二句只对 non-separating 一种情形断言概形像重合，
     没有像 Lemma 7.10 那样给出 separating 的 "(resp., …)" 对应**——即 **(7.12)（分离型 Ramond）
     的概形像与 $\Delta_R$ 的关系，Lemma 7.14 逐字没有断言**。这是原文里一处真实的不对称，如实
     记录，不替作者补。
- 备注：**Proposition 7.8(i)**（p.47，$\Delta_{NS}$ 的存在与"在只有 NS 节点的点邻域与 $\Delta$
  重合"）是 Lemma 7.10 的前置，E9 备注 (b) 第 1 条已逐字抄录；其 (ii) 与其后一段逐字为：
  > *(ii) There exists a unique effective Cartier divisor $\Delta_R$ supported on the locus of stable
  > supercurves with at least one Ramond node, such that*
  > $$\Delta = \Delta_{NS} + \Delta_R.$$
  > *If $X_0$ is a stable supercurve with NS nodes $q_1,\dots,q_r$ and Ramond nodes
  > $q_{r+1},\dots,q_k$, then there exists an étale neighborhood $B$ of $[X_0]$ in
  > $\overline{\mathcal{S}}$ with a smooth morphism $t_1,\dots,t_k : B \to \mathbb{A}^k$ such that
  > $t_1 \dots t_r$ is an equation of $\Delta_{NS}$ and $t_{r+1} \dots t_k$ is an equation of
  > $\Delta_R$.*
