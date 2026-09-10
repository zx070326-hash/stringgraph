# 抽取记录：polchinski-1998-v2

- 文献：J. Polchinski, *String Theory. Vol. 2: Superstring Theory and Beyond*, Cambridge University Press, 1998.
- 抽取者：researcher agent
- 日期：2026-09-11
- 覆盖范围：第 10 章 §10.1–§10.8（全章，pp. 1–44）；第 11 章 §11.1–§11.6（pp. 45–83）

---

## 0. 核实方法与证据等级（必读，与 v1 的方法论不同，务必先读）

**⚠ 与 `polchinski-1998-v1.md` 的最大差别：本次抽取取得了第 10 章与第 11 章的一手正文。**

v1 抽取记录（2026-09-10）在 §0 声明「没有取得该书正文全文」，所有条目都是转述 + 二手源核对。
**本次不同**：本轮通过 Cambridge Core 的机构授权（环境所在网络持有 Cambridge Books Online 订阅，
PDF 水印显示 "Zhejiang University"）取得了

- **第 10 章全章 PDF**（`9780511618123c1_p1-44_CBO.pdf`，44 页，书页 pp. 1–44），
- **第 11 章全章 PDF**（`9780511618123c2_p45-83_CBO.pdf`，39 页，书页 pp. 45–83），
- **目录 PDF**（`9780511618123toc_pix-xii_CBO.pdf`，书页 pp. ix–xii），
- **前置页 PDF**（`9780511618123pre_pi-viii_CBO.pdf`，书页 pp. i–viii，含版权页）。

抽取者用 `Read` 工具逐页读了这些 PDF 的**页图**（不是检索后端转述）。因此：

> **本记录全部条目的「位置（章节/式号）」都是 L1（一手直读），可以直接写进图节点的 `sources[].loc`。**
> **「文献自称的严格程度」栏也照抄了 Polchinski 的原措辞**（这是 v1 做不到的）。
> **唯一的例外**：第 11 章 pp. 56–58（§11.3 中段）与 pp. 61–65（§11.4 中段）本轮**跳读**，
> 那两段里的式号（(11.4.11)–(11.4.21) 等）只在别处被引用时见到，其**内容**未核实（见 E59 与 §3.2）。

### 0.1 版本锚定（重要）

版权页（书页 p. iv，L1 直读）逐字：

> "First published 1998 / Reprinted 1999, 2000 (with corrections), 2002 (twice), 2003 / Paperback edition first published 2005 / … / ISBN 978-0-521-67228-3 paperback / Transferred to digital printing 2007"

**本记录读到的是 Cambridge Books Online 版（© Cambridge University Press 2001, 2005；DOI 10.1017/CBO9780511618123），
即 2005 平装本的数字化。它已经包含 2000 年那次 "with corrections" 的订正。**
若日后有人拿 1998 年初印本核对，**式号原则上不变，但个别公式内容可能与本记录不同**。
`sources.bib` 里 `polchinski-1998-v2` 若不注明印次，建议补一句「按 2005 平装/CBO 版核对」。

### 0.2 各来源与代号

| 代号 | 来源 | 等级 | 用途 |
|---|---|---|---|
| **[P]** | 原书第 10 章 PDF（CUP/Cambridge Core 授权下载，pp. 1–44）与第 11 章 PDF（pp. 45–83） | **L1 一手** | 全部式号、公式、原文措辞 |
| **[T]** | 原书目录 PDF（pp. ix–xii） | **L1 一手** | 全书节标题与起始页码 |
| **[F]** | 原书前置页 PDF（pp. i–viii） | **L1 一手** | 版本/印次 |
| **[CC]** | Cambridge Core 书目页（章级页码范围） | **L1**（网页直读） | 章起止页，与 [T] 互校 |
| **[H]** | M. Headrick, *A solution manual for Polchinski's "String Theory"*, arXiv:0812.4408v1 | **L1**（PDF 页图直读） | 第 10、11 章习题解答；用作**独立第二源** |
| **[S]** | Schrans, *A Companion Reader to Polchinski's String Theory* | — | **对本卷不存在**（见下） |

**★ 一条对后续所有 Vol.2 工作都重要的否定结论：**
v1 抽取最强的核对源 [S]（Schrans 伴读笔记）**没有第 2 卷版本**。
hepnotes.com 首页（L1 直读）只挂三份 PDF：QFT notes (2025-08)、Joe's Book string notes (2020-11)、GR/Cosmology notes (2023-01)，
并**明写这份 string 笔记只覆盖「the first 8 chapters of volume 1」**。
`joes-book-2.pdf` 不存在（首页无此链接，定向检索也只返回 `joes-book-1.pdf` 的两个 URL）。
→ **不要再花额度找 Schrans 的 Vol.2 笔记。**

### 0.3 证据等级标记（每条「位置」栏都带）

- `[L1 原书]`：抽取者本轮逐页读了原书该页的页图，式号与内容均直接看到。**本记录绝大多数条目是这一级。**
- `[L1 [H]]`：式号出自 Headrick 解答手册正文，抽取者逐页读到；但**内容是 [H] 的推导/转述，不是原书文字**。
- `[L1 目录]`：节标题与起始页出自原书目录页图。
- `[未核实]`：无任何一手确认（本记录里只出现在 E59 所列的 §11.4 中段式号）。

### 0.4 [T] 确认的节起止页（L1，原书目录 pp. ix–x 逐字）

| 节 | 页 | 节 | 页 |
|---|---|---|---|
| **10 Type I and type II superstrings** | **1** | **11 The heterotic string** | **45** |
| 10.1 The superconformal algebra | 1 | 11.1 World-sheet supersymmetries | 45 |
| 10.2 Ramond and Neveu–Schwarz sectors | 5 | 11.2 The SO(32) and E₈ × E₈ heterotic strings | 49 |
| 10.3 Vertex operators and bosonization | 10 | 11.3 Other ten-dimensional heterotic strings | 55 |
| 10.4 The superconformal ghosts | 15 | 11.4 A little Lie algebra | 59 |
| 10.5 Physical states | 20 | 11.5 Current algebras | 66 |
| 10.6 Superstring theories in ten dimensions | 25 | 11.6 The bosonic construction and toroidal compactification | 73 |
| 10.7 Modular invariance | 31 | Exercises | 82 |
| 10.8 Divergences of type I theory | 37 | （12 Superstring interactions） | 84 |
| Exercises | 43 | | |

[CC] 独立给出章级页范围：**ch.10 = pp. 1–44，ch.11 = pp. 45–83**，与 [T] 一致（双源核实）。
另记两条与本项目相关的后文位置（[T]，L1）：**15.1 Representations of the Virasoro algebra = p. 228；
15.6 Representations of the N = 1 superconformal algebra = p. 254**。→ 若图里要挂「超 Virasoro 的表示论」，
本卷的正经出处是 **§15.6**，不是第 10 章。

### 0.5 ⚠ 任务书范围与原书实际结构的偏差（**必须先看**）

派活时给的范围是「§10 超弦的 RNS 形式、**§11 超弦谱与 GSO 投影**」。
**按 [T]/[CC]（L1），这个假设不成立：**

- **第 11 章是 "The heterotic string"（杂化弦），不是超弦谱/GSO。**
- 任务书列的全部题目——RNS 作用量、超共形代数、NS/R 边界条件、βγ 与 c = 11、D = 10、超弦 BRST 荷、
  **GSO 投影与快子消除、type IIA/IIB/I 谱、超弦无鬼定理**——**全部落在第 10 章之内**
  （GSO 与 IIA/IIB/I 在 §10.6，无鬼定理在 §10.5 末）。
- `reading-list.md` 原先写的范围「§10–§12」里，§12 是 "Superstring interactions"，也不是 GSO。

→ 本记录把第 10 章抽全（**E1–E49**），第 11 章按其**真实内容**（杂化弦）抽（**E50–E63**），并在 §4 Q1 记下这个偏差。

---

## 1. 约定

### 1.1 该书自述的约定（第 10 章内，L1 原书）

| 项 | Polchinski Vol.2 的取法 | 核实情况 |
|---|---|---|
| 与 Vol.1 的关系 | 沿用第 1 卷的记号与约定；本卷 "Notation" 在 pp. xviii–xx（[T] L1 确认存在，**本轮未读该三页**） | 位置已核实，内容未读 |
| 度规号差 | `(−,+,…,+)`（沿用 Vol.1）。§10.1 正文逐字：「Because of the **Minkowski signature of spacetime** the timelike `ψ⁰` and `ψ̃⁰`, like `X⁰`, have opposite sign commutators and lead to negative norm states」（p. 3） | **L1 原书** |
| `α'` | 显式保留。**但 §10.1 明确提示可以取 `α' = 2`**：「The annoying factors of `(2/α')^{1/2}` could be eliminated by working in units where `α' = 2`, and then be restored if needed by dimensional analysis」（p. 2，(10.1.8) 下方） | **L1 原书逐字** |
| 正规序 | 「throughout this volume the `: :` normal ordering of coincident operators **will be implicit**」（p. 2） ⚠ 与 Vol.1 显式写 `: :` 的体例不同 | **L1 原书逐字** |
| 创生-湮灭正规序 | 另用 `°  °` 记号（(10.2.12)、(10.4.4) 中出现），「Again `°°` denotes creation–annihilation normal ordering」（p. 7） | **L1 原书** |
| `XX` OPE | `X^μ(z,z̄)X^ν(0,0) ∼ −(α'/2) η^{μν} ln|z|²`（(10.1.6)，明写 "For reference we recall from chapter 2"） | **L1 原书** |
| `ψψ` OPE | `ψ^μ(z)ψ^ν(0) ∼ η^{μν}/z`，`ψ̃^μ(z̄)ψ̃^ν(0) ∼ η^{μν}/z̄`（(10.1.7)） | **L1 原书** |
| 非嵌入标量的归一化 | `H(z)H(0) ∼ −ln z`（(10.3.5)）。原文：「For world-sheet scalars **not associated directly with the embedding** of the string in spacetime this is the normalization we will always use, **corresponding to `α' = 2` for the embedding coordinates**」（p. 11） ⚠ 玻色化用的 `H`、`φ`、`χ`、`ρ` 全按这套 | **L1 原书逐字** |
| 超流归一化 | `T_F(z) = i(2/α')^{1/2} ψ^μ(z) ∂X_μ(z)`（(10.1.8)） | **L1 原书** |
| 超 Virasoro 归一化 | `{G_r, G_s} = 2L_{r+s} + (c/12)(4r²−1)δ_{r,−s}`；`[L_m,G_r] = ((m−2r)/2)G_{m+r}`（(10.2.11b,c)） | **L1 原书** |
| 超共形 OPE 归一化 | `T_F(z)T_F(0) ∼ 2c/(3z³) + (2/z)T_B(0)`（(10.1.15c)） ⚠ 与常见的 `G(z)G(0) ∼ (2c/3)/z³ + 2T/z` 同形，但 Polchinski 的场叫 `T_F` 不叫 `G`（模式仍叫 `G_r`） | **L1 原书** |
| 世界面坐标 | 柱面坐标 `w = σ¹ + iσ²`（(10.2.1) 上方），`w ≅ w + 2π`，即**周长取 2π**（不是 Vol.1 §1.3 的任意 `ℓ`） | **L1 原书** |

### 1.2 与 `graph/conventions/` canonical 约定的对照

| canonical 节点 | 一致？ | 说明 |
|---|---|---|
| `conv.metric-mostly-plus` | **一致** | Vol.2 沿用；§10.1 p.3 有正文背书（见上表）。 |
| `conv.alpha-prime-regge` | **一致，但要小心** | Vol.2 里 `α'` 仍是 Regge 斜率，但书中**两处**提示可取 `α' = 2`（(10.1.8) 下方、(10.3.5) 下方）。**(10.3.5) 那一处不是「可以取」而是「就是这么取的」**：所有玻色化标量按 `α'=2` 归一。→ curator 若从 §10.3/§10.4 抽公式，`conv` 声明必须写清楚是哪一套。 |
| `conv.virasoro-standard`（`[L_m,L_n] = (m−n)L_{m+n} + (c/12)m(m²−1)δ_{m,−n}`） | **一致** | (10.2.11a) 写作 `(c/12)(m³−m)δ_{m,−n}`，与 `m(m²−1)` 恒等。 |
| `conv.worldsheet-euclidean` | **一致** | §10.2 用 `w = σ¹ + iσ²`，与 Vol.1 §2.1 同一套。 |
| **正规序常数符号** | **⚠ 与 Vol.1 不同，见 §1.3** | Vol.2 用 `a^m` / `a^g`，**不再用 Vol.1 §4.1 的 `A`**。 |

### 1.3 ⚠ 会咬人的记号差异（三条）

1. **正规序常数：Vol.1 用 `A`，Vol.2 用 `a^m`、`a^g`，且符号约定相反。**
   Vol.1 §4.1 写 `(L_0^m + A)|ψ⟩ = 0`，`A = −1`（见 `polchinski-1998-v1.md` §1.3）。
   Vol.2 (10.2.12a) 把常数写在 `L_m` **内部**：`L_m = … + a^m δ_{m,0}`，于是物理态条件就是 `L_0|ψ⟩ = 0`（(10.5.3)）。
   **换算：Vol.2 的 `a^m` = Vol.1 的 `A`（同号），= 通行的 `−a`。**
   Vol.2 的值（(10.2.13)，L1）：**R 扇区 `a^m = D/16`；NS 扇区 `a^m = 0`**。鬼场（(10.4.5)，L1）：**R `a^g = −5/8`，NS `a^g = −1/2`**。
   `D = 10` 时 R：`10/16 − 5/8 = 0` ✓；NS：`0 − 1/2 = −1/2` ✓，与 (10.5.4) 的 `H = α'p² + N − 1/2`（NS）一致。
   ⚠ **玻色弦的 `a^g = −1`（v1 记录 E43 订正过的那个数）在这里变成 `−1/2`（NS）与 `−5/8`（R）**，不要混。
2. **`c` vs `ĉ`。** (10.2.13) 上方一句正文写「Including the shift `+ (1/16)c = (1/16)D`」（p. 7）。
   按 (10.1.14) `c = (3/2)D`，`(1/16)c ≠ (1/16)D`，**字面不自洽**。抽取者判断印的是带帽的 `ĉ ≡ (2/3)c = D`
   （超共形文献的标准记号），但**页图上帽子是否存在没能 100% 分辨**。→ 记为 §4 Q3，**式号 (10.2.13) 本身与两个结果值 `D/16` / `0` 是清楚的，可放心引用**。
3. **`T_F` 是场，`G_r` 是它的模式。** Polchinski 不用 `G(z)`。(10.2.10a)：`T_F(z) = Σ_{r∈Z+ν} G_r / z^{r+3/2}`。
   从别的文献（写 `G(z)`）抽的边接过来时不要以为是两个对象。

---

## 2. 陈述

> 第 10 章条目（E1–E45）的「原文陈述」在标了「逐字」的地方是**逐字**的，其余是忠实转述；
> 「文献自称的严格程度」栏**照抄了 Polchinski 的原措辞**（这是 v1 做不到的）。

### E1 本章的定位与「猜出来的」超共形对称性 ★
- 位置：§10.1 章首段（p. 1）`[L1 原书]`
- 类型：（纲领性陈述，非命题）
- 原文陈述（**逐字**）：「Having spent volume one on a thorough development of the bosonic string, we now come to our real interest, the supersymmetric string theories. This requires a generalization of the earlier framework, enlarging the world-sheet constraint algebra. This idea arises naturally if we try to include spacetime fermions in the spectrum, and **by guesswork** we are led to *superconformal symmetry*. In this chapter we discuss the (1,1) superconformal algebra and the associated type I and II superstrings. Much of the structure is directly parallel to that of the bosonic string so we can proceed rather quickly, focusing on the new features.」
- 文献自称的严格程度：**"by guesswork"**（作者自称）
- 文献列出的依赖：Vol.1 全书
- 备注：★ 这句「by guesswork」对本项目很有价值：**RNS 形式在本书里的起点不是推导，是猜测 + 事后验证**。
  → curator 若为「RNS 作用量」建节点，`status` 不应高于 `physical-argument`；且这条自述可直接引用作为理由。

### E2 从 Dirac 方程出发的启发式动机
- 位置：§10.1，eq. **(10.1.1)–(10.1.4)**（p. 1–2）`[L1 原书]`
- 类型：（启发式论证）
- 原文陈述：玻色弦的质量壳条件 `p_μp^μ + m² = 0`（(10.1.1)）来自物理态条件 `L_0|ψ⟩ = 0`（(10.1.2)），
  这是动量空间的 Klein–Gordon 方程；要得到时空费米子就需要 Dirac 方程 `ip_μΓ^μ + m = 0`（(10.1.3)）。
  由于 `L_0`、`L̃_0` 是世界面能动张量 `(T_B, T̃_B)` 的质心模，猜测需要新的守恒量 `T_F`、`T̃_F`，其质心模给出 Dirac 方程；
  又因 `p^μ` 是世界面流 `(∂X^μ, ∂̄X^μ)` 的质心模，自然猜测 gamma 矩阵 `{Γ^μ, Γ^ν} = 2η^{μν}`（(10.1.4)）
  是一个反对易世界面场 `ψ^μ` 的质心模。
- 文献自称的严格程度（**逐字**）：「it is **natural to guess**」；「This is one way to **motivate** the following generalization, and it will lead us to all the known consistent string theories.」
- 文献列出的依赖：Vol.1 §4.1（`L_0|ψ⟩=0`）
- 备注：注意末句「it will lead us to all the known consistent string theories」是**结果陈述**，不是论证。

### E3 RNS（超共形）世界面作用量 ★
- 位置：§10.1，eq. **(10.1.5)**（p. 2）`[L1 原书]`
- 类型：definition
- 原文陈述（**逐字公式**）：`S = (1/4π) ∫ d²z ( (2/α') ∂X^μ ∂̄X_μ + ψ^μ ∂̄ψ_μ + ψ̃^μ ∂ψ̃_μ )`
- 文献自称的严格程度：「With this in mind, we **consider** the world-sheet action」——**是直接写下的定义，不是推出来的**
- 文献列出的依赖：E2（动机）；`ψ` 的 CFT 引用 Vol.1 **§2.5**（「The `ψ` conformal field theory (CFT) was described in section 2.5」）
- 备注：★ 本条是全章的公设起点。**书中没有从任何超对称的 `diff × Weyl` 不变作用量把它推出来**（见 E27 的自述）。
  → 图节点 `status` 建议 `definition` + 该节点所在的推导链标 `physical-argument`。

### E4 世界面超流
- 位置：§10.1，eq. **(10.1.8)**（p. 2）`[L1 原书]`
- 类型：definition
- 原文陈述（**逐字公式**）：`T_F(z) = i(2/α')^{1/2} ψ^μ(z) ∂X_μ(z)`，`T̃_F(z̄) = i(2/α')^{1/2} ψ̃^μ(z̄) ∂̄X_μ(z̄)`；
  斜体术语 *world-sheet supercurrents*。
- 文献自称的严格程度：定义（无论证措辞）
- 文献列出的依赖：E3
- 备注：紧接一句给出了本卷的两条约定（`α'=2` 可选、`::` 隐含），见 §1.1。
  再下一段（**逐字**）：「This gives the desired result: the modes `ψ_0^μ` and `ψ̃_0^μ` will satisfy the gamma matrix algebra, and the centers-of-mass of `T_F` and `T̃_F` will have the form of Dirac operators. We will see that the resulting string theory has spacetime fermions as well as bosons, and that **the tachyon is gone**.」

### E5 超共形变换与其生成流
- 位置：§10.1，eq. **(10.1.9)**、**(10.1.10a,b,c)**（p. 2）`[L1 原书]`
- 类型：proposition
- 原文陈述：流 `j^η(z) = η(z)T_F(z)`、`j̃^η(z̄) = η(z)* T̃_F(z̄)`（(10.1.9)）生成*超共形变换*
  `ε^{−1}(2/α')^{1/2} δX^μ = η(z)ψ^μ(z) + η(z)*ψ̃^μ(z̄)`（(10.1.10a)）、
  `ε^{−1}(α'/2)^{1/2} δψ^μ(z) = −η(z)∂X^μ(z)`（(10.1.10b)）、
  `ε^{−1}(α'/2)^{1/2} δψ̃^μ(z̄) = −η(z)*∂̄X^μ(z̄)`（(10.1.10c)）。
  参数 `η(z)` 是反对易的（因为变换把对易场 `X` 与反对易场 `ψ` 混起来），且与共形变换一样是任意的（反）全纯函数。
- 文献自称的严格程度（**逐字**）：「From the OPE and the Ward identity it **follows (exercise 10.1)** that the currents … generate the superconformal transformation」；
  「That this is a symmetry of the action (10.1.5) **follows at once** because the current is (anti)holomorphic, and so conserved.」
