# claim.md — Thm 5.1′：Borcherds 1992 Thm 5.1 在本项目动量塔设定下的候选表述

> **本文件的地位**：这是 scoping 任务裁定 (i)「只需重述假设」那一半的交付物——
> **把"正确的假设该怎么写"写成一条精确到量词的命题**。
> **它现在没有证明。** 本 attempt 的 `proof.md` 不存在，`status.yaml` 的 `state` 是 `draft`。
> 要证它还差 `scoping.md` 第 6 节列的 P1（唯一困难的一条）与 P3。
> 在 `graph-reviewer` 判定之前，**图里任何节点不得 `depends_on` 本文件**。

---

## 0. 为什么需要重述，而不是直接引用 Thm 5.1

Borcherds 1992 Thm 5.1 的假设逐字是（**[B-逐字]**，`literature/extractions/borcherds-1992.md` E1）：

> "Suppose that `V` is a vector space with a nonsingular bilinear form `(,)` and suppose that `V` is
> acted on by the Virasoro algebra in such a way that the adjoint of `L_i` is `L_{−i}`, the central
> element of the Virasoro algebra acts as multiplication by 24, any vector of `V` is a sum of
> eigenvectors of `L_0` with **nonnegative integral eigenvalues**, and all the eigenspaces of `L_0`
> are **finite dimensional**."

本项目的动量塔不是这个形状的 `V`：

| Thm 5.1 的 `V` | 本项目的塔 |
|---|---|
| 抽象 Virasoro 模，中心荷 24 | 具体 `D` 个自由玻色子的 Fock 塔，中心荷 `D` |
| 再与 `V_{II_{1,1}}` 张量才得到 `H`（中心荷 26） | 塔**本身**已经是"`H`"：`𝔥` 内已含双曲平面 `span(b, b′)` |
| 度数按二维格 `II_{1,1}` 分 | 层指标 `j ∈ Z` 分次（`= ` 沿 `b` 方向的一维分次），横动量连续 |
| `L_0` 本征值 `∈ Z_{≥0}` | `L_0` 本征值 `∈ a₀ + Z`，`a₀ = α'k²` 一般不是整数 |
| `L_0` 本征空间有限维 | 塔上**无限维**（层数无穷）；**但每个双分次片 `T_{j,N}` 有限维** |
| `L_0 = 1` 定义 `H¹` | 截距 `a₀`，由基点钉死 |

`scoping.md` §2 的结论是：**这五处差别里，前四处是记号错位（Borcherds 的 `H` 对应塔的一个单层，
不是对应整个塔），第五处（截距）是真差别、必须写进前件。**

---

## 1. 记号与设定

沿用 `worldsheet.momentum-tower-fock-space`、`worldsheet.ddf-operators-v6`、
`worldsheet.virasoro-generators-free-boson`、`worldsheet.tower-physical-quotient-form` 的记号
（`conv.metric-mostly-plus`、`conv.alpha-prime-regge`、`conv.virasoro-standard`、
`conv.intercept-sign-a`）：

- `D ∈ N`，`D ≥ 2`；系数环 `R` 是**有序域**（正定性一半需要；只要张成的一半时 `R` 取交换
  `Q`-代数即可，见 §3 备注）。
- `η(x,y) = Σ_μ η_μ x^μ y^μ`，`η_μ ∈ {±1}`，`η` 非退化；`𝔥 := R^D`。
- `a, b ∈ 𝔥`：
  - **(N)** `η(b,b) = 0`；
  - **(S)** `η(a,b) = 1`；
  - **(A)** `η(a,a) = 2`（等价 `a₀ := ½η(a,a) = 1`，等价 `η(v,v) = 0`，`v := a − b`）。
    **← 这一条是新增的前件，是本文件的核心增量。**
- `T(a;b) := ⊕_{j ∈ Z} F(a + jb)`（代数直和），双分次 `T_{j,N}`（层 `j`、振子能级 `N`），
  层间正交的 `R`-双线性型 `⟨·,·⟩_T`。
- `L_m`：逐层 Sugawara 生成元，不移动层指标；`[L_m, L_n] = (m−n)L_{m+n} + (D/12)(m³−m)δ_{m+n,0}`。
- **(D26)** `D = 26`。
- `Ε = (ε_1, …, ε_{D−2})`：**(T)** `η(ε_i, b) = 0`、**(O)** `η(ε_i, ε_j) = δ_{ij}`。
- `H_phys := {Ψ ∈ T(a;b) : (L_0 − a₀)Ψ = 0 且 L_mΨ = 0 ∀m ≥ 1}`（此处 `a₀ = 1` 由 (A)）。
- `D(Ε) := span_R{A^{ε_{i_1}}_{−n_1} ⋯ A^{ε_{i_r}}_{−n_r}|0;a⟩ : r ≥ 0, n_j ≥ 1}`。
- `H_null := H_phys ∩ H_phys^⊥`。

---

## 2. 命题

### Thm 5.1′（候选，**未证**）

