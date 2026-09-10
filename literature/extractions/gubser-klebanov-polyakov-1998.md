# 抽取记录：gubser-klebanov-polyakov-1998

- 文献：S. S. Gubser, I. R. Klebanov, A. M. Polyakov, "Gauge Theory Correlators from Non-Critical String Theory", hep-th/9802109; Phys. Lett. B428 (1998) 105-114.
- 抽取者：researcher agent
- 日期：2026-09-11
- 覆盖范围：全文（v2，PDF 15 页 = 标题页 + 正文 pp.1–14）

## §0 元信息与约定

**证据等级说明**：本文件所有带式号的条目均为 **L1**（arXiv **v2** PDF 逐页读图一手核实），除非条目内另行标注。

- arXiv 版本：**v1 1998-02-16；v2 1998-03-27**（"minor revisions, 1 reference added, the version to appear in Physics Letters B"）。本次读的是 **v2**（PDF 侧边栏印 `arXiv:hep-th/9802109v2 27 Mar 1998`）。**引式号必须写死 v2。**
- 报告号 PUPT-1767；发表版 Phys. Lett. B428 (1998) 105–114；封面日期 "February 1998"。
- 15 页 harvmac。第 1 页为标题/摘要页，正文页码 1–14。

### 约定（原文自己声明的）

- 号差：**Lorentz 号差 (−,+,+,+)**（式 (8)(10)(14) 均写 `−dt² + dx⃗²`）。
- 坐标：`z = R²/r`（p.4 正文），`z = R e^{−φ/R}`（式 (11)），AdS₅ 边界在 **`z → 0`**「far from the brane」，horizon 在 `z → ∞`。**注意：本文把截断边界放在 `z = R`（不是 `z = 0`）。**
- 指标约定（p.5 逐字）："Our convention is to let indices `m, n` run from 0 to `d` (that is, over the full `AdS_{d+1}` space) while `μ, ν` run only from 0 to `d−1` (ie excluding `z = x^d`)."
- `κ` 一律取**十维**引力常数（p.6 正文明说 "we take κ to be the ten-dimensional gravitational constant"）。
- 规范群：`U(N)`（p.2 逐字 "described by N = 4 supersymmetric `U(N)` gauge theory in 3 + 1 dimensions"）。但 p.1 引 't Hooft 时写的是 `SU(N)`——两处不同，见 §4。
- `R⁴ = N/(2π²T₃)`，`T₃ = √π/κ`（式 (9)）。
- 未定义 `α'` 归一化；`α'` 只以 `(α')²/R⁴ ∼ (g²_YM N)^{−1}` 的组合出现（p.4）。

## §1 主张强度（原文逐字）

原文用词分布（逐字核实）：

| 措辞 | 位置 | 逐字 |
|---|---|---|
| **suggest** | 摘要第 1 句 | "We **suggest** a means of obtaining certain Green's functions in 3+1-dimensional N = 4 supersymmetric Yang-Mills theory with a large number of colors via non-critical string theory." |
| **propose** | p.3 §1 末 | "We will **suggest** a potentially very rich and detailed means of analyzing the throat-brane correspondence: we **propose** an identification of the generating function of the Green's functions of the superconformal world-volume theory and the supergravity action in the near horizon background geometry." |
| **the basic idea is to identify** | p.4 §2 开头 | "**The basic idea is to identify** the generating functional of connected Green's functions in the gauge theory with the minimum of the supergravity action, subject to some boundary conditions at `z = R` and `z = ∞`:" → 式 (12) |
| **the claim that** | p.6 §2.2 | "Then the analogue of (12) is **the claim that**" → 式 (23) |
| **prediction** | 摘要末 / p.3 | "This is a new **prediction** about the strong coupling behavior of large N SYM theory."；"One new **prediction** that we will be able to extract this way is for the anomalous dimensions …" |

**关键判定**：全文（正文 pp.1–14）中，对源/算子对应本身**没有**使用 "conjecture" 一词，也**没有**使用 "duality"/"equivalence" 这类命题式措辞。最强的自称是 **"we propose an identification"** 与 **"the basic idea is to identify"**，配一处 **"the claim that"**。摘要用的是最弱的 **"we suggest a means of"**。
→ 主张强度自称层级：`suggest`（方法） < `propose an identification` / `identify`（核心命题） ≈ `the claim that`；**未自称 conjecture、未自称 theorem、未给证明**。

## §2 陈述抽取

