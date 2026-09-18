# Prior-art gate — 紧化 + 穿孔超模空间可投影性

**日期**：2026-09-18
**执行者**：theorem-prover (agent/prover/supermoduli-compactified-punctured)
**目的**：核实"紧化 + 穿孔"这一象限在公开文献中确实无人处理（根 `CLAUDE.md` 原则："发起这条轨道前，
必须先确认真的无源可查"）。本文档记录**每一个**检索式与命中/未命中，不做事后筛选。

## 结论（先说结论，过程见下）

**没有找到任何公开文献直接证明或反驳"紧化 + 穿孔"超模叠的可投影性。** 派工单给出的四象限表成立，
右下角象限（紧化 + 穿孔）在 2026-09-18 当天的检索范围内确认为空白。

但检索发现了一个此前四张图卡（`math.supermoduli-space-not-projected` [Donagi–Witten]、
`math.supermoduli-ramond-punctures-not-projected` [Donagi–Ott]、
`math.supermoduli-ns-ramond-punctures-not-projected` [Wang]、
`math.supermoduli-compactified-genus-2/geq3-*` [Corrêa–Noja]）**都没有登记、但对本尝试至关重要**的
第五篇基础性文献：

> Giovanni Felder, David Kazhdan, Alexander Polishchuk, **"The Moduli Space of Stable Supercurves and
> Its Canonical Line Bundle"**, arXiv:2006.13271（首次提交 2020-06，v3 2023-03-06；已发表
> Amer. J. Math. **145** (2023) no. 6, 1777–1886）。

这篇文章的 **Theorem A** 逐字："There exists a smooth and proper DM-stack S̄_{g,n_NS,n_R} over ℂ
representing the functor of families of stable supercurves of genus g with n_NS NS punctures and n_R
Ramond punctures."——即：**"紧化 + 穿孔（NS 与 Ramond 均可）"的超模叠，作为光滑固有 Deligne–Mumford
超叠，已经被构造出来了**，且这正是 Corrêa–Noja 2026 用来定义他们自己的 𝔐̄_g（他们参考文献 [9]）
的同一篇文献，只是 Corrêa–Noja 只用了它的 n_NS=n_R=0 特例。**这篇文献本身不断言任何可投影性结果**
（它的目的是构造空间与研究典范线丛，见下），但它是本尝试论证赖以成立的地基，目前**不在
`literature/sources.bib` 与 `graph/` 中**——见本文档末尾"情报移交 lead"一节。

## 检索记录（逐条，含未命中）

### WebSearch

1. `compactified supermoduli space projected punctures Ramond` — 命中 Donagi–Ott、Corrêa–Noja、
   Donagi–Witten 摘要级结果，**未命中**任何直接处理"紧化+穿孔"的论文。搜索摘要本身明确指出
   "This connection to compactification is made explicit in related work: both types of punctures
   arise as nodes when one considers the compactification..."——即穿孔与紧化在**边界几何**层面有
   自然联系（Ramond 穿孔就是紧化空间里忘记自旋结构的映射的分歧点），但**没有文献把这层联系推进到
   "紧化+穿孔超模叠本身的可投影性"这个问题**。
2. `Deligne-Mumford supermoduli space Ramond punctures projection non-projected` — 命中同一批论文，
   额外命中一句对 Corrêa–Noja 论文范围的转述："the purpose is to determine projectedness for the
   compactified **unpunctured** supermoduli stack"——**明确限定 unpunctured**，与图卡记录一致。
   **未命中**任何"紧化+穿孔"结果。
3. `Corrêa Noja "compactified supermoduli" arXiv 2606.06733 citations` — 命中该文的两篇后续引用
   （Donagi–Noja 亏格4、nLab 索引页、"Formal moduli and splitting theory" companion 论文），
   **均未讨论穿孔**。
