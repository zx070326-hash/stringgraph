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

## 15. 需求侧：两条**长得很像但不同**的陈述，绝不能混

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

即 **(V) 与「Vir 是万有的」在特征零下互为等价说法**（见 §19）。图里可以只立一条节点承载 (V)，
在 statement 里把「等价于万有性」写进去。

**还有第三条，别顺手推广**：`H²` 消失**不**沿维数继续。
Ecker–Schlichenmaier 明确算出 `dim H³(Vir, K) = 1`、`dim H³(Vir, Vir) = 1`（见 §18）。
所以任何形如「Vir 的上同调都是平凡的」的措辞都是错的。

**与 FGZ 的对接（供 curator/auditor 判，researcher 不代判）**：
按 `brst-cohomology-sources.md` §1.2 的 L1 记录，FGZ 的假设句逐字是
「From this point on we will assume that **H²(g) = 0** and that ω₀ and β are fixed in such a way that γ = 0」，
且 Prop 1.1(ii) 是「γ 代表 **H²(g)** 的平凡类时可取 γ ≡ 0」——**γ 是标量 2-上循环**，
所以 FGZ 的 `H²(g)` 读作「以平凡模为系数的李代数二阶上同调」是自然的，
本节找到的正是这个群。**但「FGZ 的 g 在 §2 里到底是 Vir（含中心）还是 Witt」我没有重新读 FGZ 原文核实**，
这一步的对接留给 curator/auditor。

---

## 16. ★★ 首选（L1 全文到手）：Feldvoss & Siciliano, *Lie algebras whose derivation algebras are simple*, arXiv:2501.15560

### 16.0 文献标识

| 项 | 值 | 等级 |
|---|---|---|
| 作者 | Jörg Feldvoss（University of South Alabama）、Salvatore Siciliano（Università del Salento） | L1（首页 + 末页地址栏） |
| 标题 | *Lie algebras whose derivation algebras are simple* | L1（首页） |
| arXiv | **2501.15560**，v1，`[math.RA]`，**26 Jan 2025**；正文首页脚注「Date: January 26, 2025.」 | L1（页边 arXiv 戳） |
| 篇幅 | 13 页（正文 1–12，参考文献 12–13，共 32 条） | L1 |
| MSC | Primary 17B05；Secondary 17B40, 17B56, 17B20, 17B25, 17B50, 17B65, 17B66, 17B68 | L1 |
| 期刊发表 | **未核实（L0）**。arXiv abs 页无 journal-ref；本轮检索未找到期刊版。 | L0 |

> ⚠ **这是一篇 arXiv 预印本，本轮没能确认是否已被期刊接受。** 引用时应在 note 里写明。
> 好消息是它引用的两条更老的来源（§17、§18）可以互相背书，所以不是孤证。

### 16.1 ★★★ **Lemma 2.6**（书上 p.7，L1 逐字）——**就是图里要的那条**

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
- **注意「perfect ⇒ H¹ = 0」这一步在正文里是当作已知用的**（`H¹(L,𝔽) ≅ (L/[L,L])*`，见 §18 里
  Ecker–Schlichenmaier §3.3.2 的显式公式）。
- 证据等级：**L1**

**配套的 Corollary 2.7（书上 p.7，L1 逐字）**，顺带解决「还有没有别的覆盖代数」这个问题：

> **Corollary 2.7.** *Let* `𝔽` *be a field of characteristic zero. Then* `𝒲` *and the Virasoro algebra* `𝒱`
> *are the only covering algebras of the two-sided Witt algebra* `𝒲` *up to isomorphism.*

### 16.2 ★ 同文提供的一般定理链（书上 p.4–p.5，L1 逐字）——这是 §19 的证据来源

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

其中 **[31] = Weibel**、**[4] = Block 1968**（参考文献逐字见 §16.4）。
另有 **Lemma 2.2**（`L` 完美 ⇒ `L` 的万有中心扩张也是 `L` 的每个覆盖代数的万有中心扩张）与
**Corollary 2.3**（`dim Ĉ = 1` 时 `L` 与 `L̂` 是 `L` 的唯一两个覆盖代数），**Remark 3.4(2)** 里还有
（p.10，L1 逐字）「`Ĉ` is isomorphic to `H₂(𝔤, 𝔽)`, the second homology space of `𝔤` with coefficients in the
trivial module `𝔽` (see, e.g., **[31, Theorem 7.9.2]**)」——即 **Weibel Thm 7.9.2 同时含「iff 完美」与「核 ≅ H₂」两件事**。

