# 前沿侦察：Swampland 纲领 / 弱引力猜想 (WGC)

侦察 sub 报告，2026-09-14。目标：在 Swampland/WGC 领域里区分「已严格证明 / 物理论证 / 真开放或表述含糊」，
挑出**最适合本项目方法**的靶子。

**标签约定**：⟨lit⟩ = 有文献直接支撑；⟨judgment⟩ = 侦察员判断；⟨待核⟩ = 需进一步核实。
**严格度用本项目词表**（见 `docs/STATUS_LEVELS.md`）：formalized / rigorous / physical-argument / conjecture / speculation / refuted。

## 本项目方法的判据（用来打「合我们方法度」）

本项目真实强项：**精确代数 / 态计数 + 模形式 / 解析论证，做到机器可验证的严格（Lean）**；外加隔离的
`research/` 轨道做纸面级原创证明。**不做实验、不做重数值 / 大规模模拟**。
因此一个好靶子 = 能归约成「精确解析证明 / 正性不等式 / 有限步代数或变分计算」的**脆命题**——
陈述本身是一条可证伪的等式或不等式，而不是「对一堆例子测试看看成不成立」。

---

## 一句话结论（给 lead）

**最推荐单一靶子：Goon–Penco 极端性–熵普适关系** `∂_λ M_ext = −lim_{T→0} T ∂_λ S`（Goon–Penco 2019，
arXiv:1909.05254）。理由：它是 WGC「黑洞熵证明」这条线里**唯一真正严格、且本质是有限步热力学 / 微积分**
的命题——脆（一条精确等式）、地位高（它正是让 Cheung–Liu–Remmen 型「WGC 证明」成立的枢纽，也精确暴露出
WGC 结论**在哪里**变成有条件的：取决于 ΔS 的符号），且是**已发表结果的形式化**而非原创尝试，Lean 可及。
**建议第一步**：把这条关系写成陈述卡（status `rigorous`，来源 1909.05254），并单开一张「ΔS 符号命题」卡标
`conjecture`，让「WGC ⟸ 熵证明」这条边的猜想依赖显式化；随后评估在 `formal/` 里形式化其热力学恒等式核心。

---

## 领域地图：三层分类

### 层 A — 已严格 / 接近严格（数学定理或 EFT 内可证不等式）

| 命题 | 严格状态 | 关键文献 |
|---|---|---|
| Goon–Penco 极端性–熵关系（热力学恒等式） | **rigorous**（有限步热力学推导） | Goon–Penco 2019, 1909.05254 ⟨lit⟩ |
| 非引力 EFT 正性界（`a₂ > 0` 及双边界） | **rigorous**（在标准 S-矩阵公理下，Froissart 是定理） | Adams 等 2006, hep-th/0603249；Caron-Huot–Van Duong 2020, 2011.02957 ⟨lit⟩ |
| 距离猜想在 CY 复结构 / Kähler 模空间的指数塔（渐近 Hodge 理论） | **rigorous 岛**（Schmid / CKS 幂零轨道定理），但仅限有几何控制的模空间 | Grimm–Palti–Valenzuela 2018, 1802.08264；Grimm–Lanza–Li 2022 (tameness) ⟨lit⟩ |
| 量子引力无整体对称性（AdS/CFT 版） | 接近 rigorous（全息论证，比多数 swampland 猜想硬） | Harlow–Ooguri 2018, 1810.05338 ⟨lit⟩⟨待核精确度⟩ |

### 层 B — 有推导但不严格（physical-argument）

