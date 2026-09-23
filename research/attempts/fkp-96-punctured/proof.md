# proof.md — The normal-line formula on a punctured target

**Attempt**: `fkp-96-punctured`. **Claim under proof**: Claim P of `claim.md`.
**Author**: `theorem-prover`, 2026-09-23. **State**: see `status.yaml`.

---

## 0. Verdict (stated up front, so that the rest can be read against it)

Claim P is **true**, and a direct derivation is given below. The outcome is therefore
outcome (a) of `claim.md` §4 — but *not* for the reason the flagged inference `[INF-NORMAL]`
proposes, and not without cost. Precisely:

1. **NS punctures are free.** Every sheaf and every lemma in the chain that produces [FKP]'s
   (9.6) is *literally independent of the NS punctures*: the punctures $P_i$ enter the data of
   a supercurve (Def. 2.4) only as sections $P_i\subset U\subset X$, and none of
   $\Omega_{X/S}$, $j_*\Omega_{U/S}$, $\omega_{X/S}$, $\omega^{2k}_{X/S}$, $\mathcal B$,
   the canonical section $c$, or $\Delta$ refers to them. This is much stronger than the
   locality argument that `[INF-NORMAL]` rests on, and is proved in §3 below.
2. **Ramond punctures are *not* free, but they are harmless, and the repair is explicit.**
   Two statements of [FKP] that the chain uses are *written for $R=\varnothing$* and are, as
   printed, false or unproved when Ramond punctures are present:
   - **[E1]** the fundamental sequence (7.1),
     $0\to\omega^2_{X/S}\to j_*\Omega_{U/S}\to\omega_{X/S}\to0$, must be replaced by
     $0\to\omega^2_{X/S}(R)\to j_*\Omega_{U/S}\to\omega_{X/S}(R)\to0$ (§5);
   - **[E2]** the proof of Lemma 7.9 — the statement that gluing two stable supercurves along
     an NS puncture produces a stable supercurve, i.e. the statement that makes the gluing map
     (7.8) *exist at all* — writes the generalized spin structure as
     $L\cong\mathcal Hom(L,\omega_C)$, which is [FKP]'s own (2.5) only in the case $r=0$ (§4).

   Both are repaired here. Neither repair changes the conclusion, because the Ramond divisor
   $R$ is disjoint from the node $Q$ and from the glued divisors $D_1,D_2$, so the twist by
   $\mathcal O(R)$ is canonically trivial exactly where the computation happens.
3. **The one place `[INF-NORMAL]` was right to be nervous** is (7.6) itself: §7.1–§7.3 of
   [FKP] are written with an unsubscripted $\overline{\mathcal S}$ and with the $R=\varnothing$
   form of $\delta$. §3 below shows this is not a gap but a triviality: (7.6) is a *definition*
   plus Prop. 7.4, and Prop. 7.4 is stated and proved for an arbitrary family of stable
   supercurves with no puncture hypothesis whatsoever.

So `[INF-NORMAL]` is retractable, at the price of carrying [E1] and [E2] as explicit repairs.

---

## 1. Evidence discipline

Every displayed [FKP] formula used below carries a tag:

- **L1** = this agent read it on a rendered page image of `arXiv:2006.13271v3` at 170 dpi
  (`pdftoppm -png -r 170`), and transcribed it from the image. Page numbers are the printed
  page numbers of that PDF.
- **L3** = transcribed from `literature/extractions/felder-kazhdan-polishchuk-2020.md`.

`pdftotext` output was used **only** to locate page numbers; no formula below rests on it.

Everything used below is **L1**. Pages read as images: 1, 2, 5, 6, 7, 41, 42, 44, 45, 46, 47,
48, 56, 57, 58, 59, 60, 61.

---

## 2. Notation and the [FKP] inputs, with page verification

### 2.1 Notation

$\overline{\mathcal S}_{g;m,n}$ denotes the moduli superstack of stable supercurves of genus
$g$ with $m$ NS punctures and $n$ Ramond punctures; $\mathcal S_{g;m,n}$ its open substack of
smooth supercurves. $\pi\colon X\to S$ is a family, $j\colon U\hookrightarrow X$ the open
complement of the nodes in the fibres, $R=\sum_j R_j$ the (relative Cartier) Ramond divisor,
$D_i\subset X$ the divisor attached to the NS puncture $P_i$, $\Psi_i:=P_i^*\omega_{X/S}$.
Throughout, $k$ (never $m$) denotes the exponent in $\omega^{2k}$.

