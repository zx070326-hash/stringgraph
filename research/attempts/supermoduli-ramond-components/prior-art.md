# prior-art — `supermoduli-ramond-components`

检索日期：2026-09-23（在 `proof.md` 的两条证明写完之后，按根 `CLAUDE.md`「先做，后查」）。

**结论先行：本 attempt 的主结果 (C1)(C2) 在数学上不是新的。**
Tyler J. Jarvis, *Geometry of the moduli of higher spin curves*, **Internat. J. Math. 11 (2000), no. 5, 637–663**
（预印本 arXiv:math/9809138v3, 8 Jul 1999）的 Theorem 3.3.1 / 3.3.11 已经在完全一般的情形下给出了
分量个数，且**恰好覆盖本 attempt 的全部情形**。

更尖锐的是：这篇文章就是 **FKP 自己的参考文献 [22]**，FKP 在 p.13 引它（连同 [23]）来说明
$\overline{\mathcal S}_{g,n_{NS},n_R}$ 是光滑固有 DM 叠——也就是说，`[GAP-COMP]` 所缺的定理，
就写在论文已经引用的那一篇里，只是换了记号（$r$-spin of type $\mathbf m$）。

因此 `[GAP-COMP]` 应当重新分类为：**文献缺口（citation gap），不是数学缺口。**

---

## 1. Jarvis 的记号与逐字陈述（全部经 400 dpi 页图 L1 核对）

下面四条是判据的全部依据。每条都注明了页码与核对方式；文件 `arXiv:math/9809138v3`。

### (J1) 定义（p.12，Definition 2.3.9）— 核对：400 dpi 页图

> **Definition 2.3.9.** A genus-$g$, $n$-pointed $r$-spin curve of type $\mathbf m$ is a stable
> $n$-pointed curve $X/T$ of genus $g$ and a coherent net of $r$th roots of
> $\omega(\mathbf m):=\omega_{X/T}(-\sum m_iD_i)$, where $D_i$ is the divisor of $X$ corresponding
> to the $i$th section $\sigma_i:T\to X$.

**注意符号**：Jarvis 的扭转是 $\omega(-\sum m_iD_i)$（**减号**），本 attempt 的广义自旋结构是
$L^2\cong\omega_C(+R)$（**加号**）。翻译见 §2。

### (J2) 型的模 $d$ 平移（p.7，Note 2.1.5）— 核对：400 dpi 页图

> **Note 2.1.5.** Since the type $\mathbf m$ changes with different $d$'s dividing $r$, a net of
> roots of $\mathcal F$ of type $\mathbf m$ is not the same as a net of roots of
> $\mathcal F\otimes\mathcal O(-\sum m_ip_i)$ of type $\mathbf 0$. Still, for any $d$th root
> $(\mathcal E_d,c_d)$ of $\mathcal F$ of type $\mathbf m$, there is a uniquely determined $d$th
> root $(\mathcal E'_d,c'_d)$ of $\mathcal F$ of type $\mathbf m'$ for every $\mathbf m'$ congruent
> to $\mathbf m$ mod $d$; namely, $\mathcal E'_d:=\mathcal E_d\otimes\mathcal O(1/d\sum(m_i-m'_i)p_i)$.

这一条正是把"加号扭转"翻译成"减号扭转"的合法手续，**由 Jarvis 本人提供**，不是本 attempt 的拼接。

### (J3) 分量个数（p.17，§3.3.1 + Theorem 3.3.1）— 核对：400 dpi 页图（两段裁剪）

> If $g=0$, let $\ell_{0,r}(\mathbf m)=1$, if $g=1$, let $\ell_{1,r}(\mathbf m)$ be
> $\gcd(r,m_1,\ldots,m_n)$, and if $g\neq2$, let $\ell_{g,r}(\mathbf m)$ be
> $\gcd(2,r,m_1,\ldots,m_n)$; thus $\ell_{g,r}(\mathbf m)$ is either 1 or 2 for $g\ge2$. For any
> genus $g$, let $d_{g,r}(\mathbf m)$ be the number of positive divisors of $\ell_{g,r}(\mathbf m)$,
> including $\ell_{g,r}(\mathbf m)$ and 1.
>
> **Theorem 3.3.1.** The moduli space $\overline{\mathcal S}^{1/r,\mathbf m}_{g,n}$ is the disjoint
> union of $d_{g,r}(\mathbf m)$ irreducible components.

