# claim.md — DDF 张成定理的**塔内原生**证明（不经 Borcherds 对象字典、不经围道/模态和字典）

> **地位**：原创证明尝试。`state` 见 `status.yaml`。
> 在 `graph-reviewer` 判定之前，**图里任何节点不得 `depends_on` 本目录**。

---

## 0. 本 attempt 要做什么，以及为什么是第三条路

目标卡 `worldsheet.ddf-spanning-hypothesis-v2`（`own_status: formalized`，`effective:
physical-argument`）现有两条推导：

| 推导 | own | effective | 瓶颈 |
|---|---|---|---|
| `--via-borcherds-1992` | rigorous | physical-argument | **两枝并列**：`momentum-tower-is-borcherds-no-ghost-instance`（对象字典）与 `ddf-contour-equals-mode-sum`（算子字典） |
| `--via-rank-inequalities` | formalized | open | `ddf-spanning-rank-inequality`（∀N 的秩不等式，蓄意无推导，N ≥ 12 有硬墙） |

本 attempt **不修补这两条**，而是造第三条：**完全在本项目的动量塔内部**重做
Goddard–Thorn / Borcherds §5 的分解论证，把 Borcherds 那个未知的横向空间 `T` 换成
塔的 Fock 模型里**显式可算**的空间

```
W_j := ker( b(m)|_{F(a+jb)} : m ≥ 1 )  =  R[ b(-n), ε_i(-n) : n ≥ 1 ] · |0; a+jb⟩ .
```

`b(m)` 就是 Borcherds 的 `K_m`（`literature/extractions/borcherds-1992.md` 追加疑问 7 已证
`K_i = ±w(i)` 是 Heisenberg 模）。这一步让 Borcherds Lemma 5.1–5.3 的"未知空间上的三角性"
论证被**替换为 Fock 多项式代数上的显式偏导计算**，从而绕开：

- 对象字典（两个不同秩、不同退化性的格之间的 Φ）——本证明不提 `II_{1,1}`，不提 `V ⊗ V_{II_{1,1}}`；
- 算子字典（围道 `∮` = 模态和）——本证明只用 `ddfOp` 的**模态和定义本身**
  （Lean `StringFormal.NoGhost.ddfOp`），一次不出现围道积分；
- 逐 N 的秩不等式——本证明对一切 `N` 一次给出，不做 per-N 枚举。

---

## 1. 记号与设定

沿用 `conv.metric-mostly-plus`、`conv.alpha-prime-regge`、`conv.virasoro-standard`、
`conv.intercept-sign-a`，记号取自 `worldsheet.momentum-tower-fock-space`、
`worldsheet.virasoro-generators-free-boson`、`worldsheet.ddf-operators-v6`、
`worldsheet.ddf-light-cone-frame`。

**(R)** `R` 是含 `ℚ` 的**交换环**（等价地：交换 `ℚ`-代数）。`ℚ ⊆ R` 用在引理 2 的
`u(n) = n∂_{u(−n)}` 与 `L_m` 里的 `½`。

> ⚠ **本行原写作"`R` 是特征 0 的域"（2026-09-24 随 b6fba30 订正）**。放宽到交换环不是
> 泛化癖：目标卡 `ddf-spanning-hypothesis-v2` 的系数环设定逐字就是"交换 `ℚ`-代数"，
> 写成域会让本文够不着目标卡。且旧的"域 + 维数计数"论证在一般交换环上**真的不成立**
> ——它要走"单射 ⟹ 满射"，而 `ℤ --×2--> ℤ` 就是反例。现行 §3 步骤 (4) 改走
> "矩阵单位三角 ⟹ 行列式 `±1` ⟹ 可逆"，不用维数计数。见 `proof.md` 注 3.0、注 4.1b。

**(D)** `D ∈ ℕ`，`D ≥ 2`；`η_μ ∈ R` 满足 **(F1)** `η_μ² = 1`；`𝔥 := R^D`，
`η(x,y) := Σ_μ η_μ x^μ y^μ`（`conv.metric-mostly-plus`）。

**标架数据** `a, b, ε_1, …, ε_{D−2} ∈ 𝔥`，满足

