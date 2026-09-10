# 抽取记录：polchinski-1998-v1，第 7 章「One-loop amplitudes」

- 文献：J. Polchinski, *String Theory. Vol. 1: An Introduction to the Bosonic String*, Cambridge University Press, 1998.
  **实际读的是 Cambridge Books Online 数字化本（© 1998, 2005），即 2005 平装本，已含 2000 年 "with corrections" 的改动。**
- 抽取者：researcher agent
- 日期：2026-09-11
- 覆盖范围：**第 7 章 One-loop amplitudes，pp. 206–230**（§7.1 Riemann surfaces / §7.2 CFT on the torus / §7.3 The torus amplitude / §7.4 Open and unoriented one-loop graphs）
- 证据等级：**L1（原书页图逐字）**，除非条目内另行标注
- 与 `extractions/polchinski-1998-v1.md` 的关系：**本文件不覆盖该文件任何条目**，E 编号自成一套（本文件 E1 起）

（骨架已写盘，各节逐节追加。）

## 0. 获取路线与证据等级

### 0.1 本轮实际做了什么

**第 7 章 pp. 206–230 全 25 页逐页读图，无失败、无缺页。** 路线与 `polchinski-1998-v1.md` §12.0 完全一致：

| 步 | 本轮做法 | 结果 |
|---|---|---|
| 1 | 由 `polchinski-1998-v1.md` §12.0 的 item hash 表直接取 ch.7 = `1FCFE9B5026DE1E5210F0F62514336B0`，页范围 206–230 | 无需再 fetch 书目页 |
| 2 | 文件名按规则推出：`9780511816079c7_p206-230_CBO.pdf` | **一次命中**（第七次验证该规则） |
| 3 | `WebFetch` → 抱怨二进制并拒绝概括，但 **PDF 落盘 264.2 KB / 25 页**（≈ 10.6 KB/页，与记忆中的 Polchinski 体积基准 13 KB/页吻合） | 成功 |
| 4 | `Read(pages=1-7 / 8-14 / 15-20 / 21-25)` 四次读完 | 成功 |
| 5 | **关键页单页重渲染**：PDF p.12（印刷 217，(7.3.6)）、p.14（印刷 219，(7.3.14)/(7.3.15)）、**p.24（印刷 229，(7.4.24) 与 SO(8192)/SO(32) 那段）** | 三页复核，读数未改 |
| 6 | **额外做的一次跨章定点核对**：ch.5 PDF（`2619B77DD4AE2BE4D53B5EED5D3BE3C1` / `9780511816079c5_p145-165_CBO.pdf`）**只读 PDF p.4 = 印刷 p.148**，为核对 (5.1.15) 与 (7.3.14) 的不等号 | 成功，见 **E24 / Q1 / §5-B1** |

**PDF 落盘路径（本次会话内有效）**
- ch.7：`C:\Users\charles\.claude-apexin\projects\D--physics-string\c626835a-9cb2-486b-bf93-f345125de513\tool-results\webfetch-1789080013205-nlsjg5.pdf`
- ch.5：`C:\Users\charles\.claude-apexin\projects\D--physics-string\c626835a-9cb2-486b-bf93-f345125de513\tool-results\webfetch-1789080215615-h24e14.pdf`

**PDF 页 ↔ 印刷页的换算：`印刷页 = PDF 页 + 205`**（ch.7）。

### 0.2 版本锚定（与 §12.0 相同，必须随引用带上）

页脚逐字：`Downloaded from https://www.cambridge.org/core. Zhejiang University, on 10 Sep 2026 at 22:40:12, subject to the Cambridge Core terms of use … https://doi.org/10.1017/CBO9780511816079.010`

⇒ 读到的是 **Cambridge Books Online 数字化本（© 1998, 2005），即 2005 平装本，已含 2000 年 "with corrections"**。
**引用写「Cambridge Books Online 数字化本（2005 平装）」，不要写「1998 初印本」。**
副作用：本章式子**已经是勘误后的文本**，本记录不再为任何一式标「印刷版可能有误」。

### 0.3 证据等级

- **本文件 §2 的全部条目一律 `L1（原书页图逐字）`**，这是本项目在 Polchinski 上的最高等级。
- 凡标「逐字」的引文是**从页图上抄下来的英文原文**；凡标「转述」的是抽取者的中文归纳。
- **本章不需要 [S]（Schrans）或 [H]（Headrick）**：原书直读，二手源不再是必需品。
  （顺带记一条**否定结论**：hepnotes 的 [S] 只覆盖 Vol.1 前 8 章，其第 7 章本轮**未使用**，因此本文件里**没有任何一条依赖第三方伴读笔记**。）

### 0.4 本轮的一次独立算术交叉核验（方法论留痕）

页图上 (7.4.24) 的分子读作 **`24V₂₆`**，抽取者第一反应是「应该只有 `V₂₆`」。
**未改读数，改为独立复算**（这正是 AGW (101) 与 Zumino (5.10)/(5.11) 用过的手法）：

- (7.4.4)：`η(is/π)^{−24} = exp(2s) + 24 + O(exp(−2s))` ⇒ **无质量项的系数就是 24**；
- 无取向理论里圆柱要额外乘 ½（原书 (7.4.14) 下方明说「there is an extra ½ in both the torus and cylinder amplitudes in the unoriented theory」），
  故圆柱 (7.4.3) 的 `1/2π` → `1/4π`，无质量部分 = `i·24·V₂₆n²/(4π(8π²α')¹³)∫ds`；
- Klein 瓶 (7.4.19) 的无质量部分 = `i·24·2²⁶V₂₆/(4π(8π²α')¹³)∫ds`；
- Möbius (7.4.23) 给交叉项 `∓ 2·2¹³ n`；
- 三者相加：`2²⁶ ∓ 2¹⁴n + n² = (2¹³ ∓ n)²`，公共因子恰是 **`i·24·V₂₆/(4π(8π²α')¹³)`**。

⇒ **页图读数 `24V₂₆` 得到独立算术确认，不是 `2⁴` 也不是误读。** 同时这条复算**自动验证了 (7.4.3)/(7.4.19)/(7.4.23) 三式的系数彼此自洽**。

---

## 1. 约定

第 7 章不引入新的整体约定，沿用全书约定。本章内**实际用到并在本章内明写**的有：

| 项 | 本章的取法 | 位置 |
|---|---|---|
| 世界面坐标 | `w = σ¹ + iσ²`；环面用 `ds² = dw dw̄`（欧氏，`δ_ab`，号差 (+,+)） | §7.1 p.206 |
| 面积元与度规分量 | **`d²w = 2dσ¹dσ²`，`g_{ww̄} = ½`** —— 原书在 (7.3.2) 下方用括号提醒「(Recall that `d²w = 2dσ¹dσ²` and that `g_{ww̄} = ½`.)」 | §7.3 p.216 |
| 环面坐标 | `z = exp(−iw)`（**注意负号**），于是 `w ≅ w + 2π` 自动成立 | (7.1.3) p.206 |
| 模参数 | `τ = τ₁ + iτ₂`；`q = exp(2πiτ)`，`z = exp(2πiv)`（θ 函数一节的 `z` 与上面的世界面 `z` **同名不同义**） | (7.2.35) p.214 |
| 复模积分测度 | **`dτdτ̄ = 2dτ₁dτ₂`** —— 原书 (7.3.1) 下方逐字「As usual for complex variables, `dτdτ̄ = 2dτ₁dτ₂`」 | §7.3 p.216 |
| 哈密顿量 | `H = L₀ + L̃₀ − (1/24)(c + c̃)`，引 **(2.6.10)** | (7.2.5) 下方 p.209 |
| 动量算符 | `P = L₀ − L̃₀`（生成 `σ¹` 平移） | (7.2.5) 下方 p.209 |
| θ 函数记号 | 同时使用 `ϑ_{ab}` 与 `ϑ₁…ϑ₄` 两套，(7.2.37a–d) 给出对照 | pp.214–215 |
| Chan–Paton 计数 | **`n` = Chan–Paton 自由度数；`Sp(k)` 在本书记号下对应 `n = 2k`** —— 原书逐字「(recall that in our notation `Sp(k)` corresponds to `n = 2k` Chan–Paton states)」 | §7.4 p.228 |

⚠ **两个符号约定上的坑（原书自己承认的）**：
1. **`bc` 配分函数的整体符号被人为设定**。原书 p.213 逐字：「Again, we do not try to keep track of the overall sign, setting it to be positive.」
2. **(7.2.22) 的整体数值系数没有定出来**。原书 p.211 逐字：「up to a numerical coefficient that must be fixed by other means.」

与 `graph/conventions/` 的关系：本章没有出现与 `conv.canonical` 冲突的约定，**无需换算**。

## 2. 陈述

> 编号 `E1`–`E39`，转成节点时在 `notes` 里写 `from: polchinski-1998-v1-ch7#E<n>`。
> **全部条目 L1（原书页图）**，除非条目内另标。

### 2.1 §7.1 Riemann surfaces（pp. 206–208）

#### E1 欧拉数为零的黎曼面恰有四个
- 位置：**§7.1 开头第一句，p.206**
- 类型：proposition（分类陈述）
- **原文逐字**：「There are four Riemann surfaces with Euler number zero.」
- 文献自称的严格程度：**光秃秃的断言，无证明、无引用、无「one can show」**。随后四小节只是**逐个描述**这四个面（torus / cylinder / Klein bottle / Möbius strip），**不是**「穷尽性」的论证。
- 文献列出的依赖：无（欧拉数与 `χ` 的一般讨论在 §5.1 与 §5.3）
- 备注：⚠ **这是本章第一条也是最强的一条未论证断言。** 转成节点时 `status` 只能是 `physical-argument`（甚至更低），**不得**写成 rigorous。数学上正确的对应结果是紧曲面（含带边、不可定向）的分类定理，本项目已有独立来源，见 §5-C。

#### E2 环面 T²：定义、模、CKV、基本区
- 位置：**§7.1「The torus」，(7.1.1)–(7.1.4)，p.206**
- 类型：definition + proposition
- 原文陈述：
  - 「The torus `T²`, discussed in section 5.1, is the only closed oriented surface with Euler number zero.」（逐字）
  - 复平面配 `ds² = dw dw̄` 与认同 **`w ≅ w + 2π ≅ w + 2πτ`**（**7.1.1**）；
  - 「**There are two moduli**, the real and imaginary parts of `τ = τ₁ + iτ₂`, and **two CKVs, the translations.**」（逐字）实坐标形式 **(7.1.2)** `(σ¹,σ²) ≅ (σ¹+2π,σ²) ≅ (σ¹+2πτ₁, σ²+2πτ₂)`；
  - 几何图像（逐字）：「so that one can think of the torus as a cylinder of circumference `2π` and length `2πτ₂` with the ends rotated by an angle of `2πτ₁` and then sewn together.」
  - 取 **`z = exp(−iw)`** 则 `w ≅ w+2π` 自动，`w ≅ w+2πτ` 变成 **`z ≅ z exp(−2πiτ)`**（**7.1.3**）；
  - 「A fundamental region is the annulus **`1 ≤ |z| ≤ exp(2πτ₂)`**」（**7.1.4**）。
  - 末句（逐字）：「We will use the `w`-coordinate unless otherwise noted.」
- 文献自称的严格程度：定义 + 直接构造，无证明性措辞
- 文献列出的依赖：§5.1
- 备注：`两个模 + 两个 CKV` 与图中已有的 `worldsheet.torus-two-moduli-two-ckv` 对口，**本条给出该结论在第 7 章的复述位置**（原始推导在 §5.1）。

#### E3 圆柱 C₂（annulus）
- 位置：**§7.1「The cylinder (annulus)」，(7.1.5)–(7.1.7)，p.207**
- 类型：definition + proposition
- 原文陈述：
  - **(7.1.5)** `0 ≤ Re w ≤ π`，`w ≅ w + 2πit`。即「a strip of width `π` and length `2πt`, with the ends joined」。
  - **★ 关键结构性陈述（逐字）**：「There is a single modulus `t`, which runs over the whole range `0 < t < ∞`. **Unlike the torus there is no modular group**, the long-cylinder limit `t → 0` being quite different from the long-strip limit `t → ∞`. There is a single CKV, the translation parallel to the boundary.」
  - 由 `τ = it` 的环面对合 **`w' = −w̄`**（**7.1.6**，虚轴反射）得到；`σ¹ = 0, π` 是不动线故成边界；另一坐标周期认同 **(7.1.7)** `(σ¹,0) ≅ (σ¹,2πt)`。
- 文献自称的严格程度：构造性描述，无证明性措辞
- 文献列出的依赖：E2
- 备注：**「no modular group」这一句是 §7.4 全部发散讨论的前提**，见 E30。

#### E4 Klein 瓶 K₂
- 位置：**§7.1「The Klein bottle」，(7.1.8)–(7.1.10)，p.207**
- 类型：definition + proposition
- 原文陈述：
  - **(7.1.8)** `w ≅ w + 2π ≅ −w̄ + 2πit`；实坐标 **(7.1.9)** `(σ¹,σ²) ≅ (σ¹+2π,σ²) ≅ (−σ¹, σ²+2πt)`。
  - 逐字：「This is a cylinder of circumference `2π` and length `2πt`, with the ends sewn together after a **parity-reversal `Ω`**. The single modulus `t` runs over `0 < t < ∞`, and **there is no modular group**. Translation in the `σ²` direction is the only CKV.」
  - 由 `τ = 2it` 的环面在 **`w' = −w̄ + 2πit`**（**7.1.10**）下认同得到。
  - 逐字：「The Klein bottle can be thought of as a sphere with two cross-caps, but **we postpone this description until section 7.4.**」
