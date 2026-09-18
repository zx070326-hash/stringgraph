# Claim — 紧化 + 穿孔超模叠的可投影性（原创证明尝试）

**状态**：draft。本文件只写"要证的精确命题"，不含证明（证明见 `proof.md`）。

**Prior-art 前提**：本尝试基于 `prior-art.md` 记录的检索结论——"紧化 + 穿孔"象限在 2026-09-18
的检索范围内公开文献零覆盖。若后续发现反例，以 `prior-art.md` 的更新为准。

---

## §0 记号与已用图砖块（逐条列出 effective status）

以下节点均在 `graph/statements/math/`，本尝试**只作为已知砖块引用，不重新证明**：

| id | 断言（精简） | effective status（据既有推导文件） |
|---|---|---|
| `math.supermoduli-space-not-projected`（Donagi–Witten, Thm 1.2/1.3） | 𝔐_{g,1} 非投影 (g≥2, 偶自旋)；𝔐_{g,n} 非投影 (g≥2, g−1≥n≥1，奇g两自旋/偶g仅偶自旋) | **rigorous** |
| `math.supermoduli-ramond-punctures-not-projected`（Donagi–Ott, Thm 1） | 𝔐_{g,0,2r} 非投影 (r>0, g≥5r+1) | **rigorous** |
| `math.supermoduli-ns-ramond-punctures-not-projected`（Wang） | 𝔐_{g,n,2r} 非投影 (g≥n+5r+3) | **physical-argument**（原始文献自陈"preliminary draft"且主证明未读，见该节点 notes） |
| `math.supermoduli-genus-4-even-spin-not-projected`（Donagi–Noja） | 𝔐₄^+ 非投影 | rigorous（本尝试不需要它——见 §3 脚注） |
| `math.supermoduli-compactified-genus-geq3-not-projected`（Corrêa–Noja item 3） | 𝔐̄_g^± 非投影 (g≥3, 无穿孔) | rigorous（本尝试的"对照组"，见 §3） |

**★★ 红色标记（依据任务书要求，凡引用非 rigorous/formalized 节点必须标红）**：

> 🔴 **`math.supermoduli-ns-ramond-punctures-not-projected`（Wang）在图中的 status 是
> `physical-argument`，不是 `rigorous`。** 本尝试第 §2 部分「混合 NS+Ramond 穿孔」的推论，若使用
> Wang 的结果作为种子，其结论的 effective status 天花板**永远是 `physical-argument`**，无论本尝试
> 自己的搬运论证写得多严格——这是在一条物理论证之上叠加一层数学论证，**不是**把物理论证"升级"成了
> 严格证明。凡是下文出现"推论 C"的地方都必须携带这个红色标记，不得省略。

## §1 紧化对象的选取（必须先定，否则命题不成立）

**选取**：紧化 + 穿孔的超模叠取为

$$\overline{\mathfrak S}_{g,n_{\rm NS},n_{\rm R}}$$

即 Felder–Kazhdan–Polishchuk（下称 FKP-2020/23）在 arXiv:2006.13271（"The Moduli Space of Stable
Supercurves and Its Canonical Line Bundle", *Amer. J. Math.* **145** (2023) 1777–1886）Theorem A
构造的对象："There exists a smooth and proper DM-stack $\overline{\mathfrak S}_{g,n_{\rm NS},n_{\rm
R}}$ over $\mathbb C$ representing the functor of families of stable supercurves of genus $g$ with
$n_{\rm NS}$ NS punctures and $n_{\rm R}$ Ramond punctures."（本尝试直接读取该文 PDF pp.1–6 核实，见
`prior-art.md` 第 12 条。）

**为何是"唯一合理候选"，以及为何不是自动没有争议**：

- 这是目前公开文献里**唯一**存在的、同时容纳任意 $(n_{\rm NS}, n_{\rm R})$ 的紧化超模叠构造。
  Corrêa–Noja（下称 CN-2026）证明其无穿孔紧化非投影性结果时，用的紧化正是这篇文献的
  $n_{\rm NS}=n_{\rm R}=0$ 特例（他们参考文献 [9]/[10] 的其中一篇——见 `prior-art.md` 技术发现一节
  对两篇不同 FKP 论文的澄清：arXiv:2408.11136 证 projectedness，arXiv:2006.13271 只构造空间/证典范
  线丛，两者不是同一篇）。
