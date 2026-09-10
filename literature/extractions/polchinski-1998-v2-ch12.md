# 抽取记录：polchinski-1998-v2 第 12 章（Superstring interactions）

- 文献：J. Polchinski, *String Theory. Vol. 2: Superstring Theory and Beyond*, Cambridge University Press, 1998。
  本轮实读 **Cambridge Books Online 版**（© Cambridge University Press 2001, 2005；DOI 10.1017/CBO9780511618123；
  页脚水印 "Downloaded from https://www.cambridge.org/core … Cambridge Books Online © Cambridge University Press 2010"）。
- 抽取者：researcher agent
- 日期：2026-09-11
- 覆盖范围：**第 12 章全章，书页 pp. 84–135（PDF 52 页）逐页读图**。重点抽 §12.2（Anomalies，pp. 94–103）。
- 关联记录：`literature/extractions/polchinski-1998-v2.md`（ch.10–11，E1–E63）。
  **本文件 E 编号从 E1 重新起算**，引用时必须写 `polchinski-1998-v2-ch12#E<n>`，不要与上一份混号。
- 交叉核对记录：`literature/extractions/gsw-1987-v2.md`（GSW ch.10 + ADT + Antonelli）、
  `literature/extractions/green-schwarz-1984.md`、`literature/extractions/zumino-wu-zee-1984.md`。

---

## 0. 获取途径与证据等级

### 0.1 获取途径（一次成功，无阻碍）

按 `reading-list.md` §「已知获取路线备忘」的 Cambridge Core 路线，**文件名可直接推出，省掉 abs 页那一跳**：

```
书目页  https://www.cambridge.org/core/books/string-theory/2D456468D20AA8A9CE10CEB08B95B9DC
ch.12   item hash 46D902501550C028C94F24884F4B9D7A ，页范围 84–135
PDF     https://www.cambridge.org/core/services/aop-cambridge-core/content/view/
        46D902501550C028C94F24884F4B9D7A/9780511618123c3_p84-135_CBO.pdf/superstring_interactions.pdf
```

落盘 **682.8 KB / 52 页**（≈13 KB/页 —— 印证「Polchinski 是排版重制电子书，不受 10 MB 上限威胁」；
对照 GSW 扫描件约 240 KB/页）。WebFetch 的总结器照例以版权为由拒绝概括，**忽略即可，PDF 已落盘**，用 `Read` 带 `pages` 逐页读图。

**本轮顺带把 Vol.2 剩余 item hash 补全**（书目页 L1）：foreword `7E0461172EFC9FD46DF4B14EB59CC849`(xiii–xiv)、
preface `16FF8CF455EFF0D314451B27D566DE81`(xv–xvii)、ch.13 D-branes `67EE13E32046F0D121B589DC02989698`(136–177)、
ch.14 `42973BC3975BD6057BD6B92455DC8507`(178–227)、ch.15 Advanced CFT `D7C488602138F0172CFC84FAAD81432A`(228–273)、
ch.16 `ADD5943B7F21890CE6D0C9C38B055E94`(274–301)、ch.17 `D4ED937166A0959DD5AADA7A9FF787D1`(302–326)、
ch.18 `7C6170A1B90D3153367ADE060058A486`(327–374)、ch.19 `398330CF57E92B5A78F131A0407BD869`(375–429)、
App.B `872CC69E98F684AFA1019EB2A955BD11`(430–466)、References `B294A2903028C82BE0FD5C19FC4C5890`(467–487)、
Glossary `69846877E86A0719EB9DB58254EBB5DE`(488–517)、Index `9219B5E10873678567E837F7BFA76036`(518–531)。
正文文件名一律 `9780511618123c<章号−9>_p<起>-<止>_CBO.pdf`。

### 0.2 证据等级

| 标记 | 含义 |
|---|---|
| `[L1 原书]` | 抽取者本轮逐页读了该书页的**页图**，式号与公式内容都直接看到。**本记录几乎全部条目是这一级。** |
| `[L1 ADT]` | 出自 `arXiv:1006.1352v2` PDF 页图（本轮重读 pp. 1–3），用作独立第二源 |
| `[抽取者复算]` | 抽取者本人做的代数验算，**不是原书文字**，转节点时必须重做或标 `inferred` |
| `[读图存疑]` | 页图上小字号（阶乘、下标）可能读错，见 §3 |

**「文献自称的严格程度」一栏全部照抄原文动词**，与 ch.10–11 记录同一体例。

### 0.3 ⚠ 派工单范围与原书实际结构的偏差（**必须先看**，第二次踩同类坑）

派工单写「**§12.2 反常、§12.5 一致性/四解分类相关**」。按 L1 页图：

- **§12.5 的标题是 "General amplitudes"**（p. 118），内容是 picture / PCO / 超黎曼面 / 超模空间测度，
  **与规范群分类毫无关系**。
- **「四解」（含 `E₈×U(1)²⁴⁸` 与 `U(1)⁴⁹⁶`）在本书里只出现一次：§12.2 第 101 页的脚注 1，一句话。** 见 E14。
- 本章真实分节（[L1 原书] 逐页确认起始页）：
  **12.1 Low energy supergravity p.84 / 12.2 Anomalies p.94 / 12.3 Superspace and superfields p.103 /
  12.4 Tree-level amplitudes p.110 / 12.5 General amplitudes p.118 / 12.6 One-loop amplitudes p.126 /
  Exercises pp.134–135（12.1–12.11）**。
- 与派工单第 (5) 问相关的**弦论侧单圈计算在 §12.6**（不在 §12.5），见 E23–E25。

→ 这是继「§11 是杂化弦不是 GSO」之后**第二次**派工单章节假设不成立。
**建议：给 Vol.2 派活前先查 `polchinski-1998-v2.md` §0.4 的节标题表（现已可补上本章分节）。**

---

## 1. 约定

### 1.1 §12.2 自己声明的记号约定（**回答派工单第 (4) 问**）

**[L1 原书, p. 97，(12.2.13) 下方，逐字]：**

> "The 'tr' denotes the trace on the tangent space indices *p*, *q*. In this section we will write products
> and powers of forms without the ∧, to keep expressions compact. The 'Tr' denotes the trace of the field
> strength in the representation carried by the fermion. In particular, *n* = Tr(1) is the dimension of the
> representation *r*. If the representation *r* is reducible, *r* = *r₁* + *r₂* + …, the corresponding traces
> add: Tr_r = Tr_{r₁} + Tr_{r₂} + …."

要点：

1. **`tr` = 切空间（Lorentz）指标的迹，只用在 `R₂` 上**；**`Tr` = 规范群某表示的迹，只用在 `F₂` 上**。
   下标区分表示：**`Tr_v` = 矢量表示，`Tr_a` = 伴随表示**（(12.1.34c)、(12.2.19)、(12.2.27) 等处出现）。
2. **`∧` 在 §12.2 内一律省略**（(12.2.15)(12.2.21)(12.2.27) 里的并列即楔积）。
   ⚠ 但在 **§12.1 里 `∧` 是写出来的**（(12.1.1)(12.1.10d)(12.1.36) 等），**同一章内不统一**。
3. `n = Tr(1)` 是表示 `r` 的维数；对 (12.2.27) 而言 `r = adjoint`，故 `n` = 规范生成元总数。

### 1.2 `E₈` 的迹归一化（**这条与 Bilal / GS 的换算直接相关**）

**[L1 原书, p. 93，§12.1「Heterotic strings」末段，逐字]：**

> "For `E₈ × E₈` there is no vector representation, but it is convenient to use a normalization that is uniform
> with `SO(32)`. In place of `Tr_v(t^a t^b)` in the action use `(1/30)Tr_a(t^a t^b)`. This has the property that
> for fields in any `SO(16) × SO(16)` subgroup it reduces to `Tr_v(t^a t^b)`."

⇒ **Polchinski 的「统一归一化」= `(1/30)Tr_a`，与 Bilal arXiv:0802.0634 (12.28) 定义的 `trF² ≡ (1/30)TrF²` 是同一件事。**
这条独立佐证了 `green-schwarz-1984.md` 里记的「E₈ 侧 `tr` vs `Tr` 差一个 1/30」。
**内部一致性检验（[L1 原书] + [抽取者复算]）**：(12.6.21) 的两个写法相等要求 `Tr_a(F₂²) = (6!/4!)·F₂·F₂ = 30 F₂·F₂`，
即 `F₂·F₂` 就是 `(1/30)Tr_a(F₂²)` —— 与 p.93 的声明自洽。

### 1.3 与其它文献的 tr/Tr 对照（**关键：不是同一套**）

| 文献 | 规范群基本/矢量表示的迹 | 规范群伴随表示的迹 | Lorentz（切空间）迹 | 证据 |
|---|---|---|---|---|
| **Polchinski v2 ch.12** | `Tr_v` | `Tr_a` | **`tr`** | [L1 原书 p.97, p.92] |
| **ADT 2010** | （未用） | **`Tr`**（无下标） | **`tr`**（自称 "trace in the fundamental of `SO(1,9)`"） | [L1 ADT p.2] |
| **GS 1984 / GSW v2 ch.10** | **`tr`** | **`Tr`** | `tr`（同一个符号，靠宗量区分） | `green-schwarz-1984.md`；`gsw-1987-v2.md` §7（GSW p.149 逐字） |

⚠ **最容易出错的一点：`tr` 在 Polchinski/ADT 里是 Lorentz 迹，在 GS/GSW 里是规范群基本表示的迹。**
把 GS 的 `tr F²` 直接抄成 Polchinski 的 `tr F²` 就错了（后者根本不允许 `tr` 作用在 `F₂` 上）。
**Polchinski↔ADT 之间可以逐符号对译（`Tr_a ↔ Tr`，`tr ↔ tr`），Polchinski↔GS 之间不能。**