> **Remark 2.1 (the semicolon/comma notation trap, resolved at L1).** The project record notes
> that [FKP] never writes down that $\overline{\mathcal S}_{g;m,n}$ (§7.5 onward) and
> $\overline{\mathcal S}_{g,n_{\rm NS},n_{\rm R}}$ (§1, §8) denote the same object. They do not
> assert it, but they *define* both by the same words, verbatim:
> - **L1, p. 1, Theorem A**: "There exists a smooth and proper DM-stack
>   $\overline{\mathcal S}_{g,n_{NS},n_R}$ over $\mathbb C$ representing the functor of
>   families of stable supercurves of genus $g$ with $n_{NS}$ NS punctures and $n_R$ Ramond
>   punctures."
> - **L1, p. 48**: "Let $\overline{\mathcal S}_{g;m,n}$ denote the moduli superspace of stable
>   supercurves of genus $g$ with $m$ NS marked points and $n$ Ramond marked points."
>
> Since Theorem A says the first *represents* that functor, and the second is defined as the
> moduli space of the same functor, they are canonically isomorphic. Below I write
> $\overline{\mathcal S}_{g;m,n}$ for both and use only the defining property
> ("represents the functor"), never a numerical coincidence.

> **Remark 2.2 (the $m$ trap, resolved at L1).** In Lemma 9.1 the letter $m$ is the exponent of
> $\omega$, not a puncture count: **L1, p. 60**, proof of 9.1(ii): "To derive the case of
> arbitrary $m$ from that of $m=0$, we tensor the sequence (9.5) with the line bundle
> $\omega^{2m}_{X_B/B}$." In (8.11) the letter $m$ *is* the number of NS punctures: **L1,
> p. 58**, proof of Theorem B begins "Let $\overline{\mathcal S}=\overline{\mathcal
> S}_{g,n_{NS},n_R}$" and concludes with (8.11) $K_{\overline{\mathcal S}}\simeq
> \operatorname{Ber}_1^5\otimes\bigotimes_{i=1}^m\Psi_i(-2\Delta_{NS}-\Delta_R)$, while
> **L1, p. 2**, Theorem B states the identical formula with upper limit $n_{NS}$. Hence
> $m=n_{\rm NS}$ in (8.11); the project's recorded ambiguity is resolved.

### 2.2 The inputs

All of the following are **L1**.

**(I1) Definition 2.4 (p. 6).** A supercurve with punctures over $S$ is a superscheme $X$ of
finite type over $S$, flat and relatively Cohen–Macaulay, together with
- disjoint closed subschemes $P_i\subset X$ ($i=1,\dots,n_{NS}$), $R_i\subset X$
  ($i=1,\dots,n_R$), such that $P_i\to S$ is an isomorphism and each $R_i$ is a Cartier divisor
  flat over $S$;
- a derivation $\delta\colon\mathcal O_X\to\omega_{X/S}(R)$, trivial on pull-backs of functions
  on $S$, where $R=\sum R_i$;

subject to: there is an open fibrewise dense $U\subset X$ with $U/S$ smooth of dimension $1|1$
and $P_i\subset U$, $R_i\subset U$; $\delta$ restricts to a smooth-supercurve-with-Ramond-
punctures structure on $(U,(R_i))$; and on each geometric fibre $\delta^-$ induces
$\mathcal O^-_{X_s}\xrightarrow{\ \sim\ }\omega_{X_s}(\sum R_{is})^-$ (2.4).

**(I2) (2.2)–(2.3) (p. 5).** For a smooth supercurve with Ramond punctures, with
superconformal distribution $\mathcal D\subset\mathcal T_{X/S}$ of rank $0|1$:
$$\mathcal D^{\otimes2}\xrightarrow{\ \sim\ }\mathcal T_{X/S}/\mathcal D(-R),\tag{2.2}$$
$$0\to\mathcal D\to\mathcal T_{X/S}\to\mathcal D^{\otimes2}(R)\to0,\qquad
0\to\mathcal D^{-2}(-R)\to\Omega_{X/S}\to\mathcal D^{-1}\to0,$$
$$\omega_{X/S}:=\operatorname{Ber}(\Omega_{X/S})\simeq\mathcal D^{-1}(-R),\qquad
\mathcal D\simeq\omega^{-1}_{X/S}(-R),\tag{2.3}$$
$$\delta\colon\Omega_{X/S}\longrightarrow\mathcal D^{-1}\simeq\omega_{X/S}(R)\quad\text{surjective.}$$

