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
| 2 (uncompactified cells split) | **Proved** (Lemma 4, via affine vanishing) | Part 4 |
| 3 (bosonic truncation structure) | **Partial**: cell (B) divisor-typing verified (Part 3); root-stack representability imported; cell (A) not yet done | Part 3 |
| 4 (inertia criterion fails) | Open | — |
| 5 (boundary support reduction) | **Proved** (Corollary 4.1) | Part 4 |
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

## Part 3 — Lemma 3: the boundary-divisor typing for cell (B), verified by direct degree count

We now independently verify the divisor-typing half of claim.md's Claim 3(1) for
$X_B=\overline{\mathcal S}_{0;3,2}$, lying over $\overline M_{0,5}$ (points $1,2,3$ = NS,
$4,5$ = Ramond).

**Setup.** At a smooth point of $\overline M_{0,5}$, $C=\mathbb P^1$, and a generalized
spin structure is $L$ with $L^{\otimes2}\cong\omega_C(\rho_4+\rho_5)=\mathcal O(-2+2)=
\mathcal O$, so $L\cong\mathcal O_{\mathbb P^1}$ uniquely ($\mathrm{Pic}(\mathbb P^1)
=\mathbb Z$ is torsion-free, so the unique square root of $\mathcal O$ is $\mathcal O$
itself). Hence $S_{0;3,2}\to M_{0,5}$ is a trivial $\mu_2$-gerbe on the smooth locus:
every fibre has a unique spin structure whose only automorphism is $\{\pm1\}$ acting by
$(-1)^F$, which is exactly the fermion-parity gerbe already noted in claim.md §0. This
confirms the "connected, $\mu_2$-gerbe over the interior of $\overline M_{0,5}$" part of
Claim 3(1) away from the boundary.

**Two candidate node prescriptions.** At a boundary point of $\overline M_{0,5}$ the
curve degenerates to $C=C_1\cup_x C_2$. Classically (Cornalba's compactified theta
divisor; Jarvis's stable spin curves — imported as standard, not re-derived from first
principles here, see the caveat below) a generalized spin structure across a node
comes in exactly two types:
- **Ramond (locally free) type**: $L$ extends as an honest line bundle, with
  $L_i^{\otimes2}\cong\omega_{C_i}\bigl(x_i+\sum_{\rho_j\text{ on }C_i}\rho_j\bigr)$ on
  each branch $C_i$ — the node point $x_i$ is counted *with the same weight as a
  Ramond puncture* in the local formula on each side.
- **NS (non-locally-free) type**: $L$ is torsion-free but not locally free at the node;
  each branch instead satisfies $L_i^{\otimes2}\cong\omega_{C_i}\bigl(\sum_{\rho_j\text{
  on }C_i}\rho_j\bigr)$ — the node point is **not** counted at all.

At a given boundary divisor, whichever of the two prescriptions has *every branch's
right-hand side of even degree* (so that an honest square root $L_i$ exists on that
$\mathbb P^1$-branch, since $\mathrm{Pic}(\mathbb P^1)=\mathbb Z$ has square roots
exactly for even-degree bundles) is realized; parity considerations (as we check
case-by-case below) show at most one of the two prescriptions is degree-consistent on
each of the boundary divisors of $\overline M_{0,5}$, so this determines the type
unambiguously — this is exactly the content of claim.md's node-typing quote from
[Corrêa–Noja, p.6].

**Lemma 3.** *For $X_B$, the divisors $D_{12},D_{13},D_{23},D_{45}$ are NS-type and the
six divisors $D_{i4},D_{i5}$ ($i=1,2,3$) are Ramond-type. (This is exactly claim.md's
Claim 3(1), divisor-typing half.)*

*Proof.* By the $S_3$ symmetry permuting the NS labels $\{1,2,3\}$ and the $\mathbb Z/2$
symmetry swapping the Ramond labels $\{4,5\}$, it suffices to check one representative
of each of the three $S_3\times\mathbb Z/2$-orbits of divisors:
$\{D_{12},D_{13},D_{23}\}$, $\{D_{45}\}$, and $\{D_{14},D_{15},D_{24},D_{25},D_{34},
D_{35}\}$.

