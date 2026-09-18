# Proof — 椭圆尾粘接的带穿孔推广

**状态**：draft。遵循 `research/CLAUDE.md` 纪律：完成的步骤照常写"证明"，未完成处显式标
`[GAP: ...]`，不用含糊语言掩盖跳步。

**本文档的阅读顺序说明**：
- **§1 是 CN 椭圆尾论证的忠实重述**。凡标 **⟦CN 原文⟧** 的段落是逐字抄录（来自本轮亲自下载并
  `pdftotext -layout` 抽取的 arXiv:2606.06733v1 全文，行号可复核）；凡标 **⟦重述⟧** 的是本文作者的
  改写/补充说明。两者严格区分，不混。
- §2 是解剖：CN 的门槛 $g\ge3$ 到底从哪来，以及"无穿孔"在哪些地方被用到。
- §3 是**负面结论**（命题 N）。
- §4 是推广的构造与全部引理的重做。
- §5 是门槛与对照。§6 是自洽性检验。§7 是完整 `[GAP]` 清单。

---

## §0 记号与约定

$\mathfrak X$ 表示光滑 Deligne–Mumford 超叠，$X:=\mathfrak X_{\rm bos}$ 其玻色截断。
$\mathcal T_{\pm}\mathfrak X$ 表示 $\mathcal T\mathfrak X/\mathcal J\,\mathcal T\mathfrak X$ 的
偶/奇部分；标准超几何给出
$$\mathcal T_+\mathfrak X\cong\mathcal T_X,\qquad \mathcal T_-\mathfrak X\cong\mathcal F^\vee_{\mathfrak X},
\qquad \mathcal F_{\mathfrak X}:=\mathcal J/\mathcal J^2 .$$
（这是 DW 与 CN 使用的同一套识别，本文不重证，见 §7 `[GAP-STD]` 的严格程度说明。）

$$\mathcal F_{\mathfrak X}^{\rm obs}:=\mathrm{Hom}\big(\Lambda^2\mathcal T_-\mathfrak X,\ \mathcal
T_+\mathfrak X\big),\qquad
\omega_2(\mathfrak X)\in H^1\big(X,\ \mathcal F^{\rm obs}_{\mathfrak X}\big).$$

超模叠记号统一用 FKP 的 $\overline{\mathfrak S}_{g;m,n}$（$m$ = NS 穿孔数，$n$ = Ramond 穿孔数）。
CN 写 $\overline{\mathfrak M}{}^{\varepsilon}_g$，即 $\overline{\mathfrak S}{}^{\varepsilon}_{g;0,0}$；
CN 写 $\mathfrak M^+_{h,1}$，即光滑轨迹 $\mathfrak S^+_{h;1,0}$。本文在重述 CN 时保留 CN 的记号，在
推广部分统一用 FKP 记号，并在切换处注明。

---

## §1 CN 椭圆尾论证的忠实重述

### §1.1 工具箱（CN §2）

**⟦CN 原文⟧ Proposition 2.2**（逐字）：

> "Let $\mathfrak X$ be a smooth Deligne–Mumford superstack over $\mathbb C$, and let
> $X=\mathfrak X_{\rm bos}$. There is a canonical primary obstruction class
> $$\omega_2(\mathfrak X)\in H^1\big(X,\ \mathcal T_X\otimes\Lambda^2\mathcal T_-^\vee\mathfrak X\big).$$
> It is compatible with étale pullback. If $\omega_2(\mathfrak X)\neq0$, then $\mathfrak X$ is not
> projected. If $\mathcal T_-\mathfrak X$ has rank two, then $\mathfrak X$ is split $\iff$
> $\omega_2(\mathfrak X)=0$."

**⟦CN 原文⟧ Lemma 2.6（Functoriality of the primary obstruction）**（逐字，删去排版噪声）：

> "Let $f:\mathfrak Y\to\mathfrak X$ be a morphism of smooth Deligne–Mumford superstacks. Set
> $X=\mathfrak X_{\rm bos}$, $Y=\mathfrak Y_{\rm bos}$, and let $f_0:Y\to X$ be the induced morphism
> on bosonic truncations. Let
> $$df_+:\mathcal T_+\mathfrak Y\to f_0^*\mathcal T_+\mathfrak X,\qquad
> df_-:\mathcal T_-\mathfrak Y\to f_0^*\mathcal T_-\mathfrak X$$
> be the even and odd components of the differential, restricted to $Y$. Put
> $\mathcal F_{\mathfrak X}:=\mathrm{Hom}(\Lambda^2\mathcal T_-\mathfrak X,\mathcal T_+\mathfrak X)$,
> $\mathcal F_{\mathfrak Y}:=\mathrm{Hom}(\Lambda^2\mathcal T_-\mathfrak Y,\mathcal T_+\mathfrak Y)$,
> and introduce the comparison sheaf on $Y$
> $$\mathcal G_f:=\mathrm{Hom}\big(\Lambda^2\mathcal T_-\mathfrak Y,\ f_0^*\mathcal T_+\mathfrak X\big).$$
> The odd differential induces $\Lambda^2 df_-:\Lambda^2\mathcal T_-\mathfrak Y\to
> f_0^*\Lambda^2\mathcal T_-\mathfrak X$. Therefore pullback followed by precomposition with
> $\Lambda^2 df_-$ gives a map $\iota_f:H^1(X,\mathcal F_{\mathfrak X})\to H^1(Y,\mathcal G_f)$.
> Similarly, composition with the even differential gives a map
> $j_f:H^1(Y,\mathcal F_{\mathfrak Y})\to H^1(Y,\mathcal G_f)$. Then
> $$j_f\big(\omega_2(\mathfrak Y)\big)=\iota_f\big(\omega_2(\mathfrak X)\big)\quad\text{in }
> H^1(Y,\mathcal G_f).$$
> In particular, if $j_f(\omega_2(\mathfrak Y))\neq0$, then $\omega_2(\mathfrak X)\neq0$."

**⟦重述⟧ 这条引理是全部论证的心脏，且它的形状极其重要**：它**不**在两个障碍群之间给出映射，而是把
两者的像放进**同一个** $H^1(Y,\mathcal G_f)$ 里比较（CN 在 §8 明确写 "the cospan"）。因此**全部
上同调计算都发生在 $Y=\mathfrak Y_{\rm bos}$ 上**——本文第 §2/§3 节的全部分析都围绕这一点：
**$Y$ 是什么曲线，决定了方法能不能用。**

### §1.2 Donagi–Witten 一点障碍族（CN §5）

**⟦CN 原文⟧**（逐字）：

> "Let $h\ge2$. Choose a smooth genus-$h$ curve $C$ and an ineffective even theta characteristic
> $L^{\otimes2}\cong\omega_C$, $H^0(C,L)=0$. Such spin curves exist for every $h\ge2$: a general even
> theta characteristic is ineffective; see Mumford [12] and Cornalba [5]. […]
> The odd tangent space to the even supermoduli component at the split super Riemann surface
> associated with $(C,L)$ is $H^1(C,L^{-1})$. For an odd tangent vector $\eta\in H^1(C,L^{-1})$,
> Donagi and Witten construct a $(1|2)$-dimensional supermanifold $X_\eta$ by pulling back the
> universal one Neveu–Schwarz pointed supercurve along the odd tangent line determined by $\eta$
> [7, Section 3.5]. **The reduced space of $X_\eta$ is the curve $C$, regarded as the moving NS
> marking in the universal pointed curve over the fixed spin curve $(C,L)$.** Thus $X_\eta$ carries a
> natural morphism $u_\eta:X_\eta\to\mathfrak M^+_{h,1}$.
> The odd part of the tangent bundle of $X_\eta$ fits into an exact sequence
> $$0\to L^{-1}\to\mathcal T_-X_\eta\to\mathcal O_C\cdot\eta\to0 .$$
> After trivializing the odd base line by the chosen generator $\eta$, we identify
> $\Lambda^2\mathcal T_-X_\eta\cong L^{-1}$. Moreover, $\mathcal T_+X_\eta\cong\mathcal T_C\cong
> L^{-2}$. Hence $\mathrm{Hom}(\Lambda^2\mathcal T_-X_\eta,\mathcal T_+X_\eta)\cong
> \mathrm{Hom}(L^{-1},L^{-2})\cong L^{-1}$.
> Donagi–Witten prove that, under this identification, $\omega_2(X_\eta)=\eta$ in $H^1(C,L^{-1})$,
> see [7, Proposition 3.4]."

**⟦重述⟧ 三条要点，后面要反复用**：

1. $Y=(X_\eta)_{\rm bos}=C$，**整条光滑射影曲线**。障碍参数空间是 $H^1(C,L^{-1})$，
   这个群非零**完全依赖 $C$ 射影**（仿射曲线上它是 $0$）。
2. $\mathcal T_+X_\eta\cong\mathcal T_C$：因为 $X_\eta$ 的偶方向就是"移动那个 NS 标记点"。
3. $\Lambda^2\mathcal T_-X_\eta\cong L^{-1}$——注意它只用到 $L^{\otimes2}\cong\omega_C$，即
   **"亏格 $h$ 一侧没有 Ramond 穿孔"**（否则 $L^{\otimes2}\cong\omega_C(R)$，上述同构要改）。

### §1.3 椭圆尾 NS 边界映射（CN §6）

**⟦CN 原文⟧**（逐字，§6 开头）：

> "Set $g=h+1$. Fix a smooth pointed elliptic spin curve $(E,M,q)$ with $M^{\otimes2}\cong\omega_E
> \cong\mathcal O_E$. Let $\varepsilon\in\{+,-\}$ be the parity of $M$. For compact-type nodal spin
> curves, parity is the sum of the parities of the restrictions to the components. Since the spin
> curve $(C,L)$ chosen above is even, the parity of the glued curve is the parity of $M$. On a smooth
> elliptic curve, the trivial theta characteristic is odd, whereas the three nontrivial two-torsion
> theta characteristics are even."

**⟦CN 原文⟧**（逐字，固定尾的叠论处理）：

> "We shall regard $\xi_{\rm bos}:=(E,M,q)\in S^{\varepsilon}_{1,1}(\mathbb C)$ as a stack-theoretic
> point of the bosonic spin stack, and we denote by $\xi\in\mathfrak M^{\varepsilon}_{1,1}(\mathbb C)$
> the corresponding split one-NS-pointed elliptic supercurve. Let $A:=\mathrm{Aut}_{\mathfrak
> M^{\varepsilon}_{1,1}}(\xi)$ be its automorphism group. Since $\mathfrak M^{\varepsilon}_{1,1}$ is
> Deligne–Mumford, $A$ is finite étale. […] In what follows, saying that the elliptic tail is fixed
> means that we use the object $\xi$ as a constant family over every test superscheme."

**⟦CN 原文⟧**（逐字，粘接态射）：

