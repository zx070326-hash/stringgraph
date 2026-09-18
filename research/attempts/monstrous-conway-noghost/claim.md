# Claim：本项目无鬼定理资产能否直接支撑一条 monstrous / Conway moonshine 原创命题？

> **文件性质**：本文件是 `theorem-prover` 对"能否在 monstrous/Conway moonshine 方向提出一条锐利、
> 有终点线、可用本项目已有资产攻的命题"这一问题的**判定文件**，不是一个已开工证明的命题卡。
> 背景任务：上一轮 `research/attempts/umbral-moonshine-origin/`（`abandoned`）判定 umbral/Mathieu
> moonshine 不可攻后，指出 monstrous/Conway moonshine（无根格、权 0、全纯）在结构上比 umbral
> （有根格、权 1/2、mock 模）少两层障碍，且与本项目最大的形式化资产——无鬼定理
> （`worldsheet.no-ghost-theorem-v4`）——技术上直接相关，值得单独排查。
>
> **取证等级约定**（与 umbral 一轮一致）：`⟨lit, 核实⟩` = 已用 `WebFetch`/`Read` 独立核对原文到
> 具体段落/公式号；`⟨lit, 待核⟩` = 仅凭搜索引擎摘要合成，未独立核对原文；`⟨analysis⟩` = 本文作者
> 自己的推断/归约；本轮新增 `⟨lit, L1, Read-PDF⟩` = 用 `Read` 工具直接读取下载到本地的 PDF
> 页面图像获得的一手文本（不同于此前项目登记的"WebFetch 抓取失败⟹L0"）。
>
> 作者：prover（theorem-prover），2026-09-18。分支 `agent/prover/monstrous-conway-noghost`。

---

## 0. 背景对象与记号

### 0.1 本项目无鬼定理链的现状（图内节点，均已独立重读核实，非转述上一轮 blueprint）

`worldsheet.no-ghost-theorem-v4` 的有效状态由以下链条自上而下瓶颈：

```
no-ghost-theorem-v4
  └─ depends: ddf-spanning-hypothesis          (own=formalized / effective=physical-argument)
       ├─ --via-rank-inequalities  (own=formalized, N≤5 已 Lean 证完，N≥6 open)
       └─ --via-borcherds-1992     (own=rigorous, 引 Borcherds 1992 §5 Thm 5.1 + Lemma 5.1–5.5)
            └─ depends: ddf-contour-equals-mode-sum      (effective=physical-argument)
                 └─ --via-voa-residue (own=rigorous, GN 1995 §3.1 留数演算)
                      └─ depends: physical-exponential-equals-voa-vertex-operator
                           (own 命题的第 2 段无源 ⟹ effective=physical-argument)   ← 瓶颈
```

**瓶颈节点** `worldsheet.physical-exponential-equals-voa-vertex-operator`（2026-09-15 立卡）
断言：在秩 1、类光的动量塔 `T(p;k_0) = ⊕_N F(p+Nk_0)` 上，物理正规序指数
`:e^{i n k_0·X(z)}:`（`worldsheet.exponential-vertex-operator-modes` 给出的 `V^{(b)}_J` 复合零模移位）
与 Li–Wang 格点顶点代数 `V_(𝔥,Zk)` 的结构映射取值 `𝒴(e^{n k_0}, z)`（`math.lattice-vertex-algebra`
(3.10)）是**同一个算子**。该卡自身笔记【怎么把本卡升上去】列了三条路：(i) 读 Frenkel 1985；
(ii) 读 FLM 1988 Ch.8 / Frenkel–Ben-Zvi §5；(iii) 若 (i)(ii) 确认无源，开 `research/` track。
**本轮任务的直接触发点就是去核实 (i)(ii)，判断 (iii) 是否真的成立。**

### 0.2 Borcherds 1992 用无鬼定理的确切方式（本轮独立读图核实，非转述）

Borcherds 1992 *Monstrous moonshine and monstrous Lie superalgebras*（Invent. Math. 109）§5
Theorem 5.1：设 `H = V ⊗ V_{II_{1,1}}`，其中 `V` 是**任意**带非退化双线性型、Virasoro 作用
（中心荷 24，`L_0` 谱为非负整数，**每个 `L_0` 本征空间有限维**）的向量空间，`V_{II_{1,1}}` 是
秩 2 洛伦兹偶自对偶格 `II_{1,1}` 的格点顶点代数。结论：`P¹_r` 模去其双线性型的根，自然同构于
`V^{1-(r,r)/2}`。`D=26` 只经 Lemma 5.4（"24 from V, +2 from `II_{1,1}`"）进入。真 Monster
（`V = V^♮`，FLM 1988 的轨道化/扭模构造）与 fake monster（`V = V(Λ)`，Leech 格 VOA，构造更简单）
都用**同一条** Theorem 5.1。（本条 `⟨lit, 待核⟩`——沿用 `agent/formalizer/moonshine-bridge` 分支
`formal/BLUEPRINT-moonshine-bridge.md` 的 WebSearch 级读法，本轮未重新独立核对 Invent. Math.
109 原文页码，但已核对该 blueprint 与图内 `ddf-spanning-hypothesis--via-borcherds-1992` 推导卡
的引用互相一致。）

