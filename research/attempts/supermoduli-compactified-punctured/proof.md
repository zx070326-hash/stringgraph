# Proof (draft, incomplete) — 紧化 + 穿孔超模叠的非投影性

**状态**：draft，未完成。本文档遵循 `research/CLAUDE.md` 纪律：完成的引理照常写"证明"，未完成
的地方显式标 `[GAP: ...]`，不用含糊语言掩盖跳步。

---

## §0 定义（层论表述，为 §1 的初等引理铺垫）

设 $(X,\mathcal O_X)$ 是一个复超空间（complex superspace）：拓扑空间 $|X|$ 配一个 $\mathbb
Z/2$-分次交换 $\mathbb C$-代数的结构层 $\mathcal O_X$。设 $\mathcal J_X\subset\mathcal O_X$ 是由
全部奇元素生成的理想层（幂零）。**约化空间** $X_{\rm red}$ 定义为同一拓扑空间 $|X|$ 配结构层
$\mathcal O_{X_{\rm red}}:=\mathcal O_X/\mathcal J_X$（纯偶、无幂零元的普通复空间结构层）。有一个
标准的闭嵌入 $\iota\colon X_{\rm red}\hookrightarrow X$，其在结构层上的诱导映射正是商映射
$$q_X\colon \mathcal O_X\twoheadrightarrow \mathcal O_{X_{\rm red}}.$$

**定义（投影，与既有图卡 `math.supermoduli-space-not-projected` 陈述段的坐标化定义等价）**：
$X$ 称为**全纯投影的**，若存在超空间态射 $\pi\colon X\to X_{\rm red}$ 使 $\pi\circ\iota =
\mathrm{id}_{X_{\rm red}}$。

**引理 0.1（投影 ⟺ 层的分裂）**：$X$ 全纯投影 $\iff$ 存在结构层的 $\mathbb C$-超代数层同态
$$s\colon \mathcal O_{X_{\rm red}} \longrightarrow \mathcal O_X$$
（定义在同一拓扑空间 $|X|$ 上）使 $q_X\circ s = \mathrm{id}_{\mathcal O_{X_{\rm red}}}$。

*证明*：态射 $\pi\colon X\to X_{\rm red}$（超空间之间）由一对数据给出：底空间的连续映射
$|\pi|\colon |X|\to|X_{\rm red}|=|X|$，与结构层拉回 $\pi^\#\colon\mathcal O_{X_{\rm
red}}\to\pi_*\mathcal O_X$。由 $\iota$ 的底空间映射 $|\iota| = \mathrm{id}_{|X|}$（约化不改变拓扑
空间，只杀幂零方向），及 $\pi\circ\iota=\mathrm{id}_{X_{\rm red}}$ 取底空间映射得
$|\pi|\circ|\iota|=|\pi|=\mathrm{id}$，故 $|\pi|=\mathrm{id}_{|X|}$，从而 $\pi_*\mathcal
O_X=\mathcal O_X$（同一拓扑空间上的推前是恒等）。于是 $\pi^\#=:s\colon\mathcal O_{X_{\rm
red}}\to\mathcal O_X$。态射合成在结构层上按反变函子的方向合成：$(\pi\circ\iota)^\#=
\iota^\#\circ\pi^\#$；而 $\iota^\#=q_X$（这是闭嵌入 $X_{\rm red}\hookrightarrow X$ 的定义：拉回
函数即取模 $\mathcal J_X$）。故 $\pi\circ\iota=\mathrm{id}_{X_{\rm red}}$ 精确翻译为
$q_X\circ s=\mathrm{id}_{\mathcal O_{X_{\rm red}}}$。反过来，任何满足该等式的层同态 $s$ 显然给出
一个态射 $\pi$（取 $|\pi|=\mathrm{id}$，$\pi^\#=s$）满足 $\pi\circ\iota=\mathrm{id}$。∎

这条引理是初等的、标准的（本质上是"投影"定义本身的层论翻译），本尝试没有声称它是新结果，只是把它
写成后面 §1 需要的精确形式。

