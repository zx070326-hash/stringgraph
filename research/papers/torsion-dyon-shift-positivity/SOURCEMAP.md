# Source Map: Paper ↔ Proof Documents

This document maps every assertion in `paper.md` to specific line numbers in the two source attempts' `proof.md` files, allowing reviewers to verify that no new mathematical claims were introduced during synthesis.

## Legend

- **A**: `research/attempts/torsion-immortal-positivity-hecke/proof.md`
- **B**: `research/attempts/bkm-shift-explanation/proof.md`
- **C**: `research/attempts/torsion-divisor-sum-covariance/proof.md` (added 2026-09-23, the source of the new §6)

Section numbering note: the insertion of §6 ("The divisor sum is not a function of the charge") on
2026-09-23 shifted the old §6–§9 to §7–§10. This file uses the **current** paper numbering
throughout; the old numbers appear only in this note.

## Paper §1 (Introduction)

- Background on Sen conjecture, Rosselló result: General knowledge, no specific source
- Main results overview: Synthesized from the claim.md files of A, B and C
- The lead paragraph on the frame-dependence result: C lines 12-28 (§0 结论一览)

## Paper §2 (Notation and conventions)

- Siegel modular forms, Φ₁₀, FJ expansion: A lines 1-50, B lines 1-50
- Index placement convention warning: A lines 89-93, B claim.md lines 41-45
- Attractor cycle definition (R5)/(R5'): A lines 119-122
- Immortal index d_*: A lines 124-127
- Torsion-I generating function 𝒢_I: A lines 52-54, 283-284
- Lattice vocabulary (L, saturation M, torsion I, adapted frames, Γ₀(I) orbit): C lines 29-106 (§1)
- Physical assumption isolation: A lines 489-496, claim.md lines 169-180; narrowed to (P'_ad) by C lines 269-314

## Paper §3 (Incompatibility of DGM eq(51) and (52))

**Proposition 3.1 (Incompatibility)**
- Setup and equation statements: A lines 235-242
- Proof of sign factor difference: A lines 243-252 (Prop 5.1)
- Corollary on incompatibility: A lines 253-258 (Cor 5.2)

**Explicit witness (I=2, charges (4,1,2))**
- Numerical computation and difference: A lines 260-270
- Integer witness 101412 = 4·d_*(1,1,1): A line 265

**Remark on no erratum**
- Literature search result: A lines 298-302, B status.yaml lines 113-115

**Benchmark table of d_* values (paper lines 125-126)**
- Engine output: `scripts/divisor_sum_values.py` (bundled), cross-checked against A's own script output
- **Correction 2026-09-23**: three of the five values had been attached to the wrong triples in earlier
  drafts (632078672 is d_*(3,2,0), not d_*(3,3,0); 9337042944 is d_*(4,2,0), not d_*(2,3,1);
  113477152800 is d_*(5,2,0), not d_*(3,4,2)). The list is now the consecutive family
  (1,1,0),(2,2,0),(3,2,0),(4,2,0),(5,2,0), i.e. (Q²,P²) = (2,2),(4,4),(6,4),(8,4),(10,4) at Q·P = 0.
  The same five values are used again in the proof of Theorem 6.3.

**Remark 3.3 (this witness is frame-independent)**
- C lines 141-147 (Note 2.4); forward reference to Proposition 6.5

## Paper §4 (Algebraic derivation of half-integer shift)

**Theorem 4.1 (Half-integer shift formula)**
- Statement of equation (**): B claim.md lines 46-53, B lines 178-180
- Proof structure (5 steps): B lines 180-236
  - Step 1 (substitute and exchange sums): B lines 186-195
  - Step 2 (change variables): B lines 200-208
  - Step 3 (Lemma B.2, exponential identity): B lines 209-216, Lemma B.2 at B lines 88-120
  - Step 4 (recognize as Z_1): B lines 219-227
  - Step 5 (merge): B lines 229-236
- Lemma B.1 (bijection of change of variables): B lines 64-85
- Lemma B.2 (exponential identity with z_new): B lines 88-120

**Corollary 4.2 (Parity analysis)**
- Odd d case (integer shift cancelled): B lines 130-135 (Lemma B.3a)
- Even d case (genuine half-integer): B lines 139-144 (Lemma B.3b)
- Φ₁₀ integer periodicity source: B lines 44-62, literature/extractions/phi10-periodicity-and-product.md lines 54-62

**Translation to DGM notation**
- Comparison with DGM eq(51): B lines 240-271 (Corollary B1)

## Paper §5 (Attractor cycle covariance)

**Lemma 5.1 (Adjugate covariance)**
- Statement and proof: A lines 97-113 (Lemma 3.1)
- Part (a) T' = T(m/s², n, ℓ/s): A lines 107
- Part (b) adjugate transformation: A lines 110-113
- Part (c) determinant: A line 109

**Theorem 5.2 (Attractor cycle covariance)**
- Statement: A lines 133-140 (Theorem 4.1)
- Proof structure: A lines 143-179
  - Step 1 (image of contour): A lines 143-153
  - Step 2 (Jacobian and phase): A lines 156-162
  - Step 3 (case a, integer periodicity): A lines 164-169
  - Step 4 (case b, fractional periods vanish): A lines 172-179
- Pole avoidance for arbitrary real T': A lines 173 (added 2026-09-15)

**Corollary 5.3**
- Application to F=𝒢: A lines 181-193 (Corollary 4.2)

**Remark 5.4**
- Significance of bypassing mock forms: Synthesized from A lines 225-230 (Note 4.3)

## Paper §6 (The divisor sum is not a function of the charge) — added 2026-09-23

Source: attempt **C** throughout. Nothing in this section comes from A or B.

**Terminology block (frame / admissible / adapted), counting convention H(D)**
- Lattice dictionary, I = gcd(Q∧P) = [M:L]: C lines 29-44 (Lemma 1.1)
- adapted ⟹ admissible: C lines 45-49 (Lemma 1.2)
- adapted frames exist ⟺ M/L cyclic: C lines 50-61 (Lemma 1.3), 62-67 (Lemma 1.4)
- adapted frames = one Γ₀(I) orbit: C lines 68-79 (Lemma 1.5)
- admissible triples = invariants of adapted frames: C lines 80-106 (Lemma 1.6)
- H(D) counting convention (imprimitive forms included): **written for the paper**, no source line. It makes explicit the count C uses implicitly in Prop 2.3 and §3; h(−16)=1 but H(16)=2, and witness A depends on the latter. Arithmetic facts H(3)=H(4)=1, H(16)=2, H(23)=2, H(32)=3 are standard and are also visible in C's witness tables.

**Proposition 6.1 (a)-(e) and proof (the superlattice mechanism)**
- Statement and proof: C lines 113-130 (Prop 2.1)
- Part (b)'s appeal to d_* being a class function: paper Appendix A / A lines 194-224 (Prop 4.4)

**Remark 6.2 (this is what the DGM derivation does)**
- C lines 131-134 (Note 2.2), quoting `literature/extractions/dabholkar-gomes-murthy-2008.md` S4

**Remark (realizability in the physical charge lattice, Γ^{6,22} ≅ U³ ⊕ E₈(−1)²)**
- **Written for the paper.** C's `status.yaml` records the absence of this bridge as a small defect flagged by the 2026-09-18 reviewer; the remark closes it. The lattice facts (U⊕U a primitive orthogonal summand of Γ^{6,22}; the same Γ^{6,22} on both sides of string–string duality) are standard and carry no load in any proof — they only certify that C's witnesses occur as honest charge pairs.

**Theorem 6.3 (frame dependence), witnesses A, B, C and proof**
- Statement: C lines 150-152 (Thm 3.1)
- Witness A (Δ=16 at s=2; both vectors primitive in frame 2): C lines 153-188
- Witness B (frames related by S = [[0,−1],[1,0]]): C lines 189-203
- Witness C (I = 3, Δ/s² = 23): C lines 204-218
- Comparison table: C lines 219-224
- External validation of the numerical engine: C lines 225-244
- All displayed integers: `scripts/divisor_sum_values.py` (bundled), `scripts/lattice_witness.py` (bundled)

**Theorem 6.4 ((m,n,ℓ,I) is not a complete invariant)**
- Statement, table and proof: C lines 245-268

**Proposition 6.5 and Remark 6.6 (why the failure went unnoticed)**
- Sufficient condition H(Δ/s²)=1: C lines 135-140 (Prop 2.3)
- The §3 witness lies in the blind spot: C lines 141-147 (Note 2.4)

**Remark 6.7 (what this forces, what it leaves standing)**
- Positivity survives with wider coverage: C lines 354-395 (§7)
- (P′) refuted, (P′_ad) is the correct premise: C lines 269-314 (§5)
- Honest novelty statement relative to the literature: C lines 396-426 (§8)

## Paper §7 (Positivity theorem)

**Theorem 7.1 (Main result)**
- Statement: A lines 307-314 (Theorem 6.1)
- Proof part (a) (divisor sum identity): A lines 317-319
- Proof part (b) (positivity via Rosselló): A lines 321-325

**Remark 7.2 (Why Rosselló is gcd-independent)**
- Explanation of Gauss reduction and S-duality: A lines 326-332 (Note 6.2)
- Reference to our independent S-duality proof: A lines 194-224 (Prop 4.4)

**Cross-check with gcd>1 cases**
- Numerical verification without gcd restriction: A scripts output, mentioned in A lines 328-330

## Paper §8 (Physical interpretation and remaining assumption)

**Physical assumption (P'_ad)**
- Isolation of physical input: A lines 489-496 (§10 opening)
- Three ingredients (duality, zero modes, wall-crossing): A claim.md lines 172-176
- Restriction of the premise from charges to *adapted frames*: C lines 269-314 (§5)
- **Corollary 8.1** (positivity on an S-duality invariant charge domain): C lines 354-395 (§7)
- What the paper proves mathematically: Synthesized from A lines 916-931 (§14 Conclusion)

## Paper §9 (Open problems)

**Problem 9.1 (the sharp criterion, and the invariant object behind D_I)**
- Sufficient condition, necessity left open: C lines 135-140 (Prop 2.3) + C lines 450-end (GAP list)
- The candidate invariant 𝔇(L) = Σ_{L ⊆ L' ⊆ M} [L':L]·d_*(T_{L'}): C lines 315-353 (§6, covariant rewriting)

**Problem 9.2 (do the fractional-shift formulae fail in the same way?)**
- **Posed for the paper.** Those formulae rescale P rather than Q, so Proposition 6.1's analysis does not transfer; no source claims either way. Recorded as open, not as a negative result.

**Problem 9.3 (BKM algebra interpretation)**
- Half-integer shift and ℤ/2ℤ automorphism: B lines 98-110 (claim.md BKM section)
- Partial results on Cartan element H_r: B lines 346-384 (proof.md S2)
- Weight mismatch Den_ω vs Φ₁₀: B lines 389-445 (proof.md S3)
- Status: B status.yaml lines 82-85, GAP-BKM acknowledged as open

**Problem 9.4 (Mock modular form perspective)**
- Commutation of 𝒯_I with DMZ decomposition: A lines 412-476 (§9, crux 2)
- Theta term Θ_{m,t} computation: A lines 440-463 (Lemmas 9.2, 9.3)
- Obstacle identification: A lines 464-476, GAP 9.4

**Problem 9.5 (Mock equality beyond Gauss-reduced representatives)**
- Numerical evidence for n≥m domain: A lines 500-509 (§10.2 discovery #3)
- Explicit counterexample (5,1,4): A lines 504-505
- Mechanism (c_m^F not GL(2,ℤ)-invariant): A lines 506-509
- Failure mechanism proven rigorously: A lines 727-792 (§10.4.1, GAP 10.4.a closure)
- Three candidate routes for proof: A lines 935-999 (§10.5)
- Status: A status.yaml lines 911 (GAP 10.2b still open)

## Paper §10 (Conclusion)

- Summary of the main steps: Synthesized from both attempts' conclusions and C §0
- Reduction of physical assumptions: A lines 489-496, narrowed to adapted frames by C lines 269-314
- Open questions reiteration: From §9 sourcing above

## Paper Appendix A (S-duality invariance)

**Proposition A.1**
- Independent proof of GL(2,ℤ)-invariance: A lines 194-224 (Prop 4.4)
- Phase transformation: A line 206
- Contour transformation and adjugate identity: A lines 207-210
- Real part torus and Jacobian: A lines 212-216
- Conclusion: A lines 217-218

## Verification notes

- **Claims not traceable to a proof.md line.** Three items in the paper are *not* transcriptions and are flagged as such above: (i) the H(D) counting convention in §6; (ii) the Λ-realizability remark in §6.2; (iii) Problem 9.2. None of them carries load in any proof — (i) is notation making an implicit count explicit, (ii) certifies that C's witnesses occur in the physical charge lattice, (iii) is a question. Every *assertion with mathematical content* traces to a line range in A, B or C.
- **Honest boundary preservation**: all GAPs acknowledged in paper §9 are explicitly marked as GAPs in the source attempts' status.yaml files.
- **Captain-confirmed scope**: A and B have `captain_confirmed: true` (A line 4, B line 4). **C has `captain_confirmed: false`** (C's status.yaml line 59) with `state: verified`; per the root CLAUDE.md, that is sufficient for the content to be built upon internally but **not** for external release. §6 of the paper therefore rests on a verified-but-not-captain-confirmed attempt, and this must be resolved before submission — see `NOTES-for-captain.md`.
- **Physical assumption isolation**: the premise is labeled "physical input, not proven here" in paper §8 and in A lines 489-496. Since C §5, it is stated on *adapted frames* — (P'_ad), not (P') — and the paper does not assert it on arbitrary admissible frames.
- **Numerical reproducibility**: every integer displayed in §3, §6 and §7 is printed verbatim by one of the three bundled scripts, which use exact integer arithmetic and the Python standard library only. Recorded output is in `scripts/run_output.txt` and `scripts/lattice_output.txt`.
