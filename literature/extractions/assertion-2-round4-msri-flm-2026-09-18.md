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

## 候选 2：FLM 1988 *Vertex Operator Algebras and the Monster* 第 8 章的**后续论文转引路线**

任务书本轮明令**不再试图拿原书**（前两轮五渠道全败，见第一轮 E11），改为寻找
「后续论文里逐字转引 FLM (8.x.x) 公式」的段落。以下 E2.1–E2.5 是本轮沿这条路线的全部结果。

### E2.1 ★ Andrew Ogg 的 Bull. AMS 书评（L1 全文）——**二手但一手引用的**「FLM 的 Y(e^α,z) 长什么样」
- 文献：Andrew Ogg, *Review: Igor Frenkel, James Lepowsky and Arne Meurman,* Vertex Operator
  Algebras and the Monster, **Bull. Amer. Math. Soc. (N.S.) 25 (1991), no. 2, 425–432**，
  DOI `10.1090/S0273-0979-1991-16086-6`。新登记 bib key `ogg-1991`。
- 获取：AMS 自家 Bulletin 免费 PDF（AMS 对 Bulletin 全刊开放），本轮下载成功，
  **8 页、697 036 字节，`Read` 工具逐页渲染核对，L1**。
  ⚠ 同一 URL 在本轮稍后复测返回 **HTTP 403**（疑为 AMS 速率限制），Project Euclid 侧的
  `.../bams/1183657192.full` 页面标注为订阅内容。**如需复核请从 DOI 走 AMS 官方入口。**
- 位置：**p. 430**（本条引文全部出自这一页；已用 `Read` 直接渲染页图核对，未只信 pdftotext）
- 类型：（书评中的转述；**不是 FLM 原文**，是 FLM 同时代同行对 FLM 第 8 章构造的公开转述）
- 原文陈述（逐字，`°...°` 表示原书评排版中的「开口冒号」正规序记号）：
  > … The *current* defined by `α ∈ 𝔥` is `α(z) = Σ_{n∈Z} α(n) z^{-(n+1)}`, where the action of
  > `α(0)` on `V_L` is suitably defined. Then, **very roughly, the vertex operator `Y(u, z)` of a
  > "constant" vector `u = e^α` is** `°e^{∫α(z)dz/z}°` **where the open colons denote *normal
  > ordering*, in which the operators indexed by `n < 0` are placed to the left of those indexed by
  > `n > 0` (and we ignore here the considerable work required to deal with the case `n = 0`).**
  > This notion of normal ordering is required in order to make the operator well defined (sums must
  > be finite) and has many pleasant algebraic consequences; it is used frequently throughout the
  > book. The definition is extended to general `u ∈ V_L` so that replacing `u` by `β(-m)·u` replaces
  > `Y(u, z)` by `°(1/(m-1)!)(d/dz)^{m-1} β(z) Y(u, z)°`.
- 另一处逐字（p. 429）：
  > **The treatment in the book is entirely algebraic**; `z` is a formal variable, and there is no
  > notion of convergence in `F` or in `V`.
- 全篇唯一涉及物理的句子（逐字）：
  > It seems that the theory of vertex algebras is equivalent to 2-dimensional conformal field
  > theory; the Monster is the symmetry group of a particular conformal field theory and would have
  > been discovered by physicists if the group theorists had not found it first.
- 文献自称的严格程度：书评，作者自陈 "very roughly"、"we ignore here the considerable work
  required to deal with the case `n = 0`"——**明确声明是粗略转述、且刻意略过零模那一段**。
- 文献列出的依赖：FLM 原书（无具体章节号）。
- 备注（三条判据逐条裁定）：
  - **判据 1：不满足。** 有正规序记号（开口冒号）与模展开 `α(z)`，但 `α` 是格点/Heisenberg
    抽象元素，**没有 `X^μ(z)`、没有时空指标 `μ`、没有任何弦论场记号**；
    全篇唯一的物理句子（上引）是散文式的「顶点代数似乎等价于二维 CFT」，正是判据 1 逐字排除的
    「散里提一句 free bosonic CFT 不算」那类。
  - **判据 2：形式上有 `Y(u,z)`，但等号右边是同一构造的正规序指数展开，不是物理侧独立对象。**
  - **判据 3：不满足，而且是本轮最有价值的一条否定情报**——书评逐字说这是 FLM 对
    `Y(e^α, z)` 的**定义**（"The definition is extended to general `u ∈ V_L` …"），
    即 FLM 是**先用正规序指数把 `Y(e^α,z)` 定义出来**，再往一般 `u` 上延拓。
    **若此转述忠实，则 FLM 第 8 章里「正规序指数 = `Y(e^α,z)`」是 `:=` 而非跨框架恒等式**，
    与 Nikolov–Todorov 2004 的失败模式（判据 3）**同型**。
  - ⚠ **这条裁定的强度限制（必须写明）**：书评是**二手转述**（本项目 L 级里属 L3 的内容、
    但载体本身是 L1 读到的一手出版物）。Ogg 自己说 "very roughly"。
    **它不能替代 FLM 正文**，只能把「FLM 第 8 章大概率是定义式而非识别式」的置信度从
    「完全未知」提到「有同时代同行的公开转述支持」。**FLM 正文仍为 L0。**

### E2.2 从 Rosellen 的讲义回收到的 FLM 第 8 章**编号**（L3，编号而非公式）
- 文献：Markus Rosellen, *A Course in Vertex Algebra*, arXiv:math/0607270（L1 全文下载，
  `pdftotext` 11 365 行）。**本轮不登记 bib**（只用作编号来源，未从中取任何陈述）。
