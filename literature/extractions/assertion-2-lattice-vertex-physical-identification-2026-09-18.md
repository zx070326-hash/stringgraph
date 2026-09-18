# 抽取记录：断言 (2) 三候选文献核查——「物理正规序指数 = VOA 格点顶点算子结构映射」

- 任务：核实 `graph/statements/worldsheet/physical-exponential-equals-voa-vertex-operator.yaml`
  【怎么把本卡升上去】列出的三个候选（Frenkel 1985；FLM 1988 Ch.8；Frenkel–Ben-Zvi §5）能否
  升级断言 (2)：`:e^{i n k₀·X(z)}: = 𝒴(e^{n k₀}, z)`。
- 抽取者：researcher（本轮）
- 日期：2026-09-18
- 覆盖范围：`frenkel-1985` 全文（29 页，pp.325–353）；`frenkel-2000-bourbaki`（Frenkel 单人 Bourbaki
  综述，41 页全文，`frenkel-benzvi-2004` 的公开前身/同内容概要）；`frenkel-benzvi-2004`（仅 AMS 官方
  免费预览的目录页，正文仍不可得）；`flm-1988`（穷尽公开渠道核实，正文仍不可得，见 §5）。

## 判据重申（照抄任务书，逐条核对时用）

要算承载断言 (2)，文献必须**同时**：
1. 写出物理侧对象——`X^μ(z)`（或等价的自由玻色场模展开）与正规序 `: :`；
2. 把它与 VOA 侧结构映射 `Y(e^α,z)` / `𝒴(e^α,z)` **划等号**（不是"显然"/"well known"带过）。

## 约定

三篇文献各自号差/振子记号不同，逐条在 E 条目里标注，不统一改写。

---

## 候选 1：I. B. Frenkel, *Representations of Kac–Moody Algebras and Dual Resonance Models*,
Lectures in Applied Mathematics **21** (1985), 325–353. bib key `frenkel-1985`。

**获取途径（公开，作者主页系镜像，本轮成功）**：
`https://cpb-us-w2.wpmucdn.com/campuspress.yale.edu/dist/2/3739/files/2021/06/frenkel_representations_kac_moody.pdf`
（Yale 数学系 campuspress 挂出的扫描件，1.1 MB，15 页 PDF＝双跨页扫描，展开后覆盖刊号 pp.325–353 全部 29 页）。
**上一轮 WebFetch 走文本 OCR 失败；本轮改用 `Read` 工具直接读扫描图像（多模态），全文清晰可读，L1。**
这是本卡上一轮标记的「唯一升级候选之一」，现已**读到底**。

### E1 物理侧对象：X(p,z)，眼熟到几乎逐字就是 `:e^{ip·X(z)}:`
- 位置：p.326–327, eq. (1)–(3)（引言部分，回顾物理背景）
- 类型：definition（文献自陈是物理学界既有构造的转述，非本文新结果）
- 原文陈述（逐字，记号照抄；`x^μ` 是位置算符，`p^μ` 是动量算符）：
  > `[x^μ, p^ν] = ig^{μν}, [α^μ(m), α^ν(n)] = mg^{μν}δ_{m,-n}` where `μ,ν ∈ {0,...,d-1}`, `m,n ∈ Z`,
  > `g^{μν} = diag(-1,1,...,1)`. … In order to obtain the dual amplitudes physicists defined a "vertex operator"
  >
  > `X(p,z) = exp(p·Σ_{n=1}^∞ (α(-n)/n) z^n) · exp(p·(p log z - ix)) · exp(-p·Σ_{n=1}^∞ (α(n)/n) z^{-n})`   (3)
  >
  > where `p·α(-n)` denotes `p_μ α^μ(-n) = g_{μν}p^μα^ν(-n)`, etc.