4. `Donagi Ott "Ramond punctures" supermoduli space projected citations 2024 2025` — 命中 Donagi–Ott
   本文、Wang 2025 后续、以及 Donagi–Ott 2024 另一篇"A measure on the moduli space of super Riemann
   surfaces with Ramond punctures"（arXiv:2410.12912，构造测度而非投影性结果）。**未命中**任何
   讨论紧化的段落被摘要覆盖（后续用 WebFetch 直接查该论文全文摘要页确认，见下）。
5. `supermoduli space punctures compactification non-projected 2026 boundary node` —
   **未命中**新结果；摘要综合重复前几条内容，额外提到"Ramond nodes are the ramification points of
   the map from the compactified spin moduli space..."（背景几何事实，非可投影性结果）。
6. `"work in progress" supermoduli punctures compactified projected Noja Correa Donagi Ott` —
   **未命中**任何"work in progress"式的预告句子指向"紧化+穿孔"；命中的是同一批已知论文。
7. `"compactified" "supermoduli" "Ramond" projected 2026 Donagi Noja Correa Wang Ott arXiv new` —
   确认 Donagi–Ott 已发表于 J. Geom. Phys. **220** (2026) Id/No. 105721；**未命中**新论文。
8. `supermoduli stack punctures Deligne-Mumford non-projected boundary divisor Green obstruction 2026` —
   命中 Corrêa–Noja 技术细节的转述（分离 NS 边界因子的具体几何：紧型 NS 节点稳定自旋曲线
   (C₁,L₁,q₁)∪(C₂,L₂,q₂)，两个椭圆分支配奇 theta 特征），以及 Corrêa–Noja companion 论文
   "Formal moduli and the splitting theory of supermanifolds"（arXiv:2605.03166）被转述为
   "a broader review paper"；**该转述本身未提到穿孔**，本尝试用 WebFetch 直接查该文摘要页核实
   （见下）。

### 直接查一手摘要页 / 全文页（WebFetch + Read，非 WebSearch 转述）

9. **Corrêa–Noja arXiv:2606.06733 摘要页**（`WebFetch`）：明确写"the projectedness problem for the
   compactified **unpunctured** supermoduli stack"；abstract 页未见任何关于穿孔或"未来工作"的句子
   （工具只能取到摘要页，非全文，故不能排除全文正文里有一句"we leave the punctured case to future
   work"，但下面第 11 条直接读了论文正文 pp.1–4，**Introduction 全文亦未出现"puncture"一词**，
   见 `correa-noja-2026.md`（既有抽取记录，全文 24 页逐页 L1 读取，"未解决的疑问"第 2 条已明确记录：
   "本轮未查到任何文献处理紧化且带 Ramond/NS 穿孔的可投影性问题"）。
10. **Donagi–Ott arXiv:2308.07957 摘要页**（`WebFetch`）：摘要本身不提紧化；本尝试直接读了该文
    PDF pp.1–4（见下 proof.md 与本文档"技术发现"一节），**全文可见范围内没有出现
    "compactification" / "Deligne–Mumford" / "stable" / "boundary" 等词**（该文关注的是有限覆盖
    与子流形嵌入两种"传播机制"，不是紧化）；论文附录据检索结果提及"Theorem 21"证明其自建的
    超模叠 M̃_{d,ρ} 本身是"smooth, proper Deligne–Mumford superstack"——**这是关于覆盖空间自身的
    固有性，不是"原始未紧化空间的紧化"，两者是不同的构造**，不构成对本象限的覆盖。
11. **Corrêa–Noja 全文 pp.1–4 直接读取**（本尝试用 `Read` 工具渲染 WebFetch 保存的 PDF，见下）：
    确认摘要+引言+§2.1/§2.2（Prop 2.2 primary obstruction 定义与 étale pullback 相容性陈述）
    全文未出现"puncture"字样。
