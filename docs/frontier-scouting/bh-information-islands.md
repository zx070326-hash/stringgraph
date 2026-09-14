# 前沿侦察：黑洞信息佯谬 / Page 曲线 / 岛屿公式

> 侦察 sub 产出。目标：为一条「物理前沿·高含金量」研究线做领域侦察，判断哪些命题**脆到可以纯解析地严格证明或 Lean 形式化**，哪些仍是物理论证、短期内不可严格化。
> 本文件**不是图节点**，不改 `graph/`，不标任何东西为 formalized。所有严格性判断以本项目 `docs/STATUS_LEVELS.md` 的等级（formalized / rigorous / physical-argument / conjecture / speculation）为准绳。
>
> **诚实标签**：⟨lit⟩ = 有文献直接支撑；⟨judgment⟩ = 侦察员判断；⟨待核⟩ = arXiv 号/年份/细节需再核。侦察员**不做实验、不做重数值**，判断偏保守。

---

## 0. 一句话结论（给 lead）

这个领域**极热、拥挤、动得快**，绝大多数「岛屿/Page 曲线」结果是**物理论证**（gravitational path integral 鞍点 + replica trick + n→1 解析延拓），不在短期严格化射程内，且容易被抢。**唯一真正脆、地位高、且落在本项目机器可验证强项里的靶子，是 Page 的「随机纯态子系统平均熵」定理**——它是整个叙事的信息论骨架，1994–1996 已被严格证明，却（据侦察员所知⟨judgment⟩）从未进过证明助手。次一级的、更有原创空间的脆靶子是 **PSSY end-of-the-world brane 模型里 planar resolvent → 纠缠谱 → Page 曲线** 这条纯随机矩阵计算的严格化。

---

## 1. 领域地形图：什么严格、什么不严格

把这个领域按本项目状态等级切开，是理解「哪里能下手」的关键。核心事实：**「岛屿公式重现 Page 曲线」这件事作为物理结论已被广泛接受，但支撑它的每一块砖的严格程度差别极大。**

### Tier A — 已严格证明的数学定理（`rigorous`，个别可 `formalized`）

这些是纯数学命题，数学界接受完整证明，与「引力路径积分」无关，是整条链上**唯一不脆但可形式化**的部分。

| 命题 | 谁/何时/如何 | 严格状态 |
|---|---|---|
| **Page 平均熵定理**：Hilbert 空间维数 `mn` 的随机纯态（Haar 测度），维数 `m ≤ n` 的子系统平均 von Neumann 熵 `S_{m,n} = Σ_{k=n+1}^{mn} 1/k − (m−1)/2n` | Page 1993 猜想；Foong–Kanno 1994 首证（PRL 72,1148）；Sánchez-Ruiz 1995 简化证明（PRE 52,5653，经 Laguerre 系综一点关联函数）；Sen 1996（PRL 77,1，hep-th/9601132） | `rigorous`，且**可 `formalized`**⟨judgment⟩ |
| **Weil–Petersson 体积的 Mirzakhani 递归**：带边双曲曲面 moduli 空间 WP 体积满足递归 | Mirzakhani 2007（Invent. Math. 167:179，"Simple geodesics…"） | `rigorous`（重型微分几何） |
| **Mirzakhani 递归 = Eynard–Orantin topological recursion**（对某谱曲线的矩阵模型 loop equations） | Eynard–Orantin 2007（arXiv:0705.3600） | `rigorous`（数学物理） |

⟨judgment⟩ 备注：Tier A 是「地位高 + 严格已闭」，所以它们**不是原创研究靶子，而是形式化靶子**。其中只有 Page 定理体量适中（有限维/RMT，Mathlib 有 Haar 测度、矩阵、调和数的基础设施）；WP 体积那条虽严格，但形式化成本极高（moduli 空间、双曲几何），不建议近期碰。

### Tier B — 物理论证（`physical-argument`）：有推导、不严格

