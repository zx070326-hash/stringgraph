# 抽取记录：Witten 2012–2013 超黎曼面 / 超弦微扰论系列（+ Donagi–Witten）

- 文献：见 §0.0 的「系列构成」表（多篇，共用本记录；主项是 **arXiv:1209.5461v4**）
- 抽取者：researcher agent
- 日期：2026-09-11
- 覆盖范围：**1209.5461v4** 目录 + §1 + §2.1 + §3.3–§3.6 + §6.4.6–§6.5.1 + §7.1 + §7.5–§7.6.1 + §8.3 + §9.1 + §9.4 +
  §10.1 + Acknowledgments + **全部 91 条参考文献**（逐页读图，L1）；
  **1304.2832v4** 标题页 + 目录 + §1 + §2.1（L1）；
  **1304.7798v2** 摘要 + 目录 + §1 + §2 首页（L1）。**其余全部未读，见 §3.2。**
- 任务来源：`extractions/polchinski-1998-v2-ch12.md` **E26 / Q7** —— Polchinski v2 §12.5 p.126 自承
  「a fully explicit proof of the perturbative consistency of the theory seems to be lacking」（1998），
  核实 Witten 2012–2013 系列是否填上这个缺口。**答复见 §4 QW1。**

---

## 0. 获取途径与证据等级

### 0.0 ⚠⚠ 派工单的 arXiv 号 ↔ 标题映射有误（**必须先看**，同类第三次）

派工单写「arXiv:1209.2459（"Superstring Perturbation Theory Revisited"）」「Donagi–Witten 1304.7798?」。
**按 arXiv API 与 PDF 页边条纹（均 L1）核实，正确映射如下：**

| arXiv | **真实标题**（arXiv 元数据） | 作者 | 页数 | 本轮读到什么 |
|---|---|---|---|---|
| **1209.2199** | *Notes On Supermanifolds and Integration* | Witten | 42 | 仅元数据（L2） |
| **1209.2459** | *Notes On Super Riemann Surfaces And Their Moduli* | Witten | 122 | 仅元数据（L2）。**不是** "Superstring Perturbation Theory Revisited" |
| **1209.5461** | *Superstring Perturbation Theory Revisited* | Witten | **225** | **★ 本轮主力：目录 + §1 + §3.3–3.6 + §6.4.6 + §6.5 + §7.1 + §7.5–7.6.1 + §8.3 + §9.1 + §9.4 + 全部 91 条参考文献，逐页读图（L1）** |
| **1304.2832** | *More On Superstring Perturbation Theory: An Overview Of Superstring Perturbation Theory Via Super Riemann Surfaces* | Witten | 69 | **§1 全文 + §2.1 逐页读图（L1）** |
| **1304.7798** | *Supermoduli Space Is Not Projected* | **Donagi & Witten** | 57 | **摘要 + 目录 + §1（含 Thm 1.1/1.2/1.3、Remark 1.4/1.5/1.6）+ §2 首页，逐页读图（L1）** |
| **1306.3621** | *Notes On Holomorphic String And Superstring Theory Measures Of Low Genus* | Witten | 55 | 仅元数据 + 摘要（L2）。**派工单把它写成了 1304.7798** |
| **1307.5124** | *The Feynman iε in String Theory* | Witten | 24 | 仅元数据 + 摘要（L2）。**派工单猜的号 1209.5461 是错的**（1209.5461 是主论文本身） |
| **1404.6257** | *Super Atiyah classes and obstructions to splitting of supermoduli space* | Donagi & Witten | — | 仅元数据 + 摘要（L2） |
| **1504.00609** | *Filling The Gaps With PCO's* | **Sen & Witten** | 40 | 仅摘要（L2）。**派工单没列，但它是 PCO 问题的直接后续**，见 E14 |

→ 这是继「§11 是杂化弦不是 GSO」「§12.5 是 General amplitudes 不是分类」之后**第三次**派工单前提不成立。
**建议：给多篇系列派活前，先花一次 `export.arxiv.org/api/query?id_list=...` 把号↔标题钉死。**

### 0.1 ★ 两处「arXiv 元数据标题 ≠ PDF 标题页」（本轮独立发现，均 L1）

1. **1209.5461**：arXiv API `<title>` 逐字 `Superstring Perturbation Theory Revisited`，
   而 **v4 的 PDF 标题页逐字印的是 `Perturbative Superstring Theory Revisited`**（词序不同）。
   ⇒ **bib 里登记哪一个必须写明来源**；本记录按 arXiv 元数据登记，并在 note 里记下 PDF 侧写法。
2. **1304.2832**：arXiv 元数据标题 `More On Superstring Perturbation Theory: An Overview Of …`，
   而 **v4 的 PDF 标题页是 `Superstring Perturbation Theory Via Super Riemann Surfaces: An Overview`**，
   且**作者自己在脚注 1 里逐字说明**：「The arXiv version of this article was originally entitled "More on Superstring Perturbation Theory."」
   ⇒ 这一处**不是矛盾，是作者自陈的改名**，与第 1 条性质不同。

### 0.2 版本锚定（**引式号必须写死**）

| ref | 本轮实读版本（页边条纹逐字） | arXiv comments 自陈 |
|---|---|---|
| 1209.5461 | **v4，`arXiv:1209.5461v4 [hep-th] 5 Nov 2023`** | v4「225 pp, minor clarification in this version」；v1 2012-09-25、v2 2012-11-01、v3 2018-05-08 |
| 1304.2832 | **v4，`arXiv:1304.2832v4 [hep-th] 23 Jul 2016`** | 「69 pp, relatively minor corrections and clarifications」 |
| 1304.7798 | **v2，`arXiv:1304.7798v2 [hep-th] 19 Jul 2023`**（首页页脚另印 `Date: July 21, 2023.`） | 「57 pp」；v1 2013-04-29 |

⚠ **v3/v4 是 2018 与 2023 年的修订**，其中的引文（如 [19]–[24] Sen 的场论系列、[49] Sen–Witten 2015）
**不可能出现在 2012 年的 v1 里**。本记录凡涉及这些引文的条目，**只能说明「截至 v4 作者怎么看」，不能说明 2012 年的状态**。

### 0.3 获取途径（全部一次成功，无阻碍）

`arxiv.org/pdf/<id>`（不带版本后缀 ⇒ 取到最新版）→ WebFetch 落盘 → `Read` 带 `pages` 逐页读图。
落盘体积：1209.5461 = 3.2 MB / 1304.2832 = 1.2 MB / 1304.7798 = 607 KB，**均远低于 10 MB 上限**。
元数据用 `http://export.arxiv.org/api/query?id_list=<逗号分隔>`（返回 Atom XML，逐字可读；
**一次查 6 个 id 时摘要会被中介概括器截断，需要逐字摘要就单查 `/abs/<id>`**）。

### 0.4 证据等级

| 标记 | 含义 |
|---|---|
| `[L1 5461]` | 抽取者本轮逐页读了 arXiv:1209.5461**v4** 的 PDF 页图 |
| `[L1 2832]` | 同上，arXiv:1304.2832**v4** |
| `[L1 DW]` | 同上，arXiv:1304.7798**v2**（Donagi–Witten） |
| `[L2 摘要]` | 只读到 arXiv 摘要/元数据，正文未读 |
| `[抽取者推断]` | 抽取者的比对与判断，**不是原文文字**，转节点必须标 `inferred` |

**「文献自称的严格程度」一栏全部照抄原文动词**，与既有记录同一体例。

### 0.5 页码换算

- 1209.5461：**论文页 N = PDF 第 N+4 页**（论文 p.2 = PDF p.6，已逐页验证）。
- 1304.2832：论文 p.1 = PDF p.3。
- 1304.7798：论文页码 = PDF 页码（首页即 p.1）。

---

## 1. 约定

### 1.1 ★ Witten 明说沿用 Polchinski 的约定（**对本项目最有用的一条**）

**[L1 5461, §2.1, p.4, 逐字]：**

> "We begin by recalling how the path integral of bosonic string theory generates a measure on the moduli space
> of Riemann surfaces. For standard explanations, see [29–31] or **section 5.3 of [32] (whose conventions we
> generally follow)**. The explanation that follows is chosen to extend straightforwardly to superstring theory."

其中 **[32] = "J. Polchinski, *String Theory* (Cambridge University Press, 1998)"**（`[L1 5461]` 参考文献页逐字）。

⇒ **1209.5461 与 `polchinski-1998-v1/v2` 之间不需要额外的约定换算桥**（至少在 §5.3 覆盖的 FP/模空间测度这一层）。
⚠ 但 Witten 只说 "generally follow"，**不是逐条声明**；具体式子仍需逐条比对。

### 1.2 鬼数与图像数（picture number）——**与 Polchinski §12.5 可对译**

| 项 | 1209.5461 的取法 | 证据 |
|---|---|---|
| 鬼作用量 | `I_gh = (1/2π)∫d²σ√g b_ij D^i c^j`（(2.1)） | `[L1 5461]` p.4 |
| BRST | `{Q_B, b_ij} = T_ij`（(2.2)）、`δI = (1/4π)∫d²σ√g δg_ij T^ij`（(2.3)） | 同上 |
| 玻色弦鬼数反常 | 亏格 g 上违反 `N_gh` 达 **`−(6g−6)`** | `[L1 5461]` p.4 |
| 杂化弦（全纯侧）鬼数反常 | `b,c` 给 `−(3g−3)`，`β,γ` 给 `+(2g−2)`，净 **`−(g−1)`** | `[L1 5461]` p.49 |
| **图像数** | **`δ(β)` 及其各阶导数 → picture number `+1`；`δ(γ)` 及其各阶导数 → `−1`** | `[L1 5461]` p.48–49 逐字 |
| **图像数守恒** | **「the net picture number of all operators must add up to `2g−2` in order for the path integral to be sensible」** | `[L1 5461]` p.49 逐字 |
| 顶点算符的**正则**图像数 | **NS `−1`、R `−1/2`** | `[L1 5461]` p.109 逐字 |
| `βγ` 路径积分的可判据 | `r − s = 2g − 2`（(3.107)，r = δ(β) 个数、s = δ(γ) 个数）；原文括注 **"necessary but only generically sufficient"** | `[L1 5461]` p.49 逐字 |
| 超流形侧的类比 | `dθ` 的 picture number 定为 `−1`（§3.2.1） | `[L1 5461]` p.48 |
| `α'` | 闭弦 `L_0 = (α'/4)P² + N`（§7.1 p.125） | `[L1 5461]` p.125 |