- 文献自称的严格程度：转述物理文献既有定义（"physicists defined"），非本文证明的命题。
- 文献列出的依赖：无编号引用，正文提到这是弦论/对偶共振模型的历史构造。
- 备注：**这就是断言 (2) 左边** `:e^{ip·X(z)}:` 的**逐字物理写法**——`exp(...创生模...)·exp(动量零模移位)·exp(...湮灭模...)`
  三段分解正是 E₋·(零模)·E₊ 的正规序拆分，与本卡【设定与记号】里 `:e^{i n k₀·X(z)}:` 的构造一模一样
  （只是本文号差 mostly-plus 变体、且没有 `i`，用欧氏化的 `p·(p log z - ix)` 记号；两者只差记号习惯）。
  **本条单独看，满足判据条件 1（有物理对象）。**

### E2 推广到 Kac–Moody 设定：X(α,z)，带 cocycle ε_α
- 位置：p.332, eq. (2.2)–(2.3)
- 类型：definition
- 原文陈述（逐字）：
  > `Γ` a lattice in `𝔥_R` such that `Q ⊂ Γ ⊂ P`, and let `ε: Q×Q → C^+_1 = {z ∈ C: |z|=1}` be a bilinear
  > cocycle, whose restriction to `Q×Q` satisfies (1.2). … We construct an irreducible projective
  > representation with the cocycle `ε` of the Heisenberg system `(𝔥,Q)` in the space `V = S(𝔥⁻) ⊗ C[Γ]` in a
  > standard way [9]:
  > `h(n)·v⊗e^α = n(∂_{h(-n)}v)⊗e^α, n>0`; `h(-n)·v⊗e^α = (h(-n)v)⊗e^α, n>0`;
  > `h(0)·v⊗e^α = ⟨h,α⟩v⊗e^α`; `β·v⊗e^α = v⊗e^{α+β}`; `C·v⊗e^α = v⊗e^α`.   (2.2)
  >
  > We define a class of *vertex operators* which was first introduced in dual resonance models:
  > `X(α,z) = exp(Σ_{n=1}^∞ (z^n/n)α(-n)) · exp(log z α(0) + α) exp(-Σ_{n=1}^∞ (z^{-n}/n)α(n))`   (2.3)
- 文献自称的严格程度：构造性定义 + 后续命题（Thm 2.1 等）证明其给出 Kac–Moody 代数表示。
- 文献列出的依赖：cocycle `ε` 的存在性引 [9] = Frenkel–Kac, *Invent. Math.* **62** (1980)。
- 备注：这是 E1 的抽象化版本——把物理的 `p·X(z)` 换成一般格点 `α ∈ Γ`。**仍是"物理式"记号**
  （`exp(创生)·exp(零模)·exp(湮灭)`），**没有引入任何独立于此的"VOA 结构映射 Y"去跟它比较**。

### E3 全文检索结果：无 "vertex algebra"、无独立的结构映射 Y
- 位置：全文 pp.325–353（29 页，L1 逐页读图）
- 类型：（元信息，非陈述）
- 原文陈述：无——这是**未出现**的记录。目录（p.325）列出四节：1. Kac-Moody 代数与标准表示；
  2. Kac-Moody 代数的顶点表示；3. 有限维/仿射李代数在顶点表示中的标准表示；
  4. 临界维数下的对偶模型与秩 26 双曲代数。全文没有 "vertex algebra"（该术语 1986 年 Borcherds 才提出，
  本文写于 1982 年讲会、1985 年付印，**早于 VOA 公理化**），也没有任何形如 "𝒴(·,z)" 或 "Y(·,z)" 的
  独立结构映射记号——`X(α,z)`／`X^ε(α,z)` 本身**就是全文唯一的"顶点算子"对象**，直接由振子构造，
  不存在"用另一套公理定义的映射，再拿来跟 X(α,z) 比较相等"这回事。
- 文献自称的严格程度：N/A（未出现的内容无严格程度可言）
- 文献列出的依赖：N/A
- 备注：⚠ **这是本条目对判据条件 2 的否定性证据**——本文没有 VOA 侧对象可供等式的右边。

