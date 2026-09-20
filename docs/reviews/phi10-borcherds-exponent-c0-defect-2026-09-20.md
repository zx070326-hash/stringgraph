# `igusa-cusp-form-phi10-v2` 的 Borcherds 指数缺陷：c(0) 被写成 24（应为 20）

**记录人**：lead（主会话），2026-09-20 晚
**性质**：图内容缺陷记录。定位问题、给出正确值与依据；修复（立 v3 + 重接边）另行派工。
**发现路径**：graph-reviewer `ell0s6rev` 审查 `ell-zero-wall-degeneracy` §6 时，为构造一条
绕开 Sen Φ̂ 的 Borcherds 路线而逐因子重算乘积，用的是 `c(0)=20`；lead 复核时发现
**它与被引用的那张图卡自己写的数值不一致**，进而查出是图卡错了。

## 缺陷

`graph/statements/holography/igusa-cusp-form-phi10-v2.yaml` 第 10 行（`statement` 字段内）逐字：

> 其中 c(k) 为 K3 椭圆亏格 χ_{K3}(τ,z)（权 0 指标 1 弱 Jacobi 形式，满足 **c(k)=24 对 k=0**，
> c(k)=EG K3 系数，c(k)=0 对 k<−1）的傅里叶系数

**`c(0) = 24` 是错的，正确值是 `c(0) = 20`。**

## 依据（逐字，图内已有）

`literature/extractions/phi10-periodicity-and-product.md` 第 43 行，引 kawai-1997 eq.(4.32) **逐字**：

> `c(0) = 20, c(−1) = 2, c(N) = 0 if N < −1`

同文件第 84 行给出等价形式：K3 椭圆亏格最低阶项 `Z = 2y⁻¹ + 20 + 2y + O(q)`。

## 24 是从哪来的：它是另一个量

约定 `χ_{K3}(τ,z) = Σ_{n,l} c(4n−l²) q^n y^l`。取 `q⁰` 项：`n=0` 故宗量为 `−l²`，
`l=0` 给 `c(0)`、`l=±1` 各给 `c(−1)`、`|l|≥2` 因 `c(k)=0 (k<−1)` 全灭。于是

    χ_{K3}(τ, 0) = c(0) + 2c(−1) = 20 + 4 = 24 = χ(K3)（Euler 示性数）。

所以 **24 是 `χ_{K3}(τ,0)`，不是 `c(0)`**。卡片把「整个椭圆亏格在 z=0 的值」误记成
「它的 k=0 傅里叶系数」。两者差 `2c(−1) = 4`。

（旁证：卡片同一行还写着 `c(k)=EG K3 系数` 这句循环填充语——该括号整体是仓促写成的。）

## 影响评估

**当前是惰性的。** lead 对全图 grep `c\(0\)`：除本卡 `statement` 自身外，命中全部是
worldsheet 的**鬼场** `c(0)`（`b(z)c(0) ∼ 1/z` 等），与 Jacobi 形式系数无关。
即**目前没有任何节点消费这个数值**，故不存在已传播的错误结论，`validate` 也照常 0 errors。

**但它恰好在即将承重的位置上。** `ell0s6rev` 与下游 reviewer `dvvrev` 各自独立提出的
Borcherds 升级路线，第一步就是算 `m>0, n=0` 那族因子的指数：

    Σ_l c(0·... ) → c(0) + 2c(−1) = 20 + 4 = 24  ⟹  ∏(1−q^m)^{24} = η(ρ)²⁴（配前缀 q）

用卡片的 `c(0)=24` 会得到 `24 + 4 = 28`，即 **η^28**，整条路线立刻算错，且错得不显眼
（仍是 η 的幂，量纲/模权直到最后才对不上）。

结论：**这是「无害错误因无人消费而长期存活」的又一例**——与同日记录的
`citation-fabrication-incidents-2026-09-20.md` 事件 4 属同一失效模式，只是载体从
「捏造的引用」换成了「抄错的数值」。两者都靠结果不打脸而存活。

## 一并记下的第二个问题（不是错，是不够用）

`graph/statements/holography/phi10-borcherds-product-convergence.yaml` 的 statement
只断言「在某个区域内绝对收敛」，**未断言该区域是含 v 近 0 的开集**。而上述 Borcherds
路线要在 `v=0` 邻域做乘积重排取 `v²` 系数，真正需要的是后者。按 graph/CLAUDE.md
2026-09-15 判据（「这条边去掉 inferred，它指向的节点是否完整承载了我需要的那句话？」），
直接给它连边属于**用 flag 藏命题**。修复该卡（或另立卡）是 Borcherds 路线的前置条件。

## 修复方案（派工用）

按原则 1，`statement` 不可就地改：立 `igusa-cusp-form-phi10-v3`，把 v2 标
`superseded_by`。v1→v2 已有先例与保留裁决，见 `docs/reviews/phi10-v1-retention-decisions-2026-09-20.md`，
按同一套做法处理边的重接与旧卡保留。

v3 的 `statement` 除订正 `c(0)=20` 外，建议一并：
- 删去 `c(k)=EG K3 系数` 这句循环填充；
- 显式写出低阶值 `c(−1)=2, c(0)=20, c(k)=0 (k<−1)`（三者同出 kawai-1997 eq.(4.32)，
  一次给全，避免后人再去别处凑）；
- **可选但推荐**：补一句 `χ_{K3}(τ,0) = c(0) + 2c(−1) = 24`，把本次混淆的那两个量
  并排写清楚，防止同一错误复发。
- `sources` 增 `kawai-1997`（eq. 4.32），这是本次订正的直接依据。

## lead 亲自核过的

- `igusa-cusp-form-phi10-v2.yaml` 第 10 行原文（Read 全卡前 30 行）。
- `phi10-periodicity-and-product.md` 第 16、43、84 行（grep + 读上下文）。
- 全图 `c\(0\)` 的 grep 结果（确认无消费者）。
- `c(0)+2c(−1)=24` 的展开（lead 自行推，非文献转述；与抽取记录第 84 行的
  `Z = 2y⁻¹ + 20 + 2y` 独立吻合）。
- 28 个引用 `igusa-cusp-form-phi10-v2` 的文件清单（grep -rln）。

## lead 未核实的

- kawai-1997 原文 eq.(4.32) 本身（依赖本项目抽取记录；该记录标为逐字）。
- `ell0s6rev` 的完整 Borcherds 逐因子计算（其报告在传回途中被截断，已要求重发）。
- `phi10-borcherds-product-convergence` 所引文献是否其实给出了含 v=0 的收敛域
  （只读了图卡 statement，未回文献）。