**`[抽取者推断]`（转卡须标 `inferred`）**：把 Polchinski (12.5.14) `n_X = 2g−2+n_B+n_F/2` 与本文对照 ——
Witten 的 PCO `𝒴(p)`（(3.95)）图像数为 `+1`，NS 顶点算符正则图像 `−1`、R 正则图像 `−1/2`，
净图像数守恒到 `2g−2` ⇒ 需要 `2g−2+n_B+n_F/2` 个 PCO，**与 Polchinski (12.5.14) 数值相同**。
⚠ 但两人对「图像数」的符号约定叙述方式不同，**原文没有做这个对照**，不得写成「Witten 证实了 Polchinski 的 (12.5.14)」。

### 1.3 记号

- `𝔐_g`（Witten 用 `𝔐_g` / Donagi–Witten 用 `𝔐_g`）= **超黎曼面模空间**；
  `𝒮𝔐_g`（DW）/ `ℳ_red`（Witten）= 其约化空间 = **带自旋结构的普通黎曼面模空间**。
- Witten 在杂化弦语境下写 `ℳ_L × ℳ_R`：`ℳ_R` 是超黎曼面模空间（全纯侧），`ℳ_L` 是普通黎曼面模空间（反全纯侧）。
  `[L1 5461]` p.36 逐字。
- `Γ` = **积分链（integration cycle）**，`ℳ_L × ℳ_R` 中的实余维 `p|0` 闭链，(3.61) `Z_g = ∫_Γ 𝒟(𝒥,δ𝒥) F(𝒥,δ𝒥)`。
- 超模空间维数：亏格 g 无穿孔时 `3g−3|2g−2`（复），杂化弦上算成 `6g−6|2g−2`（`[L1 5461]` p.34）。
- **`[L1 DW]` 用词区分**：`projected` = 存在到约化空间的全纯投影；`split` = 更强，纤维方向线性。
  「every split supermanifold is projected」（DW p.7 逐字）。

---

## 2. 陈述

> 编号 `EW<n>`（**W = Witten 系列**），以免与 `polchinski-1998-v2-ch12.md` 的 E1–E32 混号。
> 引用时写 `witten-2012-superstring-perturbation#EW<n>`。

### EW1 ★★★ 1209.5461 摘要（**回答派工单第 (1) 问：自陈强度**）
- 位置：arXiv:1209.5461**v4** 摘要（arXiv 元数据与 PDF 标题页文字一致）。`[L1 5461]`
- 原文（**逐字**）：

> "Perturbative superstring theory is revisited, with the goal of **giving a simpler and more direct demonstration**
> that multi-loop amplitudes are gauge-invariant (**apart from known anomalies**), satisfy space-time supersymmetry
> **when expected**, and have the **expected** infrared behavior. The main technical tool is to make the whole analysis,
> including especially those arguments that involve integration by parts, on supermoduli space, rather than after
> descending to ordinary moduli space."

- 自称严格程度：**"demonstration"**（不是 "proof"），且带三个限定：`apart from known anomalies`、`when expected`、`expected`。
- ⚠ **摘要里没有 "consistency" 一词，没有 "prove"，没有 "all orders"。**

### EW2 ★★ 1209.5461 §1 首段：论文自陈的目标
- 位置：§1, p.2。`[L1 5461]`
- 原文（逐字）：

> "Powerful covariant methods to compute superstring scattering amplitudes in the RNS formulation were introduced
> in the 1980's [1] and have been widely used ever since. But **some aspects of the formalism have remained slightly
> opaque.** In the present paper, we will revisit this subject, **aiming to give simpler and more direct demonstrations
> that** multi-loop superstring amplitudes are gauge-invariant (apart from known anomalies), satisfy space-time
> supersymmetry when expected, and have the infrared behavior that one would expect of a field theory with the same
> massless particles and low energy interactions."

- 紧接一段（逐字）：

> "These results are more transparent if superstring perturbation theory is formulated in terms of super Riemann
> surfaces and supermoduli space, rather than aiming to reduce everything to ordinary Riemann surfaces and moduli
> space. **This is not a new idea and most of the pieces of the puzzle have been described long ago.** … Finally, we
> mention a different kind of milestone; **the first completely consistent one-loop computations were performed in
> [12, 13], and two-loop calculations were first performed in [14].**"

- 自称严格程度：**"aiming to give … demonstrations"**；对新颖性明确自我降级（"not a new idea"）。
- 依赖（`[L1 5461]` 参考文献页逐字）：[1] Friedan–Martinec–Shenker；[12] Green–Schwarz NPB **198** (1982) 441；
  [13] Brink–Green–Schwarz NPB **198** (1982) 474；[14] D'Hoker–Phong, *Lectures On Two-Loop Superstrings*。
- 备注：★ **本文把「超弦微扰论的骨架」归给 1980 年代，把自己定位为「使论证更简单更直接」，不是「首次给出证明」。**

### EW3 ★★★ 1209.5461 §1 的六条范围限制（**本文最重要的自承边界**）
- 位置：§1, p.3。`[L1 5461]`
- 原文（**逐字，分条**）：

> "**We make several restrictions on the scope of this paper.** First and very important, we assume that the reader
> has already learned the basics about superstring perturbation theory elsewhere, and we only review the basics here
> to the extent that it seems particularly useful. Second, as explained in section 2.4.1, **we consider only the
> simplest class of vertex operators that suffice for computing the S-matrix.** … Techniques for computing with more
> general vertex operators … are well-established [17, 18], but the necessary details would make the present paper
> more complicated …
>
> Accordingly, **we omit certain questions, such as mass renormalization and an analysis of models in which a
> perturbative shift in the vacuum is necessary to maintain spacetime supersymmetry**, that are difficult to study in
> a conformally-invariant formalism. Actually, an off-shell formalism appropriate for these questions has been
> developed in a relatively recent series of papers (**these papers were not available when the original version of
> the present paper was submitted to the arXiv in 2012**). For a selection of these papers, see [19–24]. These papers
> have been written in the language of picture-changing operators rather than in terms of super Riemann surfaces. It
> would certainly be possible to restate the results of those papers in the super Riemann surface language employed
> in the present paper … **However, this has not yet been done.**
>
> Likewise, **it is difficult to incorporate expectation values of Ramond-Ramond fields in the superconformal
> framework, so we do not consider backgrounds with such expectation values.** Similarly, **we do not make contact
> with the pure spinor formalism [25].**
>
> **We will not discuss ultraviolet issues in this paper, since there are none.** Modular invariance, which was
> discovered over forty years ago [26] following the recognition of the special role of 26 dimensions [27], removes
> the ultraviolet region from superstring perturbation theory, though it took some time for this to be understood."

- 自称严格程度：全是限定语。**最后一句（无 UV 问题）是断言，理由外包给模不变性 [26] = Shapiro, PRD **5** (1972) 1945。**
- 备注：★★ **这一段是把「Witten 已填上 Polchinski 的缺口」这个结论收窄的最强内部证据。**
  被排除在外的至少有：质量重整化、需要真空移动的模型、R-R 背景、pure spinor、一般顶点算符。
  ⚠ **「[19–24] 与本文语言尚未统一（"has not yet been done"）」这句写于 v3/v4（2018/2023），
  说明截至 2023 年这条缝仍没缝上。**

### EW4 ★★★ 1304.2832 §1：「只差两步」（**本系列对「缺口有多大」最直接的自评**）
- 位置：arXiv:1304.2832**v4**, §1, p.1。`[L1 2832]`
- 原文（**逐字**）：

> "The basic foundations of superstring perturbation theory – including superconformal symmetry, modular invariance,
> worldsheet anomaly cancellation, and fermion vertex operators – **were all well established by the mid-1980's.
> Roughly speaking, to complete that story in a natural way only requires a couple of steps:**
>
> ***(A)*** One should formulate all essential arguments, and especially those that involve integration by parts, on
> the moduli space of super Riemann surfaces, and not on the moduli space of ordinary Riemann surfaces.
>
> ***(B)*** One needs a careful treatment of integrals that are only conditionally convergent in the infrared region.
> The supersymmetric version of the Deligne-Mumford compactification of moduli space provides a natural infrared
> regulator."

- 自称严格程度：**"Roughly speaking, to complete that story in a natural way only requires a couple of steps"**。
- 备注：★★★ **这是「Polchinski 1998 的缺口是什么、要怎么补」的作者版答案，而且它把缺口定位为两条技术步骤，
  不是「基础不成立」。** 转卡时这条与 `polchinski-1998-v2-ch12#E26` 应当并排出现。

### EW5 ★★★ 1304.2832 §1 p.2：「well-placed to demonstrate」（**回答派工单第 (4) 问：措辞强度**）
- 位置：arXiv:1304.2832v4, §1, p.2。`[L1 2832]`
- 原文（**逐字**）：

> "The models considered here, since they do have a dilaton tadpole at two-loop order, **are not models in which
> superstring perturbation theory works to all orders, at least not in its usual form.** But they illustrate some
> essential subtleties of superstring perturbation theory in a particularly simple way. **Once one understands these
> subtleties, one is well-placed to demonstrate that superstring perturbation theory works to all orders in those
> models in which tadpoles and supersymmetry-breaking effects do not arise.**
>
> A procedure to generalize superstring perturbation theory to describe vacuum shifts that are necessary when
> tadpoles appear has been developed recently [9]. (**This procedure can certainly be restated in terms of super
> Riemann surfaces, though this has not yet been done.**) We do not consider such issues here. Our goal is only to
> explain how 'integration over moduli space' when implemented in the superworld resolves various issues that caused
> confusion in the literature of the 1980's."

- 自称严格程度：**"one is well-placed to demonstrate"** —— **不是 "we demonstrate"、不是 "it is proved"**，
  且**带条件**「in those models in which tadpoles and supersymmetry-breaking effects do not arise」。
- 备注：★★★ **这是全系列对「微扰一致性是否已证」最贴题的一句自评。**
  它同时给出了**适用域**（无 tadpole、超对称不自发破缺的模型）与**强度**（"well-placed to demonstrate"）。

### EW6 归约到超模空间与积分链 Γ（1209.5461 §3.3.1）
- 位置：§3.3.1, p.34；(3.57)。`[L1 5461]`
- 原文（逐字）："Thus, roughly speaking, `F(𝒥,δ𝒥)` is a pullback from the moduli space `𝔐_g` of super Riemann
  surfaces of genus g. Moreover, counting both holomorphic and antiholomorphic variables, `F(𝒥,δ𝒥)` has the right
  superdegree to be integrated over `𝔐_g`. So we can define the integral of `F(𝒥,δ𝒥)` over this moduli space, and
  this will give the genus g contribution to the vacuum amplitude of the heterotic string."
