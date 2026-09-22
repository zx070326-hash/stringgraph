# Pre-submission notes for the captain

**Subject**: `research/papers/supermoduli-punctured-nonprojected/paper.md`
**Source attempt**: `research/attempts/supermoduli-elliptic-tail-punctured/` (`state: verified`,
two adversarial graph-reviewer rounds: 2026-09-18 lead-dispatched, 2026-09-20 agent `smreview`)
**Written by**: theorem-prover, branch `agent/prover/supermoduli-punctured-nonprojected`, 2026-09-22;
restructured (Ramond case elevated to title level, §5.1) by a second theorem-prover round, same
branch, 2026-09-23
**Current external-release status**: 🔴 **none, and none is permitted.** `captain_confirmed: false`.

This file is the decision sheet the captain needs before anything leaves the repository. It is *not*
part of the paper and must not be bundled with a submission.

---

## 0. The one thing that blocks everything

Per the root `CLAUDE.md`, **external claims are the captain's exclusive power**, and
`captain_confirmed` is a real gate in exactly two places, one of which is external publication. The
source attempt's `status.yaml` still reads `captain_confirmed: false`, and the 2026-09-20 reviewer
**explicitly refused to fill it in on the captain's behalf**.

So: the draft exists, it is internally complete, and it is going nowhere until the captain signs.
Nothing in this file should be read as pressure to sign; §3 below is a list of reasons one might
reasonably choose *not* to, or to wait.

---

## 1. What the paper claims, in one paragraph

$\overline{\mathfrak S}_{g;n,2r}$ (the FKP compactified supermoduli stack of stable supercurves with
$n$ NS and $2r$ Ramond punctures) is **non-projected** whenever $g\ge3$ (any $n$, any $r$), and
whenever $g=2$ and $n+2r\ge2$. For $r=0$ both parity components are non-projected for $g\ge3$ and
every $n\ge0$. A complementary **negative** result (Proposition N) shows that the only other
plausible placement of the spectator punctures — on the moving component — makes the obstruction
vanish identically, so the construction used is forced rather than chosen.

The scope written into the paper is **exactly** the writable range the 2026-09-20 reviewer specified
as a graduation hard constraint (`status.yaml`, "毕业进图时的硬约束"). In particular the paper does
**not** name connected components when $r\ge1$, does **not** claim $(g,n,r)=(2,1,0)$, does **not**
claim the $g=2$ odd-parity punctured components, says nothing about the uncompactified stacks, and
makes no positive (splitness/projectedness) claim.

---

## 2. Target journal — three candidates, with reasons

The content is pure algebraic geometry (supergeometry / moduli of curves). As of this round the paper
is *not* framed as "a generalisation of [CN] plus a structural negative result" — that framing has
been demoted to describe Corollary A only. The title-level claim (Theorem B, Ramond punctures
present) is now presented as standing on its own: §9.4 shows forgetting a Ramond puncture is not a
morphism of supermoduli stacks at all, so Theorem B cannot be reduced to [CN] by any construction
known or foreseeable. This changes the pitch to a referee from "we extended a
recent theorem" to "we prove a case [CN]'s method cannot reach, and we show why it cannot." Length as
drafted: ~1200 lines of markdown, which is roughly 25–30 journal pages in LaTeX.

| Candidate | Why it fits | Why it might not |
|---|---|---|
| **Communications in Mathematical Physics** | [DW] is the ancestor of the whole line and sits in the string-math world; CMP routinely publishes supergeometry with this flavour; referees who know both the physics motivation and the stack technology exist there; a title foregrounding Ramond punctures (the physically loaded case, tied to worldsheet fermion boundary conditions) reads naturally to this audience | CMP referees may ask for the physical payoff (superstring measure) which this paper deliberately does not supply |
| **Journal of Geometry and Physics** / **Letters in Mathematical Physics** | Correct length, correct audience, faster turnaround; LMP would suit if the paper were cut to the two main theorems | Lower visibility; a result that removes the $n\le g-1$ restriction deserves better than a venue where it will be missed |
| **International Mathematics Research Notices (IMRN)** or **Mathematische Zeitschrift** | Pure-AG venues where "moduli stack $X$ is non-projected, here is the obstruction class" is a normal paper; no pressure to supply physics; a title-level theorem plus a structural immunity argument (rather than "corollary of a recent paper") is a stronger pure-AG pitch than the previous framing was | Referees will be stricter about the one inference flagged as `[INF-NORMAL]` (§5, Remark 5.8) and may demand that FKP (9.6) be re-derived for punctured targets rather than inferred |

