# 抽取记录：sen-1995-bh-torus

- 文献：A. Sen, "Black hole solutions in heterotic string theory on a torus", Nucl. Phys. B **440** (1995) 421–440, arXiv:hep-th/9411187
- 抽取者：researcher agent
- 日期：2026-09-11
- 覆盖范围：**全文 21 页逐页读图（L1）**，§1–§4 + References [1]–[32]

> ⚠ **与 `sen-1995-bh`（hep-th/9504147）是两篇不同论文，绝不可互换**（见 `sources.bib` 两条 note）。
> 本记录按 `literature/CLAUDE.md` 规则 3 可追加，不覆盖。

---

## 0. 获取途径与证据等级

### 0.1 证据等级约定（与 `green-schwarz-1984.md` §0.1 同）

| 标记 | 含义 |
|---|---|
| `[L1]` | 一手正文逐页读图（本项目认可的"读过"） |
| `[L2]` | 摘要 / 元数据级 |
| `[L3]` | 他人论文里对本文的逐字转述 |
| `[L4]` | 检索引擎中介的抽取，不得照抄公式字符 |
| `[L0]` | 未核实 |
| `[抽取者复算]` | 原文没写、由抽取者算出 —— **转节点必须 `inferred: true`** |

### 0.2 本轮结果：**全文取到，等级 L1**

- 途径：`https://arxiv.org/pdf/hep-th/9411187` → WebFetch 落盘 → `Read(pages=)` 逐页读图。一次成功，无反爬。
- **版本写死 `v3`**：页 1 侧边条纹逐字 `arXiv:hep-th/9411187v3  3 Dec 1994`。**所有 loc 按 v3。**
- **总页数 21**（p.1 标题页 → p.18 正文末 → pp.19–21 References [1]–[32]）。
- 报告号 **TIFR-TH-94-47**；标题页页脚逐字 `hep-th/9411187` / `November, 1994`。
- ⚠ **标题页正中印的 `November 26, 2024` 是 arXiv 重新编译源码的 `\today`，不是任何论文日期**（与 `sen-1995-bh` 同型陷阱）。
- **期刊终页 440 仍未核对（L0）**：arXiv 版无期刊页码。起始页 421 此前由 `arkani-hamed-2006` 参考文献 [8] L1 佐证。

### 0.3 读图不确定处（逐条留痕）

| # | 位置 | 不确定内容 | 处理 |
|---|---|---|---|
| U-a | p.11，Bogomol'nyi 界那句的引用编号 | 读作 `[24, 25]`；PDF 里该处是超链接框，数字边缘有描边 | **内容判据支持 `[24, 25]`**：[24] = Gibbons–Hull PLB 109 (1982) 109 + Harvey–Liu + Kallosh 等（全是 BPS 界文献）、[25] = Sen MPLA **A8** (1993) 2023；而 [21] = Marcus–Schwarz NPB 228 (1983) 145 在正文别处是用于 O(8,24) 对称性，与 BPS 界无关。⇒ 采 `[24, 25]`，本条留痕 |
| U-b | p.18，"consistent with GSO projection[25]" 的编号 | 读作 `[25]` | 未作内容判据，**引用时不要带这个编号** |

---

## 1. 约定 —— ★ 本轮任务的核心问题

### 1.1 ★★ 本文**不声明** α'、M_Pl、G_N 中的任何一个（否定结论，L1 全文核实）

**逐页核实结果：全文 21 页里，**

- **没有 `α'`**（一次都没出现）；
- **没有 `M_Pl`、没有 "Planck mass"、没有 "Planck scale"**；
  唯一一处 "Planck" 是 **p.18**，逐字「where `η` is a fixed length of the order of the **Planck length**」——那是 stretched horizon 的厚度，**不是归一化声明**；
- **没有 Newton 常数 `G`/`G_N`、没有 `16πG`、没有 `κ²`**（`κ` 在本文是**表面引力**，见 (2.48)）；
- **没有弦耦合 `g`**（`g_L`/`g_R` 是**回磁比**，(2.44)；`g_{μν}` 是 Einstein 度规，(3.1)）；
- **没有电荷格的量子化条件**、**没有 "even self-dual"、没有 "Narain lattice"**。
  唯一一次提到电荷格是 **p.4，(2.7) 之后**，逐字「This is a symmetry of the full string theory if we also rotate the **28 dimensional lattice `Λ` of electric charges** by `Ω`[7]」——`[7] = Narain PLB B169 (1986) 41; Narain–Sarmadi–Witten NPB B279 (1987) 369`。**只提到格的存在，不给归一化、不给 `Q_L² − Q_R² ∈ 2Z`。**

### 1.2 那么 (2.56)/(2.60)/(2.64) 里的 `M`、`Q` 归一化是怎么定的？

**原文唯一的自述是 p.11 那句**（L1 逐字）：