| 命题 | 为什么不严格 | 关键文献 |
|---|---|---|
| CLR「由黑洞熵证明 WGC」 | 只对**树级整出重场**的 UV 完成成立；依赖 ΔS>0（非普适，见层 C） | Cheung–Liu–Remmen 2018, 1801.08546 ⟨lit⟩ |
| 由因果性 / 幺正性推 WGC（振幅正性） | 引力下 t-道 graviton 极点破坏前向极限；需假设 Regge 行为 / 低自旋主导，**「引力正性界的严格推导仍缺失」**（作者自陈） | Hamada–Noumi–Shiu 2018, 1810.03637；Bellazzini–Lewandowski–Serra 2019, 1902.03250；Tokuda–Aoki–Hirano 2020, 2007.15009 ⟨lit⟩ |
| 磁 WGC 给出截断 Λ≲g·M_pl | 半经典单极子能量估计，非严格 | Arkani-Hamed–Motl–Nicolis–Vafa 2006, hep-th/0601001 ⟨lit⟩ |

### 层 C — 真开放 / 表述本身待厘清（不适合直接当定理攻）

| 命题 | 问题所在 |
|---|---|
| 温和形式 WGC（存在 q/m ≥ 1 的态） | 可被任意大电荷态平凡满足，**不约束低能 EFT**；作为「定理」几乎空洞 ⟨lit: AMNV 2006 自陈⟩ |
| 强形式 WGC（最轻 / 最小电荷态即超极端） | 已知**反例**（string 例子里破坏）；HRR 指出多数强变体有反例 ⟨lit: 1606.08437, 1712.01868⟩ |
| Tower / Sublattice / Lattice WGC | 「对已知例子成立」式陈述，**无一般证明**；Lattice 版已被 KK on 复杂流形证伪，故退化为 sublattice/tower ⟨lit⟩ |
| 凸包条件（多 U(1)） | 是 WGC 的**几何重述**，本身是定义 / 判据而非独立定理 |
| ΔS_ext 符号普适性（extremal 熵移符号恒正） | **状态未知**：零温 / extremal 处 ΔS 可为负（QED+gravity 例），符号依赖 Riemann² 系数 ⟨lit: 1912.11161, 2112.13433⟩ |
| de Sitter 猜想、种属尺度、AdS 距离猜想的 O(1) 常数取值 | 表述本身在文献中未定，靠拟合例子；不脆 |

---

## 候选靶子清单（含卡片）

### ★ 靶子 1：Goon–Penco 极端性–熵普适关系（**首推**）

- **精确陈述** ⟨lit, 待核精确形式⟩：设某微扰参数 λ（如高阶导算子系数）修正 GR。到 λ 的领头阶，
  **固定电荷下极端质量的移动 = 极端极限下 −(温度 × 熵移)**：
  `∂_λ M_ext(Q) = − lim_{T→0} T · (∂_λ S)|_{fixed extensive vars}`。
  推论：若 ΔS > 0 则 ΔM_ext < 0，即大黑洞可衰变到更小的超极端黑洞 ⟹ WGC 型行为。
- **物理地位**：是 CLR「熵证 WGC」这条线的**枢纽恒等式**；把「WGC 从熵得出」精确拆成
  「(A) 恒等式（严格）+ (B) ΔS>0（有条件）」。
- **严格状态**：**rigorous**。作者称推导是「纯热力学的，且适用于引力之外的系统」——即本质是关于配分函数 /
  Legendre 变换的有限步恒等式 ⟨lit: 1909.05254⟩。后续有推广（Cremonini 等 2019 在 AdS 复核了同一关系；2025
  EPJC 广义版）也有报告在特定黑膜 / GUP 情形下的失效边界 ⟨lit⟩。
- **关键文献**：Goon, Penco, PRL 124 (2020) 101103, arXiv:1909.05254（2019）。前置：Cheung–Liu–Remmen,
  JHEP 10 (2018) 004, arXiv:1801.08546。
- **合我们方法度 + 脆度** ⟨judgment⟩：**高 / 高**。恰好落在 `STATUS_LEVELS.md` 里「有限步初等计算（…有限维变分）
  经 reviewer 复核可标 rigorous」的档位；是一条精确等式，可证伪。Lean 形式化需先搭一个极小热力学框架
  （自由能、Legendre 变换、extremal 极限），中等工作量但自足，不碰 Hodge / 大分析。
