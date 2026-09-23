# Pre-submission notes for the captain

**Subject**: `research/papers/supermoduli-punctured-nonprojected/paper.md`
**Source attempt**: `research/attempts/supermoduli-elliptic-tail-punctured/` (`state: verified`,
two adversarial graph-reviewer rounds: 2026-09-18 lead-dispatched, 2026-09-20 agent `smreview`)
**Written by**: theorem-prover, branch `agent/prover/supermoduli-punctured-nonprojected`, 2026-09-22;
restructured (Ramond case elevated to title level, §5.4) by a second theorem-prover round, same
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
| **Communications in Mathematical Physics** | [DW] is the ancestor of the whole line and sits in the string-math world; CMP routinely publishes supergeometry with this flavour; referees who know both the physics motivation and the stack technology exist there; a title foregrounding Ramond punctures (the physically loaded case, tied to worldsheet fermion boundary conditions) reads naturally to this audience | ~~CMP referees may ask for the physical payoff (superstring measure) which this paper deliberately does not supply~~ — **addressed 2026-09-23, see below** |
| **Journal of Geometry and Physics** / **Letters in Mathematical Physics** | Correct length, correct audience, faster turnaround; LMP would suit if the paper were cut to the two main theorems | Lower visibility; a result that removes the $n\le g-1$ restriction deserves better than a venue where it will be missed |
| **International Mathematics Research Notices (IMRN)** or **Mathematische Zeitschrift** | Pure-AG venues where "moduli stack $X$ is non-projected, here is the obstruction class" is a normal paper; no pressure to supply physics; a title-level theorem plus a structural immunity argument (rather than "corollary of a recent paper") is a stronger pure-AG pitch than the previous framing was | Referees will be stricter about the one inference flagged as `[INF-NORMAL]` (§5, Remark 5.8) and may demand that FKP (9.6) be re-derived for punctured targets rather than inferred |

**CMP's "no physical payoff" objection is now answered (2026-09-23).** §9.5 was added to the paper: it
states precisely which measure-construction strategy Theorem M forecloses (a single global holomorphic
retraction of the *compactified* stack, unavailable from $g=2$ with two external legs onward), which
ones it leaves untouched (the patchwise constructions of [EW] and [DP] — already argued in §9.3), and
reads Theorem M against [DW, Remark 1.5], where Donagi and Witten record but do not prove the
expectation that the compactification of $\mathfrak M_{g,n}$ is non-split. All four quotations used
there are `L1` in this project's own extraction. Note this is a *credibility and completeness* gain,
not a new result: the honest content of §9.5 is that Theorem M has narrow physical bite, and the
section says so explicitly. It removes a predictable referee question; it does not raise the paper's
mathematical weight. **Two items in §2's "why it might not" column are now unequal**: CMP's objection
is answered, IMRN/Math. Z.'s `[INF-NORMAL]` objection is not (a `theorem-prover` round on it was
dispatched 2026-09-23; see §5).

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