这是本领域的**主体**。都有清楚的推导，但依赖引力路径积分（未定义对象）、鞍点主导性、以及 replica index 的解析延拓。按本项目规则一律 `physical-argument`（部分环节甚至 `conjecture`）。

| 命题 | 关键文献 | 为什么不 rigorous |
|---|---|---|
| **RT 公式**（全息纠缠熵 = 极小曲面面积） | Ryu–Takayanagi 2006（PRL 96,181602，hep-th/0603001）⟨待核年份/号⟩ | 原为 conjecture |
| **HRT**（协变/洛伦兹版极值曲面） | Hubeny–Rangamani–Takayanagi 2007（JHEP 0707:062，arXiv:0705.0016）⟨待核⟩ | conjecture |
| **Lewkowycz–Maldacena：RT 的 replica 推导** | LM 2013（arXiv:1304.4926，JHEP 08(2013)090） | 依赖 bulk replica 对称性、光滑性、n→1 解析延拓；作者自承洛伦兹无明显欧氏延拓⟨lit⟩ |
| **FLM：RT 的一圈量子修正** `S = A/4G + S_bulk` | Faulkner–Lewkowycz–Maldacena 2013（arXiv:1307.2892，JHEP 11(2013)074） | 一圈、形式操作 |
| **QES 处方**（极值化广义熵） | Engelhardt–Wall 2014（arXiv:1408.3203，JHEP 01(2015)073） | 处方，超一圈与 FLM 分歧 |
| **岛屿公式 / QES 在蒸发黑洞里出现** | Almheiri–Engelhardt–Marolf–Maxfield 2019（arXiv:1905.08762）；Penington 2019（arXiv:1905.08255⟨待核⟩） | 半经典 QES 推理，初版假设幺正性⟨lit⟩ |
| **Replica wormhole 从引力路径积分导出岛屿公式** | PSSY 2019（arXiv:1911.11977，JHEP 03(2022)205，"West Coast"）；Almheiri–Hartman–Maldacena–Shaghoulian–Tajdini 2019（arXiv:1911.12333，JHEP 05(2020)013，"East Coast"） | 见 Tier C：鞍点存在性、主导性、n→1 延拓都不严格 |
| **JT gravity = 双标度矩阵积分** | Saad–Shenker–Stanford 2019（arXiv:1903.11115）；Stanford–Witten 2019（arXiv:1907.03363⟨待核⟩） | 物理**对偶**（数学核心是 Tier A 的 Mirzakhani/EO），全 genus 求和是渐近级数、非微扰完备化非唯一⟨lit⟩ |

⟨judgment⟩ 综述：AHMST 的 Rev. Mod. Phys. 93,035002（arXiv:2006.06872）是权威综述，明确把这套叫「fine-grained gravitational entropy」方法，语气是「过去 15 年发展出的计算技术」，不是定理。

### Tier C — 真开放 / 表述待厘清（`conjecture` 或更低）

这些是 Tier B 推导里**公认未闭**的缝，也是「哪里其实还没严格化」的诚实清单：

1. **Replica index n 的解析延拓**：从整数 n 延拓到 n→1 一般**非唯一**；文献里靠 Carlson 定理、矩方法或「自然延拓」的希望来兜底，但综述自承「一旦用了 replica trick，目标严格度往往就降了」⟨lit⟩。JT 里已知不同延拓定性一致、定量不一致，且「自然延拓」给出复自由能、需 ad hoc 修正⟨lit⟩。
2. **有限 n 的 replica wormhole 鞍点是否存在、是否主导**：仍在用 simplicial gravity 等手段数值探查⟨lit⟩（arXiv:2504.18663）。洛伦兹路径积分里它们必须是复的。
3. **引力路径积分 = 系综平均 vs 单一理论 / factorization puzzle**：wormhole 给出 `⟨Z_L Z_R⟩ ≠ ⟨Z_L⟩⟨Z_R⟩`；Marolf–Maxfield 2020（arXiv:2002.08950⟨待核⟩）证明「带 wormhole 的引力 → 系综」在 2d 玩具模型里很一般；half-wormhole 试图恢复 factorization。高维「要平均什么」仍无共识⟨lit⟩。这是概念性开放问题，**不脆、不建议**。

