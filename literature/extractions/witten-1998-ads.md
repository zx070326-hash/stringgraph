# 抽取记录：witten-1998-ads

- 文献：E. Witten, "Anti De Sitter Space And Holography", hep-th/9802150; Adv. Theor. Math. Phys. 2 (1998) 253-291.
- 抽取者：researcher agent
- 日期：2026-09-11
- 覆盖范围：§1–§2 完整，§3–§4 见下（arXiv v2，40 页）

## §0 元信息与约定

**证据等级说明**：本文件所有带式号的条目均为 **L1**（arXiv **v2** PDF 逐页读图一手核实），除非条目内另行标注。

- arXiv 版本：**v1 1998-02-20；v2 1998-04-06**（comments: "40 pp.; **additional references and assorted corrections**"）。本次读的是 **v2**（侧边栏印 `arXiv:hep-th/9802150v2 6 Apr 1998`）。**引式号必须写死 v2**——v2 注记明说有 "assorted corrections"，比 GKP 的 "minor revisions" 风险更高。
- 报告号：**IASSNS-HEP-98-15**（印在第一页页眉，arXiv abs 页的 report-no 字段为空）。
- 发表版：Adv. Theor. Math. Phys. **2** (1998) 253–291。封面日期 "February, 1998"。
- 标题页无独立 "Abstract" 字样，摘要直接排在作者信息下方。

### 约定（原文自己声明的）

- **主体是欧氏号差**。§2.1 逐字："So far we have assumed Lorentz signature, but the identification of the boundary of `AdS_{d+1}` with `d`-dimensional Minkowski space holds also with Euclidean signature, and **it will be convenient to formulate the present paper in a Euclidean language**."
- 欧氏 AdS_{d+1} = 开单位球 `B_{d+1} ⊂ R^{d+1}`，度规 `ds² = 4Σ_{i=0}^{d} dy_i² / (1 − |y|²)²`（式 **(2.1)**）；紧化后 `B̄_{d+1}`，边界是 **`S^d`**。
- 等价表示：`ds² = dy² + sinh²y dΩ²`（式 **(2.5)**，边界在 `y = ∞`）；上半空间 `ds² = (1/x₀²) Σ_{i=0}^{d} (dx^i)²`（式 **(2.6)**，边界在 `x₀ = 0` 加无穷远一点 `P`）。
- **AdS 半径设为 1**（式 (2.1)(2.6) 中无 `R`）。因此本文的 `m²` 是**无量纲化过的** `(mR)²`。这一点原文没有专门声明，但从式 (2.1)(2.6) 直接可见。→ 与 GKP 的 `(mR)²` 对照时必须补回 `R`。
- Lorentz 号差（§1 用）：`η_ij` 号差 `−+ + … +`（式 (1.1) 后逐字）。
- 规范群：**`SU(N)`**（p.1 逐字 "N = 4 super Yang-Mills theory in four dimensions, with gauge group `SU(N)` and coupling constant `g_YM`"）。**与 Maldacena 原文的 `U(N)` 不同**，见 §4-QW5。
- 曲率半径：`(g²_YM N)^{1/4}`（p.1，弦单位）；`g_st ∝ g²_YM`。

## §1 主张强度（原文逐字）

| 措辞 | 位置 | 逐字 |
|---|---|---|
| **proposed by Maldacena**（转述他人） | 摘要首句 | "Recently, it has been **proposed by Maldacena** that large `N` limits of certain conformal field theories in `d` dimensions can be described in terms of supergravity (and string theory) on the product of `d+1`-dimensional `AdS` space with a compact manifold." |
| **elaborate / propose a precise correspondence** | 摘要 | "Here we **elaborate on this idea** and **propose a precise correspondence** between conformal field theory observables and those of supergravity: correlation functions in conformal field theory are given by the dependence of the supergravity action on the asymptotic behavior at infinity." |
| **quantitative confirmation** | 摘要 | "As **quantitative confirmation** of this correspondence, we note that the Kaluza-Klein modes of Type IIB supergravity on `AdS₅×S⁵` match with the chiral operators of `N = 4` super Yang-Mills theory in four dimensions." |
| **with some further assumptions** | 摘要末 | "**With some further assumptions**, one can deduce a Hamiltonian version of the correspondence and show that the `N = 4` theory has a large `N` phase transition related to the thermodynamics of `AdS` black holes." |
| **a remarkable suggestion** | p.1 | "Maldacena has made [13] **a remarkable suggestion** concerning the large `N` limit not of conventional `SU(N)` gauge theories but of some of their conformally invariant cousins. **According to this proposal**, …" |
| **conjecturally is equivalent** | p.1 | "This theory **conjecturally is equivalent** to Type IIB superstring theory on `AdS₅ × S⁵` …" |
| **the hope is that** | p.1 | "So **the hope is that** for large `N` and large `x`, the `N = 4` theory in four dimensions is governed by the tree approximation to supergravity." |
| ★ **make more precise the conjecture** | p.8 §2.3 首句 | "**We will now attempt to make more precise the conjecture [13]** relating field theory on the boundary of `AdS` space to supergravity (and string theory) in bulk." |
| ★ **ansatz** | §2.3 标题与正文；式 (2.11) 前导句 | 小节标题 "**2.3. Ansatz For The Effective Action**"；"**We will make an ansatz** whose justification, **initially**, is that it combines the ingredients at hand **in the most natural way**. **Gradually, further evidence for the ansatz will emerge**."；"**Our ansatz** for the precise relation of conformal field theory on the boundary to `AdS` space is that" → (2.11) |
| **our proposal** / **the proposal is effective** | p.2 | "A **precise recipe** for computing observables of the conformal field theory in terms of supergravity on `AdS_{d+1}` **was not given in [13]**; obtaining one will be the goal of the present paper. **Our proposal is that** correlation functions in conformal field theory are given by the dependence of the supergravity action on the asymptotic behavior at infinity. A special case of the proposal is that dimensions of operators in the conformal field theory are determined by masses of particles in string theory. **The proposal is effective**, and gives a practical recipe …" |
| **we will assume** | p.8 | "We will **assume** that in the correspondence between `AdS_{d+1}` and conformal field theory on the boundary, `φ₀` should be considered to couple to a conformal field `O`, via a coupling `∫_{S^d} φ₀ O`. **This assumption is natural** given the relation of the conjectured `CFT/AdS` correspondence to analyses [8–11] of interactions of fields with branes." |

**关键判定**：
1. Witten 对**自己的**核心式 (2.11) 的自称是 **"ansatz"**（小节标题 + 正文两处），并明说其最初的辩护只是"把手头材料以最自然的方式组合起来"。这**弱于** "proposal"，且**不是** "theorem"、也**不是**他自己的 "conjecture"。
2. Witten 对**Maldacena 的**主张一律称 **conjecture / proposal / suggestion / conjecturally equivalent**——即他明确把对偶本身当猜想。
3. **★ 与 GKP 的决定性措辞差别**：Witten 逐字写 "We will now attempt to **make more precise the conjecture [13]**"（p.8）与 "A precise recipe … **was not given in [13]**; obtaining one will be the goal of the present paper"（p.2）。**这是原文层面的"精确化"自我定位**。GKP 没有任何对应措辞（见 gubser-klebanov-polyakov-1998.md E13）。

## §2 陈述抽取

### E-W1 共形边界与 SO(2,d) 匹配（本文对"为什么是全息"的论证）
- 位置：p.1 末 – p.2 首；式 **(1.1)(1.2)**；p.4。
- 类型：proposition（几何事实 + 论证）
- 原文逐字（p.1–2）：
  > "As we describe below, the boundary `M_d` of `AdS_{d+1}` is in fact a copy of `d`-dimensional Minkowski space (with some points at infinity added); the symmetry group `SO(2,d)` of `AdS_{d+1}` acts on `M_d` as the conformal group. The fact that `SO(2,d)` acts on `AdS_{d+1}` as a group of **ordinary** symmetries and on `M_d` as a group of **conformal** symmetries means that there are two ways to get a physical theory with `SO(2,d)` symmetry: in a relativistic field theory (with or without gravity) on `AdS_{d+1}`, or in a conformal field theory on `M_d`."
