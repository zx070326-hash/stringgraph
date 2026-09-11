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

end StringFormal.NoGhost
