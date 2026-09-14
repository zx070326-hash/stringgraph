/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.DescendantKernel
import StringFormal.NoGhost.LevelFourCount

/-!
# The level-five antidiagonal slice

Blueprint `formal/BLUEPRINT-noghost.md` §B⁗ (PR9b).  This file closes `B26 5` and
`ddfSpans_bigrade_neg_five_five`, the fifth antidiagonal slice of `ddf-spans`.

On the slice `(rung -5, level 5)` the Pascal identity that carried `N ≤ 4`,

`p_{m+1}(N) = p_m(N) + p_{m+1}(N−1) + p_{m+1}(N−2)`,

**fails** for the first time: at `N = 5` the right-hand side is one *too big*.  The excess `1`
is the coefficient of `−q⁵` in Euler's pentagonal expansion `∏(1−qⁿ) = 1 − q − q² + q⁵ + q⁷ − ⋯`,
and it is carried by (I5):

`p_{m+1}(5) + 1 = p_m(5) + p_{m+1}(4) + p_{m+1}(3)`     (`levelFive_count_identity_gen`).

At `m + 1 = 25` this reads `209405 + 1 = 176256 + 29575 + 3575`.  **The identity holds for every
`m`** — as at `N = 2, 3, 4`, the counting step never sees `26` (blueprint §B′.8); what is new is
only the `+ 1`.

The same lemma is used twice: at `m = D − 2` it is (I5), the account of the level-five slice;
at `m = D − 1` it says `κ₅ = 1`, which combined with
`DescendantKernel.finrank_ker_descPair_add_le` gives **(K5)**
`dim ker (T₅ : V_{j,4} × V_{j,3} → V_{j,5}) ≤ 1` — the one new mathematical input of `N = 5`,
`D`-independent and valid on every rung.  The two null families `L_{−1}Q_{-5,4}` and
`𝒟₂Q_{-5,3}` therefore overlap in at most one dimension, which is exactly the `+ 1` on the
other side of (I5); the two cancel in `b26_five_of_D26`.

## Contents

* `levelFive_count_identity_gen` / `levelFive_count_identity` / `levelFive_count_identity_full`
  — the arithmetic identity, in the `m`-form and in the two `D`-forms (I5) and `κ₅ = 1`.
* `card_conjFree_four_ge` — the level-four companion of `card_conjFree_three_ge`.
* `Finsupp.oscWeight_eq_five_cases` — the seven-shape classification.
* `LevelFiveIdx` / `levelFiveIndex` / `levelFiveIndex_injective` / `levelFiveIndex_surjOn` /
  `card_ddfLevel_five_eq` — the level-five parametrisation and the exact count `p_m(5)`.
* `levelThreeIndex_surjOn`, `levelFourIndex_surjOn`, `card_ddfLevel_three_le`,
  `card_ddfLevel_four_le` — the **upper** bounds on the full level counts `p_D(3)`, `p_D(4)`,
  which the earlier files never needed and which (K5) does.
* `card_conjFree_le_card_ddfLevel` — the surjective half of the `b̃`-free bridge, valid at every
  level (`LevelThreeCount.card_ddfLevel_le_card_conjFree` is the injective half); with it
  `card_conjFree_five_le` (U5) is a corollary of `card_ddfLevel_five_eq`.
* `finrank_ker_descPair_five_le_one` / `finrank_ker_seedPair_five_le_one` — (K5).
* `le_finrank_towerNull_inf_towerBigrade_five` — (N5), **the only place `D = 26` is used**.
* `b26_five_of_D26`, `ddfSpans_bigrade_neg_five_five`.

## Status

No `sorry`.  `ddf-spans` is now machine-checked on the antidiagonal slices `N ≤ 5`.

⚠ `b26_five_of_D26` needs only `2 ≤ D`, **weaker** than the `3 ≤ D` of `b26_four_of_D26`: the
transversality input at `N = 5` is the count (K5), which needs no transverse polarisation.
(The same remark applies to `N ≤ 4`: `κ_N = 0` there, so `finrank_ker_descPair_add_le` reproves
the moment-equation transversality of `LevelThreeCount` / `LevelFourCount` for free, with the
weaker hypothesis.  Those files are kept: their statements are strictly stronger, holding on
every rung with only `p·p ≠ 0`.)

**Not done in this file**: `N ≥ 6`.  There the count stops being enough — `κ_6 = p_D(1)` while
the target is `p_{D−1}(1)`, a gap of `1` at `D = 26` — so the seed condition has to be used and
the argument is a new piece of paper (blueprint §B⁗.7).
-/


namespace StringFormal.NoGhost

/-! ### The two counting identities

Everything here is arithmetic in `ℕ`; `D` never appears, only the number `m` of directions. -/

section CountIdentity

/-- **The level-five counting identity** (blueprint §B⁗.1 (I5)), in the form free of natural
subtraction:

`p_{m+1}(5) + 1 = p_m(5) + p_{m+1}(4) + p_{m+1}(3)`,

with `p_m(5) = m + 2m² + 2m·C(m+1,2) + m·C(m+2,3) + C(m+4,5)`,
`p_m(4) = m + m² + C(m+1,2) + m·C(m+1,2) + C(m+3,4)` and `p_m(3) = m + m² + C(m+2,3)`.

Unlike `levelTwo_count_identity`, `levelThree_count_identity` and `levelFour_count_identity`
the right-hand side carries an extra `+ 1` on the left: from `N = 5` on the two families
`L_{-1}Q_{N−1}` and `𝒟₂Q_{N−2}` overlap, and the overlap is exactly this `1`.  Three
applications of Pascal's rule (`Nat.choose_succ_succ` at `(m+1,1)`, `(m+2,2)` and `(m+4,4)`)
and one `ring` step. -/
theorem levelFive_count_identity_gen (m : ℕ) :
    ((m + 1) + 2 * ((m + 1) * (m + 1)) + 2 * ((m + 1) * Nat.choose (m + 2) 2)
        + (m + 1) * Nat.choose (m + 3) 3 + Nat.choose (m + 5) 5) + 1
      = (m + 2 * (m * m) + 2 * (m * Nat.choose (m + 1) 2) + m * Nat.choose (m + 2) 3
          + Nat.choose (m + 4) 5)
        + ((m + 1) + (m + 1) * (m + 1) + Nat.choose (m + 2) 2
            + (m + 1) * Nat.choose (m + 2) 2 + Nat.choose (m + 4) 4)
        + ((m + 1) + (m + 1) * (m + 1) + Nat.choose (m + 3) 3) := by
  have h2 : Nat.choose (m + 2) 2 = (m + 1) + Nat.choose (m + 1) 2 := by
    rw [Nat.choose_succ_succ (m + 1) 1, Nat.choose_one_right]
  have h3 : Nat.choose (m + 3) 3 = Nat.choose (m + 2) 2 + Nat.choose (m + 2) 3 :=
    Nat.choose_succ_succ (m + 2) 2
  have h5 : Nat.choose (m + 5) 5 = Nat.choose (m + 4) 4 + Nat.choose (m + 4) 5 :=
    Nat.choose_succ_succ (m + 4) 4
  rw [h5, h3, h2]
  ring

variable {D : ℕ}

/-- ⭐ **(I5)**: `levelFive_count_identity_gen` at `m = D − 2`, i.e. the level-five account of
the `(rung -5, level 5)` slice:

`p_{D−1}(5) + 1 = p_{D−2}(5) + p_{D−1}(4) + p_{D−1}(3)`.

