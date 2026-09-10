# 抽取记录：ooguri-vafa-2006

- 文献：H. Ooguri and C. Vafa, *On the Geometry of the String Landscape and the Swampland*, arXiv:**hep-th/0605264**（报告号 CALT-68-2600, HUTP-06/A017）
- 抽取者：researcher agent
- 日期：2026-09-11
- 覆盖范围：**全文**（Abstract、§1 Introduction、§2 The Conjectures、§3 Evidences for the Conjectures、§3.1 Gravity Examples、§3.2 Non-Gravitational Counter-Examples、§4 Motivation from Effective Field Theories、§4.1、§4.2、§5 Concluding Thoughts、Acknowledgments、References）
- 目标 area：`swampland`

---

## 0. 核实方法与证据等级（必读）

### 0.1 本轮实际读到什么

| 项 | 内容 |
|---|---|
| 获取路线 | `WebFetch https://arxiv.org/pdf/hep-th/0605264` → PDF 落盘 157.5 KB → `Read(pages=1-5)` + `Read(pages=6-11)` + `Read(pages=12-18)` **逐页读页图** |
| 拿到的版本 | 页边条纹逐字为 `arXiv:hep-th/0605264v1  26 May 2006`；**是 v1，不是后续版本**；标题页页脚 `May 2006` |
| 页数 | PDF 共 18 页 = 标题页（无页码）+ 正文 p.1–p.15 + References p.16–p.17 |
| 缺失 | **无**。全文每一页都读到了 |

> **PDF 页码 ↔ 论文页码：论文 p.N = PDF 第 N+1 页。** 本文件「位置」栏一律给**论文页码**。

### 0.2 证据等级

沿用 `polchinski-1998-v1.md` §0 的 L1–L4 定义。本文件的 **L1 = 抽取者本轮亲自逐页读到 arXiv v1 的页图**，所有标 **[逐字]** 的都是真正的逐字引用。**本文件没有 L3 条目**（唯一的跨文献对照在 Q5/Q6，对照对象是本项目自己的另外两份 L1 抽取记录）。

### 0.3 ★ 编号结构：本文有**编号猜想**但几乎没有**编号公式**

这是本文与 `vafa-2005` 最重要的形式差异，直接决定 `loc` 怎么写：

1. **有五条编号猜想：`Conjecture 0`、`Conjecture 1`、`Conjecture 2`、`Conjecture 3`、`Conjecture 4`**，全部在 **§2 The Conjectures**（p.3–p.4）。**编号从 0 开始**（任务书猜的「Conjecture 1–4」少了 0 那条）。
   → **图节点的 `loc` 可以、也应该写「§2, Conjecture N, p.M」。**
2. **全文只有两个编号公式：`(1.1)`（p.1，圆的模空间度规 `ds² = (dr/r)²`）与 `(3.1)`（p.6，IIB dilaton-axion 度规 `ds² = dτdτ̄/(Imτ)²`）。** 其余所有公式（`T = |log(r/r₀)|`、`ε(T) ~ exp(−9T/8)`、Narain 陪集、一圈度规修正、FRW 方程等）**全部无编号**，逐页确认。
   → **除 (1.1) 与 (3.1) 外，绝不许编公式号。**
3. **⚠⚠ §3.1 的例子编号有 bug：出现了两个 `Example v)`。**
   - p.8：`Example v) Compactifications of Type II Strings on Calabi-Yau threefolds`
   - p.10：`Example v) Compactifications to Four Dimensions with N = 1 Supersymmetry`
   （前面依次是 i) M-theory on S¹、ii) Type IIB in 10d、iii) Type IIB on S¹、iv) Theories with 16 Supercharges，编号正常。）
   **而 §3.2 的 p.11 正文回指时逐字写「We saw in the example v in section 3.1 that, in theories with local `N = 2` supsersymmetries, the sign of curvature of vector multiplet moduli may be indefinite」——按内容这指的是第一个 v（CY 那条）。**
   → **图节点的 `loc` 绝不能只写「Example v」**，必须写成 `§3.1, Example v（Calabi-Yau threefolds）, p.8` 或 `§3.1, 第二个 Example v（4d N=1）, p.10`。（§3.2 的例子用字母 a)–d)，无此问题。）
4. **发表状态未核实（L0）。** 本轮只有 arXiv v1。

### 0.4 版本风险

**读的是 v1（2006-05-26）。** 后续版本（若有）与发表版的编号是否一致**本轮未核对**。由于本文的核心资产就是 `Conjecture 0`–`Conjecture 4` 这套编号，**`sources.bib` 与图节点必须写死 v1**。

---

## 1. 约定

### 1.1 该文自述/可从正文读出的约定

| 项 | 本文的取法 | 位置与等级 |
|---|---|---|
| **距离的单位** | **明确：Planck 单位**。逐字：「define `d(p₁,p₂)` for two points `p₁, p₂ ∈ M` as the distance of the shortest geodesic between them **measured in Planck units**」 | §2, p.3，**L1** |
| 模空间度规的来源 | 由标量场动能项定义。逐字：「Given that points on `M` are given by the expectation value of scalar fields, we can use their kinetic term to define a metric on `M`」 | §2, p.3，**L1** |
| 单标量情形的显式归一化 | §4.2 逐字：「choose its parametrization so that the metric in the moduli space is flat: `ds² = M_Pl^{-2}dφ²`, where `M_Pl` is the Planck mass. This means that the value of `φ` is the geodesic length times `M_Pl`.」 | §4.2, p.14，**L1** |
| 适用维数 | **≥ 4 维**。§2 逐字：「our conjectures apply to consistent quantum theories of gravity with finite Planck mass in 4 and higher spacetime dimensions. We do not consider 3 or lower dimensions as gravity does not contain propagating degrees of freedom in these dimensions, though some of our conjectures may be applicable to 3 dimensional cases as well.」 | §2, p.2，**L1** |
| 时空号差 | **全文未给出** | —，**L0** |
| `d` 的含义 | ⚠ **两处含义不同**：§4.1 的 `g_{ij}^{one-loop} = m(φ)^{d-4}∂m/∂φ^i ∂m/∂φ^j` 里逐字说「Here `d` is the spacetime dimensions of the Minkowski space」；§4.2 的 `φ̈ + dHφ̇ = 0` 里逐字说「where `d` is the spatial dimensions of flat directions」。**同一个字母，一处是时空维数，一处是空间维数。** | §4.1 p.13 / §4.2 p.14，**L1** |

### 1.2 与 `graph/conventions/` 的对照

| 图里的约定 | 是否适用 | 说明 |
|---|---|---|
| `conv.metric-mostly-plus` | **无法判定**（无号差信息） | 本文陈述与号差无关 |
| `conv.alpha-prime-regge` | **不适用**（无 `α'`、无弦张力） | —— |
| （建议新建）`conv.moduli-metric-planck-units` | **本文是这条约定的 canonical 来源** | 本文两处明确（§2 p.3「measured in Planck units」；§4.2 p.14 `ds² = M_Pl^{-2}dφ²`）。**`vafa-2005` 没有这一句**（见该文件 Q1），所以这条约定卡的来源应指本文而非 Vafa 2005 |

---

## 2. 陈述

编号 `E<n>`。转成节点时在节点 `notes` 写 `from: ooguri-vafa-2006#E<n>`。

---

### E1 摘要：本文自己给出的主张强度（**meta 条目，不要直接建节点**）

- 位置：Abstract，标题页 — **L1**
- 类型：meta（主张强度记录）
- 原文陈述 **[逐字，全文照抄]**：
  > "We make a number of conjectures about the geometry of continuous moduli parameterizing the string landscape. In particular **we conjecture that** such moduli are always given by expectation value of scalar fields and that **moduli spaces with finite non-zero diameter belong to the swampland.** We also **conjecture that** points at infinity in a moduli space correspond to points where an infinite tower of massless states appear, and that near these regions the moduli space is negatively curved. We also **propose** that there is no non-trivial 1-cycle of minimum length in the moduli space. This leads in particular to the **prediction** of the existence of a radially massive partner to the axion. These conjectures put strong constraints on inflaton potentials that can appear in a consistent quantum theory of gravity. **Our conjectures are supported by a number of highly non-trivial examples from string theory. Moreover it is shown that these conditions can be violated if gravity is decoupled.**"
- 文献自称的严格程度：**通篇 "conjecture"（两次）+ "propose"（一次）**；证据形式自陈为「supported by a number of highly non-trivial examples」；末句是「**it is shown that** these conditions can be violated if gravity is decoupled」——**注意「反例方向」用的是 "it is shown"，比正面方向强**。
- 备注（**对图 status 极关键**）：
  1. **摘要里「moduli spaces with finite non-zero diameter belong to the swampland」这句是 Conjecture 1 的 swampland 措辞版**，正文 Conjecture 1 本身不含 "swampland" 一词（见 E9）。引用时注意两者措辞不同。
  2. **摘要把「引力解耦时可违反」写成 "it is shown"**——这是本文里**唯一**一处用 "shown" 级动词的地方（另一处在 §3.2 的 `N=2` rigid limit 计算，见 E25）。这正是 Phase 4 双轨挂载里「反例方向」可以给较高 status 的原文依据。

---

### E2 §1 引言：swampland 的转述 + 「anomalous quantum gravitational theories」提法

- 位置：§1 Introduction，**p.1** — **L1**
- 类型：proposition（背景/转述）
- 原文陈述 **[逐字]**：
  > "However despite this diversity of options for the string landscape, it has been pointed out in [1] that there are also a number of patterns that seem to emerge. Not every effective field theory that appears consistent seems to arise in string theory. **It is natural to conjecture that these theories are not fully consistent as quantum gravitational theories. Such theories belong to the swampland.** The condition to be on the swampland can be lifted if we decouple gravity. In other words a fully consistent quantum field theory cannot always be coupled to gravity. **It is natural to conjecture that points on the swampland are "anomalous quantum gravitational theories," which are anomalous in a more subtle way, than has been discovered in the context of quantum field theories.** It would be important to improve the restrictions for theories to arise in string theory. By tabulating such restrictions and finding the criteria that distinguish the swampland from the landscape one can hope to have a deeper understanding into the universality class of quantum gravitational theories. The main aim of this paper is to take some modest steps in this direction. For some related conjectures distinguishing swampland from the landscape see [2,3,4,5]."