### 16.3 ⚠ 三个必须随引用一起写的陷阱

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
   | Schottenloher Def 5.2（§20） | `[L_n,L_m] = (n−m)L_{n+m} + δ_{n+m}(n/12)(n²−1) Z` |
   | Ecker–Schlichenmaier（§18） | `[ê_n,ê_m] = (m−n)ê_{n+m} − (1/12)(n³−n) δ_n^{−m} t` |

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

### 16.4 由本文参考文献 L1 抄下的关键条目（供 `sources.bib`）

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
> 而 `sources.bib` 里登记的 `kac-raina-1987` 是**第一版**。见 §21.2。

---

## 17. ★ 第二来源（L1 全文到手）：Schlichenmaier, Forum Math. **26** (2014) 913–929 = arXiv:1111.6625

### 17.0 文献标识与**版本陷阱（必读）**

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
> 与 Gui 讲义（§8.0）、Kac–Raina（§21.2）同类的坑。**引用时 `loc` 必须写死「arXiv:1111.6625v4」。**

### 17.1 ★★ **Remark 6.4** 逐字（arXiv v4 书上 p.13，L1）——`H²(𝒱; 𝕂) = {0}` 在这里被明写

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

### 17.2 它是怎么被证出来的：**`H²(𝒱;𝕂) = 0` 在本文里是「副产品」，不是主定理**

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

## 18. ★ 第三来源（L1 全文到手）：Ecker & Schlichenmaier, arXiv:1707.06106v2 —— **完整的低维上同调总表，但无编号**

### 18.0 文献标识

| 项 | 值 | 等级 |
|---|---|---|
| 作者 | Jill Ecker、Martin Schlichenmaier（both University of Luxembourg） | L1 |
| 标题 | *The vanishing of the low-dimensional cohomology of the Witt and the Virasoro algebra* | L1（首页） |
| arXiv | **1707.06106v2**，26 页；页边戳「26 Mar 2018」；正文脚注「Date: v1: 19.07.2017; v2: 31.01.2018.」 | L1 |
| MSC | Primary 17B56；Secondary 17B68, 17B65, 17B66, 14D15, 81R10, 81T40 | L1 |
| 期刊发表 | **未核实（L0）** | L0 |

### 18.1 §5.1 的总表（书上 p.18–19，L1 逐字）——**`H²(𝒱, 𝕂) = {0}` 在这里，但是无编号的显示式**

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
并把 `H²(𝒱,𝕂) = {0}` 明确**归属**给 Schlichenmaier [31]（= §17 那篇）。
**但它是 summary 小节里的显示式，没有编号**，所以图里 `loc` 只能写「arXiv:1707.06106v2, §5.1, p.19」。

### 18.2 同文可引的**带编号**结果（L1 逐字，登记备用）

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

### 18.3 同文给出的**一般解释公式**（书上 p.5，§3.3.2，L1 逐字）——图里 (V) ⇔ 完美性那一步的来源

> `H¹(𝓛, 𝕂) = (𝓛 / [𝓛, 𝓛])^*` &nbsp;&nbsp; and &nbsp;&nbsp; `H¹(𝓛, 𝓛) = Der(𝓛)/ad_𝓛 = Out(𝓛)`

> **3.3.3. Second cohomology.** The second cohomology group `H²(𝓛, 𝕂)` with values in the trivial module
> **classifies central extensions of** `𝓛` **up to equivalence.**
> The second cohomology group `H²(𝓛, 𝓛)` with values in the adjoint module classifies infinitesimal deformations
> of `𝓛` modulo equivalent deformations. …

**即：`H¹(𝓛,𝕂) = 0 ⇔ 𝓛 完美`，和「`H²(𝓛,𝕂)` 分类中心扩张」这两条解释，
本文用无编号的显示式给出（p.5）。带编号的同类陈述在 Schottenloher 那边是 Remark 4.7（见 §20.1）。**

### 18.4 顺带核实的历史归属（L1，书上 p.1–p.3, p.6）

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

## 19. 一般定理链：Weibel §7.9 与 Block 1968

### 19.1 编号核实状况

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

**内容的证据（L3）**：**Feldvoss–Siciliano p.5 与 p.10 逐字引用**（见 §16.2）。
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

### 19.2 Block 1968

- **R. E. Block, *On the extensions of Lie algebras*, Canad. J. Math. 20 (1968), 1439–1450**（元数据 L1 抄自
  Feldvoss–Siciliano 参考文献 [4]；**未与出版方交叉核对**）。
- 被引用的编号是 **Lemma 3.1**（Feldvoss–Siciliano p.5、p.6、p.8 三处），**内容未核实（L0）**。
- 同文另引 **[4, Theorem 5.1]**（char p > 3 的每个 Zassenhaus 代数 `W(1,n)` 有唯一非分裂中心扩张）——char p，与本节无关。

---

