# 抽取记录：arkani-hamed-2006

- 文献：N. Arkani-Hamed, L. Motl, A. Nicolis and C. Vafa, *The String Landscape, Black Holes and Gravity as the Weakest Force*, arXiv:**hep-th/0601001**（报告号 HUTP-05/A0057）
- 抽取者：researcher agent
- 日期：2026-09-11
- 覆盖范围：**全文**（Abstract、Contents、§1 Introduction、§2 Loose conjectures（§2.1–§2.4）、§3 Sharpening the claim、§4 Evidence for the conjecture（§4.1）、§5 Possible relation to subluminal positivity constraints、§6 Discussion、§7 Acknowledgements、References）
- 目标 area：`swampland`

---

## 0. 核实方法与证据等级（必读）

### 0.1 本轮实际读到什么

| 项 | 内容 |
|---|---|
| 获取路线 | `WebFetch https://arxiv.org/pdf/hep-th/0601001` → PDF 落盘 213.8 KB → `Read(pages=1-6)` + `Read(pages=7-13)` + `Read(pages=14-21)` **逐页读页图** |
| 拿到的版本 | 页边条纹逐字为 `arXiv:hep-th/0601001v2  21 Feb 2006`；标题页右上 `HUTP-05/A0057` 与 `hep-th/0601001` |
| 页数 | PDF 共 21 页 = 标题页（无页码）+ **p.1 = Contents** + 正文 p.2–p.18 + Acknowledgements p.19 + References p.20 |
| 缺失 | **无**。全文每一页都读到了 |

> **PDF 页码 ↔ 论文页码：论文 p.N = PDF 第 N+1 页。** 注意**论文 p.1 是目录**，正文从 p.2 开始（与目录里「1 Introduction … 2」一致）。本文件「位置」栏一律给**论文页码**。

### 0.2 证据等级

沿用 `polchinski-1998-v1.md` §0 的 L1–L4 定义。本文件的 **L1 = 抽取者本轮亲自逐页读到 arXiv v2 的页图**，所有标 **[逐字]** 的都是真正的逐字引用。**本文件没有 L3 条目。**

### 0.3 ★ 编号结构（本文是三篇里编号最完整的）

1. **有 30 个编号公式 `(1)`–`(30)`**（全篇连续编号，不分章节）。分布：`(1)`–`(4)` p.4；`(5)`–`(6)` p.6；`(7)`–`(11)` p.7；`(12)`–`(14)` p.8；`(15)`–`(17)` p.9；`(18)` p.10；`(19)` p.10；`(20)` p.12；`(21)`–`(24)` p.13；`(25)`–`(27)` p.14；`(28)` p.15；`(29)`–`(30)` p.16。
   → **图节点的 `loc` 可以、也应该精确到公式号。**
2. **三个 sharp 版本用罗马数字标号 `(I)`、`(II)`、`(III)`**，在 **§3, p.10**（在 `(19)` 之后，**它们本身不占用 `(1)`–`(30)` 的编号**）。
3. **五张编号图 `Figure 1`–`Figure 5`**：Fig.1 p.3（landscape/swampland 示意，判据写作 `G_N < g²/m²`）、Fig.2 p.6（极端黑洞衰变）、Fig.3 p.9（自不吸引物体）、Fig.4 p.13（杂化弦谱从下方趋近 `M = Q`）、Fig.5 p.17（`1/g²` 跑动与 `gM_Pl` 标度）。
4. **有目录页**（三篇里唯一一篇），节标题与页码可直接引用。
5. **⚠⚠ 全文没有出现「Weak Gravity Conjecture」这个名字**（21 页逐页确认）。原文的说法是：标题的 "Gravity as the Weakest Force"、正文加引号的 **"gravity is the weakest force"**（p.2、p.4）。**「弱引力猜想」这个名字不是本文措辞。**

### 0.4 ★ 版本风险（本篇比另两篇严重，必读）

**读的是 v2（2006-02-21）**，而 arXiv ID 是 `0601001`（**2006-01-01**）。两者相隔近两个月。

**已发现的一条 L1 内部证据表明 v2 有实质增补**：§5「Possible relation to subluminal positivity constraints」的核心引用 **[9] = Adams–Arkani-Hamed–Dubovsky–Nicolis–Rattazzi, "Causality, Analyticity and an IR Obstruction to UV Completion," arXiv:hep-th/0602178** —— **该 preprint 的编号是 2006 年 2 月**，晚于本文 v1（2006-01-01）。
→ **§5 极可能是 v2 新增或大改的**（v1 里不可能引用一篇尚未出现的 2 月 preprint）。**但 v1 本身本轮未取，这只是从引用日期推出的推断，等级 L2/推断，不是核实。**

→ **硬性要求**：图节点引本文任何公式号，**必须写死 `v2`**；引 §5 与 `(28)`–`(30)` 时**额外**在 note 里写「§5 可能不在 v1 中（其引用 hep-th/0602178 晚于 v1 日期）」。

发表状态未核实（L0）。

---

## 1. 约定

### 1.1 该文自述/可从正文读出的约定

| 项 | 本文的取法 | 位置与等级 |
|---|---|---|
| **单位** | **§3 起明确取 `M_Pl = 1`**。逐字：「Working in `M_Pl = 1` units, we are making a conjecture about mass/charge ratios」；§4 又说一次「where we work in units with `M_Pl = 1`」 | §3 p.10、§4 p.13，**L1** |
| **`α'` 归一化** | **只在 §4 的杂化弦检验里出现，且取 `α' = 4`**。逐字：「where `N_{R,L}` are the string oscillator contributions and where we chose units with `α' = 4`」 | §4, (24) 后, p.13，**L1** |
| **不等号** | **§2 的「loose conjectures」一律用 `≲`（order-of-magnitude）**；**§3 的三个 sharp 版本 (I)(II)(III) 用 `≤`**；`(19)` 用 `≲` | §2 p.4–8；§3 p.10，**L1** |
| **⚠ 极端性关系的归一化在文内不统一** | **§2.2 用 `M = QM_Pl`**（"Since extremal black holes have `M = QM_Pl`"）；**§4 用 `M² = ½Q²`**（(22)(23)，`M_Pl = 1` 单位下）。**两者不是同一个归一化**（见 Q2） | §2.2 p.6；§4 (22)(23) p.13，**L1** |
| `p`-form 情形的耦合量纲 | 逐字：「where the coupling `g` (the charge density) has a dimension of `mass^{p+1−D/2}`」 | §2.4, (14) 后, p.9，**L1** |
| 电/磁耦合的关系 | `(2)` 里逐字给 `g_mag ~ 1/g_el` | §2.1, (2), p.4，**L1** |
| 时空号差 | **全文未给出** | —，**L0** |
| Newton 常数记号 | `G_N` 与 `M_Pl` 并用；Fig.1 用 `G_N < g²/m²`，`(14)` 用 `G_N`，其余多用 `M_Pl` | **L1** |

### 1.2 与 `graph/conventions/` 的对照

| 图里的约定 | 是否适用 | 说明 |
|---|---|---|
| `conv.metric-mostly-plus` | **无法判定** | 本文陈述与号差无关 |
| `conv.alpha-prime-regge` | **部分适用，但归一化不同** | 本文 §4 取 **`α' = 4`**。图里 `conv.alpha-prime-regge` 若绑定 Polchinski 的 `α'` 归一化，与本文 (24) 的 `−1`（左移玻色弦快子贡献）系数直接相关。**引 (24) 必须声明 `α' = 4`** |
| （建议新建）`conv.extremality-normalization` | **本文内部就不统一，是必须显式化的约定** | §2.2 的 `M = QM_Pl` 与 §4 的 `M² = ½Q²` 差一个 `√2` 与电荷格归一化。见 **Q2**。**这是本篇最重要的约定缺口** |
| （建议新建）`conv.moduli-metric-planck-units` | 不适用 | 本文不涉及模空间度规（那是 `ooguri-vafa-2006`） |

---

## 2. 陈述

编号 `E<n>`。转成节点时在节点 `notes` 写 `from: arkani-hamed-2006#E<n>`。

---

### E1 摘要：本文自己给出的主张强度（**meta 条目，不要直接建节点**）

- 位置：Abstract，标题页 — **L1**
- 类型：meta（主张强度记录）
- 原文陈述 **[逐字，全文照抄]**：
  > "**We conjecture a general upper bound on the strength of gravity relative to gauge forces in quantum gravity.** This implies, in particular, that in a four-dimensional theory with gravity and a `U(1)` gauge field with gauge coupling `g`, there is a new ultraviolet scale `Λ = gM_Pl`, invisible to the low-energy effective field theorist, which sets a cutoff on the validity of the effective theory. Moreover, there is some light charged particle with mass smaller than or equal to `Λ`. **The bound is motivated by arguments involving holography and absence of remnants, the (in) stability of black holes as well as the non-existence of global symmetries in string theory. A sharp form of the conjecture is that there are always light "elementary" electric and magnetic objects with a mass/charge ratio smaller than the corresponding ratio for macroscopic extremal black holes, allowing extremal black holes to decay. This conjecture is supported by a number of non-trivial examples in string theory.** It implies the necessary presence of new physics beneath the Planck scale, not far from the GUT scale, and explains why some apparently natural models of inflation resist an embedding in string theory."
- 文献自称的严格程度：**"We conjecture"**（首句）；证据形式自陈为 "motivated by arguments" + "supported by a number of non-trivial examples"。**摘要里没有 "we prove"、没有 "we show"。**
- 备注（三点，对图有直接影响）：
  1. ⚠ **摘要写的是 `Λ = gM_Pl`（等号）**，而正文 `(4)` 是 **`Λ ≲ gM_Pl`（小于约等）**，§1 又写 `Λ ~ gM_Pl` 与 `Λ ~ √(α/G_N)`。**同一个量在摘要/正文里有三种关系符。图节点应以正文 `(4)` 的 `≲` 为准，并在 note 记摘要用等号。**
  2. **摘要把主张分成「loose」与「sharp」两级**（"A sharp form of the conjecture is that…"），与正文 §2（loose）/§3（sharp）的分节一致。**图里必须拆开**（见 §5）。
  3. **摘要里的 sharp 版本措辞是「light "elementary" electric and magnetic objects with a mass/charge ratio smaller than the corresponding ratio for macroscopic extremal black holes」** —— 这对应正文的 **(II)**（最轻带电粒子），不是 (III)。**但正文明确说「most of our evidence only supports the weaker conjecture (III)」（E19）。摘要比正文强。**

---

### E2 §1：本文相对 `vafa-2005` 的定位（"a new criterion"）

- 位置：§1 Introduction，**p.2** — **L1**
- 类型：meta（文献关系）
- 原文陈述 **[逐字]**：
  > "However it was recently suggested [1] that the landscape of consistent theories of gravity one obtains in string theory is by far smaller than would have been anticipated by considerations of semiclassical consistency of the theory. **The space of consistent low-energy effective theories which cannot be completed to a full theory was dubbed the 'swampland'.** Certain criteria were studied in [1] to distinguish the string landscape from the swampland. For example, one such criterion was the finiteness of the number of massless fields (see also [2] for a discussion of this point).
  > **In this paper we propose a new criterion which distinguishes parts of the swampland from the string landscape.** This involves the simple observation, clearly true in our own world, that "gravity is the weakest force". **We promote this to a principle and in fact find that surprisingly it is demanded by all consistent string theory compactifications!** Roughly speaking this is the statement that there exist two "elementary" charged objects for which the repulsive gauge force exceeds the attractive force from gravity. **More precisely, the conjecture we make is that this is true for a stable charged particle which minimizes the ratio `|M/Q|`. In other words one of our main conjectures in this paper is that (in suitable units) the minimum of `|M/Q|` is less than 1.**"
