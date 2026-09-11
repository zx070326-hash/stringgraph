# reviewer 独立复算：{Q_B, Q_B} 与 Q_B² = 0 ⟺ c^m = 26

- 复核人：reviewer（graph-reviewer，agora id `reviewer`）
- 日期：2026-09-12
- 复核对象：`graph/derivations/worldsheet/critical-dimension-brst-v2--via-mode-computation.yaml`
  （target `worldsheet.critical-dimension-brst-v2`，里程碑 `ms.critical-dimension-brst-nilpotency`）
- 触发：该推导 gaps 第 1 条与 `docs/STATUS_LEVELS.md` 等级 4 的「初等可复核」例外条款第三项
  （前提完整 + 有限步初等计算 + **reviewer 独立复核**）。
- 结论（先说）：**复算与卡片声明的结果逐字一致**，且比卡片多给出两件事：
  (a) 一般 a^g 的系数多项式（卡片只写 a^g = −1 的特例）；
  (b) 鬼场一侧的 −26 **在本复算中是算出来的**（有限窗求和），不是从依赖边搬来的。
  另发现两条**记号/约定层面**的问题（不影响结论，见 §9），已写进推导卡 notes。

---

## 1. 复算所用的前提（逐条注明出处，不引入任何卡外输入）

| 编号 | 前提 | 出处 |
|---|---|---|
| (P1) | `{b_m, c_n} = δ_{m+n,0}`，`{b_m,b_n} = {c_m,c_n} = 0` | `worldsheet.brst-quantization-v2` statement |
| (P2) | 鬼场 Fock 模建立在 SL(2,C) 真空上：`b_n|0⟩ = 0 (n ≥ −1)`，`c_n|0⟩ = 0 (n ≥ 2)` | 同上 |
| (P3) | `L^g_n = Σ_m (2n − m) : b_m c_{n−m} :` | 同上（等价写法见 `worldsheet.bc-ghost-central-charge-lambda-two`） |
| (P4) | `[L^m_m, L^m_n] = (m−n) L^m_{m+n} + (c^m/12) m(m²−1) δ_{m+n,0}` | `worldsheet.virasoro-algebra-v2` / `conv.virasoro-standard` |
| (P5) | `[L^g_m, L^g_n] = (m−n) L^g_{m+n} + (−26/12) m(m²−1) δ_{m+n,0}` | `worldsheet.bc-ghost-central-charge-lambda-two`（**本复算只用作对照，不作输入**，见 §6.4） |
| (P6) | `Q_B = Σ_n c_n L^m_{−n} + Σ_{m,n} ((m−n)/2) : c_m c_n b_{−m−n} : + a^g c_0`，`a^g = −1` | `worldsheet.brst-quantization-v2` statement（与 Polchinski (4.3.7) 逐字一致，见 §8） |
| (P7) | 受限模 V：每个 v ∈ V 被除有限多个模式外的 `L^m_n, b_n, c_n` 零化 | 同上 |
| (P8) | 诸 `c_{−m} c_m` 在 V 上线性无关 | 目标陈述 `worldsheet.critical-dimension-brst-v2` |

(P7) 的作用：本文中所有对模式和的重排、以及「逐项计算再求和」，都在**每个向量上只有有限多项非零**的意义下进行。
下文凡写 `Σ_m` 都按此理解；这一点在任何来源里都没有陈述（推导卡 gaps 第 5 条已登记）。

---

## 2. 记号与两套正规序（复算必须先把这件事说死）

两张前提卡都只写 `: … :` 而**没有定义**正规序规定。复算中区分两套，并证明它们给出**同一个** `Q_B`（§4）：

- **S 序（SL(2,C) 序）**：湮灭算符 = `b_n (n ≥ −1)`、`c_n (n ≥ 2)`（即 (P2) 中零化 |0⟩ 的那些），
  产生算符 = `b_n (n ≤ −2)`、`c_n (n ≤ 1)`。记作 `∘ … ∘`。
- **L 序（能级序，相对鬼场基态 |↓⟩ = c_1|0⟩）**：湮灭算符 = `b_n (n ≥ 0)`、`c_n (n ≥ 1)`；
  产生算符 = `b_n (n ≤ −1)`、`c_n (n ≤ 0)`。记作 `: … :`。
  （零模归属：取 `b_0` 为湮灭、`c_0` 为产生，即 `b_0|↓⟩ = 0`。§4 末说明结论不依赖这一选择。）

费米缩并（两个模式的乘积与其正规序之差）：对模式 X, Y，
`XY = ∘XY∘ + ⟨XY⟩`，其中 `⟨XY⟩ = {X,Y}`（X 湮灭、Y 产生时）否则为 0。由 (P1)(P2)：

| 缩并 | S 序 | L 序 |
|---|---|---|
| `⟨b_n c_{−n}⟩` | 1 当 n ≥ −1 | 1 当 n ≥ 0 |
| `⟨c_{−n} b_n⟩` | 1 当 n ≤ −2 | 1 当 n ≤ −1 |
| `⟨cc⟩, ⟨bb⟩` | 0 | 0 |

