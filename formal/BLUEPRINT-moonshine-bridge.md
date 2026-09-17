# 从本项目的无鬼定理形式化到 Borcherds 1992 怪兽月光证明所用无鬼定理的差距分析

> **本文件性质**：纯 scoping / 差距核实文档，**不是证明、不是施工蓝图**。目标是回答一个具体问题：
> 本仓库 `StringFormal.NoGhost` 里已经证到的东西，离 Borcherds 在 *Monstrous moonshine and
> monstrous Lie superalgebras*（Invent. Math. 109, 1992, 405–444）证明怪兽月光猜想时**实际用到**的
> 无鬼定理有多远。
>
> **纪律**：本文件只写 markdown，不碰 `StringFormal/` 下任何 `.lean` 文件，不碰 `graph/` 下任何
> YAML，不给任何图节点改 `status`。文中出现的 Lean 签名一律标注「草图，未编译」。
>
> **取证等级约定**（照抄 `BLUEPRINT-noghost-N6.md` 的体例）：
> - `[Lean]`：本仓库已编译声明，文件名给在旁边；
> - 引用图卡既有的、经 L1（作者一手核实）抽取的文献陈述，直接给「文献 + 章节/定理号」，
>   不再降级标注（因为 `literature/extractions/borcherds-1992.md` 与
>   `graph/derivations/worldsheet/ddf-spanning-hypothesis--via-borcherds-1992.yaml` 已把这部分做到
>   L1，本文件是在其上做二次比对，不是重新核实一手文献）；
> - 本轮新查、**只经 WebSearch 摘要、未逐页读图**的文献结论标 `⟨lit, 待核, WebSearch 2026-09-18⟩`；
> - 我自己的推理、判断、风险评估标 `⟨analysis 2026-09-18⟩`。
>
> 作者：formalizer（lean-formalizer），2026-09-18。

---

## 0. 一句话结论（详细论证见下文）

**图的策展工作已经把大半个比对做完了**——`graph/derivations/worldsheet/ddf-spanning-hypothesis--via-borcherds-1992.yaml`
（2026-09-15 起，curator）已经给出了本项目对象与 Borcherds 1992 §5 三个空间（P¹、T¹、N¹）的字典，
并诚实登记了缺口。本文件的增量贡献是：(a) 把这份字典与本仓库**当前 Lean 代码的实际进度**
（N ≤ 5 已闭、N ≥ 6 open）对齐，给出一张更细的 delta 表；(b) 独立核实"string-cft-is-a-vertex-algebra
是否在关键路径上"这一问，结论是**不在**；(c) 核实 fake monster / 整数形式无鬼定理这两个此前图里
**零覆盖**的问题；(d) 给出诚实的工期/风险判断和推荐的第一步。

**底线**：现阶段**不值得**把"形式化 Borcherds 1992 的怪兽李代数构造"立项——最大的瓶颈
（DDF 张成在 `N ≥ 6` 未闭）与是否走 moonshine 无关，是本项目自己的无鬼定理形式化本身尚未完成的部分；
在此之前做任何"桥接到 Borcherds 记号"的工作都是在未完工的地基上盖第二层。值得做的是两件**低风险、
与 `N ≥ 6` 解耦**的准备工作，见 §5。

---

## 1. Borcherds 1992 §5 实际用到什么（复述图卡字典，不重新核实一手文献）

来源：`literature/extractions/borcherds-1992.md`（L1，作者主页重排本逐页读图）+
`graph/derivations/worldsheet/ddf-spanning-hypothesis--via-borcherds-1992.yaml`。

### 1.1 Theorem 5.1 的陈述形状

设 `V` 是**任意**满足以下条件的向量空间：非退化双线性型、Virasoro 作用（`L_i` 的伴随是 `L_{-i}`）、
中心元作用为标量 `24`、`L_0` 本征值非负整数且**每个 `L_0` 本征空间有限维**。令
`V_{II_{1,1}}` 为二维偶自对偶洛伦兹格 `II_{1,1}` 的格顶点代数（Gram `((0,-1),(-1,0))`）。
`H := V ⊗ V_{II_{1,1}}`，`P¹ := {v ∈ H : L_0 v = v, L_i v = 0 (i>0)}`，`P¹_r` 是 `P¹` 中
`II_{1,1}`-degree 为 `r` 的部分。**结论**：`P¹_r` 模去其双线性型的根 `N_r`，**自然同构**于
`V^{1-(r,r)/2}`（`r=0` 时是 `V¹ ⊕ R²`）。

