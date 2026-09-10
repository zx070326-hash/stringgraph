/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import Mathlib.Combinatorics.Enumerative.Partition.Basic
import Mathlib.Data.Multiset.Sort
import Mathlib.LinearAlgebra.Dimension.Constructions
import StringFormal.Virasoro.Verma

/-!
# Straightening in the Verma module: ordered words span

Graph node: `worldsheet.verma-module` (the PBW-basis clause); `formal/TODO.md` item
`pbw-verma`, **half (a) only**.

`StringFormal/Virasoro/Verma.lean` proves `negSpan_eq_top`: `V(c,h)` is spanned by the
*unordered* words `L_{n_1} ⋯ L_{n_k}|c,h⟩`, `n_i < 0`.  This file cuts that spanning set down
to the *ordered* words

  `L_{-b_1} L_{-b_2} ⋯ L_{-b_k} |c,h⟩`,  `b_1 ≥ b_2 ≥ ⋯ ≥ b_k ≥ 1`,

i.e. to the partitions of the level.  Consequently `dim V_N ≤ p(N)`.

**This is only the easy half of Poincaré–Birkhoff–Witt.**  Linear independence of the ordered
words (`dim V_N ≥ p(N)`) is *not* proved and is not available from Mathlib `v4.33.1`; see
*Status* below.  In particular `V(c,h) ≠ 0` remains open, so — as in `Verma.lean` — everything
here would still be true, but vacuous, if `V(c,h)` were `0`.

## The straightening measure

Ordering a word by adjacent transpositions is not obviously terminating, because the
commutator `⁅L a, L b⁆ = (a-b) L_{a+b}` produces a *shorter* word whose inversion count is
uncontrolled.  The proof here uses instead the single integer

  `wordWeight [a_0, …, a_{k-1}] = Σ_i i · a_i`  (the head contributes nothing),

which is `≤ 0` on words in the negative modes, together with
`wordMeasure l = (-wordWeight l).toNat : ℕ`.  Both rewriting steps *strictly increase*
`wordWeight`:

* swapping an adjacent inversion `a :: b :: t ↦ b :: a :: t` (`a > b`) increases it by `a - b`;
* the commutator term `a :: b :: t ↦ (a+b) :: t` increases it by `-b - t.sum ≥ 1`.

So `wordMeasure` strictly decreases, and it is a natural number.  The bookkeeping that makes
the induction go through is that `straighten` returns ordered words of measure **at most** that
of the input word; without that bound the nested rewriting in the second Leibniz term
`⁅L b, ⁅L a, X⁆⁆` — whose inner straightening can produce words longer than the original tail —
cannot be controlled.

## Main definitions

* `StringFormal.Virasoro.IsOrdWord l`: `l` is a list of strictly negative integers in
  non-decreasing order — exactly the shape `L_{-b_1} ⋯ L_{-b_k}` with `b_1 ≥ ⋯ ≥ b_k ≥ 1`.
* `StringFormal.Virasoro.ordSpan R c h s`: the `R`-span of the ordered words of total mode `s`.
* `StringFormal.Virasoro.partitionWord R c h N p`: the ordered word attached to a partition `p`
  of `N`.

## Main statements

* `straighten`: applying `L_a` (`a < 0`) to an ordered word lands in the span of ordered words
  of the same total mode and no larger measure.  This is the whole content of the file.
* `wordAct_mem_ordSpan`: **every** word in the negative modes lies in the span of the ordered
  words of the same total mode.
* `levelSpan_eq_ordSpan`: `V_N` is spanned by the ordered words of level `N`.
* `levelSpan_eq_span_range_partitionWord`: `V_N = span_R {partitionWord N p : p ⊢ N}`, a
  spanning family indexed by the partitions of `N`.
* `finrank_levelSpan_le_card_partition`: over a field, `dim V_N ≤ p(N)`, where `p(N)` is
  `Fintype.card (Nat.Partition N)`.

## Status

No `sorry`, no new axioms.  What is **not** here, and why:

1. **Linear independence** of the ordered words, i.e. `dim V_N ≥ p(N)`.  This is the
   Poincaré–Birkhoff–Witt theorem for `U(Vir_-)` plus freeness of the induced module.
   Mathlib `v4.33.1` has no PBW theorem, so this cannot be assembled from existing pieces.
2. **`V(c,h) ≠ 0`**, which is a consequence of 1.
3. Consequently `dim V_N = p(N)` is *not* proved; only `≤`.
-/

namespace StringFormal.Virasoro

/-! ### The straightening measure on words -/

/-- `wordWeight [a_0, …, a_{k-1}] = Σ_i i · a_i`.  The head of the list contributes nothing,
which is what makes the recursion `wordWeight (a :: t) = wordWeight t + t.sum` independent
of `a`. -/
def wordWeight : List ℤ → ℤ
  | [] => 0
  | _ :: t => wordWeight t + t.sum

@[simp] lemma wordWeight_nil : wordWeight [] = 0 := rfl

@[simp] lemma wordWeight_cons (a : ℤ) (t : List ℤ) :
    wordWeight (a :: t) = wordWeight t + t.sum := rfl

lemma sum_nonpos_of_neg {l : List ℤ} (hl : ∀ n ∈ l, n < 0) : l.sum ≤ 0 := by
  induction l with
  | nil => simp
  | cons a t ih =>
    have ha : a < 0 := hl a (List.mem_cons_self ..)
    have hst := ih fun n hn => hl n (List.mem_cons_of_mem a hn)
    rw [List.sum_cons]
    omega

lemma wordWeight_nonpos {l : List ℤ} (hl : ∀ n ∈ l, n < 0) : wordWeight l ≤ 0 := by
  induction l with
  | nil => simp
  | cons a t ih =>
    have hnegt : ∀ n ∈ t, n < 0 := fun n hn => hl n (List.mem_cons_of_mem a hn)
    have h1 := ih hnegt
    have h2 := sum_nonpos_of_neg hnegt
    rw [wordWeight_cons]
    omega

/-- The natural number driving the straightening induction. -/
def wordMeasure (l : List ℤ) : ℕ := (-wordWeight l).toNat

lemma wordMeasure_cast {l : List ℤ} (hl : ∀ n ∈ l, n < 0) :
    ((wordMeasure l : ℤ)) = -wordWeight l := by
  have := wordWeight_nonpos hl
  rw [wordMeasure]
  omega

lemma eq_nil_of_sum_eq_zero {l : List ℤ} (hl : ∀ n ∈ l, n < 0) (h : l.sum = 0) : l = [] := by
  cases l with
  | nil => rfl
  | cons a t =>
    exfalso
    have ha : a < 0 := hl a (List.mem_cons_self ..)
    have ht := sum_nonpos_of_neg fun n hn => hl n (List.mem_cons_of_mem a hn)
    rw [List.sum_cons] at h
    omega

/-! ### Ordered words -/

/-- `l` is an **ordered word**: a list of strictly negative modes in non-decreasing order.
Writing `l = [-b_1, …, -b_k]`, this says `b_1 ≥ b_2 ≥ ⋯ ≥ b_k ≥ 1`, i.e. `l` has exactly the
shape of a Poincaré–Birkhoff–Witt monomial `L_{-b_1} ⋯ L_{-b_k}`. -/
structure IsOrdWord (l : List ℤ) : Prop where
  /-- all modes are strictly negative -/
  neg : ∀ n ∈ l, n < 0
  /-- the modes are in non-decreasing order -/
  sorted : l.Pairwise (· ≤ ·)

lemma isOrdWord_nil : IsOrdWord ([] : List ℤ) := ⟨by simp, List.Pairwise.nil⟩

lemma IsOrdWord.tail {a : ℤ} {t : List ℤ} (hw : IsOrdWord (a :: t)) : IsOrdWord t :=
  ⟨fun n hn => hw.neg n (List.mem_cons_of_mem a hn), (List.pairwise_cons.mp hw.sorted).2⟩

