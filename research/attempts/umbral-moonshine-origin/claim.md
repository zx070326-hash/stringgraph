# Claim: 是否存在一个统一的（超）顶点代数 / 锥形顶点代数构造，其特征标给出全部 23 例 umbral moonshine 的 McKay–Thompson 级数

> **文件性质**：本文件是 `theorem-prover` 对"Mathieu / umbral moonshine 的概念起源"问题的**命题形状调研**产出，
> 不是一个已开工证明的命题卡。核心目的是把一个公认"没有锐利形状"的开放问题，压缩成一条精确到量词、
> 有终点线的数学陈述，供后续（若有意愿且配齐专业基础设施）攻关，或作为"已排查、暂不可攻"的记录。
> **取证等级约定**：文献定理号标 `⟨lit⟩` 且已用 WebFetch 独立核对原文（非仅搜索引擎摘要）的标 `⟨lit, 核实⟩`；
> 仅凭搜索引擎二手摘要、未独立核对原文页码/公式号的标 `⟨lit, 待核⟩`；本文作者自己的推断/归约标
> `⟨analysis 2026-09-18⟩`。
>
> 作者：prover（theorem-prover），2026-09-18。

---

## 0. 背景对象与记号（先把"游戏"讲清楚，量词才有意义）

### 0.1 Niemeier 格与 umbral 群

设 `L` 是 rank 24 的偶自对偶正定格。Niemeier 分类定理 ⟨lit, 待核：Niemeier 1973 原始分类，
现代整理见 Conway–Sloane *SPLAG* 第 16 章⟩ 断言：`L` 的同构类恰有 24 个，其中 23 个具有**非平凡根系**
`X`（根 = 范数 2 的向量），第 24 个是 Leech 格 `Λ`（无根）。把有根系的 23 个记为 `L^X`，`X` 取遍 23 个
"Niemeier 根系"（每个 `X` 是若干 ADE 型不可约根系的直和，且所有不可约分量的 Coxeter 数相同——这是
Niemeier 分类的一条内在约束 ⟨lit, 待核⟩）。

**Umbral 群的定义**（Cheng–Duncan–Harvey, arXiv:1307.5793, eq. (2.33)，⟨lit, 核实⟩ 已用 WebFetch
核对原文 HTML）：

    G^X := Aut(L^X) / W^X ,

其中 `Aut(L^X)` 是格自同构群（正交群在格上的稳定化子），`W^X` 是根系 `X` 的 Weyl 群（由根反射生成的
`Aut(L^X)` 子群）。原文明确指出根反射生成的子群是 **`Aut(L^X)` 的正规子群**（因为任意 `g ∈ Aut(L^X)`
把根系置换到自身，从而把反射 `s_α` 共轭到 `s_{gα}`，而 `{s_α : α ∈ X}` 恰是 `W^X` 的生成集）——
`⟨analysis 2026-09-18⟩`：这一步是纯线性代数（任意格上根系与其 Weyl 群的一般事实），**不是** umbral
moonshine 特有的深刻内容，不构成本文候选命题的"卡点"。

23 个 `G^X` 是一族有限群（阶从个位数到约 `2.4×10^7`，包含 `M_24`、`M_12`、`M_22` 的扩张、
`2.M_12`、对称群与二面体群等；⟨lit, 待核⟩ 精确表见 CDH Table 2）。

### 0.2 Umbral moonshine 猜想（现在已证，见 §1）

对每个 `X`，CDH 构造/猜测了一个**权 1/2 向量值 mock 模形式** `H^X = (H^X_r)_{r}`（分量按 `X` 相关的
一个有限指标集标号），并对每个 `g ∈ G^X` 定义 **McKay–Thompson 级数** `H^X_g`（Rademacher 和构造，
由 `g` 在某个"影子" Jacobi 形式上的作用数据决定；⟨lit, 待核⟩ 精确构造见 CDH §5–6）。