证明链（Lemmas 5.1–5.5）定义了三个中间对象：
`S`（伪态，`H` 中与 `P` 正交者）、`N = S ∩ P`（`P` 上双线性型的根）、
`T`（横向空间，`P` 中被纵向算子 `K_i`，`i>0` 湮灭者；`K_i = v_{i-1}`，`v = e^{-w}_{-2}e^w`，
`w` 是 `II_{1,1}` 里的类光向量）。**关键：`T` 不是凭空取的补空间，Lemma 5.1/5.2 证明 `T` 由
`K_i` 型算子在真空上的单项式张成、双线性型在 `T` 上非退化**——这正是「DDF 单项式张成横向空间」
这句话在 Borcherds 记号下的**证明**，而不是定义。Lemma 5.5：`P¹ = T¹ ⊕ N¹`（直和分解 = 张成命题）。

### 1.2 D=26 的入口

原文逐字：「The 26 comes from the 24 in theorem 5.1 plus the dimension of `II_{1,1}`」——`24`
是 `V` 的中心荷假设，`+2` 是 `II_{1,1}` 的秩。`D=26` 只在 Lemma 5.4（证明 `L_{i<0}` 生成的结合代数
把 `S¹` 映入 `S`，用到「Virasoro 中心在 `V` 上是 24、故在 `H` 上是 26」）这一步进入，其余步骤
（`Ve^r ≅ T`、`T` 上非退化、`K` 代数关系）对任意满足假设的 `V` 成立。

### 1.3 Fake monster 与（真）Monster 的应用方式（本轮新核实，见 §3）

`V = V^♮`（Moonshine module，FLM 构造）给出（真）Monster 李代数；`V = V(Λ)`（Leech 格顶点代数，
Li–Wang 型直接构造，**不需要 FLM 的轨形/扭模构造**）给出 fake monster 李代数。**两者用的是
同一条 Theorem 5.1**，只是 `V` 不同——这一点对 §4 判断 3（是否有更便宜的中间目标）是决定性的。

---

## 2. 本仓库当前 Lean 进度实际证了什么

来源：`formal/CLAUDE.md` 模块清单 + `formal/BLUEPRINT-noghost.md` / `-N6.md`。

### 2.1 核心声明 `no_ghost_of_spans`（`NoGhost/Assembly.lean`）[Lean]

```
-- 草图，未编译（签名转录自 Assembly.lean，见 formal/CLAUDE.md 摘要）
theorem no_ghost_of_spans [Field K] [LinearOrder K] [IsStrictOrderedRing K] [Algebra ℚ K]
    (h : DDFSpans η a b a₀) :
    -- TowerPhysQuot 上诱导的形式半正定
    ∀ x, 0 ≤ towerQuotientPairing ... x x
```

`DDFSpans η a b a₀ := H_phys ≤ ddfSpan ⊔ H_null`（在整个动量塔 `T(p;k_0) = ⊕_j F(p+jk_0)` 上，
截距 `a₀ = α'k²` 由质壳条件钉死）是一条**假设**，不是定理。`no_ghost_of_spans` 的结论是
**半正定性**（无鬼），不是同构。

### 2.2 `DDFSpans` 本身在哪些片上已经是定理