**(I3) Lemma 2.6 (p. 7).** For $S$ even, the data of a supercurve $(X,P_\bullet,R_\bullet)$
over $S$ is equivalent to: a flat family of pointed curves $(C,p_\bullet,r_\bullet)$, a
coherent sheaf $L$ on $C$ (flat, relatively CM, generically line bundle), and an isomorphism
$$L\xrightarrow{\ \sim\ }\mathcal Hom\big(L,\omega_C(\textstyle\sum r_i)\big).\tag{2.5}$$
Under this correspondence $\mathcal O^+_X=\mathcal O_C$, $\mathcal O^-_X=L$,
$\omega^+_X=\omega_C$, $\omega^-_X=\mathcal Hom(L,\omega_C)\simeq L(-\sum r_i)$; (2.5)
corresponds to $\delta^-$. Such an $L$ is called a **generalized spin structure**.

**(I4) Theorem A (p. 1).** $\overline{\mathcal S}_{g,n_{NS},n_R}$ is a smooth and proper
DM-stack over $\mathbb C$ **representing** the functor of families of stable supercurves of
genus $g$ with $n_{NS}$ NS and $n_R$ Ramond punctures.

**(I5) Theorem 4.1** (used through [FKP] as: $\omega^{2k}_{X/S}:=j_*\omega^{2k}_{U/S}$ is a
line bundle on $X$). Quoted at **L1, p. 41**: "where $\omega^2_{X/S}=j_*\omega_{U/S}$ is a line
bundle on $X$ (see Theorem 4.1)", and **L1, p. 59**: "recall that we have a line bundle
$\omega^2_{X/S}$ defined on the universal curve of $\overline{\mathcal S}$ by extending from
the smooth locus (see Theorem 4.1)."

**(I6) §7.1 setup and Lemma 7.1 (p. 41).** Verbatim: "Let $\pi\colon X\to S$ be a family of
stable supercurves such that the map from $S$ to the deformation space of each node is smooth.
Let $j\colon U\to X$ be the embedding of the smooth locus. […] Since $U/S$ is a smooth
supercurve, we have an exact sequence
$0\to\omega^2_{U/S}\xrightarrow{\kappa}\Omega_{U/S}\xrightarrow{\delta}\omega_{U/S}\to0$
where in standard coordinates $\delta(dz)=\theta[dz|d\theta]$, $\delta(d\theta)=[dz|d\theta]$,
$\kappa([dz|d\theta]^{\otimes2})=dz-\theta d\theta$." Lemma 7.1: "The map $j_*\delta$ is
surjective, so we have an exact sequence
$$0\to\omega^2_{X/S}\xrightarrow{\ \kappa\ }j_*\Omega_{U/S}\xrightarrow{\ j_*\delta\ }
\omega_{X/S}\to0.\tag{7.1}$$"
**Note the absence of the twist $(R)$** — this is [E1]; see §5.

**(I7) §7.2 and Proposition 7.4 (p. 44).** Verbatim: "Let $\pi\colon X\to S$ be a family of
stable supercurves, inducing a surjection to the miniversal space of deformations of each node.
We are going to study the natural 2-term complex $[\Omega_{X/S}\to j_*\Omega_{U/S}]$ placed in
degrees $-1$ and $0$, where $j\colon U\to X$ is the open embedding of the complement to the
nodes. Note that this complex is acyclic over $U$. Furthermore, both terms are flat over $S$,
so the line bundle $\operatorname{Ber}\pi_*[\Omega_{X/S}\to j_*\Omega_{U/S}]$ is well defined.
Similarly to the theory in the even case (see [24]), we can define a canonical trivialization
of this line bundle away from the locus of nodal supercurves."

> **Proposition 7.4.** *The canonical trivialization $c$ of
> $\mathcal B:=\operatorname{Ber}\pi_*[\Omega_{X/S}\to j_*\Omega_{U/S}]$ away from the nodal
> locus extends to a regular section of $\mathcal B$ on $S$ that has form $t\cdot b$ near a
> point corresponding to a stable supercurve with one NS or Ramond node, for some trivializing
> local section $b$ of $\mathcal B$ and some local function $t$ whose reduction modulo
> nilpotents gives an equation of the corresponding reduced divisor.*

**There is no puncture hypothesis in (I7)**, and the proof (pp. 44–45) works "in an étale
neighborhood of a point on $S$ corresponding to a stable supercurve with one node", choosing a
relative Cartier divisor $D$ *disjoint from the node*.

