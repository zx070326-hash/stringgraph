# BRST 上同调相关文献：编号与元数据核实

- 负责 agent：researcher
- 日期：2026-09-10
- 触发：图中若干 `canonical_source` / bib 条目标注「编号未核实」
- 本文件不套 `templates/extraction.md`，是一次专项核实记录（自建小节）

## 0. 证据等级约定（本文件内）

| 等级 | 含义 |
|---|---|
| L1 | 我逐页读了原文（扫描件/正文），可照抄措辞 |
| L2 | 出版方权威元数据或期刊逐字摘要（Crossref / INSPIRE / Project Euclid / PMC / ADS） |
| L3 | 可溯源二手陈述（作者本人综述、引用该文的公开论文） |
| L4 | 检索后端中介读取（WebSearch 摘要读 PDF），**非逐字，不得单独作为唯一依据** |
| L0 | 未能核实 |

只有 L1 可以照抄原文措辞。L2–L4 的转述在下文都点名标注。

---

## 1. `fgz-1986` — Frenkel, Garland, Zuckerman (PNAS 1986)

**核实状态：已核实（L1，全文五页逐页读毕）**

- 来源：PMC386946 = *Proc. Natl. Acad. Sci. USA* **83** (1986) 8442–8446, issue 22, DOI `10.1073/pnas.83.22.8442`。
  PMC 只有扫描页 PNG（`pnas00326-0015.png` … `-0019.png`），已逐页读取。
- 标题（扫描页首行逐字）：`Semi-infinite cohomology and string theory`，副标题括注
  `(Virasoro algebra/Kähler structure/vanishing theorems/no-ghost theorem/gauge invariance)`。
  Communicated by I. M. Singer, June 6, 1986。

### 1.1 章节结构（L1）

```
Section 1.  Semi-Infinite Cohomology of Graded Lie Algebras
  Section 1.1  Definitions and Basic Results
  Section 1.2  Relative Subcomplex
  Section 1.3  Vanishing Theorem
Section 2.  Semi-Infinite Cohomology of the Virasoro Algebra
  Section 2.1  The Virasoro Algebra and the Bechi-Rouet-Stora-Tyutin (BRST) Complex
  Section 2.2  Identification of the Cohomology with Coefficients in Fock Space
  Section 2.3  Exceptional Case and Further Perspectives
```

编号体系：`Proposition x.y` / `Theorem x.y`，两位编号，跨全文连续。

### 1.2 「Q² = 0 iff c = 26」——**文中没有这样一条编号陈述**（L1，重要）

这是本次核实最该回传给 curator 的一条。FGZ 把幂零性和 26 拆成两处，且**没有 iff**：

- **Proposition 1.2** 全文就是一句：`d² = 0.`（p.8443 左栏，紧跟公式 [1.3] 定义 d 之后）。
  这是**一般分次李代数**的陈述，前提写在正文而非命题里：p.8443 左栏上方
  「From this point on we will assume that H²(g) = 0 and that ω₀ and β are fixed in such a way
  that γ = 0 and therefore Eq. 1.2 provides a representation of g on Λ^∞_*.」
  **Proposition 1.2 里不出现 26，也不出现中心荷。**
- **26 出现在 Proposition 2.1**（p.8444 右栏，§2.1 内）：
  `(i) ρ(c) = −26 Id_{Λ^∞_*}`，`(ii) ρ(L_m) = Σ_n (n−m) :c_{−n} b_{m+n}:`。
  紧接其后的正文（照抄）：
  「We will work in the subcomplex of V ⊗ Λ^∞_* ℒ' relative to the center. Thus from this point
  on we will assume that π(c) = 26 Id_V. When V is the Fock module (see Section 2.2), the
  differential of this subcomplex is known in the physics literature as the BRST operator
  (see, e.g., ref. 5) and we will call this subcomplex the BRST complex.」
  （ref. 5 = Kato & Ogawa 1983，见本文件第 6 节。）

**因此**：在 FGZ 里，26 的地位是「鬼系统表示的中心荷算出来是 −26」（Prop 2.1(i)）**加上**「对相对复形假设 π(c) = 26」。
**FGZ 不推导 D = 26，而是假设它。** §2.2 里也明写：「Now we will consider the relative cohomology
groups with coefficients in V(E, p), so that D = 26.」（p.8445 右栏）

