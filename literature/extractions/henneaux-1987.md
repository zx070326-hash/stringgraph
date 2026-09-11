# 抽取记录：henneaux-1987

- 文献：M. Henneaux, *BRST cohomology of the fermionic string*, Phys. Lett. **B183** (1987) 59（卷期页待 §0.3 核实）
- 抽取者：researcher agent
- 日期：2026-09-11
- 覆盖范围：**待本文件后续各节填写**（骨架先落盘，逐节追加）

> **本文件为骨架 + 逐节追加。** 各节内容见下。

## 0. 获取途径与证据等级（必读）

### 0.1 ★ 一句话结论

**正文未取得（L0）。本记录 = L2（Elsevier/INSPIRE 逐字摘要 + 元数据）+ 一条高质量 L1 二手来源（FOK 1989 全文，其 §4 有一小节标题就叫 "The Henneaux Representation"）。**

三个此前 L0 的问题，本轮能回答到什么程度：
- **范围**：摘要逐字限定 **「fermionic string (Ramond model)」**——本篇**只做 R 扇区**；NS 扇区靠前作 PLB 177 (1986) 35 的方法（其摘要说「The method can be applied to the closed and to the fermionic models」）。
- **β₀ 零模处理**：FOK 1989 p.116 逐字「like many other authors, notably Henneaux [12] – we treat γ₀ and β₀ as creation and annihilation operators (respectively) the Hilbert space is now (the completion of) the polynomial algebra in one variable C[γ₀]」——即 **β₀ 湮灭真空、γ₀ 生成**，用现代话说是 **R 扇区的 −½ picture 真空**（这一步换算是我的推断，见 §3）。
- **"infinite degeneracy … spurious" 的机制**：FOK p.118 逐字「This space, however, turns out to be trivial [12]. In fact, one can⁹ define an operator K such that {F₀, K} = 1.」——即 Henneaux 证明零模 supercharge `F₀` 的上同调平凡（收缩同伦），从而 γ₀ 幂次带来的无穷简并在上同调里消失。FOK 脚注 9：**「this is only possible for states whose center of mass momentum is different from zero」**。
- **定理陈述编号**：L0（PLB 快报，大概率无编号）。

**FOK 对 Henneaux 表示的一条批评（L1）**，图上引用时必须带：p.116「There is however a major drawback. Changing the hermiticity properties of γ₀ and β₀ changes the hermiticity properties of the BRST operator: it is no longer hermitian. This means that it is no longer guaranteed that the cohomology space inherits a well-defined (i.e. independent of the representative) inner product.」FOK 因此把无鬼定理先在 Henneaux 表示证（§6 R 扇区），再转到 Schrödinger 表示（p.128）。

### 0.2 证据等级约定（与 `brst-cohomology-sources.md` §0 一致）

| 等级 | 含义 |
|---|---|
| **L1** | 一手正文逐字读到（读图或可选文本） |
| **L2** | 出版方 / 权威书目库的原文字段（INSPIRE 转载的出版方摘要、期刊卷页、DOI、报告号） |
| **L3** | 二手文献对本文内容的转述（引用方原文一手读到） |
| **L4** | 检索后端中介的说法，非逐字，不得单独作为依据 |
| **L0** | 未能核实 |

### 0.3 文献标识

全部 L2，逐字取自 INSPIRE recid **246118**（本篇）与 **237921**（前作）、Semantic Scholar。

**本篇**
- 标题（INSPIRE `titles` 三条逐字）：`{BRST} Cohomology of the Fermionic String` / `BRST COHOMOLOGY OF THE FERMIONIC STRING`。
- 作者：`Henneaux, M.`（单作者）。
- 出版信息：`Phys.Lett.B` **183**, `page_start 59`, `page_end 64`, year 1987；`pubinfo_freetext` 逐字「Phys. Lett. B183 ( 1987) 59-64」。
- DOI：`10.1016/0370-2693(87)91417-1`。
- `report_numbers`：**absent**。`number_of_pages` **6**；`preprint_date` **1987**（只到年）。
- 外部标识：`MSNET 873041`、`ADS 1987PhLB..183...59H`、`SPIRES-1686461`。**无 CDS、无 KEKSCAN、无 OSTI**。
- `documents`/`urls`：absent。
- Semantic Scholar：`CLOSED`，paperId `7cb60372a7a961aae4c688789a18b567846214cf`，`MAG 1967622247`。
- 独立佐证（L1）：FOK 1989 参考文献 [12] 逐字「Henneaux, M.: Phys. Lett. 183B, 59 (1987)」；Dedushenko 2015 参考文献 [14] 逐字「M. Henneaux, "Brst Cohomology Of The Fermionic String," Phys. Lett. B 183, 59 (1987).」

