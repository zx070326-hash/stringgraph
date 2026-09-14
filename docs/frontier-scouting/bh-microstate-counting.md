# 前沿侦察：黑洞微观态计数 / BPS 计数与模形式

> 侦察 sub（scout）起草，2026-09-14，独立 worktree。
> **本文件不是图数据**，不参与 `stringgraph validate`；不新建任何 graph/ 节点。
> 目的：为「黑洞微观态计数 + BPS 计数 + 模形式」这条物理前沿产出一份**靶子清单**，
> 供 lead 判断是否值得开图（cartography）、开 Lean 岛、或开 research/ 原创轨道。
>
> 标签纪律（硬要求）：⟨lit⟩ = 文献所述、⟨judgment⟩ = scout 评估、**待核** = 未逐字核实原文。
> 本轮只读到 arXiv 摘要 / 综述 / 二手转述，**未逐页核实任何原始论文**；所有定理编号一律待核。

---

## 0. TL;DR（给 lead 的一句话）

**最推荐的单一靶子：cartography（开图），把 DVV 1/Φ₁₀ 四分之一 BPS dyon 计数结果建成一张依赖子图，
其唯一高价值交付物 = 把「严格的模形式脊柱」与「物理的识别步」精确切开。**
一句理由：这条线的严格状态**在文献里就是含糊的**——模形式（Igusa 尖点形式、mock Jacobi 形式、DMZ 分解）是
货真价实的数学定理，而「这些傅里叶系数 = 物理 BPS 指标」「围道 = 壁穿越」「单心 = mock 部分」全是物理识别，
两者被文献混着讲——正是本项目第零层最擅长、且**不需要任何 Mathlib 里没有的东西**的活。
建议第一步：登记 DVV-1997、Sen-wall-crossing、DMZ-2012 三篇到 `literature/`，抽取 DVV 的核心陈述，
把「1/Φ₁₀ 系数 = 1/4-BPS 指标 B₆」这一个节点**正确地标成 physical-argument**（依赖 4d–5d 提升 + DVV 构造 + SUSY 非重整化）。

**诚实的坏消息（自我攻击，详见 §6）**：这条前沿是**极好的开图对象**，但是
(a) **近期极差的 Lean 形式化对象**——所有旗舰定理都建在 Mathlib **完全没有**的 Jacobi 形式 / Siegel 形式 /
mock 模形式 / 调和 Maass 形式基础设施上；(b) **拥挤的原创研究空间**——Bringmann、Murthy、Zagier、Sen、
Rosselló 等人 2012–2026 正在逐个关掉这里的开放数学问题（positivity 的 N=4 旗舰情形 2024 年刚被关掉）。
所以本条线的现实价值排序是：**开图 ≫ 长线 Lean 岛 ＞ research/ 原创**。

---

## 1. 判据回顾：什么算「合我们方法」

本项目真正的强项（从无鬼定理形式化看得最清楚）：**精确的表示论 / 态计数 + 模形式，做到机器可验证的严格（Lean）**；
外加在隔离的 research/ 轨道做纸面级原创证明。**不做实验、不做重数值。**
好靶子 = 能归约成「精确代数 / 计数 / 模形式的解析或形式化证明」的**脆**命题，满足：
(a) 地位高 / 被当已知，(b) 严格状态开放或含糊，(c) 可经精确计数·模形式·解析·Lean 攻，(d) 表述足够脆。

一个贯穿全文的 ⟨judgment⟩：本领域大多数**数学**命题（模形式的存在、分解、正性、Rademacher 收敛）
**要么已严格、要么正被数论专家关掉**；而大多数**物理**命题（指标 = 简并度、系数 = 态数、围道 = 壁穿越）
**本质上是物理识别，不是可形式化的数学定理**。因此本领域对我们最独特的价值在**第零层（图）**，
而不在 Lean 岛或原创证明。

---

## 2. 领域地图：一句话说清「脊柱 vs 识别」

一条典型论断（以 N=4 弦论 1/4-BPS dyon 为例）的锁链：