- 位置：该讲义正文多处对 [FLM88] 的引用。
- 类型：（元信息，二手编号转引）
- 原文陈述（逐字摘引用句片段）：
  > "… in detail [FLM88], sections **2.1–2.2 and 8.1–8.3**."
  > "… this result for lattice vertex algebras [FLM88], **Remark 8.9.1**."
  > "… invariant, symmetric bilinear form [FLM88], **Theorem 8.9.5**."
  > "… rational functions in one and several variables [FLM88], equations **(8.1.5), (8.1.6), and
  >   (8.10.37)**."
  > "… [FLM88], **section 8.10**. It is the main axiom in their definition of a vertex …"
  > "… `L_0` [FLM88], equations **(8.10.23) and (8.10.32)**, [FHL93], Definition 4.1.1."
- 备注：本项目此前连 FLM 第 8 章的**小节标题**都未取得（第一轮 E11）。本条把已知的 FLM 第 8 章
  编号从「无」扩充到 **§8.1–8.3、Remark 8.9.1、Theorem 8.9.5、§8.10、(8.1.5)、(8.1.6)、
  (8.10.23)、(8.10.32)、(8.10.37)**。这是 **L3（二手转抄编号）**，**不是公式内容**——
  **没有任何一条被转引的 FLM 公式正文被本轮找到**。对断言 (2) **不承载**，
  仅供日后若拿到原书时直接翻页定位。

### E2.3 ⚠ 重要纠偏：Dong–Mason–Nagatomo math/0004132 **并没有**说「FLM 没写明公式」
- 文献：C. Dong, G. Mason, K. Nagatomo, *Quasi-modular forms and trace functions associated to
  free boson and lattice vertex operator algebras*, arXiv:math/0004132v1（L1 全文，932 行）。
  **本轮不登记 bib**（不承载任何断言）。
- 位置：§4.1 "Vertex operator algebras associated to lattices"，PDF 第 10–11 页。
- 类型：（判据核对 + 对检索摘要的纠偏）
- 原文陈述（逐字）：
  > **We now work in the setting of Chapter 8 of [FLM].** In particular, `L` is a positive definite
  > lattice, and `𝔥 = L ⊗_Z C`. Let `C[L]` be the group algebra with a basis `{e^α | α ∈ L}`. Then
  > the vertex operator algebra `V_L` associated to `L` is `V_L = M(1) ⊗ C[L]` as vector spaces.
  > The vertex operator `Y(v, z)` for `v ∈ M(1)` is defined as in the case of `M(1)`
  > (see formulas (3.1.1) and (3.1.2)). … **For the purposes of this paper we do not make explicit
  > the expression for vertex operators `Y(v, z)` for general `v` except for those `v ∈ M(1)`.**
- 备注：
  - ⚠ **纠偏**：本轮检索后端（WebSearch 摘要）把最后这句转述成「该文指出 FLM 那里没有把顶点算子
    的显式表达式写明」。**逐字核对后为误**——主语是 **"this paper"（即 Dong–Mason–Nagatomo
    自己）不是 FLM**。作者说的是**他们自己**这篇文章用不着写显式公式，**没有**对 FLM 第 8 章
    是否写了公式作任何陈述。**这是本轮发现的一处检索摘要曲解，记录在案以免日后被引为「FLM 没写」
    的伪证据。**
  - 该文本身：`Y(v,z)` 对 `v ∈ M(1)` 的公式在 (3.1.1)/(3.1.2)，是纯 VOA 侧展开
    （`a(z) = Σ a(n) z^{-n-1}`，正规序乘积），**全文无 `X^μ(z)`、无弦论记号**。
    判据 1 不满足，**不承载**。
  - 附带正面价值：这是本轮找到的**唯一**一篇逐字写出「我们在 FLM 第 8 章的设定下工作」并
    紧接着把该设定的**基本数据**（`V_L = M(1) ⊗ C[L]`、`a(0)e^β = (a,β)e^β` (4.1.1)）
    复述出来的论文——**可作为 FLM 第 8 章设定的 L3 转引**，但它复述的是**设定**，不是断言 (2)
    需要的那条公式。

### E2.4 Runkel arXiv:1209.5554 §3.3：结构最接近、但两条判据同时失败
- 文献：Ingo Runkel, *Algebra in Braided Tensor Categories and Conformal Field Theory*
  （本轮 L1 下载）。**本轮不登记 bib**。
- 位置：§3.3（自由玻色子 / Heisenberg VOA 与格点扩张），Definition 3.1、(3.28)、Lemma 3.6、
  Theorem 3.12。
- 备注：形式上**是对的形状**——先抽象公理化地定义一个对象，再显式构造一个对象，再证明二者一致。
  但：**判据 1 不满足**（全文只有模 `J_m` 与抽象正规序，**没有 `X^μ(z)`、没有物理冒号指数**）；
  **判据 2 不满足**（没有格点结构映射 `Y(e^α,z)` 这一半）。**不承载。**
  登记于此是为了给 lead 一个「数学侧确实存在'两个独立构造再证相等'这种写法」的对照样本——
  缺的从来不是数学写法，缺的是**把物理侧记号也写进来**的那一半。

