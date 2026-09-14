# 抽取记录：rossello-2024

- 文献：G. Rosselló, "The Immortal Dyon Index Is Positive," arXiv:2403.19630 (2024)
- 抽取者：lead (direct, 2026-09-14)
- 日期：2026-09-14
- 覆盖范围：摘要与引言（§1）、主定理陈述（§2–§3）；未完整通读全文，标注待核处

## 约定

- N=4 弦论（type II on K3×T²），四维，标准 Hodge 约定。
- 1/4-BPS 单心（immortal）dyon：判别式 d = 4mn−l² > 0，gcd(m,n,l) = 1，在给定 immortal chamber 中稳定。
- dyon 指标：d(m,n,l) = mock Jacobi 形式 φ_F（DMZ 分解后的有限部）的傅里叶系数。
- 正性：d(m,n,l) > 0（作为整数，即有符号指标为正）。

## 陈述

### E1 N=4 1/4-BPS 单心 dyon 指标正性（主定理，旗舰情形）
- 位置：主定理（具体定理编号和页码待核），引言中明确陈述
- 类型：proposition
- 原文陈述（忠实转述）：对 N=4 弦论（type II on K3×T²）中**所有**满足 d = 4mn−l² > 0 且 gcd(m,n,l) = 1 的 immortal dyon，其指标 d(m,n,l) > 0。
- 文献自称的严格程度："Theorem"；作者称证明对全部判别式范围成立（包括小判别式情形），不需要"充分大"的限制（这是相对于 Bringmann-Murthy 2012 的改进）。
- 文献列出的依赖：DMZ 2012（分解定理，rigorous）；Zwegers 2002（mock 模形式框架）；mock Jacobi 形式系数的符号分析（结合模变换性质、Fourier 展开系数的显式界）；部分物理输入（immortal dyon 的识别 = DMZ 识别③，physical-argument）。
- 备注：**数学部分是 rigorous**——mock Jacobi 系数符号的严格证明；但物理意义（这些系数 = 单心黑洞指标）依赖 DMZ 的物理识别③（physical-argument）。Sen positivity 猜想的 N=4 旗舰情形被本文完全关闭（2024 年）。

### E2 与 Bringmann-Murthy 2012 的关系
- 位置：引言，比较讨论
- 类型：proposition（说明性）
- 原文陈述（忠实转述）：Bringmann-Murthy 2012 对"充分大"判别式情形给出正性（用圆法 + Kloosterman 估计），但未覆盖所有小判别式；Rosselló 2024 的方法不同，对所有判别式成立，完全关闭该情形。
- 文献自称的严格程度：比较说明，引用 BM 2012。
- 文献列出的依赖：Bringmann-Murthy 2012（前置工作）；DMZ 2012。
- 备注：图节点中 bringmann-murthy-2012 和 rossello-2024 应分别引用，覆盖范围不同。

## 未解决的疑问

1. Rosselló 的具体证明方法（"mock Jacobi 形式系数符号分析"的技术细节）未在本抽取中核实——方法究竟是组合符号分析还是某种解析估计，需对照原文 §2–§3。
2. "物理输入"的程度：Rosselló 是否在某处依赖"D-brane 物理"或"BPS 计数"等物理假设，还是整个论证在 mock 模形式的纯数学框架内？若前者，严格度应标注；若后者，则数学侧完全 rigorous，只有识别步是 physical-argument。需核实。
3. 适用范围是否含 CHL 推广？本文摘要仅说明 N=4 旗舰情形（K3×T²），不覆盖 CHL orbifold。

---

## 核实（researcher, task #17, 2026-09-14）

抽取来源：arXiv HTML 全文 https://arxiv.org/html/2403.19630 、摘要页 https://arxiv.org/abs/2403.19630 。
以上初步条目（lead）标"待核处"的疑问 1–3 在此逐条解决，并订正若干事实。上方 E1/E2 及疑问保留不动（审计痕迹）。

### 订正 C1 作者姓名
- 初稿与 sources.bib 原写 "Guillem/G. Rosselló"；**实际作者为 Martí Rosselló**
  （Institute of Mathematics, Academia Sinica, Taipei；INSPIRE author 1945417；
  与 Cardoso–Nampuri–Rosselló 2021 Rademacher 展开文同一作者）。已同步订正 sources.bib。