两套只在 **n = −1** 这一个点上不同（`⟨b_{−1}c_1⟩`：S 序为 1，L 序为 0）。这正是 `a^g = −1` 的来源。

三个费米模式的 Wick 展开（下文反复用）：
```
XYZ = ∘XYZ∘ + ⟨XY⟩Z − ⟨XZ⟩Y + ⟨YZ⟩X
```

**指标改写**。把 (P6) 的两项换成下文统一用的指标（这是纯代数替换 m → −p, n → −q）：
```
Σ_n c_n L^m_{−n}                       = Σ_m c_{−m} L^m_m                       =: A
Σ_{m,n} ((m−n)/2) : c_m c_n b_{−m−n} : = −(1/2) Σ_{p,q} (p−q) : c_{−p} c_{−q} b_{p+q} : =: B_L
```
⚠ 注意这里的**负号**：`(m−n)` 在 m → −p, n → −q 下变成 `−(p−q)`。若照抄成
`+(1/2) Σ (p−q) : c_{−p}c_{−q}b_{p+q} :`，得到的算符对**任何** c^m 都不幂零（§7 的物质项不再相消）。
（本次任务书里给出的 `Q_B` 写法正是这个符号翻转的版本，见 §9 F1；复算一律以卡片 (P6) 为准。）

于是 (P6) 即
```
Q_B = A + B_L + a^g c_0 ,   a^g = −1 .
```

---

## 3. 引理 1：三次鬼场项就是 `(1/2) Σ_m c_{−m} L^g_m`（含逐步重排）

由 (P3)，`L^g_k = Σ_n (2k − n) : b_n c_{k−n} :`。令 `n = k + q`（纯换名）：
```
L^g_k = Σ_q (2k − k − q) : b_{k+q} c_{−q} : = Σ_q (k − q) : b_{k+q} c_{−q} :
```
——这正是 `worldsheet.bc-ghost-central-charge-lambda-two` 里写的第一种形式，两卡一致。
再用正规序内部的费米反对易（**这一步是后面所有符号的来源**）：
```
: b_{k+q} c_{−q} : = − : c_{−q} b_{k+q} :
```
（正规序内两个费米算符交换给一个负号；这与「缩并项」无关，缩并已被 `: :` 扣掉。）故
```
L^g_k = − Σ_q (k − q) : c_{−q} b_{k+q} : .
```
把 `c_{−p}` 乘进去并整体正规序（用 p = k 标号，b 的指标 k + q = p + q）：
```
∘ Σ_k c_{−k} L^g_k ∘ = − Σ_{p,q} (p − q) ∘ c_{−p} c_{−q} b_{p+q} ∘ = 2 B_S
```
其中 `B_S` 是 `B` 的 S 序版本。同理 `(1/2) : Σ_k c_{−k}L^g_k : = B_L`。
**结论**：(P6) 的三次项确实是 `(1/2) Σ_m c_{−m} L^g_m` 的正规序版本，与 Polchinski (4.3.14)
`Q_B = c^I (G^m_I + (1/2) G^g_I)` 的结构一致（§8）。

⚠ 一个必须记下的技术点：`Σ_m c_{−m} L^g_m`（c 写在正规序之外）在受限模上**不是良定义算符**
（m → −∞ 时 `c_{|m|}` 作用在 `L^g_m v` 上有无穷多项非零）；良定义的是**整体正规序**的 `B`。
所以下文一律以 `B` 为基本对象，不用 `Σ c_{−m}L^g_m` 这种形式写法。
（`A = Σ_m c_{−m} L^m_m` 则**是**良定义的：`L^m_m` 不动鬼场因子，`c_{|m|}` 对固定鬼场态在 |m| 大时归零。）

## 4. 引理 2：`a^g = −1` 恰好被 S 序吸收，即 `Q_B = A + B_S`