**摘要（INSPIRE `abstracts`，分四段取回后拼接，逐字，L2）：**

> 「The BRST cohomology of the first-quantized fermionic string (Ramond model) is explicitly computed by using methods developed in a previous letter. The infinite degeneracy due to the commuting ghost zero mode is shown to be spurious by extending to the BRST context an argument originally due to Corrigan and Goddard.」

（取回的第三段渲染为 "BRSt context"，按上下文应为 "BRST"；已按原意抄录，此处存疑一字。）

**前作（"a previous letter"）**：INSPIRE recid **237921**，`Remarks on the Cohomology of the {BRS} Operator in String Theory`，Phys. Lett. B **177** (1986) 35–38，`ADS 1986PhLB..177...35H`，无报告号。摘要逐字（L2）：

> 「The cohomology of the open bosonic string BRS operator is computed in a physical fashion. The method can be applied to the closed and to the fermionic models.」

Dedushenko 2015 [7] 与 FOK 1989 均引前作（FOK 引作 [13] 的是 FOK 自己的 ITP-SB-88-35，不是 Henneaux 前作；Dedushenko [7] = PLB 177, 35）。

### 0.4 失败/成功路径逐条留痕

Henneaux 当时在 Université Libre de Bruxelles，ULB 机构库 **DI-fusion** 收录其论文且常带全文——这是本篇最有希望的路线，本轮**卡在服务器端**：

| # | 路线 | 具体 URL / 手法 | 结果 |
|---|---|---|---|
| 1 | INSPIRE 标题检索 | `q=t "BRST cohomology of the fermionic string" and a Henneaux` | ✅ 一条命中 246118 |
| 2 | INSPIRE 摘要 | `…/246118?fields=abstracts` | ✅ 第一次因长度被拒，改要求「分段 <120 字」后逐字取全 |
| 3 | DI-fusion（VuFind 前端） | `difusion.ulb.ac.be/vufind/Search/Results?lookfor=…` | ❌ **HTTP 500**（三次、三种查询词，均 500 ⇒ 服务器端故障，非反爬） |
| 4 | DI-fusion VuFind API | `difusion.ulb.ac.be/vufind/api/v1/search?lookfor=…` | ❌ 404 |
| 5 | **DSpace 后端** | `dipot.ulb.ac.be/dspace/simple-search?query="BRST cohomology of the fermionic string"` | ⚠ **页面逐字「Results 1-1 of 1.」——记录存在**，但 "Items hits:" 之后的条目表**没有交付给抓取器**（三次、含 `rpp=5`），拿不到 handle/bitstream URL |
| 6 | DSpace open-search | `dipot.ulb.ac.be/dspace/open-search/discover?query=…&format=atom` 与 `/open-search/?query=…` | ❌ 404（两种路径） |
| 7 | DSpace browse by author | `dipot.ulb.ac.be/dspace/browse?type=author&value=Henneaux%2C+Marc` | ❌ 404 |
| 8 | OpenAIRE API（间接找 DI-fusion 全文链接） | `api.openaire.eu/search/publications?title="BRST cohomology of the fermionic string"&format=json` | ❌ **HTTP 409** |
| 9 | Semantic Scholar | `DOI:10.1016/0370-2693(87)91417-1` | ✅ 响应，`CLOSED` |
| 10 | CDS OAI-PMH | — | 无入口（无 CDS id） |
| 11 | WebSearch | 1 次 | ❌ 额度耗尽 |

