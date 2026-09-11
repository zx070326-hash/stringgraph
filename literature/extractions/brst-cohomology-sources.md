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

---

## 9. ★ FGZ 1986 `Theorem 2.7` 复核（2026-09-11，researcher）——**逐字 + 量词链 + 页码**

> 只追加，不改上文 §1 任何一行。触发：§1.4 的表格里 Thm 2.7 只有**一句话转述**，图中若要把它当「相对上同调消灭定理」的 canonical source，需要逐字与完整量词。
> 取件路线沿用 §7 访问日志里那条成功路线：`cdn.ncbi.nlm.nih.gov/pmc/blobs/a950/386946/275fe5e6b989/pnas00326-0018.png`（**先 fetch `pmc.ncbi.nlm.nih.gov/articles/instance/386946/bin/pnas00326-0018.png`，它 301 到 cdn 域**），WebFetch 落盘 PNG（137.5 KB）→ `Read` 读图。**期刊页 8445 = 扫描页 `-0018`。**

### 9.1 ★★ Theorem 2.7 逐字（L1 页图，p.8445 右栏）

> **THEOREM 2.7.** *Suppose* `p ≠ 0`. *Then* (i) `H^i_∞(ℒ, ℒ₀, V(E, p)) = 0, i ≠ 0`, *and* (ii) `dim H^0_∞(ℒ, ℒ₀, V(E, p)) = p_{(24)}(1 − p·p/2)`, *if* `1 − p·p/2` *is a nonnegative integer and* `0` *otherwise*.

⇒ 与 §1.4 表格里的转述**内容一致，无需更正**；本节新增的是量词链、周边依赖与强度措辞。

### 9.2 量词链（全部逐字，散布在 Thm 2.7 之前，引用时必须集齐）

Thm 2.7 的陈述本身**只带一个量词 `p ≠ 0`**，其余四个前提都写在正文里，位置如下（均 p.8445，除注明外）：

| # | 前提 | 逐字出处 |
|---|---|---|
| 1 | **`p ≠ 0`** | 定理内 |
| 2 | **`D = 26`** | 紧邻上一段逐字：「Now we will consider the relative cohomology groups with coefficients in `V(E, p)`, **so that `D = 26`**.」（右栏，Thm 2.7 正上方） |
| 3 | **号差 `(D−1, 1)`** | 左栏末逐字：「Now we will restrict our attention to the case of signature `(D − 1, 1)`, which is the most interesting from both the mathematical and the physical points of view. The following fact has been known to physicists (see refs. **8** and **9** and refs. cited therein).」（refs 8/9 = Goddard–Thorn 1972 / Brower 1972，见 §1.5） |
| 4 | **`π(c) = 26 Id_V`**（相对中心的子复形约定） | §2.1 的常设假设，逐字见本文件 §1.2；p.8445 左栏给出它与 `D` 的接口：「`[π(L_m), π(L_n)] = (m − n)π(L_{m+n}) + (D/12)(m³ − m)δ_{m+n}·Id`. **Thus `π(c) = D·Id`** by Eq. 2.1. We have `π(L_m)* = π(L_{−m})`, so that `V(E, p)` is a Hermitian ℒ-module.」⇒ **`D = 26` 与 `π(c) = 26` 在 FGZ 里是同一个假设的两种写法，不是两条独立条件** |
| 5 | **`D ≥ 2`** | 经 Prop 2.6：「**PROPOSITION 2.6.** *Let* `E` *have signature* `(D − 1, 1)`, `D ≥ 2` *and* `p ≠ 0`. *Then* (i) `V(E, p)` *is a free* `ℒ^-`-*module and* (ii) *there exists a positive definite subspace* `T ⊂ V(E, p)^{ℒ^+}` [`= all v ∈ V(E, p)`, *annihilated by* `ℒ^+`], *such that* `ch_q T = q^{p·p/2}φ(q)^{D−2}`.」（**Thm 2.7 的证明用到 Prop 2.6 的第一部分**，见 9.3） |

### 9.3 FGZ **自己列出**的依赖（逐字，就在 Thm 2.7 正上方一句）

> 「In this case the vanishing theorem (**Theorem 1.12**), the Euler–Poincaré principle (**Proposition 1.3**), **Proposition 2.4**, and **the first part of Proposition 2.6** imply the following.」

⇒ 四条依赖是**原文明写**的，不是抽取者推断，建边时**不必标 `inferred`**：
`Thm 1.12`（消灭定理，需 `ℒ^-`-free + 非退化厄米形式）、`Prop 1.3`（Euler–Poincaré）、`Prop 2.4`（Fock 模上 `dim H^m = 0, m ≠ 0` 且 `m = 0` 的维数 = Eq. [2.3] 中 `1` 的系数）、`Prop 2.6(i)`（`V(E,p)` 是自由 `ℒ^-` 模 ← 这正是喂给 Thm 1.12 的假设）。
**强度措辞是 "imply the following"，即 FGZ 把 Thm 2.7 当作前四条的直接推论，本身不另给证明。**

### 9.4 「鬼数」的量词：FGZ **不用**这个词，只用 degree `i`（L1，限 p.8445）

- Thm 2.7 的指标是 `H^i_∞(ℒ, ℒ₀, ·)`，即**相对复形的整数次数 `i`**，消灭在 `i ≠ 0`。
- **p.8445 全页不出现 "ghost" / "ghost number" 字样**（negative evidence，仅覆盖本页）。物理学家的「鬼数」在 FGZ 里就是这个 `i`，而**零点由「相对 ℒ₀ 的子复形」这个约定固定**，不是另外声明的。
- ⚠ **绝对 vs 相对的次数偏移在 FGZ 里是 ±1/2**：`Theorem 2.5`（p.8445）逐字给的是 `H^m_∞(ℒ, 𝖟; V) ≅ H^0(ℒ, ℒ₀; V)` for `m = ±1/2`（其余为零）。
  ⇒ **凡引用 Thm 2.7 的「`i ≠ 0` 消灭」，必须同时写明这是相对复形**；换成绝对复形（相对中心 `𝖟`）时非零次数是 `±1/2` 而不是 `0`。这与 [[lit-brst-noghost-source-numbering]] 里记的「鬼数零点三家不同（LZ −1,0,1 / FOK ±½ / Dedushenko (A+1)±½）」是同一类陷阱。

### 9.5 Thm 2.7 之后紧跟的两句（对建卡有用，此前未转录）

> 「*Theorem 2.7* implies that the cohomology groups are trivial except for a one-dimensional `H^0_∞` in the positive-definite case, but `H^0_∞` can be arbitrarily large in the indefinite case. It turns out that in the case of signature `(25, 1)` we can explicitly construct representatives of the cohomology classes using **the second part of Proposition 2.6**. And this is the case of the most interest in physics.」

⇒ (a) 正定号差下 `H^0_∞` 一维、不定号差下可任意大；(b) **显式代表元的构造用的是 Prop 2.6 的第二部分（横向空间 `T`）**，与 Thm 2.7 用的第一部分（自由性）是**同一个命题的两半、承担不同任务**。

### 9.6 顺带逐字取得的两条（同页，与 `V(E,p)` 卡直接相关）

