/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.LevelSixCount

/-!
# `B26 6`, conditional on the `N = 6` seed-kernel-sharpening hypothesis

Graph nodes: `worldsheet.ddf-spanning-hypothesis`, `worldsheet.no-ghost-theorem-v4`.

`NoGhost/LevelSixCount.lean`'s module docstring (`⚠` section) proves that porting the `N = 5`
closure route (`LevelFiveCount.b26_five_of_D26`) verbatim to `N = 6` gives

`dim(H_phys ⊓ V₆) ≤ dim(ddfSpan ⊓ V₆) + dim(H_null ⊓ V₆) + 1`,

exactly one more than `B26 6` needs, because the *generic* two-family kernel bound (K6) has
slack `κ₆ = D` (`finrank_ker_descPair_six_le`) where the target needs slack `D − 1`
(`dim Q_{-6,1}`).  `LevelSixCount.lean` **deliberately stops there**: it does not state `b26_six`
or `ddfSpans_bigrade_neg_six_six`, because writing an incomplete statement (or a `sorry`) would
be worse than not writing it.

This file closes the gap **conditionally**: it isolates the missing input as a single named
hypothesis, `SixSeedKernelSharp`, and proves `B26 6` and the level-six slice of `ddf-spans` from
it, porting the rest of `LevelFiveCount.lean`'s route mechanically.

## Which form of the hypothesis was chosen, and why

`LevelSixCount.lean`'s `⚠` section identifies the missing fact as: the syzygy map

`S₆ : V_{-6,1} → V_{-6,5} × V_{-6,4}, u ↦ (x₄u, y₃u)`

(`x4`, `y3` from `SeedTransferSix.lean`) is **injective on the whole slice `V_{-6,1}`**
(dimension `D`), not merely on the seed subspace `Q_{-6,1}` (dimension `D − 1`, where injectivity
is free from `SeedCriterionSix.mem_towerSeed_neg_six_one_iff`'s forward direction composed with
`SeedTransferSix`'s syzygy identity — a seed `u` with `x₄u = y₃u = 0` forces `u = 0` because a
nonzero seed has nonzero image, see `SingularVectorsSixSlice`).  There are two ways to phrase a
Lean hypothesis carrying this content:

**(A) Literal `S₆`-injectivity** on `towerBigrade D K (-6) 1` (dimension `D`).  This is
mathematically the more fundamental statement, and the one future work (see the integration
checklist below) is expected to actually prove.  Deriving the sharp kernel bound from it needs a
genuine dimension-squeeze argument:

1. `S₆(v) ∈ ker(descPair η a b (-6) 6)` for **every** `v ∈ V_{-6,1}`, unconditionally — this is
   immediate from the syzygy identity `SeedTransferSix.towerLop_neg_one_mul_x4_add_descTwo_mul_y3`
   applied to `v` (no seed hypothesis needed).
2. If `S₆` is injective on `V_{-6,1}` (`dim = D`), then `dim S₆(V_{-6,1}) = D`; combined with the
   generic bound `finrank_ker_descPair_six_le : dim ker(descPair) ≤ D`, a `D`-dimensional subspace
   of a `≤ D`-dimensional space forces equality, i.e. `S₆(V_{-6,1}) = ker(descPair η a b (-6) 6)`
   **exactly** (`Submodule.eq_of_le_of_finrank_le` or equivalent).
3. Intersecting both sides with `towerSeed η a b (-6) 5 ×ˢ towerSeed η a b (-6) 4` (as sets; on
   the `S₆` side this uses the already-proved **both directions** of `[GAP-N6-seed]`,
   `SeedCriterionSix.mem_towerSeed_neg_six_one_iff`, to identify `S₆⁻¹(Q × Q) ⊓ V_{-6,1}` with
   `Q_{-6,1}`) gives `ker(seedPair η a b (-6) 6) = S₆(Q_{-6,1})`.
