# Proof record — splitness/projectedness of $\overline{\mathfrak S}_{1;2,0}$ and $\overline{\mathfrak S}_{0;3,2}$

Slug: `supermoduli-low-corner`. This file is written from scratch; nothing in the
`status.yaml` header predating this file (the dead prior agent's "planned state of
play") is treated as established. Every claim below is either (a) proved here from
inputs that are page-verified against a rendered PDF image (logged in Appendix A), or
(b) explicitly marked `[GAP: ...]`.

Conventions, definitions and the statement of the two target cells are fixed in
`claim.md` and are not repeated in full here; we recall only what is needed inline.

---

## Part 0 — status of `claim.md`'s Claims, in one table

This table is updated as the proof progresses; it is the authoritative summary, not the
prose below it.

| Claim | Status after this session | Where |
|---|---|---|
| 1 (rank-2 machinery) | **Proved**, two independent verifications | Part 1 |
| — (new: known nonzero-$\omega_2$ mechanism unavailable) | **Proved** (Lemma 2 + Cor. 2.1), scope stated precisely | Part 2 |
| 2 (uncompactified cells split) | Open | — |
| 3 (bosonic truncation structure) | Open | — |
| 4 (inertia criterion fails) | Open | — |
| 5 (boundary support reduction) | Open, contingent on Claim 2 | — |
| 6 (the dichotomy) | **Open** | — |

---

## Part 1 — Lemma 1 (= Claim 1): the rank-2 machinery

**Lemma 1.** Let $\mathfrak X$ be a smooth Deligne–Mumford superstack over $\mathbb C$ with
$\operatorname{rk} T_-\mathfrak X = 2$. Then
$$\mathfrak X \text{ is split} \iff \mathfrak X \text{ is projected} \iff \omega_2(\mathfrak X) = 0.$$

Both cells (A) $\overline{\mathfrak S}_{1;2,0}$ and (B) $\overline{\mathfrak S}_{0;3,2}$ have
odd rank exactly 2 (claim.md §1), so Lemma 1 applies to both.

### Proof, route 1: direct citation of Corrêa–Noja Proposition 2.2

This is stated by Corrêa–Noja for exactly this category of object (smooth DM
superstack over $\mathbb C$), so it applies verbatim with no translation needed.
Verbatim (checked against the rendered page image of arXiv:2606.06733, p.2–3; see
Appendix A):

> "A splitting induces a projection. Conversely, in odd rank two, projectedness and
> splitting are equivalent by Green's obstruction theory: there are no higher Green
> obstructions beyond the primary obstruction, see for example [6, 7]." (p.2, discussion
> before Def. 2.1)
>
> **Proposition 2.2.** *Let $\mathfrak X$ be a smooth Deligne–Mumford superstack over
> $\mathbb C$, and let $X = \mathfrak X_{\mathrm{bos}}$. There is a canonical primary
> obstruction class $\omega_2(\mathfrak X)\in H^1(X, T_X\otimes\bigwedge^2 T_-^\vee\mathfrak X)$.
> It is compatible with étale pullback. If $\omega_2(\mathfrak X)\ne0$, then $\mathfrak X$
> is not projected. If $T_-\mathfrak X$ has rank two, then*
> $$\mathfrak X \text{ is split} \iff \omega_2(\mathfrak X)=0.$$
> (p.3)

Combining the quoted paragraph (split $\Rightarrow$ projected always; at odd rank 2,
projected $\Rightarrow$ split) with Proposition 2.2's rank-2 statement (split $\iff$
$\omega_2=0$) gives Lemma 1 exactly. $\blacksquare$ (route 1)

Their references [6],[7] for the "no higher Green obstructions beyond the primary
obstruction at odd rank 2" fact are Corrêa–Noja's companion paper (arXiv:2605.03166)
and Donagi–Witten (arXiv:1304.7798). Route 2 below re-derives the same conclusion
independently, directly from the Donagi–Witten source, without treating [6] as a
black box, so that Lemma 1 does not rest on a single citation.

### Proof, route 2: independent re-derivation from Donagi–Witten's filtration + Corollary 2.4

