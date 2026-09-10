# 无鬼定理 / 临界维数主线：一手来源第二轮核实

- 负责 agent：researcher
- 日期：2026-09-10
- 触发：`docs/ROADMAP.md`「待裁决」第 3、4 条；`brst-cohomology-sources.md` §2.3、§3.1、§4.1、§6.1 遗留的未解点
- 本文件不套 `templates/extraction.md`，是一次专项核实记录（自建小节），与
  `extractions/brst-cohomology-sources.md` 配套阅读，编号沿用后者的证据等级表

## 0. 证据等级约定（与 `brst-cohomology-sources.md` 一致）

| 等级 | 含义 |
|---|---|
| L1 | 我逐页读了原文（扫描件/正文 PDF），可照抄措辞 |
| L2 | 出版方权威元数据或期刊逐字摘要（Crossref / INSPIRE / Project Euclid / PMC / ADS） |
| L3 | 可溯源二手陈述（作者本人综述、引用该文的公开论文正文） |
| L4 | 检索后端中介读取（WebSearch 摘要读 PDF/网页），**非逐字，不得单独作为唯一依据** |
| L0 | 未能核实 |

**本轮最大变化：`lian-zuckerman-1991` 全文取到并逐页读毕（L1）。** 它同时解决了
ROADMAP 待裁决第 3 条（a<1 分支的文献出处），并**否定**了待裁决第 4 条对该文寄予的另一个期望
（它并不含「Q²=0 ⟺ c=26」）。

> **工具限制声明**：本次会话的 researcher **没有 Bash 工具**，因此
> `git checkout -b agent/researcher/primary-sources` 与 `git commit` **均未执行**。
> 文件已按任务要求写入 worktree
> `D:\physics\string\.claude\worktrees\agent-ae726b0e107be2823\`（当前在 `main` 分支上，工作区未提交）。
> 建分支与提交需由 lead 完成，见本文件 §9。

---

## 1. `lian-zuckerman-1991` — Lian & Zuckerman, *BRST Cohomology and Highest Weight Vectors. I*

**核实状态：已核实（L1，全文 34 页 547–580 逐页读毕）**

### 1.0 获取途径（成功，可复用）

- Project Euclid 文章页 <https://projecteuclid.org/journals/communications-in-mathematical-physics/volume-135/issue-3/BRST-cohomology-and-highest-weight-vectors-I/cmp/1104202143.full>
  自称「There is no online version at this time. Please download the PDF instead.」，页面同时显示
  Open Access 图标与订阅提示（信号混杂）。
- **实际可下载的 PDF 端点**：`https://projecteuclid.org/journalArticle/Download?urlId=cmp%2F1104202143`
  → WebFetch 报「二进制无法解析」但**把 3.1 MB 的 PDF 落盘并打印路径**，再用 `Read` 带 `pages` 逐页读图即可。
  **无需登录、未绕过任何付费墙**，符合 `literature/CLAUDE.md` 规则 1。
- 这条路线对 Project Euclid 上的整批旧 CMP 卷次应当通用（上一轮对 CMP 125(2) 只试了 `.full` 页就放弃了，
  是漏试了 `journalArticle/Download` 端点）。

### 1.1 元数据（L1，取自 PDF 首页页眉与题头）

- 页眉逐字：`Commun. Math. Phys. 135, 547–580 (1991)`，`© Springer-Verlag 1991`
- 标题逐字：`BRST Cohomology and Highest Weight Vectors. I`
- 作者与单位逐字：`Bong H. Lian¹ and Gregg J. Zuckerman²*`；
  1 = Center for Theoretical Physics, Yale University, New Haven, CT 06520, USA；
  2 = Department of Mathematics, Yale University, New Haven, CT 06520, USA
- `Received April 18, 1990`；脚注 `* Partially supported by NSF Grant DMS-8703581`
- 末页 `Communicated by A. Jaffe`
- → 与 bib 中现有的卷/期/页/年/DOI **完全一致**，无需修正。

### 1.2 摘要（L1，逐字）

> **Abstract.** We initiate a program to study certain recent problems in non-compact
> coset CFT by the BRST approach. We derive a reduction formula for the BRST cohomology
> by making use of a twisting by highest weight modules. As illustrations, we apply the
> formula to the bosonic string model and a rank one non-compact coset model [DPL]. Our
> formula provides a completely new approach to non-compact coset construction.

### 1.3 章节结构（L1）

```
0. Introduction                                                   p.547
1. Definitions and Notations                                      p.549
2. Relative Semi-Infinite Cohomology with Coefficients in V₁⊗V₂   p.557
   2.1 The Reduced Complex                                        p.557
   2.2 Main results                                               p.562
   2.3 Important Consequences                                     p.563
3. Examples                                                       p.568
4. Discussions                                                    p.579
   References                                                     p.580
   （无附录）
```
编号体系：`Definition/Proposition/Lemma/Theorem/Corollary/Remark x.y`，两位编号，按章连续。

### 1.4 问题 (a)：是否含「Q² = 0 iff c = 26」？——**没有**（L1，重要否定结论）

这条直接决定 `worldsheet.critical-dimension-brst--via-nilpotency` 能否升级。答案是**不能**。

- **幂零性在 LZ 里是无条件的、且不含 26。** `Proposition 1.11`（p.554）逐字：
  > **Proposition 1.11.** (i) *d*² = 0.
  > (ii) If *V* has a sesquilinear form ⟨,⟩_V such that ⟨π(a)·,·⟩_V = −(−√−1)^s⟨·, π(σ(a))·⟩_V,
  > for *a* ∈ 𝒢^(s) and ⟨V^(0), V^(1)⟩_V = 0, then with respect to ⟨,⟩_{C_∞} := ⟨,⟩_V ⊗ ⟨,⟩_{Ω_∞},
  > we have ⟨d·,·⟩_{C_∞} = ⟨·, d·⟩_{C_∞}.

  这里 `d` 由 `Definition 1.10`（p.554，"cf. [Fe], [FGZ]"）在 `C_∞(𝒢,V) = V ⊗ Ω_∞𝒢` 上给出。
  (i) 的证明是「detailed computation is quite long, we will only sketch how it is done」，
  **对任意 V ∈ 𝒪 成立，没有中心荷条件**。这是 FGZ `Proposition 1.2`（一句 `d² = 0`）的同构版本。
- **26 出现的唯一位置是 `Proposition 3.3`（p.570），而且是「if」不是「iff」。** 逐字：
  > **Proposition 3.3.**
  > (i) (*cf. Proposition 1.8*) H²(𝒢) = 0.
  > (ii) σ(L_n) = −L_{−n}, σ(z) = −z *defines an antilinear automorphism.*
  > (iii) (∧_∞𝒢, η) *is a 𝒢-module if* β̄ = −26z′ − L′₀. *Note that* σ(β̄) = −β̄. *Thus* ∧_∞𝒢 *is hermitian.*
  > (iv) Spec_{∧_∞𝒢} 𝒢₀ = {−26z′ − L′₀ + nL′₀}_{n∈**Z**₊}; *as before, we will identify this set with*
  > {1 − n}_{n∈**Z**₊}, *i.e. the eigenvalues of* −L₀.

  我对 (iii) 的 "if / iff" 做了**单页重读复核**（PDF 第 24 页 = 刊物 p.570），确认排印为 **`if`**，一个方向。
  且 26 在这里是**鬼系统一侧**的量（β̄ 的取值使 2-上循环 γ 为零，见 `Proposition 1.8`），
  与 FGZ `Proposition 2.1(i)` 的 ρ(c) = −26 Id 是同一件事。

- **抽取者解读（不是 LZ 的原文陈述，标为推断）**：LZ 里「物质中心荷 = 26」这一要求进来的地方，
  是**相对复形的定义**而不是幂零性。`Definition 1.12(i)` 定义 θ(x) = π(x) + η(x)；p.556 定义
  相对子复形 `C*_∞(𝒢,𝒜;V) = {ω ∈ C_∞(𝒢,V) : ι(a)ω = 0 = θ(a)ω, ∀a ∈ 𝒜}`，主要取 𝒜 = 𝒢₀ = **C**L₀ + **C**z。
  由 `Definition 1.6` 的 ⟨β̄,x⟩ 项与 (iii) 的 β̄ 得 η(z) = −26，故 θ(z)ω = 0 等价于 π(z) = 26。
  这与 FGZ「we will assume that π(c) = 26 Id_V」结构完全平行。
  **LZ 正文没有把这一步写成一条编号命题，上面这段推导是我的解读，curator 若采用须标 `inferred: true`。**

> **对 curator 的结论**：`brst-cohomology-sources.md` 对 FGZ 的判断在 LZ 1991 上**同样成立**。
> 两篇「数学侧」的 BRST 上同调论文都**不推导** c = 26，而是**为它构造相对复形**。
> `critical-dimension-brst--via-nilpotency` 的 gap 第 1 条把 lian-zuckerman-1991 列为升级候选，
> **该候选现已排除**，应改写（见 §9）。

### 1.5 问题 (b)：是否含「BRST 相对上同调 ≅ 旧协变物理态」的编号定理？——**有，而且不止一条**（L1）

LZ 在 p.568 自己给「无鬼定理」命名并编号（引号是原文的）：

> **Corollary 2.28.** (*"No-ghost Theorem"*) H⁰_∞(𝒢, 𝒢₀; W), W^{𝒢₊}[−β̄]/rad *are unitary
> (positive definite) iff*
> [ ch_q W · q^{−β̄} ∏_{α∈Δ₊} (1−q^α)^{2 dim 𝒢_α^{(0)}} (1+q^α)^{−2 dim 𝒢_α^{(1)}} ]
> = [ sign_q W · q^{−β̄} ∏_{α∈Δ₊} [(1−q^α)(1+q^α)]^{dim 𝒢_α^{(0)} − dim 𝒢_α^{(1)}} ]_{q⁰}.
>
> *Proof.* Use ch_q L(0) = q⁰ and apply Theorem 2.25 and Corollary 2.27. ∎

