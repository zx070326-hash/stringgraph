# claim.md — FKP eq. (9.6) for a target with arbitrary NS and Ramond punctures

**Attempt slug**: `fkp-96-punctured`
**Opened**: 2026-09-23, `theorem-prover`, branch `agent/prover/fkp-96-punctured`
**Trigger**: the single inference flagged `[INF-NORMAL]` in
`research/papers/supermoduli-punctured-nonprojected/paper.md`, Remark 5.8 (line ~693).

---

## 0. Why this attempt exists

The paper `supermoduli-punctured-nonprojected` proves that the compactified supermoduli stack
$\overline{\mathfrak S}_{g;n,2r}$ of stable supercurves with $n$ NS and $2r$ Ramond punctures is
non-projected. Its Lemma 5.5 ("the normal line") computes

$$e^*N_{\mathcal B}\ \cong\ L^{-1}\otimes\mathfrak n ,\qquad
N_{\mathcal B}:=\mathcal O(\Delta_{\rm NS})|_{\mathcal B},$$

and step (a) of that lemma imports, from Felder–Kazhdan–Polishchuk
(*The Moduli Space of Stable Supercurves and Its Canonical Line Bundle*, Amer. J. Math. **145**
(2023) 1777–1886; arXiv:2006.13271v3 — henceforth **[FKP]**), the normal-line formula

$$\mathcal O(\Delta)|_B\ \simeq\ \operatorname{Ber}R\pi_*\big(j_*\Omega_{U/\overline{\mathcal S}}\big)
\big|_B\otimes\operatorname{Ber}^{-1}R\pi_*\big(\Omega_{X/\overline{\mathcal S}}|_B\big)
\ \simeq\ \Psi_1^{-1}\Psi_2^{-1}. \tag{FKP 9.6}$$

**[FKP] never states (9.6) for a target carrying punctures.** Every displayed statement in [FKP]
§9.1 (the comparison argument on p. 58, Theorem 9.2 on p. 61, Theorem C on pp. 2–3) is written in
the puncture-free shape — two $\Psi$'s and no $\bigotimes_{i}\Psi_i$ factor — even though the
gluing maps (7.8)/(7.9) that §9.1's own setup invokes carry general puncture indices $(m,n)$.
This was verified at L1 (rendered page images, 400–500 dpi) by this project's three-round
extraction, `literature/extractions/felder-kazhdan-polishchuk-2020.md`, entries E7–E15.

The paper therefore uses (9.6) for a punctured target as an **inference**, labelled
`[INF-NORMAL]`. This attempt asks whether the inference can be replaced by a proof.

---

## 1. Notation (fixed once; [FKP]'s, with this project's disambiguations)

Throughout, all superschemes/superstacks are over $\mathbb C$.

- $\overline{\mathcal S}_{g;m,n}$ — the [FKP] compactified moduli superstack of stable supercurves of
  genus $g$ with $m$ NS punctures and $n$ Ramond punctures ($n$ even), [FKP, Thm. A] and [FKP, §7.5,
  p. 48]. **Semicolon convention.** ([FKP] also writes $\overline{\mathcal S}_{g,n_{\rm NS},n_{\rm R}}$
  with commas in §1, §5, §8; [FKP] never writes down that the two notations agree, so this attempt
  uses the semicolon form exclusively and states as a hypothesis, where needed, only what it
  actually uses.)
- $\mathcal S_{g;m,n}\subset\overline{\mathcal S}_{g;m,n}$ — the open substack of **smooth**
  supercurves.
- $\pi\colon X\to\overline{\mathcal S}$ — the universal stable supercurve; $j\colon U\hookrightarrow X$
  the open complement of the **nodes** in the fibres (so **all punctures lie in $U$**).
- $\omega_{X/S}$ — relative dualizing sheaf; $\omega^{2k}_{X/S}:=j_*\omega^{2k}_{U/S}$ ([FKP, Thm. 4.1]);
  $\Omega_{X/S}$ — relative differentials (rank $1|1$ on the smooth locus).
- $\Delta$ — the boundary Cartier divisor of [FKP, §7.2], defined as the vanishing divisor of the
  canonical section of $\mathcal L:=\operatorname{Ber}\big[\Omega_{X/\overline{\mathcal S}}\to
  j_*\Omega_{U/\overline{\mathcal S}}\big]$; $\Delta=\Delta_{\rm NS}+\Delta_{\rm R}$ ([FKP, Prop. 7.8]).
- For an NS puncture $P_i$ with associated divisor $D_i\subset X$: $\Psi_i:=P_i^*\omega_{X/S}$,
  a line bundle of rank $0|1$ on the base ([FKP, §8.4, p. 56]).
- **Warning inherited from the extraction**: in [FKP] the letter $m$ has three unrelated meanings
  ((8.11)/§8.4 = number of NS punctures; Lemma 9.1/9.3 = exponent of $\omega$; proof of Lemma 7.10
  = number of nodes other than $q$). Below, $m$ **always** means the number of NS punctures, and
  the exponent of $\omega$ is written $k$.

---

## 2. The precise claim

