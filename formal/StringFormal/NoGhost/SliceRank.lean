/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas
import StringFormal.NoGhost.Glue

/-!
# The critical dimension as a rank inequality on one slice

Graph nodes: `worldsheet.ddf-spanning-hypothesis`, `worldsheet.no-ghost-theorem-v4`
(the `ddf-spans` gap `(B-26)`).  This is **PR1 of blueprint §B′** in
`formal/BLUEPRINT-noghost.md`.

## What this file buys

`Glue.ddfSpans_of_forall_antidiagonal_slice_int` already reduces the spanning lemma
`DDFSpans` to a statement on each antidiagonal slice `V_N := towerBigrade (-N) N`.  Writing

```
H_N := H_phys ⊓ V_N,   D_N := ddfSpan ⊓ V_N,   Z_N := H_null ⊓ V_N
```

the slice statement `DDFSpansOn … V_N` says `H_N ≤ ddfSpan ⊔ H_null`.  Two facts that are
*independent of `D`* turn this into a comparison of three natural numbers:

* `D_N ⊔ Z_N ≤ H_N` — DDF states and null states are physical;
* `D_N ⊓ Z_N = ⊥` — **`ddfSpan_inf_towerNullSubmodule_eq_bot`**: a DDF state has strictly
  positive norm (`ddf_span_pos`) while a null state has zero norm.

Hence `finrank (D_N ⊔ Z_N) = finrank D_N + finrank Z_N`, and
`Submodule.eq_of_le_of_finrank_le` upgrades a rank inequality to the equality
`H_N = D_N ⊔ Z_N`.  The rank inequality is `B26` below.  **`D = 26` does not appear in this
file**: exactly as in `Assembly.lean` and `Glue.lean`, the critical dimension is entirely
inside the `Prop` `B26 … N`, which is where blueprint §B.5 says it belongs.

## Main definitions

* `B26 η a b hη Ε N` — blueprint §B′.3, the rank form of the critical-dimension input:
  `finrank H_N ≤ finrank D_N + finrank Z_N`.

## Main results

* `ddfSpan_inf_towerNullSubmodule_eq_bot` — the DDF sector meets the null states only in `0`
  (over an ordered field, for **every** intercept `a₀`).
* `eq_sup_of_finrank_le` — the abstract rank criterion used, stated for arbitrary submodules
  of an arbitrary vector space; it is elementary and is isolated so that the string-theoretic
  lemmas read cleanly.
* `ddfSpansOn_bigrade_of_b26` — **`B26 N` implies the slice spanning lemma on `V_N`.**
* `ddfSpans_of_forall_b26` — `B26` for every `N` implies `DDFSpans`, via the `Glue` reduction.

## Deviations from blueprint §B′ (the "§B′ corrections" of this branch)

1. §B′.4 lists the *equivalence* `ddfSpansOn_bigrade_iff_b26`.  Only the direction that is
   actually consumed (`B26 → DDFSpansOn`, i.e. `ddfSpansOn_bigrade_of_b26`) is proved here.
   The converse is **not** free: from `H_N ≤ ddfSpan ⊔ H_null` one must *project* a
   decomposition `x = d + z` back onto the slice, which needs `ddfSpan` and
   `towerNullSubmodule` to be homogeneous for the bigrading — that is
   `frameMonomial_mem_towerBigrade`, i.e. PR2.  The converse and the packaged `iff` therefore
   live in `StringFormal/NoGhost/SliceDim.lean`, which imports this file.  Consequently the
   PR1/PR2 dependency runs **PR1 → PR2**, not the other way round as drawn in §B′.7.
2. `ddfSpan_inf_towerNullSubmodule_eq_bot` is proved for an arbitrary intercept `a₀`, not only
   for `a₀ = α' k²`: the positivity input `ddf_span_pos` does not mention the intercept.

## Conventions

Mostly-plus metric with `η μ * η μ = 1`, `b·b = 0`, `b·a = 1`; the intercept is the
ground-state one `a₀ = invTwo K * Fock.zeroModeSq η a` (`= α' k²`), as in `Assembly.lean`.
The ordered-field hypotheses enter **only** through `ddf_span_pos`; see the blueprint's note
that a `CharZero` version is available from the diagonality of the DDF Gram matrix.

## Status

Complete, no `sorry`; axioms are `propext`, `Classical.choice`, `Quot.sound` only.
-/

