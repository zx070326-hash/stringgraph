# 抽取记录：bagger-witten-1983

- 文献：J. Bagger and E. Witten, *Matter couplings in `N = 2` supergravity*, Nucl. Phys. **B222** (1983) 1–10
- 抽取者：researcher agent
- 日期：2026-09-11
- 覆盖范围：**正文一字未获取**。本轮拿到的是：出版方元数据（L2）、逐字摘要（L2，分段）、以及**两条独立的、逐字引用其结果的现代文献**（L3）
- 目标 area：`swampland`（支撑 `ooguri-vafa-2006` E19 = Conjecture 3 在超多重态模空间那一支）

---

## 0. 核实方法与证据等级（必读）

### 0.1 ★ 结论先说：本篇是 **L2 + 两条独立 L3**，不是 L1

| 层次 | 拿到了什么 | 等级 |
|---|---|---|
| 书目元数据 | INSPIRE recid **13231**，DOI `10.1016/0550-3213(83)90605-3`，`Nucl.Phys.B` **222**, **1–10**, 1983，报告号 **`Print-83-0266 (PRINCETON)`** | **L2**（出版方/INSPIRE） |
| 摘要 | 逐字分段取到（见 E1） | **L2** |
| 结果内容 | **两条独立的现代文献逐字复述其结论，且给出数值公式** | **L3** |
| 正文、公式号、定理号、证明结构 | **一字未获取** | **L0** |

⇒ **图节点的 `loc` 只能写到「Nucl. Phys. B222 (1983) 1–10」这个粒度，绝不许写公式号或节号。**

### 0.2 证据等级（沿用 `vafa-2005.md` §0.2 的 L1–L4 定义）

- **L1** = 抽取者亲自读到原文页图。**本文件没有任何 L1 条目。**
- **L2** = 出版方/INSPIRE 权威元数据与逐字摘要。
- **L3** = 第三方**一手读到的**转述（本轮两条：arXiv:2501.01900v2 与 arXiv:2304.06073，抽取者亲自读了这两篇的 HTML）。
- **L4** = 检索后端复述，不入库。**本文件无 L4 条目。**

### 0.3 获取失败路径（逐条留痕，供后人省事）

| 路线 | URL / 手法 | 结果 |
|---|---|---|
| INSPIRE 全文 | `inspirehep.net/api/literature/13231?fields=...documents,urls` | **`documents` 与 `urls` 两字段皆 absent** ⇒ INSPIRE 无全文 |
| CDS（OAI-PMH） | 需先有 CDS recid | **`external_system_identifiers` 只有 `MSNET 708440` 与 `SPIRES-1041061`，无 `CDS`、无 `KEKSCAN`** ⇒ **CDS 与 KEK 两条路线在入口即排除**（不是「试了失败」，是「没有入口」） |
| OSTI | `osti.gov/api/v1/records?q="Matter couplings in N=2 supergravity"` | **7 条命中，全部主题相关（SLAC-PUB-3065 Ellis、Galicki 论文等）但**无本文** ⇒ 查询未被吞，**OSTI 确实不藏本文**（Princeton 预印本，非 DOE 报告） |
| 大学课程页扫描件（AGW 那条路线） | — | **本轮无法执行**：会话的 `WebSearch` 额度已在本任务开始前耗尽（200/200）。**这是本篇没能升到 L1 的唯一可补救原因** |
| Elsevier | `sciencedirect.com` | 按既有记录直接判死路，未尝试 |

⇒ **下一轮升级到 L1 的唯一现实路线：用 `WebSearch` 找 `.edu` 课程页扫描件**（AGW 1984 即以此法取得 62 页全文）。检索词建议：`Bagger Witten "Matter couplings in N=2 supergravity" pdf`、`"Nucl. Phys. B222" 1983 Bagger Witten scan`。**报告号 `Print-83-0266` 是 SPIRES 的占位号，不是真实报告号，不要拿它去查任何报告库。**

### 0.4 ★ 对 `ooguri-vafa-2006` E19 的核实结论（本轮最重要的产出）

`ooguri-vafa-2006` §3.1（第一个 `Example v)`，p.9）逐字：