At `D = 26`: `209405 + 1 = 176256 + 29575 + 3575`.  **Valid for every `D ≥ 2`** — the counting
step never sees `26`. -/
theorem levelFive_count_identity (hD : 2 ≤ D) :
    ((D - 1) + 2 * ((D - 1) * (D - 1)) + 2 * ((D - 1) * Nat.choose D 2)
        + (D - 1) * Nat.choose (D + 1) 3 + Nat.choose (D + 3) 5) + 1
      = ((D - 2) + 2 * ((D - 2) * (D - 2)) + 2 * ((D - 2) * Nat.choose (D - 1) 2)
          + (D - 2) * Nat.choose D 3 + Nat.choose (D + 2) 5)
        + ((D - 1) + (D - 1) * (D - 1) + Nat.choose D 2 + (D - 1) * Nat.choose D 2
            + Nat.choose (D + 2) 4)
        + ((D - 1) + (D - 1) * (D - 1) + Nat.choose (D + 1) 3) := by
  obtain ⟨m, rfl⟩ : ∃ m, D = m + 2 := ⟨D - 2, by omega⟩
  simp only [show m + 2 - 1 = m + 1 from rfl, show m + 2 - 2 = m from rfl,
    show m + 2 + 1 = m + 3 from rfl, show m + 2 + 2 = m + 4 from rfl,
    show m + 2 + 3 = m + 5 from rfl]
  exact levelFive_count_identity_gen m

/-- ⭐ **`κ₅ = 1`**: `levelFive_count_identity_gen` at `m = D − 1`, i.e. the counting input to
the kernel bound (K5) of `NoGhost/DescendantKernel.lean`:

`p_D(5) + 1 = p_{D−1}(5) + p_D(4) + p_D(3)`.

Blueprint §B⁗.3: `κ_N := p_D(N−1) + p_D(N−2) − p_D(N) + p_{D−1}(N)` equals `1` at `N = 5`.
Same lemma as (I5), one step up. -/
theorem levelFive_count_identity_full (hD : 1 ≤ D) :
    (D + 2 * (D * D) + 2 * (D * Nat.choose (D + 1) 2) + D * Nat.choose (D + 2) 3
        + Nat.choose (D + 4) 5) + 1
      = ((D - 1) + 2 * ((D - 1) * (D - 1)) + 2 * ((D - 1) * Nat.choose D 2)
          + (D - 1) * Nat.choose (D + 1) 3 + Nat.choose (D + 3) 5)
        + (D + D * D + Nat.choose (D + 1) 2 + D * Nat.choose (D + 1) 2
            + Nat.choose (D + 3) 4)
        + (D + D * D + Nat.choose (D + 2) 3) := by
  obtain ⟨m, rfl⟩ : ∃ m, D = m + 1 := ⟨D - 1, by omega⟩
  simp only [show m + 1 - 1 = m from rfl, show m + 1 + 1 = m + 2 from rfl,
    show m + 1 + 2 = m + 3 from rfl, show m + 1 + 3 = m + 4 from rfl,
    show m + 1 + 4 = m + 5 from rfl]
  exact levelFive_count_identity_gen m

end CountIdentity

/-! ### The `b̃`-free lower bound at level four

`card_conjFree_four_ge` is the level-four companion of `LevelThreeCount.card_conjFree_three_ge`:
the generic injection `conjFreeEmbed` of `LevelThreeCount` carries the level-four index family
on the `D − 1` non-`b̃` directions into the `b̃`-free level-four occupation functions. -/

section ConjFreeFourGe

variable {D : ℕ}

