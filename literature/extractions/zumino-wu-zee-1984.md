# 抽取记录：zumino-wu-zee-1984

- 文献（目标）：B. Zumino, Wu Yong-Shi and A. Zee, "Chiral anomalies, higher dimensions, and differential geometry", *Nuclear Physics B* **239** (1984) 477–507.
- 文献（**本轮实际取到全文的**）：B. Zumino, *Chiral anomalies and differential geometry*, Lectures given at Les Houches, August 1983；报告号 **LBL-16747 / UCB-PTH-83/16 / DE84 004637**，October 1983，"Notes prepared by K. Sibold (University of Geneva)"，正文印刷页 pp. 1–46。
- 抽取者：researcher agent
- 日期：2026-09-11
- 覆盖范围：**LBL-16747 全文 46 页逐页读毕（L1）**；**ZWZ (Nucl. Phys. B239) 正文一字未取到（L0/L2）**
- 目标 area：`consistency`

---

## 0. ★★ 获取途径与证据等级（**必读，本记录的效力全部取决于本节**）

### 0.1 证据等级

沿用 `extractions/primary-sources-round2.md` §0 的 L0–L4 五级制（同 `green-schwarz-1984.md` §0.1）：

| 级 | 含义 |
|---|---|
| L1 | 逐页读了原文（扫描件/正文 PDF），可照抄措辞 |
| L2 | 出版方权威元数据或期刊逐字摘要 |
| L3 | 可溯源二手陈述 |
| L4 | 检索后端中介读取，非逐字，不得单独作为唯一依据 |
| L0 | 未能核实 |

### 0.2 ★★ 本轮的核心事实：**取到的不是 ZWZ，而是 Zumino 的 Les Houches 讲义**

> **这是本记录最重要的一条限定。转节点、写 `sources[].ref` 时必须区分两个不同的文献。**

| 文献 | 本轮等级 | 说明 |
|---|---|---|
| **ZWZ** = Zumino–Wu–Zee, Nucl. Phys. **B239** (1984) 477–507 | **L2**（仅 INSPIRE 逐字摘要 + 出版方元数据） | **正文未取到。** 见 §0.4 的失败路径清单 |
| **Z-LH** = Zumino, LBL-16747（Les Houches 1983 讲义，K. Sibold 记录） | **L1 全文 46 页** | 本记录 §2 的 E1–E17 全部出自这里 |

两者的关系有 **Z-LH 原文自陈的直接证据**（印刷 p.2，引言首段，逐字）：

> "In these lectures I shall describe a number of properties of chiral anomalies from a geometric point of view. I follow mostly work done in collaboration with Raymond Stora [1]. **Some of the results are contained in a recent paper written in collaboration with Wu Yong-Shi and Anthony Zee [2]**, to which I refer also for an extensive list of old and new references on chiral anomalies. It is possible that the methods and results described in these lectures are fully known in mathematics. On the other hand, several crucial formulas have not been given before (at any rate not explicitly) and their physical relevance is emphasized here."

Z-LH 的参考文献 `[2]`（印刷 p.45，逐字）：

> "[2]. B. Zumino, Wu Yong-Shi and A. Zee, Univ. of Washington preprint **40048-17 P3**, (1983), submitted to Nuclear Physics."

⇒ **Z-LH 是 ZWZ 的同作者、同期（1983 年秋）、显式互引的伴随文献**，且 Zumino 是 ZWZ 的第一作者。
⇒ 但 **"Z-LH 的某条式子 ⇒ ZWZ 也有同样的式子与同样的符号" 是推断，不是核实**。凡把本记录用于 ZWZ 的场合，一律标 `inferred: true`。

### 0.3 ★ 派工单的两处前提在本轮被证伪

| 派工单前提 | 本轮结论 | 证据 |
|---|---|---|
| 「INSPIRE `publication_info` 有重印信息；ZWZ 收录于 *Current Algebra and Anomalies* 与 Treiman 等编的文集」 | **不成立（两层都不成立）** | (a) INSPIRE recid **194780** 的 `publication_info` **只有一条**期刊条目、**无 `pubinfo_freetext`**（逐字 JSON 见 §0.4 第 1 行）⇒ INSPIRE **不认为**本文有任何重印出处。(b) *Current Algebra and Anomalies*（Treiman–Jackiw–Zumino–Witten eds., 1985）的目录里 **Zumino 的那一章是 pp. 361–393 "Chiral Anomalies and Differential Geometry"，即 Les Houches 讲义（单作者），不是 ZWZ**；该书全部章节为 Treiman(PCAC, p.1)、Jackiw ×2 (p.81, p.211)、**Zumino (p.361)**、Bardeen–Zumino (p.393)、Witten ×3 (p.429 起)、Alvarez-Gaumé–Witten (p.451)。**ZWZ 不在该书内。** |
| 「大学课程页扫描件（搜 `"zumino wu zee" filetype:pdf site:edu`）」 | **未命中 ZWZ 正文** | 该检索的最佳 `.edu` 命中是 `hitoshi.berkeley.edu/230A/anomalies.pdf`（Murayama 课程笔记，**转述** ZWZ 的构造，L3/L4 性质），**不是原刊扫描件** |

⇒ 由 `reference_archive-org-reprint-fulltext-route` 记忆里已确立的边界条件（「本路线成败取决于重印出处数量；只有一个出处时命中率很低」），**ZWZ 的重印文集路线在输入条件上就不满足（出处数 = 0），本轮不再投入额度**。
⇒ 顺带修正一条项目内的既有判断：`alvarez-gaume-witten-1984.md` §0 与 `sources.bib` 都记了 AGW 重印于 *Current Algebra and Anomalies* pp. 451–514 —— 本轮独立取到的该书目录与之**一致**（AGW 在 p.451 起），这条可以保留。

### 0.4 逐条留痕：本轮为取 ZWZ 正文尝试过的全部路径

| 入口 | 结果 |
|---|---|
| `inspirehep.net/api/literature?q=t chiral anomalies higher dimensions and a Zumino&fields=…` | ✅ 拿到元数据：recid **194780**、DOI `10.1016/0550-3213(84)90259-1`、报告号 **`LBL-16443`** 与 **`DOE-ER-40048-18-P3`**、`external_system_identifiers` 只有 `MSNET 749345` 与 `SPIRES-1144324`。**无 `KEKSCAN`、无 `CDS`** ⇒ KEK 与 CDS/OAI-PMH 两条路线在入口上即被排除 |
| `inspirehep.net/api/literature/194780?fields=publication_info` | ✅ 逐字返回单条期刊条目，**无 `pubinfo_freetext`** ⇒ 无重印出处（见 §0.3） |
| `inspirehep.net/api/literature?q=doi …&fields=abstracts` | ✅ 拿到逐字摘要（L2，见 §2 的 **Z1**） |
| `api.semanticscholar.org/graph/v1/paper/DOI:10.1016/0550-3213(84)90259-1?fields=openAccessPdf,…` | ❌ `isOpenAccess: false`、`openAccessPdf: {"url":"", "status":"CLOSED"}`。（对比：同一端点对 GT 1972 曾给出 CDS 文件路径 ⇒ **本文确实没有已知的开放副本**，不是端点失灵） |
| `osti.gov/api/v1/records?report_number=LBL-16443` | ❌ 无命中 |
| `osti.gov/api/v1/records?q="LBL-16443"` | ❌ 无命中（只回同批的 `LBL-18260`，即 LBL 1983 年度报告）⇒ OSTI 检索本身在工作，**是 OSTI 不藏此件** |
| `osti.gov/api/v1/records?q="chiral anomalies, higher dimensions and differential geometry"` | ❌ 无命中 |
| `osti.gov/api/v1/records?q="DOE/ER/40048" AND anomalies` | ❌ 返回一批 Brodsky/SLAC 记录 = 查询被忽略，**该端点对含 `/` 的报告号查询不可靠** |
| `inis.iaea.org/api/records?q=Zumino AND Zee AND anomalies` | ⚠️ 找到 ZWZ 的 INIS 记录 **`zectt-7td81`**，但资源类型 = Journal article、**`metadata-only`、无文件** |
| `inis.iaea.org/collection/NCLCollectionStore/_Public/15/062/15062449.pdf`（按 INIS RN 15062449 推的旧公共路径） | ❌ HTTP 404 |
| `digital.library.unt.edu/search/?q=LBL-16443`（TRAIL / DOE 技术报告扫描） | ❌ 被 **Altcha 反爬挑战页**挡住，未取到检索结果。**未穷尽，可由人工浏览器复核** |
| `sciencedirect.com/science/article/abs/pii/0550321384902591` | ❌ 已知死路（Elsevier 403，`reading-list.md` 死路清单） |
| `academia.edu/53533197`（检索后端提示有用户上传 PDF） | ⛔ **主动不使用**。这是对受版权保护期刊论文的未授权再上传，按 `literature/CLAUDE.md` 规则 1 与 `reading-list.md`「未授权扫描站本项目不使用」处理。**记录在此仅为说明本轮不是漏看** |

**结论：ZWZ 正文对本 agent 已穷尽当前可用路线。** 留给人类/后续的两个未穷尽入口见 §5.4。

### 0.5 ★ 新增可用路线（建议写入 `reading-list.md` 备忘）