- 文献自称的严格程度：构造性描述
- 文献列出的依赖：E2
- 备注：「两个 cross-cap」的兑现在 §7.4 (7.4.16)–(7.4.18)，见 E36。

#### E5 Möbius 带 M₂
- 位置：**§7.1「The Möbius strip」，(7.1.11)–(7.1.12)，p.208**
- 类型：definition + proposition
- 原文陈述：
  - **(7.1.11)** `0 ≤ Re w ≤ π`，`w ≅ −w̄ + π + 2πit`（「sewn from a strip with a twist by `Ω`」）。
  - 逐字：「Again the modulus `t` runs over `0 < t < ∞` and the only CKV is the `σ²`-translation.」
  - 由 `τ = 2it` 的环面在 **两个** 对合下认同：**(7.1.12)** `w' = −w̄` **and** `w' = w + π(2it+1)`。（原书对 "the **two** involutions" 用了斜体强调。）
  - 逐字：「The Möbius strip can be thought of as a disk with a cross-cap, but **again we defer this description.**」
- 文献自称的严格程度：构造性描述
- 文献列出的依赖：E2
- 备注：兑现在 §7.4 (7.4.23) 附近，见 E37。

---

### 2.2 §7.2 CFT on the torus（pp. 208–216）

#### E6 环面上的标量 Green 函数
- 位置：**§7.2「Scalar correlators」，(7.2.1)–(7.2.3)，p.208**
- 类型：proposition
- 原文陈述：
  - 出发方程 **(7.2.1)**：`(2/α')∂̄∂ G'(w,w̄;w',w̄') = −2πδ²(w−w') + 1/(4πτ₂)`
    （右端第二项是**背景荷/零模项**，环面上必须有）；引 **(6.2.7)**。
  - **★ 作者自称的强度（逐字）**：「These properties identify it as being associated with the theta functions, whose properties are given at the end of this section. **In particular we guess** `G'(w,w̄;w',w̄') ∼ −(α'/2) ln|ϑ₁((w−w')/2π|τ)|²` (**7.2.2**).」
    ——**「we guess」**，然后逐条修补（`ϑ₁` 的准周期性 (7.2.32b)、缺失的背景荷）得到
  - **(7.2.3)**：`G'(w,w̄;w',w̄') = −(α'/2)ln|ϑ₁((w−w')/2π|τ)|² + α'[Im(w−w')]²/(4πτ₂) + k(τ,τ̄)`。
  - 逐字：「The function `k(τ,τ̄)` is determined by orthogonality to `X₀`, but as in the case of the sphere **it drops out due to spacetime momentum conservation**.」
- 文献自称的严格程度：**「we guess」+ 事后校验**（不是「we solve」）。⚠ 转节点时这是 `physical-argument` 级的构造，不是求解定理。
- 文献列出的依赖：(6.2.7)、(7.2.32b)
- 备注：习题 **7.3** 要求「Derive the Green's function (7.2.3) by carrying out the eigenfunction sum (6.2.7)」——即**原书把严格推导留作习题**。

#### E7 环面上指数顶点算子的期望值
- 位置：**§7.2，(7.2.4)，p.209**
- 类型：proposition
- 原文陈述：`⟨∏ᵢ :e^{ikᵢ·X(zᵢ,z̄ᵢ)}:⟩_{T²} = i C^X_{T²}(τ)(2π)^d δ^d(Σᵢkᵢ) ∏_{i<j} |(2π/∂_vϑ₁(0|τ)) ϑ₁(w_{ij}/2π|τ) exp(−(Im w_{ij})²/(4πτ₂))|^{α'kᵢ·k_j}`（**7.2.4**），与球面上的 (6.2.13) 平行。
  逐字：「The factor `2π/∂_vϑ₁` comes from the renormalized self-contractions.」
- 文献自称的严格程度：`【无强度措辞，直接给出】`
- 文献列出的依赖：E6、(6.2.13)
- 备注：习题 **7.1** 要求补全推导并验证 `τ → −1/τ` 变换性质 ⇒ **模协变性原书未验证，留作习题**。

#### E8 标量配分函数的迹表示
- 位置：**§7.2「The scalar partition function」，(7.2.5)–(7.2.7)，p.209**
- 类型：proposition
- 原文陈述：
  - 动机（逐字）：「The overall normalization of the sphere was absorbed into the string coupling constant, but we cannot do this for the torus, in particular because there is a nontrivial `τ`-dependence. **In fact, we will see that there is a great deal of physics in the amplitude with no vertex operators at all.**」
  - **(7.2.5)**：`Z(τ) = Tr[exp(2πiτ₁P − 2πτ₂H)] = (qq̄)^{−d/24} Tr(q^{L₀} q̄^{L̃₀})`，
    其中 `q = exp(2πiτ)`，`P = L₀ − L̃₀`，`H = L₀ + L̃₀ − (1/24)(c + c̃)`（引 **(2.6.10)**）。
  - **(7.2.6)**：`V_d(qq̄)^{−d/24}∫ d^dk/(2π)^d exp(−πτ₂α'k²) ∏_{μ,n} Σ_{N,Ñ=0}^∞ q^{nN_{μn}} q̄^{nÑ_{μn}}`；
    `V_d` 来自 `Σ_k → V_d(2π)^{−d}∫d^dk`。
  - **(7.2.7)**：`Σ_{N=0}^∞ q^{nN} = (1−q^n)^{−1}`。
- 文献自称的严格程度：直接计算
- 文献列出的依赖：(2.6.10)
- 备注：原书把「路径积分 = 迹」这一步说成「In operator language this gives a trace」，**没有独立论证**，靠的是「环面 = 圆上场论演化欧氏时间 `2πτ₂`、`σ¹` 平移 `2πτ₁`、再把两端认同」这个图像。

#### E9 ★ Dedekind η 与自由标量的配分函数（本章最常被下游引用的一式）
- 位置：**§7.2，(7.2.8)–(7.2.10)，p.210**
- 类型：proposition + definition
- 原文陈述：
  - **(7.2.8)**：`Z(τ) = i V_d Z_X(τ)^d`
  - **(7.2.9)**：`Z_X(τ) = (4π²α'τ₂)^{−1/2} |η(τ)|^{−2}`
  - **(7.2.10)（Dedekind η 的定义）**：`η(τ) = q^{1/24} ∏_{n=1}^∞ (1 − q^n)`
  - 逐字：「is the Dedekind eta function, discussed further at the end of the section. Also, the `i` comes from the **rotation `k⁰ → ik^d`** needed to define the divergent integral. Also, the earlier `C^X_{T²}(τ)` is `Z_X(τ)^d`.」
  - **★ 模不变性（逐字）**：「The result (7.2.8) is **obviously** invariant under `τ → τ + 1`. Invariance of `Z_X` under `τ → −1/τ` follows from eq. (7.2.44), `η(−1/τ) = (−iτ)^{1/2}η(τ)`, **thus generating the full modular group**. Similarly the expectation value with vertex operators is modular-covariant, taking into account the Weyl transformations of the operators.」
- 文献自称的严格程度：`τ→τ+1` 是「obviously」；`τ→−1/τ` **归约到 (7.2.44)**（η 的模变换，本章 §7.2 末给出但**未证明**，见 E16）；「generating the full modular group」引的是 `worldsheet.modular-group-generated-by-s-and-t` 型结论，本章不证。
- 文献列出的依赖：E8、**(7.2.44)**、模群由 S 与 T 生成
- 备注：**`τ₂^{−1/2}|η|^{−2}` 这个组合是全书模不变性论证的原子**：(7.3.6)、(8.2.11)、(8.4.21) 都靠它。

#### E10 用全纯性重算配分函数（另一条独立推导，但只定到一个常数）
- 位置：**§7.2，(7.2.11)–(7.2.22)，pp. 210–211**
- 类型：proposition
- 原文陈述（要点）：
  - 动机（逐字）：「The evaluation using holomorphicity is less direct. **We include it for illustration** because it is used at higher genus and for more complicated CFTs.」
  - 度规微扰 `δg_{ww} = ε*` ⇒ **(7.2.11)** Weyl 等价于 `dw'dw̄'`，`w' = w + ε(w̄−w)`；周期性 **(7.2.12)**；**(7.2.13) `δτ = −2iτ₂ε`**。
  - **(7.2.14)**：`δZ(τ) = −(1/2π)∫d²w[δg_{w̄w̄}⟨T_{ww}(w)⟩ + δg_{ww}⟨T_{w̄w̄}(w̄)⟩] = −2πi[δτ⟨T_{ww}(0)⟩ − δτ̄⟨T_{w̄w̄}(0)⟩]`
  - OPE **(7.2.15)**；**(7.2.16)**、**(7.2.17)**（`w⁰` 项）；**(7.2.18)** `⟨T_{ww}(0)⟩`；
  - **(7.2.19)** `∂_τ ln Z(τ) = (πid/3)·∂³_wϑ₁(0|τ)/∂_wϑ₁(0|τ) + id/(4τ₂)`；
  - **(7.2.20)** `∂²_wϑ₁(w/2π|τ) = (i/π)∂_τϑ₁(w/2π|τ)`——原文逐字「**which is easily verified from the infinite sum**」；
  - **(7.2.21)** 改写；
  - **★ (7.2.22)**：`Z(τ) = |∂_wϑ₁(0|τ)|^{−2d/3} τ₂^{−d/2}`，
    **紧接一句逐字**：「**up to a numerical coefficient that must be fixed by other means.** Noting the relation (7.2.43), this is the same as the earlier result (7.2.8).」
- 文献自称的严格程度：**明确不完整**——整体数值常数定不出来，靠与 (7.2.8) 对照来固定。
- 文献列出的依赖：E9、(7.2.43)
- 备注：**这是本章第二条作者自承缺口。** 另原书 p.210 说「We leave to the reader the direct path integral evaluation」——**第三条路径（直接路径积分）完全没做**；习题 **7.2** 才要求用附录 A 的行列式正则化去做，并给出参考「Polchinski (1986)」。

#### E11 bc 鬼场的配分函数：裸迹为零，须插入零模
- 位置：**§7.2「The bc CFT」，(7.2.23)–(7.2.27)，p.212**
- 类型：proposition
- 原文陈述：
  - **(7.2.23)**：`Tr[exp(2πiτ₁P − 2πτ₂H)] = (qq̄)^{13/12}Tr(q^{L₀}q̄^{L̃₀}) = 4(qq̄)^{1/12}∏_{n=1}^∞|1+q^n|⁴`（四个基态、每模 `(1+q^n)`）。
  - **★ 反周期性 vs 周期性（逐字）**：「Recall, however, that for anticommuting fields the simple trace corresponds to a path integral with **antiperiodic** boundary conditions in the time direction. In order to calculate the Faddeev–Popov determinant, the ghosts must have the same periodicity as the original coordinate transformations, which were periodic. Thus we need `Z(τ) = Tr[(−1)^F exp(2πiτ₁P − 2πτ₂H)] = 0` (**7.2.24**)」
  - 消失的两种解释（逐字）：「The trace vanishes because the states `|↓↓⟩` and `|↑↑⟩` have opposite ghost number mod 2 from `|↑↓⟩` and `|↓↑⟩`. From the path integral point of view, `Z(τ)` vanishes due to **ghost zero modes from the moduli and CKVs**. These must be saturated with appropriate insertions, the simplest nonvanishing amplitude (**and the one we will need**) being `⟨c(w₁)b(w₂)c̃(w̄₃)b̃(w̄₄)⟩` (**7.2.25**).」
  - **(7.2.26)** `Tr[(−1)^F c₀b₀c̃₀b̃₀ exp(…)]`；`c₀b₀c̃₀b̃₀` 投影到唯一基态 `|↑↑⟩`；
  - **★ (7.2.27)**：`(qq̄)^{1/12}∏_{n=1}^∞|1−q^n|⁴ = |η(τ)|⁴`。
  - 逐字：「Note the sign change in the infinite product, from the `(−1)^F` in the trace. The result (7.2.27) is **independent of the positions of the ghost fields** because the CKV and quadratic differentials on the torus are constants.」
  - **★ 第三条作者自承缺口（p.213 首句，逐字）**：「Again, **we do not try to keep track of the overall sign, setting it to be positive.**」
- 文献自称的严格程度：计算完整，但**整体符号人为设定**
- 文献列出的依赖：E8、`bc` CFT 的 `c = −26`、`(qq̄)^{13/12}` 即 `−c/24` 项
- 备注：`|η|⁴` 恰好抵消两套振子 ⇒ (7.3.6) 的指数 `−48 = −24×2`（`26 − 2 = 24` 个横向模）。

#### E12 一般 CFT 的环面配分函数
- 位置：**§7.2「General CFTs」，(7.2.28)，p.213**
- 类型：definition/proposition
- 原文陈述：**(7.2.28)** `Z(τ) = Σ_i q^{h_i − c/24} q̄^{h̃_i − c̃/24}(−1)^{F_i}`，`i` 跑遍 CFT 的全部态，`F_i` 是世界面费米数。
- 文献自称的严格程度：直接给出
- 文献列出的依赖：E8、E11
- 备注：本式是 §8.4 Narain 格论证 (8.4.21) 的模板。