> "though a quaternionic Kähler manifold in general can have curvatures of any sign [14], **it is known that those realized for hypermultiplet fields coupled to supergravity must have a negative scalar curvatures [15]**"
> （并补一句这是 "a direct consequence of the local `N = 2` supersymmetry"）

**本轮结论：OV 的这条归属（[15] = Bagger–Witten）经两条独立的现代文献 L3 证实，且其中一条给出了显式数值。** 见 E2、E3。
**但「负标量曲率」这句话在 Bagger–Witten 原文里的确切措辞与公式号仍是 L0。**

---

## 1. 约定

**本轮无法确定本文的任何约定**（正文未获取）。

由 E3 的 L3 转述可知，本文的曲率结果里出现 **`κ`（引力耦合）**，即 `R(g) = −8κ²(n² + 2n)`。⇒ **`κ` 的定义（`κ² = 8πG_N`？`κ² = 1/M_Pl²`？）本文未核实**，而这个定义**直接决定曲率的数值大小**。

⇒ **图里若要用这个数值，必须先建一条 `κ` 归一化约定卡，并标明其定义未从一手来源核实。**
⇒ **但「曲率符号为负」这一条与 `κ` 的归一化无关**（`κ² > 0` 恒成立），**所以符号结论是安全的，数值结论不安全。**

与 `graph/conventions/` 的对照：本文的陈述（曲率符号）**与度规号差、`α'` 均无关**，建议节点不声明这两条约定。

---

## 2. 陈述

编号 `E<n>`。转成节点时在节点 `notes` 写 `from: bagger-witten-1983#E<n>`。

### E1 摘要（**L2 逐字，分段转录**）

- 位置：**摘要**（INSPIRE recid 13231，来源标为 Elsevier，创建日期 1983-03-01）— **L2**
- 类型：（记录）
- 原文陈述 **[逐字，按取回时的分段拼接]**：
  > 本轮取回的摘要要点（逐字片段）：论文处理**任意数目的无质量自旋 `(0, 1/2)` 多重态与 `N = 2` 超引力的耦合**，说明该耦合自然联系到一个建立在 **"a quaternionic manifold"** 上的超对称非线性 σ 模型；并指出**某些在全局 `N = 2` 超对称理论中允许的自相互作用，在引入超引力之后被禁止，反之亦然**。
- 文献自称的严格程度：摘要用陈述式（"show"），无 conjecture 类措辞。
- 文献列出的依赖：摘要不给。
- 备注（**三点，全部对图有约束**）：
  1. ⚠ **摘要用的词是 "a quaternionic manifold"，不是 "quaternionic Kähler"。** 1983 年的术语与现代不完全一致；现代文献（E2、E3）一律写 "quaternionic Kähler (QK)"。**图节点若要写 "quaternionic Kähler"，必须 note 写明「本文摘要用的是 quaternionic manifold，术语现代化由抽取者做出，标 `inferred: true`」。**
  2. ⚠ **摘要里没有出现 "curvature"、"negative"、"scalar curvature" 任何一个词。** ⇒ **「负标量曲率」这条结论在摘要级是取不到的**，只能靠 E2/E3 的 L3 证据。
  3. ★ 摘要的第二句（「全局 `N = 2` 允许的自相互作用在超引力里被禁止，反之亦然」）**正是 OV 所说的「local `N = 2` supersymmetry 的直接后果」的原文级根据**，也正是 `ooguri-vafa-2006` §3.2 Example (b)（全局 `N = 2` rigid limit 下 Ricci 正定 ⇒ Conjecture 3 失效）与正面方向之间的**分界线**。**这一条比曲率数值更重要，因为它解释了「为什么解耦极限下反例不构成反驳」。**

---

### E2 ★★ 结果的现代逐字复述（一）：QK + **常负标量曲率**