> "**In the normalization convention that we have been using**, the Bogomol'nyi bound that follows from the space-time supersymmetry of the theory, is given by `M² ≥ (Q⃗_R²/2)`[24, 25]."

即作者**承认结论依赖归一化约定，但通篇没有把这个约定写成 `α'`/`G_N`/`M_Pl` 的取值**。约定实际上是**隐含在两条读数规则里**的：

1. **质量**：(2.38) `M = ½m(1 + cosh α cosh β)`，其中 `m` 是 Kerr 解 (2.23) 的参数。
   **`[抽取者复算]`**：由 Einstein 度规 (2.37) 取 `ρ → ∞`，`Δ^{1/2} → ρ²[1 + m(cosh α cosh β − 1)/ρ]`，得
   `g^E_tt → −(1 − m(1 + cosh α cosh β)/ρ) = −(1 − 2M/ρ)`。
   ⇒ **`M` 是按 `g_tt = −(1 − 2M/ρ)` 读出的，即 `G_N = 1` 单位。** 原文没有写这一步，**转节点必须 `inferred: true`**。
2. **电荷**：§3 的 (3.6)–(3.8) 显示 `Q^{(a)}_{el}` 是按 **`F^{(a)}_{ρt} → Q^{(a)}/ρ²`** 读出的（(3.6) 的渐近式与 (3.8) 的结果系数相同，`m/ρ² → 1/ρ²` 对应）。**没有 `1/4π`、没有场强动能项归一化因子。**
   ⇒ `Q` 的归一化**与作用量 (2.3) 的任意常数 `C` 无关**（因为 `M` 与 `Q` 都从同一个解的渐近行为读出）。

### 1.3 ★★ 与 `arkani-hamed-2006`（AMNV）的换算：**两边都不给，无法闭合**

| | Sen（本文） | AMNV `§4, (20)–(25), p.12–14` |
|---|---|---|
| 质量归一化 | **不声明**；隐含 `g_tt = −(1 − 2M/ρ)`（`[抽取者复算]`） | 逐字「we work in units with **`M_Pl = 1`**」 |
| `α'` | **全文不出现** | 逐字「where we chose units with **`α' = 4`**」（仅用于 (24) 弦谱） |
| 电荷格 | 只提到"28 维电荷格 `Λ`"存在，**无量子化条件** | (21) `Q_L² − Q_R² ∈ 2Z`，28 维偶自对偶格 |
| 换算 | **无** | **无** |

**结论（本轮任务的直接回答）**：

- **AMNV 的 `M_Pl = 1` 不出自 Sen**，Sen 从头到尾没写过 `M_Pl`。
- 若把 `M_Pl` 定义为 `M_Pl² = 1/G_N`（非约化），则「Sen 的 `G_N = 1`」与「AMNV 的 `M_Pl = 1`」在**质量侧**一致 —— 但这依赖 §1.2 的复算**加上** AMNV 自己没声明的 `M_Pl` 定义（`arkani-hamed-2006.md` **Q2** 已记：AMNV 内部 `M = QM_Pl` 与 `M² = ½Q²` 差一个 `√2` 与电荷归一化，原文不给换算）。
- **电荷侧完全无法闭合**：Sen 的 `Q^{(a)}` 是连续参数（`(m/√2) sinh α cosh β n^{(a)}` 等），**从不与任何格点归一化挂钩**；AMNV 的 `Q` 则受 (21) 的格条件约束，且 (24) 的 `−1` 与 (25) 的 `−1` 只有在 `α' = 4` 与该格归一化下才有意义。
  ⇒ **「Sen 的 `Q_R`」= 「AMNV 的 `Q_R`」这一步，在两篇一手文献里都没有依据。**

**给 curator 的硬性要求**：任何把 Sen (2.56)/(2.60) 与 AMNV (24)/(25) 并置的推导边，**必须**
(a) 挂 `conv.extremality-normalization`（`arkani-hamed-2006.md` Q2 已建议新建），
(b) 在 `gaps` 里写明「Sen↔AMNV 的电荷归一化桥在两篇原文中均不存在」，
(c) 该桥若要画，标 `inferred: true`。

### 1.4 与 `graph/conventions/` 的对照

- **号差**：本文**不声明**。由 (2.21) `(G_{μν})_{as} = η_{μν}` 与 (2.23) Kerr 解首项 `−[…]dt²` 可读出 **mostly-plus `(−,+,+,+)`**（`[抽取者复算]`，与 `conv.metric-mostly-plus` 一致，引用无需换算）。
- **α'**：不适用（不出现）。**不要**给本文挂任何 α' 约定卡。
- **规范场归一化**：由 (2.3) 的 `−G^{μμ'}G^{νν'}F^{(a)}_{μν}(LML)_{ab}F^{(b)}_{μ'ν'}`（系数 `−1`，**不是** `−1/4`）+ 整体任意常数 `C`。⇒ **不能与任何标准 YM 归一化卡直接对接。**