- 文献自称的严格程度：**"we propose a new criterion"**、**"the conjecture we make is"**；对弦论侧的检验用 **"we find that surprisingly it is demanded by all consistent string theory compactifications"**（强）。
- 文献列出的依赖：[1] = **C. Vafa, hep-th/0509212**（= `vafa-2005`）；[2] = M. Douglas, talk at Strings 2005（**无书面稿，不可登记**）。
- 备注（**两点**）：
  1. ⚠ **本文对 `vafa-2005` 的转述不完整**：只提「无质量场数目有限」，**没提标量模空间体积**（Vafa 的三条判据见 `vafa-2005.md` E5）。虽然 §2.1 末又说自己的界「not independent of conjecture about the finiteness of the volume of moduli spaces in [1]」（E10）。
  2. ⚠ **本文对 swampland 的转述与 Vafa 的原定义措辞不同**：本文说「cannot be completed to a full theory」，Vafa 原文是「semiclassically consistent … which are actually inconsistent」（`vafa-2005.md` E2）。**两者含义接近但不逐字相同；图里 swampland 的定义节点必须用 Vafa 的原措辞。**

---

### E3 §1：本文的推论清单（UV 标度、光带电粒子、对暴胀的排除）

- 位置：§1，**p.2–p.3** — **L1**
- 类型：proposition（推论汇总）
- 原文陈述 **[逐字，节选]**：
  > "We motivate this conjecture from various viewpoints. In particular **we show how this conjecture follows from the assumption of finiteness of the number of stable particles which are not protected by a symmetry principle.** This finiteness criterion nicely extends some of the finiteness criteria discussed in [1,2] in the context of bounds on the number of massless particles in a gravitational theory. **We show why if our conjecture were not true, there would be an infinite tower of stable charged particles not protected by any symmetry principle.** The conjecture also ties in nicely with the absence of global symmetries in a consistent theory of gravity.
  > Our conjecture, if true, has a number of consequences: For extremal (not necessarily supersymmetric) black holes the bound is `M/|Q| = 1`. This suggests that there are corrections to this formula for smaller charges, which makes it (in the generic case) an inequality `M/|Q| < 1`. Another aspect of our conjecture is that it naturally suggests that the `U(1)` effective gauge theory breaks down at a scale `Λ` well below the Planck scale `Λ ~ gM_Pl` (more precisely `Λ ~ √(α/G_N)`), where `g` is the `U(1)` gauge coupling. […]
  > This restriction has a number of phenomenological consequences. It implies that, extrapolating the Standard Model to high energies, there *must* be new scale `Λ` beneath the Planck scale with `Λ ~ √(α_GUT/G_N) ~ 10^{17}` GeV, and that any experimental observation of extremely weak gauge coupling must be accompanied by new ultraviolet physics at scales far beneath the Planck/GUT scales."
- 文献自称的严格程度：**"we show how this conjecture follows from the assumption of finiteness of the number of stable particles"** —— **注意这是「从一个假设推出」，不是无条件证明**。该假设本身是 §3 末的另一条猜想（E20）。
- 文献列出的依赖：[1]、[2]；[3] = Banks–Dine–Fox–Gorbatov, "On the possibility of large axion decay constants," JCAP **0306**, 001 (2003), hep-th/0303252（在同页下文引，见 E17）。
- 备注：**「本猜想 ⟸ 精确稳定粒子数有限」这条推导关系在图里应是一条真正的边**（E20 → sharp conjecture (III)），且原文自称 "we show"。**这是本文里最强的内部逻辑链**。

---

### E4 Fig.1：landscape/swampland 的判据形式 `G_N < g²/m²`

- 位置：**§1, Figure 1, p.3** — **L1**
- 类型：proposition（图示）
- 原文（图内文字 + 图题）**[逐字]**：
  > 图内左上：`G_N < g²/m²  ● ● ●` → 指向标注 `Landscape` 的小岛；
  > 图内左下：`G_N > g²/m²  ● ● ●` → 指向外围标注 `Swampland`；
  > **Figure 1 图题**：「Consistent theories of quantum gravity (the landscape) represent a small portion of the effective field theories (the swampland) where additional conditions such as the weakness of gravity are satisfied.」
- 备注：**`G_N < g²/m²` 是本文判据的第三种写法**（与 `(1)` 的 `m_el ≲ g_el M_Pl` 和 `(19)` 的 `(M/Q) ≲ 1` 等价，因为 `G_N ~ M_Pl^{-2}`）。**图节点若引这个形式，`loc` 写「Figure 1, p.3」。⚠ 图里用的是严格不等号 `<`，正文是 `≲`。**

---

### E5 ★★ `(1)` 电版本：`m_el ≲ g_el M_Pl`

- 位置：**§2.1 Weak electric and magnetic gauge couplings, eq. (1), p.4** — **L1**
- 类型：proposition（猜想，loose 版）
- 原文陈述 **[逐字，含公式]**：
  > "Consider a 4-dimensional theory with gravity and a `U(1)` gauge field with gauge coupling `g`. Naively, the effective theory breaks down near the scale `M_Pl` where gravity becomes strongly coupled, and certainly nothing seems to prevent taking `g` as small as we wish; if anything the effective theory seems to become even more weakly coupled and consistent.
  > **Nonetheless, we claim that for small `g` there is a hidden new ultraviolet scale far beneath the Planck scale. For instance, we claim that there must be a light charged particle with a small mass**
  >
  > `m_el ≲ g_el M_Pl .`   **(1)**
- 文献自称的严格程度：**"we claim"**（两次）。
- 文献列出的依赖：无（这是本文的出发点）。
- 备注（**四点，是任务书直接问到的「`m ≤ q M_Pl` 的精确形式与归一化」的答案的第一半**）：
  1. **原文的电版本是 `(1)`：`m_el ≲ g_el M_Pl`。** 用的是 **`≲`（order-of-magnitude），不是 `≤`**，且**是 `g`（规范耦合），不是 `q`（电荷）**。
  2. **`M_Pl` 在这里显式出现**（§2.1 还没取 `M_Pl = 1`）。
  3. **任务书写的 `m ≤ q M_Pl` 更接近 §2.2 的那句话**（E14：「these particles should have `m < qM_Pl`」，**严格小于**，且用 `q`）**与 §3 的 `(19)`/(I)(II)(III)**（`M_Pl = 1` 单位）。**三处形式不同，见 Q1 的对照表。**
  4. **本文没有给出任何形如 `m ≤ √2 g q M_Pl` 或 `m² ≤ (d−2)/(d−3) g²q²M_Pl^{d-2}` 的带精确系数的形式。** 那些是后来文献的内容，**不在本文里**。

---

### E6 ★ `(2)` 磁版本：`m_mag ≲ g_mag M_Pl ~ (1/g_el) M_Pl`

- 位置：**§2.1, eq. (2), p.4** — **L1**
- 类型：proposition（猜想，loose 版）
- 原文陈述 **[逐字，含公式]**：
  > "This statement should also hold for magnetic monopoles,
  >
  > `m_mag ≲ g_mag M_Pl ~ (1/g_el) M_Pl .`   **(2)**
- 文献自称的严格程度：**"should also hold"** —— 比 `(1)` 的 "we claim" 略弱（是把电版本外推到磁版本）。
- 文献列出的依赖：E5。
- 备注：**磁版本用的是 `g_mag ~ 1/g_el`**（Dirac 型对偶关系，原文只用 `~`，不给系数，也不写 `2π` 之类）。**图节点不得补系数。**

---

### E7 ★ `(3)`–`(4)`：单极子质量的 UV 探针性质 ⇒ 截断 `Λ ≲ g M_Pl`

- 位置：**§2.1, eqs. (3)–(4), p.4** — **L1**
- 类型：proposition（论证）
- 原文陈述 **[逐字，含公式]**：
  > "Note that the monopole masses are a probe of the ultraviolet cutoff of a `U(1)` gauge theory. The monopole has a mass at least of order the energy stored in the magnetic field it generates; this is linearly divergent, and if the theory has cutoff `Λ`, this is of order
  >
  > `m_mag ~ Λ/g²_el`   **(3)**
  >
  > which is indeed parametrically correct in all familiar examples—for the `U(1)` arising in the Higgsing of an `SU(2)`, this is the correct expression for the monopole mass with `Λ → m_W`, while on a lattice with spacing `a`, this is the monopole mass with `Λ → 1/a`. **Therefore, the above constraint on monopole masses tells us that for small `g`, the effective theory must break down at a prematurely low scale**
  >
  > `Λ ≲ gM_Pl .`   **(4)**
- 文献自称的严格程度：`(3)` 用 "at least of order" + "parametrically correct in all familiar examples"；`(4)` 用 "tells us that"。
- 文献列出的依赖：E6（`(2)`）+ `(3)`。
- 备注：**`(4)` 是本文对现象学最有杀伤力的一条**（§1 与 §6 都用它给出 `Λ ~ √(α_GUT/G_N) ~ 10^{17}` GeV）。**推导链是 `(2) + (3) ⇒ (4)`，两步都是量级估计**，图里的 derivation 只能是 `physical-argument`。

---

### E8 §2.1：「gravity is the weakest force」的改写 + SUSY 下的注记

- 位置：§2.1，**p.4** — **L1**
- 类型：proposition（等价表述）
- 原文陈述 **[逐字]**：
  > "This conjecture can be rephrased as the plausible statement that **"gravity is the weakest force"**; if charged particles have `m > gM_Pl`, then the gauge repulsive force between them is overwhelmed by the gravitational attraction—while if there are states with `m ≲ gM_Pl`, then gravity is subdominant. **Of course, in highly supersymmetric systems, all velocity-independent forces vanish in any case, but as we will see, our constraints still apply.**"
- 文献自称的严格程度：「plausible statement」。
- 备注（两点）：
  1. **这是全文对「gravity is the weakest force」这句口号的唯一正式定位**：它是猜想的**改写**（rephrasing），不是猜想本身。
  2. **SUSY 情形的注记很重要**：高超对称系统里速度无关的力全部抵消，所以「引力最弱」的字面物理图像失效，**但不等式仍适用**（BPS 情形是饱和，见 E9）。**图节点 note 应带这句，否则会有人以为 BPS 系统里猜想无内容。**

---

### E9 ★ §2.1：与 BPS 界的关系（"anti-BPS" 的自我更正）

- 位置：§2.1，**p.5** — **L1**
- 类型：proposition（与已知界的关系）
- 原文陈述 **[逐字，整段]**：
  > "Finally, we are familiar with restrictions on the relative magnitudes of masses and charges from BPS bounds, but these have the opposite sign, telling us that `M ≥ Q` in some units. Our bound might appear to be an "*anti*-BPS" bound. **This is not quite accurate. First of all the BPS case is a limiting case of our bound, saturating it. Secondly we are not conjecturing that for a given charge sector all the masses are less than the charge, but that there exist *some* such state.**"
- 文献自称的严格程度：明确的自我限定。
- 备注（**这是全文最重要的一条防误读声明**）：
  1. **BPS 是饱和，不是违反。**
  2. **猜想是「存在某个态满足不等式」，不是「所有态都满足」。** 这一点在 §3 的 (I)(II)(III) 里被精细化（E18）。
  3. **图节点的 statement 必须含存在量词。** 写成「所有带电态满足 `m ≤ qM_Pl`」是实质性错误。

---

### E10 §2.1：跑动耦合在哪个标度取值（原文自陈的模糊处）