## §1 紧化提升引理（Compactification Lifting Lemma）——本尝试的核心工具

**引理 1.1**：设 $\overline X$ 是一个复超空间，$U\subseteq\overline X$ 是一个（拓扑意义上的）
**开**子空间，赋予限制结构层 $\mathcal O_U:=\mathcal O_{\overline X}|_U$（即 $(U,\mathcal
O_{\overline X}|_U)$ 本身是一个超空间，是 $\overline X$ 的开子超空间）。则：
$$\overline X\ \text{全纯投影}\ \implies\ U\ \text{全纯投影}.$$
等价地（逆否）：$U$ 非投影 $\implies$ $\overline X$ 非投影。

*证明*：设 $\overline X$ 投影，取引理 0.1 给出的分裂 $s\colon\mathcal O_{\overline X_{\rm
red}}\to\mathcal O_{\overline X}$，满足 $q_{\overline X}\circ s=\mathrm{id}$。

**第一步（约化与限制交换）**：层的限制函子 $(-)|_U$ 对开子集是精确的（这是层论最基本的事实之一：
限制到开子集的截面预层化过程保持核/余核），故
$$\mathcal O_{\overline X_{\rm red}}\big|_U \;=\; \big(\mathcal O_{\overline X}/\mathcal
J_{\overline X}\big)\Big|_U \;=\; \mathcal O_{\overline X}|_U\big/\mathcal J_{\overline X}|_U
\;=\;\mathcal O_U/\mathcal J_U \;=\;\mathcal O_{U_{\rm red}},$$
这里用了 $\mathcal J_{\overline X}|_U=\mathcal J_U$（奇元素生成的理想层限制到开子集仍是奇元素
生成的理想层——限制不改变分次结构）。即：**$U$ 的约化空间的结构层，就是 $\overline X$ 的约化空间
的结构层限制到 $U$**；记 $U_{\rm red}:=(U,\mathcal O_{\overline X_{\rm red}}|_U)$，这与"$U\cap
\overline X_{\rm red}$"（$U$ 与 $\overline X$ 的约化子空间的拓扑交，配诱导结构）是同一个对象。

**第二步（限制商映射）**：商映射 $q_{\overline X}$ 限制到 $U$ 就是 $q_U$：$q_{\overline
X}|_U=q_U\colon\mathcal O_U\to\mathcal O_{U_{\rm red}}$（限制函子与取商可交换，同上）。

**第三步（限制分裂）**：$s$ 是定义在整个 $|\overline X|$ 上的层同态；限制到开子集 $U$ 给出
$s|_U\colon\mathcal O_{\overline X_{\rm red}}|_U\to\mathcal O_{\overline X}|_U$，即
$s|_U\colon\mathcal O_{U_{\rm red}}\to\mathcal O_U$（层同态限制到开子集仍是层同态：对任意
$V\subseteq U$ 开，$(s|_U)_V=s_V$，兼容性条件是逐点/逐开集验证，限制不破坏）。

**第四步（验证分裂条件）**：对任意开 $V\subseteq U$，
$$(q_U\circ s|_U)_V = (q_{\overline X})_V\circ s_V = (q_{\overline X}\circ s)_V =
(\mathrm{id})_V=\mathrm{id}_{\mathcal O_{\overline X_{\rm red}}(V)},$$
故 $q_U\circ s|_U=\mathrm{id}_{\mathcal O_{U_{\rm red}}}$：$s|_U$ 是 $q_U$ 的分裂。由引理 0.1，
$U$ 全纯投影。∎

**引理 1.1 的内容其实就是 Donagi–Witten Remark 1.4 那句未加证明的话的严格版本**（图卡
`math.supermoduli-space-not-projected` 逐字："Asking for the compactification to be projected
would only be a stronger condition"）。DW 在 2013 年只是断言，本引理给出完整初等证明——证明本身
不难（层论限制函子的精确性是标准事实），但据 `prior-art.md` 的检索，本尝试没有在公开文献中找到
这条证明被显式写出过。**这一引理本身的"新颖性"仅在于"把一句已被断言的话证出来"，不是深刻的新
数学**——本尝试如实评估其难度等级，不夸大。