#### E13 ★★ 模不变性对谱的两条约束（`c − c̃ ∈ 24Z` 与自旋整数性）
- 位置：**§7.2，(7.2.29) 及其上方一段，p.213**
- 类型：proposition
- **原文逐字**：
  > 「**Invariance under `τ → τ + 1` requires `h_i − h̃_i − (1/24)(c − c̃)` to be an integer. Looking at the unit operator, this requires `c − c̃` to be a multiple of 24. For general operators one then has the requirement that the spin be an integer,**
  > `h_i − h̃_i ∈ **Z**` .  (7.2.29)」
- **紧接的一段也逐字（极重要，常被略掉）**：
  > 「Incidentally, CFTs for which `c − c̃` is not a multiple of 24 are certainly of interest. **These cannot be separately modular-invariant, but with appropriate projections can be combined into a modular-invariant theory.**」
- 文献自称的严格程度：**这是一条真正的推导**（从 (7.2.28) 在 `τ→τ+1` 下的相位直接读出），措辞是 "requires"，不是 "we guess"。**逻辑链条完整且短**，是本章最接近 `rigorous` 的一条。
- 文献列出的依赖：E12
- 备注（**对下游最关键的一条**）：
  1. **(7.2.29) 是有前提的结论**：先要 `c − c̃ ∈ 24Z`（由单位算子那一支得到），**然后**一般算子才得到 `h − h̃ ∈ Z`。
     ⚠ `polchinski-1998-v1.md` **E138** 引用 (7.2.29) 时写作「模不变性要求 `L₀ − L̄₀ ∈ Z`」，**把 `c − c̃ ∈ 24Z` 这个前提省略了**。在 26 维平坦时空里 `c = c̃ = 26` 前提自动满足，所以结论不受影响，但**建节点时前提必须写进 statement**，否则该卡在一般 CFT 下是错的。见 **Q3**。
  2. 本条只用了 `τ → τ + 1`（模群的 T 生成元）。**`τ → −1/τ`（S）给出的是另一类约束**，见 E14。

#### E14 高权态密度由中心荷决定（Cardy 型；带明确的适用条件脚注）
- 位置：**§7.2，(7.2.30) 与脚注 1，p.213**
- 类型：proposition
- 原文陈述：
  - 论证（逐字骨架）：「Consider the partition function for `τ = iℓ` as `ℓ → 0`. The convergence factor `q = exp(−2πℓ)` is approaching unity, so the partition function is determined by the density of states at high weight. **Using modular invariance**, this is equal to the partition function at `τ = i/ℓ`. In the latter case, `q = exp(−2π/ℓ)` is going to zero, so the state of lowest weight dominates the sum. This is the unit state, with `L₀ = L̃₀ = 0`, giving」
  - **(7.2.30)**：`Z(iℓ) ≈^{ℓ→0} exp[π(c + c̃)/(12ℓ)]`
  - 逐字：「The density of states at high weight is thus determined by the central charge. This generalizes the free-boson result, where `c = c̃ = d` counts the number of free bosons.」
  - **★ 脚注 1（逐字，位置就在同页页脚）**：
    > 「To be precise, the result (7.2.30) holds in **compact unitary** CFTs. In nonunitary theories there are usually operators of negative weight, whose contribution will dominate that of the unit operator. In the linear dilaton theory, the central charge depends on `V^μ` but the density of states does not: here the exception occurs because of complications due to the **noncompactness** of `X^μ` combined with **lack of translation invariance**.」
- 文献自称的严格程度：**「Let us here note just one general consequence」**——是一个**结果陈述**（"one general consequence"），论证是标准的鞍点/主导态论证，**没有误差估计**（用的是 `≈`）。但**假设条件由脚注写得极精确**。
- 文献列出的依赖：E12、E13（模不变性）
- 备注：**这条脚注是本章质量最高的「假设显式化」样本**，建卡时必须原样带上「compact unitary」。⚠ 原书**没有**把它叫作 Cardy 公式，**也没有引 Cardy**。

#### E15 θ 函数的定义与性质（本章的数学工具箱）
- 位置：**§7.2「Theta functions」，(7.2.31)–(7.2.42)，pp. 214–215**
- 类型：definition + proposition（一组）
- 原文陈述（逐式）：
  - **(7.2.31)** `ϑ(v,τ) = Σ_{n=−∞}^∞ exp(πin²τ + 2πinv)`
  - **(7.2.32a)** `ϑ(v+1,τ) = ϑ(v,τ)`；**(7.2.32b)** `ϑ(v+τ,τ) = exp(−πiτ − 2πiv)ϑ(v,τ)`；
    逐字：「**and these in fact determine it up to normalization.**」
  - **(7.2.33a)** `ϑ(v,τ+1) = ϑ(v+1/2,τ)`；**(7.2.33b)** `ϑ(v/τ,−1/τ) = (−iτ)^{1/2}exp(πiv²/τ)ϑ(v,τ)`
  - 逐字：「The theta function has **a unique zero**, up to the periodicity (7.2.32), at `v = ½(1+τ)`.」
  - **(7.2.34)** 无穷乘积 `ϑ(v,τ) = ∏_{m=1}^∞ (1−q^m)(1+zq^{m−1/2})(1+z^{−1}q^{m−1/2})`；**(7.2.35)** `q = exp(2πiτ)`、`z = exp(2πiv)`
  - **★ 关于渐近行为的方法论一句（逐字）**：「The `q → 0` behavior can be read immediately from either the infinite sum or infinite product form. **The `q → 1` behavior is not manifest in either form, because an infinite number of terms contribute.** It can be obtained from the `τ → −1/τ` modular transformation, which relates these two limits by `q → exp(4π²/ln q)`.」
  - **(7.2.36)** 带特征标的 θ 函数 `ϑ[a;b](v,τ)`；**(7.2.37a–d)** 与 `ϑ₃/ϑ₄/ϑ₂/ϑ₁` 的对照（`ϑ₀₀=ϑ₃`、`ϑ₀₁=ϑ₄`、`ϑ₁₀=ϑ₂`、**`ϑ₁₁ = −ϑ₁`**）
  - **(7.2.38a–d)** 四个乘积表示；**(7.2.39a–d)** `τ→τ+1`；**(7.2.40a–d)** `τ→−1/τ`
  - **(7.2.41)（Jacobi「abstruse identity」）**：`ϑ⁴₀₀(0,τ) − ϑ⁴₀₁(0,τ) − ϑ⁴₁₀(0,τ) = 0`；逐字「a special case of a quartic identity of Riemann」
  - **(7.2.42)** `ϑ₁₁(0,τ) = 0`
  - 逐字：「We will encounter these functions more extensively in the superstring.」
- 文献自称的严格程度：**全部无证明**。(7.2.32) 的唯一性（"determine it up to normalization"）、零点唯一性、Jacobi 恒等式**都是断言**。(7.2.20) 是唯一被说成「easily verified」的。
- 文献列出的依赖：无（数学工具，无外部引用）
- 备注：**这是本章最大的一片「可形式化但原书零证明」的区域**。见 §5-C 的 Lean 岛建议。习题 **7.5** 把 θ 函数的渐近行为（含 `τ` 趋于实轴上有理/无理点的差别）留给读者。

#### E16 ★ Dedekind η 的两个表示与模变换
- 位置：**§7.2 末，(7.2.43)–(7.2.44)，p.216**
- 类型：definition + proposition
- 原文陈述：
  - **(7.2.43)**：`η(τ) = q^{1/24}∏_{m=1}^∞(1−q^m) = [∂_vϑ₁₁(0,τ)/(−2π)]^{1/3}`
  - **(7.2.44a)**：`η(τ+1) = exp(iπ/12) η(τ)`
  - **(7.2.44b)**：`η(−1/τ) = (−iτ)^{1/2} η(τ)`
- 文献自称的严格程度：**逐字只有「It has the modular transformations」——纯断言，无证明、无引用。**
- 文献列出的依赖：E15（(7.2.39d)/(7.2.40d) 与 (7.2.43) 的第二个等号）
- 备注：**(7.2.44b) 是全书模不变性的承重墙**：E9、E20（(7.3.6)）、(8.4.21)、(7.4.2) 全都直接用它。**而原书对它零证明。** ⇒ 这是 §5-C 里优先级最高的 Lean 岛候选。



### 2.3 §7.3 The torus amplitude（pp. 216–222）

#### E17 环面上的 n 点弦振幅（把 (5.3.9) 落到环面上）
- 位置：**§7.3 开头，(7.3.1)，p.216**
- 类型：proposition
- 原文陈述：
  - 逐字：「We now apply to the torus the general result **(5.3.9)** expressing the string amplitude as an integral with ghost and vertex operator insertions. **The two CKVs require one vertex operator to be fixed**, so
    `S_{T²}(1;2;…;n) = ½∫_{F₀} dτdτ̄ ⟨ BB̃ c̃c𝒱₁(w₁,w̄₁) ∏_{i=2}^n ∫dw_i dw̄_i 𝒱_i(w_i,w̄_i) ⟩_{T²}` (**7.3.1**)」
  - 逐字：「**The fundamental region `F₀` and the factor of ½ from `w → −w` were discussed in section 5.1.** As usual for complex variables, `dτdτ̄ = 2dτ₁dτ₂`, where `τ = τ₁ + iτ₂`.」
- 文献自称的严格程度：**把 `F₀` 与 `½` 这两件事整体外包给 §5.1**，本章不重述、不论证。
- 文献列出的依赖：**(5.3.9)**、§5.1
- 备注：⚠ **`F₀` 在本书有两个不同的写法**（(5.1.15) 闭区域含边界，(7.3.14) 开区域），见 **E24 / Q1**。

#### E18 鬼场插入的化简与 CKG 体积的处理
- 位置：**§7.3，(7.3.2)–(7.3.4)，pp. 216–217**
- 类型：proposition
- 原文陈述：
  - **(7.3.2)**：`B = (1/4π)(b,∂_τ g) = (1/2π)∫d²w b_{ww}(w)∂_τ g_{w̄w̄} = (i/4πτ₂)∫d²w b_{ww}(w) → 2πi b_{ww}(0)`。
    逐字：「We have used the result **(7.2.13)** for the `τ`-derivative of the metric. In the final line we have used the fact that the ghost path integral **(7.2.27)** is independent of position to carry out the `w`-integration. (Recall that `d²w = 2dσ¹dσ²` and that `g_{ww̄} = ½`.)」
  - **★ CKG 的处理（逐字）**：「The CKG consists of the translations of the torus. **Since this group has finite volume, we need not fix it**: we can rewrite the amplitude so that all vertex operators are integrated and the volume of the CKG is divided out. **It is easy to do this by hand here.**」平均化因子 **(7.3.3)** `∫dwdw̄/(2(2π)²τ₂)`，逐字「the denominator being the area of the torus, which is the volume of the CKG」。
  - **(7.3.4)**：`S_{T²}(1;2;…;n) = ∫_{F₀}(dτdτ̄/4τ₂)⟨b(0)b̃(0)c̃(0)c(0)∏_{i=1}^n ∫dw_idw̄_i 𝒱_i(w_i,w̄_i)⟩_{T²}`。
    逐字：「**All vertex operators are now on an equal footing.**」
- 文献自称的严格程度：计算，措辞「It is easy to do this by hand here」
- 文献列出的依赖：E17、(7.2.13)、(7.2.27)

#### E19 ★ 环面真空振幅（本章的主角）
- 位置：**§7.3，(7.3.5)，p.217**
- 类型：definition/proposition
- 原文陈述：
  - 逐字：「The form (7.3.4) could also have been derived directly, without the intermediate step of fixing a vertex operator, and **is valid even without vertex operators**,
    `Z_{T²} = ∫_{F₀}(dτdτ̄/4τ₂)⟨b(0)b̃(0)c̃(0)c(0)⟩_{T²}` (**7.3.5**)」
  - **★ 作者对这一式重要性的自评（逐字）**：「This vacuum amplitude is quite interesting and **will be our main focus**. Not only does it reveal the essential difference between the ultraviolet behaviors of string theory and field theory, but it has an important physical interpretation of its own.」
- 文献自称的严格程度：断言 (7.3.4) 也可「directly」导出，**未给该直接导法**
- 文献列出的依赖：E18

#### E20 ★★ 26 维平坦时空的环面真空振幅及其模不变性
- 位置：**§7.3，(7.3.6)–(7.3.7)，p.217**（本条已**单页重渲染复核**）
- 类型：proposition
- 原文陈述：
  - **(7.3.6)**：`Z_{T²} = i V₂₆ ∫_{F₀} (dτ dτ̄ / 4τ₂) (4π²α'τ₂)^{−13} |η(τ)|^{−48}`
  - **★ 模不变性（逐字）**：「The amplitude has the important property of **modular invariance**. The product `τ₂|η(τ)|⁴` is invariant by eq. **(7.2.44)**, and **it is easy to check** that
    `dτdτ̄/τ₂²` (**7.3.7**) is modular-invariant as well.」
  - 逐字：「**Note the exponent `−48`, from the 24 left- and right-moving oscillators. The contribution of the ghosts cancels two sets of oscillators, leaving only the contribution of the transverse modes.** The amplitude with `n` tachyons is given by including the vertex operator expectation value (7.2.4) and integrating over positions.」