`worldsheet.ddf-spanning-rank-inequality`（Lean `B26`，`NoGhost/SliceRank.lean`）把 `DDFSpans`
等价改写成逐 `N` 的秩不等式 `dim(H_phys ⊓ V_N) ≤ dim(ddfSpan ⊓ V_N) + dim(H_null ⊓ V_N)`
（`V_N` = 反对角双分次片）。**已 formalized、无 `D` 假设**的部分：`N ≤ 1`
（`NoGhost/LightCone.lean` + `Glue.lean`，`D` 完全不出现）；**已 formalized、用到 `D=26`
（经 `NullSeedsTwo.lean` 的 level-2 二次零态族 `𝒟₂ = 2L_{-2}+3L_{-1}²`）**的部分：
`N = 2,3,4,5`（分别在 `LevelTwoCount.lean`／`LevelThreeCount.lean`／`LevelFourCount.lean`／
`LevelFiveCount.lean`）。**`N ≥ 6` open**——`formal/BLUEPRINT-noghost-N6.md` 把开放内容精确压成
一条核的上界 `τ_N ≤ τ_N^目标`（Euler 五边形数展开），并自评「需要 BGG/Feigin–Fuks 级别的理解，
是一个独立的大项目」（`no-ghost-theorem-v4--via-goddard-thorn.yaml` 追记，2026-09-16 一轮手算，
未经复核）。

### 2.3 关键结构差异：本项目是**秩 1**、Borcherds 是**秩 2**

这是本文件本轮比对中**最重要的新发现**，此前的图卡字典（`ddf-spanning-hypothesis--via-borcherds-1992.yaml`）
虽然登记了"`L_0` 本征空间有限维"假设不满足这个 gap，但没有把它归因到根本结构差异——现在可以说清楚：

- **Borcherds**：`H = V ⊗ V_{II_{1,1}}`，`V` 是一个**独立的、中心荷恰好 24 的 VOA**（与
  `II_{1,1}` 完全解耦），`P¹_r` 按**秩 2**格 `II_{1,1}` 的度数 `r` 分级。`V` 自己的每个
  `L_0`-本征空间有限维，这是 Theorem 5.1 的**前提**，与 `II_{1,1}` 方向的分级无关——两个方向
  的有限性是**独立**给出的（`V` 因为假设，`V_{II_{1,1}}` 因为格顶点代数本身在每个 `(m,n)`
  度数分量有限维）。
- **本项目**：动量塔 `T(p;k_0) = ⊕_{j∈ℤ} F(p+jk_0)` 只挑了**一个类光方向** `k_0`，动量 `p`
  连续取值，只有 `j` 离散——这对应 Borcherds 图景里 `II_{1,1}` 的**一个 null 方向**，不是整个
  秩 2 格。塔的"层"（`F` 的振子 level）与"rung"（`j`）两重分级合起来给出
  `towerBigrade(rung,level)`（有限维，`Module.Finite`，`NoGhost/LightCone.lean`）——但这是
  **两个都在同一个 D 维横向+纵向振子空间里**的分级，不是"一个独立 c=24 因子 × 一个秩 2 格因子"
  这种**张量积结构**。

`⟨analysis 2026-09-18⟩` 换句话说：本项目现在证的东西，其"陈述形状"更接近 Goddard–Thorn 1972
原始物理论证（D 维时空里挑一个光锥方向），而不是 Borcherds 1992 §5 的 VOA 化重述（`V` 与
`II_{1,1}` 因子解耦、`r` 取遍整个秩 2 格）。要把本项目的结果字面地喂给 Borcherds 的定理陈述，
需要先把 `T(p;k_0)` 重新组织成 `V ⊗ V_{II_{1,1}}` 的形状——这**不是**已有的
`free-boson-vertex-algebra-with-lightlike-momentum-tower`（秩 1、单个 `k_0`）能直接提供的，
需要真正构造秩 2 格 `II_{1,1}` 的顶点代数并把它与一个**独立**的 c=24 因子张量。这是一项新的、
迄今为止本仓库和图里都没有开始的基础设施（`math.lattice-vertex-algebra` 卡本身也**没有**
被 Lean 形式化，只是一张图卡引用 Li–Wang 2008 存在性定理，见 §4 判断 2）。

---

## 3. 本轮新核实的两个此前零覆盖问题

### 3.1 Fake monster 李代数构造 `⟨lit, 待核, WebSearch 2026-09-18⟩`

`literature/` 与 `graph/` 此前对"fake monster"/"Leech lattice VOA"零命中（已用
`grep -ri "fake monster\|monster lie algebra\|leech lattice"` 核实）。WebSearch 摘要
（未逐页读图，来源含 Carnahan 综述与 Scheithauer 的相关论文）给出的构造：

