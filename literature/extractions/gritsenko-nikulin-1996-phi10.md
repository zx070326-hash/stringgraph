# 抽取记录：gritsenko-nikulin-1996-phi10

- 文献：V.A. Gritsenko, V.V. Nikulin, "The Igusa Modular Forms and 'the Simplest' Lorentzian Kac–Moody Algebras", arXiv:alg-geom/9603010v1 (13 Mar 1996). （= GN1998 中引用的 [GN4]，实际发表版本经修订后见 Mat. Sbornik 187 (1996) no.11。）
- 抽取者：researcher agent（gap-102b-lead 任务，协助 humbert geometry 检索）
- 日期：2026-09-16
- 覆盖范围：全文 39 页（§0 Introduction; §1 Hecke operator construction; §2 Orthogonal interpretation & K3 moduli; §3 Automorphic correction of Lorentzian KM algebras; §4 Perspective; Appendix A, B）
- 来源：arXiv PDF (alg-geom/9603010.pdf) 通过 WebFetch 下载后用 Read 工具逐页读取（图像 OCR，全文可读）

---

## 关键澄清：本文并非直接研究 Φ₁₀，而是 Δ₅（weight 5）

- 位置：§1，p.7（verbatim）："It is known that χ₁₀(Z) is the square of the form Δ₅(Z) of weight 5 which is a Sp₄(ℤ)-modular form of weight 5 with non-trivial character (see [Fr]). It means that (Δ₅|₅M)(Z) = v(M)Δ₅(Z) for any M ∈ Sp₄(ℤ), where v: Sp₄(ℤ) → {±1} is a quadratic character."
- **推论（原文直接给出，非 inferred）**：χ₁₀ = Δ₅²，即物理文献中的 Φ₁₀（= χ₁₀）就是本文 Δ₅ 的平方。
- 备注：本文正文几乎全部围绕 Δ₅（weight 5，带非平凡特征 v）及其 Hecke 像 χ₃₅（Igusa modular form，weight 35，[GN4] 标题主角）、χ₃₀ = χ₃₅/Δ₅展开。Φ₁₀ 本身（weight 10，trivial character）作为 Δ₅² 只在环生成元列表中提及一次（p.7，𝔐*(Sp₄(ℤ)) = ℂ[E₄,E₆,χ₁₀,χ₁₂,χ₃₅]），文中没有把 χ₁₀ 单独作为构造对象展开成无穷乘积或讨论它的零点。**所有下面关于 Humbert 零点几何的陈述，原文是针对 Δ₅（及其 Hecke 像），不是直接针对 χ₁₀=Φ₁₀。** 从 χ₁₀=Δ₅² 立即得到：Div(χ₁₀) = 2·Div(Δ₅) = 2H₁（作为除子，重数翻倍），但这是从本文两条陈述（χ₁₀=Δ₅² 与 Div(Δ₅)=H₁）组合出的**推断**，本文没有显式写出 "Div(χ₁₀)=2H₁" 这句话——留给 curator 标 inferred。

---

## H1 有理二次除子与 Humbert 曲面的定义（一般框架）

- 位置：§1，p.8（Theorem 1.2 证明段落中间，verbatim）：

  "A rational quadratic divisor of ℍ₂ is, by definition, the set
  ℋ_ℓ = {(z1 z2; z2 z3) ∈ ℍ₂ | (z2²-z1z3)d + cz3 + bz2 + az1 + e = 0},
  where ℓ=(e,a,b,c,d) ∈ ℤ⁵ is a primitive (i.e. with the greatest common divisor equals 1) integral vector. The number D(ℓ) = b²-4de-4ac is called the *discriminant* of ℋ_ℓ. This divisor determines the *Humbert surface* H_D in the Siegel threefold A₁ = Sp₄(ℤ)\ℍ₂ (the moduli space of abelian surfaces with principal polarization)

  H_D = π( ⋃_{v∈ℤ⁵ primitive, D(v)=D} ℋ_v ) = π(ℋ_ℓ)

  where π is the natural projection π: ℍ₂ → A₁."