对 `X = c_{−p}`, `Y = c_{−q}`, `Z = b_{p+q}` 用 §2 的 Wick 式，两套正规序相减（`⟨XY⟩ = ⟨cc⟩ = 0`）：
```
∘XYZ∘ − :XYZ: = −(⟨XZ⟩_S − ⟨XZ⟩_L) · (−Y) ... 
```
逐项写清楚：由 `∘XYZ∘ = XYZ − ⟨XY⟩Z + ⟨XZ⟩Y − ⟨YZ⟩X` 得
```
∘XYZ∘ − :XYZ: = (⟨XZ⟩_S − ⟨XZ⟩_L) Y − (⟨YZ⟩_S − ⟨YZ⟩_L) X
```
其中
```
⟨XZ⟩ = ⟨c_{−p} b_{p+q}⟩ = δ_{q,0} · ⟨c_{−p} b_p⟩ ,  ⟨XZ⟩_S − ⟨XZ⟩_L = −δ_{q,0} δ_{p,−1}
⟨YZ⟩ = ⟨c_{−q} b_{p+q}⟩ = δ_{p,0} · ⟨c_{−q} b_q⟩ ,  ⟨YZ⟩_S − ⟨YZ⟩_L = −δ_{p,0} δ_{q,−1}
```
（用 §2 表格：`⟨c_{−n}b_n⟩` S 序要 n ≤ −2、L 序要 n ≤ −1，差别只在 n = −1。）代回：
```
∘XYZ∘ − :XYZ: = −δ_{p,−1}δ_{q,0} c_0 + δ_{p,0}δ_{q,−1} c_0
```
乘上系数 `−(1/2)(p−q)` 并对 p,q 求和：
```
B_S − B_L = −(1/2)[ (p−q)|_{p=−1,q=0} · (−c_0) + (p−q)|_{p=0,q=−1} · (+c_0) ]
          = −(1/2)[ (−1)(−c_0) + (1)(c_0) ] = −c_0 .
```
于是
```
Q_B = A + B_L + a^g c_0 = A + (B_S + c_0) + a^g c_0 = A + B_S + (1 + a^g) c_0 ,
```
**`a^g = −1` 时末项为零**：`Q_B = A + B_S`。这就是目标陈述里「(m³ − m) 的形式来自把 a^g = −1
吸收进 L_0」那句话的精确内容——更准确地说，是**吸收进正规序规定**：S 序的 `L^g_0` 比 L 序的少 1。

零模归属无关：若改取 `c_0` 为湮灭、`b_0` 为产生，差别出现在 p = q = 0 处，而那里系数 `(p−q) = 0`，
`B_S − B_L = −c_0` 不变。

---

## 5. 把 a^g 留成参数

为了同时检验「a^g = −1 这一步是否必需」，下面保留 `κ := 1 + a^g`：
```
Q_B = A + B + κ c_0 ,   B := B_S = −(1/2) Σ_{p,q} (p−q) ∘ c_{−p} c_{−q} b_{p+q} ∘ .
```
卡片取 a^g = −1 即 κ = 0。展开
```
{Q_B,Q_B} = {A,A} + 2{A,B} + {B,B} + 2κ{A,c_0} + 2κ{B,c_0} + κ²{c_0,c_0} .
```
`{c_0,c_0} = 2c_0² = 0`（(P1)）。`{A,c_0} = Σ_m {c_{−m}, c_0} L^m_m = 0`
（`L^m_m` 与鬼场对易，`{c,c} = 0`）。剩下四项逐个算。

## 6. 四项

### 6.1 `{A,A}`：物质 Virasoro 的中心项

A 的每一项 `c_{−m}L^m_m` 是奇算符，且 `[L^m_m, c_n] = 0`：
```
(c_{−m}L_m)(c_{−n}L_n) + (c_{−n}L_n)(c_{−m}L_m)
  = c_{−m}c_{−n} L_m L_n + c_{−n}c_{−m} L_n L_m
  = c_{−m}c_{−n} L_m L_n − c_{−m}c_{−n} L_n L_m      （用 c_{−n}c_{−m} = −c_{−m}c_{−n}）
  = c_{−m}c_{−n} [L_m, L_n] .
```
代 (P4)：
```
{A,A} = Σ_{m,n} (m−n) c_{−m}c_{−n} L^m_{m+n} + (c^m/12) Σ_m (m³ − m) c_{−m} c_m .    (6.1)
```
（中心项：δ_{m+n,0} 取 n = −m，`m(m²−1) = m³ − m`。）

### 6.2 `2{A,B}`：与 (6.1) 第一项精确相消

`B` 只含鬼场，与 `L^m_m` 对易，故
```
{A,B} = Σ_m {c_{−m}, B} L^m_m .
```
算 `{c_{−k}, B}`：对三次正规序积用 `{X, UVW} = {X,U}VW − U{X,V}W + UV{X,W}`（X、U、V、W 全奇）：
```
{c_{−k}, ∘c_{−p}c_{−q}b_{p+q}∘} = c_{−p}c_{−q} {c_{−k}, b_{p+q}} = c_{−p}c_{−q} δ_{k,p+q}
```
（前两项含 `{c,c} = 0`。正规序规定在这里无关紧要：`∘c_{−p}c_{−q}b_{p+q}∘` 与未排序乘积之差
是「c 数 × 单个 c」，而 `{c_{−k}, c_r} = 0`。）于是
```
{c_{−k}, B} = −(1/2) Σ_{p+q=k} (p−q) c_{−p}c_{−q} ,
2{A,B} = −Σ_{p,q} (p−q) c_{−p}c_{−q} L^m_{p+q} .                                      (6.2)
```
(6.2) 与 (6.1) 的第一项**逐项相反**，相加为零。这就是卡片 summary 第 (2) 步所说的
「三次鬼场项与物质项的交叉贡献相消」。⚠ 相消依赖 §2 指出的那个负号；符号一反就变成两倍而非零。

