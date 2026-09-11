# 抽取记录：polchinski-1998-v2 — 第 13 章「D-branes」（pp. 136–177）

- 文献：J. Polchinski, *String Theory, Volume II: Superstring Theory and Beyond*, Cambridge University Press.
  本轮读的是 **Cambridge Books Online 数字化本（© 1998/2001, 2005，已含 2000 年 "with corrections"）**。
- 抽取者：researcher agent
- 日期：2026-09-11
- 覆盖范围：**第 13 章 D-branes，pp. 136–177（42 印刷页）全章逐页读图**
- 编号：**E 编号本文件独立重起，从 E1 开始**（与 `polchinski-1998-v2.md` 的 E1–E75、`polchinski-1998-v2-sec10-8.md` 的 E64–E75、`polchinski-1998-v2-ch12.md` 的 E1–E32 各自独立；引用时必须写全文件名，例 `polchinski-1998-v2-ch13.md#E13`）

> 状态：**全章 L1 抽取完成（E1–E32 + Q1–Q8 + §5 图建议）。**
> ★ 本轮最重要的是一条**否定结论**：**本章从不写「32 张 D9 膜」；全章唯一给出 D9 数目的句子写的是 16**（E13 / Q1）。

---

## 0. 获取路线与证据等级

### 0.1 取件

- URL（直接推出，未先 fetch abs 页，一次命中）：
  `https://www.cambridge.org/core/services/aop-cambridge-core/content/view/67EE13E32046F0D121B589DC02989698/9780511618123c4_p136-177_CBO.pdf/dbranes.pdf`
- item hash `67EE13E32046F0D121B589DC02989698`，文件名 `9780511618123c4_p136-177_CBO.pdf`，**587.8 KB / 42 页（≈14 KB/页，符合 Polchinski 的体积基准）**。
- **PDF 页号 = 印刷页号 − 135**（PDF p.1 = 印刷 p.136，已用页眉逐页核对）。
- 页脚版本锚定（逐字抄一行）：
  `Downloaded from https://www.cambridge.org/core. Zhejiang University, on 11 Sep 2026 … Cambridge Books Online © Cambridge University Press, 2010 … https://doi.org/10.1017/CBO9780511618123.007`
  ⇒ **本章的 DOI 后缀是 `.007`；章号 13 ↔ `.007`，再次确认「别用 DOI 后缀推章号」。**
- 读法：42 页分 4 批（1–10 / 11–20 / 21–30 / 31–42）通读，再对 8 页做**单页重渲染**核对
  （PDF p.3 / 6 / 7 / 8 / 9 / 11 / 12 / 15 = 印刷 p.138 / 141 / 142 / 143 / 144 / 146 / 147 / 150）。

### 0.2 证据等级

本文件除另有标注外，**全部为 L1（一手原书页图）**。凡是「抽取者补的」「原书没写」的推断，一律在条目里显式标出。

### 0.3 本轮做过的独立复算（三条，全部通过或给出确切偏差）

**(a) (13.3.4) ↔ (13.3.22)+(13.3.23) 自洽 ✅**
由 (13.3.23) `τ_p = 1/(g(2π)^p α'^{(p+1)/2})` 得 `τ_p² = 1/(g²(2π)^{2p}α'^{p+1})`；
由 (13.3.4) `τ_p² = (π/κ²)(4π²α')^{3−p}` 代入 (13.3.22) `κ² = ½(2π)^7g²α'^4`：
`π/κ² = 2π/((2π)^7g²α'^4)`，`(4π²α')^{3−p} = (2π)^{6−2p}α'^{3−p}`，乘积 `= (2π)^{−2p}/(g²α'^{p+1})` ✅ 逐位相同。
同时 (13.3.23) 的两种写法互验通过：`(2κ²)^{−1/2}(2π)^{(7−2p)/2}α'^{(3−p)/2} = g^{−1}(2π)^{−p}α'^{−(p+1)/2}` ✅；
(13.3.25) `1/((2πα')²τ_p) = (2π)^{p−2}gα'^{(p−3)/2}` ✅。

**(b) Dirac 量子化 (13.3.13) 的 `n = 1` ✅（原书用了 "Remarkably" 一词，本轮验证它确实是精确的）**
由 (13.3.7) `μ_p = √π/κ₁₀ · (4π²α')^{(3−p)/2}`，故
`μ_p μ_{6−p} = (π/κ₁₀²)(4π²α')^{(3−p)/2}(4π²α')^{(p−3)/2} = π/κ₁₀²` ⇒ 与 (13.3.13) 的 `πn/κ₁₀²` 比较得 **`n = 1` 精确**，
且 `(4π²α')` 的幂次**恰好互相抵消**——这正是 "arrived at in an entirely different way" 的那个巧合的来源。

**(c) ★★ (13.3.1) 的前缀：`α'` 的幂次被独立地重新定成 1 次方，跨章佐证了 `-sec10-8.md#Q1` 的裁定**
(13.3.1) 第一行在页图上（单页重渲染后仍然）看起来是
`iV_{p+1}·4×16 / [8π(8π²α'²)⁵]`，与 §10.8 的 (10.8.4)/(10.8.11)/(10.8.18)/(10.8.19) 七处页图读数**同型**。
**纯 `α'` 幂次记账**（不依赖数值系数、不依赖 `G_d` 的约定，只用 `y` 与 `α'` 独立这一点）：
- 左端 `α'` 幂 = `−5x + (9−p)/2 + (7−p)/2 = −5x + 8 − p`（第二项来自 `(8π²α't)^{(9−p)/2}`，第三项来自 `t` 积分给出的 `(y²/2πα')^{(p−7)/2}`）；
- 右端 `iV_{p+1}2π(4π²α')^{3−p}G_{9−p}(y)` 的 `α'` 幂 = `3 − p`（`G_d` 不含 `α'`）；
- ⇒ `−5x + 8 − p = 3 − p` ⇒ **`x = 1`**。
⇒ **本章给出了第二个、独立于第 10 章的证据：那个前缀应为 `8π(8π²α')⁵`，页图上的 `α'²` 是系统性假象或系统性排印错误。**
（`-sec10-8.md#Q1` 原判「两读数都留档、由复算裁定、须人复核」**维持**，但现在**证据强度显著提高**：两章、两条不同推导路线、同一结论。）
⚠ 同一复算里 **`π` 的幂次差一次**（算得 `π^{4n−12}`，右端要求 `π^{4n−11}`，`n ≡ (9−p)/2`），
`2` 的幂次与 `α'` 的幂次**都逐位吻合**。见 **Q3**。

---

## 1. 约定（§13 内实际用到的）

1. **号差与 `α'`**：沿用全书（`(−,+,…,+)`；`α'` 与 Vol.1 相同）。本章不重述。
2. **★ 闭弦耦合 `g` 的定义在本章才被定死**：(13.3.21) `g ≡ τ_F1/τ_D1`。
   原文逐字：「Up to now there has been **no natural convention** for defining the additive normalization of the dilaton field
   or the multiplicative normalization of the closed string coupling `g = e^Φ`. The dimensionless ratio (13.3.20) is
   proportional to the closed string coupling, and it turns out to be **very convenient to take it as the definition of the coupling**.」
   ⇒ **凡引用本书 `g`、`κ`、`τ_p`、`μ_p` 的数值系数，必须声明用的是 (13.3.21) 这一约定。**
3. **两个引力耦合常数不是一回事**：(13.3.22) `κ² = ½(2π)^7 g²α'^4`（物理测得的，依赖 dilaton 背景）
   vs (13.3.24) `κ₁₀² = ½(2π)^7 α'^4`（§12.1 低能作用量里的那个常数）。
   原文逐字：「this differs from the physically measured `κ` because the latter depends on the dilaton background.」
4. **张力 `τ_p` 与荷 `μ_p` 的关系**：(13.3.7) `μ_p² = e^{2Φ₀}τ_p² = T_p²`（`T_p` 是 `Φ₀` 无关的量）。
5. **`#ND`**：两张 D 膜之间，边界条件为 (Neumann, Dirichlet) 或 (Dirichlet, Neumann) 的坐标数目（p.153 定义）。
6. **`β^m ≡ ΓΓ^m`**（(13.1.6) 上下文），`β^⊥ ≡ ∏_{m⊥} β^m`（13.2.6），`β^mβ^m = −1`（p.138 逐字）。
7. **标量 Green 函数**：`G_d(y) = 2^{−2}π^{−d/2}Γ(½d − 1)y^{2−d}`（p.146，(13.3.1) 之后一行）。
   ⚠ **与本项目 `polchinski-1998-v1.md` E156 记的 Vol.1 (8.7.18) 形式 `(π^{(2−d)/2}/4)Γ((d−2)/2)|y|^{2−d}` 差一个 `π` 的幂**。
   本章这个形式**与标准结果 `Γ(d/2−1)/(4π^{d/2})|y|^{2−d}` 一致**；Vol.1 那条是经 [S] 二手记录的，**建议以本章为准**。见 **Q3**。

---

## 2. 陈述（E1 起）

### E1 章结构与页码表（本章的"目录"，供后人定位）
- 位置：pp. 136–177 通读所得（节标题与起始印刷页均逐页核对）
- 类型：元数据

| 节 / 小节 | 起始印刷页 | 备注 |
|---|---|---|
| 章首无编号导言 | 136 | 「In chapter 8 we found that …」 |
| **13.1 `T`-duality of type II strings** | 136 | |
| **13.2 `T`-duality of type I strings** | 138 | ★ SO(32)/D9/O9 的全部内容在此 |
|  └ *New connections between string theories* | 143 | |
| **13.3 The D-brane charge and action** | 146 | ★ τ_p、μ_p、DBI、CS |
|  └ *Dirac quantization condition* | 147 | |
|  └ *D-brane actions* | 149 | |
|  └ *Coupling constants* | 150 | |
| **13.4 D-brane interactions: statics** | 152 | |
|  └ *Branes at general angles* | 154 | |
| **13.5 D-brane interactions: dynamics** | 158 | |
|  └ *D-brane scattering* | 158 | |
|  └ *D0-brane quantum mechanics* | 161 | |
|  └ *The `#ND = 4` system* | 162 | |
| **13.6 D-brane interactions: bound states** | 164 | |
|  └ *FD bound states* | 164 | |
|  └ *D0–D`p` BPS bound* | 168 | |
|  └ *D0–D0 bound states* | 168 | |
|  └ *D0–D2 bound states* | 169 | |
|  └ *D0–D4 bound states* | 170 | |
|  └ *D-branes as instantons* | 172 | |
|  └ *D0–D6 bound states* | 175 | |
|  └ *D0–D8 bound states* | 175 | |
| **Exercises 13.1–13.12** | 175–177 | ⚠ **本章有 12 道习题**（与 §10.8「一道都没有」形成对比） |
| 图 | fig. 13.1 p.139 / 13.2 p.143 / 13.3 p.148 / 13.4 p.158 / 13.5 p.165 | |
| 脚注 | 1 (p.140) / 2 (p.141) / 3 (p.142) / 4 (p.156) / 5 (p.159) / 6 (p.173) | 共 6 条，逐条见下 |

- 备注：**本章零文献引用**（无 "(Author, year)"、无编号引文），与全书体例一致；但**多次说 "left to the references"**（见 §3.1）。

---

### E2 §13.1 type II 的 `T` 对偶交换 IIA ↔ IIB
- 位置：§13.1，eqs. **(13.1.1)–(13.1.7)**，pp. 136–138
- 类型：proposition
- 原文陈述：紧化 `X^9`、取 `R → 0`，右动部分被反射
  **(13.1.1)** `X'^9_R(z̄) = −X^9_R(z̄)`；由超共形不变性必须同时反射 **(13.1.2)** `ψ̃'^9(z̄) = −ψ̃^9(z̄)`。
  逐字：「However, this implies that the chirality of the right-moving R sector ground state is reversed …
  **Simply put, `T`-duality is a spacetime parity operation on just one side of the world-sheet**, and so reverses the
  relative chiralities of the right- and left-moving ground states. If we begin with the IIA theory and take the
  compactification radius to be small, we obtain the IIB theory at large radius, and vice versa.」
  在**奇数**个维度上作 `T` 对偶效果相同；**偶数**个维度则回到原来的 type II 理论。
  自旋场上的作用 **(13.1.3)** `𝒱'_α(z) = 𝒱_α(z)`，`𝒱̃'_α(z̄) = β^9_{αβ}𝒱̃_β(z̄)`，其中 `β^9 = ΓΓ^9`；
  R–R 顶点算子 **(13.1.4)** `𝒱̄Γ^{μ1…μp}𝒱̃` 右乘 `Γ^9Γ` ⇒ 加/减一个 `9` 指标，即
  **(13.1.5a)** `C_9 → C`，**(13.1.5b)** `C_μ, C_{μν9} → C_{μ9}, C_{μν}`，**(13.1.5c)** `C_{μνλ} → C_{μνλ9}`。
  多维时把 `β^9` 换成 **(13.1.6)** `∏_m β^m`；不同方向的 `T` 对偶**不对易**，差一个符号：
  **(13.1.7)** `β^mβ^n = exp(πiF̃)β^nβ^m`，`F̃` 是右动态的时空费米数。且 `β^mβ^m = −1`，故作用两次给 `exp(πiF̃)`。