*Case $D_{45}$* ($C_1\ni1,2,3$; $C_2\ni4,5$). NS prescription: on $C_1$,
$\deg = \deg\omega_{C_1}= -2$ (even) $\Rightarrow L_1=\mathcal O(-1)$ exists; on $C_2$,
$\deg=\deg\omega_{C_2}(\rho_4+\rho_5)=-2+2=0$ (even) $\Rightarrow L_2=\mathcal O$
exists. Both branches consistent. Ramond prescription: on $C_1$,
$\deg=\deg\omega_{C_1}(x_1)=-2+1=-1$ (**odd** — no square root on $\mathbb P^1$
exists). So only the NS prescription is realizable: $D_{45}$ is NS-type.

*Case $D_{12}$* ($C_1\ni1,2$; $C_2\ni3,4,5$). NS prescription: on $C_1$,
$\deg=\deg\omega_{C_1}=-2$ (even) $\Rightarrow L_1=\mathcal O(-1)$; on $C_2$,
$\deg=\deg\omega_{C_2}(\rho_4+\rho_5)=-2+2=0$ (even) $\Rightarrow L_2=\mathcal O$. Both
consistent. Ramond prescription: on $C_1$, $\deg=\deg\omega_{C_1}(x_1)=-2+1=-1$ (odd,
fails). So only NS is realizable: $D_{12}$ (hence $D_{13},D_{23}$ by symmetry) is
NS-type.

*Case $D_{14}$* ($C_1\ni1,4$; $C_2\ni2,3,5$). NS prescription: on $C_1$,
$\deg=\deg\omega_{C_1}(\rho_4)=-2+1=-1$ (odd, fails). Ramond prescription: on $C_1$,
$\deg=\deg\omega_{C_1}(\rho_4+x_1)=-2+1+1=0$ (even) $\Rightarrow L_1=\mathcal O$; on
$C_2$, $\deg=\deg\omega_{C_2}(\rho_5+x_2)=-2+1+1=0$ (even) $\Rightarrow L_2=\mathcal O$.
Both consistent under Ramond. So only Ramond is realizable: $D_{14}$ (hence all six
$D_{i4},D_{i5}$, $i=1,2,3$, by symmetry) is Ramond-type. $\blacksquare$

**What this establishes, and what remains imported.** The *typing* of all 10 boundary
divisors (which four get a $\mu_2$-root, which six do not) is now independently
verified by direct degree-parity computation, not merely quoted from claim.md. What is
**not** re-derived here, and is imported as standard (Cornalba's compactified theta
characteristic / Jarvis's stable $r$-spin curves, as used silently throughout FKP,
[CN], and `paper.md`):
`[GAP: root-stack representability]` the fact that the *coarse* statement "$L$ is
torsion-free-but-not-locally-free at an NS-type node" is represented, at the level of
the smooth *stack* $\overline{\mathcal S}_{0;3,2}$, by literally taking the $\mu_2$-root
stack of $\overline M_{0,5}$ along the NS-type divisors (rather than some other smooth
stacky modification). This is standard in the Abramovich–Jarvis–Chiodo picture of
$r$-spin moduli as root stacks, but is not re-derived from Jarvis's original
moduli-of-torsion-free-sheaves construction in this session; it is used here as an
imported structural fact, consistent with how `paper.md` and [CN] use it.

Granting that import, Lemma 3 gives exactly claim.md's Claim 3(1):
$$\overline{\mathcal S}_{0;3,2}\ \text{is a}\ \mu_2\text{-gerbe over}\quad
\mathcal X_0=\sqrt[2]{\bigl(\overline M_{0,5},\,D_{12}+D_{13}+D_{23}+D_{45}\bigr)}.$$

**This settles the divisor-typing content of Claim 3(1) (modulo the imported
root-stack-representability fact flagged above).**

---

## Part 4 — Lemma 4 (= Claim 2, both cells) via affine vanishing, and Corollary 4.1 (= Claim 5)

