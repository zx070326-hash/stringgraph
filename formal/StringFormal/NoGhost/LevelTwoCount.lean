/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.NullSeedsTwo
import StringFormal.NoGhost.SliceDim
import StringFormal.NoGhost.SpuriousElimination
import Mathlib.Data.Sym.Card

/-!
# Counting at level two: `p_{D−1}(2) = p_{D−2}(2) + D`

Graph node: `worldsheet.ddf-spanning-rank-inequality` (the `(B-26)` gap).  This is the
*counting* half of blueprint §B″'s `PR5b` → `B26 2`; the *operator* half (the two families of
null states and the equation `L_2 𝒟₂ φ = (D − 26) φ`) is `NoGhost/NullSeedsTwo.lean`.

## Why this file exists

`SliceRank.B26 N` compares three dimensions on the antidiagonal slice
`V_N = towerBigrade (-N) N`:

```
dim (H_phys ⊓ V_N)  ≤  dim (ddfSpan ⊓ V_N)  +  dim (H_null ⊓ V_N) .
```

PR4 bounds the left side by `p_{D−1}(N)` and PR2 computes the first right-hand term as
`p_{D−2}(N)`, both as cardinalities of `Finsupp` index sets that are deliberately *never
evaluated* (blueprint §B′.8).  To close `B26 2` those two cardinalities must finally be
compared.  `decide` is hopeless on `Osc D →₀ ℕ` (same wall as `Math/PartitionCard.lean`), so
the comparison is done by an explicit classification of the level-two occupation functions.

## Main results

* `Finsupp.oscWeight_eq_two_cases` — **the classification**: an occupation function of level
  two is either `single (i, 2) 1` or `single (i, 1) 1 + single (j, 1) 1`.  Stated for an
  arbitrary index type `ι`, so that it serves both the `p_{D−1}` and the `p_{D−2}` side.
* `card_ddfLevel_two_ge` — `p_{m}(2) ≥ m + (m+1).choose 2` for `m = Fintype.card ι`
  (an injection `ι ⊕ Sym2 ι ↪ {d | N(d) = 2}`; only the lower bound is needed).
* `card_conjFree_two_le` — `p_{D−1}(2) ≤ (D−1) + D.choose 2` (a surjection
  `κ ⊕ Sym2 κ ↠ {d | level d = 2 ∧ β(d) = 0}` with `κ = {μ | μ ≠ b̃}`; only the upper bound is
  needed).
* `levelTwo_count_identity` — the arithmetic identity
  `(D−1) + D.choose 2 = (D−2) + (D−1).choose 2 + D` for `2 ≤ D`; equivalently
  `p_{D−1}(2) − p_{D−2}(2) = D`.  It is a **Pascal identity**, valid for every `D`: the
  critical dimension does **not** enter the counting.

## Where `D = 26` is (not)

Nowhere in this file.  The identity `p_{D−1}(2) = p_{D−2}(2) + D` holds for every `D`; what
`D = 26` buys is that the `D` extra dimensions are actually realised by *null* states, and
that is `NoGhost/NullSeedsTwo.lean`'s `descTwo` (the `L_2 𝒟₂ φ = (D − 26) φ` equation).  So at
`D ≠ 26` one has only `D − 1` null states at level two and `B26 2` fails by exactly one — see
the note in `formal/TODO.md`.

## Conventions

`Osc D = Fin D × ℕ+`; `Fock.level D = Finsupp.weight (oscLevel D)` and
`DDFGram.ddfLevel` are the same function up to `mul_comm`, which is `ddfLevel_eq_oscWeight`
below.  `conjIdx D hD = ⟨1, _⟩` is the `b̃` row of the light-cone direction table.

## Status

See the module docstring of the sections below for what is and is not proved.
-/

namespace StringFormal.NoGhost

open Module

/-! ### The classification of level-two occupation functions

Everything in this section is about `Finsupp`s on `ι × ℕ+` and has no string-theoretic
content.  `oscWeight d = Σ_{(i,n)} n · d(i,n)` is the common shape of `Fock.level` and
`DDFGram.ddfLevel`. -/