- 文献自称的严格程度：「**By superconformal invariance we must also reflect** …」「Simply put …」——**属于物理论证**；
  原文明说 (13.1.5) 只到 "**up to signs**"，且 (13.1.6) 之后逐字：「**There are some signs that should be noted but should not distract attention from the main physical point.**」
- 备注：`worldsheet`/`duality` 区若要建「T 对偶交换 IIA/IIB」的卡，这里是本书的一手落点。

---

### E3 ★ type I 的 `T` 对偶给出 D 膜与 orientifold 面：**16 个 D8 膜夹在两张 orientifold 超平面之间**
- 位置：§13.2 开篇，**p. 138**（无式号）
- 类型：proposition
- 原文**逐字**：
  > 「Taking the `R → 0` limit of the open and unoriented type I `SO(32)` theory leads to D-branes and orientifold
  > planes **by the same arguments as for the bosonic string in chapter 8, which the reader should review**.
  > In particular, taking the `T`-dual on a single dimension leads to a space with **16 D8-branes between two
  > orientifold hyperplanes**.」
- 文献自称的严格程度：**整条推导被外包给第 8 章**（"by the same arguments … which the reader should review"），本章不重做。
- 备注：**★ 数字是 16，不是 32。** 见 **E12/E13 与 Q1**——这是本轮最重要的发现。

---

### E4 `T` 对偶后的体（bulk）物理是 type II
- 位置：§13.2，p. 138（无式号）
- 类型：proposition
- 原文陈述（逐字要点）：远离固定平面与 D 膜的区域，局域物理是**闭的、有取向的**超弦
  （闭：开弦住在远处的 D 膜上；有取向：取向投影把一个态与它在固定平面背后的镜像相联系，
  「but does **not locally constrain** the space of states」）。
  ⇒「Thus the local physics must be that of a type II theory. In particular there are two gravitinos, and any closed
  string scattering process will be invariant under the **32 supersymmetries** of the type II theory.」
  由于 type I 的左右手征相同，一维对偶后变成相反 ⇒ **体内是 IIA**；奇数维同效，偶数维给 IIB。
- 备注：**注意这里的 "32" 是超对称荷的个数，不是 D 膜个数。** 本章多处出现 `32`，含义各不相同，见 §3.2。

---

### E5 D 膜上的无质量开弦谱
- 位置：§13.2，eq. **(13.2.1)**，p. 139
- 类型：proposition
- 原文陈述：**(13.2.1)** `ψ^μ_{−1/2}|k⟩_NS`，`ψ^9_{−1/2}|k⟩_NS`，`|α;k⟩_R`。
  逐字：「As in the bosonic theory, the bosonic states are **a gauge field living on the D-brane** and
  **the collective coordinates for the D-brane**. The fermionic states are the superpartners of these.」
- 备注：这是「D 膜是动力学对象」的谱层依据；玻色部分与 Vol.1 §8.7（本项目 `polchinski-1998-v1.md` E153）相同。

---

### E6 ★★ D 膜是 BPS 态：保留 32 个超对称中的 16 个
- 位置：§13.2，eqs. **(13.2.2)**、**(13.2.4)**、**(13.2.5)**、**(13.2.6)**，pp. 139–140
- 类型：proposition
- 原文陈述：type I 中只有总荷 `Q_α + Q̃_α` 守恒；`T` 对偶后变成
  **(13.2.2)** `Q'_α + (β^9Q̃')_α`——「The scattering amplitudes of closed strings from the D-brane are invariant only under **these 16 supersymmetries**.」
  破缺的 16 个由 **(13.2.4)** `∫_{∂M}ds𝒱'_α = −∫_{∂M}ds(β^9𝒱̃')_α` 度量，而这正是费米型开弦态 (13.2.1) 的顶点算子
  ⇒「**Thus this state is a `goldstino`**, the Goldstone state associated with spontaneously broken supersymmetry.」
  逐字（斜体是原书的）：
  > 「It is not surprising that the D-brane breaks some supersymmetry. The only state invariant under all supersymmetries
  > is the vacuum. Rather, **what is striking is that it leaves half the supersymmetries unbroken: *it is a BPS state*.**
  > **This same argument holds for any number of dualized dimensions, and so for D`p`-branes for all `p`.**」
  未破缺的超对称是 **(13.2.5)** `Q'_α + (β^⊥Q̃')_α`，**(13.2.6)** `β^⊥ = ∏_{m} β^m`（乘积跑遍垂直于 D 膜的方向）。
- 文献自称的严格程度：**"We conclude by analogy that …"**（p.140 逐字，指 16 个超对称的破缺）；
  论证链是「动量不守恒 ↔ Goldstone 玻色子（集体坐标）」的类比推广，**不是独立计算**。
- 备注：★ 这是 `branes.bps-no-force` 的**上游**：BPS 性在这里定，无力性在 §13.3（E17）由振幅验证。

---

### E7 D 膜自发破缺平移不变性；动量不守恒 = 集体坐标顶点算子
- 位置：§13.2，eq. **(13.2.3)**，p. 140；**脚注 1**（同页）
- 类型：proposition
- 原文陈述：**(13.2.3)** `(1/2πα')∫_{∂M}ds ∂_nX'^9`「which up to normalization is just the (0 picture) vertex operator
  for the collective coordinate, with zero momentum in the Neumann directions.」
- **脚注 1 逐字（重要的限定）**：
  > 「The Mermin–Wagner–Coleman theorem from quantum field theory implies that if the D-brane has **two or more
  > noncompact directions** there will indeed be an infinite number of degenerate states. **If it has one or zero
  > noncompact directions, quantum fluctuations force it into a unique translationally invariant state.** The latter
  > effect shows up in perturbation theory through IR divergences. For a spontaneously broken *supersymmetry* the
  > fluctuations are less effective: supersymmetry can be broken even by a zero-dimensional object.」
- 备注：**转卡时这条脚注必须带上**——「D 膜自发破缺平移不变性」对 `p ≤ 1` 不成立。

---

### E8 ★★ D`p` 膜带 R–R 荷：与 `(p+1)`-形式势的耦合，10-form 的存在由 §10.8 推出
- 位置：§13.2，eq. **(13.2.7)**，**p. 141**
- 类型：proposition
- 原文陈述：**(13.2.7)** `∫C_{p+1}`（积分跑遍 D 膜世界体）。
  逐字：「BPS states, which are discussed in section B.2, **must carry conserved charges**. In the present case there is
  a natural set of charges with the correct Lorentz properties, namely the antisymmetric R–R charges.」
  由 `T` 对偶可到任意 `p` 的 D`p` 膜 ⇒ IIA 需要 1-, 3-, 5-, 7-, 9-form 势；IIB 需要 2-, 4-, 6-, 8-, 10-form 势。
  **★ 与 §10.8 的对接就在这一段，逐字：**
  > 「The first four arise in either the electric or magnetic description of the propagating R–R states.
  > **The existence of the 10-form was deduced in section 10.8, from the study of type I divergences. Indeed, we argued
  > there for the coupling (13.2.7) for the 10-form, where the integral runs over all spacetime. This fits with a point
  > made in chapter 8, that it is natural to interpret each Chan–Paton degree of freedom in the fully Neumann theory as
  > a 9-brane filling spacetime.** All the other R–R couplings follow from this one by `T`-duality, since each time we
  > `T`-dualize in an additional direction the dimension of the `p`-branes goes down by one and the R–R form loses an index.」
  同样地，9-form 势「we have discussed in section 12.1 in the context of massive IIA supergravity. Although it is not
  associated with propagating states, and so was not detected in the quantization of the IIA string, **the existence of
  D8-branes shows that it must be included**.」
- 备注：**★★ 这是本章对 §10.8 的第一处、也是最明确的一处显式引用（带式号 (13.2.7) + 节号 "section 10.8"）。**
  注意它的方向：**§10.8 → 本章**（§10.8 论证了 10-form 耦合的存在，本章把它解释成 D9 膜），
  **不是**「本章重新推出了 §10.8 的结论」。见 **§5** 的建边说明。
  ⚠ 「each Chan–Paton degree of freedom … as a 9-brane」**蕴含 32 张 D9 膜**（type I 的 CP 指标是 32 个），
  与 E12/E13 的「16 个 D 膜」在同一节内并存且**原书从不调和**——见 **Q1**。

---

### E9 D`p` 与 D`(6−p)` 是电–磁对偶的一对；无局域协变作用量
- 位置：§13.2，eqs. **(13.2.8a)(13.2.8b)**，p. 141；**脚注 2**（同页）
- 类型：proposition
- 原文陈述：**(13.2.8a)** `F_2 = dC_1`，`d∗dC_1 = 0`；**(13.2.8b)** `∗F_2 = (∗F)_8 = dC_7`，`d∧∗dC_7 = 0`。
  「At an electric source, which would be a D0-brane for `C_1` or a D6-brane for `C_7`, the field equation has a source term.
  At a magnetic source, a D6-brane for `C_1` or a D0-brane for `C_7`, **the Bianchi identity breaks down**, and the
  potential cannot be globally defined: one must introduce a Dirac string, or use different potentials in different patches.」
- **脚注 2 逐字（作者自承的缺口）**：
  > 「It should be mentioned that **there is no local covariant action for a system with both electric and magnetic charges**,
  > even though the physics is covariant and **presumably** satisfies the axioms of local quantum field theory.」
- 备注：这条脚注是本章少数几个「作者自己标出的未解决点」之一。

---

### E10 D(−1) 膜 = D-instanton
- 位置：§13.2，p. 142（无式号，接 (13.2.7)）；另 p. 145（无式号）
- 类型：proposition
- 原文陈述：IIB 还有 0-form 势 `C_0`，「This should couple to a '`(−1)`-brane.' Indeed, there is a natural interpretation
  to this: it is defined by Dirichlet boundary conditions in all directions, **time as well as space**, so its world-sheet
  is zero-dimensional and the integral (13.2.7) reduces to the value of `C_0` at that point. An object that is localized
  in time as well as space is an **instanton**.」
  p.145 给出必要性论证：D0 膜在紧空间里的路径和必须包含缠绕路径；最短的缠绕路径在时间上局域化，本质上是 instanton；
  再对紧方向作 `T` 对偶得到全方向局域的 D-instanton。**由于 D 膜作用量 ~ `O(1/g)`，D-instanton 振幅是 `e^{−O(1/g)}` 阶**
  ⇒「Thus we have found an example of the enhanced nonperturbative effects that were inferred **in section 9.7** from the
  high order behavior of string perturbation theory.」
- 文献自称的严格程度：p.145 逐字「**Presumably** we must do the same for the D0-branes as well.」

---

### E11 ★★ type I 对非 `SO(32)` 群的发散：来源是 R–R 10-form 场方程，且不受环面紧化影响
- 位置：§13.2，**p. 142**（无式号）
- 类型：proposition
- 原文**逐字**：
  > 「The divergence of the type I theory for groups other than `SO(32)` arose from the R–R 10-form field equation.
  > This divergence is unaffected by toroidal compactification and **again cancels only for `SO(32)`**. It would have
  > been surprising if toroidal compactification made a consistent theory inconsistent, or the reverse, and
  > **it is not hard to verify explicitly that this does not happen**. The effect of toroidal compactification is to add
  > world-sheets that wrap around the periodic directions of spacetime. These correspond to exchange of closed strings
  > with winding number, which are massive and so **do not have dangerous tadpoles**.」
- 文献自称的严格程度：**"it is not hard to verify explicitly that this does not happen" —— 该验证在本章不做**。
- 备注：这是本章第二处引用 §10.8 的结论（这次不带节号，只说 "arose from"）。
  ⚠ **本句是把 §10.8 的结论当已知输入使用**，不是重新证明。

---

### E12 ★★★ 空间时间图像：orientifold 面是 R–R 荷的"汇"，其荷 = `−2^{4−k}` × 一张 D 膜
- 位置：§13.2，**pp. 142–143**（无式号）
- 类型：proposition
- 原文**逐字**（跨页，连续一段）：
  > 「The spacetime interpretation of the divergence in the `T`-dual picture with D-branes is again **an inconsistency in
  > the R–R field equations**. One can picture field lines emerging from each D-brane, orthogonal to the noncompact
  > dimensions, and **these field lines must end somewhere**. Further, all D-branes must have the same sign of the charge:
  > the full set of D-branes is still a BPS state, being `T`-dual to the type I theory, and the total mass is linear in
  > the total charge for a BPS state. **We know that the disk tadpole is canceled by the unoriented cross-cap.**
  > In the `T`-dual spacetime the cross-cap must be localized near one of the orientifold planes, because the string
  > theory in the bulk is oriented. **Thus we deduce that the orientifold planes are sinks for R–R charge. If we
  > `T`-dualize on `k` dimensions there are `2^k` orientifold planes but still 16 D-branes, so the charge of an
  > orientifold plane must be `−2^{4−k}` times that of a D-brane of the same dimension.**」
