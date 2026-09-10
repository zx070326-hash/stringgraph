# 抽取记录：sen-1995-bh

- 文献：A. Sen, *Extremal black holes and elementary string states*, arXiv:**hep-th/9504147**（报告号 TIFR-TH-95-19；标题页页脚 `April, 1995`）
- 抽取者：researcher agent
- 日期：2026-09-11
- 覆盖范围：**全文**（标题页+摘要、正文 p.2–p.12、Appendix A p.13–14、References p.14–16）
- 目标 area：`swampland`（`arkani-hamed-2006` §4 正面证据的黑洞侧）、`holography`（BPS 态 ↔ 极端黑洞对应）

---

## 0. 核实方法与证据等级（必读）

### 0.1 本轮实际读到什么

| 项 | 内容 |
|---|---|
| 获取路线 | `WebFetch https://arxiv.org/pdf/hep-th/9504147` → PDF 落盘 158.6 KB → `Read(pages=1-6)` + `Read(pages=7-12)` + `Read(pages=13-16)` **逐页读页图** |
| 拿到的版本 | 页边条纹逐字为 `arXiv:hep-th/9504147v2  6 May 1995` |
| 页数 | PDF 共 16 页；**打印页码与 PDF 页码一一对应**（标题页印 `1`），本文件「位置」栏一律给打印页码 |
| 缺失 | **无**。全文每一页都读到了 |

⚠ **标题页上印的日期是 `November 26, 2024`** —— 这是 arXiv 重新编译源码时的 `\today`，**不是论文日期**。论文日期在标题页页脚：`April, 1995`。**抽取记录里不得把 2024 当成任何东西的日期。**

### 0.2 证据等级（沿用 `vafa-2005.md` §0.2 的 L1–L4 定义）

- **L1** = 抽取者本轮**亲自逐页读到 arXiv v2 的页图**。本文件所有标 **[逐字]** 的都是真正的逐字引用。
- **L2** = 出版方权威元数据。本文件用于 §0.4 的发表状态。
- **L3** = 第三方转述。本文件正文只有一处（§4 Q3，与本项目自己的 `arkani-hamed-2006.md` 交叉核对，那份记录本身是 L1）。
- **L4** = 检索后端复述，不入库。**本文件无 L4 条目。**

### 0.3 ★★ 结论先说：**本文不是 AMNV (22)(23) 的出处**

`arkani-hamed-2006.md` E22 逐字记载：AMNV §4 的极端黑洞解 `(22) M² = ½Q_R²` 与 `(23) M² = ½Q_L²` 归给其参考文献 **[8] = A. Sen, "Black hole solutions in heterotic string theory on a torus," Nucl. Phys. B 440, 421 (1995) [hep-th/9411187]**。

**本文（hep-th/9504147）是另一篇。** 本文自己把黑洞解归给它的 **[7] = 同一篇 hep-th/9411187**（p.15 逐字：「A. Sen, 'Black hole solutions in heterotic string theory on a torus', preprint TIFR-TH-94-47 [hep-th/9411187]」）。

⇒ **两条硬约束**：
1. **图里「杂化弦 on `T⁶` 的极端黑洞解」这条陈述的 `sources` 仍必须是 `sen-1995-bh-torus`（hep-th/9411187），不是本文。** 本文提供的是**下游**的东西：Bogomol'nyi 关系 `(24)`、BPS 态谱 `(46)`、以及**「极端黑洞 = 基本弦态」这条对应陈述本身**。
2. `sources.bib` 里 **`sen-1995-bh`（本文）与 `sen-1995-bh-torus`（9411187）是两个 key，绝不可互换。** 二者同作者、同年、题目都以 "black hole" 开头，是本项目已知最易撞车的一对。

### 0.4 发表状态

**本轮未核实（L0）。** 本文只以 arXiv preprint + 报告号 `TIFR-TH-95-19` 出现；AMNV 与本项目此前的记录都不引它的刊物信息。`sources.bib` 按 `@misc` + eprint 登记。

---

## 1. 约定

### 1.1 该文自述的约定（**全部 L1，且与 AMNV 不同，必须换算**）

| 项 | 本文的取法 | 位置 | 等级 |
|---|---|---|---|
| `α'` 归一化 | **`α' = 16`** —— 逐字：「As in ref.[22], we use the normalization `α' = 16`. This corresponds to a string world-sheet action of the form」，随后 **(9)** `(1/64π)∫d²ξ G_{μν}(X)∂_αX^μ∂^αX^ν + ⋯` | §p.6，(9) | **L1** |
| Newton 常数 | **`G_N = 2`**（不是 1！） | §p.6，**(12)** | **L1** |
| 弦张力 | **`T = g²/(32π)`** | §p.6，**(12)** | **L1** |
| 时空维数 | **4**（`T⁶` 上环面紧化的杂化弦） | §p.4 逐字「we shall work with the four dimensional theory obtained by toroidal compactification of the heterotic string theory[21]」 | **L1** |
| 规范场数目 | `U(1)²⁸`，`1 ≤ a ≤ 28`；`L = diag(−I₂₂, I₆)`，对偶群 `O(6,22)` | §p.5，**(1)–(6)** | **L1** |
| 度规号差 | **未显式声明**；但 (13) 的 `ds²` 首项为 `−K^{-1/2}ρ dt²` ⇒ **mostly-plus `(−,+,+,+)`** | §p.6，(13) | **L1（由式子读出，非原文自述）** |
| 两套度规 | **弦度规 `G_{μν}`** 与 **典范 Einstein 度规 `g_{μν} = e^{−Φ}G_{μν}`**（**(7)**）。二者在本文里全程并用 | §p.5，**(7)** | **L1** |
| 渐近值 | **(10)** `⟨g_{μν}⟩ = η_{μν}`，`⟨e^{−Φ}⟩ = 1/g²`，`⟨M⟩ = I₂₈`，`⟨B_{μν}⟩ = 0`，`⟨A_μ^{(a)}⟩ = 0`；由此 **(11)** `⟨G_{μν}⟩ = g²η_{μν}` | §p.6 | **L1** |