> **Claim P (punctured normal-line formula).**
> Let $g_1,g_2\ge0$ and $m_1,m_2,n_1,n_2\ge0$ with $n_1,n_2$ even, such that both
> $(g_1;m_1{+}1,n_1)$ and $(g_2;m_2{+}1,n_2)$ lie in the stable range (i.e. the moduli stacks
> $\mathcal S_{g_i;m_i+1,n_i}$ are non-empty). Put
> $$g:=g_1+g_2,\qquad m:=m_1+m_2,\qquad n:=n_1+n_2,\qquad
> \overline{\mathcal S}:=\overline{\mathcal S}_{g;m,n},$$
> and let
> $$\iota\colon\ B:=\mathcal S_{g_1;m_1+1,n_1}\times\mathcal S_{g_2;m_2+1,n_2}
> \ \longrightarrow\ \overline{\mathcal S}_{g;m,n}$$
> be [FKP]'s separating NS gluing map (7.8) restricted to the locus of smooth supercurves, gluing
> the last NS puncture of each factor into a separating NS node. Let $\Psi_1,\Psi_2$ denote the
> psi-lines on $B$ of the two glued NS punctures. Then there are canonical isomorphisms of line
> bundles of rank $1|0$ on $B$
> $$\iota^*\mathcal O(\Delta_{\rm NS})\ \cong\ \iota^*\mathcal O(\Delta)\ \cong\
> \Psi_1^{-1}\otimes\Psi_2^{-1}.$$
> **In particular the formula holds for $m,n$ arbitrary, not only $m=n=0$.**

Quantifiers, spelled out: **for all** $g_1,g_2,m_1,m_2,n_1,n_2$ in the stated range, **there exist**
isomorphisms as displayed, natural in the sense that they are obtained by restricting to $B$ a
canonical isomorphism of line bundles built from [FKP]'s (7.6) and Lemma 9.1.

> **Claim P′ (non-separating version, secondary).** The same conclusion for
> $\iota\colon B=\mathcal S_{g;m+2,n}\to\overline{\mathcal S}_{g+1;m,n}$, [FKP]'s map (7.9).

The case relevant to `supermoduli-punctured-nonprojected` is **Claim P** with
$$g_1=h,\ m_1=0,\ n_1=0;\qquad g_2=a,\ m_2=n_{\rm paper},\ n_2=2r,$$
i.e. exactly the index choice recorded in that paper's Construction 5.3. (Note the clash of
letters: the paper's $n$ = number of spectator NS punctures = this file's $m_2$; the paper's $2r$ =
this file's $n_2$.)

---

## 3. What may be assumed, and what may not

**Admissible as black boxes** (all are [FKP] results verified at L1 in
`literature/extractions/felder-kazhdan-polishchuk-2020.md`, or stated by [FKP] for an *arbitrary*
family of (pre)stable supercurves, hence carrying no hidden puncture hypothesis):

| # | Input | Location | Puncture status |
|---|---|---|---|
| A1 | $\overline{\mathcal S}_{g;m,n}$ is a smooth proper DM superstack | [FKP, Thm. A] | stated **with** $(m,n)$ arbitrary |
| A2 | $\omega^{2k}_{X/S}:=j_*\omega^{2k}_{U/S}$ is a line bundle; compatible with base change | [FKP, Thm. 4.1] | stated for an **arbitrary** prestable family; punctures do not appear |
| A3 | Prop. 7.4: the canonical trivialisation of $\mathcal L$ extends and vanishes to order one at a one-node point | [FKP, Prop. 7.4, pp. 44–45] | stated for an **arbitrary** family; punctures do not appear |
| A4 | Prop. 7.8: $\Delta=\Delta_{\rm NS}+\Delta_{\rm R}$, and $\Delta_{\rm NS}=\Delta$ near a point with only NS nodes | [FKP, Prop. 7.8, p. 47] | to be checked |
| A5 | Lemma 7.9 / Lemma 7.10: gluing along NS punctures is a stable supercurve; (7.8)/(7.9) are codimension-$1|0$ tangent embeddings whose schematic image is $\Delta_{\rm NS}$ | [FKP, pp. 47–49] | Lemma 7.10 is stated and proved **with punctures**, verbatim |
| A6 | Lemma 8.7: $\operatorname{Ber}(\pi_*(L|_{D_i}))\cong\Psi_i^{-1}$ for $L$ of rank $1|0$, $\cong\Psi_i$ for rank $0|1$ | [FKP, Lemma 8.7, p. 56] | stated for an **arbitrary** family with $m$ NS and $n$ Ramond punctures |
| A7 | Cor. 8.8: $P_i^*\omega^2_{X/S}(D_i)$ is canonically trivialised | [FKP, Cor. 8.8, p. 57] | same setup as A6 |
| A8 | Lemma 9.1(i)–(iv) | [FKP, pp. 59–60] | to be checked |
| A9 | Multiplicativity of $\operatorname{Ber}R\pi_*$ in short exact sequences, and its compatibility with base change for $\pi$ proper and the sheaf flat over the base | [FKP, §8.2] | general |