- 具体构造（式 (1.1)(1.2)，逐字）：
  > "A compactification on which `SO(2,d)` does act is the 'quadric,' described by coordinates `u, v, x¹, …, x^d`, obeying an equation"
  >
  > `uv − Σ_{i,j} η_{ij} x^i x^j = 0,`  (1.1)
  >
  > "and subject to an overall scaling equivalence (`u → su`, `v → sv`, `x^i → sx^i`, with real non-zero `s`)."
  >
  > "`AdS_{d+1}` can be described by the same coordinates `u, v, x^i` but with a scaling equivalence only under an overall sign change for all variables, and with (1.1) replaced by"
  >
  > `uv − Σ_{i,j} η_{ij} x^i x^j = 1.`  (1.2)
- 拓扑（逐字）："The compactification (1.1) is topologically `(S¹ × S^{d−1})/Z₂` … and has closed timelike curves, so one may prefer to replace it by its universal cover, which is topologically `S^{d−1} × R`."
- **★ 唯一性论证（p.4 逐字，本文最关键的一句"匹配"陈述）**：
  > "According to [13], an `N = 4` theory formulated on `M₄` is equivalent to Type IIB string theory on `AdS₅ × S⁵`. We can certainly identify the `M₄` in question with the boundary of `AdS₅`; **indeed this is the only possible `SO(2,4)`-invariant relation between these two spaces**. The correspondence between `N = 4` on `M₄` and Type IIB on `AdS₅ × S⁵` therefore expresses a string theory on `AdS₅ × S⁵` in terms of a theory on the boundary. **This correspondence is thus 'holographic,'** in the sense of [32,33]."
- 文献自称的严格程度："this is the only possible `SO(2,4)`-invariant relation" —— **断言，无证明**（原文没有给对称性分类的论证）。
- 备注：欧氏版本里边界是 `S^d`，且只有**共形结构**不是度规——式 (2.2)(2.3)(2.4) 逐字：
  > `d s̃² = f² ds²` (2.2)；`f → f e^w` (2.3)；`d s̃² → e^{2w} d s̃²` (2.4)
  > "Thus, while `AdS_{d+1}` has (in its Euclidean version) a metric invariant under `SO(1, d+1)`, **the boundary `S^d` has only a conformal structure**, which is preserved by the action of `SO(1, d+1)`."
  脚注 3 逐字："This construction is the basic idea of **Penrose's** method of compactifying spacetime by introducing conformal infinity; see [39]."

### E-W2 边界值问题的存在唯一性（本文自己给的证明）
- 位置：§2.2，p.6–7，式 **(2.7)(2.8)(2.9)**。
- 类型：proposition（**这是全文里唯一自称给出证明的部分**）
- 原文逐字：
  > "A basic fact about `AdS_{d+1}` is that given any function `φ(Ω)` on the boundary `S^d`, there is a **unique** extension of `φ` to a function on `B̄_{d+1}` that has the given boundary values and obeys the field equation. Uniqueness depends on the fact that there is no nonzero square-integrable solution of the Laplace equation … This is true because given a square-integrable solution, one would have by integration by parts"
  >
  > `0 = −∫_{B_{d+1}} d^{d+1}y √g φ D_i D^i φ = ∫_{B_{d+1}} d⁵y √g |dφ|²,`  (2.7)
  >
  > "so that `dφ = 0` and hence (for square-integrability) `φ = 0`."
  > …（(2.8) 是 `B_{d+1}` 上的 Laplace 方程；(2.9) `(d/dy) e^{dy} (d/dy) φ_α = 0`，两解 `φ_α ∼ 1` 与 `φ_α ∼ e^{−dy}`）…
  > "So for every partial wave, one gets a unique solution of the Laplace equation with a given constant value at infinity; adding these up with suitable coefficients, one gets a unique solution of the Laplace equation with any desired limiting value `φ(Ω)` at infinity."
- **原文自陈的适用范围（逐字）**："In section 2.4, we give an alternative proof of existence of `φ` based on an integral formula. This requires the explicit form of the metric on `B_{d+1}` **while the proof we have given is valid for any spherically symmetric metric with a double pole on the boundary**. (With a little more effort, one can make the proof **without assuming spherical symmetry**.)"
- **★ 印刷错误（原文如此）**：式 (2.7) 右端积分测度印作 **`d⁵y`**，左端是 `d^{d+1}y`。按上下文应为 `d^{d+1}y`。**转成节点时不要照抄 `d⁵y`。**（v2 仍有此错。）
- 备注：这条是 GKPW 字典里"体内解存在唯一"的原始严格论证，比 GKP 的一句话（GKP E4）强。

### E-W3 引力与 Yang-Mills 情形：Graham–Lee 定理与 YM 的缺口
- 位置：§2.2，p.7，脚注 4。
- 类型：引用他处定理 + 自列缺口
- 原文逐字（引力）：
  > "Conversely, **by a theorem of Graham and Lee [42]** (see [43–46] for earlier mathematical work), any conformal structure on `S^d` that is **sufficiently close to the standard one** arises, by the procedure in (2.2), from a **unique** metric on `B_{d+1}` that obeys the Einstein equations with negative cosmological constant and has a double pole at the boundary. (Uniqueness of course means uniqueness up to diffeomorphism.) This is proved by first showing existence and uniqueness at the linearized level … and then going to small but finite perturbations via an implicit function argument."
- 原文逐字（Yang–Mills，**明确是猜想不是定理**）：
  > "**One expects an analog** of the Graham-Lee theorem stating that any `A` on `S^d` that is sufficiently close to `A = 0` is the boundary value of a solution of the Yang-Mills equations on `B_{d+1}` that is unique up to gauge transformation. … The argument beyond that is **hopefully similar** to what was done by Graham and Lee. **For topological reasons, existence and uniqueness of a gauge field on `B_{d+1}` with given boundary values can only hold for `A` sufficiently close to zero.**"
  脚注 4 给出该"只能局部成立"的显式反证（Chern class 论证，逐字）："Consider on `S² × S^d` a gauge field with a nonzero `½d + 1`-th Chern class, so that `∫_{S²×S^d} TrF ∧ F ∧ … ∧ F ≠ 0` … then one would deduce that `0 = ∫_{S²×B_{d+1}} dTrF∧F∧…∧F = ∫_{S²×S^d} TrF∧F∧…∧F`, which is a contradiction."
- **★ 重要限制**：Graham–Lee 只给**接近标准共形结构**的局部结果；YM 版本原文自称 "one expects" / "hopefully"。而且 p.8 逐字："the restriction to conformal structures that are sufficiently close to the standard one **is probably also necessary** for most values of `d`"。→ **GKPW 字典的"边界值问题适定"这一支，在非微扰层面是开放的，且已知在大场下必然失败。**

### E-W4 `φ₀` 的定义与"源"的身份
- 位置：§2.3，p.8。
- 类型：definition
- 原文逐字：
  > "**Let `φ₀` be the restriction of `φ` to the boundary of `AdS_{d+1}`.** We will assume that in the correspondence between `AdS_{d+1}` and conformal field theory on the boundary, `φ₀` should be considered to couple to a conformal field `O`, via a coupling `∫_{S^d} φ₀ O`. This assumption is natural given the relation of the conjectured `CFT/AdS` correspondence to analyses [8–11] of interactions of fields with branes. **`φ₀` is conformally invariant – it has conformal weight zero –** since the use of a function `f` as in (2.2) to define a metric on `S^d` does not enter at all in the definition of `φ₀`. **So conformal invariance dictates that `O` must have conformal dimension `d`.**"
- 前提（逐字，同页）："Suppose that, in any one of the examples in [13], one has a **massless** scalar field `φ` on `AdS_{d+1}` obeying the simple Laplace equation `D_i D^i φ = 0`, with no mass term or curvature coupling, or some other equation with the same basic property: **the existence of a unique solution on `B̄_{d+1}` with any given boundary values**."
- 脚注 5 逐字："In each of the cases considered in [13], the spacetime is really `AdS_{d+1} × W` for some compact manifold `W`. At many points in this paper, we will be somewhat **informal and suppress `W`** from the notation."
- 备注：
  - **`φ₀` 就是"限制到边界"，不带任何 `z^{d−Δ}` 因子**——那是无质量情形（`Δ = d`）才成立的简化。有质量情形要重新定义，见 E-W6。
  - "`O` 必须有维数 `d`"这一结论**只对无质量标量**成立；原文是从"`φ₀` 权重 0 + 耦合 `∫_{S^d}φ₀O` 需共形不变"推出的。