### E1 源/算子对应的核心式（度规形式）
- 位置：p.4，式 **(12)**，紧接 §2 开头一句。
- 类型：proposition（原文当 identification 提出）
- 原文逐字（前导句 + 式）：
  > "The basic idea is to identify the generating functional of connected Green's functions in the gauge theory with the minimum of the supergravity action, subject to some boundary conditions at `z = R` and `z = ∞`:"
  >
  > `W[g_{μν}(x^λ)] = K[g_{μν}(x^λ)] = S[g_{μν}(x^λ, z)] .`  (12)
  >
  > "`W` generates the connected Green's functions of the gauge theory; `S` is the supergravity action on the `AdS` space; while `K` is the minimum of `S` subject to the boundary conditions. We have kept only the metric `g_{μν}(x^λ)` of the world-volume as an explicit argument of `W`."
- 文献自称的严格程度："The basic idea is to identify"（无证明，无 "conjecture" 字样）。
- 文献列出的依赖：类比 `c = 1` 矩阵模型 [15]；Brown–Henneaux [22] 用于边界条件与共形群。
- 备注：**注意这里两边都是"作用量/生成泛函"而不是"配分函数"。GKP 全文没有写成 `Z_CFT = Z_string`；右边是 *经典超引力作用量的极小值* `K`。** 这是与 Witten 表述的实质差别，见 witten-1998-ads.md 与 §5。

### E2 边界条件（度规版）
- 位置：p.4，式 **(13)**。
- 类型：definition
- 原文逐字：
  > "The boundary conditions subject to which the supergravity action `S` is minimized are"
  >
  > `ds² = (R²/z²)( g_{μν} dx^μ dx^ν + dz² ) + O(1)`   as `z → R` .  (13)
  >
  > "All fluctuations have to vanish as `z → ∞`."
- 备注：边界取在 **`z = R`**（有限截断，"near the place where the throat turns into the asymptotically flat space"，p.3），不是 `z → 0`。

### E3 式 (12) 的三条自列限制（原文自己写的 refinements）
- 位置：p.4，"A few refinements of the identification (12) are worth commenting on."
- 类型：文献自列假设
- 原文逐字要点：
  1. "it is the generator of **connected** Green's functions which appears on the left hand side because the supergravity action on the right hand side is expected to follow the **cluster decomposition principle**."
  2. "because classical supergravity is reliable only for a large number `N` of coincident branes, **(12) can only be expected to capture the leading large `N` behavior**. Corrections in `1/N` should be obtained as loop effects when one replaces the classical action `S` with an effective action `Γ`. This is sensible since the dimensionless expansion parameter `κ²/R⁸ ∼ 1/N²`."
  3. "since `(α')²/R⁴ ∼ (g²_YM N)^{−1}`, the string theoretic `α'` corrections to the supergravity action translate into gauge theory corrections proportional to inverse powers of `g²_YM N`."
  4. "the fact that there is **no covariant action for type IIB supergravity** does not especially concern us: to obtain `n`-point Green's functions one is actually considering the `n`^th variation of the action, which for `n > 0` can be regarded as the `(n−1)`^th variation of the covariant equations of motion."
- 备注：这四条是**原文自己列的**适用范围，不是抽取者推断。第 2 条是把 (12) 限定为**大 N 领头阶**的明确声明。

### E4 标量场版本的源/算子对应（GKP 的"字典"本体）
- 位置：p.6 §2.2，式 **(22)(23)**。
- 类型：proposition
- 原文逐字：
  > "Let us consider a coupling"
  >
  > `S_int = ∫ d⁴x φ(x^λ) O(x^λ)`  (22)
  >
  > "in the world-volume theory. If `φ` is the dilaton then according to [9] one would have `O = (1/(4g²_YM)) tr F² + …`. Then the analogue of (12) is **the claim that**"
  >
  > `W[φ(x^λ)] = K[φ(x^λ)] = S[φ(x^λ, z)]`  (23)
  >
  > "where `φ(x^λ, z)` is the unique solution of the equations of motion with `φ(x^λ, z) → φ(x^λ)` as `z → R`."
- **边界值的记号**：GKP **不用 `φ₀`**。边界值就写作 `φ(x^λ)`（无 `z` 宗量），由极限 `φ(x^λ, z) → φ(x^λ) as z → R` 定义。见 §4-Q1。
- 存在唯一性（原文自己给的论证，逐字）：
  > "Note that the existence and uniqueness of `φ` are guaranteed because the equation of motion is just the laplace equation on the curved space. (One could in fact compactify `x^λ` on very large `T⁴` and impose the boundary condition `φ(x^λ, z) = φ(x^λ)` at `z = R`. Then the determination of `φ(x^λ, z)` is just the **Dirichlet problem for the laplacian on a compact manifold with boundary**)."
