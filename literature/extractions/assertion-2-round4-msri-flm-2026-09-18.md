# 抽取记录：断言 (2) 第四轮（最后一轮）—— MSRI vol. 3 / FLM 转引路线 / Kac–Raina

- 目标：清掉前三轮遗留的三个 L0 候选，让 lead 能对「公开文献里确无此结果」这一前提作最终裁决。
  目标命题是 `graph/statements/worldsheet/physical-exponential-equals-voa-vertex-operator.yaml`
  的**断言 (2)**：`:e^{i n k₀·X(z)}: = 𝒴(e^{n k₀}, z)`（作为塔 T(p;k₀) 上的算子等式）。
- 抽取者：researcher（第四轮）
- 日期：2026-09-18
- 覆盖范围：候选 1 = MSRI Publications vol. 3（Springer 1985）；候选 2 = FLM 1988 Ch. 8 的
  **后续论文逐字转引路线**；候选 3 = Kac–Raina Bombay Lectures 复核。逐条访问渠道成败见各 E 条目。

## 判据（逐字照抄任务书，三条全部满足才算命中）

文献必须：
1. **写出**物理侧对象——`X^μ(z)` 或自由玻色场的模展开，**且**带正规序 `: :` 记号。
   散文里提一句 "free bosonic CFT" 不算；
2. 把它与 VOA 结构映射 `Y(e^α, z)`（格点顶点代数在格元上的结构映射）**划等号**；
3. 该等号是**两个独立构造出来的对象之间的等式**，**不是**定义式（`:=`）、也不是同一构造的记号改写。

前三轮已确认的四种失败模式（本轮用作对照，不重复踩）：
Nikolov–Todorov 2004 = 定义不等于识别（判据 3 失败）；
Gebert hep-th/9308151 = VOA 侧独立、物理侧是记号改写（判据 3 失败）；
Dolan–Goddard–Montague hep-th/9410029 = 物理侧最好、`Y(v,z)` 正文不出现（判据 2 失败）；
Gaberdiel hep-th/9910156 = 物理侧记号本身缺席（判据 1 失败）。

## 约定

本轮读到的两份一手材料（MSRI vol.3 前言与 Lepowsky 导言）**不含任何度规/α′ 约定相关公式**，
无需换算。转引路线上读到的论文各自记号在条目内标注，不统一改写。

---

## 候选 1：Lepowsky–Mandelstam–Singer (eds.), *Vertex Operators in Mathematics and Physics*,
MSRI Publications **3**, Springer-Verlag New York, 1985（= 1983-11-10..17 Berkeley MSRI 会议文集；
任务书称之为「Goddard–Olive 编 *Algebras, Lattices and Strings*」——**这个称呼有误，见 E1.0**）。
新登记 bib key `lepowsky-mandelstam-singer-1985`。

### E1.0 ⚠ 书目订正：「Algebras, Lattices and Strings」是**卷内一篇文章**，不是这一卷的书名
- 位置：Springer 官方卷页 `link.springer.com/book/10.1007/978-1-4613-9550-8`（L1，本轮实读 HTTP 200，
  283 KB）＋官方免费 front-matter PDF `link.springer.com/content/pdf/bfm:978-1-4613-9550-8/1`
  （L1，12 页，本轮下载成功，628 KB，Springer 自家扫描件，合规）。
- 类型：（元信息 / 书目订正）
- 原文陈述（逐字，front matter 扉页与 Springer 卷页元数据一致）：
  > Vertex Operators in Mathematics and Physics — Proceedings of a Conference November 10-17, 1983
  > Edited by J. Lepowsky · S. Mandelstam · I.M. Singer … Mathematical Sciences Research Institute
  > Publications 3 … Springer-Verlag New York Berlin Heidelberg Tokyo … ©1985 …
  > ISBN-13: 978-1-4613-9552-2, e-ISBN-13: 978-1-4613-9550-8, DOI: 10.1007/978-1-4613-9550-8
  > (XIV, 482 pp., 23 papers)
- 备注：**MSRI vol. 3 的编者是 Lepowsky–Mandelstam–Singer，不是 Goddard–Olive**；
  Goddard–Olive 是卷内第 5 篇文章《Algebras, Lattices and Strings》(pp. 51–96) 的**作者**。
  任务书（以及第三轮抽取记录的候选 5 条目）把篇名当成书名、把作者当成编者，**本轮订正**。
  第三轮记录里「Goddard–Olive, "Algebras, Lattices and Strings", MSRI Publications vol. 3
  (*Vertex Operators in Mathematics and Physics*, Lepowsky–Mandelstam–Singer eds., Springer 1985,
  pp.51–96)」这一行是对的，**只有汇总处的简称有误**。