**(I8) Definition of $\Delta$ and (7.6) (p. 45).** Verbatim: "The above Proposition gives a
natural definition of the boundary divisor in the moduli space of stable supercurves
$\overline{\mathcal S}$ as an effective Cartier divisor. More precisely, let
$k\colon\mathcal S'\hookrightarrow\overline{\mathcal S}$ be the complement to the locus of
stable supercurves with more than 1 node. Since the even codimension of the latter locus is
$>1$ and $\overline{\mathcal S}$ is smooth, for any vector bundle $\mathcal V$ over
$\overline{\mathcal S}$, the natural map $\mathcal V\to k_*k^*\mathcal V$ is an isomorphism.
Let us consider the line bundle
$\mathcal L:=\operatorname{Ber}\pi_*[\Omega_{X/\overline{\mathcal S}}\to
j_*\Omega_{U/\overline{\mathcal S}}]$ over $\overline{\mathcal S}$. By Proposition 7.4, the
canonical trivialization $c$ of $\mathcal L$ over the smooth locus gives a regular global
section of $k^*\mathcal L$ and hence of $\mathcal L\simeq k_*k^*\mathcal L$. We define the
effective Cartier divisor $\Delta$ to be the vanishing divisor of this global section. Note
that by definition, we have an isomorphism
$$\mathcal O(\Delta)\simeq\mathcal L\simeq\operatorname{Ber}R\pi_*(j_*\Omega_{U/S})\otimes
\operatorname{Ber}^{-1}R\pi_*(\Omega_{X/S}).\tag{7.6}$$"
(The base is printed as $S$ in (7.6) and as $\overline{\mathcal S}$ two lines above; this is a
missing overline, not a different object.)

**(I9) Lemma 7.5 (p. 45).** $\Delta$ is the *unique* Cartier divisor supported on the nodal
locus such that, étale-locally at a single NS node, $\mathcal O_{X_S}$ is generated over
$\mathcal O_S$ by $z_1,z_2,\theta_1,\theta_2$ subject to (6.11) with $t$ a local equation of
$\Delta$; and, at a single Ramond node, by $z_1,z_2,\theta$ subject to $z_1z_2=t$ with $t$ a
local equation of $\Delta$. **Punctures do not appear in this characterisation.**

**(I10) §7.4 and Proposition 7.8 (p. 47).** $\Delta_{NS}$ is defined as the effective Cartier
divisor cut out by $\mathcal I_\delta:=\operatorname{Ann}\pi_*\operatorname{coker}(\delta)$,
where $\delta\colon\Omega_{X/\overline{\mathcal S}}\to\omega_{X/\overline{\mathcal S}}(R)$
**(note: here the $(R)$ twist is present)**. Prop. 7.8(i): $\mathcal I_\delta$ defines an
effective Cartier divisor $\Delta_{NS}$ on $\overline{\mathcal S}$, "which coincides with
$\Delta$ in a neighborhood of any point $[X_0]$ corresponding to a stable supercurve $X_0$ with
only NS nodes." (ii): there is a unique effective Cartier $\Delta_R$ supported on the locus of
supercurves with at least one Ramond node such that $\Delta=\Delta_{NS}+\Delta_R$; and for
$X_0$ with NS nodes $q_1,\dots,q_r$ and Ramond nodes $q_{r+1},\dots,q_k$ there is an étale
neighborhood $B$ of $[X_0]$ with a **smooth** morphism $(t_1,\dots,t_k)\colon B\to\mathbb A^k$
such that $t_1\cdots t_r$ is an equation of $\Delta_{NS}$ and $t_{r+1}\cdots t_k$ of
$\Delta_R$.

**(I11) Lemma 7.9 (p. 47) and its proof (p. 48).** Gluing $X/S$ and $X'/S$ along NS punctures
$P\simeq S\simeq P'$ gives $Z/S$ with a natural stable supercurve structure, $\delta_Z$ being
the composition $\mathcal O_Z\to j_*\mathcal O_X\oplus j'_*\mathcal O_{X'}\to
j_*\omega_{X/S}\oplus j'_*\omega_{X'/S}\to\omega_{Z/S}$. The proof reduces to $S=\mathrm{pt}$,
sets $\mathcal O_X=\mathcal O_C\oplus L$, and states "Note that $L$ and $L'$ are generalized
spin-structures, i.e., we have an isomorphism $L\xrightarrow{\sim}\mathcal Hom(L,\omega_C)$" —
**the $r=0$ case of (2.5)**. This is [E2]; see §4.

