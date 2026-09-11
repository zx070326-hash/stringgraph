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

# 洛伦兹格顶点代数与 Borcherds 恒等式（researcher，2026-09-11）

> **本轮任务**：为无鬼定理链回 `rigorous` 找两张卡的数学一手来源。
> **卡 (A)**：「D 个自由玻色子（**不定号差** η，含类光 k₀）的 Heisenberg 顶点代数 ⊗ C[Z k₀]
> （或洛伦兹格 L 的格点顶点代数 V_L）**是**顶点代数；动量塔是其模」。
> **卡 (B)**：「Borcherds/Jacobi 恒等式」带编号 + 对易子公式
> `[a_(m), b_(n)] = Σ_{k≥0} C(m,k) (a_(k) b)_(m+n−k)`。
> **本轮特别要求**：每条来源必须记 **L 等级** 与 **对格号差假设（正定？非退化？偶？）的逐字措辞**。
>
> **上一轮（2026-09-11 早些时候）在核实 Lepowsky–Li Thm 6.5.3 时停摆、产出全丢**，本轮改为「查到一条立即落盘」。

## 36. 卡 (A)：格点顶点代数 V_L —— 号差假设的逐字核实

### 36.1 ★★ Li & Wang, arXiv:0802.0173：「**possibly degenerate** even lattice」（摘要 L1，正文待补）

| 项 | 值 | 等级 |
|---|---|---|
| 作者 | **Haisheng Li, Qing Wang** | L1 |
| 标题 | *On vertex algebras and their modules associated with even lattices* | L1 |
| id | **arXiv:0802.0173 [math.QA]** | L1 |

摘要逐字（L1）：

> "We study vertex algebras and their modules associated with **possibly degenerate even lattices**,
> using an approach somewhat different from others. Several known results are recovered and a number
> of new results are obtained. We also study modules for Heisenberg algebras and we classify
> irreducible modules satisfying certain conditions and obtain a complete reducibility theorem."

**为什么这条对本项目至关重要**：卡 (A) 要的正是「含**类光** k₀」的情形。类光向量 ⟨k₀,k₀⟩ = 0
使得格上的双线性型限制到 ℤk₀ 上**退化**。绝大多数教材（FLM/LL/Kac）默认 **nondegenerate**，
本文是本轮找到的唯一一篇**标题+摘要就点名 degenerate** 的。

**正文（ar5iv 中介，L4，待 PDF 逐字复核）：**

| 编号 | 内容（中介转述 + 引号内为其声称的逐字） | 用途 |
|---|---|---|
| **Theorem 3.6** | 构造 `V(𝔥,L)`；对 L 的假设只有「**⟨α,α⟩ ∈ 2ℤ for α ∈ L**」+ L 是 𝔥 的加法子群。**不要求非退化。** | 卡 (A) 主体 |
| **Theorem 4.1** | 单独处理**完全退化**情形「**⟨·,·⟩\|_L = 0**」 | 类光 ℤk₀ 的极端情形 |
| **Theorem 3.10** | 不可约 `V(𝔥,L)`-模分类：`𝔲(0)` 半单作用 ⇒ `≅ V(𝔥,L)(λ,U₁)`，`λ ∈ L°` | **卡 (A) 的「动量塔是其模」** |
| **Proposition 3.11** | 上述模的同构判据（`λ₁+L = λ₂+L` 且 `U₁ ≅ U₂`） | 动量塔的重数 |

引言里对**经典**设定的措辞（中介称逐字）：「Let L be any **nondegenerate** even lattice in the sense that
L is a finite-rank free abelian group」——即 Li–Wang 自己把 [Bo]/[FLM] 归类为 nondegenerate 设定。

参考文献标签（中介引号）：**[Bo]** = Borcherds, PNAS **83** (1986) 3068–3071；
**[FLM]** = Pure and Applied Math. **134**, Academic Press, 1988；
**[LL]** = Progress in Math. **227**, Birkhäuser, **2004**（注意：不是 2003）；
**[K]** = Kac, *Infinite-dimensional Lie Algebras*, 3rd ed.（**不是** *Vertex Algebras for Beginners*）；
**[DL]** = Dong–Lepowsky, Progress in Math. **112**, 1993。**无 [B] 标签。**

*（本节按来源逐个追加；每条记 L 等级 + 号差措辞逐字。）*

### 36.2 ★★★ Borcherds 1986 PNAS：**「For any even lattice R」——原文对号差零假设**（L1 全文读图）

| 项 | 值 | 等级 |
|---|---|---|
| 作者 | Richard E. Borcherds, Trinity College, Cambridge CB2 1TQ, England | L1（标题页） |
| 标题 | *Vertex algebras, Kac-Moody algebras, and the Monster.* | L1 |
| 出处 | *Proc. Natl. Acad. Sci. USA* **Vol. 83, pp 3068–3071** | L1（标题页自印） |
| 投稿 | "Communicated by Walter Feit, **December 13, 1985**" | L1 |
| **获取** | **`https://math.berkeley.edu/~reb/papers/va/va.pdf`**（作者本人主页重排本，112 KB） | L1 |

> ⚠ **引用陷阱**：这是**作者自己重排的 TeX 版**，页码是 1,2,3,4,5…，**与期刊 3068–3071 不对应**
> （重排本至少 5 页，期刊只有 4 页）。`loc:` 字段应写**节号**（Section 2/4/5），不要写重排本页码。
> 另：重排本与印本是否逐字一致**未独立核验**（可用 PMC 扫描件复核，见 §38 未解决问题）。

#### (a) 结构：**全文没有任何编号的 Theorem / Proposition / Definition**

节标题（L1 逐字）：Section 1. Introduction. / **Section 2. Construction of the Fock space V.** /
Section 3. Vertex Operators. / **Section 4. Vertex Algebras.** / **Section 5. The Virasoro Algebra.**
公理以**罗马数字 (i)–(vi)** 的形式列在节内，**没有编号定理，也没有编号公式**。
⇒ **图里不能写「Borcherds 1986, Theorem X」**——不存在。只能写 "Section 4, relations (i)–(v)"。

#### (b) ★★ 号差假设：**只要求 even，不要求非退化、不要求正定**（L1 逐字）

Section 2 开头：

> "In this section, we recall the construction of a certain Fock space `V` from an **even lattice** `R`
> and put several structures on `V`, such as a product, a derivation, and an inner product (see ref. 2)."

> "**For any even lattice** `R` there is a central extension `0 ⟶ Z₂ ⟶ R̂ ⟶ R ⟶ 0`"

Section 4 开头（**这句就是卡 (A) 的核心授权**）：

> "**For any even lattice** `R` the operators `u_n` on `V` satisfy the following relations."

随后 (i)–(v)，然后：

> "We will call any module with linear operators `D^(i)(u)` and bilinear operators `u_n(v)`
> satisfying relations *i*–*v* above a **vertex algebra**, so `V` is a vertex algebra."

**⇒ 「V(R) 是顶点代数」在 Borcherds 原文里对号差零假设：even 即可，可以不定号差，甚至可以退化（singular）。**

#### (c) ★★★ Virasoro 部分**才**要求非退化，且原文**专门处理了退化情形**（L1 逐字）

Section 5 第二段：

> "**We assume that `R` is nonsingular**, and we let `c` be the element `½ Σ_i r_i(1)r'_i(1)` of `V`,
> where `r_i` runs over some base of `R` and `r'_i` is the dual base. We write `L_i` for the operator `c_{i+1}`…"

> `L_{−1} = D`, `L_0 = deg`
> **`[L_i, L_j] = (i−j)L_{i+j} + (i³−i) dim(R) δ_{i,−j}/12`**
> `L_{−i}` is the adjoint of `L_i`.

> "In particular the operators `L_i` and 1 span a copy of the Virasoro algebra.
> **If `R` is a (possibly singular) lattice contained in a nonsingular lattice `S`, then the operators
> `L_i` for `i ≥ −1` on the vertex algebra of `S` restrict to operators on the vertex algebra of `R`
> that do not depend on the lattice `S` containing `R`. In particular if `i ≥ −1` then the operator `L_i`
> can be defined on the vertex algebra `V` of `R` even when `R` is singular.**"

**这一段直接命中卡 (A) 的「含类光 k₀」**：类光方向使格**奇异（= 退化）**，Borcherds 明说
顶点代数结构照样在，Virasoro 也在（但只有 `i ≥ −1`，**`L_i` for `i ≤ −2` 在奇异格上没有定义**——
这是一个真实的限制，图里必须写进去）。

**中心荷**：由上式读出 `c = dim(R)`（`(i³−i)·dim(R)/12` 对应 `c(i³−i)/12`）。
对 `R = ℤ^{25,1}` 即 `c = 26`——**但原文没有把这句写出来**，这是我的读数，属推断。

#### (d) ★★ 原文**明确出现洛伦兹格**，且明确点名**无鬼定理**（L1 逐字，Section 5 末）

> "*Example:* If `R` is the 18-dimensional even unimodular **Lorentzian lattice `II_{17,1}`** and `A` is the
> Kac-Moody algebra whose Dynkin diagram is that of `R`, then `A` has roots of norm 2, 0, −2, and −4 …"

> "**Frenkel used the no-ghost theorem to prove this stronger upper bound when `R` is 26 dimensional
> and Lorentzian.**"

⇒ Borcherds 本人把「26 维洛伦兹格 + 无鬼定理」写在纸面上。**这是本轮找到的、把卡 (A) 与无鬼定理
直接连起来的唯一一处原始文献。**

#### (e) 物理态子空间 `P^i` 的定义（L1 逐字，Section 5）——顺带取到，curator 可能用得上

> "We define the physical subspace `P^i` to be the elements `v` of `V` with `L_n(v) = iv` if `n = 0`,
> 0 if `n ≥ 1`."

> "If `r` is any nonzero vector of `R` the then dimension of the `r` subspace of `P¹` or `P⁰` is
> `p_{d−1}(1 − (r,r)/2)` or `p_{d−1}(−(r,r)/2)`, where `d` is the dimension of `R` …
> Hence the dimension of the `r` subspace of `P¹/DP⁰` is equal to `p_{d−1}(1 − (r,r)/2) − p_{d−1}(−(r,r)/2)`"

（`p_{d−1}` = 分成 `d−1` 色的分拆数。注意「stronger upper bound `p_{d−2}(1 − (r,r)/2)`」正是无鬼定理给的那个。）

### 36.3 ★★★ Li–Wang arXiv:0802.0173 正文 L1 核实：**Theorem 3.6 / 3.10 与整个第 4 节**

获取：`https://arxiv.org/pdf/0802.0173` → 落盘 246.9 KB → `Read(pages=)`。
版本戳（p.1 侧栏，L1）：**`arXiv:0802.0173v1 [math.QA] 1 Feb 2008`**。
作者单位（L1）：Department of Mathematical Sciences, Rutgers University, Camden, NJ 08102；
Qing Wang 的 permanent address 是 Xiamen University。**PDF 页 = 文章页**（无偏移）。

#### (a) 引言里对**经典**情形的逐字定义（p.1，L1）——这句钉死了「经典 V_L 假设非退化」

> "Let `L` be any **nondegenerate even lattice** in the sense that `L` is a finite-rank free abelian group
> equipped with a symmetric ℤ-bilinear form `⟨·,·⟩` such that `⟨α,α⟩ ∈ 2ℤ` for `α ∈ L`.
> Associated to `L` there exists a canonical vertex algebra `V_L` (**[Bo], [FLM]**)."

> "For vertex algebras `V_L`, irreducible modules were classified in **[D]** (cf. [DLM2], **[LL]**) where
> **Dong proved that every irreducible `V_L`-module is isomorphic to one of those constructed in [FLM]**."

> "…set `𝔥 = ℂ ⊗_ℤ L` and extend the ℤ-bilinear form on `L` to a **nondegenerate** symmetric ℂ-bilinear
> form `⟨·,·⟩` on `𝔥`."

p.2（L1）：

> "If the vertex algebra `V` is finitely generated, one can readily see that `L` is finitely generated,
> so that `L` is free of finite rank (as `L` is torsion-free). In this case, `L` is a (finite rank)
> **possibly degenerate even lattice**."

> "For the vertex algebra `V_L` with `L` a **nondegenerate** even lattice, irreducible modules have been
> constructed before in **[FLM]** and **[LL]** with quite different methods. Our treatment here is further
> different from those of [FLM] and [LL]."

⇒ **Li–Wang 自己把 FLM 与 LL 都归到「nondegenerate」设定**（这是本轮对「FLM/LL 是否覆盖不定号差」
问题最直接的旁证：**它们覆盖不定号差没问题，覆盖退化才是问题**——见 (d) 的号差 vs 退化辨析）。

#### (b) ★★★ **Theorem 3.6**（p.13，L1 逐字）——这就是卡 (A) 的「是顶点代数 + 动量塔是其模」

先有 **Definition 3.5**（p.13，L1 逐字）：

> "**Definition 3.5.** We say an `ĥ`-module `W` satisfies *Condition `C_L`* if `W` is a restricted
> `ĥ`-module of level 1, satisfying the condition that for any `α ∈ L`, `α(0)` is semisimple with only
> integer eigenvalues and `α(n)` with `n ≥ 1` are locally nilpotent."

> "**Theorem 3.6.** *Let `U` be an `ĥ`-module of level 1, satisfying Condition `C_L`. Set*
> &nbsp;&nbsp; `V_{(𝔥,L)}(U) = ℂ[L] ⊗ U.` &nbsp;&nbsp;**(3.13)**
> *For `α, β ∈ L`, `v ∈ M(1)`, `w ∈ U`, we define*
> &nbsp;&nbsp; `Y_W(e^α ⊗ v, x)(e^β ⊗ w) = ε(α,β) e^{α+β} ⊗ x^{⟨α,β⟩} E^−(−α,x) Y_U(Δ̄(β,x)v, x) Δ̄(α,−x) w.` &nbsp;&nbsp;**(3.14)**
> *Then `(V_{(𝔥,L)}, Y, e⁰⊗1)` **carries the structure of a vertex algebra** with `M(1)` as a vertex
> subalgebra and `(V_{(𝔥,L)}(U), Y_W)` **carries the structure of a `V_{(𝔥,L)}`-module**. Furthermore,
> if `U` is irreducible, so is `V_{(𝔥,L)}(U)`.*"

证明里作者自陈的路线（p.13–15，L1）：「Next, we show that **the Jacobi identity** holds.」→ 最后
「Using this and delta-function substitutions we obtain the Jacobi identity as desired.
This proves the assertions on vertex algebra structure and module structure.」
**⇒ 这是一条完整的、有证明的定理，不是引用别处。**

#### (c) ★★★ 动量塔：**(3.17) + Proposition 3.9 + Theorem 3.10 + Proposition 3.11**（pp.16–19，L1 逐字）

> `L° = { λ ∈ 𝔥 | ⟨α,λ⟩ ∈ ℤ for all α ∈ L }` &nbsp;&nbsp;**(3.17)**

> "**Proposition 3.9.** *The defined `ĥ`-module `M(1,λ,U₁)` satisfies Condition `C_L` and is irreducible.
> On the other hand, every irreducible `ĥ`-module satisfying Condition `C_L` is isomorphic to
> `M(1,λ,U₁)` for some `λ ∈ L°` and some irreducible restricted `ℒ₁`-module `U₁` of level 1.*"

> "**Theorem 3.10.** *Let `W` be an irreducible `V_{(𝔥,L)}`-module on which `𝔲(0)` acts semisimply.
> Then `W` is isomorphic to `V_{(𝔥,L)}(λ,U₁)` for some `λ ∈ L°` and for some irreducible restricted
> `ℒ₁`-module `U₁` of level 1.*"

其中（p.17，L1）`V_{(𝔥,L)}(λ,U₁) = ℂe^λ ⊗ ℂ[L] ⊗ U₁ ⊗ M₀(1)` as a vector space，
`𝔲(0) = ℂu₁(0) ⊕ … ⊕ ℂu_s(0) ⊂ 𝔥(0) ⊂ ĥ`。

> "**Proposition 3.11.** *Let `λ₁, λ₂ ∈ L°` … Then `V_{(𝔥,L)}(λ₁,U₁) ≃ V_{(𝔥,L)}(λ₂,U₂)` if and only if
> `λ₁ + L = λ₂ + L` and `U₁ ≃ U₂`.*"

**⇒ 「动量塔」= `λ` 跑遍 `L°/L`，正是 (3.17) 的对偶格模掉 L。**

> "**Remark 3.12.** Assume that `L` is a **nondegenerate** even lattice with `𝔥 = ℂ ⊗_ℤ L`. …
> **Thus Theorem 3.6 recovers the corresponding results of [FLM] with a different proof.**
> In this case, the assumption in Theorem 3.10 that `𝔲(0)` is semisimple is **vacuous**.
> Then we recover Dong's corresponding result in [D] (cf. [DLM2], [LL])."

#### (d) ★★★ **第 4 节标题就是类光条件**（p.20，L1 逐字）——与卡 (A) 的 `ℂ[ℤk₀]` **逐字对上**

> "**4. A characterization of vertex algebras `V_{(𝔥,L)}` with `⟨·,·⟩|_L = 0`**
>
> In this section we study vertex algebras `V_{(𝔥,L)}` with `⟨·,·⟩|_L = 0`. In this case, we give a
> characterization of the vertex algebras in terms of a certain affine Lie algebra.
>
> Let `𝔥` be a finite-dimensional vector space equipped with a **nondegenerate symmetric bilinear form**
> `⟨·,·⟩` and let `L ⊂ 𝔥` a free abelian group with **`⟨α,β⟩ = 0` for `α, β ∈ L`**. …
> `⟨h+u, h'+v⟩ = ⟨h,h'⟩` for `h,h' ∈ 𝔥`, `u,v ∈ ℂ[L]`. &nbsp;&nbsp;**(4.1)**"

**取 `L = ℤk₀`、`k₀` 类光，条件 `⟨α,β⟩=0 ∀α,β∈L` 就是 `⟨k₀,k₀⟩ = 0`。这是逐字命中。**

#### (e) ★★ 号差 vs 退化：一条**必须写进图**的辨析（这一段是我的推断，不是原文）

Li–Wang（以及 FLM/Kac/LL）全都在 **ℂ 上**做：`𝔥` 是复向量空间，形式只要求 **nondegenerate symmetric**。
**在 ℂ 上，非退化对称双线性型的号差不是不变量**（`O(n,ℂ)` 只有一个）——
所以「不定号差 η」这件事在**顶点代数结构层面根本不出现**。
真正出现号差的是 **Borcherds §2 (v) 的那个内积**（`r(i)` 与 `r(−i)` 互为伴随、`(e^r,e^s)=δ`），
它在洛伦兹格上**不定**，这才是鬼态的来源。

**⇒ 给 curator 的判断**：卡 (A)「是顶点代数」这一半，**不需要**任何关于号差的假设，
可以直接引 Borcherds §4 / Li–Wang Thm 3.6，`status: rigorous`；
而「内积不定 / 无鬼」那一半是**另一张卡**，不要混进来。
本轮**没有**找到任何来源把「不定 Hermitian 内积下的顶点代数」做成带编号定理。

#### (f) 顺带取到的 **FLM 编号**（Li–Wang 转引，L1 见于 Li–Wang 正文 ⇒ 对 FLM 而言是 L3）

| FLM 编号 | Li–Wang 用它做什么 | 页 |
|---|---|---|
| **[FLM] Theorem 1.7.3** | Heisenberg 代数在固定非零 level 下「只有一个不可约模、完全可约」 | p.2 |
| **[FLM] Section 1.7** | Li–Wang §2 的完全可约定理「generalizes a theorem of [FLM] (Section 1.7)」 | p.3 |
| **[FLM] Proposition 4.1.1** | `[h(n), E^∓(α,x)]` 的对易关系 | p.18 |
| **[FLM] Chapter 5** | 「all the 2-cocycles `ε : S×S → ℂ^×` satisfying (3.6)—(3.8) are cohomologous」 | p.15 |

**⚠ 这四条对 FLM 本身只是 L3（他人转引），FLM 原书本轮未获取。**

#### (g) ★★★ **Theorem 3.6 的假设逐字**（p.12，L1）——**对 L 只要求 even，明确没有非退化条件**

> "For the rest of this section, we assume that `L` is an **additive subgroup of `𝔥`** such that
> &nbsp;&nbsp; `⟨α,α⟩ ∈ 2ℤ` &nbsp;&nbsp; for `α ∈ L`, &nbsp;&nbsp;**(3.5)**
> equipped with a function `ε : L × L → ℂ^×`, satisfying the condition that
> &nbsp;&nbsp; `ε(α,0) = ε(0,α) = 1` &nbsp;**(3.6)**
> &nbsp;&nbsp; `ε(α, β+γ)ε(β,γ) = ε(α+β, γ)ε(α,β)` &nbsp;**(3.7)**
> &nbsp;&nbsp; `ε(α,β)ε(β,α)^{−1} = (−1)^{⟨α,β⟩}` &nbsp;**(3.8)**
> for `α, β, γ ∈ L`."

> `V_{(𝔥,L)} = ℂ[L] ⊗ M(1).` &nbsp;**(3.9)**
> `Y(e^α ⊗ u, x)(e^β ⊗ v) = ε(α,β)e^{α+β} ⊗ x^{⟨α,β⟩} E^−(−α,x) Y(Δ̄(β,x)u, x) Δ̄(α,−x)v.` &nbsp;**(3.10)**

> "One can prove that the quadruple `(V_{(𝔥,L)}, Y, e⁰⊗1)` carries the structure of a vertex algebra,
> **by using a theorem of [FKRW] and [MP]**. Here, we give a uniform treatment for both the vertex
> algebras and their modules."

⇒ **§3 对 `L` 的全部假设 = (3.5)–(3.8)**：`L` 是 `𝔥` 的加法子群、`⟨α,α⟩ ∈ 2ℤ`、存在 2-上循环 `ε`。
**没有「非退化」，没有「正定」，没有「有限秩」**（有限秩只在 Remark 3.4 里作为额外假设出现）。
另注：作者点名还有第三条路线 **[FKRW]（Frenkel–Kac–Radul–Wang）+ [MP]（Meurman–Primc）**。

#### (h) ★★ Heisenberg 顶点代数本身（p.10，L1 逐字）——卡 (A) 的前半

> "It is well known now (cf. **[LL]**) that there exists a **unique vertex algebra structure on `V_ĥ(ℓ,0)`**
> with `1` as the vacuum vector and with `Y(h,x) = h(x) = Σ_{n∈ℤ} h(n)x^{−n−1}` for `h ∈ 𝔥`.
> Furthermore, for every nonzero `ℓ`, `V_ĥ(ℓ,0)` is a **vertex operator algebra of central charge
> `d = dim 𝔥`** with conformal vector
> `ω = (1/2ℓ) Σ_{r=1}^{d} h^{(r)}(−1)h^{(r)}(−1)**1**`,
> where `{h^{(1)},…,h^{(d)}}` is any **orthonormal basis** of `𝔥`."

> "It is also known (cf. **[LL]**) that every … module `(W, Y_W)` for vertex algebra `V_ĥ(ℓ,0)` is a
> **restricted `ĥ`-module of level `ℓ`** … **On the other hand, on every restricted `ĥ`-module `W` of
> level `ℓ`, there is a unique module structure `Y_W` for vertex algebra `V_ĥ(ℓ,0)`** with
> `Y_W(h,x) = h(x)` for `h ∈ 𝔥`."

> "It is known (cf. [LL]) that vertex algebras `V_ĥ(ℓ,0)` for `ℓ ≠ 0` are all isomorphic. In view of this,
> we restrict ourselves to the vertex operator algebra `V_ĥ(1,0)`. In literature, the vertex operator
> algebra `V_ĥ(1,0)` is also often denoted by **`M(1)`**."

**⇒ 中心荷 `c = dim 𝔥 = D` 是 L1 的**（且「orthonormal basis of `𝔥`」隐含 `𝔥` 非退化——
在 ℂ 上正交基存在 ⟺ 形式非退化，**与号差无关**，再次印证 (e)）。
**⚠ 但这三句 Li–Wang 全部写作 "It is well known (cf. [LL])"，不给 LL 的定理号 ⇒ 对 LL 是 L0。**
**`Proposition 3.2`（p.10，L1）**：restricted level-1、`𝔥(0)` 半单、`𝔥(n)` (n≥1) locally finite ⇒ `W` 完全可约。

### 36.4 ★★ **任务书点名的问题结算**：Gebert–Nicolai 1995 §2 到底自引的是谁（L1，参考文献表逐条读图）

刊 p.575 §2.1 开头（L1 逐字）：

> "**2. General Setup** — *2.1. Vertex algebras.* We shall provide a short primer to formal calculus and
> vertex algebras **following closely [19]**. In **[17]** the subject is treated thoroughly."

刊 p.578（L1 逐字）：

> "We shall give **a definition of vertex algebra [15]** using the **notation of [21]** which we believe is
> more accessible to physicists."

刊 p.574（L1 逐字）：

> "Our results are couched in the language of **vertex algebras [6, 17, 19]** (see also [33] for a treatment
> in the BV formalism), which is entirely equivalent to **the formulation of [24, 22]**, but slightly more
> convenient for our purposes because of its economy of notation. … they do not correspond to summable
> operators in the sense of [17]; in this respect, vertex algebras encompassing longitudinal states
> transcend **the definition given in [6, 17]**."

参考文献表（刊 pp.620–622，**L1 逐字**）——把上面每个方括号解开：

| 号 | 条目（逐字） |
|---|---|
| **[6]** | **Borcherds, R. E.: Vertex algebras, Kac-Moody algebras, and the monster. Proc. Nat. Acad. Sci. USA 83, 3068–3071 (1986)** |
| **[15]** | **Frenkel, I. B., Huang, Y., Lepowsky, J.: On axiomatic approaches to vertex operator algebras and modules. Memoirs of the American Mathematical Society 104, 594 (1993)** |
| **[17]** | **Frenkel, I. B., Lepowsky, J., Meurman, A.: Vertex Operator Algebras and the Monster. Pure and Applied Mathematics Vol. 134, San Diego, CA: Academic Press, 1988** |
| **[19]** | **Gebert, R. W.: Introduction to vertex algebras, Borcherds algebras, and the monster Lie algebra. Int. J. Mod. Phys. A8, 5441–5503 (1993)** |
| **[21]** | **Goddard, P.: Meromorphic conformal field theory. In: V. G. Kac (ed.), Infinite Dimensional Lie Algebras and Groups — Proceedings of the Conference held at CIRM, Luminy, July 4–8, 1988, Advanced Series in Mathematical Physics Vol. 7. Singapore: World Scientific, 1989, pp. 556–587** |
| **[22]** | Goddard, P.: Vertex operators and algebras. In: Furlan, Jengo, Pati, Sciama, Shafi (eds.), The ICTP Series in Theoretical Physics — Vol. 2, Superstrings, Supergravity and Unified Theories, Singapore: World Scientific, 1986, pp. 255–291 |
| **[24]** | Goddard, P., Olive, D.: Algebras, lattices and strings. In: J. Lepowsky, S. Mandelstam, I. M. Singer (eds.), Vertex Operators in Mathematics and Physics — Proceedings of a Conference November 10–17, 1983, MSRI Publications #3, New York: Springer, 1985, pp. 51–96 |
| **[26]** | **Goddard, P., Thorne, C. B.: Compatibility of the dual Pomeron with unitarity and the absence of ghosts in the dual resonance model. Phys. Lett. 40 B, 235–238 (1972)**（**注意刊上把 Thorn 印成 "Thorne"**） |
| [8] | Brower, R. C.: Spectrum-generating algebra and no-ghost theorem for the dual model. Phys. Rev. D6, 1655–1662 (1972) |
| [41] | Scherk, J.: An introduction to the theory of dual models and strings. Rev. Mod. Phys. 47, 123–164 (1975) |

**⇒ 任务书三选一的答案是「都不是单一一个」：**
- **公理定义**取自 **FHL 1993 (Memoirs AMS 104, no. 594)**；
- **记号**取自 **Goddard 1989「Meromorphic conformal field theory」**；
- **入门叙述**跟随 **Gebert 自己的 1993 综述 [19]**，**详尽处理**指向 **FLM 1988 [17]**；
- **"vertex algebra" 这一语言**归给 **[6] Borcherds + [17] FLM + [19] Gebert 三家并列**。
- **Borcherds 与 FLM 被 GN 逐字点名「不够用」**：纵向 DDF 算符「do not correspond to summable operators
  in the sense of [17] … transcend the definition given in [6, 17]」。**这条限制必须进图**：
  含纵向态的构造超出 Borcherds/FLM 原始定义。

另（刊 p.573，L1 逐字）：GN 把无鬼定理引作 **[26, 8, 41]**（Goddard–Thorn + Brower + Scherk），
并写「the longitudinal states (or operators) have zero norm and hence decouple in 26 dimensions by
the no-ghost theorem [26, 8, 41]」。

**⚠ 与既有记忆的一致性**：本条与 `reference_web-fetch-access-blockers` 里记的 pure.mpg.de 路线一致，
且 §34 之前记的「Goddard–Thorn 1972 = CERN-TH-1493」与这里的 Phys. Lett. 40B, 235–238 是同一篇。

### 36.5 ★★★★ **本轮对「不定号差」问题的最干净答案**：Gebert–Nicolai §2.2，刊 **p.583**（L1 逐字）

> "**2.2. Toroidal compactification of the bosonic string.** It is by no means obvious that nontrivial
> examples of vertex (operator) algebras exist. However, a class of vertex algebras is provided by
> **the following result (see [6, 17])**:
>
> **Associated with each nondegenerate even lattice `Λ` is a vertex algebra `(ℱ, 𝒱, 1, ω)`.
> If in addition `Λ` is positive definite then `(ℱ, 𝒱, 1, ω)` has the structure of a vertex operator algebra.**"

**⇒ 这一句把号差问题一刀切开，而且给了出处 [6] = Borcherds 1986，[17] = FLM 1988：**

| 格的假设 | 得到什么 |
|---|---|
| **非退化 + 偶**（**号差任意**，含洛伦兹） | **vertex algebra** ✔ |
| 再加 **正定** | vertex **operator** algebra |

**这正面回答了任务书的核心问题**，并**独立证实**了我在 §37.3(a) 里标为「推断」的那条
（洛伦兹格 ⇒ 是 VA 但不是 VOA）——**该条现在有来源，可以取消 inferred 标记**，
出处写 **Gebert–Nicolai, CMP 172 (1995), §2.2, p.583**（本身是转述 [6]、[17]，**无编号定理**，
所以对 Borcherds/FLM 而言仍是 L3）。

#### 构造的逐字细节（刊 pp.584–586，L1）——与卡 (A) 的物理写法一一对上

> "Let `Λ` be an even lattice of rank `d < ∞` with a symmetric **nondegenerate** ℤ-valued ℤ-bilinear form
> `·⌣·` and **corresponding metric tensor `η^{μν}`**, `1 ≤ μ, ν ≤ d` (`Λ` even means that `r² ∈ 2ℤ` for all
> `r ∈ Λ`). The vertex algebra `(ℱ, 𝒱, 1, ω)` which we shall construct can be thought of as a **bosonic
> string theory with `d` spacetime dimensions compactified on a torus**. Thus `Λ` represents the allowed
> momentum vectors of the theory. We take **`Λ_ℝ := ℝ ⊗_ℤ Λ`** to be the real vector space in which `Λ`
> is embedded."

**★ 注意 GN 在 ℝ 上做**（`Λ_ℝ`、`η^{μν}`、厄米性 (2.69)），**号差在这里是真不变量**——
这与 §36.3(e) 说的「ℂ 上号差不可见」互补：**GN 是本轮唯一一个把不定 `η` 写成实矩阵的来源。**

| 式号 | 内容（L1 逐字/近逐字） |
|---|---|
| **(2.67)** | `(Ψ_r, Ψ_s) = δ_{r,s}`（零模态 "zero mode states"，**by definition orthonormal**） |
| **(2.68)** | **`[α^μ_m, α^ν_n] = m η^{μν} δ_{m+n,0}`** ← **不定号差 `η` 出现的确切位置** |
| **(2.69)** | `(α^μ_m)† = α^μ_{−m}` |
| **(2.72)/(2.73)** | `r(m) := Σ_μ r_μ α^μ_m ≡ r·α_m`；`[r(m), s(n)] = m(r·s)δ_{m+n,0}` |
| **(2.74)** | `ĥ := { r(m) \| r ∈ Λ_ℝ, m ∈ ℤ }`，正文称 "the `d`-fold **Heisenberg algebra**" |
| **(2.76)** | `[q^ν, p^μ] = i η^{μν}` |
| **(2.81)** | `e^r e^s = (−1)^{r·s} e^s e^r` |
| **(2.88)** | `1 → {±1} → Λ̂ → Λ → 1`（2-上循环 ⟺ 中心扩张） |
| **★ (2.90)** | **`ℱ := S(ĥ^−) ⊗ ℝ{Λ}`** —— "The Fock space associated with the lattice `Λ`" |
| **(2.95)/(2.98)** | `𝒱(e^r,z) = e^{∫r_<(z)dz} e^r z^{r(0)} e^{∫r_>(z)dz} = :e^{i r·Q(z)}: c_r` |
| **(2.97)** | `Q^μ(z) ≡ q^μ − i p^μ ln z + i Σ_{m∈ℤ} (1/m) α^μ_m z^{−m}`（Fubini–Veneziano 场） |

**★★ 一条必须写进卡 (A) 的更正**（刊 p.585，L1 逐字）：

> "One might expect the full Fock space `ℱ` of the vertex algebra to be `S(ĥ^−) ⊗ ℝ[Λ]`.
> **However, it is well known that we must replace the group algebra `ℝ[Λ]` by something more delicate
> in order to adjust the signs in the Jacobi identity for the vertex algebra.** We will multiply `e^{ir·q}`
> by a so-called **cocycle factor** `c_r` … We will take the **twisted group algebra `ℝ{Λ}`** consisting of
> the operators `e^r`, `r ∈ Λ`, instead of `ℝ[Λ]`."

⇒ 卡 (A) 写「`⊗ ℂ[ℤk₀]`」**在一般情形是错的**，应是**扭群代数** `ℂ_ε[L]`。
**但**：当 `L = ℤk₀` 且 `k₀` 类光时 `⟨mk₀, nk₀⟩ = 0`，由 (2.81) 知 `e^r` 互相对易，
且 Li–Wang **Remark 3.4** 给的显式 `ε(α_i,α_j) = (−1)^{⟨α_i,α_j⟩} (i<j), 1 (i≥j)` 在秩 1 时恒为 1
⇒ **此特例下扭群代数 = 普通群代数 `ℂ[ℤk₀]`**。
**⚠ 这一步（"此特例下可以退化成普通群代数"）是我的推断，没有来源直接写出来 ⇒ 图里标 `inferred: true`。**

#### 顺带：GN 对无鬼定理的表述（刊 p.583，L1 逐字）

> "It is well known that there are **additional null physical states in `ℛ_{(1)}` if and only if the central
> charge takes the critical value `c = 26`**, namely the space `(L_{(−2)} + (3/2)L²_{(−1)})ℛ_{(−1)}`
> (see [27] for the calculations). **The existence of these additional null physical states is used in the
> proof of the no-ghost-theorem [26].**"

（`ℛ_{(n)}` = 权 `n` 的 primary states；**(2.63)** `g_ℱ := ℛ_{(1)}/L_{(−1)}ℛ_{(0)}` = 物理态李代数；
**(2.64)** `L_{(−1)}ℱ_{(0)} ∩ ℛ_{(1)} = L_{(−1)}ℛ_{(0)}`，正文说这在**任何**顶点代数里都成立。）

## 37. 卡 (B)：Borcherds / Jacobi 恒等式与对易子公式的带编号来源

### 37.1 Gebert, *Introduction to vertex algebras, Borcherds algebras and the Monster Lie algebra*（L4，ar5iv 中介）

| 项 | 值 | 等级 |
|---|---|---|
| 作者 | Reinhold W. Gebert | L2 |
| 出处 | **Int. J. Mod. Phys. A8 (1993) 5441–5504**；preprint **DESY 93-120**；**arXiv:hep-th/9308151** | L2/L4 |

**ar5iv HTML 读取（L4，检索中介转述，非我逐字读图）：**

- **Jacobi 恒等式**是 §3.1 **Definition 1 的第 5 条**（形式变量版在定义的枚举列表里，**无独立公式号**）；
  其**模式展开版**是**公式 (27)**，附条件 "for all ψ,φ,ξ ∈ ℱ, l,m,n ∈ ℤ"。
- **★ 对易子公式 = 公式 (29)**，正文标签逐字 "(Commutator formula)"：
  `[ψ_m, φ_n] = Σ_{i≥0} C(m,i) (ψ_i φ)_{m+n−i}`
  —— **这正是卡 (B) 要的那条公式**，且与任务书给的形状一致（`i` ↔ `k`）。
- 引言逐字：「In Section 4 we construct this important class of examples of vertex algebras (**cf. [Borc86]**).」
  ⇒ Gebert 把格点顶点代数的出处指给 **Borcherds 1986（PNAS）**，**不是** FLM、**不是** Frenkel–Kac。
- **⚠ 截断**：ar5iv 渲染在 §3.6 "Symmetry products" 处截断，**§4（even lattices）正文未取到**，
  所以「Gebert 对号差的假设」本轮**仍是 L0**。

*（本节按来源逐个追加。）*

### 37.2 ★★★ Borcherds 1986 PNAS §4 的**原始公理 (i)–(v)**（L1 全文读图，逐字）

出处同 §36.2（作者主页重排本）。**Section 4. Vertex Algebras.** 全文逐字：

> "We will list some identities satisfied by the operators `u_n` and show how to construct Lie algebras
> from them. `u`, `v`, and `w` denote elements of `V`, and 1 is the unit of `V`.
> **For any even lattice `R` the operators `u_n` on `V` satisfy the following relations.**
>
> (i) `u_n(w) = 0` for `n` sufficiently large (depending on `u, w`). This ensures convergence of the following formulae.
> (ii) `1_n(w) = 0` if `n ≠ −1`, `w` if `n = −1`.
> (iii) `u_n(1) = D^{(−n−1)}(u)`.
> (iv) `u_n(v) = Σ_{i≥0} (−1)^{i+n+1} D^{(i)}(v_{n+i}(u))`.
> (v) `(u_m(v))_n(w) = Σ_{i≥0} (−1)^i C(m,i)( u_{m−i}(v_{n+i}(w)) − (−1)^m v_{m+n−i}(u_i(w)) )`.
> (The binomial coefficient `C(m,i)` is equal to `m(m−1)…(m−i+1)/i!` if `i ≥ 0` and 0 otherwise.)"

（原文用 `\binom{m}{i}`，我这里写成 `C(m,i)`；`D^{(i)}` 定义见 Section 2 (ii)：`D` 是导子，`D^{(i)} := D^i/i!`。）

**⚠★ 关键的负面结论——这条必须写进图，否则会被审计打回：**
**Borcherds 的 (v) 不是任务书要的对易子公式。** (v) 是 Borcherds 恒等式的
**「迭代 / 结合律」形式**（左边是单个 `(u_m(v))_n(w)`）。
任务书要的 `[a_(m), b_(n)] = Σ_k C(m,k)(a_(k)b)_(m+n−k)` 左边是**对易子**，是同一个 Jacobi 恒等式的**另一半**。
**从 (v) 推出对易子公式是一步真实的推导，Borcherds 1986 原文没有写出来。**
⇒ 卡 (B) 若引 Borcherds 1986，必须标 `inferred: true`，或改引下面给出对易子公式**显式**的来源
（Gebert 公式 (29)、Kac (4.8.x)、Schottenloher Thm 10.10 第 5 条）。

**模的定义（L1 逐字，Section 4 后段）** ——卡 (A) 的「动量塔是其模」用得上：

> "A module over a vertex algebra `V` is a module `W` with operators `u_n` on `W` satisfying relations
> *i*–*v* above for `u, v` in `V`, `w` in `W`. In particular `V` is a `V` module."

> "If `V` is any vertex algebra then `V/DV` is a Lie algebra, where `DV` is the sum of all the spaces
> `D^{(i)}(V)` for `i ≥ 1` and where the Lie algebra product is `[u,v] = u₀(v)`.
> Note that `u₀(v)` is not antisymmetric on `V`. Any `V` module `W` becomes a module for the Lie algebra
> `V/DV` by letting `v` in `V/DV` act as `v₀` on `W`."

**模的定义也对号差零假设**（沿用 §4 开头的 "for any even lattice"）。

### 37.3 ★★★ **本轮卡 (B) 的最佳来源**：Gebert–Nicolai, *CMP* **172** (1995) 571–622，**式 (2.38)**（L1 读图）

| 项 | 值 | 等级 |
|---|---|---|
| 作者 | R. W. Gebert, H. Nicolai | L1 |
| 标题 | *On `E₁₀` and the DDF Construction* | L1（页眉） |
| 出处 | **Commun. Math. Phys. 172 (1995) 571–622**；Communicated by R. H. Dijkgraaf | L1 |
| **获取** | **`https://pure.mpg.de/rest/items/item_153125_1/component/file_153124/content`**（2.5 MB，出版方排版扫描） | L1 |
| **页码换算** | **PDF 页 = 刊页 − 570**（PDF p.3 = 刊 p.573） | L1 |

#### (a) 顶点代数的公理表（刊 p.578，L1 逐字）

> "We shall give **a definition of vertex algebra [15] using the notation of [21]** which we believe is
> more accessible to physicists.
> A **vertex algebra** is a ℤ-graded vector space `ℱ = ⊕_{n∈ℤ} ℱ_{(n)}` **(2.22)**, equipped with a linear
> map `𝒱 : ℱ → (End ℱ)[[z, z^{−1}]]` … and the vertex operators satisfy the following axioms:
> 1. **(Regularity)** … `Res_z[z^n 𝒱(ψ,z)φ] = 0` for `n` sufficiently large **(2.23)**
> 2. **(Vacuum)** … `𝒱(1,z) = id_ℱ` **(2.24)**
> 3. **(Injectivity)** … `𝒱(ψ,z) = 0 ⟺ ψ = 0` **(2.25)**
> 4. **(Conformal vector)** … `𝒱(ω,z) = Σ_{n∈ℤ} L_{(n)} z^{−n−2}` **(2.26)**,
>    a) gives the **Virasoro algebra** with some central charge `c ∈ ℝ`,
>    `[L_{(m)}, L_{(n)}] = (m−n)L_{(m+n)} + (c/12)(m³−m)δ_{m+n,0}` **(2.27)**;
>    b) translation generator `L_{(−1)}` **(2.28)**; c) grading via `L_{(0)}` **(2.29)**
> 5. **(Jacobi identity)** … `z₀^{−1}δ((z₁−z₂)/z₀)𝒱(ψ,z₁)𝒱(φ,z₂) − z₀^{−1}δ((−z₂+z₁)/z₀)𝒱(φ,z₂)𝒱(ψ,z₁)
>    = z₂^{−1}δ((z₁−z₀)/z₂)𝒱(𝒱(ψ,z₀)φ, z₂)` **(2.30)**"

> "A **vertex operator algebra** is a vertex algebra with the additional assumptions that
> 1. **the spectrum of `L_{(0)}` is bounded below**, 2. the eigenspaces `ℱ_{(n)}` of `L_{(0)}` are
> finite-dimensional."（刊 p.579，L1 逐字）

> **⚠★ 这一条对本项目极重要**：洛伦兹格上 `L_{(0)}` 的谱**不下有界**（类时动量），
> 所以「`V_{II_{25,1}}` 是 vertex algebra 但**不是** vertex operator algebra」。
> **卡 (A) 必须写 "vertex algebra"，绝不能写 "vertex operator algebra"。**
> （**已结案**：GN 自己在刊 p.583 §2.2 把这条说出来了——「positive definite ⇒ vertex **operator** algebra」，
> 见 **§36.5**。所以这不再是我的推断，**有来源**。）

#### (b) ★★★ 模式形式的三条公式（刊 p.580，L1 逐字）——**卡 (B) 直接命中**

> 5. **(Jacobi identity)**
> `Σ_{i≥0} (−1)^i C(l,i) ( ψ_{l+m−i}(φ_{n+i}ξ) − (−1)^l φ_{l+n−i}(ψ_{m+i}ξ) ) = Σ_{i≥0} C(m,i) (ψ_{l+i}φ)_{m+n−i} ξ,`
> &nbsp;&nbsp;**(2.36)** &nbsp; for all `ψ, φ, ξ ∈ ℱ`, `l, m, n ∈ ℤ`.

> "In what follows we will frequently make use of two important formulas which are **the special cases
> `m = 0` and `l = 0`, respectively, of Eq. (2.36)**:
>
> **(Associativity formula)** `(ψ_lφ)_n = Σ_{i≥0} (−1)^i C(l,i) ( ψ_{l−i}φ_{n+i} − (−1)^l φ_{l+n−i}ψ_i )` &nbsp;**(2.37)**
>
> **★ (Commutator formula)** `[ψ_m, φ_n] = Σ_{i≥0} C(m,i) (ψ_i φ)_{m+n−i}` &nbsp;**(2.38)**
>
> for all `ψ, φ, ξ ∈ ℱ`, `l, m, n ∈ ℤ`."

**⇒ 式 (2.38) 与任务书给的 `[a_(m), b_(n)] = Σ_k C(m,k)(a_(k)b)_(m+n−k)` 逐字一致（`i ↔ k`）。**
**这是本轮唯一一个「带编号 + 同行评议 + 我逐字读到」的对易子公式来源。**
而且原文**明说**它是 Jacobi 恒等式 (2.36) 的 `l = 0` 特例 —— 卡 (B) 的「Borcherds 恒等式 ⇒ 对易子公式」
这一步在这里**有出处，不必标 inferred**。

**⚠ 记号陷阱（刊 p.581，L1）**：GN 同时用两套模式展开——
`𝒱(ψ,z) = Σ_n ψ_n z^{−n−1}` **(2.31)**（形式演算用，圆括号**外**）与
`ψ(z) = Σ_n ψ_{(n)} z^{−n−Δ_ψ}` **(2.47)**（CFT 用，圆括号**内**），换算是
`ψ_n ≡ ψ_{(n+1−Δ_ψ)}`，`ψ_{(n)} ≡ ψ_{n−1+Δ_ψ}` **(2.48)**。
**(2.38) 用的是不带圆括号的 `ψ_m`（即 (2.31) 那套）。**引用时必须连这条换算一起写，否则会与 Virasoro 的
`L_{(n)}` 记号打架。

其余顺带取到的编号（L1）：**(2.41)** `[L_{(n)}, 𝒱(φ,z)] = Σ_{i≥−1} C(n+1, i+1) 𝒱(L_{(i)}φ, z) z^{n−i}`；
**(2.42)/(2.43)** 其 `n = −1, 0` 特例；**(2.50)/(2.51)** 斜对称；**(2.52)** `𝒱(ψ,z)1 = e^{zL_{(−1)}}ψ`；
**(2.40)** `L_{(−1)}1 = 0`；**(2.16)** `Res_z[w(z)] = w_{−1}`；**(2.17)** `w_n = Res_z[z^{−n−1}w(z)]`。

### 37.4 ★★ Bakalov–Kac, arXiv:math/0402315：**(2.19) Borcherds 恒等式 + (2.21) 对易子公式 + Theorem 4.1**（L1 读图）

| 项 | 值 | 等级 |
|---|---|---|
| 作者 | Bojko Bakalov (NCSU), Victor G. Kac (MIT) | L1 |
| 标题 | *Twisted Modules over Lattice Vertex Algebras* | L1（页眉逐字） |
| id / 出处 | **arXiv:math/0402315**；出版于 *Lie Theory and Its Applications in Physics V*, World Sci., 2004, pp. 3–26 | L1 / L2 |
| 获取 | `https://arxiv.org/pdf/math/0402315` → 落盘 213 KB → `Read(pages=)`；**PDF 页 = 文章页** | L1 |

**为什么它重要**：Kac 本人是作者，且 §4.1 开头逐字写「**For more details, see [13]**」（[13] = Kac 的书），
**所以这是「Kac 书 §5.4/5.5 内容」的作者背书版，且它是公开可取的**。

#### (a) **Definition 2.1**（顶点代数，p.3，L1 逐字要点）

局域性公理 + `(2.14)` 平移协变 `[T, Y(a,z)] = ∂_z Y(a,z)` + `(2.15)(2.16)` 真空公理；
`(2.13)` `a ↦ Y(a,z) = Σ_{m∈ℤ} a_{(m)} z^{−m−1}`；`(2.17)` `Ta = a_{(−2)}|0⟩`；`(2.18)` 斜对称 `Y(a,z)b = e^{zT}Y(b,−z)a`。

> "The most important property of a vertex algebra `V` is the following **Borcherds identity**
> (which along with the vacuum axioms provides **an equivalent definition** of a vertex algebra):
> `Res_{z−w} Y(Y(a, z−w)b, w) i_{w,z−w} F(z,w)`
> `= Res_z Y(a,z)Y(b,w) i_{z,w} F(z,w) − Res_z Y(b,w)Y(a,z) i_{w,z} F(z,w)` &nbsp;&nbsp;**(2.19)**
> for any `a, b ∈ V` and **any rational function `F(z,w)` with poles only at `z = 0`, `w = 0` or `z = w`**."

> "Let us give some consequences of the Borcherds identity. Taking `F(z,w) = (z−w)^n δ(u−z)`,
> viewed as a series in `u, u^{−1}`, we obtain
> `Y(a,z)Y(b,w) i_{u,w}(u−w)^n − Y(b,w)Y(a,u) i_{w,u}(u−w)^n = Σ_{m=0}^{∞} Y(a_{(m+n)}b, w) ∂_w^{(m)} δ(u−w).`
> &nbsp;&nbsp;**(2.20)**
> **For `n = 0` this gives the commutator formula**
> `[Y(a,u), Y(b,w)] = Σ_{m=0}^{∞} Y(a_{(m)}b, w) ∂_w^{(m)} δ(u−w),` &nbsp;&nbsp;**(2.21)**
> (which implies locality). Taking `Res_u` of (2.20), we get
> `Y(a,w)_{(n)}Y(b,w) = Y(a_{(n)}b, w), n ∈ ℤ.` &nbsp;&nbsp;**(2.22)**"

**⚠ 注意 (2.21) 是「场版」对易子公式（带 `δ` 函数），不是任务书要的「模式版」
`[a_(m), b_(n)] = Σ_k C(m,k)(a_(k)b)_(m+n−k)`。**两者由取 `Res` 相联，但 **Bakalov–Kac 没写模式版**。
⇒ **卡 (B) 的模式版仍应首引 Gebert–Nicolai (2.38)**（§37.3），Bakalov–Kac (2.19)/(2.21) 作第二来源。
（**扭转版**倒是给了模式版：**Remark 3.1 的 (3.7)** 是含 `σ`-扭转的 Borcherds 恒等式模式展开，
`σ = 1` 时退化为普通情形——但要读者自己取 `σ=1`，属额外一步。）

#### (b) ★★★ **Theorem 4.1**（p.9，L1 逐字）——**对格的假设弱到只剩「integral」**

§4.1 开头（p.8，L1 逐字）：

> "**4.1. Lattice Vertex Algebras.** The purpose of this subsection is to fix the notation and review some
> properties of lattice vertex algebras. **For more details, see [13].**
> **Let `Q` be an integral lattice of rank `l`.** We denote the bilinear form on `Q` by `(·|·)`, and write
> `|α|² = (α|α)` for `α ∈ Q`. We extend the bilinear form to **`𝔥 = ℂ ⊗_ℤ Q`** by ℂ-bilinearity.
> There exists a bimultiplicative function `ε : Q × Q → {±1}` satisfying
> `ε(α,α) = (−1)^{|α|²(|α|²+1)/2}` **(4.1)** … `ε(α,β)ε(β,α) = (−1)^{(α|β)+|α|²|β|²}` **(4.2)**
> … the **twisted group algebra `ℂ_ε[Q]`** … `e^α e^β = ε(α,β)e^{α+β}` **(4.3)**"

> "Let `ĥ = 𝔥[t,t^{−1}] ⊕ ℂK` be the **Heisenberg current algebra**; this is a Lie algebra with the bracket
> `[ht^m, h't^n] = m δ_{m,−n}(h\|h')K`, `[ht^m, K] = 0` **(4.4)**.
> It has a **unique irreducible representation of level 1** (i.e., with `K = 1`) on the Fock space
> `S = S(𝔥[t^{−1}]t^{−1})` such that `𝔥[t^{−1}]t^{−1}` acts by multiplication and `𝔥[t]1 = 0`.
> This representation extends to the space **`V_Q = S ⊗ ℂ_ε[Q]`**"

> "**Theorem 4.1.** *The fields `Y(ht^{−1}, z) = h(z)` (`h ∈ 𝔥`), of parity 0, and `Y(e^α, z) = Y_α(z)`
> (`α ∈ Q`), of parity `p(e^α) = |α|² mod 2ℤ`, **generate a vertex algebra structure on
> `V_Q = S ⊗ ℂ_ε[Q]`** with the vacuum vector `|0⟩ = 1 ⊗ 1` and the operator `T` defined by
> `[T, ht^m] = −m ht^{m−1}`, `Te^α = (αt^{−1})e^α`, `h ∈ 𝔥, α ∈ Q`. **(4.15)**
> **This vertex algebra is conformal of rank `l = rank Q`** with the conformal vector
> `ν = ½ Σ_{i=1}^{l} (a^i t^{−1})(b^i t^{−1})`, **(4.16)**
> where `{a^i}, {b^i}` are **dual bases** of `𝔥`.*"

**假设总结（L1）**：只要求 **`Q` 是 integral lattice**。
**没有 even**（用 ℤ₂-分次 (4.8)/(4.9) 处理奇的情形 ⇒ 一般是**顶点超代数**；`Q` 偶 ⇒ 宇称全 0 ⇒ 普通顶点代数）、
**没有 positive definite**、**没有明写 nondegenerate**（但 (4.16) 的 "dual bases of `𝔥`" **隐含**非退化）。

#### (c) ★★★ 红旗：**Theorem 4.1 的「conformal」与它自己的 Definition 2.2(iii) 在不定号差下打架**

> "**Definition 2.2.** A vertex algebra `V` is *conformal* of central charge (or rank) `c ∈ ℂ` if there exists
> a vector `ν ∈ V` (the conformal vector) with the following properties: (i) … Virasoro … (ii) `L_{−1}` is `T`
> … **(iii) The operator `L_0` is diagonalizable with a non-negative spectrum.**" （p.4，L1 逐字）
> "The operator `L_0` defines a gradation of `V`, **`V = ⊕_{Δ≥0} V(Δ)`**" **(2.24)**（p.4，L1）

`V_Q` 上 `L_0` 在 `e^α` 上的本征值是 `|α|²/2`。**`Q` 不定 ⇒ 存在 `|α|² < 0` ⇒ 谱不下有界 ⇒ 违反 (iii)。**
但 Theorem 4.1 对**任意** integral `Q` 都断言 "This vertex algebra is conformal of rank `l`"。

**⇒ 结论（这是我的核对，不是原文自述）：Bakalov–Kac Theorem 4.1 的「conformal」一句
在不定号差下与其 Definition 2.2(iii) 不相容；要么正定是未写出的隐含假设，要么 (iii) 在这里被默默放宽。**
**图里若引 Theorem 4.1，只能引它的前半句「generate a vertex algebra structure on `V_Q`」，
不得连「conformal of rank `l`」一起引**，否则会把一条不自洽的陈述带进图。
这与 §36.5 的 Gebert–Nicolai 划分（非退化偶 ⇒ VA；再正定 ⇒ VOA）完全一致——
**GN 的划分是对的，Bakalov–Kac 这句是松的。**

## 38. 图里建议怎么引（供 curator 取舍；researcher 不改 `graph/`）

### 38.1 ★ 先看这张：本轮结论表

| 问题 | 答案 | 等级 |
|---|---|---|
| **不定号差被哪本书哪个编号覆盖？** | **没有任何一本书用「不定号差」这个词给出带编号定理。**覆盖它的是**「非退化」这个更弱的条件**，而在 ℂ 上号差根本不是不变量。最干净的**带编号**覆盖是 **Li–Wang arXiv:0802.0173 Theorem 3.6**（假设只有 (3.5) `⟨α,α⟩∈2ℤ`）与 **Bakalov–Kac math/0402315 Theorem 4.1**（假设只有「`Q` integral」）。最干净的**成句**覆盖是 **Gebert–Nicolai CMP 172 (1995) p.583 §2.2**（无编号）。 | L1 |
| 「洛伦兹格 ⇒ 顶点代数」是否成立 | **成立**，且**不需要**任何号差假设 | L1 |
| 「洛伦兹格 ⇒ 顶点**算子**代数」 | **不成立**（需正定）。GN p.583 明写；Bakalov–Kac Def 2.2(iii) 也蕴含这一点 | L1 |
| 类光 `k₀`（格退化） | **Borcherds §5**（`L_i`, `i ≥ −1` 在 singular 格上仍有定义）+ **Li–Wang §4 标题 `⟨·,·⟩\|_L = 0`** 双覆盖 | L1 |
| 卡 (B) 对易子公式的最佳带编号来源 | **Gebert–Nicolai (2.38)**（模式版，且原文明说是 Jacobi (2.36) 的 `l=0` 特例） | L1 |
| Kac 书 §5.4/5.5 的定理号 | **未核实（L0）**，见 §38.2 | L0 |
| LL Thm 6.5.x | **未核实（L0）**，见 §38.2 | L0 |
| FLM §8.4–8.6 Thm 8.x | **未核实（L0）**，连 §8 标题都没拿到 | L0 |

### 38.2 ⚠ 未能核实的候选（**一律不写进图，`sources.bib` 也只登记书目不登记编号**）

| 候选 | 本轮拿到什么 | 等级 | 结论 |
|---|---|---|---|
| **Kac, *VA for Beginners* 2nd ed. §5.4/5.5** | 检索后端给章节标题：**§5.4 "Lattice vertex algebras"、§5.5 "Simple lattice vertex algebras"、§5.6 "Root lattice vertex algebras and affine vertex algebras"**；**任务书猜的「Theorem 5.5」实际上 5.5 是节号不是定理号**，很可能是误读 | **L4** | **不得写 `Kac, Theorem 5.5`。**§5.4/5.5 的**定理号与号差假设本轮完全没拿到**。Kac 本人勘误表（`math/9901070`，§10 已读）**只覆盖到第 4 章，不含第 5 章** ⇒ 勘误表这条路对第 5 章无效 |
| **Kac, (4.8.3) Borcherds identity / Thm 4.8** | §10.1 已由勘误表 L1 确认**存在** Theorem 4.8 与 **(4.8.1)**；**任务书写的 (4.8.3) 本轮无任何证据** | L1（4.8.1）/ **L0**（4.8.3） | 引 Kac 时只能写 **Theorem 4.8 / (4.8.1)**，**不要写 (4.8.3)** |
| **Lepowsky–Li §6.3–6.5, Thm 6.5.x** | 检索后端转述某学位论文引 **「[LL] Theorem 6.2.11 and Theorem 6.3.2」**与**「[LL] Theorem 5.7.1」**；另有来源按**节**引「[LL04] Sections 6.4 and 6.5」。**任务书点名的 6.5.3 没有任何证据** | **L4** | **不得写 `LL, Theorem 6.5.3`。**Li–Wang 全篇引 [LL] 都写 "It is well known (cf. [LL])"，**一个定理号都不给** ⇒ 这个方向本轮彻底堵死。上一轮就是卡在这里停摆的，**建议下一轮改走 DNB TOC 扫描件路线**（见 §38.6） |
| **FLM 1988 §8.4–8.6 Thm 8.x** | **零证据**。三份参考文献表只给书目；转引到的 FLM 编号全在**第 1、4、5 章**（Thm 1.7.3 / §1.7 / Prop 4.1.1 / Ch. 5），**没有一条落在第 8 章** | **L0** | **不得写 `FLM, Theorem 8.x`。**任务书假设「FLM 处理一般非退化偶格含洛伦兹」**本轮既未证实也未证伪** |
| **Frenkel–Ben-Zvi §5.2/5.4** | 本轮**未查**（预算用于更高价值目标）。§9 与记忆里记的 FBZ 勘误表覆盖的是 **Thm 3.2.1 / Prop 3.2.8 / Lemma 3.2.6**，不含第 5 章 | **L0** | 留给下一轮 |
| **Dolan–Goddard, *Conformal vertex algebras*** | 任务书给的 arXiv:1305.3757 **未核实该 id 是否对应此文**；本轮未查 | **L0** | 留给下一轮。**注意**：GN 引的 Goddard 是 **1989「Meromorphic conformal field theory」（会议文集，非 arXiv）**，与 Dolan–Goddard 是两回事，别混 |
| **Gebert 1993 综述（hep-th/9308151）** | ar5iv 中介给到 **Jacobi 恒等式 = Definition 1 第 5 条 + 模式版公式 (27)**、**对易子公式 = 公式 (29)**；**§4（even lattices）被截断，号差假设未取到** | **L4** | 公式号 (27)/(29) 与 GN 的 (2.36)/(2.38) 一一对应，互为旁证；但**未逐字读过**，**不作为唯一依据**，也**不登记进 `sources.bib`** |

### 38.3 卡 (A)「洛伦兹格顶点代数 + 动量塔是其模」——建议挂三条独立推导

**陈述文本建议（researcher 的措辞建议，curator 可改）：**

> 设 `𝔥` 是 `D` 维复向量空间、带非退化对称双线性型（其实形式的号差为 `(D−1,1)`，见下文约定注）；
> 设 `L ⊂ 𝔥` 是加法子群且 `⟨α,α⟩ ∈ 2ℤ (∀α ∈ L)`。则 `V_{(𝔥,L)} = ℂ_ε[L] ⊗ M(1)` 带 (3.10) 定义的 `Y`、
> 真空 `e⁰⊗1`，构成一个**顶点代数**（**不是**顶点算子代数）；其不可约模由 `λ ∈ L°/L` 与一个不可约
> restricted `ℒ₁`-模参数化。

| 推导 | 来源 | 建议 `status` | 说明 |
|---|---|---|---|
| **D1（首选）** | `li-wang-2008`，**Theorem 3.6**（loc: `Thm 3.6, p.13, arXiv:0802.0173v1`）+ **Theorem 3.10** + **(3.17)** | **`rigorous`** | 唯一一条**带编号 + 有完整证明 + 假设弱到覆盖类光**的。**动量塔**直接是 Thm 3.10 + (3.17) |
| **D2** | `borcherds-1986`，**Section 4, relations (i)–(v)**（loc: `Sec. 4`，**不要写页码、不要写 Theorem**） | **`rigorous`** | 原始文献。逐字 "For any even lattice R"。**但无编号、无证明细节**，且 `L_i` 只在 `i ≥ −1` 上有定义（Section 5） |
| **D3** | `bakalov-kac-2004`，**Theorem 4.1 前半句**（loc: `Thm 4.1, p.9`） | **`rigorous`** | 假设最弱（只要 integral）。**必须在 note 里写明「不引其 conformal 断言」**（§37.4(c) 的红旗） |

**必须一并写进节点的四条限制：**

1. **只能说 "vertex algebra"，不能说 "vertex operator algebra"。** 来源：`gebert-nicolai-1995` p.583 §2.2（`inferred: false`）。
2. **`⊗ ℂ[ℤk₀]` 一般要换成扭群代数 `ℂ_ε[L]`。** 来源：`gebert-nicolai-1995` p.585 逐字。
   秩 1 类光时可退化为普通群代数——**这一步标 `inferred: true`**（§36.5 末）。
3. **`L_n` 只对 `n ≥ −1` 定义（当 `L` 退化时）。** 来源：`borcherds-1986` Section 5 逐字。
4. **号差在 ℂ 上不可见**：`graph/conventions/` 里若已有「度规号差 `(−,+,…,+)`」约定，
   本节点**不应**声明依赖它——真正依赖号差的是**内积/鬼态**那一族节点，不是本节点。
   建议 curator 在本节点 note 里显式写这句，防止 reviewer 误判缺约定声明。

**新增中心荷子节点（可选）**：`c = dim 𝔥 = D`。
来源二选一：`li-wang-2008` p.10（"vertex operator algebra of central charge `d = dim 𝔥`"，L1 逐字，但**它说的是 `M(1)` 即纯 Heisenberg，正定情形**）
或 `borcherds-1986` Section 5 的 `[L_i,L_j]` 公式读数（**读数属推断，标 `inferred: true`**）。

### 38.4 卡 (B)「Borcherds/Jacobi 恒等式 + 对易子公式」——建议拆成两张卡

**⚠ 本轮最重要的结构性发现：任务书把两条不同强度的陈述写在一张卡上了。**

| 子卡 | 内容 | 首选来源 | `status` |
|---|---|---|---|
| **B1** | **Borcherds/Jacobi 恒等式**（公理，或与真空公理一起构成顶点代数的等价定义） | `bakalov-kac-2004` **(2.19)**（loc: `eq. (2.19), p.3`）——逐字自称 "provides **an equivalent definition** of a vertex algebra"；第二来源 `gebert-nicolai-1995` **(2.30)**（形式变量版）/ **(2.36)**（模式版） | `rigorous` |
| **B2** | **对易子公式** `[a_(m), b_(n)] = Σ_k C(m,k)(a_(k)b)_(m+n−k)` | **`gebert-nicolai-1995` (2.38)**（loc: `eq. (2.38), p.580`）——**模式版，逐字，且原文明说是 (2.36) 的 `l = 0` 特例** | `rigorous` |

**B1 → B2 这条边**：**有来源，不必标 `inferred`**——GN p.580 逐字「which are the special cases `m = 0` and `l = 0`,
respectively, of Eq. (2.36)」。**这是本轮把这条边从 `inferred` 提升为有据的关键收获。**

**不要这样引（会被审计打回）：**
- ❌ `borcherds-1986, (v)` 当作对易子公式——(v) 是**迭代/结合律**形式，不是对易子（§37.2）。
- ❌ `bakalov-kac-2004, (2.21)` 当作模式版对易子公式——(2.21) 是**场版（带 `δ` 函数）**（§37.4(a)）。
- ❌ `Kac, (4.8.3)` ——该编号无任何证据（§38.2）。
- ❌ 任何 `LL, Theorem 6.5.x`（§38.2）。

**已有的第三来源**（本文件既有小节，可交叉挂）：`schottenloher-2008` **Theorem 10.10 第 5 条**（§11、§11A.3），
注意那里印本印作 `j = 1` 而正确下限是 `j = 0`，引用时必须留痕。

### 38.5 与既有图节点的关系（researcher 的观察，不是指令）

- `sources.bib` 里 **`gebert-nicolai-1995` 的既有 note 已经记了 (2.36)/(2.37)/(2.38)**，
  说明前一轮已经读到过 p.580。本轮的增量是：**(a) 把 §2 的自引全部解开（[6]/[15]/[17]/[19]/[21]/[26]/[27]）；
  (b) 拿到 p.583 §2.2 的号差判据；(c) 结掉该条目里「[26]/[27] 身份未核实」这个 L0。**
- 本轮**没有**找到任何来源证明「带不定 Hermitian 内积的顶点代数」的带编号定理。
  **无鬼定理回 `rigorous` 的真瓶颈不在卡 (A)/卡 (B)**——这两张卡本轮都能挂到 `rigorous` 来源上；
  瓶颈在**内积/正定性那一层**（Borcherds Section 2 (v) 的那个不定内积）。
  这与本文件 §14.2 记的缺口、以及记忆 `lit-ope-vertex-algebra-numbered-theorems` 末尾的缺口**是同一个**。

### 38.6 访问日志与未解决问题（本节）

| 目标 | URL / 手法 | 结果 |
|---|---|---|
| **Borcherds 1986 PNAS 全文** | **`math.berkeley.edu/~reb/papers/va/va.pdf`** | **成功**（112 KB，5 页全读；**作者主页 `~reb/papers/` 目录页可列出 38 篇的相对路径**） |
| **Li–Wang 全文** | `arxiv.org/pdf/0802.0173` | **成功**（246.9 KB；读 pp.1–3, 10–20） |
| **Bakalov–Kac 全文** | `arxiv.org/pdf/math/0402315` | **成功**（213 KB；读 pp.3–5, 8–12。**老式 `math/` id 在 PDF 路由下可用**） |
| **Gebert–Nicolai 全文** | `pure.mpg.de/rest/items/item_153125_1/component/file_153124/content` | **成功**（2.5 MB 扫描 PDF；读刊 pp.573–586, 620–622。**PDF 页 = 刊页 − 570**） |
| Gebert 1993 综述 | `ar5iv.labs.arxiv.org/html/hep-th/9308151` | **部分成功**：拿到 (27)/(29)，**§4 被截断** |
| Li–Wang 编号（中介） | `ar5iv.labs.arxiv.org/html/0802.0173` | 成功（后被 PDF 逐字复核，**中介转述的 Thm 3.6/3.10/4.1 全部属实**） |
| Bakalov–Kac（中介） | `arxiv.org/html/math/0402315` | **意外成功**（老论文竟有 HTML；其「[13] 无章节号」的判断被 PDF 证实） |
| Albany 学位论文（LL 编号） | `scholarsarchive.library.albany.edu/cgi/viewcontent.cgi?article=1424&context=legacy-etd` | **失败：HTTP 403**（**新增死路**） |
| arXiv abs 页取正文 | `arxiv.org/abs/1801.03753` | **失败（自找的）**：abs 页只有摘要。**记忆里已有这条纪律，本轮仍踩了一次** |
| Kac 书 §5.4/5.5 | WebSearch ×2 | 只拿到**节标题**（L4），无定理号 |
| LL Thm 6.5.x | WebSearch ×2 | 只拿到他人转引的 **6.2.11 / 6.3.2 / 5.7.1**（L4），**6.5.3 无证据** |

> **本轮新增的可复用路线**：
> **★ 作者主页 `math.berkeley.edu/~reb/papers/` 是 Borcherds 全部 38 篇论文的免费 TeX/dvi/PDF 目录**，
> 路径形如 `~reb/papers/<slug>/<slug>.pdf`（`va` = PNAS 1986，`fake` = 1990 monster Lie algebra，
> `monster` = 1992 Invent. Math.，`vertex` = 1998，`bonn` = "What is a vertex algebra?"）。
> **对 pre-arXiv 的 1980 年代论文，这比任何聚合器都干净**——但注意是**作者重排本，页码与期刊不一致**。

**未解决 / 留给下一轮：**

- **Q30** **Kac, *VA for Beginners* 2nd ed. §5.4/5.5 的定理编号与对格的假设（L0）。**
  勘误表只到第 4 章，Google Books 只给页码不给内容。**下一招建议：DNB TOC 扫描件
  `d-nb.info/<IDN>/04`**（记忆里这招破过 Bourbaki 的 Springer 登录墙），或找一篇**逐字引用 §5.4/5.5 定理号**的论文。
- **Q31** **Lepowsky–Li Chapter 6 的定理编号（L0）——这是上一轮停摆的同一堵墙。**
  已知他人转引存在 **6.2.11 / 6.3.2 / 5.7.1**；**6.5.3 无任何证据，很可能任务书记错了。**
  下一招：Birkhäuser/Springer 的 DNB TOC 扫描件；或 Google Books 卷 `dlxCFmV1dKIC`
  （**先跑无意义字符串对照实验**，见记忆 `web-fetch-access-blockers`）。
- **Q32** **FLM 1988 §8 的标题与定理号（L0）。** 本轮零证据。任务书的假设「FLM §8.4–8.6 处理含洛伦兹的
  一般非退化偶格」**既未证实也未证伪**。注意 FLM 全书的 lattice 构造**主要在第 7–8 章**（未核实）。
- **Q33** **Borcherds 主页重排本与 PNAS 印本是否逐字一致。** 可用 PMC 扫描件（记忆里 FGZ 1986 = PMC386946
  的页图路线适用于同期 PNAS）复核 Section 4 的 (i)–(v)。**在复核前，`loc:` 一律写节号不写页码。**
- **Q34** **Bakalov–Kac Theorem 4.1「conformal of rank l」与 Definition 2.2(iii) 的不相容**（§37.4(c)）。
  这是我自己的核对结论，**没有第二来源**。若 curator 要在图里写「某某文献此处有松处」，
  建议先找一篇指出同一问题的文献；否则只在 note 里写「本项目核对发现」。
- **Q35** **Frenkel–Ben-Zvi §5.2/5.4 与 Dolan–Goddard（arXiv:1305.3757 的 id 是否正确）本轮未查。**
- **Q36** **「不定 Hermitian 内积下的顶点代数」仍无任何带编号定理**（§38.5）。这是无鬼定理回 `rigorous`
  的真瓶颈，与 §14.2 / 记忆 `lit-ope-vertex-algebra-numbered-theorems` 末尾记的缺口是同一个。

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

# § Riemann–Roch（供 `worldsheet.riemann-roch-kappa-minus-mu`）

## 42. Riemann–Roch 的可引编号来源：dim H⁰(K^{−1}) 与 dim H⁰(K²)（researcher，2026-09-11）

### 39.0 需求侧：图里到底要一条什么定理

图卡 `worldsheet.riemann-roch-kappa-minus-mu` 的 `notes` 里有一条点名给 researcher 的 TODO：
"登记一个可核实的**数学**来源 —— 紧黎曼面上线丛的 Riemann–Roch（或 P₁ 这一椭圆算子的 Atiyah–Singer 指数）"，
目的是给 `κ − μ = 3χ` 另起一条能到 `rigorous` 的推导（现有唯一推导走鬼数流 Weyl 反常，且**比例常数靠球面一个例子标定**）。

要支撑该卡片，需要的**不是**"随便一条 Riemann–Roch"，而是下面这条链：

| 环节 | 内容 | 本轮结论 |
|---|---|---|
| (R) | 紧黎曼面上的 Riemann–Roch（除子形式或线丛形式） | **有多个带编号来源，其一已 L1 全文到手** |
| (K) | `deg K = 2g − 2` | 有编号来源（一手读到引用方，见 §42.4） |
| (A) | `dim H⁰(K²) − dim H⁰(K^{−1}) = 3g − 3`（**一次 RR 即得，无需分 g 讨论**） | 见 §42.2，**是抽取者的推算，尚未在任何来源里找到这个写法** |
| (B1) | `κ = 2·dim H⁰(K^{−1})`（共形 Killing 向量 ↔ 全纯向量场） | **本轮无来源**（§42.8） |
| (B2) | `μ = 2·dim H⁰(K²)`（度规模 ↔ 全纯二次微分） | **本轮无带编号来源**（§42.8） |
| (U) | 不可定向世界面（卡片明写"可定向或不可定向"） | **本轮无来源，是最被忽视的缺口**（§42.10） |

⇒ **只把 Riemann–Roch 登记进 bib，并不能让该节点变成 `rigorous`。** 详见 §42.10 的判断。

### 39.1 结论表（先看这张）

| 来源 | 任务书给的编号 | 本轮核实结果 | 可否写进 `loc` |
|---|---|---|---|
| **Eynard, arXiv:1805.06405v1**（公开讲义） | — | **★ L1 全文到手**：Ch. 4 **Theorem 1.2 (Riemann-Roch)**，p. 72，eq. **(1-10)** | **可以，且是本轮唯一全部逐字核实的来源** |
| **Farkas–Kra, GTM 71, 2nd ed.** | Thm III.4.8 | **章节位置 L1**（出版方 TOC 扫描：**III.4. Divisors and the Riemann–Roch Theorem, p. 69**；III.5. Applications…, p. 79）；**定理号 III.4.8 仍 L4** | 只能写到**小节**：`§III.4, pp. 69–78`。**不要写 Theorem III.4.8** |
| **Hartshorne, *Algebraic Geometry*** | Thm IV.1.3 | **L3（一手读到引用方原文）**：Wynter (UChicago REU 2016) p. 11 逐字 "Proof. Omitted (Theorem IV.1.3, Hartshorne [2])"，其 Theorem 5.1 正是 `l(D) − l(K−D) = deg D + 1 − g` | **可以写 `Ch. IV, Theorem 1.3`，但必须标"编号为二手核实"** |
| **Jost, *Compact Riemann Surfaces*** | Thm 5.4.x | **章节位置 L1**（出版方 TOC 扫描：**5.4 Divisors. The Riemann-Roch Theorem, p. 225**）；**定理/推论号 L4**，且**版本未定**（§42.5） | 只能写 `§5.4, p. 225ff.`，**并且必须先定版本** |
| **Griffiths–Harris** | — | **本轮未核（L0）**，一次调用都没花 | 不可 |
| Mathlib | — | **无 Riemann–Roch**（`docs/1000.yaml` 四条 RR 词条全部只有 `title`、无 `decl`） | 该节点**不可能**是 `formalized` |

### 39.2 ★ 核心观察：一次 Riemann–Roch 就够（**这一小节是抽取者的推算，不是任何来源的原文**）

> ⚠ **按本项目纪律显式声明：下面这段是我自己做的推导，不是从哪本书上抄的。**
> 之所以写进抽取记录，是因为它决定了 curator 该给这个节点接几条边、以及"数学侧到底缺什么"。

设 Σ 紧、连通、**可定向**、无边，亏格 g，K 为典范线丛。对除子 `D = 2K` 用 Riemann–Roch
（Hartshorne 形式 `l(D) − l(K − D) = deg D + 1 − g`）：

```
l(2K) − l(−K) = deg(2K) + 1 − g = (4g − 4) + 1 − g = 3g − 3
```

其中 `l(2K) = dim H⁰(K²)`（全纯二次微分），`l(−K) = dim H⁰(K^{−1})`（全纯向量场）。于是**对一切 g（含 0 和 1）**：

```
dim H⁰(K²) − dim H⁰(K^{−1}) = 3g − 3 = −(3/2) χ ,      χ = 2 − 2g
```

再用 (B1)(B2) 的 `κ = 2 dim H⁰(K^{−1})`、`μ = 2 dim H⁰(K²)`：

```
κ − μ = −2(3g − 3) = 6 − 6g = 3χ 。
```

**三条值得 curator 注意的后果：**

1. **不需要按 g = 0 / 1 / ≥2 分情形**，也**不需要**任何"球面标定"。现有推导最实质的弱点
   （`riemann-roch-kappa-minus-mu--via-ghost-number-anomaly` 的 gap 第 1 条：系数 3 靠球面一个例子定出）
   在数学路线上**根本不出现**。
2. 卡片里的两个检验值是这条式子的自动推论：g = 0 ⇒ `0 − 3 = −3` ✓；g = 1 ⇒ `1 − 1 = 0` ✓。
3. 单独的数值（`κ(S₂) = 6`、`μ(S₂) = 0`、g ≥ 2 时 `κ = 0`）**另需**一条"负次数线丛无非零全纯截面"的引理
   （`deg D < 0 ⇒ l(D) = 0`），它在教材里是 RR 之前的独立命题，**不含在 RR 里**。
   ⇒ 若 curator 想让图同时给出 `μ(S₂) = 0`（当前 gap 的残余项），要**另挂**这条引理，别指望 RR 一条边解决。

### 39.3 Farkas–Kra, *Riemann Surfaces*, GTM 71：**位置 L1、编号 L4**

**怎么拿到的（新活路的复用）**：`https://d-nb.info/920606512/04` —— 德国国家图书馆的**出版方目录扫描**，
即 [[reference-web-fetch-access-blockers]] 里记的 DNB 路线（`d-nb.info/<IDN>/04`）。落盘 62 KB，`Read pages` 读图，4 页全清晰。

**标题页逐字（L1）**：`H.M. Farkas   I. Kra` / `Riemann Surfaces` / **`Second Edition`** / `With 27 Figures` / `Springer`。
⇒ **这份 TOC 是第二版的**（这一点很重要：见 §42.5 的对照）。

**Chapter III「Compact Riemann Surfaces」目录逐字（L1，书上 p. xii）**，起始页 **54**：

```
III.1.  Intersection Theory on Compact Surfaces                      54
III.2.  Harmonic and Analytic Differentials on Compact Surfaces      56
III.3.  Bilinear Relations                                           64
III.4.  Divisors and the Riemann–Roch Theorem                        69
III.5.  Applications of the Riemann–Roch Theorem                     79
III.6.  Abel's Theorem and the Jacobi Inversion Problem              91
III.7.  Hyperelliptic Riemann Surfaces                               99
III.8.  Special Divisors on Compact Surfaces                        109
III.9.  Multivalued Functions                                       126
III.10. Projective Imbeddings                                       136
III.11. More on the Jacobian Variety                                142
III.12. Torelli's Theorem                                           161
```

同页另外三条与本项目有关的（L1）：
- **`IV.10. Riemann-Roch—An Alternate Approach   237`** ⇒ **FK 里 Riemann–Roch 出现两次**，
  引用时必须写清是 III.4 还是 IV.10（本项目要的是 III.4）。
- **`V.1. Hurwitz's Theorem   257`**、`V.2. Representations of the Automorphism Group on Spaces of Differentials   269`
  ⇒ 若将来要给"g ≥ 2 时 κ = 0"找**自同构有限**这条路线，入口在这里。
- `VII.2. Relations Among Quadratic Differentials   333`（**不是**维数计数那条，别引错）。

**结论**：
- **`§III.4` 与 `§III.5` 的标题、页码是 L1 确定的**；III.4 占 pp. 69–78，故"Theorem III.4.8 在 III.4 之内"在页码上**自洽**。
- **但 `III.4.8` 这个号本轮只有 L4 证据**：一个 fandom 维基页面（`mathbooknotes.fandom.com/wiki/Farkas_and_Kra_-_Riemann_Surfaces`）
  被检索后端转述为逐字写着 "III.4.8 Theorem (Riemann-Roch)"。**我没有一手读到该维基页，也没有读到书。**
- ⚠ 另一条负面证据：一篇综述（arXiv:1902.06406，**已一手读到该段**）在写 `dim Q(X) = 3g−3` 时逐字说
  "For details of this computation, refer to [33] or [67], or any standard reference for Riemann surfaces."
  —— **即连专门写全纯二次微分的综述都不给 FK 的定理号**。⇒ "FK 里 3g−3 的编号"很可能**在文献里根本没人引过号**。

### 39.4 Hartshorne, Ch. IV, Theorem 1.3：**编号 L3（一手读到引用方）**

**证据（一手读到的是引用方，不是 Hartshorne 本身）**：
D. L. Wynter, *An Exposition of the Riemann Roch Theorem for Curves*（University of Chicago REU 2016，
`math.uchicago.edu/~may/REU2016/REUPapers/Wynter.pdf`，日期页逐字 `Date: August 29, 2016`）。
**该 PDF 已落盘并逐页读图（L1 对该文）**，其 **p. 11**：

> **Theorem 5.1.** *Let K be the canonical class of the curve Y, D ∈ Div Y any divisor, and g the genus of the curve Y. Then we have the following:*
> `l(D) − l(K − D) = deg D + 1 − g`
> *Proof.* Omitted (**Theorem IV.1.3, Hartshorne [2]**).

紧接的 **Corollary 5.2**（p. 11–12，逐字）：*If Y has canonical divisor K, then the degree of K is determined by the genus g of Y. More precisely, we have that* `deg K = 2g − 2`。

**评级说明**：这是"**我一手读到了一篇论文，它逐字给出了 Hartshorne 的定理号**"。
按本记录 §0 的等级，对 **Hartshorne 的编号**而言是 **L3**（二手），对 **Wynter 这篇**而言是 L1。
另有一条同向的 L4：检索后端称 arXiv:2511.06880 亦逐字引 "[Hartshorne(1977), Theorem IV.1.3]"（**未一手核**）。
⇒ **两条来源同向、且其中一条已一手读到**，可以写进 `loc`，但 `note` 里要写明"编号系二手核实"。

⚠ **约定陷阱（Wynter p.2 与 p.11 已确认）**：Hartshorne 一路的 `l(D)` 是**向量空间维数**约定；
另有文献（Wynter 提到的 TCU 讲义）用**射影维数**约定（`H⁰ = 0` 时 `l(D) = −1`），**整式差 1**。
`loc` 里引 Hartshorne 时必须连约定一起写。

### 39.5 Jost, *Compact Riemann Surfaces*：**小节位置 L1，编号 L4，且版本未定（本节最脏的一条）**

**怎么拿到的**：同 DNB 路线，`https://d-nb.info/948901241/04`（落盘 460 KB，3 页读图）。

**标题页逐字（L1）**：`Jürgen Jost` / `Compact Riemann Surfaces` / `An Introduction to Contemporary Mathematics` /
`Translated by R. R. Simha` / `With 22 Figures` / `Springer`。
⚠ **没有"Second/Third Edition"字样**（对比 FK 那份**明写** `Second Edition`）⇒ **这份 TOC 很可能是第 1 版（1997）**，但**未证实**。

**Chapter 4/5 目录逐字（L1，书上 p. XIV）**：

```
4. Teichmüller Spaces
   4.1  The Basic Definitions                                               167
   4.2  Harmonic Maps, Conformal Structures and Holomorphic
        Quadratic Differentials. Teichmüller's Theorem                      169
   4.3  Fenchel-Nielsen Coordinates. …                                      179
   4.4  Uniformisation of Compact Riemann Surfaces                          191
5. Geometric Structures on Riemann Surfaces
   5.1  Preliminaries: Cohomology and Homology Groups                       203
   5.2  Harmonic and Holomorphic Differential Forms on Riemann Surfaces     211
   5.3  The Periods of Holomorphic and Meromorphic Differential Forms       219
   5.4  Divisors. The Riemann-Roch Theorem                                  225
   5.5  Holomorphic 1-Forms and Metrics on Compact Riemann Surfaces         236
   5.6  Divisors and Line Bundles                                           238
   5.7  Projective Embeddings                                              247
   5.8  Algebraic Curves                                                    254
   5.9  Abel's Theorem and the Jacobi Inversion Theorem                     267
   5.10 Elliptic Curves                                                     274
```

⇒ **任务书说的"Jost Thm 5.4.x"落在 `5.4 Divisors. The Riemann-Roch Theorem`（p. 225）之内，小节层面成立（L1）。**

**★ 本轮追到的一条有价值线索（L4，值得下一轮钉死）**：检索后端称，一篇 2025 年的 Springer 章
（*Differentials on a Riemann Surface*，`link.springer.com/chapter/10.1007/978-3-032-09219-9_9`，**Springer 登录墙，未取到**）
在陈述"亏格 ≥ 2 的闭黎曼面上全纯二次微分空间 `Q(X)` 的复维数为 `3g − 3`"时，
把证明引给 **`[219, Cor. 5.4.2]`**，而 `[219]` = Jost, *Compact Riemann Surfaces*。
⇒ **假说：Jost 的 `Corollary 5.4.2` 就是本项目要的 `dim H⁰(K²) = 3g − 3`。**
这与上面 L1 的 TOC 高度自洽（5.4 = RR 那一节，Corollary 5.4.2 正是"RR 的直接推论"应在的位置）。
**但它现在只有一条 L4 证据，禁止写进图。**

⚠ **版本陷阱（未解决）**：检索后端描述的另一份 Jost 全书 PDF（挂在爱丁堡某教师页）里，
"Quadratic Differentials. Teichmüller's Theorem" 在 **p. 163**，而我 L1 读到的 TOC 是 **p. 169**；
两者**相差 6 页**，说明**至少存在两个不同版次**。**在版次钉死之前，`Cor. 5.4.2` 这个号不可搬运。**
⚠ 另：那份全书 PDF 是**整本 Springer 书的扫描**挂在个人页上，版权状态存疑。
按 `literature/CLAUDE.md` 规则 1（不使用未授权扫描），**本轮没有去取它**，也不建议下一轮去取；
要定版次应走 DNB / 出版方 / 图书馆记录。

### 39.6 Griffiths–Harris：**本轮完全没查（L0）**

任务书列了它，但在预算内我优先把"能拿到全文的公开讲义"（§42.7）做完了。
诚实记录：**本轮对 GH 一次调用都没花，因此关于它的任何编号都不得写进图。**
下一轮若要查，注意一个结构性风险：GH *Principles of Algebraic Geometry* 的结果**多以"章·节 + 页码"引用**，
带编号定理较少 —— 也就是说它**未必**能提供本项目需要的"可逐字定位的编号"。先确认这一点再投入。

### 39.7 ★ 唯一 L1 全文到手的来源：Eynard, *Lectures on compact Riemann surfaces*, arXiv:1805.06405v1

**文献标识（L1，读自 PDF 首页）**：B. Eynard, *Lectures on compact Riemann surfaces.*，报告号 **IPhT-T18/007**，
封面逐字 "Paris–Saclay's IPHT doctoral school Lecture given in winter 2018."，
侧边戳记逐字 **`arXiv:1805.06405v1 [math-ph] 16 May 2018`**（⇒ **式号必须写死 v1**）。
作者单位：Institut de Physique Théorique de Saclay + CRM Montréal。全书 Contents 在 p. 5–7，Bibliography 起 p. 119。
**PDF 页码 = 印刷页码**（首页即印刷 p. 1）。

**⚠ 编号结构（引用时必须照做）**：**每一章内部重新计数**（Ch. 4 有 Theorem 1.1/1.2/4.1…，Ch. 5 也有 Theorem 1.1/2.1/4.1…）。
文内自引用的写法是**罗马章号 + 章内号**，例如正文逐字出现 "theorem III-3.4"、"corollary II-3.5"、"def. II-1.3"。
⇒ **`loc` 里只写 "Theorem 1.2" 会歧义，必须写成 "Ch. 4, Theorem 1.2"（或按其自身风格 "IV-1.2"）。**

**(a) Riemann–Roch 本体（书上 p. 72，L1 逐字）**

> **Theorem 1.2 (Riemann-Roch)** *For every divisor D we have*
> `r(−D) = deg D + 1 − 𝔤 + i(D).`   (1-10)

配套定义（书上 p. 71，L1 逐字，Definition 1.2 的 (1-5)(1-6)）：

> `ℒ(D) = {f ∈ 𝔐⁰(Σ) | (f) ≥ D}`  ,  `r(D) = dim ℒ(D)`,
> `Ω(D) = {ω ∈ 𝔐¹(Σ) | (ω) ≥ D}`  ,  `i(D) = dim Ω(D)`.

⇒ **与 Hartshorne 形式的字典**：`r(−D) = l(D)`，`i(D) = l(K − D)`，`𝔤 = g`。两者是同一条定理。
（⚠ Eynard 用的是 `r(−D)`，**负号在括号里**；抄错就整体差一个符号。）

**(b) 同章可引的配套结果（L1）**：Theorem 1.1 (1-7) `r(D) = r([D])`、`i(D) = i([D])`（只依赖除子类）；
**Proposition 5.1 (Riemann inequality)**（p. 75）`r(−D) ≥ deg D − 𝔤 + 1`；证明散布在 §5.2（p. 75–76）的 Theorem 5.2/5.3、Prop 5.2/5.3。
**⇒ 这是一份把 RR 完整证完的公开讲义**（"The Riemann-Roch theorem, that we shall prove in this chapter"，p. 72 逐字）。

**(c) 模空间侧（书上 p. 77、88、89，L1 逐字）** —— 这一段直接对上图卡的 `μ`：

- p. 77 章首无编号公式 **(0-1)**：`d_{𝔤,n} = 3𝔤 − 3 + n` , `χ_{𝔤,n} = 2 − 2𝔤 − n`。
- p. 88 §4 开头逐字："We shall find an explicit atlas of the moduli space ℳ_{g,n}.
  **Charts will be homeomorphic to ℝ₊^{6g−6+2n}**, and with gluing rules encoded by graphs."
  ⇒ **`dim_ℝ ℳ_{g,n} = 6g − 6 + 2n` 有一条可引的公开来源了**（正是图卡 `notes` 里点名要与 `μ` 区分的那条式子）。
- p. 89 **Theorem 4.1**：`dim Ω_𝒮 = d_{𝔤,n} = 3𝔤 − 3 + n`  (4-7)。
  ⚠⚠ **这里的 `Ω_𝒮` 不是全纯二次微分**：同页逐字定义为"having **double poles at the marked points**, and no other poles"
  的二次微分构成的**仿射**空间（其底下的线性空间是"在 pᵢ 处至多一阶极点"的二次微分）。
  n = 0 时它才退化成全纯二次微分并给出 `3g − 3`，但该节的前提是 `2𝔤 − 2 + n > 0` 且引入了 `L₁,…,Lₙ > 0`。
  ⇒ **不得直接拿 Theorem 4.1 当"dim H⁰(K²) = 3g−3"的来源**；要么另找来源，要么在 note 里写清 n = 0 的退化是抽取者的推断。

**(d) 顺带 L1 核到的、可给卡片"检验值"做数学侧佐证的三条**：

- **Ch. 5, Theorem 1.1 (1-1)（p. 77）**：`ℳ_{0,0} = {(ℂP¹)}` , `Aut = PSL(2,ℂ)` ⇒ 球面共形 Killing 群复维 3 ⇒ **κ(S₂) = 6**。
- **Ch. 5, Corollary 2.1 (2-9)（p. 85）** 与其后逐字："However, each `T_τ` has an infinite group of automorphisms,
  indeed every translation `z ↦ z + β` for `β ∈ ℂ` is an automorphism. `ℳ_{1,0}` is unstable."
  ⇒ 环面自同构含全体平移，复维 1 ⇒ **κ(T²) = 2**。
- **Ch. 5, Theorem 2.2（p. 86）**："`ℳ_{1,1}` is an orbifold of dimension 1"（复维 1）⇒ **μ(T²) = 2**（实）。
  ⚠ 注意它是 `ℳ_{1,1}`（带 1 个标记点）而不是 `ℳ_{1,0}`；`ℳ_{1,0}` 在同一处被判为 **unstable**。
  这正是图卡 `notes` 里"μ 只数度规的模、不含顶点算子位置"那条警告的数学侧对应物，**换算时必须小心**。

### 39.8 最弱的一环：`κ`、`μ` 与上同调维数的**桥**（本轮无来源）

图卡的 `κ`、`μ` 是**物理定义**（共形 Killing 方程的解数、无迹横向度规变分的模数），
而 Riemann–Roch 给的是 `dim H⁰(K^{−1})`、`dim H⁰(K²)`。**这两组量之间的等同不是 RR 的内容。**

- **(B1) `κ = 2 dim H⁰(K^{−1})`**：在复坐标下共形 Killing 方程即 `∂̄ v^z = 0`，属"一算就出"的一步，
  但**本轮没有找到任何带编号的数学来源**这么陈述。（Eynard 给的是自同构**群**，不是 CKV **方程**的解空间；
  两者相等还要一步"Aut 的李代数 = 全纯向量场"。）
- **(B2) `μ = 2 dim H⁰(K²)`**：这一步实质上是 Teichmüller 理论（`coker P₁ ≅ H⁰(K²)`，
  或"ℳ_g 的余切空间 = 全纯二次微分"）。**本轮同样没有带编号来源**；
  §42.5 的 Jost `Cor. 5.4.2` 与 Jost §4.2（Teichmüller's Theorem, p. 169）是最有希望的两个入口。
- ⇒ **curator 若现在就把 RR 挂上去，(B1)(B2) 必须显式建成节点或至少标 `inferred: true` 并留 note**，
  否则会出现"挂了一条数学来源、却跳过了两处未论证等同"的情况 —— 这恰恰是本项目最想避免的失真。

### 39.9 形式化状态：**Mathlib 没有 Riemann–Roch**

`raw.githubusercontent.com/leanprover-community/mathlib4/master/docs/1000.yaml`（读取日期 **2026-09-11**）里
标题含 "Riemann–Roch" 的条目共 **4** 条：`Q379048: Riemann–Roch theorem`、`Q4663326: Hirzebruch–Riemann–Roch theorem`、
`Q7333126: Riemann–Roch theorem for surfaces`、`Q17102744: Riemann–Roch theorem for smooth manifolds`，
**四条都只有 `title` 字段，没有 `decl` / `authors` / `date`** —— 按该文件的字段约定，这是**官方的"尚未形式化"记录**。

⇒ **`worldsheet.riemann-roch-kappa-minus-mu` 的天花板是 `rigorous`，不可能是 `formalized`**；
也不要指望把这一条选进 Phase 2 的 Lean 岛（RR 本身就是一个大工程）。

### 39.10 ★ `loc` 建议 与「能否走 rigorous」的判断

**(A) `loc` 建议（供 curator 直接抄）**

```yaml
# 首选：唯一 L1 全文到手、且免费可得
- ref: eynard-2018-lectures
  loc: "Ch. 4, §1, Theorem 1.2 (Riemann–Roch), eq. (1-10), p. 72 (arXiv:1805.06405v1)"
  note: |
    章内重新计数，必须连章号一起写。除子约定：ℒ(D)={f | (f) ≥ D}，定理写作 r(−D)=deg D+1−𝔤+i(D)，
    与 Hartshorne 形式的字典是 r(−D)=l(D)、i(D)=l(K−D)。版本写死 v1。

# 次选：教科书侧，编号为二手核实
- ref: hartshorne-1977
  loc: "Ch. IV, Theorem 1.3"
  note: |
    编号系二手核实（Wynter, UChicago REU 2016, p.11 逐字引作 "Theorem IV.1.3, Hartshorne"）；
    本项目未取得 Hartshorne 原书。l(D) 用向量空间维数约定（另有射影维数约定，整式差 1）。

# 只能写到小节的两条
- ref: farkas-kra-1992
  loc: "§III.4 (Divisors and the Riemann–Roch Theorem), pp. 69–78, 2nd ed."   # 禁写 Theorem III.4.8
# Jost：**本轮未登记进 sources.bib（版次未定，见 §42.11(a)）**。若将来登记，loc 只能写
#   "§5.4 (Divisors. The Riemann-Roch Theorem), p. 225ff."，且禁写 Cor. 5.4.2。
```

**(B) 能否走 rigorous —— 判断：可以，但不是"加一条边"，而是要新建 3–4 个节点；且现在还差两块**

1. **数学定理本身：够格。** Riemann–Roch 在三本教科书 + 一份把它证完的公开讲义里都是**有证明的定理**，
   来源强度足以支撑 `status: rigorous` 的推导。**Eynard 那份还能被任何人免费复核**，这一点对本项目特别有价值。
2. **算术那一步：干净且可机检。** §42.2 的 `l(2K) − l(−K) = 3g − 3` 只用到 RR + `deg K = 2g−2`，
   是一行代数，**没有分情形、没有"用球面标定常数"**。⇒ 数学路线一旦建成，会**同时消掉**现有推导 gap 第 1 条
   （比例常数靠单例标定）与其"残余"（缺 `μ(S₂) = 0` 的断言）。
3. **⚠ 仍缺第一块：(B1)(B2) 两处物理量 ↔ 上同调维数的等同**（§42.8）。**本轮无来源。**
   在补上之前，新推导的诚实标法是 `status: rigorous` **但** 把 (B1)(B2) 作为**依赖节点**列出，
   而那两个节点当前只能是 `physical-argument` —— 于是**有效状态仍被压到 `physical-argument`**。
   **这是好事**：它正确地暴露了"数学侧其实卡在桥上，不卡在 RR 上"。
4. **⚠ 仍缺第二块：不可定向情形。** 图卡 statement 明写"**可定向或不可定向**"，
   而 Riemann–Roch 是黎曼面（可定向）上的定理。Klein 瓶 / ℝP² / Möbius 带要走**定向双覆盖 + 对合不变子空间**，
   **本轮没有任何来源覆盖这一步**。
   ⇒ **建议 curator 把卡片拆成两条**：可定向情形（可走 RR，能到 rigorous）与不可定向情形（暂无数学来源）。
   若不拆，则新推导必须在 `gaps` 里明写"只覆盖可定向情形"，否则会出现**推导覆盖面小于陈述**的失真。
5. **形式化：到此为止。** §42.9 已证 Mathlib 无 RR，`formalized` 不可能。

**(C) 一句话给 lead**：登记 Riemann–Roch 是**值得做**的（它把这个节点从"靠球面标定的物理论证"变成"差两座桥的严格路线"），
但**不要指望这一步就把节点提到 rigorous**；真正的瓶颈已经转移到 `κ`/`μ` 的定义与上同调维数之间那两处等同，
以及不可定向情形。

### 39.11 `sources.bib` 登记建议 + 访问日志 + 未解决问题

**(a) 本轮 `sources.bib` 登记情况**（researcher 已写入；只增不改）：

| key | 条目 | 证据等级 | 是否已登记 |
|---|---|---|---|
| `eynard-2018-lectures` | B. Eynard, *Lectures on compact Riemann surfaces*, arXiv:1805.06405v1 (2018), IPhT-T18/007 | **L1 全文** | **已登记** |
| `farkas-kra-1992` | H. M. Farkas, I. Kra, *Riemann Surfaces*, 2nd ed., GTM 71, Springer | **L1 目录**（正文未取得；年份未独立核实） | **已登记** |
| `hartshorne-1977` | R. Hartshorne, *Algebraic Geometry*, GTM 52, Springer | **L3 编号**（原书未取得） | **已登记** |
| （Jost） | J. Jost, *Compact Riemann Surfaces*, Springer | L1 目录，但**版次未定** | **本轮不登记** |

⚠ **Jost 为什么不登记**：`sources.bib` 的 key 规则是 `<firstauthor>-<year>`，而本轮**定不下版次与年份**（§42.5）；
同一书至少有两个版次、同名小节页码相差 6 页。**先定版次，再登记**，否则 `loc` 里的页码会指向错误的版本。
在此之前，图里**不要**引 Jost。

**(b) 访问日志（本轮，供后人省事）**

| 目标 | URL / 手法 | 结果 |
|---|---|---|
| **Eynard 讲义全文** | `arxiv.org/pdf/1805.06405` | **成功**（落盘 2.2 MB；读 p.1–7、71–77、84–89） |
| Eynard HTML | `ar5iv.labs.arxiv.org/html/1805.06405` | 部分成功：**章节结构可读，但正文在 Ch.4 之前就被截断** ⇒ 定理号只能靠 PDF |
| **Farkas–Kra 目录** | `d-nb.info/920606512/04` | **成功**（62 KB 扫描，4 页；含 `Second Edition` 字样） |
| **Jost 目录** | `d-nb.info/948901241/04` | **成功**（460 KB 扫描，3 页；无版次字样） |
| **Hartshorne 编号（经引用方）** | `math.uchicago.edu/~may/REU2016/REUPapers/Wynter.pdf` | **成功**（落盘 266 KB；p.11 逐字含 "Theorem IV.1.3, Hartshorne [2]"） |
| 全纯二次微分维数的编号出处 | `ar5iv.labs.arxiv.org/html/1902.06406` | **成功但是否定结论**：该综述自己算 `3g−3`，引 FK/Jost 时**不给定理号** |
| **Mathlib 形式化状态** | `raw.githubusercontent.com/…/mathlib4/master/docs/1000.yaml` | **成功**：4 条 RR 词条全部只有 `title` ⇒ 未形式化 |
| Jost 全书 PDF（个人页扫描） | `webhomes.maths.ed.ac.uk/~v1ranick/papers/jost.pdf` | **主动不取**：整本 Springer 书扫描，版权状态存疑，按 `literature/CLAUDE.md` 规则 1 回避 |
| Springer 章（`[219, Cor. 5.4.2]` 的出处） | `link.springer.com/chapter/10.1007/978-3-032-09219-9_9` | **未取**（Springer 登录墙，既有记录已判死路） |
| Griffiths–Harris | — | **本轮未查（0 次调用）** |

**(c) 未解决 / 留给下一轮**

- **Q30** **Farkas–Kra 的 `Theorem III.4.8` 是否真是 Riemann–Roch（现 L4）。**
  最省力的下一招不是找书，而是找**逐字引了该号的论文**（Google Books 对 GTM 71 的两个 volume id
  `6pXuBwAAQBAJ`、`bGZDU9HxgpAC` 尚未跑过"无意义字符串"控制实验，可试，但按既有教训它只能当一致性检查）。
- **Q31** **FK 里 `dim H⁰(K²) = 3g−3` 到底有没有编号、在 III.5 的哪一条。**
  已有一条负面信号：专门写这个主题的综述（1902.06406）**不给号**。
- **Q32** **Jost 的版次**（DNB 那份无版次字样；另有一份 PDF 的同名小节页码相差 6 页），
  以及 **`Corollary 5.4.2` 的内容是否就是 `3g−3`（现 L4）**。**版次不定则编号不可搬运。**
- **Q33** **(B1)/(B2) 两座桥的带编号数学来源**（§42.8）——本轮完全空白，是数学侧真正的瓶颈。
  候选入口：Jost §4.2（Teichmüller's Theorem, p. 169）、FK V.2（p. 269）、Ahlfors–Bers 原始文献。
- **Q34** **不可定向世界面上的对应陈述**（§42.10 第 4 点）——本轮无来源，且图卡的 statement 已经把它包含在内。
- **Q35** Griffiths–Harris 是否提供**可逐字定位的编号**（§42.6）——先确认这一点再投入额度。

---

# § 伴随–基本迹恒等式的数学来源（供 `math.so-usp-adjoint-fundamental-trace-identities` 与 E₈ 迹恒等式卡）

> 触发：`reviewer-gs1984` 裁定 (c) —— 这两张卡目前只挂 `green-schwarz-1984` (12)(13)/(12′)，
> 而 GS 原文**给式不给证**（见 `extractions/green-schwarz-1984.md` E7/E8：「直接给出，无任何证明动词，也没有给出处引用」）。
> 本节的任务是给这两条**纯李代数事实**找**带编号的数学来源**，使它们的推导可以标 `rigorous` 而不被 GS 的陈述式写法压低。
> 证据等级沿用本文件 §0 的 L0–L4。
>
> 状态：**填写中**（本节按 `literature/CLAUDE.md` 规则 3 只追加，不覆盖）。

## 43. so(N) 伴随 ≅ Λ²V、sp(2n) 伴随 ≅ Sym²V 的带编号来源（researcher，2026-09-11）

### 43.0 结论表（先看这张）

| 需要的东西 | 本轮最好的来源 | 等级 | 能不能写进图 |
|---|---|---|---|
| **so(n) 的伴随表示 = 二指标反对称张量（= Λ²V）** | Cvitanović, *Group Theory*, **§10.1, eqs. (10.12)–(10.14)**, 书上 pp.122–123 | **L1 逐字** | **能** |
| **sp(n) 的伴随表示 = 二指标对称张量（= Sym²V）** | Cvitanović, *Group Theory*, **§12.1, eqs. (12.8)–(12.10)**, 书上 p.153 | **L1 逐字** | **能** |
| 同一事实的数学教科书版 | Fulton–Harris, GTM 129, **Lecture 16**（辛，起 p.238）/ **Lecture 18**（正交，起 p.267） | **L4，只到 Lecture 级** | **只能写 Lecture 号，禁写式号/命题号** |
| 从伴随 ≅ Λ²/Sym² 推出 GS (12a)(12b)(12c) | 抽取者本轮**手工完整复算**（§43.5），三阶全部对上 | 自验证 | 能，但要标明是本项目自己补的一步 |
| Lean 现状 | Mathlib 有 `LieAlgebra.Orthogonal.so` / `LieAlgebra.Symplectic.sp`（矩阵定义），**没有** Λ²/Sym² 的模同构，也没有外幂上的迹 | **L1**（读源码） | 见 §43.5(d) |

**一句话**：这两条卡可以走 `rigorous`，但**支撑它的一手来源是 Cvitanović 的 birdtracks 书，不是 Fulton–Harris**——
FH 本轮只拿到 Lecture 级定位，拿不到任何可搬运的编号。

### 43.1 需求侧：卡片到底要哪一条

`math.so-usp-adjoint-fundamental-trace-identities` 现在挂的唯一来源是 `green-schwarz-1984` (12a)(12b)(12c)+(13a)(13b)，
而按 `extractions/green-schwarz-1984.md` E7 的记录，GS 原文对这三条式子是

> **直接给出，无任何证明动词**（没有 "we show"、"one can show"、"it follows"），也没有给出处引用

所以 `reviewer-gs1984` 裁定 (c)：要么把状态压到 `physical-argument`，要么补一条**纯数学的**推导。
补数学推导需要两块砖：

| | 砖 | 性质 |
|---|---|---|
| **(A)** | `so(V)` 的伴随表示同构于 `Λ²V`；`sp(V)` 的伴随表示同构于 `Sym²V`（作为该李代数的模） | 结构性事实，需要**外部来源** |
| **(B)** | 由 (A) 展开 `Tr_{Λ²V} X^k` / `Tr_{Sym²V} X^k`，再用 `tr X^{odd} = 0`，得到 (12a)(12b)(12c) | 纯线性代数，**可自证、可 Lean 化** |

本节只负责 (A) 的来源；(B) 见 §43.5，reviewer 已复核过路线（**不需要 Antonelli 的 `e^F` 路线**）。

### 43.2 ★★ 首选（L1 全文到手、且合法免费）：Cvitanović, *Group Theory: Birdtracks, Lie's, and Exceptional Groups*

#### 43.2.0 版本与获取（可复用）

- 作者自建的 **webbook**：`birdtracks.eu` → `menu.html` 给出 `webbook` 链接 → `birdtracks.eu/version9.0/index.html`
  → 整本 PDF `birdtracks.eu/version9.0/GroupTheory.pdf`（**4.4 MB，WebFetch 落盘后 `Read(pages=)` 读图，全书可读**）。
- **每页页眉逐字**：`GroupTheory   version 9.0.1, April 8, 2011`。**引用必须写死这个版本号**——
  纸本是 Princeton University Press (2008)，webbook 是作者持续更新的版本，**页码/式号未必与 PUP 印本一致**。
- 合法性：作者本人挂在自己域名上的公开 webbook（PUP 允许），符合 `literature/CLAUDE.md` 规则 1。
  与 §42 拒用 `webhomes.maths.ed.ac.uk/~v1ranick/papers/jost.pdf`（第三方整书扫描）是**两种不同性质**的东西。
- 目录（L1，PDF pp.7–10 = 书上 pp.vii–x）里与本节相关的两章：
  **Chapter 10. Orthogonal groups, p.121**（10.1 Two-index tensors, p.122）；
  **Chapter 12. Symplectic groups, p.152**（12.1 Two-index tensors, p.153）。
  PDF 页 = 书上页 + 12。

#### 43.2.1 ★★★ `so(n)`：伴随 = 反对称二指标张量（书上 pp.121–123，L1 逐字）

章首（书上 p.121）先把生成元的反对称性写成编号式：

> The invariance condition (4.36) for the metric tensor
> `(T_i)_μ^σ g_{σν} + (T_i)_ν^σ g_{μσ} = 0`  **(10.5)**
> becomes, in this convention, a statement that the `SO(n)` generators are antisymmetric:
> `(T_i)_{μν} = − (T_i)_{νμ}` .  **(10.6)**

§10.1（书上 p.122）给出 `V ⊗ V` 的完全分解，三个投影算子分别编号：

> traceless symmetric: `(P₂)_{μν,ρσ} = ½(g_{μσ}g_{νρ} + g_{μρ}g_{νσ}) − (1/n) g_{μν}g_{ρσ}`  **(10.10)**
> singlet: `(P₁)_{μν,ρσ} = (1/n) g_{μν}g_{ρσ}`  **(10.11)**
> antisymmetric: `(P₃)_{μν,ρσ} = ½(g_{μσ}g_{νρ} − g_{μρ}g_{νσ})`  **(10.12)**

紧接着是**本节要的那句话**（书上 p.122，L1 逐字）：

> "The adjoint rep (9.57) of `SU(n)` is decomposed into the traceless symmetric and the antisymmetric parts.
> **To determine which of them is the new adjoint rep, we substitute them into the invariance condition (10.5).
> Only the antisymmetric projection operator satisfies the invariance condition** … so the adjoint rep projection
> operator for `SO(n)` is"  **(10.13)**

以及维数（书上 p.123）：

> "The dimension of `SO(n)` is given by the trace of the adjoint projection operator:
> `N = tr P_A = n(n−1)/2` ."  **(10.14)**

⇒ **可写进图的定位**：`Cvitanović, Group Theory (webbook v9.0.1), §10.1, eqs. (10.12)–(10.14), pp.122–123`。
文献自称的严格程度：**给出了论证**（把三个投影算子代回不变性条件 (10.5)，只有反对称的满足），不是断言式。

#### 43.2.2 ★★★ `sp(n)`：伴随 = 对称二指标张量（书上 pp.152–153，L1 逐字）

章首（书上 p.152）：

> "Symplectic group `Sp(n)` is the group of all transformations that leave invariant a skew symmetric
> `(p,q) = f_{ab}p^a q^b`:  `f_{ab} = − f_{ba}`, `a,b = 1,2,…n`, `n` even."  **(12.1)**
> "The invariance condition (4.36) for the symplectic invariant tensor is
> `(T_i)_{ac} f_{cb} + f_{ac}(T_i)_{cb} = 0` ."  **(12.6)**

§12.1（书上 p.153，L1 逐字）：

> "`Sp(n)` 2-index tensors decompose as
> singlet: `(P₁)_{ab,cd} = (1/n) f_{ab}f_{cd}`
> antisymmetric: `(P₂)_{ab,cd} = ½(f_{ad}f_{bc} − f_{ac}f_{bd}) − (1/n) f_{ab}f_{cd}`
> symmetric: `(P₃)_{ab,cd} = ½(f_{ad}f_{bc} + f_{ac}f_{bd})` "  **(12.8)**
>
> "The `SU(n)` adjoint rep (10.14) is now split into traceless symmetric and antisymmetric parts.
> **The adjoint rep of `Sp(n)` is given by the symmetric subspace, as only `P₃` satisfies the invariance
> condition (12.6)** … Hence the adjoint rep projection operator for `Sp(n)` is"  **(12.9)**
>
> "The dimension of `Sp(n)` is `N = tr P_A = n(n+1)/2` ."  **(12.10)**

⇒ **可写进图的定位**：`Cvitanović, Group Theory (webbook v9.0.1), §12.1, eqs. (12.8)–(12.10), p.153`。

#### 43.2.3 使用限制（诚实记录）

1. **记号不是数学书的记号**：Cvitanović 用 birdtracks 图示 + 投影算子语言，写的是「二指标反对称/对称张量子空间」，
   **没有出现 `Λ²V` / `Sym²V` 这两个符号**。「反对称二指标张量 = `Λ²V`」这一步是**记号翻译**，
   转节点时若要写 `Λ²V`，须在 note 里说明这是翻译，或者干脆按原文写「二指标反对称张量表示」。
2. **`Sp(n)` 的 `n` 是 defining rep 的维数（偶数），不是 GS 的 `USp(N)` 的 `N`**——两者恰好都指 defining rep 维数，
   `dim = n(n+1)/2` 与 GS 的 `USp(N)`、`l=+1` 一致，但**这是我核对出来的，不是原文写的**。
3. 该书对 `SO(n)` 只要求「存在可逆对称度规」，**不要求正定**（书上 p.121 逐字：
   "Our analysis of the reps of `SO(n)` will depend only on the existence of a symmetric metric tensor and its
   invertability, and not on its eigenvalues. The resulting Clebsch-Gordan series applies both to the compact
   `SO(n)` and noncompact orthogonal groups, such as the Minkowski group `SO(1,3)`."）——
   对图**是好消息**：迹恒等式不依赖号差。

### 43.3 Fulton–Harris：本轮**只拿到 Lecture 级定位**，禁写式号

任务书点名 FH「sp 在 §16 找 'the adjoint representation is Sym²V' 逐字与式号 (16.x)、so 在 §18 找 'Λ²V is the adjoint'」。
**本轮没有拿到任何一句逐字，也没有拿到任何编号。** 证据只有两条，都是页码级：

| 探针 | 返回 | 判读 |
|---|---|---|
| Google Books 卷 `6TwmBQAAQBAJ`，`q="Symplectic Lie Algebras"` | **Page 238** | 与 Lecture 16 起始页一致 |
| 同卷，`q="Orthogonal Lie Algebras"` | **Page 267** | 与 Lecture 18 起始页一致 |
| 同卷，`q="zzqxjkwmnbv"` / `"zzqxjkwmnbvpl"`（**控制**） | **两次都没有返回任何页码**（摘要器只报「页面上没有结果区」） | 弱通过：至少**没有** §9.2 记的「回落到固定页」病；但摘要器也没给出显式的 "No results" 字样，**不如 Humphreys 卷那次干净** |
| Springer 书页 `link.springer.com/book/10.1007/978-1-4612-0979-9` | **303 → `idp.springer.com/authorize`** | 与既有记录一致，登录墙，**不是取目录的路** |

Lecture 标题与页范围（**L4**，来自检索后端对 Springer 目录的转述，本轮未见目录页图）：
`Lecture 16. Symplectic Lie Algebras, pp.238–252`；`Lecture 17. sp₆ℂ and sp₂ₙℂ, pp.253–266`；
`Lecture 18. Orthogonal Lie Algebras, pp.267–281`；`Lecture 19. so₆ℂ, so₇ℂ, soₘℂ, pp.282–298`；
`Lecture 20. Spin Representations of soₘℂ, pp.299–315`。

⇒ **硬性禁令（与 §33.3.4、§15.4 同性质）：不得在图里写 `Fulton–Harris (16.x)`、`(18.x)`、`Proposition 16.x`。**
可以写的最强形式是 `Fulton & Harris, GTM 129, Lecture 18 "Orthogonal Lie Algebras", pp. 267–281`，
且 note 里必须写「正文未取得，Lecture 号与页范围分别为 L4/两条一致的页码命中」。

### 43.4 未查 / 未能核实的候选（**一律不写进图**）

- **Bourbaki, *Lie* Ch. VIII**（`𝔬(n)`、`𝔰𝔭(2n)` 的标准处理）——**本轮 0 次调用**。Springer 登录墙，
  且按 §33.3 的教训，即使拿到目录也只能定位到 `no.` 一级。
- **Humphreys GTM 9**——**不对口**：GTM 9 讲的是抽象半单李代数与根系，`so(V) ≅ Λ²V` 这种「经典李代数的具体模型」
  不是它的主题（§43.5 需要的 (A) 在 GTM 9 里基本不会以这个形式出现）。
- **Goodman–Wallach / Procesi / Onishchik–Vinberg / Knapp**——全在 Springer/Birkhäuser 墙后，本轮未尝试。
- **Kirillov Jr., *An Introduction to Lie Groups and Lie Algebras*（Stony Brook 免费草稿，
  `math.stonybrook.edu/~kirillov/mat552/liegroups.pdf`，1 MB，本轮已落盘）**——
  目录 L1 读毕：`Appendix C. Root Systems and Simple Lie Algebras`（§C.2 `B_n = so(2n+1,ℂ)` p.125、
  §C.3 `C_n = sp(n,ℂ)` p.127、§C.4 `D_n = so(2n,ℂ)` p.128）。**这些附录是按根系/矩阵实现写的，
  本轮没有在目录级看到任何 `Λ²V` / `Sym²V` 的条目**，正文未逐页核实 ⇒ **判为「未核实、疑似不对口」**。

### 43.5 ★★ 给 curator 的推导改写建议（reviewer 裁定 (c) 的落地）

> 以下 (a)(b) 是**可完全机械验证**的算术，抽取者已逐阶手算通过；(c)(d) 是建议。
> researcher 不改 `graph/`。

#### (a) 展开公式（reviewer 已复核的那条）

对**任意** `X ∈ End(V)`（`dim V = N`），把 `X` 作用在 `V⊗V` 上的导子写成 `X⊗1 + 1⊗X`（两项对易），则

```
Tr_{V⊗V}(X⊗1 + 1⊗X)^k = Σ_{j=0}^{k} C(k,j) · tr X^j · tr X^{k−j}        (约定 tr X⁰ = N)
Tr_{Sym²V} − Tr_{Λ²V}   = 2^k · tr X^k
```

（第二行：取 `X` 的本征值 `x_1,…,x_N`，则 `Sym²` 上是 `{x_i+x_j}_{i≤j}`、`Λ²` 上是 `{x_i+x_j}_{i<j}`，
差恰是对角项 `Σ_i (2x_i)^k`。可对角化情形显然，一般情形由稠密性/Zariski 闭包。）
两式相加减即得**任务书给的那条**：

```
Tr_{Λ²V}  X^k = ½ [ Σ_j C(k,j) tr X^j tr X^{k−j} − 2^k tr X^k ]
Tr_{Sym²V} X^k = ½ [ Σ_j C(k,j) tr X^j tr X^{k−j} + 2^k tr X^k ]
```

#### (b) 代进去，逐阶复算（抽取者本轮全部手算，三阶双分支共六个式子全部对上）

前提：`tr F^{odd} = 0`（见 (c)）。记 `Ω_{2m} := Tr_adj F^{2m}`。

| `k` | `Σ_j C(k,j) tr F^j tr F^{k−j}`（已丢掉奇次迹） | `2^k tr F^k` | `Λ²`（`l = −1`） | `Sym²`（`l = +1`） | 对应 GS |
|---|---|---|---|---|---|
| 2 | `2N tr F²` | `4 tr F²` | `(N−2) tr F²` | `(N+2) tr F²` | **(12a)** `Ω₄ = (N+2l) tr F²` ✓ |
| 4 | `2N tr F⁴ + 6 (tr F²)²` | `16 tr F⁴` | `(N−8) tr F⁴ + 3(tr F²)²` | `(N+8) tr F⁴ + 3(tr F²)²` | **(12b)** `Ω₈ = (N+8l) tr F⁴ + 3(tr F²)²` ✓ |
| 6 | `2N tr F⁶ + 30 tr F² tr F⁴` | `64 tr F⁶` | `(N−32) tr F⁶ + 15 tr F² tr F⁴` | `(N+32) tr F⁶ + 15 tr F² tr F⁴` | **(12c)** `Ω₁₂ = (N+32l) tr F⁶ + 15 tr F² tr F⁴` ✓ |

（`k=6` 那行里 `C(6,2)=15` 出现两次 ⇒ `30 tr F²tr F⁴`；`C(6,3)(tr F³)² = 20(tr F³)²` 因 `tr F³ = 0` 丢掉。）

⇒ **GS 的 `l = −1` for SO(N) / `l = +1` for USp(N)（(13a)(13b)）在这个语言里不是两条约定，
而是「伴随 = `Λ²` 还是 `Sym²`」这一个二选一的直接后果。** 这是本轮对图最有价值的一句话。

#### (c) ⚠ **对任务书的一处订正：`tr F^{odd} = 0` 的理由，so 与 sp 不是同一个**

- **`so(N)`**：`F^T = −F` ⇒ `tr F^m = tr (F^m)^T = tr (F^T)^m = (−1)^m tr F^m` ⇒ `m` 奇时为 0。
  ——任务书给的就是这条，**对 so 正确**。
- **`sp(2n)`**：`F` **不是**反对称矩阵，而是满足 `F^T J + J F = 0`，即 `F^T = −J F J^{−1}`。
  于是 `tr F^m = tr (F^T)^m = tr(−JFJ^{−1})^m = (−1)^m tr F^m`，同样给出 `m` 奇时为 0，
  **但用的是「相似于 −F」而不是「等于 −F^T」**。
  ⇒ **curator 若照抄任务书的一句「由 `F^T = −F`」，对 USp 分支就是错的。** 必须分两句写，
  或者写成统一的一句：「`F` 相似于 `−F`（so：经转置；sp：经 `J`-共轭），故奇次迹为零」。
  （Cvitanović (10.6) 给的正是 so 的反对称性；(12.6) 给的正是 sp 的 `f`-不变性条件，两者可分别引。）

#### (d) 建议的图结构（建议而已，不代 curator 决定）

1. **新 statement `math.so-adjoint-is-exterior-square`**：「设 `V` 上有非退化对称双线性型，则 `so(V)` 的伴随表示
   同构于 `Λ²V`」。`sources`: `cvitanovic-2008`（`loc: "§10.1, eqs. (10.12)–(10.14), pp.122–123 (webbook v9.0.1)"`），
   `fulton-harris-1991`（`loc: "Lecture 18, pp. 267–281"`，note 写明「Lecture 级，正文未取得」）。`status: rigorous`。
2. **新 statement `math.sp-adjoint-is-symmetric-square`**：同上，`Sym²V`；
   `loc: "§12.1, eqs. (12.8)–(12.10), p.153"` + `fulton-harris-1991` `"Lecture 16, pp. 238–252"`。
3. **新 statement `math.trace-of-exterior-and-symmetric-square`**：(a) 的两条恒等式（纯线性代数，**无外部来源，
   `inferred: true` + note 指向本节**；或标 `formalization-target`）。
4. **新 derivation `math.so-usp-adjoint-fundamental-trace-identities--via-exterior-square`**，
   `depends_on: [1,2,3, math.odd-traces-vanish-so-sp]`，`status: rigorous`，
   `gaps:` 写「常数 `3` 与 `15` 是二项式系数 `C(4,2)/2`、`C(6,2)`，已逐阶复算（`literature/extractions/math-sources.md` §43.5(b)）」。
5. **保留** 现有的挂 `green-schwarz-1984` 的那条 derivation，`status` 按 GS 原文的写法诚实标 `physical-argument`
   （原文无证明动词）。**两条独立推导挂同一张卡**，正是本项目的 §1 原则。

#### (e) Lean 化与 Mathlib 现状（**L1，读源码 2026-09-11**）

`raw.githubusercontent.com/leanprover-community/mathlib4/master/Mathlib/Algebra/Lie/Classical.lean` 已有：
`LieAlgebra.SpecialLinear.sl`、**`LieAlgebra.Symplectic.sp`**（对典范斜对称型 `J` 的 skew-adjoint 矩阵）、
**`LieAlgebra.Orthogonal.so`**（对单位阵的 skew-adjoint 矩阵）、`so'`、`typeB`、`typeD` 及它们之间的等价
（`soIndefiniteEquiv`、`typeBEquivSo'`、`typeDEquivSo'`）。模块 docstring 逐字给出
`Aₗ = sl(l+1)`、`Bₗ ≃ so(l+1,l) ≃ so(2l+1)`、`Cₗ = sp(l)`、`Dₗ ≃ so(l,l) ≃ so(2l)`。

**但是**：文件里**没有** `so ≅ Λ²V` / `sp ≅ Sym²V` 的模同构，也没有任何「外幂/对称幂上的迹」结论。
⇒ **(A) 这块砖在 Mathlib 里不存在，要自己造**；`(a)` 那两条迹恒等式也要自己造。
⇒ **这两张卡的天花板目前是 `rigorous`，不是 `formalized`。**
（相较之下 §5.1 的 A1「因子化恒等式 (19)」只是 `ring`/`field_simp`，仍然是更容易的第一块砖。）

### 43.6 访问日志与未解决问题（本节）

| 目标 | URL / 手法 | 结果 |
|---|---|---|
| **Cvitanović 全书** | `birdtracks.eu` → `menu.html` → `version9.0/index.html` → `version9.0/GroupTheory.pdf` | **成功**（4.4 MB 落盘；读目录 + pp.121–123、152–153） |
| Fulton–Harris 目录 | `link.springer.com/book/10.1007/978-1-4612-0979-9` | **失败**：303 → `idp.springer.com/authorize` |
| Fulton–Harris 定位 | Google Books 卷 `6TwmBQAAQBAJ`，四次 `&q=` | **部分**：两条正命中（238/267），控制串两次都无页码返回但也无显式 "No results" |
| Kirillov 讲义 | `math.stonybrook.edu/~kirillov/mat552/liegroups.pdf` | **成功落盘**（1 MB），目录 L1 读毕；**正文未查**，疑似不对口 |
| Mathlib 经典李代数 | `raw.githubusercontent.com/.../Mathlib/Algebra/Lie/Classical.lean` | **成功**：有 `so`/`sp`，**无** Λ²/Sym² |
| Cambridge Core 检索 | `www.cambridge.org/core/search?q=Lie+algebras&filters…` | **HTTP 429**（两次），本轮放弃找 CUP 的李代数教材 |
| Bourbaki *Lie* Ch. VIII | — | **本轮 0 次调用** |

**未解决 / 留给下一轮**

- **Q36** **Fulton–Harris 的逐字与编号**：`𝔰𝔭₂ₙℂ ≅ Sym²V` 与 `𝔰𝔬ₘℂ ≅ Λ²V` 在 FH 里到底是**编号式**、
  **无编号显示式**、还是**习题**？目前完全未知（L0）。最省力的下一招：
  找一篇**逐字引了该编号**的论文/讲义（§28.1 对 Weibel 用过的办法），而不是继续找书。
- **Q37** `Λ²V` / `Sym²V` 这两个记号在**哪本能拿到的书**里被逐字用于 `so`/`sp` 的伴随？
  （Cvitanović 用的是投影算子语言，翻译这一步目前挂在本项目自己名下。）
- **Q38** Bourbaki *Lie* Ch. VIII 是否给出这条并带 `no.` 级定位（若将来能拿到 DNB 目录扫描 `d-nb.info/<IDN>/04`）。

## 44. E₈ 迹恒等式：根系、Chevalley 限制定理与 248 = 120 ⊕ 128 的带编号来源（researcher，2026-09-11）

### 44.0 结论表（先看这张）

| 需要的东西 | 本轮最好的来源 | 等级 | 能不能写进图 |
|---|---|---|---|
| **E₈ 根系（240 根的显式列表）** | Humphreys, *Reflection Groups and Coxeter Groups*, **§2.10, 书上 pp.42–43** | **L1 逐字** | **能** |
| **E₈ 的基本不变量次数 = 2, 8, 12, 14, 18, 20, 24, 30**（⇒ 没有独立的 4 阶、6 阶不变量） | 同书 **§3.7, Table 1, 书上 p.59** | **L1 逐字** | **能** |
| **Chevalley 定理（反射群的不变量环是多项式环）** | 同书 **§3.5**（作者本人在 p.56/p.58 把它引作 "**Theorem 3.5**"） | **L1** | **能，写 `§3.5, Theorem 3.5`** |
| **次数与生成元选取无关** | 同书 **§3.7, Proposition, 书上 pp.58–59** | **L1 逐字** | 能（**无编号，只能写「§3.7 的 Proposition」**） |
| **Chevalley 限制定理（`S(𝔤*)^𝔤 → S(𝔥*)^W` 同构）本身** | Humphreys, GTM 9, **§23「Invariant polynomial functions」** | **L1 的交叉引用 + L4 的页码（p.126）**，**内容未核实** | **只能写 `§23`，不能写 `§23.1` 的编号** |
| **`Tr F⁴ = (1/100)(Tr F²)²`、`Tr F⁶ = (1/7200)(Tr F²)³` 的独立确认** | van Ritbergen–Schellekens–Vermaseren, **eqs. (176)(177)**（arXiv:hep-ph/9802376 = IJMPA **14** (1999) 41） | **L1 逐字** | **能，且与 GS (12b′)(12c′) 逐位相等** |
| **248 = 120 ⊕ 128 在 so(16) 下** | 同文 **§5.11, eq. (86)**：`Ch_{E₈,248} = Ch_{D₈,128} + Ch_{D₈,120}` | **L1 逐字** | **能**（比 Slansky 好：免费、带编号） |
| 从根系直接算出 (12b′)(12c′) | 抽取者本轮**手工完整复算**（§44.7），`k = 2, 4, 6` 全部对上 | 自验证 | 能，且**可脚本化 + 可 Lean 化** |

**一句话**：E₈ 这张卡**不需要**去啃 Bourbaki Planche VII——
`Humphreys 的 Reflection Groups §2.10 + §3.7 Table 1` 已经把「根系」与「没有 4/6 阶独立不变量」两块砖都以 L1 拿到了，
而且 §44.7 的复算说明**整条推导可以做成一个纯算术脚本**，reviewer 复核后走 `rigorous` 是可行的。

### 44.1 需求侧：E₈ 卡到底缺什么

GS (12a′)(12b′)(12c′)（见 `extractions/green-schwarz-1984.md` E8）：

> `Ω₄ = tr F²`、`Ω₈ = (1/100)(tr F²)²`、`Ω₁₂ = (1/7200)(tr F²)³`
> 文献自称的严格程度：**直接给出，无证明、无引用**
> 致谢里的归属：**"We are grateful to G. Chapline and R. Slansky for pointing out to us that E₈ has no
> independent fourth- and sixth-order Casimir invariants."**

所以要补的是三块：

| | 砖 | 本节给到哪一步 |
|---|---|---|
| **(A)** | `Ad`-不变多项式由它在 Cartan 上的限制决定，且该限制是 `W`-不变的（**Chevalley 限制定理**） | **§44.4，最弱的一环（内容 L0）** |
| **(B)** | E₈ 的 `W`-不变多项式环由次数 2,8,12,14,18,20,24,30 的生成元自由生成 ⇒ **4 次与 6 次的不变量只能是 `(deg 2)²` 与 `(deg 2)³`** | **§44.3，L1 拿到** |
| **(C)** | 系数 `1/100`、`1/7200`：对 248 个权求幂和 | **§44.5 + §44.7，两条独立证据** |

### 44.2 ★★★ (B) 的上游：E₈ 根系的显式列表（Humphreys, *Reflection Groups*, §2.10，L1 逐字）

获取途径：**Cambridge Core 章级 PDF（本环境有机构订阅）**。书目页
`www.cambridge.org/core/books/reflection-groups-and-coxeter-groups/2910C1E00877D33A04A512791B6EDD72`
给出每个 item 的 hash 与页范围；ch.2 的 PDF 是
`…/services/aop-cambridge-core/content/view/D2925389A4A9FDD2D6C587F55AAB1CF7/9780511623646c2_p29-48_CBO.pdf/classification_of_finite_reflection_groups.pdf`（1.0 MB，扫描件，`Read(pages=)` 清晰可读）。

**§2.10 的开场（书上 p.41，L1 逐字）**：

> "Denote by `ε₁,…,ε_n` the standard basis of `Rⁿ`. Whenever we write combinations such as `±ε_i ± ε_j` below,
> it is understood that the signs may be chosen arbitrarily. We shall outline briefly the construction of
> (crystallographic) root systems of all possible types, **following Chapter VI of Bourbaki [1]** (which should be
> consulted for further details)."

**E₈ 那一条（书上 pp.42–43，L1 逐字，跨页）**：

> "(E₈) Let `V = R⁸`. The choice of lattice is somewhat subtle. Start with the lattice `L′` consisting of all
> `Σ c_i ε_i` with `c ∈ Z` and `Σ c_i` even. Then let `L = L′ + Z(½ Σ_{i=1}^{8} ε_i)`. Define `Φ` to be the set of
> all vectors of squared length 2 in `L`. **So `Φ` consists of 240 roots:**
> `±ε_i ± ε_j (i < j)`,  `½ Σ_{i=1}^{8} ±ε_i` **(even number of + signs)**.
> For `Δ` take
> `α₁ = ½(ε₁ − ε₂ − ε₃ − ε₄ − ε₅ − ε₆ − ε₇ + ε₈)`, `α₂ = ε₁ + ε₂`, `α_i = ε_{i−1} − ε_{i−2} (3 ≤ i ≤ 8)`.
> Then `α̃ = ε₇ + ε₈`."

**⚠ 一处必须随引用一起写的记号差**：Humphreys 写的是「**even number of `+` signs**」，
而 Bourbaki Planche VII / 物理文献常见的写法是「偶数个**负**号」。
**在 8 个符号里，`+` 号个数为偶 ⟺ `−` 号个数为偶**（`8 − 偶 = 偶`），所以两种写法给出**同一个 128 元集合**，
**不是矛盾**。（本条是抽取者的核对，不是原文的话。）

**同章 Table 2（书上 p.44，L1 逐字）**：`E₈` 一行给 `|W| = 2^14 3^5 5^2 7`、`|Φ| = 240`。

### 44.3 ★★★ (B)：Chevalley 定理 + E₈ 的次数表（同书 §3.5 / §3.7，L1 逐字）

ch.3 的 PDF：hash `1DD151BF79ED7B49783AAA0B265EF54E`，文件名 `9780511623646c3_p49-86_CBO.pdf`（1.8 MB）。

**编号体例（要点）**：本书的 `Theorem` / `Proposition` / `Lemma` **在正文里是不带号的**，
但**作者自己用「小节号」去引它们**。两处 L1 证据（书上 p.56 与 p.58）：

> "Our proof of **Theorem 3.5** follows closely the original proof in Chevalley [2]."（书上 p.56）
> "The algebraically independent generators of `R` provided by **Theorem 3.5** need not be uniquely determined…"（书上 p.58）

⇒ **`Humphreys, Reflection Groups, §3.5, Theorem 3.5` 是一个作者认可的、可搬运的定位**
（与 §33.3.4 禁写「Bourbaki Theorem 1」不同：那次是**没有任何证据**，这次是**作者本人两次这么引**）。
但 §3.1/§3.2/§3.6/§3.7 里的 `Proposition` **本轮没见到作者用「Proposition 3.x」引过**，
⇒ **那几条只能写成「§3.7 的 Proposition」，不要写 `Proposition 3.7`。**

**§3.5 之后的定义（书上 p.56，L1 逐字）**：

> "For brevity, we may refer to a set of algebraically independent homogeneous generators of `R` (of positive
> degree) as a set of **basic invariants** of `R`."

**§3.7「Uniqueness of the degrees」的 Proposition（书上 p.58，L1 逐字）**：

> "**Proposition** *Suppose that `f₁,…,f_n` and `g₁,…,g_n` are two sets of homogeneous, algebraically independent
> generators of the ring `R` of `W`-invariant polynomials. Denote the respective degrees by `d_i` and `e_i`. Then,
> after renumbering one of the sets if necessary, we have `d_i = e_i` for all `i`.*"

**★★★ 次数表（书上 p.59，L1 逐字，Table 1「Degrees of basic invariants」的相关行）**：

| Type | `d₁,…,d_n` |
|---|---|
| `A_n` | `2, 3, …, n+1` |
| `B_n` | `2, 4, 6, …, 2n` |
| `D_n` | `2, 4, 6, …, 2n−2, n` |
| `E₆` | `2, 5, 6, 8, 9, 12` |
| `E₇` | `2, 6, 8, 10, 12, 14, 18` |
| **`E₈`** | **`2, 8, 12, 14, 18, 20, 24, 30`** |
| `F₄` | `2, 6, 8, 12` |
| `G₂` | `2, 6` |

表下正文（书上 p.59，L1 逐字，**必须随引用一起写的诚实话**）：

> "At the risk of lessening the suspense, we provide in Table 1 the list of degrees for each type of irreducible `W`.
> **It will be some time before we succeed in verifying the table completely**, but meanwhile the reader can compare
> it with the partial results obtained."

⇒ **引用时要注明：Table 1 是「先给结果、后文再验证」的表，不是就地被证明的定理。**
（本书后续 §3.9–§3.20 与第 4 章才把它补完；本轮**没有**逐条核实那部分。）

**对 E₈ 卡的直接后果**：`d = (2, 8, 12, 14, 18, 20, 24, 30)` 里**没有 4，也没有 6**
⇒ `W(E₈)`-不变多项式在 4 次与 6 次分量上分别只有一维（由 `f₂²` 和 `f₂³` 张成）
⇒ 一旦有了 (A)（§44.4），就得到 `Tr F⁴ ∝ (Tr F²)²`、`Tr F⁶ ∝ (Tr F²)³`。
**这正是 GS 致谢里 Chapline–Slansky 那句「E₈ has no independent fourth- and sixth-order Casimir invariants」的数学内容。**

**顺带（L1，同书 §3.6 remark 与 References）**：Chevalley 定理的原始出处是
`C. Chevalley, "Invariants of finite groups generated by reflections", Amer. J. Math. 77 (1955), 778–782`
（书上 p.188 的参考文献表逐字），Humphreys 的证明「follows closely the original proof in Chevalley [2]」。

### 44.4 ⚠ (A) Chevalley **限制**定理：本轮最弱的一环

需要的陈述是：**`𝔤` 上的 `Ad`-不变多项式函数由它在 Cartan 子代数 `𝔥` 上的限制唯一决定，且限制映射是到 `S(𝔥*)^W` 的同构。**
（注意与 §44.3 的 Chevalley 定理是**两条不同的定理**：那条是关于反射群不变量环的结构，这条是 `𝔤 ↔ 𝔥` 的桥。）

本轮拿到的证据只有两条，**都不足以写编号**：

1. **L1 的交叉引用**（Humphreys 本人，*Reflection Groups*，书上 **p.56**，§3.5 末的 Remark，逐字）：
   > "*Remark.* When `W` is a Weyl group, a theorem of Harish–Chandra (see **Humphreys [1], §23**) allows one to derive
   > from Chevalley's Theorem a description of the center of the universal enveloping algebra of a semisimple Lie
   > algebra over `C`: it too is a polynomial algebra."
   其中 `Humphreys [1]` 由该书参考文献表（书上 **p.193**，L1 逐字）确定为
   `J.E. Humphreys, Introduction to Lie Algebras and Representation Theory, Springer, New York, 1972`（= `humphreys-1972`）。
   ⇒ **「GTM 9 的 §23 讲的正是从 Chevalley 定理往李代数侧过桥」这一点是 L1 的。**
   ⚠ 但这条 Remark 说的是 **Harish–Chandra 关于 `Z(U(𝔤))` 的定理**，**不是** `S(𝔤*)^𝔤 ≅ S(𝔥*)^W`。两者相关但不同。
2. **L4 的页码**：Google Books 卷 `mSD4DvUFa6QC`（= GTM 9，**该卷在 §15.3 已做过无意义串控制，返回显式 "No results"，是"诚实卷"**），
   查询 `"Invariant polynomial functions"` → **Page 126**。与「§23 起于 p.126 附近」相容。

⇒ **可写进图的最强形式**：`Humphreys, GTM 9, §23`，note 写明「小节标题与内容本轮未逐字核实；
页码 p.126 来自 Google Books 单页命中（L4）；**不得写 `§23.1`**（`.1` 这一级本轮零证据）」。
⇒ **这是 E₈ 卡真正的瓶颈**：如果 curator 想让 `--via-e8-root-sum` 这条推导干净地走 `rigorous`，
最好的做法是**绕开 (A)**——见 §44.7/§44.8：直接对 248 个权做幂和，就**不需要**限制定理，
只需要「`F` 可对角化到 Cartan」这一个（对半单元素平凡、对一般元素用稠密性）的事实。

### 44.5 ★★★ (C) 的独立确认：van Ritbergen–Schellekens–Vermaseren

**文献标识（L1，PDF 首页页眉/侧栏逐字）**：
`T. van Ritbergen, A.N. Schellekens, J.A.M. Vermaseren, "Group theory factors for Feynman diagrams",
UM-TH-98-01 / NIKHEF-98-004`；侧栏戳记 `arXiv:hep-ph/9802376v1  20 Feb 1998`；
arXiv abs 页给出 `Int.J.Mod.Phys.A14:41-96,1999`，47 页。
（⚠ **PDF 首页正文的日期行印的是 "26 November 2024"** —— 这是 arXiv 重新编译的时间戳，**不是论文日期**；
引用时用 1998/1999，并把这条坑写进 note。）

**★★★ 附录 A.5「Indices and trace identities for E₈」（PDF p.35，L1 逐字）**：

> Trace identities in the representation (248):
> `Tr F⁴ = 36 (1/60 Tr F²)²`  **(176)**
> `Tr F⁶ = 30 (1/60 Tr F²)³`  **(177)**
> `Tr F¹⁰ = (15/4)(Tr F⁸)(1/60 Tr F²) − (315/4)(1/60 Tr F²)⁵`  **(178)**

**与 GS 的逐位比对（抽取者复算）**：

| | vRSV | 化简 | GS |
|---|---|---|---|
| 4 阶 | `36 (Tr F²/60)² = (36/3600)(Tr F²)²` | `= (1/100)(Tr F²)²` | **(12b′) `Ω₈ = (1/100)(tr F²)²`** ✓ |
| 6 阶 | `30 (Tr F²/60)³ = (30/216000)(Tr F²)³` | `= (1/7200)(Tr F²)³` | **(12c′) `Ω₁₂ = (1/7200)(tr F²)³`** ✓ |

⇒ **GS 的 (12b′)(12c′) 现在有了一个完全独立、可公开获取、带编号的第二来源。**
且两者的 `tr` 都是 **248 维伴随表示上的迹**（vRSV 明写 "in the representation (248)"；
GS 侧见 `green-schwarz-1984.md` §1.1「E₈ 伴随即基本，`tr = Tr`」）——**归一化不冲突**。

**顺带取到、curator 可能用得上的（同文，L1）**：
- **Table 3（PDF p.16）**：`E₈` 的 reference representation `(1,0,0,0,0,0,0,0)`，**Dimension 248**，
  Indices `60,1,1,1,1,41,199,61`。（第二指标 = `2 × 对偶 Coxeter 数`，同文 §5.12 逐字说明；`E₈` 的 `g = 30` ⇒ 60。）
- **Table 9（PDF p.38）**「Indices for `E₈`, part one」：`(1,0,…,0)` 248 行的 `I₂/30 = 1`、`I₈ = I₁₂ = I₁₄ = 1`。
- 文献自称的严格程度：「**all trace identities to order equal to the dual Coxeter number**」（摘要逐字），
  §5.11 说明 `E₈` 的字符是用**子代数 `D₈`** 展开算出来的（见 §44.6），**不是**从 Weyl 特征标公式硬展
  （§5.2 逐字解释了为什么 Weyl 公式对 `E₈` 到 30 阶是 "an impossible task"）。

**⚠ 一条我自己发现的、必须标为「抽取者的核对，不是原文错误认定」的疑点**：
同文 §5.1 的生成函数展开式 **(51)**（反对称张量幂的字符）
`Ch_{[k]*R}(F) = − Σ_{{n_i,m_i}} Π_i (1/m_i!) ( − Ch_R(n_i F)/n_i )^{m_i}`
在 `k = 1` 时给出正确的 `Ch_R(F)`，但在 `k = 2` 时按字面展开给出 `½Ch_R(2F) − ½Ch_R(F)²`，
**与标准的 `Ch_{Λ²R}(F) = ½[Ch_R(F)² − Ch_R(2F)]` 差一个整体符号**（偶 `k` 都差这个号）。
可能是排印/我读图的问题。⇒ **不要把 (51) 当作 §43.5(a) 展开公式的来源**；
§43.5(a) 的两条恒等式仍按「本项目自证」处理。

### 44.6 248 = 120 ⊕ 128：最好的免费带编号来源是 vRSV (86)，不是 Slansky

**vRSV §5.11「E₈ characters」（PDF p.22，L1 逐字）**：

> "Here we used the sub-algebra `D₈`, and
> `Ch_{E₈,248} = Ch_{D₈,128} + Ch_{D₈,120}`  **(86)**
> `Ch_{E₈,3875} = Ch_{D₈,1920} + Ch_{D₈,1820} + Ch_{D₈,135}`  **(87)**
> `Ch_{E₈,147250} = Ch_{D₈,60060} + Ch_{D₈,56320} + Ch_{D₈,15360} + Ch_{D₈,7020} + Ch_{D₈,6435} + Ch_{D₈,1920} + Ch_{D₈,135}`  **(88)**"

**必须随引用一起写的作者注（同页，L1 逐字）**：

> "In the first three lines all `D₈` spinor representations must be from the same conjugacy class, which is fixed by
> the decomposition one chooses for the (248). Since the choice one makes for the class is irrelevant, there is no
> need for a label to distinguish conjugate spinors."

⇒ `D₈ = so(16)`，`128` = 旋量表示，`120` = `so(16)` 的伴随（`= 16·15/2`）。
**这就是图里要的 `248 = 120 ⊕ 128`，带编号 (86)，免费可复核。**
（⚠ 原文写的是字符等式 `Ch_{E₈,248} = Ch_{D₈,128} + Ch_{D₈,120}`，即**分支规则**；
「120 是 `so(16)` 的伴随子代数」这一句是记号翻译，原文没写。）

**Slansky**：本轮只拿到书目（INSPIRE，L2 逐字）：
`R. Slansky (Los Alamos), "Group Theory for Unified Model Building", Phys. Rept. 79 (1981) 1–128`。
**正文一页未取，任何表号（"Table 25" 之类）都是 L0，禁写。**
建议：如果 vRSV (86) 够用，**就不要引 Slansky 的表号**；Slansky 只作为历史归属（GS 致谢里点了 Slansky）登记。

### 44.7 ★★ 本轮最有价值的一步：从 §44.2 的根系直接算出 (12b′)(12c′)（抽取者手算，全部对上）

> 这一节是**抽取者的复算**，不是任何来源的原文。但它只用 §44.2 的 L1 根系列表，
> 且**每一步都是二项式展开与求和**，可以脚本化、可以 Lean 化。

**设定**：取 `H ∈ 𝔥`，在 §44.2 的坐标下写成 `x = (x₁,…,x₈)`。伴随表示的权 = 240 个根 + 8 个零权（Cartan 本身），
所以

```
Tr_{248} H^k = Σ_{α ∈ Φ} α(H)^k          (k ≥ 1；零权不贡献)
```

**k = 2**：
- 向量型根 `±(ε_i ± ε_j)`：`Σ_{i<j} 2[(x_i+x_j)² + (x_i−x_j)²] = 4 Σ_{i<j}(x_i²+x_j²) = 28 Σ x_i²`
- 旋量型根 `½Σ s_i ε_i`（128 个，符号偶）：`Σ_patterns ¼(Σ s_i x_i)² = 128·¼·Σx_i² = 32 Σ x_i²`
  （交叉项 `Σ_patterns s_i s_j = 0`：翻转 `s_i` 与某个第三个 `s_k` 保持宇称、改变符号 ⇒ 配对相消）
- **合计 `Tr F² = 60 Σ x_i²`**（与 vRSV Table 3 的 `I₂ = 60` 一致 ✓）

**k = 4**：
- 向量型：`28 Σx⁴ + 24 Σ_{i<j} x_i²x_j²`
- 旋量型：`(128/16)[Σx⁴ + 6Σ_{i<j}x_i²x_j²] = 8Σx⁴ + 48Σ_{i<j}x_i²x_j²`
- 合计：`36 Σx⁴ + 72 Σ_{i<j}x_i²x_j² = 36 (Σ x_i²)²`
- ⇒ **`Tr F⁴ = 36 (Σx²)² = 36 (Tr F²/60)² = (1/100)(Tr F²)²`** = **GS (12b′)** ✓ = **vRSV (176)** ✓

**k = 6**：
- 向量型：`28 Σx⁶ + 60 Σ_{i≠j} x_i⁴x_j²`
- 旋量型：`2 Σx⁶ + 30 Σ_{i≠j} x_i⁴x_j² + 180 Σ_{i<j<k} x_i²x_j²x_k²`
- 合计：`30 Σx⁶ + 90 Σ_{i≠j}x_i⁴x_j² + 180 Σ_{i<j<k}x_i²x_j²x_k²`
- 而 `30(Σx²)³ = 30[Σx⁶ + 3Σ_{i≠j}x_i⁴x_j² + 6Σ_{i<j<k}x_i²x_j²x_k²]` = 同一式
- ⇒ **`Tr F⁶ = 30 (Σx²)³ = 30 (Tr F²/60)³ = (1/7200)(Tr F²)³`** = **GS (12c′)** ✓ = **vRSV (177)** ✓

**顺带**：`|Φ| + rank = 240 + 8 = 248` ⇒ **`dim E₈ = 248`**，
即 `green-schwarz-1984.md` §5.4 的 **A4** 那条（`dim E₈` "Mathlib 目前没有"）也能由同一个根系列表得到。

**这条路线的三个好处**：
1. **绕开 §44.4 的 (A)**：只需要「对 `H ∈ 𝔥` 成立」+「不变多项式由 `𝔥` 上的值决定」的**弱形式**
   （或者干脆把陈述本身写成「对 `H ∈ 𝔥`」，那就**完全不需要**限制定理）。
2. `k = 4, 6` 的结论**不依赖** §44.3 的次数表——次数表是「为什么会是这样」的解释，
   幂和复算是「就是这样」的证明。两者互为独立佐证。
3. 全程只有有理数算术 ⇒ **脚本枚举 240 个根 + 符号求和，reviewer 复核后可走 `rigorous` 例外**（任务书的提法成立）。

### 44.8 图里建议怎么加（供 curator 取舍；researcher 不改 `graph/`）

1. **新 statement `math.e8-root-system`**：「E₈ 根系由 `±ε_i±ε_j (i<j)` 与 `½Σ±ε_i`（`+` 号个数为偶）共 240 个向量构成」。
   `sources`: `humphreys-1990-reflection`，`loc: "§2.10 (Construction of root systems), pp. 42–43"`；
   `bourbaki-lie-4-6`，`loc: "Ch. VI, Planche VII"`，**`note` 必须写「本项目未取得 Bourbaki 原文；
   该定位来自 Humphreys §2.10 自陈 'following Chapter VI of Bourbaki [1]'，是 L3」**。`status: rigorous`。
2. **新 statement `math.e8-basic-invariant-degrees`**：「`W(E₈)` 的基本不变量次数为 2,8,12,14,18,20,24,30」。
   `sources`: `humphreys-1990-reflection`，`loc: "§3.7, Table 1 (Degrees of basic invariants), p. 59"`，
   `note`: 「原书在表下自陈 'It will be some time before we succeed in verifying the table completely'，
   完整验证在 §3.9–3.20 与 Ch.4，本项目未逐条核实」。`status: rigorous`。
3. **新 statement `math.chevalley-invariant-theorem`**（可选）：反射群不变量环是多项式环。
   `loc: "§3.5, Theorem 3.5"`（作者本人两次这么引，见 §44.3）+ 原始出处 `Chevalley, Amer. J. Math. 77 (1955) 778–782`。
4. **新 derivation `math.e8-adjoint-trace-identities--via-root-sum`**（**建议作为首选，替代任务书里的
   `--via-so16-weights`**）：`depends_on: [1]`，论证 = §44.7 的幂和复算，
   `sources`: `van-ritbergen-1998`（`loc: "App. A.5, eqs. (176)–(177)"`）作为**独立数值确认**。
   `status: rigorous`，`gaps:` 写「幂和为脚本枚举 + 手算双验；`Tr` 取 248 维伴随」。
   - **为什么不推荐 `--via-so16-weights`**：248 = 120 ⊕ 128 那条（§44.6）只是把权集合**换一种描述**，
     算出来的幂和与直接用根系**完全一样**，却多引入一条分支规则和一条「旋量共轭类」的注意事项。
     若 curator 仍要保留它，`loc` 写 `van-ritbergen-1998, §5.11, eq. (86)`，**并把作者那条共轭类的注一起抄进 note**。
5. **旧 derivation（挂 `green-schwarz-1984` (12′) 的那条）保留**，`status` 诚实写 `physical-argument`
   （GS 原文「直接给出，无证明、无引用」）。**两条独立推导挂同一张卡。**
6. **不要**把 §44.4 的 Chevalley 限制定理做成必需依赖——按 §44.7 的路线它不是必需的。
   若要建节点，`loc` 只能写 `humphreys-1972, §23`，且 `status` 不高于 `rigorous`、note 写明内容未核实。

### 44.9 `sources.bib` 本轮登记情况

| key | 条目 | 证据等级 | 处理 |
|---|---|---|---|
| `cvitanovic-2008` | P. Cvitanović, *Group Theory: Birdtracks, Lie's, and Exceptional Groups*, Princeton U.P. (2008); webbook v9.0.1, April 8, 2011 | **L1 全文** | **新登记** |
| `humphreys-1990-reflection` | J.E. Humphreys, *Reflection Groups and Coxeter Groups*, Cambridge Studies in Advanced Math. **29**, CUP | **L1 ch.2/ch.3/References 全读** | **新登记** |
| `van-ritbergen-1998` | T. van Ritbergen, A.N. Schellekens, J.A.M. Vermaseren, *Group theory factors for Feynman diagrams*, IJMPA **14** (1999) 41–96, arXiv:hep-ph/9802376 | **L1 全文（按页读）** | **新登记** |
| `fulton-harris-1991` | W. Fulton, J. Harris, *Representation Theory: A First Course*, GTM 129, Springer | **正文未取得；Lecture 级 L4** | **登记，note 写死禁令** |
| `bourbaki-lie-4-6` | N. Bourbaki, *Groupes et algèbres de Lie*, Ch. 4–6, Hermann, Paris, 1968; Masson, Paris, 1981 | **书目为 L1**（Humphreys 参考文献表 p.187 逐字）；**正文 0 页** | **登记，note 写死「只有书目是 L1」** |
| `humphreys-1972` | **已存在**（§15 登记）。书目由 Humphreys 本人的参考文献表（*Reflection Groups* p.193）L1 再确认 | 内容 L0 | **补 note**（§23 的事） |
| `slansky-1981` | R. Slansky, *Group Theory for Unified Model Building*, Phys. Rept. **79** (1981) 1–128 | **L2**（INSPIRE 逐字）；正文 0 页 | **登记，note 写死「禁写表号」** |
| `chevalley-1955` | C. Chevalley, *Invariants of finite groups generated by reflections*, Amer. J. Math. **77** (1955) 778–782 | **L3**（Humphreys 参考文献表 p.188 逐字） | **本轮不登记**（正文未取，且图里暂时用不到） |

### 44.10 访问日志与未解决问题（本节）

| 目标 | URL / 手法 | 结果 |
|---|---|---|
| **Humphreys *Reflection Groups* 书目页** | `www.cambridge.org/core/product/identifier/9780511623646/type/book` → 书 hash `2910C1E00877D33A04A512791B6EDD72` | **成功**：全部 item hash + 页范围 |
| **同书 ch.2（pp.29–48）** | Core `/services/…/D2925389A4A9FDD2D6C587F55AAB1CF7/9780511623646c2_p29-48_CBO.pdf/…` | **成功**（1.0 MB，读 pp.41–46） |
| **同书 ch.3（pp.49–86）** | 同上 `1DD151BF79ED7B49783AAA0B265EF54E/9780511623646c3_p49-86_CBO.pdf` | **成功**（1.8 MB，读 pp.49–60） |
| **同书 References（pp.185–202）** | ⚠ `…c9_p185-202_CBO.pdf` → **HTTP 404**；正确文件名是 **`9780511623646bib_p185-202_CBO.pdf`** | **成功**（745 KB，读 pp.185–188、192–193） |
| **vRSV 全文** | `arxiv.org/pdf/hep-ph/9802376` | **成功**（419 KB，47 页，读 pp.1–3, 13–27, 33–38） |
| **Slansky 书目** | `inspirehep.net/api/literature?q=title%20"…"&fields=titles,authors,publication_info` | **成功**（L2 书目） |
| Fulton–Harris | 见 §43.6 | 只到 Lecture 级 |
| DNB 检索 UI | `portal.dnb.de/opac/simpleSearch?query=…` | **失败**：Anubis「Access Denied」（与既有记录一致；`d-nb.info/<IDN>/04` 仍可用，但本轮没有 IDN） |

**方法论新知（值得进 `reading-list.md`）**：
**Cambridge Core 的后置内容（References/Bibliography）文件名用 `bib`，不是 `c<N>`**——
与 §「前置内容用 `mfm`」是同一类坑。**推不出来就先 fetch `/core/books/abs/<book-slug>/<item-slug>/<HASH>` 拿 "Save PDF" 链接。**
另外：**一本 CUP 数学书的 References 章本身就是一个极好的 L1 书目源**——
本轮就是靠它把 `bourbaki-lie-4-6`（Hermann 1968 / Masson 1981）与 `humphreys-1972` 的著录钉死的。

**未解决 / 留给下一轮**

- **Q39** **Chevalley 限制定理的带编号来源**（§44.4）。GTM 9 §23 的**内容**本轮完全没核到（L0），
  `§23.1` 这一级零证据。候选入口：(i) 找一篇**逐字引了 `[Hum, §23.1]` 或 `[Hum, Theorem 23.1]`** 的论文；
  (ii) Google Books 卷 `mSD4DvUFa6QC` 上再跑几个短语（该卷已验证诚实）；
  (iii) 按 §44.7 的路线**根本不需要它**——先确认 curator 走哪条路，再决定要不要花额度。
- **Q40** Humphreys *Reflection Groups* Table 1 的**完整验证**在 §3.9–3.20 / Ch.4 的哪一条（本轮只读到 §3.8）。
  若图里要把「E₈ 次数表」标成 `rigorous`，最好补上这个定位。
- **Q41** vRSV **式 (51) 的符号**（§44.5 末）：是排印错误、是我读图错误，还是另有约定？
  影响面很小（图里不用它），但如果将来要引 vRSV 的字符生成函数，必须先结清。
- **Q42** Fulton–Harris 的逐字（= §43.6 的 Q36），以及 **Bourbaki Planche VII 的正文**（本轮 0 次调用）。
- **Q43** Slansky 1981 是否有可公开取得的全文（LA-UR 预印本号 / OSTI）——本轮**未查**（WebSearch 额度已耗尽）。
  按 [[osti-doe-report-fulltext-route]]，`osti.gov` 的 `q="Group theory for unified model building"` 标题短语查询值得一试。

---

## 40. Q32 结案：Bârză–Ghişa, *Math. Bohemica* 129 (2004) 129–140 正文（researcher，2026-09-11）

- 触发：§39.10 的 **Q32**——「RP² 自同构那条结论**唯一的真正证明出处**」。
  §39.7.2 已确认 Cao-Huu–Ghişa (arXiv:0902.2725) 的 Corollary 3.1 把证明外包给本文（其 ref [5]）。
- 本节的结论**改变了 §39 的判断**：见 §40.3。

### 40.0 结论表

| 问题 | 结论 | 位置 | 等级 |
|---|---|---|---|
| 本文里 RP² **自同构**那条的编号 | ✅ **Corollary 3.2**（不是 Theorem，也不是 3.1） | 刊页 **p.134** | **L4-全文** |
| 本文里 RP² 全部 dianalytic **变换**（含高次）那条 | ✅ **Theorem 3.1** | 刊页 **pp.133–134** | **L4-全文** |
| Corollary 3.2 里有没有「rotation of the Riemann sphere」 | ❌ **没有。全文不出现 "rotation"/"rotations"** | — | **L4-全文（两次独立提取一致）** |
| 有没有 SO(3) / SU(2) / PSU(2) / orthogonal group | ❌ 全文都没有 | — | **L4-全文** |
| 有没有把这些自同构称作**群**、或给**维数 3** | ❌ 都没有 | — | **L4-全文** |
| 书目元数据（卷期页、DOI） | ✅ Math. Bohem. **129** (2004) no. 2, 129–140；DOI `10.21136/MB.2004.133904` | Crossref + EuDML + Semantic Scholar 三源一致 | **L2** |

### 40.1 ⚠ 证据等级说明（本节**不是 L1**，请勿在图里写成 L1）

**我没有看到本文的任何页图。** 取正文的路线是：
`https://r.jina.ai/https://dml.cz/bitstream/handle/10338.dmlcz/133904/MathBohem_129-2004-2_3.pdf`
即用 **r.jina.ai 文本抽取代理**把 DML-CZ 的 PDF 转成纯文本，再由 WebFetch 的读取模型逐条回答。
所以：

- 拿到的是**全文文本**（不是摘要、不是二手转述），这一点强于 §0 的 L4 定义；
- 但**数学符号被抽取严重破坏**（`e iθ`、`6 =` 代替 `≠`、波浪号/上划线丢失成空格），
  **且不是我本人逐页读的**。
- 为此我在本节统一记作 **「L4-全文」**：**可以引编号与页码，不可照抄公式字符**。
  要升到 L1 必须拿到页图（见 §40.5 的死路清单）。
- 为降低单次读取误差，**同一 URL 做了两次措辞不同的独立提取**，两次在
  「无 rotation / 无群 / 无维数 / Corollary 3.2 是自同构那条」四点上完全一致。

### 40.2 抽取所得（逐条）

**编号清单（全文，按出现顺序）**：
Theorem 1.1 (p.130)、Theorem 1.2 (p.130)、Theorem 1.3 (p.131)、
Proposition 2.1–2.4 (p.132)、**Theorem 3.1 (pp.133–134)**、**Corollary 3.2 (p.134)**、
Theorem 4.1 (pp.135–136)、**Theorem 6.1 (pp.138–139)**。

> ⚠ **本文自身有编号 bug**：最后一条编号是 **6.1**，却出现在标题为「5. The case of a Klein bottle」的节里。
> （与 §39.7.2 记的 Cao-Huu–Ghişa 把自己的 Theorem 2.1 叫成「Theorem 1」是同一类排印问题；
> 这两篇同一作者圈的文章在编号上都不严谨，**引用时必须写清"哪一页"而不能只写编号**。）

**节标题与页码**：
`1. Klein surfaces` p.129；`2. Dianalytic dynamics` p.132；
`3. Dianalytic self-maps of the real projective plane` p.133；
`4. Dianalytic self-maps of the pointed real projective plane` p.135；
`5. The case of a Klein bottle` p.138；References p.139。

**Corollary 3.2（p.134）**——抽取所得，**字符已被破坏，下面是原样转录并标注**：

> 「Dianalytic automorphisms of P 2 are of the form:」
> …（两支 `g(˜z) = …`，抽取里两支都掉了标记，**无法判断第二支是 `G̃(z̄)` 还是别的**）…
> 「G(z) = e iθ a z + b − ¯b z + a , where |a| + |b| 6 = 0 .」

即：**G(z) = e^{iθ}(az+b)/(−b̄z+a)**，条件 **|a| + |b| ≠ 0**。

> ⚠ **与 §39.7.2 的差异（必须留意）**：Cao-Huu–Ghişa (0902.2725, L1) 写的是分母 `−b̄z+ā`（a 上有横杠），
> 这里抽取出来的是 `− ¯b z + a`（a 上**没有**横杠）。**极可能是抽取丢了上划线**，
> 但在拿到页图之前**不能断言**。→ 图里**不得**把本文当作该公式的字符级出处；
> 公式字符仍以 **caohuu-ghisa-2004 (L1)** 为准。
- 归一化条件 `|a|+|b| ≠ 0` 与 §39.7.2 记的完全一样，**两篇都写得不严**（PSU(2) 要的是 `|a|²+|b|²=1`）。
  → §39.7.2 记的「不要照抄这行当定义」**在本文同样成立**。

**Theorem 3.1（pp.133–134）**：开头是「Dianalytic transformations f : P 2 → P 2 are of the form:」，
随后给出提升 `F` 必须是**奇次**有理函数、且分子分母系数满足共轭配对关系；
特例约化为 `F(z) = e^{iθ} z^{2n+1}`。
> 这与 Hawkins–Randolph, arXiv:1706.09980 **式 (3.1)**（该文 p.6，本轮读了页图，**L1**）逐字对得上：
> 「Additionally in [1] it is shown that these rational maps must be of the form:
> f(z) = e^{iθ}(a₀z^{2n+1}+a₁z^{2n}+…+a_{2n+1}) / (−ā_{2n+1}z^{2n+1}+ā_{2n}z^{2n}−…+ā₀), |a₀|+|a_{2n+1}| ≠ 0.」
> 其中 **[1] = Barza–Ghisa, Math. Bohemica (2004) 129–140**（该文 ar5iv 参考表，L2）。
> ⇒ **Theorem 3.1 的内容有一个独立的 L1 转引**；**但 Hawkins–Randolph 不转引 Corollary 3.2、也不提 rotation。**

**§3 开头的设定**：由「h : z → −1/z̄」生成的群对 Riemann 球作商得到 P²
（抽取里 `−1/z` 的上划线掉了；与 Polchinski (6.1.9) `z′ = −1/z̄`、与 0902.2725 的 `h(z) = −1/z̄` 一致）。

### 40.3 ★ 对 §39.7.2 判断的修正：「旋转群」这句话是 **Cao-Huu–Ghişa 加的，不是被引来源里的**

§39.7.2 把 **Cao-Huu–Ghişa Corollary 3.1**（「where **G is a rotation of the Riemann sphere**」）
列为「RP₂ 唯一找到的带编号数学陈述」，并注明其证明外包给本文。现在可以补完这条链：

| 环节 | 谁说的 | 说了什么 | 等级 |
|---|---|---|---|
| (i) 自同构 = 那族 Möbius 变换 `e^{iθ}(az+b)/(−b̄z+ā)` | **Bârză–Ghişa 2004, Corollary 3.2 (p.134)** | 只给**公式形式** | L4-全文 |
| (ii) 「这族 Möbius 变换 = 球面的旋转」 | **Cao-Huu–Ghişa 2004, Corollary 3.1 (0902.2725 p.2)** | 加了 "rotation of the Riemann sphere"；该文自称证明只是半页验证 | L1 |
| (iii) 「球面旋转群 = SO(3)，实维 3，故 κ = 3」 | **没有任何来源** | 使用者的补步 | — |

⇒ **§39.7.2 的「三条限制」要改成四条**：除了原有三条，还要加上
「**(d) 上游 Bârză–Ghişa 2004 里根本不出现 "rotation" 一词**，所以 (ii) 这一步是 Cao-Huu–Ghişa 自己补的，
而**它的证明并不在被它引作依据的那篇里**。」

这不是「找不到」，是**确定的否定结果**：两次独立全文提取都报告全文无 "rotation"。

### 40.4 给 curator 的建议（researcher 不改 `graph/`）

#### (1) `worldsheet.rp2-conformal-killing-group` 的 `sources` 建议写成三条并列，**不要合并**

```yaml
sources:
  # 物理侧（唯一逐字给出 SO(3) 的）
  - ref: polchinski-1998-v1
    loc: "§6.1「The projective plane」，书上 p.168-169（(6.1.9) 附近，无式号）"
    note: "L1。原书逐字给 CKG = SO(3) 与 no moduli；κ=3 须另挂 (5.2.11a)。"
  # 数学侧第一层：带编号，但「旋转」二字是本文加的
  - ref: caohuu-ghisa-2004
    loc: "Corollary 3.1（arXiv:0902.2725v1, p.2）"
    note: |
      L1。逐字含「G is a rotation of the Riemann sphere」。
      ⚠ 该文不写 SO(3)/PSU(2)/维数 3；且「rotation」这一步**不在**它所引的证明出处里（见下条）。
  # 数学侧第二层：真正的证明出处，但没有「旋转」
  - ref: barza-ghisa-2004
    loc: "Corollary 3.2，刊页 p.134（Math. Bohem. 129 (2004) 129-140）"
    note: |
      L4-全文（r.jina.ai 文本代理，非页图；literature/extractions/math-sources.md §40.1）。
      这是 caohuu-ghisa-2004 Theorem 2.1「We have shown in [5]」所指的那篇。
      ⚠ **本文只给 Moebius 形式 G(z)=e^{i theta}(az+b)/(-conj(b) z + a)，条件 |a|+|b| != 0；
      全文不出现 "rotation"、不出现 SO(3)/SU(2)/PSU(2)、不把这族映射称作群、不给维数。**
      ⇒ 「Aut(RP^2) 是 SO(3)、实维 3」在数学文献侧是**两步补步**，不是单条可引定理。
```

#### (2) 若节点 statement 里写了「SO(3)」或「维数 3」

必须在 `notes` 里保留一句：
> 「**SO(3)** 与「实维 3」在**任何数学来源里都不是原文**：Bârză–Ghişa 2004 Cor 3.2 只给 Möbius 形式，
> Cao-Huu–Ghişa 2004 Cor 3.1 只加到「球面的旋转」。写 SO(3) 的唯一逐字来源是 Polchinski p.168–169（物理书）。」

#### (3) 三条禁令（追加到 §39.9(7)）

4. **不得写 `Bârză–Ghişa 2004, Theorem 3.1` 来支持「自同构」那条**——Theorem 3.1 是**全部 dianalytic 变换**（含 2n+1 次），
   自同构那条是 **Corollary 3.2**。
5. **不得把 Bârză–Ghişa 2004 当作「旋转群/SO(3)」的出处**（§40.3）。
6. **不得引 `Bârză–Ghişa 2004, Theorem 5.x`**——该文最后一条编号是 **6.1**，却印在第 5 节里（§40.2）。

### 40.5 访问日志（本节）

| 目标 | URL / 手法 | 结果 |
|---|---|---|
| EuDML 记录页 | `eudml.org/doc/249387` | **成功**（给出 DML-CZ handle `10338.dmlcz/133904` 与 PDF 直链） |
| Crossref | `api.crossref.org/works?query.bibliographic=…` | **成功**（DOI `10.21136/mb.2004.133904`，元数据 language 字段误标 "la"） |
| Semantic Scholar | `api.semanticscholar.org/graph/v1/paper/DOI:10.21136/MB.2004.133904` | **成功**（openAccessPdf = DML-CZ 直链，GREEN） |
| **DML-CZ PDF 直取** | `dml.cz/bitstream/handle/10338.dmlcz/133904/…pdf`（≥6 次，含 `www.` / `?sequence=1` / handle 页 / DOI 跳转） | **全部失败：`Socket is closed`** |
| `mb.math.cas.cz` | `mb.math.cas.cz/mb129-2/` | **失败：`Socket is closed`** |
| EMIS 镜像 | `emis.de/journals/MB/…` | **失败：301 重定向到 `zbmath.org/serials/`（EMIS 的 MB 镜像已下线）** |
| **★ r.jina.ai 代理** | `r.jina.ai/https://dml.cz/bitstream/…pdf` | **成功（唯一活路）**，返回抽取文本（符号破坏） |
| allorigins 代理取二进制 | `api.allorigins.win/raw?url=…` | **失败：HTTP 520** |
| Hawkins–Randolph 页图 | `arxiv.org/pdf/1706.09980` → 落盘 → Read pages | **成功**（24 页，读 pp.1–8, 18–21, 24；式 (3.1) 在 p.6） |
| ar5iv 参考表 | `ar5iv.labs.arxiv.org/html/1706.09980` | **成功**（确认 [1] = Barza–Ghisa 2004） |

> **两条新经验（可复用）**：
> (1) **`.cz` 域（`dml.cz`、`mb.math.cas.cz`）在本环境一律 `Socket is closed`**，不是限流、重试无用；
>     **绕法是 `https://r.jina.ai/<原 URL>`**，代价是只拿到文本、数学符号被破坏 ⇒ **只能升到 L4-全文，升不到 L1**。
> (2) **EMIS 的期刊镜像（`emis.de/journals/<刊>/`）已整体重定向到 zbMATH**，旧的 EMIS 全文路线**作废**。

### 40.6 遗留问题

- **Q37** **Bârză–Ghişa 2004 的页图**（升 L1，确认 `−b̄z+ā` 的上划线、确认 Corollary 3.2 第二支是不是 `G̃(z̄)`）。
  可能的下一招：某个能返回二进制的代理；或 ELibM/zbMATH 的 PDF 镜像；或纸本馆藏。
- **Q38** 本文 Theorem 1.1–1.3（Klein 面 ↔ 对称 Riemann 面的商、dianalytic ↔ 与 h 交换的解析映射）
  与 barza-ghisa-2009 的 **Theorem 1 / Theorem 3** 是不是同一批结果的两次发表——若是，2009 那篇可作 §40 的**独立第二来源**（已 L1）。本轮未逐条比对。

---

## 41. GKPW 字典的数学背书：Fefferman–Graham 1985 与 Graham–Lee 1991（researcher，2026-09-11）

- 触发：`literature/extractions/witten-1998-ads.md` **第 345 行**自列的未解决项：
  「**Graham–Lee 定理 [42]（Adv. Math. 87 (1991) 186）本身未核实**；Fefferman–Graham [44] 的
  "Theorems 2.1 and 2.3" 亦未核实。**这两条是 GKPW 字典里唯一有真数学定理背书的部分，做形式化前必须一手核实。**」
- 本节的结果是**一半结案、一半确认取不到**。

### 41.0 结论表

| 问题 | 结论 | 位置 | 等级 |
|---|---|---|---|
| **Fefferman–Graham 1985 全文** | ✅ **取到，页图逐页读** | Numdam 扫描件，刊页 95–116 | **L1** |
| FG **Theorem 2.1**（ambient metric，n 奇/偶） | ✅ 逐字到手 | 刊页 **p.101** | **L1** |
| FG **Theorem 2.3**（Poincaré metric，n 奇/偶） | ✅ 逐字到手 | 刊页 **p.103** | **L1** |
| FG 有没有「第 5 节证明」 | ✅ 有：**「V. About the Proof of Theorem 2.1」** | 刊页 **p.111** | **L1** |
| **Graham–Lee 1991 全文** | ❌ **未取到**（7 条路线全败，见 §41.4） | — | **L0** |
| Graham–Lee 的主定理**编号** | ❌ **未核实**；且有反证：**任务书假设的「Theorem A/B」缺乏支持** | 见 §41.3 | **L0（+ L3 反证）** |
| Witten 引的到底是哪一篇的 Theorems 2.1/2.3 | ✅ **是 [44] = Fefferman–Graham**，不是 Graham–Lee | Witten 刊页 p.18、p.19 | **L1** |
| Witten 的参考编号 [42]/[43]/[44]/[45]/[46] | ✅ 逐字到手 | Witten 刊页 p.39 | **L1** |

---

### 41.1 ★★ Fefferman & Graham, "Conformal invariants", Astérisque **S131** (1985) 95–116（L1 全文页图）

**取法（可复用）**：Numdam 有全本扫描且**不设墙、不被拦**——
卷页 `numdam.org/issues/AST_1985__S131_/` → 篇页 `numdam.org/item/AST_1985__S131__95_0/`
→ **PDF 直链 `numdam.org/item/AST_1985__S131__95_0.pdf`**（2.2 MB，WebFetch 落盘后用 Read 带 `pages` 读页图）。
**PDF 页 = 刊页 − 94**（PDF p.2 = 刊页 95；封面页占 PDF p.1）。

#### 41.1.1 ambient metric 的三条件（刊页 p.101，L1 逐字）

> "There are three conditions to be imposed to determine the ambient metric g̃, of signature (p+1, q+1), on G̃. They are :
> 1) δ_s* g̃ = s² g̃, s > 0;  2) ι* g̃ = g₀;  3) Ric(g̃) = 0."

#### 41.1.2 ★★★ **THEOREM 2.1**（刊页 **p.101**，L1 逐字）

> **THEOREM 2.1.**
> *a) n odd. Up to a **R₊**-equivariant diffeomorphism fixing G, there is a unique formal power series
> solution g̃ to 1)–3). If the conformal structure on M is real analytic (i.e. has a real analytic
> representative), then this formal power series converges so that g̃ actually exists in a neighborhood of G.*
> *b) n even. There are conformal structures for which there is no formal power series solution of 1)–3).
> However, if 3) is replaced by :*
> *3′) Along G, all components of Ric(g̃) vanish to order (n−4)/2 and the components tangential to G vanish
> to order (n−2)/2,*
> *then there is a formal power series solution for g̃ uniquely determined up to addition of terms vanishing
> to order n/2 and up to a **R₊**-equivariant diffeomorphism fixing G.*

紧接其后（同页，L1）：「As with the complex Monge-Ampère equation [11], [6], [17], one can continue the
solution to higher order when n is even by including log terms in the expansion for g̃.」

#### 41.1.3 Poincaré metric 的条件（刊页 pp.102–103，L1 逐字）

条件 1)、2)（p.102）：
> "1) g⁺ has [g] as conformal infinity   2) Ric(g⁺) = −n g⁺."

写成（**式 (2.2)**，p.102）：
> (2.2)  g⁺ = r^{−2}[ dr² + Σ_{i,j=1}^n g⁺_{ij}(x,r) dx^i dx^j ].

条件 3)（p.103）：
> "3) When written in the form (2.2), g⁺_{ij} is an even function of r, 1 ≤ i, j ≤ n."

⚠ 同页作者自陈：「Although it is not obvious, it is nonetheless true that this condition is independent of
the choice of coordinate system (x, r) …. **It would be nice to have an invariant way of stating this
condition, but we have not succeeded in finding one.**」

**「conformal infinity」的定义**（p.102，L1）：作者明写「essentially following the formulation of **LeBrun [16]**
of this concept extant for some time in the physics literature」，即：
N 是带边流形，r ∈ C^∞(N̄) 满足 r > 0 in N、r = 0 且 dr ≠ 0 on bN；
若存在 m > 0 使 r^m g⁺ 光滑延拓到 N̄ 且限制到 TbN 时属于 [g]，则称 g⁺ 以 [g] 为 conformal infinity。

#### 41.1.4 ★★★ **THEOREM 2.3**（刊页 **p.103**，L1 逐字）

> **THEOREM 2.3.**
> *a) n odd. Up to a diffeomorphism fixing M, there is a unique formal power series solution g⁺ to 1)–3).
> If [g] is real analytic, then the power series converges so that g⁺ exists and r²g⁺ is analytic up to the boundary.*
> *b) n even. There are conformal structures for which there is no formal power solution of 1)–3). However,
> if 2) is replaced by :*
> *2′) Along M, the components of Ric(g⁺) + ng⁺ vanish to order n−2,*
> *then there is a formal power series solution for g⁺ uniquely determined up to addition of terms vanishing
> to order n−2 and up to a diffeomorphism fixing M.*

#### 41.1.5 ★ 三条**必须随引用一起写**的限制

1. **这两条定理是「形式幂级数」的存在唯一性，不是度规的存在性。**
   只有在 **[g] 实解析**时才断言收敛。n 偶时**存在无解的共形结构**（有障碍，见 **Proposition 3.5**，刊页 p.107）。
   ⇒ **不能**用 FG Thm 2.1/2.3 去支持「任意边界共形结构都有体度规」。
2. **n 偶与 n 奇的陈述本身不同**（a)/b) 两支），这正是 Witten 用来解释「共形反常只在偶 d 出现」的依据（§41.2）。
3. **第 5 节只证 Theorem 2.1**：刊页 p.111 的节标题逐字是
   **「V. About the Proof of Theorem 2.1」**，开头写「In this section **some of the ingredients** in the proof
   of THEOREM 2.1 are discussed.」——即**原文并未给出完整证明**，只讨论了打破规范不变性的特殊坐标系
   （**PROBLEM 5.1**，p.111）。**Theorem 2.3 的证明在原文里没有独立一节**（原文 p.103 说 Poincaré 问题与 ambient 问题等价，
   并在 pp.103–104 给出从 g̃ 造 g⁺ 的显式过程与式 (2.4)）。

#### 41.1.6 顺带取到的其它编号（L1，供以后复用）

- **CONJECTURE 3.1**（p.105，n odd）：Every scalar conformal invariant is a linear combination of conformal Weyl invariants.
- **PROPOSITION 3.2**（p.105）：G 上 R̃ 的分量 = t²W、t²C、(t²/(n−4))B 等四式（i)–iv)）。
- **PROPOSITION 3.3**（p.106）、**PROPOSITION 3.4**（p.106，‖∇̃R̃‖² 对应 ‖V‖²+16(W,U)+16‖C‖²）。
- **PROPOSITION 3.5**（p.107，n even）：存在权 (n−2)/2 的共形不变对称无迹 2-张量，**它就是 ambient metric 形式解的障碍**；n = 4 时即 Bach 张量。
- **IV. Connection with Several Complex Variables**（p.108 起）：与复 Monge–Ampère、Cheng–Yau 的关系。

---

### 41.2 ★★ Witten 1998 到底引了什么（全部 L1，页图取自 `arxiv.org/pdf/hep-th/9802150`）

**PDF 页 = 刊页 + 1。**

#### 41.2.1 参考条目逐字（刊页 **p.39**）

> [42] R. Graham and J. Lee, "**Einstein Metrics With Prescribed Infinity On The Ball**," Adv. Math. **87** (1991) 186.
> [43] C. LeBrun, "*H*-Space With A Cosmological Constant," Proc. Roy. London Ser. A **380** (1982) 171.
> [44] C. Fefferman and C. R. Graham, "Conformal Invariants," *Elie Cartan et les Mathématiques d'aujourdhui* (Asterisque, 1985), 95.
> [45] H. Pedersen, "Einstein Metrics, Spinning Top Motion, And Monopoles," Math. Ann. **274** (1986) 35.
> [46] S. Y. Cheng and S.-T. Yau, "On The Existence Of A Complete Kahler Metric On Noncompact Complex Manifolds And The Regularity Of Fefferman's Equation," Comm. Pure Appl. Math **33** (1980) 507.

> ⚠ **Witten 把 Graham–Lee 的标题印错了**：真题名是 "Einstein metrics with prescribed **conformal** infinity
> on the ball"（Crossref/OpenAlex/作者主页三源一致，L2），Witten 少了 "conformal"。
> → 图里的 `sources[].loc` 若照抄 Witten，会引出一个**查不到的题名**。

#### 41.2.2 Graham–Lee 定理被引处（刊页 **p.7**，L1 逐字）

> "Conversely, by a theorem of Graham and Lee **[42]** (see **[43–46]** for earlier mathematical work), any
> conformal structure on **S**^d that is sufficiently close to the standard one arises, by the procedure in (2.2),
> from a unique metric on B_{d+1} that obeys the Einstein equations with negative cosmological constant and has
> a double pole at the boundary. (Uniqueness of course means uniqueness up to diffeomorphism.) This is proved by
> first showing existence and uniqueness at the linearized level (for a first order deformation from the standard
> conformal structure on **S**^d) roughly along the lines of the above treatment of scalars, and then going to
> small but finite perturbations via an implicit function argument."

#### 41.2.3 Fefferman–Graham 被引处（刊页 **p.18** 与 **p.19**，L1 逐字）

> （p.18）"**Theorems 2.1 and 2.3 of [44]** show that the metric of B_{d+1} is determined locally by the conformal
> structure of **S**^d up to very high order. **The proof of the theorems in section 5 of that paper** involves showing
> that once one picks a metric on **S**^d in its given conformal class, one can pick distinguished coordinates near the
> boundary of B_{d+1} to very high order."

> （p.19）"The conformal anomaly arises only for even d; this is related to the fact that **Theorems 2.1 and 2.3 in [44]
> make different claims for odd and even d**. In the even d case, the theorems allow logarithmic terms that presumably
> lead to the conformal anomaly."

**三重交叉核验通过**：(i) 编号 [44] = Fefferman–Graham（p.39 逐字）；
(ii) FG 原文确有 Theorem **2.1** 与 **2.3**，且各自分 a) n odd / b) n even 两支（§41.1，L1）；
(iii) FG 原文的第 **V** 节标题就是 "About the Proof of Theorem 2.1"，内容正是「特殊坐标系」（§41.1.5，L1）。
⇒ **Witten 引的确实是 Fefferman–Graham，不是 Graham–Lee。**

> ⚠⚠ **本轮最容易踩的坑（已实测）**：**ar5iv 版 `ar5iv.labs.arxiv.org/html/hep-th/9802150` 给出的方括号编号与原文不同**
> ——ar5iv 读出来是「[26]–[29]」「Theorems 2.1 and 2.3 of **[27]**」，而 **arXiv PDF 原文是 [42]、[43–46]、[44]**。
> 若照 ar5iv 的编号去查参考表，会把 FG 误认成 LeBrun 或 Flato–Fronsdal。
> **教训：Witten 这篇（以及一切用 `\nref` 的 harvmac 老论文）的参考编号必须以 PDF 页图为准，不能用 ar5iv。**
> （附带：INSPIRE 的 reference label 与 PDF 编号在本篇是一致的，可作快速旁证。）

---

### 41.3 Graham & Lee 1991：**正文未取到（L0）**，只能挂二手转述

#### 41.3.1 书目（L2，三源一致）

C. Robin Graham and John M. Lee, "**Einstein metrics with prescribed conformal infinity on the ball**",
*Advances in Mathematics* **87** (1991), no. 2, 186–225. DOI `10.1016/0001-8708(91)90071-E`；MR 1112625。
NSF DMS-8702986 / DMS-8702618。

#### 41.3.2 ★ 「Theorem A / Theorem B」这个假设**没有证据，且有反证**

- 本轮**没有**在任何来源里看到 Graham–Lee 1991 的「Theorem A」「Theorem B」。
- **反证（L3）**：Lee 本人后来的 memoir *Fredholm operators and Einstein metrics on conformally compact manifolds*
  （arXiv:math/0105046）在正文里用的引法是 **「[29, Lemma 2.2]」**（[29] = Graham–Lee 1991）。
  ⇒ 该文**用的是分节编号（x.y），不是字母编号**。
- **混淆源**：Lee 的那本 **memoir 自己**的主定理才叫 **Theorem A**（「there exists an Einstein metric g on M
  that has [ĝ] as conformal infinity」）。**极易把 memoir 的 Theorem A 误记成 Graham–Lee 1991 的 Theorem A。**
- ⇒ **图里在拿到正文之前，`loc` 只能写「全文（未取得，L0）」或页码区间，严禁写任何定理号。**

#### 41.3.3 可用的二手转述（按可靠度排序）

| # | 出处 | 逐字 | 等级 |
|---|---|---|---|
| 1 | **Witten, hep-th/9802150, 刊页 p.7** | 见 §41.2.2（最完整：给了"接近标准共形结构"、"唯一（模微分同胚）"、"线性化 + 隐函数定理"三要素） | **L1** |
| 2 | **Lee, math/0105046, Introduction** | "Graham and I showed in [29] that every conformal structure on **S**^n sufficiently close to that of the round metric is the conformal infinity of an Einstein metric close to the hyperbolic metric."（作者本人转述） | **L3**（ar5iv 文本） |
| 2b | 同上，同处 | "our methods in that paper were **insufficient to prove a sharp isomorphism theorem**"（作者自陈的局限） | **L3** |
| 3 | Graham, math/9909042, Introduction | "each conformal structure on **S**^n sufficiently near the standard one is the conformal infinity of a unique (up to diffeomorphism) conformally compact Einstein metric on the ball near the hyperbolic metric." | **L3** |
| 4 | Anderson, hep-th/0403087, §6 | "By the Graham-Lee theorem [30], there is an AH Einstein metric g⁺ on B⁴ …"；并称 Friedrich 的结果是 "an exact analogue of the result of Graham-Lee [30]" | **L4** |
| 5 | arXiv:2509.18430, Introduction | 称其为 "a perturbation result, which was verified via **the implicit function theorem**" | **L4** |

四条转述在「**S**^n 上、**接近圆度规**、**存在且唯一（模微分同胚）**、**球上**、**微扰/隐函数定理**」五个要素上互相一致。
⇒ **陈述内容本身可以放心写**；**只有编号与逐字措辞是 L0。**

#### 41.3.4 ⚠ Witten 自己标出的两条限制（L1，来自 witten-1998-ads.md 已记录的 E-W3/E-W10，本轮页图复核一致）

- 刊页 p.8：「the restriction to conformal structures that are sufficiently close to the standard one
  **is probably also necessary** for most values of d」；
- 刊页 p.10：「the Graham-Lee theorem **presumably fails** for conformal structures that are sufficiently far
  from the round one」。
⇒ **Graham–Lee 定理是局部（小邻域）结果，且 Witten 认为其局部性是本质的。**

---

### 41.4 访问日志（本节）

| 目标 | URL / 手法 | 结果 |
|---|---|---|
| **Numdam 卷目录** | `numdam.org/issues/AST_1985__S131_/` | **成功**（21 篇全表；FG 在 pp.95–116） |
| **Numdam 篇页 + PDF** | `numdam.org/item/AST_1985__S131__95_0.pdf` | **成功**（2.2 MB 扫描件，落盘后 Read 页图；**PDF 页 = 刊页 − 94**） |
| **Witten 原文 PDF** | `arxiv.org/pdf/hep-th/9802150` | **成功**（41 页，读 pp.7–13, 17–20, 39–41；**PDF 页 = 刊页 + 1**） |
| Witten ar5iv | `ar5iv.labs.arxiv.org/html/hep-th/9802150` | **成功但编号错**（见 §41.2.3 警告） |
| INSPIRE 参考表 | `inspirehep.net/api/literature?q=arxiv:hep-th/9802150&fields=references` | **成功**（57 条，序号与 PDF 一致） |
| Graham–Lee 正文 | `sciencedirect.com/science/article/pii/000187089190071E` | **失败：HTTP 403**（机器人墙） |
| Graham–Lee 正文 | `r.jina.ai/https://www.sciencedirect.com/…` | **失败**：返回 "Are you a robot?" 页 |
| Graham–Lee OA 位置 | `api.openalex.org/works/doi:10.1016/0001-8708(91)90071-E` | **成功但结论是否定的**：`is_oa:false`, `oa_status:"closed"`, 全库无 repository 全文 |
| Graham–Lee OA 位置 | `api.semanticscholar.org/…` | **矛盾**：报 `isOpenAccess:true`, `openAccessPdf` 却只是 `doi.org/…`（BRONZE）——**指回付费墙，不是真 PDF** |
| Lee 主页论文表 | `sites.math.washington.edu/~lee/Research/papers.html` | **成功但结论是否定的**：该条只有 "Published Article" 链接，**无 arXiv、无 PDF** |
| Graham 主页 | `sites.math.washington.edu/~robin/`、`/~robin/Papers/index.html` | **失败**（前者只有联系方式；后者 404） |
| scholar.archive.org | `scholar.archive.org/search?q=…` | **失败：反爬验证页** |
| zbMATH | `zbmath.org/?q=…`、`r.jina.ai/https://zbmath.org/…` | **失败：403 / CAPTCHA** |
| core.ac.uk API | `api.core.ac.uk/v3/search/works?q=…` | **失败：403（需 API key）** |

> **新增经验**：
> (1) **★ Numdam 是取 Astérisque / 法国老期刊全文的可靠入口**，PDF 直链形如
>     `numdam.org/item/<ID>.pdf`，不设墙、不被拦；`<ID>` 从 `numdam.org/issues/<卷>/` 的目录页拿。
> (2) **Semantic Scholar 的 `isOpenAccess:true` 不可信**——它会把「DOI 落地页」当成 openAccessPdf（status=BRONZE）。
>     **判断是否真有 OA 全文，用 OpenAlex 的 `best_oa_location`**（本轮 OpenAlex 给的是干净的 `null`）。
> (3) **harvmac 老论文（Witten 这类）不要用 ar5iv 读参考编号**（§41.2.3）。

---

### 41.5 给 curator 的建议（researcher 不改 `graph/`）

> 我不代 curator/auditor 做裁决；以下只是把「哪条陈述能挂哪条编号、能挂到什么等级」摆出来。

#### (1) `holography.conformal-boundary-so2d`（witten-1998-ads.md 建议节点 C）：**本节不改其 sources，只加一条 note**

该节点是**纯几何**的（共形紧化 + SO(2,d) 作为边界共形群），**与 FG/GL 无关**。
建议在 `notes` 加一句，防止后来者把两件事混在一起：

```yaml
notes: |
  ⚠ 本节点只讲「边界带共形结构、SO(2,d) 作为共形群」，**不含**「边界共形结构能否决定体度规」。
  后者是另一条独立陈述，其数学来源见 literature/extractions/math-sources.md §41
  （Fefferman--Graham 1985 Thm 2.1/2.3 = 形式幂级数级；Graham--Lee 1991 = 圆度规附近的真存在唯一性）。
```

#### (2) 新 statement `holography.bulk-metric-from-boundary-conformal-structure`（建议**拆成两张卡**，不要合并）

**卡 (2a)：形式幂级数级（可挂 L1 编号）**

```yaml
kind: proposition
title: Fefferman--Graham 展开：边界共形结构形式地决定体 Einstein 度规
statement: |
  设 M^n 带共形结构 [g]。称 M^+ 上的度规 g^+ 为 [g] 的 Poincare 度规，若
  (1) g^+ 以 [g] 为 conformal infinity；(2) Ric(g^+) = -n g^+；
  (3) 在 g^+ = r^{-2}[dr^2 + g^+_{ij}(x,r) dx^i dx^j] 的写法下 g^+_{ij} 是 r 的偶函数。
  则：n 为奇数时，在固定 M 的微分同胚意义下 (1)-(3) 有**唯一的形式幂级数解**；
  且若 [g] 实解析，该级数收敛、g^+ 存在且 r^2 g^+ 解析到边界。
  n 为偶数时，**存在没有形式幂级数解的共形结构**；把 (2) 弱化为「Ric(g^+)+n g^+ 沿 M 消没到 n-2 阶」后，
  形式解存在并唯一到「消没 n-2 阶的项」与微分同胚。
sources:
  - ref: fefferman-graham-1985
    loc: "THEOREM 2.3，刊页 p.103（Asterisque S131 (1985) 95-116）；条件 1),2) 在 p.102、条件 3) 与式 (2.2) 在 pp.102-103"
    note: "L1 页图（Numdam 扫描件）。配套的 ambient metric 版是同文 THEOREM 2.1，刊页 p.101。"
# status: 该条本身是严格数学定理 -> derivation 的 own status 可写 proven（但见下面三条 gap）
```

`gaps` 必须写清三条（全部来自原文，§41.1.5）：
1. **是形式幂级数的存在唯一性**，收敛性只在 [g] 实解析时断言；
2. **n 偶时有真实障碍**（同文 Proposition 3.5，p.107）；
3. **原文第 V 节只「discuss some of the ingredients」，Theorem 2.1 的完整证明不在文内，Theorem 2.3 没有独立证明节**
   → 若要 `rigorous`/形式化，这是必须补的缺口。

**卡 (2b)：真存在唯一性（只能挂 L0 来源）**

```yaml
kind: proposition
title: Graham--Lee：球上接近标准共形结构者是唯一 Einstein 度规的共形无穷远
statement: |
  S^d 上任何**充分接近标准（圆）共形结构**的共形结构，都是 B_{d+1} 上某个满足负宇宙常数 Einstein 方程、
  在边界有二阶极点的度规的 conformal infinity；该度规在微分同胚意义下**唯一**。
sources:
  - ref: graham-lee-1991
    loc: "全文（未取得，L0）"
    note: |
      ⚠ **本项目未取得正文，任何定理号都不得写**（math-sources.md §41.3.2：
      任务书假设的「Theorem A/B」无证据，且 Lee 本人的 memoir 用的是「[29, Lemma 2.2]」这种分节编号）。
  - ref: witten-1998-ads
    loc: "刊页 p.7（arXiv:hep-th/9802150 v2，PDF p.8）"
    note: "L1。转述最完整：给出「充分接近标准共形结构」「唯一模微分同胚」「线性化 + 隐函数定理」三要素。"
# status: physical-argument 或 conjecture 都不合适——这是**数学定理但本项目未核实**。
# 建议由 curator/auditor 裁决用哪种 status，并在 notes 写明「未核实」而非「未证明」。
```

`notes` 建议写明 Witten 自列的两条限制（§41.3.4）：**局部性可能是本质的**（p.8「probably also necessary」、
p.10「presumably fails」）。

#### (3) 对 `witten-1998-ads.md` 第 345 行那条未解决项的处置

- **Fefferman–Graham 那一半：已结案**（§41.1，L1）。可以把该行改成「已核实，见 math-sources.md §41.1」。
- **Graham–Lee 那一半：确认取不到**（§41.4 十一条路线）。该行应保留，但改写为
  「**已确认无开放获取全文**（OpenAlex `oa_status: closed`）；内容有四条互相一致的二手转述（§41.3.3），
  **编号与逐字仍 L0**。」

#### (4) 两条禁令

7. **不得把「Theorems 2.1 and 2.3」记在 Graham–Lee 名下**——Witten p.18/p.19 引的是 **[44] = Fefferman–Graham**（§41.2.3）。
8. **不得写 `Graham–Lee 1991, Theorem A/B`**（§41.3.2）。

---

### 41.6 遗留问题

- **Q39** **Graham–Lee 1991 正文**（升 L1；确认主定理编号与「充分接近」的确切函数空间/范数）。
  尚未试过的招：纸本馆藏；Elsevier open-archive 的非 `sciencedirect.com` 镜像；
  某篇**逐字引用了它的定理号**的论文（本轮查了 6 篇引用文献，**无一给出内部编号**——这本身像是一个稳定现象）。
- **Q40** **Fefferman–Graham 1985 的刊页 pp.112–116**（第 V 节后半与参考文献）本轮未读，
  用于确认 Problem 5.1 之后是否还有别的编号结果。
- **Q41** **LeBrun, Proc. Roy. Soc. A 380 (1982) 171**（Witten [43]，FG 的 [16]）——
  FG 的 conformal infinity 定义外包给它，且它有 n = 3 的 self-dual 唯一性定理。**本轮未取。**
- **Q42** 本项目是否要给 `fefferman-graham-1985` 的 **Proposition 3.5**（n 偶的障碍张量 / Bach 张量）单独建卡——
  它是「偶维共形反常」在数学侧的对应物，与 witten-1998-ads.md 的 E-W 系列有直接接口。
# § Narain 模空间有限体积 + CY 三折上同调有界（swampland 区的两条数学支点）

## 45. Borel–Harish-Chandra 1962：算术子群有限余体积（researcher，2026-09-11）

### 45.0 需求侧：图里要的是哪一条

`vafa-2005`（本项目已 L1 全文抽取）**全文只引用了一条严格数学定理**：§2, p.4，讲 `T^d` 上环面紧化的 Narain 模空间

```
O(k,k;ℤ) \ O(k,k) / (O(k) × O(k))
```

的体积时，逐字写「which is known to be finite **[3]**」，而 **[3]** 逐字是：

> "A. Borel and Harish-Chandra, "Arithmetic Subgroups of Algebraic Groups," Ann. of Math. **75**, 485 (1962)."

⇒ 这是 **swampland 区目前唯一一条可能通向 `status: rigorous` 的一手数学来源**（`bagger-witten-1983` 那一支上限只有 `physical-argument`，理由见 `extractions/bagger-witten-1983.md` Q3）。

图里要的链条是：

| 环节 | 内容 | 本轮结论 |
|---|---|---|
| (A) | `O(k,k;ℤ)` 是 `O(k,k)` 中的**算术子群** | **本轮无来源（L0）**，见 §45.5 |
| (B) | `O(k,k)` 的单位连通分支是**半单**的（`k ≥ 2`） | **有一条 L3 逐字来源**，见 §45.3 |
| (C) | 半单代数群的算术子群 ⇒ 商有**有限不变体积** | **= Borel–Harish-Chandra 的定理**；内容 L3，**编号 L0** |
| (D) | 该商就是 Narain 模空间 | **本轮无数学侧来源**；`vafa-2005` 只给物理侧陈述 |

⇒ **只把 Borel–Harish-Chandra 登记进 bib，并不能让这个节点变成 `rigorous`。** 四个环节里只有 (C) 有像样的证据，且**连它的定理编号都没拿到**。

### 45.1 ★ 结论表（先看这张）

| 项 | 任务书的猜测 | 本轮核实结果 | 可否写进 `loc` |
|---|---|---|---|
| 篇级元数据 | Ann. Math. 75, 485 | **L2 确认**：Crossref `10.2307/1970210` → title "Arithmetic Subgroups of Algebraic Groups"，container "The Annals of Mathematics"，volume **75**，page **485**，year **1962**，publisher JSTOR，ISSN 0003-486X，作者 Armand Borel + Harish-Chandra | **可以写「Ann. of Math. 75 (1962) 485」** |
| **终页 535** | bib 里标 L0 | **仍未核实**：Crossref 只给 `page: "485"`，**没有页范围** | **不要写 535**，或标「终页未核实」 |
| **定理号 "Theorem 9.4"** | 任务书打了问号 | **★ 未能核实（L0）。两条独立的、亲自读到的引用方都不给编号**（§45.2、§45.3） | **★ 硬禁令：不得写 "Theorem 9.4"** |
| 定理**内容** | 算术子群有限余体积 | **有 L3 逐字来源**（§45.3） | 可写内容，但 source 要指向引用方或标 L3 |
| 转引：Borel, *Introduction aux groupes arithmétiques*, § | 任务书点名 | **本轮 0 次调用，L0** | 不可 |
| 转引：Platonov–Rapinchuk, Thm 4.13 | 任务书点名 | **本轮 0 次调用，L0** | 不可 |

### 45.2 获取失败路径（逐条留痕）

| 路线 | URL / 手法 | 结果 |
|---|---|---|
| **Semantic Scholar 引用上下文** | `api.semanticscholar.org/graph/v1/paper/DOI:10.2307/1970210/citations?fields=title,year,contexts&limit=80` | **HTTP 404** ⇒ S2 **不索引这个 DOI**（对比：同一 session 内对 `10.1016/0550-3213(83)90605-3` 与 `10.1016/0550-3213(85)90592-9` 的同一端点都成功返回）。**这是本轮最想要的路线，直接死掉** |
| S2 标题检索（想换个 id 再试） | `api.semanticscholar.org/graph/v1/paper/search?query=…` | **HTTP 429，两次**（与既有记录一致：S2 的 `/search` 端点不可靠，`DOI:` 前缀才稳） |
| **Crossref** | `api.crossref.org/works/10.2307/1970210` | **成功**，给了 §45.1 表里那批字段。**但没有页范围、没有摘要、没有目录** |
| JSTOR 正文 | — | **未尝试**（既有记录判死路） |
| Dave Witte Morris, *Introduction to Arithmetic Groups*（其 Notes 通常给精确出处） | `ar5iv.labs.arxiv.org/html/math/0106063` | **`maxContentLength size of 10485760 exceeded`** ⇒ 该书 ar5iv 渲染超出 WebFetch 10 MB 上限。**下一轮改走 `arxiv.org/pdf/math/0106063v1`（早期短版本）+ `Read(pages=)`** |
| `WebSearch` | — | **本轮无法执行**：会话额度已耗尽（200/200） |

### 45.3 ★★ 本轮拿到的最有用的一条（L3）：物理侧的逐字引用，**且正是 Narain 语境**

**来源**：Afkhami-Jeddi 等, *Free partition functions and an averaged holographic duality*, **arXiv:2006.04839**，**§4「Averaging over Narain lattices」**；该文把 Borel–Harish-Chandra 编为参考文献 **[57]**。
（抽取者亲自读到该文的 ar5iv HTML —— **L3，内容一手，编号二手**。）

逐字（节录）：

> "This finiteness can be checked directly by building a fundamental domain; it is also a special case of the theorem of Borel and Harish-Chandra **[57]**"

被归属的内容，逐字：

> "that an arithmetic subgroup of a semisimple algebraic group has a finite volume quotient"

配套条件，逐字：

> "the identity component of `O(c,c)` is semisimple iff `c ≥ 2`"

**★ 四条对图直接有用的结论：**

1. **这条引用的语境与 `vafa-2005` §2 完全一致**（Narain 模空间 `O(c,c)` 的商的有限体积），是本轮找到的**最贴切的转引**。
2. **它给出了 `vafa-2005` 没有给的限制条件：`c ≥ 2`。** Vafa 写的是一般的 `T^d`，**没有说 `d = 1` 要单独处理**。
   ⇒ **图节点的 statement 必须带 `k ≥ 2`**，否则会把一条对 `k = 1` 不成立（`O(1,1)` 的单位连通分支不是半单）的陈述写成普遍成立。**这是本轮对 `vafa-2005` E9 的一处实质补正。**
3. **它明确指出还有第二条独立路线**：「can be checked directly by building a fundamental domain」。
   ⇒ 图里这个节点可以挂**两条推导**：`--via-borel-harish-chandra`（一般定理）与 `--via-explicit-fundamental-domain`（直接构造）。**后者对 Narain 情形可能比前者更容易做到 `rigorous`，值得单列。**
4. **该文不给 Borel–Harish-Chandra 的定理编号**，且抽取者专门核对：**同一篇里对 Siegel 的引用是给编号的**（逐字对照："Theorem 8"、"Theorem 12" from his lecture notes）。
   ⇒ **「不给编号」在这篇里是有意的选择，不是疏忽** ⇒ **这条负面证据比一般的"没找到"更强。**

### 45.4 第二条独立引用（L3）：**同样不给编号**，且**内容不同**

**来源**：*Multi-Qubit Golden Gates*, **arXiv:2509.09047**；Borel–Harish-Chandra 是其参考文献 **[13]**。
（抽取者亲自读到 arXiv 原生 HTML —— **L3**。）

逐字（两处）：

> （Lemma 2.2.1 的证明中）"By Borel–Harish-Chandra theory **[13]**, we get that any finite arithmetic subgroup of `G` is a **cocompact lattice**"
>
> （§2.3）"By **[13]**, `G(F)` is a **cocompact lattice** of `G(𝔸)`"

**★ 三条注意事项：**

1. **同样不给定理编号。** 两条独立引用都不给 ⇒ **「Theorem 9.4」这个编号在本轮的证据里完全没有支持。**
2. ⚠ **这一篇引的是 `cocompact`（余紧），不是 `finite volume`（有限体积）。** 二者**不是同一条定理**：Borel–Harish-Chandra 那篇里**有限体积判据与余紧判据是分开的两条**（前者对应「无 `ℚ`-有理特征标」，后者还要求「`ℚ`-各向异性 / 无非平凡幂幺元」）。
   ⇒ **图里绝不能把这两条混成一条。** Narain 模空间要的是**有限体积**那一条（Narain 商**不是**紧的），**§45.3 的引用才是对的那一条。**
3. ⇒ **这条 L3 的价值不是支撑内容，而是佐证「引用方普遍不给编号」这一负面结论。**

### 45.5 环节 (A) 与 (D)：本轮完全空白

- **(A)「`O(k,k;ℤ)` 是算术子群」**：`vafa-2005` 直接写出这个陪集就往下走，**不论证**。数学侧要一条「整点子群是算术子群」的标准陈述（通常是定义的直接推论，但**图里仍需一个来源**）。
- **(D)「Narain 模空间 = 那个双陪集」**：这是**物理侧的构造**（Narain 1986；Narain–Sarmadi–Witten 1987），本项目**尚未登记这两篇**。
  ⚠ 巧合：`sen-1995-bh` 的参考文献 [21] 逐字给出了这两篇的完整书目（见 `extractions/sen-1995-bh.md` E15），**可以直接抄进 bib**。

### 45.6 图里建议怎么加（供 curator 取舍；researcher 不改 `graph/`）

**建议的节点**（图中目前**没有任何** swampland 或 Narain 节点，全部是新建）：

| 建议 id | kind | status | 内容 | loc | 依据 |
|---|---|---|---|---|---|
| `math.arithmetic-subgroup-finite-covolume` | proposition | **`rigorous`**（候选，见下方警告） | 半单代数群的算术子群，其商有有限不变体积 | **`Ann. of Math. 75 (1962) 485`（篇级；⚠ 不写定理号）** | §45.3 |
| `swampland.narain-moduli-space-finite-volume` | proposition | `physical-argument` 或 `rigorous`（取决于 (A)(D) 是否补上） | `O(k,k;ℤ)\O(k,k)/(O(k)×O(k))` 有有限体积，**`k ≥ 2`** | `vafa-2005, §2, p.4`（物理侧）+ 上一条 | §45.0、§45.3 |

**★ `loc` 的建议写法（供 curator 直接抄）：**

```yaml
# math.arithmetic-subgroup-finite-covolume
sources:
  - ref: borel-harish-chandra-1962
    loc: "Ann. of Math. 75 (1962) 485"     # ⚠ 篇级。正文未获取，定理号未核实，不得写 "Theorem 9.4"
    note: >
      正文未获取（L0）。内容依据两条独立的一手转引：
      arXiv:2006.04839 §4（Narain 语境，逐字 "an arithmetic subgroup of a semisimple
      algebraic group has a finite volume quotient"，其 ref [57]）；
      arXiv:2509.09047（其 ref [13]，但引的是 cocompact 那一支，不是本条）。
      两条转引都不给定理编号。详见 literature/extractions/math-sources.md §45。

# swampland.narain-moduli-space-finite-volume
sources:
  - ref: vafa-2005
    loc: "§2, p.4（v2；无公式号）"
    note: '逐字 "which is known to be finite [3]"'
depends_on:
  - math.arithmetic-subgroup-finite-covolume            # inferred: true（见下）
```

**★ 三条硬性提示（curator 必读）：**

1. **`k ≥ 2` 必须写进 statement。** `vafa-2005` 没有这个限制，§45.3 的来源有。**这是本轮对 Vafa 那条陈述的实质补正。**
2. **`depends_on` 那条边必须 `inferred: true`**，理由：环节 (A)（`O(k,k;ℤ)` 是算术子群）与 (D)（该双陪集就是 Narain 模空间）**本轮都没有来源**（§45.5）。
3. **建议同时建第二条推导 `--via-explicit-fundamental-domain`**（§45.3 结论 3）：对 Narain 情形直接构造基本域，**不经过一般定理**。这条路线的 `status` 有可能真的到 `rigorous`，而且**不需要 (A)**。

**★ 三条禁令：**

- **不得写 `Theorem 9.4`**（§45.1、§45.4）。
- **不得把「有限体积」与「余紧」混用**（§45.4 注意事项 2）。Narain 商不紧。
- **不得因为「Vafa 引了它」就把 `swampland.moduli-volume-finite`（一般的体积猜想）升格**。`vafa-2005.md` §5.2 已经写过这条红线：`T^d` 那一支必须单独建卡。

### 45.7 未解决 / 留给下一轮

- **Q45.1 ★ 定理编号。** 最省力的下一招：`arxiv.org/pdf/math/0106063v1` + `Read(pages=)`（Morris 的书早期版本较短），或者**先用 `WebSearch` 搜 `"Borel" "Harish-Chandra" "Theorem 9.4"`**（本轮无额度）。
- **Q45.2 终页**（Crossref 只给 485）。JSTOR 页面、AMS/Annals 目录、或 MathSciNet 均未试。
- **Q45.3 Platonov–Rapinchuk Thm 4.13 与 Borel 的法文书的节号** —— 本轮 0 次调用。**注意既有教训：Google Books 页码只能当一致性检查，不能当定位。**
- **Q45.4 环节 (A) 与 (D) 的来源**（§45.5）。(D) 的入口已知：Narain 1986 PLB 169, 41；Narain–Sarmadi–Witten 1987 NPB 279, 369（书目已由 `sen-1995-bh` [21] L1 抄得）。
- **Q45.5** `O(k,k)` 单位连通分支半单性对 `k = 1` 失效这一点，是否影响 `vafa-2005` 的其他陈述（他的 `T^d` 例子里 `d` 可否为 1）。

---

## 46. `math.cy3-cohomology-bounded`：CY 三折上同调是否一致有界（researcher，2026-09-11）

### 46.0 需求侧：这条卡片到底在问什么

`vafa-2005` §3, p.5（**L1 逐字**，见 `extractions/vafa-2005.md` E12）：

> "… For example, we do not know of a sequence of Calabi-Yau threefolds for which the dimension of cohomologies can get unboundedly large. **It is not known if this is actually a true mathematical fact, but experience with various examples in string theory gives one a strong feeling that this is going to be finite.**"

⇒ 图卡 `math.cy3-cohomology-bounded`：**CY 三折的上同调维数是否一致有界**。
`vafa-2005.md` §5.2 已建议它进 `math` area、`status: conjecture`，note 写「2005 年之后的进展未查（U6）」。**本节就是补这个 U6。**

### 46.1 ★★ 结论表（先看这张）

| 命题 | 2026-09 的状态 | 证据等级 |
|---|---|---|
| **CY 三折的拓扑类型数目有限**（⇔ 上同调维数一致有界的最强形式） | **仍然开放（open）** | **L3 逐字**（§46.2） |
| **椭圆纤维化 / 亏格一纤维化 CY 三折的拓扑类型数目有限** | **已被证明** | **L3 逐字 + L2 书目**（§46.3） |
| 对椭圆纤维化 CY 三折，**`h^{1,1}(X) ≤ 491`** | **已被证明**（作为一条带编号的推论） | **L3 逐字**（§46.4） |
| Kreuzer–Skarke 列表里 **`h^{1,1}` 的最大值是 491** | **确认** | **L3，四条独立摘要**（§46.5） |
| Kreuzer–Skarke 列表里 **`h^{1,1}+h^{2,1} ≤ 502`**（任务书给的数） | **★ 本轮未能核实（L0）** | —（§46.5） |
| Kreuzer–Skarke 反射多面体总数 **473,800,776**；不同 Hodge 数对 **30,108** | **确认** | **L2 逐字摘要**（§46.5） |

⇒ **图卡 `math.cy3-cohomology-bounded` 应保持 `status: conjecture`，但 `notes` 必须更新**：**一般情形仍开放，纤维化情形已解决，且已有显式数值上界 491。** 详见 §46.6。

### 46.2 ★★ 「一般情形仍开放」的一手转引（L3）

**来源**：L. Anderson, J. Gray, R. Nally, W. Taylor, *An elliptic approach to Reid's fantasy*, **arXiv:2606.08427v1**（2026-06-07；无期刊号、无 DOI），**§I（Introduction）**。
（抽取者亲自读到 arXiv 原生 HTML —— **L3**。）

逐字（节录）：

> "it is not yet known whether the number of distinct topological types of Calabi-Yau threefolds is finite or infinite"

**★ 两条注意：**

1. ⚠ **该文并未把这个问题归给 Yau，也没有归给 Reid。** 抽取者专门核对：**"Reid's fantasy" 是另一条猜想**（关于连通性，不是关于有限性），逐字：
   > "Reid's fantasy … conjectures that all Calabi-Yau threefolds … are connected to one another through various geometric transitions"
   归给其参考文献 **[1] = M. Reid (1987)**。
   ⇒ **图节点的 `notes` 里不要写「这是 Yau 猜想」或「这是 Reid 猜想」**（任务书里那个「Reid 猜想/Yau 猜想」的等同是**未经证实的**）。写「有限性问题，2026 年仍开放，见 arXiv:2606.08427 §I」。
2. **该文日期是 2026-06-07，距本轮读取（2026-09-11）三个月** ⇒ **这是目前能拿到的、最新的「仍开放」证据。**

### 46.3 「纤维化情形已解决」：四条来源，其中一条已发表

**来源同上（arXiv:2606.08427v1 §I），逐字**：

> "the number of topological types of elliptic and genus one fibered Calabi-Yau threefolds is finite **[8, 9, 10, 11]**"

该文列出的四条参考文献（**L3，由引用方抄下**）：

| 编号 | 条目 | 本轮独立核实 |
|---|---|---|
| [8] | A. Grassi, *Math. Ann.* **290**, 287 (1991) | **未核实（L0）** |
| [9] | M. Gross, *Duke Math. J.* **76**, 271 (1994) | ⚠ **与 Crossref 冲突**，见下 |
| [10] | Y. Kawamata, arXiv:**alg-geom/9701006** (1997) | **未核实（L0）** |
| [11] | Filipazzi, Hacon, Svaldi, *J. Eur. Math. Soc.* (2024) | **已 L2 核实**，见下 |

**⚠ [9] 的卷号冲突（本轮发现的一处溯源矛盾）：**

- **Crossref（出版方元数据，L2）**：`api.crossref.org/works/10.1215/S0012-7094-94-07414-0` → title "A finiteness theorem for elliptic Calabi-Yau threefolds"，container "Duke Mathematical Journal"，**volume 74**，year 1994，author Mark Gross。
- **arXiv:2606.08427v1 的参考文献 [9]（L3）**：**volume 76**。

⇒ **以 Crossref 为准（出版方元数据 > 引用方转抄）：Duke Math. J. 74 (1994)。** 但**页码 Crossref 未给**（`page` 字段缺失）。
**记下这条**：这是本项目第 N 次遇到"引用方把卷号抄错"，与 `green-schwarz-1984` 的年份问题同型。

**[11] 的完整 L2 元数据（本轮由 arXiv API 逐字取得）：**

> arXiv **2112.01352v2**；title "Boundedness of elliptic Calabi-Yau threefolds"；
> authors **Stefano Filipazzi, Christopher D. Hacon, Roberto Svaldi**；
> published 2021-12-02，updated **2024-03-27**；
> journal_ref **"J. Eur. Math. Soc. 27 (2025), no. 9, 3583-3650"**；DOI **10.4171/JEMS/1467**；
> categories math.AG + hep-th；comment "Final version, to appear in J. Eur. Math. Soc. (JEMS)"。

其摘要逐字（片段）：

> "We show that elliptic Calabi--Yau threefolds form a bounded family."
> "We also show that the same result holds for minimal terminal threefolds of Kodaira"
> "upon fixing the rate of growth of pluricanonical forms and the degree of a"
> "Both of these hypotheses are necessary to prove the boundedness of such a family."

⚠ **注意最后一句**：第二个结论**带两个必需的额外假设**。**引用时不要把第二个结论说成无条件的。**

### 46.4 ★★ 最有用的一条：**带编号的显式数值上界**（L3）

**来源**：A. Grassi, *Spectrum bounds in geometry*, **arXiv:2304.07819v2**（2023-04-16，updated 2023-07-27；无期刊号、无 DOI），**§5**。
（抽取者亲自读到 arXiv 原生 HTML —— **L3**。）

逐字（三处）：

> **Proposition 5.1**（归属其参考文献 **[29] = W. Taylor**）："then `CxDef(X) ≤ 491`"
>
> **Corollary 5.2**（作者本人在 Prop 5.1 上的推论）："Then `CxDef(X) ≤ 491`"
>
> **Corollary 5.3**："Then `h^{1,1}(X) ≤ 491`."

同文逐字（对 §46.3 的独立佐证）：

> "there are only finitely many types of topologically different elliptically fibered Calabi-Yau threefolds"（归给其 **[6] = Filipazzi–Hacon–Svaldi**）

**★ 四条注意：**

1. **`Corollary 5.3` 给的是 `h^{1,1}(X) ≤ 491`** —— 这是本轮找到的**唯一一条带编号、可精确引用的 CY3 上同调数值上界**。
2. **`CxDef(X)` 与 `h^{2,1}` 的关系**：该文 Definition 3.2 里 `H_unch = CxDef(X) + 1`，而 `H_unch = h^{2,1}(X) + 1` ⇒ **`CxDef(X) = h^{2,1}(X)`**，故 Prop 5.1 / Cor 5.2 实际上是 `h^{2,1}(X) ≤ 491` 的界。
   ⚠ **但这一步是抽取者从被引句拼出来的，`Definition 3.2` 的原文未逐字取到** ⇒ **标 L0，curator 引用须 `inferred: true`。**
3. ⚠ **这些界只对椭圆纤维化 CY3 成立**，不是对一般 CY3。**这正是 §46.1 表里「一般情形仍开放」与「纤维化情形已解决」的分界。**
4. ⚠ **该文没有提 Kreuzer–Skarke**（抽取者专门核对：全文未出现该列表或其最大 Hodge 数）。**所以「491」在这里与在 §46.5 里是两个不同来源的同一个数字**——这个巧合本身值得注意（Taylor 的 491 与 KS 的 491 是否同源，本轮未查）。

### 46.5 Kreuzer–Skarke 数据：确认了什么，**没**确认什么

**一手摘要（L2 逐字，分段拼接）** —— M. Kreuzer, H. Skarke, **arXiv:hep-th/0002240**：

> "Four dimensional reflexive polyhedra encode the data for smooth Calabi-Yau threefolds that are hypersurfaces in toric varieties, and have important applications both in perturbative and in non-perturbative string theory. We describe how we obtained all **473,800,776** reflexive polyhedra that exist in four dimensions and the **30,108** distinct pairs of Hodge numbers of the resulting Calabi-Yau manifolds. As a by-product we show that all these spaces (and hence the corresponding string vacua) are connected via a chain of singular transitions."

**★ 对 `h^{1,1}` 最大值 = 491 的四条独立佐证（L3，全部是 arXiv 摘要逐字片段）：**

| arXiv id | 标题 | 逐字片段 |
|---|---|---|
| **2008.01730v1** | Bounding the Kreuzer-Skarke Landscape | "the extremal case `h^{1,1}=491`" |
| **1808.01282v1** | The Kreuzer-Skarke Axiverse | "including all polytopes with `240 ≤ h^{1,1} ≤ 491`" |
| **2309.13145v3** | Glimmers from the Axiverse | "up to the maximum Hodge number `h^{1,1}=491`" |
| **2405.08871v4** | The DNA of Calabi-Yau Hypersurfaces | "the maximal polytope with Hodge numbers `h^{1,1} = 491`" |

⇒ **`h^{1,1}` 的最大值 491 是安全的**（四条独立来源，其中两条用 "maximum"/"maximal" 字样）。

**★ 但任务书给的 `h^{1,1}+h^{2,1} ≤ 502` 本轮未能核实（L0）：**

- Kreuzer–Skarke 原文摘要**没有**这个数。
- 抽取者读了 `ar5iv.labs.arxiv.org/html/hep-th/0002240` 的正文：**"491"、"502"、"11" 三个数字全篇未出现**；§4（Results）里给的是 Hodge 图的**稠密区**边界，逐字：
  > "a large region, roughly bounded by `h₁₁ ≥ 15`, `h₁₂ ≥ 15` and `h₁₁ + h₁₂ ≤ 175`"
  以及低端的孤立点：`{21,1}`、`{20,5}`、`{19,7}`、`{29,2}`（"the only ones with `h₁₁+h₁₂ < 28`"）。
  **这些都不是全局最大值。**
- 对上述四篇的摘要检索：**没有一条摘要含 502。**
- `hep.itp.tuwien.ac.at/~kreuzer/CY/`（Kreuzer 的 CY 数据主页）：只写 "The 473,800,776 reflexive polyhedra with point, vertex and Hodge numbers"，**不给极值。**

⇒ **禁令：图里不得写 `h^{1,1}+h^{2,1} ≤ 502`。** 若一定要用，须先从一手来源核实（最可能的位置：KS 那篇的 Hodge 数表/图注，或某篇专门做 KS 统计的论文的正文）。
⇒ **可以安全写的是 `h^{1,1} ≤ 491`（对 KS 超曲面）**，并注明来源是四条二手摘要。

### 46.6 图里建议怎么加（供 curator 取舍；researcher 不改 `graph/`）

**（a）`math.cy3-cohomology-bounded` 保持 `status: conjecture`，但拆成三层**

| 建议 id | kind | status | 内容 | 来源 |
|---|---|---|---|---|
| `math.cy3-topological-types-finite` | proposition | **`conjecture`** | CY 三折的拓扑类型数目有限（⇒ 上同调维数一致有界） | `vafa-2005 §3 p.5`（物理侧陈述）+ **arXiv:2606.08427 §I**（2026 年仍开放的证据） |
| `math.elliptic-cy3-bounded` | proposition | **`rigorous`**（候选，须 reviewer 复核） | 椭圆/亏格一纤维化 CY 三折构成有界族 ⇒ 拓扑类型有限 | **arXiv:2112.01352 = JEMS 27 (2025) 3583–3650**（已发表）；另 Grassi 1991、Gross 1994、Kawamata 1997 |
| `math.elliptic-cy3-h11-bound-491` | proposition | **`rigorous`**（候选） | 椭圆纤维化 CY3：`h^{1,1}(X) ≤ 491` | **arXiv:2304.07819v2, Corollary 5.3** |

```
math.cy3-topological-types-finite               status: conjecture
  --via-string-examples          kind: conjecture-support   status: conjecture
      sources: vafa-2005, loc "§3, p.5（v2；无公式号）"
      summary: 逐字「we do not know of a sequence of Calabi-Yau threefolds for which
               the dimension of cohomologies can get unboundedly large」
      gaps: ["原文自陈 It is not known if this is actually a true mathematical fact",
             "截至 2026-06（arXiv:2606.08427 §I）一般情形仍开放"]

  --via-fibered-case             kind: conjecture-support   status: rigorous（仅覆盖纤维化子类）
      depends_on: math.elliptic-cy3-bounded
      ⚠ 这条边**不得**让 math.cy3-topological-types-finite 升格：
        它只覆盖椭圆/亏格一纤维化的子类，一般情形仍开放。
        建议 curator 明确把它建成「部分结果」而非「支持性证据」，
        或干脆不建边，只在 notes 里记。
```

**（b）`notes` 必须写进去的四句（供 curator 直接抄）**

1. 「一般 CY 三折拓扑类型有限性**截至 2026-06 仍开放**（arXiv:2606.08427 §I 逐字）。」
2. 「**不要**把它称作 Yau 猜想或 Reid 猜想：arXiv:2606.08427 明确把 Reid's fantasy 区分为另一条（关于连通性的）猜想。」
3. 「椭圆/亏格一纤维化情形**已证明**：Filipazzi–Hacon–Svaldi, JEMS 27 (2025) 3583–3650 = arXiv:2112.01352。」
4. 「Kreuzer–Skarke 超曲面的 `h^{1,1}` 最大值为 **491**（四条二手摘要）；**`h^{1,1}+h^{2,1} ≤ 502` 本项目未核实，不得写入。**」

**（c）三条禁令**

- **不得写 `h^{1,1}+h^{2,1} ≤ 502`**（§46.5）。
- **不得把 Gross 1994 写成 Duke **76**** —— 出版方元数据是 **74**（§46.3）。
- **不得用「纤维化情形已解决」去把一般情形的 `status` 抬高**（§46.6(a) 的警告）。

### 46.7 未解决 / 留给下一轮

- **Q46.1 ★ `h^{1,1}+h^{2,1} ≤ 502` 的一手出处。** 最可能的位置：KS 那篇的 Hodge 数图注、或 `2008.01730`（Bounding the Kreuzer-Skarke Landscape）正文。**该篇标题就叫"Bounding"，是最有希望的一枪。**
- **Q46.2** Grassi *Spectrum bounds in geometry*（2304.07819v2）的 **Definition 3.2**（`CxDef` 与 `h^{2,1}` 的关系）逐字未取到（§46.4 注 2）。取到就能把 `h^{2,1} ≤ 491` 也变成可引条目。
- **Q46.3** Grassi 的 `Proposition 5.1` 归属的 **[29] = W. Taylor** 具体是哪一篇（本轮只知作者姓）。这是 491 这个数的真正源头。
- **Q46.4** Gross 1994 的**页码**（Crossref 缺 `page` 字段）；Grassi 1991 *Math. Ann.* 290, 287 与 Kawamata alg-geom/9701006 **完全未核实**。
- **Q46.5** KS 的 491 与 Taylor 的 491 是否同源（§46.4 注 4）。若同源，则「KS 列表的极值恰好饱和椭圆纤维化的理论上界」是一条很强的结构性事实，值得单独建卡。
- **Q46.6** 本节全部证据都是 L2/L3。**四篇数学论文（Grassi 1991、Gross 1994、Kawamata 1997、FHS 2021）一篇正文都没读。** FHS 有 arXiv（`2112.01352`），**升到 L1 的成本最低**。

---

## 47. `math.even-self-dual-euclidean-lattices-dimension-16`：偶自对偶格的维数 ≡ 0 mod 8，且 16 维恰有两个（researcher，2026-09-11）

> **本节状态：已完成**（2026-09-11，researcher；skeleton 先落盘，之后逐条追加）。
> 目标：为杂化弦"规范群恰有两个（`Spin(32)/Z₂` 与 `E₈×E₈`）"这条路线的**数学前提**找带编号来源，
> 使 `math.even-self-dual-euclidean-lattices-dimension-16` 能从 `physical-argument` 升到 `rigorous`。
> **结果：(A)(B) 各拿到一条 L1 带编号来源（§47.1 表），但任务书点名的四本教科书正文一本都没取到（§47.4）。**

### 47.0 需求侧：要两条不同的定理，绝不能合成一条

图卡 `math.even-self-dual-euclidean-lattices-dimension-16` 的文字里其实压着**两条独立的数学命题**，
它们的证明手段、原始文献、可获得性完全不同：

| | 陈述 | 证明手段 | 谁给 |
|---|---|---|---|
| **(A)** | 正定（欧氏）偶自对偶格的秩 `n` 必被 8 整除 | 模形式（θ 级数权 n/2 在 Γ₁ 上）或纯代数 | **有干净的带编号来源**（§47.2） |
| **(B)** | `n = 16` 时恰有两个等价类：`Γ₈ ⊕ Γ₈` 与 `Γ₁₆`（= `D₁₆⁺`） | Kneser 邻居法 / Minkowski–Siegel 质量公式 / 手工枚举 | **难得多**（§47.3 起） |

⚠ **(A) 不蕴涵 (B)，(B) 也不是 (A) 的"n=16 特例"。** 杂化弦"规范群恰有两个"这条路线**两条都要**。
⚠ 还有第三条**不属于本节**、且仍是 `physical-argument` 的桥：
「一致的 16 维内部 CFT（模不变 + 幺正）⟺ 偶自对偶欧氏格」。本节**不碰**它，见 §47.6。

**术语陷阱（本节全程要盯）**：数学文献里主流说法是 **"even unimodular"**（偶幺模），
物理文献里主流说法是 **"even self-dual"**（偶自对偶）。对**正定整格**这两者是同一件事
（`L = L*` ⟺ `det = 1` ⟺ unimodular），但**在不定号差下**物理书常用的 "self-dual" 也仍指 `L = L*`。
⇒ 抄编号时必须记原文用的是哪个词；curator 建卡时要在 `notes` 里写明两词等同的条件。
另一个记号陷阱：`Γ₁₆`、`Λ₁₆`、`D₁₆⁺`、`II₁₆,₀`、`E₈²` 在不同书里指同一批对象但字母不同（§47.2、§47.5）。

### 47.1 ★★ 结论表（先看这张）

| 命题 | 最佳可引来源 | 编号（逐字） | 证据等级 | 建议 status |
|---|---|---|---|---|
| **(A)** 正定偶幺模格的秩 `n ≡ 0 mod 8` | Zagier, *The 1-2-3 of Modular Forms* 第一篇, **p. 33** | **`Proposition 12`**，第 **(i)** 条 | **L1 页图** | **`rigorous`** |
| **(B)** 16 维恰两类：`D₁₆⁺` 与 `E₈ ⊕ E₈`，**且两者不同构** | Chenevier–Lannes, arXiv:1409.7616, ch. II §3, **p. 35** | **`Corollaire 3.6`** | **L1 页图** | **`rigorous`** |
| (B′) 8 维唯一：`E₈` | 同上，**p. 34** | **`Corollaire 3.5`** | L1 页图 | `rigorous` |
| (C) 24 维恰 24 类 | 同上，**p. 41** | **`Théorème 3.13`** | L1 页图 | `rigorous` |
| 归属：8 维 Mordell / 16 维 Witt / 24 维 Niemeier | 同上，**p. 33** | 无编号（散文句） | L1 逐字 | —（只入 `notes`） |
| **「Witt 1941 这篇文章证明了 (B)」** | — | — | **L0，且本轮拿到反向线索** | ⛔ **不得写** |
| Serre *A Course in Arithmetic* Ch. V 的定理号 | — | — | **L0**（章定位 pp. 48–58 是 L2） | ⛔ 只可引到章 |
| Milnor–Husemoller Ch. II 的定理号 | — | — | **L0**（章定位 pp. 15–55 是 L2） | ⛔ 只可引到章 |
| SPLAG "Table 16.7" | — | — | **L0**（Ch. 16 = pp. 406–420，三版一致，L2） | ⛔ 只可引到章 |
| Ebeling 的定理号（Ch. 2 还是 Ch. 3 都未定） | — | — | **L0**（章标题 + 三版页码是 L2） | ⛔ 只可引到章+版次 |
| 「一致的 16 维内部 CFT ⟺ 偶自对偶欧氏格」 | Polchinski v2 §11.6 (11.6.4a,b)（已有 L1 抽取 E63） | 有式号 | L1 | **`physical-argument`（本节不动）** |

**一句话结论**：**(A) 与 (B) 都能升 `rigorous`，但不是靠任务书点名的那四本教科书**——
四本书的正文本轮一本都没打开；真正拿到编号与证明的是
**Zagier 的模形式讲义（(A)）** 和 **Chenevier–Lannes 的 arXiv 专著（(B)，带完整证明）**。
⚠ **但杂化弦"规范群恰有两个"整体不会因此变严格**：瓶颈是那条仍为 `physical-argument`
的「一致 CFT ⟺ 偶自对偶格」桥，见 §47.6(b)。

### 47.2 ★★ (A) 已核实、可直接引用：Zagier, *Elliptic Modular Forms and Their Applications*, **Proposition 12(i)**（L1 页图）

**书目**：D. Zagier, "Elliptic Modular Forms and Their Applications", in K. Ranestad (ed.),
*The 1-2-3 of Modular Forms*（Universitext, Springer, 2008），pp. 1–103。
**获取路线（可复现）**：作者本人 MPIM 主页上的**出版社排版 PDF**
`https://people.mpim-bonn.mpg.de/zagier/files/doi/10.1007/978-3-540-74119-0_1/fulltext.pdf`
（1.2 MB；WebFetch 落盘后 `Read(pages=)` 读页图。**PDF 页码 = 书页码**，首页即 p.1）。
这是作者自建页上的合法一手件，不是盗版扫描。

**位置**：§3.2 "Theta Series in Many Variables" 下的小节 **"♠ Invariants of Even Unimodular Lattices"**，
命题在**书上 p. 33**，证明跨 p. 33–34。

**逐字（L1，照抄页图）**：

> **Proposition 12.** *Let `Q : ℤ^m → ℤ` be a positive definite even unimodular quadratic form in m variables. Then*
> *(i) the rank m is divisible by 8, and*
> *(ii) the number of representations of `n ∈ ℕ` by Q is given for large n by the formula*
>
> `R_Q(n) = − (2k/B_k) σ_{k−1}(n) + O(n^{k/2})   (n → ∞),`  (38)
>
> *where `m = 2k` and `B_k` denotes the kth Bernoulli number.*

⇒ **图里要的 (A) 就是 Proposition 12 的第 (i) 条。** 它是**带编号、带证明、公开可取**的，
而且假设写得正好对口：**positive definite**（= 欧氏）+ **even** + **unimodular**。

**证明的依赖（原文自己列出的，L1）**：
- "By the theorem above, the theta series `Θ_Q` is a modular form of weight k on the full modular group `Γ₁ = SL(2,ℤ)`"
  —— 这里的 "the theorem above" 是**同页前面的 `Theorem (Hecke, Schoenberg)`（书上 p. 32，无编号，只有人名）**。
- "By the results of Section 2, this modular form is a linear combination of `𝔾_k(z)` and a cusp form of weight k"
- "Now Proposition 8 implies the asymptotic formula (38)"
- 降到 `m ≡ 4 (mod 8)` 的技巧原文逐字：
  > "For the first part it is enough to show that m cannot be an odd multiple of 4, since if m is either odd or twice an odd number then 4m or 2m is an odd multiple of 4 and we can apply this special case to the quadratic form `Q ⊕ Q ⊕ Q ⊕ Q` or `Q ⊕ Q`, respectively."
  ⚠ 末句"如果 `k ≡ 2 (mod 4)` 则 `B_k > 0`，(38) 右边趋于 −∞，与 `R_Q(n) ≥ 0` 矛盾"里的**极限变量**
  我在页图上读成 `k → ∞`，但按数学内容应是 `n → ∞`。**这一句不要照抄，可能是我的读图误差或原书误印。**

**★ 作者自己给出的强度措辞（对 status 判定很要紧，L1 逐字，书上 p. 34）**：

> "The first statement of Proposition 12 is purely algebraic, and purely algebraic proofs are known, but they are not as simple or as elegant as the modular proof just given. No non-modular proof of the asymptotic formula (38) is known."

⇒ **(A) 是 `rigorous`，且原文明说存在纯代数证明**（即不必把整条模形式机器拖进依赖图；
若 curator 想要一条不依赖 Hecke–Schoenberg 的推导，Serre / Milnor–Husemoller 那条纯代数路线才是对的，见 §47.4）。

**同一节里对 (B) 的陈述：有，但没有编号、也没有引文（L1 逐字，书上 p. 34）**：

> "However, in rank 16 one knows that there are two non-equivalent lattices: the direct sum `Λ₈ ⊕ Λ₈` and a second lattice `Λ₁₆` which is not decomposable. Since the theta series of both lattices are modular forms of weight 8 on the full modular group with Fourier expansions beginning with 1, they are both equal to the Eisenstein series `E₈(z)`, so we have `r_{Λ₈⊕Λ₈}(n) = r_{Λ₁₆}(n) = 480 σ₇(n)` for all `n ≥ 1`, even though the two lattices in question are distinct."

以及**书上 p. 36**（"♠ Drums Whose Shape One Cannot Hear" 小节，讲 Milnor 的等谱环面）：

> "As we already mentioned, there are two non-isomorphic even unimodular lattices `Λ₁ = Γ₈ ⊕ Γ₈` and `Λ₂ = Γ₁₆` in dimension 16."

**★ 三条必须记下的注意事项：**

1. ⚠ **"one knows that" 是转述，不是本书证明的。** Zagier 对 (B) **不给编号、不给证明、正文里也不给参考文献**
   （该文的体例是"references … collected into a single section at the end"，见 p. 2 逐字：
   "references and suggestions for further reading have not been given within the main text but collected into a single section at the end"）。
   ⇒ **(B) 不能引 Zagier 当 rigorous 来源**，最多当"该事实在标准文献中是已知的"的旁证（L1 但强度为转述）。
2. ⚠ **同一篇文章里记号从 `Λ₈/Λ₁₆`（p. 34）换成了 `Γ₈/Γ₁₆`（p. 36）。** 图卡用的是 `Γ` 版，与 p. 36 一致。
3. ⚠ **rank 8 的唯一性**在 p. 34 也只是顺带一句（"the known classification in this rank says … is, in fact, the only such lattice up to isomorphism"，
   句中被指代的格符号我在页图上没读全，**该句不要逐字引用**）。**rank 24 那句原文把 Niemeier 拼成了 "Niemeyer"**：
   > "The even unimodular lattices of this rank were classified completely by Niemeyer in 1973. There are exactly 24 of them up to isomorphism."
   ⇒ 若将来要引 24 维，**注意这是原文的拼写，正确姓氏是 Niemeier**。

### 47.3 ★★★ (B) 已核实、带编号、带完整证明、公开可取：Chenevier–Lannes, **Corollaire 3.6**（L1 页图）

**这是本轮最重要的发现，也是 (B) 唯一一条我真正逐字读到编号与证明的来源。**

**书目**：G. Chenevier & J. Lannes, *Formes automorphes et voisins de Kneser des réseaux de Niemeier*,
**arXiv:1409.7616**（math.NT；法文；约 380 页 + 附录）。
该书的英文出版版是 *Automorphic Forms and Even Unimodular Lattices*, Ergebnisse der Mathematik
(3. Folge) **69**, Springer 2019 —— ⚠ **英文版的编号与法文预印本几乎肯定不同，见下方警告。**

**获取路线（可复现）**：`https://arxiv.org/pdf/1409.7616v1` → WebFetch 落盘（3.4 MB）→ `Read(pages=)`。
（⚠ `ar5iv.labs.arxiv.org/html/1409.7616` **超 10 MB 上限**，走不通。）
**PDF 页 = 书页 + 4**（正文 p.1 在 PDF 第 5 页；前面是扉页 + 罗马数字目录 i–iii）。

⚠⚠ **版本悬案（必须记下）**：本轮取到的文件，**左侧栏 stamp 印的是 `arXiv:1409.7616v1 [math.NT] 26 Sep 2014`，
而扉页正文日期印的是 `30 juin 2022`**。两者不自洽（2014 年的 v1 不可能带 2022 的编译日期）。
arXiv API 报该条目**存在 v2**。⇒ **引用时不要写死版本号**，写 `arXiv:1409.7616`；
若某条编号成为图里的 load-bearing 依赖，请人类到 arXiv 页面核对版本与编号是否随版本改动。

**位置**：**Chapitre II「Algèbre bilinéaire et quadratique」, §3「Systèmes de racines et réseaux unimodulaires pairs」（书 pp. 31–41）**。
编号是**章内 §3 的流水号**（3.1, 3.2, …, 3.13），页图上印的标签就是 `Corollaire 3.6`（**不是** `II.3.6`）。

**★ (B) 的逐字陈述（L1，书上 p. 35）**：

> **Corollaire 3.6.** *Tout réseau unimodulaire pair de dimension 16 est isomorphe à `D₁₆⁺` ou à `E₈ ⊕ E₈`
> (et ces deux réseaux ne sont pas isomorphes).*

（中译：任一 16 维偶幺模格同构于 `D₁₆⁺` 或 `E₈ ⊕ E₈`，**且这两个格互不同构**。
注意括号里那半句很值钱：它把"恰有两个"里的**"至少两个"**也一并给了，
所以引这一条就够了，不需要再单独找"两者不同构"的来源。）

**同节的 8 维版本（L1，书上 p. 34）**：

> **Corollaire 3.5.** *Tout réseau unimodulaire pair de dimension 8 est isomorphe à `E₈`.*

**★ 原文自己给出的归属（L1 逐字，书上 p. 33，小标题
"CLASSIFICATION DES RÉSEAUX UNIMODULAIRES PAIRS EN DIMENSION 8, 16 ET 24" 下第一句）**：

> "Cette classification est due à **Louis J. Mordell** en dimension 8, à **Ernst Witt** en dimension 16
> et à **Hans-Volker Niemeier** en dimension 24 [Ni73]."

⇒ **"16 维恰有两个" 的原始功劳归 Witt**，这一点由该书作者明写。
⚠ 但**原文只对 Niemeier 给了文献标签 `[Ni73]`，对 Mordell 与 Witt 没给标签**
（同页、同段内没有 `[Wit41]` 之类）。⇒ 「Witt 1941 = 该定理的原始出处」这一步
**在本节只到"作者说是 Witt"的程度，具体是哪一篇仍是 L0**，见 §47.4 与 §47.7 Q47.2。

**★ 证明是完整的，而且原文说明了它为什么在 8/16 维也成立（L1 逐字，p. 33）**：

> "Ci-après, nous évoquons la stratégie ingénieuse développée par Boris Venkov [Ven80] pour retrouver
> la classification de Niemeier. **Sa stratégie fonctionne également en dimension 8 et 16.** En effet,
> l'idée de départ de Venkov est de considérer des séries thêta 'à coefficients harmoniques de degré 2'
> et d'observer que ces séries sont identiquement nulles car toute forme modulaire parabolique pour
> `SL₂(ℤ)` de poids `14 = 24/2 + 2` est nulle, les arguments qu'il utilise ensuite ne font plus intervenir
> de façon essentielle que la dimension des réseaux est 24 ; or toute forme modulaire parabolique pour
> `SL₂(ℤ)` de poids `n/2 + 2` est également nulle pour `n = 8, 16`."

**Corollaire 3.6 的证明链（原文自己列出的依赖，L1）**：

| 编号 | 内容 | 页 |
|---|---|---|
| `Définition 3.1` | ADE 型根系的 ad hoc 定义（三条件 (I)(II)(III)），自称是 `[Bou81b, Ch. VI, §1, Déf. 1]` 的变体 | 31 |
| `Proposition 3.2` | Venkov 恒等式：`Σ_{α∈R(L)} (α·x)² = (2|R(L)|/n) x·x`，**对 n = 8, 16, 24** | 33 |
| `Proposition-Définition 3.3` | 若 `R(L) ≠ ∅` 则 (a) `R(L)` 是**秩 n** 的 ADE 根系；(b) 各不可约分支的 Coxeter 数相同（记 `h(L)`，称 équicoxeter）；(c) `|R(L)| = n·h(L)` | 34 |
| **`Corollaire 3.6`** | **16 维分类** | **35** |

**Corollaire 3.6 的证明逐字（L1，p. 35）**：

> "*Démonstration.* Soit L un tel réseau. La série thêta de L est nécessairement égale à la série
> d'Eisenstein normalisée `𝔼₈ = 𝔼₄²`. On en déduit `|R(L)| = 480` et `h(L) = 30`. Cette dernière égalité
> force **par inspection** `R(L) ≃ D₁₆` ou `R(L) ≃ E₈ ⊔ E₈` … Dans le cas `R(L) ≃ E₈ ⊔ E₈` on conclut
> comme précédemment que l'on a `L ≃ E₈ ⊕ E₈`. Dans le cas `R(L) ≃ D₁₆`, `D₁₆` apparaît, à isomorphisme
> près, comme un sous-réseau de L ; on peut donc supposer que l'on a dans `ℚ ⊗_ℤ L` les inclusions
> `D₁₆ ⊂ L ⊂ D₁₆^♯`. Alors `L/D₁₆` est un lagrangien du qe-module `rés D₁₆` et l'on voit que l'on a `L ≃ D₁₆⁺`."

⚠ **证明里有一步是 "force par inspection"**（"由检查即得"）：即"秩 16、équicoxeter、Coxeter 数 30 的 ADE 根系
只有 `D₁₆` 与 `E₈ ⊔ E₈` 两种"这一步是**有限枚举**，原文不展开。
这是一个**有限可判定的检查**，不是缺口，但**如果将来要 Lean 形式化，这一步就是主要工作量**（见 §47.6）。

**★ 该书对 (A) 的态度：只说"众所周知"，不证明（L1 逐字，书上 p. 1，§I.1）**：

> "Il est bien connu que l'ensemble `X_n` est fini, et qu'il est non vide si, et seulement si, `n ≡ 0 mod 8`."

⇒ **(A) 不能引 Chenevier–Lannes**（他们不证也不给出处）。**(A) 用 Zagier Prop 12(i)（§47.2）。**

**同书 §I.1（p. 1）的定义与记号（L1 逐字，对建卡直接可用）**：

> "Un réseau unimodulaire pair de rang n est un réseau `L ⊂ ℝⁿ` de covolume 1 et tel que `x·x ∈ 2ℤ` pour tout `x ∈ L`."
> "`X_n = O(ℝⁿ)\𝓛_n` l'ensemble des classes d'isométrie de réseaux unimodulaires pairs de rang n."
> "`E_n = D_n ⊕ ℤe` où `D_n = {(x_i) ∈ ℤⁿ, Σ_i x_i ≡ 0 mod 2}`, `e = ½(1,1,…,1)`, et `n ≡ 0 mod 8`."
> "De manière un peu surprenante, `X_n` n'a été déterminé qu'en dimension `n ≤ 24`. Mordell et Witt ont
> respectivement démontré que `X₈ = {E₈}` et `X₁₆ = {E₁₆, E₈ ⊕ E₈}`."

⚠⚠ **本书的 `E₁₆` 就是 `D₁₆⁺`，不是什么"E 型李代数"**（不存在 `E₁₆` 李代数）。
原文在 p. 33 自己点明了这一点（L1 逐字）：

> "Le réseau unimodulaire pair `E_n` est aussi noté `D_n⁺` (au moins pour `n ≥ 16`)"

并且（p. 33）"Pour `n ≥ 16` (et `n ≡ 0 mod 8`) on a `R(E_n) = R(D_n) = D_n`" —— 即 `E₁₆` 的根系是 `D₁₆` 型。
**所以同一本书里 §I.1 写 `E₁₆`、§II.3 写 `D₁₆⁺`，指同一个格。抄编号时两处措辞不同，不要当成两条不同结论。**

**同节其它可能有用的编号（L1，顺带记下，供 24 维/Leech 方向）**：
`Scholie 3.4`（p. 34，24 维恒等式）、`Proposition 3.7`（p. 36）、`Proposition 3.8`（p. 37）、
`Proposition 3.9` + `Corollaire 3.10` + `Scholie 3.11`（p. 38，24 维双射）、
**`Théorème 3.12`（p. 41）**"Tout réseau unimodulaire pair dont l'ensemble des racines est vide est isomorphe
au réseau de Leech."（原文注明 "dû à Conway (voir [Co69b])"）、
**`Théorème 3.13`（p. 41）** 24 维的 24 个类。

⚠⚠ **引用警告（最容易翻车的一条）：编号是预印本的编号。**
英文出版版 *Automorphic Forms and Even Unimodular Lattices*（Ergebnisse 69, Springer 2019）
**几乎肯定重排了编号**（法文本把整个 Chapitre II 的 §3 用 3.x 流水号，英文本的章节划分未核实）。
⇒ **bib 里登记的是 arXiv 版**（`chenevier-lannes-2014`），`loc` 写
`arXiv:1409.7616, ch. II, §3, Corollaire 3.6 (p. 35)`，**不要**写成 Springer 书的定理号。

### 47.4 任务书点名的五个候选：逐条结算（**四本书的定理号全部 L0**）

本轮**没有一本**任务书点名的教科书能取到正文（Springer 登录墙 + Google Books 无预览 + WebSearch 额度耗尽）。
但**书目坐标**都钉死了，而且发现了几处版次陷阱。下面逐条给证据等级。

#### (a) Serre, *A Course in Arithmetic* (GTM 7) —— 章定位 L2，**定理号 L0**

**已核实（L2，Crossref 单-DOI 元数据）**：

> DOI `10.1007/978-1-4684-9884-4_5`；title **"Integral Quadratic Forms with Discriminant ± 1"**；
> container `Graduate Texts in Mathematics / A Course in Arithmetic`；**pages 48–58**；book-chapter；1973。
> （同书 Ch. IV "Quadratic Forms over Q_p and over Q" pp. 27–47；Ch. VII "Modular Forms" pp. 77–111。）

⇒ **第 V 章确实是"判别式 ±1 的整二次型"，且只有 11 页（48–58）。**
任务书猜的结构（§1 Preliminaries / §2 Statement of results，Theorem 2 = "n ≡ 0 mod 8"，
§1.4.3 或 Thm 5/6 给 8 维唯一与 16 维两个）**在 11 页的篇幅里是合理的，但本轮一个字都没核实**。

**另一条独立的书目线索（L1，Chenevier–Lannes 参考文献 p. 381 逐字）**：

> "[Ser70] J.-P. Serre, *Cours d'arithmétique*, P.U.F., Paris (1970)."

⚠ 专家引的是**法文原版 1970**，不是 GTM 7 英译本。而且 CL 引它的地方（p. 2）是
「`|X₃₂| > 8·10⁶` [Ser70]」——即**质量公式给出的 32 维下界**。
⇒ 这至少证明 Serre 书里**有**"定正情形 + 质量公式"的讨论（也就是任务书说的 §2.3 那块内容），
但**具体编号仍是 L0**。

**已试且失败的路线（别再花预算）**：
`books.google.com/books?vid=ISBN9780387900407` → 页面明写 **"No eBook available"**，**无预览** ⇒
[[web-fetch-access-blockers]] 里那条 Google Books `&q=` 定位法**对这本书完全不适用**。
`www.googleapis.com/books/v1/volumes?q=…` 本轮**三次全部 HTTP 429**。

⛔ **禁令：图里不得写 `Serre, A Course in Arithmetic, Ch. V, Theorem 2`（或任何具体定理号）。**
可以写的最强形式是：`serre-1973-arithmetic`，`loc: "Ch. V «Integral Quadratic Forms with Discriminant ±1», pp. 48–58（章定位 L2，定理号未核实）"`。

#### (b) Milnor–Husemoller, *Symmetric Bilinear Forms* —— 章定位 L2+L1 双源，**定理号 L0**

**两条独立来源逐字一致：**

- **L2（Crossref）**：book DOI `10.1007/978-3-642-88330-9`, *Symmetric Bilinear Forms*, 1973。章：
  | 章 | 标题 | 页 |
  |---|---|---|
  | I | Basic Concepts | 1–14 |
  | **II** | **Symmetric Inner Product Spaces over Z** | **15–55** |
  | III | Inner Product Spaces over a Field | 56–83 |
  | IV | Discrete Valuations and Dedekind Domains | 84–99 |
  | V | Some Examples | 100–109 |
- **L1（Chenevier–Lannes 参考文献 p. 379 逐字）**：
  > "[MH73] J. Milnor & D. Husemoller, *Symmetric bilinear forms*, Ergebnisse der Math. und ihrer Grenzgebiete **73**, Springer Verlag (1973)."

⇒ 任务书说的"Ch. II §6"**章是对的**（ℤ 上的对称内积空间只可能在 Ch. II，全书 109 页里它占 41 页，是最长的一章）。
但 `Theorem 6.1` 这个号**本轮无任何证据**。⛔ **同上禁令。**

#### (c) Conway–Sloane, *SPLAG* —— 章定位 L2（**跨三版页码不变**）+ 一条意外收获

**L2（Crossref）**，同一章在三个版本里的 DOI 与页码：

| 版 | 书 DOI 前缀 | Ch. 16 "Enumeration of Unimodular Lattices" | Ch. 19 "Enumeration of Extremal Self-Dual Lattices" |
|---|---|---|---|
| 1st (1988) | `10.1007/978-1-4757-2016-7` | **406–420** | 439–442 |
| 2nd (1993) | `10.1007/978-1-4757-2249-9` | **406–420** | 439–442 |
| 3rd (1999) | `10.1007/978-1-4757-6568-7` | **406–420** | **441–444** |

★ **Ch. 16 的页码三版完全一致（406–420）** ⇒ 引 `SPLAG Ch. 16, pp. 406–420` **是版次稳健的**。
⚠ 但 **Ch. 19 的页码在第 3 版变了** ⇒ 不要把"SPLAG 页码不随版本变"当成通则。

**L1（Chenevier–Lannes 参考文献 p. 375 逐字）**：
> "[CS99] J.H. Conway & N. J. A. Sloane, *Sphere packings, lattices and groups*, Grundlehren der Math. Wissenschaften **290**, Springer-Verlag, New York (1999)."

**★ 意外收获（L1，CL 参考文献 p. 383 逐字）——SPLAG 第 18 章的真实身份：**
> "[Ven80] B. Venkov, *On the classification of integral even unimodular 24-dimensional quadratic forms*, **Chapitre 18 de [CS99]**."

⇒ **Venkov 的那篇分类文章就是 SPLAG 的第 18 章**（不是独立期刊文章）。
而 §47.3 里 Corollaire 3.6 的整个证明策略正是"Venkov 的策略"。
⇒ **如果将来要给 (B) 找第二条独立来源，SPLAG 的 Ch. 18（而不是 Ch. 16）才是与本证明同源的那一章。**

⛔ 任务书提到的 **"Table 16.7"** 本轮**未核实**，不得写入图。

#### (d) Ebeling, *Lattices and Codes* —— **三版页码全不同**，章定位 L2，定理号 L0

**L2（Crossref）**：

| 版 | 书 DOI | Ch. 1 "Lattices and Codes" | Ch. 2 "Theta Functions and Weight Enumerators" | **Ch. 3 "Even Unimodular Lattices"** | Ch. 5 |
|---|---|---|---|---|---|
| 1994 | `10.1007/978-3-322-96879-1` | 1–35 | （未取到）| **83–103** | 127–166 |
| 2002 | `10.1007/978-3-322-90014-2` | 1–37 | （未取到）| **87–108** | 135–174 |
| 3rd (2012/13) | `10.1007/978-3-658-00360-9` | 1–32 | 33–75 | **77–95** | 121–157 |

⚠⚠ **同一章 "Even Unimodular Lattices" 在三个版本里的起始页是 83 / 87 / 77 —— 全不一样。**
⇒ **引 Ebeling 必须写死版次**（这一点和 [[reference_web-fetch-access-blockers]] 里 Jost/Kac–Raina 的教训同型）。

⚠ 任务书写的 "Ebeling **Thm 2.x**"：**章号存疑**。按上表，
"偶幺模格"是 **Ch. 3**，而 **Ch. 2 是 "Theta Functions and Weight Enumerators"**。
`n ≡ 0 mod 8` 这条**既可能在 Ch. 2**（因为标准证明就是 θ 函数那条，见 §47.2 的 Zagier）**也可能在 Ch. 3**。
本轮**两种都无法排除** ⇒ 定理号与章号**一律 L0**。

#### (e) Witt 1941 —— 书目 L1+L2 双源钉死，**正文 L0**，且**有一条真实的溯源缺口**

**书目（两条独立来源，逐字）：**

- **L1（Chenevier–Lannes 参考文献 p. 384 逐字）**：
  > "[Wit41] E. Witt, *Eine Identität zwischen Modulformen zweiten Grades*, Abh. Math. Sem. **Hansischen** Univ. **14**, 323–337 (1941)."
- **L2（Crossref）**：DOI **`10.1007/BF02940750`**；title "Eine Identität zwischen Modulformen zweiten Grades"；
  container **"Abhandlungen aus dem Mathematischen Seminar der Universität Hamburg"**；vol **14**；pages **323–337**；1941 (December)。
- **重印（L2，Crossref）**：Witt, *Collected Papers — Gesammelte Abhandlungen*（Springer Collected Works in Mathematics, 1998），
  pp. **313–329**，DOI `10.1007/978-3-642-41970-6_37`。

⚠ **刊名差异不是错误**：1933–1945 年间汉堡大学名为 "Hansische Universität"，
所以 1941 年那一卷印的是 "Abh. Math. Sem. Hansischen Univ."，现代 Crossref 用的是现名。**两者是同一刊、同卷、同页。**

**★★ 必须记下的溯源缺口（本轮最重要的否定结论之一）：**

Chenevier–Lannes 有两处提到 Witt，但**指向的不是同一件事**：

1. **p. 33（分类）**："Cette classification est due à … à **Ernst Witt** en dimension 16 …"
   —— **无文献标签**（同段只给 Niemeier 挂了 `[Ni73]`）。
2. **p. 340（附录 A，θ 恒等式）逐字**：
   > "l'égalité des séries thêta `ϑ^(g)_{E₈⊕E₈} = ϑ^(g)_{E₁₆}` pour `g ≤ 3` (**résultat dû à Witt pour `g ≤ 2` [Wit41]**)."
   —— **这是全书唯一一处带标签地引用 [Wit41]，而它引的是"次数 g ≤ 2 的 Siegel θ 级数相等"，不是分类。**

⇒ **本轮没有任何来源逐字支持"Witt 1941 这一篇里证明了 16 维分类"。**
只支持两件较弱的事：(i) 分类归 Witt（人）；(ii) Witt 1941（文）证了 `g ≤ 2` 的 θ 恒等式。
⛔ **禁令：不得在图里写 "Witt (1941) proved that there are exactly two …"。**
可写：`witt-1941`，`note: "Chenevier–Lannes 把 16 维分类归给 Witt 但未给出处；[Wit41] 在该书里被引用的是 g≤2 的 Siegel θ 恒等式。原文正文未取到。"`
（这条待解问题见 §47.7 Q47.2。）

### 47.5 ★ 记号对照表（**同一个符号在不同书里指不同的格**）

| 对象 | Polchinski v2 §11.6 | Zagier (2008) | Chenevier–Lannes | 常见其它写法 |
|---|---|---|---|---|
| 8 维那个偶幺模格 | `Γ₈` | `Λ₈`（p.34）→ `Γ₈`（p.36） | `E₈` | `E₈`、`Λ₈` |
| 16 维**不可分解**那个 | `Γ₁₆` | `Λ₁₆`（p.34）→ `Γ₁₆`（p.36） | `E₁₆`（§I.1）= `D₁₆⁺`（§II.3） | `D₁₆⁺`、`II₁₆,₀`、`Γ₁₆` |
| 16 维**可分解**那个 | `Γ₈ × Γ₈` | `Λ₈ ⊕ Λ₈` → `Γ₈ ⊕ Γ₈` | `E₈ ⊕ E₈` | `E₈²` |

**★★ 两个真会咬人的陷阱：**

1. **`E₁₆` 不是李代数。** Chenevier–Lannes 的 `E_n := D_n ⊕ ℤe`（`e = ½(1,…,1)`）是他们对 `D_n⁺` 的记号，
   原文 p. 33 自己说："Le réseau unimodulaire pair `E_n` est aussi noté `D_n⁺` (au moins pour `n ≥ 16`)"。
   **不存在 `E₁₆` 型李代数**；`E₁₆` 的根系是 `D₁₆` 型（原文 p. 33："Pour `n ≥ 16` … on a `R(E_n) = R(D_n) = D_n`"）。
2. **`Λ₁₆` 在 Zagier 与在 Chenevier–Lannes 附录 A 里是两个不同的格。**
   Zagier p. 34 的 `Λ₁₆` = 16 维偶幺模不可分解格（= `D₁₆⁺`）；
   CL **附录 A**（p. 339）的 `Λ₁₆` = **Barnes–Wall 格 BW₁₆**（原文逐字："un remarquable réseau de dimension 16
   découvert par Barnes et Wall en 1959 [BW59]. Il apparaît … dans [CS99] où il est noté `Λ₁₆` ou `BW₁₆`"），
   它的最小范数是 4、**不是幺模格**。⛔ **两者不可混。**

**`Γ₁₆ = D₁₆⁺ = E₁₆(CL)` 的等同是抽取者做的比对（`inferred`，非任一文献明说）**：
Polchinski (11.6.5a,b) 的 `Γ₁₆` = 「`(n₁,…,n₁₆)` 或 `(n₁+½,…,n₁₆+½)`，`Σᵢ nᵢ ∈ 2ℤ`」
与 CL 的 `E₁₆ = D₁₆ ⊕ ℤe`（`D₁₆ = {x ∈ ℤ¹⁶ : Σxᵢ ≡ 0 mod 2}`，`e = ½(1,…,1)`）逐条对上。
curator 若要建这条等同边，**须标 `inferred: true`**。

**术语**：本节所有来源里，数学侧一律写 **"even unimodular" / "réseau unimodulaire pair"**，
物理侧（Polchinski (11.6.4b) 写 `Γ = Γ*`）写 **"even self-dual"**。对**正定**整格两者等价。

### 47.6 图里建议怎么加（供 curator 取舍；researcher 不改 `graph/`）

**（a）核心建议：把现在这一张卡拆成两张**

现在的 `math.even-self-dual-euclidean-lattices-dimension-16` 把 §47.0 的 (A)、(B) 压在一起。
两条命题的来源、证明手段、可形式化难度都不同，**合成一张卡会让 (B) 的 `par inspection` 有限枚举
和 (A) 的模形式论证互相污染**。建议：

| 建议 id | kind | 建议 status | 内容 | 唯一必须的 source |
|---|---|---|---|---|
| `math.even-unimodular-rank-divisible-by-8` | proposition | **`rigorous`** | 正定偶幺模格的秩 `n ≡ 0 (mod 8)` | `zagier-2008`，`loc: "§3.2, Proposition 12(i), p. 33"` |
| `math.even-unimodular-rank-16-classification` | proposition | **`rigorous`** | 16 维偶幺模格恰有两类：`D₁₆⁺` 与 `E₈ ⊕ E₈`，且两者不同构 | `chenevier-lannes-2014`，`loc: "ch. II, §3, Corollaire 3.6, p. 35"` |

（可选，同一节同一页图里顺手就有，成本为零：
`math.even-unimodular-rank-8-unique` ← `Corollaire 3.5, p. 34`；
`math.even-unimodular-rank-24-niemeier` ← `Théorème 3.13, p. 41`。）

**如果船长坚持保留单卡**：那么 `sources` 必须**同时**挂 Zagier Prop 12(i) 与 CL Corollaire 3.6，
且 `notes` 写明"本卡是两条独立定理的合取，(A) 来自 Zagier，(B) 来自 Chenevier–Lannes"。
**不要**只挂一条 Polchinski (11.6.4)——那是物理书的无出处断言。

**（b）现有那条"一致 CFT ⟺ 偶自对偶格"的桥**：**保持 `physical-argument`，本节不动它。**
它的一手来源已经在 `extractions/polchinski-1998-v2.md` **E63**（§11.6, (11.6.1)–(11.6.10), pp. 73–75，L1）：
Polchinski 逐字写 "From the discussion of Narain compactification in **section 8.4**, we know that the
requirements for a consistent CFT are **locality of the OPE plus modular invariance**"，
然后直接断言 "Even self-dual Euclidean lattices exist only when the dimension is a multiple of 8,
and for dimension 16 there are exactly two such lattices, `Γ₁₆` and `Γ₈ × Γ₈`."
—— **这句断言没有任何文献出处**，这正是本节要替换掉的部分。
⇒ 建议的边：`heterotic.gauge-group-exactly-two --depends_on--> math.even-unimodular-rank-divisible-by-8`
和 `--> math.even-unimodular-rank-16-classification`，**外加**那条仍为 `physical-argument` 的
"一致性 ⟺ 偶自对偶"桥。**数学卡升 rigorous 不会把杂化弦那条结论抬到 rigorous**，瓶颈仍在物理桥上——
这一点请在 `notes` 里写清楚，免得有人误以为"补了数学来源就严格了"。

**（c）形式化可行性（给 lean-formalizer 的预判，非本轮任务）**

Corollaire 3.6 的证明链是：`dim M₈(SL₂(ℤ)) = 1` → θ 级数 = `𝔼₄²` → `|R(L)| = 480`、`h(L) = 30`
→ **"par inspection"：秩 16、équicoxeter、Coxeter 数 30 的 ADE 根系只有 `D₁₆` 与 `E₈ ⊔ E₈`** → 格论收尾。
⇒ **唯一的重活是那一步有限枚举**（ADE 根系的 Coxeter 数表 + 秩相加 = 16 + 各分支 h 相同）。
Mathlib 里根系已有（`RootSystem`），但 **ADE 分类与 Coxeter 数表本轮未查**（见 §47.7 Q47.5）。
`dim M_k(SL₂(ℤ))` 与 Eisenstein 级数在 Mathlib 里的状态**也未查**。

**（d）四条禁令（都在 §47.4 里给了证据）**

- ⛔ 不得写 `Serre, A Course in Arithmetic, Ch. V, Theorem 2`（或任何 Serre 的定理号）。
- ⛔ 不得写 `Milnor–Husemoller, Ch. II, Theorem 6.1`（或任何 M–H 的定理号）。
- ⛔ 不得写 `SPLAG Table 16.7`；SPLAG 只能引到**章**（Ch. 16, pp. 406–420，三版一致）。
- ⛔ 不得写 `Witt (1941) proved there are exactly two …`——**本轮找到的是反向证据**：
  Chenevier–Lannes 唯一带标签引用 `[Wit41]` 的地方，引的是 `g ≤ 2` 的 Siegel θ 恒等式，不是分类。

**（e）bib 登记（本轮已写入 `literature/sources.bib`）**

新增 7 条：`zagier-2008`、`chenevier-lannes-2014`、`serre-1973-arithmetic`、`conway-sloane-1999`、
`milnor-husemoller-1973`、`witt-1941`、`ebeling-2013`。
每条的 `note` 里都写清了**哪些字段是 L1/L2 核实的、哪些是未核实的**，
特别是"定理号未核实"与"页码随版次变"两类风险。

### 47.7 访问日志与未解决问题（本节）

**本轮成功的路线（可复用）：**

| 路线 | 结果 |
|---|---|
| `people.mpim-bonn.mpg.de/zagier/files/doi/10.1007/978-3-540-74119-0_1/fulltext.pdf` | ★ **出版社排版 PDF，1.2 MB，PDF 页 = 书页**。作者主页上的合法一手件 |
| `arxiv.org/pdf/1409.7616v1` → 落盘 3.4 MB → `Read(pages=)` | ★★ **本轮最大收获**；**PDF 页 = 书页 + 4** |
| `api.crossref.org/works?query.bibliographic=…&select=DOI,title,container-title,page,type,issued` | ★ **Springer 书的章级目录（标题 + 页码 + 逐版 DOI）一次到手**——绕开 Springer 登录墙的最便宜办法。对 Serre / Milnor–Husemoller / SPLAG / Ebeling 四本全部命中 |
| `api.crossref.org/works?query.bibliographic=<老论文标题>` | 钉死 Witt 1941 的 DOI/卷/页 + 找到 1998 全集重印本 |
| 读**专家专著的参考文献章**（CL pp. 371–384） | ★ 一次拿到 [Wit41][Ni73][Ser70][Ven80][CS99][MH73][Kn57][Kin03][Co69b][KV89] 的逐字著录 |
| `en.wikipedia.org/wiki/Unimodular_lattice` | 只用来定位候选文献，**不作为证据**；它给的是 "two in dimension 16 (E₈² and II₁₆,₀)" |
| `services.dnb.de/sru/dnb?version=1.1&operation=searchRetrieve&query=…&recordSchema=MARC21-xml` | **接口是活的**（返回合法 SRU 响应），但 `WOE=serre course in arithmetic` → `numberOfRecords = 0` |
| `inspirehep.net/api/literature?q=ft "…"` | 两次查询各只 2–10 条命中，**对本题基本无用**（物理文献不带数学定理号） |

**本轮失败的路线（别再花预算）：**

- `www.googleapis.com/books/v1/volumes?q=…` → **HTTP 429 三次**（与 [[web-fetch-access-blockers]] 记录一致，本环境基本不可用）。
- `books.google.com/books?vid=ISBN9780387900407`（Serre GTM 7）→ **"No eBook available"，无预览** ⇒ Google Books 定位法对该书无效。
- `ar5iv.labs.arxiv.org/html/1409.7616` → **`maxContentLength size of 10485760 exceeded`**（长专著必须走 PDF 路线）。
- `neilsloane.com/doc/` → **HTTP 403**（Sloane 自建论文目录不可抓）。
- `gaetan.chenevier.perso.math.cnrs.fr/pub.html` → **TLS 证书 altnames 不匹配**（`*.perso.math.cnrs.fr` 不覆盖三级子域），WebFetch 直接失败。
- `lite.duckduckgo.com` / `html.duckduckgo.com` → CAPTCHA；`www.mojeek.com` → **403**。
- ⚠⚠ **本会话开始时 `WebSearch` 额度就已被前序任务耗尽（200/200）**，全程只能用 WebFetch + API。
  **这直接决定了 Serre/M–H/SPLAG/Ebeling 的定理号拿不到**：破这些书的唯一已知路线（找一篇逐字引
  "[Ser73, Ch. V, Thm 2]" 的论文、或找 `.edu` 课程页扫描件）**都需要全文检索**。

**未解决 / 留给下一轮：**

- **Q47.1 ★★ 四本教科书的定理号全部 L0**（Serre Ch. V、Milnor–Husemoller Ch. II、SPLAG Ch. 16/18、Ebeling Ch. 2 或 3）。
  **下一轮有 WebSearch 时优先做这个**，检索式建议：`"Serre" "Course in Arithmetic" "Ch. V" "Theorem"`、
  `"Milnor" "Husemoller" "Theorem 5.1" signature`、`Ebeling "Lattices and Codes" "Theorem 3."`。
  也值得试 `d-nb.info/<IDN>/04` 目录扫描（Ebeling 是德国出版社，DNB 命中率最高；**IDN 要靠 WebSearch 找**）。
- **Q47.2 ★★ Witt 1941 正文里到底有没有 16 维分类？** 本轮反而拿到"CL 只把 `[Wit41]` 用于 θ 恒等式"这条反向线索。
  可试路线：(i) Witt *Collected Papers*（DOI `10.1007/978-3-642-41970-6_37`，pp. 313–329）——Springer 墙；
  (ii) DigiZeitschriften / GDZ 是否收 *Abh. Math. Sem. Hansischen Univ.* 第 14 卷；
  (iii) 找一篇**明确写 "Witt [Wit41] classified the even unimodular lattices of rank 16" 的现代论文**。
- **Q47.3** Chenevier–Lannes 的**版本悬案**：取到的文件同时带 `v1 / 26 Sep 2014` 的侧栏 stamp 与 `30 juin 2022` 的扉页日期。
  需人类到 arXiv 页面核对 v1/v2 的差异，确认 `Corollaire 3.6` 这个号在两版里一致。
- **Q47.4** 英文出版版 *Automorphic Forms and Even Unimodular Lattices*（Ergebnisse **69**, Springer 2019）里
  Corollaire 3.6 对应的编号是多少？（若图要引印本而非 arXiv，必须先解决这个。）
- **Q47.5** 形式化侧完全没查：Mathlib 里 (i) ADE 根系分类与 Coxeter 数表、(ii) `dim M_k(SL₂(ℤ))`、
  (iii) 格/θ 级数 —— 三样有没有。这决定 §47.6(c) 的可行性判断。
- **Q47.6** 本节**没有为 (A) 找到第二条独立来源**（Zagier 是唯一 L1）。CL 对 (A) 只说 "il est bien connu"。
  Serre / Milnor–Husemoller 本该是那条独立来源，但正文没取到 ⇒ 与 Q47.1 是同一件事。
- **Q47.7** Zagier p. 33 证明末句的极限变量（我读成 `k → ∞`，按内容应是 `n → ∞`）需重读一次页图确认；
  以及 p. 34 那句 rank-8 唯一性里被指代的格符号没读全。**两处都已在 §47.2 标注为"不要照抄"。**

---

# § Dedekind η 的 S 变换（供 `math.dedekind-eta-s-transformation`）

## 48. `η(−1/τ) = (−iτ)^{1/2} η(τ)`：带编号的数学来源（researcher，2026-09-11）

- 触发：图节点 `math.dedekind-eta-s-transformation` 目前**只有 Polchinski 的断言**（v1 (7.2.43)/(7.2.44)，
  而 `polchinski-1998-v1-ch7.md` 已 L1 确认**原书对该变换零证明**）。本节找数学侧的一手来源。

### 48.0 结论表（先看这张）

| # | 候选 | 等级 | 可写进图的 `loc` | 判断 |
|---|---|---|---|---|
| (a) | **Siegel, *Mathematika* **1** (1954) 4** | **L1 全文（1 页页图，已逐字转录）** | `p. 4`（**全文无编号定理**，见 48.2） | ★★ **首选**：陈述形式与图里要的**完全一致**，且有完整证明 |
| (b) | Apostol, GTM 41, **Ch. 3「The Dedekind eta function」pp. 47–73** | 章标题与页范围 **L1**（Crossref）；**「Theorem 3.1」这个号 L0** | 只能写 `Ch. 3, pp. 47–73` | 章级定位可写，**定理号不得写** |
| (c) | **Mathlib `Mathlib/NumberTheory/ModularForms/DedekindEta.lean`** | **L1（raw 源文件全读）** | — | ★★ **干净的否定结论：该文件里没有 S 变换**（见 48.4）⇒ **本节点不得标 `formalized`** |

### 48.1 文献标识（L1）

- **Crossref `api.crossref.org/works?query.bibliographic=…`（L1）**：
  `Carl Ludwig Siegel, "A simple proof of η(— 1/τ)= η(τ)√τ/i", Mathematika 1 (1954) 4–4, DOI 10.1112/S0025579300000462.`
  （⚠ Crossref 的标题字段里带一个乱码连字符 `— 1/τ`，抄进 bib 时要按页图订正为 `−1/τ`。）
- **取件路线（可复用，本轮一次命中）**：
  1. `www.cambridge.org/core/product/identifier/S0025579300000462/type/journal_article` → 文章页给出 "Save PDF (0.05 mb)"；
  2. PDF 真实 URL
     `www.cambridge.org/core/services/aop-cambridge-core/content/view/EEB34D28F123950F584CE8B8DE8F6709/S0025579300000462a.pdf/a-simple-proof-of-h-1t-htti.pdf`
     → WebFetch 落盘 → `Read(pages=1)` 读页图。
  3. **⇒ 记忆里「Cambridge Core 机构订阅」这条路线对 *期刊文章* 同样有效，不只对书。**
     **期刊文章的 item hash 与 `<DOI 去掉 10.1112/ 前缀>a.pdf` 一起构成文件名**，与书的 `c<N>_p<起>-<止>_CBO.pdf` 规则不同。
- **页脚（版本锚定凭据，L1 逐字）**：
  > `Downloaded from https://www.cambridge.org/core. Zhejiang University, on 11 Sep 2026 at 02:01:04, subject to the Cambridge Core terms of use, available at https://www.cambridge.org/core/terms. https://doi.org/10.1112/S0025579300000462`
- 页脚另一行（L1 逐字）：`[MATHEMATIKA 1 (1954), 4]  (Received 3rd December, 1953.)`

### 48.2 ★★ 硬性结论：Siegel 这篇**没有编号定理，陈述就是标题**

全文 1 页，**零编号公式、零编号定理、零参考文献、零小节**。
**要引用的那条陈述，字面上只出现在标题里**（L1 逐字，页图）：

> **A SIMPLE PROOF OF `η(−1/τ) = η(τ) √(τ/i)`**
> Carl Ludwig Siegel

⇒ **`loc` 只能写 `p. 4 (title)` 或 `p. 4`，不得写 "Theorem 1"。**

**⚠ 记号换算（这一步是抽取者的算术，不是原文）**：`τ/i = −iτ`，故 `√(τ/i) = (−iτ)^{1/2}`，
即 Siegel 的标题式与图里的 `η(−1/τ) = (−iτ)^{1/2} η(τ)` **逐字同义**。
**⚠ 原文不声明平方根的分支**，也**不显式写 `Im τ > 0`**（只以 `|q| < 1` 蕴含之，见下）。
若图节点要求「主支 + 上半平面」，这两条前提**在本来源里是隐含的，不是明写的**，note 必须写明。

### 48.3 正文逐字转录（L1，全部 1 页；`Read(pages=1)` 页图）

开头（η 的定义 + 本文的定位）：

> "This functional equation for Dedekind's
> `η(τ) = q^{1/24} ∏_{l=1}^{∞} (1−q^l)`   `(q = e^{2πiτ}, |q| < 1)`
> has been established in many different ways; however, it seems that the following proof,
> **a straightforward application of the theorem of residues, has not been observed before**."

**⇒ 文献自称的严格程度：这是一篇纯粹的数学证明（留数定理），作者自称的新颖点只在"证明方法"，不在结论。
结论本身被明说是已被 "established in many different ways" 的既有事实。**

证明骨架（逐字，行间式）：

> `(1/12)πiτ − log η(τ) = − Σ_{l=1}^{∞} log(1−q^l) = Σ_{k,l=1}^{∞} (1/k) q^{kl} = Σ_{k=1}^{∞} (1/k)(q^{−k}−1)^{−1}`,
>
> "it suffices to prove that"
> `πi (τ+τ^{−1})/12 + ½ log(τ/i) = Σ_{k=1}^{∞} (1/k) ( 1/(e^{−2πikτ}−1) − 1/(e^{2πik/τ}−1) )`.
>
> "Put"  `f(z) = cot z · cot(z/τ)`,  `ν = (n+½)π`  `(n = 0, 1, …)`.
>
> "The meromorphic function `z^{−1}f(νz)` has simple poles at `z = ±πk/ν` and `z = ±πkτ/ν`
> with the residues `(1/πk) cot(πk/τ)` and `(1/πk) cot(πkτ)` respectively, for `k = 1, 2, …`;
> in addition there is a pole of the third order at `z = 0` with the residue `−⅓(τ+τ^{−1})`.
> Let `C` denote the contour of the rhombus with vertices at `1, τ, −1, −τ` in the `z`-plane.
> Then by the theorem of residues"
> `πi (τ+τ^{−1})/12 + ∫_C f(νz) dz/(8z) = ½i Σ_{k=1}^{n} (1/k)(cot πkτ + cot πk/τ)`
> `  = Σ_{k=1}^{n} (1/k)( 1/(e^{−2πikτ}−1) − 1/(e^{2πik/τ}−1) )`.
>
> "On the other hand, as `n → ∞`, the function `f(νz)` is uniformly bounded on `C` and has on the four sides,
> excluding the vertices, the limit values `1, −1, 1, −1`. Hence"
> `lim_{n→∞} ∫_C f(νz) dz/z = ( ∫_1^τ − ∫_τ^{−1} + ∫_{−1}^{−τ} − ∫_{−τ}^{1} ) dz/z = 4 log(τ/i)`,
> "which gives the desired result."

**★ 自洽性复算（抽取者所做，两处，均通过——按本项目"反直觉系数先复算"的纪律）：**
1. `z=0` 三阶极点：`2πi × (1/8) × (−⅓)(τ+τ^{−1}) = −πi(τ+τ^{−1})/12`，移项后正是左端的 `+πi(τ+τ^{−1})/12` ✓；
   末式 `(1/8)×4 log(τ/i) = ½ log(τ/i)`，与"it suffices to prove"那一行的 `½ log(τ/i)` 严格吻合 ✓。
   ⇒ **`dz/(8z)` 里的 `8` 读数正确，不是 `3` 或 `s`。**
2. 单极点：`2πi×(1/8)×2×(1/πk)(cot πkτ + cot πk/τ) = (i/2)(1/k)(…)` ✓，与页图的 `½i Σ` 吻合；
   且 `(i/2)(cot πkτ + cot πk/τ) = 1/(e^{−2πikτ}−1) − 1/(e^{2πik/τ}−1)` 由 `cot θ = i(e^{2iθ}+1)/(e^{2iθ}−1)` 逐项验证成立
   （两个 `±½` 恰好相消）✓。

### 48.4 ★★ Mathlib 现状：**有 `DedekindEta.lean`，但里面没有 S 变换**（L1，raw 源文件全读）

> ⚠⚠ **限定（curator lean-wire-9，2026-09-11 追加）**：本节标题里的「raw 源文件全读」
> **只指 `Mathlib/NumberTheory/ModularForms/DedekindEta.lean` 这一个文件**，不是把
> `ModularForms/` 目录读全了。本节的否定结论因此**只对那一个文件成立**。
> **事实是：η 的 S 变换在 Mathlib 里，在同目录的 `Discriminant.lean`**——
> `ModularForm.eta_comp_eq_csqrt_I_inv : upperHalfPlaneSet.EqOn (eta ∘ (-1 / ·)) ((Complex.sqrt I)⁻¹ • (Complex.sqrt * eta))`
> （v4.33.1；逐字形状由 formalizer 读源码转录，L1），即 η(−1/z) = (√i)⁻¹ · √z · η(z)。
> 这正落在 §48.7 的 **Q48.2「Delta/Identities/JacobiTheta 侧未查」里；Q48.2 已于 2026-09-11 结清，见该处**。
> ⇒ 下面那条「**对图的硬约束**：不得标 formalized、不得挂 lean_decl」**已作废**：
> `math.dedekind-eta-s-transformation` 现挂 `lean_decl: StringFormal.DedekindEta.eta_neg_inv`
> 并有 formalized 推导 `--via-lean`。本节其余内容（声明清单、module docstring、参考文献）仍然准确。
> **方法论教训**：「Mathlib 没有 X」这类否定结论，读一个文件不足以支撑；要么读全目录，
> 要么把结论写成「文件 F 里没有 X」而不是「Mathlib 里没有 X」。

`https://api.github.com/repos/leanprover-community/mathlib4/contents/Mathlib/NumberTheory/ModularForms`（L1）
列出 **`DedekindEta.lean`** 确实存在。读其 raw 源文件（`raw.githubusercontent.com/…/master/…/DedekindEta.lean`，L1）后：

- **module docstring 自述覆盖范围**（L1 逐字节录）：用无穷乘积定义 η，证明它在上半平面
  "non-vanishing and differentiable"，"Lastly, we compute its logarithmic derivative and show that it is a multiple of the Eisenstein series `E2`"。
  引用的参考文献是 **Diamond & Shurman, *A First Course in Modular Forms*, §1.2**（不是 Apostol，也不是 Siegel）。
- **全文声明清单**（L1）：`eta_q_eq_cexp` / `eta_q_eq_pow` / `one_sub_eta_q_ne_zero` / `multipliable_one_sub_pow` /
  `multipliableLocallyUniformlyOn_one_sub_pow` / `differentiableOn_tprod_one_sub_pow` /
  `differentiableOn_tprod_one_sub_pow_pow` / `summable_eta_q` / `multipliableLocallyUniformlyOn_eta` /
  `eta_tprod_ne_zero` / `eta_ne_zero` / `logDeriv_one_sub_cexp` / `logDeriv_one_sub_mul_cexp_comp` /
  `one_sub_eta_logDeriv_eq`(private) / `tsum_logDeriv_eta_q` / `differentiableAt_eta_tprod` /
  `differentiableAt_eta_of_mem_upperHalfPlaneSet` / `logDeriv_qParam` / `summable_logDeriv_one_sub_eta_q` /
  **`logDeriv_eta_eq_E2 (z : ℍ) : logDeriv eta z = (π * I / 12) * E2 z`**。
- **⇒ 没有任何关于 `η(−1/τ)` 的声明。**

**★ 对图的硬约束**：`math.dedekind-eta-s-transformation` **不得标 `formalized`**，也不得挂 `lean_decl`。
**但这条否定结论同时是最好的 Lean 选题情报**：Mathlib 已经把 η 的定义、非零性、可微性、
以及 `logDeriv η = (πi/12)E₂` 都备好了，而 `E₂` 的模变换（权 2 拟模形式的 S 变换）正是 S 变换的标准证明路线之一
⇒ **这是一个"地基已铺、只差最后一步"的形式化岛**。
⚠ **未检查**：`Delta.lean` / `Identities.lean` / `LevelOne/` 里是否另有 η 的 S 变换（本轮 WebFetch 预算优先给了第 6 项），见 Q48.2。

### 48.5 Apostol：章级定位 L1，**定理号仍是 L0**

- **Crossref 章级目录（L1）**：`Modular Functions and Dirichlet Series in Number Theory`，
  **Chapter 3「The Dedekind eta function」= pp. 47–73**。
  两个版次的分章与页码**完全相同**：1976 一版 DOI `10.1007/978-1-4684-9910-0_3`；
  1990 二版（GTM 41）DOI `10.1007/978-1-4612-0999-7_3`。
  ⇒ **引 Apostol 时页码不必区分版次，但 DOI 必须区分。**
- **「Theorem 3.1」这个编号本轮零证据**：
  - `link.springer.com/chapter/10.1007/978-1-4612-0999-7_3` → **303 跳 `idp.springer.com/authorize`（登录墙）**，未继续。
  - INSPIRE 全文检索 `ft "Apostol, Theorem 3.1"` → **0 hits**（L1 否定）。
  - INSPIRE 全文检索 `ft "Modular Functions and Dirichlet Series" and ft "Theorem 3.1"` → **14 hits**，
    但这只说明"同一篇论文里同时出现这两个字串"，**不能推出它把 Theorem 3.1 归给 Apostol**（两个字串可能出自不同引用）。
    本轮未逐篇核对（预算给了第 6 项）。候选最相关者：arXiv:1210.3066（Rademacher Sums and Rademacher Series）、
    arXiv:1902.04180（Modular graph functions…）、arXiv:2008.02190（Discreteness and Integrality in CFT）。见 Q48.1。
  - **⚠ WebSearch 在本任务开始前即已耗尽（200/200）**，"找课程页逐字引 [Apostol, Thm 3.1]"这条唯一现实路线**未能执行**。
- ⇒ **硬性禁令：在 Q48.1 结清之前，图里与 `sources.bib` 里都不得出现 "Apostol, Theorem 3.1"。**
  `sources.bib` 本轮**只登记 `siegel-1954-eta`**；Apostol 暂不登记（避免登记了就被顺手引成 Theorem 3.1）。

### 48.6 图里建议怎么引（供 curator 取舍；researcher 不改 `graph/`）

```yaml
# math.dedekind-eta-s-transformation
sources:
  - ref: siegel-1954-eta
    loc: "p. 4 (title; the paper has no numbered theorem)"
    note: >
      原文写作 η(−1/τ) = η(τ)√(τ/i)；√(τ/i) = (−iτ)^{1/2}（换算是抽取者所做，原文未写）。
      原文不声明平方根分支，也不显式写 Im τ > 0（只由 |q| < 1 蕴含）。
      证明是留数定理（f(z)=cot z·cot(z/τ)，菱形围道 1, τ, −1, −τ），完整、自足、1 页。
# derivation own status 可写 proven（这是一条完整的严格数学证明）
# ⚠ 不得写 formalized：Mathlib 的 DedekindEta.lean 不含 S 变换（§48.4，L1）
```

同时建议：**把 Polchinski (7.2.43)/(7.2.44) 这条 source 保留但降级为"物理侧转述"**——
`polchinski-1998-v1-ch7.md` 已 L1 确认原书对该变换**零证明**，
所以图里 `math.*` 这条卡的 `proven` 状态应当由 Siegel 提供，而不是由 Polchinski 提供。

### 48.7 访问日志与未解决问题（本节）

| 目标 | URL / 手法 | 结果 |
|---|---|---|
| Siegel 1954 书目 | `api.crossref.org/works?query.bibliographic=Siegel+simple+proof+of+eta…` | ✅ DOI + 卷页年 |
| Siegel 1954 文章页 | `cambridge.org/core/product/identifier/S0025579300000462/type/journal_article` | ✅ 给出 "Save PDF (0.05 mb)" 与真实 PDF URL |
| **Siegel 1954 全文** | Core `/services/aop-cambridge-core/content/view/EEB34D28F123950F584CE8B8DE8F6709/S0025579300000462a.pdf/…` | **✅ 56 KB / 1 页，`Read(pages=1)` 读图成功** |
| Apostol 章级目录 | `api.crossref.org/works?query.container-title=…&filter=type:book-chapter` | ✅ 八章标题 + 页码 + 两版 DOI |
| Apostol 正文 | `link.springer.com/chapter/10.1007/978-1-4612-0999-7_3` | ❌ 303 → `idp.springer.com/authorize` 登录墙 |
| Apostol 定理号 | INSPIRE `ft "Apostol, Theorem 3.1"` | ❌ **0 hits** |
| Mathlib 目录 | `api.github.com/repos/leanprover-community/mathlib4/contents/Mathlib/NumberTheory/ModularForms` | ✅ 21 个文件 + 4 个子目录，含 `DedekindEta.lean` |
| Mathlib 源文件 | `raw.githubusercontent.com/leanprover-community/mathlib4/master/Mathlib/NumberTheory/ModularForms/DedekindEta.lean` | ✅ 全读；**无 S 变换** |
| WebSearch | — | ❌ **本会话额度在任务开始前即 200/200 用尽** |

**未解决 / 留给下一轮**

- **Q48.1 ★ Apostol「Theorem 3.1」到底是不是那条陈述？** 下一轮**有 WebSearch 时优先做**，
  检索式：`"Apostol" "Theorem 3.1" "Dedekind eta"`、`site:edu "Apostol" "Theorem 3.1" eta`。
  无 WebSearch 时的替代：逐篇读上面 14 条 INSPIRE 命中里最可能的 3 篇（1210.3066 / 1902.04180 / 2008.02190），
  看有没有 `[Apostol, Theorem 3.1]` 形式的逐字引用。
- **Q48.2 ★ Mathlib 里 η 的 S 变换是否在别的文件？** 本轮只读了 `DedekindEta.lean`。
  待查：`ModularForms/Delta.lean`、`ModularForms/Identities.lean`、`ModularForms/LevelOne/`、
  以及 `Mathlib/Analysis/SpecialFunctions/…/JacobiTheta`（θ 的 S 变换在 Mathlib 里**确定存在**，
  而 `η` 与 `θ` 之间有标准桥；若 θ 侧已形式化，本节点的 Lean 路线会比想象中短）。
  - **[已结清]（formalizer，2026-09-11，逐文件读 Mathlib v4.33.1 源码，L1；curator lean-wire-9 落地）。**
    答案：**在 `Mathlib/NumberTheory/ModularForms/Discriminant.lean`**（2026 新增文件）：
    `ModularForm.eta_comp_eq_csqrt_I_inv`，即 η(−1/z) = (√i)⁻¹ √z η(z)，
    `Complex.sqrt w = w ^ (2⁻¹ : ℂ)` 主分支（`Mathlib/Analysis/RCLike/Sqrt.lean`）；
    同文件另有 `discriminant_S_invariant`、`discriminant_T_invariant`（Δ = η²⁴）。
    连带查清：**E₂ 的拟模性也已在 Mathlib**，
    `ModularForms/EisensteinSeries/E2/Transform.lean` 的 `G2_S_transform`、`G2_slash_action`、
    `E2_slash_action`（对全 SL(2,ℤ)）、`G2_T_transform`。
    **Mathlib 仍然没有的**：η 的 **T** 变换（`η(τ+1) = e^{iπ/12} η(τ)`）、
    η 对一般 (a b; c d) ∈ SL(2,ℤ) 的乘子系统（Dedekind 和）、τ₂|η|⁴ 的模不变性。
    ⚠ `discriminant_T_invariant` 是 Δ = η²⁴ 的不变性，**推不出 η 自身的相位**
    （24 次根的分支信息在 Δ 里丢掉），故它不是 η 的 T 变换的替代品；T 那半由本项目自己证
    （`formal/StringFormal/Math/DedekindEtaT.lean`，从乘积定义两行）。
    落地：`math.dedekind-eta-s-transformation--via-lean` 与
    `math.dedekind-eta-t-transformation--via-lean`（都 formalized），
    Lean 文件 `formal/StringFormal/Math/DedekindEtaS.lean`、`DedekindEtaT.lean`。
- **Q48.3** Siegel 原文不声明平方根分支与 `Im τ > 0`。若 Lean 化，这两条要自己补进 statement；
  补进去之后**就不再是"Siegel 证的那条"**，note 要写明。
- **Q48.4** 本项目此前未登记过 Mathematika。`sources.bib` 新增 `siegel-1954-eta` 时注意：
  Crossref 的标题字段含乱码连字符，**以页图为准**。

---

# § 紧曲面分类：Gallier–Xu 编号逐字复核（接 §39）

## 49. Gallier–Xu 的 Lemma 6.1 / Prop 6.1 / Thm 6.1 逐字与页码（researcher，2026-09-11）

- 触发：§39.2 只逐字转录了 **Theorem 6.1 / 6.2 / Definition 6.5**，而 **Lemma 6.1 与 Proposition 6.1
  只在 §39.2.0 的交叉表里出现了一行内容概括，没有逐字**。本节补齐。
- 取件：`https://www.cis.upenn.edu/~jean/surfclassif-root.pdf` → 落盘 3.5 MB → `Read(pages=94-101)` + `Read(pages=102-107)`。
  **PDF 页 = 书页 + 10（本轮再次验证：PDF 94 ↔ 书 p.84，PDF 107 ↔ 书 p.97）。**
- **两版编号对照沿用 §39.2.0 的交叉表**（出版版 Ch.6 ↔ arXiv:0805.0562 v1 Ch.5），本节每条都把两个号一起写。

### 49.0 本节结论表

| 出版版编号 | 书页 | arXiv v1 编号 | 是否带证明 |
|---|---|---|---|
| **Proposition 6.1** | **p. 86** | Proposition 5.2.2 | 有证明，但关键步骤**外包给 Ahlfors–Sario [1]** |
| Proposition 6.2 | p. 88 | （交叉表未列，**本轮新增，arXiv 号 L0**） | **无证明**，只说"由 Prop 5.8 的证明细看可得" |
| **Lemma 6.1** | **pp. 92–95** | Lemma 5.2.5 | 有证明，**6 个 Step**，且明说沿用 Ahlfors–Sario [1] 的步骤 |
| **Theorem 6.1** | **p. 96** | Theorem 5.3.1 | 有证明（依赖 Lemma 6.1 + Theorem 5.2） |
| Theorem 6.2 | p. 97 | Theorem 5.3.2 | **无证明**，"For the record, we state the following theorem"（见 §39.2.1） |

### 49.1 ★★ **Proposition 6.1**（书上 **p. 86**，L1 逐字）

> **Proposition 6.1.** *Every cell complex, `K`, can be refined to a triangulated 2-complex.*

**证明的开头与外包句（L1 逐字，必须随引用一起写）**：

> "*Proof.* The idea is to subdivide the cell complex by adding new edges. Informally, it is helpful to view the process
> as adding new vertices and new edges, but since vertices are not primitive objects, this must be done via the
> refinement operations (P1) and (P2). To carry this out is a bit tedious, and we describe the refinement method
> assuming that vertices are primitive objects. **The process of systematically replacing vertices by sequences of
> edges is not hard but cumbersome. It is given in Ahlfors and Sario [1].**"

⇒ **这条命题的完整证明不在本书内**（"assuming that vertices are primitive objects" 是一个被明说绕开的化简）。
⚠ 它位于 §6.2「Normal Form for Cell Complexes」（该节自 **书 p.84** 起），其上文是 **Definition 6.3**（初等细分 (P1)/(P2)，书 p.84）。

### 49.2 **Proposition 6.2**（书上 **p. 88**，L1 逐字；§39 从未记录过）

> **Proposition 6.2.** *For a triangulated 2-complex `K` viewed as a cell complex, orientability of the surface `K_g`
> as given by Definition 4.6 is equivalent to orientability of `K` as given by Definition 6.4.*

其上文（L1 逐字）：「Close examination of the proof of **Proposition 5.8** (especially the last part) shows that if `K` is a
triangulated 2-complex representing a surface or a bordered surface `K_g`, then `K_g` is orientable iff every edge in `K`
occurs at most once in the set of boundaries of the faces, which is exactly the condition of Definition 6.4.
This important property is recorded in the following proposition.」
⇒ **Proposition 6.2 无独立证明，靠回指 Proposition 5.8。**
**它是把"胞腔复形的可定向性（Def 6.4）"与"曲面的可定向性（Def 4.6）"接起来的那块桥**，
`positive-euler-number-no-moduli--via-surface-enumeration` 若要用 Thm 6.1/6.2 的"character of orientability"，
这条桥是隐含依赖。

### 49.3 ★★★ **Lemma 6.1**（书上 **p. 92**，L1 逐字）——分类定理的组合核心

> **Lemma 6.1.** *Every cell complex, `K`, is equivalent to some canonical cell complex.*

**证明结构（L1，书上 pp. 92–95，六个 Step，标题逐字）**：

> "*Proof.* The proof proceeds by steps that bring the original cell complex closer to normal form.
> **We use the same steps as in the proof given in Ahlfors and Sario [1].**"
> - *Step* 1. **Elimination of strings `aa⁻¹` in boundaries.**
> - *Step* 2. **Vertex Reduction.**
> - *Step* 3. **Reduction to a single face and introduction of cross-caps.**
> - *Step* 4. **Introduction of handles.**
> - *Step* 5. **Transformation of handles into cross-caps.**
> - *Step* 6. **Grouping loops together.**
> "When all this is done, we have obtained a canonical form and the proof is complete. □"

**Step 5 的关键伪重写（L1 逐字，书 p.95）**：「We now show that a handle and a cross-cap is equivalent to **three cross-caps**.
For this, we apply the pseudo-rewrite rule `aaXY ≃ bYbX⁻¹`.」
**Step 3/4/6 用到的两条伪重写规则（L1）**：`aXaY ≃ bbY⁻¹X`（或 `aaXY ≃ bYbX⁻¹`）与 `aUVa⁻¹X ≃ bVUb⁻¹X`。

⚠ **本引理的引用纪律**：
1. **它只讲胞腔复形的等价，不讲同胚**；「等价 ⇒ 几何实现同胚」是另一步（在 Theorem 6.1 的证明里用）。
2. **证明步骤明说照抄 Ahlfors–Sario [1]**，与 Proposition 6.1 同一外包对象。
3. 书 p.95 末逐字：「A comparison of this proof with other proofs can be found in **Note F.9**.
   Readers interested in rewrite systems should read **Note F.10**.」——本书把与其它证明的比较放在附录 Note 里。

### 49.4 **Theorem 6.1**（书上 **p. 96**，L1 逐字；§39.2.1 已有，此处补其证明与所在节）

所在节：**§6.3「Proof of the Classification Theorem」**（自书 **p. 96** 起），节首逐字：
「Having the key **Lemma 6.1** at hand, we can finally prove the fundamental theorem of the classification of
triangulated compact surfaces and compact surfaces with boundary.」

> **Theorem 6.1.** *Two (two-dimensional) compact polyhedra or compact polyhedra with boundary
> (triangulated compact surfaces with or without boundary) are homeomorphic iff they agree in character of
> orientability, number of contours, and Euler–Poincaré characteristic.*

**证明逐字（书 p.96，完整，L1）**：

> "*Proof.* If `M₁ = (K₁)_g` and `M₂ = (K₂)_g` are homeomorphic, we know that `M₁` is orientable iff `M₂` is orientable,
> and the restriction of the homeomorphism between `M₁` and `M₂` to the boundaries, `∂M₁` and `∂M₂`, is a homeomorphism,
> which implies that `∂M₁` and `∂M₂` have the same number of arcwise components, that is, the same number of contours.
> Also, we have stated that homeomorphic spaces have isomorphic homology groups and, **by Theorem 5.2**, they have the
> same Euler–Poincaré characteristic. Conversely, **by Lemma 6.1**, since any cell complex is equivalent to a canonical
> cell complex, the triangulated 2-complexes `K₁` and `K₂`, viewed as cell complexes, are equivalent to canonical cell
> complexes `C₁` and `C₂`. However, we know that equivalence preserves orientability, the number of contours, and the
> Euler–Poincaré characteristic, which implies that `C₁` and `C₂` are identical. But then, `M₁ = (K₁)_g` and `M₂ = (K₂)_g`
> are both homeomorphic to `|C₁| = |C₂|`. □"

**⇒ Theorem 6.1 的完整依赖（原文自己点名的，不是推断）：Lemma 6.1 + Theorem 5.2（同伦不变的 Euler 数）
+ "equivalence preserves orientability / number of contours / χ"（书 p.88 与 p.90 的无编号段落）。**

### 49.5 顺带 L1 核实的三条（对 §39 的补强）

1. **χ 公式确实无编号**（书 p.89–90，L1 复核 §39.2 的警告）：
   type (I) 「there are `q+1` vertices, `2p+2q` sides, and one face … `χ(K) = 2 − 2p − q`」；
   type (II) 「`q+1` vertices, `p+2q` sides, and one face … `χ(K) = 2 − p − q`」。
   **两式都是正文行间式，没有编号。**
2. **规范复形的两两不等价性**在书 p.90 是一段无编号论证（"We claim that distinct canonical cell complexes
   `K₁` and `K₂` are inequivalent."），**不是定理**。
3. **Theorem 6.2 前的两句历史评注（书 p.97，L1 逐字，§39 未记）**：
   「It is interesting to note that **3-manifolds can be triangulated (E. Moise, 1952)** but that **Markov showed that
   deciding whether two triangulated 4-manifolds are homeomorphic is undecidable (1958)**. For the record, we state
   the following theorem putting all the pieces of the puzzle together.」
   ⇒ **"For the record, we state" 再次坐实 §39.2.1 的判断：Theorem 6.2 在本书里没有独立证明。**
4. **连通和（§6.4，自书 p.97 起）**：**Definition 6.6** 给 `S₁♯S₂`；`χ(S₁♯S₂) = χ(S₁) + χ(S₂) − 2`
   **是无编号行间式**（书 p.97），且前置措辞是「It can also be shown that」⇒ 无证明。

### 49.6 给 curator 的 `loc` 写法（供直接抄）

```
# 出版版（Springer GTC 9, 2013）——首选
Gallier & Xu, A Guide to the Classification Theorem for Compact Surfaces:
  Proposition 6.1, p. 86     # 胞腔复形可细分为三角化 2-复形（证明部分外包 Ahlfors–Sario）
  Proposition 6.2, p. 88     # 两种可定向性定义等价（无独立证明，回指 Prop 5.8）
  Lemma 6.1, pp. 92-95       # 每个胞腔复形等价于某个规范胞腔复形（6 步，步骤照 Ahlfors–Sario）
  Theorem 6.1, p. 96         # 三角化版分类定理（含带边）
  Theorem 6.2, p. 97         # 紧曲面版分类定理（含带边）——无证明，依赖 Appendix E 的可三角化性
# arXiv:0805.0562 v1（Ch.5）对应号：5.2.2 / （Prop 6.2 无对应记录）/ 5.2.5 / 5.3.1 / 5.3.2
```
⚠ **Proposition 6.2 的 arXiv 号本轮未核（L0）**，`sources.bib` 与图里都不要写它的 arXiv 号。

---

# § Chevalley 限制定理与根空间分解（接 §44，结算 Q39）

## 50. Humphreys GTM 9 §23 与 §8 的入口核实（researcher，2026-09-11）

- 触发：**§44.10 的 Q39**——「Chevalley 限制定理的带编号来源」。§44.4 只拿到
  「Humphreys *Reflection Groups* p.56 的 Remark 指向 GTM 9 §23」这一条 L1 交叉引用，
  **GTM 9 的内容一字未核（L0）**，且 `§23.1` 这一级零证据。
- **本轮结论：Q39 仍未结案，但拿到两条新的 L1 与两条新的 L4，并且发现了一个比编号更要紧的问题（见 50.3）。**
- ⚠ **本会话 `WebSearch` 额度在任务开始前即已耗尽（200/200）**，
  §44.10 Q39 列的第一条路线（找一篇逐字引 `[Hum, §23.1]` 的论文）**无法执行**。

### 50.0 结论表

| 目标 | 本轮最强证据 | 等级 | 可写进图吗 |
|---|---|---|---|
| GTM 9 的**章级**结构与页码 | Crossref 章级目录（见 50.1） | **L1** | ✅ 可写 `Ch. II, pp. 15–41` / `Ch. VI, pp. 107–144` |
| **§8 = 根空间分解**，且在 Ch. II 末 | Google Books 单页命中 p.35 + 章页范围 | **L4 + L1** | ⚠ 只能写 `§8 (Ch. II, pp. 15–41)`，**p.35 要标 L4** |
| **§23 讲 Harish-Chandra 定理** | Humphreys 本人在 *Reflection Groups* p.56 的 Remark（§44.4 已 L1） | **L1** | ✅ 可写 `§23`，**不得写 `§23.x`** |
| **§23 = Chevalley 限制定理** | **无任何来源背书**（见 50.3） | **L0，且有反向证据** | ❌ **禁止** |
| §23 的小节标题与页范围 | 两条互相矛盾的 Google Books 单页命中 | **L4** | ❌ 不写 |
| 形式化状态：根空间分解 | Mathlib `cartan_sup_iSup_rootSpace_eq_top` | **L1（文件在、声明名在）/ L0（确切陈述未读）** | ⚠ 见 50.4 |
| 形式化状态：Chevalley 限制 / Harish-Chandra 同态 | Mathlib `Algebra/Lie/` 目录清单里没有 | **L2（目录级）** | ⚠ 见 50.4 |

### 50.1 ★ L1：GTM 9 的章级目录与页码（Crossref，`query.container-title` + `filter=type:book-chapter`）

`J. E. Humphreys, *Introduction to Lie Algebras and Representation Theory*, GTM 9, Springer, 1972`
（DOI 前缀 `10.1007/978-1-4612-6398-2`，Crossref 全部返回 **1972**）：

| 章 | 标题 | 页 | 章 DOI 后缀 |
|---|---|---|---|
| I | Basic Concepts | **1–14** | `_1` |
| II | **Semisimple Lie Algebras** | **15–41** | `_2` |
| III | Root Systems | **42–72** | `_3` |
| IV | Isomorphism and Conjugacy Theorems | **73–88** | `_4` |
| V | Existence Theorem | **89–106** | `_5` |
| VI | **Representation Theory** | **107–144** | `_6` |
| VII | Chevalley Algebras and Groups | **145–164** | `_7` |

⚠ **Crossref 只给到章，给不到 `§N` 这一级**——GTM 9 的 `§1`–`§26` 是**跨章连续编号的小节**，
Crossref 的 "chapter" 对应的是罗马数字大章。**所以「§8 在哪一页」Crossref 回答不了，只能靠章页范围夹逼。**
⚠ **本轮对 Springer 的三条路线全部撞登录墙**：
`link.springer.com/book/10.1007/978-1-4612-6398-2`、`link.springer.com/content/pdf/bfm:978-1-4612-6398-2/1.pdf`
（前置内容 PDF）、以及 §48 里试过的章页 —— **三者一律 303 跳 `idp.springer.com/authorize`**。
**⇒ 记一条方法论：Springer 的 `bfm:…/1.pdf`（front matter）在本环境同样不开放，不要再试。**

### 50.2 (A) §8「根空间分解」

- **位置**：在 **Ch. II「Semisimple Lie Algebras」pp. 15–41**（L1），是该章的**最后一节**
  （§4–§8 五节；§9 起进入 Ch. III「Root Systems」，见上表 p.42）。
- **起始页 p.35**：Google Books 卷 `mSD4DvUFa6QC` 查 `"Root Space Decomposition"` → **Page 35**（**L4**）。
  该卷已在 §15.3 用无意义串做过控制实验并返回显式 "No results"，属「诚实卷」，故这个页码可信度高于一般 L4，
  **但仍只是"某页含该字串"，不等于"§8 起于 p.35"**。
  ⚠ Google Books **不回 snippet**（本轮两次查询均只回页号，无上下文），**无法据此写小节标题**。
- **图里需要的那句陈述**（**这是抽取者按需求侧写的，不是 Humphreys 的原文措辞；原文措辞仍 L0**）：
  设 `L` 半单、`H` 是极大环面子代数（Cartan 子代数），`Φ ⊂ H*` 是非零根集，则
  `L = H ⊕ ⨁_{α ∈ Φ} L_α`，其中 `L_α = {x ∈ L : [h,x] = α(h)x ∀h ∈ H}`，且 `H = C_L(H) = L_0`。
  ⚠ **不得把这段话加引号当成 Humphreys 的逐字。**
- **可写的最强 `loc`**：`Humphreys, GTM 9 (1972), §8 (Ch. II, pp. 15–41)`；
  note 里写「§8 起始页 p.35 来自 Google Books 单页命中（L4）；**小节标题与定理编号本项目未核实，不得写 `§8.x`**」。

### 50.3 ★★★ (B) §23：本轮最重要的发现是**一个定名问题，不是一个页码问题**

**已有的唯一 L1 证据（§44.4 已记，此处复述以便对照）**——Humphreys 本人，*Reflection Groups and Coxeter Groups*，
书上 **p.56**，§3.5 末的 Remark（Cambridge Core 页图，L1 逐字）：

> "*Remark.* When `W` is a Weyl group, **a theorem of Harish–Chandra (see Humphreys [1], §23)** allows one to derive
> from Chevalley's Theorem a description of **the center of the universal enveloping algebra** of a semisimple Lie
> algebra over `C`: it too is a polynomial algebra."

**★ 由此可以确定的与不能确定的，必须分开写：**

| 命题 | 状态 |
|---|---|
| 「GTM 9 §23 里有一条 Harish-Chandra 的定理，内容是 `Z(U(𝔤))` 是多项式代数」 | **L1 成立**（Humphreys 本人所述） |
| 「GTM 9 §23 = Chevalley **限制**定理 `S(𝔤*)^𝔤 ≅ S(𝔥*)^W`」 | **无来源，且有反向证据** |

**反向证据**：那条 Remark 的措辞是「**allows one to derive from** Chevalley's Theorem」——
即 Chevalley 的定理（该书 §3.5 的那条，关于反射群不变量环是多项式环）是**输入**，
`Z(U(𝔤))` 的描述是**输出**，**两者是两条不同的定理**。
§44.4 已经点出过这一层，**本轮把它升级为对任务书用词的直接更正**：
⇒ **任务书写的「§23（Chevalley 限制定理）」这个等式，在本项目现有全部证据下不成立。**
**§23 有 L1 背书的内容是 Harish-Chandra 关于 `Z(U(𝔤))` 的定理**；
**Chevalley 限制定理（`𝔤`-不变多项式由其在 `𝔥` 上的限制决定）落在哪一节，仍是 L0。**
（**它很可能就在 §23 的某个小节或附录里**——这是 §44.4 由 Google Books `"Invariant polynomial functions" → p.126`
推出的猜测，**但本项目从未核实过，不得写进图。**）

**本轮新增的 L4 页码（两条互相不完全一致，一并留痕）**：

| 查询（卷 `mSD4DvUFa6QC`） | 返回 | 轮次 |
|---|---|---|
| `"Invariant polynomial functions"` | **Page 126** | §44.4（上一轮） |
| `"Harish-Chandra"` | **Page 135** | **本轮** |
| `"Generalities on characters"` | **无结果返回**（页面未交付搜索结果区，**不是"无命中"，是"没拿到"**） | 本轮 |

⚠ **p.126 与 p.135 相差 9 页，两者不可能同属一个小节。**
可能性有二：(i) 两者都在 §23 内（§23 是个长节）；(ii) p.135 已落入 **§24**。
**本轮无法分辨** ⇒ **§23 的页范围不得写进图或 `sources.bib`。**
⚠ **§44.10 的禁令原样保留：不得写 `§23.1`，不得写 `Theorem 23.x`。**

### 50.4 形式化状态（L1 目录 + L1 docstring，本轮顺手查，对 Q39 的决策有直接影响）

- **★ 根空间分解 Mathlib 里有。** `Mathlib/Algebra/Lie/Weights/Cartan.lean`（raw 源文件 docstring 已读，L1）
  module docstring 逐字节录：「In the particular case when we view `L` as a module over itself via the adjoint action,
  **the weight spaces of `L` restricted to a nilpotent subalgebra are known as root spaces**.」
  其"主结果"里包含 **`cartan_sup_iSup_rootSpace_eq_top`**，docstring 概括为
  「the full root space decomposition: the Cartan subalgebra together with the supremum of nonzero root spaces
  spans the whole Lie algebra」。
  同目录另有 `Weights/RootSystem.lean`、`Weights/Chain.lean`、`Weights/Killing.lean`、`Weights/IsSimple.lean`。
  ⚠ **该文件的 docstring 里没有 References 节**（⇒ **拿不到"Mathlib 引 Humphreys 第几节"这条线索**，
  这是本轮试图用 Mathlib 反推 Humphreys 编号的路线**失败**的原因）。
  ⚠ **`cartan_sup_iSup_rootSpace_eq_top` 的确切签名与假设本轮未读（L0）**：
  它是 `⊔`/`⨆`（子模的上确界）形式，**不等同于"直和"**，且需要"分裂的幂零子代数"等前提。
  **要把它当 `lean_decl` 用之前必须读签名。**
- **Chevalley 限制定理 / Harish-Chandra 同态：Mathlib 里看不到。**
  `Mathlib/Algebra/Lie/` 顶层 40 个文件 + 5 个子目录（`AdjointAction`/`Basis`/`Derivation`/`Semisimple`/`Weights`）里
  **没有任何以 Chevalley 限制、Harish-Chandra、或 `Z(U(𝔤))` 命名的文件**
  （`Character.lean` 是**李代数的特征标 = 一维表示**，不是 Weyl 特征标；`SerreConstruction.lean` 是 Serre 关系；
  `UniversalEnveloping.lean` 只是 `U(𝔤)` 的构造）。**等级 L2（只看了目录，没读文件）。**
- **⇒ 对 §44.4 那条判断的支持**：E₈ 卡若想走 `rigorous`，**绕开 Chevalley 限制定理**（§44.7 的"对 248 个权直接做幂和"）
  仍然是明显更省的路线——因为限制定理这一侧**既没有可引编号，也没有形式化**，而根空间分解那一侧两样都有。

### 50.5 未解决 / 留给下一轮（Q39 的后继）

- **Q50.1 ★★（= Q39 的核心，未结案）** Chevalley **限制**定理 `S(𝔤*)^𝔤 ≅ S(𝔥*)^W` 的带编号来源。
  **下一轮有 WebSearch 时第一枪**：`"Humphreys" "Invariant Polynomial Functions" "23."`、
  `site:edu "Chevalley restriction theorem" "Humphreys" section 23`。
  无 WebSearch 时的替代：(i) DNB `d-nb.info/<IDN>/04` 取 Springer 出版方目录扫描
  （**IDN 本轮未找到；`services.dnb.de/sru/dnb` 端点本轮未试，见 §47.7 的既有记录：接口活着但命中率低**）；
  (ii) Google Books 再跑几条**小节标题**短语（本轮 `"Generalities on characters"` 未交付结果，值得重试一次）。
- **Q50.2** §23 与 §24 的分界页（p.135 到底属于哪一节）。这决定 §23 的页范围能不能写。
- **Q50.3** GTM 9 §8 的小节结构（§8.1–§8.4？）与定理编号。**图里若只需要"根空间分解"这条陈述，
  按 50.4 直接引 Mathlib + 一本有编号的书更划算**，Humphreys 的编号未必值得继续追。
- **Q50.4** `cartan_sup_iSup_rootSpace_eq_top` 的完整签名、前提、以及它与"直和"的差距。
  **这是唯一一条可能让相关节点标 `formalized` 的路，成本只有 1 次 raw 文件读。**

---

## 51. 三篇一手入口的登记 + ★★ 费米型 OPE–反对易子字典的严格对应物（researcher，2026-09-11）

本节两件事：**§51.1** 是 `gibbons-hull-1982` / `terao-uehara-1986` / `schwarz-1972` 三条新 bib 条目的抽取记录；
**§51.2–§51.5** 回答「费米型 OPE ↔ 反对易子字典在数学上对应哪条带编号定理」。

### 51.0 结论表（先看这张）

| 问题 | 结论 | 最佳来源与编号 | 等级 |
|---|---|---|---|
| Gibbons–Hull 的书目与摘要 | ✅ | INSPIRE；**页码 190–194，Sen 印的 "109" 是误印** | **L1**（书目+摘要）/ L0（正文） |
| Terao–Uehara 的书目与摘要 | ✅ | INSPIRE；PLB **168** (1986) 70–74；RRK-85-32 | **L1** / L0 |
| Schwarz 1972 的书目与摘要 | ✅ | INSPIRE；NPB **46** (1972) 61–74 | **L1** / L0 |
| **超（费米）情形的 Borcherds 恒等式，带编号** | ✅ **有，且是 Kac 本人的免费讲义** | **Kac, arXiv:1512.00821v2, Proposition 3.1, eq. (3.21)** | **L1 全文读图** |
| **超情形的模式版对易子/反对易子公式** | ✅ **有两条** | **同上 Corollary 3.2, eq. (3.20)**；以及更一般的 **Remark 1.5, eq. (1.32)** | **L1** |
| 「super」在该讲义里何处被定义 | ✅ | 同上 **Remark 1.4（"Super version"）, eq. (1.16)**，p.6 | **L1** |
| **Schottenloher Thm 10.10 有没有超版** | ❌ **没有，且作者自己说出了这一点** | 同书 **p.212 末段**（Ch.10 最后一段） | **L1 逐字** |
| Bakalov–Kac `math/0402315` 能不能当超版来源 | ❌ **不能**（§2 全非超） | 见 §51.4 | **L1** |
| Li–Wang `0802.0173` 的超情形 | ❌ 该文是**偶格**情形，非超 | 见 `sources.bib` 的 note | L1 |

### 51.1 三篇的登记记录（对应 `sources.bib` 的三条新条目）

**获取方法（三篇同一条，可复用）**：INSPIRE API
`https://inspirehep.net/api/literature?q=j%20<Journal>,<Vol>,<起页>&fields=titles,abstracts,publication_info,dois,authors,report_numbers&size=3`。
⚠ **摘要要逐字，必须在 prompt 里明写「拆成 ≤90 字符的编号片段、逐字复原、不要概括」** ——
否则中介概括器会因 125 字符引用上限而改写（本轮在 Gibbons–Hull 上先踩了一次，第二次用分片法一次成功）。

| bib key | 卷/页/年/DOI | 摘要 | 正文 |
|---|---|---|---|
| `gibbons-hull-1982` | Phys. Lett. B **109**(3) **190–194** (1982)，`10.1016/0370-2693(82)90751-1` | L1 逐字（见 bib note） | **L0** |
| `terao-uehara-1986` | Phys. Lett. B **168**(1–2) **70–74** (1986)，`10.1016/0370-2693(86)91462-0` | L1 逐字 | **L0** |
| `schwarz-1972` | Nucl. Phys. B **46**(1) **61–74** (1972)，`10.1016/0550-3213(72)90201-5` | L1 逐字 | **L0** |

**★★ 本轮最实用的一条**：`sen-1995-bh-torus.md` E-（BPS 界那条）里抄录的 Sen 参考文献
`[24] = G. Gibbons and C. Hull, Phys. Lett. **B109 (1982) 109**` —— **页码是 Sen 原文的误印**。
判据两条：(a) INSPIRE `j Phys.Lett.B,109,190` 命中该文；(b) INSPIRE `j Phys.Lett.B,109,109` **零命中**。
⇒ **图里一律写 190–194**；转述 Sen 的引用串时须注明「Sen 原文印作 109」。

**三条节点级限制（每条都直接来自摘要逐字，不是推断）**，详见各自 bib note：
1. **Gibbons–Hull 摘要不含 `M² ≥ Q_R²/2`**，语境是 N=2 超引力，无 `Q_L/Q_R` 划分 ⇒ 正文到手前只能挂「存在 Bogomolny 型下界」。
2. **Terao–Uehara 摘要的方向是 "Nilpotency … determines"，不是 iff；且不出现数字 10 / 1/2 / 0。**
   LZ 1989 `Prop 1.7(ii)` 写成 "iff" 是 LZ 的措辞，**不能回挂到本文**。
3. **Schwarz 1972 自陈方法来自 Brower** ⇒ 与 `brower-1972`/`brower-friedman-1973` **不是方法独立**；
   结论是 `d ⩽ 10`；**不得写 "Theorem N"**（1972 快报体例）。

### 51.2 ★★★ 费米情形：**Kac, arXiv:1512.00821v2**（L1 全文读图）——本轮的核心收获

| 项 | 值 | 等级 |
|---|---|---|
| 作者/标题 | Victor Kac, *Introduction to vertex algebras, Poisson vertex algebras, and integrable Hamiltonian PDE* | L1（标题页） |
| 版本 | **arXiv:1512.00821v2 [math-ph] 30 Jan 2017**（页边条纹逐字） | L1 |
| 来历 | INdAM 集中研究期 "Perspectives in Lie Theory"，Centro De Giorgi, Pisa，2014-12-09 – 2015-02-28 的 Lecture 1–6 | L1（摘要） |
| 获取 | `https://arxiv.org/pdf/1512.00821` → 落盘 539.7 KB → `Read(pages=)`；**PDF 页 = 文章页** | L1 |
| 记讲稿者 | Vidas Regelskis (Lec. 1,6)、Tamás F. Görbe (2)、Xiao He (3)、Biswajit Ransingh (4)、Laura Fedele (5,6) | L1 |

**⚠ 这是"由学生记录、作者致谢并致谢修订"的讲义**，不是同行评议论文；引用时必须写明版本 v2。

#### (a) **Remark 1.4「Super version」**（书/文章 **p. 6**，L1 逐字）——超设定的**唯一**声明处

> "*Remark 1.4* (Super version). A vertex superalgebra `V` is a local unital `z`-superalgebra `V`, cf. Definition 1.3.
> Namely `V` is a vector superspace
>
> `V = V_0̄ ⊕ V_1̄,  {0̄, 1̄} = ℤ/2ℤ`  **(1.16)**
>
> `a(z)b ∈ V_{α+β}((z))` if `a ∈ V_α, b ∈ V_β`, and `TV_α ⊂ V_α`, `α, β ∈ ℤ/2ℤ`. An element `a ∈ V` has
> *parity* `p(a) = α` if `a ∈ V_α`. Finally, the locality axiom **(1.11)** is written as `(z−w)^{N_ab}[a(z),b(w)] = 0`,
> where the commutator is understood in the "super" sense, i.e.
>
> `[a(z), b(w)] = a(z)b(w) − (−1)^{p(a)p(b)} b(w)a(z).`
>
> All the identities in the "super" case are obtained from the respective identities in the purely even case by the
> Koszul–Quillen rule: there is a sign change if the order of two odd elements is reversed; no change otherwise.
> **It is a general convention to drop the adjective "super" in the case of vertex superalgebras.**"

**★ 这段解决了一个真实的阅读陷阱**：该讲义 **Definition 1.1/1.3 的正文里没有任何 parity**
（"Let `V` be a vector space"，(1.11) 的 locality 也不带符号），
**但从 §1.3 起（自由费米子 Example 1.4）到 §3 全部默认超设定**，`[·,·]` 一律是超括号。
⇒ **凡引用该讲义的 `[·,·]`，note 里必须带上 Remark 1.4**，否则回译审计会判成"漏了符号"。

#### (b) ★★★ **Corollary 3.2 的 (3.20)**（p. 18，L1 逐字）——**卡「费米型 OPE ↔ 反对易子」要的那一条**

> "**Corollary 3.2** (of the proof). `Lie_V := span{a_{(n)} | a ∈ V, n ∈ ℤ} ⊂ End V` *is a subalgebra of the
> **Lie superalgebra** `End V` with the commutator formula*
>
> `[a(z), b(w)] = Σ_{j≥0} (a(w)_{(j)}b)(w) ∂_w^j δ(z,w)/j!,`  **(3.18)**
>
> *which is equivalent to each of the following two expressions*
>
> `[a_{(m)}, b(z)] = Σ_{j≥0} C(m,j) (a_{(j)}b)(z) z^{m−j},`  **(3.19)**
>
> `[a_{(m)}, b_{(n)}] = Σ_{j≥0} C(m,j) (a_{(j)}b)_{(m+n−j)}.`  **(3.20)**
>
> *Moreover, `Lie_V` is a regular formal distribution Lie algebra with the data `(Lie_V, ℱ = {a(z)}_{a∈V}, ad T)`.*"

（原文写 `\binom{m}{j}`，此处记作 `C(m,j)`。）

**★ 为什么这就是"费米版"**：语句里明写 `End V` 是**Lie superalgebra**，
配 Remark 1.4 的 `[a,b] = ab − (−1)^{p(a)p(b)}ba`，且 `p(a_{(m)}) = p(a)`。
⇒ **当 `a, b` 都是奇元时，(3.20) 左端就是反对易子**：
`{a_{(m)}, b_{(n)}} = Σ_{j≥0} C(m,j) (a_{(j)}b)_{(m+n−j)}`。
**这一步（"两个奇元 ⇒ 反对易子"）是 Koszul–Quillen 规则的直接代入，Remark 1.4 明写了规则本身，
但 (3.20) 下面没有把反对易子写出来** ⇒ 建卡时可标为「来源直接蕴含」，不必标 `inferred`，但要在 note 里写明这一步。

#### (c) **Proposition 3.1（Borcherds identity）的 (3.21)**（p. 18，L1 逐字）——**带显式 `(−1)^{p(a)p(b)}`**

> "**Proposition 3.1** (Borcherds identity). *For `n ∈ ℤ`, `a, b ∈ V`, where `V` is a vertex algebra, we have*
>
> `a(z)b(w) i_{z,w}(z−w)^n − (−1)^{p(a)p(b)} b(w)a(z) i_{w,z}(z−w)^n = Σ_{j∈ℤ₊} (a_{(n+j)}b)(w) ∂_w^j δ(z,w)/j!.`
> &nbsp;&nbsp;**(3.21)**"

证明只有四行（Decomposition theorem **Theorem 1.2** + `n`-th product 定义），**完整、自足**。
⚠ **形态提醒**：(3.21) 是 Borcherds 恒等式的**两项 + δ 函数（"生成函数"）形式**，
**不是** Gebert–Nicolai (2.36) / Borcherds 1986 (v) 那种**三项纯模式（Jacobi）形式**。
两者等价但**逐字不同**，`loc` 不可互换。

#### (d) 更上游的一条：**Remark 1.5 的 (1.32)**（p. 7，L1 逐字）——不依赖顶点代数

> "*Remark 1.5.* If we have a local pair `a(z), b(z) ∈ 𝔤[[z, z^{−1}]]`, where `𝔤` is a **Lie (super)algebra**
> (i.e. `[a(z), b(w)]` is a local formal distribution in `z` and `w`), then, by the Decomposition theorem, we have:
> `[a(z), b(w)] = Σ_{j≥0} (a(w)_{(j)}b(w)) ∂_w^j δ(z,w)/j!,`  **(1.30)** where the sum over `j` is finite, and
> `𝔤[[w,w^{−1}]] ∋ a(w)_{(j)}b(w) := Res (z−w)^j[a(z),b(w)]dz  (= c^j(w)).`  **(1.31)**
> Using **(1.24)** and comparing the coefficients of `z^m w^n` on both sides of (1.30), we find
>
> `[a_{(m)}, b_{(n)}] = Σ_{j≥0} C(m,j) (a_{(j)}b)_{(m+n−j)},  ∀m, n ∈ ℤ.`  **(1.32)**"

**⇒ (1.32) 与 (3.20) 是同一个公式在两个层次上的陈述**：
(1.32) 只需要「`𝔤` 是李超代数 + 一对局域形式分布」，**不需要顶点代数结构**；
(3.20) 是把它用在 `𝔤 = End V`、`ℱ = {Y(a,z)}` 上。
**对 stringgraph 极有用**：世界面上的 `b(z), c(z)` 鬼场、`ψ^μ(z)` 费米场只要「两两局域」就落入 (1.32) 的假设，
**不必先证明整个 `bc`/`ψ` 系统构成顶点（超）代数** —— 这比走 (3.20) 的门槛低得多。

#### (e) 同一讲义里顺带取到、对本项目有用的编号（全 L1）

- **Theorem 1.2（Decomposition theorem）** + (1.25)(1.26)：局域形式分布唯一分解为 δ 的导数之和。
  = Schottenloher `Proposition 10.6` 的对应物（Schottenloher 正文明写 "due to Kac"）。
- **Definition 1.3(a)** (1.11) 局域性；**(b)** "A *vertex algebra* is a local unital `z`-algebra."
- **Example 1.4（Free fermion）**：`F = Λ[ξ₁, ξ₂, …]` Grassmann 超代数，`p(ξ_i) = 1̄`；
  **(1.39) `[φ_{(m)}, φ_{(n)}] = δ_{m,−n−1}`**、**(1.40) `[φ(z), φ(w)] = δ(z,w)`**
  （原文称 `φ(z)` 为 "**The odd quantum field**"，故这两条括号都是**反**对易子）。
  ⇒ **这是"自由费米子世界面场"的完整数学模型，且带编号**，可直接用作图上 `bc`/`ψ` 卡的数学对应物。
  对照 **Example 1.3（Free boson）**：(1.33)(1.34) `[a_{(m)}, a_{(n)}] = mδ_{m,−n}`、(1.35)(1.36) 局域。
- **Proposition 3.2（Skewsymmetry）(3.24)**：`a(z)b = (−1)^{p(a)p(b)} e^{zT} b(−z)a` —— **超版斜对称**。
- **Proposition 3.3 (3.28)**：`T` 是所有 `n`-th product 的导子。
- **Definition 3.2（conformal vector）(3.30)**：`[L_m, L_n] = (m−n)L_{m+n} + δ_{m,−n}(m³−m)c·I_V/12`
  —— **超设定下的 Virasoro 代数，逐字用 `(m³−m)/12`**（与 Polchinski (2.6.19) 同形，见
  `polchinski-1998-v1.md` §12.1）。
- **(3.32)** `[L_{(m)}, a_{(n)}] = Σ_j C(m,j)(L_{j−1}a)_{(m+n−j)}`；**(3.33)/(3.34)** 共形权与 Hamiltonian 算子；
  **Proposition 3.5(c)** `Δ_{a_{(n)}b} = Δ_a + Δ_b − n − 1`。
- **λ-bracket (3.29)**；§4.1「Quasicommutativity, quasiassociativity and the noncommutative Wick's formula」。
- 作者自陈的归属（p. 6，L1）：「The Extension Theorem was proved in **[DSK06]**. In **[Kac98]** a weaker version was given.」
  ⇒ **Kac 的书（`kac-1998`）在这份讲义里被作者本人定位为"较弱版本"**，这对选 canonical 来源有直接意义。

### 51.3 ★★ Schottenloher **Theorem 10.10 没有超版**，且是作者自己说的（L1 逐字）

读的是作者 LMU 主页的分章 PDF `…/LNP-cft-pdf/10_978-3-540-68625-5_Ch10_23-08-08.pdf`（549.7 KB / 42 页，
**PDF 页 = 书页 − 170**）。**第 10 章最后一段（书 p.212）逐字**：

> "In this way we obtain similarly the description of a Verma module with respect to given numbers `c, h ∈ C`
> on p. 94, the representation of the string algebra on p. 119, the representation `V_c` of the Virasoro algebra
> Vir used for the Virasoro vertex algebras on p. 193, the representation of the Kac–Moody algebras on p. 196,
> and in a certain sense even the free boson representation on p. 136 where, however, the Hilbert space structure
> has to be respected as well. **Analogously, the fermionic Fock space on p. 52 can be described as an induced
> representation. To do this, we have to extend the consideration to the case of Lie superalgebras in order to
> include the anticommutation relations.**"

⇒ **这是作者本人对「本书不做超情形」的明确表态**，而且恰好落在"费米 Fock 空间 / 反对易关系"这个点上。
**⇒ 任务问的「Schottenloher Thm 10.10 是否有超代数版」答案是否定的，且有 L1 证据，不是"我没找到"。**

**本轮顺带补到的第 10 章编号（全 L1，`§11`/`§11A` 从未记录）：**

- 章首（书 p.171）自陈：「The introduction to vertex algebras in this chapter intends to be self-contained
  including essentially all proofs.」 + 「The presentation in these notes is based mainly on the course **[Kac98*]**
  and to some extent also on the beginning sections of the book **[BF01*]**.」
  ⇒ **Schottenloher 的第 10 章是 Kac 书的改写**，两者不是独立来源。
- **§10.1 = "Formal Distributions"**（书 p.172 起）；**§10.7 = "Induced Representations"**（书 p.209 起，本章最后一节）。
- **Theorem 10.36 = OPE 的结合性**（p.208 正文引用："the associativity of the OPE (Theorem 10.36)"）。
- **Corollary 10.34** = `Y(Ta, z) = ∂Y(a, z)`。
- **公理名**：`Locality Axiom V2`、`Vacuum Axiom V3`（p.208 逐字）。
- **★ Proposition 10.48 = Poincaré–Birkhoff–Witt**（书 p.210，L1 逐字）：
  > "**Proposition 10.48** (Poincaré–Birkhoff–Witt). *Let `(a_i)_{i∈I}` be an ordered basis of the Lie algebra `𝔤`.
  > Then the elements `p(a_{i₁} ⊗ … ⊗ a_{i_m}), m ∈ ℕ, i₁ ≤ … ≤ i_m`, together with 1 form a basis of `U(𝔤)`.*"
  ⚠ **原书不证**：紧邻上文逐字「using the construction of `U(𝔤)` this follows from the Poincaré–Birkhoff–Witt
  theorem **which can be found in many books, e.g., [HN91]**. We state one essential consequence…」
  ⇒ **这是 §33「PBW 的带编号来源」的一条新候选，但只有陈述没有证明**，
  排序上仍在 `lakos-2024-pbw` Prop 6.1 之后；优点是它**不限有限维**（`(a_i)_{i∈I}` 任意指标集）且免费可取。
  外包对象 **[HN91] = J. Hilgert and K.-H. Neeb, *Lie Gruppen und Lie Algebren*, Vieweg, Braunschweig, 1991**（德文）。
- **Definition 10.45**（`U(𝔤)` 的泛性质）、**Lemma 10.46/10.47**、**Definition 10.49**（诱导表示 `Ind^𝔤_𝔟`）。
- **第 10 章参考文献表（书 p.212，L1 逐字，12 条）**里对本项目最有用的两条：
  **[Kac98*] V. Kac, *Vertex Algebras for Beginners*. University Lecture Series 10, AMS, Providence, RI, 2nd ed., 1998.**
  （= 我们的 `kac-1998`，**版次与丛书号由此获 L1 独立佐证**）；
  **[BF01*] D. Ben-Zvi and E. Frenkel, *Vertex Algebras and Algebraic Curves*. AMS, Providence, RI, 2001**
  （⚠ **作者序与年份都与我们 bib 里的 `frenkel-benzvi-2004`（2nd ed. 2004）不同**，是**第 1 版**）。

### 51.4 ★ 否定结论：**Bakalov–Kac `math/0402315` 不能当超版来源**（L1 复核，改写 §37.4 的口径）

§37.4 记 (2.19)/(2.21)/Theorem 4.1 时没有查它的超设定。本轮补读 pp. 1–2：

- **§2.1 开头逐字：「Let `V` be a vector space.」**（p.2）——**没有超空间、没有 parity、没有 ℤ/2 分次**。
- **Definition 2.1（p.3）逐字：「A *vertex algebra* is a vector space `V` …」**——同样无 parity。
- **(2.3) 的局域性、(2.4) 的对易子公式、(2.19) Borcherds 恒等式、(2.21) 对易子公式里
  一个 `(−1)^{p(a)p(b)}` 都没有。**
- **但 Theorem 4.1（p.9）却写「of parity 0」「of parity `p(e^α) = |α|² mod 2ℤ`」** ——
  即**第 4 节默默切换到了超设定，而第 2 节的公理与恒等式是非超版**。

⇒ **这是该文内部的一处口径跳变**（不是错误：按 Remark 1.4 那种"drop the adjective super"的通行约定可以自洽，
但 **Bakalov–Kac 这篇没有写出那句约定**）。
**⇒ 图里凡需要"超"的地方，不得引 `bakalov-kac-2004` 的 (2.19)/(2.21)；要引 `kac-2017-lectures` 的 (3.21)/(3.20)。**
（§37.4 关于 Theorem 4.1 与 Definition 2.2(iii) 不相容的红旗**不受影响，仍然成立**。）

顺带把 §37.4 漏记的两条补上（L1）：**Remark 3.1 的 (3.7)** 是扭转 Borcherds 恒等式的**模式版**
（`a ∈ V_j, b ∈ V, c ∈ M, m ∈ (1/N)+ℤ, n ∈ ℤ, k ∈ (1/N)ℤ`），**同样不带 parity 符号**；
**(3.12)** 是扭转对易子公式（场版）。

### 51.5 图里建议怎么引（供 curator 取舍；researcher 不改 `graph/`）

1. **新增数学卡 `math.mode-commutator-formula-super`**（或在既有「OPE ↔ 对易子字典」卡上加超分支）：
   - 陈述：设 `𝔤` 是李**超**代数，`a(z), b(z) ∈ 𝔤[[z,z^{−1}]]` 局域，则
     `[a_{(m)}, b_{(n)}] = Σ_{j≥0} C(m,j)(a_{(j)}b)_{(m+n−j)}`，其中 `[·,·]` 是超括号；
     `a, b` 同为奇元时即 `{a_{(m)}, b_{(n)}} = …`。
   - `sources`: `kac-2017-lectures`，`loc: "Remark 1.5, eq. (1.32), p. 7（超设定见 Remark 1.4, eq. (1.16), p. 6）"`。
   - `status`: 该讲义给了完整证明（Theorem 1.2 + (1.24)），可标 **`rigorous`**；
     ⚠ 但它是**学生记录的讲义**，reviewer 若要求同行评议来源，第二来源用
     `gebert-nicolai-1995` (2.38)（**非超**）或 `kac-1998` §4.8（**编号只到 L2**）。
2. **顶点（超）代数版**另立一张卡，`loc: "Corollary 3.2, eq. (3.20), p. 18"`，
   并在 `depends_on` 上挂「`V` 是顶点超代数」这条前提。
   ⚠ **本项目目前没有任何来源证明「世界面 `bc` 鬼场系统 + `ψ^μ` 构成顶点超代数」**（见 §14.2 的既有缺口），
   **所以走 (1.32) 这条低门槛路线更现实**。
3. **Borcherds 恒等式（超版）**：`loc: "Proposition 3.1, eq. (3.21), p. 18"`。
   ⚠ **必须在 note 里写明它是"两项 + δ 函数"形式**，与 `borcherds-1986` Section 4 的 (v)、
   `gebert-nicolai-1995` (2.36) 的三项模式形式**逐字不同**。
4. **`worldsheet.free-fermion-*` 一类卡的数学对应物**：`loc: "Example 1.4, eqs. (1.37)–(1.41), p. 8"`。
5. **禁令**：`schottenloher-2008` **不得**用作任何超/费米陈述的来源；
   若已有卡片这么挂，改挂 `kac-2017-lectures`，并把 p.212 那句作者自陈写进 note。

### 51.6 本节访问日志与未解决问题

| 目标 | URL / 查询 | 结果 |
|---|---|---|
| Gibbons–Hull 书目+摘要 | INSPIRE `j Phys.Lett.B,109,190` | ✅ |
| 「PLB 109 p.109 上有没有别的文章」 | INSPIRE `j Phys.Lett.B,109,109` | ✅ **零命中**（负面证据成立） |
| Terao–Uehara | INSPIRE `j Phys.Lett.B,168,70` | ✅ |
| Schwarz 1972 | INSPIRE `j Nucl.Phys.B,46,61` | ✅ |
| Kac 讲义正文 | `arxiv.org/pdf/1512.00821` | ✅ 539.7 KB，读 pp.1–4, 6–9, 18–20 |
| Bakalov–Kac 超设定复核 | `arxiv.org/pdf/math/0402315` | ✅ 读 pp.1–7 |
| Schottenloher ch.10 超情形 | LMU 分章 PDF | ✅ 读 PDF pp.1–2, 38–42 |

**未解决：**
- **Q51.1** `kac-1998`（《Vertex Algebras for Beginners》2nd ed.）**§4.8 / Theorem 4.8 / (4.8.1) / Prop 4.8(b) 的逐字仍是 L0**
  （编号只有作者勘误表 `kac-1999-corrections` 的 L2 背书）。本轮**没有**去碰它，因为 `kac-2017-lectures` 已足够。
  若日后一定要用 Kac 书的编号，**注意作者本人在 1512.00821 p.6 说书里的 Extension Theorem 是 "a weaker version"**。
- **Q51.2** Kac 讲义 **pp.10–17（§2.2–§3.1）与 §4 未读**，
  其中 **§2.3「Bakalov's formula and Dong's lemma」** 与 Schottenloher `Lemma 10.11`（Dong 引理）应当可以对上，
  但本轮没核。成本约 2 次 Read。
- **Q51.3** 「世界面 `bc` 鬼场 / `ψ^μ` 满足 (1.32) 的局域性假设」这一步**在本项目仍无来源**
  （与 §14.2 记的缺口同源）。这是费米侧唯一真正的缺口。
- **Q51.4** Schottenloher 第 10 章 pp.173–207（PDF 3–37）本轮未通读，
  故「`Theorem 10.36` 的确切陈述」「`Lemma 10.11` 是否就是 Dong 引理」等仍按 §11 的旧记录。

---

## 52. Humphreys GTM 9 §8（根空间分解）与 §23 的 L1 入口——第二轮（researcher，2026-09-11）

**结论先说：L1 入口本轮仍未拿到（Q39 / Q50.1 未结案），但拿到了 §50 没有的四条新 L4，
并且这次的 L4 带有一次成功的对照实验，可信度高于 §50 那批。**

⚠ **本轮 `WebSearch` 额度在任务开始前即已耗尽（200/200，第二次）**，
§50.5 列的第一条路线（找逐字引 `[Hum, §23.x]` 的论文/课程页扫描件）**又一次无法执行**。
⇒ **这条路线连续两轮因同一原因未执行，不是"试过失败"。建议 lead 把它排到会话最前段。**

### 52.1 本轮唯一可用的工具：Google Books 页码探针（含对照实验）

卷 id **`mSD4DvUFa6QC`**（Springer 版 GTM 9），入口 `books.google.com/books?id=<VOL>&q=<短语>`。
**该入口不返回 snippet，只把阅读器跳到命中页**；判读规则本轮首次钉死：

| 查询 | 阅读器停在 | 判读 |
|---|---|---|
| **`"zzqxjkwmnbvpl"`（无意义串，对照）** | **Front Cover** | ✅ **无命中时停在封面，不停在内页** ⇒ 停在内页 = 真命中 |
| `"Maximal Toral Subalgebras and Roots"` | **p. 35** | 与 §50 的 `"Root Space Decomposition"` → p.35 **相互印证** |
| `"Corollary 8.2"` | **p. 38** | 新 |
| `"Proposition 8.3"` | **p. 38** | 新 |
| `"Harish-Chandra's Theorem"` | **p. 130** | 新 |
| `"Theorem 23.1"` | **p. 135** | 新；与 §50 的 `"Harish-Chandra"` → p.135 同页 |

**★ 对照实验是本轮方法论上的净收获**：§50 把 `"Generalities on characters"` 的"页面未交付结果区"
记为「不是无命中，是没拿到」——**现在知道这个判据可以做实**：无命中 ⇒ 封面。
⇒ **`"Generalities on characters"` 那次多半确实是"没拿到"，值得重试一次。**

### 52.2 由这批 L4 能得到与不能得到的（严格分开）

**能得到（升级为"有证据"）：**
1. **GTM 9 确实使用 `N.M` 形式的结果标号**（`Corollary 8.2`、`Proposition 8.3`、`Theorem 23.1` 三个字符串都在书里）。
   ⇒ §50 写的「不得写 `§23.x`」这条禁令的**理由要改**：不是"书里没有这种编号"，而是"我们不知道哪个号对应哪条陈述"。
2. **§8 的结果标号落在 p.38 一带**，而 §8 起于 p.35（两条独立查询印证），**且 §8 在 Ch. II (pp.15–41) 内**（§50.1，L1）。
3. **⚠ 任务书写的「§8 Thm 8.x」需要修正**：本轮命中的两个 §8 标号都**不是 Theorem**
   （是 `Corollary 8.2` 与 `Proposition 8.3`）。**在拿到正文前，不得写 "Humphreys Theorem 8.x"。**
4. **§23 一带的地标**：`"Invariant polynomial functions"` → p.126（§44.4）、
   `"Harish-Chandra's Theorem"` → **p.130**、`"Harish-Chandra"` 与 `"Theorem 23.1"` → **p.135**。

**不能得到（仍是 L0，禁止写进图）：**
1. **哪个标号对应"根空间分解"这条陈述**。`Corollary 8.2` 与 `Proposition 8.3` 同页命中，**无法分辨**。
2. **`Theorem 23.1` 在 p.135 是"定理本身"还是"交叉引用"**。
   Humphreys 的体例是按**小节**给结果编号（`8.3` = §8.3 里的那条），
   若 §23.1 在 p.126–130 一带，则 p.135 上的 `Theorem 23.1` **更像是从 §23.3 或 §24 回指的交叉引用**。
   **本轮无法分辨，因此 §50 的禁令原样保留：不得写 `Theorem 23.1` 作为来源。**
3. **§23 的标题与页范围**。`"Harish-Chandra's Theorem"`（p.130）可能是**小节标题**也可能只是正文里的一句话。
4. **任何逐字陈述**。Google Books 不回 snippet ⇒ **原文措辞永远是 L0**，这条路线天花板就在这里。

### 52.3 Q39 / Q50.1（Chevalley 限制定理）本轮无进展

§50.3 的裁决**不变且再次确认**：「GTM 9 §23 = Chevalley **限制**定理」这个等式**无来源**，
Humphreys 本人在 *Reflection Groups* p.56 的 Remark 说的是「由 Chevalley 定理**导出**关于 `Z(U(𝔤))` 的
Harish-Chandra 定理」，两者是**输入**与**输出**的关系。
本轮的 `"Harish-Chandra's Theorem"` → p.130 与该 Remark **一致**，
但**仍然不能推出「Chevalley 限制定理在 §23」**。

**⇒ 对 E₈ 卡的建议不变**（§44.7 / §50.4）：走「对 248 个权直接做幂和」，**绕开 Chevalley 限制定理**。

### 52.4 下一轮该怎么打（按性价比）

1. **有 `WebSearch` 时的第一枪**（连续两轮未执行）：
   `"Humphreys" "Introduction to Lie Algebras" pdf "root space decomposition"`、
   `site:edu "Humphreys" "Corollary 8.2"`、`"Humphreys, Theorem 23.3"`。
2. **DNB 出版方目录扫描**（`d-nb.info/<IDN>/04`）——**本轮仍未找到 GTM 9 的 IDN**，
   而该路线正是取"章节标题 + 印刷页码"最省事的方式（见 reading-list 备忘）。
   入口 `services.dnb.de/sru/dnb?version=1.1&operation=searchRetrieve&query=...` **本轮未试**（额度用在别处）。
3. **重试 `"Generalities on characters"`**（现在知道无命中会停在封面，判读不再含糊），
   再补 `"Characters and invariant polynomial functions"`、`"Theorem 23.3"`、`"Proposition 8.4"`。
   每条成本 1 次 fetch，可以把 §23 的小节边界夹逼出来。
4. **Mathlib 侧**（§50.4 的 Q50.4 仍未做）：读
   `Mathlib/Algebra/Lie/Weights/Cartan.lean` 里 `cartan_sup_iSup_rootSpace_eq_top` 的**完整签名**。
   **这是唯一一条可能让根空间分解节点标 `formalized` 的路，成本 1 次 raw 文件读**，
   而且**比继续追 Humphreys 的编号更值**——因为图里真正需要的是"有一条可引的严格陈述"，不是"Humphreys 的第几条"。

---

## 53. Ahlfors–Sario, *Riemann Surfaces*（1960）的登记（researcher，2026-09-11）

对应 `sources.bib` 新条目 `ahlfors-sario-1960`。**正文完全未获取（L0）**；本节记的是书目数据与
"Gallier–Xu 到底引了它的什么"。

### 53.1 ★ Gallier–Xu References **[1]** 逐字（出版版书 **p. 170**，L1 页图）

> "1. Lars V. Ahlfors and Leo Sario. *Riemann Surfaces*. **Princeton Math. Series, No. 2**. Princeton
> University Press, 1960."

**获取**：`https://www.cis.upenn.edu/~jean/surfclassif-root.pdf`（3.5 MB）→ `Read(pages=178-183)`；
**PDF 页 = 书页 + 10**（本轮再次验证：PDF 180 = 书 p.170）。

⚠⚠ **丛书号存疑**：GX 印 "No. 2"。Princeton Mathematical Series 到 1960 年早已过二十号，
**"No. 2" 极可能是 GX 的排印错误**。OpenLibrary 检索（L2）确认
「Lars Valerian Ahlfors / Leo Sario, *Riemann surfaces*, Princeton University Press, 1960, 约 398 页」，
**但 `series` 字段为空** ⇒ **本项目没有第二来源可核丛书号**。
⇒ **bib 里刻意不写 `number`；引用时只写 "Princeton Mathematical Series"。**

### 53.2 ★★ Note F.9（书 **p. 169**，L1 逐字）——**GX 唯一一处交代 A–S 内部结构的地方**

> "*Note F.9.* For the benefit of the reader, we compare the proof given here (due to Ahlfors and Sario [1]) to
> other proofs, in particular, the proof given in Seifert and Threlfall [9] (**Chapter VI**). The first point is
> that **Ahlfors and Sario's proof applies to surfaces with boundaries** whereas Seifert and Threlfall first give
> a proof for surfaces without boundaries in **Section 38** and then they show how to modify this proof to deal
> with boundaries in **Section 40**. As we said earlier, Ahlfors and Sario use the same elementary transformations
> as Seifert and Threlfall. Unlike Seifert and Threlfall, who begin by gluing cells sharing a common edge using
> `(P2)^{−1}` to obtain a complex with a single cell (their Step 1), Ahlfors and Sario reduce the complex to a
> single cell at the beginning of their **Step 3**. **Step 1** of Ahlfors and Sario (eliminating strings `aa^{−1}`)
> is identical to Step 2 of Seifert and Threlfall. **Step 2** of Ahlfors and Sario (reduction to a single vertex)
> is similar to Step 3 of Seifert and Threlfall, except that Ahlfors and Sario deal with border vertices.
> **Step 3** of Ahlfors and Sario (cross-cap introduction) is analogous to Step 4 of Seifert and Threlfall and also
> preserves loops. **Step 4** of Ahlfors and Sario (handle introduction) is analogous to Step 5 of Seifert and
> Threlfall and also preserves loops. **Step 5** of Ahlfors and Sario (transformation of handles into cross-caps)
> is analogous to Step 6 of Seifert and Threlfall. Finally, **Step 6** of Ahlfors and Sario consists in grouping
> loops together. This step is achieved by Seifert and Threlfall in **Section 40**."

**★★ 由此得到的三条硬结论：**

1. **GX 的 `Lemma 6.1` 的六个 Step（§49.3 已逐字记）就是 Ahlfors–Sario 自己的 Step 1–6。**
   两侧的对应是逐 Step 的，`loc` 可以写成「A–S 的 Step `k`」，**但页码/节号仍然未知**。
2. **⚠ 任务书要的「Gallier–Xu 引用的章节号」：对 Ahlfors–Sario 而言不存在。**
   GX 在**三处**（References [1]、Prop 6.1 证明末、Lemma 6.1 证明首句）**以及 Note F.9 全段**里，
   **从不给 A–S 的章号、节号或定理号**；给节号的只有对照组 **Seifert–Threlfall [9]：Chapter VI, Section 38 / Section 40**。
3. **A–S 的证明覆盖带边曲面**（GX 逐字），这正是图里 `math.classification-of-compact-surfaces`
   需要「含带边」版本的那一支的**真正出处**。

### 53.3 ★ 副产品：GX References 全表（书 p.170，L1 逐字，9 条）——**两条对图有直接价值**

> 1. Lars V. Ahlfors and Leo Sario. *Riemann Surfaces*. Princeton Math. Series, No. 2. Princeton University Press, 1960.
> 2. Henry Roy Brahana. Systems of circuits on two-dimensional manifolds. *The Annals of Mathematics*, **23**(2):144–168, 1921.
> 3. Glen E Bredon. *Topology and Geometry*. GTM No. 139. Springer Verlag, first edition, 1993.
> 4. Maurice Fréchet and Ky Fan. *Invitation to Combinatorial Topology*. Dover, first edition, 2003.
> 5. D. Hilbert and S. Cohn–Vossen. *Anschauliche Geometrie*. Springer Verlag, second edition, 1996.
> 6. D. Hilbert and S. Cohn–Vossen. *Geometry and the Imagination*. Chelsea Publishing Co., 1952.
> 7. William S. Massey. *Algebraic Topology: An Introduction*. GTM No. 56. Springer Verlag, second edition, 1987.
> 8. James R. Munkres. *Elements of Algebraic Topology*. Addison-Wesley, first edition, 1984.
> 9. H. Seifert and W. Threlfall. *A Textbook of Topology*. Academic Press, first edition, 1980.

- **[9] Seifert–Threlfall** 是**第二个可登记的候选一手来源**：GX 明确指出它的分类定理证明在
  **Chapter VI, Section 38（无边）+ Section 40（带边）** —— **这是本项目目前唯一一条"带节号"的分类定理证明位置**，
  比 A–S 那条更可引。**建议 lead 考虑把它排进 reading-list。**
- **[7] Massey 是 GTM 56 第 2 版 1987**，**不是** `sources.bib` 里登记的 `massey-1967`
  （Harcourt/Brace 1967 初版）。**§39.3 的跨版本风险由此再获一条 L1 佐证**：
  GX 的 `Theorem 6.2` 一带若转引 Massey，转引的是**第 2 版**的编号。
- **[2] Brahana 1921** 是 GX 正文（Note F.9 续，书 p.170）指认的「切割法 (P2) 的最早出处」，
  并说 Brahana 自陈方法源自 **Veblen 1915 年的一次 Seminar**；且 **Brahana 只处理无边曲面**。
  ⇒ 若图里要"分类定理的最早证明"这条历史边，这是 L1 的转述来源。

### 53.4 本节访问日志与未解决

| 目标 | URL | 结果 |
|---|---|---|
| GX 出版版全书 | `www.cis.upenn.edu/~jean/surfclassif-root.pdf` | ✅ 3.5 MB；读 PDF pp.178–183 = 书 pp.168–173 |
| A–S 书目（第二来源） | `openlibrary.org/search.json?q=Ahlfors+Sario+Riemann+Surfaces&fields=…` | ✅ L2：1960 / PUP / 约 398 页；**series 为空** |

- **Q53.1** **丛书号**：GX 印 "No. 2"，真值未知。取一次 PUP 目录或书本身即可结清。
- **Q53.2** **A–S 的 Step 1–6 在书里的页码/节号**——**要正文才能拿到**。
  A–S 1960 无 arXiv、无 DOI；archive.org 是否有开放扫描**本轮未查**（`WebSearch` 额度耗尽）。
- **Q53.3** **Seifert–Threlfall *A Textbook of Topology*（Academic Press 1980，Ch. VI §38/§40）未登记**。
  它有节号、有英译本，**比 A–S 更可能取到**，建议下一轮优先。