### 1.2 ★ 与 `arkani-hamed-2006` 的归一化落差（**curator 必读**）

| | `arkani-hamed-2006` §4 | 本文 |
|---|---|---|
| `α'` | **`α' = 4`**（`arkani-hamed-2006.md` E22 备注 2） | **`α' = 16`** |
| Planck / Newton | **`M_Pl = 1`** | **`G_N = 2`** |
| 极端黑洞质量式 | **(22)** `M² = ½Q_R²`、**(23)** `M² = ½Q_L²` | **(24)** `m² = (1/8g²)Q̄_R²` |
| 弦谱 | **(24)**（AMNV 编号）`M² = ½Q_L² + N_L − 1` 型 | **(46)** `m² = Q̄_R²/(8g²) = (g²/8)(Q̄_L²/g⁴ + 2N_L − 2)` |

**两套式子结构同型、系数不同，因为 `α'` 与 `G_N` 的取法不同。**
⇒ **图里若把本文与 AMNV §4 挂到同一条推导上，必须先建一条显式的归一化换算卡，或者把两者放进各自的约定域，标 `inferred: true`。本文没有给出到 `M_Pl = 1, α' = 4` 的换算。**

### 1.3 与 `graph/conventions/` 的对照

| 图里的约定 | 是否适用 | 说明 |
|---|---|---|
| `conv.metric-mostly-plus` | **适用**（由 (13) 读出，原文未自述） | 标 `inferred: true` |
| `conv.alpha-prime-regge` | **需核对** | 本文写死 `α' = 16`，是**四种常见取法里最不常见的一种**；图里若已有 `α'` 约定卡，本文必须单列一条换算 |
| （无）`G_N` 归一化约定 | **缺失** | `G_N = 2` 这个取值会污染一切「`m ≤ qM_Pl`」型比较。**建卡时必须显式写出。** |

---

## 2. 陈述

编号 `E<n>`。转成节点时在节点 `notes` 写 `from: sen-1995-bh#E<n>`。

### E1 摘要：极端黑洞与 BPS 基本弦态的对应（本文的主命题）

- 位置：**摘要**，标题页 — **L1**
- 类型：proposition（探索性命题）
- 原文陈述 **[逐字，全文]**：
  > "Some of the extremal black hole solutions in string theory have the same quantum numbers as the Bogomol'nyi saturated elementary string states. We explore the possibility that these black holes can be identified to elementary string excitations. It is shown that stringy effects could correct the Bekenstein-Hawking formula for the black hole entropy in such a way that it correctly reproduces the logarithm of the density of elementary string states. In particular, this entropy has the correct dependence on three independent parameters, the mass and the left-handed charge of the black hole, and the string coupling constant."
- 文献自称的严格程度：**"We explore the possibility"**（主命题）+ **"It is shown that stringy effects **could** correct"**（结果）。
  ⇒ **注意 "could"。摘要里最强的动词是 "It is shown"，但它的宾语是一个情态句。** 图 status 上限 `physical-argument`，**不得**写成「Sen 证明了极端黑洞是基本弦态」。
- 文献列出的依赖：无（摘要里不给）。
- 备注：**三个参数**（质量、左手荷、弦耦合）这一点是本文自称的核心卖点，比「熵匹配」本身强，因为它是三参数族的匹配而非单点匹配。

---

### E2 问题设定：黑洞与基本弦态该不该分开计数

- 位置：**§p.2**（正文第 2 段）— **L1**
- 类型：definition（问题陈述）
- 原文陈述 **[逐字]**：
  > "Treating black holes as elementary particles poses a puzzle. In string theory there is an infinite tower of massive states which have the same quantum numbers as classical electrically charged black hole solutions. The question that arises naturally is, should we count the black holes and elementary string states as separate elementary particles? Or do they correspond to different ways of representing the same states? The second alternative certainly looks much more attractive. But to further substantiate this claim, one must show that the black holes have the same properties as elementary string states besides carrying the same quantum numbers."
- 文献自称的严格程度：**"certainly looks much more attractive"** —— 纯直觉论证。
- 文献列出的依赖：无。
- 备注：**这一段是「黑洞态数目有限/极端黑洞可衰变」这一族沼泽地论证的历史前身之一**，但**本文没有说任何关于 `m ≤ qM_Pl` 的话，也没有弱引力猜想的任何形式。** ⇒ 见 §4 Q1 的红线。

---

### E3 熵的定性矛盾：弦态 `ln d ∝ M` vs 黑洞 `S ∝ M²`

- 位置：**§p.2**（正文第 4 段）— **L1**
- 类型：proposition
- 原文陈述 **[逐字，节录]**：
  > "For elementary string states, the logarithm of the degeneracy of states increases linearly with mass, whereas the Bekenstein-Hawking entropy of the black hole increases as the square of the mass."
- 文献自称的严格程度：陈述式，不给推导（是已知事实的复述）。
- 文献列出的依赖：无编号引用。
- 备注：这是本文要解决的困难；**本文的解法是对 BPS 态取极端极限，此时视界面积为零**（见 E4）。

---

### E4 ★ 关键结构性事实：所论极端黑洞的**视界面积为零**