### 6.3 `2κ{B, c_0}`：唯一与 a^g 有关的项

由 6.2 的公式取 k = 0：
```
{c_0, B} = −(1/2) Σ_{p+q=0} (p−q) c_{−p}c_{−q} = −(1/2) Σ_p (2p) c_{−p}c_p = −Σ_p p c_{−p}c_p ,
2κ{B,c_0} = −2κ Σ_m m c_{−m} c_m .                                                     (6.3)
```

### 6.4 `{B,B} = 2B²`：纯鬼场项，−26 在这里被**算出来**

写 `B = Σ_{p,q} β_{pq} ∘c_{−p}c_{−q}b_{p+q}∘`，`β_{pq} = −(1/2)(p−q)`（对 p ↔ q 反对称）。
两个正规序三次积相乘，按 Wick 定理按跨组缩并数分成三类。可用的缩并只有「左组的 b 与右组的 c」
与「左组的 c 与右组的 b」，故最多两次缩并。

**(i) 零次缩并（六费米项）= 0。** 该项是
`β_{pq}β_{rs} ∘c_{−p}c_{−q}c_{−r}c_{−s} b_{p+q} b_{r+s}∘`。把标号对 (p,q) 与 (r,s) 整体交换：
四个 c 整体移动两格 ⇒ 符号 `(−1)⁴ = +1`；两个 b 交换 ⇒ `−1`；β 乘积不变。
故被加项在这个对合下变号，求和为零。

**(ii) 一次缩并（四费米项）= 0（Jacobi 那一步）。**
六个位置记作 1..6 = `c_{−p}, c_{−q}, b_{p+q}, c_{−r}, c_{−s}, b_{r+s}`。
四种一次缩并的 Wick 符号（= 把缩并对移到最左、其余保序的置换符号）：
`(3,4): +1`，`(3,5): −1`，`(1,6): +1`，`(2,6): −1`。
利用 β 的反对称把 (3,5) 归并到 (3,4)、(2,6) 归并到 (1,6)（换名 r ↔ s 或 p ↔ q 各带一个负号，
与 Wick 符号相消），得
```
B²|_{1-缩并} = 2 Σ β_{pq} β_{(p+q)s} θ(p+q) ∘c_{−p}c_{−q}c_{−s} b_{p+q+s}∘
             + 2 Σ β_{(r+s)q} β_{rs} θ̄(r+s) ∘c_{−q}c_{−r}c_{−s} b_{q+r+s}∘
```
（第二项里把 `∘c_{−q} b_T c_{−r}c_{−s}∘` 中的 b 移到最右：跨两个费米，符号 +1。
`θ(n) = 1 (n ≥ −1)`、`θ̄(n) = 1 − θ(n)`，来自 §2 的缩并表。）
因为 `∘c_{−a}c_{−b}c_{−c} b_{a+b+c}∘` 对 (a,b,c) **全反称**而 b 的指标全对称，只有系数的全反称部分存活：
```
F(a,b,c) = (1/2)[ (a−b)(a+b−c) θ(a+b) + (b+c−a)(b−c) θ̄(b+c) ]
```
把 `θ̄ = 1 − θ` 拆开：
- 无 θ 的部分 `(1/2)(b+c−a)(b−c)`：形如 `(m−n)(m+n−s)`，展开 `= m² − n² − sm + sn`。
  `m²`、`n²` 的全反称部分为零（单变量函数在三指标反称化下成对相消）；
  `s(n−m)` 的全反称部分 `= (1/3)[s(n−m) + m(s−n) + n(m−s)] = 0`。故这一块反称化后为零。
- 带 θ 的两块：记 `H(a,b,c) = (a−b)(a+b−c)θ(a+b)`，则它们是 `(1/2)[H(a,b,c) − H(b,c,a)]`。
  `(a,b,c) → (b,c,a)` 是**偶**置换，反称化对偶置换不变 ⇒ 这一块反称化后也为零。

⇒ 四费米项整体为零。（这正是 Polchinski (4.3.16) 里「由 GGG Jacobi 恒等式」那一步在模式语言下的样子；
区别是那里原书紧接着写 "We have neglected central charge terms; these need to be checked by hand"，
而中心项就是下面的 (iii)。）