**引理 1.1 的真正价值**在于它可以被**应用**到目前没有任何文献应用过的场合——见 §4 的推论。

## §2 从超空间到超叠（Deligne–Mumford 超叠）的推广

FKP 的紧化对象 $\overline{\mathfrak S}_{g,n_{\rm NS},n_{\rm R}}$ 与 Donagi–Witten/Donagi–Ott/Wang
的对象都严格地说是**超叠**（moduli stacks，见既有图卡 `math.supermoduli-space-not-projected`
Remark 1.6 段），不是裸的超空间——曲线带非平凡自同构，模问题本身是叠。引理 1.1 需要推广到超叠层面。

**推广的标准做法**：取一个 étale 图册 $p\colon X_0\to \overline X$（$X_0$ 是超空间/超概形，$p$
étale 满射），$\overline X$ 的结构层由 $X_0$ 上的结构层 $\mathcal O_{X_0}$ 配合沿 étale 群胚
$X_0\times_{\overline X}X_0\rightrightarrows X_0$ 的下降数据（descend datum）表示。"投影"定义为：
存在 $X_0$ 上的分裂 $s_0\colon\mathcal O_{(X_0)_{\rm red}}\to\mathcal O_{X_0}$，且 $s_0$ 与下降
数据相容（即在群胚的两个箭头下拉回一致，满足余循环条件），从而 $s_0$ **下降**为 $\overline X$ 上的
一个整体分裂。

给定开子叠 $U\subset\overline X$：这由图册的开子概形 $U_0:=p^{-1}(U)\subset X_0$ 表示，带限制后的
群胚 $U_0\times_U U_0\rightrightarrows U_0$（恰是原群胚箭头限制到 $U_0$ 上的部分——开子概形的
预像在群胚箭头空间里自然是开的，箭头限制到开子集仍是箭头）。若 $s_0$ 是 $\overline X$ 上下降数据
相容的分裂，把 §1 引理 1.1 的证明逐字应用到超空间 $X_0$（把 $\overline X$ 换成 $X_0$，$U$ 换成
$U_0$）得到 $s_0|_{U_0}$ 是 $q_{U_0}$ 的分裂；而相容性（余循环条件）是若干层同态相等的等式，
这类等式在限制到开子集后自动保持成立（等式限制到开子集仍是等式）。故 $s_0|_{U_0}$ 与限制后的
群胚相容，下降为 $U$ 上的整体分裂，即 $U$ 投影。

**`[GAP-STACK]`**：以上是标准描述性论证（"标准下降论证"），本尝试**没有把余循环条件的相容性逐个
图表画出来验证**（即没有严格证明"限制到开子集"这一操作与"取下降数据"这两个操作严格可交换，需要
的是纤维积 $U_0\times_U U_0$ 确实等于 $(X_0\times_{\overline X}X_0)|_{U_0\times U_0}$ 这一类
基点层面的验证）。这是一条**标准、几乎可以肯定成立**、但**本轮未逐条走完**的技术性推广，标记为
`[GAP-STACK]`——风险等级：低（这类"开子叠继承性质"的论证在代数几何里是教科书级别的常规操作，
DW/CN-2026 等论文处理"is a moduli stack"这一点时也都不展开证明，直接当作背景事实使用），但诚实
记录为未完全走完的一步。

## §3 验证引理的前提：存在性 + 可比较性

### §3.1 存在性与光滑性（无 `[GAP]`——直接引用 FKP Theorem A）