**公式转录警告**：上式的指数与两侧 `[·]_{q⁰}`（"constant term of"，由 `Corollary 2.27` 定义）
的括号归属在扫描渲染下不完全清晰，**引用公式本体前必须重新对照原页**；名称
（`Corollary 2.28`、作者自称 "No-ghost Theorem"）与 iff 结构是清楚的。

支撑它的链条（全部 L1，均有编号）：

| 编号 | 位置 | 内容（转述，非逐字除非加引号） |
|---|---|---|
| **Theorem 2.1** | p.557 | 一般 Lie 超代数的 ℒ-free 消解，Koszul 型复形 (C_*, d) 有可缩同伦 |
| Definition 2.2 / Prop. 2.3 | p.558 | 约化复形 C*_red、d̄₀；`d²_± = d² = d₊d₋ + d₋d₊ = 0`，故 `d̄₀² = 0` |
| Prop. 2.5 | p.558 | Künneth 公式 |
| Prop. 2.12 | p.561 | {B^q} 是 (C*_∞(𝒢,𝒢₀;V₊⊗V₋), d₀) 的**有限**滤过 |
| **Theorem 2.13** | p.562 | **约化公式（Reduction formula）**：`H*_∞(𝒢,𝒢₀; W ⊗ M(−β̄−λ)) ≅ H*(𝒢₊, W)[λ]`，M(·) 是 Verma 模 |
| Corollary 2.17 | p.563 | `H⁰_∞(𝒢,𝒢₀; W ⊗ M(−β̄−λ)) ≅ W^{𝒢₊}[λ]` |
| Lemma 2.21 | p.564 | "(cf. [FGZ, Theorem 1.12])"：V₊ hermitian 且 𝒢₋-free ⇒ H^n_∞ = 0 (n ≠ 0) |
| Lemma 2.23 | p.565 | Poincaré duality（作者写「The reader may refer to [LZ, Lemma 3.1] for a proof.」） |
| **Theorem 2.25** | p.566 | W hermitian、𝒢₋-free、dim W[α] < ∞ ⇒ `H^n_∞(𝒢,𝒢₀; W ⊗ L(−β̄−λ)) = 0 (n≠0)`，`≅ W^{𝒢₊}[λ]/rad (n=0)`，是**等距**（isometry）；L(·) 是 M(·) 的不可约商 |
| **Corollary 2.26** | p.567 | **Vanishing Theorem**（作者加括号命名）：`H^n_∞(𝒢,𝒢₀;W) ≅ W^{𝒢₊}[−β̄]/rad (n=0)`，其余为 0 |
| Corollary 2.27 | p.567 | 维数公式与 signature 公式（Euler–Poincaré 原理） |
| **Corollary 2.28** | p.568 | **"No-ghost Theorem"**（见上） |
| Corollary 2.30 | p.568 | `W^{𝒢₊}[λ] ≅ (W/I·W)[λ]`，`W[λ] = W^{𝒢₊}[λ] + (I·W)[λ]` 直和 |

**Theorem 2.25 的转录疑点（诚实登记）**：扫描渲染出的假设是「W ∈ 𝒪 be hermitian, 𝒢-free」，
但同章 Lemma 2.21 / 2.22 写的都是 **𝒢₋-free**。按上下文应为 `𝒢₋-free`，下标在渲染中丢失的可能性很大。
**引用 Theorem 2.25 的假设前请复核该行**（PDF 第 20 页 = 刊物 p.566）。同样地
Corollary 2.26 的第二行「= 0 for n = 0」按上下文应为 `n ≠ 0`。

### 1.6 ★ Theorem 3.5：`(D=26, h=1) 或 (26 > D ≥ 2, h ≤ 1)` —— ROADMAP 待裁决第 3 条的一手出处（L1）

这是本轮最重要的发现。p.570 逐字（已单页重读复核）：

> **Theorem 3.5.** *Let D ≥ 2, h ∈ (p·p)/2 + **Z**₊ :*
> (i) *There is a canonical isometry*
>     V(D,p)^{𝒢₊}[−h]/rad ≅ H⁰_∞(𝒢, 𝒢₀; V(D,p) ⊗ L(26−D, 1−h)).
> (ii) *The above space is unitary for each p iff (D, h) takes the following values*
>     **D = 26, h = 1  or  26 > D ≥ 2, h ≤ 1.**
>     *(The number h is called the "Regge slope" in the physics literature.)*

证明末句（p.571，逐字）：

> Thus V(D,p)^{𝒢₊}[−h]/rad is unitary for all *p* iff ch_q L(26−D, 1−h) = sign_q L(26−D, 1−h),
> i.e. iff the Verma module M(26−D, 1−h) is positive semi-definite. The latter is equivalent to
> precisely the conditions on (D, h), as given above. ∎

引出它的一段（p.568–569，逐字）：

> First, we will recover a result which has been known to physicists for quite some time – the
> No-ghost theorem of the so-called bosonic Fock space in *D* dimensions, as well as its
> superstring analogue [GT, T1, LZ, FGZ]. We will show how the no-ghost condition is closely
> related to the unitarity of some Verma modules over Vir (Theorem 3.5).

**四条必须一起传给 curator 的读法说明：**

1. **`h` 是截距 a，不是 Regge 斜率。** LZ 括注「The number h is called the "Regge slope" in the
   physics literature」是**术语用错**：物理文献里 Regge 斜率是 α′，截距才是 α₀ = a。
   从 (i) 的定义 `V(D,p)[−h]` = −L₀ 本征值为 −h 的本征空间（p.570 证明 (i) 首句：
   "We remind the reader of the convention that V(D,p)[−h] is the eigenspace of −L₀ with
   eigenvalue −h"）可知 h 就是 L₀ 本征值，即物理态条件 (L₀ − a)|ψ⟩ = 0 里的 **a**。
   **引用时不要照抄 LZ 的 "Regge slope" 措辞。**
2. **两分支与本项目审计 B1 的区域逐字吻合。** D 为整数时 `26 > D ≥ 2` 即 `2 ≤ D ≤ 25`，
   故 (ii) = 「(D = 26 且 a = 1) 或 (2 ≤ D ≤ 25 且 a ≤ 1)」，正是
   `graph/milestones/no-ghost-theorem.yaml` 审计 B1 算出、并注明「出处未找到」的那个区域。
   **区别只有一处：LZ 多一条 `D ≥ 2` 的下界**（Prop 3.1/§3 的假设，见下），审计 B1 没提下界。
3. **陈述的左侧确实是旧协变物理态空间。** `V(D,p)^{𝒢₊}[−h]/rad` = D 个自由玻色子的 Fock 模里
   被全体 L_n (n>0) 湮灭、L₀ 本征值为 h 的向量，再模去零模态（rad）——这与
   `worldsheet.old-covariant-physical-states` / `no-ghost-theorem-v2` 的 H_phys/H_0 是同一个对象。
   **（这一句是抽取者的对照解读，LZ 没有写「old covariant」字样。）**
4. **右侧多一个因子 `L(26−D, 1−h)`**，即中心荷 26−D、最高权 1−h 的**不可约** Virasoro 模。
   也就是说 D < 26 的分支是靠补上一个 c = 26−D 的「内部 CFT」把总中心荷凑到 26 后做 BRST 得到的；
   LZ 的判据最终归结为 **Verma 模 M(26−D, 1−h) 的半正定性**（证明末句），即 Kac 行列式条件。
   这条把无鬼定理接到了图里已有的 `worldsheet.kac-determinant` 与 `worldsheet.verma-module` 两个节点上。

**Theorem 3.5 依赖的模假设（问题 (c)，全部 L1）：**

- 全局假设 **A1–A5**（p.550）：A1 根空间分解与 Γ-分次；A2 生成元 {α_i}；A3 反线性对合 σ；
  A4 𝒢₀ = ℋ₀ ⊕ cent(𝒢)；**A5 只处理 𝒢₀^(1) = 0（Neveu–Schwarz 型），Ramond 型另文处理**
  （对非超的 Vir 自动满足）。
- 范畴 𝒪（`Definition 1.2`）/𝒪₀（`Definition 1.3`）：𝒢₀-可对角化、**Z**₂-分次、ℋ₀-bounded above、
  `deg x·(V_n) ⊂ V_{n+|α|}`；𝒪₀ 再要求 𝒢₀-bounded above。
- **Fock 模的定义（p.569，逐字式号）**：Heisenberg 代数 {α^μ_n, μ=1..D, n∈**Z**} ∪ {1}，
  括号 `[α^μ_m, α^ν_n] = m g^{μν} δ_{m,−n} 1`（3.1）；
  `V(D,p) = sym ⊕_{μ=1}^{D} ⊕_{n=1}^{∞} **C**α^μ_{−n}`（3.2）；真空 v_p，`x·v_p = ⟨p,x⟩ v_p`（3.3）。
  **对 p 的假设逐字**：「We will assume that ⟨p,1⟩ = 1, that ⟨p,x⟩ ≠ 0 for some x ∉ **C**1, that
  ⟨p, α^μ_0⟩ ∈ **R** for all μ, and that D ≥ 2.」
- **Proposition 3.1**（p.569，标注 "[GSW, FGZ]"）：(i) V(D,p) ∈ 𝒪₀，π(L_m) = ½Σ_m :α_m·α_{n−m}:，
  **π(z) = D·Id_V**；(ii) hermitian，⟨v_p,v_p⟩ = 1，α^{μ†}_n = α^μ_{−n}，π(L_n)† = π(L_{−n})；
  (iii) Spec；(iv) dim V(D,p)[λ] < ∞；(v) **V(D,p) 是 𝒢₋-free**。
- `Remark 3.2(ii)`：`M(c,h)` 记最高权 cz′ + hL′₀ 的 Verma 模，`L(c,h)` 是其不可约商。
- `Proposition 3.4`：dim / ch_q / sign_q 的显式公式，`ch_q V(D,p) = q^{p·p/2} φ(q)^{−D}`，
  `φ(q) = ∏_{n>0}(1−q^n)`。

### 1.7 本文自身的一处编号不一致（L1，避免后人踩坑）