> **`osti.gov` 的 `servlets/purl/<OSTI-ID>` 是 1980 年代 DOE 国家实验室报告（LBL/ANL/FNAL/SLAC…）正文的直接入口，本轮首次成功。**
> 这条路线此前在 `reading-list.md` 里被记为「OSTI 无全文」（针对 GT 1972 的结论），**该判断需要收窄为「OSTI 不藏 CERN-TH 报告」，而不是「OSTI 没有全文」**。
> 三步：
> 1. `https://www.osti.gov/api/v1/records?q=%22<报告号>%22` → 拿 **OSTI ID**。⚠ 用 `report_number=` 参数查会漏（本轮 `report_number=LBL-16443` 与 `q="LBL-16747"` 结果不一致），**一律用 `q="…"` 加引号**。⚠ 含 `/` 的报告号（`DOE/ER/40048`）会让查询被忽略并返回无关结果。
> 2. `https://www.osti.gov/servlets/purl/<OSTI-ID>` → **WebFetch 会抱怨读不了二进制但已落盘并打印路径**（本轮 LBL-16747 = OSTI **5461614**，529.6 KB，48 个 PDF 页）。
> 3. `Read` 带 `pages` 逐页读图。**扫描件是 JBIG2 打字稿 + 手写公式**，公式清晰度中等；`pages` 一次给 10 页可读，**关键公式必须单页重渲染**（本轮 §3.1 即靠此发现问题）。
>
> 交叉可用的第二入口：**INIS 的 `files` 字段**。`https://inis.iaea.org/api/records?q=…` 返回的记录里若 `files.enabled: true` 且 `access.files: "public"` / `access.status: "open"`，则确实有开放文件（本轮 LBL-16747 = INIS id `ph8pd-7r422`，文件名 `15035011.pdf`，542345 字节）。
> **但 INIS 的旧公共路径 `collection/NCLCollectionStore/_Public/<vol>/<iss>/<RN>.pdf` 仍是 404**（本轮对 `15/035/15035011.pdf` 实测），**所以 INIS 只宜当「存在性探测器」，取文件走 OSTI**。
> ⇒ 这修正了记忆 `reference_web-fetch-access-blockers` / `reading-list.md` 里「INIS 取全文基本无望」的口径：**INIS 的 `files.enabled` 是可信的正信号，只是下载要换主机。**

### 0.6 页码映射（Z-LH / LBL-16747）

**印刷页码 = PDF 页码 − 1**（PDF p.1 = LBL 封面，PDF p.2 = 题名页/DISCLAIMER，PDF p.3 = 印刷 p.2 = 引言首页）。
本记录下文一律用「**Z-LH p.NN**」指**印刷页码**。
落盘副本：`C:\Users\charles\.claude-apexin\projects\D--physics-string\c626835a-9cb2-486b-bf93-f345125de513\tool-results\webfetch-1789072611067-cigjki.pdf`（临时文件，勿作长期引用；权威入口是 `osti.gov/servlets/purl/5461614`）。

章节结构（L1）：
| 节 | 标题 | 印刷页 |
|---|---|---|
| 1 | INTRODUCTION | 2–6 |
| 2 | CHIRAL ANOMALIES AND DIFFERENTIAL FORMS | 7–17 |
| 3 | TRANSFORMATION PROPERTIES OF THE ANOMALIES | 18–25 |
| 4 | IDENTIFICATION AND USE OF THE ANOMALIES | 26–36 |
| 5 | NORMALIZATION OF THE ANOMALIES | 37–40 |
| — | ACKNOWLEDGMENT | 40 |
| App. | A SIMPLE FORMULA FOR α_{2n−2} | 41–44 |
| — | REFERENCES（[0]–[20] + Added Note） | 45–46 |

---

## 1. 约定（Z-LH，全部 L1）

### 1.1 Z-LH 自述的约定

| 项 | Z-LH 的取法 | 位置 |
|---|---|---|
| 规范势一形式 | `A = −i A^k_μ λ_k dx^μ` ——「a matrix of one-forms (i.e. having anticommuting elements)」 | (2.10)，p.9 |
| 场强 | `F = dA + A²` ——「a matrix of two-forms (wedge symbol suppressed, matrix multiplication understood, elements of F commuting)」 | (2.11)，p.9 |
| Bianchi | `DF ≡ dF + [A, F] = 0` | (2.12)，p.9 |
| `d` 的性质 | `d² = 0`；**`d` 与一形式 `A` 反交换** | (2.13) 及其后一句，p.10 |
| `λ_k` | 内部对称群（如 SU(2)、SU(3)）的生成元，**厄米**（由 (2.1) 的 `iψ̄γ^μ(∂_μ − iλ_k A^k_μ)ψ` 与 (2.4) 的 `F_{μν} = −iλ_k F^k_{μν}` 定出） | (2.1)(2.4)，p.7 |
| 鬼场 / 群方向 | `v ≡ g⁻¹δg`（(3.24)）或 `v = −i v^k λ_k`（(4.13)，v 是 0-形式、取值于李代数）；Faddeev–Popov 场 `v_i(x)` 是**反交换标量** | (3.24) p.21；(4.6)(4.13) p.27–28 |
| 两个外微分 | `d = dx^μ ∂/∂x^μ`（x 方向）、`δ = dt^α ∂/∂t^α`（群参数方向）；`Δ ≡ d + δ` | (3.18)(3.19)(3.21)，p.21 |
| 迹 | `Tr`（未区分表示）；对称化迹 `Str(B₂,…,B_n) = Σ_{Perm}(1/n!)Tr(B_{π(2)}⋯B_{π(n)})` | (3.35)，p.23 |
| 下标约定 | `ω^p_q`：**上标 = v（鬼场）的幂次**，下标 = x-形式次数。逐字："where the superscript indicates the power of v"（(3.31) 后） | (3.31)，p.22 |

### 1.2 ★★ 与 GS 1984 的约定对照 —— **完全同一套**

这是本轮最重要的技术结论。GS 1984 的 Chern–Simons / 下降方程装置与 Z-LH **逐字同构**（GS 侧全部 L1，取自 `green-schwarz-1984.md` E3/E4/E9）：

| 项 | GS 1984 | Z-LH | 是否同一约定 |
|---|---|---|---|
| 场强 | (2) `F ≡ ½F_{μν}dx^μ∧dx^ν = dA + A²`，省略 `∧` | (2.11) `F = dA + A²`，省略 `∧` | ✅ **同** |
| 规范势 | (3) `A = A^a_μ λ^a dx^μ`，`λ^a` **反厄米** | (2.10) `A = −i A^k_μ λ_k dx^μ`，`λ_k` 厄米 | ✅ **同**（`λ^a_GS = −iλ_{k,Z}`，两边的 `A` 都是**反厄米**矩阵一形式） |
| CS 三形式 | (5) `ω⁰_{3Y} = tr(AF − ⅓A³)` | (2.25) `ω₃ = 2∫₀¹dt t Tr A(t dA + t²A²) = Tr(A dA + ⅔A³) = Tr(AF − ⅓A³)` | ✅ **逐字同一表达式**（GS (5) 就是 Z-LH (2.25) 的第三种写法） |
| 第一条下降方程 | (6) `dω⁰_{3Y} = tr F²` | (2.26) `Tr F² = dω₃` | ✅ **同，含符号**（正号、无 `1/2π`、无数值因子） |
| 一般下降方程（顶） | (15) `dω⁰_{2n+1 Y} = tr F^{n+1}`，"defined (up to an exact form) by" | (3.1) `Tr F^n = dω⁰_{2n−1}`；(2.28) `Tr F^n = dω_{2n−1}` | ✅ **同，含符号**（换标 `n_Z = n_GS + 1`） |
| **下降方程的第二条（符号）** | (16) **`δω⁰_{2n+1 Y} = −dω¹_{2n Y}`** | (3.32) **`δω⁰_{2n−1} + dω¹_{2n−2} = 0`**；(4.18) `δω¹_{2n−2} = d(−ω²_{2n−3})` | ✅ **同，含符号**（`δω⁰ = −dω¹`） |
| `ω⁰` 的显式表达式 | GS (15) 后逐字："Explicit expressions for `ω⁰_{2n+1 Y}` are given in **ref. [9]**" | (2.29) `ω_{2n−1} = n Tr∫₀¹dt A F_t^{n−1}`；(5.7)(5.8) 重述 | ✅ **GS 外包的那个「显式表达式」在 Z-LH 里是 (2.29)/(5.7)** |

> ★ **判定：GS 1984 (5)(6)(15)(16) 不是「大意引用 ref [9]」，而是逐字采用了 Zumino 的约定与符号**，包括 `−⅓A³` 里的 `−⅓`、(6) 的正号、以及 (16) 的那个**负号**。
> ⚠ **但这条判定是在 Z-LH 上核实的，不是在 ZWZ 上核实的**（§0.2）。转节点时：`sources` 可列 `zumino-1983-les-houches`（L1）+ `zumino-wu-zee-1984`（L2，`inferred: true`）。

### 1.3 ★ Z-LH **不涵盖**引力/洛伦兹侧

- Z-LH 全文只处理**内部对称群**（Yang–Mills）的手征反常。**全文没有**自旋联络 `ω`、曲率 `R`、`tr R²`、`ω⁰_{3L}`、引力反常。
- 唯一与引力相关的两处都是**外部引用**：p.38 把 singlet 反常指标公式的「correct formula for the index」归给 `[18] L. Alvarez-Gaumé, Harvard preprint TP-83/A029 (1983)` 与 `[19] D. Friedan and P. Windey, in preparation`；p.37 把指标公式归给 `[17] T. Eguchi, P.B. Gilkey and A.J. Hanson, Physics Reports Vol. 66 p. 213 (1980)`。
- ⇒ **GS (7) `ω⁰_{3L} = tr(ωR − ⅓ω³)` 与 (8) `dω⁰_{3L} = tr R²` 不能溯源到 Zumino**。它们是 GS 把 Z-LH 的 `A → ω, F → R` 直接代换的结果（GS 原文没说这句话，是**抽取者的推断**）。
- ⇒ **GS (4) 里 `−ω⁰_{3L}` 那个负号的来源不在 Zumino，也不在 AGW。** 见 §4 的 Q-Z2。

