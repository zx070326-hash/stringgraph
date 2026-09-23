# Pre-submission notes for the captain

**Subject**: `research/papers/torsion-dyon-shift-positivity/paper.md`
**Source attempts**:
- **A** `research/attempts/torsion-immortal-positivity-hecke/` — `state: verified`, `captain_confirmed: true` (2026-09-15)
- **B** `research/attempts/bkm-shift-explanation/` — `state: verified`, `captain_confirmed: true` (2026-09-15)
- **C** `research/attempts/torsion-divisor-sum-covariance/` — `state: verified` (graph-reviewer, 2026-09-18, five attack surfaces), **`captain_confirmed: false`**

**Current external-release status**: 🔴 **none, and none is permitted**, *except* for the one item
already cleared in §2 below.

This file is the decision sheet, not part of the paper. It must not be bundled with a submission.
Its counterpart for the other draft is `research/papers/supermoduli-punctured-nonprojected/NOTES-for-captain.md`.

---

## 0. The one thing that changed the paper, and the one signature it needs

The paper used to be "positivity of the immortal dyon index extends to torsion I > 1". That is still
in it (Theorem 7.1, Corollary 8.1), but it is no longer the headline. The headline is now:

> **The divisor sum on the right-hand side of DGM equation (52) is not a function of the charge.**
> One rank-2 charge lattice, two SL(2,ℤ)-related frames both satisfying (52)'s own hypotheses,
> two different integers: 7999541469408 and 7999235715072.

That result comes from **attempt C, which the captain has not confirmed.** Everything else in the
paper stands on A and B, both confirmed on 2026-09-15. So the signature question is narrow and
specific:

> Does the captain confirm attempt C — the frame-dependence counterexample and the replacement of
> the physical premise (P′) by (P′_ad)?

Confirming C is what the rest of the paper now depends on. If C were withdrawn, §6 would have to be
deleted, §8's premise would revert to (P′) — **which the paper would then be asserting despite having
an explicit integer counterexample to it** — and the title would have to change back. There is no
intermediate position in which the paper is publishable and C is not confirmed.