### E-W5 ★ 核心式：**(2.11)** —— 生成泛函 = 超引力/弦配分函数
- 位置：§2.3，**p.9**，式 **(2.10)(2.11)**。**核实结论：式号确为 (2.11)。**
- 类型：proposition（原文自称 ansatz）
- 原文逐字（完整上下文）：
  > "Now, let `Z_S(φ₀)` be the supergravity (or string) partition function on `B_{d+1}` computed with the boundary condition that at infinity `φ` approaches a given function `φ₀`. For example, in the approximation of classical supergravity, one computes `Z_S(φ₀)` by simply extending `φ₀` over `B_{d+1}` as a solution `φ` of the classical supergravity equations, and then writing"
  >
  > `Z_S(φ₀) = exp(−I_S(φ)),`  (2.10)
  >
  > "where `I_S` is the classical supergravity action. If classical supergravity is not an adequate approximation, then one must include string theory corrections to `I_S` (and the equations for `φ`), or include quantum loops (computed in an expansion around the solution `φ`) rather than just evaluating the classical action. Criteria under which stringy and quantum corrections are small are given in [13]. The formula (2.10) makes sense **unless there are infrared divergences** in integrating over `AdS_{d+1}` to define the classical action `I(φ)`. We will argue in section 2.4 that when such divergences arise, they correspond to expected renormalizations and anomalies of the conformal field theory."
  >
  > "**Our ansatz for the precise relation of conformal field theory on the boundary to `AdS` space is that**"
  >
  > `⟨ exp ∫_{S^d} φ₀ O ⟩_{CFT} = Z_S(φ₀).`  (2.11)
  >
  > "As a preliminary check, note that in the case of of [sic] `N = 4` supergravity in four dimensions, this has the expected scaling of the 't Hooft large `N` limit, since the supergravity action `I_S` that appears in (2.10) is of order `N²`."
- **★ 逐字形式的三点要害**：
  1. 左边**不是** `Z_CFT`，是**生成泛函** `⟨exp ∫_{S^d} φ₀ O⟩_CFT`。右边**是**配分函数 `Z_S(φ₀)`。所以常见写法 "`Z_CFT[φ₀] = Z_string[φ→φ₀]`" 是**忠实的改写但不是原文记号**。若图节点要写成 `Z = Z`，`notes` 必须注明这是改写。
  2. 边界条件是 "**at infinity `φ` approaches a given function `φ₀`**"（p.9 逐字）+ "`φ₀` 是 `φ` 到边界的限制"（E-W4）。**没有**任何 `z^{Δ−d}` 重标度因子；重标度问题在有质量情形才出现（E-W6）。
  3. 积分在 **`S^d`**（欧氏共形边界）上，不是 `R^d`；`Z_S` 定义在**闭球 `B_{d+1}`** 上。
- 文献自称的严格程度：**"ansatz"**（小节标题）。"whose justification, **initially**, is that it combines the ingredients at hand in the most natural way. **Gradually, further evidence for the ansatz will emerge.**"（p.8）
- 文献列出的依赖：Maldacena [13] 的对偶（作为待精确化的猜想）；[8–11] 的 brane-场相互作用分析（用来辩护"`φ₀` 耦合 `O`"这条假设）；(2.10) 依赖经典超引力近似 + 无红外发散。
- 脚注 6 逐字（`N²` 标度的来源）："The action contains an Einstein term, of order `1/g_s²`. This is of order `N²` as `g_{st} ∼ g²_{YM} ∼ 1/N`. It also contains a term `F²` with `F` the Ramond-Ramond five-form field strength; this has no power of `g_{st}` but is of order `N²` as, with `N` units of RR flux, one has `F ∼ N`."
- **★ 原文印刷错误**：(2.11) 前一句写 "in the case of of `N = 4` supergravity in **four dimensions**"——按上下文（`I_S ∼ N²`、AdS₅×S⁵）应指 `N = 4` **super Yang-Mills** in four dimensions 对应的**五维**超引力；"`N = 4` supergravity in four dimensions" 是另一个理论。v2 仍如此。**转录时勿沿用。**

### E-W6 ★ **(2.12)** 才是逐字的 `Z_CFT = Z_S`；**(2.13)** 是规范流版本
- 位置：§2.3，**p.9 末 – p.10**，式 **(2.12)(2.13)**。
- 类型：proposition（(2.12) 自称 "we interpret … to be"；(2.13) 自称 "ansatz" + "we propose"）
- 原文逐字（(2.12)）：
  > "Gravity and gauge theory can be treated similarly. Suppose that one would like to compute correlation functions of a product of stress tensors in the conformal field theory on `S^d`. The generating functional of these correlation functions would be the partition function of the conformal field theory as a function of the metric on `S^d`. **Except for a `c`-number anomaly**, which we discuss in the next subsection but temporarily suppress, this partition function only depends on the conformal structure of `S^d`. Let us denote as `Z_{CFT}(h)` the partition function of the conformal field theory formulated on a **four-sphere** with conformal structure `h`. **We interpret the `CFT/AdS` correspondence to be that**"
  >
  > `Z_{CFT}(h) = Z_S(h)`  (2.12)
  >
  > "where `Z_S(h)` is the supergravity (or string theory) partition function computed by integrating over metrics that have a double pole near the boundary and induce, on the boundary, the given conformal structure `h`. In the approximation of classical supergravity, one computes `Z_S(h)` by finding a solution `g` of the Einstein equations with the required boundary behavior, and setting `Z_S(h) = exp(−I_S(g))`."
- 原文逐字（(2.13)）：
  > "Likewise, for gauge theory, suppose the `AdS` theory has a gauge group `G`, of dimension `s`, with gauge fields `A^a`, `a = 1, …, s`. Then in the scenario of [13], the group `G` is a **global** symmetry group of the conformal field theory on the boundary, and there are currents `J_a` in the boundary theory. … For this we make an **ansatz** precisely along the above lines: we let `Z_S(A₀)` be the supergravity or string theory partition function with the boundary condition that the gauge field `A` approaches `A₀` at infinity; and **we propose that**"
  >
  > `⟨ exp( ∫_{S^d} J_a A₀^a ) ⟩_{CFT} = Z_S(A₀).`  (2.13)
- **★ 式号裁定（回答"是否 (2.11)"）**：
  - 若图节点的文本是 **`⟨exp ∫_{S^d} φ₀ O⟩_CFT = Z_S(φ₀)`** → 出处**确为 (2.11)**，✔ 核实通过。
  - 若图节点的文本被写成 **`Z_CFT[φ₀] = Z_string[φ|_∂ = φ₀]`**（两边都是 `Z`）→ **原文里两边都是 `Z` 的等式是 (2.12)，而且 (2.12) 的自变量是共形结构 `h`（度规源），不是标量源 `φ₀`**。把 `Z=Z` 形式记成 (2.11) 是**式号错配**。
  - 教科书常见的通式 `Z_CFT[φ₀] = Z_bulk[φ|_∂=φ₀]` 实际是把 (2.11)(2.12)(2.13) 三式**合并归纳**的结果，Witten 原文没有写出这个通式。
- 原文给的通则性总结（p.10 逐字，这是最接近"通式"的一句）：
  > "These examples **hopefully** make the general idea clear. One computes the supergravity (or string) partition function as a function of the boundary values of the **massless** fields, and interprets this as a generating functional of conformal field theory correlation functions, for operators whose sources are the given boundary values. Of course, in general, one wishes to compute the conformal field theory partition function **with all massless fields turned on at once** – rather than considering them separately, as we have done for illustrative purposes. One also wishes to include **massive** fields, but this we **postpone** until after performing some illustrative computations in the next subsection."
- **原文印刷问题**：(2.12) 前一句写 "formulated on a **four-sphere**"，但 (2.12) 与全节都在一般 `d` 的 `S^d` 上（`Z_S(h)` 的定义句里也是"the boundary"），"four-sphere" 与上下文的 `S^d` 不一致。**转录时用 `S^d`。**
- 备注：`c`-number 反常在 (2.12) 里被"暂时压制"，这是一个**已知的等式修正项**，原文自己标出（§2.4 "Chern-Simons Term And Anomaly" 处理）。