- 文献自称的严格程度：「It is natural to conjecture」（两次）。
- 文献列出的依赖：[1] = **C. Vafa, hep-th/0509212**（= 本项目的 `vafa-2005`）；[2] = Douglas–Lu "Finiteness of volume of moduli spaces" hep-th/0509224；[3] = **Arkani-Hamed–Motl–Nicolis–Vafa hep-th/0601001**（= 本项目的 `arkani-hamed-2006`）；[4] = Douglas, talk at Strings 2005（给了 URL `http://www.fields.utoronto.ca/audio/05-06/strings/douglas/`）；[5] = Kachru–McGreevy–Svrcek "Bounds on masses of bulk fields in string compactifications" hep-th/0601111。
- 备注（三点）：
  1. **本文把 swampland 的定义外包给 [1]（Vafa 2005），自己不重新定义。** 图里 swampland 的定义节点来源应是 `vafa-2005` E2，本条只作交叉引用。
  2. **"anomalous quantum gravitational theories" 这个提法是本文的**（不在 Vafa 2005），且加了引号，且只到「It is natural to conjecture」级。可作为一条 `speculation` 级评注，不建议单独建节点。
  3. **[3] 就是 `arkani-hamed-2006`**——即弱引力猜想。**这两篇是同期并列的判据，不是谁推出谁。**

---

### E3 §1 的引子：圆紧化的体积发散与 `ε` 截断（含唯一编号公式 (1.1)）

- 位置：§1，**eq. (1.1)**，**p.1–p.2** — **L1**
- 类型：proposition（引导例）
- 原文陈述 **[逐字，含公式]**：
  > "One conjectural criterion to be on the string landscape is that the volume of the moduli space seems typically finite. **There are, however, well known counter-examples to this seemingly general phenomenon.** Consider compactification on a circle of radius `r`. The moduli space for the circle has a metric
  >
  > `ds² = (dr/r)²,`   **(1.1)**
  >
  > and the volume integral is divergent. In [1], it was pointed out that this volume divergence correlates with the cutoff in mass. Namely, let `ε` be a fixed scale for the low energy effective theory and that we insist that all the higher massive scales have mass greater than `ε`. For large `r` and small `ε`, the region of the moduli of the moduli space satisfying this constraint is specified by `r < 1/ε`. Clearly the volume of this region of the moduli space is finite,
  >
  > `∫^{1/ε} dr/r = −log ε.`
  >
  > (The lower bound for the `r` integral should also be regularized in a similar fashion, as will be clear in our examples.) We find the logarithmic volume divergence as we take the limit `ε → 0`. Thus, in this case, the volume divergence is related to the emergence of infinitely many extra light particles."
- 文献自称的严格程度：陈述/计算。
- 文献列出的依赖：[1] = `vafa-2005`。
- 备注（**这是本文与 `vafa-2005` 关系的关键一条**）：
  1. **「体积有限」这条判据在本文开篇就被称为「seemingly general phenomenon」，并明说有「well known counter-examples」。** 圆紧化就是那个反例：朴素体积发散，只有引入 `ε` 截断后才有限（且是 `−log ε`，正好落在 Vafa 2005 允许的 `~|logΛ|` 范围内，见 `vafa-2005.md` E7）。
  2. **本文的 `ε` 与 Vafa 2005 的 `Λ` 是同一角色的两个记号。** 两文都没有把两者的关系写出来。
  3. **本文由此转向「距离」而非「体积」**——这是本文与 Vafa 2005 的实质分工（见 Q5）。
  4. ⚠ 原文「the region of the moduli of the moduli space」重复了 "of the moduli"，排印冗余，照抄。

---

### E4 §1 的图景总述：本文猜想合起来给出的模空间图像

- 位置：§1，**p.2** — **L1**
- 类型：meta（纲领）
- 原文陈述 **[逐字，整段照抄]**：
  > "Even though this divergence might seem special to 1-dimensional moduli spaces, here we wish to formulate conjectures applicable to *every* moduli space `M` encountered in string theory. Our conjectures apply both to the moduli space of scalars, as well as the subspaces parameterizing minimum loci for the potentials defined on such spaces. In this way our conjectures can be viewed as very powerful constraints on what potentials can appear in a consistent theory of quantum gravity.
  >
  > Our conjectures suggest the following picture for the moduli space of a consistent quantum gravitational theory: The moduli space is parameterized by expectation value of scalar fields. We conjecture that there are points infinitely far away from one another on the moduli space and that the points near infinity are points where a tower of massless modes appear (with exponentially small mass as a function of the distance to such points). **Infinite distance singularities combined with finite volume typically imply negative curvatures.** Thus, we conjecture that the curvature becomes negative near points at infinity. We also propose that there are no non-trivial loops of minimum length in the moduli space of scalars. As we will elaborate later this is in line with the intuition that the duality groups are generated by discrete gauge symmetries realized at different points on the moduli space."
- 文献自称的严格程度：全部 "conjecture"/"propose"。
- 备注：**「Our conjectures apply both to the moduli space of scalars, as well as the subspaces parameterizing minimum loci for the potentials」是本文对适用范围的关键扩张**——即猜想不只对无势能的模空间成立，也对有势能时的极小值轨迹成立。**这一句是「猜想约束暴胀势」这一推论的前提**，图里若建暴胀约束节点，必须把它写进依赖。

---

### E5 §2 的适用域声明（≥ 4 维、有限 Planck 质量、不限于弦论）

- 位置：**§2 The Conjectures 开头**，**p.2** — **L1**
- 类型：definition（适用域）
- 原文陈述 **[逐字]**：
  > "In this section we present our conjectures. **We claim that our conjectures apply to consistent quantum theories of gravity with finite Planck mass in 4 and higher spacetime dimensions.** We do not consider 3 or lower dimensions as gravity does not contain propagating degrees of freedom in these dimensions, though some of our conjectures may be applicable to 3 dimensional cases as well. Our conjectures should apply to string theories compactified to 4 and higher dimensions. **But they should also apply to other consistent quantum gravity theories in these dimensions if they exist.**"
- 文献自称的严格程度：「We claim」。
- 备注：**这一段必须进每条猜想节点的 statement 或 `uses`**，否则会得到一个「对任意维数成立」的错误陈述。**「finite Planck mass」这个前提与 `vafa-2005` 的「Newton 常数非零」是同一件事**（见 `vafa-2005.md` E7）。

---

### E6 模空间 `M` 的物理含义与「可局部变化」的假设

- 位置：§2，**p.3** — **L1**
- 类型：definition
- 原文陈述 **[逐字]**：
  > "Let `M` denote the moduli space of a consistent quantum gravity. Choosing a point `p ∈ M` corresponds to fixing the low energy effective Lagrangian for the theory. Different points in `M` are in different super-selection sectors. However, we could ask if we can vary `p` *locally* in spacetime while keeping the asymptotic boundary conditions fixed at `p`. **Our conjecture states that this is possible.** In addition, if we consider a finite volume compactification down to 0 or 1 spatial dimensions (say on a torus), then we can vary the point `p` and study `M`. Our first conjecture states that `M` is given by the expectation value of scalar fields."
- 文献自称的严格程度：「Our conjecture states that this is possible」。
- 备注：**「可局部变化」本身就是一条猜想**，但它**没有单独编号**，是 Conjecture 0 的前置说明。图里若要用，`loc` 写「§2, p.3（Conjecture 0 前的正文，无编号）」。

---

### E7 ★★ **Conjecture 0**（逐字）

- 位置：**§2, Conjecture 0, p.3** — **L1**
- 类型：proposition（猜想）
- 原文陈述 **[逐字]**：
  > "**Conjecture 0:** `M` is parameterized by inequivalent expectation values of massless scalar fields."
- 紧随其后的原文说明 **[逐字]**：
  > "This conjecture in the context of string theory is so well known that one does not even bother to state it: *There are no coupling constants in string theory*; every parameter can be varied by changing the expectation value of a field. This did not have to be the case and one could a priori imagine a consistent gravitational theory for which the parameters are fixed (and in particular cannot be varied locally). **We conjecture that such gravitational theories cannot exist as a fully consistent quantum gravitational theory and belong to the swampland.**"
- 文献自称的严格程度：**"Conjecture"**（标题即是）；说明里再次 "We conjecture that"。
- 文献列出的依赖：无。
- 备注（两点）：
  1. **这是本文唯一一条明确带 "belong to the swampland" 措辞的猜想说明**（Conjecture 1–4 的正文都不带这个词，只有摘要给 Conjecture 1 配了 swampland 措辞）。
  2. **证据形式自陈为「弦论里众所周知」**（"so well known that one does not even bother to state it"）——**这是一种极弱的证据形式**：它说的是「在弦论里成立」，而猜想断言的是「对任何一致量子引力理论成立」。图里这条边必须标出这个跨度。

---

### E8 距离 `d(p₁,p₂)` 的定义（Planck 单位）

- 位置：§2，**p.3**（Conjecture 1 之前） — **L1**
- 类型：**definition**
- 原文陈述 **[逐字]**：
  > "Given that points on `M` are given by the expectation value of scalar fields, we can use their kinetic term to define a metric on `M`. We can then state our next conjecture dealing with the geometry of `M`: Let us assume that the dimension of `M` is not zero. Let us define `d(p₁,p₂)` for two points `p₁, p₂ ∈ M` as **the distance of the shortest geodesic between them measured in Planck units.** We conjecture that the distance can take an arbitrary large value, namely:"
- 文献自称的严格程度：定义。
- 备注：**「measured in Planck units」是本项目 `conv.moduli-metric-planck-units` 约定卡的 canonical 逐字来源**（见 §1.2）。注意定义里含「**shortest geodesic**」——即用的是测地距离，不是任意路径长度的 inf（在完备流形上两者一致，但本文不讨论完备性）。

---

### E9 ★★ **Conjecture 1**（逐字）

- 位置：**§2, Conjecture 1, p.3** — **L1**
- 类型：proposition（猜想）
- 原文陈述 **[逐字]**：
  > "**Conjecture 1:** Choose any point `p₀ ∈ M`. For any positive `T`, there is another point `p ∈ M` such that `d(p,p₀) > T`."
