# [GAP-3.3] Closure Report

**Agent**: theorem-prover (agent/prover/gap33-ell-zero)  
**Date**: 2026-09-20  
**Status**: CLOSED

## Task

Verify whether Sen (D.19) branches other than the (m₁,n₁,m₂,n₂,j)=(0,0,m₂,0,±1) subfamily hit the attractor contour at ℓ=0, and if so, whether their residues also vanish.

## Summary

**All Sen (D.19) branches at ℓ=0 either:**
1. Do not hit the contour (離開實軸 Im v≠0 or Λ large enough), OR
2. Hit the contour but have residue ∝ ℓ = 0 (already proved in §2-§4).

Therefore, d_*(m,n,0) is well-defined for Λ > 1/(4√(mn)).

## Part 1: n₂≠0 branches

### Claim
For ℓ=0, Λ > 1/(4√(mn)), no n₂≠0 branch hits the contour.

### Proof strategy
Verified that `gap-102b-route-a` Theorem 9 (§5.7) applies at ℓ=0 without modification.

### Line-by-line verification of route-a §5.7 at ℓ=0

**Constraint (I)** (route-a line 110):
```
h := n₂(2nσ₁+2mρ₁−2ℓv₁) + jℓ + 2(mn₁−nm₁) = 0
```
At ℓ=0:
```
h = n₂(2nσ₁+2mρ₁) + 2(mn₁−nm₁) = 0
```
Solving for σ₁ (route-a line 675):
```
σ₁ = [−jℓ−2(mn₁₀−nm₁₀)−2n₂(mρ₁−ℓv₁)]/(2nn₂)
```
At ℓ=0:
```
σ₁ = [−(mn₁₀−nm₁₀)−n₂mρ₁]/(nn₂)
```
**No division by ℓ.** ✓

**Proposition 7** (route-a line 660):
```
Λ²(t*) = 1/(4n₂²Δ) − (j − 2n₂v₁)²/(16mnn₂²)
```
At ℓ=0, Δ=4mn:
```
Λ²(t*) = 1/(16mnn₂²) − (j − 2n₂v₁)²/(16mnn₂²)
```
**Both terms well-defined, bound finite.** ✓

**Corollary 8** (route-a line 699):
```
Λ²(t*) ≤ 1/(4n₂²Δ) ≤ 1/(4Δ)
```
At ℓ=0:
```
Λ²(t*) ≤ 1/(16mnn₂²) = 1/(4Δ)
```
**Uniform bound, independent of v₁.** ✓

**Conclusion**: Route-a Theorem 9 states "0<ℓ≤m" in its precondition, but this is inherited from the overall claim scope (to exclude ℓ=0 counterexamples in n₂=0 branches). The n₂≠0 analysis itself **never uses ℓ>0**. At ℓ=0, Theorem 9 gives Λ₀ = 1/(4√(mn)).

### What I verified personally
- Read route-a §5.7 line-by-line (lines 655-734).
- Checked constraint (I) simplification at ℓ=0: no division by ℓ, remains linear in (ρ₁,σ₁).
- Verified Proposition 7 formula is well-defined at ℓ=0 (Δ=4mn>0).
- Confirmed Corollary 8's bound is finite and uniform at ℓ=0.
- Verified the SymPy verification script path (`scripts/verify_correct_B.py`) exists in route-a.

### What I relied on from upstream
- Route-a Theorem 9 itself (proved 2026-09-20, verified by graph-reviewer agent n2rev).
- Route-a's dependency on [GAP-identify] (Sen's Φ̃ coordinates = standard Φ₁₀ coordinates), still open.

---

## Part 2: n₂=0 subfamilies

### Classification
At n₂=0, discriminant 4m₁n₁+j²=1 with j odd.

**j=±1** (j²=1): m₁n₁=0. Three subfamilies:
- (c) m₁=n₁=0: v∈ℤ poles, already handled (§2-§4). ✓
- (a) m₁=0, n₁≠0: F = ±v + n₁σ + m₂ = 0
- (b) n₁=0, m₁≠0: F = ±v − m₁ρ + m₂ = 0

**j≥3** (j²≥9): m₁n₁ = (1−j²)/4 < 0 (opposite signs required).

### Subfamily (a): m₁=0, n₁≠0, j=±1

**Zero location**: v = −n₁σ − m₂ (for j=+1).

On contour: σ = σ₁+2imΛ, v = v₁ (ℓ=0 ⇒ Im v = 0).

Substituting:
```
v₁ = −n₁(σ₁+2imΛ) − m₂ = −n₁σ₁ − m₂ − 2imn₁Λ
```

**Imaginary part**:
```
Im v = −2mn₁Λ
```

For m,n,Λ≥1 and n₁≠0: **Im v ≠ 0** ⇒ zero does not lie on ℓ=0 contour (which requires Im v=0).