### E2.5 转引路线的渠道汇总与结论
- 本轮为找「逐字转引 FLM (8.x.x) 公式」执行的检索：
  1. arXiv 全文检索式关键词组合（`"Chapter 8 of [FLM]"`、`FLM` + `(8.4.` / `(8.6.` 等编号、
     `Frenkel-Lepowsky-Meurman` + `normal ordering`）→ 命中 **math/0004132**（见 E2.3）；
     其余命中均为只引章节号不抄公式的常规引用。
  2. VOA 教科书/讲义级材料逐份下载核对：Dong q-alg/9504017（*Introduction to VOA I*）、
     Lepowsky arXiv:0706.4072、Runkel 1209.5554、Rosellen math/0607270、Bakalov 1502.04756
     —— **五份全部 L1 拿到全文**，**无一份逐字转抄 FLM 第 8 章的格点顶点算子公式**；
     Rosellen 只给编号（E2.2），其余只给自己的记号版本。
  3. 同时代书评 → 命中 Ogg 1991（E2.1），是本路线唯一拿到「FLM 的 `Y(e^α,z)` 长什么样」的
     公开转述。
- **结论：转引路线本轮「有产出但不命中」。** 产出是 E2.1 的定性情报（FLM 是**定义式**）
  与 E2.2 的编号；**没有找到任何一篇论文把 FLM 第 8 章那条公式逐字抄出来**，
  因此**没有任何二手 L1 证据能支撑「FLM 第 8 章承载断言 (2)」**。
  **FLM 第 8 章正文维持完全 L0**（第一轮 E11 的结论不变）。

---

## ★★★ 候选 4（意外命中，不在任务书名单）：L. M. Grotenhuis, *Vertex Algebras and String
Theory in Monstrous Moonshine*, Leiden 大学**本科（BSc）**毕业论文，2020-06-19，127 页。
新登记 bib key `grotenhuis-2020`。

**发现方式**：在候选 2 的转引路线上做 WebSearch（关键词组合含 `FLM` / `lattice vertex operator` /
`normal ordering` / `string`）时，检索后端带出 `stat.ucla.edu/~ywu/moonshineString.pdf` 这一公开镜像，
遂下载核实。**这不是任务书三个候选中的任何一个。**

**获取与 L 级**：官方托管 `studenttheses.universiteitleiden.nl/handle/1887/123029`（Leiden 学生论文库，
公开可获取，符合 `literature/CLAUDE.md` 规则 1「公开可获取的文献」）；本轮实际下载自公开镜像
`stat.ucla.edu/~ywu/moonshineString.pdf`（HTTP 200，6 396 181 字节）。
**L1：全文 `pdftotext -layout` 5993 行，并对两处承载页（p. 54 与 p. 106）用 `Read` 工具
直接渲染 PDF 页图逐字核对**（按任务书纪律：凡逐字引用公式必须看页图，不能只信 pdftotext——
本轮这条纪律**确实救了命**，见 E4.3 的 `e^α` 因子）。

⚠ **来源性质先说清楚**：这是一份**本科毕业论文**，指导教师 Prof. dr. K. E. Schalm（Leiden 弦论/
凝聚态）与 Dr. R. I. van der Veen（数学）。它**不是同行评议出版物**，没有期刊或 arXiv 编号。
它公开、可引、可核，但**证据分量应当低于任何一篇已发表论文**。这一点 lead 必须在裁决时纳入。

### E4.1 物理侧对象：闭弦顶点算子与模展开（判据 1）
- 位置：**p. 106，(6.3)–(6.5)**，§6.1 "String diagrams and vertex operators"
- 类型：definition（物理侧构造，承第 4–5 章的 Polyakov 作用量量子化而来）
- 原文陈述（逐字，已用页图核对）：
  > For a string state `|k⟩` of momentum `k`, the corresponding vertex operator is given by
  >
  > `V_k(z, z̄) = :e^{ikX(z,z̄)}:`   (6.3)
  >
  > where
  >
  > `X(z, z̄) = x_0 - iα'p ln|z|² + i√(α'/2) Σ_{n≠0} (1/n)(α_n z^{-m} + ᾱ z̄^{-n}).`   (6.4)
  >
  > Note that the above expression can be obtained from our general solution for the closed string
  > given in (5.10) by setting `z = e^{i(τ+σ)}` and `z̄ = e^{i(τ-σ)}`, and assuming `τ` to take
  > imaginary values. In particular, we obtain
  >
  > `X_L(z) = x_0^L - iα'p ln z + i√(α'/2) Σ_{n≠0} (1/n) α_n z^{-m}.`   (6.5)
- 文献自称的严格程度：物理推导（由第 5 章 (5.10) 的闭弦通解 + Wick 转动得到），非公理化。
- 文献列出的依赖：(5.10)（闭弦模展开）；脚注 ‡ 说明 Wick 转动 `τ = -it`。
- 备注：**判据 1 满足。** 这是四轮检索里**第一次**同时出现：显式 `X(z,z̄)` 的完整模展开
  （含 `x_0`、`α'p ln|z|²` 零模项、`α_n` 振子）**与** 冒号正规序记号 `: :`，
  且明确来自世界面作用量而非抽象 Heisenberg 代数。
  ⚠ **印刷错误（本轮页图核对发现）**：(6.4) 与 (6.5) 的求和项写作 `α_n z^{-m}`，
  按上下文应为 `z^{-n}`（求和指标是 `n`，`m` 从未定义）；(6.4) 的反手征项写作 `ᾱ` 漏了下标 `n`。
  这两处是笔误，不影响内容。

