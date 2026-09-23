# claim — FKP Lemma 7.9 under the Ramond twist $\omega_C \rightsquigarrow \omega_C(R)$

**Attempt slug:** `fkp-79-ramond-twist`
**Opened:** 2026-09-23
**Source under examination:** G. Felder, D. Kazhdan, A. Polishchuk, *The Moduli Space of Stable
Supercurves and Its Canonical Line Bundle*, Amer. J. Math. **145** (2023) 1777–1886;
**arXiv:2006.13271v3**. All page numbers below refer to the arXiv v3 PDF, whose page numbers agree
with the printed ones (verified from the running head).

---

## 0. Why this claim exists

`research/papers/supermoduli-punctured-nonprojected/paper.md` §10.1 records an external gap
`[GAP-FKP-RAMOND]`: the **printed proof** of [FKP, Lemma 7.9] checks the generalized-spin condition
using $\omega_C$ and not $\omega_C(R)$, although the morphism (7.8) that the lemma underwrites is
stated for arbitrary numbers $n_1,n_2$ of Ramond punctures. That paper's Theorem 8.4 (= its
Theorem B, its title-level result) is the $r\ge1$ case, so it rests on Lemma 7.9 in a generality the
printed proof does not literally cover.

The task of this attempt is to redo that local computation with the twist present, and to decide
whether the lemma survives.

---

## 1. Notation and the verbatim hypotheses imported from [FKP]

All of the following are quoted from rendered page images of arXiv:2006.13271v3 (not from
`pdftotext`); the verbatim transcriptions with page references are collected in `proof.md` §1.

**(D1) [FKP, Definition 2.4, p. 6].** A *supercurve with punctures* over a base superscheme $S$ is a
superscheme $\pi:X\to S$, proper and flat with relatively Cohen–Macaulay fibres of pure dimension
$1|1$ on a dense open, together with

* a collection of **disjoint** closed subschemes $P_i\subset X$ ($i=1,\dots,n_{NS}$, *NS-punctures*,
  with $P_i\to S$ an isomorphism) and $R_i\subset X$ ($i=1,\dots,n_R$, *R-punctures*, each a Cartier
  divisor flat over $S$);
* a derivation
  $$\delta:\mathcal O_X\longrightarrow \omega_{X/S}(R),\qquad R:=\textstyle\sum_i R_i,$$
  trivial on pull-backs of functions on $S$;

subject to: there is a fibrewise dense open $U\subset X$, smooth of dimension $1|1$ over $S$, with
$P_i\subset U$ and $R_i\subset U$; $\delta$ restricts on $(U,(R_i))$ to the structure of a smooth
supercurve with Ramond punctures; and

$$\textbf{(2.4)}\qquad \delta^-\ \text{induces an isomorphism}\quad
\mathcal O^-_{X_s}\ \xrightarrow{\ \sim\ }\ \omega_{X_s}\big(\textstyle\sum_i R_{is}\big)^-
\quad\text{on every geometric fibre } X_s .$$

$(X/S,P_\bullet,R_\bullet)$ is **stable** if $X/S$ is proper and every geometric fibre's bosonic
truncation, with the marked points induced by the $P_i$ and $R_i$, is a stable pointed curve.

> The twist $(R)$ is present in **both** places: in the target of $\delta$ and in (2.4). This is the
> twist whose omission is at issue.

**(D2) [FKP, Lemma 2.6 and the definition following it, p. 7].** For $S$ **even**, the data of a
supercurve $(X,P_\bullet,R_\bullet)/S$ is equivalent to a flat family of pointed curves
$(C,p_\bullet,r_\bullet)/S$ with reduced geometric fibres, smooth near the marked points, plus a
coherent sheaf $L$ on $C$ (flat, relatively CM, locally free of rank $1$ on a fibrewise dense open)
plus an isomorphism

$$\textbf{(2.5)}\qquad L\ \xrightarrow{\ \sim\ }\ \underline{\mathrm{Hom}}\big(L,\ \omega_C(\textstyle\sum_i r_i)\big).$$

Under the correspondence $\mathcal O_X^+=\mathcal O_C$, $\mathcal O_X^-=L$, $\omega_X^+=\omega_C$,
$\omega_X^-=\underline{\mathrm{Hom}}(L,\omega_C)\simeq L(-\sum r_i)$, and **(2.5) corresponds to
$\delta^-$**. A coherent sheaf $L$ on a prestable curve $C/S$ with an isomorphism (2.5) is called a
*generalized spin structure*.

> (2.5) is stated by [FKP] **with** the twist $\omega_C(\sum r_i)$, in full generality. It is the
> **$r=0$ instance** of (2.5) that the printed proof of Lemma 7.9 quotes.

