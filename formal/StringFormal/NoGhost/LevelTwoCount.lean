/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.NullSeedsTwo
import StringFormal.NoGhost.LevelTwoElim
import StringFormal.NoGhost.LightConeResolution
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

/-! ### The counting half of `B26 2`

Combining (P3) `dim (H_phys ⊓ V_2) ≤ p_{D−1}(2)`, (P2) `dim (ddfSpan ⊓ V_2) = p_{D−2}(2)` and
the Pascal identity `p_{D−1}(2) = p_{D−2}(2) + D` leaves exactly one thing to prove:
`dim (H_null ⊓ V_2) ≥ D`.  That is where `D = 26` enters, and it is the content of
`NoGhost/NullSeedsTwo.lean`'s two families. -/

section B26Two

variable {D : ℕ} {K : Type*} [Field K] [LinearOrder K] [IsStrictOrderedRing K] [Algebra ℚ K]
variable {η a b : Fin D → K}

/-- **The physical slice at level two is at most `D` bigger than the DDF sector.**

`dim (H_phys ⊓ V_2) ≤ dim (ddfSpan ⊓ V_2) + D`, for **every** `D ≥ 2` and every light-cone
frame.  All three inputs are `D`-independent:

* (P3) `SpuriousElimination.finrank_towerPhys_inf_towerBigrade_le` and `card_conjFree_two_le`;
* (P2) `SliceDim.finrank_ddfSpan_inf_towerBigrade` and `card_ddfLevel_two_ge`;
* the Pascal identity `levelTwo_count_identity`.

So the whole of `B26 2` is reduced to producing `D` independent *null* states on the slice. -/
theorem finrank_towerPhys_inf_towerBigrade_two_le (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) :
    finrank K ↥(towerPhysSubmodule η a b (invTwo K * Fock.zeroModeSq η a)
        ⊓ towerBigrade D K (-((2 : ℕ) : ℤ)) 2)
      ≤ finrank K ↥(ddfSpan η a b F.hη F.trans ⊓ towerBigrade D K (-((2 : ℕ) : ℤ)) 2) + D := by
  have h1 := finrank_towerPhys_inf_towerBigrade_le (K := K) hD F 2
  have h2 := card_conjFree_two_le (D := D) hD
  have h3 := levelTwo_count_identity (D := D) hD
  have h4 := card_ddfLevel_two_ge (Fin (D - 2))
  rw [finrank_ddfSpan_inf_towerBigrade F.hη F.frame.isotropic F.hba F.trans 2]
  rw [Fintype.card_fin] at h4
  have h5 : (D - 2) + 1 = D - 1 := by omega
  rw [h5] at h4
  omega

/-- **`B26 2` from a lower bound on the null states.**  Blueprint §B″.2: at level two the whole
critical-dimension input is the statement that the null states on the antidiagonal slice have
dimension at least `D`. -/
theorem b26_two_of_finrank_towerNull (hD : 2 ≤ D) (F : DDFLightConeFrame η a b)
    (hnull : D ≤ finrank K ↥(towerNullSubmodule η a b (invTwo K * Fock.zeroModeSq η a)
        ⊓ towerBigrade D K (-((2 : ℕ) : ℤ)) 2)) :
    B26 η a b F.hη F.trans 2 := by
  have h := finrank_towerPhys_inf_towerBigrade_two_le hD F
  exact le_trans h (by omega)

end B26Two

/-! ### Reading off the `α_{-2}` component

The `D` null states of the level-two slice are distinguished by their `α^ν_{-2}` components:
the Type-1 state `L_{-1}(v·α_{-1})|0;p⟩` has component `v`, and the Type-2 state
`𝒟₂|0;p⟩` has component `5p`.  Everything else at level two is a product of two `α_{-1}`'s and
contributes nothing, which is the following lemma. -/

section AlphaTwoCoeff

open MvPolynomial

variable {D : ℕ} {R : Type*} [CommRing R]