lemma IsOrdWord.head_neg {a : ℤ} {t : List ℤ} (hw : IsOrdWord (a :: t)) : a < 0 :=
  hw.neg a (List.mem_cons_self ..)

lemma IsOrdWord.cons {a : ℤ} {t : List ℤ} (ha : a < 0) (ht : IsOrdWord t)
    (hle : ∀ b ∈ t, a ≤ b) : IsOrdWord (a :: t) where
  neg := by
    intro n hn
    rcases List.mem_cons.mp hn with rfl | hn
    · exact ha
    · exact ht.neg n hn
  sorted := List.pairwise_cons.mpr ⟨hle, ht.sorted⟩

/-- Prepending a mode below the head of an ordered word keeps it ordered. -/
lemma IsOrdWord.cons_head {a b : ℤ} {t : List ℤ} (ha : a < 0) (hbt : IsOrdWord (b :: t))
    (hab : a ≤ b) : IsOrdWord (a :: b :: t) := by
  refine IsOrdWord.cons ha hbt ?_
  intro x hx
  rcases List.mem_cons.mp hx with rfl | hx
  · exact hab
  · exact hab.trans ((List.pairwise_cons.mp hbt.sorted).1 x hx)

lemma IsOrdWord.cons_neg {a : ℤ} {t : List ℤ} (ha : a < 0) (ht : IsOrdWord t) :
    ∀ n ∈ a :: t, n < 0 := by
  intro n hn
  rcases List.mem_cons.mp hn with rfl | hn
  · exact ha
  · exact ht.neg n hn

section Span

variable (R : Type*) [CommRing R] [Algebra ℚ R] (c h : R)

/-- The ordered words of total mode `s` whose measure is at most `M`. -/
def ordWordSetLe (s : ℤ) (M : ℕ) : Set (VermaModule R c h) :=
  {x | ∃ l : List ℤ, IsOrdWord l ∧ l.sum = s ∧ wordMeasure l ≤ M ∧
    x = wordAct R c h l (hwv R c h)}

/-- The span of the ordered words of total mode `s` and measure at most `M`. -/
noncomputable def ordSpanLe (s : ℤ) (M : ℕ) : Submodule R (VermaModule R c h) :=
  Submodule.span R (ordWordSetLe R c h s M)

/-- The ordered words of total mode `s`.  For `s = -N` these are the candidate PBW basis
vectors of the level-`N` subspace `V_N`, indexed by the partitions of `N`. -/
def ordWordSet (s : ℤ) : Set (VermaModule R c h) :=
  {x | ∃ l : List ℤ, IsOrdWord l ∧ l.sum = s ∧ x = wordAct R c h l (hwv R c h)}

/-- The span of the ordered words of total mode `s`. -/
noncomputable def ordSpan (s : ℤ) : Submodule R (VermaModule R c h) :=
  Submodule.span R (ordWordSet R c h s)

lemma ordSpanLe_eq_span (s : ℤ) (M : ℕ) :
    ordSpanLe R c h s M = Submodule.span R (ordWordSetLe R c h s M) := rfl

lemma ordSpan_eq_span (s : ℤ) : ordSpan R c h s = Submodule.span R (ordWordSet R c h s) := rfl

lemma ordSpanLe_mono {s : ℤ} {M M' : ℕ} (hM : M ≤ M') :
    ordSpanLe R c h s M ≤ ordSpanLe R c h s M' := by
  refine Submodule.span_mono ?_
  rintro x ⟨l, hl, hs, hm, rfl⟩
  exact ⟨l, hl, hs, hm.trans hM, rfl⟩

lemma ordSpanLe_le_ordSpan (s : ℤ) (M : ℕ) : ordSpanLe R c h s M ≤ ordSpan R c h s := by
  refine Submodule.span_mono ?_
  rintro x ⟨l, hl, hs, _, rfl⟩
  exact ⟨l, hl, hs, rfl⟩

lemma mem_ordSpanLe {l : List ℤ} (hl : IsOrdWord l) {s : ℤ} (hs : l.sum = s) {M : ℕ}
    (hm : wordMeasure l ≤ M) : wordAct R c h l (hwv R c h) ∈ ordSpanLe R c h s M :=
  Submodule.subset_span ⟨l, hl, hs, hm, rfl⟩