- **[GAP-DEF]**：本尝试**没有**独立验证 FKP 的 $\overline{\mathfrak S}_{g,n_{\rm NS},n_{\rm R}}$
  在"去掉边界、限制到光滑轨迹"后，其光滑轨迹（FKP 自己 Definition 2.4(ii) 意义下的"纤维稠密开子集
  $U\subset X$ 使 $U/S$ 光滑"）作为**模函子**是否**逐字等同于**（不只是"同构于"，而是同一个模问题的
  同一个表示对象）Donagi–Witten 的 $\mathfrak M_{g,n}$（NS 穿孔）、Donagi–Ott 的
  $\mathfrak M_{g,0,2r}$（Ramond 穿孔）、Wang 的 $\mathfrak M_{g,n,2r}$（混合穿孔）。这四篇论文各自
  独立给出稳定超曲线/带穿孔超黎曼面的定义，虽然物理上明显意在描述同一个对象（标准弦论意义下的带
  NS/Ramond 穿孔超黎曼面模空间），但本尝试**未做逐条定义对照**（自同构群是否一致、稳定性条件是否
  逐字相同、Ramond 穿孔的"除子"定义是否与 Donagi–Ott/Wang 隐含使用的定义相同）。这是本尝试**最大的
  单一风险点**，见 `proof.md` §3 的详细讨论，标记为 `[GAP-DEF]` 贯穿全文。
- **[GAP-LIT]**：FKP arXiv:2006.13271 目前**不在** `literature/sources.bib`，也没有
  `literature/extractions/` 条目——按 `research/CLAUDE.md` 纪律，本尝试不能把它当作"图内 rigorous
  砖块"引用，只能当作"外部输入，待 lead 派 researcher 登记"。这不影响论证的数学有效性，但影响本尝试
  能否毕业进图（毕业前必须先补齐这块登记）。

## §2 主张的精确陈述（三条，分开处理 NS / Ramond / 混合）

### 命题 A（NS 穿孔，紧化）

对满足 Donagi–Witten Theorem 1.2 或 Theorem 1.3 量词条件的一切 $(g,n)$——即
$$\big[g\ge 2,\ n=1,\ \text{偶自旋结构}\big]\quad\text{或}\quad\big[g\ge2,\ g-1\ge n\ge1,\
\text{（奇 }g\text{ 两种自旋结构 / 偶 }g\text{ 仅偶自旋结构）}\big]$$
成立：**紧化的、仅带 $n$ 个 NS 穿孔（无 Ramond 穿孔）的超模叠
$\overline{\mathfrak S}_{g,n,0}$ 非投影。**

### 命题 B（Ramond 穿孔，紧化）

对一切 $r>0$、$g\ge 5r+1$ 成立：**紧化的、仅带 $2r$ 个 Ramond 穿孔（无 NS 穿孔）的超模叠
$\overline{\mathfrak S}_{g,0,2r}$ 非投影。**

### 命题 C（混合 NS+Ramond 穿孔，紧化）🔴 天花板 physical-argument

> 🔴 **本命题的种子（Wang）在图中是 `physical-argument`，本命题继承同样的天花板，永远不能靠本尝试
> 自己的论证升级为 rigorous。**

对一切 $g\ge n+5r+3$（$n\ge0, r\ge0$，Wang 原论文量词）成立：**紧化的、带 $n$ 个 NS 穿孔与 $2r$ 个
Ramond 穿孔的超模叠 $\overline{\mathfrak S}_{g,n,2r}$ 非投影。**

### 命题的否定/上界（本尝试明确不断言的内容，避免过度推广）

- 不断言任何 $g$ 低于上述门槛时的（非）投影性——见 `proof.md` §7 关于方法固有局限的讨论。
- 不断言"split"（分裂）方向的任何结果——本方法只产出"非投影"，见 §3 判断。
- 不断言混合穿孔情形在 $n=0$ 或 $r=0$ 退化时与命题 A/B 数值上的精确衔接（Wang 的界 $g\ge
  n+5r+3$ 在 $n=0$ 时是 $g\ge5r+3$，比 Donagi–Ott 的 $g\ge5r+1$ 更弱——这个比较已在图节点
  `math.supermoduli-ramond-punctures-not-projected` 的 notes 里记录，本尝试沿用，不重新比较）。

