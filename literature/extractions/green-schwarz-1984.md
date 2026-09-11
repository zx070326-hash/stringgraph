# 抽取记录：green-schwarz-1984

- 文献：M. B. Green and J. H. Schwarz, "Anomaly cancellations in supersymmetric *D* = 10 gauge theory and superstring theory", *Physics Letters B* **149** (1984) 117–122. 预印本 CALT-68-1182（1984-09）。
- 抽取者：researcher agent
- 日期：2026-09-11
- 覆盖范围：**全文六页（PLB p.117–122），逐页读毕**
- 目标 area：`consistency`

---

## 0. 获取途径与证据等级（必读）

### 0.1 证据等级

沿用 `extractions/primary-sources-round2.md` §0 定义的 L0–L4 五级制（**不是** `polchinski-1998-v1.md` §0 的三级制）：

| 级 | 含义 |
|---|---|
| L1 | 逐页读了原文（扫描件/正文 PDF），可照抄措辞 |
| L2 | 出版方权威元数据或期刊逐字摘要（Crossref / INSPIRE / ADS / Project Euclid） |
| L3 | 可溯源二手陈述（作者本人综述、引用该文的公开论文正文） |
| L4 | 检索后端中介读取，非逐字，不得单独作为唯一依据 |
| L0 | 未能核实 |

### 0.2 ★ 本轮结果：**全文取到，等级 L1**

与 `goddard-thorn-1972`（至今 blocked）不同，本文全文**已取到并逐页读图**。路线如下（供后续复用，已写入 `reading-list.md` 备忘）：

1. INSPIRE 记录 15583 的 `publication_info` 列出六个重印出处，其中一个是
   `In *Appelquist, T. (ed.) et al.: Modern Kaluza-Klein theories*, 608-613`（L2）。
2. archive.org 高级检索 `title:(modern kaluza-klein theories)` → identifier **`modern-kaluza-klein-theories`**（公开、已 undarked）。
3. 该 item 的 PDF 有 30 MB，**超过 WebFetch 的 10 MB 上限**，直接下载失败。
4. 改用 archive.org 的两个公开端点：
   - **全文检索定位**：`https://ia801903.us.archive.org/fulltext/inside.php?item_id=modern-kaluza-klein-theories&doc=Modern%20Kaluza-Klein%20theories%20-%20Unknown&path=/19/items/modern-kaluza-klein-theories&q=<词>`
     ⚠️ `doc=` 必须填**文件基名**（本例 `Modern Kaluza-Klein theories - Unknown`），填 identifier 会返回 `"No hOCR or Abbyy file present"`。
     `server` / `dir` 从 `https://archive.org/metadata/<id>` 取。
   - **逐页取图**：`https://ia801903.us.archive.org/BookReader/BookReaderImages.php?zip=/19/items/<id>/<基名>_jp2.zip&file=<基名>_jp2/<基名>_0612.jp2&id=<id>&scale=1&rotate=0`
     → WebFetch 落盘 JPEG，再用 `Read` 读图。`scale=1` 是原尺寸（约 700 KB/页），`scale=2` 是半尺寸（约 250 KB/页）。
     **公式细节必须用 `scale=1`**：本次在 `scale=2` 下把 (25) 的求积上限、(4) 的下标都读错过。

### 0.3 页码映射

| jp2 leaf | 重印本页 | PLB 页 | 内容 |
|---|---|---|---|
| 0611 | 608 | 117 | 题名/作者/收稿日/摘要/引言 |
| 0612 | 609 | 118 | 约定、(1)–(9a,b) |
| 0613 | 610 | 119 | (9c)–(18)、fig. 1 |
| 0614 | 611 | 120 | (17′)–(23) |
| 0615 | 612 | 121 | (23′)–(25)、fig. 2 |
| 0616 | 613 | 122 | 结论、致谢、参考文献 |

> ⚠️ 重印本把期刊页码换成了书页码（左页眉是 `612 SUPERSTRINGS`，右页眉是 `ANOMALY CANCELLATIONS IN SUPERSYMMETRIC D=10 GAUGE THEORY 611`）。
> 「重印本 608+k ↔ PLB 117+k」这条映射是**推出来的**（六页连续 + INSPIRE 给的两个区间都是 6 页），不是页面上直接印着的。引用时若要精确到期刊页，请标 `inferred`。
> 本记录下文一律用「PLB p.NNN」并同时给重印页。

### 0.4 本轮使用的其他来源（全部 L1 全文，用于交叉核验，**不得与 GS 原文混为一谈**）

| 代号 | 来源 | 用途 |
|---|---|---|
| **[Sw01]** | J. H. Schwarz, *Anomaly Cancellation: A Retrospective From a Modern Perspective*, arXiv:hep-th/0107059（CALT-68-2335 / CITUSC-01-025），11 页读毕 | 作者本人 17 年后的**重述**。首页自陈「describe the original anomaly cancellation mechanism in a **more elegant way than was originally possible**」——**不是**原始论证 |
| **[Sw12]** | J. H. Schwarz, *The Early History of String Theory and Supersymmetry*, arXiv:1201.0981，13 页读毕（§7 Anomalies + §8 Epilogue） | 作者本人历史回忆（L3 性质的一手回忆） |
| **[Bi]** | A. Bilal, *Lectures on Anomalies*, arXiv:0802.0634v1（LPTENS-08/05），§12 全节读毕（p.96–103） | 现代教学重排，给出显式 `Î₁₂` 多项式与 `X₈` |
| **[An]** | A. Antonelli, *An Analysis of Anomaly Cancellation for Theories in D=10*, arXiv:1507.08642，36 页（§1–§2.3.1 与 Appendix + 参考文献读毕） | 496 维群分类问题的现状 |

---

## 1. 约定

### 1.1 GS 1984 自述的约定（全部 L1，PLB p.118 / 重印 609）

| 项 | GS 1984 的取法 | 位置 |
|---|---|---|
| 微分形式 | `F ≡ ½F_{μν}dx^μ ∧ dx^ν = dA + A²`；**省略 ∧ 号**，`A² ≡ A ∧ A` | (2) 及其后一句 |
| 规范势 | `A = A^a_μ λ^a dx^μ` | (3) |
| `λ` 矩阵 | **反厄米（antihermitean）**，取**基本表示**（SO(N)/USp(N) 的 `N`），尽管 YM 部分的无质量费米子在**伴随**表示 | (3) 后正文 |
| `tr` vs `Tr` | 逐字：**"The trace of a matrix `M` is denoted by `tr M` when `M` is in the fundamental representation and by `Tr M` when `M` is in the adjoint representation. (Of course, these are identical for E₈.)"** | (3) 后正文 |
| 自旋联络 | `ω = ω_μ dx^μ`，是切空间代数 `SO(9,1)` 的 **10 × 10** 矩阵；`R = dω + ω²` | (8) 后正文 |
| 讨论范围 | 逐字：**"We only discuss SO(N), USp(N) and E₈ × E₈ explicitly, but other groups can be analyzed in an analogous manner."** | (3) 后正文 |
| 耦合常数 | `κ`（引力）量纲 (length)³，`g`（YM）量纲 (length)⁴；`κ/g²` 正比于弦张力；`g²` 可吸收进 `φ` 的定义，故**无任意无量纲参数**（并注明 "We are grateful to E. Witten for pointing this out to us."） | (1) 后正文 |
| `e` | zehnbein `e^m_μ` 的行列式 | (1) 后正文 |

### 1.2 与 `[Bi]`（Bilal 2008）的约定换算 —— 转成图节点前必读

| 项 | GS 1984 | Bilal `[Bi]` §12 | 换算 |
|---|---|---|---|
| `H` 的定义 | **`H = dB + ω⁰_{3Y} − ω⁰_{3L}`** (4) | **`H = dB − Q₃(A,F) + β̃ Q₃(ω,R)`** (12.14) | **两个 CS 项的符号整体相反**。任务派工单里写的 `H = dB − ω_{3Y} + ω_{3L}` 与 Bilal 同号、与 GS 原文反号 |
| E₈ 的 `tr` 归一 | **`tr = Tr`**（GS 明说 "these are identical for E₈"），故 `Ω₈ = (1/100)(tr F²)²`、`Ω₁₂ = (1/7200)(tr F²)³` | 另外**定义** `tr F² ≡ (1/30) Tr F²`，于是 `Tr F⁴ = 9(tr F²)²`、`Tr F⁶ = (75/20)(tr F²)³` (12.28)–(12.29) | 差一个 `Tr F² = 30 tr F²` 的重标度。**同一个 `tr F²` 记号在两篇里指不同的东西** |
| 反常多项式整体归一 | (20) 的括号 | (12.21) 的括号 × `1/(64(2π)⁵)` | 已复算：**GS (20) = −(3/4) × [Bi] (12.21) 的括号内容**（三项系数比 3/4 完全一致，见 §5.3） |
| `X₈` | GS **不引入** `X₈` 记号，只给 `S₁ + S₂ + S₃`（(18)(21)(23)） | (12.26) 给 SO(32) 的 `X₈`、(12.33) 给 E₈×E₈ 的 `X₈` | `B ∧ X₈` 这个**打包写法不是 GS 原文的**，是后来的重排（[Bi] (12.16)、[Sw01] (36)） |

> ⚠️ `[An]`（Antonelli 2015）**在同一篇里混用两套 E₈ 归一**：§1.3（p.7）抄 Bilal 的重标度版（`9`、`75/20`），Appendix B（p.35）却用 GS/GSW 的原版（`1/100`、`1/7200`）。转节点时不要把两处的 `tr F²` 当成同一个量。

### 1.3 与 `graph/conventions/` 的对照

本次抽取**未**改动、也未核对 `graph/conventions/` 下任何 canonical 节点（researcher 不写 `graph/`）。给 curator 的提示：
- 本文用的是**微分形式语言 + 反厄米生成元**，没有出现 `α'` 归一化以外的世界面约定；`α'` 只在 (25) 里以 `[sin π(ν_j − ν_i)]^{2α' k_i·k_j} ` 出现，未声明取值。
- 度规号差：文中未显式声明；只由 "tangent-space algebra `SO(9,1)`" 间接给出洛伦兹号差。**不要**替它填 `conv.metric-*`，应标 `inferred` 或留空。

---

## 2. 陈述

> 除另有标注外，本节所有「位置 / 原文陈述 / 措辞」均为 **L1（逐页读图）**。
> 「文献自称的严格程度」栏一律**照抄原文动词**。

### E1 论文自我定位与适用范围
- 位置：PLB p.117（重印 608），第 2 栏 + 摘要
- 类型：proposition（元陈述）
- 原文（逐字，摘要）："Supersymmetric ten-dimensional Yang–Mills theory coupled to N = 1, D = 10 supergravity has gauge and gravitational anomalies that can be partially cancelled by the addition of suitable local interactions. The remaining pieces of all the anomalies cancel if the gauge group is SO(32) or E₈ × E₈. These cancellations are automatically incorporated in the type I superstring theory based on SO(32). A superstring theory for E₈ × E₈ has not yet been constructed."
- 原文（逐字，正文）："In this letter we wish to report the discovery of other anomaly-free chiral theories in ten dimensions. One of these is type I superstring theory (which contains unoriented open and closed strings) with SO(32) as the gauge group. The mechanisms responsible for anomaly cancellations are explained below in more conventional field-theoretic terms by describing the low-energy effective field theory, which consists of N = 1, D = 10 supergravity coupled to supersymmetric Yang–Mills theory, **even though any truncation of the complete string theory is probably not fully consistent**. At the level of the effective field theory, E₈ × E₈ is shown to be another possible anomaly-free theory."
- 文献自称的严格程度：**"we wish to report the discovery"** / **"is shown to be"**；同时**主动声明**有效场论截断"probably not fully consistent"
- 文献列出的依赖：[1] Witten（Kaluza–Klein 中的费米子数）；[2] Frampton–Kephart / Townsend–Sierra / Zumino–Wu–Zee / Baulieu（YM 反常）；[3] Alvarez-Gaumé–Witten（引力反常）；[4] Schwarz Phys. Rep. 89 (1982) 223 + Green Surv. High Energy Phys. 3 (1983) 127（综述）；[5] IIB D=10 SUGRA；[6] Gell-Mann–Zwiebach
- 备注：另有一句限定了本文的边界 —— **"The superstring results are summarized at the end of this paper, but details of the analysis are left for a future publication."** 弦论侧的细节**不在本文**（见 E18）。收稿日 **10 September 1984**。

### E2 玻色作用量
- 位置：PLB p.118（重印 609），eq. (1)
- 类型：definition
- 原文（逐字转录）：
  `S₀ = ∫d¹⁰x e[−(1/2κ²)R − (1/κ²)φ^{−2}∂_μφ ∂^μφ − (1/4g²)φ^{−1}F^a_{μν}F^{μνa} − (3κ²/2g⁴)φ^{−2}H_{μνρ}H^{μνρ}]`
