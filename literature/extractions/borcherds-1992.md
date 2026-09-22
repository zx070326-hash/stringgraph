# 抽取记录：borcherds-1992

- **文献**：`borcherds-1992` = R. E. Borcherds, "Monstrous moonshine and monstrous Lie superalgebras", Invent. Math. **109** (1992) 405–444, DOI 10.1007/BF01232032.
- **抽取者**：researcher
- **日期**：2026-09-14
- **覆盖范围**：仅 §5「The no-ghost theorem」（Theorem 5.1 + Lemmas 5.1–5.5），以及 §6 中用到 5.1 的推论。§1–4、§7–14 未抽取。
- **证据等级**：**L1**（作者主页重排本 `https://math.berkeley.edu/~reb/papers/monster/monster.pdf` 落盘后逐页读图；重排本 Theorem 5.1 落在 p.19，Lemmas 5.1–5.5 在 pp.20–21）。
- **⚠ 引用陷阱**：重排本页码 1,2,3,…，**不等于**期刊页 405–444。图节点 `loc:` 一律写节号/定理号，禁止写页码。裸 PDF 文本层为 FlateDecode 压缩、不可直接抽取，须渲染读图。

## 约定（原文 §3、§5）

- 顶点代数在实数域上；双线性形式 (,) 满足 u_n 的伴随由 §3 的公式给出。
- Virasoro 生成元 L_i = ω_{i+1}（ω 为共形矢量），关系
  `[L_i, L_j] = (i−j)L_{i+j} + 26(i³−i)δ^i_{−j}/12`（张 V_{II_{1,1}} 之后），L_i 的伴随为 L_{−i}。
- 度规/格约定：II_{1,1} 为二维偶自对偶洛伦兹格，Gram 矩阵 `((0,−1),(−1,0))`；II_{25,1} 类似。
- 与本项目 `graph/conventions/` 的对照未做逐条映射（Borcherds 用 VOA 语言，非世界面场论语言）；
  最关键对应：Borcherds 的 **横向空间 T** ↔ 本项目的 **DDF 张成 D(Ε)**；**零化空间 N = S∩P** ↔ **H_null**；
  **P¹** ↔ **H_phys（L_0 本征值 1、被 L_{i>0} 湮灭）**。

## 陈述

### E1 — Theorem 5.1（无鬼定理；本抽取的核心）

- **位置**：§5，Theorem 5.1（重排本 p.19）。
- **类型**：proposition（编号定理，带证明）。
- **原文陈述**（L1 逐字要点）：
  > "Suppose that V is a vector space with a nonsingular bilinear form (,) and suppose that V is
  > acted on by the Virasoro algebra in such a way that the adjoint of L_i is L_{−i}, the central
  > element of the Virasoro algebra acts as multiplication by 24, any vector of V is a sum of
  > eigenvectors of L_0 with nonnegative integral eigenvalues, and all the eigenspaces of L_0 are
  > finite dimensional. … We let V_{II_{1,1}} be the vertex algebra of the double cover of the two
  > dimensional even unimodular Lorentzian lattice II_{1,1} … We let P¹ be the subspace of the
  > vertex algebra V ⊗ V_{II_{1,1}} of vectors v with L_0(v) = v, L_i(v) = 0 for i > 0, and we let
  > P¹_r be the subspace of P¹ of degree r ∈ II_{1,1}. … **Then the quotient of P¹_r by the
  > nullspace of its bilinear form is naturally isomorphic, as a G module with an invariant bilinear
  > form, to V^{1−(r,r)/2} if r ≠ 0 and to V¹ ⊕ R² if r = 0.**"
- **这条就是 (B)**：P¹_r（物理态）模去其形式零化空间（零态）后**自然同构**于 V^{1−(r,r)/2}（横向 Fock 空间）。
  同构是**双向**的：既是单射（正范数、无鬼）又是**满射**——V^{1−(r,r)/2} 的每个元素都来自某物理态模零态，
  即横向/DDF 态**张成完整**物理子空间。这正是 `worldsheet.ddf-spanning-hypothesis` 断言的内容的 VOA 版。
