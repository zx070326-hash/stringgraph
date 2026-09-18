# 抽取记录：correa-noja-2026

- 文献：Mauricio Corrêa and Simone Noja, "Compactified Supermoduli Space is Almost Never Projected",
  arXiv:2606.06733v1 (2026)
- 抽取者：researcher (agent/researcher/supermoduli-post-2024)
- 日期：2026-09-18
- 覆盖范围：全文（24 页，含参考文献列表），逐页 L1 直接读取（Read 工具渲染 PDF 页面）

## 约定

紧化（Deligne–Mumford 型）无穿孔超模叠记 𝔐̄_g，偶/奇自旋分量记 𝔐̄_g^±（或 ε∈{+,−}）。
第一 Green 障碍类 ω₂(𝔛) ∈ H¹(X, T_X ⊗ Λ²T_-^∨𝔛)，与 donagi-noja-2026、donagi-witten-2013 用同一套
约定（本文正文明确写"we use Green's obstruction theory in the form recalled by Donagi–Witten"）。

## 陈述

### E1 主定理 Theorem 1.1（三条并列断言）
- 位置：p.1，Theorem 1.1（Main theorem）
- 类型：proposition
- 原文陈述（逐字，L1 直接读取）：
  "Let 𝔐̄_g^± denote the two parity components of the Deligne–Mumford compactification of the moduli
  superstack of unpunctured super Riemann surfaces. Then the following hold.
  (1) The odd compactified genus-two component 𝔐̄₂⁻ is split.
  (2) The even compactified genus-two component 𝔐̄₂⁺ is non-projected. More precisely, ω₂(𝔐̄₂⁺) ≠ 0.
  (3) For every g ≥ 3, both compactified parity components 𝔐̄_g^± are non-projected. More precisely,
  for every g ≥ 3, ω₂(𝔐̄_g^±) ≠ 0."
- 文献自称的严格程度：定理（"Main theorem"），完整证明性文章；§8 "Proof of the main theorem" 明确写
  "We now assemble the two arguments established in the preceding sections"，把定理拆成三部分分别在
  §3（item 1）、§4（item 2）、§5–§7（item 3）证明。
- 文献列出的依赖：见 E2–E8。
- 备注：**摘要与标题的"almost never projected"精确对应这三条**——g≥2 范围内唯一"投影"（且更强的
  "split"）的例外是 item (1)（紧化亏格二奇分量）。

### E2 item (2) 的优先权归属：Felder–Kazhdan–Polishchuk 先证，本文独立复核（关键引文，逐字）
- 位置：p.2，正文段落（Theorem 1.1 之后紧跟）
- 类型：definition（优先权/归属说明）
- 原文陈述（逐字，L1 直接读取）：
  "The second item was first proved by Felder–Kazhdan–Polishchuk in [10]. Here we confirm their result
  by computing directly the primary Green obstruction at the separating (−,−)-boundary divisor. Our
  argument is not independent of [10] though, as it relies on their boundary expansion of the
  superperiod map and the elementary hyperelliptic invariant-theoretic vanishing entering their
  analysis of projections."
- 文献自称的严格程度：作者自陈的历史归属声明（priority statement），非泛泛而谈；明确承认自己的论证
  "not independent of [10]"（依赖 [10] 的边界展开与超椭圆不变量论消没结果）。
- 文献列出的依赖：参考文献 [10]。
- 备注：**关键澄清（本抽取者独立核实，纠正抽取者本人此前一次误读）**：这句话里的"the second item"
  **指 Theorem 1.1 的 item (2)，即紧化亏格二偶分量非投影性，不是 item (3) 的 g≥3 结果**。参考文献表
  确认 [10] = Felder, Kazhdan, Polishchuk, "Superperiods and superstring measure near the boundary of
  the moduli space of supercurves", arXiv:2408.11136（见本条目 E11 与独立抽取文件
  `felder-kazhdan-polishchuk-2024.md`）。该 FKP 论文标题与摘要（本抽取者独立 L1 核实）本身**只处理
  亏格 2**（"We consider two applications to the geometry of this moduli space in genus 2...proving in
  particular that S̄_2 is not projected"），其中的 Theorem 6.3(i) 正是 Corrêa–Noja 在 §4 引用作为
  "the Felder–Kazhdan–Polishchuk genus-two even non-projectedness theorem, recalled in the form needed
  here in Section 4" 的那条结果（p.21，§8 证明正文：the second assertion is the Felder–Kazhdan–
  Polishchuk genus-two even non-projectedness theorem [...] In the notation of this paper, this is
  Theorem 4.3）。**g≥3 的结果（item 3）在本文中是 Corrêa–Noja 自己的新贡献**，通过 Donagi–Witten
  一点障碍族 + 椭圆尾 NS 粘接映射的全新构造（§5–§7）得到，论文正文和参考文献均未把 g≥3 结果归于 [10]
  或任何其他文献。

