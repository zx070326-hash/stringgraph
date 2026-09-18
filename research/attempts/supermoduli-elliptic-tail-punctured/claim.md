# Claim — 椭圆尾粘接的带穿孔推广：紧化超模叠 $\overline{\mathfrak S}_{g,n,2r}$ 的非投影性

**状态**：draft。本文件只写**要证的精确命题**（含全部前提、记号来源、量词），证明见 `proof.md`。
**Prior-art 前提**：见 `prior-art.md`——「椭圆尾粘接 + 穿孔 + 紧化」象限在 2026-09-18 的检索范围内
公开文献零覆盖；**CN 论文没有 outlook 一节，未预告穿孔情形**。

---

## §0 记号、对象、与所用的外部输入（逐条给出严格程度）

### §0.1 对象

| 记号 | 含义 | 来源 |
|---|---|---|
| $\overline{\mathfrak S}_{g;n,2r}$ | 亏格 $g$、$n$ 个 NS 穿孔、$2r$ 个 Ramond 穿孔的**稳定超曲线**紧化超模叠（光滑固有 DM 超叠） | FKP-A Theorem A |
| $\mathfrak S_{g;n,2r}$ | 其中光滑超曲线的开子叠（未紧化） | 同上 |
| $\overline S_{g;n,2r}$ | 亏格 $g$、$n$ 个 NS 穿孔、$2r$ 个 Ramond 穿孔的**稳定自旋曲线**模叠（光滑固有 DM 叠） | FKP-A §2.6（引 Jarvis） |
| $\overline{\mathfrak S}{}^{\varepsilon}_{g;n,0}$ | $r=0$ 时按宇称 $\varepsilon\in\{+,-\}$ 分开的分量 | 宇称在 $L^{\otimes2}\cong\omega_C$ 情形是局部常值（Mumford） |
| $\omega_2(\mathfrak X)\in H^1(X,\ \mathcal T_X\otimes\Lambda^2\mathcal T_-^\vee\mathfrak X)$ | Green 第一障碍类，$X=\mathfrak X_{\rm bos}$ | CN Proposition 2.2 |
| $\mathfrak X$ **非投影** | 不存在超叠态射 $\mathfrak X\to X$ 逆于 $X\hookrightarrow\mathfrak X$ | 标准；$\omega_2\neq0\Rightarrow$ 非投影（CN Prop 2.2） |

**广义自旋结构的约定（逐字来自 FKP-A §2.6，本轮亲自读取）**：

> "A generalized spin structure $L$ over a smooth curve $C$ with punctures is a line bundle $L$
> equipped with an isomorphism $L^2\cong\omega_C(r_1+\dots+r_n)$, where $(r_i)$ are the Ramond
> punctures."

**⚠ 注意：NS 穿孔不扭转 $\omega_C$，只有 Ramond 穿孔扭转。** 这条在下面的宇称计算里是关键。

### §0.2 外部输入清单（本证明把它们当作已知砖块，逐条标严格程度）

| # | 输入 | 出处 | 严格程度 | 备注 |
|---|---|---|---|---|
| I1 | Green 第一障碍类的存在性、étale 下降、$\omega_2\neq0\Rightarrow$ 非投影 | CN Proposition 2.2 | **rigorous**（图卡 `math.supermoduli-compactified-genus-geq3-not-projected` 所属论文） | |
| I2 | 障碍类沿**任意**态射的函子性：$j_f(\omega_2(\mathfrak Y))=\iota_f(\omega_2(\mathfrak X))$ | CN Lemma 2.6（= DW [7, Cor. 2.10, 2.12] 的叠版本） | **rigorous** | |
| I3 | Donagi–Witten 一点障碍族 $X_\eta$，$\omega_2(X_\eta)=\eta$ | DW 2013 [Prop. 3.4]，经 CN §5 逐字回顾 | **rigorous**（图卡 `math.supermoduli-space-not-projected`） | |
| I4 | $\overline{\mathfrak S}_{g;n,2r}$ 存在、光滑、固有 | FKP-A Theorem A | rigorous（已发表 Amer. J. Math. 145 (2023)）🟡 **未登记入 `literature/sources.bib`**，见 `[GAP-LIT]` | |
| I5 | NS 粘接态射 (7.8)（**带任意穿孔**）：$\overline{\mathfrak S}_{g_1;m_1+1,n_1}\times\overline{\mathfrak S}_{g_2;m_2+1,n_2}\to\overline{\mathfrak S}_{g_1+g_2;m_1+m_2,n_1+n_2}$，及 Lemma 7.10（切层面余维 $1|0$ 嵌入、像 $=\Delta_{\rm NS}$） | FKP-A Lemma 7.9/7.10 | 同 I4 | |
| I6 | 法丛公式 $\mathcal O(\Delta)|_B\cong\Psi_1^{-1}\otimes\Psi_2^{-1}$，对 (7.8)/(7.9) **两者**成立 | FKP-A Theorem C + 式 (9.6)，§9.1 | 同 I4 | |
| I7 | 偶基上 $\Psi_i^{-1}\cong p_i^*L^{-1}$ | FKP-A Example 8.9 | 同 I4 | 本证明**只在无穿孔的亏格 $h$ 侧**使用它 |
| I8 | $h\ge2$ 的光滑曲线上存在**无效偶** theta 特征 | Mumford；Cornalba（CN §5 引） | 标准，rigorous | |
| I9 | 仿射曲线上凝聚层 $H^1=0$ | Serre | 标准，rigorous | 只用于 §3 的**负面结论** |