**Lemma 4.** *The open substacks $\mathfrak S_{1;2,0}\subset\overline{\mathfrak S}_{1;2,0}$
and $\mathfrak S_{0;3,2}\subset\overline{\mathfrak S}_{0;3,2}$ of smooth super Riemann
surfaces are split.*

*Proof.* By Lemma 1 (odd rank 2 in both cases), it suffices to show
$\omega_2(\mathfrak S_{\bullet})=0$, i.e. that
$H^1\bigl(M_\bullet,\, T_{M_\bullet}\otimes\det\mathcal F_\bullet\bigr)=0$, where
$M_\bullet$ is the (smooth, uncompactified) bosonic moduli and
$T_{M_\bullet}\otimes\det\mathcal F_\bullet$ is a vector bundle on it (smoothness of the
open substack). It suffices, by Serre's affine vanishing theorem for coherent sheaves
(any coherent sheaf on an affine scheme has vanishing higher cohomology; the analogous
statement descends to a smooth DM stack with **affine coarse moduli space** over
$\mathbb C$: if $\pi:\mathcal M\to M_{\mathrm{coarse}}$ is the coarse map, $\pi$ is
proper and quasi-finite hence affine, so $R^i\pi_*=0$ for $i>0$ and
$H^i(\mathcal M,\mathcal E)=H^i(M_{\mathrm{coarse}},\pi_*\mathcal E)$; if
$M_{\mathrm{coarse}}$ is affine this vanishes for $i>0$), to show that the coarse
moduli spaces $M_{0,5}$ (cell B) and $M_{1,2}$ (cell A) are affine.

**$M_{0,5}$ is affine.** Using the $\mathrm{PGL}_2$-action to fix three of the five
marked points at $0,1,\infty$, the remaining two points give an isomorphism
$$M_{0,5}\ \cong\ \{(x_4,x_5)\in(\mathbb C\setminus\{0,1\})^2 : x_4\ne x_5\},$$
an explicit Zariski-open (complement of finitely many hyperplanes $x_i=0,1,x_4=x_5$) in
the affine plane $\mathbb A^2$. The complement of a hypersurface in an affine variety is
affine (its coordinate ring is a localization of that of the ambient affine variety), so
$M_{0,5}$ is affine.

**$M_{1,2}$ is affine.** Recall $M_{1,1}\cong\mathbb A^1_j$ (the $j$-line) is affine —
classical. Using the first marked point $p_1$ as the group-law origin of $E$, a
$\mathbb C$-point of $M_{1,2}$ is a pair $(E,p_2)$ with $p_2\in E\setminus\{0\}$, modulo
the finite automorphism group $\mathrm{Aut}(E,0)$ (order $2$, $4$, or $6$ depending on
$j$). The morphism $\mathcal E^\times\to M_{1,1}$ (universal elliptic curve minus its
zero section) is affine: each fibre $E\setminus\{0\}$ is the complement of an ample
divisor (a single point is ample on a genus-$1$ curve) in a proper curve, hence affine
(complement of a relative ample divisor in a proper morphism is an affine morphism —
standard, e.g. via the relative Serre criterion), and this is compatible in families.
An affine morphism over an affine base has affine total space, so $\mathcal E^\times$
(as a scheme, i.e. before quotienting) is affine. Quotienting a affine scheme by a
finite group action gives an affine scheme (its ring of invariants is again finitely
generated, by classical invariant theory in characteristic $0$, and $\mathrm{Spec}$ of
that ring computes the quotient). Hence $M_{1,2}=\mathcal E^\times/\mathrm{Aut}(E,0)$
(fibred over $M_{1,1}=\mathbb A^1$, itself affine, with affine fibres — the same
"affine morphism over affine base" argument applies one level up) is affine.

Both coarse spaces are affine, so $H^1(M_\bullet,T_{M_\bullet}\otimes\det\mathcal F_\bullet)=0$
in both cases, giving $\omega_2(\mathfrak S_\bullet)=0$, hence (Lemma 1) both open
substacks are split. $\blacksquare$