### 1.4 规范场的厄米性与 CS 项系数

- `δA₁ = dλ − i[A₁, λ]`（(12.1.37) 上方，[L1 原书 p.92]）⇒ **`A` 取厄米约定**，因此 CS 项里带 `i`：
  `ω₃ = Tr_v(A₁∧dA₁ − (2i/3)A₁∧A₁∧A₁)`（(12.1.36)）、`ω_{3Y} = A₁dA₁ − (2i/3)A₁³`（(12.2.22) 下方）。
- Lorentz CS 项**不带 `i`**：`ω_{3L} = ω₁dω₁ + (2/3)ω₁³`（(12.2.23)），因为自旋联络 `ω₁ ≡ ω_μ{}^p{}_q dx^μ` 是实反对称的。
- ⇒ **`−2i/3` 与 `+2/3` 的差别是厄米/反厄米约定造成的，不是笔误**。ADT (3) 写 `+ (2/3)f^{abc}A^aA^bA^c`（分量式）。

### 1.5 其它（与 ch.10–11 记录相同或新增）

| 项 | 取法 | 证据 |
|---|---|---|
| 号差 | 沿用 `(−,+,…,+)`；本章未重申，但 §12.3 用 `ln|z₁₂|²` 型传播子与 ch.10 一致 | [L1 原书]（本章无显式声明，**若图里要挂号差，来源仍应指 ch.10 p.3**） |
| `α'` | §12.1–12.2 显式保留；**§12.3 明写 "In this section we set `α' = 2` to make the structure clearer"**（p.105，(12.3.19) 下方） | [L1 原书 p.105 逐字] |
| `2κ₁₀² = 1` 归一 | (12.1.4) 下方「The normalization of the kinetic terms is canonical for `2κ₁₀² = 1`」 | [L1 原书 p.86] |
| `B_{μν}` 归一 | **p.106 末逐字警告："The reader should beware of a common convention in the literature, `B^here_{μν} = 2B^there_{μν}`."** | [L1 原书 p.106] ★ 与 GS/Bilal 对 `B` 的符号之争同类，转卡时值得挂上 |
| `κ²/g²_YM` | `= α'/4`（(12.3.36)/(12.3.37)），由世界面反常导出 | [L1 原书 pp.107–108] |
| 流代数 level | 本章约定 `k̂ = 1/2`（(12.4.10) 上方与 (12.6.9) 下方「We continue to use the convention `k̂ = 1/2` for the rest of the chapter」） | [L1 原书 pp.112, 128] |

---

## 2. 陈述

### E1 反常使局域对称性理论不一致（本章对「反常」的定性）
- 位置：§12.2 开头，p. 94，无式号。`[L1 原书]`
- 类型：definition / proposition（定性）
- 原文（逐字）："In general, anomalies in local symmetries make a theory inconsistent, as unphysical degrees of
  freedom no longer decouple. Anomalies in global symmetries are not harmful but imply that the symmetry is
  no longer exact."
- 自称严格程度：无动词标记（陈述式）。
- 依赖：无（引 ch.3 的 Weyl 反常作类比）。
- 备注：这是全项目「反常 ⇒ 不一致」这条边在 Polchinski 里的**唯一出处**，措辞是 "make a theory inconsistent"，
  不是 "is inconsistent iff"。

### E2 弦论侧反常必然为零（本章的元论断）
- 位置：§12.2, p. 94，无式号。`[L1 原书]`
- 原文（逐字）："If the theories we have constructed are consistent these anomalies must be absent, **and in
  fact they are.** Although this can be understood in purely string theoretic terms it can also be understood
  from analysis of the low energy field theory, and it is useful to take both points of view."
- 自称严格程度：**"and in fact they are"**——断言式，**本节并不在此处给出证明**；证明分散在 E20（条件式论证）
  与 E23–E25（一个具体单圈振幅）。
- 备注：**转节点时不要把这句话当成「已证」**。真正的论证见 E20 的两个 "if"。

### E3 二维反常与 `k̂_L = k̂_R`（充要条件）
- 位置：§12.2, (12.2.1)–(12.2.5), pp. 94–95。`[L1 原书]`
- 原文（逐字，p.95）："For a non-Abelian theory the higher order terms are more complicated but the condition
  `k̂_L = k̂_R` for the symmetry to be preserved is still **necessary and sufficient**."
- 自称严格程度：**"necessary and sufficient"**，但**非阿贝尔情形的高阶项本书未算**（"more complicated"）。
- 依赖：`jj` OPE（ch.11 §11.5）。
- 备注：(12.2.5) `Z'[A] = Z[A] + 2πk̂∫d²z A^a_z A^a_z̄ = (k̂/2)∫d²z₁d²z₂ ln|z₁₂|² F^a_{zz̄}(z₁)F^a_{zz̄}(z₂)` 是规范不变形式。

### E4 反常由无质量谱决定，与短距细节无关
- 位置：§12.2, pp. 95–96，无式号。`[L1 原书]`
- 原文（逐字）："the anomalies are unaffected if we add additional massive degrees of freedom. This follows from
  a field theory decoupling argument. … Any gauge variation of this can therefore be written as the variation
  of a local operator, and removed by a counterterm. For this reason the anomalies in superstring theory are
  determined by the massless spectrum, independent of the stringy details at short distance."
- 自称严格程度：**"follows from a field theory decoupling argument"**——引论证类型，不给引文、不给证明。
- 备注：★ **这是「用低能场论算反常 = 用弦论算反常」这条桥的全部依据**，图里挂它时 status 应为 `physical-argument`。

### E5 二维与四维的反常抵消条件
- 位置：(12.2.6a,b,c)（d=2）与 (12.2.7a,b)（d=4），p. 96。`[L1 原书]`
- 内容：`Σ_L q² − Σ_R q² = 0`；`Σ_L 1 − Σ_R 1 = 0`；`Σ_L q − Σ_R q = 0`；`Σ_L q³ = 0`；`Σ_L q = 0`。
- 原文（逐字，(12.2.7) 下方）："If there is more than one gauge group the necessary and sufficient condition for
  anomaly cancellation is that the above hold for every linear combination of generators."
- 备注：纯算术条件，Lean 岛候选（低价值，但零成本）。

### E6 ★ 十维反常来自六边形图，且**本书不做这个计算**
- 位置：§12.2, p. 96，无式号。`[L1 原书]`
- 原文（逐字）："The IIA theory is parity-symmetric and so automatically anomaly-free, while the others have
  potential anomalies. In ten dimensions the anomaly involves amplitudes with six currents (the hexagon graph)
  and is of fifth order in the field strengths and curvatures. **The calculation has been done in detail in the
  literature; we will not repeat it here but just quote the result.**"
- 自称严格程度：**"we will not repeat it here but just quote the result"** —— 外包。
- 依赖：外部文献（本页不给引文；References 章未查）。
- 备注：★★ **(12.2.11)–(12.2.13) 三个反常多项式在本书里没有推导**。与 `green-schwarz-1984.md` 的
  「GS 把所有系数外包给 AGW」是同一个缺口，只是 Polchinski 连引文都没给在正文里。

### E7 四标架形式与两个局域对称性
- 位置：(12.2.8) `e_μ{}^p(x)' = e_μ{}^q(x)Θ_q{}^p(x)`，p. 96。`[L1 原书]`
- 原文（逐字）："Both are necessary for the decoupling of unphysical degrees of freedom, and in fact when there
  is a coordinate anomaly one can by adding counterterms to the action convert it to a Lorentz anomaly, which
  closely resembles a gauge anomaly."
- 自称严格程度："one can … convert" —— 无证明、无引文。
- 备注：这是「坐标反常 ↔ Lorentz 反常」的转换约定；GSW/AGW 侧对应的是同一件事。

### E8 反常多项式与下降方程
- 位置：(12.2.9) `Î_{d+2} = dÎ_{d+1}`，`δÎ_{d+1} = dÎ_d`；(12.2.10) `δ ln Z = (−i/(2π)⁵)∫Î_d(F₂,R₂)`。p. 97。`[L1 原书]`
- 原文（逐字，(12.2.9) 上方）："The anomaly can be written in compact form in terms of an *anomaly polynomial*,
  a formal `(d+2)`-form `Î_{d+2}(R₂,F₂)`. This has the property that it is the exterior derivative of a `(d+1)`-form,
  whose variation is the exterior derivative of a `d`-form."
- 原文（(12.2.10) 下方）："The anomaly cancellation condition is that the total anomaly polynomial vanish."
- 自称严格程度：定义 + 断言其性质；**不证下降方程，不引 Zumino/Stora**。
- 备注：★ **(12.2.10) 的整体常数 `−i/(2π)⁵` 是显式给出的**。这和
  `zumino-wu-zee-1984.md` 的结论（GS 的常数 `c` 在 AGW/ZWZ/Zumino-Les-Houches 三篇里都不以一个数的形式存在）
  形成对照：**Polchinski 给了一个具体归一化，但没说它从哪来。** ⚠ 它与 GS 的 `c` **不是同一个量**
  （`c` 是 `X₈`/`Y₄` 分解里的常数），不要直接等同 —— 这一点仍是开放的（Q4）。
  ⚠ 只在 `d = 10` 时 `(2π)⁵` 才是这个幂次；(12.2.10) 写成通式但指数写死为 5，见 §3。

### E9 三种手征场的反常多项式（**本章最核心的公式，回答派工单第 (1) 问的第一半**）
- 位置：(12.2.11)（Majorana–Weyl **8**）、(12.2.12)（Majorana–Weyl **56**）、(12.2.13)（self-dual tensor），p. 97。`[L1 原书]`
- 原文（引入句逐字）："In the ten-dimensional supergravity theories there are three kinds of chiral field: the
  spinors **8** and **8′**, the gravitinos **56** and **56′**, and the field strengths `[5]₊` and `[5]₋` of the IIB
  theory. Parity interchanges the two fields in each pair so these make opposite contributions to the anomaly.
  **The anomaly polynomials have been calculated.**"