**(I12) (7.8), (7.9), Lemma 7.10 (p. 48).**
$$\overline{\mathcal S}_{g_1;m_1+1,n_1}\times\overline{\mathcal S}_{g_2;m_2+1,n_2}\to
\overline{\mathcal S}_{g_1+g_2;m_1+m_2,n_1+n_2},\tag{7.8}$$
$$\overline{\mathcal S}_{g;m+2,n}\to\overline{\mathcal S}_{g+1;m,n}.\tag{7.9}$$
Lemma 7.10: "Both morphisms (7.8) and (7.9) induce embeddings of codimension $1|0$ on tangent
spaces and factor through the divisor $\Delta_{NS}$. Furthermore, near a stable supercurve with
a single separating (resp., non-separating) NS node, the divisor $\Delta_{NS}$ coincides with
the schematic image of (7.8) (resp., (7.9))." Its proof begins "Let $X$ be a stable supercurve
**with punctures** and a fixed NS-node $q$ […] (where we take into account **all the punctures
on both sides**)", and contains the exact sequence, for $X$ with punctures and nodes
$q,q_1,\dots,q_m$,
$$0\to H^1(X,\mathcal A_X)\to T_{\mathrm{Def}(X)}\to T_{\mathrm{Def}(\mathcal O_{X,q})}\oplus
\bigoplus_{i=1}^mT_{\mathrm{Def}(\mathcal O_{X,q_i})}\to0.\tag{$\dagger$}$$

**(I13) §6.4 (p. 41).** Verbatim: "Everything in Sec. 6.2 and 6.3 has an analog in the case of
families of stable supercurves with punctures. Namely, for such a family
$(X,P_\bullet,R_\bullet)/S$, we should replace the sheaves $\mathcal A_X$ and $\mathcal A_{X/S}$
with their intersections $\mathcal A_{X,P,R}$ and $\mathcal A_{(X,P,R)/S}$ with the subsheaf
$\mathcal T_{X,P,R}\subset\mathcal T_X$ of derivations preserving all the punctures […].
**This will not change the local picture near the nodes**, however, we need to make some
changes in the global statements."

**(I14) §8.4 and Lemma 8.7 (p. 56).** Verbatim: "Let $\pi\colon X\to S$ be a stable supercurve
with NS punctures $P_1,\dots,P_m$ **and Ramond divisors $R_1,\dots,R_n$**. […] For every
$i=1,\dots,m$, let us define a line bundle of rank $0|1$ on $S$, $\Psi_i:=P_i^*\omega_{X/S}$."
Lemma 8.7: $\Psi_i\simeq\pi_*\mathcal O_{D_i}/\mathcal O_S$,
$\Psi_i^{-1}\simeq P_i^*\omega_{X/S}(D_i)\simeq P_i^*\omega_{D_i/S}\simeq
\operatorname{Ber}(\pi_*\mathcal O_{D_i})$; hence for $L$ of rank $1|0$ on $X$,
$\operatorname{Ber}(\pi_*L|_{D_i})\simeq\Psi_i^{-1}$, and for $M$ of rank $0|1$,
$\operatorname{Ber}(\pi_*M|_{D_i})\simeq\Psi_i$.
**The setup of §8.4 explicitly contains Ramond divisors.**

**(I15) Cor. 8.8 and Remark 8.10 (p. 57).** $P_i^*\omega^2_{X/S}(D_i)$ is canonically
trivialized. $\pi_*\mathcal O_{D_i}=\mathcal O_S\oplus\Psi_i$ with $\Psi_i$ a square-zero
ideal; $\Psi_i^{-1}\simeq P_i^*\omega_{X/S}(D_i)$; $\pi_*(\omega_{D_i/S})=\Psi_i^{-1}\oplus
\mathcal O_S$.

**(I16) §9.1 setup (p. 58).** Verbatim: "Let $\iota\colon B\to\overline{\mathcal S}$ be the
standard gluing map covering an NS type boundary component, i.e., **one of the maps (7.8) or
(7.9)**, restricted to the locus of smooth supercurves. Let $X_B\to B$ denote the universal
stable supercurve, which is obtained by identifying two NS punctures $P_1,P_2$ on a smooth
supercurve $\widetilde X\to B$ into a node $Q\subset X_B$. Let $D_1,D_2\subset\widetilde X$ be
the corresponding divisors. Note that we have a finite morphism
$\rho\colon\widetilde X\to X_B$, and an exact sequence on $X_B$,
$0\to\mathcal O_{X_B}\to\rho_*\mathcal O_{\widetilde X}\to\mathcal O_Q\to0$."

**(I17) Lemma 9.1 (p. 59) and its proof (p. 60).** Statement as transcribed in §6 below.
Nothing in the statement or the proof refers to any puncture other than $P_1,P_2$.