---

## 2. 陈述

> **等级约定**：**Z1 是 ZWZ 本身（L2）**；**E1–E17 全部出自 Z-LH（LBL-16747），等级 L1（逐页读图）**。
> 扫描件是 JBIG2 打字稿 + **手写公式**，个别系数有读图风险，逐条以 ⚠︎读图 标出。
> 「文献自称的严格程度」栏一律**照抄原文动词**。

### Z1 ZWZ 的方法论自陈（**唯一一条 ZWZ 级陈述**）
- 位置：Nucl. Phys. B239 (1984) 477，摘要
- 等级：**L2**（INSPIRE `abstracts` 字段逐字返回；正文未取到）
- 类型：proposition（元陈述）
- 原文（逐字，分段引用）：作者用微分几何方法确定 `2n` 维时空中的 abelian 与 non-abelian 手征反常，该方法不必计算费曼图，"as has been done by Frampton and Kephart"；其优点是所作构造 "automatically satisfies the Wess-Zumino consistency condition"，而该相容条件 "a condition which has direct physical interpretation"；作者希望该分析 "sheds light on the mathematical structure associated with chiral anomalies"；并声明 "the mathematical analysis is self-contained and a brief review of differential forms and other mathematical tools is included"。
- 文献自称的严格程度：**"automatically satisfies"**（构造性），非 "we prove"
- 备注：★ 这条摘要**独立佐证**了 Z-LH §3–§4 的内容就是 ZWZ 的核心（下降方程构造 ⇒ 自动满足 WZ 相容条件），但**不能**据此把 Z-LH 的任何**式号**转写成 ZWZ 的式号。

---

### E1 Z-LH 的自我定位与对 ZWZ 的引用
- 位置：Z-LH p.2（§1 引言首段）；参考文献 [1][2]（p.45）
- 类型：proposition（元陈述）
- 原文（逐字）：见 §0.2 已全文引用。要点三句：`I follow mostly work done in collaboration with Raymond Stora [1]`；`Some of the results are contained in a recent paper written in collaboration with Wu Yong-Shi and Anthony Zee [2]`；`several crucial formulas have not been given before (at any rate not explicitly) and their physical relevance is emphasized here`。
- 文献自称的严格程度：**"It is possible that the methods and results described in these lectures are fully known in mathematics."**（作者主动降低原创性主张）
- 文献列出的依赖：`[1] R. Stora and B. Zumino, in preparation`；`[2] B. Zumino, Wu Yong-Shi and A. Zee, Univ. of Washington preprint 40048-17 P3, (1983), submitted to Nuclear Physics`
- 备注：⚠ **预印本号在两处不一致** —— Z-LH ref [2] 印作 `40048-17 P3`，INSPIRE 对 ZWZ 记的是 `DOE-ER-40048-18-P3`（**18** 而非 **17**）。可能是 Z-LH 的排印错误、也可能是同系列相邻两号。**引用预印本号时两个都要标不确定。**

### E2 微分形式装置（Yang–Mills 侧）
- 位置：Z-LH p.9，(2.10)–(2.13)
- 类型：definition
- 原文（逐字转录）：
  - (2.10) `A = −i A^k_μ λ_k dx^μ` ——「a matrix of one-forms (i.e. having anticommuting elements)」
  - (2.11) `F = dA + A²` ——「a matrix of two-forms (wedge symbol suppressed, matrix multiplication understood, elements of F commuting)」
  - (2.12) `DF ≡ dF + [A, F] = 0` ——「the Bianchi-identity」
  - (2.13) `d² = 0` ——「and that d anti-commutes with the one-form A」
- 文献自称的严格程度：定义式；(2.12) 称 "It is easy to check that … holds"
- 备注：**与 GS 1984 (2)(3) 完全同一套**，见 §1.2。

### E3 出发点：4 维 singlet 与 non-abelian 反常
- 位置：Z-LH p.7–9，(2.4)(2.5)(2.9)
- 类型：proposition（引用他处的已知结果）
- 原文（逐字转录）：
  - (2.4) `∂^μ J^5_μ = −(1/16π²) ε^{μνρσ} Tr F_{μν}F_{ρσ}`
  - (2.5) `∂^μ J^5_μ = −(1/4π²) ε^{μνρσ} Tr ∂_μ(A_ν∂_ρA_σ + ⅔A_νA_ρA_σ)`
  - (2.9) `D^μ J^H_{μ,i} = η_H (1/24π²) ε^{μνρσ} Tr(λ_i ∂_μ(A^H_ν ∂_ρ A^H_σ + ½ A^H_ν A^H_ρ A^H_σ))`，`H = L, R`，`η_L = −η_R = −1`
- 文献自称的严格程度：**"It is well established [14] that in the one-loop approximation of perturbation theory the classical conservation equation breaks down."** —— 明确标为**微扰论一圈的已知结果**，非本文所证
- 文献列出的依赖：`[14] S. Adler, Phys. Rev. 177, 2426 (1969); W. A. Bardeen, Phys. Rev. 184, 1848 (1969); C. Becchi, Commun. Math. Phys. 33, 259 (1975)`
- 备注：★ **(2.9) 是全文唯一的「绝对归一化锚点」**：§5 的整条归一化论证最后就是要回到它（p.40 逐字："For n = 3, formula (5.13) with (3.38) agrees with (2.9)"）。原文另注 (2.9) 的 `½` 三线性项系数与 (2.5) 的 `⅔` 不同，且逐字说 "the non-abelian anomaly cannot be rewritten in terms of Yang-Mills curls"。

### E4 `Tr F^n` 是闭形式
- 位置：Z-LH p.10、p.12，(2.17)(2.18)(2.27)
- 类型：proposition
- 原文（逐字转录）：
  - (2.17) `d Tr F² = Tr(dFF + FdF) = 2 Tr dF F`
  - (2.18) `d Tr F² = 2 Tr DF F = 0` ——「Adding zero in the form 2Tr[A,F]F we obtain」，「due to the Bianchi identity (2.12)」
  - (2.27) `d Tr F^n = n Tr dF F^{n−1} = n Tr DF F^{n−1} = 0`
- 文献自称的严格程度：给出完整两行推导
- 依赖：E2 的 (2.12)
- 备注：**纯微分几何，无任何物理输入。** 见 §5 的 Lean 候选 C1。

### E5 ★ Chern–Simons 三形式与第一条下降方程
- 位置：Z-LH p.11–12，(2.19)–(2.26)
- 类型：proposition + definition
- 原文（逐字转录）：
  - (2.19) `F = dA + A²`, `δF = dδA + δA A + A δA = D(δA)` ——原文旁注逐字：「(the signs are correct, A being a one-form)」
  - (2.20) `δ Tr F² = 2 Tr δF F = 2 Tr D(δA)F = 2D Tr δA F = 2d Tr δA F`
  - (2.21) `A_t = tA`, `F_t = t dA + t²A² = tF + (t² − t)A²`
  - (2.22) `δ Tr F_t² = 2 d Tr δA_t F_t`
  - (2.24) `Tr F² = 2 d Tr ∫₀¹ δt A(tF + (t² − t)A²) = d Tr(AF − ⅓A³)`
  - (2.25) **`ω₃ = 2∫₀¹ δt Tr A(t dA + t²A) = Tr(A dA + ⅔A³) = Tr(AF − ⅓A³)`**  ⚠︎读图：中间被积式的末项指数（`t²A` vs `t²A²`）字迹不清；由 (2.21) 与两个等号后的结果可确定应为 **`t²A²`**
  - (2.26) **`Tr F² = dω₃`**
- 文献自称的严格程度：**"and have thus verified that"**（(2.26) 前）—— 给出了完整推导
- 依赖：E4
- 备注：★★ **GS 1984 (5) `ω⁰_{3Y} = tr(AF − ⅓A³)` 与 (6) `dω⁰_{3Y} = tr F²` 就是这里的 (2.25) 第三式与 (2.26)，逐字一致、符号一致。**

### E6 一般 Chern–Simons 形式 `ω_{2n−1}`
- 位置：Z-LH p.12，(2.28)–(2.31)
- 类型：definition + proposition
- 原文（逐字转录）：
  - (2.28) **`Tr F^n = dω_{2n−1}`**
  - (2.29) **`ω_{2n−1} = n Tr ∫₀¹ δt A F_t^{n−1}`**
  - (2.30) `ω₅ = 3 Tr[∫₀¹ δt A(t dA + t²A²)²] = Tr(A(dA)² + (3/2)A³dA + (3/5)A⁵)`  ⚠︎读图：末两项的**顺序**在扫描件上难以确定，但两个系数读作 **3/2** 与 **3/5**（与通行的 CS 五形式一致）
  - (2.31) `Tr F³ = dω₅`
- 文献自称的严格程度：**"Analogously one can proceed for higher powers Tr F^n since …"**（把 (2.27) 作为理由）
- 备注：★ **这就是 GS 1984 (15) 后那句 "Explicit expressions for `ω⁰_{2n+1 Y}` are given in ref. [9]" 所指的东西**（标号换算 `n_Z = n_GS + 1`）。(2.29) 后来在 §5 里原样重述为 (5.7)(5.8)。

