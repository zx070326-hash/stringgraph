# Can Computational Verification Reveal Errors in Published Theoretical Physics?

**Assessment Date:** 2026-09-16  
**Context:** Our project discovered an internal contradiction in Dabholkar-Gomes-Murthy arXiv:0803.2692 through computational verification. This document evaluates whether "systematic verification finds errors in published theoretical physics" is a viable high-impact research program.

## Executive Summary

**Verdict: Real opportunity with significant risks. Proceed carefully with proper framing.**

**The case for viability:**
- First precedent exists (2026 Higgs doublet model paper)
- String theory microstate counting is understudied and high-stakes
- Our dependency graph infrastructure makes systematic auditing feasible
- Physics maintains high standards (5σ) but theoretical physics lacks the reproducibility culture of experimental physics

**The case for caution:**
- Career risks are real, especially for early-career researchers
- No universal threshold for "how many errors make a story"
- Publication venues for error-finding papers remain uncertain
- Risk of being seen as attacking colleagues rather than improving the field

**Recommendation:** Pursue as a secondary output of the formalization program, not the primary goal. Frame as "verification-driven discovery" rather than "error hunting."

## 1. Precedent: Has Anyone Done This Before?

### 1.1 The Higgs Doublet Model Case (2026)

The first documented case of computational verification finding an error in a physics paper occurred in 2026. Researchers formalizing the stability of the two Higgs doublet model (2HDM) potential using Lean discovered a fundamental error in a widely cited 2006 paper by Nagel ([arXiv:2603.08139](https://arxiv.org/html/2603.08139v1), [New Scientist coverage](https://www.newscientist.com/article/2520546-computer-finds-flaw-in-major-physics-paper-for-first-time/)).

**Key details:**
- The paper was 20 years old, well-cited, by a respected author
- The error invalidated the main theorem about 2HDM stability
- Discovery was made possible by projects like Mathlib and PhysLib
- The researcher noted this raised concerns about "how many other physics papers might contain similar errors"

**Critical observation:** This is described as the **first** physics paper where formal verification found an error, suggesting the field is still nascent.

### 1.2 Mathematics: Some Precedent But Limited

[Formal verification in mathematics](https://arxiv.org/html/2606.03835v2) has primarily focused on **building verified corpora** rather than systematically finding errors in published work. However:

- **Lean benchmark audits (2026):** Researchers auditing five widely used Lean theorem-proving benchmarks found [4,833 issues including 398 mechanically certified problems](https://arxiv.org/abs/2606.29493) such as counterexamples, vacuous theorems, and unsound axioms
- **Symbolic proof audit (2026):** An [audit of a symbolic invertibility proof](https://arxiv.org/html/2608.13067) found that while the intended theorem wasn't refuted, the published certificate did not actually prove the claimed conclusion
- **"Some Instructive Mathematical Errors":** [Jonathan Borwein's paper](https://arxiv.org/html/2106.07269v3) documents significant errors by highly-regarded mathematicians that weren't detected for years, demonstrating that even top-tier work contains mistakes worth studying
- **Citation integrity:** Approximately [20% of citations contain errors](https://arxiv.org/abs/2511.04683), highlighting systematic problems in academic verification

**However:** These are mostly retrospective catalogues or benchmark audits, not systematic verification campaigns targeting published literature.

### 1.3 Retraction Patterns in String Theory/Mathematical Physics

Our search found [limited retraction patterns specifically in string theory](https://en.wikipedia.org/wiki/String_theory). While retractions are increasing across scientific publishing generally ([Retraction Watch](https://retractionwatch.com/)), string theory's main documented challenges are:
- Conceptual/theoretical issues (lack of testability, landscape problem)
- Not systematic mathematical errors leading to retractions

**Key finding:** The absence of retractions doesn't mean absence of errors—it may mean absence of checking.

## 2. The Liquid Tensor Experiment: A Model for Reception

### 2.1 What Made It Notable

The [Liquid Tensor Experiment](http://www.tandfonline.com/doi/full/10.1080/10586458.2021.1926016) (Scholze-Buzzard, 2020-2022) provides the closest analogy to what we're proposing, though with a crucial difference.

**What happened:**
- Fields Medalist Peter Scholze publicly questioned part of his own proof
- The Lean community verified it collaboratively over 18 months
- Successfully completed July 14, 2022
- Published in *Experimental Mathematics*

**Why it was well-received:**
- Scholze was verifying his **own** work, not attacking others
- Demonstrated feasibility of formalizing cutting-edge contemporary mathematics
- Showed a Fields Medalist actively sought computer verification (cultural shift)
- Collaborative, open-source model
- Bridged abstract mathematics and formal verification communities

**Critical difference from our case:** This was **self-verification**, not finding errors in others' work. The social dynamics are completely different.

### 2.2 Reception Factors

The LTE became a landmark case study frequently cited in discussions about the future of mathematical proof. Key factors:
- **Humility framing:** Scholze "with humility reached out to the math community"
- **Positive construction:** Building something new (formalized proof) rather than tearing down existing work
- **Community benefit:** Validated proof assistant technology for frontier mathematics
- **No losers:** Nobody's reputation was harmed

## 3. The Reproducibility Crisis: Thresholds and Norms

### 3.1 Physics vs. Other Fields

Physics appears [less affected by the reproducibility crisis](https://www.pnas.org/doi/10.1073/pnas.1708272114) than psychology, biology, or even machine learning:

- Physicists use a strict **5σ threshold** (1 in 3.5 million chance) for discovery claims
- This is far more stringent than the p < 0.05 used in many other fields
- In surveys, physicists were most confident in reproducibility of published results
- However, physicists were also **least likely (24%) to have taken concrete steps to improve reproducibility**

**The "Theory Crisis" vs. Replication Crisis:**

A [January 2025 analysis](https://statmodeling.stat.columbia.edu/2025/01/13/the-theory-crisis-in-physics-compared-to-the-replication-crisis-in-social-science-two-different-opinion-field-inversions-that-differ-in-some-important-ways/) distinguishes between:
- **Social sciences:** Failed replications drive the crisis
- **Physics:** Theories so flexible they can explain any result (unfalsifiable) drive the concern—theoretical stagnation rather than replication failure

**String theory specifically** fits the "theory crisis" pattern: the landscape problem and lack of testability are bigger concerns than computational errors in published papers.

### 3.2 Error Thresholds

**There is no universal threshold** for "how many errors make a publishable story."

The reproducibility crisis gained traction through:
- **Scale:** 40-70% of researchers agreeing practices contribute to irreproducibility ([Nature survey](https://www.nature.com/articles/533452a))
- **Replication studies:** 50% average failure rate in biomedical/behavioral sciences
- **Systemic patterns:** [Nature's "Reproducibility: A tragedy of errors"](https://www.nature.com/articles/doi:10.1038/530027a) examined error rates across fields

**For our case:** A single high-impact error (like ours in DGM 2008) might be publishable if:
1. The paper is widely cited and influential
2. The error affects important conclusions
3. The discovery method is generalizable
4. We can show the error was non-obvious and required systematic verification to find

**Multiple errors** would strengthen the case but aren't strictly necessary if the single error is significant enough.

### 3.3 What Makes Errors "Interesting"

[Borwein's "instructive errors"](https://arxiv.org/html/2106.07269v3) framework: errors by smart people that lead to interesting mathematics are valuable. Similarly, [MathOverflow discussions](https://mathoverflow.net/questions/879/most-interesting-mathematics-mistake/9653) highlight that famous mistakes (Poincaré's 3D sphere, Euclid's parallel axiom) drove important developments.

**Our DGM case qualifies:** The eq(51)/eq(52) contradiction involves number-theoretic Kloosterman sums and has been built upon in subsequent work ([arXiv:1111.1161](https://arxiv.org/abs/1111.1161v2), [arXiv:1404.0033](https://arxiv.org/abs/1404.0033v2), [arXiv:1012.0265](https://arxiv.org/abs/1012.0265v3)). Understanding the error could clarify the foundations of black hole microstate counting.

## 4. Success Stories: When Error-Finding Works

### 4.1 Formal Methods in Safety-Critical Systems

The most successful error-finding through formal methods has been in software:

**seL4:** The [formally verified microkernel](https://sel4.systems/About/seL4-whitepaper.pdf) eliminates entire classes of bugs (buffer overflows, null pointer exceptions, use-after-free) through machine-checked proofs. However, this is **pre-deployment verification**, not finding errors in published work.

**CompCert:** The [formally verified C compiler](https://cacm.acm.org/research/formal-verification-of-a-realistic-compiler/) is proven exempt from miscompilation bugs within its verified scope. When researchers found [three bugs in CompCert](https://cantina.xyz/blog/how-we-found-three-bugs-in-a-compiler-proven-correct), they were "at the edges of formal verification"—the proof itself held. For context: random testing found over 325 bugs in other compilers over 2.5 years.

**DO-178C in aviation:** [Formal methods in airborne software](https://www.mdpi.com/2079-9292/9/2/327/htm) are mandated by industry standards and play an essential role in finding errors before deployment.

**Key pattern:** These are all **prospective verification** (preventing errors) not **retrospective auditing** (finding errors in published claims). The social dynamics are completely different.

### 4.2 "Six Textbook Mistakes in Computational Physics"

The paper ["Six textbook mistakes in computational physics"](https://arxiv.org/html/2006.08592v2) identifies widespread misconceptions across multiple textbooks. This is closer to what we're proposing—finding errors in published work.

**Why it worked:**
- Systematic errors that propagated through literature
- Pedagogical value (helps future students avoid mistakes)
- Not attacking individuals but correcting widespread misconceptions
- Framed as improving the field

### 4.3 The Polymath Project: Cultural Norms Around Errors

The [Polymath Project](http://www.cs.cmu.edu/~jcransh/papers/cranshaw_kittur.pdf) demonstrated a tolerant approach to errors in collaborative mathematics:
- Informal "blog maths" allowed flexible practices
- Errors were expected and normalized as part of exploration
- Intensive exchange (27 people, 800 comments, 170,000 words in 37 days) created rapid error detection
- One concern: whether public collaboration might "damage a hard-earned mathematical reputation"

**Lesson:** Error tolerance works in **collaborative exploration** contexts but may not extend to **retrospective auditing** of established work.

## 5. Career Risks: The Professional Norms

### 5.1 The Social Reality

[Research on error correction norms](https://www.ncbi.nlm.nih.gov/books/NBK232225/) reveals a troubling gap between official norms and reality:

**Official norm:** "Scientists who acknowledge honest mistakes promptly and openly are rarely condemned by colleagues."

**Reality:**
- Publishing corrections can feel "cruel" and "would likely turn my peers against me" ([Academia StackExchange discussions](https://academia.stackexchange.com/questions/121709/what-is-the-proper-action-when-peers-in-your-field-have-are-publishing-papers-wi))
- Fear of retaliation, particularly when critiquing senior researchers ([PLOS blogs](http://blogs.plos.org/absolutely-maybe/2018/03/22/signing-critical-peer-reviews-the-fear-of-retaliation-what-should-we-do/))
- The academic economy rewards novelty over accuracy; post-publication critique counts for little
- [Scientific communities can harbor bullies](https://cacm.acm.org/opinion/where-review-goes-wrong/) who may retaliate

### 5.2 Career Impact Data

**Retractions:** [Recent research](https://www.nature.com/articles/s41562-025-02154-0) found that retracted authors, particularly early-career researchers, tend to leave scientific publishing after a retraction. However:
- Retractions are associated with misconduct more than honest errors
- Simple errata typically won't harm a career
- **Finding errors in others' work** has unclear impact—there's no systematic study

**Innocent co-authors suffer:** Even scientists not responsible for errors face ["guilt by association"](https://ftp.zew.de/pub/zew-docs/ioekeval2019/HussingerPellens.pdf)—career damage through social stigmatization and limited collaboration opportunities.

**Early-career vs. established:** Retractions impose [disproportionate impact on early-career researchers](https://arxiv.org/html/2306.06710v2) compared to established scientists.

### 5.3 The Asymmetry Problem

[Research on scientific accountability](https://www.qeios.com/read/M4GGKZ/pdf) identifies a troubling asymmetry:
- When scientists are correct → both their work and their reputation benefit
- When errors are discovered → only the work is criticized, the individual is shielded from personal responsibility
- This creates misaligned incentives

**For error-finders:** The asymmetry works against you. You do the work of finding the error, but the credit is diffuse while the social cost (being seen as attacking colleagues) is concentrated on you.

### 5.4 Mathematics-Specific Concerns

[Errors in mathematics research are especially critical](https://www.tandfonline.com/doi/full/10.1080/23311886.2023.2244259), but questions about proper journal management to maintain correctness have received comparatively little attention. The mathematics publishing process faces unique reliability challenges.

## 6. Where Would This Be Published?

### 6.1 The Venue Question

Our search found no clear precedent for papers titled "Systematic verification reveals errors in [field] literature" in top-tier venues like Nature or PNAS.

**Possibilities:**
- **Nature/Science/PNAS:** Would require framing as a methodological breakthrough or crisis revelation, not just finding errors
- **Experimental Mathematics:** Published the Liquid Tensor Experiment; focuses on computer-assisted mathematics
- **Field-specific journals:** JHEP, Nuclear Physics B for string theory errors
- **Computing/verification venues:** Likely more receptive but lower impact for physics community

**The 2026 Higgs doublet case:** Published on arXiv (2603.08139) with New Scientist coverage. No indication yet of publication in traditional physics journals.

### 6.2 Framing Matters

Successful framing options:
1. **"Verification-driven discovery":** Emphasize what we learned, not just what was wrong
2. **"Computational tools for theoretical physics":** Focus on methodology
3. **"Foundations of black hole microstate counting":** Focus on clarifying the field
4. **"Case study in formal methods for physics":** Methodological contribution

Unsuccessful framing:
1. ~~"We found errors in published work"~~ → attacking colleagues
2. ~~"The literature is unreliable"~~ → alienating the community
3. ~~"Systematic audit reveals widespread problems"~~ → unless you have widespread problems

## 7. Is This a Viable Research Program?

### 7.1 Our Unique Position

**Advantages:**
- **Infrastructure:** 660 statements in dependency graph with rigorous status tracking
- **High-traffic nodes:** Can systematically audit results many other results depend on
- **Formalization pipeline:** Lean verification catches errors humans miss
- **Understudied field:** Black hole microstate counting hasn't faced the scrutiny of, say, the Standard Model
- **High stakes:** These results connect to fundamental questions (information paradox, quantum gravity)

**Current status (from ROADMAP.md):**
- 660 statements, 555 derivations, 5 milestones, 24 conventions
- Effective status: formalized=104, rigorous=116, physical-argument=371, conjecture=28, refuted=1, open=40
- Lean verification: 99 declarations, axiom-clean

**The DGM finding:** eq(51) and eq(52) mutually inconsistent, demonstrated by explicit integer witness I=2, charges (4,1,2). Paper is 18 years old, well-cited (built upon in arXiv:1111.1161, 1404.0033, 1012.0265), no erratum.

### 7.2 Systematic Auditing Strategy

**Most promising targets in our graph:**
1. **High-traffic nodes:** Results with many dependents (use `stringgraph why` to find bottlenecks)
2. **Physical-argument status:** 371 statements currently marked as physical arguments—likely sources of gaps
3. **Conjecture nodes:** 28 conjectures—can we find counterexamples or invalidated assumptions?
4. **Superseded chain:** 76 superseded statements—why were they replaced? Were there errors?

**Methodology:**
1. Select high-impact nodes (many dependents, frequently cited)
2. Attempt Lean formalization
3. Document gaps, assumptions, and contradictions
4. Cross-check with original papers and subsequent citations
5. Maintain adversarial posture (actively try to break claims)

### 7.3 Expected Yield

**Conservative estimate:** In 660 statements, with 371 marked physical-argument (heuristic reasoning, not rigorous), we might find:
- 5-10 internal contradictions (like DGM)
- 20-30 gaps where claimed derivations don't actually follow
- 10-15 superseded results that were quietly corrected without acknowledgment

**Optimistic estimate:** If black hole microstate counting is under-audited, we might find one DGM-scale error per 100-200 statements attempted for formalization.

**Comparison:** The Lean benchmark audit found 398 issues in benchmark problems designed to be correct. Published physics papers might have higher error rates.

### 7.4 Risks Specific to Our Case

**Academic risks:**
- Dabholkar, Gomes, Murthy are established, respected researchers
- Subsequent work built on their results—we'd be disrupting a research program
- String theory community is relatively small; reputation matters
- Early-career researchers on our team face higher risk

**Technical risks:**
- Our witness (I=2, charges (4,1,2)) might have a resolution we haven't seen
- The error might be acknowledged informally in the community
- Subsequent papers might contain implicit corrections

**Strategic risks:**
- Becoming known as "the error-finding project" rather than "the formalization project"
- Difficulty publishing error-finding results
- Potential retaliation (grant reviews, paper reviews, conference invitations)

## 8. Recommendations

### 8.1 Primary Recommendation: Pursue as Secondary Output

**Don't pivot to error-hunting.** Continue the formalization program as planned, but:

1. **Document errors as we find them** (we already do this)
2. **Build a private database** of issues before going public
3. **Wait for pattern to emerge** (one error is interesting; systematic patterns are publishable)
4. **Develop methodology paper** showing how formalization reveals errors

### 8.2 Framing Strategy

**If/when we publish on DGM:**

**Good framing:**
- "Formal verification as a tool for clarifying black hole microstate counting"
- "Case study: What computational verification reveals about theoretical physics"
- "Foundations of dyon counting: A formal analysis"
- Lead with what we **learned**, not what was **wrong**

**Bad framing:**
- "Errors in Dabholkar-Gomes-Murthy 2008"
- "Systematic problems in string theory literature"
- Anything that sounds like an attack

**Tone:**
- Respectful ("subsequent work has clarified..." not "the authors were wrong")
- Constructive ("our formalization revealed an opportunity to strengthen..." not "we found a fatal flaw")
- Collaborative ("we reached out to the authors" if true)
- Humble ("formal verification helps us all")

### 8.3 Protective Measures

**Before going public:**

1. **Captain confirmation required** (per ROADMAP: "副产品：DGM 0803.2692 eq(51)/(52) 互不相容（显式整数见证 I=2,(4,1,2))——**这是对外声明，船长确认前不得公开宣称**（暂缓，等第三方交叉核）")
2. **Independent verification:** Have someone outside the project verify the contradiction
3. **Author contact:** Consider privately contacting Dabholkar/Gomes/Murthy before publication (risky but professional)
4. **Venue strategy:** Target sympathetic venue (formal methods journal?) before field-specific journal
5. **Team protection:** Senior researchers should be primary authors on error papers to shield early-career team members

### 8.4 Alternative: The Positive Program

**Instead of "we found errors," pursue:**

**"Formal verification reveals gaps and opportunities in black hole microstate counting"**

Contents:
1. Overview of formalization program
2. Categories of gaps found:
   - Unproven lemmas assumed in subsequent work
   - Physical arguments that could be made rigorous
   - Open conjectures that clarify the dependence graph
3. The DGM case as **one example** among several
4. Methodology: how others can apply this approach
5. Call to action: collaborative verification

**This reframes error-finding as a positive contribution to the field.**

### 8.5 Timeline Recommendation

**2026-2027:** Continue formalization, build private database of issues  
**2027-2028:** If pattern emerges (5+ significant issues), draft methodology paper  
**2028+:** Consider publication once:
- Pattern is clear
- Multiple independent verifications obtained
- Team has institutional security (grants, positions)
- Venue and framing strategy tested

**Do not rush to publish based on single DGM finding.**

## 9. Answering the Original Questions

### Q1: Has anyone published a systematic study of errors in theoretical physics literature?

**No.** The 2026 Higgs doublet case is the first documented instance. No systematic study exists.

### Q2: How was the Liquid Tensor Experiment received?

**Very positively,** but it was self-verification by a Fields Medalist, not finding errors in others' work. Published in *Experimental Mathematics*, became a landmark case study. The social dynamics don't transfer to our case.

### Q3: Are there documented cases of significant errors in string theory?

**Not systematic documentation.** Retractions are rare. The field's main challenges are theoretical (unfalsifiability) rather than computational errors. This suggests either (a) the literature is unusually clean, or (b) verification is insufficient.

### Q4: Any projects systematically verifying published theorems?

**Lean benchmarks found 398 issues** in supposedly correct problems. But these are benchmark audits, not systematic literature verification. Formal methods in mathematics focus on building verified corpora, not auditing published work.

### Q5: How many errors make a publishable story?

**No universal threshold.** One high-impact error (like DGM) could be publishable with proper framing. Multiple errors strengthen the case. Pattern recognition (systematic issues) is most publishable.

### Q6: Where would this be published?

**Uncertain.** Options: Experimental Mathematics, field-specific journals (JHEP), computing venues. Framing as methodology paper improves chances. Nature/Science unlikely unless positioned as crisis or breakthrough.

### Q7: Can we systematically audit highest-traffic nodes?

**Yes, and it's viable.** Our 660-statement graph with 371 physical-arguments and 28 conjectures provides systematic audit targets. Use dependency analysis to find high-traffic bottlenecks.

### Q8: Is finding errors a good career move?

**Risky, especially for early-career researchers.** Fear of retaliation is real. Asymmetric incentives work against error-finders. However:
- Framing as "verification-driven discovery" reduces risk
- Senior researchers fronting papers protects juniors
- Methodological contribution (not just finding errors) is safer
- String theory community may be more receptive than some fields (active pursuit of rigor)

## 10. Final Verdict

**This is a real opportunity, but it's a trap if pursued as the primary goal.**

**Do:**
- Continue formalization program
- Document errors systematically as we find them
- Build methodology for verification-driven discovery
- Wait for pattern to emerge
- Frame positively (what we learned, not who was wrong)
- Protect early-career team members

**Don't:**
- Pivot to error-hunting as primary mission
- Rush to publish based on single DGM finding
- Frame as attacking individuals or the field
- Let junior researchers be primary authors on error papers
- Assume academic norms will protect us (they won't)

**The meta-lesson:** The absence of systematic verification in theoretical physics means errors likely exist, but the field lacks cultural infrastructure for handling them constructively. We could help build that infrastructure, but only if we're extremely careful about framing and process.

**Our unique contribution:** Showing how formal methods + dependency graphs can clarify foundations of a field. The errors we find are evidence this approach works, not the primary output.

---

## References

### Formal Verification Success Cases
- [seL4 verified microkernel](https://sel4.systems/About/seL4-whitepaper.pdf)
- [CompCert verified compiler](https://cacm.acm.org/research/formal-verification-of-a-realistic-compiler/)
- [CompCert bugs at verification edges](https://cantina.xyz/blog/how-we-found-three-bugs-in-a-compiler-proven-correct)
- [DO-178C formal methods in aviation](https://www.mdpi.com/2079-9292/9/2/327/htm)

### Error Detection in Published Work
- [Higgs doublet model error (2026)](https://arxiv.org/html/2603.08139v1)
- [New Scientist coverage](https://www.newscientist.com/article/2520546-computer-finds-flaw-in-major-physics-paper-for-first-time/)
- [Lean benchmark audit: 4,833 issues](https://arxiv.org/abs/2606.29493)
- [Symbolic proof audit](https://arxiv.org/html/2608.13067)
- [Some instructive mathematical errors](https://arxiv.org/html/2106.07269v3)
- [Six textbook mistakes in computational physics](https://arxiv.org/html/2006.08592v2)

### Liquid Tensor Experiment
- [Published paper in Experimental Mathematics](http://www.tandfonline.com/doi/full/10.1080/10586458.2021.1926016)
- [Xena project blog: LTE launch](https://xenaproject.wordpress.com/2020/12/05/liquid-tensor-experiment/)
- [LTE completion announcement](https://leanprover-community.github.io/blog/posts/lte-final/)

### Reproducibility Crisis
- [PNAS: Is science facing a reproducibility crisis?](https://www.pnas.org/doi/10.1073/pnas.1708272114)
- [Nature: 1,500 scientists on reproducibility](https://www.nature.com/articles/533452a)
- [Nature: Reproducibility - A tragedy of errors](https://www.nature.com/articles/doi:10.1038/530027a)
- [Theory crisis vs replication crisis (2025)](https://statmodeling.stat.columbia.edu/2025/01/13/the-theory-crisis-in-physics-compared-to-the-replication-crisis-in-social-science-two-different-opinion-field-inversions-that-differ-in-some-important-ways/)
- [Physics 5σ standard explanation](https://hdsr.mitpress.mit.edu/pub/32yz0u49)

### Career Risks and Norms
- [Error and negligence in science](https://www.ncbi.nlm.nih.gov/books/NBK232225/)
- [What to do when peers have crucial flaws](https://academia.stackexchange.com/questions/121709/what-is-the-proper-action-when-peers-in-your-field-have-are-publishing-papers-wi)
- [Fear of retaliation in peer review](http://blogs.plos.org/absolutely-maybe/2018/03/22/signing-critical-peer-reviews-the-fear-of-retaliation-what-should-we-do/)
- [Where review goes wrong](https://cacm.acm.org/opinion/where-review-goes-wrong/)
- [Career impact of retractions](https://www.nature.com/articles/s41562-025-02154-0)
- [Retraction impact on innocent co-authors](https://ftp.zew.de/pub/zew-docs/ioekeval2019/HussingerPellens.pdf)
- [Scientific accountability asymmetry](https://www.qeios.com/read/M4GGKZ/pdf)
- [Reliability in mathematics publishing](https://www.tandfonline.com/doi/full/10.1080/23311886.2023.2244259)

### Collaborative Mathematics
- [Polymath Project lessons](http://www.cs.cmu.edu/~jcransh/papers/cranshaw_kittur.pdf)
- [Polymath: successful online collaboration](https://www.researchgate.net/publication/221515395_The_polymath_project_Lessons_from_a_successful_online_collaboration_in_mathematics)

### Formalization Efforts
- [Formalizing indexed mathematics benchmark](https://arxiv.org/html/2606.03835v2)
- [Systematic errors in AI papers via LLM analysis](https://arxiv.org/html/2512.05925)
- [Zero-assumption protocol for reference verification](https://arxiv.org/abs/2511.04683)

### Our Project Context
- Project ROADMAP.md: 660 statements, 104 formalized, 116 rigorous, 371 physical-argument, 28 conjecture
- DGM finding: arXiv:0803.2692 eq(51)/eq(52) contradiction, witness I=2 charges (4,1,2)
- Status: awaiting captain confirmation before public disclosure
- Follow-up work: [arXiv:1111.1161](https://arxiv.org/abs/1111.1161v2), [arXiv:1404.0033](https://arxiv.org/abs/1404.0033v2), [arXiv:1012.0265](https://arxiv.org/abs/1012.0265v3)