- 原文（紧接，逐字）："As usual, **some subtleties arise in the infrared region because `𝔐_g` is not compact**; these
  will occupy our attention later. But as a preliminary, one has to grapple with an important detail."
- 自称严格程度：**"roughly speaking"**（原文两次用它）。

### EW7 ★★★ 「超模空间不可投影」在 1209.5461 里的位置与措辞（**回答派工单第 (3) 问**）
- 位置：§3.3.2「A Hard-To-Avoid Detail」, p.35；定义式 (3.58)(3.59)。`[L1 5461]`
- 定义（逐字）：
  - **projected**：「`𝔐` is said to be **holomorphically projected** if it is possible to choose the coordinates so
    that `f(m|η¹η²)` is a function of `m` only, and not of the `η`'s.」
  - **split**：「`𝔐` is said to be **holomorphically split** if it is possible to choose the coordinates so that `f`
    is independent of the `η`'s and the `ψ^i` are linear in the `η`'s.」
- **★ 关键句（逐字）**：

> "It is rather special for a complex supermanifold to be holomorphically projected or split. **There has been no
> reason to believe that the moduli space of super Riemann surfaces has this property, and recently it has been shown
> that this is not the case in general [45].** (**Supermoduli space is holomorphically projected in low orders and
> this fact has been exploited in explicit computations, especially in [14].**)"

- **[45] 逐字（`[L1 5461]` 参考文献页 p.234）**：
  「R. Donagi and E. Witten, "Supermoduli Space Is Not Projected," **Proc. Symp. Pure Math. 90 (2015) 19-72**,
  arXiv:1304.7798.」 ⇒ **这条同时给出了 Donagi–Witten 的发表信息**（L1，但属 Witten 自引，非出版方直证）。
- [14] = D'Hoker–Phong, *Lectures On Two-Loop Superstrings*。
- 自称严格程度：**"it has been shown"**（指 [45]）；对低亏格是 **"is holomorphically projected"**（肯定）。
- 备注：★ **注意 Witten 把「低亏格可投影」与「一般不可投影」并列陈述，且明说低亏格那条正是 D'Hoker–Phong
  两圈计算所依赖的事实。** ⇒ **两圈的显式结果不因 DW 定理受损。**

### EW8 ★★ 「自然的模空间不存在，存在的是积分链」（1209.5461 §3.3.2 结论句）
- 位置：§3.3.2, p.36；(3.61)。`[L1 5461]`
- 原文（**逐字，本节最后一句**）：

> "**One might have hoped to define a natural moduli space of heterotic string worldsheets over which one would
> integrate to compute scattering amplitudes. This appears to be too optimistic, for the reasons sketched above.
> The integration cycle `Γ` is what exists instead.**"

- 相关（逐字）："Then we thicken `Γ` to a cycle `Γ̂ ⊂ ℳ_L × ℳ_R`. **Though the thickening from `Γ` to `Γ̂` is not
  completely canonical**, the integral

```
Z_g = ∫_Γ̂ 𝒟(𝒥, δ𝒥) F(𝒥, δ𝒥)                                      (3.61)
```

> would be independent of the choices involved **if `Γ̂` were compact**. As it is, what we have said about the
> definition of `Γ̂` needs to be supplemented with an explanation of how `Γ̂` should behave at infinity. **We postpone
> this until we have acquired in section 6 a basic understanding of the behavior of the superstring measure in the
> infrared region.**"

- 一般性说明（逐字，同页）："In general, suppose that `M` is a complex supermanifold of dimension `p|q`, and
  `F(x,dx)` is a closed holomorphic `p|q`-form on `M`. Then `F` can be integrated on a subsupermanifold `Γ̂ ⊂ M` of
  real codimension `p|0` … with a result that only depends on the homology class of `Γ̂`."
- 自称严格程度：定义 + 断言；**"not completely canonical" 与 "if `Γ̂` were compact" 是两条显式保留**。
- 备注：⚠ **`Γ` 与 `Γ̂` 的帽子在页图上很小，见 §3。** 后文（§7.1 (7.1)、§9.2.1）直接写 `Γ`、`∂Γ`。

### EW9 ★★★ 伪奇点（spurious singularities）：为什么 PCO 处方只在局部有效（1209.5461 §3.5）
- 位置：§3.5「A Basis Of Odd Moduli」, pp.41–43；(3.76)–(3.84)。`[L1 5461]`
- 机制（逐字，p.42）：

> "The fermionic gauge-fixing that is defined by the choice of slice (3.78) is then wrong at such a value of `m_α`,
> and the measure on supermoduli space, computed as in section 3.6.2 using this slice, will develop a pole. …
> **Except in very low genus, this phenomenon is practically unavoidable** and in the literature there is a technical
> name for these poles – they are called **spurious singularities**. **They are spurious because they result from an
> invalid gauge-fixing.** To compute correctly in a formalism with spurious singularities can become complicated in
> general, as one has to keep track of total derivatives supported on the locus of spurious singularities. **We will
> not try to explain how to do that here.** Rather, our goal is to understand how to calculate in a framework in
> which all singularities are physically sensible … **So we want to avoid spurious singularities.**"

- **正确处方（逐字，p.42–43）**：

> "We pick a suitable set of `χ^(σ)`'s and a sufficiently small open set `𝒰` in `ℳ_L × ℳ_R` so that eqn. (3.79) has
> no solution … **But we can cover `ℳ_L × ℳ_R` with open sets `𝒰^(ζ)` in each of which we can pick an appropriate
> basis `χ^(σ;ζ)` of gravitino fields such that eqn. (3.79) nowhere has a non-zero solution.** … **what we do not want
> to do is to integrate over the `η_{σ;ζ}` in each `𝒰^(ζ)` to get a measure on the reduced space** … A correct
> computation has to keep track of `Υ₀`. **Conceptually, the simplest correct procedure is to use the local slices to
> compute the invariant objects `F(𝒥,δ𝒥)` or `Ξ(x)` …, and then evaluate the amplitude using (3.61) or (3.71). In
> that way, we extract only invariant information from the local slices and we never meet spurious singularities.
> It is also possible but cumbersome to describe a correct procedure without the geometric interpretation that we have
> just explained. See for example [49].**"

- **[49] 逐字**：「A. Sen and E. Witten, "Filling The Gaps With PCO's," **JHEP 1509 (2015) 004**, arXiv:1504.00609.」
  ⚠ **这条引文只可能出现在 v3/v4，不在 2012 年的 v1 里。**
- 结论句（逐字，p.43）："It implies that **except in special cases in low orders, one should not expect to be able to
  avoid the subtleties described in sections 3.3.2 and 3.4.1.**"
- 自称严格程度：给出处方并断言其正确（"correct procedure"），**但明说不处理带伪奇点的算法**。
- 备注：★★★ **这一条直接回答 Polchinski p.121 的 "subtle ambiguity at higher genus"：
  歧义的来源被指认为「切片选取在某些 `m_α` 处非法（(3.79) 有非零解）」，解决办法是
  「分片选切片 + 只提取不变量 `F` / `Ξ`，最后用 (3.61) 在 `Γ̂` 上积分」，而不是「挑一组 PCO 位置」。**

### EW10 ★★ PCO 是「积分掉奇模的一种方法」，被**导出**而非**假设**（1209.5461 §3.6）
- 位置：§3.6.1–§3.6.2, pp.44–45；(3.85)–(3.97)。`[L1 5461]`
- 链条（逐字 + 式号）：
  - (3.87) 被积函数对 `(η_σ, dη_σ)` 的依赖是一个简单因子 `exp(−(1/2π)∫χ(η_σ S + dη_σ β))`；
  - (3.88) 积掉这对变量得 `δ(∫χβ_zθ)·∫χS_zθ`；原文："**This is a standard formula; see [5, 7] or eqn. (3.335) in
    [8].** Usually the differentials `dη_σ` are not introduced explicitly in the formalism, and one says simply that
    (3.88) results from integration over `η_σ`."
  - (3.94)/(3.96) 取引力微子模为 delta 函数 `χ^{(σ)θ} = δ_{p_σ}`；
  - **(3.95) `𝒴(p) = δ(β(p)) S_zθ(p)` —— 原文："This is called the picture-changing operator. It was originally
    defined rather differently in [1]. The definition (3.95) was first presented in [7, 46] …"**
  - (3.97) 积掉全部奇模得 `∏_{σ=1}^{2g−2} 𝒴(p_σ)`。
- **★ 作者对 PCO 的定位（逐字，p.44）**："**We have given the reader fair warning that in general it is not
  illuminating to integrate out the odd variables.** On the other hand, it is also important to know what happens when
  we do integrate them out, both to make contact with the literature and **more importantly because integrating out
  the odd variables is useful for performing practical calculations in low orders.**"
- **★ PCO 定义本身的歧义（逐字，p.46）**："**Actually, the definition of `𝒴(p)` needs some clarification, because
  there is a singularity in the operator product of `S_zθ(p)` and `δ(β(p))`. The usual approach is to fix the
  ambiguity (which involves an operator of the form `δ'(β)∂_z b_zz` …) by using BRST symmetry.** Equivalently, one may
  regularize the definition of `𝒴(p)` by using a smooth gravitino wavefunction with very concentrated support and
  taking the limit as it approaches a delta function."
- 备注：★★ **这一条是对 Polchinski p.121 "the picture-changing prescription is rather *ad hoc* and it would be
  satisfying to see it derived in some way" 的正面回答：PCO 被导出为「delta 函数引力微子 + 积掉奇模」的特例。**

### EW11 ★★ PCO 方法的两条硬限制（1209.5461 §3.6.2）
- 位置：§3.6.2, pp.46–47；(3.98)(3.99)(3.100)–(3.103)。`[L1 5461]`
- **(a) 伪奇点判据（逐字）**："In particular, **if one integrates out the odd moduli of `Σ` via a product of
  picture-changing operators, one should expect to encounter spurious singularities as the bosonic moduli … are
  varied.** These are poles that appear where

```
H⁰(Σ_red, T^{1/2}(Σ_σ p_σ)) ≠ 0 .                                   (3.99)
```
"
- **(b) PCO 重合极限不存在（逐字，p.47）**：

