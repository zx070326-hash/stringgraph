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

We present `stringgraph`, a machine-readable directed acyclic graph that encodes results from
string theory as immutable statement nodes (definitions, propositions, axioms) connected by
sourced derivation edges. Each derivation carries an epistemic-status label on an ordered
scale — *formalized* > *rigorous* > *physical-argument* > *conjecture* > *speculation*, with
*refuted* and *open* as absorbing states — and a propagation algorithm computes each
statement's *effective status* as the minimum over its dependencies' effective status and the
maximum over its alternative derivations, so that a report can list, for any claim, the exact
set of conjectures and axioms it rests on. Statements are separated from derivations: revising
a statement's text creates a new node rather than mutating an existing one. Every dependency
edge must resolve to a literature location or be explicitly flagged `inferred`. Convention
choices (metric signature, α′ normalization, gauge-field normalization) are factored into
dedicated, non-degrading nodes. A small, fixed set of milestone statements forms the human
audit surface, gated by a back-translation check (an agent reads only the formal YAML/Lean and
translates it back to prose, which is then compared against the source). Selected islands with
existing rigorous mathematical foundations are additionally checked in Lean 4/Mathlib, bridged
to the graph via an axiom-checking pass. We report several findings the method surfaced that a
linear reading of the source texts would not — misprints, a mis-cited exercise, and precise
localization of where a critical dimension actually enters a proof — and compare the design
axis to `leanblueprint`, the FLT project, and Prove2Me.

## 2. Design principles

The seven principles below are given verbatim (in translation) in the project's root
`CLAUDE.md`, "不可违背的原则" (non-negotiable principles), lines 26–32.

1. **Statements and derivations are separated** (`CLAUDE.md:26`). A statement is an immutable
   card that can carry multiple independent derivations; changing its text means creating a new
   node and marking the old one `superseded_by`. *Prevents*: silently rewriting an established
   claim under an id that other edges already point to, which would invalidate reviews those
   edges received.
2. **Status must be told straight** (`CLAUDE.md:27`). `status` records the rigor of *that
   node's own argument*, not "how widely it is believed"; a physicist-style argument is labeled
   `physical-argument`, a duality is labeled `conjecture`, even when consensus is strong.
   *Prevents*: status inflation that would make the propagated report meaningless.
3. **The audit surface is fixed at milestones** (`CLAUDE.md:28`). Only nodes in
   `graph/milestones/` require a human (the "captain") to confirm them, via back-translation
   audit; every other node is added freely by agents and policed by the validator and by
   reviewer agents. *Prevents*: human review from becoming the bottleneck on a graph with
   hundreds of nodes.
4. **Search before adding** (`CLAUDE.md:29`). `uv run stringgraph search <keyword>` must be run
   before a new node is created; incompatible phrasings of the same lemma go through the
   milestone normalization process rather than becoming duplicate cards. *Prevents*: graph
   fragmentation. *Incident*: two curators independently built `branes.bps-bound-point-particle-d4`
   and `susy.bps-bound-point-particle-d4` for the same proposition in parallel; the `susy.*`
   card was kept and the `branes.*` one superseded. The lesson is recorded verbatim in
   `docs/ROADMAP.md:101`: "同一命题不得同时派给两个 curator" (the same proposition must not be
   assigned to two curators at once) — this motivated a single-assignment discipline for task
   dispatch.
5. **Every edge needs a source** (`CLAUDE.md:30`). Each `depends_on` entry must be locatable in
   the literature location given in `sources`; if it cannot be, it must be marked
   `inferred: true` with an explanatory note. *Prevents*: fabricated dependency claims.
6. **Conventions are made explicit** (`CLAUDE.md:31`). Metric signature, α′ normalization,
   gauge-field normalization, etc. are centralized in `graph/conventions/`, and any statement
   that depends on a formula declares which convention it uses. *Prevents*: formulas from
   different sign conventions being silently compared as if equal.
