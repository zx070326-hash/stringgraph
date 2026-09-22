# ISSUES found while transcribing `proof.md` into `paper.md`

Scope: problems **discovered during this transcription round** (2026-09-22) that were not already
recorded in the source attempt. Per the task brief, they are recorded here rather than silently
fixed. The source attempt `research/attempts/supermoduli-elliptic-tail-punctured/` is read-only for
this round, so nothing below has been changed there.

**Headline: no mathematical error was found.** Every theorem, corollary and quantifier in
`proof.md` survived transcription unchanged. The items below are one completeness-of-exposition
issue in a subsidiary lemma, and four bibliographic/production items.

---

## I1. `proof.md` §5.2 proves the $h\ge2$ threshold only for the even branch (completeness, not error)

**Severity**: low. The conclusion is correct; the written argument is missing one line.
**Affects**: Lemma 8.2(i) of the paper (= `proof.md` §5.2), i.e. the claim "(P1) $h\ge2$ cannot be
weakened". It does **not** affect Theorem M, Proposition N, or any corollary.

**What the source says** (`proof.md` §5.2, lines 766–771, my translation):

> $h=1$: $\deg L^{-1}=0$, $L$ is a theta characteristic on $E$. **If $L$ is even** (a non-trivial
> $2$-torsion point) then $h^0(E,L^{-1})=0$ and $h^1(E,L^{-1})=h^0(E,L)^\vee=0$ (Serre duality with
> $\omega_E=\mathcal O$). Hence $H^1(C,L^{-1})=0$: **there is no non-zero $\eta$ at all**.

**The problem.** The final sentence is unconditional, but the computation preceding it covers only
even $L$. For the *odd* theta characteristic on an elliptic curve, $L=\mathcal O_E$, one has
$$H^1(E,\mathcal O_E)\cong\mathbb C\ \ne\ 0,$$
so a non-zero $\eta$ **does** exist in that case. Read literally, the displayed sentence is false.

**Why the conclusion nevertheless holds.** The construction's standing hypothesis on the genus-$h$
factor (external input I8, taken verbatim from [CN, §5] / [DW]) is that $(C,L)$ is an **ineffective
even** theta characteristic: $L^{\otimes2}\cong\omega_C$ **and** $H^0(C,L)=0$. That is exactly why
the first factor of the test base is the *even* component $\mathfrak S^+_{h;1,0}$. At $h=1$ the odd
theta characteristic $\mathcal O_E$ has $h^0=1$, so it violates the standing hypothesis and is
unavailable to the method. The even branch is therefore the only one that has to be computed, and
the source's computation of it is correct.

**What I did.** Rather than reproduce the unconditional sentence, Lemma 8.2(i) in `paper.md` now
(a) restates the standing hypothesis explicitly, (b) gives the even computation, and (c) adds one
sentence recording that $L=\mathcal O_E$ has non-vanishing $H^1$ but is effective and hence excluded.
No mathematical content is added beyond the standing hypothesis already in force since §4.

**⚠ Needs adjudication.** Point (c) is one sentence of elementary reasoning that is *not* in
`proof.md`. It is flagged here because the transcription discipline for this round was
"translate, do not re-prove". A reviewer should confirm that (c) is acceptable as an expository
completion rather than a new argument. If it is judged a new argument, the alternative is to weaken
Lemma 8.2(i) to "within this method, and for the even theta characteristics the method requires,
$h\ge2$ cannot be weakened", which is what `proof.md` actually establishes.

**✅ ADJUDICATED (lead, 2026-09-22): keep the strong version. No reviewer round dispatched.**

Verdict: (c) is an **expository completion**, not a new argument, and Lemma 8.2(i) stands as drafted.

Reasoning. The standing hypothesis was checked against the source: `claim.md` I8 reads verbatim
"$h\ge2$ 的光滑曲线上存在**无效偶** theta 特征" — *ineffective even*, both adjectives present in the
input the construction has been running on since §4. The theta characteristics of an elliptic curve
are a **completely classified finite set**: $L^{\otimes2}\cong\omega_E=\mathcal O_E$ makes $L$ a
$2$-torsion point of $\mathrm{Pic}^0(E)$, of which there are exactly four — $\mathcal O_E$ with
$h^0=1$ (odd, effective) and three non-trivial ones with $h^0=0$ (even). Checking a stated hypothesis
against an exhaustively classified four-element set is verification of a premise already in force,
not the introduction of a new one. The arithmetic was re-derived independently: for even $L$, Serre
duality gives $h^1(E,L^{-1})=h^0(E,\omega_E\otimes L)^\vee=h^0(E,L)^\vee=0$; for $L=\mathcal O_E$,
$h^1(E,\mathcal O_E)=h^0(E,\mathcal O_E)=1\ne0$; and at $h=0$ the unique theta characteristic
$L=\mathcal O(-1)$ gives $h^1(\mathbb P^1,\mathcal O(1))=0$. All three agree with the draft.