FKP arXiv:2006.13271 Theorem A（本尝试直接读取原文核实，见 `prior-art.md` 第 12 条）：对任意
$g\ge0$（满足稳定性数值条件）、$n_{\rm NS}\ge0$、$n_{\rm R}\ge0$（偶数，标准 GSO 要求），存在
**光滑、固有的** Deligne–Mumford 超叠 $\overline{\mathfrak S}_{g,n_{\rm NS},n_{\rm R}}$，表示带
$n_{\rm NS}$ 个 NS 穿孔、$n_{\rm R}$ 个 Ramond 穿孔的稳定超曲线族的模函子。这满足引理 1.1/§2 里
"$\overline X$"的角色所需的前提（$\overline X$ 是一个良定的超叠，其结构层理论上是良定的——光滑性
本身不是引理 1.1 的前提，但它保证 $\overline X$ 本身不是病态对象，是应用障碍理论/层论讨论投影性的
先决条件）。

FKP 自己的 Definition 2.4(ii)（本尝试直接读取，见 `prior-art.md` 第 12 条摘要）明确要求："存在
一个纤维稠密的开子集 $U\subset X$ 使 $U/S$ 光滑，且所有穿孔的标记点/Ramond 除子都落在 $U$ 内。"
这正是 §1/§2 需要的"$U\subset\overline X$ 是开子叠"这一前提的直接来源：$U$（光滑轨迹，无退化
边界节点）就是"未紧化的带穿孔超模叠"，而它被 FKP **自己的构造**保证是 $\overline{\mathfrak
S}_{g,n_{\rm NS},n_{\rm R}}$ 的一个开（纤维稠密）子叠。

**`[GAP-LIT]`**：FKP arXiv:2006.13271 目前不在 `literature/sources.bib`，此依赖需 lead 派
researcher 补登记（见 `prior-art.md` 情报移交一节）。这是**程序性**缺口，不是数学缺口。

### §3.2 功能子的可比较性——`U` 是否就是 DW/Donagi–Ott/Wang 讨论的对象？

这是本尝试**唯一的实质数学风险点**。逐项检查：

**NS 穿孔（命题 A 所需）**：`[GAP-DEF-NS]`——**风险：低**。NS 穿孔在所有相关文献中的定义都是
"曲线族的一个截面"（marked point / section $S\to X$），这是标准、无歧义的定义，物理上对应 NS
扇区的顶点算子插入点。FKP 的 NS 穿孔定义（Definition 2.4，本尝试读取的部分）与 Donagi–Witten 的
$\mathfrak M_{g,n}$ 穿孔定义（既有图卡 `math.supermoduli-space-not-projected` 未展示穿孔的具体
定义细节——该卡只读了 §1，穿孔的形式化定义在 DW 正文 §... 本尝试未读，但"穿孔=截面"是该领域唯一
标准约定，没有第二种可能的定义竞争）在概念层面应当逐字一致。**本尝试判断：这一项风险低，几乎可以
确信一致，但未经逐条定义对照的形式化核实，仍标记为开放，不谎称"已核实"。**

**Ramond 穿孔（命题 B/C 所需）**：`[GAP-DEF-R]`——**原本风险：中；补充核实后：低**。本尝试用
`WebFetch` 直接查阅 Donagi–Ott arXiv:2308.07957 HTML 版正文，得到其 Ramond 穿孔的精确定义
（逐字/近逐字）：

> "A Ramond divisor on $S$ is [a] prime divisor $\mathcal P_R\subset S$ for which there exists a
> rank [0|1 subbundle $\mathcal D$ fitting into the exact sequence] $0\to\mathcal D\to\mathcal
> T_{S/T}\to \mathcal D^{\otimes2}(\mathcal P_R)\to0$."
> "The prime components $\mathcal P_i\subset\mathcal P_R$ are called Ramond punctures."
> "Ramond punctures are not marked points!"

对照 FKP（本尝试直接读取 arXiv:2006.13271 pp.1–6，见 `prior-art.md` 技术发现/检索记录第 12 条）
Definition 2.1 的构造：取 $\mathcal D\subset\mathcal T_{X/S}$ 为秩 $0|1$ 子丛，Ramond 穿孔除子
$R$ 定义为映射 $\mathcal D^{\otimes2}\to\mathcal T_{X/S}/\mathcal D$ 的零点除子。

