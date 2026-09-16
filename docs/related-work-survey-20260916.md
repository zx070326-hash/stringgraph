# Related Work Survey — String Theory Formalization Landscape

**Survey Date:** 2026-09-16  
**Impact Factor Threshold:** ≥ 2 (JHEP, Comm. Math. Phys., J. Math. Phys., etc.)

## Executive Summary

This survey maps the competitive landscape for the stringgraph project across four domains: (1) string theory machine verification, (2) physics formalization projects, (3) mathematical dependency graphs, and (4) string theory foundational results. Key findings:

- **No direct competitors** in comprehensive string theory formalization exist. Most work focuses on isolated results (QFT, quantum information) or individual theorems.
- **Recent breakthrough (2026):** Seiberg-Witten solution codified in Lean 4 demonstrates feasibility of formalizing physical arguments without full rigorous proofs.
- **QFT formalization advancing rapidly:** Free bosonic field Osterwalder-Schrader axioms formalized in Lean 4 (2026), establishing baseline for constructive QFT.
- **Dependency graph tooling emerging:** KnowTeX (2026), Mathlib network structure analysis, and ProofFlow demonstrate growing interest in proof dependency visualization.
- **Gap we fill:** No project systematically tracks epistemic status (conjecture vs. physical argument vs. rigorous proof) across string theory's dependency graph. No-ghost theorem formalization and D=10 anomaly cancellation classification remain open.

---

## 1. String Theory Machine Verification / Formalization

### 1.1 Direct String Theory Formalization

**No published work found** in journals with IF ≥ 2 specifically on formal verification of string theory results in proof assistants. This represents a **major gap** our project addresses.