> **设** `D`、`R`、`η`、`a`、`b`、`Ε` 如 §1，**且**满足 (N)、(S)、**(A)**、(T)、(O)、(D26)。
> **则**
>
> ```
> ∀ Ψ ∈ H_phys,  ∃ φ ∈ D(Ε),  ∃ χ ∈ H_null,   Ψ = φ + χ 。
> ```
>
> 即 `H_phys ⊆ D(Ε) + H_null`。

### 与目标卡的差别（**唯一**一条）

`worldsheet.ddf-spanning-hypothesis` 的断言逐字相同，**但没有前件 (A)**。
`scoping.md` §5.4 给出机检反例：去掉 (A)（取 `a₀ = 2`）后，命题在片 `(j,N) = (−1,1)` 上
对一切 `D ≥ 2` 为假。故

> **Thm 5.1′ = 目标卡 + 前件 (A)，且 (A) 不可省。**

### 与已形式化的 level-one 卡的关系

`worldsheet.ddf-spans-physical-states-level-one-modulo-null`（`formalized`）是 Thm 5.1′ 限制在
片 `(−1,1)` 上的版本，前件里用 (T′) `η(ε_i,a) = 0` + (C)「`Ε` 在 `v^⊥` 上完备」代替 (A)、(D26)。
`scoping.md` §5.4 证明 **(T)+(T′)+(O)+(C) ⟹ (A)**（`R` 为域时），故那张卡的前件**强于** (A)，
两者不冲突；那张卡自称的"不需要 `a₀ = 1`"应读作"不显式写 `a₀ = 1`"。

---

## 3. 关于 Thm 5.1 原假设逐条的处置（重述的正文）

这一节逐条说明：Borcherds 的哪条假设在本设定里变成了什么。依据全在 `scoping.md` §2–§4。

| Thm 5.1 的假设 | 在 Thm 5.1′ 里的对应物 | 依据 |
|---|---|---|
| `V` 有非退化形式 | 每层 Fock 形式非退化（`⟨·,·⟩_T` 限制到 `F(a+jb)`） | §4.2 结论 9：§5 只用到**单度数片上**的非退化 |
| `L_i` 的伴随是 `L_{−i}` | 同（Sugawara 生成元的伴随） | §4.5 结论 12 |
| 中心元作用为 24 | `D = 26`（前件 (D26)）。**不是 `D = 25`** | §3.3 结论 7：`24 + 2` 的那个 `2` 是 `𝔥` 内光锥平面的维数，不是格的秩 |
| `L_0` 本征值 `∈ Z_{≥0}` | 本征值 `∈ a₀ + Z`，谱下有界不必要 | §2.4 结论 3 |
| `L_0` 本征空间有限维 | **改为**：每个双分次片 `T_{j,N}` 有限维（自动成立） | §2.1–§2.3：该假设的主语是 `V`；Borcherds 自己的 `V ⊗ V_{II_{1,1}}` 同样不满足有限维，他本人在 §3 逐字写明 |
| `II_{1,1}` 是二维偶自对偶洛伦兹格 | **只需要** `𝔥` 内有一个含 `b` 的双曲平面（即 (N)+(S) 给出的 `span(a,b)`） | §3.5：自对偶性、离散动量、秩 2 在 §5 一次未用 |
| 度数 `r ∈ II_{1,1}`，`(r,w) ≠ 0` | 层指标 `j`，`r ↔ a + jb`，`w ↔ b`，`(r,w) = η(a+jb, b) = 1 ≠ 0` **由 (S) 自动** | §3.1 结论 5、D2 |
| `L_0 = 1`（`H¹`） | **前件 (A)** `a₀ = 1` | §3.4 结论 8 |

**备注（`R` 的要求）**：Thm 5.1′ 的断言本身（张成）不涉及正定性，`R` 取交换 `Q`-代数即可；
`R` 是有序域只在把 Thm 5.1′ 接到无鬼定理（正定性）时需要，那一步本项目已 `formalized`
（`worldsheet.no-ghost-theorem-conditional-on-ddf-spanning`，Lean `no_ghost_of_spans`），
**对任意 `D`、任意有序域成立** **[项目]**。

---

## 4. 证明状态

**无证明。** `scoping.md` 第 6 节把证明义务拆成 P1–P5：

| 命题 | 状态 |
|---|---|
| P1（Lemma 5.2 首句的塔上版本：单项式构成整层的基） | **完全开放**，唯一真困难的一条 |
| P2（每层形式非退化 + 两条伴随关系） | 多半已在本项目 Lean 里，待核对 |
| P3（Lemma 5.4 的塔上版本：`L_{−1}`、`L_{−2}+3L²_{−1}/2` 把 `S¹` 映进 `S`，当且仅当 `D=26, a₀=1`） | 教科书级计算，未机检 |
| P4（`T_j = D(Ε) ∩ T_{j,−j}`，靠维数比较，**绕开算子字典**） | 需要 P1 |
| P5（逐片 ⟹ 全塔） | **已完成**（Lean `ddfSpans_of_forall_antidiagonal_slice_int`） |

`[GAP: P1]` 是整条路线的唯一硬缺口。**在 P1 被证明之前，本文件的 Thm 5.1′ 不比
`worldsheet.ddf-spanning-hypothesis` 多任何论证强度——它只是把那张卡的表述改对了。**