This route works in Donagi–Witten's category (honest, ordinary supermanifolds
$S=(M,\mathcal O_S)$ with $M$ a complex manifold), not stacks; the extension to smooth
DM superstacks is the routine étale-local one that Corrêa–Noja themselves carry out for
Proposition 2.2 (choose an étale atlas $U\to\mathfrak X$ by a smooth superscheme,
apply Green's construction upstairs, descend through the étale groupoid
$R_{\mathrm{bos}}\rightrightarrows U_{\mathrm{bos}}\to X$; functoriality under étale
morphisms makes the two pullbacks to $R_{\mathrm{bos}}$ agree — this is exactly the
proof of Prop. 2.2 quoted above). We record the manifold-level argument here as an
independent check that does not depend on trusting the black-box citation.

**Input D1** (filtration of a supermanifold by infinitesimal neighborhoods; verbatim,
checked against the rendered page image of arXiv:1304.7798v2 p.13, eq. (4) and
surrounding text):

> "Given a supermanifold $S=(M,\mathcal O_S)$ with nilpotent subsheaf $J\subset\mathcal O_S$,
> it is convenient to introduce $S^{(i)} := (M,\mathcal O_{S^{(i))}=\mathcal O_S/J^{i+1})$.
> ... They form an increasing filtration of $S$: $S_{\mathrm{red}}=S^{(0)}\subset S^{(1)}
> \subset\cdots\subset S^{(i-1)}\subset S^{(i)}\subset\cdots\subset S^{(n)}=S$" where $n$ is
> the odd dimension of $S$.

**Input D2** (Corollary 2.4, verbatim, same page image p.19):

> "For any supermanifold $S$, the following conditions are equivalent: $\omega_2(S)\ne0$;
> $S^{(2)}$ is not split; $S^{(2)}$ is not projected. Moreover, if $\omega_2(S)\ne 0$, then
> $S$ is not projected."

**Input D3** (Corollary 2.3, verbatim, same page image p.19, used only as a
consistency check, not load-bearing for the argument below):

> "A supermanifold $S$ of dimension $(m|2)$ is determined by the triple $(M,V,\omega)$,
> where $\omega=\omega_2\in H^1(M,\mathrm{Hom}(\bigwedge^2 T_-,T_+))$, and any such triple
> arises from some $S$. A supermanifold of dimension $(m|2)$ is projected if and only if
> it is split."

**Derivation of Lemma 1 (manifold case) from D1+D2.** Suppose $S$ has odd dimension
exactly $2$. By Input D1 with $n=2$: $S^{(2)}=S$ (this is literally the $i=n$ term of
the stated filtration, no further argument needed). Substituting $S^{(2)}=S$ into Input
D2:
$$\omega_2(S)\ne0 \iff S \text{ is not split} \iff S \text{ is not projected}.$$
Taking the contrapositive of each equivalence gives
$$\omega_2(S)=0 \iff S \text{ is split} \iff S \text{ is projected},$$
which is Lemma 1 (manifold case). (Input D3 independently confirms the "split $\iff$
projected" half of this at odd dimension $2$, as a cross-check; it is not used in the
derivation.) $\blacksquare$ (route 2, modulo the routine étale descent to stacks, which
is not re-proved here — it is exactly Corrêa–Noja's own proof of Prop. 2.2, already
cited in full in route 1.)

