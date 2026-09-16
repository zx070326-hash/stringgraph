# research/attempts — Original Proof Attempts

This directory contains 6 active research attempts: original proofs for results where no published proof exists.

## Purpose

Most of this project curates **published** results. But when auditing reveals a key lemma has **no source anywhere**, we can attempt an original proof here. Results stay isolated from `../../graph/` until verified and graduated.

## Active Attempts

| Slug | Status | Description |
|------|--------|-------------|
| `bkm-shift-explanation/` | Under review | Why BKM product formula shifts c → c-2 |
| `d10-anomaly-full-classification/` | Draft | Complete classification of D=10 anomaly solutions |
| `dmz-finite-part-scoping/` | Draft | Scope of Dedekind eta modular form finite part |
| `gap-102b-route-a/` | Draft | Filling gap 102b in critical dimension proof |
| `level-n-count-generalization/` | Draft | Generalize level counting beyond N=7 |
| `torsion-immortal-positivity-hecke/` | Verified | N=4 twisted dyon immortal index positivity (ready to graduate) |

## Lifecycle

1. **Draft**: Prover writes `claim.md` (precise statement) and `proof.md` (argument)
2. **Under review**: Graph-reviewer does adversarial audit
3. **Verified**: Reviewer confirms proof is valid, writes verdict to `status.yaml`
4. **Graduated**: Curator adds to `../../graph/` with source pointing back here

## Structure of Each Attempt

```
<slug>/
  claim.md          # Precise statement with quantifiers, references graph nodes
  proof.md          # Paper-grade argument, [GAP: ...] marks allowed for honest gaps
  status.yaml       # {state, reviewer, verdict, notes, captain_confirmed}
  scripts/          # Optional: computational verification scripts
  scratch.lean      # Optional: Lean experiments (not held to formal/ standards)
```

## Rules

1. **Claim must be precise first**: No proof without a complete statement
2. **Only reference rigorous/formalized nodes**: Don't build conjectures on conjectures
3. **Gaps must be marked**: `[GAP: ...]` is honest, handwaving is not
4. **Graduation requires verification**: No self-certified proofs in the main graph

## When to Start an Attempt

Only when:
- You've confirmed no published proof exists (not just "we haven't found it")
- The gap is blocking a milestone or formalization target
- The attempt is worth the effort (don't redo known results)

See parent `../CLAUDE.md` for full discipline.
