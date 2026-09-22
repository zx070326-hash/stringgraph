# Scoping：Borcherds 1992 Thm 5.1 能否推广到本项目动量塔所在的设定

- **作者**：prover（agent），2026-09-22
- **分支**：`agent/prover/borcherds-rank-one-noghost`
- **本文的地位**：`research/` 草稿。**不得被 `graph/` 任何节点 `depends_on`**，未经 graph-reviewer 审查不得毕业。
- **原始材料**：`literature/extractions/borcherds-1992.md` 的 **E4–E8**（本轮追加的 §5 证明正文逐字抽取）。
  下文凡写「E5 逐字」即指该文件对应小节，不再重复引用原文。

## 0. 证据等级标注

每条结论必须带下列标签之一：

| 标签 | 含义 |
|---|---|
| **[B-逐字]** | Borcherds 原文的字面文字，落在 E4–E8 里，可直接对照 |
| **[计算]** | 我从原文 §3 的定义出发做的计算；推导过程写在本文里，可独立复核 |
| **[解读]** | 我的读法，既无逐字支持也无完整验算；**最弱，不承载裁定** |
| **[项目]** | 本项目 `graph/` / `formal/` 里已有的内容（只读引用，未改动） |

**承载裁定的每一条都必须是 [B-逐字] 或 [计算]。** 凡标 [解读] 的地方，裁定不依赖它。

---

## 1. 对象字典（先建立，Q1–Q3 全靠它）

Borcherds 的记号一律按 E5；本项目记号按 `worldsheet.momentum-tower-fock-space` /
`worldsheet.ddf-spanning-hypothesis`（重标度 `a := (2α')^{1/2}k`、`b := (2α')^{1/2}k_0`，
`η(b,b)=0`(N)、`η(b,a)=1`(S)，第 j 层动量 `a + j·b`，双分次片 `T_{j,N}`）。

### D1. `K_i` 是**沿 w 的 Heisenberg 模**，不是 DDF 算子 **[计算]**

Borcherds **[B-逐字, E5]**：`K_i = v_{i−1}`，`v = e^{−w}_{−2}e^w ∈ V_{II_{1,1}}`，
`(w,w) = 0`，且 `[L_i,K_j] = −jK_{i+j}`、`[K_i,K_j] = 0`、`K_i† = K_{−i}`。

算 `v`。按格顶点代数的标准顶点算子（E7 逐字给出底空间 `Q(L̂) ⊗ S(⊕_{i>0}L_i)`）：

```
Y(e^α, z) = E^−(−α,z) E^+(−α,z) e_α z^{α(0)},   E^±(−α,z) = exp( Σ_{±n>0} (−α(n)/n) z^{−n} ).
```

取 `α = −w` 作用在 `e^w` 上：

1. `z^{α(0)} e^w = z^{(−w,w)} e^w = z^0 e^w`（因 `(w,w)=0`）；
2. `e_{−w} e^w = ε(−w,w)·1`（真空，`ε = ±1` 是双覆盖的 2-上循环；E5 逐字说明这个 ±1 在
   `e^{−w}_{−2}e^w` 里抵消，故与下文无关）；
3. `E^+(w,z)·1 = 1`（正模湮灭真空）；
4. `E^−(w,z) = exp(−Σ_{m>0} (w(−m)/m) z^m) = 1 − w(−1)z + O(z²)`。

故 `Y(e^{−w},z)e^w = ε·(1 − w(−1)z + O(z²))`，而 `u_{−2}x` 取的是 `z^{−(−2)−1} = z^1` 的系数：

> **`v = e^{−w}_{−2}e^w = −ε·w(−1)·1`。**

即 `v` 是 `II_{1,1}` 的 Heisenberg 部分里沿 `w` 的权 1 流（共形权按
`wt(u_n x) = wt u + wt x − n − 1 = 0 + 0 + 2 − 1 = 1` 核对一致）。于是

> **`K_i` 属于沿 `w` 的 Heisenberg 模族 `{w(n)}_{n∈Z}`（差一个 ±1 与一个指标平移）。**

