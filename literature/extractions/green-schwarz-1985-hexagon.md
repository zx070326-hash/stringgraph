# 抽取记录：green-schwarz-1985-hexagon

- 文献：M. B. Green and J. H. Schwarz, *The hexagon gauge anomaly in type I superstring theory*, Nucl. Phys. **B255** (1985) 93–114
- 抽取者：researcher agent
- 日期：2026-09-11
- 覆盖范围：**待本文件后续各节填写**（骨架先落盘，逐节追加）

> **本文件为骨架 + 逐节追加。** 各节内容见下。

## 0. 获取途径与证据等级（必读）

### 0.1 ★ 一句话结论

**正文未取得。本记录整体为 L2（出版方权威元数据 + 出版方摘要），不含任何一手正文。**
⇒ **本记录不得用来给图里任何节点提供公式号、系数、章节号。** 只能支持"这篇论文声称了什么"这一层。
本轮把任务书点名的五条路线全部跑完（CDS / KEK scanned / OSTI purl / INSPIRE fulltext / 大学课程页），另加 INIS、
Semantic Scholar、CaltechAUTHORS 三条，**全部失败**，逐条留痕见 §0.4。

### 0.2 证据等级约定（与 `green-schwarz-1984.md` §0、`math-sources.md` §0 一致）

| 等级 | 含义 | 本记录中的用法 |
|---|---|---|
| **L1** | 一手正文逐字读到（读图或可选文本） | **本记录无 L1 内容** |
| **L2** | 出版方 / 权威书目库的**原文字段**（INSPIRE 转载的出版方摘要、期刊卷页、DOI、报告号） | §0.3 的全部元数据、§2 的全部陈述 |
| **L3** | 二手文献对本文内容的转述 | §4 里点名的候选，**本轮一条都没有落实** |
| **L4** | 检索后端中介的说法 | §0.5 的两个**已证伪**的例子 |

### 0.3 文献标识（**全部 L2，逐字取自 INSPIRE recid 207661**）

- 标题（INSPIRE `titles` 逐字）：`The Hexagon Gauge Anomaly in Type I Superstring Theory`
  ⚠ **大小写与"I"的写法有分歧**：INSPIRE 作 `Type I`；INIS 与 Semantic Scholar 均作 `Type 1`（阿拉伯数字 1）。
  期刊原刊标题的排法**未核实**（L0）。`sources.bib` 沿用通行的 `type I`。
- 出版信息（INSPIRE `publication_info` 逐字）：`Nucl.Phys.B`, volume `255`, `page_start: 93`, `page_end: 114`, `year: 1985`。
- **DOI（逐字）**：`10.1016/0550-3213(85)90130-0`。
- 报告号（INSPIRE `report_numbers` 逐字）：`CALT-68-1224`。
  `pubinfo_freetext` 逐字：`In *Schwarz, J.h. ( Ed.): Superstrings, Vol. 2*, 1018-1039. ( Nucl. Phys. B255 ( 1985) 93-114) and Caltech Pasadena - CALT-68-1224 (84,REC.JAN.85) 33p`
  ⇒ **预印本 1984 年发出、1985 年 1 月收录、33 页**；**重印出处只有一个**（见 §0.4 对路线选择的影响）。
- 外部标识（INSPIRE `external_system_identifiers` 逐字）：`MSNET 792246`、**`KEKSCAN 85-02-154`**、`SPIRES-1305298`。
  ⚠ **没有 `CDS` 项**。本条与 `goddard-thorn-1972` 不同（后者有 CDS id）。由于本记录的该字段**非空**（有三项），
  "无 CDS 项"这一次可以当作**有分量的否定证据**（但仍不是出版方侧的否证，见 §0.4 末的方法论提醒）。
- INSPIRE `documents` / `urls`：**两字段皆缺失（absent）** ⇒ INSPIRE 侧无全文。
- INIS（L2，`inis.iaea.org/api/records`）给出**两条**记录，都 `files.enabled: false` / `access.status: "metadata-only"`：
  1. 期刊版：TRN `NL85F2852`，RN `16069207`，`Nucl. Phys., B` **255**(1), `93-114`，日期 **1985-06-17**。
  2. 重印章：TRN `US8722862`，RN `18077387`，World Scientific 1985，书名逐字
     `Superstrings: The first 15 years of superstring theory`，`p. 1018-1039.`
  ⇒ **重印文集就是 Schwarz 编的那套两卷本**，即本项目在 `goddard-thorn-1972` 那轮已**穷尽检索、确认不在 archive.org** 的同一本书。