#### Relevant arXiv preprints:
- Most no-ghost theorem papers (see Section 4) remain at physics level without formalization efforts.
- Wikipedia entry on [Goddard-Thorn theorem](https://en.wikipedia.org/wiki/Goddard%E2%80%93Thorn_theorem) notes the theorem but no formal verification attempts.

### 1.2 Seiberg-Witten Solution Formalization (Closest Analog)

**[Axioms for physical reasoning: codifying the Seiberg–Witten solution in Lean](https://arxiv.org/html/2607.06379)** (arXiv:2607.06379, 2026)

- **Relevance:** HIGH — demonstrates feasibility of formalizing physical arguments in Lean 4 when rigorous proofs are out of reach.
- **Summary:** Formalizes N=2 SU(2) super-Yang-Mills Seiberg-Witten solution (genus-one case) by codifying chains of physical reasoning as axioms. Uses Lean 4 type system to track which conclusions depend on unproven physical assumptions vs. rigorous mathematics.
- **Impact on our project:** Validates our epistemic status tracking approach. Their "physical axiom" = our `physical-argument` status. Demonstrates Lean 4 + Mathlib suffices for modern physics.
- **Gaps they don't fill:** Specific to N=2 gauge theory, not string theory. No dependency graph across multiple results.

**[Global forms of N=4 theories and non-minimal Seiberg-Witten solutions](https://arxiv.org/html/2510.02055v2)** (arXiv:2510.02055v2, Oct 2024, JHEP candidate)

- **Relevance:** Medium — extends SW solution to N=4, closer to string theory applications.
- **Summary:** Associates algebraic completely integrable systems to N≥2 SUSY QFTs, constructs non-minimal genus SW curves for global forms.
- **Not formalized** — pure physics paper.

---

## 2. Physics Formalization Projects

### 2.1 Quantum Field Theory Formalization

**[Formalization of QFT: Osterwalder-Schrader Axioms for the Free Field in Lean 4](https://arxiv.org/html/2603.15770)** (arXiv:2603.15770, Mar 2026)

- **Venue:** OpenReview (ICLR 2026 workshop candidate)
- **Relevance:** HIGH — establishes baseline for constructive QFT formalization, prerequisite for string theory worldsheet QFT.
- **Summary:** Formalizes free bosonic quantum field on 4D Euclidean spacetime, proves it satisfies Glimm-Jaffe-Osterwalder axioms (OS0-OS4) in Lean 4. First extended mathematical physics proof using AI-assisted formalization.
- **Repository:** [Physicslib on Reservoir](https://reservoir.lean-lang.org/@physicslib/Physicslib)
- **Impact on our project:** Demonstrates Lean 4 can handle probability measures on distributions, Schwinger functions, Euclidean QFT. Their OS axioms = potential dependency for our worldsheet CFT nodes.
- **Gaps:** Only free field, no interactions. No CFT-specific structures (Virasoro, modular invariance).

**[Digitalizing Wick's theorem](https://arxiv.org/html/2505.07939v1)** (arXiv:2505.07939v1, May 2025)

- **Relevance:** Medium — normal-ordering and time-ordering are used in string perturbation theory.
- **Summary:** Formalizes Wick's theorem for quantum field operator algebras, relating normal-ordering and time-ordering maps.
- **Status:** arXiv preprint, no journal publication yet.

**[P(Φ)₂ Euclidean QFT in Lean 4](https://reservoir.lean-lang.org/@mrdouglasny/pphi2)** (Reservoir package, 2026)

- **Relevance:** Medium — interacting QFT formalization following Glimm-Jaffe/Nelson lattice approach.
- **Summary:** Formal construction of P(Φ)₂ Euclidean quantum field theory in Lean 4.
- **Impact:** Shows feasibility of interacting QFT in proof assistants, but 2D not directly applicable to 10D string backgrounds.

### 2.2 Conformal Field Theory & Virasoro Algebras

**No formal verifications found** in journals with IF ≥ 2. Physics literature on Virasoro representations is extensive (see searches) but entirely informal.

#### Physics papers (not formalized):
- Multiple arXiv papers on Virasoro algebra representations, Kac determinants, BPZ equations — all at physics rigor level.
- [Irreducibility of Virasoro representations in Liouville CFT](https://arxiv.org/html/2312.07344v1/) (Dec 2023) — constructs Virasoro highest-weight reps at Kac table degenerate values, proves irreducibility. **Pure math**, but not formalized.

**Gap our project fills:** First formalization of Virasoro no-ghost theorem (worldsheet.no-ghost-theorem-v4 target).

### 2.3 Vertex Operator Algebras

**No formalizations found** in proof assistants. Extensive mathematical physics literature (Borcherds' axiomatization, FLM Moonshine) remains informal.

#### Key unformalised work:
- Borcherds (1986) vertex algebra axiomatization — foundational but no Lean/Coq/Isabelle implementation.
- [Introduction to Vertex Algebras](https://arxiv.org/html/0809.1380v3) (arXiv:0809.1380v3) — standard reference, no formalization.
- [Raviolo vertex algebras and conformal blocks](https://arxiv.org/html/2401.11917v1) (Jan 2024) — recent VOA research, not formalized.

**Gap:** Vertex algebras central to string theory (DDF states, BRST cohomology) have zero formal verification presence.

### 2.4 Quantum Information Theory in Lean (Adjacent Field)

**[Lean-Quantum: Toward AI-Assisted Formalization of Quantum Information](https://arxiv.org/abs/2607.05492)** (arXiv:2607.05492, Jul 2026)

- **Venue:** arXiv (likely LICS/POPL 2027 submission)
- **Relevance:** Low for string theory content, HIGH for Lean 4 + physics methodology.
- **Summary:** Lean 4 library for finite-dimensional quantum information theory, formalizes data processing inequality for quantum relative entropy. Coordinate-free, type-class-driven framework.
- **Repository:** [Timeroot/Lean-QuantumInfo](https://github.com/Timeroot/Lean-QuantumInfo) — merged into Physlib (Mar 2026).
- **Impact:** Demonstrates AI-assisted physics formalization workflow. Our `lean-formalizer` agent design mirrors their approach.

**[MerLean: An Agentic Framework for Autoformalization in Quantum Computation](https://arxiv.org/html/2602.16554v1)** (arXiv:2602.16554v1, Feb 2026)

- **Relevance:** Medium — autoformalization pipeline (LaTeX → Lean 4 → verified → LaTeX).
- **Summary:** Extracts math statements from LaTeX, formalizes into Lean 4/Mathlib, back-translates for semantic review. Fully automated agentic workflow.
- **Impact on our project:** Their pipeline = our `extract-paper` + `graph-curator` + `lean-formalizer` + `audit-milestone` chain. Validates multi-agent approach.

**[Multi-agent Autoformalization of Tensor Network Theory](https://arxiv.org/html/2607.07857)** (arXiv:2607.07857, Jul 2026)

- **Relevance:** Medium — research-level formalization with specialized LLM agents.
- **Summary:** Agent-driven workflow for tensor network theory formalization in theoretical physics.
- **Methodology overlap:** Specialized agents (like our graph-curator, lean-formalizer) coordinated for complex physics.

### 2.5 Kac-Moody and Affine Lie Algebras

**No formalizations** in Lean/Coq/Isabelle found. Pure math literature extensive:

- [Affine Kac-Moody groups and Lie algebras in SGA3 language](https://arxiv.org/html/2107.12727v2) (Jul 2021, revised 2023) — scheme-theoretic approach, not formalized.
- [Higher Kac-Moody algebras and symmetries of holomorphic field theories](https://arxiv.org/html/1810.06534v2) (Oct 2018, Adv. Math. candidate) — extends affine Lie algebras to multivariate vertex algebras.

**Gap:** Affine Lie algebras (loop algebras) underpin heterotic string current algebras. Zero formal verification.

---

## 3. Mathematical Dependency Graphs / Proof Management

### 3.1 Dependency Graph Visualization Tools

**[KnowTeX: Visualizing Mathematical Dependencies](https://arxiv.org/abs/2601.15294)** (arXiv:2601.15294, Jan 2026)

- **Relevance:** HIGH — direct analog for our `uv run stringgraph dot` output.
- **Summary:** LaTeX package with `\uses` command to extract logical dependencies between statements, generates DOT/TikZ graphs. Applied to mathematical texts to clarify core results and proof structure.
- **Comparison to our work:**
  - **Similarities:** DAG structure, statement-level granularity, visual graph output.
  - **Differences:** KnowTeX embedded in LaTeX source (author-annotation), ours curated from published papers (post-hoc extraction). **We add epistemic status propagation** — KnowTeX only tracks dependencies, not conjecture vs. proof.
- **Gap we fill:** Multi-paper integration, status tracking, machine-readable YAML vs. LaTeX macros.

**[The Network Structure of Mathlib](https://arxiv.org/html/2604.24797v2)** (arXiv:2604.24797v2, Apr 2026)

- **Venue:** arXiv (likely JAR submission)
- **Relevance:** HIGH — analyzes Lean Mathlib's actual dependency graph extracted from compiler.
- **Summary:** When theorem formalized, Lean compiler records every premise its proof invokes, producing machine-readable dependency graph. Studies Mathlib's network topology: core lemmas, hub theorems, dependency depth.
- **Impact on our project:** Validates dependency-graph-as-first-class-object approach. Their analysis = future work for our graph/ once sufficiently large.
- **Key insight:** "No amount of informal exposition could replicate" compiler-extracted dependencies. **We do this for physics**, where compiler can't help (results not yet formalized).

**[ProofFlow: A Dependency Graph Approach to Faithful Proof Autoformalization](https://arxiv.org/html/2510.15981v1)** (arXiv:2510.15981v1, Oct 2025)

- **Relevance:** Medium — autoformalization using DAG to map proof step dependencies.
- **Summary:** Constructs DAG for logical dependencies between proof steps, lemma-based systematic formalization. Achieves 91.6% compilation success on ProofNet.
- **Comparison:** Their per-proof DAG vs. our cross-paper theorem DAG. Complementary scopes.

**[Orchestrating Mathematical Reasoning Agents with Fact-Graph Memory](https://arxiv.org/html/2607.06447)** (arXiv:2607.06447, Jun 2026)

- **Relevance:** Medium — multi-agent proof search with stateless verifier, fact-graph for coordination.
- **Summary:** Danus system with main planning agent, parallel worker agents, fact-graph memory for proved claims.
- **Impact:** Validates our Agora coordination bus + multi-agent architecture for complex mathematical projects.

### 3.2 Proof Assistant Infrastructure

**[ITPEval: Benchmarking Formal Translation Across Interactive Theorem Provers](https://arxiv.org/html/2607.19407v1)** (arXiv:2607.19407v1, Jul 2026)

- **Relevance:** Low for content, medium for infrastructure.
- **Summary:** First benchmark for automated proof translation across Lean 4, Rocq (Coq), Isabelle, HOL Light. Evaluates cross-ITP translation quality.
- **Impact:** If future work requires Coq interop (e.g., CompCert-verified extraction), ITPEval benchmarks are reference.

**[Formalizing Mathematics at Scale](https://arxiv.org/html/2605.29955v1)** (arXiv:2605.29955v1, May 2026)

- **Relevance:** Medium — autoformalization feasibility study.
- **Summary:** Shows autoformalizing graduate-level math at scale is economically and technically feasible. Opens door to automated verification of research and education content.
- **Impact:** Economic viability argument for our project's formalization line (Phase 1 Goddard-Thorn target).

**[Formalising New Mathematics in Isabelle](https://arxiv.org/html/2501.10852v1)** (arXiv:2501.10852v1, Jan 2025)

- **Venue:** arXiv (likely ITP 2025)
- **Relevance:** Medium — Ramsey number result formalized in Isabelle within months of announcement (2023).
- **Summary:** Rare example of formalizing brand-new (not textbook) mathematics. Discusses challenges: evolving definitions, proof gaps in papers.
- **Impact on our research/ track:** Validates original-proof-attempt workflow. Their challenges (definition instability, gap-finding) = why we have `physics-auditor` back-translation audit.

---

## 4. String Theory Foundational Results (Unformalised Literature)

This section surveys **published physics literature** on core results we aim to formalize. **None have machine-verified proofs.**

### 4.1 No-Ghost Theorem / Goddard-Thorn Theorem

**[The No Ghost Theorem in String Theory](https://link.springer.com/article/10.1007/BF03323095)** (Springer journal, IF ~2.0)

- **Relevance:** HIGH — directly relevant to worldsheet.no-ghost-theorem-v4.
- **Summary:** Critical dimension D=26 for bosonic string at all levels N>2. Proves no negative-norm states (ghosts) if and only if D=26 and intercept α(0)=1.
- **Proof method:** Light-cone quantization, Virasoro algebra representation theory.
- **Status in our graph:** This is a `rigorous-proof` candidate if we verify the argument holds to math standards (vs. `physical-argument`).

**[Goddard-Thorn theorem (Wikipedia)](https://en.wikipedia.org/wiki/Goddard%E2%80%93Thorn_theorem)**

- Notes "no-ghost theorem" for positive-definite inner product on physical states.
- [nLab entry](http://nlab.mathforge.org/nlab/show/Goddard-Thorn+theorem) provides category-theoretic perspective (functor from Vir modules to inner product spaces).

**arXiv:1110.5510v3** (Jun 2012) — Streamlined proof of original no-ghost theorem [Goddard, Thorn 1972; Thorn 1987, 2012].

**arXiv:1212.4429v1** (Dec 2012) — Confirms D=26 critical dimension derivation from no-ghost theorem at all levels N>2.

**arXiv:1104.4446v2** (Feb 2012) — Three methods detecting D=26: Lorentz covariance in light-cone, DDF operators, BRST cohomology.

**[No-Ghost Theorem for Neveu-Schwarz String in 0-Picture](https://arxiv.org/html/1009.0107v4)** (Sep 2010)

- **Relevance:** Medium — superstring analog, relevant for future Phase 2 RNS expansion.
- **Summary:** Proves no-ghost theorem for Neveu-Schwarz string directly in 0-picture, confirms one-to-one correspondence with conventional -1/2 picture physical states.

**[Superstring BRST no-ghost theorem at arbitrary picture number](https://arxiv.org/html/1212.3592v2)** (Dec 2012, JHEP candidate)

- **Relevance:** Medium — extends to arbitrary picture, relevant for PCO formalism in superstring graph expansion.

**Gap our project fills:** **First formal verification** of Goddard-Thorn theorem in any proof assistant. Our `formal/StringFormal/Worldsheet/Virasoro/NoGhost.lean` target.

### 4.2 BRST Cohomology in String Theory

**[The BRST cohomology of the NSR string: Vanishing and "no-ghost" theorems](https://link.springer.com/doi/10.1007/BF01218471)** (Comm. Math. Phys. 124, 105-132, 1989, **IF 5.4**)

- **Relevance:** HIGH — BRST formulation of no-ghost theorem, likely more amenable to formalization than OCQ.
- **Authors:** Figueroa-O'Farrill, Kimura
- **Summary:** Investigates BRST cohomology of NSR string, proves vanishing theorems for full and relative complexes, generalizes Frenkel-Garland-Zuckerman (bosonic string) to superstring.
- **Published in CMP** — strong mathematical rigor, likely upgradeable to fully rigorous proof with effort.
- **Status in our graph:** Target for `brst.nsr-cohomology-vanishing` node (future Phase 2).

**[BRST Cohomology of the Super-Virasoro Algebras](https://projecteuclid.org/journalArticle/Download?urlId=cmp/1104179468)** (Comm. Math. Phys. 125, 301-335, 1989, **IF 5.4**)

- **Relevance:** HIGH — foundational for BRST quantization of superstring.
- **Summary:** Computes BRST cohomology for super-Virasoro algebras.
- **Strong candidate for formalization** given CMP publication standards.

**arXiv:hep-th/0104110v2** (Apr 2001) — BRST cohomology for NSR (1,1) superstring models, relates to Noether currents, background charges, gauge anomalies.

**arXiv:hep-th/9712182v1** (Dec 1997) — BRST procedure for quantum string theories, physical states as BRST cohomology classes.

### 4.3 Critical Dimension & Anomaly Cancellation

**[Anomaly cancellation in ten dimensions](https://arxiv.org/html/hep-th/9709012v1)** (Sep 1997)

- **Relevance:** HIGH — D=10 restriction for consistent superstring theories, Green-Schwarz mechanism.
- **Summary:** Green-Schwarz mechanism allows anomaly cancellation for SO(32) and E8×E8 heterotic strings. Restricts consistent theories in 10D.
- **Status:** Physical argument (perturbative + cohomological). Not rigorous in math sense.
- **Our graph target:** `anomalies.d10-classification` node, status `physical-argument` or `conjecture` depending on gaps.

**[Anomaly Inflow and Gauge Group Topology in 10d Sugimoto String Theory](https://arxiv.org/pdf/2412.17894v3)** (Dec 2024, JHEP candidate)

- **Relevance:** Medium — Recent work on Green-Schwarz anomaly inflow via RR fields.
- **Summary:** Perturbative and global fermion anomaly in Type I string cancelled by GS mechanism using RR fields.

**[Trivialization of gravitational Green-Schwarz mechanism in non-relativistic limit](https://arxiv.org/html/2507.07172v1)** (Jul 2025)

- **Relevance:** Low — non-relativistic limit, but confirms GS mechanism centrality to string consistency.

**[Anomaly Cancellation and Modularity](https://arxiv.org/html/1205.0718v1)** (May 2012)

- **Relevance:** Medium — Alvarez-Gaum-Witten miraculous cancellation derived from modularity of partition functions.
- **Summary:** Shows Type IIB anomaly cancellation follows from modularity of certain characters. Elegant approach, but not formalized.

**[Type IIA String Theory and tmf with level structure](https://arxiv.org/html/2411.07299v2)** (Nov 2024)

- **Relevance:** Medium — Green-Schwarz anomaly cancellation requires spin structure + trivialization of string class.
- **Connects to homotopy theory** (topological modular forms), potential future formalization avenue.

**Gap our project fills:** Systematic dependency tracking from D=10 classification back to BRST, partition function modularity, Green-Schwarz mechanism. **No existing project connects these dots in machine-readable form.**

### 4.4 Modular Invariance & Partition Functions

**[Modular invariance, misalignment and finiteness in non-supersymmetric strings](https://link.springer.com/doi/10.1007/JHEP01(2022)127)** (JHEP 01(2022)127, **IF 5.0**)

- **Relevance:** Medium — modular invariance for open strings (subtler than closed), leads to physical quantity cancellations.
- **Summary:** Argues modular invariance crucial even for open strings despite subtlety. Connects to tadpole cancellation.

**[Modular invariance in superstring theory from N=4 SYM](https://link.springer.com/article/10.1007/JHEP11(2020)016)** (JHEP 11(2020)016, **IF 5.0**)

- **Relevance:** Medium — derives string modular invariance from localization in mass-deformed N=4 SYM sphere partition function.

**[Notes on massless scalar field partition functions, modular invariance and Eisenstein series](https://link.springer.com/article/10.1007/JHEP12(2021)211)** (JHEP 12(2021)211, **IF 5.0**)

- **Relevance:** Medium — massless scalar on ℝ^(d-1)×𝕋² with chemical potential, relates partition function to modular forms and Eisenstein series.

**Gap:** Modular invariance treated as consistency check in physics, not formalized. **Our graph explicitly tracks modular invariance as constraint** (`conventions/modular-conventions.yaml`).

### 4.5 Black Hole Entropy & String Microstates (Future Phase 3)

**[Black holes and D-branes](https://arxiv.org/html/hep-th/9705078v1)** (May 1997, foundational review)

- **Relevance:** Medium for Phase 3 — D-brane microstate counting for extremal/near-extremal black holes.
- **Summary:** String theory provides microscopic quantum description of black hole thermodynamics via D-brane states.

**[Note on Pure D-brane (non-)BPS Black Hole Microstate Counting in Type IIA](https://arxiv.org/html/2601.07927v2)** (Jan 2026, JHEP candidate)

- **Relevance:** Medium — recent microstate counting, relevant if Phase 3 reaches N=4 dyon entropy.

**Historical-philosophical analysis papers** (arXiv:1904.03234v2, JHEP 10(2019)017) analyze string theory's black hole entropy programme. Not technical sources but useful for understanding which results are "conjectures dressed as theorems."

---

## 5. Gap Analysis & Competitive Positioning

### 5.1 Unique Value Propositions of Our Project

1. **First systematic string theory formalization project**: No competitor exists attempting comprehensive string theory result curation + formalization.

2. **Epistemic status tracking at scale**: Seiberg-Witten Lean paper tracks axioms for one result; we track status across 50 years of interdependent results. KnowTeX visualizes dependencies; we add conjecture vs. proof distinction.

3. **Multi-paper integration**: Physicslib formalizes isolated QFT results; we integrate worldsheet CFT + spacetime SUGRA + anomalies + dualities into single dependency graph.

4. **Audited milestone system**: MerLean back-translates LaTeX↔Lean; we back-translate YAML/Lean→natural language for physicist review, catching formalization drift.

5. **Original research track**: Identifies provably-unpublished gaps (e.g., if no source proves certain duality chains) and attempts original proofs in `research/`, rather than assuming "someone must have done this."

### 5.2 Results That Would Validate Our Approach

If we successfully formalize **worldsheet.no-ghost-theorem-v4** (Goddard-Thorn D=26) in Lean 4 with **no axioms beyond Mathlib**, we achieve:

- **First formalized string theory theorem** in any proof assistant.
- **First Virasoro representation theory formalization** tied to physics application.
- Proof-of-concept that `physical-argument` → `formalized` pipeline works for 1970s foundational string results.

This would be **publishable in J. Automated Reasoning** or **ITP conference** as "Case Study: Formalizing String Theory's No-Ghost Theorem."

If we classify D=10 anomaly cancellation with full dependency chains to BRST + GS mechanism + modularity, we deliver:

- **First machine-readable map** of string consistency conditions.
- Demonstrates our epistemic status propagation catches where D=10 rests on `conjecture` vs. `rigorous-proof`.

### 5.3 Overlaps to Monitor (Potential Scooping Risk)

**Low risk overall** — no group working on comprehensive string formalization. Specific risks:

1. **Physicslib expansion**: If they pivot from QFT/QM to CFT/string, could formalize Virasoro before us. **Mitigation:** Our graph work (already unique) + faster Lean formalization via lean-formalizer agent.

2. **N=2 SYM Lean follow-up**: Seiberg-Witten Lean authors might extend to string-related gauge theories. **Low overlap** — different domain (gauge theory vs. worldsheet CFT).

3. **MerLean or similar autoformalization**: Could formalize string theory textbook sections faster than manual curation. **Mitigation:** Our value is dependency graph + status tracking, not just formalization speed.

### 5.4 Collaboration Opportunities

1. **Physicslib contributors**: Potential upstream for our `formal/` Lean code if they want string/CFT content.

2. **KnowTeX developers**: Could adopt our YAML schema for epistemic status tags in their LaTeX dependency graphs.

3. **MerLean team**: Their autoformalization pipeline could accelerate our `literature/extractions/` → `graph/` → `formal/` flow.

4. **Mathlib Virasoro algebra PR**: If we formalize Virasoro cleanly, upstream to Mathlib as `Mathlib.Algebra.Lie.Virasoro` (currently absent).

---

## 6. High-Impact Venues for Our Results

Based on related work venues:

### 6.1 Formalization Track (Lean Code + Graph)

- **Journal of Automated Reasoning** (IF 3.3) — Formalizing New Mathematics paper precedent.
- **ITP (Interactive Theorem Proving)** conference — Annual venue for proof assistant work.
- **CPP (Certified Programs and Proofs)** — Co-located with POPL, formalization focus.

**Target paper:** "Formalizing String Theory's No-Ghost Theorem and Building a Dependency Graph for Physical Arguments."

### 6.2 Physics Track (Original Proofs from research/)

- **Journal of High Energy Physics (JHEP)** (IF 5.0) — If we prove genuinely new string results (e.g., complete proof of some duality previously only sketched).
- **Communications in Mathematical Physics (CMP)** (IF 5.4) — If results have strong mathematical rigor (close to Figueroa-O'Farrill BRST cohomology level).
- **Journal of Mathematical Physics** (IF 1.6) — Lower bar, accepts mathematical methods in physics.

**Target paper:** "Rigorous Proof of [Gap We Filled]: A Formal-Verification-Assisted String Theory Result."

### 6.3 Methodology Track (Dependency Graph Tool + Epistemic Status Propagation)

- **Science of Computer Programming** — Software tools for scientific computing.
- **Journal of Open Source Software (JOSS)** — If we release `stringgraph` Python tool as standalone open-source (currently internal).

**Target paper:** "Epistemic Status Propagation in Mathematical Physics Dependency Graphs: A Case Study in String Theory."

---

## 7. Literature to Monitor (2026-2027)

### High-priority ongoing work:

1. **Physicslib GitHub** (`leanprover-community/Physlib`) — Watch for CFT/Virasoro additions.
2. **arXiv hep-th new listings** — Weekly scan for "formalization," "Lean," "rigorous proof" + "string theory."
3. **ITP/CPP/JAR accepted papers** — Annual check for physics formalization projects.
4. **JHEP/CMP anomaly cancellation papers** — D=10 classification updates.

### Keywords for alerts:

- "string theory" + ("Lean" OR "Coq" OR "Isabelle" OR "formalization")
- "no-ghost theorem" + "proof"
- "BRST cohomology" + "rigorous"
- "Virasoro algebra" + ("formalization" OR "Mathlib")
- "dependency graph" + ("physics" OR "proof")

---

## 8. Conclusion

**Competitive landscape:** Wide open. No direct competitors in string theory formalization or multi-result epistemic dependency tracking. Adjacent fields (QFT formalization, autoformalization tools, Lean physics libraries) advancing rapidly but not overlapping our core mission.

**Strategic positioning:** First-mover advantage in string theory formalization. High publication potential in both CS (JAR/ITP) and physics (JHEP/CMP) venues. Collaboration opportunities with Physicslib, MerLean, KnowTeX communities.

**Immediate priorities (informed by this survey):**

1. **Accelerate Goddard-Thorn formalization** before Physicslib or others reach Virasoro.
2. **Document epistemic status methodology** for standalone methods paper (not waiting for full graph completion).
3. **Engage Physicslib maintainers** — propose `Mathlib.Physics.CFT.Virasoro` contribution path.
4. **Monitor Seiberg-Witten Lean authors** — potential collaboration on "physical axioms in Lean" methodology paper.

**Validation metric:** If another group cites our graph YAML or Lean code within 2 years of public release, we've established the standard for physics formalization dependency tracking.

---

## Sources

### String Theory & No-Ghost Theorem
- [arXiv:1110.5510v3 - No-ghost theorem streamlined proof](https://arxiv.org/pdf/1110.5510.pdf)
- [Superstring BRST no-ghost theorem](https://arxiv.org/html/1212.3592v2)
- [Goddard-Thorn theorem (Wikipedia)](https://en.wikipedia.org/wiki/Goddard%E2%80%93Thorn_theorem)
- [The No Ghost Theorem in String Theory (Springer)](https://link.springer.com/article/10.1007/BF03323095)
- [No-Ghost Theorem for Neveu-Schwarz String](https://arxiv.org/html/1009.0107v4)
- [arXiv:1212.4429v1 - Critical dimension D=26](https://arxiv.org/pdf/1212.4429)
- [arXiv:1104.4446v2 - Three methods for D=26](http://arxiv.org/pdf/1104.4446)

### Formalization Projects
- [Formalization of QFT (Osterwalder-Schrader, Lean 4)](https://arxiv.org/html/2603.15770)
- [Formalization of QFT (OpenReview)](https://openreview.net/pdf?id=LxW54SEDPo)
- [Axioms for physical reasoning: Seiberg-Witten in Lean](https://arxiv.org/html/2607.06379)
- [Physicslib (Lean Reservoir)](https://reservoir.lean-lang.org/@physicslib/Physicslib)
- [P(Φ)₂ Euclidean QFT in Lean 4](https://reservoir.lean-lang.org/@mrdouglasny/pphi2)
- [Digitalizing Wick's theorem](https://arxiv.org/html/2505.07939v1)
- [Formalizing Mathematics at Scale](https://arxiv.org/html/2605.29955v1)
- [Formalising New Mathematics in Isabelle](https://arxiv.org/html/2501.10852v1)

### Quantum Information in Lean
- [Lean-Quantum: AI-Assisted Formalization](https://arxiv.org/abs/2607.05492)
- [Lean-QuantumInfo GitHub](https://github.com/Timeroot/Lean-QuantumInfo)
- [MerLean: Agentic Autoformalization](https://arxiv.org/html/2602.16554v1)
- [Multi-agent Autoformalization of Tensor Networks](https://arxiv.org/html/2607.07857)
- [Physlib (Quantum + Particle Physics)](https://reservoir.lean-lang.org/@leanprover-community/Physlib)

### Dependency Graphs
- [KnowTeX: Visualizing Mathematical Dependencies](https://arxiv.org/abs/2601.15294)
- [The Network Structure of Mathlib](https://arxiv.org/html/2604.24797v2)
- [ProofFlow: Dependency Graph Autoformalization](https://arxiv.org/html/2510.15981v1)
- [Orchestrating Mathematical Reasoning Agents](https://arxiv.org/html/2607.06447)
- [PRISM-Physics: Causal DAG Process Evaluation](https://arxiv.org/pdf/2510.03185v1)

### BRST Cohomology
- [BRST cohomology of NSR string (Comm. Math. Phys.)](https://link.springer.com/doi/10.1007/BF01218471)
- [BRST Cohomology of Super-Virasoro (Comm. Math. Phys.)](https://projecteuclid.org/journalArticle/Download?urlId=cmp/1104179468)

### Anomaly Cancellation
- [Anomaly cancellation in 10D (Green-Schwarz)](https://arxiv.org/html/hep-th/9709012v1)
- [Anomaly Inflow in 10d Sugimoto String](https://arxiv.org/pdf/2412.17894v3)
- [Trivialization of gravitational GS mechanism](https://arxiv.org/html/2507.07172v1)
- [Anomaly Cancellation and Modularity](https://arxiv.org/html/1205.0718v1)
- [Type IIA String Theory and tmf](https://arxiv.org/html/2411.07299v2)

### Modular Invariance
- [Modular invariance in non-SUSY strings (JHEP)](https://link.springer.com/doi/10.1007/JHEP01(2022)127)
- [Modular invariance from N=4 SYM (JHEP)](https://link.springer.com/article/10.1007/JHEP11(2020)016)
- [Scalar partition functions and Eisenstein series (JHEP)](https://link.springer.com/article/10.1007/JHEP12(2021)211)

### Seiberg-Witten & N=4
- [Global forms of N=4 theories](https://arxiv.org/html/2510.02055v2)

### Black Hole Entropy
- [Black holes and D-branes](https://arxiv.org/html/hep-th/9705078v1)
- [D-brane Black Hole Microstate Counting](https://arxiv.org/html/2601.07927v2)

### Infrastructure
- [ITPEval: Benchmarking Formal Translation](https://arxiv.org/html/2607.19407v1)
- [Process-Verified RL for Theorem Proving](https://arxiv.org/pdf/2606.20068v1)