/-- **`p_{D−1}(4) ≥ (D−1) + (D−1)² + C(D,2) + (D−1)·C(D,2) + C(D+2,4)`**, the lower-bound
companion to `LevelFourCount.card_conjFree_four_le`.  It turns the Type-1 half of the
level-five null bound into a number. -/
theorem card_conjFree_four_ge (hD : 2 ≤ D) :
    (D - 1) + (D - 1) * (D - 1) + Nat.choose D 2 + (D - 1) * Nat.choose D 2
        + Nat.choose (D + 2) 4
      ≤ Fintype.card {d : Osc D →₀ ℕ // Fock.level D d = 4 ∧ conjDeg hD d = 0} := by
  classical
  have hκ : Fintype.card {μ : Fin D // μ ≠ conjIdx D hD} = D - 1 := by
    rw [Fintype.card_subtype_compl, Fintype.card_subtype_eq, Fintype.card_fin]
  have h1 := card_ddfLevel_four_ge {μ : Fin D // μ ≠ conjIdx D hD}
  have h2 := card_ddfLevel_le_card_conjFree hD 4
  rw [hκ, show D - 1 + 1 = D by omega, show D - 1 + 3 = D + 2 by omega] at h1
  omega

end ConjFreeFourGe

/-! ### The classification of level-five occupation functions

Seven shapes, `[5] [4,1] [3,2] [3,1,1] [2,2,1] [2,1,1,1] [1⁵]`.  As at levels three and four the
proof is one `Finsupp.exists_peel` plus the classifications at levels `≤ 4`. -/

namespace Finsupp

variable {ι : Type*}

/-- A `ℕ+` is determined by its coercion (the `Prod.ext` helper of the classification). -/
private lemma pnat_eq_five {m n : ℕ+} (h : (m : ℕ) = (n : ℕ)) : m = n := PNat.coe_injective h

/-- **The classification of level-five occupation functions.** -/
theorem oscWeight_eq_five_cases {d : (ι × ℕ+) →₀ ℕ} (h : oscWeight d = 5) :
    (∃ i : ι, d = Finsupp.single (i, 5) 1) ∨
      (∃ i j : ι, d = Finsupp.single (i, 4) 1 + Finsupp.single (j, 1) 1) ∨
        (∃ i j : ι, d = Finsupp.single (i, 3) 1 + Finsupp.single (j, 2) 1) ∨
          (∃ i j k : ι, d = Finsupp.single (i, 3) 1
            + (Finsupp.single (j, 1) 1 + Finsupp.single (k, 1) 1)) ∨
            (∃ i j k : ι, d = Finsupp.single (i, 2) 1 + Finsupp.single (j, 2) 1
              + Finsupp.single (k, 1) 1) ∨
              (∃ i j k l : ι, d = Finsupp.single (i, 2) 1
                + (Finsupp.single (j, 1) 1
                  + (Finsupp.single (k, 1) 1 + Finsupp.single (l, 1) 1))) ∨
                (∃ i j k l n : ι, d = Finsupp.single (i, 1) 1
                  + (Finsupp.single (j, 1) 1
                    + (Finsupp.single (k, 1) 1
                      + (Finsupp.single (l, 1) 1 + Finsupp.single (n, 1) 1)))) := by
  obtain ⟨v, d', hd, hw⟩ := exists_peel (N := 4) (by simpa using h)
  have hpos : 0 < (v.2 : ℕ) := v.2.pos
  have hle : (v.2 : ℕ) ≤ 5 := by omega
  interval_cases hv : (v.2 : ℕ)
  · -- `v₂ = 1`: the rest has weight four
    have hv1 : ((v.1, 1) : ι × ℕ+) = v := Prod.ext rfl (pnat_eq_five (by simpa using hv.symm))
    rcases oscWeight_eq_four_cases (d := d') (by omega) with
      ⟨i, hi⟩ | ⟨i, j, hi⟩ | ⟨i, j, hi⟩ | ⟨i, j, k, hi⟩ | ⟨i, j, k, l, hi⟩
    · exact Or.inr (Or.inl ⟨i, v.1, by rw [hd, hi, hv1]; try abel⟩)
    · exact Or.inr (Or.inr (Or.inr (Or.inl ⟨i, v.1, j, by rw [hd, hi, hv1]; try abel⟩)))
    · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inl ⟨i, j, v.1, by rw [hd, hi, hv1]; try abel⟩))))
    · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl
        ⟨i, v.1, j, k, by rw [hd, hi, hv1]; try abel⟩)))))
    · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr
        ⟨v.1, i, j, k, l, by rw [hd, hi, hv1]; try abel⟩)))))
  · -- `v₂ = 2`: the rest has weight three
    have hv2 : ((v.1, 2) : ι × ℕ+) = v := Prod.ext rfl (pnat_eq_five (by simpa using hv.symm))
    rcases oscWeight_eq_three_cases (d := d') (by omega) with
      ⟨i, hi⟩ | ⟨i, j, hi⟩ | ⟨i, j, k, hi⟩
    · exact Or.inr (Or.inr (Or.inl ⟨i, v.1, by rw [hd, hi, hv2]; try abel⟩))
    · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inl ⟨v.1, i, j, by rw [hd, hi, hv2]; try abel⟩))))
    · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl
        ⟨v.1, i, j, k, by rw [hd, hi, hv2]; try abel⟩)))))
  · -- `v₂ = 3`: the rest has weight two
    have hv3 : ((v.1, 3) : ι × ℕ+) = v := Prod.ext rfl (pnat_eq_five (by simpa using hv.symm))
    rcases oscWeight_eq_two_cases (d := d') (by omega) with ⟨i, hi⟩ | ⟨i, j, hi⟩
    · exact Or.inr (Or.inr (Or.inl ⟨v.1, i, by rw [hd, hi, hv3]; try abel⟩))
    · exact Or.inr (Or.inr (Or.inr (Or.inl ⟨v.1, i, j, by rw [hd, hi, hv3]; try abel⟩)))
  · -- `v₂ = 4`: the rest has weight one
    have hv4 : ((v.1, 4) : ι × ℕ+) = v := Prod.ext rfl (pnat_eq_five (by simpa using hv.symm))
    obtain ⟨i, hi⟩ := oscWeight_eq_one_cases (d := d') (by omega)
    exact Or.inr (Or.inl ⟨v.1, i, by rw [hd, hi, hv4]; try abel⟩)
  · -- `v₂ = 5`: the rest is empty
    have hv5 : ((v.1, 5) : ι × ℕ+) = v := Prod.ext rfl (pnat_eq_five (by simpa using hv.symm))
    have hd' : d' = 0 := eq_zero_of_oscWeight_eq_zero (by omega)
    exact Or.inl ⟨v.1, by rw [hd, hd', add_zero, hv5]⟩

end Finsupp

/-! ### The seven index families of level five

`ι ⊕ (ι × ι) ⊕ (ι × ι) ⊕ (ι × Sym ι 2) ⊕ (Sym ι 2 × ι) ⊕ (ι × Sym ι 3) ⊕ Sym ι 5` has
cardinality `P₅(m) = m + 2m² + 2m·C(m+1,2) + m·C(m+2,3) + C(m+4,5)`.  As at level four,
injectivity is organised around the mode-count profile `(#1, #2, #3, #4, #5)`, which is

`(0,0,0,0,1) (1,0,0,1,0) (0,1,1,0,0) (2,0,1,0,0) (1,2,0,0,0) (3,1,0,0,0) (5,0,0,0,0)`,

pairwise distinct; so `42` of the `49` cases are one line and only the seven diagonal ones
need an argument. -/

section LevelFiveIndex

variable {ι : Type*} [DecidableEq ι]

/-- Three mode-`n` oscillators from an unordered triple. -/
lemma symModeIndex_mk_three (n : ℕ+) (a c e : ι)
    (h : Multiset.card ({a, c, e} : Multiset ι) = 3) :
    symModeIndex ι n ⟨{a, c, e}, h⟩
      = Finsupp.single ((a, n) : ι × ℕ+) 1
        + (Finsupp.single ((c, n) : ι × ℕ+) 1 + Finsupp.single ((e, n) : ι × ℕ+) 1) := by
  have hm : ({a, c, e} : Multiset ι) = a ::ₘ (c ::ₘ {e}) := by simp [Multiset.insert_eq_cons]
  show Finsupp.mapDomain _ (Multiset.toFinsupp ({a, c, e} : Multiset ι)) = _
  rw [hm, mapDomain_toFinsupp_cons, mapDomain_toFinsupp_cons,
    Multiset.toFinsupp_singleton, Finsupp.mapDomain_single]

/-- Five mode-`n` oscillators from an unordered quintuple. -/
lemma symModeIndex_mk_five (n : ℕ+) (a c e f g : ι)
    (h : Multiset.card ({a, c, e, f, g} : Multiset ι) = 5) :
    symModeIndex ι n ⟨{a, c, e, f, g}, h⟩
      = Finsupp.single ((a, n) : ι × ℕ+) 1
        + (Finsupp.single ((c, n) : ι × ℕ+) 1
          + (Finsupp.single ((e, n) : ι × ℕ+) 1
            + (Finsupp.single ((f, n) : ι × ℕ+) 1 + Finsupp.single ((g, n) : ι × ℕ+) 1))) := by
  have hm : ({a, c, e, f, g} : Multiset ι) = a ::ₘ (c ::ₘ (e ::ₘ (f ::ₘ {g}))) := by
    simp [Multiset.insert_eq_cons]
  show Finsupp.mapDomain _ (Multiset.toFinsupp ({a, c, e, f, g} : Multiset ι)) = _
  rw [hm, mapDomain_toFinsupp_cons, mapDomain_toFinsupp_cons, mapDomain_toFinsupp_cons,
    mapDomain_toFinsupp_cons, Multiset.toFinsupp_singleton, Finsupp.mapDomain_single]

variable (ι)

/-- The level-five index type. -/
abbrev LevelFiveIdx : Type _ :=
  ι ⊕ (ι × ι) ⊕ (ι × ι) ⊕ (ι × Sym ι 2) ⊕ (Sym ι 2 × ι) ⊕ (ι × Sym ι 3) ⊕ Sym ι 5

/-- The level-five index map. -/
noncomputable def levelFiveIndex : LevelFiveIdx ι → ((ι × ℕ+) →₀ ℕ)
  | Sum.inl i => Finsupp.single (i, 5) 1
  | Sum.inr (Sum.inl p) => Finsupp.single (p.1, 4) 1 + Finsupp.single (p.2, 1) 1
  | Sum.inr (Sum.inr (Sum.inl p)) => Finsupp.single (p.1, 3) 1 + Finsupp.single (p.2, 2) 1
  | Sum.inr (Sum.inr (Sum.inr (Sum.inl p))) =>
      Finsupp.single (p.1, 3) 1 + symModeIndex ι 1 p.2
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl p)))) =>
      symModeIndex ι 2 p.1 + Finsupp.single (p.2, 1) 1
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl p))))) =>
      Finsupp.single (p.1, 2) 1 + symModeIndex ι 1 p.2
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr t))))) => symModeIndex ι 1 t

/-- The mode profile `(#1, #2, #3, #4, #5)` of each of the seven shapes. -/
def levelFiveShape : LevelFiveIdx ι → ℕ × ℕ × ℕ × ℕ × ℕ
  | Sum.inl _ => (0, 0, 0, 0, 1)
  | Sum.inr (Sum.inl _) => (1, 0, 0, 1, 0)
  | Sum.inr (Sum.inr (Sum.inl _)) => (0, 1, 1, 0, 0)
  | Sum.inr (Sum.inr (Sum.inr (Sum.inl _))) => (2, 0, 1, 0, 0)
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl _)))) => (1, 2, 0, 0, 0)
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl _))))) => (3, 1, 0, 0, 0)
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr _))))) => (5, 0, 0, 0, 0)

variable {ι}

lemma oscWeight_levelFiveIndex (x : LevelFiveIdx ι) :
    Finsupp.oscWeight (levelFiveIndex ι x) = 5 := by
  match x with
  | Sum.inl i => simp [levelFiveIndex]
  | Sum.inr (Sum.inl p) => simp [levelFiveIndex]
  | Sum.inr (Sum.inr (Sum.inl p)) => simp [levelFiveIndex]
  | Sum.inr (Sum.inr (Sum.inr (Sum.inl p))) => simp [levelFiveIndex]
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl p)))) => simp [levelFiveIndex]
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl p))))) => simp [levelFiveIndex]
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr t))))) => simp [levelFiveIndex]

