# 查重侦察：PSSY → Page 曲线 RMT 定理化可行性

> 侦察日期：2026-09-14。目标：判断"把 PSSY EOW-brane 模型的 Page 曲线重铸为严格 RMT/自由概率极限定理"是否已有人做过，评估原创空间与可证性。
>
> **诚实标签**：⟨lit⟩ = 有文献直接支撑；⟨judgment⟩ = 侦察员判断；⟨待核⟩ = 摘要层面查到，细节未读原文。所有判断偏保守。

---

## §0 一句话结论（给 lead）

**接线为主，但有一条窄原创缝**。PSSY resolvent-SD 方程在 L→∞, k/L→t 极限下恰恰就是 Marchenko-Pastur 定律（自由概率中的 free Poisson 极限），后者是严格数学定理，S(ρ_R) 对 MP 密度的积分给出的 Page 曲线公式也是可计算的。因此"严格 RMT 定理版本"的本征值密度部分已被自由概率文献覆盖。**尚未被任何人明确做过的是**：写一篇自洽的数学文章，把 PSSY 的具体系综（k×L Ginibre 矩阵）显式嵌入 MP 框架，推出 Page 时间（两支谱交换主导）在严格意义下是 t=1/2 相变，并给出 E[S(ρ_R)] 的解析封闭式——这一"拼接+严格化"论文⟨judgment⟩据侦察员所查尚无人专门写出。但它不是深度原创数学，而是已知定理在新物理语境里的清楚应用。建议：以 `接线 + exposition` 处理，不开 research/，在图里登记为 `rigorous`（借用 MP 定律）而非 `physical-argument`。

---

## §1 查重结果（逐篇，每篇一句话判断）

### 1.1 随机张量网络文献

**Hayden-Nezami-Qi-Thomas-Walter-Yang 2016，arXiv:1601.01694**⟨lit⟩
JHEP 11(2016)009。在大键维极限下严格证明随机张量网络对所有边界区域满足 Ryu-Takayanagi 公式（面积 = 最小割）。
**查重判断**：不构成查重。HNQTWW 证明的是 RT 公式的张量网络实现（离散几何），而非 PSSY EOW-brane 模型的 Schwinger-Dyson 分辨率 → 熵这条计算链；系综、极限类型、结论形式均不同。

**Nezami-Walter 2020，arXiv:2008.12538**⟨lit⟩
PRL 125, 241602 (2020)。在大键维极限下严格证明随机张量网络的多部纠缠性质（极小多路割）。
**查重判断**：不构成查重。关注多部纠缠结构而非双部 von Neumann 熵 Page 曲线，与 PSSY 模型无直接交集。

### 1.2 JT gravity + 矩阵模型严格化

**Okuyama-Sakai 2021，arXiv:2111.09551**⟨lit⟩
JHEP 02(2022)087，"Page curve from dynamical branes in JT gravity"。从对偶矩阵模型数值计算纠缠熵，观察到先升后降的 Page 曲线行为，解释为相变。
**查重判断**：不构成查重。这是数值计算，不是严格 RMT 定理；且用的是 FZZT 反膜（JT 谱曲线框架），不是孤立的 Ginibre 系综；没有写下封闭的极限定理或证明。

**Gao-Jafferis-Kolchmeyer 2021，arXiv:2104.01184**⟨lit⟩
JHEP 01(2022)038，"An effective matrix model for dynamical end of the world branes in JT gravity"。证明带动力 EOW brane 的 JT 引力路径积分精确匹配 SSS 矩阵模型的一个修改版本。
**查重判断**：不构成查重。给出物理等价性（引力 = 矩阵模型），但这本身是物理论证；没有把"矩阵模型 → 纠缠谱 → 熵 → Page 曲线"这条链写成自由概率极限定理并严格证明。

### 1.3 自由概率 / Marchenko-Pastur 严格性

**Marchenko-Pastur 1967；Voiculescu 自由概率体系（1980s-2000s）**⟨lit⟩
MP 定律（设 G 为 k×L i.i.d. 复高斯，k/L → t，则 GG†/L 的经验谱分布依概率收敛到 free Poisson(t) 测度）是严格数学定理，在矩方法和自由概率框架下均有完整证明。von Neumann 熵对 MP 密度的积分 ∫ρ_{MP,t}(λ)(-λ log λ)dλ 可用 R-变换或直接积分计算，给出关于 t 的封闭表达式。
**查重判断**：部分覆盖（本征值密度层面完全覆盖），但没有人把这个结果显式用于 PSSY 系综并推出 Page 曲线的相变结构。