- **Introduction（p.549）逐字**：「Following from it is Corollary 2.19, a strong version of the
  Vanishing Theorem.」
- **§2 开头（p.557）逐字**：「we will prove a strong version of the Vanishing Theorem (**Corollary 2.26**)」
- **正文实际标注**：p.567 的 `Corollary 2.26. (Vanishing Theorem)`；而 p.564 处编号 2.19 被
  **`Remark 2.19`** 占用（其后是 `Corollary 2.20`）。

→ **Introduction 里的「Corollary 2.19」是本文的排印/交叉引用错误**，Vanishing Theorem 是 `Corollary 2.26`。
两处我都做了单页重读复核。**不要引用「LZ 1991 Corollary 2.19」。**

### 1.8 参考文献里可直接复用的条目（L1，抄自 p.580）

| 标签 | 条目（逐字） |
|---|---|
| [GT] | Goddard, P., Thorn, C. B.: Compatibility of the Dual Pomeron with Unitarity and Absence of Ghosts in the Dual Resonance Model, Phys. Lett. **40B**, 235–238 (1972) |
| **[T1]** | **Thorn, C. B.: Computing the Kac determinant using dual model techniques and more about the no-ghost theorem. Nucl. Phys. **B248**, 551 (1984)** |
| [LZ] | Lian, B., Zuckerman, G. J.: BRST-cohomology of the Super Virasoro algebras, Commun. Math. Phys. **125**, 301–335 (1989) |
| [FGZ] | Frenkel, I. B., Garland H., Zuckerman, G. J.: Semi-infinite cohomology and string theory. Proc. Natl. Acad. Sci. USA **83**, 8442 (1986) |
| [K1] | Kac, V. G.: Contravariant form for infinite-dimensional Lie algebras and superalgebras. Lecture Notes in Physics, Vol. **94**, p. 441. Berlin, Heidelberg, New York: Springer 1979 |
| [KK] | Kac, V. G., Kazhdan, D. A.: Structure of representations with highest weights of infinite dimensional Lie algebras. Adv. Math. **34**, 97 (1979) |
| [Fe] | Feigin, B. L.: The semi-infinite homology of Kac–Moody and Virasoro Lie algebras. Russ. Math. Surv. **39**, 155 (1984) |
| [W] | Wallach, N. R.: On the unitarizability of derived functor modules. Invent. Math. **78**, 131–141 (1984) |
| [GSW] | Green, M. B., Schwarz, J. H., Witten, E.: Superstring theory, Vol. 1, Cambridge: CUP 1987 |

两条附带收获：

1. **[T1] 是 Thorn 1984（Nucl. Phys. B248, 551），不是 bib 里已有的 thorn-1987（B286, 61）。**
   LZ 把「D 维玻色 Fock 空间的无鬼定理」归给 [GT, T1, LZ, FGZ] 四篇，其中 Thorn 的那篇是 1984 年这篇。
   已新增 bib 条目 `thorn-1984`（§8）。
2. **[K1] 独立佐证了 bib 里 `kac-1979` 的 LNP 94 / p.441**（`brst-cohomology-sources.md` §1.5 记的
   「FGZ ref 10 引的是 ICM Helsinki 1978」疑点仍在：LZ 引的是 LNP 94，与本项目 bib 一致；
   FGZ 引的是 ICM。二者可能是同一内容的两个版本，**仍未裁决**）。

---

## 2. `goddard-thorn-1972` — 正文：**本轮仍未获取（L0）**

- 本轮新试路径（全部失败，见 §7 访问日志）：
  - INSPIRE API 记录 74899：**`documents` 与 `urls` 两个字段都不存在**，即 INSPIRE 侧无全文。
    `external_system_identifiers` 只有 OSTI 4619228 / CDS 388690 / ADS 1972PhLB...40..235G / SPIRES-1499750。
    `report_numbers` 字段**不存在**——即 INSPIRE 不认为这篇有 CERN 报告号，
    上一轮猜测的「CERN TH.1471 左右」**无证据支持，应放弃这条线索**。
  - `cds.cern.ch/api/records/388690`：`Socket is closed`（CDS 全站不可达，与上一轮 Anubis 结论一致）。
  - `www-lib.kek.jp`（KEK KISS 检索入口）：**域名被环境拦截**（"Unable to verify if domain … is safe to fetch"）。
  - KEK 定向检索：`lib-extopc.kek.jp/preprints/PDF/YYYY/YYMM/NNNNNNN.pdf` 这套 URL **确实可被检索引擎索引**
    （命中过 1980 年的 `Ref.TH.2968-CERN` 与 1989 年的论文），但**未命中 1972 年的这篇**；
    检索后端明确说 KEK 扫描库「pre-1975 覆盖很薄」（L4）。
  - archive.org 高级检索：`Superstrings: The First 15 Years`（Schwarz 编，内含本文重印 pp.112–115）
    与 GSW Vol. 1 均 **`numFound: 0`**。
- **结论不变**：`ms.no-ghost-theorem` 的 `canonical_source.loc` 目前的写法
  「无编号定理；结论见摘要末句 'absence of ghosts for d ⩽ 26'」是**当前证据下唯一诚实的写法**，保持不动。
  「Theorem 1」仍然**无任何来源支持**。
- **新增的间接证据（L1）**：LZ 1991 参考文献 [GT] 给出与 bib 完全一致的卷/页
  （Phys. Lett. **40B**, 235–238 (1972)），是继 FGZ ref 8 之后的**第二条一手引用佐证**；
  且 LZ 在正文里也只说「the No-ghost theorem … [GT, T1, LZ, FGZ]」，**不给编号**，
  与 FGZ、Goddard 2008 综述一致 —— 「这篇快报没有编号定理」的间接证据现在有**四条**。
- **建议**：把 `goddard-thorn-1972` 从 `reading-list.md` 的「全文抽取」队列**降级或标 blocked**，
  并把主线的 canonical 数学来源换成 LZ 1991 Theorem 3.5（见 §9）。

---

## 3. `brower-1972` — 正文：**本轮仍未获取（L0）**；摘要要点已加固（L2）

- INSPIRE 记录 74322：`report_numbers`、`documents`、`urls` **均无**。APS 全站 403 不变。
- INSPIRE 摘要本轮再取一次（L2，仅一句在字数限制内逐字：**"the second-order Pomeranchukon is
  precisely a Regge pole"**；其余为转述）：
  - 鬼态与不定度规相联系，**在 Regge 截距等于 1 时**因 Virasoro 规范条件而退耦；
  - 用光锥变量重写顶点算符，得到与全体 Virasoro 规范对易的 spectrum-generating algebra；
  - 横向生成元与普通振子同构，纵向生成元与共形群生成元同构；
  - **临界维数 D = 26：其上出现鬼，其下没有鬼**；D = 26 处出现零模态，支持 Pomeranchukon 是真正的 Regge 极点
    （文中把这一点关联到 Lovelace 的提议）。
- **对 `(D ≤ 25, a ≤ 1)` 归属问题的判断不变**：摘要把整个论证锁在 unit Regge intercept（a = 1）上，
  「其下没有鬼」是 **a = 1 下的 D < 26**，不能读成 a ≤ 1。
  上一轮 §4.1 的否定结论**维持**。
- 注意：`ms.no-ghost-theorem` 审计 B1 的批注里写「(D ≤ 25 且 a ≤ 1)（Brower 1972；Thorn 用 Kac 行列式的
  证明给出同一条件）」——**「Brower 1972」这个归属按现有证据仍不成立**，
  「Thorn 用 Kac 行列式」的归属现在有了具体对象（Thorn 1984 / 1985，见 §4），但**正文仍未读到**。

---

## 4. `a < 1 ⇒ D ≤ 25` 的成文来源 —— **已解决**（L1）

**结论：一手、可引、带编号的来源是 `lian-zuckerman-1991` Theorem 3.5(ii)（本文件 §1.6，L1 逐字）。**
它逐字给出「D = 26, h = 1 or 26 > D ≥ 2, h ≤ 1」，与本项目审计 B1 的区域一致（多一条 D ≥ 2 下界）。

四条候选的核实结果：

| 候选 | 结果 |
|---|---|
| **Lian–Zuckerman 1991** | ✅ **Theorem 3.5(ii)，L1 逐字，两分支完整** |
| Thorn 1987（`thorn-1987`，Nucl. Phys. B286, 61–77） | ❌ **摘要里没有这条**。INSPIRE 逐字全摘要（L2）：「We offer a detailed account of the Goddard-Thorn proof of the no-ghost theorem which incorporates simplifications presented earlier. We extend these methods to obtain a new calculation of the cohomology of the nilpotent operator Q occuring in BRST quantized strings. We further explain why the apparent doubling of transverse states in the cohomology of Q has no physical significance.」——**通篇不提 intercept，也不提 D ≤ 25**。它是 GT 证明的整理 + BRST 上同调计算。作为 a<1 出处**证据不足**，正文仍未获取。 |
| **Thorn 1984**（新登记 `thorn-1984`，Nucl. Phys. B248, 551–569） | 🟡 **最像的物理侧候选，但只到摘要级（L2）**。INSPIRE 逐字全摘要：「We relate some mathematical results concerning the Virasoro algebra to properties of dual models. Specifically, we show how to compute the Kac determinant using well known techniques from dual models. Then we use the Kac formula to discuss the validity of the no-ghost theorem of dual models **in a more general setting than the original proofs of that theorem**.」——"more general setting" 与 Kac 行列式路线都对得上，且 LZ 1991 正是引 [T1] = 这篇；但**摘要没有写出条件本身**，正文未获取（Elsevier 403）。 |
| GSW Vol. 1 §2.3.3 | ❌ 本轮未推进。Google Books 只回页码不回 snippet，archive.org 无 Vol. 1。式号与内容仍 L0。 |
| Polchinski Vol. 1 §4.1 习题 | ❌ 本轮未查（无原书；`lit_polchinski-v1-equation-anchors` 记录 §4.1 的措辞本身就查不到）。 |