---

## 2. 陈述

### E1 理论内容与无质量场谱
- 位置：**§2, p.3, (2.1)–(2.2) 之前的正文** `[L1]`
- 类型：definition
- 原文（逐字）："The massless fields in heterotic string theory compactified on a six dimensional torus consist of the metric `G_{μν}`, the anti-symmetric tensor field `B_{μν}`, twenty eight `U(1)` gauge fields `A^{(a)}_μ` (`1 ≤ a ≤ 28`), the scalar dilaton field `Φ`, and a `28 × 28` matrix valued scalar field `M` satisfying, `MLM^T = L`, `M^T = M`. (2.1)"
- (2.2)：`L = diag(−I₂₂, I₆)`（22 个本征值 `−1`、6 个 `+1`）。
- 自称严格程度：陈述，无证明（标准结果）。
- 依赖：无（外部输入）。

### E2 四维有效作用量与**任意常数 `C`**
- 位置：**§2, (2.3)–(2.5), p.3** `[L1]`
- 类型：definition
- 原文（逐字，(2.3)）：
  `S = C ∫ d⁴x √(−det G) e^{−Φ} [ R_G + G^{μν}∂_μΦ∂_νΦ + (1/8)G^{μν}Tr(∂_μML∂_νML) − (1/12)G^{μμ'}G^{νν'}G^{ρρ'}H_{μνρ}H_{μ'ν'ρ'} − G^{μμ'}G^{νν'}F^{(a)}_{μν}(LML)_{ab}F^{(b)}_{μ'ν'} ]`
  (2.4) `F^{(a)}_{μν} = ∂_μA^{(a)}_ν − ∂_νA^{(a)}_μ`；(2.5) `H_{μνρ} = ∂_μB_{νρ} + 2A^{(a)}_μ L_{ab}F^{(b)}_{νρ} + cyclic permutations of μ, ν, ρ`
- 原文（逐字，紧接 (2.5)）："**`C` is an arbitrary constant which does not affect the equations of motion and can be absorbed into the dilaton field `Φ`.**"
- 自称严格程度：引用给出（"The action … is given by[23]"，**[23] = J. Maharana and J. Schwarz, Nucl. Phys. B390 (1993) 3 [hep-th/9207016]**）。
- 备注：★ **这是 §1.1「本文不定 `G_N`」的直接根据** —— Einstein–Hilbert 项的系数就是 `C e^{−Φ}`，作者自己说 `C` 任意。

### E3 O(6,22) 与 O(7,23) 对称性
- 位置：**§2, (2.6)–(2.7), p.3–4；(2.14)–(2.20), p.4–5** `[L1]`
- 类型：proposition
- (2.6)：`M → ΩMΩ^T, A^{(a)}_μ → Ω_{ab}A^{(b)}_μ, Φ → Φ, G_{μν} → G_{μν}, B_{μν} → B_{μν}`，(2.7) `ΩLΩ^T = L`。
- 原文（逐字，(2.7) 之后）："This is a symmetry of the full string theory if we also rotate the **28 dimensional lattice `Λ` of electric charges** by `Ω`[7]. On the other hand, for fixed `Λ`, only a discrete subgroup `O(6,22;Z)` of `O(6,22)` is a symmetry of the full string theory."
- 时间无关位形的 `O(7,23)`：(2.17)–(2.18)（`Ω̄` 是 `30×30`，`Ω̄L̄Ω̄^T = L̄`）。
- 自称严格程度："It can be verified that"（(2.14)）；`O(7,23)` 的存在引 [11, 1]。
- 备注：★ **本文对电荷格只说这一句**。无量子化条件、无偶自对偶、无 `Q_L² − Q_R² ∈ 2Z`。

### E4 一般转动带电黑洞解
- 位置：**§2, (2.29)–(2.37), pp.7–8** `[L1]`
- 类型：proposition（显式解）
- 构造：对 Kerr 解 (2.23) 作 `O(7,23)` 变换，参数化为陪集 `(O(6,1) × O(22,1))/(O(6) × O(22))` (2.25)（**28 维**），由 `Ω̄ = Ω̄₂Ω̄₁` (2.26)–(2.28) 给出，共 **28 个参数 `α, β, n⃗, p⃗`**（`n⃗` 22 维单位矢、`p⃗` 6 维单位矢）。
- 结果：(2.29) 弦框度规、(2.30) `Δ`、(2.31) `Φ`、(2.32) `A^{(a)}_t`、(2.33) `A^{(a)}_φ`、(2.34) `B_{tφ}`、(2.35)–(2.36) `M`、**(2.37) 正则 Einstein 度规 `ds_E² = e^{−Φ}ds²`**。
- 自称严格程度：逐字 "It is now a **straightforward algebraic exercise** to apply the transformation generated by `Ω̄` … The result is,"。**过程不展示。**
- 依赖：E3；Kerr 解 (2.23)（引 [13] = A. Sen, PRL **69** (1992) 1006）。