**Recommendation, weakly held**: a math-physics venue (CMP first choice) is the best match for the
*framing*, because the honest-boundaries section (§10) reads naturally there and would look unusual
in a pure-AG journal, and because Theorem B's title-level billing is a Ramond-puncture (i.e.
worldsheet-fermion-boundary-condition) result, which is intrinsically closer to CMP's readership than
a pure-NS statement would have been. But see §3.1 — the priority situation may decide the venue for
us by deciding the timeline.

**A real alternative worth considering**: post to arXiv first (math.AG) and submit afterwards. The
priority risk in §3.1 is a timing risk, and arXiv is the standard instrument for that. **This is
still an external release and still requires the captain's signature** — it is listed here as an
option, not as something to be done.

---

## 3. Risks the captain should weigh before signing

### 3.1 Priority risk — the one that is actually time-sensitive

Simone Noja's homepage lists, under **"In preparation"**:

> **Supermoduli spaces (with M. Corrêa, R. Donagi)**

with **no scope description whatsoever** (verified by the source attempt's prior-art round,
`prior-art.md` §3 item 7, §4 risk table). This is the same Corrêa–Noja pair whose paper [CN] this
work generalises, plus Donagi.

- We **cannot rule out** that it is exactly "compactified supermoduli with punctures". It could
  equally be a survey or a monograph.
- Everything else was ruled out: [CN] has **no outlook section at all** (the proof ends on p. 24 and
  References begin immediately — checked by direct reading, not by search), Donagi–Noja's only
  announcement is about the *uncompactified unpunctured* $\mathfrak M_3$, Wang has no compactified
  material (grep: zero hits), and neither FKP paper discusses projectedness.
- Per `literature/CLAUDE.md` rule 1, unpublished drafts cannot be cited, so this does **not** affect
  the paper's content. It affects **timing only**.
- If that work appears and covers this result, the attempt should be recorded as "superseded /
  independently reproduced", **not** "refuted" (this disposition is already written into the source
  attempt's `status.yaml`).

**Captain's call**: this is the strongest argument for moving quickly (arXiv), and it is the kind of
judgement — external timing — that the rules reserve for the captain.

### 3.2 Value risk `[GAP-ALT]` — Corollary A could be demoted, Theorem B cannot

Written out in the paper at §9.4 and §10.4, and it must stay there:

- If someone constructs the puncture-forgetting morphism on **compactified** supermoduli stacks
  (no literature support exists today: FKP's two "forget" hits are prose in local computations, CN's
  three all refer to forgetting the *spin structure*) **and** proves $\iota_\pi\ne0$ (an injection of
  sheaves does not give injectivity on $H^1$), then **Corollary A (pure NS) becomes a corollary of
  [CN]**.
- **Theorem B (with Ramond punctures) is unaffected**, because forgetting a Ramond puncture is not
  a morphism at all — Ramond punctures are the branch locus of the superconformal structure, not
  marked points.
- **This round's structural change**: this risk is no longer something the introduction merely
  gestures at while the formal statement sits in corollary position. The paper's title, abstract and
  §1.2 "main results" box now name the Ramond case **Theorem B** and place it *first*, precisely
  *because* of this asymmetry — §1.2 states outright that Corollary A "is not structurally immune to
  future erosion" while Theorem B is. The risk to Corollary A's novelty is therefore no longer merely
  disclosed; it is the paper's stated reason for its own title and its own theorem-numbering choice.
  A referee who reads only the abstract will already see the asymmetry, not just a reader who reaches
  §9.4.
- Consequence for how the paper is sold: **the headline result is Theorem B**, both in title and in
  the body of the introduction. If a referee pushes back on Corollary A's novelty, the correct
  response is to agree and point at Theorem B, which is now literally the title-level claim, not a
  fallback buried three sections deep.
