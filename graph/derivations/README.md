# graph/derivations — Derivation Nodes by Area

This directory contains all derivation nodes (推导节点): proofs, physical arguments, conjecture supports, and refutations. Each `.yaml` file is one derivation connecting dependencies to a target statement.

## Organization by Area

| Area | Files | Description |
|------|-------|-------------|
| `worldsheet/` | 299 | Derivations for worldsheet CFT results |
| `math/` | 84 | Pure mathematics proofs |
| `spectrum/` | 41 | String spectrum derivations |
| `swampland/` | 34 | Swampland conjecture arguments |
| `compact/` | 22 | Compactification derivations |
| `holography/` | 21 | Holography derivations |
| `consistency/` | 21 | Anomaly cancellation proofs |
| `branes/` | 20 | Brane property derivations |
| `duality/` | 8 | Duality derivations |
| `cft/` | 3 | General CFT derivations |
| `susy/` | 2 | Supersymmetry derivations |

**Total**: 555 derivations

## ID Convention

`<statement-id>--via-<method>` where method describes the derivation approach, e.g.:
- `worldsheet.no-ghost-theorem-v4--via-goddard-thorn`
- `math.dedekind-eta-function--via-mathlib-bridge`

## Key Fields

- `target`: The statement id being derived
- `kind`: `proof` | `physical-argument` | `conjecture-support` | `refutation`
- `status`: Own rigor level (effective status computed by propagation)
- `depends_on`: List of statement ids this derivation requires
- `sources`: Literature references with specific locations

## Rules

- Every `depends_on` entry must have a source or be marked `inferred: true`
- Status must reflect the derivation's actual rigor, not "community consensus"
- Multiple derivations for the same statement are allowed (different methods/sources)

## Companion Directory

Targets are in `../statements/<area>/<slug>.yaml`
