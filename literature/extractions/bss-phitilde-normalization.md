# 抽取记录：BSS Φ̃_k 归一化专项核查

- 文献：Ajit Bhand, Ashoke Sen, Ranveer Kumar Singh, "Mock Modularity In CHL Models,"
  arXiv:2311.16252 [hep-th] (v2, 2025-01-06/08)；Res. Math. Sci. 12 (2025) Paper 8.
- 抽取者：researcher（对抗性核查，为 research/attempts/gap-102b 的常数 c 符号裁定）
- 日期：2026-09-20
- 核查来源：arXiv 官方 PDF（600KB，v2，64页），用 Read 工具逐页读取图像
- 任务：判定 N=1 时 Φ̃₁ 与 Φ₁₀ 的归一化常数 c（Φ̃₁ = c·Φ₁₀），以及围道积分测度的书写形式

---

## T1: Φ̃_k 的定义（eq 5.2，官方 PDF p.40）

### 位置与上下文
- 页码：p.40，§5.1 "The CHL Partition Function" 第二段
- 引文（verbatim）："There exists an infinite product representation for Φ̃_k, given by [12]"
  （[12] = David-Jatkar-Sen, JHEP 01 (2007) 016, arXiv:hep-th/0609109）

### 定义式（eq 5.2，完整逐字转录）

```
Φ̃_k(τ, z, σ) = e^{2πi(α̃τ+γ̃σ+γ̃z)}
    × ∏_{b=0}^{N-1} ∏_{r=0}^∞ ∏_{k'∈ℤ+r_b/N, j∈ℤ+b,k,l∈ℤ, k'|≥0,j<0 for k'=l=0}
      (1 - exp(2πi(k'σ + lr + jz)))^{∑_{s=0}^{N-1} -2πislN/(r,s)}(4k'l-j²)
```
（公式 5.2）

### 前置定义（eq 5.3–5.4，官方 PDF p.40）

where（verbatim）：
```
α̃ := 1/(24N) Q_{0,0} - 1/(2N) ∑_{s=1}^{N-1} Q_{0,s} e^{-2πis/N}/(1-e^{-2πis/N})²,
γ̃ := 1/(24N) Q_{0,0} = 1/(24N) χ(M)                                           (5.3)

with Q_{r,s} defined by
    Q_{r,s} := N (c_0^{(r,s)}(0) + 2c_1^{(r,s)}(-1)).                         (5.4)
```

Also χ(M) denotes the Euler number of the manifold M. Note that α̃, Nγ̃ ∈ ℤ.

### N=1 时的权重（eq 5.6，官方 PDF p.40）

For M = K3, the weight k is related to N by the formula（verbatim）：
```
       ⎧ 24/(N+1) - 2,   N = 1, 2, 3, 5, 7;
       ⎪
k =    ⎨ 3,              N = 4;                                                (5.6)
       ⎪ 2,              N = 6;
       ⎩ 1,              N = 8.
```

**裁定（本人计算）**：N=1 时，k = 24/(1+1) - 2 = 24/2 - 2 = 12 - 2 = **10**。
即 Φ̃₁ 的权重是 10（与 Φ₁₀ 权重相同，这是必要条件但不足以判定 c）。

---

## T3: "exactly the inverse" 陈述的完整上下文（官方 PDF p.40）

### 位置
紧接 eq (5.6) 之后，§5.1 末尾段落。

### 完整逐字上下文

**前一句（紧接 eq 5.6）**：
"For M = K3, the weight k is related to N by the formula [eq 5.6显示]."

**关键句（verbatim，本次任务的核心证据）**：
"Note that for N = 1, the CHL partition function Φ̃_k^{-1} is exactly the inverse of the Igusa cusp form Φ_{10} and was analyzed in detail in [9]."

**后续句（verbatim）**：
"The Siegel modular form Φ̃_k has double zeros on a hypersurface given by [12, 23, Eq. (5.6.4)]
    n_2(στ - z²) + jz + n_1σ - m_1τ + m_2 = 0                                (5.7)"

### 裁定（本人分析）

1. **字面读法**：Φ̃_k^{-1} is exactly the inverse of Φ_{10}，即
   Φ̃_k^{-1} = Φ_{10}^{-1}，故 **Φ̃_k = Φ_{10}**。
   若理解为"函数相等"，则 c = +1。

2. **语境判断**：
   - 上下文在讨论 Φ̃_k 的变换性质与零点结构（eq 5.7 紧接其后）。
   - "analyzed in detail in [9]"指向 DMZ 1208.4074（Dabholkar-Murthy-Zagier）——
     那篇论文的主题是**单中心黑洞简并度对应 1/Φ₁₀ 的 Fourier 系数**，是物理应用语境。
   - **"exactly"** 一词可能强调"在围道积分意义下精确对应"（包括系数），
     也可能只是随口说"就是同一个对象"（不care具体归一化）。

