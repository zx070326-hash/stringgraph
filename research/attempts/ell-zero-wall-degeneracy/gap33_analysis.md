# [GAP-3.3] Analysis Worksheet

## Task: Verify whether other Sen (D.19) branches hit the contour at ℓ=0

The current attempt (proof.md) proved that the v=1/2 pole (from n₂=0, m₁=n₁=m₂=0, j=1) has residue ∝ ℓ, hence zero at ℓ=0. But Sen (D.19) has many other branches. Do they hit the contour at ℓ=0?

## Part 1: n₂≠0 branches

### 1.1 Route-a's Theorem 9 statement

`gap-102b-route-a/proof.md` §5.7.4 Theorem 9 states:

> For any integers n≥m≥1, **0<ℓ≤m**, Δ=4mn−ℓ²>0, take Λ₀ = 1/(2√Δ).
> Then ∀Λ>Λ₀, the attractor contour contains no point on any n₂≠0 branch.

**Key formula** (Corollary 8):
```
Λ²(t*) ≤ 1/(4n₂²Δ) ≤ 1/(4Δ)
```

The bound is uniform over all n₂≠0, j odd, and all (ρ₁,σ₁,v₁)∈[0,1]³ satisfying constraint (I).

### 1.2 Check for ℓ-dependence in the derivation

**Constraint (I)** (from route-a §2, Lemma 1):
```
h(ρ₁,σ₁,v₁) := n₂(2nσ₁+2mρ₁−2ℓv₁) + jℓ + 2mn₁ − 2nm₁ = 0
```

At ℓ=0:
```
h = n₂(2nσ₁+2mρ₁) + 2(mn₁−nm₁) = 0
```
Still a valid linear constraint on (ρ₁,σ₁), independent of v₁. ✓

**Proposition 7 formula** (route-a §5.7.3):
```
Λ²(t*) = 1/(4n₂²Δ) − (j − 2n₂v₁)²/(16mnn₂²)
```

At ℓ=0: Δ = 4mn, so:
```
Λ²(t*) = 1/(16mnn₂²) − (j − 2n₂v₁)²/(16mnn₂²)
```

The formula is still well-defined. The bound:
```
Λ²(t*) ≤ 1/(16mnn₂²) ≤ 1/(16mn) = 1/(4Δ)
```
is finite and positive since m,n≥1. ✓

**Route-a's proof steps** (§5.7.1-5.7.4):
1. Parameterize (n₁,m₁) as (n₁₀+nt, m₁₀+mt), t∈ℤ (shift invariance of (I))
2. Show Λ²(t) is a downward parabola in t with A = -mn/(n₂Δ) < 0
3. Compute vertex height Λ²(t*) via B = nσ₁ - mρ₁ - (mn₁₀+nm₁₀)/n₂
4. Substitute σ₁ from (I), simplify to get Proposition 7
5. Note second term is ≤0 (subtract a square), deduce Corollary 8
6. Conclude Λ > 1/(2√Δ) ⟹ no real t solution

**Critical examination**:
- Step 2: A = -mn/(n₂Δ) involves Δ = 4mn−ℓ², but the sign A<0 holds regardless of ℓ (even at ℓ=0 where Δ=4mn).
- Step 4: Substituting σ₁ from (I) — does this involve dividing by ℓ?
  At ℓ=0, (I) reads: n₂(2nσ₁+2mρ₁) = −2(mn₁₀−nm₁₀), so σ₁ = [−(mn₁₀−nm₁₀) − n₂mρ₁]/(nn₂).
  No division by ℓ. ✓
- Step 5: The "subtract a square" logic is algebraic, independent of ℓ. ✓

### 1.3 Why does route-a state "0<ℓ≤m"?

Tracing back:
- Theorem 4 (n₂=0 closure, §4) explicitly uses ℓ>0 (Lemma A requires ℓ odd for parity, Lemma B uses 0<ℓ≤m for the bound j²<9).
- Section 3 shows ℓ=0 is a counterexample for n₂=0 branches.
- But Theorem 9 (n₂≠0 closure, §5.7) never uses ℓ>0 in its derivation — the "0<ℓ≤m" in its statement appears to be **inherited scope from the overall claim**, not a requirement of the n₂≠0 analysis itself.

### 1.4 Verification strategy