- **分次与形式特征标**（p.8445 左栏）：「The module `V(E, p)` is also a graded ℒ-module under the following definition of grading: `deg α^{μ₁}_{m₁} … |p⟩ = (Σ^N_{i=1} m_i) − (p·p/2)`. The formal character of `V(E, p)` is given by `ch_q(V(E, p)) = q^{p·p/2}φ(q)^{−D}`. The graded ℒ-module `V(E, p)` will be called a **Fock module**.」
- **Prop 2.6 之后的 Remark（关键的反例声明，与 LZ 1991/1989 的同型陈述呼应）**：「*Remark*: We note that, although `V(E, p)` in the above proposition is free over `ℒ_-`, it is **not in general a direct sum of Verma modules** or even generated as an ℒ-module by `V(E, p)^{ℒ^+}`. As a counterexample one can choose the case in which `p·p` is a nonpositive even integer.」
  ⇒ **FGZ 与 LZ（1989 p.320 Remark、1991）在「不是 Verma 模直和」这一点上一致**；与 FOK 1989 p.111/115 转述 Brower–Friedman 的「fully reducible ⇒ Verma 模无穷直和」构成**第二条独立反证**。见 `figueroa-ofarrill-kimura-1989.md` 与 `brower-friedman-1973.md` 的裁决任务。

### 9.7 对图的建议（researcher 不改 `graph/`，仅列）

- 「相对上同调消灭定理（玻色弦）」的 canonical source 用 **`fgz-1986, Theorem 2.7(i), p.8445`**，`statement` 必须带 9.2 的五个量词（至少 `p ≠ 0`、`D = 26`、号差 `(D−1,1)`、相对 `ℒ₀`）。
- 维数公式 **Thm 2.7(ii)** 建议**单独一卡**（`dim H^0 = p_{(24)}(1 − p·p/2)`，含「`1 − p·p/2` 为非负整数否则为 0」的分段），因为下游（无鬼定理 Thm 2.8 的维数计数）只用到它。
- 依赖边按 9.3 建**实边不标 `inferred`**：→ `Thm 1.12`、`Prop 1.3`、`Prop 2.4`、`Prop 2.6(i)`。
- `status`：FGZ 是数学论文、有完整证明链，可给 `rigorous`；**但 `Prop 2.6(ii)` 的横向空间构造在 FGZ 里引用 Kac 行列式（refs 10, 11）**，若图里那条链未建，需在 note 里写明。

### 9.8 访问日志（本节）

| 目标 | URL / 手法 | 结果 |
|---|---|---|
| FGZ p.8445 | `pmc.ncbi.nlm.nih.gov/articles/instance/386946/bin/pnas00326-0018.png` | 301 → cdn 域（WebFetch 不自动跟随，需第二次调用） |
| FGZ p.8445 | `cdn.ncbi.nlm.nih.gov/pmc/blobs/a950/386946/275fe5e6b989/pnas00326-0018.png` | ✅ 137.5 KB PNG 落盘，`Read` 读图，整页两栏可辨 |

### 9.9 ★ `Proposition 2.4` 复核（2026-09-11 第二轮，researcher）——逐字 + 与 Thm 2.7 的真正区别

> 触发（lead）：§1.4 的表格里 `Prop 2.4` 只有一句转述，而该转述与 `Thm 2.7` 的结论几乎重复，
> 怀疑原文对 `V` 另有假设。**核实结果：怀疑成立——Prop 2.4 对 `V` 另有三条假设，全部写在定理语句里。**
> 取件：与 §9.8 同一张页图（先 fetch `pmc.ncbi.nlm.nih.gov/articles/instance/386946/bin/pnas00326-0018.png`
> → 301 → `cdn.ncbi.nlm.nih.gov/pmc/blobs/a950/386946/275fe5e6b989/pnas00326-0018.png`，137.5 KB，
> 期刊 **p.8445 = 扫描页 `-0018`**），本轮重新取件并重读。**`Prop 2.4` 在 p.8445 左栏下部，`Thm 2.5` 正上方。**
> 本节只追加，不改 §1.4 与 §9.1–§9.8 任何一行。

#### 9.9.1 ★★ Proposition 2.4 逐字（L1 页图）

> **PROPOSITION 2.4.** `dim H^m_∞(ℒ, ℒ₀; V) = 0` *for* `m ≠ 0`, *and for* `m = 0` *is equal to the coefficient of*
> `1` *in Eq.* **2.3**, *when* `V` *is a Hermitian* `ℒ⁻`*-free* `ℒ`*-module in* `𝒪₀`.

⚠ **两条转录注记（引用前必读）**：
1. **`ℒ⁻-free` 的上标减号在扫描件上极小**，单看这一行容易读成 `ℒ-free`。**按上下文锁定为 `ℒ⁻`**：
   紧邻上一段逐字就是「Let us consider a general `ℒ⁻`-free, Hermitian `ℒ`-module `V`」，
   且 `Theorem 1.12` 的假设本身就是 `ℒ⁻`-free（§1.4）。
   （**同型陷阱**：`lian-zuckerman-1991` 的 `Thm 2.25` 假设行同样把 `𝒢₋-free` 渲染成 `𝒢-free`，见 `primary-sources-round2.md` §1。）
2. FGZ 正文引用公式写作「**Eq. 2.3**」，而显示式的标号印作 **`[2.3]`**。两种写法都能对上原文，
   但**不要写成 "equation (2.3)"**（本文不用圆括号式号）。
3. `𝒪₀` 的下标在扫描件上可辨，但 **`𝒪₀` 这个范畴的定义在 §1，本轮未回查**（L0）。

#### 9.9.2 ★★★ 与 `Theorem 2.7` 的区别：不是重复，是「一般命题」vs「它在 Fock 模上的具体化」

| | `Proposition 2.4` | `Theorem 2.7` |
|---|---|---|
| `V` 的范围 | **任意**满足三条件的 `V`：(a) **Hermitian**、(b) **`ℒ⁻`-free**、(c) **属于 `𝒪₀`** | **具体的 Fock 模 `V(E, p)`**（§2.2 定义） |
| 量词 | **不含 `p ≠ 0`、不含号差 `(D−1,1)`、不含 `D ≥ 2`** | `p ≠ 0`（语句内）；号差 `(D−1,1)`、`D = 26`、`D ≥ 2`（正文，见 §9.2） |
| `m ≠ 0` 的消灭 | `dim H^m_∞(ℒ, ℒ₀; V) = 0` | `H^i_∞(ℒ, ℒ₀, V(E,p)) = 0, i ≠ 0`（**实质同一句**） |
| `m = 0` 的维数 | **隐式**：「the coefficient of `1` in Eq. 2.3」，即形式 Euler 特征标 `q^{−1}φ²(q)ch_q V` 里 `q⁰` 项的系数 | **显式**：`p_{(24)}(1 − p·p/2)`，外加「`1 − p·p/2` 为非负整数否则为 `0`」的分段 |
| 是否用到 `D = 26` | 只通过 §2.1 的常设假设 `π(c) = 26·Id_V`（相对复形与 `d² = 0` 的前提）；**语句里不出现 `D`** | 紧邻上一句逐字「so that `D = 26`」 |