- 文献列出的性质（同页，verbatim）："ℋ_ℓ is not empty ⇔ D(l)>0, ∀γ∈Sp₄(ℤ) the set γ(ℋ_ℓ) is a rational quadratic divisor with the same discriminant D(ℓ), H_D is irreducible, H_D can be represented by an equation az₁+bz₂+z₃=0 with b=0 or b=1."
- 类型：definition + proposition（性质列表，"well-known and almost evident"，引用 [vdG1], [GH]）
- 文献自称严格程度：定义性，性质引用 van der Geer / Gritsenko-Hulek 为来源，未在本文重证。

---

## H2 Δ₅ 的零点除子 = Humbert 曲面 H₁（判别式 1）

- 位置：§1，p.8 末（Theorem 1.2 证明前，verbatim）："The next fact is of the great importance for different subjects: the divisor of Δ₅(Z) on Sp₄(ℤ)\ℍ₂ is equal to the Humbert surface H₁ = π({Z ∈ ℍ₂ | z₂=0}) of discriminant 1 [接 p.4：discriminant 1, gives moduli of products of two elliptic curves, and its complement in Sp₄(ℤ)\ℍ₂ gives moduli of curves of genus 2]."
- 类型：proposition（本文断言为已知事实，'well-known'）
- 文献自称严格程度：陈述为既有结果，无独立证明，视为经典（Freitag [Fr] 等）。
- **判别式条件**：H₁ 对应 (n,l,m) 坐标下 z₂=0 的直接几何描述；在乘积展开语言中对应 l²-4nm = -1 的项（见下方 H5 一般规律）。

---

## H3 Igusa 形式 χ₃₅ 的零点除子 = H₁ + H₄（判别式 1 与 4 之和，重数各一）

- 位置：§0 Introduction，p.4（verbatim）："The divisor of the Igusa modular form χ₃₅(Z) is the sum with multiplicities one of the Humbert surface H₁ above and the Humbert surface H₄ of discriminant 4."
- 亦见 §1 Corollary 1.4 证明，p.10（verbatim）："Let F(Z) be a Siegel modular form of odd weight. Then F(z₁,0,z₃)≡0 since there do not exist SL₂(ℤ)-modular forms of odd weight. F(Z) is 0 on the Humbert surface H₄ = π({Z=(z z2; z2 z)∈ℍ₂}), since F(z₁,z₂,z₃) = -F(z₃,z₂,z₁). The divisor of the form [Δ₅(Z)]₂/Δ₅(Z)⁸ equals H₁+H₄."
- 类型：proposition，本文首次证明（Theorem 1.2 及其推论链）。
- 文献自称严格程度：本文正文证明（非引用外部）。证明思路：χ₃₅ = χ₇₅/Δ₅⁸（公式 0.3-0.4），比较除子并用 Koecher principle。

---

## H4 χ₃₀ = χ₃₅/Δ₅ 的零点除子 = H₄（单独）

- 位置：§1，Corollary 1.4 第2条，p.9-10；也见 §0，p.4："χ₃₀(Z) = χ₃₅(Z)/Δ₅(Z) ... is a Siegel modular form of weight 30 with the non-trivial character v: Sp₄(ℤ)→{±1}. The divisor of this function is H₄."
- 类型：proposition，本文证明。
- 备注：因为 χ₃₅ 的除子是 H₁+H₄，Δ₅ 的除子是 H₁，商的除子自然是 H₄（除子代数减法），这与 H2/H3 完全一致（本文自身逻辑闭合，不需要 inferred）。

---

## H5 一般规律：无穷乘积中"哪些 (n,l,m) 因子贡献零点"（Appendix B, Theorem B.1 证明中显式陈述——**这是本任务最相关的一条**）

- 位置：Appendix B，Theorem B.1 证明，p.37（verbatim，编号 iv)）：

  "iv) Only the factors with negative square l² - 4nm < 0 of the infinite product have zeros on ℍ₂. There factors exist only with square l² - 4nm = -5, and they define the Humbert surface H₅."