- 位置：**§p.3**（正文第 2 段）— **L1**
- 类型：proposition
- 原文陈述 **[逐字，节录]**：
  > "While the logarithm of the degeneracy of Bogomol'nyi saturated elementary string states continues to grow linearly with mass (although with a different proportionality factor), the area of the event horizon of an extremal black hole of the kind we are discussing actually vanishes. This is fortunate, since if it had not vanished, it would have almost certainly been proportional to the square of the black hole mass, leading to a contradiction, since now we can no longer appeal to a mass renormalization. But now we have the opposite problem. The degeneracy associated with extremal black hole states seems to be smaller than the degeneracy of the elementary string states with the same quantum numbers."
- 文献自称的严格程度：陈述 + 「seems to be」。
- 文献列出的依赖：脚注 1 引 [17]、[18]。
- 备注：⚠ **这一条是本文全部结论的前提，也是它的最大脆弱点**：因为标准 Bekenstein–Hawking 熵为零，本文必须**改用「拉伸视界（stretched horizon）」的面积**（E5），而拉伸视界的位置是本文自己**假设**出来的。

---

### E5 拉伸视界：本文的核心假设（原文自称 "postulate"）

- 位置：**§p.3**（正文第 3 段）— **L1**
- 类型：axiom（本文自设的假设）
- 原文陈述 **[逐字，节录]**：
  > "To resolve this puzzle, we could postulate that the entropy of the extremal black hole is not exactly equal to the area of the event horizon, but the area of a surface close to the event horizon, which we shall call the 'stretched horizon'. This assumption is not totally unreasonable, since for various reasons we expect that our standard understanding of the physics of the black hole has to be modified very close to the horizon / singularity; and the stretched horizon represents a surface beyond which our standard understanding breaks down."
- 文献自称的严格程度：**"we could postulate"** + **"This assumption is not totally unreasonable"** —— **这是本文最弱的一环，且作者自己标明是假设。**
- 文献列出的依赖：后文引 [4]、[19]（Susskind 的 stretched horizon 定义）。
- 备注：**图里若给本文建节点，这条必须单独建成 `axiom` / `assumption` 并被所有下游节点 `depends_on`。** 否则会把一个自设假设的结论记成 `physical-argument` 之外的东西。

---

### E6 三种拉伸视界定义，本文取第一种（世界面强耦合）

- 位置：**§p.3–p.4** — **L1**
- 类型：definition
- 原文陈述 **[逐字，节录三处]**：
  > （定义一）"If we believe that the necessary modification of the physics near the horizon comes from the string world-sheet effects, then we should define the stretched horizon to be the surface where the string world sheet theory becomes strongly coupled. In other words, this is the surface where the space-time curvature associated with the string metric, and/or other target space field strengths, becomes large. We shall see that this definition determines the location of the stretched horizon uniquely up to a purely numerical factor."
  >
  > （定义二，被排除）"We might also try to define the stretched horizon to be the place where the string coupling constant becomes large. However, for black holes of the type we shall discuss, this does not happen. In fact, the string coupling vanishes as we approach the event horizon."
  >
  > （定义三）"The third possibility makes use of black hole thermodynamics, and is in fact the original definition of stretched horizon given in ref.[4, 19]. According to this definition, the stretched horizon is defined to be the surface where the local Unruh temperature for an observer, who is stationary in the Schwarzschild coordinate, is of the order of the Hagedorn temperature of the string theory."
- 文献自称的严格程度：定义性；**「定义一与定义三重合」这一点由 Appendix A 论证**（E13）。
- 文献列出的依赖：[4]、[19]、[20]。
- 备注：⚠ **"uniquely up to a purely numerical factor"** —— 那个数值因子就是 **(34) 的 `C`**，最后由**与弦态计数匹配**反推出 `C = 4`（E12）。**这是一次拟合，不是独立预言。见 Q2。**

---

### E7 四维有效作用量与 `O(6,22)` 对偶

- 位置：**§p.4–p.5**，公式 **(1)–(8)** — **L1**
- 类型：definition
- 原文陈述（公式逐字转录，弦标架 (1)）：
  > `S = (1/32π) ∫ d⁴x √(−G) e^{−Φ} [ R_G + G^{μν}∂_μΦ∂_νΦ − (1/12)G^{μμ'}G^{νν'}G^{ρρ'}H_{μνρ}H_{μ'ν'ρ'}`
  > `  − G^{μμ'}G^{νν'}F^{(a)}_{μν}(LML)_{ab}F^{(b)}_{μ'ν'} + (1/8)G^{μν}Tr(∂_μML∂_νML) ]`   **(1)**
  >
  > `F^{(a)}_{μν} = ∂_μA^{(a)}_ν − ∂_νA^{(a)}_μ`,
  > `H_{μνρ} = (∂_μB_{νρ} + 2A^{(a)}_μ L_{ab}F^{(b)}_{νρ}) + cyclic permutations of μ, ν, ρ`   **(2)**
  >
  > `MLM^T = L`, `M^T = M`   **(3)**;  `L = diag(−I₂₂, I₆)`   **(4)**
  >
  > `M → ΩMΩ^T`, `A^{(a)}_μ → Ω_{ab}A^{(b)}_μ`, `G_{μν} → G_{μν}`, `Φ → Φ`, `B_{μν} → B_{μν}`   **(5)**，其中 `ΩLΩ^T = L`   **(6)**
  >
  > `g_{μν} = e^{−Φ}G_{μν}`   **(7)**；Einstein 标架作用量 **(8)**