7. **`validate` must pass before commit** (`CLAUDE.md:32`). A pre-commit hook enforces this;
   validation failures may not be committed around. *Prevents*: a broken graph state (unresolved
   ids, cycles, unsourced edges) entering the shared branch.
   *Incident*: on 2026-09-11 a `git mv` of one derivation for `ch10-residuals` left an upstream
   (superseded) statement with no surviving derivation while it was still `depends_on`-ed by
   live edges; because the effective-status algorithm treats a derivation-less proposition as
   `open`, this silently dropped roughly 40 downstream nodes to `open`. The rule added in
   response — "if a superseded statement is still `depends_on`-ed by any live derivation, it
   must retain at least one derivation" — is now a validator **error**, not a warning
   (`docs/STATUS_LEVELS.md:67`).

**Two further tool-rule incidents** (not one of the seven principles, but load-bearing for the
data model):

- *Formalization-frontier false wiring → `formalization-ruled-out` tag.* The `report` command's
  "formalization frontier" section lists statements all of whose dependencies are `formalized`
  but which are not `formalized` themselves — intended only as a *candidate list*, not a to-do
  queue. Two agents had, independently, treated frontier membership as an instruction and wired
  work against it incorrectly. A `formalization-ruled-out` tag was introduced so the lead can
  mark a card as deliberately excluded (e.g. because it asserts strictly more than any planned
  Lean statement) and have `report` hide it (`graph/CLAUDE.md:80`).
- *API outage → incremental-commit rule.* Two TLS-certificate failures on 2026-09-10 and
  2026-09-11 each killed 6–10 active sub-agents mid-task. Because uncommitted worktrees are
  garbage-collected, any agent that had been batching changes toward one large commit lost that
  work outright. The fix, recorded in the root `CLAUDE.md:61` under "API 故障韧性" (API-outage
  resilience), requires every sub-agent to run `validate` and commit after each single
  card/statement rather than accumulating changes.

## 3. Data model

Field names below are taken from `graph/schema/{statement,derivation,milestone,convention}.schema.json`.

- **Statement** (`kind: definition | proposition | axiom`): `id` (pattern `area.slug`), `title`,
  `statement` (the natural-language text), optional `formal_statement`; `status` is present
  **only** for `definition`/`axiom` nodes (forbidden on `proposition`, whose status is
  computed); `uses` (definitional dependencies, `definition`/`axiom` only); `uses_conventions`;
  `sources` (list of `{ref, loc}`); `tags`; `notes`; `superseded_by`; an optional `formal`
  object bridging to a Lean declaration.
- **Derivation**: `id` (pattern `<statement-id>--via-<method>`), `target`, `kind`
  (`proof | physical-argument | conjecture-support | refutation`), `status` (the node's own
  rigor, on the same ordered scale as statements plus `speculation`/`refuted`), `depends_on`
  (list of `{id, inferred, note, convention_map}`), `sources` (`{ref, loc, note}`), `summary`,
  optional `gaps`, `notes`, `author`.
- **Milestone**: `id` (`ms.*`), `statement_id`, `canonical_text` (the captain-confirmed
  authoritative prose), `canonical_source` (`{ref, loc}`), `audit` object with `status`
  (`draft | back-translated | approved | rejected`), `captain`, `approved_on`, and a nested
  `back_translation` (`by`, `text`, `verdict: faithful | drift | wrong`, `diff_notes`).
- **Convention**: `id` (`conv.*`), `family` (conventions in the same family are mutually
  exclusive; exactly one per family is `canonical: true`), `title`, `definition`, `sources`,
  `notes`.

**Effective-status algorithm** (`tools/stringgraph/propagate.py` docstring;
`docs/STATUS_LEVELS.md`):

