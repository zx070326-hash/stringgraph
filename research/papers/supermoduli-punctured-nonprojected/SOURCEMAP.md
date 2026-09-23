# Source Map: Paper ↔ Proof Documents

This document maps every section of `paper.md` to line ranges in its source documents, so that a
reviewer can verify that no mathematical claim was introduced during synthesis, and can see at a
glance the handful of places where something *was* introduced.

Written 2026-09-23, against `paper.md` at 1339 lines. It is an internal verification aid and must
**not** be bundled with a submission. Its counterpart for the other draft is
`research/papers/torsion-dyon-shift-positivity/SOURCEMAP.md`.

## Legend

- **P**: `research/attempts/supermoduli-elliptic-tail-punctured/proof.md` (930 lines) — `state: verified`,
  two adversarial graph-reviewer rounds (2026-09-18 lead-dispatched, 2026-09-20 agent `smreview`),
  `captain_confirmed: false`
- **Cl**: `research/attempts/supermoduli-elliptic-tail-punctured/claim.md` (196 lines)
- **Pr**: `research/attempts/supermoduli-elliptic-tail-punctured/prior-art.md` (149 lines)
- **M**: `research/attempts/supermoduli-measure-consequence/` (`claim.md` + `argument.md`) —
  ⚠️ **`state: under-review`, no reviewer round has ever occurred**; see the warning under §9.5 below
- **I**: `ISSUES.md` in this directory

---

## Paper §1 (Introduction)

| Paper | Source |
|---|---|
| §1.1 Background (lines 65-91) | Exposition; the literature facts are Pr §1-§2, the obstruction-class setup is P §1.1 (lines 39-75) |
| §1.2 Main results — Theorem M (92-106) | P §4.6 (lines 681-710); statement also Cl §1 |
| §1.2 — Theorem B (113-115) | P §5.1 (lines 740-765); the structural-immunity argument for putting it first is P §6.4 (lines 821-853) |
| §1.2 — Corollary A (119-130) | P §4.7 (lines 711-737) + P §5.1 (740-765) |
| §1.2 — threshold corollary (135-136) | P §5.1 (740-765); arithmetic re-verified by `scripts/thresholds.py` |
| §1.2 — Proposition N (140-156) | P §3 (lines 336-414). The quantifier paragraph (151-156) is P §3's own correction of an earlier draft, transcribed |
| §1.3 One-line idea (158-188) | P §2.1 (265-280) for where the threshold comes from, P §2.2 (281-304) for the puncture-free audit, P §4.1 (466-504) for the construction |
| §1.4 Comparison table (191-201) | Pr §1-§2 (the row data), P §5.4 (778-790) for the seed-bound comparison |
| §1.4 caveat (i) (214-221) | P §6.3 (812-820) |
| §1.4 caveat (ii) (223-226) | Pr §3 item on [W]'s self-described "preliminary draft" status |
| §1.4 caveat (iii) (228-236) | Pr §3 item 7 + §4 risk table (the Noja/Corrêa/Donagi "In preparation" signal). **Written for the paper** in the 2026-09-23 relayout round; its purpose is to disclaim priority rather than assert it |
| §1.5 What is not claimed (240-257) | P §7 (854-918), the full `[GAP]` list |
| §1.6 Organisation (261-270) | Navigational, no source |

## Paper §2 (Notation and conventions)

| Paper | Source |
|---|---|
| §2.1 Superstacks and the obstruction class (276-299) | P §1.1 (39-75) |
| §2.2 Supermoduli notation (300-323) | P §0 (17-36) |
| §2.3 Three notational traps in [FKP] (324-345) | P §0 (17-36) + P §2.3 (305-335), verbatim-verified against [FKP] in the source round. One trap — [FKP]'s own unrelated "Theorem B" — was found during the 2026-09-23 relayout and is disambiguated parenthetically at both occurrences (§2.3 and §5 Remark 5.6) |
| §2.4 Parity (346-356) | P §4.7 (711-737) |

## Paper §3 (External inputs)