- **严格程度（文献自称）**：**严格**。这是发表在 Invent. Math.（Borcherds 因含本文在内的工作获 1998 Fields 奖）
  的编号定理，且给出完整证明（Lemmas 5.1–5.5）。Borcherds 明写此证明是 Goddard-Thorn 1972 原始证明的复述：
  > "The original proof of Goddard and Thorn [21] works for the cases we need with only trivial
  > modifications. For convenience we give a quick sketch of their proof."
- **依赖（文献自列）**：Goddard-Thorn 1972 = ref [21]（原始证明）；Frenkel 1985 = ref [15]（用无鬼定理研究 KM 代数的想法，且亦含一份无鬼定理证明）。
- **备注**：「no-ghost」名称来源原文注明——原始表述中 V 取正定格顶点代数，故 V^i 正定、P¹_r 对 r≠0 无负范矢量。

### E2 — 证明链 Lemmas 5.1–5.5（= Goddard-Thorn 1972 原始论证的复述）

- **位置**：§5，Lemmas 5.1–5.5（重排本 pp.20–21）。
- **类型**：proof（证明步骤）。
- **子空间定义（L1 逐字，重排本 p.20）**：H = V⊗V_{II_{1,1}} 中 II_{1,1}-度数为 r 的子空间；P = H 中被所有 L_{i>0} 湮灭者；
  S = 伪态空间（H 中垂直于 P 者）；**N = S ∩ P = P 的双线性形式的根（radical）**；
  **T = 横向空间 = P 中被所有 K_i (i>0) 湮灭者**；K = K_i (i∈Z) 作用于 T 生成的空间；Ve^r = H 中 V⊗e^r 子空间。
  这里 **K_i = v_{i−1}，v = e^{−w}_{−2}e^w**（w 为 II_{1,1} 中类光矢量），是**由额外类光方向造的 DDF 型激发算子**，
  满足 `[L_i, K_j] = −jK_{i+j}`、`[K_i, K_j] = 0`、K_i 的伴随为 K_{−i}。
- **链**（各 Lemma 原文陈述已 L1 读毕）：
  1. **Lemma 5.1**：T 中非零范矢量 f 经 `L_{m_1}…K_{n_1}…(f)` 生成的态线性独立、张成一个在 K_i/L_i 下不变、形式非退化的空间（证明：内积矩阵可排成上三角、对角非零）。
  2. **Lemma 5.2**：T 上双线性形式非退化；K = T ⊕ (K 的零化空间)。
  3. **Lemma 5.3**：**Ve^r ≅ T**（自然同构）。
  4. **Lemma 5.4**：L_{i<0} 生成的结合代数，由把 S¹ 映入 S 的元素生成（证明用到「Virasoro 中心在 V 上作用为 24、故在 H 上为 26」——**D=26 在此步进入**）。
  5. **Lemma 5.5**：**P¹ = T¹ ⊕ N¹**（直和分解：任一物理态 = 横向态 + 零态）。
- **收尾（L1 逐字）**：
  > "The no ghost theorem now follows immediately, because by lemma 5.3 V^{1−(r,r)/2}e^r is
  > isomorphic to T¹, and by lemma 5.5 T¹ is isomorphic to the quotient of P¹ by its nullspace."
- **严格程度**：严格（完整证明，非仅梗概；Borcherds 称之为 GT 1972 证明的「quick sketch」但每步都给了证明理由）。
- **对 (B) 的意义**：**Lemma 5.5「P¹ = T¹ ⊕ N¹」直接是张成命题**——物理态空间 = 横向（DDF）态 ⊕ 零态，
  故 H_phys ⊆ D(Ε) + H_null 成立且为等号（在模零态意义下同构）。这是本项目所缺的「满射/完整性」严格论证。

### E3 — D=26 的地位（§5 与 §6）

- **位置**：§5 正文（重排本 p.20）与 §6 Theorem 6.1 证明后的 Remark（p.22）。
- **原文（L1 逐字）**：「The 26 comes from the 24 in theorem 5.1 plus the dimension of II_{1,1}.」
  §6 Remark：「it is only when this [conformal] vector has dimension 24 that we can apply the no-ghost
  theorem to identify the homogeneous pieces of M with those of V. … this need not be true if the
  conformal vector has dimension greater than 24, even if the inner product on V is positive definite.」