**(iii) 两次缩并（二费米项）：给出 −26。**
四种两次缩并及其 Wick 符号（同样按置换符号算）：
`{(3,4),(1,6)}: +1`，`{(3,5),(1,6)}: −1`，`{(3,4),(2,6)}: −1`，`{(3,5),(2,6)}: +1`。
后三种用 β 的反对称换名后与第一种相同，故四项等值：
```
B²|_{2-缩并} = 4 Σ_{p,q,r,s} β_{pq} β_{rs} ⟨b_{p+q} c_{−r}⟩ ⟨c_{−p} b_{r+s}⟩ c_{−q} c_{−s} .
```
两个缩并的 δ 给出 `r = p+q` 与 `p = r+s` ⇒ `s = −q`，且（§2 表格，S 序）
```
⟨b_{p+q}c_{−r}⟩ = θ(p+q)  需 p+q ≥ −1 ,   ⟨c_{−p}b_{r+s}⟩ = θ̄(p)  需 p ≤ −2 .
```
系数：`β_{pq} = −(1/2)(p−q)`，`β_{(p+q)(−q)} = −(1/2)(p+2q)`，乘积 `= (1/4)(p−q)(p+2q)`。故
```
B²|_{2-缩并} = Σ_q [ Σ_{p = −1−q}^{−2} (p−q)(p+2q) ] c_{−q} c_q =: Σ_q S(q) c_{−q}c_q .
```
**求和窗口是有限的**：`−1−q ≤ p ≤ −2` 非空当且仅当 `q ≥ 1`，共 q 项。令 `p = −j`（j = 2,…,q+1）：
```
S(q) = −Σ_{j=2}^{q+1} (j+q)(2q−j) = −Σ_{j=2}^{q+1} (2q² + qj − j²)
     = −[ 2q³ + q((q+1)(q+2)/2 − 1) − ((q+1)(q+2)(2q+3)/6 − 1) ]
     = −(1/6)[ 12q³ + 3(q³+3q²+2q) − 6q − (2q³+9q²+13q+6) + 6 ]
     = −(1/6)(13q³ − 13q) = (−26/12)(q³ − q) .
```
（数值核对 q = 1..7：0, −13, −52, −130, −260, −455, −728，与 `−(13/6)(q³−q)` 逐项相等。）
由 `c_{−m}c_m = −c_m c_{−m}`，对 m ∈ Z 的奇函数系数满足 `Σ_{m∈Z} g(m) c_{−m}c_m = 2 Σ_{m≥1} g(m) c_{−m}c_m`，故
```
{B,B} = 2B²|_{2-缩并} = Σ_{m∈Z} (−26/12) (m³ − m) c_{−m} c_m .                          (6.4)
```
**注**：这里的 26 是从 (P1)(P2)(P3) 的模式代数 + SL(2,C) 真空的湮灭条件算出来的有限窗求和，
**没有**用到 (P5)。因此推导卡挂 `worldsheet.bc-ghost-central-charge-lambda-two` 那条边仍然成立
（卡片自己的路线确实从那里取 −26），本复算另外给了一条独立佐证：该窄卡的数值与模式代数自洽。

---

## 7. 合并：系数多项式

(6.1) 第一项与 (6.2) 相消，剩下 (6.1) 的中心项、(6.3)、(6.4)：
```
{Q_B, Q_B} = Σ_{m∈Z} f(m) c_{−m} c_m ,
f(m) = ((c^m − 26)/12)(m³ − m) − 2(1 + a^g) m .                                         (7.1)
```
即，把 m³ 与 m 的系数分开写：
```
f(m) = ((c^m − 26)/12) m³ − [ (c^m − 26)/12 + 2 + 2a^g ] m .
```
**卡片取的 a^g = −1 使第二项的 `2 + 2a^g` 为零**：
```
{Q_B, Q_B} = Σ_{m∈Z} ((c^m − 26)/12) (m³ − m) c_{−m} c_m ,
Q_B² = (1/2){Q_B,Q_B} = (1/2) Σ_{m∈Z} ((c^m − 26)/12)(m³ − m) c_{−m}c_m .               (7.2)
```
与目标陈述 `worldsheet.critical-dimension-brst-v2` 的公式、与推导卡 summary 第 (2) 步**逐字一致**。

**两个方向**（前提 (P8)）：
- ⟸：`c^m = 26` ⇒ f(m) ≡ 0 ⇒ `Q_B² = 0`（无需 (P8)）。
- ⟹：`Q_B² = 0` 且诸 `c_{−m}c_m`（m ≥ 1，注意 m 与 −m 给同一个算符，m = 0, ±1 处 `m³ − m = 0`
  使那三项恒为零，不承载信息）线性无关 ⇒ f(m) = 0 对所有 m ≥ 2。取 **m = 2**：
  `f(2) = ((c^m−26)/12)·6 = (c^m−26)/2 = 0` ⇒ `c^m = 26`。
  （只需一个 m ≥ 2 即可；卡片取 m = 2，复核同意。）

**附带结论（卡片没写、但值得记账）**：(7.1) 表明若把 a^g 当自由参数，幂零性等价于
`c^m = 26` **且** `a^g = −1` 两条同时成立。这与 kato-ogawa-1983 摘要「the conditions D = 26 and
α₀ = 1 … are required by the nilpotency」把两件事一并归给幂零性的说法结构一致
（本图把 a^g = −1 放在定义卡里当归一化，故只剩 c^m = 26 一条）。

---

## 8. 与文献的对照