指标核对：若 `K_i = ±w(i)`，则 `[L_i, w(j)] = −j·w(i+j)` 精确给出原文的 `[L_i,K_j] = −jK_{i+j}`，
`[w(i),w(j)] = i(w,w)δ_{i+j,0} = 0` 精确给出 `[K_i,K_j]=0`（且原文 **[B-逐字]** 把它归因于
"because w has norm 0"），`w(i)† = w(−i)` 给出 `K_i† = K_{−i}`。**三条关系同时对上。**
而原文写的 `K_i = v_{i−1}` 在同样约定下给 `[L_i,K_j] = −(j−1)K_{i+j}`，与它自己列的关系差一个指标。
（已记入 `literature/extractions/borcherds-1992.md` 追加疑问 4。）**本文一律以原文列出的三条对易关系为准**，
它们把 `K_i` 唯一地钉成 `w` 的 Heisenberg 模族；差一个指标不影响下面任何一步。

**这条推翻了本项目现有抽取记录里的一句话**（`literature/extractions/borcherds-1992.md`
第 54 行与「未解决的疑问 2」：称 `K_i` 与本项目 `A^ε_n` "在物理上是同一族"）。理由是决定性的：

- `v` 的格度数是 `(−w) + w = 0`，故 **`K_i` 保持 `II_{1,1}`-度数**，在固定度数的 `H` 上闭合；
- 本项目的 `A^ε_n` **把第 j 层搬到第 j−n 层**（含 `e^{i n k_0·x}` 移位算子）。

**保度数的算子不可能等于移层算子。** 两者的关系是别的：DDF 态被 `k_0·α_{i>0}` 湮灭（见 D4），
所以 `D(Ε) ⊆ T`；这是一个包含，不是记号翻译。

### D2. `(r,w) ≠ 0` 的作用：`K_0` 在 `H` 上是非零标量 **[计算]**

**[B-逐字, E4]**：证明第一句是 "Fix some nonzero `r ∈ II_{1,1}` and some norm 0 vector `w` in
`II_{1,1}` with `(r, w) ≠ 0`."

由 D1，`K_0`（= `w` 的零模，在原文的对易关系下与所有 `L_i`、`K_j` 对易）在度数 `r` 的空间 `H` 上
按标量 `(w,r)` 作用。它在证明里的用处是唯一且关键的：

- 纯 K 单项式**全是零范矢量**：对 `f ∈ T`、`n,m > 0`，
  `(K_{−n}f, K_{−m}f) = (f, K_n K_{−m} f) = (f, K_{−m} K_n f) = 0`（用 `K_i†=K_{−i}`、`[K,K]=0`、
  `K_n f = 0`）。
- 使 Lemma 5.1 的内积矩阵"对角非零"的，是 **L 单项式与 K 单项式之间**的配对，最低阶的一个是
  `(L_{−n}f, K_{−n}f) = (f, L_n K_{−n} f) = (f, [L_n,K_{−n}]f) = n(f, K_0 f) = n·(w,r)·(f,f)`
  （用 `L_n f = 0`（`f ∈ T ⊆ P`）与 `[L_n,K_{−n}] = nK_0`）。

> **`(r,w) ≠ 0` 就是使 Lemma 5.1 的"对角非零"成立的那个标量。**

**本项目侧的对应物 [计算]**：取 `w ↦ b`、`r ↦ a + j·b`（第 j 层的重标度动量），则
`(r,w) = η(a + jb, b) = η(a,b) + j·η(b,b) = 1 + 0 = 1 ≠ 0`，**对一切层 j 同时成立**，
而且它逐字就是本项目的标度条件 (S) `η(b,a) = 1`。

### D3. Borcherds 的 `H`（固定度数 r）↔ 本项目的**一层**，不是整座塔 **[计算]**

**[B-逐字, E5]**：`H is the subspace of V ⊗ V_{II_{1,1}} of degree r ∈ II_{1,1}`；
§5 出现的**每一个**子空间（`H, H¹, P, P¹, S, S¹, N, N¹, T, T¹, K, Ve^r`）都是 `H` 的子空间，
**每一个算子（`L_i`、`K_i`）都保持度数**（`ω` 与 `v` 的格度数都是 0）。
即：**§5 的全部论证发生在单一度数片内部，从头到尾没有移动过度数。**