### E5 ★ 质量、角动量、电荷、磁偶极矩
- 位置：**§2, (2.38)–(2.41), p.8** `[L1]`
- 类型：proposition
- 原文（逐字）：
  - (2.38) `M = ½ m (1 + cosh α cosh β)`
  - (2.39) `J = ½ m a (cosh α + cosh β)`
  - (2.40) `Q^{(a)} = (m/√2) sinh α cosh β n^{(a)}` for `1 ≤ a ≤ 22`；`= (m/√2) sinh β cosh α p^{(a−22)}` for `23 ≤ a ≤ 28`
  - (2.41) `μ^{(a)} = (1/√2) m a sinh α n^{(a)}` for `1 ≤ a ≤ 22`；`= (1/√2) m a sinh β p^{(a−22)}` for `23 ≤ a ≤ 28`
- 引出句（逐字）："One can easily verify that the new solution given in eqs.(2.29)-(2.37) describes a black hole with mass `M`, angular momentum `J`, electric charge `Q^{(a)}` and magnetic dipole moment `μ^{(a)}` given by,"
- 自称严格程度：**"One can easily verify"** —— 无推导。
- 备注：**归一化就藏在这里**，见 §1.2。

### E6 ★ `Q_L` / `Q_R` 的定义（22 + 6 维）
- 位置：**§2, (2.42), p.9** `[L1]`
- 类型：definition
- 原文（逐字）：`Q^{(a)}_{L/R} = ½(I₂₈ ∓ L)_{ab}Q^{(b)}`，`μ^{(a)}_{L/R} = ½(I₂₈ ∓ L)_{ab}μ^{(b)}`
  紧接正文（逐字）："Then `Q⃗_L` (`μ⃗_L`) has its last six components zero, whereas `Q⃗_R` (`μ⃗_R`) has its first 22 components zero. In other words, `Q⃗_L` (`μ⃗_L`) and `Q⃗_R` (`μ⃗_R`) can be regarded as **22 and 6 dimensional vectors** respectively."
- 备注：★ **与 AMNV (20)「`Q_L` 是 22 维、`Q_R` 是 6 维」逐位对应**，是两篇之间唯一**完全对得上**的约定。
  ⚠ 但注意 `L = diag(−I₂₂, I₆)`（(2.2)），所以 `½(I₂₈ − L)` 投到前 22 分量 = `L`，与"左移"命名一致；**AMNV 没给投影子定义**。

### E7 视界、极端极限、面积、表面引力
- 位置：**§2, (2.45)–(2.51), p.9–10** `[L1]`
- (2.45) `ρ² − 2mρ + a² = 0`；(2.46) `ρ = m ± √(m²−a²) ≡ ρ_H^±`。
- 原文（逐字）："Note that the horizons disappear for `a > m`, leaving behind naked singularity. **The limit `a → m` is known as the extremal limit.**"
- (2.47) `A = 4πm(cosh α + cosh β)(m + √(m²−a²))`；(2.48) `κ = √(m²−a²) / [m(cosh α+cosh β)(m+√(m²−a²))]`；(2.50) `Ω`。
- (2.51)：`a → m` 时 `A → 4πm²(cosh α + cosh β) = 8π|J|`，`κ → 0`。

### E8 ★★ 非转动（`a = 0`）极端极限的三种情形 —— **AMNV (22)(23) 的真出处**
- 位置：**§2, (2.52)–(2.65), p.10–11** `[L1]`
- 类型：proposition
- **公共设定（逐字）**："For non-rotating black holes (`a = 0`) special care is needed to study the extremal limit. … The metric describes a black hole with horizon at `ρ = 2m` and singularity at `ρ = 0`. **The extremal limit corresponds to the case when the horizon approaches the singularity, i.e. `m → 0` keeping the physical mass `M` defined in eq.(2.38) fixed.** We shall now study this limit in three separate cases."
  - (2.52) `ds_E² = −Δ^{−1/2}(ρ²−2mρ)dt² + Δ^{1/2}(ρ²−2mρ)^{−1}dρ² + Δ^{1/2}(dθ² + sin²θ dφ²)`
  - (2.53) `Δ = ρ²{ρ² + 2mρ(cosh α cosh β − 1) + m²(cosh α − cosh β)²}`