⇒ **§1.4 表格那句转述在内容上没错，但漏掉了 Prop 2.4 对 `V` 的三条假设**，因此看上去像 Thm 2.7 的重复。
补上这三条后分工就清楚了：**Prop 2.4 负责「一般 `ℒ⁻`-free Hermitian 模上消灭 + 维数 = Euler 特征标的常数项」，
Thm 2.7 负责「把它用到 `V(E,p)` 上，并把那个常数项算成 `p_{(24)}(1 − p·p/2)`」。**
⚠ 由此还得到一条：**「`i ≠ 0` 消灭」这条结论并不需要 `p ≠ 0`**——`p ≠ 0` 只在**验证 `V(E,p)` 确为 `ℒ⁻`-free**（Prop 2.6(i)）时才被用到。
凡建「相对上同调消灭」的卡，量词应挂在 `ℒ⁻`-freeness 上，`p ≠ 0` 是它在 Fock 模情形的**充分条件**，不是消灭定理本身的假设。

#### 9.9.3 Prop 2.4 自身的依赖（原文明写，逐字在其紧邻上文）

> 「To solve the problem of the equivalence of the gauge-invariant and the light-cone formulations of string theory,
> one has to find the cohomology groups `H^m(ℒ, ℒ₀; V)`, where `V` is the Fock module defined in **Section 2.2**.
> Let us consider a general `ℒ⁻`-free, Hermitian `ℒ`-module `V`. **Then by *Theorem 1.12* all nonzero degree cohomology
> groups vanish. To find the dimension of the zero degree cohomology group we apply the Euler–Poincaré principle.**
> The formal Euler character is
>
> `ch_q V · Σ_{m∈Z} (−1)^m ch_q Λ^m_∞ = q^{−1} φ²(q) ch_q V`   **[2.3]**
>
> where `φ(q) = Π_{n≥1}(1 − q^n)`. We denote by `p_{(D)}(n)` the coefficient of `q^n` in `φ(q)^{−D}`,
> so that `p_{(1)}(n)` is the classical partition function. **This implies the following.**」

⇒ **`Prop 2.4` = `Theorem 1.12`（消灭）+ `Proposition 1.3`（Euler–Poincaré），别无其他输入**；
强度措辞是「**This implies the following**」，**Prop 2.4 自身不另给证明**。
⇒ 这一段还**给出了 `p_{(D)}(n)` 的定义**（`φ(q)^{−D}` 中 `q^n` 的系数）。
**图里若建 Thm 2.7(ii) 的维数公式卡，`p_{(24)}` 的定义出处是这里（p.8445 左栏），不是 Thm 2.7 处。**
注意 `p_{(1)}` 才是通常的分拆函数，`p_{(24)}` 是 24 个横向振子的多重分拆。

#### 9.9.4 ★ 对 §9.3「Thm 2.7 的四条依赖」的修正：这四条**不是互相独立的**

§9.3 逐字记下 FGZ 自列的依赖是「**Theorem 1.12**, **Proposition 1.3**, **Proposition 2.4**, and the first part of
**Proposition 2.6**」。本轮核实 Prop 2.4 后可见：**`Prop 2.4` 本身就是由 `Thm 1.12` + `Prop 1.3` 推出的**（9.9.3）。
⇒ 这份依赖清单**在逻辑上冗余**：前两条既直接进入 Thm 2.7，又经 Prop 2.4 间接进入。

对 curator 的两条后果：
1. 按 §9.3 建的四条**实边仍然正确**（原文明写，不必标 `inferred`），
   但**不得解读成「Thm 2.7 用了四个互相独立的输入」**；`Thm 2.7 → Thm 1.12` 与 `Thm 2.7 → Prop 2.4 → Thm 1.12`
   是**同一条论证的两次记账**。
2. 若工具要算「最小依赖集」或做猜想计数，**`Thm 1.12` 与 `Prop 1.3` 不应被计两次**。
   （这正是本项目「每条边都要有来源」与「状态沿图传播」之间的一个典型张力：原文写了什么边 ≠ 最小边集。）

#### 9.9.5 本轮顺带复核、结论未变的两条（同页）

- **`Prop 2.6` 与其后的 Remark**（「**not in general a direct sum of Verma modules** … As a counterexample one can
  choose the case in which `p·p` is a nonpositive even integer.」）——与 §9.6 第二条逐字一致，**复核无误**。
- **`Theorem 2.5`**（`H^m_∞(ℒ, 𝖟; V) ≅ H⁰(ℒ, ℒ₀; V)` for `m = ±1/2`，其余为零）——与 §9.4 一致，**复核无误**。

#### 9.9.6 negative evidence（仅覆盖 p.8445）

- **`Prop 2.4` 的语句里不出现 `p`、不出现 `D`、不出现号差、不出现 "ghost"**。
- **`Prop 2.4` 不带独立证明**：它的证明就是上方那两句（`Thm 1.12` + Euler–Poincaré），原文用「This implies」一笔带过。
- 同页**没有**把 `Prop 2.4` 与 `Kato–Ogawa` 或任何物理文献联系起来；p.8445 左栏末的物理归属句
  （refs 8/9 = Goddard–Thorn / Brower）是挂在**号差 `(D−1,1)` 那句**上的，不是挂在 Prop 2.4 上。

### 9.10 ★ 第三轮复核（2026-09-11，researcher）——`Theorem 2.7(ii)` 与 `p_{(D)}(n)` 定义逐字 + **`Prop 2.6(i)` 的证明也靠 Kac 行列式**

> 触发（lead）：图里要为 `Thm 2.7(ii)` 的维数公式单独建卡（§9.7 的建议），需要 (a) 分段子句的逐字、
> (b) `p_{(D)}(n)` 定义的逐字与准确位置。
> 取件：**本轮重新独立落盘同一张页图** `cdn.ncbi.nlm.nih.gov/pmc/blobs/a950/386946/275fe5e6b989/pnas00326-0018.png`
> （137.5 KB，`Read` 读图；期刊 **p.8445 = 扫描页 `-0018`**）。⚠ 注意：本轮**直接 fetch cdn 域成功**，
> 不必先走 `pmc.ncbi.nlm.nih.gov/articles/instance/386946/bin/…` 那一跳（§9.8 记的 301 中转可省）。
> 本节只追加，不改 §9.1–§9.9 任何一行。证据等级 **L1**。

#### 9.10.1 `Theorem 2.7` 逐字（第二次独立 L1 读取）——**与 §9.1 逐字一致，无更正**

> **THEOREM 2.7.** *Suppose* `p ≠ 0`. *Then* (i) `H^i_∞(ℒ, ℒ₀, V(E, p)) = 0`, `i ≠ 0`, *and* (ii) `dim H^0_∞(ℒ, ℒ₀, V(E, p)) = p_{(24)}(1 − p·p/2)`, *if* `1 − p·p/2` *is a nonnegative integer and* `0` *otherwise*.