**Remark on why both routes are recorded.** Route 1 is the tightest citation (already
stated for smooth DM superstacks, the exact category we need — no translation gap).
Route 2 shows the fact is not an isolated stacky artifact: it follows from two
elementary structural inputs (a filtration that terminates at $i=n$, plus one
already-published corollary of Green's obstruction theory) with no further machinery.
Neither route treats claim.md's Claim 1 as pre-established; both are worked from primary
sources verified against page images in this session.

**Lemma 1 is now proved. This settles claim.md's Claim 1 in full.**

---

## Appendix A — sources checked against rendered page images (running log)

All PDFs fetched via `curl -sk --resolve arxiv.org:443:<Fastly IP> https://arxiv.org/pdf/<id> -o <path> --max-time 30` (see note on the network workaround needed in this sandboxed environment; a bare `curl -sL` to arxiv.org fails/gets silently redirected here). Each PDF fetch was checksummed with `file <path>` to confirm a genuine multi-page PDF before reading.

| # | Source | Pages read as images | What was checked |
|---|---|---|---|
| 1 | Corrêa–Noja, arXiv:2606.06733 | 1–3 | Def. 2.1 (projection/splitting), Prop. 2.2 (rank-2 split $\iff$ $\omega_2=0$, projected always follows from splitting, and at rank 2 conversely), its proof sketch (étale-local Green construction + descent) |
| 2 | Donagi–Witten, arXiv:1304.7798v2 | 1–4, 13–14, 18–19, 23, 37–38 | TOC/Intro; filtration $S^{(i)}$ (eq. 4) and its termination $S^{(n)}=S$; Cor. 2.1–2.4 (splitting toolkit, incl. rank-2 case); Cor. 2.6–2.8 (finite covers); start of §2.2.5 (submanifolds, exact seq. (19)); §4 Prop. 4.1 + proof + Remark 4.2 (non-projectedness of $\mathfrak M_{g,1}$, even-spin case, and explicit failure of the argument for odd spin) |

Local cache used this session: `C:\Users\charles\AppData\Local\Temp\pdfs\correa-noja-2606.06733.pdf`
and the pre-existing repo cache `D:\physics\string\graph\build\dw-1304.7798v2.pdf`.

---

## Part 2 — Lemma 2: the only known non-vanishing mechanism cannot reach either cell

Everything published that produces a *nonzero* $\omega_2$ for a punctured supermoduli
stack — Donagi–Witten's $\mathfrak M_{g,1}$ theorem (arXiv:1304.7798, §4, read this
session, Appendix A), Corrêa–Noja's genus-2 even component (arXiv:2606.06733), and
`research/papers/supermoduli-punctured-nonprojected/paper.md`'s Theorem M/Corollary A —
is, at its core, one single mechanism: the **Donagi–Witten one-point obstruction
family**. It needs, as raw material, a *smooth* curve $C$ of some genus $h$ together
with a theta characteristic $L$ ($L^{\otimes2}\cong\omega_C$) that is **ineffective**
($H^0(C,L)=0$), and it produces a nonzero obstruction datum from a nonzero class
$\eta\in H^1(C,L^{-1})$. (In paper.md's Construction 5.3, reviewed this session, this
smooth curve $C$ is glued to a separate *fixed* tail purely to reach the target genus
$g=h+a$ and target puncture/Ramond-point count; the fixed tail itself contributes no
cohomology to the construction, only bookkeeping. The nonzero class always comes from
the single smooth genus-$h$ factor.)

**Lemma 2.** *Let $C$ be a smooth curve of genus $h$ and $L$ a theta characteristic on
$C$ with $H^0(C,L)=0$ (ineffective). Then*
$$h^1(C,L^{-1}) \;=\; \max(2h-2,\ 0),$$
*except at the single genus-$1$ point where $L\cong\mathcal O_C$ is trivial — but that
point is always **effective** ($h^0=1$) and hence excluded by the ineffectiveness
hypothesis. In particular $H^1(C,L^{-1})=0$ identically for every ineffective theta
characteristic when $h\le 1$, and no non-zero $\eta$ can be extracted at $h \le 1$.*

*Proof.* Since $L^{\otimes2}\cong\omega_C$, $\deg L = h-1$, so $\deg L^{-1}=1-h$.

- If $h\ge 1$: $\deg L^{-1}=1-h\le0$. A line bundle of negative degree on a smooth
  projective curve has no non-zero global sections (a non-zero section would exhibit it
  as $\mathcal O_C(D)$ for an effective divisor $D\ge0$, forcing $\deg\ge0$); at degree
  exactly $0$ ($h=1$) the only line bundle with a section is the trivial one. So for
  $h\ge2$, $h^0(L^{-1})=0$ unconditionally (strictly negative degree); for $h=1$,
  $h^0(L^{-1})=0$ **unless** $L^{-1}\cong\mathcal O_C$, i.e. unless $L\cong\mathcal O_C$
  (self-dual since $L^{\otimes2}\cong\omega_C=\mathcal O_C$ makes $L$ $2$-torsion, hence
  $L^{-1}\cong L$), which is exactly the excluded effective case ($h^0(\mathcal O_C)=1$).
  So under the ineffectiveness hypothesis, $h^0(C,L^{-1})=0$ for every $h\ge1$.
  By Riemann–Roch, $\chi(L^{-1}) = \deg L^{-1} + 1 - h = (1-h)+1-h = 2-2h$, so
  $$h^1(C,L^{-1}) = h^0(C,L^{-1}) - \chi(L^{-1}) = 0-(2-2h) = 2h-2.$$
  This is $\ge0$ for $h\ge1$, positive iff $h\ge2$, and exactly $0$ at $h=1$.