- 公式（逐字转录）：

```
Î_8(F₂,R₂) = − Tr(F₂⁶)/1440
             + Tr(F₂⁴)tr(R₂²)/2304 − Tr(F₂²)tr(R₂⁴)/23040 − Tr(F₂²)[tr(R₂²)]²/18432
             + n tr(R₂⁶)/725760 + n tr(R₂⁴)tr(R₂²)/552960 + n [tr(R₂²)]³/1327104        (12.2.11)

Î_56(F₂,R₂) = −495 tr(R₂⁶)/725760 + 225 tr(R₂⁴)tr(R₂²)/552960 − 63 [tr(R₂²)]³/1327104    (12.2.12)

Î_SD(R₂)    = 992 tr(R₂⁶)/725760 − 448 tr(R₂⁴)tr(R₂²)/552960 + 128 [tr(R₂²)]³/1327104     (12.2.13)
```

- 自称严格程度：**"have been calculated"**（被动语态，不说谁算的，正文不给引文）。见 E6。
- 依赖：E6（外包给文献）。
- 备注：⚠ (12.2.12) 的宗量写成 `Î_56(F₂,R₂)`（见 (12.2.27) 的用法）但式子里只有 `R₂`；
  (12.2.14) 里又写作 `Î_56(R₂)`。**同一符号两种宗量写法，转卡时统一取 `Î_56(R₂)`。**

### E10 ★ IIB 反常抵消（**可完全机检**）
- 位置：(12.2.14) `Î_IIB(R₂) = −2Î_8(R₂) + 2Î_56(R₂) + Î_SD(R₂) = 0`，p. 98。`[L1 原书]`
- 原文（逐字）："In type IIB supergravity there are two **8′**s, two **56**s, and one `[5]₊`, giving the total
  anomaly polynomial … There are no gauge fields so only the three purely gravitational terms enter, and the
  coefficients of these conspire to produce zero total anomaly."
- 自称严格程度：直接断言（"conspire to produce zero"），**不展示算术**。
- **`[抽取者复算]`（已验，三条系数逐一）**，取 `n = Tr(1) = 1`（中性场）：
  - `tr(R₂⁶)`：`(−2·1 + 2·(−495) + 992)/725760 = (−2 − 990 + 992)/725760 = 0` ✔
  - `tr(R₂⁴)tr(R₂²)`：`(−2·1 + 2·225 − 448)/552960 = (−2 + 450 − 448)/552960 = 0` ✔
  - `[tr(R₂²)]³`：`(−2·1 + 2·(−63) + 128)/1327104 = (−2 − 126 + 128)/1327104 = 0` ✔
  ⇒ **(12.2.14) 是三条整数恒等式，`decide`/`norm_num` 一行可证。Lean 岛候选，见 §5.4 A8。**
  ⚠ `n = 1` 这一步是抽取者按 E9 的 "`n = Tr(1)` 是表示维数、中性场即平凡表示" 推出的，**原书没有明写**，转卡须标 `inferred`。

### E11 IIB 手征一致性「像是巧合」（作者自评）
- 位置：§12.2, p. 98，无式号。`[L1 原书]`
- 原文（逐字）："From the point of view of the low energy theory, this is somewhat **miraculous**. In fact, it
  seems **accidental** that there are any consistent chiral theories at all. There are three anomaly terms that
  must vanish and three free parameters … Barring a numerical coincidence the only solution would be that all
  these differences vanish, a nonchiral theory. **One can view string theory as explaining this numerical
  coincidence**: the conditions for the internal consistency of string theory are reasonably straightforward,
  and having satisfied them, the low energy theory must be nonanomalous."
- 备注：★ 这是本书最明确的一处「低能场论侧的抵消是巧合，弦论侧才是解释」。对图里 `consistency` 区的
  **推导方向**有直接含义：Polchinski 认为箭头是「弦论一致性 ⇒ 低能反常为零」，不是反过来。

### E12 ★ GS 机制：`SO(n)` 迹恒等式（**回答派工单第 (4) 问的第二半**）
- 位置：(12.2.19a,b,c)，p. 99。`[L1 原书]`

```
Tr_a(t²) = (n − 2) Tr_v(t²)                                (12.2.19a)
Tr_a(t⁴) = (n − 8) Tr_v(t⁴) + 3 Tr_v(t²)Tr_v(t²)           (12.2.19b)
Tr_a(t⁶) = (n − 32) Tr_v(t⁶) + 15 Tr_v(t²)Tr_v(t⁴)         (12.2.19c)
```

- 原文（逐字，上方）："The pure gauge anomaly polynomial has a different group-theoretic form `Tr_a(F₂⁶)`, now in
  the adjoint representation because the charged fields are gauginos. However, for certain algebras there are
  relations between the different invariants. For `SO(n)`, it is convenient to convert all traces into the vector
  representation. The fermions of the supergravity theory are always in the adjoint; in terms of the vector
  traces these are …"
- 原文（逐字，下方）："Here `t` is any linear combination of generators, but this implies the same relations for
  symmetrized products of different generators. Symmetrized products appear when the anomaly polynomial is
  expanded in sums over generators, because the 2-forms `F₂^a` and `F₂^b` commute."
- 自称严格程度：**无证明；Exercise 12.1 逐字："Derive the `SO(n)` trace identities (12.2.19). You can assume a
  basis in which the generator `t` is a linear combination of the commuting generators `H^i`."**（p. 134）
- 备注：与 **GSW (10.1.12)–(10.1.14)（`l = −1` 支）** 和 **GS 1984 (12c)** 逐项一致
  （见 `gsw-1987-v2.md` §5.4 A6）。**Polchinski 不给 `USp(n)` / `U(n)` 支** —— GSW 给了。
- 原文（(12.2.19) 下方，逐字）："The last of these identities implies that **precisely for `SO(32)`** the gauge
  anomaly `Tr_a(F₂⁶)` is equal to a product of lower traces and so can be canceled by the variations of `S'` and
  `S''`. **This is the Green–Schwarz mechanism.** This is of course the same `SO` group that arises in the type I
  and heterotic strings, and not surprisingly the necessary interactions occur in these theories with the
  correct coefficients."
  ⚠ **"precisely for `SO(32)`" 的适用域只是 `SO(n)` 族**（上文限定 "For `SO(n)`"），**不是全体李代数**。

### E13 `E₈` 的迹归约
- 位置：(12.2.20) `Tr_a(t⁴) = (1/100)[Tr_a(t²)]²`，`Tr_a(t⁶) = (1/7200)[Tr_a(t²)]³`，p. 100。`[L1 原书]`
- 原文（逐字，下方）："Using the relation `Tr_a(t^m) = Tr_{a1}(t^m) + Tr_{a2}(t^m)`, it follows that the sixth
  power trace can be reduced for `E₈ × E₈` as well (**with only one factor of `E₈` the gravitational anomaly does
  not cancel, as we will see**)."
- 自称严格程度：**"it follows that"**，不给推导；Exercise 12.2 逐字："Obtain the trace relations (12.2.20) for
  `E₈`, and show that `Tr_a(t⁶)` can be reduced to lower order traces for `E₈ × E₈`."（p. 134）
- 备注：与 GS 1984 (12b′) `Ω₈ = (1/100)(trF²)²` 一致（GS 对 `E₈` 取 `tr = Tr`）。
  ⚠ 「一个 `E₈` 因子不行」的原因原文明说是**引力**反常（`n = 248 ≠ 496`），不是规范反常。

### E14 ★★★ 十维 N=1 总反常多项式、因子化条件与「四解」（**回答派工单第 (1)(2) 问**）
- 位置：**(12.2.27)、(12.2.28a,b)、(12.2.29) 与 p. 101 脚注 1**。`[L1 原书]`
- 原文（引入句逐字，p.100 末）："The chiral fields of `N = 1` supergravity with gauge group `g` are the gravitino
  **56**, a neutral fermion **8′**, and an **8** gaugino in the adjoint representation, for total anomaly"

```
Î_I = Î_56(R₂) − Î_8(R₂) + Î_8(F₂,R₂)
    = (1/1440){ −Tr_a(F₂⁶) + (1/48)Tr_a(F₂²)Tr_a(F₂⁴) − [Tr_a(F₂²)]³/14400 }
      + (n − 496){ tr(R₂⁶)/725760 + tr(R₂⁴)tr(R₂²)/552960 + [tr(R₂²)]³/1327104 }
      + Y₄X₈/768 .                                                                (12.2.27)

Y₄ = tr(R₂²) − (1/30)Tr_a(F₂²)                                                    (12.2.28a)

X₈ = tr(R₂⁴) + [tr(R₂²)]²/4 − Tr_a(F₂²)tr(R₂²)/30 + Tr_a(F₂⁴)/3 − [Tr_a(F₂²)]²/900  (12.2.28b)
```

- **因子化条件，原文逐字（p. 101）**：

> "The anomaly has been organized into a sum of three terms. The third is of the **factorized form** that can be
> canceled by the Green–Schwarz mechanism but the first two cannot, and so for the theory to be **anomaly-free**
> the combination of traces on the first line must vanish for the adjoint representation, and the total number
> of gauge generators must be 496. For the groups `SO(32)` and `E₈ × E₈`, **both properties hold**.¹ The net
> anomaly is then `Y₄X₈/768`. (12.2.29)"

- **★ 脚注 1（p. 101 页脚，逐字，这是本书唯一提到另外两个解的地方）**：

> "¹ They also **hold** for `E₈ × U(1)²⁴⁸` and `U(1)⁴⁹⁶`, **but no corresponding string theories are known**."