- **One thing that did *not* change and must not be allowed to**: elevating Theorem B was done by
  *raising* it, not by *lowering or hiding* Corollary A's own risk. §10 ("Honest boundaries") is
  reproduced in full, unedited beyond the label rename, including `[GAP-ALT]` itself. A referee
  cannot discover an asymmetry that is undisclosed anywhere in the paper — that is not what happened
  here; the asymmetry is now disclosed *earlier and more prominently* than before.

### 3.3 The one inference beyond [FKP]'s literal statements — `[INF-NORMAL]`

The reviewer required this to be labelled, and it is (paper §5, Remark 5.8): using FKP (9.6) /
Lemma 9.1 for a **general punctured target** is *an inference based on the locality of node
singularities, not a conclusion [FKP] states verbatim for arbitrary puncture numbers*. The
justification is real geometry (deformation theory at a node is local; the sheaves in the (9.6)
chain are "supported on the node"), not an argument from the authors' silence. But a strict referee
may ask for the punctured version of (9.6) to be proved. **Estimated cost if demanded**: redo the
local computation of FKP §9.1 in the presence of punctures — expected to be a notational
substitution, but it is real work and was not done here.

### 3.4 `[GAP-FKP-RAMOND]` — an omission in *someone else's* proof

FKP's proof text of Lemma 7.9 writes the generalized spin condition as $L\cong\mathrm{Hom}(L,\omega_C)$
without the Ramond twist $\omega_C(R)$, although the statement (7.8) permits Ramond punctures. Both
reviewer rounds agreed this is harmless (NS gluing is local, away from the Ramond divisor) **and that
we must not claim to have rewritten it**. The paper says exactly that (§10.1), and also records the
wider footprint discovered in the third literature round: FKP Lemma 8.7 and Cor. 8.8 are also
NS-only, and Lemma 9.1(i)'s proof cites Cor. 8.8, so the whole chain to (9.6) runs on NS-only lemmas.

This is **not** a gap of our paper (we glue only at NS nodes). It is listed here because a referee
who notices it will ask, and the honest answer is already in the text.

### 3.5 What we refused to do, and why it is a plus

FKP §9.3 states the Ramond-node analogue of the normal-line computation as "**We conjecture that** …".
Gluing at Ramond nodes would have been shorter and might give a lower threshold, but the theorem
would then be conditional on an unproved conjecture. We refused. The paper says so in §10.2. In this
project's terms: taking the shortcut would have pushed the result's `status` down to `conjecture`;
refusing keeps the whole chain `rigorous`.

---

## 4. Production checklist before any submission

These are real blockers for a *submission*, not for the draft:

1. **Convert to LaTeX.** The draft is markdown with `$…$` math. Nothing exotic is used, but the
   boxed statements and the comparison table need real LaTeX environments.
2. **Authors and affiliation** — the title block currently reads
   `[To be determined by project lead]`. This is the captain's decision, and it is coupled to how the
   project wants to describe agent-assisted work.