**(ii) 的分段子句读法（本轮专门确认）**：原文是**一个 `if … and … otherwise` 的后置从句**，
`0` 在 "and" 之后、"otherwise" 之前 —— 即：**当 `1 − p·p/2` 是非负整数时维数为 `p_{(24)}(1 − p·p/2)`，否则维数为 `0`**。
⚠ **不要写成「`p_{(24)}(n)` 在 `n` 非非负整数时定义为 0」**——那是把分段挂到了 `p_{(D)}` 的定义上；
原文的分段挂在**维数**上，`p_{(D)}(n)` 的定义（见 9.10.2）**只对 `φ(q)^{−D}` 的 `q^n` 系数而言，不含分段**。

⚠ **一条此前未记的排版不一致（转录必读）**：同一页上
- `Proposition 2.4` / `Theorem 2.5` 写 **`H^m_∞(ℒ, ℒ₀; V)`**（**分号**）；
- `Theorem 2.7` 写 **`H^i_∞(ℒ, ℒ₀, V(E, p))`**（**逗号**）。

两种写法都是原文，**照抄时不要统一**；本项目 `loc` 引用建议随原文。

#### 9.10.2 ★★ `p_{(D)}(n)` 的定义逐字（p.8445 **左栏**，`Eq. [2.3]` 正下方）

> 「… To find the dimension of the zero degree cohomology group we apply the Euler–Poincaré principle. The formal Euler character is
>
> `ch_q V · Σ_{m∈Z} (−1)^m ch_q Λ^m_∞ = q^{−1} φ²(q) ch_q V`,   **[2.3]**
>
> where `φ(q) = Π_{n≥1}(1 − q^n)`. **We denote by `p_{(D)}(n)` the coefficient of `q^n` in `φ(q)^{−D}`, so that `p_{(1)}(n)` is the classical partition function.** This implies the following.」

**四条读数：**

1. **定义位置确认：`p_{(D)}(n)` 定义在 `Prop 2.4` 的紧邻上文、`Eq. [2.3]` 的正下方一句，属 p.8445 左栏。**
   **不在 `Theorem 2.7` 处**（Thm 2.7 在右栏下部）。⇒ 维数公式卡的 `p_{(24)}` 定义引用应写
   `loc: p. 8445, left column, the sentence following Eq. [2.3]`。与 §9.9.3 的记录**一致，已核**。
2. **`φ(q) = Π_{n≥1}(1 − q^n)`**（原文给出，就在 [2.3] 之后）。⇒ `p_{(D)}(n)` = `Π_{n≥1}(1−q^n)^{−D}` 展开中 `q^n` 的系数。
3. **`p_{(1)}(n)` 才是经典分拆函数**（原文明写 "the classical partition function"）。
   ⇒ `p_{(24)}` 是 **24 重分拆**（24 个横向振子），**不是**通常的 `p(n)`。建卡时公式里必须保留下标 `(24)`。
4. **`[2.3]` 的标号是方括号**（FGZ 全文用 `[N.M]` 式号，正文引用时写 "Eq. **2.3**" 不带括号）。
   ⇒ 引用一律写 `Eq. [2.3]` 或 `Eq. 2.3`，**不要写 "equation (2.3)"**（与 §9.9.1 注记 2 一致）。

#### 9.10.3 ★★★ 本轮新发现：**`Proposition 2.6(i)`（`ℒ⁻`-freeness）的证明也建立在 Kac 行列式之上**

`Thm 2.7` 自列的四条依赖里有 **`Prop 2.6` 的第一部分**（§9.3）。本轮读到了 `Prop 2.6` 后面那段证明梗概的逐字（p.8445 右栏），
此前只记了「`Prop 2.6(ii)` 的横向空间构造引用 Kac 行列式（refs 10, 11）」（§9.7 末行），**低估了 Kac 行列式的作用范围**：

> 「The subspace `T` is called the **transversal space** and can be constructed explicitly using the spectrum-generating algebra (**9**). Here we will indicate another proof of the proposition based on a more detailed study of the structure of `V(E, p)`. We note first that if `E = E' ⊕ E''` is an orthogonal decomposition of `E` into two nondegenerate subspaces and `p = p' + p''` is the corresponding decomposition of `p`, then we have a canonical isomorphism of the Hermitian ℒ-modules. `V(E, p) ≅ V(E', p') ⊗ V(E'', p'')`. We choose the decomposition such that `E'` and `E''` have signatures `(D − 1, 0)` and `(0, 1)`, respectively, and `p' ≠ 0`, `p'' ≠ 0`. **Then by Kac's determinant formula (10, 11) we know that the Verma modules `M(h, c)` are irreducible and unitary for `h > 0`, `c > 1` and are irreducible and nonunitary for `h < 0`, `c = 1`.** This implies isomorphisms for `D > 2`
>
> `V(E', p') ≅ ⊔_{k≥0} p_{(D−1)}(k) M(p'·p'/2 + k, D − 1)`
> `V(E'', p'') ≅ M(p''·p''/2, 1)`.
>
> **We conclude from the above that `V(E, p)`, `p ≠ 0`, is a free ℒ⁻-module (in fact for any `r ≥ 2` or `s ≥ 1`).** We choose `T` to be
>
> `T = ⊕_{k≥0} p_{(D−2)}(k) M(p'·p'/2 + k, D − 1)^{ℒ⁺} ⊗ M(p''·p''/2, 1)^{ℒ⁺}`.   **[2.4]**」

**对图的四条后果：**

1. ★★ **`Prop 2.6(i)`（自由性）与 `Prop 2.6(ii)`（横向空间 `T`）共用同一段证明，而这段证明的核心输入是 Kac 行列式（refs 10, 11）。**
   ⇒ §9.7 末行「**若**图里 Kac 行列式那条链未建，需在 note 里写明」的适用范围要**扩大**：
   它不只影响 `Prop 2.6(ii)`，而是**影响 `Thm 2.7` 本身**（因为 `Thm 2.7` 明写依赖 `Prop 2.6` 的第一部分）。
   **`fgz-1986, Theorem 2.7` 的 `rigorous` 判定必须把 Kac 行列式算作上游依赖。**
2. ★ **这与 `lian-zuckerman-1989` 的超弦版结构完全平行**：LZ 的 `Corollary 2.19(iii)`（`V(p,κ)` 是 `Vir_κ⁻`-free）
   同样只由「不可约分解」两条显式方程 (24)(25) 推出，而那两条同样由 Kac 行列式（LZ 的 [22] = Meurman–Rocha）给出。
   见 `extractions/lian-zuckerman-1989.md` **§9.3–§9.4**。⇒ **玻色与超弦两条链在「自由性 ← Kac 行列式」这一点上同源，
   curator 可以建两条结构相同的边。**
3. **FGZ 明说自由性比洛伦兹号差更一般**：括注逐字 "(in fact for any `r ≥ 2` or `s ≥ 1`)"（`r` = 正号数、`s` = 负号数，
   见 §2.2 「signature `(r, s)`, `r` pluses and `s` minuses, `r + s = D`」）。⇒ **`Prop 2.6(i)` 的卡不必写死号差 `(D−1,1)`**；
   号差 `(D−1,1)` 与 `D ≥ 2` 是 `Prop 2.6` **陈述**里的量词，而正文的这句括注给出了更宽的成立范围（**原文自陈，非推断**）。