### E7 同伦算子 `k` 与「只在局部成立」的警告
- 位置：Z-LH p.13–17，(2.32)–(2.54) 及 p.16–17 的两段散文
- 类型：definition + proposition
- 原文（逐字转录，要点）：
  - (2.32) `dk + kd = 1`；(2.33) `k² = 0`, `d² = 0`
  - (2.36) `dA = F − A²`；(2.37) `dF = FA − AF`；(2.38) `d² = 0`（把 `A`、`F` 当作**纯代数对象**）
  - (2.39) `ℓA = 0`；(2.40) `ℓF = δA`；(2.41) `ℓd + dℓ = δ`
  - (2.42) `ℓ_t A_t = 0`, `ℓ_t F_t = δA_t = δt ∂A_t/∂t`；(2.43) `ℓ_t d + d ℓ_t = δ = δt ∂/∂t`
  - (2.44) **`k ≡ ∫₀¹ ℓ_t`**；(2.45) `kd + dk = 1`
  - (2.54) `(kd + dk)(AF) = AF`（一个显式检验例）
- 文献自称的严格程度：(2.32) 引入时逐字 **"Let us suppose for the moment that it exists and check on the known case above what k does."**；`k² = 0` 一句逐字 **"Actually, it is not difficult to show that this is a general fact, when k is defined by means of the family (2.48). We leave the proof as an exercise to the reader."** ⇒ **`k² = 0` 在本文无证明**
- ★ 两条必须随节点一起搬运的限定（逐字）：
  1. p.16 末：**"A word of caution. Equations such as (2.24) and (2.26) are really valid only locally, in some finite neighborhood in x-space. It is however well known that they can be given a global meaning by using a connection on a principal fibre bundle, rather than a vector potential on the base (x-space)."**
  2. p.17 末：**"Finally we emphasize that in defining the operators d, ℓ and k and in studying their properties (from formula (2.36) on) we have treated A and F as purely algebraic objects from which one can form polynomials. No special relations (such as particular commutation relations) have been used and the polynomials were not restricted by any symmetry or invariance property."**
- 备注：★ 第 2 条是**给 Lean 形式化的直接许可**：`d`、`ℓ`、`k` 的代数在自由微分分次代数上成立，不需要流形。★ 第 1 条则是**整条 GS 链的一个被普遍忽略的局部性 gap**（GS 1984 全文没有这句话）。

### E8 有限规范变换下 `ω⁰_{2n−1}` 的变换
- 位置：Z-LH p.18–20，(3.1)–(3.17)
- 类型：proposition
- 原文（逐字转录）：
  - (3.1) **`Tr F^n = dω⁰_{2n−1}`**；(3.2) `ω⁰_{2n−1} = k Tr F^n = n Tr ∫₀¹ δt A F_t^{n−1}`
    原文对上标的说明逐字：「(the additional superscript ⁰ is introduced for later convenience)」
  - (3.3) `A_g = g⁻¹Ag + g⁻¹dg`；(3.4) `F_g = g⁻¹Fg`
  - (3.5) **`ω⁰_{2n−1}(A_g, F_g) = ω⁰_{2n−1}(A, F) + dα_{2n−2} + ω⁰_{2n−1}(g⁻¹dg, 0)`**
  - (3.7) `V ≡ dg g⁻¹`, `dV = V²`
  - (3.8) `Ω ≡ ω(A+V, F) − ω(V, 0) − ω(A, F)`；(3.9) `dΩ = 0`；(3.10) `d(kΩ) = Ω`
  - (3.11) `α_{2n−2} = k(ω⁰_{2n−1}(A+V,F) − ω⁰_{2n−1}(A,F) − ω⁰_{2n−1}(V,0))`；(3.13) `α_{2n−2} = k(ω⁰_{2n−1}(A+V,F))`
  - (3.14) `n = 2`: `α₂ = −Tr(VA)`, `V = dg g⁻¹`
  - (3.16) `ω₃⁰(A_g, F_g) = ω₃⁰(A,F) + dα₂ − (1/3)Tr(g⁻¹dg)³`
  - (3.17) `ω₅⁰(A_g, F_g) = ω₅⁰(A,F) + dα₄ + (1/10)Tr(g⁻¹dg)⁵`
- 文献自称的严格程度：**"This completes the proof of (3.5) if we also use (3.12)"** —— 本文**自称给出了证明**
- ⚠︎读图：**(3.15)（`α₄` 的显式表达式，五项）字迹最差，本记录不转录该式**。需要 `α₄` 显式形式时用附录 (A.16)（见 E17）或直接查原件。
- 备注：(3.16) 的 `−1/3` 与 (3.17) 的 `+1/10` **符号相反**，原文对此的评注逐字：「Equation (3.16) has a well known application to instantons.」

### E9 ★★ 下降方程组（**本轮任务的核心目标**）
- 位置：Z-LH p.21–23，(3.18)–(3.32)
- 类型：proposition
- 原文（逐字转录）：
  - (3.18) `d = dx^μ ∂/∂x^μ`；(3.19) `δ = dt^α ∂/∂t^α`
    原文说明逐字：「(x^μ are coordinates in space-time; t^α any parameters upon which the group elements may depend)」，以及「We shall distinguish the differentiation in direction of x from that in direction of the group and denote the former by d, the latter by δ」
  - (3.20) `A → g⁻¹Ag + g⁻¹dg + g⁻¹δg`；(3.21) `Δ = d + δ`, `Δ² = 0`；(3.22) `d² = δ² = dδ + δd = 0`
  - (3.23) `𝒜 ≡ g⁻¹Ag + g⁻¹dg`；(3.24) `v ≡ g⁻¹δg`
  - (3.25) `δ𝒜 = −dv − v𝒜 − 𝒜v = −Dv`；(3.26) `δv = −v²`
  - (3.27) `ℱ = d𝒜 + 𝒜² = g⁻¹Fg`；(3.28) `ℱ = Δ(𝒜+v) + (𝒜+v)²`
  - (3.29) **`Δ ω⁰_{2n−1}(𝒜+v, ℱ) = d ω⁰_{2n−1}(𝒜, ℱ)`**；(3.30) `Tr ℱ^n = Tr F^n`
  - (3.31) **`ω⁰_{2n−1}(𝒜+v, ℱ) = ω⁰_{2n−1}(𝒜, ℱ) + ω¹_{2n−2} + ⋯ + ω^{2n−1}_0`**
    原文说明逐字：「where the superscript indicates the power of v」
  - (3.32) **下降方程组（逐字，四行）**：
    ```
    δω⁰_{2n−1} + dω¹_{2n−2} = 0
    δω¹_{2n−2} + dω²_{2n−3} = 0
        ⋯
    δω^{2n−2}_1 + dω^{2n−1}_0 = 0
    δω^{2n−1}_0 = 0
    ```
- 文献自称的严格程度：(3.28) 逐字 "as easily verified"；(3.29) 逐字 "This implies that"；(3.32) 逐字 "Equation (3.29) implies a set of relations"
- 依赖：E6、E8
- ★★ **对派工单核心问题的回答**：
  1. **`dω⁰_{2n+1} = tr F^{n+1}` 的符号**：这里是 (3.1) `Tr F^n = dω⁰_{2n−1}`，**正号，无 `2π`、无数值因子**。与 GS (6)(15) **完全一致**。
  2. **`δω⁰ = −dω¹` 的符号**：这里是 (3.32) 第一行 `δω⁰_{2n−1} + dω¹_{2n−2} = 0`，**即 `δω⁰ = −dω¹`**。与 GS (16) `δω⁰_{2n+1 Y} = −dω¹_{2n Y}` **完全一致**。
  3. ⇒ **GS 1984 采用的就是 Zumino 的下降方程符号约定**（在 Z-LH 上 L1 核实；在 ZWZ 上 `inferred`）。
- ⚠ 但见 §4 的 **Q-Z1**：这条**不**足以裁决 `H` 的 Chern–Simons 项符号（GS vs Bilal），因为那是另一个约定层。

### E10 `ω¹_{2n−2}` 的显式公式
- 位置：Z-LH p.23–25，(3.33)–(3.38)
- 类型：proposition
- 原文（逐字转录）：
  - (3.33) `ω⁰_{2n−1}(𝒜+v, ℱ) = n∫₀¹ δt Str((𝒜+v) ℱ̂_t^{n−1})`
  - (3.34) `ℱ̂_t = tℱ + (t²−t)(𝒜+v)² = ℱ_t + (t²−t){𝒜, v} + (t²−t)v²`
  - (3.35) `Str(B₂, B₃, …, B_n) = Σ_{Perm} (1/n!) Tr(B_{π(2)} ⋯ B_{π(n)})` ——「It is convenient to replace the trace by the symmetrized trace」
  - (3.36) `ω¹_{2n−2} = (n−1)∫₀¹ δt(1−t) Str(v d(𝒜 ℱ_t^{n−2}))`  ⚠︎读图：**前置因子与末项指数不可靠**（`(n−1)` 前是否另有 `n`、指数 `n−2` vs `n−1` 均无法判读）。**该式不得单独转写进图**；用下面两条显式特例代替
  - (3.37) `n = 2`: **`ω¹₂ = Tr(v dA)`**
  - (3.38) `n = 3`: **`ω¹₄ = Tr(v d(A dA + ½A³))`**
- 文献自称的严格程度：给出了完整的分部积分推导（p.24）
- 备注：★ 原文对 (3.36) 的评价逐字：**"Equation (3.36) is very convenient because it exhibits the anomaly in the canonical form in which the differential operates on a function of 𝒜 and ℱ, while v is not differentiated. Equation (3.38) agrees with (2.16)."**
  ⇒ **(3.38) ↔ (2.16) 是原文自己给出的、跨方法的一致性检查**（微分几何构造 vs 一圈微扰论结果）。这是本文最有价值的可机检交叉点之一，但**本抽取者未复算**（需要形式↔散度的字典，见 §4 Q-Z4）。