- **动词裁定（派工单第 (2) 问的直接回答）**：
  - Polchinski **既没用 "cancel" 也没用 "factorize" 描述那两个阿贝尔解**，用的是 **"hold"**，
    指代的是紧邻正文里那**两条 properties**：(i) 伴随表示的迹组合为零；(ii) 规范生成元总数 = 496。
  - **他没有说这四个是全部解**（无 "and for no other group"、无 "the only"、无 "classification"）。
  - 他**没有**把这两个阿贝尔解叫作理论（"no corresponding string theories are known" 只谈弦论实现，
    不评价其作为超引力理论是否一致）。
  - ⇒ **禁止用本条支持「十维 N=1 反常自由规范群恰有四个」。** 本条只支持
    「`SO(32)`、`E₈×E₈`、`E₈×U(1)²⁴⁸`、`U(1)⁴⁹⁶` 这四个满足上述两条 properties」。
- **`[抽取者复算]`（已逐项验完，(12.2.27) 与 (12.2.11)(12.2.12) 完全自洽）**：
  - 纯引力 `tr(R₂⁶)`：`(n−1) + (−495) = n − 496` ✔（无 `Y₄X₈` 贡献）
  - `tr(R₂⁴)tr(R₂²)`：`(n−496)/552960 + 1/768 = (n−496+720)/552960 = (n+224)/552960 = [(n−1)+225]/552960` ✔
  - `[tr(R₂²)]³`：`(n−496)/1327104 + 1/3072 = (n−496+432)/1327104 = (n−64)/1327104 = [(n−1)−63]/1327104` ✔
  - 纯规范 `Tr_a(F₂²)Tr_a(F₂⁴)`：`+(1/1440)(1/48) = +1/69120` 与 `Y₄X₈/768` 的 `−1/(30·3·768) = −1/69120` 相消 ✔
  - `[Tr_a(F₂²)]³`：`−(1/1440)(1/14400) = −1/20736000` 与 `+1/(30·900·768) = +1/20736000` 相消 ✔
  - `[Tr_a(F₂²)]²tr(R₂²)`：`Y₄X₈` 内部两项 `+1/900` 与 `−1/900` 自相消 ✔（故 (12.2.27) 里正确地没有这一项）
  - `Tr_a(F₂²)[tr(R₂²)]²`：`−(1/30 + 1/120)/768 = −1/18432` ✔ 与 (12.2.11) 相符
  ⇒ **(12.2.27)+(12.2.28) ⟺ (12.2.11)+(12.2.12) 是一条纯有理数恒等式，可完全机检。Lean 岛候选，见 §5.4 A9。**
- **`[抽取者复算]`（四个群逐一验证 E14 的两条 properties）**：
  条件 (i) 写成 `Tr_a(t⁶) = (1/48)Tr_a(t²)Tr_a(t⁴) − [Tr_a(t²)]³/14400`：
  - `SO(32)`：由 (12.2.19) 代入，两边同为 `15 Tr_v(t²)Tr_v(t⁴)` ✔；`n = 496` ✔
  - `E₈×E₈`：记 `x = Tr_{a1}(t²)`、`y = Tr_{a2}(t²)`，右端 `= 2(x+y)(x²−xy+y²)/14400 = (x³+y³)/7200` = 左端 ✔；`n = 496` ✔
  - `E₈×U(1)²⁴⁸`：U(1) 生成元在伴随表示里作用为零 ⇒ 所有 `Tr_a` 只剩 `E₈` 部分，同上 ✔；`n = 248+248 = 496` ✔
  - `U(1)⁴⁹⁶`：所有 `Tr_a = 0`，恒等式平凡成立 ✔；`n = 496` ✔
  ⇒ 脚注 1 的断言**被抽取者独立复算证实**。⚠ 「U(1) 在伴随下 `Tr_a = 0`」这一步原书没写，
  ADT p.3 逐字写了（"Tr is the trace in the adjoint, and the adjoint of `U(1)` is the singlet, so traces vanish"），
  **可引 ADT 而不是 Polchinski**。

### E15 ★ ADT 2010 的 (7)(8) = Polchinski (12.2.27)(12.2.28)（**回答派工单第 (2) 问的第二半**）
- 位置：Adams–DeWolfe–Taylor, arXiv:1006.1352**v2**, p. 2, eqs. (7)(8) 与其上方引文句。`[L1 ADT]`
- ADT 原文（逐字）："The contributions to the anomaly polynomial from the fermions for a general non-abelian
  gauge group were computed by Alvarez-Gaumé and Witten [5], and, **following the presentation of Polchinski
  [11]**, can be arranged to the form"

```
Î₁₂ = (1/1440)( −TrF⁶ + (1/48)TrF⁴TrF² − (TrF²)³/14400 )
      + (n − 496)( trR⁶/725760 + trR⁴trR²/552960 + (trR²)³/1327104 ) + Y₄X₈/768 ,          ADT (7)

Y₄ = trR² − (1/30)TrF² ,  X₈ = trR⁴ + (trR²)²/4 − (TrF²)(trR²)/30 + TrF⁴/3 − (TrF²)²/900 . ADT (8)
```

  ADT 紧接着定义："where `Tr` is the trace in the adjoint representation of the gauge group (supersymmetry
  requires that the gauginos running in the loop transform in the adjoint), `tr` is the trace in the fundamental
  of `SO(1,9)`, `n` is the total number of gauge bosons"
- **核实结论（本轮的确定性结果）**：
  **ADT (7) ≡ Polchinski (12.2.27)，ADT (8) ≡ Polchinski (12.2.28a,b)，逐项逐系数完全相同**，
  唯一差别是记号 `Tr_a → Tr`、`F₂,R₂ → F,R`，以及 ADT 把 `Tr_a(F₂²)Tr_a(F₂⁴)` 写成 `TrF⁴TrF²`（乘法可换，同一项）。
  ⇒ **「ADT 说其 (7) following the presentation of Polchinski [11]」对应的确切位置是 (12.2.27)–(12.2.28)，已闭合。**
- ADT 对因子化条件的措辞（逐字）："The Green-Schwarz anomaly cancellation mechanism is possible when the first
  two terms in (7) vanish, so that the anomaly takes the factorized form of the final term. For gauge groups
  `SO(32)` and `E₈ × E₈`, the first term inside large parentheses in (7) vanishes due to particular identities of
  those groups, and `n = 496` for both, killing the middle term."
- 备注：⚠ **编号必须写死 v2**（ADT 致谢自陈 v1 的 (7)(8) 系数有错，由 Tachikawa 指出；见 `gsw-1987-v2.md` E14）。
  ⚠ ADT 引 Polchinski 的书是其 ref **[11]**，与 AGW 的 ref [5] 并列 —— **ADT 把公式的出处归给 AGW，把这个特定排布方式归给 Polchinski。**

### E16 ★ GS 反项的写法与 `H₃` 的 CS 约定（**回答派工单第 (3) 问**）
- 位置：(12.2.15)、(12.2.18)、(12.2.21)–(12.2.26)，pp. 99–100。`[L1 原书]`

```
S'  = ∫ B₂ Tr(F₂⁴)                    (12.2.15)   （原文括注 "(in any representation r, for now)"）
S'' = ∫ B₂ [Tr(F₂²)]²                 (12.2.18)
      ∫ B₂ X₈(F₂,R₂)                  (12.2.21)
H̃₃ = dB₂ − c ω_{3Y} − c′ ω_{3L}       (12.2.22)   （原文："with c and c′ constants"）
ω_{3Y} = A₁dA₁ − (2i/3)A₁³            （(12.2.22) 下方行内，无独立式号）
ω_{3L} = ω₁dω₁ + (2/3)ω₁³             (12.2.23)
δω_{3L} = d tr(Θ dω₁)                 (12.2.24)
δA₁ = dλ ; δω₁ = dΘ ;
δB₂ = c Tr(λ dA₁) + c′ tr(Θ dω₁)      (12.2.25a,b,c)
被抵消的反常形式： [ c Tr(F₂²) + c′ Tr(R₂²) ] X₈(F₂,R₂)      (12.2.26)
```

- **对派工单第 (3) 问的四点裁定：**
  1. **Polchinski 写的是 `∫B₂X₈(F₂,R₂)`（(12.2.21)），不是 `B ∧ X₈`** —— 因为 §12.2 内 `∧` 一律省略（见 §1.1）。
     记号 **`X₈` 本身在本书里是显式给出的**（(12.2.28b)），这一点强于 GS 1984（`green-schwarz-1984.md` E4：
     `X₈` 不出现在 GS 原文）。⇒ **图里若要给 `X₈` 这个记号找一手教科书来源，Polchinski (12.2.28b) 可用。**
  2. **Polchinski 不固定 CS 项的系数与相对符号**：(12.2.22) 里写两个待定常数 `c`、`c′`。
     这比 GS (4) `H = dB + ω⁰_{3Y} − ω⁰_{3L}` 与 Bilal (12.14) `H = dB − Q₃^{YM} + β̃Q₃^{L}` 都更"中立"。
  3. **相对符号是隐式确定的**：由 (12.2.26) 与 (12.2.28a) `Y₄ = tr(R₂²) − (1/30)Tr_a(F₂²)` 比对可知
     `c ∝ −1/30`、`c′ ∝ +1`，即 **`c` 与 `c′` 反号**，两个 CS 项在 `H̃₃ = dB₂ − cω_{3Y} − c′ω_{3L}` 里以相反符号进入
     —— 与 GS (4)、ADT (9) `H₃ ≡ dB₂ − ω₃^Y + ω₃^R` 的相对符号一致。
     ⚠ **这一步比对是 `[抽取者复算]`，原书没有明写 `c`、`c′` 的取值。** 转节点必须标 `inferred`。
  4. ⇒ **`zumino-wu-zee-1984.md` 裁定「GS (4) 与 Bilal (12.14) 都对，物理不变量是相对符号」在 Polchinski 这里得到
     独立佐证**：一本主流教科书干脆拒绝固定整体符号，只留下相对符号有意义。