- 上下文：F⁽⁵⁾(Z) 是本文构造的 weight 24 Siegel 形式，无穷乘积形式
  F⁽⁵⁾(Z) = r⁻¹(qr-s)(q-rs) ∏_{(n,l,m)>0} (1-q^n r^l s^m)^{g(nm,l)}，
  其零点除子被证明 = Humbert 曲面 H₅（判别式 5）。
- **一般化陈述（原文明确说明这是普遍构造，非特例）**：p.37 末段（verbatim）："We remark that the construction given above is general. It gives us a modular form with the irreducible divisor H_D for any D."
- 类型：proposition，本文直接证明（"One can easily proof this theorem using the method we used in [GN1, Theorem 4.1]"）。
- **核心几何规律**（本文明确陈述，非 curator 推断）：对乘积展开 ∏(1-q^n r^l s^m)^{f(...)} 型 Siegel 模形式，**零点只来自判别式为负（l²-4nm<0）的因子**；具体哪个负判别式值 -D 出现，决定该形式的零点除子恰为 Humbert 曲面 H_D。这是本文反复使用的一般机制（也见 §1 Theorem 1.2 对 Δ₅ 的 Hecke 像 [Δ₅]_p 的除子计算，那里用有理二次除子理论直接算，而非"哪些因子"语言；Appendix B 的 iv) 是唯一处用"哪些乘积因子对应零点"这种语言明确陈述该机制的地方）。

- 与 H2 交叉验证：Δ₅(Z) = (qrs)^{1/2} ∏_{(n,l,m)∈ℤ,(n,l,m)>0} (1-q^n r^l s^m)^{f(4nm-l²)} （公式 1.10）。若同一机制适用，Δ₅ 的零点（H₁，discriminant 1）应对应判别式 l²-4nm=-1 的因子（即 4nm-l²=1，f(1)=1，见 (1.9) 附近 f(0)=10,f(-1)=1 的表——**本文没有显式把 "f(1)≠0 ⟺ 零点在 H₁ 上" 这句话写出来**，这是从 H5 的一般模式类推，属于 inferred，留给 curator。）

---

## H6 GN1998 中提到的另一处：Δ₅ 作为 M₁,II 上所有二次除子之和（更细的几何刻画）

- 位置：§2，p.16（verbatim）："The function Δ₅(Z) is an automorphic form on Ω⁺(L₁,II) with the divisor which is equal to the sum with multiplicities one of all quadratic divisors ℋ_δ, δ ∈ Δ⁽²⁾(L₁,II) (see [GN1] where this interpretation of Δ₅(Z) is given)."
- 类型：proposition，引用 [GN1]（更早论文，本项目未获取）为来源。
- 备注：这是正交群语言下的等价表述——Δ₅ 的零点是格 L₁,II 中所有范数为 2 的向量 δ 对应的二次超平面 ℋ_δ 的并集（"所有判别式为特定值的超平面之和"），对应 Siegel 语言下的单个 Humbert 曲面 H₁（因为 Sp₄(ℤ)/{±E₄} ≅ O⁺(L₁)/{±E₅} 的同构下，轨道对应关系）。

---

## H7 K3 曲面模空间中的几何解释（Theorem 2.1，直接相关于零点判别式条件的物理意义）

- 位置：§2，Theorem 2.1，p.18（verbatim）："Igusa modular form χ₃₅ = cΔ(L₁,₀)₃₅, c∈ℂ*, gives the discriminant of K3 surfaces moduli with condition S = U⊕E₈(-1)⊕E₇(-1) ⊂ L_K3 on Picard lattice where E₈ and E₇ are the standard positive definite lattices which are defined by the root systems of the same type."
- 证明中（verbatim）："It follows that T = (S)⊥_{LK3} ≅ 2U⊕⟨-2⟩ = L₁,₀(-1). The discriminant D(S⊂L_K3) of K3 surfaces with condition S⊂L_K3 on Picard lattice is equal to union of all quadratic divisors ℋ_δ, δ∈Δ⁽⁻²⁾(T) = Δ⁽²⁾(L₁,₀). Thus, Igusa modular form χ₃₅ is equal to zero exactly on this discriminant."
- 类型：proposition，本文证明。
- 备注：这给出"零点 = 判别式轨迹"这一说法的**代数几何含义**：模形式的零点恰好是"K3 曲面的 Picard 格包含更大子格"这一退化条件的轨迹（Humbert 曲面 = 某种退化/特殊化的模空间边界）。