- `Λ` = Leech 格（24 维偶幺模正定），`II_{1,1}`，`II_{25,1} = Λ ⊕ II_{1,1}`。
- 无鬼定理应用：令 `K` 为 `P¹(V(Λ)⊗V(II_{1,1}))` 上双线性型的核，**`(P¹(V(Λ)⊗V(II_{1,1})))_{(m,n)}/K
  ≅ V(Λ)_{1+mn}`**——与 §1.1 的 Theorem 5.1 是**同一条定理**，`V := V(Λ)`。
- `fake monster := M_Λ = P¹(V(II_{25,1}))/K'`（用 `V(II_{25,1}) ≅ V(Λ)⊗V(II_{1,1})` 的同构，
  两种描述等价）。
- 意义：这是历史上**第一个**广义 Kac–Moody 代数的显式例子，比（真）Monster 李代数**更早**
  （Monster 李代数的分母公式恰是被 fake monster 的分母公式**启发**而构造的）。

`⟨analysis 2026-09-18⟩` **对本项目的意义**：fake monster 用的无鬼定理强度、格结构（`II_{1,1}`
的秩 2 分级）与（真）Monster **完全一样**——`V` 从 `V^♮` 换成 `V(Λ)` 不改变 §2.3 指出的
"秩 1 塔 vs 秩 2 格张量积"结构差距，也不改变"张成需要对所有 `N`（所有 `r`）成立"这一根本要求。
**fake monster 省下的唯一成本是 `V` 侧的构造难度**：`V(Λ)` 是标准格顶点代数（`math.lattice-vertex-algebra`
一条存在性定理就够），而 `V^♮` 需要 FLM 的 `ℤ/2` 轨形/扭模构造——一项独立的、大得多的 VOA
理论工程（扭模、轨形顶点代数公理，本项目和 Mathlib 都完全没有）。**结论：fake monster 是真实
可行的、成本远低于真 Monster 的中间目标，但它不能绕开本项目目前最大的瓶颈（`N ≥ 6` 未闭 +
秩 1→秩 2 的结构翻译），因为无鬼定理本身要求的强度是一样的。**

### 3.2 整数形式无鬼定理 / arXiv 2111.09404 `⟨lit, 待核, WebSearch 2026-09-18⟩`

- **原始来源不是 2111.09404**，是 **Borcherds 1999「The fake monster formal group」**
  （Trans. AMS，Theorem 6.5）——首次证明无鬼定理的**整数**形式（对 Niemeier 格顶点代数），
  用于验证 Monster 李代数的一个未证技术假设，完成模 `p`（奇素数）模月光猜想的证明。
- **Carnahan–Urano, "Monstrous Moonshine for Integral Group Rings"**（arXiv 2111.09404，
  IMRN 2024）把 Borcherds 1999 Theorem 6.5 **精细化**（Theorem 3.6），结合 Monster 李代数
  整数形式上的 Laplacian 分析，把月光猜想的亏格零命题归约到"quasi-replicable"函数的亏格零
  问题，并对 Monster 里 4A 类生成的循环子群证出结论。
- Borcherds 1999 原定理**只对 Niemeier 格顶点代数**（`V` 取 24 维偶幺模正定格）陈述，
  结论是"若 `β` 是 `n` 倍本原向量，则相关对象的行列式整除 `n` 的某个幂"——比复数域上的
  Theorem 5.1 弱得多、条件也窄得多。

`⟨analysis 2026-09-18⟩` **对本项目的意义**：整数形式无鬼定理是在（复数域上的）Theorem 5.1
之上**再加一层**，服务于模 `p` 模月光这类更精细的结果，**不是**"怪兽李代数构造 + 根重数
= `j` 函数系数"这条主线所必需的——那条主线只需要 §1.1 的复数/实数域 Theorem 5.1。本项目
`WitnessInt.lean` 给出的是**四条几何假设**（`hη/hbb/hba/hεb`）在 `ℤ` 上可满足，这与"DDF/VOA
构造本身、商配对本身在 `ℤ` 上良定义且幺模"是**两件不同的事**——`WitnessInt.lean` 不能被
简单扩展成 Borcherds 1999 意义下的整数无鬼定理。**结论：整数形式无鬼定理超出了"基本月光桥"
所需范围，应明确排除在任何近中期计划之外。**

