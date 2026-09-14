/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import Mathlib.RingTheory.Finiteness.Prod
import StringFormal.NoGhost.TypeOneFamily

/-!
# The kernel of the two descendant families is bounded by a count

Blueprint `formal/BLUEPRINT-noghost.md` §B⁗.3 (PR9a).  Fix a rung `j` and a level `N ≥ 2` and
put

`T_N : V_{j,N−1} × V_{j,N−2} → V_{j,N}`,  `(φ, ψ) ↦ L_{−1}φ + 𝒟₂ψ`   (`descPair`),

the **whole-slice** version of the Type-1 ⊕ Type-2 map (`LevelFourCount.typeTwoAugFour` is its
restriction to the seeds `Q_{j,M}` at `j = -4`, `N = 4`).  The theorem of this file is that
`dim ker T_N` is bounded by a pure *count*:

`dim ker T_N + p_D(N) ≤ p_{D−1}(N) + p_D(N−1) + p_D(N−2)`   (`finrank_ker_descPair_add_le`),

i.e. `dim ker T_N ≤ κ_N := p_D(N−1) + p_D(N−2) − p_D(N) + p_{D−1}(N)`.  Euler's pentagonal
number theorem gives `κ_N = p_D(N−5) + p_D(N−7) − p_D(N−12) − ⋯`, so `κ_N = 0` for `N ≤ 4` and
`κ_5 = 1`: the transversality of the two families for `N ≤ 4` (proved by moment equations in
`LevelThreeCount` and `LevelFourCount`) is a *consequence of counting*, and at `N = 5` the two
families overlap in at most one dimension.  That is (K5), the only new mathematics needed for
`B26 5`.

## The three steps (blueprint §B⁗.3)

* **(a)** `range T_N ⊇ ordSeedSpanPos_{j,N}`.  An ordered word `L_{−n₁}⋯L_{−n_k}` applied to a
  `b̃`-free light-cone monomial factors as `L_{−n₁}` applied to something in `V_{j,N−n₁}`
  (`wordApply_mem_towerBigrade`), and `L_{−n}V_{j,M}` reduces to `L_{−1}V_{j,N−1}` and
  `L_{−2}V_{j,N−2}` by induction on `n` using `⁅L_{−1}, L_{−(n−1)}⁆ = (n−2)L_{−n}`
  (`towerLop_neg_map_le_range_descPair`; the negative modes have no central term).  The step
  from `L_{−2}` to `𝒟₂` is `2L_{−2} = 𝒟₂ − 3L_{−1}²`.
* **(b)** `V_{j,N} ≤ C_{j,N} ⊔ range T_N` where `C_{j,N} = conjFreeSliceAt hD F j N`: this is
  (F-1) `TypeOneFamily.towerBigrade_le_ordSeedSpan` split according to whether the ordered word
  is empty.
* **(c)** Rank–nullity plus `dim V_{j,M} = p_D(M)` (`finrank_towerBigrade`, exact) and
  `dim C_{j,N} ≤ p_{D−1}(N)` (`SpuriousElimination.finrank_conjFreeSliceAt_le`).

⭐ **`D = 26`, the seed condition, physicality and `p_j·p_j ≠ 0` never appear.**  The hypotheses
are `2 ≤ D` (for the frame), a field which is a `ℚ`-algebra of characteristic zero, and `hη`.
The bound also holds on every rung, not just the antidiagonal one.

## Status

No `sorry`.  **Not done**: the reverse inequality (`dim ker T_N ≥ κ_N`, i.e. that the bound is
tight) — that is the BGG/Feigin–Fuks half, and blueprint §B⁗.2 settles the case `N = 5` of it by
hand without needing it in Lean.
-/

namespace StringFormal.NoGhost

open StringFormal.Virasoro

/-! ### Ordered words preserve the bigrading -/

section WordBigrade

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] (η a b : Fin D → R)