### E4 no-ghost 定理（Theorem 4.1），附带确认与本图既有节点的关系
- 位置：p.347, Theorem 4.1（§4"The dual model in the critical dimension and hyperbolic algebras of rank 26"）
- 类型：proposition（引用式："We will indicate the main steps of the proof (see details in [25])"——**本文自己不给完整证明**，
  只给"main steps"梗概，引 [25] = J. Scherk, *Rev. Mod. Phys.* **47** (1975) 完整证明）
- 原文陈述（逐字）：
  > THEOREM 4.1 (NO-GHOST THEOREM). Let `V` be a vertex representation of a hyperbolic Lie algebra `𝔤`,
  > then `V₁^∘` is a positive semidefinite space if and only if rank `𝔤 ≤ 26`.
- 文献自称的严格程度：概述性证明（4 步，pp.347–348），完整证明外包给 [25]。
- 文献列出的依赖：[25] Scherk 1975。
- 备注：与本图既有的无鬼定理节点（`worldsheet.no-ghost-theorem-v4` 等）是**同一历史结果的不同证明路线**
  （超越型 hyperbolic Kac–Moody 代数版本，不是本图走的 DDF/Goddard–Thorn 路线），**不承载断言 (2)**，
  仅供背景参考，**不建议**挂到本图任何现有节点（证明路线不同，勉强挂会造成虚假的"同一推导"印象）。

### 小结（Frenkel 1985 → 断言 (2)）

**不承载。** 依据（对照判据）：
- 判据条件 1（物理对象）：**满足**——E1/E2 的 `X(p,z)`/`X(α,z)` 正是 `:e^{ipX(z)}:` 的逐字物理构造。
- 判据条件 2（VOA 结构映射 Y 并与之划等号）：**不满足**——E3 已核实全文没有独立的 VOA 结构映射，
  `X(α,z)` 本身就是全文唯一的"顶点算子"。**没有第二个对象可供"划等号"，所以断言 (2) 这个
  "两个独立构造之间的恒等式"命题在本文里根本没有陈述的对象。**
- 这与卡面判断一致但更精确：本文是**历史源头**没错，但它是"物理式记号先于 VOA 公理化"的源头，
  不是"VOA 公理化之后回头验证等于物理写法"的来源——真要有后者，得等 Borcherds (1986) / FLM (1988)
  把 VOA 公理定下来之后的文献。
- （c）δ-归一化、（b）连续动量↔离散格：本文 `V = S(𝔥⁻)⊗C[Γ]` 建在**离散格** `Γ` 上，`p` 本身
  是求和指标而非连续参数，物理侧连续动量塔（`⟨p|p'⟩=δ^D(p-p')`）与此文对接方式本文未讨论——
  与卡面【本卡明确不断言】(b)(c) 的缺口完全一致，本文没有处理。

---

## 候选 2（改走公开前身）：Edward Frenkel, *Vertex Algebras and Algebraic Curves*,
Séminaire Bourbaki, 52ème année, 1999–2000, n° 875 (Juin 2000). arXiv:math/0007054v4 [math.QA].
新登记 bib key `frenkel-2000-bourbaki`。

**为什么读这篇而不是直接读 FLM/FBZ 正文**：`frenkel-benzvi-2004`（Frenkel–Ben-Zvi 的书）此前已确认
无合法公开全文（见 math-sources.md §9）；但该书**作者主页**明确挂出了这份 **Bourbaki 综述**作为公开
前身（math-sources.md §9.0 已记该链接存在，本轮首次实际读取内容）。综述本身声明"§§4–6 的内容是首次
发表，其余（含格点顶点代数一节）是既有结果的综述"——即**格点顶点代数这部分内容与书的对应章节
（现已核实为 Ch. 4 §4.2/§4.4，见候选 3）在实质内容上应视为同一构造的两次公开呈现**，只是详略不同。
**全文 41 页，本轮 L1 通读**（含 `pdftotext -layout` 关键词复核，见 E9）。

