# PSSY → Marchenko–Pastur → Page 曲线：自足组装草稿

> **诚实框注（必读）**。本推导是**已知工具的拼接**：Marchenko–Pastur 定律（严格）+ Page/Foong–Kanno 纠缠熵封闭式（严格）+ PSSY 系综参数的平凡代入。**不宣称任何原创数学**。之所以放在 `research/attempts/` 而非直接进图，仅为**物理隔离 + 待 `graph-reviewer` 审查**；在被审查（理想情况下船长确认）前，**不得进入 `graph/` 或被任何节点依赖**。
>
> 与 `research/CLAUDE.md` 的目录格式（claim.md / proof.md / status.yaml）说明：本文件是一份**平铺的组装/说明草稿**，不是走"毕业轨道"的正式原创证明尝试（因为下面 §6 论证**不存在开放缺口**，没有"查无此证明"的命题可证）。若 reviewer 认为值得升级为正式 attempt 目录，再拆分。
>
> 诚实标签：⟨lit⟩ 有已发表来源直接支撑；⟨judgment⟩ 侦察员/起草者判断；⟨calc⟩ 本草稿内的初等演算（可复核）。
>
> 侦察上下文见 `docs/frontier-scouting/pssy-page-rmt-dedup.md`（§2 候选陈述、§7 对 arXiv:2403.05241 的查重裁定 (c)）。本草稿在把熵积分认真做出来的过程中**修正了 §2 的两处错误**（见 §5）。

---

## 1. 目的与查重状态

阶段一裁定：arXiv:2403.05241（Mück, PRD 109, 126001）**不构成查重（(c)）**——它识别的是黑洞微态 Gram 矩阵谱 = MP，算的是 Krylov state complexity 而非纠缠熵 Page 曲线，且非 PSSY 系综（见 `pssy-page-rmt-dedup.md` §7）。因此"把 PSSY EOW-brane 辐射密度矩阵谱 → MP → E[S(ρ_R)] 封闭式 → Page 相变"组装成**一条自足陈述**，据侦察所查**尚无人专门写出**。本草稿给出该组装。

**净结论前置**（诚实）：⟨judgment⟩ 组装的每一块都是已发表的严格定理，**原创数学增量 ≈ 0**。本草稿的价值是"接线 + 纠错"，建议以 `rigorous` 图节点登记（来源指 MP + Page/Foong–Kanno），而不是开正式原创证明轨道。详见 §6。

---

## 2. 精确系综定义（约定写清）

- 辐射/边界系统 H_R ≅ ℂ^k；bulk（EOW-brane 内部 / 微观）希尔伯特空间 H_B ≅ ℂ^L。
- **G 为 k×L 复随机矩阵**，条目独立同分布 G_{ia} ~ 𝒞𝒩(0, 1/L)，即 E[G_{ia}] = 0，E[|G_{ia}|²] = 1/L（复 Ginibre，**方差按 1/L 归一化**）。⟨calc⟩ 归一化选择使下面 W 的经验谱均值为 1。
- Wishart（Laguerre）矩阵 W := G G† ∈ ℂ^{k×k}。则 E[tr W] = Σ_{i,a} E|G_{ia}|² = kL·(1/L) = **k**。⟨calc⟩
- **辐射约化密度矩阵** ρ_R := W / tr(W) = G G† / tr(G G†)（归一化到 tr ρ_R = 1，Hermitian、半正定，故合法密度矩阵）。
- 极限：k, L → ∞，**比值 t := k/L → t ∈ (0, ∞)** 固定。熵单位为 nat（自然对数）。

**PSSY 物理字典**（⟨lit⟩ PSSY 1911.11977）。k = EOW-brane 味数（≈ 已辐射自由度，随蒸发时间增大）；L = e^{S_0}（bulk 希尔伯特空间维数，S_0 = 半经典黑洞熵）。故 t = k/e^{S_0} 是归一化"时间"。PSSY 的 resolvent Schwinger–Dyson 方程在此极限下就是 MP 的 Stieltjes/R-变换固定点方程（§3.1 注）。⟨lit⟩

---

## 3. 谱：ρ_R 的经验谱 → MP 定律

### 3.1 引理 1（Marchenko–Pastur）⟨lit⟩

写 G = (1/√L) G′，G′ 为方差 1 的 k×L Ginibre。则 W = G G† = (1/L) G′G′† 恰是标准 Wishart 矩阵 A = (1/N) X X†（X = G′，M = k，N = L，比 c = M/N = t）。

