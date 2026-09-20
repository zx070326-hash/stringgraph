# Claim: Resolution of DGM eq(51)/(52) Contradiction

## Context

Dabholkar-Gaiotto-Murthy (arXiv:0803.2692) provide two key equations:
- eq(51): `𝒵_I = Σ_{s|I} s/Φ₁₀(s²ρ,σ,sv)` (generating function)
- eq(52): `Ω_I(m,n,ℓ) = Σ_{s|I} s·Ω₁(m/s², n, ℓ/s)` (divisor sum for indices)

The torsion-immortal-positivity-hecke attempt has **proven** these are mathematically incompatible for even divisors with odd ℓ/s (Prop 5.1, verified), with explicit numerical witness.

## Primary Claim (Negative Result)

**Statement**: Resolving the DGM eq(51)/(52) contradiction does NOT enable upgrading `holography.torsion-immortal-positivity` from `physical-argument` to `rigorous`.

**Reason**: The actual bottleneck in the dependency chain is `holography.dvv-dyon-index-generating-function` (DVV conjecture: 1/Φ₁₀ coefficients = 1/4-BPS helicity supertrace), which:
- Lies beneath eq(52) in the dependency tree
- Has `own_status: physical-argument` (field-wide open conjecture)
- Cannot be resolved by literature adjudication of eq(51) vs eq(52)

**Evidence**: Direct verification via `uv run stringgraph why holography.torsion-immortal-positivity` shows:
```
holography.torsion-immortal-positivity [physical-argument]
  ↳ own status rigorous; limited by 1 dep
  holography.dgm-torsion-divisor-sum [physical-argument]
    ↳ own status physical-argument and 1 dep
    holography.dvv-dyon-index-generating-function [physical-argument]
```

Even if eq(52) were upgraded, `dgm-torsion-divisor-sum` has `own_status: physical-argument` and depends on DVV, so the target node's `effective` status would not move.

## Secondary Claim (Literature Adjudication)

**Statement**: eq(52) is the correct formula; eq(51) requires half-period shift correction.

**Evidence Base** (consolidation of existing project extraction records, NOT independent verification):
1. Mathematical incompatibility proven (Prop 5.1 from torsion-immortal-positivity-hecke, verified)
2. Project extraction records from `literature/sources.bib`:
   - Alexandrov-Nampuri arXiv:2009.01172: note states eq(2.11)+(2.13) gives half-shift form consistent with eq(52)
   - BSS arXiv:0802.0544/0556: note states formulas show half-integer v shift requirement
3. No published erratum for DGM eq(51)
4. Unique compatible generating function is 𝒢_I with (s-1)/2 shifts (Prop 5.4, verified)

## What This Attempt Does NOT Claim

- Independent verification of A-N or BSS papers (did not read original PDFs)
- That eq(52) can be mathematically derived (§8 proves it cannot be derived via Hecke operators or pure modular form theory)
- That [GAP 11.2] is rigorously closed (it has asymptotic heuristic + numerical support, not rigorous proof)
- That resolving this enables any graph node upgrades (it does not, per primary claim)

## Quantifiers

∀ attempts to upgrade `holography.torsion-immortal-positivity` via eq(51)/(52) resolution: the upgrade path does not go through eq(52), it goes through DVV conjecture.

## Dependencies (Bricks from Graph)

None directly - this is literature consolidation + bottleneck tree analysis.

Referenced but not depended on:
- torsion-immortal-positivity-hecke (research attempt, verified)
- Project extraction records in literature/sources.bib