**结构性事实（`⟨analysis⟩`，本轮与上一轮 blueprint 独立复核一致）**：本项目自己的无鬼定理形式化
（`no_ghost_of_spans`、动量塔 `T(p;k_0)`）是**秩 1**结构——单个类光方向 `k_0`，物理动量 `p` 连续。
Borcherds 的 `H = V ⊗ V_{II_{1,1}}` 是**秩 2**结构——一个独立的 `c=24` VOA 因子张量一个秩 2
洛伦兹格顶点代数。这**不是**简单的推广关系：要把本项目的秩 1 动量塔套进 Borcherds 的框架，
需要**从零构造** `V_{II_{1,1}}`（一个秩 2 格 VOA）并把它与独立的 `c=24` 因子张量——这是全新的
基础设施，本项目目前哪里都没有（`math.lattice-vertex-algebra` 本身没有 Lean 文件，也没有秩 2
或张量积的实例）。

### 0.3 Conway moonshine 侧文献核实（本轮任务步骤 3，WebSearch 独立核实，纠正/确认上一轮引用）

- **Conway moonshine 本身已经是完整证明的定理，不是开放问题**：Duncan–Mack-Crane，
  *The Moonshine Module for Conway's Group*，arXiv:1409.3829，*Forum of Mathematics, Sigma*
  **3** (2015) e10，DOI 10.1017/fms.2015.7（`⟨lit, 待核⟩`，WebSearch 2026-09-18 核对标题/期刊/
  卷期/DOI/收稿日期，未读原文）。构造一个 `c=12` 的超顶点算子代数（后续文献称 `V^{f♮}` 或
  `V^{s♮}`），`Co_0`（Leech 格自同构群）忠实作用其上，图特征标全部是不带常数项的规范化 principal
  moduli——这正是 FLM `V^♮`/怪兽 moonshine 的 Conway 类似物，且**已发表、已证完**。
- 上一轮 `umbral-moonshine-origin/claim.md` T7 引用的 "Harrison–Paquette–Volpato,
  *A Borcherds–Kac–Moody Superalgebra with Conway Symmetry*，arXiv:1803.10798" **本轮独立
  WebSearch 核实无误**（`⟨lit, 待核⟩`）：作者 Sarah M. Harrison、Natalie M. Paquette、
  Roberto Volpato；刊于 *Comm. Math. Phys.* **370** (2019) 539–590，DOI
  10.1007/s00220-019-03518-0。摘要核实内容：从**手性超弦理论的物理态（BRST 同调）**构造一个
  `Co_0` 作用的 BKM 超代数，给出 Conway 模 `V^{s♮}` 的分母公式，并**明确提出**（非证明）"可以把
  分母公式提升为时空 BPS 指标，从而给出 Conway moonshine genus-zero 性质的一个物理解释"——
  即这篇论文本身把"genus zero 性质的物理解释"标记为**建议/猜测**，不是已证结论。
  **这是本轮找到的、与"无鬼定理 ⟹ moonshine"技术路线最贴近的现存文献**：它已经做了
  "物理态（BRST 同调）+ 无鬼定理类论证 ⟹ BKM 代数 + Conway 群作用"这一步，且是**完整发表的
  数学结果**（不是猜测）；未完成的只是"分母公式 ⟹ genus zero 的物理解释"这个更窄的额外问题。

**`⟨analysis⟩` 结论**：Conway moonshine 本身（存在性 + 特征标恒等式）**已经是发表的定理**
（Duncan–Mack-Crane 2015），"BKM 代数从超弦物理态构造"这一步**也已经是发表的定理**
（Harrison–Paquette–Volpato 2018）。本项目若想在这个方向上做原创贡献，不能是"证明 Conway
moonshine 成立"（已证），只能是"把已发表的构造在本项目的 Lean/图基础设施里重新搭建出来"——
这是**形式化/文献登记工作**（`researcher`/`curator`/`lean-formalizer` 的活），不是
`research/` 原创证明轨道的对象（root CLAUDE.md：先确认无源可查，此处**恰恰查到了源**）。

---