- 文献自称的严格程度：**"Thus we deduce"**——纯物理演绎，输入是「§10.8 的 tadpole 相消」这一**已知结果**，
  加上「体内理论有取向 ⇒ cross-cap 只能贴在 orientifold 面上」这一定性论断。**本章不重算任何 tadpole。**
- **本轮复算（抽取者做的，原书没写）**：总 O 面荷 `= 2^k × (−2^{4−k}) = −16`，总 D 膜荷 `= +16`，和为零 ✅。
  ⇒ 原书这套记账**在 §13.2 内部自洽**，用的单位是「一张 D 膜 = 1」且 D 膜数恒为 16。
- 备注：★★★ **这是本项目要找的「D9 + O9 荷相消」在本书的确切落点，但它的数字是 16 与 `−2^{4−k}`，不是 32 与 `−32`。**
  见 **E13** 与 **Q1**。

---

### E13 ★★★ 「type I = 16 张 D9 膜 + 一张 orientifold 9-plane」——本章最接近"SO(32) = N 张 D9"的逐字句
- 位置：§13.2 小节 *New connections between string theories*，**p. 144**（无式号）
- 类型：proposition
- 原文**逐字**（本轮已单页重渲染核对两次）：
  > 「In summary, we are now considering a single theory, which has a state that contains no D-branes and looks like
  > the ordinary IIA theory, a second state (`T`-dual to the first) that contains no D-branes and looks like the ordinary
  > IIB theory, and **a third state that contains 16 D9-branes (and an orientifold 9-plane) that looks like the type I
  > theory**. It also contains an infinite number of other states with very general configurations of D-branes.」
- 文献自称的严格程度：这是**总结句**，无独立论证；其依据是 E3/E12 那条 `T` 对偶链。
- 备注：**★★★ 本轮的核心否定结论：**
  1. **本章从不写「32 个 D9 膜」。** 全章唯一把 D9 数目写出来的地方就是这一句，数字是 **16**。
  2. 唯一蕴含 32 的说法是 E8 那句「each Chan–Paton degree of freedom … as a 9-brane」（type I 有 32 个 CP 指标）。
  3. **原书从不把这两种计数并列，也从不解释二者的关系**（常见的解释是「一张 D 膜连同其镜像 = 2 个 CP 指标」，
     但 `k = 0` 时镜像与本体重合，这个解释在本章语境下并不自动成立）。**这属于 Q1，未裁决。**
  4. ⇒ **图里绝不能写「Polchinski Vol.2 §13.2 说 type I = 32 张 D9 膜」。** 要写就写 16，并把 Q1 挂上。

---

### E14 D 膜使 type I / IIA / IIB 成为同一理论的不同态；带膜荷的超对称代数
- 位置：§13.2，eqs. **(13.2.9a)(13.2.9b)(13.2.9c)**、**(13.2.10)**，pp. 144–145
- 类型：proposition
- 原文陈述：
  **(13.2.9a)** `{Q_α, Q̄_β} = −2[P_M + (2πα')^{−1}Q^NS_M]Γ^M_{αβ}`
  **(13.2.9b)** `{Q̃_α, Q̃̄_β} = −2[P_M − (2πα')^{−1}Q^NS_M]Γ^M_{αβ}`
  **(13.2.9c)** `{Q_α, Q̃̄_β} = −2Σ_p (τ_p/p!) Q^R_{M_1…M_p}(β^{M_1}⋯β^{M_p})_{αβ}`
  其中 `Q^NS_M` 是**基本弦**（F-string）带的荷，`Q^R` 是与 R–R 形式耦合的荷；
  IIA 的求和跑偶数 `p`，IIB 跑奇数 `p`。**(13.2.10)** `β^{μ_1}⋯β^{μ_p} = β^⊥Γ^0`（up to an overall sign）。
  逐字（关于归一化的重要限定）：「Also, we have **changed conventions** so that all charges are now normalized to
  one per unit world-volume of the respective extended object, and so the string tension `(2πα')^{−1}` appears explicitly.」
- 作者自承缺口（逐字）：「Incidentally, the algebra (13.2.9) is **still not complete**: the *magnetic NS–NS charge*
  is missing. This is not carried by D-branes or F-strings. We discuss this further in the next chapter.」
- 另一条自承（p.144，关于「是否存在没有 D 膜的 type II」）：
  > 「so one might imagine that there is a different type II theory in which D-branes are not allowed.
  > **This seems unlikely, however: everything we know points to the uniqueness of the theory, so we do not know
  > alternatives.**」
- 备注：这条是 `duality` 区「type I/IIA/IIB 是同一理论的不同态」的一手落点，**强度只到 physical-argument**。

---

### E15 杂化弦上没有 D 膜
- 位置：§13.2 末，**p. 146**（无式号）
- 类型：proposition
- 原文**逐字**：
  > 「On the heterotic world-sheet there are no boundary conditions that preserve the world-sheet gauge symmetries,
  > and **there is no indication that D-branes exist**. Nevertheless, we will see in the next chapter that the
  > D-branes of the type I/II theory enable us to learn a great deal about the heterotic string as well.」
- 备注：注意措辞是 "no indication"，不是 "there are none"。

---

### E16 ★★ §13.3 BPS 无力：圆柱振幅 = 闭弦交换，NS–NS 与 R–R 精确相消
- 位置：§13.3 开篇，eqs. **(13.3.1)(13.3.2)(13.3.3)**，**p. 146**
- 类型：proposition
- 原文陈述：
  > 「**There is no force between static BPS objects of like charge.** The multi-object state is still supersymmetric
  > and so its energy is determined only by its charge and the separations. For parallel D`p`-branes, the unbroken
  > supersymmetry (13.2.5) is the same as for a single D`p`-brane.
  > The vanishing of the force comes about from a cancellation between attraction due to the graviton and dilaton
  > and repulsion due to the R–R tensor. We can calculate these forces explicitly from the usual cylinder vacuum
  > amplitude. **The exchange of light NS–NS closed strings was isolated in eq. (10.8.4).** Modify this expression by
  > removing the factors for the momentum integrations in the Dirichlet directions and introducing a term for the
  > tension of a string stretched over a separation `y^μ`:」

  **(13.3.1)**
  `𝒜_NS–NS ≈ [iV_{p+1}·4×16 / (8π(8π²α'⟨?⟩)⁵)] ∫₀^∞ (dt/t²)(8π²α't)^{(9−p)/2} exp(−ty²/2πα')`
  `           = iV_{p+1}·2π(4π²α')^{3−p}G_{9−p}(y)`
  （⟨?⟩：页图读作 `α'²`，复算要求 `α'`，见 §0.3(c) 与 **Q3**）
  其后一行给 `G_d(y) = 2^{−2}π^{−d/2}Γ(½d−1)y^{2−d}`。
  逐字：「**The Chan–Paton weight is 2 here, from the two orientations of the open string, and there is no factor of
  ½ from the orientation projection because the physics is locally oriented.** Due to supersymmetric cancellation in
  the trace, the R–R exchange amplitude is」**(13.3.2)** `𝒜_R–R = −𝒜_NS–NS`「and so the total force vanishes as expected.」
  再由 Vol.1 (8.7.25) 的场论计算（只需把 `6 = (D−2)/4` 换成 `2`）得 **(13.3.3)** `2iκ²τ_p²G_{9−p}(y)`。
- 文献自称的严格程度：**(13.3.1) 用了 "≈"**（原书自己的记号）；R–R 侧不是独立算出的，
  而是「Due to supersymmetric cancellation in the trace」直接断言；**(13.3.2) 因此是超对称输入而非计算输出**。
- 备注：★ **这是 `branes.bps-no-force` 的一手落点。** 注意 (13.3.1) 明写它是 **(10.8.4) 的修改版** ⇒
  本章与 §10.8 之间存在一条**技术性**（而非只是叙事性）的公式依赖。

---

### E17 ★ D 膜张力 `τ_p` 与 R–R 荷 `μ_p` 的显式值
- 位置：§13.3，eqs. **(13.3.4)**、**(13.3.5)**、**(13.3.6)**、**(13.3.7)**，pp. 146–147
- 类型：proposition
- 原文陈述：
  **(13.3.4)** `τ_p² = (π/κ²)(4π²α')^{3−p}`「This satisfies the same `T`-duality relation as in the bosonic string.」
  R–R 交换的低能作用量 **(13.3.5)** `−(1/4κ₁₀²)∫d^{10}x(−G)^{1/2}|F_{p+2}|² + μ_p∫C_{p+1}`；
  动能项正则归一 ⇒ 传播子 `2κ₁₀²i/k²`，场论振幅 **(13.3.6)** `−2κ₁₀²iμ_p²G_{9−p}(y)`；
  **(13.3.7)** `μ_p² = (π/κ₁₀²)(4π²α')^{3−p} = e^{2Φ_0}τ_p² = T_p²`。
  **显式的 `τ_p`** 见 (13.3.23)（E21）：`τ_p = 1/(g(2π)^pα'^{(p+1)/2}) = (2κ²)^{−1/2}(2π)^{(7−2p)/2}α'^{(3−p)/2}`。
- 备注：**⚠ 任务书问的「τ_p 显式公式 (13.3.x)?」——答案是两条**：
  平方形式 **(13.3.4)**（在 §13.3 开头，`κ` 表示）与显式形式 **(13.3.23)**（在 *Coupling constants* 小节，`g, α'` 表示）。
  **不在 §13.4/§13.5。**

---

### E18 D 膜–orientifold 面之间的力：多一个 `−(2^{5−k})`，与荷的 `−(2^{4−k})` 相差因子 2
- 位置：§13.3，**p. 147**（无式号）
- 类型：proposition
- 原文**逐字**：
  > 「The reader can carry out a similar calculation of the force between a D-brane and an orientifold plane and show
  > that it has an additional `−(2^{5−k})`. **We deduced from the cancellation of divergences that the charge of the
  > orientifold plane should have a factor of `−(2^{4−k})`; the extra factor of 2 in the force arises because the
  > orientifold geometry squeezes the flux lines into half the solid angle.**」
- 文献自称的严格程度：**"The reader can carry out …" —— 这一步被完全推给读者，本章不做。**
- 备注：★ 注意逐字「**We deduced from the cancellation of divergences**」——**再次确认 O 面荷是从 §10.8 的 tadpole
  相消倒推出来的，不是本章独立算出的。** 本章唯一可能独立定它的路线（膜–O 面的力）被推给了读者。

---

### E19 ★ Dirac 量子化条件与「最小量子 `n = 1`」
- 位置：§13.3 小节 *Dirac quantization condition*，eqs. **(13.3.8)–(13.3.13)**，pp. 147–149；fig. 13.3 p.148
- 类型：proposition
- 原文陈述：复习四维 Dirac 条件：**(13.3.8)** `∫_{S_2}F_2 = μ_m`；相位 **(13.3.9)** `exp(iμ_e∮_P A_1) = exp(iμ_e∫_D F_2)`；
  收缩到 Dirac 弦附近得 **(13.3.10)** `exp(iμ_e∫_{S_2}F_2) = exp(iμ_eμ_m)`；
  「The Dirac string must be invisible, so this phase must be 1」⇒ **(13.3.11)** `μ_eμ_m = 2πn`。
  推广：`p` 膜与 `(6−p)` 膜分别是 `F_{p+2}` 与 `F_{8−p}` 的源，互为 Poincaré 对偶
  ⇒ **(13.3.12)** `∫_{S_{p+2}}F_{p+2} = μ_{6−p}/2κ₁₀²`，最终
  **(13.3.13)** `μ_pμ_{6−p} = πn/κ₁₀²`。
  > ⚠ **reviewer-branes 复核（2026-09-11，加行，不改上面的原记录）**：上一行 (13.3.12) 的系数**应为 `2κ₁₀²μ_{6−p}`**，
  > 不是 `μ_{6−p}/2κ₁₀²`。两条理由：(i) 与 (13.3.13) 自洽——Dirac 弦不可观测给 `μ_p·∫F = 2πn`，
  > 代 `∫F = 2κ₁₀²μ_{6−p}` 恰得 `μ_pμ_{6−p} = πn/κ₁₀²`，而代原读数得 `4πnκ₁₀²`；
  > (ii) 与 (13.3.5) 的动能项 `−(1/4κ₁₀²)∫|F|²` 自洽——场方程 `(1/2κ₁₀²)d∗F = μδ` ⇒ `∫∗F = 2κ₁₀²μ`，
  > `κ₁₀²` 在分子（同 (13.3.6) 的传播子 `2κ₁₀²i/k²`）。
  > **待 researcher 核印刷页 148 定案**；在此之前图上以 `branes.rr-charge-quantization-v2` 为准。
  > 本条**不影响** §0.3(b) 的 `n = 1` 复算（那一步只用 (13.3.7) 与 (13.3.13)）。
  **逐字**：
  > 「**Remarkably, the charges (13.3.7), arrived at in an entirely different way, satisfy this relation with the
  > minimum quantum `n = 1`.**」