### 0.4 失败路径逐条留痕（本轮，供后人省事）

| # | 路线（任务书优先级） | 具体 URL / 手法 | 结果 |
|---|---|---|---|
| 1 | **CDS 搜索** | `cds.cern.ch/search?p=Green+Schwarz+hexagon+1985` | **失败：Anubis 反爬页**，首行逐字 `Making sure you're not a bot!`（2026-09-11 复核，与既有记录一致）。**不要用代理绕** |
| 2 | CDS 元数据（OAI-PMH） | `cds.cern.ch/oai2d?verb=GetRecord&…&identifier=oai:cds.cern.ch:<recid>` | **未执行**：该端点需要 `<recid>`，而 INSPIRE 的 `external_system_identifiers` **无 CDS 项**（§0.3），拿不到 recid。⇒ 这条路线对本篇**没有入口**，不是"试了不行" |
| 3 | **KEK scanned** | `lib-extopc.kek.jp/preprints/PDF/1985/8502/8502154.pdf`（由 `KEKSCAN 85-02-154` 按既有猜测规则拼出） | **失败：`socket hang up`**。这是本项目第**三**次在该主机上拿到同样的失败模式 ⇒ **`lib-extopc.kek.jp` 直取应判定为死路**，`KEKSCAN` id 只能当书目标识用 |
| 4 | **OSTI purl** | `osti.gov/api/v1/records?q="CALT-68"` | **无效查询**：返回 5 条全是 `SLAC-PUB-*`，与查询无关 ⇒ 按既有教训，**这是查询被吞，不能读作"OSTI 没有 CALT-68"** |
| 5 | **OSTI purl（干净的那次）** | `osti.gov/api/v1/records?q="hexagon gauge anomaly"&rows=10` | **有效查询、结果为否**：4 条命中全部**主题相关**（Edison–Schlotterer ×2、Konno、Caltech FY1987 年报）⇒ 查询没被吞；**其中没有 Green–Schwarz 本篇**。⇒ **OSTI 不藏本文**（较可靠的否定） |
| 6 | INSPIRE fulltext links | `inspirehep.net/api/literature/207661?fields=…,documents,urls` | **失败：两字段皆 absent** |
| 7 | **大学课程页扫描件**（AGW 那条成功路线） | 两次 WebSearch（`"Nuclear Physics B255" … pdf scan full text`；`"Nucl. Phys. B255" "93" … annulus Mobius pdf lecture notes course`） | **失败**：命中全是引用本文的 arXiv 论文与 INSPIRE 页面，**无任何 `.edu` 扫描件** |
| 8 | CaltechAUTHORS（CALT-68 系列的自然归宿） | `authors.library.caltech.edu/api/records?q=…`；`authors.library.caltech.edu/search?q=…` | **失败：两个端点均 HTTP 403** |
| 9 | CaltechAUTHORS（绕过 403，走检索后端） | `site:authors.library.caltech.edu Green Schwarz hexagon …` | **失败**：只回该站两条无关的 Schwarz 记录（M-theory/AdS-CFT、Superconformal Chern-Simons） |
| 10 | Semantic Scholar 定位扫描件路径 | `api.semanticscholar.org/graph/v1/paper/DOI:10.1016/0550-3213(85)90130-0?fields=openAccessPdf,isOpenAccess` | **失败但字段干净**：`isOpenAccess: false`，`openAccessPdf: {"url": "", "status": "CLOSED", "license": null}` |
| 11 | INIS 存在性探测 | `inis.iaea.org/api/records?q="hexagon gauge anomaly"&size=20` | **成功取到元数据、全文为否**：两条本文记录均 `files.enabled: false` / `metadata-only`（§0.3） |
| 12 | archive.org 重印文集 | **未执行** | 输入条件不满足：`pubinfo_freetext` **只有一个**重印出处，且正是 `goddard-thorn-1972` 那轮已用五种检索确认**不在 archive.org** 的 Schwarz 编 *Superstrings*（World Scientific）。按既有边界条件（"只有一个重印出处时命中率很低"），**不再投入额度** |

> **方法论提醒（沿用 `goddard-thorn-1972` 那轮的教训）**：上表第 2 行的"无 CDS id"来自**聚合库**。
> 要真正否证"CERN 有本文的扫描件"，得查到出版方/图书馆侧。本篇是 Caltech 预印本、非 CERN-TH 报告，
> 先验上 CDS 收录概率低，但**这一条仍属未穷尽**。