/-- **An ordered word of negative modes shifts the level by `-l.sum`.**  `L_{n₁}⋯L_{n_k}` maps
`V_{j,M}` into `V_{j,M'}` whenever `M' = M − Σ nᵢ`; the hypothesis that every mode is negative
is what makes the intermediate levels natural numbers. -/
theorem wordApply_mem_towerBigrade (j : ℤ) :
    ∀ (l : List ℤ), (∀ n ∈ l, n < 0) → ∀ (M M' : ℕ) (y : TowerFock D R),
      y ∈ towerBigrade D R j M → (M' : ℤ) = (M : ℤ) - l.sum →
        wordApply (towerLop η a b) l y ∈ towerBigrade D R j M' := by
  intro l
  induction l with
  | nil =>
      intro _ M M' y hy hM'
      rw [List.sum_nil, sub_zero] at hM'
      rw [wordApply_nil, show M' = M from Nat.cast_injective hM']
      exact hy
  | cons m t ih =>
      intro hneg M M' y hy hM'
      have hnegt : ∀ n ∈ t, n < 0 := fun n hn => hneg n (List.mem_cons_of_mem m hn)
      have hts : t.sum ≤ 0 := sum_nonpos_of_neg hnegt
      set M₁ : ℕ := ((M : ℤ) - t.sum).toNat with hM₁def
      have hM₁ : (M₁ : ℤ) = (M : ℤ) - t.sum := by
        rw [hM₁def, Int.toNat_of_nonneg (by omega)]
      have hmid := ih hnegt M M₁ y hy hM₁
      rw [wordApply_cons]
      refine towerLop_mem_towerBigrade η a b hmid ?_
      rw [hM', hM₁, List.sum_cons]
      ring

end WordBigrade

/-! ### The whole-slice Type-1 ⊕ Type-2 map -/

section DescPair

variable {D : ℕ} {K : Type*} [Field K] [CharZero K] [Algebra ℚ K] {η a b : Fin D → K}

variable (η a b) in
/-- **The combined descendant map on a whole bigraded slice**:
`(φ, ψ) ↦ L_{−1}φ + 𝒟₂ψ` on `V_{j,N−1} × V_{j,N−2}`.  No seed condition, no physicality —
`LevelFourCount.typeTwoAugFour` is its restriction to the seeds at `j = -4`, `N = 4`. -/
noncomputable def descPair (j : ℤ) (N : ℕ) :
    (↥(towerBigrade D K j (N - 1)) × ↥(towerBigrade D K j (N - 2))) →ₗ[K] TowerFock D K :=
  (towerLop η a b (-1)).comp
      ((towerBigrade D K j (N - 1)).subtype.comp (LinearMap.fst K _ _))
    + (descTwo η a b).comp
        ((towerBigrade D K j (N - 2)).subtype.comp (LinearMap.snd K _ _))

lemma descPair_apply (j : ℤ) (N : ℕ)
    (x : ↥(towerBigrade D K j (N - 1)) × ↥(towerBigrade D K j (N - 2))) :
    descPair η a b j N x
      = towerLop η a b (-1) (x.1 : TowerFock D K) + descTwo η a b (x.2 : TowerFock D K) := by
  simp only [descPair, LinearMap.add_apply, LinearMap.coe_comp, Function.comp_apply,
    LinearMap.fst_apply, LinearMap.snd_apply, Submodule.subtype_apply]

/-- `L_{−1} V_{j,N−1} ≤ range (descPair)`: take `ψ = 0`. -/
theorem lopOne_map_le_range_descPair (j : ℤ) (N : ℕ) :
    (towerBigrade D K j (N - 1)).map (towerLop η a b (-1))
      ≤ LinearMap.range (descPair η a b j N) := by
  rintro _ ⟨φ, hφ, rfl⟩
  exact ⟨(⟨φ, hφ⟩, 0), by rw [descPair_apply]; simp⟩

/-- `L_{−2} V_{j,N−2} ≤ range (descPair)`: `2L_{−2} = 𝒟₂ − 3L_{−1}²`, and `2` is invertible. -/
theorem lopTwo_map_le_range_descPair (j : ℤ) (N : ℕ) (hN : 2 ≤ N) :
    (towerBigrade D K j (N - 2)).map (towerLop η a b (-2))
      ≤ LinearMap.range (descPair η a b j N) := by
  rintro _ ⟨ψ, hψ, rfl⟩
  have hstep : towerLop η a b (-1) ψ ∈ towerBigrade D K j (N - 1) :=
    towerLop_mem_towerBigrade η a b hψ (by omega)
  have hφ : ((-3 : K) • towerLop η a b (-1) ψ) ∈ towerBigrade D K j (N - 1) :=
    Submodule.smul_mem _ _ hstep
  refine ⟨(2 : K)⁻¹ • (⟨_, hφ⟩, ⟨ψ, hψ⟩), ?_⟩
  rw [map_smul, descPair_apply, descTwo_apply]
  show (2 : K)⁻¹ • (towerLop η a b (-1) ((-3 : K) • towerLop η a b (-1) ψ)
    + ((2 : K) • towerLop η a b (-2) ψ
      + (3 : K) • towerLop η a b (-1) (towerLop η a b (-1) ψ))) = _
  rw [map_smul]
  have h2 : (2 : K) ≠ 0 := two_ne_zero
  match_scalars <;> (field_simp; try ring)

variable (η a b) in
/-- **The induction of blueprint §B⁗.3 (a)**: for every `n ≥ 1`, `L_{−n}` maps `V_{j,M}` into
the range of `descPair` as soon as `M + n = N`.

`n = 1, 2` are the two previous lemmas; for `n ≥ 3` the Witt relation
`⁅L_{−1}, L_{−(n−1)}⁆ = (n−2)L_{−n}` (`towerLop_apply_towerLop_of_ne_zero`, no central term
because `-1 + -(n−1) ≠ 0`) expresses `L_{−n}` through `L_{−1}L_{−(n−1)}` and `L_{−(n−1)}L_{−1}`;
the first is handled by the `n = 1` case, the second by the induction hypothesis at `n − 1`. -/
theorem towerLop_neg_map_le_range_descPair (hη : ∀ μ, η μ * η μ = 1) (j : ℤ) (N : ℕ)
    (hN : 2 ≤ N) :
    ∀ n : ℕ, 1 ≤ n → ∀ M : ℕ, M + n = N →
      (towerBigrade D K j M).map (towerLop η a b (-(n : ℤ)))
        ≤ LinearMap.range (descPair η a b j N) := by
  intro n
  induction n using Nat.strong_induction_on with
  | _ n ih =>
    intro hn M hMn
    rcases Nat.lt_or_ge n 3 with h3 | h3
    · interval_cases n
      · rw [show M = N - 1 by omega, show (-((1 : ℕ) : ℤ)) = (-1 : ℤ) by norm_num]
        exact lopOne_map_le_range_descPair j N
      · rw [show M = N - 2 by omega, show (-((2 : ℕ) : ℤ)) = (-2 : ℤ) by norm_num]
        exact lopTwo_map_le_range_descPair j N hN
    · obtain ⟨k, rfl⟩ : ∃ k, n = k + 1 := ⟨n - 1, by omega⟩
      have hk2 : 2 ≤ k := by omega
      rintro _ ⟨y, hy, rfl⟩
      -- `L_{-k} y` lives on level `N - 1`, so `L_{-1} L_{-k} y` is in the range.
      have hky : towerLop η a b (-(k : ℤ)) y ∈ towerBigrade D K j (N - 1) :=
        towerLop_mem_towerBigrade η a b hy (by omega)
      have hA : towerLop η a b (-1) (towerLop η a b (-(k : ℤ)) y)
          ∈ LinearMap.range (descPair η a b j N) :=
        lopOne_map_le_range_descPair j N ⟨_, hky, rfl⟩
      -- `L_{-1} y` lives on level `M + 1`, so the induction hypothesis at `k` applies.
      have h1y : towerLop η a b (-1) y ∈ towerBigrade D K j (M + 1) :=
        towerLop_mem_towerBigrade η a b hy (by push_cast; ring)
      have hB : towerLop η a b (-(k : ℤ)) (towerLop η a b (-1) y)
          ∈ LinearMap.range (descPair η a b j N) :=
        ih k (by omega) (by omega) (M + 1) (by omega) ⟨_, h1y, rfl⟩
      -- the Witt relation
      have hne : (-1 : ℤ) + -(k : ℤ) ≠ 0 := by omega
      have hcomm := towerLop_apply_towerLop_of_ne_zero η a b hη hne y
      rw [show (-1 : ℤ) + -(k : ℤ) = -((k + 1 : ℕ) : ℤ) by push_cast; ring] at hcomm
      have hcoef : ((-1 : ℤ) : K) - ((-(k : ℤ) : ℤ) : K) = (k : K) - 1 := by push_cast; ring
      rw [hcoef] at hcomm
      have hkne : (k : K) - 1 ≠ 0 := by
        refine sub_ne_zero.2 fun hc => ?_
        have hk1 : (k : ℕ) = 1 := by exact_mod_cast hc
        omega
      have hsm : ((k : K) - 1) • towerLop η a b (-((k + 1 : ℕ) : ℤ)) y
          = towerLop η a b (-1) (towerLop η a b (-(k : ℤ)) y)
            - towerLop η a b (-(k : ℤ)) (towerLop η a b (-1) y) := by
        rw [hcomm]; abel
      have hmem : ((k : K) - 1) • towerLop η a b (-((k + 1 : ℕ) : ℤ)) y
          ∈ LinearMap.range (descPair η a b j N) := by
        rw [hsm]; exact Submodule.sub_mem _ hA hB
      have := Submodule.smul_mem (LinearMap.range (descPair η a b j N)) ((k : K) - 1)⁻¹ hmem
      rwa [smul_smul, inv_mul_cancel₀ hkne, one_smul] at this

/-- **Blueprint §B⁗.3 (a)**: the non-empty part of the seed family lands in the range of
`descPair`.  Splitting the ordered word as `n :: t`, the tail lands in `V_{j,N−|n|}`
(`wordApply_mem_towerBigrade`) and the head is handled by
`towerLop_neg_map_le_range_descPair`. -/
theorem ordSeedSpanPos_le_range_descPair (hD : 2 ≤ D) (F : DDFLightConeFrame η a b)
    (hη : ∀ μ, η μ * η μ = 1) (j : ℤ) (N : ℕ) (hN : 2 ≤ N) :
    ordSeedSpanPos hD F j N ≤ LinearMap.range (descPair η a b j N) := by
  rw [ordSeedSpanPos, Submodule.span_le]
  rintro _ ⟨⟨⟨l, c⟩, hl, hne, hc, hlev⟩, rfl⟩
  simp only at hl hne hc hlev
  obtain ⟨m, t, rfl⟩ : ∃ (m : ℤ) (t : List ℤ), l = m :: t := by
    cases l with
    | nil => exact absurd rfl hne
    | cons m t => exact ⟨m, t, rfl⟩
  have hm : m < 0 := hl.head_neg
  have hnegt : ∀ n ∈ t, n < 0 := hl.tail.neg
  have hts : t.sum ≤ 0 := sum_nonpos_of_neg hnegt
  set M₁ : ℕ := ((Fock.level D c : ℤ) - t.sum).toNat with hM₁def
  have hM₁ : (M₁ : ℤ) = (Fock.level D c : ℤ) - t.sum := by
    rw [hM₁def, Int.toNat_of_nonneg (by omega)]
  have hmid : wordApply (towerLop η a b) t (Finsupp.single j (lcMonomial F c))
      ∈ towerBigrade D K j M₁ :=
    wordApply_mem_towerBigrade η a b j t hnegt (Fock.level D c) M₁ _
      (single_mem_towerBigrade (lcMonomial_mem_levelSubmodule F c)) hM₁
  set nn : ℕ := (-m).toNat with hnndef
  have hnn : (nn : ℤ) = -m := by rw [hnndef, Int.toNat_of_nonneg (by omega)]
  have hnn1 : 1 ≤ nn := by omega
  have hsum : M₁ + nn = N := by
    rw [List.sum_cons] at hlev
    omega
  have : wordApply (towerLop η a b) (m :: t) (Finsupp.single j (lcMonomial F c))
      = towerLop η a b (-(nn : ℤ)) (wordApply (towerLop η a b) t
          (Finsupp.single j (lcMonomial F c))) := by
    rw [wordApply_cons, show (-(nn : ℤ)) = m by omega]
  show wordApply (towerLop η a b) (m :: t) (Finsupp.single j (lcMonomial F c)) ∈ _
  rw [this]
  exact towerLop_neg_map_le_range_descPair η a b hη j N hN nn hnn1 M₁ hsum ⟨_, hmid, rfl⟩

/-- **Blueprint §B⁗.3 (b)**, the split of the seed family according to whether the ordered word
is empty: the empty words give the `b̃`-free monomials on rung `j`, the rest is
`ordSeedSpanPos`. -/
theorem ordSeedSpan_le_conjFreeSliceAt_sup_pos (hD : 2 ≤ D) (F : DDFLightConeFrame η a b)
    (j : ℤ) (M : ℕ) :
    ordSeedSpan hD F j M ≤ conjFreeSliceAt hD F j M ⊔ ordSeedSpanPos hD F j M := by
  rw [ordSeedSpan, Submodule.span_le]
  rintro _ ⟨⟨⟨l, c⟩, hl, hc, hlev⟩, rfl⟩
  simp only at hl hc hlev
  by_cases hne : l = []
  · subst hne
    have hlevc : Fock.level D c = M := by
      rw [List.sum_nil, sub_zero] at hlev
      exact Nat.cast_injective hlev
    refine Submodule.mem_sup_left ?_
    show Finsupp.single j (lcMonomial F c) ∈ conjFreeSliceAt hD F j M
    exact ⟨lcMonomial F c, lcMonomial_mem_conjFree hD F hlevc hc, rfl⟩
  · exact Submodule.mem_sup_right (wordApply_mem_ordSeedSpanPos hD F j hl hne hc hlev)

/-- **(F-1) + (a) + (b)**: the slice is spanned by the `b̃`-free monomials together with the
range of `descPair`. -/
theorem towerBigrade_le_conjFreeSliceAt_sup_range_descPair (hD : 2 ≤ D)
    (F : DDFLightConeFrame η a b) (hη : ∀ μ, η μ * η μ = 1) (j : ℤ) (N : ℕ) (hN : 2 ≤ N) :
    towerBigrade D K j N
      ≤ conjFreeSliceAt hD F j N ⊔ LinearMap.range (descPair η a b j N) :=
  le_trans (towerBigrade_le_ordSeedSpan hD F hη j N)
    (le_trans (ordSeedSpan_le_conjFreeSliceAt_sup_pos hD F j N)
      (sup_le_sup_left (ordSeedSpanPos_le_range_descPair hD F hη j N hN) _))

/-- ⭐ **Blueprint §B⁗.3 (c), the kernel bound (K)**, in the subtraction-free shape `omega`
wants:

`dim ker T_N + p_D(N) ≤ p_D(N−1) + p_D(N−2) + p_{D−1}(N)`.

Rank–nullity for `descPair` plus `dim V_{j,M} = p_D(M)` exactly (`finrank_towerBigrade`) and
`dim C_{j,N} ≤ p_{D−1}(N)` (`finrank_conjFreeSliceAt_le`).

⭐ `D = 26`, the seed condition, physicality and `p_j·p_j ≠ 0` never enter; the bound holds on
every rung. -/
theorem finrank_ker_descPair_add_le (hD : 2 ≤ D) (F : DDFLightConeFrame η a b)
    (hη : ∀ μ, η μ * η μ = 1) (j : ℤ) (N : ℕ) (hN : 2 ≤ N) :
    Module.finrank K ↥(LinearMap.ker (descPair η a b j N))
        + Nat.card {d : Osc D →₀ ℕ // Fock.level D d = N}
      ≤ Nat.card {d : Osc D →₀ ℕ // Fock.level D d = N - 1}
        + Nat.card {d : Osc D →₀ ℕ // Fock.level D d = N - 2}
        + Fintype.card {d : Osc D →₀ ℕ // Fock.level D d = N ∧ conjDeg hD d = 0} := by
  classical
  have hfin1 : FiniteDimensional K ↥(towerBigrade D K j (N - 1)) := towerBigrade_finite _ _
  have hfin2 : FiniteDimensional K ↥(towerBigrade D K j (N - 2)) := towerBigrade_finite _ _
  have hfree1 : Module.Free K ↥(towerBigrade D K j (N - 1)) :=
    Module.Free.of_divisionRing K ↥(towerBigrade D K j (N - 1))
  have hfree2 : Module.Free K ↥(towerBigrade D K j (N - 2)) :=
    Module.Free.of_divisionRing K ↥(towerBigrade D K j (N - 2))
  have hfinprod : FiniteDimensional K
      (↥(towerBigrade D K j (N - 1)) × ↥(towerBigrade D K j (N - 2))) :=
    inferInstanceAs (Module.Finite K
      (↥(towerBigrade D K j (N - 1)) × ↥(towerBigrade D K j (N - 2))))
  -- rank–nullity
  have hrk := LinearMap.finrank_range_add_finrank_ker
    (V := ↥(towerBigrade D K j (N - 1)) × ↥(towerBigrade D K j (N - 2)))
    (V₂ := TowerFock D K) (descPair η a b j N)
  rw [Module.finrank_prod] at hrk
  -- the slice is covered by the `b̃`-free part and the range
  have hcover := towerBigrade_le_conjFreeSliceAt_sup_range_descPair hD F hη j N hN
  have hsup : Module.finrank K ↥(towerBigrade D K j N)
      ≤ Module.finrank K ↥(conjFreeSliceAt hD F j N)
        + Module.finrank K ↥(LinearMap.range (descPair η a b j N)) :=
    le_trans (Submodule.finrank_mono hcover)
      (Submodule.finrank_add_le_finrank_add_finrank _ _)
  have hC := finrank_conjFreeSliceAt_le hD F j N
  rw [finrank_towerBigrade (D := D) K j N] at hsup
  rw [finrank_towerBigrade (D := D) K j (N - 1), finrank_towerBigrade (D := D) K j (N - 2)]
    at hrk
  omega

/-! ### The restriction to the seed spaces -/

variable (η a b) in
/-- **The seed-restricted descendant map** `Q_{j,N−1} × Q_{j,N−2} → V_{j,N}`, `(φ, ψ) ↦
`L_{−1}φ + 𝒟₂ψ`.  `LevelFourCount.typeTwoAugFour` is `seedPair … (-4) 4` (its moment-equation
proof of injectivity is strictly stronger than the counting bound below, and is kept). -/
noncomputable def seedPair (j : ℤ) (N : ℕ) :
    (↥(towerSeed η a b j (N - 1)) × ↥(towerSeed η a b j (N - 2))) →ₗ[K] TowerFock D K :=
  (towerLop η a b (-1)).comp
      ((towerSeed η a b j (N - 1)).subtype.comp (LinearMap.fst K _ _))
    + (descTwo η a b).comp
        ((towerSeed η a b j (N - 2)).subtype.comp (LinearMap.snd K _ _))

lemma seedPair_apply (j : ℤ) (N : ℕ)
    (x : ↥(towerSeed η a b j (N - 1)) × ↥(towerSeed η a b j (N - 2))) :
    seedPair η a b j N x
      = towerLop η a b (-1) (x.1 : TowerFock D K) + descTwo η a b (x.2 : TowerFock D K) := by
  simp only [seedPair, LinearMap.add_apply, LinearMap.coe_comp, Function.comp_apply,
    LinearMap.fst_apply, LinearMap.snd_apply, Submodule.subtype_apply]

variable (η a b) in
/-- The inclusion `Q_{j,N−1} × Q_{j,N−2} ↪ V_{j,N−1} × V_{j,N−2}`. -/
noncomputable def seedInclusion (j : ℤ) (N : ℕ) :
    (↥(towerSeed η a b j (N - 1)) × ↥(towerSeed η a b j (N - 2)))
      →ₗ[K] (↥(towerBigrade D K j (N - 1)) × ↥(towerBigrade D K j (N - 2))) :=
  (Submodule.inclusion (inf_le_right : towerSeed η a b j (N - 1) ≤ _)).prodMap
    (Submodule.inclusion (inf_le_right : towerSeed η a b j (N - 2) ≤ _))

lemma seedPair_eq_comp (j : ℤ) (N : ℕ) :
    seedPair η a b j N = (descPair η a b j N).comp (seedInclusion η a b j N) := by
  refine LinearMap.ext fun x => ?_
  rw [seedPair_apply, LinearMap.comp_apply, descPair_apply]
  rfl

/-- **The seed kernel is no bigger than the whole-slice kernel** (blueprint §B⁗.0: "`Q × Q` 上的
核是整片上核的子空间").  This is what makes the count of `finrank_ker_descPair_add_le` — which
knows nothing about seeds — applicable to the two null families. -/
theorem finrank_ker_seedPair_le (j : ℤ) (N : ℕ) :
    Module.finrank K ↥(LinearMap.ker (seedPair η a b j N))
      ≤ Module.finrank K ↥(LinearMap.ker (descPair η a b j N)) := by
  classical
  have hfin1 : FiniteDimensional K ↥(towerBigrade D K j (N - 1)) := towerBigrade_finite _ _
  have hfin2 : FiniteDimensional K ↥(towerBigrade D K j (N - 2)) := towerBigrade_finite _ _
  have hfinprod : FiniteDimensional K
      (↥(towerBigrade D K j (N - 1)) × ↥(towerBigrade D K j (N - 2))) :=
    inferInstanceAs (Module.Finite K
      (↥(towerBigrade D K j (N - 1)) × ↥(towerBigrade D K j (N - 2))))
  have hfinker : Module.Finite K ↥(LinearMap.ker (descPair η a b j N)) := by
    have hnoeth : IsNoetherian K
        (↥(towerBigrade D K j (N - 1)) × ↥(towerBigrade D K j (N - 2))) :=
      isNoetherian_of_isNoetherianRing_of_finite K
        (↥(towerBigrade D K j (N - 1)) × ↥(towerBigrade D K j (N - 2)))
    infer_instance
  have hincl : Function.Injective (seedInclusion η a b j N) := by
    rintro ⟨u₁, u₂⟩ ⟨v₁, v₂⟩ h
    have h1 := congrArg (fun z => (z.1 : TowerFock D K)) h
    have h2 := congrArg (fun z => (z.2 : TowerFock D K)) h
    exact Prod.ext (Subtype.ext h1) (Subtype.ext h2)
  have hmem : ∀ x : ↥(LinearMap.ker (seedPair η a b j N)),
      seedInclusion η a b j N (x : _) ∈ LinearMap.ker (descPair η a b j N) := by
    intro x
    rw [LinearMap.mem_ker, ← LinearMap.comp_apply, ← seedPair_eq_comp]
    exact x.2
  refine LinearMap.finrank_le_finrank_of_injective
    (f := ((seedInclusion η a b j N).comp
      (LinearMap.ker (seedPair η a b j N)).subtype).codRestrict _ hmem) ?_
  intro u v huv
  exact Subtype.ext (hincl (congrArg Subtype.val huv))

end DescPair

end StringFormal.NoGhost