- **本轮复算（抽取者做的）**：见 §0.3(b)，**`n = 1` 精确成立**，且 `(4π²α')` 的幂次恰好抵消。✅
- 备注：★ 这是 `branes.rr-charge-quantization` 的一手落点。
  ⚠ **它是一致性检验，不是 `μ_p` 的推导**（`μ_p` 由 (13.3.7) 的振幅计算给出）。转卡时不要把逻辑方向搞反。

---

### E20 D 膜的 Dirac–Born–Infeld 作用量与非阿贝尔推广
- 位置：§13.3 小节 *D-brane actions*，eqs. **(13.3.14)(13.3.15)**，p. 149
- 类型：proposition
- 原文陈述：**(13.3.14)**
  `S_{Dp} = −μ_p ∫ d^{p+1}ξ Tr{ e^{−Φ}[−det(G_{ab} + B_{ab} + 2πα'F_{ab})]^{1/2} }`
  逐字：「where `G_{ab}` and `B_{ab}` are the components of the spacetime NS–NS fields parallel to the brane and
  `F_{ab}` is the gauge field living on the brane. **The argument leading to this form is exactly as in the bosonic
  case, section 8.7.**」
  `n` 张近距 D 膜：`X^m(ξ)`、`A_a(ξ)`、`λ(ξ)` 都成为 `n × n` 矩阵，迹在这个空间里；势里另有
  **(13.3.15)** `O([X^m,X^n]²)`——「in the flat directions the collective coordinates become diagonal.
  They can then be interpreted as `n` ordinary collective coordinates for `n` objects. **At small separation the full
  matrix dynamics is crucial**, as we will see.」
- 文献自称的严格程度：**整条推导外包给 Vol.1 §8.7**（本项目 `polchinski-1998-v1.md` E154 已记该处两个复现缺口）。
- ⚠ 注意 **(13.3.14) 用 `μ_p` 而不是 `τ_p`** 做整体系数（与 Vol.1 §8.7 的 `τ_p` 写法不同）；由 (13.3.7) `μ_p = e^{Φ_0}τ_p`，
  两者靠 `e^{−Φ}` 因子的 dilaton 背景值换算。**转卡时必须写明用的是哪一个。**

---

### E21 Chern–Simons 型 R–R 耦合；曲率修正未算
- 位置：§13.3，eqs. **(13.3.16)(13.3.17)(13.3.18)(13.3.19)**，pp. 149–150
- 类型：proposition
- 原文陈述：从 (1,2) 面内的 1 膜出发，**(13.3.16)** `∫C_2 = ∫dx^0(dx^1C_{01} + dx^2C_{02}) = ∫dx^0dx^1(C_{01} + ∂_1X^2C_{02})`；
  作 2-方向的 `T` 对偶变成 **(13.3.17)** `∫dx^0dx^1dx^2(C_{012} + 2πα'F_{12}C_0)`（用了 (13.1.5) 的 `C` 变换）。
  逐字：「**We are not keeping track of the normalization but one could, with the result `μ_p = μ_{p−1}/2πα'^{1/2}`
  in agreement with the explicit calculation.**」
  推广到一般构型与多张膜给 **(13.3.18)**
  `iμ_p ∫_{p+1} Tr[ exp(2πα'F_2 + B_2) ∧ Σ_q C_q ]`
  ——「the integral picks out precisely the terms that are proportional to the volume form of the `p`-brane world-volume.」
  **作者自承缺口（逐字）**：
  > 「**There are similar couplings with the spacetime curvature in addition to the field strength; these can be obtained
  > from a string calculation.**」（该计算本章不做、不引。）
  费米作用量 **(13.3.19)** `−i∫d^{p+1}ξ Tr(λ̄Γ^aD_aλ)`，随后逐字：
  > 「**The full nonlinear supersymmetric form is left to the references.**」
- 备注：(13.3.18) 后来在 §13.6 被用来验证 D0 荷（(13.6.23)、(13.6.35)），见 E29/E31。

---

### E22 ★ 耦合常数：`g` 的定义、`κ`、`τ_p`、`g_{Dp}` 的显式值
- 位置：§13.3 小节 *Coupling constants*，eqs. **(13.3.20)–(13.3.25)**，pp. 150–151
- 类型：definition + proposition
- 原文陈述：
  **(13.3.20)** `τ_{F1}/τ_{D1} = (1/2πα')·(κ/4π^{5/2}α') = κ/(8π^{7/2}α'²)`
  **(13.3.21)** `g = τ_{F1}/τ_{D1}`（**定义**，见 §1.2 的逐字理由）
  **(13.3.22)** `κ² = ½(2π)^7 g²α'^4`
  **(13.3.23)** `τ_p = 1/(g(2π)^pα'^{(p+1)/2}) = (2κ²)^{−1/2}(2π)^{(7−2p)/2}α'^{(3−p)/2}`
  **(13.3.24)** `κ₁₀² = ½(2π)^7α'^4`
  **(13.3.25)** `g²_{Dp} = 1/((2πα')²τ_p) = (2π)^{p−2}gα'^{(p−3)/2}`
  ——「Notice that for `p = 3` this coupling is dimensionless, as expected in a `(3+1)`-dimensional gauge theory.」
- **本轮复算**：(13.3.20)/(13.3.22)/(13.3.23)/(13.3.25) 与 (13.3.4) **五式互相自洽，逐位验过**（§0.3a）。✅
- 备注：★ **这是本书全部 D 膜数值系数的锚点，可以放心建卡。**

---

### E23 type I 的 `g_YM`–`κ` 关系与 Born–Infeld 形式的规范作用量
- 位置：§13.3，eqs. **(13.3.26)–(13.3.34)**，pp. 151–152
- 类型：proposition
- 原文陈述：(13.3.25) 是**有取向**理论中 `U(n)` 规范群的耦合，出现在 **(13.3.26)** `(1/4g²_{Dp})Tr_f` 里；
  把膜移到 orientifold 面上使规范对称性扩大为 `SO(2n)`，`SU(n)` 生成元嵌入为
  **(13.3.27)** `t̃ = [[t, 0],[0, −t^T]]`「because the orientation projection reverses the order of the Chan–Paton factors
  and the sign of the gauge field」；比较低能作用量得 **(13.3.28)** 与 `g²_{Dp,SO(2n)} = 2g²_{Dp}`。
  再对 `k`-环面紧化的 type I 用 **(13.3.29)(13.3.30)**（后者「has an extra factor of 2 because the compact space is an
  orientifold, its volume halved」）得到与 `k` 无关的
  **(13.3.31)** `g²_{YM}/κ = 2(2π)^{7/2}α'` （type I）。
  最后：「the Born–Infeld form for the gauge action applies by `T`-duality to the type I theory」
  **(13.3.32)** `S = −(1/((2πα')²g²_{YM}))∫d^{10}x Tr{[−det(η_{μν} + 2πα'F_{μν})]^{1/2}}`，
  其四次项 **(13.3.33)** 与前一章的树级弦修正 **(12.4.28)** 相符；用到恒等式
  **(13.3.34)** `det^{1/2}(1+M) = exp[½tr(M − ½M² + ⅓M³ − ¼M⁴ + …)]`。
- 作者自承的限定（逐字）：
  > 「We cannot quite identify `g_{Dp}` for `p = 9` with `g_{YM}`, because the former has been obtained in a locally
  > oriented theory and there are some additional factors of 2 in the type I case. Rather than repeat the string
  > calculation we will make **a more roundabout but possibly instructive argument using `T`-duality**.」
  另（p.152 末）：「**Note that only when the gauge field can be diagonalized can we give a geometric interpretation
  to the `T`-dual configuration and so derive the Born–Infeld form.**」
- 备注：**(13.3.33) ↔ (12.4.28) 的一致性是本章唯一一处与第 12 章的定量对接**，
  本项目 `polchinski-1998-v2-ch12.md` 若已记 (12.4.28)，可以建一条交叉核对的 note。

---

### E24 §13.4 `#ND` 与保留超对称的计数
- 位置：§13.4，eqs. **(13.4.1)(13.4.2)(13.4.3)**、**(13.4.8)**，pp. 152–154
- 类型：proposition
- 原文陈述：把坐标按两张膜各自的 D/N 条件分成 `S_D, S_N` 与 `S'_D, S'_N`；`DD = S_D∩S'_D`，`ND = S_N∩S'_D`，等等。
  第一张膜保留 **(13.4.1)** `Q_α + (β^⊥Q̃)_α`，`β^⊥ = ∏_{m∈S_D}β^m`；第二张保留 **(13.4.2)**（同型，`S'_D`）。
  两者同时保留的超对称与 `(β^⊥)^{−1}β^{⊥'}` 的不变旋量一一对应；把 `#ND = 2j` 配对成 `π` 转动得
  **(13.4.3)** `β ≡ (β^⊥)^{−1}β^{⊥'} = exp[πi(J_1 + … + J_j)]`。
  「In a spinor representation, each `exp(iπJ)` has eigenvalues `±i`, so there will be unbroken supersymmetries only if
  `j` is even and so **`#ND` is a multiple of 4**. In this case there are **eight** unbroken supersymmetries, one quarter
  of the original 32. Note that `T`-duality switches `NN↔DD` and `ND↔DN` and so leaves `#ND` invariant.
  When `#ND = 0` … there are then **16** unbroken supersymmetries.」
  NS 部分的零点能 **(13.4.8)** `(8 − #ND)(−1/24 − 1/48) + #ND(1/48 + 1/24) = −½ + #ND/8`。
  另给四种边界条件的 doubling trick **(13.4.4)–(13.4.7)** 与模展开 **(13.4.5a)(13.4.5b)**。
- 备注：`#ND` 是本章后半（§13.5–§13.6）几乎所有结论的组织原理。

---

### E25 任意夹角的 D 膜：保留超对称的分类与相互作用势
- 位置：§13.4 小节 *Branes at general angles*，eqs. **(13.4.9)–(13.4.27)**，pp. 154–158；fig. 13.4 p.158
- 类型：proposition
- 原文陈述：两张 D4 膜，其一在 `(2,3)`、`(4,5)`… 平面内转 `φ_1, φ_2, …`（记作 `ρ`）。
  同时保留的超对称由 **(13.4.10)** `(β^⊥)^{−1}ρ^{−1}β^⊥ρ = ρ²` 的不变旋量给出，
  `ρ²` 在 **s**-基下的本征值 **(13.4.11)** `exp(2iΣ_{a=1}^4 s_aφ_a)`。逐条结论（原文的 bullet 列表）：
  一般 `φ_a` 无保留超对称；`φ_1+φ_2+φ_3+φ_4 = 0 mod 2π` 保留 **2** 个（破缺 7/8）；
  `φ_1+φ_2+φ_3 = φ_4 = 0` 保留 **4** 个；`φ_1+φ_2 = φ_3+φ_4 = 0` 保留 **4** 个；`φ_1+φ_2 = φ_3 = φ_4 = 0` 保留 **8** 个。
  用 `U(4) ⊂ SO(8)` 语言重述（**(13.4.12)** `diag[e^{iφ_1},…,e^{iφ_4}]`）：
  「a general `U(4)` rotation breaks all the supersymmetry, an `SU(4)` rotation breaks seven-eighths, an `SU(3)` or
  `SU(2)×SU(2)` rotation breaks three-quarters, and an `SU(2)` rotation breaks half.」
  势的显式表达 **(13.4.23)**
  `V = −∫₀^∞ (dt/t)(8π²α't)^{−1/2} exp(−ty_1²/2πα') ∏_{a=1}^4 [ϑ_{11}(iφ'_at/π, it)/ϑ_{11}(iφ_at/π, it)]`
  （用到 (13.4.16)–(13.4.22) 的配分函数与 abstruse identity (7.2.41) 的推广）。
  **反平行情形（`φ_1 = π`）**：NS–NS 与 R–R 都吸引，临界间距 `y_1² = 2π²α'` 以下圆柱振幅发散
  ⇒「**This is where the tachyon appears — evidently it represents D4-brane/anti-D4-brane annihilation.**」
  最轻态质量 **(13.4.27)** `m² = y_1²/(4π²α'²) − φ_1/(2πα')`，`0 ≤ φ_1 ≤ π`。
- 作者自承的例外（逐字，重要）：
  > 「Curiously this covers only eight of the sixteen phases (13.4.11), so that if some phases (13.4.11) are unity but
  > not those of the form `exp(±2iφ'_a)`, then **supersymmetry is unbroken but the potential is nonzero. This is an
  > exception to the usual rule that the vacuum loop amplitudes vanish by Bose–Fermi cancellation.**」