```
[物理] type II on K3×T²（或杂化 on T⁶）的 1/4-BPS dyon，带电荷 (Q,P)
   │  ← 识别①：D-brane / 4d–5d 提升 / DVV 构造  ★physical-argument
[数学] 其（第六螺旋超迹）指标 −B₆ = 某 Siegel 模形式倒数 1/Φ₁₀(ρ,σ,v) 的傅里叶系数
   │  ← 数学：Φ₁₀ = Igusa 权 10 尖点形式，Sp(4,ℤ) 下的严格对象  ✔rigorous(math)
[数学] 系数依赖积分围道；围道跨越 → 系数跳变 = Φ₁₀ 二阶极点的留数
   │  ← 数学：留数计算是严格复分析；留数因子化 = （电 1/2-BPS）×（磁 1/2-BPS）
   │  ← 识别②：围道选择 = 模空间中的壁穿越（Sen / Cheng–Verlinde / Denef–Moore）  ★physical-argument
[数学] 去掉多心（Appell–Lerch）部分后，单心 = mock Jacobi 形式的系数（DMZ 分解）
   │  ← 数学：亚纯 Jacobi 形式的典范分解，DMZ 2012 严格证明  ✔rigorous(math)
   │  ← 识别③：mock 部分 = 单心（immortal）黑洞简并度  ★physical-argument
[数学] 这些 mock Jacobi 系数为正（Sen positivity）
   │  ← 数学：Bringmann–Murthy 2012（一类）+ Rosselló 2024（N=4 1/4-BPS）严格证明  ✔rigorous(math)
   │  ← 识别④：正性 = 微观态是真实的正整数简并（且黑洞视界球对称 ⇒ 玻色）  ★physical-argument
```

**本项目的独特贡献就是把这条链上的 ✔ 与 ★ 分开、各自标状态、让工具算有效状态**——
文献里 ✔ 和 ★ 是混着写的（例如「1/Φ₁₀ counts the dyons」这句话里 counts 同时含了严格的模形式事实和 ★识别①）。

---

## 3. 三类命题清单（速览表）

| # | 命题 | 类别 | 关键出处（作者+年） | 备注 |
|---|---|---|---|---|
| R1 | Zwegers 给出 mock theta 函数的内在刻画（完成为调和 Maass 形式） | **已严格** | Zwegers 2002（thesis）⟨lit⟩ | 全领域数学基础 |
| R2 | 亚纯 Jacobi 形式的典范分解 = mock Jacobi（有限/mock 部）+ Appell–Lerch（极点部） | **已严格** | Dabholkar–Murthy–Zagier 2012 ⟨lit⟩ | Zagier 是作者之一；数学定理 |
| R3 | Sym^N(K3) 椭圆亏格的 DMVV 乘积公式（→ 1/Φ 型生成函数） | **已严格**（数学版） | 物理：DMVV 1997；数学证明：Borisov–Libgober 等 ⟨lit,待核⟩ | 物理起源，后被严格化 |
| R4 | K3 椭圆亏格 = 权 0 指标 1 弱 Jacobi 形式（拓扑不变量） | **已严格** | 经典；Kawai–Yamada–Yang 等 ⟨lit,待核⟩ | 纯几何 |
| R5 | Sen positivity（N=4 1/4-BPS 单心指标 > 0） | **已严格**（2024 关掉旗舰情形） | 猜想：Sen 2011；证明：Bringmann–Murthy 2012（一类）、Rosselló 2024（N=4 1/4-BPS）⟨lit⟩ | 见 §6 自我攻击 |
| R6 | 负权（向量值）模形式系数的 Rademacher 精确收敛展开 | **已严格** | Rademacher–Zuckerman 经典；mixed-mock：Ferrari–Reys 2017、Bringmann–Mahlburg ⟨lit,待核⟩ | 圆法 |
| P1 | 1/Φ₁₀ 的傅里叶系数 = 物理 1/4-BPS dyon 指标 −B₆ | **物理论证** | DVV 1997；Shih–Strominger–Yin、Sen ⟨lit⟩ | 识别①，本条线的枢纽 ★ |
| P2 | 积分围道选择 = 模空间壁穿越；系数跳变 = 半-BPS 简并度之积 | **物理论证**（留数部分严格） | Sen 2007；Cheng–Verlinde 2007；Denef–Moore 2007 ⟨lit⟩ | 识别②；留数因子化本身严格 |
| P3 | DMZ 的 mock（有限）部分 = 单心 immortal 黑洞简并度 | **物理论证** | DMZ 2012 ⟨lit⟩ | 识别③ |
| P4 | Strominger–Vafa：5d D1-D5 态计数 = Bekenstein–Hawking 面积熵 | **物理论证** | Strominger–Vafa 1996 ⟨lit⟩ | 靠 SUSY 指标保护 + 对偶 |
| P5 | 引力路径积分（超引力局域化）再现该指标 | **物理论证**（很新） | Iliesiu–Murthy–Turiaci 2022 及后续 ⟨lit⟩ | 非我们方法 |
| O1 | OSV 猜想 Z_BH = \|Z_top\|²（原始形式） | **真开放 / 原始形式疑似证伪** | Ooguri–Strominger–Vafa 2004；Denef–Moore「熵之谜」2007 ⟨lit⟩ | 见 §6，不建议 |
| O2 | positivity 在 CHL / twisted / 其它 N 的推广 | **真开放（正被专家做）** | Chandra 等 2025；2606.19479(2026) ⟨lit⟩ | 拥挤，不建议原创 |
| O3 | DMZ 分解中 mock 部分「无 Jacobi 尖点形式歧义」的唯一性（= 物理单心的精确刻画） | **含糊 / 部分开放** | DMZ 2012 只给「典范至多差一个尖点形式」⟨lit⟩ | 微妙，见候选 C |