| 记号 | 条件 | 出处 |
|---|---|---|
| (N) | `η(b,b) = 0` | `ddf-operators-v6` 的 (N)；frame 卡 (F2) |
| (S) | `η(a,b) = 1` | 同卡 (S)；frame 卡 (F3) |
| (A) | `η(a,a) = 2` | 截距 `a₀ = ½η(a,a) = 1`；frame 卡【手算 (ii)】= Lean `DDFLightConeFrame.dotVec_self_eq_two` |
| (T) | `η(ε_i,b) = 0` | frame 卡 (F5) |
| (T′) | `η(ε_i,a) = 0` | frame 卡 (F6) |
| (O) | `η(ε_i,ε_j) = δ_{ij}` | frame 卡 (F7) |
| (C) | `{a, b, ε_1, …, ε_{D−2}}` 是 `𝔥` 的 `R`-基 | ⭐ **不是独立前件——它是 (F1)(N)(S)(T)(O) 的推论**，见下方 §1.1（2026-09-24 订正，原写「由 frame 卡 (F8) 得到」，2026-09-24 又误订正为「本 attempt 的前件，不是导出的」，两次都不对）。本文仍把它列在前件表里只是为了照应正文的引用，它不构成对目标卡的前件加强 |
| (D26) | `D = 26` | **只在 Theorem 3（主定理）用到；Theorem 1、2 对一切 `D ≥ 2` 成立** |

### 1.1 关于 (C)：它是推论，不是前件

⭐ **2026-09-24 订正（来源：只读核查 agent `consume-check`，lead 已独立复算确认）。**
本节原先绕道 frame 卡的 (F4) + Lean `span_range_frameVec_eq_top` / `frame_decomp_coeff`，
结论只敢写到"相容、非空"，并把 (C) 留作前件。那是一条**不必要的弯路**。(C) 可以从
(F1)(N)(S)(T)(O) **直接证出来**，三行，且对任意交换环成立：

设 `B` 是以 `a, b, ε_1, …, ε_{D−2}` 为列的矩阵，`c_i := η(ε_i, a)`（**不设 (T′)，`c` 任意**）。
在基序 `(a, b, ε_1, …, ε_{D−2})` 下的 Gram 阵是
```
        ⎡ η(a,a)  1   cᵀ ⎤
  G  =  ⎢   1     0   0  ⎥        （用 (S) η(a,b)=1、(N) η(b,b)=0、(T) η(ε_i,b)=0、(O)）
        ⎣   c     0   I  ⎦
```
沿**第二行**展开（该行是 `(1, 0, …, 0)`）：`det G = −det [[1, cᵀ], [0, I]] = −1`。
又 `G = Bᵀ η B`，而 `det η = ∏_μ η_μ` 由 (F1) 是**单位**（每个 `η_μ` 满足 `η_μ² = 1`）。
故 `det(B)² = det G / det η` 是单位 ⟹ `det B` 是单位 ⟹ `B` 可逆 ⟹ `{a, b, ε_i}` 是基。∎

三点后果：
1. **不需要 (T′)**（`c` 全程未被约束）、不需要域、不需要有序性、不需要 `b̃`，
   也**完全不经过** `ddf-light-cone-frame` 的 (F4)/(F8)。
2. `proof.md` §7.1 的 `[GAP-C]` 按此**关闭**——它原先说"需要把 `b̃ = b − a` 的换基
   行列式论证写全"，那正是上面这条弯路。
3. 由 1，**(C) 不构成对目标卡 `ddf-spanning-hypothesis-v2` 的前件加强**：目标卡的
   【设定】已含 (F1)(N)(S)(T)(O)，(C) 随之免费。§7.0 的前件差异表据此收窄。

⚠ **(C) 与 frame 卡的 (F8) 仍然不是一回事**（(F8) 是 `v^⊥ = span{ε_i, v}` 的完备性）。
`formal/StringFormal/NoGhost/WitnessInt.lean` 的 D = 3 整数见证否掉的是 **(F8)**：
代入 `{a,b,ε} = {(0,1,1),(1,1,0),(0,0,1)}` 得 `det = −1`，**(C) 在该见证上成立**。
把"见证否掉 (C)"写进任何地方都是错的。

### 1.2 塔、模、形式

- `F(p) := S(𝔥 ⊗ t^{−1}R[t^{−1}])`，`|0;p⟩ := 1`；塔 `T(a;b) := ⊕_{j∈ℤ} F(a+jb)`（代数直和），
  `p_j := a + jb`（`worldsheet.momentum-tower-fock-space`）。
- 对 `u ∈ 𝔥`、`n ∈ ℤ` 记 `u(n) := η(u, α_n)`；`[u(m), v(n)] = m η(u,v) δ_{m+n,0}`，
  `u(0)|_{F(p_j)} = η(u, p_j)·id`。
- **记号（本文全文固定）**：`Λ_n := a(n)`，`K_n := b(n)`，`E^i_n := ε_i(n)`。
  由 (C)，`F(p_j) = R[Λ_{−n}, K_{−n}, E^i_{−n} : n ≥ 1]`（多项式代数）。