**Case I：`α > β`**（(2.54)–(2.57)）
  - (2.54) `m → 0, α → ∞, m cosh α ≡ m₀` finite, `β` finite
  - (2.55) `M = (m₀/2)cosh β`，`Q⃗_L = (m₀/√2)cosh β n⃗`，`Q⃗_R = (m₀/√2) sinh β p⃗`
  - **(2.56)** `M² = ½ Q⃗_L²`，`Q⃗_R = √2 M tanh β p⃗`
  - 逐字："Thus here `Q⃗_R² < Q⃗_L²`."；(2.57) `A → 0`，`κ → (1/4M)cosh β`

**Case II：`α < β`**（(2.58)–(2.61)）
  - (2.58) `m → 0, β → ∞, m cosh β ≡ m₀` finite, `α` finite
  - (2.59) `M = (m₀/2)cosh α`，`Q⃗_L = (m₀/√2)sinh α n⃗`，`Q⃗_R = (m₀/√2)cosh α p⃗`
  - **(2.60)** `M² = ½ Q⃗_R²`，`Q⃗_L = √2 M tanh α n⃗`
  - 逐字："In this limit `Q⃗_L² < Q⃗_R²`."；(2.61) `A → 0`，`κ → (1/4M)cosh α`

**Case III：`α = β`**（(2.62)–(2.65)）
  - (2.62) `m → 0, α = β → ∞, m cosh²α ≡ m₀` finite
  - (2.63) `M = m₀/2`，`Q⃗_L = (m₀/√2)n⃗`，`Q⃗_R = (m₀/√2)p⃗`
  - **(2.64)** `M² = ½ Q⃗_L² = ½ Q⃗_R²`
  - (2.65) `A → 0`，`κ → ∞`
- 自称严格程度：直接给出（"In this limit, eqs.(2.38) and (2.40) take the form"），**属代数极限，可完全复核**。
- **`[抽取者复算]`（已验）**：由 (2.55) 得 `Q⃗_L² = (m₀²/2)cosh²β`（`n⃗` 为单位矢），`M² = (m₀²/4)cosh²β = ½Q⃗_L²` ✔；Case II、III 同理 ✔。
- ★★ **对图的直接结论**：
  **AMNV (22) `M² = ½Q_R²`（BPS）= 本文 (2.60)（Case II）；AMNV (23) `M² = ½Q_L²`（非 BPS）= 本文 (2.56)（Case I）。**
  **AMNV 的 `Q_R² − Q_L² > 0` ⟺ 本文的 `α < β`；`Q_L² − Q_R² > 0` ⟺ `α > β`**（由各情形的 `Q⃗_R² < Q⃗_L²` / `Q⃗_L² < Q⃗_R²` 逐字对应）。
  **AMNV 没有引用 Case III (2.64)**（`α = β`，两者相等的边界情形）。

### E9 ★★ Bogomol'nyi 界与哪些解饱和它
- 位置：**§2, p.11，(2.65) 之后，无式号** `[L1]`
- 类型：proposition（外部输入 + 本文的应用）
- 原文（逐字，整段）：
  > "In the normalization convention that we have been using, the Bogomol'nyi bound that follows from the space-time supersymmetry of the theory, is given by `M² ≥ (Q⃗_R²/2)`[24, 25]. Thus we see that the extremal black holes in **cases II and III saturate the Bogomol'nyi bound, and hence give rise to supersymmetric solutions, whereas those in case I do not**. Also for non-zero `J`, eqs.(2.38)-(2.40) shows that `M²` is always larger than `(Q⃗_R²/2)`, even in the extremal limit `a → m`. This shows that **the extremal black holes carrying non-zero angular momentum do not correspond to supersymmetric solutions.** (Similar observations have been made in ref.[26].) For special cases `α = β` and `α = 0`, the non-rotating solutions constructed here reproduce the solutions discussed in ref.[5]."
- 自称严格程度：**Bogomol'nyi 界本身外包给 [24, 25]，本文不证**（"the Bogomol'nyi bound that follows from the space-time supersymmetry of the theory, is given by … [24,25]"）。
  `[24] = G. Gibbons and C. Hull, Phys. Lett. B109 (1982) 109; J. Harvey and J. Liu, Phys. Lett. B268 (1991) 40; R. Kallosh, A. Linde, T. Ortin, A. Peet and A. Van Proeyen, Phys. Rev. D46 (1992) 5278 [hep-th/9205027]`
  `[25] = A. Sen, Mod. Phys. Lett. A8 (1993) 2023 [hep-th/9303057]`
  `[26] = R. Kallosh, D. Kastor, T. Ortin and T. Torma, 'Supersymmetry and stationary solutions in dilaton axion gravity', SU-ITP-94-12 [hep-th/9406059]`