- 位置：§2.1 末，**p.5** — **L1**
- 类型：proposition（自陈的不确定处）
- 原文陈述 **[逐字]**：
  > "We have phrased our constraint as one on the strength of `U(1)` gauge couplings. This is a running coupling so we should ask about the scale at which it should be evaluated. For the statement that there exists a light charged particle with mass `m < gM_Pl`, it is natural to use the asymptotic value of `g`, the running coupling evaluated at the mass of the lightest charged particle. But for the statement about the existence of a cutoff `Λ < gM_Pl`, it is clearly most natural to consider the running coupling near the scale `Λ`. Clearly our bound will also apply to non-Abelian gauge theories, that can be Higgsed to `U(1)`'s. In this case, the mass of the `W`'s is `m_W ~ g_el v` where `v` is an appropriate vev, and these particles will satisfy our bound as long as the vevs don't exceed the Planck scale, **a statement not independent of conjecture about the finiteness of the volume of moduli spaces in [1]**."
- 文献自称的严格程度：「it is natural to use」——**原文承认这是一个约定选择，不是推导出来的**。
- 文献列出的依赖：[1] = `vafa-2005`。
- 备注（**两点**）：
  1. ⚠ **这里出现了 `m < gM_Pl` 与 `Λ < gM_Pl`（严格小于），与 `(1)`/`(4)` 的 `≲` 不同。** 又一处关系符不一致。
  2. ★ **末句是本文与 `vafa-2005` 唯一的实质逻辑接触点**：非阿贝尔情形要求 vev 不超 Planck 标度，而这**不独立于** Vafa 的模空间体积有限性猜想。**图里这条边可以画，来源是本句（L1），但仍应标 `inferred: true`**（因为原文只说 "not independent"，没有给出推导方向）。致谢里也逐字有「We thank Jacques Distler for a discussion on the scale-dependence of our loose conjectures.」

---

### E11 ★★ §2.2：黑洞/全局对称性论证（`g → 0` 不能光滑取；`10^{100}` 残余）

- 位置：**§2.2 Black holes and global symmetries, p.5** — **L1**
- 类型：proposition（论证）
- 原文陈述 **[逐字，整段]**：
  > "Why should such a conjecture be true? One motivation has to do with the well-known argument against the existence of global symmetries in quantum gravity. Gauge symmetries are of course legal, but as we take the limit `g → 0`, the symmetry becomes physically indistinguishable from a global symmetry. **Something should stop this from happening, and our conjecture provides an answer. As the gauge coupling goes to zero `g → 0`, the cutoff on the effective theory `Λ → 0` as well, so that the limit `g → 0` can not be taken smoothly.**
  > To see this more concretely, imagine that we have `g ~ 10^{-100}`, and consider a black hole with mass `~ 10M_Pl`. Since the gauge coupling is so tiny, the black hole can have any charge between 0 and `~ 10^{100}`, and still be consistent with the bound for having a black hole solution (`M ≥ QM_Pl`). But if there are no very light charged particles, none of this charge can be radiated away as the black hole Hawking evaporates down to the Planck scale. But then we will have a Planckian black hole labeled by a charge anywhere from 0 to `10^{100}`. **This leads to `10^{100}` Planck scale remnants suffering from the same problems that lead us to conclude quantum gravity shouldn't have global symmetries (see e.g. [4]).**"
- 文献自称的严格程度：「One motivation」+「imagine that」——**这是启发式论证，不是推导**。
- 文献列出的依赖：[4] = L. Susskind, "Trouble for remnants," hep-th/9501106。
- 备注（**两点**）：
  1. ⚠ **这里的极端性条件写作 `M ≥ QM_Pl`**（"still be consistent with the bound for having a black hole solution"）。**这是本文的第一种极端性归一化**，见 Q2。
  2. **「无全局对称性」在本文里是被**引用**的前提（引 [4]），不是本文论证的对象。** 图里若建「量子引力无全局对称性」节点，来源不能是本文。

---

### E12 ★★ §2.2：极端黑洞衰变论证（**任务书问的 `m < qM_Pl` 的逐字出处**）

- 位置：**§2.2, Figure 2 之后, p.6** — **L1**
- 类型：proposition（论证）
- 原文陈述 **[逐字，含 Figure 2 图题]**：
  > **Figure 2 图题**：「An extremal black hole can decay only if there exist particles whose charge exceeds their mass.」
  > （图内三个圆：`M = Q` → 分别指向 `M > Q` 与 `M < Q`）
  >
  > 正文 **[逐字]**：
  > "The difficulties involving remnants are avoided if macroscopic black holes can evaporate all their charge away, and so these states would not be stable. **Since extremal black holes have `M = QM_Pl`, in order for them to be able to decay into elementary particles, these particles should have `m < qM_Pl`.** Our conjecture also naturally follows from Gell-Mann's totalitarian principle ("everything that is not forbidden is compulsory") because there should not exist a large number of exactly stable objects (extremal black holes) whose stability is not protected by any symmetries."
- 文献自称的严格程度：「in order for them to be able to decay … these particles **should have**」——**这是一个必要条件的推导**（若要能衰变则必须如此），逻辑上是干净的一步；但「极端黑洞必须能衰变」本身是猜想（由 remnant 问题与 Gell-Mann 原理动机化）。
- 文献列出的依赖：E11（remnant 论证）。
- 备注（**这是任务书「`m ≤ q M_Pl` 的精确形式」问题的核心答案**）：
  1. **原文这里的形式是 `m < qM_Pl`（严格小于，用 `q` = 粒子电荷，`M_Pl` 显式）**，配套的极端性关系是 **`M = QM_Pl`**。
  2. **它与 `(1)` 的 `m_el ≲ g_el M_Pl` 不是同一个式子**：`(1)` 用规范耦合 `g`，这里用电荷 `q`。两者在「最小电荷 `q ~ g`」的约定下量级相同，**但原文没有写出这个转换**。
  3. **「极端黑洞能衰变」是这条论证的核心前提，且它本身是猜想**（动机是 remnant + Gell-Mann 极权原理）。图里必须把它建成显式依赖。
  4. **Figure 2 的图题给了同一件事的另一种措辞**（"particles whose charge exceeds their mass"），可作为 statement 的辅助引文。

---

### E13 `(5)`：最小荷单极子不应已是黑洞 ⇒ `Λ ≲ g M_Pl`（第二条独立启发式）

- 位置：**§2.2, eq. (5), p.6** — **L1**
- 类型：proposition（论证）
- 原文陈述 **[逐字，含公式]**：
  > "Another heuristic argument leading to same limit on `Λ` is the following. Consider the minimally charged monopole solution in the theory. With a cutoff `Λ`, its mass is of order `M_mon ~ Λ/g²` and its size is of order `R_mon ~ 1/Λ`. **It would be surprising for the *minimally* charged monopole to already be a black hole because the values of all charges carried by a black hole should be macroscopic (and effectively continuous); after all, a black hole is a classical concept. Demanding that this monopole is not black yields**
  >
  > `M_mon/(M²_Pl R_mon) ≲ 1     ⇒     Λ ≲ gM_Pl`   **(5)**
- 文献自称的严格程度：**"Another heuristic argument"** + "It would be surprising for"。
- 文献列出的依赖：E7（`(3)` 的 `M_mon ~ Λ/g²`）。
- 备注：**这是 `(4)` 的第二条独立论证**（第一条是 E7 的 `(2)+(3)`）。**图里 `Λ ≲ gM_Pl` 这条 statement 应挂两条独立 derivation**，这是本项目「一个节点多条推导」的教科书式用例。

---

### E14 §2.3：参数检验清单 `(6)`–`(11)`（杂化、KK、type I、D`p` 膜、移动 D3）

- 位置：**§2.3 Simple parametric checks, eqs. (6)–(11), p.6–p.7** — **L1**
- 类型：proposition（证据）
- 原文陈述 **[逐字，含公式]**：
  > "It is easy to check the conjecture in a few familiar examples. For `U(1)`'s coming from closed heterotic strings compactified to four dimensions, for instance, we have
  >
  > `gM_Pl ~ M_s ,`   **(6)**
  >
  > and there are indeed light charged particles beneath the string scale `M_s`, which also sets the cutoff of the effective theory. In Kaluza-Klein theory, we have
  >
  > `gM_Pl ~ 1/R ;`   **(7)**
  >
  > again there are charged particles at this scale and it also acts as the cutoff of the low-energy 4D effective theory. By `T`-duality, it is easy to see that the same thing will be true for winding number gauge symmetries, too.
  > Next let's consider `U(1)`'s in type I string theories compactified to 4D. Here
  >
  > `gM_Pl ~ M_s/√g_s`   **(8)**
  >
  > and indeed at weak string coupling this is even larger than the string scale. At large coupling, we revert to a heterotic dual. Similarly, we can consider a `U(1)` living on a stack of D`p`-branes. Then
  >
  > `gM_Pl ~ M_s/√(g_s(RM_s)^{(9-p)})`   **(9)**
  >
  > where `R` is a typical radius of the space transverse to the brane. Again, here we could try and violate the bound for `(RM_s) ≪ 1` but then we revert to a `T`-dual description. […] Then, for instance for D3-branes moving in a spacetime with `n` large dimensions we have
  >
  > `m_W/(gM_Pl) ~ √(g_s/(M_sR)^{(n-2)})`   **(10)**
  >
  > so again for `n > 2`, `g_s < 1`, and `R > l_s`, the ratio is smaller than one. The magnetic monopole is a long D-string attached to the brane, so the analogous ratio depends on `1/g` instead and
  >
  > `m_mon/((1/g)M_Pl) ~ √(1/(M_sR)^{(n-2)})`   **(11)**
  >
  > is again satisfied."
- 文献自称的严格程度："It is easy to check"；全部是量级（`~`）关系。
- 备注：**`(10)`/`(11)` 明确指出 `n = 2` 时「parametrically marginal」、`n = 1` 时「look like they might be violated」**（见 E15）。**这是本文自己划出的「判据最可能失效」的位置。**

---

### E15 ★ §2.3：`AdS₅ × X` 情形的 `(12)`–`(13)` 与 large-`N` species problem（两个「可能违反」的方向）

- 位置：**§2.3, eqs. (12)–(13), p.7–p.8** — **L1**
- 类型：proposition（对判据的压力测试）
- 原文陈述 **[逐字，含公式]**：
  > "Things are parametrically marginal for `n = 2`, but look like they might be violated for `n = 1`. As an example, suppose we have an `AdS₅ × X` space, with `L_{AdS}` parametrically larger than the string scale. By the introduction of a "Planck brane" we have a warped compactification down to 4D. Suppose also that we can have some D3-branes in the space with a `U(1)` gauge field living on them. To an effective field theorist, there is no obstacle to imagining that the internal space `X` is small, of order the string scale. But this is in conflict with our conjecture. The `W`'s charged under the `U(1)` correspond to a long string ending on the D3-brane and hence have a mass scaling as `L_{AdS}M_s²`, the `U(1)` gauge coupling is `g²_{YM} = g_s` while `M²_Pl = M_s^8 V_X L_{AdS}/g_s²`. The requirement that
  >
  > `m²_W ≲ g²_{YM}M²_Pl`   **(12)**
  >
  > then implies that
  >
  > `(V_X M_s^5) ≳ g_s(L_{AdS}M_s) .`   **(13)**
  >
  > In other words, the volume of the internal 5D space *must* be as large as `g_sL_{AdS}` in string units. This is certainly true for the familiar `AdS₅ × S⁵` compactifications, where the volume of the `S⁵` scales like `L⁵_{AdS}`. One might try to orbifold the internal `S⁵` to smaller volumes, but there are only 3 `U(1)`'s one might orbifold by, and since the size of the "slices" in the `S⁵` can't get much smaller than `l_s`, this still assures that the volume of `X` is larger than `L²_{AdS}` in Planck units and safely satisfies our bound. **We aren't aware of any examples where `X` can be kept at the string scale with parametrically large `L_{AdS}`.**
  > Finally, let us consider another possible way in which our bound might be parametrically violated. Consider a theory with some cutoff `Λ` but a large `N` number of `U(1)`'s […] If we could somehow Higgs these `U(1)`'s down to the diagonal subgroup, the low-energy coupling `g_{diag}` would be suppressed by `~ 1/√N`, and we can make the coupling very weak. **However, at large `N`, there is also a "species problem"—`N` can't be made parametrically large without making gravity weak [4].** For instance, naively the cycles would have to each occupy a volume of order the string scale, so that the internal volume and hence `M²_Pl` also grows as `N`, and hence `N` cancels out of the combination `g_{diag}M_Pl`. Similar issues were discussed in the "`N`-flation" proposal of [5]."
