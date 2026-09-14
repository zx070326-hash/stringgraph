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
