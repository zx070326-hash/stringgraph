# 抽取记录：maldacena-1997

- 文献：J. Maldacena, *The Large N Limit of Superconformal field theories and supergravity*, arXiv:**hep-th/9711200**；发表版 Adv. Theor. Math. Phys. **2** (1998) 231–252。
- 抽取者：researcher agent
- 日期：2026-09-11
- 覆盖范围：**全文**（Abstract、§1 General idea、§2 D3 branes、§3 M5/M2、§4 D1+D5、§5、§6 Discussion、§7 Appendix、References）
- 目标 area：`holography`（现有占位节点 `duality.ads-cft`、`duality.ads-cft--via-decoupling-limit`）

---

## 0. 核实方法与证据等级（必读）

### 0.1 本轮实际读到什么

| 项 | 内容 |
|---|---|
| 获取路线 | `WebFetch https://arxiv.org/pdf/hep-th/9711200` → PDF 落盘 → `Read(pages=1-22)` **逐页读页图** |
| 拿到的版本 | 页边条纹逐字为 `arXiv:hep-th/9711200v3  22 Jan 1998`；页眉报告号 `HUTP-97/A097` |
| 页数 | PDF 共 22 页 = 标题页 + 正文编号 p.1–p.18 + References p.19–p.21 |
| 缺失 | **无**。全文每一页都读到了 |

> **PDF 页码 ↔ 论文页码的换算：论文 p.N = PDF 第 N+1 页。** 本文件所有「位置」栏给的是**论文页码**（即页脚印的数字）。

### 0.2 证据等级（沿用 `polchinski-1998-v1.md` §5.0 的 L1–L4 定义，但含义在这里更强）

- **L1** = 抽取者本轮**亲自逐页读到 arXiv v3 的页图**。
  ⚠ 与 `polchinski-1998-v1` 不同：那里 L1 只保证「Schrans/Headrick 这么写」；**这里 L1 直接就是原文**，因为读的是作者本人的 preprint。故本文件的「原文陈述」栏凡标 **[逐字]** 的都是**真正的逐字引用**。
- **L2** = 只从上下文交叉引用推知（本文件仅用于个别脚注编号）。
- **L3** = 第三方转述。**本文件没有 L3 条目。**
- **L4** = 检索后端复述，不入库。

**标注体例**：
- **[逐字]** = 英文原句照抄（含斜体/引号），可直接进图节点的 `sources` 引文。
- **[转述]** = 抽取者中文转述，不得当作文献措辞使用。
- **[抽取者代数]** = 抽取者对原文公式做的纯代数改写，**原文没有显式写出这一步**。curator 引用时必须标 `inferred: true`。

### 0.3 版本风险（务必读）

1. **本轮读的是 arXiv v3，不是 ATMP 发表版。** `sources.bib` 里登记的是 ATMP 2 (1998) 231–252。两者式号是否一致**本轮未核对**（见 Q1）。
2. **v3 与更早版本有实质差异，作者自己说了。** 致谢逐字：
   > "My apologies to everybody I did not cite in the previous version of this paper. I thank the authors of [64] for pointing out a sign error."

   （[64] = R. Kallosh, J. Kumar and A. Rajaraman, hep-th/9712073）

   → **v1/v2 的某处有符号错误，v3 已改。** 若图里要引某个具体式子，必须写死版本号 `v3`。

---

## 1. 约定

### 1.1 该文自述/可从正文读出的约定

| 项 | 本文的取法 | 位置与等级 |
|---|---|---|
| 时空号差 | **mostly-plus `(−,+,+,…,+)`**。证据两处：(4.2) 正文「`dx²_∥ = −dt² + dx²`」；附录 (7.1) 的嵌入空间 `η = Diag(−1,−1,1,⋯,1)`（两个时间方向是双曲面嵌入的常规做法，物理号差仍是 mostly-plus） | p.11、p.17，**L1** |
| `α'` | **显式保留**，不设为 1；退耦极限就是 `α' → 0` | (2.1)，p.2，**L1** |
| 弦耦合记号 | 写作 **`g`**（不写 `g_s`）。footnote 3 逐字：「We choose conventions where `g → 1/g` under S-duality.」 | p.3 脚注 3，**L1** |
| 11 维 Planck 长度 | footnote 9 逐字：「In our conventions the relation of the Planck length to the 11 dimensional Newton constant is `G_N^11 = 16π⁷ l_p⁹`.」 | p.9 脚注 9，**L1** |
| 规范群 | **`U(N)`，不是 `SU(N)`**。全文一律写 `U(N)`（§2 的节标题就是「D3 branes or `N=4 U(N)` super-Yang-Mills in d=3+1」） | §2 标题、p.2、p.4，**L1** |
| R 对称群 | 写 `SO(6) ∼ SU(4)`；footnote 2 逐字：「The representation includes objects in the spinor representations, so we should be talking about `SU(4)`, we will not make this, or similar distinctions in what follows.」 | p.2 脚注 2，**L1** |
| 共形群写法 | **`SO(2,4)`**（第一个指标是 2），不是 `SO(4,2)` | p.2、p.8，**L1** |
| 径向变量 | `U ≡ r/α'`（D3 情形），量纲是质量 | (2.1)，p.2，**L1** |

### 1.2 与 `graph/conventions/` 的对照

| 图里的约定 | 是否适用 | 说明 |
|---|---|---|
| `conv.metric-mostly-plus` | **适用**（L1 证据见上表） | 与 Polchinski 同号差，无需换算 |
| `conv.alpha-prime-regge` | **部分适用**。本文用 `α'` 作弦长尺度，但**全文没有出现「`T = 1/(2πα')`」或开弦质量壳 `α'm² = N − a`**，所以该约定卡片里的两条具体内容在本文中无对应 | 建议 curator 为全息节点只声明「α' 显式保留」这一部分，或新建一条更弱的 α' 约定 |
| （无）弦耦合归一化约定 | **缺失** | 本文的 `g` 与「`g_s`」是否同一归一化，本文没说。**耦合字典的数值因子问题见 E16 与 Q2，这是本次抽取最重要的发现之一** |

---

## 2. 陈述

编号 `E<n>`。转成节点时在节点 `notes` 写 `from: maldacena-1997#E<n>`。

---

### E1 摘要：论文自己给出的三级主张强度（**meta 条目，不要直接建节点**）

- 位置：Abstract，标题页 — **L1**
- 类型：meta（主张强度记录）
- 原文陈述 **[逐字，全文照抄]**：
  > "We show that the large `N` limit of certain conformal field theories in various dimensions include in their Hilbert space a sector describing supergravity on the product of Anti-deSitter spacetimes, spheres and other compact manifolds. This is shown by taking some branes in the full M/string theory and then taking a low energy limit where the field theory on the brane decouples from the bulk. We observe that, in this limit, we can still trust the near horizon geometry for large `N`. The enhanced supersymmetries of the near horizon geometry correspond to the extra supersymmetry generators present in the superconformal group (as opposed to just the super-Poincare group). The 't Hooft limit of 3+1 `N = 4` super-Yang-Mills at the conformal point is shown to contain strings: they are IIB strings. **We conjecture that** compactifications of M/string theory on various Anti-deSitter spacetimes **is dual to** various conformal field theories. This leads to a new proposal for a definition of M-theory which could be extended to include five non-compact dimensions."
- 文献自称的严格程度：**摘要本身就把主张分成两级**：
  1. 「**We show that** … include in their Hilbert space a sector describing **supergravity** …」——「含超引力扇区」是**主张已证**（在物理论证的意义上）；
  2. 「**We conjecture that** compactifications of M/string theory … **is dual to** various conformal field theories」——**完整对偶是猜想**；
  3. 中间还有一级：「We **observe** that … we can still trust the near horizon geometry for large N」「is **shown** to contain strings」。
- 文献列出的依赖：无（摘要）。
- 备注：**这一条是整份抽取里对图 status 最关键的证据。**「超引力扇区包含」与「完整弦论对偶」在原文里是**不同强度的两句话**，图里必须拆成两个节点（见 §5 建议）。

---

### E2 一般构造：退耦极限得到膜上场论

- 位置：§1 General idea，p.1 — **L1**
- 类型：definition（构造方法）
- 原文陈述 **[逐字]**：
  > "In this paper we consider theories that are obtained by decoupling theories on branes from gravity. We focus on conformal invariant field theories but a similar analysis could be done for non-conformal field theories. The cases considered include `N` parallel D3 branes in IIB string theory and various others. We take the limit where the field theory on the brane decouples from the bulk. At the same time we look at the near horizon geometry and **we argue** that the supergravity solution can be trusted as long as `N` is large. `N` is kept fixed as we take the limit."
- 文献自称的严格程度：「**we argue**」（对「超引力解可信」这一步）。
- 文献列出的依赖：「The approach is similar to that used in [1] to study the NS fivebrane theory [2] at finite temperature.」（[1] = J. Maldacena and A. Strominger, hep-th/9710014；[2] = N. Seiberg, PLB **408** (1997) 98, hep-th/9705221）
- 备注：注意「**N is kept fixed as we take the limit**」——退耦极限本身是 `α'→0` 下的固定 N 极限，**'t Hooft 极限是后来另外取的**（见 E21）。

---

### E3 近视界几何的一般形状与 1/N 曲率

- 位置：§1，p.1 — **L1**
- 类型：proposition
- 原文陈述 **[逐字]**：
  > "The supergravity solution typically reduces to `p + 2` dimensional Anti-deSitter space (`AdS_{p+2}`) times spheres (for D3 branes we have `AdS_5 × S^5`). The curvature of the sphere and the `AdS` space in Planck units is a (positive) power of `1/N`. Therefore the solutions can be trusted as long as `N` is large."
- 文献自称的严格程度：陈述句，无「prove」类措辞；理由是曲率的 `1/N` 幂次。
- 文献列出的依赖：无显式引用。
- 备注：`p+2` 与球的具体维数逐个 case 在 §2–§5 给出。

---

### E4 有限温度 ↔ AdS 黑洞；Hilbert 空间包含 AdS 激发

- 位置：§1，p.1 — **L1**
- 类型：proposition
- 原文陈述 **[逐字]**：
  > "Finite temperature configurations in the decoupled field theory correspond to black hole configurations in `AdS` spacetimes. These black holes will Hawking radiate into the `AdS` spacetime. **We conclude that** excitations of the `AdS` spacetime are included in the Hilbert space of the corresponding conformal field theories."
- 文献自称的严格程度：「**We conclude that**」。
- 文献列出的依赖：无显式引用（论证在 §2 展开，见 E13–E15）。
- 备注：这是 E1 第 (1) 级主张的一般版本。

---

### E5 一般猜想的原文表述 + 明确承认边界条件未定

- 位置：§1，p.1 — **L1**
- 类型：proposition（猜想）
- 原文陈述 **[逐字]**：
  > "A theory in `AdS` spacetime is not completely well defined since there is a horizon and it is also necessary to give some boundary conditions at infinity. However, local properties and local processes can be calculated in supergravity when `N` is large if the proper energies involved are much bigger than the energy scale set by the cosmological constant (and smaller than the Planck scale). **We will conjecture that** the full quantum M/string-theory on `AdS` space, plus suitable boundary conditions **is dual to** the corresponding brane theory. **We are not going to specify the boundary conditions in `AdS`, we leave this interesting problem for the future.**"
- 文献自称的严格程度：「**We will conjecture that**」；且**自陈未完成项**：边界条件未指定。
- 文献列出的依赖：无。
- 备注：**图里最重要的「承认的假设/缺口」条目之一。**「plus suitable boundary conditions」在原文里是猜想陈述的组成部分，不能省略。

---

### E6 超对称匹配（一般陈述）

- 位置：§1，p.1 — **L1**
- 类型：proposition
- 原文陈述 **[逐字]**：
  > "The supersymmetries of both theories agree, both are given by the superconformal group. The superconformal group has twice the amount of supersymmetries of the corresponding super-Poincare group [3,4]. This enhancement of supersymmetry near the horizon of extremal black holes was observed in [5,6] precisely by showing that the near throat geometry reduces to `AdS×`(spheres)."