**(I18) The derivation of (9.6) (pp. 60–61).** Verbatim (p. 60): "We can use the definition of
the NS boundary line bundle (7.6) to compute the normal bundle over the smooth part of $B$.
From the above Lemma we get
$$\operatorname{Ber}R\pi_*(j_*\Omega_{U/S})|_B\simeq\operatorname{Ber}R\pi_*
(\Omega_{\widetilde X/B}(D_1+D_2))\otimes\Psi_1^{-1}\Psi_2^{-1},$$
$$\operatorname{Ber}R\pi_*(\Omega_{X/S}|_B)\simeq\operatorname{Ber}R\pi_*\Omega_{\widetilde X/B}.$$
Finally the exact sequence $0\to\omega^2_{\widetilde X/B}\to\Omega_{\widetilde X/B}\to
\omega_{\widetilde X/B}\to0$ near $D_1,D_2$, together with Lemma 8.7, show that
$\operatorname{Ber}R\pi_*\Omega_{\widetilde X/B}(D_1+D_2)\simeq\operatorname{Ber}R\pi_*
\Omega_{\widetilde X/B}$." And (p. 61): "Hence, we deduce an isomorphism
$$\mathcal O(\Delta)|_B\simeq\operatorname{Ber}R\pi_*(j_*\Omega_{U/S})|_B\otimes
\operatorname{Ber}^{-1}R\pi_*(\Omega_{X/S}|_B)\simeq\Psi_1^{-1}\Psi_2^{-1}.\tag{9.6}$$"

**(I19) Theorem C (p. 2).** Verbatim: "Let $B\to\overline{\mathcal S}_g$ be the gluing map to
one of the components of $\Delta_{NS}$ from a lower genus (uncompactified) moduli space $B$.
There exists a natural isomorphism (see below) of the normal bundle
$N_B:=\mathcal O(\Delta)|_B\simeq\Psi_1^{-1}\otimes\Psi_2^{-1}$." — target
$\overline{\mathcal S}_g$, **unpunctured**. Not used below (using it would beg the question);
recorded to fix what is and is not available.

**(I20) The $m=0$ usage in §9.1 (p. 58, L1).** The *heuristic* comparison that opens §9.1 —
"We can rewrite (8.11) near $B$ as an isomorphism $K_{\overline{\mathcal S}}(2\Delta_{NS})
\simeq\mathcal B(\mathcal O_X)^5$" — drops both $\bigotimes_{i=1}^m\Psi_i$ and $\Delta_R$ from
(8.11), i.e. it is written for $m=n_R=0$. **This is exactly the route that is not used below.**
[FKP] themselves say so, verbatim (p. 59, L1): "Below we will define such a canonical
isomorphism **independently** and then will check its compatibility with two above
isomorphisms." Lemma 9.1 and (9.6) are that independent construction.

### 2.3 Standard (non-[FKP]) inputs

**(S1)** $\operatorname{Ber}$ is multiplicative in short exact sequences of coherent sheaves
with perfect $R\pi_*$; for a 2-term complex $F^\bullet=[F^{-1}\to F^0]$ with $F^{\pm}$ flat
over $S$ and $\pi$ proper, $\operatorname{Ber}R\pi_*F^\bullet\cong
\operatorname{Ber}R\pi_*F^0\otimes\operatorname{Ber}^{-1}R\pi_*F^{-1}$.
**(S2)** $\operatorname{Ber}R\pi_*$ commutes with base change for perfect complexes.
**(S3)** $\operatorname{Ber}$ of a free module of rank $p|q$ has parity $q\bmod 2$; in
particular $\operatorname{Ber}(M)\cong M^{-1}$ for $M$ of rank $0|1$, and
$\operatorname{Ber}(\Omega)=\omega$ has rank $0|1$ since $\Omega$ has rank $1|1$.
**(S4)** Grothendieck duality for a finite morphism: $f_*\mathcal Hom_{\mathcal O_Y}(f_*F,G)
\cong f_*\mathcal Hom_{\mathcal O_X}(F,f^!G)$, and $f^!(G\otimes N)\cong f^!G\otimes f^*N$ for
$N$ a line bundle on $Y$ (projection formula for $f^!$).

(S1)–(S2) are used by [FKP] without comment; (S3) is the standard parity convention, forced by
[FKP]'s own "$\Psi_i:=P_i^*\omega_{X/S}$ is a line bundle of rank $0|1$" (I14); (S4) is
standard.

---

## 3. Step 1: the boundary divisor $\Delta$ is blind to the punctures

This is the step the flagged inference `[INF-NORMAL]` was replacing by an appeal to the
locality of the node singularity. Locality is *not* what makes it work — $\operatorname{Ber}
R\pi_*(-)$ is a global object on the fibre — and the real reason is stronger and simpler.

