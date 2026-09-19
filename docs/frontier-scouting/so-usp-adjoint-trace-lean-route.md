# `math.so-usp-adjoint-fundamental-trace-identities` 的 Lean 路线评估

**日期**：2026-09-19
**参与**：scout（general-purpose agent `souspscout`，只读）；lead（复核 + 独立数值验证）
**触发**：`docs/LEVERAGE-ANALYSIS.md` §9.2 测出该卡是一个 **+3 单卡杠杆**，
但该节明写「**本节不对成本下结论**，已另派 scout 评估」。本文件是那个结论。

---

## 结论

**MODERATE（可做），不是 EXPENSIVE。** 存在一条自足的、不经过根系/权论/Chevalley 限制的
初等路线，估计 **400–700 行 Lean**。scout 的初版裁决是 EXPENSIVE，锚定在**错误的路线**
（E₈ 式的根系路线）上；lead 指出 Λ² 框架后 scout 自行改判，并按要求明确表态
「这是真实修正，不是顺着说」（照录见下）。

⚠ **本文件不构成派工决定。** 这 +3 **不命中任何里程碑**（全部落在 `math.*` 反常区），
是否值得投 400–700 行是船长的资源判断，不是 lead 能单方面认领的。

---

## 1. 数学路线（scout 手推，lead 复核 + 数值验证）

令 `V = R^N`，`F` 是 `N×N` 矩阵，`D := F⊗1 + 1⊗F` 作用在 `V⊗V` 上。两个求和项**对易**，
故二项式定理给 `D^k = Σ_m C(k,m) F^m ⊗ F^{k-m}`。配两条初等张量事实

    tr_{V⊗V}(A⊗B)            = tr(A)·tr(B)
    tr_{V⊗V}((A⊗B)∘swap)     = tr(A·B)

`F` 在 `Λ²V`（resp. `Sym²V`）上的诱导作用是 `D` 经投影 `½(1∓swap)` 限制，于是

    Tr(Λ²F)^k   = ½[ Σ_m C(k,m) tr(F^m)tr(F^{k-m}) − 2^k·tr(F^k) ]
    Tr(Sym²F)^k = ½[ Σ_m C(k,m) tr(F^m)tr(F^{k-m}) + 2^k·tr(F^k) ]

⭐ **两条公式的组合结构与 N 无关**：`N` 只经由 `tr(1) = N` 出现在 `m = 0` 与 `m = k`
两项里，从不进入二项式结构本身。这正是绕开 scout 初版所担心的「秩无界」障碍的地方——
整条推导里没有任何一个秩在增长的根系。

**奇次迹自动为零，两支各一行**：
- `so(N)`：`Fᵀ = −F` ⟹ `tr(F^k) = tr((Fᵀ)^k) = (−1)^k tr(F^k)` ⟹ `tr(F^odd) = 0`。
- `usp(N)`（辛型 `J`，`J² = −1`）：`FᵀJ = −JF` ⟹ `Fᵀ = −JFJ⁻¹` ⟹
  `tr(F^k) = (−1)^k tr(J F^k J⁻¹) = (−1)^k tr(F^k)`（共轭不变）⟹ 同样结论。

⭐ **两支靠同一个一行技巧拿到奇次消失**，故本路线**覆盖 usp(N)**——
而该卡 `sources` 里 antonelli-2015 那条的 note 逐字记着「本项目未逐步复核这一推导，
**也未核实它是否覆盖 usp(N)**」，Polchinski 更是只给 SO(n) 支。

代入 `k = 2, 4, 6`（奇次项全灭）：

| k | `Σ_m C(k,m)tr(F^m)tr(F^{k−m})` | `Tr(Λ²F)^k` (l = −1) | `Tr(Sym²F)^k` (l = +1) |
|---|---|---|---|
| 2 | `2N·tr F²` | `(N−2) tr F²` | `(N+2) tr F²` |
| 4 | `2N·tr F⁴ + 6(tr F²)²` | `(N−8) tr F⁴ + 3(tr F²)²` | `(N+8) tr F⁴ + 3(tr F²)²` |
| 6 | `2N·tr F⁶ + 30 tr F² tr F⁴` | `(N−32) tr F⁶ + 15 tr F² tr F⁴` | `(N+32) tr F⁶ + 15 tr F² tr F⁴` |