- 位置：**Chang, Sezgin, Tanii, *Higher derivative couplings of hypermultiplets*, arXiv:2304.06073v1（2023-04-12），JHEP 06 (2023) 172, DOI `10.1007/JHEP06(2023)172`，§2.1**；该文把 Bagger–Witten 编为参考文献 **[10]** — **L3（抽取者亲自读到该文 HTML）**
- 类型：proposition
- 转述方原文 **[逐字]**：
  > "In 1983 Bagger and Witten [10] showed that arbitrary number of hypermultiplets coupled to `N=2` supergravity in 4D parametrise a quaternionic Kähler (QK) manifold with constant negative scalar curvature."
- 该文另外三处引 [10]：
  - **(2.3)** 的 vielbein `V^{αA}` 关系 —— 逐字「They satisfy the relations [10]」；
  - **(2.5)** 的可积性条件 —— 逐字「The integrability condition ... gives [10]」；
  - §3.2 逐字「in a fashion similar to that of Bagger and Witten [10]」。
- 文献（转述方）自称的严格程度：**"showed that"** —— 陈述为已确立的结果。
- 备注：★ **这条同时给出了「Bagger–Witten 原文里有哪些可定位的内容」的线索**：vielbein 关系、可积性条件、Riemann 张量与 `Sp(n)`/`Sp(1)` 曲率的关系。**下一轮拿到原文时，应优先在这几处附近找公式号。**

---

### E3 ★★ 结果的现代逐字复述（二）：曲率的**显式数值**

- 位置：**S. Vandoren, *The geometry of hypermultiplets*, arXiv:2501.01900v2（v2 日期 2025-04-13），Institute for Theoretical Physics, Utrecht；invited contribution to the book *Half a Century of Supergravity*, eds. A. Ceresole and G. Dall'Agata；§1 与 §2**；该文把 Bagger–Witten 编为参考文献 **[23]**（逐字："J. Bagger and E. Witten, *Matter Couplings in N=2 Supergravity*, Nucl. Phys. B 222 (1983) 1–10."）— **L3（抽取者亲自读到该文 HTML）**
- 类型：proposition
- 转述方原文 **[逐字，四处]**：
  > （§1 引言）"the scalars in the hypermultiplets had to parametrize a quaternion-Kähler (QK) manifold"
  >
  > （§2 开头）"scalar fields `ϕ^i` in hypermultiplets coupled to four-dimensional supergravity parametrize a … QK manifold"
  >
  > （§2，曲率符号）"**only QK manifolds with negative scalar curvature can be coupled to supergravity**"
  >   ⚠ 原文此处印作 "QK **manfifolds**"（排印错误），照抄。
  >
  > （§2，紧接 **该文的公式 (2)** 之前）"**Bagger and Witten computed its value to be**"
  >
  > **该文 (2)**：  `R(g) = −8κ²(n² + 2n)`
- 文献（转述方）自称的严格程度：**"computed its value to be"** —— 把这个数值明确归给 Bagger–Witten 本人。
- 备注（**四点**）：
  1. ⚠ **`(2)` 是 Vandoren 这篇综述自己的公式编号，不是 Bagger–Witten 的。** **图里绝不许写「Bagger–Witten eq. (2)」。**
  2. `n` = 超多重态数目（由上下文；Vandoren 该处未在被引句中定义，抽取者未逐字取到定义句）。⇒ **`n` 的确切含义标 L0。**
  3. `κ` 的归一化未核实（见 §1）。⇒ **数值 `−8κ²(n²+2n)` 只能作为「符号为负、且与 `n` 二次增长」的证据用，不能直接搬数字。**
  4. ★ **该文 §2 中「only QK manifolds with negative scalar curvature can be coupled to supergravity」这一句，与 §1 中出现的 "local supersymmetry" 一词是分开的两处**（抽取者专门核对：`(2)` 的紧邻上下文里**没有** "local supersymmetry" 或 "N=2 supersymmetry" 字样）。⇒ **OV 那句「a direct consequence of the local `N = 2` supersymmetry」在 Vandoren 这篇里没有逐字对应句**，见 Q2。

---

### E4 两条 L3 证据的独立性检查

- 类型：（方法论记录）
- 事实：
  - 作者集合不相交：Chang–Sezgin–Tanii（Texas A&M / 埼玉）vs Vandoren（Utrecht）。
  - 年份不同：2023 vs 2025。
  - 用途不同：前者是 6D 高阶导数耦合，后者是综述性章节。
  - **两者都不引 `ooguri-vafa-2006`，也不是从 OV 转抄的**（抽取者在两篇里都未见 OV 引用出现在相关段落）。