**另外发现的第三篇 Thorn**（元数据 L2，Crossref 逐条核实）：
C. B. Thorn, *A Proof of the No-Ghost Theorem Using the Kac Determinant*, in
J. Lepowsky, S. Mandelstam, I. M. Singer (eds.), *Vertex Operators in Mathematics and Physics*,
Mathematical Sciences Research Institute Publications（ISSN 0940-4740），Springer US, New York, 1985,
pp. 411–417, DOI `10.1007/978-1-4613-9550-8_20`, ISBN 9781461395522 / 9781461395508。
**注意年份陷阱**：会议在 1983 年 11 月举行，论文集 1985 年出版，文献里常被引成「Thorn (1984)」，
与 Nucl. Phys. B248 那篇（真正的 1984）**极易混淆**。已作为 `thorn-1985` 登记以示区分。

---

## 5. Sugawara / 自由玻色子 c = 1 的数学来源

### 5.1 Kac–Raina *Bombay Lectures* 的 Lecture/命题编号 —— **未能核实（L0）**，且有版本陷阱

- 未获取正文。Google Books 只回页码不回 snippet；World Scientific 书页 **HTTP 403**。
- **版本陷阱（L2/L4，必须传给 curator）**：
  - **第 1 版**：Kac & Raina, *Adv. Ser. Math. Phys.* **2**, World Scientific 1987，**145 页**，
    ISBN 9971503964 / 9789971503963；讲座 1986 年 12 月–1987 年 1 月在 TIFR（Bombay）讲。
    Google Books（id `0P23OB84eqUC`）扫到的目录残缺且未标全部编号，可读出的条目为：
    Lecture 1 p.1 / (未标号) p.19 / Lecture 4 p.33 / Lecture 5 p.49 / (未标号) p.59 /
    Lecture 7 p.69 / Lecture 8 p.81 / Lecture 9 p.93 / Lecture 10 p.105 / Lecture 11 p.117 /
    Lecture 12 p.129 / References p.141。→ **第 1 版约 12 讲**。
  - **第 2 版**：Kac, Raina & **Rozhkovskaya**, *Adv. Ser. Math. Phys.* **29**, World Scientific 2013，
    ISBN 9789814522199。Google Books（id `Fzu7CgAAQBAJ`）目录完整：
    Lecture 1 p.1 / 2 p.11 / 3 p.19 / 4 p.31 / 5 p.45 / 6 p.55 / 7 p.65 / 8 p.77 / 9 p.89 /
    10 p.101 / 11 p.113 / 12 p.123 / 13 p.135 / 14 p.151 / 15 p.163 / 16 p.175 / 17 p.191 /
    18 p.211 / References p.229 / Index p.235。→ **第 2 版 18 讲**。
  - **两版讲次数不同（约 12 vs 18），讲号与命题号必然不可互换。** 任务里写的是 1987 年第 1 版；
    任何从第 2 版查到的编号**不能**直接填进引 1987 版的节点。
- **结论：不能给出 Kac–Raina 里「自由玻色子 Fock 空间上 L_n = ½Σ:a_{n−k}a_k: 满足 c = 1 的 Virasoro 关系」
  的 Lecture 号与命题号。按项目纪律，不入库、不猜。**

### 5.2 替代来源：`virasoro-lean-2025`（Kytölä, arXiv:2510.21741）—— **已核实，带编号，开放获取（L1，全文 16 页读毕）**

这是本轮给 curator 的**可用替代品**，强度高于 Kac–Raina 的页码推测：它是编号定理、开放获取、
并且**已在 Lean 里机器验证**（Apache-2.0 仓库）。

- §10 "The basic Sugawara construction" 的设定（逐字式号）：
  - **(H)**（Heisenberg 关系，式 (16)）：`J_k ∘ J_l − J_l ∘ J_k = k δ_{k,−l} id_V` for k, l ∈ **Z**。
  - **(T)**（局部截断，式 (17)）：for any v ∈ V there exists K_v ∈ **Z** such that `J_l v = 0` for all l ≥ K_v。
  - 正规序（式 (18)）：`:J_k J_l: = J_k∘J_l if k ≤ l, = J_l∘J_k if k > l`。
  - 算子（式 (19)）：`L_n v = ½ Σ_{k∈**Z**} :J_{n−k} J_k: v`。
- **Theorem 10.1**（逐字）：
  > Under the hypotheses (H) and (T) above, the linear operators (19) on *V* satisfy the commutation relations
  > `L_m ∘ L_n − L_n ∘ L_m = (m−n) L_{m+n} + ((m³−m)/12) δ_{m,−n} id_V`.
- **Corollary 10.2**（逐字）：
  > Under the hypotheses (H) and (T), a representation of the Virasoro algebra on *V*, **with central charge c = 1**,
  > is defined by the linear extension of the assignments `𝓛_n ↦ L_n`, `C ↦ id_V`.
- **Corollary 12.6**（逐字）：
  > The charged Fock space 𝓕_α carries a representation of the Virasoro algebra 𝔳𝔦𝔯 **with central charge c = 1**
  > so that the action of 𝓛_n is the operator L_n given by (19).
- **Theorem 12.7**：存在唯一的 U(𝔳𝔦𝔯)-模同态 `𝒱_{1, α²/2} → 𝓕_α`，把 `v_{1,α²/2}` 送到 `v_α`。
- 证明位置：Theorem 10.1 的完整证明在 **Appendix A.2**（Lemma A.6–A.12），A.12 是收尾计算。
- Lean 声明名（论文 Table 1，逐字）：
  | 主题 | 论文编号 | Lean 声明 |
  |---|---|---|
  | Sugawara construction for Heisenberg algebra | Thm 10.1 | `sugawaraRepresentation_of_representation_heisenbergAlgebra` |
  | Virasoro Verma module → charged Fock space | Thm 12.7 | `ChargedFockSpace.virasoroVermaToChargedFockSpace` |
  | Virasoro algebra | Def 8.1 | `VirasoroAlgebra` |
  | Heisenberg algebra | Sec 9 | `HeisenbergAlgebra` |
  | Verma modules | Def 12.2 | `VermaModule` / `IsVermaModule` |
  | H²(Witt) 计算 | Thm 6.2 | `WittAlgebra.rank_lieTwoCohomology_eq_one` |

**三条使用限制（务必随引用一起写进节点 gaps）：**

1. **只有 c = 1，没有 c = D。** Theorem 10.1 假设**单个** Heisenberg 族 (J_k)，
   归一化 `[J_k,J_l] = k δ_{k,−l}·id`（中心元作用为恒等）。弦论要的是 D 个分量、
   带 Lorentz 度规 `g^{μν}` 的版本（LZ 1991 式 (3.1)：`[α^μ_m, α^ν_n] = m g^{μν} δ_{m,−n} 1`，
   由此 π(z) = D，见 §1.6）。**c = D 这一步在 Kytölä 里没有做**，
   `formal/NOTES-virasoro-reuse.md` 也已独立记下这一缺口。
2. **没有不定内积。** Kytölä 全程不引入洛伦兹号差；类时方向的负模是无鬼定理的**全部难点所在**。
3. **Kytölä 自己的一条警告（脚注 11，逐字）**：
   > The literature (including Wikipedia at the time of writing) contains statements such as
   > *"The Sugawara construction is an embedding of the Virasoro algebra into the universal
   > enveloping algebra of the affine Lie algebra"*, which are false for the same reason
   > [无穷和不落在 UEA 里], although they may be helpful to convey a rough idea of what the
   > Sugawara construction does.

   → 若 curator 想把节点写成「嵌入 U(ĝ)」，**这条措辞是错的**。

**Kytölä 给出的经典文献指针（p.1 与参考文献，L1）**，可作为 Kac–Raina 之外的经典引用候选：
[Sug68] H. Sugawara, *Phys. Rev.* **170**:1659–1662 (1968)；
[GO85] Goddard & Olive, *Nucl. Phys. B* **257**:226–252 (1985)；
[GO86] Goddard & Olive, *Int. J. Mod. Phys. A* **1**(2):303–414 (1986)；
[Kac98] V. Kac, *Vertex algebras for beginners*, AMS, Oct. 1998；
[LL04] Lepowsky & Li, *Introduction to Vertex Operator Algebras and Their Representations*, Birkhäuser 2004；
[FK81] Frenkel & Kac, *Invent. Math.* **62**(1):23–66 (1980/81)。
**Kytölä 的参考文献里没有 Kac–Raina。** 他对这类经典来源的评语（§10 逐字）：
「Typically in the literature, such constructions are presented for very particular representations
(e.g., highest weight representations of affine Lie algebras or modules over vertex algebras)
[GO85, Kac98, LL04], but upon inspection of the proofs it is clear that modest and easily stated
hypotheses suffice.」——即经典来源多半是在**特殊表示**上陈述的，一般假设版本反而是这篇的贡献。

---

## 6. `kato-ogawa-1983` — 摘要升级为逐字（L2）；正文仍未获取（L0）

**INSPIRE 记录 177600 的摘要，逐字（分段以符合引用长度限制，段间无删节）：**

> "Covariant canonical quantization of the bosonic string is performed, based on the BRS
> invariance principle." /
> "Defining a physical state by a modified form of Kugo-Ojima's subsidiary condition Q_B |phys⟩ = 0
> ( Q_B = BRS charge), we prove a no-ghost theorem in a simple manner." /
> "There an interesting relation between critical dimension and BRS symmetry is noticed; namely,
> the conditions D = 26 and α_0 = 1 for the space-time dimension D and the zero-intercept α_0 of
> leading trajectory are required by the nilpotency Q_B² = 0 of the BRS charge." /
> "In addition, ghost number fractionization is observed in this system."

**这解决了上一轮的一个未解点：方向已明确。**

- 摘要逐字是「**the conditions D = 26 and α₀ = 1 … are required by the nilpotency Q_B² = 0**」，
  即 **Q_B² = 0 ⟹ (D = 26 且 α₀ = 1)**（必要性）。