### E4.2 ★ 识别句：判据 2 与判据 3 的承载处
- 位置：**p. 106，(6.6) 与紧随其后的一句**
- 类型：**identification / proposition（正是本卡断言 (2) 所要的那种「跨框架恒等式」）**
- 原文陈述（逐字，已用页图核对）：
  > and thus
  >
  > `:e^{ikX_L(z)}: = e^{ikx_0^L} z^{α'kp} e^{-k Σ_{n<0} (α_n/n) z^{-n}} e^{-k Σ_{n>0} (α_n/n) z^{-n}}.`   (6.6)
  >
  > **We recognise this expression as the lattice vertex operators `Y(|α⟩, z)` given in (3.15).
  > In this way, our mathematical definitions in chapter 1 describe the chiral (i.e. left-moving)
  > vertex operators in string theory.**^§
- 脚注 §（逐字，**作者自陈的假设**）：
  > Recall that the reconstruction theorem from chapter 2 implies that the vertex operators
  > `Y(|α⟩, z)` determine the vertex operators of the whole state space. **Assuming that the 'string'
  > vertex operators `V_A(z, z̄)` satisfy the vertex algebra axioms as well**, we obtain that not just
  > the pure momentum vertex operators (as given by (6.3)) but also the vertex operators of the
  > oscillator states correspond to the 'mathematical' lattice vertex operators.
- 文献自称的严格程度：**"We recognise this expression as …"**——即**肉眼识别**。
  没有逐项比对系数，没有证明，没有说"one checks that"。附带的脚注把从纯动量态推广到振子态
  的那一步**明确标注为假设**（"Assuming that …"）。
- 文献列出的依赖：(3.15)（第 3 章独立构造的格点结构映射，见 E4.3）；第 2 章重构定理。
- 备注：**这是四轮检索中第一次出现「物理侧显式正规序指数」与「VOA 结构映射 `Y(|α⟩,z)`」
  之间的一个真正的等号，且两侧是独立构造的。判据 2 满足，判据 3 在形式上也满足。**

### E4.3 等号右边确系**独立构造**（判据 3 的核查）
- 位置：**p. 51–54，(3.11)–(3.15) 与 Theorem 3.4 / Theorem 3.5**，§3.2 "Vertex algebras
  associated to a lattice"
- 类型：proposition（构造定理）
- 原文陈述（逐字，**已用页图核对**）：
  > **Theorem 3.4.** There exists a conformal vertex algebra structure on `V_L` with vacuum vector
  > `|0⟩` and conformal vector `ω` as defined in (3.5) and such that for each `a ∈ 𝔤` we have
  > `Y(a_{-1}|0⟩, z) = a(z)`, if and only if for each `α ∈ L` there exists an operator `c_α` that
  > commutes with every `a_n` (for all `a ∈ 𝔤, n ∈ Z`) such that these operators satisfy
  > `c_α|0⟩ = |0⟩`, `c_0 = id` and (3.14). In this case, the mapping
  >
  > `Y(|α⟩, z) = e^α c_α z^{α_0} e^{-Σ_{n<0} (α_n/n) z^{-n}} e^{-Σ_{n>0} (α_n/n) z^{-n}}.`   (3.15)
  >
  > for `α ∈ L` defines a vertex algebra structure on `V_L`.
  >
  > (3.14):  `e^α c_α e^β c_β = (-1)^{(α,β)} e^β c_β e^α c_α.`
- 文献自称的严格程度：**完整证明**。§3.2 从 (3.10) 的对易子出发，定义辅助场 `X_α(z)`（(3.11)）、
  证明 Lemma 3.2（`[a_n, X_α(z)] = 0`）、用真空公理与**局域性公理**（(3.13) 的
  `f_α(z)f_β(w) = e^α c_α e^β c_β z^{α_0} w^{β_0} (z-w)^{(α,β)} S^{α(z),β(w)}` 计算）
  推出充要条件 (3.14)，再由 Theorem 3.5（引 [Kac97] 推论 5.5）给出 `c_{α,β}` 解的存在唯一性。
  **这是从 VOA 公理出发、与任何弦论输入无关的独立构造。**
- 文献列出的依赖：Lemma 3.3（引 [LL04] (6.3.46)）；Theorem 3.5 引 [Kac97] Corollary 5.5。
- 备注：⚠ **`pdftotext` 把 (3.15) 最左边的 `e^α`（平移算符）整个吞掉了**，只剩 `c_α z^{α_0}…`。
  若只信文本抽取，就会得到「(3.15) 与 (6.6) 逐项对应得天衣无缝」的错误结论。
  **用 `Read` 渲染页图才看到 `e^α c_α` 是两个因子**——这一点正是 E4.4 那条缺口的要害。