lemma modeVec_levelFiveIndex (x : LevelFiveIdx ι) :
    (modeCount ι 1 (levelFiveIndex ι x), modeCount ι 2 (levelFiveIndex ι x),
        modeCount ι 3 (levelFiveIndex ι x), modeCount ι 4 (levelFiveIndex ι x),
        modeCount ι 5 (levelFiveIndex ι x))
      = levelFiveShape ι x := by
  match x with
  | Sum.inl i => simp [levelFiveIndex, levelFiveShape]
  | Sum.inr (Sum.inl p) => simp [levelFiveIndex, levelFiveShape, modeCount_add]
  | Sum.inr (Sum.inr (Sum.inl p)) => simp [levelFiveIndex, levelFiveShape, modeCount_add]
  | Sum.inr (Sum.inr (Sum.inr (Sum.inl p))) =>
      simp [levelFiveIndex, levelFiveShape, modeCount_add]
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl p)))) =>
      simp [levelFiveIndex, levelFiveShape, modeCount_add]
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl p))))) =>
      simp [levelFiveIndex, levelFiveShape, modeCount_add]
  | Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr t))))) =>
      simp [levelFiveIndex, levelFiveShape]

end LevelFiveIndex

/-! ### Injectivity and surjectivity of the level-five parametrisation -/

section LevelFiveInjective

variable {ι : Type*} [DecidableEq ι]

private lemma single_apply_mode_ne (i j : ι) (m n : ℕ+) (hmn : m ≠ n) :
    (Finsupp.single ((j, n) : ι × ℕ+) (1 : ℕ)) ((i, m) : ι × ℕ+) = 0 := by
  refine Finsupp.single_eq_of_ne fun hc => hmn ?_
  have hc2 := congrArg (fun v : ι × ℕ+ => v.2) hc
  simp only at hc2
  first | exact hc2 | exact hc2.symm

private lemma fst_of_single_apply (i j : ι) (n : ℕ+)
    (h : (Finsupp.single ((j, n) : ι × ℕ+) (1 : ℕ)) ((i, n) : ι × ℕ+) = 1) : j = i := by
  by_contra hc
  rw [Finsupp.single_eq_of_ne (fun hcc => hc (by
      have hz := congrArg (fun v : ι × ℕ+ => v.1) hcc
      simp only at hz
      first | exact hz | exact hz.symm))] at h
  exact zero_ne_one h