**Mingo-Speicher 教材（2017），Collins-Sniady（2006）**⟨lit⟩
自由概率与随机矩阵的标准参考，覆盖 MP 定律、R-变换、自由熵等；Collins-Sniady 给出 Weingarten 函数和酉群积分的严格结果。
**查重判断**：数学基础完备，但是工具书，不是专门论 PSSY-Page 曲线的定理。

**arXiv:2403.05241（"Black Holes and Marchenko-Pastur Distribution"）**⟨待核⟩
据摘要：明确把黑洞微态 Gram 矩阵的本征值分布认同为 MP 分布，并用于分析黑洞信息。
**查重判断**：最接近的竞争者，需读原文。若该文显式写下了"ρ_R = GG†/tr(GG†) 的谱 → MP，熵 → Page 曲线公式"并给出严格证明，则直接构成查重。侦察员判断⟨judgment⟩：从摘要描述看该文更偏物理语境（黑洞微态计数），可能没有把整条从系综定义到熵封闭式的逻辑链写严格，但必须确认。

### 1.4 形式化（Lean/Isabelle/Coq）

搜索"Lean Mathlib random matrix entropy Marchenko-Pastur Wishart"未返回任何形式化成果⟨lit⟩。Mathlib 截至 2026 年初有测度论、概率、线性代数的基础，但没有形式化的随机矩阵谱分布、Wishart 系综、或 MP 定律。
**查重判断**：完全空白，无形式化查重风险。

---

## §2 候选精确陈述（数学草稿）

设置：

- H_R = ℂ^k（辐射/环境系统），H_bulk = ℂ^L（bulk 希尔伯特空间），k, L → ∞，k/L → t ∈ (0, 1)。
- G 为 k×L 复随机矩阵，条目 i.i.d. ~ CN(0, 1/L)（Ginibre 系综，L 归一化）。
- 辐射约化密度矩阵定义为 ρ_R = GG† / tr(GG†)（归一化 Wishart 矩阵）。

**候选定理（草稿 v1）**：

> 设 G_n 为 ⌊tn ⌋ × n 复 Ginibre 矩阵（条目 i.i.d. CN(0,1/n)），ρ_n = G_n G_n† / tr(G_n G_n†)。
>
> (i) **谱收敛**：ρ_n 的经验谱测度 μ_n = (1/⌊tn⌋) Σ_i δ_{λ_i(ρ_n)} 依弱概率收敛到 Marchenko-Pastur 测度
>
>     dν_t(λ) = (1 − 1/t)⁺ δ_0 + √[(λ_+ − λ)(λ − λ_−)] / (2π t λ) · 1_{[λ_−, λ_+]} dλ,
>
>     其中 λ_± = (1 ± √t)² / t 是归一化后的支撑端点。（注：归一化到 tr ρ_n = 1，故谱被 t 因子缩放。）
>
> (ii) **熵收敛**：von Neumann 熵 S(ρ_n) = −tr(ρ_n log ρ_n) 在概率下收敛到
>
>     S_∞(t) = ∫ (−λ log λ) dν_t(λ),
>
>     此积分有封闭表达式，关于 t ∈ (0,1) 的函数在 t = 1/2 附近达到最大值（Page 时间对应 t = 1/2，即 k = L/2）。
>
> (iii) **Page 曲线形状**：S_∞(t) 在 t < 1/2 时单调递增，在 t > 1/2 时单调递减，Page 时间 t* = 1/2 是全局最大值点。

**约定说明**：
- 熵单位为 nat（自然对数）；换 bit 乘以 1/ln 2。
- 上述系综对应 PSSY 中"k 味 EOW brane 与 k 维辐射系统最大纠缠，bulk 截断维数 L → ∞"的极限。物理时间 ↔ k（蒸发增大 k），故 t = k/L 是归一化时间。
- 精确的 Page 时间（两个熵分支交换主导）在 PSSY 物理论证里是两鞍点相变；在 RMT 语言里是 t = 1/2 时 S_∞ 的极值。
- 此陈述暂未声明 E[S(ρ_n)] 与 S_∞(t) 的收敛速度（需集中不等式），仅陈述依概率收敛。

---

## §3 可证性评估

### 3.1 MP 定律路径的完整性