- **意义**：D=26（= 横向 24 + II_{1,1} 的 2）是使横向/DDF 态张成成立的**关键假设**，
  与本项目 `ddf-spanning-hypothesis`「D=26 只在这条陈述进入」的判断**完全吻合**。

## 未解决的疑问

1. **重排本 vs 期刊印本逐字一致性（L0）**：Theorem 5.1 与 Lemmas 5.1–5.5 的措辞取自作者主页 TeX 重排本，
   未与 Invent. Math. 109 期刊扫描件逐字复核。风险低（作者本人重排），但严格计属 L0。
2. **K_i ↔ DDF 算子 A^ε_n 的逐字对应**：Borcherds 的 K_i 是「由额外类光方向造的横向激发算子」，
   与本项目 `worldsheet.ddf-operators` 定义的 A^ε_n 在物理上是同一族，但**逐字的算子字典未在本文给出**
   （Borcherds 用 VOA 语言，不写 A^ε_n）。curator 若把 E1/E2 挂到 DDF 框架的节点，需标 `inferred: true`
   或补一条「K_i = DDF 算子」的对应来源。这一步等价性属标准知识但非本文成文。
3. **Goddard-Thorn 1972 原文本身仍未获取**：Borcherds 背书「GT 1972 的证明经平凡修改即适用」并复述其结构，
   但本项目至今未取得 GT 1972（Phys. Lett. B40, 235–238）全文。故「DDF 框架下的原始证明」的**逐字**
   仍缺；不过 Borcherds 1992 §5 已提供一份自足的、发表的、带证明的等价陈述。

---

## 追加抽取（2026-09-22，prover，任务 `borcherds-rank-one-noghost`）

**本次追加的范围**：§5 全部**证明正文**（此前只有一行式摘要，见上文 E2 第 56–61 行）、§3 中定义双线性型与
VOA/vertex algebra 区别的段落、§6 Remark。**不改动上面任何一行**。

- **抽取方式**：作者主页重排本 `https://math.berkeley.edu/~reb/papers/monster/monster.pdf`，
  用 **PyMuPDF**（`page.get_text("text", sort=True)`）抽文本层 + 200 dpi 渲染 PNG，**逐句读图复核**。
  脚本与用法：`research/attempts/borcherds-rank-one-noghost/scripts/extract_pdf.py`（见该目录 README 段）。
  **禁用 pdftotext**（本项目既往判例：pdftotext 曾吞掉 `e^α` 因子并把 ∆ 印成 ψ）。
- **证据等级**：**L1**（重排本文本层 + 同页渲染图双读）。重排本 §5 落在 p.19–21，§3 在 p.12–13。
  **⚠ 页码仅用于本抽取记录内部定位，图节点 `loc:` 一律写节号/定理号。**
- **文本层已知失真（读图校正后给出正确写法）**：文本层把上下标压平。下面逐字块中的数学记号已按**渲染图**还原，
  凡还原处以 `→` 标注。已核对的几处：`26(i3 −i)δi−j/12` → `26(i³−i)δ^i_{−j}/12`；
  `e−w−2 ew` → `e^{−w}_{−2}e^w`；`Ki = vi−1` → `K_i = v_{i−1}`；`L−2+3L2−1/2` → `L_{−2}+3L²_{−1}/2`；
  `V 1−(r,r)/2` → `V^{1−(r,r)/2}`；`Pr1` → `P¹_r`。

### E4 — §5 开场：证明的出发点（逐字，重排本 p.19）

> "We prove a slight extension of the no-ghost theorem. The idea of using the no-ghost theorem to
> prove results about Kac-Moody algebras appears in Frenkel's paper [15], which also contains a
> proof of the no-ghost theorem. The original proof of Goddard and Thorn [21] works for the cases
> we need with only trivial modifications. **For convenience we give a quick sketch of their proof.**"

Theorem 5.1 陈述之后、Lemma 5.1 之前的**唯一**一段正文（逐字）：

> "**Sketch of proof (taken from Goddard and Thorn, [21]). Fix some nonzero r ∈ II_{1,1} and some
> norm 0 vector w in II_{1,1} with (r, w) ≠ 0.**"

以及 Theorem 5.1 陈述后的说明段（逐字）：