---

## 4. Delta 表（核心交付物）

| 维度 | Borcherds 1992 §5 用到的 | 本项目 `no_ghost_of_spans` 现状 | 分类 |
|---|---|---|---|
| **系数环** | 实数域（VOA 定义在 `ℝ` 上，双线性型非退化） | `[Field K][LinearOrder K][IsStrictOrderedRing K][Algebra ℚ K]`（有序域，比 `ℝ` 更一般） | **记号性**——本项目条件严格覆盖 Borcherds 的设定，无需新工作 |
| **动量/格空间结构** | `H = V ⊗ V_{II_{1,1}}`：`V` 是**独立**的 c=24 VOA，`II_{1,1}` 是**秩 2**洛伦兹偶幺模格，`r` 取遍整个格 | `T(p;k_0) = ⊕_j F(p+jk_0)`：**秩 1**（单个类光方向 `k_0`），`p` 连续，塔只有一重离散指标 `j` | **真实数学缺口**——需要新建秩 2 格顶点代数 `V_{II_{1,1}}` 并与独立 c=24 因子张量，见 §2.3。`math.lattice-vertex-algebra` 本身未形式化 |
| **物理态定义** | `P¹_r = {v : L_0 v=v, L_{i>0}v=0}`（度数 `r` 分量，`L_0` 本征值锁定为 1，质壳条件由 `V` 的分级吸收） | `H_phys = towerL0Submodule ⊓ towerPositiveModeSubmodule`，截距 `a₀ = α'k²`（质壳条件由动量 `p` 吸收） | **记号性**——两者是同一约束的两种参数化，翻译无障碍 |
| **张成假设** | **定理**（Lemma 5.5，`P¹ = T¹ ⊕ N¹`，直和分解，证明详尽） | **假设**（`DDFSpans`），仅对 `N ≤ 5`（任意 `D`）证出为定理；`N ≥ 6` open，自评需要 BGG/Feigin–Fuks 级理解 | **本项目自身未完工**——这是全表**唯一**能拖垮一切下游结论的行，且与"是否走 moonshine"无关 |
| **横向空间的刻画方式** | `T` 定义为 `P ∩ ker(K_i, i>0)`，Lemma 5.1/5.2 **证明** `T` 由 DDF 单项式张成（张成 = 定理产出） | `ddfSpan`（DDF 单项式的张成，**定义**）与 `ddfCharacterization = phys ⊓ towerKerK`（**定义**），仅证 `ddfSpan ≤ ddfCharacterization`（单向），反向未证 | **真实数学缺口，规模小于上一行**——Borcherds Lemma 5.1/5.2 的论证思路（非退化性 + 上三角 Gram）本项目已有类似工具（`HeisenbergGram.lean`/`DDFGram.lean` 的非退化 Gram），有希望复用来补上反向包含，是一个独立可分拆的小任务 |
| **结论形状** | **同构** `P¹_r/N_r ≅ V^{1-(r,r)/2}`（含维数公式，Monster 情形读出 `j` 函数系数） | `no_ghost_of_spans` 的结论是**半正定性**（无鬼），不是同构；但 `ddfSpan ⊓ H_null = ⊥`（`SliceRank.lean`）+ `DDFSpans`（若证出）已经是内部直和的两个条件，同构本可"打包组装"得到 | **小缺口，非结构性**——补一条把已有两个引理装配成 `TowerPhysQuot ≃ₗ ddfSpan` 的语句，工作量小，见 §5 推荐首个 PR |
| **中心荷/临界维度入口** | `D=26` 只在 Lemma 5.4（`L_{i<0}` 生成代数的论证）进入，其余步骤对任意满足假设的 `V` 成立 | `D=26` 只在 `NullSeedsTwo.lean` 的 `L_2𝒟₂φ=(D-26)φ`（level-2 显式零态计算）进入，`N≤5` 计数恒等式对**一切** `D` 成立（Pascal 恒等式），`D` 只通过零态存在性进来 | **收敛证据，非缺口**——两条独立路线都确认 D=26 只在"张成/零态"这一步进入，不在 Gram/计数/DDF 代数里，是对彼此的正面佐证 |
| **系数环的整数加强** | Borcherds 1999 Thm 6.5（非 1992 论文本身）：Niemeier 格上的整数无鬼定理，供模 `p` 模月光用 | `WitnessInt.lean` 只证四条**几何假设**在 `ℤ` 上可满足，不触及 DDF 构造/商配对本身在 `ℤ` 上的良定义性 | **需要全新基础设施，且超出基本月光桥范围**——不建议列入计划，见 §3.2 |
| **`V` 的具体取法（Monster / fake monster）** | Monster：`V=V^♮`（FLM 轨形构造，未形式化，工程量巨大）；fake monster：`V=V(Λ)`（Li–Wang 型直接构造，与已有 `math.lattice-vertex-algebra` 同量级） | 均无 | **fake monster 是可行的更小目标，但仍受上面"张成假设"与"秩1→秩2"两行卡死**，见 §3.1 |