For a `proposition`, `effective(n) = max` over its derivations `d` of
`min(d.status, min over dep in d.depends_on of effective(dep))`, where `convention` nodes are
excluded from the inner minimum. A proposition with no derivations is `open`. A `refutation`
derivation whose own effective rigor is at least `physical-argument` forces the target to
`refuted`. For `definition`/`axiom` nodes, `effective(n) = min(own status, min over uses of
effective(dep))` — deliberately: a `rigorous`-but-not-`formalized` definition card caps every
`formalized` proposition that uses it, because a Lean proof over an object that does not
literally match the card's stated definition (e.g. missing a mass-shell condition) should not
display as `formalized`; the intended fix in that situation is to split the definition card so
the Lean-matching half becomes its own `formalized` card. Alongside the level, the algorithm
also tracks (i) an `assumes` set — the axiom ids the best derivation chain rests on — and (ii) a
`conjectures` set — statement ids on that chain whose own effective status is
conjecture/speculation/open. A multiply-derived statement takes the *strongest* derivation, so
an old physical-argument derivation and a newer rigorous one for the same statement coexist and
the tool automatically reports the higher.

`stringgraph why <id>` walks the same recursive structure but reports, at each level, *which*
dependency chain actually realized the minimum — i.e. which physical-argument or conjecture
link is the true bottleneck, as distinct from internally-rigorous nodes that happen to sit
upstream. Example (`docs/ROADMAP.md`, "瓶颈分析"): for the light-cone route to
`critical-dimension-bosonic`, `why` isolates four physical-argument steps (ζ-regularization,
infinite oscillator-commutator reordering, light-cone-gauge reachability, Polyakov–Nambu-Goto
classical equivalence) as the bottleneck, while for the Weyl-anomaly route it isolates exactly
two roots (a Laplacian log-contact-term lemma lacking a math source, and unproven OPE
convergence) even though every intermediate node on that route is individually `rigorous`.

## 4. Findings a textbook reader would not get

Each item names the graph node id carrying the finding and the extraction-record section it
traces to.

1. **Polchinski v2 eq. (13.3.12) is a misprint (three-evidence ruling).** `branes.rr-charge-quantization-v2`
   does not cite (13.3.12); the ruling is recorded in
   `literature/extractions/polchinski-1998-v2-ch13.md` §6 ("E19 复核"), on three independent
   grounds: dimensional analysis, self-inconsistency with the same page's (13.3.11)+(13.3.13),
   and independent confirmation from Polchinski's own hep-th/9510017 eqs. (12)–(15). The 2005
   "with corrections" printing still carries the misprint.
2. **Exercise 3.6 of Polchinski v1 contains no digit "3."** `worldsheet.ghost-number-current-weyl-anomaly`
   outsources its anomaly-coefficient derivation to "exercise 3.6." Reading the exercise's
   actual printed text (`literature/extractions/polchinski-1998-v1.md` §18, notably the lines
   recording the phrase "这道题的题面里没有数字 3") shows it supplies only the abstract
   conversion rule ∇ₐjᵃ = aR ↔ 4a from a z⁻³ OPE coefficient — the digit 3 that ends up in
   "3χ/2" appears three steps later, after substituting λ = 2 into machinery the exercise never
   states. This narrowed the derivation's `physical-argument` gap list from one vague outsourcing
   claim to three precise, independently checkable gaps.
3. **The DDF contour-integral-vs-mode-sum provenance card.** `worldsheet.ddf-contour-equals-mode-sum`
   (derivation `--via-laurent-coefficient-extraction`) is the single node carrying the
   equivalence between the literature's contour-integral definition of DDF operators and the
   mode-sum object Lean actually formalizes. Its own `sources` note that Goddard (2008) §5 gives
   only the contour side and never discusses the equivalence; extraction
   `literature/extractions/gsw-1987-v1.md` §2 E1 confirms the textbook side is equally silent.
   The card's `gaps` explicitly block it from being counted toward the formalized side of the
   graph.