- Enumerated table I1-I9 with rigour status: P §1.1 (39-75) and P §2.3 (305-335); cross-checked against `literature/sources.bib` and the extraction records in the `lit-blockers` researcher round
- I5 (the separating NS gluing morphism **with arbitrary punctures**) and I6 (the normal-line formula) are the two inputs the whole construction turns on; I6 is the one carrying `[INF-NORMAL]`
- I8, the standing hypothesis "ineffective **even** theta characteristic" (Mumford; Cornalba, via [CN, §5]): P §1.2 (76-106). This is the hypothesis that makes **I**'s item I1 a non-issue — see §8 below
- I9 (vanishing of higher cohomology on an affine) is used **only** in §7, the negative result

## Paper §4 (Preliminaries)

| Paper | Source |
|---|---|
| The primary obstruction (392-401) | P §1.1 (39-75) |
| Functoriality: a cospan, not a map (402-424) | P §1.1 (39-75); the cospan framing is P's own, introduced to avoid the standard misreading of [CN, Lemma 2.6] |
| The Donagi-Witten one-point obstruction family (425-461) | P §1.2 (76-106) |

## Paper §5 (The construction)

| Paper | Source |
|---|---|
| Two preliminary lemmas (471-525) | P §4.0 (420-465) |
| Construction 5.3 (526-577) | P §4.1 (466-504), line-by-line against [CN §6] |
| The tangent sheaf along the test curve (578-607) | P §4.2 (505-528) |
| The normal line (608-702) | P §4.3 (529-597) — flagged in the source as "the only step needing care" |
| Remark 5.6 (line 674; do not cite [FKP, Theorem C] here) | Found 2026-09-23; **written for the paper**, no mathematical content. It also fixes the name collision with [FKP]'s own unrelated "Theorem B" |
| Remark 5.7 (line 684; why the generalisation is free, and why Ramond costs nothing extra) | P §4.3 (529-597) closing remark |
| Remark 5.8 (line 695) `[INF-NORMAL]` — the one inference beyond [FKP]'s literal statements | P §7 (854-918), the `[GAP]` list. ⏳ A `theorem-prover` round on closing this was dispatched 2026-09-23 (`research/attempts/fkp-96-punctured/`) and is in flight |
| The even tangent quotient (703-756) | P §4.4 (598-641) |
| Remark 5.10 (line 727; no closed-immersion hypothesis needed) | P §4.4 (598-641) |
| Remark 5.11 (line 745; dimension cross-check) | P §4.4 (598-641); an arithmetic self-check, not a step |

## Paper §6 (Proof of Theorem M)

- Lemma 6.1 (the key estimate, after [CN, Lemma 7.1]) and obstruction survival: P §4.5 (642-680)
- Assembly into Theorem M: P §4.6 (681-710)

## Paper §7 (Proposition N)

- Statement, proof, and the two corollaries: P §3 (336-414)
- The extension to the non-separating gluing morphism [FKP] (7.9) and to Ramond punctures on the moving component: P §3 (336-414), same section

## Paper §8 (Parity, consequences, threshold)

| Paper | Source |
|---|---|
| The parity refinement (947-969) | P §4.7 (711-737) |
| Eliminating $h$ and $a$; Corollary A, Theorem 8.4 (= Theorem B), Corollary 8.5 (970-1026) | P §5.1 (740-765) |
| Lemma 8.2(i): $h\ge2$ cannot be weakened (inside 970-1026) | P §5.2 (766-772). ⚠️ **The only line of reasoning in the paper that is not in P.** P's §5.2 states its conclusion unconditionally but computes only the even branch; the paper restates the standing hypothesis and adds one sentence observing that the odd theta characteristic on an elliptic curve is effective and hence excluded by that hypothesis. Full write-up in **I** item I1. It affects no theorem, corollary or threshold. **It should be checked by a reviewer** |
| Lemma 8.2(ii): $a\ge2$ gives nothing more (inside 970-1026) | P §5.3 (773-777) |
| Machine verification of the threshold arithmetic (1027-1052) | `scripts/thresholds.py`, a byte-identical copy of the attempt's script. Re-run from both locations, `RESULT: ALL OK`, exit 0 both times. ⚠️ Chinese comments and console output — see `NOTES-for-captain.md` §4 item 4 before bundling |

## Paper §9 (Consistency checks)