- 文献自称的严格程度：**"We aren't aware of any examples where…"**（否定式经验证据）；species problem 引 [4]。
- 文献列出的依赖：[4] = Susskind hep-th/9501106；[5] = Dimopoulos–Kachru–McGreevy–Wacker "N-flation" hep-th/0507205。
- 备注：**这两条是原文自己找出的「最有可能构造反例」的方向**，且都以「没找到反例」告终。**图里应把它们写进 `gaps`（而不是写成证据），因为它们是「未被反驳」而非「被验证」。**

---

### E16 ★ `(14)`：`p`-form 推广（本文最一般的形式）

- 位置：**§2.4 Generalizations, eq. (14), p.8–p.9** — **L1**
- 类型：proposition（猜想，一般形式）
- 原文陈述 **[逐字，含公式与 Figure 3 图题]**：
  > "It is natural to generalize our loose conjecture: consider a `p`-form Abelian gauge field in any number of dimensions `D`; then there are electrically and magnetically charged `p − 1` and `D − p − 1` dimensional objects with tensions
  >
  > `T_el ≲ (g²/G_N)^{1/2},      T_mag ≲ (1/(g²G_N))^{1/2},`   **(14)**
  >
  > where the coupling `g` (the charge density) has a dimension of `mass^{p+1−D/2}`. **We have discussed the case `D = 4, p = 1` above. Whenever the objects carry central charges only, the inequalities above are saturated and coincide with the BPS bounds. However, the inequality becomes strict for other types of charges.** This generalization can be used to rule out effective field theories that have been constructed in the literature for a variety of purposes."
  >
  > **Figure 3 图题** **[逐字]**：「For any kind of an electric field, there should exist "self-non-attractive" objects for whom the electric repulsive force exceeds the strength of gravity.」
- 文献自称的严格程度：「It is natural to generalize」。
- 文献列出的依赖：E5、E6。
- 备注（**三点**）：
  1. **`(14)` 是本文最一般的形式**，用 `G_N` 而非 `M_Pl`，用张力 `T` 而非质量 `m`。**注意 `D = 4, p = 1` 才回到 `(1)`/`(2)`。**
  2. **「中心荷情形不等式饱和 = BPS 界」在这里第二次说**（第一次是 E9），且**明确说非中心荷情形不等式是严格的**（"the inequality becomes strict"）。
  3. **Figure 3 的 "self-non-attractive objects" 是本文独有的措辞**，值得作为引文记录。

---

### E17 ★ `(15)`–`(18)`：extranatural inflation 与轴子衰变常数 `S_inst ≲ M_Pl/F`

- 位置：**§2.4, eqs. (15)–(18), p.9–p.10** — **L1**
- 类型：proposition（应用/排除）
- 原文陈述 **[逐字，含公式]**：
  > "For instance, in [6], it was argued that a natural candidate for an inflaton could be found in 5D gauge theories compactified on a circle. Consider a `U(1)` gauge theory with gauge coupling `g₅` and Planck scale `M₅`. Compactifying on a circle, we have 4D gravity as well as the 4D periodic scalar `θ = A₅R` associated with the Wilson line around the circle. The effective action for `θ` and gravity is simply
  >
  > `∫d⁴x√(−g)[F²(∂θ)² + M²_{Pl}R] ,`   **(15)**
  >
  > where
  >
  > `F² = 1/(g₅²R) ,      M²_{Pl} = M₅³R .`   **(16)**
  >
  > At one-loop level, light charged scalars can generate a potential `V(θ) ~ (1/R⁴)cos(θ)`. It is easy to see that `θ` can have slow-roll inflation as long as `F² ≫ M²_{Pl}`, or
  >
  > `g₅²M₅³R² ≪ 1 .`   **(17)**
  >
  > **This is perfectly consistent in effective field theory, but it runs afoul of our general constraint for `D = 5`, `p = 1`. Indeed, straightforward attempts to embed this model into string theory fail.** For instance, for the `U(1)` coming from closed strings, `g₅²M₅³ = M_s²` and so we must have `R ≪ M_s^{-1}`, where this description breaks down and the `T`-dual is appropriate.
  > Indeed, Banks, Dine, Fox, and Gorbatov [3] subsequently studied the more general question of whether in compactifications to 4D it is possible to get periodic scalars ("axions") with decay constants `F` parametrically larger than the Planck scale. In all the examples they studied, they found that either `F` can't be made larger than `M_Pl`, or that if it could, there was also an instanton of anomalously small action `S_inst ~ M_Pl/F`, so the instanton generated unsuppressed potential generated terms up to `cos(Nθ)` with `N ~ M_Pl/F`, ruining the parametric flatness of the potential. **This observation is subsumed in our generalized conjecture; for `D = 4`, `p = 0`, the 0-form is an axion; the "tension" of the object charged under it is simply the action of an instanton coupling to the axion, while the axion gauge coupling is `g ~ 1/F` where `F` is the axion decay constant so our constraint gives precisely**
  >
  > `S_inst ≲ M_Pl/F .`   **(18)**
- 文献自称的严格程度：`(18)` 用 "our constraint gives precisely"（**这是本文里少见的 "precisely"**，但它指的是「与 BDFG 的经验观察吻合」，不是数学精确性）。
- 文献列出的依赖：[6] = Arkani-Hamed–Cheng–Creminelli–Randall, "Extranatural inflation," PRL **90**, 221302 (2003), hep-th/0301218；[3] = Banks–Dine–Fox–Gorbatov, JCAP **0306**, 001 (2003), hep-th/0303252。
- 备注：**`(18)` 是「弱引力猜想的轴子版本」的原始出处**（后来文献常称 axionic WGC）。**图节点若用这个名字，note 须写「此名非原文措辞」。** 本条同时是「猜想排除某类暴胀模型」的最具体实例。

---

### E18 ★★★ §3：`(19)` 与三个 sharp 版本 `(I)(II)(III)` 逐字

- 位置：**§3 Sharpening the claim, eq. (19) 与 (I)(II)(III), p.10** — **L1**
- 类型：proposition（猜想，sharp 版）
- 原文陈述 **[逐字，含公式；`M_Pl = 1` 单位]**：
  > "Working in `M_Pl = 1` units, we are making a conjecture about mass/charge ratios
  >
  > `(M/Q) ≲ 1`   **(19)**
  >
  > To find a sharper conjecture, we have to decide (a) what states should satisfy this bound and (b) what to mean by "1". For the last point, it is natural to take the `(M/Q)` ratio that is equal to one for large extremal black holes. As for the states to consider, there are three natural possibilities:
  >
  > `(I)   (M_{q_min}/q_min) ≤ 1,      for the state of minimal charge;`
  > `(II)  (M_min/q_{M_min}) ≤ 1,      for the lightest charged particle;`
  > `(III) (M/q)_min ≤ 1,             for the state with smallest mass/charge ratio.`
  >
  > **Of course, for these statements to have a sharp meaning, the state must be exactly stable for `M` to be meaningful.** The particle of smallest charge is *not* guaranteed to be stable—for instance, a heavy charged particle of charge `+1` can decay into two lighter charged particles of charge `−2, +3`. If the particles with charges `−2` and `+3` are light, they will form a Kepler/Coulomb bound state of charge `+1`. This state will be stable but its `M/Q` ratio may be larger than for the states with charges `−2` and `+3`. In particular, it may be larger than one."
- 文献自称的严格程度：**"we are making a conjecture"**；`(19)` 用 `≲`，**三个 sharp 版本用 `≤`**。
- 文献列出的依赖：E5–E17（loose 版本）。
- 备注（**四点，全部关键**）：
  1. **「1」的定义是「大极端黑洞的 `(M/Q)` 比值」**（"it is natural to take the `(M/Q)` ratio that is equal to one for large extremal black holes"）。**这就是本文对归一化的全部说明**——**它是相对定义，不给出显式系数。** 见 Q2。
  2. **三个版本的差别只在「对哪个态」下断言**，不在不等式形式。
  3. **「精确稳定」是三个版本有意义的前提**（原文明确），且原文立刻给出「最小荷态未必稳定」的反例（Kepler 束缚态）。
  4. **`(I)` 与 `(II)` 的下标写法在页图上是嵌套下标**（`M_{q_min}`、`q_{M_min}`），转纯文本易错。**curator 引用必须回原页复核。**

---

### E19 ★★★ §3：`(I)` 被作者自己反驳（"So (I) can't be right"）—— **本批唯一真正的 refutation**

- 位置：**§3, p.11** — **L1**
- 类型：proposition（**反驳**）
- 原文陈述 **[逐字，整段]**：
  > "**Furthermore, there are easy counterexamples to the conjecture (I) in string theory, even when the minimally charged particles *are* exactly stable.** For instance, in the weakly coupled `SO(32)` heterotic string, the spinor of `SO(32)` is exactly stable and has minimal half-integral charges under the `U(1)`'s inside the `SO(32)`, but is heavy and can violate our bounds. A generalization of these are the half-integrally charged winding strings considered by Wen and Witten [7], that have fractionally charges but are also heavy. **So (I) can't be right.**"
- 文献自称的严格程度：**"there are easy counterexamples"** + **"So (I) can't be right."** —— **这是作者本人给出的、对一个精确陈述的反驳。**
- 文献列出的依赖：[7] = **X. G. Wen and E. Witten, "Electric And Magnetic Charges In Superstring Models," Nucl. Phys. B 261, 651 (1985)**。
- 备注（**这是本批三篇里最重要的一条，直接满足 ROADMAP Phase 4 的「反例方向」要求**）：
  1. **`(I)` 在图里的 status 应是 `refuted`**，并配一条 `kind: refutation` 的 derivation，来源 `arkani-hamed-2006` §3, p.11。
  2. **反例是双重的**：(a) 弱耦合 `SO(32)` 杂化弦的 `SO(32)` 旋量（精确稳定、最小半整数荷、但很重）；(b) Wen–Witten 的半整数荷缠绕弦。
  3. ⚠ **反例的适用域是满足的**（弦论紧化，有引力，有限 Planck 质量）—— **与 `ooguri-vafa-2006` §3.2 的引力解耦反例性质完全不同**。这是**真反驳**。
  4. ⚠ 原文排印错误：`that have fractionally charges`（应为 fractional）。照抄。
  5. **建议同时把 Wen–Witten NPB 261, 651 (1985) 登记进 `reading-list.md`**——它是本项目图里**第一条 `refuted` 状态节点的证据来源**。

---

### E20 ★★ §3：`(II)` 强于 `(III)`；`(II)` 无反例但证据只支持 `(III)`