- 文献自称的严格程度：陈述句 + 引用他处（[3,4] 给超共形代数，[5,6] 给近视界超对称增强）。
- 文献列出的依赖（外部）：
  - [3] R. Haag, J. Lopuszanski and M. Sohnius, Nucl. Phys. **B88** (1975) 257
  - [4] W. Nahm, Nucl. Phys. **B135** (1978) 149
  - [5] G. Gibbons, Nucl. Phys. **B207** (1982) 337；R. Kallosh and A. Peet, Phys. Rev. **D46** (1992) 5223, hep-th/9209116；S. Ferrara, G. Gibbons, R. Kallosh, Nucl. Phys. **B500** (1997) 75, hep-th/9702103
  - [6] G. Gibbons and P. Townsend, Phys. Rev. Lett. **71** (1993) 5223, hep-th/9307049
  - 另 [7,8,9,10,11,12,13] 被一并引作「`AdS` spaces (and branes in them) were extensively considered in the literature […], includding the connection with the superconformal group.」（"includding" 系原文排印错误，照抄）
- 备注：⚠ **全文没有出现「`PSU(2,2|4)`」这个符号**（抽取者逐页读完 22 页确认）。原文只说「the superconformal group」，并把「The precise superconformal algebra was computed in [3]」指给 Haag–Lopuszanski–Sohnius。见 Q3。

---

### E7 D3 退耦极限的定义式

- 位置：§2，**eq. (2.1)**，p.2 — **L1**
- 类型：definition
- 原文陈述 **[逐字，含公式]**：
  > "We start with type IIB string theory with string coupling `g`, which will remain fixed. Consider `N` parallel D3 branes separated by some distances which we denote by `r`. For low energies the theory on the D3 brane decouples from the bulk. It is more convenient to take the energies fixed and take
  >
  > `α' → 0 ,        U ≡ r/α' = fixed .`   **(2.1)**
  >
  > The second condition is saying that we keep the mass of the stretched strings fixed. As we take the decoupling limit we bring the branes together but the the Higgs expectation values corresponding to this separation remains fixed."
- 文献自称的严格程度：定义/取极限，无严格性声明。
- 文献列出的依赖：无。
- 备注：`g` 固定、`N` 固定；(2.1) **不含**任何大 N 条件。原文的 "the the" 是排印重复，照抄。

---

### E8 极限中的世界体理论与其对称群

- 位置：§2，p.2 — **L1**
- 类型：proposition
- 原文陈述 **[逐字]**：
  > "The resulting theory on the brane is four dimensional `N = 4 U(N)` SYM. Let us consider the theory at the superconformal point, where `r = 0`. The conformal group is `SO(2,4)`. We also have an `SO(6) ∼ SU(4)` R-symmetry that rotates the six scalar fields into each other. The superconformal group includes twice the number of supersymmetries of the super-Poincare group: the commutator of special conformal transformations with Poincare supersymmetry generators gives the new supersymmetry generators. The precise superconformal algebra was computed in [3]. **All this is valid for any `N`.**"
- 文献自称的严格程度：陈述句；对称代数引 [3]。
- 文献列出的依赖：[3]（Haag–Lopuszanski–Sohnius）。
- 备注：**「All this is valid for any N.」是原文对「对称性匹配这一支不需要大 N」的明确声明**，与 E12 的 `gN ≫ 1` 形成对照。图里「对称性匹配」与「超引力近似」必须是两条独立的边。

---

### E9 D3 膜超引力解

- 位置：§2，**eq. (2.2)**，p.3 — **L1**
- 类型：proposition（引自他处的解）
- 原文陈述 **[逐字，含公式]**：
  > "Now we consider the supergravity solution carrying D3 brane charge [14]
  >
  > `ds² = f^{−1/2} dx²_∥ + f^{1/2}(dr² + r² dΩ²_5) ,`
  > `f = 1 + 4πgNα'²/r⁴ ,`   **(2.2)**
  >
  > where `x_∥` denotes the four coordinates along the worldvolume of the three-brane and `dΩ²_5` is the metric on the unit five-sphere. The self dual five-form field strength is nonzero and has a flux on the five-sphere."
- 文献自称的严格程度：**引用他处**——[14] = G. Horowitz and A. Strominger, Nucl. Phys. **B360** (1991) 197。
- 文献列出的依赖：[14]。
- 备注：**`R⁴ = 4πgNα'²` 这个组合首次出现在这里**（作为调和函数的系数），此时论文尚未把它与 `g_YM` 联系。

---

### E10 近视界退耦极限的度规 = AdS_5 × S^5

- 位置：§2，**eq. (2.3)**，p.3 — **L1**
- 类型：proposition
- 原文陈述 **[逐字，含公式]**：
  > "Now we define the new variable `U ≡ r/α'` and we rewrite the metric in terms of `U`. Then we take the `α' → 0` limit. Notice that `U` remains fixed. In this limit **we can neglect the 1 in the harmonic function (2.2)**. The metric becomes
  >
  > `ds² = α'[ U²/√(4πgN) dx²_∥ + √(4πgN) dU²/U² + √(4πgN) dΩ²_5 ] .`   **(2.3)**
  >
  > This metric describes five dimensional Anti-deSitter (`AdS_5`) times a five-sphere."
- 文献自称的严格程度：直接计算，无严格性声明；关键步骤是「neglect the 1 in the harmonic function」。
- 文献列出的依赖：E7 (2.1)、E9 (2.2)；脚注 4「See the appendix for a brief description of `AdS` spacetimes.」→ E48。
- 备注：**这是「近视界几何 = AdS_5×S^5」的落点式号。** 图里 `duality.ads-cft--via-decoupling-limit` 的 `loc` 应精确到 **(2.1)–(2.3)**，不是笼统的「§2」。

---

### E11 半径字典（球半径 = AdS 半径；Planck 单位下 ∝ N^{1/4}）

- 位置：§2，(2.3) 之后，p.3 — **L1**
- 类型：proposition
- 原文陈述 **[逐字]**：
  > "We see that there is an overall `α'` factor. The metric remains constant in `α'` units. **The radius of the five-sphere is `R²_sph/α' = √(4πgN)`, and is the same as the "radius" of `AdS_5`** (as defined in the appendix). In ten dimensional Planck units they are both proportional to `N^{1/4}`. The radius is quantized because the flux of the 5-form field strength on the 5 sphere is quantized."
- 文献自称的严格程度：陈述句。
- 文献列出的依赖：E10、E48（附录的「radius」定义）。
- 备注 **[抽取者代数]**：`R²_sph/α' = √(4πgN)` 平方后即 **`R⁴/α'² = 4πgN`**。这一形式**原文在 (2.3) 附近没有直接写**，但**在 p.6 明确写出**：「including the fact that `R̃⁴ = 4πgN`」（见 E20）。故 `R⁴/α'² = 4πgN` 有原文背书，等级 L1。
  ⚠ **但 `4πgN` 是否等于 't Hooft 耦合 `λ = g²_YM N`，取决于 `g_YM²` 与 `g` 的关系，见 E16 与 Q2 —— 在本文自己的约定下它们相差因子 2。**

---

### E12 超引力可信条件

- 位置：§2，**eq. (2.4)** + 脚注 5，p.3 — **L1**
- 类型：proposition（有效性判据）
- 原文陈述 **[逐字，含公式与脚注]**：
  > "We can trust the supergravity solution when
  >
  > `gN ≫ 1 .`   **(2.4)**
  >
  > When `N` is large we have approximately ten dimensional flat space in the neighborhood of any point. Note that in the large `N` limit the flux of the 5 form field strength per unit Planck (or string) 5-volume becomes small."
  >
  > 脚注 5 **[逐字]**：「In writing (2.4) we assumed that `g ≤ 1`, if `g > 1` then the condition is `N/g ≫ 1`. In other words we need large `N` , not large `g`.」
- 文献自称的严格程度：判据式陈述。
- 文献列出的依赖：E10、E11。
- 备注：**脚注 5 是「大 N 而非强耦合」的原文背书**。curator 若要写「超引力近似的有效范围」节点，`gN ≫ 1`（`g ≤ 1` 时）与 `N/g ≫ 1`（`g > 1` 时）必须一起写。

---

### E13 近极端黑 D3 膜解

- 位置：§2，**eq. (2.5)**，p.3 — **L1**
- 类型：proposition
- 原文陈述 **[逐字，含公式]**：
  > "Now consider a near extremal black D3 brane solution in the decoupling limit (2.1). We keep the energy density on the brane worldvolume theory (`μ`) fixed. We find the metric
  >
  > `ds² = α'{ U²/√(4πgN) [−(1 − U₀⁴/U⁴)dt² + dx²_i] + √(4πgN) dU²/(U²(1 − U₀⁴/U⁴)) + √(4πgN) dΩ²_5 } ,`
  > `U₀⁴ = (2⁷/3) π⁴ g² μ`   **(2.5)**
- 文献自称的严格程度：直接计算。
- 文献列出的依赖：E7 (2.1)、E9 (2.2)。
- 备注：这是「有限温度 ↔ AdS 黑洞」在 D3 情形的显式解。`U₀` 在 `α'→0` 下有限（见 E14）。

---

### E14 α'→0 下理论不塌缩的论证（proper energy 论证）

- 位置：§2，p.4 — **L1**
- 类型：proposition（论证）
- 原文陈述 **[逐字]**：
  > "We see that `U₀` remains finite when we take the `α' → 0` limit. The situation is similar to that encountered in [1]. Naively the whole metric is becoming of zero size since we have a power of `α'` in front of the metric, and we might incorrectly conclude that we should only consider the zero modes of all fields. However, energies that are finite from the point of view of the gauge theory, lead to proper energies (measured with respect to proper time) that remain finite is in `α'` units (or Planck units, since `g` is fixed). More concretely, an excitation that has energy `ω` (fixed in the limit) from the point of view of the gauge theory, will have proper energy `E_proper = (1/√α') · ω(gN4π)^{1/4}/U`. This also means that the corresponding proper wavelengths remain fixed. In other words, the spacetime action on this background has the form `S ∼ (1/α'⁴)∫d^10 x √G R + ⋯`, so we can cancel the factor of `α'` in the metric and the Newton constant, leaving a theory with a finite Planck length in the limit. Therefore we should consider fields that propagate on the `AdS` background."
- 文献自称的严格程度：物理论证（「Naively … we might incorrectly conclude … However …」）。
- 文献列出的依赖：[1]（Maldacena–Strominger hep-th/9710014）、E13。
- 备注：⚠ 原文「remain finite **is** in `α'` units」的 "is" 系排印错误，照抄。**这一步是整个退耦论证里最容易被后人跳过的一环**；curator 若建「退耦极限良定」节点，这是它的核心内容。

---

### E15 「Hilbert 空间包含 IIB 超引力态」——原文的 "we conclude" 级主张

- 位置：§2，p.4 — **L1**
- 类型：proposition
- 原文陈述 **[逐字；斜体为原文斜体]**：
  > "Since the Hawking temperature is finite, there is a flux of energy from the black hole to the `AdS` spacetime. Since `N = 4` d=4 `U(N)` SYM is a unitary theory **we conclude that**, for large `N`, *it includes in its Hilbert space the states of type IIB supergravity on* `(AdS_5 × S_5)_N`, where subscript indicates the fact that the "radii" in Planck units are proportional to `N^{1/4}`. In particular the theory contains gravitons propagating on `(AdS_5 × S_5)_N`. When we consider supergravity on `AdS_5 × S_5`, we are faced with global issues like the presence of a horizon and the boundary conditions at infinity. It is interesting to note that the solution is nonsingular [15]. The gauge theory should provide us with a specific choice of boundary conditions. It would be interesting to determine them."
- 文献自称的严格程度：「**we conclude that**」（**不是** conjecture）。被原文点名的前提：**幺正性 + 有限 Hawking 温度 + 大 N**。
- 文献列出的依赖：E12（大 N 判据）、E13（近极端解）、E14（proper energy）；[15] = G. Gibbons, G. Horowitz and P. Townsend, hep-th/9410073。
- 备注：**这是 E1 第 (1) 级主张在 D3 情形的落点。** 注意原文这里写的是 **supergravity 的态**（不是完整弦论），且**明确说边界条件仍待定**。

---

### E16 对偶猜想的原文本体（**图 status 的决定性条目**）

- 位置：§2，p.4 — **L1**
- 类型：proposition（猜想）
- 原文陈述 **[逐字；斜体为原文斜体]**：
  > "We have started with a quantum theory and we have seen that it includes gravity so it is natural to think that this correspondence goes beyond the supergravity approximation. **We are led to the conjecture that** *Type IIB string theory on* `(AdS_5 × S^5)_N` *plus some appropriate boundary conditions (and possibly also some boundary degrees of freedom) is dual to* `N=4` *d=3+1* `U(N)` *super-Yang-Mills.* The SYM coupling is given by the (complex) IIB string coupling, more precisely
  >
  > `1/g²_YM + i θ/8π² = (1/2π)(1/g + i χ/2π)`
  >
  > where `χ` is the value of the RR scalar."