- 文献列出的依赖：E3、E4；Vol.1 的 OPE 与 Ward 恒等式（Vol.1 §2.3）
- 备注：**⚠ 关键论证被推给习题 10.1。**[H] 的 Problem 10.1 解答（L1）确认：(a) 先算
  `T_F(z)X^μ(0) ∼ −i(α'/2)^{1/2} ψ^μ(0)/z`、`T_F(z)ψ^μ(0) ∼ i(α'/2)^{1/2} ∂X^μ(0)/z`；
  (b)「The result follows trivially from **(2.3.11)** and the above OPEs」——即用 Vol.1 (2.3.11)（OPE 单极点决定变换律，
  已在 `polchinski-1998-v1.md` E29 核实）。→ curator 建边时，这条依赖 Vol.1 (2.3.11) **是文献明写的**，不必标 `inferred`。

### E6 超共形变换的闭合
- 位置：§10.1，eq. **(10.1.11)**（p. 3）`[L1 原书]`
- 类型：proposition
- 原文陈述（**逐字公式**）：`δ_{η₁}δ_{η₂} − δ_{η₂}δ_{η₁} = δ_v`，`v(z) = −2η₁(z)η₂(z)`，
  即两个超共形变换的对易子是一个共形变换；类似地共形与超共形变换的对易子是超共形变换。
  「The conformal and superconformal transformations thus close to form the *superconformal algebra*.」
- 文献自称的严格程度（**逐字**）：「**as the reader can check** by acting on the various fields」——**书中不证**
- 文献列出的依赖：E5
- 备注：[H] Problem 10.2（L1）逐条验算了这一条（对 `X`、`ψ`、`ψ̃`），并引用 Vol.1 **(2.4.7)**。
  → 若要给这条挂推导，`sources` 可以同时写 Polchinski (10.1.11) + Headrick Problem 10.2。

### E7 `X ψ` SCFT 的能动张量与超共形 OPE ★
- 位置：§10.1，eq. **(10.1.12)**、**(10.1.13a,b,c)**（p. 3）`[L1 原书]`
- 类型：definition / proposition
- 原文陈述（**逐字公式**）：
  `T_B = −(1/α')∂X^μ∂X_μ − (1/2)ψ^μ∂ψ_μ`（(10.1.12)）；
  `T_B(z)T_B(0) ∼ 3D/(4z⁴) + (2/z²)T_B(0) + (1/z)∂T_B(0)`（(10.1.13a)）；
  `T_B(z)T_F(0) ∼ (3/(2z²))T_F(0) + (1/z)∂T_F(0)`（(10.1.13b)）；
  `T_F(z)T_F(0) ∼ D/z³ + (2/z)T_B(0)`（(10.1.13c)）。
  「That is, only `T_B` and `T_F` appear in the singular terms」；「The `T_B T_F` OPE implies that `T_F` is a tensor of weight `(3/2, 0)`.」
- 文献自称的严格程度：直接给出 OPE，无论证措辞（Wick 缩并的直接计算）
- 文献列出的依赖：E3、E4、E6
- 备注：**双源核实**：[H] Problem 10.3(a)（L1）逐字写「which does indeed reproduce **(10.1.13a)**」，
  并独立算出 `T_F T_F ∼ D/z³ − (2/α'z)∂X_μ∂X^μ + (1/z²)ψ^μψ_μ`（其化简即 (10.1.13c)）。
  ⚠ [H] 在 Problem 10.3(b) 里印的是「the right hand side of **(10.1.1b)**」——**页图上确实少一个 `3`**；
  按上下文（(a) 用 (10.1.13a)，(b) 讨论线性 dilaton 的额外项）**应为 (10.1.13b)**。这是 [H] 的排印疏漏，不是原书问题。

### E8 `X ψ` SCFT 的中心荷 `c = (3/2)D` ★
- 位置：§10.1，eq. **(10.1.14)**（p. 3）`[L1 原书]`
- 类型：proposition
- 原文陈述（**逐字**）：「Each scalar contributes 1 to the central charge and each fermion `1/2`, for a total」
  `c = (1 + ½)D = (3/2)D`（(10.1.14)）。
- 文献自称的严格程度：由 (10.1.13a) 的 `3D/(4z⁴)` 直接读出（与 (10.1.15a) 的 `c/(2z⁴)` 比对）
- 文献列出的依赖：E7；Vol.1「每个自由标量 `c = 1`」（= v1 记录 E34，**那条在 v1 里是唯一没有锚点的核心陈述**）、
  Vol.1 §2.5 的「每个自由 Majorana 费米子 `c = 1/2`」
- 备注：★ 这是 `D = 10` 的直接输入。注意 **v1 的 Q4（「自由标量 `c=1` 找不到式号」）在这里没有被解决**——
  Vol.2 只是复述结论，没给 Vol.1 的式号。

### E9 约束代数的作用与负范数态的来源
- 位置：§10.1，(10.1.14) 之后一段（p. 3）`[L1 原书]`
- 类型：（纲领性陈述）
- 原文陈述（**逐字**）：「This enlarged algebra with `T_F` and `T̃_F` as well as `T_B` and `T̃_B` will play the same role that the conformal algebra did in the bosonic string. That is, we will impose it on the states as a constraint algebra — it must annihilate physical states, either in the sense of old covariant quantization (OCQ) or of Becchi–Rouet–Stora–Tyutin (BRST) quantization. Because of the Minkowski signature of spacetime the timelike `ψ⁰` and `ψ̃⁰`, like `X⁰`, have opposite sign commutators and lead to negative norm states. **The fermionic constraints `T_F` and `T̃_F` will remove these states from the spectrum.**」
- 文献自称的严格程度：纲领声明（"will"）
- 文献列出的依赖：E7、E8
- 备注：末句是无鬼定理（E33）的预告。

### E10 一般 `N = 1` 超共形代数（OPE 形式）★
- 位置：§10.1，eq. **(10.1.15a,b,c)**（p. 4）`[L1 原书]`
- 类型：definition
- 原文陈述（**逐字公式**）：
  `T_B(z)T_B(0) ∼ c/(2z⁴) + (2/z²)T_B(0) + (1/z)∂T_B(0)`（(10.1.15a)）；
  `T_B(z)T_F(0) ∼ (3/(2z²))T_F(0) + (1/z)∂T_F(0)`（(10.1.15b)）；
  `T_F(z)T_F(0) ∼ 2c/(3z³) + (2/z)T_B(0)`（(10.1.15c)）。
  「Here, `N = 1` refers to the number of `(3/2, 0)` currents. In the present case there is also an antiholomorphic copy of the same algebra, so we have an `(N, Ñ) = (1,1)` *superconformal field theory (SCFT)*. We will consider more general algebras in section 11.1.」
- 文献自称的严格程度（**逐字**）：「The Jacobi identity **requires** the same constant `c` in the `T_BT_B` and `T_FT_F` products (**exercise 10.5**).」——**关键的「两个中心荷相等」被推给习题**
- 文献列出的依赖：E7
- 备注：[H] Problem 10.5（L1）给出该习题的解：设 `T_BT_B` 里的中心荷为 `c_B`、`T_FT_F` 里的为 `c_F`，用
  `0 = [L_m,{G_r,G_s}] + {G_r,[G_s,L_m]} − {G_s,[L_m,G_r]}` 算得
  `= (1/6)(c_B − c_F)(m³−m)δ_{m+r+s,0}`，故 `c_B = c_F`。**这是本记录里少数「习题给了完整证明」的地方。**
  → 与 `graph` 的接口：这条与 `worldsheet.virasoro-algebra-v2` 是**不同的陈述**（对象是 `(T_B,T_F)` 对，不是单个 `T`），
  但 (10.1.15a) 与 Vol.1 (2.4.24)/(2.6.19) 的 Virasoro 部分**逐字同形**。**本记录只记这个事实，不建议边。**

### E11 一般一阶 SCFT（`bc` + `βγ`）与其中心荷
- 位置：§10.1「Free SCFTs」小节，eq. **(10.1.16a,b)**、**(10.1.17)**、**(10.1.18a,b)**、**(10.1.19)**（p. 4）`[L1 原书]`
- 类型：definition / proposition
- 原文陈述（**逐字公式**）：
  权重 `h_b = λ, h_c = 1−λ`（(10.1.16a)）；`h_β = λ − 1/2, h_γ = 3/2 − λ`（(10.1.16b)）；
  作用量 `S_BC = (1/2π)∫d²z (b∂̄c + β∂̄γ)`（(10.1.17)）；
  `T_B = (∂b)c − λ∂(bc) + (∂β)γ − (1/2)(2λ−1)∂(βγ)`（(10.1.18a)）；
  `T_F = −(1/2)(∂β)c + ((2λ−1)/2)∂(βc) − 2bγ`（(10.1.18b)）；
  中心荷 `[−3(2λ−1)² + 1] + [3(2λ−2)² − 1] = 9 − 12λ`（(10.1.19)）。
- 文献自称的严格程度：「The various free CFTs described in chapter 2 have superconformal generalizations.」（陈述，无证明）
- 文献列出的依赖：Vol.1 §2.5（`bc` 与 `βγ` 系统的中心荷公式，= v1 记录 E36/E37）
- 备注：**(10.1.19) 的两个方括号就是 v1 E36 的 `−3(2λ−1)²+1` 与 v1 E37 的 `βγ` 反号版本**，
  即 Vol.1 **(2.5.12)** 与 **(2.5.24)**（v1 已核实这两个式号）。→ 这是 Vol.1 ↔ Vol.2 之间一条**可核实的真实依赖**。

### E12 超共形鬼场的中心荷 `−26 + 11 = −15` 与临界维数 `D = 10` ★★
- 位置：§10.1，eq. **(10.1.20)**（p. 4）`[L1 原书]`
- 类型：proposition
- 原文陈述（**逐字**）：「We can anticipate that the superconformal ghosts will be of this form with `λ = 2`, the anticommuting `(2,0)` ghost `b` being associated with the commuting `(2,0)` constraint `T_B` as in the bosonic theory, and the commuting `(3/2,0)` ghost `β` being associated with the anticommuting `(3/2,0)` constraint `T_F`. **The ghost central charge is then `−26 + 11 = −15`, and the condition that the total central charge vanish gives the critical dimension**」
  `0 = (3/2)D − 15 ⇒ D = 10`（(10.1.20)）。
- 文献自称的严格程度：「We can **anticipate**」（预告式），随后 §10.4 才正式引入鬼场；结论句用陈述语气
- 文献列出的依赖：E8（`c = (3/2)D`）、E11（(10.1.19) 在 `λ = 2` 给 `9 − 24 = −15`）；
  隐含 Vol.1 的 `bc` `c = −26`（v1 E36，Vol.1 (2.5.12)）与 `βγ` `c = +11`（v1 E37，Vol.1 **(2.5.24)**，v1 已核实）
- 备注：★★ **这是本抽取最重要的一条，且式号已 L1 核实。**
  - `−26 + 11 = −15` 这个拆分**在原书正文里逐字出现**，所以「βγ 贡献 +11」这条 Vol.1 → Vol.2 的依赖是**文献自己写出来的**，不必标 `inferred`。
  - ⚠ 但注意 Polchinski 在此处**只给了「总中心荷为零」这一条路线**。§10.5 之后有第二条独立路线：
    `Q_B² = 0 ⟺ c^m = 15`（E32），与玻色弦 Vol.1 (4.3.10) 平行。**本卷没有光锥规范洛伦兹不变性那条路线。**
  - 与 v1 的接口：v1 找到 `D = 26` 的**三条**独立推导；本卷 `D = 10` 只有**两条**（Weyl 反常/总中心荷、`Q_B²=0`）。
    按 v1 Q8 的建议，`D = 10` 应是**一条陈述挂两条 derivation**。

### E13 `λ = 2` 的鬼场能动张量与超流
- 位置：§10.1，eq. **(10.1.21a,b)**（p. 5）`[L1 原书]`
- 类型：definition
- 原文陈述（**逐字公式**）：`T_B = −(∂b)c − 2b∂c − (1/2)(∂β)γ − (3/2)β∂γ`（(10.1.21a)）；
  `T_F = (∂β)c + (3/2)β∂c − 2bγ`（(10.1.21b)）。
- 文献自称的严格程度：直接代入
- 文献列出的依赖：E11
- 备注：§10.5 的脚注 3（p. 24，L1 逐字）说明了一件容易被忽略的事：「The `bcβγ` theory actually has a one-parameter family of superconformal symmetries, related by rescaling `β → xβ` and `γ → x^{−1}γ`. **The general BRST construction (4.3.14) singles out the symmetry (10.1.21)**; this is most easily verified by noting that it correctly leads to the OPEs (10.5.22).」→ 这是一条**非平凡的选择**，转节点时应显式记录。

### E14 超共形线性 dilaton
- 位置：§10.1，eq. **(10.1.22a,b)**、**(10.1.23)**（p. 5）`[L1 原书]`
- 类型：definition / proposition
- 原文陈述（**逐字公式**）：`T_B(z) = −(1/α')∂X^μ∂X_μ + V_μ∂²X^μ − (1/2)ψ^μ∂ψ_μ`（(10.1.22a)）；
  `T_F(z) = i(2/α')^{1/2}ψ^μ∂X_μ − i(2α')^{1/2}V_μ∂ψ^μ`（(10.1.22b)）；`c = (3/2)D + 6α'V^μV_μ`（(10.1.23)）。
- 文献自称的严格程度（**逐字**）：「**The reader can verify** that these satisfy the `N = 1` algebra with」——书中不证
- 文献列出的依赖：E7、E10
- 备注：[H] Problem 10.3(b)（L1）做了这个验算。与 Vol.1 E35（线性 dilaton `c = D + 6α'V²`）平行。

---

### E15 NS/R 周期条件 ★
- 位置：§10.2，eq. **(10.2.1)**–**(10.2.4a,b)**（p. 5–6）`[L1 原书]`
- 类型：definition
- 原文陈述（**逐字公式**）：柱面上的物质费米作用量 `(1/4π)∫d²w (ψ^μ∂_w̄ψ_μ + ψ̃^μ∂_wψ̃_μ)`（(10.2.1)）
  在 `w ≅ w + 2π` 下不变，这个条件**加上洛伦兹不变性**只允许两种周期条件：
  **Ramond (R): `ψ^μ(w+2π) = +ψ^μ(w)`**（(10.2.2a)）、
  **Neveu–Schwarz (NS): `ψ^μ(w+2π) = −ψ^μ(w)`**（(10.2.2b)），
  「where the sign must be the same for all `μ`」。统一写作 `ψ^μ(w+2π) = exp(2πiν)ψ^μ(w)`、
  `ψ̃^μ(w̄+2π) = exp(−2πiν̃)ψ̃^μ(w̄)`（(10.2.3a,b)），`ν, ν̃ ∈ {0, 1/2}`。
  超流随之：`T_F(w+2π) = exp(2πiν)T_F(w)`（(10.2.4a)）、`T̃_F(w̄+2π) = exp(−2πiν̃)T̃_F(w̄)`（(10.2.4b)）。
- 文献自称的严格程度（**逐字**）：「This condition plus Lorentz invariance **still allows two possible periodicity conditions**」；
  对 `X^μ` 周期性的理由是「Since we are initially interested in theories with the maximum Poincaré invariance, `X^μ` must be periodic.」
- 文献列出的依赖：E3
- 备注：**⚠ 一条容易漏的限定**：反周期 `X^μ` 并非不可能，Polchinski 明写「(Antiperiodicity of `X^μ` is interesting, and we have already encountered it for the twisted strings on an orbifold, but **it would break some of the translation invariance**.)」
  → 「只有 R 与 NS 两种」这个结论**依赖「要最大 Poincaré 不变性」这个额外假设**，转节点时必须写进陈述本身。

### E16 四个闭弦扇区
- 位置：§10.2，(10.2.4) 下方（p. 6）`[L1 原书]`
- 类型：proposition
- 原文陈述（**逐字**）：「Thus there are four different ways to put the theory on a circle, each of which will lead to a different Hilbert space — essentially there are four different kinds of closed superstring. We will denote these by `(ν, ν̃)` or by NS–NS, NS–R, R–NS, and R–R. **They are analogous to the twisted and untwisted sectors of the `Z_2` orbifold.** Later in the chapter we will see that consistency requires that the full string spectrum contain certain combinations of states from each sector.」
- 文献自称的严格程度：陈述 + 预告
- 文献列出的依赖：E15

### E17 模式展开与（反）对易关系
- 位置：§10.2，eq. **(10.2.5)**–**(10.2.9a,b)**（p. 6）`[L1 原书]`
- 类型：definition / proposition
- 原文陈述（**逐字公式**）：`ψ^μ(z) = Σ_{r∈Z+ν} ψ_r^μ / z^{r+1/2}`，`ψ̃^μ(z̄) = Σ_{r∈Z+ν̃} ψ̃_r^μ / z̄^{r+1/2}`（(10.2.7)）；
  `∂X^μ(z) = −i(α'/2)^{1/2} Σ_m α_m^μ/z^{m+1}`（(10.2.8)），其中 `α_0^μ = α̃_0^μ = (α'/2)^{1/2}p^μ`（闭弦）、
  `α_0^μ = (2α')^{1/2}p^μ`（开弦）；
  `{ψ_r^μ, ψ_s^ν} = {ψ̃_r^μ, ψ̃_s^ν} = η^{μν}δ_{r,−s}`（(10.2.9a)）；`[α_m^μ, α_n^ν] = [α̃_m^μ, α̃_n^ν] = mη^{μν}δ_{m,−n}`（(10.2.9b)）。
- 文献自称的严格程度（**逐字**）：「The OPE and the Laurent expansions (**or canonical quantization**) give the anticommutators」
- 文献列出的依赖：E15；(10.2.6) 的半权重变换 `ψ^μ_{z^{1/2}}(z) = (∂_z w)^{1/2}ψ^μ_{w^{1/2}}(w) = i^{1/2}z^{−1/2}ψ^μ_{w^{1/2}}(w)`
- 备注：「Notice that in the NS sector the branch cut in `z^{−1/2}` offsets the original antiperiodicity, while in the R sector it introduces a branch cut.」——这句是 §10.3 R 扇区顶点算子（自旋场）之所以困难的原因。
  与 v1 的接口：`α_0^μ` 的两个取值与 v1 §1.1 表逐字一致。

### E18 超 Virasoro（Ramond / Neveu–Schwarz）代数 ★
- 位置：§10.2，eq. **(10.2.10a,b)**、**(10.2.11a,b,c)**（p. 7）`[L1 原书]`
- 类型：proposition
- 原文陈述（**逐字公式**）：`T_F(z) = Σ_{r∈Z+ν} G_r/z^{r+3/2}`，`T_B(z) = Σ_m L_m/z^{m+2}`（(10.2.10a,b)）；
  `[L_m, L_n] = (m−n)L_{m+n} + (c/12)(m³−m)δ_{m,−n}`（(10.2.11a)）；
  `{G_r, G_s} = 2L_{r+s} + (c/12)(4r²−1)δ_{r,−s}`（(10.2.11b)）；
  `[L_m, G_r] = ((m−2r)/2) G_{m+r}`（(10.2.11c)）。
  「This is known as the *Ramond algebra* for `r, s` integer and the *Neveu–Schwarz algebra* for `r, s` half-integer.
  The antiholomorphic fields give a second copy of these algebras.」
- 文献自称的严格程度（**逐字**）：「**The usual CFT contour calculation gives** the mode algebra」——即 Vol.1 §2.6 的围道变形字典
- 文献列出的依赖：E10（OPE）；Vol.1 的 OPE↔对易子字典（v1 记录 E39 = Vol.1 (2.6.14)）
- 备注：**三源一致**：[H] Problem 10.4（L1）用 Vol.1 **(2.6.14)** 独立复算了 (10.2.11b) 与 (10.2.11c)，
  并逐字写「The `[L_m, L_n]` commutator **(10.2.11a)** is as in the bosonic case」、
  「…which is easily seen to equal the RHS of **(10.2.11b)**」、「…in agreement with **(10.2.11c)**」。
  → **式号 (10.2.11a/b/c) 被原书与 [H] 双源核实。**
  与 `graph` 的接口（**只记事实，不建议边**）：(10.2.11a) 与 `worldsheet.virasoro-algebra-v2` 所引的 Vol.1 (2.6.19)
  形式完全相同（`(c/12)(m³−m)` vs `(c/12)m(m²−1)` 恒等），但**这里的 `c` 是超共形理论的中心荷 `(3/2)D`，
  而不是玻色弦的 `D`**；且 `L_m` 里含费米子项（见 E19）。是否复用节点由 curator 判断。

### E19 超 Virasoro 生成元的显式模式表达式与正规序常数 ★
- 位置：§10.2，eq. **(10.2.12a,b)**、**(10.2.13)**（p. 7）`[L1 原书]`
- 类型：definition / proposition
- 原文陈述（**逐字公式**）：
  `L_m = (1/2) Σ_{n∈Z} °α_{m−n}^μ α_{μ n}° + (1/4) Σ_{r∈Z+ν} (2r−m) °ψ_{m−r}^μ ψ_{μ r}° + a^m δ_{m,0}`（(10.2.12a)）；
  `G_r = Σ_{n∈Z} α_n^μ ψ_{μ r−n}`（(10.2.12b)）；
  **R: `a^m = D/16`；NS: `a^m = 0`**（(10.2.13)）。