> "**The foregoing remarks must be treated with care.** It is true, as we have just seen, that the picture-changing
> formalism has a natural analog when two or more of the points `p_σ` coincide. **However, this analog is not simply
> the limit of the picture-changing formalism when, say, `p₁ → p₂`.** The reason is that there is a short-distance
> singularity in the operator product `𝒴(p₁)𝒴(p₂)` for `p₁ → p₂`. The above classical treatment amounted to
> normal-ordering this product and dropping the singular terms. The singular terms are `Q_B`-exact, so that their
> contribution to `F(𝒥,δ𝒥)` is an exact form, but **as usual such exact forms must be treated carefully.** So the
> picture-changing formalism, defined initially for distinct points `p_σ`, has an analog when some of the points are
> taken to coincide, **but it does not in general have a limit as the points approach each other.**"

- 备注：★ 这两条合起来是「PCO 位置不是随便挑」的精确内容。

### EW12 ★★★ 「本文从不用 PCO 位置做基本陈述」（1209.5461 §6.4.6）
- 位置：§6.4.6「Picture Numbers And Picture-Changing Operators」, p.109。`[L1 5461]`
- 原文（**逐字**）：

> "Another type of comment about picture number may be helpful. **In this paper, we never make any fundamental
> statements in terms of positions of picture-changing operators (PCO's); we view the PCO's as a possible method of
> integration over odd moduli, but not a basic definition.** Still, it may be helpful to spell out in terms of PCO's
> what it means to correctly treat the compactification of the moduli space. … This means that when `Σ` decomposes to
> two intersecting components `Σ_ℓ` and `Σ_r`, the location of the PCO's should have a limit as `q_NS → 0`, and `Σ_ℓ`
> and `Σ_r` should each have the right number of PCO's to describe its odd moduli. Moreover, **the PCO's should be
> placed to avoid spurious singularities on `Σ_ℓ` and on `Σ_r`. (To compute correctly with PCO's, they must be used
> piecewise, avoiding spurious singularities, as described in section 3.5.)** … the odd dimension of the moduli space
> of `Σ_ℓ` is `(2g₁−2)+(n_{NS,1}+1)+n_{R,1}/2`, and that is the number of PCO's that should be placed on `Σ_ℓ`."

- 备注：★★★ **这是「积分超模空间 vs 挑 PCO 位置」这个对立在原文里的最明确表述**（派工单第 (2) 问）。

### EW13 ★★ 高亏格 PCO 分布是否会给错答案：**作者明说不确定**（1209.5461 §6.4.6 末）
- 位置：§6.4.6, pp.109–110。`[L1 5461]`
- 原文（**逐字**）：

> "**It is a slightly tricky question to what extent one will actually get wrong answers in the picture-changing
> formalism if one distributes the PCO's incorrectly when `Σ` degenerates.** In genus 0, as long as the momentum
> flowing between `Σ_ℓ` and `Σ_r` is generically off-shell, one can distribute the PCO's between `Σ_ℓ` and `Σ_r` in an
> arbitrary fashion, treating the compactification of the moduli space incorrectly, and still get the correct
> tree-level `S`-matrix. This was explained in section 4.4. **It is not entirely clear if this remains true in higher
> genus; the spurious singularities may cause trouble.** (The recipe explained in section 3.5 to compute piecewise and
> avoid spurious singularities **certainly cannot be extended over the compactification if one treats the
> compactification incorrectly**.) At any rate, in higher genus, one will run into degenerations (associated to
> massless tadpoles and mass renormalization) for which the momentum flowing between `Σ_ℓ` and `Σ_r` is generically
> on-shell. In our treatment of such questions, starting in section 7, **it will be clear that one should expect
> trouble if one does not treat the compactification of moduli space correctly.**"

- 自称严格程度：**"It is not entirely clear"** —— 作者自承的开放点。
- 备注：★★ **对图很重要：Witten 并没有宣布「PCO 方法在高亏格错了」，他宣布的是
  「用 PCO 必须分片且必须正确处理紧化，否则不清楚会不会错」。**

### EW14 Sen–Witten 2015：PCO 路线的补丁（`[L2 摘要]`）
- 位置：arXiv:1504.00609（= 1209.5461 的 [49]），摘要。`[L2 摘要]`
- 摘要要点（逐字片段）："a constraint must be placed on PCO insertions to avoid spurious singularities";
  "it has been long known that **the simplest version of the PCO procedure is valid only locally on the moduli space
  of Riemann surfaces**, and that a correct PCO-based algorithm to compute scattering amplitudes must be based on
  piecing together local descriptions"; "Recently, **'vertical integration'** was proposed as a relatively simple
  method to do this"; "This involves **a hierarchical procedure with corrections of high order**";
  "One might anticipate such a structure from the viewpoint of super Riemann surfaces."
- 备注：★ **⇒ PCO 方法本身没有被判死刑，而是被补上了「vertical integration」的分片拼接规则。**
  ⚠ 正文未读，**发表信息取自 1209.5461 ref [49]（JHEP 1509 (2015) 004）**，未与出版方核对。

### EW15 BRST 反常的定义式（1209.5461 §7.1）
- 位置：§7.1, p.123；(7.1)。`[L1 5461]`
- 原文（逐字）："At many points in the present paper, beginning in section 2.4.3, we have seen that **the proof of
  gauge-invariance and related properties relies on integration by parts on moduli space.** One simply uses eqn. (2.48)
  together with Stokes's theorem (or the superanalogs of these formulas) to express a scattering amplitude with
  insertion of a BRST-trivial state such as `Q_B𝒲₁` in terms of a boundary integral:

```
∫_Γ F_{{Q_B,𝒲₁},𝒱₂,…,𝒱_n} = − ∫_{∂Γ} F_{𝒲₁,𝒱₂,…,𝒱_n} .                (7.1)
```
"
- 原文（紧接，逐字）："**Actually, this phrasing of the problem is a little too schematic.** In closed oriented string
  theories, `Γ` has no boundary, but the forms that must be integrated over `Γ` are singular along a divisor `𝒟` …
  We place a cutoff on the integral … by removing a small neighborhood of `𝒟`. … Then we consider the limit in which
  the cutoff is removed; **there is no anomaly if the right hand side of (7.1) vanishes in this limit.**"
- 备注：这是 Witten 版「零范数态解耦 / 规范不变性」的判据，**建立在 Stokes 定理与紧化处理上**，
  与 Polchinski `polchinski-1998-v2-ch12#E20` 的 "formally … surface terms on moduli space" 是同一件事，
  但这里给出了具体的截断与取极限规程。

### EW16 ★★★ 无质量 tadpole 是「最关键的问题」（1209.5461 §7.5）
- 位置：§7.5「Massless Tadpoles In String Theory」, p.140。`[L1 5461]`
- 原文（**逐字**）：

> "**Ultimately, the most critical question for superstring perturbation theory is to make sure that the vacuum state
> that one attempts to construct in perturbation theory is not destabilized by massless tadpoles.** The show this[sic],
> we will use spacetime supersymmetry. As just explained, **we consider only the massless `S`-matrix, and only string
> compactifications in which there is no perturbative mass renormalization for massless particles.**
>
> Additionally, to begin with, **we consider only closed oriented strings.** … **The proof that the amplitudes are
> spacetime supersymmetric and free of massless tadpoles will proceed by induction in the genus `g`** of the string
> worldsheet. Assuming that there are no massless tadpoles and that spacetime supersymmetry holds up to genus `g−1`,
> we will show that this is also true in genus `g`."

- 原文（同页，关于 dilaton / 弦耦合，逐字）："Whenever one has a perturbative superstring `S`-matrix, it depends on at
  least one modulus, namely the string coupling constant `g_st = e^φ`. … The output of our discussion will be to show
  that the perturbative `S`-matrix **is well-defined as a function on `𝒵`**. **But in general there is no reason to
  expect `𝒵` to have a natural parametrization in terms of fields such as `φ`.**"
- ⚠ **原文疑似排印错误**：`The show this` 应为 `To show this`（v4 页图逐字，见 §3）。
- 备注：★★★ **回答派工单第 (5) 问的一半：dilaton tadpole 不是被"处理掉"，而是被证明为零（在限定条件下），
  且证明是对亏格的归纳。**

### EW17 ★★ 条件收敛与红外正规化的不唯一（1209.5461 §7.6.1）
- 位置：§7.5 末 – §7.6.1, pp.140–143；(7.18)–(7.27)。`[L1 5461]`
- 原文（逐字，p.140–141）："We will find that when massless tadpoles vanish, the integrals that have to be evaluated
  to compute the `S`-matrix **are convergent, but only conditionally so. Different infrared regulators lead to results
  for the `S`-matrix that differ by reparametrizations of `𝒵`.** (Some of the issues have been treated in [73].) …
  **So the `S`-matrix is naturally determined, but the vertex operators that are used to evaluate it are not.**"
- 关键式（逐字）：

```
𝒜_{g,sing} = Σ_α ∫ (d²q / q̄q) ∫_{ℳ̂_ℓ} 𝒢_{ℓ,α} ∫_{ℳ̂_r} 𝒢_{r,α}        (7.23)
∫_{ℳ̂_r} 𝒢_{r,α} = 0 ,  α = 1,…,s        （tadpole 为零的假设）        (7.24)
𝒜_{g,ε} = ∫_{ℳ̂_ε} F(g|δg)                                             (7.26)
𝒜_g → 𝒜_g − 4π Σ_α ∫_{ℳ̂_ℓ×ℳ̂_r} h 𝒢_{ℓ,α} 𝒢_{r,α}                     (7.27)
```

- 原文（逐字，p.143）："So the divergence at `q = 0` is multiplied by 0, **rather like the `0/0` that one gets in
  field theory if the tadpole vanishes.** … **Vanishing of the tadpoles has made the scattering amplitude
  convergent.** **This is not the whole story, however**, since `q` is really not a complex number … but a section of
  the line bundle `𝒩^{-1}`. This bundle is topologically nontrivial, so there is no way to trivialize it …
  A change in the hermitian metric on `𝒩^{-1}` … has the effect of shifting `log ε` to `log ε + h`. This does not
  affect the fact that `𝒜_g` has a limit for `ε → 0`, **but it shifts the value of the limit by** (7.27)."
- [73] = H. La and P. Nelson, "Unambiguous Fermionic-String Amplitudes," **PRL 63** (1989) 24。
- 备注：★★ **这是 1304.2832 §1 的 (B) 在 1209.5461 里的落地。** 结论强度是
  「`S` 矩阵作为 `𝒵` 上的函数良定义，但没有自然参数化」——**比「振幅有唯一数值」弱**。

### EW18 ★★★ 无质量 tadpole 消失的证明（1209.5461 §8.3）——**含一个未证的 "if"**
- 位置：§8.3「Vanishing Of Massless Tadpoles」, pp.173–175；(8.38)–(8.42)。`[L1 5461]`
- 原文（开篇，逐字）："Finally we come to **the question of proving that perturbative massless tadpoles vanish in
  those supersymmetric compactifications in which supersymmetry is not spontaneously broken in perturbation theory.**"
- 核心关系（逐字）：

```
𝒱_φ = Σ_α Q_α(𝒱_{ψ_α})                                                (8.38)
Σ_α ⟨𝒮_α 𝒱_{ψ_α}⟩          （亏格 g 的两点函数）                        (8.41)
0 = ∫_Γ dF_{𝒮𝒱} = ∫_{∂Γ} F_{𝒮𝒱}                                       (8.42)
```

- 归纳步（**逐字，p.175**）：

> "**A very short argument now shows the vanishing of massless tadpoles.** Inductively, suppose that we know that
> massless tadpoles vanish and spacetime supersymmetry is unbroken up to and including genus `g−1`. Then almost all
> boundary contributions to the relation (8.42) vanish. The only contribution that is not ruled out by the inductive
> hypothesis comes from the degeneration of fig. 30(b) with `g_ℓ = 0, g_r = g`. Using (8.38), this is simply the genus
> `g` tadpole `⟨𝒱_φ⟩_g`. So that tadpole vanishes.
>
> Once we know that the massless tadpoles vanish in genus `g`, the `g`-loop amplitudes make sense and the arguments of
> section 8.2.3 show that these amplitudes have spacetime supersymmetry, in general **possibly with spontaneous
> supersymmetry breaking in `g`-loop order**. **If (as in most cases) general arguments show that spacetime
> supersymmetry is not spontaneously broken at `g`-loop order, then the inductive step is complete** and we can repeat
> the argument for genus `g+1`."

- **★ 自称严格程度**：**"A very short argument now shows"**（正面），
  **但归纳闭合挂在 "If (as in most cases) general arguments show that spacetime supersymmetry is not spontaneously
  broken at `g`-loop order" 这个显式条件上，而这个条件本文不证。**
- 备注：★★★ **这是本轮找到的、与 `polchinski-1998-v2-ch12#E20` 的两个 "if" 完全同构的一条：
  Witten 的归纳论证也是条件式的。** 转卡时 `gaps` 必须抄这句。
- 补充（逐字，p.175 末）："It was crucial for the inductive argument that if spacetime supersymmetry is unbroken up to
  and including `g`-loop order, there are no massless tadpoles below `g+1`-loop order. **We deduced this from general
  properties of the Deligne-Mumford compactification.** But in fact, low energy effective field theory implies that if
  supersymmetry is unbroken up to `g`-loop order, then massless tadpoles appear only in order `2g`."

### EW19 dilaton 与度规迹在超共形形式下只有一个组合（1209.5461 §8.3）
- 位置：§8.3, p.174；(8.39)(8.40)。`[L1 5461]`
- 原文（逐字）："**At zero momentum, in a superconformal formalism, there is only one `𝒱_φ`, so only one linear
  combination of the tadpoles of the dilaton and the trace of the metric is a potential obstruction to the validity of
  perturbation theory**, and there is only one `𝒱_{ψ_α}` that we can use to prove the vanishing of this one
  obstruction. In a more general formalism as summarized in section 2.4.4, **we could potentially encounter separate
  tadpoles for the dilaton and the trace of the graviton, and we would have two separate `𝒱_{ψ_α}`'s** to deal with
  these two tadpoles."
- 十维杂化弦的显式顶点算符：`𝒱_φ = c̃cδ(γ)∂̃X_I DX^I`（(8.39)）、`𝒱_{ψ_α} = Γ_I^{αβ} c̃c ∂̃X^I Θ_{−1/2} Σ_β`（(8.40)）。
- 备注：★ **回答派工单第 (5) 问的另一半：本文处理的是「dilaton 与度规迹的那一个线性组合」的 tadpole，
  不是分开的 dilaton tadpole。** ⚠ 这是超共形形式的限制，不是物理结论。

### EW20 ★★ 开弦/无定向弦：R-R tadpole ⇒ 反常（1209.5461 §9.4）
- 位置：§9.4「What Happens When R-R Tadpoles Do Not Cancel?」, pp.196–199。`[L1 5461]`
- 原文（逐字，p.196）：

> "Now let us ask what happens if the R-R tadpoles on a disc and `ℝℙ²` do not add to zero. In this case, in a
> supersymmetric model, **there will also be a nonvanishing sum of the NS-NS tadpoles on a disc and `ℝℙ²`, leading to
> an infrared divergence and spoiling the validity of perturbation theory.** … **What happens is rather [82, 84] that
> an R-R tadpole leads to an anomaly – a failure of gauge invariance. This is a more serious deficiency than an
> infrared divergence.** An infrared divergence in perturbation theory can possibly be eliminated by expanding around a
> different – possibly time-dependent – classical solution. **But an anomaly not related to any infrared divergence is
> an overall inconsistency of a theory, independent of the choice of a particular classical solution or quantum state.**
> To be more exact, it is clear in field theory that anomalies are not affected by the choice of a quantum state, or of
> a classical solution around which one expands in order to do perturbation theory. **One expects the same in string
> theory, though string theory is not well enough understood to make this statement completely clear.**"

- 结论（逐字，p.199）："A more careful study of the boundary states [89], [84] shows that **the anomaly comes from the
  odd spin structure.** Hence, as one would expect from field theory, at one-loop order, the anomaly affects only the
  parity-violating amplitudes. … so **an anomaly can only occur if `n − 1 ≥ d/2`. In `d = 10`, the condition is
  `n ≥ 6` and the anomaly is traditionally called a hexagon anomaly.**"
- **引文（`[L1 5461]` 参考文献页逐字）**：
  **[82] = M. B. Green and J. H. Schwarz, "Anomaly Cancellation In Supersymmetric D=10 Gauge Theory And Superstring
  Theory," Phys. Lett. B149 (1984) 117-122** ⇒ **= 本项目 bib 的 `green-schwarz-1984`**；
  [83] = Green–Schwarz, "Infinity Cancellations In SO(32) Superstring Theory," PLB **B151** (1985) 21-5；
  [84] = Y. Cai and J. Polchinski, "Consistency Of Open Superstring Theories," NPB **B296** (1988) 91；
  [89] = S. Yost, NPB **B321** (1989) 629。
- 自称严格程度：**"One expects the same in string theory, though string theory is not well enough understood to make
  this statement completely clear."** —— 又一条作者自承缺口。
- 备注：★★ **这条与 `polchinski-1998-v2-ch12#E19/E20`（type I 规范群由 tadpole 抵消决定；反常消失挂在
  「if this converges」上）直接对话。Witten 把它升级为「R-R tadpole ⇒ 反常 ⇒ 整体不一致」，
  但对「弦论里这个陈述是否成立」明确保留。**
- ⚠ **注意：本项目已有 `green-schwarz-1985-hexagon`（NPB B255 (1985) 93–114）在 reading-list 上待抽。
  Witten 的 [83] 是 PLB B151 (1985) 21，是另一篇**，不要混。

### EW21 ★★★ Donagi–Witten 的定理（**回答派工单第 (3) 问：`not projected` 到底说了什么**）
- 位置：arXiv:1304.7798**v2**, 摘要与 §1, pp.1, 5。`[L1 DW]`
- 摘要（**逐字全文**）：

> "**We prove that for genus `g ≥ 5`, the moduli space of super Riemann surfaces is not projected (and in particular
> is not split): it cannot be holomorphically projected to its underlying reduced manifold. Physically, this means
> that certain approaches to superstring perturbation theory that are very powerful in low orders have no close analog
> in higher orders.** Mathematically, it means that the moduli space of super Riemann surfaces cannot be constructed
> in an elementary way starting with the moduli space of ordinary Riemann surfaces. It has a life of its own."