---

## 2. 候选靶子清单（按合我们方法度排序）

对每个给：精确陈述 / 物理地位 / 当前严格状态（引文）/ 关键文献 / 合我们方法度 + 脆度 / 形式化 vs research。

### ★ 靶子 1（首推）：Page 平均子系统熵定理 —— 形式化

- **精确陈述**：设复合系统 Hilbert 空间维数 `d = mn`，态为 Haar 随机纯态，取维数 `m ≤ n` 的子系统 A，其约化密度矩阵 `ρ_A` 的期望 von Neumann 熵为
  `⟨S(ρ_A)⟩ = Σ_{k=n+1}^{mn} 1/k − (m−1)/(2n) = H_{mn} − H_n − (m−1)/(2n)`（H = 调和数，单位 nat）。渐近 `≈ ln m − m/(2n)`（`1 ≪ m ≤ n`）。
- **物理地位**：整个 Page 曲线叙事的**信息论骨架**——「随机纯态的小子系统近乎最大混合」正是「central dogma」与「蒸发到 Page 时间后辐射熵开始下降」的定量根据。地位极高、被无数次引用。
- **当前严格状态**：`rigorous`（已闭）。Page 1993 猜想（PRL 71,1291）；Foong–Kanno 1994 首证；Sánchez-Ruiz 1995 用 Laguerre 系综简化；Sen 1996 独立证明。⟨lit⟩
- **关键文献**：Page 1993；Foong–Kanno 1994；Sánchez-Ruiz 1995；Sen 1996。
- **合我们方法度 + 脆度**：合度**极高**——纯 RMT/线性代数/组合，有限维，无路径积分。**脆度**：严格性已闭（不是「开放」），所以它不是「抢首证」，而是「首个形式化」。⟨judgment⟩ 侦察员未发现它已有 Lean/Isabelle/Coq 形式化（⟨待核⟩：应查 Mathlib、archive of formal proofs）。价值在于：它是本领域唯一**既地位高又落在项目 formalized 强项**的命题，可作为「信息佯谬子图」的第一块 formalized 岛，且回报确定。
- **形式化 vs research**：**形式化**。建议 Lean。需要的 Mathlib 组件：Haar 测度/酉群积分（或等价地对 Ginibre/复高斯矩阵积分）、调和数、`log`、矩阵迹。潜在难点⟨judgment⟩：von Neumann 熵对随机矩阵谱的期望需要 Laguerre/Marchenko–Pastur 型积分——Mathlib 现有 RMT 基础可能不足，需先估工作量。**先做可行性侦察，不要盲目立项。**

### ★ 靶子 2（次推，最有原创空间）：PSSY EOW-brane 模型 planar resolvent → 纠缠谱 → Page 曲线