- **脚注 4（p.156，方法论上的自承）逐字**：
  > 「If one applies the formalism of the previous chapter, in the (P,P) spin structure there are two `βγ` zero modes and
  > two longitudinal `ψ` zero modes for a net `0²/0²`. One can define this by a more careful gauge fixing, or equivalently
  > by adding a graviton vertex operator … **However, we simply rely on the physical input of the Coleman–Weinberg formula.**」

---

### E26 §13.5 D 膜散射：`v⁴` 势、亚弦标度分辨率、新不确定关系
- 位置：§13.5 小节 *D-brane scattering*，eqs. **(13.5.1)–(13.5.12)**，pp. 158–161
- 类型：proposition
- 原文陈述：把 (13.4.23) 解析延拓（`φ_1 = −iu`，`X^3 = X'^0 tanh u`）得 **(13.5.2)(13.5.3)**，写成世界线积分
  **(13.5.4)–(13.5.6)**。逐字：「The interaction has a number of interesting properties. The first is that as `v → 0`
  … **it vanishes as `v⁴`** from the zeros of the theta functions.」
  长程展开 **(13.5.7)** `V(r,v) = −(v⁴/r^{7−p})·(V_p/α'^{p−3})·2^{2−2p}π^{(5−3p)/2}Γ((7−p)/2) + O(v⁶)`。
  短程：不先展开 `v` 得 **(13.5.8)**，有效分辨标度 **(13.5.9)** `r ≈ α'^{1/2}v^{1/2}`
  ⇒「**A small-velocity D-brane probe is thus sensitive to distances shorter than the string scale.** This is in contrast
  to the behavior we have seen in string scattering at weak coupling, but fits nicely with the understanding of strongly
  coupled strings in the next chapter.」
  由 `δt ≈ r/v` 得 **(13.5.10)** `δxδt ≳ α'`——「This is **a suggestion for a new uncertainty relation** involving only the
  coordinates. It is another indication of '**noncommutative geometry**,' **perhaps** connected with the promotion of
  D-brane collective coordinates to matrices.」
  D0 探针的最小可测距离 **(13.5.11)** `δx ≳ 1/(mδv) = gα'^{1/2}/δv`，与 (13.5.9) 联合极小化给
  **(13.5.12)** `δx ≳ g^{1/3}α'^{1/2}`。
- **脚注 5（p.159）逐字**：「**We find it difficult to keep track of the sign during the continuation**, but it is easily
  checked by looking at the contribution from NS–NS exchange in the static limit. Note that the `ϑ_{11}` are negative
  for small positive `u`.」
- 备注：(13.5.10)/(13.5.12) 的措辞是 "a suggestion"、"perhaps"——**强度只到 physical-argument 以下**，转卡要写清。

---

### E27 D0 膜量子力学（矩阵模型的前身）
- 位置：§13.5 小节 *D0-brane quantum mechanics*，eqs. **(13.5.13)–(13.5.17)**，pp. 161–162
- 类型：proposition
- 原文陈述：`n` 张 D0 膜的非相对论有效拉氏量 **(13.5.13)**
  `L = Tr{ (1/2gα'^{1/2})D_0X^iD_0X^i + (1/(4gα'^{1/2}(2πα')²))[X^i,X^j]² − (i/2)λD_0λ + (1/4πα')λΓ^0[X^i,λ] }`
  （质量 `m = τ_0 = 1/gα'^{1/2}`；其余系数「are most easily obtained by `T`-duality from the ten-dimensional
  super-Yang–Mills action (B.6.13), with `A^i → X^i/2πα'`」）。
  Hamiltonian **(13.5.14)**；标度变换 **(13.5.16)** `X^i = g^{1/3}α'^{1/2}Y^i` 后
  **(13.5.17)** `H = (g^{1/3}/α'^{1/2})Tr{½p_{Yi}p_{Yi} − (1/16π²)[Y^i,Y^j]² − (1/4π)λΓ^0[Y^i,λ]}`
  ⇒「**The parameters `g` and `α'` now appear only in the overall normalization.**」特征尺度回到 (13.5.12)，时间尺度回到 (13.5.10)。
  逐字限定：「**Only terms with at most two powers of the velocity have been kept, not the full Born–Infeld action.**」

---

### E28 `#ND = 4` 系统：5–9 弦与超对称场论
- 位置：§13.5 小节 *The `#ND = 4` system*，eqs. **(13.5.18)–(13.5.24)**，pp. 162–164
- 类型：proposition
- 原文陈述：取 `p = 5, p' = 9`；5–9 弦的 NS 零点能为零，四个周期性横向费米子给 `2^{4/2} = 4` 个简并基态
  **(13.5.18)** `|s_3, s_4⟩_NS`，GSO 投影 **(13.5.19)** `−exp[πi(s_3+s_4)] = +1 ⇒ s_3 = s_4`；R 侧 **(13.5.20)** 要求 `s_1 = −s_2`。
  ⇒ `d = 6, N = 1` 超对称，8 个超对称荷，5–9 谱构成**半个超多重态**（另一半来自 9–5）。
  玻色部分作用量 **(13.5.21)**
  `S = −(1/4g²_{D9})∫d^{10}x F_{MN}F^{MN} − (1/4g²_{D5})∫d^6x F'_{MN}F'^{MN} − ∫d^6x[D_μχ†D^μχ + (g²_{D5}/2)Σ_{A=1}^3(χ_i†σ^A_{ij}χ_j)²]`
  逐字：「**The action is fully determined by supersymmetry and the charges**; we write the bosonic part.」
  另注：期待中的 9-9 `D`-term「is inversely proportional to the volume of the D9-brane in the (6,7,8,9)-directions,
  which we have taken to be infinite」。
  `T` 对偶下 `(p,p') = (8,6), (7,7), (6,8), (5,9)`，交线恒为 `(5+1)` 维。

---

### E29 §13.6 `(p,q)` 弦：BPS 界与 F–D 束缚态
- 位置：§13.6 小节 *FD bound states*，eqs. **(13.6.1)–(13.6.14)**，pp. 164–167；fig. 13.5 p.165
- 类型：proposition
- 原文陈述：由 (13.2.9) 得 **(13.6.1)**，本征值 **(13.6.2)**，BPS 界
  **(13.6.3)** `M/L_1 ≥ (p² + q²/g²)^{1/2}/(2πα')`，F 弦 `(1,0)` 与 D 弦 `(0,1)` 饱和之。
  分离的 F+D **(13.6.4)** `τ_{(0,1)} + τ_{(1,0)} = (g^{−1}+1)/(2πα')` 超过界 **(13.6.5)** `τ_{(1,1)} = (g^{−2}+1)^{1/2}/(2πα')`
  ⇒ 不超对称。机制（fig. 13.5）：F 弦断裂、端点附着到 D 弦上、跑到无穷远，留下**电通量**；由 D 弦作用量
  **(13.6.7)** `S_1 = −T_1∫d²ξ e^{−Φ}[−det(G_{ab}+B_{ab}+2πα'F_{ab})]^{1/2}`
  可见 `B_{μν}` 的源正比于不变电通量 `𝓕_{ab} = F_{ab} + B_{ab}/2πα'`。
  束缚能 **(13.6.8)** `τ_{(1,0)}+τ_{(0,1)} − τ_{(1,1)} = (1 − O(g))/(2πα')`——「the bound state is quite deep」。
  世界面侧：**(13.6.9)** 面项 ⇒ **(13.6.10)** `∂_nX_μ + 2πα'iF_{μν}∂_tX^ν = 0`。
  一般 `(p,q)`：`SU(2)` 部分强耦合，用超势加质量项 **(13.6.14)** `W(Φ) = Tr(Φ_1[Φ_2,Φ_3]) + m Tr(Φ_iΦ_i)` 的策略论证。
- **作者自承缺口（逐字，两条）**：
  > 「The theory cannot then be solved directly, but **it has been shown by indirect means** that there is a string
  > saturating the BPS bound for all `(p,q)` such that `p` and `q` are relatively prime. **We will sketch the argument
  > and leave the details to the references.**」
  > 「**We leave it as an exercise to verify that the tension takes the BPS value.**」（p.166，关于 D1–F1 的 `T` 对偶像）
- 备注：`p, q` 不互素时「the system is only marginally unstable against falling apart into `k` subsystems … and
  **there is believed to be no bound string** in this case」——**"is believed"，强度是 conjecture 级。**

---

### E30 D0–D`p` 的 BPS 界
- 位置：§13.6 小节 *D0–D`p` BPS bound*，eqs. **(13.6.15)–(13.6.19)**，p. 168
- 类型：proposition
- 原文陈述：**(13.6.15)(13.6.16)** 给出带 `Z = τ_0 + τ_pV_pβ`、`β = β^1⋯β^p` 的代数；正定性 **(13.6.17a,b)** 得
  `p = 4k`（`β` 厄米、`β² = 1`）：**(13.6.18)** `M ≥ τ_0 + τ_pV_p`；
  `p = 4k+2`（`β` 反厄米、`β² = −1`）：**(13.6.19)** `M ≥ (τ_0² + τ_p²V_p²)^{1/2}`。
  「These bounds are consistent with our earlier results on supersymmetry breaking, noting that `#ND = p`.」
  逐字：「**The reader can extend the analysis of the BPS bound to general values of `p` and `p'`.**」（推给读者）

---

### E31 D0–D`p` 束缚态逐例（含 D 膜作为 instanton）
- 位置：§13.6 小节 *D0–D0 / D0–D2 / D0–D4 / D-branes as instantons / D0–D6 / D0–D8*，eqs. **(13.6.20)–(13.6.36)**，pp. 168–175
- 类型：proposition（合并条目；细节按需再展开）
- 要点与逐字：
  - **D0–D0**：紧化 9-方向、加一个单位动量后可讨论；`T` 对偶到 `(1,2)` 弦的 ultrashort 多重态 `2^8` 态。
    逐字缺口：「However, it is a logical possibility that the size of these states grows with `R` such that the states
    becomes nonnormalizable in the limit. **To show that the bound states actually exist requires a difficult analysis,
    which has been carried out fully only for `n = 2`.**」
  - **D0–D2**：D0 溶入 D2 变成磁通量，**(13.6.22)** `∫_{D2}F_2 = 2π`；由 CS 作用量 (13.3.18) 展开得
    **(13.6.23)** `iμ_2∫(C_3 + 2πα'F_2∧C_1)`，「the normalizations are consistent with `μ_0 = 4π²α'μ_2`」。
  - **D0–D4**：束缚态在原超对称的 1/4 下不变，落在 `2^{12}` 的 short（非 ultrashort）多重态；简并度母函数
    **(13.6.24)** `Σ_{n=0}^∞ q^nD_n = 2^8 ∏_{k=1}^∞ ((1+q^k)/(1−q^k))^8`。
    逐字：「the details are left to the references.」以及「This is apparently correct, **but the justification is not
    simple**.」（关于 `D_{mn}`）与「the answer **has been argued** to be `D_{mn}` as asserted before.
    (**The connection with the fractional-brane picture is complicated and the latter is perhaps unphysical.**)」
  - **D-branes as instantons**：Higgs/Coulomb 分支 **(13.6.26)(13.6.27)**；自对偶 **(13.6.32)** `∗F_2 = ±F_2`；
    gaugino 变分 **(13.6.33)**；旋量分解 **(13.6.34)** `(4,2,1) + (4',1,2)`；
    由 CS 作用量得 **(13.6.35)** `½(2πα')²μ_4∫C_1∧Tr(F_2∧F_2)`，拓扑荷 **(13.6.36)** `∫_{D4}Tr(F_2∧F_2) = 8π²`
    ⇒ 总耦合 `(4π²α')²μ_4 = μ_0`——**「exactly the charge of the D0-brane」**（又一次独立的荷一致性检验）。
    另：「This provides a physical realization of the so-called **Atiyah–Drinfeld–Hitchin–Manin (ADHM) construction** of
    the general instanton solution.」
  - **D0–D6**：「**So it appears that there are no supersymmetric bound states.**」（"it appears"）
  - **D0–D8（本章最后一段）逐字**：
    > 「This system is complicated in a number of ways and **we will not pursue it**. As one example of the complication,
    > the R–R fields of the D8-brane do not fall off with distance (it has codimension 1, like a planar source in `3+1`
    > dimensions). The total energy is then infinite, and when the couplings to the dilaton and metric are taken into
    > account the dilaton diverges a finite distance from the D8-brane. **Thus the D8-brane cannot exist as an independent
    > object, but only in connection with orientifold planes such as arise in the `T`-dual of the type I theory.**」
- 备注：最后这句是本章唯一一处**从动力学侧**（而非荷相消侧）论证 D 膜必须与 O 面共存的地方。