4. **`[2.4]` 是 `T` 的显式构造式**（两个 Verma 模的 `ℒ⁺`-不变子空间的张量积，重数 `p_{(D−2)}(k)`）。
   ⇒ §9.5 说的「显式代表元用 `Prop 2.6` 的第二部分」，其显式形式就是 `[2.4]`，可直接作为「横向空间 `T`」卡的 `statement`。
   注意 `V(E', p')` 的重数是 `p_{(D−1)}(k)`，而 `T` 的重数是 **`p_{(D−2)}(k)`**——**两个下标不同，别抄混**。

#### 9.10.4 本轮顺带逐字取得的一条（此前未记）：FGZ 的「物理空间」定义含**截距 `a = 1`**

紧接 `Thm 2.7` 之后的两句之后（p.8445 右栏末，跨到 p.8446）：

> 「We let `P = P(R^{25,1}, p) = {v ∈ V(R^{25,1}, p) : π(L_n)v = δ_{0,n}v, n ≥ 0}`. `P` is called the **physical space**. Define a map `κ: V →` …」

⇒ **`π(L_0)v = v`，即 `L_0` 本征值 = 1 = 玻色弦截距 `a = 1`，是 FGZ 写在物理空间定义里的**（用 `δ_{0,n}` 表达），
而**不是**某处额外声明的假设。⚠ 与 `lian-zuckerman-1989` 的 `Definition 2.16` 对照：LZ 写 `π(L_n)v = δ_n κv`，
即超弦截距 `= κ`（NS 为 ½、R 为 0）。**两篇的截距都藏在物理空间的定义式里，建卡时必须显式写出来。**
（⚠ 本行只覆盖到 p.8445 末可见的部分，`map κ` 之后的内容在 p.8446，本轮未复读。）

#### 9.10.5 转录疑点（本轮新增一条，引用前须复核）

- **`Prop 2.6(ii)` 的特征标印作 `ch_q T = q^{p·p/2} φ(q)^{D−2}`（§9.2 第 5 行的记录与本轮读数相同）。**
  **但同页左栏的 `ch_q(V(E, p)) = q^{p·p/2} φ(q)^{−D}` 带明确的负号**，而 `Thm 2.7(ii)` 的答案是 `p_{(24)}(·)`
  = `φ(q)^{−24}` 的系数（`D = 26` 时 `D − 2 = 24`）。
  ⇒ **`φ(q)^{D−2}` 的指数前很可能丢了一个负号**（应为 `φ(q)^{−(D−2)}`）。
  **本记录不改写原文读数**，只标为**高度可疑的扫描/排印失真**；凡把 `Prop 2.6(ii)` 的特征标写进 `statement` 的，
  **请 auditor 用同一张页图复核该指数的负号**。（同型陷阱：`Prop 2.4` 的 `ℒ⁻` 上标减号极小，见 §9.9.1 注记 1。）

#### 9.10.6 negative evidence（仅覆盖 p.8445）

- **`p_{(D)}(n)` 的定义句里没有任何分段条件**；分段（"nonnegative integer … otherwise 0"）**只出现在 `Thm 2.7(ii)` 的维数陈述里**。
- **`Thm 2.7` 的陈述里不出现 "no-ghost"、不出现 "ghost number"、不出现 `a = 1` 或 "intercept"**（截距在 p.8445 末 `P` 的定义里，见 9.10.4）。
- **本页不出现 `Theorem 2.8`（无鬼定理）**——它在 p.8446，见 §1。

#### 9.10.7 访问日志（本节）

| 目标 | URL / 手法 | 结果 |
|---|---|---|
| FGZ p.8445 | `cdn.ncbi.nlm.nih.gov/pmc/blobs/a950/386946/275fe5e6b989/pnas00326-0018.png`（**直接 fetch cdn，未走 `articles/instance/…` 的 301 中转**） | ✅ 137.5 KB PNG 落盘，`Read` 读图，整页两栏可辨 |

---

### 9.11 ★★ `Proposition 1.3`（Euler–Poincaré principle）逐字 + **证明没有印出**（2026-09-11 第五轮，researcher 页图 pp.8443–8444）

> 触发（lead）：`Thm 2.7` 与 `Prop 2.4` 都把 Euler–Poincaré 原理列为依赖（见 §9.3、§9.9），
> 但图上这条一直只有「Proposition 1.3」这个编号，**没有逐字、没有量词、也不知道 FGZ 有没有证它**。
> 取件：`pmc.ncbi.nlm.nih.gov/articles/instance/386946/bin/pnas00326-**0016**.png`
> **301 →** `cdn.ncbi.nlm.nih.gov/pmc/blobs/a950/386946/**89ec636e8478**/pnas00326-0016.png`（125.1 KB PNG）＝ **期刊 p.8443**；
> 以及 `…-**0017**.png` **301 →** `…/**95f41eb23281**/pnas00326-0017.png`（124.0 KB）＝ **期刊 p.8444**。
> ⚠ **blob hash 逐页不同，不能从 `-0018` 的 `275fe5e6b989` 推**（本轮先用旧 hash 猜 `-0017` 得 404，才回去走 301）。
> **对照表（已证实）**：期刊 p.8443 = 扫描页 `-0016`，p.8444 = `-0017`，p.8445 = `-0018`，p.8446 = `-0019`。证据等级 **L1**。

#### 9.11.1 ★★★ `Proposition 1.3` 逐字（**期刊 p.8443，左栏最下方**）

> 「**PROPOSITION 1.3.** *For* `V` *in* `𝒪₀`, `Σ_m (−1)^m ch_q(V ⊗ Λ^m_∞) = Σ (−1)^m ch_q H^m_∞(g, V)`.」

**四条读数：**

1. ★ **唯一的量词是 `V ∈ 𝒪₀`**（不是 `𝒪`）。`𝒪₀` 的定义在同页左栏上方：先对 `Λ^{m,n}_∞` 说明
   「dim `Λ^{m,n}_∞` `< +∞` for every `n ∈ Z` and for some `n₀ ∈ Z` is 0 for `n > n₀`」，
   随即逐字「**The g-modules with these properties compose a category `𝒪₀`.**」
   （同页紧接着定义更大的 `𝒪 ⊃ 𝒪₀`：「consisting of graded g-modules `V` with the property that the `n₊`-submodule
   generated by any vector from `V` is finite-dimensional」）。
   ⇒ **建卡时 `𝒪₀` 必须展开成「每个分次层有限维 + 分次在上方有界」，不能只写类别名**；
   这与 LZ 1989 `Definition 2.12` 对 `sign/char` 的两条前提（见 `lian-zuckerman-1989.md` §10.2）**逐点同型**。
2. ★★ **陈述是「特征标层面的交错和相等」，不是「维数的交错和相等」。** 左端是**复形** `V ⊗ Λ^m_∞` 的 `ch_q` 交错和，
   右端是**上同调** `H^m_∞(g,V)` 的 `ch_q` 交错和。`ch_q` 的定义在 Prop 1.3 正上方一句，逐字：
   「Define `ch_q H^m_∞(g, V) = Σ_n dim H^{m,−n}_∞(g, V) q^n`.」
   （`ch_q V = Σ_n dim V^{−n} q^n` 在同页更上方，与 `𝒪₀` 的定义同段。）
   ⇒ **`q` 是分次变量，交错和是逐 `q` 幂次成立的**；Thm 2.7(ii) 的「取 `q⁰` 系数」那一步（见 §9.9）正是用这一点。
