# claim.md — Does Theorem M have a consequence for the superstring perturbation-theory measure?

**Object under study**: Theorem M of `research/papers/supermoduli-punctured-nonprojected/paper.md`
(a draft, unsubmitted paper; `captain_confirmed: false`). This file does **not** modify that paper
and does not decide whether it should be merged with anything; it answers a separate question about
its *physical* consequences, asked directly by the dispatching lead.

Recap of Theorem M (paper.md, boxed corollary, line 97), quantifiers exactly as printed there:

> $\overline{\mathfrak S}_{g;n,2r}$ is non-projected whenever $g\ge3$, or ($g=2$ and $n+2r\ge2$).

where $\overline{\mathfrak S}_{g;n,2r}$ is the Deligne–Mumford-type **compactified** supermoduli
stack of stable supercurves of genus $g$ with $n$ NS punctures and $2r$ Ramond punctures (FKP
convention). "Non-projected" means: the closed embedding of the bosonic truncation
$X=\overline{\mathfrak S}_{g;n,2r,{\rm bos}}$ into $\overline{\mathfrak S}_{g;n,2r}$ admits **no**
retraction $\overline{\mathfrak S}_{g;n,2r}\to X$.

---

## The question asked

*Does Theorem M have any consequence — positive, negative, or a precisely-bounded "neither" — for
the measure used in superstring perturbation theory to compute scattering amplitudes?* If yes, state
it with pinned-down quantifiers. If it is weak/conditional, say so up front. If there is no honest
consequence, explain why in one page and stop.

A mandatory self-check was specified by the dispatching lead: check whether **already-completed**
explicit low-genus external-line amplitude computations (D'Hoker–Phong's genus-2 program was named
as the example) fall inside the quantifier range of whatever consequence statement is produced. If
they do and the computations succeeded, the statement is wrong or too loose and must be rewritten.
If they fall outside the range, the reason why is likely the most valuable part of the deliverable.

---

## Proposition C (the consequence, stated precisely)

Fix $g\ge2$ and consider the use of $\overline{\mathfrak S}_{g;n,2r}$ (or the corresponding
uncompactified locus $\mathfrak S_{g;n,2r}\subset\overline{\mathfrak S}_{g;n,2r}$) as the domain of
integration for a genus-$g$, $(n,r)$-point superstring scattering amplitude in the RNS formalism, in
the sense of Witten's rigorous construction (arXiv:1209.5461, arXiv:1304.2832).

**(C1) Safety part — rigorous, elementary.** Let $U\subset X$ be *any* open subset of the bosonic
truncation and $\mathfrak U\subset\overline{\mathfrak S}_{g;n,2r}$ the corresponding open substack
(in particular $U$ may be the smooth interior locus $\mathfrak S_{g;n,2r,{\rm bos}}$, or any single
coordinate patch used in a local slice construction). If $\overline{\mathfrak S}_{g;n,2r}$ is
projected, then $\mathfrak U$ is projected. Equivalently: **non-projectedness of the compactified
stack (Theorem M) does not imply non-projectedness of the open substack $\mathfrak U$
— in particular of the smooth locus $\mathfrak S_{g;n,2r}$.** It therefore cannot
obstruct, contradict, or even bear on, any amplitude computation that is carried out by local
patch-based methods on the smooth locus (Witten's local-slice construction; the PCO-side
systematisation of the gluing is the "vertical integration" of Sen–Witten, arXiv:1504.00609, not
of [EW]), including every completed
low-genus computation that exploits local or even global projectedness of the *uncompactified* locus.

**(C2) Bite part — narrow, and about a hypothetical strategy, not an actual method in use.** Theorem M
does rigorously rule out one specific strategy for treating the *full* compactified moduli space
(needed to correctly handle degeneration/boundary behaviour, i.e. IR effects, in Witten's rigorous
treatment): the existence of a single global holomorphic retraction
$\overline{\mathfrak S}_{g;n,2r}\to\overline{\mathfrak S}_{g;n,2r,{\rm bos}}$ valid simultaneously on
the interior and every boundary stratum, for **every** $g\ge3$ (any $n,r$) and for $g=2$ whenever
$n+2r\ge2$ — in particular already at the lowest amplitude-relevant genus $g=2$ with as few as $2$
NS punctures, or with any nonzero number of Ramond punctures. We are aware of no completed rigorous
construction of
the superstring measure that has used or needed such a global compactified projection (see
argument.md §3); the content of (C2) is that it could not have, even in principle, in this regime.

**Epistemic status**: (C1) is a rigorous mathematical fact (elementary sheaf theory) once Theorem M
and the standard definitions of projected/split are granted; the mandatory self-check below shows it
is consistent with, and required by, Donagi–Witten's own Remark 1.4. (C2) is a correct but
deliberately modest mathematical corollary of Theorem M; its *physical* framing — "this closes off a
hypothetical shortcut" — is a `physical-argument`-level interpretive claim, not a theorem, and is
labelled as such throughout argument.md.

---

## The mandatory self-check (see argument.md §3 for the full execution)

Question: do D'Hoker–Phong's completed genus-2 computations
(Papers I–IV, hep-th/0110247/0110283/0111016/0111040, 2001–2002: chiral measure, vacuum amplitude,
1-/2-/3-point vanishing for even spin structure; Papers V–VI, hep-th/0501196/0501197, 2005: general
$N$-point gauge-slice independence and the explicit four-graviton amplitude) fall inside Theorem M's
quantifier range $g=2,\ n+2r\ge2$?

**Answer: partially yes, numerically.** $(g,n,r)=(2,4,0)$ (the four-point computation of Papers
V–VI) satisfies $n+2r=4\ge2$ and is directly inside Theorem M's own new reach (Corollary A2 of
paper.md: $g=2,\ n\ge2$, even component). The $(g,n,r)=(2,0,0)$ vacuum case is outside Theorem M's own
direct reach ($n+2r=0<2$) but is covered by the *predecessor* theorem [CN, Thm 1.1(2)] already cited
in paper.md's own comparison table, which proves the even-component compactified $g=2$ stack
non-projected already without punctures.

**Resolution**: D'Hoker–Phong's construction operates on the **uncompactified** supermoduli locus
(they build a slice-independent measure on the smooth locus and separately verify correct degeneration
behaviour at the boundary; they do not construct or use a global retraction of the *compactified*
stack). By (C1), Theorem M's compactified non-projectedness says nothing about that locus. This is
independently confirmed, verbatim, by (i) Donagi–Witten's own Remark 1.4 ("asking for the
compactification to be projected would only be a stronger condition"), already `L1`-verified in this
project at `literature/extractions/witten-2012-superstring-perturbation.md:601-604`, and (ii) Witten's
own attribution of D'Hoker–Phong's method to exploiting projectedness of the *uncompactified* locus
"in low orders" (`literature/extractions/witten-2012-superstring-perturbation.md:267-280`, `L1`).
**No rewrite of Proposition C was required by this check** — full execution and the reasoning for why
D'Hoker–Phong's success does not fall inside (C2)'s bite is in argument.md §3.

---

## Verdict recorded here in one line

**Outcome type 2** (real but narrow/conditional consequence): see `status.yaml` and the final report.