/-- **Products of two level-one states have no `α_{-2}` component.**  In the `coeff_mul` sum
over `d + e = single (ν,2) 1` the first index `d` is supported on `(ν,2)` alone, so its level is
`0` or `2`, never `1`.  (Only the left factor needs to be homogeneous of level one.) -/
lemma coeff_single_two_mul_of_mem_levelSubmodule_one {P : Fock D R}
    (hP : P ∈ Fock.levelSubmodule D R 1) (Q : Fock D R) (ν : Fin D) :
    coeff (Finsupp.single ((ν, 2) : Osc D) 1) (P * Q) = 0 := by
  classical
  rw [coeff_mul]
  refine Finset.sum_eq_zero fun x hx => ?_
  rw [Finset.mem_antidiagonal] at hx
  by_cases hd : coeff x.1 P = 0
  · rw [hd, zero_mul]
  · exfalso
    have hlvl : Fock.level D x.1 = 1 := hP hd
    have hzero : ∀ u : Osc D, u ≠ (ν, 2) → x.1 u = 0 := by
      intro u hu
      have h := congrArg (fun f : Osc D →₀ ℕ => f u) hx
      simp only [Finsupp.add_apply] at h
      rw [Finsupp.single_eq_of_ne hu] at h
      omega
    have hsingle : x.1 = Finsupp.single ((ν, 2) : Osc D) (x.1 (ν, 2)) := by
      refine Finsupp.ext fun u => ?_
      by_cases hu : u = (ν, 2)
      · rw [hu, Finsupp.single_eq_same]
      · rw [hzero u hu, Finsupp.single_eq_of_ne hu]
    have h2 : (((2 : ℕ+)) : ℕ) = 2 := rfl
    rw [hsingle, Fock.level_single, Fock.oscLevel_apply, h2] at hlvl
    omega

/-- The `α^ν_{-2}` component of `(e·α_{-2})|k⟩` is `η_ν e^ν`. -/
lemma coeff_single_two_secondState (η e : Fin D → R) (ν : Fin D) :
    coeff (Finsupp.single ((ν, 2) : Osc D) 1) (Fock.secondState η e) = η ν * e ν := by
  classical
  rw [Fock.secondState, coeff_sum, Finset.sum_eq_single ν]
  · rw [coeff_smul, coeff_X, if_pos rfl, smul_eq_mul, mul_one]
  · intro μ _ hμ
    have hne : ¬ (Finsupp.single ((μ, 2) : Osc D) 1 = Finsupp.single ((ν, 2) : Osc D) 1) :=
      fun hc => hμ (congrArg Prod.fst (Finsupp.single_left_injective one_ne_zero hc))
    rw [coeff_smul, coeff_X, if_neg hne, smul_zero]
  · intro h
    exact absurd (Finset.mem_univ ν) h

/-- `α_{-1}·α_{-1}|k⟩` has no `α_{-2}` component. -/
lemma coeff_single_two_traceState (η : Fin D → R) (ν : Fin D) :
    coeff (Finsupp.single ((ν, 2) : Osc D) 1) (Fock.traceState η) = 0 := by
  classical
  rw [Fock.traceState, coeff_sum]
  refine Finset.sum_eq_zero fun μ _ => ?_
  rw [coeff_smul, coeff_single_two_mul_of_mem_levelSubmodule_one
    (Fock.X_mem_levelSubmodule_one μ) _ ν, smul_zero]

/-- The linear functional "`α^ν_{-2}` component on rung `-2`", used to separate the `D` null
states of the level-two slice. -/
noncomputable def alphaTwoCoeff (D : ℕ) (R : Type*) [CommRing R] (ν : Fin D) :
    TowerFock D R →ₗ[R] R :=
  (MvPolynomial.lcoeff (R := R) (Finsupp.single ((ν, 2) : Osc D) 1)).comp
    (Finsupp.lapply (-2 : ℤ))

@[simp]
lemma alphaTwoCoeff_single (ν : Fin D) (P : Fock D R) :
    alphaTwoCoeff D R ν (Finsupp.single (-2 : ℤ) P)
      = coeff (Finsupp.single ((ν, 2) : Osc D) 1) P := by
  simp [alphaTwoCoeff]

end AlphaTwoCoeff

/-! ### The two families of level-two null states, explicitly