---

### E32 习题清单（12 道）
- 位置：pp. 175–177
- 类型：元数据
- **13.1**（type II 无质量场在 orientifold 镜像点的关系；八维 orientifold 面上哪些 IIA 场满足 D/N 条件）——
  引用 Vol.1 **(8.8.3)**；**13.2**（D`p` 膜上四个玻色开弦态的散射，"this should be very little work"）；
  **13.3**（三张 D4 + 一张 D0 的保留超对称与 `T` 对偶可达构型）；**13.4**（D2–D0 静态势，用 `T` 对偶作用到 (13.4.23)）；
  **13.5**（同上，D0–D6）；**13.6**（D4–D0 的速度依赖相互作用）；**13.7**（短距 D0–D4，用 `(5+1)` 维费米拉氏量的降维）；
  **13.8**（大 `r`/小 `r` 的全 `v` 依赖）；**13.9**（无穷长 F 弦 + D3 膜保留超对称的构型）；
  **13.10**（D 弦作用量算带 `q` 单位电通量的张力，与 (13.6.3) 比较）；**13.11**（详细验证 (13.6.24) 的计数）；
  **13.12**（`(p_i,q_i)` 三弦结点的力学稳定性与 1/4 超对称）。
- 备注：⚠ **本章 12 道习题里，13.4/13.5/13.6/13.8/13.10/13.11 都是「正文没做完、请读者补」的类型**，
  与 §10.8「一道习题都没有」正好相反 ⇒ **对本章的强度评估是负面的**（见 §3.1）。

---

## 3. 否定结论与未核实清单

### 3.1 ★ 作者自承的缺口 / 外包（逐字，本章共 14 条）

> 这是本章强度评估的主要依据。**第 13 章是全书里"把事情推给别处"最密集的章之一**，与 §10.8 形成鲜明对比。

| # | 位置 | 逐字 |
|---|---|---|
| 1 | p.138 | 「… by the same arguments as for the bosonic string in chapter 8, **which the reader should review**」 |
| 2 | p.138 | 「There are some signs that should be noted but **should not distract attention from the main physical point**」（(13.1.6) 后） |
| 3 | p.140 | 「**We conclude by analogy that** the D-brane also spontaneously breaks 16 of the 32 spacetime supersymmetries」 |
| 4 | p.141 脚注 2 | 「**there is no local covariant action** for a system with both electric and magnetic charges … and **presumably** satisfies the axioms of local quantum field theory」 |
| 5 | p.142 | 「**it is not hard to verify explicitly that this does not happen**」（环面紧化不改变 tadpole 相消——未验证） |
| 6 | p.144 | 「This seems unlikely, however: **everything we know points to the uniqueness of the theory, so we do not know alternatives**」 |
| 7 | p.145 | 「**Presumably** we must do the same for the D0-branes as well」 |
| 8 | p.145 | 「Incidentally, the algebra (13.2.9) is **still not complete**: the magnetic NS–NS charge is missing」 |
| 9 | p.147 | 「**The reader can carry out** a similar calculation of the force between a D-brane and an orientifold plane」 |
| 10 | p.149 | 「The argument leading to this form is **exactly as in the bosonic case, section 8.7**」（DBI 作用量整体外包） |
| 11 | p.149 | 「**We are not keeping track of the normalization** but one could, with the result `μ_p = μ_{p−1}/2πα'^{1/2}`」 |
| 12 | p.150 | 「There are similar couplings with the spacetime curvature …; **these can be obtained from a string calculation**」（未做） + 「The full nonlinear supersymmetric form is **left to the references**」 |
| 13 | p.156 脚注 4 / p.159 脚注 5 | 「**we simply rely on the physical input of the Coleman–Weinberg formula**」／「**We find it difficult to keep track of the sign during the continuation**」 |
| 14 | pp.166/169/170/172/175 | 「it has been shown by **indirect means** … **leave the details to the references**」／「requires a difficult analysis, which has been **carried out fully only for `n = 2`**」／「the details are **left to the references**」／「**This is apparently correct, but the justification is not simple**」／「**it appears that** there are no supersymmetric bound states」 |

### 3.2 ★★★ 本章**没有**出现的东西（逐条都是通读 42 页页图后的否定观察）

1. **★ 本章从不写「32 个 D9 膜」，也从不写「`SO(32)` = 32 D9-branes」。**
   全章唯一给出 D9 数目的句子是 **E13**（p.144）：「**16 D9-branes (and an orientifold 9-plane)**」。
   唯一蕴含 32 的说法是 **E8**（p.141）「each Chan–Paton degree of freedom … as a 9-brane」（CP 指标 32 个）。
   **两者在同一节内并存，原书不加调和。**
   ⇒ **本项目不得把「SO(32) = 32 个 D9」这句现代通行说法归给 Polchinski Vol.2 ch.13。** 见 **Q1**。
2. **本章从不重述 §10.8 的 `(n ∓ 32)²`**，也不出现 `2^{13}`、`SO(8192)`、`USp(32)`。
   `(n ∓ 32)²` 与 `SO(32)` 的 tadpole 计算**一次都没有被重做**；本章三处引用它（E8/E11/E18）**都是当输入用**。
3. **本章不含 "anomaly" 一词**（也没有 "hexagon"、"Green–Schwarz"、"Weyl anomaly"、"superconformal anomaly"）。
   ⇒ **`-sec10-8.md#Q2`（§10.6 承诺的 "superconformal anomaly" 在哪）在本章没有兑现**；见 **Q2**。
   ⚠ 该判断基于 42 页页图的通读，**不是文本层 grep**（PDF 二进制，本环境无法可靠 grep）。等级：**L1 观察，非穷尽检索**。
4. **本章零文献引用**（无 "(Author, year)"、无编号引文），尽管五处说 "left to the references"。
   ⇒ **不能用本章去补任何一手文献的引用链。**
5. **本章不讨论 `n = 0`（纯闭弦无取向理论）**；只在 E11 里以「groups other than `SO(32)`」一笔带过。
   ⇒ **`-sec10-8.md#Q6` 在本章只得到"图像"而非"论证"**；见 **Q4**。
6. **本章不给 D 膜的黑膜/超引力解**（p.142 脚注 3 逐字：「In the next chapter we will discuss a seemingly different
   kind of R–R source, the *black `p`-brane*.」）⇒ 那是第 14 章。
7. **本章不出现 "K-theory"、"tachyon condensation"**（1998 年之前的书，正常）。

### 3.3 本章引用、但本轮**未翻页核对**的外部式号

| 被引式号 / 节号 | 本章在哪里引它 | 本项目是否已 L1 核过 |
|---|---|---|
| **§10.8**（节号，两次；(10.8.4) 一次带式号） | E8 / E11 / E16 | ✅ `polchinski-1998-v2-sec10-8.md` E64–E75（L1） |
| **§12.1**（IIA 9-form / massive IIA） | E8 | ⚠ `polchinski-1998-v2-ch12.md` 覆盖 §12.1，但**是否含 9-form 这一段未核** |
| **(12.1.14)**（R–R 顶点算子的 picture） | E17 前一段（p.147） | ❓ 未核 |
| **(12.4.28)**（type I 有效作用量的树级弦修正） | E23 | ❓ 未核（`-ch12.md` 是否记了该式待查） |
| **(12.6.24)**（refermionization） | E25（(13.4.21) 的物理来源） | ❓ 未核 |
| **(11.6.32)**（杂化弦对易子） | E14 | ❓ 未核 |
| **(10.2.22)**（GSO 投影用 `s_a` 表示） | E28 | ✅ `polchinski-1998-v2.md`（ch.10 已 L1 通读） |
| **(7.2.41)**（abstruse identity）、**§7.2**（θ 函数） | E25 | ✅ `polchinski-1998-v1-ch7.md`（L1） |
| **Vol.1 §8.7**、**(8.7.25)**、**(8.8.3)** | E16 / E20 / E32 | ✅/⚠ `polchinski-1998-v1.md` E153–E157 覆盖 §8.7（**但那是 [S] 二手源，原书表达式未抄出**）；(8.8.3) 未核 |
| **(B.6.13)**（十维 SYM）、**§B.2**（BPS）、**§B.6/§B.7** | E6 / E27 / E28 | ❌ App. B 本项目完全未抽 |
| **§9.7**（微扰论高阶行为 ⇒ `e^{−O(1/g)}`） | E10 | ❌ 未抽 |

⇒ **与 §10.8 不同，本章有大量悬空的外部依赖**，其中 **App. B**（BPS 代数）与 **Vol.1 §8.7**（DBI）最关键。

---

## 4. 未解决的疑问

### Q1 ★★★ 「16 张 D 膜」vs「32 个 Chan–Paton 自由度 = 32 张 9 膜」：本章内部的计数张力
- **事实 A**（E8, p.141 逐字）：「it is natural to interpret **each Chan–Paton degree of freedom** in the fully Neumann
  theory **as a 9-brane** filling spacetime」——type I 的 CP 指标有 32 个 ⇒ **32 张 D9 膜**。
- **事实 B**（E12, p.143 逐字）：「If we `T`-dualize on `k` dimensions there are `2^k` orientifold planes but
  **still 16 D-branes**, so the charge of an orientifold plane must be **`−2^{4−k}`** times that of a D-brane」。
- **事实 C**（E13, p.144 逐字）：「a third state that contains **16 D9-branes** (and an orientifold 9-plane) that looks
  like the type I theory」。
- **事实 D**（E3, p.138 逐字）：「taking the `T`-dual on a single dimension leads to a space with **16 D8-branes**
  between two orientifold hyperplanes」。
- **原书从不说明 A 与 B/C/D 如何相容。** 文献中常见的调和方式是「一张 D 膜 + 它的镜像 = 2 个 CP 指标」，
  于是 `k ≥ 1` 时基本域里 16 张、覆盖空间里 32 张；但 **`k = 0` 时镜像与本体重合**，此时 C 说的「16 D9」
  与 A 蕴含的「32 D9」**无法用这个说法直接调和**，而原书对 `k = 0` 恰恰只给 C。
- **本轮已复算确认 B 在 §13.2 内部自洽**（`2^k × (−2^{4−k}) + 16 = 0`），所以这不是算术错误，是**记数单位未声明**。
- **裁决状态：未裁决。** 处理规则：
  1. 图里凡引用本章的 D9/O9 相消，**一律写 16 与 `−2^{4−k}`**（`k = 0` 时 `−16`），并在 note 里逐字附上 A 与 C 两句。
  2. **严禁**写「Polchinski Vol.2 §13.2/§13.3 给出 `SO(32)` = 32 张 D9 膜」。
  3. 若确需「32 张 D9」这一现代表述，须另找来源（首选 **Polchinski, *TASI Lectures on D-branes*, hep-th/9611050**，
     本项目尚未登记；其次 Johnson, *D-Branes*）。**在取到之前该表述在本项目里是 L0。**

### Q2 「superconformal anomaly」仍未找到（`-sec10-8.md#Q2` 在本章**未**兑现）
- §10.6 p.31 承诺「We will see **in section 10.8** that … there is a one-loop divergence **and superconformal anomaly**」，
  而 §10.8 全节无 "anomaly"；**本章（曾被列为候选去处之一）同样全章无 "anomaly"**（§3.2 第 3 条）。
- ⇒ 三个候选去处里已排除两个（§10.8、ch.13）。**剩余候选：ch.9（Fischler–Susskind / dilaton tadpole 的语言）。**
- **`-sec10-8.md#Q2` 维持未裁决；本轮把它收窄为「若存在，只可能在 ch.9」。**
  ⚠ 在裁决前仍不得写「Polchinski 证明了非 `SO(32)` 理论有超共形反常」。

### Q3 (13.3.1) 的前缀：`α'` 幂次已定死为 1，但 `π` 幂次差一次
- **已定的部分（高置信）**：纯 `α'` 幂次记账给出 `x = 1`，即前缀应为 `8π(8π²α')⁵`。
  这**独立于**数值常数 `4×16` 与 `G_d` 的约定，只用「`y` 与 `α'` 是独立符号」。
  ⇒ **跨章佐证 `-sec10-8.md#Q1`**：`α'²` 是系统性假象/排印错误。
- **未定的部分**：把 `G_d(y) = 2^{−2}π^{−d/2}Γ(½d−1)y^{2−d}`（本页读数，且与标准结果
  `Γ(d/2−1)/(4π^{d/2})|y|^{2−d}` 一致）代入后，算得 `2^{4n−11}π^{4n−12}α'^{2n−6}`，
  而右端 `iV_{p+1}2π(4π²α')^{3−p}G_{9−p}(y)` 要求 `2^{4n−11}π^{4n−11}α'^{2n−6}`（`n ≡ (9−p)/2`）。
  **`2` 与 `α'` 逐位吻合，`π` 差一次方。**
  右端本身已被 (13.3.3)+(13.3.4) 独立背书（`2iκ²τ_p² = 2iπ(4π²α')^{3−p}`，见 §0.3a），故右端可信。