---

## 5. 四个判断的结论

### 判断 1：`worldsheet.string-cft-is-a-vertex-algebra-v2` 是否在关键路径上——**不在**

证据（本地图卡，非本轮新增）：`graph/statements/math/lattice-vertex-algebra.yaml` 正文与 notes
明写 Li–Wang 的格顶点代数存在性定理**只需要** `⟨α,α⟩ ∈ 2ℤ`，不需要非退化、正定、有限秩，且
notes 逐字记录「与 `worldsheet.string-cft-is-a-vertex-algebra-v2` 的分工……两张卡互不依赖」。
`⟨analysis 2026-09-18⟩` 这与 §2.3/§1.3 的核实一致：Borcherds 的路线整体建立在"VOA 是代数结构，
直接由格/振子生成元构造"之上，从未经过"任意 2 维 CFT 的路径积分量子化在什么条件下给出 VOA"
这个一般性问题（`string-cft-is-a-vertex-algebra-v2` 问的正是后者，是一个更难、更一般、目前
`open` 的命题）。本项目现有的 DDF/塔基础设施同样是**直接**从振子模展开构造出顶点算子结构
（`VertexOperator.lean`/`DDF.lean`），从未依赖"世界面 CFT 是顶点代数"这张卡。**两条路线
（Borcherds 原始路线、本项目现有路线）在这一点上殊途同归：都绕开了这张开放的卡。** 因此，
即便未来真的推进 moonshine 桥接，`string-cft-is-a-vertex-algebra-v2` 卡的进展**与之无关**，
不应被列为该工作的前置依赖。

### 判断 2：现有 Lean 代码有多少可复用——**核心机器几乎全部可复用，但不充分**

`⟨analysis 2026-09-18⟩` 按文件分类：

- **完全可复用、不需改动**（DDF 代数、Sugawara、Gram 非退化性、秩计数技术）：
  `Fock.lean`、`Sugawara.lean`、`PhysicalStates.lean`、`HeisenbergGram.lean`、`DDFGram.lean`、
  `DDFAlgebra.lean`、`DDFOperator*.lean`、`VertexOperator*.lean`、`Longitudinal.lean`、
  `TowerVirasoro.lean`、`SliceRank.lean`/`SliceDim.lean`、`SpuriousElimination.lean`、
  `TypeOneFamily.lean`、`DescendantKernel.lean`、`Level{Two,Three,Four,Five}Count.lean`、
  `NullSeedsTwo.lean`、`Witness*.lean`——这些都是"给定一个类光方向的 DDF 张成机器"，与是否
  最终桥接 Borcherds 记号无关，Borcherds 的路线**同样需要这整套东西**（只是包在 VOA 语言里）。
  估计占无鬼定理岛总代码量的 **80% 以上**。