| Paper | Source |
|---|---|
| §9.1 Degeneration to [CN] at $n=r=0$ (1059-1067) | P §6.1 (793-798) |
| §9.2 The method cannot reach $\overline{\mathfrak M}{}^{-}_2$ (1068-1087) | P §6.2 (799-811) — the deliberate attempt to make the method contradict [CN, Thm 1.1(1)] |
| §9.3 No conflict with [DO] or [W] (1088-1112) | P §6.3 (812-820) |
| §9.4 The forgetful-morphism objection (1113-1154) | P §6.4 (821-853) |
| §9.5 What Theorem M forecloses (1155-1199) | **M**, plus four `L1` quotations from [DW] and [EW] (extraction records in `literature/extractions/`). See the warning below |

> ⚠️ **§9.5 rests on an attempt that has never been reviewed.** `research/attempts/supermoduli-measure-consequence/status.yaml` reads `state: under-review`, `reviewer: (none yet)`. Its own author classified the (C2) half as "physical-argument-level interpretive framing", not as proved mathematics. §9.5 as written leans mostly on things that do *not* need M — the restriction lemma is already in paper §9.3, Theorem M is the paper's own, and the four quotations are `L1` — so the exposure is smaller than the attempt's status suggests. But the section exists to answer a predictable referee question, so it is exactly the kind of text that must be right. A `graph-reviewer` round on M, including a check that §9.5 claims neither more nor less than M proves, was dispatched 2026-09-23 and is in flight. **This must be resolved before submission.**

## Paper §10 (Honest boundaries and open problems)

All six `[GAP-*]` labels and the surrounding text: P §7 (854-918), reproduced in full.

| Paper | Source |
|---|---|
| §10.1 `[GAP-FKP-RAMOND]` (1204-1222) | P §7; the wider footprint (FKP Lemma 8.7, Cor. 8.8, Lemma 9.1(i)) was added in the third literature round |
| §10.2 The shortcut we refuse (1223-1231) | P §7; [FKP] §9.3's own "We conjecture that …" |
| §10.3 `[GAP-COMP]` (1232-1240) | P §7. ⏳ A `theorem-prover` round on closing this was dispatched 2026-09-23 (`research/attempts/supermoduli-ramond-components/`) and is in flight |
| §10.4 `[GAP-ALT]` (1241-1247) | P §6.4 (821-853) + P §7. Wording strengthened, not softened, in the 2026-09-23 relayout |
| §10.5 Standard facts used without reproof (1248-1256) | P §7 |
| §10.6 Not addressed (1257-1268) | P §7 |

## Paper §11 (Conclusion) and References

- §11 (1269-1290): synthesis of P §8 (919-930)
- References (1291-): all twelve entries registered in `literature/sources.bib`; five background entries (Mumford, Cornalba, Jarvis, Serre, Green) were registered in the `lit-blockers` round, three of which did not reach `L1` — adequate because none carries load in any proof, recorded in **I** item I3

---

## Verification notes

1. **What does not trace to P.** Four items, all listed above: the one sentence in Lemma 8.2(i)
   (**I** item I1); §1.4 caveat (iii); Remark 5.6; and §9.5 in its entirety. Of these, only the first
   is a step in an argument, and it is a step that removes an unconditional sentence rather than
   adding one. Everything else in the paper is a transcription of P.
2. **Two source attempts, two different standings.** P is `verified` with two adversarial reviewer
   rounds. **M is `under-review` with none.** The paper does not distinguish them typographically,
   and it should not have to — but the captain's signature covers both, and §9.5 is the part that is
   not yet covered by any review at all.
3. **`captain_confirmed: false` on P as well.** Per the root `CLAUDE.md` that is sufficient for the
   content to be built upon internally and not sufficient for external release. Both the paper and
   §9.5's source are blocked on the same signature; see `NOTES-for-captain.md` §0.
4. **Honest boundaries preserved.** Every `[GAP-*]` in P §7 appears in paper §10. None was cut,
   shortened or relocated across the 2026-09-23 relayout; `[GAP-ALT]`'s wording was strengthened.
5. **Scope discipline.** The paper's scope is exactly the writable range the 2026-09-20 reviewer set
   as a graduation hard constraint (P's `status.yaml`, "毕业进图时的硬约束"): no component naming when
   $r\ge1$, no $(g,n,r)=(2,1,0)$, no $g=2$ odd-parity punctured components, nothing about the
   uncompactified stacks, no positive claim. ⏳ Whether the excluded cases are genuinely split or
   merely out of the method's reach is under investigation
   (`research/attempts/supermoduli-threshold-sharpness/`, dispatched 2026-09-23).