- 文献自称的严格程度：给定（引 [21] Narain 的紧化）。
- 文献列出的依赖：**[21] = K. Narain, Phys. Lett. B169 (1986) 41; K. Narain, H. Sarmadi and E. Witten, Nucl. Phys. B279 (1987) 369.**（p.16 逐字）
- 备注：★ **(5)–(6) 后面紧跟一句 [逐字]：「This remains a valid symmetry of the action even after we include the higher derivative terms in the action originating from the higher order corrections in the string world-sheet theory. This fact will be useful to us later.」** —— 这一句是 §p.9 那个「用 `O(6,22)` 转动把 `α` 依赖转掉」的论证的全部合法性依据（E10），**但原文对这句话本身不给论证也不给引用**。见 Q4。

---

### E8 极端黑洞解与电荷

- 位置：**§p.6–p.7**，公式 **(13)–(23)** — **L1**
- 类型：proposition（引用的解）
- 原文陈述（逐字转录，关键式）：
  > `ds² ≡ g_{μν}dx^μdx^ν = −K^{−1/2}ρ dt² + K^{1/2}ρ^{−1}dρ² + K^{1/2}ρ(dθ² + sin²θ dφ²)`   **(13)**
  > `B_{μν} = 0`   **(14)**;  `e^Φ = K^{−1/2}ρ g²`   **(15)**
  > `K = (ρ² + 2m₀ρ cosh α + m₀²)`   **(18)**
  > 电荷定义：`F^{(a)}_{ρt} ≃ Q^{(a)}_{el}/ρ²  for large ρ`   **(20)**
  > `m = (1/G_N)(m₀/2)cosh α = (1/4)m₀ cosh α`   **(22)**
  > `Q^{(a)}_R = 0` (1≤a≤22), `= g p^{(a−22)}/√2 · m₀ cosh α` (23≤a≤28);
  > `Q^{(a)}_L = g n^{(a)}/√2 · m₀ sinh α` (1≤a≤22), `= 0` (23≤a≤28)   **(23)**
- 文献自称的严格程度：**"Most general electrically charged rotating black hole solutions in this theory were constructed in ref.[7]."**（p.6 逐字）+ 脚注 4 [逐字]「Ref.[7] constructed the solution for `g = 1`. The solution for a general `g` can easily be obtained from there by appropriate rescaling of `e^{−Φ}` and `A^{(a)}_μ`.」
- 文献列出的依赖：**[7] = hep-th/9411187**（= `sen-1995-bh-torus`）；另 "(See also [23, 24].)"。
- 备注：★ **本文自己也只是引用这个解，并做了一次 `g` 的重标度。⇒ 「杂化弦 `T⁶` 极端黑洞解」这条陈述的一手来源仍是 `sen-1995-bh-torus`，本文只是二手 + 一步重标度。**
  ⚠ **视界与奇点重合**：p.7 逐字「The horizon and the singularity of this black hole coincide, both being situated at `ρ = 0`.」 —— 这正是 E4 说「面积为零」的原因。

---

### E9 ★★ Bogomol'nyi 关系（本文的黑洞侧核心式）

- 位置：**§p.8**，公式 **(24)** — **L1**
- 类型：proposition
- 原文陈述 **[逐字]**：
  > "From eqs.(22) and (23) we get,
  >
  > `m² = (1/8g²) Q̄_R²`   **(24)**
  >
  > which is the standard Bogomol'nyi relation between mass and charge."
  >
  > 紧接 **(25)**：`m₀ = 4√(m² − Q̄_L²/(8g²))`，`α = tanh^{−1}(Q_L/(2√2 g m))`
- 文献自称的严格程度：**"we get"** —— 是从 (22)(23) 直接代数得到的，**可机械复核**。
- 文献列出的依赖：本文 (22)、(23)。
- 备注（**这是本条最重要的部分**）：
  1. **[抽取者复算]** 由 (22) `m = ¼m₀cosh α`、(23) `Q̄_R² = (g²/2)m₀²cosh²α`（因 `p⃗` 是 6 维单位向量，`Σ(p^{(a−22)})² = 1`）得 `Q̄_R²/(8g²) = m₀²cosh²α/16 = m²` ✓。**(24) 自洽。**（原文未显式写出这一步，curator 引用须标 `inferred: true`。）
  2. **与 AMNV (22) `M² = ½Q_R²` 的关系**：形式相同，系数 `1/(8g²)` vs `1/2` —— **差别全部来自 `α'` 与 `G_N` 的取法（见 §1.2）**。**不得把两式当成同一个式子引用。**
  3. **独立参数**：p.8 逐字「The independent parameters characterizing the black hole may be taken to be `m`, `Q_L ≡ |Q̄_L|`, `n⃗` and `p⃗`.」

---

### E10 用 `O(6,22)` 转动消去 `α` 依赖 ⇒ 拉伸视界位置无歧义

- 位置：**§p.9**，公式 **(32)–(35)** — **L1**
- 类型：proposition
- 原文陈述 **[逐字，节录]**：
  > "Since (5) represents a symmetry of the full effective action at the string tree level, effects of world sheet quantum corrections, which show up as higher derivative terms in the effective action, could be studied as well in the transformed background represented by the primed fields. Since the background fields now do not depend on any parameter, we see that the place where the target space field strengths become strong is situated unambiguously at `ρ̄ ∼ 1`. This determines the location of the stretched horizon to be at
  >
  > `ρ̄ = C`   **(34)**
  >
  > where `C` is a pure number. This gives,
  >
  > `ρ = C/g ≡ η`   **(35)**"
- 文献自称的严格程度：**"we see that"** —— 定性论证。
- 文献列出的依赖：本文 (5)（`O(6,22)` 不变性）+ E7 备注里那句「higher derivative terms 也不变」。
- 备注：⚠ **整条论证的强度不超过 E7 备注里那句无引用的断言。见 Q4。**

---

### E11 拉伸视界熵公式

