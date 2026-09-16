# Genuinely Hard Open Problems in Mathematical Physics Adjacent to This Project

**Survey Date:** 2026-09-16  
**Context:** This project has deep technical command of Igusa cusp form Φ₁₀, mock Jacobi forms, DMZ canonical decomposition, attractor mechanisms, N=4 dyon counting, plus 37k lines of Lean 4 infrastructure (Virasoro, Fock space, vertex operators, DDF operators). We also have:
- **Conditional theorem:** torsion dyon immortal index positivity for I>1, conditional on DGM eq(52)
- **Proposition B:** closed form Z_I = sum_{d|I} d/Φ₁₀(tau, dz+(d-1)/2, d^2 sigma), not in any literature
- **Identified gap "GAP-BKM":** exact correspondence between half-integer shift and Z/2Z automorphism of BKM root space — confirmed absent from all public literature

The user wants problems that would be published in **Annals of Mathematics, Inventiones Mathematicae, Communications in Mathematical Physics, Duke, JAMS** — breakthrough results, not incremental JHEP papers.

---

## 1. Sen's Positivity Conjecture

### Statement
The index counting the difference between bosonic and fermionic black hole microstates must be positive for all charge configurations.

### Current Status (2024-2026)
**MAJOR BREAKTHROUGH (March 2024):** [The immortal dyon index is positive](https://arxiv.org/abs/2403.19630) proved Sen's conjecture for **immortal dyons** — the 1/4-BPS states in N=4 string theory that form single-centered black holes. This establishes a connection between indexed degeneracies and coefficients of mock modular forms, demonstrating that black hole physics actually predicts the sign of Fourier coefficients.

### What Remains Open
- **Multi-centered black holes:** The 2024 result covers single-centered (immortal) dyons. General multi-centered configurations remain open.
- **Other supersymmetry sectors:** N=8 supergravity, N=2 theories with different matter content.
- **Unconditional proof for all N=4 charges:** The 2024 result is a major step but doesn't close all charge sectors.

### Obstruction
The positivity question is intimately tied to the arithmetic properties of mock modular forms and meromorphic Jacobi forms. The 2024 proof exploited specific structure (DMZ decomposition, attractor flow equations) that may not generalize trivially.

### Distance from Our Team
**6 months to 2 years.** Our conditional theorem on torsion dyon positivity (I>1, conditional on DGM eq(52)) and our discovery of the DGM eq(51)/(52) incompatibility put us in the immediate neighborhood. If we can:
1. Resolve the DGM equation status (cross-check with third parties)
2. Prove or disprove our Proposition B independently
3. Resolve GAP-BKM (the half-integer shift ↔ BKM automorphism correspondence)

Then we have new tools to attack related positivity questions.

**Why it matters:** This would be a **Communications in Mathematical Physics** or **Duke** paper. Positivity is the bridge between microscopic string theory and macroscopic black hole thermodynamics. A complete proof validates the statistical interpretation of black hole entropy.

### References
- Sen positivity conjecture original formulation: [On the positivity of black hole degeneracies in string theory](http://arxiv.org/pdf/1208.3476v2.pdf)
- 2024 breakthrough: [The Immortal Dyon Index Is Positive](https://arxiv.org/abs/2403.19630)

---

## 2. Gopakumar-Vafa Integrality and Finiteness

### Statement
For any Calabi-Yau 3-fold X, there exist integer-valued invariants n^g_β (genus g, homology class β) such that:
1. **Integrality:** The invariants are integers (not just rational)
2. **Finiteness:** All but finitely many n^g_β vanish in every homology class

### Current Status
**Integrality: PROVED** (Ionel-Parker, using symplectic geometry methods)  
**Finiteness: The Gopakumar-Vafa finiteness conjecture** — [still open as of 2023](https://arxiv.org/abs/2103.08221)

### What Remains
The finiteness conjecture is the real prize. It states that for fixed β, only finitely many genera contribute. This would have profound implications for the structure of quantum geometry.

### Obstruction
The conjecture requires understanding the global structure of the moduli space of curves in Calabi-Yau threefolds. Current techniques (Gromov-Witten theory, stable pairs, Pandharipande-Thomas invariants) don't yet control the behavior at arbitrary genus.

### Distance from Our Team
**10-20 years.** This is deep algebraic geometry — our mock Jacobi form expertise is adjacent (GV invariants appear in topological string partition functions whose modular properties we understand), but we'd need to build an entirely new skill set in enumerative geometry, derived categories, and Donaldson-Thomas theory.

**Why it matters:** This would be **Inventiones Mathematicae** or **Annals**. The GV invariants are the "true" curve-counting invariants that underlie string dualities.

### References
- [The Gopakumar-Vafa finiteness conjecture](https://arxiv.org/abs/2103.08221)
- [Gopakumar-Vafa invariants and wall-crossing](https://arxiv.org/abs/1710.01843)

---

## 3. Umbral Moonshine: Conceptual Explanation

### Statement
Why do the 23+1 Niemeier lattices each give rise to a correspondence between finite groups and mock modular forms indexed by group elements? What is the physical or geometric origin of these symmetries?

### Current Status (2024-2026)
- **Umbral Moonshine Conjecture (mathematical structure): PROVED** for the Mathieu case (Gannon, 2015), with general proofs following
- **Physical explanation: PARTIALLY UNDERSTOOD** through 2D string compactifications and K3 surfaces ([Umbral Moonshine and String Duality](https://arxiv.org/abs/1803.07567))
- **Conceptual "why": STILL OPEN**

The mathematical conjecture asserted that infinite-dimensional graded modules exist with prescribed McKay-Thompson series as mock modular forms. This is now proven. But **why these particular groups? Why do they appear in K3 geometry?** The M₂₄ symmetry in K3 surfaces remains mysterious.

### Obstruction
We understand *that* the symmetries exist and *how* they're connected to string theory, but not *why* — there's no first-principles derivation from K3 geometry or CFT that predicts M₂₄ or the other umbral groups.

### Distance from Our Team
**3-5 years for a significant contribution.** Our mock Jacobi form expertise is directly relevant. The half-integer index structures we're studying (GAP-BKM, Proposition B) may be toy models for understanding the umbral symmetries. If we can rigorously explain even one aspect of the half-integer shift from BKM structure, that methodology might transfer.

**Why it matters:** Would be **Inventiones** or **Annals**. Moonshine connections have historically led to Fields Medal work (Borcherds 1998). A conceptual explanation of umbral moonshine would be a major breakthrough.

### References
- [Umbral Moonshine](https://en.wikipedia.org/wiki/Umbral_moonshine)
- [Proof of the Umbral Moonshine Conjecture](https://arxiv.org/abs/1503.01472)
- [Umbral Moonshine and String Duality](https://arxiv.org/abs/1803.07567)

---

## 4. Ooguri-Strominger-Vafa (OSV) Conjecture

### Statement
The microscopic degeneracies of 4D BPS black holes in type II string theory on a Calabi-Yau threefold are related to the topological string partition function on the same manifold by:
```
Z_BH = |Z_top|²
```
(up to modular completion and holomorphic anomaly corrections)

### Current Status (2024)
**UNPROVEN.** Strong evidence from examples, but no general proof. Recent work includes:
- [Explicit formulas for rank zero DT invariants](https://arxiv.org/abs/2203.10617) (2024) showing connections for specific CY3s like the quintic
- Refined versions relating refined BPS partition functions to refined topological strings
- [Essay on reformulation](https://arxiv.org/abs/2405.12980) using generalized global symmetries (May 2024)

### Obstruction
The conjecture bridges:
- Microscopic: BPS state counting (representation theory, wall-crossing)
- Macroscopic: Topological string amplitudes (holomorphic anomaly equations, mirror symmetry)

A proof would require unified control of both sides. The holomorphic anomaly equation is only understood perturbatively (genus-by-genus recursion), not as a closed-form solution.

### Distance from Our Team
**5-10 years.** Our attractor mechanism and dyon counting expertise puts us on the BPS side. But we'd need to:
1. Master topological string theory at a research level
2. Understand holomorphic anomaly equations deeply
3. Develop new techniques for the large-charge limit

This is doable but a major investment.

**Why it matters:** **Communications in Mathematical Physics** or **JHEP** (but a complete proof would push toward the high end, possibly Duke). OSV is one of the oldest and most important conjectures connecting quantum gravity microstates to classical geometry.

### References
- [Study of the OSV Conjecture](https://arxiv.org/abs/1109.0645)
- [BPS black holes, quantum attractor flows and automorphic forms](https://arxiv.org/abs/hep-th/0512296)
- [Recent 2024 reformulation essay](https://arxiv.org/abs/2405.12980)

---

## 5. Kontsevich-Soibelman Wall-Crossing: Full Mathematical Rigor

### Statement
Provide a complete mathematical foundation for wall-crossing formulas in all contexts where they appear (BPS state counting, Donaldson-Thomas invariants, cluster algebras, stability conditions).

### Current Status
**PARTIALLY RIGOROUS.** Kontsevich and Soibelman developed a rigorous framework for motivic Donaldson-Thomas invariants with:
- Model-independent definition of BPS invariants
- Multiplicative wall-crossing formula: A_V = ∏_{l⊂V} A_l (clockwise product over sectors)
- Proven integrality and positivity for quivers with potentials

**What remains open:**
- Full rigor for physical BPS states in supersymmetric gauge theories (not just mathematical DT invariants)
- Uniform treatment across all known examples (4d N=2, 5d SYM, M-theory compactifications)
- Categorification: complete understanding of cohomological Hall algebras

### Obstruction
The physical side (actual BPS states in quantum field theory) still involves heuristic arguments about supersymmetry, moduli space geometry, and Coulomb branch physics. Making this mathematically rigorous requires advances in derived geometry and shifted symplectic structures.

### Distance from Our Team
**7-15 years.** Wall-crossing appears in our dyon counting work (walls of marginal stability, chamber structure), but the full mathematical program is far from string theory phenomenology. We'd need to:
1. Master derived algebraic geometry at research level
2. Understand stability conditions on triangulated categories deeply
3. Bridge from physical BPS states to mathematical DT invariants

This is more of a career pivot than an extension of current work.

**Why it matters:** **Annals of Mathematics** or **Inventiones**. This is mathematics at the highest level, with applications spanning algebraic geometry, representation theory, and mathematical physics. A complete framework would be transformative.

### References
- [Motivic Donaldson-Thomas invariants: summary of results](https://arxiv.org/abs/0910.4315)
- [On 2d-4d motivic wall-crossing formulas](https://arxiv.org/abs/1711.03695)
- [Wall-Crossing Effects on Quiver BPS Algebras](https://arxiv.org/abs/2403.14600) (March 2024)

---

## 6. Uniqueness of the Moonshine Module V♮

### Statement
Prove that the Frenkel-Lepowsky-Meurman vertex operator algebra V♮ is the unique holomorphic VOA of central charge 24 with Monster group symmetry (up to isomorphism).

### Current Status
**OPEN.** The classification of holomorphic VOAs at c=24 is nearly complete **except** for proving uniqueness of V♮ itself. There are characterization theorems: a VOA satisfying certain conditions is isomorphic to V♮, but showing those conditions are forced by c=24 and Monster symmetry is still open.

Related: [Automorphism groups and uniqueness of holomorphic vertex operator algebras of central charge 24](https://arxiv.org/abs/2203.15992) (2024)

### Obstruction
The problem requires both:
- Deep VOA structure theory (understanding all possible c=24 holomorphic VOAs)
- Representation theory of the Monster group (the largest sporadic simple group)

The interaction between these is subtle and not fully understood.

### Distance from Our Team
**8-12 years.** Our Lean 4 vertex operator infrastructure (37k lines including Virasoro, DDF operators) gives us a computational edge, but this problem needs high-level representation theory we don't currently have. If we:
1. Formalize more VOA theory in Lean (conformal weights, fusion rules, modular invariance)
2. Use computer-assisted proof techniques to enumerate constraints
3. Collaborate with VOA/representation theory experts

We could make progress, but it's a long path.

**Why it matters:** **Inventiones** or **Annals**. Borcherds' work on monstrous moonshine won a Fields Medal. Completing the uniqueness proof would close a fundamental chapter in VOA theory.

### References
- [On the uniqueness of the moonshine vertex operator algebra](https://arxiv.org/abs/math/0506321)
- [On the Genus of the Moonshine Module](https://arxiv.org/abs/1708.05990)
- [Classification at c=24](https://arxiv.org/abs/2203.15992)

---

## 7. Geometric Langlands Conjecture (JUST PROVED — But Applications Open)

### Statement
An equivalence between certain categories associated to Langlands dual reductive groups, starting from a complex projective algebraic curve.

### Current Status
**PROVED (September 2024):** [Proof of the geometric Langlands conjecture V](https://arxiv.org/abs/2409.09856)

**BUT:** The **applications to mathematical physics** are wide open. The proof uses sophisticated derived geometry and higher category theory. Extracting concrete consequences for:
- 4D N=4 super Yang-Mills (the Kapustin-Witten connection)
- S-duality in gauge theory
- Vertex algebra representation theory

remains largely unexplored terrain.

### Opportunity
With the main conjecture now proven, there's a gold rush opportunity to:
1. **Make the proof constructive** for explicit computations
2. **Extract physical predictions** about S-duality and BPS states
3. **Connect to vertex operator algebras** via the Beilinson-Drinfeld framework

### Distance from Our Team
**5-8 years for applications.** We'd need to learn the proof's techniques (derived algebraic geometry, factorization algebras), but if we focus on the VOA side (which we have infrastructure for), we could contribute to understanding the representation-theoretic consequences.

**Why it matters:** **Annals**, **Inventiones**, or **Communications in Mathematical Physics** depending on direction. The main theorem is proved, but a career can be built on understanding what it means.

### References
- [Proof of the geometric Langlands conjecture V](https://arxiv.org/abs/2409.09856)
- [What is the Geometric Langlands Correspondence about?](https://arxiv.org/abs/2605.23167)
- [Quantum Langlands dualities](https://arxiv.org/abs/1805.00203)

---

## 8. Borcherds Lift: Classification of Singular Weight Forms

### Statement
Classify all holomorphic Borcherds products of singular weight on orthogonal groups O(l,2).

### Current Status
**Folklore conjecture:** There are only finitely many such forms.  
**Recent progress:** [On the non-existence of singular Borcherds products](https://arxiv.org/abs/2301.13367) (2023) resolved some cases.

**Proven classifications:**
- Symmetric holomorphic Borcherds products of singular weight on lattices of prime level (Scheithauer)
- Reflective modular forms on prime-level lattices

**Still open:** Complete classification for all lattices.

### Why Singular Weight Matters
Borcherds products of singular weight have Fourier expansions supported only on vectors of norm zero — massive cancellation that suggests deep algebraic structure. They yield denominator identities of generalized Kac-Moody algebras.

### Connection to Our Work
The reciprocal 1/Φ₁₀ appears in dyon counting as a **Borcherds-Kac-Moody denominator formula**. Understanding the automorphism structure (our GAP-BKM problem: half-integer shift ↔ Z/2Z automorphism) could provide insight into the classification.

### Distance from Our Team
**3-6 years.** This is closer to our core expertise (modular forms, BKM algebras, arithmetic properties of Φ₁₀) than most other problems on this list. If we:
1. Resolve GAP-BKM for our specific case
2. Understand what makes 1/Φ₁₀ special among meromorphic Siegel modular forms
3. Generalize the technique to other lattices

We could contribute meaningful results.

**Why it matters:** **Inventiones** or **Duke**. Borcherds' original work on automorphic products won him a Fields Medal. Completing the classification of singular weight forms would be a natural next chapter.

### References
- [On the non-existence of singular Borcherds products](https://arxiv.org/abs/2301.13367)
- [Borcherds products of half-integral weight](https://arxiv.org/abs/2007.00055)
- [Automorphic correction of E₁₀](https://arxiv.org/abs/1304.5811)

---

## 9. Rademacher Expansion: Conceptual Origin

### Statement
**Status:** The Rademacher expansion gives **exact** (not asymptotic) formulas for Fourier coefficients of modular/Jacobi forms, hence exact BPS degeneracies. This is **mathematically proven** (rigorous number theory).

**Open conceptual question:** Why does the number-theoretic structure of the Rademacher series (Kloosterman sums, Bessel functions) encode holographic bulk physics?

### Current Understanding (2024-2026)
Recent work shows each Rademacher summand encodes a Segal-Bargmann heat kernel calculation in conformal quantum mechanics: [Emergent holographic AdS₂ from exact BPS black hole microstate counting](https://arxiv.org/abs/2607.12923)

**This is getting close to a conceptual answer.** The holographic origin is becoming clearer.

### Opportunity
- **Formalize the connection** between Rademacher series structure and AdS₂/CFT₁
- **Extend to non-BPS or less supersymmetric cases**
- **Connect to quantum entropy function** (Sen's formalism)

### Distance from Our Team
**2-4 years.** This is in our wheelhouse:
- We understand mock modular forms and Rademacher expansions
- We work with attractor mechanisms and AdS₂ near-horizon geometries
- Our Lean infrastructure could formalize the number-theoretic side

This is one of the **closest opportunities** for a major result.

**Why it matters:** **Communications in Mathematical Physics** or **Duke**. Understanding the holographic origin of exact formulas is a profound question at the intersection of number theory and quantum gravity.

### References
- [Emergent holographic AdS₂ space-time](https://arxiv.org/abs/2607.12923)
- [Exact BPS black hole microstate counting from holographic CQM](https://arxiv.org/abs/2506.22109)
- [Mixed Rademacher and BPS black holes](https://arxiv.org/abs/1702.02755)

---

## 10. Clay Millennium: Yang-Mills Mass Gap

### Statement
Prove that quantum Yang-Mills theory in 4D has a mass gap (lightest particle has mass > 0) and that the quantum theory exists in a mathematically rigorous sense.

### Current Status
**WIDE OPEN.** One of the seven Clay Millennium Prize Problems ($1M prize). Only one (Poincaré conjecture) has been solved.

### Obstruction
Quantum field theory in 4D lacks mathematical foundations. Constructive QFT has only succeeded in 2D and some 3D models. Yang-Mills is non-perturbatively defined only on a lattice (lattice gauge theory), not in the continuum.

### Distance from Our Team
**20+ years, if ever.** This is not adjacent to our expertise. String theory doesn't solve the mass gap problem — it sidesteps it by working in 2D worldsheet CFT or 10D spacetime with compactification.

We list this only for completeness as a "famous problem where our tools don't help."

**Why it matters:** **Annals of Mathematics** (and $1M). But it's likely beyond any physics-based approach. Requires new mathematics.

### References
- [Yang-Mills existence and mass gap](https://en.wikipedia.org/wiki/Yang%E2%80%93Mills_existence_and_mass_gap)
- [Clay Millennium Prize Problems](https://www.claymath.org/millennium-problems)

---

## Honest Assessment: What's Within Reach

### Immediate (1-3 years)
1. **Resolve GAP-BKM** (half-integer shift ↔ BKM automorphism): We've identified the gap, have the tools (Igusa Φ₁₀, BKM structure), and this could be an **Inventiones** or **CMP** paper if we're first.
2. **Prove Proposition B independently**: Closed form for Z_I from Alexandrov-Nampuri. If correct and genuinely new, publishable in **Duke** or **CMP**.
3. **Resolve DGM equation status**: Our finding that eq(51)/(52) are incompatible needs third-party verification. If confirmed, this invalidates a standard reference and would merit **JHEP** or **CMP**.

### Medium term (3-5 years)
4. **Umbral moonshine contribution**: Use our mock Jacobi form + BKM expertise to explain one aspect of the half-integer structure. **Inventiones** or **Annals** if it's conceptual.
5. **Rademacher holographic interpretation**: Extend recent 2024 work on AdS₂ emergence. We have the right background. **CMP** or **Duke**.
6. **Sen positivity (torsion case)**: Remove conditionality from our I>1 theorem. **CMP** or **Duke**.

### Long term (5-10 years)
7. **Borcherds singular weight classification**: Contribute to the full classification program. **Inventiones** or **Duke**.
8. **OSV conjecture progress**: Attack from the BPS/attractor side using our dyon counting tools. **CMP** or **JHEP** (top tier).

### Out of reach (>10 years or never)
9. **GV finiteness**: Too far into algebraic geometry.
10. **Kontsevich-Soibelman full rigor**: Requires career pivot into pure mathematics.
11. **Moonshine module uniqueness**: Representation theory we don't have.
12. **Yang-Mills mass gap**: Wrong tools entirely.

---

## Brutal Honesty: Where Real Breakthroughs Happen

The user is dissatisfied with "methods papers." Let's be frank about where the **real intellectual weight** is in 2024-2026:

### Currently Hot (Top Journal Activity)
1. **Geometric Langlands applications** (just proved Sept 2024 — gold rush moment)
2. **Wall-crossing and BPS algebras** (active March 2024 papers)
3. **Modular forms arithmetic** (2023 breakthrough on 50-year conjecture, March 2023 Quanta Magazine coverage)
4. **Mock modular forms and black hole physics** (2024 Sen positivity proof)

### Where This Project Could Make Noise
**If GAP-BKM is genuinely new and we prove it:** That's an **Inventiones**-level result. The half-integer shift in dyon counting has been known since Dijkgraaf-Verlinde-Verlinde, but if the BKM automorphism explanation is original, that's a conceptual breakthrough.

**If our DGM incompatibility finding is correct:** This is a **bomb** — it means a standard reference (David-Gaiotto-Moore) contains incompatible equations. Needs extreme care and multiple independent checks, but if true, this is **CMP** material.

**If we can explain umbral moonshine's half-integer structure:** Using our BKM + mock Jacobi form tools, even a partial explanation (why the (d-1)/2 shift has the symmetry it does) would be **Inventiones** or **Annals**.

### The Intellectual Honesty Test
Most "applications of method X to problem Y" papers in JHEP are incremental. The breakthroughs come from:
- **Resolving a known gap everyone else walked past** (GAP-BKM might be this)
- **Finding a contradiction in accepted results** (DGM eq(51)/(52) might be this)
- **Providing the first conceptual explanation** (umbral moonshine, Rademacher holography)

This project has **genuine shots** at 1 and 2, and a **plausible path** to 3.

---

## Conclusion

**Closest high-value targets (ranked by feasibility × impact):**

1. **GAP-BKM resolution** (1-2 years, Inventiones/CMP)
2. **Proposition B + DGM status** (1-2 years, Duke/CMP if correct)
3. **Rademacher holographic structure** (2-4 years, CMP/Duke)
4. **Sen positivity unconditional proof** (2-3 years, CMP/Duke)
5. **Umbral moonshine partial explanation** (3-5 years, Inventiones if conceptual)
6. **Borcherds singular weight contribution** (3-6 years, Inventiones/Duke)

**Avoid (too far / wrong tools):**
- Gopakumar-Vafa finiteness
- Full Kontsevich-Soibelman rigor
- Moonshine module uniqueness
- Yang-Mills mass gap

The project's unique assets (Φ₁₀ command, DMZ decomposition, BKM structure understanding, Lean formalization infrastructure) are **well-positioned** for problems 1-6. Problems 1 and 2 are **within striking distance now**.

---

## Sources

### Sen Positivity
- [The Immortal Dyon Index Is Positive](https://arxiv.org/abs/2403.19630) (March 2024 breakthrough)
- [On the positivity of black hole degeneracies](http://arxiv.org/pdf/1208.3476v2.pdf)

### Gopakumar-Vafa
- [The Gopakumar-Vafa finiteness conjecture](https://arxiv.org/abs/2103.08221)
- [Gopakumar-Vafa invariants and wall-crossing](https://arxiv.org/abs/1710.01843)

### Moonshine
- [Umbral Moonshine](https://en.wikipedia.org/wiki/Umbral_moonshine)
- [Proof of the Umbral Moonshine Conjecture](https://arxiv.org/abs/1503.01472)
- [Umbral Moonshine and String Duality](https://arxiv.org/abs/1803.07567)
- [On the uniqueness of the moonshine module](https://arxiv.org/abs/math/0506321)

### OSV Conjecture
- [Study of the OSV Conjecture](https://arxiv.org/abs/1109.0645)
- [Explicit formulas for rank zero DT invariants](https://arxiv.org/abs/2203.10617)
- [Recent 2024 essay](https://arxiv.org/abs/2405.12980)

### Wall-Crossing
- [Motivic Donaldson-Thomas invariants](https://arxiv.org/abs/0910.4315)
- [Wall-Crossing Effects on Quiver BPS Algebras](https://arxiv.org/abs/2403.14600) (March 2024)

### Geometric Langlands
- [Proof of the geometric Langlands conjecture V](https://arxiv.org/abs/2409.09856) (September 2024)
- [What is Geometric Langlands about?](https://arxiv.org/abs/2605.23167)

### Borcherds Lift
- [On the non-existence of singular Borcherds products](https://arxiv.org/abs/2301.13367)
- [Borcherds products of half-integral weight](https://arxiv.org/abs/2007.00055)

### Rademacher
- [Emergent holographic AdS₂ from exact BPS black hole microstate counting](https://arxiv.org/abs/2607.12923)
- [Exact BPS black hole microstate counting from holographic CQM](https://arxiv.org/abs/2506.22109)

### Modular Forms Recent Breakthroughs
- [Long-Sought Math Proof Unlocks More Mysterious 'Modular Forms'](https://www.quantamagazine.org/long-sought-math-proof-unlocks-more-mysterious-modular-forms-20230309/) (March 2023, Quanta Magazine)

### Clay Millennium
- [Yang-Mills existence and mass gap](https://en.wikipedia.org/wiki/Yang%E2%80%93Mills_existence_and_mass_gap)
- [Clay Millennium Prize Problems](https://www.claymath.org/millennium-problems)