4. `S₆` restricted to `Q_{-6,1}` (dimension `D − 1`) is still injective (it is the restriction of
   an injective map), so `dim S₆(Q_{-6,1}) = D − 1`, i.e. `dim ker(seedPair η a b (-6) 6) = D − 1`
   — sharper than (and in particular gives) the bound `≤ D − 1` needed below.

**(B) The direct dimension bound** `dim ker(seedPair η a b (-6) 6) ≤ D − 1` as the hypothesis
itself (no reference to `S₆`, `x4`, `y3`).

We use **form (B)**, named `SixSeedKernelSharp` below, for three reasons: (i) it plugs directly
into the existing (K6)/(N6) infrastructure
(`LevelSixCount.le_finrank_towerNull_inf_towerBigrade_six`) by replacing exactly one `have` line,
so the closing argument below is a line-for-line port of `LevelFiveCount.b26_five_of_D26` with
minimal new Lean code and minimal implementation risk; (ii) it is the *weakest* statement that
the rest of the route needs — nothing downstream cares whether the sharp bound came from
`S₆`-injectivity or from some other argument, so exposing exactly this much keeps the hypothesis
as weak (hence as easy to eventually discharge, from as many possible angles) as possible; (iii)
the four-step derivation above is recorded here in full, in prose, so that a future proof of (A)
has an explicit, checked roadmap for deriving (B) from it (see the integration checklist below) —
the task does not require formalising the equivalence, only documenting it.