- **形式化 vs 原创**：**形式化已发表结果**。

### ★ 靶子 2：非引力 EFT 正性界（`a₂>0` 与双边界）——最脆的「正性不等式」

- **精确陈述** ⟨lit⟩：对满足解析性、幺正性、多项式有界（Froissart / Jin–Martin）、交叉对称的 2→2 散射，
  低能 Wilson 系数 = UV 谱密度（非负）的加权积分 ⟹ 领头 s² 系数严格为正（Adams 等）；加交叉对称的
  null constraints ⟹ 所有系数**双边**有界（Caron-Huot–Van Duong 的 Bₖ sum rules / EFT-hedron）。
- **物理地位**：这是「由因果性 / 解析性严格推出的不等式」的**范式**，也是 WGC-正性联系的源头。
- **严格状态**：在标准公理 S-矩阵框架内 **rigorous**（对有质量隙理论，Froissart 界是定理；色散关系 + 幺正性给出正性）。
  **注意**：一旦加入无质量 graviton（引力 WGC），t-道极点破坏前向极限，严格性丧失（见层 B）。所以**严格的是非引力版**。
- **关键文献**：Adams–Arkani-Hamed–Dubovsky–Nicolis–Rattazzi, JHEP 10 (2006) 014, hep-th/0603249；
  Caron-Huot–Van Duong, JHEP 05 (2021) 280, arXiv:2011.02957；Arkani-Hamed–Huang–Huang「EFT-hedron」
  arXiv:2012.15849 ⟨lit⟩。
- **合我们方法度 + 脆度** ⟨judgment⟩：**中高 / 高**。是纯正性不等式，极脆；但完整形式化需要色散关系 / 复分析 / 分波幺正性，
  Mathlib 近期不具备，Lean 门槛高。更现实：先在图里登记为 `rigorous` 命题链，把「正性界 ⟹ WGC」那条边如实标
  `conjecture`（因为引力步不严格），日后形式化其**代数内核**（sum rule 的正加权 ⟹ 单个系数符号）。
- **形式化 vs 原创**：形式化已发表结果（代数内核可及；完整解析基础是长期）。

### ★ 靶子 3：距离猜想在 CY 模空间的指数塔（渐近 Hodge 理论）——最高数学含金量

- **精确陈述** ⟨lit⟩：CY 复结构（及大体积 Kähler）模空间中，**无穷远点 ⟺ 无穷阶单值性矩阵**；由幂零轨道定理，
  单值性生成 BPS 谱内一条无穷轨道，对应一塔态，其质量沿趋近该点**指数下降** `m ~ e^{−λ d}`。
- **物理地位**：Ooguri–Vafa 距离猜想在**有几何控制处**被翻译成 Hodge 结构退化的精确命题并证明——swampland 里
  少数真正「变成数学定理」的例子。
- **严格状态**：**rigorous 岛**。底座是经典代数几何定理（Schmid 的 SL(2)-轨道定理、Cattani–Kaplan–Schmid 混合
  Hodge 结构退化）。2022 起用 tame 几何 / o-minimality 处理路径依赖（Grimm–Lanza–Li）；2025 有对「几乎所有
  局部对称模空间」的证明（在若干谱 / 可紧化假设下）⟨lit, 待核 2025 论文号⟩。**全一般性仍是猜想**。
- **关键文献**：Ooguri–Vafa, Nucl.Phys.B766 (2007) 21, hep-th/0605264；Grimm–Palti–Valenzuela, JHEP 08 (2018)
  143, arXiv:1802.08264；Grimm–Li–Palti 1811.02571；Grimm–Lanza–Li「Tameness, Strings, and the Distance
  Conjecture」JHEP 09 (2022) 149 ⟨lit⟩。