/-- **The level-five parametrisation is injective.**  Forty-two of the forty-nine cases are
settled by the mode profile `levelFiveShape`; the seven diagonal ones by `Finsupp.single`
injectivity resp. `symModeIndex_injective`. -/
theorem levelFiveIndex_injective : Function.Injective (levelFiveIndex ι) := by
  have h51 : (5 : ℕ+) ≠ 1 := by decide
  have h41 : (4 : ℕ+) ≠ 1 := by decide
  have h32 : (3 : ℕ+) ≠ 2 := by decide
  have h31 : (3 : ℕ+) ≠ 1 := by decide
  have h21 : (2 : ℕ+) ≠ 1 := by decide
  have h12 : (1 : ℕ+) ≠ 2 := by decide
  intro x y h
  have hs : levelFiveShape ι x = levelFiveShape ι y := by
    rw [← modeVec_levelFiveIndex x, ← modeVec_levelFiveIndex y, h]
  obtain i | p | q | ps | sp | pt | t := x <;> obtain i' | p' | q' | ps' | sp' | pt' | t' := y <;>
    simp only [levelFiveShape, Prod.mk.injEq] at hs <;> try (exfalso; omega)
  · -- `[5]` versus `[5]`
    refine congrArg Sum.inl ?_
    have h1 := DFunLike.congr_fun h ((i, 5) : ι × ℕ+)
    rw [levelFiveIndex, levelFiveIndex, Finsupp.single_eq_same] at h1
    exact (fst_of_single_apply i i' 5 h1.symm).symm
  · -- `[4,1]` versus `[4,1]`
    refine congrArg (Sum.inr ∘ Sum.inl) ?_
    have h1 := DFunLike.congr_fun h ((p.1, 4) : ι × ℕ+)
    have h2 := DFunLike.congr_fun h ((p.2, 1) : ι × ℕ+)
    rw [levelFiveIndex, levelFiveIndex, Finsupp.add_apply, Finsupp.add_apply,
      Finsupp.single_eq_same, single_apply_mode_ne p.1 p.2 4 1 h41,
      single_apply_mode_ne p.1 p'.2 4 1 h41, add_zero, add_zero] at h1
    rw [levelFiveIndex, levelFiveIndex, Finsupp.add_apply, Finsupp.add_apply,
      Finsupp.single_eq_same, single_apply_mode_ne p.2 p.1 1 4 (Ne.symm h41),
      single_apply_mode_ne p.2 p'.1 1 4 (Ne.symm h41), zero_add, zero_add] at h2
    exact Prod.ext (fst_of_single_apply p.1 p'.1 4 h1.symm).symm
      (fst_of_single_apply p.2 p'.2 1 h2.symm).symm
  · -- `[3,2]` versus `[3,2]`
    refine congrArg (Sum.inr ∘ Sum.inr ∘ Sum.inl) ?_
    have h1 := DFunLike.congr_fun h ((q.1, 3) : ι × ℕ+)
    have h2 := DFunLike.congr_fun h ((q.2, 2) : ι × ℕ+)
    rw [levelFiveIndex, levelFiveIndex, Finsupp.add_apply, Finsupp.add_apply,
      Finsupp.single_eq_same, single_apply_mode_ne q.1 q.2 3 2 h32,
      single_apply_mode_ne q.1 q'.2 3 2 h32, add_zero, add_zero] at h1
    rw [levelFiveIndex, levelFiveIndex, Finsupp.add_apply, Finsupp.add_apply,
      Finsupp.single_eq_same, single_apply_mode_ne q.2 q.1 2 3 (Ne.symm h32),
      single_apply_mode_ne q.2 q'.1 2 3 (Ne.symm h32), zero_add, zero_add] at h2
    exact Prod.ext (fst_of_single_apply q.1 q'.1 3 h1.symm).symm
      (fst_of_single_apply q.2 q'.2 2 h2.symm).symm
  · -- `[3,1,1]` versus `[3,1,1]`
    refine congrArg (Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inl) ?_
    have h1 := DFunLike.congr_fun h ((ps.1, 3) : ι × ℕ+)
    rw [levelFiveIndex, levelFiveIndex, Finsupp.add_apply, Finsupp.add_apply,
      Finsupp.single_eq_same, symModeIndex_apply_of_ne 1 ps.2 (by simpa using h31),
      symModeIndex_apply_of_ne 1 ps'.2 (by simpa using h31), add_zero, add_zero] at h1
    have hfst : ps'.1 = ps.1 := fst_of_single_apply ps.1 ps'.1 3 h1.symm
    rw [levelFiveIndex, levelFiveIndex, hfst] at h
    exact Prod.ext hfst.symm (symModeIndex_injective 1 (add_left_cancel h))
  · -- `[2,2,1]` versus `[2,2,1]`
    refine congrArg (Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inl) ?_
    have h1 := DFunLike.congr_fun h ((sp.2, 1) : ι × ℕ+)
    rw [levelFiveIndex, levelFiveIndex, Finsupp.add_apply, Finsupp.add_apply,
      Finsupp.single_eq_same, symModeIndex_apply_of_ne 2 sp.1 (by simpa using h12),
      symModeIndex_apply_of_ne 2 sp'.1 (by simpa using h12), zero_add, zero_add] at h1
    have hsnd : sp'.2 = sp.2 := fst_of_single_apply sp.2 sp'.2 1 h1.symm
    rw [levelFiveIndex, levelFiveIndex, hsnd] at h
    exact Prod.ext (symModeIndex_injective 2 (add_right_cancel h)) hsnd.symm
  · -- `[2,1,1,1]` versus `[2,1,1,1]`
    refine congrArg (Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inl) ?_
    have h1 := DFunLike.congr_fun h ((pt.1, 2) : ι × ℕ+)
    rw [levelFiveIndex, levelFiveIndex, Finsupp.add_apply, Finsupp.add_apply,
      Finsupp.single_eq_same, symModeIndex_apply_of_ne 1 pt.2 (by simpa using h21),
      symModeIndex_apply_of_ne 1 pt'.2 (by simpa using h21), add_zero, add_zero] at h1
    have hfst : pt'.1 = pt.1 := fst_of_single_apply pt.1 pt'.1 2 h1.symm
    rw [levelFiveIndex, levelFiveIndex, hfst] at h
    exact Prod.ext hfst.symm (symModeIndex_injective 1 (add_left_cancel h))
  · -- `[1,1,1,1,1]` versus `[1,1,1,1,1]`
    exact congrArg (Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inr ∘ Sum.inr)
      (symModeIndex_injective 1 h)

end LevelFiveInjective

/-! ### Surjectivity of the parametrisations, and the exact counts

The kernel bound of `NoGhost/DescendantKernel.lean` needs **upper** bounds on the full
level-`M` counts `p_D(M)` for `M = 3, 4`, which the earlier files never needed (they only ever
bounded the `b̃`-free counts from above).  So the surjectivity halves of the level-three and
level-four parametrisations are proved here as well; together with the injectivity halves
already in `LevelThreeCount` / `LevelFourCount` they give exact cardinalities. -/

section SurjOn

variable {ι : Type*} [DecidableEq ι]

/-- The level-three parametrisation hits every level-three occupation function. -/
theorem levelThreeIndex_surjOn {d : (ι × ℕ+) →₀ ℕ} (h : Finsupp.oscWeight d = 3) :
    ∃ x : ι ⊕ (ι × ι) ⊕ Sym ι 3, levelThreeIndex ι x = d := by
  classical
  rcases Finsupp.oscWeight_eq_three_cases h with ⟨i, hd⟩ | ⟨i, j, hd⟩ | ⟨i, j, k, hd⟩
  · exact ⟨Sum.inl i, hd.symm⟩
  · exact ⟨Sum.inr (Sum.inl (i, j)), hd.symm⟩
  · have hc : Multiset.card ({i, j, k} : Multiset ι) = 3 := by simp
    refine ⟨Sum.inr (Sum.inr ⟨{i, j, k}, hc⟩), ?_⟩
    show symThreeIndex ι ⟨{i, j, k}, hc⟩ = d
    rw [symThreeIndex_mk, hd]

/-- The level-four parametrisation hits every level-four occupation function. -/
theorem levelFourIndex_surjOn {d : (ι × ℕ+) →₀ ℕ} (h : Finsupp.oscWeight d = 4) :
    ∃ x : LevelFourIdx ι, levelFourIndex ι x = d := by
  classical
  rcases Finsupp.oscWeight_eq_four_cases h with
    ⟨i, hd⟩ | ⟨i, j, hd⟩ | ⟨i, j, hd⟩ | ⟨i, j, k, hd⟩ | ⟨i, j, k, l, hd⟩
  · exact ⟨Sum.inl i, hd.symm⟩
  · exact ⟨Sum.inr (Sum.inl (i, j)), hd.symm⟩
  · have hc : Multiset.card ({i, j} : Multiset ι) = 2 := by simp
    refine ⟨Sum.inr (Sum.inr (Sum.inl ⟨{i, j}, hc⟩)), ?_⟩
    show symModeIndex ι 2 ⟨{i, j}, hc⟩ = d
    rw [symModeIndex_mk_two, hd]
  · have hc : Multiset.card ({j, k} : Multiset ι) = 2 := by simp
    refine ⟨Sum.inr (Sum.inr (Sum.inr (Sum.inl (i, ⟨{j, k}, hc⟩)))), ?_⟩
    show Finsupp.single ((i, 2) : ι × ℕ+) 1 + symModeIndex ι 1 ⟨{j, k}, hc⟩ = d
    rw [symModeIndex_mk_two, hd]
  · have hc : Multiset.card ({i, j, k, l} : Multiset ι) = 4 := by simp
    refine ⟨Sum.inr (Sum.inr (Sum.inr (Sum.inr ⟨{i, j, k, l}, hc⟩))), ?_⟩
    show symModeIndex ι 1 ⟨{i, j, k, l}, hc⟩ = d
    rw [symModeIndex_mk_four, hd]

/-- The level-five parametrisation hits every level-five occupation function. -/
theorem levelFiveIndex_surjOn {d : (ι × ℕ+) →₀ ℕ} (h : Finsupp.oscWeight d = 5) :
    ∃ x : LevelFiveIdx ι, levelFiveIndex ι x = d := by
  classical
  rcases Finsupp.oscWeight_eq_five_cases h with
    ⟨i, hd⟩ | ⟨i, j, hd⟩ | ⟨i, j, hd⟩ | ⟨i, j, k, hd⟩ | ⟨i, j, k, hd⟩ | ⟨i, j, k, l, hd⟩
      | ⟨i, j, k, l, n, hd⟩
  · exact ⟨Sum.inl i, hd.symm⟩
  · exact ⟨Sum.inr (Sum.inl (i, j)), hd.symm⟩
  · exact ⟨Sum.inr (Sum.inr (Sum.inl (i, j))), hd.symm⟩
  · have hc : Multiset.card ({j, k} : Multiset ι) = 2 := by simp
    refine ⟨Sum.inr (Sum.inr (Sum.inr (Sum.inl (i, ⟨{j, k}, hc⟩)))), ?_⟩
    show Finsupp.single ((i, 3) : ι × ℕ+) 1 + symModeIndex ι 1 ⟨{j, k}, hc⟩ = d
    rw [symModeIndex_mk_two, hd]
  · have hc : Multiset.card ({i, j} : Multiset ι) = 2 := by simp
    refine ⟨Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl (⟨{i, j}, hc⟩, k))))), ?_⟩
    show symModeIndex ι 2 ⟨{i, j}, hc⟩ + Finsupp.single ((k, 1) : ι × ℕ+) 1 = d
    rw [symModeIndex_mk_two, hd]
  · have hc : Multiset.card ({j, k, l} : Multiset ι) = 3 := by simp
    refine ⟨Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inl (i, ⟨{j, k, l}, hc⟩)))))), ?_⟩
    show Finsupp.single ((i, 2) : ι × ℕ+) 1 + symModeIndex ι 1 ⟨{j, k, l}, hc⟩ = d
    rw [symModeIndex_mk_three, hd]
  · have hc : Multiset.card ({i, j, k, l, n} : Multiset ι) = 5 := by simp
    refine ⟨Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr (Sum.inr ⟨{i, j, k, l, n}, hc⟩))))), ?_⟩
    show symModeIndex ι 1 ⟨{i, j, k, l, n}, hc⟩ = d
    rw [symModeIndex_mk_five, hd]

