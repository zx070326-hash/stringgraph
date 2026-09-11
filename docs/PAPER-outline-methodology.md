# Paper outline: methodology (draft skeleton)

Target venue class: SciPost Physics Codebases / JOSS / CICM. This is a skeleton for the
methodology paper about the `stringgraph` tool and dataset, not the physics results
themselves. Uncertain items are marked `[verify: ...]`; nothing here is asserted beyond what
the cited files state.

## 1. Title candidates and abstract

**Title candidates**

1. *stringgraph: A Machine-Readable Dependency Graph for String Theory with Propagated
   Epistemic Status*
2. *From Physical Argument to Lean-Checked Theorem: A Status-Propagating Knowledge Graph for
   String Theory*
3. *Auditing Fifty Years of String Theory: An Epistemic-Status DAG with a Formal-Verification
   Bridge*

**Abstract (draft)**

We present `stringgraph`, a machine-readable directed acyclic graph encoding string-theory
results as immutable statement nodes (definitions, propositions, axioms) connected by sourced
derivation edges. Each derivation carries an epistemic-status label on an ordered scale —
*formalized* > *rigorous* > *physical-argument* > *conjecture* > *speculation*, with *refuted*
and *open* as absorbing states — and a propagation algorithm computes each statement's
*effective status* as the minimum over its dependencies' effective status and the maximum over
its alternative derivations, so a report can list, for any claim, the exact set of conjectures
and axioms it rests on. Statements are separated from derivations: revising a statement's text
creates a new node rather than mutating an existing one. Every dependency edge must resolve to
a literature location or be flagged `inferred`. Convention choices (metric signature, α′
normalization, gauge-field normalization) are factored into dedicated, non-degrading nodes. A
small, fixed set of milestone statements forms the human audit surface, gated by a
back-translation check (an agent reads only the formal YAML/Lean and translates it back to
prose for comparison against the source). Selected islands with existing rigorous mathematical
foundations are additionally checked in Lean 4/Mathlib, bridged via an axiom-checking pass. We
report findings the method surfaced that a linear reading would not — misprints, a mis-cited
exercise, and precise localization of where a critical dimension actually enters the argument —
and compare the design to `leanblueprint`, the FLT project, and Prove2Me.

## 2. Design principles

The seven principles below are given verbatim (in translation) in the project's root
`CLAUDE.md`, "不可违背的原则" (non-negotiable principles), lines 26–32.

1. **Statements/derivations separated** (`CLAUDE.md:26`): a statement is an immutable card
   with multiple independent derivations; text changes create a new node, marking the old one
   `superseded_by` — prevents silently rewriting a claim under an id other edges already trust.
2. **Status told straight** (`CLAUDE.md:27`): `status` records the rigor of *that node's own
   argument*, not consensus; physicist-style arguments get `physical-argument`, dualities get
   `conjecture` — prevents status inflation.
3. **Audit surface fixed at milestones** (`CLAUDE.md:28`): only `graph/milestones/` nodes need
   human (captain) back-translation confirmation; everything else is agent-added, validator- and
   reviewer-policed — keeps human review off the critical path on a graph of hundreds of nodes.
4. **Search before adding** (`CLAUDE.md:29`): `uv run stringgraph search <keyword>` before any
   new node; incompatible phrasings go through milestone normalization, not duplicate cards.
   *Incident*: two curators independently built duplicate cards
   (`branes.bps-bound-point-particle-d4` / `susy.bps-bound-point-particle-d4`); `susy.*` was
   kept, `branes.*` superseded (`docs/ROADMAP.md:101`: "同一命题不得同时派给两个 curator"),
   motivating single-assignment task dispatch.
5. **Every edge needs a source** (`CLAUDE.md:30`): each `depends_on` must be locatable in
   `sources`, else flagged `inferred: true` with a note — prevents fabricated dependencies.
6. **Conventions explicit** (`CLAUDE.md:31`): metric signature, α′ normalization, gauge-field
   normalization etc. live in `graph/conventions/`; formula-bearing statements declare which
   convention they use — prevents comparing incompatible sign conventions as if equal.