- **合我们方法度 + 脆度** ⟨judgment⟩：**方法契合但工程量巨大 / 脆度中**。数学是解析 + 代数，正是我们喜欢的类型，
  但 Mathlib 无混合 Hodge 结构，近期无法 Lean 形式化。**可行的脆岛**：某个**单参数**极限（大复结构 / conifold）里，
  由局部幂零算子直接给出的指数质量估计，是自足的有限维线性代数 + 渐近估计，可作纸面级 `rigorous` 登记，甚至局部形式化。
- **形式化 vs 原创**：形式化已发表结果（选对单参数岛）。

### 备选：靶子 4：量子引力无整体对称性（AdS/CFT 版，Harlow–Ooguri）

- 地位极高、论证比多数 swampland 硬（全息 + 算子代数 / splittability）。⟨judgment⟩ 脆度中：陈述精确但证明依赖
  AdS/CFT 与算子代数假设；更接近 `physical-argument`/`rigorous` 边界。文献：Harlow–Ooguri arXiv:1810.05337（长文
  1810.05338）。若本项目想要一条「swampland 里最接近定理」的高地节点，值得单独侦察，但不如靶子 1 脆、不如靶子 1 易形式化。

---

## 诚实自我攻击（哪些别碰、哪些已被做过）

- **温和 WGC 当定理是空洞的** ⟨lit: AMNV 2006 自陈⟩：可被大电荷态平凡满足，证它没有认识论价值。真正有内容的是
  tower/sublattice/凸包等**强**版本——而这些**恰恰没有一般证明**，只对例子测试。别把「对例子成立」当成可攻的定理。
- **「A Weak Gravity Theorem」是个警示** ⟨lit⟩：Mirbabayi 2019（arXiv:1905.02736）标题就叫 Theorem，2 个月后
  **被作者自己撤稿**，因为其 UV 系数假设「只有在 g·M_pl~Λ 时才成立」，等于**默认了要证的结论（循环论证）**。
  教训：WGC 这类命题极易写出看似严格实则偷偷假设结论的「证明」；我们若攻，必须把每个 UV 假设摊在桌面上审。
- **CLR「证明」不是无条件证明** ⟨lit⟩：只对「树级整出重场」的 UV 完成成立，且**依赖 ΔS>0**。而 ΔS 在
  extremal/零温处可为负（Cremonini–Jones–Liu–McPeak 1912.11161；McPeak 2112.13433），符号依赖 Riemann² 系数。
  所以「熵证 WGC」= 严格恒等式（靶子 1）+ **符号猜想**（层 C），后者状态未知。别把整条链标成 rigorous。
- **引力正性界不严格** ⟨lit⟩：Tokuda–Aoki–Hirano 自陈「引力正性界的严格推导仍缺失」；graviton t-道极点 +
  低自旋主导 / Regge 行为都是**假设**。后续（如 2301.01999）给出假设失效的反例。所以严格的是**非引力**正性界（靶子 2）。
- **已被大量做过、别重复造轮子**：距离猜想的 Hodge 理论证明（Grimm 学派十年工作），正性界的 EFT-hedron/SDP 数值边界。
  我们的增量只能在：(i) 形式化其代数 / 热力学**内核**（Lean），或 (ii) 某个尚无人写出严格纸面证明的**具体脆岛**
  （需先按 `research/CLAUDE.md` 确认「查无此证明」再开 `research/` 轨道）。
- **de Sitter 猜想、种属尺度、各 O(1) 常数**：表述本身在文献里未定型，靠拟合例子，**不脆**，不适合本项目。

---

## 给 lead 的落地建议（优先级）

1. **靶子 1（Goon–Penco）**：最先动。登记 `rigorous` 陈述卡 + 单独的 `conjecture`「ΔS 符号」卡，边如实标注；
   评估 Lean 形式化其热力学恒等式内核（中等、自足）。
2. **靶子 2（非引力正性界）**：登记 `rigorous` 命题链；「⟹ WGC」边标 `conjecture`（引力步不严格）。
   长期形式化 sum-rule 正性内核。
