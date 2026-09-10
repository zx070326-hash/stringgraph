# 抽取记录：kato-ogawa-1983

- 文献：M. Kato and K. Ogawa, *Covariant quantization of string based on BRS invariance*, Nucl. Phys. **B212** (1983) 443–460
- 抽取者：researcher agent
- 日期：2026-09-11
- 覆盖范围：**待本文件后续各节填写**（骨架先落盘，逐节追加）

> **本文件为骨架 + 逐节追加。** 各节内容见下。既有元数据/摘要级核实见 `brst-cohomology-sources.md` §6 与 `primary-sources-round2.md` §6，本文件不重复，只在 §0.3 汇总。

## 0. 获取途径与证据等级（必读）

### 0.1 ★ 一句话结论

**正文仍未取得（L0）。本记录 = L2（出版方逐字摘要 + 元数据）+ 本轮新增的四条 L1 二手来源（L3）对「KO 证明结构」的三角定位。**
⇒ 本记录**不得**用于给图节点提供 KO 的公式号/定理号/页码；但 §2–§3 的 L3 内容可以支撑「KO 的无鬼证明是什么结构、是否有 ⟺、是否有 Ker/Im 形式」这三个此前 L0 的问题的**部分**回答。

本轮四条 L1 二手来源（全部逐页读图，见各自抽取记录）：
1. **Ito–Morozumi–Nojiri–Uehara 1986**（PTP 75, 934；`ito-morozumi-nojiri-uehara-1986.md`）—— KO 同一学派（京都/东北/广岛）对 NSR 弦做的**同型证明**，五处逐字写「similar to Ref. 1)」/「the same method in Ref. 1)」。**这是对 KO 证明结构最可靠的反推来源。**
2. **Lian–Zuckerman 1989**（CMP 125, 301；`lian-zuckerman-1989.md`）—— 数学侧，p.332 把 KO 的关键代数结构指认为 Dixon–Taylor 型 `Ker A = Im A` 结构，Lemma 5.3.1 证明末句「The reader can consult [11] for details」。
3. **Kohriki–Kunitomo–Murata 2010**（arXiv:1009.0107v4；见 `henneaux-1987.md` §0.5 登记）—— 京都 YITP，(2.1) 鬼零模二维表示「defined by [33]」（= KO）。
4. **Dedushenko 2015**（arXiv:1212.3592v2；同上）—— p.2 逐字「BRST quantization of the bosonic string theory was introduced in [1]」。

**本轮对既有记忆的一条订正**：`sources.bib` 里「检索后端 L4 质疑 KUNS 637 归属、认为 Kato 当时在东京」——**已由两条 L2 元数据否定**：INSPIRE `raw_affiliation` 逐字「Department of Physics, Kyoto University, Kyoto 606, Japan」（两位作者同），INIS 同样记「Kyoto Univ. (Japan). Dept. of Physics」。KUNS = 京都大学物理系预印本系列，与作者单位吻合；L4 异议可以关闭。

### 0.2 证据等级约定（与 `brst-cohomology-sources.md` §0 一致）

| 等级 | 含义 |
|---|---|
| **L1** | 一手正文逐字读到（读图或可选文本） |
| **L2** | 出版方 / 权威书目库的原文字段（INSPIRE 转载的出版方摘要、期刊卷页、DOI、报告号） |
| **L3** | 二手文献对本文内容的转述（引用方原文一手读到） |
| **L4** | 检索后端中介的说法，非逐字，不得单独作为依据 |
| **L0** | 未能核实 |

### 0.3 文献标识

全部 L2，逐字取自 INSPIRE recid **177600**（`fields=titles,authors.full_name,publication_info,dois,report_numbers,external_system_identifiers,documents,urls,number_of_pages,preprint_date,imprints`）与 INIS。