- 文献自称的严格程度：陈述式（"The action for the interacting theory contains the bosonic terms"）
- 文献列出的依赖：ref [7] = E. Bergshoeff, M. de Roo, B. de Wit, P. van Nieuwenhuizen, Nucl. Phys. **B195** (1982) 97；G. F. Chapline and N. S. Manton, Phys. Lett. **120B** (1983) 105（"minimal form" 的耦合 SUGRA+SYM lagrangian）
- 备注：`R` 这里是标量曲率（第一项），与后文作为曲率二形式的 `R` **同符号不同义**。

### E3 微分形式与迹的约定
- 位置：PLB p.118（重印 609），(2)(3) 及其间正文
- 类型：definition
- 见 §1.1 表（`F = dA + A²`；`A = A^a_μλ^a dx^μ`；`λ` 反厄米、基本表示；`tr`/`Tr` 定义）

### E4 `H` 的 Chern–Simons 修正
- 位置：PLB p.118（重印 609），(4)(4′)(5)(6)(7)(8)
- 类型：definition
- 原文（逐字转录）：
  - (4) `H = dB + ω⁰_{3Y} − ω⁰_{3L}` ——「for the case of SO(N) or USp(N)」
  - (4′) `H = dB + (1/30)ω⁰_{3Y₁} + (1/30)ω⁰_{3Y₂} − ω⁰_{3L}` ——「In the case of E₈ × E₈ this equation is replaced by」
  - (5) `ω⁰_{3Y} = tr(AF − ⅓A³)`
  - (6) `dω⁰_{3Y} = tr F²`
  - (7) `ω⁰_{3L} = tr(ωR − ⅓ω³)`
  - (8) `dω⁰_{3L} = tr R²`
- 原文（逐字，关键限定句）："**The last term in eq. (4) is a higher-derivative term arising in the low-energy expansion of the superstring and therefore does not appear in ref. [7].** Its inclusion leads to a very similar treatment of the Yang–Mills local Lorentz symmetries."
  → 即：**YM Chern–Simons 项已在 ref [7] 的经典 SUGRA 里；洛伦兹 Chern–Simons 项 `−ω⁰_{3L}` 是本文新加的**。（[Sw01] p.9 独立复述同一点：「Note that ω₃ contains both Yang–Mills and Lorentz Chern–Simons terms. Only the former is present in the classical supergravity theory.」）
- 原文（(4′) 里 1/30 的来历，逐字）："The Yang–Mills Chern–Simons terms in eq. (4) would have a coefficient of 1/30 (as in eq. (4′)) for the special case of SO(32) if it were defined in terms of matrices in the adjoint representation."
- 文献自称的严格程度：定义式，无证明
- 备注：**符号方向见 §1.2** —— GS 是 `+ω_{3Y} − ω_{3L}`，Bilal (12.14) 是 `−Q₃^{YM} + β̃Q₃^{L}`。

### E5 规范/洛伦兹变换与 `H` 的不变性
- 位置：PLB p.118–119（重印 609–610），(9a,b)(9c)(9c′)(10a,b,c)
- 类型：proposition
- 原文（逐字转录）：
  - (9a,b) `δA = dΛ + [A, Λ]`, `δω = dΘ + [ω, Θ]`
  - (9c) `δB = −tr(AdΛ) + tr(ωdΘ)`，for SO(N) or USp(N)
  - (9c′) `δB = −(1/30)tr₁(A₁dΛ₁) − (1/30)tr₂(A₂dΛ₂) + tr(ωdΘ)`，for E₈ × E₈
  - (10a,b,c) `δF = [F, Λ]`, `δR = [R, Θ]`, `δH = 0`
- 原文（逐字）："The subscripts in eq. (9′c) refer to the two E₈ factors. **It follows from eq. (10) that the terms in eq. (1) are invariant.** It is crucial that the potential `B` transforms under both kinds of transformations and that the field strength `H` is invariant."
- 文献自称的严格程度：**"It follows from"**（无计算）
- 依赖：E4

### E6 反常的十二形式编码
- 位置：PLB p.119（重印 610），(11) 及其上一段
- 类型：proposition
- 原文（逐字）："Anomalies in ten-dimensional gauge theories arise from loop diagrams with six or more external lines and chiral fields circulating around the loop. The anomalies corresponding to diagrams with more than six external lines are uniquely determined by the hexagon diagrams. Their form can be deduced by implementing the Wess–Zumino consistency conditions [8]. The analysis of ref. [9] relates the anomalies to a formal expression in twelve dimensions, namely the gauge-invariant twelve-form `Ω₁₂`, where"
  - (11) `Ω_{4n} = tr F^{2n}`  ← **⚠️ 印作小写 `tr`，见 §3.1**
- 文献自称的严格程度：**"can be deduced by"** / **"The analysis of ref. [9] relates"** —— 本文不重做推导，直接引用
- 文献列出的依赖：[8] J. Wess and B. Zumino, Phys. Lett. **37B** (1971) 95；[9] B. Zumino, Y. S. Wu and A. Zee, Nucl. Phys. **B239** (1984) 477

### E7 ★【纯代数】SO(N) / USp(N) 的伴随–基本迹恒等式
- 位置：PLB p.119（重印 610），(12a)(12b)(12c)(13a)(13b)
- 类型：proposition（李代数迹恒等式）
- 原文（逐字转录）：
  - (12a) `Ω₄ = (N + 2l) tr F²`
  - (12b) `Ω₈ = (N + 8l) tr F⁴ + 3(tr F²)²`
  - (12c) `Ω₁₂ = (N + 32l) tr F⁶ + 15 tr F² tr F⁴`
  - where (13a) `l = −1` for SO(N)；(13b) `l = +1` for USp(N)
- 引导句（逐字）："The cases of SO(N) and USp(N) are considered first. In these cases `Ω_{4n}` can be reexpressed in terms of fundamental-representation matrices"
- 文献自称的严格程度：**直接给出，无任何证明动词**（没有 "we show"、"one can show"、"it follows"），也没有给出处引用
- 备注：
  - 与 `[Bi]` (12.23) 一致：`Tr F² = (n−2)tr F²`、`Tr F⁴ = (n−8)tr F⁴ + 3(tr F²)²`、`Tr F⁶ = (n−32)tr F⁶ + 15 tr F² tr F⁴`（Bilal 的措辞是 **"Let us note without proof that…"**）。
  - 与 `[An]` p.10 Table 2 一致（`[An]` §2.3.1 给了 SO(n) 情形的一个推导：从 `Ω^{mn}_{kl} = O^m_k O^n_l − O^n_k O^m_l` 出发，`TrΩ = ½[(trO)² − tr(O²)]`，再对 `Ω = e^𝓕`、`O = e^F` 按阶比较）。
  - `USp` 一路：GS 从未单独讨论 USp 的排除，但由 (12c)+(13b)，`N + 32l = N + 32 > 0` 恒不为零 ⇒ USp 的 `tr F⁶` 项不可消。**这一步是抽取者的推论，转节点时须标 `inferred: true`。**

### E8 ★【纯代数】E₈ 的迹恒等式
- 位置：PLB p.119（重印 610），(12a′)(12b′)(12c′)
- 类型：proposition
- 引导句（逐字）："For the group E₈, eq. (12) is replaced by"
  - (12a′) `Ω₄ = tr F²`
  - (12b′) `Ω₈ = (1/100)(tr F²)²`
  - (12c′) `Ω₁₂ = (1/7200)(tr F²)³`
- 文献自称的严格程度：**直接给出，无证明、无引用**
- 备注：这里 `tr = Tr`（E₈ 伴随即基本，见 §1.1）。与 `[An]` Appendix B（p.35，注明来自 GSW Vol. 2）逐字一致。与 `[Bi]` (12.28) 在换算 `Tr F² = 30 tr F²` 后一致（§1.2）。
- 致谢里的归属（见 E17）：**"We are grateful to G. Chapline and R. Slansky for pointing out to us that E₈ has no independent fourth- and sixth-order Casimir invariants."**

### E9 `tr F⁶` 项不可消 ⇒ SO(32)
- 位置：PLB p.119（重印 610），(12c) 下方 + (14)(15)(16)
- 类型：proposition
- 原文（逐字）："**The first term in eq. (12c) corresponds to anomalies that cannot be cancelled by the addition of local interactions to the effective action. However, it is absent if the gauge group is chosen to be SO(32).** The second term in eq. (12c) can be expressed as"
  - (14) `tr F² tr F⁴ = d(ω⁰_{3Y} tr F⁴) = d(ω⁰_{7Y} tr F²)`
  - (15) `dω⁰_{2n+1 Y} = tr F^{n+1}`（"where `ω⁰_{2n+1 Y}` is defined (up to an exact form) by"；"Explicit expressions for `ω⁰_{2n+1 Y}` are given in ref. [9]"）
  - (16) `δω⁰_{2n+1 Y} = −dω¹_{2n Y}`（"Similarly, applying an infinitesimal gauge transformation, one defines `ω¹_{2n Y}` (up to an exact form) by"）
- 文献自称的严格程度：陈述式；`ω⁰` 的显式表达式**外包给 ref [9]**
- 依赖：E7（(12c) 的 `N + 32l` 系数），[9]

### E10 YM 反常与抵消项 `S₁`（SO(32)）
- 位置：PLB p.119（重印 610），(17)(18) + fig. 1
- 类型：proposition
- 原文（逐字转录）：
  - (17) `G = c∫(⅓ω¹_{2Y} tr F⁴ + ⅔ω¹_{6Y} tr F²)`
    "where the ratio of the two terms is uniquely determined by Bose symmetry. **The numerical constant `c` can be deduced from refs. [3,9].**"
  - (18) `S₁ = c∫(B tr F⁴ + ⅔ω⁰_{3Y}ω⁰_{7Y})`
- 原文（逐字）："**The nontrivial `Λ` transformation of `B` in eq. (9c) is the key to the cancellation between `δS₁` and `G`. This amounts to a complete cancellation of the Yang–Mills anomaly for the gauge group SO(32).**"
- 树图机制（逐字）："The extra terms in the action contribute anomalous pieces to tree amplitudes. For example, there is a tree diagram with six external gauge fields (fig. 1) in which the `B tr F⁴` vertex is connected to the `ω⁰_{3Y} dB` vertex (contained in the `H²` term of eq. (1)) by a `B` propagator. This gives rise to an anomalous piece of the six-particle amplitude, which together with the second term in eq. (18) cancels the hexagon anomaly."
- 文献自称的严格程度：陈述式；`c` **不在本文算出**，指向 [3]（Alvarez-Gaumé–Witten）与 [9]（Zumino–Wu–Zee）
- 依赖：E5 (9c)、E9 (14)(16)

### E11 ★【纯代数】因子化恒等式（本文的核心代数命题）
- 位置：PLB p.120（重印 611），(19)
- 类型：proposition
- 引导句（逐字，跨页）："It is important in comparing the analysis of the mixed anomalies for SO(32) and E₈ × E₈ that **for both these gauge groups**"
  - (19) `Ω₁₂ = (1/48) Ω₄ [Ω₈ − (1/300)(Ω₄)²]`
- 文献自称的严格程度：**直接断言，无证明**（只说 "It is important … that for both these gauge groups"）
- 依赖：E7（SO(32)：`l = −1, N = 32`）、E8（E₈）
- 抽取者复算（**可完全机械验证，见 §5.1**）：
  - E₈：RHS `= (1/48)(tr F²)[(1/100) − (1/300)](tr F²)² = (1/48)(1/150)(tr F²)³ = (1/7200)(tr F²)³` = (12c′) ✓
  - SO(32)：`Ω₄ = 30 tr F²`、`Ω₈ = 24 tr F⁴ + 3(tr F²)²`、`Ω₁₂ = 15 tr F² tr F⁴`；
    RHS `= (1/48)(30 tr F²)[24 tr F⁴ + 3(tr F²)² − 3(tr F²)²] = (5/8)(24) tr F² tr F⁴ = 15 tr F² tr F⁴` ✓
- 备注：把 (19) 展开即 `Ω₁₂ = (1/48)Ω₄Ω₈ − (1/14400)Ω₄³`。这与网上常见的写法 `Tr F⁶ = (1/48)Tr F⁴ Tr F² − (1/14400)(Tr F²)³` 数值一致 —— **但那个写法是二手转述（L4），原文的编号式是 (19) 的嵌套形式。**

### E12 E₈ × E₈ 的 YM 反常与抵消项
- 位置：PLB p.120（重印 611），(17′)(18′)
- 类型：proposition
- 引导句（逐字）："**It follows from eq. (12c′) by the same reasoning as before** that the consistent anomaly for E₈ × E₈ is given by"
  - (17′) `G′ = (c/108000)∫[ω¹_{2Y₁}(tr₁F²)² + ω¹_{2Y₂}(tr₂F²)²]`
  - (18′) `S′₁ = (c/108000)∫{30B[(tr₁F²)² + (tr₂F²)² − tr₁F² tr₂F²] − ω⁰_{3Y₁}ω⁰_{3Y₂}(tr₁F² − tr₂F²)}`
    （"This can be cancelled by adding"）