### E1.1 完整篇目表（23 篇，L1，Springer 官方卷页两页 TOC 全部抓取）
- 位置：`link.springer.com/book/10.1007/978-1-4613-9550-8`（page=1 与 page=2），L1
- 类型：（元信息，篇目表）
- 原文陈述（逐字，按卷内顺序；分组标题为 Springer 卷页给出的 part 名）：
  > Front Matter, pp. i–xiv
  > **Introduction** — Introduction, James Lepowsky, pp. 1–13
  > **String models** — Introduction to String Models and Vertex Operators, S. Mandelstam, pp. 15–35
  > An Introduction to Polyakov's String Model, Orlando Alvarez, pp. 37–47
  > Conformally Invariant Field Theories in Two Dimensions, Thomas Curtright, pp. 49–50
  > **Lie algebra representations** — **Algebras, Lattices and Strings, P. Goddard, D. Olive, pp. 51–96**
  > Z-Algebras and the Rogers–Ramanujan Identities, James Lepowsky, Robert Lee Wilson, pp. 97–142
  > Structure of the Standard Modules for the Affine Lie Algebra A1(1) in the Homogeneous Picture,
  >   J. Lepowsky, M. Primc, pp. 143–162
  > Standard Representations of Some Affine Lie Algebras, Kailash C. Misra, pp. 163–183
  > Some Applications of Vertex Operators to Kac-Moody Algebras, Alex J. Feingold, pp. 185–206
  > On a Duality of Branching Coefficients, Michio Jimbo, Tetsuji Miwa, pp. 207–216
  > **The Monster** — A Brief Introduction to the Finite Simple Groups, Robert L. Griess Jr., pp. 217–229
  > **A Moonshine Module for the Monster, Igor B. Frenkel, James Lepowsky, Arne Meurman, pp. 231–273**
  > **Integrable Systems** — Monodromy, Solitons and Infinite Dimensional Lie Algebras,
  >   Michio Jimbo, Tetsuji Miwa, pp. 275–290
  > The Riemann-Hilbert Decomposition and the KP Hierarchy, Kimio Ueno, pp. 291–302
  > Supersymmetric Yang-Mills Fields as an Integrable System …, Ling-Lie Chau, pp. 303–328
  > Lax Pairs, Riemann-Hilbert Transforms and Affine Algebras …, Yong-Shi Wu, Mo-Lin Ge, pp. 329–352
  > Massive Kaluza-Klein Theories and Bound States in Yang-Mills, L. Dolan, pp. 353–372
  > Local Charge Algebras in Quantum Chiral Models and Gauge Theories, Itzhak Bars, pp. 373–391
  > Supergeometry and Kac-Moody Algebras, B. Julia, pp. 393–409
  > **The Virasoro algebra** — **A Proof of the No-Ghost Theorem Using the Kac Determinant,
  >   Charles B. Thorn, pp. 411–417**
  > Conformal Invariance, Unitarity and Two Dimensional Critical Exponents,
  >   Daniel Friedan, Zongan Qiu, Stephen Shenker, pp. 419–449
  > Vacuum Vector Representations of the Virasoro Algebra, A. Rocha-Caridi, pp. 451–473
  > Classical Invariant Theory and the Virasoro Algebra, Nolan R. Wallach, pp. 475–482
- 备注：**这份篇目表本身是本轮对 lead 最有价值的情报之一**（任务书逐字说「知道里面有哪些文章
  本身就是有价值的情报」）。两条与本图其它线相关的旁支发现（**不承载断言 (2)**，仅供 lead 排期）：
  · **Thorn, "A Proof of the No-Ghost Theorem Using the Kac Determinant", pp. 411–417** ——
    本图 `worldsheet.kac-determinant` 与无鬼定理链上，这是一篇**用 Kac 行列式证无鬼定理**的
    一手文献（比 Lian–Zuckerman 1991 早六年）。正文同样付费墙（见 E1.3），但**存在**这一事实
    此前本图未登记。
  · **Frenkel–Lepowsky–Meurman, "A Moonshine Module for the Monster", pp. 231–273** ——
    这是 FLM 1988 专著的会议版前身；若日后要追 FLM Ch.8 的历史源头，这是同一批作者在
    **1983 年**的公开陈述版本（同样付费墙）。