Blueprint §B″.2.1.  On the antidiagonal slice `(rung -2, level 2)` the seeds of
`NoGhost/NullSeedsTwo.lean` become concrete vectors, and their `α_{-2}` components are
`e` (Type 1) and `5 p` (Type 2). -/

section States

open MvPolynomial

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] {η a b : Fin D → R}

/-- **The Type-1 level-two state** `L_{-1}((e·α_{-1})|0;p_{-2}⟩)`, on rung `-2`. -/
noncomputable def typeOneTwo (η a b e : Fin D → R) : TowerFock D R :=
  towerLop η a b (-1) (Finsupp.single (-2) (Fock.polState η e))

/-- The explicit form: `(e·α_{-2}) + (e·α_{-1})(p·α_{-1})` on the vacuum of rung `-2`. -/
lemma typeOneTwo_eq (hη : ∀ μ, η μ * η μ = 1) (e : Fin D → R) :
    typeOneTwo η a b e = Finsupp.single (-2) (Fock.secondState η e
      + Fock.polState η e * Fock.polState η (towerMomentum a b (-2))) :=
  towerLop_neg_one_apply_single_polState η a b hη (-2) e

/-- **The `α_{-2}` component of the Type-1 state is `e` itself.** -/
lemma alphaTwoCoeff_typeOneTwo (hη : ∀ μ, η μ * η μ = 1) (e : Fin D → R) (ν : Fin D) :
    alphaTwoCoeff D R ν (typeOneTwo η a b e) = η ν * e ν := by
  rw [typeOneTwo_eq hη, alphaTwoCoeff_single, coeff_add, coeff_single_two_secondState,
    coeff_single_two_mul_of_mem_levelSubmodule_one (Fock.polState_mem_levelSubmodule_one e) _ ν,
    add_zero]

/-- `L_{-2}|0;p⟩ = (p·α_{-2})|0;p⟩ + ½ (α_{-1}·α_{-1})|0;p⟩`, in the `traceState`/`secondState`
notation of `NoGhost/LevelTwo.lean`. -/
lemma Lop_neg_two_apply_one_eq (η p : Fin D → R) :
    Fock.Lop η p (-2) (1 : Fock D R)
      = Fock.secondState η p + invTwo R • Fock.traceState η := by
  rw [Fock.Lop_neg_two_apply_one, Fock.secondState_eq_sum_mode η p]
  congr 1
  rw [Fock.traceState]
  refine congrArg _ (Finset.sum_congr rfl fun μ _ => ?_)
  rw [Fock.mode_neg_one_apply η p, Fock.mode_neg_one_apply_one η p]

/-- **The Type-2 level-two state, explicitly**:
`𝒟₂|0;p⟩ = 5(p·α_{-2}) + (α_{-1}·α_{-1}) + 3(p·α_{-1})²` on the vacuum of rung `-2`.
Blueprint §B″'s correction note (b). -/
lemma descTwo_single_neg_two_eq (hη : ∀ μ, η μ * η μ = 1) :
    descTwo η a b (Finsupp.single (-2) (1 : Fock D R))
      = Finsupp.single (-2) ((5 : R) • Fock.secondState η (towerMomentum a b (-2))
          + Fock.traceState η
          + (3 : R) • (Fock.polState η (towerMomentum a b (-2))
              * Fock.polState η (towerMomentum a b (-2)))) := by
  have h1 : towerLop η a b (-2) (Finsupp.single (-2) (1 : Fock D R))
      = Finsupp.single (-2) (Fock.secondState η (towerMomentum a b (-2))
          + invTwo R • Fock.traceState η) := by
    rw [towerLop_single, Lop_neg_two_apply_one_eq]
  have h2 : towerLop η a b (-1) (Finsupp.single (-2) (1 : Fock D R))
      = Finsupp.single (-2) (Fock.polState η (towerMomentum a b (-2))) := by
    rw [towerLop_single, Fock.Lop_neg_one_apply_one_eq_polState]
  have h3 : towerLop η a b (-1) (Finsupp.single (-2)
        (Fock.polState η (towerMomentum a b (-2))))
      = Finsupp.single (-2) (Fock.secondState η (towerMomentum a b (-2))
          + Fock.polState η (towerMomentum a b (-2))
            * Fock.polState η (towerMomentum a b (-2))) := by
    rw [towerLop_single, Fock.Lop_neg_one_apply_polState η _ hη]
  rw [descTwo_apply, h1, h2, h3, Finsupp.smul_single, Finsupp.smul_single,
    ← Finsupp.single_add]
  congr 1
  rw [smul_add, smul_add, smul_smul, two_mul_invTwo, one_smul]
  module