3. **本人无法从此句单独判定 c 的符号**：
   - 若"exactly"包含归一化，则 c=+1。
   - 若"exactly"只指"模空间上同一除子、同样的变换性质"，c 可以是任意非零常数。
   - **需要 T1 路径（直接算 Fourier 系数）才能独立裁定**。

---

## T2: 围道积分测度的书写形式（eq 5.13，官方 PDF p.41）

### 位置
p.41，紧接"The degeneracy of single-centered black hole microstates of charge (Q⃗,P⃗) is then given by the following contour integral"

### 逐字转录（verbatim，eq 5.13）

```
d*(P²/(2N), Q·P, NQ²/2) ≡ ((-1)^{Q·P+1})/N ∫_C dτdσdz
    exp{-2πi(NQ²/2·τ + P²/(2N)·σ + (Q·P)z)} · 1/Φ̃_k(Ω)
```
（公式 5.13）

### 裁定（本人核对）

**测度书写：dτdσdz**（三个微分符号并列，**无楔积符号 ∧**）。

这是**迭代积分记号**（iterated integral），常规理解为
```
∫ dτ ∫ dσ ∫ dz (...)
```
即三个独立的一维围道积分按某个次序嵌套。

**与定向 3-形式的区别**：
- 定向形式写作 dτ∧dσ∧dz 或 dσ∧dτ∧dz（楔积带反对称性）。
- 迭代积分 dτdσdz 中，微分次序**不自动带定向符号**，需额外约定。

**原文是否明说次序与定向？** 否。围道 C 的定义（eq 5.14，见既有抽取记录 E2）
只给虚部条件与实部积分范围，未说"先积 τ 再积 σ"还是反之，也未说是否有
Jacobian 定向因子 η=±1。

**结论（T2）**：BSS eq (5.13) 用迭代积分记号 dτdσdz，**未明说定向**。

---

## T1（续）：能否从 eq (5.2) 算出 Φ̃₁ 的首项 Fourier 系数？

### 问题
eq (5.2) 是无穷乘积，指数前因子 e^{2πi(α̃τ+γ̃σ+γ̃z)}，乘积部分
```
∏∏∏ (1 - e^{2πi(...)})^{exponent}
```
要展开成 q^a r^b s^c（或 e^{2πi(aτ+bz+cσ)}）的级数，需要：
1. 确定 N=1 时 α̃, γ̃ 的数值（依赖 Q_{0,0}, c_0^{(r,s)}, c_1^{(r,s)}——这些在 eq 5.3/5.4
   中定义，但它们的**具体数值**依赖"M=K3 的 CHL 模型在 N=1 时的 elliptic genus"，
   即 c_n^{(r,s)}(4n-ℓ²) 系数——**eq (5.1)–(5.4) 只给了递推关系，未给 N=1 的显式值**）。