### E4.4 ⚠ 这条识别的四个缺口（作者未处理，本条目逐条列出，**不做推断只做对照**）
- 位置：对照 E4.2 与 E4.3 的两条公式，以及本卡【本卡明确不断言】(b)(c)
- 类型：（判据与接缝核对，非文献陈述）
- 备注（逐条）：
  1. **cocycle 被静默跳过。** (3.15) 的零模因子是 **`e^α c_α`**（平移算符 × cocycle 算符），
     且 Theorem 3.4 逐字要求它满足 (3.14) `e^α c_α e^β c_β = (-1)^{(α,β)} e^β c_β e^α c_α`。
     (6.6) 的物理侧零模因子只有 **`e^{i k x_0^L}`** 一个。作者在 "We recognise …" 一句里
     **没有提到 `c_α`**，也没有讨论 `e^{ikx_0^L}` 是否满足 (3.14)。
     ⭐ **这恰好落在本卡断言 (1) 的位置上**：断言 (1) 说的正是「秩 1 类光格上 cocycle 平凡
     （`ε(mk,nk)=1`）」。换句话说，Grotenhuis 的识别在**一般偶格**上有一个未处理的 cocycle 缺口，
     而本卡断言 (1)（已有 Gebert–Nicolai 1995 §3.1 与 Li–Wang 2008 §4 两条 L1 来源）
     **正是把这个缺口在秩 1 类光格情形下补上的那一步**。
     （本条只陈述两者位置重合这一**事实对照**；「补上之后是否就完整」属于 curator/prover 的判断，
     researcher 不越权下结论。）
  2. **连续动量 ↔ 离散格（本卡接缝 (b)）未处理。** (6.3) 逐字写 "For a string state `|k⟩` of
     momentum `k`"，(6.4) 的 `p` 是连续动量算符；而 (3.15) 要求 `α ∈ L` 是格点。
     作者在 (6.6) 之后**没有**说明 `k` 何时落在格里（第 5.4 节的环面紧化确实把动量离散化，
     但 §6.1 的 (6.3)–(6.6) **没有**声明自己处在紧化设定下）。
  3. **`δ` 归一化（本卡接缝 (c)）完全未提。**
  4. **格的类型不对。** 全文的格是**正定偶格**（第 3.1 节逐字要求 "`L` is even and positive
     definite"，最终用的是 24 维 Leech 格）。**本卡要的是秩 1 类光格与动量塔 `T(p;k₀)`**——
     那是**不定（洛伦兹）**签名下的退化情形，Grotenhuis 的 Theorem 3.4/3.5 的前提（正定偶格、
     `L_0` 的 `N`-分次、特征有限维）**在类光情形下不成立**。
  5. **额外的 `α'` 归一化不自洽（印刷/推导错误）。** 由 (6.5)，`:e^{ikX_L}:` 的振子指数应带
     `√(α'/2)` 因子（`ik · i√(α'/2)(α_n/n)z^{-n} = -k√(α'/2)(α_n/n)z^{-n}`），
     但 (6.6) 右端写的是 `e^{-k Σ (α_n/n) z^{-n}}`，**`√(α'/2)` 不见了**；
     而零模项的 `α'` 却保留着（`z^{α'kp}`）。即 **(6.6) 与 (6.5) 在 `α'` 归一化上内部不自洽**。
     这正好说明「We recognise」那一步**确实没有逐项核对系数**。

### 小结（Grotenhuis 2020 → 断言 (2)）

**(A) 找到了——但带三个必须同时说出口的限定词。**
- **三条判据形式上全部满足**：判据 1（E4.1，显式 `X(z,z̄)` 模展开 + 冒号正规序）、
  判据 2（E4.2，与 `Y(|α⟩,z)` 划等号）、判据 3（E4.3，右端是第 3 章独立用 VOA 公理构造的对象，
  (6.6) 之后的句子是 "We recognise …" 而非 `:=`）。
  **这是四轮、十余篇候选里唯一一次三条全中。**
- **限定词 1：来源分量低。** 本科毕业论文，非同行评议，无 arXiv/期刊编号。
- **限定词 2：论证强度低。** "We recognise this expression as …" 是肉眼识别，
  无逐项系数核对（(6.6) 自身的 `√(α'/2)` 就掉了，见 E4.4(5)），
  推广到振子态那步作者自己标了 "Assuming that …"。
- **限定词 3：命题不是本卡那一条。** 正定偶格（Leech），不是秩 1 类光格；
  cocycle、连续动量↔格、`δ` 归一化三个接缝全部未处理（E4.4）。
- ⭐ **对 lead 的实际意义**：本卡此前的前提是「公开文献里**连这个等式的陈述**都找不到」。
  **这个前提现在被部分推翻了**——等式的陈述是存在的（虽然只在一份本科论文里，
  且只对正定偶格、且只靠肉眼识别）。但「**证明**」这一前提**没有**被推翻：
  Grotenhuis 没有证明它，也没有处理本卡列出的任何一条接缝。
  即：从「查无此陈述」降格为「查无此**证明**，但陈述在一份低分量来源里出现过」。
  这两者对是否开原创轨道的含义不同，**必须由 lead 而非 researcher 裁决**。

---

## 候选 3（任务书标为低优先，本轮为**浅触并如实标注**）：Kac–Raina, *Bombay Lectures on
Highest Weight Representations of Infinite Dimensional Lie Algebras*

bib 中已有两条：`kac-raina-1987`（第 1 版，Adv. Ser. Math. Phys. **2**，World Scientific 1987）
与 `kac-raina-rozhkovskaya-2013`（第 2 版，Adv. Ser. Math. Phys. **29**，2013，新增 Part II
"Vertex algebras"）。**本轮不新登记 bib 条目，只在本抽取记录留档。**