**Not admissible**: [FKP, §9.3] (the Ramond-node analogue) — it is verbatim a *conjecture*
("We conjecture that the following diagram is commutative (up to a sign)", p. 70). Nothing below
may use it. Also not admissible: [FKP, Theorem C], whose target is verbatim the **unpunctured**
$\overline{\mathcal S}_g$ — using it would beg the question.

**Known external gap, carried along, not assumed away**: `[GAP-FKP-RAMOND]`. [FKP]'s §8.4–§9.1
chain — Lemma 8.7, Cor. 8.8, Example 8.9, and hence Lemma 9.1(i) — is stated only for NS
punctures; and the *proof* of Lemma 7.9 writes the generalized spin structure as
$L\cong\mathcal Hom(L,\omega_C)$, i.e. drops the Ramond twist $\omega_C(\textstyle\sum\rho_j)$.
This attempt must either avoid these, or repair them, and must say which.

---

## 4. Attack plan (written before computing; kept for the record even if it fails)

The plan is **not** "the sheaves are supported on the node, hence punctures don't matter" — that is
precisely the inference under scrutiny, and it is too weak, because
$\operatorname{Ber}R\pi_*(-)$ is a global object on the whole fibre. The plan is stronger and
structural:

1. **Puncture-blindness of the input sheaves.** Show that *every* sheaf entering (7.6) and (9.6)
   — $\Omega_{X/S}$, $j_*\Omega_{U/S}$, $\omega_{X/S}$, $\omega^{2k}_{X/S}$ — is defined from the
   family of superschemes $X\to S$ **alone**, with no reference to the NS punctures $P_i$
   whatsoever, and with reference to the Ramond punctures only through the derivation
   $\delta\colon\mathcal O_X\to\omega_{X/S}(R)$ of [FKP, Def. 2.4] whose *target twist* does not
   enter any of the four sheaves. If so, then $\mathcal L$, its canonical section, and $\Delta$
   are literally the same objects on $\overline{\mathcal S}_{g;m,n}$ as on $\overline{\mathcal S}_g$,
   pulled back along the puncture-forgetting map wherever that exists, and — more to the point —
   *defined by the same formula* with no $\Psi_i$-corrections possible.
2. **Locate the only two places punctures can enter.** (i) The moduli-theoretic hypotheses (A1, and
   the smoothness of the map to node deformations) — these are stated by [FKP] for
   $\overline{\mathcal S}_{g;m,n}$ or follow from A1. (ii) $\Psi_1,\Psi_2$, which are the psi-lines
   of the *glued* punctures and are part of the data of the gluing, not spectators.
3. **Rebuild the three steps of (9.6) from scratch**, for the punctured target, quoting only A1–A9.
   In particular rebuild the step "$\operatorname{Ber}R\pi_*\Omega_{\widetilde X/B}(D_1+D_2)\simeq
   \operatorname{Ber}R\pi_*\Omega_{\widetilde X/B}$", which [FKP] compresses into one line
   ("near $D_1,D_2$, together with Lemma 8.7"), and check that the cancellation
   $\Psi_i^{-1}\cdot\Psi_i=\mathcal O$ there is insensitive to the spectator punctures.
4. **Bridge $\Delta\rightsquigarrow\Delta_{\rm NS}$** on $B$: show $\iota^*\mathcal O(\Delta_{\rm R})
   \cong\mathcal O_B$ because $\operatorname{Supp}\Delta_{\rm R}\cap\iota(B)=\varnothing$ (curves in
   $\iota(B)$ have exactly one node, of NS type — Ramond *punctures* are not Ramond *nodes*).
5. **Adversarial pass**: hunt for a puncture-dependent correction. The two places worth suspecting
   are (a) [FKP, Prop. 7.7], which asserts rank $(3g-3|2g-2)$ — the **unpunctured** dimension —
   and so is *prima facie* written for $\overline{\mathcal S}_g$; if the (9.6) chain needed Prop. 7.7
   the claim would be in trouble; (b) the exact sequence
   $0\to\omega^2_{U/S}\to\Omega_{U/S}\to\omega_{U/S}\to0$ of [FKP, §7.1], which uses superconformal
   standard coordinates and therefore must be checked near **Ramond punctures**, where the
   superconformal structure degenerates.

**Possible outcomes, all acceptable**: (a) Claim P proved, `[INF-NORMAL]` retractable; (b) Claim P
proved under extra hypotheses, which must then be checked in the paper's situation; (c) Claim P
not decidable with the available inputs, or false — in which case the load-bearing chain of
`supermoduli-punctured-nonprojected` has a real problem and that is the finding.

---

## 5. Evidence discipline

- L1 = verified by this agent against a **rendered page image** of arXiv:2006.13271v3;
  L3 = transcribed from `literature/extractions/felder-kazhdan-polishchuk-2020.md` or from
  `research/attempts/supermoduli-elliptic-tail-punctured/`.
- Every displayed [FKP] formula used as a premise in `proof.md` carries an explicit L1/L3 tag.
  `pdftotext` output is used **only** for locating page numbers, never as evidence — this project
  has twice been burned by `pdftotext` silently dropping symbols.
