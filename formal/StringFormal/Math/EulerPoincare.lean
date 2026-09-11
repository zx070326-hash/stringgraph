/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import Mathlib.LinearAlgebra.Dimension.RankNullity
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas
import Mathlib.Algebra.BigOperators.Intervals

/-!
# The Euler–Poincaré principle

Graph node: `math.euler-poincare-principle`.

For a cochain complex of finite-dimensional vector spaces over a field `K` which vanishes
outside finitely many degrees,

  `Σ_n (−1)^n dim_K C^n = Σ_n (−1)^n dim_K H^n(C)`.

This is part **(1)** of the card (the "characteristic" version).

## Why this is not a bridge lemma

Mathlib `v4.33.1` has `Mathlib/Algebra/Homology/EulerCharacteristic.lean`, which defines
`HomologicalComplex.eulerChar` and `HomologicalComplex.homologyEulerChar` (via `finsum`, with
signs from `ComplexShape.EulerCharSigns`) and proves that these `finsum`s agree with finite
`Finset` sums.  It does **not** prove `eulerChar = homologyEulerChar`, i.e. the
Euler–Poincaré principle itself is missing from Mathlib.  So this file proves it, rather than
restating a Mathlib theorem in the `StringFormal.Bridge` namespace.

## Indexing convention (and the trap it avoids)

The naive encoding `d n : C n →ₗ[K] C (n+1)` makes `LinearMap.range (d (n-1))` live in
`C (n-1+1)`, which is *not* definitionally `C n`; every statement then needs transport along
`n - 1 + 1 = n`.  Following Mathlib's `HomologicalComplex`, we instead use a **doubly indexed**
differential `d m n : C m →ₗ[K] C n`, required to vanish unless `n = m + 1`.  Then

  `cocycles d n     = ker   (d n (n+1))`   and
  `coboundaries d n = range (d (n-1) n)`

are both `Submodule K (C n)` on the nose, with no casts anywhere.  Indexing by `ℕ` (rather than
`ℤ`) is an extra convenience: truncated subtraction gives `0 - 1 = 0`, so
`coboundaries d 0 = range (d 0 0) = ⊥` automatically, and `n + 1 - 1 = n` holds definitionally.

## Scope: what is and is not proved here

* Proved: the alternating-sum identity over `Finset.range N` for a complex with
  `Subsingleton (C N)` (`euler_poincare`).
* **Not** proved (card item (a), explicitly excluded there): the *signature* version
  `Σ_n sign H^n = Σ_n sign C^n` of Lian–Zuckerman, which needs a nondegenerate Hermitian form
  with `d` self-adjoint.
* **Not** proved: the direct-sum decomposition `H^n(C) = ⊕_λ H^n(C_λ)` mentioned inside card
  item (2).  Here the graded version takes as input a *family of complexes indexed by the
  weights* and concludes the identity of formal characters; identifying that family with the
  weight pieces of a single graded complex is a separate (purely bookkeeping) step that this
  file does not perform.
* Degree convention: the complex is indexed by `ℕ`, not `ℤ`.  A `ℤ`-indexed complex with only
  finitely many nonzero terms is a shift of one of these, and `(-1)^n` is invariant under
  `n ↦ n + c` up to the overall sign `(-1)^c`; the identity is therefore unaffected.  Making
  that reindexing itself a Lean theorem is not done here.
-/

namespace StringFormal.EulerPoincare

open Module Submodule Finset

variable {K : Type*} [Field K] {C : ℕ → Type*}
  [∀ n, AddCommGroup (C n)] [∀ n, Module K (C n)]

variable (d : ∀ m n : ℕ, C m →ₗ[K] C n)

/-- A (cochain) complex: `d m n` vanishes unless `n = m + 1`, and consecutive differentials
compose to zero. -/
structure IsComplex : Prop where
  /-- The differential only connects consecutive degrees. -/
  shape : ∀ m n : ℕ, m + 1 ≠ n → d m n = 0
  /-- `d ∘ d = 0`. -/
  d_comp_d : ∀ n : ℕ, (d (n + 1) (n + 1 + 1)).comp (d n (n + 1)) = 0

/-- The cocycles `Z^n = ker (d^n : C^n → C^{n+1})`. -/
def cocycles (n : ℕ) : Submodule K (C n) := LinearMap.ker (d n (n + 1))

/-- The coboundaries `B^n = im (d^{n-1} : C^{n-1} → C^n)`.  For `n = 0` truncated subtraction
gives `d 0 0`, which is `0` for any complex, so `B^0 = ⊥` as it should be. -/
def coboundaries (n : ℕ) : Submodule K (C n) := LinearMap.range (d (n - 1) n)

/-- The cohomology `H^n(C) = Z^n / B^n`. -/
abbrev cohomology (n : ℕ) : Type _ :=
  ↥(cocycles d n) ⧸ (coboundaries d n).comap (cocycles d n).subtype

@[simp] lemma coboundaries_succ (n : ℕ) :
    coboundaries d (n + 1) = LinearMap.range (d n (n + 1)) := rfl

lemma coboundaries_zero : coboundaries d 0 = LinearMap.range (d 0 0) := rfl

variable {d}