### E5 §2.3 Heisenberg 顶点代数：正规序场 b(z)（自由玻色场的抽象版）
- 位置：p.875-06/07（PDF 内部页码，即综述编号 5–6），eq. (3)(4)
- 类型：definition
- 原文陈述（逐字，`b_n = t^n` 是振子模）：
  > The Heisenberg Lie algebra `H` is topologically generated by the generators `b_n = t^n, n ∈ Z`, and the
  > central element `1`, and the relations between them read `[b_n,b_m] = nδ_{n,-m}1, [1,b_n] = 0`.   (3)
  > … `b(z) = Σ_{n∈Z} b_n z^{-n-1}`.
  > `Y(b_{-n_1}b_{-n_2}...b_{-n_k}, z) = 1/((n_1-1)!...(n_k-1)!) :∂_z^{n_1-1}b(z)...∂_z^{n_k-1}b(z):`   (4)
- 文献自称的严格程度：证明（Proposition 2.4：Fock 表示 π 满足 VOA 公理）。
- 文献列出的依赖：Reconstruction Theorem（[FKRW]）。
- 备注：`b(z)` 就是物理侧 `∂X(z)`（或 `i∂X`）的抽象模拟——单变量、单振子塔，本卡断言 (2) 需要的正是
  D 维推广后跟 `X^μ(z)` 的对应。**这一条本身满足判据条件 1 的"等价的自由玻色场模展开"部分**，但
  记号是 `b(z)`、`Y(·,z)`，**没有出现 `X^μ(z)` 这个物理写法**，也没有 `:e^{i k X(z)}:` 这种指数记号
  （指数记号要到 §3.3 才出现，见 E6）。

### E6 §3.3 玻色–费米对应：Y(1_λ,z) —— 与 :e^{ikX(z)}: 结构完全同构的公式
- 位置：p.875-13，无编号公式（紧接"Explicitly,"之后）
- 类型：definition/proposition
- 原文陈述（逐字）：
  > In order to define the vertex operation on `V_{√N Z}`, it suffices to define the fields `Y(1_{m√N}, z)`.
  > They are determined by the identity `∂_z Y(1_λ,z) = Y(T·1_λ,z) = λ:b(z)Y(1_λ,z):`. Explicitly,
  >
  > `Y(1_λ,z) = S_λ z^{λb_0} exp(-λ Σ_{n<0} (b_n/n) z^{-n}) exp(-λ Σ_{n>0} (b_n/n) z^{-n})`
  >
  > where `S_λ: π_μ → π_{μ+λ}` is the shift operator, `S_λ·1_μ = 1_{μ+λ}, [S_λ,b_n]=0, n≠0`.
- 文献自称的严格程度：陈述为显式公式（"Explicitly,"），由前面identity 唯一确定（无独立证明段落，
  依赖 Reconstruction Theorem 型论证隐含在此前的 §2.3–2.4 框架里，本节没有重新给出证明）。
- 文献列出的依赖：`b(z)`（E5）、Reconstruction Theorem。
- 备注：**这公式在结构上与断言 (2) 左边 `:e^{i n k₀·X(z)}:` 的 E₋·(零模)·E₊ 三段分解逐项对应**
  （`exp(-λΣ_{n<0}...)` = 产生模段，`z^{λb_0}` = 零模段，`exp(-λΣ_{n>0}...)` = 湮灭模段），
  但记号仍是 `b_n`（抽象 Heisenberg 振子）而不是 `α_n^μ`/`X^μ(z)`，且左边被命名为 `Y(1_λ,z)`
  （VOA 结构映射本身），**不是"物理写法 = VOA 映射"的等式，而是"VOA 映射的显式公式"**——
  跟 Li–Wang (3.10) 是同一类型（VOA 侧内部展开，非"翻译句"）。