3. **Bibliography verification.** [CN], [DN], [DO], [DW], [FKP], [FKP2], [W] are all registered in
   `literature/sources.bib` and were cross-checked there (titles/arXiv numbers verified against the
   bib and the extraction records while writing). **Not registered in `literature/`, and therefore
   not verified by this project's own machinery**: Mumford (1971), Cornalba (1989), Jarvis (2000),
   Serre (1955), Green (1982). Their bibliographic details in the reference list were written from
   standard knowledge and **must be checked against the actual articles** before submission.
   ⚠ Specifically: [FKP, §2.6] cites **two** Jarvis papers ([22] and [23] in FKP's numbering); our
   reference list gives only one, and the pair must be completed (`ISSUES.md` I2).
   ⚠ Also: the project registry and [CN]'s bibliography disagree on [DW]'s page range (19–72 vs
   19–71), and neither was checked against the AMS volume (`ISSUES.md` I4).
4. **Translate the bundled script.** `scripts/thresholds.py` is a byte-identical copy of the
   attempt's verification script and has **Chinese comments and Chinese console output**. It was
   copied verbatim on purpose, so that it remains checkable against the source attempt. If it is to
   accompany a submission (as an ancillary file), it needs an English translation — and the
   translation should be a *new* file, leaving the verbatim copy intact for internal traceability.
5. **Decide whether §10 stays in full.** Recommendation: **yes, keep all of it.** It is unusual to
   publish a section that names a value risk to one's own corollary, but the honesty is the point,
   and the graduation constraints were written assuming those boundaries are visible. Cutting §10 to
   "polish" the paper would be exactly the failure mode this project exists to prevent.
6. **Optional**: a `SOURCEMAP.md` in the style of `research/papers/torsion-dyon-shift-positivity/`
   mapping each paper section to line ranges in the attempt's `proof.md`. Not written this round; it
   is an internal verification aid, not a submission artefact.

---

## 5. What this round did and did not do

**Did**: translate the verified `proof.md` into a paper-shaped English draft, preserving every
quantifier, every reviewer-mandated label, and every honest boundary; re-run the threshold script
from both its original and its new location (`RESULT: ALL OK`, exit 0 both times); cross-check the
reference metadata against `literature/sources.bib` and the extraction records.

**Did not**: re-prove anything, add any argument absent from `proof.md`, touch
`research/attempts/**`, touch `graph/**`, `formal/**` or `literature/**`, or release anything
anywhere.

**No new mathematical errors were found during transcription.** One expository incompleteness in a
*subsidiary* lemma did surface and is recorded as `ISSUES.md` I1: `proof.md` §5.2 establishes the
$h\ge2$ threshold only for the even theta characteristics the method actually uses, while stating
the conclusion unconditionally. The conclusion is correct — the odd theta characteristic on an
elliptic curve is effective and therefore excluded by the standing hypothesis — but the paper adds
one sentence to say so, and that sentence is the only line of reasoning in the draft that is not
already in `proof.md`. **It should be checked by a reviewer.** Nothing in Theorem M, Proposition N,
or any corollary is affected. The remaining `ISSUES.md` entries are bibliographic or production
items.

### 5.1 Addendum (2026-09-23): structural elevation of the Ramond case to title level

A second theorem-prover round restructured the paper's presentation to put the Ramond-puncture case
at title level. This was **pure relayout, not new mathematics**: the renamed result (Corollary B →
Theorem B; the underlying statement is unchanged, Theorem 8.4 in §8) is, and was already, a direct
one-line specialisation of Theorem M (`status.yaml` of the source attempt records this explicitly).
No quantifier, threshold, or hypothesis was touched anywhere in the paper.

**Did**: rename "Corollary B" → "Theorem B" and "Corollary 8.4" → "Theorem 8.4" throughout (title,
abstract, §1.2 "main results" — reordered so Theorem B's box comes before Corollary A's, each box's
own text is byte-identical to before apart from the label — §1.3–§1.6, §2.3, §5, §8, §9.3, §9.4,
§10.1, §10.4); added one new abstract paragraph and one new §1.4 caveat (iii) explaining, without
claiming unpublished priority, why the Ramond case is the structurally more robust one; fixed a
naming collision discovered in the process ([FKP]'s own paper independently has an unrelated theorem
it calls "Theorem B" — disambiguated at both occurrences, §2.3 and §5 Remark 5.6, by parenthetical,
not by renaming our own result again); updated this file's §2 and §3.2 to match.

**Did not**: change any theorem, lemma, quantifier, or threshold; touch `research/attempts/**`,
`graph/**`, `formal/**`, or `literature/**`; weaken, shorten, or relocate any part of §10 ("Honest
boundaries") — all six `[GAP-*]` labels are reproduced in full, and one (`[GAP-ALT]`) was
strengthened in wording, not softened; touch `captain_confirmed` or the external-release status
(§6, unchanged).

**Priority-claim decision, made explicitly rather than by default**: the same unresolved signal
recorded in §3.1 (Simone Noja's "In preparation: Supermoduli spaces (with M. Corrêa, R. Donagi)",
still with zero scope disclosed as of a fresh check this round) was re-verified via web search before
drafting the new abstract paragraph. Because that signal cannot be ruled out, the paper makes **no**
claim to priority anywhere — the new abstract paragraph and the new §1.4 caveat (iii) both say so
explicitly, rather than asserting "first" and leaving the caveat only in this captain-facing file.

---

## 6. Signature block (to be completed by the captain only)

```
captain_confirmed:  false          # ← unchanged; only the captain may change this
external release:   NOT AUTHORISED
venue decision:     (pending)
arXiv first?:       (pending)
date:               (pending)
```