**Umbral moonshine 猜想**（现在已证，见 §1）：∀ 23 个 `X`，存在 `ℤ`-分次复向量空间

    K^X = ⊕_{d ∈ 指标集} K^X_d ,   dim K^X_d < ∞ ,

配一个 `G^X` 在 `K^X` 上的作用（保持分次），使得

    ∀ g ∈ G^X :   H^X_g(τ) = "graded trace of g on K^X"（按 CDH 给定的编码，含 mock 补正）.

### 0.3 已知的"障碍事实"：非零权

`⟨lit, 核实⟩`（Cheng, *Generalised Umbral Moonshine*, arXiv:1608.07835，用 WebFetch 核对原文 HTML §2.2）：

> "the non-vanishing weight of the umbral moonshine function[s]" 与
> "one should be able to attach a weight zero modular object to the moonshine module"
> 之间的张力：若 `K^X` 是"传统手性 CFT / VOA"的态空间，物理常识 + VOA 数学结果都要求能配出一个
> **权为零**的（全纯）Jacobi 形式（例如亏格），但 `H^X` 本身权为 1/2。

> "This process can be done in a straightforward manner for the eight cases of umbral moonshine"
> （8 个纯 A 型根系的 Niemeier 格，⟨lit, 待核⟩ 精确清单见 CDH Table 2）——即对这 8 个可以配出权零对象；
> "not for the remaining fifteen cases involving D- and/or E-type root systems"——对另外 15 个（含 D/E 型
> 分量）**做不到**（若要求全纯）。

> 且**即使在 8 个 A 型里**，"apart from the A_1^{24} case of Mathieu moonshine, the associated weight
> zero Jacobi forms cannot coincide with [a genuine CFT elliptic genus]"——因为一般 CFT 亏格要求
> `q^0 y^{m-1}` 项非零（NS-NS 基态贡献），而除 `A_1^{24}` 外该项恒为零。

`⟨analysis 2026-09-18⟩`：这条障碍事实本身**已经是文献里明确写出的定性论断**，不是我的新发现；
但它没有被写成一条**可独立核验的、量词精确的"不可能"命题**（下面 §2 尝试补这一步，作为候选命题之一，
标注为**候选 B**，与候选 A 并列）。

---

## 1. 三分类（调研结果，供归档）

### 1.1 已证的定理（可作为已知背景引用，但**均不在图 `graph/` 中**，故 proof.md 不能把它们当"rigorous 砖块"，只能作为待办文献任务）