---

## 关于 "Im ρ ≥ Im σ 避开零点" 的检索结果：**原文未找到此陈述**

**判定：无定论（原文未涉及，本文不使用 (σ,v) 或 Im ρ/Im σ 记号讨论零点回避）**

具体情况：

1. 本文变量约定是 Z=(z₁ z₂; z₂ z₃) ∈ ℍ₂（Siegel 上半空间），或用 (n,l,m) 根格坐标配合 q=e^{2πiz₁}, r=e^{2πiz₂}, s=e^{2πiz₃}。这与 GN1998 的 Z=[[τ,z],[z,σ]] 记号一致（z₁↔τ, z₂↔z, z₃↔σ）。**本文没有使用 ρ 表示 Siegel 变量**（本文的 ρ 只用于 Weyl 向量 ρ₀,ρ_I,ρ_II，是格论对象，不是 Siegel 上半空间坐标）。

2. 全文搜索未见任何形如 "Im ρ ≥ Im σ" 或"当虚部满足某不等式时避开 Humbert 曲面"的几何论证。本文关于无穷乘积收敛性的唯一相关陈述是：p.37 "i) The given infinite product absolutely converges for all Im(Z)>C for a large C>0"——即乘积在虚部充分大时收敛（这保证乘积展开有意义，与零点回避是不同的问题：乘积表示本身在收敛域内非零，收敛域外需解析延拓）。这与"Im ρ ≥ Im σ" 型条件（哪个变量的虚部大于哪个）没有对应。

3. **可能的物理来源**：物理文献（Sen 2007 及后续 N=4 dyon 简并度论文）中常把 Φ₁₀ 的自变量记为 (ρ,σ,v)（不是本文的 τ,z,σ 或 z₁,z₂,z₃），且用 Im ρ, Im σ 排序来描述"attractor 区域"与"黑洞晕（halo）分解"的收敛域边界。这类条件属于**物理文献自己的论证**（如 Sen 的 wall-crossing / decomposition into single+multi-centered black holes 的收敛域讨论），**不在 GN1996/GN1998 这两篇代数几何论文中**。若 gap-102b-lead 需要这条，应检索 Sen (hep-th/0708.1270 或后续 review) 或 Cheng-Verlinde 等物理文献，而非 Gritsenko-Nikulin。

---

## 未解决的疑问 / 待核实

1. **χ₁₀ 本身的显式无穷乘积**：本文只给出 χ₁₀=Δ₅²，没有把 χ₁₀ 单独写成 (qrs)^1 前因子 × 乘积的形式。若 Route A 需要 χ₁₀ 自己的乘积公式（而非通过平方 Δ₅ 得到），需要对 Δ₅ 公式 (1.10) 平方展开，这是简单的代数运算但本文没有显式写出。

2. **"Im ρ ≥ Im σ 避开零点"完全未在本文出现**——如上节，需要查物理文献（建议：Sen 2008 review "Black Hole Entropy Function, Attractors and Precision Counting of Microstates", arXiv:0708.1270，或 Shih-Strominger-Yin hep-th/0505094，那里讨论 Φ₁₀ 零点与黑洞晕分解的收敛域）。

