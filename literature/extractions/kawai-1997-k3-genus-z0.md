# 抽取记录：kawai-1997（补充抽取：K3 椭圆亏格在 z=0 的取值）

- 文献：T. Kawai, "K3 Surfaces, Igusa Cusp Form and String Theory",
  arXiv:hep-th/9710016（Proceedings of the Taniguchi symposium, *Topological Field Theory,
  Primitive Forms and Related Topics*, 1997）。
- 抽取者：researcher agent（task：为 `χ_{K3}(τ,0)=24 对一切 τ` 取逐字来源）
- 日期：2026-09-20
- 覆盖范围：§3（椭圆亏格一般框架，Theorem 3.1 / Corollary 3.2 / Corollary 3.3）；
  §4（K3 情形，eqs. (4.1)–(4.6), (4.17)–(4.22), (4.28)–(4.32)）
- **本文件是对已有 `extractions/phi10-periodicity-and-product.md` 的补充，不覆盖它。**
  那份记录覆盖 eq.(5.13)（Borcherds 乘积）与 eq.(4.32)（c 值）；本文件补 §4 中
  与「z=0 求值」相关的式子，并对 (4.31)/(4.32) 做一次独立的**官方 PDF 逐字复核**。
- 原文获取方式：arXiv 官方 PDF（`https://arxiv.org/pdf/hep-th/9710016`，HTTP 200），
  PyMuPDF 取文本 + PDF 第 11、13 页 200 dpi 渲染成图逐符号目视核对。**未用 pdftotext。**
  ⚠ 已有记录 `phi10-periodicity-and-product.md` 自述用的是 **ar5iv HTML**；本次改用官方 PDF，
  式号 (4.31)/(4.32)/(5.13) 均**一致**，未发现编号漂移。

## 约定

- `Z(τ, z)` = K3 椭圆亏格（§4 起 `Z[M]` 简写为 `Z`，M = K3）。
- `q = e^{2πiτ}`, `y = e^{2πiz}`（§2 eq.(2.19) 在 Siegel 变量语境下写 `p=e[σ], q=e[τ], y=e[z]`）。
- `ϑ_ν` = Jacobi theta（eq.(4.13)/(4.14) 给出带特征的定义）；`ϑ_{ν+1}(0)` 即 z=0 处的 theta 常数。
- `K(τ,z) := √(−1) ϑ₁(τ,z)/η(τ)³ = 2π√(−1) ϑ₁(τ,z)/ϑ′₁(τ,0)`（eq.(4.17)）。
- `e_ν = ℘(ω_ν)`，ω₁=1/2, ω₂=−(τ+1)/2, ω₃=τ/2（eq.(4.10)）。

## 陈述

### E1 K3 椭圆亏格是权 0 指标 1 的弱 Jacobi 形式

- 位置：§3 Corollary 3.3（PDF p.7）+ §4 开头（PDF p.8）
- 类型：proposition（Cor. 3.3）+ 应用
- 原文陈述（逐字）：

  Corollary 3.3（PDF p.7）："If M is an even dimensional Calabi-Yau manifold, then the
  elliptic genus Z_{T*}[M] : H₁ × C → C is a weak Jacobi form of weight 0 and index d/2
  without character."

  §4（PDF p.8，逐字）："Corollary 3.3 tells us that the elliptic genus Z(τ, z) is a weak Jacobi
  form of weight 0 and index 1 with the expansion

  ```
  Z(τ, z) = 2y⁻¹ + 20 + 2y + O(q) .                                    (4.2)
  ```
  "

  同页 eq.(4.1)（逐字）：`χ_y(M) = 2 + 20y + 2y² .`

- 文献自称的严格程度：Theorem 3.1 / Cor. 3.2 / Cor. 3.3 都自称"summarizes what has been
  shown in [KYY][KM]"，即引用 Kawai–Yamada–Yang 与 Kawai–Mohri，非本文证明。
- 备注：⚠ **(4.2) 只给 q⁰ 项**，本身**不能**支撑「χ_{K3}(τ,0)=24 对一切 τ」。
  （这正是本项目之前的缺口：`phi10-periodicity-and-product.md:84` 只记到这一条。）

### E2 Z = 2φ̃_{0,1}

- 位置：§4，eq. (4.6)（PDF p.8）
- 类型：proposition
- 原文陈述（逐字）："Now comparing the expansions of Z and φ̃_{0,1} and using the structure
  theorem 4.1 mentioned below we find that

  ```
  Z(τ, z) = 2 φ̃_{0,1}(τ, z) .                                          (4.6)
  ```
  "
  其中 eq.(4.4) 逐字：`φ̃_{−2,1}(τ,z) = φ_{10,1}(τ,z)/Δ(τ) , φ̃_{0,1}(τ,z) = φ_{12,1}(τ,z)/Δ(τ)`；
  eq.(4.5) 逐字：`Δ(τ) := (E₄(τ)³ − E₆(τ)²)/1728 = η(τ)²⁴`。