12. **Felder–Kazhdan–Polishchuk arXiv:2006.13271 全文 pp.1–6 直接读取**：确认 Theorem A（紧化+穿孔
    空间的存在性与光滑固有性）、Theorem B（典范线丛公式，含 NS/Ramond 两类边界因子 Δ_NS, Δ_R）、
    Theorem C（NS 边界因子沿低亏格粘接映射的法丛识别）。**全文摘要与前 6 页读取范围内没有任何一句
    讨论"可投影性"（projectedness）**——这篇文献的目的是典范线丛的 Mumford 同构，完全不涉及
    projected/split 的问题；它是本尝试论证赖以成立的**地基**（紧化+穿孔空间的存在性与光滑性），
    但**它自己不覆盖、也不试图覆盖"紧化+穿孔"的可投影性问题**，两者是完全独立的问题。
13. **"Formal moduli and the splitting theory of supermanifolds" arXiv:2605.03166 摘要页**
    （`WebFetch`）：确认该文是关于分裂问题的一般形式模空间/dg 李代数理论（affine Atiyah class
    编码 Green 障碍塔），**完全不提穿孔、不提紧化、不提超黎曼曲面模空间本身**，是纯形式理论的
    companion 论文。**不覆盖本象限**。

## 特别核查：三篇关键论文是否"预告"紧化+穿孔情形

派工单特别要求核查"the case with punctures / the compactified case will be treated elsewhere"式的
预告句。核查结果：

- **Corrêa–Noja**（`correa-noja-2026.md` E7/未解决疑问第2条，全文 24 页逐页已读）：**未见任何此类
  预告句**。论文标题本身"almost never projected"已经暗示这是他们认为"settled"（settle the
  projectedness problem）的完整结果，只针对 unpunctured；没有一句说"punctured case elsewhere"。
- **Donagi–Ott**（本尝试直接读 PDF pp.1–4）：**未见**任何提及紧化或"未来工作会做紧化"的句子；
  论文致谢与引言只讨论覆盖空间构造与子流形传播两条技术路线。
- **Donagi–Noja**（既有抽取记录 `donagi-noja-2026.md` E4，全文 16 页已读）：致谢部分**只预告了
  "亏格 3（未紧化、无穿孔）非投影性是与 Corrêa 合作的进行中工作"**——这条预告完全在"未紧化、无
  穿孔"这一已知象限内部（填补 Donagi–Witten 留下的 g=3 缺口），**与"紧化+穿孔"象限无关**。
- **Wang**（既有抽取记录 `wang-2025.md`，pp.1–3 已读，pp.4起未读）：引言与预备部分**未提紧化**；
  论文本身标注"preliminary draft"，pp.4 起完全未读，**不能完全排除正文深处有一句预告**，但引言/
  摘要层面没有——这是本尝试唯一一处"未读到全文"的残留不确定性，如实记录，不影响本尝试判断
  （即使 Wang 正文深处真有一句预告，那也只是"某人打算做"，不是"已经做出"，不改变"零覆盖"的
  prior-art 结论）。

## 技术发现（副产品，直接影响 claim.md/proof.md 的可行性判断）

在核查 Donagi–Ott 全文 pp.1–4 时，读到两条**未被现有图卡/抽取记录覆盖**的关键技术事实
（既有抽取记录 `donagi-ott-2023.md` 只读到"存在 Lemma 2、Corollary 4"这一结构性层级，未逐字记录
其内容——本尝试在此基础上补充逐字读取）：

- **Corollary 3**（原文逐字，归于该文参考文献 [6]）："Let π: X̃ → X be a finite cover of
  supermanifolds. If ω₂(X) ≠ 0, then ω₂(X̃) ≠ 0. Furthermore, X is split if and only if X̃ is split."