### E11 Wess–Zumino 相容条件与 BRS 结构
- 位置：Z-LH p.26–28，(4.1)–(4.17)
- 类型：proposition
- 原文（逐字转录）：
  - (4.1) `X_i(x) = −∂_μ δ/δA^i_μ − (A_μ × δ/δA_μ)_i`（规范变换的泛函表示）
  - (4.2) `[X_i(x), X_j(y)] = f_{ij}^k X_k(x) δ(x−y)`
  - (4.3) `X_i(x) W[A] = G_i[A](x)` ——「(G_i = 0 would correspond to the conservation of the respective currents)」
  - (4.4) **`X_i(x)G_j(y) − X_j(y)G_i(x) = f_{ij}^k G_k(x) δ(x−y)`** ——**这就是 Wess–Zumino 相容条件**
  - (4.6) `v·X = Σ_i ∫dx v_i(x)X_i(x)`, `v·G = Σ_i ∫dx v_i(x)G_i(x)`（`v_i` 是**反交换标量**，逐字「anti-commuting scalar fields (Faddeev-Popov fields)」）
  - (4.7) `v·X v·G − ½(v×v)·G = 0`
  - (4.8) `δA_μ = v·X A_μ`；(4.9) `δv_i = −½(v×v)_i`
  - (4.10) **`δ(v·G) = 0`**；(4.11) `δ² = 0`
  - (4.14) `δ𝒜 = −dv − v𝒜 − 𝒜v ≡ −Dv`；(4.15) `δv = −v²`
  - (4.17) `δ Tr v·G[A](x) = dχ`
- 文献自称的严格程度：(4.4) 逐字 **"the mere existence of the functional W[A], which we suppose to be obtained by appropriate renormalization, implies a consistency condition"**；(4.11) 逐字 **"Exercise: check (4.11)"** ⇒ **未证**
- ★ 原文的关键判定句（逐字，p.28）：**"It should be clear that (4.8), (4.9) are nothing but the BRS-transformations and (4.10) the Slavnov identity for the special case of currents."**
- ★ 反常的**定义**（逐字，p.27）：**"The anomalies (2.9) arise as solutions of (4.4) which are not variations of a local functional in the basic fields of the theory. This feature we take as definition for the general case: any solution of (4.4) which is not a variation of a local functional in the basic fields (φ, A_μ) we regard as anomaly."**
- 备注：★ (4.14)(4.15) 与 (3.25)(3.26) **逐字相同** —— 这是原文明说的桥（p.29 逐字："Hence the δ defined in (4.14), (4.15) and the d in (4.17) fulfill the algebra (3.25) (3.26) and will be identified with those operators."）。⇒ **「下降方程的 δ」= 「BRS 算子」是本文的一条显式认同，不是后人的重排。**

### E12 ★ `ω¹_{2n−2}` 就是相容反常
- 位置：Z-LH p.29，(4.18) 及其前后
- 类型：proposition
- 原文（逐字转录）：
  - (4.18) **`δω¹_{2n−2} = d(−ω²_{2n−3})`**
  - 原文随即**重排出一个四行的方程组**（p.29，逐字，与 (3.32) 同内容的另一次书写）：
    ```
    Tr F^n = dω⁰_{2n−1}
    δ Tr F^n = 0
    δω⁰_{2n−1} + dω¹_{2n−2} = 0
    δω¹_{2n−2} + dω²_{2n−3} = 0
    ```
  - 结论句逐字：**"We see that ω¹_{2n−2} is linear in v and satisfies the consistency condition."**
- 文献自称的严格程度：**"What remains to be shown is thus only that (4.17) can be identified with"** + 给出验证
- ★ 原文主动声明的 gap（逐字，p.29）：**"The problem of finding the most general solution of the consistency condition will not be discussed here."**
  ⇒ **唯一性不在本文。** 转节点时这是一条必须显式保留的 gap（GS 1984 (11) 后那句 "The anomalies corresponding to diagrams with more than six external lines are uniquely determined by the hexagon diagrams. Their form can be deduced by implementing the Wess–Zumino consistency conditions [8]" **依赖的正是这个未讨论的唯一性**）。
- 备注：★★ **这是 Z1 摘要里 "automatically satisfies the Wess-Zumino consistency condition" 那句话的技术内容**：因为 `ω¹` 是从 (3.32) 的下降链里出来的，(4.18) 自动成立。

### E13 反常的量子化条件
- 位置：Z-LH p.35–36，(4.47)–(4.49) 及末句
- 类型：proposition
- 原文（逐字转录）：
  - (4.48) `d Tr V^{2n−1} = (2n−1) Tr V^{2n} = 0`，`V = dg g⁻¹`, `dV = V²`
  - (4.49) **`∫_{C₅} Tr(g⁻¹dg)⁵ ≠ 0`** ——「For a group (like SU(3)) with a nontrivial Π₅, there exist 5-cycles C₅ such that the integral … does not vanish; suitably normalized (see below) it equals an integer.」
  - p.36 全页只有一句（逐字）：**"the effective action, as mentioned in the Introduction. The normalization to be chosen is 2π times that which gives an integer for (4.49)."**
- 文献自称的严格程度：陈述式；"This fact leads to a quantisation of …"
- ★ 备注：**这是 §5 绝对归一化论证的「另一半」** —— §5 用指标定理定 singlet 反常的归一，再用本条的整数性把它传给 non-abelian 反常。见 E15/E16。

### E14 ★ 归一化 I：指标定理给出 singlet 反常的绝对归一
- 位置：Z-LH p.37–38，§5 开头 + (5.1)–(5.5)
- 类型：proposition
- 原文（逐字转录）：
  - 节首句（逐字）：**"The normalization of anomalies of the form TrF^n, which enters in the abelian anomaly (2.5), (2.15) can be related to the formula for the index of the Dirac operator. This gives the correctly normalized abelian (or singlet) anomaly in 2n dimensions. The connection between it and the non-abelian anomaly in 2n−2 dimensions permits then to find that normalization also. So both normalizations can be determined completely from purely geometric arguments."**
  - (5.1) `∂^μ J^5_{μ,reg} = C(x) − Σ_{zero modes} φ_a^† γ₅ φ_a`
  - (5.2) `∫C(x)dx = 2Σφ^†γ₅φ = 2(n₊ − n₋)`
  - (5.3) `ch(V) = Tr e^{(i/2π)F}`
  - (5.4) `n₊ − n₋ = ∫ (1/n!)((i/2π))^n Tr F^n` ——「More precisely, in 2n dimensions」
  - (5.5) `C(x) = (2/n!)(i^n/((2π)^n 2^n)) Tr F_{μ₁μ₂}F_{μ₃μ₄}⋯F_{μ_{2n−1}μ_{2n}} ε^{μ₁μ₂⋯μ_{2n}}`  ⚠︎读图：分母的 `(2π)^n 2^n` 与指数排布字迹不清
- 文献自称的严格程度：**"Now it is known (see e.g. Ref. [17], Eq. (7.22)) that the index is given by the integral of the Chern character"** —— **指标定理是外部输入，本文不证**
- 文献列出的依赖：`[17] T. Eguchi, P.B. Gilkey and A.J. Hanson, Physics Reports Vol. 66 p. 213 (1980)`（**= AGW ref [6]，本项目 `reading-list.md` 已列 P1**）；正确的指标公式归给 `[18] L. Alvarez-Gaumé, Harvard preprint TP-83/A029 (1983)` 与 `[19] D. Friedan and P. Windey, in preparation`
- 备注：原文对 (5.5) 的限定逐字：**"This requires, of course, that one knows somehow the correct formula for the index. A nice derivation (for physicists) based on quantum mechanical supersymmetry, has been given recently by Alvarez-Gaumé [18] and by Friedan and Windey [19]."**

### E15 ★★ 归一化 II：non-abelian 反常的绝对归一（**GS 常数 `c` 的真正落点**）
- 位置：Z-LH p.38–40，(5.6)–(5.13)
- 类型：proposition
- 原文（逐字转录）：
  - (5.6) `Tr F^n = dω_{2n−1}(A, F)`；(5.7) `ω_{2n−1}(A,F) = n∫₀¹ dt Tr A F_t^{n−1}`；(5.8) `F_t = tF + (t²−t)A²`
  - (5.9) `ω_{2n−1}(V, 0) = n∫₀¹ δt (t²−t)^{n−1} Tr V^{2n−1}`
  - (5.10) `n∫₀¹ δt (t²−t)^{n−1} = (−1)^{n−1} (n−1)! n! / (2n−1)!`  ⚠︎读图：分子首个阶乘读作 `(m−1)!`，判为 **`(n−1)!`** 的排印/扫描讹误（由 (5.11) 的化简结果反推确定）
  - (5.11) `(1/n!)(i/2π)^n (−1)^{n−1} (n−1)! n!/(2n−1)! = (−1)^{n−1}(i/2π)^n (n−1)!/(2n−1)!`
  - (5.12) `(i/2π)^n ((n−1)!/(2n−1)!) Tr V^{2n−1}`，`V = dg g⁻¹` ——「also integrates to an integer, the integral being performed over a (2n−1)-cycle in group space (see [20])」
  - (5.13) **`(1/n!) (i^n/(4π)^{n−1}) ω¹_{2n−2}`**  ⚠︎⚠︎读图：**分母的指数 `n−1` 与 `4π` 的底数存在读图风险**，且原文在该式**正上方有一处手写插注**（逐字）：**"(up to a sign)"**
  - 引导句（逐字）：**"This means that the non-abelian anomaly in 2n−2 dimensions is given by (up to a sign) [(5.13)] with ω¹_{2n−2} given by the expansion (3.31). For n = 3, formula (5.13) with (3.38) agrees with (2.9)."**
