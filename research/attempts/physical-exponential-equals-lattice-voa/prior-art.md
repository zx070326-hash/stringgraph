# Prior-art gate — 「物理正规序指数 = 格点 VOA 顶点算子」（图卡断言 (2)）

**日期**：2026-09-18
**执行者**：theorem-prover（分支 `agent/prover/physical-exponential-equals-lattice-voa`）
**目标命题**：`graph/statements/worldsheet/physical-exponential-equals-voa-vertex-operator.yaml`
的**断言 (2)**——在秩 1 类光格 `L = Zk` 与动量塔 `T(p;k_0)` 上，
`:e^{i n k_0·X(z)}: = 𝒴(e^{n k_0}, z)` 作为塔上线性算子逐幂次相等。

本文件的唯一作用是**在写任何证明之前**把「谁已经说过这件事、说到什么程度」钉死，
使本尝试的原创性主张不会越界。

---

## §0 结论（先说结论，三句话）

1. **这个等式的陈述在公开文献里出现过**——`grotenhuis-2020`（Leiden 本科毕业论文）p.106
   (6.6) 之后逐字写道 "We recognise this expression as the lattice vertex operators `Y(|α⟩, z)`
   given in (3.15)."
   🔴 **因此本尝试的原创性主张只能是「首次给出证明」，绝不可主张「首次陈述」。**
   这条纪律写进 `claim.md` §0，并在那里单列一节点名 Grotenhuis。
2. **这个等式的证明查无。** Grotenhuis 的 "We recognise" 是零论证的肉眼识别，
   而且他的两条公式内部不自洽（见 §2 的限定词 2）；他处理的是**正定偶格（Leech）**，
   不是本卡的秩 1 类光格 + 连续动量塔；本卡列出的三条接缝（cocycle / 连续动量↔离散格 / δ 归一化）
   他一条都没碰。
3. **⭐ 更要紧的是：Grotenhuis 的识别在他自己的设定（一般偶格）下是错的**——零模因子对不上，
   而且对不上的方式恰好被 (3.14) 的反对易条件**证伪**（§3）。这个洞在秩 1 类光格上正好闭合，
   闭合它的那一步**就是本卡的断言 (1)**。所以本尝试面对的不是"补一个细节"，
   而是"在唯一使该识别可能为真的退化情形下，把它真正证出来"。

---

## §1 `grotenhuis-2020` 的登记信息（逐字）

| 字段 | 内容 |
|---|---|
| bib key | `grotenhuis-2020`（**已由 researcher 登记在 `literature/sources.bib`**，本轮不重复登记、不修改） |
| 作者 | L. M. Grotenhuis |
| 标题 | *Vertex Algebras and String Theory in Monstrous Moonshine* |
| 机构/类型 | Leiden University，**Bachelor thesis (Physics and Mathematics)**，指导 Prof. dr. K. E. Schalm、Dr. R. I. van der Veen |
| 日期/篇幅 | 2020-06-19，127 页 |
| 官方托管 | `https://studenttheses.universiteitleiden.nl/handle/1887/123029` |
| 公开镜像 | `http://www.stat.ucla.edu/~ywu/moonshineString.pdf` |
| 承载位置 | **p.106 (6.5)(6.6) + 紧随其后的识别句**；等号右端来自 **p.54 Theorem 3.4 的 (3.15)** |
| 本项目内的抽取记录 | `literature/extractions/assertion-2-round4-msri-flm-2026-09-18.md` §候选 4（E4.1–E4.4，含页图逐字核对） |

### 承载文字（逐字，取自上述抽取记录的页图核对结果）

物理侧（p.106）：

> `X_L(z) = x_0^L - iα'p ln z + i√(α'/2) Σ_{n≠0} (1/n) α_n z^{-m}.`   (6.5)
>
> and thus
>
> `:e^{ikX_L(z)}: = e^{ikx_0^L} z^{α'kp} e^{-k Σ_{n<0} (α_n/n) z^{-n}} e^{-k Σ_{n>0} (α_n/n) z^{-n}}.`   (6.6)
>
> **We recognise this expression as the lattice vertex operators `Y(|α⟩, z)` given in (3.15).
> In this way, our mathematical definitions in chapter 1 describe the chiral (i.e. left-moving)
> vertex operators in string theory.**^§

VOA 侧（p.54，Theorem 3.4）：