- 位置：**§3, p.11** — **L1**
- 类型：proposition（三版本之间的关系）
- 原文陈述 **[逐字，整段]**：
  > "Of course the *lightest* charged particle is exactly stable, as is the particle with smallest `(M/Q)` (as follows trivially from the triangle inequality), so both `(II)` and `(III)` are well-defined conjectures. **Obviously `(II)` is the stronger of the two (and it clearly implies `(III)`) and *forces* the effective theory to contain a light charged particle.** Conjecture `(III)` can in principle be satisfied by a heavy state with large `Q` which would reduce the impact of the inequality on physics at low energies. **Even though we have no counterexamples for conjecture `(II)` most of our evidence only supports the weaker conjecture `(III)`.**"
- 文献自称的严格程度：**"(II) is the stronger of the two (and it clearly implies (III))"** —— **这是一条逻辑蕴含断言**，原文说 "clearly"，理由是「最轻带电粒子的 `M/Q` ≥ 最小 `M/Q`」；**"Even though we have no counterexamples for conjecture (II) most of our evidence only supports the weaker conjecture (III)."**
- 文献列出的依赖：E18。
- 备注（**这是本文对图 status 最精细的一条输入**）：
  1. **`(II) ⇒ (III)` 是一条可以画的边**（原文 "clearly implies"），且这一步是**初等的**（三角不等式 + 定义）。按 `docs/STATUS_LEVELS.md` 的 lead 裁决，reviewer 复核后这条边可标 `rigorous`。
  2. **但两条 statement 的 status 不同**：`(II)` = `conjecture`（无反例但证据不足）、`(III)` = `conjecture`（有证据）。**注意工具的传播规则：如果 `(III)` 由 `(II)` 推出，`(III)` 的 effective 会被 `(II)` 拖低。所以 `(III)` 必须另挂一条独立的 `--via-string-examples` 推导（§4 的杂化弦检验，E22），才能不被拖低。**
  3. **原文明确区分「无反例」与「有证据」**——这正是本项目「status 只能实话实说」原则要的粒度。

---

### E21 ★ §3：违反猜想的谱是什么样（Kepler 塔 ⇒ 无穷多精确稳定态）+ 「精确稳定态数目有限」的一般猜想

- 位置：**§3, p.11–p.12** — **L1**
- 类型：proposition（论证 + 更一般的猜想）
- 原文陈述 **[逐字，两段]**：
  > "It is interesting to see what the spectrum of a theory which violates our conjectures looks like. Suppose for simplicity that there is only one "elementary" particle with minimal charge 1, but with `M > Q`. Since the net force between two of these particles is attractive, there is a Kepler bound state of two of these particles, with charge 2, but with a mass smaller than `2M`, so that the mass/charge ratio decreases. We can continue to add further particles to make further bound states, with `(M/Q)` continually decreasing. This proceeds till the bound state eventually turns into an extremal black holes, and asymptotically, we reach `(M/Q) = 1`. **It is easy to see that *all* of these particles are exactly stable: since `(M/Q)` is a decreasing function of `Q`, none of these states can decay into a collection of particles with smaller charges.**
  > On the other hand, if there are any states with `(M/Q) < 1`, then the macroscopic black holes can always decay, and the number of exactly stable particles will be finite. Suppose that, among the states with `(M/Q) < 1`, the one with smallest charge has charge `Q_min`. Then, by the same argument as above, we expect that the lightest particles with charges smaller than `Q_min` are exactly stable.
  > **So our mass/charge ratio conjecture `(III)` can be seen to follow from a very simple general conjecture valid for both charged and uncharged particles: The number of exactly stable particles in a theory of quantum gravity in asymptotically flat space is finite. Actually this statement is not quite correct.** Clearly we can have an infinite number of exactly stable BPS states, and many of these are safely bound; consider for instance dyons of electric/magnetic charge `(n,1)` for large `n`. **However, the number of exactly stable (and safely bound) states *in any given direction in charge space* is finite.**
  > Even for neutral particles, this implies that the number of massless degrees of freedom is finite, and such a restriction is indeed suggested by the species problem associated with the Bekenstein bound. If there is a principle dictating the number of exactly stable particles to be finite, it is reasonable to expect that in all the vacua in the landscape, the number of exactly stable states is typically of order a few. In this case, the minimal charge `Q_min` for which `(M/Q) < 1` should not be too large, since as we saw above the number of exactly stable states grows with `Q_min`. **This then substantiates our loose conjectures `m ≲ gM_Pl`.**"
- 文献自称的严格程度：**"can be seen to follow from"** —— 是从「精确稳定态数目有限」这条猜想推出 `(III)`；且原文**自己修正了两次**（"Actually this statement is not quite correct" → 加上「in any given direction in charge space」限定）。
- 文献列出的依赖：E18、E20。
- 备注（**三点，对图很有价值**）：
  1. **「精确稳定态数目有限（在电荷空间的任一给定方向上）」是本文提出的一条独立猜想**，且原文说 `(III)` 从它推出。**图里应建成独立 statement 并画边到 `(III)`。**
  2. **BPS 态是这条猜想的显式例外**，原文自己修正了措辞。**图节点必须带「in any given direction in charge space」这个限定，否则陈述是错的（作者自己说 "not quite correct"）。**
  3. **「精确稳定态数目有限」与 `vafa-2005` 的「场数目有限」是同族判据**（本文 §1 逐字说 "This finiteness criterion nicely extends some of the finiteness criteria discussed in [1,2]"，E3）。**这是 swampland 区两条主线唯一的原文级逻辑连接。**
  4. 致谢里逐字有「We thank … Juan Maldacena for clarifying discussion on the number of exactly stable states in quantum gravity.」

---

### E22 ★★ §4：杂化弦 `T⁶` 检验 `(20)`–`(25)`（本文最具体的正面证据）

- 位置：**§4 Evidence for the conjecture, eqs. (20)–(25), p.12–p.14** — **L1**
- 类型：proposition（证据）
- 原文陈述 **[逐字，含公式与 Figure 4 图题]**：
  > "Our conjecture is now phrased sharply enough that we can look for non-trivial checks of it in known stringy backgrounds. Clearly in highly supersymmetric situations where `U(1)`'s are associated with central charges, there will be BPS states saturating our inequality. This will for instance be the case in theories with 32 supercharges. However, already with 16 supercharges non-trivial checks are possible, for instance in compactifications of the heterotic string on tori with generic Wilson lines, where most of the `U(1)`'s are not central charges.
  > Consider for instance the `SO(32)` heterotic string compactified on `T⁶`. At a generic point on moduli space, there is a `U(1)^{28}` gauge symmetry. We will check our conjecture for electric charges only; by `S`-duality, this check will carry over to magnetic charges as well. A general set of electric charges is a 28-dimensional vector
  >
  > `Q = (Q_L / Q_R)`   **(20)**
  >
  > where `Q_L` is 22-dimensional vector and `Q_R` is 6-dimensional vector. The charges are quantized, lying on the 28-dimensional even self-dual lattice with
  >
  > `Q_L² − Q_R² ∈ 2**Z**`   **(21)**
  >
  > Moving around in moduli space corresponds to making `SO(22,6)` Lorentz transformations on the charges."
  >
  > **Figure 4 图题** **[逐字]**：「The charge `M` of the heterotic string states of charge `Q` approaches the `M = Q` line from below. The yellow area denotes the allowed region.」
  > （⚠ 图题首句逐字为 "The charge `M` of the heterotic string states"，**按内容应为 "The mass `M`"**，是原文排印错误。）
  >
  > 续 **[逐字]**：
  > "The extremal black hole solutions in this theory were constructed by Sen [8]. For `Q_R² − Q_L² > 0`, there are BPS black hole solutions with mass
  >
  > `M² = ½Q_R²`   **(22)**
  >
  > where we work in units with `M_Pl = 1`. For `Q_L² − Q_R² > 0`, the black holes are *not* BPS; still, the extremal black holes have mass
  >
  > `M² = ½Q_L² .`   **(23)**
  >
  > We can compare this with the spectrum of perturbative heterotic string states, given by
  >
  > `M² = ½Q_R² + N_R = ½Q_L² + N_L − 1`   **(24)**
  >
  > where `N_{R,L}` are the string oscillator contributions and where we chose units with `α' = 4`. **The `−1`, coming from the tachyon in the left-moving bosonic string, is crucial.** Note that this spectrum nicely explains the BH spectrum of the theory, as the highly excited strings are progenitors of extremal black holes. Consider large `Q_L, Q_R`, with `Q_R² > Q_L²`. Then, the minimal `M²` compatible with these charges will have `N_R = 0`, `N_L = ½(Q_R² − Q_L²) + 1`, which are BPS, with `M² = ½Q_R²`. On the other hand, for `Q_L² > Q_R²`, the minimal `M²` is with `N_L = 0`, and `N_R = ½(Q_L² − Q_R²) − 1`. These are not BPS, but for large `Q_L²`, they have `M² = ½Q_L²`.
  > **But the string spectrum also guarantees that, as we go down to smaller charges along a basis of directions in charge space, we are guaranteed to find a state with a mass/charge ratio smaller than for extremal BH's.** The inequality is saturated for the BPS states which have `Q_R² > Q_L²`, but for `Q_L² > Q_R²` the extremal black holes have `M² = ½Q_L²` while there is always a state with mass
  >
  > `M² = ½Q_R² = ½Q_L² − 1`   **(25)**
  >
  > since there is a charge vector with `Q_L² − Q_R² = 2` on the charge lattice."
- 文献自称的严格程度：**"the string spectrum also guarantees"**、**"we are guaranteed to find"** —— **这是本文最强的正面证据措辞**，且是一个可完全机械验证的格论论证。
- 文献列出的依赖：[8] = **A. Sen, "Black hole solutions in heterotic string theory on a torus," Nucl. Phys. B 440, 421 (1995), hep-th/9411187**。
- 备注（**四点**）：
  1. **[抽取者复算]** 由 `(24)` 取 `N_L = 0`、`Q_L² − Q_R² = 2` 得 `M² = ½Q_R² + N_R` 与 `M² = ½Q_L² − 1 = ½(Q_R² + 2) − 1 = ½Q_R²`，即 `N_R = 0`；与 `(25)` 一致，且比极端黑洞的 `M² = ½Q_L²` 小 `1`。**格论论证自洽。**（此复算原文未显式写出，curator 引用须标 `inferred: true`。）
  2. **`α' = 4` 与 `M_Pl = 1` 两个归一化都必须声明**，否则 `(24)` 的 `−1` 与 `(25)` 的 `−1` 无意义。
  3. **这条证据支持的是 `(III)`（或更准确地说，「在电荷空间的一组基方向上」的版本），不是 `(II)`** —— 与 E20 的自陈一致。
  4. ⚠ **Figure 4 图题把 "mass" 印成 "charge"**，照抄并记为排印错误。

---

### E23 §4.1：规范对称 vs 全局对称的世界面论证（`(26)`–`(27)`，spectral flow）