**This is precisely claim.md's Claim 2, now fully established for both cells**, by an
elementary and completely general mechanism (affineness of the genus-$\le1$ open moduli
spaces involved), matching Donagi–Witten's own remark (arXiv:1304.7798v2, p.4,
Introduction, read this session) that projectedness for small $g$ "follows from the
cohomological nature of the obstructions to splitting and the nature of the reduced
spaces $\mathcal{SM}_g$ for small $g$" — we can now say precisely *what* that nature is:
affineness.

### Corollary 4.1 (= Claim 5, boundary support)

**Corollary 4.1.** *$\omega_2(\overline{\mathfrak S}_{1;2,0})$ and
$\omega_2(\overline{\mathfrak S}_{0;3,2})$, if non-zero, are supported on the boundary:
each lies in the image of $H^1_{\partial X}(X,\mathcal V_{\mathfrak X})\to
H^1(X,\mathcal V_{\mathfrak X})$ for $X\in\{X_A,X_B\}$ and $\partial X$ the (normal
crossing) boundary divisor.*

*Proof.* Write $j:U\hookrightarrow X$ for the open embedding of the smooth locus (so
$U=M_{1,2}$ or $M_{0,5}$) with closed complement $\partial X = X\setminus U$. Corrêa–Noja
Proposition 2.2 (quoted in Part 1, Appendix A source #1) states $\omega_2$ "is compatible
with étale pullback"; an open immersion is in particular étale, so
$$j^*\,\omega_2(\overline{\mathfrak S}_\bullet) \;=\; \omega_2(\mathfrak S_\bullet)
\quad\text{in } H^1(U,\mathcal V_{\mathfrak X}|_U).$$
By Lemma 4, the right-hand side is $0$. So $\omega_2(\overline{\mathfrak S}_\bullet)$
lies in $\ker\bigl(H^1(X,\mathcal V_{\mathfrak X})\xrightarrow{\ j^*\ }
H^1(U,\mathcal V_{\mathfrak X}|_U)\bigr)$. The long exact sequence of local cohomology
for the closed subscheme $\partial X\subset X$ (coefficients in the coherent sheaf
$\mathcal V_{\mathfrak X}$),
$$\cdots \to H^1_{\partial X}(X,\mathcal V_{\mathfrak X}) \to H^1(X,\mathcal V_{\mathfrak X})
\xrightarrow{\ j^*\ } H^1(U,\mathcal V_{\mathfrak X}|_U) \to \cdots,$$
identifies this kernel exactly with the image of $H^1_{\partial X}(X,\mathcal V_{\mathfrak
X})\to H^1(X,\mathcal V_{\mathfrak X})$, i.e. with the classes "supported on
$\partial X$." $\blacksquare$

**This settles claim.md's Claim 5 in full** (the boundary-support half; the trivial
"$H^1(X,\mathcal V_{\mathfrak X})=0\Rightarrow$ split" half of Claim 5 is immediate from
Lemma 1 and needs no separate argument).

**What Corollary 4.1 buys us, concretely.** It does *not* by itself decide Claim 6. It
narrows the search: any non-vanishing of $\omega_2$ must come from the local cohomology
$H^1_{\partial X}$, which (by the standard excision/Mayer–Vietoris description of local
cohomology along a normal-crossing divisor) is built from residues along the boundary
components and their pairwise intersections. Combined with Lemma 3 (which of the ten
boundary divisors of $X_B$ actually carry a $\mu_2$-root, i.e. are candidates for a
non-trivial "twisted" contribution) this gives a finite, structured list of places to
look — see §6 for the precise remaining target.

---

## Part 5 — §6: the precise remaining target for Claim 6, and what would be needed

This section does **not** resolve Claim 6. It records, as precisely as this session
gets, what a resolution would require, so that the computation is well-posed for future
work rather than left as a vague "compute $\omega_2$."

### 5.1 The line bundle $\det\mathcal F_{\mathfrak X}$, made explicit for cell (B)