- 标题（INSPIRE `titles[0]` 逐字）：`Covariant Quantization of String Based on BRS Invariance`
- 作者与单位（INSPIRE 逐字）：`Kato, Mitsuhiro` / `Ogawa, Kaku`，两人 `raw affiliation` 均为 **`Department of Physics, Kyoto University, Kyoto 606, Japan`**。
- 出版信息：`Nucl.Phys.B` **212**, `page_start 443`, `page_end 460`, year 1983；INIS 补充 **issue 3**、出版日期 **1983-02-28**（INIS TRN `NL83F2063`）。
- DOI：`10.1016/0550-3213(83)90680-6`。
- 报告号（INSPIRE `report_numbers` 逐字）：**`KUNS 637`**。`preprint_date` = **`1982-04`**；`number_of_pages` = **18**。
- 外部标识：`KEKSCAN 2000-33-955`、`SPIRES-912123`。**无 CDS 项**。
- INSPIRE `documents` / `urls`：**均 absent**（无全文）。
- INIS：`files.enabled: false`、`access.status: "metadata-only"`。
- Semantic Scholar（`DOI:` 查询）：`isOpenAccess: false`、`openAccessPdf.status: "CLOSED"`、url 空；paperId `e03270344a31f2c580e198bb2ad50fb15b12f159`。
- 摘要：已逐字登记于 `sources.bib` note 与 `primary-sources-round2.md` §6，本文件不重抄。

### 0.4 失败/成功路径逐条留痕

**本轮的硬约束：会话开始时 `WebSearch` 额度已耗尽（`200 of 200`），三次检索均被拒绝**（KO / Ohta / Henneaux 各一次）。因此本轮**没有做任何新的「大学课程页扫描件」检索**——这条 AGW 那次成功的首选路线对本篇**并未穷尽**，下次有额度时应先补。

| # | 路线 | 具体 URL / 手法 | 结果 |
|---|---|---|---|
| 1 | INSPIRE 元数据 | `inspirehep.net/api/literature/177600?fields=…` | ✅ 取得 §0.3 全部字段；`documents`/`urls` absent |
| 2 | INIS | `inis.iaea.org/api/records?q="Covariant quantization of string based on BRS invariance"` | ✅ 一条记录（NL83F2063），**metadata-only** |
| 3 | Semantic Scholar | `api.semanticscholar.org/graph/v1/paper/DOI:10.1016/0550-3213(83)90680-6?fields=…` | ✅ 响应，但 `CLOSED`、无 PDF 路径线索 |
| 4 | KEK 扫描件 | `lib-extopc.kek.jp/preprints/PDF/…`（本篇 id `2000-33-955` 对应路径未试；同主机用 Ohta 的 `85-12-165` 拼出 `/1985/8512/8512165.pdf` 探测） | ❌ **`socket hang up`（本项目第四次）** ⇒ 主机层面死路的判断维持，本篇不再单独试 |
| 5 | 京都大学 KURENAI | `repository.kulib.kyoto-u.ac.jp/dspace/simple-search?query=Kato+Ogawa+BRS+invariance+string` | ❌ 页面只回标题栏，无结果列表（是空结果还是渲染失败无法分辨） |
| 6 | CDS OAI-PMH | — | **无入口**：INSPIRE 无 CDS id（与 GS 1985 同型，不是「试了不行」） |
| 7 | WebSearch（课程页扫描件 / KUNS 637 扫描） | 3 次 | ❌ **额度耗尽，未执行** |
| 8 | ScienceDirect | — | 未试（既有记录 403，且按 `literature/CLAUDE.md` 规则不走未授权镜像） |

**替代成功路径（间接）**：OUP 的 PTP 旧刊 PDF 可取（`academic.oup.com/ptp/article-lookup/doi/10.1143/PTP.75.934` → `article-pdf/75/4/934/5260521/75-4-934.pdf` → 302 到 `watermark02.silverchair.com/…` → 落盘 804 KB）。**页面标 "Subscribers Only" 但实际可下载**——这条路线对整个 PTP/PTP Suppl. 旧刊（1946–2012）都值得复用。由此取得 IMNU 1986 全文，成为本记录 §2–§3 的主要 L3 来源。

## 1. 约定

**KO 本文的约定 L0（正文未读）。** 以下是同学派同型论文 IMNU 1986 的约定（L1），**只作为「KO 大概率同型」的参考，不得写成 KO 的约定**：