- 位置：**§p.9**，公式 **(36)(37)** — **L1**
- 类型：proposition
- 原文陈述 **[逐字]**：
  > "The area of the stretched horizon, calculated using the canonical metric (13) is given by,
  >
  > `A ≃ 4πηm₀ = 4πm₀C/g`   **(36)**
  >
  > Following the Bekenstein-Hawking result, we define the entropy of the black hole to be
  >
  > `S_{B.H.} ≡ A/(4G_N) = (π/2)(m₀C/g) = (2πC/g)√(m² − Q̄_L²/(8g²))`   **(37)**"
- 文献自称的严格程度：**"we define"** —— **这是定义，不是导出。**
- 文献列出的依赖：(13)、(25)、(35)、以及 `G_N = 2`（(12)）。
- 备注：**[抽取者复算]** `A/(4G_N) = 4πm₀C/(g·8) = πm₀C/(2g)` ✓（用 `G_N = 2`）。**若误用 `G_N = 1`，(37) 的系数会差 2 倍。** 这就是 §1.2 说「`G_N = 2` 会污染一切比较」的具体含义。

---

### E12 ★★ 弦侧计数与 `C = 4` 的标定（本文的落点）

- 位置：**§p.12**，公式 **(46)–(49)** — **L1**
- 类型：proposition
- 原文陈述 **[逐字，整段]**：
  > "In the normalization convention we are using, the mass formula for the Bogomol'nyi saturated elementary string states is given by,
  >
  > `m² = Q̄_R²/(8g²) = (g²/8)(Q̄_L²/g⁴ + 2N_L − 2)`   **(46)**
  >
  > where `N_L` is the total oscillator contribution to the squared mass from the left moving oscillators. There is no contribution to the mass from the right moving oscillators, since in order to saturate the Bogomol'nyi bound, the string state must be at the lowest level in the right moving sector of the world-sheet. The degeneracy of such states arises due to the many different ways the left moving oscillators make up the total number `N_L`. This degeneracy has been calculated many times (for a recent calculation, see [5]) and is given by,
  >
  > `d_{E.S.} ≃ exp(4π√N_L)`   **(47)**
  >
  > Thus, the entropy, calculated from the elementary string spectrum, is given by,
  >
  > `S_{E.S.} ≡ ln d_{E.S.} ≃ 4π√N_L ≃ (8π/g)√(m² − Q̄_L²/(8g²))`   **(48)**
  >
  > This has the same dependence on `g`, `m` and `Q̄_L` as `S_{B.H.}` given in eq.(37). The overall constant of proportionality in the two expressions agree if we make the choice
  >
  > `C = 4`   **(49)**
  >
  > This shows that the modified Bekenstein-Hawking entropy of the black hole does reproduce the density of elementary string states correctly."
- 文献自称的严格程度：**"agree if we make the choice"** —— **`C` 是被拟合出来的，不是独立算出来的。** 最后一句 "does reproduce ... correctly" 只在 `C = 4` 这个选择之下成立。
- 文献列出的依赖：**[5] = J. Russo and L. Susskind, 'Asymptotic level density in heterotic string theory and rotating black holes', preprint UTTG-9-94 [hep-th/9405117]**（p.14 逐字）。
- 备注（**四点，全部对图有约束**）：
  1. **[抽取者复算]** 由 (46)：`2N_L − 2 = 8m²/g² − Q̄_L²/g⁴`，故 `N_L = 1 + 4m²/g² − Q̄_L²/(2g⁴)`。当 `m² ≫ g²` 时 `√N_L ≃ (2/g)√(m² − Q̄_L²/(8g²))`，代入 (48) 得 `8π/g·√(…)` ✓。**(48) 自洽（在大质量渐近下）。**（原文未写出这一步，curator 引用须标 `inferred: true`。）
  2. **匹配是三参数（`g`, `m`, `Q̄_L`）的函数形式匹配 + 一个常数的拟合**，这正是摘要里说的「correct dependence on three independent parameters」。**图里不得写成「无自由参数的匹配」。**
  3. **(46) 与 `arkani-hamed-2006` (24) 是同一族公式的不同归一化写法**（AMNV 那边是 `M² = ½Q_L² + N_L − 1` 型）。**这是本文与 AMNV §4 之间唯一真正的内容接口**，但**需要换算**，且**原文两边都没给换算**。
  4. ⚠ **`N_L` 的取值范围本文没有讨论**：(46) 允许 `N_L = 0`（即 `Q̄_L² = 2g⁴`），而 AMNV §4 的整个论证正是取 `N_L = 0` 那个态。**本文没有讨论 `N_L = 0` 的态，也没有做任何「亚极端 / 超极端」的比较。** 见 Q1。

---

### E13 Appendix A：拉伸视界处 Unruh 温度 ~ Hagedorn 温度

- 位置：**Appendix A，p.13–14**，公式 **(A.1)–(A.6)** — **L1**
- 类型：proposition
- 原文陈述 **[逐字，节录]**：
  > "In this appendix we shall show that at the location of the stretched horizon defined in eq.(35), the local Unruh temperature does become of the order of the Hagedorn temperature of string theory."
  >
  > `t = iτ`, `ρ = r²`   **(A.1)**；`ds²_E ≃ 4m₀(dr² + (r²/4m₀²)dτ²) + m₀r²(dθ² + sin²θ dφ²)`   **(A.2)**；`τ ≡ τ + 4πm₀`   **(A.3)**
  > `β_{Unruh}(η) ≃ 4π√(m₀η) = 4π√(m₀C/g)`   **(A.4)**
  > `e^{Φ(η)} ≃ g²η/m₀ = Cg/m₀`   **(A.5)**
  > `β_{Hagedorn}(η) = 4π(2+√2)e^{−Φ(η)/2} = 4π(2+√2)√(m₀/(Cg))`   **(A.6)**
  >
  > "Since `C ∼ 1` we see that at the stretched horizon, the local Unruh temperature is indeed of the same order as the local Hagedorn temperature."