**排印问题（如实记录，见 §5）**：上面的 "$g\neq2$" 是 v3 页面上的字面文字，已在 400 dpi 下反复确认，
不是 OCR 误读。按上下文（$g=0,1$ 各有自己的子句；紧接着的"thus … for $g\ge2$"）应读作 "$g\ge2$"。
按字面读，**$g=2$ 的 $\ell$ 未被定义**。本 attempt 无法核对已发表版（Internat. J. Math. 11 (2000)）
是否修正了这个错字。

### (J4) 一般基域版本 + 紧化（p.23，Theorem 3.3.11）— 核对：170 dpi 页图

> **Theorem 3.3.11.** For any field $k$ with characteristic prime to $r$, the moduli space
> $\mathcal S^{1/r,\mathbf m}_{g,n}$ and and its compactification $\overline{\mathcal S}^{1/r,\mathbf m}_{g,n}$
> of pure spin curves over $k$ are irreducible if $\ell_{g,r}(\mathbf m)=1$. In general, over any
> algebraically closed field, the moduli space is the disjoint union of $d_{g,r}(\mathbf m)$
> irreducible components.

（"and and" 是原文重复词。）注意 (J4) 明确把**内部** $\mathcal S$ 与**紧化** $\overline{\mathcal S}$
并列陈述，所以紧化那一步 Jarvis 也已覆盖（在他自己的紧化下，见 §4 的保留意见）。

其证明的开头一句也值得记下，因为本 attempt 的 Note 2.2 独立用到了同一事实：

> First, note that it is well-known and straightforward to prove [32, Lemma 2.3] that an algebraic
> stack is irreducible or connected if and only if its coarse moduli space has the same property.

---

## 2. 约定翻译表

本 attempt：$L^{\otimes2}\cong\omega_C(R)$，$R=\rho_1+\cdots+\rho_{2r}$（Ramond 穿孔），NS 穿孔
$p_1,\dots,p_n$ 不扭转。

取 Jarvis 的 $r_{\rm Jarvis}=2$（本 attempt 的 $r$ 是 Ramond 穿孔**对数**，与 Jarvis 的 $r$ 无关，
以下写 $r_J=2$ 以免混淆），$n_J=n+2r$（全部标记点，有编号）。

第一步（去掉加号）：置 $L':=L(-R)$，则
$$L'^{\otimes2}=L^{\otimes2}(-2R)\cong\omega_C(R)(-2R)=\omega_C(-R),$$
即 $L'$ 是 $\omega(\mathbf m)$ 的平方根，其中
$$m_i=\begin{cases}1,&\text{标记点是 Ramond 穿孔}\\0,&\text{标记点是 NS 穿孔.}\end{cases}$$
这一步是 $L\mapsto L(-R)$ 的双射，逐族成立，给出模叠的同构。（也可以直接引 (J2)：$-1\equiv1\bmod2$。）

第二步（代入 (J3)）：

| 情形 | $\ell_{g,2}(\mathbf m)$ | $d_{g,2}(\mathbf m)$ | Jarvis 的分量数 | 本 attempt 的结论 |
|---|---|---|---|---|
| $g\ge2$，$r\ge1$（有 Ramond） | $\gcd(2,2,\underbrace{1}_{\text{某个 }m_i},\dots)=1$ | 1 | 1 | (C1) 连通 ✔ |
| $g\ge2$，$r=0$（纯 NS） | $\gcd(2,2,0,\dots,0)=2$ | 2 | 2 | (C2) 两个宇称分量 ✔ |
| $g=1$，$r\ge1$ | $\gcd(2,1,\dots)=1$ | 1 | 1 | (C1) ✔ |
| $g=1$，$r=0$ | $\gcd(2,0,\dots,0)=2$ | 2 | 2 | (C2) ✔ |
| $g=0$ | $\ell_{0,2}\equiv1$ | 1 | 1（或空） | (C2) 的 $g=0$ 条 ✔ |