> curator 注意：若图里有节点声称「FGZ 给出 Q²=0 ⟺ c=26 的严格版本」，按本次核实**不成立**；
> 应改为「FGZ 在 c=26 处构造 BRST 复形并证明其上同调结构」，D=26 是 FGZ 的**假设**不是结论。
> 「Q_B² = 0 ⟹ D=26, a=1」的原始来源是 Kato–Ogawa 1983（第 6 节）。

### 1.3 无鬼定理 = **Theorem 2.8**（L1）

p.8446 左栏。按扫描件转录（符号排版可能有细微出入）：

> **THEOREM 2.8.** *The inclusion of P into* (V(R^{25,1}, p) ⊗ Λ^0_∞)^{ℒ_0}, *p ≠ 0, induces a
> unitary isomorphism from P/rad P ≅ H^0_∞(ℒ, ℒ_0, V(R^{25,1}, p)). The inclusion of T ∩ P into P
> induces a unitary isomorphism T ∩ P ≅ P/rad P. All three isomorphic spaces are positive
> definite and have dimension p_{(24)}(1 − (p·p/2)).*

紧接的一句是关键的自我定位（照抄）：

> 「The second isomorphism of *Theorem 2.8* is known as the no-ghost theorem in the physics
> literature (8, 9).」

其中 ref 8 = Goddard & Thorn (1972) Phys. Lett. B **40**, 235–238；ref 9 = Brower (1972) Phys. Rev. D **6**, 1655–1662。
即 **FGZ 自己指认的「无鬼定理」就是 Theorem 2.8 的第二个同构 `T ∩ P ≅ P/rad P`（横向空间 ≅ 物理态模去零模）**，
而不是第一个同构（物理态 ≅ 零阶上同调）。这两条要分开挂节点。

FGZ 还在同段给了第二个证明：Eq. [2.5]–[2.8] 用 Euler–Poincaré 型的 signature 论证，
并自评（照抄）「It is remarkable that the semi-infinite cohomology of the Virasoro algebras provides
the simplest and the most conceptual proof of this rather mysterious result. Note that the latter
proof does not use the existence of the transversal space!」

### 1.4 其他编号陈述（L1，供 curator 挑节点）

| 编号 | 位置 | 一句话内容 |
|---|---|---|
| Prop. 1.1 | p.8443 | 存在 2-上循环 γ；(ii) γ 代表 H²(g) 的平凡类时可取 γ ≡ 0 |
| Prop. 1.2 | p.8443 | `d² = 0` |
| Prop. 1.3 | p.8443 | Euler–Poincaré：Σ_m (−1)^m ch_q(V ⊗ Λ^m_∞) = Σ (−1)^m ch_q H^m_∞(g, V) |
| Prop. 1.4 / 1.5 | p.8443 | 反对合 σ 与 ε, ι, d 的相容性；ρ(x)* = −ρ(σ(x)), d* = d |
| **Thm. 1.6** | p.8443 | **Poincaré duality**：V Hermitian 时 H^{m;n}_∞ 的反对偶同构于 H^{−m;n}_∞ |
| Prop. 1.6/1.7 | p.8443 | [L, Λ] = −H, [H, L] = 2L, [H, Λ] = −2Λ（sl(2,C) 结构）；Hermitian 结构 |
| **Thm. 1.8** | p.8444 | (i) *² = (−1)^{a+b}，(iii) ι(x)* = (−1)^{a+b} ε(x) 等；d* = *̄ d *̄ |
| **Thm. 1.9** | p.8444 | Kähler 恒等式 Δ = 2Δ₁ = 2Δ₂ |
| Prop. 1.10/1.11/1.11′ | p.8444 | 谱序列滤过；E₁ ≅ ⨆(H^a(n₊, V) ⊗ H^b_∞(n₋, V))^{gp} |
| **Thm. 1.12** | p.8444 | **消灭定理**：V 是 n₋-free、有非退化 Hermitian 形式时 H^m_∞(g, g₀; V) = 0, m ≠ 0 |
| **Prop. 2.1** | p.8444 | (i) ρ(c) = −26 Id；(ii) ρ(L_m) 的鬼场表达式 |
| Prop. 2.2 / 2.3 | p.8444 | 生成函数 b(z), c(z), T_V(z), T_Λ(z) 的表达；与 Banks–Peskin 形式的对应 |
| Prop. 2.4 | p.8445 | dim H^m_∞(ℒ, ℒ₀; V) = 0 for m ≠ 0；m = 0 时等于 Eq. [2.3] 中 1 的系数 |
| **Thm. 2.5** | p.8445 | H^m_∞(ℒ, 𝖟; V) ≅ H^0(ℒ, ℒ₀; V) for m = ±1/2，其余为零 |
| **Prop. 2.6** | p.8445 | D ≥ 2, p ≠ 0 时 V(E, p) 是 free ℒ^-module，且存在正定 T ⊂ V(E,p) 被 ℒ^+ 湮灭（横向空间的构造） |
| **Thm. 2.7** | p.8445 | p ≠ 0 时 (i) H^i_∞(ℒ, ℒ₀, V(E,p)) = 0, i ≠ 0；(ii) dim H^0 = p_{(24)}(1 − p·p/2)（当 1 − p·p/2 为非负整数，否则 0）。**此处已设 D = 26** |
| **Thm. 2.8** | p.8446 | 无鬼定理（见上） |
| Prop. 2.8 / 2.9 + Corollary | p.8446 | p = 0 例外情形（Thm 1.12 不适用），格 L 为偶整格时 H^{±1/2}_∞(ℒ, 𝖟; V(R^{25,1}, L)) ≅ P(R^{25,1}, L) |