### E3 主定理与推论（核实）
- 位置：§1 给出主结论；正文 Theorem 1、Corollary 1.1。
- 类型：proposition（数学定理）。
- 原文陈述（忠实转述，含符号）：
  - **Theorem 1**：设 m>0、n≥m、0≤ℓ≤m，则 (−1)^{ℓ+1} c_m^F(n,ℓ) > 0。
    （c_m^F(n,ℓ) = 指标 m 的 mock Jacobi 形式 ψ_m^F 的傅里叶系数；ψ_m^F 由 1/Φ₁₀ 的
    DMZ 典范分解得到。）
  - **Corollary 1.1**：设 m,n,ℓ∈ℤ，m,n≥1，Δ=4mn−ℓ²>0，则 d_*(m,n,ℓ) > 0。
    由单心简并度的 S-对偶（GL(2,ℤ)）不变性从 Theorem 1 的代表元范围推广到全部电荷；
    本文限定 torsion I=1（单位挠），高挠态可归约到单位挠。
- 文献自称的严格程度："Theorem"/"Corollary"；对**全部** Δ>0（含小判别式）证明，无"充分大"限制。
- 依赖：DMZ 2012（分解 + 收敛整值 Rademacher 展开，本文 [35][38]）；Zwegers 2002；Igusa 尖点形式
  Φ₁₀（Sp(4,ℤ) 权 10 Siegel modular form）。

### E4 证明方法与"是否含物理输入"（task #17 核心裁定依据）
- 位置：§2（Rademacher 展开、极系数界），§3（m≥6 一般证明），Appendix A（m=3,4,5）。
- **证明结构（纯解析数论）**：
  1. 用 Siegel 模形式的 GL(2,ℤ) 对称约化到代表元 n≥m、0≤ℓ≤m；
  2. 系数写成精确收敛的 **Rademacher 展开**（式 2.36）：修正 Bessel 函数 (I_{23/2}, I_{12},
     I_{25/2}) × 广义 Kloosterman 和（theta 乘子系）× 极系数 c_m^F(ñ,ℓ̃)（Δ̃<0）之和；
  3. 识别 γ=1、ℓ̃=m 的非-mock 项为无条件正的主项（式 3.5，Kloosterman 和简化为 (−1)^ℓ/√(2mi)）；
  4. Lemma 2 把 mock 项（C_{12}, C_{25/2}）对主项定界（界 5×10⁻⁴、0.015）；Lemma 3 起用连分数
     结构（式 2.43）+ d(n) 的 Rademacher 型界（Prop. 2）界住极系数；Lemma 7 组装得 m≥6 为正；
     m=1,2 归 [30]（Bringmann-Murthy），m=3,4,5 见 Appendix A 显式验证。
- **是否含物理输入（判定）**：**正性证明本身完全是纯数学**，物理只提供动机与解读。原文自述证明
  "simply consists in identifying the leading terms with a positive contribution and bounding the
  remaining infinitely many contributions against them"；结论表述为 "black holes predict the sign
  of the Fourier coefficients of mock modular forms"——物理**预言**、数学**证明**。全篇正性论证在
  mock 模形式/圆法/Kloosterman 界的纯解析框架内，未把弱耦合展开、谱假设、弦对偶或超引力/黑洞态
  计数当作**证明前提**。arXiv 交叉分类 hep-th + math.NT 亦一致。
- 依赖：DMZ 2012 分解定理（rigorous）、Zwegers 2002、圆法收敛定理[35][38]、Kloosterman/Bessel 标准估计。

### E5 论证中唯一的物理假设（属"识别"层，不属正性证明）
- 位置：§1（single-centered/immortal 指标的界定，hair-mode 分解）。
- 原文（忠实转述）：把总 1/4-BPS 指标分解出"单心（immortal）"部分时，就 hair 模式陈述
  "We assume that such frame exists for 1/4-BPS black holes"；并指出正性 "does not imply that all
  microstates are bosonic"，只说明 "the index receives more contributions from bosonic states than
  fermionic ones"。Sen 猜想的物理前提是"超对称黑洞在四维构成全部零角动量态的系综"。