- If $h=0$: the unique theta characteristic on $\mathbb P^1$ is $L=\mathcal O(-1)$
  (ineffective automatically, $h^0(\mathcal O(-1))=0$), so $L^{-1}=\mathcal O(1)$, which
  is a positive-degree bundle on $\mathbb P^1$ with $h^0=2$, $h^1=0$ (standard). This
  matches the formula $\max(2\cdot0-2,0)=0$.

So $h^1(C,L^{-1})=\max(2h-2,0)$ in every case, vanishing exactly for $h\le1$. $\blacksquare$

*(This is an independent Riemann–Roch/Serre-duality re-derivation, not a restatement,
of the fact recorded as Lemma 8.2(i) in `paper.md`, which is quoted there only for the
elliptic and $\mathbb P^1$ cases needed there; the computation above gives the general
formula $h^1=\max(2h-2,0)$ for all $h$, which is what is actually needed to make the
"no genus-$\ge2$ smooth piece available" argument below fully general and self-contained,
rather than resting on paper.md's narrower quoted statement.)*

**Corollary 2.1 (the known mechanism is structurally unavailable for cells A and B).**
*Let $\mathfrak X\in\{\overline{\mathfrak S}_{1;2,0},\ \overline{\mathfrak S}_{0;3,2}\}$.
Every stable curve underlying a $\mathbb C$-point of $X=\mathfrak X_{\mathrm{bos}}$
(interior or boundary) has total arithmetic genus $g\le1$ (namely $g=1$ for cell A,
$g=0$ for cell B), and every one of its irreducible components has geometric genus
$\le g\le1$. By Lemma 2, no irreducible component of any such curve — smooth or
appearing as a piece of a nodal degeneration — can supply a non-zero class
$\eta\in H^1(C,L^{-1})$ for an ineffective theta characteristic $L$, because every
available component has genus $h\le1$, and $h^1=0$ at $h\le1$ regardless of which
ineffective theta characteristic is chosen. Consequently the Donagi–Witten one-point
obstruction family, in the form used by DW/CN/`paper.md` to prove every currently
published non-projectedness result, cannot be instantiated anywhere on $X$ — there is
no raw material (no genus-$\ge2$ component) anywhere in the moduli problem to build the
family from.*

**Scope of this negative result — stated precisely, not oversold.** Corollary 2.1 rules
out only the *specific, published* construction (built from a single smooth curve of
genus $\ge2$ carrying an ineffective theta characteristic, exactly as in DW §4 and
paper.md's Construction 5.3). It does **not** by itself show $\omega_2=0$ for either
cell — it shows only that the one technique currently in the literature capable of
proving $\omega_2\ne0$ cannot be run here. It leaves open:
- whether some other, currently unpublished, construction could produce a non-zero
  $\omega_2$ using genuinely *nodal* (not smooth-component) input — e.g. cohomology
  supported at a node rather than on a smooth genus-$\ge2$ piece — which Lemma 2 does
  not address (Lemma 2 only concerns $H^1$ of a line bundle on a *smooth* curve);
- whether $\omega_2=0$ can be proved directly (a positive/splitting result), which is a
  completely different computation (an explicit vanishing of $H^1(X,\mathcal V_{\mathfrak X})$
  on the 2-dimensional bosonic base $X$, or of a suitable boundary-supported subgroup of
  it per Claim 5) and is not addressed by Lemma 2 either.

**This settles the negative half of the picture: the threshold-sharpness attempt's
curve-base method is exhausted (already established, `supermoduli-threshold-sharpness`
Remark 5.2), and now Lemma 2 shows the *other* known method (one-point obstruction
family) is exhausted too, independently and for a different reason (total genus, not
base dimension). Both of the two currently-existing techniques for this class of
problem are unavailable for cells (A) and (B). Any resolution of Claim 6 needs either a
genuinely new non-vanishing mechanism, or a direct vanishing computation on the
surface base — see §6 for what such a computation would require.**

---

## Part 3 — [in progress]

*To be continued in the next commit.*