/-- **The `α_{-2}` component of the Type-2 state is `5p`.**  It is nonzero for some `ν`
precisely because `p · p = -2 ≠ 0`, which is how `descTwo_single` is shown to be independent of
the Type-1 family. -/
lemma alphaTwoCoeff_descTwo_single (hη : ∀ μ, η μ * η μ = 1) (ν : Fin D) :
    alphaTwoCoeff D R ν (descTwo η a b (Finsupp.single (-2) (1 : Fock D R)))
      = 5 * (η ν * towerMomentum a b (-2) ν) := by
  rw [descTwo_single_neg_two_eq hη, alphaTwoCoeff_single, coeff_add, coeff_add, coeff_smul,
    coeff_smul, coeff_single_two_secondState, coeff_single_two_traceState,
    coeff_single_two_mul_of_mem_levelSubmodule_one
      (Fock.polState_mem_levelSubmodule_one (towerMomentum a b (-2))) _ ν]
  simp

end States

/-! ### The Type-1 states are null on the slice -/

section TypeOneNull

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] {η a b : Fin D → R}
variable (hη : ∀ μ, η μ * η μ = 1) (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1)
variable (haa : Fock.zeroModeSq η a = 2)

include hη in
/-- A transverse level-one state is annihilated by every positive Virasoro mode: `L_1` gives
the transversality `e · p_j`, and `L_n` for `n ≥ 2` dies by the grading. -/
lemma towerLop_apply_single_polState_eq_zero_of_pos {e : Fin D → R} {j : ℤ}
    (he : dotVec η e (towerMomentum a b j) = 0) {n : ℤ} (hn : 0 < n) :
    towerLop η a b n (Finsupp.single j (Fock.polState η e)) = 0 := by
  rcases eq_or_lt_of_le (show (1 : ℤ) ≤ n by omega) with h1 | h1
  · rw [← h1, towerLop_single, Fock.Lop_one_apply_polState η _ hη e]
    have hsum : (∑ μ : Fin D, η μ * e μ * towerMomentum a b j μ) = 0 := he
    rw [hsum, zero_smul, Finsupp.single_zero]
  · exact towerLop_apply_eq_zero_of_mem_towerBigrade_of_lt η a b
      (single_mem_towerBigrade (Fock.polState_mem_levelSubmodule_one e)) (by exact_mod_cast h1)

include hη hbb hba haa in
/-- **The Type-1 level-two null states.**  For every polarisation `e` transverse to the rung
momentum `p_{-2}`, `L_{-1}((e·α_{-1})|0;p_{-2}⟩)` is a null physical state of the antidiagonal
slice `(rung -2, level 2)`.  `D` does not appear. -/
theorem typeOneTwo_mem_towerNullSubmodule {e : Fin D → R}
    (he : dotVec η e (towerMomentum a b (-2)) = 0) :
    typeOneTwo η a b e ∈ towerNullSubmodule η a b (1 : R) ⊓ towerBigrade D R (-2) 2 :=
  towerLop_neg_one_mem_towerNullSubmodule_of_mem_towerBigrade η a b hη hbb hba haa
    (j := -2) (N := 1) (by norm_num)
    (single_mem_towerBigrade (Fock.polState_mem_levelSubmodule_one e))
    (fun _ hn => towerLop_apply_single_polState_eq_zero_of_pos hη he hn)

end TypeOneNull

/-! ### The `D` null states of the level-two slice, and their independence -/

section Independence

open MvPolynomial

variable {D : ℕ} {K : Type*} [Field K] [CharZero K] [Algebra ℚ K] {η a b : Fin D → K}