- 文献自称的严格程度：**"Conjecture"**（标题）；前一句正文是 "We conjecture that the distance can take an arbitrary large value"（E8 末）。
- 文献列出的依赖：E6、E8。
- 备注（**三条红线**）：
  1. **陈述形式是「直径无界」**（对任意 `T` 存在超过 `T` 的点），**不是**「存在无穷远点」，也**不是**「体积无穷」。
  2. **摘要的 swampland 措辞版**是「moduli spaces with **finite non-zero diameter** belong to the swampland」（E1）。注意 **"non-zero"**——`dim M = 0` 的情形被 E8 的「Let us assume that the dimension of `M` is not zero」排除了。**图节点的 statement 必须带这个限定，否则「无模空间的理论」会被错误判入 swampland。**
  3. **这条与 `vafa-2005` 的「体积有限」是不同的猜想，两者相容但独立**（见 `vafa-2005.md` Q4 与本文件 Q5）。**把这条归给 Vafa 2005 是溯源错误。**

---

### E10 ★★ **Conjecture 2**（逐字，含两句）

- 位置：**§2, Conjecture 2, p.3** — **L1**
- 类型：proposition（猜想）
- 前置句 **[逐字]**：
  > "More strongly, we claim that the limit `d(p,p₀) → ∞` is correlated with a breakdown of the low energy effective theory in a particular way:"
- 原文陈述 **[逐字]**：
  > "**Conjecture 2:** Compared to the theory at `p₀ ∈ M`, the theory at `p` with `d(p,p₀) > T` has an infinite tower of light particles starting with mass of the order of `e^{-αT}` for some `α > 0`. In the `T → ∞` limit, the number of extra light particles of mass less than a fixed mass scale becomes infinite."
- 紧随其后的原文说明 **[逐字，整段]**：
  > "In the first part of the conjecture 2, we are claiming that the low energy effective theory defined on a particular point on the moduli space makes sense only in a domain in a finite diameter from the point. In section 4 we will give a physical motivation for this part of the conjecture. If the breakdown of the low energy theory is associated with an infinite number of extra light particles, one-loop graphs of such particles can give rise to the distance divergence. If only a finite number of particles becomes light, they alone do not generate the distance divergence for dimensions higher than 2. This motivates the second part of the conjecture 2. **Note that this conjecture in particular places strong constraints for inflationary models: We cannot have a slow roll inflation where the distance in the scalar moduli space is much bigger than Planck length and still use the same effective field theory.**"
- 文献自称的严格程度：**"Conjecture"**；前置句用 "we claim"。
- 文献列出的依赖：E9（Conjecture 1）；§4.1 给「physical motivation」（见 E29）。
- 备注（**四条，全部是常见误引点**）：
  1. **这就是通常所说的「距离猜想（Swampland Distance Conjecture）」的原始出处。** 但**原文没有用「distance conjecture」这个名字**——全文只叫它 `Conjecture 2`。**图节点若用「距离猜想」这个名字，note 必须写「此名非原文措辞」。**
  2. **`α` 是「some `α > 0`」，不是普适常数。** 原文在 §3.1 Example i 明确说 **[逐字]**：「Note that as this example demonstrates the coefficient of the exponent is not universal (9/8 and 3/8 in this case) even for a given dimension.」（E15）**「距离猜想的 `α` 是 O(1) 普适数」这类说法不在本文里。**
  3. **陈述是两句**：(a) 存在无穷塔，质量起于 `~e^{-αT}`；(b) `T → ∞` 时低于固定质量标度的粒子数趋于无穷。**原文自己把这两句分别称为 "the first part" 与 "the second part"**，且给了不同的动机。**图里可拆两卡（拆时不必标 inferred，原文自己就分了两部分）。**
  4. **暴胀约束是本条的直接推论**，且原文写在同一段，措辞是「places strong constraints」。

---

### E11 ★★ **Conjecture 3**（逐字）

- 位置：**§2, Conjecture 3, p.4** — **L1**
- 类型：proposition（猜想）
- 原文陈述 **[逐字]**：
  > "**Conjecture 3:** The scalar curvature near the points at infinity is non-positive. (It is strictly negative if the dimension of the moduli space is greater than 1.)"
- 紧随其后的原文说明 **[逐字，整段]**：
  > "The fact that the curvature is negative near infinity is correlated with the fact that there are points infinitely far away, even though the volume is finite.
  >
  > One could consider a stronger conjecture claiming various sectional curvatures being negative near infinity. The geodesics deviation equation shows that neighboring geodesics tend to diverge when curvatures are negative. In particular, in a compact space, this leads to mixing of geodesics. More precisely, it is known that the geodesics flow in a compact space with negative sectional curvatures is ergodic [6]. Our conjectures here go in that direction. However they are not quite the same condition, as for instance, there are points on `M` arising in string theory where the sectional curvature is positive, as will be noted in the next section. **Our conjecture here only refers to the scalar curvature being negative near infinity, which is weaker.** Nevertheless, it could be true that the geodesic motion on the moduli space is ergodic. This could be potentially true, independently of the above conjecture, and would be worth investigating."
- 文献自称的严格程度：**"Conjecture"**。
- 文献列出的依赖：[6] = D. V. Anosov, "Geodesic flows on closed Romanian manifolds with negative curvature," Proc. Steklov Inst. Mathematics **90**, 209 (1967)。⚠ **原文参考文献把 "Riemannian" 印成 "Romanian"**，照抄。
- 备注（**两条红线**）：
  1. **是「标量曲率」（scalar curvature），不是截面曲率（sectional curvature）。** 原文特意声明更强的截面曲率版本**不成立**（"there are points on `M` arising in string theory where the sectional curvature is positive"），并说自己这条 "is weaker"。**把 Conjecture 3 写成截面曲率是实质性错误。**
  2. **括号里的维数条件是猜想的一部分**：`dim M > 1` 时严格负，`dim M = 1` 时只保证非正。图节点必须带。

---

### E12 ★★ **Conjecture 4**（逐字）+ 两条动机 + 轴子伴侣预言

- 位置：**§2, Conjecture 4, p.4–p.5** — **L1**
- 类型：proposition（猜想）
- 原文陈述 **[逐字]**：
  > "**Conjecture 4:** There is no non-trivial 1-cycle with minimum length within a given homotopy class in `M`."
- 动机一（Teichmüller 商 / 不动点论证）**[逐字，含公式]**：
  > "Suppose `M` is obtained from dividing a contractible Teichmüller `T` space by a group action `Γ`, as is often the case in string theory:
  >
  > `M = T/Γ.`
  >
  > Then the duality group associated to `M` is `Γ`. Fixed points of `Γ` have a nice physical significance: If `g ∈ Γ` fixes a point `p ∈ T`, then `g` is a gauge symmetry at `p`. It seems to be the case that `Γ`'s that appear in string theory are generated by group elements which have fixed points. In other words the entire `Γ` can be viewed as a gauge symmetry which is broken as we move around in `M`, and we recover different parts of it at different points of `M`. If `Γ` is indeed generated by elements with fixed points, then `π₁(M)` would be trivial, as each loop which can be identified with an element `h ∈ Γ` can be written as `h = ∏g_i` and each `g_i` has fixed points and so the corresponding segment of the path can be contracted to a point. So the entire path would be contractible, thus making `M` simply connected. Clearly in this case there is no 1-cycle of minimum length."
- 动机二（全局荷 / 无毛定理）**[逐字]**：
  > "Another motivation for this conjecture is the following. Suppose we compactify the theory further down to (1+1) dimensions and choose the space to be a circle. If there is a non-trivial 1-cycle in `M` with minimum length, we can use it to define a state with a non-zero global charge by going over the corresponding path on the circle. Since there are no global charges in a gravitational theory (to be consistent with no-hair theorems for black holes), this cannot happen. **This suggests that at least the center of `π₁` is trivial.**"
- 轴子伴侣的推论 **[逐字]**：
  > "Conjecture 4 suggests there is a partner to the axion. The axion is massless before we take into account instanton effects, and its has a compact moduli space of `S¹`. If we can separate the scale of the instanton effects from those at the Planck scale so that the instanton effects are taken into account in the low energy effective theory, the conjecture 4 would require that there exists another direction where `S¹` shrinks to a point, *i.e.* a radial partner to the axion."
- 文献自称的严格程度：**"Conjecture"**；两条动机分别是 "It seems to be the case that"（不动点）与 "This suggests that"（全局荷）。
- 文献列出的依赖：无编号引用。
- 备注（**三点**）：
  1. **摘要把这一条叫 "propose"（"We also propose that there is no non-trivial 1-cycle…"），正文标题叫 "Conjecture 4"。** 措辞强度在两处不同，**引用时以正文的 Conjecture 4 为准，并可在 note 里记摘要用的是 propose**。
  2. **两条动机导出的结论强度不同**：不动点论证给「`M` 单连通」（强），全局荷论证只给「`π₁` 的中心平凡」（弱）。**原文自己指出了这个差距**（"at least the center of `π₁` is trivial"）。图里两条动机应是**两条独立的 derivation**，且第二条的 `summary` 必须写明它只给中心。
  3. **轴子的径向伴侣是本条的推论**（摘要称之为 "prediction"）。⚠ 原文 "and its has a compact moduli space" 的 "its" 系排印错误（应为 "it"），照抄。
  4. ⚠ **Conjecture 4 是本文里唯一一条被本文自己的例子明确违反的猜想**——§3.2 Example d) 的 `R⁴ × T²`（见 E28）。但那是**引力解耦**的情形，与 E5 的适用域声明不冲突。

---

### E13 §3 引言：证据的类型自陈

- 位置：**§3 Evidences for the Conjectures 开头**，**p.5** — **L1**
- 类型：meta（证据类型自陈）
- 原文陈述 **[逐字]**：
  > "In the following, we will present evidences for these conjectures. We will also present examples in string theory that, if we decouple gravity by taking the internal volume to be infinitely large, then these constraints disappears. So it is only a constraint in the context of quantum theories of gravity."
- 备注：**「evidences」而非「proof」**。⚠ 原文 "these constraints disappears" 主谓不一致，照抄。
  **这段是 Phase 4「双轨」的原文纲领**：§3.1 是成立方向（引力例子），§3.2 是**反面方向**（非引力反例）。**本文的结构本身就是双轨的**，这是本批三篇里对 ROADMAP Phase 4 最直接的支持。

---

### E14 §3.1 Example i)：M 理论 on `S¹`