### E3 §3 内容：紧化亏格二奇分量分裂（item 1 的证明依据）
- 位置：§3（Theorem 3.5，p.11）
- 类型：proposition
- 原文陈述（忠实转述）：证明骨架为"典范亏格二对合作用于障碍层（obstruction sheaf）上，作用方式
  是一个非平凡特征标；这迫使第一障碍在通过一个有限étale覆盖后必须消失，从而给出分裂性"（inertia-
  character 判据，Lemma 2.5 一般形式的具体应用）。
- 文献自称的严格程度："we prove"，完整证明。
- 文献列出的依赖：Green 障碍理论（§2 回顾）；有限étale覆盖与惯性特征标判据（Corollary 3 [=Lemma 2.5]
  之类，§2 内建立）。
- 备注：无。

### E4 §4 内容：紧化亏格二偶分量不可投影（item 2 的具体计算，Theorem 4.3）
- 位置：§4（Lemmas 4.1/4.2, Theorem 4.3, pp.12–14）
- 类型：proposition
- 原文陈述（忠实转述）：直接在分离 (−,−)-边界因子处计算第一 Green 障碍的法向主部分量，证明该分量
  不能被消去，从而 ω₂(𝔐̄₂⁺) ≠ 0。
- 文献自称的严格程度："we prove"；同时明确自陈"this is precisely Theorem 4.3"是 FKP [10] 结果
  "recalled in the form needed here"——即本文对同一结果给出了独立于（但依赖于 [10] 部分工具的）
  第二个计算路径（见 E2）。
- 文献列出的依赖：见 E2（依赖 FKP [10] 的边界展开与超椭圆不变量消没结果）。
- 备注：无。

### E5 §5–§6：Donagi–Witten 一点障碍族回顾 + 椭圆尾 NS 粘接映射构造
- 位置：§5（p.15），§6（Lemmas 6.1/6.2, Proposition 6.3, pp.15–19）
- 类型：definition/proposition（构造性工具，非独立可引用的最终陈述）
- 原文陈述（忠实转述）：§5 回顾 Donagi–Witten 的一点（one-pointed）障碍超流形族 X_η 的构造；§6 构造
  "constant-tail NS gluing construction"，给出一个超叠态射 G_{E,M,q}: 𝔐_{h,1}^+ → 𝔐̄_g^ε（h=g−1，
  取定亏格一椭圆自旋曲线尾 (E,M,q)），把亏格 h+1 一点障碍族沿一个椭圆尾粘接嵌入亏格 g 的紧化超模空间
  边界。
- 文献自称的严格程度："we construct"，是本文原创的构造性工具，为 §7/§8 的 g≥3 结果服务。
- 文献列出的依赖：Donagi–Witten arXiv:1304.7798（一点障碍族的原始构造）。
- 备注：这是把种子结果（亏格 h≥2 的一点障碍族非零）沿粘接映射"搬运"到亏格 g≥3 紧化空间的核心技术
  路线，与 donagi-witten-2013 用分歧覆盖搬运种子结果（见 `research/attempts/genus-five-supermeasure/
  proof.md` §1.1 对 Donagi–Witten 覆盖论证的复核）是**不同的搬运机制**（本文用椭圆尾粘接，Donagi–
  Witten 2013 用分歧三重覆盖），但目的相同（把低亏格种子结果推广到任意更高亏格）。