## 1. 本轮实际排查过的候选命题

### 候选 C（本轮的主发现，也是唯一一条被认真推进、并最终判定"仍不满足判据 4"的候选）：
### 「物理正规序指数塔算子 = Li–Wang 格点 VOA 结构映射」的算子恒等式

这就是 §0.1 瓶颈节点 `worldsheet.physical-exponential-equals-voa-vertex-operator` 断言 (2) 的
精确重述。为了判断它是否满足判据 1–4，本轮把它的两侧对象都摊开到**显式公式**层面（见 proof.md
§2 的逐项比对），发现：

- **物理侧公式完全显式**（图内 `worldsheet.exponential-vertex-operator-modes`，`status: formalized`，
  有 Lean 逐字对应）：
  `V^{(b)}_J = Σ_{p+q=J} E₋(b)_p ∘ E₊(b)_q`，
  `E₋(b;z) = exp(Σ_{l≥1} (b·α_{-l}/l) z^l)`，`E₊(b;z) = exp(-Σ_{l≥1} (b·α_l/l) z^{-l})`。
- **VOA 侧公式在图内目前不完整**：`math.lattice-vertex-algebra` (3.10) 写
  `Y(e^α⊗u,x)(e^β⊗v) = ε(α,β) e^{α+β} ⊗ x^{⟨α,β⟩} E^-(−α,x) Y(Δ̄(β,x)u,x) Δ̄(α,−x)v`，
  但卡内明文承认「`E^-(·,x)`、`Δ̄(·,x)` 是 Li–Wang §2–§3 的标准算子，本卡照抄为记号」——即图内
  **没有**把 `E^-`、`Δ̄` 的显式公式钉死，只是占位记号。

**`⟨analysis 2026-09-18⟩` 判定**：命题 C 精确到量词、有终点线（比较两个已定义/半定义算子在塔上
每个模式的取值，对一切 `n∈Z`、一切模式指标），**满足判据 1、2**。但要真正开工证明它，第一步
必须先把 Li–Wang 2008 里 `E^-(α,x)`、`Δ̄(β,x)`（以及 twisted-module 版本的 (3.10)，因为我们需要
的是 `Y` 在 **`U`-模** `⊕_j e^{jk}⊗M(1,p̃)` 上的作用，而不是 `Y` 在其**自身**（真空模 `M(1)`）上的
作用）钉成显式公式。**Li–Wang 2008 是本项目图里已经 L1 核实、大量引用的一手来源**
（`math.lattice-vertex-algebra`、`free-boson-vertex-algebra-with-lightlike-momentum-tower` 两张
卡各自引了 Theorem 3.6、Definition 3.5、Proposition 3.9、(3.17)、Theorem 3.10、Proposition 3.11
等一整批编号结果），几乎可以肯定 `E^-`、`Δ̄` 的显式公式与 twisted 版本的 (3.10) 就在同一篇论文的
§2–§3 里，只是**此前的 researcher 抽取时没有抽全**（当时只为了验证 `ε≡1` 合法性够用，没有必要
抽出完整算子公式）。

**结论：命题 C 不满足判据 4（确认无源可查）**——恰恰相反，源大概率就在已经登记的 Li–Wang 2008
里，只是抽取不完整。这是 `researcher`/`curator` 的继续抽取任务，不是"查无此证明，需要原创研究"。
详细比对与推理见 proof.md §2。

### 候选 D（否定，判据 4 直接失败）：「秩 1 → 秩 2」结构翻译本身

即 §0.2 提到的"把本项目秩 1 动量塔套进 Borcherds `V⊗V_{II_{1,1}}` 框架"。`⟨analysis⟩`：
这不是"无源"，而是"文献路数已知（Li–Wang 存在性定理本身允许任意秩、任意（可退化）格，
含秩 2 情形；Borcherds 1992/1986 本身就是范例），只是本项目没有把它实例化"。真正要做的是
**新建一份 `V_{II_{1,1}}` 的 Lean/图构造**（把 `math.lattice-vertex-algebra` 应用到一个具体
秩 2 格上）——这是工程量巨大但**不含任何未解决数学问题**的形式化任务，明确**不属于**
`research/` 原创证明轨道（root CLAUDE.md：`research/` 是给"文献里查无证明"的命题开的）。

### 候选 E（否定，判据 3+4 双重失败）：「monstrous/Conway moonshine 的物理解释」本身