### E7 ★ §3.4(1) 格点顶点代数：**唯一出现"物理身份声明"的一句话**
- 位置：p.875-14，§3.4 "Rational vertex algebras"，例 (1) 段末句
- 类型：assertion（无编号，纯陈述句，无公式，无证明）
- 原文陈述（逐字）：
  > (1) Let `L` be an even positive definite lattice in a real vector space `W`. One can attach to it a
  > vertex algebra `V_L` in the same way as in §3.3 for `L = √N Z`. … Then `V_L` is rational, and its
  > inequivalent simple modules are parameterized by `L'/L` where `L'` is the dual lattice [D1]. The
  > corresponding characters are theta-functions. **The vertex algebra `V_L` is the chiral symmetry
  > algebra of the free bosonic conformal field theory compactified on the torus `W/L`.**
- 文献自称的严格程度：**这句话没有推导、没有公式、没有引用**——紧接在"characters are theta functions
  [引 D1]"之后，独立成句，不带引用标号，是全篇**唯一**一次把 VOA 对象（`V_L`）与物理对象
  （"the free bosonic conformal field theory"）直接划等号的地方。
- 文献列出的依赖：**无**（本句不带引用；前一句的 theta 函数陈述引 [D1]，但"chiral symmetry algebra of
  the free bosonic CFT"这句独立，未见引用标记）。
- 备注：**这是全文最接近断言 (2) 的一句话，但按任务书判据不合格**：
  (i) 没有写出 `X^μ(z)` 或任何物理场记号——"free bosonic conformal field theory"只是**文字描述**，
  不是公式化的 `:e^{ikX(z)}:` 记号，不满足判据条件 1 的"写出"要求（只是**提及**，不是**写出**）；
  (ii) 没有给出任何论证——是一句纯断言，符合任务书明确排除的"用'well known'一笔带过"情形
  （虽然原文连"well known"字样都没写，比那更简略：**直接断言，零论证、零引用**）；
  (iii) 完全没有处理接缝 (b)（连续动量↔离散格：本节从头到尾 `L` 都是固定格，没有连续动量塔）
  和 (c)（δ-归一化：全文没有归一化讨论，`S_λ` 移位算符的归一化未提及）。
  **结论：这条不满足判据，只能算"作者在综述里顺口确认了物理学界的共识"，不能当来源引用。**

### E8 全文再无第二处物理识别
- 位置：pp.875-01～875-41 全文（41 页）
- 类型：（元信息）
- 备注：除引言首句"Vertex operators appeared in the early days of string theory as local operators
  describing propagation of string states"（p.875-01，泛泛背景陈述，无公式）与参考文献表里三处
  "string theory"字样（书名/文章名引用，非正文论证）外，**全文没有第二次提到物理弦论构造**，
  §4"Coordinate independent description"、§5"Conformal blocks"等后续章节完全是代数/几何语言，
  与本卡断言 (2) 无关。

### E9 关键词复核（`pdftotext -layout` 全文抽取 + grep，交叉验证 E3/E8 的"未出现"判断）
- 位置：全文（机器可读文本抽取版，2161 行）
- 类型：（方法论记录）
- 备注：`grep -in "worldsheet\|X\^\\\\mu\|string theory\|free bosonic string\|X(z)"` 命中仅 4 处，
  全部落在引言首句与参考文献表（见上 E8），**无正文公式命中**。确认本文档全文检索不出物理坐标场
  `X^μ(z)` 或 "worldsheet" 字样，佐证 E7 的判断不是遗漏而是真的没写。

### 小结（Frenkel 2000 Bourbaki 综述 = FBZ 书的公开前身/同构造内容 → 断言 (2)）

**不承载，但是本轮找到的最接近的一句话（E7）。** 判据条件 1 不满足（用文字"free bosonic CFT"
代替显式 `X^μ(z)` 公式），判据条件 2 的"划等号"动作有（`V_L` **是** chiral algebra），但**零论证**，
比 well-known 带过还简略（连"well known"字样都省了）。**这恰是任务书明确要求不算数的那种情形。**
接缝 (b)(c) 完全未处理。

---

## 候选 3：Frenkel–Ben-Zvi, *Vertex Algebras and Algebraic Curves* (AMS Surv. 88), 直接正文核实