> "Consider the product of smooth one-NS-pointed supermoduli stacks
> $$\mathcal B^{\varepsilon}:=\mathfrak M^+_{h,1}\times\mathfrak M^{\varepsilon}_{1,1}.$$
> Its bosonic truncation is $\mathcal B^{\varepsilon}_{\rm bos}=S^+_{h,1}\times S^{\varepsilon}_{1,1}$.
> The stable-supercurve compactification admits the NS gluing morphism
> $$\Gamma^{\varepsilon}:\mathcal B^{\varepsilon}\longrightarrow\overline{\mathfrak M}{}^{\varepsilon}_{h+1},$$
> which glues the two NS punctures and produces a separating NS node. […]
> By Felder–Kazhdan–Polishchuk, the NS gluing morphism is defined for stable supercurves with NS
> punctures; near a curve with a single NS node, its image is the corresponding NS boundary component,
> and it is a codimension $1|0$ embedding on tangent spaces [9, Lemmas 7.9–7.10]. With their
> convention for the NS psi-lines, the normal line to the NS boundary is
> $$\mathcal O(\Delta_{\rm NS})|_{\mathcal B^{\varepsilon}}\cong\Psi_1^{-1}\otimes\Psi_2^{-1},$$
> where $\Psi_i$ is the NS psi-line attached to the $i$-th puncture; see [9, Theorem C and equation
> (9.6)]."

**⟦CN 原文⟧**（逐字，常值尾态射与测试曲线）：

> "For every test superscheme $S$ and every $S$-point $\mathcal X\in\mathfrak M^+_{h,1}(S)$, set
> $\xi_S:=\xi\times_{\mathrm{Spec}\,\mathbb C}S$. The assignment $\mathcal X\mapsto(\mathcal X,\xi_S)$
> and, on morphisms, $\phi\mapsto(\phi,\mathrm{id}_S)$, defines a morphism of superstacks
> $\tau_\xi:\mathfrak M^+_{h,1}\to\mathcal B^{\varepsilon}$. […]
> Define the fixed-tail gluing morphism $G_{E,M,q}:=\Gamma^{\varepsilon}\circ\tau_\xi:
> \mathfrak M^+_{h,1}\to\overline{\mathfrak M}{}^{\varepsilon}_{h+1}$. We define the test morphism
> $F_{\eta,M}:=G_{E,M,q}\circ u_\eta:X_\eta\to\overline{\mathfrak M}{}^{\varepsilon}_{h+1}$. […]
> Let $e_C:C\to S^+_{h,1}$, $p\mapsto(C,L,p)$, and define
> $e:=\tau_{\xi,\rm bos}\circ e_C:C\to\mathcal B^{\varepsilon}_{\rm bos}$,
> $p\mapsto\big((C,L,p),(E,M,q)\big)$. Set $i:=\Gamma_{\rm bos}\circ e:C\to\overline S{}^{\varepsilon}_{h+1}$.
> Thus $i(p)=(C,L,p)\cup_{p=q}(E,M,q)$ is the stable spin curve obtained by gluing the moving point
> $p\in C$ to the fixed point $q\in E$ by an NS node."

**⟦CN 原文⟧ Lemma 6.1**（逐字，含证明）：

> "**Lemma 6.1.** Along the morphism $e:C\to\mathcal B^{\varepsilon}_{\rm bos}$, there is an exact
> sequence $0\to\mathcal T_C\to e^*\mathcal T\mathcal B^{\varepsilon}_{\rm bos}\to W\otimes
> \mathcal O_C\to0$, where $W:=H^1(C,\mathcal T_C)\oplus T_{\xi_{\rm bos}}S^{\varepsilon}_{1,1}$ is a
> fixed finite-dimensional vector space.
> *Proof.* […] The morphism $S^+_{h,1}\to S^+_h$ is the universal pointed curve over the smooth spin
> moduli stack. Pulling back its tangent sequence along $e_C$ gives
> $0\to\mathcal T_C\to e_C^*\mathcal T S^+_{h,1}\to T_{(C,L)}S^+_h\otimes\mathcal O_C\to0$.
> Since the smooth spin moduli stack is finite étale over the ordinary moduli stack of smooth curves,
> $T_{(C,L)}S^+_h\cong H^1(C,\mathcal T_C)$. For the elliptic factor, the morphism $e$ is constant and
> equal to the stack-theoretic point $\xi_{\rm bos}$. Therefore $e^*\mathrm{pr}_2^*\mathcal T
> S^{\varepsilon}_{1,1}\cong T_{\xi_{\rm bos}}S^{\varepsilon}_{1,1}\otimes\mathcal O_C$. […]
> Since $A$ is finite étale, the gerbe itself contributes no infinitesimal tangent directions."

**⟦CN 原文⟧ Lemma 6.2**（逐字，含证明）：

> "**Lemma 6.2.** The normal line to the NS boundary gluing morphism restricts along
> $e:C\to\mathcal B^{\varepsilon}_{\rm bos}$ as $e^*N\cong L^{-1}\otimes M_q^{-1}$, where
> $M_q:=M|_q$.
> *Proof.* […] By the Felder–Kazhdan–Polishchuk normal-line formula, $N\cong\Psi_1^{-1}\otimes
> \Psi_2^{-1}$. Over an even base, the inverse NS psi-line at a marked point is identified with the
> fibre of the inverse spin line at that point [9, Example 8.9]. In the present situation the first
> marked point is the moving point $p\in C$, whereas the second marked point is the fixed point
> $q\in E$. Hence $e^*\Psi_1^{-1}\cong L^{-1}$, $e^*\Psi_2^{-1}\cong M_q^{-1}\otimes\mathcal O_C$.
> Therefore $e^*N\cong L^{-1}\otimes M_q^{-1}$."

**⟦CN 原文⟧ Proposition 6.3**（逐字，含证明骨架）：

> "**Proposition 6.3 (Even tangent quotient along the test curve).** Let
> $\mathcal T:=i^*\mathcal T_+\overline{\mathfrak M}{}^{\varepsilon}_{h+1}\cong i^*\mathcal T
> \overline S{}^{\varepsilon}_{h+1}$. The differential of $i$ gives an injection
> $\mathcal T_C\hookrightarrow\mathcal T$. If $Q:=\mathcal T/\mathcal T_C$, then $Q$ has a filtration
> $0\subseteq Q_{\rm main}\subseteq Q_{\rm bd}\subseteq Q$ whose associated graded pieces are
> $Q_{\rm main}\cong H^1(C,\mathcal T_C)\otimes\mathcal O_C$,
> $Q_{\rm bd}/Q_{\rm main}\cong T_{\xi_{\rm bos}}S^{\varepsilon}_{1,1}\otimes\mathcal O_C$,
> $Q/Q_{\rm bd}\cong L^{-1}\otimes M_q^{-1}$.
> Equivalently, if $W:=H^1(C,\mathcal T_C)\oplus T_{\xi_{\rm bos}}S^{\varepsilon}_{1,1}$, then $Q$ has
> a two-step filtration $0\subseteq Q_0\subseteq Q$ with $Q_0\cong W\otimes\mathcal O_C$,
> $Q/Q_0\cong L^{-1}\otimes M_q^{-1}$.
> *Proof.* By Lemma 6.1, […]. By the tangent-embedding property of the NS boundary gluing morphism,
> pulling back the tangent sequence of the boundary inclusion along $e$ gives
> $0\to e^*\mathcal T\mathcal B^{\varepsilon}_{\rm bos}\to\mathcal T\to e^*N\to0$. […]"

### §1.4 障碍的存活（CN §7）

**⟦CN 原文⟧**（逐字）：

> "Let $J:H^1(C,L^{-1})\to H^1\big(C,\mathrm{Hom}(L^{-1},\mathcal T)\big)$ be the map induced by the
> inclusion $\mathcal T_C\cong L^{-2}\hookrightarrow\mathcal T$. Since
> $\mathrm{Hom}(L^{-1},\mathcal T)=\mathcal T\otimes L$, this is equivalently the map induced by
> $\mathrm{Hom}(L^{-1},\mathcal T_C)\cong L^{-1}\to\mathrm{Hom}(L^{-1},\mathcal T)\cong\mathcal T\otimes L$.
>
> **Lemma 7.1.** With the notation above, $\dim\ker J\le1$.
> *Proof.* Apply $\mathrm{Hom}(L^{-1},-)=(-)\otimes L$ to the exact sequence
> $0\to\mathcal T_C\to\mathcal T\to Q\to0$. Using $\mathcal T_C\cong L^{-2}$, we obtain
> $0\to L^{-1}\to\mathcal T\otimes L\to Q\otimes L\to0$. The associated long exact sequence in
> cohomology contains $H^0(C,Q\otimes L)\xrightarrow{\ \delta\ }H^1(C,L^{-1})\xrightarrow{\ J\ }
> H^1(C,\mathcal T\otimes L)$. Hence $\ker J=\mathrm{im}\,\delta$, and therefore
> $\dim\ker J\le h^0(C,Q\otimes L)$. By Proposition 6.3, after tensoring by $L$ the quotient
> $Q\otimes L$ has a filtration whose associated graded terms are $Q_0\otimes L\cong W\otimes L$,
> $(Q/Q_0)\otimes L\cong\mathcal O_C\otimes M_q^{-1}$. Equivalently, there is an exact sequence
> $0\to W\otimes L\to Q\otimes L\to\mathcal O_C\otimes M_q^{-1}\to0$. Taking global sections gives an
> injection $H^0(C,Q\otimes L)\hookrightarrow H^0(C,\mathcal O_C)\otimes M_q^{-1}$ because
> $H^0(C,W\otimes L)=W\otimes H^0(C,L)=0$. Hence $h^0(C,Q\otimes L)\le h^0(C,\mathcal O_C)=1$.
> Therefore $\dim\ker J\le1$. $\square$
>
> **Corollary 7.2.** There exists $\eta\in H^1(C,L^{-1})$ such that $J(\eta)\neq0$.
> *Proof.* Since $L^{\otimes2}\cong\omega_C$, we have $\deg L=h-1$, $\deg L^{-1}=1-h<0$. Thus
> $H^0(C,L^{-1})=0$. By Riemann–Roch, $\chi(C,L^{-1})=h^0(C,L^{-1})-h^1(C,L^{-1})=\deg(L^{-1})+1-h=
> 2-2h$. Since $H^0(C,L^{-1})=0$, this gives $h^1(C,L^{-1})=2h-2$. For $h\ge2$, the source of $J$ has
> dimension at least 2. By Lemma 7.1, $\ker J$ has dimension at most 1, and hence it cannot be all of
> $H^1(C,L^{-1})$. Choose $\eta\notin\ker J$. $\square$"

### §1.5 组装（CN §8）

**⟦CN 原文⟧**（逐字要点）：