**★ 交给人类点击的 URL**：`https://dipot.ulb.ac.be/dspace/simple-search?query=%22BRST+cohomology+of+the+fermionic+string%22` —— 浏览器里应能看到那条唯一命中；若记录带 bitstream，即为出版方 PDF。同理可查前作 PLB 177。

### 0.5 本轮 L1 二手来源

见 `ohta-1986.md` §0.5 的表（五篇共用）。对本篇最要紧的是 **`figueroa-ofarrill-kimura-1989`**（全文 28 页），其 §4 "The Henneaux Representation" 小节与 p.118、p.119、p.121、p.132 五处引 Henneaux [12]。

## 1. 约定

**Henneaux 本文约定 L0。** FOK 在描述 Henneaux 表示时用自己的记号：`F₀` = R 扇区零模 supercharge（总的，含鬼），`{γ₀, β₀}` 满足 `[γ₀, β₀] = 1`（FOK (4.4)），Henneaux 表示下「β₀ and γ₀ are mutual adjoints」（FOK p.116；p.132 同）。Henneaux 原文记号不可知。

## 2. 陈述

### E1 R 扇区 BRST 上同调被显式算出
- 位置：L0；摘要（L2）。
- 类型：proposition
- 原文陈述（摘要逐字）：「The BRST cohomology of the first-quantized fermionic string (Ramond model) is explicitly computed by using methods developed in a previous letter.」
- 文献自称的严格程度："explicitly computed"；前作自称 "computed in a physical fashion"。
- 备注：**结果具体是什么（≅ 光锥态？在哪个鬼数？），摘要不说。** 任务书写的「超弦 BRST 上同调 = 光锥态」是对结果的合理预期，但**本轮没有任何 L1/L2/L3 来源逐字给出 Henneaux 的结论陈述**。FOK 引 [12] 的五处全是关于零模处理与 F₀ 上同调，**没有一处转述 Henneaux 的最终定理**。

### E2 交换鬼零模导致的无穷简并是 spurious
- 位置：L0；摘要（L2）。
- 类型：proposition
- 原文陈述（摘要逐字）：「The infinite degeneracy due to the commuting ghost zero mode is shown to be spurious by extending to the BRST context an argument originally due to Corrigan and Goddard.」
- L3（FOK 1989，L1 转述，四处）：
  - p.116：Henneaux 表示 = `γ₀` 生成、`β₀` 湮灭，Hilbert 空间 `C[γ₀]`（的完备化）；在此表示下可以考虑相对于**整个零模子代数 `R₀ = L₀ ⊕ F₀`** 的相对子复形（即可以施加 `β₀ω = 0`）。
  - p.118 逐字：「This space, however, turns out to be trivial [12]. In fact, one can⁹ define an operator K such that {F₀, K} = 1. Therefore the vertical cohomology is zero except in dimension zero where it is isomorphic to C^{F₀}.」脚注 9 逐字：「Strictly speaking, this is only possible for states whose center of mass momentum is different from zero. In the Ramond sector any such on-shell (L₀ invariant) states correspond to one of the degenerate vacua and hence it has manifestly zero ghost number」。
  - p.119 逐字：「Since the cohomology of F₀ is trivial, as proven in [12], so is the cohomology of F₀ + K.」
  - p.121 逐字：「the proof of (5.1) is similar to the proof of the isomorphisms of the relative BRST cohomology of the Ramond sector in the Henneaux and Schrödinger representations. In fact, part of the proof already appears in [12].」
- 文献自称的严格程度："is shown to be spurious"。
- 备注：Corrigan–Goddard 的原论证（NPB 68, 189 (1974)，LZ 1989 参考文献 [2]）是 R 弦旧协变量子化里处理 `F₀` 零模的方法；LZ 1989 **Theorem 2.7**（`{D_R, ε} = 1` 收缩同伦）是同一机制的数学版。

### E3（隐含假设）非零质心动量
- 位置：由 FOK 脚注 9 推出（L3 + inferred）。
- 类型：assumption
- 备注：`{F₀, K} = 1` 型收缩同伦在 `p = 0` 失效（LZ 1989 p.333 同样声明「For p = 0, the vanishing theorem does not hold」并单独算 Prop 5.5）。Henneaux 原文是否声明此假设，L0。