- 判定：此假设服务于**物理识别**（"被证正的系数 c_m^F = immortal dyon 指标"），对应图中
  holography.dmz-single-center-identification（识别③，physical-argument）。它**不进入** E4 的系数
  正性证明，但它是"immortal dyon 指标为正"这一**物理陈述**成立的前提。

### 疑问解决
1.（原疑问1）已解决：见 E4——方法为 S-对偶约化 + Rademacher 展开 + Kloosterman/Bessel 显式定界，
   非单纯组合符号分析；m=3,4,5 显式、m≥6 一般。
2.（原疑问2）已解决：见 E4、E5——系数正性证明纯数学；唯一物理假设在"识别"层（hair frame + 单心
   识别），不在正性证明内。
3.（原疑问3）本文仅 N=4 旗舰（K3×T²），不含 CHL。CHL 推广见后续 arXiv:2311.16252 等，且已知低电荷
   CHL 出现违反正性的负号，属识别层的电荷构型甄别问题，非本文数学结论。

---

## Corollary 1.1 推广步性质核实（researcher, 2026-09-14）

抽取来源：arXiv HTML 全文 https://arxiv.org/html/2403.19630 （原始 HTML 下载后剥标签逐句核对，非依赖二手摘要）。
目标：只针对 **Corollary 1.1 由 Theorem 1 的 GL(2,ℤ) 推广步**，钉死它是 (i) 纯数学 / (ii) 含物理输入。
上方 E1–E5 及疑问解决保留不动（审计痕迹）。以下逐字转述均含 §/式号定位。

### R1 三条关键对象的原文定义（逐字）

- **d_∗(m,n,ℓ) 是纯数学对象**。§1 引言（正文近 (1.2) 处）逐字：
  "The quantity d_∗(m,n,ℓ) is defined in (2.23) as the Fourier coefficient of a meromorphic Siegel
  modular form at a particular point in the Siegel upper-half space which is charge dependent."
  即 d_∗ = 亚纯 Siegel 模形式 1/Φ₁₀ 在一个**依赖电荷的点**（吸引子点）的傅里叶系数。
- **(2.23) 定义式**（§2）：d_∗(m,n,ℓ) = ∫_{𝒞_∗} dρ dσ dv · e^{−2πi(mρ+nσ+ℓ(v+1/2))} / Φ₁₀(ρ,σ,v)。
  其中 **𝒞_∗ 是 (2.22) 明确给出的具体围道**（"attractor contour"，Λ≫0，line: "This contour is called
  the attractor contour since it coincides with the one given by the values that the moduli take at
  the black hole horizon through the attractor mechanism [66]"，[66]=Ferrara–Kallosh–Strominger 吸引子机制）。
- **ψ_m^F 的傅里叶系数 c_m^F(n,ℓ)** 是 1/Φ₁₀ 傅里叶展开 (2.24)–(2.26) DMZ 典范分解后有限部（mock Jacobi
  形式）的系数，[31]=Dabholkar–Murthy–Zagier。§2.2 逐字："The finite part ψ_m^F ... is the generating
  function ... for the single centered (or immortal) indexed degeneracy of states carrying charge
  bilinears m,n,ℓ which satisfy **0≤ℓ<2m,2n** [31]."

### R2 Corollary 1.1 陈述与其推广步理由段（逐字）

- **Theorem 1（§1，式 1.5）**："Let m>0, n≥m and 0≤ℓ≤m, then (−1)^{ℓ+1} c_m^F(n,ℓ) > 0."
- **Corollary 1.1（§1，式 1.6）**："Let m,n,ℓ∈ℤ with m,n≥1 and Δ=4mn−ℓ²>0. Then, d_∗(m,n,ℓ)>0."
  （注意：结论是 **d_∗>0**，不是 c_m^F>0；见 R4。作者全篇限定单位挠 I=1。）
- **引言给出的推广逻辑（§1，Corollary 1.1 之前）**逐字："As we explain in Section 2, **as a consequence
  of the S-duality invariance of the single centered degeneracies**, we have Corollary 1.1."
- **§3.1 "Main idea" 推广步全文（逐字）**：
  "Since the single centered degeneracies are S-duality invariant, it is enough to prove the positivity
  for the representatives of one S-duality equivalence class. That is, it is enough proving it for states
  satisfying n≥m, 0≤ℓ<2m, and then it is automatically proved for all the SL(2,ℤ) images. **Furthermore,
  since the invariance group can be enlarged to GL(2,ℤ) (see, e.g. [59], or notice that the Igusa cusp
  form has even weight), it is enough to prove it for charge configurations satisfying** (3.1) n≥m,
  0≤ℓ≤m, which for m≥1 automatically satisfy Δ>0."