- 文献自称的严格程度：**"of the same order"** —— 量级论证。
- 文献列出的依赖：脚注 7 引 [26]（Atick–Witten）。
- 备注：⚠ **(A.4) 与 (A.6) 对 `m₀/g` 的依赖互为倒数**（`√(m₀C/g)` vs `√(m₀/(Cg))`）——**只有在 `C ∼ 1` 时两者才同量级**，而 (49) 定的是 `C = 4`。原文自己说 "Since `C ∼ 1`"，与 `C = 4` 之间有一处**未讨论的张力**。见 Q3。

---

### E14 致谢与优先权

- 位置：**§p.12 末** — **L1**
- 类型：（记录）
- 原文陈述 **[逐字]**：
  > "**Acknowledgement**: I wish to thank John Schwarz for several illuminating discussions, without which the detailed computation given here would not have been performed. Some of these results were reported at the workshop on 'Physics at the Planck Scale, Puri, India, Dec.12-21, 1994'. I would like to thank the organisers of the workshop for hospitality."
- 备注：**「1994 年 12 月已报告」** ⇒ 本文的核心结果早于 arXiv 日期（1995-04）。另注脚注 3 [逐字]：「A preliminary version of this result was stated briefly in ref.[7].」 —— **[7] 就是 hep-th/9411187**，即本文的结果在那篇里已有初步版本。**又一条不要把两篇搞混的理由。**

---

### E15 参考文献里对图有用的条目（**L1 逐字转抄**）

- 位置：**References，p.14–16** — **L1**
- 逐字转抄（节录，只抄图里可能要用的）：
  > "[7] A. Sen, 'Black hole solutions in heterotic string theory on a torus', preprint TIFR-TH-94-47 [hep-th/9411187]."
  > "[13] G. Gibbons and C. Hull, Phys. Lett. **B109** (1982) 109; J. Harvey and J. Liu, Phys. Lett. **B268** (1991) 40; R. Kallosh, A. Linde, T. Ortin, A. Peet and A. Van Proeyen, Phys. Rev. **D46** (1992) 5278 [hep-th/9205027];"
  > "[14] E. Witten and D. Olive, Phys. Lett. **B78** (1978) 97."
  > "[16] C. Vafa, as quoted in first reference in [4]."
  > "[18] G. Gibbons and S. Hawking, Phys. Rev. **D15** (1977) 2752, Comm. Math. Phys. **66** (1979) 291."
  > "[21] K. Narain, Phys. Lett. **B169** (1986) 41; K. Narain, H. Sarmadi and E. Witten, Nucl. Phys. **B279** (1987) 369."
  > "[22] A. Sen, Int. J. Mod. Phys. **A9** (1994) 3707 [hep-th/9402002] ."
  > "[26] J. Atick and E. Witten, Nucl. Phys. **B310** (1988) 291."
- 备注（三点）：
  1. **[22] 是本文全部归一化约定（`α' = 16`）的出处**（p.6 逐字「As in ref.[22], we use the normalization `α' = 16`」）。⇒ **要独立核实 `α' = 16` 这套约定，必须抽 hep-th/9402002。本文自己不推导它。**
  2. **[21] 是 Narain 紧化的一手来源**，与 `vafa-2005` E9（Narain 模空间体积有限）**指向同一批文献**。⇒ 图里 Narain 格/模空间的节点应该以 [21] 为一手来源，本项目尚未登记这两篇。
  3. **[16] 是一条不可用的引用**（「C. Vafa, as quoted in first reference in [4]」——转引的转引，无书面出处）。按 `literature/CLAUDE.md` 规则 1 不得登记。

---

## 3. 未核实项清单

| 编号 | 项 | 影响 | 处理建议 |
|---|---|---|---|
| U1 | **v1 与 v2 的差异**（本轮只读 v2） | 公式编号可能变 | **所有 `loc` 写死 `v2`** |
| U2 | **是否有期刊发表版**（L0） | 页码体系不同 | `sources.bib` 按 `@misc` + eprint 登记 |
| U3 | **[7] = hep-th/9411187 的正文**（本轮未抽） | 「(13)–(19) 的解是谁构造的」只有本文的转述 | **这是下一轮最该抽的一篇**：它同时是本文 E8 的来源与 AMNV (22)(23) 的来源 |
| U4 | **[22] = hep-th/9402002 的 `α' = 16` 约定** | 本文全部数值系数依赖它 | 若图里要用本文的系数，必须抽它，或只用无量纲组合 |
| U5 | **(47) 的 `exp(4π√N_L)`**（本文引 [5]，不推导） | `S_{E.S.}` 的系数 `4π` 全靠它 | 需另找来源；`4π` 与 `α'` 归一化绑定 |
| U6 | **`Q̄_L`、`Q̄_R` 上的横杠在纯文本转录中的一致性** | `Q_L` vs `Q̄_L` 在原文里混用（(23) 用 `Q^{(a)}_L`，(24)(25) 用 `Q̄_R`/`Q̄_L`，(25) 的 `α` 式又用 `Q_L`） | **curator 引用必须回页图复核**（PDF p.7–8） |
| U7 | **(46) 与 AMNV (24) 的显式换算** | 决定两篇能否挂到同一条推导 | **两篇原文都没给。必须由 reviewer 独立推导并标 `inferred: true`** |

---

## 4. 未解决的疑问

### Q1 — ★ 本文**没有**弱引力猜想的任何形式（红线）