### E3.1 访问渠道逐条实测：正文维持完全 L0
- 位置：N/A（方法论记录）
- 类型：（方法论记录）
- 逐条渠道与结果：
  1. **World Scientific 官方页** `worldscientific.com/worldscibooks/10.1142/8882`（第 2 版）：
     本轮**首次对本候选实测**，返回 **HTTP 403 + Cloudflare 质询页**
     （`<title>Just a moment...</title>`，5513 字节）。
     ⭐ 这把第二轮 E6 的「基于同域名的合理外推」升级为**实测确认**
     （第二轮残余风险第 3 条里明确说这条 L0 结论「比候选 1/2 弱一档」，现已补齐）。
  2. **Kac 本人 MIT 主页** `math.mit.edu/~kac/`：L1 读取。页面只有 CV、出版物列表、
     "Not Easily Available Papers"、Quantum Calculus 勘误表、Google Scholar 五个链接，
     **没有** Bombay Lectures 的任何 PDF。
  3. **Kac 的 "Not Easily Available Papers" 页** `math.mit.edu/~kac/not-easily-available.html`：
     L1 读取并逐条列出全部 6 个 PDF 链接——
     `An algebraic definition of compact Lie groups`、
     `On the question of describing the space of orbits of linear algebraic groups`、
     `Branching functions for winding subalgebras and tensor products`（Kac–Wakimoto 1990）、
     `Representations of quantum groups at roots of 1` I/II、
     `Modular invariance in mathematics and physics`。
     **没有 Bombay Lectures，也没有 2003 年 TIFR 顶点代数讲义**（即第 2 版 Part II 的来源）。
  4. **archive.org**：按 `title:("Bombay Lectures on Highest Weight Representations")`
     advancedsearch → **numFound: 0**。
  5. **非官方整本扫描**（Scribd 上流传的 1988 年印次扫描，文件名带 "18.747"）：
     按 `literature/CLAUDE.md` 规则 1（非官方整本教材扫描不用）**不采信，未下载**。
  6. **MIT OCW**：`ocw.mit.edu/search/?q=18.747` 返回 200（9790 字节搜索页），
     **未见 18.747 课程页或讲义**（该研究生课程未在 OCW 上架）。
- 备注：**正文完全 L0**。这是「没拿到」，不是「读了没有」。
  ⚠ 需要注意的是：即便拿到，判据 1 的前景也不乐观——按出版社与多方书目描述，
  第 1 版的四条主线是 Heisenberg 振子代数 / `gl_∞` 与孤子方程 / 仿射 Kac–Moody / Virasoro
  （Kac 行列式），**第 2 版 Part II 才讲顶点代数**，且两部分都是数学侧语言。
  **但这只是基于书目描述的预期，不是核实结论，不能据此下裁定。**

### E3.2 顺带取得的 Kac 一手材料（与断言 (2) 无关，仅登记发现）
- 位置：Victor G. Kac, *Modular Invariance in Mathematics and Physics*,
  **Proceedings of the AMS Centennial Symposium, August 8–12, 1988**, p. 337 起，AMS 1992
  （14 页，扫描件，`math.mit.edu/~kac/not-easily-available/modular_invariance_in_mathematics_and_physics.pdf`，
  HTTP 200，1 260 292 字节）。
- 类型：（元信息；**浅触，未通读**）
- 备注：**该 PDF 无文字层**（`pdftotext` 输出 0 行），只用 `Read` 渲染了第 1 页确认书目信息。
  第 1 页内容是模函数、Dedekind `η`、配分函数渐近——主题是**特征标的模不变性**，
  **不是**顶点算子记号对照。**本轮未通读，不作任何判据裁定**，仅登记「Kac 主页上有这份公开一手
  材料」这一事实，供日后模不变性相关卡片使用。**这是浅触，如实标注为未读完。**

---

## 旁支情报（不承载断言 (2)，但本轮顺手核实，供 lead 排期）

### E5.1 Thomas Driscoll-Spittler, *Vertex operator expressions for Lie algebras of physical
states*, arXiv:2408.07597v1 [math.QA]（L1 全文，1229 行）
- 摘要逐字：
  > We study the Lie algebra of physical states associated with certain vertex operator algebras of
  > central charge 24. **By applying the no-ghost theorem from string theory** we express the
  > corresponding Lie brackets in terms of vertex algebra operations. In the special case of the
  > Moonshine module this result **answers a question of Borcherds**, posed in his paper on the
  > Monstrous moonshine conjecture.
- 为什么记在这里：该文正文大量使用 `V ⊗ V_{II_{1,1}}`（中心荷 24 + 2 = 26）、
  primitive isotropic element `f ∈ II_{1,1}`、`P_n(α)` 物理态空间、以及无鬼定理——
  **与本图 `worldsheet.no-ghost-theorem-v4` 一线、以及本卡所在的「类光格 / 物理态」语境高度同源，
  且是 2024 年的新文献**，本图此前未登记。
- **对断言 (2) 不承载**：全文是纯 VOA 语言，`: :` 只表示抽象正规序乘积，
  **无 `X^μ(z)`、无冒号指数、无弦论场记号**（判据 1 不满足）。
- **建议（只提建议，不动手）**：lead 可考虑派 curator 把这篇挂到无鬼定理 / Borcherds 代数一线。

### E5.2 Christoph A. Keller, *Vertex Operator Algebras*（课程讲义，
`archive.math.arizona.edu/cakeller/VertexOperatorAlgebras.pdf`，L1 全文 1930 行）
- 第 8 章 "Lattice VOAs"（§8.1 Lattices 起，Theorem 8.6 给出 `(V_L, Y, |0⟩, ω)` 是 VOA）。
- **对断言 (2) 不承载**：全文关键词扫描 `string` / `world-sheet` / `X(z)` / `:e^` **零命中**，
  正规序只以抽象 `:a(z)b(z):` 出现（§ "the notion of normal ordering"）。
  **判据 1 不满足**——作者虽是弦论背景，但这份讲义完全在数学侧写。