3. ★★★ **Prop 1.3 的证明没有印出。** 紧随其后的一句逐字是
   「Let `θ(x) = π(x) + ρ(x)`, `x ∈ g`; then one has the following.」→ 直接进入 **`PROPOSITION 1.4`**。
   **Prop 1.3 与 Prop 1.4 之间没有 `Proof`、没有 "□"、没有 "see ref. N"、没有 "straightforward"。**
   本轮通读 p.8443 全页与 p.8444 全页（两栏），**没有在别处补证**（p.8444 的编号序列是 Prop 1.8 → Thm 1.9 →
   §1.3 → Prop 1.10 → Prop 1.11 → Prop 1.11′ → Thm 1.12 → §2 → Prop 2.1 → Prop 2.2 → Prop 2.3，无回补）。
   ⇒ **`fgz-1986` 作为 Euler–Poincaré 原理的来源，只能给「陈述 + 编号」，给不了证明。**
   建卡时 status 判定应据此收紧；若要 `rigorous` 需另挂一条数学侧来源
   （现成候选：**Hatcher `Theorem 2.44`, p. 146**，见 `sources.bib` 的 `hatcher-2002`，那里连证明带引理都印全了）。
4. **引出句逐字（Prop 1.3 正上方）**：「The Euler–Poincaré principle for each graded level can be contained in the
   following statement.」⇒ **"Euler–Poincaré principle" 这个名字是 FGZ 自己在此处给出的**（`Thm 2.7` 上方那句
   「the Euler–Poincaré principle (**Proposition 1.3**)」与之呼应，见 §9.3），**归属自洽，不必 inferred**。
   ⚠ 转录疑点：`can be contained` 读起来不像标准英文，疑为 `is contained` 或 `can be couched`；
   扫描件此处字迹偏细。**这句只作旁证，不要写进 `statement`。**

#### 9.11.2 Prop 1.3 的上下文（p.8443 左栏，同段逐字，建卡需要）

> 「Assume `V` is a graded module in `𝒪₀`. The formula `deg(v ⊗ ω) = deg(v) + deg(ω)`, `ω ∈ Λ*_∞`, `v ∈ V`, turns
> `V ⊗ Λ*_∞` into a graded space, finite-dimensional in each level. It follows from the definition of `d` that it preserves
> the graded structure of `V ⊗ Λ*_∞`. Thus, the cohomology groups are graded spaces, finite-dimensional in each level:
> `H^m_∞(g, V) = Π_n H^{m,n}_∞(g, V)`.」

⇒ ★ **「每层有限维」不是 Prop 1.3 的额外假设，而是由 `V ∈ 𝒪₀` 推出的**（原文明写「turns `V ⊗ Λ*_∞` into a graded space,
finite-dimensional in each level」）。⇒ 图上不必给 Prop 1.3 再补一条「有限维」前提，`𝒪₀` 已经包住。
⚠ 但**上同调是无穷乘积 `Π_n` 不是直和**——这是 semi-infinite 上同调的特有现象，转述时别写成 `⊕`。

#### 9.11.3 同页顺带取得的两条（**此前图上只有编号，无逐字**）

**(a) `Proposition 1.2`（p.8443 左栏中部）逐字**：

> 「**PROPOSITION 1.2.** `d² = 0`.」

紧随其后逐字：「Thus `{V ⊗ Λ*_∞, d}` is a complex. The cohomology of this complex will be called the semi-infinite
cohomology of the graded Lie algebra `g` with coefficients in the graded `g`-module `V` and will be denoted by
`H*_∞(g; V)`. If `[g, g] = g`, then the semi-infinite cohomology and the representation `ρ` do not depend on the choice
of basis in `g` and the vacuum `ω₀ ∈ Λ*_∞`. This complex was introduced by **Feigin (1)**.」
且 Prop 1.2 **正上方**是微分的显式定义 **[1.3]**：`d = Σ_i π(e_i)ε(e'_i) + Σ_{i<j} ι([e_i,e_j])ε(e'_i)ε(e'_j) : + ε(β)`。

⇒ ★ **这一条复核了旧记录「FGZ 的 `d² = 0` 是 `Proposition 1.2`、一句话、不含 26」（见本文件 §1.2）**，**无更正**。
⇒ ⚠ **编号陷阱**：**微分的定义式印作 `[1.3]`（方括号），而 Euler–Poincaré 原理是 `Proposition 1.3`（无括号）。
同一页上 `1.3` 既是式号又是命题号**，且 FGZ 全篇式号一律用方括号（`[1.4]`、`[1.5]`、`[2.1]`…）。
**引用时必须写全类型词**（同型陷阱：p.8446 的 `Proposition 2.8` vs `Theorem 2.8`，见 §1）。

**(b) `Theorem 1.12`（p.8444 右栏上部，= `Thm 2.7` 自列依赖之一）逐字**：

> 「**THEOREM 1.12.** *If* `V` *is an* `n₋`*-free module, is in* `𝒪₀`, *and has a nondegenerate Hermitian form, then*
> `H^m_∞(g, g₀; V) = 0` *for* `m ≠ 0`.」

⇒ ★★ **三条假设并列且全部显式：`n₋`-free + `∈ 𝒪₀` + **nondegenerate Hermitian form**。**
此前本文件只记了 `Thm 1.12 = 一般消灭定理`（§1.4），**没有记这三条假设**，其中「非退化厄米型」这条尤其重要——
它使 **FGZ 玻色侧与 LZ 1989 超弦侧在结构上再次逐点同型**（LZ 的非退化性出处见 `lian-zuckerman-1989.md` §10.1）。
⚠ 转录：`n₋` 的下标减号极小（同 §9.9 记的 `ℒ⁻` 陷阱）；`H^m_∞(g, g₀; V)` 此处用**分号**。

#### 9.11.4 negative evidence（覆盖 p.8443 全页 + p.8444 全页）

- **Prop 1.3 不出现 `D`、不出现 `26`、不出现 `p`、不出现任何弦论词汇**——它是纯粹的分次李代数半无穷上同调陈述。
  ⇒ 图上这条卡应归到 `math.*` 或代数侧命名空间，**不要挂 `worldsheet.*` 的物理前提**。
- **Prop 1.3 不引任何参考文献编号**（同页 Prop 1.2 后引了 `Feigin (1)`，Prop 1.3 处没有）。
- p.8443–8444 **不出现 "ghost"、不出现 "BRST" 以外的物理术语**；`BRST` 首次出现在 p.8444 右栏
  §2.1 标题「The Virasoro Algebra and the Bechi–Rouet–Stora–Tyutin (BRST) Complex」
  （⚠ **原刊把 Becchi 印作 "Bechi"**，少一个 `c`）。