4. **The FOK-vs-LZ Verma-decomposition dispute, now with two independent references against
   FOK.** `worldsheet.nsr-fock-space-verma-decomposition` records FOK's 1989 claim (via
   Brower–Friedman) that the relevant Fock module is a direct sum of Verma modules; against it
   stand two independently sourced remarks stating the opposite verbatim, with an explicit
   counterexample condition: LZ 1989 p.320 (`literature/extractions/lian-zuckerman-1989.md`
   §9.6/§9.9.5) and the FGZ 1986 Prop. 2.6 Remark
   (`literature/extractions/brst-cohomology-sources.md`). The card is kept `conjecture` rather
   than downgraded to `refuted`, since neither source gives an explicit level matching FOK's
   stated regime.
5. **Sen's Gibbons–Hull citation has a page misprint.** `swampland.heterotic-t6-bps-bound`
   outsources its Bogomol'nyi bound to Sen's references [24][25].
   `literature/extractions/sen-1995-bh-torus.md` (transcribed reference list) and the
   cross-check in `literature/extractions/math-sources.md` show Sen's paper prints "Gibbons and
   Hull, Phys. Lett. B109 (1982) 109," but INSPIRE has no such page; the correct page range is
   190–194. Graph notes now record both the printed and the corrected citation.
6. **LZ 1989's reference table has independent page-number misprints.** Tracing the original
   attribution behind `worldsheet.superstring-relative-complex-character-signature` and related
   LZ-sourced cards required reading Lian–Zuckerman's printed bibliography as a page image;
   `literature/extractions/lian-zuckerman-1989.md` §8 records at least two independent
   page-number misprints in the same reference table (entries [5] and [13]) and pins reference
   [8] to Gliozzi–Scherk–Olive, Nucl. Phys. B122 (1977) 253–290, rather than the Phys. Lett.
   citation an initial guess had assumed.
7. **Precise localization of where D = 26 enters the Goddard–Thorn argument.** The Lean
   formalization blueprint `formal/BLUEPRINT-noghost.md:431` isolates step "(B-26)" — "the
   `p_{D-1}(N) - p_{D-2}(N)` directions outside `H^⊥` in `H_phys` are exactly null states at
   `D = 26`" — as the *only* step in the entire argument feeding
   `worldsheet.no-ghost-theorem-v4` that actually uses the critical dimension. Every other
   component (DDF algebra, adjoints, the transverse Gram matrix) is dimension-independent, and
   the sole literature support located for (B-26) itself is one secondhand sentence in Goddard
   (2008) eq. (6.4), since the primary Goddard–Thorn 1972 text remains unobtained
   (`formal/BLUEPRINT-noghost.md`).

## 5. Comparison to leanblueprint / FLT / Prove2Me

**leanblueprint** (P. Massot) is *already* a status-bearing dependency DAG: nodes are LaTeX
environments, edges are the `\uses` macro, and node color tracks formalization-pipeline
progress (`stated`, `can_state`, `not_ready`, `proved`, `can_prove`, `defined`, `fully_proved`,
`mathlib`, via `\leanok`/`\notready`/`\mathlibok`). The difference from `stringgraph` is not
"having a graph" but the *semantics of the status axis*: leanblueprint's premise is that the
underlying mathematics is already rigorously proved by humans, and the only open question is
distance to a Lean proof. `stringgraph` replaces that axis with epistemic strength of the
argument itself — `formalized` > `rigorous` > `physical-argument` > `conjecture` > `refuted` —
propagated by minimum-over-dependencies/maximum-over-derivations, which is the axis that
matters precisely because most string-theory derivations are *not* rigorously proved by any
accepted standard yet. It would be inaccurate to describe prior work as "only static
documentation."

**Prove2Me** (Chen, Marwaha, Lu, Yuen, Peng, arXiv:2608.28433) is the direct source of the
mechanisms reused most: statement/proof separation, a fixed human-audited core, proof sketches
that may depend on unproved statements (yielding conditional results), back-translation audits,
milestone normalization for incompatible phrasings, and search-before-submit with attribution
credited via `author`. The one change made from Prove2Me, recorded in
`docs/METHODOLOGY.md`, is structural: Prove2Me's compositional guarantee rests on every edge
being kernel-checked by Lean; most string-theory edges cannot be, so node status became an
ordered scale rather than a binary "proved in Lean or not."