- **`§12.1` 里的显式版本（不含 Lorentz CS 项）**：
  type I `F̃₃ = dC₂ − (κ₁₀²/g₁₀²)ω₃`（(12.1.35)），`ω₃ = Tr_v(A₁∧dA₁ − (2i/3)A₁∧A₁∧A₁)`（(12.1.36)），
  `δω₃ = dTr_v(λdA₁)`（(12.1.37)），`δC₂ = (κ₁₀²/g₁₀²)Tr_v(λdA₁)`（(12.1.38)）；
  heterotic `H̃₃ = dB₂ − (κ₁₀²/g₁₀²)ω₃`，`δB₂ = (κ₁₀²/g₁₀²)Tr_v(λdA₁)`（(12.1.40)）。
  **原文逐字解释为何 §12.1 没有引力 CS 项（p. 100）**："The gravitational Chern–Simons term was not included in
  the earlier low energy effective action because it is a higher derivative effect. The spin connection `ω₁` is
  proportional to the derivative of the tetrad, so the gravitational term in the field strength (12.2.22)
  contains three derivatives where the other terms contain one. However, its contribution is important in
  discussing the anomaly."
- 自称严格程度：(12.2.25) 下方逐字 **"Again, we only indicate the leading, Abelian, terms."** ⇒ 非阿贝尔的完整变换律本书未写。

### E17 `B₂` 修改规范变换的世界面起源
- 位置：§12.3, (12.3.32)–(12.3.36)，p. 107。`[L1 原书]`
- 原文（逐字）："It is worth noting that the modified gauge transformation of the 2-form potential, which has
  played an important role in the cancellation of spacetime anomalies, **has a simple origin in terms of a
  world-sheet anomaly.** … This acts only on left-moving world-sheet fermions and so has an anomaly in the
  world-sheet path integral. We can use the result (12.2.3) with `k̂_L = 1`, `k̂_R = 0` …"
- 结论：`δZ[A] = (1/8π)∫d²z Tr_v[χ(X)F_{μν}(X)]∂_z X^μ∂_z̄ X^ν`（(12.3.34)），
  由背景移动 `δB_{μν} = (1/2)Tr_v(χF_{μν})`（(12.3.35)）抵消 ⇒ `κ₁₀²/g₁₀² = 1/2 → α'/4`（(12.3.36)）。
- 自称严格程度：直接计算，无保留语。
- 备注：★ **这是本书里把「GS 机制所需的 `δB` 变换」落到世界面的唯一一条推导，且是显式的。**
  图里若要给 `H₃` 的 CS 修正找一条**非唯象**的来源，这条比 (12.2.22) 强。

### E18 弦论侧：六边形圈图与树图的抵消
- 位置：§12.2「Relation to string theory」，Fig. 12.1 与 pp. 102。`[L1 原书]`
- 原文（Fig. 12.1 caption 逐字）："Graphs contributing to the anomalies. One of the six external lines is a
  current and the others are gauge or gravitational fields: (a) hexagon graph; (b) canceling graph from
  exchange of `B_{μν}` field."
- 原文（逐字）："In each string theory, the hexagon loop and the tree graph arise from the same topology but
  different limits of moduli space. In the type I theory, the topology is the cylinder. The loop graph is from
  the short-cylinder limit and the tree graph from the long-cylinder limit. In the heterotic theory, the
  topology is the torus. The hexagon graph is from the limit `τ₂ → ∞`, while the tree graph is from the limit
  where two vertex operators approach one another."
- 备注：与 GSW ch.10 的 planar/nonplanar 分析同一物理，但 Polchinski 用模空间语言。

### E19 规范群在弦论侧由什么决定
- 位置：§12.2, p. 102，无式号。`[L1 原书]`
- 原文（逐字）："In the heterotic string, the gauge group was determined by the requirement of **modular
  invariance**. In the type I string it was determined by cancellation of **tadpole divergences**."
- 依赖：`polchinski-1998-v2.md` E（(10.8.19) `(n ∓ 32)²`）与 §11.6 (11.6.4a,b) 偶自对偶格。
- 备注：⇒ **弦论侧的「唯一性」根本不来自反常，而来自模不变性/tadpole。** 这对图里边的方向很重要。

### E20 ★★ 弦论侧反常消失的**条件式**陈述（**回答派工单第 (5)(6) 问**）
- 位置：§12.2 末，pp. 102–103，无式号。`[L1 原书]`
- 原文（**逐字，两处斜体 "if" 为原文强调**）：

> "The relation with the field theory anomaly is as follows. **One can prove the decoupling of null states
> *formally* in either field theory or string theory; the issue is whether terms from the UV limit invalidate
> the formal argument.** In string theory these are the usual surface terms on moduli space. In the heterotic
> string the effective UV cutoff comes from the restriction of the integration to the fundamental region of
> moduli space. Surface terms from the boundary of the fundamental region cancel *if* the theory is
> modular-invariant. In the type I string the integration is not cut off but the 'UV' limit is reinterpreted as
> the IR limit of a closed string exchange, and the anomaly then vanishes *if* this converges."

- 自称严格程度：**"formally"** + 两个显式条件 **"if the theory is modular-invariant"**、**"if this converges"**。
- 备注：★★ **这是本书对「超弦无反常」给出的最强论证，而它是条件式的、被作者自己标为 "formal"。**
  E2 的 "and in fact they are" 必须被这一段限定。图里 `consistency.superstring-anomaly-free` 类节点
  **status 只能是 `physical-argument`，且 `gaps` 至少要抄这两个 "if"**。
  ⚠ 第二个条件（type I 闭弦交换的 IR 收敛）与 §10.8 的 tadpole 抵消是同一件事，
  而 `gsw-1987-v2.md` E10 记 GSW 自评那个发散抵消论证 **"not entirely rigorous"** —— **两书在同一处都留了口子。**

### E21 低能反常检查在弦论里"原则上不必做"
- 位置：§12.2「Relation to string theory」，p. 101。`[L1 原书]`
- 原文（逐字）："From the low energy point of view, the cancellation of the anomaly involves several numerical
  accidents: the identity for the gauge traces, the correct number of generators, the factorized form (12.2.27).
  Again, these are explained by the existence of consistent string theories. In constructing new string
  theories, **it is in principle not necessary to check the low energy anomaly**, since this is guaranteed to
  vanish if the string consistency requirements have been satisfied. In practice, it is very useful as a check
  on the calculations and as a check that no subtle inconsistency has been overlooked."
- 备注：与 E11 同一立场；注意 "guaranteed … **if** the string consistency requirements have been satisfied"。

### E22 其它十维杂化弦的反常也因子化（无证明）
- 位置：§12.2, p. 101，无式号。`[L1 原书]`
- 原文（逐字）："Of the various additional heterotic string theories constructed in the previous chapter, all but
  the diagonal theory are chiral, and **in all cases the anomalies factorize**."
- 自称严格程度：断言，无证明、无引文。Exercise 12.3 只要求做 `SO(16)×SO(16)` 一例：
  "Show that the anomaly factorizes for the massless spectrum of the `SO(16) × SO(16)` **nonsupersymmetric**
  heterotic string."（p. 134）
- 备注：这里的 "factorize" 与 E14 脚注的 "hold" 是**不同措辞**；Polchinski 在同一页上区分了这两个词。

### E23 ★ 弦论侧单圈显式计算：目标与自称（**回答派工单第 (5) 问**）
- 位置：§12.6 开头，pp. 126–127。`[L1 原书]`
- 原文（逐字）："We will illustrate one-loop superstring calculations with two examples where the low energy
  limit can be obtained in closed form. The first is the heterotic string amplitude with four gauge bosons and
  one antisymmetric tensor. The Green–Schwarz anomaly cancellation requires a one-loop Chern–Simons term
  `∫B₂Tr_v(F₂⁴)` (12.6.1). **We would like to confirm the appearance of this term by an explicit string
  calculation.**"
- 备注：**这是本书唯一一次真的算弦论侧的 GS 项。** 用的是 (P,P) 自旋结构的环面路径积分 (12.6.2)。

### E24 ★ 弦论侧单圈结果与「正确系数」
- 位置：(12.6.18)–(12.6.22)，p. 130。`[L1 原书]`

```
有效作用量  − (1/(2⁹π⁶α')) ∫ B₂ ∫_F (d²τ/τ₂²) f̂(q,F₂)                       (12.6.18)
表面项化简  f̂(q,F₂)/τ₂² = −(32πi/(F₂·F₂)) ∂f̂(q,F₂)/∂τ̄                        (12.6.19)
τ₂→∞       − (1/(2⁴π⁵α')) ∫ (B₂/(F₂·F₂)) f̂(q,F₂)|_{q⁰ term}                  (12.6.20)
有效相互作用 − (1/(2⁴π⁵6!α')) ∫ B₂Tr_a(F₂⁶)/(F₂·F₂)
            = − (1/(2⁴π⁵4!α')) ∫ B₂ Tr_a(F₂⁶)/Tr_a(F₂²)                      (12.6.21)
E₈×E₈ 的形比 (1/7200){ [Tr_{a1}(F₂²)]² + [Tr_{a2}(F₂²)]² − Tr_{a1}(F₂²)Tr_{a2}(F₂²) }  (12.6.22)
                        （SO(32) 的形比是 (1/2)Tr_v(F₂⁴)）
```