- 备注（**三点，对图极重要**）：
  1. ★ **"In the normalization convention that we have been using" 是本文关于归一化的唯一自述**，见 §1.2/§1.3。
  2. ★ **`M² ≥ Q⃗_R²/2` 这条界在本文里是 `status: physical-argument` 级的外部输入**（空间时超对称的推论，外包给三篇/一篇他文），**本文不给推导**。
     ⇒ 图里「极端黑洞饱和 BPS 界」这条边**不能**把 `sen-1995-bh-torus` 当作 BPS 界本身的来源，只能当作「Case II/III 饱和它」的来源。
  3. ★★ **`J ≠ 0` 必须排除**：原文明说带角动量的极端黑洞**不**饱和界、**不**超对称。**AMNV (22) 没有写这个前提。**

### E10 58 参数转动 dyonic 黑洞（算法，不是显式解）
- 位置：**§3, (3.1)–(3.34), pp.12–17** `[L1]`
- 类型：proposition
- 要点：`SL(2,R)` S-对偶 (3.2)–(3.5) 与 `O(7,23)` 合成给出 `O(8,24)` (3.19)–(3.20)；陪集 `(O(22,2)×O(6,2))/(O(22)×O(6)×SO(2))` (3.30) 为 **57** 参数，加 `m, a` 得 **59**；非奇异性要求 (3.31) 一条约束 ⇒ **58** 参数。
- 原文（逐字，p.17）："Thus although we have not explicitly shown that the solutions constructed this way are free from naked singularities, there is good reason to believe that this is indeed the case."
- 自称严格程度：**算法级 + "good reason to believe"**。⇒ 若图里要用 dyonic 解，**status 上限 `physical-argument`**。
- 备注：(3.10) `Q^{(a)}_{mag} = tan γ L_{ab}Q^{(b)}_{el}` —— 简单 `SL(2,R)` 转动只给出电磁荷**平行**的 dyon，这是要走 `O(8,24)` 的原因。

### E11 §4 结论：与基本弦态的"巧合"
- 位置：**§4, (4.1)–(4.5), pp.18–19** `[L1]`
- 类型：proposition（对照，非推导）
- (4.1)：`β → ∞` 极限下黑洞侧 `g_L → 0, g_R → 2`；(4.2)：弦态侧 `g_L = 2S_R/(S_L+S_R)`，`g_R = 2S_L/(S_L+S_R)`（"computed using a slight generalization of the work of ref.[3]"，**[3] = J. Russo and L. Susskind, hep-th/9405117**）。
- 逐字："From eqs.(2.38) - (2.40) we see that in the limit `β → ∞`, with `M`, `J` and `α` fixed, **`M² − Q⃗_R²/2 → 0`**. Thus these states saturate the Bogomol'nyi bound, which, in turn, implies that the right hand part of this state must be the lowest state in the Neveu-Schwarz (or Ramond) sector consistent with GSO projection[25]."
- (4.3) `A_s = 8πMη/cosh α = 8πη √(M² − Q⃗_L²/2)`；(4.4) `d_S ∼ exp(4π√n)`（`n` = 左移振子对 `mass²` 的总贡献）；**(4.5) `A_s ∝ ln d_S`**。
- 自称严格程度：**全节自称 "some amusing coincidences"**（§1 与 §4 各一次）。逐字（§4 开头）："we shall conclude this paper by pointing out some **amusing coincidences** between the properties of black holes and those of elementary strings in the extremal limit."
  并对 `β → ∞` 自陈："(Note that in this limit the solution develops **naked singularity**, but we shall **ignore this problem**.)"
- 备注（**两点，对 swampland 区很重要**）：
  1. ★ **本文没有杂化弦的质量公式**。AMNV (24) `M² = ½Q_R² + N_R = ½Q_L² + N_L − 1` **不出自本文**；本文只用到 (4.4) 的态密度 `exp(4π√n)`。
     ⇒ **图里 AMNV (24) 的来源不能挂 `sen-1995-bh-torus`。**
  2. ★ 本文**没有任何弱引力猜想形式**（无 `m ≤ qM_Pl`、无亚极端/超极端的"必须存在"型断言），与 `sen-1995-bh`（9504147）同（见该记录红线 (2)）。本文只做了**一次**方向性比较：`M² − Q⃗_L²/2` 与 `ln d_S` 成正比（(4.5)）。

### E12 论文自我定位（适用范围）
- 位置：**§1, pp.2–3；§4, p.18** `[L1]`
- 逐字（摘要）："We construct the general electrically charged, rotating black hole solution in the heterotic string theory compactified on a six dimensional torus … We also give an algorithm for constructing a 58 parameter rotating dyonic black hole solution in this theory … **This is the most general asymptotically flat black hole solution in this theory consistent with the no-hair theorem.**"
- 逐字（§1）："For non-rotating black holes, **some of** the extremal black holes saturate the Bogomol'nyi bound and hence have unbroken supersymmetry. But black holes carrying non-zero angular momentum never saturate Bogomol'nyi bound, and hence have no unbroken supersymmetry."
- 备注：★ 摘要里的 "most general … consistent with the no-hair theorem" 是**断言**，§3 自己承认非奇异性未证（E10）。