- 文献自称的严格程度：**模不变性的两半都是「归约」或「留给读者」**：`τ₂|η|⁴` 不变 **归约到 (7.2.44)**（E16，原书未证）；测度不变「easy to check」（**未做**）。
- 文献列出的依赖：E9、E11、E19、**(7.2.44)**
- 备注：**指数账**：`(4π²α'τ₂)^{−13}` 的 `−13 = −26/2`（26 个 `Z_X` 各出一个 `τ₂^{−1/2}`），`|η|^{−48}` = `26 − 2 = 24` 个横向模 × 左右两侧。**这就是「模不变性 ⇔ D = 26」在环面上的具体表现**；习题 **7.12** 明确要求验证「the vacuum amplitude is modular-invariant **only for `D = 26` and `D' = 24`**」并引 Shapiro (1972)。

#### E21 一般 CFT 的环面真空振幅
- 位置：**§7.3，(7.3.8a)/(7.3.8b)，p.217**
- 类型：proposition
- 原文陈述：**「As long as there are `d ≥ 2` noncompact flat dimensions the ghosts still cancel two sets of bosonic operators」**，于是
  - **(7.3.8a)**：`Z_{T²} = V_d∫_{F₀}(dτdτ̄/4τ₂)∫d^dk/(2π)^d exp(−πτ₂α'k²)Σ_{i∈ℋ^⊥} q^{h_i−1}q̄^{h̃_i−1}`
  - **(7.3.8b)**：`= iV_d∫_{F₀}(dτdτ̄/4τ₂)(4π²α'τ₂)^{−d/2}Σ_{i∈ℋ^⊥} q^{h_i−1}q̄^{h̃_i−1}`
  - 逐字：「Here `ℋ^⊥` is the closed string Hilbert space **excluding the ghosts, the `μ = 0,1` oscillators, and the noncompact momenta**.」
- 文献自称的严格程度：`d ≥ 2` 的条件明写，其余直接给出
- 文献列出的依赖：E20、E12

#### E22 场论侧的对照量：圆上的点粒子路径和
- 位置：**§7.3，(7.3.9)，p.218**
- 类型：proposition
- 原文陈述：
  - 动机逐字：「it is useful to compare with the corresponding quantity in field theory, **the sum over all particle paths with the topology of a circle**」
  - **(7.3.9)**：`Z_{S¹}(m²) = V_d∫d^dk/(2π)^d ∫₀^∞ (dl/2l) exp[−(k²+m²)l/2] = iV_d∫₀^∞(dl/2l)(2πl)^{−d/2}exp(−m²l/2)`
  - 逐字：「This can be derived by gauge-fixing the point-particle path integral, **which was given as exercise 5.2**. The result is intuitive: `l` is the modulus for the circle, `½(k²+m²)` is the world-line Hamiltonian, and the `2l` in the denominator removes the overcounting from **translation and reversal** of the world-line coordinate.」
- 文献自称的严格程度：**推导外包给习题 5.2**
- 文献列出的依赖：exercise 5.2

#### E23 把点粒子结果按弦谱求和（含一个必须带上的前提）
- 位置：**§7.3，(7.3.10)–(7.3.13)，p.218**
- 类型：proposition
- 原文陈述：
  - 逐字：「**As shown in chapter 4**, the physical spectrum is in one-to-one correspondence with `ℋ^⊥`, where the mass is related to the transverse weights by
    `m² = (2/α')(h + h̃ − 2)` (**7.3.10**)」，并带约束 `h = h̃`。
  - **(7.3.11)**：`δ_{h,h̃} = ∫_{−π}^{π}(dθ/2π)exp[i(h−h̃)θ]`
  - **★ 前提（逐字）**：「**In writing this we are assuming that the difference `h − h̃` is an integer. This is true in 26 flat dimensions, and as we have discussed in the previous section it is necessary in general for modular invariance.**」
  - **(7.3.12)**：`Σ_{i∈ℋ^⊥}Z_{S¹}(m_i²) = … = iV_d∫_R (dτdτ̄/4τ₂)(4π²α'τ₂)^{−d/2}Σ_{i∈ℋ^⊥}q^{h_i−1}q̄^{h̃_i−1}`，其中 **`θ + il/α' = 2πτ`**；
  - **(7.3.13)**：`R : τ₂ > 0 , |τ₁| < ½`
- 文献自称的严格程度：谱的对应关系**外包给第 4 章**（无鬼定理）；整数性前提**明写**
- 文献列出的依赖：**第 4 章的谱定理**、E13（(7.2.29)）、E22
- 备注：⚠ 这里把 **E13 反向用作输入**：模不变性 ⇒ `h−h̃ ∈ Z` ⇒ 才能写出 (7.3.11)。**建图时 E13 → E23 是一条真实的边，不是 `inferred`。**

#### E24 ★★★ 弦论 UV 有限性的核心论证（本章最重要的一条）
- 位置：**§7.3，(7.3.14) 及其上下文，p.219**（本条已**单页重渲染复核**）
- 类型：proposition
- **原文逐字（完整段落，本条的核心）**：
  > 「Summing this over the string spectrum as in eq. (7.3.12) only makes things worse, as all the states of the string contribute with the same sign. However, compare the sum (7.3.12) to the actual string amplitude (7.3.8). **There is great similarity but also one remarkable difference. The integrands are identical but the regions of integration are different**: in the string it is the fundamental region
  > `F₀ :  |τ| > 1 ,  |τ₁| < ½ ,  τ₂ > 0`  (**7.3.14**)
  > and in field theory the larger region `R`. **In the string amplitude, the UV divergent region is simply *absent*.** We can also see this from the point of view of the momentum integral (7.3.8a). **Since `τ₂` is bounded below, this integral (after contour rotation) is a convergent Gaussian.**」
- **文献自称的严格程度（关键判定）**：
  - **这是一条「区域对比」论证，不是收敛性定理。** 原书给的全部内容是：(a) 被积函数相同；(b) 积分区域 `F₀ ⊊ R`；(c) `τ₂` 有下界故动量高斯积分收敛。
  - **没有**一致收敛性、求和与积分可交换性、`Σ_{i∈ℋ^⊥}` 收敛性的任何讨论。
  - 强度措辞是叙述性的（"simply absent"、"We can also see this"），**不是** "we prove" / "one can show"。
- 文献列出的依赖：E20/E21、E23、「`F₀` 是基本域」（外包给 §5.1，见 E17）
- 备注（**必须写进节点**）：
  1. **⚠ 不等号不一致（本轮新发现，已跨章核实）**：
     - **(7.3.14)** 逐字是 **`|τ| > 1`，`|τ₁| < ½`，`τ₂ > 0`**（**严格不等号，开区域**）；
     - **(5.1.15)**（本轮**额外核实**，ch.5 PDF p.4 = 印刷 p.148）逐字是 **`−½ ≤ Re τ ≤ ½` , `|τ| ≥ 1`**（**闭区域**），紧跟一句「**except on the boundaries which are identified as shown in the figure**」。
     两者**不是同一个集合**（差一层零测度边界），原书**没有说明为什么 §7.3 改用开区域**。见 **Q1**。
  2. **本条顺带坐实了 `worldsheet.modular-fundamental-domain` 的 `sources.loc`**：`§5.1, eq. (5.1.15), p.148` **经原书页图确认无误**（该节点现有 note 写「未核对 Polchinski 原书」，可以撤销）。见 **§5-B1**。
  3. **(5.1.15) 处原书的强度措辞（本轮逐字取得）**：「Using the modular transformations (5.1.13), **it can be shown that** every `τ` is equivalent to exactly one point in the region `F₀` shown in figure 5.2 … except on the boundaries which are identified as shown in the figure.」——**「it can be shown」，无证明。**
     这为该节点的 ⚠ 提供了**原书自身**的证据（此前只有 [S] 的第三方评价「quite cavalier about the boundaries」）。另一句同样有用：「Because of the identifications one should think of `F₀` as being **rolled up, and open only at `Im τ → ∞`**.」

#### E25 τ₂ → ∞ 的发散：来自快子，且被判为「非普遍」
- 位置：**§7.3，(7.3.15)–(7.3.16)，p.219**
- 类型：proposition
- 原文陈述：
  - **(7.3.15)**：`iV₂₆∫^∞ (dτ₂/2τ₂)(4π²α'τ₂)^{−13}[exp(4πτ₂) + 24² + …]`
  - 逐字：「the asymptotic behavior being controlled by the lightest string states. … **The first term is from the tachyon and diverges due to the positive exponential in the path sum (7.3.9). This divergence is therefore an artifact of a theory with a tachyon, and will not afflict more realistic string theories.** Incidentally, this path sum can be defined by analytic continuation from positive mass-squared, **but there is still a pathology — the continued energy density is complex. This signifies an instability, the tachyon field rolling down its inverted potential.**」
  - **(7.3.16)**：`iV_d∫^∞(dτ₂/2τ₂)(4π²α'τ₂)^{−d/2}Σ_i exp(−πα'm_i²τ₂)`
  - 逐字：「Because the tachyon is always present in bosonic string theory this again diverges; **in the absence of tachyons it will converge.**」
- 文献自称的严格程度：**末句「in the absence of tachyons it will converge」是断言**，无收敛性证明（态数按 E14 指数增长，与 `exp(−πα'm²τ₂)` 的竞争**完全没有讨论**）。
- 文献列出的依赖：E20、E14（隐含，未被原书点名）
- 备注：⚠ **`24²` 不是 `2⁴`**：这是无质量态的简并度 `24 × 24`（左右各 24 个横向模）。与 (7.4.4) 的 `24`（开弦只有一侧）**是不同的数**，别混。

#### E26 ★★ 一般原则：模空间没有 UV 区
- 位置：**§7.3，p.219 末段**
- 类型：proposition（一般性断言）
- **原文逐字**：
  > 「The torus illustrates **a general principle, which holds for all string amplitudes: there is no UV region of moduli space that might give rise to high energy divergences. All limits are controlled by the lightest states, the long-distance physics.** For the torus with vertex operators the `τ`-integration is still cut off as above, but there are more limits to consider as vertex operators approach one another. The same general principle applies to these as well, **as we will develop further in chapter 9**.」
- 文献自称的严格程度：**原书自己的用词就是「a general principle」，不是定理。** 全亏格、带顶点算子的情形**明确推迟到第 9 章**，本章一字不证。
- 文献列出的依赖：E24（本章唯一算过的例子就是环面真空振幅）
- 备注：**这是「弦论 UV 有限」这条流行陈述在 Vol.1 里的最强表述，而其证据基础只有环面真空振幅一例。** 建节点时 `status` 必须是 `physical-argument`，且 statement 里要写明「作者称之为 principle；全亏格情形推迟到 ch.9」。

#### E27 ★★ 为什么不能对模空间做截断（BRST 一致性论证）
- 位置：**§7.3，p.220 首段**
- 类型：proposition
- **原文逐字（几乎全段，本条价值极高）**：
  > 「One might try to remove the UV divergence from field theory by cutting off the `l` integral. Similarly, one might try to make an analogous modification of string theory, for example replacing the usual fundamental region `F₀` with the region `|τ₁| ≤ ½`, `τ₂ > 1` whose lower edge is straight. **However, in either case this would spoil the consistency of the theory: unphysical negative norm states would no longer decouple.** We have seen in the general discussion in **section 5.4** that **the coupling of a BRST-null state is proportional to a total derivative on moduli space.** For the fundamental region `F₀`, the apparent boundaries **I and I′ and II and II′** respectively (shown in **fig. 5.2**) are identified and the surface terms cancel. **Modifying the region of integration introduces real boundaries. Surface terms on the modified moduli space will no longer cancel, so there is nonzero amplitude for null states and an inconsistent quantum theory.** This is directly analogous to what happens in gravity if we try to make the theory finite by some brute force cutoff on the short-distance physics: it is exceedingly difficult to do this without spoiling the local spacetime symmetry and making the theory inconsistent. **String theory manages in a subtle way to soften the short-distance behavior and eliminate the divergences without loss of spacetime gauge invariance.**」
- 文献自称的严格程度：**论证链条完整且可检验**（BRST-null 态耦合 = 模空间上的全导数 ⇒ `F₀` 的表观边界成对认同 ⇒ 面项抵消 ⇒ 截断会造出真边界），但**关键一步整体外包给 §5.4**，本章不重述。
- 文献列出的依赖：**§5.4**（BRST-null 态耦合是模空间上的全导数）、E24、fig. 5.2 的边界标记 I/I′/II/II′
- 备注：**本章唯一一条把「UV 有限性」与「幺正性/一致性」显式连起来的论证**，也是「弦论不能被人为截断」这一说法的原文出处。
  ⚠ 它依赖 §5.4，而 §5.4 已由 `polchinski-1998-v1.md` §12 在 L1 下读过（pp.160–163），**curator 可把这条边建实，不必标 `inferred`**（但要去 §12 核对 §5.4 那条陈述的确切式号）。