3. **f(4nm-l²) 的判别式对应表**：本文公式 (1.9) 定义 f(N)（N=4n-l² 对单变量 Jacobi 形式 φ₀,₁），但 Δ₅ 的三变量乘积用的是 f(4nm-l²)（注意是 nm 乘积，不是单个 n）——这与 GN1998 抽取记录 E5 中 f₁(nm,l) 记号一致。f(0)=10, f(-1)=1 列在 (1.9) 后，但 f(1)（对应 discriminant -1，即 H₁ 判别式）的值本文未直接列出数值，只能从 Cohen 数公式或 φ₀,₁ 的展开 (1.8) 反推：φ₀,₁ = (r⁻¹+10+r)+q(10r⁻²-64r⁻¹+108-64r+10r²)+...，对应 f(0,±1)=10（n=0,l=±1，N=4·0-1=-1），与 "f(-1)=1" 矛盾——**需要仔细核对 (1.8)/(1.9) 的 N 定义是否为 N=4n-l² 还是 l²-4n，此处本文用词有潜在正负号混淆，标记为潜在印刷/符号陷阱，留给 curator 或后续核对者注意**。

---

# 【2026-09-20 追加，researcher，task：Φ₁₀ 在 v=0 附近领头行为路线的目标 2「收敛域」】

- 本轮原文获取方式与上文不同：**arXiv 官方 PDF**（`https://arxiv.org/pdf/alg-geom/9603010`，curl HTTP 200），
  **PyMuPDF** 取文本 + p.11 / p.12 200 dpi 渲染成图逐字目视核对。**未用 pdftotext。**
- 上文（2026-09-16 那轮）自述用的是 "WebFetch 下载后用 Read 工具逐页读取（图像 OCR）"。
  本轮对 p.5 / p.11 / p.12 / p.36 / p.37 做了 PDF 原生文本复核，结论见下（含对上文一处误读的更正，见 H10）。

## H8 【★★ 目标 2：Siegel 坐标下的绝对收敛逐字来源】

### H8a 本文对 ℍ₂ 的定义——确立 ">" 是矩阵序

- 位置：§1 开头，PDF p.5（逐字）：

  "A Siegel modular form of weight k with respect to Sp₄(ℤ) is, by definition, a holomorphic
  function F(Z) on the Siegel upper half-plane

  ```
  H₂ = { Z = ( z₁  z₂ ; z₂  z₃ ) ∈ M₂(C) | Im (Z) > 0 },
  ```
  "

- 类型：definition
- **为什么记这一条**：本文**唯一一处**给 `Im(Z)` 配 ">" 号的地方，含义是
  **矩阵 Im(Z) 正定**（Siegel 上半空间的标准定义）。这为 H8c 里 `Im(Z) > C` 的读法定锚。
  ⚠ 本文**从未显式定义** `Im(Z) > C`（C 是标量）这一记号。

### H8b Δ₅ 的无穷乘积 (1.10) 与 (n,l,m)>0 的显式含义

- 位置：§1，PDF p.11 末 – p.12 初
- 类型：proposition（本文自称引自 [GN1, Theorem 4.1]）
- 原文陈述（逐字）：

  p.11："In [GN1, Theorem 4.1] we proved that the modular form ∆₅(Z) is the denominator
  function of a generalized Lorentzian Kac–Moody superalgebra and the product formula

  ```
                    1/2     ___
  ∆₅(Z) = (q r s)          |   |  ( 1 − qⁿ rˡ sᵐ )^{f(4nm−l²)}                    (1.10)
                            n, l, m ∈ Z
                            (n,l,m) > 0
  ```
  "

  p.12（紧接 (1.10)）："is valid where q = exp(2πiz₁), r = exp(2πiz₂), s = exp(2πiz₃).
  The condition (n, l, m) > 0 in the product means that n ≥ 0, m ≥ 0, l is an arbitrary
  integer if n + m > 0, and l < 0 if n = m = 0."

- **坐标对照（本项目路线的记号 ↔ 本文记号）**：`ρ = z₁`, `v = z₂`, `σ = z₃`；
  `q = e^{2πiρ}`, `r = e^{2πiv}`, `s = e^{2πiσ}`。**与 Kawai 1997 eq.(2.19) 的 p ↔ s 对调**，
  但 (1.10) 的指数 `f(4nm−l²)` 与 Kawai eq.(5.13) 的 `c(4kl−r²)` 结构相同（`c = 2f`）。