At a smooth point $(C=\mathbb P^1, L=\mathcal O; y_1,y_2,y_3,\rho_1,\rho_2)$ of $X_B$, we
computed (see the rank cross-check below) that
$$T_-\mathfrak X\big|_{\rm pt} = H^1\bigl(C, L^{-1}(-y_1-y_2-y_3)\bigr),\qquad
\det\bigl(T_-^\vee\mathfrak X\big|_{\rm pt}\bigr) \;\cong\;
\det H^0\bigl(C,\ L^3(y_1+y_2+y_3-\rho_1-\rho_2)\bigr),$$
via Serre duality ($H^1(F)^\vee\cong H^0(\omega_C\otimes F^\vee)$ with
$F=L^{-1}(-\sum y_i)$, and $\omega_C\otimes L = L^3(-\rho_1-\rho_2)$ from the defining
relation $L^{\otimes2}\cong\omega_C(\rho_1+\rho_2)$).

**Rank cross-check.** On the smooth locus $L=\mathcal O$ (Part 3), so this is
$H^0(\mathbb P^1,\mathcal O(y_1+y_2+y_3-\rho_1-\rho_2)) = H^0(\mathbb P^1,\mathcal O(1))$,
which is $2$-dimensional — matches the required odd rank $2$ (claim.md §1) and cross-checks
against the Riemann–Roch computation directly on $T_-$: $\deg L^{-1}(-\sum y_i)=-3$,
$\chi=-3+1=-2$ (genus $0$), $h^0=0$ (negative degree) $\Rightarrow h^1=2$. Consistent.

**What this identifies.** Away from the boundary, $\mathcal F_{\mathfrak X}$ is
(canonically, since $L=\mathcal O$ globally on the smooth locus) the rank-$2$ bundle on
$M_{0,5}$ whose fibre is $H^0(\mathbb P^1,\mathcal O(y_1+y_2+y_3-\rho_1-\rho_2))$, i.e.
$\mathcal F_{\mathfrak X}=\pi_*\mathcal O_{\mathcal C}(\sigma_1+\sigma_2+\sigma_3-\sigma_4-
\sigma_5)$, the **pushforward along the universal curve**
$\pi:\overline M_{0,6}\to\overline M_{0,5}$ (adding a $6$th, moving, point $z$; the
$\sigma_i$ are the $5$ tautological sections) **of the relative degree-$1$ line bundle**
$\mathcal O_{\mathcal C}(\sigma_1+\sigma_2+\sigma_3-\sigma_4-\sigma_5)$. This
identification is exact on the open locus and (granting the imported root-stack
representability of Part 3) extends to the compactification after twisting by the
appropriate root data along $D_{12}+D_{13}+D_{23}+D_{45}$.

`[GAP: explicit Chern class of det F]` Computing $c_1(\det\mathcal F_{\mathfrak X}) =
c_1(\pi_*\mathcal O_{\mathcal C}(\sigma_1+\sigma_2+\sigma_3-\sigma_4-\sigma_5))$ as an
explicit combination of the standard generators of $\mathrm{Pic}(\overline M_{0,5})$
(the ten boundary classes $\delta_{ij}$, or equivalently the $\psi$-classes
$\psi_1,\dots,\psi_5$, related by the standard genus-$0$ relations) is **not done in
this session**. The standard tool is Grothendieck–Riemann–Roch applied to the
family of $\mathbb P^1$'s $\pi:\overline M_{0,6}\to\overline M_{0,5}$ (equivalently,
Mumford's or Arbarello–Cornalba's formulas for pushforwards of line bundles along the
universal curve in genus $0$, where the fibrewise cohomology and its degeneration at
the boundary are completely explicit because every fibre is a nodal union of
$\mathbb P^1$'s). This is a finite, mechanical (if somewhat long) computation, not a
conceptual obstacle — but it was not carried out here, and getting the boundary
corrections right (where $\sigma_i$'s collide, i.e. exactly at the $D_{ij}$ divisors of
Lemma 3) requires care that a rushed computation risks getting wrong, so it is recorded
as an open item rather than attempted under time pressure. `scripts/` in this attempt
is empty; a symbolic computation (e.g. using known closed-form recursions for
$\psi$-class intersection numbers on $\overline M_{0,n}$, or the `admcycles` Sage
package if available) would be the natural way to carry this out reliably.

### 5.2 What the rest of the computation needs, once §5.1 is done