- **§2 不变性的依据句（逐字，紧接 (2.23)）**："**It follows from the definition of the contour 𝒞_∗ (2.22)
  that** the number of BPS indexed degeneracies associated to a single centered black hole given by (2.23)
  is invariant under the duality group (2.2). The discriminant Δ is also invariant under the duality
  transformations (2.2) ... The value of the single centered degeneracies depends only on the **SL(2,ℤ)
  equivalence class of the discriminant Δ**, while the inequivalent number of solutions is given by the
  class number associated to the discriminant of (m,n,ℓ) [67]." （(2.2) = SL(2,ℤ)×O(6,22;ℤ)；[67]=Moore
  "Arithmetic and attractors"，类数。）

### R3 推广步援引的文献（bib 定位）

- **[59]** = Bossard–Cosnier-Horeau–Pioline, "Exact effective interactions and 1/4-BPS dyons in heterotic
  CHL orbifolds," SciPost Phys. 7 (2019) 028, 1806.03330。**在本文中被当作"Siegel 模形式手册"引用**：§2 line 305
  逐字 "(see **Appendix A in [59] for a useful compendium on Siegel modular forms**)"。§3.1 的 "see, e.g. [59]"
  即指向该数学手册，且**并列给出自足数学理由** "or notice that the Igusa cusp form has even weight"。
- **[66]** = Ferrara–Kallosh–Strominger, "N=2 extremal black holes," hep-th/9508072（吸引子机制，定义围道 𝒞_∗ 的物理动机）。
- **[67]** = Moore, "Arithmetic and attractors," hep-th/9807087（二元二次型类数）。
- **[31]** = Dabholkar–Murthy–Zagier, 1208.4074（mock Jacobi 分解 + ψ_m^F=单心生成函数的识别）。
- **[52][53][54]** = Banerjee–Sen 0801.0149 / Banerjee–Sen–Srivastava 0802.1556 / Dabholkar–Gomes–Murthy
  0803.2692，仅用于把 **挠 I>1** 归约到 I=1。**(b) 取 gcd=1（单位挠），不触及这三条**，故这层物理输入与 (b) 无关。
- **关键否定证据**：不变性依据句 (§2, 接 (2.23)) 与 §3.1 推广句里，**没有把 Sen / Dabholkar 的"物理 S-对偶
  下单心指标按模形式变换"当作前提来引用**；不变性归因于 "the definition of the contour 𝒞_∗" 与 Φ₁₀ 的
  Sp(4,ℤ) 模性，GL(2,ℤ) 扩群归因于 **Igusa 尖点形式偶权**（纯数学），[59] 是数学手册。

### R4 裁定：Corollary 1.1 推广步 = **(i) 纯数学**（弦对偶未作为证明前提），但须修正卡 (b) 的陈述对象

**推广步的逻辑内容全部为数学**，理由链：
1. d_∗(m,n,ℓ) 是**明确的数学对象**——亚纯 Siegel 模形式 1/Φ₁₀ 在电荷依赖点的傅里叶系数 / (2.23) 的
   吸引子围道积分（R1）。
2. 其在对偶群 (2.2) 下的不变性，作者归因于 **"the definition of the contour 𝒞_∗"** + Φ₁₀ 的 Sp(4,ℤ)
   模性（R2），即"d_∗ 只依赖 Δ 的 SL(2,ℤ) 等价类"。**未引用任何物理 S-对偶假设作前提**（R3 关键否定证据）。
3. SL(2,ℤ)→GL(2,ℤ) 扩群——把代表元范围从 0≤ℓ<2m 收紧到 0≤ℓ≤m 的关键步——作者给出**自足数学理由**
   "the Igusa cusp form has even weight"（Φ₁₀ 偶权 ⇒ 反射对称），[59] 只作 Siegel 模形式数学手册并列引用。