> "Set $\mathcal T:=i^*\mathcal T_+\overline{\mathfrak M}{}^{\varepsilon}_g$. For the morphism
> $F_{\eta,M}$, the comparison sheaf in Theorem 2.6 is $\mathcal G_{F_{\eta,M}}:=
> \mathrm{Hom}\big(\Lambda^2\mathcal T_-X_\eta,\ i^*\mathcal T_+\overline{\mathfrak M}{}^{\varepsilon}_g\big)$.
> Using $\Lambda^2\mathcal T_-X_\eta\cong L^{-1}$, $i^*\mathcal T_+\overline{\mathfrak
> M}{}^{\varepsilon}_g=\mathcal T$, we identify it as $\mathcal G_{F_{\eta,M}}\cong
> \mathrm{Hom}(L^{-1},\mathcal T)$. The coefficient morphism […] is induced by the even differential
> $dF_{\eta,M,+}:\mathcal T_+X_\eta=\mathcal T_C\to i^*\mathcal T_+\overline{\mathfrak
> M}{}^{\varepsilon}_g=\mathcal T$. Under the identifications above, this is precisely the map induced
> by the inclusion $\mathcal T_C\hookrightarrow\mathcal T$. […] Passing to cohomology, this is exactly
> the map $J$ introduced in Section 7. Therefore $j_{F_{\eta,M}}(\omega_2(X_\eta))=J(\eta)$. By
> construction of $\eta$, this class is non-zero. […] functoriality asserts the equality
> $j_{F_{\eta,M}}(\omega_2(X_\eta))=\iota_{F_{\eta,M}}(\omega_2(\overline{\mathfrak
> M}{}^{\varepsilon}_g))$ in $H^1(C,\mathcal G_{F_{\eta,M}})$. Since the left-hand side is
> $J(\eta)\neq0$, we obtain $\iota_{F_{\eta,M}}(\omega_2(\overline{\mathfrak M}{}^{\varepsilon}_g))=
> J(\eta)\neq0$. In particular, $\omega_2(\overline{\mathfrak M}{}^{\varepsilon}_g)\neq0$. By Theorem
> 2.2, non-vanishing of the primary obstruction prevents projectedness. Hence
> $\overline{\mathfrak M}{}^{\varepsilon}_g$ is non-projected."

> "It remains only to obtain both parity components. Elliptic curves admit theta characteristics of
> both parities. Since the genus-$h$ spin curve $(C,L)$ is even, the parity of the compact-type glued
> spin curve is the parity of the elliptic tail:
> $\mathrm{par}\big((C,L,p)\cup_{p=q}(E,M,q)\big)=\mathrm{par}(L)+\mathrm{par}(M)=\mathrm{par}(M)$.
> Choosing $M$ even gives the even compactified component, and choosing $M$ odd gives the odd
> compactified component."

---

## §2 解剖：门槛从哪来，"无穿孔"在哪里被用到

### §2.1 门槛 $g\ge3$ 的**唯一**来源

⟦重述⟧ 追踪 §1 的每一步，$g$ 只在两处出现：

1. $g=h+1$（因为尾巴是**亏格 1** 的椭圆曲线）；
2. Corollary 7.2 要求 $h\ge2$，来自 $h^1(C,L^{-1})=2h-2\ge2$。

于是 $g=h+1\ge3$。**注意 (2) 是不可动摇的**（$h=1$ 时 $\deg L^{-1}=0$，$h^1=0$，根本没有非零的
$\eta$ 可选），而 **(1) 完全是"尾巴亏格"这一个自由选择的结果**。

**⟦重述⟧ 于是本轮的整个想法只有一句话**：

> **CN 之所以必须用亏格 1 的尾巴，是因为在无穿孔情形，亏格 0 的尾巴不稳定**
> （$2\cdot0-2+1=-1<0$：一条 $\mathbb P^1$ 上只有一个特殊点，自同构群无限，不是稳定曲线）。
> **一旦允许穿孔，就可以把旁观穿孔装到尾巴上，尾巴立刻变稳定，于是可以取 $a=0$，省下一个亏格。**

### §2.2 逐处清点："无穿孔"到底在哪里被用到？

| CN 的步骤 | 是否用到"目标空间无穿孔"？ | 说明 |
|---|---|---|
| Prop 2.2（障碍类存在/étale 下降） | **否** | 对任意光滑 DM 超叠成立 |
| Lemma 2.6（函子性） | **否** | 对任意态射成立 |
| §5 的 $X_\eta$，$\omega_2(X_\eta)=\eta$ | **否**（但用到**亏格 $h$ 侧**只有一个 NS 标记点、无 Ramond） | $\Lambda^2\mathcal T_-X_\eta\cong L^{-1}$ 依赖 $L^2\cong\omega_C$（无 Ramond 扭转）；$Y=C$ 射影依赖**没有别的固定标记点** |
| §6 的粘接态射 $\Gamma$ | **否** | FKP (7.8) 本来就是带任意 $(m_i,n_i)$ 的一般形式（§2.3） |
| Lemma 6.1 | **否** | 尾因子只贡献一个**常值**向量丛，其维数无关紧要 |
| Lemma 6.2 | **部分**：$e^*\Psi_1^{-1}\cong L^{-1}$ 用 Example 8.9（NS 穿孔、偶基）；$e^*\Psi_2^{-1}$ 是**常值线**，无需公式 | 关键：Ramond 的复杂性全在尾巴那一侧，而那一侧不需要任何公式 |
| Prop 6.3 | **否** | 纯粹是两条正合列拼图 |
| Lemma 7.1 | **否** | 只用 $H^0(C,L)=0$ 与"$W$ 是常值向量空间"；**$\dim W$ 完全无关紧要** |
| Cor 7.2 | **否**（但要 $h\ge2$ 与 $L^2\cong\omega_C$） | 见 §2.1 |
| §8 宇称 | 用到 $L^2\cong\omega$（宇称良定） | $r=0$ 时成立；$r>0$ 时无宇称分解，见 §5.2 |

**⟦重述⟧ 结论：CN 的论证几乎不依赖"无穿孔"。** 真正依赖无穿孔的只有一处，而且是**隐性**的：
**尾巴的选择**。所有上同调内容都活在亏格 $h$ 一侧，而在那一侧，运动点 $p$ 是**唯一**的特殊点，
于是测试基是整条射影曲线 $C$。

**⟦重述⟧ 特别值得记录的一条观察（Lemma 7.1 的"维数无关性"）**：Lemma 7.1 的证明只用了
$H^0(C,W\otimes L)=W\otimes H^0(C,L)=0$。因此把 $W$ 换成任何**更大**的常值向量空间——例如把
$T_{\xi}S^{\varepsilon}_{1,1}$ 换成 $T_\xi S^{\delta}_{a;n+1,2r}$（维数随 $n,r$ 增长）——
**这一步一字不用改**。这是本轮推广"免费"的技术原因。

### §2.3 FKP 的机器本来就是带穿孔的（逐字核实）

⟦重述⟧ 这是本轮能推广的**外部**原因。三条逐字证据（本轮亲自从 arXiv:2006.13271v3 全文抽取）：

> **(7.8)**：$\overline{\mathfrak S}_{g_1;m_1+1,n_1}\times\overline{\mathfrak S}_{g_2;m_2+1,n_2}
> \longrightarrow\overline{\mathfrak S}_{g_1+g_2;\,m_1+m_2,\,n_1+n_2}$
> （$m$ = NS，$n$ = Ramond；FKP 原文："we can apply the above gluing construction to the pair of
> families of stable supercurves over $\overline{\mathfrak S}_{g_1;m_1+1,n_1}\times\overline{\mathfrak
> S}_{g_2;m_2+1,n_2}$, pulled back from each factor and using the last NS puncture on each of them."）

> **Lemma 7.10**（逐字）："Both morphisms (7.8) and (7.9) induce embeddings of codimension $1|0$ on
> tangent spaces and factor through the divisor $\Delta_{\rm NS}$. Furthermore, near a stable
> supercurve with a single separating (resp., non-separating) NS node, the divisor $\Delta_{\rm NS}$
> coincides with the schematic image of (7.8) (resp., (7.9))."

> **§9.1 + Theorem C**（逐字）："Let $\varphi:B\to\overline{\mathfrak S}$ be the standard gluing map
> covering an NS type boundary component, **i.e., one of the maps (7.8) or (7.9)**, restricted to the
> locus of smooth supercurves. […] $N_B\cong\Psi_1^{-1}\otimes\Psi_2^{-1}$"（式 (9.6)）。

**⟦重述⟧ 也就是说，CN 在 §6 引用的 FKP 的三条结果（Lemma 7.9/7.10、Theorem C/(9.6)），FKP 本来就是
在带任意 NS + Ramond 穿孔的一般性下陈述和证明的。CN 只用了 $m_i=n_i=0$ 的特例。**
本轮要做的不是"把 FKP 的机器推广"（不需要），而是**把 CN 的构造重新装配在 FKP 机器的一般形式上**。

🟡 **`[GAP-FKP-RAMOND]`（低风险，如实记录）**：FKP Lemma 7.9 的**证明正文**在核对广义自旋结构时
写的是 $L\xrightarrow{\sim}\mathrm{Hom}(L,\omega_C)$（**没有** Ramond 扭转 $\omega_C(R)$），
尽管其**陈述**(7.8) 允许 $n_1,n_2>0$ 个 Ramond 穿孔。本文判断这是无害的笔误/省略（粘接是在 NS 节点
的一个邻域内做的局部操作，该邻域可取成与 Ramond 除子不交，把 $\omega_C$ 换成 $\omega_C(R)$ 逐字
不影响论证），但**本文没有独立重写这段证明**，如实标为 `[GAP]`。

---

## §3 负面结论：朴素推广为什么失败（命题 N）

⟦本节全部是本文作者的原创论证⟧

看到"要把穿孔加进来"，最自然的第一反应是：把 $n$ 个旁观 NS 穿孔加在**运动的**亏格 $h$ 分量上，
即把 CN 的 $\mathfrak M^+_{h,1}$ 换成 $\mathfrak M^+_{h,n+1}$。本节证明这条路**必然给出零信息**。

> **命题 N.** 设 $n\ge1$。在亏格 $h$ 的光滑曲线 $C$ 上固定 $n$ 个互不相同的点
> $p_1,\dots,p_n$，考虑"移动第 $n+1$ 个 NS 标记点"所得到的测试族：即沿
> $$e_C^{\circ}\colon\ C^{\circ}:=C\smallsetminus\{p_1,\dots,p_n\}\ \longrightarrow\ S^+_{h;n+1,0},
> \qquad p\longmapsto (C,L,p_1,\dots,p_n,p)$$
> 构造的 Donagi–Witten 型一点障碍族 $X^{\circ}_\eta$。则
> $$(X^{\circ}_\eta)_{\rm bos}=C^{\circ},\qquad H^1(C^{\circ},\mathcal F)=0\ \ \text{对一切凝聚层
> }\mathcal F .$$
> 特别地，主障碍类的**取值空间**为零：$\omega_2(X^\circ_\eta)\in H^1(C^\circ,\mathcal F^{\rm obs})=0$，
> 于是 §1.5 的比较映射 $j_F$ 把它送到零：**该测试族恒定地检测不到任何障碍，对一切 $\eta$。**
> ⚠ 注意结论**不是**"可取的 $\eta$ 只有 $0$"——恰恰相反，带穿孔时奇切空间
> $H^1(C,L^{-1}(-\sum_i p_i))$ 的维数是 $2h-2+n$，比 CN 的 $2h-2$ **更大**。是**取值空间**为零，
> 不是**参数空间**为零。（初稿在此处写反了，订正记录见下方证明第四步后。）