- 备注：这是全文里最接近"数学陈述"的一处，但原文只给了一句话的理由，没有引定理。

### E5 正则性/视界条件（选 K 不选 I）
- 位置：p.6，式 (21) 后。
- 类型：假设
- 原文逐字：
  > "We have chosen the modified Bessel function `K₂(kz)` rather than `I₂(kz)` because the functions `K_ν(kz)` fall off exponentially for large `z`, while the functions `I_ν(kz)` grow exponentially. In other words, **the requirement of regularity at the horizon (far down the throat) tells us which solution to keep**."
- 备注：这条是 AdS/CFT 字典里"体内正则性"条件的原始出处之一。

### E6 两点函数（massless / dilaton）
- 位置：p.7，式 **(24)–(27)**。
- 类型：计算结果
- 原文逐字（式 26）：
  > `⟨O(k)O(q)⟩ = ∂²K/(∂λ_k ∂λ_q) = (2π)⁴ δ⁴(k+q) (N²/(16π²)) F`
  > `                 = −(2π)⁴ δ⁴(k+q) (N²/(64π²)) k⁴ ln(k²R²) + (analytic in k²)`  (26)
  > 其中 flux factor `F = [ φ̄_k (1/z³) ∂_z φ̄_k ]_{z=R} = −(1/4) k⁴ ln(k²R²) + (analytic in k²)`  (27)
- 计算方式（逐字）："To calculate the two-point function of `O` in the world-volume theory, we differentiate `K` **twice with respect to the coupling constants `λ_k`**."
- 脚注 2 逐字："The appearance of the logarithm here is analogous to the logarithmic scaling violation in the `c = 1` matrix model."
- 备注：**`ln(k²R²)` 中的 `R` 就是截断位置**；两点函数的非解析部分与截断无关，解析部分被丢弃。

### E7 中心荷 c = N²/4（应力张量两点函数）
- 位置：p.8，式 **(29)–(32)**。
- 类型：计算结果
- 原文逐字：
  > "Another interesting application of this analysis is to the two-point function of the stress tensor, which with the normalization conventions of [11] is"
  >
  > `⟨T_{αβ}(x) T_{γδ}(0)⟩ = (c/(48π⁴)) X_{αβγδ}(1/x⁴)` ,  (29)
  >
  > "where the central charge (the conformal anomaly) is `c = N²/4`"
  >
  > `⟨T_{xy}(k) T_{xy}(q)⟩ = −(2π)⁴δ⁴(k+q)(N²/(64π²)) k⁴ ln(k²R²) + (analytic in k²)` ,  (32)
  >
  > "which upon Fourier transform can be compared with (29) to give `c = N²/4`. In view of the conformal symmetry of both the supergravity and the gauge theory, the evaluation of this one component is **a sufficient test**."
- 备注：`S_int = ∫d⁴x (1/2) h^{μν} T_{μν}` 是式 (31)——这是"体场边界值 ↔ CFT 算子源"耦合的显式实例。

### E8 无质量态 → 零反常维数；ℓ 阶分波 → Δ = 4 + ℓ
- 位置：p.10，式 (37)(38) 后。
- 原文逐字：
  > "This formula indicates that the operator that couples to `ℓ`-th partial wave has dimension `4 + ℓ`." … "Thus, supergravity **predicts** that their non-perturbative dimensions equal their bare dimensions."
- p.12 逐字："By contrast, the vertex operators that couple to the massless string states do not acquire any anomalous dimensions. This has been checked explicitly for gravitons, dilatons and RR scalars [9, 10, 11], and **we believe this to be a general statement**." + "The absense [sic] of the anomalous dimensions is **probably** due to the fact that they are protected by SUSY."
- 备注：原文用 "we believe" / "probably"，不是 "we prove"。

### E9 ★ 维数–质量关系：**GKP 给的是 Δ = 2 + √(4 + (mR)²)，不是 Δ(Δ−d) = m²**
- 位置：p.10 式 **(41)**、p.11 式 **(45)**。
- 类型：计算结果
- 原文逐字：
  > "Analysis of the choice of wave function goes through as before, with `ℓ + 2` replaced by `ν`, where"
  >
  > `ν = √(4 + (mR)²)` .  (41)
  >
  > …（式 (44) 给出 2 点函数领头非解析项）…
  >
  > "This implies that the dimension of the corresponding SYM operator is equal to"
  >
  > `Δ = 2 + ν = 2 + √(4 + (mR)²)` .  (45)
