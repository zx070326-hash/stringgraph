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

### PR0: Exceptional Algebra Exclusion ★ IN PROGRESS

**Goal**: Prove G₂, F₄, E₆, E₇ violate condition (i); E₈ satisfies it.

**File**: `StringFormal/Math/ExceptionalAnomalyExclusion.lean`

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

-- Witnesses from proof.md table
def g2Witness : Fin 2 → ℚ := ![1, -1]  -- S₂=48, S₆=3048, RHS=352.32
def f4Witness : Fin 4 → ℚ := ![1,0,0,0] -- S₆=14.25, RHS=5.22
def e6Witness : Fin 6 → ℚ := ![1,0,0,0,0,0]
def e7Witness : Fin 7 → ℚ := ![1,0,0,0,0,0,0]

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

**Active**: PR0 (this session)

**Target file**: `formal/StringFormal/Math/ExceptionalAnomalyExclusion.lean`

**Approach for PR0**:
1. Encode G₂, F₄, E₆, E₇ root lists (from proof.md scripts/Bourbaki coords)
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