- 记录价值：又一个「物理学家写 VOA 讲义时也不写物理侧记号」的实例，
  与第三轮 Gaberdiel hep-th/9910156 的失败模式同型。

---

## 未解决的疑问（原文疑点汇总）

1. **Grotenhuis 2020 的三处印刷/推导错误**（本轮页图核对发现，见 E4.1 与 E4.4(5)）：
   (6.4)、(6.5) 的求和项写作 `α_n z^{-m}`（应为 `z^{-n}`，`m` 全文未定义）；
   (6.4) 的反手征项 `ᾱ` 漏下标 `n`；(6.6) 右端振子指数漏掉 (6.5) 中的 `√(α'/2)` 因子，
   而零模项的 `α'` 保留在 `z^{α'kp}` 中 → **(6.6) 与 (6.5) 在 `α'` 归一化上内部不自洽**。
2. **Grotenhuis 2020 的 cocycle 缺口是作者未自承的**（E4.4(1)）：(3.15) 的零模因子是
   `e^α c_α` 且须满足 (3.14)，(6.6) 只有 `e^{ikx_0^L}`，作者在识别句里对此只字未提。
   与之相对，作者**确实自承**了另一处假设（p.106 脚注 §，"Assuming that the 'string' vertex
   operators `V_A(z,z̄)` satisfy the vertex algebra axioms as well"）。
3. **检索后端的一处曲解已记录在案**（E2.3）：WebSearch 摘要把 Dong–Mason–Nagatomo
   math/0004132 的 "For the purposes of **this paper** we do not make explicit the expression for
   vertex operators `Y(v,z)`…" 转述成「该文指出 **FLM** 没写明」。逐字核对为误。
   **不要把它引为「FLM 第 8 章没写公式」的证据。**
4. **Ogg 1991 书评自陈 "very roughly" 且明说略过 `n = 0` 零模那一段**（E2.1），
   而零模正是断言 (2) 的接缝所在——即使这份二手转述忠实，它**恰好回避了最关键的部分**。
5. **任务书对候选 1 的书名/编者有误**（E1.0，已订正）：「Algebras, Lattices and Strings」是
   卷内 Goddard–Olive 那一篇的**篇名**，MSRI vol. 3 的编者是 Lepowsky–Mandelstam–Singer。
6. **本轮新增的 FLM 第 8 章编号全部是 L3**（E2.2）：§8.1–8.3、Remark 8.9.1、Theorem 8.9.5、
   §8.10、(8.1.5)、(8.1.6)、(8.10.23)、(8.10.32)、(8.10.37)——**转抄自 Rosellen 讲义，
   未与原书核对**，日后引用须标 L3。

## ★ 残余风险 / 未做的事（本轮必须逐条列出，不得隐瞒）

1. **MSRI vol. 3 的 Goddard–Olive pp. 51–96 与 Mandelstam pp. 15–35 仍完全 L0**（E1.3）。
   九条渠道实测失败。**这是「没拿到」，不是「读了没有」。** 结构性论证（E1.4）只排除判据 2 的
   严格形式，**不排除**该文里写了某种记号对照。
2. **FLM 1988 第 8 章正文仍完全 L0**（E2.5）。本轮走的是转引路线，产出的是**关于**该章的
   定性情报（Ogg 书评）与编号（Rosellen），**没有任何一条 FLM 公式的逐字转抄被找到**。
   Ogg 的转述指向「FLM 是定义式」，但这是二手、"very roughly"、且刻意略过零模。
3. **Kac–Raina 两版正文仍完全 L0**（E3.1）。本轮的进步只是把「基于同域名的外推」换成了
   World Scientific 403 + Cloudflare 的**实测**。
4. **Kac 1998 *Vertex Algebras for Beginners* §5 仍完全 L0**（第二轮候选 2 的残余风险，
   **本轮未再尝试**）。
5. **Goddard–Olive 1986 (IJMPA 1, 303–414) 仍完全 L0**（第二轮候选 1，任务书当时的最高优先级，
   **本轮未再尝试**）。第二轮已实测五渠道全败。
6. **Google Books 渠道本轮仍未恢复**（E1.3 渠道 8，HTTP 429）。第二轮残余风险第 5 条
   （「配额或验证码可能在后续会话恢复，值得重跑」）**本轮复测仍失败**，
   因此「页码定位法」这条既有方法论**连续两轮无法执行**。
7. **CDS Anubis 反爬、World Scientific Cloudflare 两条防线本轮再次确认生效**
   （E1.3 渠道 7、E3.1 渠道 1）。凡托管在这两处的格点顶点代数经典文献，本项目目前无公开途径。
8. **Grotenhuis 2020 只读了承载页与相关章节，未通读全文 127 页**。第 4–5 章（自由玻色开弦/闭弦
   量子化）、第 6.2–6.4 节（单圈配分函数、Monster 配分函数）只做了关键词扫描，未逐页核对。
   **若 lead 要把这条当作正式来源，应再派一轮做全文通读与接缝复核。**
9. **Kac 的 *Modular Invariance in Mathematics and Physics*（AMS Centennial 1988，14 页扫描件）
   只读了第 1 页**（E3.2）。该 PDF 无文字层，通读需逐页渲染，本轮未做。
