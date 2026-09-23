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

### 4.4 The benchmark degeneracies are stated as computed, not quoted

The five values 50064 / 32861184 / 632078672 / 9337042944 / 113477152800 circulate in the 1/4-BPS
literature, but a citable table number was not verified (ar5iv truncates 0708.1270 §5; the HTML
conversion of hep-th/0505094 fails). The paper says so explicitly in §3 rather than attaching a
reference it cannot back. A researcher round on the published PDFs would close this; it is a
production nicety, not a blocker, since the values are independently recomputed by the bundled engine
and by the reviewer's from-scratch engine.

**Correction recorded 2026-09-23**: three of these five values had been attached to the *wrong* charge
triples in earlier drafts of §3 (632078672 is d_*(3,2,0), not d_*(3,3,0); 9337042944 is d_*(4,2,0),
not d_*(2,3,1); 113477152800 is d_*(5,2,0), not d_*(3,4,2)). Found during cross-checking against the
engine, fixed, and logged in `SOURCEMAP.md`. Nothing downstream used the mislabelled triples.

### 4.5 One unverified preprint is deliberately not cited

arXiv:2510.05219 was cited in an early draft of C on the strength of a search snippet. There is no
extraction record for it anywhere in `literature/`, so per this project's rules C stopped citing it
and the paper never did. If it turns out to contain the lattice criterion, the disposition should be
"independently reproduced", not "refuted". Closing this needs a researcher round with network access.

⏳ **That round was dispatched 2026-09-23** (`agent/researcher/arxiv-2510-05219`, writes `literature/**`
only). It is also carrying §4.4's benchmark-citation question as a secondary objective. This is the
paper's last open novelty question: §3 establishes there is no priority race with Banerjee–Sen, but
that argument covers only the sources this project has actually read, and 2510.05219 is the one
title we know of and have *not* read. **Recommendation: do not submit before this returns** — the
cost of learning the answer from a referee is much higher than the cost of waiting.

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
4. **Resolve the benchmark table citation** (§4.4) — optional.
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
