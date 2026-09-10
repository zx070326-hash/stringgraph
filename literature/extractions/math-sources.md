# 数学侧一手来源：可引编号的标准教材定理

- 负责 agent：researcher
- 日期：2026-09-10
- 触发：图节点 `laplacian-log-contact-term`（`∂∂̄ ln|z|² = 2πδ²(z,z̄)`，二维）目前**只因缺数学文献来源**而标 `physical-argument`
- 本文件不套 `templates/extraction.md`，是一个「数学教材定理登记簿」（按需追加小节），
  与 `extractions/primary-sources-round2.md`、`extractions/brst-cohomology-sources.md` 配套阅读
- 用途：给弦论侧那些**本身就是标准数学事实、只是物理书不给数学来源**的节点补一手出处，
  使其有效状态不必被物理书的推导方式压低

## 0. 证据等级约定（与 `primary-sources-round2.md`、`brst-cohomology-sources.md` 一致）

| 等级 | 含义 |
|---|---|
| L1 | 我逐页读了原文（扫描件/正文 PDF 页图），可照抄措辞 |
| L2 | 出版方权威元数据（Crossref / AMS / 出版社目录页） |
| L3 | 可溯源二手陈述（公开讲义正文里对该定理的引用） |
| L4 | 检索后端中介读取（WebSearch 摘要读 PDF/网页），**非逐字，不得单独作为唯一依据** |
| L0 | 未能核实 |

---

## 1. 需求侧：图里到底要一条什么定理

`laplacian-log-contact-term` 要的是二维 Laplace 算子的**基本解**这条陈述本身，即
「`ln|x|` 的分布意义下的 Laplace 算子是 `2π` 乘 Dirac 测度」。

注意区分**两条不同的数学陈述**，它们在标准教材里的地位不一样：

| | 陈述 | 谁给 |
|---|---|---|
| (A) | `−ΔΦ = δ_0` 本身（`Φ` 是基本解） | **Lieb–Loss Theorem 6.20**（见 §2） |
| (B) | `u = Φ * f` 解 `−Δu = f` | Lieb–Loss Theorem 6.21；**Evans §2.2.1 的那条定理是 (B)，不是 (A)**（见 §4.1） |

图节点要的是 **(A)**。这一点很要紧：候选里最常被引的 Evans，正文给的是 (B)。

---

## 2. ★ 已核实、可直接引用：Lieb–Loss, *Analysis*, 2nd ed., **Theorem 6.20**（L1）

### 2.1 获取途径（可复用）

- 多伦多大学 MAT1000 课程页公开挂出的**第 6 章扫描**：
  `https://www.math.utoronto.ca/almut/MAT1000/LL-6.pdf`（36 页，覆盖书上 p.135–170）。
- WebFetch 该 URL 会把 PDF 落盘并打印本地路径，再用 `Read` 带 `pages` 逐页读图。
  （与 `reading-list.md` 里记的 Project Euclid / arXiv 同一套办法。）
- 该扫描件的**第 1 页就是书名页**，逐字为：
  「ANALYSIS / SECOND EDITION / Elliott H. Lieb — Princeton University / Michael Loss — Georgia Institute of Technology /
  Graduate Studies in Mathematics / Volume 14 / American Mathematical Society / Providence, Rhode Island」。
  **版次（SECOND EDITION）、系列、卷号 14、出版方均为 L1；出版年份 2001 不在该页上（版权页未含在扫描件里），按 AMS 目录记，为 L2/L4。**
- 第 2 页起是「Chapter 6 — Distributions」，`6.1 INTRODUCTION` 起于书上 **p.135**。

### 2.2 Green 函数的定义（书上 **p.155**，`Sections 6.18–6.19` 页眉下，编号 (2)；L1 逐字）

> An amusing—and useful—exercise in the computation of distributional derivatives is the computation of
> Green's functions. Let `y ∈ ℝⁿ`, `n ≥ 1`, and let `G_y : ℝⁿ → ℝ` be defined by
>
> `G_y(x) = −|S¹|^{−1} ln(|x − y|)`, &nbsp;&nbsp; `n = 2`,
> `G_y(x) = [(n−2)|S^{n−1}|]^{−1} |x − y|^{2−n}`, &nbsp;&nbsp; `n ≠ 2`, &nbsp;&nbsp;&nbsp;&nbsp; (2)
>
> where `|S^{n−1}|` is the area of the unit sphere `S^{n−1} ⊂ ℝⁿ`.
> `|S⁰| = 2`, `|S¹| = 2π`, `|S²| = 4π`, `|S^{n−1}| = 2π^{n/2}/Γ(n/2)`.
> These are the **Green's functions for Poisson's equation in ℝⁿ**. Recall that the **Laplacian**, `Δ`,
> is defined by `Δ := Σ_{i=1}^{n} ∂²/∂x_i²`. The notation notwithstanding, `G_y(x)` is actually
> *symmetric*, i.e., `G_y(x) = G_x(y)`.

**`n = 2` 时即 `G_0(x) = −(1/2π) ln|x|`。** 注意 Lieb–Loss 明确写出 `Δ := Σ ∂²/∂x_i²`（正号、无号差歧义），
这条对本项目很重要——它把「度规号差」这个坑排除在外。

### 2.3 定理原文（书上 **p.156**；L1 逐字）

> **6.20 THEOREM (Distributional Laplacian of Green's functions)**
>
> *In the sense of distributions,*
>
> &nbsp;&nbsp;&nbsp;&nbsp; `−ΔG_y = δ_y`, &nbsp;&nbsp;&nbsp;&nbsp; (1)
>
> *where* `δ_y` *is Dirac's delta measure at* `y` *(often written as* `δ(x − y)` *).*

- 类型：proposition（定理，带完整证明）
- 文献自称的严格程度：标题即 `THEOREM`，正文给了完整 `PROOF`（p.156 一整页：取 `y = 0`，
  要求 `I := ∫_{ℝⁿ}(Δφ)G_0 = −φ(0)` 对 `φ ∈ C_c^∞(ℝⁿ)`；用 `G_0 ∈ L¹_loc` 归约到
  `−φ(0) = lim_{r→0} I(r)`，`I(r) := ∫_{|x|>r} Δφ(x)G_0(x)dx`；两次分部积分，
  用球面上 `∇G_0·ν = |S^{n−1}|^{−1} r^{−n+1}` 得 `−|S^{n−1}|^{−1}∫_{S^{n−1}} φ(rω)dω → −φ(0)`）。
  **这是一条真正的、被证明的数学定理，不是「形式操作」。**
- 文献列出的依赖：`G_0 ∈ L¹_loc`；分部积分/散度定理；`φ ∈ C_c^∞`。全在同一章内自足。
- 证据等级：**L1**

### 2.4 配套定理（书上 **p.157**；L1 逐字，登记备用）

> **6.21 THEOREM (Solution of Poisson's equation)**
>
> *Let* `f ∈ L¹_loc(ℝⁿ)`, `n ≥ 1`. *Assume that for almost every* `x` *the function* `y ↦ G_y(x)f(y)`
> *is summable (here,* `G_y` *is Green's function given before 6.20) and define the function*
> `u : ℝⁿ → ℂ` *by* `u(x) = ∫_{ℝⁿ} G_y(x) f(y) dy` (1). *Then* `u` *satisfies:*
> `u ∈ L¹_loc(ℝⁿ)` (2), `−Δu = f` *in* `D'(ℝⁿ)` (3).

其 REMARKS (1) 明确说 `ℝⁿ` 可换成任意开集 `Ω ⊂ ℝⁿ`。REMARKS (2) 给出可和性条件的等价形式
（`n = 2` 时权重是 `ln(1+|y|)`）。

---

## 3. 从 Lieb–Loss 6.20 到 Polchinski (2.1.24) 的换算

Polchinski (2.1.24)（[S] 目录已核实，见 `polchinski-1998-v1.md` E26）写的是

> `∂∂̄ ln|z|² = 2π δ²(z, z̄)`

而 Lieb–Loss 6.20（`n = 2`）给的是 `Δ ln|x| = 2π δ_0`（`δ_0` 是**相对 Lebesgue 测度 `dσ¹dσ²`** 的 Dirac 测度）。
两者对上需要**两条约定输入**，缺一个就差因子 2：

| 输入 | 内容 | 出处与等级 |
|---|---|---|
| (i) | `∂ = ½(∂₁ − i∂₂)`、`∂̄ = ½(∂₁ + i∂₂)`，故 **`∂∂̄ = ¼Δ`** | Polchinski (2.1.3)；[S] §2.2（笔记 p.43）[2.2] 逐字给出这两式，**L1** |
| (ii) | `d²z = dz dz̄ = 2 dσ¹dσ²`，且 `δ²(z,z̄)` 是相对 `d²z` 归一化的密度，即 **`δ²(z,z̄) = ½ δ(σ¹)δ(σ²)`** | Polchinski (2.1.7)（Jacobian）+ Polchinski **前言 p. xviii 的 delta 函数约定**；[S] §2.4（笔记 p.44）[2.8] 逐字算出 `d²z = 2dσ¹dσ²`，[S] §2.6 两次写「the delta function convention from p xviii」并用 `2π·½δ(σ¹)δ(σ²)`，**L1** |

代入即得（**这一步的算术是抽取者自己做的，标为「researcher 推导」**）：

```
Δ ln|x| = 2π δ(σ¹)δ(σ²)                     [Lieb–Loss 6.20, n = 2]
ln|z|² = 2 ln|z|  ⇒  Δ ln|z|² = 4π δ(σ¹)δ(σ²)
∂∂̄ = ¼Δ           ⇒  ∂∂̄ ln|z|² = π δ(σ¹)δ(σ²)
δ²(z,z̄) = ½δ(σ¹)δ(σ²)  ⇒  2π δ²(z,z̄) = π δ(σ¹)δ(σ²)
⇒  ∂∂̄ ln|z|² = 2π δ²(z,z̄)   ✓ 与 (2.1.24) 逐字一致
```

**独立佐证（不是抽取者的推导，是文献里现成的验算，L1）**：
[S] §2.6「p 36: Eq. (2.1.24) `∂∂̄ ln|z|² = 2πδ²(z,z̄)`」，笔记 **p.45**（2020-11-21 版）把整条式子按 `σ^a`
坐标验算了一遍：`RHS = ∫d²σ 2π·½δ(σ¹)δ(σ²) = π`（[2.12]），
`LHS = ∫d²σ ¼(∂₁²+∂₂²)ln(σ₁²+σ₂²) = … = ½∮_C (σ₁dσ₂ − σ₂dσ₁)/(σ₁²+σ₂²) = ½∮dθ = π`（[2.13]–[2.15]），
结论句「and so LHS = RHS, proving (2.1.24)」。
即：**[S] 用 Stokes 定理做的是同一件事，只是没引任何分布论文献；Lieb–Loss 6.20 正是它缺的那块严格基础。**

**因子 2 是个真陷阱**：如果把 `δ²(z,z̄)` 误当成 `δ(σ¹)δ(σ²)`，(2.1.24) 的系数就该是 `π` 而不是 `2π`。
所有涉及 `(2.1.24)`、`XX` 传播子归一化（E25）、`α'` 因子的节点都吃这条约定。

---

## 4. 未能核实编号的候选（**不登记进 `sources.bib`**）

### 4.1 Evans, *Partial Differential Equations*, 2nd ed. (2010), §2.2.1 —— **候选、编号未核实（L0）**

- 任务给的候选是「§2.2.1 中『`Φ` 是基本解 / `−ΔΦ = δ`』的定理编号」。
- **未能在任何公开可见页面核实到 Evans 自己的定理编号。** Evans 的体例是**按节重新编号**
  （节内写 `THEOREM 1`、`THEOREM 2`…），所以引用只能写成「Evans (2010), §2.2.1, Theorem 1」这种形式，
  而这个字符串在公开网页上检索不到；AMS bookstore 页 **403**，ProofWiki 的该书条目页 **403**，
  目录页只到节标题一级，不含定理号。
- **能核实到的（L1，逐页读图）**：Stanford Math 220B 公开讲义
  `https://web.stanford.edu/class/math220b/handouts/laplace.pdf`（"3 Laplace's Equation"）：
  - 其 (3.3) 逐字给 `Φ(x) = −(1/2π)ln|x|`（`n = 2`）、`1/(n(n−2)α(n)) · 1/|x|^{n−2}`（`n ≥ 3`），
    `α(n)` 是单位球体积——**与 Evans 的 `Φ` 归一化同一套**（`α(n)` 就是 Evans 的记号）；
  - 其 **Theorem 2**（`f ∈ C²(ℝⁿ)` 且紧支撑，`u = Φ * f` ⇒ `u ∈ C²`、`−Δu = f`）下面**逐字写着
    「*Ref: Evans, p. 23.*」** ⇒ Evans 的该定理位于**书上 p.23**（L1 读到的是讲义的这句引用，属对 Evans 的 **L3** 证据）；
  - **关键区别**：同一讲义把 `−Δ_xΦ = δ_0` 单列为它**自己的** "Claim 1"，**没有**标 Evans。
    这与「Evans §2.2.1 的定理是 (B) 型（`−Δ(Φ*f) = f`）而不是 (A) 型（`−ΔΦ = δ`）」一致。
- **结论**：Evans 即使把编号核实出来，**也不是 `laplacian-log-contact-term` 最贴的来源**（它给的是 (B)）。
  按 `literature/CLAUDE.md` 的口径，此条记为「**候选、编号未核实**」，不入 `sources.bib`，
  也不建议 curator 现在拿它填 `sources[].loc`。

### 4.2 Hörmander, *ALPDO I* (1983/1990), §3.3 —— **候选、编号未核实（L0）**

- 章节标题「**Some Fundamental Solutions**」（第 III 章，前接 3.1 "Definition and Examples"、
  3.2 "Homogeneous Distributions"，后接 3.4 "Evaluation of Some Integrals"）——**L4，仅检索后端转述，未见页图**。
- 定理编号（曾猜 `Theorem 3.3.2`）**完全未核实**；且 1983 第 1 版与 1990 第 2 版/Classics 重印**编号可能不同**。
- 本轮没有找到公开可见、可逐页读的合法页面（搜到的全本扫描站点不采信）。**不入 `sources.bib`。**

### 4.3 Lieb–Loss Theorem 6.20 与 6.21 的关系（避免以后引错）

`6.20` 是 (A)（`−ΔG_y = δ_y`），`6.21` 是 (B)（Poisson 方程可解性）。
任务书里写的「Lieb–Loss Theorem 6.20/6.21」两个号**都真实存在且都已核实**，但**只有 6.20 是图节点要的那条**。

---

## 5. 图里建议怎么引（供 curator 取舍；researcher 不改 `graph/`）

针对节点 `laplacian-log-contact-term`：

```yaml
sources:
  - ref: lieb-loss-2001
    loc: "§6.20 (Theorem, Distributional Laplacian of Green's functions), p. 156;
          Green 函数定义见 p. 155 eq. (2)"
  - ref: polchinski-1998-v1
    loc: "§2.1, eq. (2.1.24)"        # 已核实（[S] 目录 2.6 p 36）
```

配套建议（**均为建议，researcher 不代 curator/auditor 决定**）：

1. **必须显式挂两条约定边**，否则 `2π` 这个系数在图里是悬空的：
   - `d²z = 2dσ¹dσ²` 与 `δ²(z,z̄) = ½δ(σ¹)δ(σ²)`：来源是 **Polchinski 前言 p. xviii + (2.1.7)**，
     不是 §2.1 正文。`graph/conventions/` 现在（据 `polchinski-1998-v1.md` §1.2 的对照表）**没有**这条，
     建议新增一个 `family: delta-normalization` 的约定节点。
   - `∂∂̄ = ¼Δ`：Polchinski (2.1.3)。
2. **换算这一步若单独成 derivation，应标 `inferred: true`**：Lieb–Loss 不提复坐标、
   Polchinski 也不引 Lieb–Loss，两边没有互引。可在 note 里写「[S] §2.6（笔记 p.45）给了同一验算的显式计算」。
3. **`status` 的建议**：把「`∂∂̄ ln|z|² = 2πδ²`」这条**纯数学恒等式**与 E26 里跟它捆在一起的另半句
   「算子形式的运动方程只在不重合处成立、重合处的接触项由路径积分场重定义给出」**拆成两个节点**。
   前者有了 Lieb–Loss 6.20 + 两条约定之后，是**有严格数学来源**的（`rigorous` 量级）；
   后者仍是路径积分形式操作（`physical-argument`）。
   现在把两者放一个节点，会让前者被后者压低，也会让后者被前者抬高——两个方向都不实话实说。
4. **形式化侧**：本轮**没有**检索 Mathlib 是否已有二维 Laplace 基本解
   （`−Δ(−(1/2π)log‖x‖) = δ₀` 的分布版本）。留给 `formalizer`；这是 `formal/` 的一个低风险候选岛。

---

## 6. 访问日志（本轮，供后人省事）

| 目标 | URL / 手法 | 结果 |
|---|---|---|
| Lieb–Loss 第 6 章 | `https://www.math.utoronto.ca/almut/MAT1000/LL-6.pdf` | **成功**（PDF 落盘 → `Read` 带 `pages` 读图，36 页；书上 p.135–170） |
| Stanford Math 220B Laplace 讲义 | `https://web.stanford.edu/class/math220b/handouts/laplace.pdf` | **成功**（同上手法，见 §4.1） |
| Schrans 伴读笔记（2020-11-21 版） | `https://hepnotes.com/wp-content/uploads/2020/11/joes-book-1.pdf` | **成功**（5.2 MB；首次调用报「域名无法验证」，**重试即通过**） |
| Schrans 伴读笔记（2020-04-30 版） | `https://hepnotes.com/wp-content/uploads/2020/04/joes-book-1.pdf` | **成功**（3.9 MB；用于两版比对） |
| AMS bookstore（Lieb–Loss GSM 14.R 目录） | `https://bookstore.ams.org/view?ProductCode=GSM/14.R` | **403** |
| ProofWiki（Evans PDE 书目页） | `https://proofwiki.org/wiki/Book:Lawrence_C._Evans/Partial_Differential_Equations` | **403** |
| Headrick 解答手册 | `https://arxiv.org/pdf/0812.4408`、`…v1`、`https://ar5iv.org/abs/0812.4408` | **全部失败**：「Unable to verify if domain … is safe to fetch」。**本次会话 `arxiv.org` 与 `ar5iv.org` 均被环境拦截**（与 `reading-list.md` 记的「arXiv 可用」不符，疑为临时限制） |

> **新增死路/活路，建议合并进 `reading-list.md` 的「已知获取路线备忘」**：
> - `bookstore.ams.org`、`proofwiki.org`：403。
> - `hepnotes.com`、`www.math.utoronto.ca`、`web.stanford.edu`：可用（PDF 落盘 + `Read pages` 手法）。
> - `arxiv.org` / `ar5iv.org`：**本次会话被拦截**（不是永久死路，下次先重试一次再放弃）。

---

## 7. 未解决 / 留给下一轮

- **Q1** Evans (2010) 自己的定理编号（§2.2.1 里那条是 `Theorem 1` 吗？）—— 需要持原书者一句话即可结案。
  但按 §4.1 的分析，**结不结案都不影响** `laplacian-log-contact-term` 的来源选择。
- **Q2** Hörmander ALPDO I §3.3 的定理编号，以及 1983/1990 两版是否一致。
- **Q3** Polchinski 前言 **p. xviii** 的 delta 函数约定原文措辞未核对（现在只有 [S] 两次转述「the delta function
  convention from p xviii」，L1 读到的是 [S] 的转述，对 Polchinski 是 **L3**）。
  这条是 §3 里因子 2 的支点，值得让持原书者抄一句。
- **Q4** Lieb–Loss 第 2 版的**出版年**（2001）只有 L2/L4：扫描件的书名页不含版权页。
  引用前若要写死年份，建议以 AMS 目录为准并在 bib note 里说明。
- **Q5** 本文件只解决了 Laplace 基本解这一条。同类「物理书不给数学来源」的候选还有：
  OPE 收敛性（`polchinski-1998-v1.md` Q3）、态-算子同构（E44）、Faddeev–Popov 测度（E50）。
  其中**只有第一条有希望在标准数学文献里找到带编号的定理**（径向排序/顶点代数方向），后两条大概找不到。
  → **本文件 §8 起已开工**（2026-09-10 第二轮，researcher）。

---

# § OPE / 顶点代数

- 负责 agent：researcher
- 日期：2026-09-10（第二轮）
- 触发：图节点 `worldsheet.operator-product-expansion` 目前是 `physical-argument`，
  且是 Weyl 反常路线与一切 OPE 推导的**瓶颈根**。目标：在数学文献里找**带编号的定理**，
  使「OPE 存在且收敛」这一半可以脱离物理论证。
- 证据等级沿用本文件 §0 的 L0–L4 表。
- **本节最重要的方法论结论先写在前面**：数学文献里被证明的东西**不是一条**，而是**至少三条不同强度的陈述**
  （形式分布局域性 / 复解析局域性 / 解析收敛的 OPE），它们之间的等价性本身是定理。
  图里不拆开就一定会把状态标错。详见 §12。

---

## 8. ★ 候选 1（已核实 L1，全文到手）：Bin Gui, *Lectures on Vertex Operator Algebras and Conformal Blocks*

### 8.0 文献标识与**版本陷阱（必读）**

| 项 | 值 | 等级 |
|---|---|---|
| 作者 | Bin Gui（清华大学 YMSC） | L1（PDF 封面页） |
| 标题 | *Lectures on Vertex Operator Algebras and Conformal Blocks* | L1（封面页） |
| arXiv | **2305.03822**（v1 提交 2023-05-05） | L4（WebSearch 后端；未直接打开 arXiv） |
| 我实际读的版本 | 作者主页 PDF `https://binguimath.github.io/Files/2022_VOA_Lectures.pdf`，**封面页逐字写「Last update: July 15, 2026」** | **L1** |
| 篇幅 | 正文 179 页 + 索引 + 参考文献；17 节 + 附录 A | L1（目录页） |
| 来历 | 前言逐字：「This monograph is the lecture notes of a course I gave in 2022 spring at Tsinghua University, Yau Mathematical Sciences Center.」致谢页署「May 2022」 | L1 |

> **版本陷阱**：作者主页明说主页版可能比 arXiv 版新，而我拿到的这份是 **2026-07-15 更新版**。
> **下面所有编号（Def 7.2、Thm 7.17、Thm 8.1 等）只对这份 2026-07-15 主页版核实过；
> arXiv:2305.03822 各版的编号是否相同，本轮未核实（L0）。**
> 引用时 `loc` 必须写死版本日期，例如「Gui, *Lectures on VOAs and Conformal Blocks*, 2026-07-15 版, Def. 7.2」。
> 这与 Kac–Raina 那个「两版讲数不同」的坑同类（见 `sources.bib` 的 `kac-raina-1987` note）。

### 8.1 为什么这篇正中要害（前言逐字，L1，书上 p.2）

> A key feature of this monograph is the emphasis on the *complex analytic* aspects of VOAs and conformal blocks.
> We prove many well-known results by first proving the convergence (more precisely: absolute and locally uniform (a.l.u.)
> convergence) of correlation functions which are defined a priori as formal power/Laurent series of some formal variables.
> These results include Dong's Lemma and Goddard uniqueness (and hence the reconstruction theorem), construction of
> contragredient modules, local freeness of sheaves of conformal blocks for `C₂`-cofinite VOAs (and families of compact
> Riemann surfaces).

> The usual algebraic approaches to VOAs (e.g. [Kac, LL]) avoid showing the convergence of such series. In geometry, this
> means not considering analytic sewing, but only formal and infinitesimal sewing. As a compensation, formal calculus and
> delta functions are heavily used in these approaches. An advantage of our complex analytic approach is that by showing
> that these functions are convergent, one can view the correlation functions as genuine functions but not just formal
> series, so one can understand the nature of VOAs and conformal blocks in a similar way as physicists do.

**这段就是本项目要的那句话**：Kac / Lepowsky–Li 的算子代数路线**刻意回避**收敛性，
Gui 这本是**专门把收敛性证出来**的那本。这直接决定了候选 3（Kac）与候选 1 的分工。

### 8.2 「三个版本的局域性」——本节的核心结构（L1，书上 p.69 §7.1 逐字）

> **7 Local fields**
> **7.1** Having explored some important examples, we now return to the general theory. The goal of this section is to
> understand the close relationship between the three statements in Subsec. 5.8. The precise formulation of statement 1
> is the Lie bracket version of local fields, as defined in Def. 5.9 and Rem. 5.10. For statement 2 we give two rigorous
> descriptions: the complex analytic version and the formal variable version of local fields. We first give the complex
> analytic version, which is more intuitive.

被指回的 **§5.8（书上 p.54）三条陈述逐字（L1）**：

> In a very vague sense, any of the following three statements implies the others without assuming the full Jacobi identity.
> 1. Suitable Lie bracket relations hold for a pair of field operators `A(z₂), B(z₁)`.
> 2. The finite poles of (the analytic continuation of) `⟨w′, A(z₂)B(z₁)w⟩` at `z₂ = z₁`.
> 3. The finitely many singular terms in the OPE of `A(z₂)B(z₁)` and, in particular, *the existence of such OPE*.
>
> Clearly, the third one a priori implies the second one, since the second does not assume the existence of OPE. Thus, as
> we have said that OPEs are roughly the same as associativity, we see that the associativity (and indeed, the full Jacobi
> identity) can be derived from the first or the second statement above. This is called the **reconstruction theorem** …
> A rigorous and detailed discussion of the equivalence of the above three statements will be given in Sec. 7.

### 8.3 三个「局域性」定义的逐字转录（L1）

**(a) Lie 代数版 —— Definition 5.9（书上 p.55）**

> **Definition 5.9 (Local fields (Lie algebraic version)).** Given homogeneous fields `A(z)` and `B(z)`, we say `A(z)`
> is **local** to `B(z)` if there exist `Cʲ(z) = Σ_{n∈ℤ} C_n^j z^{−n−1} ∈ End(𝕍)[[z^{±1}]]`
> (where `j = 0, 1, …, N−1` for some `N ∈ ℕ`) satisfying
>
> &nbsp;&nbsp;&nbsp;&nbsp; `[A_m, B_k] = Σ_{l=0}^{N−1} (m choose l) C^{(·)}_{m+k−l}` &nbsp;&nbsp;&nbsp;&nbsp; (5.27)
>
> for all `m, k ∈ ℤ`. We consider the right hand side of (5.27) as 0 if `N = 0`.

> ⚠ **转录疑点（引用前须复核原页）**：(5.27) 右端 `C` 的**上标**在页图上难以判读；
> 按求和指标 `l` 与上文 `Cʲ, j = 0,…,N−1` 的定义，几乎肯定是 `C^l_{m+k−l}`，但我不把它写死。
> **curator 若要把 (5.27) 抄进图里，必须让人复核这一个上标。**
> 与 `lian-zuckerman-1991` 的转录疑点同类处理。

配套 **Remark 5.10（书上 p.55）**给出等价形式：`A(z)` 局域于 `B(z)` **iff** 存在
`D⁰(z), …, D^{N−1}(z) ∈ End(𝕍)[[z^{±1}]]` 使 `[A_m, B_k] = Σ_{l=0}^{N−1} m^l D^l_{m+k}`（5.28）。
**Exercise 5.11** 要求用 (5.28) 证局域性的对称性（`A` 局域于 `B` ⇒ `B` 局域于 `A`）。

**(b) 复解析版 —— Definition 7.2（书上 p.70），本项目最想要的那条**

> **Definition 7.2 (Local fields (complex analytic version)).** We say `A(z)` and `B(z)` are **local** to each other if
> for each `v ∈ 𝕍, v′ ∈ 𝕍′` the following hold.
>
> 1. The series
>    `⟨v′, A(z₁)B(z₂)v⟩ := Σ_{n∈ℕ} ⟨v′, A(z₁) P_n B(z₂) v⟩`  (7.2a)
>    `⟨v′, B(z₂)A(z₁)v⟩ := Σ_{n∈ℕ} ⟨v′, B(z₂) P_n A(z₁) v⟩`  (7.2b)
>    converge a.l.u. respectively on the open sets `Ω₁ = {(z₁,z₂) ∈ ℂ² : 0 < |z₂| < |z₁|}` and
>    `Ω₂ = {(z₁,z₂) ∈ ℂ² : 0 < |z₁| < |z₂|}`. So (7.2a) and (7.2b) are automatically holomorphic functions on `Ω₁` and `Ω₂`.
> 2. (7.2a) and (7.2b) can be analytically continued to the same holomorphic function `f_{v,v′}` on `Conf²(ℂ^×)`.
>    Moreover, there exists `N ∈ ℕ` depending only on `A, B` but not on `v, v′` such that the function
>    `(z₁ − z₂)^N f_{v,v′}(z₁, z₂)`  (7.3)
>    is holomorphic on `ℂ^× × ℂ^×`.
>
> Roughly speaking, this definition says that (7.2a) and (7.2b) converge a.l.u on `Ω₁, Ω₂` and extend to the same
> holomorphic function on `Conf²(ℂ^×)` which has poles of order at most `N` at `z₁ = z₂`, where `N` is independent of `v, v′`.

其中 **Definition 7.1（书上 p.69）**逐字定义 a.l.u.：

> **Definition 7.1.** Let `Ω` be a locally compact Hausdorff space. A series of functions `Σ_n f_n` is said to
> **converge absolutely and locally uniformly (a.l.u.)** on `Ω` if each `x₀ ∈ Ω` is contained in a neighborhood `U` such that
> `sup_{x∈U} Σ_n |f_n(x)| < +∞`. Equivalently, for each compact subset `K ⊂ Ω`, we have `sup_{x∈K} Σ_n |f_n(x)| < +∞`.

`P_n : 𝕍^cl = Π_{m∈ℕ}𝕍(m) → 𝕍(n)` 是分次投影（书上 p.70 §7.2，指回 (3.18)）。
**注意 (7.2a)/(7.2b) 的求和是对分次指标 `n` 求和，不是对模式指标求和**——
即「插入完备基」那种求和，正是物理侧「插入 `Σ_n |n⟩⟨n|`」。

**(c) 形式变量版 —— Definition 7.6（书上 p.72）**

> **Definition 7.6 (Local fields (formal variable version)).** There exists `N ∈ ℕ` depending only on `A` and `B` such that
> the equation
>
> &nbsp;&nbsp;&nbsp;&nbsp; `(z₁ − z₂)^N [A(z₁), B(z₂)] = 0` &nbsp;&nbsp;&nbsp;&nbsp; (7.10)
>
> holds on the level of `End(𝕍)[[z₁^{±1}, z₂^{±1}]]`.
>
> This version of local fields is the most common in the literature, partly because it is the most concise. Indeed, since
> locality implies Jacobi identity, many people use locality instead of Jacobi identity in the definition of VOAs. We do not
> take this approach because locality has its own limitation: in the definition of VOA modules and conformal blocks, we
> need the full Jacobi identity, but not just locality.

（§7.6–§7.7 还逐字警告：`(z₁−z₂)^N f = 0` **不**蕴含 `f = 0`，因为 `ℂ[[z₁^{±1},z₂^{±1}]]` 有「零因子」且不是环；
`Lemma 7.7`：`𝔽` 是域 ⇒ `𝔽((z))` 是域，于是在 `ℂ((z₁))((z₂))` 里 `(z₁−z₂)^N` **不是**零因子。
这一段是「形式版与解析版为什么不是平凡等价」的技术核心。）

### 8.4 等价性怎么被证的：**没有一条编号定理，是一张箭头图 + 五个小节**（L1，书上 p.73–p.78）

§7.7（书上 p.73）逐字：

> Each of the three versions has its own advantage, and it is the goal of this section to prove the equivalence of them.
> This is a crucial step for proving the reconstruction theorem. Moreover, note that in each of these three versions there
> is a number `N`. *We can prove the equivalence of the three versions for the same `N`.*
> The Lie algebraic version is the easiest to verify in concrete examples: we have already seen this in the previous section.
> In contrast, the complex analytic one is the most difficult to verify. But the complex analytic version is closest to how
> physicists understand local fields. So it allows us to prove results in a similar fashion as in physics literature. For
> instance: we will prove the existence of OPE using the complex analytic version of local fields. And with the help of OPE,
> we can prove that complex analytic implies Lie bracket version in the same way as deriving the algebraic Jacobi identity
> from the complex analytic one using residue theorem.

书上 **p.74** 有一张证明路线图。其节点与边标签逐字为：

```
Lie algebraic  --7.8-->  Formal variable  --7.9-->  Complex analytic
Complex analytic --7.10--> Formal variable
Complex analytic --7.11--> OPE  --7.12--> Lie algebraic
```

紧接着一句（L1）：

> From the above chart, we see that a direct proof from complex analytic to formal variable is not necessary for proving
> the equivalence of the three versions. We will still give such a proof because: In the VOA theory, many definitions and
> properties can be stated in both algebraic (i.e., formal variable) and complex analytic language. It is important to learn
> how to translate between these two.

**⚠ 关键否定结论：「三个版本等价」在本书里没有被写成一条带编号的定理。**
它是 §7.7 的散文断言 + §7.8–§7.12 五个小节的分段证明。
**因此绝不能在图里写「Gui Theorem 7.x：三种局域性等价」——不存在这个编号。**
能引的带编号对象是下面这些具体环节：

| 编号 | 书页 | 内容 | 核实 |
|---|---|---|---|
| **Definition 5.9** | p.55 | 局域性（Lie 括号版） | L1 逐字（上标有疑点） |
| **Remark 5.10** | p.55 | 与 (5.28) 的等价形式 | L1 |
| **Theorem 5.12** | p.55–56 | **Reconstruction theorem**（假设含「Locality: Any two fields of `ℰ` are local」） | L1 逐字（见 §8.6） |
| **Definition 7.1** | p.69 | a.l.u. 收敛的定义 | L1 逐字 |
| **Definition 7.2** | p.70 | 局域性（复解析版） | L1 逐字 |
| **Definition 7.3 / Lemma 7.4** | p.71 | 形式收敛；形式收敛与 a.l.u. 收敛互换的引理 | L1 |
| **Definition 7.6** | p.72 | 局域性（形式变量版） | L1 逐字 |
| **Lemma 7.7** | p.73 | `𝔽` 是域 ⇒ `𝔽((z))` 是域（说明 `(z₁−z₂)^N` 何时不是零因子） | L1 |
| §7.8 + **Lemma 7.9** | p.74–75 | Lie 代数版 ⇒ 形式变量版（组合恒等式） | L1 |
| §7.9 | p.75 | 形式变量版 ⇒ 复解析版；正文逐字标「The method is due to [FHL93]」 | L1 |
| §7.10 | p.76 | 复解析版 ⇒ 形式变量版 | L1 |
| **Definition 7.10 / Lemma 7.11 / Proposition 7.12 / Lemma 7.13** | p.77–78 | **OPE 的存在与 a.l.u. 收敛**（见 §8.5） | L1 逐字 |
| **Proposition 7.14 / Remark 7.15** | p.78 | 由 Def 7.2 推出 Jacobi 恒等式 (7.18) | L1 |
| **Definition 7.16** | p.79–80 | Jacobi 恒等式（复解析版） | L1 |
| **Theorem 7.17** | p.80 | 「The complex analytic and the algebraic versions of Jacobi identity are equivalent.」 | L1 逐字 |
| **Theorem 8.1 / Remark 8.2 / Theorem 8.4** | p.80–83 | `n` 点函数的 a.l.u. 收敛与解析延拓（见 §8.7） | L1 逐字 |

### 8.5 ★★ **Proposition 7.12** —— 「解析收敛的 OPE」这条陈述本身（书上 p.77，L1 逐字）

§7.11 引言逐字：

> In this subsection, we assume the statements in Def. 7.2, and derive the OPE
> `A(z₁)B(z₂) = Σ_{k∈ℤ} (z₁ − z₂)^{−k−1}(A_k B)(z₂)` similar to
> `Y(u,z₁)Y(v,z₂) = Σ_{k∈ℤ}(z₁−z₂)^{−k−1} Y(Y(u)_k v, z₂)` for some fields `(A_k B)(z)`. This is simply done by taking
> Laurent series expansions of the function `f_{v,v′}` in Def. 7.2. Thus, the existence of OPE simply follows from complex
> analysis. Since we are treating multivariable holomorphic functions, to be serious about the domain of a.l.u. convergence,
> we provide some details below.

> **Definition 7.10.** For each `k ∈ ℤ` and `z ∈ ℂ^×`, let `f_{v,v′} ∈ 𝒪(Conf²(ℂ^×))` be as in Def. 7.2. We define the
> linear map `(A_k B)(z) : 𝕍′ ⊗ 𝕍 → ℂ`, `v′ ⊗ v ↦ ⟨v′, (A_k B)(z)v⟩` to be
>
> &nbsp;&nbsp;&nbsp;&nbsp; `⟨v′, (A_k B)(z₂)v⟩ = ∮_{C(z₂)} (z₁ − z₂)^k f_{v,v′}(z₁, z₂) dz₁/(2iπ)` &nbsp;&nbsp;&nbsp;&nbsp; (7.14)
>
> where `C(z₂)` is any circle in `ℂ^×` surrounding `z₂`. …

> **Lemma 7.11.** `A_k B = 0` whenever `k ⩾ N`.
>
> *Proof.* When `k ⩾ N`, `(z₁ − z₂)^k f_{v,v′}` has no poles at `z₁ = z₂`. So the RHS of (7.14) vanishes. □

> **Proposition 7.12.** *For each* `v ∈ 𝕍, v′ ∈ 𝕍′`, *we have*
>
> &nbsp;&nbsp;&nbsp;&nbsp; `f_{v,v′}(z₁, z₂) = Σ_{k∈ℤ} (z₁ − z₂)^{−k−1} ⟨v′, (A_k B)(z₂)v⟩` &nbsp;&nbsp;&nbsp;&nbsp; (7.15)
>
> *where the series on the RHS converges a.l.u. on* `Ω₀ = {(z₁,z₂) : 0 < |z₁ − z₂| < |z₂|}` *to the LHS.*
>
> *Proof.* It suffices to prove the claim on `{(z₁,z₂) : 0 < |z₁−z₂| < r, r ⩽ |z₂|}` for all `r > 0`. Then this follows
> easily from the following basic lemma. □

（其后的 **Lemma 7.13** 是多变量 Laurent 展开的一般引理，(7.16)–(7.17)。）

**这就是图里 `worldsheet.operator-product-expansion` 想要的那条数学定理的最贴近版本**：
- 它**断言 OPE 系数场存在**（`A_k B` 由围道积分 (7.14) *定义*，不是假设的）；
- 它**断言收敛**，而且是 a.l.u. 收敛，**带明确的收敛域** `0 < |z₁−z₂| < |z₂|`；
- 它**断言奇异项有限**（Lemma 7.11：`k ⩾ N` 时 `A_kB = 0`）。
- **代价**：前提是 Def. 7.2（复解析局域性）。也就是说这是「**复解析局域性 ⇒ OPE 存在且收敛**」，
  不是凭空的「OPE 收敛」。**图里这条边必须显式画出来，否则等于偷了假设。**

### 8.6 Theorem 5.12（Reconstruction theorem，书上 p.55–56，L1 逐字）

> **Theorem 5.12 (Reconstruction theorem).** *Let* `ℰ` *be a set of* `L₀`*-homogeneous fields on* `𝕍`*. Assume that the
> following conditions are satisfied. Then* `𝕍` *has a unique graded vertex algebra structure such that each* `A(z) ∈ ℰ`
> *is a vertex operator (namely, is of the form* `Y(u,z)` *for some* `u ∈ 𝕍`*), and that the vacuum vector* `1` *and the
> operator* `L₋₁` *are those described in the following.*
> - *Creation property: There is a distinguished vector* `1 ∈ 𝕍(0)` *such that* `A(z)1` *has no negative powers of* `z`
>   *for all* `A(z) ∈ ℰ`.
> - *Translation property: There is a distinguished* `L₋₁ ∈ End(𝕍)` *such that* `L₋₁1 = 0`, *and that for each*
>   `A(z) ∈ ℰ` *we have* `[L₋₁, A(z)] = ∂_z A(z)`.
> - *Generating property: Vectors of the form* `A¹_{n₁} ⋯ A^k_{n_k} 1` *(where* `k ∈ ℕ`, `A¹(z),…,A^k(z) ∈ ℰ`, *and*
>   `n₁,…,n_k ∈ ℤ`*) span* `𝕍`.
> - ***Locality: Any two fields of*** `ℰ` ***are local.***
>
> *Moreover, if* `L₀, L₋₁` *can be extended to a sequence of operators* `(L_n)_{n∈ℤ}` *on* `𝕍` *such that*
> `Σ_{n∈ℤ} L_n z^{−n−2}` *belongs to* `ℰ`, *and that the Virasoro relation (2.7) is satisfied for some* `c ∈ ℂ`,
> *then* `𝕍` *is a VOA whose conformal vector* **c** *satisfies* `Y(**c**, z) = Σ_{n∈ℤ} L_n z^{−n−2}`.

对本项目的用处：这是**「只验局域性 ⇒ 得到整个顶点代数（含 Jacobi 恒等式 / 结合性）」**，
即物理书里「写下几条基本 OPE 就当作定义了整个 CFT」这一步的严格版本。

**⚠ 注意它*假设*了 Virasoro 关系与中心荷 `c`，*不推导* `c` 的值**——与 FGZ / LZ 同型
（见 `brst-cohomology-sources.md` §1、`primary-sources-round2.md` §1）。
**不能**用它去支持任何 `c = 26` 的结论。

### 8.7 `n` 点函数：Theorem 8.1 与 Theorem 8.4（书上 p.80–83，L1 逐字）

> **Theorem 8.1.** *Assume that the homogeneous fields* `A¹(z), …, A^M(z) ∈ (End𝕍)[[z^{±1}]]` *are mutually local. Then
> for each* `v ∈ 𝕍, v′ ∈ 𝕍′` *and each permutation* `σ` *of* `{1,…,M}`, *the series*
> `⟨v′, A^{σ(1)}(z_{σ(1)}) ⋯ A^{σ(M)}(z_{σ(M)}) v⟩ ∈ (End𝕍)[[z₁^{±1},…,z_M^{±1}]]` (8.1)
> *converges a.l.u. on* `Ω_σ = {z_• ∈ ℂ^M : 0 < |z_{σ(M)}| < ⋯ < |z_{σ(1)}|}` (8.2)
> *and can be extended to some* `f_{v,v′} ∈ 𝒪(Conf^M(ℂ^×))` *independent of* `σ`. *Moreover, there exists* `N ∈ ℕ`
> *for all* `v, v′` *such that the function* `f_{v,v′}(z_•) · Π_{1⩽i<j⩽M} (z_i − z_j)^N` (8.3)
> *is holomorphic on* `(ℂ^×)^M`. *(Indeed, it is an element of* `ℂ[z₁^{±1},…,z_M^{±1}]`.*)*

紧接着（书上 p.81，L1）：

> `f_{v,v′}` is called the `(M + 2)`**-point (genus 0 correlation) function** associated to the fields `A^•(z)`.

**这条才是物理书里「径向排序积的相关函数是单值解析函数、不同算子顺序互为解析延拓」的严格版本**——
它把「**与排序 `σ` 无关**」写死了，正对应物理侧的 radial ordering。
证明在 §8.2，正文逐字标「(Cf. [FHL93].)」。
**Remark 8.2** 说明 (8.1) 的 a.l.u. 收敛等价于逐级插入投影 `P_{n₂},…,P_{n_M}` 的多重级数 (8.5) 的收敛。

> **Theorem 8.4.** *Assume* `A¹,⋯,A^m, B¹,…,B^n` *are mutually local. Then on*
> `Ω = {(z₁,…,z_m, ζ₁,…,ζ_n) ∈ Conf^{m+n}(ℂ^×) : |z_i| > |ζ_j| for all i, j}`,
> *for each* `v ∈ 𝕍, v′ ∈ 𝕍′` *the RHS of*
> `⟨v′, A¹(z₁)⋯A^m(z_m)B¹(ζ₁)⋯B^n(ζ_n)v⟩ = Σ_{k∈ℕ} ⟨v′, A¹(z₁)⋯A^m(z_m) P_k B¹(ζ₁)⋯B^n(ζ_n) v⟩` (8.13)
> *converges a.l.u. to the LHS.*

Gui 对 Thm 8.4 的几何解释逐字：「it corresponds to the sewing of … `𝔛₁`, `𝔛₂` … along `0 ∈ 𝔛₁` and `∞ ∈ 𝔛₂`,
in case all these fields are vertex operators.」——即**插入完备基分解 = 缝合两个球面**，
正是物理侧 OPE / 因子化的内容。

### 8.8 Gui 自己划出的边界（诚实记录，避免超引）

- Def. 7.2 / Def. 7.6 / Def. 5.9 **都只讲「两个场之间」的局域性**；`M` 个场是 Thm 8.1。
- Gui 明确说复解析版**最难验证**、Lie 代数版最好验证（§7.7）。所以「物理里写下 OPE 就完事」在数学上
  对应的是**先验 Lie 代数版，再经 §7.8→§7.9 得到复解析版**，而不是直接验解析收敛。
- §5.7（书上 p.53）逐字给出 OPE 在 VOA 语境里的地位：
  > In physics, a series expansion of the form `A(z₂)B(z₁) = Σ_{m⩾−N} (z₂ − z₁)^m C^m(z₁)` is called the
  > **operator product expansion (OPE)** of the fields `A(z₂), B(z₁)`. Thus, in the VOA context, *OPEs are just the
  > associativity property* (4.9).

  并在 (5.24) 给出物理写法 `Y(u,z₂)Y(v,z₁) ∼ Y(Y(u)_{N−1}v, z₁)/(z₂−z₁)^N + ⋯ + Y(Y(u)_0 v, z₁)/(z₂−z₁)`。
  **即：Gui 认为「OPE = 结合性」，这与物理书把 OPE 当独立公理不同**，是图里 `operator-product-expansion`
  与 `vertex-algebra-associativity` 该不该是同一节点的直接证据。
- **本书的 `𝕍` 是 `ℕ`-分次、`L₀` 可对角化；CFT-type 假设（§5.5 逐字）是「`dim 𝕍(n) < +∞` for each `n`, and `𝕍(0) = ℂ1`」。**
  Gui 全程用 `𝕍′`-配对 `⟨v′, ·v⟩`（双线性配对），**不是**正定 Hilbert 内积，
  所以弦论的洛伦兹不定号本身**不构成障碍**；但**本书没有任何一处处理不定内积下的无鬼/幺正性问题**。
  这一条要与 `virasoro-lean-2025` 的限制 (2) 一起记（见 `sources.bib`）。
- 本书**不做**弦论：没有 `c = 26`、没有 Weyl 反常、没有路径积分。它给的是**世界面 CFT 的算子代数骨架**。

### 8.9 获取途径（可复用，L1）

| 目标 | URL / 手法 | 结果 |
|---|---|---|
| Gui 讲义全文 | `https://binguimath.github.io/Files/2022_VOA_Lectures.pdf` | **成功**。WebFetch 落盘（2.7 MB）→ `Read` 带 `pages` 读图。**PDF 页码 = 书上页码 + 1**（封面无页码；目录 = 书上 p.1 = PDF 第 2 页） |
| Gui 主页（论文与讲义列表） | `https://binguimath.github.io/` | **成功**。列出全部论文与讲义 PDF 直链（含另一本 *Conformal Blocks: Vector Bundle Structures, Sewing, and Factorization*，`/Files/2020_Conformal_Blocks.pdf`，本轮未读） |
| arXiv:2305.03822 | **本轮未尝试**（主页版更新且已到手） | — |

---

## 9. 候选 2（部分核实）：Frenkel & Ben-Zvi, *Vertex Algebras and Algebraic Curves*

### 9.0 文献标识

| 项 | 值 | 等级 |
|---|---|---|
| 作者 | Edward Frenkel, David Ben-Zvi | L2 |
| 标题 | *Vertex Algebras and Algebraic Curves* | L2 |
| 系列 | Mathematical Surveys and Monographs, **vol. 88**, AMS | L2/L4 |
| 版次 | 第 1 版 2001；**第 2 版 2004**，ISBN 0-8218-3674-9 / 978-0-8218-3674-3 | L4（检索后端 + 作者主页 `math.berkeley.edu/~frenkel/BOOK` 的 OUP 链接含 `isbn/0-8218-3674-9`） |
| DOI | 10.1090/surv/088 | L4 |

**全文未获取，且本轮判定为「无合法公开全文」**：
- `bookstore.ams.org` → 403（本文件 §6 已记）；`www.ams.org/bookstore/pspdf/surv-88-prev.pdf`（AMS 官方免费预览）→ **403**。
- 作者主页 `math.berkeley.edu/~frenkel/BOOK` **不挂全书 PDF**，只挂订购链接、书评链接、
  Bourbaki 综述（`bourbaki.ps` / `bourbaki.pdf`）与**勘误表**（见 §9.1）。
- `web.ma.utexas.edu/users/benzvi/math/book.html`（Ben-Zvi 主页）只有书的介绍文字，**无任何文件链接**。
- 检索结果里出现的 `nzdr.ru/...(2ed., web draft, 2004)(412s).pdf` 是**非官方全本扫描站**，
  按 `literature/CLAUDE.md` 规则 1 与本文件 §4.2 的既定口径 **不采信、不使用、不登记**。

### 9.1 ★ 已核实（L1）：**Theorem 3.2.1（结合性）**，来源是**作者本人的勘误表**

获取途径：`https://math.berkeley.edu/~frenkel/BOOK/corrections.pdf`（2 页，WebFetch 落盘 → `Read` 读图）。
标题页逐字：「CORRECTIONS AND UPDATES TO THE BOOK "VERTEX ALGEBRAS AND ALGEBRAIC CURVES"
BY EDWARD FRENKEL AND DAVID BEN-ZVI」。**这是作者本人对自己书的更正，权威性等同原书。**

勘误表 §3.2 条目**逐字全文（L1）**：

> **To § 3.2:** The statement of Theorem 3.2.1 needs to be modified as follows. By locality, for any `C ∈ V` the series
> `Y(A, z)Y(B, w)C` is the expansion in `V((z))((w))` of an element of the space `V[[z, w]][z^{−1}, w^{−1}, (z − w)^{−1}]`.
> We embed this space into `V((w))((z − w))` by sending `z` to `w + (z − w)` and `z^{−1}` to `(w + (z − w))^{−1}` considered
> as a power series in positive powers of `(z − w)/w`. Observe also that for degree reasons for any `C ∈ V` the power series
> `Y(Y(A, z − w)B, w)C` in `w` and `z − w` belongs to `V((w))((z − w))`.
>
> **3.2.1. Theorem.** *Any vertex algebra* `V` *satisfies the following associativity property: for all* `A, B, C ∈ V`
> *we have the equality in* `V((w))((z − w))`,
>
> &nbsp;&nbsp;&nbsp;&nbsp; `Y(A, z)Y(B, w)C = Y(Y(A, z − w)B, w)C,` &nbsp;&nbsp;&nbsp;&nbsp; (1)
>
> *where by the left hand side we understand its image in* `V((w))((z − w))` *under the map described above.*
>
> When we write that `Y(A, z)Y(B, w) = Y(Y(A, z − w)B, w)`, the equality should be understood in this sense.

勘误表还给了**简化证明**（用 **Proposition 3.2.8** 与 **Lemma 3.2.6**；这两个编号因此也 L1 核实存在），
并在证明后附 **Remark（L1 逐字）**：

> **Remark.** This proof shows that for large enough `N ∈ ℤ₊`, `z^N Y(Y(A, z−w)B, w)C` belongs to
> `V[[z, w]][w^{−1}, (z − w)^{−1}]`, and its image in `V[[z^{±1}, w^{±1}]]`, obtained by expanding `(z−w)^{−1}` in positive
> powers of `w/z`, equals `z^N Y(A, z)Y(B, w)C`. This suggests another interpretation of formula (1): for any `A, B, C ∈ V`
> and large enough `N ∈ ℤ₊` we have the identity
> `z^N Y(A, z)Y(B, w)C = z^N Y(Y(A, z − w)B, w)C` in `V[[z^{±1}, w^{±1}]]`.

勘误表其余两条（顺带 L1 记下，可能对图有用）：

> **To Remark 1.1.6:** The maximal `ℂ[z^{±1}, w^{±1}]`–submodule of `ℂ[[z^{±1}, w^{±1}]]` supported on the diagonal is
> spanned by the series `f(w)∂_w^i δ(z − w)`, where `f(w) ∈ ℂ[[w^{±1}]]` and `i ∈ ℤ₊`.

> **To Definition 4.1.1:** The second axiom should be modified as follows. For all `A, B ∈ V` and `C ∈ M`, the series
> `Y_M(A, z)Y_M(B, w)C` is the expansion of an element of `M[[z, w]][z^{−1}, w^{−1}, (z − w)^{−1}]` in `M((z))((w))`, and
> `Y_M(A, z)Y_M(B, w)C = Y_M(Y(A, z − w)B, w)C` in the sense of Theorem 3.2.1.

> ⚠ **版次陷阱**：这份 `corrections.pdf` 的 PDF 元数据显示由 **pdfTeX-0.14e 于 2001 年 9 月生成**
> （L4，WebFetch 摘要器读到的元数据，我没直接看元数据字段），即**很可能是第 1 版（2001）的勘误**；
> 第 2 版（2004）大概率已把这些更正吸收进正文。因此：
> **「Theorem 3.2.1 的措辞」我逐字拿到的是勘误版措辞，不是任何一版印本的正文措辞。**
> 但编号本身在第 2 版仍存在（见 §9.2 的 Google Books 定位）。

### 9.2 章节与页码定位（L4，Google Books 页码定位法，**带控制实验**）

用 `books.google.com/books?id=r82mAgAAQBAJ&q=<短语>`（该 volume id 对应 AMS 版，页码与下述目录一致）。
按本项目既有纪律，**这种查询只回页码、不回 snippet，只能当区间约束**。本轮跑了控制：

| 查询短语 | 返回页 | 判读 |
|---|---|---|
| `"Goddard's Uniqueness Theorem"` | **p.47** | ✔ **控制通过**：与目录「§3.1 Goddard's Uniqueness theorem, p.47」一致 |
| `"Theorem 3.2.1"` | **p.49** | ✔ 真实命中；与「§3.2 Associativity, p.48」一致 ⇒ **Theorem 3.2.1 在该版中存在** |
| `"operator product expansion"` | **p.51** | ✔ 与「§3.3 Operator product expansion, p.51」一致 |
| `"Theorem 3.3.1"` | **p.403** | ✘ 见下 |
| `"satisfies the following associativity property"`（勘误版措辞） | **p.403** | ✘ 见下 |

> **本轮新发现的方法论要点（建议并入 `reading-list.md` 的获取路线备忘）**：
> **Google Books 的 `&q=` 在「无命中」时似乎回落到一个固定页（本例为 p.403），而不是报告无结果。**
> 证据：一个**已知应当无命中**的短语（勘误版才有的措辞，印本正文很可能不含）与 `"Theorem 3.3.1"`
> 返回**同一个 p.403**，而三个已知应当命中的短语各自返回互不相同且与目录吻合的页码。
> 所以看到 p.403 要读成「**没查到**」，不能读成「在 p.403」。

**推论（证据等级 L4，且是弱的否定证据）**：
**书中很可能没有「Theorem 3.3.1」这个编号**，即 §3.3（OPE）里的内容多半不是以「Theorem 3.3.1」出现的。
任务书里假设的「§3.3 OPE 定理（约 Theorem 3.3.1 / Corollary 3.3.x）」**本轮未能证实，按 L0 处理**。
**绝不要在图里写 `Frenkel–Ben-Zvi, Theorem 3.3.1`。**

章节结构（**L4，检索后端读一份 web draft 目录后的转述，我没有亲眼看到目录页**）：

- Ch.1「Definition of Vertex Algebras」p.11：Formal distributions p.11 / **Locality p.16** / Definition of vertex algebra p.20 / Commutative vertex algebras p.22
- Ch.3「Associativity and Operator Product Expansion」p.47：Goddard's Uniqueness theorem p.47 / **Associativity p.48** / **Operator product expansion p.51** / Examples of OPE p.56

### 9.3 未核实的部分（老实记录）

- **任务书点名的 §2.1.5 / §2.5（Heisenberg 与 Virasoro 顶点代数）：本轮完全未核实（L0）。**
  Google Books 查 `"Heisenberg vertex algebra"` 返回 **p.262**，与「第 2 章」明显不符；
  按既有纪律（返回页不保证是首次出现，后面的交叉引用可能压过定义处），**这个页码不可用**。
  **不要拿它当 Heisenberg VOA 的定位。** 这一块的已核实替代来源仍是
  `virasoro-lean-2025`（Kytölä, Theorem 10.1 / Corollary 10.2，见 `sources.bib`）。
- §3.3 里 OPE 到底以什么形式（定理？定义？公式？）出现：**未核实**。
- 第 1 版与第 2 版之间编号是否一致：**只对 `Theorem 3.2.1` 有 L4 级正面证据**，其余一律不可跨版搬运。

### 9.4 ★ 对图最重要的一点：FBZ 的结合性/OPE **是纯形式的，没有收敛性**

Theorem 3.2.1 的等式成立的场所是 `V((w))((z − w))`、`V[[z^{±1}, w^{±1}]]`、
`V[[z, w]][z^{−1}, w^{−1}, (z−w)^{−1}]`——**全是形式 Laurent 级数空间**。
勘误表通篇没有「converge」「holomorphic」「analytic continuation」任何一个词，
`z, w` 是形式变量而不是 `ℂ` 里的点。

**这与候选 1（Gui）形成干净的对照，也正是 Gui 前言里点名的那句「[Kac, LL] 这类代数路线回避收敛性」：**

| | Frenkel–Ben-Zvi Thm 3.2.1 | Gui Prop. 7.12 |
|---|---|---|
| 陈述场所 | `V((w))((z−w))`（形式级数） | `𝒪(Conf²(ℂ^×))`（全纯函数） |
| 收敛性 | **不涉及** | a.l.u.，域 `0 < |z₁−z₂| < |z₂|` |
| `z, w` 是什么 | 形式变量 | 复数点 |
| 「OPE」的含义 | 形式级数恒等式（= 结合性） | 一个全纯函数的 Laurent 展开 |

**因此这两条是图里两个不同的节点，绝对不能合并。** 详见 §12。

---

## 10. 候选 3（部分核实）：Kac, *Vertex Algebras for Beginners*, 2nd ed. (1998)

### 10.0 文献标识

| 项 | 值 | 等级 |
|---|---|---|
| 作者 | Victor G. Kac | L2 |
| 标题 | *Vertex Algebras for Beginners* | L2 |
| 系列 | University Lecture Series, **vol. 10**, AMS | L4 |
| 版次 | 第 1 版 1996/1997；**第 2 版 1998**（"revised and expanded"） | L4 |
| **勘误** | **arXiv:math/9901070**, "Corrections to the book *Vertex algebras for beginners*, second edition, by Victor Kac"，1999-01-18 | **L1（5 页逐页读毕）** |

全文未获取（`bookstore.ams.org` → 403，本文件 §6 已记）。**但作者本人的勘误表已全文到手**，
它是一份**第 2 版专用**的更正文件（标题里逐字写 "second edition"），因此**它引用的编号就是第 2 版的编号**——
这比 FBZ 那份来路不明版次的勘误干净得多。

### 10.1 从 Kac 本人勘误表 L1 确认存在的编号（**不是我猜的，是他自己引用的**）

勘误表正文里被 Kac 引用/陈述的编号，逐条列出（全部 L1）：

| 编号 | 勘误表里的出现方式（逐字） | 由此确认 |
|---|---|---|
| **Theorem 4.8** | 「Note that the `n`-th product axiom is nothing else but **Borcherds identity in the form (4.8.1)** for `F = (z−w)^n`. As in the proof of **Theorem 4.8**, it follows that (4.8.1) holds for `F = z^m` with `m ∈ ℤ₊`.」 | §4.8 = **Borcherds 恒等式**；存在 **Theorem 4.8** 与公式 **(4.8.1)** |
| **Proposition 4.8(b)** | 「A *field algebra* `V` is defined by the same data as a vertex algebra, but weaker axioms (**cf. Proposition 4.8(b)**)」 | 存在 Proposition 4.8(b) |
| **Theorem 4.4**、**(4.4.1)** | 「Suppose that **(4.4.1)** holds for some `b ∈ V`. Then `B(z) = Y(b, z)`.」；「Proof: It is similar to that of **Theorems 4.4 and 4.5**」 | §4.4 = **唯一性定理**（Goddard uniqueness 型）；(4.4.1) 是其假设式 |
| **Theorem 4.5**、**(4.5.1)**、**(4.5.2)** | 「let `{a^α(z)}_{α∈A}` and `{b^β(z)}_{β∈B}` … be two collections of fields such that each of them satisfies conditions **(i)–(v) of Theorem 4.5** except that in **(iii) "local" is replaced by "weakly local"** … Then formula **(4.5.1)** defines a unique structure of a field algebra on `V` such that `\|0⟩` is the vacuum vector, `T` is the infinitesimal translation operator and **(4.5.2)** holds.」 | §4.5 = **存在性定理**，假设 (i)–(v)，**其中 (iii) 就是局域性**；(4.5.1) 是构造公式 |
| **Proposition 3.2**、**Proposition 3.3(b)**、**(3.3.6)**、**(3.3.7)** | 「Weak locality is proved in the same way as **Proposition 3.2**.」；「It follows from the proof of **Proposition 3.3(b)** that two weakly local fields `a(z)` and `b(z)` for which the **skewsymmetry property (3.3.6)** holds, are local.」；「The `n`-th product axiom for `n ≥ 0` is implied by **(3.3.7)**.」 | 第 3 章有 Prop 3.2、Prop 3.3(b)，(3.3.6) 是**斜对称关系** |
| **(4.2.1)**、**(4.2.2)**、**(4.6.4)**、**Example 3.5**、**Section 3.2**、**Section 1.4**、**(2.2.5)**、**(3.1.1)** | 均在勘误表中被逐字引用 | 存在 |

**Kac 自己陈述的两条弱局域性/结合性公式（L1 逐字，来自勘误表新写的 §4.11）**：

> **(4.11.3)** &nbsp;&nbsp; `Res_z (z−w)^N [Y(a,z), Y(b,w)] = 0` for `N >> 0`.
> Note that weak locality of fields `a(z)` and `b(z)` means that `a(z)_{(n)}b(z) = 0` for `n ≥ N`, some `N`.
> (Unlike the usual locality, this is not a symmetric property.)

> Formula (4.11.5) implies the *associativity* property in the domain `|z| > |w|`:
> **(4.11.6)** &nbsp;&nbsp; `(z−w)^N Y(Y(a,z)b,−w)c = (z−w)^N Y(a, z−w)Y(b,−w)c` for `N ≫ 0`.

> ⚠ **注意 (4.11.6) 里的「in the domain `|z| > |w|`」是形式展开的选择（`i_{z,w}` 还是 `i_{w,z}`），
> 不是解析收敛域。** Kac 全书是形式分布演算，`z, w` 是形式变量。
> 这个措辞极易被误读成「解析收敛」，是本轮发现的一个真陷阱
> （Schottenloher §10.2 的 "Analytic Aspects" 段把这件事讲得最清楚，见 §11.3）。

### 10.2 ★ 红旗：Kac 本人宣布书中**有两条是错的**（L1 逐字）

> **pp. 130–131:** **Theorem 4.11 and Proposition 4.11 are false.** A corrected version of Section 4.11 is given below.

勘误表随后给出重写的 §4.11「Field algebras」，含新的 **Theorem 4.11 (a)(b)**、**Corollary 4.11 (a)(b)**、
**Example 4.11**、**Remark 4.11a**、**Remark 4.11b**。
**任何引用 Kac §4.11 的地方都必须引勘误表版本，不能引印本。**（对本项目暂无直接影响，但登记备查。）

### 10.3 未能核实：**Theorem 2.3（局域性的等价刻画）的内容**

- 任务书要的「局域性、Borcherds 恒等式、OPE 与对易子公式的编号」中，**Borcherds 恒等式 = §4.8 已 L1 落定**；
  **局域性的等价刻画**通常被文献引成 **[Kac, Theorem 2.3]**，但：
  - **Theorem 2.3 的正文措辞本轮未获取（L0）。**
  - Google Books（volume id `e-jxBwAAQBAJ`）查 `"Theorem 2.3"` → **p.26**；查 `"Theorem 4.8"` → **p.118**。
    **交叉验证成功**：Kac 勘误表里恰好有两条「p. 118」的更正（`(b_{(k+j)}c)`、`(a_{(m+j)}c)`，都是 Borcherds 恒等式型表达式），
    与 §4.8 落在 p.118 完全吻合 ⇒ 该 Google Books 卷即**第 2 版**，页码可信。
    所以 **「Theorem 2.3 存在且在 p.26 附近」是 L4 但有旁证**；**它说什么，仍是 L0**。
  - 章节标题（L4，检索后端）：§2.1 Formal delta-function、§2.2 An expansion of a formal distribution `a(z,w)`、
    **§2.3 Locality**。
- **未裁决的矛盾**：检索后端给出两种互相冲突的归属——
  一说「locality 与 weak commutator formula 的等价是 **Theorem 2.3(i)**」，
  另一说「delta 分解公式 `a(z,w) = Σ_j c^j(w)∂_w^jδ(z−w)/j!`，`c^j(w) = Res_z (z−w)^j a(z,w)`，被引作 **Corollary 2.2**」。
  两者都是 L4，**本轮不裁决**。
  **在拿到正文之前，图里不得写 `Kac, Theorem 2.3` 或 `Kac, Corollary 2.2` 中的任何一个。**
- **好消息：这条陈述有一个完全可核实的替代来源**——Schottenloher **Proposition 10.6 + Theorem 10.10**，
  而且 Schottenloher 正文明确把 Proposition 10.6 归功于 Kac（见 §11.2）。**建议图里改引 Schottenloher。**

---

## 11. ★★ 意外收获（已核实 L1，全章到手）：Schottenloher, *A Mathematical Introduction to CFT*, 2nd ed., **Chapter 10「Vertex Algebras」**

> **这一节直接修复 `sources.bib` 里 `schottenloher-2008` 的 note（原文写「章节号与定理号未核实」）。**

### 11.0 获取途径与标识（L1）

- URL：`https://www.mathematik.uni-muenchen.de/~schotten/LNP-cft-pdf/10_978-3-540-68625-5_Ch10_23-08-08.pdf`
  （**作者本人在 LMU 的主页上按章挂出**，合法公开；WebFetch 落盘 550 KB → `Read` 带 `pages` 读图）。
- 首页页脚**逐字**：「Schottenloher, M.: *Vertex Algebras*. Lect. Notes Phys. **759**, **171–212** (2008)
  DOI **10.1007/978-3-540-68628-6_11** © Springer-Verlag Berlin Heidelberg 2008」。
  > ⚠ **两个陷阱**：(1) 书里是**第 10 章**，但 **DOI 后缀是 `_11`**（Springer 按物理章序编）；
  > (2) 文件名里的 ISBN 是 `978-3-540-68625-5`，页脚 DOI 里是 `978-3-540-68628-6`（印本/电子本之别）。
  > 引用时按「Chapter 10, LNP 759, pp. 171–212」写，别用 DOI 后缀去推章号。
- **PDF 页码 = 书上页码 − 170**（PDF 第 1 页 = 书上 p.171）。
- 作者自陈来源（p.172 逐字）：「The presentation in these notes is based mainly on the course [Kac98*] and to some
  extent also on the beginning sections of the book [BF01*].」——**即本章是 Kac 那本书的可核实、可公开获取的替身。**

### 11.1 章内编号总表（L1，全部逐页读到）

| 编号 | 书页 | 内容 |
|---|---|---|
| **§10.1 Formal Distributions** | p.172 | |
| Definition 10.1 | p.173 | 形式分布的 residue `Res_z A(z) = A_{−1}`；形式导数 |
| Lemma 10.2 | p.173 | `R[[z^±]] ≅ Hom(ℂ[z^±], R)`（形式分布确实是「分布」） |
| **Definition 10.3** | p.174 | **形式 delta 函数** `δ(z−w) = Σ_{n∈ℤ} z^{n−1}w^{−n} = Σ_{n∈ℤ} z^{−n−1}w^n` |
| Lemma 10.4 | p.174 | `Res_z f(z)δ(z−w) = f(w)`；`f(z)δ(z−w) = f(w)δ(z−w)` |
| Lemma 10.5 | p.174 | 五条 `(z−w)^n D^jδ` 恒等式（记号 `D_w^j := (1/j!)∂_w^j`） |
| **Proposition 10.6** | p.175 | **局域形式分布的 delta 分解（唯一性 + 系数公式）** |
| **§10.2 Locality and Normal Ordering** | p.177 | 含 "Analytic Aspects" 段与 (10.1) |
| **Definition 10.7 (Locality)** | p.177 | `(z−w)^N[A(z),B(w)] = 0` |
| Remark 10.8 | p.177 | 局域性对 `∂` 封闭 |
| Definition 10.9 | p.178 | 正规序积 `:A(z)B(w):` |
| **Theorem 10.10** | p.178 | **五条等价性质（局域性 ⟺ delta 分解 ⟺ OPE 形式 ⟺ 对易子公式）** |
| (10.2) | p.180 | Virasoro 的 `T(z)T(w)` OPE |
| **Lemma 10.11 (Dong's Lemma)** | p.181 | 两两局域 ⇒ `:A(z)B(z):` 与 `C(z)` 局域 |
| **§10.3 Fields and Locality** | p.181 | |
| Definition 10.12 | p.181 | **场**（field）的定义：`∀v ∃n₀, a_{(n)}v = 0 for n ≥ n₀` |
| Lemma 10.13 | p.182 | 齐次分布是场 |
| Remark 10.14 | p.182 | `∂` 对正规序积是导子 |
| Remark 10.16 | （p.173 前向引用） | 回到 `(z−w)^{−1}` 的两种展开 |
| Definition 10.45 | （p.179 引用） | 泛包络代数 |

### 11.2 **Proposition 10.6** 逐字（书上 p.175，L1）——delta 分解，且**正文把它归功于 Kac**

正文引言逐字：

> As a consequence, for every `N ∈ ℕ, N > 0`, the distribution `(z−w)^N` annihilates all linear combinations of
> `∂_w^k δ(z−w)`, `k = 0,…,N−1`, with coefficients in `R[[w^±]]`. **The next result (due to Kac [Kac98*])** states that
> these linear combinations already exhaust the subspace of `R[[z^±, w^±]]` annihilated by `(z−w)^N`.

> **Proposition 10.6.** *For a fixed* `N ∈ ℕ, N > 0`*, each*
>
> &nbsp;&nbsp;&nbsp;&nbsp; `f ∈ R[[z^±, w^±]] with (z−w)^N f = 0`
>
> *can be written uniquely as a sum*
>
> &nbsp;&nbsp;&nbsp;&nbsp; `f(z,w) = Σ_{j=0}^{N−1} c^j(w) D_w^j δ(z−w) , c^j ∈ R[[w^±]].`
>
> *Moreover, for such* `f` *the formula*
>
> &nbsp;&nbsp;&nbsp;&nbsp; `c^n(w) = Res_z (z−w)^n f(z,w)`
>
> *holds for* `0 ≤ n < N`.

带完整证明（p.175–176，对 `N` 归纳）。**这就是 §10.3 里那条 Kac 归属未定的陈述的可核实版本。**

### 11.3 ★★★ **Theorem 10.10** 逐字（书上 p.178，L1）——**本轮为 OPE 节点找到的最贴切的「带编号的定理」（形式侧）**

先是 **Definition 10.7（书上 p.177，L1 逐字）**：

> **Definition 10.7 (Locality).** Two formal distributions `A, B ∈ R[[z^±]]` are *local* with respect to each other if
> there exists `N ∈ ℕ` such that `(z−w)^N [A(z), B(w)] = 0` in `R[[z^±, w^±]]`.

然后：

> **Theorem 10.10.** *The following properties are equivalent for* `A, B ∈ R[[z^±]]` *and* `N ∈ ℕ`:
>
> 1. `A, B` *are mutually local with* `(z−w)^N [A(z),B(w)] = 0`.
> 2. `[A(z),B(w)] = Σ_{j=0}^{N−1} C^j(w) D^j δ(z−w)` *for suitable* `C^j ∈ R[[w^±]]`.
> 3. `[A(z)_−, B(w)] = Σ_{j=0}^{N−1} i_{z,w} (z−w)^{−(j+1)} C^j(w)`,
>    `−[A(z)_+, B(w)] = Σ_{j=0}^{N−1} i_{w,z} (z−w)^{−(j+1)} C^j(w)` *for suitable* `C^j ∈ R[[w^±]]`.
> 4. `A(z)B(w) = Σ_{j=0}^{N−1} i_{z,w} (z−w)^{−(j+1)} C^j(w) + :A(z)B(w):`,
>    `B(w)A(z) = Σ_{j=0}^{N−1} i_{w,z} (z−w)^{−(j+1)} C^j(w) + :A(z)B(w):` *for suitable* `C^j ∈ R[[w^±]]`.
> 5. `[A_{(m)}, B_{(n)}] = Σ_{j} (m choose j) C^j_{(m+n−j)}`, `m,n ∈ ℤ`, *for suitable*
>    `C^j = Σ_{k∈ℤ} C^j_{(k)} w^{−k−1} ∈ R[[w^±]]`.

> ⚠ **转录疑点（引用前须复核原页）**：第 5 条的求和**下限**在页图上看起来是 `j = 1`，
> 但第 2、3、4 条都是 `j = 0`，且标准的对易子公式也是从 `j = 0` 起。
> **我不把它写死；curator 若要抄第 5 条，必须让人复核这一个下限。**（与 Gui (5.27) 的上标疑点同类。）

**为什么这条定理是本轮最重要的收获**：它把
「**局域性**」（第 1 条，= 图里想要的 `math.formal-distribution-locality`）、
「**delta 分解**」（第 2 条）、
「**物理学家写的那个 OPE**」（第 4 条）、
「**模式对易子公式**」（第 5 条）
**在同一条编号定理里判为等价**。图里 `operator-product-expansion` 与 `mode-commutator` 之间那条一直只有物理论证的边，
在**形式分布层面**由这一条定理支撑。

紧接着（书上 p.179，L1 逐字）Schottenloher **亲手把它翻译成物理记号**：

> The notation of physicists for the first equation in 4 is
> `A(z)B(w) = Σ_{j=0}^{N−1} C^j(w)/(z−w)^{j+1} + :A(z)B(w):`
> with the implicit assumption of `|z| > |w|` in order to justify `1/(z−w)^{j+1} = i_{z,w} 1/(z−w)^{j+1}`.
> Another frequently used notation for this circumstance by restricting to the singular part is
> `A(z)B(w) ∼ Σ_{j=0}^{N−1} C^j(w)/(z−w)^{j+1}`.
> Here, `∼` denotes as before (Sect. 9.2, in particular (9.5)) the asymptotic expansion neglecting the regular part of the
> series. **This is a kind of operator product expansion as in Sect. 9.3, in particular (9.13).**

**这段是图里最需要的「桥」**：一本数学书**逐字地**把物理的 `A(z)B(w) ∼ Σ C^j(w)/(z−w)^{j+1}` 认领为
它自己 Theorem 10.10 第 4 条，并**点名 `|z| > |w|` 只是为了选定 `i_{z,w}` 这个形式展开**。
**注意它说的是 "a kind of"，不是 "is"。**

同页更前面的 **"Analytic Aspects" 段（书上 p.177，L1 逐字节选）**把这件事的边界划得最清楚：

> For a rational function `F(z,w)` in two complex variables `z, w` with poles only at `z = 0, w = 0`, or `|z| = |w|` one
> denotes the power series expansion of `F` in the domain `{|z| > |w|}` by `i_{z,w}F` and correspondingly the power series
> expansion of `F` in the domain `{|z| < |w|}` by `i_{w,z}F`.

即：`i_{z,w}` / `i_{w,z}` 是**把一个有理函数展开成形式级数**的两种方式，
`(10.1)`：`i_{z,w}(z−w)^{−1} − i_{w,z}(z−w)^{−1} = δ(z−w)`。
**整章都停在形式级数层面，没有任何收敛性定理。**

### 11.4 顺带核实的 Heisenberg / Virasoro OPE（L1，书上 p.179–180）

- **Heisenberg**（p.179）：`[a_m, a_n] = mδ_{m+n}Z`，`A(z) = Σ a_n z^{−n−1}` ⇒ `[A(z),A(w)] = ∂δ(z−w)Z`，
  「the operator product expansion has the form `A(z)A(w) ∼ Z/(z−w)²`」。
- **自由玻色子的 Fock 空间实现**（p.181–182）：`S = ℂ[T₁,T₂,…]`，`a_n(P) = ∂P/∂T_n`（`n > 0`）、`a_0(P) = 0`、
  `a_{−n}(P) = nT_nP`、`Z(P) = P`；`Φ(z) = Σ a_n z^{−n−1}` 是场，且 `Φ(z)Φ(w) ∼ 1/(z−w)²`。
  正文逐字：「The field `Φ` is the quantized field of the infinite set of harmonic oscillators (cf. Sect. 7.2) and thus
  represents the quantized field of a free boson.」
- **Virasoro**（p.179–180）：`[L_m,L_n] = (m−n)L_{m+n} + (m/12)(m²−1)δ_{m+n}Z`，`T(z) = Σ L_n z^{−n−2}` ⇒
  `[T(z),T(w)] = (Z/12)∂³δ(z−w) + 2T(w)∂_wδ(z−w) + ∂_wT(w)δ(z−w)`，
  于是（**(10.2)**，书上 p.180）
  `T(z)T(w) ∼ (c/2)·1/(z−w)⁴ + 2T(w)/(z−w)² + ∂_wT(w)/(z−w)`，
  正文说「which we have encountered already in (9.5)」。
  > ⚠ **本页有两处疑似排印错误（L1 观察，未与勘误表核对）**：正文写
  > 「according to our **Theorem 10.5** with `N = 4` … (observe the factor `3! = 6` in the first equation of
  > **property 4 of the theorem**)」以及「by using **property 5 in Lemma 10.5**」。
  > 但 **10.5 是 Lemma（delta 恒等式），没有 property 4/5 那种带 `C^j` 的条目**；
  > 带 property 4、5 的是 **Theorem 10.10**。**两处「10.5」几乎肯定应为「10.10」。**
  > 引用 (10.2) 的推导时请指向 **Theorem 10.10**，不要照抄这两个编号。
  > 另注意 `[L_m,L_n]` 的中心项这里写成 `(m/12)(m²−1)δ_{m+n}Z`（与 `((m³−m)/12)δ_{m,−n}` 同一式，
  > 但 `δ_{m+n}` 的记法与 Kytölä `δ_{m,−n}` 不同，**约定要对齐**，见 `sources.bib` 的 `virasoro-lean-2025`）。

### 11.5 本节对 `sources.bib` 的影响

`schottenloher-2008` 的 note 目前写「**章节号与定理号未核实**，图节点的 loc 一律写『相关章节，编号未核实』」。
**这条限制现在对第 10 章可以解除**：Chapter 10（LNP 759, pp. 171–212）的全部编号已 L1 逐页核实，
可以放心写 `loc: "Ch. 10, Theorem 10.10, p. 178"` 这样的定位。**其余章节的编号仍未核实，限制照旧。**

---

## 12. 候选 4（已核实，**否定结论**）：Kytölä arXiv:2510.21741 **不含**局域性/OPE

### 12.1 结论

**该论文里没有任何关于顶点代数、局域性、OPE、形式分布正规序积的陈述。** 它全程是 Lie 代数层面的。

证据（**L1**，本轮重读了 pp.1–3；全文 16 页曾于 2026-09-10 读毕，记录见 `sources.bib` 的 `virasoro-lean-2025`）：
其 **Table 1「Main objects and results formalized and discussed in this report」**逐字列出的**全部**条目是：
中心扩张（Def 3.1）、Lie 代数二次上同调（Def 4.3）、Virasoro 代数（Def 8.1）、Heisenberg 代数（Sec 9）、
Verma 模（Def 12.2）、Witt 代数二次上同调的计算（Thm 6.2）、Heisenberg 代数的 Sugawara 构造（Thm 10.1）、
Virasoro Verma 模到带电 Fock 空间的模映射（Thm 12.7）。**没有一条与局域性/OPE 有关。**

### 12.2 作者本人把 VOA 明确划给别人（§1.3 "Related work"，书上 p.2，L1 逐字）

> Some ambitious formalization work of Carnahan [Car25] builds towards the theory of vertex operator algebras (VOA).
> These are a far more advanced topic related to breakthroughs in group theory [FLM89], and also a starting point for a
> mathematical definition of conformal field theory **[Gui23]**. VOAs include the Virasoro algebra as a component, often
> via variants of Sugawara constructions. We hope that the current project finds synergies with the formalization of VOAs.

> **注意 [Gui23] 就是本文件 §8 的候选 1（Bin Gui 的讲义）。** 即：Kytölä 亲自把「CFT 的数学定义」指向 Gui，
> 而本轮独立地把 Gui 认定为 OPE 收敛性的最佳来源。**两条线在这里合上了。**

### 12.3 ★ 对 `formal/` 的两条硬情报（L1）

1. **Kytölä 的成果尚未进入 Mathlib。**§1.2 逐字：「The results here have not yet been pull-requested to Mathlib.」
   （报告对应仓库 commit **29e118b**，约 4000 行 Lean。）
   ⇒ 复用它必须直接依赖 `github.com/kkytola/VirasoroProject`，**不能指望从 Mathlib 拿到**。
2. **Mathlib 里的顶点代数支持：`VertexOperator` 有，`Locality` 没有。**
   查 `leanprover-community.github.io/mathlib4_docs`（**读取日期 2026-09-11；Mathlib 变动快，用前须复查**）：
   - `Mathlib/Algebra/Vertex/HVertexOperator.lean`：`HVertexOperator`（`V → HahnModule Γ W` 的 `R`-线性映射）、
     `coeff`、`comp`、`compHahnSeries`、`of_coeff` 等 19 个声明。
   - `Mathlib/Algebra/Vertex/VertexOperator.lean`：`VertexOperator R V = HVertexOperator ℤ R V V`、
     `VertexOperator.ncoeff`（正规化指标下的系数，记号 `A(n)` / `Aₙ`）、`of_coeff`、
     `ncoeff_eq_zero_of_lt_order` 等 12 个声明。
   - **该文件模块 docstring 的 TODO 段逐字为：**
     > `HasseDerivative` : A divided-power derivative.
     > **`Locality` : A weak form of commutativity.**
     > `Residue products` : A family of products on `VertexOperator R V` parametrized by integers.

   > ⚠ **本轮纠正了一个检索后端的错误断言（记下来免得下一轮重犯）**：WebSearch 后端声称
   > 「Main definitions in this file **include locality** … and residue products」，
   > 并声称 `HVertexOperator` 的 docstring 里有 `(X−Y)^n A(X)B(Y)` 在 `R((X))((Y))` 中展开的设计说明。
   > **逐字读官方文档页后，两条都不成立**：`Locality` 与 `Residue products` 出现在 **TODO** 段（= 尚未实现），
   > `HVertexOperator` 的 docstring 里**没有** `(X−Y)^n A(X)B(Y)` 这段话。
   > 这是把 TODO 读成 Definitions 的典型误报。
   - 两个文件的 References 段（L1 逐字）：`HVertexOperator` 引 Borcherds, *Vertex Algebras, Kac-Moody Algebras,
     and the Monster*；`VertexOperator` 引 G. Mason, *Vertex rings and Pierce bundles*（arXiv:1707.00328）与
     A. Matsuo, K. Nagatomo, *On axioms for a vertex algebra and locality of quantum fields*（arXiv:math/9706118）。
     **后者的标题正好是本节主题，是下一轮值得抓的新候选（本轮未读）。**

**⇒ 形式化侧的现状：局域性在 Mathlib 里是一个 TODO，不是一条已证的定理。**
所以图里任何顶点代数节点**现在都不能标 `formalized`**，最高只能到 `rigorous`。

---

## 13. ★ 回答任务的核心问题 + 给 curator 的拆法建议

### 13.1 「这些定理证明的是形式局域性/结合性，还是解析收敛的 OPE？」——**两者都有，但分属不同文献，且强度不同**

| 来源 | 证明的对象 | 陈述场所 | 有收敛性吗 | 核实等级 |
|---|---|---|---|---|
| Schottenloher **Def 10.7 / Prop 10.6 / Thm 10.10** | **形式分布的局域性**及其四种等价刻画（含物理写法的 OPE、模式对易子公式） | `R[[z^±, w^±]]` | **没有**（`i_{z,w}` 只是选哪种形式展开） | **L1** |
| Frenkel–Ben-Zvi **Thm 3.2.1** | **顶点代数的结合性**（= 形式 OPE） | `V((w))((z−w))` | **没有** | **L1**（作者勘误表措辞） |
| Kac **§4.8**（Borcherds 恒等式）、**Thm 4.5**（存在性）、**Thm 4.4**（唯一性） | 形式局域性 ⇒ 顶点代数结构 | 形式级数 | **没有** | L1（编号，经作者勘误表）/ L0（措辞） |
| Gui **Def 7.6** | 形式变量版局域性 | `End(𝕍)[[z₁^{±1},z₂^{±1}]]` | 没有 | **L1** |
| Gui **Def 7.2** | **复解析版局域性** | `𝒪(Conf²(ℂ^×))` | **有**（a.l.u. + 解析延拓 + 极点阶 ≤ N） | **L1** |
| Gui **Prop 7.12** | **解析收敛的 OPE**（存在 + a.l.u. 收敛 + 收敛域 + 奇异项有限） | 全纯函数 | **有** | **L1** |
| Gui **Thm 8.1 / Thm 8.4** | `n` 点函数的 a.l.u. 收敛、与算子排序无关的解析延拓（= 径向排序） | `𝒪(Conf^M(ℂ^×))` | **有** | **L1** |
| Gui **§7.7 + §7.8–§7.12** | 三种局域性（Lie 括号 / 形式变量 / 复解析）**等价，且同一个 N** | — | — | **L1**，但**不是一条编号定理** |

**一句话**：形式侧的定理**遍地都是且都很干净**；解析收敛侧**只有 Gui 一家**，
而且他的解析 OPE（Prop 7.12）**以复解析局域性（Def 7.2）为前提**，不是无条件的。
物理书里那句「OPE 收敛」在数学上对应的是 **Def 7.2 ⇒ Prop 7.12** 这条蕴含，**不是一条孤立定理**。

### 13.2 建议的拆法（**建议而已，researcher 不改 `graph/`，也不代 curator/auditor 决定**）

现在 `worldsheet.operator-product-expansion` 一个节点承担了至少四件事，
按项目原则 2「状态只能实话实说」，这会同时**压低**数学部分、**抬高**物理部分。建议拆成：

```
math.formal-distribution-locality              (rigorous)   ← Schottenloher Def 10.7；Gui Def 7.6
        │
        ├── math.locality-ope-equivalences     (rigorous)   ← Schottenloher Thm 10.10 (+ Prop 10.6)
        │        「局域性 ⟺ delta 分解 ⟺ 物理写法的 OPE ⟺ 模式对易子公式」
        │
        └── math.vertex-algebra-associativity  (rigorous)   ← FBZ Thm 3.2.1；Kac §4.8/Thm 4.5
                 「形式意义下 Y(A,z)Y(B,w)C = Y(Y(A,z−w)B,w)C」

math.vertex-algebra-complex-analytic-locality  (rigorous)   ← Gui Def 7.2（这是**定义**，不是定理）
        │
        └── math.vertex-algebra-ope-analytic-convergence   (rigorous)  ← Gui Prop 7.12
                 「OPE 系数场由围道积分给出；级数在 0 < |z₁−z₂| < |z₂| 上 a.l.u. 收敛；k ≥ N 时为零」
                 └── math.n-point-function-analytic-continuation (rigorous) ← Gui Thm 8.1（含「与排序 σ 无关」）

worldsheet.operator-product-expansion          (**保留 physical-argument**)
        depends_on: 上面各条，**每条边都要 inferred: true**（理由见 13.3）
```

补充建议：
1. **`math.vertex-algebra-complex-analytic-locality` 是个定义节点，不是命题节点。**
   项目原则 1（陈述与推导分离）下，它应该按「定义」类型登记，`status` 用定义节点的口径，
   不要因为「Gui 证了它等价于形式版」就把它当定理。
   「三版等价」如果要单独立节点，**必须在 note 里写明「Gui 没有把它写成编号定理，是 §7.7 散文断言 + §7.8–§7.12 分段证明」**
   （见 §8.4），并且 `loc` 只能写小节号，不能写定理号。
2. **`math.locality-ope-equivalences` 是本轮性价比最高的新节点**：它一条就把图里
   「OPE ↔ 模式对易子」这条一直只有物理论证的边，在形式分布层面变成 `rigorous`。
3. 已有的 `laplacian-log-contact-term`（本文件 §2–§5）与这批节点是**同一类**：
   数学事实严格、物理书不给来源。可以考虑归到同一个 `family`。

### 13.3 ★★ 最重要的一条：**拆完之后，`worldsheet.operator-product-expansion` 仍然是 `physical-argument`，瓶颈只是搬了家**

**本轮没有找到任何文献**证明「玻色弦世界面理论（`D` 个洛伦兹号差的自由玻色子 + `bc` 鬼场，
按路径积分定义）构成一个满足 Gui Def 7.2 / Schottenloher Def 10.7 假设的顶点代数」。
已核实的只有**单个**自由玻色子的 Heisenberg 情形：
- Schottenloher 书上 p.181–182：Fock 空间 `S = ℂ[T₁,T₂,…]` 上 `Φ(z)Φ(w) ∼ 1/(z−w)²`（L1）；
- Gui §6：Heisenberg VOA 的构造（本轮只读到目录级）；
- Kytölä Thm 10.1 / Cor 10.2：**只有 c = 1 的单分量**（`sources.bib` 已记的限制 (1)）。

因此：
- **从这批数学节点到 `worldsheet.operator-product-expansion` 的每条边都必须 `inferred: true`**，
  note 写「文献双方没有互引；数学侧未处理 `D` 分量 + 洛伦兹号差 + 鬼场 + 路径积分定义」。
- 更诚实的做法是**新增一个明确的缺口节点**，例如
  `worldsheet.string-cft-is-a-vertex-algebra`（`status: physical-argument` 或 `conjecture`），
  让它成为真正的瓶颈根，而不是让 `operator-product-expansion` 继续背锅。
  **这才是本轮检索的真正结论：OPE 的数学部分不缺定理，缺的是「弦论那个具体理论满足假设」这一步。**
- 注意 Gui **不做**洛伦兹不定内积（§8.8），Kytölä 也不做（`sources.bib` 限制 (2)）。
  这与无鬼定理那条线的缺口**是同一个缺口**，值得在图里合并成一个共享依赖。

### 13.4 `loc` 的建议写法（供 curator 直接抄）

```yaml
# 形式局域性（首选，全部编号 L1 逐页核实）
- ref: schottenloher-2008
  loc: "Ch. 10 (Vertex Algebras), Definition 10.7 (Locality), p. 177"
- ref: schottenloher-2008
  loc: "Ch. 10, Theorem 10.10 (five equivalent properties), p. 178;
        delta 分解见 Proposition 10.6, p. 175"

# 形式结合性 / 形式 OPE
- ref: frenkel-benzvi-2004
  loc: "Theorem 3.2.1 (associativity), §3.2;
        措辞取作者勘误表 corrections.pdf『To §3.2』的修订版，非印本正文"
- ref: kac-1998
  loc: "§4.8 (Borcherds identity), Theorem 4.8;
        存在性定理 Theorem 4.5（假设 (iii) 为局域性）；唯一性定理 Theorem 4.4"

# 解析收敛的 OPE（唯一来源）
- ref: gui-2023-lectures
  loc: "2026-07-15 版, Proposition 7.12 (7.15), p. 77;
        前提是 Definition 7.2 (Local fields, complex analytic version), p. 70"
- ref: gui-2023-lectures
  loc: "2026-07-15 版, Theorem 8.1 (8.1)-(8.3), pp. 80-81（n 点函数，与排序 σ 无关）"

# 三版等价：只能写小节，不能写定理号
- ref: gui-2023-lectures
  loc: "2026-07-15 版, §7.7-§7.12（三种局域性等价；**本书未把它写成编号定理**）"
```

**三条硬性禁令**：
1. **不得写 `Frenkel–Ben-Zvi, Theorem 3.3.1`** —— 本轮证据指向该编号不存在（§9.2）。
2. **不得写 `Kac, Theorem 2.3` 或 `Kac, Corollary 2.2`** —— 编号存在但**内容未核实**，且两个候选归属互相冲突（§10.3）。
   要这条陈述就引 Schottenloher Prop 10.6（正文明确归功于 Kac）。
3. **引 Gui 必须带版本日期 `2026-07-15 版`** —— arXiv:2305.03822 各版编号未核实（§8.0）。

---

## 14. 本节访问日志与未解决问题

### 14.1 访问日志（本轮，供后人省事）

| 目标 | URL / 手法 | 结果 |
|---|---|---|
| Gui 讲义全文（179 页） | `binguimath.github.io/Files/2022_VOA_Lectures.pdf` | **成功**（落盘 2.7 MB → `Read pages`；PDF 页 = 书页 + 1） |
| Gui 主页 | `binguimath.github.io/` | **成功**（全部论文/讲义 PDF 直链） |
| FBZ 作者勘误表 | `math.berkeley.edu/~frenkel/BOOK/corrections.pdf` | **成功**（2 页，落盘 66 KB） |
| Frenkel 书页 | `math.berkeley.edu/~frenkel/BOOK`（**大写 BOOK**） | **成功**；`~frenkel/book/`（小写）→ **403** |
| Ben-Zvi 书页 | `web.ma.utexas.edu/users/benzvi/math/book.html` | 成功但**无任何文件链接** |
| AMS 免费预览 | `www.ams.org/bookstore/pspdf/surv-88-prev.pdf` | **403**（与 `bookstore.ams.org` 一样） |
| **Kac 作者勘误表** | **`arxiv.org/pdf/math/9901070`** | **成功**（5 页，落盘 66 KB） |
| **Schottenloher 第 10 章全章** | **`www.mathematik.uni-muenchen.de/~schotten/LNP-cft-pdf/10_978-3-540-68625-5_Ch10_23-08-08.pdf`** | **成功**（落盘 550 KB；PDF 页 = 书页 − 170） |
| Kytölä 全文 | `arxiv.org/pdf/2510.21741` | **成功**（1.2 MB） |
| Kytölä HTML | `arxiv.org/html/2510.21741` 与 `…v1` | **均 404**（该论文无 LaTeXML HTML 版） |
| Mathlib 文档 | `leanprover-community.github.io/mathlib4_docs/Mathlib/Algebra/Vertex/{VertexOperator,HVertexOperator}.html` | **成功**（可逐条读声明名与 docstring） |
| Kac 讲义（IMPA 镜像） | `w3.impa.br/~heluani/files/lect.pdf` | **403** |
| Google Books 页码定位 | `books.google.com/books?id=<ID>&q=<短语>` | 成功但只回页码；**发现无命中时回落到固定页**（FBZ 卷为 p.403），详见 §9.2 |

> **对 `reading-list.md` 的建议增补**：
> - **`arxiv.org` 本次会话完全正常**（`/pdf/` 落盘 + `Read pages` 一次成功）。
>   这推翻了 2026-09-10 记的「arXiv 被环境拦截」——**那确实是临时限制，下一轮先重试**。
> - **新增活路**：`math.berkeley.edu/~frenkel/BOOK/`（大小写敏感！）、
>   `www.mathematik.uni-muenchen.de/~schotten/LNP-cft-pdf/`（**Schottenloher 按章挂出全书，本轮只取了第 10 章**）、
>   `binguimath.github.io/Files/`、`leanprover-community.github.io/mathlib4_docs/`。
> - **新增死路**：`www.ams.org/bookstore/pspdf/*`（403）、`w3.impa.br`（403）、`math.berkeley.edu/~frenkel/book/`（小写，403）。
> - **重要教训**：**作者自己的勘误表是绕过付费墙拿到定理逐字措辞的最佳路线。**
>   本轮 FBZ 与 Kac 两本买不到的书，都是靠作者勘误表拿到编号与措辞的。
>   下次遇到「书拿不到但要编号」，**先找 errata/corrections，再找扫描件**。

### 14.2 未解决 / 留给下一轮

- **Q6** Kac *Vertex Algebras for Beginners* **Theorem 2.3 的正文措辞**（§2.3 Locality，约书上 p.26）。
  以及「delta 分解到底是 Theorem 2.3(i) 还是 Corollary 2.2」这个未裁决的矛盾（§10.3）。
- **Q7** FBZ 的 `corrections.pdf` 到底是第 1 版还是第 2 版的勘误（PDF 元数据显示 2001-09，L4）。
  以及 **§3.3（OPE，书上 p.51 起）里到底有没有带编号的命题**。
- **Q8** FBZ §2.1.5 / §2.5（Heisenberg 与 Virasoro 顶点代数）的编号——本轮完全未核实。
- **Q9** Gui 讲义的 **arXiv:2305.03822 各版编号**是否与 2026-07-15 主页版一致。
  若要引一个「不会再变」的版本，应核 arXiv 某个固定版本号。
- **Q10** 两处转录疑点须持原件者复核：Gui (5.27) 里 `C` 的上标；Schottenloher Thm 10.10 第 5 条的求和下限。
- **Q11** 新候选（本轮未读）：**Matsuo–Nagatomo, *On axioms for a vertex algebra and locality of quantum fields*
  （arXiv:math/9706118）**——Mathlib `VertexOperator.lean` 的 References 之一，标题正对本主题。
  另有 Gui 的另一本 *Conformal Blocks: Vector Bundle Structures, Sewing, and Factorization*
  （`binguimath.github.io/Files/2020_Conformal_Blocks.pdf`），是 Gui 讲义里技术证明的出处（前言称 [Gui]）。
- **Q12** Schottenloher 书上 p.180 的两处「10.5」疑似应为「10.10」（§11.4）——
  可与作者勘误（若有）核对；不影响引用 Theorem 10.10 本身。
- **Q13** **本轮最重要的缺口**：没有任何文献把「玻色弦世界面理论（`D` 分量洛伦兹号差 + `bc` 鬼场 + 路径积分）」
  验证成满足 Gui Def 7.2 / Schottenloher Def 10.7 的顶点代数（§13.3）。
  这是 OPE 路线与无鬼定理路线**共享**的缺口，值得作为下一个检索专题。

---

# § 11A. Schottenloher 第 10 章补转录（第三轮，2026-09-11）

> 本节是 §11 的追加段，**不修改 §11 已有内容**。编号用 `11A.x` 以免与 §12–§14 冲突。

- 负责 agent：researcher
- 日期：2026-09-11（第三轮）
- 触发：补转录 **Definition 10.9**（`A(z)_±` 与正规序 `:AB:`）与**书上 p.177 的记号段**；
  并结案 §14.2 的 **Q10**（Theorem 10.10 第 5 条求和下限是 `j = 0` 还是 `j = 1`）
- 获取途径：与 §11.0 完全相同的公开 PDF
  `https://www.mathematik.uni-muenchen.de/~schotten/LNP-cft-pdf/10_978-3-540-68625-5_Ch10_23-08-08.pdf`
  （WebFetch 落盘 549.7 KB → `Read` 带 `pages` 读页图；**PDF 页 = 书上页码 − 170**；
  本轮读 PDF 第 7–9 页 = 书上 p.177–179，其中第 8 页 = 书上 p.178 **单独重读一次以放大页图复核 Q10**）
- 除明确标注为「researcher 推导」的段落外，本节全部为 **L1 逐字**

---

## 11A.1 书上 **p.177** 的「Analytic Aspects」段与记号段（L1 逐字）

### (a) `ι_{z,w}` / `ι_{w,z}` 的两条展开式（书上 p.177，在 §11.3 已引的 "Analytic Aspects" 定义句之后）

> `ι_{z,w} 1/(z−w)^{j+1} = Σ_{m=0}^{∞} (m choose j) z^{−m−1} w^{m−j}`,
> `ι_{w,z} 1/(z−w)^{j+1} = − Σ_{m=1}^{∞} (−m choose j) z^{m−1} w^{−m−j}`.

> In particular, as formal distributions
>
> `ι_{z,w} 1/(z−w) − ι_{w,z} 1/(z−w) = Σ_{m≥0} z^{−m−1}w^m + Σ_{m>0} z^{m−1}w^{−m}`
> `= Σ_{m∈ℤ} z^{−m−1}w^m = δ(z−w)`  &nbsp;&nbsp;&nbsp;&nbsp; **(10.1)**
>
> and similarly for the derivatives of `δ`,
>
> `D^j δ(z−w) = ι_{z,w} 1/(z−w)^{j+1} − ι_{w,z} 1/(z−w)^{j+1} = Σ (m choose j) z^{−m−1} w^{m−j}`.

**这最后一式是 11A.3 结案 Q10 的技术支点**：它给出 `Res_z z^m D^j_w δ(z−w) = (m choose j) w^{m−j}`，
而 `(m choose 0) = 1 ≠ 0`。

### (b) 记号段（书上 p.177，紧接 Remark 10.8 之后；L1 逐字）

> In order to formulate equivalent conditions of locality we introduce some notations. For `A = Σ A_m z^m`
> we mostly write `A = Σ A_{(n)} z^{−n−1}` such that we have the following convenient formula:
>
> &nbsp;&nbsp;&nbsp;&nbsp; `A_{(n)} = A_{−n−1} = Res_z A(z) z^n`.
>
> We break `A` into
>
> &nbsp;&nbsp;&nbsp;&nbsp; `A(z)_− := Σ_{n≥0} A_{(n)} z^{−n−1}` , &nbsp;&nbsp; `A(z)_+ := Σ_{n<0} A_{(n)} z^{−n−1}`.

紧接着（书上 **p.178** 页首，L1 逐字）：

> This decomposition has the property
>
> &nbsp;&nbsp;&nbsp;&nbsp; `(∂A(z))_± = ∂(A(z)_±)`,
>
> and conversely, this property determines this decomposition.

> ⚠ **约定陷阱（务必写进图里的约定节点）**：Schottenloher 的下标 `−` 是**模式指标 `n ≥ 0` 的那一半**
> （即 `z` 的负幂部分，含 `Res`），`+` 是 `n < 0` 的那一半（`z` 的非负幂部分）。
> **这与物理里常见的「`+` = 湮灭部分」记法方向相反**，也与「`A_±` 按 `z^{±}` 幂次命名」的直觉相反。
> 抄 Definition 10.9 或 Theorem 10.10 第 3、4 条时如果把 `±` 弄反，正规序积就写反了。

---

## 11A.2 **Definition 10.9**（正规序积，书上 **p.178**；L1 逐字）

> **Definition 10.9.** The *normally ordered product* for distributions `A, B ∈ R[[z^±]]` is the distribution
>
> &nbsp;&nbsp;&nbsp;&nbsp; `:A(z)B(w): := A(z)_+ B(w) + B(w)A(z)_− ∈ R[[z^±, w^±]]`.
>
> Equivalently,
>
> &nbsp;&nbsp;&nbsp;&nbsp; `:A(z)B(w): = Σ_{n∈ℤ} ( Σ_{m<0} A_{(m)}B_{(n)} z^{−m−1} + Σ_{m≥0} B_{(n)}A_{(m)} z^{−m−1} ) w^{−n−1}`,
>
> and the definition leads to the formulas
>
> &nbsp;&nbsp;&nbsp;&nbsp; `A(z)B(w) = +[A(z)_−, B(w)] + :A(z)B(w): ,`
> &nbsp;&nbsp;&nbsp;&nbsp; `B(w)A(z) = −[A(z)_+, B(w)] + :A(z)B(w): .`

紧接其后一句（L1 逐字）：

> With this new notation the result of Proposition 10.6 can be restated as follows.

——即 **Definition 10.9 是 Theorem 10.10 第 4 条得以成立的记号前提**，两者在书上是连着的。

**内部一致性核对（researcher 推导，不是原文）**：把 11A.1(b) 的 `A(z)_+ = Σ_{n<0} A_{(n)}z^{−n−1}`、
`A(z)_− = Σ_{n≥0} A_{(n)}z^{−n−1}` 代入定义式的第一行，正好得到第二行的 `Σ_{m<0}(AB) + Σ_{m≥0}(BA)`。
**两行自洽，转录无误。**

---

## 11A.3 ★★ **Q10 结案**：Theorem 10.10 第 5 条的求和下限

### (a) 页面上印的是什么（L1，两次不同缩放各读一遍）

书上 p.178 的 Theorem 10.10 第 5 条，**印本逐字**为：

> 5. `[A_{(m)}, B_{(n)}] = Σ_{j=1}^{N−1} (m choose j) C^j_{(m+n−j)}`, &nbsp; `m, n ∈ ℤ`, &nbsp; *for suitable*
>    `C^j = Σ_{k∈ℤ} C^j_{(k)} w^{−k−1} ∈ R[[w^±]]`.

**即：页图上确实是 `j = 1`，不是 `j = 0`。**（第 2、3、4 条同页均为 `j = 0`，对比明显；
本轮先读 PDF 第 7–9 页一次，再单独重取 PDF 第 8 页放大复读一次，两次判读一致。）

### (b) 但这是**排印错误**；图里按 `j = 0` 是对的

**结论：`j = 1` 是印刷错误，正确下限是 `j = 0`。图里现有的 `j = 0` 不用改，但必须加 note。**
四条独立证据：

| # | 证据 | 等级 |
|---|---|---|
| 1 | **同一条定理内部不自洽**：第 2、3、4 条都是 `Σ_{j=0}^{N−1}`，且用的是**同一批** `C^j` 与**同一个** `N`。若第 5 条真从 `j=1` 起，它就严格弱于第 2–4 条，「五条等价」不成立 | L1（同页对照） |
| 2 | **Proposition 10.6（书上 p.175）产出的正是 `c^0,…,c^{N−1}`**（`j` 从 0 到 `N−1`，见 §11.2），第 5 条丢掉 `j=0` 项等于丢掉 Prop 10.6 给出的一个系数 | L1 |
| 3 | **独立文献给的同一条公式下限是 0**：Gui, *Lectures on VOAs and Conformal Blocks*（2026-07-15 版）**Definition 5.9 式 (5.27)**（本文件 §8.3 已 L1 逐字转录）写作 `[A_m, B_k] = Σ_{l=0}^{N−1} (m choose l) C^l_{m+k−l}` | L1（另一份文献） |
| 4 | **本章在这一带有系统性的交叉引用排印错误**：书上 p.179 写「according to **4 in Lemma 10.5**」，p.180 两处写「our **Theorem 10.5**」「property **5 in Lemma 10.5**」——**三处**的「10.5」都应为「10.10」（10.5 是 delta 恒等式引理，没有 property 4/5）。同一区域已有三处编号误植，第 5 条下限误植完全在情理之中 | L1（§11.4 记了两处，本轮补到三处） |

**researcher 自己的推导（明确标为推导，不是原文）**——由第 2 条直接算出第 5 条：

```
A_(m) = Res_z A(z) z^m                              [p.177 记号段]
Res_z z^m D^j_w δ(z−w) = (m choose j) w^{m−j}       [p.177 D^jδ 展开式]

[A_(m), B_(n)] = Res_z Res_w z^m w^n [A(z),B(w)]
               = Res_z Res_w z^m w^n Σ_{j=0}^{N−1} C^j(w) D^j_w δ(z−w)      [第 2 条]
               = Σ_{j=0}^{N−1} (m choose j) Res_w C^j(w) w^{m+n−j}
               = Σ_{j=0}^{N−1} (m choose j) C^j_(m+n−j)
⇒ 下限必须是 j = 0。
```

**一个具体反例（researcher 由书上 p.179–180 的数据推出，不是原文）**：Virasoro 情形，
书上 p.179–180 给 `[T(z),T(w)] = (Z/12)∂³δ(z−w) + 2T(w)∂_wδ(z−w) + ∂_wT(w)δ(z−w)`，
故 `C⁰(w) = ∂_wT(w) ≠ 0`。若第 5 条从 `j=1` 起，就会把这一项整个丢掉。

> ⚠ **不要用书上 p.179 的 Heisenberg 例子去「验证」`j=1`**：那里正文写
> 「Because of `C¹(w) = Z` and `C^j(w) = 0` for `j ≠ 1` …」，即该例恰好 `C⁰ = 0`，
> **`j=0` 与 `j=1` 在这个例子里给出相同答案，它无法区分两者**。这是个容易上当的地方。

### (c) 给 curator 的处理建议

- 图里第 5 条**保持 `j = 0`**；
- 但该 source 的 `loc` 或推导 note 里必须写明：
  「**印本 Theorem 10.10 第 5 条的求和下限印作 `j = 1`，判定为排印错误**；本节点按 `j = 0`，
  依据是同条定理第 2–4 条、Proposition 10.6、以及 Gui Def 5.9 (5.27)」。
- 这样做的理由是项目原则 2（实话实说）：图里的公式与被引页面**不逐字一致**，就必须留痕，
  否则将来做回译审计时会被判为抄错。

---

## 11A.4 本轮对 §14.2 未解决问题的影响

- **Q10 中「Schottenloher 第 5 条下限」这一半：已结案**（见 11A.3）。
  Q10 中「Gui (5.27) 里 `C` 的上标」那一半**仍未复核**（本轮没有重开 Gui 的 PDF）。
- **Q12（p.180 两处「10.5」应为「10.10」）：本轮补充为三处**（p.179 一处、p.180 两处），
  且这条现在有了新用途——它是 11A.3 判定「第 5 条下限是排印错误」的旁证之一。
  仍未与作者勘误（若有）核对。
- 本轮**没有**新开任何其他文献；§12–§14 的结论不变。

---

# § PBW / Verma 模自由性

- 负责 agent：researcher
- 日期：2026-09-11（第三轮，与 §11A 同一轮）
- 触发：图节点 **`verma-module-pbw-basis--via-pbw`** 需要
  (A) Poincaré–Birkhoff–Witt 定理（`U(g)` 的有序单项式基）与
  (B) 其推论「Verma 模 `M(λ)` 作为 `U(n⁻)`-模自由、秩 1」的**可核实编号**
- 证据等级沿用本文件 §0 的 L0–L4 表
- **本节最重要的两条结论先写在前面**：
  1. **(A) 已落定**：Humphreys GTM 9 **§17.3「PBW Theorem and consequences」（起于 p.91），Corollary C 在 p.92**——
     由一篇已发表论文的逐字引用 + Google Books 全文检索（带通过的控制实验）**两条独立证据**互证（§15）。
  2. **(B) 没有落定，而且比「没落定」更糟：任务书给的候选（Humphreys §20.3）方向就不对。**
     Humphreys 全书只讲**有限维半单**李代数，**根本不覆盖 Virasoro**；而本项目的 Verma 模是 Virasoro Verma 模。
     本轮找到的最贴切来源是**已经在 `sources.bib` 里的 `virasoro-lean-2025`（Kytölä）§12**，
     它给的是 Virasoro Verma 模 `𝒱_{c,h}` 的 PBW 基本身，**但那句话没有编号**（§16、§17）。

---

## 15. ★ (A) PBW 定理：**Humphreys, GTM 9 (1972), §17.3, Corollary C, p. 92**

### 15.1 结论与证据链

| 待核实项 | 结论 | 等级 |
|---|---|---|
| 书目 | J. E. Humphreys, *Introduction to Lie Algebras and Representation Theory*, Graduate Texts in Mathematics **9**, Springer-Verlag, New York-Berlin, **1972** | **L1**（见 15.2 的逐字参考文献条目） |
| §17 章题 | 「Universal enveloping algebras」，约起于 **p.89** | L4 |
| §17 子节 | 17.1 Tensor and symmetric algebras / 17.2 Construction of `U(L)` / **17.3 PBW Theorem and consequences** / 17.4 Proof of PBW Theorem / 17.5 Free Lie algebras | L4（检索后端读目录）**＋** L4-带控制（见 15.3） |
| §17.3 起始页 | **p.91** | L4-带控制 |
| **PBW 基所在编号** | **Corollary C**，书上 **p.92** | **L3（已发表论文逐字引用）＋ L4-带控制（Google Books）** |

### 15.2 证据 1（**L1** 逐页读图）：Ardizzoni 的逐字引用

来源：A. Ardizzoni, *Universal Enveloping Algebras of PBW Type*, **arXiv:1008.4523v2**（2010-12-23；
已发表于 Glasgow Math. J. **54** (2012)）。获取：`https://arxiv.org/pdf/1008.4523` WebFetch 落盘 312.9 KB → `Read` 带 `pages` 读图。

**该文 p.1（Introduction 第一段）逐字（L1）**：

> Let `L` be a Lie algebra which is assumed to have a totally ordered basis `(X, ≤)`. A classical result from the
> theory of Lie algebras asserts that the elements `x₁⋯xₙ`, where `n ≥ 1`, `xᵢ ∈ X`, for all `1 ≤ i ≤ n`, and
> `x₁ ≤ x₂ ≤ ⋯ ≤ xₙ`, along with `1`, form a basis of the universal enveloping algebra `U(L)` of `L`. This theorem
> is due to Poincaré, Birkhoff and Witt and the basis is called the **PBW basis** of the universal enveloping
> algebra (**see e.g. [Hu, Corollary C, page 92]**).

**该文 p.15（References）逐字（L1）**：

> **[Hu]** J. E. Humphreys, *Introduction to Lie algebras and representation theory*. Graduate Texts in Mathematics,
> Vol. **9**. Springer-Verlag, New York-Berlin, **1972**.

> ⚠ **版本小坑**：检索后端转述的是**期刊版**的编号 `[15, Corollary C, p. 92]`；arXiv 版用的是 `[Hu]`。
> 两者指同一条。**引用时写 arXiv 版的 `[Hu]`**，因为那是我 L1 读到的。

**这条证据的性质**：我 L1 读到的是**Ardizzoni 的引用行为**，不是 Humphreys 的正文。
对 Humphreys 而言这是 **L3**（可溯源二手陈述）。但它是一篇同行评议论文对一条具体页码+编号的点名引用，
比讲义转述强。

### 15.3 证据 2（**L4，但控制实验通过**）：Google Books 全文检索

卷 id **`mSD4DvUFa6QC`**（= Humphreys GTM 9 的预览卷）。手法与 §9.2 一致：`books.google.com/books?id=<ID>&q=<短语>`，**只回页码、不回 snippet**。

| 查询短语 | 返回页 | 判读 |
|---|---|---|
| `"zzqxjkwmnbv"`（无意义串，**控制**） | **No results** | ✔ **控制通过**：本卷**没有** §9.2 记的「无命中回落到固定页」的病（FBZ 卷回落到 p.403）。因此本卷的返回页可以当作真实命中 |
| `"PBW Theorem and consequences"` | **p.91** | ✔ §17.3 的节标题，且与「§17 起于 p.89」相容 |
| `"Corollary C"` | **p.92** | ✔ **与 Ardizzoni 的「Corollary C, page 92」完全吻合** |
| `"maximal vector"` | p.32 | （旁证：与 §7 的 `sl₂` 表示论位置相容） |

**两条互相独立的证据落在同一个 (Corollary C, p.92) 上 ⇒ 这个定位可以写进图。**

### 15.4 Humphreys §17.3 里那几条编号**说的是什么**（内容 L1，编号字母 **不可搬运**）

印本拿不到，但有一份公开的、明说「基于 Humphreys §17」的研讨班讲稿：
**J. Swanson, "§17: The PBW Theorem"**，`https://www.jpswanson.org/talks/2015_Humphreys_PBW.pdf`
（WebFetch 落盘 326.2 KB → `Read` 全文读毕，9 页；**L1**）。首行逐字：

> The following are lecture notes based on §17 of Humphreys, covering universal enveloping algebras,
> the PBW theorem, and some consequences. (Speaker: Josh Swanson.)

它用的是**研讨班自己的连续编号（113–118）**，不是 Humphreys 的字母。按顺序，Humphreys §17.3 的内容是：

| Swanson 编号 | 内容（L1 逐字节录） | 对应 Humphreys |
|---|---|---|
| **Theorem 113 (PBW, Humphreys' version)** | 「The natural map `𝔖 → gr 𝔘` is an isomorphism of algebras.」 | §17.3 的 **Theorem**（Humphreys 证的是**分次版**） |
| Corollary 114 | 「`𝔘 ≅ 𝔽[v₁,v₂,…]` as `𝔽`-vector spaces.」 | 某条 Corollary |
| Corollary 115 | `W ⊂ 𝔗_m` 同构到 `𝔖_m` ⇒ `F_m𝔘 = F_{m−1}𝔘 ⊕ π(W)`；附注「**Humphreys seems to forget to note that `π` is injective on `W`**, though it's implicit in his proofs」 | 某条 Corollary |
| Corollary 116 | 「`i: L → 𝔘(L)` is injective.」 | 某条 Corollary |
| **Corollary 117 (PBW Theorem, standard)** | 「Let `(x₁,x₂,…)` be an ordered basis of `L`. Then the elements `x_{i₁}⋯x_{i_m} = π(x_{i₁}⊗⋯⊗x_{i_m})` for `m ∈ ℤ_{≥1}` with `i₁ ≤ ⋯ ≤ i_m`, together with `1`, form a basis for `𝔘(L)`, called a **PBW basis**.」 | **= Ardizzoni 引的 Corollary C** |
| **Corollary 118** | 「Let `H` be a subalgebra of `L`, and extend an ordered basis `(h₁,h₂,…)` of `H` to an ordered basis `(h₁,…,x₁,…)` of `L`. Then the homomorphism `𝔘(H) → 𝔘(L)` … is itself injective, and **`𝔘(L)` is a free `𝔘(H)`-module** with free basis consisting of all `x_{i₁}⋯x_{i_m}` with `i₁ ≤ ⋯ ≤ i_m`, along with `1`.」 | 某条 Corollary，**这条正是 (B) 的上游** |

另记（L1 逐字）：「**Humphreys writes `𝔊(L)` for `gr 𝔘(L)`** under this filtration」——
即 Humphreys 的定理原文用的是 `𝔊(L)` 这个记号，图里若抄公式要注意。

> ⚠⚠ **本轮发现的一个真矛盾，未裁决，直接影响 `loc` 怎么写**：
> Ardizzoni 把**有序单项式基**那条定为 **Corollary C**；而按 Swanson 的顺序，
> 有序单项式基那条排在**第 4 位**（114→A, 115→B, 116→C, 117→D 的话，它该是 **Corollary D**）。
> 两者对不上，说明**「Swanson 的第 k 条 = Humphreys 的第 k 个字母」这个假设不成立**
> （很可能 Humphreys 没有把 115 那种技术性中间结论单列为 Corollary，或者字母顺序不同）。
> **硬性禁令：只允许写 `Corollary C, p. 92`（有两条独立证据），
> 绝不允许写 `Corollary A` / `Corollary B` / `Corollary D` / `Corollary E` 中的任何一个，
> 也绝不允许把 Swanson 的编号 113–118 写进图。**

### 15.5 **未核实（L0）：Humphreys 的 PBW 是否对无限维 `L` 成立**

- Ardizzoni 引用它时的假设是「a Lie algebra which is **assumed to have a totally ordered basis**」，
  **没有有限维假设**（L1，见 15.2）；Swanson 的记号段也写「`L` is a Lie algebra over `𝔽`
  (**possibly infinite dimensional**)」，并加了一句「Many statements are true in much greater generality」（L1）。
- **但**：Humphreys 全书的通行约定是「`F` 代数闭、特征 0，李代数有限维」，**§17.1 开头那句话本轮没有核到（L0）**。
- ⇒ **结论：把 Humphreys Corollary C 用在 Virasoro（无限维）上，目前只有 L3/L1 的旁证，没有原文背书。**
  curator 若要这么用，**必须挂 `inferred: true`**，note 写「Humphreys 全书为有限维半单语境；
  Ardizzoni 与 Swanson 均在无限维/任意李代数语境下引用同一条，但 Humphreys §17.1 的适用范围声明未核实」。

---

## 16. ★★ (B) Verma 模自由性：本项目真正该引的是 **`virasoro-lean-2025` §12**，不是 Humphreys

### 16.1 为什么 Humphreys §20.3 方向不对（**这是本节最重要的判断**）

- Humphreys, GTM 9 **整本书讲的是「代数闭特征 0 域上的有限维半单李代数」**；
  §20 用根系 `Φ`、Borel 子代数 `B = H ⊕ ⊕_{α∈Φ⁺}L_α`、`Z(λ)` 记号。
  **Virasoro 代数不在它的适用范围内**（无限维、不是半单、没有有限根系）。
- 而本项目的 Verma 模是 **Virasoro Verma 模**（见 `lian-zuckerman-1991` Theorem 3.5(ii) 里的
  `L(26−D, 1−h)`、`worldsheet.kac-determinant` 一线）。
- ⇒ **即使把 Humphreys §20.3 的编号核实到 L1，它也不能单独支撑本项目的 Verma 节点。**
  这与 §4.1 里「Evans 即使核实出编号也不是最贴的来源」是同一类判断。

### 16.2 Humphreys §20.3 的编号核实结果：**候选、编号未核实（L0）**，且**很可能不是那条陈述**

- Google Books（同 15.3 的卷，控制已通过）：
  `"Existence and uniqueness theorems"` → **p.3**（与第 20 章毫不相容，判为无用命中）；
  `"Standard cyclic modules"` → **p.167**、`"Verma"` → **p.167**（都落在书末索引区）；
  `"Weights and maximal vectors"` → **p.111**。
  **四条都不能把 §20.x 的子节号钉死。**
- 本轮唯一 **L1 读到的、明确写出「section 20.3 of [Hum72]」的公开讲义**是
  Lily Li, *Weights and Verma Modules*（UC Berkeley Math 261A 期末作业，2021），
  `https://www.ocf.berkeley.edu/~lilyl/wp-content/uploads/2021/06/Verma-Modules.pdf`（4 页，落盘读毕）。
  它把 §20.3 挂在 **Theorem 2.1「Theorems of the Highest Weight」**（不可约表示有最高权 / 同最高权则等价 /
  最高权是 dominant integral / 每个 dominant integral 都能实现）下面，逐字为
  「*Proof.* The proof is ommitted here. For a full proof, see **section 20.3 of [Hum72]**.」
  ⇒ **§20.3 指向的是「最高权定理」，不是「`M(λ)` 作为 `U(n⁻)`-模自由秩 1」。**
  连节号本身的语义都与任务书的假设不符。
- 另有一条记号差异（L3，多份讲义一致）：**Humphreys 用 `Z(λ)`，不用 `M(λ)`**。
  图里 `loc` 若写 `M(λ)` 会与原书记号不一致。
- ⇒ 按 `literature/CLAUDE.md` 口径，**Humphreys §20.3 记为「候选、编号未核实」，不作为 (B) 的来源。**

### 16.3 ★★★ 本轮找到的最贴切来源（**已经在 `sources.bib` 里**）：Kytölä, arXiv:2510.21741, **§12**

来源：`virasoro-lean-2025`（本文件 §12 已登记，`sources.bib` 有条目）。
本轮**新读**其 §12「Verma modules and Fock spaces」与 §13「Formalizing Verma modules」、§14 Conclusions
（`arxiv.org/pdf/2510.21741` 落盘 1.2 MB → `Read` 读 PDF 第 10–14 页；**PDF 页 = 论文页**）。全部 **L1 逐字**。

**可引用的编号结果（书上 p.10）**：

> **Definition 12.1.** Let `V` be a left `𝒰(𝔤)`-module. A vector `v ∈ V` is a **weight vector** of weight `λ` if
> `Hv = λ(H)v` for all `H ∈ 𝔤₀`. &nbsp;&nbsp; **(20)**

（其后 **(21)** `Xv = 0` for all `X ∈ 𝔤₊` 定义 **highest weight vector**；`V = 𝒰(𝔤)v` 定义 **highest weight module**。）

> **Definition 12.2.** A highest weight module `M` over `𝒰(𝔤)` with highest weight `λ` and corresponding highest
> weight vector `v ∈ M` is said to be a **Verma module** with highest weight `λ` if the following universal property
> is satisfied: for any `𝒰(𝔤)`-module `V` with a highest weight vector `v` of highest weight `λ`, there exists a
> unique `𝒰(𝔤)`-module homomorphism `f : M → V` such that `f(v) = v`.

> **Lemma 12.3.** For `𝔤 = 𝔤₋ ⊕ 𝔤₀ ⊕ 𝔤₊` and `λ ∈ 𝔤₀*` as above, let `I_λ ⊂ 𝒰(𝔤)` be the left ideal generated by
> the elements of the form `H − λ(H)1` for `H ∈ 𝔤₀` and `X` for `X ∈ 𝔤₊`. View `𝒰(𝔤)` as a left module over itself,
> so that `I_λ` becomes a submodule. Then the module `M_λ := 𝒰(𝔤)/I_λ` is a Verma module ("the Verma module")
> with highest weight `λ`, with `v_λ := 1 + I_λ ∈ 𝒰(𝔤)/I_λ` as its highest weight vector.

> **Definition 12.4.** The Virasoro algebra has a triangular decomposition `𝔳𝔦𝔯 = 𝔳𝔦𝔯₋ ⊕ 𝔳𝔦𝔯₀ ⊕ 𝔳𝔦𝔯₊` where
> `𝔳𝔦𝔯_± = span_𝔽{ℒ_n | ±n > 0}`, `𝔳𝔦𝔯₀ = span_𝔽{ℒ₀, C}`.
> Let `c, h ∈ 𝔽`. The **Virasoro Verma module** `𝒱_{c,h}` of **central charge** `c` and **conformal weight** `h` is
> the Verma module associated with the above triangular decomposition and the highest weight `λ ∈ 𝔳𝔦𝔯₀*` defined by
> `λ(C) = c` and `λ(ℒ₀) = h`. We denote (a choice of) its highest weight vector by `v_{c,h}`.

> **Definition 12.5.** The Heisenberg algebra has a triangular decomposition `𝔥𝔢𝔦 = 𝔥𝔢𝔦₋ ⊕ 𝔥𝔢𝔦₀ ⊕ 𝔥𝔢𝔦₊` where
> `𝔥𝔢𝔦_± = span_𝔽{𝒥_k | ±k > 0}`, `𝔥𝔢𝔦₀ = span_𝔽{𝒥₀, 𝒦}`.
> Let `α ∈ 𝔽`. The **charged Fock space** `ℱ_α` of **charge** `α` is the Verma module for `𝔥𝔢𝔦` associated with the
> above triangular [decomposition and the highest weight `λ ∈ 𝔥𝔢𝔦₀*` defined by `λ(𝒦) = 1`, `λ(𝒥₀) = α`]。

**★ 图节点真正要的那句话（书上 p.11，紧接 Def 12.5 之后；L1 逐字）**：

> From the Poincaré–Birkhoff–Witt (PBW) theorem, it can be seen that a basis of `𝒱_{c,h}` is
>
> &nbsp;&nbsp;&nbsp;&nbsp; `(ℒ_{−n_m} ⋯ ℒ_{−n_1} v_{c,h})_{m∈ℕ, 1≤n_1≤⋯≤n_m}`.
>
> Similarly, a basis of `ℱ_α` is
>
> &nbsp;&nbsp;&nbsp;&nbsp; `(𝒥_{−k_m} ⋯ 𝒥_{−k_1} v_α)_{m∈ℕ, 1≤k_1≤⋯≤k_m}`.

> ⚠ **这句话没有编号**：它是 §12 的正文散文，夹在 Definition 12.5 与 Corollary 12.6 之间，
> **不是 Lemma / Proposition / Theorem**。`loc` 只能写「§12, p. 11（正文，无编号）」，
> **不得写「Kytölä Lemma 12.x」**。这与 §8.4 里 Gui 的「三版局域性等价没有编号定理」是同一种坑。

### 16.4 ★★★ **对 `status` 的硬约束：PBW 不在 Mathlib 里，所以这个节点不能标 `formalized`**

紧接上面那句话（书上 p.11，L1 **逐字**）：

> These statements about explicit bases of Verma modules are **not yet formalized**, since **Mathlib does not
> currently have the PBW theorem**. The PBW theorem was perhaps the only major missing desirable prerequisite of
> the project. A few compromises in the scope were made to avoid relying on it.

§14「Conclusions and outlook」（书上 p.12，L1 逐字）：

> Highest weight representation theory of Lie algebras is a classical topic in mathematics **[Hum72]**, certainly
> wanted in Mathlib. It is likely a major undertaking, starting from the **missing Poincaré–Birkhoff–Witt theorem**.
> We hope that our design experiment with Verma modules proves helpful there.

**独立佐证（L1，读取日期 2026-09-11）**：`leanprover-community.github.io/mathlib4_docs/Mathlib/Algebra/Lie/UniversalEnveloping.html`
只有 17 个声明——`Rel`、`ringCon`、`UniversalEnvelopingAlgebra`、三个 instance、`mkAlgHom`、`ι`、`ι_apply`、
`lift`、`lift_symm_apply`、`ι_comp_lift`、`lift_ι_apply`、`lift_ι_apply'`、`lift_unique`、`hom_ext`、`hom_ext_iff`——
**全部围绕构造与泛性质**；**没有 PBW、没有滤过、没有与对称代数的同构，也没有 TODO 段**。

> ⇒ **`verma-module-pbw-basis--via-pbw` 现在最高只能到 `rigorous`，不能标 `formalized`。**
> 这与 §12.3 记的「Mathlib 的 `Locality` 还是 TODO ⇒ 顶点代数节点不能 `formalized`」是同一类硬约束，
> 但**这一条更硬**：Locality 至少在 TODO 列表里，PBW 连 TODO 都没有。
>
> **同时这是 `formal/` 的一条重要情报**：Kytölä 已经把 Verma 模的**理想商构造**（`vermaIdeal`、`VermaModule`、
> `VermaModule.hwVec`、`VermaModule.universalMap`、`IsVermaModule`）形式化了（论文 §13 有 Lean 代码块），
> **只有「显式 PBW 基」这一步没做**。所以形式化侧的缺口是**精确的一条**：`Mathlib` 的 PBW 定理。

### 16.5 一条重要的方法论警告：**(B) 在文献里多半根本没有编号**

本轮扫过的多份来源显示，「`M(λ)` 作为 `U(n⁻)`-模自由秩 1」通常**不是**一条独立编号命题，而是：

- 被**写进定义**：例如 Bershtein, *Virasoro algebra and conformal field theory*（SISSA 讲义）
  **Definition 2.1** 把 `V_{h,c}` 直接定义成「a module freely generated by `Vir_{<0}`」（L4，检索后端转述）；
  arXiv:1405.6734 也把「free as a module over `U(L₁)`」当作 Verma 模的**定义条件**（L4）。
- 或者被当作**PBW 的即时推论**一笔带过（Kytölä §12 就是这样，见 16.3）。

⇒ **给 curator 的建议：不要去找一条并不存在的「Theorem X.Y」。**
这条陈述在图里应当按「定义级 / PBW 的直接推论」处理，`loc` 指向定义或正文段落，
并在 note 里写明「文献未把它写成编号命题」。**与 §8.4（Gui 三版等价）同型处理。**

---

## 17. 未能核实编号的候选（**一律不登记进 `sources.bib`**）

沿用 §4 的口径：编号没核实的一律不入 bib，只在这里留档。

| 候选 | 任务书给的定位 | 本轮结果 | 等级 |
|---|---|---|---|
| **Dixmier, *Enveloping Algebras*** (North-Holland Math. Library **14**, 1977；法文原版 *Algèbres enveloppantes* 1974) | §2.1.11 | **完全未核实。** 没找到任何公开可读页面。检索后端只给了一句**自陈为猜测**的话（「2.1.11 falls among the consequences of the main theorem (2.1.9/2.1.10)」），**不可用**。另注意 1974 法文版 / 1977 英译版编号是否一致也未查 | **L0** |
| **Kac, *Infinite-Dimensional Lie Algebras*, 3rd ed.** | §9.2（Verma 模）、Prop 9.2 / 9.3 | **完全未核实**，无公开页面。**并且有结构性反对意见**：该书讲的是 **Kac–Moody 代数 `g(A)`**，而 **Virasoro 代数不是 Kac–Moody 代数**，所以即使核实出 §9.2 也不直接覆盖 `𝒱_{c,h}`。Kac 的 Virasoro 材料在别处（Kac–Raina 一线） | **L0** |
| **Moody–Pianzola, *Lie Algebras with Triangular Decompositions*** (Wiley, 1995) | 任务书未给具体号 | **完全未核实**，无公开全文。**但它是几个候选里框架最对的**：三角分解正好覆盖 Virasoro。值得下一轮找 | **L0** |
| **Iohara–Koga, *Representation Theory of the Virasoro Algebra*** (Springer Monographs, 2011) | 本轮新增候选 | **完全未核实**，无公开全文。**这是主题最对口的书**（Kytölä 的 [IK10]），目录含「Verma Modules I: Preliminaries」「Verma Modules II: Structure Theorem」 | **L0** |
| **Feigin–Fuks 1984**, *Verma modules over the Virasoro algebra*, Funct. Anal. Appl. **17**(3):241–242 | 本轮新增候选 | 未取正文。这是 Kytölä 的 **[FF84]**，Virasoro Verma 模结构定理的经典出处，Kytölä 把「Feigin–Fuks structure theorem 的形式化」列为后续目标 | **L0** |
| **Humphreys §20.3** | Verma 模自由秩 1 | 见 16.2：**编号未核实，且方向不对**（§20.3 指向最高权定理；全书不覆盖 Virasoro） | **L0** |

---

## 18. 图里建议怎么引（供 curator 取舍；researcher 不改 `graph/`）

针对 `verma-module-pbw-basis--via-pbw`：

```yaml
sources:
  # (A) PBW 定理本身 —— 唯一已核实的带编号来源
  - ref: humphreys-1972
    loc: "§17.3 (PBW Theorem and consequences), p. 91 起；有序单项式基 = Corollary C, p. 92"
    # note: 定位由 ardizzoni-2010 p.1 的逐字引用 + Google Books 全文检索两条独立证据互证；
    #       禁止把编号改写成 Corollary A/B/D。

  # (B) Virasoro Verma 模的 PBW 基 —— 无编号，只能指段落
  - ref: virasoro-lean-2025
    loc: "§12 (Verma modules and Fock spaces), p. 11 正文（**无编号**）：
          𝒱_{c,h} 的基为 (ℒ_{−n_m}⋯ℒ_{−n_1} v_{c,h})，1≤n_1≤⋯≤n_m；
          Verma 模的定义见 Definition 12.2（泛性质）与 Lemma 12.3（𝒰(𝔤)/I_λ 构造）；
          Virasoro 情形见 Definition 12.4"
```

配套建议（**均为建议，researcher 不代 curator / auditor 决定**）：

1. **`status` 上限是 `rigorous`，不得写 `formalized`。**
   依据是 16.4 的两条 L1 证据（Kytölä 自陈 + Mathlib 文档页）。
   若将来 Mathlib 有了 PBW，这条要重新评估——**建议在节点 note 里写死「读取日期 2026-09-11」**。
2. **建议把节点拆成两条**（与 §13.2 同一思路）：
   - `math.pbw-theorem`（PBW 定理本身，`rigorous`，来源 `humphreys-1972` §17.3 Corollary C）；
   - `math.verma-module-free-over-U-nminus`（`M(λ) ≅ U(n⁻)` 作为 `U(n⁻)`-模，`rigorous`，
     依赖前者，来源 `virasoro-lean-2025` §12 p.11）。
   现在合在一起会让「PBW 有干净编号」这一半被「Verma 那半没编号」拖下去。
3. **从 `math.pbw-theorem` 到 Virasoro 用例的那条边建议 `inferred: true`**：
   理由见 15.5——Humphreys 全书是有限维半单语境，无限维适用性只有旁证。
   note 建议写「Ardizzoni (arXiv:1008.4523) 与 Swanson 讲义均在任意/无限维李代数语境下引用同一条；
   Humphreys §17.1 的适用范围声明未核实」。
4. **记号对齐**：Humphreys 写 `Z(λ)` 与 `𝔊(L)`；Kytölä 写 `M_λ` / `𝒱_{c,h}` 与 `𝒰(𝔤)`；
   `lian-zuckerman-1991` 又是另一套。**建议在 `graph/conventions/` 加一条 `family: verma-module-notation`**，
   否则 `M(λ)` / `Z(λ)` / `𝒱_{c,h}` 在图里会被当成三个东西。
5. **形式化侧的具体提示**（给 `formalizer`）：Kytölä 的 `VirasoroProject` 已有
   `vermaIdeal` / `VermaModule` / `VermaModule.hwVec` / `VermaModule.universalMap` / `IsVermaModule`，
   **唯独缺 PBW 基**。所以 `formal/` 若要碰这块，缺口是**精确的一条：Mathlib 的 PBW 定理**，
   而不是整套 Verma 模理论。这是个明确但**很大**的工程（Kytölä 逐字称之为 "a major undertaking"）。

---

## 19. 本节访问日志与未解决问题

### 19.1 访问日志（本轮，供后人省事）

| 目标 | URL / 手法 | 结果 |
|---|---|---|
| **Ardizzoni, arXiv:1008.4523v2** | `arxiv.org/pdf/1008.4523` | **成功**（落盘 312.9 KB → `Read pages`；p.1 引用 + p.15 参考文献） |
| **Swanson §17 讲稿** | `www.jpswanson.org/talks/2015_Humphreys_PBW.pdf` | **成功**（落盘 326.2 KB，9 页全读） |
| **Lily Li, Verma Modules 讲义** | `www.ocf.berkeley.edu/~lilyl/wp-content/uploads/2021/06/Verma-Modules.pdf` | **成功**（落盘 204 KB，4 页全读） |
| **Kytölä arXiv:2510.21741** | `arxiv.org/pdf/2510.21741` | **成功**（落盘 1.2 MB；本轮读 p.10–14） |
| **Mathlib 文档 `UniversalEnveloping`** | `leanprover-community.github.io/mathlib4_docs/Mathlib/Algebra/Lie/UniversalEnveloping.html` | **成功**（逐条读声明名与 docstring） |
| Google Books（Humphreys GTM 9） | `books.google.com/books?id=mSD4DvUFa6QC&q=<短语>` | **成功且控制通过**（无意义串回 "No results"，**本卷无回落页病**） |
| Springer 书页（GTM 9 目录） | `link.springer.com/book/10.1007/978-1-4612-6398-2` | **失败：303 重定向到 `idp.springer.com/authorize`（登录墙）** |
| Google Books（错卷 id 试探） | `books.google.com/books?id=mSD4DwAAQBAJ&…` | 失败——**该 id 是一本无关的日文小说**。正确 id 是 **`mSD4DvUFa6QC`**（只差两个字符，极易抄错） |

> **对 `reading-list.md` 的建议增补**：
> - **新增活路**：`www.jpswanson.org/talks/`、`www.ocf.berkeley.edu/~<user>/`、`arxiv.org/pdf/`（本轮再次全程正常）。
> - **新增死路**：`link.springer.com/book/*` → **303 到 `idp.springer.com` 登录墙**（Springer 书页现在拿不到目录了）。
> - **Google Books 手法的更新**：§9.2 记的「无命中回落到固定页」**不是全站行为，是逐卷的**。
>   **每换一个卷 id 都要先跑一次无意义串的控制实验**：本轮 Humphreys 卷回 "No results"（干净），
>   而 §9.2 的 FBZ 卷回落到 p.403（脏）。控制通过的卷，返回页可以当真实命中用。
> - **一个新教训**：本轮 (A) 的定位是靠**「找一篇引用了它的已发表论文」**拿到的，
>   而不是靠找原书。这与 §14.1 记的「先找作者勘误表」并列为拿不到书时的两条标准路线：
>   **① 作者勘误表；② 引用它的论文里带页码+编号的 citation。**

### 19.2 未解决 / 留给下一轮

- **Q14** Humphreys §17.3 里 **Theorem 与各 Corollary 的字母到底怎么排**（15.4 的矛盾）。
  持原书者看一眼 p.91–93 即可结案。**在结案前，图里只许写 `Corollary C, p. 92`。**
- **Q15** Humphreys **§17.1 开头对 `L` 的假设**（是否明说可为无限维）。这条决定 15.5 那条 `inferred` 边能不能撤。
- **Q16** Humphreys **§20 的子节标题与页码**（`Weights and maximal vectors` 是章题还是 20.1？§20.3 的确切标题是什么）。
  优先级低——按 16.1 的判断，Humphreys §20 对本项目本来就不适用。
- **Q17** **(B) 的带编号一手来源仍然缺**。下一轮最值得抓的三个，按性价比排：
  **① Iohara–Koga (2011)**（主题最对口，Kytölä 的 [IK10]）；
  **② Moody–Pianzola (1995)**（三角分解框架，覆盖 Virasoro）；
  **③ Feigin–Fuks (1984)**（经典原始出处）。
  另可试 Bershtein 的 SISSA CFT 讲义 `www.people.sissa.it/~mbersht/CFT/2019/Lectures2019.pdf`
  （**Definition 2.1** 疑似把 freeness 写进定义，本轮只有 L4 转述，**未读原文**）。
- **Q18** **Mathlib 的 PBW 状态需要定期复查**（本轮读取日期 2026-09-11）。
  建议同时盯 `Mathlib/Algebra/Lie/UniversalEnveloping.lean` 与 Mathlib 的 `1000.yaml` 定理跟踪表
  （后者本轮**未查**）。另有一条 **L4 未核实**线索：`Mathlib/Algebra/Lie/Free.lean` 的 docstring
  据称写着「I don't know of a proof that avoids invoking the Poincaré–Birkhoff–Witt theorem」——
  若属实，是 Mathlib 侧缺 PBW 的第三条独立佐证，**值得花一次 fetch 去逐字核实**。
- **Q19** Dixmier §2.1.11 与 Kac IDLA §9.2 的编号（见 §17 表）。两者都**没有**公开可读页面，
  下一轮若要碰，建议改用「找引用它们的论文里的 citation」这条路（19.1 的教训）。
# § H²(Vir) = 0 / 万有中心扩张

- 负责 agent：researcher
- 日期：**2026-09-11（第三轮）**
- 触发：推导节点 `worldsheet.brst-nilpotent-at-c26--via-fgz` 的 `gaps` 里写着
  「把 FGZ Prop 1.2 用到 `g = Vir` 上时要的是 `H²(Vir, C) = 0`……**本图中没有这个节点，本推导对这一步无任何来源支撑**」。
  本节的任务就是给这条补一手、**带编号**的数学出处。
- 证据等级沿用本文件 §0 的 L0–L4 表。
- **一句话结论**：找到了。**首选是 Feldvoss–Siciliano, arXiv:2501.15560, Lemma 2.6（L1 逐字，特征零，带完整证明）**；
  第二来源是 **Schlichenmaier, Forum Math. 26 (2014), Remark 6.4**（L1 逐字，arXiv:1111.6625v4）。
  任务书里点名的四个候选（Fuks / Kac–Raina / Iohara–Koga / Kytölä）**一个都没能提供带编号的出处**，
  其中 Kytölä 是**确定的否定**。

---

> **编号说明（lead 2026-09-11）**：本节原编 §15–§23，与前一节 PBW 部分（§15–§19）撞号，已整体改为 §24–§32；sources.bib 中 `feldvoss-siciliano-2025` 等条目 note 里引用的 "§21.4"/"§22.1" 等对应本文件 §30.4/§31.1。

## 24. 需求侧：两条**长得很像但不同**的陈述，绝不能混

| | 陈述 | 图里谁承载 | 本节要的是它吗 |
|---|---|---|---|
| (W) | `dim H²(Witt, k) = 1`（Witt 恰有一个非平凡一维中心扩张 = Vir） | `worldsheet.virasoro-unique-central-extension`（已有） | **不是** |
| (V) | `H²(Vir, k) = 0`（Vir 自身**没有**非平凡中心扩张） | **图里没有** ← 本节要补的 | **是** |

**(W) 不蕴含 (V)**，(V) 也不蕴含 (W)：它们是两个不同李代数的上同调群。
「Vir 是 Witt 的**万有**中心扩张」这句话之所以同时用到两者，是因为一般定理链是

```
Witt 完美 ⇒ 万有中心扩张存在（Weibel Thm 7.9.2）
dim H²(Witt,k) = 1 ⇒ 那个万有中心扩张就是 Vir（一维中心）
Vir 完美 且 H¹(Vir,k) = H²(Vir,k) = 0 ⇔ 「Vir → Witt」是万有的（Weibel Lemma 7.9.3 + Block Lemma 3.1）
```

即 **(V) 与「Vir 是万有的」在特征零下互为等价说法**（见 §28）。图里可以只立一条节点承载 (V)，
在 statement 里把「等价于万有性」写进去。

**还有第三条，别顺手推广**：`H²` 消失**不**沿维数继续。
Ecker–Schlichenmaier 明确算出 `dim H³(Vir, K) = 1`、`dim H³(Vir, Vir) = 1`（见 §27）。
所以任何形如「Vir 的上同调都是平凡的」的措辞都是错的。

**与 FGZ 的对接（供 curator/auditor 判，researcher 不代判）**：
按 `brst-cohomology-sources.md` §1.2 的 L1 记录，FGZ 的假设句逐字是
「From this point on we will assume that **H²(g) = 0** and that ω₀ and β are fixed in such a way that γ = 0」，
且 Prop 1.1(ii) 是「γ 代表 **H²(g)** 的平凡类时可取 γ ≡ 0」——**γ 是标量 2-上循环**，
所以 FGZ 的 `H²(g)` 读作「以平凡模为系数的李代数二阶上同调」是自然的，
本节找到的正是这个群。**但「FGZ 的 g 在 §2 里到底是 Vir（含中心）还是 Witt」我没有重新读 FGZ 原文核实**，
这一步的对接留给 curator/auditor。

---

## 25. ★★ 首选（L1 全文到手）：Feldvoss & Siciliano, *Lie algebras whose derivation algebras are simple*, arXiv:2501.15560

### 25.0 文献标识

| 项 | 值 | 等级 |
|---|---|---|
| 作者 | Jörg Feldvoss（University of South Alabama）、Salvatore Siciliano（Università del Salento） | L1（首页 + 末页地址栏） |
| 标题 | *Lie algebras whose derivation algebras are simple* | L1（首页） |
| arXiv | **2501.15560**，v1，`[math.RA]`，**26 Jan 2025**；正文首页脚注「Date: January 26, 2025.」 | L1（页边 arXiv 戳） |
| 篇幅 | 13 页（正文 1–12，参考文献 12–13，共 32 条） | L1 |
| MSC | Primary 17B05；Secondary 17B40, 17B56, 17B20, 17B25, 17B50, 17B65, 17B66, 17B68 | L1 |
| 期刊发表 | **未核实（L0）**。arXiv abs 页无 journal-ref；本轮检索未找到期刊版。 | L0 |

> ⚠ **这是一篇 arXiv 预印本，本轮没能确认是否已被期刊接受。** 引用时应在 note 里写明。
> 好消息是它引用的两条更老的来源（§26、§27）可以互相背书，所以不是孤证。

### 25.1 ★★★ **Lemma 2.6**（书上 p.7，L1 逐字）——**就是图里要的那条**

先是它的前置段落（书上 p.7，L1 逐字）：

> For the remainder of this section let `𝔽` be a field of characteristic zero. Then it is well known that the
> infinite-dimensional two-sided Witt algebra³ `𝒲 := Der(𝔽[t, t⁻¹])` is simple (see [21, Lemma 1.14]) and has a
> unique non-split central extension (up to equivalence), the *Virasoro algebra* `𝒱` (see [20, Section 1.3]). Set
>
> &nbsp;&nbsp;&nbsp;&nbsp; `𝒱 := ⊕_{n∈ℤ} 𝔽 d_n ⊕ 𝔽 c`
>
> with Lie brackets given by
>
> &nbsp;&nbsp;&nbsp;&nbsp; `[d_m, d_n] = (n − m) d_{m+n} + δ_{m+n,0} (1/12)(n − 1)n(n + 1) c` .
>
> The first part of the next result is well-known (see **[24, Remark 6.4]** and **[12, Section 5.1]**).
> For the convenience of the reader we indicate a proof that is the precise analogue of the proof of Lemma 2.4.

然后（书上 p.7，**L1 逐字**）：

> **Lemma 2.6.** *Let* `𝒱` *denote the Virasoro algebra over a field* `𝔽` *of characteristic zero. Then*
> `H¹(𝒱, 𝔽) = H²(𝒱, 𝔽) = 0`. *In particular, the Virasoro algebra* `𝒱` *is a universal central extension of the
> two-sided Witt algebra* `𝒲`.
>
> *Proof.* In order to prove that `H¹(𝒱, 𝔽) = 0`, we need to show that `𝒱` is perfect. We have that
> `[d₀, d_n] = n d_n` for any integer `n ≠ 0` which shows that `d_n ∈ [𝒱, 𝒱]` for `n ≠ 0`. Moreover, from
> `[d₋₁, d₁] = 2d₀` we obtain that `d₀ ∈ [𝒱, 𝒱]`. Finally, `[d₋₂, d₂] = 4d₀ + ½c` implies that `c ∈ [𝒱, 𝒱]`,
> and thus we have that `𝒱 = [𝒱, 𝒱]`.
> Now we can use the same arguments as in the proof of Lemma 2.4 in conjunction with `H¹(𝒲, 𝔽) = 0` and
> `dim_𝔽 H²(𝒲, 𝔽) = 1` (see [24, Section 2]) to complete the proof. □

- 类型：proposition（带完整证明的引理）
- 文献自称的严格程度：`Lemma` + 完整 `Proof`；作者自陈**第一部分（H¹=H²=0）是 well-known**，
  他们只是「为方便读者」补一个证明。**这不是新结果，但这是一条可引的编号陈述。**
- 文献列出的依赖：`H¹(𝒲,𝔽) = 0` 与 `dim H²(𝒲,𝔽) = 1`（引 [24, Section 2] = Schlichenmaier 2014）；
  以及 Lemma 2.4 证明里的长正合序列（引 [18, Theorem 7] = Hochschild–Serre 1953）。
- **注意「perfect ⇒ H¹ = 0」这一步在正文里是当作已知用的**（`H¹(L,𝔽) ≅ (L/[L,L])*`，见 §27 里
  Ecker–Schlichenmaier §3.3.2 的显式公式）。
- 证据等级：**L1**

**配套的 Corollary 2.7（书上 p.7，L1 逐字）**，顺带解决「还有没有别的覆盖代数」这个问题：

> **Corollary 2.7.** *Let* `𝔽` *be a field of characteristic zero. Then* `𝒲` *and the Virasoro algebra* `𝒱`
> *are the only covering algebras of the two-sided Witt algebra* `𝒲` *up to isomorphism.*

### 25.2 ★ 同文提供的一般定理链（书上 p.4–p.5，L1 逐字）——这是 §28 的证据来源

覆盖代数的定义（p.4）：

> Let `0 → C̄ → L̄ → L → 0` be a central extension of a Lie algebra `L`. Then `L̄` is called a *covering algebra*
> of `L` if `L̄` is perfect, i.e., `L̄ = [L̄, L̄]` (see [16, Definition 1.4] or [2, Section 2]). Since homomorphic
> images of perfect Lie algebras are perfect, only perfect Lie algebras admit a covering algebra. Moreover, if
> `C(L) = 0`, then `C̄ = C(L̄)`.

> **Lemma 2.1.** *Let* `L` *be a Lie algebra over a field* `𝔽` *with* `H²(L, 𝔽) = 0`. *Then* `L` *has at most one
> covering algebra up to isomorphism.*

万有中心扩张的定义与**两条 Weibel 引用**（p.5，**L1 逐字，本节最重要的一段**）：

> A *universal central extension* of a Lie algebra `L` is a central extension
> `0 → Ĉ → L̂ →^{π̂} L → 0` of `L` such that for every central extension `0 → Z → E →^{π} L → 0` of `L` there
> exists a unique homomorphism `φ : L̂ → E` of Lie algebras satisfying `π ∘ φ = π̂`. Note that then necessarily
> `φ(Ĉ) ⊆ Z`. It is clear from this definition that a universal central extension of `L` is unique up to
> isomorphism, in case it exists. Since universal central extensions must be perfect, they are covering algebras.
> **It is well known that a Lie algebra** `L` **over a field** `𝔽` **has a universal central extension if, and only
> if,** `L` **is perfect (see [31, Theorem 7.9.2]). Moreover, we conclude from [4, Lemma 3.1] and
> [31, Lemma 7.9.3] that a central extension** `0 → Ĉ → L̂ →^{π̂} L → 0` **is universal exactly when**
> `H¹(L̂, 𝔽) = H²(L̂, 𝔽) = 0`. In particular, the property of being universal is independent of `L`.

其中 **[31] = Weibel**、**[4] = Block 1968**（参考文献逐字见 §25.4）。
另有 **Lemma 2.2**（`L` 完美 ⇒ `L` 的万有中心扩张也是 `L` 的每个覆盖代数的万有中心扩张）与
**Corollary 2.3**（`dim Ĉ = 1` 时 `L` 与 `L̂` 是 `L` 的唯一两个覆盖代数），**Remark 3.4(2)** 里还有
（p.10，L1 逐字）「`Ĉ` is isomorphic to `H₂(𝔤, 𝔽)`, the second homology space of `𝔤` with coefficients in the
trivial module `𝔽` (see, e.g., **[31, Theorem 7.9.2]**)」——即 **Weibel Thm 7.9.2 同时含「iff 完美」与「核 ≅ H₂」两件事**。

### 25.3 ⚠ 三个必须随引用一起写的陷阱

1. **Lemma 2.4 ≠ Lemma 2.6，别引错。**
   **Lemma 2.4**（书上 p.6，L1 逐字）是
   > *Let* `V` *denote the **restricted Virasoro algebra** over a field* `𝔽` *of **prime characteristic** p > 3.
   > Then* `H¹(V, 𝔽) = H²(V, 𝔽) = 0`. *In particular, the restricted Virasoro algebra is a universal central
   > extension of the Witt algebra.*

   这是**特征 p > 3 的受限 Virasoro 代数**（`V := ⊕_{n=−1}^{p−2} 𝔽e_n ⊕ 𝔽z`，有限维！），
   与弦论用的复 Virasoro 代数**完全不是同一个对象**。
   作者在其前面逐字写「The next result is perhaps well known. But since we could not find a suitable reference,
   we include its proof for the convenience of the reader.」——**这句「找不到合适的参考文献」是针对 char p 版本的，
   不是针对 Lemma 2.6。** 检索后端很容易把这两条混起来（本轮就遇到一次），**图里绝不能把 2.4 填成来源**。
   配套的 **Corollary 2.5** 也是 char p。

2. **括号约定与 `conv.virasoro-standard` 不一致，但结论不受影响。** 四份来源的括号写法并列：

   | 来源 | 括号 |
   |---|---|
   | 图里 `conv.virasoro-standard`（Polchinski 系） | `[L_m,L_n] = (m−n)L_{m+n} + (c/12) m(m²−1) δ_{m+n,0}` |
   | Feldvoss–Siciliano | `[d_m,d_n] = (n−m)d_{m+n} + δ_{m+n,0}(1/12)(n−1)n(n+1) c` |
   | Schottenloher Def 5.2（§29） | `[L_n,L_m] = (n−m)L_{n+m} + δ_{n+m}(n/12)(n²−1) Z` |
   | Ecker–Schlichenmaier（§27） | `[ê_n,ê_m] = (m−n)ê_{n+m} − (1/12)(n³−n) δ_n^{−m} t` |

   四者互为「重标记生成元/中心元符号」的差别（`d_n ↦ ±L_{±n}`、`c ↦ ±c`），**都是同一个李代数**。
   **`H²(Vir, k) = 0` 这条结论对这些符号约定完全不敏感**（同构的李代数有同构的上同调），
   所以图里这条节点**可以不挂 `conv.virasoro-standard`**，或者挂上但在 note 里说明「结论与约定无关」。
   **但 statement 里若要抄出括号式，就必须抄图自己那套，不能照抄任一来源。**

3. **「universal central extension of the **two-sided** Witt algebra」这个「two-sided」不是修辞。**
   本文脚注 3（书上 p.7，L1 逐字）：
   > In Olivier Mathieu's paper the Virasoro algebra is the two-sided Witt algebra `𝒲` (see [21] (0.1.4)]), but we
   > follow here the general custom to call the universal central extension `𝒱` of `𝒲` the Virasoro algebra
   > (see also footnote 3 in [21]).

   即：`𝒲 = Der(𝔽[t,t⁻¹])` 是双边（`n ∈ ℤ`）Witt 代数，与「单边」`W_r`（`𝔽[x₁,…,x_r]` 的导子代数）不同。
   同文 **Proposition 1.2**（p.4，L1 逐字）说「`H²(W_r, 𝔽) = 0` and `H²(K_{2r+1}, 𝔽) = 0`」——
   **单边 Witt 代数的 H² 是零**（没有中心扩张），与双边的 `dim H² = 1` 相反。
   图里 `math.witt-algebra` 若指双边（`ℓ_n, n ∈ ℤ`）就对得上；否则会撞车。

### 25.4 由本文参考文献 L1 抄下的关键条目（供 `sources.bib`）

（书上 p.12–13，逐字）

- **[4]** R. E. Block: *On the extensions of Lie algebras*, Canad. J. Math. **20** (1968), 1439–1450.
- **[12]** J. Ecker and M. Schlichenmaier: *The vanishing of the low-dimensional cohomology of the Witt and the
  Virasoro algebra*, Preprint (26 pages), available as **arXiv:1707.06106v2 [math.RA]**, March 26, 2018.
- **[16]** H. Garland: *The arithmetic theory of loop groups*, Inst. Hautes Études Sci. Publ. Math. **52** (1980), 5–136.
- **[18]** G. Hochschild and J-P. Serre: *Cohomology of Lie algebras*, Ann. Math. (2) **57** (1953), no. 3, 591–603.
- **[20]** V. G. Kac, A. K. Raina, and N. Rozhkovskaya: *Bombay Lectures on Highest Weight Representations of
  Infinite Dimensional Lie Algebras* (**Second edition**), Advanced Series in Mathematical Physics, vol. **29**,
  World Scientific, Hackensack, NJ, **2013**.
- **[21]** O. Mathieu: *Classification of simple graded Lie algebras of finite growth*, Invent. Math. **108** (1992), no. 3, 455–519.
- **[22]** E. Neher: *An introduction to universal central extensions of Lie superalgebras*, in: *Groups, Rings, Lie
  and Hopf Algebras*, Math. Appl., vol. **555**, Kluwer, Dordrecht, 2003, pp. 141–166.
- **[24]** M. Schlichenmaier: *An elementary proof of the vanishing of the second cohomology of the Witt and
  Virasoro algebra with values in the adjoint module*, Forum Math. **26** (2014), no. 3, 913–929.
- **[31]** C. A. Weibel: *An Introduction to Homological Algebra*, Cambridge Studies in Advanced Mathematics,
  vol. **38**, Cambridge University Press, Cambridge, **1994**.

> **注意 [20]：Feldvoss–Siciliano 引的是 Kac–Raina 的 2013 第二版（Rozhkovskaya 合著，vol. 29）**，
> 而 `sources.bib` 里登记的 `kac-raina-1987` 是**第一版**。见 §30.2。

---

## 26. ★ 第二来源（L1 全文到手）：Schlichenmaier, Forum Math. **26** (2014) 913–929 = arXiv:1111.6625

### 26.0 文献标识与**版本陷阱（必读）**

| 项 | 值 | 等级 |
|---|---|---|
| 作者 | Martin Schlichenmaier（University of Luxembourg） | L1（末页地址栏） |
| 标题（期刊版） | *An elementary proof of the vanishing of the second cohomology of the Witt and Virasoro algebra with values in the **adjoint module*** | L1（Feldvoss–Siciliano [24] 与 Ecker–Schlichenmaier [31] 两份参考文献逐字一致） |
| 期刊 | Forum Math. **26** (2014), no. 3, 913–929；MR **3200354** | L1（两份参考文献一致；MR 号取自 Ecker–Schlichenmaier [31]） |
| **我实际读的版本** | **arXiv:1111.6625v4**，14 页，页眉「VANISHING OF THE SECOND COHOMOLOGY OF THE VIRASORO ALGEBRA」 | **L1** |
| 目录（v4） | 1 Introduction / 2 The algebras / 3 Cohomology and Deformations / 4 The degree decomposition of the cohomology / **5 Degree zero for the Witt algebra** / **6 Extension to the Virasoro algebra** | L1 |

> ⚠ **版本陷阱**：我读的 arXiv v4 的元数据显示的是 **2011–2012** 的时间戳（v1 2011-11-28，v4 附 2012 年的
> 「reference update after publication」），而期刊版是 **2014**。
> **因此「Remark 6.4」这个编号只对 arXiv v4 核实过；期刊印本的编号是否相同未核实（L0）。**
> 与 Gui 讲义（§8.0）、Kac–Raina（§30.2）同类的坑。**引用时 `loc` 必须写死「arXiv:1111.6625v4」。**

### 26.1 ★★ **Remark 6.4** 逐字（arXiv v4 书上 p.13，L1）——`H²(𝒱; 𝕂) = {0}` 在这里被明写

> **Remark 6.4.** What has been done in this section can also be interpreted in the framework of long exact
> cohomology sequences in Lie algebra cohomology. The exact sequence (2.5) of Lie algebras is also a exact
> sequence of Lie modules over `𝒱`. For such sequences we have a long exact sequence in cohomology. If we
> consider only level two we get
>
> &nbsp;&nbsp;&nbsp;&nbsp; `··· ⟶ H²(𝒱; 𝕂) ⟶ H²(𝒱; 𝒱) ⟶^{ν_*} H²(𝒱; 𝒲) ⟶ ···` &nbsp;&nbsp;&nbsp;&nbsp; (6.20)
>
> Proposition 6.1 also shows that naturally `H²(𝒱; 𝒲) ≅ H²(𝒲; 𝒲)` (which is not a consequence from the existence
> of the long exact sequence). **The calculations of Lemma 6.2 and Lemma 6.3 showed** `H²(𝒱; 𝕂) = {0}`.
> From Section 5 we know `H²(𝒲; 𝒲) = {0}`. Hence, also `H²(𝒱; 𝒱) = {0}`.

### 26.2 它是怎么被证出来的：**`H²(𝒱;𝕂) = 0` 在本文里是「副产品」，不是主定理**

本文的**主定理是 adjoint 模那条**（(6.1)：`H²(𝒱, 𝒱) = 0`）。`H²(𝒱; 𝕂) = 0` 出现在 §6 的中途：
`ν`-像被消掉之后，剩下的 2-上循环取值落在中心理想 `𝕂·t` 里，于是（书上 p.12，L1 逐字）

> We can reformulate this as that the component function `ψ_{x,y} : 𝒱 × 𝒱 → 𝕂` is a Lie algebra 2-cocycle for
> `𝒱` **with values in the trivial module**.

接着两条编号引理（书上 p.12，L1 逐字）：

> **Lemma 6.2.** *We have* `ψ(x, t) = 0, ∀x ∈ 𝒱`. &nbsp;&nbsp;&nbsp;&nbsp; (6.12)

> **Lemma 6.3.** *The cocycle* `ψ'` *is identically zero.*

（其间 (6.13)–(6.15) 给出使 `ψ'(e_i,e_0) = 0 ∀i`、`ψ'(e₁,e₋₁) = ψ'(e₂,e₋₂) = 0` 的显式上同调改变
`φ_i := −(1/i)ψ_{e_i,e_0}`、`φ₀ := −(1/2)ψ_{e₁,e₋₁}`、`c := (−2ψ_{e₂,e₋₂} − 8φ₀)`。）

**⚠ 因此本文的引用格式有一个真实的取舍**：
- **想引「`H²(Vir, 𝕂) = 0`」这句话本身** ⇒ 只能引 **Remark 6.4**（那是它被明写出来的唯一地方）；
- **想引它的证明** ⇒ 是 **Lemma 6.2 + Lemma 6.3**，但这两条的陈述里**不出现 `H²`**，
  它们是对一个由前文构造出来的特定 `ψ` 的计算。
- **绝不要写「Schlichenmaier Theorem: H²(Vir,ℂ)=0」——本文没有这样一条编号定理。**
  也别把本文标题当依据：标题说的是 **adjoint module**。

另有 **Proposition 6.1**（书上 p.10，L1 逐字）：

> **Proposition 6.1.** *Given a cocycle* `ψ ∈ C²(𝒱, 𝒱)` *there exists a cohomologous one* `ψ̃ ∈ C²(𝒱, 𝒱)`
> *such that the bilinear map* `ψ' = ν ∘ ψ̃ ∈ C²(𝒲, 𝒲)`.

以及 §6 开头（书上 p.10，L1 逐字）「Here we show in an elementary way that also for the Virasoro algebra
`H²(𝒱, 𝒱) = 0.` (6.1) Hence `𝒱` is also infinitesimally and formally rigid.」

---

## 27. ★ 第三来源（L1 全文到手）：Ecker & Schlichenmaier, arXiv:1707.06106v2 —— **完整的低维上同调总表，但无编号**

### 27.0 文献标识

| 项 | 值 | 等级 |
|---|---|---|
| 作者 | Jill Ecker、Martin Schlichenmaier（both University of Luxembourg） | L1 |
| 标题 | *The vanishing of the low-dimensional cohomology of the Witt and the Virasoro algebra* | L1（首页） |
| arXiv | **1707.06106v2**，26 页；页边戳「26 Mar 2018」；正文脚注「Date: v1: 19.07.2017; v2: 31.01.2018.」 | L1 |
| MSC | Primary 17B56；Secondary 17B68, 17B65, 17B66, 14D15, 81R10, 81T40 | L1 |
| 期刊发表 | **未核实（L0）** | L0 |

### 27.1 §5.1 的总表（书上 p.18–19，L1 逐字）——**`H²(𝒱, 𝕂) = {0}` 在这里，但是无编号的显示式**

> **5.1. Results for the cohomology of the Virasoro algebra.** From Section 3.3.1 we immediately deduce the
> following results for the zeroth cohomology group of the Virasoro algebra:
> `H⁰(𝒱, 𝕂) = 𝕂` and `H⁰(𝒱, 𝒱) = 𝕂 t`,
> where `t` is the central element. Concerning the first cohomology group, we obtain from Section 3.3.2 the
> following results:
> `H¹(𝒱, 𝕂) = {0}` and `H¹(𝒱, 𝒱) = {0}`.
> **The first equation is obtained from the fact that the Virasoro algebra is a perfect Lie algebra.** The second
> equation states that all the derivations for `𝒱` are inner. …
> **The results for the second cohomology were shown by Schlichenmaier [31]:**
> `H²(𝒱, 𝕂) = {0}` and `H²(𝒱, 𝒱) = {0}`.
> Thus, for the second cohomology we have `H²(𝒲, 𝒲) = H²(𝒱, 𝒱) = {0}`. **This does not hold true for the third
> cohomology group** `H³(𝒱, 𝒱)`. In fact, in the next subsection we will give a sketch of the proof of the
> following results:
> `dim(H³(𝒱, 𝕂)) = 1` and `dim(H³(𝒱, 𝒱)) = 1`.
> Hence, the third cohomology of the Virasoro algebra is not zero, but one-dimensional.

**这是本轮最有用的一张「地图」**：它把 `H⁰/H¹/H²/H³ × (平凡模, adjoint 模)` 八个格子一次列全，
并把 `H²(𝒱,𝕂) = {0}` 明确**归属**给 Schlichenmaier [31]（= §26 那篇）。
**但它是 summary 小节里的显示式，没有编号**，所以图里 `loc` 只能写「arXiv:1707.06106v2, §5.1, p.19」。

### 27.2 同文可引的**带编号**结果（L1 逐字，登记备用）

> **Theorem 5.2.1.** *The third cohomology groups of the Witt algebra* `𝒲` *and the Virasoro algebra* `𝒱` *over a
> field* `𝕂` *with* `char(𝕂) = 0` *and values in the trivial module are one-dimensional, i.e.*
> `dim(H³(𝒲, 𝕂)) = dim(H³(𝒱, 𝕂)) = 1`.

> **Theorem 5.2.2.** *The third cohomology group of the Virasoro algebra* `𝒱` *over a field* `𝕂` *with*
> `char(𝕂) = 0` *and values in the adjoint module is one-dimensional, i.e.* `dim(H³(𝒱, 𝒱)) = 1`.

> **Theorem 4.1.** *The third cohomology of the Witt algebra* `𝒲` *over a field* `𝕂` *with* `char(𝕂) = 0` *and
> values in the adjoint module vanishes, i.e.* `H³(𝒲, 𝒲) = {0}`.

> **Theorem A.1.1.** *The first cohomology of the Witt algebra* `𝒲` *over a field* `𝕂` *with* `char(𝕂) = 0` *and
> values in the adjoint module vanishes, i.e.* `H¹(𝒲, 𝒲) = {0}`.

另有 Proposition 4.1.1 / 4.2.1（`H³` 的非零次数部分消失 + 次数零部分）、Remark 5.2.1
（`H³(𝒲,𝕂)` 与 `H³(𝒱,𝕂)` 由 **Godbillon–Vey 3-上循环**的代数化生成）、Remark 5.2.2
（用 Hochschild–Serre 谱序列的替代证明）、Proposition A.1.1.1。

### 27.3 同文给出的**一般解释公式**（书上 p.5，§3.3.2，L1 逐字）——图里 (V) ⇔ 完美性那一步的来源

> `H¹(𝓛, 𝕂) = (𝓛 / [𝓛, 𝓛])^*` &nbsp;&nbsp; and &nbsp;&nbsp; `H¹(𝓛, 𝓛) = Der(𝓛)/ad_𝓛 = Out(𝓛)`

> **3.3.3. Second cohomology.** The second cohomology group `H²(𝓛, 𝕂)` with values in the trivial module
> **classifies central extensions of** `𝓛` **up to equivalence.**
> The second cohomology group `H²(𝓛, 𝓛)` with values in the adjoint module classifies infinitesimal deformations
> of `𝓛` modulo equivalent deformations. …

**即：`H¹(𝓛,𝕂) = 0 ⇔ 𝓛 完美`，和「`H²(𝓛,𝕂)` 分类中心扩张」这两条解释，
本文用无编号的显示式给出（p.5）。带编号的同类陈述在 Schottenloher 那边是 Remark 4.7（见 §29.1）。**

### 27.4 顺带核实的历史归属（L1，书上 p.1–p.3, p.6）

- 首句逐字：「The Witt algebra `𝒲` is an infinite-dimensional, ℤ-graded Lie algebra first introduced by
  **Cartan in 1909** [1]. The Witt algebra and its **universal central extension, the Virasoro algebra**, are two
  of the most important infinite-dimensional Lie algebras…」
- p.3 逐字：「As the second cohomology group of the Witt algebra with values in the trivial module is
  one-dimensional, i.e. `dim(H²(𝒲, 𝕂)) = 1`, there is, up to equivalence and rescaling, exactly one non-trivial
  central extension, which is the *Virasoro* algebra `𝒱`.」
- p.6 逐字：「The following result is a well-known fact: `dim(H²(𝒲, 𝕂)) = 1`, which states that there is up to
  equivalence and rescaling exactly one non-trivial central extension of the Witt algebra, namely the Virasoro
  algebra.」——**它对这条 well-known fact 也没给编号来源。**
- p.2 有一条对本项目很有价值的**方法论警告**（L1 逐字）：连续上同调
  `H^*(Vect(S¹), Vect(S¹)) = {0}`（Fialowski–Schlichenmaier [10]，基于 Goncharova [21]、Reshetnikov [27]、
  Tsujishita [33]）**不能**靠稠密性论证推出 Witt 代数的**代数**上同调消失：
  > As a first naive guess, one might be inclined to argue, by density arguments, that this result implies the
  > vanishing of the cohomology of the Witt algebra. However, this reasoning is not sound, as the argument using
  > density is only valid when considering the sub-complex formed by the continuous cohomology of the Lie algebra.

  **⇒ 图里如果哪天想用 `Vect(S¹)` 的 Gelfand–Fuks 结果去支持 Witt/Vir 的代数陈述，这一步必须标 `inferred: true`。**

---

## 28. 一般定理链：Weibel §7.9 与 Block 1968

### 28.1 编号核实状况

| 编号 | 内容（**内容只有 L3**，见下） | 编号本身 |
|---|---|---|
| **Weibel Theorem 7.9.2** | (a) 李代数 `L` 有万有中心扩张 **iff** `L` 完美；(b) 万有中心扩张的核 `Ĉ ≅ H₂(𝔤, 𝔽)` | **L4（含控制实验通过）+ L3 两条独立引用** |
| **Weibel Lemma 7.9.3** | 与 Block [4, Lemma 3.1] 合起来给出：中心扩张 `L̂ → L` 是万有的 **iff** `H¹(L̂,𝔽) = H²(L̂,𝔽) = 0` | **L4（含控制）+ L3 一条引用** |
| Weibel Corollary 7.9.5 | 有限维半单李代数是 centrally closed | L4（仅检索后端转述，未做控制） |

**编号的证据（L4，但做了控制实验）**：Google Books（volume id `flm-dBXfZ_gC`，Cambridge 版）
`books.google.com/books?id=flm-dBXfZ_gC&q=<短语>`：

| 查询短语 | 返回页 | 判读 |
|---|---|---|
| `"Theorem 7.9.2"` | **p.249** | ✔ 真实命中 |
| `"Lemma 7.9.3"` | **p.249** | ✔ 真实命中（与 7.9.2 同页，合理） |
| `"Universal Central Extensions"` | **p.198** | ✔ 命中的是**第 6 章**那个同名小节（**群**的万有中心扩张，§6.9），不是 §7.9 |
| `"perfect Lie algebra"` | p.445 | ✔ 大概是索引页（书约 450 页） |
| `"quixotic Virasoro wombat"`（**故意无意义的控制**） | **无返回页、无命中** | ✔ **控制通过** |

> **★ 对 §9.2 那条方法论结论的重要修正（建议并入 `reading-list.md`）**：
> §9.2 记的「Google Books `&q=` 无命中时回落到一个固定页（FBZ 卷为 p.403）」**不是全站行为，是按卷不同的**。
> 本轮对 Weibel 卷（`flm-dBXfZ_gC`）和 Fuks 卷（`RrnfBwAAQBAJ`）各跑了一次无意义控制查询，
> **两卷都返回「无命中」而不是回落页**。
> ⇒ **纪律：每次用 Google Books 定位法，都必须**同时**跑一个「应当无命中」的控制查询**，
> 不能沿用上一卷的回落页结论。

**内容的证据（L3）**：**Feldvoss–Siciliano p.5 与 p.10 逐字引用**（见 §25.2）。
另有第二条独立引用：arXiv:2407.14809（*Central extensions, derivations, and automorphisms of semi-direct sums
of the Witt algebra with its intermediate series modules*）也以 `[Wei94, Theorem 7.9.2]` 引「`𝔤` 有万有中心扩张
iff `𝔤` 完美」（**L4**，检索后端转述，未读原文）。

**⚠ 三条使用限制**：
1. **Weibel 正文我一页也没读到（L0）。** `bookstore` 型渠道不适用；
   检索里出现的 `sas.rochester.edu/.../weibel-homv2.pdf`、`djvu.online`、`anyflip` 等全本副本，
   按 `literature/CLAUDE.md` 规则 1 与本文件 §4.2/§9.0 的既定口径（拒 `nzdr.ru` 同理）**本轮不采信、未打开**。
   **这一条建议提交 lead 裁决**：Rochester 那份挂在大学域名下，与 `nzdr.ru` 是否同一档，我不代判。
2. **作者本人的勘误表本轮没能提供 §7.9 的信息（否定结论，L1）。**
   `sites.math.rutgers.edu/~weibel/Hbook-corrections.html` 只挂两个勘误 PDF 链接；
   我读了其中一份（`www.math.umd.edu/~jmr/602/bookerrors.pdf`，5 页，标题逐字
   「Corrections to "Intro. to Homological Algebra" by C. Weibel / Cambridge University Press,
   **paperback version, 1995**」）：第 7 章相关条目只有 **p.226（Exercise 7.3.5）** 与 **p.238**
   （把两句替换成关于 `𝔤 = 𝔣/𝔯` 自由李代数、`H²(𝔤,M) = 0` ⇒ `𝔤` 自由的陈述），
   **完全没有 §7.9 的条目**。⇒ 这次「找作者勘误表」的招（§14.1 的教训）**不奏效**。
   顺带 L1 得到的边界信息：Exercise 7.3.5 在 p.226、p.238 在 §7.7–7.8 附近，与 §7.9 落在 p.249 一致。
3. **那条双条件（`universal ⟺ H¹ = H² = 0`）在 Feldvoss–Siciliano 里是「[4, Lemma 3.1] 与 [31, Lemma 7.9.3] 合起来」推出的。**
   **不得把整条双条件单独归给 Weibel Lemma 7.9.3，也不得单独归给 Block。**
   要引就两条一起引，或者干脆引 Feldvoss–Siciliano p.5 那句话本身。

### 28.2 Block 1968

- **R. E. Block, *On the extensions of Lie algebras*, Canad. J. Math. 20 (1968), 1439–1450**（元数据 L1 抄自
  Feldvoss–Siciliano 参考文献 [4]；**未与出版方交叉核对**）。
- 被引用的编号是 **Lemma 3.1**（Feldvoss–Siciliano p.5、p.6、p.8 三处），**内容未核实（L0）**。
- 同文另引 **[4, Theorem 5.1]**（char p > 3 的每个 Zassenhaus 代数 `W(1,n)` 有唯一非分裂中心扩张）——char p，与本节无关。

---

## 29. ★ Schottenloher 第 4、5 章：**已 L1 核实，且是干净的否定结论**

> **这一节把 `sources.bib` 里 `schottenloher-2008` 的「其余章节编号仍未核实」限制，对第 4、5 章一并解除。**
> 获取途径与 §11.0 同一套：作者本人 LMU 主页按章挂 PDF
> `https://www.mathematik.uni-muenchen.de/~schotten/LNP-cft-pdf/0{4,5}_978-3-540-68625-5_Ch0{4,5}_23-08-08.pdf`
> （WebFetch 落盘 → `Read` 带 `pages` 读图）。**PDF 页码 = 书上页码 − 62（Ch.4）/ − 74（Ch.5）。**

### 29.1 第 4 章「Central Extensions of Lie Algebras and Bargmann's Theorem」（LNP 759, pp. **63–73**，L1）

页脚逐字：「Schottenloher, M.: *Central Extensions of Lie Algebras and Bargmann's Theorem*.
Lect. Notes Phys. **759**, **63–73** (2008) DOI **10.1007/978-3-540-68628-6_5**」
（**又一次的章号/DOI 后缀错位：书里是第 4 章，DOI 后缀 `_5`**，与 §11.0 记的第 10 章/`_11` 同型。）

| 编号 | 书页 | 内容 |
|---|---|---|
| **Definition 4.1** | p.63 | 李代数中心扩张：正合列 `0 → 𝔞 → 𝔥 →^π 𝔤 → 0` 且 `[𝔞, 𝔥] = 0` |
| （例） | p.64–67 | 由李群中心扩张微分得到；**Heisenberg 代数** `H := ℂ[T,T⁻¹] ⊕ ℂZ`（(4.1)）；仿射 Kac–Moody / 当前代数（(4.2)）；末尾一句逐字「In a similar way the **Virasoro algebra can be defined as a central extension of the Witt algebra** (cf. Chap. 5).」 |
| **Definition 4.2** | p.67 | 扩张**分裂** / **平凡**扩张的定义（存在 `β : 𝔤 → 𝔥` 使 `π ∘ β = id_𝔤`） |
| **Remark 4.3** | p.67 | 任一中心扩张都有线性 `β`，令 `Θ(X,Y) := [β(X),β(Y)] − β([X,Y])`；**`β` 是分裂映射 iff `Θ = 0`** |
| **Definition 4.4** | p.68 | **2-上循环**（满足 Remark 4.3 的 1°、2°） |
| **Lemma 4.5** | p.68 | 三条：1 每个中心扩张来自一个上循环；2 每个上循环生成一个中心扩张；3 **该中心扩张分裂（从而平凡）iff 存在 `μ ∈ Hom(𝔤,𝔞)` 使 `Θ(X,Y) = μ([X,Y])`** |
| **Definition 4.6** | p.69 | `Alt²(𝔤,𝔞)`、`Z²`、`B²`、**`H²(𝔤,𝔞) := Z²/B²`** |
| **Remark 4.7** | p.69 | **「The cohomology group `H²(𝔤,𝔞)` is in one-to-one correspondence with the set of equivalence classes of central extensions of `𝔤` by `𝔞`.」** |
| **Theorem 4.8** | p.69 | Bargmann：`G` 连通单连通有限维、`H²(Lie G, ℝ) = 0` ⇒ 投影表示可提升 |
| Lemma 4.9 | p.70（前向引用） | 局部连续截面 |

**★ 对图最有用的一条是 Remark 4.7**：它是「`H²(Vir,ℂ) = 0` ⟺ Vir 的每个中心扩张都平凡」这一**翻译步骤**的
带编号来源。图里若要把 statement 写成「Vir 没有非平凡中心扩张」，就该挂这一条，**而不是**让它悬空。
（`Theorem 4.8` 的形式「`H²(Lie G, ℝ) = 0` ⇒ …」也顺带说明：`H² = 0` 这种假设在这本书里是常规写法。）

### 29.2 第 5 章「The Virasoro Algebra」（LNP 759, pp. **75–85**，L1）—— **没有 H²(Vir) = 0**

页脚逐字：「Schottenloher, M.: *The Virasoro Algebra*. Lect. Notes Phys. **759**, **75–85** (2008)
DOI **10.1007/978-3-540-68628-6_6」（章号 5 / DOI 后缀 `_6`）。

章首导言逐字（书上 p.75）：

> In this chapter we describe how the Witt algebra and the Virasoro algebra as its **essentially unique nontrivial
> central extension** appear in the investigation of conformal symmetries. **This result has been proven by
> Gelfand and Fuks in [GF68].**

| 编号 | 书页 | 内容 |
|---|---|---|
| §5.1 | p.75–77 | `Vect(𝕊)`、`Lie(Diff₊(𝕊)) := Vect(𝕊)`、`L_n := z^{1−n} d/dz`、`W := ℂ{L_n : n ∈ ℤ}`，`[L_n,L_m]f = (n−m)L_{n+m}f` |
| §5.2 | p.77–79 | 欧氏平面版；`t : W → W`, `t(L_n) := −L_{−n}` 是对合同构 |
| **Theorem 5.1** | **p.79** | **「[GF68] `H²(W, ℂ) ≅ ℂ`.」**（就这一行；后接三步证明 1. `ω ∈ Z²`；2. `ω ∉ B²`；3. `Θ ∈ Z² ⇒ ∃λ : Θ ∼ λω`，证毕于 p.82） |
| Remark（Thm 5.1 内） | p.79 | 逐字：「The choice of the factor `1/12` in the definition of `ω` is in accordance with the zeta function regularization using the Riemann zeta function, cf. [GSW87, p. 96].」 |
| (5.2) | p.81 | `h(n) = (λ/12)n(n²−1)` |
| **Definition 5.2** | **p.82** | **Virasoro 代数**：`Vir = W ⊕ ℂZ`，`[L_n,L_m] = (n−m)L_{n+m} + δ_{n+m}(n/12)(n²−1)Z`，`[L_n,Z] = 0` |
| §5.4 | p.82–84 | 「Does There Exist a Complex Virasoro Group?」 |
| **Theorem 5.3** | p.83 | 「`Diff₊(𝕊)` has no complexification. In particular, there even does not exist a real Lie group `ℋ` with `Lie ℋ = Ŵ = Vect(𝕊)^ℂ`.」（引 [Lem97*]） |
| **Theorem 5.4** | p.84 | 「**There does not exist a complex Lie group `𝒢` with `Lie 𝒢 = V̂ir`.**」（引 [Nit06*]） |

**⇒ 明确的否定结论：Schottenloher 第 4、5 两章通读，没有任何一处陈述 `H²(Vir, ℂ) = 0`，
也没有「Vir 是万有中心扩张」这个措辞**（章首只说 "essentially unique nontrivial central extension"，
那是 (W) 而不是 (V)）。**不要拿 Schottenloher 当本节这条节点的来源。**

### 29.3 副产品：`worldsheet.virasoro-unique-central-extension` 的 loc 现在可以写死

该节点现有 `sources` 里 `schottenloher-2008` 的 loc 是「相关章节，编号未核实」。**现在可以改成**：

```yaml
- ref: schottenloher-2008
  loc: "Ch. 5 (The Virasoro Algebra), Theorem 5.1 (H^2(W, C) ≅ C), p. 79；
        Virasoro 代数的定义见 Definition 5.2, p. 82；
        『中心扩张等价类 ↔ H^2』见 Ch. 4, Remark 4.7, p. 69"
```

**另外一条对该节点的实质补充**：Schottenloher 把 Theorem 5.1 归给 **[GF68] = Gelfand–Fuks (1968)**，
而节点现在的三个来源（`virasoro-lean-2025` / `schottenloher-2008` / `kac-raina-1987`）里**没有原始出处**。
建议加 `gelfand-fuks-1968`（见 §30.4 的元数据分歧）。

---

## 30. 任务书点名的四个候选：逐条结算（三个 L0、一个否定）

### 30.1 Fuks, *Cohomology of Infinite-Dimensional Lie Algebras* (1986) —— **L0，且任务书猜的 §2.3 是别的定理**

- 元数据（**L2**，两份独立参考文献一致）：
  - Ecker–Schlichenmaier [14] 逐字：「D. B. Fuks, *Cohomology of infinite-dimensional Lie algebras*,
    Contemporary Soviet Mathematics, **Consultants Bureau, New York, 1986**, Translated from the Russian by
    A. B. Sosinskiĭ. **MR 874337**.」
  - Schlichenmaier (1111.6625) [8] 逐字：「Fuks, D.: *Cohomology of Infinite-dimensional Lie Algebras*.
    Consultants Bureau, N.Y., London, 1986.」
- **正文一页也没读到（L0）。** Google Books volume id `RrnfBwAAQBAJ`（Springer Science & Business Media 重印）：
  - `"central extension"` → **p.304**；
  - 无意义控制查询 `"quixotic wombat telescope"` → **无命中**（✔ 控制通过，故 p.304 是真实命中）。
  - 书约 338 页（导航出现 `PA338`）。**p.304 落在书的最后部分，不在 §1.4 也不在 §2.3。**
- **任务书猜的「§2.3」几乎肯定不是我们要的东西**：检索后端（L4）指出 Fuks 在 **p.119** 把
  **Theorem 2.3.1** 称为 Goncharova 定理（**直线上形式向量场**李代数的上同调），
  并评价它「still remains one of the most difficult theorems in the cohomology theory of
  infinite-dimensional Lie algebras」。那是 `L_1 = W_1^{formal}` 的上同调，**不是 `H²(Vir, ℂ)`**。
- Ecker–Schlichenmaier 引 Fuks [14] 的地方（书上 p.5）是**另一条**结论：
  「in the case of internally ℤ-graded Lie algebras, nonzero cohomology groups can exist only for degree zero,
  see Fuks [14]」——**且他们也没给编号**（只写 [14]）。
- **结论：不入 `sources.bib`**（照 §4.1/§4.2 的既定口径）。若以后拿到原书，值得核的是
  「内部 ℤ-分次李代数的上同调只在零次数非零」这条（那是 §27 里 (3a)/(3b) 的出处），
  **不是** `H²(Vir)` 本身。

### 30.2 Kac–Raina *Bombay Lectures* —— **L0，且两篇独立文献引的都是 2013 第二版、且只覆盖 Witt 侧**

- `sources.bib` 里 `kac-raina-1987` 的版本陷阱（12 讲 vs 18 讲）本轮**再次被证实是真陷阱**：
  **Feldvoss–Siciliano [20] 与 Ecker–Schlichenmaier [24] 引的都是第二版**
  （Kac, Raina & **Rozhkovskaya**, Adv. Ser. Math. Phys. vol. **29**, World Scientific, **2013**；MR **3185361**）。
- Feldvoss–Siciliano 引它的位置是 **[20, Section 1.3]**，被引的陈述逐字是
  「the infinite-dimensional two-sided Witt algebra `𝒲` … **has a unique non-split central extension
  (up to equivalence), the Virasoro algebra `𝒱`**」——**这是 (W)，不是 (V)。**
- **结论：Kac–Raina（任何版本）本轮没有提供 `H²(Vir, ℂ) = 0` 的任何证据。**
  已有的 `kac-raina-1987` 条目不需要改；但**图里若要引「Witt 有唯一非分裂中心扩张」，
  可考虑改引第二版并写 `Section 1.3`**（那是 L3：Feldvoss–Siciliano 的转引）。
  → 需要新 bib key `kac-raina-rozhkovskaya-2013`；**本轮我没有登记它**（因为我没读到那一版的正文，
  且现有节点用的是一版；是否新增留给 curator 决定）。

### 30.3 Iohara & Koga, *Representation Theory of the Virasoro Algebra* (2011) —— **L0，Springer 认证墙**

- 元数据（**L2/L4**）：Springer Monographs in Mathematics，DOI **10.1007/978-0-85729-160-8**，
  精装 ISBN 978-0-85729-159-2（2010-11-25），平装 978-1-4471-2609-6（2013-01），**XVIII + 474 页**。
- **访问失败**：`link.springer.com/book/10.1007/978-0-85729-160-8` 与
  `link.springer.com/chapter/10.1007/978-0-85729-160-8_1` 都 **303 重定向到 `idp.springer.com/authorize`**（认证墙）。
  Google Books 无该书的可检索预览卷。
- 检索后端（**L4**）转述其第 1 章内容：「the Virasoro algebra Vir is introduced as the universal central extension
  of the Witt algebra, a ℤ-graded Lie algebra treated within the framework of *Q-graded Lie algebras*」。
  文献里对该书的引用惯例是 **[IK11] + 小节号**（例见 `[IK11, Section 5.3.1]`），
  **本轮没有找到任何一处以「[IK11, Proposition 1.x]」形式引用它的第 1 章。**
- **结论：编号未核实（L0），不入 `sources.bib`。**
  而且即便拿到，按上面的转述，IK 很可能是**把 Vir 定义成**万有中心扩张（那样它就不含 (V) 的证明，
  而是把 (V) 变成定义的一部分）——**这对图反而是坏事**：会把一条需要证明的命题藏进定义。
  真要用 IK，必须先确认它是**证明**了 `H²(Vir) = 0` 还是**定义**了万有性。

### 30.4 Kytölä arXiv:2510.21741 —— **确定的否定：没有 Vir perfect，也没有 H²(Vir) = 0**

两条独立证据：
1. **论文侧（L1，来自 2026-09-10 那轮的全文阅读记录，见 `sources.bib` 的 `virasoro-lean-2025`）**：
   其 **Table 1「Main objects and results formalized and discussed in this report」**列出的**全部**条目是
   Def 3.1（中心扩张）、Def 4.3（李代数二阶上同调）、Def 8.1（Virasoro 代数）、Sec 9（Heisenberg）、
   Def 12.2（Verma 模）、**Thm 6.2（Witt 代数二阶上同调一维）**、Thm 10.1（Sugawara）、Thm 12.7。
   **`Thm 6.2` 是 `H²(Witt)`，不是 `H²(Vir)`；表里没有任何 perfect / universal central extension 条目。**
2. **仓库侧（L4，2026-09-11 读 GitHub 目录树）**：`github.com/kkytola/VirasoroProject/tree/master/VirasoroProject`
   的 Lean 文件清单为
   `CentralChargeCalc / CentralExtension / Commutator / CyclicTripleSum / FockSpace / FockSpaceSugawara /
   HeisenbergAlgebra / IndexTri / IsCentralExtension / LieAlgebraModuleUEA / LieAlgebraRepresentationOfBasis /
   LieCohomologySmallDegree / LieVerma / SectionSES / Sugawara / VermaModule / VirasoroAlgebra /
   VirasoroCocycle / VirasoroVerma / WittAlgebra / **WittAlgebraCohomology**`（+ `ToMathlib/`）。
   **有 `WittAlgebraCohomology.lean`，没有任何 Virasoro 上同调/完美性/万有性的文件。**
   （这是文件名级别的证据，L4；我没有读文件内容。）

**⇒ 形式化侧现状：`H²(Vir, ℂ) = 0` 目前没有任何 Lean 形式化。图里这条节点最高只能到 `rigorous`。**
（顺带：`H²(Witt)` 一维**已**被 Kytölä 形式化，所以 `virasoro-unique-central-extension` 与本节点
在形式化程度上是**不对称**的——(W) 已机器验证，(V) 完全没有。这个不对称值得在图里体现。）

---

## 31. 图里建议怎么加（供 curator 取舍；researcher 不改 `graph/`）

### 31.1 新陈述节点

```yaml
id: math.virasoro-universal-central-extension
kind: proposition
title: Virasoro 代数是 Witt 代数的万有中心扩张（H²(Vir, k) = 0）
statement: |
  设 k 是特征零的域。取 Virasoro 代数 Vir(k)（worldsheet.virasoro-algebra-v2）与
  Witt 代数 W(k)（math.witt-algebra，双边版本：基 {ℓ_n : n ∈ ℤ}）。则

  (1) Vir(k) 是**完美**李代数：[Vir(k), Vir(k)] = Vir(k)。特别地中心元 C 落在导出代数里。

  (2) 以平凡模 k 为系数的李代数上同调满足

        H^1(Vir(k), k) = 0   且   H^2(Vir(k), k) = 0 。

  (3) 等价地（经「H^2 分类中心扩张等价类」这一对应）：Vir(k) 的**每个**以 k 为系数的中心扩张
      都是平凡（分裂）的；且典范满射 Vir(k) → W(k) 是 W(k) 的**万有中心扩张**
      （即对 W(k) 的任一中心扩张 E → W(k)，存在唯一的李代数同态 Vir(k) → E 与之相容）。

  【本节点不断言】
  (a) H^2(W(k), k) 的维数——那是 worldsheet.virasoro-unique-central-extension，是**另一个**上同调群；
  (b) 任何非平凡系数模的上同调。特别地**以 adjoint 模为系数**的 H^2(Vir, Vir) = 0 是一条不同的定理；
  (c) 更高阶的消失。**恰恰相反**：dim H^3(Vir, k) = 1 且 dim H^3(Vir, Vir) = 1
      （Ecker–Schlichenmaier, arXiv:1707.06106v2, Theorem 5.2.1 / 5.2.2），
      所以不得把本节点读成「Vir 的上同调都平凡」；
  (d) 特征非零的类比。char p > 3 的**受限** Virasoro 代数有形式相同但对象不同的结论
      （Feldvoss–Siciliano Lemma 2.4），与本节点无关；
  (e) 任何形式化：本项目 formal/ 与 Kytölä 的 VirasoroProject 中**都没有**这条结论
      （后者只形式化了 H^2(Witt) 一维）。
uses_conventions: []          # 见 22.3：结论与括号符号约定无关
sources:
  - ref: feldvoss-siciliano-2025
    loc: "Lemma 2.6, p. 7（含完整证明；特征零；同页给出 𝒱 的定义式与脚注 3 关于 two-sided 的说明）；
          万有性的一般判据见 p. 5 正文（引 Weibel Thm 7.9.2 与 Lemma 7.9.3 + Block Lemma 3.1）"
  - ref: schlichenmaier-2014
    loc: "arXiv:1111.6625v4, Remark 6.4, p. 13（『The calculations of Lemma 6.2 and Lemma 6.3
          showed H²(𝒱; 𝕂) = {0}』）；计算本体是 Lemma 6.2, Lemma 6.3, p. 12。
          **编号只对 arXiv v4 核实，期刊版（Forum Math. 26 (2014) 913–929）编号未核实**"
  - ref: ecker-schlichenmaier-2018
    loc: "arXiv:1707.06106v2, §5.1, p. 19（低维上同调总表，H²(𝒱,𝕂) = {0}，**无编号**，
          正文把该结果归给 Schlichenmaier）；H³ 不为零见 Theorem 5.2.1 / 5.2.2, pp. 19–20"
  - ref: schottenloher-2008
    loc: "Ch. 4, Remark 4.7, p. 69（H²(𝔤,𝔞) ↔ 中心扩张等价类，即 (2) ⟺ (3) 的翻译步骤）；
          Definition 4.2, p. 67（分裂/平凡扩张）；Lemma 4.5(3), p. 68"
tags: [algebra, lie-algebra, cohomology, central-extension]
```

配套的推导节点（`kind: proof`，`status: rigorous`），`depends_on` 至少含
`worldsheet.virasoro-algebra-v2`、`math.witt-algebra`，
并把「一般判据（完美 + H¹ = H² = 0 ⟺ 万有）」那一环标出来。

### 31.2 把它接到 `brst-nilpotent-at-c26--via-fgz`

`worldsheet.brst-nilpotent-at-c26--via-fgz` 的 `depends_on` 加一条
`- id: math.virasoro-universal-central-extension`，并把现有 `gaps` 里
「**本图中没有 H²(Vir, C) = 0 的节点**，本推导对这一步无任何来源支撑」这句改掉。

**但 gaps 不能整条删**，还剩两个未闭合的点（**这是本轮的诚实结论**）：
1. **FGZ 的 `g` 在 §2 里是否就是 `Vir`（含中心）、其 `H²(g)` 是否就是平凡系数的李代数 `H²`**——
   我没有重读 FGZ 原文，只依据 `brst-cohomology-sources.md` §1.2 的 L1 摘录做了合理性判断（见 §24 末）。
   这一步**必须标 `inferred: true`**，note 写「FGZ 不引任何数学文献来支撑 H²(g) = 0；
   两边没有互引；`g` 的确切身份未在本项目内核实」。
2. **`γ = 0` 那一半仍无来源。** FGZ 的假设是**两条**：`H²(g) = 0` **且**「ω₀ 与 β 取得使 `γ = 0`」。
   本节只解决了第一条。第二条按 FGZ Prop 1.1(ii) 是「γ 代表 H²(g) 的平凡类时可取 γ ≡ 0」，
   所以形式上第一条**应当**蕴含第二条——但这是我的推断，不是文献明说，
   **也要标 `inferred: true`**。

### 31.3 三条给 curator 的硬性提示

1. **`uses_conventions` 建议留空或只挂 note。** 四份来源的 Virasoro 括号写法各不相同（§25.3 的表），
   但 `H²(Vir, k) = 0` 对同构不变，**结论与约定无关**。
   如果非要挂 `conv.virasoro-standard`，请在 note 里写明「来源用的是别的符号约定，结论不受影响」，
   **不要**把任何一份来源的括号式抄进 statement。
2. **不要与 `worldsheet.virasoro-unique-central-extension` 合并，也不要让其中一个依赖另一个「就因为都叫中心扩张」。**
   两者是不同李代数的不同上同调群（§24）。真正的依赖方向是：
   「Vir 是 W 的万有中心扩张」这个**推论**同时用到两者，而 `H²(Vir,k) = 0` 本身不依赖 `dim H²(W,k) = 1`
   ——不过**已核实的那个证明确实用到了它**（Feldvoss–Siciliano Lemma 2.6 的证明引
   `H¹(𝒲,𝔽) = 0` 与 `dim H²(𝒲,𝔽) = 1`）。所以**推导节点里挂这条依赖是对的，陈述节点里不要写成前提**。
3. **area 用 `math`（已有 `math.witt-algebra`），不要放 `worldsheet`。** 这条与弦论无关。
   建议与 `laplacian-log-contact-term`、`math.formal-distribution-locality` 等归到同一个
   「物理书不给数学来源」的 family（见 §13.2 补充建议 3）。

### 31.4 三条禁令

1. **不得引 `feldvoss-siciliano-2025, Lemma 2.4`** —— 那是 char p > 3 的**受限** Virasoro 代数（§25.3-1）。
   要引 **Lemma 2.6**。
2. **不得写「Schlichenmaier, Theorem: H²(Vir, ℂ) = 0」** —— 那篇没有这样一条编号定理；
   `H²(𝒱;𝕂) = {0}` 只在 **Remark 6.4** 里被明写，且那篇的标题/主定理是 **adjoint 模**（§26.2）。
3. **不得引 Schottenloher、Kac–Raina、Iohara–Koga、Kytölä 支撑这条节点** ——
   前者通读无此陈述（§29.2），后三者本轮 L0 / 否定（§30）。

---

## 32. 访问日志与未解决问题（本节）

### 32.1 访问日志

| 目标 | URL / 手法 | 结果 |
|---|---|---|
| **Feldvoss–Siciliano 全文（13 页）** | `arxiv.org/pdf/2501.15560` | **成功**（落盘 225 KB → `Read pages` 读图，逐页读完 1–13） |
| **Schlichenmaier 全文（14 页）** | `arxiv.org/pdf/1111.6625v4` | **成功**（落盘 181 KB；读 pp.10–14 = §6 + 参考文献） |
| **Ecker–Schlichenmaier 全文（26 页）** | `arxiv.org/pdf/1707.06106v2` | **成功**（落盘 287 KB；读 pp.1–8, 17–21, 24–26） |
| **Schottenloher Ch.4** | `www.mathematik.uni-muenchen.de/~schotten/LNP-cft-pdf/04_978-3-540-68625-5_Ch04_23-08-08.pdf` | **成功**（落盘 331 KB；PDF 页 = 书页 − 62） |
| **Schottenloher Ch.5** | `…/05_978-3-540-68625-5_Ch05_23-08-08.pdf` | **成功**（落盘 258 KB；PDF 页 = 书页 − 74；**全章 11 页读完**） |
| Schottenloher 章节目录 | `www.mathematik.uni-muenchen.de/~schotten/LNP-cft-pdf/` | **成功**（全 11 章 + Prelims/Intro/Appendix/Index/References，**按章直链，文件名规律 `NN_978-3-540-68625-5_ChNN_23-08-08.pdf`**） |
| **Weibel 勘误（paperback 1995）** | `www.math.umd.edu/~jmr/602/bookerrors.pdf` | **成功**（落盘 73 KB，5 页读完）；**但无 §7.9 条目** |
| Weibel 作者勘误页 | `sites.math.rutgers.edu/~weibel/Hbook-corrections.html` | 成功但只列两个 PDF 链接，页面本身无内容 |
| Weibel 正文 | Google Books `books.google.com/books?id=flm-dBXfZ_gC&q=…` | 只回页码；**Thm 7.9.2 与 Lemma 7.9.3 均 p.249**；**无意义控制查询无命中 ⇒ 控制通过** |
| Fuks 正文 | Google Books `books.google.com/books?id=RrnfBwAAQBAJ&q=…` | 只回页码；`"central extension"` → p.304；**控制通过** |
| Rosellen, *A Course in Vertex Algebra* | `arxiv.org/html/math/0607270` | 成功（HTML 版存在）；**但相关的 Proposition / Lemma 全部无编号**（§1.5），**不可用** |
| **Iohara–Koga** | `link.springer.com/book/10.1007/978-0-85729-160-8`、`…/chapter/…_1` | **失败：303 重定向到 `idp.springer.com/authorize`（认证墙）** |
| Kytölä Lean 仓库目录 | `github.com/kkytola/VirasoroProject/tree/master/VirasoroProject` | **成功**（文件名清单；无 Virasoro 上同调文件） |
| 学位论文《Comparing Different Mathematical Definitions of 2D CFT》 | `arxiv.org/pdf/1607.05078` | 落盘 1 MB（**图片型 PDF**）；只读到 Ch.1，**§2.1/2.2 未读**（本轮判定它只是二手替身，优先级低） |
| Neher, *Lectures on extended affine Lie algebras* | `arxiv.org/pdf/1003.2352` | 落盘 716 KB，**本轮未读**（留给下一轮做 Weibel 7.9.x 的第二条 L1 旁证） |

> **对 `reading-list.md` 的建议增补**：
> - **`arxiv.org/pdf/` 本轮再次全部成功**（4 篇，含 `math/`-era 与 2025 新论文）。落盘 + `Read pages` 已是稳定路线。
> - **新增活路**：`www.mathematik.uni-muenchen.de/~schotten/LNP-cft-pdf/`**全书按章都在**（不止第 10 章）；
>   `www.math.umd.edu/~jmr/602/`（Weibel 勘误镜像）；`sites.math.rutgers.edu/~weibel/`。
> - **新增死路**：`link.springer.com`（书/章页一律 303 → `idp.springer.com/authorize`，认证墙；
>   **重定向 URL 不要跟，跟了也是登录页**）。
> - **★ 修正 §9.2 的结论**：Google Books 的「无命中回落到固定页」是**按卷**的行为，不是全站行为。
>   **每次都必须跑一个故意无意义的控制查询**（本轮两卷都返回真正的「无命中」）。
> - **教训（与 §14.1 的那条并列）**：「找作者勘误表」这一招**对 Weibel 不奏效**（勘误里没有 §7.9）。
>   对付买不到的教材，**先试 Google Books 编号定位 + 控制查询**，再试「引用它的近期论文逐字引用编号」——
>   本轮 Weibel 的编号最终是靠 **Feldvoss–Siciliano 的逐字引用**（L3）+ Google Books 页码（L4 带控制）
>   两条腿站住的。

### 32.2 未解决 / 留给下一轮

- **Q14** **Weibel Theorem 7.9.2 / Lemma 7.9.3 的正文措辞（L0）**，以及 `Corollary 7.9.5`（L4）。
  需要持原书者抄三句即可结案。**顺带需要 lead 裁决**：挂在 `sas.rochester.edu` 大学域名下的
  Weibel 全本 PDF 是否属于本项目规则 1 排除的「非官方全本扫描」（§28.1 限制 1）。
- **Q15** **Block, *On the extensions of Lie algebras*, Canad. J. Math. 20 (1968), Lemma 3.1 的内容（L0）。**
  CJM 老卷在 Cambridge Core 上，可能有开放存取。
- **Q16** **Feldvoss–Siciliano arXiv:2501.15560 是否已被期刊接受（L0）。**
  若已发表，编号可能变；`loc` 现在写死的是 v1。
- **Q17** **Schlichenmaier 的期刊版（Forum Math. 26 (2014) 913–929）编号是否与 arXiv v4 一致（L0）。**
  这是本节唯一一条「已发表的第二来源」，值得把编号钉死。
- **Q18** Ecker–Schlichenmaier arXiv:1707.06106 是否已发表（L0）。
- **Q19** Iohara–Koga 第 1 章：它是**证明**了 `H²(Vir) = 0`，还是把万有性当**定义**？（§30.3）
  这个区别对图很重要。需要能进 Springer 的人看一眼。
- **Q20** Fuks (1986) 里「内部 ℤ-分次李代数的上同调只在零次数非零」这条的**编号**（§30.1）。
  它是 Ecker–Schlichenmaier (3a)/(3b) 的出处，将来若给 `math.witt-algebra` 那一支建节点会用到。
- **Q21** Neher, *An introduction to universal central extensions of Lie superalgebras*
  （Math. Appl. 555, Kluwer 2003, pp. 141–166）与 Garland, IHES Publ. Math. 52 (1980), **Definition 1.4/1.6**
  ——Feldvoss–Siciliano 用它们定义「covering algebra / universal covering algebra」。
  若图里要立「万有中心扩张」的一般定义节点，这两条是候选来源；**本轮未查**。
- **Q22** `Vect(S¹)` 的连续上同调（Gelfand–Fuks / Goncharova / Reshetnikov / Tsujishita）与
  Witt/Vir 的**代数**上同调之间那条「稠密性论证不成立」的沟（§27.4）。
  这与 §13.3 的「弦论那个具体理论满足假设」是同一类缺口，值得单独立节点。

---

# § PBW 定理的「任意李代数 / 任意基环」来源（撤 inferred 用）

- 负责 agent：researcher
- 日期：**2026-09-11（第四轮）**
- 触发：`math.verma-module-free-over-negative-part--via-pbw-theorem` 到 `math.pbw-theorem` 的边标着
  `inferred: true`，其 note 逐字说理由是**适用范围**：「humphreys-1972 全书语境是『代数闭特征零域上的
  **有限维半单**李代数』，而 §17.1 开头对 L 的假设本项目未核到（L0）」（= §15.5 的 **Q15**）。
  本节的任务：找一条**明确对任意（含无限维）李代数、任意交换环或域**陈述 PBW 的**带编号**来源。
- 证据等级沿用本文件 §0 的 L0–L4 表。
- **一句话结论**：找到了一条，**Lakos, arXiv:1812.04896v2, Proposition 6.1（书上 p.16）**——
  「The PBW theorem holds if `𝔤` is a free `K`-module.」，前提逐字只有「`K` 是幺交换环、`𝔤` 是 Lie `K`-代数」，
  **全文无任何有限维假设**，且同一篇里有第二条独立证明（Appendix A, **Corollary A.4(f)**）。
  另外把 **Bourbaki 的位置钉到了 Ch. I, §2, no. 7, p. 18（L1，来自出版社目录扫描）**，但**正文与「Theorem 1」
  这个编号仍然完全未核实**。任务书候选 2（Dixmier **2.1.11**）本轮拿到了**相反**的 L3 证据（指向 **2.1.8**）。

---

## 33. 结论表（先看这张）

| # | 候选 | 本轮结果 | 等级 | 能否用来撤 inferred |
|---|---|---|---|---|
| 1 | **Bourbaki**, *Lie Groups and Lie Algebras, Chapters 1–3*, Ch. I, §2, no. 7 | **小节标题与页码已 L1 落定**：「**7. The Poincaré-Birkhoff-Witt Theorem … 18**」（出版社目录扫描逐字）。**正文未取**；**「Theorem 1」这个编号本轮零证据**；「`𝔤` 为自由 `K`-模」这条前提**未见任何已核实来源写出** | 位置 **L1** / 内容 **L0** | **否**（只有位置，没有内容） |
| 2 | **Dixmier**, *Enveloping Algebras*, Thm **2.1.11** | **未证实，且有相反证据**：Crytser 讲义（L1 读毕）把「有序单项式基」挂在 **[Dixmier, Lem 2.1.8]** 上，把 `U(𝔤)` 的 `U(𝔤')`-模基挂在 **[Prop. 2.2.7]** 上。**2.1.11 是什么，本轮仍不知道** | **L0**（且 2.1.8 为 L3） | **否**，且**禁止写 2.1.11** |
| 3 | **Serre**, *Lie Algebras and Semisimple Lie Algebras* | 无公开全文，编号零证据 | **L0** | 否 |
| 4 | **Jacobson**, *Lie Algebras*, Ch. V Thm 3 | 无公开全文。两处 L1 书目（Garrett 讲稿、Lakos [19]）都只给「Jacobson, Nathan: *Lie Algebras*. Wiley, New York, 1962」，**不带编号**。旁证：Garrett 逐字说他的证明「is basically that given in Jacobson」并适用于无限维 | **L0** | 否 |
| 5 | **Kac**, *IDLA* 3rd ed. §9.1 / **Moody–Pianzola** | 未查到公开全文（沿用 §17 的结论；Kac 的结构性反对仍在：该书讲 Kac–Moody `g(A)`，Virasoro 不是 Kac–Moody） | **L0** | 否 |
| 6 | **形式化（Lean / Coq / Isabelle）** | **三边都没有 PBW**。Mathlib 官方 `docs/1000.yaml` 里 `Poincaré–Birkhoff–Witt theorem` 条目**存在但没有 `decl`**（= 官方登记为未形式化）；Isabelle AFP 只有一条微分几何路线的 *Lie Groups and Algebras*；Coq 侧本轮未找到 | **L1**（Lean）/ **L2**（AFP）/ **L0 否定**（Coq） | 不适用（只影响 `status` 上限） |
| **★** | **Lakos**, arXiv:**1812.04896v2**, **Proposition 6.1**（p.16）＋ **Corollary A.4(f)**（p.20） | **全文到手、逐字核实**。前提：`K` 幺交换环、`𝔤` 为自由 `K`-模；**无维数限制**；索引集任意 | **L1** | **可以**（见 §33.7 的写法与限制） |

> **一条方法论提醒（与 §19.1、§32.1 并列的第三条路线）**：本轮 Bourbaki 的位置不是靠 Google Books、
> 不是靠出版社书页（Springer 仍是登录墙），而是靠 **德国国家图书馆（DNB）挂的「出版社目录扫描件」
> `d-nb.info/<IDN>/04`**。这是拿不到书时定位章节号/页码的一条新活路，见 §33.8。

---

## 33.1 需求侧：到底要一条什么陈述（复述，避免跑偏）

图里 `math.pbw-theorem` 的 statement 已经写死为「**域 F 上、任意（可无限维）李代数 L + 全序基 (X,≤)**」，
并且它自己的 statement 末尾就承认：

> 【范围】本节点按上面写的**任意（可无限维）李代数 + 全序基**陈述。所引来源的原书语境是否允许无限维 L **未核实**。

所以本轮要的**不是**「PBW 的又一个证明」，而是**一句带编号的、把假设写清楚的定理陈述**，其假设要能覆盖
`vir` 与 `vir₋`（可数无限维、非半单、特征零域上）。判据只有两条：

1. 假设里**不能**出现 finite-dimensional / semisimple / algebraically closed；
2. 结论要含**有序单项式基**（节点的 (1)）或**分次同构** `S(L) ≅ gr U(L)`（节点的 (2)）——两者有一即可，
   因为节点自己说明了两者在来源里是同一小节内互推的。

---

## 33.2 ★★ 首选（L1 全文到手）：Lakos, *Some proofs of the Poincaré–Birkhoff–Witt theorem and related matters*

### 33.2.0 文献标识与**版本陷阱（必读）**

| 项 | 值 | 等级 |
|---|---|---|
| 作者 | **Gyula Lakos**（Alfréd Rényi Institute of Mathematics；文末逐字 `Email address: lakos@renyi.hu`） | **L1** |
| 标题 | *Some proofs of the Poincaré–Birkhoff–Witt theorem and related matters* | **L1** |
| eprint | **arXiv:1812.04896** | **L1** |
| 版本 | **v1: 2018-12-12**；**v2: 2024-07-23**（"last revised"） | **L1**（abs 页） |
| 页数 / comments | 逐字：「**22 pages, Part 3 of original submission arXiv:1812.04896v1, rewritten**」 | **L1** |
| 分类 | math.RA；MSC **Primary 17B35; Secondary 17B01, 16S30** | **L1** |
| journal-ref | **无**（abs 页无 journal-ref，只有 arXiv 自发 DOI `10.48550/arXiv.1812.04896`）⇒ 截至 2026-09-11 **视为未发表的 expository preprint** | **L1** |
| 摘要（逐字） | 「This expository paper focuses on free Lie `K`-algebras and the basic PBW theorem. We argue in various ways that the basic PBW theorem is a quite close consequence of the Magnus-Witt theorems concerning free Lie algebras.」 | **L1** |

> ⚠⚠ **版本陷阱，直接写进 `loc`**：comments 逐字说 v2 是「v1 原稿的 **Part 3**，**重写过**」。
> ⇒ **v1 与 v2 的编号几乎肯定不同**，本节所有编号（Prop 6.1、Cor A.4、Thm 1.5–1.7）**只对 v2 成立**。
> `loc` 必须写死 **v2**。（同一类坑见 memory 里的 arXiv:2512.08296 案例。）

获取：`arxiv.org/pdf/1812.04896` → WebFetch 落盘 301.4 KB → `Read` 带 `pages` 读图。**PDF 页 = 论文页**（共 22 页）。
本轮 L1 逐页读了 **pp. 1–6, 16–22**（含全部参考文献）。

### 33.2.1 ★ 前提（书上 **p.1**，Introduction，「The local formulation of the PBW theorem」段；L1 逐字）

> **The local formulation of the PBW theorem.** Assume that `K` is a unital commutative ring, and `𝔤` is a
> `K`-module with a compatible Lie-ring structure; i. e. `𝔤` is a Lie `K`-algebra (also called: Lie ring over `K`).
> The universal enveloping algebra `𝒰𝔤` is the free `K`-algebra `F_K[𝔤] ≃ ⊗𝔤 ≡ ⊕_{n=0}^∞ ⊗^n 𝔤` factorized by
> the ideal `J𝔤` generated by the elements `X ⊗ Y − Y ⊗ X − [X,Y]`, the tensor products are taken over `K`.
> Let `𝒎 : ⊗𝔤 → 𝒰𝔤` denote this canonical homomorphism. The enveloping algebra is naturally filtered by
> `𝒰^n𝔤 = 𝒎(⊗^{≤n}𝔤)`, and the construction implies the existence of natural surjective maps
> `𝒎^{(n)} : ⊙^n 𝔤 → 𝒰^n𝔤/𝒰^{n−1}𝔤`. The (local form of the) Poincaré–Birkhoff–Witt theorem, whenever it holds,
> states that the maps `𝒎^{(n)}` are isomorphisms. This theorem is known to hold in the following cases:

**这段话就是本轮要的东西**：`K` 只要「幺交换环」，`𝔤` 只要「李 `K`-代数」。**全文没有任何有限维假设**
（我逐页读了 pp.1–6, 16–22，没有出现 "finite dimensional" 作为对 `𝔤` 的standing assumption）。
`𝒎^{(n)}` 是同构 ⇔ 图节点的 **(2)** 分次形式 `S(L) ≅ gr U(L)`（`⊙^n` 就是对称代数的 `n` 次分量）。

### 33.2.2 已知成立的情形一览（书上 **p.2**；L1 逐字，节录）

> (i) `K` is a field, or, more generally, `𝔤` is a free `K`-module, or, more generally, `𝔤` is a direct sum of
> cyclic `K`-modules (Poincaré [32]; `K` is a field, `ℚ ⊂ K`, cf. Ton-That, Tran [42]; Birkhoff [2], Witt [45]:
> `K` is a field, but their methods work more generally);
> (i') `K` is a principal ideal domain (Lazard [22]) or just a Dedekind domain (Cartier [8]); also see Higgins [18]
> for further results in this direction;
> (ii) `ℚ ⊂ K` (Cohn [11]);
> (ii') `1/2 ∈ K` but `[𝔤,[𝔤,𝔤]] = 0` (Nouazé, Revoy [31]), or `1/k! ∈ K` but `(ad 𝔤)^k 𝔤 = 0` ([21]);
> cf. Grivel [15] for a review. **But there are counterexamples** (see Širšov [39], Cartier [8], Cohn [11]).
> The most general approach is of Higgins [18], cf. Revoy [35].

> ★ **这一段对图有独立价值**：它逐字给出了「**PBW 在一般交换环上会失败**」这件事（有反例），
> 因此 `math.pbw-theorem--via-humphreys` 的 gaps 第四条（「基环限制」）**不是过度谨慎，是对的**。
> 若日后有人想把节点的基环从「域」放宽，**必须放宽到 (i)/(i')/(ii) 之一，不能放宽到任意交换环**。

### 33.2.3 全局形式（书上 **p.2**，「Global formulations of the PBW theorem」，情形 (i)；L1 逐字）

> (i) If `𝔤` is a sum of cyclic `K`-modules, then we can choose a basis `{g_α : α ∈ A}`, and an ordering `≤` of `A`.
> Then let `⊗_≤ 𝔤` be the submodule of `⊗𝔤` spanned by `g_{α_1} ⊗ … ⊗ g_{α_n}` with `α_1 ≤ … ≤ α_n`.
> Then the "basic" version of the PBW theorem states that
>
> &nbsp;&nbsp;&nbsp;&nbsp; `𝒎_≤ : ⊗_≤ 𝔤 → 𝒰𝔤`
>
> (a restriction of `𝒎`) is an isomorphism of `K`-modules. […] As the natural map `⊗^n_≤ 𝔤 → ⊙^n 𝔤` is an
> isomorphism, it is easy to see that this `𝒎_≤` is necessarily surjective, and **its injectivity is equivalent to
> the local version of PBW theorem**; one can see these inductively on the filtration.

**这就是图节点的 (1)（有序单项式基）**：`⊗_≤𝔤` 的自然基是有序单项式，`𝒎_≤` 是同构 ⇔ 有序单项式的像是 `𝒰𝔤` 的基。
**索引集 `A` 任意**（只要求给一个序 `≤`），**这正是无限维情形需要的措辞**。
末句还逐字给出「局部形式 ⇔ 全局形式」，所以节点 statement 里那句「(1) 与 (2) 在同一小节里互推」在这份来源里
**是被明写出来的**（Humphreys 那边只是转述）。

### 33.2.4 ★★★ **Proposition 6.1**（书上 **p.16**；L1 逐字）——本轮要的那条带编号陈述

第 6 节的标题与开场白（逐字）：

> **6. FROM `F^Lie_K` TO THE BASIC PBW THEOREM**
> Here we assume to know that free Lie `K`-algebras are free `K`-modules in every multigrade separately (MW),
> and that the PBW theorem holds for them.
>
> **Proposition 6.1.** *The PBW theorem holds if `𝔤` is a free `K`-module.*

后接约 1.5 页的完整证明（`Proof.` … `□`，跨 p.16–p.17），证法是把 `𝔤` 的基 `{Z_λ}` 提升到自由李代数
`F^Lie_K[X_λ : λ ∈ Λ]`，再用 Magnus–Witt 定理。第 6 节末尾还逐字补了一句：

> But then the arguments of the previous proof can be modified in order to obtain the basic PBW theorem for
> **sums of cyclic `K`-modules**.

> ⚠ **`loc` 必须同时指 p.1–2**：Prop 6.1 的主语「the PBW theorem」是在 Introduction 里定义的
> （局部形式 = `𝒎^{(n)}` 同构；全局形式 (i) = `𝒎_≤` 同构）。**单独引 "Proposition 6.1" 而不带 Introduction，
> 读者无法知道它到底断言了什么**——这与 §16.3 里 Kytölä 那句「无编号正文」是相反方向的同一类坑。

### 33.2.5 第二条独立证明：**Corollary A.4**（书上 **p.20**；L1 逐字）

Appendix A 标题逐字：「**Appendix A. The Witt–Lazard proof of the global PBW theorems**」，
开场逐字说这条路线「allows to formulate the proof of the PBW theorem simultaneously in (i) the basic case
(sum of cyclic `K`-modules) and (ii) the symmetric case (`ℚ ⊂ K`)」。链条是
**Lemma A.1 → Corollary A.2 → Lemma A.3 → Corollary A.4**。

> **(III) The PBW splittings.** Note that in case (i), `⊗_η 𝔤 = ⊗_≤ 𝔤`; and in case (ii), `⊗_η 𝔤 = ⊗_Σ 𝔤`.
> Thus, the statement of the PBW theorem is that `⊗_η 𝔤` and `J𝔤` do not intersect each other
> (and, in fact, they are complementer spaces in `⊗𝔤`).

> **Corollary A.4.** *The following inner direct sum decompositions hold:*
> (a) `J^{≤n}𝔤 = J^{≤n−1}𝔤 ⊕ J^n_η𝔤`; (b) …; (c) …; (d) …; (e) …;
> **(f) `⊗𝔤 = ⊗_η 𝔤 ⊕ J𝔤`.**

紧接其证明之后逐字：

> In particular, we find the statement of the PBW theorem in (f).

⇒ **同一篇论文里有两条互相独立的证明**（第 6 节走 Magnus–Witt；附录 A 走经典 Witt–Lazard），
对 `status = rigorous` 是加分项。另外 p.20 逐字点名了其它经典证明的出处，可作为将来找一手书的地图：

> Specified to the basic case (i), the proof given above is certainly over-algebraized compared to the one of
> **Jacobson [19]** […] There are similar proofs which concentrate not on the factorization structure but on
> constructing the regular representation of the enveloping algebra. Such one is the proof of
> **Cartan, Eilenberg [7]** in the basic case (i). In the symmetric case (ii), this is done by **Cohn [11]**;
> another (terse) proof is given in **Deligne, Morgan, Bernstein [13]**. Quite different proof is the one of
> **Milnor, Moore [30]** (over fields) which uses the coalgebra structure of the universal enveloping algebra.

（参考文献逐字：[7] Cartan, Henri; S. Eilenberg, Samuel: *Homological algebra*. Princeton University Press, 1956；
[19] Jacobson, Nathan: *Lie Algebras*. Wiley, New York, 1962；[30] Milnor, John W.; Moore, John C.:
*On the structure of Hopf algebras*. Ann. of Math. (2) **81** (1965), 211–264；
[5] Bourbaki, Nicolas: *Elements of mathematics. Lie groups and Lie algebras. Part I: Chapters 1–3.*
Hermann, Paris; Addison-Wesley Publishing Co., Reading Mass., **1975**。）

### 33.2.6 使用限制（诚实记录）

1. **未发表**：expository preprint，无 journal-ref（L1 核对 abs 页）。它的权威性低于教科书，
   **但它是本轮唯一一条「带编号 + 前提逐字 + 无维数限制 + 全文可读」的来源**。
   建议在图里**与 `humphreys-1972` 并列**（教科书给权威与完整证明，本篇给适用范围），而不是取代它。
2. **Prop 6.1 的证明依赖 Magnus–Witt 定理**（本篇 **Theorem 1.5 / 1.6 / 1.7**，p.5，逐字：
   「**Theorem 1.5.** (The Magnus–Witt theorem.) `F^Lie_K[X_λ : λ ∈ Λ]` embeds to the noncommutative polynomial
   algebra `F_K[X_λ : λ ∈ Λ]` by the commutator-evaluation.」；1.6「… is a free `K`-module (multigrade-wise)」；
   1.7「… can be directly complemented …」），这是**非教科书路线**。若 reviewer 介意，改引 **Corollary A.4(f)**，
   那条走的是经典 Witt–Lazard 证明。
3. **记号**：本篇用 `𝒰𝔤`、`⊙^n𝔤`（对称幂）、`⊗_≤𝔤`、`J𝔤`；图节点用 `U(L)`、`S(L)`、`gr U(L)`。
   对应关系是 `⊙^n 𝔤 ↔ S(L)` 的 `n` 次分量、`𝒰^n𝔤/𝒰^{n−1}𝔤 ↔ gr_n U(L)`。**抄公式时不要混。**

---

## 33.3 ★ Bourbaki：位置钉死了（L1），内容与「Theorem 1」仍是 L0

### 33.3.1 怎么拿到的（**新活路，值得进 reading-list**）

Springer 书页仍是登录墙（§19.1 记的 303 → `idp.springer.com`）。本轮改走
**德国国家图书馆（Deutsche Nationalbibliothek）为每条书目挂的「出版社目录扫描件」**：

```
https://d-nb.info/954432517/04      ← IDN 954432517 的第 04 号附件 = 目录扫描 PDF（8 页，1.3 MB）
```

WebFetch 落盘（**注意：它是纯图片型 PDF，WebFetch 的摘要器读不出来，必须落盘后用 `Read` 带 `pages` 读图**）
→ `Read pages 1-8` 全部读毕。**L1**。

### 33.3.2 标题页（PDF p.1；L1 逐字）

> NICOLAS BOURBAKI / ELEMENTS OF MATHEMATICS / **Lie Groups and Lie Algebras** / **Chapters 1–3** /
> Springer-Verlag / Berlin Heidelberg New York / London Paris Tokyo

（**扫描件里没有版权页，故出版年未见**。见 33.3.5 的年份冲突。）

### 33.3.3 ★★ 目录里 Chapter I §1–§2 的逐字转录（PDF p.2 = 书上 **p. xi**；L1）

> **CHAPTER I. LIE ALGEBRAS … 1**
> **§ 1. Definition of Lie algebras … 1**
> &nbsp;&nbsp; 1. Algebras … 1 / 2. Lie algebras … 3 / 3. Commutative Lie algebras … 5 / 4. Ideals … 5 /
> &nbsp;&nbsp; 5. Derived series, lower central series … 6 / 6. Upper central series … 6 / 7. Extensions … 7 /
> &nbsp;&nbsp; 8. Semi-direct products … 8 / 9. Change of base ring … 11
> **§ 2. Enveloping algebra of a Lie algebra … 12**
> &nbsp;&nbsp; 1. Definition of the enveloping algebra … 12
> &nbsp;&nbsp; 2. Enveloping algebra of a product … 13
> &nbsp;&nbsp; 3. **Enveloping algebra of a subalgebra** … 14
> &nbsp;&nbsp; 4. Enveloping algebra of the opposite algebra … 15
> &nbsp;&nbsp; 5. Symmetric algebra of a module … 16
> &nbsp;&nbsp; 6. Filtration of the enveloping algebra … 17
> &nbsp;&nbsp; 7. **The Poincaré-Birkhoff-Witt Theorem … 18**
> &nbsp;&nbsp; 8. Extension of derivations … 23
> &nbsp;&nbsp; 9. Extension of the base ring … 25

⇒ **可写进图的定位**：`Ch. I, §2, no. 7 «The Poincaré-Birkhoff-Witt Theorem», p. 18`（**L1**）。

**顺带三条对本项目有用的目录情报（同一页/后页，L1）**：
- **§2 no. 3「Enveloping algebra of a subalgebra」在 p. 14** ——「`U(L)` 作为 `U(H)`-模自由」这条
  （= `math.verma-module-free-over-negative-part` 的直接上游）如果 Bourbaki 有，最可能在这里或 no. 7 的推论里。
- **§1 no. 9「Change of base ring」p. 11 / §2 no. 9「Extension of the base ring」p. 25** ——
  Bourbaki 显然是在**一般基环**上做的（否则不会有这两节），这与「`𝔤` 为自由 `K`-模」的前提相容，
  但**这只是结构性旁证，不是对前提的核实**。
- Chapter II §1 no. 5「**Structure of the cogebra `U(g)` in characteristic 0**」p. 116；
  Chapter II §3「Enveloping algebra of the free Lie algebra」p. 136。

### 33.3.4 ⚠ **硬性禁令：不得写「Theorem 1」**

- 任务书给的定位是「Ch. I §2.7 **Theorem 1**」。**本轮对这个编号得到的证据是零。**
  目录只到 `no. 7` 一级；Google Books 拿不到正文；所有说「就是 Theorem 1」的话都来自**检索后端的自述**，
  按 §0 的口径**不可引**（这与 §15.4 那条 `Corollary A/B/D` 禁令同性质）。
- 同理，**「`𝔤` 是自由 `K`-模」这条前提在 Bourbaki 原文里怎么写的，本轮完全没有核到**。
  ⇒ **Bourbaki 目前不能作为「撤 inferred」的依据**：我们只知道那一节叫什么、在第几页。

### 33.3.5 Google Books 与年份：两个坑

| 探针 | 结果 | 判读 |
|---|---|---|
| 卷 id **`brSYF_rB2ZcC`**，控制查询 `"zzqxjkwmnbv"` | **No results** | ✔ 控制通过（本卷无「回落固定页」病） |
| `"Poincaré-Birkhoff-Witt"` | **Page 187** | ✘ **与目录的 p.18 矛盾**。按目录，p.187 落在 Chapter II 的「Exercises for §4」区。⇒ **检索后端只回一个页码，而且不是首个命中**。**Google Books 这条路本轮判定为不可用于定位**（与 §15.3 Humphreys 卷的经验相反） |
| `"Enveloping algebra"` | Page 16 | 与「§2 起于 p.12」相容，但无信息量 |
| 卷元数据 | 「Publisher: Springer Science & Business Media；**Publication Year: 1975**；ISBN **3540642420 / 9783540642428**；**450 pages**；Edition: reprint」 | ⚠ **年份自相矛盾**：ISBN 354064242X 系列是 **1998 年 Springer 平装重印**的号，而 1975 是 Hermann/Addison-Wesley 英译本的年份（= lakos-2024-pbw 的 [5] 逐字著录）。**Google Books 的年份不可信。**「450 pages」与目录末条「… 449」相容 ⇒ 至少可确认**DNB 扫描的目录与该 Google Books 卷是同一套页码** |

> ⇒ **因此本轮不把 Bourbaki 登记进 `sources.bib`**：正文未取、内部编号未核实、**连出版年都定不下来**
> （key 的年份没法诚实地填）。沿用 §17 的口径留在本节备查。若 lead 认为 §15 的 humphreys-1972 先例
> （正文未取也登记了）应当同样适用于 Bourbaki，那就登记——**但 note 里必须写死「只有目录是 L1」**。
> 待填的骨架见 §33.7 末尾。

---

## 33.4 Dixmier：任务书给的 **2.1.11** 拿到了**相反**证据

来源：**Danny Crytser, *Notes on Enveloping Algebras (following Dixmier)*, Summer 2019**，
`https://myslu.stlawu.edu/~dcrytser/EnvelopingAlgebrasNotes.pdf`（落盘 385.3 KB，**L1 读毕 pp.1–7**）。
首页摘要逐字：「These notes follow **[2] Ch. 2** very closely – mostly they were written to digest and provide
additional background information.」（`[2]` = Dixmier）。

**该讲义把自己的每条结论逐条挂到 Dixmier 的编号上（L1 逐字）**：

| Crytser | 挂到 Dixmier | 内容（L1 逐字节录） |
|---|---|---|
| Lemma 1.1 | `[2, Lemma 2.1.3]` | `U(𝔤)` 的泛性质 |
| Lemma 1.2 | `[2, Lem. 2.1.5]` | `σ(a_1)…σ(a_p) − σ(a_{π(1)})…σ(a_{π(p)}) ∈ U_{p−1}(𝔤)` |
| Lemma 1.3 | `[2, Lem. 2.1.6]` | 「The set of monomials `{y_I : I increasing of length p}` spans the space `U_p(𝔤)`.」 |
| **Lemma 1.5** | **`[2, Lem 2.1.8]`** | **「The set `{y_I : I increasing}` forms a basis for `U(𝔤)`.」← 这就是 PBW 基** |
| Prop 2.3 | `[2, Prop. 2.2.4]` | `𝔤' ⊂ 𝔤` ⇒ `U(𝔤') ⊂ U(𝔤)` |
| **Prop 2.4** | **`[2, Prop. 2.2.7]`** | 「Let `𝔤' ≤ 𝔤` and let `(y_1,…,y_q)` be a basis for a (vector space) complement of `𝔤'` in `𝔤`. Then the set `{y_1^{k_1}…y_q^{k_q} : k_j ∈ ℕ∪{0}}` is a **`U(𝔤')`-module basis for `U(𝔤)`**.」 |
| Prop 2.5 | `[2, Prop. 2.2.8]` | `U(𝔥) ⊗_{U(𝔩)} U(𝔣) → U(𝔤)` 是双射 |

**结论**：
1. **有序单项式基在 Dixmier 里是 `Lem 2.1.8`（L3），不是 `2.1.11`。** `2.1.11` 是什么，本轮**仍然不知道**
   （§17 已记「完全未核实」，本轮把它降级为「**有相反证据**」）。**禁止在图里写 Dixmier 2.1.11。**
2. **`Prop. 2.2.7` 是 (B)（`U(L)` 作为 `U(子代数)`-模自由）的编号候选**，比 Humphreys 那条无字母可写的推论好。
   ⚠ **但 Crytser 的转述里 `(y_1,…,y_q)` 是有限串**，且他自己的 Definition 1.6 逐字假设
   「Assume that `𝔤` is **finite-dimensional** (although as in [4] its possible to make this work for
   **countable-dimension** Lie algebras as well)」——**所以这条对 `vir` 能不能直接用，未定**。
3. **Crytser 是个人讲义**，权威性等同 `swanson-2015-pbw`（lead 2026-09-11 裁决：个人笔记只作核对源）。
   ⇒ 只用于「Dixmier 的编号大概是什么」，**不入 `sources.bib`**，也不作为图的 source。
4. Dixmier §2.1 的**标题**是「The Poincaré-Birkhoff-Witt theorem」（L4，ScienceDirect 的章节页转述），
   与 Crytser 的 2.1.x 编号相容；但 Dixmier 对 `𝔤` 的维数假设**本轮仍未核到**。

---

## 33.5 其余候选与两条「不要再抓了」的负面结论

| 候选 | 本轮结果 |
|---|---|
| **Shepler–Witherspoon, *Poincaré-Birkhoff-Witt Theorems*, arXiv:1404.6497**（已发表：MSRI Publ. **67**, Cambridge Univ. Press, 2015, pp. 259–290——书目取自 lakos-2024-pbw 的 [37]，L1） | **★ 明确不可用**（L1 读毕 pp.1–6）。它的两条 PBW 陈述**都是加粗小标题、没有编号**：「**Original PBW Theorem.** *A Lie algebra `𝔤` embeds into its universal enveloping algebra `U(𝔤)`, and the associated graded algebra of `U(𝔤)` is isomorphic to `S(𝔤)`, the symmetric algebra on the vector space `𝔤`.*」「**PBW Basis Theorem.** *Let `v_1,…,v_n` be an ordered `k`-vector space basis of the Lie algebra `𝔤`. Then `{v_1^{a_1}⋯v_n^{a_n} : a_i ∈ ℕ}` is a `k`-basis of the universal enveloping algebra `U(𝔤)`.*」——而且 p.2 逐字定义「**A finite dimensional Lie algebra** is a finite dimensional vector space `𝔤` over a field `k` …」，p.2 又逐字说「we limit discussions to **finitely generated algebras** over `k` for simplicity」。**方向与本项目要的正相反**（要的是无限维），且无编号。**下一轮不要再抓这一篇。** |
| **Paul Garrett, *Poincaré-Birkhoff-Witt theorem*（UMN 讲稿, 2011-04-08, 4 页）**，`www-users.cse.umn.edu/~garrett/m/algebra/pbw.pdf` | **有编号且方向正确**（L1 读毕）：「**[0.0.1] Theorem**: For any basis `{x_i : i ∈ I}` of a Lie algebra `𝔤` with *ordered* index set `I`, the monomials `x_{i_1}^{e_1}…x_{i_n}^{e_n}` (with `i_1 < … < i_n`, and integers `e_i > 0`) form a *basis* for the enveloping algebra `U𝔤`.」「**[0.0.2] Corollary**: The natural map of a Lie algebra to its universal enveloping algebra is an *injection*.」p.2 逐字：「The hard part of the argument is basically from Jacobson, and applies to **not-necessarily finite-dimensional** Lie algebras over arbitrary fields of characteristic 0.」p.1 逐字：「The following argument does not use any further properties of the Lie algebra `𝔤`, so *must* be general.」**⇒ 这是「无限维适用性」的第三条旁证**（前两条是 ardizzoni-2010 与 swanson-2015-pbw）。**但它是个人讲稿**，按 lead 2026-09-11 的裁决**只能作核对源、不进 `sources[]`**。 |
| **Encyclopedia of Mathematics, "Birkhoff-Witt theorem"**（Springer/Kluwer 百科，作者 T.S. Fofanova） | 已读（检索后端转述，**L3**）。给出「域上任意李代数 + 有序基 ⇒ 有序积构成 `U(G)` 的基」与推论「`G → U(G)` 是单同态」，并说「The theorem remains valid if `k` is a **principal ideal domain**」。**方向正确、无维数限制**，**但百科条目没有编号**，且本轮只拿到转述。作为旁证记下，不入 bib。 |
| **nLab, "PBW theorem"** | 前提写的是 **flat**（`𝔤` flat as `k`-module, `ℚ ⊂ k`），不是 free；陈述无编号。引的一手文献是 **Quillen, *Rational homotopy theory*, Ann. of Math. 90 (1969) 205–295, appendix B.3**（**新候选**：这是一条「带编号（附录小节号）+ 已发表 + 一般基环」的路线，本轮**未取正文**，L0）。 |
| **Weibel, *An Introduction to Homological Algebra*, 「Theorem 7.3.7」** | **新候选，本轮零证据**。Google Books 卷 `flm-dBXfZ_gC`（§32.1 已记控制通过）：`"Poincaré-Birkhoff-Witt"` → 只回 **p.445**（按 §32 的经验那是书末索引区），`"ordered monomials"` → **No results**。**连 §7.3 的位置都没钉住 ⇒ 禁止写 Weibel 7.3.7。**（注意 `weibel-1994` 已在 bib 里，是 §28 给 `H²` 用的，**不要顺手拿它当 PBW 的来源**。） |
| Serre / Jacobson / Kac IDLA / Moody–Pianzola | 均无公开全文，编号零证据（**L0**，沿用 §17）。 |

---

## 33.6 ★★ 形式化侧：三个证明助手都没有 PBW（本轮全部重查，读取日期 **2026-09-11**）

| 系统 | 证据 | 等级 |
|---|---|---|
| **Lean 4 / Mathlib（源码）** | `raw.githubusercontent.com/leanprover-community/mathlib4/master/Mathlib/Algebra/Lie/UniversalEnveloping.lean` 逐条读声明：`Rel`、`ringCon`、`UniversalEnvelopingAlgebra`、`mkAlgHom`、`ι`、`lift`、`lift_symm_apply`、`ι_comp_lift`、`lift_ι_apply`、`lift_ι_apply'`、`lift_unique`、`hom_ext`。**无 PBW、无滤过、无对称代数同构；无 TODO**（只有 Porting note）。与 §16.4 读 docs 页的结论一致，但这次读的是**源码**。 | **L1** |
| **★ Lean 4 / Mathlib（官方定理跟踪表）** | `docs/1000.yaml` 里有条目 `Q2270905: title: Poincaré–Birkhoff–Witt theorem`，**但该条目没有 `decl` / `authors` / `date` 字段** ⇒ **Mathlib 官方把它登记为「未形式化」**。（对照组：同表里 `Q1243340 Birkhoff–Von Neumann theorem` 有 `decl: doublyStochastic_eq_convexHull_permMatrix, authors: Bhavik Mehta, date: 2024`。） | **L1** |
| **Isabelle / AFP** | `isa-afp.org/topics/mathematics/algebra/` 下与李代数相关的**只有一条**：**"Lie Groups and Algebras", Richard Schmoetten & Jacques D. Fleuriot, 2024-07-31**。其摘要（L2）形式化的是**微分几何路线**：Lie groups as locales on smooth manifolds、diffeomorphism groups、group actions、GL、smooth vector fields、"the Lie algebra of a Lie group"（左不变向量场）。**没有抽象李代数、没有泛包络代数、没有 PBW。** AFP 无 PBW 条目。 | **L2**（摘要级） |
| **Coq / Rocq** | 本轮检索**未找到**任何 PBW 或泛包络代数的形式化。**这是「没找到」，不是「已证明没有」。** | **L0（否定）** |

> ⇒ **§16.4 的硬约束不变，而且更硬了**：`math.pbw-theorem` 及其一切下游
> **上限 `rigorous`，不得标 `formalized`**。
> **★ 这条同时结案了 §19.2 的 Q18 的一半**：「Mathlib 的 1000.yaml 跟踪表」本轮**已查**，
> 结果是「条目在、`decl` 不在」。下次复查只需再看这一个字段。
> **Q18 剩下的一半**（`Mathlib/Algebra/Lie/Free.lean` docstring 里那句「I don't know of a proof that avoids
> invoking the Poincaré–Birkhoff–Witt theorem」）**本轮仍未核**。

---

## 33.7 图里建议怎么改（供 curator 取舍；researcher 不改 `graph/`）

### (a) 给 `math.pbw-theorem` 增加一条 source

```yaml
  - ref: lakos-2024-pbw
    loc: "arXiv:1812.04896**v2**, Proposition 6.1, p. 16（「The PBW theorem holds if 𝔤 is a free K-module.」）；
          该命题所指的「PBW theorem」由 Introduction, p. 1–2 定义：局部形式 = 𝒎^{(n)} : ⊙^n𝔤 → 𝒰^n𝔤/𝒰^{n−1}𝔤 为同构，
          全局形式 (i) = 𝒎_≤ : ⊗_≤𝔤 → 𝒰𝔤 为 K-模同构（有序单项式基）；
          第二条独立证明见 Appendix A（Witt–Lazard），Corollary A.4(f), p. 20"
    note: |
      **L1 全文读毕（researcher 2026-09-11，literature/extractions/math-sources.md §33.2）**。
      前提逐字：「Assume that K is a unital commutative ring, and 𝔤 is a K-module with a compatible
      Lie-ring structure; i. e. 𝔤 is a Lie K-algebra」——**全文无任何有限维假设**，基的索引集 A 任意。
      域是特例（域上模皆自由）。本条 source 的作用是**背书适用范围**，不是替代 humphreys-1972 的教科书证明。
      ⚠ 版本陷阱：v2（2024-07-23）的 comments 逐字为「Part 3 of original submission arXiv:1812.04896v1,
      rewritten」⇒ v1 编号不同，`loc` 必须写死 v2。⚠ 未发表 preprint（无 journal-ref）。
```

### (b) 撤 `inferred` 的条件——**已经满足，但要配一条记录**

`math.verma-module-free-over-negative-part--via-pbw-theorem` 里到 `math.pbw-theorem` 的边，
其 `inferred: true` 的 note 逐字写的理由是：

> **inferred 的理由是适用范围，不是论证**（math-sources.md §15.5，Q15）……
> **撤销条件**：核到 Humphreys §17.1 对 L 的假设声明并确认不限有限维（Q15）。

本轮的发现让这条**撤销条件本身可以放宽**：瓶颈从来不是「Humphreys 怎么说」，而是
「**本图有没有一条来源背书无限维**」。现在有了。建议：

1. 把该边改 `inferred: false`，note 重写为：
   「适用范围由 **lakos-2024-pbw, Prop 6.1（K 幺交换环、𝔤 自由 K-模、无维数限制）** 背书；
    vir 与 vir₋ 都是特征零域上的可数维李代数，落在其假设内，且都有现成可数全序基
    （{L_n}∪{C}；{L_{-1} < L_{-2} < …}），不需要选择公理。
    humphreys-1972 仍作为教科书证明的来源保留，其有限维半单语境**不再是本边的瓶颈**。
    原 inferred 理由与撤销条件（Q15）见 math-sources.md §15.5、§33.7。」
2. **Q15 不必再追**（Humphreys §17.1 的假设声明）：它现在只影响 `humphreys-1972` 这一条 source 的
   自洽性，不再卡住任何一条边。建议在 §19.2 把 Q15 从「决定 inferred 能否撤」降级为「可选」。
3. ⚠ **一个前置动作，请 curator/lead 裁决**：`math.pbw-theorem` 的 **statement 里那段【范围】**
   （「所引来源的原书语境是否允许无限维 L **未核实**」）与 **notes 的「警告二」** 都已**过时**。
   按项目原则 1，statement 文本不可改。可选做法：(i) 在 notes 里追加一条「2026-09-11 更新：
   范围问题已由 lakos-2024-pbw Prop 6.1 解决，statement 的【范围】段与警告二作废」；
   或 (ii) 新建 `math.pbw-theorem-v2` 并把旧卡标 `superseded_by`。**researcher 不代决。**

### (c) 建议新增一条独立推导 `math.pbw-theorem--via-lakos`

现在 `math.pbw-theorem` 只挂着 `--via-humphreys` 一条推导，而那条的 gaps 第一条逐字承认
「**印本未取得** …… 本推导对来源的核实等级是 L3/L4，不是 L1」。新增一条

```yaml
id: math.pbw-theorem--via-lakos
target: math.pbw-theorem
kind: proof
status: rigorous
depends_on: []
sources:
  - ref: lakos-2024-pbw
    loc: "arXiv:1812.04896v2, §6 (Prop. 6.1, p.16, 走 Magnus–Witt 路线) 与 Appendix A (Cor. A.4(f), p.20, 走经典 Witt–Lazard 路线)"
```

的好处：**同一张卡挂两条独立推导**（教科书 vs 全文可读的 preprint），
把「可核对性」与「权威性」分开承载，正合项目原则 1。**同时它自带两条独立证明**（§33.2.5）。
`status` 仍是 `rigorous`（未形式化，见 §33.6）。

### (d) Bourbaki 的 `loc` 骨架（**若 lead 决定登记**）

```yaml
  - ref: bourbaki-lie-<年份待定>
    loc: "Ch. I, §2, no. 7 «The Poincaré-Birkhoff-Witt Theorem», p. 18（Springer 英译 Chapters 1–3）"
    note: |
      **只有目录是 L1**（DNB 目录扫描 d-nb.info/954432517/04）。**正文完全未取**：
      定理的内部编号（常被转引为 "Theorem 1"）与前提（「𝔤 为自由 K-模」）**均未核实（L0）**。
      **禁止在图里写 "Theorem 1"。** 出版年在来源间冲突（Google Books 元数据 1975 + ISBN 3540642420
      系 1998 重印；lakos-2024-pbw [5] 著录为 Hermann/Addison-Wesley 1975）。
```

**researcher 本轮不登记它**，理由见 §33.3.5。

---

## 33.8 访问日志与未解决问题（本节）

### 33.8.1 访问日志

| 目标 | URL / 手法 | 结果 |
|---|---|---|
| **Lakos arXiv:1812.04896（22 页）** | `arxiv.org/pdf/1812.04896` | **成功**（落盘 301.4 KB → `Read pages`；读 pp.1–6, 16–22） |
| **Lakos abs 页（版本/journal-ref）** | `arxiv.org/abs/1812.04896` | **成功**（v1 2018-12-12 / v2 2024-07-23；无 journal-ref） |
| **★ Bourbaki 目录（8 页扫描）** | **`d-nb.info/954432517/04`** | **成功**（落盘 1.3 MB；**纯图片型 PDF，WebFetch 摘要器读不出，必须 `Read pages` 读图**） |
| DNB 书目记录本体 | `d-nb.info/954432517` → 302 → `portal.dnb.de/opac.htm?...` | **失败：`portal.dnb.de` 被 Anubis 反爬拦截（"Access Denied: error code ..."）** |
| **Shepler–Witherspoon arXiv:1404.6497** | `arxiv.org/pdf/1404.6497` | **成功**（落盘 356.9 KB；读 pp.1–6） |
| **Garrett PBW 讲稿（4 页）** | `www-users.cse.umn.edu/~garrett/m/algebra/pbw.pdf` | **成功**（落盘 93.7 KB，全读） |
| **Crytser, Notes on Enveloping Algebras（following Dixmier）** | `myslu.stlawu.edu/~dcrytser/EnvelopingAlgebrasNotes.pdf` | **成功**（落盘 385.3 KB；读 pp.1–7） |
| **Mathlib 源码** | `raw.githubusercontent.com/leanprover-community/mathlib4/master/Mathlib/Algebra/Lie/UniversalEnveloping.lean` | **成功**（raw.githubusercontent.com **不需要认证**，是读 Mathlib 源码的稳定路线） |
| **Mathlib `docs/1000.yaml`** | `raw.githubusercontent.com/leanprover-community/mathlib4/master/docs/1000.yaml` | **成功**（Q2270905 无 decl） |
| **Isabelle AFP 代数主题页** | `isa-afp.org/topics/mathematics/algebra/` | **成功**（只有一条 Lie 相关条目） |
| AFP 站内搜索页 | `isa-afp.org/search?term=...` | **失败**（纯 JS，返回的是空搜索框） |
| nLab | `ncatlab.org/nlab/show/PBW+theorem` | **成功**（带重音的标题 `Poincaré-Birkhoff-Witt+theorem` 是 **404**，**要用 `PBW+theorem`**） |
| Google Books（Bourbaki 卷 `brSYF_rB2ZcC`） | `books.google.com/books?id=…&q=…` | **控制通过但结论不可用**：只回**一个**页码，且与目录矛盾（见 §33.5 表） |
| Google Books（Weibel 卷 `flm-dBXfZ_gC`） | 同上 | `"Poincaré-Birkhoff-Witt"` → p.445（索引区）；`"ordered monomials"` → No results |
| Dixmier 正文 | 全网 | **仍然一页都拿不到**（§17 的结论不变） |

> **对 `reading-list.md` 的建议增补**：
> - **★ 新活路一：`d-nb.info/<IDN>/04` = 出版社目录扫描件。** 德国国家图书馆给很多 Springer/Hermann 书挂了
>   目录扫描，**这是 Springer 登录墙的一条绕路**，能拿到章节标题 + 页码（L1）。
>   **注意它是图片型 PDF：必须落盘后 `Read pages` 读图，WebFetch 的摘要器会说「只有二进制」。**
>   （反面：`portal.dnb.de` 的检索界面被 Anubis 反爬挡死，不要去。）
> - **★ 新活路二：`raw.githubusercontent.com/leanprover-community/mathlib4/master/<path>`** 直接读 Mathlib 源码与
>   `docs/1000.yaml`，**不需要认证**，比读 `mathlib4_docs` 的 HTML 页更权威（读的是源码本身）。
> - **新活路三**：`www-users.cse.umn.edu/~garrett/`、`myslu.stlawu.edu/~<user>/`（个人讲稿，只作核对源）。
> - **★ 修正 §15.3 的乐观结论**：Google Books 的「控制实验通过」**只保证没有回落页病，不保证返回的是首个命中**。
>   本轮 Bourbaki 卷控制通过，返回的 p.187 却与出版社目录的 p.18 矛盾。
>   ⇒ **今后 Google Books 的页码只能作为「与其它证据相容性检验」，不能单独定位。**
> - **新死路**：`portal.dnb.de`（Anubis 反爬）；`isa-afp.org/search`（纯 JS）；
>   `ncatlab.org/nlab/show/Poincaré-...`（带重音的 URL 404）。

### 33.8.2 未解决 / 留给下一轮

- **Q23** **Bourbaki Ch. I §2 no. 7 的正文（p.18–23）**：定理的内部编号是不是 "Theorem 1"？前提怎么写的？
  持书者看一眼即可结案。**在结案前，图里只许写 `Ch. I, §2, no. 7, p. 18`。**
  顺带看 **§2 no. 3（p.14）**有没有「`U(L)` 作为 `U(H)`-模自由」——那是 (B) 的编号候选。
- **Q24** **Bourbaki 该卷的出版年**（Springer 英译到底著录 1975 还是 1989？ISBN 3540642420 是哪一次重印？）。
  这条决定 `sources.bib` 的 key 怎么起。DNB 门户被反爬挡住，可试 Library of Congress / WorldCat。
- **Q25** **Dixmier `2.1.11` 究竟是什么**（§33.4 已证明它**不是**有序单项式基）。低优先级，
  但若有人再看到「Dixmier 2.1.11 = PBW」的说法，请指向本节。
  更值得追的是 **Dixmier `Prop. 2.2.7`**（`U(𝔤')`-模基）对无限维是否成立。
- **Q26** **Quillen, *Rational homotopy theory*, Ann. of Math. 90 (1969), appendix B.3**（nLab 引的一手出处，
  flat 模版本）。这是「带编号 + 已发表 + 一般基环」的新候选，本轮未取正文。
- **Q27** **lakos-2024-pbw 是否已被期刊接受**（现为 L0）。若发表，编号可能变；`loc` 现在写死 v2。
- **Q28** **Q18 的后半**：`Mathlib/Algebra/Lie/Free.lean` 的 docstring 是否真写着
  「I don't know of a proof that avoids invoking the Poincaré–Birkhoff–Witt theorem」。
  现在有了 `raw.githubusercontent.com` 这条路，**一次 fetch 就能核实**，本轮遗漏。
- **Q29** Isabelle AFP 那条 *Lie Groups and Algebras*（Schmoetten–Fleuriot 2024）本轮只读了摘要（L2）。
  若日后要拿它当「李代数已被别的系统形式化」的旁证，需读条目正文确认它形式化到哪一步。
# § Kac 行列式公式

> **编号说明**：本节按分派写作 **§34**。**§33 预留给「PBW 一般来源」**（另一路 agent 并行写入，
> 本轮我写入时该节尚不存在）。**若合并后 §33 仍空缺，lead 可把本节整体改号为 §33**——
> 本节内部没有交叉引用自己的节号，改号是安全的。§20–§23 在本文件里本来就是空号。

## 34. Kac 行列式公式：可逐字定位的带编号来源（researcher，2026-09-11）

- 触发：`graph/statements/worldsheet/kac-determinant.yaml` 与其推导 `--via-feigin-fuchs` 的 `sources`
  现引 `kac-1979`（`loc: "Theorem 1"`）与 `feigin-fuchs-1982`（`loc: "§2（完整证明）"`），
  **两条编号都未核实**，且 `sources.bib` 对 `kac-1979` 指向哪一篇存疑
  （`brst-cohomology-sources.md` §1.5：FGZ 1986 的 ref 10 是 ICM Helsinki 1978，不是 LNP 94）。
- 本轮结果：**两条 `loc` 都要改**，并且找到了**一条可公开获取、可逐字引用的带编号来源**（Schottenloher Thm 6.12）。

### 34.1 ★★★ `kac-1979` 归属结论：LNP 94 与 ICM Helsinki 是**两篇不同的论文**，且两者都被文献当作行列式公式的出处

**决定性证据（L1）：Kac 本人的出版目录** `https://math.mit.edu/~kac/publications.pdf`
（WebFetch 落盘 159 KB → `Read pages 1-3` 读图），"Publications" 列表第 3 页逐字：

> 30. Contravariant form for infinite dimensional Lie algebras and superalgebras, *Lecture
>     Notes in Physics* **94** (1979), 441–445.
> 31. (with D. Kazhdan) Structure of representations with highest weight of infinite dimen-
>     sional Lie algebras, *Advances in Math.* **34** (1979), 97–108.
> 32. Highest weight representations of infinite dimensional Lie algebras, *Proceedings of ICM,
>     Helsinki* **1978** (1980), 299–304.

⇒ **#30 与 #32 是目录里两个独立条目，不是同一篇的两个版本**。
「`kac-1979` 到底是哪篇」这一疑点由此结案：**`kac-1979` 就是 #30 = LNP 94, 441–445**，登记无误。
顺带**副产品**：`kac-kazhdan-1979` 的终页 **108 由作者本人目录确认**（原 note 说「终页未与出版方核对」，可解除）。

但**新的分歧**随之出现——两篇都被当作 Kac 行列式的出处：

| 谁 | 把行列式公式归给哪篇 | 等级 |
|---|---|---|
| **Feigin–Fuchs 1982**（俄文原刊，§34.2） | **[2] = LNP 94, 1979, 441–445** | **L1 逐字** |
| **Schottenloher 2008 Thm 6.12**（§34.3） | **[Kac80] = Proc. Intern. Congress Helsinki, 299–304, 1980** | **L1 逐字** |
| Lian–Zuckerman 1991 [K1]（`primary-sources-round2.md` §1.6） | LNP 94, p. 441 | L1（前轮） |
| FGZ 1986 ref 10（`brst-cohomology-sources.md` §1.5） | ICM Helsinki 1978, Vol. 1, 299–304 | L1（前轮） |
| Goddard–Olive 型引用（检索后端转述，未逐字核实） | **两篇并列写在同一条**：「Lecture Notes in Physics, Vol. 94, p. 441 …; in Proc. Int. Congress of Math., Helsinki (1978)」 | L4 |

**结论与建议**：
1. `kac-1979` 保持指向 LNP 94，**note 里写死「与 ICM 那篇是两篇，不是同一篇的两个版本，依据是 Kac 本人出版目录 #30/#32」**。
2. **新增 bib key `kac-1980-icm`**（ICM Helsinki 1978，出版年 1980）。FGZ 与 Schottenloher 引的是它，
   图里凡是转述这两家的地方应引它而不是 `kac-1979`。
3. **「哪一篇最先陈述 Virasoro 的行列式公式」本轮未能裁决**（两篇正文都没拿到，见 §34.10 Q23/Q24）。
   一条**弱倾向**（L4，不得单独用）：检索后端称 Kac 本人的《Infinite dimensional Lie algebras》
   把 ICM 那篇（[1978 B]）引在 **g(A) 的最高权模与特征标公式**两章，暗示 ICM 那篇偏 Kac–Moody 综述，
   而 LNP 94 的标题「contravariant form … and superalgebras」正对逆变形式；
   FF 1982 作为**同期最内行的引用者**选了 LNP 94。
4. **`loc` 里绝不能再写「Theorem 1」**：LNP 94 正文未获取，内部编号 **L0**。

### 34.2 ★★★ Feigin–Fuchs 1982 全文核实（俄文原刊，L1 逐页读图）——**定理号是 §3.2 的「Теорема 3.1」，证明在 §4.2**

**获取途径（可复用，L1）**：Math-Net.Ru
`https://www.mathnet.ru/eng/faa1619`（元数据）→
`https://www.mathnet.ru/php/getFT.phtml?jrnid=faa&paperid=1619&what=fullt&option_lang=eng`
（WebFetch 落盘 2 MB **扫描图 PDF** → `Read pages` 逐页读图；**PDF 页 = 俄文刊页 − 46**）。
先用 `…/archive.phtml?jrnid=faa&wshow=issue&year=1982&volume=16&issue=2` 定位 `paperid=1619`（p. 47–63）。

**元数据（L2，Math-Net.Ru 页面）**：Б. Л. Фейгин, Д. Б. Фукс,
《Кососимметрические инвариантные дифференциальные операторы на прямой и модули Верма над алгеброй Вирасоро》,
Функц. анализ и его прил. **16**:2 (1982), 47–63；英译 Funct. Anal. Appl. **16**:2 (1982), **114–126**；
DOI 10.1007/BF01081626；MR **659165**；Zbl **0505.58031**；收稿 **15.09.1981**。
⚠ **俄文标题的词序是「Кососимметрические инвариантные…」（先「斜对称」后「不变」），
bib 里英文标题 "Invariant skew-symmetric…" 是英译本用法**，两者都能查到，不必改。

#### (a) 论文自述的结构（书上 p. 47，L1 逐字节选）

> «Основным результатом этой статьи является **теорема 1.1**, доставляющая полную классификацию
> кососимметрических дифференциальных операторов…»
> «Эта проблема приводимости **решена в 1979 г. Кацем [2]**, и с помощью его результатов удается
> доказать нашу основную теорему. Более того, … простые соображения, относящиеся к инвариантным
> операторам, позволяют дать **новое доказательство теоремы Каца**.»
> «В **§ 3** формулируется **теорема Каца**, и при помощи этой теоремы и результатов § 2 доказывается
> основная теорема. Заключительный **§ 4 содержит доказательство теоремы Каца**, а также
> упоминавшихся комбинаторных тождеств.»

**⇒ 三条对图直接有用的事实**：
1. 本文的**主定理是 Theorem 1.1（不变微分算子的分类），不是 Kac 行列式**；
2. **Kac 行列式在 §3 被陈述、在 §4 被证明**；现图里 `feigin-fuchs-1982` 的 `loc: "§2（完整证明）"` **是错的**
   （§2 讲的是「不变算子 ↔ 特殊向量」的辅助构造与主系统的渐近解）；
3. 作者自称给的是**「новое доказательство» = 一个新证明**，并把「可约性问题**已由 Kac 于 1979 年解决**」
   写在明处。**因此不宜把本文描述成「第一个完整证明」**——那是二手文献的说法，不是作者自称。

#### (b) ★ 定理原文（书上 **p. 58**，§3.2 «Теорема Каца»；L1 逐字）

引出句：«**Кацу удалось вычислить определитель матрицы** M_{h,c}(k). Вот его результат.»

> **Теорема 3.1 (см. [2]).**
>
> det² M_{h,c}(k) = C ∏_{i=1}^{k} ∏_{j|i} Φ_{j, i/j}(h, c)^{p(k−i)},
>
> Φ_{α,β}(h, c) = ( h + (1/24)(α²−1)(c−13) + (1/2)(αβ−1) ) ×
>                 ( h + (1/24)(β²−1)(c−13) + (1/2)(αβ−1) ) + (α²−β²)²/16,
>
> где **C — ненулевая константа**.
>
> **Следствие.** Для существования у модуля V_{h,c} особого вектора степени ≤ k необходимо и
> достаточно, чтобы для некоторых натуральных чисел k′, k″ с k′k″ ≤ k имело место равенство
> Φ_{k′,k″}(h, c) = 0.

**四条必须随引用一起写的注意事项**：
- **是 det²（行列式的平方），不是 det**。Φ_{α,β} 是**一对** (α,β) 与 (β,α) 的合并因子，
  故 ∏_{j|i} Φ_{j,i/j} = [∏_{j|i}(h − h_{j,i/j})]²，两边平方后与标准写法一致（验算见 §34.8）。
- **下标判读**：扫描件上 Φ 的第一个下标字形在 `i` 与 `j` 之间不易分辨；
  按 ∏_{j|i} 的求积变量以及 p. 62 同一式的重复出现，**只能是 Φ_{j, i/j}**（i = rs，j 跑遍 i 的因子）。
  这一处是**字形 L2 + 数学强制**，不是纯 L1。
- **C 只被断言「非零」，没有断言「正」**。图卡现在写的是「α_N 是…**正**常数」，
  **本轮找到的两个来源都不支持「正」**（Schottenloher 写的是 K_N ≥ 0，见 §34.3）。
- 前置定义（同页 §3.2，L1）：M_{h,c}(k) 是 Verma 模 V_{h,c} 的 k 次齐次分量（维数 p(k)）上，
  把 U(L₁⁻) 的 p(k) 个线性无关元 e_{−1}^k, e_{−1}^{k−2}e_{−2}, …, e_{−k} 作用到真空 v 上得到的基的 Gram 矩阵；
  正文逐字说「определяемая этой матрицей квадратичная форма называется **формой Шаповалова**」。
  **h, c 取任意复数**（p. 57 逐字：«Пусть h и c — два комплексных числа»）——
  这一点比 Schottenloher 的实 Hermite 版本更贴合图卡。

#### (c) 证明的位置（书上 **p. 62**，L1）

小节标题逐字：**«4.2. Доказательство теоремы 3.1.»**，证明用 §4.1 显式构造的特殊向量 ξ^k_{m,n}
（Предложение 4.1、4.2）+ §3 的 Предложение 3.2、3.3 + 归纳，末句：
«Таким образом, det² M_{h,c}(r) делится на ∏∏_{j|i} Φ_{j,i/j}(h,c)^{p(r−i)}，и очевидное вычисление
степеней показывает, что частное есть константа»。

#### (d) 参考文献（书上 **p. 63**，L1 逐字）——**这是 §34.1 的关键证据**

> 1. Фейгин Б. Л., Фукс Д. Б. Об инвариантных дифференциальных операторах на прямой. —
>    Функц. анализ, 1979, т. 13, вып. 4, с. 91–92.
> 2. **Kac V. G. Contravariant form for infinite-dimensional Lie algebras and superalgebras.
>    Lecture Notes Phys. V. 94, 1979, p. 441–445.**
> 3. Kac V. G., Peterson D. H. Spin and wedge representations of infinite-dimensional Lie algebras
>    and groups. — Proc. Nat. Acad. Sci. USA, 1981, v. 78, p. 3308–3312.
> 4. Гроэман Д. Я. Классификация билинейных инвариантных операторов на тензорных полях. —
>    Функц. анализ, 1980, т. 14, вып. 2, с. 58–59.
> 5. Гельфанд И. М., Фукс Д. Б. Когомологии алгебры Ли векторных полей на окружности. —
>    Функц. анализ, 1968, т. 2, вып. 4, с. 92–93.

⇒ **FF 的 [2] 就是 `kac-1979`（LNP 94），一字不差**；他们**没有**引 ICM 那篇。
（顺带：条目 5 与 bib 里 `gelfand-fuks-1968` 的元数据一致。）

#### (e) ⚠ 一处未裁决的印刷/判读问题

书上 **p. 59 首句**（紧接 Theorem 3.1 与其推论之后）渲染为：
«Насколько нам известно, доказательство **теоремы 2.1** не опубликовано. Мы приведем ее доказательство в § 4.»
（「据我们所知，定理 ?.1 的证明未曾发表。我们将在 §4 给出它的证明。」）

- **字形上读作 2.1**（同一页与 p. 61 上「теорему 3.1」「теорему 2.1」两种写法都出现，说明字形可分辨）；
- **但 §2 里根本没有「Теорема 2.1」**——只有 §2.4 的 **Предложение 2.1**（S̄_k 是代数曲线），
  而且它在原地就被证明了（«Предложение доказано.»，p. 54）；
- **§4 里唯一被证明的编号定理是 3.1**（§4.2 标题）。

⇒ 语义上这句只能指 **Теорема 3.1**（即：Kac 的证明未发表，我们补上），但**字面印的是 2.1**。
**图里不得引用这句作为「Kac 只宣布不证明」的证据**，直到有人核对英译本（Q26）。
可以安全引用的是 §34.2(a) 的三句（Kac 1979 解决了问题 / 我们给新证明 / §4 含 Kac 定理的证明）。

### 34.3 ★★★ 可公开获取的带编号来源：Schottenloher, LNP 759, **Ch. 6, Theorem 6.12**（L1 全章读图）

**获取途径**：作者本人 LMU 主页按章挂的 PDF，
`https://www.mathematik.uni-muenchen.de/~schotten/LNP-cft-pdf/06_978-3-540-68625-5_Ch06_23-08-08.pdf`
（落盘 302 KB → `Read pages` 读图；**PDF 页 = 书页 − 86**）。
页脚逐字：「Schottenloher, M.: *Representation Theory of the Virasoro Algebra*. Lect. Notes Phys. **759, 91–102** (2008)
DOI 10.1007/978-3-540-68628-6**_7**」——**又一次「章号 6 / DOI 后缀 _7」错位**，与 §11、§29 记录的模式一致，
`loc` 请写「Ch. 6, LNP 759, pp. 91–102」，不要用 DOI 后缀推章号。

章内结构（L1）：§6.1 Unitary and Highest-Weight Representations (p. 91)、**§6.2 Verma Modules (p. 92)**、
**§6.3 The Kac Determinant (p. 95)**、§6.4 Indecomposability and Irreducibility (p. 99)、
§6.5 Projective Representations of Diff₊(𝕊) (p. 100)、References (p. 102)。
章首第一句逐字：「Most of the results in this chapter can be found in **[Kac80]**.」

**可引编号（均 L1 逐字）**：

- **Theorem 6.8, p. 96**（Hermite 形式的存在唯一性 = 图卡里「由 L_n^† = L_{−n} 与 ⟨h|h⟩ = 1 定义」那句）：
  > Let h, c ∈ ℝ and M = M(c,h).
  > 1. H : M × M → ℂ is the unique hermitian form satisfying H(v₀,v₀) = 1, as well as
  >    H(L_n v, w) = H(v, L_{−n} w) and H(Zv,w) = H(v,Zw) for all v,w ∈ M and n ∈ ℤ.
  > 2. H(v,w) = 0 for v ∈ V_N, w ∈ V_M with N ≠ M, that is the eigenspaces of L₀ are pairwise orthogonal.
  > 3. ker H is the maximal proper submodule of M.
- **Definition 6.11, p. 97**：「Let P(N) := dim_ℂ V_N and {b₁,…,b_{P(N)}} be a basis of V_N.
  We define matrices A^N by A^N_{ij} := H(b_i,b_j) for i,j ∈ {1,…,P(N)}.」
- **★★ Theorem 6.12, p. 98**（**本轮为本节点找到的最贴切的带编号来源**）逐字：
  > **Theorem 6.12. [Kac80]** *The Kac determinant* det A^N *depends on* (c,h) *as follows:*
  >
  > det A^N(c,h) = K_N ∏_{p,q ∈ ℕ, pq ≤ N} (h − h_{p,q}(c))^{P(N−pq)},
  >
  > *where* **K_N ≥ 0** *is a constant which does not depend on* (c,h), *the* P(M) *is as in Definition 6.11, and*
  >
  > h_{p,q}(c) := (1/48)( (13 − c)(p² + q²) + √((c−1)(c−25)) (p² − q²) − 24pq − 2 + 2c ).
  >
  > 紧接一句：「**A proof can be found in [KR87] or [CdG94], for example.**」
- **Corollary 6.10, p. 97**（H 半正定 ⇒ c ≥ 0 且 h ≥ 0）；**Remark 6.9, p. 97**（M/ker H 上 H 非退化但不定）；
  **Theorem 6.13, p. 98–99**（酉性完全分类，第 2 条给出 **minimal model 参数化**：
  c(m) := 1 − 6/(m(m+1))，h_{p,q}(m) := (((m+1)p − mq)² − 1)/(4m(m+1))，1 ≤ p ≤ q < m）；
  **Theorem 6.17, p. 100**（Verma 模不可分解 / 商模不可约）。
- **章末参考文献（p. 102，L1 逐字，与 §34.1 直接相关）**：
  > [Kac80] V. Kac. Highest weight representations of infinite dimensional Lie algebras. In: *Proc.
  >         Intern. Congress Helsinki*, Acad. Sci. Fenn., 299–304, 1980.
  > [KR87]  V. Kac and A.K. Raina. *Highest Weight Representations of Infinite Dimensional Lie
  >         Algebras*. World Scientific, Singapore, 1987.
  > [CdG94] F. Constantinescu and H.F. de Groote. *Geometrische und Algebraische Methoden der
  >         Physik: Supermannigfaltigkeiten und Virasoro-Algebren*. Teubner, Stuttgart, 1994.
  > [FQS86] D. Friedan, Z. Qiu, S. Shenker. Details of the nonunitary proof for highest weight
  >         representations of the Virasoro algebra. *Comm. Math. Phys.* **107** (1986), 535–542.
  > [GKO86] P. Goddard, A. Kent, D. Olive. Unitary representations of the Virasoro and
  >         Super-Virasoro algebras. *Comm. Math. Phys.* **103** (1986), 105–119.

**⚠ 引用 Theorem 6.12 必须同时写清的三条限制**：
1. **实数限制**：Theorem 6.8 起整段假设 **c, h ∈ ℝ**，A^N 是 **Hermite** 形式的 Gram 矩阵；
   图卡若要覆盖复 (c,h) 的双线性 Shapovalov 形式，**该限制要么写进 note，要么改引 FF Theorem 3.1**（那边是 ℂ）。
2. **常数**：书上写 **K_N ≥ 0**，**没有**写 > 0。
3. **归属**：本书把这条定理归给 **[Kac80] = ICM Helsinki**，并把**证明外包给 [KR87] / [CdG94]**，
   **全章没有引 Feigin–Fuchs**。所以「Kac 陈述 + FF 证明」这条历史线**不是 Schottenloher 的说法**。

### 34.4 物理侧标准转述：Di Francesco–Mathieu–Sénéchal —— **是 §7.2，不是任务书说的 §7.3.2**

- Google Books 卷 `keUrdME5rhIC`（*Conformal Field Theory*, Springer 1997）：
  `"Kac determinant"` → **p. 205**；`"Unitarity and the Kac Determinant"` → **p. 205**；
  **控制查询** `"qxzptvv wrrglmn"` → 无命中（只回封面）⇒ **控制通过**（L4 带控制）。
- 检索后端读到的章节结构（L4，未逐页核实）：**Ch. 7「Minimal Models I」**；
  §7.1 Verma Modules (p. 200)；**§7.2 The Kac Determinant (p. 205)**；§7.2.1 Unitarity and the Kac Determinant (p. 205)；
  §7.2.2 Unitarity of c > 1 Representations (p. 209)；§7.2.3 Unitary c < 1 Representations；§7.3 = minimal models 本体。
- ⇒ **任务书里的「§7.3.2」与此不符**；本轮**没有任何证据支持 §7.3.2**。
- **公式号（如常被转引的 (7.30)）本轮完全未核实（L0），不得写进图。**
- 结论：DMS 只能作**旁证**，`loc` 最多写「§7.2 The Kac Determinant, p. 205（L4，公式号未核实）」，
  而且**不必写**——`schottenloher-2008` 已经提供了更强的同类来源。
  （注：检索结果里有一个 `scispace.com` 的全本 PDF；**按 literature/CLAUDE.md 规则 1 未使用**，
  是否可用留给 lead 裁决，与 §28.1 的 Weibel 全本问题同类。）

### 34.5 Iohara–Koga, *Representation Theory of the Virasoro Algebra* (2011)：**Chapter 4 = 「Determinant Formulae」，编号仍 L0**

- 章标识（L2/L3）：Iohara, K., Koga, Y. (2011). **"Determinant Formulae"**, in *Representation Theory of
  the Virasoro Algebra*, Springer Monographs in Mathematics, **DOI 10.1007/978-0-85729-160-8_4**。
  章序（L4）：1 Preliminary → 2 Classification of Harish-Chandra Modules → 3 The Jantzen Filtration →
  **4 Determinant Formulae** → 5 Verma Modules I: Preliminaries。
- Springer 官方章摘要（L4，检索后端转述 Springer 页面，**未逐字核实**）：
  「The Kac determinant formula for Verma modules over Vir is given together with its proof **in the
  language of vertex algebras**, a result that is crucial for the analysis of Verma modules in Chapters 5 and 6.
  The chapter also provides determinant formulae for the Vir-module maps from a Verma module to the Fock
  module … and from a Fock module to the contragredient dual of the Verma module …」
- **访问全部失败**：`link.springer.com/chapter/…_4` 与 `…/book/…` 一律 303 → `idp.springer.com/authorize`；
  Google Books 该卷**无预览**（`vid=ISBN9780857291592` + `"Kac determinant"` → 无结果页，非「无命中」）。
- ⇒ **「Theorem 4.1」这类编号一个字都不许写**。这本书仍是**主题最对口**的候选（也是 Kytölä 的 [IK10]），
  留待能进 Springer 的人核对（Q28），与 §30.3 的 Q19 是同一本书、同一堵墙。

### 34.6 Kac–Raina *Bombay Lectures*：本轮唯一新增的是「它被当作证明出处」这一事实

- **L1 新证据**：Schottenloher Theorem 6.12 后一句把证明外包给 **[KR87]**（= `kac-raina-1987` 第 1 版）与 [CdG94]。
  这是图里第一次有 L1 来源把 Kac–Raina 与**Kac 行列式的证明**挂钩。
- 但**书内讲号/命题号仍未核实**，且 `sources.bib` 的**版本陷阱**（第 1 版约 12 讲 / 2013 第 2 版 18 讲，编号不可互换）依旧。
  ⇒ `loc` **只能写主题**（「Kac 行列式的证明」），**不得写 Lecture / Theorem 号**。本轮没有新增第 2 版的 key。

### 34.7 形式化状态：**Kytölä 的 VirasoroProject 没有 Shapovalov 形式，也没有 Kac 行列式**（三条独立证据，L1）

1. **Lean 文件清单**（`github.com/kkytola/VirasoroProject/tree/master/VirasoroProject`，2026-09-11 读取）：
   21 个 `.lean` 文件——CentralChargeCalc / CentralExtension / Commutator / CyclicTripleSum / FockSpace /
   FockSpaceSugawara / HeisenbergAlgebra / IndexTri / IsCentralExtension / LieAlgebraModuleUEA /
   LieAlgebraRepresentationOfBasis / LieCohomologySmallDegree / **LieVerma** / SectionSES / Sugawara /
   **VermaModule** / VirasoroAlgebra / VirasoroCocycle / **VirasoroVerma** / WittAlgebra / WittAlgebraCohomology。
   **没有 ShapovalovForm.lean、没有 KacDeterminant.lean、没有 SingularVector.lean。**
2. **arXiv:2510.21741 的 Table 1（书上 p. 2，L1）**「Main objects and results formalized and discussed in this report」
   共 7 行：中心扩张 (Def 3.1)、2 次李代数上同调 (Def 4.3)、Virasoro 代数 (Def 8.1)、Heisenberg (Sec 9)、
   **Verma 模 (Def 12.2)**、Witt 的 H² 计算 (Thm 6.2)、Sugawara (Thm 10.1)、Verma→charged Fock 的模映射 (Thm 12.7)。
   **没有逆变形式 / 行列式。**
3. **§14 "Conclusions and outlook"（书上 p. 12，L1 逐字）**：
   > For Virasoro algebra representation theory, a significant project could aim at a formal proof of the
   > **Feigin–Fuks structure theorem for Verma modules over the Virasoro algebra [FF84, VZ90, IK10]**,
   > which is foundational to numerous topics in conformal field theory.
   同段前一句还写「Highest weight representation theory of Lie algebras … is likely a major undertaking,
   **starting from the missing Poincaré–Birkhoff–Witt theorem**」。
   其参考文献（书上 p. 13，L1）：**[FF84]** B. L. Feigin and D. B. Fuks. *Verma modules over the Virasoro algebra*.
   Functional Analysis and Its Applications, **17(3):241–242, 1984**；**[VZ90]** Vershik–Zhelobenko (eds.),
   *Representation of Lie groups and related topics*, Adv. Stud. Contemp. Math. 7, Gordon and Breach, 1990；
   **[IK10]** Iohara–Koga (2010)。

**⇒ 对图的硬约束**：`worldsheet.kac-determinant` **不能标 `formalized`**，上限是 `rigorous`；
理由与 `math.verma-module-free-over-negative-part` 同源（Mathlib 无 PBW，见 §16.4），
而且这里还多一层：**连 Shapovalov 形式本身都没有被形式化**。

### 34.8 三种参数化对照（+ 我自己做的一致性验算，**这一小节是推断，不是来源原文**）

| 来源 | 参数化写法 | 等级 |
|---|---|---|
| **Schottenloher Thm 6.12** | 直接用 c：h_{p,q}(c) = (1/48)[(13−c)(p²+q²) + √((c−1)(c−25))(p²−q²) − 24pq − 2 + 2c] | L1 |
| **Feigin–Fuchs Thm 3.1** | **不出现 h_{r,s}**，用无根号的成对多项式 Φ_{α,β}(h,c)（见 §34.2(b)） | L1 |
| **Schottenloher Thm 6.13.2 / 物理书** | c(m) = 1 − 6/(m(m+1))，h_{p,q}(m) = (((m+1)p − mq)² − 1)/(4m(m+1)) | L1（Schottenloher 那半） |
| **c = 13 − 6(t + 1/t)** 型（任务书提到的另一种） | **本轮在任何已核实来源里都没见到**；Kac–Raina / Iohara–Koga 可能用它，但都没拿到正文 | **L0** |

**我做的三次数值验算（researcher 推断）**，用来确认三种写法互相自洽、可以放进同一张卡：
- Schottenloher 的 h_{p,q}(c) 在 c = 1 时给 (p−q)²/4；FF 的 Φ_{2,1}(h,1) = (h − 1/4)²。✓ 一致。
- c = 1/2（m = 3）：Schottenloher 给 h_{2,1} = 1/2、h_{1,2} = 1/16，与 Thm 6.13.2 的 minimal-model 公式一致；
  FF 的 Φ_{2,1}(h, 1/2) 展开 = h² − 0.5625h + 0.03125 = (h − 1/2)(h − 1/16)。✓ 一致。
- 由此 **Φ_{α,β}(h,c) = (h − h_{α,β}(c))(h − h_{β,α}(c))**，且 FF 的 det² 形式与
  det M_N = α_N ∏_{rs≤N}(h − h_{r,s})^{p(N−rs)} 逐项平方后完全吻合。✓
  （**平方根分支约定**：c < 1 时取 √((c−1)(c−25)) > 0，验算即按此。）

### 34.9 图里建议怎么引（供 curator 取舍；researcher 不改 `graph/`）

**A. `worldsheet.kac-determinant`（statement）的 `sources` 建议改成：**

```yaml
sources:
  - ref: schottenloher-2008
    loc: "Ch. 6 §6.3, Theorem 6.12, p. 98（LNP 759, pp. 91-102）；Gram 矩阵定义 Definition 6.11, p. 97；Hermite 形式的唯一性 Theorem 6.8, p. 96"
    note: "L1 逐页核实（math-sources.md §34.3）。三点限制：(a) 该处假设 c,h ∈ R、A^N 是 Hermite 形式的 Gram 矩阵，不是复 (c,h) 的双线性 Shapovalov 形式；(b) 书上写 K_N >= 0，没有写 > 0；(c) 该书把定理归给 [Kac80] = ICM Helsinki 那篇，且把证明外包给 [KR87]/[CdG94]，全章不引 Feigin-Fuchs。"
  - ref: feigin-fuchs-1982
    loc: "§3.2 «Теорема Каца», Теорема 3.1（俄文原刊 Функц. анализ 16:2 (1982), 第 58 页）"
    note: "L1 逐页核实（math-sources.md §34.2）。原文形式是 det^2 M_{h,c}(k) = C * prod_{i<=k} prod_{j|i} Phi_{j,i/j}(h,c)^{p(k-i)}，Phi 是 (h-h_{a,b})(h-h_{b,a}) 的无根号展开；C 只被断言『非零』。h,c 取任意复数。英译本 Funct. Anal. Appl. 16 (1982) 114-126 的编号与页码未核实。"
  - ref: kac-1979
    loc: "pp. 441-445（内部编号未核实，不得写 Theorem 1）"
    note: "Feigin-Fuchs 1982 的参考文献 [2] 逐字就是本条，Теорема 3.1 标注 (см. [2])。正文未获取。"
```
**⚠ 同时给 auditor 的一条**：卡面 statement 现在写「α_N 是与 (c,h) 无关的**正**常数」。
**「正」在本轮两个来源里都无据**（FF：非零；Schottenloher：≥ 0）。
按「状态只能实话实说」，要么在 statement 里改成「非零常数」（那是**新建节点 + superseded_by**），
要么在 note 里写明「正性未由所引来源支持」。**我不替 curator 做这个决定。**

**B. `worldsheet.kac-determinant--via-feigin-fuchs`（derivation）建议：**
- `feigin-fuchs-1982` 的 `loc` 由 `"§2（完整证明）"` 改为 **`"§3.2 Теорема 3.1（陈述）+ §4.2 «Доказательство теоремы 3.1»（证明，俄文原刊第 62 页）"`**；
- `kac-1979` 的 `loc` 去掉 `"Theorem 1（陈述与证明概要）"`，改为 `"pp. 441-445（编号未核实）"`；
- `summary` 里「数学界接受为定理」可保留，但**「Kac 给出公式并概述证明」无据**——
  FF 原文只说「Кацу удалось вычислить определитель…」（Kac 算出了这个行列式），
  且 FF 自称提供的是**新证明**，同时把「可约性问题已由 Kac 1979 解决」写在明处（§34.2(a)）。
- 若要引 ICM 那篇，**必须用新 key `kac-1980-icm`**，不要复用 `kac-1979`。

**C. 状态**：本节点上限 `rigorous`（§34.7）；`formalized` 现在**不可能**。

### 34.10 访问日志与未解决问题（本节）

| 目标 | URL / 手法 | 结果 |
|---|---|---|
| **Kac 本人出版目录** | `math.mit.edu/~kac/publications.pdf` | **成功**（落盘 159 KB → 读图 p.1–3；#30/#31/#32 三条逐字） |
| **Feigin–Fuchs 1982 俄文全文** | `mathnet.ru/php/getFT.phtml?jrnid=faa&paperid=1619&what=fullt` | **成功**（落盘 2 MB 扫描 PDF，17 页读完 p.47–63；**PDF 页 = 刊页 − 46**） |
| Math-Net.Ru 期号定位 | `…/archive.phtml?jrnid=faa&wshow=issue&year=1982&volume=16&issue=2` | 成功（**俄文页面回来是乱码**，但 `paperid` 与页码可用；英文页 `mathnet.ru/eng/faa1619` 正常） |
| **Schottenloher Ch. 6** | `…/~schotten/LNP-cft-pdf/06_978-3-540-68625-5_Ch06_23-08-08.pdf` | **成功**（落盘 302 KB，全章 12 页读完；**PDF 页 = 书页 − 86**） |
| **Kytölä arXiv:2510.21741** | `arxiv.org/pdf/2510.21741` | **成功**（落盘 1.2 MB；读 p.2–3、12–13、14–16） |
| Kytölä Lean 仓库目录 | `github.com/kkytola/VirasoroProject/tree/master/VirasoroProject` | 成功（21 个 .lean 文件名） |
| DMS 页码定位 | Google Books `books.google.com/books?id=keUrdME5rhIC&q=…` | 成功（p. 205；**控制查询无命中 ⇒ 控制通过**） |
| Kac LNP 94 正文 | `link.springer.com/chapter/10.1007/3-540-09238-2_102` | **失败：303 → `idp.springer.com/authorize`** |
| Kac LNP 94 纸本 | archive.org `title:(group theoretical methods in physics)` | **失败**：只有 Montreal 1976 / Cocoyoc 1980 / Trieste 1983 三卷，**没有 Austin 1978（LNP 94）那卷** |
| **ICM 1978 Helsinki Vol. 1 正文** | `mathunion.org/fileadmin/ICM/Proceedings/ICM1978.1/ICM1978.1.ocr.pdf` | **失败：30 MB，`maxContentLength size of 10485760 exceeded`** |
| ICM 1978 Vol. 1（archive.org 两个副本） | `proceedingsofint0001inte_c4t9` / `…_n1u1` | 元数据可读；**`fulltext/inside.php` 与 `_djvu.txt` 均 403**（借阅限制项，与 GS 1984 那本公开重印集不同） |
| Iohara–Koga Ch. 4 | `link.springer.com/chapter/…_4`；Google Books `vid=ISBN9780857291592` | **双失败**（认证墙 / 无预览） |
| zbMATH 查询页 | `zbmath.org/?q=…` | **失败：403**（**新增死路**） |
| MathSciNet MR Lookup | `mathscinet.ams.org/mrlookup?au=…&ti=…` | **失败**：`ti=` 参数无效，只回搜索表单或无关的 Kac 条目；**不要再试** |
| Springer 章 PDF 直链 | `link.springer.com/content/pdf/10.1007/978-1-4757-0363-4_3.pdf` | **失败：303 → 认证墙**（`content/pdf/` 也不例外） |
| ouci.dntb.gov.ua | `ouci.dntb.gov.ua/en/?s=<DOI>` | 失败（只回首页，未命中记录） |

> **新增活路**：**Math-Net.Ru 是俄文老论文的稳定入口**——`…/php/getFT.phtml?jrnid=<刊>&paperid=<id>&what=fullt`
> 直接给整篇扫描 PDF，落盘后 `Read pages` 读图即可（本轮 17 页公式全部可判读）。
> 期号页用 `…/php/archive.phtml?jrnid=<刊>&wshow=issue&year=&volume=&issue=` 定位 `paperid`。
> **新增死路**：zbMATH 查询页 403；`mathscinet.ams.org/mrlookup` 的 `ti=` 无效；
> archive.org 的**借阅限制卷**（`fulltext/inside.php`、`_djvu.txt` 一律 403）——
> 与 `reference_archive-org-reprint-fulltext-route` 记的公开重印集不是一回事，**先看该项是否 lending-restricted**。

**未解决 / 留给下一轮：**

- **Q23** **Kac, LNP 94 (1979), 441–445 的正文与内部编号（L0）。** 图里现写的 `Theorem 1` **无任何证据**。
  Springer 认证墙 + archive.org 无此卷。可能的下一招：找一篇**逐字引用了它的定理号**的论文，
  或找 LNP 94 的**重印/图书馆扫描**（该卷 = *Group Theoretical Methods in Physics*, Austin 1978,
  eds. Beiglböck–Böhm–Takasugi，DOI 10.1007/3-540-09238-2_102）。
- **Q24** **ICM Helsinki 1978 (299–304) 的正文（L0）：它到底含不含 Virasoro 的行列式公式？**
  这一条决定 Schottenloher 的 [Kac80] 归属是否准确，也决定 FGZ ref 10 的解释。
  IMU 官方 PDF 30 MB 超上限——**需要一个能分页取 PDF 的手段**（lead 若有 Bash/curl 可直接切页）。
- **Q25** **FF 1982 英译本（Funct. Anal. Appl. 16 (1982) 114–126）的编号与页码。**
  按俄文 p.47–63 ↔ 英译 p.114–126 的线性换算，Theorem 3.1 约在英译 **p. 122**（**未核实，别写进图**）。
  Springer BF01081626 在认证墙后。
- **Q26** **FF 1982 俄文 p. 59 首句的定理号究竟是 2.1 还是 3.1**（§34.2(e)）。
  这句是「Kac 未发表证明」的唯一直接候选证据，值得钉死。
- **Q27** DMS *Conformal Field Theory* 里 Kac 行列式的**公式号**（L0）与 §7.2 的**逐页确认**。
- **Q28** Iohara–Koga **Chapter 4「Determinant Formulae」的定理编号**（L0）——与 §30.3 的 Q19 同一堵墙。
- **Q29** `sources.bib` 里 **`schottenloher-2008` 条目的花括号失衡**（`note = {…}` 在原第 457 行就闭合，
  其后到 481 行是游离文本，最后多一个 `}`）。**本轮我把第 6 章的补充追加进了最后那段游离文本内部，
  没有改动括号结构**（避免与别的 agent 冲突）。**建议 lead 单独修一次**。

---
---

# § 紧曲面分类定理 + RP₂/圆盘的 CKV 与模

## 39. 为 `positive-euler-number-no-moduli--via-surface-enumeration` 的两个缺口找带编号来源（researcher，2026-09-11）

- 触发：`graph/derivations/worldsheet/positive-euler-number-no-moduli--via-surface-enumeration.yaml`
  的 `gaps` 第 2、3 条：「**输入 (1)（曲面分类定理）在本图中无节点、无数学来源**」、
  「**RP₂ 的 μ = 0 则连节点都缺**」。
- 证据等级沿用 §0。
- ⚠ **本轮最大的意外收获与任务书的预设相反**：我用 [[reference_cambridge-core-licensed-book-pdfs]] 的路线
  取到了 Polchinski Vol.1 **第 5 章与第 6 章的原书页图**，结果是——
  **原书自己就给了 χ > 0 ⇒ μ = 0 的直接论证（不是枚举），也自己逐字给了 RP₂ 与圆盘的 CKG。**
  所以该推导的 `gaps` 里有**两条已经作废、一条需要改写**（见 §39.8）。

### 39.0 结论表（先看这张）

| 问题 | 结论 | 最佳来源与编号 | 等级 |
|---|---|---|---|
| **(A) 紧曲面分类（含带边、含不可定向）** | ✅ 有带编号定理 | **Gallier–Xu (2013), Theorem 6.2**（书上 p.97） | **L1** |
| (A) 配套：χ = 2−2p−q / 2−p−q | ⚠ **有公式、无编号** | 同书 p.89–90 行间式（Definition 6.5 之后） | L1 |
| (A) 「χ>0 只剩 S²、D²、RP²」 | ❌ **任何来源都没有这条现成陈述** | 由 Def 6.5 + χ 公式**两行算术**导出（本文件 §39.2(e)，**是我的补步**） | — |
| (A) 第二来源 Massey | ⚠ **Theorem 5.1 有 L1 旁证；带边那条定理号 L0** | Massey (1967) Ch. I §5/§7/§10/§11（目录 L1） | L1/L0 |
| (A) Munkres §77 | ❌ **不对口**：只讲闭曲面、不出现 Euler 数 | Theorem 77.5（第三方逐字转引） | L2 |
| (A) Hatcher §1.2 | ❌ **根本没有分类定理**（有编号的没有，无编号的也没有） | §1.2 末只有 Prop 1.26 / Cor 1.27 / Cor 1.28 / Ex 1.29 | **L1** |
| **(B) RP₂：μ = 0、κ = 3、CKG = SO(3)** | ✅ **Polchinski 原书逐字有** | **Polchinski §6.1「The projective plane」，书上 p.168–169，(6.1.9) 附近，无式号** | **L1** |
| (B) 圆盘：μ = 0、CKG = PSL(2,R) | ✅ **Polchinski 原书逐字有，且有两处** | **§6.1「The disk」p.168（(6.1.8) 之后）** 与 **§6.4 开头 p.178**，均无式号 | **L1** |
| (B) κ = 3 这个**数字** | ✅ 由原书 **(5.2.11a) κ = 3χ** + χ = 1 得到 | Polchinski (5.2.11a)，书上 p.152 | **L1** |
| (B) 数学侧：Aut(D) | ⚠ 分成两条、合成后无单一编号 | **Miličić Theorem 1.7.3**（Aut(D)≅SU(1,1)/{±I}）+ §1.9 无编号句（SL(2,R)≅SU(1,1)） | **L1** |
| (B) 数学侧：Aut(P¹) = PSL(2,C) | ✅ | **Miličić Theorem 1.5.2** | **L1** |
| (B) 数学侧：Aut(RP²) = 球面旋转群 | ✅ 有编号，但期刊层级低、证明外包 | **Cao-Huu–Ghişa, arXiv:0902.2725, Corollary 3.1** | **L1** |
| (B) 「球面旋转群 = SO(3)、实维 3」 | ❌ 上面那条推论里**没有**这句 | — | — |

---

### 39.1 需求侧：这条推导到底缺什么

推导 `--via-surface-enumeration` 的 `summary` 把论证拆成两步：

1. **曲面分类**：χ = 2 − 2g − b − c，χ > 0 只允许 S₂、D₂、RP₂；
2. **三个曲面各自 μ = 0**。

本轮要找的就是 (1) 的数学来源、(2) 里 RP₂ 那一支的来源。
**但读完原书之后，问题的形状变了**：原书根本不是这么论证的（§39.6），
枚举路线是本图补写的。所以下面同时给出**两条路线各自的来源**，
并在 §39.8 建议 curator 把它们拆成两条并列的 derivation。

---

### 39.2 ★★ (A) 首选来源：Gallier & Xu, *A Guide to the Classification Theorem for Compact Surfaces*（L1 全章读图）

#### 39.2.0 版本陷阱（必读，与 [[gui-2023-lectures]] 那次同类）

同一批内容有**两个编号互不相同的公开版本**：

| | 文件 | 章节 | 分类定理编号 |
|---|---|---|---|
| **出版版**（Springer GTC 9, 2013） | `cis.upenn.edu/~jean/surfclassif-root.pdf`（标题页日期 **January 8, 2025**，页脚 "Philadelphia, September 2012"） | **Ch. 6** | **Theorem 6.2** |
| **arXiv 早期版**（单作者，2008） | `arxiv.org/pdf/0805.0562`（v1） | Ch. 5 | Theorem 5.3.2 |

**编号交叉表（本轮逐条对照，L1）**：

| 出版版 | arXiv 版 | 内容 |
|---|---|---|
| Lemma 6.1 | Lemma 5.2.5 | 每个胞腔复形等价于某个规范胞腔复形 |
| Proposition 6.1 | Proposition 5.2.2 | 每个胞腔复形可细分为三角化 2-复形 |
| Definition 6.4 | Definition 5.2.3 | 定向 / contour |
| **Definition 6.5** | **Definition 5.2.4** | **规范胞腔复形 type (I)/(II)** |
| **Theorem 6.1** | **Theorem 5.3.1** | 三角化版分类定理（含带边） |
| **Theorem 6.2** | **Theorem 5.3.2** | **紧曲面版分类定理（含带边）** |
| Theorem 6.3 | Theorem 5.3.4 | 连通和形式（闭曲面） |
| Definition 6.6 | Definition 5.3.3 | 连通和 |

⚠ **另有一个 28 页的截断文件**：`cis.upenn.edu/~jean/surfclass-n.pdf` 与镜像
`cs.brynmawr.edu/~dxu/surfclassif.pdf` 两次下载都只回来 2.7 MB / **28 页**（只到第 1 章），
其目录显示的是**第三套编号**（Ch. 6 同出版版，但 Appendix B 叫「Proof of Proposition 5.1」）。
**不要用这两个 URL 取正文。**

#### 39.2.1 ★★★ **Theorem 6.2**（书上 **p.97**，L1 逐字）——这就是图里要的那条

> **Theorem 6.2.** *Two compact surfaces or compact surfaces with boundary are homeomorphic iff
> they agree in character of orientability, number of contours, and Euler–Poincaré characteristic.*

同页上方的三角化版：

> **Theorem 6.1.** *Two (two-dimensional) compact polyhedra or compact polyhedra with boundary
> (triangulated compact surfaces with or without boundary) are homeomorphic iff they agree in
> character of orientability, number of contours, and Euler–Poincaré characteristic.*

Theorem 6.1 与 6.2 之间（p.96 末）作者自陈缺口，**必须随引用一起写**：

> "In order to finally get a version of Theorem 6.1 for compact surfaces or compact surfaces with
> boundary (not necessarily triangulated), it is necessary to prove that every surface and every
> surface with boundary can be triangulated. As we said in Section 1.1, this is indeed true, but the
> proof is far from trivial. … We will present Carsten Thomassen's proof, which we consider to be
> the most easily accessible, in Appendix E."

→ **Theorem 6.2 依赖「每个曲面可三角化」（Radó），该证明在 Appendix E，不在正文**。
本项目若要 `rigorous`，这条依赖必须显式建边或至少写进 note。

#### 39.2.2 **Definition 6.5**（书上 **p.88–89**，L1 逐字）——枚举的参数范围就藏在这里

> **Definition 6.5.** A *cell complex in normal form, or canonical cell complex* is a cell complex,
> K = (F, E, B), where F = {A} is a singleton set, and either
> (I) E = {a₁,…,a_p, b₁,…,b_p, c₁,…,c_q, h₁,…,h_q} and
>   B(A) = a₁b₁a₁⁻¹b₁⁻¹ ⋯ a_p b_p a_p⁻¹ b_p⁻¹ c₁h₁c₁⁻¹ ⋯ c_q h_q c_q⁻¹,
>   **where p ≥ 0, q ≥ 0**, or
> (II) E = {a₁,…,a_p, c₁,…,c_q, h₁,…,h_q} and
>   B(A) = a₁a₁ ⋯ a_p a_p c₁h₁c₁⁻¹ ⋯ c_q h_q c_q⁻¹,
>   **where p ≥ 1, q ≥ 0**.

紧接着（p.89，L1 逐字）：

> "Observe that canonical complexes of type (I) are orientable, whereas canonical complexes of type (II)
> are not. The sequences c_i h_i c_i⁻¹ yield q boundary vertices, (h_i, c_i, h_i⁻¹), and thus **q contours** (h_i) …"

#### 39.2.3 χ 公式（书上 **p.89–90**）——**⚠ 无编号，只能引页码**

> "Thus, in case (I), there are q+1 vertices, 2p+2q sides, and one face, and the Euler–Poincaré
> characteristic is q+1−(2p+2q)+1 = 2−2p−q, that is,
>   **χ(K) = 2 − 2p − q**,
> and in case (II), there are q+1 vertices, p+2q sides, and one face, and the Euler–Poincaré
> characteristic is q+1−(p+2q)+1 = 2−p−q, that is,
>   **χ(K) = 2 − p − q**.
> Note that when p = q = 0, we do get χ(K) = 2, which agrees with the fact that in this case, we assumed
> the existence of a null vertex and there is one face. **This is the case of the sphere.**"

同书 p.103（§6.6，同样**无编号**）给出等价的属数形式：

> "In terms of the Euler–Poincaré characteristic, for an orientable surface, the genus g is given by the formula
>   g = (2 − χ − q)/2,
> and for a nonorientable surface, the genus g is given by the formula
>   g = 2 − χ − q,
> **where q is the number of contours.**"

→ 即 **χ = 2 − 2g − q（可定向）**、**χ = 2 − g − q（不可定向）**。
**这正是推导 `summary` 里那条「χ = 2 − 2g − b − c」的正确写法**——注意原书用**一个**属数 g
覆盖两种情形（不可定向时 g 数的是交叉帽/射影平面个数），**不是**「2 − 2g − b − c」那种把
handles 与 crosscaps 并列相加的四参数写法。**推导 summary 里那条公式的形式在本轮找到的任何来源里都没有出现，
建议 curator 改写成上面两条之一。**

#### 39.2.4 本书对三个目标曲面的身份认定（L1 逐字，散落）

- **球面**：p.89–90「Note that when p = q = 0, we do get χ(K) = 2 … This is the case of the sphere.」
- **圆盘**：p.102（§6.6）「there are only two kinds of complexes having a trivial group, namely, for orientable
  complexes for which p = q = 0, or **p = 0 and q = 1**. The corresponding surfaces (with boundary) are a
  *sphere* and a *closed disk* (a surface with boundary).」
- **射影平面**：p.90「If a canonical cell complex has the boundary, B(A) = a₁a₁, we can think of the face A as a
  circular disk whose boundary is divided into two semi-circles both labeled a₁. … it is homeomorphic to the
  projective plane.」（即 type (II)、p = 1、q = 0）
- **莫比乌斯带**（最近的落选者）：p.102「in the nonorientable case when p = 1 and q = 0, a *projective plane*,
  or **p = 1 and q = 1, a *Möbius strip***.」→ χ = 2−1−1 = **0**，正好被 χ > 0 排除。

#### 39.2.5 ★ (e) 「χ > 0 ⇒ 恰好三种」这一步：**没有任何来源写过，是我的补步**

把 Definition 6.5 的参数范围代进 §39.2.3 的两条公式：

- type (I)（可定向）：`2 − 2p − q > 0`，`p ≥ 0, q ≥ 0` ⟹ `(p,q) = (0,0)` 或 `(0,1)`
  ⟹ **χ = 2 的球面**、**χ = 1 的圆盘**（身份认定见 §39.2.4）。
- type (II)（不可定向）：`2 − p − q > 0`，`p ≥ 1, q ≥ 0` ⟹ `(p,q) = (1,0)`
  ⟹ **χ = 1 的射影平面**。

再由 **Theorem 6.2**（同不定向性 + 同 contour 数 + 同 χ ⟹ 同胚）知这三者两两不同胚且穷尽。

⚠ **诚实记录**：这三行是**纯算术**，但**书上没有这段话**，也没有任何「χ > 0」的讨论。
按本项目规矩，把它写进图时要么标 `inferred: true`，要么在 derivation 的 `summary` 里
明写「不等式求解这一步由本图完成，来源只提供 Definition 6.5 的参数范围与 χ 公式」。

---

### 39.3 (A) 第二来源：Massey —— **目录 L1，定理号只有一条有旁证**

**已获取**：`Algebraic Topology: An Introduction`, William S. Massey, Harcourt, Brace & World, 1967
的**目录扫描页**（`external.dandelon.com/download/attachments/dandelon/ids/DE00420A6F9CE221E6E38C12579A000352287.pdf`，
6 页，L1 读图）。**正文未获取。**

Chapter One「Two-Dimensional Manifolds」目录逐字（L1）：

| § | 标题 | 页 |
|---|---|---|
| 1 | Introduction | 1 |
| 2 | Definition and examples of n-manifolds | 2 |
| 3 | Orientable vs. nonorientable manifolds | 3 |
| 4 | Examples of compact, connected 2-manifolds | 6 |
| **5** | **Statement of the classification theorem for compact surfaces** | **10** |
| 6 | Triangulations of compact surfaces | 15 |
| **7** | **Proof of Theorem 5.1** | **18** |
| 8 | The Euler characteristic of a surface | 29 |
| 9 | Manifolds with boundary | 35 |
| **10** | **The classification of compact, connected 2-manifolds with boundary** | **37** |
| **11** | **The Euler characteristic of a bordered surface** | **42** |
| 12 | Models of compact bordered surfaces in Euclidean 3-space | 43 |
| 13 | Remarks on noncompact surfaces | 47 |

**结论**：
- **「紧曲面分类定理 = Theorem 5.1」有 L1 证据**——证据就是 **§7 的标题本身**「Proof of Theorem 5.1」。
  任务书猜的 `Thm I.5.1` **对**。
- **§10 里那条带边分类定理的编号完全没有证据（L0）。硬性禁令：不得写「Theorem 10.1」。**
  （编号体系看起来是 `<节>.<序>`，但「看起来」不是证据。）
- **跨版本风险**：本书后由 Springer 重印为 GTM 56（Gallier–Xu 参考文献 [16] 逐字写「second edition, 1987」），
  Chapter I 又被吸收进 GTM 127 *A Basic Course in Algebraic Topology* (1991)。
  **三个版本的定理编号是否一致，本轮未核实。** 引用时必须写死版本。

**第三方交叉（L1，但权威性低）**：ETH Zürich 学士论文
Ana da Silva Rodrigues, *Classification of Surfaces*, 2023（`people.math.ethz.ch/~acannas/Student_Papers/BSc_Theses/`）
第 5 章明说「following Massey's book 'Algebraic Topology: An Introduction' [11]」，并给出自己的编号：

> **Theorem 5.1**（p.43）Let M₁ and M₂ be two bordered surfaces with the same number of boundary components.
> Then M₁ and M₂ are homeomorphic if and only if M₁* and M₂* are homeomorphic.
> （p.45，无编号）**χ(M) = χ(M*) − k**
> **Theorem 5.2**（p.46）Two compact bordered surfaces are homeomorphic if and only if they have the same
> number of boundary components, they are both orientable or non-orientable, and they have the same Euler
> characteristic.

⚠ 这是**学士论文**，**不建议进 `sources.bib` 当图的来源**；只作为「Massey §10 那条定理长什么样」的旁证，
且它的编号是**它自己的**，不是 Massey 的。

---

### 39.4 (A) 候选否定之一：Munkres §77 —— **编号对得上，内容不对口**

第三方讲义（ETSU, R. Gardner, *Knot Theory* Section 4.2 笔记，L1 读图）**逐字转引并注明出处**
「James Munkres' *Topology*, Second Edition, Upper Saddle River, NJ: Prentice Hall (2000)」：

> **Theorem 77.5. The Classification Theorem.**
> Let X be the quotient space obtained from a polygonal region in the plane by pasting its edges
> together in pairs. Then X is homeomorphic to either S², to the n-fold torus T, or to the m-fold
> projective plane P_m.

→ 等级 **L2**（第三方逐字 + 出处齐全，Munkres 原书未获取）。

⚠ **不能用**：这条定理 (a) **只覆盖闭曲面**（"pasting its edges together in pairs" 意味着没有自由边），
(b) **通篇不出现 Euler 数**。本项目要的恰恰是「带边 + 用 χ 判别」。登记它只是为了钉死这个看似对口的候选。

---

### 39.5 (A) 候选否定之二：Hatcher §1.2 —— **L1 确认「根本没有」**

取到 `pi.math.cornell.edu/~hatcher/AT/ATch1.pdf`（PDF 页 = 书页 − 20），读了书上 **pp.49–56** 全段。
§1.2 的最后一个小标题是「**Applications to Cell Complexes**」（p.49 起），其内容**全部**是：

- **Proposition 1.26**（贴 2-胞腔对 π₁ 的影响，三条 (a)(b)(c)）
- **Corollary 1.27**：「*The surface M_g is not homeomorphic, or even homotopy equivalent, to M_h if g ≠ h.*」
- **Corollary 1.28**：任何群都是某个 2 维胞腔复形的 π₁
- **Example 1.29**
- 然后 p.52 就进入 **Exercises**，p.56 是 **§1.3 Covering Spaces**。

关于不可定向曲面，p.52 只有一句**无编号**的正文：
「Hence N_g is not homotopy equivalent to N_h if g ≠ h, nor is N_g homotopy equivalent to any orientable surface M_h.」

→ **结论（L1）：Hatcher §1.2 里没有紧曲面分类定理，有编号的没有、无编号的也没有；
带边曲面一个字都没提。他只证了「标准曲面两两不同伦等价」这半边（唯一性），不证存在性/穷尽性。**
任务书里「Hatcher §1.2 末（无编号？核实）」——**核实结果是比「无编号」更强的否定：那条定理不在那里**。

---

### 39.6 ★★★ (B) 本轮最重要的发现：**Polchinski 原书自己给了全部四条**（L1 原书页图）

取书路线见 [[reference_cambridge-core-licensed-book-pdfs]]；本轮用到
ch.5 `2619B77DD4AE2BE4D53B5EED5D3BE3C1` / `9780511816079c5_p145-165_CBO.pdf`、
ch.6 `F440F6B46EB4150F96EAEAFDDF9F0D76` / `9780511816079c6_p166-205_CBO.pdf`。

#### (a) **χ > 0 ⇒ μ = 0 原书有直接论证，且有独立式号 (5.2.10)/(5.2.11a)**（书上 **p.152**，L1 逐字）

> "Further, κ vanishes for χ < 0 and μ vanishes for χ > 0. To show this, we first **cite the fact** that it is
> always possible by a Weyl transformation to find a metric for which the scalar curvature R is constant.
> The sign of R is then the same as that of χ. Now, P₁ᵀP₁ = −½∇² − ¼R, so
>   ∫d²σ g^{1/2}(P₁δσ)_{ab}(P₁δσ)^{ab} = ∫d²σ g^{1/2} δσ_a(P₁ᵀP₁δσ)^a
>     = ∫d²σ g^{1/2}( ½∇_aδσ_b∇^aδσ^b − (R/4) δσ_aδσ^a ) .   **(5.2.10)**
> For negative χ the right-hand side is strictly positive, so P₁δσ cannot vanish.
> **A similar argument shows that P₁ᵀδ′g cannot vanish for positive χ.**
> Combining these results we have
>   χ > 0 :  κ = 3χ ,  μ = 0 ,   **(5.2.11a)**
>   χ < 0 :  κ = 0 ,  μ = −3χ .  **(5.2.11b)**"

三条必须随引用一起写的缺口（全 L1，全是原书自陈）：

1. **单值化被外包**：「we first **cite the fact** that it is always possible by a Weyl transformation to find a
   metric for which the scalar curvature R is constant」——原书**不证**，也**不给引文**。
2. **「R 的符号与 χ 相同」也是断言**（Gauss–Bonnet），原书同样不证不引。
3. **χ > 0 那一半只有一句「A similar argument shows」**——即本图关心的方向，
   **原书没有写出来**，只声明与 χ < 0 的论证同型。

#### (b) **「χ > 0 的 Riemann 面只有三个」原书自己说了，但不证不引**（书上 **p.166**，§6.1 首句，L1 逐字）

> "**There are three Riemann surfaces of positive Euler number: the sphere, the disk, and the projective plane.**"

→ 这就是枚举路线的步骤 (1)，**原书是当作已知事实直接写出的，全章无证明、无引文**。
所以「补一条数学来源」这件事仍然必要（§39.2），但它补的是**原书的缺口**，不是本图自造的缺口。

#### (c) **圆盘：CKG = PSL(2,R)，μ = 0**（书上 **p.168**，§6.1「The disk」，L1 逐字，**无式号**）

> "The CKG of the disk is the subgroup of PSL(2,**C**) that leaves the boundary of the disk fixed.
> For the reflection (6.1.8) this is just the subgroup of (6.1.6) with α, β, γ, δ all real, which is
> **PSL(2,R)**, the Möbius group with real parameters. One CKV is the ordinary rotational symmetry of
> the disk. **Again, all metrics are equivalent — there are no moduli.**"

（(6.1.7) 是 `z′ = 1/z̄`，(6.1.8) 是 `z′ = z̄`；(6.1.6) 是一般 Möbius 变换 `z′=(αz+β)/(γz+δ)`，
p.168 上方明写「we can fix αδ − βγ = 1 and identify under an overall sign reversal … This defines the group PSL(2,C)」。）

#### (d) **射影平面：CKG = SO(3)，μ = 0**（书上 **p.168–169**，§6.1「The projective plane」，L1 逐字，**无式号**）

> "The projective plane RP₂ can also be obtained as a **Z**₂ identification of the sphere. Identify points
> z and z′ with
>   z′ = −1/z̄ .   **(6.1.9)**
> These points are diametrically opposite in the round metric (6.1.3). There are no fixed points and so no
> boundary in the resulting space, but the space is not oriented. One fundamental region for the
> identification is the unit disk |z| ≤ 1, with points e^{iφ} and −e^{iφ} identified. Another choice is the
> upper half-z-plane. **There are no moduli. The CKG is the subgroup of PSL(2,C) that respects the
> identification (6.1.9); this is just the ordinary rotation group SO(3).**"

#### (e) 球面（顺带，用于 `sphere-conformal-killing-group` 的第二锚点，书上 **p.167–168**，L1）

> p.167：「According to the general discussion in section 5.2, **the sphere has no moduli and six CKVs**,
> so that in particular every metric is (diff×Weyl)-equivalent to the round metric (6.1.3).」
> **(6.1.5a)** δz = a₀ + a₁z + a₂z² …「with three complex or six real parameters as expected from the
> Riemann–Roch theorem.」
> p.168：「Three of the six parameters correspond to ordinary rotations, forming an **SO(3)** subgroup of PSL(2,C).」

#### (f) **κ = 3 这个数字怎么来的**

原书 **§6.1 里从不写「κ(D₂) = 3」或「κ(RP₂) = 3」**，只写群。
数字 3 的书内来源是 **(5.2.11a) `κ = 3χ`** 配 χ(D₂) = χ(RP₂) = 1。
（另可用 **(5.4.20)** `m = μ + 2n_c + n_o − κ = −3χ + 2n_c + n_o`，书上 p.164。）

#### (g) ⚠ **辟谣：Polchinski Vol.1 第 5 章里没有 κ/μ/χ 的「Table 5.1」**

某些检索摘要会说「Table 5.1 是你要的表」。**本轮读了书上 pp.150–165（§5.2 起到第 5 章末），
全章只有 Fig. 5.1 / 5.2 / 5.3 三张图，没有任何表格**；第 5 章在 p.165 以习题 5.1–5.3 结束。
（pp.145–149 = §5.1「The circle」未读，但那一节讲环面与模群，出现 κ/μ 总表的可能性极低。）
**图里不得出现 `loc: "Table 5.1"`。**

---

### 39.7 (B) 数学侧的带编号来源

#### 39.7.1 ★ Miličić, *Notes on Riemann Surfaces*（Univ. of Utah, Math 6220），全 15 页 L1

编号体系是 `<章>.<节>.<序>`（如「1.5.2. **Theorem.**」）。本轮要的两条：

> **1.5.2. Theorem.**（书上 p.6）*The homomorphism γ ⟼ φ_γ of PSL(2,**C**) into the group of all
> holomorphic automorphisms Aut(**P**¹) of the Riemann sphere is an isomorphism.*

> **1.7.3. Theorem.**（书上 p.10）*The homomorphism γ ⟼ φ₀ ∘ φ_γ ∘ φ₀⁻¹ is a surjective homomorphism of
> SU(1,1) onto the group of all holomorphic automorphisms Aut(D(0,1)) of D(0,1).
> The kernel of this homomorphism is {±I}.*

⚠ **「Aut(D) = PSL(2,R)」在这篇里没有单一编号。** 把 SU(1,1) 换成 SL(2,R) 靠的是 §1.9（p.11）
的**无编号正文句**：「Therefore, Ψ : SL(2,**R**) ⟶ SU(1,1) is a group isomorphism.」（Ψ(S) = TST⁻¹，
T = (1/√2)·[[1, i],[i, 1]]）。所以引用时**要么写「Theorem 1.7.3 + §1.9」两处，要么只引 SU(1,1) 版**。

同文其余可用编号（登记备用）：1.6.1 Lemma（Aut(**C**) 是仿射）、1.6.2 Theorem、1.7.1/1.7.2 Lemma、
1.8.1 Theorem（球面自同构必有不动点）、1.8.2 Theorem、1.11.1 Theorem（单值化）。

⚠ **文件上没有印年份**，`sources.bib` 里 key 只能写 `milicic-riemann-surfaces`，
**偏离 `literature/CLAUDE.md` 的 `<firstauthor>-<year>` 规范，请 lead 裁决**。

#### 39.7.2 ★ Cao-Huu & Ghişa, arXiv:0902.2725（v1, 4 页，L1 全文）——RP₂ 唯一找到的**带编号**数学陈述

期刊版：*Automation, Computers, Applied Mathematics* **13** (2004) no. 1。arXiv v1 投于 2009-02-16。

设定（p.1，L1）：「The antianalytic involution h : C̄ → C̄ defined by h(z) = −1/z̄ if z ≠ 0, z ≠ ∞,
and h(0) = ∞, h(∞) = 0 makes (C̄, h) into a symmetric Riemann surface.
The real projective plane P² = C̄/⟨h⟩ endowed with the unique dianalytic structure which makes the
canonical projection π : C̄ → P² a dianalytic function, represents a nonorientable Klein surface.」
——**注意 h 与 Polchinski 的 (6.1.9) `z′ = −1/z̄` 逐字相同**。

> **Corollary 3.1.**（书上 p.2，L1 逐字）*The dianalytic automorphisms of P² have the representation:*
>   g(z̃) = G̃(z)  *or*  g(z̃) = G̃(z̄), *where **G is a rotation of the Riemann sphere**.*

配套的（§2，p.2，**式 (2)，非定理**）：「any dianalytic automorphism of P² has the representation
g(z̃) = G̃(z), or g(z̃) = G̃(z̄), where G(z) = e^{iθ}(az+b)/(−b̄z+ā), |a|+|b| ≠ 0, θ ∈ R」。

⚠ **四条限制，必须随引用一起写**：
1. **原文不出现「SO(3)」、不出现「PSU(2)」、不出现「维数 3」。**
   从「球面旋转群」到「SO(3)，实维 3、κ = 3」是**使用者的补步**（标准，但不是来源原文）。
2. **证明外包**：上游 Theorem 2.1 明写「We have shown in [5]」，[5] = Bârză & Ghişa,
   *Dynamics of Dianalytic Transformations of Klein Surfaces*, **Mathematica Bohemica 129 (2004) no. 2, 129–140**
   （本轮未获取）。Corollary 3.1 的证明本身只有半页，且是「验证 z ↦ e^{iα}(z−z₀)/(1+z̄₀z) 是球面旋转」这一步。
3. **归一化条件写得不严**：`|a| + |b| ≠ 0` 不足以刻画 PSU(2)（需 `|a|²+|b|² = 1` 后投影化；
   前置的 `e^{iθ}` 可被吸收进 a,b，实测无碍）。**不要照抄这行当定义。**
4. 期刊层级低、正文有笔误（§3 开头把 **Theorem 2.1** 称作「Theorem 1」）。

#### 39.7.3 第二来源：Bârză & Ghişa, *Excerpts of Analysis on Klein Surfaces*, Rev. Roumaine Math. Pures Appl. **54** (2009) 5–6, 395–406（L1 pp.395–402）

免费 PDF：`csm.ro/reviste/Revue_Mathematique/pdfs/2009/5-6/5Barza.pdf`。

框架性定理（L1 逐字，节录）：
- **Theorem 1**（p.396）对称 Riemann 面 (O₂; k) 的商 O₂/⟨k⟩ 是不可定向 Klein 面；反之每个不可定向
  Klein 面都同构于某个这样的商。
- **Theorem 3**（p.397）P²/NOKS 上的 dianalytic 映射与双叶覆盖上与 k 交换的解析映射一一对应
  （「can be lifted to a unique **analytic** mapping F : O₂ → O₂ commuting with k」）。
- **Theorem 4**（p.397）P² 的全部 dianalytic **变换**的显式形式（(2n+1) 次有理式）。

⚠ **最容易引错的一点**：真正说「P² 的 dianalytic **自同构**都形如 G̃(cl[z]) = cl[G(z)] 或 cl[G(z̄)]，
G(z) = e^{iθ}(az+b)/(−b̄z+ā)」的那句，在 **p.398 顶端，是 Theorem 4 与 Theorem 5 之间的无编号行间陈述**，
**不是 Theorem 4**。（检索摘要会把它说成 Theorem 4——错的。）
同处也自陈「We have proved the following results (see [11])」，证明同样外包。

#### 39.7.4 未能找到 / 明确的空白

- **Alling–Greenleaf, LNM 219 (1971)**：archive.org 有扫描（`foundationsofthe0219alli`），但是**借阅限制项**，
  按 [[reference_archive-org-reprint-fulltext-route]] 记的规律，`fulltext/inside.php` 与 `_djvu.txt` 一律 403。
  **本轮未取到，任何编号都是 L0。**（唯一旁证：某综述称该书的编号形如「Theorem 1.3.6 (Ahlfors), p. 16」，
  即三级编号——但这是 L4，不足以推出别的定理号。）
- **Klein 曲面自同构群的主流文献（Bujalance–Cirre–Gamboa 等）全部假设代数亏格 ≥ 2**（那里 Aut 有限），
  **代数亏格 0 的 RP² 恰恰被排除在外**。这是一个真实的文献空白，不是我没找到。
- **Farkas–Kra / Jost / Forster**：均未获取（付费墙），本轮未尝试逐条突破。
- arXiv:2502.13269（*Superstring scattering on the real projective plane*）据检索摘要称
  「the conformal Killing group of the real projective plane is **SU(2)**」——**L4，正文未获取**。
  ⚠ 若属实，它与 Polchinski 的 **SO(3)** 相差一个 **Z₂**（SU(2) 是二重覆盖，有效作用的是 PSU(2) ≅ SO(3)）。
  **这不影响 κ = 3（两者李代数同为 su(2)），但如果哪天要写「CKG 是哪个群」，两种写法并存于文献中，须写明取哪一种。**

---

### 39.8 ★★ 对**现有卡片**的三条订正（本轮读原书直接得到，优先级高于新建卡）

#### (A) `worldsheet.positive-euler-number-no-moduli--via-surface-enumeration` 的 `gaps` 有两条已作废

- gaps 第 1 条写：「**原书未给直接论证** … **Polchinski 原书是否给出直接论证，本项目未核实**」
  → **已核实：原书给了**（§39.6(a)，(5.2.10) + (5.2.11a) + 「A similar argument shows」）。
  这条 gap 必须改写为：「原书给的是**正定性论证**，但 χ > 0 那一半只有一句 "A similar argument shows"，
  且论证依赖两条原书不证不引的输入（常曲率度规的存在、R 的符号 = χ 的符号）。」
- `summary` 里「原书只把本条作为 (5.2.10) 的**对偶断言**（χ < 0 ⇒ κ = 0 的镜像）给出，未附论证」
  **是错的**：(5.2.10) 是那条正定性积分恒等式本身，(5.2.11a/b) 才是结论对；
  原书是**对 χ < 0 写出论证、对 χ > 0 声明同型**。
- `notes` 的升级路径 (d)「若 researcher 拿到原书正文并确认 Polchinski 给了直接的正定性论证，
  另建一条 `--via-positivity` 推导」→ **条件已满足，建议现在就建**（见 §39.9(3)）。

#### (B) 伴读者 [S] 那段被逐字转引的枚举论证**本身有毛病**，不宜作为论证骨架

现节点 `sources[].note` 逐字转引的 [S] 句子是：
「We know that for closed oriented surfaces, the Euler number is χ = 2 − 2g … **The only close oriented
surface with χ > 0 therefore has g = 0, i.e. is the sphere, the disk or the projective plane**」。
——**「closed oriented surface」与「the disk or the projective plane」自相矛盾**（圆盘有边、RP₂ 不可定向），
而且 χ = 2 − 2g 这条公式只对闭可定向曲面成立，根本推不出圆盘与 RP₂。
**Polchinski 自己的那句（§39.6(b)，p.166）是干净的**：「There are three Riemann surfaces of positive Euler
number: the sphere, the disk, and the projective plane.」
→ 建议 curator **把枚举路线的书内锚点从 [S] 换成原书 p.166**，并保留 [S] 引文只作为「本图为何走枚举」的历史记录。

#### (C) `worldsheet.disk-conformal-killing-group` 卡：**歧义结案 + `loc` 三处要改**

1. **歧义结案（本轮最干净的一条）**。卡片 `notes` 记的「[S] 说两种循环序 *is linked by* PSL(2,R)，
   抽取记录说 *不被* 联系，两者相反」——**原书站在「不被联系」一边，且是逐字**（书上 **p.178**，§6.4 开头，L1）：
   > "We represent the disk as the upper half-plane so the boundary coordinate y is real. **There are no moduli.**
   > After fixing the metric, the CKG **PSL(2,R)** can be used to fix the three vertex operators to arbitrary
   > positions y₁, y₂, y₃ on the boundary, except that **this group does not change the cyclic ordering of the
   > vertex operators so we must sum over the two orderings**."
   → 卡片选的方向正确；`notes` 里理由 (a)「**这是 curator 的数学论证、不是文献内容**」这句限定
   **可以撤销**，改成「原书 p.178 明写」。**[S] 那句确认为 Schrans 的错误**，可加进
   [[lit-polchinski-v1-equation-anchors]] 的「[S] 已确证的错误」清单。
2. **`loc` 的页码错了**：§6.4 开头在书上 **p.178**（不是「p.179 附近」）。
3. **`loc` 里的「3χ = κ − μ = 3 − 0」不在 §6.4**。我读了书上 pp.178–181，**没有这条式子**。
   §6.4 开头只说「There are no moduli」并点名 PSL(2,R)。
   `κ − μ = 3χ` 的书内位置是 **§5.2 (5.2.9)**（原书写作 `μ − κ = −3χ`，见 [[lit-polchinski-v1-equation-anchors]]）
   与 **(5.2.11a) `κ = 3χ, μ = 0`**。**建议把这半句从 §6.4 的 loc 里摘出去，另挂 (5.2.11a)。**
4. **「PSL(2,R)」这个记号写在原书哪里——已核实**：出现在 **两处，均无式号**——
   **p.168**（§6.1「The disk」，(6.1.8) 之后）与 **p.178**（§6.4 开头）。卡片里那条
   「⚠ **「PSL(2,R)」这个记号写在原书哪一式未核实**」可以撤销。
5. ⚠ **唯一性没有书内支持**：卡片 statement (2) 写「**存在唯一的** PSL(2,R) 元把它们送到任一组指定的同循环序的三点」。
   原书只写「can be used to fix the three vertex operators to **arbitrary positions**」，
   **没有「唯一」**。唯一性要么挂 `math.mobius-group-sharply-three-transitive`，要么在 note 里注明「唯一性非书内陈述」。

---

### 39.9 图里建议怎么加（供 curator 取舍；researcher 不改 `graph/`）

> 我不代 curator/auditor 做任何裁决。以下只是把「哪条陈述能挂哪条编号」摆出来。

#### (1) 新 statement `math.classification-of-compact-surfaces`

```yaml
kind: proposition          # 命题不填 status，由 derivation 计算
title: 紧曲面分类定理（含带边、含不可定向）
statement: |
  两个紧曲面（含带边）同胚，当且仅当它们的可定向性、边界分支数（contour 数）与
  Euler–Poincaré 示性数三者全部相同。
sources:
  - ref: gallier-xu-2013
    loc: "Ch. 6 §6.3, Theorem 6.2, p. 97（三角化版 Theorem 6.1, p. 96）"
    note: |
      L1 逐页核实（math-sources.md §39.2.1）。三条限制：
      (a) 原文用 "number of contours"，不是 "number of boundary components"；
      (b) Theorem 6.2 依赖「每个曲面/带边曲面可三角化」，原书 p.96 自陈该证明「far from trivial」
          且放在 Appendix E（Thomassen 的证明），正文不证；
      (c) 出版版编号 6.2 与 arXiv 版（gallier-2008-surfaces）编号 5.3.2 不可互换。
  - ref: massey-1967
    loc: "Ch. I §10「The classification of compact, connected 2-manifolds with boundary」, pp. 37-42（定理编号未核实，不得写 Theorem 10.1）"
    note: "仅目录 L1（math-sources.md §39.3）。闭曲面那条是 Theorem 5.1（由 §7 标题「Proof of Theorem 5.1」佐证）。"
```

配一条 derivation `math.classification-of-compact-surfaces--via-normal-forms`，
`kind: proof`、`status: rigorous`，`sources` 同上，**并在 `gaps` 里写死上面的 (b)**（三角化外包）。

#### (2) 新 statement `math.positive-euler-characteristic-surfaces`（**这才是 ch.5 那条推导真正要的**）

```yaml
kind: proposition
title: χ > 0 的紧连通曲面只有三种：S²、D²、RP²
statement: |
  设 M 是紧连通二维曲面（允许有边、允许不可定向），χ(M) 是其 Euler 数。
  若 χ(M) > 0，则 M 同胚于球面 S²（χ = 2）、圆盘 D²（χ = 1）或实射影平面 RP²（χ = 1）三者之一。
```
derivation `--via-normal-form-enumeration`：
- `depends_on`: `math.classification-of-compact-surfaces`；
- `sources`: `gallier-xu-2013`，`loc: "Definition 6.5, pp. 88-89（type (I) p>=0,q>=0；type (II) p>=1,q>=0）+ χ(K)=2-2p-q / χ(K)=2-p-q, pp. 89-90（无编号行间式）+ 身份认定 p.90（RP²）、p.102（圆盘 p=0,q=1；莫比乌斯带 p=q=1）"`；
- ⚠ `summary` 里必须写明：**「χ > 0 ⇒ 只剩三种」这条不等式求解在来源里不存在，是本图补的两行算术**；
  对应的边或该条 source 建议标 `inferred: true`，或由 auditor 判定这属于「来源直接蕴含的平凡推论」。
- 最近的落选者 **莫比乌斯带 χ = 0**（p = q = 1）值得写进 `notes`，因为它是唯一会被「χ ≥ 0」误纳的曲面。

#### (3) ★ 新 derivation `worldsheet.positive-euler-number-no-moduli--via-positivity`

这是原书自己的论证，**与现有的 `--via-surface-enumeration` 并列，不替换它**。

```yaml
target: worldsheet.positive-euler-number-no-moduli
kind: physical-argument
status: physical-argument
sources:
  - ref: polchinski-1998-v1
    loc: "§5.2, eq. (5.2.10) 与 (5.2.11a), p.152"
gaps:
  - "原书对 χ < 0（κ = 0）写出了完整正定性论证，对本条（χ > 0 ⇒ μ = 0）**只有一句 'A similar argument shows that P₁ᵀδ′g cannot vanish for positive χ'**，未写出。"
  - "论证依赖『总可用 Weyl 变换取到常数标量曲率 R 的度规』——原书逐字写 'we first **cite the fact**'，不证、不给引文（即单值化定理）。"
  - "论证依赖『R 的符号与 χ 相同』（Gauss–Bonnet），原书同样不证不引。"
```
→ **status 建议 `physical-argument`**：论证骨架是原书的、方向清晰，但本图关心的那一半原书没写出来，
且两条输入外包。**是否可升到 `rigorous`，由 auditor 定。**
**（若采纳，`--via-surface-enumeration` 的 gaps 第 1 条与 notes(d) 应同步改写，见 §39.8(A)。）**

#### (4) 新 statement `worldsheet.rp2-conformal-killing-group`

```yaml
kind: proposition
title: 射影平面的共形 Killing 群是 SO(3)，κ(RP₂) = 3，μ(RP₂) = 0
statement: |
  RP₂ 实现为球面在对合 z′ = −1/z̄ 下的 Z₂ 商（无不动点，故无边界，且不可定向）。则：
  (1) RP₂ 无模：μ(RP₂) = 0；
  (2) 其共形 Killing 群是 PSL(2,C) 中与该认同相容的子群，即通常的旋转群 SO(3)；
  (3) 由 χ(RP₂) = 1 与 κ = 3χ 得 κ(RP₂) = 3。
sources:
  - ref: polchinski-1998-v1
    loc: "§6.1「The projective plane」, pp. 168-169，认同式 (6.1.9)；『There are no moduli』与『the CKG … is just the ordinary rotation group SO(3)』均为**无式号**正文句"
    note: |
      L1 原书页图核实（math-sources.md §39.6(d)）。⚠ 原书**不写** κ(RP₂)=3 这个数字，
      数字来自同书 (5.2.11a) κ = 3χ 与 χ(RP₂) = 1。
  - ref: polchinski-1998-v1
    loc: "§5.2, eq. (5.2.11a), p.152（κ = 3χ, μ = 0 for χ > 0）"
  - ref: caohuu-ghisa-2004
    loc: "Corollary 3.1（arXiv:0902.2725v1, p.2）"
    note: |
      数学侧独立来源，L1（math-sources.md §39.7.2）。原文逐字只说自同构「is a rotation of the
      Riemann sphere」，**不出现 SO(3)/PSU(2)/维数 3**；证明外包给 Barza-Ghisa, Math. Bohemica 129 (2004) 129-140。
      同文用的对合 h(z) = −1/z̄ 与 Polchinski (6.1.9) 逐字相同。
```
- `uses_conventions`: `conv.worldsheet-euclidean`、`conv.worldsheet-complex-coords`（与 disk 卡一致）。
- 建议同时建 derivation `--via-sphere-involution`，`kind: physical-argument`，
  `depends_on`: `worldsheet.sphere-conformal-killing-group`（CKG(S₂) = PSL(2,C)）
  + `worldsheet.riemann-roch-kappa-minus-mu`（给 κ = 3χ）。
- ⚠ **文献分歧要写进 note**：arXiv:2502.13269 据称写「CKG of RP² is **SU(2)**」（L4，未核实）。
  SU(2) 与 SO(3) 差一个 Z₂，κ 不受影响，但群的写法两说并存。

#### (5) `worldsheet.disk-conformal-killing-group`（已存在）：按 §39.8(C) 改 `loc` 与 `notes`

建议的新 `loc`（可直接抄）：

```yaml
sources:
  - ref: polchinski-1998-v1
    loc: "§6.1「The disk」, p.168（(6.1.8) 之后）：CKG 是 PSL(2,C) 中保持圆盘边界的子群 = PSL(2,R)，且『there are no moduli』；**无式号**"
    note: |
      L1 原书页图核实（math-sources.md §39.6(c)）。原书用 (6.1.7) z′=1/z̄ 与共形等价的 (6.1.8) z′=z̄，
      并在 p.168 上方由 (6.1.6) + αδ−βγ=1 + 整体反号认同定义 PSL(2,C)。
  - ref: polchinski-1998-v1
    loc: "§6.4 开头, p.178：『There are no moduli. After fixing the metric, the CKG PSL(2,R) can be used to fix the three vertex operators to arbitrary positions y₁,y₂,y₃ on the boundary, except that this group does not change the cyclic ordering … so we must sum over the two orderings.』；**无式号**"
    note: |
      L1 原书页图核实。**本条直接结案了卡片 notes 里的文献歧义：原书站「不被 PSL(2,R) 联系」一边。**
      ⚠ 原书只说 arbitrary positions，**没有说「唯一」**；唯一性须另挂 math.mobius-group-sharply-three-transitive。
  - ref: polchinski-1998-v1
    loc: "§5.2, eq. (5.2.11a), p.152（κ = 3χ, μ = 0 for χ > 0；配 χ(D₂)=1 给 κ=3）"
```
并**删掉**旧 loc 里的「3χ = κ − μ = 3 − 0」与「p.179 附近」，
**撤销** notes 里「PSL(2,R) 记号未核实」与「(a) 是 curator 的数学论证、不是文献内容」两处。

#### (6) 数学侧的可选补强

若 curator 想给 (4)(5) 各挂一条**纯数学**依赖：

```yaml
# 圆盘
- ref: milicic-riemann-surfaces
  loc: "Theorem 1.7.3, p.10（Aut(D(0,1)) ≅ SU(1,1)/{±I}）+ §1.9, p.11 的无编号句（SL(2,R) ≅ SU(1,1)）"
  note: "L1。⚠ 「Aut(D) = PSL(2,R)」在该文献里**没有单一编号**，是两处合成。"
# 球面（给 sphere 卡）
- ref: milicic-riemann-surfaces
  loc: "Theorem 1.5.2, p.6（PSL(2,C) → Aut(P¹) 是同构）"
# 射影平面
- ref: caohuu-ghisa-2004
  loc: "Corollary 3.1（arXiv:0902.2725v1, p.2）"
```

#### (7) 三条禁令

1. **不得写 `Massey … Theorem 10.1`**（§39.3）。
2. **不得写 `Polchinski Vol.1 Table 5.1`**——第 5 章没有表格（§39.6(g)）。
3. **不得把 RP² 自同构那条引成 `Bârză–Ghişa Theorem 4`**——那句是 Theorem 4 与 5 之间的**无编号**陈述（§39.7.3）。

---

### 39.10 访问日志与未解决问题（本节）

| 目标 | URL / 手法 | 结果 |
|---|---|---|
| **Polchinski Vol.1 ch.5 正文** | Cambridge Core `…/2619B77DD4AE2BE4D53B5EED5D3BE3C1/9780511816079c5_p145-165_CBO.pdf/…` | **成功**（243 KB；读 pp.150–165；**PDF 页 = 书页 − 144**） |
| **Polchinski Vol.1 ch.6 正文** | Cambridge Core `…/F440F6B46EB4150F96EAEAFDDF9F0D76/9780511816079c6_p166-205_CBO.pdf/…` | **成功**（404 KB；读 pp.166–181；**PDF 页 = 书页 − 165**） |
| **Gallier–Xu 出版版全书** | `cis.upenn.edu/~jean/surfclassif-root.pdf` | **成功**（3.5 MB；**PDF 页 = 书页 + 10**，前置 roman 页 = PDF 页 + 2） |
| **Gallier arXiv 版** | `arxiv.org/pdf/0805.0562` | **成功**（947 KB；**PDF 页 = 书页**） |
| Gallier 草稿版（两个镜像） | `cis.upenn.edu/~jean/surfclass-n.pdf`；`cs.brynmawr.edu/~dxu/surfclassif.pdf` | **失败：两次都只回来 28 页**（2.7 MB，只到第 1 章）——**新增死路** |
| ar5iv 版 0805.0562 | `ar5iv.arxiv.org/html/0805.0562` | **失败**：「Conversion to HTML had a Fatal error」 |
| **Massey 1967 目录扫描** | `external.dandelon.com/download/attachments/dandelon/ids/DE00420A6F9CE221E6E38C12579A000352287.pdf` | **成功**（92.6 KB，6 页扫描）——**新增活路：dandelon 是取旧书目录页的稳定入口** |
| **Munkres Thm 77.5（转引）** | `faculty.etsu.edu/gardnerr/Knot-Theory/Notes-Livingston/Livingston-Knot-4-2.pdf` | **成功**（352 KB；p.2 逐字带出处） |
| **Hatcher ch.1** | `pi.math.cornell.edu/~hatcher/AT/ATch1.pdf` | **成功**（1 MB；**PDF 页 = 书页 − 20**） |
| **Miličić 讲义** | `math.utah.edu/~milicic/Math_6220/rsurfaces.pdf` | **成功**（163 KB，15 页全读；**PDF 页 = 书页**） |
| **Cao-Huu–Ghişa** | `arxiv.org/pdf/0902.2725` | **成功**（72 KB，4 页全读） |
| **Bârză–Ghişa 2009** | `csm.ro/reviste/Revue_Mathematique/pdfs/2009/5-6/5Barza.pdf` | **成功**（198 KB；读 pp.395–402；**PDF 页 = 刊页 − 394**） |
| ETH 学士论文 | `people.math.ethz.ch/~acannas/Student_Papers/BSc_Theses/2023_bsc_da_silva_classification_of_surfaces.pdf` | **成功**（3.4 MB；**PDF 页 = 书页 + 6**） |
| Alling–Greenleaf LNM 219 | archive.org `foundationsofthe0219alli` | **未尝试正文**（借阅限制项，按既往规律必 403） |
| arXiv:2502.13269 正文 | `arxiv.org/abs/2502.13269` | **失败**（abs 页只有摘要，摘要里没有 CKV 陈述；未取 PDF） |

> **两条可复用的经验**：
> (1) **dandelon.com** 的 `external.dandelon.com/download/attachments/dandelon/ids/<ID>.pdf` 提供**旧书的目录扫描页**，
> 对「只想确认某章某节标题与页码」的场景够用，且不被拦——这是本轮拿到 Massey 结构的唯一手段。
> (2) **同一本书的作者主页往往挂着多个版本，编号可能完全不同**（Gallier 一人挂了三份），
> 取正文前先看标题页日期与目录，**不要假设 arXiv 版 = 出版版**。

**未解决 / 留给下一轮：**

- **Q30** **Massey 里带边分类定理的编号（L0）。** GTM 56 (2nd ed. 1987) 或 GTM 127 (1991) 的 Ch. I §10。
  可能的下一招：找一篇**逐字引用了它的定理号**的论文；或找 GTM 127 的公开扫描（Springer 认证墙）。
  在拿到之前，图里只能写「Ch. I §10, pp. 37–42」。
- **Q31** **Massey 1967 / GTM 56 / GTM 127 三个版本的 Chapter I 定理编号是否一致（L0）。**
  本轮只有 1967 Harcourt 版的目录。
- **Q32** **Bârză & Ghişa, Mathematica Bohemica 129 (2004) 129–140** 正文——
  这是 RP² 自同构那条结论**唯一的真正证明出处**（0902.2725 与 RRMPA 2009 都把证明外包给它）。
  `dml.cz` 有 Mathematica Bohemica 全文开放，值得一试。
- **Q33** **Alling–Greenleaf LNM 219 里有没有 RP²（代数亏格 0）自同构群的带编号定理。**
  它是这一支文献人人引的标准参考，但本轮无人给出具体编号。
- **Q34** **arXiv:2502.13269 正文里「CKG of RP² = SU(2)」的确切措辞**，
  以确认它与 Polchinski 的 SO(3) 是笔误还是有意（覆盖群 vs 有效作用群）。
- **Q35** **Polchinski Vol.1 §5.1（书上 pp.145–149）未读**——用于最终排除「第 5 章有 κ/μ/χ 总表」的可能。
- **Q36** **Miličić 讲义的年份**（文件上未印）。影响 `sources.bib` 的 key 是否合规。
