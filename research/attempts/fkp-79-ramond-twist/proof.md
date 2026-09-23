# Proof — FKP Lemma 7.9 holds with the Ramond twist

**Attempt:** `research/attempts/fkp-79-ramond-twist/`
**Source:** [FKP] = Felder–Kazhdan–Polishchuk, *The Moduli Space of Stable Supercurves and Its
Canonical Line Bundle*, **arXiv:2006.13271v3** = Amer. J. Math. **145** (2023) 1777–1886.
All page references are to the arXiv v3 PDF; its page numbers coincide with the printed ones
(checked against the running head). **Every quotation below was read off a rendered page image at
220 dpi, not from `pdftotext`.**

**Verdict: outcome (a).** The lemma is true with the twist, and the local computation is written out
below in full. Moreover the rewrite removes [FKP]'s only externally-sourced step (their "It is well
known that…", for which they give no reference): §5 proves it.

---

## 1. The verbatim source data

### 1.1 [FKP, Definition 2.4, p. 6] — the twist is in the definition

> • a collection of disjoint closed subschemes called *NS-punctures* and *R-punctures*
> $$P_i\subset X,\ i=1,\dots,n_{NS};\quad R_i\subset X,\ i=1,\dots,n_R,$$
> such that the projection $P_i\to S$ is an isomorphism, and each $R_i$ is a Cartier divisor (flat
> over $S$);
> • a derivation
> $$\delta:\mathcal O_X\to\omega_{X/S}(R),$$
> trivial on pull-backs of functions on $S$, where $R=\sum R_i$. […]
>
> We impose the following additional properties.
> • There is an open fiberwise dense subset $U\subset X$ such that $U/S$ is smooth of dimension
> $1|1$, and $P_i\subset U$, $R_i\subset U$;
> • the derivation $\delta$ corresponds to a structure of a smooth supercurve with Ramond punctures
> on $(U,(R_i))$ over $S$;
> • on every geometric fiber $X_s$, $\delta^-$ induces an isomorphism
> $$\mathcal O^-_{X_s}\ \xrightarrow{\ \sim\ }\ \omega_{X_s}\big(\textstyle\sum R_{is}\big)^-;
> \tag{2.4}$$
>
> […] (ii) A supercurve with punctures $(X/S,P_\bullet,R_\bullet)$ is called *stable* (resp.,
> *prestable*) if $X$ is proper over $S$ and for every geometric fiber $X_s$, passing to the bosonic
> truncation $(X_s)_{\rm bos}$ with the marked points induced by $(P_i)$ and $(R_i)$ one gets a usual
> stable (resp., prestable) pointed curve.

Two things to lift out of this page, because the whole question turns on them.

* **The condition that has to be verified when one glues is (2.4), and (2.4) carries the twist
  $\big(\sum R_{is}\big)$ explicitly.**
* **NS-punctures and R-punctures are required to be *disjoint*.** This is not a convention we are
  importing; it is in the definition, first bullet, first word after "collection of".

### 1.2 [FKP, Lemma 2.6 and the paragraph after its proof, p. 7] — (2.5) is stated *with* the twist

> **Lemma 2.6.** *Assume that $S$ is even. Then the data of a supercurve $(X,P_\bullet,R_\bullet)$
> over $S$ is equivalent to the following data:*
> * *a flat family of pointed curves $(C,p_\bullet,r_\bullet)$ over $S$ with reduced geometric
>   fibers, smooth near the marked points;*
> * *a coherent sheaf $L$ on $C$, flat and relatively Cohen-Macaulay over $S$, locally free of rank
>   $1$ over a fiberwise dense open in $C$;*
> * *an isomorphism*
> $$L\ \xrightarrow{\ \sim\ }\ \underline{\mathrm{Hom}}\big(L,\omega_C(\textstyle\sum r_i)\big).
> \tag{2.5}$$
> *Under this correspondence one has $|C|=|X|$,*
> $$\mathcal O^+_X=\mathcal O_C,\ \ \mathcal O^-_X=L,\ \ \omega^+_X=\omega_C,\ \
> \omega^-_X=\underline{\mathrm{Hom}}(L,\omega_C)\simeq L(-\textstyle\sum r_i),$$
> *where $\mathcal O^-_X\cdot\mathcal O^-_X=0$, $\mathcal O^-_X\cdot\omega^+_X=0$, and the action map
> $\mathcal O^-_X\otimes\omega^-_X\to\omega^+_X$ is identified with the natural evaluation map. The
> puncture $P_i$ is the image of the composition $S\xrightarrow{p_i}C\to X$; and $R_i$ is the
> schematic preimage of $r_i$ under the projection $X\to C$. The isomorphism (2.5) corresponds to
> $\delta^-$.*

and, four lines below the end of the proof:

> A coherent sheaf $L$ on a prestable curve $C/S$ equipped with an isomorphism (2.5) is called a
> *generalized spin structure*.

**Finding (contradicting one form of a rumour that reached this attempt):** (2.5) is **not** an
$r=0$ statement. [FKP] state it in full generality, twist included. What is true is the weaker and
more specific thing: the printed proof of Lemma 7.9 quotes **the $r=0$ instance** of (2.5). See
§1.4.

Note also the bookkeeping: $\omega^-_X=\underline{\mathrm{Hom}}(L,\omega_C)$ is *untwisted*, so
$$\delta^-:\ \mathcal O^-_X=L\ \longrightarrow\ \omega^-_X(R)
=\underline{\mathrm{Hom}}(L,\omega_C)\otimes\mathcal O_C(\textstyle\sum r_i)
=\underline{\mathrm{Hom}}\big(L,\omega_C(\textstyle\sum r_i)\big),$$
which is exactly (2.5). The twist sits on the **target**.

### 1.3 [FKP, §7.5, p. 47] — the gluing construction and the statement of Lemma 7.9

> Assume that $X$, $X'$ and $Y$ are superschemes, $i:Y\to X$ and $i:Y\to X'$ are closed embeddings.
> We want to define a new superscheme $Z$ by gluing $X$ and $X'$ along $Y$. As a topological space we
> can define $Z$ to the usual gluing of the topological spaces of $X$ and $X'$ along $Y$, so that we
> have closed embeddings $j:X\to Z$, $j':X'\to Z$, so that $k:=j_1\circ i=j_2\circ i$. Hence, we have
> two homomorphisms of sheaves of rings
> $$\phi:j_*\mathcal O_X\to k_*\mathcal O_Y,\quad\phi':j'_*\mathcal O_{X'}\to k_*\mathcal O_Y,$$
> and we define $\mathcal O_X$ [sic — $\mathcal O_Z$] to be the subsheaf of
> $j_*\mathcal O_X\oplus j'_*\mathcal O_{X'}$, namely the preimage of the diagonal
> $k_*\mathcal O_Y\subset k_*\mathcal O_Y\oplus k_*\mathcal O_Y$ under $\phi\oplus\phi'$.
>
> We can apply this to gluing two stable supercurves along NS-punctures.
>
> Suppose $X/S$ and $X'/S$ is a pair of stable supercurves with NS-punctures $P\subset X$ and
> $P'\subset X'$. We have an isomorphism $P\simeq S\simeq P'$, so we can define a new superscheme
> $Z/S$ by gluing $X$ and $X'$ along $P\simeq P'$.
>
> **Lemma 7.9.** *The glued superscheme $Z/S$ has a natural stable supercurve structure such that the
> derivation $\delta$ on $Z$ is defined as the composition*
> $$\mathcal O_Z\to j_*\mathcal O_X\oplus j'_*\mathcal O_{X'}
> \xrightarrow{(j_*\delta,\,j'_*\delta')}j_*\omega_{X/S}\oplus j'_*\omega_{X'/S}\to\omega_{Z/S}.$$