- **★ 重要否定性核实**：**全文 14 页正文中没有出现 `Δ(Δ − d) = m²` 这个形式，也没有出现一般维数 `d` 的版本。** GKP 只给 `d = 4`（3-brane）的**解出形式** (45)，且质量以无量纲组合 `(mR)²` 出现（`R` = AdS 半径 = S⁵ 半径）。
  代数上 (45) 等价于 `Δ(Δ − 4) = (mR)²`，但**这一改写是抽取者做的，不是原文**。一般 `d` 的 `Δ(Δ−d) = m²`（`R=1` 单位）请引 Witten hep-th/9802150 式 (2.13)（见 witten-1998-ads.md E-W6）。
- 备注：GKP 的推导路径是"两点函数的领头非解析项 `(kR)^{2ν} R^{-4}` 的幂次 → 读出维数"（式 (44)），**不是**解渐近行为 `z^{d−Δ}` / `z^Δ` 的指数。

### E10 massive string states 的反常维数（本文的"新预言"）
- 位置：p.11，式 **(46)** 及其前后。
- 原文逐字：
  > `R⁴ = 2N g²_YM (α')²` ,  `(mR)² = 4 n g_YM √(2N)` （二者均为无编号行内式，`m² = 4n/α'`）
  >
  > "Using (45) we find that the spectrum of dimensions for operators that couple to massive string states is, for large `g_YM √N`,"
  >
  > `h_n ≈ 2 ( n g_YM √(2N) )^{1/2}` .  (46)
  >
  > "Equation (46) is **a new non-trivial prediction** of the string theoretic approach to large `N` gauge theory."
- 文献自列限制（脚注 4 逐字）："We do not expect this equation to be valid for arbitrarily large `n`, because application of linearized local effective actions to arbitrarily excited string states is questionable. However, we should be able to trust our approach for **moderately excited** states."
- 备注：摘要写作 `2(n g_YM √(2N))^{1/2}`、p.3 写作 `2√n (2 g²_YM N)^{1/4}`——两者代数恒等（都 = `2(2 n² g²_YM N)^{1/4}`），**不是笔误**。

### E11 原文自列的"潜在问题"（massive states 的 leg factors）
- 位置：p.12，"There is one potential problem with our treatment of massive states."
- 类型：文献自列缺口
- 原文逐字：
  > "The minimal linear equation (39) where higher derivative terms are absent may be true only for a particular field definition (otherwise corrections in positive powers of `α'∇²` will be present in the equation). Therefore, it is possible that there are **energy dependent leg factors** relating the operators `O` in (44) and the gauge theory operators of the form (3). We **hope** that these leg factors do not change our conclusion about the anomalous dimensions. However, to completely settle this issue we need to either find an exact sigma-model which incorporates all `α'` corrections or to calculate the 3-point functions of massive vertex operators."

### E12 结论节自列的未完成项
- 位置：p.12 §4 "Conclusions"。
- 原文逐字：
  > "There are many **unanswered questions** that we have left for the future. So far, we have considered the limit of large 't Hooft coupling, since we used the **one-loop sigma-model calculations** for all operators involved."
  > "**It is plausible that**, in addition to the global `O(2,4)` symmetry, this theory possesses the `O(2,4)` **Kac-Moody algebra**. If this is the case, then the sigma model is tractable with standard methods of conformal field theory."
- p.9 逐字（三点函数）："It now seems clear how to proceed to three-point functions … **We leave the details of such calculations for the future.**"
- p.9 逐字（超流多重态）："We leave these technical issues for the future, but with the expectation that they are **'bound to work'** based on supersymmetry."
- 备注：原文对 `O(2,4)` 一律写 **`O(2,4)`**（不是 `SO(2,4)`）；Maldacena hep-th/9711200 写的是 `SO(2,4)`。

### E13 本文如何描述 Maldacena（参考文献 [14]）
- 位置：p.2 末 – p.3 首。
- 原文逐字：
  > "The non-critical string and the D-brane approaches to 3+1 dimensional gauge theory have been **synthesized in [14]** by rescaling the 3-brane metric and taking the limit in which it has conformal symmetry, being the direct product `AdS₅ × S⁵`. This is exactly the confining string ansatz [4] with `a(φ) = e^{φ/R}` (7)"