- 文献自称的严格程度：**"It follows … by the same reasoning as before"** —— 无独立推导
- 依赖：E8、E10

### E13 ★ 纯引力反常十二形式与 `dim G = 496`
- 位置：PLB p.120（重印 611），(20)
- 类型：proposition
- 引导句（逐字）："As described above for the Yang–Mills case, Lorentz anomaly structures arising from hexagon (and higher) diagrams with external gravitons only can be associated with **the formal twelve-form [3]**"
  - (20) `−[1/32 + (n − 496)/13824](tr R²)³ − [1/8 + (n − 496)/5760] tr R² tr R⁴ − [(n − 496)/7560] tr R⁶`
- 原文（逐字，`n` 的含义）："In this expression we have included the contributions of **one left-handed spin 3/2 gravitino and one right-handed spin 1/2 field from the supergravity sector and `n` left-handed spin 1/2 fields from the matter sector**, which only depends on the dimension of the gauge group."
- 原文（逐字，496 的结论）："**The last term in eq. (20) corresponds to an anomaly of the form ∫ω¹_{10L}, which cannot be cancelled by adding local terms to the action. Therefore 496 left-handed spin 1/2 fields are needed in the matter sector in order that it vanish. Remarkably, since the dimension of the adjoint representation of SO(32) or E₈ × E₈ is 496, the cancellation occurs for either of these gauge groups.**"
- 文献自称的严格程度：系数**外包给 ref [3]**（Alvarez-Gaumé–Witten）；本文只做"因此需要 496"这一步推论
- 文献列出的依赖：[3] L. Alvarez-Gaumé and E. Witten, Nucl. Phys. **B234** (1983) 269 ⚠️ **GS 把年份写成 1983，通行引法是 1984**（[Sw12] 参考文献作 1984）。[10] Zumino Les Houches 1983 + Stora Cargèse 1983；[11] Bardeen–Zumino LBL-17639 + Alvarez-Gaumé–Ginsparg HUTP-84/A016（引力反常 ↔ 局部洛伦兹反常的互相转移）
- 备注（重要，易误引）：**`n = 496` 只让 `tr R⁶` 项消失**；(20) 的前两项在 `n = 496` 时仍留下 `−(1/32)(tr R²)³ − (1/8) tr R² tr R⁴`，由 `S₂`（E14）抵消。不要写成"496 使引力反常整体为零"。

### E14 引力反常抵消项 `S₂`
- 位置：PLB p.120（重印 611），(21)
- 类型：proposition
- 原文（逐字转录）："The anomalies associated with the first two terms of eq. (20) can be cancelled (putting `n = 496`) by adding to the effective action for SO(32) or E₈ × E₈"
  - (21) `S₂ = −c∫[1/32 B(tr R²)² + ⅛B tr R⁴ + 1/12 ω⁰_{3L}ω⁰_{7L}]`
- 原文（逐字，结论句）："**Thus, not only does the cancellation of the Yang–Mills anomaly require coupling to the supergravity multiplet, but also the cancellation of the gravitational anomalies requires the contributions of Yang–Mills supermultiplets.**"
- 备注：`S₂` 对 SO(32) 与 E₈×E₈ **相同**（不含规范场）。

### E15 ★ 混合反常：`N = 32` 的两次独立确认
- 位置：PLB p.120（重印 611），(22)(23)
- 类型：proposition
- 原文（逐字）："The extra terms in the action, which are needed to cancel the pure Yang–Mills and local Lorentz anomalies, also contribute to mixed anomalies. (Consider, for example, the Lorentz variation of the `B` field in eq. (18)). **The relative normalization of all the anomalies can be deduced from eq. (63) of ref. [3].** In particular, the twelve-form that characterizes the mixed anomalies for SO(32) is"
  - (22) `−tr R²[tr F⁴ + ⅛(tr F²)²] + tr F²[⅛ tr R⁴ + (5/32)(tr R²)²]`
- 原文（逐字）："**The twelve-forms in (14), (20) and (22) are given with the correct relative normalization.** The mixed anomalies can be cancelled by adding the local terms"
  - (23) `S₃ = c∫(⅛B tr R² tr F² + (1/48)ω⁰_{3L}ω⁰_{3Y} tr R² − (1/24)ω⁰_{3Y}ω⁰_{3L} tr F² − ⅔ω⁰_{3L}ω⁰_{7Y} + (1/12)ω⁰_{3Y}ω⁰_{7L})`
- 原文（逐字，★核心）："**The cancellation requires that `N + 8l = 24` and `N + 2l = 30` in eq. (12). Thus the cancellation of mixed anomalies gives two independent confirmations of the consistency of choosing the gauge group SO(32). In summary, modifying the action of ref. [7] by including the last term in eq. (4) and adding `S₁ + S₂ + S₃` to the action gives complete cancellation of all anomalies at one-loop level for the gauge group SO(32).**"
- 文献自称的严格程度：相对归一化**外包给 ref [3] eq. (63)**；"The cancellation requires that…" 是断言，无中间步骤
- 依赖：E7、E10、E13、E14
- 备注：`N + 8l = 24` 与 `N + 2l = 30` 在 `l = −1` 时**都**给 `N = 32`；两式相容本身是非平凡的（**这就是 GS 说的"two independent confirmations"**）。见 §5.2。

### E16 E₈ × E₈ 的混合反常抵消
- 位置：PLB p.120–121（重印 611–612），(23′)
- 类型：proposition
- 原文（逐字）："**Given the cancellation of mixed anomalies in SO(32) the possibility of their cancellation in E₈ × E₈ follows from eq. (19).** Explicitly, for E₈ × E₈ one obtains"
  - (23′) `S′₃ = (c/7200)∫(30 B tr R² tr₁F² + 5ω⁰_{3L}ω⁰_{3Y₁} tr R² + 20ω⁰_{3Y₁}ω⁰_{7L} + ω⁰_{3Y₁}ω⁰_{3L} tr₁F² + ω⁰_{3L}ω⁰_{3Y₁} tr₂F²) + (1 ↔ 2)`
- 原文（逐字，结论）："Thus, as before, the addition of `S′₁ + S₂ + S′₃` to the action cancels all the one-loop anomalies for E₈ × E₈. **It may be interesting to look for analogous anomaly-free theories in other dimensions.**"
- 文献自称的严格程度：**"follows from eq. (19)"** —— E₈×E₈ 的混合反常抵消**没有独立验算**，是靠 (19) 的因子化恒等式从 SO(32) 推过去的
- 依赖：E11（(19)）、E15
- 备注：(23′) 最后两项 `ω⁰_{3Y₁}ω⁰_{3L}tr₁F²` 与 `ω⁰_{3L}ω⁰_{3Y₁}tr₂F²` 的 `ω` 次序相反；三形式反对易，故 `ω⁰_{3L}ω⁰_{3Y₁} = −ω⁰_{3Y₁}ω⁰_{3L}`。**按印刷原样转录**，不要"顺手合并"。

### E17 ★ 弦论侧：GS 原文的断言范围
- 位置：PLB p.121（重印 612），"Superstring anomalies" 一节，(24)(25) + fig. 2
- 类型：proposition
- 原文（逐字，来历）："**The results described above were discovered by calculating the anomalies of superstring diagrams and studying the low-energy expansions of the formulae.** Since type I superstrings appear otherwise to be consistent quantum theories, the possibility of anomalies is of crucial importance. Their occurrence in a covariant formalism implies that unphysical modes of gauge fields cannot be consistently decoupled, leading to a breakdown of unitarity in the quantum theory. In the light-cone gauge formalism the problem would be expressed as a breakdown of Lorentz invariance."
- 原文（逐字，群的范围）："The groups SO(N), USp(N), and U(N) have been shown to be possible superstring gauge groups at the classical level [4,12]. The U(N) case was shown in ref. [4] to give inconsistencies at the quantum level. **In view of the preceding results, it seems very likely to us that E₈ × E₈ is also possible for superstrings. Since such a superstring theory has not yet been formulated, the following discussion is restricted to the cases SO(N) and USp(N).**"
- 原文（逐字，计算本身）："**We have explicitly evaluated the anomalies of one-loop superstring hexagons with external massless Yang–Mills particles in a covariant formalism. The results are summarized here, but the details will be presented elsewhere.** The one-loop diagrams come in three topologies, shown in fig. 2, called planar, nonorientable, and nonplanar. **The planar and nonorientable diagrams have a group theory structure corresponding to the `tr F⁶` term in eq. (12) whereas the nonplanar diagrams have the group-theoretic structure of the `tr F² tr F⁴` term. The nonplanar diagrams turn out to be anomaly-free. This means that the superstring theory necessarily contains terms such as in eq. (18) with the requisite coefficients.**"
- 显式振幅：
  - (24) `k_r·ζ_r = k_r² = 0`（`r = 2,3,4,5,6`；line no. 1 用 `k₁^μ` 代替 `ζ₁^μ`）
  - (25) `G = (const.)(N + 32l) tr(λ₁λ₂λ₃λ₄λ₅λ₆) × ε_{μ₁…μ₅ν₁…ν₅} ζ₁^{μ₁}…ζ₅^{μ₅} k₁^{ν₁}…k₅^{ν₅} × ∫₀¹(∏_{i=1}^{5} ϑ(ν_{i+1} − ν_i) dν_i) × ∏_{1≤i<j≤8}[sin π(ν_j − ν_i)]^{2α′k_i·k_j} + permutations`，`where ν₆ = 1`
    ⚠️ 求积上限见 §3.2
- 原文（逐字，结论）："**The coefficient `N` comes from the planar diagram and the coefficient `32l` from the nonorientable one. As before, a perfect cancellation occurs for SO(32).** Eq. (25) is different from the anomaly of the low-energy effective field theory, because **(contrary to common belief) massive fermions also contribute to the anomaly**. It reduces to the usual anomaly at low energies (`α′k_i·k_j ≪ 1`). Anomalies involving excited external states can be deduced by factorizing on poles of eq. (25)."
- 文献自称的严格程度：**"We have explicitly evaluated … The results are summarized here, but the details will be presented elsewhere."** —— **本文只给结果，不给弦论侧推导**
- 备注（重要，归属易搞混）：[Sw12] p.9（L1）把这条链拆得更清楚：
  > "After a couple years of failed attempts, Green and I finally managed to compute the one-loop hexagon diagrams in Type I superstring theory. … **Green and Schwarz (1985) showed that SO(32) is the unique choice for which the cancellation occurs.** Since this computation only demonstrated the cancellation of the pure gauge part of the anomaly, we decided to explore the low-energy effective field theory to see whether the gravitational and mixed anomalies also cancel. Using the results of Alvarez-Gaumé and Witten (1984), **Green and Schwarz (1984b)** verified that all gauge, gravitational, and mixed anomalies do in fact cancel for the gauge group SO(32)."
  其中 Green & Schwarz (1985) = *The hexagon gauge anomaly in Type I superstring theory*, Nucl. Phys. **B255** (1985) 93–114；**(1984b) 就是本文**。也就是说：**弦论侧的完整单圈计算发表在 1985 的 Nucl. Phys. B255，本文只是"summarized here"。**

### E18 超对称性与遗留问题（作者自陈的不完整处）
- 位置：PLB p.122（重印 613），第 1 栏
- 类型：proposition（元陈述）
- 原文（逐字）："The field-theoretic discussion in the earlier part of this paper only displayed certain higher-derivative terms, occurring in the low-energy expansion of the superstring, that were required for explaining the anomaly cancellation mechanisms. **Clearly, only adding these terms and no others destroys supersymmetry. We suspect that restoring it would require introducing the entire infinite expansion of the superstring effective action. We have not investigated anomalous divergences of the supersymmetry current, but since the gravitino and the graviton are in the same supermultiplet it seems likely that the cancellation of gravitational anomalies should also ensure the cancellation of supersymmetry anomalies in the superstring theory.**"
- 原文（逐字，结论）："**In conclusion, it appears very likely that SO(32) superstring theory is a consistent quantum theory. More analysis of anomaly cancellation in various diagrams involving closed strings still needs to be carried out. Also, the possibility of anomalies associated with 'big' gauge transformations, not connected to the identity, remains to be investigated.** The anomaly cancellations in the case of the E₈ × E₈ effective theory suggest that it is also the low-energy expansion of a superstring theory, which has not yet been formulated. The fact that anomaly-free type I superstring theories are chiral theories containing elementary gauge fields makes them appealing candidates for a fundamental theory."
- 文献自称的严格程度：**"it appears very likely"** / **"We suspect"** / **"it seems likely"** —— 三处明确的非严格措辞
- 备注：转图节点时，E18 应压低所有依赖它的下游节点的有效状态。**「SO(32) 型 I 弦是自洽量子理论」在 GS 原文里是 "appears very likely"，不是定理。**

