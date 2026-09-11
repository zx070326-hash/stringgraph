/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import Mathlib.Combinatorics.Enumerative.Partition.Basic
import Mathlib.Data.Finset.Card
import Mathlib.Tactic.IntervalCases

/-!
# Cardinality of `Nat.Partition n` for small `n`

Graph node: supporting lemma for `worldsheet.verma-level-basis-generic-low-levels-v2`
(the `dim V_N ≤ p(N)` half lives in `StringFormal/Virasoro/VermaPBW.lean`).
No physics convention is used; this file imports only Mathlib (three modules, no
`import Mathlib`, so that `Virasoro/GenericIndependence.lean` can import it cheaply)
and no other `StringFormal` module.

Mathlib `v4.33.1` has `Nat.Partition` and a `Fintype` instance for it, but **no cardinality
lemmas**: `p(n)` is never computed.  This file closes that gap for `n ≤ 5`, which is exactly
the range needed to instantiate `finrank_levelSpan_le_card_partition`
(`StringFormal/Virasoro/VermaPBW.lean`) at Virasoro levels `N ≤ 5`.

## Why not `decide`

Routes tried, for the record:

* **(c) `decide` / `rfl` directly.**  Fails.  `#eval Fintype.card (Nat.Partition 4)` *does*
  print `5` (the instance is computable), but the kernel/`whnf` route is blocked: the instance
  is `Fintype.ofSurjective (Nat.Partition.ofComposition n) _`, and `Fintype (Composition n)`
  goes through `compositionEquiv` → `CompositionAsSet.blocks` → `Finset.orderEmbOfFin` →
  `Finset.sort` → `List.mergeSort`, which is well-founded recursion and does not reduce.
  The error is the one quoted in `Virasoro/GenericIndependence.lean`: reduction gets stuck at
  `match h : (Fintype.card (Nat.Partition 2)).beq 2 with ...`.
  `native_decide` would work but introduces `Lean.ofReduceBool`, which the project forbids.
* **(d) existing `Nat.Partition` counting lemmas.**  There are none in `v4.33.1`
  (`Mathlib/Combinatorics/Enumerative/Partition/{Basic,GenFun,Glaisher}.lean`);
  `Nat.Partition.toFinsuppAntidiag` is only *injective* into
  `(Finset.Icc 1 n).finsuppAntidiag n`, not bijective — e.g. for `n = 2` the antidiagonal has
  `3` elements (`(2,0), (1,1), (0,2)` as values on `{1,2}`) against `p(2) = 2`, because
  `(1,1)` is not of the form `i ↦ count i * i`.  So that Finset cannot be used to count.
* **(a)/(b), taken here.**  Transport the count to an explicit `Finset (Multiset ℕ)` literal
  (`card_partition_eq_card`), which *is* `decide`-friendly (`DecidableEq (Multiset ℕ)` reduces
  through `List.decidablePerm`), and prove the exhaustiveness of that literal by peeling one
  part off at a time (`exists_cons_of_sum_succ`) and recursing on the total.

## Main results

* `StringFormal.Math.card_partition_eq_card`: the reusable bridge — if `F : Finset (Multiset ℕ)`
  contains exactly the multisets of positive naturals summing to `n`, then
  `Fintype.card (Nat.Partition n) = F.card`.  Independent of the `Fintype` instance in the
  sense that it is proved from `Finset.card_bij`, not from the instance's definition.
* `StringFormal.Math.multiset_sum_eq_two`, `..._three`, `..._four`, `..._five`: the explicit
  classification of multisets of positive naturals with a given small sum (unordered, so e.g.
  `{2, 1}` absorbs both peelings `1 ::ₘ {2}` and `2 ::ₘ {1}`).
* `StringFormal.Math.card_partition_two`, `card_partition_three`, `card_partition_four`,
  `card_partition_five`: `p(2) = 2`, `p(3) = 3`, `p(4) = 5`, `p(5) = 7`.
-/

namespace StringFormal.Math

/-- A multiset of naturals with sum `0` and positive entries is empty. -/
theorem multiset_eq_zero_of_sum_eq_zero {s : Multiset ℕ} (hsum : s.sum = 0)
    (hpos : ∀ i ∈ s, 0 < i) : s = 0 := by
  refine Multiset.eq_zero_of_forall_notMem fun x hx => ?_
  have h1 : 0 < x := hpos x hx
  have h2 : x ≤ s.sum := Multiset.le_sum_of_mem hx
  omega

