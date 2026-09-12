/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.SpuriousElimination
import StringFormal.NoGhost.NullSeedsTwo
import StringFormal.Virasoro.VermaPBW

/-!
# The Type-1 family: a `D`-independent lower bound on the null states (blueprint §B‴ PR6′)

Graph nodes: `worldsheet.ddf-spanning-hypothesis` (the consumer, through
`NoGhost/SliceRank.lean`'s `B26`), `worldsheet.gt-longitudinal-k-algebra` (the `K`-algebra
input).  Blueprint `formal/BLUEPRINT-noghost.md` §B‴.9 (PR6′) and §B‴.12.

**`D = 26` occurs nowhere in this file.**  The intercept `a₀ = 1` (`k·k = 2`) enters only in
the last theorem, through the Type-1 null lemma of `NoGhost/NullSeedsTwo.lean`.

## Main results

* `towerLop_neg_one_injective` — **`L_{-1}` is injective on every bigraded piece `(j, M)`**.
  Only the `K`-algebra is used: `⁅L_{-1}, K_1⁆ = -K_0 = -1` gives
  `L_{-1} K_1^{k+1} x = -(k+1) K_1^k x` for `L_{-1} x = 0`, and `K_1^{M+1} x = 0` on level `M`
  forces `x = 0` by descent.  Needs only a `ℚ`-algebra (no `CharZero` hypothesis).
* `straighten` / `apply_mem_ordSpanOn_of_mem` — **straightening for an arbitrary family**
  `L : ℤ → Module.End R W` satisfying the negative-mode Witt relations (`IsNegWitt`), applied
  to an arbitrary vector: `Virasoro/VermaPBW.lean`'s induction, freed from the Verma module.
  `isNegWitt_towerLop` instantiates it on the tower.
* `towerBigrade_le_ordSeedSpan` — **(F-1), spanning half** (blueprint §B″.4.1): every bigraded
  piece `(j, M)` is spanned by `L_{-λ} m(c)`, `λ` an ordered partition, `c` `b̃`-free,
  `|λ| + level c = M`.  Nested induction: strong induction on `M`, inside it the measure
  induction of PR4's elimination, with the spurious term kept instead of discarded.
* `seedIndexPosEmbed_injective` / `finrank_ordSeedSpanPos_le` — **(F-2), injective half**:
  `(λ, c) ↦ c + wordOcc λ` is injective into `{d | level d = M, β(d) ≥ 1}`, so the non-empty
  part of the family has dimension `≤ p_D(M) − p_{D−1}(M)`.
* `finrank_towerBigrade` — `dim V_{j,M} = #{d | level d = M}` (Mathlib `basisRestrictSupport`).
* `towerSeed` / **`le_finrank_towerSeed`** — the seed space
  `Q_{j,M} = towerPositiveModeSubmodule ⊓ towerBigrade j M` has `dim ≥ p_{D−1}(M)`, on every
  rung and level.  Rank–nullity for `V_{j,M} → (non-empty seed family)^*`, whose kernel
  consists of seeds; **no nondegeneracy of the form on the slice is used** for this direction.
  With `SpuriousElimination.finrank_towerPositiveMode_inf_towerBigrade_le` this is an equality
  `dim Q_{j,M} = p_{D−1}(M)` — blueprint §B″.4.1's (F-4) second line, without a basis.
* **`le_finrank_towerNull_inf_towerBigrade_succ`** — the **`D`-independent null lower bound**
  `dim (H_null ⊓ V_{N+1}) ≥ p_{D−1}(N)` for **every** `N`: `L_{-1}` embeds `Q_{-(N+1),N}` into
  the null states of the antidiagonal slice (`typeOneMap`).  `le_finrank_towerNull_inf_towerBigrade`
  is the blueprint's `N - 1` phrasing (for `1 ≤ N`).

## Deviations from blueprint §B‴.9 (also appended to the blueprint's "§B‴ 订正")

1. **`le_finrank_towerNull_inf_towerBigrade` as drafted is false at `N = 0`**: the draft reads
   `p_{D−1}(N−1) ≤ dim (H_null ⊓ V_N)` with natural-number subtraction, so at `N = 0` it claims
   `1 ≤ dim (H_null ⊓ V_0)`, but `|0;0⟩` is physical and not null.  Stated at `N + 1`
   (`_succ`), with the `N − 1` form under `1 ≤ N`.
2. **`towerLop_neg_one_injective` needs no `CharZero`**: in a `ℚ`-algebra `k • y = 0 ⇒ y = 0`
   for `k ≠ 0` (`eq_zero_of_natCast_smul_eq_zero`), so the descent runs over `[Algebra ℚ R]`.
3. **The (F-1)+(F-2) lower bound does not need "`S_M = S ⊓ V_M`" or projections of spurious
   states.**  The dual map is taken against the non-empty seed family `ordSeedSpanPos` directly
   (not against `towerSpuriousSubmodule ⊓ V_M`); its kernel lies in `Q_{j,M}` because
   `⟨L_n x, y⟩ = ⟨x, L_{-n} y_{(j,M-n)}⟩` and `L_{-n} V_{j,M-n} ⊆ ordSeedSpanPos` by (F-1) plus
   straightening.  So `towerBigradeProj_mem_towerSpuriousSubmodule` was never needed.
4. **Straightening had to be re-proved.**  `VermaPBW.straighten` is stated on `V(c,h)` acting on
   the highest-weight vector; (F-1) needs it on `TowerFock` acting on `m(c)`.  Rather than
   transporting, the induction is redone once for an arbitrary `IsNegWitt` family (≈ 110 lines,
   verbatim structure).  The blueprint's "(F-1) 不需要抽象 PBW" is right, but it does need the
   PBW *spanning* induction, which is exactly `straighten`.
5. **(F-2) only in the injective direction**, as the lower bound needs
   (`nat_card_seedIndexPos_le`); the bijection of §B″.4.1 (c1) is not built.  Sorted lists are
   recovered from multiplicities via `List.Perm.eq_of_pairwise'` + `List.perm_iff_count`.
6. **Line count** ≈ 940 against the estimate 700–850 (the seed-index bookkeeping and the
   dimension lemmas `finrank_towerBigrade` / `nat_card_level_split` were not itemised).

## Scope and gaps

* This bound is the **`D ≠ 26` answer** (blueprint §B‴.8): the missing
  `p_{D−1}(N+1) − p_{D−2}(N+1) − p_{D−1}(N)` null states are the Type-2 family and, from
  `N + 1 ≥ 12`, further singular-vector families — all `D = 26`-dependent, none here.  So
  `B26 N` is **not** closed for `N ≥ 3`; see the TODO `noghost-pr6` and blueprint §B‴.9's
  "(B-26) 剩余部分".
* `ordSeedSpan` is only known to *contain* `V_{j,M}`; linear independence of the family
  (the PBW basis, (F-3)) is not proved, and `conjFree ⊓ spurious = ⊥` remains open.
-/

namespace StringFormal.NoGhost

open MvPolynomial

/-! ### A `ℚ`-algebra has no `ℕ`-torsion in its modules -/

section RatTorsion

/-- Over a `ℚ`-algebra, `k • y = 0` with `k ≠ 0` a natural number forces `y = 0`. -/
lemma eq_zero_of_natCast_smul_eq_zero {R : Type*} [CommRing R] [Algebra ℚ R] {W : Type*}
    [AddCommGroup W] [Module R W] {k : ℕ} (hk : k ≠ 0) {y : W} (h : (k : R) • y = 0) :
    y = 0 := by
  have hunit : algebraMap ℚ R ((k : ℚ)⁻¹) * (k : R) = 1 := by
    rw [← map_natCast (algebraMap ℚ R) k, ← map_mul,
      inv_mul_cancel₀ (by exact_mod_cast hk), map_one]
  calc y = (algebraMap ℚ R ((k : ℚ)⁻¹) * (k : R)) • y := by rw [hunit, one_smul]
    _ = algebraMap ℚ R ((k : ℚ)⁻¹) • ((k : R) • y) := mul_smul _ _ _
    _ = 0 := by rw [h, smul_zero]

end RatTorsion

/-! ### `K_1` is homogeneous for the bigrading -/

section ModeVecBigrade

variable {D : ℕ} {R : Type*} [CommRing R]