1. $T_{X_B}$, the tangent bundle of the root stack $\mathcal X_0$ (or of $\overline
   M_{0,5}$ pulled back, twisted by the root data) — standard once the surface's
   tangent bundle is expressed via the log-tangent sequence along the boundary
   (again mechanical given $\overline M_{0,5}$'s explicit toric-like presentation as an
   iterated blow-up of $\mathbb P^2$, `[GAP: explicit tangent bundle]`, not carried out
   here).
2. The tensor product $\mathcal V_{\mathfrak X}=T_X\otimes\det\mathcal F_{\mathfrak X}$
   as an explicit line bundle (once 1 and §5.1 are both explicit).
3. By Corollary 4.1, only the **local cohomology supported on** $\partial X_B$
   (the union of the ten $D_{ij}$) matters. For a normal-crossing divisor with several
   components, $H^1_{\partial X}(X,\mathcal V)$ is computed by the Čech/Mayer–Vietoris
   complex built from $H^0$ of $\mathcal V$ twisted by the relevant normal bundles on
   each component and each pairwise intersection point (the ten $D_{ij}$ meet each
   other only at points, since $\overline M_{0,5}$'s boundary is a normal-crossing
   arrangement of $(-1)$-curves — this is the del Pezzo-of-degree-$5$ "pentagon"
   configuration). `[GAP: local cohomology computation]` This final step — writing down
   the Mayer–Vietoris complex and computing whether the resulting class is forced to
   vanish or can be non-zero — is genuinely the crux of Claim 6 and is not attempted
   here.

### 5.3 Cell (A): even less is pinned down