---

## 4. 候选靶子（详）

### 候选 A —— ⭐首推：cartography 子图「1/4-BPS dyon 计数的严格脊柱 vs 物理识别」

- **精确陈述（要建的图，不是要证的定理）**：把 §2 那条锁链落成 graph/ 节点与推导边，
  每个 ✔ 标 rigorous（附数学来源）、每个 ★ 标 physical-argument（附 gaps 说明识别的物理内容），
  让 `stringgraph why` 能回答「Strominger–Vafa 型熵匹配到底压在哪几个 ★ 识别上」。
- **为何重要（物理地位）**：黑洞熵的微观解释是弦论**最被引用的成功**之一（⟨lit⟩ Strominger–Vafa 1996）。
  但「成功」二字混合了严格数学与物理识别；没人系统标注过其中哪几步是定理、哪几步是物理。
- **当前严格状态**：脊柱各节点见 §3 的 R2/R5/P1/P2；文献把它们混讲（⟨judgment⟩）。
- **关键文献**：DVV 1997（hep-th/9607026）；Sen wall-crossing（hep-th/0702141 及后续）；
  Denef–Moore 2007（hep-th/0702146）；DMZ 2012（arXiv:1208.4074）；Sen 综述、Murthy 综述 arXiv:2305.11732。
- **契合度 + 脆度 ⟨judgment⟩**：**契合度最高**——纯第零层，无需 Mathlib 缺失件；产出正是本项目招牌（「某结论建立在哪些猜想/物理论证之上」）。脆度：中——不是单一命题而是一张图，但每个节点本身足够脆、可查重、可回译。
- **分类**：**cartography（开图）**，不是形式化也不是原创。是 Phase-1 式的最低成本、最高信息密度动作。

### 候选 B —— DMZ 典范分解定理（长线 Lean 岛 / 或高价值 rigorous 卡）

- **精确陈述 ⟨lit,待核⟩**：整指标的亚纯 Jacobi 形式（SL(2,ℤ) 上）有一个**典范分解** = 一个 mock Jacobi 形式
  （「有限部 / mock 部」）+ 一个 Appell–Lerch 型和（「极点部」），且对每个正整数指标 m 存在一族权 2、指标 m 的
  特殊 mock Jacobi 形式，**在至多相差一个 Jacobi 尖点形式的意义下唯一**。