/-- **A polarised mode has bidegree `(0, -m)`**: `α^w_m` preserves the rung and lowers the
oscillator level by `m`.  (Compare `Glue.towerLop_mem_towerBigrade` for `L_m`.) -/
theorem towerModeVec_mem_towerBigrade (η a b w : Fin D → R) {j : ℤ} {N : ℕ}
    {x : TowerFock D R} (hx : x ∈ towerBigrade D R j N) {m : ℤ} {N' : ℕ}
    (hN' : (N' : ℤ) = (N : ℤ) - m) :
    towerModeVec η a b w m x ∈ towerBigrade D R j N' := by
  obtain ⟨hx1, hx2⟩ := mem_towerBigrade.1 hx
  rw [hx1, towerModeVec, LinearMap.sum_apply]
  refine Submodule.sum_mem _ fun μ _ => ?_
  rw [LinearMap.smul_apply, towerMode_single]
  exact Submodule.smul_mem _ _
    (single_mem_towerBigrade (Fock.mode_mem_levelSubmodule η _ hx2 hN' μ))

/-- A polarised mode of index above the level kills the slice. -/
theorem towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt (η a b w : Fin D → R) {j : ℤ}
    {N : ℕ} {x : TowerFock D R} (hx : x ∈ towerBigrade D R j N) {m : ℤ} (hm : (N : ℤ) < m) :
    towerModeVec η a b w m x = 0 := by
  obtain ⟨hx1, hx2⟩ := mem_towerBigrade.1 hx
  rw [hx1, towerModeVec, LinearMap.sum_apply]
  refine Finset.sum_eq_zero fun μ _ => ?_
  rw [LinearMap.smul_apply, towerMode_single, Fock.mode_apply_eq_zero_of_level_lt η _ hx2 hm μ,
    Finsupp.single_zero, smul_zero]

end ModeVecBigrade

/-! ### `L_{-1}` is injective on each bigraded piece -/

section LopNegOneInjective

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] (η a b : Fin D → R)
variable (hη : ∀ μ, η μ * η μ = 1) (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1)

include hη hbb hba in
/-- `L_{-1} K_1 v = K_1 L_{-1} v - v`: the `K`-algebra relation `⁅L_{-1}, K_1⁆ = -K_0` with
`K_0 = 1` (blueprint §B‴.9, the "three lines"). -/
lemma towerLop_neg_one_apply_kOp_one (v : TowerFock D R) :
    towerLop η a b (-1) (kOp η a b 1 v) = kOp η a b 1 (towerLop η a b (-1) v) - v := by
  have h := congrArg (fun T : Module.End R (TowerFock D R) => T v)
    (lie_towerLop_kOp η a b hη (-1) 1)
  simp only [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
    LinearMap.smul_apply] at h
  rw [show (-1 : ℤ) + 1 = 0 by norm_num, kOp_zero_eq_one η a b hbb hba,
    Module.End.one_apply, Int.cast_one, neg_smul, one_smul] at h
  rw [sub_eq_iff_eq_add] at h
  rw [h, sub_eq_add_neg, add_comm]

include hη hbb hba in
/-- `L_{-1} K_1^{k+1} x = -(k+1) • K_1^k x` whenever `L_{-1} x = 0`. -/
lemma towerLop_neg_one_apply_kOp_one_pow {x : TowerFock D R}
    (hx : towerLop η a b (-1) x = 0) (k : ℕ) :
    towerLop η a b (-1) ((kOp η a b 1 ^ (k + 1)) x)
      = (-((k + 1 : ℕ) : R)) • (kOp η a b 1 ^ k) x := by
  induction k with
  | zero =>
      rw [pow_one, pow_zero, Module.End.one_apply, towerLop_neg_one_apply_kOp_one η a b hη hbb hba,
        hx, map_zero, zero_sub]
      simp
  | succ k ih =>
      rw [pow_succ', Module.End.mul_apply, towerLop_neg_one_apply_kOp_one η a b hη hbb hba, ih,
        map_smul, pow_succ' (kOp η a b 1) k, Module.End.mul_apply, sub_eq_add_neg,
        ← neg_one_smul R (kOp η a b 1 ((kOp η a b 1 ^ k) x)), ← add_smul]
      congr 1
      push_cast
      ring

include hη hbb hba in
/-- **`L_{-1}` is injective on every bigraded piece** (blueprint §B‴.9's
`towerLop_neg_one_injective`).

With `x_k := K_1^k x` the previous lemma gives `L_{-1} x_{k+1} = -(k+1) x_k`; since `K_1`
lowers the level by one, `x_{M+1} = 0` on the piece `(j, M)`, and descending through
`x_M, x_{M-1}, …, x_0 = x` (each step dividing by a non-zero natural number, possible in a
`ℚ`-algebra) gives `x = 0`.  `D` does not appear, nor does the intercept. -/
theorem towerLop_neg_one_injective {j : ℤ} {M : ℕ} {x : TowerFock D R}
    (hx : x ∈ towerBigrade D R j M) (h : towerLop η a b (-1) x = 0) : x = 0 := by
  have hmem : ∀ k, k ≤ M → (kOp η a b 1 ^ k) x ∈ towerBigrade D R j (M - k) := by
    intro k
    induction k with
    | zero => intro _; simpa using hx
    | succ k ih =>
        intro hk
        rw [pow_succ', Module.End.mul_apply, kOp_eq_towerModeVec]
        exact towerModeVec_mem_towerBigrade η a b b (ih (by omega)) (by omega)
  have htop : (kOp η a b 1 ^ (M + 1)) x = 0 := by
    rw [pow_succ', Module.End.mul_apply, kOp_eq_towerModeVec]
    exact towerModeVec_apply_eq_zero_of_mem_towerBigrade_of_lt η a b b (hmem M le_rfl)
      (by simp)
  have hdesc : ∀ i, i ≤ M + 1 → (kOp η a b 1 ^ (M + 1 - i)) x = 0 := by
    intro i
    induction i with
    | zero => intro _; simpa using htop
    | succ i ih =>
        intro hi
        have h1 := ih (by omega)
        rw [show M + 1 - i = (M - i) + 1 by omega] at h1
        have h2 := towerLop_neg_one_apply_kOp_one_pow η a b hη hbb hba h (M - i)
        rw [h1, map_zero, neg_smul, eq_comm, neg_eq_zero] at h2
        rw [show M + 1 - (i + 1) = M - i by omega]
        exact eq_zero_of_natCast_smul_eq_zero (Nat.succ_ne_zero _) h2
  have := hdesc (M + 1) le_rfl
  rwa [Nat.sub_self, pow_zero, Module.End.one_apply] at this

end LopNegOneInjective

/-! ### Straightening for an arbitrary family of endomorphisms

`Virasoro/VermaPBW.lean` proves that ordered words in the negative modes span the Verma module,
but its `straighten` is stated for words acting on the highest-weight vector of `V(c,h)`.
Here the same induction is run for a family `L : ℤ → Module.End R W` on an arbitrary module,
applied to an arbitrary vector, assuming only the Witt relations among the negative modes
(`IsNegWitt`).  The measure `wordMeasure` and the predicate `IsOrdWord` are reused verbatim. -/

section Straightening

open StringFormal.Virasoro

variable {R : Type*} [CommRing R] {W : Type*} [AddCommGroup W] [Module R W]

/-- The word `L_{n_1} ⋯ L_{n_k}` of a family of endomorphisms, applied to a vector. -/
def wordApply (L : ℤ → Module.End R W) : List ℤ → W → W
  | [], v => v
  | n :: t, v => L n (wordApply L t v)

@[simp] lemma wordApply_nil (L : ℤ → Module.End R W) (v : W) : wordApply L [] v = v := rfl

@[simp] lemma wordApply_cons (L : ℤ → Module.End R W) (n : ℤ) (t : List ℤ) (v : W) :
    wordApply L (n :: t) v = L n (wordApply L t v) := rfl

/-- The ordered words of total mode `s` and measure at most `M`, applied to `v`. -/
def ordWordSetLeOn (L : ℤ → Module.End R W) (v : W) (s : ℤ) (M : ℕ) : Set W :=
  {x | ∃ l : List ℤ, IsOrdWord l ∧ l.sum = s ∧ wordMeasure l ≤ M ∧ x = wordApply L l v}

/-- The span of the ordered words of total mode `s` and measure at most `M`, applied to `v`. -/
noncomputable def ordSpanLeOn (L : ℤ → Module.End R W) (v : W) (s : ℤ) (M : ℕ) :
    Submodule R W :=
  Submodule.span R (ordWordSetLeOn L v s M)

/-- The ordered words of total mode `s`, applied to `v`. -/
def ordWordSetOn (L : ℤ → Module.End R W) (v : W) (s : ℤ) : Set W :=
  {x | ∃ l : List ℤ, IsOrdWord l ∧ l.sum = s ∧ x = wordApply L l v}

/-- The span of the ordered words of total mode `s`, applied to `v`. -/
noncomputable def ordSpanOn (L : ℤ → Module.End R W) (v : W) (s : ℤ) : Submodule R W :=
  Submodule.span R (ordWordSetOn L v s)

lemma ordSpanLeOn_mono (L : ℤ → Module.End R W) (v : W) {s : ℤ} {M M' : ℕ} (hM : M ≤ M') :
    ordSpanLeOn L v s M ≤ ordSpanLeOn L v s M' := by
  refine Submodule.span_mono ?_
  rintro x ⟨l, hl, hs, hm, rfl⟩
  exact ⟨l, hl, hs, hm.trans hM, rfl⟩

lemma ordSpanLeOn_le_ordSpanOn (L : ℤ → Module.End R W) (v : W) (s : ℤ) (M : ℕ) :
    ordSpanLeOn L v s M ≤ ordSpanOn L v s := by
  refine Submodule.span_mono ?_
  rintro x ⟨l, hl, hs, _, rfl⟩
  exact ⟨l, hl, hs, rfl⟩

lemma mem_ordSpanLeOn (L : ℤ → Module.End R W) (v : W) {l : List ℤ} (hl : IsOrdWord l)
    {s : ℤ} (hs : l.sum = s) {M : ℕ} (hm : wordMeasure l ≤ M) :
    wordApply L l v ∈ ordSpanLeOn L v s M :=
  Submodule.subset_span ⟨l, hl, hs, hm, rfl⟩

lemma mem_ordSpanOn (L : ℤ → Module.End R W) (v : W) {l : List ℤ} (hl : IsOrdWord l)
    {s : ℤ} (hs : l.sum = s) : wordApply L l v ∈ ordSpanOn L v s :=
  Submodule.subset_span ⟨l, hl, hs, rfl⟩

/-- **The straightening hypothesis**: the negative modes of `L` satisfy the Witt relations
`L_m L_n = L_n L_m + (m - n) L_{m+n}` (no central term can appear for `m, n < 0`). -/
def IsNegWitt (L : ℤ → Module.End R W) : Prop :=
  ∀ m n : ℤ, m < 0 → n < 0 → ∀ v : W, L m (L n v) = L n (L m v) + ((m : R) - n) • L (m + n) v

variable {L : ℤ → Module.End R W}

/-- **Straightening, the key lemma** (the module-and-vector version of
`Virasoro.straighten_aux`): applying a negative mode to an ordered word applied to `v` lands
in the span of ordered words of the same total mode and measure at most that of the input. -/
theorem straighten_aux (hL : IsNegWitt L) (v : W) (k : ℕ) :
    ∀ a : ℤ, a < 0 → ∀ l : List ℤ, IsOrdWord l → wordMeasure (a :: l) ≤ k →
      L a (wordApply L l v) ∈ ordSpanLeOn L v (a + l.sum) (wordMeasure (a :: l)) := by
  induction k with
  | zero =>
    intro a ha l hl hk
    have hnegl : ∀ n ∈ l, n < 0 := hl.neg
    have hcast := wordMeasure_cast (IsOrdWord.cons_neg ha hl)
    have hwl := wordWeight_nonpos hnegl
    have hsl := sum_nonpos_of_neg hnegl
    have hzero : l.sum = 0 := by
      rw [wordWeight_cons] at hcast
      omega
    have hnil : l = [] := eq_nil_of_sum_eq_zero hnegl hzero
    subst hnil
    exact mem_ordSpanLeOn L v (IsOrdWord.cons ha isOrdWord_nil (by simp)) (by simp) le_rfl
  | succ k ih =>
    intro a ha l hl hk
    match l with
    | [] =>
      exact mem_ordSpanLeOn L v (IsOrdWord.cons ha isOrdWord_nil (by simp)) (by simp) le_rfl
    | b :: t =>
      have hb : b < 0 := hl.head_neg
      have ht : IsOrdWord t := hl.tail
      have hnegt : ∀ n ∈ t, n < 0 := ht.neg
      have hst : t.sum ≤ 0 := sum_nonpos_of_neg hnegt
      have hwt : wordWeight t ≤ 0 := wordWeight_nonpos hnegt
      have habt : ((wordMeasure (a :: b :: t) : ℤ))
          = -(wordWeight t + t.sum + (b + t.sum)) := by
        rw [wordMeasure_cast (IsOrdWord.cons_neg ha hl)]
        simp only [wordWeight_cons, List.sum_cons]
      by_cases hab : a ≤ b
      · have hord : IsOrdWord (a :: b :: t) := IsOrdWord.cons_head ha hl hab
        exact mem_ordSpanLeOn L v hord (by simp only [List.sum_cons]) le_rfl
      · have hba : b < a := lt_of_not_ge hab
        have hat : ((wordMeasure (a :: t) : ℤ)) = -(wordWeight t + t.sum) := by
          rw [wordMeasure_cast (IsOrdWord.cons_neg ha ht), wordWeight_cons]
        have hsum' : ((wordMeasure ((a + b) :: t) : ℤ)) = -(wordWeight t + t.sum) := by
          rw [wordMeasure_cast (IsOrdWord.cons_neg (by omega) ht), wordWeight_cons]
        have key : ∀ y ∈ ordSpanLeOn L v (a + t.sum) (wordMeasure (a :: t)),
            L b y ∈ ordSpanLeOn L v (a + (b :: t).sum) (wordMeasure (a :: b :: t)) := by
          intro y hy
          rw [ordSpanLeOn] at hy
          induction hy using Submodule.span_induction with
          | mem z hz =>
            obtain ⟨l', hl', hsl', hml', rfl⟩ := hz
            have hnegl' : ∀ n ∈ l', n < 0 := hl'.neg
            have hbl' : ((wordMeasure (b :: l') : ℤ)) = -(wordWeight l' + l'.sum) := by
              rw [wordMeasure_cast (IsOrdWord.cons_neg hb hl'), wordWeight_cons]
            have hl'cast : ((wordMeasure l' : ℤ)) = -wordWeight l' :=
              wordMeasure_cast hnegl'
            have hm3 : wordMeasure (b :: l') ≤ k := by omega
            have h3 := ih b hb l' hl' hm3
            rw [hsl'] at h3
            have hsum3 : b + (a + t.sum) = a + (b :: t).sum := by
              simp only [List.sum_cons]; ring
            rw [hsum3] at h3
            exact ordSpanLeOn_mono L v (by omega) h3
          | zero => rw [map_zero]; exact Submodule.zero_mem _
          | add y z _ _ hy hz => rw [map_add]; exact Submodule.add_mem _ hy hz
          | smul r y _ hy => rw [map_smul]; exact Submodule.smul_mem _ _ hy
        rw [wordApply_cons, hL a b ha hb]
        refine Submodule.add_mem _ ?_ ?_
        · have hm2 : wordMeasure (a :: t) ≤ k := by omega
          exact key _ (ih a ha t ht hm2)
        · have hm1 : wordMeasure ((a + b) :: t) ≤ k := by omega
          have h1 := ih (a + b) (by omega) t ht hm1
          have hsum1 : a + b + t.sum = a + (b :: t).sum := by
            simp only [List.sum_cons]; ring
          rw [hsum1] at h1
          exact Submodule.smul_mem _ _ (ordSpanLeOn_mono L v (by omega) h1)

/-- **Straightening**: applying a negative mode to an ordered word lands in the span of the
ordered words of the same total mode. -/
theorem straighten (hL : IsNegWitt L) (v : W) {a : ℤ} (ha : a < 0) {l : List ℤ}
    (hl : IsOrdWord l) :
    L a (wordApply L l v) ∈ ordSpanLeOn L v (a + l.sum) (wordMeasure (a :: l)) :=
  straighten_aux hL v (wordMeasure (a :: l)) a ha l hl le_rfl

/-- A negative mode maps the ordered-word span of total mode `s` into the one of total mode
`a + s`. -/
theorem apply_mem_ordSpanOn_of_mem (hL : IsNegWitt L) (v : W) {a : ℤ} (ha : a < 0) {s : ℤ}
    {y : W} (hy : y ∈ ordSpanOn L v s) : L a y ∈ ordSpanOn L v (a + s) := by
  rw [ordSpanOn] at hy
  induction hy using Submodule.span_induction with
  | mem z hz =>
    obtain ⟨l, hl, rfl, rfl⟩ := hz
    exact ordSpanLeOn_le_ordSpanOn L v _ _ (straighten hL v ha hl)
  | zero => rw [map_zero]; exact Submodule.zero_mem _
  | add y z _ _ hy hz => rw [map_add]; exact Submodule.add_mem _ hy hz
  | smul r y _ hy => rw [map_smul]; exact Submodule.smul_mem _ _ hy

end Straightening

/-! ### The tower Virasoro operators satisfy the straightening hypothesis -/

section TowerNegWitt

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

/-- The negative modes of `towerLop` satisfy the Witt relations: `TowerVirasoro.lean`'s
`towerLop_apply_towerLop_of_ne_zero` with `m + n < 0`. -/
theorem isNegWitt_towerLop (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) :
    IsNegWitt (towerLop η a b) := fun m n hm hn v =>
  towerLop_apply_towerLop_of_ne_zero η a b hη (by omega) v

end TowerNegWitt

/-! ### Ordered Virasoro words on `b̃`-free seeds (blueprint §B″.4.1 (F-1)) -/

section SeedFamily

open StringFormal.Virasoro

variable {D : ℕ}

/-- **The index set of (F-1)**: pairs `(l, c)` with `l` an ordered word in the negative modes,
`c` a `b̃`-free light-cone occupation function, and total level `level c − l.sum = M`. -/
def SeedIndex (hD : 2 ≤ D) (M : ℕ) : Type :=
  {lc : List ℤ × (Osc D →₀ ℕ) //
    IsOrdWord lc.1 ∧ conjDeg hD lc.2 = 0 ∧ (Fock.level D lc.2 : ℤ) - lc.1.sum = M}

/-- The index set of (F-1) restricted to **non-empty** words: these are the ones that index
the spurious part (blueprint §B″.4.1's "`λ ≠ ∅` half"). -/
def SeedIndexPos (hD : 2 ≤ D) (M : ℕ) : Type :=
  {lc : List ℤ × (Osc D →₀ ℕ) //
    IsOrdWord lc.1 ∧ lc.1 ≠ [] ∧ conjDeg hD lc.2 = 0 ∧ (Fock.level D lc.2 : ℤ) - lc.1.sum = M}

variable {R : Type*} [CommRing R] [Algebra ℚ R] {η a b : Fin D → R}

/-- The vector `L_{-λ} · m(c)` on rung `j` indexed by `(l, c)`. -/
noncomputable def seedWord (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (j : ℤ) (M : ℕ)
    (p : SeedIndex hD M) : TowerFock D R :=
  wordApply (towerLop η a b) p.1.1 (Finsupp.single j (lcMonomial F p.1.2))

/-- The same, for non-empty words. -/
noncomputable def seedWordPos (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (j : ℤ) (M : ℕ)
    (p : SeedIndexPos hD M) : TowerFock D R :=
  wordApply (towerLop η a b) p.1.1 (Finsupp.single j (lcMonomial F p.1.2))

/-- **(F-1)'s spanning family**: the span of `L_{-λ} m(c)` over ordered `λ` and `b̃`-free `c`
with `|λ| + level c = M`, on rung `j`. -/
noncomputable def ordSeedSpan (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (j : ℤ) (M : ℕ) :
    Submodule R (TowerFock D R) :=
  Submodule.span R (Set.range (seedWord hD F j M))

/-- The part of `ordSeedSpan` with `λ ≠ ∅`. -/
noncomputable def ordSeedSpanPos (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (j : ℤ) (M : ℕ) :
    Submodule R (TowerFock D R) :=
  Submodule.span R (Set.range (seedWordPos hD F j M))

lemma wordApply_mem_ordSeedSpan (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (j : ℤ) {M : ℕ}
    {l : List ℤ} (hl : IsOrdWord l) {c : Osc D →₀ ℕ} (hc : conjDeg hD c = 0)
    (hlev : (Fock.level D c : ℤ) - l.sum = M) :
    wordApply (towerLop η a b) l (Finsupp.single j (lcMonomial F c)) ∈ ordSeedSpan hD F j M :=
  Submodule.subset_span ⟨⟨(l, c), hl, hc, hlev⟩, rfl⟩

lemma wordApply_mem_ordSeedSpanPos (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (j : ℤ) {M : ℕ}
    {l : List ℤ} (hl : IsOrdWord l) (hne : l ≠ []) {c : Osc D →₀ ℕ} (hc : conjDeg hD c = 0)
    (hlev : (Fock.level D c : ℤ) - l.sum = M) :
    wordApply (towerLop η a b) l (Finsupp.single j (lcMonomial F c))
      ∈ ordSeedSpanPos hD F j M :=
  Submodule.subset_span ⟨⟨(l, c), hl, hne, hc, hlev⟩, rfl⟩

lemma ordSeedSpanPos_le_ordSeedSpan (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (j : ℤ)
    (M : ℕ) : ordSeedSpanPos (R := R) hD F j M ≤ ordSeedSpan hD F j M := by
  refine Submodule.span_le.2 ?_
  rintro _ ⟨⟨⟨l, c⟩, hl, _, hc, hlev⟩, rfl⟩
  exact wordApply_mem_ordSeedSpan hD F j hl hc hlev

/-- **`L_{-n}` maps the seed family of level `M'` into the non-empty seed family of level
`M' + n`** — this is where straightening is used.  An ordered word of total mode
`-n + l.sum < 0` is automatically non-empty. -/
theorem towerLop_neg_mem_ordSeedSpanPos (hD : 2 ≤ D) (F : DDFLightConeFrame η a b)
    (hη : ∀ μ, η μ * η μ = 1) (j : ℤ) (n : ℕ+) {M' : ℕ} {y : TowerFock D R}
    (hy : y ∈ ordSeedSpan hD F j M') :
    towerLop η a b (-((n : ℕ) : ℤ)) y ∈ ordSeedSpanPos hD F j (M' + n) := by
  rw [ordSeedSpan] at hy
  induction hy using Submodule.span_induction with
  | mem z hz =>
    obtain ⟨⟨⟨l, c⟩, hl, hc, hlev⟩, rfl⟩ := hz
    simp only at hl hc hlev
    have hn1 : (0 : ℕ) < (n : ℕ) := n.pos
    have hn : (-((n : ℕ) : ℤ)) < 0 := by omega
    have hmem : towerLop η a b (-((n : ℕ) : ℤ)) (seedWord hD F j M' ⟨(l, c), hl, hc, hlev⟩)
        ∈ ordSpanOn (towerLop η a b) (Finsupp.single j (lcMonomial F c))
          (-((n : ℕ) : ℤ) + l.sum) :=
      apply_mem_ordSpanOn_of_mem (isNegWitt_towerLop η a b hη) _ hn
        (mem_ordSpanOn (towerLop η a b) _ hl rfl)
    rw [ordSpanOn] at hmem
    refine Submodule.span_le.2 ?_ hmem
    rintro _ ⟨l', hl', hsum, rfl⟩
    have hsl := sum_nonpos_of_neg hl.neg
    have hne : l' ≠ [] := by
      intro hnil
      rw [hnil, List.sum_nil] at hsum
      omega
    exact wordApply_mem_ordSeedSpanPos hD F j hl' hne hc (by rw [hsum]; push_cast; omega)
  | zero => rw [map_zero]; exact Submodule.zero_mem _
  | add y z _ _ hy hz => rw [map_add]; exact Submodule.add_mem _ hy hz
  | smul r y _ hy => rw [map_smul]; exact Submodule.smul_mem _ _ hy

/-- **(F-1), the spanning half** (blueprint §B″.4.1): every light-cone monomial of level `M`
on rung `j` is a combination of ordered Virasoro words applied to `b̃`-free monomials.

Outer strong induction on the level `M`, inner induction on the measure
`μ(d) = β(d)(M+1) + ω(d)` exactly as in `single_lcMonomial_mem_conjFreeSlice_sup_towerSpurious`;
the difference is that the spurious term `-L_{-n} m(d₀)` is no longer discarded: `m(d₀)` has
level `M - n < M`, so it lies in the seed family by the outer hypothesis, and `L_{-n}` maps
that family into the level-`M` family by straightening. -/
theorem single_lcMonomial_mem_ordSeedSpan (hD : 2 ≤ D) (F : DDFLightConeFrame η a b)
    (hη : ∀ μ, η μ * η μ = 1) (j : ℤ) (M : ℕ) (d : Osc D →₀ ℕ) (hd : Fock.level D d = M) :
    Finsupp.single j (lcMonomial F d) ∈ ordSeedSpan hD F j M := by
  classical
  induction M using Nat.strong_induction_on generalizing d with
  | _ M ihM =>
  suffices h : ∀ K : ℕ, ∀ e : Osc D →₀ ℕ, Fock.level D e = M → lcMeasure hD M e ≤ K →
      Finsupp.single j (lcMonomial F e) ∈ ordSeedSpan hD F j M from
    h (lcMeasure hD M d) d hd le_rfl
  intro K
  induction K with
  | zero =>
      intro e he hK
      simp only [lcMeasure] at hK
      have hz : conjDeg hD e * (M + 1) = 0 := by omega
      have hc : conjDeg hD e = 0 := by
        rcases Nat.mul_eq_zero.mp hz with h' | h'
        · exact h'
        · omega
      exact wordApply_mem_ordSeedSpan hD F j Virasoro.isOrdWord_nil hc (by simp [he])
  | succ K ih =>
      intro e he hK
      by_cases hc : conjDeg hD e = 0
      · exact wordApply_mem_ordSeedSpan hD F j Virasoro.isOrdWord_nil hc (by simp [he])
      obtain ⟨v, hvmem, hv1⟩ : ∃ v ∈ e.support, v.1 = conjIdx D hD := by
        by_contra hcon
        refine hc ?_
        rw [conjDeg, Finsupp.weight_apply]
        refine Finset.sum_eq_zero fun v hv => ?_
        show (e v) • (if v.1 = conjIdx D hD then (1 : ℕ) else 0) = 0
        rw [if_neg (fun h => hcon ⟨v, hv, h⟩), smul_zero]
      obtain ⟨t, n⟩ := v
      simp only at hv1
      subst hv1
      set e₀ := e - Finsupp.single ((conjIdx D hD, n) : Osc D) 1 with he₀
      have hsplit : e₀ + Finsupp.single ((conjIdx D hD, n) : Osc D) 1 = e := by
        rw [he₀, add_comm]
        exact Fock.single_add_tsub_single (Finsupp.mem_support_iff.mp hvmem)
      have hlev : Fock.level D e₀ + (n : ℕ) = M := by
        rw [← he, ← hsplit, Fock.level_add, Fock.level_single, Fock.oscLevel, one_mul]
      have hmeas : lcMeasure hD M e
          = lcMeasure hD M e₀ + lcMeasure hD M (Finsupp.single ((conjIdx D hD, n) : Osc D) 1) := by
        rw [← hsplit, lcMeasure_add]
      have hZ : Submodule.map (Finsupp.lsingle (M := Fock D R) (R := R) j)
            (lcLow hD F M (lcMeasure hD M
              (e₀ + Finsupp.single ((conjIdx D hD, n) : Osc D) 1)))
          ≤ ordSeedSpan hD F j M := by
        rw [lcLow, Submodule.map_span, Submodule.span_le]
        rintro _ ⟨_, ⟨f, ⟨h1, h2⟩, rfl⟩, rfl⟩
        rw [hsplit] at h2
        exact ih f h1 (by omega)
      have hlead := towerLop_neg_conjDegree_leading hD F hη n j e₀ hlev
      have hAB : Finsupp.single j (lcMonomial F e)
          = (Finsupp.single j
                (lcMonomial F (e₀ + Finsupp.single ((conjIdx D hD, n) : Osc D) 1))
              + towerLop η a b (-((n : ℕ) : ℤ)) (Finsupp.single j (lcMonomial F e₀)))
            - towerLop η a b (-((n : ℕ) : ℤ)) (Finsupp.single j (lcMonomial F e₀)) := by
        rw [hsplit]
        abel
      rw [hAB]
      refine Submodule.sub_mem _ (hZ hlead) ?_
      have hn : (0 : ℕ) < (n : ℕ) := n.pos
      have hseed : Finsupp.single j (lcMonomial F e₀) ∈ ordSeedSpan hD F j (M - n) :=
        ihM (M - n) (by omega) e₀ (by omega)
      have hL := towerLop_neg_mem_ordSeedSpanPos hD F hη j n hseed
      rw [show M - (n : ℕ) + (n : ℕ) = M by omega] at hL
      exact ordSeedSpanPos_le_ordSeedSpan hD F j M hL

/-- **(F-1) as an inclusion of submodules**: the bigraded piece `(j, M)` is spanned by the
ordered Virasoro words on `b̃`-free light-cone monomials. -/
theorem towerBigrade_le_ordSeedSpan (hD : 2 ≤ D) (F : DDFLightConeFrame η a b)
    (hη : ∀ μ, η μ * η μ = 1) (j : ℤ) (M : ℕ) :
    towerBigrade D R j M ≤ ordSeedSpan hD F j M := by
  classical
  rw [towerBigrade, levelSubmodule_eq_lcSpan hD F hη M, lcSpan, Submodule.map_span,
    Submodule.span_le]
  rintro _ ⟨_, ⟨f, hf, rfl⟩, rfl⟩
  exact single_lcMonomial_mem_ordSeedSpan hD F hη j M f hf

/-- `L_{-n}` maps the whole bigraded piece `(j, M')` into the non-empty seed family of level
`M' + n`: (F-1) followed by straightening. -/
theorem towerLop_neg_mem_ordSeedSpanPos_of_mem_towerBigrade (hD : 2 ≤ D)
    (F : DDFLightConeFrame η a b) (hη : ∀ μ, η μ * η μ = 1) (j : ℤ) (n : ℕ+) {M' : ℕ}
    {y : TowerFock D R} (hy : y ∈ towerBigrade D R j M') :
    towerLop η a b (-((n : ℕ) : ℤ)) y ∈ ordSeedSpanPos hD F j (M' + n) :=
  towerLop_neg_mem_ordSeedSpanPos hD F hη j n (towerBigrade_le_ordSeedSpan hD F hη j M' hy)

end SeedFamily

/-! ### Counting the non-empty seed family (blueprint §B″.4.1 (F-2), the injective half) -/

section SeedCount

open StringFormal.Virasoro

variable {D : ℕ}

/-- The `b̃`-row occupation function of a word: `L_{-λ}` contributes `α^{b̃}_{-λ_i}` for each
part.  (F-2)'s map `(λ, c) ↦ d` is `c + wordOcc λ`. -/
noncomputable def wordOcc (hD : 2 ≤ D) (l : List ℤ) : Osc D →₀ ℕ :=
  (l.map fun n => Finsupp.single ((conjIdx D hD, negPNat n) : Osc D) 1).sum

@[simp] lemma wordOcc_nil (hD : 2 ≤ D) : wordOcc hD ([] : List ℤ) = 0 := rfl

@[simp] lemma wordOcc_cons (hD : 2 ≤ D) (n : ℤ) (t : List ℤ) :
    wordOcc hD (n :: t) = Finsupp.single ((conjIdx D hD, negPNat n) : Osc D) 1 + wordOcc hD t :=
  by simp [wordOcc]

lemma level_wordOcc (hD : 2 ≤ D) {l : List ℤ} (hl : ∀ n ∈ l, n < 0) :
    (Fock.level D (wordOcc hD l) : ℤ) = -l.sum := by
  induction l with
  | nil => simp
  | cons n t ih =>
    have hn : n < 0 := hl n (List.mem_cons_self ..)
    have ht := ih fun m hm => hl m (List.mem_cons_of_mem n hm)
    rw [wordOcc_cons, Fock.level_add, Fock.level_single, Fock.oscLevel, one_mul, List.sum_cons]
    push_cast
    rw [ht, negPNat_coe_of_neg hn]
    omega

lemma conjDeg_wordOcc (hD : 2 ≤ D) (l : List ℤ) : conjDeg hD (wordOcc hD l) = l.length := by
  induction l with
  | nil => simp
  | cons n t ih => rw [wordOcc_cons, conjDeg_add, conjDeg_single_conj, ih, List.length_cons]; ring

lemma wordOcc_apply_of_ne (hD : 2 ≤ D) (l : List ℤ) {t : Fin D} (ht : t ≠ conjIdx D hD)
    (m : ℕ+) : wordOcc hD l (t, m) = 0 := by
  induction l with
  | nil => simp
  | cons n s ih =>
    rw [wordOcc_cons, Finsupp.add_apply, ih, Finsupp.single_apply, if_neg, zero_add]
    intro h
    exact ht (congrArg Prod.fst h).symm

lemma negPNat_eq_iff {n : ℤ} (hn : n < 0) (m : ℕ+) : negPNat n = m ↔ n = -((m : ℕ) : ℤ) := by
  constructor
  · intro h
    have := congrArg (fun k : ℕ+ => (k : ℕ)) h
    simp only [negPNat_coe_of_neg hn] at this
    omega
  · intro h
    subst h
    exact negPNat_neg_coe m

/-- The `b̃`-row of `wordOcc l` records the multiplicities of the word. -/
lemma wordOcc_apply_conj (hD : 2 ≤ D) {l : List ℤ} (hl : ∀ n ∈ l, n < 0) (m : ℕ+) :
    wordOcc hD l (conjIdx D hD, m) = l.count (-((m : ℕ) : ℤ)) := by
  induction l with
  | nil => simp
  | cons n t ih =>
    have hn : n < 0 := hl n (List.mem_cons_self ..)
    have ht := ih fun k hk => hl k (List.mem_cons_of_mem n hk)
    rw [wordOcc_cons, Finsupp.add_apply, ht, Finsupp.single_apply, List.count_cons]
    by_cases h : n = -((m : ℕ) : ℤ)
    · rw [if_pos (by rw [(negPNat_eq_iff hn m).2 h]), if_pos (by simp [h]), add_comm]
    · rw [if_neg (fun h' => h ((negPNat_eq_iff hn m).1 (congrArg Prod.snd h'))),
        if_neg (by simpa using h), add_zero, zero_add]

/-- A `b̃`-free occupation function vanishes on the whole `b̃` row. -/
lemma apply_conj_eq_zero_of_conjDeg_eq_zero (hD : 2 ≤ D) {c : Osc D →₀ ℕ}
    (hc : conjDeg hD c = 0) (m : ℕ+) : c (conjIdx D hD, m) = 0 := by
  by_contra hne
  have hmem : ((conjIdx D hD, m) : Osc D) ∈ c.support := Finsupp.mem_support_iff.2 hne
  rw [conjDeg, Finsupp.weight_apply] at hc
  have := (Finset.sum_eq_zero_iff.1 hc) _ hmem
  exact hne (by simpa using this)

end SeedCount

section SeedCountInj

open StringFormal.Virasoro

variable {D : ℕ}

/-- **(F-2), the injective half**: `(λ, c) ↦ c + wordOcc λ` sends the non-empty seed indices
of level `M` into the level-`M` occupation functions with at least one `b̃` factor. -/
noncomputable def seedIndexPosEmbed (hD : 2 ≤ D) (M : ℕ) (p : SeedIndexPos hD M) :
    {d : Osc D →₀ ℕ // Fock.level D d = M ∧ 1 ≤ conjDeg hD d} :=
  ⟨p.1.2 + wordOcc hD p.1.1, by
    obtain ⟨⟨l, c⟩, hl, hne, hc, hlev⟩ := p
    simp only at hl hne hc hlev ⊢
    refine ⟨?_, ?_⟩
    · have h1 := level_wordOcc hD hl.neg
      rw [Fock.level_add]
      have : (Fock.level D c : ℤ) + (Fock.level D (wordOcc hD l) : ℤ) = M := by rw [h1]; omega
      exact_mod_cast this
    · rw [conjDeg_add, hc, conjDeg_wordOcc, zero_add]
      exact List.length_pos_of_ne_nil hne⟩

/-- Injectivity of (F-2): `c` is read off outside the `b̃` row (where `wordOcc λ` vanishes and
`c` is arbitrary), and `λ` from the `b̃` row (where `c` vanishes and `wordOcc λ` records the
multiplicities of `λ`; a sorted list is determined by its multiplicities). -/
theorem seedIndexPosEmbed_injective (hD : 2 ≤ D) (M : ℕ) :
    Function.Injective (seedIndexPosEmbed hD M) := by
  rintro ⟨⟨l, c⟩, hl, hne, hc, hlev⟩ ⟨⟨l', c'⟩, hl', hne', hc', hlev'⟩ h
  have h := congrArg (fun x : {d : Osc D →₀ ℕ // Fock.level D d = M ∧ 1 ≤ conjDeg hD d} =>
    (x : Osc D →₀ ℕ)) h
  simp only [seedIndexPosEmbed] at h
  have hcc : c = c' := by
    ext ⟨t, m⟩
    by_cases ht : t = conjIdx D hD
    · subst ht
      rw [apply_conj_eq_zero_of_conjDeg_eq_zero hD hc,
        apply_conj_eq_zero_of_conjDeg_eq_zero hD hc']
    · have := congrArg (fun f : Osc D →₀ ℕ => f (t, m)) h
      simpa only [Finsupp.add_apply, wordOcc_apply_of_ne hD _ ht, add_zero] using this
  subst hcc
  have hll : l = l' := by
    have hcount : ∀ z : ℤ, l.count z = l'.count z := by
      intro z
      by_cases hz : z < 0
      · have hm := congrArg (fun f : Osc D →₀ ℕ => f (conjIdx D hD, negPNat z)) h
        simp only [Finsupp.add_apply, wordOcc_apply_conj hD hl.neg, wordOcc_apply_conj hD hl'.neg,
          apply_conj_eq_zero_of_conjDeg_eq_zero hD hc, zero_add] at hm
        rwa [negPNat_coe_of_neg hz, show -(((-z).toNat : ℕ) : ℤ) = z by omega] at hm
      · rw [List.count_eq_zero_of_not_mem fun hmem => hz (hl.neg z hmem),
          List.count_eq_zero_of_not_mem fun hmem => hz (hl'.neg z hmem)]
    exact List.Perm.eq_of_pairwise' hl.sorted hl'.sorted (List.perm_iff_count.2 hcount)
  subst hll
  rfl

instance finite_seedIndexPos (hD : 2 ≤ D) (M : ℕ) : Finite (SeedIndexPos hD M) := by
  have : Finite {d : Osc D →₀ ℕ // Fock.level D d = M ∧ 1 ≤ conjDeg hD d} :=
    ((Fock.finite_setOf_level_eq D M).subset fun _ hd => hd.1).to_subtype
  exact Finite.of_injective _ (seedIndexPosEmbed_injective hD M)

instance finite_conjPosIndex (hD : 2 ≤ D) (M : ℕ) :
    Finite {d : Osc D →₀ ℕ // Fock.level D d = M ∧ 1 ≤ conjDeg hD d} :=
  ((Fock.finite_setOf_level_eq D M).subset fun _ hd => hd.1).to_subtype

theorem nat_card_seedIndexPos_le (hD : 2 ≤ D) (M : ℕ) :
    Nat.card (SeedIndexPos hD M)
      ≤ Nat.card {d : Osc D →₀ ℕ // Fock.level D d = M ∧ 1 ≤ conjDeg hD d} :=
  Nat.card_le_card_of_injective _ (seedIndexPosEmbed_injective hD M)

variable {K : Type*} [Field K] [Algebra ℚ K] {η a b : Fin D → K}

/-- **`dim (non-empty seed family) ≤ p_D(M) − p_{D−1}(M)`**, the right-hand side being the
number of level-`M` occupation functions with at least one `b̃` factor. -/
theorem finrank_ordSeedSpanPos_le (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (j : ℤ) (M : ℕ) :
    Module.finrank K ↥(ordSeedSpanPos hD F j M)
      ≤ Nat.card {d : Osc D →₀ ℕ // Fock.level D d = M ∧ 1 ≤ conjDeg hD d} := by
  classical
  have := Fintype.ofFinite (SeedIndexPos hD M)
  refine le_trans (finrank_range_le_card (seedWordPos hD F j M)) ?_
  rw [← Nat.card_eq_fintype_card]
  exact nat_card_seedIndexPos_le hD M

instance ordSeedSpanPos_finiteDimensional (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (j : ℤ)
    (M : ℕ) : FiniteDimensional K ↥(ordSeedSpanPos hD F j M) :=
  FiniteDimensional.span_of_finite K (Set.finite_range _)

end SeedCountInj

/-! ### The exact dimension of a bigraded piece, and the count split -/

section BigradeDim

variable {D : ℕ}

/-- `dim (level-`M` piece of one Fock fiber) = #{d | level d = M}` (`= p_D(M)`, never
evaluated): Mathlib's `basisRestrictSupport` on `weightedHomogeneousSubmodule`. -/
theorem Fock.finrank_levelSubmodule (D : ℕ) (K : Type*) [Field K] (M : ℕ) :
    Module.finrank K ↥(Fock.levelSubmodule D K M)
      = Nat.card {d : Osc D →₀ ℕ // Fock.level D d = M} := by
  have h : Fock.levelSubmodule D K M
      = MvPolynomial.restrictSupport K
          {d : Osc D →₀ ℕ | Finsupp.weight (Fock.oscLevel D) d = M} := by
    rw [Fock.levelSubmodule, weightedHomogeneousSubmodule_eq_finsupp_supported]
    rfl
  rw [(LinearEquiv.ofEq _ _ h).finrank_eq,
    Module.finrank_eq_nat_card_basis (MvPolynomial.basisRestrictSupport K _)]
  rfl

/-- `dim V_{j,M} = #{d | level d = M}`: the rung embedding is injective. -/
theorem finrank_towerBigrade (K : Type*) [Field K] (j : ℤ) (M : ℕ) :
    Module.finrank K ↥(towerBigrade D K j M)
      = Nat.card {d : Osc D →₀ ℕ // Fock.level D d = M} := by
  rw [towerBigrade, ← (Submodule.equivMapOfInjective (Finsupp.lsingle (M := Fock D K) (R := K) j)
    (fun x y h => Finsupp.single_injective j h) _).finrank_eq]
  exact Fock.finrank_levelSubmodule D K M

/-- `p_D(M) = p_{D−1}(M) + (p_D(M) − p_{D−1}(M))`: the level-`M` occupation functions split
into the `b̃`-free ones and the ones with at least one `b̃` factor. -/
theorem nat_card_level_split (hD : 2 ≤ D) (M : ℕ) :
    Nat.card {d : Osc D →₀ ℕ // Fock.level D d = M}
      = Nat.card {d : Osc D →₀ ℕ // Fock.level D d = M ∧ conjDeg hD d = 0}
        + Nat.card {d : Osc D →₀ ℕ // Fock.level D d = M ∧ 1 ≤ conjDeg hD d} := by
  classical
  have hfin : Finite {d : Osc D →₀ ℕ // Fock.level D d = M} :=
    (Fock.finite_setOf_level_eq D M).to_subtype
  rw [← Nat.card_congr
    (Equiv.sumCompl fun x : {d : Osc D →₀ ℕ // Fock.level D d = M} => conjDeg hD x.1 = 0),
    Nat.card_sum]
  congr 1
  · exact Nat.card_congr (Equiv.subtypeSubtypeEquivSubtypeInter
      (fun d : Osc D →₀ ℕ => Fock.level D d = M) (fun d => conjDeg hD d = 0))
  · refine Nat.card_congr ((Equiv.subtypeSubtypeEquivSubtypeInter
      (fun d : Osc D →₀ ℕ => Fock.level D d = M) (fun d => ¬ conjDeg hD d = 0)).trans
      (Equiv.subtypeEquivRight fun d => ?_))
    simp only [and_congr_right_iff]
    intro _
    omega

end BigradeDim

/-! ### The seed space and its lower bound (blueprint §B‴.9's `le_finrank_towerSeed`) -/

section Seed

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] (η a b : Fin D → R)

/-- **The seed space `Q_{j,M}`** (blueprint §B‴.3): states on the bigraded piece `(j, M)`
killed by every positive mode.  No `L_0` condition, so it is defined on every rung and level;
on the antidiagonal `j = -M` at intercept `a₀ = α'k²` it coincides with the physical slice. -/
noncomputable def towerSeed (j : ℤ) (M : ℕ) : Submodule R (TowerFock D R) :=
  towerPositiveModeSubmodule η a b ⊓ towerBigrade D R j M

variable {η a b}

lemma mem_towerSeed {j : ℤ} {M : ℕ} {x : TowerFock D R} :
    x ∈ towerSeed η a b j M
      ↔ (∀ m : ℤ, 0 < m → towerLop η a b m x = 0) ∧ x ∈ towerBigrade D R j M := by
  rw [towerSeed, Submodule.mem_inf, mem_towerPositiveModeSubmodule]

end Seed

section SeedBound

variable {D : ℕ} {K : Type*} [Field K] [CharZero K] [Algebra ℚ K] {η a b : Fin D → K}

omit [CharZero K] [Algebra ℚ K] in
/-- A linear map into the dual of a finite-dimensional space has rank at most that dimension.
Stated on abstract vector spaces for the same instance-path reason as
`SpuriousElimination.finrank_le_of_injective_toDualHom`. -/
theorem finrank_range_toDualHom_le {V : Type*} [AddCommGroup V] [Module K V]
    {M : Type*} [AddCommGroup M] [Module K M] (W : Submodule K M) [FiniteDimensional K ↥W]
    (f : V →ₗ[K] (↥W →ₗ[K] K)) :
    Module.finrank K ↥(LinearMap.range f) ≤ Module.finrank K ↥W := by
  have hfin : Module.Finite K (↥W →ₗ[K] K) :=
    (inferInstance : FiniteDimensional K (Module.Dual K ↥W))
  exact le_trans (Submodule.finrank_le _)
    (le_of_eq (Subspace.dual_finrank_eq (K := K) (V := ↥W)))

/-- The pairing of the bigraded piece `V_{j,M}` against the non-empty seed family, as a linear
map into the dual of that family.  Its kernel is (contained in) the seed space `Q_{j,M}`, and
rank–nullity then gives the lower bound on `dim Q_{j,M}` — no nondegeneracy of the form on the
slice is needed for this direction (blueprint §B‴.9). -/
noncomputable def sliceToSeedDual (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (j : ℤ) (M : ℕ) :
    ↥(towerBigrade D K j M) →ₗ[K] (↥(ordSeedSpanPos hD F j M) →ₗ[K] K) :=
  LinearMap.domRestrict ((Fock.towerPairing η).compl₂ (ordSeedSpanPos hD F j M).subtype) _

omit [CharZero K] in
@[simp]
lemma sliceToSeedDual_apply (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (j : ℤ) (M : ℕ)
    (x : ↥(towerBigrade D K j M)) (s : ↥(ordSeedSpanPos hD F j M)) :
    sliceToSeedDual hD F j M x s
      = Fock.towerPairing η (x : TowerFock D K) (s : TowerFock D K) := rfl

/-- **The kernel of `sliceToSeedDual` consists of seeds.**  For `0 < n ≤ M`,
`⟨L_n x, y⟩ = ⟨L_n x, y_{(j,M-n)}⟩ = ⟨x, L_{-n} y_{(j,M-n)}⟩`, and `L_{-n} y_{(j,M-n)}` lies in
the non-empty seed family of level `M` by (F-1) plus straightening; nondegeneracy of the tower
form then gives `L_n x = 0`.  For `n > M` the mode kills the slice outright. -/
theorem mem_towerSeed_of_mem_ker_sliceToSeedDual (hD : 2 ≤ D) (F : DDFLightConeFrame η a b)
    (j : ℤ) (M : ℕ) {x : ↥(towerBigrade D K j M)}
    (hx : x ∈ LinearMap.ker (sliceToSeedDual hD F j M)) :
    (x : TowerFock D K) ∈ towerSeed η a b j M := by
  rw [mem_towerSeed]
  refine ⟨fun m hm => ?_, x.2⟩
  have hker : ∀ s ∈ ordSeedSpanPos hD F j M, Fock.towerPairing η (x : TowerFock D K) s = 0 := by
    intro s hs
    have := congrArg (fun g : ↥(ordSeedSpanPos hD F j M) →ₗ[K] K => g ⟨s, hs⟩)
      (LinearMap.mem_ker.1 hx)
    simpa using this
  by_cases hMm : (M : ℤ) < m
  · exact towerLop_apply_eq_zero_of_mem_towerBigrade_of_lt η a b x.2 hMm
  · obtain ⟨n, rfl⟩ : ∃ n : ℕ+, m = ((n : ℕ) : ℤ) :=
      ⟨⟨m.toNat, by omega⟩, by simp only [PNat.mk_coe]; omega⟩
    have hnM : (n : ℕ) ≤ M := by omega
    have hM' : ((M - (n : ℕ) : ℕ) : ℤ) = (M : ℤ) - ((n : ℕ) : ℤ) := by omega
    have hLx : towerLop η a b ((n : ℕ) : ℤ) x ∈ towerBigrade D K j (M - (n : ℕ)) :=
      towerLop_mem_towerBigrade η a b x.2 hM'
    refine Fock.eq_zero_of_towerPairing_left_eq_zero F.hη fun y => ?_
    have hproj : towerBigradeProj D K j (M - (n : ℕ)) (towerLop η a b ((n : ℕ) : ℤ) x)
        = towerLop η a b ((n : ℕ) : ℤ) x := towerBigradeProj_of_mem_self hLx
    rw [← hproj, towerPairing_towerBigradeProj_left, hproj, Fock.towerPairing_towerLop_left]
    refine hker _ ?_
    have := towerLop_neg_mem_ordSeedSpanPos_of_mem_towerBigrade hD F F.hη j n
      (towerBigradeProj_mem j (M - (n : ℕ)) y)
    rwa [show M - (n : ℕ) + (n : ℕ) = M by omega] at this

/-- **(F-1)+(F-2), the lower-bound half** (blueprint §B‴.9's `le_finrank_towerSeed`):

`dim Q_{j,M} ≥ p_{D−1}(M)`,

the right-hand side being the number of `b̃`-free level-`M` light-cone occupation functions.

Rank–nullity for `Ψ = sliceToSeedDual : V_{j,M} → (seed family)^*`:
`dim ker Ψ = dim V_{j,M} − rank Ψ ≥ p_D(M) − (p_D(M) − p_{D−1}(M))`, using
`dim V_{j,M} = p_D(M)` (`finrank_towerBigrade`), `rank Ψ ≤ dim (seed family) ≤ p_D(M) − p_{D−1}(M)`
(`finrank_ordSeedSpanPos_le`, the injective half of (F-2)), and `ker Ψ ⊆ Q_{j,M}`.

`D = 26` does not appear, nor does the intercept: the statement holds on **every** rung `j` and
every level `M`.  Combined with `SpuriousElimination.finrank_towerPositiveMode_inf_towerBigrade_le`
this is an equality. -/
theorem le_finrank_towerSeed (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (j : ℤ) (M : ℕ) :
    Fintype.card {c : Osc D →₀ ℕ // Fock.level D c = M ∧ conjDeg hD c = 0}
      ≤ Module.finrank K ↥(towerSeed η a b j M) := by
  classical
  have hrn := LinearMap.finrank_range_add_finrank_ker (K := K) (V := ↥(towerBigrade D K j M))
    (V₂ := ↥(ordSeedSpanPos hD F j M) →ₗ[K] K) (sliceToSeedDual hD F j M)
  have hS : FiniteDimensional K ↥(ordSeedSpanPos hD F j M) :=
    ordSeedSpanPos_finiteDimensional hD F j M
  have h1 := finrank_range_toDualHom_le (K := K) (V := ↥(towerBigrade D K j M))
    (M := TowerFock D K) (ordSeedSpanPos hD F j M) (sliceToSeedDual hD F j M)
  have h2 := finrank_ordSeedSpanPos_le hD F j M
  have hVfin : FiniteDimensional K ↥(towerBigrade D K j M) := towerBigrade_finite j M
  have hseedfin : FiniteDimensional K ↥(towerSeed η a b j M) :=
    Submodule.finiteDimensional_of_le (K := K) (V := TowerFock D K)
      (S₁ := towerSeed η a b j M) (S₂ := towerBigrade D K j M) inf_le_right
  have hker : Module.finrank K ↥(LinearMap.ker (sliceToSeedDual hD F j M))
      ≤ Module.finrank K ↥(towerSeed η a b j M) := by
    rw [← Submodule.finrank_map_subtype_eq (towerBigrade D K j M)]
    refine Submodule.finrank_mono ?_
    rintro _ ⟨x, hx, rfl⟩
    exact mem_towerSeed_of_mem_ker_sliceToSeedDual hD F j M hx
  have hV := finrank_towerBigrade (D := D) K j M
  have hsplit := nat_card_level_split hD M
  rw [← Nat.card_eq_fintype_card]
  omega

end SeedBound

/-! ### The `D`-independent null lower bound (blueprint §B‴.9's
`le_finrank_towerNull_inf_towerBigrade`, PR6′-c) -/

section NullLowerBound

variable {D : ℕ} {K : Type*} [Field K] [CharZero K] [Algebra ℚ K] {η a b : Fin D → K}

/-- **`L_{-1}` embeds the seed space `Q_{-(N+1), N}` into the null states of the antidiagonal
slice `V_{N+1}`**, as a linear map (Type 1 of `NullSeedsTwo.lean`, packaged). -/
noncomputable def typeOneMap (F : DDFLightConeFrame η a b) (haa : Fock.zeroModeSq η a = 2)
    (N : ℕ) :
    ↥(towerSeed η a b (-((N + 1 : ℕ) : ℤ)) N)
      →ₗ[K] ↥(towerNullSubmodule η a b 1 ⊓ towerBigrade D K (-((N + 1 : ℕ) : ℤ)) (N + 1)) :=
  (towerLop η a b (-1)).restrict fun y hy => by
    obtain ⟨hpos, hbig⟩ := mem_towerSeed.1 hy
    exact towerLop_neg_one_mem_towerNullSubmodule_of_mem_towerBigrade η a b F.hη
      F.frame.isotropic F.hba haa (by push_cast; ring) hbig hpos

omit [CharZero K] in
lemma typeOneMap_apply (F : DDFLightConeFrame η a b) (haa : Fock.zeroModeSq η a = 2) (N : ℕ)
    (y : ↥(towerSeed η a b (-((N + 1 : ℕ) : ℤ)) N)) :
    (typeOneMap F haa N y : TowerFock D K) = towerLop η a b (-1) (y : TowerFock D K) := rfl

omit [CharZero K] in
theorem typeOneMap_injective (F : DDFLightConeFrame η a b) (haa : Fock.zeroModeSq η a = 2)
    (N : ℕ) : Function.Injective (typeOneMap (K := K) F haa N) := by
  intro u v huv
  have h : (typeOneMap F haa N u : TowerFock D K) = (typeOneMap F haa N v : TowerFock D K) := by
    rw [huv]
  simp only [typeOneMap_apply] at h
  refine Subtype.ext (sub_eq_zero.mp ?_)
  refine towerLop_neg_one_injective η a b F.hη F.frame.isotropic F.hba
    (M := N) (j := -((N + 1 : ℕ) : ℤ)) (Submodule.sub_mem _ (mem_towerSeed.1 u.2).2
      (mem_towerSeed.1 v.2).2) ?_
  rw [map_sub, h, sub_self]

/-- **The `D`-independent lower bound on the null states** (blueprint §B‴.9, PR6′-c; stated
at level `N + 1` so that no natural-number subtraction is involved):

`dim (H_null ⊓ V_{N+1}) ≥ p_{D−1}(N)`,

the right-hand side being the number of `b̃`-free level-`N` light-cone occupation functions.
Proof: `L_{-1}` is injective on the piece `(-(N+1), N)` (`towerLop_neg_one_injective`) and sends
its seed space `Q_{-(N+1),N}` into `H_null ⊓ V_{N+1}` (Type 1), so
`dim (H_null ⊓ V_{N+1}) ≥ dim Q_{-(N+1),N} ≥ p_{D−1}(N)` (`le_finrank_towerSeed`).

`D = 26` does not appear.  The intercept enters only through `haa : k·k = 2` (i.e. `a₀ = 1`),
which is what makes `L_0` vanish on the seeds and hence `L_{-1}(seed)` physical; this is the
one place PR6′ is not intercept-free (blueprint §B‴.10).  Compare
`LevelTwoCount.le_finrank_towerNullSubmodule_inf_towerBigrade_two` (`N + 1 = 2`), which gets
`D` rather than `p_{D−1}(1) = D − 1`: the missing one is the Type-2 state `𝒟₂|0;p_{-2}⟩`, the
only place `D = 26` is consumed — exactly the gap §B‴.3 predicts. -/
theorem le_finrank_towerNull_inf_towerBigrade_succ (hD : 2 ≤ D) (F : DDFLightConeFrame η a b)
    (haa : Fock.zeroModeSq η a = 2) (N : ℕ) :
    Fintype.card {c : Osc D →₀ ℕ // Fock.level D c = N ∧ conjDeg hD c = 0}
      ≤ Module.finrank K
          ↥(towerNullSubmodule η a b 1 ⊓ towerBigrade D K (-((N + 1 : ℕ) : ℤ)) (N + 1)) := by
  refine le_trans (le_finrank_towerSeed hD F (-((N + 1 : ℕ) : ℤ)) N) ?_
  have hVfin : FiniteDimensional K ↥(towerBigrade D K (-((N + 1 : ℕ) : ℤ)) (N + 1)) :=
    towerBigrade_finite _ _
  have hfin : FiniteDimensional K
      ↥(towerNullSubmodule η a b 1 ⊓ towerBigrade D K (-((N + 1 : ℕ) : ℤ)) (N + 1)) :=
    Submodule.finiteDimensional_of_le (K := K) (V := TowerFock D K)
      (S₁ := towerNullSubmodule η a b 1 ⊓ towerBigrade D K (-((N + 1 : ℕ) : ℤ)) (N + 1))
      (S₂ := towerBigrade D K (-((N + 1 : ℕ) : ℤ)) (N + 1)) inf_le_right
  exact LinearMap.finrank_le_finrank_of_injective (typeOneMap_injective F haa N)

/-- The same bound in the blueprint's `N - 1` phrasing, for `1 ≤ N`.  (At `N = 0` the
blueprint's statement is false: `p_{D−1}(0) = 1` but the vacuum `|0;0⟩` is physical and not
null.) -/
theorem le_finrank_towerNull_inf_towerBigrade (hD : 2 ≤ D) (F : DDFLightConeFrame η a b)
    (haa : Fock.zeroModeSq η a = 2) {N : ℕ} (hN : 1 ≤ N) :
    Fintype.card {c : Osc D →₀ ℕ // Fock.level D c = N - 1 ∧ conjDeg hD c = 0}
      ≤ Module.finrank K ↥(towerNullSubmodule η a b 1 ⊓ towerBigrade D K (-(N : ℤ)) N) := by
  obtain ⟨N, rfl⟩ : ∃ N', N = N' + 1 := ⟨N - 1, by omega⟩
  simpa using le_finrank_towerNull_inf_towerBigrade_succ hD F haa N

end NullLowerBound

end StringFormal.NoGhost