> **Lemma 3.1 (puncture-blindness).** Let $(X,P_\bullet,R_\bullet)/S$ be a family of stable
> supercurves with punctures in the sense of (I1). Let $U\subset X$ be the complement of the
> nodes of the fibres and $j\colon U\hookrightarrow X$. Then the two-term complex
> $[\Omega_{X/S}\to j_*\Omega_{U/S}]$, the line bundle
> $\mathcal B=\operatorname{Ber}\pi_*[\Omega_{X/S}\to j_*\Omega_{U/S}]$, and the canonical
> trivialization $c$ of $\mathcal B$ away from the nodal locus, all depend **only** on the
> morphism of superschemes $\pi\colon X\to S$. In particular they are unchanged if the
> punctures $(P_\bullet,R_\bullet)$ are altered or forgotten (as long as $\pi$ is not changed).

*Proof.* Four observations.

(a) *$U$ depends only on $\pi$.* By (I1), $U$ is required to be an open fibrewise dense subset
with $U/S$ smooth of dimension $1|1$, containing all $P_i$ and $R_i$. The maximal such open is
the smooth locus of $\pi$, and the locus where $\pi$ fails to be smooth is precisely the nodal
locus; this is a property of $\pi$ alone. (That the punctures are contained in it is a
*condition on the punctures*, not a modification of $U$.) Hence $j\colon U\to X$ is determined
by $\pi$.

(b) *$\Omega_{X/S}$ and $j_*\Omega_{U/S}$ depend only on $\pi$.* $\Omega_{X/S}$ is the sheaf of
relative Kähler differentials of $\pi$; $\Omega_{U/S}$ likewise for $\pi|_U$; $j_*$ is the
pushforward along the map produced in (a). None of the three constructions has $P_\bullet$ or
$R_\bullet$ as an input. In particular *the derivation $\delta$ of (I1) is not used*. This is
the crucial point: the Ramond punctures enter the data of a supercurve only through the
*target twist* of $\delta\colon\mathcal O_X\to\omega_{X/S}(R)$, and $\delta$ does not appear in
the complex.

(c) *$\mathcal B$ depends only on $\pi$.* By (I7) both terms of the complex are flat over $S$
and $\pi$ is proper, so $\mathcal B$ is a well-defined line bundle; it is built from (b) by
$\operatorname{Ber}\pi_*$, which uses only $\pi$.

(d) *$c$ depends only on $\pi$.* Over the open locus $S^{\rm sm}\subset S$ where the fibres
have no nodes we have $U=X$, hence the map $\Omega_{X/S}\to j_*\Omega_{U/S}$ is the identity,
hence the complex is $[\,\mathrm{id}\colon F\to F\,]$ in degrees $-1,0$, whose Berezinian
carries the canonical trivialization $\operatorname{Ber}(F)\otimes\operatorname{Ber}(F)^{-1}
\cong\mathcal O_{S^{\rm sm}}$. This is [FKP]'s $c$ ("Similarly to the theory in the even case
[…], we can define a canonical trivialization of this line bundle away from the locus of nodal
supercurves", I7), and it is manifestly independent of the punctures. $\square$

> **Remark 3.2.** Lemma 3.1 is not "the sheaves are supported near the node". They are not;
> $j_*\Omega_{U/S}$ has full support. The statement is that the *entire input data* of the
> construction — $\pi$ and $U$ — carries no puncture information, so no puncture-dependent
> correction term can arise, wherever it might be supported. Lemma 7.5 (I9) is an independent
> confirmation from [FKP]'s side: $\Delta$ is characterised by two purely local conditions in
> which punctures do not occur.

> **Lemma 3.3 (the hypotheses of Prop. 7.4 hold on $\overline{\mathcal S}_{g;m,n}$).** Let
> $m,n\ge0$ with $n$ even and $(g;m,n)$ in the stable range, and let
> $\pi\colon X\to\overline{\mathcal S}_{g;m,n}$ be the universal stable supercurve. Then
> $\pi$ induces a surjection to the miniversal deformation space of each node; equivalently,
> for each point $[X_0]$ with nodes $q_1,\dots,q_k$ there is an étale neighborhood $B$ of
> $[X_0]$ and a **smooth** morphism $(t_1,\dots,t_k)\colon B\to\mathbb A^k$ with $t_i$ the
> induced deformation of $q_i$.