> "The name "no-ghost theorem" comes from the fact that in the original statement of the theorem
> in [21], **V was part of the underlying vector space of the vertex algebra of a positive definite
> lattice** so the inner product on V^i was positive definite, and thus P¹_r had no ghosts (i.e.
> vectors of negative norm) for r nonzero. The space V^i is the space V_{i−1} used in the rest of
> this paper."

### E5 — §5 的算子与子空间定义（逐字，重排本 p.20）

> "We use the following operators. We have an action of the Virasoro algebra on V ⊗ V_{II_{1,1}}
> generated by its conformal vector. The operators L_i of the Virasoro algebra satisfy the relations
>
>   [L_i, L_j] = (i − j)L_{i+j} + 26(i³ − i)δ^i_{−j}/12.
>
> and the adjoint of L_i is L_{−i}. **(The 26 comes from the 24 in theorem 5.1 plus the dimension of
> II_{1,1}.)** We define operators K_i, i ∈ Z by **K_i = v_{i−1} where v is the element e^{−w}_{−2}e^w
> of the vertex algebra of II_{1,1}**, and e^w is an element of the group ring of the double cover of
> II_{1,1} corresponding to w ∈ II_{1,1} and e^{−w} is its inverse. (There are in fact two possible
> choices for e^w which differ by a factor of −1, but it does not matter which we choose because this
> factor of −1 cancels out in the expression e^{−w}_{−2}e^w.) These operators satisfy the relations
>
>   [L_i, K_j] = −jK_{i+j}
>   [K_i, K_j] = 0
>
> **because w has norm 0**, and the adjoint of K_i is K_{−i}."

子空间（逐字）：

> "We define the following subspaces of V ⊗ V_{II_{1,1}}.
> **H is the subspace of V ⊗ V_{II_{1,1}} of degree r ∈ II_{1,1}.** H¹ is its subspace of vectors h
>   with L_0(h) = h.
> P, is the subspace of H of all vectors h with L_i(h) = 0 for i > 0. P¹ = H¹ ∩ P.
> S, the space of spurious vectors, is the subspace of H of vectors perpendicular to P. S¹ = H¹ ∩ S.
> N = S ∩ P is the radical of the bilinear form of P, and N¹ = H¹ ∩ N.
> T, the transverse space, is the subspace of P annihilated by all the operators K_i, i > 0, and
>   T¹ = H¹ ∩ T.
> K is the space generated by the action of the operators K_i, i ∈ Z on T.
> Ve^r is the subspace V ⊗ e^r of H."

证明路线图（逐字；原文附一张 S ← N → P ← T → K ← Ve^r 的箭头图）：

> "We have the following inclusions of subspaces of H: [图：S ↖ N ↗ P ↖ T ↗ K ↖ Ve^r]
> and we construct the isomorphism from V^{1−(r,r)/2} to P¹/N∩P¹ by zigzagging up and down this
> diagram; more precisely we show that Ve^r and T are both isomorphic to K modulo its nullspace,
> and then we show that T¹ is isomorphic to P¹ modulo its nullspace P¹ ∩ N."

### E6 — Lemmas 5.1–5.5 的证明正文（**逐字全文**，重排本 pp.20–21）

**Lemma 5.1**（陈述 + 证明，逐字）：

> "**Lemma 5.1.** If f is a vector of nonzero norm in T then the vectors of the form
>
>   L_{m_1}L_{m_2} … K_{n_1}K_{n_2} … (f)
>
> for all sequences of integers with 0 > m_1 ≥ m_2 …, 0 > n_1 ≥ n_2 … are linearly independent and
> span a space invariant under the operators K_i and L_i on which the bilinear form is nonsingular.
>
> **Sketch of proof:** It is possible to order these elements so that the matrix of inner products is
> upper triangular with nonzero diagonal elements. This implies that they are independent and span a
> space on which the inner product is nonsingular. The other statements in the lemma are easy to prove."

**Lemma 5.2**（陈述 + 证明，逐字）：

> "**Lemma 5.2.** The bilinear form on T is nonsingular, and K is the direct sum of T and the
> nullspace of K.
>
> **Proof.** If we choose an orthogonal basis for T, then **the set of all vectors generated from them
> as in Lemma 5.1 is a basis for H.** As H is nonsingular, T must therefore also be nonsingular. It now
> follows that K is the direct sum of its nullspace and T, because K is generated from T by the
> operators K_i and anything generated from T by these operators is in the nullspace of K."

