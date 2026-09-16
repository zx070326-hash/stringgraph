# graph/milestones — Curated Milestone Statements

This directory contains 5 milestone nodes: carefully audited, canonical formulations of major results that serve as anchors for the dependency graph.

## What Makes a Milestone

- **Human-audited**: Must pass back-translation audit (只看 YAML 翻回自然语言，再与原文比对)
- **Captain-approved**: Requires explicit approval (`audit.status: approved`)
- **Canonical formulation**: The definitive statement for this result
- **Major result**: Significant theorem or classification (not intermediate lemmas)

## Current Milestones

| File | Target Statement | Status | Description |
|------|------------------|--------|-------------|
| `critical-dimension-bosonic.yaml` | `worldsheet.bosonic-critical-dimension-26` | Approved | D=26 for bosonic string |
| `critical-dimension-brst-nilpotency.yaml` | `worldsheet.brst-nilpotency-critical-dimension` | Approved | BRST nilpotency at D=26 |
| `no-ghost-theorem.yaml` | `worldsheet.no-ghost-theorem-v4` | Approved | Goddard-Thorn no-ghost theorem |
| `ddf-commute-with-virasoro.yaml` | `worldsheet.ddf-commute-with-virasoro` | Approved | DDF operators commute with Virasoro |
| `bh-entropy-cartography.yaml` | `holography.bh-entropy-cartography` | Draft | Black hole entropy landscape (under review) |

## Audit Process

1. **Draft**: Milestone created, points to a statement
2. **Back-translation**: Auditor reads only YAML/Lean, translates to natural language
3. **Comparison**: Compare translation with original source
4. **Verdict**: `faithful` | `drift` | `wrong`
5. **Approved**: Captain confirms after faithful back-translation

## Fields

```yaml
id: milestone-slug
statement_id: area.statement-slug  # Must exist in ../statements/
audit:
  status: draft | back-translated | approved
  back_translation: |
    Human-readable statement reconstructed from the formal YAML
  auditor: physics-auditor
  verdict: faithful | drift | wrong
  date: YYYY-MM-DD
  notes: Any drift or issues found
```

## Why Milestones Exist

Only milestones require captain approval. Other nodes are added freely by agents and validated by tools + reviewers. This keeps the human review surface finite while maintaining quality.

See `../../docs/CAPTAIN-PACKET-*.md` for audit packages.