### E19 ★ 致谢：E₈ × E₈ 部分是谁补的
- 位置：PLB p.122（重印 613），第 1–2 栏致谢段
- 类型：proposition（归属/历史事实）
- 原文（**逐字，最关键的一段**）："We wish to acknowledge helpful and stimulating discussions with W. Bardeen, D. Friedan, S. Shenker, P. West, B. Zumino, and other participants at the Aspen Center for Physics. **In an earlier version of this paper it was noted that the gravitational anomalies cancel for E₈ × E₈, but the cancellation of the other anomalies in that theory was overlooked. We are grateful to G. Chapline and R. Slansky for pointing out to us that E₈ has no independent fourth- and sixth-order Casimir invariants. L. Dixon, J. Harvey and E. Witten and, independently, J. Thierry-Mieg have also observed that all the Yang–Mills and mixed anomalies can be cancelled for the case of E₈ × E₈.**"
- 佐证（L2，INSPIRE 记录 15583 的 `titles` 字段有两条）：
  - 发表版：`Anomaly Cancellation in Supersymmetric D=10 Gauge Theory and Superstring Theory`
  - **预印本版（CALT-68-1182，`preprint_date` = 1984-09）：`ANOMALY CANCELLATIONS IN SUPERSYMMETRIC D = 10 GAUGE THEORY REQUIRE SO(32)`**
- 结论（**这是本次抽取对派工单"E₈×E₈ 是谁补的"问题的回答**）：
  1. **发表版 PLB 149 (1984) 117 确实同时包含 SO(32) 与 E₈ × E₈**（摘要、(4′)(9c′)(12′)(17′)(18′)(23′) 六处显式处理 E₈ × E₈）。
  2. **但 E₈ × E₈ 的规范/混合反常抵消不是 GS 独立发现的**：早期版本（= 题为 "…REQUIRE SO(32)" 的 CALT-68-1182）只注意到引力反常抵消，"the cancellation of the other anomalies in that theory was overlooked"。
  3. 关键的群论输入（E₈ 无独立四阶、六阶 Casimir）来自 **G. Chapline 与 R. Slansky**；独立作出同一观察的是 **L. Dixon、J. Harvey、E. Witten** 和 **J. Thierry-Mieg**。
  4. GS 原文**没有**做"只有 SO(32) 和 E₈ × E₈"的分类证明，见 E20。

### E20 ★ GS 原文**没有**给出唯一性分类（否定结论）
- 位置：全文
- 类型：proposition（关于本文范围的否定陈述）
- 依据（L1）：
  - PLB p.118 明写 **"We only discuss SO(N), USp(N) and E₈ × E₈ explicitly, but other groups can be analyzed in an analogous manner."** —— 没有分类断言。
  - 摘要只说 "The remaining pieces of all the anomalies cancel **if** the gauge group is SO(32) or E₈ × E₈"（充分条件，非充要）。
  - 全文没有出现 "only"、"unique"、"classification" 之类针对规范群的断言。
- 后续文献对唯一性的说法（**三个来源互相冲突，未裁决**）：

  | 来源 | 说法 | 等级 |
  |---|---|---|
  | `[Sw12]` p.10（Schwarz 本人 2012） | "The effective field theory analysis showed that E₈ × E₈ is a second (**and the only other**) gauge group for which the anomalies could cancel for a theory with N=1 supersymmetry in ten dimensions." | L1（但属回忆） |
  | `[Bi]` p.102–103（Bilal 2008 §12.4.2） | 有**四**个解：`SO(32)`、`E₈ × E₈`、`E₈ × U(1)²⁴⁸`、`U(1)⁴⁹⁶`。措辞：**"One can actually scan all 496-dimensional groups and show that there are no other possibilities to achieve factorization of `Î₁₂^{total}`."**（无证明、无引用） | L1 |
  | `[An]`（Antonelli 2015）§1.1 | 同样列四个解，来源指向 **"the original statement found in chapter 13 of [3]"**，其中 [3] = **GSW Vol. 2 (1988)**；并明确说 **"but no proof has explicitly been carried out"**，本文（2015）才补证 | L1 |

- 结论：
  - "只有 SO(32) 与 E₈ × E₈"这个说法 **不属于 GS 1984**。
  - 完整版是**四个**李代数（另加两个含 U(1) 因子的平凡解），其"原始陈述"在 **GSW Vol. 2 第 13 章**（据 `[An]`，本次未直接核实 GSW，标 **L3**）。
  - Schwarz 本人 2012 年的 "the only other" 与四解表述**冲突**；最可能的解释是他只算非阿贝尔/半单群，但他没这么限定。**记为矛盾，不裁决。**
  - 唯一性的**显式证明**据 `[An]` 摘要直到 2015 才做（arXiv:1507.08642，作者自称 "We prove that…"）。该文是**单作者预印本，未在本次核实到期刊发表记录**，引用时须注明。

---

## 3. 未核实式号 / 读图不确定处

> 本节列出**即使拿到 L1 影印件仍不能 100% 确定**的地方。转图节点时凡涉及这几处，必须保留标记。

### 3.1 (11) 的 `tr` 还是 `Tr`
- (11) 在影印件（`scale=1`，2541×3238）上印作 **`Ω_{4n} = tr F^{2n}`**，首字母看起来是**小写**。
- 但语义上必须是**伴随迹**：紧接的引导句是 "In these cases `Ω_{4n}` **can be reexpressed in terms of fundamental-representation matrices**"，(12a) 才把它写成 `(N + 2l) tr F²`。若 (11) 已经是基本迹，(12a) 就是废话。
- 而 (15) `dω⁰_{2n+1 Y} = tr F^{n+1}` 的 `tr` **确实**是基本迹（与 (5)(6) 一致）。
- **判定：(11) 的 `tr` 与本文 §1.1 自定的 `tr`/`Tr` 约定不一致，疑为原文排版疏忽（应作 `Tr`）。** 抽取者读图无法排除是印刷字形问题。转节点时请写成 `Tr F^{2n}` 并加 note 指向本条。

### 3.2 (25) 的求积上限
- 影印件上印作 `∏_{1 ≤ i < j ≤ 8}`（第二个数字读作 **8**）。
- 但 (25) 是**六点**振幅，`ν₆ = 1`，外线只有 6 条，语义上应为 `≤ 6`。
- **未裁决**：可能是原文误排，也可能是抽取者把 `6` 读成 `8`（该字符在扫描件上偏糊）。**引用 (25) 时请勿依赖这个上限。**

### 3.3 (4) 第一项的下标
- `scale=2` 下读作 `H = dB + ω⁰_{3Y} − ω⁰_{3L}`；`scale=1` 下两个下标的字形接近，第一个也可能被读成 `3L`。
- **判定为 `ω⁰_{3Y}`，依据是紧随其后的正文逐字句 "In eq. (4) `ω⁰_{3Y}` is the Yang–Mills Chern–Simons three-form"。** 这一步是文字佐证，非直接读图，已记录。

### 3.4 (4′) 之后正文里的 `1/30`
- 该句的行内分数在影印件上分母字形介于 `30` 与 `3n` 之间。
- **判定为 `1/30`**：句子自己说 "(as in eq. (4′))"，而 (4′) 里两个系数清晰印作 `1/30`；且 SO(32) 有 `Tr F² = 30 tr F²`（由 (12a) `l=−1, N=32`）。

### 3.5 参考文献 [3] 的年份
- GS 参考文献 [3] 印作 "L. Alvarez-Gaumé and E. Witten, Nucl. Phys. **B234** (1983) 269"。
- 通行引法是 **1984**（`[Sw12]` 参考文献、`[Bi]` ref [3] 均作 1984）。
- **GS 原文写的是 1983。** 建 bib 条目时用 1984，但注明原文如此。

### 3.6 期刊页码映射
- 见 §0.3 末尾的警告：`重印 608+k ↔ PLB 117+k` 是推论，非页面直证。

---

## 4. 未解决的疑问（留给 curator / auditor）

**Q1（唯一性归属）** —— "只有 SO(32) 与 E₈ × E₈"该挂到哪个节点？
本次已确定它**不属于** `green-schwarz-1984`。候选一手来源是 **GSW Vol. 2 第 13 章**（本次未直接核实，L3，转引自 `[An]` §1.1）。
建议：把「(19) 型因子化对 SO(32) 与 E₈×E₈ 成立」（= E11，GS 1984，可严格验证）与「496 维群中只有四个解」（分类断言，来源不明 + 证明晚至 2015）**拆成两个节点**，后者标 `conjecture` 或 `physical-argument`，且**不要**把 `green-schwarz-1984` 列为它的 source。

**Q2（`c` 与相对归一化）** —— GS 把 (17) 的常数 `c` 与 (22) 的相对归一化都外包给 `[3]` 的 eq. (63)（Alvarez-Gaumé–Witten, Nucl. Phys. B234, 269）。
本次**未核实** AGW 的 eq. (63)（该文 1984 年，无 arXiv，本轮未尝试取全文）。
后果：`green-schwarz-1984` 的整条反常抵消链，其**数值系数层**目前是 L0（依赖一篇未抽取的文献）。这是本抽取最大的未闭合依赖。

**Q3（(20) 的系数来源）** —— (20) 的三个系数同样"can be associated with the formal twelve-form [3]"，即出自 AGW 的指标定理计算。GS 未复算。
交叉核验结果（见 §5.3）：GS (20) 与 `[Bi]` (12.21) 的括号内容之比在三项上**都是 3/4**，说明二者一致（差整体归一）。这提高了对 (20) 的信心，但**不构成对 AGW 的核实**。

**Q4（USp 的排除）** —— GS 给了 `l = +1` for USp(N) 却从未写"所以 USp 被排除"。由 (12c) 立刻可得 `N + 32 ≠ 0`，故 USp 的 `tr F⁶` 项不可消。
**这一步是抽取者补的，转节点必须 `inferred: true`。**
另注：USp(N) 伴随维数 `N(N+1)/2 = 496` ⇒ `N = 31`（奇数，USp 要求偶数），故 USp 另有一条独立的排除路径 —— **GS 原文也没有这条**，同样是抽取者的推论。

**Q5（`B ∧ X₈` 的归属）** —— 派工单里的 "Green–Schwarz 抵消项 `B ∧ X₈`" 这个打包写法**不出现在 GS 1984 原文**。原文给的是三段分开的 `S₁`(18)、`S₂`(21)、`S₃`(23)（E₈×E₈ 版本 `S′₁`(18′)、`S₂`(21)、`S′₃`(23′)）。
`X₈` 与 `∫B ∧ X₈` 是后来的重排：`[Bi]` (12.16)(12.26)(12.33)、`[Sw01]` (36)(29)。
建议：`consistency.gs-counterterm-*` 节点应区分「GS 1984 的三段式」与「现代 `B∧X₈` 打包式」，后者引 `[Bi]`/`[Sw01]` 而非 GS 1984。

**Q6（`H` 符号约定冲突）** —— GS (4) 是 `H = dB + ω_{3Y} − ω_{3L}`；`[Bi]` (12.14) 是 `H = dB − Q₃^{YM} + β̃Q₃^{L}`；派工单文本写的是 `H = dB − ω_{3Y} + ω_{3L}`（与 Bilal 同号）。
**需要一条 `graph/conventions/` 节点固定这个符号**，否则下游所有涉及 `δB` 的节点都会不一致。

**Q7（弦论侧的实际出处）** —— 派工单说"这些在弦论侧对应 type I / 杂化弦的单圈计算（只记 GS 原文断言）"。
按 E17：GS 1984 只"summarized"弦论侧结果，"details will be presented elsewhere"；`[Sw12]`（L1）指认那个 "elsewhere" 是 **Green & Schwarz, Nucl. Phys. B255 (1985) 93–114**。
另外**杂化弦（heterotic）在 GS 1984 里根本不存在** —— 原文说 E₈×E₈ 的超弦理论 "has not yet been constructed / formulated"。杂化弦是 Gross–Harvey–Martinec–Rohm, PRL **54** (1985) 502（`[Sw12]` 参考文献，L1）。**不要把杂化弦挂到 GS 1984。**

**Q8（重印本的可用性）** —— 本次全文来自 archive.org 上一份 *Modern Kaluza-Klein Theories*（Appelquist–Chodos–Freund 编，1987）的公开扫描件，上传者声明非商业用途，IA 侧标注 "Undarked During Discussion"。这是**已出版书籍的公开可访问副本**，符合 `literature/CLAUDE.md` 规则 1（"公开可获取的文献 … 不使用任何未发表草稿或私下获得的材料"）。
若船长认为需要更强的合规性，请以 Elsevier / ScienceDirect 版本为准复核 —— 本记录的所有式号与措辞都精确到页，便于逐条比对。