*证明.* 分三步。

**第一步（测试基必须去掉固定点）。** 模问题 $S_{h;n+1,0}$ 的对象是带 $n+1$ 个**两两不同**的标记点的
自旋曲线（FKP §2.6 与 Cornalba/Jarvis 的稳定自旋曲线定义中，光滑曲线上的标记点必须互不相同；否则
所得的族不是 $S_{h;n+1,0}$ 的族）。因此映射 $p\mapsto(C,L,p_1,\dots,p_n,p)$ 在 $p=p_j$ 处无定义，
其最大定义域是 $C^{\circ}=C\smallsetminus\{p_1,\dots,p_n\}$。DW 的一点障碍族是**沿这条曲线**
（万有带点超曲线在固定自旋曲线上的纤维）拉回得到的，故其约化空间恰为 $C^{\circ}$。

**第二步（$C^\circ$ 仿射）。** $C$ 是光滑射影曲线，$n\ge1$，故 $C^\circ$ 是从射影曲线去掉一个非空
有限点集所得，是光滑**仿射**曲线（标准事实：射影曲线减去非空有限集合是仿射的——取一个支撑在
$\{p_1,\dots,p_n\}$ 上的丰沛除子即可）。

**第三步（Serre 消没）。** 仿射概形上凝聚层的高阶上同调为零（Serre）：$H^i(C^\circ,\mathcal F)=0$，
$i\ge1$，**对一切凝聚层 $\mathcal F$**。

**第四步（结论：障碍类的取值空间为零）。** 按 §0，任何光滑 DM 超叠 $\mathfrak X$ 的主障碍类落在
$$\omega_2(\mathfrak X)\in H^1\big(\mathfrak X_{\rm bos},\ \mathcal F^{\rm obs}_{\mathfrak X}\big),$$
而这里 $(X^\circ_\eta)_{\rm bos}=C^\circ$ 由第一步是仿射曲线。故由第三步，**无论系数层是什么**，
$$\omega_2(X^\circ_\eta)\in H^1\big(C^\circ,\ \mathcal F^{\rm obs}\big)=0 .$$
于是 $j_F(\omega_2)=0$，由 Lemma 2.6 只得到平凡等式 $\iota_F(\omega_2(\text{目标}))=0$，
给不出任何非消没信息。$\blacksquare$

> ⚠ **订正记录（2026-09-18 对抗审查）**：本证明初稿在此处写的是"由 §1.2，DW 障碍族的参数恰是
> $\eta\in H^1(Y,L^{-1})$（$Y$ = 约化空间），源空间为零蕴含 $\omega_2=0$"。**这句话是错的**，
> 且错法有教益，故保留记录而非抹去。§1.2 的重述本身没错，但 CN 的无穿孔设定里
> "约化空间 $=C$" 与 "奇切空间 $=H^1(C,L^{-1})$" 是**两件事碰巧算在同一条射影曲线上**；
> 把这个巧合原样搬到带穿孔情形就错了——带穿孔时 $(C,L,p_1,\dots,p_n)$ 处的奇切空间是
> $H^1\big(C,L^{-1}(-\textstyle\sum_i p_i)\big)$（仍算在**射影**曲线 $C$ 上），其维数由
> $\deg L^{-1}(-\sum p_i)=1-h-n$、$\chi=2-2h-n$、$h^0=0$ 得
> $$h^1\big(C,L^{-1}(-\textstyle\sum p_i)\big)=2h-2+n,$$
> 与 $\mathfrak M_{h,n}$ 的奇维数 $2h-2+n$ 吻合。即：可取的 $\eta$ 比 CN 的情形**更多**，不是没有。
> **命题 N 的结论不受影响，且论证反而更强**——不是"没有 $\eta$ 可试"，而是"$\eta$ 比 CN 还多，
> 却依然一个都测不到"。上面第四步给出的是修正后的正确论证，它根本不需要谈 $\eta$ 的取值范围，
> 只需要 $\omega_2$ 的**取值空间**为零。
>
> 等价的另一条写法（若要显式连回 $\eta$）：CN Proposition 2.2 逐字 **"It is compatible with étale
> pullback"**，而开浸入 $C^\circ\hookrightarrow C$ 是étale，故 $\omega_2(X^\circ_\eta)=
> \eta|_{C^\circ}\in H^1(C^\circ,L^{-1})=0$。两条写法都对，第四步那条更短且不依赖 $\eta$ 的形状。

> **推论 N′（非分离粘接同样被杀死）。** FKP 的非分离 NS 粘接态射
> $(7.9)\colon\overline{\mathfrak S}_{g;m+2,n}\to\overline{\mathfrak S}_{g+1;m,n}$
> 要求被粘的两个 NS 穿孔在**同一条**曲线上。若用它承载本方法，两个被粘点中必须有一个是运动点 $p$、
> 另一个是 $C$ 上的固定点 $q$，于是测试基是 $C\smallsetminus\{q\}$，仍是仿射曲线，命题 N 的第二至
> 第四步逐字适用。**故本方法无法使用非分离粘接。**

> **推论 N″（"把 Ramond 穿孔放在运动分量上"同样被杀死）。** 同上，且额外地：亏格 $h$ 侧若带
> Ramond 除子 $R\neq0$，则 $L^{\otimes2}\cong\omega_C(R)$，§1.2 的识别
> $\Lambda^2\mathcal T_-X_\eta\cong L^{-1}$ 与 $\mathcal T_+X_\eta\cong L^{-2}$ 同时失效，
> Lemma 7.1 的"$\mathrm{Hom}(L^{-1},\mathcal T_C)\cong L^{-1}$"这一步也失效。

**⟦重要的诚实声明⟧ 命题 N 不是"$\overline{\mathfrak S}_{g;n,2r}$ 是投影的"**，甚至不是"这条路一定
不行"的元定理——它只断言**这一族具体的测试曲线恒等于零**。但它足以说明：**穿孔不能放在运动分量上**，
从而**唯一**剩下的装法是放在固定尾上。下一节说明这样装恰好可行。

**⟦副产品⟧** 命题 N 也给出 CN 的构造为何"必须是分离粘接 + 常值尾"的结构性解释——在 CN 的论文里这是
一个未加解释的构造选择，本文指出它是被仿射性障碍**强制**的。

---

## §4 推广：把旁观穿孔装到固定尾上

⟦本节除明确标注为引用的部分外，全部是本文作者的论证。每条引理都注明它与 CN 对应引理的关系：
**"逐字相同"**（把 CN 的证明一字不改地搬过来即可）或 **"需要修改"**（并写出修改）。⟧

### §4.0 预备：两条基础引理

> **引理 4.1（玻色截断）。** 对一切 $g,m,n$（$n$ 偶），
> $$\big(\overline{\mathfrak S}_{g;m,n}\big)_{\rm bos}\ \cong\ \overline S_{g;m,n},$$
> 即带 $m$ 个 NS 穿孔、$n$ 个 Ramond 穿孔的**稳定自旋曲线**模叠（光滑固有 DM 叠）。