### 0.5 ★ 本轮证伪的两条 L4 说法（**不要再被它们带偏**）

1. **错误 DOI**：检索后端给出 `10.1016/0550-3213(85)90605-4`。用它查 Semantic Scholar 返回的是**另一篇论文**
   （`Analytic operator approach to fermionic lattice field theories`，1985）。**正确 DOI 见 §0.3，以 INSPIRE 逐字字段为准。**
2. **错误的报告号归属**：检索后端两次断言 `CALT-68-1224` 是 GS 1984（Phys. Lett. B149, 117）那篇的预印本号，
   还一次把它绑到 INSPIRE recid `245035`（`Coupling Constant Relations and Effective Lagrangian in the Type I Superstring`）。
   **两条都错**：`CALT-68-1224` 由 INSPIRE 逐字挂在本篇（recid 207661）名下；**GS 1984 的预印本号是 `CALT-68-1182`**
   （见 `extractions/green-schwarz-1984.md`）。

## 1. 约定

**无法填写。** 号差、`α'` 归一化、`Tr` vs `tr` 的取法、Chern–Simons 三形式的符号——**本轮一条都没有核到**（正文未取得）。

两点必须记下来，防止 curator 想当然：

1. **不得把 `green-schwarz-1984` 的约定套到本文头上。** GS 1984 全文**未声明号差**（见该记录 §1），
   本文是否声明、是否与之一致，**未知（L0）**。
2. 特别是 **`Tr` 与 `tr` 的关系**（GS 1984 对 E₈ 取 `tr = Tr`；Bilal 另取 `trF² ≡ (1/30)TrF²`）与
   **`H = dB + ω⁰_{3Y} − ω⁰_{3L}` 的整体符号**，在本文里如何取，**都不能从 GS 1984 推断**。
   本文若被用作 `conv.h-chern-simons-sign` 一类约定节点的来源，**必须先取到正文**。

## 2. 陈述

> **⚠ 全节 L2。位置栏一律只能写「摘要」。本文任何公式号、章节号、图号在本项目内均为 L0 —— 严禁编号。**
> 摘要来源：INSPIRE recid 207661 的 `abstracts` 字段（INSPIRE 对 pre-arXiv 论文转载**出版方摘要**）。
> 取法：让抓取端按顺序输出**每段 <110 字符的逐字片段**（整段直引会被长度限制拒绝），共 10 段，按序拼回。
> **拼接是抽取者做的，片段本身是逐字的**；下面给出拼回的全文，读者可按 10 段边界复核。

**摘要（拼回全文，L2）：**

> "Hexagon diagrams with external on-mass-shell Yang-Mills gauge particles are investigated in type I superstring theory. Both the annulus and the Möbius-strip diagrams are shown to give anomalies, implying that spurious longitudinal modes cannot be consistently decoupled. However, the anomalies cancel when the two diagrams are added together if the gauge group is chosen to be SO(32). In carrying out the analysis, two different regulators are considered, but the same conclusions emerge in both cases. We point out where various terms in the low-energy effective action originate in superstring diagrams."

### E1 单圈六边形图在 type I 超弦中的计算对象
- 位置：摘要（**无公式号可给**）
- 类型：proposition（研究对象声明）
- 原文陈述（逐字）："Hexagon diagrams with external on-mass-shell Yang-Mills gauge particles are investigated in type I superstring theory."
- 文献自称的严格程度：**"are investigated"**（无"we prove"）
- 文献列出的依赖：摘要不列
- 备注：⚠ **"六点振幅"这个说法不出现在摘要里**。摘要只说 "hexagon diagrams"，且限定外线为
  **在壳（on-mass-shell）Yang–Mills 规范粒子**。"hexagon = 六点"是领域常识，但**在本记录里属推断，不属原文**。

### E2 annulus 与 Möbius 带图**各自**给出反常
- 位置：摘要
- 类型：proposition
- 原文陈述（逐字）："Both the annulus and the Möbius-strip diagrams are shown to give anomalies, implying that spurious longitudinal modes cannot be consistently decoupled."
- 文献自称的严格程度：**"are shown to give"**（本篇摘要里最强的动词）
- 文献列出的依赖：摘要不列
- 备注：⚠ 任务书里的措辞是"SO(32) **平面图**与 Möbius 相消"。**摘要用的词是 `annulus`（环带），不是 `planar`。**
  开弦单圈里"平面图 = 环带图的一部分（含非平面环带）"这层对应关系**是二次文献的说法，本文摘要不支持**，
  转节点时**必须写 `annulus`**。另：反常的**物理判据**在本文摘要里是
  **"spurious longitudinal modes 不能一致地解耦"**（即耦合到非物理纵向模），而不是"反常多项式不为零"。
  这是与 GS 1984（纯场论侧、用反常多项式）**不同的判据**，值得单独建节点或至少写进 note。