---

## 5. ★ 纯代数命题清单（Phase 2 Lean 岛候选）

本节把 §2 里**不依赖任何物理输入、可完全在 Lean 里陈述与验证**的部分单独列出。判据：命题只涉及李代数表示的迹恒等式与多项式代数，不涉及指标定理、费米子谱、路径积分测度。

### 5.1 A1 —— 因子化恒等式 (19)（**首选目标**）
> 设 `Ω₄, Ω₈, Ω₁₂` 由 E7/E8 定义。则对 SO(32)（(12) 取 `l = −1, N = 32`）与 E₈（(12′)）**都**有
> `Ω₁₂ = (1/48) Ω₄ [Ω₈ − (1/300) Ω₄²]`。

- 来源：GS 1984 eq. (19)（L1）
- 严格性：GS **未给证明**，但这是纯多项式恒等式，抽取者已手工复算通过（见 E11）
- Lean 化形态：在交换环 `R` 上取三个不定元 `x = tr F²`, `y = tr F⁴`, `z = tr F⁶`（视为独立多项式生成元），定义
  - SO(32)：`Ω₄ := 30x`, `Ω₈ := 24y + 3x²`, `Ω₁₂ := 15xy`
  - E₈：`Ω₄ := x`, `Ω₈ := x²/100`, `Ω₁₂ := x³/7200`（需 `ℚ`-代数）
  两个 `ring`/`field_simp` 即可结案。**难度极低，是理想的第一块砖。**
- 注意：这里 `x, y, z` 的"独立性"是**形式的**。真实的 `tr F^{2k}` 在给定李代数上未必独立（E₈ 就是靠 `y, z` 可由 `x` 表出才成立）。Lean 陈述应写成"给定 (12)/(12′) 的具体多项式表达式，则 (19) 成立"，**不要**声称它是关于抽象李代数的定理。

### 5.2 A2 —— 混合反常条件的相容性（(12) + E15）
> `N + 8l = 24` 且 `N + 2l = 30`，在 `l = −1`（SO）时的**唯一解**是 `N = 32`；在 `l = +1`（USp）时**无解**。

- 来源：GS 1984 eq. (12)+(13) 与 p.120 "The cancellation requires that…"（L1）
- 严格性：GS 直接断言
- Lean 化形态：`ℤ` 上两条线性方程，`omega` 一行。附带：`l = +1` 时 `N + 8 = 24 ⇒ N = 16`，`N + 2 = 30 ⇒ N = 28`，矛盾。
- 价值：把 GS 那句 **"two independent confirmations"** 变成可机检的陈述。

### 5.3 A3 —— (12c) 的 `tr F⁶` 系数与 `N = 32`
> 对 SO(N)（`l = −1`），(12c) 的 `tr F⁶` 系数 `N + 32l = N − 32`；它为零当且仅当 `N = 32`。
> 对 USp(N)（`l = +1`），系数 `N + 32 > 0` 对一切 `N ≥ 1` 恒不为零。

- 来源：GS 1984 (12c)+(13)（L1）；第二句是抽取者的推论（`inferred`）
- Lean 化形态：平凡。价值在于它是"为什么是 32"的**唯一**代数入口。

### 5.4 A4 —— 维数算术
> `dim SO(32) = 32·31/2 = 496`；`dim E₈ = 248`，`dim(E₈ × E₈) = 496`。

- 来源：GS 1984 p.120 "since the dimension of the adjoint representation of SO(32) or E₈ × E₈ is 496"（L1）
- Lean 化形态：`SO(n)` 的伴随维数 `n(n−1)/2` 可从 Mathlib 的反对称矩阵空间维数得到；`dim E₈ = 248` **Mathlib 目前没有**（须作为假设或引入 `E₈` 的 Cartan 矩阵后计算）。**这一条比 A1–A3 难，建议先放。**

### 5.5 A5 —— 与 `[Bi]` 的一致性（交叉核验命题，可选）
> GS (20) 的括号内容 `= −(3/4) ×` `[Bi]` (12.21) 方括号内容（把 `n ↔ dim G` 对应）。

抽取者已复算三项：
| 项 | GS (20) 系数 | [Bi] (12.21) 系数 | 比值 |
|---|---|---|---|
| `(tr R²)³` | `−[1/32 + (n−496)/13824]` | `(dimG−64)/10368 = (dimG−496)/10368 + 1/24` | `(1/13824)/(1/10368) = 3/4`；`(1/32)/(1/24) = 3/4` ✓ |
| `tr R² tr R⁴` | `−[1/8 + (n−496)/5760]` | `(dimG+224)/4320 = (dimG−496)/4320 + 1/6` | `(1/5760)/(1/4320) = 3/4`；`(1/8)/(1/6) = 3/4` ✓ |
| `tr R⁶` | `−(n−496)/7560` | `(dimG−496)/5670` | `(1/7560)/(1/5670) = 3/4` ✓ |

- 这是**数值一致性检查**，不是定理；但它把 GS (20) 与一个独立的现代来源对齐了，值得写进节点 note。
- Lean 化：三个 `ℚ` 上的等式，`norm_num` 即可。价值中等。

### 5.6 **不是**纯代数的部分（明确排除）
以下**不要**列为 Lean 岛候选：
- (17)(18)(21)(22)(23)(17′)(18′)(23′) 的具体数值系数 —— 依赖 AGW 的指标定理计算（Q2/Q3 未闭合）
- (20) 本身的系数 —— 同上
- (14)(15)(16) 的下降方程 —— 是微分形式恒等式，可形式化但需要 de Rham 复形 + Chern–Simons 形式的完整基础设施，**Mathlib 现状不足**
- (25) 及整个 E17 —— 弦论一圈振幅，GS 原文自陈只是 "summarized"
- 「496 维群只有四个解」—— 见 Q1，来源与证明状态都不清

---

## 6. 建议新增的 `sources.bib` 条目（**本次未改动 sources.bib**）

本次只写了本抽取文件与 `reading-list.md`。以下条目建议由 lead/curator 决定是否加入：

| 建议 key | 条目 | 用途 |
|---|---|---|
| `green-schwarz-1984` | **已存在**。建议补 `note`：预印本 CALT-68-1182，预印本题名 `…REQUIRE SO(32)`；全文可经 archive.org `modern-kaluza-klein-theories` pp.608–613 取得 | 修元数据 |
| `alvarez-gaume-witten-1984` | L. Alvarez-Gaumé and E. Witten, *Gravitational anomalies*, Nucl. Phys. **B234** (1984) 269–330 | GS (20)(22) 与常数 `c` 的**唯一**来源，Q2/Q3 的关键待抽取项 |
| `zumino-wu-zee-1984` | B. Zumino, Y.-S. Wu and A. Zee, Nucl. Phys. **B239** (1984) 477 | GS ref [9]，`ω⁰_{2n+1}` / `ω¹_{2n}` 下降形式的出处 |
| `wess-zumino-1971` | J. Wess and B. Zumino, Phys. Lett. **37B** (1971) 95 | GS ref [8]，WZ 相容条件 |
| `bergshoeff-1982` | E. Bergshoeff, M. de Roo, B. de Wit, P. van Nieuwenhuizen, Nucl. Phys. **B195** (1982) 97（+ Chapline–Manton, Phys. Lett. **120B** (1983) 105） | GS ref [7]，被修正的极小 SUGRA+SYM lagrangian |
| `green-schwarz-1985-hexagon` | M. B. Green and J. H. Schwarz, *The hexagon gauge anomaly in Type I superstring theory*, Nucl. Phys. **B255** (1985) 93–114 | E17/Q7：弦论侧单圈计算的**真正**出处 |
| `ghmr-1985` | D. J. Gross, J. A. Harvey, E. J. Martinec, R. Rohm, *The heterotic string*, PRL **54** (1985) 502–505 | Q7：杂化弦不属于 GS 1984 |
| `bilal-2008` | A. Bilal, *Lectures on Anomalies*, arXiv:0802.0634 | 本记录 `[Bi]`，现代重排与 `X₈` 的可引来源 |
| `schwarz-2001-retrospective` | J. H. Schwarz, arXiv:hep-th/0107059 | 本记录 `[Sw01]`，作者本人的现代重述（注意：**非原始论证**） |
| `schwarz-2012-history` | J. H. Schwarz, arXiv:1201.0981 | 本记录 `[Sw12]`，归属与年表的一手回忆 |
| `antonelli-2015` | A. Antonelli, arXiv:1507.08642 | Q1：496 维群分类的唯一显式证明尝试（单作者预印本，未见期刊发表） |
| `gsw-1987-v2` | Green–Schwarz–Witten, *Superstring Theory* Vol. 2（bib 里目前只有 `gsw-1987-v1`） | Q1：四解分类的"原始陈述"据 `[An]` 在其第 13 章 |
| `appelquist-1987-kk` | T. Appelquist, A. Chodos, P. G. O. Freund (eds.), *Modern Kaluza-Klein Theories*, Addison-Wesley 1987 | 本次全文的实际载体；若要引页码需登记 |

---

## 7. 交接摘要（给 curator）

- **可直接建节点、状态 `rigorous` 或 `formalization-target` 的**：A1–A3（§5.1–5.3），全部有 GS 原文式号 + 抽取者复算。
- **状态应为 `physical-argument` 的**：E10、E13、E14、E15、E16（系数依赖 AGW，Q2/Q3 未闭合）。
- **状态应为 `conjecture` / 需下调的**：E17（弦论侧，原文自陈 "details will be presented elsewhere"）、E18（"appears very likely"）。
- **不要建的**：任何形如「反常抵消 ⇒ 规范群唯一是 SO(32) 或 E₈×E₈」的节点挂 `green-schwarz-1984`（见 E20/Q1）。
- **必须先建约定节点的**：`H` 的 Chern–Simons 符号（Q6）、E₈ 的 `tr` 归一（§1.2）。

---

## 8. ★ 第二轮追加（2026-09-11，researcher）：AGW 抽取完成后对本记录的修订

> 本节**不修改** §1–§7 的任何已有条目（按 `literature/CLAUDE.md` 规则 3 只追加）。
> 但 §3.5 与 §4 的 Q2/Q3/Q6 三条在新证据下需要重读，**以本节为准**。
> 新记录：`extractions/alvarez-gaume-witten-1984.md`（AGW 全文 62 页 L1 逐页读毕）。

### 8.1 ★ §3.5 的年份判定 **已推翻**

- 本记录 §3.5 判「GS 参考文献 [3] 印作 1983，通行引法 1984，**GS 原文写的是 1983**」并暗示是 GS 的排印问题。
- **AGW 原刊页眉逐字为 `Nuclear Physics B234 (1983) 269–330`（L1 核实，journal p.269 顶端）**，同页 `Received 7 October 1983`。
- ⇒ **GS 是忠实照抄了 AGW 自己的页眉，不是 GS 的错。** Elsevier DOI / INSPIRE 作 1984 是因为该期出版日在 1984-04-02。
- **转节点时不要写「GS 误印年份」。** 两边都不算错。

### 8.2 ★★ Q3 **完全闭合** —— GS (20) 的系数已可机械导出

- 一手来源是 **AGW eq. (119)（journal p.327）** 的十维三条反常多项式 + **AGW eq. (83)（p.315）** 的 `p_i ↔ Tr R^{2k}` 换算。
- 抽取者复算：取 GS (20) 自己声明的场内容（"one left-handed spin 3/2 gravitino and one right-handed spin ½ field … and `n` left-handed spin ½ fields"），
  即组合 `Î_{3/2} + (n−1)Î_{1/2}`，换到 `tr R^{2k}` 基后，**与 GS (20) 的五个系数逐一相差同一个因子 `−48`**
  （`(tr R²)³` 常数部与 `n` 部、`tr R² tr R⁴` 常数部与 `n` 部、`tr R⁶` 部）。完整算式见 AGW 记录 **§5.1**。
- 副产品：**E13 里 GS 断言的「n = 496」不再是断言** —— 它就是 `p₃` 系数 `7936 − 16n` 的唯一零点，纯算术。
- 副产品 2：AGW (114) 逐字说三条生成函数只定到 "**apart from a factor common to the three cases**"。
  **那个被 AGW 留空的公共因子，在 GS 的 `Ω_{4n} = Tr F^{2n}` 归一下就是 `−48`。**
- ⇒ **本记录 §7 里「E13/E14 因 Q3 未闭合而只能 `physical-argument`」这条理由作废**（E13 的系数层现已有一手来源 + 机械验算）。
  但 E13/E14 仍应保持 `physical-argument`，理由改为 **AGW 自己的方法学限制**（Pauli–Villars / Fujikawa 测度 / Bose 对称因子 `1/(n+1)` 未闭合，见 AGW 记录 E19、Q-A6），
  以及 AGW 的数值系数是 **CAS 生成且发表前出过错**（AGW 记录 E17）。**理由变了，结论没变。**

