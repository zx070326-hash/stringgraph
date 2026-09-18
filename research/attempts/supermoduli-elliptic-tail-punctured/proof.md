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
> 特别地 $H^1(C^\circ,L^{-1})=0$，可取的障碍参数只有 $\eta=0$，于是 $\omega_2(X^\circ_\eta)=0$ 且
> §1.5 的比较映射 $j_F$ 的源空间为零：**该测试族恒定地检测不到任何障碍。**

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
$i\ge1$。取 $\mathcal F=L^{-1}|_{C^\circ}$ 得 $H^1(C^\circ,L^{-1})=0$。

由 §1.2，DW 障碍族的参数恰是 $\eta\in H^1(Y,L^{-1})$（$Y$ = 约化空间），且 $\omega_2(X_\eta)=\eta$。
源空间为零蕴含 $\omega_2=0$，从而 $j_F(\omega_2)=0$，由 Lemma 2.6 只得到平凡等式
$\iota_F(\omega_2(\text{目标}))=0$，给不出任何非消没信息。$\blacksquare$

> **推论 N′（非分离粘接同样被杀死）。** FKP 的非分离 NS 粘接态射
> $(7.9)\colon\overline{\mathfrak S}_{g;m+2,n}\to\overline{\mathfrak S}_{g+1;m,n}$
> 要求被粘的两个 NS 穿孔在**同一条**曲线上。若用它承载本方法，两个被粘点中必须有一个是运动点 $p$、
> 另一个是 $C$ 上的固定点 $q$，于是测试基是 $C\smallsetminus\{q\}$，仍是仿射曲线，命题 N 的第二、
> 三步逐字适用。**故本方法无法使用非分离粘接。**

> **推论 N″（"把 Ramond 穿孔放在运动分量上"同样被杀死）。** 同上，且额外地：亏格 $h$ 侧若带
> Ramond 除子 $R\neq0$，则 $L^{\otimes2}\cong\omega_C(R)$，§1.2 的识别
> $\Lambda^2\mathcal T_-X_\eta\cong L^{-1}$ 与 $\mathcal T_+X_\eta\cong L^{-2}$ 同时失效，
> Lemma 7.1 的"$\mathrm{Hom}(L^{-1},\mathcal T_C)\cong L^{-1}$"这一步也失效。

**⟦重要的诚实声明⟧ 命题 N 不是"$\overline{\mathfrak S}_{g;n,2r}$ 是投影的"**，甚至不是"这条路一定
不行"的元定理——它只断言**这一族具体的测试曲线恒等于零**。但它足以说明：**穿孔不能放在运动分量上**，
从而**唯一**剩下的装法是放在固定尾上。下一节说明这样装恰好可行。

**⟦副产品⟧** 命题 N 也给出 CN 的构造为何"必须是分离粘接 + 常值尾"的结构性解释——在 CN 的论文里这是
一个未加解释的构造选择，本文指出它是被仿射性障碍**强制**的。