- ⚠ **记号细节（逐字，容易抄错）**：Kawai 写的是**带波浪号**的 `φ̃_{0,1}` / `φ̃_{−2,1}`
  （原文是 `\widetilde\phi`），与不带波浪的尖点形式 `φ_{10,1}` / `φ_{12,1}` 是**不同函数**：
  `φ̃` 是弱 Jacobi 形式（权 0 / −2），`φ` 是 Jacobi 尖点形式（权 12 / 10）。抄录时勿混。

### E3 【★★ 目标 1：Kawai 侧的最清爽来源】Z 的 theta 商表达式 (4.22)

- 位置：§4，eq. (4.21)、(4.22) 及脚注 †（PDF p.11 = 印刷 p.11）
- 类型：proposition
- 原文陈述（逐字，200 dpi 渲染图逐符号目视核对）：

  "Since the ℘-function is related to the Jacobi theta functions through the identities [EMOT]

  ```
                  ( ϑ_{ν+1}(z) )²
  ℘(z) = e_ν  +  ( ─────────── )  K(z)⁻² ,      (ν = 1, 2, 3) ,
                  ( ϑ_{ν+1}(0) )
                         3
              1         ---  ( ϑ_{ν+1}(z) )²
           = ───        >    ( ─────────── )  K(z)⁻² ,                 (4.20)
              3         ---  ( ϑ_{ν+1}(0) )
                        ν=1
  ```

  the elliptic genus can also be expressed as†

  ```
                 { ( ϑ_{ν+1}(z) )²              }
  Z(τ, z) = 24   { ( ─────────── )  + e_ν K(z)² } ,   (ν = 1, 2, 3) ,   (4.21)
                 { ( ϑ_{ν+1}(0) )              }
  ```

  or

  ```
                   3
                  ---  ( ϑ_{ν+1}(z) )²
  Z(τ, z) = 8     >    ( ─────────── )   .                             (4.22)
                  ---  ( ϑ_{ν+1}(0) )
                  ν=1
  ```
  "

  脚注 † 逐字："The formula given in [KYY] corresponds to the choice ν = 2."

  【逐字细节，已逐符号核过】(4.21) 前系数是 **24**，花括号内第二项是 **+ e_ν K(z)²**（**加号**）；
  (4.22) 前系数是 **8**，求和 `ν = 1, 2, 3`，被加项是 `(ϑ_{ν+1}(z)/ϑ_{ν+1}(0))²`（**平方**，
  **无** e_ν 项、**无** K 因子）。

- 文献自称的严格程度：由 (4.6)、(4.7)、(4.18)、(4.20) 代数推出（"the elliptic genus can also
  be expressed as"）。(4.20) 自称引自 [EMOT]（Erdélyi et al., Higher Transcendental Functions）。

- **对目标 1 的裁定：SUPPORT（强）。理由分层**：

  **原文说了什么（逐字）**：(4.22) 把 K3 椭圆亏格写成三个 theta 商平方之和乘 8，
  **每个商的分母恰是同一个 theta 在 z=0 的值**。

  **我的推断（一行，非原话）**：令 z = 0，每个商变成 `ϑ_{ν+1}(0)/ϑ_{ν+1}(0) = 1`，故
  `Z(τ, 0) = 8·(1+1+1) = 24`，**对一切 τ ∈ ℍ**。
  这一步**不需要**任何模形式论证、不需要取极限、不需要 ϑ₁ 的零点性质——只需要
  ν+1 ∈ {2,3,4} 的 theta 常数 ϑ₂(τ,0), ϑ₃(τ,0), ϑ₄(τ,0) 非零（否则 (4.22) 本身无定义；
  Kawai 把它们写作分母即默认非零）。**这是我见过的最短的坐实路径。**

  用 (4.21) 也可以：z=0 时 `K(τ,0) = √(−1)·ϑ₁(τ,0)/η³ = 0`（ϑ₁ 在 z=0 取零），
  故 `Z(τ,0) = 24·{1 + 0} = 24`——同样**逐字前系数就是 24**。

- 与 kawai-yamada-yang-1994 的交叉一致性（我做的验算）：KYY (5.3) 取 Kawai 脚注 † 说的 ν=2，
  即 `Z = 24{(ϑ₃(z)/ϑ₃(0))² + e₂K(z)²}`。代入 eq.(4.15) 的
  `e₂ = −(1/12){ϑ₂(0)⁴ − ϑ₄(0)⁴}` 与 `K = √(−1)ϑ₁/η³`（K² = −ϑ₁²/η⁶）得
  `24 e₂ K² = −2 (ϑ₄⁴−ϑ₂⁴)/η⁴ · (ϑ₁/η)²`，与 KYY (5.3) 第二项**逐项吻合**（含系数 −2、
  含 ϑ₄⁴−ϑ₂⁴ 的顺序与符号）。两篇独立排版的公式互证，可排除单篇印刷错误。