- 文献自称的严格程度（**逐字**）：「The normal ordering constant can be obtained by **any of the methods from chapter 2**; we will use **the mnemonic from the end of section 2.9**. Each periodic boson contributes `−1/24`. Each periodic fermion contributes `+1/24` and each antiperiodic fermion `−1/48`. Including the shift `+(1/16)c = (1/16)D` gives」
- 文献列出的依赖：Vol.1 **§2.9 末的助记法**（← **⚠ 与 v1 记录 E46 的核实结果有张力，见 §4 Q2**）
- 备注：
  - **⚠ 记号问题**：「`+(1/16)c = (1/16)D`」在 `c = (3/2)D` 下字面不自洽；抽取者判断印的是 `ĉ ≡ (2/3)c = D`，
    但页图上的帽子未能 100% 分辨。见 §4 Q3。**两个结果值 `D/16` 与 `0` 是清楚的。**
  - 数值交叉检验（本记录内部）：`D = 10` 时 R 的 `a^m = 5/8`，与 (10.4.5) 的 `a^g = −5/8` 抵消 → (10.5.4) 的 `H = α'p² + N`（R）✓；
    NS 的 `0 + (−1/2) = −1/2` → `H = α'p² + N − 1/2`（NS）✓。**三处式号自洽。**

### E20 开弦的边界条件与 doubling trick
- 位置：§10.2，eq. **(10.2.14)**、**(10.2.15)**（p. 7–8）`[L1 原书]`
- 类型：proposition
- 原文陈述：运动方程的表面项为零要求 `ψ^μ(0,σ²) = exp(2πiν)ψ̃^μ(0,σ²)`、`ψ^μ(π,σ²) = exp(2πiν')ψ̃^μ(π,σ²)`（(10.2.14)）；
  由重定义 `ψ̃^μ → exp(−2πiν')ψ̃^μ` 可取 `ν' = 0`，**故开弦只有 R、NS 两个扇区**（闭弦有四个）。
  把 `ψ` 与 `ψ̃` 合成一个定义在 `0 ≤ σ¹ ≤ 2π` 上的场：`ψ^μ(σ¹,σ²) ≡ ψ̃^μ(2π−σ¹,σ²)` for `π ≤ σ¹ ≤ 2π`（(10.2.15)）。
- 文献自称的严格程度：直接推理
- 文献列出的依赖：E15、E17
- 备注：与 Vol.1 的 doubling trick（v1 E40 备注里的 Vol.1 (2.6.25)）同构。

### E21 NS 与 R 的基态；R 基态是时空旋量 ★
- 位置：§10.2「NS and R spectra」，eq. **(10.2.16)**–**(10.2.18)**（p. 8）`[L1 原书]`
- 类型：definition / proposition
- 原文陈述（**逐字公式**）：NS：`ψ_r^μ|0⟩_NS = 0`，`r > 0`（(10.2.16)）——「The NS spectrum is simple. There is no `r = 0` mode」；
  R：基态定义为被所有 `r > 0` 模湮灭者，`ψ_0^μ` 满足 gamma 矩阵代数 (10.1.4)，`Γ^μ ≅ 2^{1/2}ψ_0^μ`（(10.2.17)）；
  基态构成 gamma 矩阵代数的表示，基取 Lorentz 生成元 `S_a` 的本征态
  `|s_0, s_1, …, s_4⟩_R ≡ |s⟩_R`，`s_a = ±1/2`（(10.2.18)）。
- 文献自称的严格程度（**逐字**）：「This representation is **worked out in section B.1**; in `D = 10` it has **dimension 32**. The reader who is not familiar with properties of spinors in various dimensions **should read section B.1 at this point**.」
- 文献列出的依赖：**附录 B.1**（明写），特别是 eq. (B.1.10)
- 备注：「The half-integral values show that these are indeed spacetime spinors.」；
  「In the NS sector, the ground state is annihilated by `S^{μν}` and is a Lorentz singlet, and all other states then have integer spin.」
  「The Dirac representation **32** is reducible to two Weyl representations **16 + 16′**, distinguished by their eigenvalue under `Γ` in eq. **(B.1.11)**.」
  → ⚠ **本章的时空旋量部分把技术内容外包给 Appendix B（pp. 430–466，[T] L1 确认）。** 若要建图，`D=10` 的谱这一支会依赖 App. B，本轮未读。

### E22 世界面费米子数 `exp(πiF)` ★
- 位置：§10.2，eq. **(10.2.19)**–**(10.2.24a,b)**（p. 8–9）`[L1 原书]`
- 类型：definition
- 原文陈述（**逐字公式**）：需要一个与整个 `ψ^μ` 反对易的算符，取 `exp(πiF)`（(10.2.19)），
  `F` 是*world-sheet fermion number*，**只 mod 2 有定义**；
  `Σ^{μλ} = −(i/2)Σ_{r∈Z+ν}[ψ_r^μ, ψ_{−r}^λ]`（(10.2.20)）；`S_a = i^{δ_{a,0}}Σ^{2a,2a+1}`（(10.2.21)，「the `i` being included to make `S_0` Hermitean」）；
  `F = Σ_{a=0}^{4} S_a`（(10.2.22)）；
  `exp(πiF)|0⟩_NS = −|0⟩_NS`（(10.2.24a)）；`exp(πiF)|s⟩_R = |s′⟩_R Γ_{s′s}`（(10.2.24b)）。
  「The ghost ground state contributes a factor `−1` in the NS sector and `−i` in the R sector.」
- 文献自称的严格程度（**逐字**）：「The definition (10.2.22) makes it obvious that `F` is conserved by the OPE of the vertex operators, **as a consequence of Lorentz invariance**.¹」
  脚注 1（**逐字**）：「Lorentz invariance of the OPE holds separately for the `ψ` and `X` CFTs (and the `ψ̃` CFT in the closed string) because they are decoupled from one another. However, the world-sheet supercurrent is only invariant under the overall Lorentz transformation.」
- 文献列出的依赖：E21、附录 B（(B.1.8)）；(10.2.24) 中的鬼场部分预告到 **§10.4**（「When we include the ghost part of the vertex operator in section 10.4, we will see that it contributes to the total matter plus ghost `F`」）
- 备注：★ `exp(πiF)` 是 GSO 投影（E36）的算符，本条是 GSO 的技术前提。
  ⚠ **`F` 的鬼场部分定义在 §10.4 才补全**（见 E31），而且 Polchinski 自己说那个定义「is based on spin rather than statistics, since the ghosts have the wrong spin-statistics relation; it would therefore be more appropriate to call `F` the *world-sheet spinor number*」（p. 19，逐字）。

### E23 R–R 基态的分解与 Table 10.1
- 位置：§10.2「Closed string spectra」，eq. **(10.2.25)** 与 **Table 10.1**（p. 9–10）`[L1 原书]`
- 类型：proposition
- 原文陈述：`32_Dirac × 32_Dirac = [0] + [1] + [2] + … + [10] = [0]² + [1]² + … + [4]² + [5]`（(10.2.25)），
  `[n]` 表示反对称 `n` 阶张量。Table 10.1「`SO(9,1)` representations of massless R–R states」按
  `(exp(πiF), exp(πiF̃))` 的四种符号给出：`(+,+) → 16×16 = [1]+[3]+[5]_+`；`(+,−) → 16×16′ = [0]+[2]+[4]`；
  `(−,+) → 16′×16 = [0]+[2]+[4]`；`(−,−) → 16′×16′ = [1]+[3]+[5]_−`。
- 文献自称的严格程度：「The products of spinors are discussed in section B.1.」（推给附录）
- 文献列出的依赖：E21、E22、附录 B.1

---

### E24 NS 扇区顶点算子与态-算子映射
- 位置：§10.3，eq. **(10.3.1)**–**(10.3.4)**（p. 10）`[L1 原书]`
- 类型：proposition
- 原文陈述：单位算子对应的态满足 `ψ_r^μ|1⟩ = 0`，`r = 1/2, 3/2, …`（(10.3.1)），故 `|1⟩ = |0⟩`（(10.3.2)，即 NS 基态）；
  围道论证给出映射 `ψ_{−r}^μ → (1/(r−1/2)!) ∂^{r−1/2}ψ^μ(0)`（(10.3.3)）；
  NS 算子的超共形变分（Noether 关系 **(2.9.6)** 的类比）为 (10.3.4)。
- 文献自称的严格程度（**逐字**）：「The holomorphicity of `ψ` at the origin implies, **via the contour argument**, that the state corresponding to the unit operator satisfies…」；「**The analog of the Noether relation (2.9.6)**…」
- 文献列出的依赖：Vol.1 **(2.9.6)**（明写）
- 备注：⚠ **v1 记录 Q5 说 [S] 在 Vol.1 §2.9（p.68–73）只标注了 (2.9.3)、(2.9.14)、(2.9.15) 三处。
  本条与 E19 一起构成新的证据：Vol.1 §2.9 至少还有 (2.9.6)，且 §2.9 末有一个「正规序常数助记法」。**
  → v1 的 Q5 应据此更新（见 §4 Q2）。

### E25 玻色化 ★
- 位置：§10.3，eq. **(10.3.5)**–**(10.3.19)**（p. 11–13）`[L1 原书]`
- 类型：proposition
- 原文陈述（要点，**逐字公式**）：取全纯标量 `H(z)H(0) ∼ −ln z`（(10.3.5)）；
  基本算子 `e^{±iH}` 的 OPE（(10.3.6a,b,c)）；球面期望值
  `⟨Π_i e^{iε_i H(z_i)}⟩_{S_2} = Π_{i<j} z_{ij}^{ε_iε_j}`，`Σ_i ε_i = 0`（(10.3.7)）；
  两个 Majorana–Weyl 费米子的复组合 `ψ = 2^{−1/2}(ψ¹+iψ²)`、`ψ̄ = 2^{−1/2}(ψ¹−iψ²)`（(10.3.8)），其 OPE (10.3.9a,b,c) 与 (10.3.6) **同形**；
  故 `ψ(z) ≅ e^{iH(z)}`，`ψ̄ ≅ e^{−iH(z)}`（(10.3.10)）；能动张量等同 `ψψ̄ ≅ i∂H`，`T_B^ψ ≅ T_B^H`（(10.3.13)）；
  算符层面 `ψ(z) ≅ °e^{iH(z)}°`（(10.3.14)），由 CBH 公式 **(6.7.23)** 与 **(8.2.21)** 证明玻色化后的算子确实反对易（(10.3.15)）；
  配分函数两边相等（(10.3.17)、(10.3.18)、(10.3.19)）。
- 文献自称的严格程度（**逐字**）：
  - 「The poles and zeros in the OPE together with **smoothness at infinity determine** the expectation values of these operators on the sphere, up to an overall normalization」（(10.3.7) 上方）；
  - 「the equivalence of the theories can be extended to all local operators」；
  - 「This rather surprising equivalence is known as *bosonization*.」
  - 「**We know indirectly that these must be equal**, since we can use the OPE to construct an analog in the fermionic theory for any local operator of the bosonic theory and vice versa」；
    「in fact the equality of (10.3.17) and (10.3.18) **follows from the equality of the product and sum expressions for theta functions, section 7.2**」；
  - 「Note that while bosonization was derived for the sphere, **the sewing construction from chapter 9 guarantees that it holds on all Riemann surfaces**, provided that we make equivalent projections on the spectra.」
- 文献列出的依赖：Vol.1 **§7.2**（theta 函数）、Vol.1 **第 9 章**（sewing）、Vol.1 **(6.7.23)**、**(8.2.21)**、**(8.2.22)**（明写）
- 备注：★ 这是全章严格性最可疑的一块之一：「smoothness at infinity determines」是物理论证；
  [H] Problem 10.7（L1）给的正是这个唯一性论证（Liouville 型：比值是整函数且在无穷远趋于常数 ⇒ 常数），
  **这条论证本身是可以数学化的**，但书里放在习题。→ curator 若建 `bosonization` 节点，`status` 建议 `physical-argument`，
  并把 (10.3.7) 的唯一性单列，注明「书中推给 exercise 10.7，[H] 给出 Liouville 型论证」。

### E26 谱流、自旋场与 R 扇区顶点算子 ★
- 位置：§10.3，eq. **(10.3.20)**–**(10.3.29)**（p. 13–15）`[L1 原书]`
- 类型：definition / proposition
- 原文陈述（**逐字公式**）：一般周期 `ψ(w+2π) = exp(2πiν)ψ(w)`（(10.3.20)）；参考态 `|0⟩_ν` 由
  `ψ_{n+ν}|0⟩_ν = ψ̄_{n+1−ν}|0⟩_ν = 0`，`n = 0,1,…`（(10.3.23)）定义；
  对应的玻色等价物 `exp[i(−ν+1/2)H] ≅ A_ν`（(10.3.25)）；
  `|0⟩_{ν+1} = ψ̄_{−ν}|0⟩_ν`（(10.3.26)）——「This is known as *spectral flow*」；
  R 情形 `ν = 0` 有两个简并基态 `|s⟩ ≅ e^{isH}`，`s = ±1/2`（(10.3.27)）；
  十维需要五个玻色子 `H^a`，`a = 0,…,4`（(10.3.28a,b)）；
  R 态 `|s⟩` 的顶点算子 `Θ_s ≅ exp[i Σ_a s_a H^a]`（(10.3.29)）——「sometimes called a *spin field*」。
- 文献自称的严格程度（**逐字**）：「The conditions (10.3.23) **uniquely identify** the state `|0⟩_ν`, and so the corresponding OPEs (10.3.24) **determine** the bosonic equivalent」；
  「**One can check** the identification (10.3.25) by verifying that the weight is `h = (1/2)(ν−1/2)²`」
- 文献列出的依赖：E25；Vol.1 **§8.2**（缠绕态顶点算子）、**§8.5**（orbifold 扭曲态顶点算子）（明写作对照）；(2.7.8) 的对易子方法
- 备注：脚注 2（p. 14，**逐字**）：「The precise operator definition has a subtlety when there are several species of fermion. The `H^a` for different `a` are independent and so the exponentials **commute rather than anticommute**. A cocycle is needed, as in eq. (8.2.22). A general expression will be given in the next section.」
  → cocycle 在 (10.4.26)–(10.4.28) 补上。**这是一处真实的技术漏洞被延后修补**，转节点时不要漏。

### E27 `bc` 系统的玻色化
- 位置：§10.3 末，eq. **(10.3.30)**–**(10.3.34)**（p. 15）`[L1 原书]`
- 类型：proposition
- 原文陈述（**逐字公式**）：一般 `λ` 的 `bc` CFT 由 `λ = 1/2` 理论改能动张量得到：`T_B^{(λ)} = T_B^{(1/2)} − (λ−1/2)∂(bc)`（(10.3.30)）；
  等价的玻色算子 `T_B^{(λ)} ≅ T_B^H − i(λ−1/2)∂²H`（(10.3.31)）——「This is the same as the linear dilaton CFT, with `V = −i(λ−1/2)`」；
  `b ≅ e^{iH}`，`c ≅ e^{−iH}`（(10.3.32)）；中心荷核对 `c = 1 − 3(2λ−1)² = 1 + 12V²`（(10.3.33)）；
  由于 `b`、`c` 需为厄米，玻色场 `H` 必须反厄米，通常改写为厄米场：`H → iρ`；`c ≅ e^ρ`，`b ≅ e^{−ρ}`（(10.3.34)）。
- 文献自称的严格程度（**逐字**）：「**As a check**, the central charges agree」；「**So do** the dimensions of the fields」
- 文献列出的依赖：E25；Vol.1 §2.5（`bc` 中心荷公式，= v1 E36 / (2.5.12)）

---

### E28 超共形鬼场：模式、基态与正规序常数 ★
- 位置：§10.4，eq. **(10.4.1a,b)**–**(10.4.5)**（p. 15–16）`[L1 原书]`
- 类型：definition / proposition
- 原文陈述（**逐字公式**）：
  「To build the BRST current we will need, in addition to the anticommuting `b` and `c` ghosts of the bosonic string, **commuting ghost fields `β` and `γ` of weight `(3/2, 0)` and `(−1/2, 0)`**」；
  `β(z) = Σ_{r∈Z+ν} β_r/z^{r+3/2}`，`γ(z) = Σ_{r∈Z+ν} γ_r/z^{r−1/2}`（(10.4.1a)）；`b(z)`、`c(z)`（(10.4.1b)）；
  `[γ_r, β_s] = δ_{r,−s}`，`{b_m, c_n} = δ_{m,−n}`（(10.4.2)）；
  基态 `|0⟩_{NS,R}`：`β_r|0⟩_NS = 0 (r ≥ 1/2)`、`γ_r|0⟩_NS = 0 (r ≥ 1/2)`（(10.4.3a)）；
  `β_r|0⟩_R = 0 (r ≥ 0)`、`γ_r|0⟩_R = 0 (r ≥ 1)`（(10.4.3b)）；`b_m|0⟩ = 0 (m ≥ 0)`、`c_m|0⟩ = 0 (m ≥ 1)`（(10.4.3c)）；
  `L_m^g = Σ_n (m+n)°b_{m−n}c_n° + Σ_r (1/2)(m+2r)°β_{m−r}γ_r° + a^g δ_{m,0}`（(10.4.4a)）；
  `G_r^g = −Σ_n [ (1/2)(2r+n)β_{r−n}c_n + 2b_nγ_{r−n} ]`（(10.4.4b)）；
  **R: `a^g = −5/8`；NS: `a^g = −1/2`**（(10.4.5)）。
- 文献自称的严格程度（**逐字**）：「The normal ordering constant is determined by **the usual methods** to be」；
  基态的分组理由：「We have grouped `β_0` with the lowering operators and `γ_0` with the raising ones, **in parallel with the bosonic case**.」
- 文献列出的依赖：E11、E13（(10.1.17) 的作用量与 (10.1.21) 的 `T_B, T_F`，明写）；(10.2.4) 的周期性
- 备注：★ **`β`、`γ` 的周期性必须与 `T_F` 相同**：「The ghosts `β` and `γ` must have the same periodicity (10.2.4) as the generator `T_F` with which they are associated. **This is necessary to make the BRST current periodic, so that it can be integrated to give the BRST charge.**」（p. 15，逐字）
  → 这是一条真实的约束，转节点时应记为 BRST 荷存在性的前提。
  ⚠ 与 Vol.1 的接口：Vol.1 的 `a^g = −1`（v1 E43 订正过），这里是 `−1/2`（NS）/ `−5/8`（R）。**不同的数，不要迁移。**

### E29 `δ(γ)` 与 NS 基态顶点算子
- 位置：§10.4「Vertex operators」，eq. **(10.4.6)**、**(10.4.7)**（p. 16–17）`[L1 原书]`
- 类型：definition / proposition
- 原文陈述：单位算子对应的态 `|1⟩` 满足 `β_r|1⟩ = 0 (r ≥ −1/2)`、`γ_r|1⟩ = 0 (r ≥ 3/2)`（(10.4.6)），
  **它不是 `|0⟩_NS`**（`γ_{1/2}` 湮灭 `|0⟩_NS`，而其共轭 `β_{−1/2}` 湮灭 `|1⟩`）；
  `bc` 情形有 `|0⟩ = c_1|1⟩`，但对易振子没有这么简单的关系：「there is no state in the Fock space built on `|1⟩` by acting with `γ_{1/2}` that has the properties of `|0⟩_NS`」；
  `|0⟩_NS` 对应的算子记作 `δ(γ)`，满足 `γ(z)δ(γ(0)) = O(z)`、`β(z)δ(γ(0)) = O(z^{−1})`（(10.4.7)）。
- 文献自称的严格程度（**逐字**）：「**One can show** that an insertion of `δ(γ)` in the path integral has the property (10.4.7).」——**书中不证**
- 文献列出的依赖：E28
- 备注：★ 这是「picture（图景）」问题在本书里的出现方式——Polchinski 不用 "picture number" 这个词在这里，
  但 `|1⟩ ≠ |0⟩_NS` 正是 βγ 系统有无穷多不等价真空的表现。**书中对此不作系统处理。**

### E30 βγ 系统的玻色化：`φ`、`η`、`ξ` ★
- 位置：§10.4，eq. **(10.4.8)**–**(10.4.22)**（p. 17–18）`[L1 原书]`
- 类型：proposition
- 原文陈述（**逐字公式**）：`βγ(z)βγ(0) ∼ −1/z²`（(10.4.8)）与 `∂φ` 相同（`φ(z)φ(0) ∼ −ln z`），故 `βγ(z) ≅ ∂φ(z)`（(10.4.9)）；
  朴素的 `β ≅ e^{−φ}`、`γ ≅ e^{φ}`（(10.4.10)，式上带 `?`）给出**错误**的 OPE（(10.4.11) vs 正确的 (10.4.12)）；
  修补为 `β(z) ≅ e^{−φ(z)}∂ξ(z)`，`γ ≅ e^{φ(z)}η(z)`（(10.4.13)），其中 `η(z)ξ(0) ∼ 1/z`、`η η = O(z)`、`∂ξ∂ξ = O(z)`（(10.4.14)）；
  `ηξ` 是一个 `λ = 1` 的 `bc` 型系统，`T_B^{ηξ} = −η∂ξ`（(10.4.17)），`T_B^{βγ} ≅ T_B^φ + T_B^{ηξ}`（(10.4.18)）；
  中心荷核对：`T_B^φ` 给 `3(2λ'−1)²+1`，`T_B^{ηξ}` 给 `−2`，合为 `βγ` 的 `3(2λ'−1)²−1`；
  进一步用自由玻色子 `χ` 表示 `ηξ`：`η ≅ e^{−χ}`、`ξ ≅ e^{χ}`（(10.4.19a)），`β ≅ e^{−φ+χ}∂χ`、`γ ≅ e^{φ−χ}`（(10.4.19b)）；
  对弦而言 `λ' = 3/2`，`δ(γ) ≅ e^{−φ}`，`h = 1/2`（(10.4.21)）；
  快子与无质量 NS 顶点算子的费米部分分别是 `e^{−φ}` 与 `e^{−φ}e^{±iH^a}`（(10.4.22)）。