| # | 陈述 | 来源 | 取证等级 |
|---|---|---|---|
| T1 | K3 椭圆亏格按 `g ∈ M_24` 扭化得到的级数序列，确实是 `M_24` 的**真实**（非仅形式）特征标；即 EOT 猜想在 `X = A_1^{24}` 情形成立 | Gannon, *Much ado about Mathieu*, arXiv:1211.5531 | ⟨lit, 待核⟩（二手摘要确认，未独立核对定理号） |
| T2 | 23 个 Niemeier 格各自的 umbral moonshine 猜想（`X ≠ A_1^{24}` 的另外 22 例）成立：存在满足 §0.2 特征标条件的分次 `G^X`-模 | Duncan–Griffin–Ono, *Proof of the Umbral Moonshine Conjecture*, arXiv:1503.01472，其"Theorem 9.3"被称为 Borcherds 定理的 umbral 对应物 | ⟨lit, 待核⟩（定理号来自二手摘要，未独立核对） |
| T3 | 任意保 `N=(4,4)` 超对称与谱流算子的 K3 sigma 模型，其对称群都嵌入 Conway 群 `Co_1`（Mukai–Kondo `M_23` 定理的弦论推广） | Gaberdiel–Hohenegger–Volpato, *Symmetries of K3 sigma models*, arXiv:1106.4315 | ⟨lit, 待核⟩ |
| T4 | 存在具体的 K3 CFT（`T^4/ℤ_2` 自对偶点、Gepner 模型 `(2)^4`、`(1)^6`）其对称群**不是** `M_24` 的子群——即"任何单个 K3 sigma 模型都不承载完整 `M_24` 作用"这一断言的**反例式证明**（而非猜测） | 同上 arXiv:1106.4315，附录 C | ⟨lit, 待核⟩ |
| T5 | 8 个纯 A 型 Niemeier 格情形，可以直接配出权零 Jacobi 形式；其余 15 个（含 D/E 分量）不能（若要求全纯） | Cheng, *Generalised Umbral Moonshine*, arXiv:1608.07835 §2.2 | ⟨lit, 核实⟩（已用 WebFetch 核对原文段落） |
| T6 | `A_1^{24}`（`M_24`）、`E_8^3`、`D_4^{⊕6}`、以及 2022 年后追加的 `ℓ=8,12,16` 三例，各自有**显式**（超）顶点代数 / 锥形顶点代数构造，其特征标复现对应的 `H^X_g` | Duncan–Griffin–Ono, *The Umbral Moonshine Module*, arXiv:1412.8191；Cheng–Harrison(–Anagiannis), *K3 Elliptic Genus and an Umbral Moonshine Module*, arXiv:1709.01952；Cheng–Sgroi, *Cone Vertex Algebras...*, arXiv:2203.03052 | ⟨lit, 待核⟩（案例清单来自二手摘要拼接，未逐篇核对；**需要 curator/researcher 核实到底哪些 `X` 已被覆盖，本文档不保证这张表穷尽或互斥**） |
| T7 | 无鬼定理路线（DDF/BRST 物理态）可以从**无根**偶自对偶格（Leech 格、或 `II_{1,1}⊕Λ`）构造出 generalized Kac–Moody 代数，其分母公式就是 Borcherds 怪兽李代数 / Conway 型 BKM 超代数 | Borcherds, *The monster Lie algebra*, Adv. Math. 83 (1990)；Harrison–Paquette–Volpato, *A Borcherds–Kac–Moody Superalgebra with Conway Symmetry*, arXiv:1803.10798 | ⟨lit, 待核⟩ |
| T8 | 同一"物理态 + 无鬼定理"技术路线应用到**有根**的 23 个 Niemeier 格（而非 Leech 格）上，会给出（不同于 umbral moonshine 的）另一族 generalized Kac–Moody 代数，其根重数由（全纯）Borcherds 乘积公式给出 | Niemann, *Some Generalized Kac-Moody Algebras with Known Root Multiplicities*, arXiv:math/0001029（其博士论文）；相关 Höhn–Scheithauer 用 `A_3^8` Niemeier 格 + 无鬼定理构造 fake baby monster 李代数 | ⟨lit, 待核⟩ |

**`⟨analysis 2026-09-18⟩` 关键辨析（T7 vs T8 vs umbral moonshine）**：T7、T8 用的是**同一套**
"弦在格上量子化 + 无鬼定理 ⇒ BKM 代数 + 分母公式"技术（本项目 `formal/` 里 `worldsheet.no-ghost-theorem-v4`
正是这条技术链的形式化目标）。T7（无根格）给出**monstrous/Conway moonshine**（已解决，权为 0，
对象是**全纯**自守形式）。T8（有根格）给出的是一族**不同的、已经解决**的 BKM 代数（Niemann/Scheithauer
工作，权也是 0，全纯自守形式）——但这族代数的分母公式**不是** umbral moonshine 的 mock 模 McKay–Thompson
级数 `H^X_g`！umbral moonshine 的对象本质上是权 1/2、**非全纯**（mock）的，这正是 §0.3 障碍事实的根源。
**没有任何已知文献在 T8 的 BKM 代数与 umbral moonshine 的 `K^X` 之间建立桥梁**——这是本文档判断
"统一构造问题"仍然开放、且与本项目无鬼定理资产**表面接近但实际不可达**的核心技术原因（详见 proof.md §4）。