- 结论：**两条 L3 证据是独立的**，共同支持「Bagger–Witten 1983 里有『耦合到超引力的超多重态标量流形是 QK 且标量曲率为常负』这一结果」。
- ⚠ **但两者都只是转述。二者一致不能替代原文。** 按 `literature/CLAUDE.md` 规则 2，这仍是 L3。

---

### E5 由 `ooguri-vafa-2006` 逐字记录的同处第二条引用（**未登记**）

- 位置：`ooguri-vafa-2006` §3.1，第一个 `Example v)`，p.9（v1）— **L1（经本项目自己的 OV 抽取记录）**
- 事实：OV 同一句里的 **[14]** 是 **J. A. Wolf, J. Math. Mech. **14**, 1033 (1965)**，被引来支撑「一般的 quaternionic Kähler 流形曲率可以取任意符号」。
- 备注：**[14] 本轮未登记也未核实（L0）。** 若图里要给「一般 QK 流形曲率符号不定」建节点，须先登记 Wolf 1965。**注意 OV 的论证结构是「一般情况任意符号（[14]）+ 超引力情况必负（[15]）」，两条引用缺一不可。**

---

## 3. 未核实项清单

| 编号 | 项 | 影响 | 处理建议 |
|---|---|---|---|
| U1 | **正文全部**（公式号、定理号、证明结构） | `loc` 只能到篇级 | 走 `.edu` 课程页扫描件路线（§0.3） |
| U2 | **「负标量曲率」在原文里的确切措辞** | 决定图节点 statement 能写多强 | 同上 |
| U3 | **`R = −8κ²(n²+2n)` 是否真在原文里、编号是多少** | 数值不可搬运 | 同上 |
| U4 | **`κ` 的归一化定义** | 数值大小 | 同上；或改用无量纲陈述 |
| U5 | **终页 `10`** | bib 完整性 | **本轮已由 INSPIRE `publication_info` 核实：`page_start: 1`, `page_end: 10`（L2）** ⇒ **U5 关闭** |
| U6 | **Wolf, J. Math. Mech. 14 (1965) 1033**（OV 的 [14]） | 「一般 QK 曲率任意符号」这一支无来源 | 登记并核实 |
| U7 | **本文与 Bagger–Witten 的另一篇（`N=1` 的 "Matter couplings in N=1 supergravity", Nucl. Phys. B222 (1983) 1 ← 同卷同页！）是否混淆** | 严重 | **本轮已核对：INSPIRE recid 13231 的标题逐字是 "Matter couplings in `N=2` supergravity"，卷页 222/1–10，DOI `10.1016/0550-3213(83)90605-3`** ⇒ 无混淆。但**记下这个风险**：Bagger–Witten 另有 `N=1` 的著名工作，引用时必须带 `N=2` |

---

## 4. 未解决的疑问

### Q1 — ★ 「负标量曲率」到底是 Bagger–Witten 的**定理**，还是后人从其结果推出的**推论**？

E2 的措辞（"showed that ... QK manifold with constant negative scalar curvature"）和 E3 的措辞（"Bagger and Witten computed its value to be"）**都把它归给 BW 本人**。

但摘要（E1）**只说 quaternionic manifold，不提曲率**。两种可能：
- (a) 曲率符号在正文里，摘要没提（最可能）；
- (b) 曲率符号是从 BW 的可积性条件（E2 提到的该文 (2.5)）**由后人读出**的。

**本轮无法裁决。** ⇒ 图节点 `notes` 必须写「结论来自两条独立 L3 转述；原文措辞未核实；不排除是从原文的可积性条件推出的推论」。

### Q2 — OV 的「a direct consequence of the local `N = 2` supersymmetry」在哪里？

OV 用这句话来论证**该结论对扰动与非扰动量子修正仍成立**（这是 OV 让 Conjecture 3 在超多重态那一支变强的关键一步）。