- 文献自称的严格程度（**逐字**）：「For the `bc` system we would be finished: this approach leads to the same bosonization as before. For the `βγ` system, however, the sign of the current–current OPE and therefore of the `φφ` OPE is changed.」；
  「the equivalence (10.4.13) **will hold — all OPEs will be correct — if** `η` and `ξ` satisfy…」；
  「**One can check** that the total partition functions agree, in the appropriate sectors.」
- 文献列出的依赖：E25、E28
- 备注：⚠ 「The need for extra degrees of freedom is not surprising. The `βγ` theory has a greater density of states than the `bc` theory because the modes of a commuting field can be excited any number of times.」（逐字）

### E31 R 基态顶点算子与鬼场对 `F` 的贡献 ★
- 位置：§10.4，eq. **(10.4.23)**–**(10.4.25)**（p. 19）`[L1 原书]`
- 类型：proposition
- 原文陈述（**逐字公式**）：`β(z)Σ(0) = O(z^{−1/2})`、`γ(z)Σ(0) = O(z^{1/2})`（(10.4.23)）确定
  `Σ = e^{−φ/2}`，`h = 3/8`（(10.4.24)）；R 基态顶点算子 `V_s = e^{−φ/2}Θ_s`（(10.4.25)），`Θ_s` 是 (10.3.29) 的自旋场。
  「Adding the contribution `−1` of the `bc` ghosts, the weight of `e^{−φ/2}` and of `e^{−φ}` **agree with the values (10.4.5)**.」
  `F` 的推广（**逐字**）：「We need to extend the definition of world-sheet fermion number `F` to be **odd for `β` and `γ`**. The ultimate reason is that it anticommutes with the supercurrent `T_F` and so we will need it to commute with the BRST operator, which contains terms such as `γT_F`. The natural definition for `F` is then that it be the charge associated with the current (10.4.9), which is `l` for `e^{lφ}`. Again, it is conserved by the OPE. This accounts for the ghost contributions in eq. (10.2.24). Note that **this definition is based on spin rather than statistics**, since the ghosts have the wrong spin-statistics relation; **it would therefore be more appropriate to call `F` the *world-sheet spinor number*.**」
- 文献自称的严格程度：如上逐字（"The natural definition"）
- 文献列出的依赖：E22、E26、E28、E30
- 备注：★ 这条把 E22 里悬着的「鬼场对 `F` 的贡献」补齐，是 GSO（E36）的完整前提。**`F` 的定义带一处约定选择（spin 而非 statistics），转节点时应显式记录。**

### E32 cocycle
- 位置：§10.4 末，eq. **(10.4.26)**–**(10.4.28)**（p. 19–20）`[L1 原书]`
- 类型：definition
- 原文陈述：一般的自由场指数算子 `exp(ik_L·H_L + ik_R·H_R)`（(10.4.26)）在动量取值于格 `Γ` 时，
  朴素算符乘积带相位 `z^{−k∘k'}`；正确定义的顶点算子是 `C_k(α_0) °exp(ik_L·H_L + ik_R·H_R)°`（(10.4.27)），
  cocycle `C_k(α_0) = exp(πi Σ_{α>β} n_α α_{0β} k_α ∘ k_β)`（(10.4.28)）。
  「This generalizes the simple case **(8.2.22)**.」
- 文献自称的严格程度（**逐字**）：「**The reader can check** that vertex operators with even `k ∘ k` now commute with all vertex operators, and those with odd `k ∘ k` anticommute among themselves.」
- 文献列出的依赖：Vol.1 **§8.4**（`k ∘ k'` 的记号）、**(8.2.22)**（明写）

---

### E33 §10.5 的方法论声明：RNS 约束是**假定**的，不是从规范不变作用量导出的 ★★
- 位置：§10.5 开头段（p. 20）`[L1 原书]`
- 类型：（方法论/公设声明）
- 原文陈述（**逐字**）：「In the bosonic string we started with a (diff×Weyl)-invariant theory. After fixing to conformal gauge we had to impose the vanishing of the conformal algebra as a constraint on the states. In the present case **there is an analogous gauge-invariant form, and the superconformal algebra emerges as a constraint in the gauge-fixed theory. However, it is not necessary to proceed in this way, and it would require us to develop some machinery that in the end we do not need. Rather we can generalize directly in the gauge-fixed form, defining the superconformal symmetry to be a constraint and proceeding in parallel to the bosonic case to construct a consistent theory.** We will first impose the constraint in the old covariant formalism, and then in the BRST formalism.」
- 文献自称的严格程度：如上——**作者明说本书不走「超 diff × 超 Weyl 不变作用量 → 规范固定」这条路**
- 文献列出的依赖：Vol.1 第 3、4 章（作为对照）
- 备注：★★ 对本项目极重要。后果：
  1. **Vol.1 里 `D = 26` 的「Weyl 反常」路线（v1 E51–E53）在 Vol.2 里没有对应物**——本卷的 `D = 10` 不是从超 Weyl 反常推的，
     而是「总中心荷为零」这个**被假定的一致性条件**（E12）加上 `Q_B² = 0`（E35）。
  2. 「there is an analogous gauge-invariant form」是**未加论证的断言**（书中不构造、不引用）。
     → curator 若要建「RNS 有规范不变形式」的节点，必须标 `status: conjecture` 或干脆不建。

### E34 OCQ 物理态条件与质量壳 ★
- 位置：§10.5「OCQ」，eq. **(10.5.1)**–**(10.5.6a,b)**（p. 20–21）`[L1 原书]`
- 类型：definition / proposition
- 原文陈述（**逐字公式**）：
  `L_n^m|ψ⟩ = 0, n > 0`；`G_r^m|ψ⟩ = 0, r ≥ 0`（(10.5.1)）——注意 **`r ≥ 0` 含 `r = 0`（R 扇区的 `G_0`）**；
  等价关系 `L_n^m|χ⟩ ≅ 0, n < 0`；`G_r^m|χ⟩ ≅ 0, r < 0`（(10.5.2)）；
  `L_0|ψ⟩ = H|ψ⟩ = 0`（(10.5.3)）——「The mass-shell condition can always be written in terms of the total matter plus ghost Virasoro generator, which is the same as the world-sheet Hamiltonian `H` **because the total central charge is zero**」；
  十平坦维中 `H = α'p² + N − 1/2`（NS）、`H = α'p² + N`（R）（(10.5.4)）；
  零点常数的抵消（(10.5.5)）：**NS: `8(−1/24 − 1/48) = −1/2`；R: `8(−1/24 + 1/24) = 0`**——
  「The zero-point constants from the ghosts and longitudinal oscillators have canceled as usual, leaving the contribution of the transverse modes」；
  `G_0^m = (2α')^{1/2}p_μψ_0^μ + …`（(10.5.6a)）、`G_{±1/2}^m = (2α')^{1/2}p_μψ_{±1/2}^μ + …`（(10.5.6b)）。
- 文献自称的严格程度：「In this formalism, developed for the bosonic string in **section 4.1**, one ignores the ghost excitations…」
- 文献列出的依赖：Vol.1 **§4.1**（明写）、E18、E19、E28
- 备注：与 v1 记录 E54 的接口：Vol.1 §4.1 的条件是 `L_m^m|ψ⟩=0 (m≥1)` 与 `(L_0^m + A)|ψ⟩=0`；
  这里因为常数被吸进 `L_0`（E19、§1.3），直接写 `L_0|ψ⟩ = 0`。**是同一件事的两种写法。**

### E35 NS / R 的低能级谱、快子与无质量 Dirac 方程 ★
- 位置：§10.5，eq. **(10.5.7)**–**(10.5.17a,b)** 与 **Table 10.2**、**Table 10.3**（p. 21–23）`[L1 原书]`
- 类型：proposition
- 原文陈述（**逐字公式**）：
  NS 最低态 `|0;k⟩_NS`：`m² = −k² = −1/(2α')`（(10.5.7)）——**「This state is a tachyon. It has `exp(πiF) = −1`」**；
  第一激发态 `|e;k⟩_NS = e·ψ_{−1/2}|0;k⟩_NS`（(10.5.8)），条件 `0 = L_0|e;k⟩ = α'k²|e;k⟩`（(10.5.9a)）、
  `0 = G_{1/2}^m|e;k⟩ = (2α')^{1/2}k·e|0;k⟩`（(10.5.9b)），而 `G_{−1/2}^m|0;k⟩_NS = (2α')^{1/2}k·ψ_{−1/2}|0;k⟩_NS`（(10.5.10)）是 null，
  故 `k² = 0`、`e·k = 0`、`e^μ ≅ e^μ + λk^μ`（(10.5.11)）——**无质量矢量，`D−2` 个类空极化，`exp(πiF) = +1`**；
  R 最低态 `|u;k⟩_R = |s;k⟩_R u_s`（(10.5.12)），条件 `0 = L_0|u;k⟩ = α'k²|u;k⟩`（(10.5.13a)）、
  `0 = G_0^m|u;k⟩ = α'^{1/2}|s';k⟩_R k·Γ_{s's}u_s`（(10.5.13b)），即**无质量 Dirac 方程** `k·Γ_{s's}u_s = 0`（(10.5.14)）；
  `k_0Γ⁰ + k_1Γ¹ = −2k_1Γ⁰(S_0 − 1/2)`（(10.5.15)），故物理态条件是 `(S_0 − 1/2)|s,0;k⟩_R u_s = 0`（(10.5.16)），
  只有 `s_0 = +1/2` 存活；`16 → (+1/2, 8) + (−1/2, 8′)`、`16′ → (+1/2, 8′) + (−1/2, 8)`（(10.5.17a,b)）。
  **Table 10.2「Massless and tachyonic open string states」**：`NS+ : 8_v, m²=0`；`NS− : 1, m²=−1/(2α')`；
  `R+ : 8, m²=0`；`R− : 8′, m²=0`。
  闭弦质量壳：`(α'/4)m² = N − ν = Ñ − ν̃`（(10.5.18)）；**Table 10.3** 给闭弦无质量能级的 `SO(8)` 表乘积。
- 文献自称的严格程度（**逐字**）：「The NS sector works out much as in the bosonic string.」；
  「which was our original goal in introducing the superconformal algebra」（指 (10.5.14)）；
  「The `G_0^m` condition implies the `L_0` condition, because `G_0² = L_0` **in the critical dimension** and the ghost parts of `G_0` annihilate the ghost vacuum.」
- 文献列出的依赖：E34、E19、E21、E22、附录 B.1
- 备注：★ 「快子存在于 NS− 扇区」这一条是 GSO 消除快子（E36）的直接前提；(10.5.7) 与 Table 10.2 是逐字锚点。
  另注：「The `(NS−,NS−)` sector contains a closed string tachyon with `m² = −2/α'`」（p. 23，逐字）。

### E36 超弦 BRST 荷 ★★
- 位置：§10.5「BRST quantization」，eq. **(10.5.20)**–**(10.5.24)**（p. 24）`[L1 原书]`
- 类型：definition / proposition
- 原文陈述（**逐字公式**）：
  「From the general structure discussed in **chapter 4**, in particular the expression **(4.3.14)** for the BRST operator for a general constraint algebra, the BRST operator can be constructed as a simple extension of the bosonic one:」
  `Q_B = (1/2πi) ∮ (dz j_B − dz̄ j̃_B)`（(10.5.20)）；
  `j_B = cT_B^m + γT_F^m + (1/2)(cT_B^g + γT_F^g)`
      `= cT_B^m + γT_F^m + bc∂c + (3/4)(∂c)βγ + (1/4)c(∂β)γ − (3/4)cβ∂γ − bγ²`（(10.5.21)）；
  「As in the bosonic case, this is a tensor up to an unimportant total derivative term.」
  `j_B(z)b(0) ∼ … + (1/z)T_B(0)`，`j_B(z)β(0) ∼ … + (1/z)T_F(0)`（(10.5.22)），
  故 `{Q_B, b_n} = L_n`，`[Q_B, β_r] = G_r`（(10.5.23)）；
  模式展开
  `Q_B = Σ_m c_{−m}L_m^m + Σ_r γ_{−r}G_r^m − Σ_{m,n} (1/2)(n−m) °b_{−m−n}c_mc_n°`
      `+ Σ_{m,r} [ (1/2)(2r−m) °β_{−m−r}c_mγ_r° − °b_{−m}γ_{m−r}γ_r° ] + a^g c_0`（(10.5.24)），
  「where `m` and `n` run over integers and `r` over (integers + `ν`). The ghost normal ordering constant is as in eq. **(10.4.5)**.」
- 文献自称的严格程度：构造性（"can be constructed as a simple extension"）
- 文献列出的依赖：Vol.1 **第 4 章**、特别是 **(4.3.14)**（明写）；E28（(10.4.5)）
- 备注：★★ 与 v1 的接口：v1 记录 E65 把 Vol.1 (4.3.15)/(4.3.16) 记为「一般约束代数下的 BRST 荷及其幂零条件」，
  **而 Vol.2 这里引用的是 Vol.1 (4.3.14)**。→ v1 §3 的未核实清单里 (4.3.15)/(4.3.16) 的表达式仍未核实，
  但**「(4.3.14) 是一般约束代数的 BRST 算符表达式」现在有了 Vol.2 的一手背书（L1）**，可写进 v1 的补注。
  另：末项 `a^g c_0` 与玻色弦 (4.3.7) 的 `−c_0` 平行（v1 E63），但数值不同（NS `−1/2`、R `−5/8`）。

### E37 `Q_B² = 0 ⟺ c^m = 15`（`D = 10` 的第二条路线）★★
- 位置：§10.5，(10.5.23) 下方一段（p. 24）`[L1 原书]`
- 类型：proposition
- 原文陈述（**逐字**）：「From these one can verify nilpotence by the same steps as in the bosonic case (**exercise 4.3**) whenever the total central charge vanishes. Thus, we can replace some of the spacelike `X^μψ^μ` SCFTs with any positive-norm SCFT such that the total matter central charge is `c^m = c̃^m = 15`. The BRST current must be periodic for the BRST charge to be well defined. The supercurrent of the SCFT must therefore have the same periodicity, R or NS, as the `ψ^μ`, `β`, and `γ`.」
- 文献自称的严格程度（**逐字**）：「**one can verify** nilpotence by the same steps as in the bosonic case (exercise 4.3)」——**书中不证，推给 Vol.1 的习题 4.3**
- 文献列出的依赖：E36、E12；Vol.1 **exercise 4.3**（明写）
- 备注：★★ 这是 `D = 10` 的**第二条独立推导**，且**比 E12 更强**：结论是 `c^m = 15`（允许一般物质 SCFT），
  `D = 10` 只是取 `D` 个平坦 `Xψ` SCFT 的特例。
  → 与 v1 Q6 的建议完全平行：`c^m = 15` 与 `D = 10` 是**两条不同的陈述**，图里应拆开，前者更一般。
  ⚠ 注意：**本卷没有像 Vol.1 (4.3.10) 那样把「`Q_B²=0 ⟺ c=26`」写成一个带式号的公式**；这里是一句正文。
  故 `sources[].loc` 只能写「§10.5, p. 24, (10.5.23) 下方一段」，**不要编式号**。

### E38 BRST 附加条件（含 R 扇区的 `β_0`、`G_0`）
- 位置：§10.5，eq. **(10.5.25)**、**(10.5.26)**（p. 25）`[L1 原书]`
- 类型：definition
- 原文陈述（**逐字公式**）：「The observable spectrum is the space of BRST cohomology classes. As in the bosonic theory, we impose the additional conditions」
  `b_0|ψ⟩ = L_0|ψ⟩ = 0`（(10.5.25)）；「In addition, in the R sector we impose」
  `β_0|ψ⟩ = G_0|ψ⟩ = 0`（(10.5.26)），「**the logic being the same as for (10.5.25)**」。
- 文献自称的严格程度：如上（无独立论证，只说"the logic being the same"）
- 文献列出的依赖：E36；Vol.1 §4.3（`b_0`、`L_0` 条件，= v1 E66）
- 备注：**双源核实**：[H] Problem 10.14（L1）逐字用到「the constraint **(10.5.26)**」，并说明
  「`|ψ⟩` is defined to be annihilated by `b_0` and `β_0`, which implies that it is annihilated by `G_0^g`.
  According to (10.5.26), this in turn implies that it is annihilated by `G_0^m`, **which is exactly the OCQ condition**.」
  → (10.5.26) 是 OCQ ↔ BRST 等价在 R 扇区的技术关键。

### E39 超弦无鬼定理 ★★★
- 位置：§10.5 末（p. 25），**无式号** `[L1 原书]`
- 类型：proposition
- 原文陈述（**逐字**）：「The reader can again work out the first few levels by hand, the result being exactly the same as for OCQ. **The no-ghost theorem is as in the bosonic case. The BRST cohomology has a positive definite inner product and is isomorphic to OCQ and to the transverse Hilbert space `H^⊥`, which is defined to have no `X^{0,1}`, `ψ^{0,1}`, `b`, `c`, `β`, or `γ` excitations. The proof is a direct imitation of the bosonic argument of chapter 4.**
  We have defined `exp(πiF)` to commute with `Q_B`. We can therefore consider subspaces with definite eigenvalues of `exp(πiF)` and **the no-ghost theorem holds separately in each**.」
- 文献自称的严格程度（**逐字**）：「**The proof is a direct imitation of the bosonic argument of chapter 4.**」
  ——**这就是全部。书中不给证明，也不引用任何原始文献（此处无脚注、无引文）。**
- 文献列出的依赖：Vol.1 **第 4 章**的无鬼定理证明（= v1 记录 E68，Vol.1 §4.4）；E36、E37、E38
- 备注：★★★ **本条是本次抽取对本项目最直接有用的结果。**
  1. 陈述是**三重的**：(i) 内积正定；(ii) 与 OCQ 同构；(iii) 与横向 Hilbert 空间 `H^⊥` 同构。
     按「一个节点一个命题」，这至少该拆成两到三条陈述。
  2. **没有证明**，只有「direct imitation」。→ 若图里要建 `worldsheet.no-ghost-theorem--superstring`，
     它的**唯一推导**就是「照搬 Vol.1 §4.4」，`status` 不能高于该玻色弦节点，且应记 `inferred` 的风险：
     「direct imitation」这句掩盖了超弦特有的困难（`βγ` 的无穷多不等价真空 / picture、R 扇区的 `β_0` 零模）。
     **文献没有讨论这些困难是否影响该论证。** 见 §4 Q4。
  3. 「`H^⊥` 定义为不含 `X^{0,1}, ψ^{0,1}, b, c, β, γ` 激发」这个定义是**逐字**的，可直接写进节点。
  4. 最后一句「无鬼定理在 `exp(πiF)` 的每个本征子空间上分别成立」是 GSO 投影后谱仍无鬼的依据，**很重要，别漏**。

---

### E40 十维的十个（实为十个中的四类）扇区与三条一致性条件 ★
- 位置：§10.6，eq. **(10.6.1)**–**(10.6.6)**（p. 25–26）`[L1 原书]`
- 类型：definition / proposition
- 原文陈述（**逐字公式**）：开弦四扇区记作 `(α, F)`（(10.6.1)），其中 `α = 1 − 2ν`（(10.6.2)）在 R 扇区为 1、NS 扇区为 0；
  「Both `α` and `F` are defined only mod 2」；闭弦有 16 个扇区 `(α, F, α̃, F̃)`（(10.6.3)）。
  「**Actually, six of these sectors are empty**: in the NS− sector the level `L_0 − α'p²/4` is half-integer, while in the sectors NS+, R+, and R− it is an integer. It is therefore impossible to satisfy the level-matching condition `L_0 = L̃_0` if NS− is paired with one of the other three.」
  相位 `exp πi(F_1α_2 − F_2α_1 − F̃_1α̃_2 + F̃_2α̃_1)`（(10.6.4)）；「If this phase is not unity, the amplitude with both operators cannot be consistently defined.」
  **三条一致性条件**（逐字标号 (a)(b)(c)）：
  (a) *mutual locality*：`F_1α_2 − F_2α_1 − F̃_1α̃_2 + F̃_2α̃_1 ∈ 2Z`（(10.6.5)）；
  (b) *OPE 闭合*：若 `(α_1,F_1,α̃_1,F̃_1)` 与 `(α_2,F_2,α̃_2,F̃_2)` 在谱中则 `(α_1+α_2, F_1+F_2, α̃_1+α̃_2, F̃_1+F̃_2)` 也在（(10.6.6)）；
  (c) *模不变性的一个必要条件*：「There must be at least one left-moving R sector (`α = 1`) and at least one right-moving R sector (`α̃ = 1`).」