⭐ **This hypothesis is currently unproven anywhere in this repository.** It is explicitly flagged
as an unverified route judgement by `formal/BLUEPRINT-noghost.md` §B⁗.7 (the `⟨路线判断，未验证⟩`
tag, attached to the very derivation whose step 2 is exactly `S₆`-injectivity) and by §B⁗.9's
"状态与下一步" listing `b26_six` as not done. It is **genuinely new mathematics**: neither a PBW
triangularity argument (showing `x₄`, `y₃` applied to a non-seed vector of `V_{-6,1}` must pick
up a nonzero non-seed component) nor a fresh explicit moment computation (in the style of
`LevelThreeCount`/`LevelFourCount`) for it exists in this repository or, as far as this
formalisation effort has established, in the published literature on the `N = 6` level of the
Goddard–Thorn argument. A separate proof attempt lives in
`research/attempts/s6-injectivity-level-six/` (outside this file's scope).

## Contents

* `card_conjFree_five_ge` — the level-five lower-bound companion of
  `LevelFiveCount.card_conjFree_four_ge` / `LevelThreeCount.card_conjFree_three_ge`, needed here
  because the `N = 6` closure consumes `p_{D-1}(5)` on the input side. It is placed in this file
  (not in `LevelFiveCount.lean`) to avoid touching an already-closed PR file; mathematically it
  belongs alongside its level-three/level-four siblings.
* `SixSeedKernelSharp` — the named hypothesis, form (B) above.
* `le_finrank_towerNull_inf_towerBigrade_six_of_sixSeedKernelSharp` — (N6) with slack sharpened
  from `D` to `D − 1`, conditional on the hypothesis; otherwise identical to
  `LevelSixCount.le_finrank_towerNull_inf_towerBigrade_six`.
* `b26_six_of_sixSeedKernelSharp` — `B26 6` conditional on the hypothesis, porting
  `LevelFiveCount.b26_five_of_D26`'s proof verbatim (`5 → 6`, `4 → 5`, `3 → 4`).
* `ddfSpans_bigrade_neg_six_six_of_sixSeedKernelSharp` — the level-six slice of `ddf-spans`,
  conditional on the hypothesis, via `SliceRank.ddfSpansOn_bigrade_of_b26`.

## What is **not** done here

* The hypothesis `SixSeedKernelSharp` itself is not proved (see above) — that is out of scope for
  this file by design.
* Form (A) (literal `S₆`-injectivity) is not stated or related to form (B) in Lean; only the
  prose derivation above records the relationship.
* `N ≥ 7`: blueprint §B⁗.7 explains the pattern generalises (`κ_N` outgrows `τ_N` further, and a
  second syzygy pair `(x₆, y₅)` enters at `N = 7`), but nothing about that is attempted here.

## Status

No `sorry`, no `native_decide`. All declarations `check_axioms`-clean (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

namespace StringFormal.NoGhost

/-! ### The level-five lower bound `card_conjFree_five_ge`

The level-five companion of `LevelFiveCount.card_conjFree_four_ge` /
`LevelThreeCount.card_conjFree_three_ge`: mirrors their proof exactly, substituting the level-five
generic lower bound `card_ddfLevel_five_ge` for the level-four/level-three ones. -/

section ConjFreeFiveLowerBound

variable {D : ℕ}

/-- **`p_{D−1}(5) ≥ (D−1) + 2(D−1)² + 2(D−1)C(D,2) + (D−1)C(D+1,3) + C(D+3,5)`**, the lower bound
companion to `LevelFiveCount.card_conjFree_five_le` (U5). Needed by `b26_six_of_sixSeedKernelSharp`
because closing `B26 6` consumes `p_{D-1}(5)` (via `LevelFiveCount.le_finrank_towerSeed` at
`M = 5`) on the input side, exactly as `card_conjFree_four_ge` was needed by `b26_five_of_D26`. -/
theorem card_conjFree_five_ge (hD : 2 ≤ D) :
    (D - 1) + 2 * ((D - 1) * (D - 1)) + 2 * ((D - 1) * Nat.choose D 2)
        + (D - 1) * Nat.choose (D + 1) 3 + Nat.choose (D + 3) 5
      ≤ Fintype.card {d : Osc D →₀ ℕ // Fock.level D d = 5 ∧ conjDeg hD d = 0} := by
  classical
  have hκ : Fintype.card {μ : Fin D // μ ≠ conjIdx D hD} = D - 1 := by
    rw [Fintype.card_subtype_compl, Fintype.card_subtype_eq, Fintype.card_fin]
  have h1 := card_ddfLevel_five_ge {μ : Fin D // μ ≠ conjIdx D hD}
  have h2 := card_ddfLevel_le_card_conjFree hD 5
  rw [hκ, show D - 1 + 1 = D by omega, show D - 1 + 2 = D + 1 by omega,
    show D - 1 + 4 = D + 3 by omega] at h1
  omega

end ConjFreeFiveLowerBound

/-! ### The named hypothesis -/

section Hypothesis

variable {D : ℕ} {K : Type*} [Field K] [CharZero K] [Algebra ℚ K]

/-- ⭐⭐⭐ **The named hypothesis this file's conditional results depend on.**

`dim ker(seedPair η a b (-6) 6) ≤ D − 1`, i.e. the two-family descendant map restricted to the
`N = 6` seeds on rung `-6` (`T₆|_{Q_{-6,5} × Q_{-6,4}}`) has kernel of dimension at most `D − 1`,
sharper by one than the generic bound `LevelSixCount.finrank_ker_seedPair_six_le : ≤ D`.

See the module docstring above for: (a) why this dimension-bound form was chosen over the
equivalent-in-spirit but more work-intensive literal `S₆`-injectivity statement, (b) the full
four-step derivation relating the two forms, and (c) the citation of
`formal/BLUEPRINT-noghost.md` §B⁗.7/§B⁗.9 flagging the underlying route judgement as
`⟨路线判断，未验证⟩`.

⭐ **This `Prop` is not proved by any declaration in this repository.** It is genuinely new
mathematics, out of scope for this file by design (see the module docstring). -/
def SixSeedKernelSharp (η a b : Fin D → K) : Prop :=
  Module.finrank K ↥(LinearMap.ker (seedPair η a b (-6) 6)) ≤ D - 1

end Hypothesis

/-! ### (N6), sharpened: `dim(H_null ⊓ V₆) ≥ dim Q_{-6,5} + dim Q_{-6,4} − (D − 1)` -/

section KernelSixSharp

variable {D : ℕ} {K : Type*} [Field K] [CharZero K] [Algebra ℚ K] {η a b : Fin D → K}

/-- ⭐⭐ **(N6), sharpened, conditional on `SixSeedKernelSharp`:**

`dim Q_{-6,5} + dim Q_{-6,4} ≤ dim (H_null ⊓ V₆) + (D − 1)`.

Line-for-line identical to `LevelSixCount.le_finrank_towerNull_inf_towerBigrade_six`, except the
final `omega` step uses `hsharp` (slack `D − 1`) in place of the generic
`finrank_ker_seedPair_six_le` (slack `D`). -/
theorem le_finrank_towerNull_inf_towerBigrade_six_of_sixSeedKernelSharp (hD : 2 ≤ D)
    (F : DDFLightConeFrame η a b) (haa : Fock.zeroModeSq η a = 2) (hD26 : (D : K) = 26)
    (hsharp : SixSeedKernelSharp η a b) :
    Module.finrank K ↥(towerSeed η a b (-6) 5) + Module.finrank K ↥(towerSeed η a b (-6) 4)
      ≤ Module.finrank K
          ↥(towerNullSubmodule η a b (1 : K) ⊓ towerBigrade D K (-6) 6) + (D - 1) := by
  classical
  have hQ5fin : FiniteDimensional K ↥(towerSeed η a b (-6) ((6 : ℕ) - 1)) :=
    Submodule.finiteDimensional_of_le (K := K) (V := TowerFock D K)
      (S₁ := towerSeed η a b (-6) ((6 : ℕ) - 1))
      (S₂ := towerBigrade D K (-6) ((6 : ℕ) - 1)) inf_le_right
  have hQ4fin : FiniteDimensional K ↥(towerSeed η a b (-6) ((6 : ℕ) - 2)) :=
    Submodule.finiteDimensional_of_le (K := K) (V := TowerFock D K)
      (S₁ := towerSeed η a b (-6) ((6 : ℕ) - 2))
      (S₂ := towerBigrade D K (-6) ((6 : ℕ) - 2)) inf_le_right
  have hQ5free : Module.Free K ↥(towerSeed η a b (-6) ((6 : ℕ) - 1)) :=
    Module.Free.of_divisionRing K ↥(towerSeed η a b (-6) ((6 : ℕ) - 1))
  have hQ4free : Module.Free K ↥(towerSeed η a b (-6) ((6 : ℕ) - 2)) :=
    Module.Free.of_divisionRing K ↥(towerSeed η a b (-6) ((6 : ℕ) - 2))
  have hprod : FiniteDimensional K
      (↥(towerSeed η a b (-6) ((6 : ℕ) - 1)) × ↥(towerSeed η a b (-6) ((6 : ℕ) - 2))) :=
    inferInstanceAs (Module.Finite K
      (↥(towerSeed η a b (-6) ((6 : ℕ) - 1)) × ↥(towerSeed η a b (-6) ((6 : ℕ) - 2))))
  have hWfin : FiniteDimensional K
      ↥(towerNullSubmodule η a b (1 : K) ⊓ towerBigrade D K (-6) 6) :=
    Submodule.finiteDimensional_of_le (K := K) (V := TowerFock D K)
      (S₁ := towerNullSubmodule η a b (1 : K) ⊓ towerBigrade D K (-6) 6)
      (S₂ := towerBigrade D K (-6) 6) inf_le_right
  have hmem : ∀ x : ↥(towerSeed η a b (-6) ((6 : ℕ) - 1))
        × ↥(towerSeed η a b (-6) ((6 : ℕ) - 2)),
      seedPair η a b (-6) 6 x
        ∈ towerNullSubmodule η a b (1 : K) ⊓ towerBigrade D K (-6) 6 := by
    rintro ⟨⟨φ, hφ⟩, ⟨ψ, hψ⟩⟩
    have hpos5 : ∀ n : ℤ, 0 < n → towerLop η a b n φ = 0 := (mem_towerSeed.1 hφ).1
    have hbig5 : φ ∈ towerBigrade D K (-6) 5 := (mem_towerSeed.1 hφ).2
    have hpos4 : ∀ n : ℤ, 0 < n → towerLop η a b n ψ = 0 := (mem_towerSeed.1 hψ).1
    have hbig4 : ψ ∈ towerBigrade D K (-6) 4 := (mem_towerSeed.1 hψ).2
    have h1 := towerLop_neg_one_mem_towerNullSubmodule_of_mem_towerBigrade η a b F.hη
      F.frame.isotropic F.hba haa (j := -6) (N := 5) (by norm_num) hbig5 hpos5
    have h2 := descTwo_mem_towerNullSubmodule_of_mem_towerBigrade η a b F.hη F.frame.isotropic
      F.hba haa hD26 (j := -6) (N := 4) (by norm_num) hbig4 hpos4 (N' := 6) (by norm_num)
    rw [seedPair_apply]
    refine Submodule.add_mem _ ?_ h2
    have h56 : (5 : ℕ) + 1 = 6 := by norm_num
    rw [h56] at h1
    exact h1
  have hrk := LinearMap.finrank_range_add_finrank_ker
    (V := ↥(towerSeed η a b (-6) ((6 : ℕ) - 1)) × ↥(towerSeed η a b (-6) ((6 : ℕ) - 2)))
    (V₂ := TowerFock D K) (seedPair η a b (-6) 6)
  rw [Module.finrank_prod] at hrk
  have hrange : LinearMap.range (seedPair η a b (-6) 6)
      ≤ towerNullSubmodule η a b (1 : K) ⊓ towerBigrade D K (-6) 6 := by
    rintro _ ⟨x, rfl⟩
    exact hmem x
  have hle1 : Module.finrank K ↥(LinearMap.range (seedPair η a b (-6) 6))
      ≤ Module.finrank K ↥(towerNullSubmodule η a b (1 : K) ⊓ towerBigrade D K (-6) 6) :=
    Submodule.finrank_mono hrange
  have hker : Module.finrank K ↥(LinearMap.ker (seedPair η a b (-6) 6)) ≤ D - 1 := hsharp
  have he : Module.finrank K ↥(towerSeed η a b (-6) ((6 : ℕ) - 1))
      = Module.finrank K ↥(towerSeed η a b (-6) 5) := rfl
  have hf : Module.finrank K ↥(towerSeed η a b (-6) ((6 : ℕ) - 2))
      = Module.finrank K ↥(towerSeed η a b (-6) 4) := rfl
  rw [he, hf] at hrk
  omega

end KernelSixSharp

/-! ### `B26 6` and the level-six slice of `ddf-spans`, conditional on `SixSeedKernelSharp` -/

section ClosingSix

variable {D : ℕ} {K : Type*} [Field K] [LinearOrder K] [IsStrictOrderedRing K] [Algebra ℚ K]
variable {η a b : Fin D → K}

/-- ⭐⭐⭐ **`B26 6` at `D = 26`, conditional on `SixSeedKernelSharp`.**

Line-for-line port of `LevelFiveCount.b26_five_of_D26` (`5 → 6`, `4 → 5`, `3 → 4`):

`dim (H_phys ⊓ V₆) ≤ p_{D−1}(6)`, and `p_{D−1}(6) + (D-1) = p_{D−2}(6) + p_{D−1}(5) + p_{D−1}(4)
  ≤ dim (ddfSpan ⊓ V₆) + dim Q_{-6,5} + dim Q_{-6,4} ≤ dim (ddfSpan ⊓ V₆)
    + dim (H_null ⊓ V₆) + (D-1)`,

so the two `+ (D-1)`s cancel. The first `≤` is (P3), the identity is `levelSix_count_identity`,
`p_{D−2}(6) = dim (ddfSpan ⊓ V₆)` is PR2, `p_{D−1}(M) ≤ dim Q_{-6,M}` is PR6′, and the last `≤` is
`le_finrank_towerNull_inf_towerBigrade_six_of_sixSeedKernelSharp`, which is where the hypothesis
enters (and the only step using `D = 26`, exactly as in the `N = 5` case). -/
theorem b26_six_of_sixSeedKernelSharp (hD : 2 ≤ D) (F : DDFLightConeFrame η a b)
    (hD26 : (D : K) = 26) (hsharp : SixSeedKernelSharp η a b) :
    B26 η a b F.hη F.trans 6 := by
  have haa : Fock.zeroModeSq η a = 2 := F.dotVec_self_eq_two hD
  have hint : invTwo K * Fock.zeroModeSq η a = 1 := by rw [haa, invTwo_mul_two]
  have hrung : (-((6 : ℕ) : ℤ)) = (-6 : ℤ) := by norm_num
  have h1 := finrank_towerPhys_inf_towerBigrade_le (K := K) hD F 6
  have h2 := card_conjFree_six_le (D := D) hD
  have h3 := levelSix_count_identity (D := D) hD
  have h4 := (card_ddfLevel_six_eq (Fin (D - 2))).ge
  have h5 := card_conjFree_five_ge (D := D) hD
  have h6 := card_conjFree_four_ge (D := D) hD
  have h7 := le_finrank_towerSeed (K := K) hD F (-((6 : ℕ) : ℤ)) 5
  have h8 := le_finrank_towerSeed (K := K) hD F (-((6 : ℕ) : ℤ)) 4
  have h9 : Module.finrank K ↥(towerSeed η a b (-((6 : ℕ) : ℤ)) 5)
        + Module.finrank K ↥(towerSeed η a b (-((6 : ℕ) : ℤ)) 4)
      ≤ Module.finrank K ↥(towerNullSubmodule η a b (invTwo K * Fock.zeroModeSq η a)
          ⊓ towerBigrade D K (-((6 : ℕ) : ℤ)) 6) + (D - 1) := by
    rw [hint, hrung]
    exact le_finrank_towerNull_inf_towerBigrade_six_of_sixSeedKernelSharp hD F haa hD26 hsharp
  rw [Fintype.card_fin, show D - 2 + 1 = D - 1 by omega, show D - 2 + 2 = D by omega,
    show D - 2 + 3 = D + 1 by omega, show D - 2 + 5 = D + 3 by omega] at h4
  refine le_trans h1 ?_
  rw [finrank_ddfSpan_inf_towerBigrade F.hη F.frame.isotropic F.hba F.trans 6]
  omega

/-- ⭐⭐⭐ **The DDF spanning lemma on the level-six slice `(rung -6, level 6)`, at `D = 26`,
conditional on `SixSeedKernelSharp`.**

The sixth antidiagonal slice of `ddf-spans`, after `LevelFiveCount.ddfSpans_bigrade_neg_five_five`
— conditional, unlike its predecessors, on the named hypothesis (see the module docstring). -/
theorem ddfSpans_bigrade_neg_six_six_of_sixSeedKernelSharp (hD : 2 ≤ D)
    (F : DDFLightConeFrame η a b) (hD26 : (D : K) = 26) (hsharp : SixSeedKernelSharp η a b) :
    DDFSpansOn η a b F.hη F.trans (towerBigrade D K (-((6 : ℕ) : ℤ)) 6) :=
  ddfSpansOn_bigrade_of_b26 F.frame.isotropic F.hba (b26_six_of_sixSeedKernelSharp hD F hD26 hsharp)

end ClosingSix

end StringFormal.NoGhost