> **MP 定理**（Marchenko–Pastur 1967；强形式 Bai–Silverstein 2010）。X 为 M×N 复（或实）矩阵，条目 i.i.d. 均值 0 方差 1。设 M, N → ∞，M/N → t ∈ (0, ∞)。则 A = (1/N) X X† 的经验谱测度 μ_A = (1/M) Σ_i δ_{a_i} 几乎必然弱收敛到 MP 测度
>
>   dν_t(λ) = (1 − 1/t)_+ δ_0(λ) + [√((λ_+ − λ)(λ − λ_−)) / (2π t λ)] · 1_{[λ_−, λ_+]}(λ) dλ,
>
> 其中 λ_± = (1 ± √t)²，(x)_+ = max(x,0)。连续部分均值 ∫λ dν_t = 1，方差 ∫(λ−1)² dν_t = t。

因 W = A，**W 的经验谱测度几乎必然 → ν_t**。当 t ≤ 1 时 W 满秩（k 个非零本征值），无 0 原子；当 t > 1 时秩为 L < k，出现质量 (1 − 1/t) 的 0 原子（k − L 个零本征值）。⟨calc⟩

注（Schwinger–Dyson ⇄ MP）。⟨lit⟩ PSSY 的 resolvent R(λ) = E tr(λ − ρ)^{-1} 满足的 SD 方程（虫洞求和）在 L→∞、k/L→t 极限下与 MP 的 Stieltjes 变换 m(z) 满足的二次方程 t z m² − (z − (1 − t)) m + 1 = 0 同构。这是"PSSY 物理路径积分 = MP 定律"的严格对应点，也是 arXiv:2403.05241 对黑洞微态 Gram 矩阵所"识别"的同一事实（但对象是 bag-of-gold 微态，非 PSSY 辐射矩阵）。

### 3.2 引理 2（归一化不改谱极限）⟨calc⟩⟨lit⟩

tr(W) = Σ_i w_i（w_i 为 W 的本征值）。由强大数律/MP 均值，(1/k) Σ_i w_i → ∫λ dν_t = 1 a.s.（t ≤ 1 时 k 个本征值；t > 1 时仍 Σ w_i / L → …，见下）。故 tr(W) = k(1 + o(1)) a.s.（t ≤ 1）。归一化因子以概率 1 稳定，不改变谱的极限形状——只把 W 的谱整体缩放 1/tr(W) ≈ 1/k，使 ρ_R 的本征值 ρ_i ≈ w_i / k。⟨calc⟩

---

## 4. 熵：E[S(ρ_R)] 的封闭式

### 4.1 命题 1（熵的自平均极限）⟨calc⟩（依赖引理 1、2）

设 t ≤ 1。ρ_R 本征值 ρ_i = w_i / T，T = tr W = Σ_j w_j。则

  S(ρ_R) = −Σ_i ρ_i ln ρ_i
      = −(1/T) Σ_i w_i ln w_i + ln T · (1/T) Σ_i w_i
      = ln T − (1/T) Σ_i w_i ln w_i.        （用 Σ_i w_i = T）

代入 T = k(1 + o(1))、(1/k)Σ_i w_i ln w_i → I(t) := ∫ λ ln λ dν_t(λ)（强 MP + λ↦λ ln λ 在支撑上连续有界，t<1 时支撑 [λ_−,λ_+] 不含 0；t=1 时 λ_−=0，但 λ ln λ → 0，仍可积），得

  **S(ρ_R) = ln k − I(t) + o(1)   （依概率，自平均）**。

### 4.2 命题 2（I(t) 的封闭式）⟨lit⟩⟨calc⟩

**I(t) = ∫ λ ln λ dν_t(λ) = t/2**，对所有 t ∈ (0, 1]。

- **交叉验证（Page/Foong–Kanno）**⟨lit⟩：固定维精确 Page 公式（Page 1993 猜想；Foong–Kanno 1994、Sánchez-Ruiz 1995、Sen 1996 证明）给出，对 dim A = m ≤ dim B = n 的 Haar 随机纯态，
    ⟨S_A⟩ = ψ(mn+1) − ψ(n+1) − (m−1)/(2n).
  取 m = k ≤ L = n，大 k,L、m/n = t：ψ(kL+1) − ψ(L+1) = ln k + O(1/L)，(m−1)/(2n) = t/2 + O(1/L)，故 ⟨S⟩ = ln k − t/2 + o(1)。与命题 1 比对即得 I(t) = t/2。⟨calc⟩
- **小 t 独立核对**⟨calc⟩：λ ln λ = (1+δ)ln(1+δ) ≈ δ + δ²/2（δ = λ−1），E[δ]=0，E[δ²] = Var(ν_t) = t ⇒ I(t) ≈ t/2。