- 文献自称的严格程度（**逐字**）：「Thus there are potentially `2^{10}` combinations of sectors, but only a few of these lead to consistent string theories. **We impose three consistency conditions**」；
  条件 (c)：「We will study modular invariance in the next section, but **in order to reduce the number of possibilities it is useful to extract one simple necessary condition**」
- 文献列出的依赖：E22、E26、E31（自旋场的分支切割）
- 备注：★ 「相互局域性」的物理理由（逐字）：「the spinor fields have branch cuts in the presence of R sector vertex operators.
  Various pairs of vertex operators will then have branch cuts in their operator products — they are not *mutually local*.
  The operator `F` counts the number of spinor fields in a vertex operator, so the net phase when one vertex operator circles another is…」

### E41 四个解：IIB / IIA / IIA′ / IIB′，以及快子的消失 ★★
- 位置：§10.6，(10.6.6) 下方的四行谱表 + (10.6.7)（p. 26–27）`[L1 原书]`
- 类型：proposition
- 原文陈述（**逐字**）：解这三个条件（先设至少有一个 R–NS 扇区 `(α, α̃) = (1,0)`）得到
  ```
  IIB : (NS+,NS+)  (R+,NS+)  (NS+,R+)  (R+,R+)
  IIA : (NS+,NS+)  (R+,NS+)  (NS+,R−)  (R+,R−)
  IIA′: (NS+,NS+)  (R−,NS+)  (NS+,R+)  (R−,R+)
  IIB′: (NS+,NS+)  (R−,NS+)  (NS+,R−)  (R−,R−)
  ```
  「**Notice that none of these theories contains the tachyon, which lives in the sector (NS−,NS−).**」
  「These four solutions represent just two physically distinct theories.」——`X² → −X²`、`ψ² → −ψ²`、`ψ̃² → −ψ̃²`（(10.6.7)）
  的时空反射把 IIA′ 变成 IIA、IIB′ 变成 IIB。
  若没有 R–NS 扇区，则只有两个额外解：
  ```
  0A : (NS+,NS+)  (NS−,NS−)  (R+,R−)  (R−,R+)
  0B : (NS+,NS+)  (NS−,NS−)  (R+,R+)  (R−,R−)
  ```
  「These are modular-invariant, but **both have a tachyon and there are no spacetime fermions**.」
  「In conclusion, we have found two potentially interesting string theories, the *type IIA and IIB superstring theories*.」
- 文献自称的严格程度：「Proceeding further, **one readily finds the only other solutions**」——穷举论证
- 文献列出的依赖：E40、E35（Table 10.2、Table 10.3）
- 备注：★★ **「快子被消除」在本书里的确切内容是：三条一致性条件的解里没有一个包含 (NS−,NS−) 扇区（IIA/IIB），
  或者虽然包含但那是 type 0（有快子）。** 这与「GSO 投影投掉快子」的通俗说法**不完全一样**——
  Polchinski 是先解一致性条件得到扇区组合，**再**（(10.6.9)/(10.6.10)）把它重述为 GSO 投影。转节点时要按前者写。

### E42 IIA / IIB 的无质量谱与 GSO 投影 ★★
- 位置：§10.6，eq. **(10.6.8a,b)**、**(10.6.9)**、**(10.6.10)**、**(10.6.11)**（p. 27–28）`[L1 原书]`
- 类型：proposition / definition
- 原文陈述（**逐字公式**）：无质量谱
  `IIA: [0] + [1] + [2] + [3] + (2) + 8 + 8′ + 56 + 56′`（(10.6.8a)）；
  `IIB: [0]² + [2]² + [4]_+ + (2) + 8′² + 56²`（(10.6.8b)）；
  「The IIB theory is defined by keeping all sectors with `exp(πiF) = exp(πiF̃) = +1`」（(10.6.9)）；
  「and the IIA theory by keeping all sectors with `exp(πiF) = +1`, `exp(πiF̃) = (−1)^{α̃}`」（(10.6.10)）。
  「**This projection of the full spectrum down to eigenspaces of `exp(πiF)` and `exp(πiF̃)` is known as the *Gliozzi–Scherk–Olive (GSO) projection*.**」
  「In the IIA theory the opposite GSO projections are taken in the NS–R and R–NS sectors, so the spectrum is nonchiral. That is, the spectrum is invariant under spacetime parity, which interchanges `8 ↔ 8′` and `56 ↔ 56′`. On the world-sheet, this symmetry is the product of spacetime parity and world-sheet parity. In the IIB theory the same GSO projection is taken in each sector and the spectrum is chiral.」
  type 0：「for example, 0B is defined by keeping all sectors with `α = α̃`, `exp(πiF) = exp(πiF̃)`」（(10.6.11)）；
  「The projections that define the type II theories act separately on the left- and right-moving spinors, while the projections that define the type 0 theory tie the two together. **The latter are sometimes called *diagonal GSO projections*.**」
- 文献自称的严格程度：定义 + 由 E41 的扇区表读出
- 文献列出的依赖：E41、Table 10.3（E35）
- 备注：★★ **GSO 投影在本书里是 E41 结论的重述，不是独立公设。** 这一点与很多教材（把 GSO 当成额外投影公设）不同，
  转节点时应准确反映：`gso-projection` 的推导依赖 `(10.6.5)/(10.6.6)/(c)` 三条一致性条件。

### E43 时空超对称与引力微子；对 RNS 形式的自评 ★
- 位置：§10.6，eq. **(10.6.12)**–**(10.6.15)** 与其后两段（p. 28–29）`[L1 原书]`
- 类型：proposition
- 原文陈述（**逐字公式**）：NS–R 引力微子态 `ψ_{−1/2}^μ|0;s;k⟩_{NS–R} u_{μs}`（(10.6.12)）；
  物理态条件 `k² = k^μu_{μs} = k·Γ_{ss'}u_{μs'} = 0`（(10.6.13)）；等价关系 `u_{μs} ≅ u_{μs} + k_μζ_s`（(10.6.14)）；
  「We have learned that such equivalence relations are **the signature of a local spacetime symmetry**. Here the symmetry parameter `ζ_s` is a spacetime spinor so we have **local spacetime supersymmetry**.」
  引力微子顶点算子 `V_s e^{−φ̃}ψ̃^μ e^{ik·X}`、`e^{−φ}ψ^μ Ṽ_s e^{ik·X}`（(10.6.15)），权重 `(1,0)` 与 `(0,1)`。
  自评（**逐字**）：「The reader may feel that the construction in this section, which is the *Ramond–Neveu–Schwarz (RNS)* form of the superstring, is somewhat **ad hoc**. In particular one might expect that the spacetime supersymmetry should be manifest from the start. **There is certainly truth to this**, but the existing supersymmetric formulation (the *Green–Schwarz superstring*) seems to be even more unwieldy.」
  另（**逐字**）：「This is to be expected: **if all requirements for a consistent string theory are met (and they are)** then the existence of the gravitinos implies that the corresponding supersymmetries must be present.」
- 文献自称的严格程度：如上——「ad hoc」是作者自评；「(and they are)」是**未加论证的断言**
- 文献列出的依赖：E42；附录 **B.2、B.4、B.5**（明写：「the reader should now study the appropriate sections of appendix B」）
- 备注：★ 「if all requirements … are met (and they are)」这句括号是本章少见的**赤裸断言**，
  转节点时若要用「IIA/IIB 有时空超对称」，`status` 应为 `physical-argument`，并把这句记进 note。

### E44 GSO 与自旋-统计
- 位置：§10.6（p. 29）`[L1 原书]`，无式号
- 类型：proposition
- 原文陈述（**逐字**）：「In bosonized form, all the R sector vertex operators have odd length-squared and all the NS sector vertex operators have even length-squared, in terms of the `∘` product defined in section 10.4. This can be seen at the lowest levels for the operators (10.4.22) and (10.4.25), **the tachyon having been removed by the GSO projection**. By the remark at the end of section 10.4, the space-time spin is then correlated with the *world-sheet* statistics. In fact, this is the same as the *space-time* statistics. … The result is the expected spacetime spin-statistics connection. … **This is certainly a rather technical way for the spin-statistics theorem to arise, but it is worth noting that all string theories seem to obey the usual spin-statistics relation.**」
- 文献自称的严格程度：如上（"seem to obey"）
- 文献列出的依赖：E32、E42

### E45 无取向与开超弦：type I ★
- 位置：§10.6「Unoriented and open superstrings」，eq. **(10.6.16)**–**(10.6.18)** 与其后（p. 29–30）`[L1 原书]`
- 类型：proposition
- 原文陈述（**逐字公式**）：IIB 有世界面宇称对称性 `Ω`，规范掉它得无取向闭弦理论；
  R–R 顶点算子 `V_s Ṽ_{s'}`（(10.6.16)）按 `8 × 8 = [0] + [2] + [4]_+` 变换，世界面宇称给
  `Ṽ_{s'}V_s = −V_sṼ_{s'}`（(10.6.17)），「where the final sign comes from the fermionic nature of the R vertex operators」，
  故投影到 `Ω = +1` 挑出反对称的 `[2]`；结果是 *type I closed unoriented theory*，谱为
  `[0] + [2] + (2) + 8′ + 56 = 1 + 28 + 35 + 8′ + 56`（(10.6.18)）。
  「**However, this theory by itself is inconsistent, as we will explain further below.**」
  开弦：「Closure of the OPE in open + open → closed scattering implies that any open string that couples consistently to type I or type II closed superstrings must have a GSO projection in the open string sector. The two possibilities and their massless spectra are」
  `I : NS+, R+ = 8_v + 8`；`Ĩ : NS+, R− = 8_v + 8′`。
  「Adding Chan–Paton factors, the gauge group will again be `U(n)` in the oriented case and `SO(n)` or `Sp(n)` in the unoriented case. The `8` or `8′` spinors are known as *gauginos* because they are related to the gauge bosons by supersymmetry. They must be in the adjoint representation of the gauge group, like the gauge bosons, because supersymmetry commutes with the gauge symmetry.」
- 文献自称的严格程度：如上；「as we will explain further below」指向 §10.8（发散/反常抵消）
- 文献列出的依赖：E42；脚注 4（p. 30，逐字）：「The analogous operation in the IIA theory would be to gauge the symmetry which is the product of world-sheet and spacetime parity, but this breaks some of the Poincaré invariance. We will encounter this in section 13.2.」
- 备注：★ **type I 的一致性（`SO(32)`）在本章 §10.8 才定，见 E47。** 本条只给谱。

### E46 三个无快子、无反常的十维理论：IIA、IIB、I `SO(32)` ★★
- 位置：§10.6 末，eq. **(10.6.19)**（p. 31）`[L1 原书]`
- 类型：proposition
- 原文陈述（**逐字**）：「We can already anticipate that not all of these theories will be consistent. The open string multiplets, with 16 states, are representations of `d = 10`, `N = 1` supersymmetry but not of `N = 2` supersymmetry. Thus the open superstring **cannot couple to the oriented closed superstring theories, which have two gravitinos**.⁵ It can only couple to the unoriented closed string theory (10.6.18) and so the open string theory must also be unoriented for consistent interactions. With the chirality (10.6.18), the massless open string states must be `8_v + 8`. This is required by spacetime supersymmetry, or by conservation of `exp(πiF)` on the world-sheet. The result is the unoriented *type I open plus closed superstring theory*, with massless content」
  `[0] + [2] + (2) + 8′ + 56 + (8_v + 8)_{SO(n) or Sp(k)}`（(10.6.19)）。
  「**There is a further inconsistency in all but the `SO(32)` theory.** We will see in section 10.8 that for all other groups, as well as the purely closed unoriented theory, there is a one-loop divergence and superconformal anomaly. We will also see, in chapter 12, that the spacetime gauge and coordinate symmetries have an anomaly at one loop for all but the `SO(32)` theory.
  **Thus we have found precisely three tachyon-free and nonanomalous string theories in this chapter: type IIA, type IIB, and type I `SO(32)`.**」
- 文献自称的严格程度：如上；反常抵消本身被推给 **§10.8** 与 **第 12 章**
- 文献列出的依赖：E41、E42、E45；§10.8（E48）、§12（未读）
- 备注：★★ 脚注 5（p. 31，**逐字**）给了「开弦不能耦合到取向闭超弦」的世界面理由：
  「At the world-sheet level the problem is that the total derivative null gravitino vertex operators give rise to nonzero world-sheet boundary terms. Only one linear combination of the two null gravitinos decouples, so we must make the world-sheet parity projection in order to eliminate the other.」
  → 「本章恰好三个理论」这条结论**依赖两处尚未给出的论证**（§10.8 的 tadpole 抵消、§12 的时空反常抵消）。转节点时必须写成有条件的。

### E47 环面振幅与模不变性 ★
- 位置：§10.7，eq. **(10.7.1)**–**(10.7.16)**（p. 31–35）`[L1 原书]`
- 类型：proposition
- 原文陈述（要点，**逐字公式**）：
  环面真空振幅（Coleman–Weinberg 形式，取自 Vol.1 **(7.3.24)**）
  `Z_{T₂} = V_{10} ∫_F (d²τ/4τ₂) ∫ (d^{10}k/(2π)^{10}) Σ_{i∈H^⊥} (−1)^{F_i} q^{α'(k²+m_i²)/4} q̄^{α'(k²+m̃_i²)/4}`（(10.7.1)），`q = exp(2πiτ)`；
  `m² = 4H^⊥/α'`，`m̃² = 4H̃^⊥/α'`（(10.7.2)）；`X` 的贡献 `Z_X(τ) = (4π²α'τ₂)^{−1/2}|η(τ)|^{−2}`（(10.7.3)，引 Vol.1 **(7.2.9)**）；
  一般周期 `ψ(w+2π) = exp[πi(1−α)]ψ(w)`，`α = 1 − 2ν`（(10.7.4)）；升算符 (10.7.5)；
  基态权重 `α²/8`；`Tr_α(q^H) = q^{(3α²−1)/24}Π_{m=1}^∞[1+q^{m−(1−α)/2}][1+q^{m−(1+α)/2}]`（(10.7.6)）；
  一般迹 `Z^α_β(τ) = Tr_α[q^H exp(πiβQ)]`（(10.7.7a)）= …（(10.7.7b)）
  `= (1/η(τ)) ϑ[α/2, β/2](0,τ)`（(10.7.7c)）——「The notation in the final line was introduced in **section 7.2**, but our discussion of these functions in the present volume will be self-contained.」；
  四个相关迹 `Z^0_0 = Tr_NS[q^H]`、`Z^0_1 = Tr_NS[exp(πiF)q^H]`、`Z^1_0 = Tr_R[q^H]`、`Z^1_1 = Tr_R[exp(πiF)q^H]`（(10.7.8a–d)）——
  「We should emphasize that these traces are for a *pair* of dimensions.」；
  `Z_ψ^±(τ) = (1/2)[Z^0_0(τ)⁴ − Z^0_1(τ)⁴ − Z^1_0(τ)⁴ ∓ Z^1_1(τ)⁴]`（(10.7.9)）——
  「The half is from the projection operator, the minus sign in the second term is from the ghost contribution to `exp(πiF)`, and the minus signs in the third and fourth (R sector) terms are from spacetime spin-statistics.」；
  总振幅 `Z_{T₂} = iV_{10}∫_F (d²τ/16π²α'τ₂²) Z_X⁸ Z_ψ^+(τ) Z_ψ^+(τ)*`（(10.7.10)）；
  模变换 `Z^α_β(τ) = Z^β_{−α}(−1/τ) = exp[−πi(3α²−1)/12] Z^α_{α+β−1}(τ+1)`（(10.7.14)）；
  type 0 的费米迹 `(1/2)[|Z^0_0|^N + |Z^0_1|^N + |Z^1_0|^N ∓ |Z^1_1|^N]`（(10.7.15)），「with `N = 8`. This is known as the *diagonal modular invariant*」；
  Jacobi 的「abstruse identity」`Z^0_0(τ)⁴ − Z^0_1(τ)⁴ − Z^1_0(τ)⁴ = 0`（(10.7.16)）。
- 文献自称的严格程度（**逐字**，多处重要）：
  - 「**We make the guess, correctly it will turn out**, that the torus amplitude is again given by the Coleman–Weinberg formula (7.3.24)…」 ← ★ **又一次「猜」**
  - 「Naively then, `Z^α_β(τ) = Z^α_{α+β−1}(τ+1)`… so that **naively** `Z^α_β(τ) = Z^β_{−α}(−1/τ)`. **The reason these modular transformations are naive is that there is no diff-invariant way to define the phase of the path integral for purely left-moving fermions.**」
  - 「The phase represents a *global gravitational anomaly*, an inability to define the phase of the path integral such that it is invariant under large coordinate transformations.」
  - 「**The reader can verify** that with the transformations (10.7.14), the combinations `Z_ψ^±` are invariant under `τ → −1/τ`…」
  - 「**It is necessary for the construction of this invariant that there be a multiple of *eight* transverse fermions.**」
  - 「Although we have focused on the path integral without vertex operators, amplitudes with vertex operators must also be modular-invariant. In the present case the essential issue is the path integral measure, and **one can show by explicit calculation (or by indirect arguments)** that the modular properties are the same with or without vertex operators.」
  - 脚注 6（**逐字**）：「The phase factor is a holomorphic function of `τ`, because the `Z^α_β` are. Since it has magnitude 1, this implies that it is actually independent of `τ`.」
- 文献列出的依赖：Vol.1 **(7.3.24)**、**(7.2.9)**、**§7.2**（theta 函数与 `τ→τ+1` 要求 `L_0 − L̃_0 ∈ Z`）、**§7.4**；E40、E42
- 备注：★ 三条对图有用的事实：
  1. **「必须有 8 的倍数个横向费米子」是模不变性的要求**（逐字），这是 `D = 10` 的一个**独立的必要条件来源**
     （与 E12/E37 的中心荷路线不同）。→ 可考虑作为 `D = 10` 的第三条 derivation，但注意它给的是「横向费米子数 ≡ 0 mod 8」，
     不是直接给 `D = 10`。
  2. **模不变性还固定了 (10.7.9) 里的相对符号**：「modular invariance forces the minus signs in the combination (10.7.9), in particular the relative sign of `(Z^0_0)⁴` and `(Z^1_0)⁴` **which corresponds to Fermi statistics for the R sector states**」（逐字）。
  3. type II 的 `Z_{T₂} = 0` 依赖 Jacobi 恒等式 (10.7.16) 与 `Z^1_1 = 0`；但 Polchinski 强调**一般振幅要求真空是模不变的
     「*without* using the vanishing of `Z^1_1` or the abstruse identity (10.7.16) — as we have required」**（逐字）。

### E48 type I 的发散抵消只在 `SO(32)` 成立 ★★
- 位置：§10.8，eq. **(10.8.1)**–**(10.8.19)**（p. 37–42）`[L1 原书]`
- 类型：proposition
- 原文陈述（要点，**逐字公式**）：
  柱面 `Z_{C₂} = Z_{C₂,0} + Z_{C₂,1}`（(10.8.1)），两项分别对应闭弦 NS–NS 与 R–R 交换（(10.8.2a,b)）；
  「Note that the GSO and `Ω` projection operators each contribute a factor of `1/2`.」
  用模变换 (10.8.3) 得 `Z_{C₂,0} = i (V_{10}n²/8π(8π²α'²)⁵) ∫₀^∞ ds [16 + O(exp(−2s))]`（(10.8.4)）；
  「The divergence as `s → ∞` is due to a massless closed string tadpole, which as noted must be an NS–NS state.」
  ⚠ **悖论**（逐字）：「However, there is a paradox here: the `d = 10`, `N = 1` supersymmetry algebra does not allow such a term. Even more puzzling, `Z_{C₂,1}` has an equal and opposite divergence which must be from a tadpole of an R–R state, but the only massless R–R state is the rank 2 tensor which cannot have a Lorentz-invariant tadpole.」
  解决（逐字）：「**One can guess the resolution of this as follows.**」——10-form 势 `C_{10}` 可以存在，其场强恒为零；
  `μ_{10}∫C_{10}`（(10.8.5)）在 `δC_{10} = dχ_9` 下不变；无动能项 ⇒ 传播子 `1/0`，tadpole 的效应是发散 `μ_{10}²/0`（(10.8.6)）。
  「**This must be the origin of the divergence in `Z_{C₂,1}`, as indeed a more detailed analysis does show.** The equation of motion from varying `C_{10}` is just `μ_{10} = 0`, so unlike the divergences encountered previously **this one cannot be removed by a correction to the background fields. It represents an actual inconsistency.**」
  Klein 瓶：(10.8.7)–(10.8.11)，`Z_{K₂,0} = i(2^{10}V_{10}/8π(8π²α'²)⁵)∫₀^∞ ds[16 + O(exp(−2s))]`（(10.8.11)），`Z_{K₂,1} = −Z_{K₂,0}`；
  Möbius 带：`Ωψ_r^μΩ^{−1} = exp(−πir)ψ_r^μ`（(10.8.13)），`Ω² = exp(πiF)`（(10.8.14)），投影算符 `(1+Ω+Ω²+Ω³)/4`（(10.8.15)）；
  `Z_{M₂,1} = ±2in (2⁵V_{10}/8π(8π²α'²)⁵) ∫₀^∞ ds [16 + O(exp(−2s))]`（(10.8.18)），「where the upper sign is for `SO(n)`」；
  **总的 R–R 交换发散** `Z_1 = −i(n ∓ 32)² (V_{10}/8π(8π²α'²)⁵) ∫₀^∞ ds [16 + O(exp(−2s))]`（(10.8.19)）。
  「**The R–R tadpole vanishes only for the gauge group `SO(32)`.** For each world-sheet topology the NS–NS divergence is the negative of the R–R divergence, so the dilaton–graviton tadpole also vanishes for `SO(32)`. This calculation does not determine the sign of the tadpole, but it should be `n ∓ 32`. That is, changing from a symplectic to orthogonal projection changes the sign of `RP₂`, not of the disk. This is necessary for unitarity: the number of cross-caps is conserved mod 2 when a surface is cut open, so the sign is not determined by unitarity; this is not the case for the number of boundaries.」