- 文献自称的严格程度：**「We are led to the conjecture that」**。逐字关键词是 **conjecture**——**不是** "we propose"，**也不是** "we argue"。（"we argue" 出现在 E2，指的是「超引力解可信」这一步，不是对偶本身。）
- 文献列出的依赖：E15（超引力级结论）；且「it is natural to think that this correspondence goes beyond the supergravity approximation」**明说这一步是外推**。
- 备注（三点，全部对图有直接影响）：
  1. **规范群是 `U(N)`，不是 `SU(N)`。** 现有节点 `duality.ads-cft` 写的 `SU(N)` **不是 Maldacena 原文的表述**。
  2. **猜想陈述里含两个限定语：「plus some appropriate boundary conditions」与「(and possibly also some boundary degrees of freedom)」。** 图节点不能省。
  3. ⚠ **耦合字典的数值因子。** 原文只给上面这一个复耦合关系。**[抽取者代数]**：取实部得 `1/g²_YM = 1/(2πg)`，即 **`g²_YM = 2πg`**；代入 E11 得 `R⁴/α'² = 4πgN = **2 g²_YM N**`。**这与今天教科书常写的 `g²_YM = 4πg_s`、`R⁴/α'² = g²_YM N = λ` 相差因子 2。** 本文**没有**写 `g²_YM = 4πg`，**也没有**用符号 `λ` 表示 't Hooft 耦合（见 Q2、Q4）。
  4. ⚠ 虚部同样对不上常见写法：本文给 `θ/8π² = χ/(4π²)`，即 `θ = 2χ`；而常见写法 `τ = θ/2π + 4πi/g²_YM ↔ χ + i/g_s` 给 `θ = 2πχ`。**两处因子都需独立核实，见 Q2。**

---

### E17 对偶的性质：非微扰、SL(2,Z)、强弱

- 位置：§2，p.4–5 — **L1**
- 类型：proposition
- 原文陈述 **[逐字]**：
  > "The supersymmetry group of `AdS_5×S^5`, is known to be the same as the superconformal group in 3+1 spacetime dimensions [3], so the supersymmetries of both theories are the same. **This is a new form of "duality"**: a large `N` field theory is related to a string theory on some background, notice that the correspondence is non-perturbative in `g` and the `SL(2,Z)` symmetry of type IIB would follow as a consequence of the `SL(2,Z)` symmetry of SYM. It is also a strong-weak coupling correspondence in the following sense. When the effective coupling `gN` becomes large we cannot trust perturbative calculations in the Yang-Mills theory but we can trust calculations in supergravity on `(AdS_5 × S^5)_N`. This is suggesting that the `N = 4` Yang-Mills master field is the anti-deSitter supergravity solution (similar ideas were suggested in [17])."
  >
  > 脚注 6 **[逐字]**：「This is similar in spirit to [16] but here `N` is not interpreted as momentum.」
- 文献自称的严格程度：陈述 + 暗示（「This is suggesting that…」）。
- 文献列出的依赖：[3]；[16] = L. Susskind hep-th/9611164, Ganor–Ramgoolam–Taylor NPB **492** (1997) 191；[17] = M. Douglas, J. Polchinski and A. Strominger, hep-th/9703031。
- 备注：**「effective coupling `gN`」是原文对 't Hooft 耦合的称呼**（用 `gN`，不用 `λ`）。

---

### E18 量子效应 = 1/N 效应

- 位置：§2，p.5 — **L1**
- 类型：proposition
- 原文陈述 **[逐字]**：
  > "Since `N` measures the size of the geometry in Planck units, we see that quantum effects in `AdS_5 × S^5` have the interpretation of `1/N` effects in the gauge theory. So Hawking radiation is a `1/N` effect. It would be interesting to understand more precisely what the horizon means from the gauge theory point of view. IIB supergravity on `AdS_5 × S^5` was studied in [7,9]."
- 文献自称的严格程度：陈述句 + 自陈未完成（「It would be interesting to understand…」）。
- 文献列出的依赖：[7]（Salam–Sezgin 编 *Supergravities in Diverse Dimensions*）、[9]（Günaydin–Marcus 等）。

---

### E19 Higgs 分支检验：探针 D3 膜的 Born–Infeld 作用量

- 位置：§2，**eq. (2.6)**，p.5 — **L1**
- 类型：proposition（检验）
- 原文陈述 **[逐字，含公式]**：
  > "The above conjecture becomes nontrivial for large `N` and gives a way to answer some large `N` questions in the SYM theory. For example, suppose that we break `U(N) → U(N−1) × U(1)` by Higgsing. This corresponds to putting a three brane at some point on the 5-sphere and some value of `U`, with world volume directions along the original four dimensions (`x_∥`). We could now ask what the low energy effective action for the light U(1) fields is. For large `N` (2.4) it is the action of a D3 brane in `AdS_5 × S^5`. More concretely, the bosonic part of the action becomes the Born-Infeld action on the `AdS` background
  >
  > `S = −(1/((2π)³g)) ∫ d⁴x h^{−1}[ √(−Det(η_{αβ} + h∂_αU∂_βU + U²h g_{ij}∂_αθ^i∂_βθ^j + 2π√h F_{αβ})) − 1 ]`
  > `h = 4πgN/U⁴ ,`   **(2.6)**
  >
  > with `α, β = 0,1,2,3`, `i, j = 1,..,5`; and `g_{ij}` is the metric of the unit five-sphere."
- 文献自称的严格程度：陈述句。有效性条件被原文说明 **[逐字]**：「As any low energy action, (2.6) is valid when the energies are low compared to the mass of the massive states that we are integrating out. In this case the mass of the massive states is proportional to `U` (with no factors of `N`). The low energy condition translates into `∂U/U ≪ U` and `∂θ^i << U`, etc.. So the nonlinear terms in the action (2.6) will be important only when `gN` is large.」
- 文献列出的依赖：E12 (2.4)。
- 备注：`h = 4πgN/U⁴` 再次给出 `R⁴ = 4πgNα'²` 组合。

---

### E20 由超共形不变性定探针作用量（原文的三个输入 + 「不是预言」的自我限定）

- 位置：§2，**eqs. (2.7)–(2.9)**，p.6 — **L1**
- 类型：proposition（检验/一致性论证）
- 原文陈述 **[逐字，含公式]**：
  > "It seems that the form of this action is completely determined by superconformal invariance, by using the broken and unbroken supersymmetries, in the same sense that the Born Infeld action in flat space is given by the full Poincare supersymmetry [18]. It would be very interesting to check this explicitly. We will show this for a particular term in the action. We set `θ^i = const` and `F = 0`, so that we only have `U` left. Then we will show that the action is completely determined by broken conformal invariance. This can be seen as follows. Using Lorentz invariance and scaling symmetry (dimensional analysis) one can show that the action must have the form
  >
  > `S = ∫ d^{p+1}x U^{p+1} f(∂_αU ∂^αU/U⁴) ,`   **(2.7)**
  >
  > where `f` is an arbitrary function. Now we consider infinitesimal special conformal transformations
  >
  > `δx^α = ε^β x_β x^α − ε^α (x² + R̃⁴/U²)/2 ,`
  > `δU ≡ U'(x') − U(x) = −ε^α x_α U ,`   **(2.8)**
  >
  > … Demanding that (2.7) is invariant under (2.8) we find that the function `f` in (2.7) obeys the equation
  >
  > `f(z) + const = 2(z + 1/R̃⁴) f'(z)`   **(2.9)**
  >
  > which is solved by `f = b[√(1 + R̃⁴z) − a]`. Now we can determine the constants `a, b, R̃` from supersymmetry. **We need to use three facts.** The first is that there is no force (no vacuum energy) for a constant `U`. This implies `a = 1`. The second is that the `∂U²` term (`F²` term) in the U(1) action is not renormalized. The third is that the only contribution to the `(∂U)⁴` term (an `F⁴` term) comes from a one loop diagram [19]. This determines all the coefficients to be those expected from (2.6) **including the fact that `R̃⁴ = 4πgN`**. It seems very plausible that using all 32 supersymmetries we could fix the action (2.6) completely. **This would be saying that (2.6) is a consequence of the symmetries and thus not a prediction.**"
  >
  > 脚注 7 **[逐字]**：「Notice that the action (2.6) includes a term proportional to `v⁶` similar to that calculated in [20]. Conformal symmetry explains the agreement that they would have found if they had done the calculation for 3+1 SYM as opposed to 0+1.」
- 文献自称的严格程度：「one can show」（(2.7) 的形式）、「We will show this **for a particular term**」、「It seems very plausible」（用全部 32 个超对称定死作用量）。**并且原文自己降格了这条检验的证据价值**：若真由对称性完全决定，则 (2.6)「is a consequence of the symmetries and **thus not a prediction**」。
- 文献列出的依赖：[18] = Aganagic–Popescu–Schwarz, NPB **495** (1997) 99；[19] = Dine–Seiberg, PLB **409** (1997) 239；[20] = Becker–Becker–Polchinski–Tseytlin, PRD **56** (1997) 3174。
- 备注：**`R̃⁴ = 4πgN` 在这里被原文显式写出**（这是 E11 备注中「有原文背书」的出处）。**同时这是原文自己承认「这不算独立检验」的关键句**，curator 建「检验清单」时必须带上。

---

### E21 't Hooft 极限含 IIB 弦

- 位置：§2，p.6–7 — **L1**
- 类型：proposition
- 原文陈述 **[逐字]**：
  > "However we can make very nontrivial predictions (**though we were not able to check them**). For example, if we take `g` to be small (but N large) we can predict that the Yang-Mills theory contains strings. More precisely, **in the limit `g → 0`, `gN` = fixed `≫ 1` ('t Hooft limit) we find free strings in the spectrum, they are IIB strings moving in `(AdS_5 × S^5)_{gN}`.** The sense in which these strings are present is rather subtle since there is no energy scale in the Yang-Mills to set their tension. In fact one should translate the mass of a string state from the `AdS` description to the Yang-Mills description. This translation will involve the position `U` at which the string is sitting. This sets the scale for its mass. As an example, consider again the D-brane probe (Higgsed configuration) which we described above. From the type IIB description we expect open strings ending on the D3 brane probe. From the point of view of the gauge theory these open strings have energies `E = U/(4πgN)^{1/4} √(N_open)` where `N_open` is the integer charaterizing the massive open string level. In this example we see that `α'` disappears when we translate the energies and is replaced by `U`, which is the energy scale of the Higgs field that is breaking the symmetry."
  >
  > 脚注 8 **[逐字]**：「In fact, Polyakov [21] recently proposed that the string theory describing bosonic Yang-Mills has a new dimension corresponding to the Liouville mode `φ`, and that the metric at `φ = 0` is zero due to a "zig-zag" symmetry. In our case we see that the physical distances along the directions of the brane contract to zero as `U → 0`. The details are different, since we are considering the `N = 4` theory."
- 文献自称的严格程度：「we **can predict**」+ 括号里的自我限定「**though we were not able to check them**」。
- 文献列出的依赖：E16（猜想）、E19（探针）；[21] = A. Polyakov, hep-th/9711002。
- 备注：**这是原文里「't Hooft 极限」唯一的显式定义**：`g → 0`，`gN` fixed `≫ 1`。注意下标写作 `(AdS_5 × S^5)_{gN}`（而 E15/E16 用下标 `N`）——**两种下标记号在原文里并存**。原文 "charaterizing" 系排印错误，照抄。

---

### E22 U 的物理解释 = 能标

- 位置：§2，p.7 — **L1**
- 类型：proposition
- 原文陈述 **[逐字]**：
  > "Now we turn to the question of the physical interpretation of `U`. `U` has dimensions of mass. **It seems natural to interpret** motion in `U` as moving in energy scales, going to the IR for small `U` and to the UV for large U. For example, consider a D3 brane sitting at some position `U`. Due to the conformal symmetry, all physics at energy scales `ω` in this theory is the same as physics at energies `ω' = λω`, with the brane sitting at `U' = λU`."
- 文献自称的严格程度：「**It seems natural to interpret**」——明确的启发式措辞，不是推导。
- 文献列出的依赖：无。
- 备注：⚠ **本文这里的 `λ` 是标度因子，不是 't Hooft 耦合。** 全文没有把 `λ` 用作 `g²_YM N`（见 Q4）。

