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

end StringFormal.NoGhost