### H8c 【★★ 承重逐字】绝对收敛的陈述

- 位置：§1，PDF p.12，**紧跟在 (n,l,m)>0 的解释之后、∆₃₅ 的定义之前**，以括注形式出现
- 类型：remark（本文用 "We remark that"，**无证明、无引用**）
- 原文陈述（逐字，200 dpi 渲染图目视核对）：

  "(We remark that the infinite product **absolutely converges** for all Im(Z) > C for a
  large C > 0.)"

- **逐字要点**：
  1. 用的是 "**absolutely converges**"——**比 borcherds-1995 Theorem 5.1 的 "converges" 更强**
     （见 `extractions/borcherds-1995.md` B2）。这正是路线所需的"可重排为三块"的那种收敛。
  2. 这句话**直接挂在 (1.10) 上**，即挂在 **Δ₅ 的乘积**上，而本文 p.7 逐字断言
     "χ₁₀(Z) is the square of the form ∆₅(Z) of weight 5"（见本文件开头「关键澄清」）。
  3. **量词形式是「Im(Z) > C for a large C > 0」，不是 Weyl chamber 形式，没有任何 chamber 条件。**
  4. 本文**未给出 C 的任何显式界，也未给证明**。

- 同页另一处相容表述（逐字，PDF p.12）：Corollary 1.6 的开头
  "The following identity is valid for **Z with a large imaginary part**"。

### H8d 附录 B 的平行陈述（不同对象，仅作旁证）

- 位置：Appendix B，Theorem B.1 i)，PDF p.37（逐字）：
  "i) The given infinite product absolutely converges for all Im(Z) > C for a large C > 0
  and can be continued to a multi-valued analytic function on H₂."
- ⚠ **对象是 F⁽⁵⁾(Z)（weight 24，除子 H₅），不是 Δ₅/χ₁₀**。措辞与 H8c 逐字相同，
  说明这是作者的固定表述模板。本文件上文（2026-09-16 那轮）第 105 行引的就是这一条，
  **但那是附录里的另一个函数**；H8c 才是挂在 Δ₅ 上的那一条。
- 同页证明开头逐字（PDF p.36）："One can easily proof this theorem using the method we used
  in [GN1, Theorem 4.1] (see also **[B5, Theorem 5.1]**)."
  ⇒ 本文引 Borcherds 1995 用的标签是 **[B5]**，与本文文献表一致
  （对比 GN1998 正文用 "[Bo6]"，与其文献表 [B1]–[B6] 不自洽，见 `extractions/borcherds-1995.md` 疑点 2）。

## H9 【我的推断，非原文】H8c 是否蕴含任务的验收标准

**任务验收标准（lead 给定）**：存在 `C > 0` 与 `δ > 0`，使乘积在
`{ Ω = [[ρ,v],[v,σ]] ∈ ℍ₂ : Im ρ > C, Im σ > C, |Im v| < δ }` 上绝对收敛，
且该区域是 ℍ₂ 的开子集、对每个固定的 (ρ,σ) 含 `v` 的一个邻域（特别地含 `v=0`）。

**以下每一步都是我的推导，GN1996 没有写。**

**第 0 步（记号读法）**：把 H8c 的 `Im(Z) > C` 按 H8a 确立的矩阵序读作
`Im(Z) − C·E₂ > 0`（正定），其中 `E₂` 是 2×2 单位阵。
理由：(a) 本文 p.5 定义 ℍ₂ 时 `Im(Z) > 0` 就是矩阵正定；(b) 逐元素读法在此处无意义——
`Im z₂` 在 ℍ₂ 上可正可负，要求 `Im z₂ > C > 0` 会把收敛域缩成一个不对称的怪集合，
而本文同页 Corollary 1.6 只说 "a large imaginary part"。
⚠ **这仍是推断：本文从未定义 `Im(Z) > C`。**