- **为何重要**：这是把「黑洞配分函数」与「mock 模形式」连起来的**数学定理**（Zagier 参与），
  下游几乎所有严格结果（正性、Rademacher）都用它；且它反过来生成了无穷多新 mock 模形式（含 Ramanujan 的 mock theta、
  Umbral moonshine）。⟨lit⟩
- **当前严格状态**：**已严格证明**（DMZ 2012，建立在 Zwegers 2002 上）。⟨lit⟩
- **契合度 + 脆度 ⟨judgment⟩**：概念上正中我们「模形式」靶心，命题脆（等式 + 唯一性）。
  **但 Lean 可行性近期极低**：Mathlib 有部分经典模形式，但**没有** Jacobi 形式、**没有** Siegel 形式、
  **没有** mock / 调和 Maass 形式、**没有** Appell–Lerch 和。形式化它 = 先造一整套基础设施，规模远超无鬼定理。
- **分类**：**形式化已发表结果**，但只能作**长线岛**，附诚实警告「前置 Mathlib 缺口巨大」。
  近期更现实的落地是：把它建成一张 **rigorous 陈述卡 + 严格数学来源**（不 Lean），作为候选 A 图的脊柱节点。

### 候选 C —— DMZ 分解唯一性 / 单心刻画的「Jacobi 尖点形式歧义」（微妙开放点）

- **精确陈述 ⟨lit,待核⟩**：DMZ 的典范分解只到「至多相差一个 Jacobi 尖点形式」；
  物理上「单心 = mock 部分」要求把这个歧义**唯一钉死**（靠某个增长/最优性条件）。
  「该歧义被物理条件唯一固定」这一步的严格地位含糊。
- **为何重要**：这正是 P3（识别③）能否升格为定理的关键；也是「单心黑洞 mock-modular 补全的存在唯一性」
  这个种子问题的精确化身。
- **当前严格状态**：存在性 + 至多差尖点形式 = 已严格（DMZ）；**完全唯一性 = 部分开放 / 依赖物理最优性条件**。⟨judgment，待核⟩
- **契合度 + 脆度 ⟨judgment⟩**：脆且数学味重，契合「模形式」。但**风险高**：很可能 DMZ / Bringmann–Murthy 的后续
  已经把这个唯一性条件讲清楚了（我未核实原文，**待核**）；若如此则非开放。**开 research/ 前必须先逐页核实 DMZ §（唯一性）。**
- **分类**：**若核实后确属开放** → research/ 原创；**否则** → 形式化 / rigorous 卡。**当前不建议贸然启动。**

### 候选 D —— Sen positivity（作为「刚被关掉的旗舰定理」的形式化 / rigorous 卡）

- **精确陈述 ⟨lit⟩**：N=4 弦论中构成单心黑洞的 1/4-BPS 态（immortal dyons）的指标 > 0
  ⟺ 某族显式 mock Jacobi 形式的傅里叶系数在相应 chamber 中为正。
- **为何重要**：Sen 猜想是本领域**头号脆命题**（一个符号！），地位极高，且把物理（视界球对称 ⇒ 玻色 ⇒ 指标正）
  精确翻成数论（显式系数的符号）。⟨lit⟩
- **当前严格状态**：Sen 2011 提出（物理）；Bringmann–Murthy 2012 证明**一类**（N=4、N=8，K3×T²/T⁶ 等，
  用 mock 模性 + 圆法估计）；**Rosselló 2024（arXiv:2403.19630）声称证明 N=4 1/4-BPS 单心（immortal）指标为正**，
  方法是 mock 模形式系数符号（rigorous math + 物理识别输入）。⟨lit⟩
- **契合度 + 脆度 ⟨judgment⟩**：**最脆**（符号命题），最高地位。但见 §6：**N=4 旗舰情形已被 2024 关掉**，
  原创空间没了；作为形式化对象又撞上候选 B 的同一 Mathlib 缺口（mock Jacobi + 圆法）。