🔴 **红色标记（依纪律必须写明）**：
> 本轮的**主结论完全不使用** `math.supermoduli-ns-ramond-punctures-not-projected`（Wang，图中
> status = **`physical-argument`**，论文自陈 "preliminary draft"），**也不使用**
> `math.supermoduli-ramond-punctures-not-projected`（Donagi–Ott）。因此本轮结论
> **不继承任何 `physical-argument` 天花板**。这与上一轮 `supermoduli-compactified-punctured`
> 的推论 C 处境完全不同——那条推论的天花板被 Wang 锁死在 `physical-argument`，而本轮的命题 B
> 覆盖它的全部量词范围且状态更高（补齐 `[GAP-LIT]` 后应为 `rigorous`）。

🟡 **不使用的猜想（刻意的设计约束，必须写明）**：
> FKP-A §9.3 把 Theorem C 的 **Ramond 节点类比**只写成**猜想**（原文逐字："We conjecture that the
> following diagram is commutative (up to a sign)"）。**本证明因此只在 NS 节点处粘接，绝不在
> Ramond 节点处粘接**，从而完全避开这条猜想。这是一条本可以走、但会把结论压到 `conjecture` 的捷径，
> 本轮明确拒绝走它。

---

## §1 构造的参数空间（命题的前提就是这组不等式）

固定四个整数
$$h\ \ (\text{亏格 }h\text{ 的"运动分量"}),\qquad a\ \ (\text{固定尾的亏格}),\qquad n\ge0,\qquad r\ge0,$$
并令 $g:=h+a$。要求：

$$\boxed{\ \textbf{(P1)}\ \ h\ge 2\ }\qquad\qquad \boxed{\ \textbf{(P2)}\ \ 2a-2+(n+1)+2r>0\ }$$

- **(P1)** 是 CN Corollary 7.2 的技术门槛（$h^1(C,L^{-1})=2h-2\ge2$），见 `proof.md` §4.5；
- **(P2)** 是**固定尾**（亏格 $a$，带 $n+1$ 个 NS 穿孔——其中 $1$ 个被粘接消耗——与 $2r$ 个 Ramond
  穿孔）作为带标记光滑曲线的稳定性条件。

(P2) 展开即：$a\ge1$ 时恒成立；$a=0$ 时等价于 $n+2r\ge2$。

## §2 主定理（精确到量词）

> **定理 M（带穿孔的固定尾 NS 粘接定理）。**
> 设整数 $h,a,n,r$ 满足 **(P1)**、**(P2)**，令 $g=h+a$。则
> $$\omega_2\big(\overline{\mathfrak S}_{g;n,2r}\big)\neq 0 ,$$
> 从而 $\overline{\mathfrak S}_{g;n,2r}$ **非投影**（特别地非分裂）。
>
> 更精确地：设 $C$ 是亏格 $h$ 的光滑曲线，$L$ 是其上一个**无效偶** theta 特征
> （$L^{\otimes2}\cong\omega_C$，$H^0(C,L)=0$），$\xi=(F,N;q,y_1,\dots,y_n;\rho_1,\dots,\rho_{2r})$
> 是一条固定的亏格 $a$ 光滑稳定自旋曲线，带 $n+1$ 个 NS 标记点（$q$ 为粘接点）与 $2r$ 个 Ramond
> 标记点，$N^{\otimes2}\cong\omega_F(\rho_1+\dots+\rho_{2r})$。则存在
> $\eta\in H^1(C,L^{-1})$ 使得沿测试态射
> $$F_{\eta,\xi}\colon X_\eta\longrightarrow \overline{\mathfrak S}_{g;n,2r}$$
> 有 $\iota_{F}\big(\omega_2(\overline{\mathfrak S}_{g;n,2r})\big)=J(\eta)\neq0$，
> 其中 $X_\eta$ 是 $\eta$ 的 Donagi–Witten 一点障碍族。
>
> **宇称加细（仅当 $r=0$）**：此时被测试曲线落在宇称分量
> $\overline{\mathfrak S}{}^{\varepsilon}_{g;n,0}$ 中，$\varepsilon=\mathrm{par}(N)$，故
> $\omega_2\big(\overline{\mathfrak S}{}^{\varepsilon}_{g;n,0}\big)\neq0$。