---

### E23 多中心解与 Higgs 分支的几何

- 位置：§2，**eqs. (2.10)–(2.11)**，p.7–8 — **L1**
- 类型：proposition（检验）
- 原文陈述 **[逐字，含公式]**：
  > "Now let us turn to another question. We could separate a group of D3 branes from the point were they were all sitting originally. Fortunately, for the extremal case we can find a supergravity solution describing this system. All we have to do is the replacement
  >
  > `N/U⁴ → (N−M)/U⁴ + M/|Ū − W̄|⁴ ,`   **(2.10)**
  >
  > where `W̄ = r̄/α'` is the separation. It is a vector because we have to specify a point on `S⁵` also. The resulting metric is
  >
  > `ds² = α'[ U² · 1/(√(4πg)(N − M + MU⁴/|Ū−W|⁴)^{1/2}) dx²_∥ + √(4πg)·(1/U²)·(N − M + MU⁴/|Ū − W|⁴)^{1/2} dŪ² ] .`   **(2.11)**
  >
  > For large `U ≫ |W|` we find basically the solution for `(AdS_5 × S^5)_N` which is interpreted as saying that for large energies we do not see the fact that the conformal symmetry was broken, while for small `U ≪ |W|` we find just `(AdS_5 × S^5)_{N−M}`, which is associated to the CFT of the unbroken `U(N − M)` piece. Furthermore, if we consider the region `|Ū − W̄| ≪ |W̄|` we find `(AdS_5 × S^5)_M`, which is described by the CFT of the `U(M)` piece."
- 文献自称的严格程度：陈述句（超引力侧是精确解，场论侧是「interpreted as」）。
- 文献列出的依赖：E7、E9。
- 备注：紧接一句 **[逐字]**：「We could in principle separate all the branes from each other. For large values of `U` we would still have `(AdS_5 × S^5)_N`, but for small values of `U` we would not be able to trust the supergravity solution, but **we naively get** `N` copies of `(AdS_5 × S^5)_1` which should correspond to the `U(1)^N`.」——「naively」是原文的自我限定。

---

### E24 紧化到环面后的可信条件

- 位置：§2，**eq. (2.12)**，p.8 — **L1**
- 类型：proposition
- 原文陈述 **[逐字，含公式]**：
  > "Now we discuss the issue of compactification. We want to consider the YM theory compactified on a torus of radii `R_i`, `x_i ∼ x_i + 2πR_i`, which stay fixed as we take the `α' → 0` limit. **Compactifying the theory breaks conformal invariance and leaves only the Poincare supersymmetries.** However one can still find the supergravity solutions and follow the above procedure, going near the horizon, etc. The `AdS` piece will contain some identifications. So we will be able to trust the supergravity solution as long as the physical length of these compact circles stays big in `α'` units. This implies that we can trust the supergravity solution as long as we stay far from the horizon (at `U = 0`)
  >
  > `U ≫ (gN)^{1/4}/R_i ,`   **(2.12)**
  >
  > for all `i`. **This is a larger bound than the naive expectation (`1/R_i`).** If we were considering near extremal black holes we would require that `U₀` in (2.5) satisfies (2.12), which is, of course, the same condition on the temperature gotten in [22]."
- 文献自称的严格程度：陈述句。
- 文献列出的依赖：E13 (2.5)；[22] = T. Banks, W. Fishler, I. Klebanov and L. Susskind, hep-th/9709091。

---

### E25 已有检验的清单与熵的「差一个数值因子」（**原文没有写 3/4**）

- 位置：§2 末，p.8 — **L1**
- 类型：proposition（对已有证据的综述）
- 原文陈述 **[逐字，全段照抄]**：
  > "The relation of the three-brane supergravity solution and the Yang-Mills theory has been studied in [23,24,25,26] . All the calculations have been done for near extremal D3 branes fall into the category described above. In particular the absorption cross section of the dilaton and the graviton have been shown to agree with what one would calculate in the YM theory [24,25]. It has been shown in [26] that some of these agreements are due to non-renormalization theorems for `N = 4` YM. **The black hole entropy was compared to the *perturbative* YM calculation and it agrees up to a numerical factor [23]. This is not in disagreement with the correspondence we were suggesting, It is expected that large `gN` effects change this numerical factor, this problem remains unsolved.**"
- 文献自称的严格程度：转述他人结果 + 明确的未决声明（「this problem **remains unsolved**」）。
- 文献列出的依赖（外部）：
  - [23] S. Gubser, I. Klebanov and A. Peet, Phys. Rev. **D54** (1996) 3915, hep-th/9602135；**A. Strominger, unpublished.**
  - [24] I. Klebanov, Nucl. Phys. **B496** (1997) 231, hep-th/9702076
  - [25] S. Gubser, I. Klebanov and A. Tseytlin, Nucl. Phys. **B499** (1997) 217, hep-th/9703040
  - [26] S. Gubser and I. Klebanov, hep-th/9708005
- 备注（**任务书特别问到熵/3-4 因子，此处给死答案**）：
  1. **本文没有出现数字 `3/4`**（抽取者逐页读完全部 22 页确认）。原文只说「agrees **up to a numerical factor**」，并把出处指给 [23]（Gubser–Klebanov–Peet）。
  2. 因此图里若要建「自由场熵 = (3/4)×强耦合熵」节点，**来源必须是 Gubser–Klebanov–Peet 1996，不能挂 `maldacena-1997`**。本文只能作为「Maldacena 承认此处不符且问题未解决」的来源。
  3. ⚠ 原文 [23] 的第二项是「A. Strominger, **unpublished**」——按 `literature/CLAUDE.md` 规则 1（不使用未发表材料），这一半不可登记为 source。
  4. 原文 "It is not in disagreement …, **It** is expected" 处逗号接大写系排印错误，照抄。

---

### E26 十二维/两时的暗示

- 位置：§2 末，p.8 — **L1**
- 类型：proposition（推测性评论）
- 原文陈述 **[逐字]**：
  > "Finally notice that the group `SO(2,4) × SO(6)` suggests a twelve dimensional realization in a theory with two times [27]."
- 文献自称的严格程度：「suggests」。
- 文献列出的依赖：[27] = C. Vafa, Nucl. Phys. **B469** (1996) 403, hep-th/9602022。
- 备注：**这是全文唯一一处把 D3 情形的两个玻色对称群并列写出的地方**：`SO(2,4) × SO(6)`。常见的写法 `SO(4,2)×SO(6)` 指标顺序与原文不同（同构，但引文要照原文）。

---

### E27 §3 引言：D3 的论证整体搬到 M5/M2

- 位置：§3 标题「Other cases with `16 → 32` supersymmetries, M5 and M2 brane theories」，p.9 — **L1**
- 类型：proposition
- 原文陈述 **[逐字]**：
  > "**Basically all that we have said for the D3 brane carries over** for the other conformal field theories describing coincident M-theory fivebranes and M-theory twobranes. We describe below the limits that should be taken in each of the two cases. Similar remarks can be made about the entropies [28], and the determination of the probe actions using superconformal invariance. Eleven dimensional supergravity on the corresponding `AdS` spaces was studied in [5,10,11,15]."
- 文献自称的严格程度：类比式陈述（「carries over」），**没有重复给出 D3 那样的详细论证**。
- 文献列出的依赖：E7–E26 全部（通过「all that we have said for the D3 brane」）；[28] = I. Klebanov and A. Tseytlin, Nucl. Phys. **B475** (1996) 164, hep-th/9604089。
- 备注：**图里 M5/M2 的推导节点在原文里比 D3 弱一级**：D3 有逐步的极限+度规+可信条件+多项检验；M5/M2 只有极限+度规+对称性，其余靠「carries over」。curator 不应把 D3 的检验直接复制给 M5/M2 而不加 note。

---

### E28 M5 退耦极限

- 位置：§3.1 M 5 brane，p.9 — **L1**
- 类型：definition
- 原文陈述 **[逐字]**：
  > "The decoupling limit is obtained by taking the 11 dimensional Planck length to zero, `l_p → 0`, keeping the worldvolume energies fixed and taking the separations `U² ≡ r/l_p³ = fixed` [29]. This last condition ensures that the membranes stretching between fivebranes give rise to strings with finite tension."
- 文献自称的严格程度：定义 + 引用他处（[29] = A. Sromenger〔原文排印，实为 A. Strominger〕, Phys. Lett. **B383** (1996) 44, hep-th/9512059）。
- 文献列出的依赖：[29]。
- 备注：⚠ 参考文献 [29] 的作者名在原文 references 里印成 **"A. Sromenger"**（排印错误）。登记 `sources.bib` 时应写正确姓名 Strominger 并留 note。

---

### E29 M5 超引力解

- 位置：§3.1，**eq. (3.1)** + 脚注 9，p.9 — **L1**
- 类型：proposition
- 原文陈述 **[逐字，含公式]**：
  > "The metric is
  >
  > `ds² = f^{−1/3} dx²_∥ + f^{2/3}(dr² + r² dΩ²_4) ,`
  > `f = 1 + πN l_p³/r³ ,`   **(3.1)**
  >
  > We also have a flux of the four-form field strength on the four-sphere (which is quantized)."
  >
  > 脚注 9 **[逐字]**：「In our conventions the relation of the Planck length to the 11 dimensional Newton constant is `G_N^{11} = 16π⁷ l_p⁹`.」
- 文献自称的严格程度：直接给出，无出处（脚注 9 只给约定）。
- 文献列出的依赖：无。

---

### E30 M5 近视界几何 AdS_7 × S^4 与半径

- 位置：§3.1，**eq. (3.2)**，p.9 — **L1**
- 类型：proposition
- 原文陈述 **[逐字，含公式]**：
  > "Again, in the limit we obtain
  >
  > `ds² = l_p²[ U²/(πN)^{1/3} dx²_∥ + 4(πN)^{2/3} dU²/U² + (πN)^{2/3} dΩ²_4 ] ,`   **(3.2)**
  >
  > where now the "radii" of the sphere and the `AdS_7` space are `R_sph = R_AdS/2 = l_p(πN)^{1/3}`. Again, the "radii" are fixed in Planck units as we take `l_p → 0`, and supergravity can be applied if `N ≫ 1`. Reasoning as above we conclude that this theory contains seven dimensional Anti-deSitter times a four-sphere, which for large `N` looks locally like eleven dimensional Minkowski space."
- 文献自称的严格程度：「Reasoning as above **we conclude**」。
- 文献列出的依赖：E28、E29。
- 备注：**注意 `R_sph = R_AdS/2`**——M5 情形球半径是 AdS 半径的一半（D3 情形两者相等，见 E11）。可信条件是 `N ≫ 1`（没有额外的耦合常数）。

---

### E31 M5 猜想的原文本体

- 位置：§3.1 末，p.9 — **L1**
- 类型：proposition（猜想）
- 原文陈述 **[逐字；斜体为原文斜体]**：
  > "This gives us a method to calculate properties of the large N limit of the six dimensional (0,2) conformal field theory [30]. The superconformal group again coincides with the algebra of the supersymmetries preserved by `AdS_7 × S^4`. The bosonic symmetries are `SO(2,6) × SO(5)` [4]. We can do brane probe calculations, thermodynamic calculations [28], etc.
  > **The conjecture is now that** *the (0,2) conformal field theory is dual to M-theory on* `(AdS_7 × S^4)_N` , the subindex indicates the dependence of the "radius" with `N`."
- 文献自称的严格程度：「**The conjecture is now that**」。
- 文献列出的依赖：[30] = E. Witten hep-th/9507121；N. Seiberg and E. Witten, Nucl. Phys. **B471** (1996) 121, hep-th/9603003；[4] = Nahm；[28] = Klebanov–Tseytlin。
- 备注：**这条猜想里没有「plus appropriate boundary conditions」这个限定语**（D3 那条有，见 E16）。逐字差异，curator 不要自行补齐。

---

### E32 M2 退耦极限及其与 D2 强耦合极限的关系