故 **S(ρ_R) = ln k − t/2 + o(1)（t ≤ 1）**——这正是 Page 的 −m/2n 修正项在 MP 大 N 极限下的表现。

### 4.3 t > 1 分支与两支合并⟨calc⟩⟨lit⟩

t > 1 时 min(k,L) = L，ρ_R 秩为 L（MP 出现 0 原子）。W 与 W′ = G†G 的非零谱相同，故可交换 k ↔ L（比 1/t < 1）套用上式：

  **S(ρ_R) = ln L − 1/(2t) + o(1)   （t > 1）**。

两支在 t = 1（k = L）处相接：ln k − 1/2 = ln L − 1/2。⟨calc⟩

---

## 5. Page 曲线与相变刻画（并修正 §2 草稿）

汇总（t = k/L）：

| 区间 | S(ρ_R) 极限 | 物理相 |
|---|---|---|
| t < 1（k < L = e^{S_0}） | ln k − t/2，随 k **单调上升** | 无岛 / Hawking 分支 |
| t = 1（k = e^{S_0}） | ln k − 1/2 = ln L − 1/2 | **Page 点** |
| t > 1（k > L） | ln L − 1/(2t)，→ ln L **饱和** | 有岛 / bulk 分支 |

**Page 时间**：t = 1，即 **k = e^{S_0}**。PSSY 蒸发图像里 k 随时间增大，S(ρ_R) 先如 ln k 上升，到 Page 时间后饱和于 S_0 = ln L。（要得到熵**下降**的完整 Page 曲线，需让 S_0 = ln L 随黑洞蒸发而减小——这是 MP 双参数模型之外的独立要素，本组装不含。）⟨judgment⟩

**相变的严格含义**⟨calc⟩⟨judgment⟩：
- **谱层面严格非解析**：MP 的 0 原子 (1 − 1/t)_+ 在 t = 1 处开启，是 ν_t 关于 t 的真非解析点（秩饱和）。
- **鞍点层面**：min(ln k, ln L) 的"退火"近似（两鞍点竞争，PSSY 的连通/非连通复本几何交换主导）在 t=1 有尖角。
- **但自平均 ⟨S⟩(t) 本身在 t=1 是光滑过渡**：以 k 参数化、L 固定，t<1 支 S = ln k − k/(2L)，t>1 支 S = ln L − L/(2k)，在 k=L 处**一阶、二阶导都连续**（dS/dk = 1/(2L)，d²S/dk² = −1/L²，两侧相等）。⟨calc⟩ 故"相变"的尖锐性在**谱密度原子开启**与**鞍点 min 理想化**里，不在有限分辨率的 ⟨S⟩ 里。

### 修正 §2 候选陈述的两处错误（诚实记录）

- **(修正 A)** §2(ii) 断言 S(ρ_n) 收敛到有限的 S_∞(t) = ∫(−λ log λ)dν_t —— **错**。归一化本征值 ρ_i = O(1/k)，S(ρ_R) ~ **ln k → ∞**，不收敛到有限量。有限的是**次导修正** I(t) = ∫λ ln λ dν_t = t/2。§2 把 O(1) 修正误当成整条熵。
- **(修正 B)** §2(iii) 断言 Page 相变/极大在 **t = 1/2** —— 以**比值 t = k/L** 参数化时**错**，正确是 **t = 1（k = L = e^{S_0}）**，与 arXiv:2403.05241 的 c = 1（s = 0）阈值一致。"1/2"只在以"占总维对数的份额 f = ln k / ln(kL)"参数化时成立（此时 S ≈ ln(kL)·min(f, 1−f) 在 f = 1/2 取峰）；§2 混淆了"比值"与"份额"两种参数化。

---

## 6. 关键引理 + 逐步引用；以及"文献缺口"评估

| 步骤 | 内容 | 严格性来源 | 已发表？ |
|---|---|---|---|
| L1 | ρ_R = GG†/tr(GG†) 谱 → MP ν_t | Marchenko–Pastur 1967；Bai–Silverstein 2010（强形式）；自由概率 Mingo–Speicher 2017 | ✅ 严格已发表 ⟨lit⟩ |
| L2 | tr(W) 自平均，归一化不改谱极限 | 强大数律 + MP 均值 | ✅ 标准 ⟨lit⟩ |
| P1 | S(ρ_R) = ln k − I(t) + o(1) | 弱收敛 + λ ln λ 可积（控制收敛）；随机熵自平均 | ✅ 组装（Page 方差结果保证集中）⟨lit⟩ |
| P2 | I(t) = t/2，即 ⟨S⟩ = ln k − t/2 | Page 1993 猜想；Foong–Kanno 1994 / Sánchez-Ruiz 1995 / Sen 1996 证明 | ✅ 严格已发表 ⟨lit⟩ |
| P3 | t>1 支 ln L − 1/(2t)，Page 点 t=1 | k↔L 对称 + 同上 | ✅ 标准 ⟨lit⟩ |
| P4 | 相变 = MP 0 原子在 t=1 开启 | ν_t 的显式非解析 | ✅ 由 L1 直接读出 ⟨calc⟩ |
| D | PSSY 字典 k=味数, L=e^{S_0}, SD=MP | PSSY 1911.11977（物理）+ 自由概率 | ✅ 物理已发表 ⟨lit⟩ |