### E1.2 ★ 读到的一手正文：Lepowsky 的卷首 Introduction（pp. 1–13）全文 L1
- 位置：MSRI vol. 3, pp. 1–13。获取渠道：**Springer 官方免费章节 PDF**
  `https://link.springer.com/content/pdf/10.1007/978-1-4613-9550-8_1.pdf`（HTTP 200，
  `application/pdf`，1 188 652 字节，Springer 自家 1984 camera-ready 扫描 + OCR）。**L1。**
  这是本轮**唯一**拿到正文的 MSRI vol.3 篇目。
- 类型：（综述性导言；本条目对判据而言是**否定性证据**）
- 原文陈述（逐字，第 1 页第一段末尾，本轮最关键的一句）：
  > A central theme in this volume is the construction of affine Lie algebras using formal
  > differential operators called vertex operators, which originally appeared in the dual-string
  > theory. **Since the precise description of vertex operators, in both mathematical and physical
  > settings, requires a fair amount of notation, we do not attempt it in this introduction.**
  > Instead we refer the reader to the papers of Mandelstam, Goddard-Olive, Lepowsky-Wilson
  > and Frenkel-Lepowsky-Meurman.
- 另一处逐字（p. 5，讲 Goddard–Olive 那篇做了什么）：
  > Using the vertex operators of the string model, I. B. Frenkel and Kac [11] and independently
  > G. Segal [54] found a second construction of the affine algebras of types A_n^{(1)}, D_n^{(1)},
  > E_n^{(1)} as operators on their basic modules (the "homogeneous picture"; here the automorphism
  > is the identity, and the algebras are untwisted). In particular, the commutators of both kinds
  > of vertex operators (using suitable parameters) "close up" to form affine Lie algebras.
  > **In the article of Goddard-Olive, the latter construction is extended to arbitrary integral
  > lattices.**
- 另一处逐字（front matter 的 PREFACE 末段，p. vi，编者自述导言的功能）：
  > We have provided an introduction to help the reader with terminology, notation and historical
  > perspective.
- 文献自称的严格程度：导言／历史综述，无定理、无证明，作者自陈「reflects our own understanding」。
- 文献列出的依赖：[11] Frenkel–Kac；[54] Segal；[37] 作者早前的详细综述；[29] 另一视角。
- 备注（对三条判据逐条裁定）：
  - **判据 1（写出物理侧对象 + 正规序）：不满足。** 全文（608 行 pdftotext）关键词扫描
    `normal order` / `normal-order` / `:e^` / `X(z)` / `exp(` **零命中**；`Fock` 只出现一次
    （p. 4，散文，讲 "a Lie algebra of operators on a Fock space"，无公式）。编者在正文里
    **逐字声明不写记号**（上面第一条引文），这不是抽取者的推断，是原文措辞。
  - **判据 2（与 VOA 结构映射 Y(e^α,z) 划等号）：不满足。** 全文无 `Y(·,z)` 记号，
    也不可能有——见 E1.4 的日期论证。
  - **判据 3：不适用**（判据 1、2 均已失败）。
  - ⭐ 但**这条否定证据的性质与前三轮不同，值得 lead 注意**：这是**这一卷的编者本人**，
    在**唯一一篇以「统一术语与记号」为自觉任务的文章**里（PREFACE 逐字说导言是为
    "terminology, notation and historical perspective" 而写的），**明确选择不写下那套记号**。
    也就是说：1983 年那场「物理学家与数学家当面对记号」的会议，其**官方记号协调文本**
    本身就把记号对照工作**外包给了各篇原文**，没有在任何一处做成一条可引用的等式。