- 位置：**§3.1, Example i), p.6** — **L1**
- 类型：proposition（证据）
- 原文陈述 **[逐字，含公式；公式无编号]**：
  > "In the 10-dimensional theory, which is equivalent to type IIA string, we have a massless scalar `r` whose vev gives the radius of the circle. Since the metric on this space is `(dr/r)²`, the geodesic distance between `r` and `r₀` is given by
  >
  > `T = |log(r/r₀)|.`
  >
  > Since `r` and `r₀` can take arbitrary positive values, **the conjecture 1 is clearly satisfied.**
  > If we fix `r₀` and take `T → ∞`, we have either `r → ∞` or 0. On the one hand, in the limit of `r → ∞`, the M theory develops light Kaluza-Klein modes with mass `1/r` in the 11-dimensional frame. In the Einstein frame in 10 dimensions, which involves rescaling the metric by `r^{1/4}`, we find the lowest mass scale `ε(T)` is
  >
  > `ε(T) ~ r^{-1/8}r^{-1} ~ exp(−(9/8)T)`
  >
  > On the other hand, for the compactification at `r = r₀e^{-T}`, the radius `r → 0` and the theory again develop light states, namely type IIA strings, corresponding to membranes wrapping `S¹`. The tension of the string will scale as `r`, which means that their mass in 11-dimensional frame scales as `r^{1/2}`. Or in 10-dimensional Einstein frame as
  >
  > `ε(T) ~ r^{-1/8}r^{1/2} = r^{3/8} ~ exp(−(3/8)T)`
  >
  > So we see that this result is consistent with the conjecture 2 since in both cases infinitely many light modes appear as `T → ∞`."
- 文献自称的严格程度：显式计算 + "is clearly satisfied" / "is consistent with"。
- 备注：见 E15（本例最重要的推论）。

---

### E15 ★ 指数系数 `α` **不普适**（原文明确声明）

- 位置：§3.1 Example i) 末，**p.6** — **L1**
- 类型：proposition（对 Conjecture 2 的限定）
- 原文陈述 **[逐字]**：
  > "Note that as this example demonstrates the coefficient of the exponent is not universal (9/8 and 3/8 in this case) even for a given dimension."
- 文献自称的严格程度：直接断言，由前面的计算支持。
- 备注（**这是本文最容易被后人误引的一条**）：Conjecture 2 里的 `α` 只有 `α > 0` 这一个约束。**同一个理论（M 理论 on `S¹`）的两个无穷远端给出两个不同的 `α`（9/8 与 3/8）。** 图里 Conjecture 2 的节点 statement 必须只写 `α > 0`，**note 必须带上本条**，防止后来者写成「`α` 是 O(1) 普适常数」。

---

### E16 §3.1 Example ii)：IIB dilaton-axion（含编号公式 (3.1)）

- 位置：**§3.1, Example ii), eq. (3.1), p.6–p.7** — **L1**
- 类型：proposition（证据，同时覆盖 Conjecture 1/2/3/4）
- 原文陈述 **[逐字，含公式]**：
  > "The dilaton-axion moduli space is `SL(2,**Z**)\SL(2,**R**)/SO(2)`, parametrized by `τ = τ₁ + iτ₂`, where `τ₁` and `τ₂` are related to vev's of the axion and the dilaton. The metric in this space is
  >
  > `ds² = dτdτ̄/(Imτ)².`   **(3.1)**
  >
  > **This is a good example to illustrate the point of our conjectures since the volume of this moduli space is finite yet a geodesic length toward `i∞` is logarithmically divergent.** As we take `τ → i∞` keeping `τ₀` finite, the geodesic length between `τ` and `τ₀` is approximately given by
  >
  > `T ~ log(Im τ/Im τ₀).`
  >
  > Since light stringy excitations of mass `~ e^{-T/4}` appear at `τ`, this exemplifies the conjectures 1 and 2.
  > The metric (3.1) has a constant negative curvature, consistently with the conjecture 3. The curvature integral as well as the volume integral is finite, thanks to the quotienting by the S-duality symmetry `SL(2,**Z**)`. It is known that the geodesic flow on compact spaces with constant negative curvatures is ergodic [7]. In particular, if we consider a region `τ₂ > 1/ε` in the fundamental domain, generic geodesics will pass through it within finite geodesic time.
  > **This moduli space is simply connected since `SL(2,**Z**)` is generated by `S` and `ST` transformations (`S : τ → −1/τ`, `T : τ → τ + 1`), both of which have fixed points in the fundamental domain, at `τ = i` and `τ = exp(2πi/3)` respectively.**"
- 文献自称的严格程度：显式计算 + "It is known that"（遍历性，引 [7]）。
- 文献列出的依赖：[7] = E. Hopf, Leipzig Ber. Verhandl. Sächs. Akad. Wiss. **91**, 261 (1939)；并指 G. W. Moore, "Finite in all directions," hep-th/9305139。
- 备注（**三点，对图很有用**）：
  1. **这条例子同时检验 Conjecture 1、2、3、4**，是本文最经济的一个证据点。
  2. ★ **「有限体积 + 无穷测地距离」在这里被原文明确点破**——这是 `vafa-2005`（体积）与本文（距离）**相容且独立**的最干净证据（见 Q5）。
  3. **这里的陪集写法是 `SL(2,Z)\SL(2,R)/SO(2)`（双侧商，正确写法）**，与 `vafa-2005` E9 的松散写法不同（见那份记录的备注 2）。**图里用本文的写法。**
  4. `ε` 在这里第二次出现（`τ₂ > 1/ε`），与 E3 的截断记号一致。

---

### E17 §3.1 Example iii)：IIB on `S¹`

- 位置：**§3.1, Example iii), p.7** — **L1**
- 类型：proposition（证据）
- 原文陈述 **[逐字，含公式]**：
  > "In this case the moduli space of compactification is characterized by the radius `r` of `S¹`, in addition to the `τ` space discussed above. This example is similar to the example i, and we have
  >
  > `T = |log(r/r₀)|`
  >
  > in string frame in 10 dimensions. We get light Kaluza-Klein modes for `r → ∞` and light winding modes for `r → 0`. In the 9-dimensional Einstein frame, this translates to the existence of light mass scales for large `T` given by
  >
  > `ε(T) ~ r^{-1/7}exp(−T) ~ exp(−(8/7)T)   or   exp(−(6/7)T)`
  >
  > Thus, both conjectures 1 and 2 are satisfied."
- 备注：**又一组不同的 `α`（8/7 与 6/7）**，进一步支持 E15。

---

### E18 §3.1 Example iv)：16 超荷（K3 与 heterotic on `T^d`）

- 位置：**§3.1, Example iv), p.7–p.8** — **L1**
- 类型：proposition（证据）
- 原文陈述 **[逐字，含公式]**：
  > "The classical moduli space of `K3` is
  >
  > `M_{K3}^{(classical)} = SO(3,19;**Z**)\SO(3,19)/(SO(2) × SO(19)).`
  >
  > This is the relevant moduli space for the 7 dimensional theory obtained by compactifying M-theory on `K3`. The physical moduli space of type II string on `K3` includes configurations of the NS-NS 2-form, the dilaton, and the R-R forms. In type IIA theory, the resulting moduli space, in addition to the coupling constant (as discussed in the example iii in the above), is
  >
  > `K_{K3}^{IIA} = SO(4,20;**Z**)\SO(4,20)/(SO(4) × SO(20)).`
  >
  > In type IIB theory, the coupling constant multiplet and other fields combine to give
  >
  > `M_{K3}^{IIB} = SO(5,21;**Z**)\SO(5,21)/(SO(5) × SO(21)).`
  >
  > In each of these moduli spaces, any point which is infinite distance away from points in the middle of the moduli space is dual to a decompactification limit. Therefore an infinite tower of light Kaluza-Klein modes appears at each of these points, in accord with the conjectures 1 and 2.
  > These spaces have negative curvatures, satisfying the conjecture 3. In general, if `Γ` is a lattice in a connected semi-simple Lie group `G` with finite center and `K` is a maximal compact subgroup of `G`, generic geodesics are dense in the coset space `Γ\G/K` [8] leading to ergodicity.
  > For the `K3` moduli space, the discrete group `Γ` is known to be generated by symmetry of the worldsheet CFT's [9,10], and this supports the expectation from the conjecture 4 that these moduli spaces are simply connected.
  > The same is true for heterotic/type I string compactified on `T^d`, whose moduli space (in addition to the coupling constant) is
  >
  > `SO(d,16+d;**Z**)\SO(d,16+d;**R**)/(SO(d) × SO(16+d)).`"
- 文献自称的严格程度：陈述 + "it is known"（遍历性引 [8]）+ 「supports the expectation」。
- 文献列出的依赖：[8] = C. C. Moore, "Ergodicity of flows on homogeneous spaces," Amer. J. Math. **88** (1966) 154；[9] = C. Vafa, "Quantum symmetries of string vacua," Mod. Phys. Lett. A **4**, 1615 (1989)；[10] = Aspinwall–Morrison "String theory on K3 surfaces" hep-th/9404151。
- 备注：⚠ **`M_{K3}^{(classical)}` 写的是 `SO(3,19)/(SO(2) × SO(19))`**——按 `SO(3,19)` 的最大紧子群应是 `SO(3)×SO(19)`。**页图上确实印的是 `SO(2)`。** 这**很可能是原文排印错误**，但抽取者不擅自改。**curator 引用这个空间前必须回原页复核，并在 note 里记「v1 印作 SO(2)，疑为排印错误」。**

---

### E19 §3.1 第一个 Example v)：CY 三折（含曲率的一般论证与一个 `π₁` 的微妙例子）