对照本项目：`F(a + jb)`（第 j 层的 Fock 空间）= 26 个振子族作用在单一动量本征态上；
`(V ⊗ V_{II_{1,1}})_r = V ⊗ e^r ⊗ S(⊕_{i>0}(II_{1,1}⊗R))` = （V 提供的横向自由度）⊗（2 个类光振子族）
⊗ 单一动量 `e^r`。两者在 `V =` 横向 24 个振子族时是同一个对象。

> **字典：Borcherds 的 `H`（度数 r）↔ 本项目的第 j 层 `F(a+jb)`，`r ↔ a + j·b`。**

再叠上质量壳：**[项目]** `L_0` 在第 j 层能级 N 上的本征值是 `a₀ + j + N`（用 (N)(S)），
物理条件 `L_0 = a₀` 把塔压到反对角 `j + N = 0`（Lean `massShell_of_mem_towerBigrade`）。
于是

> **Borcherds 的 `H¹`（度数 r、`L_0 = 1`）↔ 本项目的一个双分次片 `T_{−N,N}`。**

两侧都是**有限维**的。

### D4. 横向空间：Borcherds 的 `T` 是核，本项目的 `D(Ε)` 是像 **[B-逐字 + 计算]**

**[B-逐字, E5]**：`T, the transverse space, is the subspace of P annihilated by all the operators
K_i, i > 0`。由 D1，这就是"被所有 `k_0·α_i`（`i>0`）湮灭的物理态"。

**[计算]** DDF 态满足这个条件：`[b·α_m, A^ε_n] = 0`，因为 (i) `[b·α_m, ε·α_n] = m·η(b,ε)δ_{m+n,0} = 0`
（横向性 (T)），(ii) `[b·α_m, e^{i n k_0·x}] ∝ n·η(b,b) = 0`（类光性 (N)）；而 `b·α_{i>0}|0;a⟩ = 0`。
故 **`D(Ε) ⊆ T`**。反包含 `T ⊆ D(Ε)` 正是要证的东西，**不是**字典。

### D5. 形式（bilinear form）：见 Q3。

### D6. 截距：Borcherds 固定在 `L_0 = 1` **[B-逐字, E5]**

`H¹ is its subspace of vectors h with L_0(h) = h`，其后 `P¹, S¹, N¹, T¹` 全部带上标 1。
本项目的截距是 `a₀ := α'k² = ½η(a,a)`，**不固定为 1**。这条差别的后果见 Q2 §2.4 与第 5 节。

---

## 2. Q1：「`L_0` 本征空间有限维」这条假设在证明正文里被用在哪

### 2.1 这条假设的主语是 `V`，不是 `H`，也不是 `V ⊗ V_{II_{1,1}}` **[B-逐字]**

Theorem 5.1 的假设逐字（E1，已有抽取）：
"…any vector of **V** is a sum of eigenvectors of `L_0` with nonnegative integral eigenvalues,
and all the eigenspaces of `L_0` are finite dimensional"——整句的主语是 **V**。

而 Borcherds **本人在 §3 明确写出**（E7 逐字，**本轮新抽取**）：

> "The vertex algebras used in this paper all have conformal vectors but the eigenspaces of `L_0`
> are not always finite dimensional. **An example of a vertex algebra without these properties is
> the vertex algebra `V_{II_{1,1}}`** of the 2-dimensional even unimodular Lorentzian lattice `II_{1,1}`."

**[计算]** 核对为什么：`V_{II_{1,1}}` 的 `L_0` 本征值是 `(r,r)/2 + n`（`r ∈ II_{1,1}`，`n` 为振子能级）；
`II_{1,1}` 是洛伦兹格，任一给定范数 `(r,r)` 都有**无穷多**个 `r`（例如 `(m,n)` 范数 `−2mn`，
固定 `mn` 有无穷多解），故每个 `L_0` 本征空间无限维。

> **结论 1 [B-逐字 + 计算]：Borcherds 自己的工作空间 `V ⊗ V_{II_{1,1}}` 的 `L_0` 本征空间也是无限维的，
> 而且他知道、并且写下来了。**

