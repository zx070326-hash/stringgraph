# graph/statements — Statement Nodes by Area

This directory contains all statement nodes (陈述节点): definitions, propositions, and axioms. Each `.yaml` file is one node.

## Organization by Area

| Area | Files | Description |
|------|-------|-------------|
| `worldsheet/` | 378 | Worldsheet CFT, BRST, ghosts, Virasoro, DDF operators |
| `math/` | 86 | Pure math: Lie algebras, modular forms, partitions, cohomology |
| `spectrum/` | 45 | String spectrum, mass levels, tachyons, physical states |
| `compact/` | 25 | Compactifications, toroidal geometry, winding modes |
| `holography/` | 25 | AdS/CFT, holographic principle, black hole entropy |
| `consistency/` | 29 | Anomaly cancellation, tadpole constraints |
| `swampland/` | 31 | Swampland conjectures, WGC, distance conjecture |
| `branes/` | 24 | D-branes, tensions, charges, intersections |
| `duality/` | 10 | T-duality, S-duality, U-duality |
| `cft/` | 3 | General CFT statements (most CFT is in worldsheet/) |
| `susy/` | 4 | Supersymmetry, superspace, fermions |

**Total**: 660 statements

## ID Convention

`<area>.<slug>` where slug is lowercase with hyphens, e.g., `worldsheet.no-ghost-theorem-v4`

## Before Adding a Statement

1. **Search first**: `uv run stringgraph search <keyword>` to check for duplicates
2. Read parent `CLAUDE.md` for rules (陈述与推导分离、status 只能实话实说)
3. Check `../conventions/` for which convention family applies to your statement
4. See `../schema/` for valid field values

## Companion Directory

Each statement can have multiple derivations in `../derivations/<area>/<statement-slug>--via-<method>.yaml`