**Observation not recorded in our §10.1:** the twist is missing already in the **statement** of
Lemma 7.9, not only in its proof — the displayed composition ends in $\omega_{Z/S}$, whereas
Definition 2.4 requires $\delta_Z:\mathcal O_Z\to\omega_{Z/S}(R^Z)$. So the printed Lemma 7.9 is, read
literally, a statement about the case $R=R'=\varnothing$ throughout.

### 1.4 [FKP, proof of Lemma 7.9, p. 48] — verbatim

> *Proof.* If $U\subset X$, $U'\subset X'$ are smooth loci, then $(U\smallsetminus P)\sqcup
> (U'\smallsetminus P')$ is an open subset of $Z$, which is a smooth supercurve over $S$. Next, we
> need to check that in the case when $S$ is a point, $\delta^-$ induces an isomorphism of
> $\mathcal O^-_Z$ with $\omega^-_Z$. Since the base is even, we have identifications
> $$\mathcal O_X=\mathcal O_C\oplus L,\quad\mathcal O_{X'}=\mathcal O_{C'}\oplus L',$$
> and the smooth marked points $P\subset C$, $P'\subset C'$, so that the embedding of $P$ into $X$
> corresponds to the projection
> $$\mathcal O_X\to\mathcal O_C\to\mathcal O_P.$$
> Note that $L$ and $L'$ are generalized spin-structures, i.e., we have an isomorphism
> $L\xrightarrow{\ \sim\ }\underline{\mathrm{Hom}}(L,\omega_C)$ (which corresponds to $\delta^-$ on
> $X$), and similarly, for $L'$. Furthermore, we know that $L$ (resp., $L'$) is locally free near $P$
> (resp., $P'$).
>
> The glued superscheme $Z$ has the underlying nodal curve $Z_0$, which is glued from $C$ and $C'$
> along $P\simeq P'$, and
> $$\mathcal O_Z\simeq\mathcal O_{Z_0}\oplus j_*L\oplus j'_*L'.$$
> It is well known that the natural map
> $$j_*L\oplus j'_*L'\to\underline{\mathrm{Hom}}(j_*L\oplus j'_*L',\omega_{Z_0})$$
> is an isomorphism, i.e., $j_*L\oplus j'_*L'$ is a generalized spin-structure. It is easy to see that
> above map is precisely $\delta^-$, so this proves that $Z/S$ is a stable supercurve. $\square$

**The three places the twist is dropped, itemised.**

| # | printed | required by Def. 2.4 for $R\ne\varnothing$ |
|---|---|---|
| (i) | "$\delta^-$ induces an isomorphism of $\mathcal O_Z^-$ with $\omega_Z^-$" | $\mathcal O^-_Z\xrightarrow{\sim}\omega_Z(R^Z)^-$, i.e. (2.4) |
| (ii) | "$L\xrightarrow{\sim}\underline{\mathrm{Hom}}(L,\omega_C)$", quoted as "$L$ is a generalized spin structure" | $L\xrightarrow{\sim}\underline{\mathrm{Hom}}(L,\omega_C(R))$, i.e. (2.5) with its twist |
| (iii) | "$j_*L\oplus j'_*L'\to\underline{\mathrm{Hom}}(j_*L\oplus j'_*L',\omega_{Z_0})$ is an isomorphism" | target $\underline{\mathrm{Hom}}(j_*L\oplus j'_*L',\ \omega_{Z_0}(R^{Z_0}))$ |

So (ii) is literally "the $r=0$ instance of (2.5)", and it is asserted as if it were the definition of
generalized spin structure — which it is only when $r=0$. This is the precise, and correct, form of
the observation. The scope of the defect is item (ii), and it propagates to (i) and (iii).

**Forensic note: where the wrong formula was copied from.** [FKP, Remark 2.3, p. 5] contains, for a
smooth supercurve over an even base and with **no mention of $R$**, verbatim:

> so the odd part of the derivation $\delta$ induces an isomorphism $L\xrightarrow{\ \sim\ }
> \underline{\mathrm{Hom}}(L,\omega_C)$, or equivalently $L^2\xrightarrow{\ \sim\ }\omega_C$.

That is character-for-character the formula the proof of Lemma 7.9 calls "generalized spin
structure". So the proof is echoing **Remark 2.3** (the unpunctured §2.2 discussion) where it should
be echoing **(2.5)** (the punctured Lemma 2.6, two pages later). This is a copying slip between two
formulas in the same paper, not a conceptual error, and it is one more reason to expect — as turns
out to be the case — that the statement survives once the right formula is substituted.

### 1.5 Standard facts imported

* **[S1] (Rosenlicht / Serre).** A nodal curve $Z_0$ over an algebraically closed field is Gorenstein;
  its dualizing sheaf $\omega_{Z_0}$ is invertible; if $\nu:\widetilde Z\to Z_0$ is the partial
  normalization at one node $z$, with preimages $P\in C$, $P'\in C'$, then $\omega_{Z_0}$ is
  identified with the sheaf of rational $1$-forms on $\widetilde Z$ regular away from $\{P,P'\}$,
  with at worst simple poles at $P,P'$ and $\mathrm{Res}_P+\mathrm{Res}_{P'}=0$. In particular near
  $z$ it is free of rank one on the generator $\eta$ with $\eta|_C=du/u$, $\eta|_{C'}=-dv/v$, and the
  canonical injection $\nu_*\omega_{\widetilde Z}\hookrightarrow\omega_{Z_0}$ is $f\,du\mapsto fu\,\eta$
  on the $C$ side and $g\,dv\mapsto -gv\,\eta$ on the $C'$ side.
  *(Serre, GACC, Ch. IV; Arbarello–Cornalba–Griffiths, GAC II, Ch. X §2; Hartshorne III.7.)*
  Used **only** in §5. It is what [FKP]'s "it is well known" is standing in for; it is not the thing
  at issue and it is insensitive to $R$.
* **[S2]** Sheaf-Hom adjunction for a finite morphism (proved inline, §4, Lemma 4.2).
* **[S3]** Classical stability of a nodal union: if $(C,P,p_\bullet,r_\bullet)$ and
  $(C',P',p'_\bullet,r'_\bullet)$ are stable pointed curves then so is
  $(C\cup_{P=P'}C',\ p_\bullet\sqcup p'_\bullet,\ r_\bullet\sqcup r'_\bullet)$. Insensitive to which
  markings are called NS and which Ramond, since Definition 2.4(ii) feeds *all* of them to the
  classical notion.

---

## 2. Setup and standing notation

Throughout, $S$ is a **purely even** scheme; this is legitimate for what has to be checked, because
condition (2.4) is stated fibrewise over geometric points, and geometric points are even. (Where the
argument needs $S$ arbitrary — namely the construction of $\delta_Z$ itself, §6 — nothing depends on
$R$ and the printed argument applies unchanged.)

Data:

* $(X/S;\ P,P_1,\dots,P_{m_1};\ R_1,\dots,R_{n_1})$ and
  $(X'/S;\ P',P'_1,\dots,P'_{m_2};\ R'_1,\dots,R'_{n_2})$, stable supercurves with punctures
  (Definition 2.4), $m_i,n_i\ge0$ **arbitrary**.
* Bosonic pictures (Lemma 2.6): $X\leftrightarrow(C,L)$, $X'\leftrightarrow(C',L')$, with
  $r=\sum r_i\subset C$, $r'=\sum r'_j\subset C'$ the Ramond divisors on the bosonic curves, and
  $$\Phi_X:\ L\xrightarrow{\ \sim\ }\underline{\mathrm{Hom}}(L,\omega_C(r)),\qquad
  \Phi_{X'}:\ L'\xrightarrow{\ \sim\ }\underline{\mathrm{Hom}}(L',\omega_{C'}(r')).\tag{2.5$_X$, 2.5$_{X'}$}$$
  Equivalently: perfect pairings $\langle\ ,\ \rangle_C:L\otimes L\to\omega_C(r)$ and
  $\langle\ ,\ \rangle_{C'}$.
* $Z$ = the glued superscheme, $Z_0=C\cup_{P=P'}C'$ its bosonic truncation, $z\in Z_0$ the node,
  $j:C\to Z_0$, $j':C'\to Z_0$ the two branch embeddings (same letters for $X\to Z$, $X'\to Z$).
* $D:=j(r)+j'(r')$, an effective divisor on $Z_0$; $R^Z\subset Z$ the corresponding divisor upstairs.
* $\mathcal F:=j_*L\oplus j'_*L'$, a coherent sheaf on $Z_0$.

**Standing consequences of Definition 2.4 used below (and *only* these).**

* **(H1)** $P$ and every $R_i$ are *disjoint* closed subschemes of $X$; likewise on $X'$.
  Hence $P\notin\mathrm{Supp}(r)$ and $P'\notin\mathrm{Supp}(r')$, so
  $$z\notin\mathrm{Supp}(D).$$
* **(H2)** $P\subset U$ and $R_i\subset U$, $U$ the smooth locus. Hence $C$ is smooth at $P$ and at
  every $r_i$, and $L$ is **locally free of rank $1$** on a neighbourhood of $P$ (this is [FKP]'s own
  "we know that $L$ is locally free near $P$"). Likewise on $X'$.
* **(H3)** $r_i$ are Cartier divisors in the smooth locus, so $\mathcal O_{Z_0}(D)$ is an **invertible**
  sheaf on $Z_0$, with $j^*\mathcal O_{Z_0}(D)=\mathcal O_C(r)$ and $j'^*\mathcal O_{Z_0}(D)=\mathcal O_{C'}(r')$.
  *(For $j^*$: $j(C)$ meets $\mathrm{Supp}(D)$ exactly in $r$, because $j'(r')$ lies in
  $C'\smallsetminus P'$, which is disjoint from $j(C)$.)*

---

## 3. What has to be proved

By Definition 2.4, giving $Z/S$ the structure of a stable supercurve with punctures
$(P^Z_\bullet,R^Z_\bullet)$ means producing a derivation
$\delta_Z:\mathcal O_Z\to\omega_{Z/S}(R^Z)$ with the three listed properties. Of these:

* the smooth-locus property and the "smooth supercurve with Ramond punctures on $(U_Z,(R^Z_i))$"
  property are §6 (easy, but **(H1)** is used);
* stability is §7 ([S3]);
* the substantive one is

$$\boxed{\ \textbf{(2.4) for } Z:\qquad \delta_Z^-:\ \mathcal O^-_Z\ \xrightarrow{\ \sim\ }\
\omega_{Z_0}(D)\text{-valued dual of }\mathcal O^-_Z\ }$$

which, once we identify $\mathcal O^-_Z=\mathcal F$ (§4.1) and
$\omega_{Z}(R^Z)^-=\underline{\mathrm{Hom}}(\mathcal F,\omega_{Z_0}(D))$ (§4.3), reads:

> **Main Proposition.** *The natural map*
> $$\Phi_Z:\ \mathcal F\ \longrightarrow\ \underline{\mathrm{Hom}}_{\mathcal O_{Z_0}}\big(\mathcal F,\
> \omega_{Z_0}(D)\big)$$
> *induced by the block-diagonal pairing $\langle\ ,\ \rangle_C\oplus\langle\ ,\ \rangle_{C'}$ is an
> isomorphism.*

§4 sets up the identifications, §5 proves the Main Proposition.

---

## 4. The identifications

### 4.1 The glued structure sheaf and its odd part

**Lemma 4.1.** *Over an even base $S$,*
$$\mathcal O_Z\ \simeq\ \mathcal O_{Z_0}\ \oplus\ j_*L\ \oplus\ j'_*L' ,\qquad
\mathcal O^+_Z=\mathcal O_{Z_0},\quad \mathcal O^-_Z=\mathcal F,\quad
\mathcal O^-_Z\cdot\mathcal O^-_Z=0 .$$

*Proof.* By §1.3, $\mathcal O_Z=\ker\big(j_*\mathcal O_X\oplus j'_*\mathcal O_{X'}
\xrightarrow{\phi-\phi'}k_*\mathcal O_Y\big)$ with $Y\simeq S$. Split into parities. Since $S$ is
even, $\mathcal O_Y=\mathcal O_S$ has zero odd part, so the gluing condition is vacuous on odd parts
and
$$\mathcal O^-_Z=j_*\mathcal O^-_X\oplus j'_*\mathcal O^-_{X'}=j_*L\oplus j'_*L'=\mathcal F,$$
while on even parts it is the usual condition "values agree at $P\simeq P'$", giving
$\mathcal O^+_Z=\mathcal O_{Z_0}$. The product of two odd sections is computed componentwise inside
$j_*\mathcal O_X\oplus j'_*\mathcal O_{X'}$; within one component it vanishes because
$\mathcal O^-_X\cdot\mathcal O^-_X=0$ (Lemma 2.6), and across components it vanishes because
$(s,0)\cdot(0,s')=(0,0)$. $\square$

This is [FKP]'s own displayed identification, with the reason for it spelled out. **It contains no
$\omega$ and is completely insensitive to $R$.**

### 4.2 Sheaf-Hom adjunction for a finite morphism

**Lemma 4.2.** *Let $f:T\to W$ be an affine morphism of schemes, $\mathcal G$ an $\mathcal O_T$-module,
$M$ an $\mathcal O_W$-module. Put $f^\flat M:=\underline{\mathrm{Hom}}_{\mathcal O_W}(f_*\mathcal O_T,M)$,
an $\mathcal O_T$-module. Then*
$$\underline{\mathrm{Hom}}_{\mathcal O_W}(f_*\mathcal G,\ M)\ \cong\
f_*\,\underline{\mathrm{Hom}}_{\mathcal O_T}\big(\mathcal G,\ f^\flat M\big),$$
*naturally in $\mathcal G$ and $M$.*

*Proof.* Send $\psi:f_*\mathcal G\to M$ to $\widetilde\psi$, $\widetilde\psi(g)(a):=\psi(ag)$ for a
local section $a$ of $f_*\mathcal O_T$. This is $\mathcal O_T$-linear, and
$\psi\mapsto\widetilde\psi$ is inverted by $\widetilde\psi\mapsto\big(g\mapsto\widetilde\psi(g)(1)\big)$.
$\square$

### 4.3 The odd part of the dualizing sheaf of $Z$

**Lemma 4.3.** *Let $\pi_Z:Z\to Z_0$ be the canonical finite projection ($\pi_{Z*}\mathcal O_Z=
\mathcal O_{Z_0}\oplus\mathcal F$, Lemma 4.1). Then*
$$\omega_Z\ =\ \pi_Z^!\,\omega_{Z_0}\ =\ \underline{\mathrm{Hom}}_{\mathcal O_{Z_0}}\big(\mathcal O_{Z_0}
\oplus\mathcal F,\ \omega_{Z_0}\big),\qquad\text{hence}\qquad
\omega_Z^-\ =\ \underline{\mathrm{Hom}}_{\mathcal O_{Z_0}}(\mathcal F,\ \omega_{Z_0}),$$
*and consequently, $\mathcal O_Z(R^Z)$ being the pull-back of the invertible sheaf
$\mathcal O_{Z_0}(D)$ (H3),*
$$\big(\omega_Z(R^Z)\big)^-\ =\ \underline{\mathrm{Hom}}_{\mathcal O_{Z_0}}\big(\mathcal F,\
\omega_{Z_0}(D)\big).$$

*Proof.* The first equality is the identification [FKP] use in the proof of Lemma 2.6, verbatim
*"We have a natural identification of $\mathcal O_X$-modules, compatible with the
$\mathbb Z_2$-grading $\omega_X=\pi^!\omega_C=\underline{\mathrm{Hom}}(\mathcal O_X,\omega_C)$"* (p. 7);
their derivation uses only that $\pi$ is finite with $\pi_*\mathcal O_X=\mathcal O_C\oplus L$ and
$L\cdot L=0$, which holds here by Lemma 4.1. Splitting by parity, and using that $\omega_{Z_0}$ is
purely even, the odd part of $\underline{\mathrm{Hom}}(\mathcal O_{Z_0}\oplus\mathcal F,\omega_{Z_0})$
is the parity-reversing part, i.e. $\underline{\mathrm{Hom}}(\mathcal F,\omega_{Z_0})$ (and the even
part is $\omega_{Z_0}$, matching $\omega^+_Z=\omega_{Z_0}$). For the last display, twisting by an
invertible sheaf passes through $\underline{\mathrm{Hom}}$ in the second slot:
$\underline{\mathrm{Hom}}(\mathcal F,\omega_{Z_0})\otimes\mathcal O_{Z_0}(D)\cong
\underline{\mathrm{Hom}}(\mathcal F,\omega_{Z_0}(D))$. $\square$

> **This is the only step where one could have worried that the twist interacts with the
> supergeometry, and it does not:** $\mathcal O_Z(R^Z)$ is an *even* invertible sheaf pulled back
> from $Z_0$ (the $R_i$ are cut out by even equations, being schematic preimages of the $r_i$,
> Lemma 2.6), so it commutes with the parity splitting.

### 4.4 The map $\Phi_Z$ is the block-diagonal one, and it is $\delta^-_Z$

By §1.3 the derivation on $Z$ is the restriction to $\mathcal O_Z\subset j_*\mathcal O_X\oplus
j'_*\mathcal O_{X'}$ of $(j_*\delta,j'_*\delta')$, followed by the branch-inclusion map into
$\omega_{Z/S}$ — in the twisted form, into $\omega_{Z/S}(R^Z)$ (the branch-inclusion map exists in
the twisted form by (H3) and the projection formula; see §6.1). On **odd** parts, Lemma 4.1 says
$\mathcal O^-_Z$ is the *whole* of $j_*L\oplus j'_*L'$, so no restriction happens and

$$\delta^-_Z\ =\ \iota\circ\big(j_*\delta_X^-\ \oplus\ j'_*\delta_{X'}^-\big)
\ =\ \iota\circ\big(j_*\Phi_X\oplus j'_*\Phi_{X'}\big),$$

where $\iota$ is the branch inclusion. In particular **$\delta^-_Z$ is block diagonal**: the pairing
$\mathcal F\otimes\mathcal F\to\omega_{Z_0}(D)$ that induces it has zero cross terms, by construction,
not by an accident that would need checking. This justifies calling $\Phi_Z$ "the natural map" and
identifies it with $\delta^-_Z$, which is the content of [FKP]'s "It is easy to see that above map is
precisely $\delta^-$".

---

## 5. Proof of the Main Proposition

We must show $\Phi_Z:\mathcal F\to\underline{\mathrm{Hom}}(\mathcal F,\omega_{Z_0}(D))$ is an
isomorphism. Being an isomorphism of coherent sheaves is local on $Z_0$, so it suffices to check it
on the members of an open cover. By **(H1)** we may choose an open $V\ni z$ with
$V\cap\mathrm{Supp}(D)=\varnothing$, and then

$$Z_0\ =\ V\ \cup\ \big(Z_0\smallsetminus\{z\}\big)$$

is an open cover. We treat the two pieces separately. **The twist is invisible on the second piece
and is exactly the hypothesis on the first; that is the whole mechanism.**

### 5.1 Away from the node: the twist is present, and is exactly hypothesis (2.5)

On $Z_0\smallsetminus\{z\}=(C\smallsetminus P)\sqcup(C'\smallsetminus P')$ all the objects restrict
to the corresponding objects on the branches:

$$\mathcal F|_{C\smallsetminus P}=L|_{C\smallsetminus P},\qquad
\omega_{Z_0}|_{C\smallsetminus P}=\omega_C|_{C\smallsetminus P},\qquad
\mathcal O_{Z_0}(D)|_{C\smallsetminus P}=\mathcal O_C(r)|_{C\smallsetminus P},$$

(the middle one because $Z_0$ and $C\sqcup C'$ agree as schemes away from $z$, and the dualizing
sheaf is Zariski-local), and the other branch contributes nothing there. Hence

$$\Phi_Z|_{C\smallsetminus P}\ =\ \Phi_X|_{C\smallsetminus P}:\
L\longrightarrow\underline{\mathrm{Hom}}(L,\omega_C(r))\Big|_{C\smallsetminus P},$$

an isomorphism by (2.5$_X$). Symmetrically on $C'\smallsetminus P'$. $\checkmark$

> Note what this does and does not use: it uses the hypothesis on $X$ **with** its twist. If one had
> only the $r=0$ form of (2.5), as the printed proof quotes, this step would be **false** on the
> Ramond divisor. So the defect identified in §1.4(ii) is real, and this is where it would bite.

### 5.2 Near the node: the twist is canonically trivial

On $V$ the tautological section $1_D$ of $\mathcal O_{Z_0}(D)$ is nowhere vanishing (its zero scheme
is $D$, disjoint from $V$), so it trivializes:
$\mathcal O_{Z_0}(D)|_V\xrightarrow{\ \sim\ }\mathcal O_V$. Under this trivialization the twisted
pairing $\langle\ ,\ \rangle_C$ on $V\cap C$ becomes an ordinary $\omega_C$-valued pairing
$\beta:L\otimes L\to\omega_C$ on $V\cap C$, and

$$\Phi_Z|_V\ =\ \Phi^{(0)}_Z|_V,$$

the *untwisted* natural map, with the untwisted branch pairings $\beta$, $\beta'$ — which are perfect
on $V\cap C$, $V\cap C'$, again because $1_D$ is invertible there. So on $V$ we must prove exactly
[FKP]'s "well known" statement. We prove it, rather than cite it.

Shrink $V$ so that $V\cap C$ is contained in the smooth locus of $C$ and $L|_{V\cap C}$ is free of
rank one (possible by **(H2)**), likewise for $C'$. Since a map of coherent sheaves is an isomorphism
iff it is so after completing at every point, and iff it is so on the complement of $z$ (done in
§5.1), it suffices to check the induced map on $\widehat{\mathcal O}_{Z_0,z}$-modules.

**The local model.** Let $u$ be a local coordinate on $C$ at $P$ and $v$ one on $C'$ at $P'$. Then
$$A:=\widehat{\mathcal O}_{Z_0,z}\ \cong\ k[[u,v]]/(uv)\ =\ k[[u]]\times_k k[[v]],$$
the fibre product over the two evaluations at $0$. Write $A_1:=A/(v)=k[[u]]$ (the $C$ branch),
$A_2:=A/(u)=k[[v]]$.

*Annihilators.* For $a=(a_1(u),a_2(v))\in A$ we have $v\cdot a=(0,v\,a_2(v))$, so
$$\mathrm{Ann}_A(v)=\{(a_1,0):a_1(0)=0\}=(u),\qquad\text{and symmetrically}\qquad
\mathrm{Ann}_A(u)=(v).\tag{5.1}$$
As an $A_1$-module, $(u)=u\,k[[u]]$ is free of rank one on the generator $u$.

*The dualizing module.* By **[S1]**, $\widehat\omega_{Z_0,z}=A\cdot\eta$ is free of rank one, and the
branch inclusions are
$$\iota_C:\ A_1\,du\longrightarrow A\eta,\quad f\,du\mapsto f\,u\,\eta;\qquad
\iota_{C'}:\ A_2\,dv\longrightarrow A\eta,\quad g\,dv\mapsto -g\,v\,\eta. \tag{5.2}$$

*The sheaf.* $\widehat{\mathcal F}_z=A_1e\oplus A_2e'$, with $e$ a generator of $L$ near $P$ and
$e'$ one of $L'$ near $P'$ (**H2**). Write
$$\beta(e,e)=\alpha\,du\ \ (\alpha\in k[[u]]),\qquad \beta'(e',e')=\alpha'\,dv\ \ (\alpha'\in k[[v]]).$$
Perfectness of $\beta$ at $P$ — i.e. $L\to\underline{\mathrm{Hom}}(L,\omega_C)$ being an isomorphism
of free rank-one modules there — says precisely that
$$\alpha\in k[[u]]^\times,\qquad \alpha'\in k[[v]]^\times. \tag{5.3}$$

*The dual module.* $\underline{\mathrm{Hom}}_A(\widehat{\mathcal F}_z,A\eta)=
\mathrm{Hom}_A(A_1,A\eta)\oplus\mathrm{Hom}_A(A_2,A\eta)$, and by evaluation at $1$ together with
(5.1),
$$\mathrm{Hom}_A(A_1,A\eta)\ \xrightarrow[\ \sim\ ]{\ \mathrm{ev}_1\ }\ \mathrm{Ann}_A(v)\,\eta=(u)\eta,
\qquad
\mathrm{Hom}_A(A_2,A\eta)\ \xrightarrow[\ \sim\ ]{\ \mathrm{ev}_1\ }\ (v)\eta. \tag{5.4}$$

*The map.* By §4.4, $\Phi^{(0)}_Z(e)$ kills $e'$ and sends $e\mapsto\iota_C(\beta(e,e))
\overset{(5.2)}{=}\alpha u\,\eta$. So under (5.4),
$$\Phi^{(0)}_Z\big|_{A_1e}:\ A_1\longrightarrow (u)\eta,\qquad 1\longmapsto \alpha\,u\,\eta,$$
which is an isomorphism of free rank-one $A_1$-modules precisely because $\alpha$ is a unit (5.3).
Symmetrically $\Phi^{(0)}_Z|_{A_2e'}:A_2\to(v)\eta$, $1\mapsto-\alpha' v\,\eta$, an isomorphism.
Since $\Phi^{(0)}_Z$ is block diagonal (§4.4), it is an isomorphism. $\checkmark$

### 5.3 Conclusion

$\Phi_Z$ is an isomorphism on $V$ and on $Z_0\smallsetminus\{z\}$, hence on $Z_0$. This proves the
Main Proposition, i.e. condition **(2.4)** for $Z$ with its Ramond divisor $R^Z$. $\blacksquare$

> **Remark 5.4 (a by-product).** §5.2 also proves the untwisted claim that [FKP] introduce with "It is
> well known that …" and for which they give no reference (a point already flagged in this project's
> extraction of the lemma). The proof is (5.1)–(5.4) plus [S1]; no Ramond input at all.

> **Remark 5.5 (the glued node is an NS node).** From $\widehat{\mathcal F}_z=A_1\oplus A_2$: the odd
> structure sheaf is *not* locally free at $z$, which is the local model of an NS node. This is
> consistent with (7.8) factoring through $\Delta_{NS}$ ([FKP, Lemma 7.10]) and confirms that the
> gluing performed here never produces a Ramond node, whatever $n_1,n_2$ are.

---

## 6. The remaining conditions of Definition 2.4

### 6.1 $\delta_Z$ exists as a map into $\omega_{Z/S}(R^Z)$, and is a derivation

The untwisted branch inclusion $\iota^{(0)}:j_*\omega_{X/S}\oplus j'_*\omega_{X'/S}\to\omega_{Z/S}$ is
[FKP]'s. Twist it: by (H3), $\mathcal O_Z(R^Z)$ is invertible with
$j^*\mathcal O_Z(R^Z)=\mathcal O_X(R)$ and $j'^*\mathcal O_Z(R^Z)=\mathcal O_{X'}(R')$, so the
projection formula for the finite morphisms $j$, $j'$ gives
$$j_*\big(\omega_{X/S}(R)\big)\ \cong\ j_*\omega_{X/S}\otimes\mathcal O_Z(R^Z),$$
and $\iota:=\iota^{(0)}\otimes\mathrm{id}_{\mathcal O_Z(R^Z)}$ is the required arrow
$$j_*\big(\omega_{X/S}(R)\big)\oplus j'_*\big(\omega_{X'/S}(R')\big)\longrightarrow\omega_{Z/S}(R^Z).$$
Then $\delta_Z:=\iota\circ(j_*\delta,j'_*\delta')|_{\mathcal O_Z}$. It is a derivation because
$\mathcal O_Z\subset j_*\mathcal O_X\oplus j'_*\mathcal O_{X'}$ is a subsheaf of rings, $(j_*\delta,
j'_*\delta')$ is componentwise a derivation, and $\iota$ is $\mathcal O_Z$-linear (for the
$\mathcal O_Z$-module structure obtained by restricting scalars); triviality on pull-backs from $S$
is inherited componentwise. **No $R$-dependence beyond the projection-formula bookkeeping.**

### 6.2 Smooth locus and the punctures

[FKP]'s first sentence: $U_Z:=(U\smallsetminus P)\sqcup(U'\smallsetminus P')$ is an open subset of
$Z$, smooth of dimension $1|1$ over $S$, and it is fibrewise dense. All surviving punctures lie in
it:

* NS: $P_i\subset U$ and $P_i\cap P=\varnothing$ (**H1**, disjointness of the NS punctures among
  themselves), so $P_i\subset U\smallsetminus P$;
* **Ramond: $R_i\subset U$ and $R_i\cap P=\varnothing$ (H1 again), so $R_i\subset U\smallsetminus P$.**

Consequently $(U_Z,(R^Z_i))$ is an open sub-supercurve of $(U,(R_i))\sqcup(U',(R'_i))$, hence a smooth
supercurve with Ramond punctures over $S$, with $\delta_Z|_{U_Z}=\delta_X|\sqcup\delta_{X'}|$. This is
the second of the two places where disjointness of $R$ from the glued puncture $P$ is used (the first
being the choice of $V$ in §5).

Each $R^Z_i$ is a Cartier divisor in $Z$ flat over $S$, because $Z\to Z_0$ and $X\to C$ agree on a
neighbourhood of $R_i$ ($Z\smallsetminus\{\text{node}\}\cong(X\smallsetminus P)\sqcup
(X'\smallsetminus P')$ as superschemes), and $R_i$ was such in $X$. The punctures of $Z$ are pairwise
disjoint since those of $X$ and $X'$ were and the two branches meet only at the node, which carries
no puncture.

### 6.3 Cohen–Macaulay / structural conditions

By [FKP, Lemma 2.5(iii), p. 6], $Z$ is Cohen–Macaulay with a dense smooth $1|1$ open iff $Z_0$ is a
reduced curve, $\mathcal O_Z^-$ is Cohen–Macaulay with full support on $Z_0$, locally free of rank $1$
on a dense open, and $\mathcal O^-_Z\cdot\mathcal O^-_Z=0$. All four hold: $Z_0$ is a nodal union of
reduced curves; $j_*L$ is CM of dimension $1$ over $\mathcal O_{Z_0}$ (at $z$ it is $A_1$, of depth
$1$) and $j_*L\oplus j'_*L'$ then has full support and is CM; local freeness of rank $1$ holds on
$(C\smallsetminus P)\sqcup(C'\smallsetminus P')$ intersected with the loci where $L$, $L'$ are locally
free, a dense open; and the product vanishes by Lemma 4.1. **Nothing here involves $\omega$ or $R$.**

### 6.4 Stability

$Z\to S$ is proper (glued from two proper $S$-schemes along a closed subscheme). By
Definition 2.4(ii) stability is the classical stability of
$\big((Z_0)_s;\ p_\bullet\sqcup p'_\bullet,\ r_\bullet\sqcup r'_\bullet\big)$, which holds by **[S3]**
since $(C_s;P,p_\bullet,r_\bullet)$ and $(C'_s;P',p'_\bullet,r'_\bullet)$ are stable. Note that
Definition 2.4(ii) feeds **all** markings, NS and Ramond alike, to the classical notion, so the
Ramond punctures help stability rather than hinder it.

---

## 7. Theorem

> **Theorem 7.1 (= Lemma 7.9 of [FKP], with the Ramond twist restored).** *With the hypotheses and
> notation of §2 — in particular for arbitrary numbers $m_1,m_2\ge0$ of spectator NS punctures and
> arbitrary numbers $n_1,n_2\ge0$ of Ramond punctures on the two factors — the glued superscheme
> $Z/S$, equipped with the punctures $P^Z_\bullet$, $R^Z_\bullet$ and with the derivation*
> $$\delta_Z:\ \mathcal O_Z\to j_*\mathcal O_X\oplus j'_*\mathcal O_{X'}
> \xrightarrow{(j_*\delta,\,j'_*\delta')}
> j_*\big(\omega_{X/S}(R)\big)\oplus j'_*\big(\omega_{X'/S}(R')\big)\xrightarrow{\ \iota\ }
> \omega_{Z/S}(R^Z),$$
> *is a stable supercurve with punctures in the sense of [FKP, Definition 2.4]. Consequently the
> gluing morphism*
> $$\overline{\mathcal S}_{g_1;m_1+1,n_1}\times\overline{\mathcal S}_{g_2;m_2+1,n_2}
> \longrightarrow\overline{\mathcal S}_{g_1+g_2;\,m_1+m_2,\,n_1+n_2}\qquad\textbf{(7.8)}$$
> *is well defined for all $m_i\ge0$, $n_i\ge0$, and the same holds for the non-separating variant*
> $\overline{\mathcal S}_{g;m+2,n}\to\overline{\mathcal S}_{g+1;m,n}$ **(7.9)** *(same proof, with
> $C=C'$ and $z$ a non-separating node; §5 is unchanged, and §6.4 uses the corresponding classical
> statement).*

*Proof.* §4 (identifications), §5 (condition (2.4)), §6 (the rest). $\blacksquare$

---

## 8. Where exactly the twist lives — and a correction to our §10.1's stated reason

The twist enters the proof in **three** places, and it is worth separating them because the
paper's §10.1 currently gives a reason that is close to right but not the right one.

§10.1 currently says, verbatim:

> "the gluing is a local operation in a neighbourhood of the NS node, which may be taken disjoint
> from the Ramond divisor, and **replacing $\omega_C$ by $\omega_C(R)$ is a verbatim substitution
> there**."

That sentence is self-defeating as written: on a neighbourhood disjoint from the Ramond divisor there
is nothing to substitute, and the place where the substitution is *not* verbatim — namely on the
Ramond divisor itself — is precisely the place the sentence excludes. The correct statement is the
complementary decomposition:

1. **On $Z_0\smallsetminus\{z\}$** (which *does* meet the Ramond divisor): the twisted statement is
   not a substitution at all; it is **verbatim the hypothesis (2.5) on the two branches**, which
   [FKP] state with the twist. Nothing is proved here; it is imported.
2. **On a neighbourhood $V$ of the node** (disjoint from the Ramond divisor by Definition 2.4's
   disjointness requirement): the twisting sheaf is **canonically trivialized** by its tautological
   section, so the twisted assertion *is* the untwisted assertion, which is the genuinely
   node-theoretic step (§5.2).
3. **Globally**: the two assertions glue because $\mathcal O_{Z_0}(D)$ is invertible on all of $Z_0$
   (H3), so $\underline{\mathrm{Hom}}(-,\omega_{Z_0}(D))=\underline{\mathrm{Hom}}(-,\omega_{Z_0})
   \otimes\mathcal O_{Z_0}(D)$ and the parity splitting of Lemma 4.3 is unaffected.

So the load-bearing hypothesis is not "locality of gluing" in the vague sense, but the single
combinatorial fact **$z\notin\mathrm{Supp}(R^Z)$**, which is forced by Definition 2.4's word
"disjoint". If one ever glues at a point that *is* on the Ramond divisor — i.e. gluing at Ramond
punctures, [FKP, §7.6] — step 2 collapses and the argument gives nothing; that is the structural
reason §7.6 opens with "*Gluing along two Ramond punctures is more subtle*" and why (7.11)/(7.12)
are $\mathbb Z/2\ltimes\mathbb A^{0|1}$-torsors over the moduli spaces rather than maps from them.

**Is the answer (a) or (b)?** It is **(a)**: no hypothesis beyond [FKP]'s own Definition 2.4 is
needed, so the conclusion is unconditional and `[GAP-FKP-RAMOND]` can be discharged on Lemma 7.9. The
only thing that would turn it into (b) is if some intended use of (7.8) placed a Ramond puncture at
the glued point, which is forbidden by the definition and never happens in
`research/papers/supermoduli-punctured-nonprojected/paper.md` (there the glued points are
$P\in\mathfrak S^+_{h;1,0}$ and $q\in F$, both NS, and the Ramond punctures $\rho_1,\dots,\rho_{2r}$
are distinct points of the tail $F$).

**A fortiori for the paper.** The paper's Construction 5.3 is the special case $g_1=h$, $m_1=0$,
$n_1=0$; $g_2=a$, $m_2=n$, $n_2=2r$. Its moving factor carries **no** Ramond punctures at all
($n_1=0$), so on that branch §5.1 is the untwisted hypothesis anyway, and all Ramond punctures sit on
the constant tail at points distinct from $q$. Both hypotheses (H1), (H2) are satisfied by
construction (Lemma 5.2 of the paper chooses $q,y_1,\dots,y_n,\rho_1,\dots,\rho_{2r}$ *pairwise
distinct* on a *smooth* curve $F$).

---

## 9. Footprint I — which surrounding statements are really NS-only

This section is an independent page-image audit of the claim, circulating in this project, that
"the entire derivation chain leading to (9.6) runs on NS-only lemmas"
(`research/papers/supermoduli-punctured-nonprojected/paper.md` §10.1). **That sentence is wrong**,
and the chain is in better shape than it says. Evidence, all from rendered page images at 220 dpi.

### 9.1 The §8.4 setup already declares Ramond divisors [p. 56, verbatim]

> **8.4. Canonical line bundle on the moduli space of stable supercurves with punctures.** Let
> $\pi:X\to S$ be a stable supercurve with NS punctures $P_1,\dots,P_m$ and **Ramond divisors
> $R_1,\dots,R_n$**. We denote by $D_i\subset X$ the divisors associated with $P_i$ as in Sec. 2.5.
> For every $i=1,\dots,m$, let us define a line bundle of rank $0|1$ on $S$,
> $\Psi_i:=P_i^*\omega_{X/S}$.

Everything from Lemma 8.7 to (8.11) is stated *inside* this setup.

### 9.2 Statement-by-statement

| statement | page | scope as printed | on the (9.6) chain? |
|---|---|---|---|
| **Lemma 8.7** ($\Psi_i\simeq\pi_*\mathcal O_{D_i}/\mathcal O_S$, $\Psi_i^{-1}\simeq P_i^*\omega_{X/S}(D_i)\simeq P_i^*\omega_{D_i/S}\simeq\mathrm{Ber}(\pi_*\mathcal O_{D_i})$) | 56 | §8.4 setup, **Ramond divisors present** | **yes** (proof of Lemma 8.11, p. 58; and p. 60, last paragraph) |
| **Cor. 8.8** ("The line bundle $P_i^*\omega^2_{X/S}(D_i)$ on $S$ is canonically trivialized") | 57 | same setup, **Ramond divisors present** | **yes** (cited by name in Lemma 9.1(i), p. 59) |
| **Example 8.9** ("Suppose $X\to S,(P_i)$ is a family of supercurves with **NS-punctures** over an *even* base $S$ … $(C,L)$ … with **spin-structures**") | 57 | **genuinely NS-only**, and an even base as well | **no** — not cited in the proof of Lemma 8.11 (p. 58), nor in Lemma 9.1 (pp. 59–60), nor in the proof of Theorem B (p. 58) |
| **Remark 8.10** | 57 | §8.4 setup; and it **explicitly handles the Ramond divisors**: "For every Ramond divisor $R_j\subset X$ let us consider the line bundle on the base, $\Phi_j:=\mathrm{Ber}(\pi_*\mathcal O_{R_j})^{-1}\simeq\mathrm{Ber}(\pi_*\omega_{R_j})$. Note that $\Phi_j=\Phi_{R_j}$ (see (7.10)), so the line bundles $\Phi_j^2$ are canonically trivialized." | **yes** (cited by name in the proof of Lemma 9.1(ii), p. 60) |
| **Lemma 8.11 / Theorem B (8.11)** | 57–58 | §8.4 setup; the proof runs on (8.2), Lemma 8.7, the filtration of $\omega^3(2R)/\omega^3$, and the trivializations of $\Phi_j^2$ | it *is* the chain |

### 9.3 Verdict

* **Lemma 8.7, Cor. 8.8 and Remark 8.10 are already stated in punctured generality.** The narrowed
  scope claimed for `[GAP-FKP-RAMOND]` is correct on this point.
* Moreover Lemma 8.7 and Cor. 8.8 are **insensitive** to the twist for a structural reason worth
  recording: every object in them is pulled back along $P_i$, and $P_i\cap R=\varnothing$
  (Definition 2.4), so $P_i^*\omega_{X/S}(R)=P_i^*\omega_{X/S}$. Writing $\omega_{X/S}$ rather than
  $\omega_{X/S}(R)$ there is not even an omission.
* **Example 8.9 is the only genuinely NS-only item**, and it is **off the chain**: it is an
  illustration computing $\Psi_i^{-1}\simeq p_i^*L^{-1}$ for NS-only families over an even base, and
  no later statement invokes it.
* **Therefore §10.1's sentence "the entire derivation chain leading to (9.6) runs on NS-only lemmas"
  is false as written and should be deleted.** The only NS-only ingredient that was ever load-bearing
  is Lemma 7.9 — precisely the one this attempt has now proved in the punctured generality (§7).

---

## 10. Footprint II — the status of (7.1)

A second claim circulating in this project is that **(7.1) is a misprint** and should read
$0\to\omega^2_{X/S}(R)\to j_*\Omega_{U/S}\to\omega_{X/S}(R)\to0$. My independent verdict:
**the corrected formula is right, the word "misprint" is wrong.**

### 10.1 What is actually printed [p. 41, verbatim]

> **7.1. Modified sheaf of differentials.** Let $\pi:X\to S$ be **a family of stable supercurves**
> such that the map from $S$ to the deformation space of each node is smooth. Let $j:U\to X$ be the
> embedding of the smooth locus. […]
> Since $U/S$ is a smooth supercurve, we have an exact sequence
> $$0\to\omega^2_{U/S}\xrightarrow{\ \kappa\ }\Omega_{U/S}\xrightarrow{\ \delta\ }\omega_{U/S}\to0$$
> where in standard coordinates
> $$\delta(dz)=\theta[dz|d\theta],\quad\delta(d\theta)=[dz|d\theta],\qquad
> \kappa([dz|d\theta]^{\otimes2})=dz-\theta d\theta.$$
> […]
> **Lemma 7.1.** *The map $j_*\delta$ is surjective, so we have an exact sequence*
> $$0\to\omega^2_{X/S}\xrightarrow{\ \kappa\ }j_*\Omega_{U/S}\xrightarrow{\ j_*\delta\ }\omega_{X/S}\to0.
> \tag{7.1}$$

Two things follow from the *hypothesis line* and the *displayed local formulas*, and they decide the
question:

1. §7.1 is opened for "a family of **stable supercurves**", with **no punctures in the hypotheses**.
2. $\delta(dz)=\theta[dz|d\theta]$, $\delta(d\theta)=[dz|d\theta]$ are the formulas for the **NS
   (non-degenerate) normal form** $D=\partial_\theta+\theta\partial_z$, for which $Dz=\theta$,
   $D\theta=1$. They are *not* the Ramond normal form.

So (7.1) is a **correct statement, correctly proved, in a narrower scope than its later use** — not a
typographical slip. Calling it a misprint misdescribes where the defect is: nothing is mistyped;
§7.1 simply never states the punctured case, and Lemma 9.1(iv) (p. 60, verbatim: *"This follows from
parts (i), (ii) and from the exact sequence (7.1) (and a similar exact sequence for
$\Omega_{\widetilde X/B}$ which holds over the smooth locus)"*) then invokes it for the universal
supercurve over $\overline{\mathcal S}_{g,n_{NS},n_R}$, which does have punctures.

### 10.2 The correct punctured analogue, derived

**Proposition 10.1.** *Let $(X/S,P_\bullet,R_\bullet)$ be a family of stable supercurves with
punctures, with the smoothness hypothesis of §7.1, and $j:U\to X$ the smooth locus. Then*
$$0\ \to\ \omega^2_{X/S}(R)\ \xrightarrow{\ \kappa\ }\ j_*\Omega_{U/S}\ \xrightarrow{\ j_*\delta\ }\
\omega_{X/S}(R)\ \to\ 0. \tag{7.1$_R$}$$

*Proof.* Two independent checks.

**(a) Berezinian rank count (global, convention-free).** The middle term is *not* twisted: $\Omega_{U/S}$
is intrinsic, and $j_*$ does not see $R$. The right-hand term is forced to be $\omega_{X/S}(R)$ by
Definition 2.4, which declares $\delta:\mathcal O_X\to\omega_{X/S}(R)$ and — via (2.4) — requires
$\delta^-$ to be *onto* the odd part of $\omega(R)$. For a short exact sequence of locally free
modules, $\mathrm{Ber}$ is multiplicative; $\mathrm{Ber}(\Omega_{U/S})=\omega_{U/S}$ by definition;
the quotient $\omega(R)$ has rank $0|1$, so $\mathrm{Ber}(\omega(R))=\omega(R)^{-1}$; the kernel $K$
has rank $1|0$, so $\mathrm{Ber}(K)=K$. Hence
$$\omega\ =\ K\otimes\omega^{-1}(-R)\qquad\Longrightarrow\qquad K=\omega^2(R).$$

**(b) Local normal form at a Ramond divisor.** Near $R_j=\{z=0\}$ the structure derivation of a smooth
supercurve with a Ramond puncture is $D=\partial_\theta+\theta z\,\partial_z$ (the degenerate case:
$D^2=z\partial_z$), so $Dz=\theta z$, $D\theta=1$, and $\delta(f)=(Df)\,\sigma$ with $\sigma$ the
generator of the target. Consistency with Lemma 2.6's dictionary pins $\sigma$ down: over an even
base, $\omega^-_X=\underline{\mathrm{Hom}}(L,\omega_C)$ and $\delta^-:L\xrightarrow{\sim}
\underline{\mathrm{Hom}}(L,\omega_C(r))=\omega_X(R)^-$, so with $L=\mathcal O_C\theta$ near $r$ one
gets $\delta(\theta)=\theta^\vee\otimes\frac{dz}{z}$, i.e.
$$\sigma\ =\ z^{-1}[dz|d\theta],$$
a generator of $\omega_{X/S}(R)$ and **not** of $\omega_{X/S}$. Then
$$\delta(dz)=\theta z\,\sigma=\theta\,[dz|d\theta],\qquad \delta(d\theta)=\sigma=z^{-1}[dz|d\theta],$$
which is surjective onto $\mathcal O\sigma=\omega(R)$, with kernel generated by
$$dz-\theta z\,d\theta,$$
free of rank $1|0$; and the twisted $\kappa$ is $\sigma^{\otimes2}=z^{-2}[dz|d\theta]^{\otimes2}
\mapsto z^{-1}(dz-\theta z\,d\theta)$, identifying the kernel with $\omega^2(R)$. Away from $R$ the
normal form is the NS one and the printed (7.1) applies verbatim; the two descriptions agree on the
overlap because $z$ is a unit there. Exactness at the nodes is FKP's Lemma 7.1, whose argument is
node-local and does not involve $R$ (the nodes are disjoint from the punctures). $\square$

**Corroboration from §6.4 [p. 41, verbatim]:**
$\mathcal A_{(X,P_\bullet,R_\bullet)/S}\simeq\mathcal L(X,P_\bullet,R_\bullet):=\omega^{-2}_{X/S}
(-\sum_{i\in I}D_i-2\sum_{j\in J}R_j)$. Reading this as "$K^{-1}$, further twisted down by the
conditions of fixing the punctures" gives $K^{-1}=\omega^{-2}(-R)$ before the $-D_i$ for the NS
punctures and one further $-R$ for fixing the Ramond divisors — i.e. $K=\omega^2(R)$, matching
(7.1$_R$). This is numerology rather than proof, but it is consistent, whereas $K=\omega^2$ would
require the Ramond-fixing condition to cost $-2R$ in one step.

### 10.2bis Decisive confirmation: FKP already print (7.1$_R$) on p. 5

After deriving Proposition 10.1 I checked [FKP, §2.2, p. 5] and found the punctured sequence
**printed there in full generality**, verbatim:

> In the above situation the map $D_1\otimes D_2\mapsto\frac12[D_1,D_2]$ induces an isomorphism
> $$\mathcal D^{\otimes2}\xrightarrow{\ \sim\ }\mathcal T_{X/S}/\mathcal D(-R).\tag{2.2}$$
> Thus, we have an exact sequence
> $$0\to\mathcal D\to\mathcal T_{X/S}\to\mathcal D^{\otimes2}(R)\to0,$$
> or dually,
> $$0\to\mathcal D^{-2}(-R)\to\Omega_{X/S}\to\mathcal D^{-1}\to0.$$
> From this we get an isomorphism $\omega_{X/S}:=\mathrm{Ber}(\Omega_{X/S})\simeq\mathcal D^{-1}(-R)$,
> or equivalently,
> $$\mathcal D\simeq\omega^{-1}_{X/S}(-R).\tag{2.3}$$
> Hence, taking the dual of the embedding $\mathcal D\to\mathcal T_{X/S}$, we get a surjective
> morphism
> $$\delta:\Omega_{X/S}\to\mathcal D^{-1}\simeq\omega_{X/S}(R),$$
> […] Equivalently, we can view $\delta$ as a derivation $\mathcal O_X\to\omega_{X/S}(R)$, trivial
> on $\mathcal O_S$.

Substituting (2.3): $\mathcal D^{-1}=\omega_{X/S}(R)$ and
$\mathcal D^{-2}(-R)=\omega^2_{X/S}(2R)(-R)=\omega^2_{X/S}(R)$, so FKP's own dual sequence **is**
$$0\to\omega^2_{X/S}(R)\to\Omega_{X/S}\to\omega_{X/S}(R)\to0,$$
in exact agreement with Proposition 10.1. This makes the verdict certain and closes the question:

* **The mathematics of (7.1$_R$) is FKP's own, from p. 5.** My §10.2(a)(b) is an independent
  re-derivation of it; the two agree.
* **(7.1) is therefore not a misprint but a specialization.** §7.1 opens with "Since $U/S$ is a
  smooth supercurve, we have an exact sequence …", which is a back-reference to precisely the p. 5
  sequence — taken at $R=\varnothing$, consistently with §7.1's own hypothesis line ("a family of
  stable supercurves", no punctures) and with the NS normal form in its displayed local formulas.
  What is missing is the sentence "and with punctures the same sequence reads (7.1$_R$)" at the point
  where Lemma 9.1(iv) needs it.

### 10.3 Does the scope gap damage Lemma 9.1(iv), hence (9.6)?

No, and for the *same reason* as in §8: the twist enters **symmetrically and cancels**.
Lemma 9.1(iv) compares $j_*\Omega_{U/\overline{\mathcal S}}|_{X_B}$ with
$\Omega_{\widetilde X/B}(D_1+D_2)$ and asserts that the cokernel $\widetilde{\mathcal C}$ is
supported **on the node** with subfactors $\mathcal O_Q,\mathcal O_Q,Q_*(\Psi_1^{-1}\oplus\Psi_2^{-1})$.
Replacing (7.1) by (7.1$_R$) for $X_B$ and simultaneously for $\widetilde X$ leaves the **middle**
terms $j_*\Omega_U$, $\Omega_{\widetilde X/B}$ — the only ones appearing in (iv) — literally
unchanged, and twists the outer terms by the *same* $\mathcal O(R)$ on both sides, since $R$ is
pulled back identically along $\rho:\widetilde X\to X_B$ (the Ramond divisors are untouched by the
NS gluing and are disjoint from the node). The same applies to the displayed sequence at the foot of
p. 60, $0\to\omega^2_{\widetilde X/B}\to\Omega_{\widetilde X/B}\to\omega_{\widetilde X/B}\to0$, which
is invoked *"near $D_1,D_2$"* — a region disjoint from $R$, where the twist is canonically trivial.

**[GAP: Lemma 9.1(iv) not re-derived in full]** I have checked which terms move and which do not, and
found no term whose twist fails to cancel; I have not rewritten the whole of the proof of Lemma 9.1
under (7.1$_R$).

---

## 11. Open points

- **[GAP: S1 not reproved]** The description of $\omega_{Z_0}$ near a node (Rosenlicht/Serre, §1.5
  [S1]) is imported as a standard fact and used in (5.2). It is classical, predates all of the
  supergeometry, and is $R$-independent; but this write-up does not reprove it.
- **[GAP: general base]** The verification of (2.4) is fibrewise by definition, so §5 over an
  algebraically closed field suffices for that condition. The construction of $\delta_Z$ and the
  structural conditions §6.1, §6.3 are stated over a general $S$ and follow [FKP]'s own treatment;
  the present write-up checks their $R$-dependence (nil) but does not re-derive [FKP]'s
  base-change/flatness bookkeeping.
- Nothing here bears on [FKP, §7.6] (Ramond-node gluing), and §8 explains why it cannot.
- **[GAP: the last arrow of Lemma 7.9's display is never named by FKP]** The composite defining
  $\delta_Z$ ends in an unlabelled arrow $j_*\omega_{X/S}\oplus j'_*\omega_{X'/S}\to\omega_{Z/S}$
  ([FKP], p. 47). FKP do not say which map this is. §4.4 and §6.1 take it to be the canonical
  residue-free (trace) inclusion of the branch dualizing sheaves — the only natural candidate, and
  the one under which the lemma is true. Worth noting that this inclusion is **injective but not
  surjective**: at the node its image is $(u)\eta\oplus(v)\eta\subsetneq A\eta$, of colength one.
  This is harmless, and in fact necessary: $\omega_Z(R^Z)^-$ is exactly
  $\underline{\mathrm{Hom}}(\mathcal F,\omega_{Z_0}(D))$, whose stalk at $z$ is that same proper
  submodule (§5.2, (5.4)), so $\delta^-_Z$ lands on the nose. But the identification of FKP's arrow
  is an interpretive step, not a quoted one.
- **[GAP: Remark 2.3 vs (2.5)]** §1.4's forensic note observes that [FKP, Remark 2.3, p. 5] prints
  $L^2\xrightarrow{\sim}\omega_C$ untwisted for "a smooth supercurve over an even base", without
  restricting to $R=\varnothing$ in its hypothesis line. Either Remark 2.3 is tacitly unpunctured,
  or it carries the same omission as Lemma 7.9's proof. I have not resolved which; nothing in this
  write-up depends on Remark 2.3 (everything uses (2.5), p. 7).