（注意 §2.3 里编号**重复**：p.8446 同时有 §1 之后的 `Prop. 2.8` 和 `Thm. 2.8`，两者不同。引用时必须写全 `Proposition`/`Theorem`。）

### 1.5 FGZ 参考文献里可直接复用的三条（L1）

- ref 5：Kato, M. & Ogawa, K. (1983) *Nucl. Phys. B* **212**, 443–460
- ref 8：Goddard, P. & Thorn, C. (1972) *Phys. Lett.* **40B**, 235–238
- ref 9：Brower, R. (1972) *Phys. Rev. D* **6**, 1655–1662
- ref 11：Feigin, B. & Fuks, D. (1982) Funkt. Anal. Prilozhenia **16**, 47–63（英译 *Funct. Anal. Appl.* **16**, 114–126）→ 与 bib 里 `feigin-fuchs-1982` 的 114–126 一致
- ref 10：Kac, V. (1978) *Proc. ICM* (Helsinki) Vol. 1, 299–304 → **与 bib 里 `kac-1979`（Lecture Notes in Physics 94, 441–445）不是同一篇**，未处理，留给后续

---

## 2. `lian-zuckerman-1989` — Lian & Zuckerman (CMP 1989)

**核实状态：部分核实（元数据 L2 已核实；定理编号 L0 未能核实）**

- **真实标题：`BRST cohomology of the super-Virasoro algebras`**
  来源：Project Euclid 期刊卷期目录（CMP Vol. 125 Issue 2）逐字，
  <https://projecteuclid.org/journals/communications-in-mathematical-physics/volume-125/issue-2>
  以及文章页 `cmp/1104179468`。Crossref（`10.1007/bf01217910`）同样给 `BRST cohomology of the super-Virasoro Algebras`。
- 图里按记忆填的 **"supra-Virasoro" 是错的**，应为 **"super-Virasoro"**。
  （INSPIRE 把它归一化成 `BRST Cohomology of the Supervirasoro Algebras`，属同一篇的不同排版，以 Project Euclid / Crossref 为准。）
- 卷/期/页/年：*Commun. Math. Phys.* **125** (1989), issue 2, 301–335 — 与 reviewer 给的一致，**已核实**。
- DOI：`10.1007/BF01217910`。Project Euclid id：`cmp/1104179468`。
- 同期目录佐证（Project Euclid，L2）：该期文章顺序为 Fredenhagen–Rehren–Schroer 201–226、Baulieu–Singer 227–237、
  Ruelle 239–262、Eskin 263–300、**Lian–Zuckerman 301–335**、Lyons 337–353、Bismut–Vasserot 355–367。

### 2.1 内容范围警告（L2，重要）

INSPIRE 摘要（片段逐字）：
「We study the superextension of the semi-infinite cohomology theory of the Virasoro Algebra.」
「examine the BRST complex with coefficients in the Fock Space of the RNS superstring」
「a theorem of vanishing cohomology」
「the unitary equivalence between a positive definite transversal space, a physical subspace and the zeroth cohomology group」
「the cohomology of a subcomplex is identified as the covariant equivalent of the well-known GSO subspace」
「an exceptional case to the vanishing theorem is discussed」

即：**这是 RNS 超弦 / super-Virasoro 的论文，是 FGZ 1986 的超对称推广，不是玻色弦 c = 26 的论文。**
把它挂到「玻色弦 Q_B² = 0 ⟺ c = 26」或「玻色弦无鬼定理」上是**误引**。
它对应的临界值是超弦的 ĉ = 10（c = 15），不是 26。