lemma coboundaries_zero_eq_bot (hd : IsComplex d) : coboundaries d 0 = ⊥ := by
  rw [coboundaries_zero, hd.shape 0 0 (by omega), LinearMap.range_zero]

lemma coboundaries_le_cocycles (hd : IsComplex d) (n : ℕ) :
    coboundaries d n ≤ cocycles d n := by
  cases n with
  | zero => simp [coboundaries_zero_eq_bot hd]
  | succ m =>
      rintro x ⟨y, rfl⟩
      have h := hd.d_comp_d m
      have : (d (m + 1) (m + 1 + 1)) ((d m (m + 1)) y) = 0 := by
        rw [← LinearMap.comp_apply, h, LinearMap.zero_apply]
      exact this

section Finite

variable [∀ n, FiniteDimensional K (C n)]

/-- Rank–nullity applied to `d^n : C^n → C^{n+1}`: `dim C^n = dim B^{n+1} + dim Z^n`. -/
lemma finrank_coboundaries_succ_add_finrank_cocycles (n : ℕ) :
    finrank K (coboundaries d (n + 1)) + finrank K (cocycles d n) = finrank K (C n) := by
  exact LinearMap.finrank_range_add_finrank_ker (d n (n + 1))

/-- `dim H^n = dim Z^n − dim B^n`, in the additive form. -/
lemma finrank_cohomology_add_finrank_coboundaries (hd : IsComplex d) (n : ℕ) :
    finrank K (cohomology d n) + finrank K (coboundaries d n) = finrank K (cocycles d n) := by
  have hmap : ((coboundaries d n).comap (cocycles d n).subtype).map (cocycles d n).subtype
      = coboundaries d n := by
    rw [Submodule.map_comap_subtype, inf_of_le_right (coboundaries_le_cocycles hd n)]
  have hq : finrank K ((coboundaries d n).comap (cocycles d n).subtype)
      = finrank K (coboundaries d n) :=
    calc finrank K ((coboundaries d n).comap (cocycles d n).subtype)
        = finrank K
            (((coboundaries d n).comap (cocycles d n).subtype).map (cocycles d n).subtype) :=
          (Submodule.finrank_map_subtype_eq _ _).symm
      _ = finrank K (coboundaries d n) := by rw [hmap]
  have := Submodule.finrank_quotient_add_finrank
    ((coboundaries d n).comap (cocycles d n).subtype)
  rwa [hq] at this

/-- The telescoping term `(−1)^n dim B^n`. -/
private noncomputable def eulerBoundary (d : ∀ m n : ℕ, C m →ₗ[K] C n) (n : ℕ) : ℤ :=
  (-1 : ℤ) ^ n * finrank K (coboundaries d n)

private lemma term_eq_telescope (hd : IsComplex d) (n : ℕ) :
    (-1 : ℤ) ^ n * finrank K (C n) - (-1 : ℤ) ^ n * finrank K (cohomology d n)
      = eulerBoundary d n - eulerBoundary d (n + 1) := by
  have h1 : (finrank K (C n) : ℤ)
      = finrank K (coboundaries d (n + 1)) + finrank K (cocycles d n) := by
    exact_mod_cast (finrank_coboundaries_succ_add_finrank_cocycles (d := d) n).symm
  have h2 : (finrank K (cohomology d n) : ℤ)
      = finrank K (cocycles d n) - finrank K (coboundaries d n) := by
    have := finrank_cohomology_add_finrank_coboundaries hd n
    omega
  simp only [eulerBoundary, h1, h2, pow_succ]
  ring

/-- **Euler–Poincaré principle**, card item (1).

If `(C^•, d)` is a cochain complex of finite-dimensional `K`-vector spaces which vanishes in
degree `N`, then the alternating sums of dimensions over the degrees `0, …, N-1` of the complex
and of its cohomology agree. -/
theorem euler_poincare (hd : IsComplex d) (N : ℕ) (hN : Subsingleton (C N)) :
    ∑ n ∈ Finset.range N, (-1 : ℤ) ^ n * finrank K (C n)
      = ∑ n ∈ Finset.range N, (-1 : ℤ) ^ n * finrank K (cohomology d n) := by
  have hb0 : eulerBoundary d 0 = 0 := by
    simp [eulerBoundary, coboundaries_zero_eq_bot hd]
  have hbN : eulerBoundary d N = 0 := by
    have hle : finrank K (coboundaries d N) ≤ finrank K (C N) := Submodule.finrank_le _
    have hz : finrank K (C N) = 0 := Module.finrank_zero_of_subsingleton
    have : finrank K (coboundaries d N) = 0 := by omega
    simp [eulerBoundary, this]
  have hsum : ∑ n ∈ Finset.range N,
      ((-1 : ℤ) ^ n * finrank K (C n) - (-1 : ℤ) ^ n * finrank K (cohomology d n)) = 0 := by
    rw [Finset.sum_congr rfl (fun n _ => term_eq_telescope hd n),
      Finset.sum_range_sub' (eulerBoundary d) N, hb0, hbN, sub_zero]
  rw [← sub_eq_zero, ← Finset.sum_sub_distrib]
  exact hsum

end Finite

end StringFormal.EulerPoincare