**FLT** (Imperial College London, Buzzard et al.) targets a single theorem already proved by
humans and pushes it into Lean end to end. `stringgraph` instead has to represent a domain
where most derivations have no accepted rigorous proof at all, so the "graph-as-external-memory
for agents" lesson from Anthropic's FLT report is adopted (agents read state from the graph
rather than carrying it in context), but the object being tracked is different in kind, not
just in size.

## 6. Limitations

- **AI-agent-only review.** Every node except the three current milestones
  (`ms.critical-dimension-bosonic`, `ms.ddf-commute-with-virasoro`, `ms.no-ghost-theorem`) has
  been reviewed only by agents (`curator`/`reviewer`/`auditor` roles), not by a human physicist.
  Even the three milestones are currently only at `audit.status: back-translated`, awaiting
  captain approval (`docs/ROADMAP.md`, "待船长裁决"). (as of 2026-09-12 all three milestones are `back-translated`, none `approved`; approval is a captain-only action)
- **Chinese-language records.** Nearly all files under `literature/extractions/` and most
  node-level `notes` are written in Chinese by the working agents, even though statement titles
  and text are English. A reader auditing sourcing crosses a language boundary at the
  extraction-record layer. `[verify: whether extraction records will be translated before any
  public release]`
- **Coverage is one area deep, the rest shallow.** By area (`uv run stringgraph report`,
  current run): `worldsheet`=339 of 596 statements (57%), `math`=76, `spectrum`=43,
  `consistency`=29, `swampland`=31, `branes`=24, `compact`=25, `holography`=12, `duality`=10,
  `susy`=4, `cft`=3. Phase 1 (`worldsheet`) is the only area near its target size; the Phase
  2–4 areas (consistency/duality, holography, swampland) are seeded (a few dozen nodes each)
  but not systematically covered.
- **Effective-status counts.** Of 596 statements (112 definitions, 484 propositions), effective
  status is `formalized`=73, `rigorous`=107, `physical-argument`=350, `conjecture`=29,
  `refuted`=1, `open`=36 (`uv run stringgraph report`, current run). The majority of the
  graph — 350/596 (≈59%) — sits at `physical-argument`: internally coherent but not rigorously
  proved by any accepted mathematical standard. Only 73 nodes (≈12%) are machine-checked.

## 7. Artifact

**Repo layout**

- `graph/{statements,derivations,milestones,conventions}/<area>/<slug>.yaml` — one file per
  node (data only, no code).
- `tools/stringgraph/` — pure Python 3.11+, dependencies limited to `pyyaml` and `jsonschema`;
  `cli.py` exposes `validate | status | why | report | search | dot`.
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

**Counts** (current snapshot, `uv run stringgraph report`): 596 statements, 492 derivations, 3
milestones, 21 conventions. Lean side: 77 declarations checked, 77 ok (`uv run stringgraph check-axioms`, 2026-09-12, main 3508 Lake jobs) — the
project log records roughly 77 axiom-clean declarations as of the last recorded check
(`docs/ROADMAP.md`, Phase 1 progress notes); `check-axioms` must be re-run against the current
`formal/` tree before this number is quoted in the paper.

**Licensing question for verbatim quotes** `[decide]`: extraction records and some
`sources[].note` fields carry short verbatim quotations from copyrighted textbooks (Polchinski,
Green–Schwarz–Witten) and journal articles (Lian–Zuckerman 1989, Friedan–Martinec–Shenker/FGZ
1986) for sourcing and audit purposes. Before any public release of `literature/extractions/`
or the graph's `sources[].note` fields, `[decide: whether the length and purpose of these
quotations qualifies as fair use/fair dealing for the intended venue, or whether extraction
records must be paraphrased/redacted or excluded from the public artifact]`.