#### E28 真空振幅的物理：宇宙学常数
- 位置：**§7.3「Physics of the vacuum amplitude」，(7.3.17)–(7.3.26)，pp. 220–222**
- 类型：proposition（一组）
- 原文陈述（要点）：
  - **(7.3.17)** `Z_vac(m²) = exp[Z_{S¹}(m²)]`（点粒子真空图 = 任意条不连通圆圈，带 `1/n!`）；
    **(7.3.18)** `Z_vac(m²) = ⟨0|exp(−iHT)|0⟩ = exp(−iρ₀V_d)`；**(7.3.19)** `ρ₀ = (i/V_d)Z_{S¹}(m²)`
  - **(7.3.20)** `∫₀^∞(dl/2l)exp[−(k²+m²)l/2] → −½ln(k²+m²)`
    —— 逐字前提：「we will cut off the integral at `l ≥ ε` and then take `ε → 0`, **but drop divergent terms**」
  - **(7.3.21)**；**(7.3.22)** `ρ₀ = ∫ d^{d−1}k/(2π)^{d−1} · ω_k/2`（零点能求和，`ω_k² = k·k + m²`）
  - **(7.3.23)** Coleman–Weinberg 形式 `ln Z_vac(m²) = −½ Tr ln(−∂²+m²) = −(V_d/2)∫d^dk/(2π)^d ln(k²+m²)`
  - **(7.3.24)** `ρ₀ = (i/V_d)Σ_i(−1)^{F_i}Z_{S¹}(m_i²)`，`F_i` 是**时空**费米数（mod 2），自旋 `s_i` 的粒子在四维贡献 `2s_i+1`
  - **(7.3.25)** `|ρ₀| ≲ 10^{−44} GeV⁴`；**(7.3.26)** `m_ew⁴ ≈ 10⁸ GeV⁴`，逐字「**52 orders of magnitude too large**」
  - **★ 弦论侧（逐字）**：「The one-loop vacuum energy density in bosonic string theory is nonzero, and is necessarily of the order of the string scale (**ignoring the tachyon divergence**). In four dimensions this would correspond to `10⁷²` GeV⁴, which is again far too large. In a supersymmetric string theory, there will be a certain amount of cancellation, but again one expects a remainder of at least `m_ew⁴` in a realistic theory with supersymmetry breaking.」
  - **★ §7.3 的收尾句（逐字，作者自承的认识论状态）**：「**The cosmological constant problem is telling us that there is something that we still do not understand about the vacuum, in field theory and string theory equally.** We will return to this problem at various points.」
- 文献自称的严格程度：物理讨论 + 量纲估计；括号里的 "**ignoring the tachyon divergence**" 是**自承的不自洽**（E25 已说该积分发散）。
- 文献列出的依赖：E22、E25；习题 7.6 引 Coleman & Weinberg (1973)
- 备注：**「树级宇宙学常数为零是我们手动安排的」（逐字）**：「At string tree level we had a consistent theory with a flat metric, so the cosmological constant was zero. In fact **we arranged this by hand, when we took 26 dimensions**. One sees from the spacetime action **(3.7.20)** that there would otherwise be a tree-level potential energy proportional to `D − 26`.」
  → 这是 `D = 26` 的又一种表述（树级势能 ∝ `D − 26`），可与图中 `worldsheet.critical-dimension-*` 系列交叉引用。

### 2.4 §7.4 Open and unoriented one-loop graphs（pp. 222–229）

#### E29 圆柱真空振幅
- 位置：**§7.4「The cylinder」，(7.4.1)，p.223**
- 类型：proposition
- 原文陈述：
  - **(7.4.1)**：`Z_{C₂} = ∫₀^∞ (dt/2t) Tr'_o[exp(−2πtL₀)] = iV_d∫₀^∞(dt/2t)(8π²α't)^{−d/2}Σ_{i∈ℋ_o^⊥}exp[−2πt(h_i−1)] → iV₂₆ n² ∫₀^∞ (dt/2t)(8π²α't)^{−13} η(it)^{−24}`
  - 逐字：「This can be obtained either by working out the path integral measure in terms of the ghost zero modes, as we did for the torus, **or by guessing (correctly) that we should again sum the point-particle result (7.3.9) over the open string spectrum**. In the first line the trace is over the full open string CFT, **except for omission of the ghost zero modes as denoted by the prime**. In the final line the trace has been carried out, for the case of 26 flat dimensions, with **`n` Chan–Paton degrees of freedom**. Including tachyon vertex operators is straightforward.」
  - 逐字：「The `t → ∞` limit of the cylinder is much like the `τ₂ → ∞` limit of the torus. … As in the closed string there is a divergence, **but only from the open string tachyon**.」
- 文献自称的严格程度：**作者明说自己走的是「guessing (correctly)」那条路**，另一条（鬼场零模测度）只提及未做。
- 文献列出的依赖：E22（(7.3.9)）、E3、开弦谱
- 备注：`n²` = 圆柱两条边界各挂一个 Chan–Paton 指标。

#### E30 ★★ t → 0 极限：开弦侧「没有模群来截断」，UV 发散看似存在
- 位置：**§7.4，p.223 末段 + (7.4.2)–(7.4.4)，pp. 223–224**
- 类型：proposition
- **原文逐字（本条的核心，与 E24/E26 构成对照）**：
  > 「The `t → 0` limit is rather interesting. **Unlike the case of the torus, there is no modular group acting to cut off the range of integration, and so the UV divergence of field theory still seems to be present. However, we will see that, as with all divergences in string theory, this should actually be interpreted as a *long-distance* effect.** In the `t → 0` limit the cylinder is very long as shown in figure 7.1(a). That is, it looks like a **closed string appearing from the vacuum, propagating a distance, and then disappearing again into the vacuum.**」
- 后续式子：
  - **(7.4.2)**：`η(it) = t^{−1/2} η(i/t)`（引 (7.2.44)）
  - 变量代换 `s = π/t` ⇒ **(7.4.3)**：`Z_{C₂} = i (V₂₆n²)/(2π(8π²α')¹³) ∫₀^∞ ds η(is/π)^{−24}`
  - **(7.4.4)**：`η(is/π)^{−24} = exp(2s)∏_{n=1}^∞[1−exp(−2ns)]^{−24} = exp(2s) + 24 + O(exp(−2s))`
  - 逐字：「one sees the expected asymptotics from expanding in a complete set of closed string states. In other words, if we think of `σ²` as world-sheet time and `σ¹` as world-sheet space, figure 7.1(a) is a very short open string loop. **If we reverse the roles of world-sheet space and time, it is a very long closed string world-line beginning and ending on boundary loops. In the Euclidean path integral, either description can be used, and each is useful in a different limit of moduli space.**」
- 文献自称的严格程度：论证是**模变换 + 展开**，可机械验证；「should actually be interpreted as」是解释性判断。
- 文献列出的依赖：E29、**(7.2.44)**（即 E16）
- 备注：**开闭弦通道对偶（open–closed duality）在本书的第一次出现就在这里**，没有单独命名。

#### E31 ★ tadpole 发散的起源：圆盘单点函数 × 闭弦传播子 × 圆盘单点函数
- 位置：**§7.4，(7.4.5)–(7.4.6)，p.224 + fig. 7.1(b)(c)**
- 类型：proposition
- 原文陈述：
  - **(7.4.5)**：`∫₀^∞ ds exp(βs) ≡ −1/β` —— 逐字前提：「**The leading divergence in the vacuum amplitude is from the closed string tachyon. This is uninteresting and can be defined by analytic continuation**」
  - **★ 无质量态那一项（逐字）**：「**The second term, from the massless closed string states, gives a divergence of the form `1/0` even with the continuation.** To see the origin of this divergence, imagine separating the process as shown in figure 7.1(b). **As we have discussed in section 6.6, there is a nonzero amplitude with one closed string vertex operator on the disk. This *tadpole* corresponds to a closed string appearing from or disappearing into the vacuum. In between the two tadpoles is the closed string propagator.** In momentum space the massless propagator is proportional to `1/k²`. Here, **momentum conservation requires that the closed string appear from the vacuum with zero momentum, so the propagator diverges.**」
  - 场论类比：**(7.4.6)** `1/k²|_{k^μ=0}`，图 7.1(c)。
  - **★ 判定（逐字）**：「**This is a long-distance (IR) divergence, because poles in propagators are associated with propagation over long spacetime distances.**」
- 文献自称的严格程度：机制解释 + 图示，措辞是解释性的；**「圆盘上单闭弦顶点算子振幅非零」外包给 §6.6**。
- 文献列出的依赖：**§6.6**（圆盘 tadpole 非零）、E30
- 备注：**这是「tadpole」一词在 Vol.1 的定义位置**。⚠ §6.6 已由 `polchinski-1998-v1.md` §12 在 L1 下读过（pp.194–197），curator 可去核对该处的确切式号。

#### E32 UV vs IR：场论侧的对照（线性项 ⇒ 必须绕新背景展开）
- 位置：**§7.4，(7.4.7)–(7.4.8)，p.225**
- 类型：proposition
- 原文陈述：
  - 逐字：「**UV and IR divergences in quantum field theory have very different physical origins. UV divergences usually signify a breakdown of the theory, the need for new physics at some short distance. IR divergences generally mean that we have asked the wrong question, or expanded in the wrong way. So it is here.**」
  - **(7.4.7)**：`−(1/g²)∫d^dx(½∂_μφ∂^μφ + gΛφ)`；**(7.4.8)**：运动方程 `∂²φ = gΛ`
  - 逐字：「**does not allow `φ(x) = 0` as a solution.** Instead we must expand around a solution to the equation (7.4.8); **any solution is necessarily position-dependent. The resulting amplitudes are free of divergences.** This is true even though the right-hand side is a perturbation (we have included the factor of `g` appropriate to the disk), because **it is a singular perturbation. In particular, the corrected background breaks some of the Poincaré symmetry of the zeroth order solution.**」
- 文献自称的严格程度：物理论证；「The resulting amplitudes are free of divergences」是**断言，无证明**。
- 文献列出的依赖：E31

#### E33 弦论侧：圆盘 tadpole 是 dilaton 与度规的源；细节推迟到第 9 章
- 位置：**§7.4，(7.4.9)，p.225**
- 类型：proposition
- 原文陈述：
  - **(7.4.9)**：`−Λ∫d²⁶x(−G)^{1/2}e^{−Φ̃}` —— 逐字「The situation is just the same in string theory. **The disk tadpole is a source … for both the dilaton and metric.**」
  - **★ 作者自承的推迟（逐字）**：「Expanding around a solution to the corrected field equations (with the metric and dilaton no longer constant) leads to finite amplitudes. **The details are a bit intricate, and will be discussed somewhat further in chapter 9.**」
  - 逐字：「Incidentally, in supersymmetric string theories **if the string background is invariant under supersymmetry, it usually receives no loop corrections**.」（注意 "usually"）
- 文献自称的严格程度：**「The details are a bit intricate, and will be discussed somewhat further in chapter 9」——本章不做，且 ch.9 也只是 "somewhat further"。**
- 文献列出的依赖：E32、E31

#### E34 开弦理论必须包含闭弦
- 位置：**§7.4，(7.4.10)，p.225 末 + p.226 首**
- 类型：proposition
- **原文逐字**：
  > 「The pole (7.4.6) is the same kind of divergence encountered in the tree-level amplitudes, a resonance corresponding to propagation over long spacetime distances. If we add open string vertex operators to each end of the cylinder so that it represents a one-loop open string scattering amplitude, then the momentum `k^μ` flowing from one boundary to the other is in general nonzero. The large-`s` limit (7.4.4) then includes a factor of `exp(−α'k²s/2)` (**7.4.10**) and the divergence becomes a momentum pole representing scattering of open strings into an intermediate closed string. **Thus, as claimed in chapter 3, an open string theory must include closed strings as well.** It is curious that the mechanism that removes the UV divergence is different in the closed and open string cases. **In the closed string it is an effective cutoff on the modular integration; in the open string it is a reinterpretation of the dangerous limit of moduli space in terms of long distances.**」
- 文献自称的严格程度：论证是「极点位置 + 通道解释」，措辞 "as claimed in chapter 3"（**即第 3 章已声称，这里给证据**）。
- 文献列出的依赖：E30、E31、第 3 章
- 备注：末句的对比是本章最凝练的结论之一，值得整句进节点。

#### E35 边界态 |B⟩ 表示（归一化未定）
- 位置：**§7.4，(7.4.11)–(7.4.13)，p.226**
- 类型：proposition
- 原文陈述：
  - 把 `σ¹` 当时间、`σ²` 周期 `2π`、边界在 `σ¹ = 0, s` ⇒ **(7.4.11)** `⟨B|c₀b₀ exp[−s(L₀+L̃₀)]|B⟩`
  - **(7.4.12)**：`(α^μ_n + α̃^μ_{−n})|B⟩ = (c_n + c̃_{−n})|B⟩ = (b_n − b̃_{−n})|B⟩ = 0`，all `n`
    （逐字来历：「The **boundary state `|B⟩`** is determined by the condition that `∂₁X^μ`, `c¹`, and `b₁₂` vanish on the boundary.」）
  - **(7.4.13)**：`|B⟩ ∝ (c₀+c̃₀)exp[−Σ_{n=1}^∞(n^{−1}α_{−n}·α̃_{−n} + b_{−n}c̃_{−n} + b̃_{−n}c_{−n})]|0;0⟩`
  - **★ 作者自承缺口（逐字）**：「Using this in (7.4.11) gives the result (7.4.3), **except that the normalization of `|B⟩` is undetermined.** This representation is useful in analyzing the `t → 0` limit and the closed string poles.」
  - **★ 第二处推迟（逐字）**：「**By comparing the string and field theory calculations we can determine the disk tadpole `Λ`, but it will be more convenient to do this in the next chapter as a special case of a more general result.**」