- 文献自称的严格程度：★ 原文对整个论证的自我评价（逐字，p.38）：**"In order to determine the normalization of the non-abelian anomaly, we shall proceed as follows. Since the non-abelian anomaly determines the phenomenological Lagrangian (see Sect. 4), we shall require that it be normalized so that the Lagrangian satisfies the quantization condition. As we shall see, the normalization of the non-abelian anomaly is then related directly to that of the index formula, without the extra factor 2 necessary for the singlet anomaly. Of course this procedure is, in a sense, like going backwards, and the normalization of the non-abelian anomaly can be computed directly in perturbation theory. What we are saying is that the perturbation theory result agrees with the correct normalization for the phenomenological Lagrangian, as required by geometric considerations."**
- ★★ **对派工单「常数 `c` 的归属」的回答**：
  1. **Z-LH §5 就是「反常的绝对归一化」那一节**，其结论是 (5.13)：`2n−2` 维 non-abelian 反常 = `(1/n!)(i^n/(4π)^{n−1}) ω¹_{2n−2}`（⚠︎读图 + 原文自注 "up to a sign"）。
  2. **但 (5.13) 里没有、也不可能有 GS 的那个 `c`。** GS (17) 的 `c` 是**十维**（`2n−2 = 10 ⇒ n = 6`）、**且已经把引力侧一并归一**之后的一个数；Z-LH 全文不含引力侧（§1.3）。
  3. ⇒ **`c` 的归属裁定：`c` 不在 ZWZ/Z-LH 里，也不在 AGW 里（`alvarez-gaume-witten-1984.md` Q-A1 已定）。GS 说的 "can be deduced from refs. [3,9]" 是准确的措辞 —— 两篇各提供一半（AGW (63) 给相对归一，ZWZ/Z-LH §5 给绝对归一与下降形式的归一），合成那一步是 GS 自己做的，且 GS 未给中间步骤，三篇文献里都不存在这个数。**
  4. ⚠ **额外的坏消息**：即便取到 ZWZ 正文，`c` 也**未必**能闭合成一个「查得到的数」—— 因为源头 (5.13) 本身带作者手写的 "up to a sign"，且是 `2n−2` 维通式而非十维特例。

### E16 附录：`α_{2n−2}` 的简单公式
- 位置：Z-LH p.41–44（APPENDIX: A SIMPLE FORMULA FOR α_{2n−2}），(A.1)–(A.18)
- 类型：proposition
- 原文（逐字转录，要点）：
  - 节首句逐字：**"It is often useful to have a simple explicit formula, (A.16) below, for the differential form α_{2n−2} occurring in Eqs. (3.5), (3.14) to (3.17). The formulas (3.11) or (3.13) are sufficient, but they still require some work to evaluate α_{2n−2}."**
  - (A.1) `𝒜_{λ,μ} = λA − μV`；(A.2) `V = dg g⁻¹`, `dV = V²`；(A.3) `ℱ_{λ,μ} = d𝒜_{λ,μ} + 𝒜²_{λ,μ}`
  - (A.11) `ω_{2n−1}(A+V, F) − ω_{2n−1}(A, F) − ω_{2n−1}(V, 0)`
  - (A.16) **`α_{2n−2} = −n(n−1)∫∫ Str(VA ℱ_{λ,μ}^{n−2})`**
  - (A.17) `∫∫ = ∫₀¹δλ ∫₀^{1−λ}δμ`（「as a two dimensional integral over the interior of the triangle」）
  - (A.18) `∫₀¹δλ ∫₀^{1−λ}δμ λ^h μ^k = h! k!/(h+k+2)!`
- 文献自称的严格程度：给出完整的 Stokes 定理推导（p.42–44）；末句逐字 **"As an exercise, the reader may check that (A.16) agrees with (3.14) (obvious) and (3.15) and then go on to the next case n = 4."**
- 备注：★ (A.18) 是一条**纯组合恒等式**，完全可机检（见 §5 的 Lean 候选 C3）。

### E17 参考文献结构（用于溯源）
- 位置：Z-LH p.45–46，`[0]`–`[20]` + Added Note
- 类型：（元信息）
- 原文（逐字转录，关键条目）：
  - `[0]`（逐字）："Standard mathematical references for the subject of these lectures are:" — M. Flanders, *Differential Forms with Applications to Physical Sciences*, Academic Press, New York (1963); S. S. Chern, *Complex Manifolds without Potential Theory* (especially the Appendix: Geometry of Characteristic Classes) Springer, New York (1979); S. Kobayashi, K. Nomizu, *Foundations of Differential Geometry*, Interscience, New York (1969); Y. Choquet-Bruhat, C. DeWitt-Morette, M. Dillard-Bleick, *Analysis, Manifolds and Physics*, North-Holland, Amsterdam (1978)
  - `[1]` R. Stora and B. Zumino, in preparation
  - `[2]` B. Zumino, Wu Yong-Shi and A. Zee, Univ. of Washington preprint 40048-17 P3, (1983), submitted to Nuclear Physics
  - `[14]` S. Adler, Phys. Rev. **177**, 2426 (1969); W. A. Bardeen, Phys. Rev. **184**, 1848 (1969); C. Becchi, Commun. Math. Phys. **33**, 259 (1975)
  - `[15]` J. Wess and B. Zumino, Phys. Lett. **37B**, 95 (1971)  ← **= GS 1984 ref [8]**
  - `[17]` T. Eguchi, P. B. Gilkey and A. J. Hanson, Physics Reports, Vol. **66** p. 213 (1980)  ← **= AGW ref [6]**
  - `[18]` L. Alvarez-Gaumé, Harvard preprint TP-83/A029 (1983)
  - `[19]` D. Friedan and P. Windey, in preparation
  - `[20]` R. Bott and R. Seeley, Commun. Math. Phys. **62**, 235 (1978)
  - **Added Note**（逐字）："A very interesting (and rather mathematical) paper relevant to the subject of these lectures is: I. Bonora and P. Cotta-Ramusino, Commun. Math. Phys. **87**, 589 (1983); See also I. Bonora, P. Cotta-Ramusino and C. Reina, Phys. Lett. **126B**, 305 (1983)."
- ★ 备注：**`[1] R. Stora and B. Zumino, in preparation` 是全文第一句就点名的主要依据，却从未发表成形**（通行的替代是 Stora 的 Cargèse 1983 讲义 = **GS 1984 ref [10] 的一半**，以及 Mañes–Stora–Zumino, Commun. Math. Phys. **102** (1985) 157）。
  ⇒ **下降方程的「原始出处」在文献学上是分叉的**：Stora 侧（未刊 → Cargèse 讲义 → MSZ 1985）与 Zumino 侧（ZWZ 1984 / Z-LH 1983）。GS 1984 同时引了两侧（ref [9] = ZWZ，ref [10] = Zumino Les Houches 1983 + Stora Cargèse 1983）。
  ⚠ **注意**：**GS ref [10] 的「Zumino Les Houches 1983」就是本记录的 Z-LH**。⇒ **本轮取到的文献不是 GS ref [9]，而是 GS ref [10] 的第一项。** 这是一个意外的好消息：GS 引的两条 Zumino 参考里，我们取到了其中一条的全文。

---

## 3. 未核实项与读图存疑

### 3.1 ★ ZWZ 本身：全部为 L2 / L0

| 项 | 等级 | 说明 |
|---|---|---|
| 作者、题名、卷期页、DOI、收稿信息 | **L2** | INSPIRE recid 194780 + Crossref DOI `10.1016/0550-3213(84)90259-1`。页码 **477–507（31 页）** |
| 报告号 `LBL-16443` / `DOE-ER-40048-18-P3` | **L2** | INSPIRE `report_numbers`。⚠ 与 Z-LH ref [2] 印的 `40048-17 P3` **冲突**（见 E1 备注 / Q-Z5） |
| 摘要 | **L2** | 逐字，见 Z1 |
| **正文的一切**：式号、符号约定、下降方程的具体写法、`c` 的归一化 | **L0** | **一字未取到。** 本记录 §2 的 E1–E17 **全部是 Z-LH，不是 ZWZ** |

> ⚠️ **红线**：**任何形如「ZWZ eq. (X)」的引用都不得出现在图里。** 本项目目前没有 ZWZ 的任何式号。
> 若 curator 需要给 GS ref [9] 建来源指针，只能用「ZWZ 全文，无式号」的粒度，或改指 Z-LH 的式号并标 `inferred`。

### 3.2 Z-LH 的读图存疑（逐条）

| 位置 | 读到的样子 | 判定 |
|---|---|---|
| (2.25) 中间被积式 | `2∫₀¹δt Tr A(t dA + t²A)` | **判为 `t²A²`**（由 (2.21) 的 `F_t = t dA + t²A²` 与后两个等号的结果反推）。**结论式 `Tr(AF − ⅓A³)` 本身清晰无疑** |
| (2.30) `ω₅` 末两项 | 顺序不可判 | 两个**系数** `3/2`（`A³dA`）与 `3/5`（`A⁵`）读数明确，与通行 CS 五形式一致 |
| **(3.15) `α₄` 的显式五项式** | 字迹最差 | **本记录不转录。** 需要时用 (A.16) 或查原件 |
| **(3.36) `ω¹_{2n−2}` 的积分公式** | `(n−1)∫₀¹δt(1−t)Str(v d(𝒜ℱ_t^{n−2}))` | **前置因子与末项指数均不可靠，不得单独入图。** 用 (3.37)(3.38) 两个显式特例代替（两者清晰） |
| (5.5) 分母 | `(2π)^n 2^n` 与指数排布不清 | 标 ⚠︎；不作为定量来源 |
| (5.10) 分子首个阶乘 | 读作 `(m−1)!` | **判为 `(n−1)!` 的讹误**（由 (5.11) 化简后的 `(n−1)!/(2n−1)!` 反推确定）。⇒ **这是一次「同篇内两条路线互除」的成功校验**，方法与 `alvarez-gaume-witten-1984.md` 定 (101) 的 `11/21` 同 |
| **(5.13) 的 `(4π)^{n−1}`** | 底数与指数均有风险 | ⚠︎⚠︎ **最重要的一条存疑**，因为它就是绝对归一化的结论式。已单页重渲染复核一次，读数不变，但清晰度不足以定案。**不得作为定量来源入图** |
| (2.14) 形式↔散度的字典 | 部分模糊 | 不转录 |