**五个格子全部相符，没有一个例外。** 这既确认了 Jarvis 覆盖本 attempt，也反过来是对 `proof.md`
两条独立证明的一次外部交叉检验。

顺带：Jarvis 的判据 $\ell_{g,2}(\mathbf m)=\gcd(2,2,m_\bullet)$ 只依赖 $\mathbf m\bmod 2$，也就是
"是否存在至少一个 Ramond 穿孔"。这与 `proof.md` §4 Proposition 4.2 给出的机制性说法
（"唯一的差别在于扭转除子里有没有可动点"）是同一件事的两种写法。

---

## 3. FKP 的引用链

FKP（Felder–Kazhdan–Polishchuk, *Regularity of the superstring supermeasure and the superperiod map*
及相关文章，本 attempt 所用版本即论文 §2 所引者）p.13 在定义广义自旋结构之后，紧接着引

- **[21]** T. Jarvis, *Torsion-free sheaves and moduli of generalized spin curves*, Compositio Math. **110** (1998), 291–333.
- **[22]** T. Jarvis, *Geometry of the moduli of higher spin curves*, Internat. J. Math. **11** (2000), no. 5, 637–663.
- **[23]** T. Jarvis, T. Kimura, A. Vaintrob, *Moduli spaces of higher spin curves and integrable hierarchies*, Compositio Math. **126** (2001), 157–212.

说明 $\overline{\mathcal S}_{g,n_{NS},n_R}$ 是光滑固有 DM 叠。

**[22] 就是给出 Theorem 3.3.1 的那一篇。** 就本 attempt 所核查的范围内，FKP 引 [22] 只用了
"光滑固有 DM 叠"，**没有**引用其中的不可约性/分量计数（Theorem 3.3.1 / 3.3.11）。
`research/papers/supermoduli-punctured-nonprojected/paper.md` §10.3 的 `[GAP-COMP]` 因此是
"顺着 FKP 的引用方式继承下来的盲点"，而不是公开文献里真的没有答案。

---

## 4. 保留意见：Jarvis 覆盖到哪一步，哪一步仍然需要本 attempt 自己的论证

诚实地划线。Jarvis 给的是**玻色侧、他自己的紧化**上的陈述。要落到论文 §10.3 需要的形状，还差两步，
这两步 Jarvis 没有做，本 attempt 做了：

**(a) 紧化的同一性。** Jarvis 的 $\overline{\mathcal S}^{1/2,\mathbf m}_{g,n}$ 用无挠层（Cornalba 风格）
构造，FKP 的 $\overline{\mathcal S}_{g,n_{NS},n_R}$ 走的是 twisted curve / Abramovich–Jarvis 路线。
二者同构是已知的（Abramovich–Jarvis），但**本 attempt 没有核对这个同构**。
→ `proof.md` §5 的稠密性论证（基于 FKP Prop 7.8(ii)，已 L1 核过）**绕开了这个问题**：
它只用"内部在 FKP 紧化里稠密"，把**内部**的连通性（记号无歧义，Jarvis 与本 attempt 一致）
搬到 FKP 的紧化上，不需要两个紧化是同一个。这一步是本 attempt 仍然承重的部分。

**(b) 从玻色截断回到超叠。** Jarvis 全文是玻色几何，不涉及超叠。
→ `proof.md` §2 Note 2.2 + 论文引理 5.1（超叠与其玻色截断有相同的底层拓扑空间）完成这一步。
这一步平凡，但确实要有人写。

**(c) $g=2$ 的字面漏洞。** 见 (J3) 的排印问题。`proof.md` 的两条证明都独立覆盖 $g=2$
（§6.2 还给出 $g=2,2r=2$ 的显式见证），不依赖对 Jarvis 那个 "$g\neq2$" 的修复性解读。
这对本 attempt 的下游用途有实际意义：论文定理 M 的阈值情形恰好就是 $g=2$。

---

## 5. 检索记录（这一轮实际做了什么）

- WebSearch：`connected components moduli space of twisted spin curves Ramond punctures theta
  characteristic L^2=ω(D) irreducible` → 命中 Jarvis math/9809138（以及 FKP、Donagi–Witten
  1304.7798、Alexandrov–Norbury 2412.17272、Norbury 2312.14558、Polishchuk 等）。