### E6 §7：障碍在椭圆尾粘接下的存活性（Lemma 7.1, Corollary 7.2, Theorem 7.2）
- 位置：§7（pp.19–21）
- 类型：proposition
- 原文陈述（逐字要点，L1 直接读取，p.21）：
  "Proof. Since L^⊗2 ≃ ω_C, we have deg L = h−1, deg L^{-1} = 1−h < 0. Thus H⁰(C,L^{-1}) = 0. By
  Riemann–Roch, χ(C,L^{-1}) = h⁰(C,L^{-1}) − h¹(C,L^{-1}) = deg(L^{-1}) + 1 − h = 2 − 2h. Since
  H⁰(C,L^{-1}) = 0, this gives h¹(C,L^{-1}) = 2h−2. For h ≥ 2, the source of J has dimension at least
  2. By Lemma 7.1, ker J has dimension at most 1, and hence it cannot be all of H¹(C,L^{-1}). Choose
  η ∉ ker J."
  这证明了 Theorem 7.2：存在 η ∈ H¹(C,L^{-1}) 使 J(η) ≠ 0（J 是由 §6 粘接构造给出的一个具体上同调
  映射；此非零性是 g≥3 论证能够启动的关键存在性引理）。
- 文献自称的严格程度："we prove"，显式的上同调维数计数论证（Riemann–Roch + 核维数估计），完整、
  初等、非存在性猜测。
- 文献列出的依赖：E5（构造 J 所需的粘接映射）；标准 Riemann–Roch。
- 备注：**这条要求 h = g−1 ≥ 2，即 g ≥ 3**——与 item (3) 的量词范围精确吻合，不是巧合，是论证的
  技术门槛所在（h < 2 时 ker J 可能占满整个源空间，论证失效）。

### E7 §8：主定理组装，逐字核实证明骨架（Theorem 1.1 完整证明）
- 位置：§8 "Proof of the main theorem"（pp.21–24）
- 类型：proposition
- 原文陈述（逐字，L1 直接读取，p.21 开篇）：
  "Proof of Theorem 1.1. The first assertion is precisely Theorem 3.5: the odd compactified genus-two
  component 𝔐̄₂⁻ is split. The second assertion is the Felder–Kazhdan–Polishchuk genus-two even
  non-projectedness theorem, recalled in the form needed here in Section 4. In the notation of this
  paper, this is Theorem 4.3: the primary obstruction of 𝔐̄₂⁺ is non-zero, and hence 𝔐̄₂⁺ is
  non-projected.
  We now prove the higher-genus assertion. Fix ε ∈ {+,−}. Let g ≥ 3, and put h := g−1 ≥ 2."
  随后（pp.21–24）取亏格 h 的曲线 C 配备无效偶 theta 特征 L^⊗2 ≃ ω_C，H⁰(C,L)=0；取奇偶两种宇称的
  椭圆自旋尾 (E,M,q)（"the trivial theta characteristic on E is odd, whereas the three nontrivial
  two-torsion theta characteristics are even"）；用 §6 的粘接映射构造测试态射 F_{η,M}: X_η → 𝔐̄_g^ε；
  用 Theorem 2.6（一个一般的障碍类比较引理/函子性引理，§2 建立）把子空间上非零的 j_{F}(ω₂(X_η)) = J(η)
  ≠ 0（E6）与目标空间上的障碍类 ι_{F}(ω₂(𝔐̄_g^ε)) 联系起来，得到 ι_{F}(ω₂(𝔐̄_g^ε)) = J(η) ≠ 0，从而
  ω₂(𝔐̄_g^ε) ≠ 0，"By Theorem 2.2, non-vanishing of the primary obstruction prevents projectedness.
  Hence 𝔐̄_g^ε is non-projected."
  最后一段（p.24）说明两种宇称分量均可达到："Elliptic curves admit theta characteristics of both
  parities...Choosing M even gives the even compactified component, and choosing M odd gives the odd
  compactified component. Therefore both 𝔐̄_g^+ and 𝔐̄_g^- are non-projected for every g ≥ 3."
- 文献自称的严格程度：完整证明（"Proof of Theorem 1.1"），无省略步骤（本抽取者逐页读完，未发现
  [GAP]/[TODO]/"we leave to the reader"式跳步）。
- 文献列出的依赖：Theorem 3.5（E3）、Theorem 4.3（E4，间接依赖 FKP [10]，见 E2）、Theorem 2.2（§2 内
  Green 障碍消没蕴含可投影性的一般引理）、Theorem 2.6（§2 内的障碍类函子性/比较引理）、Theorem 7.2
  （E6）、§6 的粘接映射构造（E5）。