- 能级 `N`（`Fock.level`）：`u(−n)` 把能级抬高 `n`。双分次片 `T_{j,N}`。
- `L_m`：逐层 Sugawara 生成元 `L_m = ½ Σ_{k∈ℤ} :α_{m−k}·α_k:`
  （`worldsheet.virasoro-generators-free-boson`，Lean `Fock.Lop` / `towerLop`），
  `c = D`，`[L_m,L_n] = (m−n)L_{m+n} + (D/12)(m³−m)δ_{m+n,0}`。
- `⟨·,·⟩`：逐层 Fock 双线性型，层间正交（`momentum-tower-fock-space` (2)，**约定**），
  `⟨0;p|0;p⟩ = 1`，`u(n)† = u(−n)`（Lean `Fock.pairing`）。
- `A^ε_n := Σ_{j∈ℤ} α^ε_j V^{(n)}_j`（`ddf-operators-v6`，Lean `ddfOp`），
  `V^{(n)}_K = S_n ∘ vertexOsc(n·b)_{K−n}`，`S_n` 是层移 `j ↦ j+n`。
- `H_phys := {Ψ ∈ T(a;b) : L_0Ψ = Ψ, L_mΨ = 0 ∀m ≥ 1}`
  （`worldsheet.tower-physical-quotient-form`，`a₀ = 1` 由 (A)）。
- `D(Ε) := span_R{ A^{ε_{i_1}}_{−n_1} ⋯ A^{ε_{i_r}}_{−n_r}|0;a⟩ : r ≥ 0, n_1,…,n_r ≥ 1 }`。
- `H_null := H_phys ∩ H_phys^⊥`（同卡）。

### 1.3 本证明新引入的空间（逐层定义，`j ∈ ℤ` 固定）

```
W_j := { w ∈ F(p_j) : K_m w = 0 ∀ m ≥ 1 }            （"横向核"）
I_j := Σ_{n ≥ 1} K_{−n}·W_j                          （W_j 里 K-次数 ≥ 1 的部分）
P_j := { v ∈ F(p_j) : L_m v = 0 ∀ m ≥ 1 }            （不带 L_0 条件）
S_j := Σ_{m ≥ 1} L_{−m}·F(p_j)                       （"伪态"）
T_j := W_j ∩ P_j                                     （本证明的"横向空间"）
N_j := S_j ∩ P_j
```

上标 `¹` 表示取 `L_0 = 1` 的本征分量：`P¹_j := P_j ∩ ker(L_0 − 1)` 等。

---

## 2. 命题

以下 `Theorem 1`、`Theorem 2` 对一切 `D ≥ 2` 成立；`Theorem 3` 需要 (D26)。

### Theorem 1（塔上 Fock 模在 `U(Vir_{<0})` 上自由，"Borcherds Lemma 5.2 首句"的替代品）

> 设 (R)(D)(F1)(N)(S)(T)(T′)(O)(C)。固定 `j ∈ ℤ`。则乘法映射
> ```
> μ : U(Vir_{<0}) ⊗_R W_j ⟶ F(p_j),    u ⊗ w ↦ u·w
> ```
> 是 `R`-线性同构；等价地，
> ```
> { L_{−m_1} ⋯ L_{−m_r} w : r ≥ 0, m_1 ≥ … ≥ m_r ≥ 1, w ∈ B_j }
> ```
> 是 `F(p_j)` 的 `R`-基，其中 `B_j` 是 `W_j = R[K_{−n}, E^i_{−n}]` 的单项式基。
> **推论 1.1**：`F(p_j) = W_j ⊕ S_j`。
> **推论 1.2**（再用每个 `T_{j,N}` 上形式非退化）：`S_j = P_j^⊥`。
>
> ⚠ 注意本定理**不需要** (A)、(D26)（`η(a,a)` 可以是任意标量）。三角性机制的**命门**
> 是 (S)：引理 6 的领项系数恰为 `K_0 = η(b, p_j) = η(b,a) + jη(b,b) = 1`（用 (S)(N)），
> 对一切 `j ∈ ℤ` 恒等于 `1`——注意拿到的是**单位元 `1`**而非仅仅"≠ 0"，这在一般交换环
> 上是必需的强度。
>
> ⚠⚠ **本行曾错写成"不需要 (T)、(T′)、(O)"（rev-tower-ddf 的 F1，2026-09-24 订正）**。
> 订正后的正确说法，三条要分开讲：
> - **(T) `η(ε_i,b)=0` 是真必需的**，不是"未证可省"。反例（`R = ℝ`，`D = 3`，基
>   `(a,b,ε)` 下 Gram `[[2,1,0],[1,0,1],[0,1,1]]`）：`det = −3`，符号差 `(2,1)`，与
>   `conv.metric-mostly-plus` 相容，且 (A)(S)(N)(T′)(O) 全部成立、只有 (T) 失效；
>   此时 `(G^{−1})^{aa} = 1/3 ≠ 0`，引理 1 把 `W_j` 认成"不含 `Λ` 变量的子环"这一步
>   随之失效。
> - **(T′)、(O) 的地位不同**：本文的证明**确实用到**它们（引理 1 的 `ε_i^* = ε_i`），
>   只是本文**没有证明**它们不可省。它们是"未证可省"，不是"已知必需"。
> - 因此本定理的前件表已按 §7.0 的差异表订正为 (R)(D)(F1)(N)(S)(T)(T′)(O)(C)，
>   与 `proof.md` §3 逐字一致。