- 位置：§3.2 M2 brane，p.10 — **L1**
- 类型：definition + proposition
- 原文陈述 **[逐字]**：
  > "We now take the limit `l_p → 0` keeping `U^{1/2} ≡ r/l_p^{3/2}` = fixed. This combination has to remain fixed because the scalar field describing the motion of the twobrane has scaling dimension 1/2. Alternatively we could have derived this conformal field theory by taking first the field theory limit of D2 branes in string theory as in [31,32,33], and then taking the strong coupling limit of that theory to get to the conformal point as in [34,35,36]. The fact that the theories obtained in this fashion are the same can be seen as follows. The D2 brane gauge theory can be obtained as the limit `α' → 0`, keeping `g²_YM ∼ g/α'` = fixed. This is the same as the limit of M-theory two branes in the limit `l_p → 0` with `R_11/l_p^{3/2} ∼ g_YM` = fixed. This is a theory where one of the Higgs fields is compact. Taking `R^{11} → ∞` we see that we get the theory of coincident M2 branes, in which the `SO(8)` R-symmetry has an obvious origin."
- 文献自称的严格程度：「can be seen as follows」。
- 文献列出的依赖：[31] = J. Maldacena, Proceedings of Strings'97, hep-th/9709099；[32] = N. Seiberg, PRL **79** (1997) 3577；[33] = A. Sen, hep-th/9709220；[34] = N. Seiberg, hep-th/9705117；[35] = Sethi–Susskind, PLB **400** (1997) 265；[36] = Banks–Seiberg, NPB **497** (1997) 41。
- 备注：⚠ **本条包含全文唯一一处把 `g_YM` 与 `g/α'` 直接联系的式子，但只是 `∼`（正比号），不是等号**：`g²_YM ∼ g/α'`（**D2 膜**，不是 D3）。**不能**用来定 D3 的耦合字典（见 Q2）。

---

### E33 M2 解与近视界几何 AdS_4 × S^7

- 位置：§3.2，**eq. (3.3)**，p.10 — **L1**
- 类型：proposition
- 原文陈述 **[逐字，含公式]**：
  > "The metric is
  >
  > `ds² = f^{−2/3} dx²_∥ + f^{1/3}(dr² + r² dΩ²_7) ,`
  > `f = 1 + 2⁵π²N l_p⁶/r⁶ ,`   **(3.3)**
  >
  > and there is a nonzero flux of the dual of the four-form field strength on the seven-sphere. In the decoupling limit we obtain `AdS_4 × S^7`, and the supersymmetries work out correctly. The bosonic generators are given by `SO(2,3) × SO(8)`. In this case the "radii" of the sphere and `AdS_4` are `R_sph = 2R_AdS = l_p(2⁵π²N)^{1/6}`."
- 文献自称的严格程度：陈述句（「the supersymmetries work out correctly」——无细节）。
- 文献列出的依赖：E32。
- 备注：**M2 情形 `R_sph = 2R_AdS`**（与 M5 的 `R_sph = R_AdS/2` 相反，与 D3 的相等又不同）。三个 case 的半径关系各不相同，图里若建「AdS×球半径比」节点必须逐 case 分开。

---

### E34 M2 的熵：原文明说 N 依赖与数值系数「not understood」

- 位置：§3.2，p.10 — **L1**
- 类型：proposition（负面结果 / 未决）
- 原文陈述 **[逐字]**：
  > "The entropy of the near extremal solution agrees with the expectation from dimensional analysis for a conformal theory in 2+1 dimensions [28], **but the `N` dependence or the numerical coefficients are not understood.**"
- 文献自称的严格程度：明确的未决声明。
- 文献列出的依赖：[28] = Klebanov–Tseytlin。
- 备注：与 E25（D3 的熵差一个数值因子）并列，是原文自列的**两条已知不符/未解释项**。curator 建「原文自列的 gap」清单时两条都要收。

---

### E35 M2 探针作用量与共形不变性

- 位置：§3.2，p.10 — **L1**
- 类型：proposition
- 原文陈述 **[逐字]**：
  > "Actually for the case of the two brane the conformal symmetry was used to determine the `v⁴` term in the probe action [37], **we are further saying that conformal invariance determines it to all orders in the velocity of the probe.** Furthermore the duality we have proposed with M-theory on `AdS_4 × S^7` **determines the precise numerical coefficient.**"
- 文献自称的严格程度：「we are further saying」——**这是原文的一个预言**（未被本文验证）。
- 文献列出的依赖：[37] = T. Banks, W. Fishler, N. Seiberg and L. Susskind, PLB **408** (1997) 111, hep-th/9705190。
- 备注：注意这里出现了 **"the duality we have **proposed**"** 这个措辞。**全文对该对应关系的措辞统计见 §5.1。**

---

### E36 十三维暗示

- 位置：§3.2 末，p.10 — **L1**
- 类型：proposition（推测性评论）
- 原文陈述 **[逐字]**：
  > "When M-theory is involved the dimensionalities of the groups are suggestive of a thirteen dimensional realization [38]."
- 文献列出的依赖：[38] = I. Bars, Phys. Rev. **D55** (1997) 2373, hep-th/9607112。

---

### E37 D1+D5 退耦极限

- 位置：§4「Theories with `8 → 16` supersymmetries, the D1+D5 system」，**eq. (4.1)**，p.10–11 — **L1**
- 类型：definition
- 原文陈述 **[逐字，含公式]**：
  > "Now we consider IIB string theory compactified on `M⁴` (where `M⁴ = T⁴` or `K3`) to six spacetime dimensions. […] Consider a system with `Q_5` fivebranes and `Q_1` D-strings, where the D-string is parallel to the string in six dimensions arising from the fivebrane. This system is described at low energies by a 1+1 dimensional (4,4) superconformal field theory. So we take the limit
  >
  > `α' → 0 ,   r/α' = fixed ,   v ≡ V_4/((2π)⁴α'²) = fixed ,   g_6 = g/√v = fixed`   **(4.1)**
  >
  > where `V_4` is the volume of `M⁴`. All other moduli of `M⁴` remain fixed. **This is just a low energy limit, we keep all dimensionless moduli fixed.**"
- 文献自称的严格程度：定义。
- 文献列出的依赖：无。

---

### E38 D1+D5 解与近视界几何 AdS_3 × S³ × M⁴(Q)

- 位置：§4，**eqs. (4.2)–(4.3)**，p.11 — **L1**
- 类型：proposition
- 原文陈述 **[逐字，含公式]**：
  > "Now we consider the supergravity solution corresponding to D1+D5 branes [40]
  >
  > `ds² = f_1^{−1/2} f_5^{−1/2} dx²_∥ + f_1^{1/2} f_5^{1/2}(dr² + r² dΩ²_3) ,`
  > `f_1 = (1 + gα'Q_1/(vr²)) ,      f_5 = (1 + gα'Q_5/r²) ,`   **(4.2)**
  >
  > where `dx²_∥ = −dt² + dx²` and `x` is the coordinate along the D-string. […] In the decoupling limit (4.1) we can neglect the 1's in `f_i` in (4.2) and the metric becomes
  >
  > `ds² = α'[ U²/(g_6√(Q_1Q_5)) dx²_∥ + g_6√(Q_1Q_5) dU²/U² + g_6√(Q_1Q_5) dΩ²_3 ] .`   **(4.3)**"
- 文献自称的严格程度：直接计算 + 引用他处解（[40] = G. Horowitz, J. Maldacena and A. Strominger, PLB **383** (1996) 151, hep-th/9603109）。
- 文献列出的依赖：E37、[40]。
- 备注：可信条件 **[逐字]**：「We can trust the supergravity solution if `Q_1, Q_5` are large, `g_6Q_1 ≫ 1`.」

---

### E39 D1+D5 猜想的原文本体

- 位置：§4，p.12 — **L1**
- 类型：proposition（猜想）
- 原文陈述 **[逐字；斜体为原文斜体]**：
  > "The metric (4.3) describes three dimensional `AdS_3` times a 3-sphere. The supersymmetries work out correctly, starting from the 8 Poincare supersymmetries we enhance then to 16 supersymmetries. The bosonic component is `SO(2,2) × SO(4)`. In conformal field theory language `SO(2,2)` is just the `SL(2,R) × SL(2,R)` part of the conformal group and `SO(4) ∼ SU(2)_L × SU(2)_R` are the R-symmetries of the CFT [13].
  > **So the conjecture is that** *the 1+1 dimensional CFT describing the Higgs branch of the D1+D5 system on* `M⁴` *is dual to type IIB string theory on* `(AdS_3 × S³)_{Q_1Q_5} × M⁴(Q)` . The subscript indicates that the radius of the three sphere is `R²_sph = α' g_6 √(Q_1Q_5)`."
- 文献自称的严格程度：「**So the conjecture is that**」。
- 文献列出的依赖：E37、E38；[13] = P. Claus, R. Kallosh and A. van Proeyen, hep-th/9711161。
- 备注：原文 "we enhance **then**" 应为 "them"，排印错误，照抄。

---

### E40 D1+D5 猜想所需的额外假设（原文自列）

- 位置：§4，p.12 — **L1**
- 类型：proposition（承认的假设）
- 原文陈述 **[逐字]**：
  > "**It is necessary for this conjecture to work that** the 1+1 dimensional (4,4) theory is indendent of the tensor moduli appearing in its original definition as a limit of the brane configurations, since `M⁴(Q)` does not depend on those moduli. **A non renomalization theorem like [44,45] would explain this.** We also need that the Higgs branch decouples from the Coulomb branch as in [46,47]."
- 文献自称的严格程度：**明确列出为「必要条件」，且这些条件本文未证明**（「would explain this」是条件语气）。
- 文献列出的依赖：[44] = J. Maldacena, PRD **55** (1997) 7645, hep-th/9611125；[45] = D. Diaconescu and N. Seiberg, JHEP07(1997)001, hep-th/9707158；[46] = O. Aharony, M. Berkooz, S. Kachru, N. Seiberg and E. Silverstein, hep-th/9707079；[47] = E. Witten, hep-th/9707093。
- 备注：**这是全文中「原文自己承认的假设」写得最明确的一条**（比 D3 的还明确）。原文 "indendent" 系排印错误。

---

### E41 D1+D5 的有限温度与已有证据（BTZ、greybody factors）

- 位置：§4，p.12–13 — **L1**
- 类型：proposition
- 原文陈述 **[逐字]**：
  > "Finite temperature configurations in the 1+1 conformal field theory can be considered. They correspond to near extremal black holes in `AdS_3`. The metric is the same as that of the BTZ 2+1 dimensional black hole [48], except that the angle of the BTZ description is not periodic. […] **All calculations done for the 1D+5D system [39,53,54] are evidence for this conjecture.** In all these cases [54] the nontrivial part of the greybody factors comes from the `AdS` part of the spacetime. Indeed, it was noticed in [55] that the greybody factors for the BTZ black hole were the same as the ones for the five-dimensional black hole in the dilute gas approximation. The dilute gas condition `r_0, r_n ≪ r_1r_5` [53] is automatically satisfied in the limit (4.1) for finite temperature configurations […]. It was also noticed that the equations have an `SL(2,R) × SL(2,R)` symmetry [56], these are the isometries of `AdS_3`, and part of the conformal symmetry of the 1+1 dimensional field theory."
- 文献自称的严格程度：「are **evidence for** this conjecture」——**明确称为证据而非证明**。
- 文献列出的依赖：[39] = Strominger–Vafa, PLB **B379** (1996) 99；[48] = Bañados–Teitelboim–Zanelli, PRL **69** (1992) 1849；[53] = Horowitz–Strominger, PRL **77** (1996) 2368；[54]（一长串 greybody 文献）；[55] = D. Birmingham, I. Sachs and S. Sen, hep-th/9707188；[56] = Cvetic–Larsen。
- 备注：**这是全文中「已有检验」最集中的一段**，且是唯一一处原文用「evidence for this conjecture」的地方。

---

### E42 §5 引言的自我限定（**原文自评最弱的一节**）

- 位置：§5「Theories with `4 → 8` supersymmetries」开头，p.13 — **L1**
- 类型：meta（自我限定）
- 原文陈述 **[逐字]**：
  > "The theories of this type will be related to black strings in five dimensions and Reissner-Nordström black holes in four dimensions. **This part will be more sketchy, since there are several details of the conformal field theories involved which I do not completely understand, most notably the dependence on the various moduli of the compactification.**"
- 备注：curator 若从 §5 取任何内容，**必须**在节点 note 里带上这句自评。

---

### E43 五维黑弦：AdS_3 × S² 与其猜想（原文明说不确定必要条件是否成立）