- **摘要没有给「⟺」**。反方向（c^m = 26 ⇒ Q_B² = 0）在 Kato–Ogawa 摘要里**没有陈述**。
  故 `worldsheet.critical-dimension-brst` 陈述里的「当且仅当」，其反方向目前仍只有
  Polchinski §4.3 的形式计算支撑 —— 与该节点 gaps 第 3 条的现状判断一致，可以据此把
  「未核实它给出的是⟹还是⟺」改写成「摘要逐字给出的是⟹；⟺ 无来源」。
- **报告号（L2，INSPIRE `report_numbers`）：`KUNS 637`。**
  ⚠️ 检索后端（L4）质疑此归属，认为 637 属 RIFP 系列而非 KUNS 系列，且认为 Kato 当时在东京而非京都。
  **两方冲突，未裁决**：INSPIRE 是出版方级元数据（L2），优先级高于 L4，故按 INSPIRE 记入 bib 并注明争议。
- 全文：ScienceDirect 403 不变；未找到 KEK/UT-Komaba/京大 的扫描件（检索无命中）。
  「是否已写成 `Ker Q_B / Im Q_B ≅ OCQ 物理态` 的同构形式」仍 **L0**。

---

## 7. 访问日志（本轮，供后人省事）

| 目标 | 路径 | 结果 |
|---|---|---|
| **LZ 1991 全文** | `projecteuclid.org/journals/.../cmp/1104202143.full` | 只有元数据，页面自称「no online version」 |
| **LZ 1991 全文** | **`projecteuclid.org/journalArticle/Download?urlId=cmp%2F1104202143`** | **✅ 成功**：3.1 MB PDF 落盘，`Read(pages=)` 逐页可读（34 页全读） |
| LZ 1991 卷期目录 | `projecteuclid.org/journals/communications-in-mathematical-physics/volume-135/issue-3` | ✅ 全期目录 + 文章 id |
| GT 1972 全文 | INSPIRE API `fields=documents,urls,report_numbers` | 三个字段**均不存在** → INSPIRE 无全文、无报告号 |
| GT 1972 全文 | `cds.cern.ch/api/records/388690` | `Socket is closed` |
| GT 1972 全文 | `www-lib.kek.jp/KISS/kiss_prepri.html` | **域名被环境拦截**（"Unable to verify if domain … is safe"） |
| GT 1972 重印本 | archive.org advancedsearch（Schwarz *Superstrings* / GSW Vol.1） | `numFound: 0` |
| Brower 1972 全文 | INSPIRE API `documents/urls/report_numbers` | 均无 |
| Kato–Ogawa 全文 | KEK/UT-Komaba 定向检索 | 无命中；仅确认 `lib-extopc.kek.jp/preprints/PDF/YYYY/YYMM/*.pdf` 这套路径可被索引 |
| Kac–Raina 目录 | `worldscientific.com/worldscibooks/10.1142/8882` | **HTTP 403** |
| Kac–Raina 目录 | `books.google.com/books/about/...?id=Fzu7CgAAQBAJ`（2 版）/ `0P23OB84eqUC`（1 版） | ✅ 目录页码（2 版完整、1 版残缺），无 snippet |
| Kytölä 2510.21741 | `arxiv.org/abs/...` | 只有摘要（又一次验证：想要正文别打 `/abs/`） |
| **Kytölä 2510.21741** | **`arxiv.org/pdf/2510.21741`** | **✅ 落盘 1.2 MB，`Read(pages=1-16)` 全读** |
| Thorn 1985 章节元数据 | `api.crossref.org/works/10.1007/978-1-4613-9550-8_20` | ✅ 完整（章题/书名/系列/页码/ISBN） |
| Thorn 1984 / 1987 摘要 | INSPIRE API `fields=abstracts`（单字段查询可拿到完整逐字摘要） | ✅ 两篇均逐字取到 |

**方法要点（本轮新增，已写入 researcher 记忆）**：
INSPIRE API 用 `fields=abstracts` **单字段**查询时能拿到完整逐字摘要；
一次查多个字段时摘要会被摘要器截断。

---

## 8. 本轮对 `sources.bib` 的改动清单

**只改 note / 补字段 / 新增条目，不改任何已有 key。**

| key | 改动 |
|---|---|
| `lian-zuckerman-1991` | `note` 整体替换：全文已核实（Project Euclid 免费 PDF，34 页读毕）；列出 Theorem 3.5 / Corollary 2.26 / Corollary 2.28 / Theorem 2.13 / Theorem 2.25；写明「文中无 Q²=0 ⟺ c=26」；写明 Introduction 的 "Corollary 2.19" 是排印错误 |
| `goddard-thorn-1972` | `note` 追加：LZ 1991 参考文献 [GT] 第二次独立佐证卷页；INSPIRE 无 documents/urls/report_numbers，「CERN TH 报告号」线索作废 |
| `brower-1972` | `note` 追加：INSPIRE 无报告号/全文；摘要要点复核结论不变 |
| `thorn-1987` | `note` 整体替换：INSPIRE 逐字全摘要已取到，**摘要不含 a<1 / D≤25**，作为 a<1 出处证据不足 |
| `thorn-1984` | **新增**（Nucl. Phys. B248 (1984) 551–569，DOI `10.1016/0550-3213(84)90611-4`，报告号 UFTP-84-004；LZ 1991 的 [T1]） |
| `thorn-1985` | **新增**（MSRI 论文集章节，DOI `10.1007/978-1-4613-9550-8_20`，pp. 411–417；与 thorn-1984 的年份混淆警告） |
| `kato-ogawa-1983` | `note` 整体替换：逐字摘要 + 方向是 ⟹ 不是 ⟺ + 报告号 KUNS 637（含 L4 争议） |
| `kac-1979` | `note` 追加：LZ 1991 [K1] 独立佐证 LNP 94 / p.441；与 FGZ ref 10（ICM 1978）的疑点仍未裁决 |
| `kac-kazhdan-1979` | **新增**（Adv. Math. 34 (1979) 97；LZ 1991 的 [KK]，Theorem 3.5 与 Lemma 3.17 的关键工具，接 `worldsheet.kac-determinant` 节点） |
| `kac-raina-1987` | **新增**，`note` 里写死版本陷阱（1 版约 12 讲 / 2 版 18 讲，编号不可互换；内容与编号均未核实） |
| `virasoro-lean-2025` | `note` 追加：全文已核实；Theorem 10.1 / Corollary 10.2（c=1）/ Corollary 12.6 / Theorem 12.7 与对应 Lean 声明名；三条使用限制 |

---

## 9. 对图节点的具体修改建议（供 curator / auditor / lead 取舍）

> researcher 不写 `graph/`。以下每条都写明「哪个节点的哪个字段 → 改成什么」。
> 已逐一确认这些 id 在 `graph/` 下真实存在（`Grep`/`Glob` 复核，2026-09-10）。

### 9.1 `worldsheet.critical-dimension-brst--via-nilpotency`（derivation）

1. `gaps[0]`：**把 lian-zuckerman-1991 从升级候选里删掉**，改写为
   「lian-zuckerman-1991 已全文核实（primary-sources-round2.md §1.4）：该文**没有**
   『Q²=0 ⟺ c=26』型编号陈述。Proposition 1.11(i) 的 `d²=0` 对任意 V ∈ 𝒪 无条件成立且不含 26；
   26 只出现在 Proposition 3.3(iii)，且是**单向**的『is a 𝒢-module **if** β̄ = −26z′ − L′₀』。
   与 FGZ 同型：数学侧文献为 c=26 **构造**相对复形，不**推导** c=26。
   本候选排除；目前无已知数学来源可支撑本推导升到 rigorous。次选仍是 Kato–Ogawa 1983 正文。」
2. `gaps[2]`：把「未核实它给出的是「⟹」还是「⟺」」改成
   「已核实（primary-sources-round2.md §6，INSPIRE 逐字摘要）：Kato–Ogawa 给的是 **⟹**
   （『the conditions D = 26 and α₀ = 1 … are **required by** the nilpotency Q_B² = 0』）。
   反方向 c^m = 26 ⇒ Q_B² = 0 在该摘要中**没有**陈述，仍只有 Polchinski §4.3 的形式计算支撑。」
3. `sources[kato-ogawa-1983].note`：把现有的转述换成 §6 的逐字摘要三句，并把 `loc` 保持
   「摘要；正文未获取，定理编号未核实」。
4. `status` **不变**（仍 `physical-argument`）。本轮没有找到任何可以升级它的来源。

### 9.2 `worldsheet.critical-dimension-brst`（statement）

- `sources[kato-ogawa-1983].note`：同 9.1.3，并把「未核实它给出的是「⟹」还是本节点写的「当且仅当」」
  改成「已核实为 ⟹；本节点的「当且仅当」中反方向无文献来源」。
- 可考虑在 `notes` 里加一句：「数学侧（FGZ 1986、Lian–Zuckerman 1991）**均不推导** c = 26，
  两篇都把 c = 26 作为相对复形的定义条件。见 primary-sources-round2.md §1.4。」

### 9.3 `ms.no-ghost-theorem` / `worldsheet.no-ghost-theorem-v2` —— 本轮最有价值的一条

审计 B1 明确写着「正确区域是 (D ≤ 25 且 a ≤ 1) 或 (D = 26 且 a = 1)」，并在 C1 要求
「以文献抽取记录支撑」；`--via-goddard-thorn` 的 `gaps[0]` 也写着「D ≤ 25、a ≤ 1 的无鬼性
（通常归于 Brower 1972 / Thorn）不在本陈述内，需另建节点」。**这条来源现在有了：**

- **建议新建一个 statement 节点**（例如 `worldsheet.no-ghost-theorem-subcritical`），内容为
  LZ Theorem 3.5，并挂一条 `--via-lian-zuckerman` 推导，`kind: proof`，`status: rigorous`，
  `sources`：
  ```
  - ref: lian-zuckerman-1991
    loc: "Theorem 3.5(ii)，p.570（逐字：'D = 26, h = 1 or 26 > D ≥ 2, h ≤ 1'）；(i) 的等距同构见同页"
  ```
  `depends_on` 至少含 `worldsheet.verma-module`、`worldsheet.kac-determinant`
  （LZ 的证明末句把判据归结为 Verma 模 M(26−D, 1−h) 的半正定性，并在 Lemma 3.17 用 Kac–Kazhdan 公式）。