### 2.2 定理编号未能核实（L0）

- Project Euclid 明示「There is no online version at this time. Please download the PDF instead.」，PDF 在付费墙后。
- Springer `link.springer.com/article/10.1007/BF01217910` 303 重定向到 `idp.springer.com/authorize`（登录墙），
  与 `reference_web-fetch-access-blockers` 里记录的 Springer/Nature 行为一致。
- 没有 arXiv 版本（1989 年，早于 arXiv）。

**结论：不能给出该文里 Q_B 幂零条件或无鬼定理的定理编号。图里凡引它的定理号都应标 `loc_unverified: true`。**

> **★ 本节已作废（2026-09-11）**：全文已由 **Project Euclid 下载端点** `journalArticle/Download?urlId=cmp%2F1104179468` 取得并逐页读毕（35 页，L1）。
> 幂零 = **Proposition 1.7(ii)**「Q² = 0 iff D = 10」（证明外包给 Ohta [13]、Terao–Uehara [15]）；
> 无鬼 = **Corollary 2.15(ii)**（作者自命名）与 **Theorem 2.20**。完整编号清单与前提链见 `extractions/lian-zuckerman-1989.md`。
> 上面「付费墙」的判断只对 `.full` 页与 Springer 成立，对下载端点不成立——与 `lian-zuckerman-1991` 是同一教训。

### 2.3 与另外两篇 Lian–Zuckerman 的区分（L2）

- `New perspectives on the BRST-algebraic structure of string theory` = *Commun. Math. Phys.* **154** (1993), issue 3, 613–646，DOI `10.1007/BF02102111`（Crossref）。**是另一篇**，1993 年，不是 1989 的这篇。
- `BRST cohomology and highest weight vectors. I` = *Commun. Math. Phys.* **135** (1991), issue 3, 547–580，DOI `10.1007/BF02104121`（Crossref）。若图里需要**一般 Virasoro**（而非 super-Virasoro）的 BRST 上同调结果，这一篇比 1989 那篇更可能是正确出处 —— 但我**没有核实其内容**，只核实了元数据。

---

## 3. `goddard-thorn-1972` — Goddard & Thorn (Phys. Lett. B 1972)

**核实状态：部分核实（元数据 + 摘要 L2 已核实；「Theorem 1」L0 未能核实，且无任何来源支持）**

- 元数据（Crossref 与 INSPIRE #74899 一致）：
  *Phys. Lett. B* **40** (1972), issue 2, 235–238，DOI `10.1016/0370-2693(72)90420-0`。
  作者单位均为 CERN, Geneva。另收录于 Schwarz (ed.), *Superstrings, Vol. 1*, 112–115。
- **摘要逐字**（INSPIRE，L2）：
  > 「It is shown that the number of states coupling in the Veneziano model when the space time
  > dimension, d, is 26 (d = 10 for the Neveu-Schwarz model) is reduced in such a way that the
  > Pomeron is probably a pole. A simple consequence of this counting is the absence of ghosts
  > for d ⩽ 26 (d ⩽ 10 for Neveu-Schwartz).」
  （末尾 "Neveu-Schwartz" 拼写错误是原记录如此。）

### 3.1 「Theorem 1」是否存在：未能核实，且间接证据全部指向「无编号」

正文取不到，四条路径全部失败（详见第 7 节访问日志）。因此**不能确认也不能否认**文中有 `Theorem 1`。
但以下三条间接证据一致指向「这篇快报没有编号定理」：

1. **Goddard 本人 2008 年的历史综述**（arXiv:0802.3249, *From Dual Models to String Theory*，L3）
   复述这条结果时称之为 "the No-Ghost Theorem"，陈述为「For D = 26, if |ψ⟩ is a physical state …
   it can be written in the form」+ DDF 态 + 零模物理态，**通篇不给编号**。
2. **FGZ 1986（我读了全文，L1）** 引它为 ref 8，写「known as the no-ghost theorem in the physics
   literature (8, 9)」，**不给编号**。
3. 该文是 4 页的 Physics Letters 快报（235–238），该年代该刊体例基本不用编号定理。

**建议**：把 milestone 的 `canonical_source` 从 `"Theorem 1"` 改为
`"无编号；结论见摘要末句 'absence of ghosts for d ⩽ 26'"`，或保留位置但打 `loc_unverified: true`。
**不要在没有正文的情况下把「Theorem 1」写进图。**

### 3.2 适用范围：只对 a = 1？D > 26 的反例在不在文中？（L2 + L3）