> **Theorem 3.4.** There exists a conformal vertex algebra structure on `V_L` … if and only if for
> each `α ∈ L` there exists an operator `c_α` that commutes with every `a_n` … such that these
> operators satisfy `c_α|0⟩ = |0⟩`, `c_0 = id` and (3.14). In this case, the mapping
>
> `Y(|α⟩, z) = e^α c_α z^{α_0} e^{-Σ_{n<0} (α_n/n) z^{-n}} e^{-Σ_{n>0} (α_n/n) z^{-n}}.`   (3.15)
>
> for `α ∈ L` defines a vertex algebra structure on `V_L`.
>
> (3.14):  `e^α c_α e^β c_β = (-1)^{(α,β)} e^β c_β e^α c_α.`

作者自陈的假设（p.106 脚注 §，逐字）：

> Recall that the reconstruction theorem from chapter 2 implies that the vertex operators
> `Y(|α⟩, z)` determine the vertex operators of the whole state space. **Assuming that the 'string'
> vertex operators `V_A(z, z̄)` satisfy the vertex algebra axioms as well**, we obtain that not just
> the pure momentum vertex operators (as given by (6.3)) but also the vertex operators of the
> oscillator states correspond to the 'mathematical' lattice vertex operators.

---

## §2 必须与陈述同时说出口的五条限定词

本尝试**不得**在任何地方只引用 §1 的识别句而省略以下任何一条。

1. **来源分量低。** 本科毕业论文，**非同行评议**，无期刊号、无 arXiv 号。可公开获取、可核，
   但证据分量低于任何一篇已发表论文。
2. **论证强度为零，且作者的公式内部不自洽。**
   "We recognise this expression as …" 是**肉眼识别**——不是 "one checks that"，不是 "a computation
   shows"，没有逐项系数核对。证据就在他自己的公式里：
   - (6.5) 的振子项带 `i√(α'/2)` 因子，故 `:e^{ikX_L}:` 的振子指数应当带 `√(α'/2)`；
     但 (6.6) 右端写的是 `e^{-k Σ (α_n/n) z^{-n}}`，**`√(α'/2)` 消失了**，
     而零模项的 `α'` 却保留着（`z^{α'kp}`）。**(6.6) 与 (6.5) 在 `α'` 归一化上互相矛盾。**
   - (6.4)(6.5) 的求和项写作 `α_n z^{-m}`，按上下文应为 `z^{-n}`；**`m` 全文未定义**。
     (6.4) 的反手征项写作 `ᾱ`，漏下标 `n`。
   一个逐项核对过的识别不会掉一个整体因子 `√(α'/2)`。
3. **命题不是本卡这一条。** 全文的格是**正定偶格**（§3.1 逐字要求 "`L` is even and positive
   definite"，最终用 24 维 Leech 格）。本卡要的是**秩 1 类光格 `L = Zk`（`⟨k,k⟩=0`）与连续基点
   动量塔 `T(p;k_0)`**，即不定（洛伦兹）签名下的退化情形。Grotenhuis 的 Theorem 3.4/3.5 的前提
   （正定偶格、`L_0` 的 `N`-分次、特征子空间有限维）**在类光情形下不成立**。
   本卡的接缝 (b)（连续动量 ↔ 离散格）与 (c)（δ 归一化）他**一条都没碰**：(6.3) 逐字写
   "For a string state `|k⟩` of momentum `k`"，`p` 是连续动量算符，而 (3.15) 要求 `α ∈ L` 是格点；
   作者在 (6.6) 之后没有说明 `k` 何时落在格里。δ 归一化全文未提。
4. **作者本人把关键的推广步骤标成了未证的假设。** p.106 脚注 § 逐字 "**Assuming** that the
   'string' vertex operators `V_A(z,z̄)` satisfy the vertex algebra axioms as well, we obtain that …"。
   即：从纯动量态推广到振子态那一步，作者自己声明是假设。
5. **零模因子对不上（见 §3，这是硬伤，不是限定词而已）。**

---

## §3 ⭐ 正面迎击：Grotenhuis 的识别在一般偶格上**是错的**

（这条是 lead 的独立发现；本尝试必须在 `proof.md` 里正面处理，不得绕过。）

逐项对照 §1 的两条公式的**零模部分**：

| | 零模因子 |
|---|---|
| 物理侧 (6.6) | `e^{i k x_0^L}` —— **一个**因子 |
| VOA 侧 (3.15) | `e^α c_α` —— **两个**因子（平移算符 × cocycle 算符） |

作者在 "We recognise …" 一句里**完全没有提到 `c_α`**，也没有讨论 `e^{ikx_0^L}` 是否满足 (3.14)。

而 Theorem 3.4 的存在性条件 (3.14) 逐字是

```
e^α c_α e^β c_β = (-1)^{(α,β)} e^β c_β e^α c_α
```