(i) 部分（谱收敛到 MP）是标准结果⟨lit⟩：矩方法（Marchenko-Pastur 1967），Stieltjes 变换方法（多本教材），以及强收敛版本（Bai-Silverstein 等）均给出完整严格证明。ρ_n 是归一化 Wishart 矩阵，归一化因子 tr(GG†) ≈ k（大数定律，方差压低）以概率 1 稳定，不影响谱极限。⟨judgment⟩

(ii) 部分（熵的收敛）需要：
  - von Neumann 熵 λ ↦ −λ log λ 在 [0,1] 上有界连续（除 λ=0 但 MP 密度的 L^1 积分对 -λ log λ 可控）；
  - 弱收敛 + 函数的连续有界性 → 积分收敛；由于 -λ log λ 在 λ=0 只有对数奇点而 MP 密度对应地在 0 的行为可控（t<1 时有原子 1−t 在 0，但 -λ log λ → 0 as λ→0），可用控制收敛定理。⟨judgment⟩
  - 这些技术细节在随机矩阵熵文献（如 arXiv:2204.01754 等）里有处理先例⟨lit⟩，但需整理成一个干净引理。

(iii) 部分（Page 曲线单调性）：S_∞(t) 的封闭式可对 t 求导并分析符号——这是一道干净的微积分题，不依赖随机性，完全严格。⟨judgment⟩

**总结**：整条路径的每个步骤都有现成工具或先例；"证明"主要是把已知结果正确组装，加上对熵积分在端点的可控性做精细化处理。估计一篇 4-8 页的严格数学注记（note）足以完成，不需要新颖数学思想。⟨judgment⟩

### 3.2 最小严格证明路径（4-8 页论文大纲）

1. **引理 1（谱收敛）**：引用 Marchenko-Pastur 定律的标准强形式（Bai-Silverstein 或等价陈述），给出 ρ_n = G_n G_n† / tr(G_n G_n†) 的经验谱测度到 ν_t 的几乎必然弱收敛。
2. **引理 2（熵可积性）**：证明 ∫ |−λ log λ| dν_t(λ) < ∞；用 MP 密度在 0 和 λ_± 处的行为给出显式估计。
3. **命题 1（熵收敛）**：由引理 1+2 加控制收敛，推出 S(ρ_n) → S_∞(t) 依概率。
4. **命题 2（封闭式）**：用 R-变换或显式积分计算 S_∞(t) = − ∫ λ log λ dν_t(λ) 的封闭表达式（已知可用自由熵工具或直接用 MP 密度的矩公式计算；结果涉及对数和初等函数）。
5. **定理（Page 曲线）**：证明 S_∞(t) 在 t=1/2 取最大值，在 (0,1/2) 递增、(1/2,1) 递减；对 dS_∞/dt 分析符号（纯分析）。
6. **注记（物理对应）**：将参数映射回 PSSY 物理量（k 味 brane，L = e^{S_0}，t = k/e^{S_0}），说明 Page 时间 = t=1/2 时的相变。

**关键引理来源**：Bai-Silverstein《Spectral Analysis of Large Dimensional Random Matrices》（Springer, 2010）；Mingo-Speicher《Free Probability and Random Matrices》（Springer, 2017）；Voiculescu 自由熵系列文章（math/0103168 等）。⟨lit⟩

### 3.3 Lean/Mathlib 基础设施现状

Mathlib 目前（2026 年初）没有 MP 定律、Wishart 系综、或随机矩阵谱收敛的形式化。⟨judgment⟩ 从零开始形式化上述论文（命题 1-3 + 定理）的估计工作量极大：MP 定律的 Lean 证明本身是一个独立的大型形式化项目（大数定律→矩方法→弱收敛→谱测度，Mathlib 各有基础但未组装）。建议近期不作为 Lean 形式化靶子；若未来 Mathlib 补上随机矩阵基础设施后再考虑。

---

## §4 与 Page 定理（Foong-Kanno 1994）的关系

**不是同一定理，但同一框架在不同参数区间的表现。**

Page 定理（Foong-Kanno 1994）工作在**固定有限维**（Hilbert 空间维数 m, n 固定，Haar 随机纯态），给出 ⟨S(ρ_A)⟩ 的精确有限维公式 = H_{mn} − H_n − (m−1)/2n（调和数表达式）。极限 m,n → ∞ with m/n → t ∈ (0,1) 下，Haar 随机纯态的约化密度矩阵的经验谱分布收敛到 MP(t)——这正是 MP 定律在 Laguerre 系综（即 Wishart）上的表现。因此：