namespace StringFormal.NoGhost

open Module

/-! ### An abstract rank criterion

If two finite-dimensional subspaces `S`, `T` of `H` meet only in `0` and their dimensions add
up to at least `dim H`, they span `H`.  Nothing here is specific to string theory. -/

section RankCriterion

variable {K V : Type*} [Field K] [AddCommGroup V] [Module K V]

/-- **Rank criterion for spanning.**  `S ≤ H`, `T ≤ H`, `S ⊓ T = ⊥` and
`finrank H ≤ finrank S + finrank T` force `H = S ⊔ T`.

This is the finite-dimensional bookkeeping behind blueprint §B′.2: it converts the submodule
inclusion `H_phys ∩ V_N ≤ ddfSpan ⊔ H_null` into a comparison of three natural numbers. -/
theorem eq_sup_of_finrank_le {S T H : Submodule K V} [FiniteDimensional K H]
    [FiniteDimensional K S] [FiniteDimensional K T] (hS : S ≤ H) (hT : T ≤ H)
    (hdisj : S ⊓ T = ⊥) (hrank : finrank K H ≤ finrank K S + finrank K T) :
    H = S ⊔ T := by
  have hsum : finrank K ↥(S ⊔ T) + finrank K ↥(S ⊓ T) = finrank K S + finrank K T :=
    Submodule.finrank_sup_add_finrank_inf_eq S T
  rw [hdisj, finrank_bot, add_zero] at hsum
  exact (Submodule.eq_of_le_of_finrank_le (sup_le hS hT) (by rw [hsum]; exact hrank)).symm

end RankCriterion

/-! ### The DDF sector meets the null states only in zero -/

section Disjoint

variable {D : ℕ} {K : Type*} [Field K] [LinearOrder K] [IsStrictOrderedRing K] [Algebra ℚ K]
variable {η a b : Fin D → K}
variable (hη : ∀ μ, η μ * η μ = 1) (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1)
variable (Ε : TransverseFrame η b)

include hbb hba in
/-- **`ddfSpan ⊓ H_null = ⊥`** (blueprint §B′.4, PR1).

A nonzero DDF state has strictly positive norm (`ddf_span_pos`), a null state has zero norm
(`towerPairing_self_eq_zero_of_mem_towerNullSubmodule`).  The intercept plays no role, so this
holds for every `a₀`.

This is the only place in the general-`N` thread where the order on `K` is used. -/
theorem ddfSpan_inf_towerNullSubmodule_eq_bot (a₀ : K) :
    ddfSpan η a b hη Ε ⊓ towerNullSubmodule η a b a₀ = ⊥ := by
  refine le_antisymm (fun x hx => ?_) bot_le
  obtain ⟨hd, hn⟩ := Submodule.mem_inf.1 hx
  rw [Submodule.mem_bot]
  by_contra hne
  have hpos := ddf_span_pos hη hbb hba Ε hd hne
  rw [towerPairing_self_eq_zero_of_mem_towerNullSubmodule hn] at hpos
  exact lt_irrefl (0 : K) hpos

end Disjoint

/-! ### `(B-26)` as a rank inequality, and its consumer -/

section B26

variable {D : ℕ} {K : Type*} [Field K] [LinearOrder K] [IsStrictOrderedRing K] [Algebra ℚ K]
variable {η a b : Fin D → K} {hη : ∀ μ, η μ * η μ = 1} {Ε : TransverseFrame η b}

variable (η a b) in
/-- **`(B-26)`, the single place where the critical dimension enters Goddard–Thorn**, written
as a rank inequality on the antidiagonal slice `(rung -N, oscillator level N)`:

`dim (H_phys ∩ V_N) ≤ dim (ddfSpan ∩ V_N) + dim (H_null ∩ V_N)`.

Blueprint §B′.3.  The reverse inequality is unconditional (`ddfSpansOn_bigrade_of_b26`'s
proof produces it), so this is an *equivalent rewriting* of the graph card's phrasing "the
rank of the form on `H_phys ∩ V_N` is exactly `p_{D−2}(N)`", not a weakening.