### 3.3 本记录**未做**的事（避免后续误以为已做）

- **未复算 (3.38) ↔ (2.16) 的一致性**（原文自称 "agrees"）。需要先固定 (2.14) 的形式↔散度字典与 `λ` 归一，本轮判为超出抽取范围。见 Q-Z4。
- **未复算 (5.13) + (3.38) ↔ (2.9)**（原文自称 "agrees"）。同上，且 (5.13) 读图不可靠、原文自带 "up to a sign"。
- **未核对 Z-LH 与 ZWZ 的式子对应关系**（无法核对，ZWZ 正文未取到）。
- **未获取** Stora–Zumino "in preparation"（[1]）、Stora Cargèse 1983（GS ref [10] 的第二项）、Mañes–Stora–Zumino CMP 102 (1985) 157。

---

## 4. 未解决的疑问（留给 curator / auditor）

### Q-Z1 ★★ `H` 的 Chern–Simons 符号：**GS 与 Bilal 谁对？—— 裁定「都对，是两套约定」**

这是派工单的核心问题。分三层回答，**前两层已定，第三层待补一个数**。

**第一层（已定，L1）：下降方程层，GS = Zumino，无冲突。**
- Zumino (3.1) `Tr F^n = dω⁰_{2n−1}`（正号）↔ GS (6)(15)（正号）✓
- Zumino (3.32) `δω⁰_{2n−1} + dω¹_{2n−2} = 0`，即 `δω⁰ = −dω¹` ↔ GS (16) `δω⁰_{2n+1 Y} = −dω¹_{2n Y}` ✓
- Zumino (2.25) `ω₃ = Tr(AF − ⅓A³)` ↔ GS (5) `ω⁰_{3Y} = tr(AF − ⅓A³)` ✓（连 `−⅓` 都一样）
⇒ **`green-schwarz-1984.md` Q6 里「符号约定源头」那一半，至此在 Z-LH 上闭合。**

**第二层（已定）：但这**不能**裁决 `H` 的符号，因为那是**另一个约定层**。**
- **Z-LH 全文没有 `B` 场、没有 `H`、没有引力**（§1.3）。下降方程只约束 `ω₃` 自身的定义与 `δω₃` 的符号，**完全不约束 `H = dB ± ω₃` 里的那个 `±`**。
- 那个 `±` 是由**另外三样东西联合固定**的：(i) `B` 的规范变换约定（GS (9c) `δB = −tr(AdΛ) + tr(ωdΘ)`）；(ii) 要求 `δH = 0`（GS (10c)）；(iii) `B` 的整体符号约定（可自由重定义）。
⇒ **不要**把 `H` 的符号挂在 `zumino-wu-zee-1984` 上。

**第三层（结论 + 一个待补的数）：GS 与 Bilal 之间是一次纯场重定义。**
- GS (4)：`H = dB + ω⁰_{3Y} − ω⁰_{3L}`
- Bilal (12.14)：`H = dB − Q₃^{YM} + β̃ Q₃^{L}`
- 作 `(B, H) → (−B, −H)`（对 `B` 的整体符号重定义，物理内容不变），GS (4) 逐项映为 `H = dB − ω⁰_{3Y} + ω⁰_{3L}`，**这正是 Bilal (12.14) 在 `β̃ = +1` 时的形式**。
- ⇒ **若 `β̃ = +1`，两者是同一约定的两种写法，「谁对」是伪问题**；物理不变量是**两个 CS 项的相对符号**（GS 与 Bilal 都取相反号）。
- ⚠ **待补**：`green-schwarz-1984.md` §1.2 记下了 Bilal (12.14) 的形式，但**没有记 `β̃` 的取值**。**若 `β̃ ≠ +1`（例如 `−1` 或某个归一化因子），上面的结论要重判。** 这是一次**低成本**的补课（重读 Bilal arXiv:0802.0634 §12 的 (12.14) 附近一句）。
- ⚠ 另注：派工单文本里写的 `H = dB − ω_{3Y} + ω_{3L}` 与 Bilal 同号、与 GS 原文反号 —— 按本裁定，**它也不算错，但与 GS 原文不是同一个 `B`**。

### Q-Z2 ★ GS (4) 里 `−ω⁰_{3L}` 那个负号的来源：**不在 Zumino，不在 AGW，就在 GS 1984 自己**

- **不在 Zumino**：Z-LH 全文只做内部对称群，**没有自旋联络 `ω`、没有 `R`、没有 `tr R²`、没有 `ω⁰_{3L}`**（§1.3，L1 通读确认）。
- **不在 AGW**：AGW 全文没有下降方程（`alvarez-gaume-witten-1984.md` §8.4，L1 确认）。
- **不在 GS ref [7]**：GS 自己逐字说 **"The last term in eq. (4) is a higher-derivative term arising in the low-energy expansion of the superstring and therefore does not appear in ref. [7]."**（`green-schwarz-1984.md` E4）⇒ 洛伦兹 CS 项是 **GS 本文新加的**。
- ⇒ **裁定：`−ω⁰_{3L}` 的符号是 GS 1984 自己的约定选择**，与 (9c) 的 `+tr(ωdΘ)` 联合固定，GS 对其自洽性只给了一句 "It follows from eq. (10) that the terms in eq. (1) are invariant"（`green-schwarz-1984.md` E5，**无计算**）。
- **给 curator**：`conv.h-chern-simons-sign` 的 canonical source 应是 **`green-schwarz-1984` (4)+(9c)**，**不是** `zumino-wu-zee-1984`。而 `ω⁰_{3L} = tr(ωR − ⅓ω³)`、`dω⁰_{3L} = tr R²`（GS (7)(8)）是把 Zumino 的 `A → ω, F → R` 直接代换 —— **GS 原文没说这句话，这是抽取者的推断，转边时须 `inferred: true`**。

### Q-Z3 ★ 常数 `c` 的归属：**三篇文献里都没有这个数（本轮定案）**

- AGW：**没有**（`alvarez-gaume-witten-1984.md` Q-A1：AGW (114) 逐字 "apart from a factor common to the three cases"，从不固定整体归一）。
- ZWZ：**正文未取到**，但由其伴随文献 Z-LH 的 §5 可知，Zumino 侧给出的是 **`2n−2` 维的通式 (5.13)**，且原文自注 **"(up to a sign)"**；**不含引力侧**，因此不可能含 GS 那个已把引力一并归一的十维常数。
- GS：逐字 "The numerical constant `c` **can be deduced from** refs. [3,9]" —— **"deduced from" 而非 "given in"，措辞准确。**
- ⇒ **裁定**：`c` 是 **GS 自己合成的一步**，中间步骤在三篇原始文献里都不存在。
  **建议**：涉及 `c` 的节点（GS E10/E13 一族）status **`physical-argument`**，`sources` 列 `alvarez-gaume-witten-1984`（(63)，相对归一）+ `zumino-1983-les-houches`（§5，绝对归一）+ `green-schwarz-1984`（(17)，合成结果），并在 note 写明「**三篇都不给出 `c` 的数值；GS 未给中间步骤；本项目未复算**」。
  ⚠ **不要**在 `reading-list.md` 里继续写「抽了 ZWZ，`c` 才有可能定出来」—— **本轮的证据表明，即使取到 ZWZ 正文，`c` 大概率仍不会以一个数的形式出现。** 该预期应下调。

### Q-Z4 两条「原文自称一致、本项目未复算」的交叉检查
1. **(3.38) `ω¹₄ = Tr(v d(AdA + ½A³))` ↔ (2.16) `(D*J^s)_i ∝ d Tr λ_i(AdA + ½A³)`**（原文逐字 "Equation (3.38) agrees with (2.16)"）。
2. **(5.13) + (3.38) ↔ (2.9)**（原文逐字 "For n = 3, formula (5.13) with (3.38) agrees with (2.9)"）。
- 这两条是**「微分几何构造」与「一圈微扰论」之间仅有的两处定量对接**，是整条 ZWZ→GS 归一化链的信度基础。
- **本项目未复算**（需先固定 (2.14) 的形式↔散度字典、`λ` 的厄米/反厄米换算、以及 (5.13) 的读图不确定性）。
- **建议**：建一条显式 gap，**不要**静默把「Zumino 的归一化是对的」当成已核实事实。

### Q-Z5 预印本号 `17` vs `18` 的冲突
- Z-LH ref [2]（L1，逐字）：`Univ. of Washington preprint 40048-17 P3, (1983)`
- INSPIRE ZWZ `report_numbers`（L2）：`DOE-ER-40048-18-P3`（另有 `LBL-16443`）
- **未裁决。** 可能是 Z-LH 排印错误、扫描讹误，或同系列相邻两号。**登记 bib 时两个都记，标不确定。**

### Q-Z6 ★ 局部性 gap（**GS 链上一条从未被记录的限定**）
- Z-LH p.16 逐字："**Equations such as (2.24) and (2.26) are really valid only locally, in some finite neighborhood in x-space.** It is however well known that they can be given a global meaning by using a connection on a principal fibre bundle, rather than a vector potential on the base (x-space)."
- **GS 1984 全文没有这句话**；GS 直接在整个十维时空上写 (4)–(8)、(14)–(16)。
- **建议**：在 `math.chern-simons-descent-equations` 或其下游建一条显式 note/gap。这是本轮的**新发现**，此前 `green-schwarz-1984.md` 与 `alvarez-gaume-witten-1984.md` 都没有捕捉到。