## §3 方向判断：为什么"非投影"是本尝试判断更可能真、且更可行的方向

**判断：非投影（命题 A/B/C 的形式），不是"投影"或"分裂"。**

**理由（在开始写证明之前的推理，不是事后包装）**：

1. **存在一个几乎免费的单向机制把非投影性从未紧化搬到紧化**——见 `proof.md` §2 的
   Compactification Lifting Lemma：若开子叠 $U\subset\overline X$（$\overline X$ 是 $U$ 的某个
   紧化）非投影，则 $\overline X$ 自动非投影。这个方向的论证是**初等的**（本质上是"结构层的分裂
   态射限制到开子集仍是分裂态射"这条平凡的层论事实），完全不需要新技术，而且它恰好是 Donagi–Witten
   自己在 Remark 1.4 里断言但未证明的那句话（"Asking for the compactification to be projected would
   only be a stronger condition"）的严格版本。
2. **没有任何已知机制指向相反方向**（即"紧化后反而变得可投影/可分裂"）。这在直觉上也不合理：紧化
   只会**增加**空间（添加退化边界），不会删除原来空间里已经存在的障碍——障碍类的不消没是一个"存在性"
   现象（某个上同调类非零），加更多点不会让已经非零的类变成零（这正是 Lifting Lemma 的内容）。要让
   紧化空间"变好"（可投影），需要一种全新的、目前文献中不存在的抵消机制，且已知的三个"讲紧化"或
   "讲穿孔"的正面结果（CN-2026 无穿孔紧化、Donagi–Ott/Wang 未紧化带穿孔）全部指向"非投影"这一个
   方向，没有一个例子显示"加维度会修复投影性"（唯一的"投影性变好"的例子是 CN-2026 item(1)：
   $g=2$ 奇分量紧化后是**split**——但这是一个特殊的、依赖对合作用在障碍层上的非平凡特征标的独立
   机制，不是"紧化本身导致变好"的一般现象；且它发生在无穿孔情形，与本命题的穿孔情形是否有类似的
   "特殊分量"完全开放，本尝试不断言）。
3. **"分裂"方向没有构造性路径**：要证明 $\overline{\mathfrak S}_{g,n,0}$（或带 Ramond 穿孔版本）
   是 split，需要展示一个显式的层同构或一个诱导消没机制（如 CN-2026 item(1) 的惯性特征标判据），
   这是**每个情形都要单独做的硬功夫**，没有通用搬运引理可用，本轮不具备条件去做。
4. 因此，"构造一个从已知非投影结果搬运到紧化+穿孔情形的引理，得到非投影结论"是**唯一在本轮时间/
   证据条件下可行的方向**，而且这个方向的证明本身几乎肯定是对的（唯一的风险点是 §1 的
   `[GAP-DEF]`——搬运引理本身的逻辑是初等且无懈可击的，真正的风险在于"我搬运的对象是否就是文献
   宣称非投影的那个对象"，这是一个**定义匹配问题**，不是一个**数学正确性问题**）。

## §4 与既有图卡的关系声明（不修订任何已有卡）

- 不修订 `math.supermoduli-space-not-projected` 红线 (4)（该卡明确声明不考虑紧化）——本尝试是
  在该卡的结论之上、朝紧化方向做的**新**搬运，不改变该卡对未紧化情形的断言。
- 不修订 CN-2026 三张紧化卡——它们处理无穿孔情形，本尝试处理带穿孔情形，是正交的补充，方法也不同
  （CN-2026 用椭圆尾粘接达到 $g\ge3$ 这个**低于**种子门槛的范围；本尝试的搬运引理**不能**达到这个
  效果，只能到种子本身的门槛——见 `proof.md` §7 的诚实对照）。
- 不修订 Donagi–Ott / Wang 两张未紧化带穿孔卡——本尝试把它们的结论**搬运**到紧化情形，不改变原卡
  本身的断言范围。