- **编号定理（逐字，p.5）**：
  - **Theorem 1.1.** "The supermanifold `𝔐_g` is non-projected, and in particular non-split, for `g ≥ 5`."
    紧跟一句括注：**"(We suspect that this result may hold for `g ≥ 3`.)"**
  - **Theorem 1.2.** "The supermanifold `𝔐_{g,1}` is non-projected for `g ≥ 2`, **for the case of an even spin
    structure.**"
  - **Theorem 1.3.** "The supermanifold `𝔐_{g,n}` is non-projected for `g ≥ 2` and `g−1 ≥ n ≥ 1`. This holds for both
    even and odd spin structures if `g` is odd and for even spin structure if `g` is even."
  - 紧跟（逐字）：**"We do not resolve the question of projectedness of `𝔐_{g,n}` for the case of even `g`, odd spin
    structure, and `n ≥ 1`."**
- **Remark 1.4（逐字）**：**"Though `𝔐_g` and `𝔐_{g,n}`, like their bosonic counterparts, have natural
  Deligne-Mumford compactifications, we do not consider the compactifications in the present paper. Our assertion is
  that `𝔐_g` and `𝔐_{g,n}` are non-projected without any consideration of the compactification. Asking for the
  compactification to be projected would only be a stronger condition."**
- **Remark 1.5（逐字节选）**："Although the upper bound on `n` in Theorem 1.3 is probably not optimal … For `n >> g`,
  requiring the `n` points to be distinct **very likely kills the obstructions to splitness**, though we would expect
  the compactification of `𝔐_{g,n}` to be non-split."
- **Remark 1.6（逐字）**："the phrase 'moduli space' is oversimplified in the present context. **The object of study,
  `𝔐_g`, is really the moduli *stack* of super Riemann surfaces.**"
- 自称严格程度：**"We prove"**（摘要）+ 三条编号定理。**这是本系列里唯一一条数学定理级的结果。**
- 备注：⚠ **适用域必须随节点搬运**：`g ≥ 5`（无穿孔）；`g ≥ 3` 只是 "suspect"；`g = 2` 未被本文否定；
  偶亏格 + 奇自旋结构 + `n ≥ 1` **明确未解决**；**不考虑紧化**。

### EW22 ★★★ Donagi–Witten 自己说：不可投影**不**威胁微扰论的有效性
- 位置：arXiv:1304.7798v2, §1, p.4。`[L1 DW]`
- 原文（**逐字**）：