- **必须一并写进节点 `notes` 的四条**（否则会误引，详见 §1.6）：
  1. LZ 的 `h` 是**截距 a**，不是 Regge 斜率；LZ 的括注 "Regge slope" 是术语错误，**不要照抄**。
  2. LZ 的设定是 `V(D,p) ⊗ L(26−D, 1−h)`：D<26 分支靠一个 c = 26−D 的不可约 Virasoro 模补足总中心荷 26。
     **不是**「纯 D 维弦、截距 a<1」的裸陈述。
  3. LZ 多一条下界 **D ≥ 2**（§3 的 Fock 模假设），审计 B1 的区域没有这条。
  4. LZ 对动量 p 的假设逐字：⟨p,1⟩ = 1、⟨p,x⟩ ≠ 0 for some x ∉ **C**1、⟨p,α^μ_0⟩ ∈ **R**、D ≥ 2。
- `ms.no-ghost-theorem` 的 `canonical_source`：**建议保持 `goddard-thorn-1972` 不变**
  （它是历史 canonical），但在 `audit.diff_notes` 里补一条：
  「B1 所需的区域来源已找到：lian-zuckerman-1991 Theorem 3.5(ii)（L1 逐字，
  primary-sources-round2.md §1.6）；B1 批注里把该区域归给『Brower 1972』的部分**按现有证据不成立**
  （§3），应改为归给 LZ 1991，历史上的物理侧来源候选是 Thorn 1984（Nucl. Phys. B248, 551，摘要级）。」
- `--via-goddard-thorn` 的 `gaps[0]`：把「（通常归于 Brower 1972 / Thorn）」改为
  「（出处现已核实为 lian-zuckerman-1991 Theorem 3.5(ii)；Brower 1972 的归属不成立）」。

### 9.4 `worldsheet.brst-cohomology-equals-ocq-physical`（statement）

- 可在 `sources` 增加第二条独立来源：
  ```
  - ref: lian-zuckerman-1991
    loc: "Theorem 3.5(i)，p.570：canonical isometry V(D,p)^{G+}[-h]/rad ≅ H^0_∞(G,G_0; V(D,p) ⊗ L(26-D,1-h))；一般版本见 Theorem 2.25 与 Corollary 2.26（Vanishing Theorem），p.566–567"
    note: "L1 全文核实。与 FGZ Theorem 2.8 第一个同构平行，但 LZ 版本是**等距**（isometry）且覆盖 D ≠ 26 的补足 CFT 情形。注意 Theorem 2.25 的假设行在扫描件里渲染为 'G-free'，按上下文应为 'G_-free'，引用前需复核。"
  ```
  这会给该节点第二条独立推导，且它是**数学期刊的编号定理**。

### 9.5 curator 正在建的 Sugawara / 自由玻色子 c = 1 节点

- `stringgraph search` 层面确认：`graph/` 下目前 **没有** 任何 `sugawara` / `heisenberg` /
  `free-boson` 节点（Grep 零命中），新建不会撞车。
- **建议来源写法（可支撑 `rigorous`）**：
  ```
  - ref: virasoro-lean-2025
    loc: "Theorem 10.1（Sugawara 对易关系）与 Corollary 10.2（c = 1 的 Virasoro 表示）；证明在 Appendix A.2（Lemma A.6–A.12）；Fock 空间情形见 Corollary 12.6"
    note: "L1 全文核实。假设逐字：(H) [J_k,J_l] = k δ_{k,-l} id_V；(T) 局部截断 ∀v ∃K_v, J_l v = 0 for l ≥ K_v。L_n v = ½ Σ_k :J_{n-k} J_k: v（式 19）。已在 Lean 机器验证，声明名 sugawaraRepresentation_of_representation_heisenbergAlgebra（kkytola/VirasoroProject, Apache-2.0）。"
  ```
- **不要**引 Kac–Raina 的具体 Lecture/命题号（§5.1：编号未核实，且 1 版/2 版讲次不同）。
  若一定要挂经典来源，只写书名不写编号，并在 note 里标 `loc_unverified: true`。
- **必须写进 gaps 的三条**（§5.2）：只有 c = 1 没有 c = D；没有洛伦兹不定内积；
  Kytölä 脚注 11 指出「Sugawara = 嵌入 U(ĝ)」的通行说法是错的，节点措辞不要用「嵌入」。
- **`status` 建议**：`rigorous`（外部已形式化不等于本项目的 `formalized`——按 `formal/CLAUDE.md`，
  `formalized` 只给本仓库内无 sorry 编译通过的声明）。

### 9.6 `docs/ROADMAP.md`「待裁决」

- 第 3 条「a<1 分支的文献出处：… 候选 Thorn 1987」→ **可裁决**：
  出处是 **lian-zuckerman-1991 Theorem 3.5(ii)**（L1）；Thorn 1987 的摘要**不含**该条件，候选降级；
  物理侧的历史候选改为 Thorn 1984（Nucl. Phys. B248, 551，仅摘要级）。
- 第 4 条「原书核对 … GT 1972 与 Brower 1972 正文在付费墙后」→ 建议加注：
  本轮又试了 INSPIRE documents/urls、CDS API、KEK KISS、archive.org 四条新路径，**全部失败**；
  GT 1972 的 CERN 报告号线索（TH.1471）**经 INSPIRE 证伪**，不必再追。

---

## 10. 未解决 / 留给下一轮

1. **GT 1972 与 Brower 1972 正文**：十条路径累计失败。除非有人能进 ScienceDirect/APS 或线下扫描，
   否则建议永久标 blocked，主线改用 LZ 1991 / FGZ 1986 作数学 canonical。
2. **Thorn 1984 正文**（Nucl. Phys. B248, 551–569）：是「a<1 分支」的物理侧原始出处的最强候选，
   摘要说「in a more general setting than the original proofs」但没写出条件。Elsevier 403。
   报告号 **UFTP-84-004** 可作为找扫描件的钥匙（佛罗里达大学）。
3. **Kato–Ogawa 正文**：是否给出 `Ker Q_B / Im Q_B ≅ OCQ 物理态` 的同构形式，仍 L0。
   报告号 `KUNS 637`（INSPIRE，L2；L4 有异议）可作为找扫描件的钥匙。
4. **Kac–Raina 编号**：需要持第 1 版原书者核对，或找到合法的第 1 版电子本。
5. **`kac-1979` vs FGZ ref 10（ICM Helsinki 1978, Vol. 1, 299–304）** 是否同一篇：仍未裁决。
   本轮新增的 LZ [K1] 站在 LNP 94 一侧，但没有排除两者是同一内容的两个版本。
6. **LZ 1991 两处扫描转录疑点**（Theorem 2.25 的 `𝒢-free` vs `𝒢₋-free`；Corollary 2.26 第二行
   `n = 0` vs `n ≠ 0`；Corollary 2.28 的公式指数）：需要持有可选中文本 PDF 的人复核。
   PDF 本身在 Project Euclid 免费，任何人可复现（§7 给了 URL）。
   → **本条第 1 项（`𝒢₋-free`）已在 §11.4 得到强佐证，见下。**

---

## 11. LZ 1991 的「典范等距」是否由包含映射诱导 —— 第三轮专项核实

> **编号说明**：lead 的任务书写的是「新节 §10」，但本文件的 §10 已被「未解决 / 留给下一轮」占用
> （`literature/CLAUDE.md` 规则 3：可多次追加，**不覆盖**已有条目），故本节编号为 **§11**。
>
> - 负责 agent：researcher（无 Bash，不做 git 操作）
> - 日期：2026-09-10（第三轮）
> - 触发：`graph/derivations/worldsheet/brst-cohomology-equals-ocq-physical--via-lian-zuckerman.yaml`
>   的 `gaps[0]` 自称「本推导最软的一步……待 researcher 复核 LZ p.566–567」
> - 证据等级沿用 §0 的表。本节全部为 **L1**（Project Euclid 免费 PDF，`Read(pages=)` 逐页读图），
>   获取端点与 §1.0 / §7 相同：`https://projecteuclid.org/journalArticle/Download?urlId=cmp%2F1104202143`
>   （PDF 页码 = 刊物页码 − 546；本轮读了 PDF 第 16–21、24–25 页 = 刊物 p.562–567、p.570–571）

### 11.1 结论（一句话）

**是。** LZ 的典范等距**确实**由「物理态 ⊗ （补充模的最高权向量）⊗ 鬼真空 ↦ 上同调类」诱导，
而且 LZ 把这个映射**逐字写了出来**（`Lemma 2.22` 证明中的 Eq. (2)，p.565）。
之前登记的「LZ 只说 canonical isometry、没写映射是什么」是**因为上一轮没有读 Lemma 2.22**——
`Theorem 2.25` 的证明末句正是「Now by **Lemma 2.22**, Eqs. (1), (2) give the desired result」。
因此 `--via-lian-zuckerman` 的 `gaps[0]`（「本推导最软的一步」）**可以关闭**。

### 11.2 逐字证据链（三步，全部 L1）

**第一步：显式映射写在 `Lemma 2.22`（p.565）的证明里。逐字：**

> **Lemma 2.22.** *Suppose W∈𝒪 is hermitian, 𝒢₋-free and* dim W[α] < ∞ ∀α∈𝒢₀'. *Then
> for each* λ∈𝒢₀', *there is an isometry*
> H^n_∞(𝒢, 𝒢₀; W ⊗ M(−β̄−λ)) = 0   *for* n ≠ 0,
>                       ≅ W^{𝒢₊}[λ]   *for* n = 0.
>
> *Proof.* The vanishing part follows from Lemma 2.21. **One can check that the composed
> isomorphism given by the proof of Corollary 2.17 and Theorem 2.13,**
>   W^{𝒢₊}[λ] ⥲ H⁰(𝒢₊, W)[λ] ⥲ H⁰_∞(𝒢, 𝒢₀; W ⊗ M(−β̄−λ)),   (1)
> **is given by**
>   **ω ↦ [ω ⊗ 1] ↦ [ω ⊗ v_{−β̄−λ} ⊗ 1 ⊗ 1],   (2)**
> where [ ] denotes the cohomology class. This is obviously an isometry. ∎