## 20. ★ Schottenloher 第 4、5 章：**已 L1 核实，且是干净的否定结论**

> **这一节把 `sources.bib` 里 `schottenloher-2008` 的「其余章节编号仍未核实」限制，对第 4、5 章一并解除。**
> 获取途径与 §11.0 同一套：作者本人 LMU 主页按章挂 PDF
> `https://www.mathematik.uni-muenchen.de/~schotten/LNP-cft-pdf/0{4,5}_978-3-540-68625-5_Ch0{4,5}_23-08-08.pdf`
> （WebFetch 落盘 → `Read` 带 `pages` 读图）。**PDF 页码 = 书上页码 − 62（Ch.4）/ − 74（Ch.5）。**

### 20.1 第 4 章「Central Extensions of Lie Algebras and Bargmann's Theorem」（LNP 759, pp. **63–73**，L1）

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

### 20.2 第 5 章「The Virasoro Algebra」（LNP 759, pp. **75–85**，L1）—— **没有 H²(Vir) = 0**

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

### 20.3 副产品：`worldsheet.virasoro-unique-central-extension` 的 loc 现在可以写死

该节点现有 `sources` 里 `schottenloher-2008` 的 loc 是「相关章节，编号未核实」。**现在可以改成**：

```yaml
- ref: schottenloher-2008
  loc: "Ch. 5 (The Virasoro Algebra), Theorem 5.1 (H^2(W, C) ≅ C), p. 79；
        Virasoro 代数的定义见 Definition 5.2, p. 82；
        『中心扩张等价类 ↔ H^2』见 Ch. 4, Remark 4.7, p. 69"
```

**另外一条对该节点的实质补充**：Schottenloher 把 Theorem 5.1 归给 **[GF68] = Gelfand–Fuks (1968)**，
而节点现在的三个来源（`virasoro-lean-2025` / `schottenloher-2008` / `kac-raina-1987`）里**没有原始出处**。
建议加 `gelfand-fuks-1968`（见 §21.4 的元数据分歧）。

---

## 21. 任务书点名的四个候选：逐条结算（三个 L0、一个否定）

### 21.1 Fuks, *Cohomology of Infinite-Dimensional Lie Algebras* (1986) —— **L0，且任务书猜的 §2.3 是别的定理**

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
  「内部 ℤ-分次李代数的上同调只在零次数非零」这条（那是 §18 里 (3a)/(3b) 的出处），
  **不是** `H²(Vir)` 本身。

### 21.2 Kac–Raina *Bombay Lectures* —— **L0，且两篇独立文献引的都是 2013 第二版、且只覆盖 Witt 侧**

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

### 21.3 Iohara & Koga, *Representation Theory of the Virasoro Algebra* (2011) —— **L0，Springer 认证墙**

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

### 21.4 Kytölä arXiv:2510.21741 —— **确定的否定：没有 Vir perfect，也没有 H²(Vir) = 0**

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

## 22. 图里建议怎么加（供 curator 取舍；researcher 不改 `graph/`）

### 22.1 新陈述节点

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

### 22.2 把它接到 `brst-nilpotent-at-c26--via-fgz`

`worldsheet.brst-nilpotent-at-c26--via-fgz` 的 `depends_on` 加一条
`- id: math.virasoro-universal-central-extension`，并把现有 `gaps` 里
「**本图中没有 H²(Vir, C) = 0 的节点**，本推导对这一步无任何来源支撑」这句改掉。

**但 gaps 不能整条删**，还剩两个未闭合的点（**这是本轮的诚实结论**）：
1. **FGZ 的 `g` 在 §2 里是否就是 `Vir`（含中心）、其 `H²(g)` 是否就是平凡系数的李代数 `H²`**——
   我没有重读 FGZ 原文，只依据 `brst-cohomology-sources.md` §1.2 的 L1 摘录做了合理性判断（见 §15 末）。
   这一步**必须标 `inferred: true`**，note 写「FGZ 不引任何数学文献来支撑 H²(g) = 0；
   两边没有互引；`g` 的确切身份未在本项目内核实」。
2. **`γ = 0` 那一半仍无来源。** FGZ 的假设是**两条**：`H²(g) = 0` **且**「ω₀ 与 β 取得使 `γ = 0`」。
   本节只解决了第一条。第二条按 FGZ Prop 1.1(ii) 是「γ 代表 H²(g) 的平凡类时可取 γ ≡ 0」，
   所以形式上第一条**应当**蕴含第二条——但这是我的推断，不是文献明说，
   **也要标 `inferred: true`**。

### 22.3 三条给 curator 的硬性提示