- 备注：**g≥3 部分的证明完全不引用 FKP [10]**——只有 item (2)（g=2 偶分量）依赖 FKP。curator 若要
  精确标注依赖边，应仅在 item (2) 对应的图节点上标 FKP arXiv:2408.11136 依赖，item (1)/(3) 不应标此
  依赖。

### E8 参考文献列表逐条核实（解决此前抽取者本人对 [9]/[10] 身份的未决问题）
- 位置：References（pp.24）
- 类型：definition（文献学记录）
- 原文陈述（逐字抄录相关条目）：
  "[9] G. Felder, D. A. Kazhdan and A. Polishchuk, The moduli space of stable supercurves and its
  canonical line bundle, Amer. J. Math. 145 (2023), no. 6, 1777–1886.
  [10] G. Felder, D. Kazhdan and A. Polishchuk, Superperiods and superstring measure near the boundary
  of the moduli space of supercurves, arXiv:2408.11136."
  （其余相关条目：[6] M. Corrêa, S. Noja, Formal moduli and the splitting theory of supermanifolds,
  arXiv:2605.03166；[7] R. Donagi and E. Witten, Supermoduli space is not projected, in String-Math
  2012, Proc. Sympos. Pure Math. 90 (2015) 19–71；[8] R. Donagi and E. Witten, Super Atiyah classes and
  obstructions to splitting of supermoduli space, Pure Appl. Math. Q. 9 (2013), no. 4, 739–788；
  [11] P. Green, On holomorphic graded manifolds, Proc. Amer. Math. Soc. 85 (1982), no. 4, 587–590；
  [13] E. Witten, Notes on super Riemann surfaces and their moduli, Pure Appl. Math. Q. 15 (2019),
  no. 1, 57–211.）
- 文献自称的严格程度：不适用（参考文献列表条目）。
- 文献列出的依赖：不适用。
- 备注：**这彻底解决了本抽取者此前（压缩前会话）关于 [9]/[10] 身份的未决问题**：[9] 是 FKP 发表在
  Amer. J. Math. 145 (2023) 的"canonical line bundle"论文（无独立 arXiv 号写在此参考文献条目里，
  另据 dunin-barkowski-fedorov-sleptsov-2025 的参考文献表 [34] 交叉核实，其 arXiv 号为 2006.13271）；
  [10] 正是本抽取者 P1-4 任务的目标论文 arXiv:2408.11136，已独立开一个抽取文件
  `felder-kazhdan-polishchuk-2024.md`。

## 未解决的疑问

1. **§2 的 Theorem 2.2 / Theorem 2.6 未单独抽取为独立 E 条目**：这两条是 §8 证明骨架里被反复引用的
   一般性引理（障碍消没⇒可投影 的逆否命题；障碍类沿态射的函子性比较），本抽取者在阅读 §8 时确认了
   它们被使用的方式和结论文字，但未专门重读 §2 逐字核实这两条引理自身的证明细节（§2 主要在 pp.1–3
   已读，但 Theorem 2.2/2.6 具体证明段落是否在已读页码范围内需 curator 或后续核实时再次确认页码）。
   若 curator 需要把 Theorem 2.2/2.6 做成独立图节点的依赖，建议先补读 §2 全文确认其证明是否完整
   自足或本身依赖 [9]/[10]。
2. **"almost never projected"这个论文标题的量词范围**：本文标题断言的范围是"紧化、g≥2、无穿孔"，
   完全不涉及**未紧化**空间（那是 donagi-witten-2013 / donagi-noja-2026 的范围）也不涉及**有穿孔**
   空间（那是 donagi-ott-2023 / wang-2025 的范围）——curator 若要建立跨论文的"覆盖范围地图"式索引
   节点，四篇论文（DW2013未紧化无穿孔、DN2026亏格4未紧化无穿孔、CN2026紧化无穿孔、DO2023+Wang2025
   有穿孔）分别覆盖互不重叠的四个象限，无一篇声称覆盖"紧化+有穿孔"这一象限（本轮未查到任何文献
   处理紧化且带 Ramond/NS 穿孔的可投影性问题，若 curator 需要标注"未解决/未见文献处理"的缺口，
   这是一个候选点，但本抽取者未做穷尽式文献搜索确认真的无人做过，仅是本轮阅读范围内的观察）。