- 位置：**§4.1 Gauge symmetries vs. global symmetries, eqs. (26)–(27), p.14–p.15** — **L1**
- 类型：proposition（一般化论证）
- 原文陈述 **[逐字，节选，含公式]**：
  > "It is possible to generalize this argument to *any* perturbative heterotic string compactification, including compactifications on `K3` and arbitrary Calabi-Yau threefolds, as a straightforward generalization of the familiar argument that all global symmetries in this theory are gauged. For any integral `U(1)` gauge symmetry coming from the left-movers of heterotic string, there is a worldsheet current `J(z)`. Because it is a `(1,0)` primary field, one can construct the `(1,1)` vertex operator `J(z)∂̄X_μe^{ikX}(z,z̄)` with `k² = 0` for a spacetime gauge field and prove that the corresponding symmetry is a gauge symmetry. […] We can bosonize the current with level `k` as
  >
  > `J(z) ~ √k ∂φ(z) .`   **(26)**
  >
  > Then, the operator
  >
  > `O(z) = :e^{i√kφ(z)}:`   **(27)**
  >
  > is always in the CFT. There are a number of ways to see this. One way is to note that this operator has local OPE with all the operators in the theory. […] Therefore, the completeness of the CFT spectrum (i.e. the statement that the operator content of the theory is maximal consistent with local OPE, as follows from modular invariance) forces us to have `O(z)` as an allowed operator in the theory.
  > Another way to understand the existence of the operator `O(z)` is to note that it corresponds to spectral flow by 1 unit in the `U(1)`. This simply corresponds to changing the boundary conditions on the circle by `exp(2πiθp)` where `p` denotes the `U(1)` charge and `θ` goes from 0 to 1.
  > **We thus see that the state corresponding to `O(z)` exists in the spectrum of CFT. Since by assumption this is a left-mover state, this corresponds to `N_L = 0` and so `M² = ½Q_L² − 1`, while asymptotically, the excited strings correspond to extremal black holes with `M² = ½Q_L²`, so our string state is indeed *sub*-extremal.**"
- 文献自称的严格程度：**"prove that the corresponding symmetry is a gauge symmetry"**（对规范性那一步用 prove）+ **"forces us to have"**（完备性论证）+ **"We thus see that"**。
- 文献列出的依赖：E22；**依赖「模不变性 ⇒ 算子谱完备」这一步**（原文只以括号形式给出，无引用）。
- 备注（**这是本文最技术、也最接近可形式化的一段**）：
  1. **论证链**：左移 `U(1)` 流 `J(z)` → 玻色化 → 谱流算子 `O(z)` 在 CFT 谱中（由模不变性/完备性）→ 它是 `N_L = 0` 的左移态 → `M² = ½Q_L² − 1` < 极端黑洞的 `½Q_L²` → 亚极端。
  2. **它把 §4 的 `T⁶` 特例推广到任意微扰杂化紧化**（含 K3、任意 CY 三折）。**这是本文里覆盖面最广的一条正面证据。**
  3. ⚠ **「模不变性 ⇒ 算子内容最大化」这一步在原文里只有一个括号**，没有引用、没有证明。**图里这条边必须写进 `gaps`。** 这与本项目已有的「OPE 收敛未证」类缺口同型（见 `docs/ROADMAP.md` lead 裁决 2026-09-10）。
  4. **本条依赖 `worldsheet`/`cft` 区的对象**（`(1,0)` 主场、顶点算子、模不变性、玻色化）——**这是 swampland 区与 worldsheet 区之间唯一的技术性连线**。

---

### E24 §5：与亚光速正性约束的可能关系（`(28)`–`(30)`）

- 位置：**§5 Possible relation to subluminal positivity constraints, eqs. (28)–(30), p.15–p.16** — **L1**
- 类型：proposition（推测性关联）
- 原文陈述 **[逐字，节选，含公式]**：
  > "It is natural to conjecture that since there must exist states for which `(M/Q) < 1` while the extremal black holes have `(M/Q) = 1`, the extremal limit for `(M/Q)` for black holes is approached from below, that is, that the leading corrections to the extremal black hole masses from higher-dimension operators should again *decrease* the mass. This implies some positivity constraint on some combination of higher-dimension operators.
  > It is interesting that similar positivity constraints have been discussed in [9] […] For instance, consider the theory of a `U(1)` gauge field in four dimensions. The leading interactions are `F⁴` terms, and the effective Lagrangian is of the form
  >
  > `−F²_{μν} + a(F²)² + b(FF̃)² + ⋯`   **(28)**
  >
  > If the scale suppressing the dimension 8 operators is far beneath the Planck scale, we can ignore gravity, and the claim of [9] is that `a, b` must be positive to avoid superluminal propagation of signals around backgrounds with uniform electric or magnetic fields, and also to satisfy analyticity and dispersion relation for the photon-photon scattering amplitude. […]
  > To first order in `a, b`, we find that for a black hole with electric and magnetic charges `(Q_e, Q_m)` and working with `M_Pl = 1`
  >
  > `M²_{extr} = (Q_e² + Q_m²) − (2a/5)((Q_e² − Q_m²)²/(Q_e² + Q_m²)²) − (32b/5)(Q_e²Q_m²/(Q_e² + Q_m²)²)`   **(29)**
  >
  > So, for purely electric or magnetic black holes, we have
  >
  > `M²_{extr} = Q² − 2a/5`   **(30)**
  >
  > which indeed decreases for the "right" sign of `a > 0`. The same statement holds for the dyonic black holes as long as `b > 0` which is also the "right" sign. The result (29) has, in fact, an `SO(2)` symmetry mixing `Q_e` and `Q_m` for `a = 4b`, much like the stress-energy tensor derived from (28) for the same values `a = 4b`.¹ The effect of other four-derivative terms on the extremal black hole masses will be studied elsewhere [10]."
  >
  > 脚注 1 **[逐字]**：「While our inequality `M_{extr} < |Q|` holds uniformly for `a > 0, b > 0`, we would also be able to satisfy our constraint and find a basis of directions where the inequality holds whenever at least one parameter (`a` or `b`) is positive.」
- 文献自称的严格程度：**"It is natural to conjecture"**、**"we find"**（对 `(29)` 的一阶计算）。
- 文献列出的依赖：[9] = **Adams–Arkani-Hamed–Dubovsky–Nicolis–Rattazzi, "Causality, Analyticity and an IR Obstruction to UV Completion," hep-th/0602178**（⚠ **2006 年 2 月，晚于本文 v1 的 2006-01-01，见 §0.4**）；[10] = **"M. Padi, L. Motl et al., work in progress"**（**未发表，按 `literature/CLAUDE.md` 规则 1 不可登记**）。
- 备注（**三点**）：
  1. **★ 版本警告**：本节的核心引用 [9] 的 arXiv 编号晚于本文 v1，**故本节极可能是 v2 新增**。引 `(28)`–`(30)` 必须写死 v2 并加 note（见 §0.4）。
  2. **`(29)` 是本文唯一一处有显式数值系数的公式**（`2/5`、`32/5`）。**这些系数依赖 `M_Pl = 1` 与 `(28)` 的算子归一化，转引必须同时带这两个约定。**
  3. **脚注 1 是对 `a > 0, b > 0` 条件的弱化**（只需至少一个为正就能在某组基方向上满足），**这与 E22 的「一组基方向」措辞一致**，是本文对 sharp 版本的一贯限定。

---

### E25 ★★ §6：作者对自身猜想强度的最终定性（含「若错应能找到简单反例」）

- 位置：**§6 Discussion, p.16–p.17** — **L1**
- 类型：meta（主张强度记录）
- 原文陈述 **[逐字，整段]**：
  > "In this note, we have argued that there is a simple but powerful constraint on low-energy effective theories containing gravity and `U(1)` gauge fields. An effective field theorist would not see any problem with an arbitrarily weak gauge coupling `g`, but we have argued that in fact there is a hidden ultraviolet scale `Λ ~ gM_Pl`, where the effective field theory breaks down, and that there are light charged particles with mass smaller than `Λ`. While this statement is completely unexpected to an effective field theorist, it resonates nicely with the impossibility of having global symmetries in quantum gravity, and the associated ability for large charged black holes to dissipate their charge in evaporating down to the Planck scale.
  > **The specific forms of our conjecture are sharp, and if they are wrong it should be possible to find simple counter-examples in string theory, though we have not found any. The strongest form is that for the lightest charged particle along the direction of some basis vectors in charge space, the `(M/Q)` ratio is smaller than for extremal black holes. Such an assumption allows all extremal black holes to decay into these states. The weaker statement says that there should exist *some* state with mass/charge ratio smaller than for extremal black holes. In all the examples we have seen, this state has a "reasonably small" charge, so it is light; however, the weaker form allows the possibility that the smallest `M/Q` is realized for some large charge `Q_*` and objects that are "nearly" extremal black holes. While the number of exactly stable states would be finite in this case, it would still be extremely large. If this weaker form of the conjecture is true it is likely that there is some distribution of `Q_*` peaked for charges of order 1, but perhaps with sporadic exceptions at larger `Q_*`.**"
- 文献自称的严格程度：**"we have argued"**（两次）+ **"The specific forms of our conjecture are sharp, and if they are wrong it should be possible to find simple counter-examples in string theory, though we have not found any."**
- 备注（**这一句是 ROADMAP Phase 4「双轨挂载」在本文里的原文授权**）：**作者明确说猜想是可反驳的（falsifiable），且反例应当能在弦论里找到，只是他们没找到。** 图里 `(II)` 与 `(III)` 各应留一个反例分支占位。
  另注意 **"for the lightest charged particle along the direction of some basis vectors in charge space"** —— 这是 `(II)` 的**加限定版**（带「基方向」），比 §3 的 `(II)` 原句更精细。**两处措辞不同，引用须区分。**

---

### E26 §6：现象学推论与对暴胀的两幅图景

- 位置：**§6, p.17–p.18** — **L1**
- 类型：proposition（推论）
- 原文陈述 **[逐字，节选]**：
  > "In particular, if we take the standard model gauge (augmented by SUSY or split SUSY or other particles leading to precision gauge coupling unification), we have perturbative gauge couplings at a very high energy scale, and our conjecture then implies that there *must* be new physics at a scale beneath the Planck scale, given by `Λ ~ √(α/G_N)` which is close to the familiar heterotic string scale `~ 10^{17}` GeV.
  > Our conjecture also offers a new experimental handle on ultraviolet physics, by searching for extremely weak new gauge forces. Indeed, if a new gauge force coupling to, say, `B − L` is discovered, with coupling `g ~ 10^{-15}`, in the current generation sub-millimeter force experiments, we would claim that there must be new physics at an ultraviolet scale `~ gM_Pl ~ ` TeV. […]
  > It would be interesting to investigate whether there is an analogous conjecture in Anti-de-Sitter spaces, since here it can be translated into a statement about the spectrum of operators in the dual CFT **that can perhaps be proved on general grounds.**
  > Finally, it is interesting that the constraint implied by our conjecture seems to at least parametrically exclude apparently natural models for inflation based on periodic scalars with super-Planckian decay constants, which seem perfectly sensible from the point of view of a consistent effective theory. Of course, in the real world we don't need a parametrically large decay constant to get parametrically large numbers of `e`-foldings of inflation—60 `e`-foldings will do. **If the strong form of our conjecture is true, one might be tempted to conclude that there is a sharp obstacle to getting this sort of inflation in quantum gravity. If as is more likely the weaker form is true, then one might say that even though the low-energy theorists' notion of technical naturalness is misleading and such models are non-generic, there might be sporadic examples where they are possible. Clearly these are two very different pictures.** […] **Further exploration of the boundaries between the swampland and the landscape should shed more light on these issues.**"
- 文献自称的依赖：[12] = Arkani-Hamed–Dimopoulos–Dvali, PRD **59**, 086004 (1999), hep-ph/9807344（大额外维）。
- 备注（**两点**）：
  1. **「AdS 里的类似猜想或许能在一般基础上被证明」是原文自己指出的升级路径**（"that can perhaps be proved on general grounds"）。**这是 swampland 区通向 `rigorous` 的作者自陈路线**，且它连到 `holography` 区。
  2. **对暴胀的结论在 strong form 与 weak form 下截然不同，原文明确说「two very different pictures」，并说 weak form「as is more likely」。** 图里若建暴胀排除节点，**必须挂在 `(II)`（strong）上，并在 note 里写明原文认为 weak form 更可能成立**。

---

### E27 参考文献里的未发表材料（不可登记）