/-- `p_{-2} · p_{-2} = -2`: the level-two tachyonic shell. -/
lemma dotVec_momentum_neg_two_self (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) :
    dotVec η (towerMomentum a b (-2)) (towerMomentum a b (-2)) = -2 := by
  rw [← zeroModeSq_eq_dotVec, zeroModeSq_towerMomentum, zeroModeSq_eq_dotVec,
    F.dotVec_self_eq_two hD, F.hba, F.frame.isotropic]
  push_cast
  ring

/-- `a · p_{-2} = 0`: the base momentum is transverse to the rung-`(-2)` momentum, because
`a·a = 2` and `a·b = 1`.  This is the extra Type-1 polarisation beyond the `D - 2` transverse
ones (blueprint §B″.2.1's cross-check: `b - b̃ = a`). -/
lemma dotVec_base_momentum_neg_two (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) :
    dotVec η a (towerMomentum a b (-2)) = 0 := by
  rw [dotVec_vec_towerMomentum, F.dotVec_self_eq_two hD, dotVec_comm η a b, F.hba]
  push_cast
  ring

/-- `p_{-2} · b = 1`, rung-independently. -/
lemma dotVec_momentum_neg_two_light (F : DDFLightConeFrame η a b) :
    dotVec η (towerMomentum a b (-2)) b = 1 := by
  rw [dotVec_comm, dotVec_vec_towerMomentum, F.hba, F.frame.isotropic, mul_zero, add_zero]

/-- **The `D` null states of the antidiagonal slice `(rung -2, level 2)`**: the Type-2 state
`𝒟₂|0;p_{-2}⟩` (index `none`), the Type-1 state with polarisation `a` (index `some none`), and
the `D - 2` Type-1 states with the transverse polarisations (index `some (some i)`).

Blueprint §B″.2.1's `25 + 1 = 26`, with the `25` split as `1 + 24`: the extra Type-1
polarisation is `a = b - b̃`, the one direction of the orthogonal complement of `p_{-2}` outside
the transverse frame. -/
noncomputable def nullFamilyTwo (F : DDFLightConeFrame η a b) :
    Option (Option (Fin (D - 2))) → TowerFock D K
  | none => descTwo η a b (Finsupp.single (-2) (1 : Fock D K))
  | some none => typeOneTwo η a b a
  | some (some i) => typeOneTwo η a b (F.trans.vec i)

/-- **The `D` level-two null states are linearly independent.**

`D = 26` is **not** needed here: independence is a statement about the `α_{-2}` components,
which are `5 p_{-2}` for the Type-2 state and the polarisation itself for the Type-1 states.
The argument is the triangularity of blueprint §B″: pair with `p_{-2}` to kill the Type-2
coefficient (using `p·p = -2 ≠ 0`), then with the frame to kill the Type-1 ones. -/
theorem linearIndependent_nullFamilyTwo (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) :
    LinearIndependent K (nullFamilyTwo F) := by
  classical
  rw [Fintype.linearIndependent_iff]
  intro g hg
  set p : Fin D → K := towerMomentum a b (-2) with hpdef
  set u : Fin D → K :=
    g (some none) • a + (∑ i : Fin (D - 2), g (some (some i)) • F.trans.vec i)
      + (5 * g none) • p with hudef
  -- Step 1: the `α_{-2}` component of the relation says that `u` vanishes.
  have hu : u = 0 := by
    funext ν
    have h : ∑ x : Option (Option (Fin (D - 2))),
        g x * alphaTwoCoeff D K ν (nullFamilyTwo F x) = 0 := by
      have h0 := congrArg (alphaTwoCoeff D K ν) hg
      rw [map_sum, map_zero] at h0
      exact (Finset.sum_congr rfl fun x _ => by rw [map_smul, smul_eq_mul]).trans h0
    rw [Fintype.sum_option, Fintype.sum_option] at h
    simp only [nullFamilyTwo, alphaTwoCoeff_descTwo_single F.hη,
      alphaTwoCoeff_typeOneTwo F.hη] at h
    have hS : ∑ i : Fin (D - 2), g (some (some i)) * (η ν * F.trans.vec i ν)
        = η ν * ∑ i : Fin (D - 2), g (some (some i)) * F.trans.vec i ν := by
      rw [Finset.mul_sum]
      exact Finset.sum_congr rfl fun i _ => by ring
    rw [hS] at h
    simp only [hudef, Pi.add_apply, Pi.smul_apply, Finset.sum_apply, smul_eq_mul, Pi.zero_apply]
    linear_combination (η ν) * h
      - (g (some none) * a ν + (∑ i : Fin (D - 2), g (some (some i)) * F.trans.vec i ν)
          + 5 * g none * p ν) * F.hη ν
  -- Step 2: pair `u = 0` against `p`, `b` and the transverse frame.
  have hexp : ∀ w : Fin D → K, g (some none) * dotVec η a w
      + (∑ i : Fin (D - 2), g (some (some i)) * dotVec η (F.trans.vec i) w)
      + (5 * g none) * dotVec η p w = 0 := by
    intro w
    have h0 : dotVec η u w = 0 := by rw [hu]; simp [dotVec]
    rw [hudef, dotVec_add_left, dotVec_add_left, dotVec_smul_left, dotVec_smul_left,
      dotVec_sum_left] at h0
    rw [← h0]
    congr 2
    exact Finset.sum_congr rfl fun i _ => (dotVec_smul_left η _ w _).symm
  have hnone : g none = 0 := by
    have h := hexp p
    rw [hpdef, dotVec_base_momentum_neg_two hD F,
      dotVec_momentum_neg_two_self hD F] at h
    simp only [F.dotVec_trans_towerMomentum, mul_zero, Finset.sum_const_zero, add_zero,
      zero_add] at h
    have h10 : (10 : K) ≠ 0 := by norm_num
    have hg10 : (10 : K) * g none = 0 := by linear_combination -h
    exact (mul_eq_zero.1 hg10).resolve_left h10
  intro i
  match i with
  | none => exact hnone
  | some none =>
      have h := hexp b
      rw [dotVec_comm η a b, F.hba, hpdef, dotVec_momentum_neg_two_light F] at h
      simp only [F.trans.transverse, mul_zero, Finset.sum_const_zero, add_zero, hnone,
        mul_zero, zero_mul] at h
      linear_combination h
  | some (some j) =>
      have h := hexp (F.trans.vec j)
      rw [dotVec_comm η a (F.trans.vec j), F.hεa j, hpdef,
        dotVec_comm η p (F.trans.vec j), F.dotVec_trans_towerMomentum j (-2)] at h
      simp only [F.trans.orthonormal, mul_ite, mul_one, mul_zero, Finset.sum_ite_eq',
        Finset.mem_univ, if_true, mul_zero, zero_mul, zero_add, add_zero] at h
      exact h

end Independence

/-! ### `B26 2` at `D = 26`, and the level-two slice of the DDF spanning lemma -/

section Closing

variable {D : ℕ} {K : Type*} [Field K] [LinearOrder K] [IsStrictOrderedRing K] [Algebra ℚ K]
variable {η a b : Fin D → K}

/-- All `D` members of `nullFamilyTwo` really are null states of the slice.  This is the only
statement of the file that uses `(D : K) = 26`, and it uses it only for the single Type-2
member (`NullSeedsTwo.descTwo_single_mem_towerNullSubmodule`). -/
theorem nullFamilyTwo_mem_towerNullSubmodule (hD : 2 ≤ D) (F : DDFLightConeFrame η a b)
    (hD26 : (D : K) = 26) (x : Option (Option (Fin (D - 2)))) :
    nullFamilyTwo F x ∈ towerNullSubmodule η a b (1 : K) ⊓ towerBigrade D K (-2) 2 := by
  have haa : Fock.zeroModeSq η a = 2 := F.dotVec_self_eq_two hD
  match x with
  | none =>
      exact descTwo_single_mem_towerNullSubmodule η a b F.hη F.frame.isotropic F.hba haa hD26
  | some none =>
      exact typeOneTwo_mem_towerNullSubmodule F.hη F.frame.isotropic F.hba haa
        (dotVec_base_momentum_neg_two hD F)
  | some (some i) =>
      exact typeOneTwo_mem_towerNullSubmodule F.hη F.frame.isotropic F.hba haa
        (F.dotVec_trans_towerMomentum i (-2))

/-- **`dim (H_null ⊓ V_2) ≥ D` at `D = 26`.**  Blueprint §B″.2's `r_2 = D`: the `D - 1` Type-1
states and the one Type-2 state are independent (`linearIndependent_nullFamilyTwo`, which needs
no hypothesis on `D`) and all null (`nullFamilyTwo_mem_towerNullSubmodule`, which needs
`(D : K) = 26` for the Type-2 one). -/
theorem le_finrank_towerNullSubmodule_inf_towerBigrade_two (hD : 2 ≤ D)
    (F : DDFLightConeFrame η a b) (hD26 : (D : K) = 26) :
    D ≤ finrank K ↥(towerNullSubmodule η a b (1 : K) ⊓ towerBigrade D K (-2) 2) := by
  classical
  have hfin : FiniteDimensional K
      ↥(towerNullSubmodule η a b (1 : K) ⊓ towerBigrade D K (-2) 2) :=
    Submodule.finiteDimensional_of_le inf_le_right
  have hspan : Submodule.span K (Set.range (nullFamilyTwo F))
      ≤ towerNullSubmodule η a b (1 : K) ⊓ towerBigrade D K (-2) 2 := by
    rw [Submodule.span_le]
    rintro _ ⟨x, rfl⟩
    exact nullFamilyTwo_mem_towerNullSubmodule hD F hD26 x
  have hrank : finrank K ↥(Submodule.span K (Set.range (nullFamilyTwo F)))
      = Fintype.card (Option (Option (Fin (D - 2)))) :=
    finrank_span_eq_card (linearIndependent_nullFamilyTwo hD F)
  have hcard : Fintype.card (Option (Option (Fin (D - 2)))) = D := by
    simp only [Fintype.card_option, Fintype.card_fin]
    omega
  have hmono := Submodule.finrank_mono hspan
  rw [hrank, hcard] at hmono
  exact hmono

/-- ⭐ **`B26 2` holds at `D = 26`.**

This is the first slice on which the critical dimension is actually consumed by a
machine-checked spanning result.  The two halves are:

* counting (`finrank_towerPhys_inf_towerBigrade_two_le`, `D`-independent):
  `dim (H_phys ⊓ V_2) ≤ dim (ddfSpan ⊓ V_2) + D`;
* null states (`le_finrank_towerNullSubmodule_inf_towerBigrade_two`, **`D = 26`**):
  `dim (H_null ⊓ V_2) ≥ D`.

The intercept is `a₀ = invTwo K * η(a,a) = 1`, which the frame fixes
(`DDFLightConeFrame.dotVec_self_eq_two`). -/
theorem b26_two_of_D26 (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (hD26 : (D : K) = 26) :
    B26 η a b F.hη F.trans 2 := by
  have hint : invTwo K * Fock.zeroModeSq η a = 1 := by
    rw [zeroModeSq_eq_dotVec, F.dotVec_self_eq_two hD, invTwo_mul_two]
  refine b26_two_of_finrank_towerNull hD F ?_
  rw [hint, show (-((2 : ℕ) : ℤ)) = (-2 : ℤ) by norm_num]
  exact le_finrank_towerNullSubmodule_inf_towerBigrade_two hD F hD26

/-- ⭐⭐ **The DDF spanning lemma on the level-two slice `(rung -2, level 2)`, at `D = 26`.**

`H_phys ⊓ V_2 ≤ ddfSpan ⊔ H_null`.  Together with `Assembly.ddfSpans_bigrade_neg_one_one`
(level one, unconditional in `D`) and `Glue.ddfSpansOn_towerLevelLE_one` this is the second
antidiagonal slice of `ddf-spans` to be closed, and the **first one that consumes `D = 26`**. -/
theorem ddfSpans_bigrade_neg_two_two (hD : 2 ≤ D) (F : DDFLightConeFrame η a b)
    (hD26 : (D : K) = 26) :
    DDFSpansOn η a b F.hη F.trans (towerBigrade D K (-((2 : ℕ) : ℤ)) 2) :=
  ddfSpansOn_bigrade_of_b26 F.frame.isotropic F.hba (b26_two_of_D26 hD F hD26)

end Closing

/-! ### Two by-products: `𝒟₂|0;p⟩ ≠ 0`, and the sharpness of `D = 26` for that state -/

section ByProducts

variable {D : ℕ} {K : Type*} [Field K] [CharZero K] [Algebra ℚ K] {η a b : Fin D → K}

/-- **`𝒟₂|0;p_{-2}⟩ ≠ 0`.**  Blueprint §B″'s correction note records this as open, and notes
that the Gram criterion *cannot* supply it: `kacDet2 26 (1-2) = 0` is precisely why the state is
null.  The `α_{-2}` component does supply it — that component is `5 p_{-2}`, and
`p_{-2}·p_{-2} = -2 ≠ 0` forces some component of `p_{-2}` to be nonzero. -/
theorem descTwo_single_neg_two_ne_zero (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) :
    descTwo η a b (Finsupp.single (-2) (1 : Fock D K)) ≠ 0 := by
  intro hzero
  have hp : ∀ ν : Fin D, towerMomentum a b (-2) ν = 0 := by
    intro ν
    have h := alphaTwoCoeff_descTwo_single (η := η) (a := a) (b := b) F.hη ν
    rw [hzero, map_zero] at h
    have h5 : (5 : K) ≠ 0 := by norm_num
    have hprod : η ν * towerMomentum a b (-2) ν = 0 :=
      (mul_eq_zero.1 h.symm).resolve_left h5
    have hη0 : η ν ≠ 0 := by
      intro hc
      have h1 := F.hη ν
      rw [hc, mul_zero] at h1
      exact one_ne_zero h1.symm
    exact (mul_eq_zero.1 hprod).resolve_left hη0
  have hzz : dotVec η (towerMomentum a b (-2)) (towerMomentum a b (-2)) = 0 := by
    rw [dotVec]
    exact Finset.sum_eq_zero fun ν _ => by rw [hp ν, mul_zero]
  rw [dotVec_momentum_neg_two_self hD F] at hzz
  norm_num at hzz

/-- **The concrete `N = 2` Type-2 state is physical exactly at `D = 26`.**

The slice form of `NullSeedsTwo.descTwo_mem_towerPhysSubmodule_iff`, with all its hypotheses
discharged by the light-cone frame (`descTwo_single_neg_two_ne_zero` supplies the nonvanishing).
So at `(D : K) ≠ 26` the one Type-2 null state of blueprint §B″.2.1 does not exist and the
level-two slice carries only the `D - 1` Type-1 null states — one short of the `D` that
`finrank_towerPhys_inf_towerBigrade_two_le` needs.

This is *not* a proof of `¬ B26 2` at `D ≠ 26`: that would additionally require the two
counting bounds to be equalities and an upper bound on `dim (H_null ⊓ V_2)`, neither of which is
available (see `formal/TODO.md`, `noghost-pr5`). -/
theorem descTwo_single_mem_towerPhysSubmodule_iff (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) :
    descTwo η a b (Finsupp.single (-2) (1 : Fock D K))
        ∈ towerPhysSubmodule η a b (1 : K) ↔ (D : K) = 26 := by
  have haa : Fock.zeroModeSq η a = 2 := F.dotVec_self_eq_two hD
  have hy : (Finsupp.single (-2) (1 : Fock D K)) ∈ towerBigrade D K (-2) 0 :=
    single_mem_towerBigrade (Fock.one_mem_levelSubmodule D K)
  have hpos : ∀ n : ℤ, 0 < n → towerLop η a b n (Finsupp.single (-2) (1 : Fock D K)) = 0 :=
    fun n hn => towerLop_apply_eq_zero_of_mem_towerBigrade_of_lt η a b hy (by exact_mod_cast hn)
  have h0 : towerLop η a b 0 (Finsupp.single (-2) (1 : Fock D K))
      = -(Finsupp.single (-2) (1 : Fock D K)) := by
    rw [towerLop_zero_apply_of_mem_towerBigrade_of_zeroModeSq_eq_two η a b F.hη
      F.frame.isotropic F.hba haa hy]
    push_cast
    module
  exact descTwo_mem_towerPhysSubmodule_iff η a b F.hη hpos h0
    (fun hc => descTwo_single_neg_two_ne_zero hD F (by rw [hc, map_zero]))

end ByProducts

end StringFormal.NoGhost