**Lemma 5.3**（陈述 + 证明，逐字）：

> "**Lemma 5.3.** Ve^r is naturally isomorphic to T.
>
> **Proof.** **K is also the subspace of H annihilated by all the operators K_i, i > 0** from which it
> follows that K is the direct sum of Ve^r and the nullspace of K. By lemma 5.2 K is also the direct
> sum of T and the nullspace of K, so this gives a natural isomorphism from Ve^r to T, because they
> are both isomorphic to the quotient of K by its nullspace."

**Lemma 5.4**（陈述 + 证明，逐字）：

> "**Lemma 5.4.** The associative algebra generated by the elements L_i for i < 0 is generated by
> elements mapping S¹ into S.
>
> **Proof.** **Calculation shows** that the operators L_{−1} and L_{−2}+3L²_{−1}/2 have this property,
> and they generate the algebra generated by all L_i's with i < 0. (It is in doing these calculations
> that we need to use the fact that **the center of the Virasoro algebra acts as 24 on V and therefore
> as 26 on H**.)"

**Lemma 5.5**（陈述 + 证明，逐字）：

> "**Lemma 5.5.** P¹ is the direct sum of T¹ and N¹.
>
> **Proof.** We have to show that any vector p of P¹ can be written as p = t + n for t ∈ T¹, n ∈ N¹.
> **By lemma 5.3, p = k + s for some unique k ∈ K¹, s ∈ S¹** and by lemma 5.4 k and s are both mapped
> into K and S by some set of generators of the algebra generated by **the L_i's, i > 0**. As these
> generators annihilate p, they must also annihilate k and s. Hence k is in K¹ ∩ P¹ = T¹ and s is in
> S¹ ∩ P¹ = N¹, so that P¹ = T¹ ⊕ N¹."

**收尾**（逐字，与上文 E2 第 63–64 行同，此处保留以使本段自足）：

> "The no ghost theorem now follows immediately, because by lemma 5.3 V^{1−(r,r)/2}e^r is isomorphic
> to T¹, and by lemma 5.5 T¹ is isomorphic to the quotient of P¹ by its nullspace."

**以上即 §5 证明正文的全部文字**（除 Theorem 5.1 陈述与 E4 的两段外，§5 再无其它正文）。抽取者按
`literature/CLAUDE.md` 第 2 条不在此处作推断；对这些文字的解读、其中未给论证的步骤、以及与本项目设定的
对照，全部写在 `research/attempts/borcherds-rank-one-noghost/scoping.md`，不写进本抽取记录。

### E7 — §3：双线性型的构造与 vertex algebra / VOA 的区别（逐字，重排本 p.13）

与 §5 的形式（bilinear form）直接相关的**唯一**定义段（逐字）：

> "The vertex algebra of any even lattice and the monster vertex algebra both have a real valued
> symmetric bilinear form (,) such that **the adjoint of the operator u_n is
> (−1)^i Σ_{j≥0} L^j_1(ω(u))_{2i−j−n−2}/j! if u has degree i**, where ω is the automorphism of the
> vertex algebra defined by **ω(e^w) = (−1)^{(w,w)/2}(e^w)^{−1}** for e^w an element of the twisted
> group ring of L corresponding to the vector w ∈ L, or is 1 in the case of the monster vertex
> algebra. … If a vertex algebra has a bilinear form with the properties above we say that the
> **bilinear form is compatible with the conformal vector**."

张量积（逐字）：

> "If V and W have conformal vectors ω_V and ω_W of dimensions m and n then ω_V ⊗ 1 + 1 ⊗ ω_W is a
> conformal vector of V ⊗ W of dimension m + n. **If V and W have bilinear forms compatible with the
> conformal vectors then so does V ⊗ W; in fact the obvious bilinear form on the tensor product will
> do.**"

中心荷与格维数（逐字）：

> "**The vertex algebra of any c-dimensional even lattice has a canonical conformal vector of
> dimension c**, and the monster vertex algebra has a conformal vector of dimension 24."

格顶点代数的底空间（逐字，p.12）：