**两者是同一个几何结构的两种等价表述**：若映射 $\phi\colon\mathcal D^{\otimes2}\to\mathcal
T_{X/S}/\mathcal D$（FKP）在除子 $R$ 处恰好消没（一阶零点），则 $\phi$ 在 $R$ 外是同构，扭一个
$R$ 使其在整体上变成同构：$\mathcal D^{\otimes2}(R)\;\xrightarrow{\ \sim\ }\;\mathcal
T_{X/S}/\mathcal D$，取逆即 $\mathcal T_{X/S}/\mathcal D\cong\mathcal D^{\otimes2}(R)$，
对应 Donagi–Ott 短列 $0\to\mathcal D\to\mathcal T_{S/T}\to\mathcal D^{\otimes2}(\mathcal
P_R)\to0$ 里的第三项恰是 $\mathcal T/\mathcal D\cong\mathcal D^{\otimes2}(\mathcal P_R)$——**两个
定义在结构上精确匹配**（同一个秩 $0|1$ 子丛 $\mathcal D$，同一个"$\mathcal D^{\otimes2}$ 与
$\mathcal T/\mathcal D$ 之间的映射在穿孔处退化"的几何机制，只是 FKP 把它写成"映射 + 零点除子"，
Donagi–Ott 把它写成"扭转后的正合列"，这是同一件事的两种标准写法）。

**本尝试的判断**：这一项经补充核实后风险从"中"降为"低"，但仍未完成的是**逐字的函子级同构**
证明（即：给定一个 FKP 意义下的"$U$ 上的稳定超曲线族"，其限制到 Ramond 穿孔数据是否给出**恰好**
一个 Donagi–Ott 意义下的"$\mathfrak M_{g,0,2r}$ 的对象"，双向、functorial、且是同构而非仅仅
"看起来像同一个东西"）——这需要在两篇论文的形式化定义之间建立一个显式的模范畴等价，本尝试**没有
写出这个等价的构造**，只核实了"局部几何数据的定义在结构上匹配"这一层，标记为 `[GAP-DEF-R]`
（降级为低风险，未完全消除）。

**混合 NS+Ramond（命题 C 所需）**：`[GAP-DEF-MIX]`——风险等级从属于 Wang 论文本身的 physical-
argument 天花板（见下），且叠加上面两项的风险，未单独核实。

## §4 应用：推论 A / B / C

### 推论 A（NS 穿孔，紧化非投影）

**结合**：§1 引理 1.1（$U$ 非投影 ⟹ $\overline X$ 非投影）+ §3.1（$\overline{\mathfrak
S}_{g,n,0}$ 存在且光滑，$U=\mathfrak M_{g,n}$ 是其开子叠）+ 图节点
`math.supermoduli-space-not-projected`（Donagi–Witten Thm 1.2/1.3：$\mathfrak M_{g,n}$ 在给定
量词范围内非投影，**rigorous**）。

**结论**：对满足 DW Thm 1.2（$g\ge2,n=1$，偶自旋）或 Thm 1.3（$g\ge2,g-1\ge n\ge1$，量词见
`claim.md` §2）的一切 $(g,n)$：**$\overline{\mathfrak S}_{g,n,0}$ 非投影。**

**依赖的 `[GAP]`**：`[GAP-STACK]`（§2，低风险）、`[GAP-LIT]`（§3.1，程序性）、`[GAP-DEF-NS]`
（§3.2，低风险）。**没有依赖任何 conjecture/physical-argument 节点**——这条推论若三个 GAP 全部
补齐，effective status 应为 **rigorous**。

### 推论 B（Ramond 穿孔，紧化非投影）

**结合**：同上机制 + 图节点 `math.supermoduli-ramond-punctures-not-projected`（Donagi–Ott Thm 1：
$\mathfrak M_{g,0,2r}$ 在 $r>0, g\ge5r+1$ 时非投影，**rigorous**）。