*证明.* 设 $\mathfrak X$ 是 $\mathbb C$ 上的超叠，$S$ 是**纯偶**（普通）概形。任一态射
$\varphi\colon S\to\mathfrak X$ 在结构层上给出 $\varphi^{\#}\colon\mathcal O_{\mathfrak X}\to
\varphi_*\mathcal O_S$；由于 $\mathcal O_S$ 没有奇部分，$\varphi^\#$ 把一切奇截面打到 $0$，
从而把它们生成的理想层 $\mathcal J$ 打到 $0$，于是唯一地分解过
$\mathcal O_{\mathfrak X}/\mathcal J=\mathcal O_{\mathfrak X_{\rm bos}}$。故
$$\mathrm{Hom}(S,\mathfrak X)=\mathrm{Hom}(S,\mathfrak X_{\rm bos})\quad\text{对一切纯偶 }S,$$
即 $\mathfrak X_{\rm bos}$ 表示 $\mathfrak X$ 的函子在纯偶基上的限制。

另一方面，FKP-A §2.6 逐字：**"If we only consider even bases, the functor of (stable) supercurves
with punctures coincides with the functor of stable curves with punctures equipped with generalized
spin structures"**，而该自旋函子由 $\overline S_{g;m,n}$ 表示，且 FKP-A §2.6 逐字记载
**"The moduli stack $S_{g,n_{\rm NS},n_{\rm R}}$ of stable spin curves of genus $g$ with $n_{\rm NS}$
NS-punctures and $n_{\rm R}$ Ramond punctures (where $n_{\rm R}$ is necessarily even) was studied in
[22], [23] […] In particular, it [is] shown to be a smooth proper Deligne–Mumford stack."**

两个叠若在纯偶基上表示同一个函子，则典范同构。$\blacksquare$

⟦注⟧ CN 在无穿孔情形逐字断言了同一件事（§3.1："In the unpunctured case, the bosonic truncation of
$\overline{\mathfrak M}{}^{\pm}_g$ is the compactified spin stack $\overline S{}^{\pm}_g$"）。
引理 4.1 只是把它写成带穿孔的一般形式并补上证明。

> **引理 4.2（固定尾存在性）。** 设 $a\ge0$、$n\ge0$、$r\ge0$ 满足 $2a-2+(n+1)+2r>0$。则存在
> 一条光滑亏格 $a$ 曲线 $F$，其上 $n+1+2r$ 个两两不同的点
> $q,y_1,\dots,y_n,\rho_1,\dots,\rho_{2r}$，以及线丛 $N$ 使
> $$N^{\otimes2}\cong\omega_F\big(\rho_1+\dots+\rho_{2r}\big).$$
> 且该数据是 $\overline S_{a;n+1,2r}$ 的一个 $\mathbb C$-点，位于光滑轨迹 $S_{a;n+1,2r}$ 内。
> 特别地：
> - $a=0$ 时（需 $n+2r\ge2$）：$\omega_{\mathbb P^1}(\rho)=\mathcal O(2r-2)$，故
>   $N=\mathcal O_{\mathbb P^1}(r-1)$，**唯一**；$r=0$ 时 $N=\mathcal O(-1)$，$h^0=0$，**偶**。
> - $a=1$ 且 $r=0$ 时：$N^{\otimes2}\cong\mathcal O_E$，四个 theta 特征，$\mathcal O_E$ 为**奇**，
>   三个非平凡 $2$-挠为**偶**（CN §6 逐字）。

*证明.* 取任意亏格 $a$ 的光滑曲线 $F$ 与其上 $n+1+2r$ 个互异点（$a=0$ 时 $\mathbb P^1$ 上任取；
$\mathbb C$ 上恒可）。$\deg\big(\omega_F(\rho)\big)=2a-2+2r$ 是偶数。在光滑射影曲线上，
$\mathrm{Pic}^0(F)$ 是复环面，特别是**可除**阿贝尔群，故任何偶次线丛都有平方根：取
$\deg$ 为 $a-1+r$ 的任一线丛 $N_0$，则 $\omega_F(\rho)\otimes N_0^{-2}\in\mathrm{Pic}^0(F)$
有平方根 $\alpha$，令 $N:=N_0\otimes\alpha$。稳定性（$\mathrm{Aut}$ 有限）等价于
$2a-2+\#\{\text{标记点}\}>0$，即 $2a-2+(n+1)+2r>0$，这正是前提。$a=0$ 的唯一性来自
$\mathrm{Pic}(\mathbb P^1)=\mathbb Z$；$a=1,r=0$ 的宇称统计是经典事实。$\blacksquare$

### §4.1 构造（与 CN §6 逐行对照）

固定满足 `claim.md` **(P1)(P2)** 的 $h,a,n,r$，令 $g=h+a$。固定：

- $(C,L)$：亏格 $h\ge2$ 光滑曲线 + **无效偶** theta 特征（$L^{\otimes2}\cong\omega_C$，
  $H^0(C,L)=0$）；存在性见 §1.2 引用的 Mumford/Cornalba。
- $\xi=(F,N;q,y_1,\dots,y_n;\rho_1,\dots,\rho_{2r})$：引理 4.2 给出的**固定尾**，视为光滑超模叠
  $\mathfrak S_{a;n+1,2r}(\mathbb C)$ 的一个点（偶基上超曲线 $=$ 自旋曲线，FKP-A §2.6）。
  记 $A:=\mathrm{Aut}(\xi)$，由 $\mathfrak S_{a;n+1,2r}$ 是 DM（FKP-A Theorem A + 开子叠）且 $\xi$
  稳定，$A$ 有限 étale。

定义（**与 CN §6 逐字平行，只把第二因子换掉**）：

$$\mathcal B:=\underbrace{\mathfrak S^+_{h;1,0}}_{=\ \text{CN 的}\ \mathfrak M^+_{h,1}}\times\ \mathfrak
S_{a;n+1,2r},\qquad
\mathcal B_{\rm bos}=S^+_{h;1,0}\times S_{a;n+1,2r}\ \ (\text{引理 }4.1),$$

$$\Gamma\colon\ \mathcal B\ \longrightarrow\ \overline{\mathfrak S}_{g;n,2r}
\qquad\text{（FKP-A 式 (7.8)，取 }g_1=h,\ m_1=0,\ n_1=0;\ g_2=a,\ m_2=n,\ n_2=2r\text{）}$$

——注意 (7.8) 的输出恰是 $\overline{\mathfrak S}_{g_1+g_2;m_1+m_2,n_1+n_2}=
\overline{\mathfrak S}_{h+a;n,2r}$ ✓，即：**运动分量上那一个 NS 穿孔与尾巴上的 $q$ 被粘成一个
分离 NS 节点，尾巴上的 $y_i$ 与 $\rho_j$ 原样保留为结果曲线上的 $n$ 个 NS 穿孔与 $2r$ 个 Ramond
穿孔。**

$$\tau_\xi\colon\ \mathfrak S^+_{h;1,0}\to\mathcal B,\quad \mathcal X\mapsto(\mathcal X,\ \xi_S)
\qquad\text{（常值尾，CN §6 逐字同样的定义）},$$
$$G_\xi:=\Gamma\circ\tau_\xi\colon\ \mathfrak S^+_{h;1,0}\to\overline{\mathfrak S}_{g;n,2r},\qquad
F_{\eta,\xi}:=G_\xi\circ u_\eta\colon\ X_\eta\to\overline{\mathfrak S}_{g;n,2r}.$$

玻色截断上：
$$e_C\colon C\to S^+_{h;1,0},\ p\mapsto(C,L,p);\qquad e:=\tau_{\xi,\rm bos}\circ e_C;\qquad
i:=\Gamma_{\rm bos}\circ e\colon C\to\overline S_{g;n,2r},$$
$$i(p)=(C,L,p)\ \cup_{p=q}\ (F,N;y_\bullet;\rho_\bullet).$$

**⭐ 构造的全部新意就在这一行**：CN 的第二因子是 $\mathfrak M^{\varepsilon}_{1,1}$（亏格 1、一个 NS
点）；这里换成 $\mathfrak S_{a;n+1,2r}$（亏格 $a$、$n+1$ 个 NS 点、$2r$ 个 Ramond 点）。
**第一因子一字未动**——这正是下面所有引理能"逐字搬运"的原因。

### §4.2 切层计算（CN Lemma 6.1 的推广）

> **引理 4.3。** 沿 $e\colon C\to\mathcal B_{\rm bos}$ 有正合列
> $$0\longrightarrow\mathcal T_C\longrightarrow e^*\mathcal T\mathcal B_{\rm bos}\longrightarrow
> W\otimes\mathcal O_C\longrightarrow0,\qquad
> W:=H^1(C,\mathcal T_C)\oplus T_{\xi_{\rm bos}}S_{a;n+1,2r},$$
> 其中 $W$ 是一个**固定的有限维向量空间**。

*证明（与 CN Lemma 6.1 的证明逐字相同，逐条核对修改点）.*

- **第一因子**：$S^+_{h;1,0}\to S^+_h$ 是光滑自旋模叠上的万有带点曲线。沿 $e_C$ 拉回其切列得
  $0\to\mathcal T_C\to e_C^*\mathcal T S^+_{h;1,0}\to T_{(C,L)}S^+_h\otimes\mathcal O_C\to0$；
  由光滑自旋模叠在普通曲线模叠上有限 étale，$T_{(C,L)}S^+_h\cong H^1(C,\mathcal T_C)$。
  **这一段与 CN 完全相同，因为第一因子未被改动。**
- **第二因子**：$e$ 在第二因子上是**常值**（等于叠论点 $\xi_{\rm bos}$），故
  $e^*\mathrm{pr}_2^*\mathcal T S_{a;n+1,2r}\cong T_{\xi_{\rm bos}}S_{a;n+1,2r}\otimes\mathcal O_C$。
  **唯一的修改**：常值向量空间从 $T_{\xi}S^{\varepsilon}_{1,1}$（维数 $1$）换成
  $T_{\xi}S_{a;n+1,2r}$（维数 $3a-3+(n+1)+2r$）。CN 的论证对这个空间**只用到它是有限维常值**，
  不用它的维数。
- **剩余 gerbe**：$A=\mathrm{Aut}(\xi)$ 有限 étale，故剩余 gerbe 不贡献无穷小切方向；全部计算在
  沿 $e$ 拉回到 $C$ 之后进行，不取 $A$-不变部分。**与 CN 逐字相同的论证。**

两因子相加即得所述正合列。$\blacksquare$

### §4.3 法线计算（CN Lemma 6.2 的推广）——**这里是唯一需要小心的一步**

> **引理 4.4。** 记 $N_{\mathcal B}:=\mathcal O(\Delta_{\rm NS})|_{\mathcal B}$ 为粘接态射
> $\Gamma$ 的法线。则
> $$e^*N_{\mathcal B}\ \cong\ L^{-1}\otimes\mathfrak n,$$
> 其中 $\mathfrak n:=\big(\Psi_2^{-1}\big)\big|_{\xi}$ 是一个**一维 $\mathbb C$-向量空间**
> （尾巴的粘接穿孔 $q$ 处的逆 NS psi-线的纤维）。

*证明.*

**(a) 法线公式在带穿孔的一般性下成立。** FKP-A §9.1（p.58）逐字：**"Let $\iota:B\to\overline S$
be the standard gluing map covering an NS type boundary component, i.e., one of the maps (7.8) or
(7.9), restricted to the locus of smooth supercurves"**。我们的 $\Gamma$ 正是 (7.8)（见 §4.1），
且 $\mathcal B$ 写成的是**未紧化**的两个因子，正落在"光滑超曲线轨迹"里，故 setup 逐字适用。

🔴 **引用必须走哪一条路（2026-09-18 对抗审查后改正，改正前的引用是错的）**：FKP-A 把法丛公式给了
**两次**，走两条独立路线，而**只有第二条**对带穿孔的靶成立——

- **路线 1（p.58 底–p.59 顶，不可用）**：经超 Mumford 同构 (8.11)。该处的
  $N_B\cong\Psi_1^{-1}\otimes\Psi_2^{-1}$ 是**无编号显示式（p.59）**，不是 (9.6)。它确实能挺过穿孔，
  但**不是免费的**：旁观穿孔的 $\Psi_j$ 会同时出现在两边（$B$ 侧来自两因子各自的 (8.11)，
  $\overline S$ 侧来自粘接后曲线的 (8.11)，且 $\iota^*\Psi_j=\Psi_j$ 因为就是同一批穿孔）并相消，
  此外还需额外论证 $\mathcal O(\Delta_R)|_B\cong\mathcal O_B$。本文**不走这条**。
- **路线 2（p.60 底–p.61，本文所用）**：经 NS 边界线丛的定义 (7.6)。FKP-A p.61 逐字：
  > "$\mathcal O(\Delta)|_B\simeq\operatorname{Ber}R\pi_*(j_*\Omega_{U/S})|_B\otimes
  >  \operatorname{Ber}^{-1}R\pi_*(\Omega_{X/S}|_B)\simeq\Psi_1^{-1}\Psi_2^{-1}$."  (9.6)
  这条路线整个跑在 **Lemma 9.1(iii)(iv)（p.59）**上，而该引理涉及的层 $\mathcal K$ 与
  $\tilde{\mathcal C}$ 按 FKP-A 原文逐字是 **"supported on the node"**。**没有任何穿孔进入这条推导**，
  故它是**真正与穿孔无关的**那一条。

  ⚠ **不得引 Theorem C。** FKP-A p.2 的 Theorem C 陈述逐字是 "Let $B\to\overline{\mathcal S}_g$ be
  the gluing map to one of the components of $\Delta_{NS}$ from a lower genus (uncompactified) moduli
  space $B$"——靶是**无穿孔**的 $\overline{\mathcal S}_g$；对照同页 Theorem B 明写
  "Let $\overline{\mathcal S}=\overline{\mathcal S}_{g,n_{NS},n_R}$"，可见 FKP-A 是**刻意区分**的。
  Theorem C 允许**源** $B$ 带穿孔，但不允许**靶**带穿孔，而本文恰恰需要带穿孔的靶。
  本文初稿误引 Theorem C，已改正为 §9.1 / Lemma 9.1(iii)(iv) / (9.6)（pp.59–61）。

$\Psi_1$ 来自第一因子、$\Psi_2$ 来自第二因子，理由**不是**（初稿所引的）§9.1 那句 exterior product
——那句话的主语被略去了，而略去的主语是 Berezinian 线丛 $\mathcal B(\mathcal O_{\tilde X})$，不是
$\Psi$（FKP-A p.58 逐字："Note that in the case of a separating node, where $B=S_1\times S_2$,
the line bundle $\mathcal B(\mathcal O_{\tilde X})$ is the exterior product of two similar line
bundles on the factors $S_1$ and $S_2$."）。正确理由是 $\Psi$ **自身的定义**加平坦基变换：
FKP-A p.57（Lemma 8.7 证明末）逐字 "$\Psi\simeq\tilde\Psi\simeq\pi_*(I_P/I_D)$" 与
"$P^*\omega_{D/S}\simeq\operatorname{Ber}(\Psi)=\Psi^{-1}$"——定义里的每个对象都算在第 $i$ 个穿孔的
除子 $D_i$ 上；对 $\mathcal B=S_1\times S_2$，万有曲线是
$\tilde X=\mathrm{pr}_1^*\tilde X_1\sqcup\mathrm{pr}_2^*\tilde X_2$，故 $\Psi_2=\mathrm{pr}_2^*\Psi_{P_2}$。

**(b) $\Psi_1$ 侧：与 CN 逐字相同。** 第一因子 $\mathfrak S^+_{h;1,0}$ 上**恰好一个 NS 穿孔、
零个 Ramond 穿孔**，即 CN Lemma 6.2 处理的完全相同的情形。由 FKP-A Example 8.9（偶基上
$\Psi_i^{-1}$ 等同于该点处逆自旋线的纤维），沿 $e_C$（基是 $C$，族是固定自旋曲线 $(C,L)$ 配运动
标记点 $p$）得
$$e^*\Psi_1^{-1}\cong L^{-1}.$$
**注意：Example 8.9 只在这一侧被使用，而这一侧没有任何 Ramond 穿孔**，故其"NS-punctures over an
even base"的前提逐字满足。

**(c) $\Psi_2$ 侧：不需要任何公式。** 尾巴沿 $e$ 是**常值**的，故 $e^*\Psi_2^{-1}$ 是常值线丛
$\mathfrak n\otimes\mathcal O_C$，$\mathfrak n$ 为一维向量空间。**下文只用到"它是一条线"，
从不用它等于什么。**

合并 (a)(b)(c) 即得。$\blacksquare$

> **⭐ 评注（本轮方法论上最关键的一点）。** CN 在 Lemma 6.2 中把 $\mathfrak n$ 算成 $M_q^{-1}$，
> 用的是 Example 8.9。在带 Ramond 穿孔的尾巴上，Example 8.9 的陈述（"a family of supercurves with
> NS-punctures"）不直接覆盖，$\Psi$-线与广义自旋结构的关系需要重新核对。
> **本证明通过"不去算 $\mathfrak n$"完全绕开了这个问题**：因为尾巴是常值的，$\mathfrak n$ 只能是
> 一条常值线，而 Lemma 7.1 的论证只需要 $h^0(C,\mathcal O_C\otimes\mathfrak n)=1$。
> **Ramond 穿孔带来的全部技术复杂性都被隔离在常值因子里，而常值因子不需要任何公式。**
> 这就是"把穿孔装到固定尾上"这个选择的真正回报。

### §4.4 偶切商（CN Proposition 6.3 的推广）

> **命题 4.5。** 令 $\mathcal T:=i^*\mathcal T_+\overline{\mathfrak S}_{g;n,2r}\cong
> i^*\mathcal T\overline S_{g;n,2r}$（后一同构由 §0 的标准识别 $\mathcal T_+\cong\mathcal T_X$ 与
> 引理 4.1 给出）。$di$ 给出单射 $\mathcal T_C\hookrightarrow\mathcal T$。令
> $Q:=\mathcal T/\mathcal T_C$，则 $Q$ 有两步滤过
> $$0\subseteq Q_0\subseteq Q,\qquad Q_0\cong W\otimes\mathcal O_C,\qquad
> Q/Q_0\cong L^{-1}\otimes\mathfrak n .$$

*证明（与 CN Proposition 6.3 的证明逐字相同）.* 由 FKP-A Lemma 7.10——逐字：**"Both morphisms
(7.8) and (7.9) induce embeddings of codimension $1|0$ on tangent spaces and factor through the
divisor $\Delta_{\rm NS}$. Furthermore, near a stable supercurve with a single separating […] NS
node, the divisor $\Delta_{\rm NS}$ coincides with the schematic image of (7.8)"**——沿 $e$ 拉回
边界包含的切列得
$$0\longrightarrow e^*\mathcal T\mathcal B_{\rm bos}\longrightarrow\mathcal T\longrightarrow
e^*N_{\mathcal B}\longrightarrow0 .$$
与引理 4.3 给出的 $0\to\mathcal T_C\to e^*\mathcal T\mathcal B_{\rm bos}\to W\otimes\mathcal O_C\to0$
拼接。⚠ **这一步不是蛇引理**（初稿如此标注，2026-09-18 订正）：它是两步滤过
$\mathcal T_C\subset e^*\mathcal T\mathcal B_{\rm bos}\subset\mathcal T$ 的**第三同构定理**，
令 $Q:=\mathcal T/\mathcal T_C$、$Q_0:=e^*\mathcal T\mathcal B_{\rm bos}/\mathcal T_C
\cong W\otimes\mathcal O_C$，即得 $0\to W\otimes\mathcal O_C\to Q\to e^*N_{\mathcal B}\to0$。
（结论不变；本命题断言的本来就是一个**两步滤过**，不是分裂。）
由引理 4.4，$e^*N_{\mathcal B}\cong L^{-1}\otimes\mathfrak n$。$\blacksquare$

> ⭐ **[GAP-IMM] 已关闭（2026-09-18 对抗审查）。** 初稿担心上面那条切列需要 $\Gamma$ 是闭浸入才合法。
> **不需要。** FKP-A Lemma 7.10（p.48）逐字：**"Both morphisms (7.8) and (7.9) induce embeddings of
> codimension $1|0$ on tangent spaces and factor through the divisor $\Delta_{NS}$."** 故 $d\Gamma$ 有
> **常余秩 $1|0$**，从而 $\operatorname{coker}(d\Gamma)$ 局部自由、秩 $1|0$；它与
> $\mathcal O(\Delta_{NS})|_B=N_{\mathcal B}$ 的等同正是该引理证明（p.49）里那句逐字
> **"Using the fact that the morphism on tangent spaces is an embedding with the image which is the
> orthogonal to $dt$, we deduce that near this point $\Delta_{NS}$ is the schematic image of the
> morphism."**（$t$ = $\Delta_{NS}$ 的局部方程）。**局部自由层短正合列沿 $e$ 的拉回是正合的**，
> 故上面那条列无需任何闭浸入假设。闭浸入只有在要把 $\mathcal T$ 认同为某个真子概形的切层时才需要，
> 而本文的 $\mathcal T$ 是**定义**为 $i^*\mathcal T_+\overline{\mathfrak S}$ 的拉回，
> 不是任何像的内蕴对象。
> ⚠ 另记：FKP-A Lemma 7.10 本身是**带穿孔一般性**的——其证明（p.48）开头逐字
> "Let $X$ be a stable supercurve with punctures and a fixed NS-node $q\in X$"，并括注
> "(where we take into account all the punctures on both sides)"；同页 (7.8) 的显示式
> $\overline S_{g_1;m_1+1,n_1}\times\overline S_{g_2;m_2+1,n_2}\to\overline S_{g_1+g_2;m_1+m_2,n_1+n_2}$
> 与本文 §4.1 的指标取法（$g_1=h,m_1=0,n_1=0$；$g_2=a,m_2=n,n_2=2r$）逐字吻合。

⟦修改点清单（相对 CN）⟧：仅两处，且都不影响论证结构——(i) $W$ 的第二个直和项换成
$T_\xi S_{a;n+1,2r}$；(ii) $M_q^{-1}$ 换成抽象的一维空间 $\mathfrak n$。

### §4.5 障碍存活（CN Lemma 7.1 / Corollary 7.2 的推广）

定义（与 CN §7 逐字相同）
$$J\colon\ H^1(C,L^{-1})\longrightarrow H^1\big(C,\mathrm{Hom}(L^{-1},\mathcal T)\big)
=H^1(C,\mathcal T\otimes L),$$
由包含 $\mathcal T_C\cong L^{-2}\hookrightarrow\mathcal T$ 诱导。

> **引理 4.6。** $\dim\ker J\le1$。

*证明（CN Lemma 7.1 的证明逐字搬运，只替换两处记号）.* 对
$0\to\mathcal T_C\to\mathcal T\to Q\to0$ 施用 $\mathrm{Hom}(L^{-1},-)=(-)\otimes L$，用
$\mathcal T_C\cong L^{-2}$ 得
$$0\to L^{-1}\to\mathcal T\otimes L\to Q\otimes L\to0 .$$
长正合列含 $H^0(C,Q\otimes L)\xrightarrow{\delta}H^1(C,L^{-1})\xrightarrow{J}H^1(C,\mathcal T\otimes L)$，
故 $\ker J=\mathrm{im}\,\delta$，$\dim\ker J\le h^0(C,Q\otimes L)$。

由命题 4.5，$\otimes L$ 后有正合列
$$0\to W\otimes L\to Q\otimes L\to \mathcal O_C\otimes\mathfrak n\to0 .$$
（这里用了 $(L^{-1}\otimes\mathfrak n)\otimes L\cong\mathcal O_C\otimes\mathfrak n$。）取整体截面：
$$H^0(C,W\otimes L)=W\otimes H^0(C,L)=0\quad(\because\ L\ \text{无效}),$$
故 $H^0(C,Q\otimes L)\hookrightarrow H^0(C,\mathcal O_C)\otimes\mathfrak n$，于是
$$h^0(C,Q\otimes L)\le h^0(C,\mathcal O_C)\cdot\dim\mathfrak n=1\cdot1=1 .$$
故 $\dim\ker J\le1$。$\blacksquare$

**⭐ 注意这条证明对 $\dim W$ 完全不敏感**：无论尾巴的模空间有多大（$\dim T_\xi S_{a;n+1,2r}
=3a-3+n+1+2r$ 随 $n,r$ 线性增长），$H^0(C,W\otimes L)=W\otimes H^0(C,L)$ 都是 $0$。
**这是整个推广"免费"的技术根源**（§2.2 末段已预告）。

> **推论 4.7。** 若 $h\ge2$，则存在 $\eta\in H^1(C,L^{-1})$ 使 $J(\eta)\neq0$。

*证明（CN Corollary 7.2 的证明逐字搬运）.* 由 $L^{\otimes2}\cong\omega_C$ 得 $\deg L=h-1$，
$\deg L^{-1}=1-h<0$，故 $H^0(C,L^{-1})=0$。Riemann–Roch：
$\chi(C,L^{-1})=\deg L^{-1}+1-h=2-2h$，故 $h^1(C,L^{-1})=2h-2$。$h\ge2$ 时源空间维数
$\ge2>1\ge\dim\ker J$（引理 4.6），故 $\ker J\subsetneq H^1(C,L^{-1})$，取 $\eta\notin\ker J$。
$\blacksquare$

⟦注：这里 $L^{\otimes2}\cong\omega_C$ **不带 Ramond 扭转**，因为**亏格 $h$ 一侧没有 Ramond 穿孔**
——这正是 §3 推论 N″ 指出的、必须把 Ramond 穿孔放到尾巴上的第二个理由。⟧

### §4.6 定理 M 的证明

> **定理 M（重述，见 `claim.md` §2）。** 设 $h\ge2$，$a,n,r\ge0$ 满足 $2a-2+(n+1)+2r>0$，
> $g=h+a$。则 $\omega_2(\overline{\mathfrak S}_{g;n,2r})\neq0$，故
> $\overline{\mathfrak S}_{g;n,2r}$ 非投影。

*证明.* 取 §4.1 的全部数据与推论 4.7 给出的 $\eta$，构造
$F_{\eta,\xi}\colon X_\eta\to\overline{\mathfrak S}_{g;n,2r}$。

**第一步（比较层的识别）。** 由 §1.2（DW，经 CN §5），
$\Lambda^2\mathcal T_-X_\eta\cong L^{-1}$，$\mathcal T_+X_\eta\cong\mathcal T_C\cong L^{-2}$，
$\omega_2(X_\eta)=\eta\in H^1(C,L^{-1})$。CN Lemma 2.6 的比较层为
$$\mathcal G_{F}=\mathrm{Hom}\big(\Lambda^2\mathcal T_-X_\eta,\ i^*\mathcal T_+\overline{\mathfrak
S}_{g;n,2r}\big)\cong\mathrm{Hom}(L^{-1},\mathcal T)=\mathcal T\otimes L .$$

**第二步（系数态射就是 $J$）。** $j_F$ 由偶微分
$dF_+\colon\mathcal T_+X_\eta=\mathcal T_C\to i^*\mathcal T_+\overline{\mathfrak S}_{g;n,2r}
=\mathcal T$ 诱导，而 $dF_+$ 在上述识别下正是包含 $\mathcal T_C\hookrightarrow\mathcal T$
（$F$ 的玻色截断是 $i$，$i$ 的微分把 $C$ 的切方向送进目标的切方向）。取上同调即 §4.5 的 $J$。故
$$j_F\big(\omega_2(X_\eta)\big)=J(\eta)\neq0 .$$

**第三步（函子性）。** 对 $F\colon X_\eta\to\overline{\mathfrak S}_{g;n,2r}$ 施用 CN Lemma 2.6
（前提：两边都是光滑 DM 超叠——$X_\eta$ 是 $(1|2)$ 维超流形，
$\overline{\mathfrak S}_{g;n,2r}$ 由 FKP-A Theorem A 光滑固有 DM ✓）：
$$\iota_F\big(\omega_2(\overline{\mathfrak S}_{g;n,2r})\big)=j_F\big(\omega_2(X_\eta)\big)=J(\eta)\neq0
\quad\text{in }H^1(C,\mathcal G_F).$$
特别地 $\omega_2(\overline{\mathfrak S}_{g;n,2r})\neq0$。

**第四步。** 由 CN Proposition 2.2，第一障碍非零蕴含非投影。$\blacksquare$

### §4.7 宇称加细（$r=0$）

> **命题 4.8。** 设 $r=0$。则 $i(C)$ 落在宇称分量 $\overline S{}^{\varepsilon}_{g;n,0}$ 中，
> $\varepsilon=\mathrm{par}(N)$，从而
> $\omega_2\big(\overline{\mathfrak S}{}^{\varepsilon}_{g;n,0}\big)\neq0$。

*证明.* $r=0$ 时广义自旋结构满足 $L^{\otimes2}\cong\omega$（无 Ramond 扭转，FKP-A §2.6），
故宇称 $h^0\bmod2$ 在 $\overline S_{g;n,0}$ 上局部常值（Mumford；Cornalba 对稳定自旋曲线），
$\overline S_{g;n,0}=\overline S{}^+_{g;n,0}\sqcup\overline S{}^-_{g;n,0}$。

被测试的曲线是紧型（compact type）NS 节点曲线 $Z=C\cup_{p=q}F$，其广义自旋层由 FKP-A Lemma 7.9
的证明给出为 $j_*L\oplus j'_*N$（逐字："$\mathcal O_Z\cong\mathcal O_{Z_0}\oplus j_*L\oplus
j'_*L'$"，NS 节点处自旋层不是局部自由，等于两支的直像之和）。故
$$h^0(Z,\ j_*L\oplus j'_*N)=h^0(C,L)+h^0(F,N),\qquad
\mathrm{par}(Z)=\mathrm{par}(L)+\mathrm{par}(N)=\mathrm{par}(N),$$
末一步用 $L$ 为**偶**。于是整条 $i(C)$ 落在宇称 $\varepsilon=\mathrm{par}(N)$ 的分量内。
由于 $H^1$ 在不交并上分解为直和，定理 M 第三步得到的非零类落在该分量的 $H^1$ 里，故
$\omega_2(\overline{\mathfrak S}{}^{\varepsilon}_{g;n,0})\neq0$。$\blacksquare$

**`[GAP-COMP]`（$r>0$ 时的分量识别，风险：低，纯属加细）**：当 $r>0$ 时
$L^{\otimes2}\cong\omega(R)$，Mumford 的宇称不变性论证不再适用，$\overline S_{g;n,2r}$ 是否连通、
以及它的连通分量由什么离散不变量标号，本文**未确定**。因此定理 M 只断言**整个叠**
$\overline{\mathfrak S}_{g;n,2r}$ 非投影（这在逻辑上是完备的：$\omega_2\neq0$ 即可），
**不断言**是哪个连通分量。若后续要把结论加细到分量层面，需要补 $\overline S_{g;n,2r}$ 的分量分类。

---

## §5 门槛：把 (P1)(P2) 翻译成 $(g,n,r)$

### §5.1 推论 A / B 的推导

(P1) $h\ge2$，(P2) $2a-2+(n+1)+2r>0$，$g=h+a$。

- **$a=1$**：(P2) 化为 $n+1+2r>0$，恒真。$h=g-1\ge2\iff g\ge3$。
  宇称（$r=0$）：尾巴是带 $n+1$ 个 NS 标记点的亏格 1 自旋曲线，$N^{\otimes2}\cong\mathcal O_E$
  （NS 穿孔不扭转 $\omega$！），**两种宇称都存在**（引理 4.2）。
  ⟹ **推论 A(1)**：$g\ge3$，任意 $n\ge0$，两种宇称，$\overline{\mathfrak S}{}^\varepsilon_{g;n,0}$
  非投影。
  ⟹ 以及 $r\ge0$ 任意时 $\overline{\mathfrak S}_{g;n,2r}$ 非投影（$g\ge3$）。
- **$a=0$**：(P2) 化为 $n+2r\ge2$。$h=g\ge2$。
  宇称（$r=0$，须 $n\ge2$）：$N=\mathcal O_{\mathbb P^1}(-1)$，$h^0=0$，**偶**。
  ⟹ **推论 A(2)**：$g\ge2$，$n\ge2$，$\overline{\mathfrak S}{}^{+}_{g;n,0}$ 非投影。
  ⟹ **推论 B**：$g\ge2$，$n\ge0$，$r\ge1$（此时 $n+2r\ge2$ 自动），
  $\overline{\mathfrak S}_{g;n,2r}$ 非投影。

合并：$\overline{\mathfrak S}_{g;n,2r}$ 非投影，只要 $g\ge3$，或（$g=2$ 且 $n+2r\ge2$）。

**机器复核（范围要说准）**：§5.1 的闭式判据与 §5.3 的"$a\in\{0,1\}$ 已够"是纯整数算术，已由
`scripts/thresholds.py` 在 $g\le8,\ n\le6,\ r\le4,\ a\le6$ 范围内穷举复核。
运行方式与预期输出见该脚本头部与末尾注释（2026-09-18 实跑：`RESULT: ALL OK`，退出码 0）。
⚠ **订正（2026-09-18 对抗审查）**：初稿把 §6.1/§6.2 的两条自洽性检验也算进"已由脚本穷举复核"，
**这是夸大**——脚本只能核对整数算术，核不了 §6.1"构造退化到 CN"这一结构性断言，也核不了 §6.2
关于奇分量的结构性断言。那两条是**人工核对**的（作者 + 2026-09-18 独立对抗审查各一次），
脚本对它们只提供了必要条件层面的算术一致性。

### §5.2 为什么 $h\ge2$ 不能再降

$h=1$：$\deg L^{-1}=0$，$L$ 是 $E$ 上的 theta 特征。若 $L$ 偶（非平凡 $2$-挠），
$h^0(E,L^{-1})=0$ 且 $h^1(E,L^{-1})=h^0(E,L)^\vee=0$（Serre 对偶 + $\omega_E=\mathcal O$）。
于是 $H^1(C,L^{-1})=0$，**根本没有非零的 $\eta$**。$h=0$ 同理（$L=\mathcal O(-1)$，
$h^1(\mathbb P^1,\mathcal O(1))=0$）。故 **(P1) 是这条技术路线的硬门槛，不是本文的疏忽**。

### §5.3 为什么 $a\ge2$ 的尾巴不给出更多

$a\ge2$ 时 (P2) 恒真，但 $g=h+a\ge2+a\ge4$，门槛比 $a\in\{0,1\}$ 更差；宇称也不会新增
（$a\ge1$ 时两种宇称已由 $a=1$ 覆盖）。故只需考虑 $a\in\{0,1\}$。

### §5.4 与种子界的对照

见 `claim.md` §4 的两张表。一句话总结：

> **DW 的 $n\le g-1$ 限制被完全去掉**（推论 A 对一切 $n\ge0$ 成立）；
> **Donagi–Ott 的 $g\ge5r+1$ 与 Wang 的 $g\ge n+5r+3$ 被替换为 $g\ge2$**（推论 B），
> 且**不依赖 Wang，故不继承 `physical-argument` 天花板**。

概念上的一句话解释：**穿孔替尾巴付了稳定性的钱，于是省下一个亏格**（$a$ 从 $1$ 降到 $0$），
而**穿孔本身完全不进入上同调计算**（它们全在常值因子里）。

---

## §6 自洽性检验（用来找自己的错）

### §6.1 退化到 CN：$n=r=0$

$n=r=0$ 时 (P2) 强制 $a\ge1$；取 $a=1$，尾巴是带一个 NS 点的椭圆自旋曲线 $(E,M,q)$，
$\mathcal B=\mathfrak S^+_{h;1,0}\times\mathfrak S_{1;1,0}$——**这正是 CN 的 $\mathcal B^{\varepsilon}$**，
定理 M 逐字退化为 CN Theorem 1.1(3)（$g\ge3$，两种宇称）。✓ **本文的构造在 CN 的范围内重现 CN。**

### §6.2 ⭐ 关键反向检验：本方法**永远碰不到** $\overline{\mathfrak M}{}^{-}_2$

CN Theorem 1.1(1) 证明了 $\overline{\mathfrak M}{}^{-}_2=\overline{\mathfrak S}{}^-_{2;0,0}$
是**分裂的**（特别地 $\omega_2=0$）。若本文的构造能触及这个对象，就会与 CN 直接矛盾，说明本文有错。
检验：$(g,n,r)=(2,0,0)$ 要求
- $a=1\Rightarrow h=1$，违反 (P1)；
- $a=0\Rightarrow n+2r=0<2$，违反 (P2)。

**两条路都被堵死 ✓。** 更进一步，即使允许穿孔（$g=2$，$n\ge2$），$a$ 必须为 $0$，尾巴的自旋结构
只能是 $\mathcal O_{\mathbb P^1}(-1)$（**偶**），于是 $\varepsilon=\mathrm{par}(L)+\mathrm{par}(N)=+$：
**本方法在 $g=2$ 只能到达偶分量，结构上不可能到达奇分量。** 这与 CN 的分裂性定理完全相容，
是一条强的"没有隐藏错误"的证据。

### §6.3 与 Donagi–Ott / Wang 不矛盾

推论 B 给出 $g\ge2$ 而 Donagi–Ott 要 $g\ge5r+1$——差距巨大，必须解释清楚：
**两者断言的对象不同。** Donagi–Ott/Wang 断言的是**未紧化**的 $\mathfrak S_{g;n,2r}$ 非投影；
本文断言的是**紧化**的 $\overline{\mathfrak S}_{g;n,2r}$ 非投影，且非零障碍是在**边界测试曲线**
$i(C)\subset\Delta_{\rm NS}$ 上检测到的。**紧化空间非投影不蕴含光滑轨迹非投影**（反之亦不然，
除非走上一轮的提升引理方向）。CN 与 DW 之间是完全相同的关系：CN 的 $g\ge3$ 远好于 DW 的 $g\ge5$，
正因为 CN 用的是边界，而 DW 说的是未紧化空间。✓ **无矛盾。**

### §6.4 ⭐ 一个必须正面回答的质疑：能不能用"忘掉穿孔"的态射平凡地得到推论 A？

⟦本节是本文作者对自身结果价值的诚实评估，不粉饰。⟧

**质疑**：既然 CN 已证 $\overline{\mathfrak S}{}^\varepsilon_{g;0,0}$（$g\ge3$）非投影，
取忘却态射 $\pi\colon\overline{\mathfrak S}_{g;n,0}\to\overline{\mathfrak S}_{g;0,0}$，
由 CN Lemma 2.6 得 $j_\pi(\omega_2(\overline{\mathfrak S}_{g;n,0}))=
\iota_\pi(\omega_2(\overline{\mathfrak S}_{g;0,0}))$；若右边非零，立刻得推论 A。
**推论 A 是不是就这么"免费"？**

**回答：不是，而且这条路有两个本文无法闭合的缺口。**

1. **忘却态射在紧化超模叠上的存在性没有文献支持。** 本轮逐字搜索 FKP-A 与 CN 全文的
   `forget`：FKP-A 的两处命中都是行文里的"forget about the punctures"（指局部计算时忽略穿孔），
   **不是构造态射**；CN 的三处命中指的是**忘掉自旋结构**的态射（$\overline S_g\to\overline M_g$），
   不是忘掉穿孔。**紧化情形尤其非平凡**：标记点撞上节点时需要稳定化（插入有理桥），而有理桥上的
   广义自旋结构如何指定，在超几何设定下本文未见任何文献处理。
2. **即使态射存在，$\iota_\pi$ 的非零性正是问题本身。** $\iota_\pi$ 是"拉回 $\pi_0^*$"再"沿
   $\Lambda^2 d\pi_-$ 前合成"。$\pi_0^*$ 那一半确实单（$\pi_0$ 固有、纤维连通、
   $\pi_{0*}\mathcal O=\mathcal O$，Leray 边缘映射单）；但第二半是由层的**单射**
   $\mathrm{Hom}(\pi^*\Lambda^2\mathcal T_-,\pi^*\mathcal T_+)\hookrightarrow
   \mathrm{Hom}(\Lambda^2\mathcal T_-,\pi^*\mathcal T_+)$ 诱导的，**层的单射不蕴含 $H^1$ 上的单射**
   （需要余核的 $H^0$ 被满射掉，这是关于整个模叠的整体陈述，本文既不能证也不能否证）。

**结论**：这条"平凡化"路线**不成立**（至少目前不成立），本文的构造是**无条件的**，且额外给出
障碍类的**定位信息**（它在 NS 边界上就已经非零，且由显式的 $\eta$ 见证）。
**但必须诚实指出**：如果将来有人补齐上述两点，推论 A（纯 NS 部分）就会变成 CN 的一个推论，
其独创性会下降。**推论 B（含 Ramond）不受影响**——忘却 Ramond 穿孔**根本不是态射**
（Ramond 穿孔是超共形结构的分歧轨迹，不是标记点；Donagi–Ott 逐字强调 "Ramond punctures are not
marked points!"），故该路线对推论 B 完全不适用。⭐ **推论 B 是本轮最稳固、最不可替代的产出。**

---

## §7 完整 `[GAP]` 清单

按风险从高到低：

1. **`[GAP-LIT]`（程序性，毕业前阻塞，**2026-09-18 部分关闭**）**：FKP-A（arXiv:2006.13271 =
   Amer. J. Math. **145** (2023) 1777–1886）**现已登记** `literature/sources.bib`，且
   `literature/extractions/felder-kazhdan-polishchuk-2020.md` 已存在（由另一条并行任务补上）。
   ⚠ **但该抽取记录覆盖的是 Theorem A、Def 2.1/2.4、§2.6、§5.4——恰好一条本证明的承重依赖都不覆盖**，
   且其条目 E6 自陈「**不建议 curator 直接引用本条目的 Theorem B 公式作为图节点来源**」。
   **剩余阻塞（已派 researcher）**：把该抽取记录**追加**扩展到 §7.5 的 (7.8)/(7.9)、Lemma 7.9、
   Lemma 7.10、§8.4 Example 8.9、§9.1 / Lemma 9.1 / (9.6)。本文 §4.3、§4.4、§4.5 的逐字引用
   已由 2026-09-18 的对抗审查用**页图**独立核实（pp. 2, 48, 49, 57, 58, 59, 60, 61），
   可直接交给 researcher 作为 append 的底稿。
2. **`[GAP-FKP-RAMOND]`（低）**：FKP-A Lemma 7.9 的**证明正文**把广义自旋结构写成
   $L\cong\mathrm{Hom}(L,\omega_C)$，漏掉了 Ramond 扭转 $\omega_C(R)$，尽管其陈述 (7.8) 允许
   $n_1,n_2>0$。本文判断这是无害省略（粘接是 NS 节点处的局部操作，可在与 Ramond 除子不交的邻域内
   进行），但**未独立重写该证明**。影响范围：推论 B（$r\ge1$）。
   **闭合方式**：重做 FKP Lemma 7.9 在 $\omega_C(R)$ 下的局部计算；预期是纯粹的记号替换。
   ✅ 2026-09-18 对抗审查逐字复核了 FKP-A p.48 该句（"Note that $L$ and $L'$ are generalized
   spin-structures, i.e., we have an isomorphism $L\longrightarrow^{\!\!\sim}\mathrm{Hom}(L,\omega_C)$
   …"，确无 $\omega_C(R)$），并同意"无害"这一判断，同时同意**不应**声称已重写该证明。
   **保留本 GAP，保留诚实措辞。**
3. **`[GAP-COMP]`（低，仅影响加细）**：$r>0$ 时 $\overline S_{g;n,2r}$ 的连通分量分类未知，
   故只断言整个叠非投影，不指认分量。见 §4.7。
4. ✅ **`[GAP-IMM]`：已关闭（2026-09-18 对抗审查）。** 该切列**不需要**闭浸入假设——
   $d\Gamma$ 常余秩 $1|0$（FKP-A Lemma 7.10, p.48）⟹ $\operatorname{coker}(d\Gamma)$ 局部自由，
   而局部自由层短正合列的拉回是正合的；且 $\mathcal T$ 是**定义**为 $i^*\mathcal T_+\overline{\mathfrak S}$
   的拉回，不是任何像的内蕴对象。完整论证见 §4.4 命题 4.5 证明末的关闭记录。
5. **`[GAP-STD]`（低，标准事实）**：$\mathcal T_+\mathfrak X|_X\cong\mathcal T_X$ 与
   $\mathcal T\mathfrak X/\mathcal J\mathcal T\mathfrak X=\mathcal T_+\oplus\mathcal T_-$ 是标准
   超几何事实（Manin；DW §2；CN §2），本文直接使用，未重证。
6. **`[GAP-DW]`（低）**：DW 一点障碍族的构造与 $\omega_2(X_\eta)=\eta$（[DW, Prop. 3.4]）本文
   **未独立复核**，按 CN §5 的逐字回顾使用。该结果所属图卡
   `math.supermoduli-space-not-projected` 状态为 **rigorous**。
7. **`[GAP-ALT]`（不是缺口，是价值风险）**：§6.4 的忘却态射路线若被他人补齐，推论 A 的独创性下降。
   推论 B 不受影响。
8. **未触及的方向（如实声明）**：
   - 本文**不断言**未紧化 $\mathfrak S_{g;n,2r}$ 的任何事；
   - 本文**不断言**任何"分裂/可投影"的正面结果（类比 CN Theorem 1.1(1)）；
   - $(g,n,r)=(2,1,0)$ 与 $g=2$ 的**奇**宇称带穿孔分量**完全开放**；
   - Ramond 节点处的粘接被**刻意避免**（FKP-A §9.3 的类比只是**猜想**），若将来该猜想被证明，
     可能打开新的、门槛更低的构造。

---

## §8 小结（诚实的一句话）

**本文把 Corrêa–Noja 的椭圆尾粘接技术重新装配在 Felder–Kazhdan–Polishchuk 的带穿孔粘接态射 (7.8)
上，做法是把旁观穿孔全部装到那条被固定的尾巴上；由此证明紧化带穿孔超模叠
$\overline{\mathfrak S}_{g;n,2r}$ 在 $g\ge3$（任意 $n,r$）以及 $g=2$（只要 $n+2r\ge2$）时非投影，
从而完全去掉了 Donagi–Witten 的 $n\le g-1$ 限制，并把 Donagi–Ott 的 $g\ge5r+1$ 与 Wang 的
$g\ge n+5r+3$ 替换成 $g\ge2$，且不依赖 Wang 那张 `physical-argument` 的卡。
同时本文给出一条同等重要的**负面结论**（命题 N）：旁观穿孔若装在运动分量上，测试基变成仿射曲线，
$H^1$ 消没，整条路线恒等于零——这解释了为什么"装到尾巴上"不是一个技巧而是唯一的选择，也解释了
CN 为什么必须用分离粘接加常值尾。全部结论依赖的外部输入均为 rigorous（无 conjecture、无
physical-argument），唯一的阻塞是程序性的 `[GAP-LIT]`（FKP-A 尚未登记）。**