- 号差：IMNU (2.1) 下方逐字 `η_{μν} = diag(−1, 1, ⋯, 1)`，与 `conv` canonical 一致。
- 鬼零模：`η₀`（= c₀ 型）、`η̄₀`（= b₀ 型），`{η₀, η̄₀} = 1`（IMNU (2.20)）；真空二重简并 `|−⟩, |+⟩ ≡ η₀|−⟩`，`η̄₀|−⟩ = 0`（IMNU (3.12)，并注明「As discussed in Ref. 1)」即 KO）。
- 截距参数记作 `α₀`，作为正规序未定常数进入 `L`（IMNU (3.3)/(3.5) 末项 `−α₀/√π`），由 `Q_B² = 0` 定值——这与 KO 摘要「zero-intercept α₀ of leading trajectory」的记号一致。
- 度规算子：IMNU (3.16)–(3.18) 用 `G^NS = η₀` 定义内积使态有「usual norm」——KO 是否同样引入度规算子，L0。

## 2. 陈述

编号 `E<n>`。**证据等级逐条标注；凡 L3 的，引用方与其页码都给出。**

### E1 幂零 ⟹ 临界维数与截距
- 位置：KO 正文位置 L0；摘要（L2）。
- 类型：proposition
- 原文陈述（摘要逐字，L2）：「the conditions D = 26 and α₀ = 1 for the space-time dimension D and the zero-intercept α₀ of leading trajectory are **required by** the nilpotency Q_B² = 0 of the BRS charge」。
- L3 佐证（三条独立）：
  - IMNU 1986 §1 p.934 逐字：「They showed that a condition of nilpotency of the BRS charge determines the values of the critical dimension and the leading zero-intercept α₀ **simultaneously**.」
  - LZ 1989 §0 p.301 逐字：「It was first applied to the Virasoro algebra of the bosonic string by Kato and Ogawa [11].」（不提方向）
  - Dedushenko 2015 §1 p.2 逐字：「BRST quantization of the bosonic string theory was introduced in [1], where it was shown that the string at the critical dimension (or when the total central charge vanishes) admits a BRST charge Q_B satisfying Q_B² = 0.」——注意 Dedushenko 转述的是**反方向**（临界维 ⟹ 幂零）。
- 文献自称的严格程度：摘要用 "are required by"；IMNU 转述用 "showed"。
- **方向**：摘要只给 ⟹。**⟺ 在 KO 是否成立仍 L0。** 旁证：IMNU 对 NSR 弦给出显式公式 (3.8)–(3.9)，`(Q_B^NS)² = (1/π)Σ[(D−10)/8 · n³ + (16α₀^NS − D + 2)/8 · n] η_n†η_n + …`，从中 ⟺ 一眼可见；若 KO 对玻色弦给出同型显式公式（**推测，未核实**），则 ⟺ 在 KO 正文里也是"可见"的，只是摘要没写。
- 备注：`worldsheet.critical-dimension-brst-v2` 若写「当且仅当」，KO 目前只能支撑 ⟹ 半边。

### E2 物理态条件（修改版 Kugo–Ojima 附加条件）
- 位置：L0；摘要（L2）。
- 类型：definition
- 原文陈述（摘要逐字，L2）：「Defining a physical state by a modified form of Kugo-Ojima's subsidiary condition Q_B|phys⟩ = 0 (Q_B = BRS charge)」。
- L3 对「modified form」的解释：
  - IMNU 1986 (3.12)–(3.13)、(3.26) 与紧随其后的句子：物理态条件是在把 Fock 空间**限制到鬼零模真空 `|−⟩` 分量**（`η̄₀|−⟩ = 0`，即 `b₀|phys⟩ = 0`）之后，再施加 `Q_B|phys⟩ = 0`，并明写「These conditions are deduced from the usual physical state condition,²⁰⁾ Q_B|phys⟩ = 0, when we restrict the Fock spaces as (3.26)」；(3.12) 处「As discussed in Ref. 1)」把这套零模处理归给 KO。
  - KKM 2010 (2.1a,b)：鬼零模的二维表示 `b₀|↓⟩ = 0, b₀|↑⟩ = |↓⟩, c₀|↓⟩ = |↑⟩, c₀|↑⟩ = 0`，上标 33 = KO，逐字「we take a two-dimensional representation (|↓⟩, |↑⟩) defined by³³⁾」。