`D = 26` is not mentioned: it is what one must *supply* in order to prove this `Prop`. -/
def B26 (η a b : Fin D → K) (hη : ∀ μ, η μ * η μ = 1) (Ε : TransverseFrame η b) (N : ℕ) :
    Prop :=
  finrank K ↥(towerPhysSubmodule η a b (invTwo K * Fock.zeroModeSq η a)
                ⊓ towerBigrade D K (-(N : ℤ)) N)
    ≤ finrank K ↥(ddfSpan η a b hη Ε ⊓ towerBigrade D K (-(N : ℤ)) N)
      + finrank K ↥(towerNullSubmodule η a b (invTwo K * Fock.zeroModeSq η a)
                      ⊓ towerBigrade D K (-(N : ℤ)) N)

variable (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1)

include hη hbb hba in
/-- **The slice spanning lemma follows from the rank inequality.**  Blueprint §B′.4, PR1.

The three inputs are `ddfSpan ≤ H_phys`, `H_null ≤ H_phys` and
`ddfSpan_inf_towerNullSubmodule_eq_bot`; `eq_sup_of_finrank_le` does the rest.  The
finite-dimensionality is inherited from `towerBigrade_finite`. -/
theorem ddfSpansOn_bigrade_of_b26 {N : ℕ} (h : B26 η a b hη Ε N) :
    DDFSpansOn η a b hη Ε (towerBigrade D K (-(N : ℤ)) N) := by
  have hS : ddfSpan η a b hη Ε ⊓ towerBigrade D K (-(N : ℤ)) N
      ≤ towerPhysSubmodule η a b (invTwo K * Fock.zeroModeSq η a)
          ⊓ towerBigrade D K (-(N : ℤ)) N :=
    inf_le_inf_right _ (ddfSpan_le_towerPhysSubmodule η a b hη hbb hba Ε)
  have hT : towerNullSubmodule η a b (invTwo K * Fock.zeroModeSq η a)
        ⊓ towerBigrade D K (-(N : ℤ)) N
      ≤ towerPhysSubmodule η a b (invTwo K * Fock.zeroModeSq η a)
          ⊓ towerBigrade D K (-(N : ℤ)) N :=
    inf_le_inf_right _ towerNullSubmodule_le_towerPhysSubmodule
  have hdisj : (ddfSpan η a b hη Ε ⊓ towerBigrade D K (-(N : ℤ)) N)
        ⊓ (towerNullSubmodule η a b (invTwo K * Fock.zeroModeSq η a)
            ⊓ towerBigrade D K (-(N : ℤ)) N) = ⊥ :=
    le_antisymm
      ((inf_le_inf inf_le_left inf_le_left).trans
        (le_of_eq (ddfSpan_inf_towerNullSubmodule_eq_bot hη hbb hba Ε _))) bot_le
  have hsplit := eq_sup_of_finrank_le hS hT hdisj h
  rw [DDFSpansOn, hsplit]
  exact sup_le (le_sup_of_le_left inf_le_left) (le_sup_of_le_right inf_le_left)

include hη hbb hba in
/-- **`(B-26)` for every `N` implies the DDF spanning lemma.**  Blueprint §B′.4, PR1; this is
the theorem the whole general-`N` thread is aimed at, and it is the point at which
`Glue.ddfSpans_of_forall_antidiagonal_slice_int` is consumed.

Together with `Assembly.no_ghost_of_spans` it says: *the no-ghost theorem follows from the
family of rank inequalities `B26 N`.* -/
theorem ddfSpans_of_forall_b26 (h : ∀ N : ℕ, B26 η a b hη Ε N) : DDFSpans η a b hη Ε :=
  ddfSpans_of_forall_antidiagonal_slice_int hbb hba fun N =>
    ddfSpansOn_bigrade_of_b26 hbb hba (h N)

include hη hbb hba in
/-- **`(B-26)` for every `N` implies `DDFSpansAtIntercept`.**  Graph card
`worldsheet.ddf-spanning-hypothesis-v2`: the reduction `ddfSpans_of_forall_b26` above carries no
condition on the intercept at all (it is valid for every `a₀`), so discharging the card's
implication form is immediate — the intercept hypothesis is simply unused. -/
theorem ddfSpansAtIntercept_of_forall_b26 (h : ∀ N : ℕ, B26 η a b hη Ε N) :
    DDFSpansAtIntercept η a b hη Ε :=
  fun _ => ddfSpans_of_forall_b26 hbb hba h

end B26

end StringFormal.NoGhost