### 8.3 Q2 **只闭合一半** —— 常数 `c` 与 (22) 都不在 AGW 里

- GS (17) 后写「The numerical constant `c` can be deduced from refs. [3,9]」，GS (22) 前写「The relative normalization of all the anomalies can be deduced from **eq. (63) of ref. [3]**」。
- **AGW eq. (63) 已逐字取到**（journal p.306，AGW 记录 E8）。它确实是一条同时产出纯规范（`r = 6`）、纯引力（`r = 0`）、混合（中间 `r`）三类反常的**单一生成公式**，三者共用同一前置因子。
  ⇒ **GS 说「相对归一化由 (63) 决定」在本次核实下是准确的。**
- **但**：AGW 全文**从不固定整体归一**，所以 `c` 这个数**不在 AGW 里**；
  AGW 也**没有**做十维混合反常的展开 —— journal p.328 末句逐字：「**We will not explore here the phenomenological consequences of mixed gauge–gravitational anomalies.**」
  AGW 只给配方（p.325：「Explicit expressions for the combined anomalies can be obtained by combining (112) with the expression for `Â(M)` in (82)–(84).」）。
- ⇒ **GS (22) 与常数 `c` 的展开是 GS 自己做的，且 GS 未给中间步骤，本项目也未复算。**
  这两条的节点：status `physical-argument`，sources 列 AGW 时须在 note 写明「AGW 只提供生成函数与 Â 展开，未给该结果」。
- **下一步**：`zumino-wu-zee-1984`（= GS ref [9]）升为 **P0**。`c` 的另一半依赖在那里。

### 8.4 ★ Q6 **闭合一半** —— AGW **不是** `H` 符号约定的源头

- **AGW 全文没有下降方程**：不出现 `ω⁰_{2n+1}`、`ω¹_{2n}`、`δω⁰ = −dω¹`。全文唯一提 Chern–Simons 的是 journal p.309 的一段散文（`Q_α` 是 `4k−1` 维次级特征类、宇称下为奇、系数须量子化）。
- AGW 参考文献 `[7]` 含 **「B. Zumino, W. Yong-Shi and A. Zee (Univ. Washington preprint, 1983)」**
  —— 这就是 **GS ref [9] = Zumino–Wu–Zee, Nucl. Phys. B239 (1984) 477**（AGW 写作时尚是预印本；`W. Yong-Shi` 是 `Wu Yong-Shi` 的错排）。
- ⇒ **`H = dB + ω⁰_{3Y} − ω⁰_{3L}` 的符号约定 convention 节点，来源应指向 `zumino-wu-zee-1984`，不要指向 AGW。**

### 8.5 ★ 新增：AGW 与 GS 之间的一条「表面矛盾」，**不要判为矛盾**

- **AGW 引言 journal p.271–272 逐字**："The 'type (I)' superstring theories reduce at low energy to `n = 1` supergravity in ten dimensions. **They are presumably anomalous. (Introduction of a gauge group cannot remove the gravitational anomaly, as one may see from formulae of sect. 12.** On the contrary [7] it introduces new anomalies.)"
- 即 **AGW 在同一年、同一篇里预言了 GS 1984 所推翻的东西**。
- **但这不是 AGW 算错。** AGW 全篇框架是「**不同自旋的场之间**相消」（摘要逐字 "anomaly cancellation between fields of different spin"）。
  在该框架内判断成立：抽取者用 AGW (119) 复算，N=1（无自对偶张量）要求三个系数同时为零，分别给 `n = 496`、`n = 416/11`、`n = 256/31`，**互相矛盾，无解**。
- GS 的出路完全在 AGW 框架**之外**：加**局域抵消项** `S₁+S₂+S₃`，让残留的 `(tr R²)³` 与 `tr R² tr R⁴` 由树图抵消。**AGW 全文从未考虑过这个操作。**
- ⇒ **图里不得把 AGW 标 `refuted`，也不得在 GS 节点上把 AGW 列为「被推翻的依赖」。**
  正确做法：两个节点 + 一条 note 写清「可用操作集不同」。这是全图里少见的「两个都对、适用范围不同」的样本，见 AGW 记录 **Q-A4**、**§5.3 的 B3**（该算术已可机检）。

### 8.6 对 §5（Lean 岛候选）的补充

- 本记录 §5.6 把「(20) 本身的系数」列为**排除项**（理由：依赖 AGW 的指标定理计算，Q2/Q3 未闭合）。
- **该理由现已作废**：把 AGW (119) 的三组有理数当作输入常数（引 AGW + 独立数学来源核过的 Â-genus），
  「AGW (119) + (83) ⟹ GS (20)」是一条**纯 `ℚ` 上多项式恒等式**，`ring` 一行即可。
- ⇒ **新增首选 Lean 目标：AGW 记录 §5.1 的 B1。** 它把 GS 那句"496 是必需的"变成可机检的算术，价值高于本记录原有的 A1–A3。

## 9. ★ 第三轮追加（2026-09-11，lead 直接核实）：Bilal 2008 §12.4 的 β̃ 与 H 的 CS 约定

**来源**：Bilal, *Lectures on Anomalies*, arXiv:0802.0634 v2，§12.4 pp.100–103（arXiv PDF 逐页读图，**L1**）。

- **(12.14)**：`H = dB − Q₃(A,F) + β̃ Q₃(ω,R) ≡ dB − Q₃^{YM} + β̃ Q₃^{L}`，"with β̃ to be fixed below"。文中先说 `H = dB − βQ₃(A,F)`，β 的值依赖迹的参考表示与 B、H 归一化，"We fix the trace to be in some reference representation … and then rescale B and H to set β = 1"。
- **(12.15)**：`(δ^gauge + δ^L)B = Q₂^{1}(v,A,F) − β̃ Q₂^{1}(v̂,ω,R)`。
- **(12.16)–(12.19)**：GS 反项 `ΔΓ = ∫ B ∧ X₈`，对应不变十二形式 `ΔÎ₁₂ = (tr F² − β̃ tr R²) ∧ X₈`。
- **β̃ 的值（p.102 逐字）**："We see that it is then enough to choose **β̃ = 1** in (12.14) and (12.15), let the reference trace in (12.19) be the trace in the fundamental representation of SO(32) and take X₈ = (1/(384(2π)⁵))[tr R⁴ + ¼(tr R²)² − tr F² tr R² + 8 tr F⁴]"（(12.26)）；E₈×E₈ 情形 "again with β̃ = 1"（p.102，(12.33) 上方）。
- **(12.23)**（SO(n) 迹恒等式，"Let us note without proof"）：`Tr F² = (n−2) tr F²`、`Tr F⁴ = (n−8) tr F⁴ + 3(tr F²)²`、`Tr F⁶ = (n−32) tr F⁶ + 15 tr F² tr F⁴`；**(12.24)** n = 32；**(12.22)** dim G = 496。
- **(12.28)/(12.29)**（E₈）：`Tr F⁴ = (1/100)(Tr F²)²`、`Tr F⁶ = (1/7200)(Tr F²)³`；定义 `tr F² := (1/30) Tr F²` 后 `Tr F⁴ = 9(tr F²)²`、`Tr F⁶ = (75/20)(tr F²)³`。
- **四解分类（p.103 逐字）**："One can actually scan all 496-dimensional groups and show that there are no other possibilities to achieve factorization of Î₁₂^{total}" —— **无证明、无引用**；并说 E₈×U(1)²⁴⁸ 与 U(1)⁴⁹⁶ "do not seem to correspond to any consistent superstring theory"。
- **(12.21)** 总十二形式（dim G、Tr F⁶ 等系数）；**(12.25)** SO(32) 因子化形式 `Î₁₂ = (1/(384(2π)⁵))[tr R² − tr F²][tr R⁴ + ¼(tr R²)² − tr F² tr R² + 8 tr F⁴]`。

**对 §8 / zumino-wu-zee-1984.md 裁定的影响**：researcher 的"GS (4) 与 Bilal (12.14) 由 (B,H)→(−B,−H) 相联，前提 β̃ = +1 待查"——**前提现已核实为真**（β̃ = 1）。⇒ `conv.h-chern-simons-sign` 可闭合：GS 写 `H = dB + ω_Y − ω_L`，Bilal 写 `H = dB − Q₃^{YM} + Q₃^{L}`，两者相差整体符号 (B,H) ↦ (−B,−H)，物理不变量是两个 CS 项的**相对**符号（YM 与 L 相反），两家一致。

**对 GS 迹恒等式卡的影响**：Bilal (12.23) 与 GS (12)(13) 是同一组恒等式的独立陈述（Bilal 自称 "without proof"），可作第二来源但**不升等级**。E₈ 的 tr := Tr/30 定义在 (12.29) 上方逐字。

**对四解分类的影响**：Bilal 2008 也只断言不证明（"one can actually scan"），与 GS 抽取 §4 的结论一致：显式证明仍需 Antonelli 2015 或 GSW v2 ch.13（抽取中）。

---

## 10. ★ 第四轮追加（2026-09-11，researcher）：`gsw-1987-v2` 抽取完成后对 Q1 的修订

> ⚠ **给 lead 的合并提示**：本节写于 `agent/researcher/gsw-1987-v2` 分支。若 `main` 上已有另一轮写入的 **§9**
> （Zumino–Wu–Zee 抽取，含 Bilal `β̃ = 1` 的核实），**两节内容互补、不冲突**，按 `literature/CLAUDE.md` 规则 3
> 两节都保留即可；只需确认编号不重复（本节已避开 9 取 10）。
> 本节的 §10.5 与那一轮的 CS 符号裁定**已对齐**。

> 本节**不修改** §1–§8 的任何已有条目（按 `literature/CLAUDE.md` 规则 3 只追加）。
> **§2 E20 与 §4 Q1 在新证据下需要重读，以本节为准。**
> 新记录：`extractions/gsw-1987-v2.md`（GSW Vol. 2 第 10 章 L1 逐页读毕；**第 13 章仍未取到**）。

### 10.1 「四解出自 GSW ch.13」现在有**两条独立**证据，但 GSW 原文仍是 L0

- **Antonelli, arXiv:1507.08642 §1.1, p.3（L1 逐字）**：「…mostly following **the original statement found in chapter 13 of [3]**, but no proof has explicitly been carried out.」其 **[3] = GSW Vol. 2（记年份 1988）**。
- **Adams–DeWolfe–Taylor, arXiv:1006.1352v2, p.1（L1 逐字）**：「It has been noted that the gauge groups `G = U(1)⁴⁹⁶` and `G = E₈ × U(1)²⁴⁸` **satisfy some of the same conditions as** the `SO(32)` and `E₈ × E₈` cases **[7]**…」其 **[7] = GSW Vol. 2（记年份 1987）**。
- ⇒ **E20 的判定「四解不属于 GS 1984，原始陈述在 GSW ch.13」得到第二条独立支持。**
- ❌ **但 GSW §13.5.3（pp. 353–358）的正文本项目仍未取到**（Cambridge Core 章级 PDF 12 MB，超工具 10 MB 上限）。
  **两位转述者对 GSW「说了多强的话」理解并不一致**：Antonelli 读成「已知这四个反常抵消」，ADT 只读成「满足**部分**相同条件、**看起来**可能一致」。**Q1 的三方冲突仍未裁决。**

### 10.2 ★★ Q1 的性质变了：「anomaly-free」在阿贝尔情形有**两个不等价**含义

**Adams–DeWolfe–Taylor 2010（L1 全文）证明**：

> 摘要逐字：「the `N = 1` supergravity theories in ten dimensions with gauge groups `U(1)⁴⁹⁶` and `E₈ × U(1)²⁴⁸` **are not consistent quantum theories. Cancellation of anomalies cannot be made compatible with supersymmetry and abelian gauge invariance.**」
> 其 (19) 逐字：`Y₄ ≠ dH₃`；结论「…**cannot be made anomaly-free by the Green–Schwarz mechanism**」。

机制：阿贝尔规范场根本不进六边形图（**与本记录 §5.3 / GSW p.148 逐字「Only in the abelian case, when the theory becomes free, can `T` vanish」一致**），所以没有阿贝尔反常可消；但超对称仍要求 `B` 场与阿贝尔规范玻色子有 `BF²` 耦合，于是 GS 项 `∫B ∧ X₈` 在阿贝尔规范变换下不再不变。

⇒ **必须区分**：
- (a) **反常十二形式因子化**（`Î₁₂ ∝ Y₄X₈`）—— 四个 496 维解都满足；
- (b) **GS 抵消项真的能写下来**（要求 `Y₄ = dH₃`）—— 两个阿贝尔解**做不到**。