### 1.2 仅有观察 / 数值吻合（无严格推导机制）

| # | 陈述 | 来源 |
|---|---|---|
| O1 | "Symmetry surfing"：把不同 K3 CFT 的对称群"拼接"能在**最低阶**非平凡 BPS 态上给出一个 `M_24` 作用 | Taormina–Wendland, arXiv:1107.3834, arXiv:1303.2931 |
| O2 | 上述拼接推广到更高阶 BPS 态时给出"非平凡支持证据"，但非证明 | Gaberdiel–Keller(–Paul), arXiv:1609.09302 |
| O3 | 截至 2020–2026 的多篇后续文献（含 2026 年 JHEP 一篇关于 `ℤ_3` 轨道化 K3 的论文），symmetry surfing 对**全部** BPS 态成立与否仍未证明或证伪 | 多篇，见 proof.md §3.2 |

### 1.3 真正开放，且逐一判断"是否有锐利形状"

| # | 开放问题 | 是否有锐利形状？ | 判断理由 |
|---|---|---|---|
| P1 | 是否存在一个统一的（超）VOA / 锥形顶点代数构造，同时给出全部 23 例 `K^X`？ | **有**（存在性命题，特征标恒等式作为终点线） | 见 §2 候选 A；但"统一"一词本身没有先验的构造配方，只能对每个 `X` 单独判定"是否有构造"，穷尽 23 例才算"统一"完成 |
| P2 | Niemeier ↔ umbral 群对应能否写成某种函子/伴随？ | **没有**（不构成实质开放问题） | `G^X = Aut(L^X)/W^X` 已是**定义**（eq 2.33），`W^X ⊲ Aut(L^X)` 是初等事实（`⟨analysis⟩` 见 §0.1）；23 个 Niemeier 格之间没有自然的态射范畴（它们是两两不同构的格，只有"近邻格"关系等其他结构），造"函子"缺乏范畴论意义上的定义域，容易沦为文字游戏而非可证伪命题 |
| P3 | Symmetry surfing 能否写成一条精确命题？ | **有**，但已经在文献里精确表述（非本项目首创），且是活跃的物理/CFT 前沿（见 O3） | 精确形式：∀ K3 CFT 参数空间 `M`（保 `N=(4,4)`）与 BPS 态阶 `n`，是否存在 `M_24` 在所有 `n`-阶 BPS 态空间直和上的作用，其限制到每个 CFT 点 `p ∈ M` 的对称子群 `G_p ≤ Co_1` 上与真实作用一致？——这需要**逐点**的 K3 CFT 对称群数据（Gepner 模型、轨道化模型的显式表示），本项目无此类物理输入 |
| P4 | 权障碍（T5/§0.3）能否升级成一条严格的"不可能"定理（而非文献里"expectation"式论断）？ | **候选**，见 §2 候选 B | 需要精确刻画"传统手性 CFT/VOA 特征标"这一类对象的模变换性质（本质上要用到 Zhu 定理：C2-cofinite 有理 VOA 的特征标满足权 0 模不变（对某乘子系统）的常微分方程），而 Zhu 定理**不在图里**，也不是本项目容易独立重证的深度定理 |

---

## 2. 候选锐利命题

### 候选 A（首选，写入本节主命题）：某个尚未构造的 D/E 型 Niemeier 根系 `X_0` 的显式构造存在性

**`⟨analysis 2026-09-18⟩` 选择理由**：把"统一构造 23 例"直接当作命题不满足"有终点线"的要求——
终点线只能逐 `X` 核验（构造 + 特征标恒等式），23 例不是一次性可判定的单一断言。因此把候选 A 精确化为
**最小可攻单元**：挑一个**尚未见公开显式构造**（据 §1.1 T6 的清单，`⟨lit, 待核⟩`）的 `D`/`E` 型
Niemeier 根系 `X_0`，命题是：