3. **靶子 3（CY 距离塔）**：作为「高含金量长期岛」。先只登记大结构与文献，挑一个单参数极限做纸面 `rigorous`
   小岛，暂不进 Lean。

## 引用（作者 + 年 + 定位）

- Arkani-Hamed, Motl, Nicolis, Vafa, *The String Landscape, Black Holes and Gravity as the Weakest Force*, JHEP 06 (2007) 060, arXiv:hep-th/0601001（WGC 原始，2006）。
- Adams, Arkani-Hamed, Dubovsky, Nicolis, Rattazzi, *Causality, analyticity and an IR obstruction to UV completion*, JHEP 10 (2006) 014, arXiv:hep-th/0603249。
- Ooguri, Vafa, *On the Geometry of the String Landscape and the Swampland*, Nucl. Phys. B766 (2007) 21, arXiv:hep-th/0605264（距离猜想）。
- Cheung, Liu, Remmen, *Proof of the Weak Gravity Conjecture from Black Hole Entropy*, JHEP 10 (2018) 004, arXiv:1801.08546。
- Hamada, Noumi, Shiu, *Weak Gravity Conjecture from Unitarity and Causality*, PRL 123 (2019) 051601, arXiv:1810.03637。
- Bellazzini, Lewandowski, Serra, *Positivity of Amplitudes, Weak Gravity Conjecture, and Modified Gravity*, PRL 123 (2019) 251103, arXiv:1902.03250。
- Goon, Penco, *A Universal Relation Between Corrections to Entropy and Extremality*, PRL 124 (2020) 101103, arXiv:1909.05254。
- Caron-Huot, Van Duong, *Extremal Effective Field Theories*, JHEP 05 (2021) 280, arXiv:2011.02957。
- Arkani-Hamed, Huang, Huang, *The EFT-Hedron*, JHEP 05 (2021) 259, arXiv:2012.15849。
- Tokuda, Aoki, Hirano, *Gravitational positivity bounds*, JHEP 11 (2020) 054, arXiv:2007.15009。
- Heidenreich, Reece, Rudelius, *Evidence for a Sublattice Weak Gravity Conjecture*, JHEP 08 (2017) 025, arXiv:1606.08437。
- Heidenreich, Reece, Rudelius, *The WGC and Emergence from an UV Cutoff*, EPJC 78 (2018) 337, arXiv:1712.01868。
- Grimm, Palti, Valenzuela, *Infinite Distances in Field Space and Massless Towers of States*, JHEP 08 (2018) 143, arXiv:1802.08264。
- Grimm, Lanza, Li, *Tameness, Strings, and the Distance Conjecture*, JHEP 09 (2022) 149。
- Etheredge, Heidenreich, Kaya, Qiu, Rudelius, *Sharpening the Distance Conjecture in Diverse Dimensions*, JHEP 12 (2022) 114, arXiv:2206.04063（λ ≥ 1/√(d−2)，提出+证据，非一般证明）。
- Cremonini, Jones, Liu, McPeak, *Higher-Derivative Corrections to Entropy and the WGC in AdS*, arXiv:1912.11161；McPeak, *The Entropy Shift and Extremality Shift at Zero Temperature*, arXiv:2112.13433（ΔS 符号可负）。
- Harlow, Ooguri, *Symmetries in Quantum Field Theory and Quantum Gravity*, arXiv:1810.05338（无整体对称性）。
- Harlow, Heidenreich, Reece, Rudelius, *The Weak Gravity Conjecture: A Review*, Rev. Mod. Phys. 95 (2023) 035003, arXiv:2201.08380（综述，各定义汇总）。
- ⟨待核⟩ Mirbabayi, *A Weak Gravity Theorem*, arXiv:1905.02736（**已撤稿**，循环论证，作警示用）。
- ⟨待核⟩ *A Proof of the WGC via Leading-Order Quantum Gravity Effects*, arXiv:2503.08459（近期新证明尝试，未核实内容）。