7. **`validate` must pass before commit** (`CLAUDE.md:32`), enforced by a pre-commit hook.
   *Incident*: on 2026-09-11 a `git mv` left a superseded `ch10-residuals` statement with no
   surviving derivation while still `depends_on`-ed by live edges; since a derivation-less
   proposition is `open`, this silently dropped ~40 downstream nodes to `open`. The added rule
   — a superseded statement still depended on must retain at least one derivation — is now a
   validator **error** (`docs/STATUS_LEVELS.md:67`).

**Two further tool-rule incidents** (load-bearing for the data model, not among the seven):

- *Formalization-frontier false wiring.* `report`'s "formalization frontier" lists statements
  whose dependencies are all `formalized` but which aren't themselves — a candidate list, not a
  to-do queue. This has happened twice: an agent wired work against it as an instruction anyway.
  A `formalization-ruled-out` tag now lets the lead exclude a card deliberately (e.g. it asserts
  more than any planned Lean statement) and have `report` hide it (`graph/CLAUDE.md:80`).
- *API outage → incremental commit.* Two TLS-certificate failures (2026-09-10/11) each killed
  6–10 sub-agents mid-task. A worktree with zero commits is garbage-collected outright, so an
  agent batching toward one large commit could lose everything. The fix (`CLAUDE.md:61`, "API
  故障韧性"): every sub-agent validates and commits after each single card/statement.

## 3. Data model

Field names below are taken from `graph/schema/{statement,derivation,milestone,convention}.schema.json`.

- **Statement** (`kind: definition | proposition | axiom`): `id` (`area.slug`), `title`,
  `statement` (prose), optional `formal_statement`; `status` only for `definition`/`axiom`
  (forbidden on `proposition`, computed instead); `uses` (definitional deps — documented
  `definition`/`axiom`-only, not schema-enforced; a few propositions carry it and the
  propagator ignores it there); `uses_conventions`; `sources` (`{ref, loc}`); `tags`; `notes`;
  `superseded_by`; optional `formal` object bridging to a Lean declaration.
- **Derivation**: `id` (`<statement-id>--via-<method>`), `target`, `kind` (`proof |
  physical-argument | conjecture-support | refutation`), `status` (own rigor, the statement
  scale plus `conjecture`/`speculation`/`refuted`), `depends_on` (`{id, inferred, note,
  convention_map}`), `sources` (`{ref, loc, note}`), `summary`, optional `gaps`, `notes`,
  `author`.
- **Milestone**: `id` (`ms.*`), `statement_id`, `canonical_text`, `canonical_source` (`{ref,
  loc}`), `audit` object with `status` (`draft | back-translated | approved | rejected`),
  `captain`, `approved_on`, nested `back_translation` (`by`, `text`, `verdict: faithful | drift
  | wrong`, `diff_notes`).
- **Convention**: `id` (`conv.*`), `family` (mutually exclusive within family; at most one
  `canonical: true` per family — the validator only errors on more than one; every family
  currently has exactly one), `title`, `definition`, `sources`, `notes`.

**Effective-status algorithm** (`tools/stringgraph/propagate.py` docstring;
`docs/STATUS_LEVELS.md`):

For a `proposition`, `effective(n) = max` over derivations `d` of `min(d.status, min over dep
in d.depends_on of effective(dep))` (convention nodes excluded); no derivations means `open`. A
`refutation` derivation with effective rigor ≥ `physical-argument` forces `refuted`. For
`definition`/`axiom`, `effective(n) = min(own status, min over uses of effective(dep))` —
deliberately, so a `rigorous`-but-not-`formalized` definition caps every `formalized`
proposition using it (splitting the card is the fix when a Lean proof only matches part of it).
The algorithm also tracks an `assumes` set (axiom ids the best chain rests on) and a
`conjectures` set (statement ids on that chain at conjecture, speculation, refuted, or open —
the code's `level <= conjecture` test also catches `refuted`, which the docstring omits). A
multiply-derived statement takes its strongest derivation, so an old physical-argument
derivation and a newer rigorous one coexist and the tool reports the higher.

`stringgraph why <id>` reports, at each level, which dependency chain realized the minimum —
the true bottleneck, as distinct from internally-rigorous nodes sitting upstream. Example
(`docs/ROADMAP.md`, "瓶颈分析"): for `critical-dimension-light-cone`, `why` isolates four
physical-argument steps (ζ-regularization, infinite oscillator-commutator reordering,
light-cone-gauge reachability, Polyakov–Nambu-Goto classical equivalence) as the bottleneck;
for `critical-dimension-weyl-anomaly` it isolates exactly two roots (a Laplacian
log-contact-term lemma lacking a math source, and unproven OPE convergence) even though every
intermediate node on that route is individually `rigorous`.

## 4. Findings a textbook reader would not get

Each item names the graph node id carrying the finding and the extraction-record section it
traces to.

1. **Polchinski v2 eq. (13.3.12) is a misprint, confirmed by two independent lines of
   evidence.** `branes.rr-charge-quantization-v2` does not cite (13.3.12); the ruling is
   recorded in `literature/extractions/polchinski-1998-v2-ch13.md` §6 ("E19 复核"), triggered
   by a dimensional-analysis flag and confirmed by (i) self-inconsistency with (13.3.11) on the
   same page (p.148) and (13.3.13) on the next page (p.149), and (ii) independent confirmation
   from Polchinski's own hep-th/9510017 eqs. (12)–(15). The 2005 "with corrections" printing
   still carries the misprint.
2. **Exercise 3.6 of Polchinski v1 contains no digit "3."** `worldsheet.ghost-number-current-weyl-anomaly`
   outsources its anomaly-coefficient derivation to "exercise 3.6." Reading the exercise's
   actual printed text (`literature/extractions/polchinski-1998-v1.md` §18, notably the lines
   recording the phrase "这道题的题面里没有数字 3") shows it supplies only the abstract
   conversion rule ∇ₐjᵃ = aR ↔ 4a from a z⁻³ OPE coefficient; the digit 3 that ends up in
   "3χ/2" is reconstructed only after substituting λ = 2 into machinery the exercise never
   states. This narrowed the derivation's `physical-argument` gap list from one vague outsourcing
   claim to three independently checkable gaps: the dimensional-grounds origin of the anomaly
   form, the unproved z⁻³-coefficient identity, and the missing bc-system OPE computation.
3. **The DDF contour-integral-vs-mode-sum provenance card.** `worldsheet.ddf-contour-equals-mode-sum`
   (derivation `--via-laurent-coefficient-extraction`) is the single node carrying the
   equivalence between the literature's contour-integral DDF definition and the mode-sum object
   Lean actually formalizes. Its `sources` note that Goddard (2008) §5 gives only the contour
   side and never discusses the equivalence; extraction `literature/extractions/gsw-1987-v1.md`
   §2 E1 records Goddard's (2008) contour definition verbatim (eq. 5.1–5.3), while GSW §2.3.3
   itself was never obtained (§1, L0). The card's `gaps` block it from counting toward the
   formalized side of the graph.
4. **The FOK-vs-LZ Verma-decomposition dispute, now with a second independent remark.**
   `worldsheet.nsr-fock-space-verma-decomposition` records FOK's 1989 claim (via
   Brower–Friedman) that the relevant super-Virasoro Fock module is a direct sum of Verma
   modules; against it stand two independently sourced remarks pointing the same direction,
   though neither is an accepted counterexample to the NSR claim: the LZ 1989 p.320 Remark
   (`literature/extractions/lian-zuckerman-1989.md` §2, §4 Q1, §9.6; NS sector, condition
   p·p < 0, no explicit level or vector given) and, for the bosonic analogue, the FGZ 1986
   Prop. 2.6 Remark (`literature/extractions/brst-cohomology-sources.md` §9; p·p a nonpositive
   even integer, also no explicit vector). The card is kept `conjecture` rather than downgraded
   to `refuted` because LZ gives no explicit level or vector and FGZ concerns the bosonic case,
   not the super-Virasoro/NSR case the card asserts.
5. **Sen's Gibbons–Hull citation has a page misprint.** `swampland.heterotic-t6-bps-bound`
   outsources its Bogomol'nyi bound to Sen's references [24][25].
   `literature/extractions/sen-1995-bh-torus.md` (transcribed reference list) and the
   cross-check in `literature/extractions/math-sources.md` show Sen's paper prints "Gibbons and
   Hull, Phys. Lett. B109 (1982) 109," but INSPIRE has no such page; the correct page range is
   190–194. Graph notes now record both the printed and the corrected citation.
6. **LZ 1989's reference table has independent page-number misprints.** Tracing the
   attribution behind `worldsheet.superstring-relative-complex-character-signature`
   (whose D=10 global assumption depends on entry [13], Ohta, via Prop. 1.7(ii)) required
   reading Lian–Zuckerman's printed bibliography as a page image, triggered by a question over
   the correct target of reference [8]; `literature/extractions/lian-zuckerman-1989.md` §8
   records a confirmed page-number misprint in entry [13] (Ohta, Phys. Rev. D33, printed as
   681–691, corrected to 1681–1691 via a double OSTI source) and pins reference [8] to
   Gliozzi–Scherk–Olive, Nucl. Phys. B122 (1977) 253–290, resolving a prior ambiguity with the
   similarly-numbered Phys. Lett. B65 (1976) 282 that the extraction records as previously
   undecided, not as a wrong initial guess.
7. **Precise localization of where D = 26 enters the Goddard–Thorn argument.** The Lean
   formalization blueprint `formal/BLUEPRINT-noghost.md:431` isolates step "(B-26)" — "the
   `p_{D-1}(N) - p_{D-2}(N)` directions outside `H^⊥` in `H_phys` are exactly null states at
   `D = 26`" — as the only step feeding the D=26 isometry half of
   `worldsheet.no-ghost-theorem-v4` that uses the critical dimension (the argument's other
   half, the D>26 negative-norm claim, uses D independently via an explicit Lean witness,
   `Fock.pairing_levelTwoScalar_intercept_one`: ⟨ψ₂,ψ₂⟩ = −2(D−26)(D−1)/25). Every other
   component of the D=26 half (DDF algebra, adjoints, the transverse Gram matrix) is
   dimension-independent, and the sole literature support located for (B-26) itself is one
   secondhand sentence in Goddard (2008) eq. (6.4), since the primary Goddard–Thorn 1972 text
   remains unobtained (`formal/BLUEPRINT-noghost.md`).

## 5. Comparison to leanblueprint / FLT / Prove2Me

**leanblueprint** (P. Massot) is *already* a status-bearing dependency DAG: nodes are LaTeX
environments, edges are the `\uses` macro, and node color tracks formalization-pipeline
progress (`stated`, `can_state`, `not_ready`, `proved`, `can_prove`, `defined`, `fully_proved`,
`mathlib`, via `\leanok`/`\notready`/`\mathlibok`). A domain-specific instance of the same
pattern already exists for our own target theorem — Kytölä's VirasoroProject blueprint
(`literature/extractions/prior-formalizations.md`; https://kkytola.github.io/VirasoroProject/),
a leanblueprint-style pipeline-progress graph for Virasoro representation theory, not an
epistemic-strength graph. The difference from `stringgraph` is not "having a graph" but the
*semantics of the status axis*: both blueprints assume the underlying mathematics is already
rigorously proved by humans, leaving only distance to a Lean proof as the open question.
`stringgraph` replaces that axis with epistemic strength of the argument itself —
`formalized` > `rigorous` > `physical-argument` > `conjecture` > `speculation` > `refuted` —
propagated by minimum-over-dependencies/maximum-over-derivations, the axis that matters
precisely because most string-theory derivations are *not* rigorously proved by any accepted
standard yet. It would be inaccurate to describe prior work as "only static documentation."

**Prove2Me** (Chen, Marwaha, Lu, Yuen, Peng, arXiv:2608.28433) is the direct source of the
mechanisms reused most: statement/proof separation, a fixed human-audited core, proof sketches
depending on unproved statements (conditional results), back-translation audits, milestone
normalization for incompatible phrasings, and search-before-submit with `author` attribution.
The one change, recorded in `docs/METHODOLOGY.md`: Prove2Me's compositional guarantee rests on
every edge being kernel-checked by Lean; most string-theory edges cannot be, so node status
became an ordered scale rather than a binary "proved in Lean or not."

**FLT** (Imperial College London, Buzzard et al.) targets a single theorem already proved by
humans and pushes it into Lean end to end. `stringgraph` instead represents a domain where most
derivations have no accepted rigorous proof at all; it adopts the "graph-as-external-memory for
agents" lesson from Anthropic's FLT report (agents read state from the graph rather than
carrying it in context), but the tracked object differs in kind, not just size.

## 6. Limitations

- **AI-agent-only review.** Every node except the three current milestones
  (`ms.critical-dimension-bosonic`, `ms.ddf-commute-with-virasoro`, `ms.no-ghost-theorem`) has
  been reviewed only by agents (`curator`/`reviewer`/`auditor` roles), not a human physicist.
  All three milestones are currently `audit.status: back-translated`, awaiting captain approval
  (`docs/ROADMAP.md`, "待船长裁决") — a captain-only action, none yet `approved`.
- **Chinese-language records.** Nearly all files under `literature/extractions/` and most
  node-level `notes` are written in Chinese by the working agents, even though statement titles
  and text are English. A reader auditing sourcing crosses a language boundary at the
  extraction-record layer. `[verify: whether extraction records will be translated before any
  public release]`
- **Coverage is one area deep, the rest shallow.** By area (`uv run stringgraph report`,
  current run): `worldsheet`=343 of 602 statements (57%), `math`=77, `spectrum`=44,
  `consistency`=29, `swampland`=31, `branes`=24, `compact`=25, `holography`=12, `duality`=10,
  `susy`=4, `cft`=3. Phase 1 (`worldsheet`) has already run well past its ~150-node planned
  size (`docs/ROADMAP.md:12`; now more than 2× target); the Phase 2–4 areas
  (consistency/duality, holography, swampland) are seeded (a few dozen nodes each) but not
  systematically covered.
- **Effective-status counts.** Of 602 statements (114 definitions, 488 propositions), effective
  status is `formalized`=75, `rigorous`=107, `physical-argument`=354, `conjecture`=29,
  `refuted`=1, `open`=36 (`uv run stringgraph report`, current run; this is a moving target,
  edited concurrently by many other agents). The majority of the graph — 354/602 (≈59%) — sits
  at `physical-argument`: internally coherent but not rigorously proved by any accepted
  mathematical standard. Only 75 nodes (≈12%) are machine-checked.

## 7. Artifact

**Repo layout**

- `graph/{statements,derivations}/<area>/<slug>.yaml` and `graph/{milestones,conventions}/<slug>.yaml`
  (the latter two are flat, not split by area) — one file per node (data only, no code).
- `tools/stringgraph/` — pure Python 3.11+, dependencies limited to `pyyaml` and `jsonschema`;
  `cli.py` exposes `validate | status | why | report | search | dot | check-axioms`.
- `formal/` — the Lean 4 + Mathlib formalization island (`StringFormal` namespace).
- `literature/` — `sources.bib` (single bibliography), `extractions/<ref>.md` (statement-level
  extraction records, an intermediate product), `reading-list.md`.

**Commands**

```bash
uv sync
uv run stringgraph validate
uv run stringgraph report
uv run stringgraph status <node-id>
uv run stringgraph why <node-id>
uv run stringgraph search <keyword>
uv run stringgraph dot > graph/build/graph.dot
uv run pytest
cd formal && lake build
uv run stringgraph check-axioms
```

**Counts** (current snapshot, `uv run stringgraph report`): 602 statements, 496 derivations, 3
milestones, 21 conventions. Lean side: the project log records 79 axiom-clean declarations as
of the last recorded `check-axioms` run (`docs/ROADMAP.md`, Phase 1 progress notes, 3511 Lake
jobs); `check-axioms` must be re-run against the current `formal/` tree before this number is
quoted in the paper, since the graph and `formal/` are both edited concurrently by other
agents.

**Licensing question for verbatim quotes** `[decide]`: extraction records and some
`sources[].note` fields carry short verbatim quotations from copyrighted textbooks (Polchinski,
Green–Schwarz–Witten) and journal articles (Lian–Zuckerman 1989, FGZ 1986) for sourcing and
audit. Before any public release, `[decide: whether the length and purpose of these quotations
qualifies as fair use/fair dealing for the intended venue, or whether extraction records must
be paraphrased/redacted or excluded from the public artifact]`.