- 文献自称的严格程度：definition。
- 备注：**用现代语言，这就是相对于 b₀ 的相对复形**（`Ker b₀` 上的 `Q_B` 上同调）。KO 是否用「上同调/相对复形」这类词，L0；LZ 1989 §0 把「基于消灭定理的 BRST 上同调群与物理态空间的幺正等价」明确归给 **FGZ** 而非 KO（p.301 逐字「Based on a vanishing theorem, unitary equivalence between the BRST cohomology groups and the physical spaces known to physicists was proven by Frenkel, Garland and Zuckerman (FGZ) [5, 17].」）。

### E3 无鬼定理（BRST 版）
- 位置：L0；摘要（L2）。
- 类型：proposition
- 原文陈述（摘要逐字，L2）：「we prove a no-ghost theorem in a simple manner」。
- L3 对内容与结构的转述：
  - KKM 2010 §1 p.2–3 逐字：「They proved that the physical Hilbert space is isomorphic to the conventional one spanned by DDF states³⁴⁾ and, hence, has a positive semidefinite norm. This norm of string states is, however, a little nontrivial owing to the ghost zero-modes.」
  - IMNU 1986 §4 p.945 逐字：「The procedure is similar to that in Ref. 1) in the bosonic string case.」；p.950 逐字：「Now we can prove Proposition II by the same method in Ref. 1).」；(4.9) 处「We introduce a parameter β to rescale the variables,¹⁾」。
  - LZ 1989 p.332 逐字：「A similar structure ((18) to (23)) was first realized by Dixon and Taylor [21] in their study of gauge theories. Kato and Ogawa [11] then apply it in a different context. It turns out that such a structure allows one to define a projection map from the cocycles of D₁* to those of C*_rel.」其中 (20)–(23) 逐字：`A² = C² = 0, B² = CA`；`{B,A} = {B,C} = {A,C} = 0`；`A, B, C commute with β₀, γ₀`；**`Ker A = Im A`**。Lemma 5.3.1 (Dixon–Taylor) 证明末句逐字「The reader can consult [11] for details.」
- 文献自称的严格程度：「we prove」（摘要）。
- 备注：三条 L3 互相一致，且 IMNU 是同学派的同型证明，可信度最高。**证明结构的反推见 §3。**

### E4 鬼数分数化
- 位置：L0；摘要（L2）逐字：「In addition, ghost number fractionization is observed in this system.」
- 类型：proposition（观察）
- 备注：与 §1 的鬼零模二重真空 `|±⟩` 直接相关（鬼数 ±1/2）。Dedushenko 2015 p.2 逐字「The space of physical states is identified as the cohomology of this complex at the ghost number −½」——这是对 KO 分数鬼数约定的现代转述。

### E5（否定性）KO 不是「BRST 上同调 ≅ 旧协变物理态」的上同调语言原始出处
- 类型：元陈述（供 curator 定 source）
- 证据（L3，两条独立）：LZ 1989 §0（见 E2 备注）把幺正等价归 FGZ；Dedushenko 2015 §1 p.2「Another classical treatment is presented in [6] (where a vanishing theorem for the relative BRST cohomology is proven …)」，[6] = FGZ。
- 但**内容上** KO 的 Prop II 型结论（见 §3 第 5 步）「任意 Q̃-闭态 = 横向态 + Q̃-恰当态」在数学上**就是** `Ker Q̃ = 横向 ⊕ Im Q̃`，即相对上同调 ≅ 横向空间——只是不用上同调词汇。**这是我的推断（基于 IMNU 同型证明的 (4.19)），标 inferred。**

## 3. 证明结构