### E-W7 无质量标量的两点函数（本文自算，用 (2.11)）
- 位置：§2.4，p.11–13，式 **(2.14)–(2.23)**。
- 类型：计算结果
- 关键式逐字：
  - `I(φ) = (1/2) ∫_{B_{d+1}} d^{d+1}y √g |dφ|²` (2.14)
  - 上半空间度规 `ds² = (1/x₀²) Σ_{i=0}^d (dx_i)²` (2.15)
  - `(d/dx₀) x₀^{−d+1} (d/dx₀) K(x₀) = 0` (2.16)；`K(x₀) = c x₀^d` (2.17)
  - 反演 `x_i → x_i/(x₀² + Σ_j x_j²)` (2.18) 后 `K(x) = c x₀^d /(x₀² + Σ_j x_j²)^d` (2.19)
  - `φ(x₀, x_i) = c ∫ dx' [x₀^d/(x₀² + |x−x'|²)^d] φ₀(x'_i)` (2.20)  ← **体–边界传播子**
  - `I(φ) = (cd/2) ∫ dx dx' φ₀(x)φ₀(x')/|x−x'|^{2d}` (2.23)
  - 原文逐字结论："So the two point function of the operator `O` is a multiple of `|x−x'|^{−2d}`, **as expected for a field `O` of conformal dimension `d`**."
- 方法逐字："By integrating by parts, one can express `I(φ)` as a surface integral, in fact `I(φ) = lim_{ε→0} ∫_{T_ε} dx √h φ (n⃗ · ∇⃗)φ` (2.22), where `T_ε` is the surface `x₀ = ε`"
- 备注：与 GKP 的两点函数计算是**同一物理内容、不同技术路线**：GKP 用 Bessel 函数 + `z = R` 截断 + 动量空间；Witten 用体–边界传播子 (2.20) + `x₀ = ε` 面 + 位置空间。**两者是独立推导，图上应挂成同一陈述的两条推导。**
- 自称严格程度：直接计算，无 "we prove"；关键的 `φ₀` ↔ `O` 身份仍是 (2.11) 的假设（"We **assume** that the boundary value `φ₀` of `φ` is the source for a field `O`"，p.12 逐字）。

### E-W8 自由 U(1) 规范场两点函数；Chern–Simons 项与手征反常
- 位置：§2.4，p.13–16，式 **(2.24)–(2.31)**。
- 关键式逐字：
  - `A = ((d−1)/(d−2)) x₀^{d−2} dx^i` (2.25)
  - `I(A) = (1/2)∫_{B_{d+1}} F ∧ *F = (1/2) lim_{ε→0} ∫_{T_ε} A ∧ *F` (2.29)
  - `I = ∫ dx dx' a_i(x) a_j(x') ( δ_{ij}/|x−x'|^{2d−2} − 2(x−x')_i(x−x')_j/|x−x'|^{2d} )` (2.30)
  - 原文逐字："**This is the expected form for the two-point function of a conserved current.**"
  - IIB on `AdS₅×S⁵` 的作用量（含 CS 项）：`I(A) = ∫_{B₅} Tr( F∧*F/(2g²) + (iN/(16π²))(A∧dA∧dA + …) )` (2.31)，"the Chern-Simons term can be found, for example, in eqn. (4.15) in [49]"
- **反常论证（p.15 逐字，本文最强的一处"检验"）**：
  > "Since we identify the effective action of the conformal field theory with the classical action of supergravity (evaluated for a classical solution with given boundary values), **the classical supergravity action must not be gauge invariant.** How does this occur?"
  > … "In the classical supergravity approximation, the anomaly immediately follows from the relation `W(A₀) = I(A)`. In fact, `I(A)` is not gauge-invariant; under a gauge transformation it picks up a boundary term (because the Chern-Simons coupling changes under gauge transformation by a total derivative) **which precisely reproduces the chiral anomaly on the boundary**."
  > "Going beyond the classical supergravity approximation **does not really change** the discussion of the anomaly, because for **any** `A` whose boundary values are `A₀`, the gauge-dependence of `I(A)` is the same … Likewise, stringy corrections to `I(A)` involve integrals over `B₅` of gauge-invariant local operators, and do not affect the anomaly."
- 备注：`A` 必须取复值（因为 CS 项带 `i`），原文由此又给出一条 "`A₀` 必须足够小" 的理由（p.15 逐字："since classical equations for strong complex-valued gauge fields will not behave well, this is another reason, in addition to arguments given in section 2.3, that `A₀` must be sufficiently small"）。

### E-W9 引力作用量的发散与共形反常（自称 schematic）
- 位置：§2.4 "Gravity"，p.18–19，式 **(2.32)**。
- 原文逐字：
  > "Now we will discuss, **though only schematically**, the gravitational case …"
  >
  > `I(g) = ∫_{B_{d+1}} d^{d+1}x √g ( (1/2)R + Λ ) + ∫_{∂B_{d+1}} K,`  (2.32)
  >
  > "Now, **everything in sight in (2.32) is divergent.** … To proceed, therefore, we need to regularize the action."
  > "We want to show **at least schematically** that, with a natural choice of `f`, the divergent terms are local integrals on the boundary. The strategy for proving this is as follows. **Theorems 2.1 and 2.3 of [44]** show that the metric of `B_{d+1}` is determined locally by the conformal structure of `S^d` up to very high order."
  > "The effective action of the conformal field theory on `S^d` can thus be made finite **by subtracting local counterterms.** … the conformal anomaly comes as usual from the logarithmically divergent term; all the divergent terms are local."
  > "The conformal anomaly **arises only for even `d`**; this is related to the fact that Theorems 2.1 and 2.3 in [44] make different claims for odd and even `d`."
- 备注：这是全息重整化（holographic renormalization）的最早论证之一，但原文自称 "schematically"。式 (2.32) 明确包含 Gibbons–Hawking 面项 `∫_{∂B} K`（引 [50,51]）。

### E-W10 Graham–Lee 定理失败与"大 N 非解析性"（原文自列的隐忧）
- 位置："A Small Digression"，p.10–11。
- 类型：文献自列疑难
- 原文逐字：
  > "the Graham-Lee theorem **presumably fails** for conformal structures that are sufficiently far from the round one, and … the analogous theorem for gauge theory **definitely fails** for sufficiently strong gauge fields on the boundary."
  > "If one is very far from the standard conformal structure, so that `R` is negative, or if the background gauge field `A₀` is big enough, **the partition function may well diverge**."
  > "**But perhaps such analyticity can break down in the large `N` limit**; the failure of existence and uniqueness of the extension of the boundary fields to such a classical solution could correspond to such nonanalyticity."
- 备注：原文自己指出 (2.11)–(2.13) 的适定性**只在源足够小的邻域内**有依据。这直接限制了 GKPW 字典节点的适用域，应写进节点 `notes` 或 assumptions。

### E-W11 有质量情形：`φ₀` 的重新定义（`φ ∼ f^{−λ₊} φ₀`）
- 位置：§2.5 "The Massive Case"，p.19–20，式 **(2.33)–(2.36)**。
- 类型：definition（**修正 E-W4 的 `φ₀` 定义**）
- 原文逐字：
  > `I(φ) = (1/2)∫ dμ ( |dφ|² + m²φ² )`  (2.33)
  >
  > `( −(1/(sinh y)^d) (d/dy)(sinh y)^d (d/dy) + L²/sinh²y + m² ) φ = 0.`  (2.34)
  >
  > "The `L²` term is still irrelevant at large `y`. The two linearly independent solutions of (2.34) behave for large `y` as `e^{λy}` where"
  >
  > `λ(λ + d) = m².`  (2.35)
  >
  > "**For reasons that will be explained later, `m²` is limited to the region in which this quadratic equation has real roots.** Let `λ₊` and `λ₋` be the larger and smaller roots, respectively; note that `λ₊ ≥ −d/2` and `λ₋ ≤ −d/2`. One linear combination of the two solutions extends smoothly over the interior of `AdS_{d+1}`; this solution behaves at infinity as `exp(λ₊ y)`."
  >
  > "**This state of affairs means that we cannot find a solution of the massive equation of motion (2.34) that approaches a constant at infinity.** The closest that we can do is the following. Pick any positive function `f` on `B_{d+1}` that has a simple zero on the boundary. … Then one can look for a solution of the equation of motion that behaves as"
  >
  > `φ ∼ f^{−λ₊} φ₀,`  (2.36)
  >
  > "with an arbitrary 'function' `φ₀` on the boundary."
  >
  > "**But just what kind of object is `φ₀`?** The definition of `φ₀` as a function depends on the choice of a particular `f` … If we transform `f → e^w f`, the metric will transform by `d s̃² → e^{2w} d s̃²`. At the same time, (2.36) shows that `φ₀` will transform by `φ₀ → e^{wλ₊}φ₀`. This transformation under conformal rescalings of the metric shows that **`φ₀` must be understood as a conformal density of length dimension `λ₊`, or mass dimension `−λ₊`.**"