### E3 两图相加后反常相消 —— **条件是 SO(32)，措辞是充分条件**
- 位置：摘要
- 类型：proposition
- 原文陈述（逐字）："However, the anomalies cancel when the two diagrams are added together **if** the gauge group is chosen to be SO(32)."
- 文献自称的严格程度：陈述句，无"prove"
- 备注：⚠⚠ **"if"，不是 "only if"。** 这与 GS 1984 摘要的措辞模式完全一致
  （该记录 §8 已记："摘要只给充分条件 `cancel if the gauge group is…`"）。
  ⇒ **不得从本文推出"只有 SO(32)"**，也不得用本文支撑任何唯一性/分类陈述。
  ⇒ 另注意：**摘要里没有 E₈ × E₈**。本文是 **type I 开弦**的计算，E₈ × E₈ 不在其射程内
  （与 GS 1984 一致：那里 E₈×E₈ 超弦 "has not yet been constructed"）。

### E4 两套正规化子给出同样结论（本文自陈的稳健性检查）
- 位置：摘要
- 类型：proposition（方法学）
- 原文陈述（逐字）："In carrying out the analysis, two different regulators are considered, but the same conclusions emerge in both cases."
- 文献自称的严格程度：**"are considered" / "the same conclusions emerge"**
- 备注：**是哪两种正规化子，摘要不说（L0）。** 这条对图有直接价值——它是本文自己给出的
  "结果不依赖正规化方案"的论证；但**在拿到正文前不能写进节点的 `notes`，只能作为待核对象**（§4 Q2）。

### E5 与低能有效作用量中各项的对应（= 与 GS 1984 反项的接口）
- 位置：摘要
- 类型：proposition
- 原文陈述（逐字）："We point out where various terms in the low-energy effective action originate in superstring diagrams."
- 文献自称的严格程度：**"We point out"**（**全篇摘要里最弱的动词**）
- 备注：⚠⚠ **这是任务书问的"与 GS 1984 反项（`S₁`/`S₂`/`S₃`）对应"那一条的唯一线索，而它只有这一句。**
  摘要**没有**点名 `B ∧ tr F⁴`、`ω⁰_{3Y} dB`、`H²` 中的任何一项，也**没有**说"本文导出了那些反项"。
  ⇒ **图里不得建"GS 1985 从弦论推出了 GS 1984 的反项"这样的节点**；在取到正文前，
  最多只能建"本文声称指出了低能有效作用量各项的弦论起源"，且状态按 `physical-argument` 起步。

### 本节的**否定性**结论（同样重要）

摘要里**不出现**下列内容，因此本记录**不能**为它们提供任何支持：

- 任何数值系数（尤其二次文献常说的"平面图 ∝ n、Möbius ∝ ∓32，故 n = 32"——**本文摘要无此数**）；
- `Tr F⁶` 的因子化、十二形式 `X₈`、`B ∧ X₈`；
- 引力反常与混合反常（摘要只提 **Yang–Mills 规范粒子**外线）；
- 唯一性/分类（见 E3）；
- 与 `alvarez-gaume-witten-1984` 的关系。

## 3. 未核实式号 / 读图不确定处

**本文全部内容的公式号、章节号、图号一律 L0。** 本记录不提供任何一个编号，也**禁止**从二手文献搬运编号
（`green-schwarz-1984.md` §3 里那条"不要编式号"的纪律在这里升级为"连一个编号都不存在"）。

同时**未核实**的书目细节：

- 期刊原刊标题中 "Type I" 是罗马数字还是阿拉伯数字 `1`（§0.3 的分歧）。
- 收稿日期（GS 1984 那条有 `Received 7 October 1983` 类的页眉信息；本文**无**）。
- 33 页的预印本与 22 页的期刊版（93–114）之间的内容差异——**预印本可能含期刊版删掉的附录**，取到任一份都要记明是哪一份。
- 本文的参考文献表（因此**本文自己声称依赖谁，完全未知**）。

## 4. 未解决的疑问（留给 curator / auditor）

- **Q1（最重要）**：本文到底有没有**导出** GS 1984 的反项 `S₁`/`S₂`/`S₃`，还是只做了"指认起源"（E5 的动词是 "We point out"）？
  这决定图里"弦论侧 ⟹ 场论侧反项"这条边**存不存在**。**未取到正文前，这条边不得建。**