## §3 推论：门槛（把 (P1)(P2) 翻译成 $(g,n,r)$ 的条件）

消去 $h=g-a$ 与 $a\in\{0,1\}$（$a\ge2$ 不给出更低门槛，见 `proof.md` §5.3），得：

> **推论 A（纯 NS 穿孔，$r=0$）。**
> **(A1)** 对一切 $g\ge3$、一切 $n\ge0$、**两种宇称** $\varepsilon\in\{+,-\}$：
> $\overline{\mathfrak S}{}^{\varepsilon}_{g;n,0}$ 非投影。 *(取 $a=1$，$h=g-1\ge2$)*
> **(A2)** 对一切 $g\ge2$、一切 $n\ge2$，**偶宇称**：
> $\overline{\mathfrak S}{}^{+}_{g;n,0}$ 非投影。 *(取 $a=0$，$h=g\ge2$)*

> **推论 B（含 Ramond 穿孔，$r\ge1$）。**
> 对一切 $g\ge2$、一切 $n\ge0$、一切 $r\ge1$：
> $\overline{\mathfrak S}_{g;n,2r}$ 非投影。 *(取 $a=0$，$h=g\ge2$；(P2) 因 $2r\ge2$ 自动成立)*
> 对一切 $g\ge3$、$n\ge0$、$r\ge0$ 亦非投影 *(取 $a=1$)*。

**合并成一条**：

$$\boxed{\ \overline{\mathfrak S}_{g;n,2r}\ \text{非投影，只要}\quad g\ge3,\ \ \text{或}\ \ \big(g=2\ \text{且}\ n+2r\ge2\big).\ }$$

## §4 与种子界的逐格对照（本轮的价值判定标准）

"种子界"指上一轮 `supermoduli-compactified-punctured` 用**紧化提升引理**把已发表的未紧化结果
搬进紧化范畴所能达到的范围（该轮 §6 自检已诚实承认：只能达到种子本身的门槛）。

### §4.1 纯 NS 穿孔

| 范围 | 上一轮（提升 DW） | CN 2026 | **本轮** | 是否新 |
|---|---|---|---|---|
| $g\ge3,\ n=0$，两宇称 | $g\ge5$ | ✅ $g\ge3$ | ✅ $g\ge3$ | ❌ 重现 CN（一致性检验） |
| $g\ge2,\ n=1$，偶 | ✅ (DW Thm 1.2) | — | $g\ge3$ ✅ | 部分：$g=2,n=1$ **本轮不覆盖** |
| $g\ge3,\ 1\le n\le g-1$ | ✅（部分宇称） | — | ✅ **两种宇称** | 宇称范围扩大 |
| $\boxed{n\ge g}$（任意大的 $n$） | ❌ **DW 的 $n\le g-1$ 限制挡死** | — | ✅ $g\ge3$ 全覆盖 | ⭐ **全新** |
| $g=2,\ n\ge2$，偶 | ❌（$n\le g-1=1$） | — | ✅ | ⭐ **全新** |

⭐ **本轮的实质突破：DW 的穿孔数限制 $n\le g-1$ 被完全去掉。** 概念上的原因一句话：
**穿孔可以"付钱"给尾巴的稳定性**——CN 必须用椭圆尾（$a=1$）是因为无穿孔时有理尾不稳定；
一旦允许穿孔，有理尾（$a=0$）就稳定了，于是省下一个亏格。

### §4.2 含 Ramond 穿孔

| 范围 | 上一轮推论 B（提升 Donagi–Ott） | 上一轮推论 C（提升 Wang）🔴 | **本轮推论 B** |
|---|---|---|---|
| $n=0,\ r=1$ | $g\ge6$ | $g\ge8$ 🔴 | ✅ $g\ge2$ |
| $n=0,\ r=2$ | $g\ge11$ | $g\ge13$ 🔴 | ✅ $g\ge2$ |
| $n=0,\ r=5$ | $g\ge26$ | $g\ge28$ 🔴 | ✅ $g\ge2$ |
| $n\ge1,\ r\ge1$ | ❌ 完全不覆盖 | $g\ge n+5r+3$ 🔴 | ✅ $g\ge2$，任意 $n$ |
| status 天花板 | rigorous | 🔴 **physical-argument** | **rigorous**（补齐 `[GAP-LIT]` 后） |