- 文献自称的严格程度：**归一化未定 + `Λ` 的确定推迟到第 8 章**
- 文献列出的依赖：E30、E33
- 备注：习题 **7.14** 要求「Show that the amplitude (7.4.11) with the boundary state (7.4.13) reproduces the cylinder amplitude (7.4.3)」——**原书没做，留作习题**。

#### E36 Klein 瓶真空振幅与两个 cross-cap 的表示
- 位置：**§7.4「The Klein bottle」，(7.4.14)–(7.4.19)，pp. 226–227**
- 类型：proposition
- 原文陈述：
  - **(7.4.14)**：`Z_{K₂} = ∫₀^∞(dt/4t)Tr'_c{Ω exp[−2πt(L₀+L̃₀)]} = iV_d∫₀^∞(dt/4t)(4π²α't)^{−d/2}Σ_{i∈ℋ_c^⊥}Ω_i exp[−2πt(h_i+h̃_i−2)]`
  - **★ 因子 ½ 的来历（逐字，本章计数的关键）**：「Relative to the torus in the oriented theory there is an extra `½` from the projection operator `½(1+Ω)`. **For the same reason there is an extra `½` in both the torus and cylinder amplitudes in the unoriented theory.** One can also think of this as coming from the extra gauge invariance `w → w̄`.」
  - 迹的计算（逐字）：「note that the only diagonal elements of `Ω` are those for which the right- and left-movers are in the same state, and these states contribute with `Ω = +1`. The trace is then effectively over only one side, which is the same as the open string spectrum, except that **the weight is doubled** because the right- and left-movers make equal contributions.」⇒
  - **(7.4.15)**：`Z_{K₂} → iV₂₆∫₀^∞(dt/4t)(4π²α't)^{−13}η(2it)^{−24}`
  - 两个基本区 **(7.4.16a)** `0 ≤ σ¹ ≤ 2π, 0 ≤ σ² ≤ 2πt`、**(7.4.16b)** `0 ≤ σ¹ ≤ π, 0 ≤ σ² ≤ 4πt`，都对应认同 **(7.4.17)** `w ≅ w+2π ≅ −w̄+2πit`；**(7.4.18)** `w ≅ w+4πit`，`w+π ≅ −(w̄+π)+2πit`
  - **★ cross-cap 的定义（逐字）**：「The left-hand edge is identified with itself after translation by half its length and reflection through the edge, and similarly the right-hand edge: **this is the definition of a cross-cap.** Thus we have the representation in figure 7.2(a) as **a cylinder capped by two cross-caps**.」（兑现了 E4 的推迟）
  - 重标度 `1/2t` ⇒ 长度 `s = π/2t`，模变换后 **(7.4.19)**：`Z_{K₂} = i (2²⁶ V₂₆)/(4π(8π²α')¹³) ∫₀^∞ ds η(is/π)^{−24}`
  - 逐字：「The modulus `t` runs over the same range `0 < t < ∞` as for the cylinder, **so the `t → 0` divergences are the same.** Again the `1/0` pole has a long-distance interpretation in terms of a closed string pole.」图 7.2(b) 标为 **`RP₂` tadpole**。
- 文献自称的严格程度：计算完整；**只有几何认同的验证是逐步给出的**，其余直接给。
- 文献列出的依赖：E4、E29、E30、(7.2.44)
- 备注：习题 **7.13** 要求「Carry out the steps, parallel to those used to derive the torus amplitude (7.3.6), to obtain the vacuum Klein bottle amplitude (7.4.15) from the string path integral」——**即原书本身没有从路径积分导出 (7.4.15)**。

#### E37 ★ Möbius 带真空振幅与 SO(n)/Sp(k) 的计数
- 位置：**§7.4「The Möbius strip」，(7.4.20)–(7.4.23)，p.228**
- 类型：proposition
- 原文陈述：
  - **(7.4.20)**：`Z_{M₂} = iV_d∫₀^∞(dt/4t)(8π²α't)^{−d/2}Σ_{i∈ℋ_o^⊥}Ω_i exp[−2πt(h_i−1)]`
    逐字：「This differs from the result on the cylinder only by the `Ω` and the factor of `½` from the projection operator.」
  - 逐字：「In 26 flat dimensions, the effect of the operator `Ω` in the trace is **an extra `−1` at the even mass levels** plus an appropriate accounting of the Chan–Paton factors. The oscillator trace is thus
    `exp(2πt)∏_{n=1}^∞[1−(−1)^n exp(−2πnt)]^{−24} = ϑ₀₀(0,2it)^{−12} η(2it)^{−12}` (**7.4.21**)」
  - **★★ 群论计数（逐字，本条最重要的一句）**：
    > 「**For the `SO(n)` theory the `½n(n+1)` symmetric states have `Ω = +1` while the `½n(n−1)` antisymmetric states have `Ω = −1` for a net contribution of `n`. For the `Sp(k)` theory these degeneracies are reversed, giving `−n` (recall that in our notation `Sp(k)` corresponds to `n = 2k` Chan–Paton states).**」
  - **(7.4.22)**：`Z_{M₂} = ±inV₂₆∫₀^∞(dt/4t)(8π²α't)^{−13}ϑ₀₀(0,2it)^{−12}η(2it)^{−12}`
  - 逐字：「By the same construction as for the Klein bottle, the Möbius strip can be represented as **a cylinder with a boundary at one end and a cross-cap on the other**, as in figure 7.3(a). **The length of the cylinder is now `s = π/4t`.**」（兑现了 E5 的推迟）
  - **(7.4.23)**：`Z_{M₂} = ±2in (2¹³ V₂₆)/(4π(8π²α')¹³) ∫₀^∞ ds ϑ₀₀(0,2is/π)^{−12} η(2is/π)^{−12}`
  - 逐字（p.229 首段）：「As for the annulus this can be written as an operator expression, one of the boundary states in eq. (7.4.11) being replaced by an analogous **cross-cap state `|C⟩`**. There is again a `t → 0` divergence; it corresponds to the process of figure 7.3(a) **with one tadpole from the disk and one from the projective plane**.」
- 文献自称的严格程度：计数论证明确写出；`±` 号绑定 `SO`/`Sp` 而**未逐一验证**
- 文献列出的依赖：E5、E29、E36、E15（`ϑ₀₀`）
- 备注：习题 **7.15** 要求「(a) Find the state `|C⟩` corresponding to a cross-cap. (b) By formulae analogous to eq. (7.4.11), obtain the Klein bottle and Möbius strip vacuum amplitudes.」——**`|C⟩` 原书没给。**

#### E38 ★★★ tadpole 相消：Vol.1 给的是 **SO(2¹³) = SO(8192)**，不是 SO(32)
- 位置：**§7.4 最后一段，(7.4.24)，p.229**（本条已**单页重渲染复核**，并做过独立算术交叉核验，见 §0.4）
- 类型：proposition
- **原文逐字（整段，一字不漏）**：
  > 「In the unoriented theory the divergences on these three surfaces combine into
  >
  > `i (24 V₂₆)/(4π(8π²α')¹³) (2¹³ ∓ n)² ∫₀^∞ ds` .  (**7.4.24**)
  >
  > **That is, the total tadpole is proportional to `2¹³ ∓ n`. For the gauge group `SO(2¹³) = SO(8192)` this vanishes, the tadpoles from the disk and projective plane canceling. For the bosonic string this probably has no special significance, but the analogous cancellation for `SO(32)` in superstring theory does.**」
- **文献自称的严格程度（逐层拆解，这是本条的关键）**：
  1. **(7.4.24) 本身是一次直接的求和**（三个面的无质量 tadpole 相加），可机械复算；本轮**已独立复算通过**（§0.4）。
  2. **「For the gauge group `SO(2¹³) = SO(8192)` this vanishes」是硬结论**，但它是**玻色弦**的结论，`n = 2¹³ = 8192`。上号 `∓` 中的 `−` 对应 `SO(n)`（见 E37 的 `±`）。
  3. **「For the bosonic string this probably has no special significance」——作者亲口给玻色弦这条结论判了「probably 无特殊意义」。** 强度词是 **"probably"**。
  4. **「but the analogous cancellation for `SO(32)` in superstring theory does」——这是全章唯一一次出现 `32`，而且是一句「前向指路」，没有任何计算、没有式号、没有引文献。**
- 文献列出的依赖：E29（圆柱）、E36（Klein）、E37（Möbius）；「超弦侧」**无依赖、无引用**
- 备注（**curator 必读的三条红线**）：
  1. **⚠⚠⚠ 不得由本章建立「type I / SO(32) tadpole 相消」的节点。** 本章算的是**玻色弦**，得到的群是 **`SO(8192)`**。`SO(32)` 在本章**只作为一句关于超弦的前向断言出现**，作者未给任何论据。
     → 如果图里要 `spectrum.type-i-tadpole-cancellation-so32`，**它的 Vol.1 来源不是第 7 章**；正确的 Polchinski 位置在 **Vol.2 §10.8「Type I superstring / tadpole」附近**（本项目 `polchinski-1998-v2.md` 只抽了 §10–§11，需核对该节是否覆盖），而**弦论侧的原始文献是 `green-schwarz-1985-hexagon`（正文仍 L0）**、有效场论侧是 `green-schwarz-1984`。
  2. **本章可以建的是一条真正有内容的新节点：`spectrum.bosonic-unoriented-tadpole-cancellation-so8192`**（玻色弦、无取向、`n = 2¹³`）。这条在本项目里**是新的**（`uv run stringgraph search` 里 `so-32`/`tadpole` 均无命中），而且它**恰好是「反常抵消不是超弦独有的数论巧合」这一论点的原文证据**——作者自己说玻色弦这条 "probably has no special significance"。
  3. **「32」的两种来历不要混**（本项目已有两条独立记录）：
     - **本章的 `2¹³ = 8192`** 来自 `2^{13}`，而 `13 = 26/2`（(7.4.19) 的 `2²⁶` 与 (7.4.23) 的 `2¹³` 都从这里来）；
     - **GSW Vol.2 §10.2 的「32」**（见 `extractions/gsw-1987-v2.md`）来自「六边形内线上奇数个扭转的分布方式数」，且超弦侧是 `2^{10/2} = 32`。
       **两者是同一个机制在 `D = 26` 与 `D = 10` 下的不同取值**（`2^{D/2}`），但**这句话是抽取者的推断，原书没有写**，不得当作原文陈述使用。见 **Q4**。

#### E39 §7.4 相关的习题（原书自己留下的缺口清单）
- 位置：**Exercises 7.1–7.15，pp. 229–230**
- 类型：（登记，不建节点）
- 与本章结论直接相关的：
  - **7.2**：用附录 A 的行列式正则化重导 (7.3.6) 并证明模变换只是置换本征值。**引 "Polchinski (1986)"** ⇒ 这是 (7.3.6) 的一手原始文献候选，本项目 `sources.bib` **未登记**。
  - **7.10**：⚠ **式子读数存疑，见 Q5。** 页图上读到的字符串是
    `Tr(λ^aλ^b)Tr(λ^cλ^d) = Tr(λ^aλ^bλ^cλ^dλ^cλ^d)`，
    但**右端 λ 的个数与指标（尤其后两个）本轮无法确信**（该式在页图上字号很小，`c/d/e/f` 型上标易混）。
    **不得据此建卡；要用先由人复核一次原书 p.230。**
    题干的文字部分则读数清楚，逐字：「Argue that unitarity of the cylinder amplitude with respect to intermediate open strings requires the Chan–Paton factors to satisfy … Show that the gauge group `U(n₁) × U(n₂) × … × U(n_k)` **is consistent with unitarity at tree level, but that this additional condition singles out `U(n)`**.」
    ⇒ **单圈幺正性对 Chan–Paton 群的约束**，与 `spectrum.chan-paton-gauge-group` 直接相关。
  - **7.11**：逐字「This exercise reproduces **the first appearance of `D = 26` in string theory (Lovelace, 1971)**」——用 Coleman–Weinberg 形式算圆柱真空振幅，**「Show that unless `D = 26` and `D' = 24`, the amplitude has branch cuts (rather than poles) in `k²`」**。
  - **7.12**：环面版本，**「the vacuum amplitude is modular-invariant only for `D = 26` and `D' = 24` (Shapiro, 1972)」**。
  - **7.13 / 7.14 / 7.15**：分别是 (7.4.15) 的路径积分推导、(7.4.11)+(7.4.13) ⇒ (7.4.3)、cross-cap 态 `|C⟩`。**这三条都是原书正文没做的步骤。**
- 备注：**7.11 与 7.12 给出 `D = 26` 的两条独立单圈判据**（分支割线 vs 模不变性），且各带一手文献（Lovelace 1971、Shapiro 1972）。这两篇**本项目 `sources.bib` 均未登记**，是很干净的后续检索目标。

---

## 3. 未核实的公式号清单

> **本章内部的式号 (7.1.1)–(7.4.24) 全部经原书页图逐字核实，本节不列它们。**
> 本节只列**第 7 章正文引用、但本轮没有翻到原页去核对的外部式号与结论**。
> 用它们建边时必须标 `inferred: true` 或先去补核。

### 3.1 本章引用的**其他章节**式号（本轮未逐一翻页核对）