- 摘要**只说 d ⩽ 26，完全没提 intercept**。原因是 Veneziano 模型本身以 α₀ = 1 为前提
  （Virasoro 的无穷多条件只在 α₀ = 1 时成立）—— 这一点由 Goddard 2008 综述明说（L3）：
  「If α₀ = 1 … so that Virasoro's conditions obtain, the lowest state has negative mass squared」，
  并称 α₀ = 1「we shall in general take to be the case in what follows」。
- **摘要里没有 D > 26 的反例。** Goddard 2008 综述把「D > 26 时物理态中出现鬼」明确归给**更早的**
  Brower–Thorn 1971（他的 ref [29]），不是 1972 的这两篇：他写他们发现
  「a ghost amongst the physical states if the dimension of space-time, D > 26」，
  并解释 D = 26 是「the norm of a physical state moves from positive values through zero to negative values」的转折点。
- Brower–Thorn 1971 的元数据（INSPIRE，L2）：*Eliminating spurious states from the dual resonance model*,
  R. C. Brower & C. B. Thorn, *Nucl. Phys. B* **31** (1971) 163–182, DOI `10.1016/0550-3213(71)90452-4`。
  **注意矛盾点**：该文摘要只说「no ghosts or unanticipated null ('zero norm') states are found on the
  leading nine trajectories」，**摘要里没有出现 D > 26 或任何维数条件**。Goddard 2008 的归属（L3）与
  Brower–Thorn 摘要（L2）之间存在张力，需读 Brower–Thorn 正文才能裁决。**本次不裁决，如实登记两方。**

---

## 4. `brower-1972` — Brower (Phys. Rev. D 1972)

**核实状态：部分核实（元数据 + 摘要 L2；正文 L0）。结论对 auditor 的问题是否定的。**

- 元数据（INSPIRE #74322 + ADS `1972PhRvD...6.1655B` 一致）：
  *Phys. Rev. D* **6** (1972), issue 6, 1655–1662，DOI `10.1103/PhysRevD.6.1655`，MIT LNS。
  期刊页标题排版为 `Spectrum-Generating Algebra and No-Ghost Theorem for the Dual Model`。
- 摘要要点（INSPIRE 记录，引号内逐字，其余转述，L2）：
  - 鬼态「decouple for unit Regge intercept」，机制是 Virasoro gauge L_n；
  - 在 light-cone 变量下重写顶点，得到与所有 L_n 对易的 spectrum-generating algebra；
  - 横向生成元 A^i_n 与原振子同构，纵向生成元 A^{(+)}_n（差 c-数）与共形群生成元同构；
  - 「a critical dimension D = 26」：其上有鬼、其下无鬼；D = 26 处纵向生成元全部对应零模态。

### 4.1 对「(D ≤ 25, a ≤ 1) 或 (D = 26, a = 1)」的文献归属（本次最关键的否定结论）

- **Brower 1972 的摘要把结果限定在 unit Regge intercept，即 a = 1。没有任何证据显示它处理任意 a ≤ 1。**
- **Goddard 2008 综述（L3）通篇在 α₀ = 1 下陈述无鬼定理**，D < 26 的情形是**嵌入 D = 26 的情形**得到：
  逐字「The No-Ghost Theorem follows for D < 26 by embedding in the D = 26 case.」
  该综述**完全没有讨论 α₀ < 1**，也没有把 D < 26 当作独立的非单位截距情形。

**结论：auditor 提出的两分支表述「(D ≤ 25, a ≤ 1) 或 (D = 26, a = 1)」不能归给 `brower-1972`，
也不能归给 `goddard-thorn-1972`。这两篇 1972 年的论文（按可得证据）都只覆盖 a = 1。**

- **仍未解**：a < 1 ⇒ D ≤ 25 这一支的文献出处**未找到可引用来源**。检索后端把它当作教科书标准表述（L4），
  但我没拿到任何一手或权威二手的成文陈述，**按项目纪律不入库**。
  后续应查（按优先级）：
  1. GSW Vol. 1 §2.3.3「The no-ghost theorem and the spectrum-generating algebra」（p.102–112）
  2. Polchinski Vol. 1 §4.1 / §4.4
  3. C. B. Thorn, *A detailed study of the physical state conditions in covariantly quantized string
     theories*, *Nucl. Phys. B* **286** (1987) 61–77, DOI `10.1016/0550-3213(87)90431-7`
     （nLab 与 Thorn 本人 arXiv:1110.5510 都称这是把 1972 年证明「substantially streamlined (and improved)」的版本）