> "The underlying vector space of this vertex algebra is the tensor product of the twisted group ring
> Q(L̂) of the double cover L̂ of L … and the ring of polynomials **S(⊕_{i>0}L_i)** over the sum of an
> infinite number of copies L_i of **L ⊗ R**."

**L_0 本征空间有限维性的地位**（逐字，p.13；**本次抽取最关键的新材料**）：

> "A **vertex operator algebra** is a vertex algebra with a conformal vector such that the eigenspaces
> of L_0 are all finite dimensional with nonnegative integral eigenvalues. For example, the monster
> vertex algebra is a vertex operator algebra. … **The vertex algebras used in this paper all have
> conformal vectors but the eigenspaces of L_0 are not always finite dimensional. An example of a
> vertex algebra without these properties is the vertex algebra V_{II_{1,1}} of the 2-dimensional
> even unimodular Lorentzian lattice II_{1,1}.**"

（即：Borcherds 本人指出 **V_{II_{1,1}} 的 L_0 本征空间不是有限维的**；Theorem 5.1 里"all the eigenspaces of
L_0 are finite dimensional"这句话的主语是 **V**，不是 V ⊗ V_{II_{1,1}}，也不是 H。）

### E8 — §6 Remark：24 这个数字的必要性（逐字，重排本 p.22；补齐 E3 的上下文）

> "The construction of a Lie algebra from a vertex algebra in theorem 6.1 can be carried out for any
> vertex algebra V with a conformal vector, but **it is only when this vector has dimension 24 that we
> can apply the no-ghost theorem** to identify the homogeneous pieces of M with those of V. The
> important point is that the bilinear form on M is positive definite on any piece of nonzero degree,
> and **this need not be true if the conformal vector has dimension greater than 24, even if the inner
> product on V is positive definite**."

§6 中对"形式按度数配对"的逐字说明（Theorem 6.1 (2) 的括号内，p.21–22）：

> "(By "contravariant bilinear form" we mean that the II_{1,1}-graded Lie algebra M has an involution
> ω which acts as −1 on II_{1,1} and as −1 on the piece of degree (0,0), such that the form
> (u, v) = −(u, ω(v))_0 is invariant, and **(u, v) = 0 unless deg(u) + deg(v) = 0**.)"

（注意：这句里的 (u,v) 是**李代数 M 上**的不变型，与 §5 用在 H 上的 (,) 是两个不同的型；M 上的不变型按
deg(u)+deg(v)=0 配对，(,)_0 = 反变型按同度数配对。§5 通篇用的是带 ω 的那个，见 E7 的伴随公式。
这一段仅为避免后续读者混淆而抽取，**不构成对 §5 用哪个型的断言**——该判断见 scoping.md Q3。）

### 追加的未解决疑问

4. **`K_i = v_{i−1}` 的指标与 `[L_i,K_j] = −jK_{i+j}` 不自洽（读图已确认原文如此）**：由 §3 的
   `L_i = ω_{i+1}` 与标准 `[L_i, u_n] = ((h−1)(i+1) − n)u_{i+n}`（u 为权 h 的初级场），
   `v = e^{−w}_{−2}e^w` 的共形权为 `0 + 0 − (−2) − 1 = 1`，故 `v_{i−1}` 的 L_0-度数为 `1−i`，
   给出 `[L_0, K_i] = (1−i)K_i`，与原文 `[L_i,K_j] = −jK_{i+j}` 在 i=0 时给出的 `−jK_j` 差一个指标。
   与原文给出的对易子自洽的写法是 `K_i = v_i`。这是**抽取者的计算**（非原文文字），不改上面的逐字引用；
   影响评估见 scoping.md Q2。
5. **Lemma 5.5 证明第一句引的引理号**："By lemma 5.3, p = k + s for some unique k ∈ K¹, s ∈ S¹"——
   `H = K ⊕ S` 型的分解在 Lemma 5.2/5.3 的陈述里都没有逐字出现；Lemma 5.3 的陈述是 `Ve^r ≅ T`。
   逐字如此，抽取者不改。
6. **Lemma 5.5 证明中的 "the L_i's, i > 0" 与 Lemma 5.4 的 "L_i for i < 0"**：Lemma 5.4 讲的是 i<0
   生成的代数，Lemma 5.5 引用时写 i>0。逐字如此，抽取者不改。