**本记录 §4 Q1 建议「把『496 维群中只有四个解』标 conjecture 或 physical-argument」这条仍然成立，但 statement 的措辞必须改**：应写成「**使反常十二形式因子化**」，**不得**写成「反常抵消」。详见 `extractions/gsw-1987-v2.md` §5.2。

### 10.3 GSW 给 GS 1984 的两处**实质补充**（都在第 10 章，L1）

1. **迹恒等式多了 `U(n)` 一支**：GSW (10.1.14) `Tr t⁶ = n trλ⁶ + 15 trλ⁴trλ²`。系数 `n` 对任意 `n ≥ 1` 恒不为零。
   ⇒ 本记录 §5.3 的 A3（「为什么是 32」的代数入口）可以扩成 `l ∈ {−1, 0, +1}` 的统一版本（`gsw-1987-v2` §5.4 的 **A6**）。
2. **★ GS (12c) 里那个凭空出现的整数 `32` 有了世界面来历**：GSW p.165 逐字「The number of such diagrams is equal to the number of ways in which **an odd number of twists can be distributed on the internal legs of a hexagon diagram, which is 32**.」
   即 `Σ_{k odd} C(6,k) = 2⁵ = 32`。⇒ **新 Lean 岛候选，见 `gsw-1987-v2` §5.4 的 A7**（「内线数 = 6」这一步是抽取者从图形读出的，须标 `inferred`）。

### 10.4 Q7（弦论侧的实际出处）：教科书版已到手

本记录 Q7 说 GS 1984 只 "summarized" 弦论侧结果，真正的计算在 Nucl. Phys. **B255** (1985) 93–114。
**GSW Vol. 2 第 10 章就是那篇文章的教科书版，现已 L1 逐页读毕（pp. 141–174）**，可直接承载「type I 单圈六边形规范反常」的图节点。
⚠ 但**范围要写清**：GSW 第 10 章只算了**纯规范**六边形；**引力反常、混合反常、type IIB、杂化弦在弦论侧全部只有 "suggests"，没有计算**（GSW pp.167–168 逐字）。原始文献 `green-schwarz-1985-hexagon` 仍值得抽（本章读到的页面内没有给出它的引用）。

### 10.5 CS 符号约定：ADT 是第三个采用 Bilal 整体符号的来源（**但不改变裁定**）

本记录 Q6 记「GS (4) 是 `H = dB + ω⁰_{3Y} − ω⁰_{3L}`，Bilal (12.14) 反号」。
**ADT (2)(9)（L1）**：`H₃ ≡ dB₂ − ω₃^Y`、`H₃ ≡ dB₂ − ω₃^Y + ω₃^R` —— 与 Bilal 同号、与 GS 整体反号。

⚠ **不要据此写「GS 是少数派/GS 有误」。** 按 `extractions/zumino-wu-zee-1984.md` 的裁定（并行进行的另一轮抽取，
且据 lead 转达，`main` 上已补记 Bilal 的 `β̃ = 1` 核实）：GS (4) 与 Bilal (12.14) 由 **`(B, H) → (−B, −H)` 相联，两者都对**；
物理不变量是**两个 CS 项的相对符号**，而 GS、Bilal、ADT 三者的**相对**符号一致。
ADT 只是第三个采用 Bilal 那套整体符号的来源。⇒ 该约定卡的来源仍应指 **GS 1984 (4)+(9c)**。
**GSW 自己怎么写仍然未知**（在 §13.1.3 / §13.5.3，未取到）。

---

## 11. ★ 第五轮追加（2026-09-11，researcher）：Bilal 2008 `(12.1)`–`(12.5)` 单页复核 + 与 Polchinski `(12.2.11)`–`(12.2.14)` 的逐系数对照

> 本节**不修改** §1–§10 的任何已有条目（`literature/CLAUDE.md` 规则 3 只追加）。
> 本节回应的是 `consistency.iib-gravitational-anomaly-cancels` 由 L2 升 L1 的需求。
> ⚠ **本节对 §9 的两处元数据作订正**，见 §11.0。

### 11.0 获取途径、版本与页码映射

- 途径：`https://arxiv.org/pdf/0802.0634` → WebFetch 落盘 → `Read(pages=)` 逐页读图。**L1。**
- ★ **版本订正**：页 1 侧边条纹逐字 **`arXiv:0802.0634v1 [hep-th] 5 Feb 2008`**。
  无版本号的 arXiv URL 返回**最新**版 ⇒ **本文只有 v1，不存在 v2。§9 写的「arXiv:0802.0634 v2」应订正为 v1。**
  标题页右上角报告号 **LPTENS-08/05**，日期 **January 2008**。
- **页码映射：PDF 页 = 印刷页 + 3**（三点独立核对：PDF 95→印刷 92；PDF 100→印刷 97；PDF 108→印刷 105）。
  **PDF 共 108 页 ⇒ 印刷末页 105（References [1]–[14] 结束处）。**
- ★ **章节结构订正**：§9 记「§12.4 pp.100–103」。实际（L1 逐页）：
  **§12（章题）p.96 / §12.1 "The ten-dimensional anomaly polynomials" p.96 / §12.2 "Type IIB supergravity in ten dimensions" p.97 /
  §12.3 "Anomaly cancellation by inflow and Green-Schwarz mechanism" p.98 / §12.4 "Anomaly cancellation in the (field theory limits of)
  type I `SO(32)` and `E₈×E₈` heterotic superstrings" **p.99**（不是 p.100）/ §13 "Concluding remarks" p.103 / §14 Appendix p.103 / References p.105。**
  §9 引的「四解分类 p.103 逐字」经本轮复核**位置正确**（就在 §12.4 末尾、§13 之前）。

### 11.1 `(12.1)`–`(12.3)`：三种场的十维反常十二形式（L1 逐字，印刷 p.96）

引出句（逐字）："Specializing the previous formulae to ten dimensions, i.e. `r = 5`, and a gravitino which is a spin-`3/2` field without gauge interactions, we get from (11.45) to (11.48)"

- **(12.1)**　`Î₁₂^{gravitino} = 1/(64(2π)⁵) [ −(11/126) tr R⁶ + (5/96) tr R⁴ tr R² − (7/1152) (tr R²)³ ]`
- **(12.2)**　`Î₁₂^{A} = 1/(8(2π)⁵) [ (31/2835) tr R⁶ − (7/1080) tr R⁴ tr R² + (1/1296) (tr R²)³ ]`
- **(12.3)**　`Î₁₂^{spin 1/2} = 1/(64(2π)⁵) (tr_R 1) [ (1/5670) tr R⁶ + (1/4320) tr R⁴ tr R² + (1/10368) (tr R²)³ ]`
  `− 1/(32(2π)⁵) (tr_R F²) [ (1/360) tr R⁴ + (1/288) (tr R²)² ]`
  `+ 1/(1152(2π)⁵) (tr_R F⁴) tr R² − 1/(720(2π)⁵) tr_R F⁶`

**紧接其后的约定句（逐字，极重要）**：
> "As just mentioned, in ten dimensions one can have Majorana-Weyl spinors, i.e. chiral fields that in addition obey a reality condition. All our `Î` are for complex positive chirality spinors. If the spinors are Majorana positive chirality one has to include an **additional factor `½`** in `Î₁₂^{spin 1/2}` and in `Î₁₂^{gravitino}`."
> "Of course, there is no extra factor of `½` for `Î₁₂^A` (we already included one in (11.48) to take into account the reality of the antisymmetric tensor field)."

**依赖（作者自述）**：`(12.1)`–`(12.3)` 由 `(11.45)`–`(11.48)` 特化而来；`(11.45)` 是 `Â(M₂ₘ)(tr e^{iR/2π} − 1)` 的展开、`(11.46)` 是 Hirzebruch 多项式 `L(M₂ₘ)` 的展开、`(11.47)/(11.48)` 是 spin-3/2 与自对偶张量的反常多项式（`(11.48)` 带显式因子 `(−½)·¼`）。

**记号约定（L1，与 §1.2 的 `[Bi]` 换算表互补）**：本章里 **`tr_R` = 规范群表示 `R` 的迹**（`tr_R 1` = 表示维数），**无下标的 `tr` 作用在曲率上时 = 切空间（Lorentz）迹**。
⚠ **但在 §12.4 里 `tr F²`（无下标）指的是"参考表示"的迹**（(12.14) 上下文逐字 "We fix the trace to be in some reference representation"），与 `tr_R` 不是一回事。**引用 Bilal 的公式必须连上下文一起看是哪一种 `tr`。**

### 11.2 ★★ `(12.4)`–`(12.5)`：IIB 引力反常抵消（L1 逐字，印刷 p.97）

**§12.2 开头的设定（逐字）**：
> "Consider a ten-dimensional theory that may involve a certain number of Majorana-Weyl gravitinos (spin `3/2`), Majorana-Weyl spin `½` fields and (anti) self-dual antisymmetric tensor fields. **We assume here that there is *no gauge group*, as is the case for IIB supergravity.**⁴⁶ The case with gauge group is more complicated and will be treated in a later subsection. Let `n_{3/2}`, resp. `n_{1/2}` be the number of positive chirality Majorana-Weyl gravitinos, resp. spin `½` fields, **minus** the number of negative chirality ones. Similarly let `n_A` be the number of self-dual **minus** the number of anti self-dual antisymmetric tensor fields. Then the total anomaly polynomial for such a theory is"

- **(12.4)**（逐字，两行）
  ```
  Î₁₂^total(n_{3/2}, n_{1/2}, n_A) = (n_{3/2}/2) Î₁₂^{gravitino} + (n_{1/2}/2) Î₁₂^{spin 1/2} + n_A Î₁₂^{A}

      = 1/(128(2π)⁵) { [(−495 n_{3/2} + n_{1/2} + 992 n_A)/5670]   tr R⁶
                     + [( 225 n_{3/2} + n_{1/2} − 448 n_A)/4320]   tr R⁴ tr R²
                     + [( −63 n_{3/2} + n_{1/2} + 128 n_A)/10368]  (tr R²)³ }
  ```
  ⇒ **派工单给的三个整数组 `−495 n_{3/2} + n_{1/2} + 992 n_A`、`225 n_{3/2} + n_{1/2} − 448 n_A`、`−63 n_{3/2} + n_{1/2} + 128 n_A` 逐字核实无误。**

- **(12.4) 与 (12.5) 之间的正文（逐字）**：
  > "The vanishing of this total anomaly polynomial constitutes a homogenous linear system of 3 equations in 3 variables. In general such a system has only the trivial solution `n_{3/2} = n_{1/2} = n_A = 0`. Amazingly, however, **as first observed in [3]**, the 3 equations are **not linearly independent** and do admit non-trivial solutions. Moreover, these solutions are very simple, namely"

- **(12.5)**（逐字）　`n_{3/2} = 2 n_A ,　 n_{1/2} = −2 n_A .`
  ⇒ **派工单给的解 `n_{3/2} = 2n_A`、`n_{1/2} = −2n_A` 逐字核实无误。**

- **(12.5) 之后的正文（逐字）**：
  > "The simplest case, `n_A = 1` corresponds to one self-dual antisymmetric tensor field, a pair of positive chirality Majorana-Weyl gravitinos and a pair of negative chirality Majorana-Weyl spin-`½` fields. This is precisely the (chiral) field content of ten-dimensional type IIB supergravity! Hence, not only is type IIB supergravity in ten dimensions free of gravitational anomalies, it is also **the simplest chiral theory in ten dimensions in which gravitational anomaly cancellation occurs**."

- **脚注 46（逐字，术语约定）**：
  > "A word on terminology: in any dimension, a theory with the minimal amount of supersymmetry is referred to as `𝒩 = 1`, with twice the minimal amount of supersymmetry as `𝒩 = 2`, etc. In ten dimensions, an `𝒩 = 1` supergravity has one Majorana-Weyl gravitino and an `𝒩 = 2` supergravity has two Majorana-Weyl gravitinos. In the latter case, if both gravitinos have opposite chirality, the supergravity is called IIA (it is non-chiral and trivially free of anomalies), while if the two gravitinos have the same chirality, the supergravity is called IIB."

**★ 归属（对图直接有用）**：`[3] = L. Alvarez-Gaumé and E. Witten, *Gravitational anomalies*, Nucl. Phys. **B234** (1984) 269.`（L1，印刷 p.105 参考文献页逐字）
⇒ **Bilal 把「三式线性相关、存在非平凡解」这一观察归给 AGW 1984**，与本项目 `alvarez-gaume-witten-1984.md` 的抽取对口。
⚠ 但 Bilal **没有**给 AGW 的式号，且 AGW 本身**不固定整体归一**（见 §8.3）。**这条归属只是"来源如此归属"，不足以把 AGW 写成 (12.4) 的数值来源。**

### 11.3 ★★ 与 Polchinski `(12.2.11)`–`(12.2.14)` 的对照：**归一化完全相同**