**KO 正文 L0。以下是从 IMNU 1986（同学派、五处自称「same method in Ref. 1)」）反推的 KO 无鬼证明骨架。每一步给 IMNU 的式号作锚；「KO 同型」是推断。**

1. **鬼零模分离**：`Q_B = c₀ L + b₀ M + Q̃_B`（IMNU (3.2) `Q_B^NS = η₀L^NS + η̄₀M^NS + √(κ/π) Q̃_B^NS`；KKM (2.6a) 同型）。物理态限制到 `b₀|phys⟩ = 0` 分量后，条件化为 `L|phys⟩ = 0` 与 `Q̃_B|phys⟩ = 0`（IMNU (3.22)–(3.23)）。
2. **光锥参考系**：取 `p^i = 0 (i = 1..D−2)`、`p⁺` 固定非零，引入零矢 `k` 使 `k·p = 1`（IMNU (4.3)–(4.5)）。**⇒ 隐含假设 `p⁺ ≠ 0`，零动量扇区被排除**（Dedushenko 2015 p.2 对此类证明明说 "requires d ≥ 2 spacetime" 且 "the zero-momentum case requires a separate discussion"）。
3. **用与 `L` 对易的重定义模 `A_n, B_n, C_n, …`（含相因子 `e^{i(πn/κ)k·x₀}`）张成满足 `L|φ⟩=0` 的子空间 `V_L`**（IMNU (4.6)）。
4. **形式参数 β 的重标度**：`κ → κ/β², p₀⁻ → β² p₀⁻, x₀⁺ → x₀⁺/β²`（IMNU (4.9)，注明「¹⁾」即 KO），使 `Q̃_B(β) = Q_I + β Q_II + β² Q_III`（IMNU (4.10)），其中 `Q_I = (1/√π) p₀⁺ Σ√n (A⁺_n† C_n + C_n† A⁺_n) + …`（IMNU (4.11)）「has the same quadratic form as the asymptotic form of BRS charges in ordinary gauge theories」。**这就是 LZ 1989 (18)–(23) 说的 Dixon–Taylor/KO 结构：`A² = 0`、`Ker A = Im A`。**
5. **Proposition I（quartet 机制）**：`Q_I|φ⟩ = 0 ⇒ |φ⟩ = P^(0)|φ⟩ + Q_I|ρ⟩`，`P^(0)` 是到横向模 `A^i_n†, B^i_n†` 生成子空间的投影（IMNU (4.17)–(4.18)）；证明用 Kugo–Ojima 的 quartet 投影算子递推 `P^(n) = {Q_I, R^(n)}`（IMNU (A.3)–(A.6)，逐字「we can follow the usual procedure developed by Kugo and Ojima²⁰⁾」）。
6. **Proposition II（按 β 阶归纳）**：`Q̃_B(β)|φ(β)⟩ = 0 ⇒ |φ(β)⟩ = P(β)|φ(β)⟩ + Q̃_B(β)|J(β)⟩`，`P(β)` 是由**横向算子 `Ã^i_n†(β), B̃^i_n†(β)`**（DDF 型，IMNU (A.7)，引 Brower–Friedman [21]）生成的横向扇区投影（IMNU (4.19)–(4.20)）；(A.10) `[Q̃_B(β), Ã] = 0`；归纳步骤 (A.13)–(A.19)，逐字「Now we can prove Proposition II by the same method in Ref. 1).」
7. **正半定**：置 `β = 1`，`⟨φ|φ⟩ = ⟨φ|P|φ⟩ ≥ 0`（IMNU (4.21)），末句「where the last inequality follows from the positive definiteness of the transverse state space.²¹⁾」

**由此推断 KO 的自称严格程度**：物理学家式构造证明——**形式参数展开**（`|φ(β)⟩ = Σ βⁿ|φ_n⟩`，IMNU (4.16) 明写「we have assumed that |φ(β)⟩ can be expanded in β」）+ Kugo–Ojima quartet + DDF 算子对易性。**没有**谱序列/消灭定理语言；**没有**对 Verma 模自由性/Kac 行列式的引用。

## 4. 未解决的疑问