## 3. 证明结构与假设

**全部 L3/推断。**

1. 表示选择：`C[γ₀]`，`β₀|0⟩ = 0`。**picture 换算（我的推断）**：Dedushenko 2015 (5) 定义 A-picture 真空为 `β_r|A⟩ = 0 (r ≥ −A−½)`、`γ_r|A⟩ = 0 (r ≥ A+3/2)`，并明写「The vacuum in the R sector annihilated by all the positive-indexed modes and by β₀ corresponds to the picture A = −½. If we interchange the role of β₀ and γ₀ … we obtain an A = −3/2 picture.」⇒ **Henneaux 表示 = R 扇区 −½ picture**；FOK 的 Schrödinger 表示 `L²(R, dx)` 不对应任何 picture。
2. 相对复形：相对于 `L₀`、`b₀`、`F₀`、`β₀`（FOK (4.5) `C_∞(R, R₀; M) = {ω | F₀ω = b₀ω = β₀ω = 0}`，FOK 说这是 Henneaux 表示下才能做的）。
3. 零模 supercharge 的上同调平凡（E2），`p ≠ 0`。
4. 剩余部分套前作 PLB 177 的玻色弦方法（"physical fashion"，内容 L0）。
5. **FOK 指出的结构性缺陷**：此表示下 `Q` 非厄米，上同调上的内积不自动良定；FOK 用 Schrödinger 表示补救（p.128）。Henneaux 原文是否讨论内积/正定性：**L0**——摘要只说 "cohomology … computed"，**没有 "no-ghost" 字样**。

## 4. 未解决的疑问

- **Q1**：Henneaux 的最终结论逐字是什么（上同调 ≅ 光锥态？鬼数？绝对还是相对上同调？）。L0。
- **Q2**：是否证明了内积正定（no-ghost）还是只算了上同调的维数/结构？摘要不含 "no-ghost"。
- **Q3**：NS 扇区在哪里？前作 PLB 177 摘要说方法「can be applied to … the fermionic models」，但 NS 扇区的显式计算是否在 PLB 177、PLB 183 或都不在，L0。
- **Q4**：是否声明 `p ≠ 0`。
- **Q5**：Henneaux 与 Ohta/IMNU 是否互引。FOK 不引 Ohta/KO/IMNU；LZ 不引 Henneaux。**两个数学组各只看到一半物理文献**——这本身值得记。

## 5. 对图的建议

### 5.1 三篇一手来源分别能挂哪个节点

| 节点 | kato-ogawa-1983 | ohta-1986 | henneaux-1987 |
|---|---|---|---|
| `no-ghost-theorem-brst`（玻色弦） | ✅ 物理原始出处（L2 摘要 + L3 结构） | — | — |
| `critical-dimension-brst-v2`（Q²=0 ⟺ D=26,a=1） | ⟹ 半边（L2） | — | — |
| `no-ghost-theorem-superstring` | — | ⚠ 只 NS 扇区（IMNU Note added） | ⚠ 只 R 扇区，且摘要无 "no-ghost" |
| 超弦 `Q²=0 ⟺ D=10` | — | ⟹（L2）；iff 见 LZ 1989 Prop 1.7(ii) | — |
| R 扇区 β₀ 零模上同调平凡 | — | 代数分解有（LZ Prop 1.7(x)）、证明无 | ✅ 原始出处（L2 + FOK 三处 L3） |

### 5.2 `no-ghost-theorem-superstring` 能否离开 `physical-argument`

**能，但不是靠这三篇；靠本轮取得全文的两篇数学论文，且要按其假设重述节点。** 对 curator 记的三处差异，逐条给出处：