- 位置：**§3.1, Example v)（Calabi-Yau threefolds）, p.8–p.9** — **L1**
- 类型：proposition（证据）
- 原文陈述 **[逐字，节选，含公式]**：
  > "The moduli space splits into the vector multiplet moduli space, which has special Kähler structure, and the hypermultiplet moduli space, which is quaternionic Kähler. […] The Kähler moduli space has at least one infinite distance singularity corresponding to the decompactification limit, where infinitely many Kaluza-Klein modes become light. By the mirror symmetry, we expect that the complex moduli space has an infinite distance singularity. This demonstrates the conjecture 1.
  > **The curvature of the vector multiplet moduli space is not necessarily negative.** However, one can see from explicit examples as that in [11] that the scalar curvature asymptotes to negative toward infinite distance singularities. In fact, this is a general fact. By using results in [12], one can estimate the behavior of the metric near singularities. Since the moduli space is orientable, the Einstein action can be written as
  >
  > `∫_M √g R ~ ∫ c₁ ∧ k^{n-1},`
  >
  > where `c₁` is the first Chern class, `k` is the Kähler form, and `n` is the complex dimension of `M`. This can be expressed as an integral of the same quantity of a compactification `M̄` of `M`, which is topological, plus contributions from singularities. **One can show that infinite distance singularities always give strictly negative contributions to the integral,¹ as expected from the conjecture 2.** For Calabi-Yau manifolds with one Kähler moduli, the large size limit is always given by constant negative curvature (as the prepotential is dominated by `X₁³/X₀` in the standard notation)."
  >
  > 脚注 1 **[逐字]**：「We would like to thank Z. Lu for helping us make this estimate.」
  >
  > `π₁` 的例子 **[逐字]**：
  > "Are Calabi-Yau moduli spaces simply connected? One way to test this is to see whether monodromies of period integrals are generated by transformations with fixed points represented by Calabi-Yau manifolds with symmetries. One subtlety is that such points can be at infinite distance away from the middle of the moduli space, in which case one has to be careful about how to define `π₁`. Indeed there is an examples of where the moduli space is complex one-dimensional with two different large complex structure limits [13].² If we remove the two points in the limits, the moduli space has the topology of `C*` and is not simply connected. In this case, the length of a circle that goes around the non-trivial `π₁` of `C*` vanishes as the circle approaches to either one of the large complex structure limits. This follows from the fact that the limits are infinite distances away yet the volume of the moduli space is finite. **Therefore the conjecture 4 is still valid in this case.**"
  >
  > 脚注 2 **[逐字]**：「We thank D. Morrison for bringing this example into our attention.」
  >
  > 超多重态部分 **[逐字]**：
  > "As for the hypermulitplet moduli space, though a quaternionic Kähler manifold in general can have curvatures of any sign [14], it is known that those realized for hypermultiplet fields coupled to supergravity must have a negative scalar curvatures [15], satisfying the conjecture 2. Note that the negativity of the scalar curvature in this case is a direct consequence of the local `N = 2` supersymmetry, and therefore it applies to the hypermultiplet moduli space after perturbative and non-perturbative quantum corrections are taken into account as far as we consider the low energy effective theory with minimum number of derivatives."
- 文献自称的严格程度：**"One can show that"**（曲率贡献为负）+ **"it is known that"**（超多重态负标量曲率，引 [15]）。
- 文献列出的依赖：[11] = Candelas–De La Ossa–Green–Parkes NPB **359**, 21 (1991)；[12] = Lu–Sun, "On the Weil-Petersson volume and the first Chern class of the moduli space of Calabi-Yau manifolds," CMP **261**, 297 (2006), math.dg/0510021；[13] = Rodland, Compositio Math. **122**, 135 (2000)；[14] = J. A. Wolf, J. Math. Mech. **14**, 1033 (1965)；[15] = **Bagger–Witten, "Matter couplings in `N = 2` supergravity," NPB 222, 1 (1983)**。
- 备注（**四点，全部会咬人**）：
  1. ⚠ **原文两处把 "conjecture 3"（曲率）误写成 "conjecture 2"**：「as expected from the conjecture 2」（曲率积分为负那句）与「satisfying the conjecture 2」（超多重态负标量曲率那句）。**按内容这两处都应是 Conjecture 3。** 这是本文最实质的一处编号误植。**curator 若从本段取证据支持 Conjecture 3，note 必须写「原文 v1 印作 conjecture 2，判为误植」。**（判据：Conjecture 2 讲的是轻粒子塔，与曲率无关；Conjecture 3 才是曲率。）
  2. **超多重态那一支有真正的定理支撑**（Bagger–Witten 1983），且原文说这是「a direct consequence of the local `N = 2` supersymmetry」。**这是本文里 status 可能高于 conjecture 的极少数支点之一**（但需另抽 Bagger–Witten）。
  3. **向量多重态的曲率符号「不必为负」**——只有渐近行为为负。图节点必须区分「近无穷远处」与「整体」。
  4. ⚠ 原文排印错误：`there is an examples`、`hypermulitplet`、`bringing this example into our attention`。照抄。

---

### E20 §3.1 第二个 Example v)：4d `N=1` 通量紧化（对 Conjecture 1/2/4 一致）

- 位置：**§3.1, 第二个 Example v)（Compactifications to Four Dimensions with `N = 1` Supersymmetry）, p.10** — **L1**
- 类型：proposition（证据）
- 原文陈述 **[逐字，整段]**：
  > "Little is known about the metric on `M` in this case. To our knowledge, the conjectures 1, 2, and 4 are consistent with all known examples. (Without information on the metric, it is difficult to test the conjecture 3 about the curvature of `M`.) Consider for example the flux compactifications in [16]. In this construction, the classical superpotential generated by RR and NS-NS fluxes fixes all of the Kähler moduli and the complex structure moduli. There is one axion for each complex structure moduli multiplet that cannot be stabilized by the fluxes. In some models, these axions remain massless to all orders in `α'` and `g_s` expansions. However, in all known examples of this type, there are always instantons of the appropriate charges to lift all the remaining axions.³ Thus, it appears that there are obstructions in constructing models with compact moduli spaces with finite diameter (*i.e.* with a upper bound on `d(p,p₀)`) or with non-trivial fundamental group, and we regard this difficulty as in support of the conjectures 1, 2, and 4."
  >
  > 脚注 3 **[逐字]**：「We thank S. Kachru for discussion on this point.」
- 文献自称的严格程度：**"it appears that"** + **"we regard this difficulty as in support of"** —— 这是**否定式经验证据**（「造不出反例」），本文自己把它定性为 "difficulty"，不是证明。
- 文献列出的依赖：[16] = DeWolfe–Giryavets–Kachru–Taylor, "Type IIA moduli stabilization," JHEP **0507**, 066 (2005), hep-th/0505160。
- 备注：**注意 `loc` 陷阱**——这是**第二个** `Example v)`（见 §0.3 第 3 条）。**Conjecture 3 在这个例子里明确无法检验**（"it is difficult to test the conjecture 3"），图里不要把这条例子挂到 Conjecture 3 上。

---

### E21 ★★ §3.2 引言：反例的适用条件（**Phase 4 反例方向的原文纲领**）

- 位置：**§3.2 Non-Gravitational Counter-Examples 开头**，**p.10** — **L1**
- 类型：meta（反例方向的纲领）
- 原文陈述 **[逐字，整段]**：
  > "**We claim that the conjectures hold for theories with gravity with finite Planck scale. It is not difficult to construct non-gravitational field theory models which violate the conjectures.** In this sense our conjectures focus on what aspects of a consistent quantum theory are required purely from requiring having gravity. For example, if the theory has a compact global symmetry `G`, as is typically the case in quantum field theories, and if it is spontaneously broken to a subgroup `H`, the moduli space `G/H` has finite radius and the conjecture 1 fails in this case. Such spaces can have non-trivial fundamental groups, violating the conjecture 4 also. Since string theory cannot have any continuous global symmetry, such an example can exist only in the limit where we decouple gravity. **In the following, we will present examples to show how the violation of the conjectures is explicitly tied to the decoupling of gravity.**"
- 文献自称的严格程度：**"It is not difficult to construct … models which violate the conjectures"** —— 对反例方向的断言比正面方向强。
- 备注（**这是本批三篇里对 ROADMAP Phase 4「双轨挂载」最直接的原文支持**）：
  1. **`G/H` 这个反例是「一句话可验证」的**：紧全局对称群自发破缺给出有限半径的模空间，直接违反 Conjecture 1 与 4。
  2. **但它不构成对猜想的反驳**，因为猜想的适用域（E5）明确要求「有限 Planck 质量的引力理论」，而 `G/H` 例子要求连续全局对称性（弦论里没有）。
  3. → **图里 §3.2 的四个例子应建成 `kind: refutation` 的 derivation 挂到一个「猜想在引力解耦时失效」的独立 statement 上**，**而不是**挂到 Conjecture 1/2/3/4 本身。**把它们直接挂成 Conjecture 的 refutation 会让工具把 Conjecture 的 status 打到 `refuted`，那是记账错误。** 这与 `vafa-2005.md` §5.2(c) 的告诫是同一件事。

---

### E22 §3.2 Example a)：平 D 膜上的场论（违反 Conjecture 2 但满足 1）

- 位置：**§3.2, Example a) Field Theories Living on Flat D-Branes in `R^10`, p.11** — **L1**
- 类型：proposition（反例）
- 原文陈述 **[逐字，整段]**：
  > "The gauge theory on flat parallel `Dp` branes in `R^{10}` contains `(9 − p)` massless scalar fields in the adjoint representation of the gauge group. If we go to a generic direction away from the origin of the moduli space, we can go to infinity along geodesic without encountering extra massless particles. **Therefore, this gives an example where the distance `d(p,p₀)` can become infinite (and therefore the conjecture 1 holds), but no new massless particles appear there (and the conjecture 2 fails).** In this case, the gravity degrees of freedom in the bulk 10 dimensions is decoupled. To have a finite Planck scale in `(p + 1)` dimensions along the branes, we need to compactify the transverse direction appropriately. This will change the structure of the gauge theory moduli space."
- 文献自称的严格程度：显式构造。
- 备注：**这是本文里最干净的一条「Conjecture 1 成立而 Conjecture 2 失效」的分离例子**——它证明**两条猜想逻辑独立**。这与 §4.1 末的独立性声明（E30）一致。

---

### E23 §3.2 Example b)：`N=2` 的 rigid limit（含 Ricci 曲率正定的显式计算）