| 被引式号 | 第 7 章在哪里引它 | 引用时说它是什么 | 本项目是否已在别处 L1 核过 |
|---|---|---|---|
| **(2.6.10)** | (7.2.5) 下方 | `H = L₀ + L̃₀ − (1/24)(c + c̃)` 生成 `σ²` 平移 | `polchinski-1998-v1.md` §12 读过 §2.4–§2.7（pp.43–52, 55–62），**但没有单独确认 (2.6.10) 的内容** → **待补核** |
| **(3.7.20)** | §7.3 p.222 | 时空作用量，含正比于 `D − 26` 的树级势能 | ❌ 未核 |
| **(5.1.5)/(5.1.8)/(5.1.9)/(5.1.11)/(5.1.12)/(5.1.13)/(5.1.14)** | 经 (5.1.15) 的上下文（本轮读到 p.148） | 模群 `PSL(2,Z)` 的生成、大坐标变换 | **本轮顺带读到 p.148 页图，内容确实如此（L1）**，但未逐式抄录 |
| **(5.1.15)** | (7.3.1) 与 (7.3.14) | 基本域 `F₀` | ✅ **本轮 L1 核实**（ch.5 PDF p.4 = 印刷 p.148），见 E24 |
| **(5.3.9)** | (7.3.1) 的出发点 | 「string amplitude as an integral with ghost and vertex operator insertions」的一般式 | ❌ 未核（`polchinski-1998-v1.md` §12 读的是 §5.1–§5.2 与 §5.4，**跳过了 §5.3**）→ **这是最该补的一条**，因为 (7.3.1) 整条链的起点在它 |
| **§5.4「BRST-null 态的耦合是模空间上的全导数」** | E27 的关键一步 | 无式号，正文陈述 | `polchinski-1998-v1.md` §12 读过 §5.4 pp.160–163 → **待去 §12 查该陈述的确切位置** |
| **fig. 5.2 的边界标记 I / I′ / II / II′** | E27 | `F₀` 表观边界的成对认同 | ❌ 未核（图本身在 p.148 附近，本轮读到的 p.148 正文提到 "figure 5.2" 但未读图） |
| **(6.2.7)** | (7.2.1) | 球面 Green 函数所满足的方程 | ❌ 未核（§12 读的是 §6.4 与 §6.6，跳过 §6.2） |
| **(6.2.13)** | (7.2.4) | 球面上指数算子期望值 | ❌ 未核 |
| **§6.6「圆盘上单闭弦顶点算子的振幅非零」** | E31 的起点 | 无式号，正文陈述 | `polchinski-1998-v1.md` §12 读过 §6.6 pp.194–197 → **待去 §12 查确切位置** |
| **第 3 章「开弦理论必须含闭弦」的 claim** | E34 的 "as claimed in chapter 3" | — | ❌ 未核 |
| **第 4 章「物理谱 ↔ `ℋ^⊥` 一一对应」** | E23 | 无鬼定理的结果 | ✅ `polchinski-1998-v1.md` §12 全章 L1 读过 pp.121–144 → **待去 §12 取确切式号** |
| **exercise 5.2** | E22 的推导外包处 | 点粒子路径积分的规范固定 | ❌ 未核 |
| **Appendix A.3** | exercise 7.2 | 谐振算子的行列式正则化 | ❌ 未核（App.A 的 item hash 已知：`D6A09941572ED2451AFC3C5C497F9A9A`） |

### 3.2 本章提到但本项目 `sources.bib` **未登记**的外部文献

| 文献（原书写法） | 出现处 | 它在原书里承担什么 |
|---|---|---|
| **Polchinski (1986)** | exercise 7.2 | (7.3.6) 的行列式正则化推导的一手来源 |
| **Coleman & Weinberg (1973)** | exercise 7.6 | (7.3.23) 的一手来源 |
| **Lovelace (1971)** | exercise 7.11 | 原书逐字称之为「**the first appearance of `D = 26` in string theory**」 |
| **Shapiro (1972)** | exercise 7.12 | 环面真空振幅模不变性 ⇒ `D = 26, D' = 24` |

⚠ 上表四条的**卷期页一律未取**，只有原书正文里的「作者 (年份)」写法。**书末 References（pp.347–358，item hash `F5E26AFC8AF1D3B0E3F3866E752F8FD2`）一次 fetch 即可补齐**，本轮未做。

### 3.3 本章**没有**出现的东西（否定结论，防止误引）

以下逐条都是抽取者通读 25 页后的**否定观察**，写在这里以免后人反复找：

1. **本章没有出现 "type I"、"type IIA/IIB"、"heterotic" 任何一个词。**
2. **本章没有出现 "anomaly"（反常）一词，也没有出现 "hexagon"（六边形）。**
   ⇒ **第 7 章与 `green-schwarz-1984` / `green-schwarz-1985-hexagon` / GSW ch.10 之间没有原文级的连接**，任何这类边都是推断。
3. **本章没有出现 "orientifold" 一词**（`Ω` 投影有，名字没有；该词在 §8.8 才出现）。
4. **本章没有出现 "Cardy"**（E14 的内容是 Cardy 公式，但原书不这么叫、也不引 Cardy）。
5. **本章没有出现 "even self-dual lattice" / "Narain"**（那些在 §8.4）。本章给出的只有 (7.2.29)，即 §8.4 论证的**输入**。
6. **本章没有给出模群 `PSL(2,Z)` 由 `S`、`T` 生成的证明**，只在 E9 处用一句 "thus generating the full modular group" 带过。
7. **`SO(32)` 在本章只出现一次**（p.229 最后一句），**`E₈ × E₈` 零次**。

---

## 4. 未解决的疑问

### Q1 ★ `F₀` 的两个定义不一致：(5.1.15) 是闭区域，(7.3.14) 是开区域
- **事实（两条都 L1）**：
  - (5.1.15)，p.148：`−½ ≤ Re τ ≤ ½ , |τ| ≥ 1`（**闭**），后接「except on the boundaries which are identified as shown in the figure」；
  - (7.3.14)，p.219：`|τ| > 1 , |τ₁| < ½ , τ₂ > 0`（**开**）。
- **原书没有解释这个改动。** 合理猜测是 §7.3 想要一个「边界不重复计数」的代表元集合（开区域 + 零测度边界不影响积分），但**这是抽取者的推断，原书未写**。
- **对图的影响**：`worldsheet.modular-fundamental-domain` 的 statement 现在用的是 (5.1.15) 的闭版本 + 边界认同，**这是对的**（与原书 §5.1 一致）。但若 curator 想为 (7.3.14) 单独建卡或把两者当同一条，**必须先处理这个差异**。
- **建议**：不新建节点，在 `worldsheet.modular-fundamental-domain` 的 `notes` 里加一行「§7.3 (7.3.14) 用开区域版本，两者差一层零测度边界，原书未说明」。

### Q2 ★★ E24/E26「UV 有限」的真实强度：区域对比 vs 收敛性定理
- 原书给的全部内容见 E24：被积函数相同 + 区域更小 + `τ₂` 有下界。
- **原书没有讨论**：`Σ_{i∈ℋ^⊥}` 与 `∫_{F₀}` 能否交换；`Σ_i` 本身在 `F₀` 上是否一致收敛；E14 说态密度按 `exp(π(c+c̃)/(12ℓ))` 增长，而 (7.3.16) 的压制因子是 `exp(−πα'm²τ₂)`——**这两者的竞争在 `τ₂ → ∞` 端才是真正的收敛性问题，原书用「in the absence of tachyons it will converge」一句带过（E25）。**
- **疑问**：本项目要不要把「环面真空振幅在无快子时收敛」单独建成一个 `conjecture` 或 `physical-argument` 节点？它**不是**「UV 有限」（那条是关于 `τ₂ → 0` 的），而是 `τ₂ → ∞` 的 IR 端收敛性。
- **留给 lead/auditor 裁决。** 抽取者的观察：原书把这两件事写在相邻两段，容易被读者合并成一句「弦论有限」，而**它们的证据强度完全不同**（前者是区域对比，后者是断言）。

### Q3 (7.2.29) 被 §8.4 引用时丢了前提
- `polchinski-1998-v1.md` **E138** 写「由 (7.2.29)（模不变性要求 `L₀ − L̄₀ ∈ Z`）」。
- **原书 (7.2.29) 的完整陈述带前提**（E13）：先要 `c − c̃` 是 24 的倍数（由单位算子），**然后**才有 `h − h̃ ∈ Z`。
- 在 §8.4 的场景里 `c = c̃`，前提自动满足，**结论不受影响**；但**建卡时 statement 必须带前提**，否则该卡对一般 CFT 是错的。
- **本轮不改 `polchinski-1998-v1.md`（一篇一文件、只追加不覆盖），在此登记，请 curator 建卡时采用 E13 的完整版本。**

### Q4 「32」与「8192」是否同一机制的 `2^{D/2}`
- **事实**：本章 (7.4.24) 的临界值是 `2¹³`，且 `13 = 26/2`；`gsw-1987-v2` §10.2（本项目 L1 抽取）把超弦侧的 `32` 解释为「六边形内线上奇数个扭转的分布方式数」，而 `32 = 2⁵ = 2^{10/2}`。
- **推断（抽取者，非原文）**：两者是同一计数在 `D = 26` 与 `D = 10` 下的取值 `2^{D/2}`。
- **⚠ Polchinski 第 7 章完全没有说这句话**，他只说「the analogous cancellation for `SO(32)` in superstring theory」——「analogous」是他给的唯一连接词。
- **需要的核实**：Polchinski Vol.2 里 type I tadpole 相消那一节（§10.8 或附近）是否把 `32` 写成 `2^{D/2}` 或类似形式。**本项目 `polchinski-1998-v2.md` 只抽了 §10–§11，需去查 §10.8。**

### Q5 exercise 7.10 的迹恒等式读数存疑
- 页图 p.230 上读到 `Tr(λ^aλ^b)Tr(λ^cλ^d) = Tr(λ^aλ^bλ^cλ^dλ^cλ^d)`，**右端 λ 的个数与后两个上标本轮无法确信**（字号小，上标 `c/d/e/f` 易混）。
- **处理**：该式**不进任何节点**，直到有人复核原书 p.230 或找到独立转述。题干的**文字**部分读数清楚，可以用（见 E39）。

### Q6 (7.2.22) 的「numerical coefficient」与 (7.2.24) 的「overall sign」
- 这是本章两处**作者明确承认没算出来**的量（E10、E11）。
- **疑问**：全书后面有没有把它们补上？(7.2.22) 的系数靠与 (7.2.8) 对照固定；`bc` 的符号则一路「设为正」。
- 如果图里要建「环面配分函数 = `|η|^{-48}` 的两条独立推导」，**全纯法那条必须标出这个缺口**，不能写成与算符法等价的独立证明。

### Q7 本章有没有引 Goddard–Thorn / 无鬼定理的一手文献？
- **E23 只写「As shown in chapter 4」**，本章正文**不引任何外部文献**（本章正文一处文献引用都没有，只有习题里有四处「作者 (年份)」）。
- ⇒ **第 7 章不能用来补 `goddard-thorn-1972` 的引用链。**（书末 References 仍未查，见 §3.2 的备注。）

---

## 5. 对图的建议

> researcher 不写 `graph/`。以下全部是**给 curator 的建议**，每条都注明证据等级与该不该标 `inferred`。
> 本轮已用 `graph/` 下的 grep 确认：`one-loop-vacuum`、`type-i-tadpole`、`self-dual`、`narain` **四个关键词在现图里零命中**，即下面 A 组全是新节点。

### 5-A 建议新建的节点（本章可直接支撑）