- E1（摘要）的第二句（「全局允许的自相互作用在超引力里被禁止，反之亦然」）**是这句话的原文级根据**，但**不是这句话本身**。
- E3 核对结果：Vandoren 在 `(2)` 的紧邻上下文里**没有** "local supersymmetry" 字样（该词只出现在其 §1）。

⇒ **「这是局部 `N=2` 超对称的直接后果，因而对量子修正稳健」这条推理，目前只有 `ooguri-vafa-2006` 一处来源，且 OV 不给论证。** 图里若要用它把 Conjecture 3 的超多重态支升格，**这一步必须单独建节点并标 `physical-argument` + `inferred: true`**，**不得**挂到 `bagger-witten-1983` 名下。

### Q3 — 这条结果能否让 `ooguri-vafa-2006` Conjecture 3 的某一支到 `rigorous`？

**本轮判断：不能，且差得比预想的远。** 三道缺口：

1. **数学缺口**：BW 的结果是关于**超引力理论的标量流形**的，不是关于「一致量子引力理论的模空间在无穷远处」的。OV Conjecture 3 讲的是**模空间无穷远处**的标量曲率；BW 讲的是**整个超多重态流形**的（常）标量曲率。**两者的量词不同**（OV：无穷远处非正；BW：处处为常负）。**BW 更强，但只在 `N=2` 超引力这个子类里成立。**
2. **适用域缺口**：BW 只覆盖 **4d `N=2`、只覆盖超多重态**。OV Conjecture 3 是对**一切**一致量子引力理论的模空间。
3. **等级缺口**：BW 本身是**超引力的场论构造**（物理论证），不是一条数学定理的证明。即使拿到原文，`status` 上限也是 `physical-argument`，**不是** `rigorous`。

⇒ **修正 `ooguri-vafa-2006.md` §5.1 里「这是 swampland 区最有希望通向 `rigorous` 的物理支点」这句话的口径**：它是 swampland 区**最有希望通向 `physical-argument` 且论证链最短**的支点，**不是通向 `rigorous` 的**。真正可能到 `rigorous` 的只有 `borel-harish-chandra-1962` 那一支（见 `math-sources.md` §45）。

---

## 5. 给图的建议

> 以下是**建议**，不是改动。researcher 只写 `literature/`，下列节点由 curator 落地。

### 5.1 建议的节点

| 建议 id | kind | status | 内容 | loc | 抽取条目 |
|---|---|---|---|---|---|
| `sugra.hypermultiplet-moduli-quaternionic` | proposition | `physical-argument` | 任意数目超多重态与 4d `N=2` 超引力耦合 ⇒ 标量参数化 quaternionic（Kähler）流形 | `Nucl. Phys. B222 (1983) 1–10`（**篇级，无公式号**） | **E1、E2、E3** |
| `sugra.hypermultiplet-moduli-negative-scalar-curvature` | proposition | `physical-argument` | 该流形的标量曲率为**常负** | 同上（**篇级**） | **E2、E3** |
| `sugra.global-vs-local-n2-selfinteractions` | proposition | `physical-argument` | 全局 `N=2` 允许的某些自相互作用在超引力中被禁止，反之亦然 | 同上（**摘要级，L2**） | **E1** |

⚠ **三条的 `sources[].loc` 都只能写 `Nucl. Phys. B222 (1983) 1–10`**，并在 `notes` 写死「正文未获取；结论来自两条独立 L3 转述（arXiv:2304.06073 §2.1；arXiv:2501.01900v2 §2）」。
⚠ **`sugra.hypermultiplet-moduli-negative-scalar-curvature` 不得带数值 `−8κ²(n²+2n)`**（U3、U4）。若 curator 一定要记这个数，另建一条 `notes`-only 的记录，`sources` 指向 **Vandoren 2501.01900v2 (2)**，**不指向 BW**。

### 5.2 它在 swampland 子图里的位置（**双轨**）