- 文献自称的严格程度（**逐字**）：「**One can guess the resolution** of this as follows」；「as indeed **a more detailed analysis does show**」（不给该分析）；
  「The cancellation is very similar to what we have already seen in the bosonic theory in chapter 7.」
- 文献列出的依赖：Vol.1 **(7.4.1)**、**(7.4.15)**、**(7.4.22)**、**§7.4**（明写）；E47（(10.7.9) 的费米迹）、E45
- 备注：★★ 脚注 7（p. 39，**逐字**）是一处容易漏的技术要点：
  「In the vacuum amplitude the sum of the NS–NS and R–R divergences is zero for each topology separately because the trace vanishes by supersymmetry. **This is not sufficient**, because they will no longer cancel when vertex operators are added near one end of each surface. **The NS–NS and R–R tadpoles must vanish separately when summed over topologies.**」
  → 「`SO(32)`」这条结论的**逻辑形式**是：要求 NS–NS 与 R–R tadpole **各自**在拓扑求和后为零 ⇒ `n = 32` 且是正交投影。

### E49 第 10 章的习题清单（作为「哪些论证被推给读者」的清单）★
- 位置：§10「Exercises」（p. 43–44）`[L1 原书]`
- 类型：（元信息，不是陈述）
- 原文陈述：全章 15 道习题。与本记录条目直接相关的（**逐字题干节选**）：
  - **10.1** (a) Find the OPE of `T_F` with `X^μ` and `ψ^μ`. (b) Show that the residues of the OPEs of the currents (10.1.9) are proportional to the superconformal variations (10.1.10). → E5
  - **10.2** (a) Verify the commutator (10.1.11), **up to terms proportional to the equations of motion**. (b) Verify that the commutator of a conformal and a superconformal transformation is a superconformal transformation. → E6
  - **10.3** (a) Verify the OPE (10.1.13). (b) Extend this to the linear dilaton SCFT (10.1.22). → E7、E14
  - **10.4** Obtain the R and NS algebras (10.2.11) from the OPE. → E18
  - **10.5** From the Jacobi identity for the R–NS algebra, show that the coefficients of the central charge terms in `T_BT_B` and `T_FT_F` are related. → E10
  - **10.7** Verify that the expectation value (10.3.7) has the appropriate behavior as `z_i → ∞`, and show that together with the OPE this determines the result up to normalization. → E25
  - **10.8** Verify the weight of the fermionic ground state `A_ν` for general real `ν`: (a) from the commutator **(2.7.8)**; (b) from the mnemonic of **section 2.9**. 「The most direct, but most time-consuming, method would be to find the relation between conformal and creation–annihilation normal ordering as in eq. **(2.7.11)**.」 → E26；**且这是 Vol.1 §2.9 有「助记法」的第二个一手证据**（见 §4 Q2）
  - **10.9** By any of the above methods, determine the ghost normal ordering constants (10.4.5). → E28
  - **10.12** By looking at the eigenvalues of `S_a`, verify the spinor decompositions (10.5.17). → E35
  - **10.13** (a) Verify the operator products (10.5.22). (b) **Using the Jacobi identity as in exercise 4.3, verify nilpotence of `Q_B`.** → **E37（`Q_B² = 0` 的唯一「证明」入口）**
  - **10.14** Work out the massless level of the open superstring in BRST quantization. → E39 的低能级验证
- 备注：★ **本条对图很有用**：它精确列出了 Polchinski 把哪些论证推给了读者。
  按本项目「状态只能实话实说」的原则，凡是被推给习题的步骤，**该节点的 derivation 应记 `physical-argument` 或注明「书中不证」**。
  其中 **10.13(b)**（`Q_B` 幂零）与 **10.5**（`c_B = c_F`）是最要紧的两条；两者 [H] 都给了完整解答（见 E10、E37 的备注）。

---

### E50 §11.1 的纲领：穷举可能的世界面**约束**代数 ★
- 位置：§11.1 开头（p. 45–46）`[L1 原书]`
- 类型：（纲领性陈述）
- 原文陈述（**逐字**）：「In the last chapter we were led **by guesswork** to the idea of enlarging the world-sheet constraint algebra, adding the supercurrents `T_F(z)` and `T̃_F(z̄)`. Now let us see how much further we can generalize this idea. We are looking for sets of holomorphic and antiholomorphic currents whose Laurent coefficients form a closed algebra.」
  关键区分（**逐字**）：「Let us start by emphasizing the distinction between *global symmetries* and *constraints*. … However, we are also singling out part of the symmetry to impose as a *constraint*, meaning that physical states must be annihilated by it, either in the OCQ or BRST sense. In the bosonic string, the spacetime Poincaré invariance was a global symmetry of the world-sheet theory, while the conformal symmetry was a constraint. **Our present interest is in constraint algebras.**」
- 文献自称的严格程度：纲领
- 文献列出的依赖：第 10 章
- 备注：★ 「全局对称 vs 约束」这个区分对图很重要——`worldsheet` 区里的「Virasoro 是约束」与「Poincaré 是全局对称」
  是两类不同的节点，本书在这里给了明确的措辞依据。
  ⚠ **又一条 Vol.1 §2.9 的一手引用（逐字）**：「we have seen in **section 2.9** that in a unitary CFT an operator is holomorphic **if and only if** it is of weight `(h, 0)` with `h ≥ 0`」。见 §4 Q2。

### E51 约束代数分类的三条限制假设与鬼场中心荷通式 ★★
- 位置：§11.1，eq. **(11.1.1)**、**(11.1.2a,b)** 与 **Table 11.1**（p. 46–47）`[L1 原书]`
- 类型：proposition / definition
- 原文陈述（**逐字公式与措辞**）：
  三条限制（作者自己列出的假设）：
  1. **`h ≥ 2`（W 代数）被排除**：「One complication is that the commutator of generators is in general a nonlinear function of the generators, making the construction of the BRST operator nontrivial. The few examples that have been constructed appear, upon gauge fixing, to be special cases of bosonic strings. Further, the geometric interpretation, analogous to the Riemann surface construction used to formulate bosonic string perturbation theory, is not clear. **So we will restrict our attention to constraint algebras with `h ≤ 2`.**」
     并且：「**we will assume that there is precisely one `(2,0)` constraint current which is the overall energy-momentum tensor.**」
  2. **`h` 非半整数倍被排除**：`j(z)j(0) ∼ z^{−2h}`（(11.1.1)）「with a coefficient that **can be shown by a positivity argument** not to vanish. This is multi-valued if `2h` is not an integer. … Attempts to construct such *fractional strings* have led only to partial results and **it is not clear if such theories exist**. **So we will restrict our attention to `h` a multiple of `1/2`.**」
  3. 于是「With these assumptions the possible algebras are very limited, with spins `0, 1/2, 1, 3/2,` and `2`.
     **Solution of the Jacobi identities allows only the algebras shown in table 11.1.**」
  **鬼场中心荷通式**：`c_h = (−1)^{2h+1}[3(2h−1)² − 1]`（(11.1.2a)）；
  `c_2 = −26`，`c_{3/2} = +11`，`c_1 = −2`，`c_{1/2} = −1`，`c_0 = −2`（(11.1.2b)）。
  「The sign `(−1)^{2h+1}` takes into account the statistics of the ghosts, anticommuting for integer spin and commuting for half-integer spin. **Since the matter central charge `c^m` is `−c^g`, there is only one new algebra, `N = 2`, that can have a positive critical dimension.**」
  **Table 11.1「World-sheet superconformal algebras」**（列：`n_{3/2} ≡ N`, `n_1`, `n_{1/2}`, `n_0`, `c^g`, symmetry, `T_F` rep）
  前三行（**逐字，抽取者确信**）：
  | `N` | `n_1` | `n_{1/2}` | `n_0` | `c^g` | symmetry | `T_F` rep |
  |---|---|---|---|---|---|---|
  | 0 | 0 | 0 | 0 | **−26** | — | — |
  | 1 | 0 | 0 | 0 | **−15** | — | — |
  | 2 | 1 | 0 | 0 | **−6** | `U(1)` | `±1` |
  后四行（`N = 3` 一行与 `N = 4` 三行，`c^g` 分别为 `0, 0, 0, 12`，symmetry 为 `SU(2)`、`SU(2)×SU(2)×U(1)`、`SU(2)×SU(2)`、`SU(2)`）
  **抽取者对这四行的 `n_1`/`n_{1/2}` 数字读图不确定**，见 §4 Q10。
- 文献自称的严格程度：如上——**分类是「Solution of the Jacobi identities allows only…」，但书中不给这个求解**
- 文献列出的依赖：E10、E12；(11.1.1) 的正定性论证（不给）
- 备注：★★ **对本项目极有价值的三点：**
  1. **(11.1.2a) 是一条通式，`−26` 与 `+11` 都是它的特例**（`h = 2` 与 `h = 3/2`）。
     这比 Vol.1 (2.5.12)/(2.5.24) 分开给更统一，且**式号已 L1 核实**。
     → 可以为「一般自旋 `h` 的鬼场中心荷」建一个节点，`sources.loc = "Vol.2 §11.1, eq. (11.1.2a)"`。
  2. 表的第一行 `c^g = −26`、第二行 `c^g = −15` 就是玻色弦与超弦的临界条件，**即 `D = 26` 与 `D = 10` 在同一张表里**。
  3. 「`c^m = −c^g`」这条被当作显然写出，是「总中心荷为零」这个公设（E33 讨论过）的又一次出现。

### E52 `N = 2` 代数与其临界维数 4（但号差不能是 Minkowski）
- 位置：§11.1，eq. **(11.1.3)**–**(11.1.6b)**（p. 47–48）`[L1 原书]`
- 类型：definition / proposition
- 原文陈述（**逐字公式**）：复超流 `T_F^± = 2^{−1/2}(T_{F1} ± iT_{F2})`（(11.1.3)）；
  `N = 2` 代数的 OPE 形式 (11.1.4a)–(11.1.4f)，其中
  `T_F^+(z)T_F^−(0) ∼ 2c/(3z³) + (2/z²)j(0) + (2/z)T_B(0) + (1/z)∂j(0)`（(11.1.4c)）、
  `T_F^+(z)T_F^+(0) ∼ T_F^−(z)T_F^−(0) ∼ 0`（(11.1.4d)）、`j(z)j(0) ∼ c/(3z²)`（(11.1.4f)）；
  最小线性表示是 `Zψψ̃` CFT（(11.1.5) 作用量、(11.1.6a,b) 流），中心荷 3。
  「Since there are two real scalars in each CFT the critical dimension is 4. However, these dimensions come in complex pairs, so that the spacetime signature can be purely Euclidean, or `(2,2)`, **but not the Minkowski `(3,1)`**. … Thus there is just the center-of-mass motion of a single state. This has some mathematical interest, but **whether it has physical applications is more conjectural**.」
- 文献自称的严格程度（**逐字**）：「This follows from the Jacobi identity for the modes, but **we will not write out the mode expansion in full until chapter 19**, where we will have more need of it.」
- 文献列出的依赖：E51
- 备注：`(N, Ñ) = (0,1)` 即杂化弦：「This allows the one new possibility, the `(N, Ñ) = (0,1)` *heterotic string*; `(N, Ñ) = (1,0)` would be the same on redefining `z → z̄`.」（逐字）

### E53 ⚠ 作者自己对分类完备性的警告 ★★★
- 位置：§11.1 末（p. 48–49）`[L1 原书]`
- 类型：（元陈述/限定）
- 原文陈述（**逐字**）：「**It should be emphasized that the analysis in this section had many explicit and implicit assumptions, and one should be cautious in assuming that all string theories have been found.** Indeed, there are some string theories that do not fall into this classification. One is the Green–Schwarz form of the superstring, which has no simple covariant gauge-fixing, but in the light-cone gauge it is in fact equivalent to the RNS superstring, via bosonization. … Another exception is *topological string theory*, where in a covariant gauge the constraints do not satisfy spin-statistics as we have assumed. …
  In fact, we will find the same set of physical string theories from an entirely different and nonperturbative point of view in chapter 14, **suggesting** that all have been found. To be precise, there are other theories with stringlike excitations, but the theories found in this and the previous chapter **seem to be** the only ones which have a limit where they become weakly coupled, so that string perturbation theory exists.」
- 文献自称的严格程度：如上——**"one should be cautious"、"suggesting"、"seem to be"**
- 文献列出的依赖：E51、E52
- 备注：★★★ 这是全两卷里对「弦论的分类是完备的」这条常见断言**最直接的作者级限定**。
  → 若图里有「十维一致弦论恰有五个」这类节点，**必须**引用本条，`status` 只能是 `conjecture` 或 `physical-argument`。

### E54 杂化弦的场内容与中心荷分配 ★
- 位置：§11.2，eq. **(11.2.1)**–**(11.2.5c)**（p. 49–50）`[L1 原书]`
- 类型：definition
- 原文陈述（**逐字公式**）：`X^μ(z,z̄)`、`ψ̃^μ(z̄)`，`μ = 0, …, 9`（(11.2.1)），**总中心荷 `(c, c̃) = (10, 15)`**；
  「The ghost central charges add up to `(c^g, c̃^g) = (−26, −15)`, so the remaining matter has `(c, c̃) = (16, 0)`.
  The simplest possibility is to take **32 left-moving spin-`1/2` fields** `λ^A(z)`, `A = 1, …, 32`」（(11.2.2)）；
  作用量 `S = (1/4π)∫d²z ( (2/α')∂X^μ∂̄X_μ + λ^A∂̄λ^A + ψ̃^μ∂ψ̃_μ )`（(11.2.3)）；
  OPE (11.2.4a,b,c)；`T_B = −(1/α')∂X^μ∂X_μ − (1/2)λ^A∂λ^A`（(11.2.5a)）、
  `T̃_B = −(1/α')∂̄X^μ∂̄X_μ − (1/2)ψ̃^μ∂̄ψ̃_μ`（(11.2.5b)）、`T̃_F = i(2/α')^{1/2}ψ̃^μ∂̄X_μ`（(11.2.5c)）。
- 文献自称的严格程度：构造性
- 文献列出的依赖：E51（表 11.1 的 `c^g = −26` 与 `−15`）、E3、E4
- 备注：★ 「`16 = 32 × (1/2)`」这个配平是 `SO(32)` 的来源。
  「The world-sheet theory has symmetry `SO(9,1) × SO(32)`. The `SO(32)`, acting on the `λ^A`, is an internal symmetry.
  In particular, **none of the `λ^A` can have a timelike signature because there is no fermionic constraint on the left-moving side to remove states of negative norm.**」（逐字）——这是一条**真实的技术限制**，转节点时别漏。

### E55 杂化弦的 BRST 与无鬼定理（一句话，无证明）★★
- 位置：§11.2（p. 50），**无式号** `[L1 原书]`
- 类型：proposition
- 原文陈述（**逐字**）：「The right-moving ghosts are the same as in the RNS superstring, and the left-movers are as in the bosonic string. **It is straightforward to construct the nilpotent BRST charge and show the no-ghost theorem, with any BRST-invariant periodicity conditions.** As usual this still holds if we replace any of the spatial `(X^μ, ψ̃^μ)` and the `λ^A` with a unitary `(0,1)` SCFT of the equivalent central charge.」
- 文献自称的严格程度（**逐字**）：「**It is straightforward to construct … and show …**」——**书中不构造、不证明、不引文献**
- 文献列出的依赖：E39（超弦无鬼定理）、Vol.1 §4.4（玻色弦无鬼定理）
- 备注：★★ 与 E39 的「direct imitation」并列，是本卷第二条「无鬼定理靠类比」的陈述，且**比 E39 更弱**
  （E39 至少给了 `H^⊥` 的定义与三重结论；这里连陈述都只有半句）。
  → 图里若要建 `worldsheet.no-ghost-theorem--heterotic`，`sources.loc` 只能写「Vol.2 §11.2, p. 50（无式号）」，
  且必须注明「书中只作断言」。见 §4 Q4。

### E56 `SO(32)` 杂化弦：GSO、配分函数、无质量谱 ★
- 位置：§11.2，eq. **(11.2.6)**–**(11.2.18)** 与 **Table 11.2**（p. 50–53）`[L1 原书]`
- 类型：proposition
- 原文陈述（**逐字公式**）：`λ^A(w+2π) = O^{AB}λ^B(w)`，`O ∈ O(32)`（(11.2.6)）——
  「Periodicity of `T_B` only requires that the `λ^A` be periodic up to an arbitrary `O(32)` rotation」；
  右移 GSO：`s·s′ + l/2 ∈ Z`（(11.2.7)，`l = −1` 在 NS、`−1/2` 在 R）⇒ `exp(πiF̃) = 1`（(11.2.8)）；
  左移取 `λ^A(w+2π) = ±λ^A(w)`（(11.2.9)，32 个分量同号）并强加 `exp(πiF) = 1`（(11.2.10)）；
  复化 `λ^{K±} = 2^{−1/2}(λ^{2K−1} ± iλ^{2K})`，`K = 1,…,16`（(11.2.11)），玻色化为 16 个左移标量 `H^K(z)`，
  `F = Σ_{K=1}^{16} q_K`（(11.2.12)）；
  配分函数 `Z_{16}(τ) = (1/2)[Z^0_0(τ)^{16} + Z^0_1(τ)^{16} + Z^1_0(τ)^{16} + Z^1_1(τ)^{16}]`（(11.2.13)）——
  「The form (11.2.13) parallels that of `Z_ψ^+(τ)` in the type II string **but with all `+` signs**」，理由（逐字）：
  「With 32 rather than 8 fermions, the signs in the modular transformations are raised to the fourth power and so the first three terms must enter with a common sign. … the relative minus sign in the first and second terms of `Z_ψ^+(τ)` came from the `F` of the superconformal ghosts, **which we do not have on the left-moving side** of the heterotic string. The relative minus sign in the first and third terms came from spacetime statistics, **but the `λ` are spacetime scalars** and so are their R sector states.」
  左移正规序常数 `NS: −8/24 − 32/48 = −1`，`R: −8/24 + 32/24 = +1`（(11.2.14)）——
  「**The left-moving NS ground state is therefore a tachyon.**」但第一激发态 `λ^A_{−1/2}|0⟩_NS`（(11.2.15)）被 (11.2.10) 投掉；
  `H^⊥ = 0` 的态有两种：`α^i_{−1}|0⟩_NS`、`λ^A_{−1/2}λ^B_{−1/2}|0⟩_NS`（(11.2.16)），后者按 `SO(32)` 的 `[2]` 变换，
  维数 `32 × 31/2 = 496`，即伴随表示；
  **Table 11.2「Low-lying heterotic string states」**：`m² = −4/α'` 行 NS = `(1,1)`，R/ÑS/R̃ 为空；
  `m² = 0` 行 NS = `(8_v,1) + (1,496)`，R 空，ÑS = `8_v`，R̃ = `8`；
  无质量乘积 `(8_v,1) × (8_v + 8) = (1,1)+(28,1)+(35,1)+(56,1)+(8′,1)`（(11.2.17)，type I 超引力多重态）与
  `(1,496) × (8_v + 8) = (8_v,496) + (8,496)`（(11.2.18)，`SO(32)` 伴随的 `N=1` 规范多重态）。
- 文献自称的严格程度（**逐字**）：「**It is easily verified by means of bosonization** that the OPE is local and closed」；
  「**Modular invariance is straightforward.**」；
  「The left-moving side, like the bosonic string, has a would-be tachyon, but **there is no right-mover to pair it with so the theory is tachyon-free**.」
- 文献列出的依赖：E42、E47、E54
- 备注：★ 「杂化弦无快子」的机制**不是 GSO 投掉**，而是**level matching 找不到配对**（逐字如上）。
  这与 type II 的机制（E41）不同，转节点时不要混。
  另（逐字）：「Remarkably, however, we will see in **chapter 14** that the type I and heterotic `SO(32)` theories are one and the same.」