与卡面 `Ω₄ = (N+2l)tr F²`、`Ω₈ = (N+8l)tr F⁴+3(tr F²)²`、
`Ω₁₂ = (N+32l)tr F⁶+15 tr F² tr F⁴`（`l = −1` SO / `l = +1` USp）**逐项精确吻合**，
两支都吻合。lead 已逐条手算复核（含 `C(6,2)+C(6,4) = 30`、`2⁶ = 64`）。

---

## 2. ⭐ lead 的独立数值验证：把 scout 唯一没查的那一步查了

scout 的修订裁决**明确附带一条未 derisk 的条件**（照录）：

> "conditional on the one part I have not derisked: showing that this abstract
> 'Λ²/Sym² of the fundamental, computed via V⊗V and swap' formula is actually
> *equal to* Tr(ad F)^k on the literal Lie algebra so(N)/usp(N) as defined in
> Mathlib's `Classical.lean` … That's a basis/index-matching exercise … that I
> have not attempted and is exactly the kind of bookkeeping that has ballooned
> before in this repo (NoGhost/*)."

**lead 已经做了这一步的数值验证**，脚本 `docs/frontier-scouting/so-usp-adjoint-trace-check.py`
（精确整数运算，无浮点）。做法不是重算张量侧，而是**从另一头逼近**：
在李代数的**显式基**上把 `ad(F)(X) = FX − XF` 组装成一个显式矩阵，直接算 `Tr((ad F)^k)`，
再与上表右端比较。线性求解同时 assert「`ad(F)(X)` 仍落在代数内」，故顺带验证了基的正确性。

覆盖与结果：

    so(N):    N = 3,4,5,6,7,8      各 2 个随机整系数元素   k = 2,4,6
    sp(2n):   N = 2,4,6,8          各 2 个随机整系数元素   k = 2,4,6
    ------------------------------------------------------------------
    TOTAL ok=60 bad=0

**60/60 精确相等，两支、三个 k、十组 (N, 元素) 全中。**

⇒ **scout 标为「主要剩余风险」的那条桥，在数学层面不是风险**：`so(N) ≅ Λ²V`、
`sp(N) ≅ Sym²V` 作为伴随模的识别是对的，诱导作用确实就是 `ad`，系数也对。
**剩下的是纯 Lean 工程量，不是未知的数学。**

⚠ **本条的边界**：这验证的是**小 N 的具体实例**，不是对一切 `N` 的证明。它排除的是
「公式或识别本身错了」这一类失败（那会在某个小 `N` 上立刻暴露），**不**替代 Lean 里
对一般 `N` 的归纳/组合论证。估工时仍按 scout 的 400–700 行算。

---

## 3. 关于 E₈ 先例：scout 的结论对，给出的机制在图上不成立

scout 用 E₈ 卡做先例，论证「把根系形式化买不到升级」：即便 `Math/E8Roots.lean`
已经把 240 个根与幂和全部形式化，`math.e8-adjoint-trace-identities` **仍然**是
physical-argument，因为根幂和 → 伴随迹那道桥（Chevalley 限制）没进 Lean。

**这个工程结论是对的**，而且有仓库自证：`formal/CLAUDE.md` 对 `Math/E8Roots.lean` 逐字写着
「**Tr₂₄₈ = 根幂和 + Chevalley 限制是 docstring 假设不在 Lean 内**」。

**但 scout 给的图上机制不成立。** lead 实测：

```
$ uv run stringgraph counterfactual math.chevalley-restriction-theorem
moved (0 other active cards):
$ uv run stringgraph counterfactual math.chevalley-restriction-theorem math.adjoint-weights-are-roots-and-zero
moved (0 other active cards):
$ uv run stringgraph status math.adjoint-weights-are-roots-and-zero
own_status: rigorous
effective:  rigorous
```

强制 Chevalley 为 rigorous **一张卡都不动**；连同另一座桥一起强制，**还是一张都不动**；
而且推导自己点名的两座桥里，`adjoint-weights-are-roots-and-zero` **早已是 rigorous**。

真正封顶的是 `math.e8-adjoint-trace-identities--via-root-power-sums` 自己的
`status: physical-argument`——`effective = min(own, deps)`，own 一旦压低，改多少依赖都没用；
该卡两条推导 own 都是 physical-argument。

⚠ **一条实质数据缺陷（lead 发现，未修）**：该推导对
`math.adjoint-weights-are-roots-and-zero` 那条依赖的 note 仍写着
「physical-argument（来源 L0）」并「本推导的有效状态被它与上一条桥压在 physical-argument」。
**这条 note 已过时**：被点名的两座桥之一现在是 rigorous。属 curator 领域，见 §4。

**两个问题要分开问**，scout 把它们合并了：
- *图上什么封顶了这张卡？* → 它自己的 own status。
- *Lean 里还差什么活？* → 根幂和 → 伴随迹那道桥。

两者都真，但只有后者支持 scout 的建议（别去投根系家族的形式化）。**该建议照收。**

---

## 4. 方法论副产品：自封顶的一个**误用**形态

`docs/LEVERAGE-ANALYSIS.md` §4 已把自封顶当**统计量**记录（86.9% 的弱卡自封顶）。
E₈ 这张卡暴露的是一个更窄、更值得单独记的**误用**形态：

> 把一条推导的 **own status** 调低，用来反映**依赖弱**，而不是反映**这一步自身论证的松紧**。

后果有两条：
1. **重复计账**。`graph/CLAUDE.md` 明写「status 写自身论证的严格程度」；依赖的弱已经由
   `effective = min(own, deps)` 传播一次，own 再压一次就是同一条弱算两遍。
2. **让 `counterfactual` 失明**。工具会如实报「强制这个依赖，0 张卡移动」——
   **作为数据是对的，作为工程判断是错的**，因为那个依赖确实是真实的待办。

这与 §9.1 记的打平盲点**不是同一件事**：打平盲点让 `roots`/`bottleneck_roots` 只跟一条推导，
而 `counterfactual` 本来是它的解药（真强制 + 真重算，不走 `bottleneck_roots`）。
本形态把**解药本身**也挡住了。

**未修，待定**：改 `--via-root-power-sums` 的 own status 属于 curator + reviewer 领域的实质
图数据判断（要判断这一步自身论证到底有多严），lead 不在调研途中单方面改。
过时的 note（§3 末）与 own status 该不该动，建议一并派 curator 处理。

---

## 5. scout 自报的未查项（照录，不代为消化）

- 没有逐行读 Mathlib `Algebra/Lie/` 下的 `Killing.lean` / `SerreConstruction.lean`，
  只 grep 了相邻文件（`TraceForm.lean`、`InvariantForm.lean`）并列了目录。
- 没有对着 antonelli-2015 原文复核 §2.3.1 的推导，只有图里的抽取记录——
  而那条记录自己就说本项目从未逐步核过、也不覆盖 usp(N)。
- 没有在 Mathlib 里广搜对称函数 / Newton 恒等式机器（`MvPolynomial`、
  `SymmetricFunctions` 一带）；只看了 Lie 代数目录与 `LinearAlgebra/ExteriorPower/`
  （后者只有 `Basic` / `Basis` / `Pairing`，**没有**诱导映射的迹引理）。
- **整条 Λ² 路线没有在 Lean 里试过任何一步**，全是纸上手算。
  （⚠ lead 补：其中的基匹配桥已由 §2 的数值验证覆盖；Lean 工程量本身仍未试。）
- 没查是否有已 rigorous 的图节点能抄近路做「伴随 = 基本表示的 Λ²/Sym²」这一步
  **专门对经典型**的识别——`math.adjoint-weights-are-roots-and-zero` 是对一般半单 𝔤
  经根空间陈述的，不直接适用。
- 没有超出卡上已引文献（GS 1984、Bilal 2008、GSW、Polchinski、antonelli-2015）去找
  是否有哪个来源给了覆盖 so 与 usp 两支的、一般 N 的干净完整证明。**若存在，
  可以把本路线从「自己发明证明」降成「照抄证明大纲」，显著降风险。**

lead 补一条 scout 未提的：该卡的四个来源**全都不给证明**（GS 无证明动词、
Bilal「without proof」、GSW「it is easy to show」、Polchinski 留作 Exercise 12.1）。
这既是该卡 status 只能是 physical-argument 的原因，也意味着**没有现成大纲可抄**——
除非上面最后一条的文献搜索找到东西。

---

## 6. 复现

```bash
python docs/frontier-scouting/so-usp-adjoint-trace-check.py    # 60/60，见 §2
uv run stringgraph counterfactual math.so-usp-adjoint-fundamental-trace-identities   # +3
uv run stringgraph counterfactual math.chevalley-restriction-theorem                 # 0
uv run stringgraph status math.adjoint-weights-are-roots-and-zero                    # rigorous
```
