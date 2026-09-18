# Formalization Blueprint: D=10 Anomaly-Free Gauge Algebra Classification

This blueprint plans the formalization of proposition (S) from
`research/attempts/d10-anomaly-full-classification/proof.md`: the complete
classification of compact Lie algebras satisfying D=10 anomaly cancellation.

**Target**: Let 𝔤 be compact, dim 𝔤 = 496, satisfying
`Tr F⁶ = (1/48)·Tr F⁴·Tr F² − (Tr F²)³/14400`. Then 𝔤 ≅ so(32) or e₈⊕e₈ or
e₈⊕u(1)²⁴⁸ or u(1)⁴⁹⁶.

---

## Scope & Strategy

Complete formalization requires Killing-Cartan classification + Chevalley
restriction (both absent from Mathlib v4.33.1). This blueprint targets
**incremental PRs** starting with highest-value, lowest-risk pieces.

---

## PR Sequence

### PR0: Exceptional Algebra Exclusion ★ PARTIAL (G₂, F₄, E₆ done; E₇ open)

**Goal**: Prove G₂, F₄, E₆, E₇ violate condition (i); E₈ satisfies it.

**Current status** (updated 2026-09-18):
- ✓ G₂ violates anomaly (12 roots, kernel-checked `simp only [...]; norm_num`, no `native_decide`)
- ✓ F₄ violates anomaly (48 roots, same kernel-checked approach)
- ✓ E₆ violates anomaly (72 roots, same kernel-checked approach — **see postmortem below**,
  a root-table bug, not a tooling bug, was blocking this)
- ✗ E₇ NOT IMPLEMENTED (126 roots, list literal times out during elaboration)
- E₈ already done in `E8Roots.lean`

**File**: `StringFormal/Math/ExceptionalAnomalyExclusion.lean`

**What works**:
- `g2_violates_anomaly`: existence proof with witness point H = (1, 0, -1)
- `f4_violates_anomaly`: existence proof with witness point H = (1, 0, 0, 0)
- `e6_violates_anomaly`: existence proof with witness point H = (1, 0, 0, 0, 0, 0, 0, 0)

**Postmortem — the `native_decide`/E₆ misdiagnosis (2026-09-18)**:

An earlier round used `native_decide` for all six G₂/F₄ power-sum theorems. That is
disallowed by project policy (`native_decide` introduces a fresh `Lean.ofReduceBool`-family
axiom per invocation, which fails `check-axioms`'s "only `propext`, `Classical.choice`,
`Quot.sound`" rule). All six were replaced with kernel-checkable
`simp only [<definitional unfolds + List.map/sum_cons/nil + Matrix.cons_val*>]; norm_num`
proofs — no block decomposition à la `E8Roots.lean` was needed because each goal is a
*fixed numeric witness point*, not an identity for arbitrary `x`.

Separately, the docstring claimed **E₆ (72 roots): `native_decide` computes incorrect
values**, phrased as if the tool were unreliable. Auditing the root table (recovered from
git history, commit `9565d95`) found the real cause: a root-table bug, specifically an
off-by-one confusion between Bourbaki's 1-indexed range `i ≤ 5` (5 coordinates `1..5`) and
a 0-indexed reading of the same string (wrongly suggesting 6 coordinates `0..5`):
- the "D₅ block" `±eᵢ±eⱼ` used 10 pairs drawn from the wrong 6-coordinate index set
  `{0,...,5}` (and even then covered only 10 of the 15 possible pairs there) instead of
  *all* 10 pairs `i<j` among the correct 5 coordinates `{0,...,4}`;
- the spinor block's alternating-sign sum ranged over 6 coordinates `i=0..5` with only 2
  fixed coordinates, instead of 5 coordinates `i=0..4` with 3 fixed (`e₆,e₇,e₈` pinned at
  `(-1/2,-1/2,+1/2)`).

Both blocks had the *right length* (40 and 32 respectively, so the "72 roots" count looked
fine) but the *wrong vectors* — hence non-standard power sums, which `native_decide`
(and any other evaluator) reported faithfully. The E₆ embedding used here is the standard
Bourbaki 8-dimensional one and is fully rational (coordinates ∈ {0, ±1, ±1/2}; no `√3` is
needed — that only appears in the unrelated 6-dimensional presentation of E₆), so "E₆
can't be written over ℚ" was never the issue. **Decision: option (a)** — the root table was
fixed (`e6RootsD5`, `e6RootsHalf` in the Lean file) and the three E₆ power-sum theorems were
added with the same kernel-checked method as G₂/F₄, no block decomposition required (72
roots at a fixed witness elaborates in ~9s). As a sanity check, the corrected list reproduces
*exactly* the power-sum values (S₂=24, S₄=18, S₆=33/2, anomaly RHS=201/25) that the old,
never-successfully-checked docstring had already written down — the original author had the
right target numbers, only the list that was supposed to produce them was mistyped.

**What's needed for E₇** (unchanged, still open):

The direct list enumeration approach times out for E₇'s 126 roots. Must follow `E8Roots.lean`
pattern:

1. **Programmatic root construction**: Define helper functions (like E8's `vroot`, `pairs28`) 
   to build roots rather than enumerating all 126 vectors as list literals
2. **Algebraic identities**: Prove power sum formulas for arbitrary Cartan elements
   using the structure of the root system (block decomposition)
3. **Witness specialization**: Only then evaluate at specific points for violations

**Technical blockers encountered**:
- E₇ root list (64-element half-root list) times out during elaboration even with 600k heartbeats
- List-based `powerSum` definitions don't generate usable equation theorems for rewrites

**Dependencies**:
- E₈ roots already in `E8Roots.lean` (e8_trace_four, e8_trace_six)
- Need: G₂, F₄, E₆, E₇ root systems (encode from proof.md §6.5)

**Lean signatures**:
```lean
def anomalyRHS (S₂ S₄ S₆ : ℚ) : Prop :=
  S₆ = (1/48) * S₄ * S₂ - (1/14400) * S₂^3

-- E₈ satisfies
theorem e8_satisfies_anomaly_identity : 
  ∀ x : Fin 8 → ℚ, 
  anomalyRHS (e8PowerSumTwo x) (e8PowerSumFour x) (e8PowerSumSix x)

-- Witnesses (matches the actual Lean file; g2/f4/e6 done, e7 still open)
def g2Witness : Fin 3 → ℚ := ![1, 0, -1]  -- S₂=48, S₄=360, S₆=3048, RHS=8808/25
def f4Witness : Fin 4 → ℚ := ![1,0,0,0]   -- S₂=18, S₄=15, S₆=57/4, RHS=261/50
def e6Witness : Fin 8 → ℚ := ![1,0,0,0,0,0,0,0]  -- S₂=24, S₄=18, S₆=33/2, RHS=201/25
def e7Witness : Fin 7 → ℚ := ![1,0,0,0,0,0,0]  -- not yet implemented

-- Exclusions
theorem g2_violates_anomaly : 
  ∃ x, ¬ anomalyRHS (g2PowerSumTwo x) (g2PowerSumFour x) (g2PowerSumSix x)
-- Similar for F₄, E₆, E₇
```

**Mathlib status** (checked 2026-09-17):
- ❌ No root systems
- ✅ Rational arithmetic (`Data.Rat`, `BigOperators`)
- ✅ Finset sums, power operations

**Estimated**: ~400 lines (roots ~200, power sums ~150, theorems ~50)

**Risk**: Low. Finite rational arithmetic. E8Roots.lean is the template.

**Value**: High. This proves the **actual numbers** (1/100, 1/7200) that
distinguish E₈. It's the computational heart.

---

### PR1: Classical Families (A_n, B_n, C_n, D_n)

**Goal**: Closed-form power sums; exclude all except so(32).

**File**: `StringFormal/Math/ClassicalAnomalyExclusion.lean`

**Lean signatures**:
```lean
-- D_n power sums (proof.md §6.2)
def so2nPowerSumTwo (n : ℕ) (p₂ : ℚ) : ℚ := 4 * (n - 1) * p₂
def so2nPowerSumFour (n : ℕ) (p₂ p₄ : ℚ) : ℚ := 4 * (n - 4) * p₄ + 12 * p₂^2
def so2nPowerSumSix (n : ℕ) (p₂ p₄ p₆ : ℚ) : ℚ := 4 * (n - 16) * p₆ + 60 * p₂ * p₄

-- Uniqueness
theorem so32_unique_satisfies_anomaly :
  ∀ n ≥ 4, (∀ p₂ p₄ p₆, algebraIndependent [p₂,p₄,p₆] →
    anomalyRHS (so2nPowerSumTwo n p₂) (so2nPowerSumFour n p₂ p₄) 
               (so2nPowerSumSix n p₂ p₄ p₆)) → n = 16
```

**Dependencies**: None beyond basic algebra.

**Estimated**: ~300 lines

**Risk**: Low. Closed-form polynomials + algebra.

**Value**: Medium. Completes classical part.

---

### PR2: Abelian Invisibility (Lemma 1)

**Goal**: Formalize proof.md §2: center contributes zero to adjoint traces.

**File**: Add to `MathlibBridges.lean` or new `LieAlgebraDecomposition.lean`

**Lean signatures**:
```lean
theorem adjoint_of_center_eq_zero {L : Type*} [LieRing L] 
  {c : L} (hc : c ∈ LieAlgebra.center ℚ L) : ⁅c, ·⁆ = 0

theorem trace_adjoint_ignores_abelian_summand
  -- State: Tr_{𝔤}(ad F)^k = Tr_{𝔤'}(ad F')^k when F = F' + F_u with F_u central
```

**Dependencies**: Mathlib has `LieAlgebra.center`, lacks direct sum structure.

**Estimated**: ~100 lines

**Risk**: Medium. Mathlib's Lie library is sparse.

**Value**: Medium. Structural simplification, not computational.

---

### PR3: Cross-Term Bound (Lemma 3)

**Goal**: Formalize proof.md §3-4: at most two simple factors.

**File**: `StringFormal/Math/AnomalyCrossTerms.lean`

**Approach**: Work in Sym⁶(𝔤*), extract multidegree (2,2,2) component.

**Estimated**: ~200 lines

**Risk**: High. Requires symmetric algebra machinery.

**Value**: Medium. Structural but abstract.

---

### PR4: Assembly

**Goal**: Combine all pieces.

**Lean signature**:
```lean
theorem d10_anomaly_classification_conditional
  -- Assume: Killing-Cartan gives 66 algebras
  -- Assume: Chevalley restriction
  (𝔤 : Type*) [CompactLieAlgebra ℚ 𝔤]
  (hdim : finrank ℚ 𝔤 = 496)
  (h_anomaly : ∀ F, Tr (ad F)^6 = (1/48) * Tr (ad F)^4 * Tr (ad F)^2 
                                 - (1/14400) * (Tr (ad F)^2)^3) :
  𝔤 ≅ so(32) ∨ 𝔤 ≅ e₈⊕e₈ ∨ 𝔤 ≅ e₈⊕u(1)²⁴⁸ ∨ 𝔤 ≅ u(1)⁴⁹⁶
```

**Estimated**: ~100 lines (bookkeeping)

**Risk**: Low given pieces.

**Value**: High (final theorem), but needs black-box assumptions.

---

## Out of Scope

1. **Killing-Cartan classification**: Not in Mathlib. Accept as axiom.
2. **Chevalley restriction**: Not in Mathlib. For PR0, we compute on explicit
   Cartan points; the restriction step is left to graph gaps.
3. **All 66 root systems**: Too much data. PR0 does 5 exceptionals. PR1 uses
   parameterized closed forms for classical families.
4. **Converse**: Already in `GreenSchwarzAlgebra.lean`.

---

## Mathlib Gaps

1. No `GroupTheory.RootSystem` module
2. Sparse Lie algebra: no `IsSimple`, `IsSemisimple`, no direct sum structure
3. No Chevalley restriction theorem

---

## Current Status

**Active**: PR0 (G₂, F₄, E₆ closed 2026-09-18; E₇ still open)

**Target file**: `formal/StringFormal/Math/ExceptionalAnomalyExclusion.lean`

**Approach for PR0**:
1. Encode G₂, F₄, E₆, E₇ root lists (from proof.md scripts/Bourbaki coords) — done for
   G₂/F₄/E₆, still needed for E₇
2. Compute power sums P₂, P₄, P₆ (same method as E8Roots.lean)
3. Evaluate anomaly RHS at witness point for each
4. Prove violations (exact rational arithmetic, `norm_num`)
5. For E₈, prove satisfaction (use existing e8_trace_four, e8_trace_six)

**Estimated time**: ~6 hours Lean writing

---

## Final Deliverable

A **conditional theorem** verified in Lean:

The four solutions to (i)∧(ii) are exactly so(32), e₈⊕e₈, e₈⊕u(1)²⁴⁸, u(1)⁴⁹⁶,
conditional on Killing-Cartan classification and Chevalley restriction.

**Value**: Paper proof computes ~200k rational numbers. One typo invalidates the
classification. Lean verifies the arithmetic.