- **候选解释**：(a) 前缀分母是 `8(8π²α')⁵` 而非 `8π(8π²α')⁵`（少一个 `π` 即完全吻合）；
  (b) 分子 `4 × 16` 读错；(c) `(8π²α't)^{(9−p)/2}` 的某个指数读错。
- **处理**：**(13.3.1) 的完整前缀不进任何节点**；`𝒜_R–R = −𝒜_NS–NS`（(13.3.2)）与「总力为零」的**结论**不受影响（公因子）。
  须由人复核印刷页 146 一次。
- **副产品（应回填到别处）**：本页的 `G_d` 与 `polchinski-1998-v1.md` **E156** 记的 Vol.1 (8.7.18) 形式
  `(π^{(2−d)/2}/4)Γ((d−2)/2)|y|^{2−d}` **差一个 `π` 幂**；本章形式与标准结果一致
  ⇒ **建议以本章为准，并复核 E156 那条（它是经 [S] 二手源记的）。**

### Q4 `-sec10-8.md#Q6`（`n = 0` 的不一致）在本章只得到图像，没得到论证
- 本章提供的是**空间时间图像**（E12）：R–R 场线从每张 D 膜出发「must end somewhere」，O 面是汇。
  `n = 0` 时没有 D 膜，而 O 面荷仍为 `−16` ⇒ 场线无源可配，场方程不一致。
- **但原书没有写出这一步**，只在 E11 里说「for groups other than `SO(32)`」。
- ⇒ **`-sec10-8.md#Q6` 的裁决维持：若要建「纯闭弦无取向 type I 不一致」的节点，仍须标 `inferred: true`。**
  本章可以作为**第二条 source**（提供机制图像），但不能把 `inferred` 撤掉。

### Q5 本章与 §10.8 的依赖方向
- 三处引用（E8 带节号 + 式号、E11 不带、E18「We deduced from the cancellation of divergences」）**方向一致**：
  **§10.8 → ch.13**。本章把 §10.8 的结果翻译成 D 膜/O 面语言，**不提供独立推导**。
- 唯一一条可能的独立路线（D 膜–O 面之间力的直接计算）**被明确推给读者**（E18）。
- ⇒ **图里 `branes.o9-d9-charge-cancellation-so32` 必须 `depends_on` `spectrum.type-i-tadpole-cancellation-so32`，
  而不是反过来，也不能并列成两条独立推导。** 这条判断有三处逐字支持，**不需要标 `inferred`**。
- **未决的小问题**：(13.3.1) 明写是 (10.8.4) 的修改版 ⇒ **`branes.bps-no-force` 也间接依赖 §10.8 的圆柱振幅**。
  该边是否要显式建，交 curator 判断。

### Q6 `μ_p` 与 `τ_p` 在 DBI 作用量里的混用
- (13.3.14) 的整体系数是 **`μ_p`**；Vol.1 (8.7.2)/(8.7.12) 用的是 **`τ_p`**（`polchinski-1998-v1.md` E154/E156）。
- 由 (13.3.7) `μ_p = e^{Φ_0}τ_p`，而 (13.3.14) 里又显含 `e^{−Φ}` ⇒ 两种写法只在 `Φ = Φ_0` 处等价。
- **原书不解释这个切换。** 转卡时必须写死用的是哪一个，且把 (13.3.7) 一并挂上。

### Q7 「D 膜张力的 `T` 对偶递推」在两卷之间的归一化差异
- 本章 (13.3.4) 之后逐字：「This satisfies **the same `T`-duality relation as in the bosonic string**」，但**不写出那个关系**。
- Vol.1 §8.7 的递推是 `τ_p = τ_{p−1}/(4π²α')^{1/2}`（`polchinski-1998-v1.md` E156，二手源）。
  本章 (13.3.23) 给 `τ_p/τ_{p−1} = 1/(2πα'^{1/2})`。⚠ **`(4π²α')^{1/2} = 2πα'^{1/2}`，两者其实相同** ✅
  ——本轮已验，**不是矛盾**，记在这里以免后人重复怀疑。
- 另 E21 里 R–R 荷的递推是 `μ_p = μ_{p−1}/2πα'^{1/2}`（同一形式），且原文自陈「We are not keeping track of the
  normalization but one could」。

### Q8 (13.4.23) 之后那条「超对称未破缺但势不为零」的例外
- 原文逐字（E25）：「**This is an exception to the usual rule that the vacuum loop amplitudes vanish by Bose–Fermi
  cancellation.**」原书只给现象（16 个相位里只覆盖 8 个），**不给机制分析**。
- 若图里要建「BPS ⇒ 无力」的一般命题，**这条例外必须写进 statement 的限定**，否则该卡是错的。

---

## 5. 对图的建议

> researcher 不写 `graph/`。以下全部是**给 curator 的建议**。
> 本轮已用 grep 确认：**`graph/` 全目录 `branes.` 零命中、`t-duality` 零命中、`d-brane-from-t-duality` 零命中**
> ⇒ **`branes` 区目前一个节点都没有，下列全部是新节点**（`schema/areas.yaml` 已有 `branes` 条目，无需改 schema）。
> 另：`graph/statements/spectrum/chan-paton-factors.yaml` 已存在，是 `branes` 区最自然的上游接口。

### 5-A 建议新建的四个首批节点

| 建议 id | kind | 来源 loc | 建议 status | 备注 |
|---|---|---|---|---|
| **`branes.d-brane-tension`** | proposition | `Vol.2 §13.3, eqs. (13.3.4) p.146, (13.3.7) p.147, (13.3.23) p.150` | `physical-argument` | 见 5-A1 |
| **`branes.rr-charge-quantization`** | proposition | `Vol.2 §13.3「Dirac quantization condition」, eqs. (13.3.11)(13.3.13), pp.148–149` | `physical-argument` | 见 5-A2 |
| **`branes.bps-no-force`** | proposition | `Vol.2 §13.3, eqs. (13.3.1)(13.3.2), p.146；BPS 性见 §13.2 eq. (13.2.5), p.140` | `physical-argument` | 见 5-A3 |
| **`branes.o9-d9-charge-cancellation-so32`** | proposition | `Vol.2 §13.2, pp.142–144（无式号）` | `physical-argument` | ★ 见 5-A4，**这条最容易写错** |

#### 5-A1 `branes.d-brane-tension`
- **statement 要点**：type II 中 D`p` 膜的张力由 `τ_p² = (π/κ²)(4π²α')^{3−p}` 给出（(13.3.4)），
  在 `g ≡ τ_{F1}/τ_{D1}`（(13.3.21)）与 `κ² = ½(2π)^7g²α'^4`（(13.3.22)）的约定下显式为
  `τ_p = 1/(g(2π)^pα'^{(p+1)/2})`（(13.3.23)）；R–R 荷 `μ_p = e^{Φ_0}τ_p`（(13.3.7)）。
- **必须写进 statement 的限定**：
  1. **`g` 的定义是本章新引入的约定 (13.3.21)**，不是别处的 `e^Φ`（原文逐字见 §1.2）；
  2. `κ`（物理测得，依赖 dilaton 背景）与 `κ₁₀`（(13.3.24)，§12.1 低能作用量里的常数）**不是同一个数**；
  3. 张力由圆柱真空振幅 (13.3.1) 与场论对照 (13.3.3) 定出，而 **(13.3.1) 用了 "≈"**。
- **status 理由**：(13.3.1) 是 (10.8.4) 的修改版（未重新推导），R–R 侧靠超对称断言而非计算；
  **正面因素**：(13.3.4)/(13.3.22)/(13.3.23)/(13.3.25) 五式已被抽取者独立复算自洽（§0.3a），可写进 note。
- **`depends_on` 建议**：`spectrum.type-i-tadpole-cancellation-so32` 对应的圆柱振幅卡（(10.8.4)）——**原文明写，不必 `inferred`**；
  Vol.1 §8.7 的玻色弦 D 膜张力卡（若已建）。

#### 5-A2 `branes.rr-charge-quantization`
- **statement 要点**：D`p` 与 D`(6−p)` 膜的 R–R 荷满足 `μ_pμ_{6−p} = πn/κ₁₀²`（(13.3.13)，Dirac 条件 (13.3.11) 的推广），
  而 (13.3.7) 给出的荷**恰好实现最小量子 `n = 1`**。
- **逐字必须带上**：「**Remarkably, the charges (13.3.7), arrived at in an entirely different way, satisfy this relation
  with the minimum quantum `n = 1`.**」
- **note 应写**：抽取者已独立复算，`n = 1` 精确成立且 `(4π²α')` 的幂次恰好抵消（§0.3b）。
- ⚠ **逻辑方向**：这是**一致性检验**，`depends_on` 应指向 `branes.d-brane-tension`（提供 `μ_p`），
  **不能**反过来把它当作 `μ_p` 的推导。

#### 5-A3 `branes.bps-no-force`
- **statement 要点**：两张平行、同号荷的静态 BPS D`p` 膜之间无力；圆柱真空振幅在长薄极限下等于闭弦交换，
  NS–NS（引力子 + dilaton，吸引）与 R–R（排斥）精确相消，`𝒜_R–R = −𝒜_NS–NS`（(13.3.2)）。
- **必须写进 statement 的限定（否则该卡是错的）**：
  1. **只对平行、同维、同号荷、静态**成立（`#ND = 0`）；
  2. **有反例**：(13.4.23) 之后原文自陈的那条例外——某些相位下「supersymmetry is unbroken **but the potential is
     nonzero**」，并被作者称为「an exception to the usual rule that the vacuum loop amplitudes vanish by Bose–Fermi
     cancellation」（Q8）；
  3. 相对运动时超对称全破、有 `v⁴` 依赖的力（(13.5.7)）。
- **`depends_on`**：`branes.d-brane-bps`（D 膜保留一半超对称，(13.2.5)/(13.2.6)，建议一并新建）、
  §10.8 的圆柱振幅卡。

#### 5-A4 ★ `branes.o9-d9-charge-cancellation-so32`（最容易写错的一条）
- **kind**：`proposition`
- **status**：**`physical-argument`，且必须低于 `spectrum.type-i-tadpole-cancellation-so32`**（它依赖后者）。
- **statement 建议（照原书写，不要照通行说法写）**：
  > 在 type I 的 `T` 对偶描述中，圆盘 tadpole 由无取向 cross-cap 相消这一事实被重新解释为：
  > orientifold 面是 R–R 荷的汇。若在 `k` 个方向上作 `T` 对偶，则有 `2^k` 张 orientifold 面而仍有 **16 张 D 膜**，
  > 故每张 orientifold 面的荷是同维 D 膜荷的 **`−2^{4−k}`** 倍。`k = 0` 的情形即：type I 是含 **16 张 D9 膜与一张
  > orientifold 9-plane** 的态。
- **`sources[].loc` 建议逐字写**：
  `"§13.2, pp.142–143（无式号）：「Thus we deduce that the orientifold planes are sinks for R–R charge. If we T-dualize
  on k dimensions there are 2^k orientifold planes but still 16 D-branes, so the charge of an orientifold plane must be
  −2^{4−k} times that of a D-brane of the same dimension.」；总结句见 §13.2「New connections between string theories」,
  p.144：「a third state that contains 16 D9-branes (and an orientifold 9-plane) that looks like the type I theory」"`
- **★★★ 必须写进 notes 的三条红线**：
  1. **本章的数字是 16，不是 32。** 「`SO(32)` = 32 张 D9 膜」这句通行说法**不在本章**，不得归给本书本章（Q1）。
  2. 同一节 p.141 另有一句「it is natural to interpret **each Chan–Paton degree of freedom** … **as a 9-brane**」，
     **蕴含 32 张**；原书从不调和这两种计数。**两句都要抄进 notes。**
  3. **依赖方向**：本卡的输入是 §10.8 的 tadpole 相消（三处逐字，其中 p.147「**We deduced from the cancellation of
     divergences that** the charge of the orientifold plane should have a factor of `−(2^{4−k})`」最明确）。
     ⇒ **`depends_on: spectrum.type-i-tadpole-cancellation-so32`，不 `inferred`。**
     **绝不能**把本卡建成 `SO(32)` 的一条独立推导。
- **抽取者的复算可写进 note**：`2^k × (−2^{4−k}) + 16 = 0`（§13.2 内部自洽）。
- **禁止建的边**：与 `consistency.type-i-hexagon-so32-iff` **不得建任何边**
  （本章全章无 "anomaly"/"hexagon"，§3.2 第 3 条；这与 `-sec10-8.md` 的既有裁决一致）。

### 5-B 建议的第二批节点（可选，按性价比排序）