- 位置：**§3.2, Example b) Rigid Limit of `N = 2` Theories in Four Dimensions, p.11–p.12** — **L1**
- 类型：proposition（反例 + 计算）
- 原文陈述 **[逐字，含公式]**：
  > "We saw in the example v in section 3.1 that, in theories with local `N = 2` supsersymmetries, the sign of curvature of vector multiplet moduli may be indefinite, but the scalar curvature becomes strictly negative near infinite distance singularities.
  > On the other hand, **it is straightforward to see that, in non-gravitational theories with global `N = 2` supersymmetry, the Ricci curvature of the vector multiplet moduli space is positive definite.** In this case, the metric can be written as
  >
  > `g_{ij̄} = Im τ_{ij},      τ_{ij} = ∂_i∂_j F(z),`
  >
  > where `F(z)` is the pre-potential. The Ricci curvature then is
  >
  > `R_{ij̄} = −∂_i∂̄_j log det g`
  > `    = (1/4) g^{kl̄} g^{mn̄}(∂_iτ_{km})(∂̄_j τ̄_{l̄n̄}),`
  >
  > which is manifestly positive definite. The essential step is to use the fact that `g_{ij̄}` is the imaginary part of `τ_{ij}`, which is holomorphic in `z`.
  > It is instructive to see how the decoupling of the gravity leads to the positive definite Ricci curvature. In a theory with local `N = 2` supersymmetry, the Kähler potential `K` for the moduli space metric is given by [17]
  >
  > `K = −log(4F − 4F̄ + z̄^i̅∂_iF − z^i ∂̄_i F̄),`
  >
  > where `F(z)` is the pre-potential of the gravitational theory. The rigid limit can be taken by setting
  >
  > `F(z) = (i/8)M_{Pl}² + F(z),`
  >
  > and let `M_{Pl} → ∞`. The Kähler potential then becomes, modulo terms that are purely holomorphic or anti-holomorphic,
  >
  > `K = −log iM_{Pl}² + (1/(iM_{Pl}²))(z̄^i̅∂_iF(z) − z^i∂̄_iF̄(z̄)) + ⋯.`
  >
  > in this limit, the metric `g_{ij̄}` becomes an imaginary part of the holomorphic `τ_{ij}` and the Ricci curvature is positive definite. **This shows how the conjecture 2 can be violated by taking the decoupling limit `M_{Pl} → ∞`.**"
- 文献自称的严格程度：**"it is straightforward to see"** + **"This shows how"** + **"which is manifestly positive definite"** —— **这是本文里最接近严格论证的一段**（一段有限步的复几何计算）。
- 文献列出的依赖：[17] = de Wit–Van Proeyen, NPB **245**, 89 (1984)。
- 备注（**三点**）：
  1. ⚠ **末句又把 Conjecture 3 写成 "the conjecture 2"**（与 E19 同型的误植）。曲率是 Conjecture 3。**这是本文第三处该类误植。**
  2. **原文的两个 `F`（花体 `F` 与直体 `F`）在 `F(z) = (i/8)M_{Pl}² + F(z)` 里是不同的量**（左边是引力理论的 pre-potential，右边是刚性极限的）。**页图上字体可区分，转成纯文本后丢失。** curator 引用此式必须回原页。
  3. **这一段的 Ricci 曲率计算是「有限步初等计算」型的**，按 `docs/STATUS_LEVELS.md` 的 lead 裁决（2026-09-10），若 reviewer 独立复核可标 `rigorous`。**这是 swampland 区少见的可升级点。**

---

### E24 §3.2 Example c)：非紧 CY 上的缠绕膜（违反 Conjecture 1 与 3）

- 位置：**§3.2, Example c) Type II Strings on Non-Compact Calabi-Yau Manifolds with wrapped branes, p.12** — **L1**
- 类型：proposition（反例）
- 原文陈述 **[逐字]**：
  > "Another way to obtain field theories decoupled from gravity is to consider D-branes on cycles in a non-compact Calabi-Yau manifold `M` and to take the low energy limit. For example, consider a brane at a point in `M`. Though the moduli space metric is not exactly equal to that of `M` [18,19], the metric computed using the gauge theory method of [20] is typically Ricci flat [21]. In particular, its scalar curvature does not necessarily become negative as we go infinite distance away from the origin of `M`.
  > As another example, consider a non-compact local model of Calabi-Yau manifold with small `P²`. The moduli space of a brane wrapping a 2-cycle in `P²` is a copy of `P²` (see [22] for a study of 2 branes in this geometry). **Note that this space is compact (violating conjecture 1) and positively curved (violating conjecture 3).** Note that cycles can shrink in a Calabi-Yau manifold only when they are positively curved. This may be related to the fact that scalar moduli coupled to gravity tend to be negatively curved, as suggested in the conjecture 3."
- 文献自称的严格程度：陈述 + 引用他处的度规计算。
- 文献列出的依赖：[18] = Douglas–Ooguri–Shenker PLB **402**, 36 (1997), hep-th/9702203；[19] = Douglas–Ooguri PLB **425**, 71 (1998), hep-th/9710178；[20] = Douglas–Moore hep-th/9603167；[21] = Douglas–Greene ATMP **1**, 184 (1998), hep-th/9707214；[22] = Katz–Klemm–Vafa ATMP **3**, 1445 (1999), hep-th/9910181。
- 备注：**这里的 Conjecture 编号是对的**（1 与 3），与 E19/E23 的误植形成对照——说明那两处确实是笔误而非另一种编号体系。

---

### E25 §3.2 Example d)：`T²` 上的 D5 膜（违反 Conjecture 4）

- 位置：**§3.2, Example d) D-brane Wrapping `T²`, p.12** — **L1**
- 类型：proposition（反例）
- 原文陈述 **[逐字]**：
  > "Consider type IIB compactified on `T²` to 8 dimensions. Consider a D5 brane wrapping `T²` and filling a 3+1 dimensional flat subspace of 8 dimensions. The theory living on this 4 dimensions is a deformed `N = 4` Yang-Mills, where out of the 6 scalars, two of them (corresponding to the Wilson lines on `T²`) are periodic. The theory on this brane does not have a dynamical gravity in 4 dimensions (as the transverse dimensions are non-compact) and we have the moduli space of the theory given by
  >
  > `R⁴ × T²`
  >
  > **This clearly violates conjecture 4 which states that the moduli space should have no non-trivial loops. `T²` has non-trivial loops.**"
- 文献自称的严格程度：**"This clearly violates"** —— 直接构造。
- 备注：**这是四个反例里最短、最可验证的一个**，与 E21 的 `G/H` 一起是「反例方向」的最佳图节点候选。

---

### E26 §4.1：Conjecture 2 的场论动机（一圈度规修正）+ 有限多轻粒子不够

- 位置：**§4.1 Infinite Distances and Appearance of a Tower of Light States, p.13** — **L1**
- 类型：proposition（动机/论证）
- 原文陈述 **[逐字，含公式；公式无编号]**：
  > "The conjecture 2 implies that there is an infinite tower of light particles at infinite distance from any point inside the moduli space, where the effective field theory in the interior breaks down, and potentially a new description takes over. This is consistent with the following field theory fact.
  > Suppose there is a field `φ` [原文用 varphi], whose mass `m(φ)` is a function of the moduli field `φ`. We assume that `m(φ)` is generically large in the moduli space `M` so that we can integrate out `φ`. Now suppose there is a particular point `φ₀ ∈ M` where `m(φ₀) = 0`. There the effective field theory with `φ` integrated out breaks down. To see its effect on the moduli space metric, let us look at how the one-loop diagram of the `φ` field modifies the kinetic term of `φ`. If `φ` is a scalar field, the coupling between `φ` and `φ` is given by `L_int = m(φ)²φ²`, and it gives the one-loop correction:
  >
  > `g_{ij}^{one-loop} = m(φ)^{d-4}(∂m/∂φ^i)(∂m/∂φ^j).`
  >
  > Here `d` is the spacetime dimensions of the Minkowski space where we are considering the gravity theory. Consider a point `φ₁` near `φ₀` where `m(φ₁) = ε ≪ 1` (in Planck units). The distance to `φ₁` measured by the quantum corrected metric in the above is given by
  >
  > `d(φ,φ₁) = ∫_ε m^{(d-4)/2}dm = −(2/(d−2))ε^{(d-2)/2} + finite.`
  >
  > **Thus, a finite number of light particles does not generate infinite distance for `d > 2`.** We get the same result if the light particle is a fermion `ψ` with an interaction `L_int = m(φ)ψ̄ψ`.
  > On the other hand, a sum over one-loop effects of an infinite tower of light particles can produce a distance divergence in a quantum corrected metric. This field theory fact is consistent with our conjecture that an infinite distance singularity in the moduli space is correlated to an emergence of an infinite tower of light states."
- 文献自称的严格程度：一圈场论计算（"This is consistent with the following field theory fact"）。
- 备注：⚠ **原文用 `φ`（varphi）表示重场、`φ`（phi）表示模场，两者在页图上可区分，转纯文本后极易混淆。** 本文件已用 [原文用 varphi] 标出。**curator 引用此式必须回原页。**
  另注意 `d` 在这里是**时空维数**（与 §4.2 的空间维数不同，见 §1.1）。

---

### E27 ★ Conjecture 1 与 Conjecture 2 相互独立（原文明确声明 + 反例）

- 位置：§4.1 末，**p.13–p.14** — **L1**
- 类型：proposition（独立性声明）
- 原文陈述 **[逐字]**：
  > "Note, however, that we are not claiming that the infinite distance in moduli space is a direct consequence of having an infinite tower of massless states. **Indeed it is possible to show that these are independent conjectures and one conjecture does not follow from the other.** For example, the KK tower of light states (which can affect the distance in moduli space at one loop level) is not directly related to an infinite distance in the moduli space which is observable at tree level. **Also sometimes there is an infinite tower of light states but at finite distance. This typically happens at conformal fixed points.** For example consider M-theory compactified on a Calabi-Yau 3-fold near a point in moduli where a `P²` inside the Calabi-Yau shrinks to a point. This leads to an infinite tower of light M2 branes wrapping shrinking cycles in `P²`. **Nevertheless the distance in moduli space where `P²` shrinks to zero size is finite.**"
- 文献自称的严格程度：**"it is possible to show that these are independent conjectures"**。
- 备注（**对图极其重要**）：
  1. **这条明确禁止把 Conjecture 2 建成 Conjecture 1 的推论，反之亦然。** 图里两条必须是**独立 statement**，不能有 `depends_on` 边。
  2. **「无穷塔但有限距离」的例子（收缩 `P²`）是 Conjecture 2 的逆命题的反例**——即「无穷塔 ⇏ 无穷距离」。加上 E22（Example a：无穷距离但无新轻粒子，即「无穷距离 ⇏ 无穷塔」，虽然那是在引力解耦下），**两个方向都有反例**。
  3. ⚠ 注意 E22 的反例在**引力解耦**情形，而本条的收缩 `P²` 例子在**有引力**的 M 理论紧化里。**后者是真正在猜想适用域内的、对「Conjecture 1 ⟸ Conjecture 2」的反驳**，但**它不反驳 Conjecture 2 本身**（Conjecture 2 说的是无穷距离 ⇒ 无穷塔，不是逆命题）。**这是本文里最容易记错账的一处逻辑，curator 必须在 note 里写清方向。**