/-- Peel one part off a multiset of positive naturals with positive sum.  This is the induction
step of the classifications below: the remaining multiset has the same shape with a strictly
smaller sum. -/
theorem exists_cons_of_sum_succ {s : Multiset ℕ} (hpos : ∀ i ∈ s, 0 < i) {n : ℕ}
    (hsum : s.sum = n + 1) :
    ∃ a t, s = a ::ₘ t ∧ 1 ≤ a ∧ a ≤ n + 1 ∧ (∀ i ∈ t, 0 < i) ∧ t.sum = n + 1 - a := by
  have hs : s ≠ 0 := by
    intro h
    rw [h] at hsum
    simp at hsum
  obtain ⟨a, ha⟩ := Multiset.exists_mem_of_ne_zero hs
  obtain ⟨t, rfl⟩ := Multiset.exists_cons_of_mem ha
  have h1 : 1 ≤ a := hpos a ha
  have h2 : a + t.sum = n + 1 := by simpa using hsum
  exact ⟨a, t, rfl, h1, by omega, fun i hi => hpos i (Multiset.mem_cons_of_mem hi), by omega⟩

/-- The unique multiset of positive naturals with sum `1`. -/
theorem multiset_sum_eq_one {s : Multiset ℕ} (hpos : ∀ i ∈ s, 0 < i) (hsum : s.sum = 1) :
    s = {1} := by
  obtain ⟨a, t, rfl, h1, h2, hpt, hts⟩ := exists_cons_of_sum_succ hpos (n := 0) hsum
  interval_cases a
  rw [multiset_eq_zero_of_sum_eq_zero (by omega) hpt]
  decide

/-- The two multisets of positive naturals with sum `2`: `{2}` and `{1, 1}`. -/
theorem multiset_sum_eq_two {s : Multiset ℕ} (hpos : ∀ i ∈ s, 0 < i) (hsum : s.sum = 2) :
    s = {2} ∨ s = {1, 1} := by
  obtain ⟨a, t, rfl, h1, h2, hpt, hts⟩ := exists_cons_of_sum_succ hpos (n := 1) hsum
  interval_cases a
  · rw [multiset_sum_eq_one hpt (by omega)]; decide
  · rw [multiset_eq_zero_of_sum_eq_zero (by omega) hpt]; decide

/-- The three multisets of positive naturals with sum `3`. -/
theorem multiset_sum_eq_three {s : Multiset ℕ} (hpos : ∀ i ∈ s, 0 < i) (hsum : s.sum = 3) :
    s = {3} ∨ s = {2, 1} ∨ s = {1, 1, 1} := by
  obtain ⟨a, t, rfl, h1, h2, hpt, hts⟩ := exists_cons_of_sum_succ hpos (n := 2) hsum
  interval_cases a
  · rcases multiset_sum_eq_two hpt (by omega) with rfl | rfl <;> decide
  · rw [multiset_sum_eq_one hpt (by omega)]; decide
  · rw [multiset_eq_zero_of_sum_eq_zero (by omega) hpt]; decide

/-- The five multisets of positive naturals with sum `4`. -/
theorem multiset_sum_eq_four {s : Multiset ℕ} (hpos : ∀ i ∈ s, 0 < i) (hsum : s.sum = 4) :
    s = {4} ∨ s = {3, 1} ∨ s = {2, 2} ∨ s = {2, 1, 1} ∨ s = {1, 1, 1, 1} := by
  obtain ⟨a, t, rfl, h1, h2, hpt, hts⟩ := exists_cons_of_sum_succ hpos (n := 3) hsum
  interval_cases a
  · rcases multiset_sum_eq_three hpt (by omega) with rfl | rfl | rfl <;> decide
  · rcases multiset_sum_eq_two hpt (by omega) with rfl | rfl <;> decide
  · rw [multiset_sum_eq_one hpt (by omega)]; decide
  · rw [multiset_eq_zero_of_sum_eq_zero (by omega) hpt]; decide

/-- The seven multisets of positive naturals with sum `5`. -/
theorem multiset_sum_eq_five {s : Multiset ℕ} (hpos : ∀ i ∈ s, 0 < i) (hsum : s.sum = 5) :
    s = {5} ∨ s = {4, 1} ∨ s = {3, 2} ∨ s = {3, 1, 1} ∨ s = {2, 2, 1} ∨ s = {2, 1, 1, 1} ∨
      s = {1, 1, 1, 1, 1} := by
  obtain ⟨a, t, rfl, h1, h2, hpt, hts⟩ := exists_cons_of_sum_succ hpos (n := 4) hsum
  interval_cases a
  · rcases multiset_sum_eq_four hpt (by omega) with rfl | rfl | rfl | rfl | rfl <;> decide
  · rcases multiset_sum_eq_three hpt (by omega) with rfl | rfl | rfl <;> decide
  · rcases multiset_sum_eq_two hpt (by omega) with rfl | rfl <;> decide
  · rw [multiset_sum_eq_one hpt (by omega)]; decide
  · rw [multiset_eq_zero_of_sum_eq_zero (by omega) hpt]; decide