10. **未尝试的渠道（诚实列出）**：高校图书馆代理 / 馆际互借（本环境无法使用）；
    Springer / AMS 的促销预览窗口（时段性，本轮未碰上）；
    向作者本人索取（本项目不使用私下获得的材料，按 `literature/CLAUDE.md` 规则 1 **原则上排除**）。

---

## ★★★ 结论（三选一）

### (A) 找到了——**但只在一份本科毕业论文里，且只是陈述、不是证明，且命题不是本卡那一条。**

逐候选：

| 候选 | 本轮状态 | 裁定 |
|---|---|---|
| 1a. MSRI vol.3, Lepowsky Introduction pp.1–13 | **L1 读到底** | **REFUTE（不承载）**：判据 1、2 均不满足；编者逐字声明不写记号 |
| 1b. MSRI vol.3, Goddard–Olive pp.51–96 | **L0**（九渠道实测） | **无定论**（没拿到 ≠ 读了没有） |
| 1c. MSRI vol.3, Mandelstam pp.15–35 | **L0** | **无定论** |
| 2a. FLM 1988 Ch.8 正文 | **L0**（转引路线未取得公式） | **无定论** |
| 2b. Ogg 1991 Bull. AMS 书评（二手转述 FLM） | **L1 读到底** | **REFUTE（不承载）**：判据 1 不满足；且转述指向 FLM 是 `:=` 定义式（判据 3 亦不满足） |
| 2c. Dong–Mason–Nagatomo math/0004132 | **L1 读到底** | **REFUTE**：判据 1 不满足（纯 VOA 侧） |
| 2d. Runkel 1209.5554 §3.3 | **L1 读到底** | **REFUTE**：判据 1、2 不满足 |
| 3. Kac–Raina（两版） | **L0**（四渠道实测） | **无定论** |
| **4. Grotenhuis 2020（意外命中）** | **L1 承载页页图核对** | **★ SUPPORT（有条件）**：三条判据形式上全中（E4.1–E4.3） |
| 5a. Driscoll-Spittler 2408.07597 | **L1 读到底** | **REFUTE**：判据 1 不满足（旁支情报，见 E5.1） |
| 5b. Keller VOA 讲义 | **L1 读到底** | **REFUTE**：判据 1 不满足（见 E5.2） |

**为什么标 (A) 而不是 (B) 或 (C)**：任务书的判据是三条，**Grotenhuis 2020 三条全中**，
这是四轮、十余篇候选里的**第一次**。按判据的字面，这就是「找到了」。
**但 researcher 必须同时把三条限定词说全**（见候选 4 小结）：来源是本科毕业论文（非同行评议）；
论证是肉眼 "We recognise"（无逐项核对，(6.6) 自身的 `α'` 因子就掉了）；
命题是**正定偶格**上的，**不是**本卡的秩 1 类光格 / 动量塔 `T(p;k₀)`，
且 cocycle、连续动量↔格、`δ` 归一化三条接缝全部未处理。

**对 lead 的裁决建议（只提建议，不动手改图）**：
- 本卡此前的开轨前提是「公开文献里连这个等式的**陈述**都找不到」。
  **这个前提现在应当修正为**：等式的陈述在一份低分量公开来源里出现过（`grotenhuis-2020`），
  但**证明**仍查无——Grotenhuis 没有证明它，也没有处理本卡列出的任何接缝，
  且他处理的格类型与本卡不同。
- 因此按根 `CLAUDE.md`「原创证明轨道」那一条的标准（「确认查无此证明」），
  **开原创轨道的前提仍然成立**；但 `research/` 的文档里**必须**记上 `grotenhuis-2020` 这条
  在先的公开陈述，避免日后被指「其实有人写过、只是没读到」。
- ⚠ 同时必须记上上面【残余风险】第 1–5 条：MSRI vol.3 的 Goddard–Olive、FLM Ch.8、
  Kac–Raina、Kac 1998 §5、Goddard–Olive 1986 **五份经典文献的正文，四轮下来一个字都没读到**。
  **这不是「文献里没有」的强证据，是「这批经典文献恰好集中在反爬极严的平台上」的结构性困境。**

---

## bib

- `ogg-1991`：**本轮新登记**（Bull. AMS (N.S.) 25 (1991) 425–432），note 记录 E2.1 的逐字引文、
  三条判据裁定、以及「书评是二手转述、Ogg 自陈 very roughly 且略过零模」这一强度限制。
- `grotenhuis-2020`：**本轮新登记**（Leiden BSc 论文 2020），note 完整记录 E4 的三条判据裁定、
  四个缺口与三处印刷错误，并逐字标明「非同行评议、本科毕业论文」。
- `lepowsky-mandelstam-singer-1985`：本轮（较早）新登记，见 E1.0–E1.5。
- `kac-raina-1987` / `kac-raina-rozhkovskaya-2013`：**本轮不追加 note**（无新内容进展，
  只有访问渠道实测，已在本抽取记录 E3.1 留档）。
- **本轮刻意不登记 bib 的文献**（沿用本项目既有纪律：正文虽拿到但不承载任何图中陈述、
  仅作方法论对照的，不入 bib，只在抽取记录留档）：
  Rosellen math/0607270、Dong–Mason–Nagatomo math/0004132、Runkel 1209.5554、
  Keller VOA 讲义、Kac *Modular Invariance*（AMS Centennial 1988）。
  **例外**：Driscoll-Spittler arXiv:2408.07597 与本图无鬼定理一线直接相关，
  **本轮登记 bib**（见下），供 curator 日后取用。

---