- **精确陈述**：在 JT gravity + `k` 味 end-of-the-world brane（与辅助辐射系统 R 最大纠缠）模型里，辐射约化密度矩阵 `ρ_R` 的 resolvent `R(λ)` 满足一条 Schwinger–Dyson 方程（planar/genus-0 近似下**精确**）；解出 `R(λ)` 取虚部得本征值密度 `D(λ)`；由 `D(λ)` 积分得 `S(ρ_R)` 随 `k`（∝ 时间）先升后降，重现 Page 曲线；Page 时间对应两个鞍点/两支谱交换主导。
- **物理地位**：PSSY 是「replica wormhole 重现 Page 曲线」最精确、最可算的玩具模型（「West Coast model」），地位很高。
- **当前严格状态**：`physical-argument`。resolvent SD 方程「exact in the planar approximation」——但 (a)「planar 近似」本身是近似（略去 `e^{-S_0}` 压低的非平面项），(b) SD 方程与引力几何的对应是物理的。⟨lit⟩
- **关键文献**：PSSY 2019（arXiv:1911.11977，resolvent/SD 机器）；Gao–Jafferis–Kolchmeyer 2021（arXiv:2104.01184，有效矩阵模型）；Okuyama–Sakai 2021（arXiv:2111.09551，从矩阵模型直接构造纠缠熵并看到相变）；Dong 2016（arXiv:1601.06788，cosmic brane / gravitational Rényi）。
- **合我们方法度 + 脆度**：合度**较高**——把「planar resolvent SD 方程 → 本征值密度 → 熵」重述为一个**关于具体随机矩阵/随机张量系综的纯 RMT 命题**（去掉引力解释），就是可解析严格化的对象。脆度：**中高**。这里的脆点是「把物理里的 planar 计算，改写成一个 well-defined 系综上的极限定理并严格证明」。⟨judgment⟩ 风险：这类 RMT 陈述可能已被随机张量网络文献（Hayden–Nezami–Qi–Thomas–Walter–Yang 等⟨待核⟩）以定理形式部分覆盖——**立项前必须查重**，否则是重复造轮子。
- **形式化 vs research**：**research/（纸面级原创严格化）优先**，成功后再考虑形式化其 RMT 内核。这是「岛」而非「记账」的方向：目标是把某个可解模型里的 Page 曲线**作为严格 RMT 定理**陈述并证明。

### 靶子 3（观望）：JT = 矩阵积分的数学内核形式化

- **精确陈述**：JT gravity 的 genus 展开配分函数 = WP 体积的积分变换 = 某谱曲线 `y = sin(2π√x)/(4π)`⟨待核⟩ 的 Hermitian 矩阵模型 topological recursion。
- **物理地位 / 严格状态**：物理对偶 = `physical-argument`；**数学内核**（Mirzakhani 递归 = EO topological recursion）= `rigorous`（Tier A）。
- **合度 + 脆度**：内核已严格，形式化体量**巨大**（moduli 空间、双曲几何、拓扑递归），远超无鬼定理岛。**不推荐近期**。⟨judgment⟩
- **形式化 vs research**：远期形式化候选，非当前。

### 靶子 4（不推荐做严格化，仅登记）：岛屿公式 / QES 从 replica 的严格推导

- **精确陈述**：从引力欧氏路径积分（含 replica wormhole 拓扑求和 + n→1 延拓）严格导出岛屿公式 `S(R) = min ext_I [Area(∂I)/4G + S_QFT(I∪R)]`。
- **地位**：本领域皇冠，地位最高。
- **严格状态**：`physical-argument`，缝在 Tier C（n 延拓非唯一、有限 n 鞍点存在性/主导性、复度规）。⟨lit⟩
- **合度 + 脆度**：脆度看似高，**但严格化难度极大且不属于「代数/态计数」射程**（是硬分析 + 路径积分定义问题），且**极度拥挤、动得快、最容易被抢**。⟨judgment⟩ 诚实结论：**不适合本项目短期攻坚**；只宜作为图节点如实标 `physical-argument` 并记录 Tier C 缝。

---

## 3. 自我攻击（诚实指出风险）

- **拥挤与被抢**：靶子 4（岛屿公式严格推导）、Tier C 的所有条目是全球数十个组在做的热点，本项目无速度优势，**不要碰首证竞赛**。
- **「其实是物理论证」**：靶子 2 的「exact in planar approximation」这句里的 *approximation* 是关键——若不把它重铸成一个 well-defined 系综的极限定理，就仍是物理论证，形式化无从谈起。
- **查重是硬前提**：
  - 靶子 1：Page 定理**可能已被形式化**（⟨待核⟩ Mathlib / AFP / Lean Zulip）。若已有，价值大减，改为「引用/接线」而非「首形式化」。
  - 靶子 2：随机张量网络的 Page 曲线**可能已有 RMT 定理版本**（⟨待核⟩ HNQTWW 等）。若已有严格版，则本项目应做的是「整理+接线」而非 research/ 原创。