> **命题 A（`X_0` 的显式构造存在性）**：
> 设 `X_0` 是一个具体的、Cheng–Duncan–Harvey (arXiv:1307.5793) Table 2 中列出的、**含 D 或 E 型分量**
> 的 23 个 Niemeier 根系之一，且据 §1.1 T6 的核实结果确认**尚无公开的显式（超）顶点代数构造**。
> 记 `G^{X_0}` 为其 umbral 群（§0.1），`H^{X_0}_g` (`g ∈ G^{X_0}`) 为 CDH 给出的 McKay–Thompson
> mock 模形式族。
>
> **命题**：∃ 一个 `ℤ_{≥0}`-分次（或 `ℤ + 常数`-分次，视 CDH 约定）复向量空间 `K^{X_0} = ⊕_n K^{X_0}_n`，
> `dim K^{X_0}_n < ∞`，配一个（可能带扭化/orbifold 结构的）顶点代数式乘法结构，以及 `G^{X_0}` 在其上
> 保持分次与结构的忠实（或至少满足特征标要求的）作用，使得
>
>     ∀ g ∈ G^{X_0}, ∀ n :   Tr(g | K^{X_0}_n) · q^{n + 常数} 的母函数 = H^{X_0}_g(τ)（按 CDH 编码，
>                                                                        含 mock 补正规则）。
>
> **量词范围**：`X_0` 固定（不是"∃ X_0"——那样退化成"找一个已知案例重新抄一遍"，没有意义；
> 而是**指定一个具体尚未解决的 `X_0`**，例如据 T5 排除掉的 8 个 A 型之外、且据 T6 排除掉 `E_8^3`、
> `D_4^{⊕6}`、`ℓ=8,12,16` 后**仍未见文献覆盖**的一个 D/E 型根系。**本文档尚未最终锁定 `X_0` 的取值**
> ——见 proof.md §2 的 `[GAP: X_0 未定]`，这是启动本命题证明前的**必要前置步骤**，需要 curator/researcher
> 逐篇核对 T6 清单后确定一个"最简单的、confirmed 未构造"的 `X_0`。

**终点线**：给出满足上式的 `(K^{X_0}, \text{结构}, G^{X_0}\text{-作用})` 的显式定义，并证明特征标恒等式
对**每个** `g ∈ G^{X_0}`、**每个**分次阶 `n`（不只是前几项 q-展开）成立——后者通常靠恒等式两边都满足同一个
模性质微分方程/Rademacher 和的封闭形式来"一次性"证明，而不是逐项核对（逐项核对只能验证到有限阶，
不构成证明）。

### 候选 B（备选，权障碍的严格化）

> **命题 B（权障碍的"不可能"定理，条件式）**：
> 设 `V` 是一个 `ℤ_{≥0}`-分次、`C_2`-余有限、有理的（超）顶点算子代数，中心荷 `c`，`G ≤ Aut(V)` 有限，
> `V` 的每个不可约模的扭化特征标（Zhu 意义下）在 `SL(2,ℤ)`（或其某个同余子群，视扭化类型）下张成一个
> 权为 **0** 的向量值模形式表示（Zhu 定理，⟨lit, 待核，本项目图中无对应节点⟩）。
>
> 若进一步（如 umbral moonshine 情形）某个 `g ∈ G` 的扭化特征标经"完备化/影子修正"后等于一个权 **1/2**
> 的（非全纯）mock 模形式 `H_g`，且该修正是非平凡的（即 `H_g` 本身不是模形式，需要 Eichler 积分 /
> 非全纯补项才能补成模形式），**则** `V` 不能是满足前提的（`C_2`-余有限、有理）VOA。
>
> **量词范围**：∀ 满足前提的 `(V, G, g)` 三元组。

