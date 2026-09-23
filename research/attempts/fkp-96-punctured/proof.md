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

So `[INF-NORMAL]` is retractable, at the price of carrying [E1] and [E2] as explicit repairs, and
at the price of correcting the paper's own justification: two of its sentences are wrong as
written — "no puncture enters this derivation" (three do, §10.3(A)) and "the locality of the node
singularity" as the ground of the inference (insufficient by itself, §10.3(B)) — even though the
conclusion they support is correct. §10 states the exact replacement, §11 prices the residual gaps,
and Remark 10.5 settles the textual question of whether [FKP] may be read as already stating (9.6)
in the punctured generality (arguably yes; it does not matter, because their proof of Lemma 9.1(iv)
is defective for $R\neq\varnothing$ either way).

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

## 4. Step 2 [E2]: the gluing map (7.8) exists in the presence of Ramond punctures

### 4.1 What is wrong

The whole of §9.1 — hence (9.6) — presupposes that the gluing map (7.8) exists, i.e. that
gluing two stable supercurves along an NS puncture yields a stable supercurve. That is
[FKP]'s Lemma 7.9 (I11). Its proof, **L1, p. 48**, reads in full (relevant part transcribed
verbatim from the page image):

> "Note that $L$ and $L'$ are generalized spin-structures, i.e., we have an isomorphism
> $L\xrightarrow{\ \sim\ }\underline{\operatorname{Hom}}(L,\omega_C)$ (which corresponds to
> $\delta^-$ on $X$), and similarly, for $L'$. Furthermore, we know that $L$ (resp., $L'$) is
> locally free near $P$ (resp., $P'$).
> The glued superscheme $Z$ has the underlying nodal curve $Z_0$, which is glued from $C$ and
> $C'$ along $P\simeq P'$, and
> $$\mathcal O_Z\simeq\mathcal O_{Z_0}\oplus j_*L\oplus j'_*L'.$$
> It is well known that the natural map
> $$j_*L\oplus j'_*L'\to\underline{\operatorname{Hom}}(j_*L\oplus j'_*L',\omega_{Z_0})$$
> is an isomorphism, i.e., $j_*L\oplus j'_*L'$ is a generalized spin-structure. It is easy to
> see that above map is precisely $\delta^-$, so this proves that $Z/S$ is a stable
> supercurve."

Compare [FKP]'s own definition of a generalized spin structure, **L1, p. 7** (I3):
(2.5) is $L\xrightarrow{\sim}\underline{\operatorname{Hom}}(L,\omega_C(\sum r_i))$, and "a
coherent sheaf $L$ on a prestable curve $C/S$ equipped with an isomorphism (2.5) is called a
generalized spin structure". The printed proof of Lemma 7.9 therefore uses the $r_\bullet=
\varnothing$ form throughout: it calls $L\cong\underline{\operatorname{Hom}}(L,\omega_C)$ "the"
generalized spin structure, and asserts the untwisted statement for $Z_0$. Similarly its first
paragraph says "$\delta^-$ induces an isomorphism of $\mathcal O_Z^-$ with $\omega_Z^-$", while
Def. 2.4's condition (2.4) (I1) demands an isomorphism with $\omega_Z(R)^-$.

So as printed Lemma 7.9 is proved only for $n_1=n_2=0$, and (7.8) is justified only for
$n_1=n_2=0$ — even though the displayed map (7.8) carries general $(n_1,n_2)$. This is
`[GAP-FKP-RAMOND]` at its sharpest point. **It is repairable.** The repair is §4.3.

### 4.2 A duality lemma for a branch of a nodal curve

> **Lemma 4.1.** Let $Z_0$ be a curve over an algebraically closed field with a node at $p_0$,
> let $C\subset Z_0$ be one of the two branches through $p_0$ (a closed subscheme, with
> $j\colon C\hookrightarrow Z_0$ the inclusion), and suppose $Z_0$ is Gorenstein of pure
> dimension 1 with dualizing sheaf $\omega_{Z_0}$. Set
> $j^!\mathcal F:=\underline{\operatorname{Hom}}_{\mathcal O_{Z_0}}(\mathcal O_C,\mathcal F)$,
> an $\mathcal O_C$-module. Then:
> 1. $j^!\omega_{Z_0}\cong\omega_C$, and under this isomorphism the trace map
>    $j_*j^!\omega_{Z_0}\hookrightarrow\omega_{Z_0}$ (evaluation at $1$) is the canonical
>    inclusion $j_*\omega_C\hookrightarrow\omega_{Z_0}$ of the dualizing sheaf of the branch.
> 2. For every line bundle $N$ on $Z_0$, $j^!(\omega_{Z_0}\otimes N)\cong\omega_C\otimes j^*N$,
>    compatibly with (1).
> 3. For every coherent $\mathcal O_C$-module $F$,
>    $\underline{\operatorname{Hom}}_{\mathcal O_{Z_0}}(j_*F,\omega_{Z_0}\otimes N)\cong
>    j_*\underline{\operatorname{Hom}}_{\mathcal O_C}(F,\omega_C\otimes j^*N)$, the
>    isomorphism sending $\phi\colon F\to\omega_C\otimes j^*N$ to the composite
>    $j_*F\xrightarrow{j_*\phi}j_*(\omega_C\otimes j^*N)\hookrightarrow\omega_{Z_0}\otimes N$.

*Proof.* (3) is the $\underline{\operatorname{Hom}}$-adjunction for the closed embedding $j$:
for any $\mathcal O_{Z_0}$-module $G$ and any $\mathcal O_C$-module $F$, an
$\mathcal O_{Z_0}$-linear map $j_*F\to G$ is the same as an $\mathcal O_C$-linear map
$F\to\underline{\operatorname{Hom}}_{\mathcal O_{Z_0}}(\mathcal O_C,G)=j^!G$, and this
identification is evaluation-at-$1$ composed with $j_*(-)$. Combined with (1) and (2) this is
exactly the displayed statement.

(2): for $N$ invertible,
$\underline{\operatorname{Hom}}_{\mathcal O_{Z_0}}(\mathcal O_C,\mathcal F\otimes N)\cong
\underline{\operatorname{Hom}}_{\mathcal O_{Z_0}}(\mathcal O_C,\mathcal F)\otimes N$, and the
right-hand side, viewed as an $\mathcal O_C$-module, is $j^!\mathcal F\otimes j^*N$.

(1): the statement is local, and away from $p_0$ the inclusion $j$ is an open immersion onto a
subscheme where $\mathcal O_C=\mathcal O_{Z_0}$, so $j^!\omega_{Z_0}=\omega_{Z_0}|_C=\omega_C$
and the trace is the identity. At $p_0$ take the complete local ring
$\mathcal O_{Z_0,p_0}=k[[x,y]]/(xy)$, with $C=\{y=0\}$, so
$\mathcal O_{C,p_0}=k[[x]]$. Then $\omega_{Z_0,p_0}$ is free of rank one on the generator
$\eta$ with $\eta=\frac{dx}{x}=-\frac{dy}{y}$ (the standard generator of the dualizing sheaf of
a node). Hence
$$j^!\omega_{Z_0}=\{\alpha\in\omega_{Z_0,p_0}:y\alpha=0\}
=\operatorname{Ann}_{\mathcal O_{Z_0,p_0}}(y)\cdot\eta=(x)\cdot\eta,$$
and $(x)\eta=k[[x]]\cdot x\eta=k[[x]]\,dx=\omega_{C,p_0}$; the inclusion
$(x)\eta\subset\omega_{Z_0,p_0}$ is precisely the standard inclusion
$j_*\omega_C\subset\omega_{Z_0}$ (i.e. "differentials on the branch, extended by zero on the
other branch, have no pole and zero residue at $p_0$"). $\square$

> **Remark 4.2.** The content of Lemma 4.1(1) is the *cancellation of two opposite twists*:
> $j^*\omega_{Z_0}=\omega_C(p_0)$, and $\underline{\operatorname{Hom}}(\mathcal O_C,
> \mathcal O_{Z_0})=\mathcal I_{C'}\cong\mathcal O_C(-p_0)$, so
> $j^!\omega_{Z_0}=\omega_C(p_0)(-p_0)=\omega_C$. This is why the node contributes **no** extra
> twist, and it is exactly what makes the argument insensitive to whether the Ramond twist is
> present: the Ramond points $r_i$ sit away from $p_0$ and pass through untouched.

### 4.3 The repair

> **Proposition 4.3 (Lemma 7.9 with Ramond punctures).** Let $S$ be even, and let
> $(X,P_\bullet,R_\bullet)/S$ and $(X',P'_\bullet,R'_\bullet)/S$ be families of stable
> supercurves with punctures; let $P\subset X$ and $P'\subset X'$ be NS punctures, and let
> $Z:=X\sqcup_{P\simeq S\simeq P'}X'$ be the glued superscheme, with $\delta_Z$ defined as the
> composite
> $$\mathcal O_Z\longrightarrow j_*\mathcal O_X\oplus j'_*\mathcal O_{X'}
> \xrightarrow{\ j_*\delta_X\oplus j'_*\delta_{X'}\ }
> j_*\omega_{X/S}(R)\oplus j'_*\omega_{X'/S}(R')\longrightarrow\omega_{Z/S}(R_{\rm tot}),$$
> where $R_{\rm tot}$ is the (disjoint) union of the images of $R_\bullet$ and $R'_\bullet$.
> Then $(Z,\text{remaining NS punctures},R_{\rm tot})/S$ is a family of stable supercurves with
> punctures. **No hypothesis $R=R'=\varnothing$ is needed.**

*Proof.* Follow [FKP]'s own reduction, replacing only the defective step.

*Reduction to a geometric point.* Everything except condition (2.4) of Def. 2.4 (I1) is a
statement about the superscheme $Z/S$, its open smooth part, and the divisors; it is verified
exactly as in [FKP]: $(U\smallsetminus P)\sqcup(U'\smallsetminus P')$ is an open subset of $Z$
which is a smooth supercurve over $S$ and contains all the remaining punctures. Condition
(2.4) is, verbatim in Def. 2.4, a condition **on each geometric fibre**; so it suffices to
treat $S=\operatorname{pt}$. Since $S$ is then even, Lemma 2.6 (I3) applies, and we must show:

> with $C,C'$ the bosonic truncations, $p\in C$, $p'\in C'$ the images of $P,P'$,
> $r_1,\dots,r_a\in C$ and $r'_1,\dots,r'_b\in C'$ the Ramond points, $L,L'$ the generalized
> spin structures, $Z_0:=C\cup_{p\sim p'}C'$, and $\mathcal L:=j_*L\oplus j'_*L'$, the map
> $$\delta^-_Z\colon\ \mathcal L\ \longrightarrow\
> \underline{\operatorname{Hom}}_{\mathcal O_{Z_0}}\!\big(\mathcal L,\ \omega_{Z_0}
> (\textstyle\sum_i r_i+\sum_j r'_j)\big)$$
> induced by $\delta^-_X=(2.5)_L$ and $\delta^-_{X'}=(2.5)_{L'}$ is an isomorphism.

Here I used: $\mathcal O_Z=\mathcal O_{Z_0}\oplus j_*L\oplus j'_*L'$ (L1, p. 48, quoted above —
this part of [FKP]'s proof is correct and puncture-independent, because $P\cong S$ has relative
dimension $0|0$, so the gluing condition $f|_P=f'|_{P'}$ is a condition on even sections only);
$\omega^-_Z=\underline{\operatorname{Hom}}(\mathcal L,\omega_{Z_0})$ and
$\omega_Z(R_{\rm tot})^-=\underline{\operatorname{Hom}}(\mathcal L,\omega_{Z_0}(R_{\rm tot}))$
by (I3) and the fact that $\mathcal O(R_{\rm tot})$ is an **even** line bundle — L1, p. 7:
"locally $R_i$ is given by an even equation $f\in\mathcal O^+_X=\mathcal O_C$, and $r_i$ is
given by the same equation $f$ in $C$"; and that $r_\bullet,r'_\bullet$ are disjoint from
$p_0:=[p]=[p']\in Z_0$, since by Def. 2.4 the punctures lie in the smooth locus.

Now compute, writing $D:=\sum_i r_i+\sum_j r'_j$ as a Cartier divisor on $Z_0$:
$$\underline{\operatorname{Hom}}_{\mathcal O_{Z_0}}(\mathcal L,\omega_{Z_0}(D))
=\underline{\operatorname{Hom}}(j_*L,\omega_{Z_0}(D))\ \oplus\
\underline{\operatorname{Hom}}(j'_*L',\omega_{Z_0}(D))$$
(a $\underline{\operatorname{Hom}}$ out of a direct sum). For the first summand, Lemma 4.1(3)
with $N=\mathcal O_{Z_0}(D)$ gives
$$\underline{\operatorname{Hom}}_{\mathcal O_{Z_0}}(j_*L,\omega_{Z_0}(D))
\ \cong\ j_*\,\underline{\operatorname{Hom}}_{\mathcal O_C}\!\big(L,\ \omega_C\otimes
j^*\mathcal O_{Z_0}(D)\big)
\ =\ j_*\,\underline{\operatorname{Hom}}_{\mathcal O_C}\!\big(L,\ \omega_C(\textstyle\sum_i
r_i)\big),$$
where $j^*\mathcal O_{Z_0}(D)=\mathcal O_C(\sum_i r_i)$ because the points $r'_j$ lie on
$C'\smallsetminus\{p'\}$, hence do not meet $C$. By (2.5) for $L$, the right-hand side is
$j_*L$. Symmetrically for the second summand. Adding,
$$\underline{\operatorname{Hom}}_{\mathcal O_{Z_0}}(\mathcal L,\omega_{Z_0}(D))\ \cong\
j_*L\oplus j'_*L'=\mathcal L .$$

It remains to check that the isomorphism just produced **is** $\delta^-_Z$. By Lemma 4.1(3) the
isomorphism sends $\phi\colon L\to\omega_C(\sum_i r_i)$ to the composite
$j_*L\xrightarrow{j_*\phi}j_*(\omega_C(\sum_i r_i))\hookrightarrow\omega_{Z_0}(D)$, i.e. to
"apply $\phi$ on the branch, then include via the trace". Taking $\phi=(2.5)_L=\delta^-_X$
(L1, p. 7: "The isomorphism (2.5) corresponds to $\delta^-$") and likewise on $C'$, this
composite is precisely the odd part of the three-arrow composite defining $\delta_Z$ in the
statement, whose last arrow is the canonical map $j_*\omega_{X/S}(R)\oplus j'_*\omega_{X'/S}
(R')\to\omega_{Z/S}(R_{\rm tot})$ — which on odd parts is, by Lemma 4.1(1), the trace
inclusion. Hence $\delta^-_Z$ is an isomorphism.

Finally $\mathcal L=j_*L\oplus j'_*L'$ is coherent, flat, relatively Cohen–Macaulay and locally
free of rank 1 on a fibrewise dense open of $Z_0$ (at $p_0$ its complete local module is
$k[[x]]\oplus k[[y]]$, which is torsion free of depth 1 over $k[[x,y]]/(xy)$), and $Z_0$ is
prestable with reduced fibres, smooth near all remaining marked points. By Lemma 2.6 the triple
$(Z_0,\mathcal L,\delta_Z^-)$ is a supercurve with punctures; stability of $Z$ is the stability
of $(Z_0,\text{marked points})$, unchanged from [FKP]. $\square$

> **Corollary 4.4.** The morphisms (7.8) and (7.9) exist as stated, for all
> $m_i\ge0$ and all even $n_i\ge0$:
> $$\overline{\mathcal S}_{g_1;m_1+1,n_1}\times\overline{\mathcal S}_{g_2;m_2+1,n_2}
> \to\overline{\mathcal S}_{g_1+g_2;m_1+m_2,n_1+n_2},\qquad
> \overline{\mathcal S}_{g;m+2,n}\to\overline{\mathcal S}_{g+1;m,n}.$$

*Proof.* Apply Prop. 4.3 to the two families pulled back from the factors (resp., to $X/S$ with
its two NS punctures $P,P'$), and use that $\overline{\mathcal S}_{g;m,n}$ *represents* the
functor of families of stable supercurves with $m$ NS and $n$ Ramond punctures (I4), so that
the constructed family over $\overline{\mathcal S}_{g_1;m_1+1,n_1}\times
\overline{\mathcal S}_{g_2;m_2+1,n_2}$ is classified by a unique morphism. $\square$

> **Remark 4.5 (consistency check on parities).** On a smooth fibre, (2.5) says
> $L^{\otimes2}\cong\omega_C(\sum r_i)$, so $2\deg L=2g-2+n$ and $n$ must be even. The gluing
> adds $n=n_1+n_2$, even ✓, and raises the genus by $g_1+g_2$ with no change to the parity
> bookkeeping — the glued $Z_0$ has arithmetic genus $g_1+g_2$ and $\mathcal L$ has
> "$\deg$" $g_1-1+\frac{n_1}2+g_2-1+\frac{n_2}2+1$, matching $\frac{2(g_1+g_2)-2+n}{2}+1$
> correctly for a node contribution. This is only a sanity check, not part of the proof.

---

## 5. Step 3 [E1]: the fundamental sequence carries a Ramond twist

### 5.1 What is wrong

**L1, p. 41** (I6) prints, for a smooth supercurve $U/S$,
$$0\to\omega^2_{U/S}\xrightarrow{\ \kappa\ }\Omega_{U/S}\xrightarrow{\ \delta\ }\omega_{U/S}
\to0,$$
and Lemma 7.1 concludes (7.1) $0\to\omega^2_{X/S}\to j_*\Omega_{U/S}\to\omega_{X/S}\to0$.
But [FKP]'s own §2.2, **L1, p. 5** (I2), gives for a smooth supercurve **with Ramond punctures**
$$0\to\mathcal D^{-2}(-R)\to\Omega_{X/S}\to\mathcal D^{-1}\to0,\qquad
\mathcal D\simeq\omega^{-1}_{X/S}(-R),$$
whence $\mathcal D^{-1}=\omega_{X/S}(R)$ and
$\mathcal D^{-2}(-R)=\omega^2_{X/S}(2R)(-R)=\omega^2_{X/S}(R)$, and the third arrow is
identified on the same page as
"$\delta\colon\Omega_{X/S}\to\mathcal D^{-1}\simeq\omega_{X/S}(R)$".
So the correct sequence on a smooth supercurve with Ramond punctures is
$$0\to\omega^2_{U/S}(R)\xrightarrow{\ \kappa\ }\Omega_{U/S}\xrightarrow{\ \delta\ }
\omega_{U/S}(R)\to0.\tag{7.1$'_{\rm sm}$}$$
The printed (7.1) is its $R=\varnothing$ specialisation. That this is an omission and not a
different convention is confirmed by [FKP]'s §7.4, **L1, p. 47** (I10), which writes the very
same $\delta$ **with** the twist: "$\delta\colon\Omega_{X/\overline{\mathcal S}}\to
\omega_{X/\overline{\mathcal S}}(R)$".

This matters, because **Lemma 9.1(iv) uses (7.1) by name**. L1, p. 60, proof of Lemma 9.1:
"(iv) This follows from parts (i), (ii) and from the exact sequence (7.1) (and a similar exact
sequence for $\Omega_{\widetilde X/B}$ which holds over the smooth locus)."

### 5.2 The repair

> **Lemma 5.1 (the $R$-twisted fundamental sequence).** Let $\pi\colon X\to S$ be a family of
> stable supercurves with punctures, $j\colon U\hookrightarrow X$ the complement of the nodes,
> $R\subset U$ the Ramond divisor. Then there is an exact sequence on $X$
> $$0\to\omega^2_{X/S}(R)\xrightarrow{\ \kappa\ }j_*\Omega_{U/S}
> \xrightarrow{\ j_*\delta\ }\omega_{X/S}(R)\to0.\tag{7.1-R}$$
> Moreover, on the open set $V:=X\smallsetminus R$ — which contains every node and every NS
> puncture — the canonical section $s_R$ of $\mathcal O_X(R)$ trivialises $\mathcal O_X(R)|_V$,
> and (7.1-R)$|_V$ is identified with (7.1)$|_V$.

*Proof.* On $U$ the sequence is (7.1$'_{\rm sm}$), which is [FKP]'s (I2) rewritten using (2.3),
as computed above. Apply $j_*$. Left-exactness is automatic. For the outer terms,
$R\subset U$ is a relative Cartier divisor **disjoint from the nodes**, so
$\mathcal O_X(R)$ is a line bundle on $X$ with $j^*\mathcal O_X(R)=\mathcal O_U(R)$, and by the
projection formula $j_*(\omega^{2}_{U/S}(R))=(j_*\omega^2_{U/S})(R)=\omega^2_{X/S}(R)$ (using
(I5) for the middle equality) and $j_*(\omega_{U/S}(R))=\omega_{X/S}(R)$.

Surjectivity of $j_*\delta$ is a local question on $X$. Away from the nodes it is the
surjectivity of $\delta$ on $U$. At a node it is [FKP]'s Lemma 7.1, whose proof is local at the
node (**L1, p. 42**: "Near a Ramond node, the map $\delta\colon\Omega_{X/S}\to\omega_{X/S}=
j_*\omega_{U/S}$ is surjective", followed by the NS-node computation); since $R$ does not meet
the nodes, $\mathcal O_X(R)$ is canonically trivial there and the twisted and untwisted
statements are literally the same statement. The last sentence of the Lemma is then the
definition of $s_R$. $\square$

> **Corollary 5.2 (where the twist is invisible).** Let $W\subset X$ be any open subset
> disjoint from $R$. Then over $W$ the sequences (7.1) and (7.1-R) coincide, canonically, via
> $s_R$. In particular this applies to:
> (a) a neighbourhood of a node $Q$;
> (b) a neighbourhood of an NS puncture $P_i$ and of its divisor $D_i$.
> Consequently, for any coherent sheaf $\mathcal F$ on $X$ whose support is contained in $W$,
> the canonical map $\mathcal F\to\mathcal F\otimes\mathcal O_X(R)$, $s\mapsto s\otimes s_R$,
> is an isomorphism.

*Proof.* Immediate: $s_R$ is nowhere vanishing on $X\smallsetminus R$, and by Def. 2.4 the
divisors $R_j$ are disjoint from the nodes (they lie in the smooth locus $U$) and from the
NS punctures and their divisors $D_i$ (Def. 2.4 requires the $P_i$ and $R_j$ to be disjoint
closed subschemes; $D_i$ is supported on $P_i$). $\square$

> **Remark 5.3 ([E1] does not damage §3).** Proposition 3.5 — the definition of $\Delta$ and
> the isomorphism (7.6) — does **not** use (7.1) at any point: it uses only Prop. 7.4 (I7),
> whose proof is étale-local at a single node, plus smoothness of
> $\overline{\mathcal S}_{g;m,n}$ and the codimension estimate. The only consumer of (7.1) in
> the whole chain is Lemma 9.1(iv), treated in §6.

> **Remark 5.4 (a third instance of the same omission).** The composite defining $\delta_Z$ in
> Lemma 7.9 is printed (L1, p. 47) as ending in $j_*\omega_{X/S}\oplus j'_*\omega_{X'/S}\to
> \omega_{Z/S}$, again untwisted; the correct composite is the one displayed in Prop. 4.3.
> [E1] and [E2] are thus two symptoms of one editorial fact: §7 of [FKP] was written with
> $R=\varnothing$ in mind, while §2 and §7.4 carry the twist. None of the three instances is a
> mathematical error in the untwisted case, and all three are repaired above.

---

## 6. Step 4: Lemma 9.1 in the presence of spectator punctures

### 6.1 The punctured §9.1 setup

Fix data as in Claim P. Put
$$B:=\mathcal S_{g_1;m_1+1,n_1}\times\mathcal S_{g_2;m_2+1,n_2}\quad\text{(separating case)},
\qquad B:=\mathcal S_{g;m+2,n}\quad\text{(non-separating case)},$$
and let $\iota\colon B\to\overline{\mathcal S}:=\overline{\mathcal S}_{g;m,n}$ be the
restriction of (7.8) (resp. (7.9)) to the smooth locus; this exists by Cor. 4.4. Let
$\widetilde\pi\colon\widetilde X\to B$ be the universal **smooth** supercurve over $B$ (in the
separating case $\widetilde X=X_1\sqcup X_2$ is the disjoint union of the two pulled-back
universal curves — "smooth supercurve" is used here in the possibly-disconnected sense, exactly
as in [FKP]'s §9.1), with:

- the two **glued** NS punctures $P_1,P_2$ and their divisors $D_1,D_2$, with psi-lines
  $\Psi_1,\Psi_2$;
- $m=m_1+m_2$ **spectator** NS punctures $P^{\rm sp}_\alpha$ with divisors $D^{\rm sp}_\alpha$
  and psi-lines $\Psi^{\rm sp}_\alpha$;
- the Ramond divisor $R=\sum_{j}R_j$, $n=n_1+n_2$ components.

By Def. 2.4 all of $D_1,D_2,D^{\rm sp}_\bullet,R$ are pairwise disjoint. Let
$X_B:=X\times_{\overline{\mathcal S}}B\to B$ be the pulled-back universal stable supercurve,
obtained from $\widetilde X$ by identifying $P_1\simeq B\simeq P_2$ into a relative node
$Q\subset X_B$ (Prop. 4.3), and $\rho\colon\widetilde X\to X_B$ the resulting finite morphism.
Note $Q\cong B$, $\rho^{-1}(Q)=P_1\sqcup P_2$, and $Q$ is disjoint from the images of
$D^{\rm sp}_\bullet$ and $R$. Following [FKP], set
$\omega^{2k}_{X_B/B}:=\omega^{2k}_{X/\overline{\mathcal S}}|_{X_B}$ and
$\omega^{2k+1}_{X_B/B}:=\omega^{2k}_{X_B/B}\otimes\omega_{X_B/B}$.

> **Lemma 6.0 (parity of the divisor line bundles).** $\mathcal O_{\widetilde X}(D_i)$ and
> $\mathcal O_{X}(R)$ are line bundles of rank $1|0$ (i.e. "even" divisors). Consequently
> $\omega^{2k}(\ast)$ has rank $1|0$ and $\omega^{2k+1}(\ast)$ has rank $0|1$ for any twist by
> such divisors.

*Proof.* For $R$: L1, p. 7, proof of Lemma 2.6 — "locally $R_i$ is given by an even equation
$f\in\mathcal O^+_X=\mathcal O_C$". For $D_i$: L1, p. 57, Remark 8.10 gives
$\Psi_i^{-1}\simeq P_i^*\omega_{\widetilde X/B}(D_i)=P_i^*\omega_{\widetilde X/B}\otimes
P_i^*\mathcal O(D_i)=\Psi_i\otimes P_i^*\mathcal O(D_i)$; since $\Psi_i^{\pm1}$ both have rank
$0|1$, $P_i^*\mathcal O(D_i)$ has rank $1|0$, and a line bundle whose restriction to a section
is even is even. The last assertion follows from
$\operatorname{rank}\omega=0|1$ (S3) and multiplicativity of parity. $\square$

### 6.2 Parts (i), (ii), (iii) are puncture-blind

> **Proposition 6.1.** Parts (i), (ii), (iii) of [FKP]'s Lemma 9.1 — the sequences
> (9.1), (9.3), (9.5), the isomorphisms (9.2), (9.4), and the statement
> $\operatorname{Ber}R\pi_*\Omega_{X_B/B}\simeq\operatorname{Ber}R\pi_*\Omega_{\widetilde X/B}$
> — hold verbatim in the setting of §6.1, for arbitrary $m\ge0$ and arbitrary even $n\ge0$.

*Proof.* We go through [FKP]'s proof (L1, p. 60) and check each input.

**(i)** The assertion is that $\rho^*\omega^2_{X_B/B}\cong\omega^2_{\widetilde X/B}(D_1+D_2)$.
[FKP]'s proof has exactly two ingredients. (a) A natural identification over the smooth locus
of $\widetilde X$: this is [FKP]'s Theorem 4.1 definition $\omega^{2k}:=j_*\omega^{2k}_{U}$
(I5), which is constructed from the morphism alone and mentions no puncture, plus the fact that
$\rho$ is an isomorphism away from $P_1\sqcup P_2$. (b) An extension across the node, checked
"in an étale neighborhood of the node … in the framework of Sec. 6.2, using a generator $e$ of
$\omega^2_{X/S}$ (see (6.13))". By §6.4 (I13) — "Everything in Sec. 6.2 and 6.3 has an analog
in the case of families of stable supercurves with punctures … **This will not change the local
picture near the nodes**" — this étale-local computation is unchanged by the presence of
$D^{\rm sp}_\bullet$ and $R$, which do not meet the node.
The canonical trivialisations of $\omega^2_{\widetilde X/B}(D_1+D_2)|_{P_i}$ used to identify
the cokernel with $\mathcal O_Q$ are [FKP]'s Cor. 8.8, stated in the §8.4 setup which
explicitly carries "$m$ NS punctures $P_1,\dots,P_m$ **and Ramond divisors $R_1,\dots,R_n$**"
(I14). Hence (9.1) and (9.2) hold.

**(ii)** [FKP]'s proof uses: Lemma 6.4 (a node-local statement of §6.2, unchanged by punctures
by (I13)); Remark 8.10, $\Psi_i^{-1}\simeq P_i^*\omega_{\widetilde X/B}(D_i)$, again from the
§8.4 setup with Ramond divisors (I14/I15); and explicit local coordinates
$\frac1{z_i}[dz_i|d\theta_i]$, $\frac{\theta_i}{z_i}[dz_i|d\theta_i]$ at $D_i$ and at $Q$. All
of these live on neighbourhoods of $D_1,D_2,Q$, which are disjoint from $D^{\rm sp}_\bullet$
and $R$. The passage from $m=0$ to general $m$ (here $m$ is the **$\omega$-exponent**, Remark
2.2) tensors (9.5) with $\omega^{2m}_{X_B/B}$, a line bundle, using the triviality of
$Q^*(\omega^2_{X_B/B})$ — again node-local. Hence (9.3), (9.4), (9.5) hold.

**(iii)** [FKP] open the proof with "First, we note that $\mathcal K$ is supported on the node,
so it is enough to prove the assertion after replacing $X_B$ with the formal neighborhood of
the node", so the argument is manifestly local at $Q$. Its only external input is Lemma 7.2(ii),
whose setup (L1, p. 42) is "a family of stable supercurves $X/S$ over a smooth affine base $S$
with a smooth map $t\colon S\to\mathbb A^1$ … the completion of $\mathcal O_X$ along $q(S_0)$
is given by the standard generators and relations (6.11)" — an étale-local hypothesis at a
single NS node, with **no puncture hypothesis at all**. Moreover $\Omega_{X_B/B}$ and
$\Omega_{\widetilde X/B}$ are puncture-blind by Lemma 3.1. Hence the sequence
$0\to\mathcal K\to\Omega_{X_B/B}\to\rho_*\Omega_{\widetilde X/B}\to0$ holds with the stated
filtration of $\mathcal K$.

For the last clause of (iii) we verify [FKP]'s assertion that $\operatorname{Ber}\pi_*\mathcal K$
is canonically trivial, using (S3). The subfactors are
$Q_*(\Psi_1^2\Psi_2^2),\ Q_*(\Psi_1^2\Psi_2),\ Q_*(\Psi_1\Psi_2^2),\ Q_*(\Psi_1\Psi_2)$;
since $\pi\circ Q=\operatorname{id}_B$ and each $\Psi_i$ has rank $0|1$, their ranks are
$1|0,\ 0|1,\ 0|1,\ 1|0$, so their Berezinians are
$$\Psi_1^2\Psi_2^2,\quad(\Psi_1^2\Psi_2)^{-1},\quad(\Psi_1\Psi_2^2)^{-1},\quad\Psi_1\Psi_2,$$
whose product is $\Psi_1^{2-2-1+1}\Psi_2^{2-1-2+1}=\mathcal O_B$. Hence
$\operatorname{Ber}R\pi_*\Omega_{X_B/B}\simeq\operatorname{Ber}R\pi_*\Omega_{\widetilde X/B}$.
**Note that no spectator $\Psi^{\rm sp}_\alpha$ occurs anywhere in this list** — the only
psi-lines that can appear are those of the two glued punctures, because $\mathcal K$ is
supported on $Q$. $\square$

### 6.3 Part (iv): the [E1] repair, done Berezinian-first

[FKP]'s (iv) produces the cokernel sheaf $\widetilde{\mathcal C}$ and reads off its Berezinian.
Its one-line proof — "(iv) This follows from parts (i), (ii) and from the exact sequence (7.1)"
(L1, p. 60) — is the **only** place in the whole chain where (7.1) is used, and therefore the
only place where [E1] bites. Rather than repairing the $3\times3$ diagram (which would require
checking the commutativity of squares whose vertical arrows are only defined up to the
torsion-freeness of $j_*\Omega_U$), we derive the Berezinian consequence directly. The
resulting statement is exactly the first display after Lemma 9.1 on L1, p. 60.

> **Proposition 6.2.** In the setting of §6.1, there is a canonical isomorphism
> $$\operatorname{Ber}R\pi_*\big(j_*\Omega_{U/\overline{\mathcal S}}\big|_{X_B}\big)\ \simeq\
> \operatorname{Ber}R\widetilde\pi_*\big(\Omega_{\widetilde X/B}(D_1+D_2)\big)\otimes
> \Psi_1^{-1}\otimes\Psi_2^{-1}.$$

*Proof.* **Row 1 (on $X_B$).** Restrict the $R$-twisted fundamental sequence (7.1-R) of
Lemma 5.1, written for the universal family $X\to\overline{\mathcal S}$, to the closed
substack $X_B\subset X$:
$$0\to\omega^2_{X_B/B}(R)\to\big(j_*\Omega_{U/\overline{\mathcal S}}\big)\big|_{X_B}
\to\omega_{X_B/B}(R)\to0 .$$
This is exact: restriction is right exact, and $\mathcal Tor_1^{\mathcal O_X}
(\omega_{X/\overline{\mathcal S}}(R),\mathcal O_{X_B})=0$ because
$\omega_{X/\overline{\mathcal S}}(R)$ is a line bundle. (I have used
$\omega^{2}_{X/\overline{\mathcal S}}|_{X_B}=\omega^2_{X_B/B}$, which is [FKP]'s **definition**
in Lemma 9.1(i), and $\omega_{X/\overline{\mathcal S}}|_{X_B}=\omega_{X_B/B}$, base change for
the relative dualizing sheaf of a flat proper family.)
By (S1),
$$\operatorname{Ber}R\pi_*\big(j_*\Omega_{U/\overline{\mathcal S}}|_{X_B}\big)=
\operatorname{Ber}R\pi_*\big(\omega^2_{X_B/B}(R)\big)\otimes
\operatorname{Ber}R\pi_*\big(\omega_{X_B/B}(R)\big).\tag{6.1}$$

**Row 2 (on $\widetilde X$).** On the smooth family $\widetilde X/B$, (7.1-R) reads
$0\to\omega^2_{\widetilde X/B}(R)\to\Omega_{\widetilde X/B}\to\omega_{\widetilde X/B}(R)\to0$
with all three terms locally free, hence locally split. Twist by the line bundle
$\mathcal O_{\widetilde X}(D_1+D_2)$ and apply the exact functor $\rho_*$ ($\rho$ finite):
$$0\to\rho_*\big(\omega^2_{\widetilde X/B}(D_1+D_2)\big)\otimes\mathcal O_{X_B}(R)
\to\rho_*\big(\Omega_{\widetilde X/B}(D_1+D_2)\big)
\to\rho_*\big(\omega_{\widetilde X/B}(D_1+D_2)\big)\otimes\mathcal O_{X_B}(R)\to0,$$
where I used the projection formula together with
$\rho^*\mathcal O_{X_B}(R)=\mathcal O_{\widetilde X}(R)$ ($\rho$ is an isomorphism near $R$).
By (S1), and since $R\pi_*\rho_*=R\widetilde\pi_*$,
$$\operatorname{Ber}R\widetilde\pi_*\big(\Omega_{\widetilde X/B}(D_1+D_2)\big)=
\operatorname{Ber}R\pi_*\Big(\rho_*\omega^2_{\widetilde X/B}(D_1+D_2)\otimes\mathcal O(R)\Big)
\otimes\operatorname{Ber}R\pi_*\Big(\rho_*\omega_{\widetilde X/B}(D_1+D_2)\otimes\mathcal O(R)
\Big).\tag{6.2}$$

**Comparison of the first factors.** Tensor (9.1) with $m=1$ — i.e.
$0\to\omega^2_{X_B/B}\to\rho_*\omega^2_{\widetilde X/B}(D_1+D_2)\to\mathcal O_Q\to0$, valid by
Prop. 6.1(i) — with the line bundle $\mathcal O_{X_B}(R)$. Since $Q\cap R=\varnothing$,
Cor. 5.2 gives a canonical $\mathcal O_Q\otimes\mathcal O(R)\cong\mathcal O_Q$. Hence
$$\operatorname{Ber}R\pi_*\Big(\rho_*\omega^2_{\widetilde X/B}(D_1+D_2)\otimes\mathcal O(R)\Big)
=\operatorname{Ber}R\pi_*\big(\omega^2_{X_B/B}(R)\big)\otimes
\operatorname{Ber}\pi_*\mathcal O_Q
=\operatorname{Ber}R\pi_*\big(\omega^2_{X_B/B}(R)\big),$$
because $Q\cong B$ gives $\pi_*\mathcal O_Q=\mathcal O_B$ of rank $1|0$, whose Berezinian is
canonically $\mathcal O_B$.

**Comparison of the second factors.** Tensor the "In addition" sequence of Lemma 9.1(ii) with
$m=0$ — i.e. $0\to\omega_{X_B/B}\to\rho_*\omega_{\widetilde X/B}(D_1+D_2)\to\mathcal C\to0$,
valid by Prop. 6.1(ii) — with $\mathcal O_{X_B}(R)$; again $\mathcal C$ is supported on $Q$, so
$\mathcal C\otimes\mathcal O(R)\cong\mathcal C$ canonically (Cor. 5.2). By (9.5),
$0\to Q_*\mathcal O_B\to\mathcal C\to Q_*(\Psi_1^{-1}\oplus\Psi_2^{-1})\to0$, and using (S3)
($\Psi_i^{-1}$ has rank $0|1$, so $\operatorname{Ber}\Psi_i^{-1}=\Psi_i$),
$$\operatorname{Ber}\pi_*\mathcal C=\operatorname{Ber}(\mathcal O_B)\otimes
\operatorname{Ber}(\Psi_1^{-1}\oplus\Psi_2^{-1})=\Psi_1\otimes\Psi_2 .$$
Hence
$$\operatorname{Ber}R\pi_*\Big(\rho_*\omega_{\widetilde X/B}(D_1+D_2)\otimes\mathcal O(R)\Big)
=\operatorname{Ber}R\pi_*\big(\omega_{X_B/B}(R)\big)\otimes\Psi_1\otimes\Psi_2 .$$

**Conclusion.** Substituting the last two displays into (6.2) and comparing with (6.1),
$$\operatorname{Ber}R\widetilde\pi_*\big(\Omega_{\widetilde X/B}(D_1+D_2)\big)=
\operatorname{Ber}R\pi_*\big(j_*\Omega_{U/\overline{\mathcal S}}|_{X_B}\big)\otimes\Psi_1
\otimes\Psi_2,$$
which is the assertion. $\square$

> **Remark 6.3 (what the repair cost).** Every occurrence of the Ramond twist cancelled for one
> reason only: the three sheaves whose Berezinians carry $\Psi$-information —
> $\mathcal O_Q$, $\mathcal C$, and later $\Omega(D_i)|_{D_i}$ — are **supported on $Q$ or on
> $D_1\cup D_2$**, and $R$ is disjoint from both. The middle terms of both rows,
> $j_*\Omega_{U}|_{X_B}$ and $\rho_*\Omega_{\widetilde X/B}(D_1+D_2)$, carry no $R$ at all
> (Lemma 3.1). This is the precise sense in which "$R$ is a spectator": not that $R$ is far
> from the node, but that the only $R$-twisted objects in the computation sit in the two outer
> columns, where they occur once on each side and cancel.

> **Remark 6.4 (the spectator NS punctures never appear).** By the same token, no
> $\Psi^{\rm sp}_\alpha$ occurs anywhere in §6: (i)–(iii) are node-local, and Prop. 6.2's
> correction terms are $\operatorname{Ber}\pi_*\mathcal O_Q$ and $\operatorname{Ber}\pi_*
> \mathcal C$, both computed from $Q,\Psi_1,\Psi_2$ alone.

---

## 7. Step 5: the $D_1+D_2$ cancellation

This is the step [FKP] compress into one line ("Finally the exact sequence
$0\to\omega^2_{\widetilde X/B}\to\Omega_{\widetilde X/B}\to\omega_{\widetilde X/B}\to0$ near
$D_1,D_2$, together with Lemma 8.7, show that …", L1, p. 60). Because it invokes the untwisted
sequence, it is the second place where [E1] could bite; it does not, and here is why.

> **Proposition 7.1.** In the setting of §6.1 there is a canonical isomorphism
> $$\operatorname{Ber}R\widetilde\pi_*\big(\Omega_{\widetilde X/B}(D_1+D_2)\big)\ \simeq\
> \operatorname{Ber}R\widetilde\pi_*\big(\Omega_{\widetilde X/B}\big),$$
> for arbitrary $m\ge0$ spectator NS punctures and arbitrary even $n\ge0$ Ramond punctures.

*Proof.* Since $D_1$ and $D_2$ are disjoint relative Cartier divisors and
$\Omega_{\widetilde X/B}$ is locally free (rank $1|1$; $\widetilde X/B$ is smooth), there is an
exact sequence
$$0\to\Omega_{\widetilde X/B}\to\Omega_{\widetilde X/B}(D_1+D_2)\to
\bigoplus_{i=1}^2\Big(\Omega_{\widetilde X/B}(D_i)\big|_{D_i}\Big)\to0 ,$$
obtained by tensoring $0\to\mathcal O\to\mathcal O(D_1+D_2)\to\bigoplus_i\mathcal O(D_i)|_{D_i}
\to0$ with $\Omega_{\widetilde X/B}$. The quotient is $\widetilde\pi$-finite, so by (S1)
$$\operatorname{Ber}R\widetilde\pi_*\big(\Omega_{\widetilde X/B}(D_1+D_2)\big)=
\operatorname{Ber}R\widetilde\pi_*\big(\Omega_{\widetilde X/B}\big)\otimes
\prod_{i=1}^2\operatorname{Ber}\widetilde\pi_*\Big(\Omega_{\widetilde X/B}(D_i)\big|_{D_i}
\Big).$$
It remains to show each factor $\operatorname{Ber}\widetilde\pi_*(\Omega_{\widetilde X/B}(D_i)
|_{D_i})$ is canonically $\mathcal O_B$.

Fix $i$. On the smooth family $\widetilde X/B$ we have (7.1-R):
$0\to\omega^2_{\widetilde X/B}(R)\to\Omega_{\widetilde X/B}\to\omega_{\widetilde X/B}(R)\to0$,
with all terms locally free, hence locally split. Tensoring with the line bundle
$\mathcal O(D_i)$ and restricting to $D_i$ preserves exactness, and
$\mathcal O(R)|_{D_i}\cong\mathcal O_{D_i}$ **canonically** by Cor. 5.2, since $D_i\cap
R=\varnothing$ (Def. 2.4: the NS punctures and the Ramond divisors are disjoint). Therefore
$$0\to\omega^2_{\widetilde X/B}(D_i)\big|_{D_i}\to\Omega_{\widetilde X/B}(D_i)\big|_{D_i}
\to\omega_{\widetilde X/B}(D_i)\big|_{D_i}\to0$$
is exact, and by (S1)
$$\operatorname{Ber}\widetilde\pi_*\Big(\Omega_{\widetilde X/B}(D_i)\big|_{D_i}\Big)=
\operatorname{Ber}\widetilde\pi_*\Big(\omega^2_{\widetilde X/B}(D_i)\big|_{D_i}\Big)\otimes
\operatorname{Ber}\widetilde\pi_*\Big(\omega_{\widetilde X/B}(D_i)\big|_{D_i}\Big).$$
Now apply Lemma 8.7 (I14), which is stated for a family carrying $m$ NS punctures **and $n$
Ramond divisors**, in its two displayed forms:
- $\omega^2_{\widetilde X/B}(D_i)$ has rank $1|0$ by Lemma 6.0, so
  $\operatorname{Ber}\widetilde\pi_*\big(\omega^2_{\widetilde X/B}(D_i)|_{D_i}\big)\simeq
  \Psi_i^{-1}$;
- $\omega_{\widetilde X/B}(D_i)$ has rank $0|1$ by Lemma 6.0, so
  $\operatorname{Ber}\widetilde\pi_*\big(\omega_{\widetilde X/B}(D_i)|_{D_i}\big)\simeq\Psi_i$.

Their product is $\Psi_i^{-1}\otimes\Psi_i\simeq\mathcal O_B$, the canonical evaluation
pairing. $\square$

> **Remark 7.2.** The cancellation is *exactly* the statement that $\Omega$ has rank $1|1$: its
> two Jordan–Hölder pieces on $D_i$ have opposite parity, so Lemma 8.7 assigns them $\Psi_i^{-1}$
> and $\Psi_i$. Nothing in it depends on $m$ or $n$: the spectator punctures $D^{\rm sp}_\alpha$
> do not meet $D_i$, so they contribute no factor, and $R$ contributes the canonically trivial
> $\mathcal O(R)|_{D_i}$. This answers the adversarial worry recorded as step 3 of `claim.md`
> §4 ("check that the cancellation $\Psi_i^{-1}\cdot\Psi_i=\mathcal O$ there is insensitive to
> the spectator punctures"): it is.

---

## 8. The theorem

### 8.1 The separating case (Claim P)

> **Theorem 8.1 (punctured normal-line formula, separating case).** Let $g_1,g_2\ge0$ and
> $m_1,m_2\ge0$, $n_1,n_2\ge0$ even, be such that $(g_1;m_1{+}1,n_1)$ and $(g_2;m_2{+}1,n_2)$
> lie in the stable range. Put $g=g_1+g_2$, $m=m_1+m_2$, $n=n_1+n_2$, and let
> $$\iota\colon\ B=\mathcal S_{g_1;m_1+1,n_1}\times\mathcal S_{g_2;m_2+1,n_2}\
> \longrightarrow\ \overline{\mathcal S}_{g;m,n}$$
> be the separating NS gluing map (7.8) restricted to the smooth locus, and $\Psi_1,\Psi_2$ the
> psi-lines of the two glued NS punctures. Then there are isomorphisms of line bundles of rank
> $1|0$ on $B$
> $$\iota^*\mathcal O(\Delta_{\rm NS})\ \cong\ \iota^*\mathcal O(\Delta)\ \cong\
> \Psi_1^{-1}\otimes\Psi_2^{-1},$$
> canonical up to the sign ambiguity of Remark 8.2. In particular the formula holds for
> **arbitrary** $m,n$, not only $m=n=0$.

*Proof.* The map $\iota$ exists by Cor. 4.4. For the second isomorphism:
$$
\begin{aligned}
\iota^*\mathcal O(\Delta)
&\ \cong\ \Big[\operatorname{Ber}R\pi_*\big(j_*\Omega_{U/\overline{\mathcal S}}\big)\otimes
\operatorname{Ber}^{-1}R\pi_*\big(\Omega_{X/\overline{\mathcal S}}\big)\Big]\Big|_B
&&\text{(Prop.\ 3.5)}\\
&\ \cong\ \operatorname{Ber}R\pi_*\big(j_*\Omega_{U/\overline{\mathcal S}}\big|_{X_B}\big)
\otimes\operatorname{Ber}^{-1}R\pi_*\big(\Omega_{X_B/B}\big)
&&\text{(S2)}\\
&\ \cong\ \operatorname{Ber}R\widetilde\pi_*\big(\Omega_{\widetilde X/B}(D_1+D_2)\big)\otimes
\Psi_1^{-1}\Psi_2^{-1}\otimes\operatorname{Ber}^{-1}R\widetilde\pi_*
\big(\Omega_{\widetilde X/B}\big)
&&\text{(Prop.\ 6.2, Prop.\ 6.1(iii))}\\
&\ \cong\ \Psi_1^{-1}\otimes\Psi_2^{-1}
&&\text{(Prop.\ 7.1).}
\end{aligned}
$$
In the second line, (S2) is applied to $j_*\Omega_{U/\overline{\mathcal S}}$ and
$\Omega_{X/\overline{\mathcal S}}$, both of which are flat over $\overline{\mathcal S}$ by (I7);
and $\Omega_{X/\overline{\mathcal S}}|_{X_B}=\Omega_{X_B/B}$ because Kähler differentials
commute with base change. The first isomorphism of the Theorem is Prop. 9.1 below.

Finally the rank: each $\Psi_i$ has rank $0|1$, so $\Psi_1^{-1}\otimes\Psi_2^{-1}$ has rank
$1|0$ — as it must, $\mathcal O(\Delta)$ being the line bundle of an effective Cartier divisor,
which is even. $\square$

> **Remark 8.2 (signs).** Every identification used above is canonical as a map of line
> bundles, except that the multiplicativity isomorphism (S1) for $\operatorname{Ber}$ in a short
> exact sequence involves a choice of ordering of the factors, which can change the total
> isomorphism by a sign. [FKP] work under the same proviso — their Theorem 9.2 checks
> compatibility "up to a sign", and their §9.3 is stated as a conjecture "up to a sign".
> **Claim P as an isomorphism of line bundles is unaffected**; only the identification of a
> preferred generator would be. Nothing downstream in the supermoduli paper uses more than the
> isomorphism class, so I do not track signs.

### 8.2 The non-separating case (Claim P′)

> **Theorem 8.3.** Let $g\ge0$, $m\ge0$, $n\ge0$ even with $(g;m{+}2,n)$ in the stable range,
> and let $\iota\colon B=\mathcal S_{g;m+2,n}\to\overline{\mathcal S}_{g+1;m,n}$ be the
> non-separating gluing map (7.9) restricted to the smooth locus. Then, with $\Psi_1,\Psi_2$
> the psi-lines of the two glued punctures,
> $\iota^*\mathcal O(\Delta_{\rm NS})\cong\iota^*\mathcal O(\Delta)\cong\Psi_1^{-1}\otimes
> \Psi_2^{-1}$.

*Proof.* Everything in §§3, 5, 6, 7 was written for "one of the maps (7.8) or (7.9)", exactly
as in [FKP]'s own §9.1 setup (I16), and uses only: the node $Q$, the two divisors $D_1,D_2$,
the finite morphism $\rho\colon\widetilde X\to X_B$, and the disjointness of
$\{Q,D_1,D_2\}$ from $R$ and from the spectator punctures. All of these hold verbatim when
$\widetilde X$ is connected and $P_1,P_2$ are two NS punctures of the same curve.

The single point needing amendment is Lemma 4.1, which was stated for a **closed** branch
embedding $j\colon C\hookrightarrow Z_0$. In the non-separating case the relevant morphism is
the partial normalization $\nu\colon\widetilde C\to Z_0$ at the new node $p_0$, with
$\nu^{-1}(p_0)=\{p,p'\}$ two distinct smooth points of $\widetilde C$; $\nu$ is finite and an
isomorphism away from $p_0$, but not a closed immersion. Lemma 4.1 holds verbatim for $\nu$,
with the identical proof: set $\nu^!\mathcal F:=\underline{\operatorname{Hom}}_{\mathcal
O_{Z_0}}(\nu_*\mathcal O_{\widetilde C},\mathcal F)$; at $p_0$ one has
$(\nu_*\mathcal O_{\widetilde C})_{p_0}=k[[x]]\times k[[y]]$ inside
$\mathcal O_{Z_0,p_0}=k[[x,y]]/(xy)$, so
$$\nu^!\omega_{Z_0}\big|_{p_0}=\underline{\operatorname{Hom}}(k[[x]],\omega_{Z_0})\oplus
\underline{\operatorname{Hom}}(k[[y]],\omega_{Z_0})=(x)\eta\oplus(y)\eta
=\omega_{\widetilde C,p}\oplus\omega_{\widetilde C,p'},$$
i.e. $\nu^!\omega_{Z_0}=\omega_{\widetilde C}$ with the trace $\nu_*\omega_{\widetilde C}
\hookrightarrow\omega_{Z_0}$ the canonical inclusion. (Equivalently: $\nu^!$ takes the
dualizing complex of $Z_0$ to that of $\widetilde C$.) Prop. 4.3 then reads: $\mathcal L:=
\nu_*L$ satisfies $\mathcal L\cong\underline{\operatorname{Hom}}(\mathcal L,\omega_{Z_0}
(\sum r_i))$, by the same three-line computation, because the Ramond points $r_i$ are disjoint
from $p,p'$ and $\nu^*\mathcal O_{Z_0}(\sum r_i)=\mathcal O_{\widetilde C}(\sum r_i)$. The rest
of the proof of Theorem 8.1 applies unchanged. $\square$

---

## 9. $\Delta$ versus $\Delta_{\rm NS}$ on $B$

> **Proposition 9.1.** In the setting of Theorem 8.1 or 8.3,
> $\iota^*\mathcal O(\Delta_{\rm R})\cong\mathcal O_B$ canonically, hence
> $\iota^*\mathcal O(\Delta_{\rm NS})\cong\iota^*\mathcal O(\Delta)$.

*Proof.* By Prop. 7.8(ii) (I10), $\Delta_{\rm R}$ is an effective Cartier divisor **supported
on the locus of stable supercurves with at least one Ramond node**, and
$\Delta=\Delta_{\rm NS}+\Delta_{\rm R}$.

Every geometric point of $\iota(B)$ is a stable supercurve $Z$ obtained by Prop. 4.3 from
smooth supercurves by gluing along NS punctures; it has exactly one node, and that node is an
**NS** node. Indeed, by the proof of Prop. 4.3 the odd structure sheaf at the node is
$\mathcal O_Z^-=j_*L\oplus j'_*L'$ (resp. $\nu_*L$), which has rank $1$ on each of the two
branches, since $L,L'$ are locally free near $P,P'$ (L1, p. 48: "we know that $L$ (resp. $L'$)
is locally free near $P$ (resp. $P'$)"). In [FKP]'s étale-local classification (Lemma 7.5, I9),
that is exactly the NS-node model — generated by $z_1,z_2,\theta_1,\theta_2$, with **two**
independent odd coordinates — whereas the Ramond-node model is generated by $z_1,z_2,\theta$
with a **single** odd coordinate. Hence $\iota(B)\cap\operatorname{Supp}\Delta_{\rm R}=
\varnothing$, so the canonical section $s_{\Delta_{\rm R}}$ of $\mathcal O(\Delta_{\rm R})$ is
nowhere vanishing along $\iota(B)$ and $\iota^*s_{\Delta_{\rm R}}$ is a canonical
trivialisation of $\iota^*\mathcal O(\Delta_{\rm R})$. Tensoring $\Delta=\Delta_{\rm NS}+
\Delta_{\rm R}$ gives the second assertion. $\square$

> **Remark 9.2 (two independent confirmations from [FKP]).** (a) Prop. 7.8(i) (I10) states that
> $\Delta_{\rm NS}$ *coincides with* $\Delta$ in a neighbourhood of any point corresponding to
> a stable supercurve with only NS nodes; every point of $\iota(B)$ is such a point, so already
> the divisors — not just the line bundles — agree near $\iota(B)$. (b) Lemma 7.10 (I12)
> asserts that (7.8) and (7.9) "factor through the divisor $\Delta_{\rm NS}$", and its proof is
> written for stable supercurves **with punctures** ("where we take into account all the
> punctures on both sides", L1, p. 48). Neither is needed for Prop. 9.1, but both agree with it.

> **Remark 9.3 (Ramond punctures are not Ramond nodes).** This is the point at which a reader
> might expect trouble and finds none: $\Delta_{\rm R}$ is about Ramond **nodes** — degenerate
> curves — whereas the $n$ Ramond **punctures** carried by the target
> $\overline{\mathcal S}_{g;m,n}$ live in the smooth locus of every fibre and never make a
> curve lie on $\Delta_{\rm R}$.

---

## 10. What the supermoduli paper may assert without `[INF-NORMAL]`

This section instantiates Theorem 8.1 at the indices actually used in
`research/papers/supermoduli-punctured-nonprojected/paper.md`, states the exact replacement for
Remark 5.8, and — this is the part that is *not* a rubber stamp — lists the two sentences of the
paper's own justification that are **wrong as written**, even though its conclusion is right.

### 10.1 The paper's indices

Construction 5.3 of the paper fixes $(C,L)$ of genus $h\ge2$ with $L^{\otimes2}\cong\omega_C$,
$H^0(L)=0$, and a tail $\xi=(F,N;q,y_1,\dots,y_n;\rho_1,\dots,\rho_{2r})$, and sets
$$\mathcal B:=\mathfrak S^+_{h;1,0}\times\mathfrak S_{a;n+1,2r},\qquad
\Gamma\colon\mathcal B\to\overline{\mathfrak S}_{g;n,2r}\ \ (g=h+a),$$
declaring $\Gamma$ to be [FKP, (7.8)] with $g_1=h,\ m_1=0,\ n_1=0;\ g_2=a,\ m_2=n,\ n_2=2r$.

> **Corollary 10.1 (Theorem 8.1 at the paper's indices).** Assume the paper's standing hypotheses
> $h\ge2$ and (P2) $2a-2+(n+1)+2r>0$. Then
> $$\Gamma^*\mathcal O(\Delta_{\rm NS})\ \cong\ \Gamma^*\mathcal O(\Delta)\ \cong\
> \Psi_1^{-1}\otimes\Psi_2^{-1}$$
> as line bundles of rank $1|0$ on $\mathcal B$, canonically up to the sign of Remark 8.2, where
> $\Psi_1$ is the psi-line of the NS puncture of the first factor and $\Psi_2$ that of $q$ on the
> second.

*Proof.* The hypotheses of Theorem 8.1 are met:

- $(g_1;m_1{+}1,n_1)=(h;1,0)$ is stable, since $2h-2+1>0$ for $h\ge2$;
- $(g_2;m_2{+}1,n_2)=(a;n+1,2r)$ is stable, since $2a-2+(n+1)+2r>0$ is exactly the paper's (P2);
- $n_1=0$ and $n_2=2r$ are both even, as Theorem 8.1 requires;
- the target is $\overline{\mathcal S}_{h+a;\,0+n,\,0+2r}=\overline{\mathcal S}_{g;n,2r}$, which is
  the paper's target;
- $\mathcal B$ is a product of two *uncompactified* factors, so $\Gamma$ lands in the image of the
  smooth locus, which is where $\iota$ of Theorem 8.1 is defined. (The paper states this itself in
  Lemma 5.5(a).)

Finally $\mathcal B$ is not quite the $B$ of Theorem 8.1: the first factor is the even-parity piece
$\mathfrak S^+_{h;1,0}\subseteq\mathcal S_{h;1,0}$. That is irrelevant. Writing
$\jmath\colon\mathcal B\to B$ for the inclusion, $\Gamma=\iota\circ\jmath$ by construction, so
$\Gamma^*=\jmath^*\iota^*$ and the isomorphism of Theorem 8.1 pulls back. (No property of $\jmath$
beyond its being a morphism is used; that spin parity is a deformation invariant, hence that
$\jmath$ is an open and closed immersion, is true but not needed.) $\square$

> **Lemma 10.2 (the psi-lines really do factor).** In the situation of Cor. 10.1, with
> $\mathrm{pr}_i\colon\mathcal B\to\mathcal S_i$ the two projections and $\Psi_{P_i}$ the psi-line
> of the marked NS puncture on the $i$-th factor,
> $$\Psi_1\cong\mathrm{pr}_1^*\Psi_{P_1},\qquad\Psi_2\cong\mathrm{pr}_2^*\Psi_{P_2}.$$

*Proof.* The paper asserts this in the third paragraph of Lemma 5.5(a); since it is used to route
$\Psi_1$ to the first factor and $\Psi_2$ to the tail, I verify it. By [FKP, Remark 8.10] (I15, L1
p. 57), $\Psi_i^{-1}\simeq P_i^*\omega_{\widetilde X/B}(D_i)$. For a separating node
$\widetilde X=\mathrm{pr}_1^*\widetilde X_1\sqcup\mathrm{pr}_2^*\widetilde X_2$ as super schemes
over $B=\mathcal S_1\times\mathcal S_2$, and each $\mathrm{pr}_i$ is flat (it is a projection of a
product of smooth stacks), so relative dualising sheaves commute with the base change
$\mathrm{pr}_i$:
$\omega_{\widetilde X/B}\big|_{\mathrm{pr}_i^*\widetilde X_i}
\cong\mathrm{pr}_i^*\omega_{\widetilde X_i/\mathcal S_i}$. The divisor $D_i$ and the section $P_i$
are likewise pulled back from the $i$-th factor. Applying $P_i^*$ to a pullback gives the pullback
of $P_{i}^*$ computed on the factor, whence the claim. $\square$

> **Remark 10.3.** The paper's parenthetical caution — that the sentence on [FKP, p. 58] about
> $\mathcal B(\mathcal O_{\widetilde X})$ being an exterior product "must not be used for the
> factorisation above" — is correct and is honoured here: Lemma 10.2 uses only Remark 8.10 and flat
> base change, never $\mathcal B(\mathcal O_{\widetilde X})$. I confirmed at L1 (p. 58) that the
> sentence in question is indeed about $\mathcal B(\mathcal O_{\widetilde X})$ and not about $\Psi$.

> **Remark 10.4 (the paper's $N_{\mathcal B}$ matches [FKP]'s definition verbatim).** The paper
> defines $N_{\mathcal B}:=\mathcal O(\Delta_{\rm NS})|_{\mathcal B}$ and calls it "the normal line
> bundle of $\Gamma$". No independent identification with a normal bundle is owed, because [FKP]
> define the symbol the same way: L1, p. 59, "*where $N_B$ is the normal bundle defined as the
> pull-back of $\mathcal O(\Delta_{NS})$ to $B$*". Nothing in this attempt, and nothing in the
> paper, uses a normal-bundle property of $N_{\mathcal B}$ beyond its being this line bundle.

### 10.2 The assertion the paper is now entitled to

Combining Cor. 10.1, Lemma 10.2 and the paper's own parts (b) and (c) of Lemma 5.5 — neither of
which is touched here — the paper may state Lemma 5.5 **unconditionally**, i.e. delete the words
"an inference" and the conditionality clause of Remark 5.8. Concretely, the sentence

> *"Our use of it for the punctured target $\overline{\mathfrak S}_{g;n,2r}$ is an inference …
> and a reader who declines to make it should read every statement of this paper as conditional on
> it."*

may be replaced by a pointer to Cor. 10.1 above. The replacement carries a price, stated in §10.3
and §10.4, and it is not the price the paper currently anticipates.

I emphasise what is **not** being claimed. Cor. 10.1 concerns only Lemma 5.5(a). Parts (b) and (c)
are untouched: (b) is [CN]'s argument on the unpunctured first factor via [FKP, Example 8.9], and
(c) is the observation that $\mathfrak n$ is a line because the tail is constant. This attempt
supplies **no** information about $\mathfrak n$ (see G4 in §11), and the paper's Remark 5.7 —
which quarantines all Ramond difficulty inside $\mathfrak n$ and never computes it — remains both
necessary and correct.

### 10.3 Two sentences of the paper that are wrong as written

Retracting `[INF-NORMAL]` is not simply deleting a caveat: the *reason* the paper gives for its
inference does not survive contact with the source.

**(A) "No puncture enters this derivation" (Lemma 5.5(a), Route 2 bullet) is false.** Punctures
enter route 2 in three places, all of which had to be dealt with above:

1. *The existence of $\Gamma$ itself.* $\Gamma$ is [FKP, (7.8)] with $n_2=2r$ Ramond punctures; the
   map is well defined only because the glued object is a stable supercurve, which is [FKP,
   Lemma 7.9], whose printed proof invokes $L\cong\underline{\operatorname{Hom}}(L,\omega_C)$ — the
   $r=0$ case of (2.5). See §4, defect **[E2]**, repaired by Prop. 4.3 / Cor. 4.4.
2. *The proof of Lemma 9.1(iv).* L1, p. 60: "*(iv) This follows from parts (i), (ii) and from the
   exact sequence (7.1)…*". Sequence (7.1) as printed is the $R=\varnothing$ specialisation and is
   **false** when $R\neq\varnothing$. See §5, defect **[E1]**, repaired by Lemma 5.1 of this note
   (the twisted sequence (7.1-R)) and Prop. 6.2.
3. *The final step of route 2.* L1, p. 60: "*Finally the exact sequence
   $0\to\omega^2_{\widetilde X/B}\to\Omega_{\widetilde X/B}\to\omega_{\widetilde X/B}\to0$ near
   $D_1,D_2$, together with Lemma 8.7…*". This is again the untwisted sequence; it is legitimate
   only because [FKP] restrict it to a neighbourhood of $D_1,D_2$, which is disjoint from $R$ —
   exactly Cor. 5.2. With punctures present one must also know $\mathcal O(R)|_{D_i}$ is canonically
   trivial and that the spectator divisors miss $D_i$. See Prop. 7.1.

So the correct statement is not "no puncture enters" but "**punctures enter three times and each
contribution is canonically trivial**". The distinction is not pedantry: item 2 is a place where
[FKP]'s printed argument is *incorrect* in the punctured setting, and an author who believed "no
puncture enters" would have had no reason to look.

**(B) The ground given in Remark 5.8 — "the locality of the node singularity" — is insufficient by
itself.** That $\mathcal K$ and $\widetilde{\mathcal C}$ are "supported on the node" bounds where the
*comparison* sheaves live, but the objects being compared are
$\operatorname{Ber}R\pi_*(-)$, which is a global invariant of the whole fibre: a statement about the
support of a kernel and cokernel does not by itself imply that the two Berezinians differ by a
node-local factor, since one still needs the two outer terms to be flat, the sequences to exist
globally on $X_B$, and the Berezinians of the comparison sheaves to be computed. The ground that
does work is different and stronger:

- **Lemma 3.1 (puncture-blindness of the input).** The complex $[\Omega_{X/S}\to j_*\Omega_{U/S}]$,
  the line bundle $\mathcal B$, its canonical trivialisation $c$, and hence $\Delta$ and (7.6),
  are constructed from $\pi\colon X\to S$ alone. The punctures enter a supercurve only through the
  derivation $\delta$ and the divisor $R$, and neither appears anywhere in that construction. This,
  not locality, is why (7.6) transports to a punctured target (Prop. 3.5).
- **Lemma 3.3 + Cor. 3.4 (the hypothesis of Prop. 7.4 holds on the punctured stack)**, which is the
  only other thing (7.6) needs. This I did verify at L1: the proof of [FKP, Prop. 7.4] (pp. 44–45)
  works "*in an étale neighborhood of a point on $S$ corresponding to a stable supercurve with one
  node*" and chooses a relative Cartier divisor $D$ "*disjoint from the node*"; no puncture
  hypothesis, no use of $\delta$ or $R$, occurs in it.

### 10.4 What the retraction costs: an inherited debt to [FKP]

If the paper retracts `[INF-NORMAL]` by citing Cor. 10.1, it inherits §§4–5 of this attempt as part
of the cited content, i.e. it inherits two corrections to [FKP]:

- **[E1]** [FKP, (7.1)] should read $0\to\omega^2_{X/S}(R)\to j_*\Omega_{U/S}\to\omega_{X/S}(R)\to0$.
  As printed the sequence is stated without the twist in a section whose supercurves may carry
  Ramond divisors. Consumers: Lemma 9.1(iv) only, within the (9.6) chain.
- **[E2]** [FKP, Lemma 7.9] is proved only for $R=\varnothing$. The statement is true in general
  (Prop. 4.3), but the printed proof is not a proof of it.

Neither is the paper's error — the paper cites statements that [FKP] do make, with the indices that
[FKP] do allow in (7.8)/(7.9). They are defects in the source. But an unconditional Lemma 5.5 rests
on them, so an honest paper should name them rather than let them be invisible. My recommendation is
a short remark, e.g. `[FKP-ERRATA]`, next to Construction 5.3 and Lemma 5.5, citing this attempt.

> **Remark 10.5 (was the caution in Remark 5.8 warranted?).** Yes, and more so than its author
> thought, though for a different reason. Textually, [FKP]'s §9.1 does *not* restrict the number of
> punctures: the setup sentence (I16) says "*one of the maps (7.8) or (7.9)*", and (7.8)/(7.9) carry
> general $(m_i,n_i)$; Lemma 9.1 and the route-2 computation on p. 60 are likewise index-free; and
> the proof of Theorem B immediately above, on the same page, sets
> $\overline{\mathcal S}=\overline{\mathcal S}_{g,n_{NS},n_R}$ (L1, p. 58). So a literal reader could
> argue (9.6) *is* stated in the punctured generality. Against that: [FKP]'s own Theorem C is stated
> for $\overline{\mathcal S}_g$, and their route 1 visibly specialises to no NS punctures — L1,
> p. 58: "*We can rewrite (8.11) near $B$ as an isomorphism
> $K_{\overline{\mathcal S}}(2\Delta_{NS})\simeq\mathcal B(\mathcal O_X)^5$*", which drops the factor
> $\bigotimes_{i=1}^m\Psi_i$ of (8.11) and can only hold for $m=0$; and p. 59 top,
> "$K_B\simeq\mathcal B(\mathcal O_{\widetilde X})^5\otimes\Psi_1\otimes\Psi_2$", with only the two
> glued psi-lines present. So [FKP] had the unpunctured case in view even where the prose did not say
> so. **The decisive point, however, is neither textual: route 2's proof of Lemma 9.1(iv) really is
> defective for $R\neq\varnothing$.** The inference was therefore not a free lunch, and declaring
> it "solid because nothing punctured enters" would have been a mistake. It is solid because §§3–8
> above prove it.

> **Remark 10.6 (the paper's assessment of route 1 is confirmed).** The paper declines route 1 and
> says it "*does survive the introduction of punctures, but not for free*", needing the spectator
> psi-lines to cancel and needing $\mathcal O(\Delta_R)|_B\cong\mathcal O_B$. Both halves are
> confirmed at L1: the missing $\bigotimes_{i=1}^m\Psi_i$ is exactly the spectator cancellation
> (Remark 10.5), and the $\Delta_R$ term of (8.11) is likewise silently dropped on p. 58. The second
> half is now a theorem anyway — Prop. 9.1 — but the first half remains unverified here, so route 1
> stays unavailable; the paper is right not to use it.

### 10.5 What the paper may still **not** assert on the strength of this attempt

1. Anything about the value of $\mathfrak n=(\Psi_2^{-1})|_\xi$. [FKP, Example 8.9] is genuinely
   NS-only and is not extended here. Lemma 5.5(c) and Remark 5.7 must stay as they are.
2. Anything obtained through [FKP, (8.11)] with $m>0$ (route 1).
3. Anything from [FKP, §9.3] (the Ramond boundary component), which [FKP] themselves state as a
   conjecture.
4. [FKP, Theorem C] for a punctured target — Remark 5.6 of the paper is correct and should stay.
   Cor. 10.1 supplies the normal-line formula, which is what Theorem C would have supplied, but it
   does not supply Theorem C's splitting statement.

---

## 11. Remaining gaps

These are the honest residual dependencies. None is a hole in the logic of §§3–9 as such; each is a
place where I use a statement of [FKP] whose own proof I did not read at L1, or where a hypothesis
was verified only indirectly. I state them so that a reviewer can price them.

- **[GAP-G1: [FKP] §6.2 unread at L1.]** Lemma 9.1(i) is proved by placing oneself "*in the framework
  of Sec. 6.2*" and using a generator $e$ of $\omega^2_{X/S}$ from (6.13); Lemma 9.1(ii) uses
  Lemma 6.4 and the relations (6.11). I use (i) and (ii) as black boxes (Prop. 6.1) and argue they
  transport to the punctured setting because they are computations in an étale neighbourhood of the
  node. That transport rests on a single L1 sentence, [FKP] §6.4 (I13), to the effect that adding
  punctures does not change the local picture near the nodes. I did **not** read pp. 33–40. *Risk:
  low — §6.2's objects are the local models of a node, and punctures are disjoint from nodes. What
  would close it: read [FKP] pp. 33–40 at L1 and check that no step assumes $R=\varnothing$.*
- **[GAP-G2: proofs of Lemma 8.7 / Cor. 8.8 / Remark 8.10 unread at L1.]** I verified at L1 (p. 56)
  that the §8.4 setup declares both NS punctures $D_i$ and Ramond divisors $R_j$, so the
  *statements* are made in the punctured generality — this is the part of `[GAP-FKP-RAMOND]` that
  turns out not to bite. I did not read their proofs. *Risk: low — all three are computations on
  $D_i$, which is disjoint from $R$.*
- **[GAP-G3: signs.]** Every isomorphism above is canonical only up to the ordering ambiguity in the
  multiplicativity of $\operatorname{Ber}$ (Remark 8.2). [FKP] work under the same proviso. The
  isomorphism class, which is all the supermoduli paper consumes, is unaffected. *Not closable
  without fixing a sign convention for $\operatorname{Ber}$ in short exact sequences, which [FKP] do
  not do either.*
- **[GAP-G4: `[GAP-FKP-RAMOND]` survives at Example 8.9.]** [FKP, Example 8.9] identifies the
  inverse NS psi-line with the spin line over an even base, and is stated for families with NS
  punctures only. Nothing here extends it to $R\neq\varnothing$. This is the one genuinely
  unrepaired Ramond gap in the chain, and the supermoduli paper's Lemma 5.5(c) is built precisely to
  avoid needing it.
- **[GAP-G5: [FKP] Theorem A used as a black box.]** Smoothness and representability of
  $\overline{\mathcal S}_{g;m,n}$ enter twice: in Lemma 3.3 (the hypothesis of Prop. 7.4) and in
  Cor. 3.4 (the extension $\mathcal V\to k_*k^*\mathcal V$ across the codimension-$>1$ multi-node
  locus, L1 p. 45). This is [FKP]'s main theorem and I do not audit it.
- **[GAP-G6: [FKP] Lemmas 7.2(ii), 7.3 used as black boxes.]** They appear inside the proofs of
  Lemma 9.1(iii) and of the Ramond-node case of Prop. 7.4. Both proofs are visibly local at the node
  (L1, pp. 45, 60), hence puncture-blind, but the lemmas' own proofs are unread.
- **[GAP-G7: Theorem 8.3 (non-separating) is thinner than Theorem 8.1.]** Its proof proceeds by
  checking that each ingredient of §§3–7 was written so as to cover (7.9), and by extending
  Lemma 4.1 from a closed branch embedding to the partial normalisation. I believe it, and the
  supermoduli paper does not use it (its $\Gamma$ is (7.8)). A reviewer wanting to rely on
  Theorem 8.3 should re-derive §§6–7 for (7.9) explicitly rather than by inspection.

No `[GAP]` above is load-bearing for Cor. 10.1 in the following sense: G1, G2, G5, G6 are appeals to
[FKP]'s published statements, which the supermoduli paper is entitled to cite anyway; G3 is a
convention; G4 is not used; G7 concerns a case the paper does not use. The genuinely new content of
this attempt — Lemma 3.1, Prop. 3.5, Prop. 4.3, Lemma 5.1 (the twisted (7.1-R)), Prop. 6.2,
Prop. 7.1, Prop. 9.1 — is proved here from those statements without further appeal.