**这直接改写了本项目卡 `worldsheet.momentum-tower-is-borcherds-no-ghost-instance` 边界 (a) 的问题。**
那条边界说"Thm 5.1 假设 `L_0` 本征空间全有限维，本项目塔上此条为假"。
两件事都对，但**它们不构成冲突**：本项目的塔不是 `V` 的类比物，是 `V ⊗ V_{II_{1,1}}` 的类比物，
而后者的 `L_0` 本征空间**同样**无限维。两边的失效方式、失效原因**完全相同**：

| | 无限维的原因 |
|---|---|
| `V ⊗ V_{II_{1,1}}` | 固定 `L_0` 本征值时，度数 `r` 在洛伦兹格上有无穷多解 **[计算]** |
| 本项目塔 `⊕_j F(a+jb)` | 固定 `L_0 = a₀ + j + N` 时，`(j,N)` 有无穷多解（一切 `j ≤ m`）**[项目]**（卡 `free-boson-vertex-algebra-with-lightlike-momentum-tower` 边界 (N3)(b) 记的就是这件事） |

**Borcherds 的应对办法就是固定度数**（D3）：`H := (V⊗V_{II_{1,1}})_r`。在固定度数上，
`L_0` 本征空间 `= ⊕_{i+n=const} V^i ⊗ (2 族振子的第 n 级)`，**只要 `V` 的本征空间有限维且谱下有界，
它就有限维**。本项目的对应动作是固定层指标 `j`（等价地，由质量壳固定能级 `N`）。

### 2.2 假设在 §5 正文里被用在哪：**只有一个可能的落点，而那一步没有证明** **[B-逐字]**

逐步扫描 §5 的每一句证明正文（E6 是全文，除此之外 §5 无其它正文）：

| 步骤 | 证明正文说了什么 | 是否用到 `V` 的本征空间有限维 |
|---|---|---|
| Lemma 5.1 | "It is possible to order these elements so that the matrix of inner products is upper triangular with nonzero diagonal elements." | **否 [计算]**。给定单个 `f`，每个 `L_0` 能级上的单项式 `L_{m_1}…K_{n_1}…f` 只有**有限**多个（分拆数），三角化 + 对角非零在每个能级的有限块上给出可逆；不同 `L_0` 本征值自动正交（`L_0† = L_0`）。这条有限性来自**分拆有限**，与 `V` 无关。 |
| Lemma 5.2 第 1 句 | "**the set of all vectors generated from them as in Lemma 5.1 is a basis for H**" | **这是唯一的落点**。见 2.3。 |
| Lemma 5.2 第 2–3 句 | "As H is nonsingular, T must therefore also be nonsingular"；`K = T ⊕ null(K)` | 否（前者靠 `H` 非退化，后者靠 `[K,K]=0`，见 D2 的零范计算）。 |
| Lemma 5.3 | "K is also the subspace of H annihilated by all the operators `K_i, i>0`" ⟹ `K = Ve^r ⊕ null(K)` | 否 **[计算]**：被所有 `w(i>0)` 湮灭的态恰是"没有 `w'` 振子"的态（`w'` 为与 `w` 配对的另一个类光方向），即 `Ve^r ⊗ S(w(−n))`；这是振子分解，不需要维数计数。 |
| Lemma 5.4 | "Calculation shows that the operators `L_{−1}` and `L_{−2}+3L²_{−1}/2` have this property…（中心荷 24 ⟹ 26）" | 否。 |
| Lemma 5.5 | 用 5.3 + 5.4 的纯代数分解论证 | 否。 |

> **结论 2 [B-逐字]：「`L_0` 本征空间有限维」这条假设在 §5 的证明正文里，
> 只可能用在 Lemma 5.2 的第一句；而那一句 Borcherds 没有给任何论证。**

### 2.3 Lemma 5.2 第一句是整条链的承重步，且它在 §5 里是**断言**

逐字（E6）：

> "**Proof.** If we choose an orthogonal basis for `T`, then **the set of all vectors generated from
> them as in Lemma 5.1 is a basis for H.** As `H` is nonsingular, `T` must therefore also be
> nonsingular. …"

**[计算]** 这句话的内容是一个特征标（维数）恒等式。设 `q` 记 `L_0` 分次，L/K 单项式的生成函数是
`∏_{n≥1}(1−q^n)^{−2}`（两族：`L_{−n}` 与 `K_{−n}`），于是"单项式构成 `H` 的基"等价于