- 位置：§5.1，**eqs. (5.1)–(5.2)**，p.13–14 — **L1**
- 类型：proposition（猜想）
- 原文陈述 **[逐字，含公式]**：
  > "We wrap fivebranes on a four-cycle `P_4 = p^A α_A` in `M⁶` with nonzero triple self intersection number, see [57]. […] Now we take the following limit
  >
  > `l_p → 0 ,   (2π)⁶v ≡ V_6/l_p⁶ = fixed ,   U² ≡ r/l_p³ = fixed ,`   **(5.1)**
  >
  > […] We get
  >
  > `ds² = l_p²[ (U²v^{1/3}/D^{1/3})(−dt² + dx²) + (D^{2/3}/v^{2/3})(4 dU²/U² + dΩ²_2) ] .`   **(5.2)**
  >
  > […] We get a product of three dimensional `AdS_3` spacetime with a two-sphere, `AdS_3 × S²`. Defining the five dimensional Planck length by `l³_{5p} = l³_p/v` we find that the "radii" of the two sphere and the `AdS_3` are `R_sph = R_AdS/2 = l_{5p}D^{1/3}`. In this case the superconformal group contains as a bosonic subgroup `SO(2,2) × SO(3)`. So the R-symmetries are just `SU(2)_R`, associated to the 4 rightmoving supersymmetries.
  > **In this case we conjecture that** this (0,4) conformal field theory is dual, for large `p^A`, to M-theory on `AdS_3 × S² × M⁶_p`. […] **A necessary condition for this conjecture to work is that the (0,4) theory should be independent of the original values of the vector moduli (at least for large `p`). It is not clear to me whether this is true.**"
- 文献自称的严格程度：「**we conjecture**」+ 明确的「**It is not clear to me whether this is true**」。
- 文献列出的依赖：[57] = J. Maldacena, A. Strominger and E. Witten, hep-th/9711053；[58] = Chamseddine–Ferrara–Gibbons–Kallosh（近视界处 vector moduli 取 fixed point 值）。
- 备注：紧接 **[逐字]**：「Using this conjecture we would get for large `N` a compactification of `M` theory which has five extended dimensions.」

---

### E44 四维极端 Reissner–Nordström：AdS_2 × S² 与原文自陈的 puzzle

- 位置：§5.2，**eqs. (5.3)–(5.4)**，p.15 — **L1**
- 类型：proposition（含未解决矛盾）
- 原文陈述 **[逐字，含公式]**：
  > "**This section is more sketchy and contains an unresolved puzzle, so the reader will not miss much if he skips it.**
  > We start with IIB string theory compactified on `M⁶`, where `M⁶` is a Calabi-Yau manifold or `K3 × T²` or `T⁶`. We consider a configuration of `D3` branes that leads to a black hole with nonzero horizon area. Consider the limit
  >
  > `α' → 0 ,   (2π)⁶v ≡ V_6/α'³ = fixed ,   U ≡ r/α' = fixed .`   **(5.3)**
  >
  > The string coupling is arbitrary. In this limit the system reduces to quantum mechanics on the moduli space of the three-brane configuration.
  > Taking the limit (5.3) of the supergravity solution we find
  >
  > `ds² = α'[ (U²/(g²_4N²))dt² + g²_4N² dU²/U² + g²_4N² dΩ²_2 ]`   **(5.4)**
  >
  > where `N` is proportional to the number of D3 branes. We find a two dimensional `AdS_2` space times a two-sphere, both with the same radius `R = l_{4p}N`, where `l²_{4p} = g²α'/v`. The bosonic symmetries of `AdS_2 × S²` are `SO(2,1) × SO(3)`. This superconformal symmetry seems related to the symmetries of the *chiral* conformal field theory that was proposed in [59] to describe the Reissner-Nordström black holes. **Here we find a puzzle, since in the limit (5.3) we got a quantum mechanical system and not a 1+1 dimensional conformal field theory.** In the limit (5.3) the energy gap (mentioned in [60,59]) becomes very large. So it looks like taking a large `N` limit at the same time will be crucial in this case. These problems might be related to the large ground state entropy of the system."
  >
  > 脚注 13 **[逐字]**：「I thank A. Strominger for pointing this out to me.」
- 文献自称的严格程度：**明确标为 unresolved puzzle**。
- 文献列出的依赖：[59] = J. Maldacena and A. Strominger, PRD **56** (1997) 4975；[60] = J. Maldacena and L. Susskind, NPB **475** (1996) 679。
- 备注：⚠ **(5.4) 的 `dt²` 项符号为正**，与 mostly-plus 号差下 `−dt²` 的写法不一致，页图上确实印的是 `+U²/(g²_4N²)dt²`。**这很可能与致谢里提到的「sign error」有关（见 §0.3），但本轮没有 v1/v2 可对照，不能断定。** 见 Q5。

---

### E45 §6 总结：论文对自身成果强度的最终定性

- 位置：§6 Discussion, relation to matrix theory，p.16 — **L1**
- 类型：meta（主张强度记录）
- 原文陈述 **[逐字]**：
  > "By deriving various field theories from string theory and considering their large `N` limit **we have shown** that they contain in their Hilbert space excitations describing **supergravity** on various spacetimes. **We further conjectured** that the field theories are **dual to the full quantum M/string theory** on various spacetimes. In principle, we can use this duality to give a definition of M/string theory on flat spacetime as (a region of) the large `N` limit of the field theories. Notice that this is a non-perturbative proposal for defining such theories, since the corresponding field theories can, *in principle*, be defined non-perturbatively. **We are only scratching the surface and there are many things to be worked out.**"
- 文献自称的严格程度：**再次明确的两级划分**，与 E1 摘要一致：
  - 「we have **shown**」→ 超引力**激发包含于 Hilbert 空间**；
  - 「we further **conjectured**」→ 与**完整量子 M/弦论**的对偶。
- 备注：**E1 + E45 是同一划分在文首文末各出现一次**，两处措辞高度一致。这构成图里「拆成两个节点」的最强证据（两条独立位置的原文背书）。

---

### E46 与矩阵模型的关系

- 位置：§6，p.16 — **L1**
- 类型：proposition
- 原文陈述 **[逐字]**：
  > "In [61] it has been proposed that the large `N` limit of D0 brane quantum mechanics would describe eleven dimensional M-theory. The large `N` limits discussed above, also provide a definition of M-theory. **An obvious difference with the matrix model of [61] is that here `N` is not interpreted as the momentum along a compact direction. In our case, `N` is related to the curvature and the size of the space where the theory is defined.** In both cases, in the large `N` limit we expect to get flat, non-compact spaces. The matrix model [61] gives us a prescription to build asymptotic states, **we have not shown here how to construct graviton states, and this is a very interesting problem.** On the other hand, with the present proposal it is more clear that we recover supergravity in the large `N` limit."
- 文献自称的严格程度：陈述 + 自陈未完成（「we have not shown here how to construct graviton states」）。
- 文献列出的依赖：[61] = T. Banks, W. Fischler, S. Shenker and L. Susskind, hep-th/9610043。

---

### E47 §6 的其余评论（推广到非共形、singleton、欧氏化）

- 位置：§6，p.16–17 — **L1**
- 类型：proposition（展望性评论，均带 hedging）
- 原文陈述 **[逐字，节选]**：
  > "**It seems that** this correspondence between the large `N` limit of field theories and supergravity **can be extended to non-conformal field theories.** An example was considered in [1], where the theory of NS fivebranes was studied in the `g → 0` limit. **A natural interpretation for the throat region is that it is a region in the Hilbert space of a six dimensional "string" theory.** And the fact that contains gravity in the large N limit is just a common feature of the large `N` limit of various field theories. The large `N` master field seems to be the anti-deSitter supergravity solutions [17]."
  >
  > 「In [5,13] super-singleton representations of `AdS` were studied and it was proposed that they would describe the dynamics of a brane "at the end of the world". […] **The claim of the present paper is that all the dynamics of `AdS` reduces to previously known conformal field theories.**」
  >
  > 「**It seems natural to study conformal field theories in Euclidean space and relate them to deSitter spacetimes.**」
  >
  > 「Also it would be nice if these results could be extended to four-dimensional gauge theories with less supersymmetry.」
  >
  > 脚注 14 **[逐字]**：「This possibility was also raised by [62], though it is a bit disturbing to find a constant energy flux to the UV (that is how we are interpreting the radial dimension).」（[62] = O. Aharony, S. Kachru, N. Seiberg and E. Silverstein, **private communication**）
- 文献自称的严格程度：全部 hedged（「It seems that」「A natural interpretation」「It seems natural」）。
- 备注：⚠ [62] 是「**private communication**」——按 `literature/CLAUDE.md` 规则 1 不可登记为 source，只能作为原文脚注内容记录。

---

### E48 附录：AdS 时空的定义与「radius」的含义

- 位置：§7 Appendix，**eqs. (7.1)–(7.3)**，p.17–18 — **L1**
- 类型：definition
- 原文陈述 **[逐字，含公式]**：
  > "`D = p + 2`-dimensional anti-deSitter spacetimes can be obtained by taking the hyperboloid
  >
  > `−X²_{−1} − X²_0 + X²_1 + ⋯ + X²_p + X²_{p+1} = −R² ,`   **(7.1)**
  >
  > embedded in a flat D+1 dimensional spacetime with the metric `η = Diag(−1,−1,1,⋯,1)`. **We will call `R` the "radius" of `AdS` spacetime.** The symmetry group `SO(2, D − 1) = SO(2, p + 1)` is obvious in this description. In order to make contact with the previously presented form of the metric let us define the coordinates
  >
  > `U = (X_{−1} + X_{p+1})`
  > `x_α = X_α R/U ,      α = 0,1,⋯,p`
  > `V = (X_{−1} − X_{p+1}) = x²U/R² + R²/U .`   **(7.2)**
  >
  > The induced metric on the hyperboloid (7.1) becomes
  >
  > `ds² = (U²/R²) dx² + R² dU²/U² .`   **(7.3)**
  >
  > This is the form of the metric used in the text. We could also define `Ũ = U/R²` so that metric (7.3) has an overall factor of `R²`, making it clear that `R` is the overall scale of the metric. **The region outside the horizon corresponds to `U > 0`, which is only a part of (7.1). It would be interesting to understand what the other regions in the `AdS` spacetime correspond to.** For further discussion see [65]."
- 文献自称的严格程度：定义。
- 文献列出的依赖：[65] = S. Hawking and J. Ellis, *The large scale structure of spacetime*, Cambrige Univ. Press (1973)（原文将 "Cambridge" 印作 "Cambrige"）。
- 备注（两点，对图重要）：
  1. **本文使用的 `AdS` 坐标只覆盖 `U > 0`，即视界外的一片**，原文明说这只是 (7.1) 的一部分，且「其余区域对应什么」未解决。→ 「AdS 边界/全局结构」在原文里是**未处理**的，与 E5「边界条件未指定」呼应。
  2. **本文的「radius」按 (7.1) 定义**，E11/E30/E33/E39/E43 里所有 `R_sph`、`R_AdS` 的数值关系都以此为准。

---

## 3. 未核实项清单

本次抽取对**原文本身**的覆盖是完整的（22 页逐页读图，L1）。下列各项是**超出原文之外**、本轮没有核实的东西。curator 不得把它们当成已核实内容使用。