- **★ 抽取要点**：**"`φ₀` = `φ` 到边界的限制"（E-W4）只对无质量场成立。**有质量时 `φ₀` 由 (2.36) 通过 `f^{−λ₊}` 剥离定义，且**不是函数而是共形密度**（权重依赖 `λ₊`，因而依赖质量）。图节点若只写 "`φ₀` 是边界值" 会漏掉这个关键限定。
- 备注：`f` 的选择破坏共形不变（是"选度规而非只选共形结构"），与 (2.2)(2.3) 同一个 `f`。

### E-W12 ★ **(2.43)** `Δ(Δ − d) = m²`（任务点，核实通过）
- 位置：§2.5 "Computation Of Two Point Function"，**p.21**，式 **(2.37)–(2.44)**。
- 类型：计算结果
- 原文逐字（推导链）：
  > `( −x₀^{d+1}(d/dx₀) x₀^{−d+1}(d/dx₀) + m² ) K(x₀) = 0.`  (2.37)
  > "The solution that vanishes for `x₀ = 0` is `K(x₀) = x₀^{d+λ₊}`."
  > `K = x₀^{d+λ₊}/(x₀² + |x|²)^{d+λ₊},`  (2.38)
  > `φ(x) = c' ∫ dx' [ x₀^{d+λ₊}/(x₀² + |x−x'|²)^{d+λ₊} ] φ₀(x')`  (2.41)
  > `I(φ) = (c'(d+λ₊)/2) ∫ dx dx' φ₀(x)φ₀(x')/|x−x'|^{2(λ₊+d)}.`  (2.42)
  > "This is the expected two point function of a conformal field `O` of dimension `λ₊ + d`."
  >
  > "**In sum, the dimension `Δ` of a conformal field on the boundary that is related to a field of mass `m` on `AdS` space is `Δ = d + λ₊`, and is the larger root of**"
  >
  > `Δ(Δ − d) = m².`  (2.43)
  >
  > "Thus"
  >
  > `Δ = (1/2)( d + √(d² + 4m²) ).`  (2.44)
  >
  > "In section 3.3, we will **propose another explanation, using a Hamiltonian approach**, for this relation."
- **核实结论**：任务所指的 `Δ(Δ − d) = m²` **确实存在于 Witten，式号 (2.43)（arXiv v2, p.21）**，并明确附带 **"is the larger root of"** 这一取根规定，以及显式解 (2.44)。§2.6 又重复为 `Δ = d + λ₊ = (d + √(d²+4m²))/2` 式 **(2.48)**（p.25）。
- **约定警告**：此处 **AdS 半径 = 1**（式 (2.15) 无 `R`），所以 `m²` 实为 `m²R²`。与 GKP 式 (45) `Δ = 2 + √(4+(mR)²)` 对照：取 `d = 4`、`R` 显式，两式**代数等价**。**图节点必须声明 `R = 1` 约定，否则量纲不对。**
- 非标量情形（式 **(2.45)**，p.22 逐字）：
  > "If instead `C` is a massive field that behaves as `f^{−λ₊}C₀` near the boundary, then … an operator `O` that couples to `C₀` has conformal dimension `Δ = d − p + λ₊`. In this case (2.43) is replaced by"
  >
  > `(Δ + p)(Δ + p − d) = m².`  (2.45)
  - 无质量 `p`-form 情形（同页逐字）："a massless `p`-form `C` on `AdS` space could couple to a `d − p`-form operator `O` on the boundary via a coupling `∫_{M_d} C ∧ O`; conformal invariance (and gauge invariance of the massless `C` field) requires that the dimension of `O` be `d − p`."
- **★ 幺正界 / Breitenlohner–Freedman 界（式 (2.47)，p.24）**：
  > "Here is a **quick and nonrigorous** Euclidean space derivation of the lower bound. … The case `λ₊ = λ₋ = −d/2` arises for `m² = −d²/4`, and this is the lower bound on `m²`. If `m²` is smaller, then `λ_±` become complex, with real part `−d/2`, and the linearized equations have zero modes with plane wave normalizability; this is the same sort of spectrum and gives the same sort of pathology as for tachyon equations in flat Euclidean space. So the lower bound is `m² ≥ −d²/4`, `λ₊ ≥ −d/2`. Note that the dimension `Δ = d + λ₊` of a scalar field on the boundary … thus obeys"
  >
  > `Δ ≥ d/2.`  (2.47)
  - 原文自称 "**quick and nonrigorous**"。原始严格结果引 [24–26]（Breitenlohner–Freedman 等）。
  - 逐字："Because of the boundary conditions at infinity, the kinetic energy of a scalar field in `AdS` space cannot vanish, and **stability requires not that `m²` should be positive but that `m²` should be no smaller than a certain negative lower bound**."

### E-W13 任意算子的关联函数：无穷小源与"不相关微扰"的困难（原文自列缺口）
- 位置：§2.5 "Correlation Functions Of Arbitrary Operators"，p.22–23，式 **(2.46)**。
- 类型：文献自列限制
- 原文逐字：
  > "If one allows arbitrary local operators of any dimension, the singularities for coincident points are extremely complicated and **one cannot without a very high degree of complication and arbitrariness define a generating function** `⟨exp(∫ d^dx Σ_a ε_a(x) O_a(x))⟩` (2.46)."
  > "**It is nevertheless convenient to formally have the machinery of generating functionals.** To do this one should consider the `ε_a` to have **disjoint support** and to be **infinitesimal**, and evaluate (2.46) **only to linear order in each `ε_a`**."
  > "This works fine if the `λ_{a,+}` are **all negative** … The case of negative `λ_{a,+}` is the case of **relevant** perturbations of the conformal field theory, of dimension `< d` …"
  > "**The trouble arises if one wants to include irrelevant (or unrenormalizable) perturbations** … Since the solutions of the linearized equations have boundary behavior `φ_a ∼ ε_a f^{−λ_{a,+}}`, they **diverge near the boundary if `λ₊ > 0`**, in which case use of the linearized equations to determine the boundary behavior is **not self-consistent**. … we consider the `ε_a` to be **not real-valued functions but infinitesimal variables with `ε_a² = 0`**, and with different `ε_a` having disjoint support."
- **★ 抽取要点**：**Witten 自己声明 (2.11)/(2.46) 型生成泛函在一般情形只能作为形式级数（`ε²=0` 的无穷小变量）定义**，只有 relevant/marginal 源才能当"真正的泛函"。这是 GKPW 字典的一条硬限制，且**在现代教科书里常被省略**。转成节点必须写进 assumptions。

### E-W14 ★ 规范群：Witten 论证是 `SU(N)` 而非 `U(N)`
- 位置：§2.6，p.26。
- 类型：proposition（基于 KK 谱匹配的论证）
- 原文逐字：
  > "Consider the operators `T^{z₁z₂…z_k} = TrΦ^{z₁}Φ^{z₂}…Φ^{z_k}`. **We require `k ≥ 2` as the gauge group is `SU(N)` and not `U(N)`.**"
  > "A field of dimension `k` in four-dimensional conformal field theory has `λ₊ = k − 4` and corresponds to a scalar field in supergravity with a mass `m² = λ₊(λ₊ + 4) = k(k − 4)`. So we expect in the Kaluza-Klein spectrum of the `N = 4` theory that for every `k = 2, 3, …` there should be a scalar with mass `m² = k(k − 4)` transforming in the `k`^th traceless symmetric tensor representation of `SO(6)`."
  > "**Note that a `k = 1` state does not appear in the supergravity, which confirms that the supergravity is dual to an `SU(N)` gauge theory and not to a `U(N)` theory.** In fact, the `k = 2` state saturates the bound (2.47), and a `k = 1` state would violate it."
  > 脚注 7 逐字："Another reason that the `U(1)` gauge field could not be coded in the `AdS₅` theory is that it is **free**, while in the `AdS₅` theory everything couples to gravity and nothing is free. **To describe `U(N)` gauge theory on the boundary, one would have to supplement the `AdS₅` theory with an explicit `U(1)` singleton field on the boundary.**"