---

## 3. 未核实项清单

| # | 未核实项 | 影响 | 建议 |
|---|---|---|---|
| U1 | **v1/v2 与 v3 的差异**（本轮只读 v3） | 式号可能不同 | 所有 `loc` **写死 v3** |
| U2 | **期刊终页 440**（L0） | 只影响 bib | 可用 Crossref `10.1016/0550-3213(95)00063-X`（未查） |
| U3 | 参考文献 [1]–[32] 的**内容**（本记录只抄书目条目） | 「Bogomol'nyi 界出自 [24,25]」只是转述 | 若图里要 BPS 界节点，须单独抽 Gibbons–Hull PLB 109 (1982) 109 |
| U4 | **(2.29)–(2.37) 的独立复算** | 解本身的正确性 | 原文只说 "straightforward algebraic exercise"；若要 `rigorous` 必须 reviewer 独立复算 |
| U5 | **`M_Pl` 在 AMNV 里的定义**（`M_Pl² = 1/G_N` 还是 `1/(8πG_N)`） | 决定 §1.3 的质量侧能否闭合 | `arkani-hamed-2006.md` Q2 已记：AMNV 不给 |

---

## 4. 未解决的疑问

### Q1 — ★★ Sen ↔ AMNV 的电荷归一化桥不存在

见 §1.3。**两篇原文都不给换算**；Sen 的 `Q` 是连续参数、无格条件，AMNV 的 `Q` 受 (21) 约束。
→ **建议**：图里 `swampland.heterotic-t6-substates-below-extremality` 的推导必须把「黑洞侧 (22)(23)」与「弦谱侧 (24)(25)」之间的归一化一致性列入 `gaps`，并注明**这不是 Sen 的缺口，也不是 AMNV 的缺口，而是两篇拼接处的缺口**。

### Q2 — ★★ AMNV (22) 丢掉了 Sen 的两个前提

本文 (2.56)/(2.60) 成立的前提是：
1. **`a = 0`（非转动）** —— (2.52) 之前逐字 "For non-rotating black holes (`a = 0`)"；
2. **`m → 0` 且 `M` 固定的极端极限** —— (2.52)–(2.53) 之后逐字。
并且 E9 明说 **`J ≠ 0` 的极端黑洞不饱和 BPS 界**。
**AMNV §4 只写 "The extremal black hole solutions in this theory were constructed by Sen [8]"，两个前提都没写。**
→ **建议**：图节点 statement 必须带 `J = 0`；这是本轮抽取发现的**最实质的一条缺失前提**。

### Q3 — Case III (`α = β`) 该不该单独建卡？

本文 (2.64) `M² = ½Q⃗_L² = ½Q⃗_R²` 是 Case I 与 Case II 的**公共边界**，且 E9 说它也饱和 BPS 界。
AMNV 的 (22)(23) 用严格不等号 `Q_R² − Q_L² > 0` / `Q_L² − Q_R² > 0` 划分，**恰好把 `Q_L² = Q_R²` 排除在外**。
→ **建议**：不必单独建卡，但 `notes` 里要记「AMNV 的两式合起来不覆盖 `Q_L² = Q_R²`，该情形见 Sen (2.64)」。

### Q4 — 「`M` 按 `g_tt = −(1−2M/ρ)` 读出」这一步能标多高？

§1.2 的复算是四行代数（渐近展开 (2.30)+(2.37)）。按 `docs/STATUS_LEVELS.md` 的 lead 裁决（2026-09-10，前提完整 + 有限步初等推理 + reviewer 独立复核 ⇒ 可标 `rigorous`），**这一步可以请 reviewer 复核后标 rigorous**，但**必须 `inferred: true`**（原文没写）。

### Q5 — 本文与 `sen-1995-bh`（9504147）的关系

9504147 p.6 逐字把黑洞解归给本文（其 [7]），并在脚注说「ref.[7] constructed the solution for `g = 1`」。
**但本文全文没有 `g`（弦耦合）这个符号**（§1.1）。⇒ 「`g = 1`」是 **9504147 事后的追述**，不是本文的自述。
→ **建议**：`sources.bib` 里 `sen-1995-bh` 的 note 已记这条；本记录补充**本文侧的否定证据**：本文既不写 `g`，也不写 `α' = 16`（那是 9504147 的约定，外包给 hep-th/9402002）。**两篇的归一化体系不同，不得混用。**

---

## 5. 对图的建议

> 以下是**建议**，不是改动。researcher 只写 `literature/`（`literature/CLAUDE.md` 规则 4）。

### 5.1 `swampland.heterotic-t6-substates-below-extremality` 的来源该怎么改