**本文全文没有**：
- 任何 `m ≤ qM_Pl` / `M/Q ≤ 1` 型的不等式；
- 任何「亚极端 / 超极端」的比较；
- 「极端黑洞必须能衰变」的论证；
- 「gravity is the weakest force」或类似措辞。

**本文只做一件事：把一族极端黑洞（视界面积为零的那族）的拉伸视界熵与 BPS 弦态计数对上。**

⇒ **图里绝不得把「弱引力猜想的黑洞侧证据」挂给本文。** AMNV §4 用的是**格论论证**（`Q_L² − Q_R² = 2` 的电荷向量存在 ⇒ 存在质荷比小于极端黑洞的态），那条论证的黑洞输入是 **(22)(23)**，来自 `sen-1995-bh-torus`，**不是本文**。

### Q2 — `C` 是拟合参数，本文没有独立确定它

E6 说定义一「determines the location of the stretched horizon uniquely up to a purely numerical factor」，E12 说这个因子由**与弦态熵匹配**定出 `C = 4`。

⇒ **本文的熵匹配在「常数」这一层是循环的**：`C` 由匹配定出，然后宣布匹配成功。真正非平凡的是**三个参数的函数依赖**（`g`, `m`, `Q̄_L`）。
**图节点的 statement 必须把「函数依赖匹配」与「常数拟合」分成两句，不得合并。**

### Q3 — `C ∼ 1`（Appendix A）与 `C = 4`（正文 (49)）的张力

Appendix A 的结论句逐字是 "Since `C ∼ 1` we see that ...", 而 (49) 定 `C = 4`。**在 (A.4)/(A.6) 里 `C` 分别以 `√C` 与 `1/√C` 出现**，`C = 4` 时两个温度相差 `C = 4` 倍。原文把这叫 "of the same order"。

**本文没有讨论这一点。** 图节点若引 Appendix A，`gaps` 必须写「两种拉伸视界定义只在 `C` 的量级意义下重合；正文取 `C = 4`，附录论证只对 `C ∼ 1` 成立」。

### Q4 — 「高阶导数项也保持 `O(6,22)` 不变」这句无引用无证明

E7 备注里那句逐字断言（"This remains a valid symmetry ... even after we include the higher derivative terms"）**是 E10 全部论证的支点**，而原文对它**既不给引用也不给论证**。

⇒ 图里 E10 的推导 `gaps` 必须包含这一条。**这是本文结构上最重的一个未证前提**（比 E5 的 postulate 更隐蔽，因为 E5 作者自己标了是假设，这一条没标）。

### Q5 — 本文与 `arkani-hamed-2006` 的真实关系

| | `arkani-hamed-2006` §4 | 本文 |
|---|---|---|
| 用的黑洞式 | (22)(23)，引其 [8] = **hep-th/9411187** | (24)，由本文 (22)(23) 导出，解引本文 [7] = **hep-th/9411187** |
| 用的弦谱 | (24)（AMNV 编号） | **(46)** |
| 结论 | 存在 `M/Q` 小于极端黑洞的态 ⇒ WGC (III) 成立 | 极端黑洞熵 = BPS 弦态熵（三参数依赖） |
| 归一化 | `α' = 4`, `M_Pl = 1` | `α' = 16`, `G_N = 2` |

**AMNV 不引本文**（其参考文献 [8] 是 9411187）。
⇒ **本文与 AMNV 之间没有原文级的引用关系。** 图里任何把二者相连的边都必须 `inferred: true`，且 note 写明「两篇的共同一手来源是 hep-th/9411187，而非彼此」。

---

## 5. 给图的建议

> 以下是**建议**，不是改动。researcher 只写 `literature/`（`literature/CLAUDE.md` 规则 4），下列节点由 curator 落地。

### 5.1 核心判断：本文**不该**直接进 swampland 主线，应进一个独立的「BPS/黑洞对应」小簇

理由见 Q1、Q5：本文与 AMNV 没有引用关系，也没有任何弱引力猜想的形式。把它挂到 `swampland.wgc-*` 上会制造一条原文不支持的边。

### 5.2 建议的节点集合

**（a）约定层（必须先建，否则下面全部无意义）**

| 建议 id | kind | 内容 | loc（v2） | 抽取条目 |
|---|---|---|---|---|
| `conv.sen-1995-normalization` | convention | `α' = 16`、`G_N = 2`、`T = g²/32π`、弦度规 vs Einstein 度规 `g = e^{−Φ}G` | `(7)、(9)、(12)、p.5–6` | **§1.1、E7** |

⚠ **这条约定卡的 note 必须写「本文的 `α' = 16` 出自其 [22] = hep-th/9402002，本项目未核实」**（U4）。

**（b）假设层**

| 建议 id | kind | status | 内容 | loc | 抽取条目 |
|---|---|---|---|---|---|
| `bh.stretched-horizon-postulate` | axiom | `physical-argument` | 极端黑洞的熵取拉伸视界面积而非事件视界面积 | `§p.3` | **E5** |
| `bh.stretched-horizon-worldsheet-definition` | definition | — | 拉伸视界 = 世界面理论强耦合处；位置唯一到一个纯数 `C` | `§p.3–4, (34)(35)` | **E6、E10** |

**（c）命题层**