> "Mathematically, if `𝔐_g` is split, this means that it can be reconstructed from the purely bosonic moduli space
> `𝒮ℳ_g` in an elementary fashion and, in a sense, need not be studied independently. **Physically, if `𝔐_g` is split
> – or at least projected – then a possible strategy in superstring perturbation theory is to integrate over `𝔐_g` by
> first integrating over the fibers of its projection to `𝒮ℳ_g`. Indeed, practical calculations in superstring
> perturbation theory – such as the `g = 2` calculations that are surveyed in [16] – are usually done in this way.**
>
> However, there has been no evidence that `𝔐_g` is split, or even projected, in general. **The validity of
> superstring perturbation theory does not depend on a projection, so the existence of string theory gives no hint
> that `𝔐_g` is projected.** The existence of holomorphic projections for small `g` follows from the cohomological
> nature of the obstructions to splitting and the nature of the reduced spaces `𝒮ℳ_g` for small `g`, and gives little
> indication of what happens for larger `g`. **The goal of the present paper is to show that actually `𝔐_g` is not
> projected or split in general.**"

- 备注：★★★ **这是本轮最重要的一条纠偏。**
  **「Donagi–Witten 反驳了 PCO 方法」是过度解读。** 原文说的是：
  (i) 被否定的是**一个特定策略**——「先沿投影的纤维积分，再在 `𝒮ℳ_g` 上积分」；
  (ii) **微扰论本身的有效性不依赖投影的存在**（作者原话）；
  (iii) 低亏格（含 `g = 2`）的实际计算**照旧成立**。
  ⇒ **禁止把 DW 写成「对超弦微扰论的负面结论」；它是对「化约到普通模空间」这条路线的负面结论。**

### EW23 Donagi–Witten 的后续（`[L2 摘要]`）
- 位置：arXiv:1404.6257（DW 在 1304.7798 §1 p.6 逐字称之为 "In a sequel to this work [23]"）。`[L1 DW]` 的自陈 + `[L2 摘要]`
- 1404.6257 摘要（逐字节选）："The first obstruction to splitting a supermanifold `S` is one of the three components
  of its super Atiyah class … We evaluate these classes explicitly for the moduli space of super Riemann surfaces
  ('super moduli space') and its reduced space, the moduli space of spin curves. … These results are used to give **a
  new proof of the non-projectedness of `𝔐_{g,1}`**, the moduli space of super Riemann surfaces with one puncture."
- 备注：⇒ **1404.6257 只重证 Theorem 1.2（`𝔐_{g,1}`），不扩展 Theorem 1.1 的亏格范围。**

### EW24 系列内其余两篇的定位（`[L2 摘要]`）
- **1209.2199 / 1209.2459**：两篇摘要的措辞几乎相同，均为
  「These are notes on the theory of **supermanifolds and integration on them** / **super Riemann surfaces and their
  moduli spaces**, **aiming to collect results that are useful for a better understanding of superstring perturbation
  theory in the RNS formalism.**」
  ⇒ **自我定位为「工具笔记」，不含微扰论一致性的结论。** 1209.5461 把它们引作 [15]、[16]。
- **1306.3621**（*Notes On Holomorphic String And Superstring Theory Measures Of Low Genus*）：摘要自陈
  「describe in a unified way how to determine the bosonic string and superstring vacuum amplitude in **genus 1 and 2**
  via holomorphy … The main novelty is the superstring analysis in genus 2, where we use holomorphy to get a **new
  understanding of some of the results that previously have been obtained by more explicit calculations.**」
  ⇒ **只覆盖亏格 1、2 的真空振幅，不是任意阶的一致性论证。**
  ⚠ **它不在 1209.5461 的 91 条参考文献里**（抽取者逐条扫过）。
- **1307.5124**（*The Feynman iε in String Theory*）：摘要逐字「The Feynman `iε` is an important ingredient in defining
  perturbative scattering amplitudes in field theory. **Here we describe its analog in string theory.** Roughly one
  takes the string worldsheet to have Lorentz signature when a string is going on-shell although it has Euclidean
  signature generically.」comments 自陈「based on a talk presented at the Zuminofest」。
  **1209.5461 引它为 [56]，发表信息 JHEP 1504 (2015) 055**；其内容在 1209.5461 §6.3「The Feynman `iε`」（pp.96–99）
  里已有对应章节。⇒ **回答派工单第 (5) 问的括注：`iε` 确实在系列内，但它是主论文 §6.3 的独立展开，不是 tadpole 处理。**

### EW25 Polchinski 所说的 "ambiguity" 文献 = 哪一篇
- 位置：`[L1 5461]` 参考文献页 p.234。
- **[48] 逐字**：「J. J. Atick, J. M. Rabin, and A. Sen, "**An Ambiguity In Fermionic String Perturbation Theory**,"
  Nucl. Phys. **B299** (1988) 279.」
- 备注：`polchinski-1998-v2-ch12#E26` 逐字提到「There is a literature on the 'ambiguity of superstring perturbation
  theory,' which arose from parameterizations that did not precisely cover supermoduli space.」
  **[48] 的标题与之逐字吻合，是该"文献"的最可能主项。**
  ⚠ **这是 `[抽取者推断]`：Polchinski 正文不给引文编号，本项目未取 Polchinski 书末 References（pp.467–487），
  该对应关系未直证。**

---

## 3. 未核实项 / 读图不确定处

### 3.1 ★ 发表情况（INSPIRE API，L2；**对 bib 直接有用**）

`https://inspirehep.net/api/literature?q=arxiv:<id>&fields=arxiv_eprints,titles,publication_info`（一次查九个）：

| arXiv | INSPIRE recid | `publication_info` |
|---|---|---|
| **1209.5461**（主论文，225 pp） | 1188034 | **无**（截至 2026-09-11 仍**没有期刊发表版**） |
| **1304.2832**（Overview，69 pp） | 1227826 | **无** |
| **1306.3621** | 1238841 | **无** |
| 1209.2199 | 1185124 | Pure Appl. Math. Quart. **15**, no.1 (2019) 3–56 |
| 1209.2459 | 1185284 | Pure Appl. Math. Quart. **15**, no.1 (2019) 57–211 |
| **1304.7798**（Donagi–Witten） | 1231519 | **Proc. Symp. Pure Math. 90 (2015) 19–72** ✔ 与 1209.5461 的 ref [45] 逐字吻合 |
| 1404.6257 | 1292493 | Pure Appl. Math. Quart. **9**, no.4 (**2013**) 739–788 |
| 1307.5124 | 1243621 | **JHEP 1504 (2015) 055** ✔ 与 ref [56] 吻合 |
| 1504.00609 | 1357623 | **JHEP 09 (2015) 004** ✔ 与 ref [49] 吻合 |

⚠ **两条要注意的**：
1. **本系列的两篇核心论文（1209.5461、1304.2832）从未在期刊发表**，只有 arXiv 版。
   ⇒ 图里挂它们时 `sources` 必须写 arXiv id + 版本号，**不能写期刊**。
2. **1404.6257 的卷期年份（2013）早于其 arXiv 提交日（2014-04-24）** —— PAMQ 卷号延迟出版所致，
   **不是错误，但引用时年份写哪个要统一**（本记录按 arXiv 年份 2014 登记，note 里记 PAMQ 2013）。
3. 1209.2199/1209.2459 的 **PAMQ 版页码（3–56 / 57–211）与 arXiv 版页数（42 / 122）不同** ⇒
   **两套页码不可互换**，图里 loc 只能用 arXiv 版并写死版本。

### 3.2 本轮**未读**的部分（红线：这些位置的任何式号、定理号都不得写进图）

| 文献 | 已读 | **未读** |
|---|---|---|
| 1209.5461v4（225 pp） | 目录、§1、§2.1（首页）、§3.3–3.6、§6.4.6–6.5.1、§7.1（前两页）、§7.5–7.6.1（前三页）、§8.3、§9.1、§9.4、§10.1（首段）、Acknowledgments、**References 全 91 条** | **§2.2–2.6、§3.1–3.2、§4 全章（NS 顶点算符）、§5 全章（R 扇区）、§6.1–6.3、§6.6、§7.2–7.4、§7.6.2–7.7、§8.1–8.2、§9.2–9.3、§10.2–10.3、附录 A–D** |
| 1304.2832v4（69 pp） | 标题页、目录、§1、§2.1 | **§2.2–2.6、§3 全章（两圈真空能）、§4 全章（超对称 Ward 恒等式）** |
| 1304.7798v2（57 pp） | 摘要、目录、§1、§2 首页 | **§2.2 起全部、§3、§4（`𝔐_{g,1}` 非投影的证明）、§5（`𝔐_g` 的证明）、附录 A（亏格 5 的例子）、References** |
| 1209.2199 / 1209.2459 / 1306.3621 / 1307.5124 / 1404.6257 / 1504.00609 | **仅摘要与元数据** | **全部正文** |

### 3.3 读图不确定处

| 项 | 情况 |
|---|---|
| **`Γ` 与 `Γ̂` 的帽子** | (3.61) 与 §3.3.2 正文里区分 `Γ ⊂ (ℳ_L×ℳ_R)_red`（中维闭链）与 `Γ̂ ⊂ ℳ_L×ℳ_R`（加厚后的超链）。**页图上帽子很小，抽取者不能 100% 确认每一处**；且 §7.1 (7.1)、§9.2.1 直接写 `Γ`、`∂Γ`（似已省略帽子）。⇒ **图里若要写这条记号，须单页重渲染再核**，或统一写「积分链（integration cycle）」不带记号 |
| **§7.5 p.140 的 "The show this"** | 页图逐字如此，**按上下文应为 "To show this"**。判为 **v4 的排印错误**（不是读图错误：字形清晰）。若图里要引这一整段，`notes` 须写明 |
| (3.99) 的 `T^{1/2}(Σ_σ p_σ)` | 页图上 `Σ` 是求和号还是曲面 `Σ`，字号小；按上下文是**求和**（`Σ_{σ=1}^{2g−2} p_σ` 作为除子）。同页 (3.98) 写 `∂_z̄ y^θ = Σ_{σ=1}^{2g−2} e_σ δ_{p_σ}` 支持这一读法 |
| §6.4.6 的 PCO 计数 `(2g₁−2)+(n_{NS,1}+1)+n_{R,1}/2` | 下标 `1`/`ℓ` 在页图上易混（原文同段既用 `g₁,g₂` 又用 `Σ_ℓ,Σ_r`）。**转卡前须重核** |
| 1209.5461 的 §2.1 (2.1)–(2.5) 系数 | 只读了一页，`1/2π` 与 `1/4π` 的区分依赖小字号，**未做第二遍核对** |
| DW Theorem 1.3 的不等式方向 | 页图读作 "`g ≥ 2` and `g−1 ≥ n ≥ 1`"。**建议重核**：这是唯一带双侧界的定理 |

### 3.4 版本差异未核（**最大的系统性风险**）