*Proof.* By (I4), $\overline{\mathcal S}_{g;m,n}$ represents the functor of families of stable
supercurves with $m$ NS and $n$ Ramond punctures; hence its tangent space at $[X_0]$ is
$T_{\mathrm{Def}(X_0,P_\bullet,R_\bullet)}$ and the universal family is versal. By (I12), the
sequence $(\dagger)$ — which [FKP] state for a stable supercurve **with punctures**, with
$\mathcal A_X$ read as $\mathcal A_{X,P,R}$ per the convention of (I13) — is exact on the
right, i.e.
$$T_{\mathrm{Def}(X_0,P_\bullet,R_\bullet)}\longrightarrow
\bigoplus_{i=1}^kT_{\mathrm{Def}(\mathcal O_{X_0,q_i})}$$
is surjective. Each $\mathrm{Def}(\mathcal O_{X_0,q_i})$ is smooth of dimension $1|0$ (the
standard NS-node deformation with parameter $t$, or the Ramond-node deformation $z_1z_2=t$;
(I9) exhibits both, and by (I13) the local picture at the nodes is unchanged by punctures).
Since $\overline{\mathcal S}_{g;m,n}$ is smooth (I4) and the target $\prod_i
\mathrm{Def}(\mathcal O_{X_0,q_i})\cong\mathbb A^{k|0}$ is smooth, surjectivity on tangent
spaces at every point of an étale neighborhood gives smoothness of the morphism. $\square$

> **Corollary 3.4 (codimension).** The locus $Z_{\ge2}\subset\overline{\mathcal S}_{g;m,n}$ of
> stable supercurves with more than one node has even codimension $>1$.

*Proof.* Let $[X_0]\in Z_{\ge2}$ have $k\ge2$ nodes. By Lemma 3.3 there is an étale
neighborhood $B$ and a smooth $(t_1,\dots,t_k)\colon B\to\mathbb A^{k|0}$; in $B$, the locus of
supercurves with $\ge2$ nodes is contained in $\bigcup_{i\ne j}\{t_i=t_j=0\}$, which has even
codimension $2$ since the map is smooth. $\square$

> **Proposition 3.5 (the boundary divisor and (7.6) on a punctured target).** Let $m,n\ge0$
> with $n$ even, $(g;m,n)$ in the stable range, and
> $\pi\colon X\to\overline{\mathcal S}:=\overline{\mathcal S}_{g;m,n}$ the universal stable
> supercurve. Put
> $\mathcal L:=\operatorname{Ber}\pi_*[\Omega_{X/\overline{\mathcal S}}\to
> j_*\Omega_{U/\overline{\mathcal S}}]$. Then the canonical trivialization $c$ of $\mathcal L$
> over the smooth locus extends to a global section of $\mathcal L$, whose vanishing divisor
> $\Delta\subset\overline{\mathcal S}_{g;m,n}$ is an effective Cartier divisor, and
> $$\mathcal O(\Delta)\ \simeq\ \mathcal L\ \simeq\
> \operatorname{Ber}R\pi_*\big(j_*\Omega_{U/\overline{\mathcal S}}\big)\otimes
> \operatorname{Ber}^{-1}R\pi_*\big(\Omega_{X/\overline{\mathcal S}}\big).$$
> Moreover $\Delta$ is characterised by the two local conditions of Lemma 7.5 (I9).

*Proof.* The universal family satisfies the hypothesis of Prop. 7.4 (I7) by Lemma 3.3, and
Prop. 7.4 carries no puncture hypothesis; so $c$ extends to a regular section of $\mathcal L$
over $\mathcal S'$, the complement of $Z_{\ge2}$, vanishing to order one at each one-node
point. $\overline{\mathcal S}_{g;m,n}$ is smooth by (I4) and $Z_{\ge2}$ has even codimension
$>1$ by Cor. 3.4, so $\mathcal L\to k_*k^*\mathcal L$ is an isomorphism and the section extends
uniquely to $\overline{\mathcal S}$; $\Delta$ is its vanishing divisor. The displayed
isomorphism is then the definition of $\mathcal L$ together with (S1). The characterisation is
Lemma 7.5, whose proof (I9) uses only the local models and the same
$\mathcal I\cong k_*k^*\mathcal I$ extension argument. $\square$

> **Remark 3.6.** Proposition 3.5 settles the first half of `[INF-NORMAL]` outright, and it
> does so *without any Ramond subtlety*: the $(R)$-twist problem [E1] lives in §7.1, which
> (7.6) does not use. In particular the quantity $\mathcal O(\Delta)$ appearing on the left of
> (9.6) is unambiguously defined on $\overline{\mathcal S}_{g;m,n}$ for all $m,n$, and the
> first $\simeq$ of (9.6) holds there.

---

*(Parts §4–§11 follow.)*