| 建议 id | kind | status | 内容 | loc | 抽取条目 |
|---|---|---|---|---|---|
| `bh.extremal-bogomolnyi-relation-sen` | proposition | `physical-argument` | `m² = Q̄_R²/(8g²)`（本文归一化） | `§p.8, (24)` | **E9** |
| `bh.extremal-horizon-area-vanishes` | proposition | `physical-argument` | 该族极端黑洞事件视界面积为零 | `§p.3；§p.7（"horizon and singularity coincide"）` | **E4、E8** |
| `bh.stretched-horizon-entropy` | proposition | `physical-argument` | `S_{B.H.} = (2πC/g)√(m² − Q̄_L²/(8g²))` | `§p.9, (36)(37)` | **E11** |
| `string.bps-heterotic-t6-degeneracy` | proposition | `physical-argument` | `d_{E.S.} ≃ exp(4π√N_L)`，`m²` 由 (46) 给 | `§p.12, (46)(47)` | **E12** |
| `bh.extremal-bh-equals-elementary-string-state` | proposition | **`physical-argument`** | 三参数熵匹配（`C = 4` 时常数亦匹配） | `§p.12, (48)(49)` | **E1、E12** |

### 5.3 推导布局

```
bh.extremal-bh-equals-elementary-string-state          status: physical-argument
  --via-stretched-horizon-entropy-matching   kind: physical-argument   status: physical-argument
      depends_on: bh.stretched-horizon-postulate（axiom）,
                  bh.stretched-horizon-worldsheet-definition,
                  bh.extremal-bogomolnyi-relation-sen,
                  string.bps-heterotic-t6-degeneracy,
                  conv.sen-1995-normalization
      sources: sen-1995-bh, loc "§p.9–12, eqs. (36)(37)(46)(47)(48)(49)（v2）"
      summary: 拉伸视界面积熵 (37) 与弦态计数熵 (48) 在 g、m、Q̄_L 三个参数上同形；
               取 C = 4 后常数也相同
      gaps: ["C 是拟合出来的，不是独立算出的（Q2）",
             "拉伸视界本身是原文自称的 postulate（E5）",
             "「高阶导数项保持 O(6,22) 不变」无引用无证明（Q4）",
             "Appendix A 的两种定义只在 C ∼ 1 时重合，与 C = 4 有张力（Q3）",
             "(47) 的 exp(4π√N_L) 外包给 [5]，本文不推导（U5）",
             "α' = 16 的约定外包给 [22]，本项目未核实（U4）"]
```

**`bh.extremal-bogomolnyi-relation-sen` 的上游边**：

```
bh.extremal-bogomolnyi-relation-sen
  --via-sen-torus-solution          kind: physical-argument
      depends_on: 〈杂化弦 T⁶ 极端黑洞解〉  ← 一手来源必须是 sen-1995-bh-torus (hep-th/9411187)
      sources: sen-1995-bh, loc "§p.6–8, (13)–(24)（v2）"
      notes: 本文只引用该解并做一次 g 的重标度（脚注 4）；
             ⚠ 一手性在 sen-1995-bh-torus，本文是二手 + 一步重标度
      gaps: ["sen-1995-bh-torus 正文未抽取（U3）"]
```

### 5.4 **不得**挂到 `sen-1995-bh` 的东西（红线清单）

| 内容 | 为什么不行 | 正确出处 |
|---|---|---|
| **AMNV 的 (22) `M² = ½Q_R²` 与 (23) `M² = ½Q_L²`** | **AMNV 引的是 hep-th/9411187，不是本文**；本文的对应式 (24) 系数不同 | `sen-1995-bh-torus` |
| 「杂化弦 `T⁶` 上的极端黑洞解是 Sen 在本文构造的」 | 本文 p.6 逐字说解在其 [7]（= 9411187）里构造 | `sen-1995-bh-torus` |
| 任何弱引力猜想形式（`m ≤ qM_Pl`、`M/Q ≤ 1`、亚极端态存在） | **本文完全没有**（Q1） | `arkani-hamed-2006` |
| 「极端黑洞必须能衰变」/ remnant 论证 | 本文完全没有 | `arkani-hamed-2006` §2.2 → `susskind-1995-remnants` |
| 「Bekenstein–Hawking 熵 = 视界面积/4G」用在**事件**视界上 | 本文明说该族黑洞事件视界面积**为零**，用的是**拉伸**视界 | 见 E4、E5 |
| `α' = 4` 或 `M_Pl = 1` 下的任何系数 | 本文是 `α' = 16`、`G_N = 2` | 见 §1.2、U7 |
| 参考文献 [16]（"C. Vafa, as quoted in first reference in [4]"） | 无书面出处，`literature/CLAUDE.md` 规则 1 | 只作原文引用记录 |
| 标题页的 `November 26, 2024` | 是 arXiv 重编译日期，不是论文日期 | 论文日期 `April, 1995` |

### 5.5 建议同时更新的既有文件

- `literature/sources.bib`：**新增 `sen-1995-bh`（本文，hep-th/9504147）**，与已有的 `sen-1995-bh-torus`（hep-th/9411187）**并列且互相交叉引用**。**本轮已加。**
- `literature/reading-list.md`：加一行 `extracted`；同时**把 `sen-1995-bh-torus` 的优先级上调**（它现在是三处依赖的共同上游：本文 E8、AMNV (22)(23)、以及 `α'`/`G_N` 之外的解本身）。**本轮已加。**
- **建议新增 reading-list 条目（两条）**：
  1. **A. Sen, Int. J. Mod. Phys. **A9** (1994) 3707 [hep-th/9402002]** —— 本文全部归一化约定（`α' = 16`）的出处（U4）。有 arXiv，成本低。
  2. **K. Narain, Phys. Lett. **B169** (1986) 41 与 K. Narain, H. Sarmadi, E. Witten, Nucl. Phys. **B279** (1987) 369** —— Narain 紧化的一手来源；同时被本文 [21] 与 `vafa-2005` E9 需要。1986/87 年，无 arXiv。
  **本轮已加这两条。**

---