本轮读的 1209.5461 是 **v4（2023-11-05）**。以下内容**几乎肯定不在 2012 年的 v1 里**（抽取者推断，未逐版比对）：
- §1 p.3 关于 [19–24]（Sen 2014–2017 的 off-shell / SFT 系列）的整段，含 "these papers were not available when the
  original version of the present paper was submitted to the arXiv in 2012"（**这句本身就是 v3/v4 才可能写的**）；
- §3.5 p.43 对 [49] = Sen–Witten 2015 的引用；
- §3.3.2 p.35 对 [45] = Donagi–Witten (2013/2015) 的引用 —— **v1 (2012-09-25) 早于 DW 的 v1 (2013-04-29)**，
  故这句**不可能**出现在 v1 里。

⇒ ★ **对图的直接后果：「Witten 2012 是否知道超模空间不可投影」这个问题的答案是「不知道，那是后来加的」。**
**任何把「2012 年的论文已经处理了非投影性」写进节点的说法都是错的。**
若需要 2012 年原始状态，必须另取 `arxiv.org/pdf/1209.5461v1` 重读（本轮未做）。

### 3.5 其它未核实

- 1209.5461 ref [45] 给出的 DW 发表信息（PSPM 90 (2015) 19–72）**与 INSPIRE 一致**（两源相符），
  但**均未与出版方（AMS）直证**。
- Witten 说「conventions we generally follow」指 Polchinski §5.3，**本项目尚未把 §5.3 与 1209.5461 §2 逐式比对**。
- 1209.5461 §6.3「The Feynman `iε`」（pp.96–99）与 1307.5124 的关系**只有目录级证据**，正文未读。

---

## 4. 未解决的疑问

（待填）

---

## 4. 未解决的疑问（留给 curator / auditor / lead）

**QW1（★★★ 派工单的核心问题：Polchinski 的缺口填上了没有？）**
抽取者的判定（**基于逐字自陈，不是抽取者的物理判断**）：

- **填上的部分**：
  1. Polchinski p.121「the picture-changing prescription is **rather ad hoc** and it would be satisfying to see it
     **derived in some way**」→ **已填**。EW10：PCO `𝒴(p) = δ(β)S_zθ` 被导出为「delta 函数引力微子 + 积掉奇模」的
     特例（(3.88)→(3.95)），不是假设。
  2. Polchinski p.121「this prescription has a **subtle ambiguity at higher genus**」→ **已诊断并给出处方**。
     EW9：歧义 = 伪奇点 = 切片选取在 (3.79) 有非零解处非法；处方 = 分片选切片 + 只提取不变量 + 在 `Γ̂` 上积分。
     系统化的 PCO 版本另见 Sen–Witten 2015（EW14，"vertical integration"）。
  3. Polchinski §12.5「parameterizations that did not precisely cover supermoduli space」→ **框架已重建**：
     EW6/EW8，整个论证在超模空间/积分链上做，不下降到普通模空间。

- **没有填上的部分（作者自陈）**：
  1. **适用域被显式收窄**（EW3）：不含质量重整化、不含需要真空移动的模型、不含 R-R 背景、不含 pure spinor、
     只用最简单一类顶点算符。
  2. **归纳论证本身是条件式的**（EW18）：「**If** (as in most cases) general arguments show that spacetime
     supersymmetry is not spontaneously broken at `g`-loop order, then the inductive step is complete」——
     **这个 "if" 与 `polchinski-1998-v2-ch12#E20` 的两个 "if" 结构完全同型。**
  3. **强度自陈是 "demonstration" / "well-placed to demonstrate"，不是 "proof of consistency"**（EW1/EW5）。
  4. **开弦/无定向弦侧仍有保留**（EW20）：「string theory is not well enough understood to make this statement
     completely clear」。
  5. **PCO 分布错误是否一定给错答案，作者明说 "not entirely clear"**（EW13）。
  6. **主论文从未在期刊发表**（§3.1）。

⇒ **抽取者建议的结论措辞**：「Polchinski 1998 指出的两条具体技术缺口（PCO 的 ad hoc 性、高亏格歧义）在 Witten
2012–2013 的框架里被**诊断并给出了系统处方**；但 Polchinski 那句话本身（*a fully explicit proof of the
perturbative consistency of the theory*）**在本系列里没有被任何一处宣称已完成**，作者自己给出的最强表述是
『在没有 tadpole 且超对称不自发破缺的模型中，人们**处在有利位置去论证**微扰论到所有阶成立』。」
**这属于陈述规范化，按根 CLAUDE.md 原则 4 应走里程碑流程，researcher 不代裁。**

**QW2（★★ 最容易被误用的一条）** Donagi–Witten 的 "not projected" **不是**对超弦微扰论的负面结论。
EW22 逐字：「**The validity of superstring perturbation theory does not depend on a projection**」。
被否定的是「先沿投影纤维积分再下降到 `𝒮ℳ_g`」这一**策略**。派工单把它描述为「这是对 PCO 方法的**负面**结论」，
**按原文不成立**：PCO 与 projection 是两件事，PCO 方法在 Sen–Witten 2015 里被补丁化而非废弃（EW14）。
**问题**：图里要不要专门建一条 `refuted` 卡来记「化约到普通模空间的策略在高亏格失效」？抽取者倾向于建，
但 statement 必须写成对**策略**的否定，不是对**微扰论**的否定。

**QW3** EW18 的那个 "if"（超对称在 `g` 圈不自发破缺）**在 1209.5461 里不证**，只说 "as in most cases general
arguments show"。而 **1304.2832 整篇正是研究这个 "if" 失效的模型**（`SO(32)` 杂化弦 on CY，超对称在一圈自发破缺，
两圈有 dilaton tadpole）。**问题：图里「超弦微扰论到所有阶一致」这条链的真实瓶颈，是不是应该指到这个 "if"？**
需要 auditor 裁定。（与 `polchinski-1998-v2-ch12` Q6 同型。）

**QW4** Witten §9.4（EW20）把「R-R tadpole 不抵消 ⇒ 反常 ⇒ 整体不一致」讲清楚了，并把六边形反常的条件推成
`n ≥ 6`（`d = 10`）。**这与 `polchinski-1998-v2-ch12#E19`（type I 规范群由 tadpole 抵消决定）和 `#E20`
（反常消失挂在 "if this converges" 上）是同一条链。**
**问题：`consistency` 区的 type I 分支能不能把来源从 Polchinski §12.2 换成 Witten §9.4？**
抽取者的观察：Witten §9.4 的论证**更具体**（给出边界态、自旋结构、零模计数），但**它引 [82] = `green-schwarz-1984`
与 [84] = Cai–Polchinski 1988 作为结论出处**，自己不重做 GS 那一步。⇒ **换来源只是把 L0 的一环换到另一处，
真正的一手仍是 `green-schwarz-1985-hexagon`（reading-list P1，仍未取到正文）。**

**QW5** 1209.5461 §2.1 明说「conventions we generally follow」= Polchinski §5.3。
**问题：本项目要不要把这条写成一条 `conv.*` 节点上的「兼容性」注记？**
风险：Witten 只说 "generally"，没逐条声明；抽取者未做逐式比对（§3.5）。**不建议在没做比对前写进图。**

**QW6** 派工单问「引力 dilaton tadpole 的处理」。按 EW19，**在超共形形式下，零动量处只有一个 `𝒱_φ`，
因此只有 dilaton 与度规迹的那**一个线性组合**是潜在障碍**；分开的 dilaton tadpole 与 graviton 迹 tadpole
只在「更一般的形式（§2.4.4）」里才会分开出现，而**本文不用那种形式**。
⇒ **图里不得写「Witten 证明了 dilaton tadpole 为零」，只能写「那一个线性组合的 tadpole 为零（在 EW18 的条件下）」。**

**QW7** `1306.3621`（Notes On Holomorphic … Measures Of Low Genus）**不在 1209.5461 的 91 条参考文献里**
（抽取者逐条扫过参考文献页，未见）。**它与主线的关系是什么？** 摘要显示它只做亏格 1、2。
抽取者的读法：它是**独立的技术性笔记**，不是一致性论证链的一环。**未验证，正文未读。**

**QW8** 抽取者未能在 1209.5461 全文中找到任何**结论/总结章节**（目录里 §10 之后直接是附录 A–D）。
⇒ **「作者对自己是否完成了什么的总评」只能从 §1 与 1304.2832 §1 取**（EW1–EW5）。
**若 auditor 认为需要更强的证据，应指定重读 §7.7、§8.2.3、§9.3.6 这三处**（本轮未读，且从标题看最可能含总结性措辞）。

---

## 5. 给图的建议

> 以下是**建议**，不是改动。researcher 只写 `literature/`（`literature/CLAUDE.md` 规则 4）。

### 5.1 ★★★ `consistency.superstring-perturbative-consistency-unproven` 这张卡怎么写

`polchinski-1998-v2-ch12.md` §5.3 提议过这张卡。**本轮的结论是：不要写成一张卡，写成三张。**
理由：Polchinski 1998 的自评、Witten 2012–2023 的重构、Donagi–Witten 2013 的定理，
**三者的 kind 与 status 不同，混成一张会同时误报两个方向。**