**结论**：对一切 $r>0$，$g\ge5r+1$：**$\overline{\mathfrak S}_{g,0,2r}$ 非投影。**

**依赖的 `[GAP]`**：`[GAP-STACK]`（低风险）、`[GAP-LIT]`（程序性）、`[GAP-DEF-R]`（低风险，已
补充核实几何结构匹配，未完成函子级等价）。**同样不依赖任何 conjecture/physical-argument 节点。**

### 推论 C（混合 NS+Ramond 穿孔，紧化非投影）🔴

> 🔴 **本推论的种子节点 `math.supermoduli-ns-ramond-punctures-not-projected`（Wang）在图中
> effective status 是 `physical-argument`**（该论文自陈"preliminary draft"，其主证明 pp.4 起
> 本项目未读——见该图卡 notes）。**本推论继承这个天花板：无论 §1/§2 的搬运论证写得多严谨，推论 C
> 的 effective status 永远不能超过 `physical-argument`。** 这是"在一个物理论证之上叠加一层严格
> 的数学搬运"，不是把物理论证升级为严格证明——按图传播规则（`_combine_deps` 取依赖链的下界），
> 任何依赖 physical-argument 节点的结论自动被压到至多 physical-argument。

**结合**：同上机制 + 图节点 `math.supermoduli-ns-ramond-punctures-not-projected`（Wang：
$\mathfrak M_{g,n,2r}$ 在 $g\ge n+5r+3$ 时非投影，**physical-argument**）。

**结论（天花板 physical-argument）**：对一切 $g\ge n+5r+3$：**$\overline{\mathfrak
S}_{g,n,2r}$ 非投影。**（🔴 physical-argument 天花板）

## §5 三个已覆盖象限的机制解剖，及它们在"紧化+穿孔"同时出现时是否叠加/抵消/失效

任务书要求明确回答：Donagi–Witten 的障碍类机制、Corrêa–Noja 的紧化机制、Donagi–Ott 的穿孔机制，
在紧化与穿孔同时出现时，是**叠加**、**抵消**，还是**互不适用**？

- **Donagi–Witten（未紧化，NS 穿孔或无穿孔）**：机制是"分歧覆盖 + Green 障碍类的显式 Čech 计算"。
  这个机制**在紧化+穿孔情形下不直接适用**——它是对 $\mathfrak M_{g,n}$（未紧化对象）本身做的
  显式计算，不涉及任何边界几何。它对本尝试的角色是**"种子"**（推论 A 的输入），不是被搬运的机制
  本身。
- **Corrêa–Noja（紧化，无穿孔）**：机制是"椭圆尾粘接 + Donagi–Witten 一点障碍族 + Riemann–Roch
  维数计数（Theorem 7.2，要求 $h=g-1\ge2$）"，用来**降低**种子（DW 的 $g\ge5$）到 $g\ge3$。这个
  机制**原则上可以推广到带穿孔情形**（用带穿孔的一点障碍族做同样的粘接），但本尝试**没有做这个
  推广**——这正是能把命题 A/B 的门槛降到 DW/Donagi–Ott 门槛以下的唯一已知技术路线，标记为
  `[GAP-ELLIPTIC-TAIL]`，即最大的未解决的、真正"硬"的开放问题（见 §7）。
- **Donagi–Ott（未紧化，Ramond 穿孔）**：机制是"有限覆盖传播（Corollary 3）+ 子流形嵌入传播
  （Corollary 4）"，把 DW 的 $\mathfrak M_{2,1,0}$（$g=2,n=1$ 偶自旋种子）搬运到更高亏格/更多
  Ramond 穿孔的对象。这个机制与本尝试提出的"开子叠 étale 限制"机制是**同一方法论家族**（"取一个
  已知非投影的低复杂度对象作种子，用某种保持非投影性的函子性操作搬运"），但**搬运算子不同**（有限
  覆盖+嵌入 vs 开子叠限制）。**两者互不冲突、也不叠加**——它们是作用在不同"轴"上的搬运（Donagi–Ott
  沿"覆盖/嵌入"轴在**未紧化**范畴内部搬运；本尝试沿"紧化"轴把**已经搬运好的**结果再搬一次到紧化
  范畴）。**可以想象把两者复合**：先用 Donagi–Ott 的机制在未紧化范畴内把种子搬到更大的 $(g,r)$
  范围，再用本尝试的引理 1.1 把整个结果搬到紧化范畴——但这不会扩大覆盖范围（复合两个搬运不会让
  门槛降低，只是重复利用已经证明的未紧化结果），**不构成新的技术，本尝试不单独列为推论**。