- 本轮**未见 Prop 1.3 在后文被再次引用**（除 §9.3 已记的 `Thm 2.7` 上方那句、与 §9.9 已记的 `Prop 2.4` 证明里那句）。

#### 9.11.5 对图的建议（researcher 不改 `graph/`，仅列）

| 建议 | 内容 |
|---|---|
| Euler–Poincaré 卡的 `loc` | **`Proposition 1.3, p. 8443`**（逐字见 9.11.1），read_depth L1 |
| 量词 | **只有 `V ∈ 𝒪₀`**；`𝒪₀` 须展开为「每层有限维 + 分次上方有界」（同页定义），**不要额外补「有限维」** |
| status | ⚠ **FGZ 不印证明** ⇒ 仅凭 `fgz-1986` 不足以判 `rigorous`；建议同卡并挂 **`hatcher-2002` `Theorem 2.44`, p. 146**（有完整证明）作第二来源，或标注 gap |
| ⚠ 引用格式 | 必须写 `Proposition 1.3`；**`[1.3]` 是同页的微分定义式，不是本命题** |
| 顺带可升级的卡 | `Theorem 1.12` 的三条假设（`n₋`-free / `∈ 𝒪₀` / **非退化厄米型**）现有逐字，见 9.11.3(b)；`Proposition 1.2`（`d²=0`）逐字亦已取得 |

#### 9.11.6 访问日志（本节）

| 目标 | URL / 手法 | 结果 |
|---|---|---|
| FGZ p.8443 | `pmc.ncbi.nlm.nih.gov/articles/instance/386946/bin/pnas00326-0016.png` **301 →** `cdn.ncbi.nlm.nih.gov/pmc/blobs/a950/386946/89ec636e8478/pnas00326-0016.png` | ✅ 125.1 KB PNG，两栏全可辨 |
| FGZ p.8444 | 同法 **301 →** `…/95f41eb23281/pnas00326-0017.png` | ✅ 124.0 KB PNG，两栏全可辨 |
| （失败）用 `-0018` 的 hash 猜 `-0017` | `cdn.ncbi.nlm.nih.gov/pmc/blobs/a950/386946/**275fe5e6b989**/pnas00326-0017.png` | ❌ HTTP 404 ⇒ **hash 逐页不同，必须走 301**（推翻 §9.10.7 记的「可省掉 301 中转」——那只对已知 hash 的同一页成立） |

---

## 10. ★★ FGZ 参考文献表全 14 条逐字（p.8446，2026-09-11，researcher 第四轮页图）

> 触发（lead 派工单第 2 项）：「抄 FGZ 参考表 refs 10、11 条目逐字（PNAS p.8446）」，为的是给玻色 Kac 行列式定上游。
> 取件：`pmc.ncbi.nlm.nih.gov/articles/instance/386946/bin/pnas00326-**0019**.png`
> **301 →** `cdn.ncbi.nlm.nih.gov/pmc/blobs/a950/386946/**2d14d6150a94**/pnas00326-0019.png`（133.5 KB PNG，`Read` 读图）。
> ⚠ **页映射与 hash 两条新坐标**：**期刊 p.8446 = 扫描页 `-0019`**（与 §9 记的「p.8445 = `-0018`」相容，偏移 8427）；
> **但 hash 段 `275fe5e6b989` 只对 `-0018` 有效** —— `-0019` 的 hash 是 **`2d14d6150a94`**，
> 直接把 `-0018` 的 URL 改个页号会 **HTTP 404**（本轮实测）。⇒ **hash 是每页一个，不能类推；必须走 `articles/instance/…` 拿 301。**
> 只追加，不改 §1.5 任何一行。证据等级 **L1**。

### 10.1 ★★★ 派工单的前提被推翻：**FGZ 的 refs 10、11 不是「Kac 1979 / Kac–Wakimoto」**

派工单写「**Kac 1979 / Kac–Wakimoto**（FGZ refs 10, 11：玻色 Kac 行列式）」。**页图逐字显示不是。**

> 「10. Kac, V. (1978) *Proceedings of the International Congress of Mathematicians* (ASF, Helsinki, Finland), Vol. 1, pp. 299–304.」
>
> 「11. Feigin, B. & Fuks, D. (1982) *Funkt. Anal. Prilozheniya* **16**, 47–63 (English translation: *Functional Analysis and Its Application* **16**, 114–126).」

⇒ **FGZ ref 10 = Kac 的 ICM Helsinki 那篇（本 bib 的 `kac-1980-icm`），ref 11 = Feigin–Fuchs 1982（本 bib 的 `feigin-fuchs-1982`）。**
⇒ **FGZ 全表 14 条里没有 Kac–Wakimoto，也没有 LNP 94（`kac-1979`）。**
⇒ 混淆的来源几乎可以肯定是 **`lian-zuckerman-1989` 的 `[9]`/`[10]`**：LZ 那边才是
`[9] = Kac, Lecture Notes in Phys. vol. 94 (1979)`、`[10] = Kac, Wakimoto`（见 extractions/lian-zuckerman-1989.md §8.3）。
**两篇的编号完全不同，转述前必须分清是 FGZ 的号还是 LZ 的号。**

**三条附带读数：**

1. FGZ 把 ICM 那篇的年份印成 **(1978)**（会议年），而本 bib 的 `kac-1980-icm` 取出版年 **1980**；
   FGZ 另给了 **"Vol. 1"** 这个卷次信息（作者本人出版目录只给 "Proceedings of ICM, Helsinki 1978 (1980), 299-304"）。
   **两种年份都合法，引用时写清取的是哪个。**
2. ref 11 给出的俄文起止页 **47–63** 与本 bib `feigin-fuchs-1982`（Math-Net.Ru 核实的俄文原刊 16:2, 47–63）**逐位一致**；
   英译刊名 FGZ 印作单数 **"Functional Analysis and Its Application"**（通行是 Applications）。
3. ⇒ **§1.5 记的两条（ref 10 = ICM、ref 11 = FF）本轮第二次 L1 确认，无更正。**

### 10.2 全表 14 条逐字（p.8446 右栏下部）

> 「 1. Feigin, B. (1984) *Usp. Mat. Nauk* **39**, 195–196 (English translation: *Russian Math Surveys* **39**, 155–156).
>  2. Kumar, S. (1984) *J. Differ. Geom.* **20**, 384–431.
>  3. Banks, T. & Peskin, M. (1986) *Nucl. Phys. B* **264**, 513–547.
>  4. Witten, E. (1986) *Nucl. Phys. B* **268**, 253–294.
>  5. Kato, M. & Ogawa, K. (1983) *Nucl. Phys. B* **212**, 443–460.
>  6. Griffiths, P. & Harris, J. (1978) *Principles of Algebraic Geometry* (Wiley, New York).
>  7. Koszul, J. L. (1950) *Bull. Soc. Math. France* **78**, 5–127.
>  8. Goddard, P. & Thorn, C. (1972) *Phys. Lett. B* **40**, 235–238.
>  9. Brower, R. (1972) *Phys. Rev. D* **6**, 1655–1662.
> 10. Kac, V. (1978) *Proceedings of the International Congress of Mathematicians* (ASF, Helsinki, Finland), Vol. 1, pp. 299–304.
> 11. Feigin, B. & Fuks, D. (1982) *Funkt. Anal. Prilozheniya* **16**, 47–63 (English translation: *Functional Analysis and Its Application* **16**, 114–126).
> 12. Wallach, N. (1984) *Invent. Math.* **78**, 131–141.
> 13. Frenkel, I. (1985) *Lect. Math. Appl. Math.* **21**, 325–353.
> 14. Borcherds, R. (1986) *Proc. Natl. Acad. Sci. USA* **83**, 3068–3071.」