### E57 `E₈ × E₈` 杂化弦；以及「十维只有两个超对称杂化弦」
- 位置：§11.2，eq. **(11.2.19)**–**(11.2.28)**（p. 53–55）`[L1 原书]`
- 类型：proposition
- 原文陈述（**逐字公式**）：把 `λ^A` 分成两组 16，独立周期条件（(11.2.19)），
  对应算符 `exp(πiF_1)`、`exp(πiF_1′)`（(11.2.20)），对 `2³ = 8` 种周期组合求和并投影
  `exp(πiF_1) = exp(πiF_1′) = exp(πiF̃) = 1`（(11.2.21)）；
  配分函数 `Z_8(τ)² = (1/4)[Z^0_0(τ)^8 + Z^0_1(τ)^8 + Z^1_0(τ)^8 + Z^1_1(τ)^8]²`（(11.2.22)）——
  「**It is important here that the fermions are in groups of 16**, so that the minus signs from `Z_ψ^±` (which was for eight fermions) are squared.」
  R–NS′ 扇区正规序常数 `−8/24 + 16/24 − 16/48 = 0`（(11.2.24)）⇒ 基态无质量，16 个 `λ^A` 零模给 256 维旋量，
  GSO 分成 `128 + 128′`，前者留下；
  左移无质量内容 `(8_v,1,1) + (1,120,1) + (1,1,120) + (1,128,1) + (1,1,128)`（(11.2.25)）；
  「Consistency of the spacetime theory requires that massless vectors transform under the *adjoint* representation of the gauge group.
  There is indeed a group, the exceptional group `E₈`, that has an `SO(16)` subgroup under which the `E₈` adjoint **248** transforms as `120 + 128`.
  **Evidently this second heterotic string theory has gauge group `E₈ × E₈`.**」
  额外流由玻色化给出 `exp[i Σ_{K=1}^{16} q_K H^K(z)]`（(11.2.26)），`q_K = ±1/2`（`K = 1..8`）或 `0`（`K = 9..16`），`Σ q_K ∈ 2Z`（(11.2.27)）；
  完整无质量谱 (11.2.28)。
  结论（**逐字**）：「Consistency requires the fermions to be in groups of 16. We could make a modular-invariant theory using groups of eight, the left-moving partition function being `(Z_ψ^±)⁴`. However, we have seen that modular invariance requires minus signs in `Z_ψ^±`. These signs would give negative weight to left-moving R sector states and would correspond to the projection `exp(πiF) = −1` in the NS sector. The first is inconsistent with spin-statistics because these states are spacetime scalars, and the second is inconsistent with closure of the OPE thus making the interactions inconsistent. **The `SO(32)` and `E₈ × E₈` theories are the only supersymmetric heterotic strings in ten dimensions.**」
- 文献自称的严格程度：「Again closure and locality of the OPE and modular invariance **are easily verified**.」；「Evidently」
- 文献列出的依赖：E56、E47
- 备注：注意「`E₈ × E₈` 是唯一另一个」这条结论的论证是**排除法 + 自旋统计 + OPE 闭合**，不是穷举证明。

### E58 其它十维杂化弦（含无超对称但无快子的 `SO(16)×SO(16)`）
- 位置：§11.3，eq. **(11.3.1)**–**(11.3.3)** 起（p. 55–59）`[L1 原书]`
- 类型：proposition
- 原文陈述（**逐字**）：「The other heterotic string theories can all be constructed from a single theory by **the twisting construction introduced in section 8.5**.」
  「最不扭曲」的理论对应对角模不变量 (11.3.1)，即所有费米子（`λ^A` 与 `ψ̃^μ`）在环面每条闭链上同时周期或反周期，
  对角投影 `exp[πi(F + F̃)] = 1`（(11.3.2)）；「This theory is consistent except for a tachyon」，即
  `λ^A_{−1/2}|0⟩_{NS,NS}`，`m² = −2/α'`，`exp(πiF) = exp(πiF̃) = −1`（(11.3.3)）。
  §11.3 末（p. 59，逐字）：「Gravitinos, in the sectors `(R±, NS+, NS+)`, are absent from the spectrum. So also are tachyons, which are in the `(NS−, NS−, NS+)` and `(NS−, NS+, NS−)` sectors. The twists leave an `SO(16) × SO(16)` gauge symmetry.」并列出无质量谱四行；
  「**This shows that a tachyon-free theory without supersymmetry is possible.**」
- 文献自称的严格程度：构造 + 列举
- 文献列出的依赖：Vol.1 **§8.5**（明写）、E56、E57
- 备注：与 E54 备注里的「Nine ten-dimensional theories based on the action (11.2.3) are known, though six have tachyons」
  （p. 50，逐字）对应：**9 个 = 2 个超对称 + 1 个 `SO(16)×SO(16)` + 6 个有快子。**

### E59 §11.4「一点点李代数」（工具节）
- 位置：§11.4，eq. **(11.4.1)**–**(11.4.21) 附近**（p. 59–66）`[L1 原书]`
- 类型：definition
- 原文陈述（**逐字公式**，抽取者只记与后文相关的）：`[T^a, T^b] = i f^{ab}{}_c T^c`（(11.4.1)）；
  Jacobi 恒等式（(11.4.2)）；`exp(iθ_a T^a)`（(11.4.3)）；紧群的正定内积 `(T^a, T^b) = d^{ab}`（(11.4.4)），
  其不变性 `([T,T'],T'') + (T',[T,T'']) = 0`（(11.4.5)）「equivalent to the statement that `f^{abc}` is completely antisymmetric」；
  `Tr(t_r^a t_r^b) = T_r d^{ab}`（(11.4.6)，定义指标 `T_r`）；`t_r^a t_r^b d_{ab} = Q_r`（(11.4.7)，*Casimir invariant*）；
  `Sp(k)` 的定义 (11.4.8)–(11.4.10)。后文用到的还有一般 Cartan–Weyl 形式 **(11.4.12)**、生成元归一化 **(11.4.14)**、
  `SO(n)` 的根 **(11.4.16)**、`E₈` 的根 **(11.4.21)**（这四个式号在 §11.5/§11.6 被引用，**已 L1 见到引用**，
  但抽取者未逐页读 p. 61–65 的正文，故其**内容**未核实）。
- 文献自称的严格程度（**逐字**）：「**Space forbids a complete treatment**; we focus on some basic ideas and some specific results that will be needed later.」
- 备注：脚注 1（p. 60，逐字）：「To be precise the Lie algebra determines only the local structure of the group. Many groups, differing only by discrete identifications, will have a common Lie algebra.」

### E60 流代数（仿射 Kac–Moody 代数）与 level 的量子化 ★★
- 位置：§11.5，eq. **(11.5.1)**–**(11.5.17)**（p. 66–68）`[L1 原书]`
- 类型：definition / proposition
- 原文陈述（**逐字公式**）：
  `(1,0)` 流的 OPE `j^a(z)j^b(0) ∼ k^{ab}/z² + i c^{ab}{}_c j^c(0)/z`（(11.5.1)）
  ——「Conformal invariance requires their OPE to be of the form … Dimensionally, the `z^{−2}` term must be a `c`-number and the `z^{−1}` term must be proportional to a current.」
  Laurent 系数 `j^a(z) = Σ_{m=−∞}^∞ j_m^a/z^{m+1}`（(11.5.2)）满足闭代数
  `[j_m^a, j_n^b] = m k^{ab}δ_{m,−n} + i c^{ab}{}_c j^c_{m+n}`（(11.5.3)）；
  `[j_0^a, j_0^b] = i c^{ab}{}_c j_0^c`（(11.5.4)），即 `m = 0` 模构成李代数 `g`，`c^{ab}{}_c = f^{ab}{}_c`（(11.5.5)）；
  `j_1^a j_1^b j_{−1}^c` 的 Jacobi 恒等式要求 `f^{bc}{}_d k^{ad} + f^{ba}{}_d k^{dc} = 0`（(11.5.6)），
  故对单李代数 `k^{ab} = k̂ d^{ab}`（(11.5.7)）；
  **「The algebra (11.5.3) is variously known as a *current algebra*, an *affine Lie algebra*, or an *(affine) Kac–Moody algebra*.」**
  流是 `(1,0)` 张量：`[L_m, j_n^a] = −n j^a_{m+n}`（(11.5.8)）；
  **中心扩张必须为正**：`k̂ d^{aa} = ⟨1|[j_1^a, j_{−1}^a]|1⟩ = ‖j_{−1}^a|1⟩‖²`（(11.5.9)，`a` 不求和）
  ——「The *central extension* or *Schwinger term* `k̂` **must always be positive in a unitary theory**. … Thus `k̂ = 0` only if the current vanishes identically.」
  **`k̂` 是量子化的**：对任意根 `α` 定义 `J³ = α·H/α²`、`J^± = E^{±α}`（(11.5.10)）满足 `SU(2)` 代数（(11.5.11)），
  且 `(α·H_0/α², E_0^α, E_0^{−α})`（(11.5.12a)）与 `((α·H_0 + k̂)/α², E_1^α, E_{−1}^{−α})`（(11.5.12b)，*pseudospin*）也满足；
  由 `2J³ ∈ Z` 得 `2k̂/α² ∈ Z`，取长根 `ψ` 最强，故**level**
  `k = 2k̂/ψ²`（(11.5.13)）「is then a nonnegative integer, and positive for a nontrivial current」；
  `U(1)` 流归一化 `j^a(z)j^b(0) ∼ δ^{ab}/z²`（(11.5.14)），
  **「From this OPE and holomorphicity it follows that each `U(1)` current algebra is isomorphic to a free boson CFT, `j^a = i∂H^a`（(11.5.15)）. We will often use this equivalence.」**
  杂化弦的流 `iλ^Aλ^B`（(11.5.16)）构成 `SO(n)` 代数，level `k = 1`（`n = 3` 例外，`k = 2`）；
  一般表示 `r` 的自由费米子构造 `(1/2)λ^Aλ^B t^a_{r,AB}`（(11.5.17)），level `k = T_r/ψ²`。
- 文献自称的严格程度（**逐字**）：「with a coefficient that **can be shown by a positivity argument** not to vanish」（(11.1.1) 处）；
  「**The reader can verify** that the two sets … also satisfy the `SU(2)` algebra」；
  「**It is easy to see** that…」
- 文献列出的依赖：E59（(11.4.6)、(11.4.12)、(11.4.14)、(11.4.16)）
- 备注：★★ **(11.5.15)「每个 `U(1)` 流代数同构于自由玻色子 CFT」是本卷与本项目已有的
  `sugawara-free-boson-c1` 方向最直接的接口**（本记录只记事实，是否建边由 curator 定）。
  注意 Polchinski 给这条的理由只有「From this OPE and holomorphicity it follows」——**没有证明**。

### E61 Sugawara 构造与 `c^{g,k}` ★★★
- 位置：§11.5「The Sugawara construction」，eq. **(11.5.18)**–**(11.5.37)**（p. 69–72）`[L1 原书]`
- 类型：definition / proposition
- 原文陈述（**逐字公式**）：
  `: jj :(z_1) := lim_{z_2→z_1} ( j^a(z_1)j^a(z_2) − k̂ dim(g)/z_{12}² )`（(11.5.18)，「with the sum on `a` implicit」）；
  经过 (11.5.19)、(11.5.20) 的全纯性论证得
  `T_B^s(z) = (1/((k + h(g))ψ²)) : jj :`（(11.5.21)，`h(g)` 是 dual Coxeter number）；
  `T_B^s(z)j^c(0) ∼ T_B(z)j^c(0)`（(11.5.22)）；
  `T_B^s(z_1)T_B^s(z_3) ∼ c^{g,k}/(2z_{13}⁴) + (2/z_{13}²)T_B^s(z_3) + (1/z_{13})∂T_B^s(z_3)`（(11.5.24)）
  **with `c^{g,k} = k dim(g)/(k + h(g))`（(11.5.25)）**；
  Laurent 系数 `L_0^s = (1/((k+h(g))ψ²))(j_0^a j_0^a + 2Σ_{n=1}^∞ j^a_{−n}j^a_n)`（(11.5.26a)）、
  `L_m^s = (1/((k+h(g))ψ²)) Σ_{n=−∞}^∞ j^a_{m−n}j^a_n`，`m ≠ 0`（(11.5.26b)），
  **「satisfy a Virasoro algebra with this central charge」**；
  「The vanishing of the normal ordering constant in `L_0^s` **can be deduced** by noting that holomorphicity requires `L_0^s` and also `j_n^a` for `n ≥ 0` to annihilate the state `|1⟩`.」
  `U(1)` 情形 `T_B^s = (1/2) : jj :`（(11.5.27)）「as one sees by writing the current in terms of a free boson, `j = i∂H`」；
  陪集分解 `T_B′ = T_B − T_B^s`（(11.5.28)），`T_B′(z_1)j^a(z_2) ∼ 0`（(11.5.29)），
  `T_B′T_B′` 是标准 `TT` OPE，中心荷 `c′ = c − c^{g,k}`（(11.5.30)、(11.5.31)）
  ——「**The internal theory thus separates into two decoupled CFTs.**」「For a unitary CFT `c′` must be nonnegative and so `c^{g,k} ≤ c`（(11.5.32)），and `T_B′` is trivial precisely if `c^{g,k} = c`（(11.5.33)）, in which case `T_B = T_B^s`.」
  单纯 laced 代数：`h(g) + 1 = dim(g)/rank(g)`，故
  `c^{g,k} = k dim(g) rank(g)/(dim(g) + (k−1)rank(g))`（(11.5.34)）；
  **`c^{g,1} = rank(g)`（(11.5.35)）**；`SU(2) = SO(3)`：`c^{g,k} = 3k/(2+k) = 1, 3/2, 9/5, 2, 15/7, … → 3`（(11.5.36)）；
  一般界 `rank(g) ≤ c^{g,k} ≤ dim(g)`（(11.5.37)）。
- 文献自称的严格程度（**逐字，多处对形式化很关键**）：
  - 「We first wish to **show** that up to normalization the OPE of `: jj :` with `j^a` is the same as that of `T_B` with `j^a`.
    **This takes a bit of effort**; the same calculation is organized in a different way in **exercise 11.7**.」
  - **★「The OPE of the product `: jj :` is not the same as the product of the OPEs, because the two currents in `: jj :` are closer to each other than they are to the third current; we must make a less direct argument using holomorphicity.」**
  - **★「We have used the `jj` OPE to determine the `: jj :: jj :` OPE. We could not do this directly, because the `jj` OPE is valid only for two operators close compared to all others, and in this case there are two additional currents in the vicinity. Naive application of the OPE would give the wrong normalization for `T^s` and `c^{g,k}`. The argument above uses the OPE only where it is valid, and then takes advantage of holomorphicity.」**
  - 「It **can be shown** by considering various `SU(2)` subgroups that for a simply-laced Lie algebra `Γ_r ⊂ Γ_g^*`」（§11.6，(11.6.7)）
  - 「The expectation values of primary fields are completely determined by symmetry. **We defer the details to chapter 15.**」
- 文献列出的依赖：E60；**exercise 11.7**（明写）
- 备注：★★★ **对形式化最有价值的一条。** 三点：
  1. **Polchinski 显式指出了「OPE 的收敛域」问题**（上面两段加粗的逐字），并说明朴素地嵌套使用 OPE 会给出**错误**的
     `c^{g,k}`。→ 这正是 v1 记录 **Q3**（「OPE 的收敛性在书中有没有论证？」）所担心的那件事，
     **本卷给出了它在实际计算里咬人的具体实例**。v1 Q3 建议的 `worldsheet.ope-convergence` 公理节点，
     现在有了一个**来自原书的、非形式化的正面理由**。
  2. **`c^{g,k} = k dim(g)/(k + h(g))`（(11.5.25)）与 `c^{g,1} = rank(g)`（(11.5.35)）是带式号的一手结果**，
     可直接进图。`U(1)` 情形（`dim = rank = 1`，`h = 0`）给 `c = 1`，与本项目已有的
     「自由玻色子 Sugawara `c = 1`」方向**数值一致**——但注意 Polchinski 的 (11.5.27) 是**由自由玻色子反推**的，
     不是独立证明。**只记事实，不建议边。**
  3. `L_0^s` 正规序常数为零的理由是「全纯性 + `|1⟩` 被湮灭」，**又是一条推理而非计算**。

### E62 流代数的主场与其权
- 位置：§11.5「Primary fields」，eq. **(11.5.38)**–**(11.5.46)**（p. 72–73）`[L1 原书]`
- 类型：definition / proposition
- 原文陈述（**逐字公式**）：反复作用降算符 `j_n^a`（`n > 0`）达到*highest weight / primary* 态，它被所有 `j_n^a`（`n > 0`）湮灭，
  「It is therefore also annihilated by the `L_n^s` for `n > 0`, eq. (11.5.26), **so is a highest weight state of the Virasoro algebra**」；
  `j_0^a|r, i⟩ = |r, j⟩ t^a_{r,ji}`（(11.5.38)）；
  `L_0^s|r,i⟩ = Q_r/((k+h(g))ψ²) |r,i⟩`（(11.5.39)）；
  **`h_r = Q_r/((k+h(g))ψ²) = Q_r/(2k̂ + Q_g)`（(11.5.40)）**；`SU(2)` level `k` 的自旋-`j` 主场 `h_j = j(j+1)/(k+2)`（(11.5.41)）；
  表示的截断：`⟨r,λ|[E_1^α, E_{−1}^{−α}]|r,λ⟩ = 2(α·λ + k̂)/α² ≥ 0`（(11.5.42)）⇒ `k̂ ≥ |α·λ|`（(11.5.43)）⇒
  `k ≥ 2|ψ·λ|/ψ² = 2|J³|`（(11.5.44)）
  ——「For `g = SU(2)` the statement is that the spin `j` of any primary state can be at most `k/2`. … For `g = SU(n)` at level `k`, only representations whose Young tableau has `k` or fewer columns can appear.」
  type I 的 Chan–Paton 抽象描述：`Ẋ^μ λ^a e^{ik·X}`（(11.5.45)）、
  `λ^a(y_1)λ^b(y_2) = [θ(y_1−y_2)d^{ab}{}_c + θ(y_2−y_1)d^{ba}{}_c]λ^c(y_2)`（(11.5.46)）
  ——「so the `λ^a` form a multiplicative algebra with structure constants `d^{ab}{}_c`. The antisymmetric part of `d^{ab}{}_c` is the structure constant of the gauge Lie algebra. **This is an abstract description of the Chan–Paton factor. The requirement that the `λ^a` algebra be associative has been shown to forbid the gauge group `E₈ × E₈`.**」
- 文献自称的严格程度（**逐字**）：「**It is also true that** at any given level, only a finite number of representations are possible for the primary states.」；
  「**has been shown to** forbid the gauge group `E₈ × E₈`」（被动语态，**不给引文**）
- 文献列出的依赖：E60、E61
- 备注：★ 「主场的权由代数、level、表示完全定出」(11.5.40) 是**流代数表示论的一条硬结果**，带式号，可进图。
  最后一句「结合律禁止 `E₈ × E₈` 作为开弦规范群」是一条**不给出处的断言**，若要用必须另找来源。

### E63 玻色构造与 Narain 格：偶自对偶洛伦兹格 ★
- 位置：§11.6，eq. **(11.6.1)**–**(11.6.10)**（p. 73–75）`[L1 原书]`
- 类型：proposition
- 原文陈述（**逐字公式**）：26 个左移 + 10 个右移玻色子；无量纲动量 `l_{L,R} = (α'/2)^{1/2}k_{L,R}`（(11.6.1)）；
  紧化动量 `(l_L^m, l_R^n)`，`d ≤ m ≤ 25`，`d ≤ n ≤ 9`（(11.6.2)）取值于格 `Γ`；
  「From the discussion of Narain compactification in **section 8.4**, we know that the requirements for a consistent CFT are
  **locality of the OPE plus modular invariance**.」
  定义 `l ∘ l′ = l_L·l_L′ − l_R·l_R′`（(11.6.3)），则
  **「the lattice must be an *even self-dual Lorentzian lattice of signature* `(26−d, 10−d)`」**：
  `l ∘ l ∈ 2Z` for all `l ∈ Γ`（(11.6.4a)）、`Γ = Γ^*`（(11.6.4b)）；
  `d = 10` 时 `∘` 全正号，`l_L^m` 构成 16 维偶自对偶**欧氏**格——
  **「Even self-dual Euclidean lattices exist only when the dimension is a multiple of 8, and for dimension 16 there are exactly two such lattices, `Γ_{16}` and `Γ_8 × Γ_8`.」**
  `Γ_{16}`：`(n_1,…,n_{16})` 或 `(n_1+1/2,…,n_{16}+1/2)`，`Σ_i n_i ∈ 2Z`（(11.6.5a,b)）；
  `Γ_8` 同理（(11.6.6a,b)）；
  左移零点能 `−1`，无质量态由 `∂X^μ, ∂X^m` 或 `e^{ik_L·X(z)}`（`l_L² = 2`）给出；
  「the points of length-squared two are just the `SO(32)` roots (11.4.16)」/「the `E₈` roots (11.4.21)」
  ⇒ **「Thus the two possible lattices give the same two gauge groups, `SO(32)` and `E₈ × E₈`, found earlier.」**
  格论结果：`Γ_r ⊂ Γ_g^*`（(11.6.7)）、权格 `Γ_w = Γ_g^*`（(11.6.8)）、`SO(2n)` 权格的四个子格 (11.6.9a–d)；
  模不变 CFT 可取 `Γ = Σ_r Γ_r × Γ̃_r`（(11.6.10)）。