namespace Finsupp

variable {ι : Type*}

/-- `Σ_{(i,n)} n · d(i,n)`: the weight function shared by `Fock.level` (on `Osc D`) and
`NoGhost.ddfLevel` (on `ι × ℕ+`). -/
noncomputable def oscWeight (d : (ι × ℕ+) →₀ ℕ) : ℕ :=
  Finsupp.weight (fun v : ι × ℕ+ => (v.2 : ℕ)) d

lemma oscWeight_apply (d : (ι × ℕ+) →₀ ℕ) :
    oscWeight d = d.sum fun v k => k * (v.2 : ℕ) :=
  Finsupp.weight_apply _ _

@[simp]
lemma oscWeight_single (v : ι × ℕ+) (k : ℕ) :
    oscWeight (Finsupp.single v k) = k * (v.2 : ℕ) :=
  Finsupp.weight_single _ _ _

@[simp]
lemma oscWeight_add (d e : (ι × ℕ+) →₀ ℕ) :
    oscWeight (d + e) = oscWeight d + oscWeight e :=
  map_add _ _ _

@[simp]
lemma oscWeight_zero : oscWeight (0 : (ι × ℕ+) →₀ ℕ) = 0 := map_zero _

/-- The support of an occupation function is no bigger than its weight: every occupied mode
contributes at least `1`. -/
lemma card_support_le_oscWeight (d : (ι × ℕ+) →₀ ℕ) : d.support.card ≤ oscWeight d := by
  classical
  rw [oscWeight_apply, Finsupp.sum]
  calc d.support.card = ∑ _v ∈ d.support, 1 := by simp
    _ ≤ ∑ v ∈ d.support, d v * (v.2 : ℕ) := by
        refine Finset.sum_le_sum fun v hv => ?_
        have h1 : 1 ≤ d v := Nat.one_le_iff_ne_zero.2 (Finsupp.mem_support_iff.1 hv)
        have h2 : 1 ≤ (v.2 : ℕ) := v.2.2
        calc 1 = 1 * 1 := by ring
          _ ≤ d v * (v.2 : ℕ) := Nat.mul_le_mul h1 h2

/-- A single occupied mode carries at least its own mode number. -/
lemma le_oscWeight_of_mem_support {d : (ι × ℕ+) →₀ ℕ} {v : ι × ℕ+} (hv : v ∈ d.support) :
    d v * (v.2 : ℕ) ≤ oscWeight d := by
  classical
  rw [oscWeight_apply, Finsupp.sum]
  exact Finset.single_le_sum (f := fun u : ι × ℕ+ => d u * (u.2 : ℕ))
    (fun _ _ => Nat.zero_le _) hv

/-- **The classification of level-two occupation functions.**