- **需要新建、当前完全没有**：秩 2 格顶点代数 `V_{II_{1,1}}`（§2.3）；把 `V` 与 `II_{1,1}`
  因子解耦的张量积构造与联合 Virasoro（当前塔是 D 维一体，不是两个独立 Virasoro 作用的和）；
  `math.lattice-vertex-algebra` 存在性定理本身（Li–Wang 构造）尚未 Lean 化；Theorem 5.1
  意义下的同构结论装配（§4 表"结论形状"行，工作量小但目前不存在）；`ddfSpan =
  ddfCharacterization` 反向包含（§4 表"横向空间刻画"行）。
- **对 moonshine 而言额外需要、且工程量最大**：`V^♮`（FLM 轨形/扭模构造）——这本身大致是
  一个独立的、和"无鬼定理"同数量级甚至更大的形式化项目，Mathlib **完全没有**轨形/扭模顶点
  代数理论。
- **完全不需要，明确排除**：整数无鬼定理（Borcherds 1999 / Carnahan–Urano，§3.2）。

**结论：可复用比例高，但"可复用"≠"够用"——即使把现有 100% 的代码原样搬过去，
`N≥6` 未闭和秩1→秩2 翻译这两个缺口依然存在，且都是全新工作，不是复用能解决的。**

### 判断 3：是否有更便宜的中间目标——**fake monster 是真实但不"小"的目标；真正更小的目标是更早的两步**

`⟨analysis 2026-09-18⟩` fake monster（§3.1）确实比真 Monster 便宜得多（省掉 FLM 轨形构造），
但它**不能绕开** `N≥6` 张成缺口与秩1→秩2 翻译——这两者是无鬼定理本身的固有内容，与 `V` 取
`V^♮` 还是 `V(Λ)` 无关。**更便宜、且与 `N≥6` 完全解耦、可以立刻开始**的中间目标是：

1. **把结论形状补成同构**（§4 表倒数第二行）：用已有的 `ddfSpan ⊓ H_null = ⊥`
   （`SliceRank.lean` [Lean]）加一条标准线性代数装配（`Submodule` 的内部直和 ↔ 商模同构，
   Mathlib 应有现成引理，如 `Submodule.quotEquivOfIsCompl` 一类），在 `DDFSpans` 假设下把
   `no_ghost_of_spans` 的邻居定理升级成 `TowerPhysQuot ≃ₗ ddfSpan`——这是 Borcherds Theorem 5.1
   结论的**逐字形状**，工作量是一个引理，且**完全不依赖 `N≥6` 是否闭合**（假设形式给出，
   对任意 `N` 都对）。
2. **独立构造 `V_{II_{1,1}}`**（秩 2 洛伦兹偶幺模格的顶点代数）：这是纯 Li–Wang 型存在性定理的
   一个具体实例，`D`-无关、与本项目 D=26 的动量塔完全解耦，可以作为
   `math.lattice-vertex-algebra` 图卡在本项目里的**第一个具体应用**独立推进，为将来的秩 2
   翻译打基础，同样**不依赖 `N≥6`**。

这两步做完后，"桥接到 Borcherds 记号"这件事的**形状**会清楚很多，但依然要等
`N≥6`（或至少一个更大的有限窗口）关闭才能谈"张成对 Monster 应用意义下的所有 `r` 成立"。

### 判断 4：诚实的工期/风险判断

`⟨analysis 2026-09-18⟩`

- **若目标是"字面复现 Borcherds 1992 构造出（真）Monster 李代数"**：多年级项目。
  最大单点风险是 `N≥6` 的 DDF 张成闭合——本项目自己的追记（`no-ghost-theorem-v4--via-goddard-thorn.yaml`）
  把它形容为"需要 BGG/Feigin–Fuks 级别理解的独立大项目"，且 Mathlib **没有** Virasoro Verma 模的
  一般 Kac 行列式公式、没有 BGG 消解——这些是表示论里公认有一定深度的结果，本项目自己的
  `Virasoro/Verma.lean` 连 PBW 基本身、`V ≠ 0`（一般情形）都还没做完。第二大风险是 FLM 轨形/扭模
  VOA 构造（`V^♮`）——这在 Mathlib 和本项目里都是**从零开始**，工程量可能与整个无鬼定理岛相当
  甚至更大，是一个全新的数学专题（twisted modules、orbifold VOA 公理），不是"多写几个 Lean 文件"
  量级的工作。