- **Corollary 4**（原文逐字，归于该文参考文献 [6]）："Let X be a supermanifold and suppose X' ⊂ X is
  a sub-supermanifold with bosonic reduction M' ⊂ M such that the normal sequence
  0 → TM|_{M'} → TM'|... → N_{M'/M} → 0 is split exact. If X' is not projected, then X is not
  projected."
- Donagi–Ott 的证明机制是：genus-2 带一个 NS 穿孔的超模叠 𝔐_{2,1,0}（**这正是 Donagi–Witten
  Theorem 1.2 覆盖的对象：g=2, n=1, 偶自旋非投影**）作为分歧覆盖的**底空间**种子，用 Corollary 3
  把非投影性沿有限覆盖 p: M̃_{d,ρ} → 𝔐_{2,1,0} 向上传播到覆盖空间 M̃_{d,ρ}，再用一个嵌入
  i: M̃_{d,ρ} → 𝔐_{g,0,2r} 把结论搬进目标空间（Lemma 15，具体是否用 Corollary 4 的子流形机制还是
  另一论证，本尝试未读 pp.7 起的证明细节，标记为待核）。

这条发现对本尝试的 claim.md/proof.md 至关重要：**它确认了 Donagi–Witten 的 g=2, n=1 偶自旋结果
（属于既有图卡 `math.supermoduli-space-not-projected` Theorem 1.2 覆盖范围内）正是 Donagi–Ott 整条
证明链的"种子"**，这与本尝试提出的"紧化+穿孔"论证策略（见 claim.md）在方法论上同构：都是"取一个
已知非投影的低复杂度对象作种子，用某种保持 ω₂≠0 的函子性操作把它搬运到目标空间"，只是 Donagi–Ott
的搬运算子是"有限覆盖 + 子流形嵌入"，Corrêa–Noja 的搬运算子是"椭圆尾粘接"，本尝试提议的搬运算子是
"开子叠的 étale 限制（pullback）"。

## 情报移交 lead（不在本尝试权限内处理，仅记录+报告）

1. **FKP arXiv:2006.13271（"The moduli space of stable supercurves and its canonical line bundle"，
   Amer. J. Math. 145 (2023)）不在 `literature/sources.bib` 中，也没有 `literature/extractions/`
   条目**——但它是本尝试 claim.md/proof.md 的**地基性依赖**（紧化+穿孔超模叠的存在性与光滑固有性，
   Theorem A）。**建议 lead 派 researcher 做 L1 全文抽取**，至少覆盖：Theorem A 的精确陈述与证明
   依赖范围、Definition 2.4（"supercurve with punctures"的稳定性定义，含"存在纤维稠密开子集 U
   使 U/S 光滑"这条——本尝试 claim.md 会明确依赖这条来论证"未紧化穿孔模叠是紧化穿孔模叠的开稠密
   子叠"）、以及 §7（边界因子 Δ = Δ_NS + Δ_R 的精确构造，本尝试 proof.md 会需要引用它来讨论边界
   贡献是否可能产生"紧化专属"的额外障碍，见 proof.md §3）。
2. Donagi–Ott 引用的 Corollary 3 / Corollary 4（见上）出自其参考文献 **[6]**，本尝试未确认 [6] 的
   具体书目身份（很可能是 Donagi–Witten 本人另一篇文章，或 Corrêa–Noja 系列的某篇 companion 论文，
   但本尝试独立检索"Formal moduli and the splitting theory of supermanifolds" arXiv:2605.03166 的
   摘要后**未见**这两条具体引理陈述，故排除该文候选）。若 lead 认为这两条一般性传播引理本身值得
   登记为图节点（它们对整条"帶穿孔"文献链都是公共地基），建议派 researcher 先确认 Donagi–Ott 论文
   参考文献列表第 [6] 条的完整书目信息。
3. Wang 论文（`wang-2025`）pp.4 起完全未读，本尝试同样未读——若后续要在"紧化+穿孔（NS+Ramond
   混合）"情形做更深入工作，需要先补读全文确认是否有关于紧化的预告句（见上"特别核查"一节）。

## 本次检索没有改变的判断

四象限表仍然成立：**紧化 + 穿孔（NS 和/或 Ramond）超模叠的可投影性，在 2026-09-18 的检索范围内，
公开文献零覆盖。** 本尝试可以开工。