**Similarly for j=−1**: Im v = +2mn₁Λ ≠ 0.

**Conclusion**: Subfamily (a) does not hit ℓ=0 contour for any Λ>0. ✓

### Subfamily (b): n₁=0, m₁≠0, j=±1

**Zero location**: v = m₁ρ − m₂ (for j=+1).

On contour: ρ = ρ₁+2inΛ, v = v₁.

Substituting:
```
v₁ = m₁(ρ₁+2inΛ) − m₂ = m₁ρ₁ − m₂ + 2inm₁Λ
```

**Imaginary part**:
```
Im v = 2nm₁Λ ≠ 0    (m₁≠0)
```

**Conclusion**: Subfamily (b) does not hit ℓ=0 contour for any Λ>0. ✓

### Subfamily j≥3

**Discriminant requirement**: m₁n₁ = (1−j²)/4 < 0 for j²≥9.
⇒ m₁ and n₁ have **opposite signs** (both nonzero).

**Constraint (I) at ℓ=0** (gap-102b §2, for n₂=0):
```
h = jℓ + 2(mn₁−nm₁) = 2(mn₁−nm₁)    (at ℓ=0)
```
Constraint h=0 ⇒ **mn₁ = nm₁**, i.e., n₁/n = m₁/m (since m,n≥1).

If m₁,n₁ both nonzero, this ratio equality forces m₁ and n₁ to have the **same sign** (both numerators and denominators positive).

**Contradiction**: Discriminant requires opposite signs, constraint (I) requires same sign.

**Conclusion**: Subfamily j≥3 has no solutions at ℓ=0 (constraint incompatible with discriminant). ✓

### What I verified personally
- Derived Im v formulas for subfamilies (a) and (b) from scratch.
- Verified constraint (I) simplification at n₂=0, ℓ=0: h = 2(mn₁−nm₁).
- Checked discriminant 4m₁n₁+j²=1 for j≥3 forces m₁n₁<0.
- Confirmed sign contradiction between discriminant and constraint (I) at ℓ=0.

### What I relied on
- Sen (D.19) branch formula F = n₂(σρ−v²) + jv + n₁σ − m₁ρ + m₂ (from gap-102b-route-a §2).
- Contour parameterization: ρ=ρ₁+2inΛ, σ=σ₁+2imΛ, v=v₁+iℓΛ (from claim.md §0).

---

## Combined Conclusion

At ℓ=0, all Sen (D.19) branches:

| Branch | Subfamily | Hits contour? | Residue |
|--------|-----------|---------------|---------|
| n₂≠0 | all | No (Λ>Λ₀) | N/A |
| n₂=0 | m₁=n₁=0 | Yes (v=1/2) | ∝ ℓ = 0 ✓ |
| n₂=0 | m₁=0,n₁≠0 | No (Im v≠0) | N/A |
| n₂=0 | n₁=0,m₁≠0 | No (Im v≠0) | N/A |
| n₂=0 | j≥3 | No (no solution) | N/A |

**Therefore**: d_*(m,n,0) is well-defined for Λ > 1/(4√(mn)). [GAP-3.3] is CLOSED.

---

## Dependencies and trust chain

### Directly verified by me
- Route-a §5.7 formulas work at ℓ=0 (constraint, Prop 7, Cor 8).
- Im v calculations for n₂=0 subfamilies (a)(b).
- Constraint (I) vs discriminant incompatibility for j≥3.

### Relied on from upstream (explicitly noted in proof.md §6)
- Route-a Theorem 9 (verified 2026-09-20 by graph-reviewer agent n2rev).
- Route-a's open dependency [GAP-identify] (Sen's coordinates = standard Φ₁₀).
- Sen (D.19) branch formula (original source: Sen 2008, registered in gap-102b).
- Φ₁₀ basic properties: periodicity (Fourier expansion), v-evenness ([EXT-Even]).

### Red-flagged (not rigorous in graph)
- [EXT-Even] (Φ₁₀ v-evenness): not yet a graph node, required by reviewer to be registered before graduation.
- [GAP-identify]: open gap in route-a, inherited by this work.

---

## Reviewer audit request

Lead should dispatch graph-reviewer to audit:
1. **Im v calculation correctness** (§6.2, subfamilies a/b).
2. **Constraint (I) simplification at ℓ=0** for n₂=0 (did I correctly reduce to mn₁=nm₁?).
3. **Route-a Theorem 9 ℓ=0 applicability** (§6.1, did I miss any hidden ℓ>0 assumption?).
4. **Sign contradiction logic** for j≥3 (discriminant vs constraint, same-sign vs opposite-sign).
5. **Gap33_analysis.md worksheet** (this file serves as detailed scratch work, can be audited or deleted post-merge).