- **分类**：**形式化已发表结果**（Bringmann–Murthy / Rosselló），长线岛；**不适合 research/ 原创**（已被证）。

### 候选 E —— 半-BPS 计数 1/η²⁴ 的 Rademacher 精确展开（最接近 Mathlib 的「脚趾」）

- **精确陈述 ⟨lit,待核⟩**：1/2-BPS「小黑洞」（Dabholkar–Harvey 态）的简并度 = 1/η(τ)²⁴（= 1/Δ）的傅里叶系数，
  且这些系数有一个**经典严格的 Rademacher–Zuckerman 精确收敛展开**（Bessel 函数级数）。
- **为何重要**：η²⁴ = 判别式 Δ 是**级 1** 模形式，是本领域里**唯一**离 Mathlib 现有模形式基础设施最近的对象。
  是「先钉一个真能 Lean 的脚趾」的诚实起点。
- **当前严格状态**：数学侧（1/Δ 系数的 Rademacher 展开）**经典严格**；识别为 1/2-BPS 简并度 = 物理（P4 类）。⟨lit,待核⟩
- **契合度 + 脆度 ⟨judgment⟩**：契合「精确计数 + 模形式」，脆（精确等式）。**Lean 可行性相对最高但仍不低**：
  需要圆法 / Kloosterman 和 / Bessel 渐近，Mathlib 目前也没有成套圆法。⟨judgment⟩
- **分类**：数学部分 = 形式化已发表结果（长线）；物理识别 = rigorous-脊柱之外的 physical-argument 卡。
  **可作为候选 A 图里一个特别干净的 rigorous 叶子**。

---

## 5. 建议的落地顺序（若 lead 采纳）

1. **（立刻，低成本）候选 A 开图**：登记 DVV-1997、Sen-wall-crossing、DMZ-2012、Strominger–Vafa-1996 到 `literature/`；
   派 curator 抽取 DVV 核心陈述，建 5–8 个节点，**把 P1（系数 = 指标）正确标 physical-argument**。产出即招牌图。
2. **（并行，rigorous 卡）候选 B / E 建成 rigorous 陈述卡**（不 Lean），作为 A 图脊柱，附「Mathlib 缺口」备注。
3. **（暂缓）候选 C**：先由 researcher 逐页核实 DMZ 的唯一性条款，确认是否真开放，再决定是否开 research/。
4. **（不做）候选 D 的原创、O1 OSV、O2 CHL 推广、P5 引力路径积分**：理由见 §6。

---

## 6. 自我攻击（明确的坏消息与不建议做的）

- ⟨judgment⟩ **整条前沿是差的近期 Lean 对象。** 所有旗舰定理（B/C/D）都建在 Mathlib **没有**的
  Jacobi 形式 / Siegel 形式 / mock 模形式 / 调和 Maass 形式 / 圆法之上。把它当第二个「无鬼式 Lean 岛」会低估工作量一个量级。
  无鬼定理能做，是因为 Virasoro / Fock 空间已在 Mathlib 射程内；这里的模形式基础设施**不在**。
- ⟨lit+judgment⟩ **positivity 的原创窗口基本关闭。** Sen 猜想的 N=4 1/4-BPS 旗舰情形 Rosselló 2024 已证；
  Bringmann–Murthy 2012 已覆盖一类。剩下的 O2（CHL / twisted / 其它 N）**正被同一批专家 2025–2026 高速推进**
  （Chandra 等 2025；2606.19479，2026-06）。我们在这里做原创 = 和 Bringmann/Murthy/Sen 抢时间，**不明智**。
- ⟨lit+judgment⟩ **OSV 猜想（O1）不要碰。** 原始形式 Z_BH=\|Z_top\|² 文献公认「schematic」，且 Denef–Moore「熵之谜」
  给出 N=2 下的疑似崩溃（多心熵 ~Λ³ 压过单心 ~Λ²），只能靠加测度因子 + 截断的 refined 版本救。
  它是对偶味的猜想（本项目 STATUS_LEVELS 把对偶默认压在 conjecture），且表述含糊、难以做脆——**双输**。