```
ch T = ch H · ∏_{n≥1}(1−q^n)²  ( = ch V · q^{(r,r)/2} )。
```

这**恰恰就是 Lemma 5.3 的维数版本**（`T ≅ Ve^r`）。也就是说：Lemma 5.2 的第一句已经蕴含了
Lemma 5.3 的计数内容，而 Lemma 5.3 的证明反过来引用 Lemma 5.2。**整条链的计数内容集中在这一句，
而这一句在 §5 里没有论证。** 另外，逐字还有两处小瑕（已记入抽取记录疑问 5、6）：

- "If we choose an orthogonal basis for `T`"——Lemma 5.1 要求 `f` **非零范**，而"`T` 上形式非退化"
  正是本引理要证的结论；逐字读是循环的（至少需要补一句"先在非退化部分上做、再论证根为零"）。
- Lemma 5.5 首句 "By lemma 5.3, `p = k + s` for some unique `k ∈ K¹, s ∈ S¹`"——`H = K ⊕ S` 型分解
  在 5.2/5.3 的**陈述**里都没有逐字出现。

这不是在指摘一篇 Invent. Math. 论文：Borcherds **[B-逐字, E4]** 自己写的是
"For convenience we give a **quick sketch** of their proof"，并把完整证明归给 Goddard–Thorn [21]
与 Frenkel [15]。**但对本任务这是决定性的**：要判断某条假设能不能放宽，必须看它在证明里被用在哪；
而承载它的那一步在这份文本里**不存在**。

> **结论 3 [B-逐字]：无法从 Borcherds §5 读出"有限维假设被用在何处"，
> 因为唯一会用到它的那一步在 §5 里是无证明的断言。任何"§5 的证明只用到较弱的有限性"的说法，
> 都不能以 §5 为依据——只能以 GT 1972 / Frenkel 1985 的完整证明为依据，而本项目两者都未获取。**

### 2.4 本项目侧实际成立的有限性是什么形状，与假设差多远 **[计算]**

按 D3 的字典，本项目侧对应 `V` 的是**固定横向动量的横向 Fock 空间** `V := F_⊥(k_⊥)`
（`D−2 = 24` 个横向振子族）。它的 `L_0` 谱是

```
L_0^⊥ = α'k_⊥² + N_⊥,   N_⊥ ∈ Z_{≥0},   dim(第 N_⊥ 级) = p_{24}(N_⊥) < ∞。
```

逐条对 Thm 5.1 对 `V` 的假设：

| Thm 5.1 对 `V` 的假设 **[B-逐字]** | 本项目侧 | 差距 |
|---|---|---|
| 非退化双线性型 | ✓（横向 Fock 形式非退化，且在正交归一横向标架上正定）**[项目]** | 无 |
| Virasoro 作用，`L_i† = L_{−i}` | ✓ **[项目]** `worldsheet.virasoro-generators-free-boson` | 无 |
| 中心荷 = 24 | ✓ 当 `D = 26` 且切成 24 横向 + 2 类光 **[计算]**（见 Q2 §3.3） | 无 |
| `L_0` 本征空间**全有限维** | ✓ `p_{24}(N_⊥)` | **无差距** |
| `L_0` 本征值是**非负整数** | ✗ 一般为 `α'k_⊥² + Z_{≥0}`，`α'k_⊥² ∈ R` 任意 | **有差距** |

> **结论 4 [计算]：真正的差距不在"有限维"，在"整数"。**
> 本项目塔的每一层、每一片都满足有限维；不满足的是横向因子 `L_0` 谱的整性
> ——因为本项目的横向动量 `k_⊥` 是连续的，`α'k_⊥²` 一般不是整数。

**这条差距的形状**：谱仍然是**下有界**的、**按整数间隔**的（落在单个陪集 `c + Z_{≥0}`，`c := α'k_⊥²`）。
Lemma 5.1 的三角化只需要"分次、下有界、每级有限维"，Lemma 5.2 的计数只需要特征标是形式幂级数
——两者都只需要陪集版本。**所以这是一条"改写假设"级别的差距，不是结构性障碍**；
但按结论 3，这个判断**不能**以 §5 为依据（§5 没有给出会用到该假设的那一步），
只能作为"改写后的假设应该长什么样"的提案。提案写法见第 5 节。