- **★ 与 Maldacena 的冲突**：Maldacena hep-th/9711200 全篇用 **`U(N)`**（见 `maldacena-1997.md`）；Witten 这里**论证** `SU(N)` 才对，并指出 `U(N)` 需在边界额外加 `U(1)` singleton。**这是两篇原始文献之间可核实的实质分歧，图上应作为一条独立陈述（"AdS₅×S⁵ IIB 对偶的是 SU(N) 而非 U(N)"，来源 Witten §2.6）而不是静默统一。**
- 备注：`m² = k(k−4)` 与 (2.43) 一致（`Δ = k`, `d = 4`）；KK 谱数据引 [30,31]（"eqn. (2.34) and in Fig. 2 and Table III of [30]"），原文提醒 "Formulas given there contain a parameter `e` which we have set to 1."

### E-W15 KK 谱与手征算子的匹配（摘要所称的 "quantitative confirmation"）
- 位置：§2.6，p.26–28，式 **(2.49)(2.50)**。
- 类型：检验结果
- 三族算子与对应质量（原文逐字给出）：
  1. `T^{a₁…a_k}`（对称无迹，`k ≥ 2`）：`m² = λ₊(λ₊+4) = k(k−4)`（无编号行内式，p.26）
  2. `V^{z₁…z_t} = TrW_αW^αΦ^{z₁}…Φ^{z_t}`，`k = t+1`：`m² = (k+2)(k−2)`  (2.49)
  3. 由 prepotential `Tr a^r` 得 `Q_r`，`k = r−2`，维数 `k+4`：`m² = k(k+4)`  (2.50)
- 原文自称：p.26 逐字 "**It is therefore possible to test the conjectured CFT/AdS correspondence** by comparing the Kaluza-Klein harmonics on `AdS₅ × S⁵` to the operators in the `N = 4` super Yang-Mills theory that are in small representations"；三处均以 "These states can be found in Fig. 2 and in Table III in [30]" 收尾。
- 备注：Witten **只比较了三族**（含 relevant 或 marginal 算子的），逐字："Two additional families that contain only states of positive `m²` **will not be considered here**." → 摘要里的 "match" 是**部分匹配**，不是全谱匹配。
- 另一处逐字（p.27）："the operator `Σ_a Tr(X^a)²`, which is certainly a relevant operator for weak coupling, **is not chiral** and so is related to a stringy excitation and has a dimension of order `(g²_YM N)^{1/4}` for strong coupling."（与 GKP 式 (46) 的 `(g²N)^{1/4}` 标度一致，但 Witten 不在此处引 GKP。）

### E-W16 §3：非平凡边界流形、`Z_CFT = Σ_i Z_S(X_i)`、Hawking–Page 相变
- 位置：§3.1–3.2，p.28–34，式 **(3.1)–(3.17)**。
- 类型：proposition（原文自称 postulate / propose / "non-rigorous"）
- 原文逐字：
  > "As in section 2.3, **we propose that** the conformal field theory partition function on `M` equals the supergravity (or string theory) partition function on `X`, with boundary conditions given by the conformal structure (and other fields) on `M`. In the approximation of classical supergravity, we simply solve the classical equations on `X` with the given boundary conditions, and write"
  >
  > `Z_{CFT}(M) = exp(−I_S(X)),`  (3.1)
  >
  > "In general, there might be several possible `X`'s. If so, we have no natural way to pick one, so as is usual in Euclidean quantum gravity, we replace (3.1) by a sum. … **So we postulate that in general**"
  >
  > `Z_{CFT}(M) = Σ_i exp(−N^γ F(X_i)),`  (3.2)   （`I_S = N^γ F(X)`，`γ = 2` for `N = 4` SYM）
  >
  > "Of course, (3.2) should be viewed as the classical supergravity approximation to an exact formula"
  >
  > `Z_{CFT}(M) = Σ_i Z_S(X_i),`  (3.3)
  >
  > "where `Z_S(X_i)` is the partition function of string theory on `X_i`."
  > "But since **the discussion is non-rigorous anyway**, we will keep things simple and speak in terms of a `d+1`-dimensional Einstein manifold `X`."（p.28）
- 相变（p.33 逐字）：`I = πr₊²(1−r₊²)/(1+3r₊²)` (3.16)（Hawking–Page 作用量差）；"Thus (for `d = 3` and **presumably for all `d`**), the boundary conformal field theories that enter the `CFT-AdS` correspondence **have phase transitions as a function of temperature in the large `N` limit**."
- 自旋结构精细化（式 (3.9)(3.10)）：`Z₁(M) = Tr e^{−βH}(−1)^F`、`Z₂(M) = Tr e^{−βH}`；脚注 8 逐字："in the case that the boundary theory is four-dimensional gauge theory with a gauge group that is **locally** `SU(N)`, **it may be that the gauge group is really `SU(N)/Z_N`**, in which case the partition function on `M` depends on a choice of a 'discrete magnetic flux' `w ∈ H²(M, Z)`. **Perhaps** one should restrict the sum in (3.2) to `X_i` over which `w` extends."
- **★ 与摘要的 "with some further assumptions" 对应**：p.33 逐字 "Actually, **we do not know how the `N = 4` theory should behave for large `N` with large and fixed `g²_YM N`.** We will therefore compare to the expected large `N` thermodynamics [57] of an `SU(N)` gauge theory with **massive quarks in the fundamental representation** (that is, ordinary QCD generalized to large `N`). **It is surprising that this comparison will work**, since QCD is confining, while the `N = 4` theory has no obviously analogous phenomenon. **However, the comparison seems to work**, as we will see, at least for large `g²_YM N`."

### E-W17 §3.3 Hamiltonian 版本与 `Δ = ω`（第二条独立推导）+ **一处符号矛盾**
- 位置：§3.3，p.34–36，式 **(3.18)**。
- 原文逐字：
  > "So we identify the Hilbert space of the conformal field theory in quantization on `S^{d−1}` with the Hilbert space of the supergravity (or string theory) on `AdS_{d+1}`."
  > "So we can **assert** that, in the `CFT-AdS` correspondence, the local operators in the boundary conformal field theory correspond to the quantum states on `AdS_{d+1}`."
  > "The `SO(1,1)` generator that measures operator dimensions in the conformal field theory is the unique `SO(1, d+1)` generator that commutes with `SO(d)`, so it is the energy operator of the `AdS` theory."
  > "Thus, the energy of a mode in `AdS` space equals the dimension of the corresponding operator in the boundary conformal field theory. Now, in equation (A6) in [24], it is shown that a scalar field of mass `m²` in `AdS` space has a discrete energy spectrum … and that the frequency of the mode of lowest energy is `ω = ½(d + √(d² − 4m²))`. Comparing to the formula (2.44) for the dimension `Δ` of the conformal field `O` in boundary conformal field theory that is related to a scalar of mass `m` in `AdS` space, **we see that `Δ = ω`, as expected**."
  > 脚注 9 逐字："In [24], the computation is performed **only for `d = 3`**. Also, **the parameter `α` in [24] is our `−m²`**, and there is a small clash in notation: the quantity `λ₊` defined on p. 276 of [24] is `d + λ₊` in our notation."
