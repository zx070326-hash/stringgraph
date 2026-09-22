# scratch/websearch-log.md — raw research trail (not part of the deliverable, kept for traceability)

Unrestricted scratch notes. Nothing here is a claim; claim.md/argument.md are the load-bearing files.

## WebFetch attempts (both failed, network policy, not content)

- `https://arxiv.org/abs/hep-th/0111016` — "Unable to verify if domain arxiv.org is safe to fetch."
- `https://arxiv.org/abs/hep-th/0501196` — same error.

Conclusion: WebFetch to arxiv.org is blocked in this environment. Fell back to WebSearch for D'Hoker-
Phong scope confirmation (see argument.md §3.1's verification-level note for why this is judged
acceptable — no formula/number from D'Hoker-Phong is load-bearing, only (g,n,r) scope and the
qualitative "uses a projection" fact, both independently corroborated by `L1` Witten/DW quotes).

## WebSearch raw results used

Query: `D'Hoker Phong "Two-Loop Superstrings V" four-point function hep-th/0501196 title`
→ confirmed: Paper V = hep-th/0501196 = "Gauge Slice Independence of the N-Point Function" (Nucl.
Phys. B715:91-119, 2005); Paper VI = hep-th/0501197 = "Non-Renormalization Theorems and the 4-Point
Function" (Nucl. Phys. B715:3-90, 2005). The n=4 explicit amplitude is in Paper VI, the general
gauge-slice-independence machinery for arbitrary N in Paper V.

Query: `D'Hoker Phong "Two-Loop Superstrings I" hep-th/0110247 title chiral measure`
→ confirmed: Paper I = hep-th/0110247 = "Main Formulas" (Phys. Lett. B529, 241-255, 2002). Abstract
(via search snippet): "An unambiguous and slice-independent formula for the two-loop superstring
measure on moduli space for even spin structure is constructed from first principles... for fixed
spin structure, the measure exhibits the expected behavior under degenerations of the surface... the
cosmological constant, and the 1-, 2- and 3-point functions of massless supergravitons all vanish
pointwise on moduli space." Also confirmed Papers II (hep-th/0110283, "The chiral Measure on Moduli
Space", Nucl. Phys. B636 (2002) 3-60), III (hep-th/0111016, "Slice Independence and Absence of
Ambiguities", Nucl. Phys. B636 (2002) 61-79), IV (hep-th/0111040, "The Cosmological Constant and
Modular Forms", Nucl. Phys. B639 (2002) 129-181). Paper II abstract (via search snippet): "describes
how supergeometries are projected onto their superperiod matrices, and the integration over odd
supermoduli is performed by integrating over the fibers of this projection" — this is the sentence
used in argument.md §3.1 to confirm the method is a genuine projection/fibre-integration construction,
independently of Witten's own characterization of it.

## Restriction lemma — derivation notes (kept here in case argument.md's proof needs revisiting)

Original motivating question: does Theorem M (non-projected COMPACTIFIED stack) say anything about
the SMOOTH stack used by actual physics computations? Worked through the sheaf-theoretic definition
of "projected" (global splitting of the truncation map O_X -> O_X/J) and noticed restriction to an
open set is functorial — a global section restricts to a section on any open subset, trivially, by
the sheaf axioms. This is genuinely elementary (not a deep fact) but nobody had written it down in
this project's context, and it is the entire logical content of why Theorem M and D'Hoker-Phong don't
collide. Checked against Donagi-Witten's Remark 1.4 afterward and found they state the exact same
fact (in the direction relevant to their own theorem, which is the converse implication) — good
independent sanity check that the definitions were being used correctly.

## Things considered and discarded

- Considered trying to argue Theorem M implies something about factorization/degeneration limits of
  the D'Hoker-Phong measure itself (i.e. that non-projectedness of the compactified stack forces some
  specific behavior of the measure near the boundary that could be checked against D'Hoker-Phong's
  published degeneration formulas). Discarded: this would require knowing precisely how D'Hoker-
  Phong's slice-based construction extends across the boundary, which is not addressed by their
  papers' abstracts (would need a full read of Papers III/IV, out of proportion for what the task
  asked, and not necessary for the two outcomes documented in argument.md).
- Considered whether Theorem M's Ramond-puncture case (Corollary B) has any special physical relevance
  beyond NS (e.g. fermionic external states, gravitino amplitudes). Decided this doesn't change the
  logical structure of Proposition C (same restriction-lemma argument applies verbatim), so folded the
  observation into argument.md §4.1's phrasing ("any nonzero number of Ramond punctures") rather than
  writing a separate section.