- 原文（逐字，(12.6.21) 下方）："Ordinarily dividing by a form would make no sense, but we know from the
  discussion of anomalies that `Tr_a(F₂⁶) ∝ F₂·F₂ X₈(F₂)`, so the effective interaction is proportional to
  `∫B₂X₈` **as required by anomaly cancellation (and with the correct coefficient)**."
- 自称严格程度：**"as required by anomaly cancellation (and with the correct coefficient)"** —— 断言系数对得上，
  **但书里没有把两个系数并排写出来做对比**。⇒ 「弦论侧单圈系数 = 场论侧 GS 项系数」这条**在本书里未被显式验证**。
- **原文自承的缺口（逐字，紧接着）**："**With somewhat more effort one can also find the required curvature
  terms.** That we were able with modest effort to bring this string loop amplitude to a closed form is not too
  surprising, since this is a very special amplitude whose coefficient is determined by symmetry (anomaly
  cancellation). However, many of the physically interesting corrections to the low energy effective action
  cannot be obtained in a closed form."
  ⇒ **`∫B₂X₈` 里的曲率（`tr R²`、`tr R⁴`）部分本书没算。** 只算了纯规范的 `F₂⁴` 部分。
- **`[抽取者复算]`（内部一致性）**：(12.6.21) 两个写法相等 ⟺ `Tr_a(F₂²) = (6!/4!)F₂·F₂ = 30 F₂·F₂`，
  与 §1.2（p.93 的 `(1/30)Tr_a` 归一化）自洽 ✔。
- 备注：只覆盖**杂化弦**；type I 的对应计算是 Exercise 12.10/12.11。

### E25 第二个单圈例子：四规范玻色子
- 位置：(12.6.23)–(12.6.30)，pp. 131–132。`[L1 原书]`
- 结果：`SO(32)` 的有效相互作用 `(1/(2⁸π⁵4!α')) t^{μνσρxβγδ}Tr_v(F_{μν}F_{σρ}F_{αβ}F_{γδ})`（(12.6.30)）；
  `E₈×E₈` 用 (12.6.22) 的群论结构。
- 原文（逐字）："In fact, this is one amplitude that is much more easily obtained in the **light-cone superstring
  formalism**, and so we will effectively convert the calculation to that form."
- 备注：⚠ 这条计算**不是协变的**，中途转到光锥。作者自陈（p.117）："all of these were obtained first in the
  light-cone gauge, before the development of covariant methods."

### E26 ★★ 超弦微扰论一致性的作者自承缺口（**回答派工单第 (6) 问，本章最重要的一条**）
- 位置：§12.5 末，p. 126，无式号。`[L1 原书]`
- 原文（**逐字**）：

> "The parameterization (12.5.27) is always possible locally on supermoduli space. It can also be used globally,
> with careful treatment of the modular identification and the limits of moduli space. There is a literature on
> the 'ambiguity of superstring perturbation theory,' which arose from parameterizations that did not precisely
> cover supermoduli space. **It appears that superstring perturbation theory to arbitrary order is understood in
> principle, and certain special amplitudes have been calculated at higher orders of perturbation theory.
> However, the subject is somewhat unfinished — a fully explicit proof of the perturbative consistency of the
> theory seems to be lacking.** With the immense progress in nonperturbative string theory, filling this
> technical gap does not seem to be a key issue."

- 备注：★★★ **这是全书对「超弦微扰论是否一致」最直白的自评：`a fully explicit proof … seems to be lacking`。**
  对本项目的图，这条应当成为 `consistency` 区一大批节点的**共同瓶颈**（见 §5.3）。
  ⚠ 注意 Polchinski 紧接着**淡化**了它（"does not seem to be a key issue"）—— 转节点时把这句一并抄进 `notes`，
  但**不能因为作者淡化就不记这个缺口**。

### E27 PCO 处方 "ad hoc" 与「形式论证」
- 位置：§12.5, p. 121（(12.5.14) 下方），无式号。`[L1 原书]`
- 原文（逐字）："**The same formal arguments as in the case of the bosonic string show that this defines a
  consistent unitary theory.** In particular, the PCOs are BRST-invariant and do not affect the decoupling of
  null states. This prescription is sufficient for all the calculations we will carry out. However, in the
  remainder of this section we will develop superstring perturbation theory from a more general and geometric
  point of view. One reason for this is that **the picture-changing prescription is rather *ad hoc*** and it
  would be satisfying to see it derived in some way. Another is that this prescription has a **subtle ambiguity
  at higher genus**, which is best resolved from the more geometric point of view."
- 备注：与 `polchinski-1998-v2.md` §10.5 末「超弦无鬼定理只有一句 direct imitation」是同一类缺口的延续：
  **超弦侧的 null-state decoupling 在本书里从头到尾只有 "formal arguments"。**
- 相关式号：(12.5.4) PCO `X(z) ≡ Q_B·ξ(z) = T_F(z)δ(β(z)) − ∂b(z)δ′(β(z))`；
  (12.5.14) `n_X = 2g − 2 + n_B + n_F/2`；(12.5.23) `n_v = 2g − 2 + n_B + n_F/2`（两者相等是 p.126 的"几何推导"结论）。

### E28 非重整化定理：从"所有阶"到"精确"的跳跃
- 位置：§12.6「Nonrenormalization theorems」，pp. 133–134。`[L1 原书]`
- 原文（逐字）："These nonrenormalization theorems **have been argued to extend to all orders of string
  perturbation theory; the details are left to the references.** … This argument applies to all orders of
  perturbation theory and in fact it is a nonperturbative (exact) result. The latter fact is very striking …
  **It should be noted that the leap from 'all orders of perturbation theory' to 'exact' is quite nontrivial**,
  because in theories with less symmetry there are many examples of corrections that arise only from
  nonperturbative effects."
- 备注：作者自己给出了这条推理的强度分级，值得直接抄进节点 `notes`。

### E29 §12.1 的超引力作用量取自文献，不作推导
- 位置：§12.1, p. 85，无式号。`[L1 原书]`
- 原文（逐字）："**We will take such results from the literature without derivation.** Our interest is only in
  certain general features of the various actions, and we will not write out the full fermionic terms or
  supersymmetry transformations. For the supergravities arising from string theories, one can verify the action
  by comparison with the low energy limits of string amplitudes; a few such calculations are given later in the
  chapter and in the exercises."
- 备注：⇒ **(12.1.1)、(12.1.10)、(12.1.26)、(12.1.34)、(12.1.39) 这些十维超引力作用量在本书里没有推导。**
  图里挂它们时 `sources` 只能标"教科书转述"，且需要另找一手来源（IIA 见 ADT ref [9] Bergshoeff 等；
  非阿贝尔推广见 ADT ref [10] Chapline–Manton —— 这两条是 `[L1 ADT]` p.2）。

### E30 IIB 自对偶 5-形的量子化未解决
- 位置：§12.1, p. 91（(12.1.29) 下方），无式号。`[L1 原书]`
- 原文（逐字）："This formulation is satisfactory for a classical treatment but **it is not simple to impose the
  constraint in a quantum theory. This will not be important for our purposes, and we leave further discussion
  to the references.**"
- 备注：这条对 E10（IIB 反常抵消）有潜在影响：`Î_SD` 是自对偶张量的反常多项式，而其量子化本身在本书里是开放的。
  ⚠ **这是抽取者的观察，Polchinski 没有把两者联系起来。**

### E31 十维 N=1 超对称禁止 `F³` 项
- 位置：§12.4, p. 111（(12.4.5) 下方），无式号。`[L1 原书]`
- 原文（逐字）："Unlike the bosonic open string amplitude (6.5.15) there is no `k³` term and so no `F³` term in the
  low energy effective action. Indeed, it is known that such a term is not allowed by the `d = 10`, `N = 1`
  supersymmetry."
- 自称严格程度："it is known that"，无引文。

### E32 GS 机制的推广（六维多张量、其它秩）
- 位置：§12.2, p. 101，无式号。`[L1 原书]`
- 原文（逐字）："In six-dimensional compactifications, some of which will be discussed in chapter 19, there can be
  multiple tensors. The Green–Schwarz mechanism can then cancel a sum of products `Y₄X₄`. Also, the same
  mechanism generalizes to forms of other rank; for example, a scalar in place of `B₂` can cancel an anomaly
  `Y₂X_d`. For `d = 4` this will arise in section 18.7."
- 备注：给 `swampland` / 六维一致性区的后续工作留的钩子（ADT 引言提到六维 `N=1` 的 string universality 研究）。

---

## 3. 未核实项 / 读图不确定处

| 项 | 情况 |
|---|---|
| (12.6.21) 的两个阶乘 `6!` 与 `4!` | 页图小字号，**读作 `2⁴π⁵6!α'` 与 `2⁴π⁵4!α'`**。旁证：两式相等要求比值 `6!/4! = 30`，与 §1.2 的 `(1/30)Tr_a` 归一化自洽 ⇒ **读图正确的可能性很高，但仍标为需二次确认** |
| (12.6.18) 的 `2⁹π⁶`、(12.6.20) 的 `2⁴π⁵`、(12.6.30) 的 `2⁸π⁵4!` | 同上，小字号指数；对本任务不关键 |
| (12.2.10) 的 `(2π)⁵` | 式子写成一般 `d` 维的形式（`Î_d`），但指数写死为 `5`。**原书如此**，不是读图错误；这是 `d = 10` 的特例。转卡时须把 `d = 10` 写进陈述 |
| (12.4.25) 中的 `t^{μνσρxβγδ}` | 页图上第 5 个指标像 `x`（应为 `α`），判为字体渲染问题 |
| 第 12 章的 References 编号 | **本章正文一处引文编号都不给**（Polchinski 的体例是章末不列参考文献，全部集中在书末 pp. 467–487）。**本轮未取 References 章** ⇒ E6/E9 外包给的"the literature"具体是哪几篇，**本项目仍不知道** |
| Notation 页（pp. xviii–xx） | 本轮仍未读（与 ch.10–11 记录相同）。号差、`ε` 张量约定的正式声明可能在那里 |
| Appendix B（pp. 430–466） | 未读。`[5]₊`/`[5]₋`、**56**、**8′** 这些 `SO(9)`/`SO(8)` 记号的定义在 §B.1/B.4/B.5，本记录直接沿用未核 |

