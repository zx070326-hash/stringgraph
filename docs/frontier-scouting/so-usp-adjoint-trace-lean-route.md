# `math.so-usp-adjoint-fundamental-trace-identities` 的 Lean 路线评估

**日期**：2026-09-19
**参与**：scout（general-purpose agent `souspscout`，只读）；lead（复核 + 独立数值验证）
**触发**：`docs/LEVERAGE-ANALYSIS.md` §9.2 测出该卡是一个 **+3 单卡杠杆**，
但该节明写「**本节不对成本下结论**，已另派 scout 评估」。本文件是那个结论。

---

## 结论

**MODERATE（可做），不是 EXPENSIVE。** 存在一条自足的、不经过根系/权论/Chevalley 限制的
初等路线。scout 的初版裁决是 EXPENSIVE，锚定在**错误的路线**
（E₈ 式的根系路线）上；lead 指出 Λ² 框架后 scout 自行改判，并按要求明确表态
「这是真实修正，不是顺着说」（照录见下）。

**估工时：650–1100 行**（lead 修订；scout 原估 400–700 行未计入
「Mathlib 里 so/sp 根本没有基」这一项，见 §2.5）。定性不变，数字上调。

⚠ **本文件不构成派工决定。** 这 +3 **不命中任何里程碑**（全部落在 `math.*` 反常区），
是否值得投 650–1100 行是船长的资源判断，不是 lead 能单方面认领的。

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

## 2.5 ⭐ Mathlib 侧的实测（lead，2026-09-19）：伴随作用是好消息，**真正的瓶颈在别处**

scout 在交回修订裁决时点名了「投人之前该查的下一件事」（照录）：

> "whether Mathlib's `LieAlgebra.Classical.so`/`sp` come with an existing
> `LieModule.toEnd`-based adjoint action and whether `ad(F)(X) = FX − XF` is already
> how that's phrased there … **That would be the next concrete thing to check before
> committing formalizer time.**"

lead 已查。结论分两半，方向相反。

### 2.5.1 伴随作用：**比 scout 期望的还顺**（利好）

    Classical.lean:168  def so n R := skewAdjointMatricesLieSubalgebra (1 : Matrix n n R)
    Classical.lean:159  def sp l R := skewAdjointMatricesLieSubalgebra (Matrix.J l R)
    SkewAdjoint.lean:114  def skewAdjointMatricesLieSubalgebra : LieSubalgebra R (Matrix n n R)

两支**都**是 `Matrix n n R` 的 `LieSubalgebra`，括号从环境矩阵代数继承；而环境括号就是
`LieRing.ofAssociativeRing`，且该实例带 `@[instance_reducible]`，`Ring.lie_def` 即
`⁅A,B⁆ = A*B − B*A`。配 `OfAssociative.lean:206` 的 `LieAlgebra.ad_apply : ad R L x y = ⁅x,y⁆`，
得 `ad(F)(X) = F*X − X*F` —— **正是 §2 数值脚本里 `ad_matrix` 组装的那个式子，逐字相同**。

佐证这不是纸面等式而是真能 unfold：`SkewAdjoint.lean:95` 的 `Matrix.lie_transpose`
证明体直接写 `show (A * B − B * A)ᵀ = …`，即 Mathlib 自己就在靠定义性展开吃这个括号。

⇒ **scout 担心的「Mathlib 可能用别的方式陈述括号，导致基匹配变难」不成立。** 这一层
预计 ~2 行，不是一个翻译层。

### 2.5.2 ⚠ 但 lead 顺手查出一条 scout **没查、也没预料到**的真瓶颈：**so/sp 在 Mathlib 里没有基**

    grep "Module.Free|Module.Finite|FiniteDimensional"  SkewAdjoint.lean Classical.lean  -> 空
    grep "Basis|finrank"                                 SkewAdjoint.lean               -> 空
    Classical.lean 的 `section ElementaryBasis` (101-141) **只服务 sl n R**
      （`single` / `singleSubSingle`，docstring 逐字说 "a natural basis of `sl n R`"），
      与 so / sp 无关。
    全 Mathlib 提到 `skewAdjointMatrices` 的文件只有 4 个，其中 2 个是双线性型文件。

为什么这条是**阻断性**的而不是装修问题：`Tr((ad F)^k)` 在 Lean 里要经 `LinearMap.trace`，
而 `LinearMap.trace` 要求底模是 **f.g. 投射/自由**。`↥(so n R)` 是 `Matrix n n R` 的一个
子模，Mathlib **没有给它 `Module.Free` / `Module.Finite` 实例，也没有基**。
⇒ **在把基造出来之前，本卡的目标陈述连「写得出来」都做不到**，谈不上证。

要造的东西 §2 的脚本其实已经写过一遍（Python 版）：
`so_basis`（`E_ij − E_ji`，`i<j`）与 `sp_basis`（`J·S`，`S` 对称）。Lean 侧要把它们做成
真正的 `Basis`（带线性无关 + 张成），再挂 `Module.Free`/`Module.Finite` 实例。

### 2.5.3 对估工时的影响：**上调，但不改「MODERATE 而非 EXPENSIVE」的定性**

- **性质不变**：这是常规线性代数（构造显式基并证两条性质），**不是缺定理**——
  与 §3 讲的根系路线缺 Chevalley 限制**根本不同**。它有确定的完成路径。
- **量变**：scout 的 400–700 行是在「基匹配是 bookkeeping」的假设下给的，而实际要从零造两族基。
  lead 的修正估计：**基与实例约 250–400 行（且这部分本质是 Mathlib 上游工作），
  加原路线 400–700 行，合计 650–1100 行。**