The route-a proof's SymPy verification (`verify_correct_B.py`, §5.7.3) checked Proposition 7 symbolically. To confirm it holds at ℓ=0, I should check:
1. Does constraint (I) at ℓ=0 still allow solutions in [0,1]³? (Yes, it's a hyperplane in (ρ₁,σ₁) space.)
2. Is the bound 1/(4Δ) finite at ℓ=0? (Yes, Δ=4mn>0.)
3. Does the "no v₁ dependence" in the final bound still hold? (Yes, the formula shows Λ²(t*)≤1/(4n₂²Δ) uniform in v₁.)

**Conclusion (Part 1, pending final check)**: 
The n₂≠0 closure **appears to work at ℓ=0** without modification. The derivation does not require ℓ>0. The statement scope "0<ℓ≤m" in Theorem 9 is likely an artifact of the overall claim's scope (which must exclude ℓ=0 due to n₂=0 counterexamples), not a limitation of the n₂≠0 argument itself.

**Action**: Verify this by reading route-a §5.7 line-by-line for any hidden ℓ>0 assumption.

### 1.5 Line-by-line verification of route-a §5.7 at ℓ=0

**Step 3 in Prop 7 proof** (route-a line 675):
> σ₁ = [−jℓ−2(mn₁₀−nm₁₀)−2n₂(mρ₁−ℓv₁)]/(2nn₂)

At ℓ=0:
```
σ₁ = [−2(mn₁₀−nm₁₀)−2n₂mρ₁]/(2nn₂) = [−(mn₁₀−nm₁₀)−n₂mρ₁]/(nn₂)
```
Well-defined, no division by ℓ. ✓

**Step 5**: The SymPy simplification that produces Prop 7's formula. The final formula:
```
Λ²(t*) = 1/(4n₂²Δ) − (j − 2n₂v₁)²/(16mnn₂²)
```
At ℓ=0: Δ=4mn, so 1/(4n₂²Δ) = 1/(16mnn₂²). The formula becomes:
```
Λ²(t*) = 1/(16mnn₂²) − (j − 2n₂v₁)²/(16mnn₂²)
```
Both terms have the same denominator. The bound Λ²(t*) ≤ 1/(16mnn₂²) = 1/(4Δ) is finite. ✓

**Conclusion**: Route-a Theorem 9's proof **does not require ℓ>0**. The statement's restriction "0<ℓ≤m" is inherited from the overall claim (to exclude ℓ=0 counterexamples in n₂=0 branches), not from the n₂≠0 analysis itself.

**Final answer for Part 1**: At ℓ=0, route-a Theorem 9 applies directly. The bound is:
```
Λ₀ = 1/(2√Δ) = 1/(2√(4mn)) = 1/(4√(mn))
```
For Λ > Λ₀, no n₂≠0 branch hits the contour. Since Λ can be arbitrarily large, n₂≠0 branches are **completely avoided** at ℓ=0.

---

## Part 2: n₂=0 subfamilies not yet handled

### 2.1 Complete classification of n₂=0 branches

From Sen (D.19), n₂=0 forces j²=1−4m₁n₁ (discriminant). Since j is odd, j²∈{1,9,25,...}.
For j²=1 (j=±1): m₁n₁=0.

**Three subfamilies**:
- (a) m₁=0, n₁ arbitrary: F = ±v + n₁σ + m₂
- (b) n₁=0, m₁ arbitrary: F = ±v − m₁ρ + m₂
- (c) m₁=n₁=0: F = ±v + m₂ (current attempt handled this)

For j²=9 (j=±3): 4m₁n₁ = 1−9 = −8, so m₁n₁=−2. Integer solutions: (m₁,n₁)∈{(1,−2),(−1,2),(2,−1),(−2,1)}.

Route-a Lemma B (§4.3) showed that for **0<ℓ≤m**, the constraint (I₀) (which is (I) with n₂=0) combined with the discriminant forces j²<9, hence only j=±1. But at **ℓ=0**, Lemma B's inequality chain breaks:
- Lemma B uses: 9ℓ² < 32mn ⟹ 4mn/Δ < 9 ⟹ j²<9.
- At ℓ=0: 9·0 < 32mn is trivially true, but the bound j²<9 no longer follows from (I₀) alone (the constraint becomes weaker).

So at ℓ=0, we must also handle **j=±3, ±5, ...** in principle. But the current attempt's mechanism (residue ∝ ℓ) only applies to poles that the contour actually **crosses**. The question is: at ℓ=0, which of these branches produce zeros that lie on the contour Im v=0?

### 2.2 Subfamily (a): m₁=0, n₁≠0, j=±1

F = v + n₁σ + m₂ = 0 (taking j=+1 for concreteness).
Zero at: **v = −n₁σ − m₂**.

On the contour: ρ=ρ₁+2inΛ, σ=σ₁+2imΛ, v=v₁ (ℓ=0 ⟹ Im v=0).
Substitute: v = v₁, σ = σ₁+2imΛ.
Zero condition: v₁ = −n₁(σ₁+2imΛ) − m₂ = −n₁σ₁ − m₂ − 2imn₁Λ.

For this to be real (v₁∈ℝ), need **Im part = 0**:
```
−2mn₁Λ = 0
```
Since m≥1, Λ>0, this requires **n₁=0**, contradicting the assumption n₁≠0.

**Conclusion (subfamily a)**: For any Λ>0, zeros from (m₁,n₁,m₂,j)=(0,n₁,m₂,1) with n₁≠0 have Im v = −2mn₁Λ ≠ 0, hence do **not** lie on the ℓ=0 contour.

Similarly for j=−1 (F = −v + n₁σ + m₂, zero at v = n₁σ + m₂, Im v = 2mn₁Λ ≠ 0 for n₁≠0).

### 2.3 Subfamily (b): n₁=0, m₁≠0, j=±1

F = v − m₁ρ + m₂ = 0 (j=+1).
Zero at: v = m₁ρ − m₂.

On contour: ρ = ρ₁+2inΛ, v = v₁.
Zero condition: v₁ = m₁(ρ₁+2inΛ) − m₂ = m₁ρ₁ − m₂ + 2inm₁Λ.

Imaginary part: Im v = 2nm₁Λ. For this to be zero (ℓ=0 contour), need m₁=0, contradiction.

**Conclusion (subfamily b)**: Zeros from (m₁,n₁,m₂,j)=(m₁,0,m₂,1) with m₁≠0 have Im v = 2nm₁Λ ≠ 0, do **not** lie on ℓ=0 contour.

### 2.4 Higher j values (j=±3, ±5, ...) at ℓ=0

At ℓ=0, the constraint (I₀) simplifies: n₂(2nσ₁+2mρ₁) + 2(mn₁−nm₁) = 0 (for n₂=0, this is just mn₁=nm₁, i.e., n₁/n = m₁/m).

For n₂=0, j=±3: discriminant 4m₁n₁ = 1−9 = −8 ⟹ m₁n₁ = −2.
Example: (m₁,n₁)=(1,−2). Then F = 3v − 2σ + ρ + m₂ = 0.
Zero at v = (2σ − ρ − m₂)/3. On contour: Im v = (2·2mΛ − 2nΛ)/3 = 2Λ(2m−n)/3.

For n≥m≥1, we have 2m−n ≤ m. If n>m, then 2m−n < m. In either case, 2m−n could be zero (if n=2m) or nonzero.
- If n=2m: Im v = 0 at this particular (n,m) — zero lies on contour! But this is a single (n,m) pair, not generic.
- If n≠2m: Im v ≠ 0 for Λ>0.

But wait: we haven't checked whether this actually satisfies (I₀) at ℓ=0. At ℓ=0 with n₂=0, (I₀) is: mn₁ = nm₁.
For (m₁,n₁)=(1,−2): mn₁ = −2m, nm₁ = n. Equality: −2m = n, i.e., n = −2m. Since n,m≥1, this is impossible (LHS<0, RHS>0).

So this branch doesn't satisfy (I₀) at all!

**Key insight**: At ℓ=0, constraint (I₀) for n₂=0 becomes **mn₁ = nm₁**, i.e., n₁/n = m₁/m (assuming m,n≠0). For m₁n₁≠0 (required by j²≥9), this forces n₁ and m₁ to have the same sign. But discriminant 4m₁n₁+j²=1 with j²≥9 gives m₁n₁ ≤ (1−9)/4 = −2 < 0, forcing opposite signs. Contradiction!

**Conclusion (j≥3 at ℓ=0)**: For n₂=0, j=±3,±5,..., the constraint (I₀) at ℓ=0 (which simplifies to mn₁=nm₁) is **incompatible** with the discriminant condition (which requires m₁n₁<0 for j²≥9). These branches produce no solutions at ℓ=0.

### 2.5 Summary of Part 2

At ℓ=0, n₂=0 branches split into:
- **m₁=n₁=0, j=±1**: Handled by current attempt. Zero at v∈ℤ, contour crosses at v=1/2, residue ∝ ℓ = 0. ✓
- **m₁=0, n₁≠0, j=±1**: Im v = ∓2mn₁Λ ≠ 0 for Λ>0, does not hit ℓ=0 contour. ✓
- **n₁=0, m₁≠0, j=±1**: Im v = ±2nm₁Λ ≠ 0 for Λ>0, does not hit ℓ=0 contour. ✓
- **j≥3**: Constraint (I₀) at ℓ=0 incompatible with discriminant, no solutions. ✓

**All n₂=0 subfamilies are closed at ℓ=0.**

---

## Final Conclusion for [GAP-3.3]

### Status: CLOSED

**Part 1 (n₂≠0)**: Route-a Theorem 9 applies at ℓ=0 without modification. For Λ > 1/(4√(mn)), no n₂≠0 branch hits the contour. ✓

**Part 2 (n₂=0 subfamilies)**:
- Subfamily (c) m₁=n₁=0: Current attempt already handled. Residue ∝ ℓ = 0. ✓
- Subfamilies (a)(b) with m₁n₁≠0: Do not hit ℓ=0 contour (Im v ≠ 0 for Λ>0). ✓
- Higher j: Discriminant incompatible with (I₀) at ℓ=0. ✓

**Combined answer**: At ℓ=0, ALL branches of Sen (D.19) either:
1. Do not hit the contour (n₂≠0 for Λ large enough; n₂=0 subfamilies (a)(b) for any Λ>0), OR
2. Hit the contour but have residue = 0 (subfamily (c), already proved by current attempt).

Therefore, d_*(m,n,0) is well-defined for Λ > 1/(4√(mn)).

---

## What to write in proof.md

Add a new section §6 (replacing the current [GAP-3.3] placeholder) with two subsections:
- §6.1: n₂≠0 branches (cite route-a Theorem 9, verify ℓ=0 applicability)
- §6.2: n₂=0 subfamilies (systematic enumeration, Im v calculations)

Conclusion: [GAP-3.3] is closed.