4. "推广到代表元"是正定二元二次型 [m,ℓ,n]（Δ=4mn−ℓ²>0 ⟺ 判别式 ℓ²−4mn<0 ⟺ 正定）的 **Gauss / GL(2,ℤ)
   约化**，代表域 (3.1) 即约化域；类数出处 [67]（数学）。
5. 代表元范围内 ℓ≤m≤n ⇒ ℓ<2n 且 ℓ<2m，故 d_∗(m,n,ℓ)=(−1)^{ℓ+1}c_m^F(n,ℓ)（R 腔傅里叶等式，§2.2），
   Theorem 1 证其为正 ⇒ 代表元 d_∗>0 ⇒ 不变性推全域 = Corollary 1.1。

物理只出现在两处，**均不进入推广步的逻辑前提**：(a) 选吸引子围道 𝒞_∗ 的**动机**（吸引子机制 [66]）；
(b) "d_∗ = 单心黑洞简并度"的**物理解读/识别**（DMZ [31]，即上方 E5 的识别③层）。这与 E4 的全局裁定一致，
也与 E3 的物理措辞不冲突：**本文用物理词汇（单心简并度、S-对偶）称呼一个数学上成立的不变性**（偶权 Siegel
模形式的围道积分在 GL(2,ℤ) 下不变），二者非矛盾，只是 E3 转述了原文用语、E4 点出了逻辑实质。

**须向 curator 提示的两点保留（重要）**：

- **（保留 A，措辞级但关键）卡 (b) 的陈述对象须是 d_∗，不是 c_m^F**。Corollary 1.1 断言的是
  **d_∗(m,n,ℓ)>0**，而非 "(−1)^{ℓ+1}c_m^F(n,ℓ)>0 在全范围"。**后者在全范围为假**：§2.2 反例 (2.34)
  c_10^F(1,6)=1393564656 满足 (−1)^{6+1}c_10^F(1,6)<0（(m,n,ℓ)=(10,1,6)，Δ=4，满足 0≤ℓ<2m 但违反 ℓ<2n），
  作者明说 "the positivity conjecture in this case is **not** satisfied due to ... multi-centered black holes"；
  须减去多心留数 (2.35) 才得 d_∗(10,1,6)=(−1)^7(1393564656−4d(1)d(5)−2d(1)d(2))=50064>0，且等于代表元
  d_∗(1,1,0)=(−1)c_1^F(1,0)。**结论：c_m^F 的（带符号）正性只在代表元范围（=Theorem 1）成立；全范围正性
  属于 d_∗（含多心扣除/等价类归约），即 Corollary 1.1。** 若卡 (b) 写成"全范围 mock Jacobi 系数正性"须订正为
  d_∗ 正性，否则陈述与原文 (2.34)-(2.35) 直接矛盾。
- **（保留 B，严格度级）基础 S-对偶不变性是"断言"而非本文分步证明**。作者以 "It follows from the definition
  of the contour 𝒞_∗" 一句带过 d_∗ 在 (2.2) 下的不变性，未在本文给出逐步证明——它是既有背景结果（源于
  Φ₁₀ 的 Sp(4,ℤ) 模性 + 吸引子围道协变），Sen / DGM 早已确立。要把 (b) 记 rigorous，节点应显式记：推广步依赖
  (1) Φ₁₀∈M_10(Sp(4,ℤ)) 偶权（数学），(2) 吸引子围道积分 d_∗ 在 SL(2,ℤ)⊂Sp(4,ℤ) 下不变、经偶权扩到 GL(2,ℤ)
  （数学，本文以"由围道定义即得"援引为背景），(3) 正定二元二次型的 Gauss/GL(2,ℤ) 约化（数学）。这条不变性建议
  在图里标 `inferred` 指向 Φ₁₀ 模性节点或另立"d_∗ 的对偶不变性"引理卡，而非当成本文原证的一步。

**一句话结论**：(b)（Corollary 1.1 的全域正性）**可记 rigorous**——推广步是纯数学（偶权 Siegel 模形式围道积分
的 GL(2,ℤ) 不变性 + 二元二次型 Gauss 约化），弦对偶未作证明前提；但 (b) 的陈述对象必须是 **d_∗(m,n,ℓ)>0**
（免死指标 / 含多心扣除），不是全范围的 c_m^F 系数正性（后者为假），且基础不变性宜作背景引理（`inferred`）而非本文原证一步。