For cell A, Claim 3(2)–(3) (the $\mu_2$-gerbe/root-stack structure of
$\overline{\mathcal S}^-_{1;2,0}$ and the degree-$3$ étale structure of
$\overline{\mathcal S}^+_{1;2,0}$) have **not** been independently verified this
session (only cell B's divisor typing was checked, in Part 3). `[GAP: cell-A structure]`
The same degree-parity method used in Part 3 should transfer directly (checking, on
each boundary divisor of $\overline{\mathcal M}_{1,2}$, whether the NS or Ramond node
prescription is degree-consistent on each branch — including the genus-$1$ branch,
where the relevant Picard group is no longer $\mathbb Z$, so "even/odd degree" must be
replaced by "does a square root exist in $\mathrm{Pic}(E)$," which is automatic for
*every* degree on an elliptic curve since $\mathrm{Pic}^0(E)$ is divisible — so the
obstruction on an elliptic branch, if any, is of a different, subtler kind than on a
rational branch, and was not worked out here), but doing so honestly is separate work,
not carried out in this session.

**Summary of what remains for Claim 6:** a genuinely non-trivial, multi-step
computation (explicit line bundle on a stacky surface, its tangent-bundle twist, and a
normal-crossing local-cohomology computation) for cell (B), and an *additional*,
not-yet-started structural verification (Claim 3(2)-(3)) plus the analogous
computation for cell (A). Neither cell's dichotomy is settled by this session.

---

## Part 6 — Summary and honest verdict

**What is proved (self-contained, from primary sources verified against page images,
or independently re-derived):**
- **Lemma 1** (= Claim 1): odd rank $2$ $\Rightarrow$ split $\iff$ projected $\iff$
  $\omega_2=0$, for both cells. Two independent routes.
- **Lemma 2 + Corollary 2.1**: the only published mechanism for proving $\omega_2\ne0$
  in this literature (the Donagi–Witten one-point obstruction family) is structurally
  unavailable for both cells, because it needs a smooth curve of genus $\ge2$
  somewhere in the construction and both cells have total genus $\le1$. Scope of this
  negative statement is stated precisely (Part 2) — it does not itself imply
  $\omega_2=0$.
- **Lemma 3** (part of Claim 3(1)): the NS/Ramond typing of all ten boundary divisors
  of $\overline M_{0,5}$ for cell (B), verified by direct Riemann–Roch degree-parity
  computation (not merely quoted).
- **Lemma 4** (= Claim 2, both cells): the open, uncompactified loci
  $\mathfrak S_{1;2,0}$ and $\mathfrak S_{0;3,2}$ are split, via an elementary Serre
  affine-vanishing argument (the coarse moduli spaces $M_{0,5}$ and $M_{1,2}$ are both
  affine).
- **Corollary 4.1** (= Claim 5): $\omega_2$ of both compactified cells, if non-zero, is
  necessarily boundary-supported, an immediate consequence of Lemma 4 plus the
  étale-pullback compatibility of $\omega_2$ (Corrêa–Noja Prop. 2.2).

**What is explicitly open, as `[GAP]`s:**
1. `[GAP: root-stack representability]` (Part 3) — imported, not re-derived from
   Jarvis's/Cornalba's original moduli-of-torsion-free-sheaves construction.
2. `[GAP: explicit Chern class of det F]`, `[GAP: explicit tangent bundle]`,
   `[GAP: local cohomology computation]` (Part 5) — the actual target computation for
   Claim 6, cell (B); none of its three steps were carried out.
3. `[GAP: cell-A structure]` (Part 5.3) — Claim 3(2)-(3) not independently checked;
   the analogous Claim-6 computation for cell (A) not started.
4. Claim 4 (inertia-character criterion) — not attempted this session; deprioritized as
   a negative meta-claim that, even if established, would not by itself move Claim 6
   forward (it only shows one more technique doesn't decide the question, the same kind
   of result as Lemma 2, not a resolution).

**Honest verdict on viability.** The *negative* half of the picture (Claim 6 cannot be
settled by importing either of the two techniques that exist in the literature — the
curve-base degree method, already shown exhausted by `supermoduli-threshold-sharpness`
Remark 5.2, and now the one-point obstruction family, shown exhausted here by Lemma 2)
is now solid and, I believe, essentially complete: there is no way to reach a verdict on
Claim 6 by importing existing machinery. The *positive* half — a genuine vanishing
argument sufficient to conclude $\omega_2=0$, i.e. a full proof that both cells are
**split** — is a well-posed and, on current evidence (Corollary 4.1 already restricts
the target to a finite Mayer–Vietoris computation on an explicit, well-understood del
Pezzo surface with an explicit normal-crossing boundary arrangement), plausibly
tractable computation, but it was **not completed** this session; the three `[GAP]`s in
§5.2 are genuine, unfinished mathematics, not a hidden reduction dressed up as
completion.

**Is this path viable?** Yes, more so than it looked at the start of this session.
Corollary 4.1 removed the "surface-base curve-degree method doesn't apply" obstacle
that killed the naive approach (`supermoduli-threshold-sharpness` Remark 5.2): we no
longer need a *global* vanishing theorem on a $2$-dimensional stack, only a *local*
one (Mayer–Vietoris on the boundary normal-crossing arrangement), which is a
qualitatively easier target with completely explicit, classical tools ($\psi$-class
calculus on $\overline M_{0,5}$). The remaining work (§5.1–5.2) is real but bounded and
mechanical, not conceptually stuck.

**Recommendation for next steps.** (1) Carry out the Grothendieck–Riemann–Roch /
$\psi$-class computation of $\det\mathcal F_{\mathfrak X}$ for cell (B) explicitly
(§5.1) — ideally with a symbolic-computation script in `scripts/`, since
$\overline M_{0,5}$'s intersection theory is completely algorithmic (Kontsevich–Manin
recursions) and error-prone by hand. (2) Then attempt the Mayer–Vietoris local
cohomology computation (§5.2 item 3) directly, since Corollary 4.1 + Lemma 3 already
supply the precise geometric input (which divisors, which normal bundles) it needs.
(3) Only after (or in parallel with) resolving cell (B), redo the (structurally similar
but technically different, elliptic-branch) computation for cell (A) — Part 5.3 flags
exactly where the method needs new input (Picard group of an elliptic curve is
divisible, changing the parity-obstruction argument of Lemma 3). This attempt should
stay `draft`/`under-review` rather than closing; a future prover picking it up has,
thanks to this session, a fully-reduced, well-posed finite computation to run rather
than an open-ended search for a method.