**`⟨analysis 2026-09-18⟩` 关于候选 B 的诚实评估**：这条命题的证明骨架其实只是"Zhu 定理 + 权的可加性
在模变换下不匹配 ⇒ 矛盾"，**数学内容单薄**（本质上是把文献里"expectation"语气的论断形式化，
不是新结果），且**必须引用 Zhu 定理作为砖块**——而 Zhu 定理属于 VOA 表示论的深度定理（1996 年，
涉及 `C_2`-余有限性、顶点算子的可结合性延拓到环面等），**不在本项目图里，也不是本项目基础设施
（Virasoro/Fock/格顶点代数的 Lean 形式化）能够独立重证的规模**。故即使写出候选 B，其"证明"要么
（a）诚实标注"引用 Zhu 定理，未在本项目内验证"（红旗，等价于在未形式化的深度外部结果上叠证明），
要么（b）尝试从头证 Zhu 定理（明显超出本项目当前范围，是另一个独立的大工程）。

---

## 3. 已知砖块盘点（供任何未来证明尝试参考；**本项目图里目前一块都够不着**）

| 需要的工具 | 图里是否存在 rigorous/formalized 节点？ | 备注 |
|---|---|---|
| 格顶点代数一般理论 | `math.lattice-vertex-algebra`（存在，rigorous，见 `graph/statements/math/lattice-vertex-algebra.yaml`） | 只是一般格 VOA 构造（Li–Wang 等），**没有** Niemeier 格 / 根系专属内容，**没有**轨道化（orbifold）构造，**没有**超 VOA（NS/R 扇区） |
| Weyl 群、根系反射 | 无对应图节点（是纯粹的初等线性代数，未见有专门节点） | 若需要可自行补一条初等引理，但价值有限 |
| Zhu 定理（VOA 特征标模性质） | **不存在** | 深度外部定理，见候选 B 讨论 |
| Borcherds 分母公式 / generalized Kac–Moody 代数 | **不存在**（本项目 `worldsheet.no-ghost-theorem-v4` 是无鬼定理本身，尚未构造出 BKM 代数层） | 即使无鬼定理形式化完成，也只给出"物理态维数"，不会自动给出 T7/T8 里的 BKM 代数结构与分母公式——那是额外一层（顶点算子的李括号 + Borcherds 的 no-ghost 论证的代数版本），当前 `formal/NoGhost/` 未做 |
| Mock 模形式 / Rademacher 和理论 | **不存在** | 全新的数论输入，超出本项目现有 Lean 资产（`Math/DedekindEta*.lean`、`Math/RegulatedSum.lean` 只到经典模形式与 ζ 正规化） |
| Mathieu / umbral 群表示论（`M_24` 等 23 个群的特征标表） | **不存在** | 需要 Atlas 数据；不是不可行，但需要专门的有限群表示论基础设施（本项目目前没有） |

**结论（本节）**：候选 A、候选 B 各自需要的每一件工具，图里都没有对应的 rigorous/formalized 节点。
这不是"缺一两个引理"的量级差距，而是缺**整层基础设施**（超 VOA、轨道化、mock 模形式、稀有有限群表示论）。

---

## 4. 终点线小结

- **候选 A**（首选）：终点线 = 给出 `X_0` 的显式构造 + 对全部 `g ∈ G^{X_0}`、全部阶数的特征标恒等式证明。
  **前置未完成步骤**：锁定 `X_0`（需 researcher/curator 核实 T6 清单的覆盖范围）。
- **候选 B**（备选）：终点线 = 完整证明"不可能"定理，但需要 Zhu 定理作为砖块，本项目图里没有，
  必须标红或从头重证（不现实）。

两条候选命题都**精确到量词、有终点线**，满足本任务对"锐利形状"的要求。但两者是否**可攻**
（本项目当前资产能否推进），见 proof.md 的路线分析与最终裁定——结论是否定的（见 proof.md §5）。