- **Q1（方向）**：KO 正文是否显式写出 `Q_B²` 的系数公式（IMNU (3.8) 的玻色弦版），从而 ⟺ 可读出？L0。
- **Q2（Ker/Im 形式）**：KO 是否有一条陈述等价于「`Ker Q̃ / Im Q̃ ≅` 横向（DDF）空间」？按 §3 第 6 步推断**内容上有**（Prop II 型），**词汇上无**（LZ、Dedushenko 都把上同调语言归 FGZ）。需正文。
- **Q3（D ≤ 25 / a < 1 分支）**：KO 只处理 D = 26、α₀ = 1（由 E1 锁定）；`(D ≤ 25, a ≤ 1)` 分支**不在 KO**（与 `lit_brst-noghost-source-numbering` 记忆一致：该分支的一手编号出处是 LZ 1991 Thm 3.5(ii)）。
- **Q4（零动量）**：§3 第 2 步的光锥参考系要求 `p⁺ ≠ 0`。KO 是否讨论 `p = 0`？L0。IMNU 也未讨论。
- **Q5（KUNS vs RIFP）**：**本轮关闭**——两条 L2（INSPIRE raw_affiliation、INIS 单位字段）均为京都大学物理系，KUNS 归属成立。
- **Q6（发表日期）**：INIS 给 1983-02-28；INSPIRE `preprint_date 1982-04`。预印本到发表间隔 10 个月，正常。

## 5. 对图的建议

（researcher 只提建议，不动 `graph/`。）

1. **`worldsheet.no-ghost-theorem-brst`**：
   - KO 可以继续挂，但 `sources[kato-ogawa-1983].loc` 只能写「全文；摘要」，**不得写式号**。note 建议改为：「BRST 版无鬼定理的物理学原始出处；证明结构（经 IMNU 1986 同型证明反推，L3）= 鬼零模分离 + 光锥参考系（p⁺≠0）+ 形式参数 β 展开 + Kugo–Ojima quartet + DDF 横向投影，见 `extractions/kato-ogawa-1983.md` §3」。
   - **status 不能因 KO 离开 `physical-argument`**：形式 β 展开 + 归纳，是物理学家证明。要 `rigorous` 仍靠 `fgz-1986` Theorem 2.8 / `lian-zuckerman-1991` Theorem 3.5(i)（既有）。
   - 建议在 gaps 里补一条：「KO 型证明隐含 `p⁺ ≠ 0`（零动量扇区另论）」——这条对 BRST 版比对 OCQ 版更要紧，因为 Dedushenko 2015 p.2 明说 FGZ 路线能做 d=1 而 KO/Polchinski 路线要 d ≥ 2。
2. **`worldsheet.critical-dimension-brst-v2`**：
   - 若陈述文本是「当且仅当」：KO 只覆盖 ⟹（摘要逐字 "required by"）。⟸ 目前**没有任何 L1/L2 来源**指向 KO；Polchinski §4.3 的形式计算是唯一既有来源。建议 derivation 拆成两条：`Q²=0 ⟹ (D=26, a=1)` 挂 KO（L2）+ Polchinski；`(D=26, a=1) ⟹ Q²=0` 只挂 Polchinski，并在 note 里写「KO 摘要不含此方向；正文未读」。
   - **不要**把 LZ 1989 Prop 1.7(ii)「Q² = 0 iff D = 10」当玻色弦的 iff 来源——那是 RNS 超弦。
3. **新增候选节点**（供 curator 查重后决定）：「BRST 物理态条件 = `b₀|ψ⟩ = 0` 且 `Q_B|ψ⟩ = 0`（相对于 b₀ 的相对复形）」——physics 原始出处 KO（经 IMNU (3.12)/(3.26) 与 KKM (2.1) 两条 L3 指认），math 出处 FGZ §2 / LZ 1991 §2.3。
4. **bib**：`kato-ogawa-1983` 的 note 应删去「L4 异议未裁决」，改为「KUNS 归属已由 INSPIRE/INIS 单位字段确认（2026-09-11）」；补 `preprint_date 1982-04`、`KEKSCAN 2000-33-955`、INIS issue 3。