`oscWeight d = 2` leaves exactly two shapes: a single mode-`2` excitation, or a pair of
mode-`1` excitations (possibly equal, which is the doubly occupied case).  This is the
combinatorial content of `p_m(2) = m + binom(m+1, 2)` and the only place where the
level-two-ness is unfolded. -/
theorem oscWeight_eq_two_cases {d : (ι × ℕ+) →₀ ℕ} (h : oscWeight d = 2) :
    (∃ i : ι, d = Finsupp.single (i, 2) 1) ∨
      (∃ i j : ι, d = Finsupp.single (i, 1) 1 + Finsupp.single (j, 1) 1) := by
  classical
  have hcard : d.support.card ≤ 2 := h ▸ card_support_le_oscWeight d
  interval_cases hc : d.support.card
  · exfalso
    rw [Finset.card_eq_zero, Finsupp.support_eq_empty] at hc
    rw [hc] at h; simp at h
  · -- one occupied mode: `k · n = 2`
    obtain ⟨v, hv⟩ := Finset.card_eq_one.1 hc
    have hdv : d v ≠ 0 := Finsupp.mem_support_iff.1 (hv ▸ Finset.mem_singleton_self v)
    have hd : d = Finsupp.single v (d v) := (Finsupp.support_eq_singleton.1 hv).2
    have hw : d v * (v.2 : ℕ) = 2 := by
      rw [← h, hd, oscWeight_single, Finsupp.single_eq_same]
    have hb1 : 1 ≤ d v := Nat.one_le_iff_ne_zero.2 hdv
    have hb2 : 1 ≤ (v.2 : ℕ) := v.2.2
    rcases Nat.eq_or_lt_of_le hb1 with h' | h'
    · -- one mode-`2` excitation
      left
      rw [← h', one_mul] at hw
      have hv2 : v = (v.1, 2) := Prod.ext rfl (PNat.coe_injective (by simpa using hw))
      exact ⟨v.1, by rw [hd, ← h', ← hv2]⟩
    · -- one mode-`1` excitation, doubly occupied
      right
      have h2' : (v.2 : ℕ) = 1 := by
        by_contra hne
        have hge : 2 ≤ (v.2 : ℕ) := by omega
        have : 4 ≤ d v * (v.2 : ℕ) := Nat.mul_le_mul (show 2 ≤ d v by omega) hge
        rw [hw] at this; omega
      rw [h2', mul_one] at hw
      have hv1 : v = (v.1, 1) := Prod.ext rfl (PNat.coe_injective (by simpa using h2'))
      exact ⟨v.1, v.1, by rw [hd, hw, ← hv1, ← Finsupp.single_add]⟩
  · -- two occupied modes, each of weight one
    obtain ⟨v, w, hvw, hs⟩ := Finset.card_eq_two.1 hc
    have hdv : d v ≠ 0 :=
      Finsupp.mem_support_iff.1 (hs ▸ Finset.mem_insert_self v {w})
    have hdw : d w ≠ 0 :=
      Finsupp.mem_support_iff.1 (hs ▸ Finset.mem_insert_of_mem (Finset.mem_singleton_self w))
    have hsum : d v * (v.2 : ℕ) + d w * (w.2 : ℕ) = 2 := by
      rw [← h, oscWeight_apply, Finsupp.sum, hs, Finset.sum_insert (by simpa using hvw),
        Finset.sum_singleton]
    have hbv1 : 1 ≤ d v := Nat.one_le_iff_ne_zero.2 hdv
    have hbv2 : 1 ≤ (v.2 : ℕ) := v.2.2
    have hbw1 : 1 ≤ d w := Nat.one_le_iff_ne_zero.2 hdw
    have hbw2 : 1 ≤ (w.2 : ℕ) := w.2.2
    have hprodv : 1 ≤ d v * (v.2 : ℕ) := Nat.one_le_iff_ne_zero.2 (by positivity)
    have hprodw : 1 ≤ d w * (w.2 : ℕ) := Nat.one_le_iff_ne_zero.2 (by positivity)
    have hv1 : d v * (v.2 : ℕ) = 1 := by omega
    have hw1 : d w * (w.2 : ℕ) = 1 := by omega
    have hdv1 : d v = 1 := Nat.eq_one_of_mul_eq_one_right hv1
    have hdw1 : d w = 1 := Nat.eq_one_of_mul_eq_one_right hw1
    have hv2 : (v.2 : ℕ) = 1 := Nat.eq_one_of_mul_eq_one_left hv1
    have hw2 : (w.2 : ℕ) = 1 := Nat.eq_one_of_mul_eq_one_left hw1
    have hve : v = (v.1, 1) := Prod.ext rfl (PNat.coe_injective (by simpa using hv2))
    have hwe : w = (w.1, 1) := Prod.ext rfl (PNat.coe_injective (by simpa using hw2))
    right
    refine ⟨v.1, w.1, Finsupp.ext fun x => ?_⟩
    rw [Finsupp.add_apply, Finsupp.single_apply, Finsupp.single_apply, ← hve, ← hwe]
    by_cases hxv : v = x
    · rw [if_pos hxv, if_neg (fun hcc => hvw (hxv.trans hcc.symm)), ← hxv, hdv1]
      omega
    · by_cases hxw : w = x
      · rw [if_neg hxv, if_pos hxw, ← hxw, hdw1]
      · have hx0 : d x = 0 := by
          by_contra hne
          have hmem := Finsupp.mem_support_iff.2 hne
          rw [hs] at hmem
          rcases Finset.mem_insert.1 hmem with h' | h'
          · exact hxv h'.symm
          · exact hxw (Finset.mem_singleton.1 h').symm
        rw [if_neg hxv, if_neg hxw, hx0]
        omega

end Finsupp

/-! ### The two index families of level two

`ι ⊕ Sym2 ι` indexes the level-two occupation functions on `ι` directions: the left summand is
the single mode-`2` excitation `α^i_{-2}`, the right summand the unordered pair
`α^i_{-1} α^j_{-1}`.  The classification says the parametrisation is onto, and an easy
cancellation argument says it is injective; the two halves are used on opposite sides of
`B26 2`, so they are stated separately. -/

section Index

variable (ι : Type*)

/-- The level-two occupation function attached to an index: `α^i_{-2}` on the left summand,
`α^i_{-1} α^j_{-1}` on the right.  Well defined on `Sym2` because the two creation operators
commute (`add_comm`). -/
noncomputable def levelTwoIndex : ι ⊕ Sym2 ι → ((ι × ℕ+) →₀ ℕ)
  | Sum.inl i => Finsupp.single (i, 2) 1
  | Sum.inr s =>
      Sym2.lift ⟨fun i j =>
          Finsupp.single ((i, 1) : ι × ℕ+) 1 + Finsupp.single ((j, 1) : ι × ℕ+) 1,
        fun i j => add_comm _ _⟩ s

variable {ι}

@[simp]
lemma levelTwoIndex_inl (i : ι) : levelTwoIndex ι (Sum.inl i) = Finsupp.single (i, 2) 1 := rfl

@[simp]
lemma levelTwoIndex_inr (i j : ι) :
    levelTwoIndex ι (Sum.inr s(i, j))
      = Finsupp.single ((i, 1) : ι × ℕ+) 1 + Finsupp.single ((j, 1) : ι × ℕ+) 1 :=
  Sym2.lift_mk _ _ _

/-- Mode one and mode two are different oscillators. -/
lemma osc_one_ne_two (i j : ι) : ((i, 1) : ι × ℕ+) ≠ (j, 2) := by
  have h12 : ((1 : ℕ+) = 2) → False := by decide
  exact fun h => h12 (congrArg Prod.snd h)

/-- Every index really does name a level-two occupation function. -/
lemma oscWeight_levelTwoIndex (x : ι ⊕ Sym2 ι) :
    Finsupp.oscWeight (levelTwoIndex ι x) = 2 := by
  cases x with
  | inl i => simp
  | inr s => induction s using Sym2.ind with | _ i j => simp

/-- **The parametrisation is injective.**  For two mode-one excitations this is cancellation:
if the two unordered pairs share an element, deleting it identifies the other. -/
lemma levelTwoIndex_injective : Function.Injective (levelTwoIndex ι) := by
  classical
  have hne : (1 : ℕ) ≠ 0 := one_ne_zero
  have key : ∀ i k l : ι,
      levelTwoIndex ι (Sum.inl i) ≠ levelTwoIndex ι (Sum.inr s(k, l)) := by
    intro i k l heq
    rw [levelTwoIndex_inl, levelTwoIndex_inr] at heq
    have h1 := DFunLike.congr_fun heq ((i, 2) : ι × ℕ+)
    have hk0 : (Finsupp.single ((k, 1) : ι × ℕ+) (1 : ℕ)) ((i, 2) : ι × ℕ+) = 0 :=
      Finsupp.single_eq_of_ne (osc_one_ne_two k i).symm
    have hl0 : (Finsupp.single ((l, 1) : ι × ℕ+) (1 : ℕ)) ((i, 2) : ι × ℕ+) = 0 :=
      Finsupp.single_eq_of_ne (osc_one_ne_two l i).symm
    rw [Finsupp.single_eq_same, Finsupp.add_apply, hk0, hl0] at h1
    exact absurd h1 (by norm_num)
  rintro (i | s) (k | t) heq
  · have hik : ((i, 2) : ι × ℕ+) = (k, 2) :=
      Finsupp.single_left_injective hne (by simpa using heq)
    simp only [Prod.mk.injEq] at hik
    rw [hik.1]
  · exact absurd heq (by induction t using Sym2.ind with | _ k l => exact key i k l)
  · exact absurd heq.symm (by induction s using Sym2.ind with | _ i j => exact key k i j)
  · induction s using Sym2.ind with
    | _ i j =>
      induction t using Sym2.ind with
      | _ k l =>
        rw [levelTwoIndex_inr, levelTwoIndex_inr] at heq
        -- the left-hand pair occupies `(i, 1)`, so the right-hand pair must contain `i`
        have hmem : k = i ∨ l = i := by
          by_contra hcon
          have hk : ((k, 1) : ι × ℕ+) ≠ (i, 1) := fun h => hcon (Or.inl (congrArg Prod.fst h))
          have hl : ((l, 1) : ι × ℕ+) ≠ (i, 1) := fun h => hcon (Or.inr (congrArg Prod.fst h))
          have h1 := DFunLike.congr_fun heq ((i, 1) : ι × ℕ+)
          have hk0 : (Finsupp.single ((k, 1) : ι × ℕ+) (1 : ℕ)) ((i, 1) : ι × ℕ+) = 0 :=
            Finsupp.single_eq_of_ne hk.symm
          have hl0 : (Finsupp.single ((l, 1) : ι × ℕ+) (1 : ℕ)) ((i, 1) : ι × ℕ+) = 0 :=
            Finsupp.single_eq_of_ne hl.symm
          rw [Finsupp.add_apply, Finsupp.add_apply, Finsupp.single_eq_same, hk0, hl0] at h1
          omega
        rcases hmem with rfl | rfl
        · have hs : Finsupp.single ((j, 1) : ι × ℕ+) 1 = Finsupp.single ((l, 1) : ι × ℕ+) 1 :=
            add_left_cancel heq
          have hjl : ((j, 1) : ι × ℕ+) = (l, 1) := Finsupp.single_left_injective hne hs
          simp only [Prod.mk.injEq] at hjl
          rw [hjl.1]
        · rw [add_comm (Finsupp.single ((k, 1) : ι × ℕ+) 1)] at heq
          have hs : Finsupp.single ((j, 1) : ι × ℕ+) 1 = Finsupp.single ((k, 1) : ι × ℕ+) 1 :=
            add_left_cancel heq
          have hjk : ((j, 1) : ι × ℕ+) = (k, 1) := Finsupp.single_left_injective hne hs
          simp only [Prod.mk.injEq] at hjk
          rw [hjk.1, Sym2.eq_swap]

end Index

/-! ### The two cardinalities of `B26 2`

`SliceDim.finrank_ddfSpan_inf_towerBigrade` computes `dim (ddfSpan ⊓ V_N)` as the number of
level-`N` DDF occupation functions and `SpuriousElimination.finrank_towerPhys_inf_towerBigrade_le`
bounds `dim (H_phys ⊓ V_N)` by the number of `b̃`-free level-`N` light-cone occupation
functions.  At `N = 2` these are `p_{D−2}(2)` and `p_{D−1}(2)`, and only now do they have to be
evaluated.  Only one inequality is needed on each side, so only a surjection resp. an injection
is produced. -/

section Cardinalities

/-- `ddfLevel` is `oscWeight` (the two differ by `mul_comm` inside the sum). -/
lemma ddfLevel_eq_oscWeight {ι : Type*} (d : (ι × ℕ+) →₀ ℕ) :
    ddfLevel d = Finsupp.oscWeight d := by
  rw [ddfLevel, Finsupp.oscWeight_apply, Finsupp.sum, Finsupp.sum]
  exact Finset.sum_congr rfl fun v _ => mul_comm _ _

/-- `Fock.level` is `oscWeight` on `Osc D = Fin D × ℕ+`. -/
lemma level_eq_oscWeight {D : ℕ} (d : Osc D →₀ ℕ) :
    Fock.level D d = Finsupp.oscWeight d := rfl

/-- **`p_m(2) ≥ m + binom(m+1, 2)`** where `m = #ι`: the level-two DDF occupation functions are
at least as many as the indices `ι ⊕ Sym2 ι`.  This is the lower bound on
`dim (ddfSpan ⊓ V_2)` needed by `B26 2`; equality holds but is not needed. -/
theorem card_ddfLevel_two_ge (ι : Type*) [Fintype ι] [DecidableEq ι] :
    Fintype.card ι + Nat.choose (Fintype.card ι + 1) 2
      ≤ Fintype.card {d : (ι × ℕ+) →₀ ℕ // ddfLevel d = 2} := by
  classical
  have hcard : Fintype.card (ι ⊕ Sym2 ι) = Fintype.card ι + Nat.choose (Fintype.card ι + 1) 2 := by
    rw [Fintype.card_sum, Sym2.card]
  rw [← hcard]
  refine Fintype.card_le_of_injective
    (fun x => (⟨levelTwoIndex ι x, ?_⟩ : {d : (ι × ℕ+) →₀ ℕ // ddfLevel d = 2})) ?_
  · rw [ddfLevel_eq_oscWeight]; exact oscWeight_levelTwoIndex x
  · intro x y hxy
    exact levelTwoIndex_injective (congrArg Subtype.val hxy)

variable {D : ℕ}

/-- The level-two `b̃`-free light-cone occupation functions, parametrised by the directions
other than `b̃`.  (The `b` direction *is* allowed here: `conjFree` only forbids `b̃`.) -/
noncomputable def conjFreeIndexTwo (hD : 2 ≤ D) :
    {μ : Fin D // μ ≠ conjIdx D hD} ⊕ Sym2 {μ : Fin D // μ ≠ conjIdx D hD} → (Osc D →₀ ℕ)
  | Sum.inl μ => Finsupp.single (((μ : Fin D), 2) : Osc D) 1
  | Sum.inr s =>
      Sym2.lift ⟨fun μ ν : {μ : Fin D // μ ≠ conjIdx D hD} =>
            Finsupp.single (((μ : Fin D), 1) : Osc D) 1
              + Finsupp.single (((ν : Fin D), 1) : Osc D) 1,
        fun μ ν => add_comm _ _⟩ s

@[simp]
lemma conjFreeIndexTwo_inl (hD : 2 ≤ D) (μ : {μ : Fin D // μ ≠ conjIdx D hD}) :
    conjFreeIndexTwo hD (Sum.inl μ) = Finsupp.single (((μ : Fin D), 2) : Osc D) 1 := rfl

@[simp]
lemma conjFreeIndexTwo_inr (hD : 2 ≤ D) (μ ν : {μ : Fin D // μ ≠ conjIdx D hD}) :
    conjFreeIndexTwo hD (Sum.inr s(μ, ν))
      = Finsupp.single (((μ : Fin D), 1) : Osc D) 1
        + Finsupp.single (((ν : Fin D), 1) : Osc D) 1 :=
  Sym2.lift_mk _ _ _

lemma level_conjFreeIndexTwo (hD : 2 ≤ D) (x) : Fock.level D (conjFreeIndexTwo hD x) = 2 := by
  cases x with
  | inl μ => simp [level_eq_oscWeight]
  | inr s => induction s using Sym2.ind with | _ μ ν => simp [level_eq_oscWeight]

lemma conjDeg_conjFreeIndexTwo (hD : 2 ≤ D) (x) : conjDeg hD (conjFreeIndexTwo hD x) = 0 := by
  cases x with
  | inl μ => simpa using conjDeg_single_of_ne hD (v := (((μ : Fin D), 2) : Osc D)) μ.2 1
  | inr s =>
      induction s using Sym2.ind with
      | _ μ ν =>
        rw [conjFreeIndexTwo_inr, conjDeg_add,
          conjDeg_single_of_ne hD (v := (((μ : Fin D), 1) : Osc D)) μ.2 1,
          conjDeg_single_of_ne hD (v := (((ν : Fin D), 1) : Osc D)) ν.2 1]

/-- **`p_{D−1}(2) ≤ (D−1) + binom(D, 2)`**: the classification says the parametrisation
`conjFreeIndexTwo` is onto the `b̃`-free level-two occupation functions.  This is the upper
bound on `dim (H_phys ⊓ V_2)` needed by `B26 2`; equality holds but is not needed. -/
theorem card_conjFree_two_le (hD : 2 ≤ D) :
    Fintype.card {d : Osc D →₀ ℕ // Fock.level D d = 2 ∧ conjDeg hD d = 0}
      ≤ (D - 1) + Nat.choose D 2 := by
  classical
  have hκ : Fintype.card {μ : Fin D // μ ≠ conjIdx D hD} = D - 1 := by
    rw [Fintype.card_subtype_compl, Fintype.card_subtype_eq, Fintype.card_fin]
  have hcard : Fintype.card
      ({μ : Fin D // μ ≠ conjIdx D hD} ⊕ Sym2 {μ : Fin D // μ ≠ conjIdx D hD})
      = (D - 1) + Nat.choose D 2 := by
    rw [Fintype.card_sum, Sym2.card, hκ]
    congr 2
    omega
  rw [← hcard]
  refine Fintype.card_le_of_surjective
    (fun x => (⟨conjFreeIndexTwo hD x, level_conjFreeIndexTwo hD x,
      conjDeg_conjFreeIndexTwo hD x⟩ :
        {d : Osc D →₀ ℕ // Fock.level D d = 2 ∧ conjDeg hD d = 0})) ?_
  rintro ⟨d, hlvl, hconj⟩
  rcases Finsupp.oscWeight_eq_two_cases (d := d) (by rw [← level_eq_oscWeight]; exact hlvl) with
    ⟨μ, rfl⟩ | ⟨μ, ν, rfl⟩
  · have hμ : μ ≠ conjIdx D hD := by
      intro h
      rw [conjDeg_single, if_pos (by simpa using h)] at hconj
      simp at hconj
    exact ⟨Sum.inl ⟨μ, hμ⟩, rfl⟩
  · rw [conjDeg_add] at hconj
    have hμ : μ ≠ conjIdx D hD := by
      intro h
      rw [conjDeg_single, if_pos (by simpa using h)] at hconj
      simp at hconj
    have hν : ν ≠ conjIdx D hD := by
      intro h
      rw [conjDeg_single (v := ((ν, 1) : Osc D)), if_pos (by simpa using h)] at hconj
      simp at hconj
    exact ⟨Sum.inr s(⟨μ, hμ⟩, ⟨ν, hν⟩), Subtype.ext (conjFreeIndexTwo_inr hD _ _)⟩

/-- **`p_{D−1}(2) = p_{D−2}(2) + D`**, in the form in which `B26 2` consumes it.

This is a **Pascal identity**, true for every `D`: the counting step of Goddard–Thorn at level
two never sees the critical dimension.  What `D = 26` decides is whether the `D` extra
dimensions are spanned by *null* states; see `NoGhost/NullSeedsTwo.lean`. -/
theorem levelTwo_count_identity (hD : 2 ≤ D) :
    (D - 1) + Nat.choose D 2 = ((D - 2) + Nat.choose (D - 1) 2) + D := by
  obtain ⟨m, rfl⟩ : ∃ m, D = m + 2 := ⟨D - 2, by omega⟩
  have hpascal : Nat.choose (m + 2) 2 = Nat.choose (m + 1) 1 + Nat.choose (m + 1) 2 :=
    Nat.choose_succ_succ (m + 1) 1
  rw [Nat.choose_one_right] at hpascal
  have h1 : m + 2 - 1 = m + 1 := by omega
  have h2 : m + 2 - 2 = m := by omega
  rw [h1, h2, hpascal]
  omega

end Cardinalities

end StringFormal.NoGhost