- **Q2**：E4 的"两种正规化子"分别是什么？这直接关系到该结果能给到什么状态
  （若两种独立正规化给出同一结论，是提升 `physical-argument` 可信度的实质论证，但仍不足以到 `rigorous`）。
- **Q3**：本文的反常判据是"spurious longitudinal modes 不能解耦"（E2），与 GS 1984 的反常多项式判据**不是同一个陈述**。
  两者在图里应是**两个节点**，还是一个节点两条推导？建议按项目原则（"一个节点一个命题"）先按**两个节点**处理，
  因为判据本身不同，不是同一命题的两条独立推导。
- **Q4**：`green-schwarz-1984.md` E17 记 GS 1984 自陈弦论侧 "details will be presented elsewhere"，
  `schwarz-2012-history`（L1，p.9）指认那个 elsewhere 就是本文。**本轮没有新增证据，该指认仍停在 L3。**
  取到正文后应核对：本文是否自称是 PLB 那篇的详细版。
- **Q5**：33 页预印本 `CALT-68-1224` 是否存在于 Caltech 校内的**非** CaltechAUTHORS 系统
  （Caltech Library digital collections / 旧的 `resolver.caltech.edu` 永久链接）？本轮只试了 CaltechAUTHORS 的两个端点（都 403）。

## 5. 图里建议怎么引 + `sources.bib` 登记

### 5.1 `sources.bib`

`green-schwarz-1985-hexagon` **本轮之前就已存在**（由前一轮 curator 按 `green-schwarz-1984.md` §6 的建议登记）。
本轮**只在其 `note` 末尾追加**本次核实到的标识与失败路径，**不改动已有字段**。

### 5.2 给 curator 的建议（researcher 不改 `graph/`）

1. **本轮不建议新增任何图节点。** 理由：整篇只有 L2 摘要，五条陈述里有四条（E1/E3/E4/E5）的动词都是
   "investigated / if / are considered / We point out"，**没有一条能撑起一个精确陈述卡片**。
2. 若 lead 坚持要一个占位节点，唯一可接受的形态是**一条弱陈述**：
   「type I 超弦单圈六边形图（外线为在壳规范粒子）的 annulus 与 Möbius 带贡献相加后，
   在规范群取 SO(32) 时反常相消」，`status: physical-argument`，
   `sources: [{ref: green-schwarz-1985-hexagon, loc: "abstract"}]`，并**必须**在 `notes` 写明
   「**仅据出版方摘要**；正文未取得；措辞是充分条件 `if`，不得读作唯一性；本文用的是 `annulus`，不是 `planar`」。
3. **禁止**把本文列为下列任何节点的 source：唯一性/分类（SO(32) 与 E₈×E₈ 是仅有的解）、`X₈` / `B ∧ X₈`、
   引力反常或混合反常、`H` 的 Chern–Simons 符号约定、任何带系数的因子化恒等式。
4. `green-schwarz-1984` 的 E17（弦论侧结果，原文自陈"details will be presented elsewhere"）
   **仍然只能停在 `physical-argument` 且 `inferred` 的接口**——本轮没有把它接实。

### 5.3 下一轮最省力的三个入口（按性价比排序）

1. **GSW *Superstring Theory* Vol. 2（Green–Schwarz–Witten 自己的书）走 Cambridge Core 章级 PDF。**
   本环境对 CUP 有机构订阅（Polchinski 两卷已实测），若 GSW 也在 Core 上，
   反常那一章就是**同一批作者对同一计算的详细版**，能一次性解决 Q1/Q2/Q3 的内容层
   （对本文仍是 L3，但对 `gsw-1987-v2` 本身是 L1），而且 `reading-list.md` 里 `gsw-1987-v2` 已挂 P2 待抽。
2. **Caltech 侧的 `CALT-68-1224`**：CaltechAUTHORS 的 `/api` 与 `/search` 都 403，但**单条记录页**在检索后端可见
   （例：`authors.library.caltech.edu/records/<id>` 能被抓到）。找到记录 id 就可能直取。
3. **把两个 URL 交给人类点击**（agent 过不去，但出版方并未标 restricted）：
   Elsevier `doi.org/10.1016/0550-3213(85)90130-0`；以及任何持有 Schwarz 编 *Superstrings*（World Scientific, 1985）
   Vol. 2 pp. 1018–1039 的图书馆纸本。