三个符号的身份（均 L1，出自本文自身）：

| 符号 | 身份 | 出处逐字 |
|---|---|---|
| `ω ∈ W^{𝒢₊}[λ]` | 物质模里被 𝒢₊ 湮灭、权为 λ 的向量 = **旧协变物理态** | `Corollary 2.17` 证明（p.563）：「A simple calculation shows that H⁰(𝒢₊, W) ≅ W^{𝒢₊}, the space of 𝒢₊-invariant vectors in W.」 |
| `v_{−β̄−λ}` | **Verma 模 M(−β̄−λ) 的最高权向量** | `Lemma 2.14` 证明（p.562）：「where v_Λ is a highest weight vector of M(Λ) having weight Λ」 |
| `1 ⊗ 1` | **半无限形式空间 Ω_∞ = ∧_∞𝒢 的典范生成元 = 鬼真空** | 同上句续：「and 1⊗1 ∈ ∧(𝒢^(0)′) ∨ (𝒢^(1)) has weight β̄」；`Remark 2.19(i)`（p.564）：「A hermitian form is uniquely defined by letting ⟨1⊗1, 1⊗1⟩_{Ω_∞} = 1」 |

**`1⊗1` 就是物理学家的 |↓⟩，且能对上数值**：`Proposition 3.3(iii)` 给 β̄ = −26z′ − L′₀，
`Proposition 3.3(iv)` 把 ∧_∞𝒢 的 𝒢₀-谱 {−26z′ − L′₀ + nL′₀}_{n∈Z₊} 认同为 {1−n}_{n∈Z₊}
「*i.e. the eigenvalues of* −L₀」。故 `1⊗1`（n = 0）的 −L₀ 本征值为 1，即 **L₀ 本征值 = −1**
——正是 `polchinski-1998-v1.md` E43 订正后的鬼场正规序常数 **a^g = −1**，也正是图节点
`worldsheet.brst-cohomology-equals-ocq-physical` 里 |↓⟩ 的归一化（该节点把 −1 挪进
L_0 = L^m_0 + L^g_0 − 1 的定义，等价）。**这条数值吻合是本轮的额外收获**：
它把「LZ 的 1⊗1 = 本项目的 |↓⟩」从纯字典推断变成了带一个可核对数值的对照。

**第二步：`Theorem 2.25`（p.566）的等距就是 Lemma 2.22 的映射再对 rad 取商。证明逐字：**

> *Proof.* First apply Lemma 2.21 to V₊ = W and V₋ = M, rad M, M/rad M, where M = M(−β̄−λ).
> Then Corollary 2.20 implies that
>   H⁰_∞(𝒢,𝒢₀; W ⊗ (M/rad M)) ≅ H⁰_∞(𝒢,𝒢₀; W ⊗ M)/i*H⁰_∞(𝒢,𝒢₀; W ⊗ rad M)   (1)
> is an isometry. Now W ⊗ (M/rad M) is hermitian. Thus by Remark 2.19 (ii), there is a hermitian
> pairing between C^n_∞ and C^{−n}_∞, where C*_∞ = C*_∞(𝒢,𝒢₀; W ⊗ (M/rad M)). By Lemma 2.24
> C*_∞(𝒢,𝒢₀; W ⊗ M(Λ)) is finite dimensional. Thus Lemma 2.23 implies that the left-hand side of
> Eq. (1) is hermitian. It follows from Eq. (1) that
>   i*H⁰_∞(𝒢,𝒢₀; W ⊗ rad M) = rad H⁰_∞(𝒢,𝒢₀; W ⊗ M).   (2)
> **Now by Lemma 2.22, Eqs. (1), (2) give the desired result.** ∎

而 (1) 里的 `i*` **逐字就是包含映射诱导的映射**——`Lemma 2.18`（p.564）逐字：

> …*Then there is an isomorphism* H⁰(A/B) ≅ H⁰(A)/i*H⁰(B), **where i\* is induced by i: B ↪ A**.
> *If, furthermore, A has a sesquilinear form such that* ⟨d·,·⟩ = ⟨·,d·⟩ *and* B ⊆ rad A,
> *then the isomorphism is an isometry.*
>
> *Proof.* The short exact sequence 0 → B →^i A →^p A/B → 0, **where p is the canonical map**,
> gives a long exact sequence. But since this sequence collapses we get the desired isomorphism.
> The second part is a trivial exercise. ∎

（`Corollary 2.20`, p.564，是它在半无限上同调里的版本：「*Suppose* (V,π)∈𝒪 *has a sesquilinear
form and* U ⊂ rad V *is a submodule. If* H^n_∞(𝒢,𝒢₀;K) = 0 *for* K = V, U *or* V/U *if* n ≠ 0,
*then there is an isometry* H⁰_∞(𝒢,𝒢₀; V/U) ≅ H⁰_∞(𝒢,𝒢₀;V)/i*H⁰_∞(𝒢,𝒢₀;U).」）

→ 合起来：`Theorem 2.25` 的典范等距 `W^{𝒢₊}[λ]/rad ≅ H⁰_∞(𝒢,𝒢₀; W ⊗ L(−β̄−λ))`
就是 **ω ↦ [ω ⊗ (L 的最高权向量) ⊗ 1 ⊗ 1]** 在两侧同时对 rad 取商后诱导的映射
（Verma 侧的 `v_{−β̄−λ}` 经 `p: M → M/rad M = L` 落到 L 的最高权向量）。

**第三步：`Theorem 3.5(i)` 的证明只有一句话，直接回到 Theorem 2.25。p.570 逐字：**

> *Proof.*
> (i) We remind the reader of the convention that V(D,p)[−h] is the eigenspace of −L₀ with
> eigenvalue −h. **Then (i) is simply a direct application of Theorem 2.25.**

→ **`Theorem 3.5(i)` 的「canonical isometry」= `Theorem 2.25` 的等距 = 上面那个显式映射。**
本项目用的 **D = 26、h = 1** 特例下补充模是 L(0,0) = **C**（`Corollary 2.26` 的证明逐字就是
一句「L(0) = **C**.」），其最高权向量是 1，映射退化为

  **ω ↦ [ω ⊗ 1 ⊗ 1 ⊗ 1]，即「物理态 ⊗ 鬼真空 ↦ 上同调类」，与 FGZ 的 ι 逐点相同。**

### 11.3 与 FGZ「The inclusion of P … induces」的逐条对照

| 项 | FGZ 1986 Theorem 2.8（第一个同构） | LZ 1991 Theorem 3.5(i) / Theorem 2.25 |
|---|---|---|
| 映射是否逐字给出 | **是**：「The inclusion of P into (V ⊗ Λ⁰_∞)^{ℒ₀} … induces a unitary isomorphism」 | **是**（本轮新证）：Lemma 2.22 Eq. (2) 逐字 `ω ↦ [ω ⊗ v_{−β̄−λ} ⊗ 1 ⊗ 1]`，Theorem 2.25 与 3.5(i) 逐句回指它 |
| 措辞 | "unitary isomorphism" | "isometry"（Thm 2.25 / 3.5(i)）；"canonical"（Thm 2.13、Lemma 2.14、Thm 3.5(i)） |
| 「典范」的含义 | 由包含映射直接给出 | 由 `Corollary 2.17`+`Theorem 2.13`（约化公式）**复合**给出，Lemma 2.22 再把复合映射算出来**恰好是**包含型映射 |
| 张量因子 | 只有 V ⊗ Λ⁰_∞（鬼真空扇区） | 多一个补充模因子 L(26−D, 1−h) 的最高权向量；**D=26,h=1 时该因子 = C，两者重合** |
| 「核 = rad」 | FGZ 的陈述形式是 P/rad P ≅ H⁰_∞，核已含在商里 | 同左（Thm 2.25 已是 `/rad` 形式）。**LZ 没有单独写一句「该映射的核是 rad」**；由「Lemma 2.22 是等距（等距把 rad 映满 rad）」+ 证明里的 Eq. (2) `i*H⁰(W⊗rad M) = rad H⁰(W⊗M)` 一行即得，**这一行是抽取者的合成，不是 LZ 的原句**（推断，须标 `inferred`） |

**差异的实质**：LZ 走的确实是「谱序列/约化公式」路线（`Theorem 2.13` 逐字：「(*Reduction formula*).
**There is a canonical isomorphism** H*_∞(𝒢,𝒢₀; W ⊗ M(−β̄−λ)) ≅ H*(𝒢₊, W)[λ] for each λ∈𝒢₀'.」，
更精确地说是**有限滤过 + 长正合列**，见 `Proposition 2.12` 与 Theorem 2.13 的证明，
**不是**谱序列的语言），**但终点相同**：Lemma 2.22 明确指出这条路线复合出来的同构就是包含型映射。
所以「LZ 走了别的构造」这个上一轮的猜测是**部分正确、结论错误**：路线不同，**映射相同**。

### 11.4 本轮顺带解决 / 新发现的四件事

1. **§10.6 的转录疑点 (a) 基本可判定：`Theorem 2.25` 的假设应读作 `𝒢₋-free`。**
   理由：`Lemma 2.22`（p.565）与 `Lemma 2.21`（p.564）在**同一组假设**下都渲染成带下标的
   **`𝒢₋-free`**（Lemma 2.21 逐字：「If V₊, V₋∈𝒪 with V₊ hermitian and **𝒢₋-free**…」），
   而 Theorem 2.25 的证明第一句就是「First apply **Lemma 2.21**…」。
   **等级：L1 间接（同页同章的平行陈述带下标），不是对 2.25 那一行的直接判读**——
   该行在扫描里仍看不出下标。建议把 §10.6 第 1 项从「待复核」降为「已高度确信，仍欢迎复核」。