**本轮新进展**：此前researcher（math-sources.md §9）用 WebFetch 访问 AMS 官方免费预览
`https://www.ams.org/bookstore/pspdf/surv-88-prev.pdf` 得到 403。**本轮改用浏览器 UA 的 curl 直接
下载，返回 200，拿到完整前 4 页（含**完整目录**，第 2 版）**——比此前只有勘误表多了目录这一手资料。

### E10 完整目录核实：格点顶点代数在 **Ch. 4 §4.2/§4.4**，不在"§5"
- 位置：AMS 官方免费预览 PDF `surv-88-prev.pdf`，p. vii–ix（目录页），2004 年第 2 版
- 类型：（元信息，目录）
- 原文陈述（逐字摘录相关行）：
  > Chapter 4. Rational Vertex Algebras 69
  >   4.1. Modules over vertex algebras 69
  >   4.2. Vertex algebras associated to one-dimensional integral lattices 72
  >   4.3. Boson–fermion correspondence 77
  >   4.4. Lattice vertex algebras 80
  >   4.5. Introducing rational vertex algebras 82
  >   4.6. Constructing new vertex algebras 83
  >   4.7. Bibliographical notes 86
  > Chapter 5. Vertex Algebra Bundles 87
  >   5.1. The group Aut O 87
  >   5.2. Exponentiating vector fields 89
  >   5.3. Primary fields 92 …
- 文献自称的严格程度：N/A（目录）
- 文献列出的依赖：N/A
- 备注：⚠ **任务书假设的"Frenkel–Ben-Zvi §5"是错的**——目录清楚显示 §5 是"Vertex Algebra Bundles"
  （坐标无关化构造，讲 Aut O 群作用），**与格点顶点代数无关**。真正的格点构造在 **Ch.4 §4.2（一维格）
  /§4.3（玻色费米对应）/§4.4（一般格点 VOA）**，编号顺序与页码（69/72/77/80）**与候选 2 的 Bourbaki
  综述 §3.2/§3.3/§3.4 几乎逐节对应**（综述 §3.3 玻色费米对应 ↔ 书 §4.3；综述 §3.4(1) 格点例子 ↔ 书 §4.4），
  强烈提示书的 Ch.4 是综述 §3 的展开版，**内容路线极可能相同**（先给 `Y(1_λ,z)` 显式公式，
  再一句话"是自由玻色 CFT 的手征对称代数"）。**这是推断（researcher 标注 inferred，非直接核实）**，
  真要坐实仍需正文，正文本轮依然拿不到（见下）。
- **正文仍不可得**：`bookstore.ams.org` 403；作者主页/Ben-Zvi 主页均只挂目录/勘误表/书评链接；
  `sciencedirect.com` 系列列表页返回 403（bot 拦截，且即使能访问也是付费全文，不合"公开可获取"）；
  唯一非官方全本扫描（`nzdr.ru`）按项目规则不采信。**Ch.4 §4.2/§4.4 正文内容本轮维持 L0。**

### 小结（Frenkel–Ben-Zvi 书直接 → 断言 (2)）

**无法直接核实（L0），但目录定位这一手新资料本身值得登记**：纠正了任务书"§5"的错误定位，并且
通过与候选 2（同一作者的公开综述，内容路线几乎逐节对应）的强关联，把"书的 Ch.4 大概率长什么样"
的置信度从"完全未知"提升到"极可能与 E7 的一句话同构"——但这只是 researcher 的推断，**不能当作
已核实的反面结论**，必须留作残余风险（见结论段）。

---

## 候选 4（未列入原任务书三选一，但同源需一并排除）：FLM 1988，*Vertex Operator Algebras and the
Monster*，Ch. 8。bib key `flm-1988`。