### E1.3 Goddard–Olive pp. 51–96 与 Mandelstam pp. 15–35 的正文：访问失败，维持 L0
- 位置：N/A（记录访问过程）
- 类型：（方法论记录，逐条渠道成败）
- 逐条渠道与结果：
  1. **SLMath（前 MSRI）官方电子图书馆** `library.slmath.org/books/`：HTTP 200，L1 读取索引页。
     **该站只托管 Book28–Book72**（即 Cambridge University Press 时期的卷），vol. 3 无目录。
     `library.slmath.org/books/Book3/` → **404**；猜测式 PDF 路径
     `.../Book3/MSRI-v3-Lepowsky-Mandelstam-Singer.pdf`、`.../Book3/files/MSRI-v3.pdf` → 均 **404**。
     `www.msri.org/publications/books/` 302 → `slmath.org/publications/books/`（现代站点，无早期卷 PDF）。
  2. **SLMath「Early Volumes」总表** `library.slmath.org/books/masterlist.html`：HTTP 200，L1。
     逐字列出 Springer 时期 vol. 1–27 全部书名（vol. 3 = "Lepowsky, Mandelstam, and Singer
     (editors): Vertex Operators in Mathematics and Physics"），但**整页只有一个 PDF 链接**：
     `Book18/MSRI-v18-Bryant-Chern-et-al.pdf`（Exterior Differential Systems）。
     对照测试确认该 v18 链接 **HTTP 200 可下载**，即「早期卷在 SLMath 有免费 PDF」这条线索
     **确实存在但只对 vol. 18 成立**，vol. 3 **没有**。⭐ 这条是本轮对任务书访问线索的**直接证伪**
     （任务书：「早期 MSRI Publications 卷在 library.slmath.org 常有免费 PDF。先查这条」）。
  3. **Springer 卷页与章节页**：卷页 200（TOC 已取，见 E1.1）。
     章节页 `link.springer.com/chapter/10.1007/978-1-4613-9550-8_5`（Goddard–Olive）200，
     **摘要可读（L1，见 E1.5）**，但正文逐字写 "This is a preview of subscription content,
     log in via an institution to check access"，且 Preview 区块逐字写
     "**Unable to display preview. Download preview PDF.**"（即连 Springer 惯常的前两页预览
     都没有——1985 年扫描件无预览层）。
  4. **Springer 章节 PDF 直链实测**（`link.springer.com/content/pdf/10.1007/978-1-4613-9550-8_N.pdf`）：
     - `_1`（Lepowsky Introduction）→ **200, application/pdf, 1.19 MB，成功**（= E1.2）；
     - `bfm:.../1`（front matter）→ **200, application/pdf, 628 KB，成功**；
     - `_2`（Mandelstam）、`_5`（Goddard–Olive）、`_6`（Lepowsky–Wilson）、`_12`（FLM Moonshine）、
       `_20`（Thorn no-ghost）→ 全部 **200 但 `content_type: text/html`**（即被重定向回付费墙落地页，
       非 PDF）。**结论：Springer 对本卷只开放 front matter + 第 1 章（Introduction），其余全付费墙。**
  5. **archive.org / OpenLibrary**：`archive.org/advancedsearch.php` 按
     `title:("Vertex Operators in Mathematics and Physics")` 查询 → **numFound: 0**（无任何条目，
     连 CDL 借阅记录都没有）。
  6. **INSPIRE-HEP**（record 196485，`Goddard:1983xxx`）：确认 Goddard–Olive 该文预印本号
     **DAMTP-83/22**，且 `documents` 与 `urls` 字段**均为空**（INSPIRE 未托管全文亦无外链）。
     另记录逐字：该文后**重印**于 `IN *GODDARD, P. (ED.), OLIVE, D. (ED.): KAC-MOODY AND VIRASORO
     ALGEBRAS* 210-255` —— 即第二轮已实测被 Cloudflare 全站拦截的 World Scientific 重印文集
     （`10.1142/0485`）。**故重印路线与第二轮的失败是同一条防线，无新出路。**
  7. **CERN Document Server**（`cds.cern.ch/search?p=DAMTP-83-22&of=hx`）：返回第二轮已记录的同一份
     **Anubis 反爬挑战页**（`<title>Making sure you're not a bot!</title>`，7495 字节），未穿透。
  8. **Google Books API**（`googleapis.com/books/v1/volumes?q=intitle:"Vertex Operators in
     Mathematics and Physics"`）：**HTTP 429**——与第二轮记录的 Google Books 环境故障一致，
     **本轮同样未能执行任何带控制组的页码定位查询**。这是环境噪声，不是文献不可得的证据。
  9. **INSPIRE 附带发现**：Olive 另有 *LECTURES ON ALGEBRAS, LATTICES AND STRINGS*
     （record 240971，Trieste 1986 *Supersymmetry, Supergravity, Superstrings '86* 论文集 pp. 239–256，
     18 页，单作者 Olive）。INSPIRE 的 `documents`/`urls` 同样为空；该论文集亦由 World Scientific
     出版，按渠道 6 的同一防线判断大概率同样不可得，**本轮未单独发起下载请求**（如实标注为未尝试）。
- 备注：**Goddard–Olive pp. 51–96 与 Mandelstam pp. 15–35 正文本轮维持完全 L0。**
  这是「没拿到」，**不是**「读了没有」。