Why no reviewer agent was dispatched. Root `CLAUDE.md` principle 8 fixes the audit trigger at
consequence, and forbids spending a round on a check that moves nothing. This paper is not in
`graph/`, so no node's `effective` moves; the external-release trigger 8(c) is live **but fires at
submission**, where the object of review is the whole manuscript, not one sentence of textbook
algebraic geometry. Dispatching an agent to re-derive the classification of theta characteristics on
an elliptic curve is precisely the "边界清晰、一定做得完、做完能写一段漂亮记录" failure mode that
principle 8 names.

⚠ This adjudication covers **only** I1. It is **not** a pre-submission review of `paper.md`, and it
does not touch `captain_confirmed`. I2–I6 remain open and are production blockers listed in
`NOTES-for-captain.md` §4.

**Incidental**: the source's parenthetical "$h^0(E,L^{-1})=0$" is true but irrelevant (the quantity
needed is $h^0(E,L)$, which Serre duality converts $h^1(E,L^{-1})$ into). Dropped in the paper; no
consequence.

---

## I2. The bibliography needs two Jarvis papers, not one (citation)

**Severity**: low, but it is a real defect in the reference list.

[FKP, §2.6] — quoted verbatim in the proof of Lemma 5.1 of the paper — attributes smoothness and
properness of the stack of stable spin curves with punctures to **two** references, numbered [22]
and [23] in [FKP]. Our reference list gives only one Jarvis paper (*Geometry of the moduli of higher
spin curves*, Internat. J. Math. **11** (2000), 637–663).

Neither [22] nor [23] has been resolved against [FKP]'s actual bibliography by this project: the
`literature/` extraction record for [FKP] notes explicitly that the two entries were **not
individually verified** ("[22]、[23]（Jarvis 的两篇文章，本条目未逐一核实完整书目）").

**Handling**: the paper's reference entry now carries a ⚠ note saying the pair must be completed
before submission; the verbatim quote retains [FKP]'s own numbers "[22], [23]" rather than
substituting an invented key. Resolving the two entries requires reading [FKP]'s bibliography, which
is `literature/` work and out of this round's write scope.

---

## I3. Five references are not registered in `literature/` (citation hygiene)

Mumford (1971), Cornalba (1989), Jarvis (2000), Serre (1955) and Green (1982) are cited in the paper
but have **no entry in `literature/sources.bib`** and therefore have never passed this project's own
bibliographic verification. Their details in the reference list were written from standard knowledge.
They must be checked against the actual articles before submission.

By contrast [CN], [DN], [DO], [DW], [FKP], [FKP2] and [W] **are** registered, and their titles,
arXiv numbers and (for [FKP]) journal data were cross-checked against `literature/sources.bib` and
the extraction records while writing this draft.

---

## I4. Two sources disagree on the page range of [DW] (citation)

`literature/sources.bib` (entry `donagi-witten-2013`, sourced from INSPIRE recid 1231519 and a
verbatim cross-reference) gives **Proc. Sympos. Pure Math. 90 (2015) 19–72**. The bibliography of
[CN], transcribed verbatim in `literature/extractions/correa-noja-2026.md` E8, prints
**19–71**. Neither has been checked against the AMS volume itself — the project's own bib note says
so explicitly ("均未与 AMS 直证").

The paper's reference entry currently gives 19–72 with a ⚠ note recording the conflict. One page
number, zero mathematical consequence, but it must be settled before submission.

---

## I5. The bundled verification script is not submission-ready (production)

`scripts/thresholds.py` is a **byte-identical** copy of
`research/attempts/supermoduli-elliptic-tail-punctured/scripts/thresholds.py`, deliberately not
translated so that it remains diff-checkable against the source attempt. Its comments and its
console output are in Chinese, and it requires `python -X utf8` on a non-UTF-8 Windows console.

Re-run from both locations during this round: `RESULT: ALL OK`, exit code 0.

If the script is to accompany a submission as an ancillary file it needs an English version, and
that should be a **new** file, leaving the verbatim copy in place.

---

## I6. Title-block author field is a placeholder (production)

`paper.md` opens with `**Authors:** [To be determined by project lead]`. This is a deliberate
placeholder, not an oversight, and is coupled to how the project chooses to describe agent-assisted
work. Recorded in `NOTES-for-captain.md` §4, item 2, as a captain decision.

---

## Not issues (recorded so nobody re-opens them)

- **`[GAP-FKP-RAMOND]`, `[GAP-COMP]`, `[GAP-ALT]`, `[GAP-STD]`, `[GAP-DW]`** are pre-existing,
  already adjudicated by two reviewer rounds, and are reproduced in the paper body (§10). They are
  not findings of this round.
- **The `[INF-NORMAL]` label** on the use of [FKP] (9.6) for punctured targets is a reviewer-mandated
  note, reproduced verbatim in intent at Remark 5.8. Not a finding of this round.
- **The DO/Wang threshold gap** ($g\ge2$ versus $g\ge5r+1$ / $g\ge n+5r+3$) is not a contradiction;
  the objects differ (compactified versus uncompactified). Explained in §9.3, and already settled in
  `proof.md` §6.3.