**对图有用的五条：**

1. **[1] = Feigin 1984（Usp. Mat. Nauk 39, 195–196）** —— 与本 bib 的 `feigin-fuchs-1984`
   （Funct. Anal. Appl. 17(3) 241–242）**不是同一篇**；FGZ 的 [1] 是 Feigin **单作者**的那篇 Uspekhi 短文。
   ⚠ 本 bib 目前**没有**这一条，且 `feigin-fuchs-1984` 的 note 里也没提到它 —— **是个干净的新增目标（本轮未登记，因内容未核实）**。
2. **[5]/[8]/[9]** 与 §1.5 记录一致（Kato–Ogawa、Goddard–Thorn、Brower），本轮复核无误；
   **注意 FGZ 把 Goddard–Thorn 的卷号印成 `Phys. Lett. B 40`**，而通行著录是 `Phys. Lett. 40B`。
3. **[12] = Wallach, Invent. Math. 78, 131–141 (1984)** —— 正文 p.8446 的 Remark 逐字
   「The reader should compare with **Wallach's argument in ref. 12**」，**这是 FGZ 自己给出的、与其第二个无鬼证明
   最接近的数学对照**，本 bib 未登记。
4. **[14] = Borcherds 1986 PNAS 83, 3068–3071** = 本 bib 的 `borcherds-1986`（同一期刊同一年）。
5. **全表没有 Thorn 1984、没有 Meurman–Rocha-Caridi、没有 Kac–Kazhdan、没有 Kac LNP 94。**
   ⇒ **FGZ 的玻色 Kac 行列式上游只有两条：[10] ICM + [11] Feigin–Fuchs。**
   这与 `meurman-rocha-caridi-1986` 的证词（[13] ICM + [14] LNP 94 都有该公式）**不冲突但不重合**：
   **FGZ 不引 LNP 94，MRC 引两篇**。详见 extractions/math-sources.md §55.5。

### 10.3 顺带：p.8446 正文里此前未转录的两句（L1，与 `Theorem 2.8` 同页）

> 「The second isomorphism of **Theorem 2.8** is known as the no-ghost theorem in the physics literature (**8, 9**).
> (The reader should compare our arguments for **Theorems 2.7 and 2.8** with the different arguments in **ref. 5**.)」

⇒ (a) **FGZ 把「无鬼定理」这个名字归给物理文献 (8, 9) = Goddard–Thorn 1972 与 Brower 1972**（逐字，L1）；
(b) **FGZ 自陈其 Thm 2.7/2.8 的论证与 ref. 5 = Kato–Ogawa 1983 的论证「different」** ——
这是「FGZ 与 KO 是两条独立推导」的**作者自证**，可直接支撑图里两条并列 derivation。

> 「The signature (25, 1) is very special because of the no-ghost theorem, but there is also an amazing coherence
> between the Hermitian structure of the ℒ-modules `V(R^{25,1}, p)` and `Λ^∞_*(ℒ/ℒ₀)`.」

⇒ **FGZ 明确把号差写成 `(25, 1)`**（与 §9.2 记的 `(D−1, 1)` 一致，`D = 26`）。

### 10.4 negative evidence（仅覆盖 p.8446）

- **全页不出现 "Kac determinant" 字样**；Kac 行列式只以 refs 10/11 的形式出现在参考表里（正文引用点在 p.8445 的 `Prop 2.6` 证明，见 §9.10.3）。
- **全页不出现 Kac–Wakimoto、不出现 Meurman、不出现 Rocha-Caridi。**
- 致谢段逐字提到 **「the workshop on "Superstring Theories and the Mathematical Structure of Infinite-Dimensional Lie Algebras"」**
  与 **E. Witten** 的一条具体贡献：「**In particular he first noticed that the vanishing theorem does not hold in the exceptional case.**」
  ⇒ **`p = 0` 例外情形的发现权，FGZ 自己归给 Witten**（对照：`lian-zuckerman-1989` `Prop 5.5` 是超弦版的例外情形）。

### 10.5 访问日志（本节）

| 目标 | URL / 手法 | 结果 |
|---|---|---|
| FGZ p.8446（首试，按 `-0018` 的 hash 类推） | `cdn.ncbi.nlm.nih.gov/pmc/blobs/a950/386946/275fe5e6b989/pnas00326-0019.png` | ❌ **HTTP 404**（hash 不能跨页类推） |
| FGZ p.8446（改走 301 中转） | `pmc.ncbi.nlm.nih.gov/articles/instance/386946/bin/pnas00326-0019.png` → `cdn…/2d14d6150a94/pnas00326-0019.png` | ✅ 133.5 KB PNG 落盘，`Read` 读图，参考表 14 条全可辨 |

### 9.12 ★ auditor 页图复核（2026-09-12）——`Prop 2.6` 的 `D ≥ 2` / `D > 2` 与 `ch_q T` 指数（结清 §9.10.5）

> 只追加，不改 §9.1–§9.11 任何一行。完整裁决与理由见 `page-check-rulings-2026-09-12.md` §2。取件：同一张 p.8445 页图（`cdn…/275fe5e6b989/pnas00326-0018.png`，直连成功），右栏局部 5×–8× 放大。L1。

- **`D ≥ 2`（语句）与 `D > 2`（梗概「This implies isomorphisms for D > 2」）两处页图均清晰，读数与 §9.10.3 一致。裁定：不是排印不一致。** `D > 2` 是 `V(E′,p′)` Verma 分解的前提（E′ 号差 (D−1,0) ⇒ c = D−1，梗概引用的 Kac 事实要 c > 1）；`D = 2` 由梗概末尾括注 "(in fact for any r ≥ 2 **or s ≥ 1**)" 的 s = 1 分支覆盖（`V(E″,p″) ≅ M(p″·p″/2, 1)` 只用 h < 0, c = 1）。**两处各自正确，卡片的 (H1) `D ≥ 2` 不改。**
- **`ch_q T = q^{p·p/2}φ(q)^{D−2}`：8× 放大后 `D` 前确无负号；同页 `ch_q V(E,p) = q^{p·p/2}φ(q)^{−D}` 的 `−D` 清晰，排除扫描丢字。裁定：原刊排印漏负号，正确为 `φ(q)^{−(D−2)}`。** 三条内证：φ^{D−2} 有负系数不能是特征标；由 [2.4] 直接算得 Σ_k p_{(D−2)}(k) q^{p·p/2+k}；Thm 2.7(ii) 的 p_{(24)} 是 φ^{−24} 的系数。**引用纪律：loc 逐字保留 `φ(q)^{D−2}` 并注「原刊漏负号」；statement 一律写 `φ(q)^{−(D−2)}`。**

