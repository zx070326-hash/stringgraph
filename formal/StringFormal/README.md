# StringFormal — Lean 4 Formalization Modules

Lean 4.33.1 + Mathlib v4.33.1. Root module: `StringFormal.lean` (all imports must chain from here).

## Module Organization

| Directory | Files | Description |
|-----------|-------|-------------|
| `Math/` | 15 | Pure mathematics: partitions, η-function, Euler-Poincaré, modular forms |
| `Virasoro/` | 12 | Virasoro/Witt algebras, Verma modules, Shapovalov form, Kac determinants |
| `NoGhost/` | 30+ | No-ghost theorem machinery: Fock space, DDF operators, level counting |
| `Scratch/` | — | Experimental code (not imported into main build) |

## Math Module Highlights

- **Partitions & Counting**: `EulerPartition.lean`, `PartitionCard.lean` — Euler product formula, explicit partition counts
- **Modular Forms**: `DedekindEtaS/T/Modular.lean` — η-function transformations, SL(2,ℤ) invariance
- **Homology**: `EulerPoincare.lean` — Euler-Poincaré principle (Mathlib has definitions but not the theorem)
- **Anomalies**: `AnomalyPolynomial.lean`, `IIBAnomalyUnique.lean` — D=10 anomaly cancellation
- **Bridges**: `MathlibBridges.lean` — Connects Mathlib definitions to graph statement conventions

## Virasoro Module Highlights

- **Algebras**: `Witt.lean`, `Basic.lean` — Witt and Virasoro Lie algebras
- **Representations**: `Verma.lean`, `VermaPBW.lean` — Verma modules, PBW basis
- **Shapovalov Form**: `Shapovalov.lean`, `ShapovalovLevel{Three,Four}.lean` — Gram matrices, Kac determinants
- **Cohomology**: `WittCohomologyH1.lean` — H¹(W,k)=0 and perfectness characterization

## NoGhost Module Highlights (30+ files)

Core infrastructure:
- `Fock.lean` — D-dimensional oscillator Fock space, CCR, bilinear form
- `Sugawara.lean` — Virasoro generators from energy-momentum tensor
- `PhysicalStates.lean` — Physical state submodule, L_n adjoint relations

DDF machinery:
- `VertexOperator.lean`, `DDF.lean` — Exponential vertex operators, DDF tower
- `DDFAlgebra.lean` — Transverse DDF oscillator algebra [A^ε_m, A^δ_n] = m(ε·δ)δ_{m+n,0}
- `DDFGram.lean` — DDF state Gram matrix is diagonal

Light-cone frame:
- `LightCone.lean`, `LightConeFrame.lean` — Frame structure, witness construction
- `Longitudinal.lean` — K_m operators, characterization of DDF span

Level-by-level proofs (蓝图 §B/B′/B″/B‴/B⁗):
- `LevelTwo{,Span,Count}.lean` — N=2 physical states, Type-1/Type-2 null states, counting identity
- `LevelThree/FourCount.lean` — N=3,4 moment relations, counting identities
- `LevelFiveCount.lean` — N=5 kernel bound from Euler pentagonal, κ₅=1
- `DescendantKernel.lean` — General kernel upper bound for (L_{-1}, 𝒟₂) map

Assembly:
- `Assembly.lean` — No-ghost conditional on DDFSpans assumption
- `Glue.lean` — Bigrading projections, slice-by-slice ⇒ global
- `SliceRank/Dim.lean` — Dimension inequality B26, DDF span intersection counting
- `SpuriousElimination.lean` — b̃-degree elimination, (P3) physical state dimension bound
- `TypeOneFamily.lean` — D-independent null state lower bound
- `NullSeedsTwo.lean` — Type-1/Type-2 null states, D=26 entry point (𝒟₂ operator)

Critical dimension:
- `FockFreeLowLevel.lean` — Fock module is free under Vir⁻ at N≤4, kacDet2_massShell_two = 2(c-26)
- `Ghost.lean` — bc ghost system central charge c^g = -26 (SL(2,C) normal ordering)

## Build Instructions

```bash
cd formal
lake build                    # Build all (from StringFormal.lean import chain)
lake build StringFormal.Path.To.Module   # Build specific module
```

**Critical**: New `.lean` files are **not built** unless imported into `StringFormal.lean` or transitively imported by something that is. See parent `CLAUDE.md` for the 2026-09-16 isolation incident.

## Graph Integration

Formalized statements have `formal.lean_decl` and `formal.lean_file` fields pointing here. After `lake build`, run:

```bash
uv run stringgraph check-axioms   # Verify no sorry, no non-standard axioms
```

Only declarations passing this check can mark their derivation `formalized`.