lemma mem_ordSpan {l : List ℤ} (hl : IsOrdWord l) {s : ℤ} (hs : l.sum = s) :
    wordAct R c h l (hwv R c h) ∈ ordSpan R c h s :=
  Submodule.subset_span ⟨l, hl, hs, rfl⟩

/-! ### Straightening -/

private lemma lie_lgen_nil_mem {a : ℤ} (ha : a < 0) :
    ⁅VirasoroAlgebra.lgen R a, wordAct R c h ([] : List ℤ) (hwv R c h)⁆
      ∈ ordSpanLe R c h (a + ([] : List ℤ).sum) (wordMeasure [a]) := by
  have hrw : ⁅VirasoroAlgebra.lgen R a, wordAct R c h ([] : List ℤ) (hwv R c h)⁆
      = wordAct R c h [a] (hwv R c h) := rfl
  rw [hrw]
  exact mem_ordSpanLe R c h (IsOrdWord.cons ha isOrdWord_nil (by simp)) (by simp) le_rfl

/-- **Straightening, the key lemma.**  Applying a negative mode `L_a` to an ordered word
`L_{n_1} ⋯ L_{n_k}|c,h⟩` produces an element of the span of the *ordered* words with the same
total mode `a + n_1 + ⋯ + n_k` and with measure at most `wordMeasure (a :: l)`.

The measure bound in the conclusion is not decoration: it is exactly what makes the second
Leibniz term fit under the induction hypothesis. -/
private lemma straighten_aux (k : ℕ) :
    ∀ a : ℤ, a < 0 → ∀ l : List ℤ, IsOrdWord l → wordMeasure (a :: l) ≤ k →
      ⁅VirasoroAlgebra.lgen R a, wordAct R c h l (hwv R c h)⁆
        ∈ ordSpanLe R c h (a + l.sum) (wordMeasure (a :: l)) := by
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
    exact lie_lgen_nil_mem R c h ha
  | succ k ih =>
    intro a ha l hl hk
    match l with
    | [] => exact lie_lgen_nil_mem R c h ha
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
        have hrw : ⁅VirasoroAlgebra.lgen R a, wordAct R c h (b :: t) (hwv R c h)⁆
            = wordAct R c h (a :: b :: t) (hwv R c h) := rfl
        rw [hrw]
        exact mem_ordSpanLe R c h hord (by simp only [List.sum_cons]) le_rfl
      · -- `b < a`: swap the two leading modes, at the cost of a shorter word
        have hba : b < a := lt_of_not_ge hab
        have hat : ((wordMeasure (a :: t) : ℤ)) = -(wordWeight t + t.sum) := by
          rw [wordMeasure_cast (IsOrdWord.cons_neg ha ht), wordWeight_cons]
        have hsum' : ((wordMeasure ((a + b) :: t) : ℤ)) = -(wordWeight t + t.sum) := by
          rw [wordMeasure_cast (IsOrdWord.cons_neg (by omega) ht), wordWeight_cons]
        -- the reordered term, as a statement about a variable element of the span
        have key : ∀ y ∈ ordSpanLe R c h (a + t.sum) (wordMeasure (a :: t)),
            ⁅VirasoroAlgebra.lgen R b, y⁆
              ∈ ordSpanLe R c h (a + (b :: t).sum) (wordMeasure (a :: b :: t)) := by
          intro y hy
          rw [ordSpanLe_eq_span] at hy
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
            exact ordSpanLe_mono R c h (by omega) h3
          | zero => rw [lie_zero]; exact Submodule.zero_mem _
          | add y z _ _ hy hz => rw [lie_add]; exact Submodule.add_mem _ hy hz
          | smul r y _ hy => rw [lie_smul]; exact Submodule.smul_mem _ _ hy
        have hrw : ⁅VirasoroAlgebra.lgen R a, wordAct R c h (b :: t) (hwv R c h)⁆
            = ⁅VirasoroAlgebra.lgen R a,
                ⁅VirasoroAlgebra.lgen R b, wordAct R c h t (hwv R c h)⁆⁆ := rfl
        rw [hrw, leibniz_lie, VirasoroAlgebra.lie_lgen_lgen, if_neg (by omega), zero_smul,
          add_zero, smul_lie]
        refine Submodule.add_mem _ ?_ ?_
        · -- the commutator term `(a-b) • L_{a+b} · X`
          have hm1 : wordMeasure ((a + b) :: t) ≤ k := by omega
          have h1 := ih (a + b) (by omega) t ht hm1
          have hsum1 : a + b + t.sum = a + (b :: t).sum := by
            simp only [List.sum_cons]; ring
          rw [hsum1] at h1
          exact Submodule.smul_mem _ _ (ordSpanLe_mono R c h (by omega) h1)
        · -- the reordered term `L_b · (L_a · X)`
          have hm2 : wordMeasure (a :: t) ≤ k := by omega
          exact key _ (ih a ha t ht hm2)