**"哪一步文献确实没写全、需我们补？"**⟨judgment⟩

**答：没有。** 逐块检查——
- L1（Ginibre/Wishart ESD → MP）：完全严格、已发表（Marchenko–Pastur、Bai–Silverstein）。
- P2（E[S] 封闭式 ⟨S⟩ = ln k − t/2）：完全严格、已发表（Page/Foong–Kanno 系列）。固定迹归一化（ρ = W/tr W）的熵正是 Page 的固定迹 / 随机纯态设置。
- P4（Page 相变 = 秩饱和 = 0 原子开启）：由 MP 密度显式读出，无需新证明。
- D（PSSY SD 方程 = MP）：PSSY 已在物理层面写出 resolvent SD，其大 N 极限 = MP 是标准自由概率事实。

因此**不存在"查无此证明"的开放命题**——整条链是已发表严格定理的**显式组装**。可能的**微增量**仅为：**尚无人把"PSSY EOW 辐射 ρ_R 谱 → MP 且 ⟨S(ρ_R)⟩ = ln k − k/(2L)，Page 相变在 k = e^{S_0}"作为一条带完整引用的自足陈述写出来**——但这是 exposition/接线，不是新数学。

**给 reviewer / lead 的建议**⟨judgment⟩：
1. **不建议**把本条升级为正式 `research/attempts/` 原创证明轨道（无开放缺口可证）。
2. **建议**由 curator 走正常 `add-statement` 流程，在图中登记一个 `status = rigorous` 的**接线节点**："PSSY 辐射密度矩阵谱 → MP 分布 ⇒ ⟨S(ρ_R)⟩ = ln k − t/2（Page 曲线），Page 相变在 t = k/e^{S_0} = 1"，`depends_on` 指向（待登记的）MP 定律节点与 Page/Foong–Kanno 节点，`sources` 指 Marchenko–Pastur 1967、Bai–Silverstein 2010、Page 1993、Foong–Kanno 1994、PSSY 1911.11977；在 `note` 里显式声明"本节点为已发表定理的组装/接线，非原创证明；见 research/attempts/pssy-page-mp-assembly.md 的推导记录与 §2 纠错"。（curator 的活，需 reviewer；本草稿作者不建图节点。）
3. arXiv:2403.05241 可另行登记为相关但**不覆盖**本条的文献（它做 complexity，非熵）。

---

## 7. 文献清单

- ⟨lit⟩ Penington–Shenker–Stanford–Yang 2019, arXiv:1911.11977, JHEP 03(2022)205 — PSSY West Coast / EOW-brane 模型，resolvent SD 方程，Page 曲线物理来源。
- ⟨lit⟩ Marchenko–Pastur 1967, Math. USSR Sbornik 1, 457 — MP 定律原始。
- ⟨lit⟩ Bai–Silverstein 2010, *Spectral Analysis of Large Dimensional Random Matrices*, Springer — MP 强形式。
- ⟨lit⟩ Mingo–Speicher 2017, *Free Probability and Random Matrices*, Springer — 自由概率 / free Poisson。
- ⟨lit⟩ Page 1993, PRL 71, 1291, arXiv:gr-qc/9305007 — 平均纠缠熵猜想 ⟨S⟩ = ψ(mn+1) − ψ(n+1) − (m−1)/2n。
- ⟨lit⟩ Foong–Kanno 1994, PRL 72, 1148 — Page 公式证明。
- ⟨lit⟩ Sánchez-Ruiz 1995, Phys. Rev. E 52, 5653；Sen 1996, PRL 77, 1 — Page 公式独立证明。
- ⟨lit⟩ Mück 2024, arXiv:2403.05241, PRD 109, 126001 — 黑洞微态 Gram 矩阵 = MP + Krylov state complexity（**非**熵 Page 曲线，**非** PSSY；查重裁定 (c)，见 `pssy-page-rmt-dedup.md` §7）。
- ⟨lit⟩ arXiv:2204.01754 — 随机约化密度矩阵熵与主本征值的解析关系（−λ log λ 积分先例）。
