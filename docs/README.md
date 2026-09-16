# docs — Project Documentation

High-level vision, methodology, and status definitions for the stringgraph project.

## Core Documents

| File | Purpose |
|------|---------|
| `VISION.md` | Why build a machine-readable dependency graph for string theory |
| `METHODOLOGY.md` | Lessons from Prove2Me, FLT, Navier-Stokes projects |
| `STATUS_LEVELS.md` | Precise definitions of formalized / rigorous / physical-argument / conjecture |
| `CONVENTIONS.md` | How notational conventions are handled in the graph |
| `ROADMAP.md` | Current phase, active workstreams, milestone targets |

## Specialized Documentation

### Captain Packets
- `CAPTAIN-PACKET-2026-09-12.md` — Milestone audit package for human review

### Paper Outlines
- `PAPER-outline-formalization.md` — Draft paper on first formalization results
- `PAPER-outline-methodology.md` — Draft paper on the graph methodology itself

### Frontier Scouting
`frontier-scouting/` — Research notes on potential expansion areas:
- `a-theorem-rg.md` — Zamolodchikov's a-theorem and RG flows
- `bh-information-islands.md` — Black hole information paradox, island formula
- `bh-microstate-counting.md` — Microscopic black hole entropy
- `mock-modular-mathlib-gap.md` — Gap between Mathlib and mock modular form needs
- `pssy-page-rmt-dedup.md` — Page curve and random matrix theory
- `swampland-wgc.md` — Weak gravity conjecture

### Drafts
`drafts/` — Work-in-progress analysis:
- `brst-normal-ordering-convention.md` — Resolving BRST ordering ambiguities
- `critdim-route-cards.md` — Critical dimension proof decomposition cards

### Reviews
`reviews/` — Post-mortem analysis:
- `brst-nilpotency-recompute-2026-09-12.md` — BRST nilpotency calculation review

## Key Concepts

**Status Levels** (strictest to weakest):
1. `formalized` — Lean proof with no sorry, no non-standard axioms
2. `rigorous` — Paper-level mathematical proof
3. `physical-argument` — Physicist's derivation (may skip steps, use heuristics)
4. `conjecture` — Proposed but unproven
5. `refuted` — Proven false

**Effective Status**: A proposition's status is the minimum of its own status and all its dependencies.

## Current Phase (see ROADMAP.md)

- **Formalization line**: Phase 1 worldsheet subgraph, targeting Goddard-Thorn no-ghost theorem
- **Black hole line**: Phase 3 holography + original proof track for dyon index positivity

## Navigation

- Project overview: Start with `VISION.md`
- Working on the graph: See `../graph/CLAUDE.md`
- Formalizing: See `../formal/CLAUDE.md`
- Adding literature: See `../literature/CLAUDE.md`