2. **转录疑点 (b) 确认为疑点：`Corollary 2.26` 第二行确实渲染成「= 0 *for* n = 0」**（p.567 原页），
   与第一行的「≅ W^{𝒢₊}[−β̄]/rad *for* n = 0」重复，按上下文第二行必为 **n ≠ 0**。
   对照证据：**同一份扫描里 `Lemma 2.22` 的两行渲染是正常的**（「= 0 for n ≠ 0」/「≅ … for n = 0」），
   说明这不是全篇性的 OCR 缺陷，**更可能是原刊排印错误**。引用 Corollary 2.26 时须带这条注。
3. **LZ 自己给了物理词典，可以削弱 `old-covariant-physical-states` 那条 `inferred` 边的软度。**
   §2.3 开头逐字（p.563）：
   > **2.3. Important Consequences.** We now proceed to an important consequence of the reduction
   > formula (for the case of a Hermitian 𝒢-module W) which relates W^{𝒢₊}[λ]/rad with a zeroth
   > relative cohomology group (Theorem 2.25). **In some special cases, the space W^{𝒢₊}[λ]/rad is
   > known as the "physical Hilbert space"** (see Sect. 3 for examples.)

   以及 `Remark 3.6(ii)`（p.571）逐字：
   > Theorem 2.25 can be applied to a general class of string theories, known as the "compactified"
   > string models… Given such a theory, **one postulates that the "particle spectrum" be given by
   > the cohomology classes of** H⁰_∞(𝒢,𝒢₀; V(D,p) ⊗ W).

   → LZ **仍然没有**写 "old covariant" 四个字（§1.6 读法说明 3 不变），但「W^{𝒢₊}[λ]/rad =
   物理 Hilbert 空间」「H⁰_∞ 的类 = 粒子谱」是**作者自己的**对照措辞，不再是抽取者独有的解读。
   `depends_on` 的 `inferred: true` 建议保留（LZ 没有给出与本项目 H_phys/H_0 定义逐条对齐的命题），
   但 note 里可以补上这两句逐字，把「纯抽取者解读」改成「作者给了同向的非正式对照」。
4. **新发现一条此前未登记的支撑性假设：`§2.3` 起有一条 reality condition。** p.563 末逐字：
   > **From now on we will only consider weights λ∈𝒢₀' that satisfy the reality condition σλ = −λ.**

   这是 §2.3（含 `Theorem 2.25`、`Corollary 2.26/2.27/2.28`）以及由它们推出的 `Theorem 3.5` 的
   **常设假设**，`--via-lian-zuckerman` 与 `--via-lian-zuckerman`（subcritical）两条推导的
   `gaps` 里都没有登记。σ 是 `Proposition 3.3(ii)` 的反线性自同构（σ(L_n) = −L_{−n}, σ(z) = −z）。
   在本项目的 D=26、h=1（h 实）特例下它应当自动满足，但**这一步 LZ 没有验，本轮也没有验**。
   建议加进 gaps（等级：假设逐字为 L1，「特例下自动满足」为未核实推断）。

**另外一条小的编号存疑（不影响结论，登记备查）**：`Corollary 2.20` 的证明渲染为
「It follows from Lemma 2.18 and the observation made in **Remark 2.13(iii)**」，
但内容显然指 **`Remark 2.19(iii)`**（p.564，「U ⊆ rad V then C_∞(𝒢,𝒢₀;U) ⊆ rad C_∞(𝒢,𝒢₀;V)」）。
2.13 处是 `Theorem 2.13`（约化公式），没有 (iii) 小项。**未做单页重读复核，可能是 OCR 误读也可能
是本文第二处交叉引用错误**（第一处见 §1.7 的 "Corollary 2.19"）。

### 11.5 对图的建议

> researcher 不写 `graph/`。以下逐条写明「哪个节点的哪个字段 → 改成什么」。
> 相关 id 已用 `Read`/`Grep` 确认存在（2026-09-10）。

#### 11.5.1 `worldsheet.brst-cohomology-equals-ocq-physical--via-lian-zuckerman`（derivation）

- **`gaps[0]` 建议整体替换**（原文是「【本推导最软的一步】…待 researcher 复核 LZ p.566–567」）为：

  > 「【已复核，2026-09-10，primary-sources-round2.md §11】LZ **确实**逐字给出了典范等距的构造，
  > 且它就是包含型映射：`Lemma 2.22`（p.565）证明中的 Eq. (2) 逐字写
  > `ω ↦ [ω ⊗ 1] ↦ [ω ⊗ v_{−β̄−λ} ⊗ 1 ⊗ 1]`，其中 `v_{−β̄−λ}` 是补充 Verma 模的最高权向量
  > （身份见 Lemma 2.14 证明）、`1⊗1` 是半无限形式的典范生成元即鬼真空
  > （Remark 2.19(i) 定义 ⟨1⊗1,1⊗1⟩ = 1；Proposition 3.3(iii)(iv) 给它 −L₀ 本征值 1，即 L₀ = −1 = a^g）。
  > `Theorem 2.25` 的证明末句「Now by **Lemma 2.22**, Eqs. (1), (2) give the desired result」把
  > 该映射对 rad 取商；`Theorem 3.5(i)` 的证明逐字只有一句「(i) is simply a direct application of
  > Theorem 2.25」。本节点的 D=26、h=1 特例下补充模 L(0,0) = **C**（Corollary 2.26 证明逐字「L(0) = **C**.」），
  > 映射退化为 `ω ↦ [ω ⊗ 鬼真空]`，与 fgz-1986 的 ι 逐点相同。
  > **残留的两点仍是推断（不是 LZ 原句）**：(a)「该映射的核恰为 rad」LZ 没有单独陈述，由
  > 「Lemma 2.22 是等距」+ Theorem 2.25 证明 Eq. (2) 一行合成；(b)「LZ 的 1⊗1 = 本项目 |↓⟩」
  > 仍属 brst-quantization 那条 inferred 边的字典，但现在有 L₀ 本征值 −1 这个可核对数值支持。」

- **`gaps` 建议新增一条（本轮新发现）**：
  > 「LZ §2.3 开头（p.563 末）逐字设定常设假设『From now on we will only consider weights λ∈𝒢₀'
  > that satisfy the reality condition σλ = −λ』，Theorem 2.25 / Corollary 2.26 / Theorem 3.5 全部
  > 在此假设下。本节点的 D=26、h=1 特例是否自动满足该条件，**未核实**。」

- **`sources[0].note`（Theorem 3.5(i) 那条）建议追加一句**：
  > 「Theorem 3.5(i) 的证明逐字只有一句『(i) is simply a direct application of Theorem 2.25』，
  > 故实质来源是 Theorem 2.25 + Lemma 2.22（primary-sources-round2.md §11.2）。」

- **`sources[1].note` 的转录疑点 (a) 建议降级**：按 §11.4 第 1 条，改成
  「(a) …按 Lemma 2.21/2.22 的平行渲染（两处均带下标 `𝒢₋-free`）判定应为 `𝒢₋-free`，
  高度确信；仍欢迎持可选中文本者复核该行」；(b) 保留并补一句
  「同一扫描里 Lemma 2.22 的对应两行渲染正常，故更可能是原刊排印错误而非 OCR」。

- **`notes` 里「两条推导的分工」那段建议改写**：原写「本推导……但没有逐字说明典范同构由包含映射
  诱导（见 gaps 第一条）」。按本轮结果，**这句已不成立**。建议改为：
  「两条推导都逐字覆盖了『包含型映射诱导等距』这一具体形式（FGZ 用一句话直陈，LZ 用
  Lemma 2.22 把约化公式复合出来的映射算出来）；真正的分工是**证明的完整程度**（PNAS 梗概
  vs CMP 长文）与**覆盖范围**（FGZ 只有 D=26；LZ 覆盖任意 D≥2 加补充模）。」

- **`status: rigorous` 不变**，本轮只增强不削弱。

#### 11.5.2 目标陈述 `worldsheet.brst-cohomology-equals-ocq-physical` —— **建议不拆**

lead 问「两条推导互补 → 是否需拆目标陈述」。**researcher 的意见：不拆。** 理由：

1. 拆分的动机原本是「一条推导只覆盖『存在保形式的双射』、另一条才覆盖『由 ι 诱导』」。
   **这个前提本轮被推翻**：两条来源现在都逐字覆盖了具体映射，目标陈述的断言
   （ι 良定义、核恰为 H_0、诱导酉同构）**没有任何一半是只靠单一来源支撑的**。
   按 `graph/CLAUDE.md`「一个节点一个命题」，这里就是**一个**命题挂两条推导，正是该原则想要的形态。
2. 若硬拆成「存在同构」+「同构由 ι 给出」两个节点，会制造一条两来源完全重合的边，
   增加节点数而不增加信息，且与 `docs/VISION.md`「审计面固定在里程碑」的减负方向相反。
3. **真正值得拆的另有其物（可选，优先级低）**：目标陈述当前把 `k ≠ 0` 写死，而 LZ 的动量假设是
   四条 (P1)–(P4)（§1.6），FGZ 是 `p ≠ 0`。这属于**假设对齐**问题，应在 gaps 里解决
   （现有 gap 已记），不必新建节点。

#### 11.5.3 `worldsheet.no-ghost-theorem-subcritical--via-lian-zuckerman`（若已建）

同 11.5.1 的第二条：把 reality condition `σλ = −λ` 加进 gaps；
并可在 sources.note 里补 §11.4 第 3 条的两句作者自述（"physical Hilbert space" / "particle spectrum"）。

### 11.6 本节仍未核实的部分

1. **`Theorem 2.25` 假设行的下标**：仍未直接判读（只有平行陈述佐证）。
2. **`Corollary 2.20` 证明里的 "Remark 2.13(iii)"**：未单页复核，OCR 误读 vs 原文交叉引用错误未分辨。
3. **`Lemma 2.18` 里「B ⊆ rad A」**：扫描渲染像 "BC ⊆ rad A"，按 `Corollary 2.20` 的对应条件
   （"U ⊂ rad V"）读作 **B ⊆ rad A**；未单页复核。
4. **reality condition 在 D=26、h=1 下是否自动满足**：未验。
5. 与本节无关但仍开着的 §10 各条不变。