- **若目标改为"fake monster"**（跳过 `V^♮`，用 `V(Λ)`）：省掉了上面第二个风险点，但第一个风险点
  （`N≥6`）原样保留，外加秩 1→秩 2 的翻译工程（§2.3，全新，未估过工作量但预计是数周到数月量级，
  取决于 Li–Wang 构造本身有多少能直接套用）。**仍是以年计的项目，只是比真 Monster 短。**
- **Mathlib 缺什么**：一般 Kac 行列式公式、Virasoro Verma 模 BGG 消解、格顶点代数的轨形/扭模理论、
  （本项目自己已发现）`Nat.Partition` 计数引理的系统性缺失（已被本项目用显式分类绕过，但每加一个
  `N` 就要重新手搓一轮，未来 `N≥6` 大概率还要继续手搓或找到真正的一般计数论证）。

---

## 6. 推荐的第一步 PR 与总体建议

**总体建议（一句话）**：现阶段不值得为 moonshine 桥接单独立项；`N≥6` 闭合本身已经是足够大、
足够优先的独立目标，moonshine 桥接应该等它（或至少若干个更大的 `N` 窗口）之后再评估。

**若要现在开始为将来做准备（低风险、与 `N≥6` 解耦、可并行）**，推荐顺序：

1. **`TowerPhysQuot ≃ₗ ddfSpan` 装配引理**（§5 判断 3 第 1 步）——一个引理，纯线性代数，
   把 `no_ghost_of_spans` 的结论形状从"半正定"升级到"同构"，独立于 moonshine 也有价值
   （更贴近文献里"无鬼定理"通常陈述的形状）。这是本文件推荐的**具体第一个 PR**。
2. **`V_{II_{1,1}}` 的独立 Lean 构造**（§5 判断 3 第 2 步）——落地 `math.lattice-vertex-algebra`
   在本项目里的第一个具体实例，为秩 2 翻译打基础，`D`-无关，可与无鬼定理主线完全并行开发。

两者都**不需要**先解决 `N≥6`，也**不需要**碰 `string-cft-is-a-vertex-algebra-v2`（判断 1）。

---

## 7. 环境障碍记录（供 lead 参考）

本任务的原始指令要求全程使用 `agora_join`/`agora_claim`/`agora_release` 协调总线，但**本次
会话实际可用工具集中自始至终不包含任何 `agora_*` 函数**（只有 Read/Grep/Glob/Bash/Write/Edit/
WebSearch/WebFetch）。这不是使用失误，是环境本身未暴露这些工具。已按 CLAUDE.md 对此类故障的
兜底原则处理：不重试、不臆造调用，在报告里如实记录，交由 lead 统一处理协调总线状态。

---

## 8. 留给 curator / researcher 的后续动作建议

- `graph/statements/worldsheet/ddf-spanning-hypothesis--via-borcherds-1992.yaml` 已经很完整，
  但可以补一条本轮核实的"秩1→秩2"结构性缺口（§2.3）作为 `gaps` 条目，这是此前登记的
  "`L_0` 本征空间有限维"缺口的**根本原因**，值得单独点名，方便未来 agent 不必重新推导。
- `math.lattice-vertex-algebra` 目前只是图卡，**没有对应 Lean 文件**——若 curator/reviewer
  认为值得，可以在图卡 `formal.lean_decl` 留空处加一条 note，指向本文件 §5 判断 3 第 2 步
  作为"第一个具体应用"的候选任务。
- fake monster（§3.1）、Borcherds 1999 整数无鬼定理（§3.2）目前都是 `⟨lit, 待核,
  WebSearch 2026-09-18⟩` 等级——若未来真的要推进这个方向，建议 researcher 补齐 L1 抽取
  （Borcherds 1999 原文 + 一篇 fake monster 的标准参考，如 Scheithauer 或 Borcherds 自己
  后续综述），本文件的判断不应在没有 L1 核实的情况下被当作最终结论引用。