**第 1 步（展开矩阵不等式）**：设 `Y = Im Z = [[y₁, y₂],[y₂, y₃]]`（`y₁=Im ρ, y₂=Im v, y₃=Im σ`）。
`Y − C·E₂ > 0` ⟺ `y₁ − C > 0` 且 `(y₁−C)(y₃−C) − y₂² > 0`。

**第 2 步（造出验收标准的方盒）**：取 `C' := 2C`、`δ := C`。若 `y₁ > C'`, `y₃ > C'`, `|y₂| < δ`，则
`y₁ − C > C > 0`，`y₃ − C > C > 0`，故 `(y₁−C)(y₃−C) > C² > y₂²`。
⇒ `{y₁ > 2C, y₃ > 2C, |y₂| < C} ⊆ {Im(Z) > C·E₂}`，乘积在其上绝对收敛。

**第 3 步（开性与 v-邻域）**：该集合由**严格不等式**定义、且 `Im` 与乘法连续，故是 ℂ³ 的开集，
与 ℍ₂ 交后是 ℍ₂ 的开子集（第 2 步已保证含于 ℍ₂：`Y > C·E₂ > 0`）。
对固定的 (ρ, σ)，条件只限制 `|Im v| < δ`、**不限制 `Re v`**，故 v 的允许集是带形
`{v ∈ ℂ : |Im v| < δ}`，它是 ℂ 的开集且含 `v = 0`。✔

**结论（我的推断）：H8c 蕴含任务的验收标准，取 `C_验收 = 2C`、`δ = C`。**

**第 4 步（从 Δ₅ 到 Φ₁₀ = χ₁₀ = Δ₅²）**：绝对收敛的无穷乘积平方后仍绝对收敛
（指数逐项翻倍：`∏(1−u_i)^{2a_i} = (∏(1−u_i)^{a_i})²`，Σ|2a_i u_i| = 2Σ|a_i u_i| < ∞）。
故 Φ₁₀ 的乘积在同一区域绝对收敛。**这一步 GN1996 也没写**（它从不把 χ₁₀ 单独展成乘积，
见本文件开头「关键澄清」与「未解决的疑问 1」）。

**旁证（我的验算，解释为什么这个域不需要 Weyl chamber 条件）**：(1.10) 的第 (n,l,m) 个因子的模是
`|qⁿrˡsᵐ| = exp(−2π(n y₁ + l y₂ + m y₃))`。指数 `f(4nm−l²)` 非零要求 `4nm − l² ≥ −1`，
即 `|l| ≤ √(4nm+1)`——**对每个 (n,m) 只有有限个 l**。于是
`n y₁ + l y₂ + m y₃ ≥ n y₁ + m y₃ − √(4nm+1)·|y₂|`，而 `Y > C·E₂` 给出
`n y₁ + m y₃ ≥ 2√(nm y₁ y₃) > 2√(nm)·|y₂|`（由 `y₁y₃ > y₂²`）并留有正裕量。
这正是 `det Y > 0` 的作用，与 `y₂` 的**符号无关**——所以作者能给出一个关于 `Im v ↔ −Im v` 对称、
不带 chamber 条件的域。**这段是我的验算，不是原文论证。**

## H10 对本文件上文「未解决的疑问 3」的更正

上文第 117 行称：由 (1.8) 读出 "f(0,±1)=10"，与 (1.9) 后的 "f(−1)=1" 矛盾。
**本轮官方 PDF 复核表明：这是上一轮的误读，(1.8) 与 (1.9) 之间没有矛盾。**

- (1.8) 逐字（PDF p.11）：
  `φ₀,₁(z₁,z₂) = φ₁₂,₁(z₁,z₂)/∆₁₂(z₁) = Σ_{n≥0, l∈Z} f(n,l) exp(2πi(n z₁ + l z₂))`
  `= (r⁻¹ + 10 + r) + q(10r⁻² − 64r⁻¹ + 108 − 64r + 10r²) + …`