### 8.1 Polchinski (4.3.7)：`Q_B` 的模展开 —— 一致
抽取记录 `literature/extractions/polchinski-1998-v1.md` §12.3（E63，[S] §4.46 [4.225] 逐字复现）：
```
Q_B = Σ_n c_n L^m_{−n} + (1/2) Σ_{m,n} (m−n) : c_m c_n b_{−m−n} : − c_0
```
与 (P6)（`+ a^g c_0`，`a^g = −1`）逐字相同。⇒ 卡片对 Polchinski 的转写无漂移。

### 8.2 Polchinski (4.3.9)：结论式 —— 一致，但原书**没有印出系数多项式**
抽取记录 §12.10 表 B 第 11 行：(4.3.9) 的内容是「`{Q_B, Q_B} = 0` only if `c^m = 26`」，
原书另注「The shortest derivation of this uses the Jacobi identity, exercise 4.3」。
**抽取记录里没有 (4.3.9) 的系数多项式逐字文本**，故无法与 (7.1) 的 m³/m 系数逐项对照。
（这与推导卡 gaps 第 2 条一致：没有任何文献印出这条判据的完整证明。）

### 8.3 Polchinski (4.3.10)：`j_B j_B` 的 OPE —— **可以对照，且逐项一致**
抽取记录 §12.10 表 B 逐字（该行标 ✓ 已核实）：
```
j_B(z) j_B(0) ∼ −((c^m−18)/2z³) c∂c − ((c^m−18)/4z²) c∂²c − ((c^m−26)/12 z) c∂³c
```
把单极点换成模式（`c(z) = Σ c_n z^{−n+1}` ⇒ `∂³c` 的系数 `(1−n)(−n)(−1−n)`）：
```
{Q_B,Q_B} = Res_{z→0} j_B(z)j_B(0) 的零模
          = −((c^m−26)/12) ∮(dw/2πi) (c∂³c)(w)
          = −((c^m−26)/12) Σ_m (m³ − m) c_m c_{−m}
          = +((c^m−26)/12) Σ_m (m³ − m) c_{−m} c_m ,
```
（用 `n = −m` 时 `(1−n)(−n)(−1−n) = (1+m)m(m−1) = m³ − m`，以及 `c_mc_{−m} = −c_{−m}c_m`。）
**与 (7.2) 完全一致**，包括整体符号与 1/12 归一化。⇒ 本复算与原书 OPE 路线交叉验证通过。
另 (4.3.11) `T j_B ∼ ((c^m−26)/2z⁴)c + …`（反常仅在 c^m = 26 消失）与本结论同号同判据。

### 8.4 fgz-1986 / kato-ogawa-1983 —— 无可对照的系数公式
`literature/extractions/brst-cohomology-sources.md` §1.2（L1 全文五页逐页读毕）明确：FGZ 中
**没有**「Q² = 0 iff c = 26」型编号陈述；Prop 1.2 只有一句 `d² = 0`，26 只在 Prop 2.1(i) 的
`ρ(c) = −26 Id`（鬼场表示），而 `π(c) = 26` 是 FGZ 的**假设**。Kato–Ogawa 正文未获取（403），
摘要只给方向 ⟹，无系数公式。⇒ **数学文献侧没有可供逐项对照的多项式**，这一点与推导卡
gaps 第 2 条一致；本复算因此是该推导升 rigorous 的**唯一**依据（例外条款第三项）。
IMNU 1986 (3.8)–(3.9) 的显式系数是 **NSR 超弦**，不能拿来对照玻色弦。

---

## 9. 机器复核（独立于 §3–§7 的手算）

为避免手算的符号错误，另在**显式 Fock 模**上把 `Q_B` 当作算符直接作用两次（有理数精确运算，
无符号计算）：物质取 D 个自由玻色子（`[α^μ_m, α^ν_n] = m δ^{μν} δ_{m+n,0}`，动量 0，
`L^m_n = (1/2)Σ:α_{n−k}α_k:`，故 `c^m = D`），鬼场取 (P1)(P2) 的 Fock 模，
`Q_B` 按 (P6) 逐项实现，两套正规序（S 序无 c_0 项、L 序带 `a^g c_0`）分别实现。
脚本见 §11（未提交，复现步骤在那里）。

测试态 `b_{−j}|0⟩`（矩阵元把 (7.1) 的 f(j) 直接暴露出来：`Q_B² b_{−j}|0⟩ = f(j) c_{−j}|0⟩`）：

| scheme | D = c^m | j | 复算 (7.1) 预言 | 脚本结果 |
|---|---|---|---|---|
| S 序 | 1 | 2, 3, 4 | −25/2, −50, −125 | 同 |
| S 序 | 2 | 2, 3, 4 | −12, −48, −120 | 同 |
| S 序 | 3 | 2, 3, 4 | −23/2, −46, −115 | 同 |
| L 序（a^g = −1） | 1, 2, 3 | 2, 3, 4 | 同上 | 同 |

且 `Q_B²b_{−j}|0⟩` 除 `c_{−j}|0⟩` 外**没有其他分量**。两套正规序给出相同结果 ⇒ 引理 2（§4）被独立验证。