- ⚠ **诚实标注**：这个上调**推翻了 scout 估计的前提，但不是推翻它的裁决**。
  scout 把风险押在「张量公式是否等于 `Tr(ad F)^k`」（§2 已数值排除、§2.5.1 已确认 Lean 侧顺），
  真正的成本却在它没查的「子模有没有基」上。**风险定位错了，方向判断（可做）仍对。**

⇒ 交给船长的数字按 **650–1100 行**算，不按 400–700。

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

### 3.1 scout 的反驳与 lead 的接受：「缺定理」vs「缺计算」

lead 把上面的实测发回后，scout **接受了机制更正**，但补了一条**部分平反它原判**、
且比 lead 原框架更锋利的区分（lead 认为这条对，照收）：

| | 根系路线（E₈ 卡） | Λ² 路线（本卡） |
|---|---|---|
| 要把 `Tr_ad(F)^k = Σ_α α(H)^k` 从 **Cartan 的 H** 推到 **一般的 F** | **需要** | **不需要** |
| 那一步是什么 | 就是 **Chevalley 限制**（Ad-不变多项式在与每个共轭类相交的 Cartan 上相等 ⟹ 处处相等） | 无此步：公式对**任意**交换环上的**任意**矩阵一致成立 |
| Mathlib 里有吗 | **没有** | 不适用 |
| 缺口的类型 | **缺定理**（missing theorem） | **缺计算**（missing computation） |
| 诚实的终点 status | 只能停在 `physical-argument` | 可以正当地走到 `rigorous` / `formalized` |

⭐ **这条区分才是本次调研最该留下的东西**：两条路线都"缺一步"，但缺的**种类**不同，
而种类决定了 status 的天花板。Λ² 路线之所以值得考虑，不是因为它更短
（§2.5.3 表明它其实更长），而是因为它**没有特殊轨迹**（no special locus）——
所以把它做完是真的能升 status 的，而根系路线做完了也升不动。

⚠ **这同时部分平反了 §4 对 own status 的指控**：若 `--via-root-power-sums` 的
own = physical-argument 实际上是在追踪**它自己装配里那一步未言明的轨迹延拓**，
那这个 own 就是**诚实的**，不是 §4 说的"把依赖的弱重复记一遍"。
lead 已把这条**反对自己简报框架**的证据原样转给 `e8statusfix`，并明确告诉它
「『不改，理由如下』比改更有价值，若你查出是这样请直说，那是在纠正我」。
**§4 的定性因此转为待定，以 curator 的裁定为准。**

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

⚠ **本节的定性已被 §3.1 挑战，转为待定。** scout 后来论证：那个 own status 可能诚实地
在追踪本推导自身装配里的 Cartan → 一般 F 轨迹延拓（即缺 Chevalley 限制这条**真定理**），
若如此则**不是**本节所说的「误用」。已派 `e8statusfix`（curator）裁定，**以它的结论为准**；
上面第 1、2 条作为**一般机制**的描述仍然成立，只是 E₈ 这张卡未必是它的实例。

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

**本节的闭合情况（lead，2026-09-19）**：

- ✅ **已闭合**：scout 在交回时另提的「Mathlib 怎么陈述伴随作用」——见 §2.5.1，
  `ad(F)(X) = F*X − X*F` 近乎定义性，**利好**。
- ✅ **已闭合（连带）**：第 4 条「整条 Λ² 路线没在 Lean 里试过任何一步」的**风险部分**——
  §2 的数值验证覆盖基匹配桥，§2.5 覆盖 Mathlib 接口。**工程量本身仍未试。**
- ⚠ **查出一条 scout 未列、也未预料的未查项**：so/sp 在 Mathlib 里**没有基、没有
  `Module.Free`/`Module.Finite`**（§2.5.2）。这条不在 scout 的自报清单里——
  **值得记的教训是：scout 的"未查项清单"本身也不是完备的**，
  它只能列出它意识到的盲点。lead 的复核价值主要在这里，不在复述它已列的那几条。
- ❌ **仍未闭合**（原样保留，无人认领）：Killing/Serre 未逐行读；antonelli-2015 原文未复核；
  对称函数机器未广搜；无 shortcut 节点检查；**未做那条"是否存在覆盖两支的一般 N 完整证明"的
  文献搜索**——最后这条是本清单里**唯一能显著降成本**的（找到就从"自己发明证明"降成"照抄大纲"），
  若船长决定投这条路线，建议**先派 researcher 做这一条**再派 formalizer。

---

## 6. 复现

```bash
python docs/frontier-scouting/so-usp-adjoint-trace-check.py    # 60/60，见 §2
uv run stringgraph counterfactual math.so-usp-adjoint-fundamental-trace-identities   # +3
uv run stringgraph counterfactual math.chevalley-restriction-theorem                 # 0
uv run stringgraph status math.adjoint-weights-are-roots-and-zero                    # rigorous
```

§2.5 的 Mathlib 实测（路径相对仓库根）：

```bash
M=formal/.lake/packages/mathlib/Mathlib
sed -n '155,175p' $M/Algebra/Lie/Classical.lean          # so / sp = skewAdjointMatricesLieSubalgebra
sed -n '110,120p' $M/Algebra/Lie/SkewAdjoint.lean        # 它是 LieSubalgebra R (Matrix n n R)
grep -n "ad_apply" $M/Algebra/Lie/OfAssociative.lean     # ad R L x y = ⁅x,y⁆
grep -n "Basis\|finrank\|Module.Free" $M/Algebra/Lie/SkewAdjoint.lean   # 空 ⇒ §2.5.2 的瓶颈
sed -n '101,141p' $M/Algebra/Lie/Classical.lean          # ElementaryBasis 只服务 sl n R
```