---

## 5. GSW Vol. 1 §2.3 —— eq. (2.3.32) 与 DDF 算子

**核实状态：部分核实（章节页码 L4/L2 混合；式号内容 L0）。reviewer 的两条说法一条获佐证、一条被反证。**

### 5.1 §2.2–§2.3 的目录（CUP 25 周年版 frontmatter，L4：由检索后端读取该 PDF）

| 节 | 标题 | 起始页 |
|---|---|---|
| 2.2 | Quantization — old covariant approach | 74 |
| 2.2.1 | Commutation relations and mode expansions | 75 |
| 2.2.2 | Virasoro algebra and physical states | 79 |
| 2.2.3 | Vertex operators | 86 |
| 2.3 | Light-cone gauge quantization | 92 |
| **2.3.1** | **Light-cone gauge and Lorentz algebra** | **93** |
| **2.3.2** | **Construction of transverse physical states** | **100** |
| **2.3.3** | **The no-ghost theorem and the spectrum-generating algebra** | **102** |
| 2.3.4 | Analysis of the spectrum | 113 |
| 2.3.5 | Asymptotic formulas for level densities | 116 |
| 2.4 | Summary | 119 |

原始 URL：`https://assets.cambridge.org/97811070/29118/frontmatter/9781107029118_frontmatter.pdf`
（WebFetch 三次都返回 `Socket is closed`，只能靠检索后端读取 → **L4，未逐字核对**。）

### 5.2 Google Books 全文检索定位（vol. 1, id = `ItVsHqjJo4gC`）

Google Books 只回页码不回 snippet。先做了两个对照实验验证「回的是真命中页而不是默认预览页」：

| 对照查询 | 返回页 | 与目录是否吻合 |
|---|---|---|
| `"Construction of transverse physical states"` | 100 | ✅ = §2.3.2 起始页 |
| `"Asymptotic formulas for level densities"` | 116 | ✅ = §2.3.5 起始页 |

正式查询：

| 查询 | 返回页 | 落在哪一节 |
|---|---|---|
| `"2.3.30"` | 99 | §2.3.1（93–99） |
| **`"2.3.32"`** | **99** | **§2.3.1（末页）** |
| `"2.3.34"` | 100 | §2.3.2 |
| `"2.3.36"` | 111 | §2.3.3 ← **与单调性不符** |
| `"DDF"` | 103 | §2.3.3（102–112） |
| `"DDF operators"` | 215 | 第 4 章之后 |
| `"Del Giudice"` | 443 | 参考文献 |

### 5.3 两条结论

1. **(2.3.32) 在 p.99，即 §2.3.1「Light-cone gauge and Lorentz algebra」的最后一页。**
   reviewer 说它属于 §2.3.1、内容与 `[J^{i−}, J^{j−}]` 的反常系数有关 —— **章节归属获得佐证**
   （p.99 正是该小节收尾、也正是光锥 Lorentz 代数闭合条件给出 D = 26 与 a = 1 的位置）。
   **但式子内容我没有读到 GSW 正文，不能确认它就是反常系数式。**内容等级 **L0**。
2. **「§2.3.2 是 DDF 算子的定义」未获佐证，反向证据更强。**
   `DDF` 在正文首次命中 p.103，落在 §2.3.3（102–112），而 §2.3.2 只占 p.100–101。
   §2.3.2 的标题是「Construction of transverse physical states」，DDF/spectrum-generating algebra
   按目录属于 §2.3.3。**DDF 算子的定义式号未能核实（L0）。**

### 5.4 使用限制

`"2.3.36"` 返回 p.111 而 `"2.3.34"` 返回 p.100，说明 Google Books 返回的**不一定是首次出现页**
（p.111 很可能是一处交叉引用）。所以这套页码只能当**区间约束**用，不能当精确定位。
本节所有「式号 ↔ 内容」的对应都是 **L0**，写进图节点的 `loc` 时必须标注未核实。

---

## 6. `kato-ogawa-1983` — Kato & Ogawa (Nucl. Phys. B 1983)

**核实状态：已核实（元数据 + 摘要 L2，且有 L1 独立佐证）；定理编号未核实（L0）**

- 真实标题：`Covariant Quantization of String Based on BRS Invariance`
- 作者：Mitsuhiro Kato, Kaku Ogawa
- *Nucl. Phys. B* **212** (1983) 443–460，DOI `10.1016/0550-3213(83)90680-6`（INSPIRE）
- **独立佐证（L1）**：FGZ 1986 的参考文献 5 给出同样的卷页 `Nucl. Phys. B 212, 443-460`，
  且 FGZ 在 §2.1 把「BRST operator」这一叫法直接指向该文（"see, e.g., ref. 5"）。