| curator 记的差异 | LZ 1989（L1） | FOK 1989（L1） |
|---|---|---|
| βγ 不等价真空 | p.304 逐字「Representations corresponding to distinct charges are inequivalent.」；(7) 明确选 `T_{1/2}`（κ=½）与 `T₀ ⊕ T₁`（κ=0）并给理由（p.306：唯一使 deg 有上界且承载非退化厄米形式的选择） | §4 p.115–116：两种表示（Schrödinger `L²(R,dx)` vs Henneaux `C[γ₀]`）都做；(5.1) 证明两者相对上同调作为无分次空间同构；p.128 无鬼定理两种表示都证 |
| R 扇区 β₀ 零模 | Definition 2.2：κ=0 相对复形 = `Ker b₀ ∩ Ker β₀ ∩ Ker K ∩ Ker D_R`；**Theorem 2.7**（p≠0 时 `(F, D_R)` 上同调为零）；Definition 2.11 的 `⟨u,v⟩_rel = √−1⟨u, v̂⟩` 处理 `⟨,⟩` 在 `Ker β₀` 上恒零的问题（Prop 2.5） | §4 (4.10)–(4.17)：双复形 + 谱序列，`{F₀,K}=1`（引 Henneaux）；(4.20)–(4.28) Schrödinger 表示下 `Q = c₀L₀ − 2b₀T − γ₀²b₀ + Q̂` |
| βγ 占据数无上界 | p.306 逐字「A space in which deg (or "energy") is bounded neither above nor below will give rise to various difficulties. Fortunately, for each sector κ = ½, 0, there is a unique such space in which deg is bounded above」；Prop 3.2 有限过滤 | p.112「C_∞ is finite dimensional」（固定 Verma 模、固定 `L₀` 本征值的相对子复形）；p.113 过滤有界 |

**可作 canonical 的编号陈述**：
- **LZ 1989 Theorem 2.20**（p.321）逐字：「There are unitary isomorphisms T ∩ P ≅ P/rad P ≅ H⁰_rel.」——超弦版 FGZ Thm 2.8 / LZ 1991 Thm 3.5(i)。前提链：`p ≠ 0`（Theorem 2.4 明写 "Suppose p ≠ 0"）、`D = 10`（p.308 "From now on, we will take D = 10"）、`p` 在未来光锥（Definition 1.3 Remark）、空间取 (8) `C(p,κ)`。**Corollary 2.15(ii)** 作者自命名 "(No-ghost Theorem) H⁰_rel(p,κ) is a positive definite space"。
- **FOK 1989 §6**：(6.14)=(6.15)（NS）、(6.19)=(6.20)（R，Henneaux 表示）+ p.128 一段（Schrödinger 表示）。**FOK 的自承缺口**：p.115「Brower and Friedman **claim** to have proven full reducibility of this representation, although they do not write down the explicit spectrum generating algebra」（R 扇区完全可约性是引用的断言）；p.106 超李代数上同调基本定理「We have never seen a published proof」只在附录 A 对所需特例补证；p.132「To show that the new inner product defined by (B.1) is indeed positive-definite is completely straightforward and is left as an exercise」。
- **两篇互不引用、独立完成**（LZ p.335 Note added in proof：「we received preprints from J. Figueroa-O'Farrill and T. Kimura, whose work appears to be similar to ours」）⇒ 两条独立 derivation。

**建议**：`no-ghost-theorem-superstring` 保持现陈述为 `physical-argument`（挂 Polchinski §10.5 + ohta-1986[NS] + ito-morozumi-nojiri-uehara-1986[R] + henneaux-1987[R 零模]），另建一条按 LZ Thm 2.20 措辞的 `-v2` 陈述挂 `rigorous`，两条 derivation（LZ 1989、FOK 1989），gaps 写 `p ≠ 0`、表示/picture 的选择、GSO 前（LZ §4 Prop 4.3 才是 GSO 后）。**picture 依赖**（reading-list P2 的问题）：Dedushenko 2015 p.3 逐字转述 Berkovits–Zwiebach 1998「the isomorphism of relative (and semirelative) cohomologies at different picture numbers for non-zero momentum was established (while the zero-momentum relative and semirelative cohomologies were shown to be picture-dependent …)」；Dedushenko 自己 (39) 给出任意 picture、`p ≠ 0`、两扇区的绝对上同调 ≅ 两份光锥谱（`physical-argument` 级，但自洽完整）。