/-- **Straightening.**  Applying a negative mode to an ordered word lands in the span of the
ordered words of the same total mode. -/
theorem straighten {a : ℤ} (ha : a < 0) {l : List ℤ} (hl : IsOrdWord l) :
    ⁅VirasoroAlgebra.lgen R a, wordAct R c h l (hwv R c h)⁆
      ∈ ordSpanLe R c h (a + l.sum) (wordMeasure (a :: l)) :=
  straighten_aux R c h (wordMeasure (a :: l)) a ha l hl le_rfl

/-- **Every word in the negative modes is a combination of ordered words of the same total
mode.**  This is the straightening half of Poincaré–Birkhoff–Witt for `V(c,h)`. -/
theorem wordAct_mem_ordSpan {l : List ℤ} (hl : ∀ n ∈ l, n < 0) :
    wordAct R c h l (hwv R c h) ∈ ordSpan R c h l.sum := by
  induction l with
  | nil => exact mem_ordSpan R c h isOrdWord_nil rfl
  | cons a t ih =>
    have ha : a < 0 := hl a (List.mem_cons_self ..)
    have hnegt : ∀ n ∈ t, n < 0 := fun n hn => hl n (List.mem_cons_of_mem a hn)
    have key : ∀ y ∈ ordSpan R c h t.sum,
        ⁅VirasoroAlgebra.lgen R a, y⁆ ∈ ordSpan R c h (a + t.sum) := by
      intro y hy
      rw [ordSpan_eq_span] at hy
      induction hy using Submodule.span_induction with
      | mem z hz =>
        obtain ⟨l', hl', hsl', rfl⟩ := hz
        have h3 := straighten R c h ha hl'
        rw [hsl'] at h3
        exact ordSpanLe_le_ordSpan R c h _ _ h3
      | zero => rw [lie_zero]; exact Submodule.zero_mem _
      | add y z _ _ hy hz => rw [lie_add]; exact Submodule.add_mem _ hy hz
      | smul r y _ hy => rw [lie_smul]; exact Submodule.smul_mem _ _ hy
    have hgoal : wordAct R c h (a :: t) (hwv R c h)
        = ⁅VirasoroAlgebra.lgen R a, wordAct R c h t (hwv R c h)⁆ := rfl
    rw [hgoal, List.sum_cons]
    exact key _ (ih hnegt)

end Span

/-! ### The level subspaces are spanned by the partitions of the level -/

section Level

variable (R : Type*) [CommRing R] [Algebra ℚ R] (c h : R)

private lemma map_toNat_map_neg {l : List ℤ} (hl : ∀ n ∈ l, n < 0) :
    ((l.map fun n : ℤ => (-n).toNat).map fun b : ℕ => -(b : ℤ)) = l := by
  rw [List.map_map]
  refine (List.map_congr_left ?_).trans (List.map_id l)
  intro n hn
  have := hl n hn
  simp only [Function.comp_apply, id_eq]
  omega

private lemma sum_map_toNat {l : List ℤ} (hl : ∀ n ∈ l, n < 0) :
    (((l.map fun n : ℤ => (-n).toNat).sum : ℕ) : ℤ) = -l.sum := by
  induction l with
  | nil => simp
  | cons a t ih =>
    have ha : a < 0 := hl a (List.mem_cons_self ..)
    have hrec := ih fun n hn => hl n (List.mem_cons_of_mem a hn)
    rw [List.map_cons, List.sum_cons, List.sum_cons, Nat.cast_add]
    omega

private lemma toNat_pos_of_mem {l : List ℤ} (hl : ∀ n ∈ l, n < 0) {i : ℕ}
    (hi : i ∈ l.map fun n : ℤ => (-n).toNat) : 0 < i := by
  obtain ⟨n, hn, rfl⟩ := List.mem_map.mp hi
  have := hl n hn
  omega

private lemma sum_map_neg_nat (bl : List ℕ) :
    (bl.map fun b : ℕ => -(b : ℤ)).sum = -((bl.sum : ℕ) : ℤ) := by
  induction bl with
  | nil => simp
  | cons a t iht =>
    rw [List.map_cons, List.sum_cons, iht, List.sum_cons]
    push_cast
    ring

private lemma sum_map_neg_multiset (s : Multiset ℕ) :
    (s.map fun b : ℕ => -(b : ℤ)).sum = -((s.sum : ℕ) : ℤ) := by
  induction s using Multiset.induction with
  | empty => simp
  | cons a t iht =>
    rw [Multiset.map_cons, Multiset.sum_cons, iht, Multiset.sum_cons]
    push_cast
    ring

/-- Any word in the negative modes whose modes sum to `-N` lies in the level-`N` subspace. -/
theorem wordAct_mem_levelSpan {l : List ℤ} (hl : ∀ n ∈ l, n < 0) {N : ℕ}
    (hs : l.sum = -(N : ℤ)) : wordAct R c h l (hwv R c h) ∈ levelSpan R c h N := by
  have hblocks : (l.map fun n : ℤ => (-n).toNat).sum = N := by
    have := sum_map_toNat hl
    omega
  refine Submodule.subset_span ⟨⟨l.map fun n : ℤ => (-n).toNat,
    fun hi => toNat_pos_of_mem hl hi, hblocks⟩, ?_⟩
  show wordAct R c h ((l.map fun n : ℤ => (-n).toNat).map fun b : ℕ => -(b : ℤ)) (hwv R c h)
      = wordAct R c h l (hwv R c h)
  rw [map_toNat_map_neg hl]

/-- **The level-`N` subspace is spanned by the ordered words of level `N`.** -/
theorem levelSpan_eq_ordSpan (N : ℕ) : levelSpan R c h N = ordSpan R c h (-(N : ℤ)) := by
  refine le_antisymm ?_ ?_
  · rw [levelSpan, Submodule.span_le]
    rintro x ⟨cmp, rfl⟩
    have hneg : ∀ n ∈ cmp.blocks.map fun b : ℕ => -(b : ℤ), n < 0 := by
      intro n hn
      obtain ⟨b, hb, rfl⟩ := List.mem_map.mp hn
      have := cmp.blocks_pos hb
      omega
    have hsum : (cmp.blocks.map fun b : ℕ => -(b : ℤ)).sum = -(N : ℤ) := by
      rw [sum_map_neg_nat, cmp.blocks_sum]
    have hmem := wordAct_mem_ordSpan R c h hneg
    rwa [hsum] at hmem
  · rw [ordSpan_eq_span, Submodule.span_le]
    rintro x ⟨l, hl, hs, rfl⟩
    exact wordAct_mem_levelSpan R c h hl.neg hs

/-- The ordered word attached to a partition `p` of `N`: with `p = {b_1 ≥ ⋯ ≥ b_k}` it is
`L_{-b_1} ⋯ L_{-b_k} |c,h⟩`. -/
noncomputable def partitionWord (N : ℕ) (p : Nat.Partition N) : VermaModule R c h :=
  wordAct R c h ((p.parts.map fun b : ℕ => -(b : ℤ)).sort (· ≤ ·)) (hwv R c h)

private lemma sort_coe_self {l : List ℤ} (hl : l.Pairwise (· ≤ ·)) :
    ((l : Multiset ℤ)).sort (· ≤ ·) = l := by
  rw [Multiset.coe_sort]
  exact List.mergeSort_eq_self (r := (· ≤ ·)) hl

/-- **`V_N` is spanned by the `p(N)` ordered words attached to the partitions of `N`.** -/
theorem levelSpan_eq_span_range_partitionWord (N : ℕ) :
    levelSpan R c h N = Submodule.span R (Set.range (partitionWord R c h N)) := by
  refine le_antisymm ?_ ?_
  · rw [levelSpan_eq_ordSpan, ordSpan_eq_span, Submodule.span_le]
    rintro x ⟨l, hl, hs, rfl⟩
    have hneg : ∀ n ∈ l, n < 0 := hl.neg
    have hblocks : (l.map fun n : ℤ => (-n).toNat).sum = N := by
      have := sum_map_toNat hneg
      omega
    refine Submodule.subset_span ⟨⟨(l.map fun n : ℤ => (-n).toNat : Multiset ℕ),
      fun hi => toNat_pos_of_mem hneg (Multiset.mem_coe.mp hi), by
        rw [Multiset.sum_coe, hblocks]⟩, ?_⟩
    show wordAct R c h
        ((((l.map fun n : ℤ => (-n).toNat : Multiset ℕ)).map
          fun b : ℕ => -(b : ℤ)).sort (· ≤ ·)) (hwv R c h)
      = wordAct R c h l (hwv R c h)
    congr 1
    rw [Multiset.map_coe, map_toNat_map_neg hneg, sort_coe_self hl.sorted]
  · rw [Submodule.span_le]
    rintro x ⟨p, rfl⟩
    refine wordAct_mem_levelSpan R c h (N := N) ?_ ?_
    · intro n hn
      rw [Multiset.mem_sort] at hn
      obtain ⟨b, hb, rfl⟩ := Multiset.mem_map.mp hn
      have := p.parts_pos hb
      omega
    · have hsum : ((p.parts.map fun b : ℕ => -(b : ℤ)).sort (· ≤ ·)).sum
          = (p.parts.map fun b : ℕ => -(b : ℤ)).sum := by
        rw [← Multiset.sum_coe, Multiset.sort_eq]
      rw [hsum, sum_map_neg_multiset, p.parts_sum]

end Level

/-! ### `dim V_N ≤ p(N)` -/

section Dim

variable (K : Type*) [Field K] [CharZero K] (c h : K)

/-- **`dim V_N ≤ p(N)`.**  The level-`N` subspace of the Verma module has dimension at most the
number of partitions of `N`.

The reverse inequality `dim V_N ≥ p(N)` is *not* proved: it is the linear-independence half of
Poincaré–Birkhoff–Witt, which Mathlib `v4.33.1` does not provide.  In particular this bound is
compatible with `V(c,h) = 0`, which is still not excluded.

Here `p(N)` is `Fintype.card (Nat.Partition N)`; `Nat.Partition N` is Mathlib's type of
partitions of `N` (multisets of positive naturals summing to `N`), so this cardinality *is* the
partition function by definition.  (It is not reducible by `decide`: the `Fintype` instance goes
through `Fintype.ofSurjective` on `Composition N`.) -/
theorem finrank_levelSpan_le_card_partition (N : ℕ) :
    Module.finrank K (levelSpan K c h N) ≤ Fintype.card (Nat.Partition N) := by
  rw [levelSpan_eq_span_range_partitionWord]
  exact finrank_range_le_card (partitionWord K c h N)

end Dim

/-- Sanity check that the bound is usable on a concrete ground field. -/
example (c h : ℚ) (N : ℕ) :
    Module.finrank ℚ (levelSpan ℚ c h N) ≤ Fintype.card (Nat.Partition N) :=
  finrank_levelSpan_le_card_partition ℚ c h N

end StringFormal.Virasoro