**(D3) [FKP, §7.5, p. 47] (the gluing construction).** For superschemes $X,X',Y$ with closed
embeddings $i:Y\to X$, $i:Y\to X'$, the glued superscheme $Z$ has underlying space the topological
gluing, with closed embeddings $j:X\to Z$, $j':X'\to Z$, and $\mathcal O_Z\subset
j_*\mathcal O_X\oplus j'_*\mathcal O_{X'}$ the preimage of the diagonal
$k_*\mathcal O_Y\subset k_*\mathcal O_Y\oplus k_*\mathcal O_Y$ under $\phi\oplus\phi'$. Applied to a
pair of stable supercurves $X/S$, $X'/S$ with **NS**-punctures $P\subset X$, $P'\subset X'$ and
$P\simeq S\simeq P'$, this defines $Z/S$.

---

## 2. The claim

> **Claim (Lemma 7.9 with the Ramond twist).**
> Let $S$ be a scheme (purely even), let
> $$(X/S,\ P,P_1,\dots,P_{m_1},\ R_1,\dots,R_{n_1}),\qquad
> (X'/S,\ P',P'_1,\dots,P'_{m_2},\ R'_1,\dots,R'_{n_2})$$
> be stable supercurves with punctures in the sense of (D1), with **arbitrary**
> $m_1,m_2\ge0$ and **arbitrary** $n_1,n_2\ge0$. Let $Z/S$ be the superscheme glued from $X$ and
> $X'$ along $P\simeq S\simeq P'$ as in (D3), and give $Z$ the punctures
> $$P^Z_\bullet := j(P_\bullet)\sqcup j'(P'_\bullet),\qquad
> R^Z_\bullet := j(R_\bullet)\sqcup j'(R'_\bullet),\qquad R^Z:=\textstyle\sum_i R^Z_i .$$
> Then $Z/S$ carries a natural **stable supercurve with punctures** structure in the sense of (D1),
> whose derivation $\delta_Z:\mathcal O_Z\to\omega_{Z/S}(R^Z)$ is the composition
> $$\mathcal O_Z\ \longrightarrow\ j_*\mathcal O_X\oplus j'_*\mathcal O_{X'}
> \ \xrightarrow{\ (j_*\delta,\ j'_*\delta')\ }\
> j_*\big(\omega_{X/S}(R)\big)\oplus j'_*\big(\omega_{X'/S}(R')\big)
> \ \longrightarrow\ \omega_{Z/S}(R^Z),$$
> the last arrow being the canonical (residue-free) inclusion of the branch dualizing sheaves,
> twisted by the invertible sheaf $\mathcal O_Z(R^Z)$.
>
> In particular the gluing morphism
> $$\overline{\mathcal S}_{g_1;m_1+1,n_1}\times\overline{\mathcal S}_{g_2;m_2+1,n_2}
> \longrightarrow\overline{\mathcal S}_{g_1+g_2;\,m_1+m_2,\,n_1+n_2}\qquad \textbf{(7.8)}$$
> is well defined for all $m_i\ge0$ and all $n_i\ge0$, not only for $n_1=n_2=0$.

**Quantifiers, explicitly.** The claim is universally quantified over $S$, over both supercurves,
over the numbers of punctures of both types on both factors, and over the choice of the two glued NS
punctures. Nothing is assumed about the position of $R$ relative to the node beyond what (D1)
already forces — namely that the $R_i$ and the NS puncture $P$ are **disjoint** closed subschemes
contained in the smooth locus $U\subset X$.

**What is *not* claimed.** Nothing about gluing at **Ramond** punctures ([FKP, §7.6], morphisms
(7.11)/(7.12)); nothing about [FKP, Lemma 7.10] (a separate statement, already written and proved in
punctured generality in the source); nothing about the rest of [FKP].

---

## 3. Bricks used

Everything used is either (i) quoted verbatim from [FKP] above, or (ii) elementary commutative
algebra / duality theory for curves, proved from scratch in `proof.md`. **No step of the argument
quotes FKP's own "It is well known that …" sentence** — that step is replaced by an explicit local
computation (`proof.md` §5), which is a small strengthening, since [FKP] gives no reference for it.

No `conjecture`- or `physical-argument`-status input is used.

---

## 4. Verdict recorded in `proof.md`

Outcome **(a)**: the lemma holds with the twist, and the complete local computation is written out.
The one hypothesis that carries the weight — and which is automatic in [FKP]'s own setup, hence does
not make this a conditional result — is the disjointness of $R$ from the glued NS puncture $P$,
[FKP, Def. 2.4, p. 6], verbatim: *"a collection of **disjoint** closed subschemes called
NS-punctures and R-punctures"*.