/-- **Bridge.**  If `F` lists exactly the multisets of positive naturals summing to `n`, then
`Fintype.card (Nat.Partition n) = F.card`.  Use this to move a `Nat.Partition` count onto an
explicit `Finset (Multiset ℕ)` literal, where `decide` works. -/
theorem card_partition_eq_card (n : ℕ) (F : Finset (Multiset ℕ))
    (hF : ∀ s : Multiset ℕ, s ∈ F ↔ ((∀ i ∈ s, 0 < i) ∧ s.sum = n)) :
    Fintype.card (Nat.Partition n) = F.card := by
  rw [← Finset.card_univ]
  refine Finset.card_bij (fun p _ => p.parts) ?_ ?_ ?_
  · intro p _
    exact (hF p.parts).2 ⟨fun _ hi => p.parts_pos hi, p.parts_sum⟩
  · intro p _ q _ h
    exact Nat.Partition.ext h
  · intro s hs
    obtain ⟨hpos, hsum⟩ := (hF s).1 hs
    exact ⟨⟨s, fun {i} hi => hpos i hi, hsum⟩, Finset.mem_univ _, rfl⟩

/-- `p(2) = 2`. -/
theorem card_partition_two : Fintype.card (Nat.Partition 2) = 2 := by
  have hF : ∀ s : Multiset ℕ, s ∈ ({{2}, {1, 1}} : Finset (Multiset ℕ)) ↔
      ((∀ i ∈ s, 0 < i) ∧ s.sum = 2) := by
    have hback : ∀ s ∈ ({{2}, {1, 1}} : Finset (Multiset ℕ)), (∀ i ∈ s, 0 < i) ∧ s.sum = 2 := by
      decide
    refine fun s => ⟨hback s, fun h => ?_⟩
    simpa using multiset_sum_eq_two h.1 h.2
  rw [card_partition_eq_card 2 _ hF]
  decide

/-- `p(3) = 3`. -/
theorem card_partition_three : Fintype.card (Nat.Partition 3) = 3 := by
  have hF : ∀ s : Multiset ℕ, s ∈ ({{3}, {2, 1}, {1, 1, 1}} : Finset (Multiset ℕ)) ↔
      ((∀ i ∈ s, 0 < i) ∧ s.sum = 3) := by
    have hback : ∀ s ∈ ({{3}, {2, 1}, {1, 1, 1}} : Finset (Multiset ℕ)),
        (∀ i ∈ s, 0 < i) ∧ s.sum = 3 := by decide
    refine fun s => ⟨hback s, fun h => ?_⟩
    simpa using multiset_sum_eq_three h.1 h.2
  rw [card_partition_eq_card 3 _ hF]
  decide

/-- `p(4) = 5`. -/
theorem card_partition_four : Fintype.card (Nat.Partition 4) = 5 := by
  have hF : ∀ s : Multiset ℕ,
      s ∈ ({{4}, {3, 1}, {2, 2}, {2, 1, 1}, {1, 1, 1, 1}} : Finset (Multiset ℕ)) ↔
      ((∀ i ∈ s, 0 < i) ∧ s.sum = 4) := by
    have hback : ∀ s ∈ ({{4}, {3, 1}, {2, 2}, {2, 1, 1}, {1, 1, 1, 1}} : Finset (Multiset ℕ)),
        (∀ i ∈ s, 0 < i) ∧ s.sum = 4 := by decide
    refine fun s => ⟨hback s, fun h => ?_⟩
    simpa using multiset_sum_eq_four h.1 h.2
  rw [card_partition_eq_card 4 _ hF]
  decide

/-- `p(5) = 7`. -/
theorem card_partition_five : Fintype.card (Nat.Partition 5) = 7 := by
  have hF : ∀ s : Multiset ℕ,
      s ∈ ({{5}, {4, 1}, {3, 2}, {3, 1, 1}, {2, 2, 1}, {2, 1, 1, 1},
        {1, 1, 1, 1, 1}} : Finset (Multiset ℕ)) ↔
      ((∀ i ∈ s, 0 < i) ∧ s.sum = 5) := by
    have hback : ∀ s ∈ ({{5}, {4, 1}, {3, 2}, {3, 1, 1}, {2, 2, 1}, {2, 1, 1, 1},
        {1, 1, 1, 1, 1}} : Finset (Multiset ℕ)), (∀ i ∈ s, 0 < i) ∧ s.sum = 5 := by decide
    refine fun s => ⟨hback s, fun h => ?_⟩
    simpa using multiset_sum_eq_five h.1 h.2
  rw [card_partition_eq_card 5 _ hF]
  decide

end StringFormal.Math