一般 a^g（把 (P6) 末项系数当参数）：对 a^g ∈ {−2, −1, −1/2, 0, 1}、D ∈ {1, 26}、j ∈ {2,3}，
脚本结果与 `f(j) = ((D−26)/12)(j³−j) − 2(1+a^g) j` **逐个相等**；特别是 D = 26、a^g = −1 时
`Q_B²` 在测试态上恒为 0，而 a^g ≠ −1 时不为 0。⇒ (7.1) 的 m 线性项系数被独立确认。

幂零性抽查（a^g = −1）：对若干含物质振子与鬼场激发的态（如 `α_{−2} c_{−1} b_{−3}|0⟩`、
`b_{−2}b_{−4}|0⟩`），D = 26 时 `Q_B²` 的所有分量为零；D = 25 时非零。

## 10. 与推导卡声明的逐条对照

| 卡片声明 | 复核结论 |
|---|---|
| summary (1) 用 `{b,c} = δ` 与物质 Virasoro 展开 `{Q_B,Q_B}` | 一致（§6.1–6.2） |
| summary (2) 三次鬼场项与物质项交叉贡献相消，只剩 ∝ 总中心荷的项 | **一致**，相消是逐项精确的（(6.1) 首项 + (6.2) = 0） |
| summary (2) 结果 `Σ ((c^m−26)/12)(m³−m) c_{−m}c_m` | **一致**（(7.2)），且与 Polchinski (4.3.10) 单极点独立吻合 |
| summary (3) ⟸ 方向每项为零 | 一致 |
| summary (4) ⟹ 方向取 m = 2 得 c^m = 26 | 一致（需 m ≥ 2 的任一个；m = 0, ±1 无信息） |
| 陈述卡「(m³ − m) 的形式来自把 a^g = −1 吸收进 L_0」 | 一致，且可精确化为：a^g = −1 等价于把三次项改用 S 序写（§4） |
| gaps 第 1 条要求复核的三处（(m³−m) 系数、交叉相消、a^g 吸收） | **三处全部复核通过** |
| 26 = −c^g 由依赖边供给 | 成立；本复算另从模式代数独立算出 −26（§6.4 (iii)） |

⇒ **结论：计算与卡片声明一致**，满足 `docs/STATUS_LEVELS.md` 等级 4 例外条款第三项。

---

## 11. 复核中发现的问题（不影响上面的结论，但要记账）

### F1（对**任务书**的更正，不是对图的）—— `Q_B` 三次项的符号与 a^g 的符号
本次任务书把 `Q_B` 写成
`Σ c_{−m}L^m_m + (1/2) Σ (m−n) : c_{−m}c_{−n}b_{m+n} : − a^g c_0`。
这与卡片 (P6) 相差**两个**符号：三次项的 `(m−n)` 与末项的 `a^g`（见 §2 的指标改写）。
按任务书那个写法，§6.2 的相消变成相加，`Q_B` 对任何 `c^m` 都不幂零。
**复算一律以卡片 (P6) 为准**，卡片的写法与 Polchinski (4.3.7) 逐字一致（§8.1）。
任务书草拟的系数多项式 `… + (2a^g + 2 − (c^m−26)/12) m` 中 `(2a^g+2)` 的符号亦与 (7.1) 相反；
在 a^g = −1 处两者都退化为卡片公式，故不影响结论。

### F2（对**图**的，PLAUSIBLE，建议交 curator/lead）—— 两张前提卡的 `: :` 规定不一致且都未定义
- `worldsheet.brst-quantization-v2`：写 `L_n = L^m_n + L^g_n + a^g δ_{n,0}` 的中心荷在 (m³−m)
  形式下为 `c^m + c^g` ⇒ 它的 `L^g` 必须是 **L 序**（能级序）的。
- `worldsheet.bc-ghost-central-charge-lambda-two`：写 `[L^g_m, L^g_n] = (m−n)L^g_{m+n} +
  (−26/12) m(m²−1) δ` ⇒ 它的 `L^g` 必须是 **S 序**（SL(2,C) 序）的。
两卡的 `L^g_m` 写的是**同一个公式**，但正规序规定不同，相差 `δ_{m,0}`：机器复核给出
`L^g_0|↓⟩ = −|↓⟩`（S 序）而 `= 0`（L 序）。若把两卡的式子**字面**拼在一起，
L 序 `L^g` 的中心项应是 `(−26/12)(m³−m) − 2m` 而不是 `(−26/12)(m³−m)`。
**影响**：本复算不受影响（§6.4 没有用 (P5)，而是从模式代数直接算；(7.1) 的 m 线性项也已独立核对）。
但对下游任何**逐字**组合这两卡公式的推导，这是一个会咬人的隐含约定。
**建议**：定义卡换代（v3）时把 `: :` 的规定写进 statement，或在 `conv.` 层加一条鬼场正规序约定。
（本 reviewer 只读，不改 statement 卡；已写入本推导 notes 供 lead 裁决。）