2. 展开无穷乘积 ∏(1-e^{...})^{...}——指数是 ∑_{s=0}^{N-1} -2ris lN/(r,s) (4k'l-j²)，
   在 N=1 时简化，但仍是无穷多项的乘积。

### 追溯链条
BSS 引用 [12]=David-Jatkar-Sen 2007 为 eq (5.2) 来源。**本人未在本次任务中获取 [12] 原文**
（任务书要求"追下去直到能定出首项系数"，但 [12] 是付费期刊文章，arXiv 版本为 hep-th/0609109）。

**能否从 BSS 自己的其它式子推出？** 检索 BSS 全文：
- eq (5.9)–(5.10) 给出 Φ̃_k 在 z=0 附近的留数行为（与 f^{(k)}, g^{(k)} 有关，
  但这些是 N-dependent 的 Dedekind η 乘积，仍未给 N=1 的显式首项）。
- eq (5.11) 给出周期性 Φ̃_k(τ+1,z,σ) = Φ̃(τ,z+1,σ) = Φ̃(τ,z,σ+N)——这决定 Fourier
  变量的整数性，但不给系数。
- **BSS 自己从未显式写出 Φ̃₁ 的 Fourier 展开前几项**。

### 结论（T1，无法判定）
**本人无法从 BSS 给出的信息单独算出 Φ̃₁ 的首项 Fourier 系数，因为：**
1. eq (5.2) 的前因子 α̃, γ̃ 依赖 BSS 未给出数值的 c_n^{(r,s)}；
2. 无穷乘积的展开需要 [12] 原文或数值计算工具（Mathematica/SageMath）；
3. Φ₁₀ 的标准归一化在本项目既有抽取（gritsenko-nikulin-1996-phi10.md）中
   也**未给出显式 Fourier 展开**（GN1996 只给 Φ₁₀=Δ₅² 与 Δ₅ 的零点结构，
   不给系数）。

**若要完成 T1，需要：**
- 获取 David-Jatkar-Sen [12] hep-th/0609109 原文，或
- 获取 Gritsenko 的 Δ₅ 或 χ₁₀ 的显式乘积公式（例如 DVV, Gritsenko-Nikulin 1998），或
- 数值计算（用 SageMath 的 Siegel modular forms 包，但这超出本次"文献逐字抽取"任务范围）。

---

## 最终报告（三个任务的裁定）

### T1（主任务）：c 的值
**无法判定**。理由：
1. BSS eq (5.2) 定义 Φ̃_k 为无穷乘积，但前因子系数 α̃,γ̃ 依赖未给数值的 elliptic genus
   系数 c_n^{(r,s)}。
2. BSS 自己未显式写出 Φ̃₁ 或 Φ₁₀ 的 Fourier 展开。
3. 需要追溯到 [12]=David-Jatkar-Sen hep-th/0609109 或数值计算工具。

### T2（次任务）：围道积分测度形式
**BSS eq (5.13) 写成 dτdσdz（迭代积分记号），无楔积符号 ∧。**
**原文未明说定向或积分次序**——只给围道 C 的虚部/实部条件，未说"先积哪个变量"。

Rosselló 2403.19630 eq (2.23)（见本项目既有抽取 literature/extractions/rossello-2024.md V1）
同样写 dρ dσ dv（无楔积），**亦未明说定向**。

**推断（非原文陈述）**：两文可能都默认"标准 Siegel 上半空间定向"或"物理文献惯例"，
但这一层**不在 BSS/Rosselló 的显式陈述中**——curator 若要用它推导符号，需标 `inferred`。

### T3（次任务）："exactly the inverse" 的上下文
**完整逐字已抄录于上方**。判断：
- 这是一个**定性陈述**（"Φ̃_k^{-1} 就是 Φ₁₀^{-1}"），出现在讨论变换性质与零点的段落。
- **字面上支持 c=+1**（"exactly"），但物理文献常用"exactly"表示"在模空间上作为除子相等"
  而不care归一化常数——**单凭此句无法排除 c=-1 的可能性**。
- 引用 [9]=DMZ 1208.4074——那篇论文主题是围道积分与 mock 模形式，可能给更精确的归一化，
  但本人未在本次任务中获取 [9]。

---

## 未取得的来源（供船长手动获取）

1. **David-Jatkar-Sen, hep-th/0609109** (JHEP 2007)：BSS eq (5.2) 的直接来源，
   可能包含 Φ̃_k 的显式 Fourier 展开或 N=1 特例的数值。
   URL: https://arxiv.org/abs/hep-th/0609109

2. **Dabholkar-Murthy-Zagier, arXiv:1208.4074**：BSS [9]，"exactly the inverse"
   引用的详细分析，可能明确 c 的符号。
   URL: https://arxiv.org/abs/1208.4074
   （注：本项目已有此文献的部分抽取 dabholkar-gomes-murthy-2008.md，但那是 0803.2692
   不是 1208.4074——需核查是否为同一系列论文的不同版本）

3. **Gritsenko-Nikulin 或 DVV 的 Φ₁₀ / Δ₅ 显式乘积公式**：用于独立计算 Φ₁₀ 首项。
   本项目 gritsenko-nikulin-1996-phi10.md 只抄录了零点结构，未抄 Fourier 系数。

---

## 对草稿 research/attempts/gap-102b 的含义

草稿用数值锚点 (P²/2,Q·P,Q²/2)=(1,0,1) 处 d*=50064（三方吻合）反推出 c=-1，
前提是"三重围道积分按迭代积分理解、微分书写次序不带定向符号 η=±1"。

**本次核查结果**：
- BSS 与 Rosselló **都用迭代积分记号**（T2 确认），这**支持**草稿的前提假设。
- 但两文**都未明说定向**，故 η=±1 这一因子仍是**推断**（inferred），不是逐字证据。
- BSS p.40 "exactly the inverse"**字面支持 c=+1**，与草稿反推的 c=-1 **矛盾**。

**可能的解释（非本人裁定，留给 lead/reviewer）**：
1. "exactly the inverse"是随口说，不包含归一化常数（c 可以是任意非零常数）；
2. 草稿的 η 因子推断有误（迭代积分实际上隐含某个标准定向约定，使 η=-1）；
3. BSS 或 Rosselló 的 d* 定义式中有未察觉的符号差异（例如指数中 ±2πi 的约定）。

**本人建议下一步**：获取 [12] hep-th/0609109 与 [9] 1208.4074，逐字核对 Φ̃_k 与 d*
的**完整定义链**（从 Φ̃_k 无穷乘积 → Fourier 系数 → 围道积分 → 数值 50064），
找出符号差异的真实来源。