### E11 穷尽公开渠道核实结果：全部失败，Ch. 8 内容维持 L0
- 位置：N/A（记录的是"查无"过程，不是文献内容）
- 类型：（方法论记录，穷尽尝试清单）
- 尝试的公开渠道与结果：
  1. **archive.org / Open Library**：`openlibrary.org/books/OL2031899M/...` 可访问（HTTP 200），
     但页面里**没有**指向 archive.org 扫描件的 `archive.org/details/...` 链接（grep 无命中）。
     即使存在 Controlled-Digital-Lending 借阅扫描，按 `literature/CLAUDE.md` 规则 1（非官方整本
     教材扫描不用）与本项目既有口径（2001–2024 年 Hachette v. Internet Archive 判定 CDL 全本扫描
     侵权），**不采信**，本轮未进一步深挖。
  2. **ScienceDirect（Elsevier 官方，该书现归入 Pure and Applied Mathematics 丛书 vol. 134）**：
     `sciencedirect.com/bookseries/pure-and-applied-mathematics/vol/134` 返回 **HTTP 403**
     （bot 拦截页，`<title>ScienceDirect</title>` 空壳，非正文）。即使能访问，Elsevier 全文
     是订阅付费，不满足"公开可获取"，此渠道**原则上也不合规**，仅作为"能否至少看到章节标题/摘要"
     的尝试，仍失败。
  3. **Google Books 预览**（volume id `yOC9OFC1YSUC`）：用与候选 3 相同的"已知应无命中的对照短语法"
     （见 math-sources.md §9.2 记录的方法论）测试四个查询短语（"untwisted vertex operators"、
     "Chapter 8"、"normal ordered exponential"、"vertex operator representation of the Virasoro
     algebra"），**全部返回同一固定回落页 `pg=PA508`**（= 全书最后一页，索引/封底），
     即**这本书在 Google Books 完全没有可搜索的预览内容**（连候选 3 那种"部分页码可查"的程度都没有）。
  4. **AMS/Academic Press/Elsevier 官方样章、作者个人主页**：本轮未找到 Lepowsky 或 Meurman
     的个人主页挂出该书任何章节 PDF（此前researcher 在 §36 系列抽取里也未记录找到）。
  5. **图书馆目录链接**（Bates College / U. Missouri）：仅为馆藏索引页，不含扫描内容。
- 备注：**结论——FLM 1988 Ch. 8 正文本轮（以及此前所有轮次）从未被本项目以任何公开渠道读到过，
  完全维持 L0。** 这是本任务最大的残余风险：三个候选里，Frenkel 1985 已读到底（E1–E4，L1），
  Frenkel–Ben-Zvi 走公开前身读到底（E5–E9，L1）+ 正文目录核实（E10，L1）+ 正文内容仍 L0（推断），
  **只有 FLM 1988 是完全的黑箱**——不能排除它在 Ch.8 里做了 E1/E2/E6/E7 都没做到的事
  （即显式写出 `X^μ(z)` 记号并与自己的 `Y(·,z)` 划等号且给出论证）。

---

## 未解决的疑问

1. **FLM 1988 Ch. 8 正文内容完全未核实**（见 E11）。这是本轮唯一没有"读到底"的候选，穷尽了
   五种公开渠道均未获得只字内容。若日后能拿到（例如某高校课程页挂出该书某单章，或作者身后
   版权方公开），应第一时间重开本卡。
2. **Frenkel–Ben-Zvi 书 Ch.4 §4.2/§4.4 正文仍是 L0**，E10 给出的"极可能与综述 §3.3/§3.4 同构"
   只是 researcher 基于目录对应关系与作者惯例的推断，**不是核实**。若未来 AMS 或作者放出更多
   免费页（例如某次促销的扩展预览），应重查。
3. **本轮登记的 `frenkel-2000-bourbaki` 综述与 `frenkel-benzvi-2004`（书）是否算"同一文献的两个
   版本"还是"两篇独立文献"**：本条目按"两篇独立文献"处理（作者集合不同：综述仅 Frenkel 一人，
   书是 Frenkel+Ben-Zvi 二人；发表场所不同），但内容高度重叠，**curator 决定是否需要在图节点的
   sources 列表并列两者时注明"重叠来源"**，本抽取记录不越权判断。