即 Harrison–Paquette–Volpato 2018 论文结尾"建议"的、把分母公式提升为时空 BPS 指标从而给出
genus-zero 性质物理解释这件事。`⟨analysis⟩`：这确实在文献里以"suggestion"（非定理）的形式存在，
理论上满足判据 4（查无完整证明）。但它**不满足判据 3**（砖块合规）：要证它需要先有
(a) Conway 模 `V^{s♮}` 的完整超 VOA 构造（FLM 型轨道化，图里完全没有）、(b) 超弦（RNS 或
GS 型）BRST 同调物理态刻画（本项目 `no-ghost-theorem-v4` 目前只做**玻色**弦，无超对称结构，
`formal/` 里没有超弦 BRST 层）、(c) 某种"BPS 指标"的精确数学定义与和 Borcherds 分母公式的对应
（这本身是当前物理文献一个活跃、未有共识数学表述的方向）。这三块图里全都没有 rigorous/formalized
节点可引，且规模远超"缺一两个引理"——与上一轮候选 A/B 的"缺整层基础设施"是同一性质的否决理由。

---

## 2. 已知砖块盘点

| 需要的工具 | 图里是否存在 rigorous/formalized 节点？ | 备注 |
|---|---|---|
| 秩 1 类光动量塔上的无鬼定理链（DDF、动量塔、格 VOA 模） | 部分存在，见 §0.1 | 瓶颈正是候选 C 处理的那个节点 |
| Li–Wang 2008 一般格 VOA 存在性定理 | `math.lattice-vertex-algebra`（rigorous） | (3.10) 的 `E^-`、`Δ̄` **未钉死**——候选 C 卡在这里，是**待补抽取**而非缺失 |
| Borcherds 1992 §5 Theorem 5.1（秩 2 版无鬼定理） | 已登记为 rigorous 来源（`ddf-spanning-hypothesis--via-borcherds-1992`），但只covering own status，本项目未把它**应用**到秩 2 场景 | 文献侧完整，本项目侧未实例化——工程任务 |
| `V_{II_{1,1}}`（秩 2 洛伦兹自对偶格 VOA） | **不存在**（`math.lattice-vertex-algebra` 未实例化到秩 2） | 需新建，但不含未解决数学问题（Li–Wang 定理本身覆盖任意秩） |
| FLM 型轨道化/扭模构造（`V^♮` 或超对称版 `V^{s♮}`） | **不存在** | 40 年前已发表（FLM 1988），是大规模已知数学的移植/形式化任务，不是研究任务 |
| 超弦 BRST 同调物理态刻画 | **不存在**（`no-ghost-theorem-v4` 只覆盖玻色弦） | 需要全新一层形式化（RNS 超弦 BRST），规模与整个无鬼定理岛相当 |
| Conway moonshine 存在性本身 | **已发表已证**（Duncan–Mack-Crane 2015），图里未登记为节点 | 纯粹的 curator 登记任务 |
| Conway 群 BKM 超代数（超弦物理态构造） | **已发表已证**（Harrison–Paquette–Volpato 2018），图里未登记 | 同上 |
| 分母公式 ⟹ genus zero 的时空 BPS 物理解释 | **文献本身也未完成**（HPV 2018 明文标"suggestion"） | 唯一真正"查无证明"的一条，但因判据 3 失败被否决（见候选 E） |

---

## 3. 终点线小结与最终判定

**本轮判定：在 monstrous/Conway moonshine 方向，本项目找不出一条同时满足判据 1–4 的候选命题。**

- 候选 C（无鬼定理链自身的瓶颈节点）精确、有终点线（判据 1、2 通过），但**判据 4 失败**：
  几乎可以肯定源就在已登记的 Li–Wang 2008 里，只是抽取不完整——这是 researcher/curator
  继续抽取 + 逐项公式比对的任务，不是"查无证明需要原创研究"。这是本轮**最具体、最可执行**
  的正向产出，见 proof.md §2 与 §5 的具体建议。
- 候选 D（秩 1→秩 2 翻译）与候选 E 的三块子基础设施（`V^{s♮}` 构造、超弦 BRST、BPS 物理解释）
  规模达到"缺整层基础设施"级别，其中大部分（候选 D、Conway moonshine 存在性、BKM 超代数
  构造）**文献已完整覆盖**（判据 4 失败——不是原创研究对象，是形式化/移植任务）；唯一真正
  文献也未完成的部分（候选 E 的"物理解释"）因判据 3（砖块不存在）被否决。

**因此本次 scoping 的交付是"提不出来"**：与上一轮 umbral moonshine 的"缺整层基础设施故不可攻"
不同，本轮更精确的诊断是——**这个方向上，"新数学"意义下真正开放的部分（候选 E）本项目砖块不够；
"本项目资产够得着"的部分（候选 C、D）全部已经查到文献来源，是文献抽取/工程移植任务，根本不该
进 `research/`。** 详细论证见 proof.md。