```
(P1) consistency.superstring-perturbative-consistency-unproven-1998
     statement: 「截至 1998，超弦微扰论到任意阶的完整一致性没有显式证明。」
     kind: proposition （或项目里表示「作者自承缺口」的 kind）
     status: open      —— 这是一条**历史事实陈述**，其真值由原文逐字背书
     sources:
       - ref: polchinski-1998-v2   loc: "§12.5, p.126, 无式号"   （L1，逐字见 polchinski-1998-v2-ch12#E26）
     notes: "作者同时写了 'filling this technical gap does not seem to be a key issue'，那是价值判断不是证明。
             1998 之后的进展见 (P2)/(P3)，本卡**不因此失效**（它陈述的是 1998 年的状态）。"
     superseded_by: 不填 —— 历史陈述不被后续工作 supersede

(P2) consistency.superstring-perturbation-supermoduli-framework
     statement: 「在超模空间/积分链上（而非下降到普通模空间后）表述的超弦微扰论中，多圈振幅规范不变
                （已知反常除外）、在预期时具有时空超对称、且具有预期的红外行为。」
     kind: proposition
     status: physical-argument     ★ 不得写 rigorous
     sources:
       - ref: witten-2012-superstring-perturbation   loc: "arXiv:1209.5461v4, Abstract; §1, pp.2-3"   （L1）
       - ref: witten-2013-overview                   loc: "arXiv:1304.2832v4, §1, pp.1-2"            （L1）
     gaps（**必须全抄，逐字来源见 EW3/EW5/EW13/EW18/EW20**）:
       - "作者自称 'demonstration' 与 'well-placed to demonstrate'，不是 'proof'"
       - "适用域：不含质量重整化、不含需要真空移动的模型、不含 R-R 背景、不含 pure spinor、只用最简单一类顶点算符"
       - "归纳步挂在未证条件：'If (as in most cases) general arguments show that spacetime supersymmetry
          is not spontaneously broken at g-loop order'"
       - "开弦/无定向弦侧：'string theory is not well enough understood to make this statement completely clear'"
       - "PCO 分布错误是否给错答案：'It is not entirely clear if this remains true in higher genus'"
       - "主论文 arXiv:1209.5461 至今无期刊发表版（INSPIRE recid 1188034 无 publication_info）"
     notes: "版本必须写死 v4；v1 (2012) 不含对 Donagi-Witten 与 Sen-Witten 的引用，见本记录 §3.4。"

(P3) math.supermoduli-space-not-projected
     statement: 「亏格 g ≥ 5 时，超黎曼面模空间 𝔐_g 不可（全纯）投影，特别地不可分裂。」
     kind: theorem
     status: rigorous              ★ 本系列里唯一一条可以给 rigorous 的
     sources:
       - ref: donagi-witten-2013   loc: "arXiv:1304.7798v2, Theorem 1.1 (§1, p.5)"   （L1，逐字见 EW21）
     notes: "适用域红线：g ≥ 5；'g ≥ 3' 原文只是 'We suspect'；g = 2 未被否定；
             𝔐_{g,1} 是 Theorem 1.2（g ≥ 2，**仅偶自旋结构**）；𝔐_{g,n} 是 Theorem 1.3（g ≥ 2 且 g−1 ≥ n ≥ 1）；
             **偶 g + 奇自旋结构 + n ≥ 1 原文明说未解决**；**Remark 1.4：不考虑 Deligne-Mumford 紧化**；
             Remark 1.6：对象其实是 moduli **stack**。
             ⚠⚠ **不得写成「对超弦微扰论/PCO 方法的否定」**——原文 p.4 逐字：
             'The validity of superstring perturbation theory does not depend on a projection'。"
```

**边的建议**：
- `(P2) --depends_on--> (P3)`：**不要建。** Witten 在 §3.3.2 只是**引用** DW 说明「不能指望有全局投影」，
  他的框架本来就不假设投影；建这条边会把因果讲反。**正确做法是在 (P2) 的 `notes` 里写一句交叉引用。**
- `(P1) --superseded_by--> (P2)`：**不要建。** (P1) 是 1998 年的历史陈述，(P2) 没有把它变成假。
  两者的关系是「后续进展」，建议用项目里的 `related`/`notes` 而不是 `superseded_by`。

### 5.2 ★★ 建议再建两张「策略被否定」的卡（这是 DW 的真正物理含义）

```
(P4) worldsheet.reduction-to-ordinary-moduli-space-strategy-fails-high-genus
     statement: 「『先沿超模空间到其约化空间的全纯投影的纤维积分、从而把超弦振幅化为普通模空间上的积分』
                 这一策略，在高亏格（g ≥ 5）不存在，因为所需的全纯投影不存在。」
     kind: proposition
     status: rigorous（数学部分）/ 但「策略」这一层是 physical-argument
     sources:
       - ref: donagi-witten-2013   loc: "arXiv:1304.7798v2, Abstract; §1, p.4"   （L1，逐字见 EW21/EW22）
       - ref: witten-2012-superstring-perturbation  loc: "arXiv:1209.5461v4, §3.3.2, pp.35-36"  （L1，EW7/EW8）
     notes: "DW 摘要逐字：'certain approaches to superstring perturbation theory that are very powerful in
             low orders have no close analog in higher orders'。
             **低亏格（含 g=2 的 D'Hoker-Phong 计算）不受影响**——Witten §3.3.2 逐字承认
             'Supermoduli space is holomorphically projected in low orders'。"

(P5) worldsheet.pco-prescription-derived-from-odd-moduli-integration
     statement: 「图像变换算符 𝒴(p) = δ(β(p))S_zθ(p) 是『取 delta 函数引力微子波函数并积掉相应奇模』的结果。」
     kind: proposition
     status: physical-argument
     sources:
       - ref: witten-2012-superstring-perturbation  loc: "arXiv:1209.5461v4, §3.6.1-3.6.2, (3.88)/(3.94)/(3.95)/(3.97), pp.44-45"  （L1，EW10）
     notes: "★ 这是对 polchinski-1998-v2-ch12#E27 的 'rather ad hoc' 的直接回应。
             gaps：(a) 原文自陈 𝒴(p) 的定义仍需澄清（S_zθ 与 δ(β) 的 OPE 奇异，靠 BRST 或光滑化定义）；
             (b) (3.99) 给出伪奇点判据，PCO 处方只在局部有效；
             (c) PCO 位置重合时『没有极限』（p.47 逐字）。"
```

### 5.3 ★ 建议给既有卡补 `gaps` / `notes`（不新建）

| 既有/建议 id | 建议动作 | 依据 |
|---|---|---|
| Polchinski §12.5 PCO 相关的卡（若已建） | `notes` 加一句「1998 年的 'ad hoc' 与 'subtle ambiguity at higher genus' 在 `witten-2012-superstring-perturbation#EW9/EW10/EW12` 得到诊断与处方」 | EW9/EW10/EW12 |
| `consistency` 区所有依赖「超弦微扰论一致」的卡 | `gaps` 里把 (P2) 的六条限定原样搬运 | EW3/EW5/EW13/EW18/EW20 |
| type I / open-string tadpole 相关卡 | `notes` 加 Witten §9.4 的升级陈述与其保留语 | EW20 |
| `conv.*`（模空间测度约定） | **暂不动**，见 QW5 | — |

### 5.4 Lean 岛候选：**本轮零条**

- Donagi–Witten 的定理是代数几何/上同调障碍类层面的结果，**证明本轮未读**，且依赖 `𝔐_g` 作为 stack 的构造
  （Remark 1.6）。Mathlib 里既没有超流形也没有超黎曼面，**形式化成本远超本项目 Phase 1 的能力**。
- Witten 系列里没有可机检的纯代数恒等式（对比 `polchinski-1998-v2-ch12` §5.4 的 A8/A9/A10）。
- **唯一可能的低价值候选**：(3.107) `r − s = 2g − 2` 与图像数守恒的整数计数（`omega` 一行），
  但它依赖大量未形式化的背景，**不建议现在做**。

### 5.5 **不得**挂到本系列的东西（红线）

| 内容 | 为什么不行 |
|---|---|
| 「Witten 2012 证明了超弦微扰论一致」 | EW1/EW2/EW5：自称是 "demonstration"、"well-placed to demonstrate"，且 EW3 列了五条排除项 |
| 「Donagi–Witten 反驳了超弦微扰论 / PCO 方法」 | EW22 逐字：「The validity of superstring perturbation theory does not depend on a projection」；PCO 见 EW14 被补丁化 |
| 「超模空间不可投影」不带亏格条件 | EW21：`g ≥ 5`（无穿孔）；`g ≥ 3` 只是 "suspect"；紧化不在讨论范围（Remark 1.4） |
| 「Witten 证明了 dilaton tadpole 为零」 | EW19：只有 dilaton 与度规迹的**一个线性组合**；且 EW18 的归纳挂在一个未证的 "if" 上 |
| 把 1209.5461 的式号写成期刊页码/式号 | §3.1：**本文无期刊版**；式号只在 arXiv v4 下有效 |
| 「1209.2459 = Superstring Perturbation Theory Revisited」 | §0.0：号↔标题映射，1209.2459 是 *Notes On Super Riemann Surfaces And Their Moduli* |
| 引 1209.5461 的式号而不写 v4 | §3.4：v1 (2012) 与 v4 (2023) 的引文集合不同，§1 与 §3.5 有整段差异 |
| 「Witten 用了 Polchinski 的全部约定」 | §1.1：原文只说 "generally follow"，且限定在 §5.3 |
| 1209.2199/1209.2459/1306.3621/1307.5124/1404.6257/1504.00609 的任何式号、定理号 | §3.2：**正文一字未读**，只有摘要（L2） |
| DW 的任何编号引理/命题（除 Thm 1.1/1.2/1.3、Remark 1.4/1.5/1.6） | §3.2：§2 起的正文未读 |

---

## 6. `sources.bib` 与 `reading-list.md` 的改动（本轮已做）

| 文件 | 改动 |
|---|---|
| `literature/sources.bib` | **新增 7 条**（文件末尾，带小节注释头）：`witten-2012-superstring-perturbation`（1209.5461，**L1 部分章节**）、`witten-2013-overview`（1304.2832，**L1 §1+§2.1**）、`witten-2012-srs-notes`（1209.2459，L2）、`witten-2012-supermanifolds-notes`（1209.2199，L2）、`donagi-witten-2013`（1304.7798，**L1 摘要+§1**）、`witten-2013-holomorphic-measures`（1306.3621，L2）、`sen-witten-2015-pco`（1504.00609，L2）。每条 note 都写死版本戳、发表状况（含「无期刊版」这一否定结论）、以及该条的使用红线 |
| `literature/reading-list.md` | 原 `witten-2012-super-riemann` 行**划废**（ref key 与号↔标题映射都错），改写为 `witten-2012-superstring-perturbation` 行：标 `partially extracted`，列已读/未读章节、对 Q7 的三条硬结论、版本红线、下一轮三个最高性价比目标 |
| `literature/reading-list.md`「已知获取路线备忘」 | 新增两条：**`export.arxiv.org/api/query?id_list=…` 一次钉死一批号↔标题↔版本**（并记「arXiv 元数据标题 ≠ PDF 标题页」这个新踩到的坑）；**`inspirehep.net/api/literature?q=arxiv:… &fields=publication_info` 一次查一批有无期刊版**（本轮的关键否定证据） |

**未做（留给 lead / curator）**：
- 未在 `sources.bib` 里登记 `witten-2013-feynman-ie`（1307.5124，JHEP 1504 (2015) 055）与
  `donagi-witten-2014-atiyah`（1404.6257，PAMQ 9 (2013) 739–788）—— 两者正文均未读，且本轮的结论不依赖它们。
  元数据已在 §3.1 表中备好，需要时可直接抄。
- 未动 `graph/`（`literature/CLAUDE.md` 规则 4）。§5 的五张卡（P1–P5）是**建议**，由 curator/auditor 决定。