- 读法：`(r⁻¹ + 10 + r)` 里 `r⁻¹` 与 `r` 的**系数是 1**（不是 10），常数项系数才是 10。
  故 `f(0,0) = 10`、`f(0,±1) = 1`。
- 代入 `N = 4n − l²`：`f(0) = f(0,0) = 10` ✔，`f(−1) = f(0,±1) = 1` ✔。
  与 (1.9) 后逐字的 "In particular, we have f(0) = 10, f(−1) = 1 and f(n) = 0 if n < −1" **完全一致**。
- 连带：本文的 `f` 与 Kawai 1997 的 `c` 之间是 `c = 2f`（`c(0)=20=2·10`，`c(−1)=2=2·1`，
  见 `extractions/kawai-1997-k3-genus-z0.md` E4）——因为 K3 椭圆亏格 `Z = 2φ̃_{0,1}`（Kawai eq.(4.6)），
  而本文的 `φ₀,₁` 就是 Kawai 的 `φ̃_{0,1}`（两者都 `= φ₁₂,₁/η²⁴`）。
  ⇒ Φ₁₀ = Δ₅² 的指数是 `2f = c`，与 Kawai eq.(5.13) 的 `c(4kl−r²)` **自洽**。（这段是我的对照，非原文。）

## 本轮新发现的原文疑点

1. **GN1996 PDF p.11 的印刷错误**：φ₁₂,₁ 的 q² 系数逐字印作
   `(10r−2 − 88r−1 − 132 − 88r + 10r−2)q²`，**最后一项的指数应为 +2**（即 `10r²`）。
   我的验算：`φ₁₂,₁ = φ₀,₁·∆₁₂`，`∆₁₂ = q(1 − 24q + …)`，故 q² 项
   `= (10r⁻² − 64r⁻¹ + 108 − 64r + 10r²) − 24(r⁻¹ + 10 + r)`
   `= 10r⁻² − 88r⁻¹ − 132 − 88r + 10r²`——数值系数（−88, −132）全部对上，只有末项指数排错。
   **这是纯排印错误，不影响任何结论。**（同页 (1.8) 里 φ₀,₁ 的对应项印的是 `10r2`，是对的。）
2. `Im(Z) > C` 这个记号**全文未定义**（见 H9 第 0 步）。
3. 本文件上文第 105 行把 Appendix B Theorem B.1 i) 当成"本文关于收敛性的唯一相关陈述"——
   **不准确**：p.12 还有一条（H8c），而且那一条才是挂在 Δ₅ 上的。上文那次检索漏了 p.12。

## 本轮：我亲自逐字核过的 / 我转述或推断的

**亲自逐字核过（arXiv 官方 PDF + PyMuPDF；p.11、p.12 另经 200 dpi 渲染图目视）**：
- PDF p.5：ℍ₂ 的定义（含 `Im (Z) > 0`）、Siegel 模形式的函数方程 (1.1)
- PDF p.7：`χ₁₀(Z) is the square of the form ∆₅(Z) of weight 5`、环生成元列表
- PDF p.11：φ₁₂,₁ 的展开、(1.8)、(1.9)、`f(0)=10, f(−1)=1, f(n)=0 if n<−1`、(1.10)
- PDF p.12：(n,l,m)>0 的解释、**绝对收敛括注（H8c）**、∆₃₅ 的定义、Theorem 1.5、Corollary 1.6
- PDF p.36：Theorem B.1 的陈述与证明首句（含 `[B5, Theorem 5.1]`）
- PDF p.37：Theorem B.1 i)–iii)

**我转述或推断的（非原文）**：
- H9 全部五步（`Im(Z) > C` 的矩阵序读法、方盒构造、开性、Δ₅→Δ₅² 的平方、以及无需 chamber 的旁证验算）。
- H10 里 `c = 2f` 的对照。
- 「本轮疑点 1」里 φ₁₂,₁ q² 系数的验算。
- 坐标对照 `ρ=z₁, v=z₂, σ=z₃`（本文不用 ρ/σ/v 这套记号，见上文第 103 行）。