What the reviewer did on 2026-09-18 (recorded verbatim in C's `status.yaml`): re-derived the witness
matrices without importing the attempt's scripts; rebuilt the charge vectors in U ⊕ U and checked
torsion, invariants and primitivity independently; wrote a from-scratch coefficient engine, calibrated
it on 50064 / 25353 / 32861184 / 1127472, and reproduced **every** d_* used by the three witnesses to
the last digit, including d_*(9,6,−3) = 4315653393218540262504; wrote an independent form enumerator
and confirmed the class counts H(3)=1, H(16)=2, H(23)=2, H(32)=3; confirmed the identity-transform
control returns exactly 0. The verdict was CONFIRMED on all five attack surfaces with one flagged
defect (the Λ-realizability bridge was never written down), **which has since been written into the
paper** as the realizability remark in §6.2.

---

## 1. What the paper claims, in one paragraph

Four things, in decreasing order of what a referee will care about. (i) The divisor sum D_I of DGM
eq(52) takes two values on one charge — three explicit witnesses, one of them related by the S-duality
generator S itself, with the mechanism fully identified (the s-th term is the immortal index of the
*superlattice* ℤ(Q/s) + ℤP, which leaves Λ exactly when the frame is not adapted) and a sufficient
condition under which the failure is invisible (all relevant class numbers 1 — which is why it was
missed). (ii) DGM equations (51) and (52), as printed, are incompatible: they differ by (−1)^{ℓ−ℓ/s},
with an integer witness. (iii) The correct shifted formula, derived algebraically (Theorem 4.1), and
the contour covariance that makes the divisor sum commute with the immortal projection (Theorem 5.2).
(iv) Σ_{s|I} s·d_*(m/s², n, ℓ/s) > 0 on the stated domain, and — given the physical premise (P′_ad),
now stated on adapted frames rather than on triples — strict positivity of single-centered degeneracies
on an S-duality invariant set of charges (Corollary 8.1).

The paper does **not** claim: a proof of Sen's positivity conjecture; a proof of (P′_ad); that the
class-number condition of Proposition 6.5 is necessary (only sufficient — the converse is Problem 9.1);
anything about the CHL generalisation; or priority over Banerjee–Sen for the *qualitative* observation
that (Q²,P²,Q·P) is an insufficient label at torsion r (§10 says outright that this is theirs, from
2008).

---

## 2. What is already cleared, and what is not

**Already cleared (2026-09-15, recorded in A's `status.yaml`)**: stating the DGM eq(51)/(52)
incompatibility externally, and contacting the original authors. The clearance rested on three
corroborating legs — this project's own exact-integer witness, Alexandrov–Nampuri 2020 eq(2.11)+(2.13)
as an independent closed form, and BSS 0802.0544 / 0802.1556 (two independent papers, both predating
DGM, not citing each other) — plus the absence of any source supporting eq(51) as printed and the
absence of an erratum. `letter-to-dgm-authors.md` in this directory is the drafted letter and is still
marked DO NOT SEND WITHOUT AUTHORIZATION; that authorization is what this clearance grants, and the
letter has not been sent.

**Recommendation on the letter**: send it, and send it with the frame-dependence witness included.
C's reviewer makes the point that the eq(51)/(52) sign discrepancy and the frame dependence are two
faces of one thing; presenting only the first would give the authors an incomplete picture. This is a
**captain decision** and the letter is unsent pending it.

**Not cleared**: the frame-dependence result itself (attempt C, `captain_confirmed: false`), and
therefore the paper as a whole, since the paper's title is that result.

---

## 3. Target journal

**Recommendation: JHEP.** This is C's own recommendation and I concur. The composition is:
rigorous arithmetic of the Fourier coefficients of Φ₁₀ (Theorems 4.1, 5.2, 7.1, the §6 lattice
dictionary) + one physical corollary explicitly conditional on a labelled premise + an erratum-flavoured
observation about a published paper. JHEP accepts all three; it accepts conclusions conditioned on a
clearly marked physical input, and it has room for corrective content.

| Candidate | Why it fits | Why it might not |
|---|---|---|
| **JHEP** *(recommended)* | Accepts a result conditional on a marked physical premise; accepts corrective observations about published work; the readership is exactly the one that uses eq(52) | Refereeing is variable; an erratum-flavoured claim about a well-known paper may draw a referee who is a co-author or close colleague — this is an argument for sending the letter first, not for a different journal |
| **CNTP** or **Lett. Math. Phys.** | The pure-mathematical core (d_* is a GL(2,ℤ) class function; the divisor-sum identity; the adapted-frame criterion) is clean and self-contained | They would require stripping the physical premise entirely, and what remains is short and leans on someone else's theorem (Rosselló Cor. 1.1) for the positivity input. The frame-dependence result would survive the strip, but it would lose the reason anyone cares |
| **Physical Review D** | Wide readership | Poor fit for the lattice-theoretic content, which is the substance of the headline |

**On timing**: unlike the supermoduli paper, there is **no known priority race here**. C's prior-art
round found that Banerjee–Sen 2008 has the qualitative statement but zero occurrences of
"automorphism" / "Borcherds" / "Kac-Moody" / "Weyl vector" / "Hecke", and nothing resembling the
integer witnesses, the class-number criterion, or the Q ∈ IΛ criterion. So there is no reason to rush
to arXiv ahead of contacting the DGM authors — and a good reason not to.

---

## 4. Risks the captain should weigh

### 4.1 The paper publicly corrects a well-known paper

That is the sharp edge. It is mitigated as far as it can be: the correction is an exact integer
computation, reproducible from the bundled scripts in a few minutes; the paper states that no erratum
exists rather than implying the authors knew; and the derivation of what eq(51) *should* say
(Theorem 4.1) is given, so the paper repairs rather than only complains. **The right sequencing is
letter first, submission after**, and that ordering is the captain's to set.

### 4.2 (P′_ad) is unproven and is load-bearing for the physics claim

Flagged in the paper at §8 with an explicit `[GAP: (P'_ad) unproven]`. Everything called a Theorem or
Proposition is unconditional; only Corollary 8.1 is conditional, and it says so in its first line.
C judged proving (P′_ad) **infeasible in the short term** and I see no reason to disagree. This is
not a defect to be fixed before submission; it is the honest shape of the result.

### 4.3 Problem 9.2 is the one open question that could demote the paper

If the BSS fractional-shift summation formulae (0802.0544 / 0802.1556) turn out to be frame-*covariant*,
then **they**, not eq(52), are the correct general formula, and eq(52) is their specialisation to
adapted frames. That would not make anything in this paper false — the witnesses stand, (P′_ad) is
still the right premise — but it would reframe the contribution from "a widely used formula is
ill-defined" to "a widely used formula is the adapted-frame shadow of a well-defined one". C flagged
this as the single most valuable next test, and a `theorem-prover` round on it was dispatched
2026-09-23 and is still running. **Recommendation: wait for it before submitting.** It is cheap
insurance against a referee asking the question first.

⏳ **That round (`prescale`) landed 2026-09-23 and the news is mixed.** Merged to `main` at
`research/attempts/p-rescaling-frame-dependence/`, `state: under-review`, reviewer `prescalerev`
dispatched the same day. What it establishes:

- **Problem 9.2 is answered, and the answer does not demote the paper.** The P-rescaling sum
  $D'_I(m,n,\ell) = D_I(n,m,\ell)$ (its Theorem A, two lines), so the P-family is the Q-family with
  the electric and magnetic invariants exchanged, and is frame-dependent in exactly the same way —
  $\Gamma_0(I)$-invariant where ours is $\Gamma^0(I)$ (its Theorem C). Neither family is the
  covariant general formula the other specialises to. The demotion scenario in the paragraph above
  does not occur.
- **A sharper witness than anything in the paper.** Its Theorem D: under DGM plus S-duality the
  index is not a function of $(m,n,\ell,I)$ at all — at $(4,8,8)$ with $I=2$ both a $Q$-adapted and
  a $P$-adapted lattice exist, giving $7\,999\,235\,715\,072$ against $7\,999\,541\,469\,408$, a gap
  of $305\,754\,336$. This needs no trust in either AN or BCP separately, which the paper's own
  witnesses do.
- **Its Theorem E orthogonalises two of our questions**: the signed BSS sum is *also*
  $\Gamma^0(I)$-invariant, so the eq(51)/eq(52) sign question and the frame question are independent
  — neither resolves the other. The paper should not be read as implying otherwise.
- **An honest deflation it volunteered.** Its Theorem C is DGM's own §4.1, which states and proves
  the $\Gamma^0(I)$ restriction and says outright that a different function must be used on each
  other coset. On that reading the frame dependence in our Remark 6.3 is *DGM's own content*, not an
  oversight of theirs. `prescalerev` is checking this self-deflation, and whether it is complete.
  If it holds, §1 and §10's framing of the contribution needs revisiting — the finding would be that
  six of eight papers writing a torsion divisor sum already state the restriction, and only two (AN
  2009.01172 eq. (2.13), CNR 2007.10302 §3.7) need one sentence's hypothesis tightened, **with no
  computed number wrong in either**.

**Three corrections it reports to files outside its own write scope, all touching this paper.** None
is applied yet; `prescalerev` was asked to confirm each independently, because they will drive edits
to a manuscript we intend to submit and the finder should not also be the confirmer:

1. Our §9 (now around `paper.md:477`, Problem 9.2) attributes the P-rescaling family to BSS
   (0802.0544). **BSS is Q-rescaling**; the P-family is AN 2009.01172 and BCP 1806.03330. If
   confirmed this is a straight misattribution in a sentence that names a specific paper.
2. Our §4 $(\rho,\sigma,v)$ dictionary picks the right *slots* but silently identifies the electric
   with the magnetic invariant (our $\rho$ carries $Q^2/2$ where AN's $\sigma$ carries $P^2/2$).
   Theorem 4.1 survives as a $\Phi_{10}$ identity either way, but **"AN corrects DGM" would not
   follow from AN alone** — and that inference is in the abstract, item (B).
3. `literature/extractions/dgm-eq51-eq52-third-party-crosscheck.md` §E1/E2 reads the
   "$\check v + 1/2$" in BSS eq. (4) as independent support for a half-integer shift. It is a
   periodisation term that BSS undo in their eq. (7); no shift survives. That extraction is one of
   the supports under abstract item (B).

**Recommendation: do not submit before `prescalerev` returns.** Items 2 and 3 both sit under abstract
item (B); if they are confirmed, the abstract changes.

### 4.4 The benchmark degeneracies now have a published source — CLOSED

**Resolved 2026-09-23** by the `arxiv-2510-05219` researcher round (carried as its secondary
objective). All five values, **with their charge triples**, are in Bringmann–Murthy,
*On the positivity of black hole degeneracies in string theory*, CNTP 7 (2013) 15-56
(arXiv:1208.3476), **Appendix A, pp. 28-29**: 50064 at (m,n,l)=(1,1,0); 32861184 at (2,2,0);
632078672 at (3,2,0) *and again* at (2,3,0); 9337042944 at (4,2,0) *and again* at (2,4,0);
113477152800 at (2,5,0). These are coefficients of the mock Jacobi form psi_m^F, i.e. the
*single-centered* index directly — no "total = immortal at Q.P = 0" step is needed. The two
doubly-tabulated values are an internal consistency check on the table.

Two Sen tables corroborate part of the list (arXiv:1008.4209 Table 1 p. 11, first three;
arXiv:0708.1270 v3 p. 142, first two) but print the chamber-dependent total -B_6, so
Bringmann-Murthy is the citation to use. §3 now cites it and the "stated as computed, not quoted"
sentence is gone.

**Bonus, now written into the paper as Remark 6.3.1**: every summand of witness (A) and of the
second line of witness (B) is in that same appendix, so those integers are reconstructible from
published numbers by hand. The bundled scripts are needed only for witness (C) and for the first
line of (B). This materially weakens the "trust their code" objection a referee could raise.

Two transcription warnings for anyone who touches this again: `pdftotext` **mis-rows all three
tables** (in Sen 1008.4209 Table 1 it moves the (4,6) data onto the (6,6) label, which would turn
632078672 into a value for (6,6,0) — the true (6,6,0) is 16193130552). Read page images. Also, the
earlier guess that hep-th/0505094 (Shih-Strominger-Yin) holds a table is **wrong**: 6 pages, no
table, none of the five values.

**Correction recorded 2026-09-23**: three of these five values had been attached to the *wrong* charge
triples in earlier drafts of §3 (632078672 is d_*(3,2,0), not d_*(3,3,0); 9337042944 is d_*(4,2,0),
not d_*(2,3,1); 113477152800 is d_*(5,2,0), not d_*(3,4,2)). Found during cross-checking against the
engine, fixed, and logged in `SOURCEMAP.md`. Nothing downstream used the mislabelled triples. The
corrected triples are now independently confirmed against the Bringmann-Murthy table.

### 4.5 The unverified preprint has been read — no overlap. CLOSED

**Resolved 2026-09-23.** arXiv:2510.05219 = A. Bhand, A. Sen, R. K. Singh, *Generating Function of
Single Centered Black Hole Index from the Igusa Cusp Form* (v1, 2025-10-06, 38 pp., hep-th +
math.NT; no journal-ref, no DOI, no v2). Extracted at L1 from the official PDF with page-image
verification: `literature/extractions/bhand-sen-singh-2025-single-centered.md`.

**No overlap.** Its scope is fixed at *torsion one* by its own eq (1.1),
gcd{Q_i P_j - Q_j P_i} = 1; the word "torsion" occurs **exactly once** in the whole text, in the
sentence introducing that equation. Divisor sum, superlattice, saturation, class number, adapted
frame, congruence subgroup, Smith normal form: **zero occurrences**. Its 26-item reference list
(checked on the page image, not the text layer) contains **none** of DGM 0803.2692,
Rossello 2403.19630, Alexandrov-Nampuri 2009.01172, BSS 0802.0544, BSS 0802.1556,
Gritsenko-Nikulin, Kawai — the entire torsion-I>1 line is absent from it. Its six self-listed
results are analyticity, convergence, pole-cancellation and meromorphic-continuation statements
about the single-centered generating function F(Omega) at torsion one. **There is no priority
question.**

One contact point, a citation matter and not a positioning matter: its eq (1.16)-(1.17) state
d_*(gamma^T T gamma) = d_*(T) for gamma in SL(2,Z) by the same route as our Appendix A
(Prop A.1) — Phi_10's Sp-invariance, the contour covariance, measure invariance — but without proof
steps, and sidestepping the half-period shift with an explicit (-1)^{T_12+1} prefactor. Appendix A
already says "for completeness" and Remark 7.2 already attributes the invariance to Rossello, so
the right action was a "cf." line, which is now in Appendix A.

**This closes the paper's last open novelty question.** §3's finding of no priority race with
Banerjee-Sen now covers every title this project knows of.

### 4.6 Two bibliography errors found and fixed

Both in `paper.md`, both found by the same round:

1. `[banerjee-sen-2008]` printed the title and journal number of **0712.0043** against the arXiv
   number of **0801.0149**. The citation's *content* (the Gamma^0(r) discrete-T-duality-invariant
   observation) belongs to 0801.0149, so the arXiv number was right and the title/journal were
   wrong. Now reads: S. Banerjee, A. Sen, *S-duality Action on Discrete T-duality Invariants*,
   arXiv:0801.0149, JHEP **04** (2008) 012 — verified against INSPIRE.
2. `literature/sources.bib` had the same entry as `Banerjee, Sandip` (should be **Shamik**) with
   journal JHEP 09 (2008) 027 (should be **04 (2008) 012**). Fixed in the researcher's branch.

Worth knowing: **Bringmann-Murthy's own reference [3] has this bug too** — it prints an em-dash
continuing "N. Banerjee" from [2], but 0801.0149 is Banerjee (Shamik) and **Sen**. So the error is
in the literature, not only in our copy of it.

---

## 5. Production checklist before any submission

1. **Convert to LaTeX.** The draft is markdown with Unicode math. The tables in §6.2 and §6.3 and the
   long displayed integers need real environments.
2. **Authors and affiliation.** Not yet written into the draft at all. Captain's decision, coupled to
   how the project describes agent-assisted work.
3. **Ancillary scripts are submission-ready but English-only-adjacent.** `scripts/` holds
   `coefficients.py`, `frame_search.py`, `divisor_sum_values.py`, `lattice_witness.py`,
   `primitive_frame_search.py` plus their recorded output. They are byte-identical copies of the
   attempts' engines except for one import path (`primitive_frame_search.py` additionally carries the
   Remark 6.8 sweep and the Proposition 6.9 check, which exist only in the paper), are pure standard
   library, use exact integer arithmetic, and run clean (exit 0; the engine's own
   self-tests report 86 and 171 cases of Rosselló Thm 1 and Cor 1.1 with no violations; the identity
   control returns difference 0). **Check their comments for Chinese text before bundling** — this was
   a real problem with the supermoduli paper's script.
4. ✅ **Benchmark table citation resolved** (§4.4) — Bringmann–Murthy Appendix A is now cited in §3,
   and Remark 6.3.1 makes witness (A) checkable without running our code. Done, not optional.
5. **Wait on Problem 9.2** (§4.3) — recommended.
6. `SOURCEMAP.md` is current as of 2026-09-23 and maps every section to line ranges in A, B or C,
   including the items that are *not* transcriptions (the H(D) convention, the Λ-realizability
   remark, Problem 9.2, and — added 2026-09-23 — Remark 6.8 and Propositions 6.9/6.10).
   It is an internal aid, not a submission artefact.
7. ⏳ **Remark 6.8 and Propositions 6.9/6.10 have no attempt behind them and no reviewer.** They were
   written directly into the paper during a post-welding audit of §6 (the audit that found
   `primitive_frame_search.py` was backing a claim in Remark 6.6 without being bundled). Proposition
   6.9 is proved and machine-checked; Remark 6.8's three conclusions are computational within a
   stated range and labelled as such. They are nonetheless the only mathematics in the paper that has
   never been attacked by anyone, which is exactly the failure mode that bit the supermoduli paper's
   §9.5. **A reviewer should see them before submission.**
8. ⏳ **A stronger result is in review and may supersede §6.8–§6.10 and answer Problem 9.1 outright.**
   `research/attempts/divisor-sum-frame-dependence/` (merged to `main`, `state: under-review`,
   reviewer `framedeprev` dispatched 2026-09-23) reports a structure theorem: D_I is a function of
   (L, H) for H a cyclic isotropic subgroup; a class-*group* criterion for frame-independence; and
   the same invariant 𝔇(L) the paper's Remark 6.8 arrives at independently. Its wider sweep
   (Δ ≤ 400, I ≤ 6) corroborates Remark 6.8 and extends it by an order of magnitude. **Nothing from
   it has been welded in.** If the review confirms it, Problem 9.1 stops being the paper's headline
   open problem and becomes a theorem — which would be a materially stronger paper and is worth
   waiting for. It also carries an unresolved `[GAP-INJ]` affecting only the frame-*dependence*
   direction, not the frame-independence results the paper currently states.

   ✅ **`framedeprev` returned 2026-09-23. Verdict: the mathematics stands** — no error in Theorems
   A, B, C1, C3 (sufficiency), D, E, E″ or Prop 7.1. `state: verified`. But it also found **four
   false claims the attempt made about *this paper***, all now struck by the lead (commit
   `96d8569`): that we assert "invisible exactly when $h=1$" (we state sufficiency and decline
   necessity, at `paper.md:352`, Cor. 6.10, Problem 9.1 and `paper.md:509`); that we "silently
   restrict" to cyclic $M/L$ (we hypothesise it, at `paper.md:87`, Cor. 8.1, `paper.md:475`); that
   $\mathcal D(L\subseteq\Lambda)$ is the attempt's answer (it is our own $\mathfrak D(L)$,
   `paper.md:470–475`); and the word "vacuous". **Nothing in the paper needs changing on account of
   those four** — they were errors in the attempt's description of us, not in us. What remains
   genuinely weldable: Theorem A (the $(L,H)$ structure theorem), Theorem B (the four-way
   characterisation of adaptedness), the class-*group* criterion, and Prop 7.1(2)(3) on non-cyclic
   $M/L$ — which is a statement about the complement of our hypothesis, not a correction to it.
   **Still not welded**, deliberately: awaiting `framedeprev`'s per-item welding list (line numbers,
   target section, prerequisite propositions, `[GAP-INJ]` exposure). Welding is an irreversible
   outward action; better to weld late than to weld wrong.


---

## 6. Signature block (to be completed by the captain only)

```
attempt C captain_confirmed:  false          # ← the blocking one; see §0
paper external release:       NOT AUTHORISED
letter to DGM authors:        drafted, cleared in principle 2026-09-15, NOT SENT
venue decision:               (pending; recommendation: JHEP)
wait for Problem 9.2 result?: (pending; recommendation: yes)
date:                         (pending)
```