### Theorem 2（横向空间 = DDF 空间，对一切 `D ≥ 2`）

> 设 (R)(D)(F1)(N)(S)(A)(T)(T′)(O)(C)。则对一切 `N ≥ 0`：
> ```
> T¹_{−N}  =  D(Ε) ∩ T_{−N,N}  ,      且 dim_R = p_{D−2}(N)
> ```
> （`p_{D−2}` = 把 `N` 写成带 `D−2` 种颜色的部分的分拆数）。合起来：
> ```
> T¹ := ⊕_{j∈ℤ} T¹_j  =  D(Ε) ,
> ```
> 且 `{A^{ε_{i_1}}_{−n_1}⋯A^{ε_{i_r}}_{−n_r}|0;a⟩}`（`(i_k,n_k)` 的多重集互不相同）是
> `D(Ε)` 的一组基。

### Theorem 3（主定理 = 目标卡，`D = 26`）

> 设 (R)(D)(F1)(N)(S)(A)(T)(T′)(O)(C)(D26)。则
> ```
> H_phys  =  D(Ε) ⊕ H_null    （内直和）。
> ```
> 特别地 `H_phys ⊆ D(Ε) + H_null`，即 `worldsheet.ddf-spanning-hypothesis-v2` 的断言，
> 且和是直和（比目标卡多一条 `D(Ε) ∩ H_null = 0`）。

### 与已有卡的关系

- Theorem 3 的结论逐字包含 `worldsheet.ddf-spanning-hypothesis-v2` 的断言；前件比该卡多
  (A)(T′)(O)(C)。⚠ 该卡自身前件表里 `η(v,v) = 0`（`v := a − b`）等价于 (A)
  （`η(v,v) = η(a,a) − 2`），故 (A) **不是**新增前件；新增的是 (T′)(O)(C)，
  而这三条正是 `worldsheet.ddf-light-cone-frame`（`formalized`）的 (F6)(F7)(F8)，
  即"文献取的那个标架"。
- Theorem 2、3 限制到 `N = 1` 就是 `worldsheet.ddf-spans-physical-states-level-one-modulo-null`
  （`formalized`）；§5 的机检把两者对上作为一致性检查。
- `research/attempts/borcherds-rank-one-noghost/claim.md` 的义务表里
  **P1（"唯一真困难的一条"）= 本文 Theorem 1**，**P3 = 本文 Lemma 9/10**，
  **P4 = 本文 Theorem 2**。本 attempt 是那条路线的**替代**而非续作：
  那里把 `T_j` 当未知空间去猜生成集（已记录为死路），这里根本不需要事先知道 `T_j`。

---

## 3. 允许使用的砖块

本证明**不引用**任何 `conjecture` / `physical-argument` 节点。用到的图内节点全部是
`definition` 或 `formalized`：

| 节点 | 用途 | effective |
|---|---|---|
| `worldsheet.momentum-tower-fock-space` | 塔、层间正交型、`S_n` 的定义 | formalized |
| `worldsheet.virasoro-generators-free-boson` | `L_m` 的定义 | formalized |
| `worldsheet.ddf-operators-v6` | `A^ε_n` 的模态和定义 | formalized |
| `worldsheet.ddf-light-cone-frame` | (F1)–(F8) | formalized |
| `worldsheet.bosonic-fock-gram-matrix` | 逐能级 Gram 对角、非退化 | formalized |
| `worldsheet.tower-physical-quotient-form` | `H_phys`、`H_null` 的定义 | formalized |
| `worldsheet.ddf-operators-preserve-physical-states` | `D(Ε) ⊆ H_phys` | formalized |

**§3 注**：`proof.md` 里凡是用到这些卡的地方都**同时给出独立推导**（本 attempt 是原创证明，
按 `research/CLAUDE.md`，论证必须自己站得住），引用只作为"本项目已有同一事实"的交叉验证。
唯一的例外是 §1.2 的**约定**（层间正交、度规号差、`α'` 归一化），那是设定不是定理。