---

### E28 §4.2：可观测的模空间区域（宇宙学论证）

- 位置：**§4.2 Observable Regions of Moduli Spaces, p.14–p.15** — **L1**
- 类型：proposition（动机/论证）
- 原文陈述 **[逐字，含公式；公式无编号]**：
  > "For simplicity, let us consider the case when there is one massless scalar field `φ` and choose its parametrization so that the metric in the moduli space is flat: `ds² = M_{Pl}^{-2}dφ²`, where `M_{Pl}` is the Planck mass. This means that the value of `φ` is the geodesic length times `M_{Pl}`.
  > Suppose `φ` is homogeneous in space. If it were not for gravity, `φ` would evolve linearly in time `t`. If we turn on the gravity and assume that the vacuum energy is dominated by the kinetic term of `φ`, we have the Freedman-Robertson-Walker cosmology, where the Hubble friction slows down the scalar velocity `φ̇ = dφ/dt`:
  >
  > `φ̈ + dHφ̇ = 0,     H² = φ̇²/M_{Pl}²,`
  >
  > where `d` is the spatial dimensions of flat directions. With the initial condition, `φ̇(t = 0) = c`, we can integrate this to find
  >
  > `φ(t) = φ(0) + (M_{Pl}/d)log(1 + (c/M_{Pl})t).`
  >
  > In particular, `φ(t)` grows like `log t` for large `t`.
  > […] When `t ≫ 1/H_others`, the velocity of the scalar field starts to decay exponentially, `φ̇ ~ exp(−d H_others t)` and the evolution of `φ` is shut off. Thus we find that
  >
  > `|φ(t) − φ(0)| ~ −(M_{Pl}/d)log H_others,     t → ∞.`
  >
  > If we identify `H_others` with the mass scale `ε` for the low energy effective theory, this takes the same form as the logarithmic cutoff `T < −M_{Pl}log ε` for the geodesic length in the moduli space. **This suggests that the classical evolution of the field `φ` cannot probe the region where the low energy effective theory breaks down by the appearance of an infinite tower of light particles.** Similar ideas have been considered in [23,24]."
- 文献自称的严格程度：显式 FRW 计算 + "This suggests that"。
- 文献列出的依赖：[23] = T. Banks, "A critique of pure string theory: Heterodox opinions of diverse dimensions," hep-th/0306074；[24] = Banks–Dine–Gorbatov, "Is there a string theory landscape?," JHEP **0408**, 058 (2004), hep-th/0309170。
- 备注：⚠ 原文把 "Friedmann" 印成 **"Freedman"**，照抄。
  注意 `d` 在这里是**空间维数**（与 §4.1 的时空维数不同）。

---

### E29 §5 结论：作者自陈「即使证明成立也还需要知道为什么」

- 位置：**§5 Concluding Thoughts, p.15** — **L1**
- 类型：meta（自陈）
- 原文陈述 **[逐字，整节照抄]**：
  > "We have raised a number of conjectures about the geometry of scalar moduli in a consistent quantum theory of gravity. **We find determination of whether or not these and similar conjectures are true or false as critical to a deeper understanding of what constitutes the universality class of quantum gravitational theories.** Ultimately we would need to learn more: Even if we establish they are correct we would need to know *why*! This would presumably involve deep questions of gravity, such as questions involved in the context of black hole. It would be very satisfying if we can relate such geometric questions on moduli of scalar fields to deeper issues involving black holes and holography. We hope raising such question will contribute to asking deeper questions in the context of quantum gravity and how an effective field theory can be possibly consistent with it."
- 备注：**"whether or not these … are true or false" 是 Phase 4 双轨挂载的原文授权句**——作者本人把「真」与「假」并列为待定。这与 `vafa-2005` E14 的 "verify or disprove" 是同一姿态。

---

## 3. 未核实项清单

本次抽取对**原文本身**的覆盖是完整的（18 页逐页读图，L1）。下列各项是**超出原文之外**、本轮没有核实的东西。

| # | 未核实项 | 影响 | 建议做法 |
|---|---|---|---|
| U1 | **是否有 v2 及发表版**，编号是否一致（L0） | 本文的核心资产是 Conjecture 0–4 的编号 | `sources.bib` 与所有 `loc` **写死 v1** |
| U2 | **参考文献 [1]–[24] 的内容**，本文件只抄了书目条目 | 「原文说 [15] 证明了 X」只是转述 | **Bagger–Witten NPB 222, 1 (1983)** 是最值得单独抽的一篇（E19：超多重态负标量曲率是局部 `N=2` 超对称的直接后果，可能是 swampland 区唯一能到 `rigorous` 的物理支点） |
| U3 | **E18 的 `SO(3,19)/(SO(2)×SO(19))` 是否排印错误** | 影响该空间的节点 | 页图上确实印 `SO(2)`。按最大紧子群应为 `SO(3)`。**引用前必须回原页复核，并在 note 记疑点** |
| U4 | **E19、E23 三处「conjecture 2」是否确为「conjecture 3」的误植** | 影响 Conjecture 3 的证据集合 | 抽取者按内容判定为误植（曲率是 Conj 3），但**未与作者/后续版本核对**。图里必须写「原文 v1 印作 conjecture 2」 |
| U5 | **E23 的 Kähler 势 `K = −log(4F − 4F̄ + …)` 与 `F(z) = (i/8)M_Pl² + F(z)` 中花体/直体 `F` 的区分** | 若转录丢失字体，公式无意义 | **curator 引用必须回原页图** |
| U6 | **E26 的 `varphi`（重场）与 `phi`（模场）的区分** | 同上 | 同上 |
| U7 | **两个 `Example v)` 是否在后续版本被修正** | 影响 `loc` 的可复现性 | 见 §0.3 第 3 条的写法要求 |

---

## 4. 未解决的疑问

### Q1 — Conjecture 0 的适用性：`M` 的维数可以是 0 吗？

Conjecture 0（E7）说 `M` 由无质量标量场的期望值参数化，但**没有排除 `dim M = 0`**。而 Conjecture 1（E9）之前的正文明确说「Let us assume that the dimension of `M` is not zero」（E8），摘要也说「moduli spaces with **finite non-zero** diameter」。

→ **问题**：一个完全没有模的一致量子引力理论（`dim M = 0`）是否违反 Conjecture 1？按 E8 的假设，Conjecture 1 **不适用**于这种情形。**但 Conjecture 0 的说明段（E7）又说「parameters are fixed（且不能局部变化）的引力理论……属于 swampland」**，这似乎在说 `dim M = 0` 本身有问题。

**两处措辞有张力，本文没有裁决。** → 图里 Conjecture 1 的 statement **必须**带「`dim M ≠ 0`」这个限定；Conjecture 0 的节点 note 应记下这个张力。

---

### Q2 — 三处「conjecture 2」应为「conjecture 3」（编号误植）

见 E19（两处）与 E23（一处）。全部出现在**曲率**语境里。

**判定依据**（抽取者的推理，非原文）：
- Conjecture 2 讲的是「无穷塔轻粒子」，与曲率无关；
- Conjecture 3 是唯一讲曲率的猜想；
- 同一篇的 E24（Example c）在同样的曲率语境里写的是「violating conjecture 3」，**编号正确**。

→ **本轮判定为排印错误，但不擅改。** 图节点若引这三处，`loc` 与 note 必须写「原文 v1 印作 conjecture 2，按内容判为 conjecture 3 的误植（本项目判定，非原文）」，并标 `inferred: true`。

---

### Q3 — Conjecture 2 的 `α` 有没有下界？

Conjecture 2（E10）只说 `for some α > 0`。E15 明确说系数不普适（9/8 vs 3/8），E17 又给 8/7 与 6/7。

**问题**：`α` 能否任意小？若能，则「`e^{-αT}`」这个形式在 `α → 0` 时退化为无内容。**本文没有讨论。**

→ 图节点的 statement 只写 `α > 0`，note 带 E15 与 E17 的四个具体值，并写「本文未讨论 `α` 是否有下界」进 `gaps`。

---

### Q4 — 「无穷塔」的计数方式：`e^{-αT}` 是塔的**最轻**质量还是**间距**？

Conjecture 2 逐字是「an infinite tower of light particles **starting with** mass of the order of `e^{-αT}`」。**"starting with" 只约束了塔的起点（最轻的那个），没有说塔内的质量间距。** 第二句说的是「低于固定质量标度的粒子数 → ∞」，这是对**计数**的约束，也不是间距。

→ 图节点必须逐字保留 "starting with"，**不要**写成「塔的所有态质量都是 `e^{-αT}` 的整数倍」之类的加强版（那是后来文献的内容，不在本文里）。

---

### Q5 — ★ 本文与 `vafa-2005` 的分工：体积 vs 距离

| | `vafa-2005` | `ooguri-vafa-2006` |
|---|---|---|
| 核心量 | 模空间**体积** `V_Φ` | 模空间**距离/直径** `d(p,p₀)` |
| 陈述 | `V_Φ ≠ ∞`（允许 `~\|logΛ\|`） | 直径无界（Conjecture 1） |
| 单位 | **未指定**（`vafa-2005.md` Q1） | **Planck 单位**（E8） |
| 编号 | 无编号猜想 | Conjecture 0–4 |
| 关系 | **相容且独立** —— 本文 E16 逐字：「the volume of this moduli space is **finite** yet a geodesic length toward `i∞` is logarithmically **divergent**」 | 同左 |

**本文 §1 开篇（E3）还把「体积有限」称为有「well known counter-examples」的 "seemingly general phenomenon"**——这是对 Vafa 2005 判据的**软化**，虽然本文引 [1] 时是正面引用。

→ **图里两条必须是独立 statement，禁止合并，禁止把 Conjecture 1 归给 `vafa-2005`。** 详见 `vafa-2005.md` Q4。

---

### Q6 — 本文与 `arkani-hamed-2006` 的关系