- **★ 否定性核实**：GKP **既不称 [14] 为 conjecture，也不称之为 duality**；只说它"综合"了两条路线。GKP 也**没有**说自己是在"检验 Maldacena 猜想"。
- 备注：[14] = J. Maldacena, "The Large N limit of superconformal field theories and supergravity," hep-th/9711200（参考文献表逐字，**无期刊卷页**——写于 ATMP 发表前）。

## §3 未核实 / 无法核实项

1. **发表版（Phys. Lett. B428 (1998) 105–114）未核对**。本文件全部式号来自 **arXiv v2**。v1（1998-02-16）未读；arXiv 注记称 v2 相对 v1 是 "minor revisions, 1 reference added"，但**哪一条参考文献是新增的、式号是否移位，未核实**。→ 引式号必须写 `hep-th/9802109v2`。
2. **"全文无 conjecture / 无 duality（指称本文主张时）"这两条否定性结论**基于对 15 页 PDF 的**逐页读图**，非全文字符串检索（本环境无法对 PDF 做 grep）。置信度高但等级记为 **L1-neg**（读图否定），不是机器检索否定。
3. `X_{αβγδ}` 的具体形式（式 (30)）与 [11] 的归一化约定未追到 [11] 本身核实；`c = N²/4` 依赖 [11] 的约定，**换约定后数值会变**。
4. 式 (36)(43) 的 Bessel 展开系数未独立复算。
5. `h_n`（式 46）里 `h` 与 `Δ`（式 45）是否同一个量，原文未显式说明（正文说"spectrum of dimensions"，故应当是 `Δ`，但记号不统一）。
6. 参考文献 [23] 与 [25] 的 arXiv 号在参考文献表里**都印作 `hep-th/9605009`**（p.14 逐字）。至少有一处印错（Erdmenger–Osborn 与 Ferrara–Fronsdal 不可能同号），但**原文如此**，未去外部核实哪个是对的。

## §4 疑问

- **Q1（记号）**：任务给定的"`φ₀` 定义"在 GKP 里**不存在**。GKP 把边界值写作 `φ(x^λ)`（少一个宗量），靠 "`φ(x^λ, z) → φ(x^λ)` as `z → R`" 定义（式 (23) 后）。`φ₀` 是 **Witten** 的记号。若图里要用 `φ₀`，来源必须记 Witten，不能记 GKP。
- **Q2（边界位置）**：GKP 的边界在 **`z = R`**（有限截断，物理上是"喉部接上渐近平坦区的地方"），Witten 与后来的标准表述在 **共形边界 `z → 0`**。两者不是同一个边界条件方案；GKP 的 `ln(k²R²)` 里 `R` 就是这个截断。**图里若把 GKP 与 Witten 合并成一个节点会抹掉这个差别。**
- **Q3（左边是什么）**：GKP 式 (12)(23) 左边是**连通格林函数生成泛函 `W`**，右边是**经典超引力作用量的极小值 `K`**。这是"`W = S_on-shell`"型陈述。Witten 的 (2.11) 是**配分函数等式** `Z_CFT = Z_string`，两边都是 `Z` 不是 `W`；`W = −ln Z` 型的关系只在鞍点近似下把两者连起来。**GKP 全文没有配分函数陈述。**（与 [[maldacena-1997]] 抽取一致：配分函数陈述在 1998 年这两篇里才出现，且只在 Witten 篇里是 `Z = Z`。）
- **Q4（符号）**：GKP 写 `W = K = S`，没有负号；标准现代写法是 `W = −S_on-shell`（Euclid）或 `⟨e^{∫φ₀O}⟩ = e^{−S}`。GKP 用 Lorentz 号差、且式 (26) 是对 `K` 求二阶导直接得到 `⟨OO⟩`（不是 `−∂²W`）。**符号约定与现代教科书不一致，转成节点时必须显式记 conv。**
- **Q5（规范群）**：p.1 引 't Hooft 时写 `SU(N)` Yang-Mills（泛指），p.2 讲 D3-brane 世界体时写 `U(N)`。指同一件事时以 **`U(N)`** 为准（与 Maldacena 原文一致）。
- **Q6（"sufficient test" 的强度）**：p.8 "the evaluation of this one component is a sufficient test" —— 原文自认这是**检验**，不是推导。整篇里 (12)/(23) 始终是输入而非输出。

## §5 图建议

> researcher 只给建议，不写 `graph/`。curator 落卡前须先 `uv run stringgraph search gkp / dictionary / generating-functional` 查重。

### 建议节点 A：`holography.gkpw-dictionary`（独立卡）