- Foong-Kanno 的**有限维精确公式**在 m,n → ∞, m/n → t 极限下趋近于候选定理的 S_∞(t)；⟨judgment⟩
- PSSY 直接工作在大 L 极限（L → ∞ 是 bulk 截断维数），Ginibre 系综（i.i.d. 高斯）而非严格的 Haar 酉不变系综，但二者在谱层面具有相同的大 N 极限（普适性）；⟨lit⟩
- Foong-Kanno 的有限维证明**不能直接移植**到 PSSY 极限，因为 PSSY 从一开始就取大 L 极限，需要 MP 大数定律而非有限维求和公式；但二者的**大 N 渐近结果一致**，从不同路径到达同一极限。

结论：Foong-Kanno 是"有限维精确"，候选 RMT 定理是"大 N 极限严格"，二者互补而非重复。候选定理需要的是 MP 定律而非 Foong-Kanno 的组合技术。⟨judgment⟩

---

## §5 建议

**不建议开 research/ 轨道。** 理由：

1. 候选定理所需的数学工具（MP 定律、弱收敛、熵积分）均已有严格证明，没有真正意义上的"查无此证明"的数学空缺。
2. 把这些工具组装成一篇以 PSSY 为动机的自洽严格论文是有价值的**接线工作**（exposition + 应用），不是原创数学定理。
3. arXiv:2403.05241 是需要阅读原文的待核竞争者⟨待核⟩——若它已显式把 PSSY 系综映射到 MP 并给出严格证明，则连接线工作也已完成。

**建议的后续动作**（按优先级）：

- **第一步**：读 arXiv:2403.05241 全文，确认是否已有"PSSY Ginibre → MP → Page 曲线公式 + 相变"的严格数学陈述。如有，在图里登记为 `rigorous`，来源指向该文，工作完成。
- **第二步（若 2403.05241 未完整覆盖）**：把候选定理的 §2 陈述作为图节点，状态标 `rigorous`，依赖边指向 MP 定律（Bai-Silverstein）和自由概率（Mingo-Speicher），备注"证明为已知工具的直接组装，可在 4-8 页 note 中完成"；登记到 `graph/statements/` 但不开 research/。
- **第三步（远期）**：若 Mathlib 在随机矩阵方向有重大进展，可作为形式化目标；目前不推荐。

---

## §6 关键文献

⟨lit⟩ PSSY 2019, arXiv:1911.11977, JHEP 03(2022)205 — West Coast model，resolvent SD 方程，Page 曲线 physical-argument 原始来源。

⟨lit⟩ Hayden-Nezami-Qi-Thomas-Walter-Yang 2016, arXiv:1601.01694, JHEP 11(2016)009 — 随机张量网络严格 RT 公式，大键维极限；不直接覆盖 PSSY。

⟨lit⟩ Nezami-Walter 2020, arXiv:2008.12538, PRL 125,241602 — 随机张量网络多部纠缠，极小割；不直接覆盖。

⟨lit⟩ Okuyama-Sakai 2021, arXiv:2111.09551, JHEP 02(2022)087 — JT gravity 矩阵模型数值 Page 曲线；非严格定理。

⟨lit⟩ Gao-Jafferis-Kolchmeyer 2021, arXiv:2104.01184, JHEP 01(2022)038 — 动力 EOW brane 有效矩阵模型，物理等价性；非严格定理。

⟨lit⟩ Marchenko-Pastur 1967, Mat. Sb. 72(114):507 — MP 定律原始证明。

⟨lit⟩ Bai-Silverstein 2010, 《Spectral Analysis of Large Dimensional Random Matrices》, Springer — MP 定律强形式参考书。

⟨lit⟩ Mingo-Speicher 2017, 《Free Probability and Random Matrices》, Springer — 自由概率与随机矩阵标准教材。

⟨lit⟩ Voiculescu et al., arXiv:math/0103168 — 自由熵综述。

⟨lit⟩ Foong-Kanno 1994, PRL 72:1148 — Page 定理有限维精确证明。

⟨待核⟩ arXiv:2403.05241 — 《Black Holes and Marchenko-Pastur Distribution》，据摘要直接连接黑洞微态与 MP 分布；需读全文确认是否覆盖 PSSY Page 曲线严格化。

⟨lit⟩ arXiv:2204.01754 — 随机约化密度矩阵的熵与主本征值的精确解析关系，提供处理 -λ log λ 积分的先例。