---

## 4. 未解决的疑问（留给 curator / auditor / lead）

**Q1（派工单假设错误，同类第二次）** 派工单说「§12.5 一致性/四解分类相关」。**§12.5 是 "General amplitudes"，
与分类无关**；四解只在 §12.2 p.101 的**一条脚注**里。建议在 `polchinski-1998-v2.md` §0.4 的节标题表里补上
第 12 章分节（本记录 §0.3 已给），避免第三次。

**Q2（★ 对图最要紧）** Polchinski 的「四解」脚注**没有唯一性主张**。
`gsw-1987-v2.md` §5.2 建议的卡 (A) 现在多了一条来源，但**性质不同**：
- Antonelli 2015：自称 "We prove" 四个群使十二形式因子化，且说 GSW 那里 "no proof has explicitly been carried out"；
- ADT 2010：说这四个 "satisfy some of the same conditions … and therefore **might appear** to be consistent"；
- **Polchinski (脚注 1)：只说那两条 properties "also hold"，并加 "but no corresponding string theories are known"。**
⇒ 三个来源对**同一事实**的措辞强度递减，且**没有一个声称这是完备分类**。
**问题**：卡 (A) 的 statement 文本要不要改成「以下四个群满足 (i) 伴随迹恒等式 (ii) `n = 496`」而
**不提「因子化」**？—— 因为 Polchinski 的两条 properties 是**比"因子化"更原始**的表述，而且可机检（E14 复算）。
抽取者倾向于改，但这属于陈述规范化，按根 CLAUDE.md 原则 4 应走里程碑流程。

**Q3** (12.2.26) 写作 `[cTr(F₂²) + c′Tr(R₂²)]X₈(F₂,R₂)`，**第二项用了大写 `Tr` 作用在 `R₂` 上**，
与 p.97 的约定（`tr` 才是切空间迹）以及 (12.2.25c) 的 `c′tr(Θdω₁)`、(12.2.28a) 的 `tr(R₂²)` 都不一致。
**判定：极可能是排印错误，应为 `c′tr(R₂²)`。** 但 Core 版已含 2000 年 "with corrections"，说明勘误表没改它。
⇒ 若图里要引 (12.2.26)，`notes` 必须写明这一处。（这是本章找到的**唯一**疑似排印错误。）

**Q4** E8 的 (12.2.10) 给出整体常数 `−i/(2π)⁵`。**这与 GS 1984 那个未闭合的常数 `c` 是什么关系？**
`green-schwarz-1984.md` Q2 记「`c` 在 AGW/ZWZ/Zumino-Les-Houches 三篇里都不以一个数的形式存在」。
Polchinski 给了一个数，但**不说来源**。三种可能：(a) 与 `c` 是同一个常数的不同打包；(b) 是独立的路径积分归一化，
与 `c` 无关；(c) Polchinski 自己按 (12.2.11)–(12.2.13) 的归一化反推。**本轮无法裁决。**
建议：抽 References 章找 §12.2 的引文，或抽 Bilal 0802.0634 §12 做三方对照。

**Q5** ADT (9) 写 `H₃ ≡ dB₂ − ω₃^Y + ω₃^R`，配 (13) `Y₄ = dH₃` 与 (8) `Y₄ = trR² − (1/30)TrF²`，
这要求 `dω₃^Y = (1/30)TrF²`；但 ADT (3) 定义 `ω₃^Y ≡ A^a∧dA^a + (2/3)f^{abc}A^a∧A^b∧A^c`，
**其外微分给不出那个 1/30**（除非 `A` 已按 `(1/30)Tr_a` 归一）。**ADT 内部的归一化没有说清。**
⇒ 这反过来说明 **Polchinski (12.2.22) 用待定常数 `c`、`c′` 是更谨慎的写法**。
⚠ 这是抽取者的观察，**不影响 ADT 的结论**（其论证只用到 `Y₄` 是否为某个东西的全微分），
但如果图里要引 ADT (9)/(13)，须注意其归一化未闭合。

**Q6** E20 的两个 "if"（模不变性、闭弦交换收敛）在本书里**都没有被证明**。
type I 那一支等价于 §10.8 的 tadpole 抵消，而 GSW 自评那个论证 "not entirely rigorous"（`gsw-1987-v2.md` E10）。
**问题：图里"超弦反常自由"这条链的真实瓶颈，是不是应该指到 §10.8 而不是 §12.2？** 需要 auditor 裁定。

**Q7** E26 的 "a fully explicit proof of the perturbative consistency of the theory seems to be lacking" 写于 1998。
**1998 年之后这条缺口是否已被填上？** 已知候选（本轮未查证，仅记方向）：Witten 的 super-Riemann surface 系列
（2012–2013，arXiv:1209.2459、1209.2199、1304.7798）自称给出了超弦微扰论的系统处理。
**若已填上，图里这条 gap 应改指 Witten 而不是保留 Polchinski 的自评。** 建议新增 reading-list 条目。

**Q8** E24：Polchinski 说单圈结果 "with the correct coefficient"，但**没有把两个系数并排比较**。
⇒ 「弦论侧单圈 GS 项系数 = 场论侧所需系数」在本项目里仍是 **L0**。
一手来源应是 **Green–Schwarz, Nucl. Phys. B255 (1985) 93–114**（reading-list 已有 `green-schwarz-1985-hexagon`，P1，待分派）。

**Q9** E30：IIB 自对偶 5-形的量子化本书未解决，而 E10（IIB 反常抵消）用到了它的反常多项式 `Î_SD`。
**这两者之间有没有循环或缺口？** 抽取者不作判断，交 auditor。

---

## 5. 给图的建议

> 以下是**建议**，不是改动。researcher 只写 `literature/`（`literature/CLAUDE.md` 规则 4）。

### 5.1 `consistency` 区可以补 `polchinski-1998-v2` 来源的卡

| 已有/建议 id | 建议动作 | loc | 备注 |
|---|---|---|---|
| `consistency.adjoint-fundamental-trace-identities`（`gsw-1987-v2.md` §5.1 建议过） | **加第二来源** | `§12.2, (12.2.19a-c), p. 99` | Polchinski 只给 `SO(n)` 支；`USp/U(n)` 支仍只有 GSW。**两书系数完全一致**（`l=−1`），可作独立核实 |
| （新）`consistency.e8-trace-reduction` | 新建，`status: rigorous`（纯代数） | `§12.2, (12.2.20), p. 100` | `Tr_a(t⁴)=(1/100)[Tr_a(t²)]²`、`Tr_a(t⁶)=(1/7200)[Tr_a(t²)]³`。与 GS (12b′) 一致。**原书无证明，Exercise 12.2** |
| （新）`consistency.d10-n1-anomaly-polynomial` | 新建，`status: physical-argument` | `§12.2, (12.2.27)+(12.2.28a,b), p. 101` | ★ 十维 N=1 总反常多项式。**gaps 必抄 E6 的 "we will not repeat it here but just quote the result"** |
| （新）`consistency.d10-anomaly-factorization-conditions` | 新建，`status: physical-argument` | `§12.2, p. 101（(12.2.28)–(12.2.29) 之间，无式号）` | 两条条件：伴随迹组合为零 + `n = 496`。**statement 用 Polchinski 的原措辞"properties"，不要写"充要"** |
| （新）`consistency.iib-gravitational-anomaly-cancels` | 新建，`status: physical-argument`（其算术核心可另建 rigorous 卡，见 5.4） | `§12.2, (12.2.14), p. 98` | gaps 抄 E11 的 "miraculous"/"accidental" |
| （新）`consistency.gs-counterterm-B-X8` | 新建，`status: physical-argument` | `§12.2, (12.2.21)–(12.2.26), pp. 99–100` | ★ **本项目里 `X₈` 这个记号的第一条一手教科书来源**（GS 1984 原文没有，见 `green-schwarz-1984.md` E4）。`notes` 抄 Q3 的疑似排印错误 |
| （新）`worldsheet.B-field-gauge-variation-worldsheet-origin` | 新建，`status: physical-argument` | `§12.3, (12.3.32)–(12.3.36), p. 107` | E17。**这是 `δB₂ ∝ Tr(λdA₁)` 唯一的非唯象来源**，比 (12.2.22) 强 |
| `consistency.typeI-hexagon-gauge-anomaly-so32`（GSW 那条） | **加一条 note，不加 source** | — | Polchinski §12.2 走的是低能场论路线，**不是** type I 六边形弦论计算，两者不是同一条推导 |

### 5.2 ★ 「四解」卡怎么改（回答派工单核心问题，接 `gsw-1987-v2.md` §5.2）

`gsw-1987-v2.md` §5.2 建议的卡 (A) 目前只有 `antonelli-2015`（L1）+ `gsw-1987-v2`（L0, inferred）。
**本轮可以做的三件事：**

1. **给 (A) 加 `polchinski-1998-v2` 作为来源，loc `§12.2, p. 101, footnote 1`，且 `inferred: false`。**
   理由：这是**目前唯一一条能在正文里直接读到那四个群名字的 L1 来源**（GSW ch.13 仍取不到）。
   ⚠ 但 statement 文本必须与 Polchinski 的措辞匹配：他说的是**两条 properties "hold"**，不是"因子化"也不是"抵消"。