### F3（记录）—— 例外条款其余两项的核对
- 「前提完整」：(P1)–(P8) 全部写在目标陈述或其依赖的定义卡里，复算未引入任何卡外输入
  （唯一需要补的是 §2 的正规序规定，见 F2）。
- 「有限步初等计算」：成立。全部步骤是费米 Wick 展开 + 有限窗求和（§6.4 的窗口长度 = q）+
  三指标反称化；受限模条件保证每个向量上只有有限多项。

---

## 12. 复现（脚本未提交）

机器复核脚本在复核时放在 worktree 的 `.scratch/`（未提交，`graph/` 与 `docs/` 之外）。要点：
- 基态：鬼场 `|0⟩`（SL(2,C)），基矢 = 产生算符的规范排序元组，费米符号按置换奇偶；
  物质 = D 个自由玻色子的 Fock 基（动量 0）。
- `Q_B` 按 (P6) 逐项实现：`Σ_n c_n L^m_{−n}`、`Σ_{p,q}((p−q)/2) : c_p c_q b_{−p−q} :`（按 scheme
  排序并记符号）、`a^g c_0`；模式截断 |index| ≤ 9，已验证再放大不改变结果。
- 检验量：`Q_B²` 作用在 `b_{−j}|0⟩` 上 `c_{−j}|0⟩` 分量的系数，与 (7.1) 的 f(j) 比较（有理数精确相等）。

---

## 13. 升级与工具输出

复算通过 ⇒ 按 `docs/STATUS_LEVELS.md` 等级 4 例外条款，把
`worldsheet.critical-dimension-brst-v2--via-mode-computation` 的
`status: physical-argument → rigorous`、`kind: physical-argument → proof`（该卡 notes 要求两者同改），
gaps 第 1 条按「已关闭 + 历史原文照录」处理，notes 留 `reviewer-verified: reviewer-brst-nilpotency, 2026-09-12`。

```
$ uv run stringgraph validate --hide-history
624 statements, 516 derivations, 4 milestones, 22 conventions: 0 errors, 71 warnings (25 history)
```

```
$ uv run stringgraph status worldsheet.critical-dimension-brst-v2
id: worldsheet.critical-dimension-brst-v2
kind: proposition
title: BRST 荷幂零 Q_B^2 = 0 当且仅当物质中心荷 c^m = 26（陈述只到 c^m，不含 c^m = D 那一步）
own_status: rigorous
effective: rigorous
best_derivation: worldsheet.critical-dimension-brst-v2--via-mode-computation
assumes:
conjectures_depended_on:
derivations:
  worldsheet.critical-dimension-brst-v2--via-mode-computation  [proof] own=rigorous effective=rigorous
  worldsheet.critical-dimension-brst-v2--via-nilpotency  [physical-argument] own=physical-argument effective=physical-argument
```

升级前（同一命令）：`own_status: physical-argument`、`effective: physical-argument`、
`best_derivation` 相同（两条推导当时同为 physical-argument）。

```
$ uv run stringgraph report | grep -A 6 '^milestones:'
milestones:
  ms.critical-dimension-bosonic -> worldsheet.critical-dimension-bosonic-v3  audit=back-translated  effective=physical-argument
  ms.critical-dimension-brst-nilpotency -> worldsheet.critical-dimension-brst-v2  audit=draft  effective=rigorous
  ms.ddf-commute-with-virasoro -> worldsheet.ddf-commute-with-virasoro  audit=back-translated  effective=formalized
  ms.no-ghost-theorem -> worldsheet.no-ghost-theorem-v4  audit=back-translated  effective=rigorous
```

升级前 `ms.critical-dimension-brst-nilpotency` 的 `effective` 是 **physical-argument**；
升级后为 **rigorous**（`audit=draft` 不变——approved 只断言陈述忠实性，须 auditor 回译 + 船长确认）。
`ms.critical-dimension-bosonic` 仍是 physical-argument：它指向 `critical-dimension-bosonic-v3`，
被 (I)(IV)(V) 三条路线与该推导自身的 status 封顶，与本次升级无关。

### 13.1 附带的工具侧改动（须 lead 过目）
`tests/test_graph.py::test_why_seed_critical_dimension_names_three_routes` 原先断言
`worldsheet.critical-dimension-brst-v2` **出现在** `worldsheet.critical-dimension-bosonic` 的瓶颈树里。
本次升级后它 rigorous，按定义不再是瓶颈，故从 `why` 树中消失——这正是 `docs/ROADMAP.md` R3
预言的「(III) 整条从瓶颈树消失」。该测试因此失败（pre-commit 的 pytest 会挡住提交）。
处理：把断言改成「light-cone-v2 仍在树里」且「brst-v2 **不**在树里」，并在测试里写明日期与原因。
单独提交（`tools: …`），与图数据提交分开。**这是本次唯一一处 reviewer 改到 `graph/` 之外的代码，
请 lead 确认该测试的新形状是想要的**（另一种改法是删掉这条对活数据的断言，本次未采用）。
