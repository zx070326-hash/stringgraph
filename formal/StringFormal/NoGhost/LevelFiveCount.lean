/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.LevelFourCount

/-!
# The level-five antidiagonal slice: the counting half

Blueprint `formal/BLUEPRINT-noghost.md` §B⁗ (PR9b).  On the slice `(rung -5, level 5)` the
Pascal identity that carried `N ≤ 4`,

`p_{m+1}(N) = p_m(N) + p_{m+1}(N−1) + p_{m+1}(N−2)`,

**fails** for the first time: at `N = 5` the right-hand side is one *too big*.  The excess `1`
is the coefficient of `−q⁵` in Euler's pentagonal expansion `∏(1−qⁿ) = 1 − q − q² + q⁵ + q⁷ − ⋯`,
and it is carried by (I5):

`p_{m+1}(5) + 1 = p_m(5) + p_{m+1}(4) + p_{m+1}(3)`     (`levelFive_count_identity_gen`).

At `m + 1 = 25` this reads `209405 + 1 = 176256 + 29575 + 3575`.  **The identity holds for every
`m`** — as at `N = 2, 3, 4`, the counting step never sees `26` (blueprint §B′.8); what is new is
only the `+ 1`.

The same lemma is used twice: at `m = D − 2` it is (I5), the account of the level-five slice; at
`m = D − 1` it says `κ₅ = 1`, the counting input to the kernel bound (K5) of
`NoGhost/DescendantKernel.lean`.

## Status

No `sorry`.

**Not done in this file**: `N ≥ 6` (the excess stops being `1`; see blueprint §B⁗.7).
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

end StringFormal.NoGhost