**结论**：三个机制**互不适用**（各自作用的对象类型不同：DW 是纯计算，CN 的粘接是紧化专属技术，
Donagi–Ott 的覆盖/嵌入是未紧化专属技术），本尝试提出的"开子叠限制"是**第四个、独立的搬运机制**，
与三者都不冲突，可以和 Donagi–Ott 的机制**串联**（先搬运再紧化）但**不能**和 Corrêa–Noja 的
椭圆尾粘接机制"叠加"来突破种子门槛——**因为本尝试的机制的数学内容（层限制）与椭圆尾粘接（一个
具体的几何构造+维数计数）完全不同源，没有共同的"叠加"接口**；若要达到 CN-2026 式的"低于种子门槛"
的效果，必须真正重做一遍椭圆尾粘接技术的带穿孔版本，这是 §7 里明确标注的、留给未来工作的硬问题。

## §6 自检对照：把引理 1.1 应用到无穿孔情形，重现（弱于）Corrêa–Noja 自己的结果

**自检**：取 $n=0$（无 NS 穿孔），$r=0$（无 Ramond 穿孔），$U=\mathfrak M_g$（Donagi–Witten
Thm 1.1：$g\ge5$ 非投影，rigorous），$\overline X=\overline{\mathfrak S}_{g,0,0}$。引理 1.1 给出：
$\overline{\mathfrak S}_{g,0,0}$ 在 $g\ge5$ 非投影。

**与 Corrêa–Noja 自己结果的对照**：CN-2026 item(3)（`math.supermoduli-compactified-genus-geq3-
not-projected`）直接证明了 $\overline{\mathfrak S}_{g,0,0}=\overline{\mathfrak M}_g^\pm$ 在
**$g\ge3$**（比本尝试的方法能达到的 $g\ge5$ **更宽**）非投影，且证明**完全不引用**本尝试这条
平凡的开子叠限制引理（见该图卡 notes："g≥3 部分的证明完全不引用 FKP……"，其证明是椭圆尾粘接，
不是限制引理）。

**这个自检的意义**：它**证实了 §5 的判断**——引理 1.1 是一个真实有效、但**严格弱于**已知专门技术
（椭圆尾粘接）的工具，它只能达到"种子门槛"（这里是 $g\ge5$），达不到"种子门槛以下"的范围
（$g=3,4$）。这不是引理 1.1 有错误，而是**如实反映了这条方法的能力上限**——这正是任务书要求
"诚实报告困难"的地方：本尝试提出的机制，在能够与已知更强技术对照检验的场合（无穿孔情形），
被证实严格弱于人类已发表的最优结果。**对于带穿孔的情形（推论 A/B/C），目前没有任何已发表的"椭圆
尾粘接类比"技术存在**，所以引理 1.1 给出的门槛（DW/Donagi–Ott/Wang 各自的门槛）目前是带穿孔+
紧化情形下**已知的最好结果**（因为它是**唯一**存在的结果——见 `prior-art.md` 的零覆盖结论），
但本尝试如实承认：**如果有人后续把椭圆尾粘接技术推广到带穿孔情形，会得到比本尝试的推论 A/B 更强
（覆盖更低亏格）的结果，届时推论 A/B 会被超越，不是被推翻**（两者不矛盾，只是范围不同，如同
CN-2026 与 DW 未紧化结果的关系）。