/-- A surjective parametrisation bounds the level-`N` count from above. -/
theorem card_ddfLevel_le_of_surjOn {ι : Type*} [Fintype ι] [DecidableEq ι] {N : ℕ}
    {A : Type*} [Fintype A] (f : A → ((ι × ℕ+) →₀ ℕ))
    (hw : ∀ x, Finsupp.oscWeight (f x) = N)
    (hsurj : ∀ d : (ι × ℕ+) →₀ ℕ, Finsupp.oscWeight d = N → ∃ x, f x = d) :
    Fintype.card {d : (ι × ℕ+) →₀ ℕ // ddfLevel d = N} ≤ Fintype.card A := by
  classical
  refine Fintype.card_le_of_surjective
    (fun x => (⟨f x, by rw [ddfLevel_eq_oscWeight]; exact hw x⟩ :
      {d : (ι × ℕ+) →₀ ℕ // ddfLevel d = N})) ?_
  rintro ⟨d, hd⟩
  rw [ddfLevel_eq_oscWeight] at hd
  obtain ⟨x, hx⟩ := hsurj d hd
  exact ⟨x, Subtype.ext hx⟩

end SurjOn

section LevelCounts

variable (ι : Type*) [Fintype ι] [DecidableEq ι]

/-- **`p_m(3) ≤ m + m² + C(m+2,3)`**, the upper bound companion to
`LevelThreeCount.card_ddfLevel_three_ge`. -/
theorem card_ddfLevel_three_le :
    Fintype.card {d : (ι × ℕ+) →₀ ℕ // ddfLevel d = 3}
      ≤ Fintype.card ι + Fintype.card ι * Fintype.card ι
        + Nat.choose (Fintype.card ι + 2) 3 := by
  classical
  have hcard : Fintype.card (ι ⊕ (ι × ι) ⊕ Sym ι 3)
      = Fintype.card ι + Fintype.card ι * Fintype.card ι
        + Nat.choose (Fintype.card ι + 2) 3 := by
    simp only [Fintype.card_sum, Fintype.card_prod, Sym.card_sym_eq_choose]
    rw [show Fintype.card ι + 3 - 1 = Fintype.card ι + 2 by omega]
    ring
  rw [← hcard]
  exact card_ddfLevel_le_of_surjOn (levelThreeIndex ι) oscWeight_levelThreeIndex
    fun _ hd => levelThreeIndex_surjOn hd

/-- **`p_m(4) ≤ m + m² + C(m+1,2) + m·C(m+1,2) + C(m+3,4)`**, the upper bound companion to
`LevelFourCount.card_ddfLevel_four_ge`. -/
theorem card_ddfLevel_four_le :
    Fintype.card {d : (ι × ℕ+) →₀ ℕ // ddfLevel d = 4}
      ≤ Fintype.card ι + Fintype.card ι * Fintype.card ι + Nat.choose (Fintype.card ι + 1) 2
        + Fintype.card ι * Nat.choose (Fintype.card ι + 1) 2
        + Nat.choose (Fintype.card ι + 3) 4 := by
  classical
  have hcard : Fintype.card (LevelFourIdx ι)
      = Fintype.card ι + Fintype.card ι * Fintype.card ι + Nat.choose (Fintype.card ι + 1) 2
        + Fintype.card ι * Nat.choose (Fintype.card ι + 1) 2
        + Nat.choose (Fintype.card ι + 3) 4 := by
    show Fintype.card (ι ⊕ (ι × ι) ⊕ Sym ι 2 ⊕ (ι × Sym ι 2) ⊕ Sym ι 4) = _
    simp only [Fintype.card_sum, Fintype.card_prod, Sym.card_sym_eq_choose]
    rw [show Fintype.card ι + 2 - 1 = Fintype.card ι + 1 by omega,
      show Fintype.card ι + 4 - 1 = Fintype.card ι + 3 by omega]
    ring
  rw [← hcard]
  exact card_ddfLevel_le_of_surjOn (levelFourIndex ι) oscWeight_levelFourIndex
    fun _ hd => levelFourIndex_surjOn hd

/-- **`p_m(5) = m + 2m² + 2m·C(m+1,2) + m·C(m+2,3) + C(m+4,5)`**, the level-five count; the
seven index families of `LevelFiveIdx` are a bijective parametrisation. -/
theorem card_ddfLevel_five_eq :
    Fintype.card {d : (ι × ℕ+) →₀ ℕ // ddfLevel d = 5}
      = Fintype.card ι + 2 * (Fintype.card ι * Fintype.card ι)
        + 2 * (Fintype.card ι * Nat.choose (Fintype.card ι + 1) 2)
        + Fintype.card ι * Nat.choose (Fintype.card ι + 2) 3
        + Nat.choose (Fintype.card ι + 4) 5 := by
  classical
  have hcard : Fintype.card (LevelFiveIdx ι)
      = Fintype.card ι + 2 * (Fintype.card ι * Fintype.card ι)
        + 2 * (Fintype.card ι * Nat.choose (Fintype.card ι + 1) 2)
        + Fintype.card ι * Nat.choose (Fintype.card ι + 2) 3
        + Nat.choose (Fintype.card ι + 4) 5 := by
    show Fintype.card (ι ⊕ (ι × ι) ⊕ (ι × ι) ⊕ (ι × Sym ι 2) ⊕ (Sym ι 2 × ι)
      ⊕ (ι × Sym ι 3) ⊕ Sym ι 5) = _
    simp only [Fintype.card_sum, Fintype.card_prod, Sym.card_sym_eq_choose]
    rw [show Fintype.card ι + 2 - 1 = Fintype.card ι + 1 by omega,
      show Fintype.card ι + 3 - 1 = Fintype.card ι + 2 by omega,
      show Fintype.card ι + 5 - 1 = Fintype.card ι + 4 by omega]
    ring
  refine le_antisymm ?_ ?_
  · rw [← hcard]
    exact card_ddfLevel_le_of_surjOn (levelFiveIndex ι) oscWeight_levelFiveIndex
      fun _ hd => levelFiveIndex_surjOn hd
  · rw [← hcard]
    refine Fintype.card_le_of_injective
      (fun x => (⟨levelFiveIndex ι x, ?_⟩ : {d : (ι × ℕ+) →₀ ℕ // ddfLevel d = 5})) ?_
    · rw [ddfLevel_eq_oscWeight]; exact oscWeight_levelFiveIndex x
    · intro x y hxy
      exact levelFiveIndex_injective (congrArg Subtype.val hxy)

/-- **`p_m(5) ≥ …`**: the lower bound on `dim (ddfSpan ⊓ V_5)` needed by `B26 5`. -/
theorem card_ddfLevel_five_ge :
    Fintype.card ι + 2 * (Fintype.card ι * Fintype.card ι)
        + 2 * (Fintype.card ι * Nat.choose (Fintype.card ι + 1) 2)
        + Fintype.card ι * Nat.choose (Fintype.card ι + 2) 3
        + Nat.choose (Fintype.card ι + 4) 5
      ≤ Fintype.card {d : (ι × ℕ+) →₀ ℕ // ddfLevel d = 5} :=
  (card_ddfLevel_five_eq ι).ge

end LevelCounts

/-! ### From the `b̃`-free count back to the count on `D − 1` directions

`LevelThreeCount.card_ddfLevel_le_card_conjFree` is the injective direction of the bridge; the
surjective direction is Mathlib's `Finsupp.mem_range_mapDomain_iff` together with
`TypeOneFamily.apply_conj_eq_zero_of_conjDeg_eq_zero`.  This makes every `conjFree` upper bound
a corollary of the corresponding `ddfLevel` upper bound, at every level. -/

section ConjFreeBridge

variable {D : ℕ}

/-- **The `b̃`-free level-`N` occupation functions are exactly the images of the level-`N`
occupation functions on the `D − 1` non-`b̃` directions.**  (The other inequality is
`LevelThreeCount.card_ddfLevel_le_card_conjFree`.) -/
theorem card_conjFree_le_card_ddfLevel (hD : 2 ≤ D) (N : ℕ) :
    Fintype.card {d : Osc D →₀ ℕ // Fock.level D d = N ∧ conjDeg hD d = 0}
      ≤ Fintype.card {e : ({μ : Fin D // μ ≠ conjIdx D hD} × ℕ+) →₀ ℕ // ddfLevel e = N} := by
  classical
  have hinj : Function.Injective
      (fun v : {μ : Fin D // μ ≠ conjIdx D hD} × ℕ+ => (((v.1 : Fin D), v.2) : Osc D)) := by
    intro u v h
    exact Prod.ext (Subtype.ext (congrArg (fun p : Osc D => p.1) h))
      (congrArg (fun p : Osc D => p.2) h)
  refine Fintype.card_le_of_surjective
    (fun e => (⟨conjFreeEmbed hD (e : _), ?_, conjDeg_conjFreeEmbed hD _⟩ :
      {d : Osc D →₀ ℕ // Fock.level D d = N ∧ conjDeg hD d = 0})) ?_
  · rw [level_conjFreeEmbed hD, e.2]
  rintro ⟨d, hlev, hconj⟩
  have hmem : d ∈ Set.range (Finsupp.mapDomain
      (fun v : {μ : Fin D // μ ≠ conjIdx D hD} × ℕ+ => (((v.1 : Fin D), v.2) : Osc D))) := by
    refine (Finsupp.mem_range_mapDomain_iff _ hinj d).2 fun w hw => ?_
    have hw1 : w.1 = conjIdx D hD := by
      by_contra hc
      exact hw ⟨(⟨w.1, hc⟩, w.2), rfl⟩
    have := apply_conj_eq_zero_of_conjDeg_eq_zero hD hconj w.2
    rwa [← hw1] at this
  obtain ⟨e, he⟩ := hmem
  refine ⟨⟨e, ?_⟩, Subtype.ext he⟩
  rw [← level_conjFreeEmbed hD e]
  show Fock.level D (conjFreeEmbed hD e) = N
  rw [show conjFreeEmbed hD e = d from he]
  exact hlev

/-- ⭐ **(U5)**: `p_{D−1}(5) ≤ (D−1) + 2(D−1)² + 2(D−1)C(D,2) + (D−1)C(D+1,3) + C(D+3,5)`, the
upper bound on `dim (H_phys ⊓ V_5)` needed by `B26 5`. -/
theorem card_conjFree_five_le (hD : 2 ≤ D) :
    Fintype.card {d : Osc D →₀ ℕ // Fock.level D d = 5 ∧ conjDeg hD d = 0}
      ≤ (D - 1) + 2 * ((D - 1) * (D - 1)) + 2 * ((D - 1) * Nat.choose D 2)
        + (D - 1) * Nat.choose (D + 1) 3 + Nat.choose (D + 3) 5 := by
  classical
  have hκ : Fintype.card {μ : Fin D // μ ≠ conjIdx D hD} = D - 1 := by
    rw [Fintype.card_subtype_compl, Fintype.card_subtype_eq, Fintype.card_fin]
  have h1 := card_ddfLevel_five_eq {μ : Fin D // μ ≠ conjIdx D hD}
  have h2 := card_conjFree_le_card_ddfLevel hD 5
  rw [hκ, show D - 1 + 1 = D by omega, show D - 1 + 2 = D + 1 by omega,
    show D - 1 + 4 = D + 3 by omega] at h1
  omega

end ConjFreeBridge

/-! ### The full level counts on `Fin D` -/

section FullCounts

variable {D : ℕ}

/-- `Nat.card` of the level-`M` occupation functions, as `Fintype.card` of the `ddfLevel`
subtype: the shape `finrank_towerBigrade` produces versus the shape the index families
count. -/
theorem nat_card_level_eq_card_ddfLevel (D M : ℕ) :
    Nat.card {d : Osc D →₀ ℕ // Fock.level D d = M}
      = Fintype.card {d : (Fin D × ℕ+) →₀ ℕ // ddfLevel d = M} := by
  classical
  rw [← Nat.card_eq_fintype_card]
  exact Nat.card_congr (Equiv.subtypeEquivRight fun d => by
    rw [level_eq_oscWeight, ddfLevel_eq_oscWeight])

end FullCounts

/-! ### (K5): the two families overlap in at most one dimension -/

section KernelFive

variable {D : ℕ} {K : Type*} [Field K] [CharZero K] [Algebra ℚ K] {η a b : Fin D → K}

/-- ⭐⭐ **(K5)**, blueprint §B⁗.0: `dim ker(T₅) ≤ 1` on **every** rung, where
`T₅(φ, ψ) = L_{−1}φ + 𝒟₂ψ` on the whole slice `V_{j,4} × V_{j,3}`.

This is the only new mathematics `B26 5` needs, and it is a **pure count**: the general bound
`DescendantKernel.finrank_ker_descPair_add_le` says
`dim ker T₅ + p_D(5) ≤ p_D(4) + p_D(3) + p_{D−1}(5)`, and `levelFive_count_identity_full` says
the right-hand side is `p_D(5) + 1`.  **`D = 26` does not appear**; the bound holds for every
`D ≥ 2`, and `κ_5 = 1` is Euler's pentagonal `−q⁵`. -/
theorem finrank_ker_descPair_five_le_one (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (j : ℤ) :
    Module.finrank K ↥(LinearMap.ker (descPair η a b j 5)) ≤ 1 := by
  have h1 := finrank_ker_descPair_add_le hD F F.hη j 5 (by norm_num)
  simp only [show (5 : ℕ) - 1 = 4 from rfl, show (5 : ℕ) - 2 = 3 from rfl,
    nat_card_level_eq_card_ddfLevel] at h1
  have h2 := card_ddfLevel_five_eq (Fin D)
  have h3 := card_ddfLevel_four_le (Fin D)
  have h4 := card_ddfLevel_three_le (Fin D)
  have h5 := card_conjFree_five_le (D := D) hD
  have h6 := levelFive_count_identity_full (D := D) (by omega)
  rw [Fintype.card_fin] at h2 h3 h4
  omega

/-- (K5) restricted to the seeds: `dim ker(T₅|_{Q×Q}) ≤ 1`. -/
theorem finrank_ker_seedPair_five_le_one (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (j : ℤ) :
    Module.finrank K ↥(LinearMap.ker (seedPair η a b j 5)) ≤ 1 :=
  le_trans (finrank_ker_seedPair_le j 5) (finrank_ker_descPair_five_le_one hD F j)

/-- ⭐ **(N5)**, the null lower bound on the level-five slice at `D = 26`:

`dim Q_{-5,4} + dim Q_{-5,3} ≤ dim (H_null ⊓ V_5) + 1`.

Rank–nullity for `seedPair` on `Q_{-5,4} × Q_{-5,3}`: the image is contained in the null states
(Type 1 for the first factor, Type 2 for the second — this is the **only** place `D = 26` is
used, through `LevelThreeCount.descTwo_mem_towerNullSubmodule_of_mem_towerBigrade`), and the
kernel is at most one-dimensional by (K5).

Compare `LevelFourCount.le_finrank_towerNull_inf_towerBigrade_four`, where the corresponding map
is *injective* (proved there by moment equations, and reproved for free by
`finrank_ker_descPair_add_le` since `κ_4 = 0`). -/
theorem le_finrank_towerNull_inf_towerBigrade_five (hD : 2 ≤ D) (F : DDFLightConeFrame η a b)
    (haa : Fock.zeroModeSq η a = 2) (hD26 : (D : K) = 26) :
    Module.finrank K ↥(towerSeed η a b (-5) 4) + Module.finrank K ↥(towerSeed η a b (-5) 3)
      ≤ Module.finrank K
          ↥(towerNullSubmodule η a b (1 : K) ⊓ towerBigrade D K (-5) 5) + 1 := by
  classical
  have hQ4fin : FiniteDimensional K ↥(towerSeed η a b (-5) ((5 : ℕ) - 1)) :=
    Submodule.finiteDimensional_of_le (K := K) (V := TowerFock D K)
      (S₁ := towerSeed η a b (-5) ((5 : ℕ) - 1))
      (S₂ := towerBigrade D K (-5) ((5 : ℕ) - 1)) inf_le_right
  have hQ3fin : FiniteDimensional K ↥(towerSeed η a b (-5) ((5 : ℕ) - 2)) :=
    Submodule.finiteDimensional_of_le (K := K) (V := TowerFock D K)
      (S₁ := towerSeed η a b (-5) ((5 : ℕ) - 2))
      (S₂ := towerBigrade D K (-5) ((5 : ℕ) - 2)) inf_le_right
  have hQ4free : Module.Free K ↥(towerSeed η a b (-5) ((5 : ℕ) - 1)) :=
    Module.Free.of_divisionRing K ↥(towerSeed η a b (-5) ((5 : ℕ) - 1))
  have hQ3free : Module.Free K ↥(towerSeed η a b (-5) ((5 : ℕ) - 2)) :=
    Module.Free.of_divisionRing K ↥(towerSeed η a b (-5) ((5 : ℕ) - 2))
  have hprod : FiniteDimensional K
      (↥(towerSeed η a b (-5) ((5 : ℕ) - 1)) × ↥(towerSeed η a b (-5) ((5 : ℕ) - 2))) :=
    inferInstanceAs (Module.Finite K
      (↥(towerSeed η a b (-5) ((5 : ℕ) - 1)) × ↥(towerSeed η a b (-5) ((5 : ℕ) - 2))))
  have hWfin : FiniteDimensional K
      ↥(towerNullSubmodule η a b (1 : K) ⊓ towerBigrade D K (-5) 5) :=
    Submodule.finiteDimensional_of_le (K := K) (V := TowerFock D K)
      (S₁ := towerNullSubmodule η a b (1 : K) ⊓ towerBigrade D K (-5) 5)
      (S₂ := towerBigrade D K (-5) 5) inf_le_right
  have hmem : ∀ x : ↥(towerSeed η a b (-5) ((5 : ℕ) - 1))
        × ↥(towerSeed η a b (-5) ((5 : ℕ) - 2)),
      seedPair η a b (-5) 5 x
        ∈ towerNullSubmodule η a b (1 : K) ⊓ towerBigrade D K (-5) 5 := by
    rintro ⟨⟨φ, hφ⟩, ⟨ψ, hψ⟩⟩
    have hpos4 : ∀ n : ℤ, 0 < n → towerLop η a b n φ = 0 := (mem_towerSeed.1 hφ).1
    have hbig4 : φ ∈ towerBigrade D K (-5) 4 := (mem_towerSeed.1 hφ).2
    have hpos3 : ∀ n : ℤ, 0 < n → towerLop η a b n ψ = 0 := (mem_towerSeed.1 hψ).1
    have hbig3 : ψ ∈ towerBigrade D K (-5) 3 := (mem_towerSeed.1 hψ).2
    have h1 := towerLop_neg_one_mem_towerNullSubmodule_of_mem_towerBigrade η a b F.hη
      F.frame.isotropic F.hba haa (j := -5) (N := 4) (by norm_num) hbig4 hpos4
    have h2 := descTwo_mem_towerNullSubmodule_of_mem_towerBigrade η a b F.hη F.frame.isotropic
      F.hba haa hD26 (j := -5) (N := 3) (by norm_num) hbig3 hpos3 (N' := 5) (by norm_num)
    rw [seedPair_apply]
    refine Submodule.add_mem _ ?_ h2
    have h45 : (4 : ℕ) + 1 = 5 := by norm_num
    rw [h45] at h1
    exact h1
  have hrk := LinearMap.finrank_range_add_finrank_ker
    (V := ↥(towerSeed η a b (-5) ((5 : ℕ) - 1)) × ↥(towerSeed η a b (-5) ((5 : ℕ) - 2)))
    (V₂ := TowerFock D K) (seedPair η a b (-5) 5)
  rw [Module.finrank_prod] at hrk
  have hrange : LinearMap.range (seedPair η a b (-5) 5)
      ≤ towerNullSubmodule η a b (1 : K) ⊓ towerBigrade D K (-5) 5 := by
    rintro _ ⟨x, rfl⟩
    exact hmem x
  have hle1 : Module.finrank K ↥(LinearMap.range (seedPair η a b (-5) 5))
      ≤ Module.finrank K ↥(towerNullSubmodule η a b (1 : K) ⊓ towerBigrade D K (-5) 5) :=
    Submodule.finrank_mono hrange
  have hker := finrank_ker_seedPair_five_le_one (K := K) (η := η) (a := a) (b := b) hD F (-5)
  have he : Module.finrank K ↥(towerSeed η a b (-5) ((5 : ℕ) - 1))
      = Module.finrank K ↥(towerSeed η a b (-5) 4) := rfl
  have hf : Module.finrank K ↥(towerSeed η a b (-5) ((5 : ℕ) - 2))
      = Module.finrank K ↥(towerSeed η a b (-5) 3) := rfl
  rw [he, hf] at hrk
  omega

end KernelFive

/-! ### `B26 5` and the level-five slice of `ddf-spans` -/

section ClosingFive

variable {D : ℕ} {K : Type*} [Field K] [LinearOrder K] [IsStrictOrderedRing K] [Algebra ℚ K]
variable {η a b : Fin D → K}

/-- ⭐⭐ **`B26 5` at `D = 26`.**  Blueprint §B⁗.1, machine-checked:

`dim (H_phys ⊓ V_5) ≤ p_{D−1}(5)`, and `p_{D−1}(5) + 1 = p_{D−2}(5) + p_{D−1}(4) + p_{D−1}(3)
  ≤ dim (ddfSpan ⊓ V_5) + dim Q_{-5,4} + dim Q_{-5,3} ≤ dim (ddfSpan ⊓ V_5)
    + dim (H_null ⊓ V_5) + 1`,

so the two `+ 1`s cancel.  The first `≤` is PR4, the identity is Pascal (`+ 1` from Euler's
pentagonal `−q⁵`), `p_{D−2}(5) = dim (ddfSpan ⊓ V_5)` is PR2, `p_{D−1}(M) ≤ dim Q_{-5,M}` is
PR6′, and the last `≤` is `le_finrank_towerNull_inf_towerBigrade_five`, the only step using
`D = 26`.

⚠ The hypothesis is `2 ≤ D`, weaker than the `3 ≤ D` that `b26_four_of_D26` needs: the level-five
transversality input is the count (K5), which needs no transverse polarisation, whereas the
moment-equation proof at `N = 4` does. -/
theorem b26_five_of_D26 (hD : 2 ≤ D) (F : DDFLightConeFrame η a b) (hD26 : (D : K) = 26) :
    B26 η a b F.hη F.trans 5 := by
  have haa : Fock.zeroModeSq η a = 2 := F.dotVec_self_eq_two hD
  have hint : invTwo K * Fock.zeroModeSq η a = 1 := by rw [haa, invTwo_mul_two]
  have hrung : (-((5 : ℕ) : ℤ)) = (-5 : ℤ) := by norm_num
  have h1 := finrank_towerPhys_inf_towerBigrade_le (K := K) hD F 5
  have h2 := card_conjFree_five_le (D := D) hD
  have h3 := levelFive_count_identity (D := D) hD
  have h4 := card_ddfLevel_five_ge (Fin (D - 2))
  have h5 := card_conjFree_four_ge (D := D) hD
  have h6 := card_conjFree_three_ge (D := D) hD
  have h7 := le_finrank_towerSeed (K := K) hD F (-((5 : ℕ) : ℤ)) 4
  have h8 := le_finrank_towerSeed (K := K) hD F (-((5 : ℕ) : ℤ)) 3
  have h9 : Module.finrank K ↥(towerSeed η a b (-((5 : ℕ) : ℤ)) 4)
        + Module.finrank K ↥(towerSeed η a b (-((5 : ℕ) : ℤ)) 3)
      ≤ Module.finrank K ↥(towerNullSubmodule η a b (invTwo K * Fock.zeroModeSq η a)
          ⊓ towerBigrade D K (-((5 : ℕ) : ℤ)) 5) + 1 := by
    rw [hint, hrung]
    exact le_finrank_towerNull_inf_towerBigrade_five hD F haa hD26
  rw [Fintype.card_fin, show D - 2 + 1 = D - 1 by omega, show D - 2 + 2 = D by omega,
    show D - 2 + 4 = D + 2 by omega] at h4
  refine le_trans h1 ?_
  rw [finrank_ddfSpan_inf_towerBigrade F.hη F.frame.isotropic F.hba F.trans 5]
  omega

/-- ⭐⭐ **The DDF spanning lemma on the level-five slice `(rung -5, level 5)`, at `D = 26`.**

The fifth antidiagonal slice of `ddf-spans`, after `Assembly.ddfSpans_bigrade_neg_one_one`
(`N = 1`, unconditional in `D`), `LevelTwoCount.ddfSpans_bigrade_neg_two_two`,
`LevelThreeCount.ddfSpans_bigrade_neg_three_three` and
`LevelFourCount.ddfSpans_bigrade_neg_four_four`. -/
theorem ddfSpans_bigrade_neg_five_five (hD : 2 ≤ D) (F : DDFLightConeFrame η a b)
    (hD26 : (D : K) = 26) :
    DDFSpansOn η a b F.hη F.trans (towerBigrade D K (-((5 : ℕ) : ℤ)) 5) :=
  ddfSpansOn_bigrade_of_b26 F.frame.isotropic F.hba (b26_five_of_D26 hD F hD26)

end ClosingFive

end StringFormal.NoGhost