- 位置：References，**p.20** — **L1**
- 类型：meta
- 原文陈述 **[逐字]**：
  > "[2] M. Douglas, talk presented at Strings 2005, Toronto, Canada."
  > "[10] M. Padi, L. Motl et al., work in progress."
- 备注：**两条都不可作为 `sources.bib` 条目**（`literature/CLAUDE.md` 规则 1）。只作原文引用内容记录。
  其余参考文献均为已发表/arXiv 可得，可登记。**其中最值得单独抽取的三条**：[7] Wen–Witten NPB 261, 651 (1985)（`(I)` 的反例）、[8] Sen hep-th/9411187（`(22)`/`(23)` 的极端黑洞解）、[9] Adams et al. hep-th/0602178（`(28)` 的正性约束）。

---

## 3. 未核实项清单

本次抽取对**原文本身**的覆盖是完整的（21 页逐页读图，L1）。下列各项是**超出原文之外**、本轮没有核实的东西。

| # | 未核实项 | 影响 | 建议做法 |
|---|---|---|---|
| U1 | **v1（2006-01-01）与 v2（2006-02-21）的差异**。本轮只读 v2 | **§5 与 `(28)`–`(30)` 极可能是 v2 新增**（其引用 [9] = hep-th/0602178 晚于 v1，见 §0.4）；若 §5 是新增，则 `(28)`–`(30)` 的编号在 v1 里不存在或不同 | **所有 `loc` 写死 `v2`**；引 §5 额外加 note。需要时下载 v1 逐节对照 |
| U2 | **是否有期刊发表版**（L0） | 页码体系不同 | `sources.bib` 按 `@misc` + eprint 登记 |
| U3 | **参考文献 [1]–[12] 的内容**，本文件只抄了书目条目 | 「原文说 [8] 构造了极端黑洞解」只是转述 | Wen–Witten [7]、Sen [8]、Adams et al. [9] 最值得单独抽取（见 E27 备注） |
| U4 | **`(29)` 的系数 `2/5`、`32/5` 的独立核对** | 这是本文唯一一处有显式数值系数的公式 | 原文只说 "we find"，无推导步骤。**若图里要用这两个系数，必须另找来源或由 reviewer 独立复算** |
| U5 | **§2.2 的 `M = QM_Pl` 与 §4 的 `M² = ½Q²` 之间的换算** | 影响所有「`m ≤ qM_Pl`」型陈述的精确形式 | **见 Q2。原文没有给出换算。** |
| U6 | **`(I)`/`(II)` 的嵌套下标转录**（`M_{q_min}`、`q_{M_min}`） | 若转录出错，`(I)` 与 `(II)` 会互换 | **curator 引用必须回原页图复核**（PDF 第 11 页） |
| U7 | **E23 的「模不变性 ⇒ 算子谱完备」这一步** | 是 §4.1 一般化论证的关键一环，原文只有一个括号 | 需另找来源；这与本项目已有的 OPE/CFT 公理缺口同型 |
| U8 | **「弱引力猜想」这个名字的最早出处** | 本文没有这个名字（§0.3 第 5 条） | 若图节点要用这个名字，须另找来源并在 note 写明「此名不出自 AMNV 2006」 |

---

## 4. 未解决的疑问

### Q1 — ★★ 「`m ≤ q M_Pl`」在本文里有**四种**不同的写法（任务书直接问的问题）

**逐页统计如下（全部 L1）**：

| # | 位置 | 逐字形式 | 用的量 | 关系符 | 单位 |
|---|---|---|---|---|---|
| 1 | **§2.1, `(1)`, p.4** | `m_el ≲ g_el M_Pl` | 规范**耦合** `g_el` | `≲` | `M_Pl` 显式 |
| 2 | **§2.2, p.6** | `these particles should have m < qM_Pl` | 粒子**电荷** `q` | `<` | `M_Pl` 显式 |
| 3 | **§3, `(19)`, p.10** | `(M/Q) ≲ 1` | 电荷 `Q` | `≲` | **`M_Pl = 1`** |
| 4 | **§3, `(I)(II)(III)`, p.10** | `(M_{q_min}/q_min) ≤ 1` 等三式 | 电荷 `q` | **`≤`** | `M_Pl = 1` |
| （旁） | **Fig.1, p.3** | `G_N < g²/m²` | 耦合 `g` | `<` | `G_N` 显式 |
| （旁） | **§2.4, `(14)`, p.9** | `T_el ≲ (g²/G_N)^{1/2}` | 张力 `T`、耦合 `g` | `≲` | `G_N` 显式 |
| （旁） | **Abstract** | `Λ = gM_Pl` | —— | **`=`** | `M_Pl` 显式 |

**本文没有给出**：
- 任何形如 `m ≤ √2 g q M_Pl`、`m² ≤ 2g²q²M_Pl²`、或含 `(d−2)/(d−3)` 因子的**带精确系数**的形式；
- `g` 与 `q` 之间的显式换算（虽然 `(1)` 与 §2.2 那句在「最小电荷 `~ g`」的意味下量级相同）。

→ **给 curator 的硬性要求**：
1. **图节点写不等式时必须指明是哪一处**，并逐字抄该处的关系符（`≲` / `<` / `≤`）。
2. **loose 版本（`(1)`/`(2)`/`(4)`/`(14)`）与 sharp 版本（`(19)`/(I)(II)(III)）是不同强度的陈述，必须分节点。** 原文自己就分了 §2（loose）与 §3（sharp）。
3. **不得补系数。** 任何带 `√2`、`(d−2)/(d−3)` 的形式都不出自本文。

---

### Q2 — ★★ 极端性归一化在本文内部不统一

- **§2.2, p.5–p.6**：`M ≥ QM_Pl`（黑洞解存在的界）与 `extremal black holes have M = QM_Pl`。
- **§4, `(22)`/`(23)`, p.13**：`M² = ½Q_R²` / `M² = ½Q_L²`（`M_Pl = 1` 单位）。
- **§3, p.10** 的「1」的定义是相对的：「it is natural to take the `(M/Q)` ratio that is equal to one for large extremal black holes」。

**问题**：`M = Q`（§2.2）与 `M² = ½Q²`（§4）**差一个 `√2` 与电荷格的归一化**。原文**没有给出两者的换算**，也没有说 `(19)` 的「1」在 `(22)`/`(23)` 的记号下是什么。

**唯一的自洽读法（抽取者的理解，非原文）**：§3 的「1」是**按定义**取的（即把极端黑洞的比值定义为 1），所以 `(19)` 与 (I)(II)(III) 在任何电荷归一化下都成立；而 §2.2 的 `M = QM_Pl` 与 §4 的 `M² = ½Q²` 分别是两套具体归一化下的实现。

→ **建议**：**必须新建约定卡 `conv.extremality-normalization`**，明确「本项目的 `(M/Q) ≤ 1` 中的 1 = 大极端黑洞的比值（相对定义）」，并在卡上列出本文两处不同的具体实现。**这正是根 CLAUDE.md 原则 6 要求的场合，也是本篇最重要的约定缺口。**

---

### Q3 — 「弱引力猜想」这个名字不在本文里，图节点该怎么命名？

**逐页确认：全文 21 页没有 "Weak Gravity Conjecture" 这个词组。** 原文只有：
- 标题 "Gravity as the Weakest Force"；
- 正文两处加引号的 **"gravity is the weakest force"**（p.2 与 p.4，后者明确说这是猜想的 rephrasing，见 E8）；
- Figure 1 图题里的 "the weakness of gravity"。

→ **建议**：图节点 id 可以用 `swampland.weak-gravity-*`（作为本项目的记号），**但 statement 文本必须用原文措辞，且 note 必须写「'Weak Gravity Conjecture' 这一名称不出自 AMNV 2006」**。这与 `ooguri-vafa-2006` 的「Swampland Distance Conjecture」情形完全同型（见那份记录 E10 备注 1）。

---

### Q4 — `(II) ⇒ (III)` 这一步在图里能标多高？

原文 E20 逐字：「Obviously `(II)` is the stronger of the two (and it **clearly implies** `(III)`)」，理由是括号里的「as follows trivially from the triangle inequality」（那句实际是说最小 `M/Q` 的态精确稳定）。

**问题**：原文把「`(II) ⇒ (III)`」说成 "clearly"，但**没有写出推导**。从定义看：`(II)` 断言最轻带电粒子的 `M/Q ≤ 1`，而 `(III)` 断言最小 `M/Q ≤ 1`；由于最小 `M/Q` ≤ 最轻带电粒子的 `M/Q`，蕴含关系成立。**这一步是一行推理。**

→ **按 `docs/STATUS_LEVELS.md` 的 lead 裁决（2026-09-10）**：前提完整 + 有限步初等推理 + reviewer 独立复核 ⇒ 可标 `rigorous`（推导 `notes` 须写 `reviewer-verified`）。**建议 curator 建这条边并请 reviewer 复核。这可能是 swampland 区第一条 `rigorous` 的边。**

---

### Q5 — `(I)` 被反驳，那 `(19)` 呢？

`(19)`（`(M/Q) ≲ 1`）是**没有指定「对哪个态」**的模糊形式；§3 明确说要「decide (a) what states should satisfy this bound」才能变精确。`(I)` 被反驳（E19），`(II)`/`(III)` 存活。

→ **建议**：**`(19)` 不应作为独立 statement 建节点**（它不是一个精确陈述，原文自己说需要精细化）。若要建，kind 应是 `definition`（判据的模式）而非 `proposition`。**否则会出现「`(19)` 是否被 `(I)` 的反例反驳」这种无法回答的记账问题。**

---

### Q6 — 本文与另两篇的逻辑关系（三篇合并的结论）

| | `vafa-2005` | `ooguri-vafa-2006` | `arkani-hamed-2006` |
|---|---|---|---|
| 判据 | 有限性（体积 / 场数 / 规范秩） | 模空间几何（Conj 0–4） | 引力最弱（`m ≲ gM_Pl`） |
| 编号 | **无**编号公式、**无**编号猜想 | Conj 0–4；公式只有 (1.1)/(3.1) | **公式 (1)–(30) + (I)(II)(III)** |
| 引另两篇 | 把 AMNV 标为 [9] "work in progress" | 引 Vafa [1] 与 AMNV [3] | 引 Vafa [1] |
| 原文级逻辑连接 | —— | 与 AMNV **无**逻辑连接 | §2.1 末：非阿贝尔情形「not independent of conjecture about the finiteness of the volume of moduli spaces in [1]」（E10）；§1：「finiteness criterion nicely extends some of the finiteness criteria in [1,2]」（E3） |

→ **结论**：**三条主线在原文层面是三个并列的判据族。唯一的原文级逻辑连接是 AMNV → Vafa 的两处「有限性」呼应（E3、E10）。** 其余任何连接边都必须标 `inferred: true`。

---

## 5. 给图的建议

> 以下是**建议**，不是改动。researcher 只写 `literature/`，下列节点由 curator 落地。

### 5.1 ★★ 核心结论：本文是本批唯一提供 `refuted` 状态节点的文献

`docs/ROADMAP.md` Phase 4 要求「每条沼泽地猜想双轨挂载（成立方向 / 反例方向）」，`docs/METHODOLOGY.md` 的对照表也写「支持反证 → `status: refuted`，`derivations` 可以是 `kind: refutation`」。

**本文 E19 是本项目至今**（据抽取者所见的 `graph/` 与三份 swampland 抽取记录）**第一个可以真正落地 `status: refuted` + `kind: refutation` 的案例**，且反驳者是**作者本人**：

> "there are easy counterexamples to the conjecture (I) in string theory … **So (I) can't be right.**"