| # | 未核实项 | 影响 | 建议做法 |
|---|---|---|---|
| U1 | **ATMP 发表版 (Adv. Theor. Math. Phys. 2 (1998) 231–252) 的正文与式号**。本轮只读了 arXiv **v3**。 | 本文件所有式号 (2.1)–(7.3) 只对 v3 成立 | `sources.bib` 的 `maldacena-1997` 应加 `note` 写明「本项目的所有 loc 依 arXiv v3」；或另建 `maldacena-1997-atmp` 条目 |
| U2 | **arXiv v1/v2 与 v3 的差异**。致谢承认「a sign error」被 [64] 指出并改正，但**具体改了哪一处未查** | 若他人引用 v1 的某式，与本文件对不上 | 需要时下载 v1 逐式对照。**在此之前，E44 的 (5.4) 符号问题（Q5）不能下结论** |
| U3 | **参考文献 [1]–[65] 的内容**。本文件只抄了原文 references 的书目条目，**没有读任何一篇** | 「原文说 [23] 证明了 X」只是原文的转述，不是 X 本身 | 熵、吸收截面、非重整化定理若要进图，必须各自单独抽取 |
| U4 | **熵的 `3/4` 因子** | 本文**没有**这个数（见 E25） | 必须去 Gubser–Klebanov–Peet, hep-th/9602135 抽 |
| U5 | **`PSU(2,2|4)` 这个记号的最早出处** | 本文没有（见 E6、Q3） | 若图里要用这个记号，须另找来源 |
| U6 | **配分函数形式的 AdS/CFT（`Z_string[φ_0] = ⟨e^{∫φ_0 O}⟩_CFT`）** | **本文完全没有**（见 Q7） | 出处是 1998 年的 GKP (hep-th/9802109) 与 Witten (hep-th/9802150)，两者都不在本文的 65 条参考文献里（时间上也不可能） |
| U7 | **`g²_YM = 4πg_s` 这条现代标准字典** | 与本文的 `g²_YM = 2πg` 差因子 2（见 E16、Q2） | 见 Q2 的处理建议 |
| U8 | **本文的 `g` 与 Polchinski 的 `g_s`/`g_o` 是否同一归一化** | 影响所有把本文与 `polchinski-1998-v2` 拼接的边 | 需要 Polchinski Vol.2 §13 的 D 膜作用量归一化，本项目尚未抽取 |
| U9 | **(4.2)、(5.2)、(5.4)、(2.11) 的转录细节**。这几式在页图上是多层分式/嵌套根号，本文件转成一行文本时**可能丢了括号层次** | 若 curator 要把这些式子写进节点，**必须回原 PDF 复核页图**，不能直接复制本文件的一行版本 | 本文件已在每条备注里保留了式号与页码，回查成本很低 |

---

## 4. 未解决的疑问

### Q1 — 版本：图里的 `loc` 应该锚定 v3 还是 ATMP 发表版？

本轮只有 v3。`sources.bib` 登记的是 ATMP。**两者式号一致性未核实（U1）。**
→ **建议**：在 `sources.bib` 的 `maldacena-1997` 加一行 `note = {本项目所有 loc 依 arXiv hep-th/9711200v3 (22 Jan 1998)；ATMP 发表版未核对}`。这是一个**低成本、高收益**的防错措施。

---

### Q2 — 耦合字典：`g²_YM = 2πg`（原文）vs `g²_YM = 4πg_s`（今日常见写法），差因子 2

**原文只给这一条关系（E16，L1 逐字）**：

> `1/g²_YM + i θ/8π² = (1/2π)(1/g + i χ/2π)`

**[抽取者代数]** 取实部 ⇒ `g²_YM = 2πg`；结合 E11/E20 的 `R⁴/α'² = 4πgN` ⇒ **`R⁴/α'² = 2 g²_YM N`**。
取虚部 ⇒ `θ/8π² = χ/4π²` ⇒ `θ = 2χ`。

而任务书与多数现代教科书写的是 `g²_YM = 4πg_s`、`R⁴/α'² = g²_YM N ≡ λ`、`θ = 2πχ`。

**本轮做了什么**：用 WebSearch 查了这个因子。检索后端复述称「`R⁴/α'² = 4πg_sN` 在两套约定下都一样，差别只在如何把它拆成 `g²_YM`，根源是生成元迹归一化 `Tr(T^aT^b) = c δ^{ab}` 取 `c = 1/2` 还是 `c = 1`；`g²_YM = 2πg_s` 配 `R⁴/α'² = 2g²_YM N` 是自洽的」。
⚠ **这段是 L4（检索后端自由复述），按本项目规矩不得入库，本条只作为后续核实的线索记录。** 检索命中的候选核实源（**均未打开阅读**）：Aharony–Gubser–Maldacena–Ooguri–Oz 综述 hep-th/9905111、Klebanov TASI hep-th/0009139、D'Hoker–Freedman TASI hep-th/0201253、Petersen "Introduction to the Maldacena Conjecture" hep-th/9902131。

**本文内部的旁证（L1）**：E32 里原文对 **D2 膜**写的是 `g²_YM ∼ g/α'`（**正比号，不是等号**），说明本文全篇不追求 `g_YM` 的数值归一化。这是本文自己的写作风格，**不能**据此断定本文的 `2π` 是笔误。

→ **给 curator 的硬性要求**：
1. **图节点里写字典时必须逐字抄原文那一个复耦合等式，不要写 `g²_YM = 4πg_s`。**
2. **不要在挂 `maldacena-1997` 的节点上写 `R⁴/α'² = λ = g²_YM N`。** 本文约定下它等于 `2g²_YM N`。
3. **可以安全写的、与约定无关的形式是 `R⁴/α'² = 4πgN`（`g` = 本文的 IIB 弦耦合）**，它在原文中有两处直接背书（E11 的 `R²_sph/α' = √(4πgN)`、E20 的 `R̃⁴ = 4πgN`）。
4. 若图里要引入 `λ`，应新建一条**规范场归一化约定**卡（`conv.ym-coupling-normalization` 之类），并在卡上标明「Maldacena 1997 用的是哪一支」。这正是根 CLAUDE.md 原则 6（约定显式化）要求的场合。

---

### Q3 — `PSU(2,2|4)` 与 `SO(4,2)`：原文都不这么写

- **全文没有出现 `PSU(2,2|4)`**（22 页逐页确认）。原文只说 "the superconformal group"，并把精确代数指给 [3] Haag–Lopuszanski–Sohnius（E6、E8）。
- 玻色对称群原文写 **`SO(2,4) × SO(6)`**（E8、E26），指标顺序与常见的 `SO(4,2)` 相反。
- 其余各 case 的写法同样是「2 在前」：`SO(2,6) × SO(5)`（M5，E31）、`SO(2,3) × SO(8)`（M2，E33）、`SO(2,2) × SO(4)`（D1+D5，E39）、`SO(2,2) × SO(3)`（黑弦，E43）、`SO(2,1) × SO(3)`（RN，E44）。这与附录 (7.1) 的 `SO(2, D−1)` 一致（E48）。

→ **建议**：图节点写对称性匹配时用原文的 `SO(2,4) × SO(6)`；若要用 `PSU(2,2|4)`，**必须换来源**并在 note 里说明「此记号不出自 Maldacena 1997」。

---

### Q4 — 符号 `λ` 在原文里被占用了别的意思

原文 p.7（E22）用 `λ` 表示**共形标度因子**：`ω' = λω`、`U' = λU`。**全文没有用 `λ` 表示 't Hooft 耦合**；原文称 't Hooft 耦合为 "the effective coupling `gN`"（E17）。
→ 图节点若用 `λ`，note 里要写「`λ` 是本项目记号，非 Maldacena 1997 记号」。

---

### Q5 — (5.4) 的 `dt²` 符号看起来与 mostly-plus 不一致

E44 的 (5.4) 页图上印的是 `ds² = α'[ (U²/(g²_4N²))dt² + … ]`，`dt²` 前是**加号**。在 mostly-plus 号差下应为 `−dt²`（对照 (2.5) 里明确写着 `−(1 − U₀⁴/U⁴)dt²`）。
**可能性**（本轮无法裁决）：(a) 原文排印/笔误；(b) 与致谢中提到的、v3 已修的「sign error」相关的残留；(c) 抽取者读图误判。
→ **建议**：§5.2 本来就被作者自评为 "sketchy … unresolved puzzle"（E42、E44），**图里最好根本不建 §5.2 的节点**。若一定要建，须先取 v1/v2 与 ATMP 版三方对照。

---

### Q6 — 原文对该对应关系的措辞：是 "conjecture"，不是 "we propose" 也不是 "we argue"（逐字统计）

这是本次抽取对图 `status` 最直接的输入。**全文逐字统计如下（每条都在上面的 E 条目里可回查）**：

| 位置 | 逐字措辞 | 指向什么 |
|---|---|---|
| Abstract | "**We conjecture that** compactifications of M/string theory on various Anti-deSitter spacetimes **is dual to** various conformal field theories." | 一般对偶 |
| §1 p.1 | "**We will conjecture that** the full quantum M/string-theory on `AdS` space, plus suitable boundary conditions **is dual to** the corresponding brane theory." | 一般对偶 |
| §2 p.4 | "**We are led to the conjecture that** *Type IIB string theory on* `(AdS_5×S^5)_N` *… is dual to* `N=4` *d=3+1* `U(N)` *super-Yang-Mills.*" | **D3 主猜想** |
| §2 p.5 | "The above **conjecture** becomes nontrivial for large `N`" | D3 主猜想 |
| §3.1 p.9 | "**The conjecture is now that** *the (0,2) conformal field theory is dual to M-theory on* `(AdS_7×S^4)_N`" | M5 |
| §3.2 p.10 | "the duality we have **proposed** with M-theory on `AdS_4×S^7`" | M2（**回指式**，唯一一处把该对应叫 "proposed"） |
| §4 p.12 | "**So the conjecture is that** *the 1+1 dimensional CFT … is dual to type IIB string theory on* `(AdS_3×S³)_{Q_1Q_5} × M⁴(Q)`" | D1+D5 |
| §4 p.13 | "All calculations done for the 1D+5D system [39,53,54] **are evidence for this conjecture.**" | D1+D5 |
| §5.1 p.14 | "**In this case we conjecture that** this (0,4) conformal field theory is dual, for large `p^A`, to M-theory on `AdS_3×S²×M⁶_p`." | 五维黑弦 |
| §6 p.16 | "**We further conjectured** that the field theories are **dual to the full quantum M/string theory** on various spacetimes." | 总结 |

而 "**we argue**" 在全文只出现在 §1（E2），指的是**「超引力解在大 N 下可信」**这一步，**不是**指对偶本身。
"**propose / proposal**" 主要用于**另一件事**：「用大 N 场论给出 M/弦论的非微扰定义」这个提议（Abstract 末句、§6）。

→ **结论（可直接写进图节点的 note）**：**Maldacena 1997 对 AdS/CFT 本身自称 `conjecture`，共 9 处；对「超引力解可信」自称 `argue`；对「用大 N 定义 M 理论」自称 `proposal`。** 因此 `duality.ads-cft` 的 `status: conjecture` **有原文逐字背书，不是编者判断**。

---

### Q7 — 现有节点 `duality.ads-cft` 的陈述文本与原文不符（三处）

现有卡片写：

> "N 个重合 D3 膜的近视界极限给出 AdS_5 × S^5 上的 IIB 型弦论，它与四维 N=4 **SU(N)** 超 Yang–Mills 理论完全等价：**两边的配分函数在边界条件与源的对应下相等。**"

与原文（E16 逐字）比对：

| 卡片 | 原文 | 性质 |
|---|---|---|
| `SU(N)` | `U(N)` | **事实性不符**。原文全篇 `U(N)`，且 E19/E23 的 Higgs 论证依赖 `U(N) → U(N−1)×U(1)`、`U(N−M)`、`U(1)^N`，`U` 是本质的 |
| 「配分函数在边界条件与源的对应下相等」 | **原文没有任何配分函数陈述**（22 页逐页确认） | **溯源错误**。这是 GKP (hep-th/9802109) 与 Witten (hep-th/9802150) 1998 年的内容，晚于本文，且不在本文 65 条参考文献里 |
| 「完全等价」 | 原文是 "is dual to"，且带两个限定语「plus some appropriate boundary conditions」「(and possibly also some boundary degrees of freedom)」 | **限定语被丢失**。原文明说边界条件**未指定**（E5、E15、E48） |

→ 处理建议见 §5。

---

### Q8 — 猜想陈述本身有没有大 N 限定？（'t Hooft 版 vs 有限 N 版）

- **斜体的猜想句本身没有任何 `N` 限定**（E16）。
- 但支撑它的论证（E15）逐字写「**for large `N`**」，且下一段说「The above conjecture **becomes nontrivial for large `N`**」（E19）。
- 「't Hooft limit」在原文中只出现一次，定义是 `g → 0`，`gN` fixed `≫ 1`，结论是**谱中有自由 IIB 弦**（E21）；这是**从猜想推出的一条预言**，且原文自陈「**we were not able to check them**」。

→ **本文没有把「有限 N 版」与「't Hooft 版」写成两条不同强度的猜想。** 拆成两个节点是**编者的组织选择**，curator 若要拆，必须标 `inferred: true` 并在 note 里写明「原文只有一条猜想陈述，本图的拆分是编者所为」。

---

### Q9 — 图里 AdS/CFT 应该落在 `duality` 还是 `holography` area？

`graph/schema/areas.yaml` 里 `holography` 的描述正是「AdS/CFT、黑洞熵、Ryu–Takayanagi、岛公式」，而现有种子节点建在 `duality.ads-cft`。id 一旦提交不得更改（graph/CLAUDE.md）。
→ 这是 lead/curator 的裁决题，不是文献问题。**建议新建的 v2 节点统一放 `holography.*`**，并在旧的 `duality.ads-cft` 上写 `superseded_by`。