- WebSearch：`Alexandrov Norbury super volumes KdV Ramond twisted spin curves moduli space connected
  components labeled` → Alexandrov–Norbury 只按**穿孔类型** $\sigma\in\{0,1\}^n$ 给分量标签，即
  把 $(n,2r)$ 固定下来；在固定类型之后**没有**给出进一步的分量计数。故不构成对本 attempt 的覆盖，
  但也不与之冲突。
  **记号陷阱**：Alexandrov–Norbury 的 Definition 2.1 把 $\sigma_p=0$ 叫 Ramond、$\sigma_p=1$ 叫
  Neveu–Schwarz，与多数文献相反，引用时须小心。
- 下载 `arxiv.org/pdf/math/9809138` → `pdfinfo` 显示为 **v3, 8 Jul 1999**，25 页，running head
  "GEOMETRY OF SPIN CURVE MODULI"。§1–§3 全文 `pdftotext -layout` 提取，四条承重陈述
  ((J1)–(J4)) 逐条渲染页图核对。
- **未做**：核对已发表版 Internat. J. Math. 11 (2000) 637–663 的正文（无访问）。因此 §1 的逐字引用
  一律标明取自 v3。
- **未找到**：任何把这条连通性直接写在**超模空间/超黎曼面带 Ramond 穿孔**语言里的文献陈述。
  （这不是一个有分量的发现——从玻色截断过去是三行的事。）

---

## 6. 对本 attempt 新颖性的最终判定

| 内容 | 新颖性 |
|---|---|
| (C1) $r\ge1$ ⟹ 连通 | **不是新的**。Jarvis Thm 3.3.1/3.3.11（$\ell_{g,2}=1$）。 |
| (C2) $r=0$ ⟹ 两个宇称分量 | **不是新的**。经典（Atiyah/Mumford），Jarvis §3.3.1 开篇也明说。 |
| (C3) 紧化 + 超叠 | 玻色紧化部分不是新的；**"绕开两个紧化是否同构"的稠密性论证**是本 attempt 自己的，见 §4(a)。 |
| (C4) `[GAP-COMP]` 对 $r\ge1$ 为空 | 作为**对论文的处置**是新的（论文原文不知道这一点）；作为数学是 (C1) 的直接推论。 |
| (C5) §8 步骤 (i) 不可修复 | 论证是本 attempt 的；但一旦知道 (C1)，它是一句话推论（连通 ⟹ 连续不变量恒为常值）。 |
| `proof.md` §3 的点推单值机制 | **不是新的**：Jarvis Lemma 3.3.6 用 bounding pair 的 Torelli 扭转做同一个 Picard–Lefschetz 计算，而点推本身就是一个 bounding-pair 映射。本 attempt 的写法更短、更初等，但机制相同。 |
| `proof.md` §8 的 Johnson 二次型路线 | 作为**证法**是标准工具的标准用法；作为对同一结论的第二条独立证明，在本 attempt 内部是有用的交叉检验，对外不构成新结果。 |
| `proof.md` §6.2 的 $g=2,2r=2$ 显式宇称跳变见证（$L\cong\omega_C$ ⟺ $\rho_2=\iota(\rho_1)$；余维 1 上 1 偶 + 15 奇，其余 16 奇） | 在检索到的文献里**没找到**这条显式计算。它是小的，但它是具体的，而且正好是"为什么宇称在 $r\ge1$ 时不是不变量"的最便宜的见证。 |

**一句话**：本 attempt 的数学产出是"已知结论的独立重证 + 一条到论文语言的搬运 + 一个显式见证"，
按根 `CLAUDE.md`「负面结果与『已知结论的新推导路径』算产出，但要标清楚」归类。
真正对项目有价值的是那条**处置建议**：`[GAP-COMP]` 可以直接引 Jarvis [22] Thm 3.3.11 关闭，
不需要任何新数学；论文只需把 §10.3 从"未知"改写成"已知且为 1，故定理 B 已经是分量级陈述"。
（改写论文是 lead 的事，本 attempt 不碰 `research/papers/**`。）