**这与 `ooguri-vafa-2006` §3.2 的「引力解耦反例」性质完全不同**（那些反例的前提不满足猜想适用域，不构成反驳）。**`(I)` 的反例发生在猜想适用域内（弦论紧化、有引力），是真反驳。**

### 5.2 建议的节点集合

**（a）定义与约定层**

| 建议 id | kind | 内容 | loc（v2） | 抽取条目 |
|---|---|---|---|---|
| `conv.extremality-normalization` | convention | 「1」= 大极端黑洞的 `(M/Q)` 比值（相对定义）；列出本文两处具体实现 `M = QM_Pl` 与 `M² = ½Q²` | `§3, p.10`；`§2.2, p.6`；`§4, (22)(23), p.13` | **E18、E11、E22**、**Q2** |
| `swampland.weak-gravity-loose-form` | definition 或 proposition | 判据的模式：`(M/Q) ≲ 1`（未指定对哪个态） | `§3, eq. (19), p.10` | **E18**、**Q5** |

**（b）loose 版本层（§2）**

| 建议 id | kind | status | 内容 | loc | 抽取条目 |
|---|---|---|---|---|---|
| `swampland.wgc-electric-loose` | proposition | `conjecture` | `m_el ≲ g_el M_Pl` | `§2.1, eq. (1), p.4` | **E5** |
| `swampland.wgc-magnetic-loose` | proposition | `conjecture` | `m_mag ≲ g_mag M_Pl ~ (1/g_el)M_Pl` | `§2.1, eq. (2), p.4` | **E6** |
| `swampland.u1-cutoff-scale` | proposition | `physical-argument` | `Λ ≲ gM_Pl`（**两条独立论证**） | `§2.1, eqs. (3)–(4), p.4`；`§2.2, eq. (5), p.6` | **E7、E13** |
| `swampland.wgc-pform-generalization` | proposition | `conjecture` | `T_el ≲ (g²/G_N)^{1/2}`，`T_mag ≲ (1/(g²G_N))^{1/2}`，`g` 量纲 `mass^{p+1−D/2}` | `§2.4, eq. (14), p.9` | **E16** |
| `swampland.axionic-wgc` | proposition | `conjecture` | `S_inst ≲ M_Pl/F`（`D=4, p=0`） | `§2.4, eq. (18), p.10` | **E17** |

**（c）sharp 版本层（§3）—— 三卡，status 各不相同**

| 建议 id | kind | **status** | 内容 | loc | 抽取条目 |
|---|---|---|---|---|---|
| `swampland.wgc-sharp-minimal-charge` | proposition | **`refuted`** | `(M_{q_min}/q_min) ≤ 1`（最小荷态） | `§3, (I), p.10` | **E18、E19** |
| `swampland.wgc-sharp-lightest-charged` | proposition | `conjecture` | `(M_min/q_{M_min}) ≤ 1`（最轻带电粒子） | `§3, (II), p.10` | **E18、E20** |
| `swampland.wgc-sharp-smallest-ratio` | proposition | `conjecture` | `(M/q)_min ≤ 1`（最小质荷比态） | `§3, (III), p.10` | **E18、E20** |
| `swampland.finite-exactly-stable-states` | proposition | `conjecture` | 精确稳定（且安全束缚）态数目在电荷空间**任一给定方向**上有限；**BPS 是例外** | `§3, p.12` | **E21** |

**（d）★ 推导层：双轨布局**

```
〈成立方向〉

swampland.wgc-sharp-smallest-ratio            status: conjecture
  --via-heterotic-t6-lattice     kind: physical-argument   status: physical-argument
      depends_on: 〈Sen 的极端黑洞解 (22)(23)〉, 〈杂化弦谱 (24)〉,
                  〈偶自对偶电荷格 (21)〉, conv.extremality-normalization
      sources: arkani-hamed-2006, loc "§4, eqs. (20)–(25), p.12–14（v2）"
      summary: 原文逐字「the string spectrum also guarantees … we are guaranteed to
               find a state with a mass/charge ratio smaller than for extremal BH's」
      notes: 抽取者已复算 (24)+(21) ⇒ (25) 自洽，见本文件 E22 备注 1（复算原文未显式写出，标 inferred: true）
      gaps: ["Sen hep-th/9411187 的极端黑洞解未独立抽取（U3）",
             "α' = 4 与 M_Pl = 1 两套归一化必须同时声明"]

  --via-worldsheet-spectral-flow kind: physical-argument   status: physical-argument
      sources: arkani-hamed-2006, loc "§4.1, eqs. (26)–(27), p.14–15（v2）"
      summary: 左移 U(1) 流玻色化 ⇒ 谱流算子 O(z) 在谱中 ⇒ N_L = 0 ⇒ 亚极端；
               覆盖任意微扰杂化紧化（含 K3、任意 CY 三折）
      gaps: ["「模不变性 ⇒ 算子谱完备」在原文只有一个括号，无引用无证明（U7）",
             "依赖 cft 区尚未建立的顶点算子/模不变性节点"]

  --via-finiteness-of-stable-states  kind: conjecture-support  status: conjecture
      depends_on: swampland.finite-exactly-stable-states
      sources: arkani-hamed-2006, loc "§3, p.11–12（v2）"
      summary: 原文逐字「can be seen to follow from a very simple general conjecture」
      ⚠ 这条边使 (III) 的 effective 被 finite-stable-states 拖低；
        上面两条 string-example 边是它不被拖低的原因（工具取最强推导）

swampland.wgc-sharp-lightest-charged (II)     status: conjecture
  → 到 (III) 的边：
  swampland.wgc-sharp-smallest-ratio--via-implication-from-ii
      kind: proof    status: rigorous（候选，须 reviewer 复核，见 Q4）
      sources: arkani-hamed-2006, loc "§3, p.11（逐字 'clearly implies'）"
      notes: reviewer-verified: <待填>
  ⚠ (II) 自身只有「无反例」而无正面证据（E20 逐字），
     故 (II) 的 status 是 conjecture，且其 gaps 必须写
     「原文自陈 most of our evidence only supports the weaker conjecture (III)」

〈反例方向 —— 本批唯一的真反驳〉

swampland.wgc-sharp-minimal-charge (I)        status: refuted
  --via-so32-spinor-counterexample   kind: refutation   status: physical-argument
      sources: arkani-hamed-2006, loc "§3, p.11（v2，逐字 'So (I) can't be right.'）"
      summary: 弱耦合 SO(32) 杂化弦的 SO(32) 旋量精确稳定、最小半整数荷、但很重；
               Wen–Witten 的半整数荷缠绕弦同型
      depends_on: 〈Wen–Witten NPB 261, 651 (1985)〉  ← 建议登记并抽取
      gaps: ["Wen–Witten 正文未抽取（U3）",
             "「重到足以违反界」的定量估计原文未给出"]

〈为 (II)/(III) 留反例分支占位〉
  原文 §6 逐字：「if they are wrong it should be possible to find simple
  counter-examples in string theory, though we have not found any.」（E25）
  → 在 (II)/(III) 的 statement notes 里写明「反例方向：作者明确认为可反驳，
    截至 2006 年 v2 未找到反例」，暂不建 derivation 文件。
```

**★ 记账红线**：§2.3 的 `AdS₅ × X` 与 large-`N` 两个「可能违反」的方向（E15）**是「未找到反例」而非「验证成功」**，应进 `gaps`，**不得**作为 `conjecture-support` 的 sources。

### 5.3 原文自列的假设与缺口（建议全部进 `gaps`）

1. **loose 版本全部是量级估计**（`≲`、`~`）—— E5–E7、E16。
2. **BPS 是饱和不是违反；猜想是「存在某个态」不是「所有态」** —— E9、E16。
3. **跑动耦合在哪个标度取值是约定选择** —— E10（"it is natural to use"）。
4. **`(I)` 已被作者自己反驳** —— E19。
5. **`(II)` 无反例但证据只支持 `(III)`** —— E20。
6. **「精确稳定态数目有限」需加「在电荷空间任一给定方向上」限定，否则作者自陈 "not quite correct"（BPS 例外）** —— E21。
7. **`n = 2` 时判据「parametrically marginal」，`n = 1` 时「look like they might be violated」** —— E14、E15。
8. **`AdS₅ × X` 与 large-`N` 两个压力测试只到「we aren't aware of any examples」** —— E15。
9. **「模不变性 ⇒ 算子谱完备」无引用无证明** —— E23、U7。
10. **`(29)` 的系数无推导** —— E24、U4。
11. **§5 可能不在 v1 中** —— §0.4、U1。
12. **strong form 与 weak form 对暴胀给出「two very different pictures」，且原文认为 weak form 更可能** —— E26。

### 5.4 **不得**挂到 `arkani-hamed-2006` 的东西（红线清单）

| 内容 | 为什么不行 | 正确出处 / 处理 |
|---|---|---|
| 「Weak Gravity Conjecture」这个名字 | **全文 21 页没有这个词组**（§0.3 第 5 条） | node note 须写「此名不出自本文」（Q3） |
| 带精确系数的形式（`√2`、`(d−2)/(d−3)` 等） | **本文完全没有**；本文只有 `≲`/`≤`/`<` 与相对归一化的「1」 | 见 Q1、Q2 |
| 把 `(1)` 与 §2.2 的 `m < qM_Pl` 当成同一个式子 | 一个用规范耦合 `g`、一个用电荷 `q`，原文没给换算 | 见 Q1 |
| 把 loose 与 sharp 混成一个节点 | 原文自己分 §2 / §3，且 sharp 有三个互不等价的版本 | 见 §5.2 |
| 「AMNV 证明了弱引力猜想」类表述 | 摘要与 §6 一律 "conjecture"/"we have argued" | E1、E25 |
| 「量子引力无全局对称性」作为本文结论 | 本文**引用**它（[4] Susskind）作前提，不论证它 | E11；来源应是 Susskind hep-th/9501106 |
| 「极端黑洞必须能衰变」当成已知事实 | 本文把它作为猜想的动机（remnant + Gell-Mann 原理） | E12 |
| de Sitter 猜想 / 暗能量约束 | **本文完全没有** | 本批三篇都没有 |
| 距离猜想 / 无穷塔轻态 / 模空间曲率 | **本文完全没有** | `ooguri-vafa-2006` |
| 参考文献 [2]（Douglas 讲座）与 [10]（work in progress） | `literature/CLAUDE.md` 规则 1 | 只作原文引用内容记录（E27） |
| 引 `(28)`–`(30)` 而不写版本 | §5 可能是 v2 新增（§0.4） | 必须写死 `v2` + note |

### 5.5 建议同时更新的既有文件

- `literature/sources.bib`：新增 `arkani-hamed-2006`（`@misc` + eprint；note 写死「loc 依 arXiv **v2**」、「§5 可能是 v2 新增」、「全文无 'Weak Gravity Conjecture' 一词」、「`(I)` 被作者自己反驳」、「极端性归一化文内不统一」）。**本轮已加。**
- `literature/reading-list.md`：加一行 `extracted`。**本轮已加。**
- **建议新增 reading-list 条目（三条，按价值排序）**：
  1. **Wen–Witten, "Electric And Magnetic Charges In Superstring Models," Nucl. Phys. B 261, 651 (1985)** —— 图里第一条 `refuted` 节点的证据来源（E19）。
  2. **Sen, "Black hole solutions in heterotic string theory on a torus," Nucl. Phys. B 440, 421 (1995), hep-th/9411187** —— `(22)`/`(23)` 的极端黑洞解，是 §4 全部正面证据的基础。
  3. **Susskind, "Trouble for remnants," hep-th/9501106** —— §2.2 remnant 论证与「无全局对称性」的来源（E11）。
  **本轮已加这三条。**

---