- **建议 status：`conjecture`**。
  理由（严格按原文强度）：原文对该式的最强自称是 "we **propose** an identification"（p.3）/ "The basic idea is to **identify**"（p.4）/ "the **claim** that"（p.6）。全文**没有任何推导**把 (12)(23) 从更基本的东西导出；(26)(32) 与吸收截面的一致是**事后检验**（原文自称 "a sufficient test"）。
  - 不建议 `physical-argument`：`physical-argument` 应留给"有推导但不严格"的情形；GKP 这里是**直接假设**。
  - 若 curator 认为"由 D3-brane 世界体耦合 (5)(6)(22)(31) 提供了启发式推导"而选 `physical-argument`，请在 `notes` 里写明这是编者判断，因为**原文没有这样自我描述**。
- **建议把 GKP 与 Witten 拆成两条独立陈述**（或一条陈述 + 两条推导），理由见 Q2/Q3：
  - `holography.gkpw-dictionary`（若做成单卡）：文本应写成"体场边界值 = CFT 算子的源"这一**定性字典**，两篇都支持。
  - GKP 特有的量化形式 `W[φ] = K[φ] = S[φ(x,z)]`（截断边界 `z=R`、生成泛函 = on-shell 作用量）应作为**该卡的一条推导**，`sources: gubser-klebanov-polyakov-1998, eq (12),(23)`。
  - Witten 的 `Z_CFT[φ₀] = Z_string[φ|_∂ = φ₀]`（共形边界、配分函数）作为**另一条独立推导**。两条推导的假设不同，不可互相替代。
- **`depends_on` 候选（均可在 GKP 里找到对应论证，不需 `inferred`）**：
  - AdS₅×S⁵ 是 N 个重合 D3-brane 的近视界几何（式 (8)(9)(10)(11)，p.3–4）
  - 大 N 经典超引力可靠（E3-2，`κ²/R⁸ ∼ 1/N²`）
  - 大 't Hooft 耦合 / `α'` 修正受 `(g²_YM N)^{−1}` 压低（E3-3）
  - 视界正则性选解条件（E5）
  - 世界体耦合 `S_int = ∫ φ O`（式 (22)(31)），依赖 [9,10,11] 的顶点算子辨认
- **不应挂的依赖**：不要把"Maldacena 猜想"作为 GKP 字典的 `depends_on` 并标为原文依据——原文只在 p.2–3 说 [14]"synthesized"了两条路线（E13），**没有**把 (12) 建立在 [14] 之上。若要连边，须标 `inferred: true`。

### 建议节点 B：`holography.dimension-mass-relation-ads5`（或并入现有维数-质量卡）

- 文本必须写 **`Δ = 2 + √(4 + (mR)²)`（d = 4）**，`sources: gubser-klebanov-polyakov-1998, eq (45) (v2)`。
- **不要**把 `Δ(Δ − d) = m²` 的来源记成 GKP（E9 的否定性核实）。一般 `d` 版本记 Witten。
- status：`physical-argument`（有明确推导链：式 (39)→(40)→(41)→(43)→(44)→(45)，但依赖节点 A 的字典与线性化有效作用量，且原文自列 leg-factor 缺口 E11）。

### 与 `ads5-cft4-duality-v2` 的关系：判 **独立假设**（不是"精确化"）

- **原文措辞证据**：GKP 从未说自己在"使 Maldacena 的对偶变精确 / 变成可计算的形式"。它说的是"我们 **suggest a means of analyzing** the throat-brane correspondence"（p.3）——提供**分析手段**，且 [14] 只被描述为"synthesized"两条路线（E13）。GKP 全文不含 "conjecture"，也没有复述 Maldacena 的对偶陈述。
- **逻辑上**（抽取者判断，标为推断）：即使承认"两个理论对偶"，也**推不出**"生成泛函 = on-shell 超引力作用量"与"哪个体场耦合哪个算子"。后者是附加的、可独立证伪的假设。
- **建议图结构**：`holography.gkpw-dictionary` **不**从 `ads5-cft4-duality-v2` 派生（不加 `depends_on`），而是与之**并列**；再新建一条组合节点（如"AdS/CFT 可计算框架"）同时依赖两者。这样 `stringgraph why` 才能正确显示"某个超引力算出来的关联函数压在**两个**独立猜想上"，而不是一个。
- 若 curator 采取相反判断（视为"精确化"，即 dictionary 依赖 duality），请在 `notes` 明记这是编者判断并引 §5 本节，因为**原文措辞不支持**。