## §7 完整 `[GAP]` 清单与方法的根本局限（不粉饰）

1. **`[GAP-STACK]`**（§2，风险：低）：超叠层面（而非裸超空间）的引理 1.1 推广，标准下降论证，
   本轮未逐条画出余循环相容性图表验证。
2. **`[GAP-LIT]`**（§3.1，风险：程序性，非数学）：FKP arXiv:2006.13271 未登记入
   `literature/sources.bib`，无 `literature/extractions/` 条目，需 lead 派 researcher 补做 L1
   抽取。本尝试的推论 A/B/C 在毕业前必须等这一步完成才能把 FKP Theorem A 当作"图内 rigorous 砖块"
   引用。
3. **`[GAP-DEF-NS]`**（§3.2，风险：低）：FKP 的 NS 穿孔与 Donagi–Witten 的 NS 穿孔（marked
   point）在概念层面几乎确定一致，但未经逐条定义对照的形式化核实。
4. **`[GAP-DEF-R]`**（§3.2，风险：低，已从"中"降级）：FKP 与 Donagi–Ott 的 Ramond 穿孔定义已
   核实在**几何结构层面**精确匹配（同一个秩 $0|1$ 子丛 $\mathcal D$、同一个退化机制），但缺少
   显式的**模范畴等价**证明（双向 functorial 同构）。
5. **`[GAP-DEF-MIX]`**（§3.2，风险：叠加 3+4，且天花板受 6 限制）：混合穿孔情形的定义比较未
   单独核实。
6. **Wang 种子的 physical-argument 天花板**（§4 推论 C，🔴 已标红）：不是本尝试能解决的问题
   ——除非有人把 Wang 的证明补充读完/独立复核到 rigorous 标准，推论 C 永远卡在 physical-argument。
7. **方法的根本局限（★★ 最重要的一条，不是技术缺口，是方法论的天花板）**：引理 1.1 只能把非
   投影性搬运到**种子已经覆盖的**亏格/穿孔数范围（§6 已用无穿孔情形自检证实：达到的是 DW 的
   $g\ge5$，不是 CN-2026 更强的 $g\ge3$）。**本尝试完全没有触及"紧化+穿孔情形下、低于 DW/Donagi–
   Ott 门槛的亏格范围"这个更难的问题**——那需要把 Corrêa–Noja 的椭圆尾粘接技术真正推广到带穿孔
   的一点/多点障碍族，这是一个**全新的几何构造**，不是本尝试这条"层限制"路线能免费获得的，标记为
   `[GAP-ELLIPTIC-TAIL]`，留给未来工作（可能是下一轮 prover 任务，或本尝试自己在后续轮次继续）。
8. **"分裂"方向完全未触及**：本方法只产出"非投影"结论；"是否存在某个特殊分量/情形使紧化+穿孔
   空间实际上是 split"（类比 CN-2026 item(1) 的 $g=2$ 奇分量）完全开放，本尝试未给出任何构造或
   否定性论证。

## §8 小结（诚实的一句话）

**本尝试证明了一条初等但此前未见文献显式写出的"紧化提升引理"（§1，rigorous、自包含证明），并把
它应用到 FKP 已经构造好的紧化带穿孔超叠上，得到两条新的、effective status 应为 rigorous 的推论
（A：NS 穿孔紧化非投影；B：Ramond 穿孔紧化非投影，各自匹配 DW/Donagi–Ott 原有的亏格门槛），以及
一条天花板被 Wang 的 physical-argument 状态锁死的推论（C：混合穿孔）。这条方法被自检（§6）证实
严格弱于已知的专门技术（椭圆尾粘接）在能够对照的场合的表现，因此推论 A/B 是"目前已知范围内唯一
存在的结果"而不是"最优结果"——真正把这个象限的边界推进到 CN-2026 式的更低亏格范围，需要一个
本尝试未能给出的新几何构造（`[GAP-ELLIPTIC-TAIL]`），这是留给后续工作的真正硬问题。**