### E4 c 系数的官方 PDF 逐字复核（目标 3）

- 位置：§4，eq. (4.28)、(4.31)、(4.32)（PDF p.12–13）
- 类型：definition + 数值
- 原文陈述（逐字，PDF p.13 200 dpi 渲染图目视核对）：

  eq.(4.28)（PDF p.12）：
  ```
  Z(τ, z) = Σ_{n ∈ ℕ₀, r ∈ ℤ} c(4n − r²) qⁿ yʳ ,                       (4.28)
  ```
  紧接其后逐字："where we used the fact that the coefficients depend only on the combination
  4n − r²."

  eq.(4.31)：
  ```
  h₀(τ) = 20 + 216 q + 1616 q² + 8032 q³ + 33048 q⁴ + ··· ,
  q^{1/4} h₁(τ) = 2 − 128 q − 1026 q² − 5504 q³ − 23550 q⁴ − ··· .      (4.31)
  ```

  eq.(4.32)，其前一行逐字是 "Note in particular that"：
  ```
  c(0) = 20 ,      c(−1) = 2 ,      c(N) = 0 if N < −1 .                (4.32)
  ```

- **裁定（目标 3）：CONFIRM。** 式号 **(4.32)** 与数值 **c(0)=20, c(−1)=2, c(N)=0 for N<−1**
  与已有记录 `phi10-periodicity-and-product.md:43`（那次经 ar5iv HTML）**完全一致**，
  本次经**官方 PDF + 渲染图**独立复核。**图卡 `igusa-cusp-form-phi10-v2` statement 第 10 行的
  `c(0)=24` 确为错误，正确值 20。**

- 备注（我的验算，非原文）：`c(0) + 2c(−1) = 20 + 4 = 24 = χ_{K3}(τ,0)`，
  与 E3 的 z=0 求值一致；这正说明 `c(0)` 与 `χ_{K3}(τ,0)` 是**两个不同的数**。

## 综合裁定

| 需求 | 裁定 | 位置 |
|---|---|---|
| `χ_{K3}(τ,0) = 24` 对一切 τ | **SUPPORT**（逐字给 (4.22)/(4.21)，z=0 代入是一行） | kawai-1997 §4, eq.(4.21)/(4.22)，PDF p.11 |
| `c(0)=20, c(−1)=2` | **CONFIRM**（官方 PDF 复核） | kawai-1997 §4, eq.(4.32)，PDF p.13 |
| Borcherds 乘积收敛域 | **本文完全未涉及**（见下） | — |

## 原文疑点 / 检索空结果

1. **kawai-1997 全文没有任何收敛性陈述**。我对 PDF 全文正则检索
   `converge|Weyl chamber|sufficiently large|absolutely`，**零命中**。
   §5 "Product formulas of Borcherds, Gritsenko and Nikulin" 给出 eq.(5.12)/(5.13) 的乘积公式，
   但**不说它在哪里收敛**。目标 2 不能指望这篇。
2. kawai-1997 也**没有**写出 `Z(τ,0)=24` 或 `Z(τ,0)=χ(K3)` 这样的自然语言句子——
   24 只以 (4.19)/(4.21)/(4.22) 的**前系数**出现。

## 我亲自逐字核过的 / 我转述或推断的

**亲自逐字核过（PyMuPDF 文本；(4.19)–(4.23) 与 (4.31)–(4.34) 另经 200 dpi 渲染图目视）**：
- PDF p.7：Theorem 3.1、Corollary 3.2、Corollary 3.3
- PDF p.8：(4.1)、(4.2)、(4.3)、(4.4)、(4.5)、(4.6)
- PDF p.10：(4.13)–(4.18)（theta 定义、e_ν 的 theta 表达式 (4.15)、ϑ′₁(τ,0)=2πη³ (4.16)、
  K 的定义 (4.17)、φ̃_{−2,1}=K² (4.18)）
- PDF p.11：Corollary 4.2、(4.19)、(4.20)、(4.21)、(4.22)、(4.23)、脚注 †
- PDF p.12：(4.28)、(4.29)、(4.30)
- PDF p.13：(4.31)、(4.32)、(4.33)、(4.34)

**我转述或推断的（非原文）**：
- E3 的「z=0 代入 (4.22) 得 24」与「代入 (4.21) 得 24」——Kawai 未写这两步。
- E3 末尾 (4.21)|_{ν=2} ↔ KYY (5.3) 的代数吻合验算——两篇都未写这一对照
  （Kawai 脚注 † 只说 "[KYY] corresponds to the choice ν = 2"，没做代数展开）。
- E4 备注里 `c(0)+2c(−1)=24` 的算术。
- 「ϑ₂(τ,0), ϑ₃(τ,0), ϑ₄(τ,0) 对 τ ∈ ℍ 非零」——标准事实，本文未陈述。