### E1.4 结构性论证：MSRI vol. 3 在**日期上**不可能满足判据 2（供 lead 权衡残余风险）
- 位置：（推理，基于 E1.1 的出版信息与本图既有的文献年表）
- 类型：（抽取者的结构性分析，**明确标为推断，非核实**）
- 备注：会议 1983-11；front matter 逐字记 "The camera-ready manuscript of this book was received
  by Springer-Verlag in **October, 1984**"；出版 1985。而 **Borcherds 的顶点代数公理是 1986**
  （PNAS 83: 3068–3071），**FLM 的 `Y(v,z)` 结构映射记号是 1988**。因此 MSRI vol. 3 的任何一篇
  都**不可能**含有「独立公理化的 VOA 结构映射 `Y(e^α,z)`」这一半——判据 2 在这一卷里
  **结构上无对象可指**。这与第一轮对 `frenkel-1985` 的裁定（E3：「该文写于 VOA 公理化之前，
  是两套写法分裂**之前**的共同祖先」）**是同一条论证**，且 Frenkel 1985（Lectures in Applied
  Mathematics 21）与本卷是**同一时期、同一学术场合群**的产物。
  ⚠ **这条论证的限度（必须诚实说明）**：它排除的是「判据 2 的严格形式」，**不排除**
  Goddard–Olive pp.51–96 里可能写下了「物理侧正规序指数 ↔ Frenkel–Kac/Segal 式格点顶点算子」
  的某种**记号对照**（那将是一条历史上有价值、但按本项目判据 3 仍属「同一构造的记号改写」的
  陈述，正是 Gebert 1993 的失败模式）。**由于正文未获取，这一点无法证实也无法证伪。**

### E1.5 Goddard–Olive 摘要（L1，Springer 章节页公开摘要）——支持 E1.4 的间接证据
- 位置：`link.springer.com/chapter/10.1007/978-1-4613-9550-8_5`，Abstract 区块，L1
- 类型：（摘要；非正文，不承载任何判据裁定）
- 原文陈述（逐字，全文摘录）：
  > A unified construction is given of various types of algebras, including finite dimensional Lie
  > algebras, affine Kac-Moody algebras, Lorentzian algebras and extensions of these by Clifford
  > algebras. This is done by considering integral lattices (i.e. ones such that the scalar product
  > between any two points is an integer) and associating to the points of them the square of whose
  > length is 1 or 2, **the contour integral of the dual model vertex operator for emitting a
  > "tachyon"**. If the scalar product is positive definite, the algebra of these quantities
  > associated with the points of length 2 closes, when the momenta are included, to form a finite
  > dimensional Lie algebra. If the scalar product is positive semi definite, this algebra closes to
  > an affine Kac-Moody algebra when the vertex operators for emitting "photons" are added. If the
  > scalar product is Lorentzian, the algebra closes if the vertex operators for all the emitted
  > states in the dual model are added. Special lattices in 10, 18, and 26 dimensional Lorentzian
  > space are discussed and implications of the dual model no ghost theorem for these algebras are
  > mentioned. This framework links many physical ideas, including concepts in magnetic monopole
  > theory and the fermion-boson equivalence as well as the dual model. (Knowledge of dual models is
  > not assumed but familiarity with aspects of the theory of Lie algebras is presumed in the latter
  > part of this paper.)
- 备注：摘要逐字表明该文的构造对象是**「对偶模型的顶点算子」的围道积分**——即**只有物理侧**，
  用物理侧对象直接造出李代数，**摘要里没有出现第二套（代数侧公理化的）顶点算子对象**。
  这与 E1.4 的日期论证方向一致（Frenkel 1985 型失败模式），但**摘要不能替代正文**，
  只作为「该文大概率与 Frenkel 1985 同型」的**间接**支持，**不作为判据裁定的依据**。
  ⚠ 顺带：摘要提到 "implications of the dual model no ghost theorem"，与本图无鬼定理线相关，
  但同样只是摘要，不可引为来源。

### 小结（候选 1 → 断言 (2)）

**(C) 部分：一篇读到底（判定不承载），两篇仍 L0。**
- **Lepowsky, Introduction, pp. 1–13：L1 读到底，判据 1、2 均不满足，不承载。**
  且其否定证据质量高于「没写」——是编者**逐字声明不写**（E1.2）。
- **Goddard–Olive, pp. 51–96：完全 L0**（九条渠道逐条实测，见 E1.3）。
  仅有摘要（E1.5）与日期结构论证（E1.4）作间接旁证，**两者都不足以下「读了没有」的裁定**。
- **Mandelstam, pp. 15–35：完全 L0**，同上。
- ⭐ **任务书对本候选的核心访问假设被直接证伪**：SLMath 官方电子图书馆**不**托管 vol. 3
  （只从 vol. 28 起，且早期卷中只有 vol. 18 有免费 PDF）。但**意外收获**是 Springer 开放了
  front matter + Introduction 两份一手材料，使本候选从「零进展」变成「拿到了这一卷唯一那篇
  以统一记号为职责的文章，并确认它明确拒绝写记号」。

---