2. **建议把 (A) 拆成 (A1)/(A2)：**
   ```
   (A1) consistency.d10-four-groups-satisfy-anomaly-conditions
        「SO(32)、E8×E8、E8×U(1)^248、U(1)^496 均满足：(i) Tr_a(t^6) = (1/48)Tr_a(t^2)Tr_a(t^4)
          − [Tr_a(t^2)]^3/14400；(ii) 规范生成元数 n = 496」
        kind: proposition     status: rigorous（纯代数，见 5.4 A10）
        sources:
          - ref: polchinski-1998-v2   loc: "§12.2, p.101 正文 + footnote 1"   （L1，措辞 "both properties hold" / "They also hold"）
          - ref: adams-dewolfe-taylor-2010  loc: "eqs. (7)(8), p.2; 阿贝尔迹为零的说明 p.3"  （L1）
        notes: "Polchinski 脚注原文不含唯一性主张；不得据此写'恰有四个'。"

   (A2) consistency.d10-anomaly-twelve-form-factorization-four-solutions
        「这四个群使反常十二形式因子化为 Y4 X8」
        kind: proposition     status: conjecture（因为"完备性"未证）
        —— 即 gsw-1987-v2.md §5.2 的原卡 (A)，来源保持 antonelli-2015 + gsw-1987-v2(inferred)
   ```
   理由：**(A1) 是可机检的纯代数事实**（抽取者已复算，见 E14），不该被 (A2) 的 `conjecture` 状态拖低。
   **(A2) 的 `conjecture` 来自"是否只有这四个"，不来自"这四个是否因子化"。**

3. **`gsw-1987-v2.md` §5.3 的结论可以再收紧一格**：那里说「`inferred` 不能撤，因为 GSW §13.5.3 正文没读到」。
   现在 **`vafa-2005` E15 那条跨区边可以改挂 `polchinski-1998-v2` §12.2 脚注 1**（L1，能在指定位置读到那两个群名），
   此时该边可以撤 `inferred`。⚠ 但 Vafa 引的是 GS 1984，改挂 Polchinski 仍是**替换来源**而非"证明 Vafa 引对了"——
   `vafa-2005` 的溯源错误结论不变。

### 5.3 ★★ 建议新增一个「全局 gap 节点」

E26 的自评（"a fully explicit proof of the perturbative consistency of the theory seems to be lacking"）
影响的不只是 §12 —— 它是**所有依赖"超弦微扰论一致"的节点的共同瓶颈**。建议：

```
consistency.superstring-perturbative-consistency-unproven
  kind: proposition （或项目里表示"缺口/开放问题"的 kind）
  status: open / conjecture
  statement: 「截至 1998，超弦微扰论到任意阶的完整一致性没有显式证明」
  sources: polchinski-1998-v2, loc "§12.5, p.126, 无式号"   （L1，逐字见 E26）
  notes: "作者同时写了 'filling this technical gap does not seem to be a key issue'，
          但那是价值判断不是证明。Q7：需核实 Witten 2012–2013 的 super-Riemann surface 系列是否已填上。"
```

同时把 **E20 的两个条件式 "if"** 与 **E27 的 "formal arguments" / "ad hoc" / "subtle ambiguity at higher genus"**
写进相关节点的 `gaps`。这三条合起来，是本章对图的**最大贡献**——
它们把「超弦无反常/一致」从看似 `rigorous` 拉回 `physical-argument`，且每一条都有作者本人的逐字自评作背书。

### 5.4 Lean 岛候选：本轮新增三条（接 `gsw-1987-v2.md` §5.4 的 A6/A7）

**A8 —— IIB 引力反常抵消 (12.2.14)**
> 三条整数恒等式：`−2·1 + 2·(−495) + 992 = 0`；`−2·1 + 2·225 − 448 = 0`；`−2·1 + 2·(−63) + 128 = 0`。
- 来源：`polchinski-1998-v2` (12.2.11)(12.2.12)(12.2.13)(12.2.14)（全 L1）
- 严格性：原书只说 "the coefficients … conspire to produce zero total anomaly"，不展示算术
- Lean 化：`decide` / `norm_num` 一行。**价值：把 Polchinski 亲口说的 "miraculous"/"accidental" 变成三条可判定的整数等式。**
- ⚠ `n = 1`（中性场）这一步须标 `inferred`（见 E10）

**A9 —— (12.2.27) 是 (12.2.11)+(12.2.12) 的恒等重排**
> 在有理系数的自由交换代数 `ℚ[a,b,c,d,e,f]`（`a=Tr_aF₂², b=Tr_aF₂⁴, c=Tr_aF₂⁶, d=trR₂², e=trR₂⁴, f=trR₂⁶`）上：
> `Î_56 − Î_8|_{n=1,F=0} + Î_8|_{n} = (1/1440)(−c + ab/48 − a³/14400) + (n−496)(f/725760 + ed/552960 + d³/1327104) + Y₄X₈/768`
> 其中 `Y₄ = d − a/30`，`X₈ = e + d²/4 − ad/30 + b/3 − a²/900`。
- 来源：`polchinski-1998-v2` (12.2.11)(12.2.12)(12.2.27)(12.2.28)（全 L1）；独立第二源 ADT (7)(8)（L1）
- 严格性：原书**一个字都没说这是恒等式**，直接给出重排后的形式
- Lean 化：`MvPolynomial ℚ (Fin 6)` 上的 `ring`（或 `Polynomial.funext` + `norm_num`）。抽取者已手工逐项验过（见 E14）
- **价值高**：这是 GS 反常链上**第二条**可完全机检的核心代数事实（第一条是 `green-schwarz-1984.md` 的 (19)）。
  而且它把 Polchinski 与 ADT 两个独立文本的公式**同时**验证了

**A10 —— 四个群满足因子化条件（`gsw-1987-v2.md` A6 的推广）**
> 在 `ℚ` 系数下验证 `Tr_a(t⁶) = (1/48)Tr_a(t²)Tr_a(t⁴) − [Tr_a(t²)]³/14400`：
> - `SO(n)` 支：代入 (12.2.19)，成立 ⟺ `n = 32`
> - `E₈^k` 支：代入 (12.2.20)，`k = 1` 成立但 `n = 248`；`k = 2` 成立且 `n = 496`
> - `U(1)^m` 支：`Tr_a ≡ 0`，恒成立；`n = m`
> ⇒ 配合 `n = 496`，在这三族及其乘积中的解恰是 `SO(32)`、`E₈×E₈`、`E₈×U(1)²⁴⁸`、`U(1)⁴⁹⁶`
- 来源：`polchinski-1998-v2` (12.2.19)(12.2.20) + p.101 正文与脚注 1（全 L1）；`adams-dewolfe-taylor-2010` p.3（L1，U(1) 部分）
- 严格性：Polchinski 只对 `SO(32)`/`E₈×E₈` 说 "both properties hold"，脚注对另两个说 "They also hold"，**都不给验算**
- Lean 化：三族分别是 `ring` + `omega`；**⚠ 「恰是这四个」需要"候选集限定在这三族及其乘积"这条额外假设，
  必须写进定理陈述，否则就变成了本项目明令禁止的完备分类主张。**

### 5.5 **不得**挂到 `polchinski-1998-v2` 第 12 章的东西（红线）

| 内容 | 为什么不行 |
|---|---|
| 「十维 N=1 反常自由规范群恰有四个」 | E14：脚注只说两条 properties "hold"，**无唯一性主张、无 "the only"** |
| 「`E₈×U(1)²⁴⁸` / `U(1)⁴⁹⁶` 反常抵消」 | 同上，且与 `adams-dewolfe-taylor-2010`（阿贝尔解 `Y₄ ≠ dH₃`，不是一致量子理论）冲突。Polchinski 的措辞恰好避开了这个坑 |
| (12.2.11)–(12.2.13) 标 `rigorous` | E6：**本书明说不做这个计算，只 quote the result**，且正文不给引文 |
| 「弦论侧单圈 GS 项系数已被验证」 | E24：书里只断言 "with the correct coefficient"，**没有并排比较**；且**曲率项根本没算** |
| 「超弦微扰论一致」标 `rigorous` 或 `physical-argument` 不带 gap | E26：作者自陈 "a fully explicit proof … seems to be lacking" |
| 「超弦 null-state decoupling 已证」 | E20/E27：全书只有 "formal arguments" + 两个未证的 "if" |
| 第 13 章及以后的任何式号 | 本轮只取了第 12 章 |
| `B ∧ X₈` 这个**带楔号**的写法归给 Polchinski | §1.1：§12.2 内 `∧` 一律省略，原文是 `∫B₂X₈(F₂,R₂)`。**`X₈` 这个记号本身可以归给 (12.2.28b)** |
| 十维超引力作用量 (12.1.1)/(12.1.10)/(12.1.26)/(12.1.34)/(12.1.39) 标 `rigorous` | E29：**"We will take such results from the literature without derivation"** |
| GS 的常数 `c` 已由 (12.2.10) 闭合 | Q4：`−i/(2π)⁵` 与 GS 的 `c` 是否同一个量**未裁决** |

---

## 6. `sources.bib` 与 `reading-list.md` 的改动（本轮已做）

| 文件 | 改动 |
|---|---|
| `literature/sources.bib` | `polchinski-1998-v2` 补 `note`：版本锚定（CBO 2001/2005，含 2000 年勘误）+ 已抽范围（ch.10–12）+ 两条使用限制（第 12 章脚注不含唯一性主张；(12.2.26) 疑似排印错误） |
| `literature/reading-list.md` | `polchinski-1998-v2` 两行合并更新为「ch.10–12 已 L1 全文」，注明 §12.5 不是分类内容、四解只在 p.101 脚注、ch.13+ 未抽；「已知获取路线备忘」的 Cambridge Core 条目补上 Vol.2 全部 item hash 与「文件名可直接推出」 |