- **★ 原文内部矛盾（读图核实，v2 p.35）**：此处印的是 **`ω = ½(d + √(d² − 4m²))`（减号）**，而 (2.44) 是 **`Δ = ½(d + √(d² + 4m²))`（加号）**。二者不可能同时成立（除非 `m²` 换了符号约定），而正文紧接着断言 "`Δ = ω`, as expected"。脚注 9 指出 [24] 的 `α = −m²`，**推测**是把 [24] 用 `α` 写的公式转写时符号处理出了问题。
  - **裁定建议**：与 (2.43) 一致、与两点函数 (2.42) 一致、与 §2.6 的 `m² = k(k−4)` 一致的是 **加号版本 (2.44)**。**不要引 p.35 的 `ω` 公式。**
  - **不确定度**：`+`/`−` 是从 PDF 渲染图上判读的（已单独重读该页确认）。等级记 **L1（读图）**，见 §3-3。
- 备注：这是 (2.43)/(2.44) 的**第二条独立论证**（态-算子对应 + AdS 能谱），与 §2.5 的两点函数论证不同。但其中"`Δ` 生成元 = AdS 能量算子"一步原文用的是 "we can assert"。

### E-W18 ★ Witten 如何描述 GKP（参考文献 [36]）
- 位置：p.4 末（§1 结尾）。
- 原文逐字：
  > "**After this work was substantially completed, I learned of independent work [36]** in which **a very similar understanding of the the [sic] `CFT/AdS` correspondence to what we describe in section 2 is developed**, as well as two papers [37,38] that consider facts relevant to or aspects of the Hamiltonian formalism that we consider in section 3."
- 参考文献 [36] 逐字：`S. S. Gubser, I. R. Klebanov, and A. M. Polyakov, "Gauge Theory Correlators From Noncritical String Theory," hep-th/9802109.`
- **★ 图学意义**：Witten **本人**把 GKP 认定为**独立工作（independent work）**且"非常相似的理解"。这是**原文层面的证据**，支持把 GKP 与 Witten 处理成**同一陈述的两条独立推导**，而不是一条。
- 备注：[37] = Ferrara–Fronsdal hep-th/9802126；[38] = Horowitz–Ooguri hep-th/9802116。

## §3 未核实 / 无法核实项

1. **发表版（ATMP 2 (1998) 253–291）未核对**。全部式号来自 **arXiv v2**；v1（1998-02-20）未读。v2 comments 自陈 "**assorted corrections**"，故 v1 与 v2 可能有实质差异，比 GKP 的 "minor revisions" 风险更高。→ 引式号必须写 `hep-th/9802150v2`。
2. **§2.6 的 KK 谱数据未独立核实**：`m² = k(k−4)`、`(k+2)(k−2)`、`k(k+4)` 与 Kim–Romans–van Nieuwenhuizen [30]、Gunaydin–Marcus [31] 的对照**只据 Witten 转述**（"Fig. 2 and Table III in [30]"），未读 [30][31]。原文还提醒 [30] 的公式含参数 `e`，Witten 设为 1。
3. **p.35 的 `ω = ½(d + √(d² − 4m²))` 的正负号**：基于 PDF 渲染图判读（已单独重读该页）。因为由此得出"原文有内部矛盾"这种强断言，**建议 curator 用可搜索文本（ATMP 发表版或 v1）再核一次**。
4. **Graham–Lee 定理 [42]（Adv. Math. 87 (1991) 186）本身未核实**；Fefferman–Graham [44] 的 "Theorems 2.1 and 2.3" 亦未核实。**这两条是 GKPW 字典里唯一有真数学定理背书的部分，做形式化前必须一手核实。**
5. **"全文没有把 (2.11) 称作 conjecture/theorem" 是逐页读图的否定性结论**（41 页 PDF 全读），非字符串检索。等级 **L1-neg**。（"conjecture" 一词在文中大量出现，但**都指 Maldacena 的 [13] 或 "the conjectured CFT/AdS correspondence"**，不指 (2.11) 本身。）
6. **参考文献 [13] 的 arXiv 号原文印错**：p.37 逐字 `J. Maldacena, "The Large N Limit Of Superconformal Field Theories And Supergravity," hep-th/971120.` —— **少一位数字**，应为 `hep-th/9711200`。原文如此，勿沿用。
7. `c`-number 反常在 (2.12) 中被 "temporarily suppress"，其精确修正形式未在本文写出闭式。
8. §3.2 的 Hawking–Page 计算只对 **`d = 3`（AdS₄）** 做过，推广到一般 `d` 原文自称 "presumably"。
9. 未核实 GKP v2（1998-03-27）是否在其修订中加入了对 Witten 的引用——GKP v2 参考文献表（已读，25 条）中**没有** hep-th/9802150。两篇互引关系：Witten 引 GKP（[36]），GKP 不引 Witten。

## §4 疑问

- **QW1（(2.11) vs (2.12) vs (2.13) 不是同一条陈述）**：三式左边分别是 (2.11) 标量源生成泛函 `⟨exp∫φ₀O⟩`、(2.12) **配分函数** `Z_CFT(h)`（自变量是共形结构 `h`）、(2.13) 流源生成泛函 `⟨exp∫J_aA₀^a⟩`。常见的"教科书通式" `Z_CFT[φ₀] = Z_bulk[φ|_∂=φ₀]` 是把三者归纳的结果，**原文未写出该通式**。图节点若标 "(2.11)" 就必须用 (2.11) 的左边形式；若要写 `Z=Z` 应引 (2.12)。
- **QW2（`φ₀` 有两个不同定义）**：无质量时 `φ₀ = φ|_∂`（E-W4）；有质量时由 `φ ∼ f^{−λ₊}φ₀`（式 (2.36)）定义，`φ₀` 是权重 `λ₊` 的**共形密度**而非函数，且依赖辅助函数 `f`。**同一符号在同一篇文章里换了含义**，节点必须挑一个并注明。
- **QW3（生成泛函只在形式意义下存在）**：E-W13。Witten 明说对不相关算子只能取 `ε² = 0` 的无穷小源。**"AdS/CFT 给出 CFT 的完整生成泛函"这一常见说法超出原文。**
- **QW4（适定性只在小源邻域）**：E-W3 + E-W10。Graham–Lee 只在接近标准共形结构处成立；规范场版本对大场**确定失败**（脚注 4 的 Chern class 反证）。字典的适用域有限且已知有边界。
- **QW5（`SU(N)` vs `U(N)`）**：Witten 用 `SU(N)` 并**论证** `U(N)` 不对（E-W14）；Maldacena 原文全篇 `U(N)`；GKP 在 D3-brane 处写 `U(N)`、在 't Hooft 处写 `SU(N)`。**三篇原始文献互不一致**，图上不宜静默统一。
- **QW6（`Δ = ω` 那一步的符号）**：见 E-W17。
- **QW7（`R = 1` 约定）**：Witten 全篇 AdS 半径 = 1，故 (2.43)(2.44) 中 `m²` 实为 `m²R²`；GKP 显式写 `(mR)²`。**合并两篇的维数-质量陈述前必须统一这条约定**，否则量纲不一致。
- **QW8（(2.10) 的红外发散）**：Witten 自陈 "(2.10) makes sense **unless there are infrared divergences**"，并把发散解释为 CFT 的重整化与反常（§2.4，自称 "schematically"）。即 (2.11) 右边**未经重整化时并不有限**。
- **QW9（"holographic" 一词的用法）**：Witten p.4 逐字 "This correspondence is thus 'holographic,' in the sense of [32,33]"（[32] = 't Hooft gr-qc/9310026，[33] = Susskind J. Math. Phys. 36 (1995) 6377）。**"全息"在本文是被引入用来描述 AdS/CFT 的类比，不是被证明的。**

## §5 图建议

> researcher 只给建议，不写 `graph/`。curator 落卡前须先 `uv run stringgraph search gkpw / holography / dictionary` 查重。

### 建议节点 A：`holography.gkpw-dictionary`（独立卡）— 与 GKP 抽取一致