```
〈成立方向〉
swampland.ov-conjecture-3-nonpositive-curvature        status: conjecture
  --via-hypermultiplet-supergravity-theorem   kind: conjecture-support   status: physical-argument
      depends_on: sugra.hypermultiplet-moduli-negative-scalar-curvature
      sources: ooguri-vafa-2006, loc "§3.1, 第一个 Example v), p.9（v1）"
               bagger-witten-1983, loc "Nucl. Phys. B222 (1983) 1–10"（篇级）
      summary: 耦合到超引力的超多重态模空间标量曲率必为负 ⇒ Conjecture 3 在这一支上成立
      gaps: ["Bagger–Witten 正文未获取，结论为 L3（本文件 §0.1）",
             "BW 覆盖的是 4d N=2 超多重态，不是一般量子引力模空间（Q3 缺口 2）",
             "BW 说「处处常负」，OV 说「无穷远处非正」，量词不同（Q3 缺口 1）",
             "「local N=2 超对称的直接后果 ⇒ 对量子修正稳健」只有 OV 一处来源且不给论证（Q2）"]

〈反例方向 —— 与本条互为镜像，且必须同时建〉
swampland.ov-conjectures-fail-without-dynamical-gravity
  --via-gauge-theory-examples ... Example (b)：全局 N=2 rigid limit ⇒ Ricci 正定
      ★ 本篇的 E1 摘要第二句正是这两支的分界线：
        「全局 N=2 允许的自相互作用在超引力里被禁止，反之亦然」
      ⇒ 建议在该 refutation 的 notes 里引 bagger-witten-1983 E1，
        以说明「解耦极限下曲率变号不是反常，是理论本身换了」。
```

**★ 这是本篇对图最有价值的贡献**：它把 `ooguri-vafa-2006` §3.1（正面）与 §3.2 Example (b)（反例）**从同一个物理事实两侧解释**，从而支持 `ooguri-vafa-2006.md` §5.2 那条记账红线（引力解耦反例不构成反驳）。

### 5.3 **不得**挂到 `bagger-witten-1983` 的东西（红线清单）

| 内容 | 为什么不行 | 正确处理 |
|---|---|---|
| 任何公式号、定理号、节号 | **正文一字未获取** | `loc` 只写篇级 |
| 数值 `R = −8κ²(n²+2n)` | 是 Vandoren 综述的转述与其自己的编号 `(2)` | 若要用，source 写 Vandoren 2501.01900v2 |
| 「quaternionic **Kähler**」这个术语出自本文 | **摘要用的是 "a quaternionic manifold"** | note 写明术语现代化是抽取者所为 |
| 「这是 local `N=2` 超对称的直接后果」 | 这是 **OV 的话**，不是 BW 的 | source 写 `ooguri-vafa-2006` |
| 「因此对扰动/非扰动量子修正稳健」 | 同上，且 OV 也不给论证 | 单独节点 + `inferred: true` |
| 把本条当作 Conjecture 3 的**证明** | 覆盖域与量词都不同（Q3） | 只能是 `conjecture-support` |
| `status: rigorous` | 这是超引力场论构造，不是数学定理 | 上限 `physical-argument`（Q3） |
| Bagger–Witten 的 `N=1` 工作 | 是另一篇 | 引用必须带 `N=2`（U7） |

### 5.4 建议同时更新的既有文件

- `literature/sources.bib`：`bagger-witten-1983` 的 `note` **补写**：终页 10 已 L2 核实；`Print-83-0266 (PRINCETON)` 是 SPIRES 占位号；无 CDS/KEKSCAN/OSTI 入口；两条 L3 证据的出处。**本轮已改。**
- `literature/reading-list.md`：状态由 `待分派` 改为 **`attempted, L2+L3（正文未获取）`**，并写明下一轮唯一路线是 `WebSearch` 找 `.edu` 扫描件。**本轮已改。**
- **建议新增 reading-list 条目**：**J. A. Wolf, J. Math. Mech. **14** (1965) 1033**（OV 的 [14]，「一般 QK 流形曲率可任意符号」）。**本轮已加。**
- **建议修正 `ooguri-vafa-2006.md` §5.1 的口径**（见 Q3）：把「最有希望通向 `rigorous`」改为「最有希望通向 `physical-argument` 且链条最短」。**researcher 不改他人抽取记录；此条留给 lead 裁决。**

---