⏳ **Round dispatched 2026-09-23 to close it outright.** The standing position above — "both reviewer
rounds agreed this is harmless" — is a *judgement nobody has checked by doing the computation*;
§10.1 says so itself ("We have not independently rewritten that local computation"). Since
[GAP-FKP-RAMOND] sits directly under Theorem 8.4 at $r\ge1$, and Theorem B is this paper's
title-level claim (§5.4), an unverified external omission is load-bearing in the worst possible
place. A `theorem-prover` round (`research/attempts/fkp-79-ramond-twist/`) is now rewriting FKP's
Lemma 7.9 proof under $\omega_C\rightsquigarrow\omega_C(R)$ from the rendered p.47–48. Three
outcomes, all useful: (a) it goes through and §10.1's gap label can be **removed**, making Theorem B
unconditional; (b) it needs extra hypotheses, which we then check against our actual §5–§6 usage;
(c) it fails, in which case the title-level claim has a real problem and we need to know now rather
than from a referee. The brief explicitly tells the agent the "harmless" judgement is the object
under test, not a prior. **Recommendation: do not submit before this returns.**

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
3. **Bibliography verification — ~~blocker~~ cleared 2026-09-23.** All twelve reference entries are
   now registered in `literature/sources.bib`. [CN], [DN], [DO], [DW], [FKP], [FKP2], [W] were
   already registered and cross-checked. Mumford (1971), Cornalba (1989), Jarvis (2000), Serre
   (1955), Green (1982) were registered in the `lit-blockers` researcher round, which also fed five
   corrections back into the reference list (missing issue numbers on Mumford, Serre, Jarvis; the
   Annals series designation on Serre; Cornalba's publisher address). **None of the five had its
   full text retrieved and three did not reach L1** — adequate for background citations that carry
   no load in any proof, which is what all five are, and recorded as such in `ISSUES.md` I3.
   ✔ [FKP, §2.6]'s second Jarvis reference ([23]) is resolved and added: Jarvis–Kimura–Vaintrob,
   Compositio Math. **126** (2001), no. 2, 157–212 (`ISSUES.md` I2, closed at L1 off [FKP]'s own
   References page image).
   ✔ [DW]'s page range settled as **19–71** on AMS's own Crossref record, agreeing with [CN];
   INSPIRE's 19–72 is the sole dissent and is named in the reference entry (`ISSUES.md` I4).
   Remaining: nothing blocking. The AMS endmatter PDF is Cloudflare-blocked and was not read, so
   19–71 rests on the publisher's machine-readable record rather than a page image.
4. **Translate the bundled script.** `scripts/thresholds.py` is a byte-identical copy of the
   attempt's verification script and has **Chinese comments and Chinese console output**. It was
   copied verbatim on purpose, so that it remains checkable against the source attempt. If it is to
   accompany a submission (as an ancillary file), it needs an English translation — and the
   translation should be a *new* file, leaving the verbatim copy intact for internal traceability.
5. **Decide whether §10 stays in full.** Recommendation: **yes, keep all of it.** It is unusual to
   publish a section that names a value risk to one's own corollary, but the honesty is the point,
   and the graduation constraints were written assuming those boundaries are visible. Cutting §10 to
   "polish" the paper would be exactly the failure mode this project exists to prevent.
6. **~~Optional~~ `SOURCEMAP.md` — written 2026-09-23**, mapping each paper section to line ranges in
   the attempt's `proof.md`. It is an internal verification aid, not a submission artefact. Writing it
   surfaced one thing worth the captain's attention, recorded as §5.2 below.
7. **~~Resolve §9.5's provenance~~ — done 2026-09-23, and it was not a formality.** The review
   cleared the source attempt and **refuted §9.5 as written**: two overclaims, one of them refuted by
   the paper's own §9.2. Both fixed. See §5.2 for what happened and why it is worth reading before
   signing anything else in this directory.

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

### 5.2 Addendum (2026-09-23, lead): §9.5 rests on an attempt nobody has reviewed

Building `SOURCEMAP.md` turned this up, and it changes one line of §0.

Every section of the paper traces to `research/attempts/supermoduli-elliptic-tail-punctured/proof.md`
— `state: verified`, two adversarial graph-reviewer rounds — **except §9.5**, which draws on
`research/attempts/supermoduli-measure-consequence/`. That attempt reads:

```
state: under-review
reviewer: (none yet — requesting graph-reviewer dispatch, see notes)
verdict: (pending — no reviewer round has occurred yet.)
```

Its own author split Proposition C into a "safety" half (C1, the restriction lemma — rigorous and
proved) and a "bite" half (C2), and graded C2 as *physical-argument-level interpretive framing*, not
as proved mathematics. §9.5 is the section that was added on 2026-09-23 **specifically to pre-empt
CMP's "where is the physical payoff" objection** (§2 above). A section written to answer a referee
before they ask is exactly the text that has to be right.

**How bad is it, honestly**: smaller than the status line suggests. §9.5's load-bearing pieces are
the paper's own Theorem M, the restriction lemma already proved in §9.3, and four `L1`-verified
quotations from [DW] and [EW]. The part that is genuinely M's — the framing of *which* measure
strategy is foreclosed — is also the part §9.5 states most cautiously, and the section's closing
paragraph ("What is not claimed") gives away more than it takes. So this is a **provenance** problem,
not a suspected-error problem.

**What was done about it**: a `graph-reviewer` round was dispatched 2026-09-23, charged with judging
C1 and C2 on their own terms, checking whether C2's `physical-argument` grading is the right grading
(too high *or* too low), re-running the attempt's D'Hoker–Phong self-check, and — the part that
matters here — reading §9.5 against what M actually proves to confirm it claims neither more nor
less.

**Result (2026-09-23, same day): the paragraph above was wrong about where the risk was.** I judged
this a provenance problem and not a suspected-error problem. The review found errors, and it found
them in exactly the place I had reasoned was safe — not in M, but in the *transcription* of M into
§9.5. M itself came back CONFIRMED and is now `state: verified`. §9.5 came back **refuted as
written**, with two CONFIRMED overclaims present in neither `claim.md`, `argument.md` nor
`draft-section.md`:

1. **"empty from $g=2$ onward"** — refuted by the paper's own §9.2, which cites [CN, Thm. 1.1(1)]
   for the *splitness* of $\overline{\mathfrak M}^-_2$. The paper contradicted itself across two
   sections, and the refuting citation was already in it.
2. **"That is the strategy"** — attributed Donagi–Witten's *uncompactified* strategy to the
   compactified one Theorem M forecloses, contradicting §9.5's own next paragraph about [DP].

Also removed: an unsupported "lowest external-leg count at which a compactified treatment is needed
at all" (D'Hoker–Phong's $n=0$ two-loop degeneration work exists), and an upgrade of M's "applies
with equal force" to "applies here verbatim". All four fixed in commit 8070707; two citation defects
found inside M (vertical integration is Sen–Witten's, not [EW]'s; the "validity does not depend on a
projection" quote is Donagi–Witten's, not Witten's) fixed in 72a42a1.

**Why this is recorded at this length**: the defects were introduced by welding, survived my own
read-through, and would have been invisible to any check that only asked "is the source attempt
sound?" — the source attempt *was* sound. They were caught by the one question the reviewer was
charged with that I did not think would pay: does the section claim neither more nor less than its
source proves. If the captain takes one procedural lesson from this round, it is that a paper's
referee-facing sections need to be diffed against their sources, not merely traced to them.

**Captain's call, updated**: §9.5's provenance is no longer a blocker. It is reviewed, its source is
`verified`, and the defects the review found are fixed. One honest limit remains: the reviewer's
report was **truncated in delivery after its sixth finding**, so findings F1–F6 were received and
independently re-verified against the primary text, and anything beyond F6 was not. The attempt's
`status.yaml` says so in its verdict rather than quietly claiming a clean bill.

### 5.3 Addendum (2026-09-23, lead): four rounds dispatched against this paper

| Round | Target | Where it writes | Status |
|---|---|---|---|
| `fkp96` | Close `[INF-NORMAL]` (§3.3) by deriving [FKP] (9.6) for punctured targets | `research/attempts/fkp-96-punctured/**` | ◐ **half landed.** Its §3 proves the strong form — the complex $[\Omega_{X/S}\to j_*\Omega_{U/S}]$, its Berezinian and the canonical trivialization depend on $\pi$ alone, because the punctures enter a supercurve only through the target twist of $\delta$ and $\delta$ never appears in the complex — so (7.6) holds verbatim on $\overline{\mathcal S}_{g;m,n}$. The round then died to an API fault; its work is committed (6cfec89) and it has been resumed. It also reports two errors in [FKP] that the remaining half must repair: (7.1) needs an $(R)$ twist, and the proof of Lemma 7.9 uses the $r=0$ case of (2.5) |
| `gapcomp` | Close `[GAP-COMP]` (§10.3 of the paper): component refinement when $r>0$ | `research/attempts/supermoduli-ramond-components/**` | in flight |
| `measurerev` | The §5.2 review above | read-only | ✅ **landed** — cleared M, refuted §9.5 as written; see §5.2 |
| `sharpness` | Is the threshold **sharp**? The paper leaves $(g,n,r)=(2,1,0)$, the $g=2$ odd-parity punctured components, and all of $g\le1$ untouched, and §9.2 only says the *method* cannot reach them. Whether they are genuinely split or merely out of reach is unknown | `research/attempts/supermoduli-threshold-sharpness/**` | ✅ **landed, under review.** Merged to `main`. Headline: $\overline{\mathfrak S}_{0;4,0}$, of dimension $(1|2)$, is **split** — and since its odd rank is $2$, [CN, Prop. 2.2] makes that *equivalent* to $\omega_2=0$, so the cell is settled outright, not merely unreached. Also: odd rank $\le1$ forces canonical splitness, hence everything with $2g-2+n+r\le1$ is split; and $(0;4,0)$ is the unique remaining cell with bosonic dimension $1$ and odd rank $2$, so the degree method is exhausted rather than open-ended. **Do not act on this before `sharprev` returns** |
| `sharprev` | Adversarial review of the above. The stacky-order arithmetic $(-1,-1,+3)$, the $\mu_2$-gerbe/root-stack identification, the stacky Serre-duality vanishing, and whether [CN, Prop. 2.2] says what it is used to say — dispatched 2026-09-23 | read-only | in flight |
| `lowcorner` | The two cells `sharpness` named as the next targets: $\overline{\mathfrak S}_{1;2,0}$ and $\overline{\mathfrak S}_{0;3,2}$ — the smallest where odd rank is still exactly $2$ but the bosonic base is a *surface*, i.e. where the degree argument stops. Dispatched 2026-09-23 without waiting for `sharprev`, deliberately: it was told to find its own route and to re-verify the shared [CN, Prop. 2.2] step itself rather than inherit it | `research/attempts/supermoduli-low-corner/**` | in flight |
| `genus0priorart` | Whether $\overline{\mathfrak S}_{0;4,0}$ splitness is already published. `sharpness` deliberately did not search (project rule defers prior art to graph entry / publication) and flagged that the object is small and natural enough that it may well be known. **This is a submission gate, not a nicety** | `literature/extractions/supermoduli-genus0-splitness-prior-art.md` only | in flight |
| `fkp79` | Close `[GAP-FKP-RAMOND]` (§3.4, paper §10.1) by rewriting [FKP] Lemma 7.9's proof under $\omega_C\rightsquigarrow\omega_C(R)$. Dispatched 2026-09-23 because this is the only unverified external dependency sitting under a **title-level** claim | `research/attempts/fkp-79-ramond-twist/**` | in flight |

**Cross-round fact relayed to `fkp79` (2026-09-23):** `fkp96` independently reported, from the same
pages, that Lemma 7.9's proof "uses the $r=0$ case of (2.5)" and that (7.1) needs an $(R)$ twist.
That is two separate rounds finding the same $r=0$ assumption baked into the same proof, arrived at
from different directions. It raises the prior that the omission is a genuine restriction rather
than typographic — which is precisely why `fkp79` was dispatched and why §3.4's standing "harmless"
judgement should not be relied on until it returns.

The first two, if they land, remove two of the three items in §3 ("Risks the captain should weigh")
outright: `[INF-NORMAL]` is the objection §2's table assigns to IMRN / Math. Z., and `[GAP-COMP]` is
the one caveat attached to Theorem B's statement. The fourth is upside rather than risk reduction: a
sharpness theorem — in either direction — would turn "here is a threshold" into "here is *the*
threshold", which is a different class of result. None of the four is a prerequisite for submitting
what exists today; all four change what is worth submitting.

**What `sharpness` actually changes, stated plainly (2026-09-23, lead).** The paper's §1.5 item 2
says verbatim that it asserts *"Nothing in the positive direction"*. If `sharprev` clears
Theorem 4.5, that sentence is false and must go, and §9.2's apologetic "the method cannot reach
$\overline{\mathfrak M}^-_2$" becomes a sharpness section: the low corner is **provably split**, not
merely unreached. That is a change of kind, not of degree, and it is the largest single upgrade
available to this paper right now.

**Two things it does not change, and one new gate.** It does not touch the $g\ge2$ region — its
Theorem 3.3 there is assembly of [CN] and [DW] plus a restriction lemma, explicitly claimed as zero
novelty, and `sharprev` is checking the assembly drops no cell. And the prover corrected itself
mid-round: it first wrote that `paper.md` had failed to apply the restriction lemma at $(2;1,0)$,
then found the current manuscript already states the transfer in §1.4 caveat (i), §1.5(3), §9.3 and
§10.6 — the erratum is in its own `status.yaml`, and `sharprev` was asked to confirm the withdrawn
claim leaves no trace in the attempt's text. **New gate: `genus0priorart`.** $\overline{\mathfrak
S}_{0;4,0}$ is a small, natural object; if its splitness is already in Donagi–Witten, Codogni–Viviani
or the physics folklore, then what we have is an exercise, not a result, and it must be cited rather
than claimed. **Recommendation: do not submit, and do not insert Theorem 4.5 into `paper.md`, before
both `sharprev` and `genus0priorart` return.**

**A guard against reading "sharpness" as more than it is (lead, 2026-09-23).** Even with Theorem 4.5
standing, the threshold is *not* settled. Writing the odd rank of $\overline{\mathfrak S}_{g;n,2r}$
as $2g-2+n+r$, what is known splits as:

- **split**, because odd rank $\le1$ forces it: the finitely many cells with $2g-2+n+r=1$;
- **split**, by Theorem 4.5: $(0;4,0)$ — the unique cell with odd rank $2$ *and* bosonic dimension $1$;
- **non-projected**: everything with $g\ge2$;
- **open in both directions**: all of $g=1$ with $n+r\ge2$, and all of $g=0$ with $n+r\ge4$ except
  $(0;4,0)$. That is two infinite families, and the attempt's own GAP-3 says plainly that it found no
  mechanism producing a nonzero $\omega_2$ from genus $\le1$ data *and did not prove none exists*.

So the honest headline is "the low corner is provably split, and the degree method that proves it is
exhausted", not "$g\ge2$ is exactly the non-projected region". The `lowcorner` round is aimed at the
first two cells of the open families precisely because the gap is infinite. Any sharpness section
inserted into `paper.md` must carry this enumeration, or a referee will read a threshold claim we
have not earned.

### 5.4 Addendum (2026-09-23): structural elevation of the Ramond case to title level

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