- ⟨lit+judgment⟩ **引力路径积分匹配（P5，Iliesiu–Murthy–Turiaci 2022 及后续）不是我们的方法。**
  它是超引力局域化 + 形式路径积分（作者自陈超引力非 UV 完备、积分先验无定义），既非精确代数计数也非可形式化数学。
- ⟨judgment⟩ **候选 C 的最大风险是「其实已被讲清楚」。** 单心 = mock 部分的唯一性很可能已在 DMZ 后续或
  Bringmann–Murthy 里被固定；未逐页核实前**不得**当成开放问题开 research/（违反根 CLAUDE.md「先确认真的无源可查」）。
- ⟨judgment⟩ **DMVV / 椭圆亏格（R3/R4）虽严格，但形式化前置（复流形椭圆亏格、Hilbert 概形 / 对称积）比 B 还远**，
  仅作地理标注，不列为靶。

---

## 7. 关键文献（作者 + 年 + 标识；均 ⟨lit⟩，正文级未核实处标待核）

- Strominger, Vafa 1996 — *Microscopic Origin of the Bekenstein-Hawking Entropy* — hep-th/9601029.
- Maldacena, Strominger, Witten (MSW) 1997 — *Black Hole Entropy in M-Theory* — hep-th/9711053（M5-brane / MSW CFT / 椭圆亏格）.
- Dijkgraaf, Verlinde, Verlinde (DVV) 1997 — *Counting Dyons in N=4 String Theory* — hep-th/9607026（1/Φ₁₀，Igusa 尖点形式）.
- Dijkgraaf, Moore, Verlinde, Verlinde (DMVV) 1997 — *Elliptic Genera of Symmetric Products and Second Quantized Strings* — hep-th/9608096.
- Dabholkar, Harvey 1989 — 1/2-BPS 计数 1/η²⁴（小黑洞）；Dabholkar 精确计数 hep-th/0409148（待核）.
- Ooguri, Strominger, Vafa (OSV) 2004 — *Black Hole Attractors and the Topological String* — hep-th/0405146.
- Sen 2007– — dyon 谱与壁穿越，如 hep-th/0702141；positivity 猜想 arXiv:1008.4209（Siegel 系数符号）.
- Denef, Moore 2007 — *Split States, Entropy Enigmas, Holes and Halos* — hep-th/0702146.
- Zwegers 2002 — PhD thesis（mock theta 的内在刻画）；arXiv:0807.4834.
- Bringmann, Murthy 2012 — *On the Positivity of Black Hole Degeneracies in String Theory* — arXiv:1208.3476.
- Dabholkar, Murthy, Zagier (DMZ) 2012 — *Quantum Black Holes, Wall Crossing, and Mock Modular Forms* — arXiv:1208.4074（151 页）.
- Ferrari, Reys 2017 — *Mixed Rademacher and BPS Black Holes* — （mixed-mock 圆法收敛，待核）.
- Rosselló 2024 — *The Immortal Dyon Index Is Positive* — arXiv:2403.19630（N=4 1/4-BPS 单心正性）.
- Iliesiu, Murthy, Turiaci 2022 — *Black Hole Microstate Counting from the Gravitational Path Integral* — arXiv:2209.13602.
- Murthy 2023 — 综述 *Black Holes and Modular Forms in String Theory* — arXiv:2305.11732.
- CHL / twisted positivity 推广：Chandra 等 2025（arXiv:2505.17182）；*Generating Function of single-centered Black Hole Index in CHL Models* arXiv:2606.19479（2026）.

> 免责：以上编号与年份取自 arXiv 摘要 / 综述 / 二手转述，**未逐页核实原文**；登记进 `literature/` 前须按
> `extract-paper` 流程逐条核对（尤其定理编号、Φ₁₀ 权与群、−B₆ 的螺旋阶数、Rosselló 证明是否含物理输入）。