| 建议 id | kind / status | statement 要点 | 来源 loc | 依赖 | 备注 |
|---|---|---|---|---|---|
| **`spectrum.one-loop-vacuum-amplitudes`**（或拆成下面几条） | proposition / physical-argument | 见下 | — | — | ⚠ 建议**不要**建成一个大杂烩节点，理由见 5-A0 |
| `worldsheet.torus-vacuum-amplitude-d26` | proposition / physical-argument | (7.3.6) `Z_{T²} = iV₂₆∫_{F₀}(dτdτ̄/4τ₂)(4π²α'τ₂)^{−13}\|η(τ)\|^{−48}` | `§7.3, eq. (7.3.6), p.217` | `worldsheet.modular-fundamental-domain`、E9/E11 对应节点 | E20，L1 |
| `worldsheet.dedekind-eta-modular-transformations` | proposition / **physical-argument**（原书零证明！） | (7.2.44a) `η(τ+1)=e^{iπ/12}η(τ)`；(7.2.44b) `η(−1/τ)=(−iτ)^{1/2}η(τ)` | `§7.2, eq. (7.2.44a,b), p.216` | 无 | E16。**这是全书模不变性的承重墙而原书不证** ⇒ 见 5-C |
| `worldsheet.torus-amplitude-modular-invariant` | proposition / physical-argument | `τ₂\|η(τ)\|⁴` 与 `dτdτ̄/τ₂²` 分别模不变 ⇒ (7.3.6) 模不变 | `§7.3, eq. (7.3.7) 及其上下文, p.217` | 上一条 | E20。「easy to check」= 原书未做 |
| **`worldsheet.modular-invariance-integer-spin`** | proposition / **rigorous 候选** | `τ→τ+1` 不变 ⇒ (a) `c−c̃ ∈ 24Z`（由单位算子）；(b) 一般算子 `h_i − h̃_i ∈ Z` | `§7.2, eq. (7.2.29) 与其上方一段, p.213` | `worldsheet.torus-partition-function-general-cft`（新，(7.2.28)） | **E13。本章逻辑最干净的一条，且是 §8.4 Narain 论证的输入** |
| `worldsheet.torus-partition-function-general-cft` | definition | (7.2.28) `Z(τ)=Σ_i q^{h_i−c/24}q̄^{h̃_i−c̃/24}(−1)^{F_i}` | `§7.2, eq. (7.2.28), p.213` | — | E12 |
| `worldsheet.high-weight-density-from-central-charge` | proposition / physical-argument | (7.2.30) `Z(iℓ) ≈ exp[π(c+c̃)/(12ℓ)]`，**仅在 compact unitary CFT** | `§7.2, eq. (7.2.30) + 脚注 1, p.213` | 上面两条 | E14。**脚注 1 的三条例外必须写进 statement** |
| **`worldsheet.no-uv-region-in-moduli-space`** | proposition / **physical-argument** | 环面：被积函数与场论相同、积分区域是 `F₀ ⊊ R`，UV 发散区「simply absent」；作者由此提出对全部弦振幅成立的 **general principle**，全亏格情形推迟到 ch.9 | `§7.3, eq. (7.3.14) 与 p.219 末段` | `worldsheet.torus-vacuum-amplitude-d26`、`worldsheet.modular-fundamental-domain` | **E24 + E26。本章最重要的节点。** statement 必须写明「作者称 principle 而非定理，唯一算过的例子是环面真空振幅」 |
| **`worldsheet.moduli-cutoff-breaks-brst-decoupling`** | proposition / physical-argument | 把 `F₀` 换成带真边界的区域 ⇒ BRST-null 态耦合的全导数不再抵消 ⇒ 负模态不解耦、理论不一致 | `§7.3, p.220 首段` | **§5.4 的 BRST-null 全导数结论**（图里若已有则连实边，否则先建） | **E27。这条把 UV 有限性与幺正性连起来，是本章论证价值最高的一条** |
| `spectrum.cylinder-vacuum-amplitude` | proposition / physical-argument | (7.4.1)/(7.4.3)，`n` 个 Chan–Paton 自由度 | `§7.4, eqs. (7.4.1)(7.4.3), pp.223–224` | `spectrum.chan-paton-factors` | E29/E30 |
| **`spectrum.open-string-requires-closed-string`** | proposition / physical-argument | 圆柱 `t→0` 的发散是**长距离效应**：闭弦极点；加外腿后 (7.4.10) 把它变成动量极点 ⇒ 开弦理论必须含闭弦 | `§7.4, eqs. (7.4.4)(7.4.6)(7.4.10), pp.224–225` | 上一条、`§6.6 圆盘 tadpole 非零` | E30/E31/E34。**"as claimed in chapter 3" ⇒ 这是第 3 章那条断言的证据节点** |
| **`spectrum.bosonic-unoriented-tadpole-cancellation-so8192`** | proposition / physical-argument | 无取向玻色弦：圆柱 + Klein 瓶 + Möbius 的无质量 tadpole 合为 (7.4.24)，正比于 `(2¹³ ∓ n)²`；对 **`SO(2¹³) = SO(8192)`** 消失（圆盘与射影平面的 tadpole 相消）。**作者判定：对玻色弦「probably has no special significance」** | `§7.4, eq. (7.4.24), p.229` | 上面的圆柱、以及新建的 Klein/Möbius 两条 | **E38。见 5-B2 的红线** |

#### 5-A0 关于 `spectrum.one-loop-vacuum-amplitudes` 这个 id
派工单点名了这个 id。**抽取者的建议是不要用它做一个节点**，理由是本项目原则 1「一个节点一个命题」：
第 7 章的「单圈真空振幅」实际上是**四个不同曲面上的四条不同陈述**（(7.3.6)、(7.4.1)、(7.4.15)、(7.4.22)），
它们的依赖不同（环面靠模不变性、另三个靠 `Ω` 投影与 cross-cap 几何），下游用法也不同。
**如果 lead 坚持要一个汇总 id，建议把它做成 `milestone` 或纯粹的 tag，而不是 statement。**

### 5-B 对**现有节点**的修改建议

**B1（可以立刻做，收益明确）—— `worldsheet.modular-fundamental-domain`**
- 现状：`sources[0].loc = "§5.1, eq. (5.1.15), p.148"`，`note` 里写「L1（读到 schrans-2020 笔记 p.248；**未核对 Polchinski 原书**）」。
- **本轮已核对原书**（ch.5 PDF p.4 = 印刷 p.148）：**式号、页码、内容三者全部正确**。
- 建议改动：
  1. note 里「未核对 Polchinski 原书」改为「**2026-09-11 经 Cambridge Books Online 原书页图 L1 核实（`polchinski-1998-v1-ch7.md` §0.1 步骤 6 / E24 备注 2）**」。
  2. **新增一条原书自身的强度证据**（比现有的 [S] 第三方评价强）：原文逐字「**it can be shown that** every `τ` is equivalent to exactly one point in the region `F₀` … except on the boundaries which are identified as shown in the figure」，以及「one should think of `F₀` as being rolled up, and open only at `Im τ → ∞`」。
     ⇒ 现有 statement 里的「⚠ 边界的认同在本书中未被严格处理」**现在有了原书证据**，不再只依赖 [S]。
  3. notes 里加一行 Q1：「§7.3 (7.3.14) 用的是**开区域** `|τ|>1, |τ₁|<½, τ₂>0`，与 (5.1.15) 的闭区域差一层零测度边界，原书未说明。」

**B2 ★★★ —— 关于 `spectrum.type-i-tadpole-cancellation-so32` 的 Vol.1 来源：结论是「不存在」**
- 派工单假设第 7 章 §7.4 能给这个节点提供 Vol.1 侧来源。**本轮核实的结论是不能。**
- **第 7 章算的是玻色弦，得到的群是 `SO(8192) = SO(2¹³)`，不是 `SO(32)`。**
- **`SO(32)` 在整章只出现一次**，位置是 p.229 最后半句，逐字：
  「For the bosonic string this probably has no special significance, but **the analogous cancellation for `SO(32)` in superstring theory does**.」
  —— **没有计算、没有式号、没有引用、没有「we will show」，是一句纯前向指路。**
- **建议**：
  - **不要**在 `polchinski-1998-v1` 名下建 `spectrum.type-i-tadpole-cancellation-so32`；
  - 若该节点要建，其来源应在 **Polchinski Vol.2**（type I 那一节，须先核实是 §10.8 还是别处）、**`green-schwarz-1985-hexagon`**（正文仍 L0）、或 **`gsw-1987-v2` ch.10**（本项目已 L1，p.143 逐字「the anomaly cancels **if and only if** the gauge group is SO(32)」+「**although the relevant calculations have not been performed**」）；
  - **改建 `spectrum.bosonic-unoriented-tadpole-cancellation-so8192`**（见 5-A 表），并在其 notes 里逐字记下那句 "probably has no special significance"。
    **这条节点本身有独立价值**：它是「tadpole 相消这件事不是超弦独有」的原文证据，同时**作者本人否认玻色弦这一支有意义**——这正是本项目想捕捉的那种「强度实话实说」的样本。

**B3 —— 模不变性卡与 compact 区 `modular-invariance-requires-self-dual-lattice` 的接口**
- 现状：该节点**在图里不存在**（本轮 grep 零命中），是待建节点。
- **本章提供的接口是 E13（(7.2.29)），而且只提供这一半**：
  - **`τ → τ + 1`（T）那一半 ⇒ 偶格**：`polchinski-1998-v1.md` **E138** 已记录，(8.4.19)「`ℓ∘ℓ ∈ 2Z`」直接引 (7.2.29)。**这条边可以建实，不标 `inferred`。**
    ⚠ 但 statement 要用 **E13 的完整版本**（含 `c − c̃ ∈ 24Z` 前提），见 **Q3**。
  - **`τ → −1/τ`（S）那一半 ⇒ 自对偶**：**第 7 章不提供任何东西**。它在 §8.4 (8.4.21)–(8.4.24) 独立做，而且**原书在那里有一个明确的缺口**（`polchinski-1998-v1.md` **E139** 逐字：「Joe claims that "**a little thought shows that it is also necessary if modular invariance is to hold for all `τ`**"」，[S] 复现不出）。
- **因此建议把 `modular-invariance-requires-self-dual-lattice` 拆成两个节点**：
  1. `compact.modular-invariance-implies-even-lattice` —— 依赖 `worldsheet.modular-invariance-integer-spin`（新，本章 E13），**status 可以比较高**；
  2. `compact.self-dual-lattice-implies-modular-invariance` —— (8.4.24) 的**充分方向**，原书有完整推导；
  3. 以及**单独一条 `conjecture`/低状态节点**给**必要方向**（「模不变 ⇒ 自对偶」），因为原书只有 "a little thought shows"。
  **把三者压成一个「⟺」节点会掩盖那个缺口，这正是本项目要避免的。**

**B4 —— `worldsheet.critical-dimension-*` 可加两条独立的单圈判据（来自习题，等级低）**
- 习题 7.11：`D = 26` 的**首次出现**（Lovelace 1971），判据是「否则振幅在 `k²` 里有分支割线而非极点」；
- 习题 7.12：环面真空振幅**只在 `D = 26, D' = 24` 时模不变**（Shapiro 1972）；
- 正文 p.222：树级势能正比于 `D − 26`（引 (3.7.20)）。
- ⚠ **前两条都在习题里，原书正文没做** ⇒ 若建节点，`status` 只能很低，且应把一手来源指向 Lovelace 1971 / Shapiro 1972（**均未登记**，见 §3.2）。

### 5-C Lean 形式化岛的候选（本章产出）

第 7 章意外地是**目前抽取过的章节里数学最干净的一章**：它的核心工具（θ 函数与 `η`）是纯粹的解析数论对象，**而原书对它们零证明**。

| 候选 | 陈述 | 为什么值得 | Mathlib 现状（本轮**未核实**，需 formalizer 确认） |
|---|---|---|---|
| **★ 首选** | **(7.2.44b) `η(−1/τ) = (−iτ)^{1/2}η(τ)`** | **它是 (7.3.6) 模不变性、(7.4.2) 开闭弦对偶、(8.4.21) Narain 三处的共同承重墙，而 Polchinski 一个字都不证** | Mathlib 有 `ModularForm`、`UpperHalfPlane`、`SlashAction`；`DedekindEta` 是否已有**待查** |
| 次选 | (7.2.10)/(7.2.43) `η` 的两种表示相等 | 纯形式幂级数恒等式 | 与 Euler 五边形数定理相关，图里已有 `math.euler-partition-generating-function` |
| 次选 | (7.2.41) Jacobi abstruse identity `ϑ⁴₀₀ − ϑ⁴₀₁ − ϑ⁴₁₀ = 0` | 原书称之为 Riemann 四次恒等式的特例，**无证明无引用** | 待查 |
| 次选 | (7.2.32) ⇒ θ 函数由周期性唯一确定（up to normalization） | 原书逐字「these in fact determine it up to normalization」，**无证明** | 待查 |
| 结构性 | 模群 `PSL(2,Z)` 由 `S`,`T` 生成 | 图里已有 `worldsheet.modular-group-generated-by-s-and-t`；本章 E9 直接用它 | Mathlib 有 `SL(2,ℤ)` 的生成元结果 |

⚠ **注意 `worldsheet.torus-vacuum-amplitude-d26` 本身不是形式化候选**：它含发散积分与 `k⁰ → ik^d` 的转动（E9 逐字），不是良定义的数学对象。**能形式化的是它的被积函数的模不变性，不是振幅。**

### 5-D 本轮给 reading-list 的新增建议

1. **`polchinski-1998-v1` §5.3**（`(5.3.9)` 的出处，pp. 约 154–159）—— **优先级最高的补核目标**，因为 (7.3.1) 整条链从它出发，而 §12 恰好跳过了 §5.3。ch.5 PDF 已落盘，**只需再读 5–6 页**。
2. **`polchinski-1998-v1` 书末 References（pp.347–358）** —— 一次 fetch 可同时补齐：Lovelace 1971 / Shapiro 1972 / Polchinski 1986 / Coleman–Weinberg 1973 的卷期页，**以及长期悬而未决的「Goddard–Thorn 是否被 Vol.1 引用」**。item hash `F5E26AFC8AF1D3B0E3F3866E752F8FD2`。
3. **`polchinski-1998-v2` §10.8 附近的 type I tadpole** —— 回答 **Q4**，并给 `spectrum.type-i-tadpole-cancellation-so32` 找到真正的 Polchinski 来源。item hash `E69C35DC077FD0BAD6B39479144D4A12`（ch.10）。
4. **Lovelace (1971)** 与 **Shapiro (1972)** —— `D = 26` 的两条单圈一手来源，本项目**均未登记**。
5. **`polchinski-1998-v1` Appendix A**（item hash `D6A09941572ED2451AFC3C5C497F9A9A`）—— 同时能闭合 `polchinski-1998-v1.md` §12 留下的 **(A.1.31)**（欧氏约定）与本章习题 7.2 的 **A.3**（行列式正则化）。**一次 fetch 清两笔债。**