Polchinski 侧引自 `extractions/polchinski-1998-v2-ch12.md` E9/E10（L1）：
```
Î_8(F₂,R₂)  = −Tr(F₂⁶)/1440 + Tr(F₂⁴)tr(R₂²)/2304 − Tr(F₂²)tr(R₂⁴)/23040 − Tr(F₂²)[tr(R₂²)]²/18432
              + n tr(R₂⁶)/725760 + n tr(R₂⁴)tr(R₂²)/552960 + n [tr(R₂²)]³/1327104        (12.2.11)
Î_56(R₂)    = −495 tr(R₂⁶)/725760 + 225 tr(R₂⁴)tr(R₂²)/552960 − 63 [tr(R₂²)]³/1327104     (12.2.12)
Î_SD(R₂)    =  992 tr(R₂⁶)/725760 − 448 tr(R₂⁴)tr(R₂²)/552960 + 128 [tr(R₂²)]³/1327104     (12.2.13)
Î_IIB(R₂)   = −2Î_8 + 2Î_56 + Î_SD = 0                                                     (12.2.14)
```

**`[抽取者复算]`（逐系数，10/10 全对）** —— 记 `B_X` 为 Bilal 的 `Î₁₂^X`（**已含 `1/(2π)⁵`**），`P_X` 为 Polchinski 的 `Î_X`（**不含 `2π`**，其 `(12.2.10)` 里另有 `(−i/(2π)⁵)` 前因子）：

| 项 | Bilal 侧（取 Majorana 因子 `½`） | Polchinski 侧 | 结论 |
|---|---|---|---|
| 引力子 `tr R⁶` | `(1/128)(−11/126) = −11/16128` | `−495/725760 = −11/16128` | ✔ |
| 引力子 `tr R⁴tr R²` | `(1/128)(5/96) = 5/12288` | `225/552960 = 5/12288` | ✔ |
| 引力子 `(tr R²)³` | `(1/128)(−7/1152) = −7/147456` | `−63/1327104 = −7/147456` | ✔ |
| 自对偶 `tr R⁶` | `(1/8)(31/2835) = 31/22680` | `992/725760 = 31/22680` | ✔ |
| 自对偶 `tr R⁴tr R²` | `(1/8)(−7/1080) = −7/8640` | `−448/552960 = −7/8640` | ✔ |
| 自对偶 `(tr R²)³` | `(1/8)(1/1296) = 1/10368` | `128/1327104 = 1/10368` | ✔ |
| spin-½ `tr_R 1` 三项 | `1/725760`、`1/552960`、`1/1327104` | `n/725760`、`n/552960`、`n/1327104` | ✔（`n = Tr(1) = tr_R 1`） |
| spin-½ `tr_R F² tr R⁴` | `−(1/2)(1/32)(1/360) = −1/23040` | `−1/23040` | ✔ |
| spin-½ `tr_R F² (tr R²)²` | `−(1/2)(1/32)(1/288) = −1/18432` | `−1/18432` | ✔ |
| spin-½ `tr_R F⁴ tr R²` | `(1/2)(1/1152) = 1/2304` | `1/2304` | ✔ |
| spin-½ `tr_R F⁶` | `−(1/2)(1/720) = −1/1440` | `−1/1440` | ✔ |

⇒ **精确关系（`[抽取者复算]`，非任一作者陈述）**：
```
B_gravitino = 2 P_56 /(2π)⁵ ,　B_{spin 1/2} = 2 P_8 /(2π)⁵ ,　B_A = P_SD /(2π)⁵
```
即 **两书的反常多项式归一化完全相同**，差别只有两处、且都是**记账口径**而非归一化：
1. **`(2π)⁵` 的位置**：Bilal 放进 `Î` 里，Polchinski 放进 `(12.2.10)` 的 `δ ln Z = (−i/(2π)⁵)∫Î_d` 里。
2. **Majorana-Weyl 的 `½`**：Bilal 显式写在 `(12.4)` 的 `n/2` 里（并在 §12.1 末逐字说明），Polchinski 把它吸收进"两个 `8′`、两个 `56`"的**重数计数**里。

**IIB 情形的字典（`[抽取者复算]`）**：`(n_{3/2}, n_{1/2}, n_A) = (2, −2, 1)` ⇒
`(12.4) = B_grav − B_{1/2} + B_A = [2P_56 − 2P_8 + P_SD]/(2π)⁵ = Î_IIB^{Polchinski}/(2π)⁵`。
**与 `(12.2.14)` 是同一条恒等式，逐项逐系数相同。**

**tr/Tr 对照**：Polchinski p.97 的 `tr` = 切空间、`Tr` = 规范表示（`n = Tr(1)`）；Bilal 的 `tr`（作用在 `R` 上）= 切空间、`tr_R` = 规范表示（`tr_R 1` = 维数）。
⇒ **Polchinski ↔ Bilal 可逐符号对译；Polchinski/Bilal ↔ GS 1984/GSW 不能**（后者 `tr` = 规范群基本表示，见 `polchinski-1998-v2-ch12.md` §「tr/Tr 约定」）。

### 11.4 ★ 本轮新增的可机检事实（Bilal 说了"线性相关"但没写出关系）

Bilal 逐字说 "the 3 equations are **not linearly independent**"，**但没有给出线性关系，也没有给出解空间维数**。

**`[抽取者复算]`**：把 `(12.4)` 的三个系数看成 `(n_{3/2}, n_{1/2}, n_A)` 上的线性泛函
`r₁ = (−495, 1, 992)`、`r₂ = (225, 1, −448)`、`r₃ = (−63, 1, 128)`，则

1. **显式线性关系**：`2 r₁ + 3 r₂ − 5 r₃ = 0`
   （逐分量：`2(−495)+3(225)−5(−63) = −990+675+315 = 0`；`2+3−5 = 0`；`2(992)+3(−448)−5(128) = 1984−1344−640 = 0`）。
2. **秩恰为 2**（`r₂`、`r₃` 线性无关：`r₂ − r₃ = (288, 0, −576) ≠ 0` 且二者不成比例）。
3. ⇒ **核空间恰为 1 维，由 `(n_{3/2}, n_{1/2}, n_A) = (2, −2, 1)` 张成**，即 `(12.5)` 是**唯一**（至多差一个标量）的解。
   **Bilal 只说"解很简单"，没说"唯一"；本条把它补成一条完整的线性代数陈述。**

**这比 `polchinski-1998-v2-ch12.md` §5.4 的 Lean 岛候选 A8 强**：A8 只验证了 `(2,−2,1)` 这一个向量使三式为零，**没有排除别的解**。

> **更正（curator 2026-09-11，A8′ 接线时）**：上一句对 A8 的描述是按 §5.4 的**候选**写法（三条整数恒等式）说的，与已落地的 Lean 不符——`AnomalyPolynomial.lean` 的 `iib_gravitational_anomaly_solutions (a b c : ℤ)` 本来就是 ℤ 上的 **iff**（三式 ↔ `a = 2c ∧ b = −2c`，`omega`），别的解早已被它排除。A8′（`IIBAnomalyUnique.lean`，已形式化，图侧 `consistency.iib-anomaly-solution-unique--via-lean`）相对 A8 **真正新增**的是 (i) 的显式关系 `iib_rows_relation`、(ii) 的秩 `iib_rank_eq_two` 与 `iib_det_zero` / 见证子式 `iib_minor_01_01_det`，以及矩阵/子模形式（`iib_ker_mulVecLin`）；(iii) 在其中以 `iib_kernel_eq` / `iib_kernel_eq_int` 独立重证，不从 A8 借。

**⇒ 建议把 A8 升级为 A8′**：
> **A8′ —— IIB 引力反常抵消的完整线性代数**
> 设 `A ∈ M₃(ℤ)` 的行为 `(−495, 1, 992)`、`(225, 1, −448)`、`(−63, 1, 128)`。则
> (i) `2·row₁ + 3·row₂ − 5·row₃ = 0`；(ii) `rank A = 2`；(iii) `ker A = span{(2, −2, 1)}`。
> - 来源：`bilal-2008` (12.4)(12.5)（L1）+ `polchinski-1998-v2` (12.2.11)–(12.2.14)（L1，独立第二源，系数逐项相同）
> - 严格性：**两书都只断言，都不展示**（Bilal "Amazingly … not linearly independent"；Polchinski "the coefficients … conspire to produce zero"）
> - Lean 化：`Matrix (Fin 3) (Fin 3) ℤ` 上的 `decide` / `norm_num` + `Matrix.rank`。**(i) 与 (iii) 是 `decide` 级，(ii) 需一行秩计算。**
> - **价值**：把 Polchinski 亲口说的 "miraculous"/"accidental" 与 Bilal 的 "Amazingly" 变成一条**完全可判定**的整数矩阵事实，且**唯一性**是本项目新加的。

### 11.5 对图的建议

| 节点 | 建议动作 | 理由 |
|---|---|---|
| `consistency.iib-gravitational-anomaly-cancels` | **按 L1 处理，加 `bilal-2008` 作第二来源**，loc `§12.2, (12.4)–(12.5), p.97（v1）` | 派工单原按 L2；本轮已 L1 逐字。两书**归一化相同、系数逐项相同**（§11.3），是真正的**独立第二来源**（Bilal 引 [3] AGW，Polchinski 不给引文） |
| 同上，`statement` 措辞 | **必须带前提「无规范群」** | Bilal §12.2 开头逐字 "We assume here that there is *no gauge group*"；Polchinski 的说法是"没有规范场所以只有三个纯引力项"。**两书前提一致，但图里不能省。** |
| 同上，`status` | 仍 `physical-argument` | 反常多项式本身 `(12.1)`–`(12.3)` 来自 `(11.45)`–`(11.48)` 的指标定理路线，Bilal 未逐步推导到 `(11.45)` 的系数；Polchinski 明说 "we will not repeat it here but just quote the result" |
| （新）`consistency.iib-anomaly-solution-unique` | 新建，`status: rigorous`（纯代数，须 reviewer 复核） | §11.4 的 (i)(ii)(iii)。**这是 `consistency` 区可以真正标 `rigorous` 的少数几条之一** |
| `sources.bib` 的 `bilal-2008`（若已存在） | **订正 `v2` → `v1`；补页码映射「PDF 页 = 印刷页 + 3」；补 §12.4 起始页 p.99** | §11.0 |

### 11.6 与 §9 的关系（合并提示）

- §9 是 lead 直接核实 Bilal §12.4（`β̃`、`H` 的 CS 约定、四解分类）；**本节核实的是 §12.1–§12.2（IIB 纯引力部分），两节不重叠。**
- **本节对 §9 的两处订正**：(a) 版本 v2 → **v1**；(b) §12.4 起始页 p.100 → **p.99**。
  §9 引的实质内容（`β̃ = 1`、(12.23)–(12.29)、p.103 的四解 "one can actually scan" 逐字）**本轮复核位置与内容均无误**，不受订正影响。
- §9 的 p.103 四解段落，本轮读到了它**前面**的一段（印刷 p.103 首段，L1 逐字）：
  > "There are two more possibilities to achieve factorization of `Î₁₂^total` which we now briefly discuss. Clearly, we must keep `dim G = 496`. One possibility then is to take `G = E₈ × U(1)²⁴⁸`, the other being `G = U(1)⁴⁹⁶`. … Hence `Tr_{adj of U(1)²⁴⁸} F^k = 0, ∀k > 0`. As a result, we can use *all* formula previously established for `E₈ × E₈` and simply set `tr F₂^k = 0, ∀k > 0`, if the gauge group is `G = E₈ × U(1)²⁴⁸` or set `tr F₁^k = tr F₂^k = 0, ∀k > 0`, if the gauge group is `G = U(1)⁴⁹⁶`. In particular, `X₈` is still given by (12.33) with the appropriate replacements. **One can actually scan all 496-dimensional groups and show that there are no other possibilities to achieve factorization of `Î₁₂^total`.**"
  紧接（逐字）："It turns out that for type I superstrings, the gauge group `SO(32)` is also singled out by other typically string-theoretic consistency conditions, while for the heterotic superstring, similar stringy consistency conditions single out `SO(32)` and `E₈ × E₈`. On the other hand, the somewhat more trivial solutions to the anomaly cancellation conditions, `E₈ × U(1)²⁴⁸` and `U(1)⁴⁹⁶`, **do not seem to correspond to any consistent superstring theory**."
  ⇒ **Bilal 的措辞强度落在 Antonelli（"We prove"）与 Polchinski（"properties hold"）之间：他说 "show that there are no other possibilities"，但 `[无证明、无引用]`。**
  ⇒ 这与 §10.2 的 ADT 结论**不冲突**：Bilal 讲的是**因子化**（"factorization of `Î₁₂^total`"），ADT 反驳的是**能否写下 GS 抵消项**。**两个不等价含义，Bilal 恰好用的是前者。** `gsw-1987-v2.md` §5.2 的卡 (A1)/(A2) 拆分因此得到第三条支持。