---

### Q10 — `conv.alpha-prime-regge` 对本文是否成立？

本文用 `α'` 但**全文没有 `T = 1/(2πα')`，也没有 `α'm² = N − a`**（该约定卡的两条实质内容）。
→ 直接给全息节点声明 `uses_conventions: [conv.alpha-prime-regge]` 会写下一条**本文并未使用**的约定。建议 curator 与 auditor 裁决：要么弱化该约定卡，要么新建一条只说「α' 显式保留、`α'→0` 是可取的极限」的约定。

---

### Q11 — M5/M2 的推导在原文里比 D3 弱一级，图里是否应体现？

原文 §3 开头逐字「Basically all that we have said for the D3 brane **carries over**」（E27），**没有**为 M5/M2 重做 proper-energy 论证（E14 只在 D3 做过）、也没有 §2 那样的检验清单。§4（D1+D5）有独立证据（E41），§5 被作者自评 sketchy（E42）。
→ 建议在 M5/M2/D1+D5/黑弦 的 derivation `gaps` 里各写一条，说明「原文以类比方式处理，未重做退耦论证」。这是**原文自述**，不是编者推断。

---

## 5. 给图的建议

> 以下是**建议**，不是改动。researcher 只写 `literature/`（`literature/CLAUDE.md` 规则 4），下列节点由 curator 落地。

### 5.1 核心结论：原文把主张分成两级，图必须拆成两个节点

**证据是文首文末两处独立的逐字对照（E1 与 E45）**：

| 级别 | 原文措辞 | 内容 | 建议 status |
|---|---|---|---|
| 高 | "We **show** that …" / "we **conclude** that …" / "we have **shown** that …" | 大 N 下，`N=4 U(N)` SYM 的 **Hilbert 空间包含 (AdS₅×S⁵)_N 上 IIB *超引力* 的态** | **`physical-argument`**（依赖幺正性 + 有限 Hawking 温度 + 大 N + proper-energy 论证，全是物理式推理，无严格证明） |
| 低 | "We are led to the **conjecture** that …" / "We further **conjectured** that …" | **完整 IIB 弦论**（含边界条件与可能的边界自由度）与 SYM **对偶** | **`conjecture`** |

现有单节点 `duality.ads-cft` 把两级混成一条，**丢掉了原文明确区分的信息**。

### 5.2 建议的 v2 节点集合

**（a）定义/约定层**

| 建议 id | kind | 内容 | loc（v3） | 抽取条目 |
|---|---|---|---|---|
| `holography.d3-decoupling-limit` | definition | `α'→0`，`U ≡ r/α'` 固定，`g` 与 `N` 固定 | (2.1)，p.2 | E7 |
| `holography.ads-radius-convention` | convention 或 definition | AdS「radius」`R` 按双曲面 (7.1) 定义 | (7.1)–(7.3)，p.17–18 | E48 |
| `holography.d3-coupling-dictionary` | definition | **逐字抄** `1/g²_YM + iθ/8π² = (1/2π)(1/g + iχ/2π)`；note 必须写 Q2 的因子警告 | §2 p.4 | E16 |
| `holography.ads5s5-radius-dictionary` | proposition | `R²_sph/α' = √(4πgN)`，且 `R_sph = R_AdS`；Planck 单位下 ∝ `N^{1/4}` | (2.3) 后，p.3；+ p.6 的 `R̃⁴ = 4πgN` | E11、E20 |

**（b）几何层**

| 建议 id | kind | status | 内容 | loc | 抽取条目 |
|---|---|---|---|---|---|
| `holography.d3-near-horizon-ads5s5` | proposition | `physical-argument` | 在 (2.1) 下丢掉调和函数里的 1，(2.2) 化为 (2.3) = `AdS_5×S^5` | (2.2)–(2.3)，p.3 | E9、E10 |
| `holography.d3-sugra-validity-window` | proposition | `physical-argument` | `gN ≫ 1`（`g ≤ 1`）/ `N/g ≫ 1`（`g > 1`） | (2.4) + 脚注 5，p.3 | E12 |
| `holography.decoupling-limit-nondegenerate` | proposition | `physical-argument` | proper energy 不塌缩，Planck 长度有限 | §2 p.4 | E14 |

**（c）对偶层——本次抽取的主产出**

| 建议 id | kind | status | 陈述要点 | 抽取条目 |
|---|---|---|---|---|
| `holography.n4sym-contains-iib-sugra-states` | proposition | **`physical-argument`** | 「大 `N` 下，4d `N=4 U(N)` SYM 的 Hilbert 空间包含 `(AdS_5×S_5)_N` 上 IIB **超引力** 的态，特别是其上传播的引力子」 | **E15**（"we conclude"） |
| `holography.ads5-cft4-duality-v2` | proposition | **`conjecture`** | 「IIB **弦论** on `(AdS_5×S^5)_N`，**加上适当的边界条件（可能还要加边界自由度）**，与 4d `N=4` `U(N)` SYM 对偶」——**逐字保留两个限定语，写 `U(N)`，不写配分函数** | **E16** |
| `holography.ads7-s4-m5-duality` | proposition | `conjecture` | 6d (0,2) CFT ↔ M 理论 on `(AdS_7×S^4)_N` | E31 |
| `holography.ads4-s7-m2-duality` | proposition | `conjecture` | 3d CFT ↔ M 理论 on `AdS_4×S^7` | E33 |
| `holography.ads3-s3-d1d5-duality` | proposition | `conjecture` | D1+D5 Higgs 分支 CFT ↔ IIB on `(AdS_3×S³)_{Q_1Q_5}×M⁴(Q)` | E39、E40 |
| （不建议建）§5.1 黑弦、§5.2 RN | — | — | 原文自评 sketchy / unresolved puzzle | E42、E43、E44、Q5 |

**（d）推导层**

```
holography.n4sym-contains-iib-sugra-states--via-decoupling-limit
  kind: physical-argument      status: physical-argument
  depends_on: d3-decoupling-limit, d3-near-horizon-ads5s5,
              d3-sugra-validity-window, decoupling-limit-nondegenerate,
              〈近极端黑 D3 膜解 (2.5)〉, 〈SYM 的幺正性〉
  sources: maldacena-1997, loc "§2, p.4（"we conclude that…"）；式 (2.1)–(2.5)"

holography.ads5-cft4-duality-v2--via-extrapolation-beyond-sugra
  kind: conjecture-support     status: conjecture
  depends_on: holography.n4sym-contains-iib-sugra-states
  sources: maldacena-1997, loc "§2, p.4"
  summary: 原文逐字「it is natural to think that this correspondence goes beyond
           the supergravity approximation」——**这一步是外推，原文自己这么说**
  gaps: ["边界条件未指定（原文 §1、§2、§7 三处承认）",
         "可能需要额外的边界自由度（原文猜想句里的括号）"]

holography.ads5-cft4-duality-v2--via-symmetry-matching
  kind: conjecture-support     status: conjecture
  depends_on: 〈superconformal algebra〉, 〈AdS_5×S^5 的等距+超对称〉
  sources: maldacena-1997, loc "§2, p.2 与 p.4"
  summary: 玻色对称 SO(2,4)×SO(6) 两边一致；超对称数目两边一致。
  notes: 原文逐字「All this is valid for any N.」——**这条支持不依赖大 N**，
         与 --via-extrapolation 是独立的边
```

### 5.3 原文自列的检验清单（建议放进 derivation 的 `summary`/`gaps`，或单独一张 evidence 卡）

| 检验 | 原文自评 | 抽取条目 |
|---|---|---|
| 超对称/共形对称匹配 | 陈述句，任意 `N` 成立 | E6、E8 |
| 探针 D3 膜 Born–Infeld 作用量由（破缺的）共形不变性决定 | ⚠ **原文自己降格**：「This would be saying that (2.6) is a consequence of the symmetries and **thus not a prediction**」 | E19、E20 |
| Higgs / 多中心：`U(N)→U(N−M)×U(M)` 与三个 AdS 区域 | 陈述句；「we **naively** get」用于全分离情形 | E23 |
| 紧化到环面的温度/尺度条件与 [22] 一致 | 「of course, the same condition」 | E24 |
| 膨胀子与引力子的吸收截面 | 引 [24,25]；[26] 归因于非重整化定理 | E25 |
| 黑洞熵 vs **微扰** YM | ⚠ **「agrees up to a numerical factor … this problem remains unsolved」；原文没写 `3/4`** | E25 |
| M2 熵 | ⚠ 「the `N` dependence or the numerical coefficients are **not understood**」 | E34 |
| D1+D5 的 greybody factors / BTZ | 「**are evidence for** this conjecture」——全文唯一一处这么说 | E41 |
| 't Hooft 极限中有自由 IIB 弦 | ⚠ **是预言不是检验**：「though **we were not able to check them**」 | E21 |

### 5.4 原文自己承认的假设与缺口（建议全部进 `gaps`）

1. **边界条件未指定**（三处：§1「we leave this interesting problem for the future」；§2「The gauge theory should provide us with a specific choice of boundary conditions. It would be interesting to determine them.」；§7「It would be interesting to understand what the other regions in the `AdS` spacetime correspond to.」）—— E5、E15、E48。
2. **可能还需要边界自由度**（猜想句括号里）—— E16。
3. **超引力可信要 `gN ≫ 1`（或 `N/g ≫ 1`）**；对称性匹配则「valid for any `N`」—— E8、E12。
4. **D1+D5 的猜想需要一条未证明的非重整化定理与 Higgs/Coulomb 分支退耦**（「It is necessary for this conjecture to work that…」「A non renomalization theorem like [44,45] **would** explain this」）—— E40。
5. **黑弦情形的必要条件作者明说不知道是否成立**（「It is not clear to me whether this is true.」）—— E43。
6. **§5 整节作者自评 sketchy**，§5.2 自评 unresolved puzzle —— E42、E44。
7. **没有构造引力子渐近态**（「we have not shown here how to construct graviton states」）—— E46。
8. **M5/M2 靠「carries over」类比，没有重做退耦论证** —— E27、Q11。

### 5.5 **不得**挂到 `maldacena-1997` 的东西（红线清单）

| 内容 | 为什么不行 | 正确出处 |
|---|---|---|
| 「两边配分函数相等」/ GKP–Witten 字典 | **本文完全没有**（22 页逐页确认） | GKP hep-th/9802109、Witten hep-th/9802150（1998，晚于本文，且不在本文 65 条参考文献里） |
| 熵的 `3/4` 因子 | **本文没有这个数**，只说「up to a numerical factor」 | Gubser–Klebanov–Peet hep-th/9602135（本文 [23]） |
| `SU(N)` | 本文一律 `U(N)`，且 Higgs 论证依赖 `U` | —— |
| `PSU(2,2|4)` | 本文没有这个记号 | 需另找来源 |
| `g²_YM = 4πg_s`、`R⁴/α'² = λ = g²_YM N` | 本文的字典给的是 `g²_YM = 2πg`、`R⁴/α'² = 2g²_YM N` | 见 Q2 |
| `SO(4,2)` | 本文一律写 `SO(2,4)` | —— |
| 「Maldacena 证明了 AdS/CFT」类表述 | 原文 9 处自称 `conjecture` | 见 Q6 |
| 参考文献 [23] 的 "A. Strominger, unpublished" 与 [62] 的 "private communication" | `literature/CLAUDE.md` 规则 1 禁止登记未发表材料 | 只能作为原文脚注/引用内容记录 |

### 5.6 建议同时更新的既有文件

- `graph/statements/duality/ads-cft.yaml`：`SU(N)` → `U(N)`；删除「配分函数」句（或迁到未来的 GKP/Witten 节点）；`loc` 从 "§2–§3" 精确化为 "§2, p.4（猜想句）；式 (2.1)–(2.3)"。**因 id 不可改，建议新建 v2 并在此写 `superseded_by`。**
- `graph/derivations/duality/ads-cft--via-decoupling-limit.yaml`：`loc: "§2"` → `"§2, 式 (2.1)–(2.5)；p.4"`；`summary` 里「加上对称性（PSU(2,2|4)）匹配」应改为原文的 `SO(2,4)×SO(6)` + "the superconformal group"（见 Q3）。
- `literature/sources.bib`：`maldacena-1997` 加 `note` 写死「loc 依 arXiv v3」（见 Q1）。

---