即：当 `(α,β)` 为**奇数**时，两个零模因子必须**反对易**。
物理侧的 `e^{i k x_0}` 是平移算符的指数，彼此**两两对易**（`[x_0^μ, x_0^ν] = 0`）。

**结论：在存在 `(α,β)` 为奇数的偶格上（Leech 格就有大量这样的对），物理侧的零模因子不可能满足
(3.14)，因此 (6.6) 的右端不可能等于 (3.15)。Grotenhuis 的识别在他自己设定的一般偶格上是错的。**

**而这个洞在本卡的设定下恰好闭合**：秩 1 类光格 `L = Zk`，`⟨k,k⟩ = 0` ⟹ 对一切 `α,β ∈ L` 有
`⟨α,β⟩ ≡ 0`，于是 `(-1)^{(α,β)} ≡ 1`，(3.14) 退化成"两个零模因子对易"——这正是 `e^{ikx_0}`
满足的关系，从而可以取 `c_α ≡ 1`（等价地 `ε ≡ 1`）。

**这一步就是本卡的断言 (1)**（`ε(mk,nk) = 1`），它已有两条 L1 来源：
- Gebert–Nicolai 1995 §3.1 式 (3.1)；
- Li–Wang 2008（arXiv:0802.0173）§4 p.21 逐字 "the normalized 2-cocycle ε … is trivial in the
  sense that `ε(α,β) = 1` for all `α,β ∈ L`"。

🔴 **纪律**：断言 (1) 已被证明，本尝试**不重证**，只引用。
并且必须明说：**断言 (1) 对断言 (2) 是必要而不充分的**——它只保证零模因子的**对易型**匹配，
不保证两侧作为算子逐幂次相等（振子部分、单值因子 `z^{⟨α,·⟩}`、指标移位、以及塔上层间行为
都还没被它触及）。本尝试的全部工作在断言 (1) 之后开始。

**结构性推论（写进 `proof.md`）**：类光性不是本命题的一个技术便利，而是**它成立的条件本身**。
任何把本命题往非类光格推广的尝试都会先撞上 §3 的这堵墙。

---

## §4 本卡此前四轮检索的结论（转录，不重做）

四轮检索（记录见 `literature/extractions/` 下的 assertion-2 系列）的净结果：
**断言 (2) 的陈述只在 `grotenhuis-2020` 一处找到，证明一处也没有。** 失败模式有四类，
每一类都值得在本尝试里当作"证明必须跨过的门槛"来读：

| 候选 | 失败模式 |
|---|---|
| Nikolov–Todorov 2004 | **定义 ≠ 识别**：正规序指数是 `Y(e^α,z)` 的**定义式**，不是跨框架恒等式 |
| Gebert 1993 | VOA 侧独立，但物理侧只是**记号改写**（同一个对象换个写法），两端不独立 |
| Dolan–Goddard–Montague 1994 | 正文里**根本没有出现 `Y(v,z)`** |
| Gaberdiel 1999 | **物理侧记号缺席**（无 `X^μ(z)` 模展开、无冒号正规序） |
| FLM 第 8 章 | 转引路线查到的所有二手转述都指向 "The definition is extended to…"，即**定义式**；正文本身仍为 L0（无法获取） |
| Dong–Mason–Nagatomo / Runkel / Driscoll-Spittler / Keller 讲义 | 纯 VOA 侧，物理侧记号缺席 |
| Kac–Raina（两版） | 四渠道实测无法获取，**无定论** |

**判据的含义**：一条真正的"跨框架恒等式"必须满足三条——(1) 物理侧有显式 `X^μ(z)` 模展开与冒号
正规序；(2) 两侧之间有一个真正的等号；(3) 等号右端是**独立**用 VOA 公理构造出来的，而不是被这个
等号定义出来的。四轮里只有 Grotenhuis 三条形式上全中，而他的那一次识别按 §3 是错的。

---

## §5 本尝试的定位（据此写 `claim.md` §0）

- ✅ **可以主张**：首次给出证明；首次在**秩 1 类光格 + 连续基点动量塔**这一设定下把该识别
  精确到逐幂次系数并指明归一化的全部自由度。
- ❌ **不可主张**：首次陈述。（`grotenhuis-2020` 已陈述，虽只在正定偶格上且无论证。）
- ⚠ **必须同时报告的负面情报**：Grotenhuis 的识别在一般偶格上因 (3.14) 的反对易条件而**不成立**；
  本尝试的正面结论**只**覆盖 `⟨α,β⟩ ≡ 0` 的退化情形，且这不是本尝试的取巧，而是该命题成立的边界。

**本文件不修改 `literature/**` 的任何文件**（`grotenhuis-2020` 已由 researcher 登记，本轮只引用）。