- **成本未估**：靶子 1 的形式化难点在「随机矩阵谱期望的积分」是否在 Mathlib 射程内；下手前必须做一次**可行性侦察**（估 Mathlib 缺口），否则可能陷入自建大量 RMT 基础设施。
- **约定风险**（项目原则 6）：任何涉公式的节点需声明 `G_N` 归一化、2d 里「Area」= dilaton 值、熵单位（nat vs bit）、度规号差。Page 定理这一支是纯量子信息、约定负担最小，也是它适合作为第一块砖的另一个理由。

---

## 4. 关键文献一览（作者 + 年份 + arXiv）

- Page 1993, PRL 71,1291（average subsystem entropy，猜想）
- Foong–Kanno 1994, PRL 72,1148（首证）
- Sánchez-Ruiz 1995, PRE 52,5653（简化证明）
- Sen 1996, PRL 77,1（hep-th/9601132）
- Ryu–Takayanagi 2006, PRL 96,181602（hep-th/0603001）⟨待核⟩
- Hubeny–Rangamani–Takayanagi 2007, JHEP 0707:062（arXiv:0705.0016，HRT）⟨待核⟩
- Mirzakhani 2007, Invent. Math. 167:179（WP 体积递归）
- Eynard–Orantin 2007, arXiv:0705.3600（Mirzakhani = topological recursion）
- Lewkowycz–Maldacena 2013, arXiv:1304.4926（generalized gravitational entropy）
- Faulkner–Lewkowycz–Maldacena 2013, arXiv:1307.2892（RT 一圈修正）
- Engelhardt–Wall 2014, arXiv:1408.3203（QES）
- Dong 2016, arXiv:1601.06788（gravity dual of Rényi entropy / cosmic brane）
- Saad–Shenker–Stanford 2019, arXiv:1903.11115（JT as matrix integral）
- Stanford–Witten 2019, arXiv:1907.03363（JT and RMT ensembles）⟨待核⟩
- Almheiri–Engelhardt–Marolf–Maxfield 2019, arXiv:1905.08762（岛屿 / QES 蒸发黑洞）
- Penington 2019, arXiv:1905.08255（entanglement wedge reconstruction）⟨待核⟩
- PSSY 2019, arXiv:1911.11977, JHEP 03(2022)205（replica wormholes, West Coast）
- Almheiri–Hartman–Maldacena–Shaghoulian–Tajdini 2019, arXiv:1911.12333, JHEP 05(2020)013（replica wormholes, East Coast）
- Marolf–Maxfield 2020, arXiv:2002.08950（系综 / baby universes）⟨待核⟩
- AHMST 2020, arXiv:2006.06872, Rev. Mod. Phys. 93,035002（综述：The entropy of Hawking radiation）
- Gao–Jafferis–Kolchmeyer 2021, arXiv:2104.01184（EOW brane 有效矩阵模型）
- Okuyama–Sakai 2021, arXiv:2111.09551（Page curve from dynamical branes in JT）

---

## 5. 建议第一步

对**靶子 1（Page 定理形式化）**做一次一天的**可行性侦察**：(a) 查 Mathlib / Archive of Formal Proofs / Lean Zulip 是否已有 Page 定理或其所需的随机矩阵谱期望积分；(b) 估 Mathlib 现有 Haar 测度 / 调和数 / 复高斯矩阵基础离目标有多远。若 Mathlib 缺口可控且无人形式化过，则立项作为「信息佯谬子图」的第一块 formalized 岛；同时把靶子 2 作为 research/ 的备选原创方向，但**先查随机张量网络文献是否已有严格 Page 曲线定理**。