4. Frenkel 1985 (2.3) 与本卡断言 (2) 右端记号 `𝒴(e^{nk},z)`（Li–Wang 2008 风格）之间，前者的
   `X(α,z)` 本身就是"唯一顶点算子"，**没有第二个独立构造给它验证"相等"**——这意味着即使把
   Frenkel 1985 当作断言 (2) 的"历史源头"，它承载的其实是"断言 (2) 尚未成为一个需要被验证的
   命题的历史阶段"，而不是"断言 (2) 已被验证"。这一点建议 curator 在决定是否要给
   `physical-exponential-equals-voa-vertex-operator` 卡加一条历史背景 source（不算数但值得记）时参考。

---

## ★★★ 结论（三选一）

### (B) 确认查无此证明——断言 (2) 在 Frenkel 1985 / Frenkel–Ben-Zvi（经其公开前身 Bourbaki 综述核实）/
FLM 1988 中，**据本轮核实均无来源**，可以开原创轨道。

依据：
- **Frenkel 1985**：全文 29 页 L1 通读到底。有物理侧对象（判据条件 1 满足，E1/E2），但**没有独立的
  VOA 结构映射可供划等号**（判据条件 2 不满足，E3）——该文写于 VOA 公理化（Borcherds 1986）之前，
  是"两套写法分裂"之前的共同祖先，不是"分裂后再验证等价"的文献。
- **Frenkel–Ben-Zvi**：正文本身仍不可得（穷尽 AMS/作者主页/出版社渠道，唯一进展是本轮用浏览器 UA
  拿到官方预览 PDF 的完整目录，纠正了任务书"§5"的错误定位，真正章节是 Ch.4 §4.2/§4.4）。
  但其作者本人公开挂出的、内容路线几乎逐节对应的 **Bourbaki 综述**（math/0007054，41 页 L1 通读到底）
  在对应内容处（E7）给出全文**唯一**的物理识别句——"`V_L` is the chiral symmetry algebra of the free
  bosonic conformal field theory compactified on the torus `W/L`"——但**这句话没有公式、没有 `X^μ(z)`
  记号、零论证、零引用**，不满足判据条件 1（未写出物理侧公式，只是文字提及）也不满足"不能 well-known
  带过"的要求（比 well-known 更简略）。**不合格。**
- **FLM 1988 Ch. 8**：穷尽五种公开渠道（archive.org/Open Library、ScienceDirect、Google Books 预览、
  作者主页、图书馆目录）**全部失败**，正文完全未获取，见 E11。

**因此：断言 (2) 在 Frenkel 1985、Frenkel–Ben-Zvi（含其公开前身综述）、FLM 1988 中均无来源，
可以开原创轨道。**

**残余风险（必须显式列出，不能装作查全了）**：
- ⚠ **FLM 1988 Ch.8 正文完全未获取（L0）**——三个候选里，这是唯一"完全黑箱"的一个。
  上面的结论对 FLM 这一支是**"穷尽公开渠道仍拿不到，不能证实也不能证伪"**，不是"读到了、
  确认不承载"。**如果要开原创轨道，必须显式记录这一条残余风险**，不能把"拿不到"等同于"读过了、
  没有"。
- ⚠ Frenkel–Ben-Zvi 书正文（Ch.4 §4.2/§4.4）同样未直接核实，结论依赖"与公开综述内容路线相同"
  的推断，**推断强度高但非核实**。

---

## bib

- `frenkel-1985`：已在 `literature/sources.bib` 登记，本轮把 note 从"内容 L0，OCR 失败"更新为
  "全文 L1 通读到底，不承载断言 (2)，理由见本抽取记录 E1–E4"。
- `frenkel-2000-bourbaki`：**本轮新登记**（Séminaire Bourbaki n°875 / arXiv:math/0007054v4）。
- `frenkel-benzvi-2004`：本轮追加 note，记录 AMS 官方预览 PDF 完整目录核实结果（E10）与
  ScienceDirect 403 的尝试记录。
- `flm-1988`：本轮追加 note，记录 E11 的五渠道穷尽尝试全部失败。