摘要（INSPIRE，引号内逐字，其余转述，L2）：
> 「Covariant canonical quantization of the bosonic string is performed, based on the BRS invariance principle.」

物理态用 Kugo–Ojima 型附加条件的修改版定义（要求 BRS 荷湮灭之），由此给出无鬼定理的直接证明。
> 「There an interesting relation between critical dimension and BRS symmetry is noticed」

即 **D = 26 与领头轨迹截距 a = 1 是「要求 BRS 荷幂零」的必然结果**。
另观察到 ghost number fractionization。

### 6.1 对「是否是『BRST 上同调 ≅ 旧协变物理态』的原始来源」的判断

- **是**「Q_B² = 0 ⟹ D = 26 且 a = 1」的原始来源：摘要直接这么说，且 FGZ（1986）与后续文献都这么引。
- 「BRST 上同调 ≅ 旧协变物理态」这一表述：**部分成立，需谨慎**。
  摘要说的是「用 BRS 附加条件定义物理态，并证明无鬼定理」，**用的是物理态/无鬼的语言，不是上同调语言**
  （`H^0` / 相对上同调 / 消灭定理 这一套是 FGZ 1986 引入的）。
  把 Kato–Ogawa 登记为「BRST 上同调 ≅ 旧协变物理态」的原始出处，需要读正文确认它是否真的做了
  `Ker Q_B / Im Q_B ≅ OCQ 物理态` 的同构陈述。**我没拿到正文（ScienceDirect 403），此点 L0。**
- **建议登记措辞**：「BRST 物理态条件 `Q_B|ψ⟩ = 0` 的引入，及由 `Q_B² = 0` 导出 D = 26、a = 1；
  该文自称给出无鬼定理的证明。是否已给出上同调同构的形式，未核实。」

> **2026-09-11 追加**：正文仍 L0，但**证明结构已由三条 L1 二手来源三角定位**（同学派同型证明 IMNU 1986 §4 五处「same method in Ref. 1)」；LZ 1989 p.332 Dixon–Taylor 结构 + Lemma 5.3.1「consult [11] for details」；KKM 2010 (2.1)/(2.5)/§2.2）：
> 鬼零模分离 → 光锥参考系（p⁺ ≠ 0）→ 形式参数 β 展开 → Kugo–Ojima quartet（Prop I 型）→ DDF 横向投影 + β 阶归纳（Prop II 型）→ `⟨φ|φ⟩ = ⟨φ|P|φ⟩ ≥ 0`。
> 「上同调 ≅ 旧协变物理态」的**上同调语言**按 LZ 1989 §0 与 Dedushenko 2015 §1 都归 FGZ；KO 内容上有 Prop II 型的 `Ker = 横向 ⊕ Im` 陈述（推断）。
> **KUNS 637 归属的 L4 异议已关闭**（INSPIRE raw_affiliation / INIS 均为京都大学物理系）。
> 详见 `extractions/kato-ogawa-1983.md`。

---

## 7. 访问日志（失败路径，供后人省事）

