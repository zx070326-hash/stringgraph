# Claim: Resolution of DGM eq(51)/(52) Contradiction

## Context

Dabholkar-Gaiotto-Murthy (arXiv:0803.2692) provide two key equations:
- eq(51): `𝒵_I = Σ_{s|I} s/Φ₁₀(s²ρ,σ,sv)` (generating function)
- eq(52): `Ω_I(m,n,ℓ) = Σ_{s|I} s·Ω₁(m/s², n, ℓ/s)` (divisor sum for indices)

The torsion-immortal-positivity-hecke attempt has **proven** these are mathematically incompatible for even divisors with odd ℓ/s (Prop 5.1, verified), with explicit numerical witness.

## Precise Claims

### Claim A: eq(52) is the Physically Correct Formula

**Statement**: For torsion I dyons in N=4 string theory, the single-centered (immortal) BPS index satisfies the divisor sum formula eq(52), not eq(51).

**Evidence Base**:
1. **Independent corroboration**: Alexandrov-Nampuri (arXiv:2009.01172) eq(2.11)+(2.13) independently derive a generating function that, when Fourier expanded, yields eq(52)
2. **Earlier independent sources**: BSS papers (arXiv:0802.0544, 0802.0556) predate DGM and give formulas consistent with eq(52)
3. **Mathematical consistency**: The unique generating function compatible with eq(52) is 𝒢_I with half-period shifts (Prop 5.4, verified)
4. **No erratum exists**: No published correction to DGM eq(51) has been found

### Claim B: [GAP 11.2] is Closeable

**Statement**: If eq(51) were correct instead, the divisor sum would require a dominance lemma:
```
d_*(m,n,ℓ) > Σ_{s|I, s≥2} s · d_*(m/s², n, ℓ/s)
```
This is **not needed** given Claim A (eq(52) is correct), but even if it were, the lemma follows from exponential dominance of the Cardy term.

**Argument**: By Rademacher/Cardy asymptotics, d_* ~ exp(π√Δ). For right-hand side terms, Δ' = Δ/s² ≤ Δ/4, giving exponential suppression. Finite small-Δ cases are numerically verified (219 points, no counterexamples in torsion-immortal-positivity-hecke §12).

### Claim C: Graph Implications

**Current bottleneck**: `holography.torsion-immortal-positivity` is compressed to `physical-argument` via:
- holography.dgm-torsion-divisor-sum [physical-argument]
- holography.dvv-dyon-index-generating-function [physical-argument]

**Resolution**: 
- eq(52) itself remains a **physical premise** (cannot be Hecke-derived, per torsion-immortal-positivity-hecke §8)
- But its **internal mathematical consistency** is now established
- The "divisor sum commutes with immortal projection" (缝A gap (i)) is **rigorous** via Thm 4.1
- Combined status: **eq(52) is the minimal physical input; everything downstream is rigorous given eq(52)**

## What This Attempt Will NOT Prove

This is **not** a claim that eq(52) is "pure mathematics" or derivable from first principles. It remains a physical premise. This attempt resolves:
1. Which of the two DGM equations is correct
2. Whether the mathematical structure conditional on that equation is complete
3. What remains as irreducible physical input

## Quantifiers

∀ I ≥ 1, ∀ (m,n,ℓ) with I²|m, I|ℓ, m,n≥1, Δ>0: The divisor sum formula matching physical BPS counting is eq(52), not eq(51).

## Dependencies (Bricks from Graph)

None directly from graph nodes - this is a literature adjudication based on:
- torsion-immortal-positivity-hecke (research attempt, verified)
- Published papers: DGM 0803.2692, A-N 2009.01172, BSS 0802.0544/0556