### Q-Z7 ★ WZ 相容条件解的**唯一性**在本文明确未讨论
- Z-LH p.29 逐字：「**The problem of finding the most general solution of the consistency condition will not be discussed here.**」
- 但 GS 1984 (11) 前逐字依赖的正是唯一性：「The anomalies corresponding to diagrams with more than six external lines are **uniquely determined** by the hexagon diagrams. Their form **can be deduced by implementing the Wess–Zumino consistency conditions** [8]」（`green-schwarz-1984.md` E6）。
- ⇒ **GS 的「唯一确定」在 Zumino 侧没有支撑**。真正的唯一性（相容反常的上同调分类）属于后来的 **Mañes–Stora–Zumino, CMP 102 (1985) 157** 一线。
- **建议**：GS E6 对应的节点须建 `inferred: true` 的边或显式 gap，**不要**把「唯一性」当作 ZWZ/Z-LH 提供的内容。

### Q-Z8 下降方程原始出处的**文献学分叉**
- Z-LH 开篇逐字把主要功劳给 `[1] R. Stora and B. Zumino, in preparation` —— **该文从未以此形式发表**。
- GS 1984 同时引了两侧：ref [9] = ZWZ（Nucl. Phys. B239），ref [10] = **Zumino Les Houches 1983（= 本记录 Z-LH）+ Stora Cargèse 1983**。
- ⇒ **「下降方程的 canonical 一手来源」不是单一文献。** 建议图里用 `zumino-1983-les-houches`（L1，本项目已有全文）作主来源，`zumino-wu-zee-1984` 作并列来源（`inferred`），并在 note 里记 Stora 一线。

---

## 5. 给 curator 的图建议

> researcher 不写 `graph/`。本节全部是**建议**，由 curator/auditor 裁定。

### 5.1 `math.chern-simons-descent-equations`（定义卡）—— **建议可标 `rigorous`，但理由不能只写 Z-LH**

**建议的卡片内容**（纯微分几何，无物理输入）：
> 设 `A` 是取值于李代数的矩阵一形式，`F = dA + A²`，`Tr` 为不变迹。则
> (i) `d Tr F^n = 0`；
> (ii) 存在 `ω⁰_{2n−1} = n Tr∫₀¹δt A F_t^{n−1}`（`F_t = tF + (t²−t)A²`）使 **`Tr F^n = dω⁰_{2n−1}`**；
> (iii) 在 `Δ = d + δ`、`𝒜 = g⁻¹Ag + g⁻¹dg`、`v = g⁻¹δg` 下，`ω⁰_{2n−1}(𝒜+v, ℱ)` 按 `v` 的幂次展开 `= ω⁰_{2n−1} + ω¹_{2n−2} + ⋯ + ω^{2n−1}_0`，且满足**下降方程组**
> **`δω^p_{2n−1−p} + dω^{p+1}_{2n−2−p} = 0`（`p = 0,…,2n−2`），`δω^{2n−1}_0 = 0`**。

- `sources`：
  - `zumino-1983-les-houches`，loc `eq. (2.28)-(2.29), (3.1)-(3.2), (3.29), (3.31)-(3.32)`，**L1**，`inferred: false`
  - `zumino-wu-zee-1984`，loc `全文（无式号）`，**L2**，**`inferred: true`** + note「ZWZ 正文本项目未取到；本卡内容取自同作者同期伴随文献 Z-LH，两者关系有 Z-LH 引言的自陈为据（见抽取记录 §0.2）」
- **状态建议**：`rigorous`，**但有两个必须写进 note 的限定**：
  1. Z-LH 自己把 **`k² = 0` 留作 "exercise to the reader"**（E7），**本文无证明**；
  2. Z-LH 自己声明 (2.24)(2.26) **"really valid only locally"**（Q-Z6），全局版需要主丛联络。
- ⇒ **建议 curator 顺手加一条数学侧 canonical 来源**把这两个限定补掉。Z-LH 自己的 ref `[0]` 就给了现成的候选：**Chern, *Complex Manifolds without Potential Theory*（Appendix: Geometry of Characteristic Classes）**、**Kobayashi–Nomizu**。这比让 `rigorous` 单靠一份 1983 年的讲义扫描件稳。
- **可否升 `rigorous`：可以**（Chern–Weil transgression 是标准数学定理），**但不要以「Z-LH 给了完整推导」为理由**，理由应写「纯微分几何 + 有独立数学文献」。

### 5.2 建议**拆开**的两张卡（不要合并）

| 卡 | 内容 | 建议状态 | 理由 |
|---|---|---|---|
| `math.chern-simons-descent-equations` | 上面 (i)(ii)(iii)，**纯代数/微分几何** | `rigorous` | 无物理输入 |
| `consistency.anomaly-is-omega-1`（新） | 「`ω¹_{2n−2}` 就是相容规范反常」 | **`physical-argument`** | 依赖 (4.3) 的 `W[A]` "obtained by appropriate renormalization"（E11）、(4.11) 留作 exercise、以及 **Q-Z7 的唯一性未讨论** |

**不要**把这两条合成一张卡 —— 前者是定理，后者是物理识别。这是本轮最重要的一条结构建议。

### 5.3 引力侧的边：**一律 `inferred: true`**

- `worldsheet/consistency` 区里凡涉及 `ω⁰_{3L} = tr(ωR − ⅓ω³)`、`dω⁰_{3L} = tr R²` 的节点：
  - **不得**把 `zumino-wu-zee-1984` 或 `zumino-1983-les-houches` 列为来源（Z-LH 无引力侧，L1 通读确认，§1.3）。
  - canonical source 用 **`green-schwarz-1984` (7)(8)**；
  - 「由 YM 侧的 `A → ω, F → R` 代换得到」这条边标 **`inferred: true`**，note 写「GS 原文未陈述该代换，Zumino 侧不含引力」。
- 引力反常的**数值**侧仍走 `alvarez-gaume-witten-1984`（(63)/(119)/(83)），与本轮无关。

### 5.4 `conv.h-chern-simons-sign`（约定族）—— **建议建，但按「约定族」建，不按「谁对」建**

- 建一个**约定族**节点，列出**至少两个成员**：
  - `conv.h-cs-sign.gs1984`：`H = dB + ω⁰_{3Y} − ω⁰_{3L}`，配套 `δB = −tr(AdΛ) + tr(ωdΘ)`（GS (4)+(9c)，L1）
  - `conv.h-cs-sign.bilal2008`：`H = dB − Q₃^{YM} + β̃Q₃^{L}`（Bilal (12.14)，L1）
- **note 必须写**：两者由 `(B, H) → (−B, −H)` 相联（**在 `β̃ = +1` 前提下**，见 Q-Z1 第三层），**物理不变量是两个 CS 项的相对符号**。
- **待补一个数**：`β̃` 的取值（Bilal §12）。**在补上之前，不要把该约定族标成「已闭合」。**
- **来源指向**：`green-schwarz-1984`，**不是** `zumino-*`（Q-Z2）。

### 5.5 Lean 岛候选（纯代数，可机检）

| 编号 | 命题 | 难度 | 备注 |
|---|---|---|---|
| **C1** | `d Tr F^n = n Tr(DF)F^{n−1} = 0`（Bianchi ⇒ `Tr F^n` 闭）（(2.18)(2.27)） | 低–中 | 需要分次代数 + 迹的循环性（带符号）。**Mathlib 现状：无现成的矩阵值微分形式分次代数**，须自建玩具设定 |
| **C2** | 同伦算子恒等式 `kd + dk = 1`（(2.45)），在 Z-LH p.17 明说的**纯代数**设定下（`A, F` 为自由生成元，`dA = F − A²`, `dF = FA − AF`） | 中 | ★ **Z-LH p.17 逐字给了这条许可**（E7 第 2 条引文）：不需要流形。这使它成为本文**最适合形式化的一条**。⚠ 但 `k² = 0` 原文未证，**不要**一并声称 |
| **C3** | `∫₀¹δλ∫₀^{1−λ}δμ λ^h μ^k = h!k!/(h+k+2)!`（(A.18)） | **极低** | 纯组合恒等式（Dirichlet 积分特例）。Mathlib 的 `Nat.factorial` + Beta 函数即可。**可作为第一块砖** |
| — | (5.13) 的归一化 | **排除** | 读图不可靠 + 原文自带 "up to a sign" + 依赖指标定理（外部输入） |
| — | (3.36) `ω¹` 的积分公式 | **排除** | 读图不可靠（§3.2） |

### 5.6 建议的 `sources.bib` 改动（**本轮已执行，见 §6**）

---

## 6. `sources.bib` 与 `reading-list.md` 的改动（本轮已写）

| key | 动作 | 说明 |
|---|---|---|
| `zumino-1983-les-houches` | **新增** | B. Zumino, *Chiral anomalies and differential geometry*, LBL-16747 / UCB-PTH-83/16。**本项目已有 L1 全文**（`osti.gov/servlets/purl/5461614`）。**= GS 1984 ref [10] 的第一项** |
| `zumino-wu-zee-1984` | **新增** | B. Zumino, Y.-S. Wu, A. Zee, Nucl. Phys. B239 (1984) 477–507。**= GS 1984 ref [9]**。note 记明：正文未取到（L2）、报告号冲突（Q-Z5）、无重印出处 |
| `reading-list.md` | 改两行 + 加备忘 | ZWZ 行状态改 `attempted, blocked`；新增 `zumino-1983-les-houches` 行（extracted, L1）；备忘区加 §0.5 的 OSTI purl 路线 |