- **建议 status：`conjecture`**。
  理由（严格按原文强度）：Witten 对 (2.11) 的自称是 **"ansatz"**（§2.3 小节标题 + 正文两处），其最初辩护只是"以最自然的方式组合手头材料"；(2.12) 是 "we **interpret** … to be"；(2.13) 是 "we **propose**"；§3 的 (3.2) 是 "we **postulate**"。**全篇没有把 (2.11) 称作定理，也没有给出证明。**
  - 与 GKP 同级（GKP: "we propose an identification" / "the basic idea is to identify" / "the claim that"）。两篇自称强度都在 "proposal/ansatz" 档；Witten 把 "conjecture" 一词专门留给 Maldacena 的 [13]。
  - 图状态词表里没有 "ansatz/proposal" 这一档；`physical-argument` 应留给"有推导但不严格"的情形，而这两篇都是**直接假设 + 事后检验**，故取 `conjecture`。若 curator 认为 Witten 的 `SO(2,d)` 唯一性论证（E-W1）+ brane 耦合 [8–11] 构成启发式推导而改选 `physical-argument`，请在 `notes` 标明是编者判断。
- **★ 强烈建议：一条陈述 + 两条独立推导，且有原文背书**：
  - Witten 本人 p.4 逐字称 GKP 为 "**independent work** … in which a very similar understanding … is developed"（E-W18）；GKP v2 参考文献表不含 Witten。
  - 推导 1（GKP）：`W[φ] = K[φ] = S[φ(x,z)]`，**截断边界 `z = R`**，Lorentz 号差，Bessel/动量空间。`sources: gubser-klebanov-polyakov-1998, eq (12),(23) (v2)`。
  - 推导 2（Witten）：`⟨exp∫_{S^d}φ₀O⟩_CFT = Z_S(φ₀)`，**共形边界 `S^d`**，欧氏号差，体–边界传播子 (2.20)/(2.41)。`sources: witten-1998-ads, eq (2.11) (v2)`；度规版 `eq (2.12)`；流版 `eq (2.13)`。
  - 两条推导的**假设集不同**（截断 vs 共形边界；Lorentz vs Euclid；`W = S_on-shell` vs `⟨e^{∫φ₀O}⟩ = Z_S`），不可互相替代。分开挂才能让 `stringgraph why` 给出正确瓶颈。
- **节点必须携带的 assumptions（均有原文出处，不需 `inferred`）**：
  1. 大 `N` + 大 `g²_YM N`（经典超引力可靠）：Witten p.1–2；GKP E3。
  2. 源足够小（Graham–Lee 局部性；规范场版对大场确定失败）：Witten E-W3、E-W10。
  3. 生成泛函一般只在 `ε² = 0` 的形式意义下定义（不相关算子）：Witten E-W13。
  4. 需要红外重整化 / 局域反项，且带共形反常：Witten E-W9、QW8。
  5. `c`-number 反常在 (2.12) 中被暂时忽略：E-W6。

### 建议节点 B：`holography.dimension-mass-relation`（维数-质量）

- **陈述文本用 Witten 的一般 `d` 形式**：`Δ(Δ − d) = m²`，`Δ` 取**较大根**，即 `Δ = ½(d + √(d² + 4m²))`。
  `sources: witten-1998-ads, eq (2.43),(2.44) (v2)`。**约定必须声明 AdS 半径 `R = 1`。**
- GKP 的 `Δ = 2 + √(4 + (mR)²)`（`d = 4`、`R` 显式）作为**同一陈述的第二条推导**：`sources: gubser-klebanov-polyakov-1998, eq (45) (v2)`。**GKP 原文没有写出 `Δ(Δ−d) = m²` 这个形式**（GKP E9），故来源字段不能只写 GKP。
- 附带节点（各有独立价值）：
  - `Δ ≥ d/2`（Witten eq (2.47)）：原文自称推导 "quick and **nonrigorous**"，严格版引 [24–26]（Breitenlohner–Freedman 等）→ status 至多 `physical-argument`，且应挂到 BF 界原始文献。
  - `p`-form 版本 `(Δ+p)(Δ+p−d) = m²`（Witten eq (2.45)）。
  - Hamiltonian 推导 `Δ = ω`（Witten §3.3）——**因 p.35 印刷符号矛盾（E-W17），建议暂不作为独立推导入图；若入图必须在 `notes` 写明该矛盾。**
- status：`physical-argument`（推导链 (2.33)→(2.35)→(2.41)→(2.42)→(2.43) 完整可复算，但整条链的物理含义依赖节点 A 的 ansatz）。

### 建议节点 C：`holography.conformal-boundary-so2d`（共形边界与 SO(2,d) 匹配）

- 陈述：`AdS_{d+1}` 的共形边界是 `d` 维 Minkowski 空间的共形紧化 `M_d`（欧氏版为 `S^d`）；`AdS_{d+1}` 的等距群 `SO(2,d)` 在边界上作为**共形群**作用；边界只带**共形结构**不带度规。
  `sources: witten-1998-ads, §1 eq (1.1),(1.2); §2.1 eq (2.1)–(2.6) (v2)`。
- **status 可以比 A/B 高**：这部分是**纯几何**、可严格化（二次曲面 (1.1)(1.2)、Penrose 共形紧化、单位球模型 (2.1)、(2.2)–(2.4) 的共形类）。建议 `physical-argument`，补齐后可升 `proven`。**这是本方向最容易做 Lean 形式化的一块**（远比 Graham–Lee 容易）。
- 但 p.4 的 "**this is the only possible `SO(2,4)`-invariant relation between these two spaces**" 是**无证明的断言**；若单独立卡，status 应为 `conjecture` 或标 `inferred`。
- 相关的真数学定理（应单独立卡并指向原始文献，**不要**记成 Witten 的结果）：
  - Graham–Lee, "Einstein Metrics With Prescribed Infinity On The Ball," Adv. Math. **87** (1991) 186（Witten [42]）。
  - Fefferman–Graham, "Conformal Invariants," Astérisque (1985) 95，Theorems 2.1 & 2.3（Witten [44]）。
  - Breitenlohner–Freedman, Phys. Lett. **115B** (1982) 197 / Ann. Phys. **144** (1982) 197（Witten [24]）。

### 与 `ads5-cft4-duality-v2` 的关系：★ **Witten 判「精确化」，GKP 判「独立假设」——两篇不同**

- **Witten 侧：判「精确化」，有逐字背书。**
  - p.8 §2.3 首句："**We will now attempt to make more precise the conjecture [13]** relating field theory on the boundary of `AdS` space to supergravity (and string theory) in bulk."
  - p.2："**A precise recipe** for computing observables of the conformal field theory in terms of supergravity on `AdS_{d+1}` **was not given in [13]**; obtaining one will be the goal of the present paper."
  - 摘要："Here we **elaborate on this idea** and **propose a precise correspondence** …"
  - 另有三处把自己的设定挂在 [13] 上："in any one of the examples in [13]"（p.8）、"in the scenario of [13]"（p.10）、"under precisely the conditions proposed in [13]"（p.2）。
  - → 图上：**Witten 那条推导可以加 `depends_on: ads5-cft4-duality-v2`，不需要 `inferred: true`**。
- **GKP 侧：判「独立假设」。** 见 `gubser-klebanov-polyakov-1998.md` §5——GKP 只说 [14] "synthesized" 了两条路线，没有把 (12) 建立在 [14] 之上，全文不含 "conjecture"。若要连边须标 `inferred: true`。
- **由此得到的图结构建议（关键）**：
  - `holography.gkpw-dictionary` 挂**两条推导**：Witten 推导的 `depends_on` 含 duality 节点；GKP 推导**不含**。
  - 这样 `stringgraph status` 会给出一个有意义的结论：**即使 Maldacena 对偶被推翻，GKP 那条推导仍独立地把"超引力 on-shell 作用量 ↔ 规范理论关联函数"作为一条可单独证伪的假设立着**；反之若只挂 Witten 一条，字典会被错误地完全压在 duality 之下。
  - 这正是本项目"精确回答某条结论建立在多少条猜想之上"的价值点；建议 curator 保留这个**非对称结构**，并在节点 `notes` 里同时引本文件 §5 与 GKP 文件 §5。
- **附带建议**：新建一条陈述记录 **Witten §2.6 的 `SU(N)` 论证**（`k = 1` 态不出现在超引力 KK 谱中 ⇒ 对偶的是 `SU(N)` 而非 `U(N)`；`U(N)` 需在边界补一个 `U(1)` singleton，脚注 7）。这与 `ads5-cft4-duality-v2` 若沿用 Maldacena 的 `U(N)` 表述**直接冲突**，属 CLAUDE.md 原则 4 所说的"同一引理的不兼容表述"，应走里程碑规范化流程，不要私下改。