| 建议 id | 来源 loc | 备注 |
|---|---|---|
| `branes.d-brane-bps-half-susy` | `§13.2, eqs. (13.2.5)(13.2.6), p.140` | ★ 是 5-A3 的上游；逐字「*it is a BPS state*」+ 「We conclude by analogy」；**脚注 1 的 Mermin–Wagner–Coleman 限定必须带上** |
| `branes.dbi-action` | `§13.3, eq. (13.3.14), p.149` | ⚠ 推导整体外包给 Vol.1 §8.7，且本项目对 §8.7 只有 [S] 二手源；`μ_p` vs `τ_p` 见 Q6 |
| `branes.chern-simons-coupling` | `§13.3, eq. (13.3.18), p.150` | 曲率修正原文明说未算 |
| `duality.type-ii-t-duality-swaps-iia-iib` | `§13.1, eqs. (13.1.1)(13.1.2), pp.136–137` | 与 `compact.*` 的 T 对偶卡接口；**目前图里 T 对偶节点为零** |
| `duality.type-i-ii-single-theory` | `§13.2, p.144` | 强度低（"everything we know points to the uniqueness"） |
| `branes.nd-counting-unbroken-susy` | `§13.4, eqs. (13.4.3)(13.4.8), pp.153–154` | `#ND` 是 4 的倍数 ⇒ 8 个超对称；`#ND = 0` ⇒ 16 个 |
| `branes.pq-string-bps-bound` | `§13.6, eq. (13.6.3), p.164` | 「relatively prime ⇒ 存在饱和态」只有 "shown by indirect means"，**status 不高于 physical-argument** |
| `branes.d8-requires-orientifold` | `§13.6 末, p.175` | 逐字「the D8-brane **cannot exist as an independent object**, but only in connection with orientifold planes」 |

### 5-C 与已有区的接口

- **`spectrum`**：`spectrum.chan-paton-factors`（已存在）→ 5-A4 的「CP 自由度 ↔ 9 膜」那句（E8）；
  `spectrum.type-i-tadpole-cancellation-so32`（**待建**，`-sec10-8.md` §5-A1）→ 5-A4 的 `depends_on`。
- **`consistency`**：`consistency.type-i-hexagon-so32-iff` —— **不建边**（见 5-A4 红线 3）。
- **`compact`**：T 对偶系列（`polchinski-1998-v1.md` E132/E133/E151/E155）→ `branes.*` 的上游。
  **`polchinski-1998-v1.md` E151（(8.6.15)，T 对偶把 Neumann 换成 Dirichlet）是 `branes` 区的真正入口**，
  本章 E3 明写「by the same arguments as for the bosonic string in chapter 8」⇒ **这条边有原文背书，不必 `inferred`。**
- **`duality`**：`duality.ads-cft--via-decoupling-limit`（已存在，grep 命中 "D-brane"）——
  ⚠ **该推导若引用了 D3 膜，其上游现在可以指向 `branes.d-brane-tension` / `branes.bps-no-force`**，建议 curator 复核一次。
- **`math` / `formal`**：本章**没有**可直接形式化的干净岛（全部是物理论证）。
  唯一的例外候选是 **(13.6.24) 的生成函数计数**与 **(13.3.34) 的 `det^{1/2}(1+M) = exp[½tr(…)]` 恒等式**——
  后者是纯线性代数恒等式，可作为极小的 Lean 练习，但对图的价值低。

---

## 6. E19 复核：(13.3.12) 的系数（researcher，2026-09-11；只加不改上面的旧行）

> 触发：**reviewer-branes** 按量纲与 (13.3.13) 判定 §2 E19（本文件第 417 行）抄的
> `∫_{S_{p+2}}F_{p+2} = μ_{6−p}/2κ₁₀²` 应为 `2κ₁₀² μ_{6−p}`。
> 本节用 **Cambridge Core ch.13 单章 PDF 原书页图**（印刷 p.148 = PDF p.13）+ **一条独立的一手来源**核对。

### 6.1 ★★ 结论（三句话）

1. **原书印的就是 `μ_{6−p}/2κ₁₀²`。** E19 的转录**没有抄错**（L1 页图，见 6.2）。
2. **但 reviewer-branes 在物理上是对的**：`2κ₁₀² μ_{6−p}` 才与同页的 (13.3.11) + 次页的 (13.3.13) 自洽（见 6.3），
   且被 **Polchinski 本人 1995 年的原始论文独立证实**（见 6.4）。
3. ⇒ **这是原书的一处排印错误**（与 `polchinski-1998-v1.md` 记过的 ch.6 (6.6.21) `4α'` 应为 `¼α'` 同型：
   **分数线两侧被倒置**）。**注意 Core 版已是 2005「with corrections」本，说明官方勘误表也没收这一条。**

### 6.2 原书 p.148 逐字（L1 页图，`Read(pages=13)`；页脚 `Cambridge Books Online © Cambridge University Press, 2010`，DOI 后缀 `.007`）

> "A `p`-brane and `(6−p)`-brane are sources for `F_{p+2}` and `F_{8−p}` respectively. These two field strengths are
> Poincaré dual to one another, so again there is a Dirac quantization condition that must be satisfied by the
> product of their charges. Let us think about `F_{p+2}` as the field strength, so that the `p`-brane is an electric
> source and the `(6−p)`-brane a magnetic source. In nine dimensions a `(6−p)`-dimensional object is surrounded
> by a `(p+2)`-sphere, so by analogy to the magnetic flux (13.3.8),"
>
> `∫_{S_{p+2}} F_{p+2} = μ_{6−p}/2κ²_{10}` .  **(13.3.12)**

同页上文的两条锚（同一页图，L1）：**(13.3.8)** `∫_{S_2} F_2 = μ_m`（**右端裸的 `μ_m`，没有 `κ`**）；
**(13.3.11)** `μ_e μ_m = 2πn` "for some integer `n`"。
次页 p.149（PDF p.14，L1）：**(13.3.13)** `μ_p μ_{6−p} = πn/κ²_{10}`，紧接逐字
「Remarkably, the charges (13.3.7), arrived at in an entirely different way, satisfy this relation with the minimum quantum `n = 1`.」
前页 p.147（PDF p.12，L1）：**(13.3.6)** 场论振幅 `−2κ²_{10} i μ_p² G_{9−p}(y)`，其上一句逐字
「the propagator for any given component … is `2κ²_{10} i/k²`」；**(13.3.7)** `μ_p² = (π/κ²_{10})(4π²α')^{3−p} = e^{2Φ_0}τ_p² = T_p²`。

### 6.3 内部不自洽的复算（抽取者做的，两步算术）

把 (13.3.12) 当作 (13.3.11) 里的 `μ_m`、把 `μ_p` 当作 `μ_e`（这正是原文那一段的逻辑）：

- **按印出来的 `μ_{6−p}/2κ₁₀²`**：`μ_p · μ_{6−p}/(2κ₁₀²) = 2πn` ⇒ `μ_p μ_{6−p} = 4π κ₁₀² n`。
  **与 (13.3.13) 的 `πn/κ₁₀²` 相差 `4κ₁₀⁴`** ✗
- **按 `2κ₁₀² μ_{6−p}`**：`μ_p · 2κ₁₀² μ_{6−p} = 2πn` ⇒ `μ_p μ_{6−p} = πn/κ₁₀²` **= (13.3.13) 逐字相同** ✓

**独立旁证（同样是抽取者的算术）**：由 (13.3.7)，
`μ_p μ_{6−p} = √[(π/κ₁₀²)(4π²α')^{3−p}] · √[(π/κ₁₀²)(4π²α')^{3−(6−p)}] = (π/κ₁₀²)(4π²α')^{0} = π/κ₁₀²`
⇒ **(13.3.13) 在 `n = 1` 处精确成立**（这与 §0.3(b) 的旧复算一致），即 **(13.3.13) 是可信的一端**，
所以不自洽的那一端只能是 (13.3.12)。

### 6.4 ★★ 独立的一手来源：Polchinski, hep-th/9510017（PRL **75** (1995) 4724）p.5（L1 页图）

> `S = (α_p/2) ∫ F*_{p+2}F_{p+2} + iμ_p ∫_branes A_{p+1}` .  **(12)**
> "For later convenience we have not chosen a normalization for `A_{p+1}`, so two constants `α_p` and `μ_p` appear."
> `μ_p²/α_p = 2π(4π²α')^{3−p}` .  **(13)**
> "… Integrate the field strength `*F_{p+2}` on an `(8−p)`-sphere surrounding a `p`-brane;
> **from the action (12) one finds total flux `Φ = μ_p/α_p`.**"
> `Φ = ∫_{S_{8−p}} *F_{p+2} = ∫_{S_{7−p}} A_{7−p}` .  **(14)**
> "In order that the Dirac string be invisible to a `(6−p)`-brane, we need `μ_{6−p}Φ = 2πn` for integer `n`. That is,
> the Dirac quantization condition is"
> `μ_p μ_{6−p}/α_p = 2πn` .  **(15)**
> "The charges (13) of the D-branes satisfy this with minimum quantum `n = 1`."
> 脚注 7 逐字：「It follows from `F_{p+2} = *F_{8−p}` that `α_p = α_{6−p}`.」

**桥接（抽取者做的换算，两条独立校验都通过）**：书里的归一化对应 `α_p = 1/(2κ₁₀²)`。
- 校验 A：代入 (13) ⇒ `μ_p² = 2π(4π²α')^{3−p}/(2κ₁₀²) = (π/κ₁₀²)(4π²α')^{3−p}` = **书 (13.3.7) 逐字相同** ✓
- 校验 B：代入 (15) ⇒ `2κ₁₀² μ_p μ_{6−p} = 2πn` ⇒ `μ_p μ_{6−p} = πn/κ₁₀²` = **书 (13.3.13) 逐字相同** ✓
- ⇒ 1995 年论文的 **`Φ = μ_p/α_p = 2κ₁₀² μ_p`**，即**通量 = 荷 × `2κ₁₀²`**（**乘**，不是除）。
  搬到书的记号即 `∫_{S_{p+2}}F_{p+2} = 2κ₁₀² μ_{6−p}`。

⇒ **两条独立证据（书内部的 (13.3.11)+(13.3.13)、书外的 1995 论文 (12)–(15)）方向一致。**

### 6.5 给 curator / reviewer 的处理建议（researcher 不改 `graph/`）

- **§2 E19 那一行不改**（本项目规则：抽取记录只加不改），本节即是订正记录。
- **图里若要写这条式子，写 `∫_{S_{p+2}}F_{p+2} = 2κ₁₀² μ_{6−p}`，但 `loc` 仍写 `(13.3.12), p. 148`，
  并在 `note` 里写明：「原书此处印作 `μ_{6−p}/2κ₁₀²`，与同节 (13.3.11)+(13.3.13) 不自洽；
  按 Polchinski hep-th/9510017 eqs. (12)–(15) 订正。Cambridge Core 2005 corrected 版仍印错误形式。」**
- **更稳妥的做法**：`branes.rr-charge-quantization` 这张卡**根本不引 (13.3.12)**，只引
  **(13.3.11) + (13.3.13) + (13.3.7)**——这三条都已 L1 核实且互相自洽，(13.3.12) 只是中间步骤。
- **建议把 `polchinski-1996-tasi` 之外再登记 `polchinski-1995-dbranes`（hep-th/9510017）**：
  它是 D 膜 R–R 荷的**原始出处**，11 页、arXiv 可取、本轮已读 pp.4–8，
  且它给出了书里**没有**的东西——`α_p` 这个显式的归一化常数，使量纲关系可以独立核查。
  ⚠ 读的是 **v3**（PDF 内嵌链接自陈 `hep-th/9510017v3`）。
  ⚠ 同篇 p.6 有一段作者自承的未解矛盾（逐字）：「This is twice the value found in ref. [13] …
  **We have not succeeded in reconciling these calculations**, but strongly expect that the RR charge is that
  required by string duality.」——引用本文的荷归一化时必须带上这句。
  ⚠ 同篇 p.8 的 **(20)** `i(n−32)μ_9 ∫ A_10`，紧接「Thus, the equation of motion requires the group `SO(32)`」
  ——**这是「32 张 D9」这一表述的真正早期出处**，比书 ch.13（只写 16）更接近现代说法，
  与 `-ch13.md#Q1` 直接相关；p.7 同时逐字写「exactly **16** D-branes」⇒ **两种计数在 1995 年原文里就并存**。

### 6.6 访问日志（本节）

| 目标 | URL / 手法 | 结果 |
|---|---|---|
| 书 ch.13 PDF | Core `…/67EE13E32046F0D121B589DC02989698/9780511618123c4_p136-177_CBO.pdf/d-branes.pdf` | ✅ 587.8 KB / 42 页（文件名直接推出，一次命中） |
| 印刷 p.147/148/149 | `Read(pages=12)`、`(pages=13)`、`(pages=14)` | ✅ 三页页图 |
| hep-th/9510017 | `arxiv.org/pdf/hep-th/9510017` → 落盘 136 KB / 11 页 → `Read(pages=5-9)` | ✅ pp.4–8 读到，(12)–(20) 全部到手 |