⭐ **本轮推论 B 严格包含上一轮推论 B 与推论 C 的全部量词范围，且把 Wang 带来的
`physical-argument` 天花板一并去掉**——这是图上一个从 `physical-argument` 升到 `rigorous` 的净增益。

### §4.3 本轮**不覆盖**的范围（明确声明，避免过度推广）

- $(g,n,r)=(2,1,0)$：DW/上一轮覆盖（偶宇称），本轮**不覆盖**（(P2) 要求 $n+2r\ge2$）。
  故本轮与上一轮**互不包含**，只是本轮宽得多。
- $(g,n,r)=(2,n,0)$ 的**奇**宇称分量（$n\ge1$）：本轮不覆盖（有理尾的自旋结构 $\mathcal O(-1)$
  必为偶）。**这是一个必要的一致性特征而不是缺陷**：CN Theorem 1.1(1) 证明了
  $\overline{\mathfrak M}{}^{-}_2$ 是**分裂的**，若本方法能碰到 $g=2$ 奇分量就会出矛盾；
  见 `proof.md` §6.2 的自洽性检验。
- $g=1,0$：$h\ge2$ 排除，不断言。
- **未紧化**的 $\mathfrak S_{g;n,2r}$：本轮**不断言任何事**。障碍类是在**边界测试曲线**上检测到的，
  与光滑轨迹的投影性无逻辑关系（正如 CN 的 $g\ge3$ 与 DW 的 $g\ge5$ 之间没有矛盾）。
- "分裂/投影"正面方向：完全不断言。

## §5 同时要证的**负面命题**（与正面结论同等重要，不得写软）

任务书要求：若椭圆尾在穿孔情形有本质障碍，必须精确写下来。本轮找到了一个，且它恰好**解释了为什么
必须把穿孔装到固定尾上**：

> **命题 N（朴素推广失败）。** 设 $n\ge1$。把 $n$ 个旁观 NS 穿孔装在**运动的亏格 $h$ 分量**上
> （即把 CN 的 $\mathfrak M^+_{h,1}$ 换成 $\mathfrak M^+_{h,n+1}$，其中 $n$ 个点固定、第 $n+1$ 个
> 点运动）。则 Donagi–Witten 测试族的约化空间变成
> $$C^\circ:=C\smallsetminus\{p_1,\dots,p_n\},$$
> 这是**仿射**曲线，于是对任何凝聚层 $\mathcal F$ 有 $H^1(C^\circ,\mathcal F)=0$；特别地
> $H^1(C^\circ,L^{-1})=0$，可用的障碍参数 $\eta$ 只有 $0$，映射 $J$ **恒等于零**。
> **该路线给不出任何信息。**
>
> **推论 N′。** 同一个仿射性障碍也杀死 FKP 的**非分离**粘接态射 (7.9)
> $\overline{\mathfrak S}_{g;m+2,n}\to\overline{\mathfrak S}_{g+1;m,n}$ 作为本方法的载体：
> (7.9) 要求两个被粘的 NS 穿孔在**同一条**曲线上，若其中之一是运动点，另一个就是 $C$ 上的固定点，
> 测试基仍是仿射的 $C\smallsetminus\{q\}$。
>
> **⚠ 命题 N 不断言 $\overline{\mathfrak S}_{g;n,2r}$ 是投影的**，只断言**这一族测试曲线检测不到
> 任何东西**。这是方法的局限，不是几何的结论。

命题 N 是本轮的第二个交付物：它把"为什么必须用分离粘接 + 常值尾"从"CN 碰巧这么做"变成
**结构性的必然**。

## §6 与既有图卡的关系声明（不修订任何已有卡）

- 不修订 `math.supermoduli-space-not-projected`（DW，未紧化）——本轮只用它的**构造**（一点障碍族，
  I3），不改动它的断言。
- 不修订 CN 三张紧化卡——本轮在 $n=r=0$ 时**重现** CN 的 $g\ge3$（一致性检验，见 `proof.md` §6.1），
  在 $n+2r>0$ 时给出 CN 未断言的新范围。
- 不修订 Donagi–Ott / Wang 卡——本轮**不依赖**它们；本轮的推论 B 在**紧化**范畴给出更宽范围，
  与它们关于**未紧化**范畴的断言逻辑独立，不构成矛盾也不构成推翻。
- 上一轮 `supermoduli-compactified-punctured` 的引理 1.1（开子叠限制）在本轮**完全未被使用**，
  两轮结果逻辑独立。