| 需要的东西 | 现状 | 建议 |
|---|---|---|
| 极端黑洞解本身 | 只有 AMNV 的转述 | **加 `sen-1995-bh-torus` 作一手来源**，loc `§2, (2.29)–(2.37), pp.7–8（v3）` |
| `M² = ½Q_R²`（BPS） | AMNV (22) | loc `§2, (2.60), p.11（v3）`；**statement 必须带 `a = 0` 与 `α < β`（⟺ `Q_L² < Q_R²`）** |
| `M² = ½Q_L²`（非 BPS） | AMNV (23) | loc `§2, (2.56), p.10（v3）`；同样带 `a = 0` 与 `α > β` |
| BPS 界 `M² ≥ Q_R²/2` | 无 | **新建独立卡**，来源 `sen-1995-bh-torus` loc `§2, p.11（无式号）`，**但 `status` 只能 `physical-argument`，且 gaps 写「本文外包给 [24,25]，不给推导」** |
| 弦谱 `M² = ½Q_R² + N_R = ½Q_L² + N_L − 1` | AMNV (24) | ❌ **不要挂 `sen-1995-bh-torus`**（E11 备注 1） |
| 电荷格 `Q_L² − Q_R² ∈ 2Z` | AMNV (21) | ❌ **不要挂 `sen-1995-bh-torus`**（§1.1）；本文只提 `Λ` 存在，引 Narain [7] |

### 5.2 建议的新节点

| 建议 id | kind | status | 内容 | loc（v3） | 抽取条目 |
|---|---|---|---|---|---|
| `bh.heterotic-t6-general-rotating-charged-solution` | proposition | `physical-argument` | 28 参数转动带电黑洞解（`O(7,23)` 变换 Kerr） | `§2, (2.29)–(2.37), pp.7–8` | E4 |
| `bh.heterotic-t6-mass-charge-readout` | proposition | `physical-argument` | `M, J, Q^{(a)}, μ^{(a)}` 的表达式 | `§2, (2.38)–(2.41), p.8` | E5 |
| `bh.heterotic-t6-extremal-nonrotating-case1` | proposition | `physical-argument` | `α > β`：`M² = ½Q_L²`，`Q_R² < Q_L²`，不饱和 BPS | `§2, (2.54)–(2.57), p.10` | E8, E9 |
| `bh.heterotic-t6-extremal-nonrotating-case2` | proposition | `physical-argument` | `α < β`：`M² = ½Q_R²`，`Q_L² < Q_R²`，饱和 BPS | `§2, (2.58)–(2.61), pp.10–11` | E8, E9 |
| `bh.heterotic-t6-bps-bound` | proposition | `physical-argument` | `M² ≥ Q_R²/2`（Sen 的归一化约定下） | `§2, p.11（无式号）` | E9 |
| `bh.heterotic-t6-rotating-extremal-not-susy` | proposition | `physical-argument` | `J ≠ 0` 的极端黑洞从不饱和 BPS 界 | `§2, p.11（无式号）` | E9 |

**全部 `status` 上限是 `physical-argument`**：解本身是 "straightforward algebraic exercise"（不展示）、BPS 界外包、非奇异性 "good reason to believe"。

### 5.3 约定卡

- `conv.extremality-normalization`（`arkani-hamed-2006.md` Q2 已建议）**必须新增一行**：
  「`sen-1995-bh-torus`：不声明 `α'`/`G_N`/`M_Pl`；`M` 按 `g^E_tt = −(1−2M/ρ)` 读出（`inferred`），`Q` 按 `F_{ρt} → Q/ρ²` 读出；与 AMNV 的 `M_Pl = 1`/`α' = 4` **无换算**。」
- **不要**给本文挂 α' 约定卡（§1.4）。

### 5.4 Lean 岛候选（低优先，但干净）

**S1 —— 三种极端极限的代数一致性**
> 设 `M = (m₀/2)cosh β`、`|Q⃗_L| = (m₀/√2)cosh β`、`|Q⃗_R| = (m₀/√2)|sinh β|`（`n⃗, p⃗` 单位矢）。则 `M² = ½Q⃗_L²` 且 `Q⃗_R² = Q⃗_L² tanh²β ≤ Q⃗_L²`，等号当且仅当 `β → ∞`。Case II、III 同构。
- 来源：(2.55)(2.56)、(2.59)(2.60)、(2.63)(2.64)（全 L1）
- 严格性：原文直接给出，无推导
- Lean 化：`ℝ` 上的初等恒等式 + `tanh² ≤ 1`。**价值中等**：它把「哪一侧是 BPS」变成一条可判定的不等式，是 swampland 区第一条可机检的**物理量**关系（而非纯格论算术）。
- ⚠ 与 AMNV 的 `Q_L² − Q_R² ∈ 2Z` **不要合并成一条**：那是格论条件，来源不同（§5.1）。