1. **`uses_conventions` 建议留空或只挂 note。** 四份来源的 Virasoro 括号写法各不相同（§16.3 的表），
   但 `H²(Vir, k) = 0` 对同构不变，**结论与约定无关**。
   如果非要挂 `conv.virasoro-standard`，请在 note 里写明「来源用的是别的符号约定，结论不受影响」，
   **不要**把任何一份来源的括号式抄进 statement。
2. **不要与 `worldsheet.virasoro-unique-central-extension` 合并，也不要让其中一个依赖另一个「就因为都叫中心扩张」。**
   两者是不同李代数的不同上同调群（§15）。真正的依赖方向是：
   「Vir 是 W 的万有中心扩张」这个**推论**同时用到两者，而 `H²(Vir,k) = 0` 本身不依赖 `dim H²(W,k) = 1`
   ——不过**已核实的那个证明确实用到了它**（Feldvoss–Siciliano Lemma 2.6 的证明引
   `H¹(𝒲,𝔽) = 0` 与 `dim H²(𝒲,𝔽) = 1`）。所以**推导节点里挂这条依赖是对的，陈述节点里不要写成前提**。
3. **area 用 `math`（已有 `math.witt-algebra`），不要放 `worldsheet`。** 这条与弦论无关。
   建议与 `laplacian-log-contact-term`、`math.formal-distribution-locality` 等归到同一个
   「物理书不给数学来源」的 family（见 §13.2 补充建议 3）。

### 22.4 三条禁令

1. **不得引 `feldvoss-siciliano-2025, Lemma 2.4`** —— 那是 char p > 3 的**受限** Virasoro 代数（§16.3-1）。
   要引 **Lemma 2.6**。
2. **不得写「Schlichenmaier, Theorem: H²(Vir, ℂ) = 0」** —— 那篇没有这样一条编号定理；
   `H²(𝒱;𝕂) = {0}` 只在 **Remark 6.4** 里被明写，且那篇的标题/主定理是 **adjoint 模**（§17.2）。
3. **不得引 Schottenloher、Kac–Raina、Iohara–Koga、Kytölä 支撑这条节点** ——
   前者通读无此陈述（§20.2），后三者本轮 L0 / 否定（§21）。

---

## 23. 访问日志与未解决问题（本节）

### 23.1 访问日志

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

### 23.2 未解决 / 留给下一轮

- **Q14** **Weibel Theorem 7.9.2 / Lemma 7.9.3 的正文措辞（L0）**，以及 `Corollary 7.9.5`（L4）。
  需要持原书者抄三句即可结案。**顺带需要 lead 裁决**：挂在 `sas.rochester.edu` 大学域名下的
  Weibel 全本 PDF 是否属于本项目规则 1 排除的「非官方全本扫描」（§19.1 限制 1）。
- **Q15** **Block, *On the extensions of Lie algebras*, Canad. J. Math. 20 (1968), Lemma 3.1 的内容（L0）。**
  CJM 老卷在 Cambridge Core 上，可能有开放存取。
- **Q16** **Feldvoss–Siciliano arXiv:2501.15560 是否已被期刊接受（L0）。**
  若已发表，编号可能变；`loc` 现在写死的是 v1。
- **Q17** **Schlichenmaier 的期刊版（Forum Math. 26 (2014) 913–929）编号是否与 arXiv v4 一致（L0）。**
  这是本节唯一一条「已发表的第二来源」，值得把编号钉死。
- **Q18** Ecker–Schlichenmaier arXiv:1707.06106 是否已发表（L0）。
- **Q19** Iohara–Koga 第 1 章：它是**证明**了 `H²(Vir) = 0`，还是把万有性当**定义**？（§21.3）
  这个区别对图很重要。需要能进 Springer 的人看一眼。
- **Q20** Fuks (1986) 里「内部 ℤ-分次李代数的上同调只在零次数非零」这条的**编号**（§21.1）。
  它是 Ecker–Schlichenmaier (3a)/(3b) 的出处，将来若给 `math.witt-algebra` 那一支建节点会用到。
- **Q21** Neher, *An introduction to universal central extensions of Lie superalgebras*
  （Math. Appl. 555, Kluwer 2003, pp. 141–166）与 Garland, IHES Publ. Math. 52 (1980), **Definition 1.4/1.6**
  ——Feldvoss–Siciliano 用它们定义「covering algebra / universal covering algebra」。
  若图里要立「万有中心扩张」的一般定义节点，这两条是候选来源；**本轮未查**。
- **Q22** `Vect(S¹)` 的连续上同调（Gelfand–Fuks / Goncharova / Reshetnikov / Tsujishita）与
  Witt/Vir 的**代数**上同调之间那条「稠密性论证不成立」的沟（§18.4）。
  这与 §13.3 的「弦论那个具体理论满足假设」是同一类缺口，值得单独立节点。