- 文献自称的严格程度（**逐字**）：「**It is easy to see** that the earlier fermionic construction and the present bosonic one are equivalent under bosonization.」；
  「**It can be shown** by considering various `SU(2)` subgroups that … (11.6.7)」
- 文献列出的依赖：Vol.1 **§8.2**、**§8.4**（明写）；E59（(11.4.16)、(11.4.21)）
- 备注：★ 脚注 2（p. 75，逐字）：「To be precise it is still necessary to specify the spectrum, which amounts to specifying which primary fields appear. **Modular invariance generally restricts the possibilities greatly.**」
  脚注 3：「For the nonsimply-laced algebras `Sp(k)` and `SO(2k+1)`, these same relations hold between the weight lattice of one and the dual of the root lattice of the *other*.」
  → 「16 维偶自对偶欧氏格恰有两个」是一条**纯数学定理**（书中不证、不引），是杂化弦分类的支点。
    若要进图，来源应另找（Conway–Sloane / Serre *A Course in Arithmetic*）。

---

## 3. 未核实的公式号清单 / 访问日志

### 3.1 第 10 章：**没有未核实的式号**

本记录第 10 章的全部式号（(10.1.1)–(10.8.x)）都来自原书页图直读。
**唯一的两处不确定不是式号而是内容**：
1. (10.2.13) 上方的「`+(1/16)c = (1/16)D`」里的 `c` 是否带帽（`ĉ`）——见 §4 Q3；
2. E37（`Q_B² = 0 ⟺ c^m = 15`）**本身没有式号**，是 (10.5.23) 下方的一句正文；E39（无鬼定理）**同样没有式号**。
   → **curator 不得为这两条编造式号**，`loc` 只能写节 + 页 + 「(10.5.23) 下方」/「§10.5 末」。

### 3.2 第 11 章：只有一处「跳读区」

第 11 章正文 PDF **本轮已取得并逐页读了 pp. 45–55、59–60、66–75**。
**跳读区（未读页图）**：
- **pp. 56–58**（§11.3 中段，其它十维杂化弦的具体扭曲构造）；
- **pp. 61–65**（§11.4 中段，李代数的根系/Cartan–Weyl 部分）；
- **pp. 76–83**（§11.6 后半 + 习题）。

后果：E59 里列的 **(11.4.12)、(11.4.14)、(11.4.16)、(11.4.21)** 四个式号，抽取者是在
**§11.5/§11.6 的正文引用中**看到的（L1 见到引用），但**没读到这四式本身**，故其**内容未核实**。
E58（§11.3）只覆盖了 (11.3.1)–(11.3.3) 与 p.59 顶端的谱表，中间的构造未抽。
→ 若 curator 需要这几条，补读 pp. 56–58 与 pp. 61–65 即可，路线见 §3.3（同一份已落盘的 PDF）。

[H] 对第 11 章的独立佐证：Problem 11.1/11.3/11.4/11.7/11.8/11.9/11.12 的解答（L1 读 [H]）引用了
**(11.5.2)、(11.5.18)、(11.5.20)、(11.5.24)、(11.5.26)、(11.6.5)、(11.6.6)、(11.6.15)**，
其中前六个与本记录 E60/E61/E63 的一手读数**逐一吻合**（双源核实）。
⚠ 两处需注意：
1. [H] Problem 11.9 引用 **(11.6.15)**，本记录未读到该式（在 pp. 76–83 跳读区），[H] 说它是「找规范玻色子要满足的格矢条件」；
2. [H] Problem 11.3 的整个解答是一句「See the last paragraph of section 11.2.」——即该习题的答案就是原书正文。

### 3.3 访问日志（供后人省事）

**成功的路线（★ 新增，值得写进项目的通用手册）：**
- ★★ **Cambridge Core 章级 PDF：环境持有机构订阅，可直接取到 Polchinski Vol.1/Vol.2 的正文 PDF。**
  路径：`www.cambridge.org/core/books/string-theory/<BOOK_HASH>` → 该页列出每个 item 的 hash →
  `www.cambridge.org/core/books/abs/string-theory/<slug>/<ITEM_HASH>` → 页面上的 "Save PDF" 链接形如
  `www.cambridge.org/core/services/aop-cambridge-core/content/view/<ITEM_HASH>/<file>_CBO.pdf/<name>.pdf`。
  WebFetch 会抱怨二进制但**落盘并打印路径**，再用 `Read` 带 `pages` 读页图。
  已验证可取：Vol.2 的 frontmatter (pp. i–viii)、**contents (pp. ix–xii)**、**chapter 10 (pp. 1–44)**、**chapter 11 (pp. 45–83)**。
  Vol.2 的 BOOK_HASH = `2D456468D20AA8A9CE10CEB08B95B9DC`（Vol.1 = `30409AF2BDE27D53E275FDA395AB667A`）。
  **★ PDF 文件名可以直接推出来，省一次 fetch**：`9780511618123c1_p1-44_CBO.pdf` → 第 11 章就是
  `9780511618123c2_p45-83_CBO.pdf`（即 `c<第几章-9>_p<起页>-<止页>_CBO.pdf`，页码取自 [T]/[CC]）。本轮实测一次命中。
  各 item 的 ITEM_HASH（Vol.2，本轮已取，L1）：
  frontmatter `A8D08A85DB6844C8B9430754B2DE51FE`、contents `07FB90D821053D58A00610479EFE2978`、
  notation `BACF746050A6F8DC6AE8EF5FA4A6BA28`（pp. xviii–xx，**本轮未读，建议下轮补**）、
  ch.10 `E69C35DC077FD0BAD6B39479144D4A12`、ch.11 `C4D876C20A83F4E778152B75A219A718`、
  ch.12 `46D902501550C028C94F24884F4B9D7A`、附录 B `872CC69E98F684AFA1019EB2A955BD11`。
  **⚠ 这条路线让 v1 记录 §3 那张「未核实公式号清单」原则上可以全部清掉——建议 lead 派一轮专门做这件事。**
- Headrick arXiv:0812.4408：`arxiv.org/pdf/0812.4408` → 落盘 → `Read(pages=)`。第 10 章解答在手册 p. 83–87，第 11 章在 p. 88–93。

**失败的路线（勿再耗额度）：**
- `hepnotes.com`：**Schrans 没有 Vol.2 笔记**，首页明写只覆盖 Vol.1 前 8 章（已确认，见 §0.2）。
- `assets.cambridge.org/97805216/72283/frontmatter/9780521672283_frontmatter.pdf` → **Socket is closed**（与 v1 记录的 3/3 失败一致）。
  改用 Cambridge Core 路线即可，且 Core 版还多给一个独立的 contents PDF。
- `www.kitp.ucsb.edu/joep/links/joes-big-book-string/errata` → **HTTP 404**（带不带 `www.` 都 404）。
  检索后端仍能逐字转述其 Vol.1 条目（如「exercise 3.6 的 `−4a` 应为 `+4a`」「eq. 4.1.18 的因子 `2` 应为 `(2α')^{1/2}`」），
  说明它读到了缓存，但**本轮无法直接核对，等级 L4，不得入库**。
- `books.google.com/books?id=WKatSc5pjOgC&q=…` → 本书**无预览**（"No preview available" ×3 个版本），
  与 v1 对 Vol.1 的结论相同。**Google Books 对 Polchinski 两卷都不可用。**
- `archive.org/details/stringtheory0002jose` 条目**存在**（Vol.2，1998，558 页，`internetarchivebooks`/`inlibrary`/`printdisabled`，
  access-restricted）。但三条 search-inside 端点全部失败：
  `api.archivelab.org/books/<id>/searchinside` → Socket closed；
  `ia-petabox.archive.org/services/search/beta/page_production/scan.json` → Socket closed；
  `archive.org/services/search/beta/…` → 404；
  `ia801406.us.archive.org/fulltext/inside.php?item_id=…&path=/5/items/…` → **403**。
  （`archive.org/metadata/<id>` 本身可读，给出 server=`ia801406.us.archive.org`、dir=`/5/items/stringtheory0002jose`。）
- INSPIRE 全文检索**可用**且好用：`inspirehep.net/api/literature?q=ft%20%22<字串>%22&fields=titles,arxiv_eprints`。
  实测 `ft "10.5.26"` 只有 6 条命中且唯一相关的是 Headrick 手册；`ft "Polchinski" and ft "10.2.11"` 12 条，也无新料。
  → **结论：没有第三方论文按式号引用 Polchinski Vol.2 第 10 章。别指望这条路补锚点。**
- `dokumen.pub` 上有本书全文扫描；**本轮没有 fetch 它**（未授权扫描件，按 `literature/CLAUDE.md` 规则 1 不使用）。
  检索后端会转述其内容（例如给出 §10.1–10.8 的页码表），**这些转述本记录一律不采信**——
  幸好它给的页码表与 [T]（原书目录，L1）**完全一致**，说明后端读的确实是本书，但等级仍是 L4。

---

## 4. 未解决的疑问

**Q1 — 任务书的章节假设与原书不符（已在 §0.5 说明，此处只记结论与待办）。**
「§11 = 超弦谱与 GSO 投影」是错的；§11 是杂化弦。GSO/IIA/IIB/I 全在 §10.6。
→ 待办：`reading-list.md` 里 `polchinski-1998-v2` 的范围列「§10–§12（超弦、GSO、反常）」也不准确
（反常在 §12.2 "Anomalies"，p. 94；GSO 在 §10.6）。本轮已把该行状态改为 `extracted`，**范围改写为「§10–§11」并注明差异**。

**Q2 — Vol.1 §2.9 的内容比 v1 记录以为的多（v1 Q5 应更新）。**
v1 记录 Q5 的结论是「[S] 在 Vol.1 §2.9（p.68–73）只标注了 (2.9.3)、(2.9.14)、(2.9.15) 三处，
没有证据表明 §2.9 讲 Verma 模或 Kac 行列式」。
**本轮从 Vol.2 拿到两条新的一手证据（L1）：**
- (10.3.4) 上方逐字：「The analog of the Noether relation **(2.9.6)**」→ Vol.1 §2.9 至少有 (2.9.6)，且它是一条 Noether 关系；
- (10.2.13) 上方逐字：「we will use **the mnemonic from the end of section 2.9**」→ **Vol.1 §2.9 末尾有一个「零点能助记法」**
  （每个周期玻色子 `−1/24`、周期费米子 `+1/24`、反周期费米子 `−1/48`）。
→ 这两条都**不是** Verma 模/Kac 行列式，所以 v1 Q5 的主结论（§2.9 不讲 Kac 行列式）**没有被推翻，反而更可信**；
  但 v1 Q5 里「[S] 只标注了三处 = §2.9 只有三件事」这个隐含推断**被证伪了**。
  → 建议在 `polchinski-1998-v1.md` Q5 下追加这条订正。**本 researcher 只写 `literature/`，v1 文件的追加由 lead 决定是否派活。**
  ⚠ 顺带：既然 Cambridge Core 路线能取到 Vol.1 正文（§3.3），**v1 的 Q1–Q11 大部分可以一轮清掉**。

**Q3 — (10.2.13) 上方的 `c` 是否是 `ĉ`。**
正文印作「Including the shift `+(1/16)c = (1/16)D` gives」。若 `c` 就是 (10.1.14) 的 `c = (3/2)D`，则等式不成立。
抽取者判断是超共形文献常用的 `ĉ ≡ (2/3)c = D`，但**页图上帽子未能 100% 分辨**（PDF 渲染，字号小）。
影响面：**只影响这句话的转录，不影响 (10.2.13) 的两个结果值 `a^m(R) = D/16`、`a^m(NS) = 0`**（这两个是清楚的，且与 (10.4.5)、(10.5.4)、(10.5.5) 三处交叉自洽）。
→ 待办：任何人下次读到 p. 7 时确认一下；确认前 curator **不要**把这句话写进节点。

**Q4 — 超弦（与杂化弦）无鬼定理的「direct imitation / straightforward」到底掩盖了什么？★ 本项目最该追的一条。**
E39 逐字：「The proof is **a direct imitation of the bosonic argument of chapter 4**.」
E55 逐字（杂化弦，更弱）：「It is **straightforward** to construct the nilpotent BRST charge and show the no-ghost theorem…」
但超弦相对玻色弦至少多出三个结构：
(i) `βγ` 是**对易**鬼场，其 Fock 空间与 `bc` 不同，且有 `|1⟩ ≠ |0⟩_NS` 的不等价真空问题（E29，(10.4.6)–(10.4.7)）；
(ii) R 扇区有 `β_0`、`γ_0` 零模，(10.5.26) 是**额外强加**的条件（E38），书中只说「the logic being the same as for (10.5.25)」；
(iii) Vol.1 §4.4 的证明用的是「light-cone number 分次 + `S = {Q_1, R}` 是数算符 + 严格下三角」（v1 E68），
     其中 `S` 同时计鬼场激发与光锥振子激发；**超弦版的 `S` 必须还计 `β, γ` 与 `ψ^{0,1}`，而 `βγ` 的占据数无上界**
     （E30 里 Polchinski 自己指出「the modes of a commuting field can be excited any number of times」）。
**Polchinski 完全没有讨论这三点是否影响论证。** 全章无脚注、无引文。
→ 后果与建议：
- 图里若建 `worldsheet.no-ghost-theorem--superstring`，其唯一 derivation 是「Vol.1 §4.4 的照搬」，
  **应标 `inferred: true` 并在 note 里写明上述三个未讨论的差异**；`status` 不高于 `physical-argument`。
  杂化弦版（E55）更弱，连 `H^⊥` 的定义都没有。
- 数学/物理文献里这条**有独立的严格处理**。本轮检索到的候选（**均只到标题/摘要级，未抽取，不得直接入库**）：
  Ohta, "Covariant quantization of superstrings based on BRS invariance", Phys. Rev. D 33 (1986) 1681；
  Ohta, "BRST cohomology in superstring theories", Phys. Lett. B 179 (1986) 347；
  Henneaux, "BRST cohomology of the fermionic string", Phys. Lett. B 183 (1987) 59；
  Horowitz–Myers–Martin(?), "BRST cohomology of the superstring at arbitrary ghost number", Phys. Lett. B 218 (1989) 309；
  以及现代的 arXiv:1212.3592 "Superstring BRST no-ghost theorem at arbitrary picture number"、
  arXiv:1009.0107 "No-Ghost Theorem for Neveu–Schwarz String in 0-Picture"。
  → **建议 lead 把 `ohta-1986` / `henneaux-1987` 等加进 `reading-list.md`**，它们才是把这条抬到 `rigorous` 的目标。
- ⚠ 一条现代事实（**L4，来自检索后端综述，未核对原文，不得入库**）：picture number 会影响 BRST 上同调，
  零动量 R–R 态在不同 picture 下不等价，而非零动量态在所有 picture 下等价。若属实，
  **Polchinski 的无鬼定理陈述隐含了 picture 的选择**（他的 (10.4.22)/(10.4.25) 用的是 `−1` 与 `−1/2` picture），
  而书中根本不出现 "picture" 这个词。这条值得一查。

**Q5 — 「there is an analogous gauge-invariant form」（E33）书中不给。**
Polchinski 明说存在一个超 diff × 超 Weyl 不变的形式，但**不构造、不引用文献**。
→ 若图里需要「RNS 有规范不变起点」，只能标 `conjecture` 或 `physical-argument` 并注明「作者断言，本书不给」。
  正经出处应另找（GSW 第 4 章、或超几何/超 Riemann 面文献）。

**Q6 — `c^m = 15` 与 `D = 10` 该拆成几个节点？**
与 v1 Q6/Q8 完全平行。本卷的事实是：
- **`D = 10` 有两条独立推导**：E12（总中心荷为零，(10.1.20)，**有式号**）与 E37（`Q_B² = 0`，**无式号**）；
- E37 给的其实是更强的 `c^m = c̃^m = 15`，`D = 10` 只是平坦 `Xψ` SCFT 的特例；
- **本卷没有光锥规范那条路线**（玻色弦有三条，超弦只有两条）。
→ 建议：`worldsheet.critical-dimension-superstring`（`D = 10`）与 `worldsheet.matter-central-charge-15`（`c^m = 15`）拆开，
  后者是前者的更一般形式，前者挂两条 derivation。

**Q7 — 第 11 章的两个跳读区（已从「未取全文」降级为「局部未读」）。**
第 11 章正文已取得并读了 pp. 45–55、59–60、66–75（见 §3.2）。**剩下 pp. 56–58、pp. 61–65、pp. 76–83 三段未读页图。**
影响：E58（§11.3 的具体扭曲构造）不完整；E59 列的 (11.4.12)/(11.4.14)/(11.4.16)/(11.4.21) 内容未核实；
E63 提到的 (11.6.15) 未读到（只见 [H] 引用）。
→ 待办：同一份已落盘 PDF，补读三段即可，**无需再 fetch**。

**Q8 — 附录 B 未读，但第 10 章大量依赖它。**
E21、E23、E35、E43 都把技术内容推给 Appendix B（B.1 旋量、B.2 时空 SUSY、B.4 反对称张量场、B.5 IIA/IIB 超引力；pp. 430–466）。
明确引用的编号有 **(B.1.8)、(B.1.10)、(B.1.11)**。
→ 若图里要建「R 基态是 `32` 维 Dirac 表示」「`16 + 16′`」这类节点，其真实来源是附录 B，不是第 10 章。
  ITEM_HASH 已在 §3.3 记下，取一次即可。

**Q9 — 本记录的版本锚定问题。**
读到的是 CBO/2005 平装数字版（已含 2000 年 "with corrections"）。
`sources.bib` 的 `polchinski-1998-v2` 若按 1998 初印本登记，**式号应当相同但个别公式可能不同**。
→ 建议在 bib 里加一句 `note = {equation numbers verified against the Cambridge Books Online edition (© 2001, 2005), DOI 10.1017/CBO9780511618123}`。

**Q10 — Table 11.1 后四行的流数目（`n_1`/`n_{1/2}`/`n_0`）读图不确定。**
E51 里 Table 11.1 的**前三行**（`N = 0, 1, 2`，`c^g = −26, −15, −6`）抽取者确信，本记录也只用了这三行。
后四行（`N = 3` 一行、`N = 4` 三行）的 `c^g` 值（`0, 0, 0, 12`）与 symmetry 列（`SU(2)`、`SU(2)×SU(2)×U(1)`、
`SU(2)×SU(2)`、`SU(2)`）也确信，但**中间三列的整数在页图上分辨不足**。
抽取者读到 `N=3` 行疑似 `3, 7, 1, 0`，但按 (11.1.2a) 做自洽性检验：
`c^g = −26 + n_1·11·? …` —— 正确的组合方式是 `c^g = Σ_h n_h c_h`，其中 `c_2 = −26`（恒有一个）、`c_{3/2} = +11`、
`c_1 = −2`、`c_{1/2} = −1`、`c_0 = −2`。`N = 3` 行要给 `c^g = 0`，需 `−26 + 3×11 + n_1×(−2) + n_{1/2}×(−1) + n_0×(−2) = 0`，
即 `2n_1 + n_{1/2} + 2n_0 = 7`；`(n_1, n_{1/2}, n_0) = (3, 1, 0)` 满足，`(7, 1, 0)` 不满足。
**故该行极可能是 `3, 3, 1, 0`（即 `N=3, n_1=3, n_{1/2}=1, n_0=0`）。**
→ **这个检验是抽取者的推断，不是原书文字。** 后四行不进图；要用先补读 p. 47 的页图。

**Q11 — E51 的 `c_h` 通式与 v1 的 `bc`/`βγ` 中心荷是同一条还是两条？★ 有一条便宜的清账路径。**
(11.1.2a) `c_h = (−1)^{2h+1}[3(2h−1)² − 1]` 在 `h = 2` 给 `−26`、`h = 3/2` 给 `+11`。
而 v1 记录 E36 说 Vol.1 (2.5.12) 是 `c = −3(2λ−1)² + 1`（`bc`，一般 `λ`），E37 说 (2.5.24) 是 `βγ` 的反号版本。
两者一致：`h` 为整数时 `(−1)^{2h+1} = −1`，`c_h = −3(2h−1)² + 1` ✓；`h` 为半整数时 `(−1)^{2h+1} = +1`，符号翻转 ✓。
即 **(11.1.2a) 就是把 Vol.1 的两条统一成一条，并把符号规则显式归因于鬼场统计。**
但 v1 记录里 (2.5.12) 与 (2.5.24) 的**表达式本身仍标「未核实」**（只核实了式号，见 v1 §3 清单）。
→ 现在有两条路清掉那个未核实：
  (a) 用 Cambridge Core 取 Vol.1 §2.5 的页图（§3.3 路线，Vol.1 BOOK_HASH 已记）；
  (b) 直接引 Vol.2 **(11.1.2a)**（**已 L1 核实**）作为该公式的来源。
  **建议 curator 优先用 (b)**——同一本教材、同一套约定、带式号的一手读数，且比 Vol.1 的分立写法更一般。