- 本文 [3] 引 `arkani-hamed-2006`（hep-th/0601001），日期上后者（2006-01）早于本文（2006-05）。
- 但两文**互不依赖**：本文的五条猜想里没有一条用到弱引力猜想；`arkani-hamed-2006` 的正文也没提距离/曲率/1-cycle。
- **唯一的接触点**：`arkani-hamed-2006` §2.1 末逐字说自己的界「a statement not independent of conjecture about the finiteness of the volume of moduli spaces in [1]」——那个 [1] 是 **`vafa-2005`**（体积），**不是本文**。

→ 图里 swampland 区的三条主线（Vafa 的有限性、OV 的几何、AMNV 的弱引力）**在原文层面是三个并列的判据族，彼此没有推导关系**。**任何把它们连起来的边都必须标 `inferred: true`。**

---

## 5. 给图的建议

> 以下是**建议**，不是改动。researcher 只写 `literature/`，下列节点由 curator 落地。

### 5.1 核心结论：本文提供了本项目 swampland 区**唯一**一套有编号、可精确引用的猜想

`loc` 可以写死为 `§2, Conjecture N, p.3–4`（v1）。**这使本文成为 swampland 区节点的首选锚点**（`vafa-2005` 只能写「§N, p.M」）。

| 类别 | 内容 | 抽取条目 | 建议 kind / status |
|---|---|---|---|
| **定义** | 距离 `d(p₁,p₂)` = 最短测地线长度，Planck 单位 | **E8** | `definition` / `rigorous` |
| **定义（适用域）** | ≥ 4 维、有限 Planck 质量、含势能极小轨迹 | **E5、E4** | `definition` / `rigorous` |
| **猜想** | Conjecture 0：`M` 由无质量标量期望值参数化 | **E7** | `proposition` / `conjecture` |
| **猜想** | Conjecture 1：直径无界（`dim M ≠ 0`） | **E9** | `proposition` / `conjecture` |
| **猜想** | Conjecture 2（两部分）：无穷远 ⇒ 无穷塔轻粒子，`m ~ e^{-αT}`，`α > 0` | **E10** | `proposition` / `conjecture`（**建议按原文的 first/second part 拆两卡**） |
| **猜想** | Conjecture 3：无穷远处标量曲率非正（`dim M > 1` 时严格负） | **E11** | `proposition` / `conjecture` |
| **猜想** | Conjecture 4：同伦类内无最小长度的非平凡 1-cycle | **E12** | `proposition` / `conjecture` |
| **推论** | 轴子有径向伴侣 | **E12** | `proposition` / `conjecture`（依赖 Conjecture 4 + 「瞬子尺度可与 Planck 尺度分离」这个前提） |
| **推论** | 慢滚暴胀的模空间位移不能远超 Planck 长度而仍用同一 EFT | **E10** | `proposition` / `conjecture` |
| **有定理级支撑的支点** | 超多重态模空间标量曲率为负（局部 `N=2` 超对称的直接后果） | **E19** | 需先抽 Bagger–Witten NPB 222 (1983)。**这是 swampland 区最可能升到 `rigorous` 的物理支点** |
| **可复核的初等计算** | 全局 `N=2` 向量多重态的 Ricci 曲率正定 | **E23** | 按 `STATUS_LEVELS.md` 的 lead 裁决，reviewer 复核后可标 `rigorous`。**这是「反例方向」的最强节点** |

### 5.2 ★★ Phase 4 双轨挂载：本文是本批三篇里唯一自带完整双轨结构的

`docs/ROADMAP.md` Phase 4 要求「每条沼泽地猜想双轨挂载（成立方向 / 反例方向）」。**本文 §3.1 = 成立方向，§3.2 = 反例方向，是原文自带的结构**（E13 逐字纲领）。

**建议的推导布局**（以 Conjecture 1 与 2 为例；3、4 同型）：

```
swampland.ov-conjecture-1-unbounded-diameter        status: conjecture
  --via-string-examples            kind: conjecture-support   status: conjecture
      depends_on: 〈适用域声明 E5〉, 〈距离定义 E8〉
      sources: ooguri-vafa-2006, loc "§3.1, Examples i–v, p.6–10（v1）"
      summary: M/S¹、IIB 10d、IIB/S¹、16 超荷、CY 三折、4d N=1 通量紧化
      gaps: ["4d N=1 那一支是否定式经验证据：原文逐字 'we regard this difficulty as in support of'（E20）",
             "K3 陪集的紧子群写法疑为排印错误（E18 备注，U3）"]

swampland.ov-conjecture-2-tower-of-light-states     status: conjecture
  --via-string-examples            kind: conjecture-support   status: conjecture
  --via-one-loop-metric-argument   kind: physical-argument    status: physical-argument
      sources: ooguri-vafa-2006, loc "§4.1, p.13（v1，无公式号）"
      summary: 有限多轻粒子在 d > 2 时不产生距离发散；无穷塔的一圈和可以
      gaps: ["只说明'无穷塔可以产生'，未证明'必须有无穷塔'",
             "varphi/phi 记号在纯文本转录中丢失（U6）"]

  ⚠ 绝对不要加边 conjecture-1 → conjecture-2 或反向：
     E27 逐字「it is possible to show that these are independent conjectures
     and one conjecture does not follow from the other」。

〈反例方向：独立 statement，不是 Conjecture 的 refutation〉
swampland.ov-conjectures-fail-without-dynamical-gravity    status: physical-argument
  --via-gauge-theory-examples      kind: refutation           status: physical-argument
      sources: ooguri-vafa-2006, loc "§3.2, Examples a–d, p.11–12（v1）"
      summary: (a) 平 Dp 膜：Conj 1 成立而 Conj 2 失效；
               (b) 全局 N=2 rigid limit：Ricci 正定 ⇒ Conj 3 失效（有显式计算）；
               (c) 非紧 CY 上的 P² 缠绕膜：紧且正曲率 ⇒ Conj 1 与 3 失效；
               (d) T² 上的 D5：模空间 R⁴×T² ⇒ Conj 4 失效；
               另 §3.2 开头的 G/H（紧全局对称群破缺）⇒ Conj 1 与 4 失效
      notes: 原文摘要对这一方向用的是 "it is shown"（比正面方向的 "conjecture" 强）
```

**★ 记账红线（本批三篇共同）**：`§3.2` 的四个例子**不得**作为 `Conjecture 1–4` 本身的 `kind: refutation` 推导挂上去。理由：Conjecture 的适用域（E5）**明确要求有限 Planck 质量**，反例全部在引力解耦极限，前提不满足。**挂错会让工具把这五条猜想的 status 全部打成 `refuted`。** 正确做法是建一个独立的「适用域」statement 并把反例挂到它上面。

### 5.3 原文自列的假设与缺口（建议全部进 `gaps`）

1. **适用域限于 ≥ 4 维、有限 Planck 质量**（E5）；3 维「some of our conjectures may be applicable」。
2. **Conjecture 1 要求 `dim M ≠ 0`**（E8、E9、摘要的 "non-zero"）。
3. **`α` 不普适**（E15：9/8 与 3/8；E17：8/7 与 6/7），且本文未讨论是否有下界（Q3）。
4. **Conjecture 3 只是标量曲率，更强的截面曲率版本被原文自己否定**（E11 逐字：string theory 里有正截面曲率的点）。
5. **Conjecture 4 的两条动机强度不同**：不动点论证给单连通，全局荷论证只给 `π₁` 中心平凡（E12）。
6. **Conjecture 1 与 2 相互独立，且「无穷塔但有限距离」在有引力的情形里确实发生**（E27，收缩 `P²`）。
7. **4d `N=1` 那一支只有否定式经验证据**（E20 逐字 "we regard this difficulty as in support of"）。
8. **Conjecture 3 在 4d `N=1` 例子里无法检验**（E20 逐字 "it is difficult to test the conjecture 3"）。
9. **作者自陈「即使证明为真，还需要知道为什么」**（E29）。

### 5.4 **不得**挂到 `ooguri-vafa-2006` 的东西（红线清单）

| 内容 | 为什么不行 | 正确出处 |
|---|---|---|
| 「Swampland Distance Conjecture」这个名字 | **原文没有这个名字**，只叫 `Conjecture 2` | 名字是后来文献的；节点 note 须写「此名非原文措辞」 |
| 「`α` 是 O(1) 普适常数」 | **原文明确否定**（E15） | —— |
| 把 Conjecture 3 写成截面曲率 | **原文明确说是标量曲率，且更强版本不成立**（E11） | —— |
| 把 Conjecture 2 建成 Conjecture 1 的推论（或反向） | **原文明确说二者独立**（E27） | —— |
| 模空间**体积**有限 | 本文讲的是**距离/直径**；本文开篇还说体积判据有「well known counter-examples」（E3） | `vafa-2005` E7 |
| 弱引力猜想 | **本文完全没有** | `arkani-hamed-2006` |
| de Sitter 猜想 / 暗能量约束 | **本文完全没有**（无 "de Sitter"、无 "dark energy"） | 本批三篇都没有 |
| 「无全局对称性」作为独立判据 | 本文只在 E12 与 E21 里**用**它，不论证它 | `arkani-hamed-2006` §2.2 |
| 任何非 (1.1)/(3.1) 的公式号 | **全文只有这两个编号公式** | —— |
| 只写「Example v」的 `loc` | **§3.1 有两个 Example v**（§0.3 第 3 条） | 必须带标题或页码 |
| 参考文献 [4]（Douglas 的 Strings 2005 讲座录音 URL） | 无书面稿，按 `literature/CLAUDE.md` 规则 1 | 只作原文引用内容记录 |

### 5.5 建议同时更新的既有文件

- `literature/sources.bib`：新增 `ooguri-vafa-2006`（`@misc` + eprint；note 写死「loc 依 arXiv **v1**」、「Conjecture 0–4 有编号，公式只有 (1.1)/(3.1)」、「§3.1 有两个 Example v」、「三处 conjecture 2/3 误植」）。**本轮已加。**
- `literature/reading-list.md`：加一行 `extracted`。**本轮已加。**
- **建议新增 reading-list 条目**：**Bagger–Witten, "Matter couplings in `N = 2` supergravity," Nucl. Phys. B 222, 1 (1983)** —— E19 把「超多重态模空间标量曲率必为负」归给它，是 swampland 区最有希望通向 `rigorous` 的物理来源。**本轮已加。**

---