| 目标 | 路径 | 结果 |
|---|---|---|
| FGZ 全文 | `pmc.ncbi.nlm.nih.gov/articles/PMC386946/` HTML | 只有摘要，正文是扫描 PNG，无 OCR 文本 |
| FGZ 全文 | `pmc.ncbi.nlm.nih.gov/articles/PMC386946/pdf/...` | 返回 "Preparing to download" 中间页，无 PDF |
| FGZ 全文 | `europepmc.org/api/fulltextRepo?...` | HTTP 403 |
| **FGZ 全文** | **`cdn.ncbi.nlm.nih.gov/pmc/blobs/a950/386946/<hash>/pnas00326-00NN.png`** | **✅ 成功**：WebFetch 把 PNG 落盘并打印路径，再用 `Read` 读图即可逐页读完（**新方法，已记忆**） |
| GT 全文 | `sciencedirect.com/science/article/pii/0370269372904200` | HTTP 403 |
| GT 全文 | `cds.cern.ch/record/388690/files/CM-P00058839.pdf` | **Anubis 反爬挑战页**（CERN CDS 全站，含 `/search`），无内容 |
| GT 全文 | `r.jina.ai/https://cds.cern.ch/...` 代理 | 同样被 Anubis 挡回 |
| GT 全文 | `osti.gov/biblio/4619228` / `osti.gov/servlets/purl/4619228` | 只有元数据 / 404 |
| GT 全文 | `pdfs.semanticscholar.org/<hash>.pdf` | 301 回 semanticscholar 网页，无 PDF |
| Brower 全文 | `journals.aps.org/prd/abstract/10.1103/PhysRevD.6.1655` | HTTP 403（APS 全站） |
| Brower 全文 | INSPIRE `documents` / `urls` 字段 | 空，无 preprint |
| LZ 1989 全文 | `link.springer.com/article/10.1007/BF01217910` | 303 → `idp.springer.com/authorize` 登录墙 |
| LZ 1989 全文 | Project Euclid `cmp/1104179468.full` | 「There is no online version at this time」，PDF 付费 |
| GSW 目录 | `assets.cambridge.org/.../9781107029118_frontmatter.pdf` | WebFetch 连续 3 次 `Socket is closed`；只能靠检索后端读 |
| GSW 正文 | archive.org | **只有 Vol. 2**（`superstringtheor0002gree`），Vol. 1 不在 |
| 通用检索 | `html.duckduckgo.com` / `lite.duckduckgo.com` | CAPTCHA（"Select all squares containing a duck"） |
| 通用检索 | WebSearch | 本次会话**间歇性 `unavailable`**，约一半调用失败，需重试 |

**有效的元数据入口（全部可用）**：Crossref `api.crossref.org/works?query.bibliographic=`、
INSPIRE `inspirehep.net/api/literature?q=doi%20<DOI>&fields=...`、
Europe PMC `ebi.ac.uk/europepmc/webservices/rest/search`、
Project Euclid 卷期目录页、Google Books `books.google.com/books?id=<ID>&q=<term>`（只回页码不回 snippet）。

---

## 8. 本次对 `sources.bib` 的改动清单

**只改 title / journal / volume / number / pages / doi / note，不改任何 key。**

| key | 字段 | 改动 |
|---|---|---|
| `fgz-1986` | `journal` | `Proceedings of the National Academy of Sciences` → `Proceedings of the National Academy of Sciences of the United States of America` |
| `fgz-1986` | `number` | 新增 `22` |
| `fgz-1986` | `doi` | 新增 `10.1073/pnas.83.22.8442` |
| `fgz-1986` | `note` | 新增：全文已核实途径 + 无鬼定理 = Theorem 2.8 + 26 见 Prop 2.1(i) |
| `lian-zuckerman-1989` | `title` | **`BRST cohomology of the supra-Virasoro algebras` → `BRST cohomology of the super-Virasoro algebras`**（订正） |
| `lian-zuckerman-1989` | `number` | 新增 `2` |
| `lian-zuckerman-1989` | `doi` | 新增 `10.1007/BF01217910` |
| `lian-zuckerman-1989` | `note` | 替换旧「据记忆登记」note：标题/卷页已核实；内容是 RNS 超弦，定理编号仍未核实 |
| `goddard-thorn-1972` | `number` | 新增 `2` |
| `goddard-thorn-1972` | `doi` | 新增 `10.1016/0370-2693(72)90420-0` |
| `goddard-thorn-1972` | `note` | 新增：正文未获取，"Theorem 1" 未核实；摘要只给 d ⩽ 26 不提 intercept |
| `brower-1972` | `number` | 新增 `6` |
| `brower-1972` | `doi` | 新增 `10.1103/PhysRevD.6.1655` |
| `brower-1972` | `note` | 新增：摘要限定 unit Regge intercept；不支持 a ≤ 1 的两分支表述 |
| `kato-ogawa-1983` | 整条 | **新增条目** |
| `brower-thorn-1971` | 整条 | **新增条目**（D > 26 出鬼的归属源，Goddard 2008 所指） |
| `goddard-2008` | 整条 | **新增条目**（本文件第 3、4 节的 L3 证据来源） |
| `thorn-1987` | 整条 | **新增条目**（后续核查 a ≤ 1 归属的首选目标） |
| `lian-zuckerman-1993` | 整条 | **新增条目**（与 1989 区分用） |

未改动：`polchinski-1998-v1/v2`、`gsw-1987-v1`、`blt-2013`、`kac-1979`、`feigin-fuchs-1982`、
`green-schwarz-1984`、`maldacena-1997`、`virasoro-lean-2025`。
（`kac-1979` 与 FGZ ref 10 所指的 ICM 1978 论文疑似不是同一篇，**未处理**，见 §1.5。）
