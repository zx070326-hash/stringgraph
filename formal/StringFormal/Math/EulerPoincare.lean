/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import Mathlib.LinearAlgebra.Dimension.RankNullity
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas
import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Algebra.Ring.NegOnePow
import Mathlib.Data.Int.Interval

/-!
# The Euler–Poincaré principle

Graph node: `math.euler-poincare-principle`.

For a `ℤ`-graded cochain complex of finite-dimensional vector spaces over a field `K` which
vanishes outside finitely many degrees,

  `Σ_n (−1)^n dim_K C^n = Σ_n (−1)^n dim_K H^n(C)`.

This is part **(1)** of the card (the "characteristic" version).  Part **(2)** (the graded /
formal-character version) is `euler_poincare_graded`, which is literally (1) applied weight by
weight, exactly as the card says it should be.

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
`n - 1 + 1 = n`, and the transport happens in a *dependent* position, where `rw` cannot even
form a type-correct motive.  Following Mathlib's `HomologicalComplex`, we instead use a
**doubly indexed** differential `d m n : C m →ₗ[K] C n`, required to vanish unless `n = m + 1`.
Then

  `cocycles d n     = ker   (d n (n+1))`   and
  `coboundaries d n = range (d (n-1) n)`

are both `Submodule K (C n)` on the nose, with no casts anywhere.  For the same reason
`IsComplex.comp_eq_zero` is stated for *all* triples `l m n` (for non-adjacent triples it is
vacuous, since one factor is then `0` by `IsComplex.shape`): that form can be applied at
`(n-1, n, n+1)` with no index arithmetic at all.

Signs are `Int.negOnePow n : ℤˣ`, Mathlib's `(-1)^n` for integer `n` (the same device
`ComplexShape.EulerCharSigns` uses).

## Scope: what is and is not proved here

* Proved: the alternating-sum identity over `Finset.Ico a b` for a complex vanishing at `a-1`
  and at `b` (`euler_poincare`), its `finsum`-over-all-degrees form (`euler_poincare_finsum`),
  the card's "concentrated in degree 0" clause (`finrank_cohomology_zero_eq`), and the graded /
  formal-character version (`euler_poincare_graded`).
* **Not** proved (card item (a), explicitly excluded there): the *signature* version
  `Σ_n sign H^n = Σ_n sign C^n` of Lian–Zuckerman, which needs a nondegenerate Hermitian form
  with `d` self-adjoint.
* **Not** proved: the direct-sum decomposition `H^n(C) = ⊕_λ H^n(C_λ)` mentioned inside card
  item (2).  Here the graded version takes as input a *family of complexes indexed by the
  weights* and concludes the identity of formal characters; identifying that family with the
  weight pieces of a single graded complex is a separate (purely bookkeeping) step that this
  file does not perform.
* Nothing here connects these definitions to Mathlib's `HomologicalComplex`; a bridge showing
  that `cohomology d n` agrees with `HomologicalComplex.homology` is a separate task.
-/

namespace StringFormal.EulerPoincare

open Module Submodule Finset

variable {K : Type*} [Field K] {C : ℤ → Type*}
  [∀ n, AddCommGroup (C n)] [∀ n, Module K (C n)]

variable (d : ∀ m n : ℤ, C m →ₗ[K] C n)

/-- A cochain complex: `d m n` vanishes unless `n = m + 1`, and any two composable
differentials compose to zero.  (For non-adjacent triples the second condition is automatic
from the first; stating it for all triples is what lets us apply it at `(n-1, n, n+1)` without
any index arithmetic.) -/
structure IsComplex : Prop where
  /-- The differential only connects consecutive degrees. -/
  shape : ∀ m n : ℤ, m + 1 ≠ n → d m n = 0
  /-- `d ∘ d = 0`. -/
  comp_eq_zero : ∀ l m n : ℤ, (d m n).comp (d l m) = 0

/-- The cocycles `Z^n = ker (d^n : C^n → C^{n+1})`. -/
def cocycles (n : ℤ) : Submodule K (C n) := LinearMap.ker (d n (n + 1))

/-- The coboundaries `B^n = im (d^{n-1} : C^{n-1} → C^n)`. -/
def coboundaries (n : ℤ) : Submodule K (C n) := LinearMap.range (d (n - 1) n)

/-- The cohomology `H^n(C) = Z^n / B^n`. -/
abbrev cohomology (n : ℤ) : Type _ :=
  ↥(cocycles d n) ⧸ (coboundaries d n).comap (cocycles d n).subtype

variable {d}

lemma coboundaries_add_one (n : ℤ) :
    coboundaries d (n + 1) = LinearMap.range (d n (n + 1)) :=
  -- `fun m ↦ range (d m (n+1))` has type `ℤ → Submodule K (C (n+1))`, which does *not* depend
  -- on `m`; so `congrArg` applies and no dependent rewriting is needed.
  congrArg (fun m : ℤ => LinearMap.range (d m (n + 1))) (by ring : n + 1 - 1 = n)

lemma coboundaries_le_cocycles (hd : IsComplex d) (n : ℤ) :
    coboundaries d n ≤ cocycles d n := by
  rintro x ⟨y, rfl⟩
  have : (d n (n + 1)) ((d (n - 1) n) y) = 0 := by
    rw [← LinearMap.comp_apply, hd.comp_eq_zero (n - 1) n (n + 1), LinearMap.zero_apply]
  exact this

section Finite

variable [∀ n, FiniteDimensional K (C n)]

/-- Rank–nullity applied to `d^n : C^n → C^{n+1}`: `dim C^n = dim B^{n+1} + dim Z^n`. -/
lemma finrank_coboundaries_add_finrank_cocycles (n : ℤ) :
    finrank K (coboundaries d (n + 1)) + finrank K (cocycles d n) = finrank K (C n) := by
  rw [coboundaries_add_one]
  exact LinearMap.finrank_range_add_finrank_ker (d n (n + 1))

/-- `dim H^n = dim Z^n − dim B^n`, in the additive form. -/
lemma finrank_cohomology_add_finrank_coboundaries (hd : IsComplex d) (n : ℤ) :
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

/-- A degree in which the complex vanishes contributes nothing to the cohomology either. -/
lemma finrank_cohomology_eq_zero_of_subsingleton (hd : IsComplex d) (n : ℤ)
    [Subsingleton (C n)] : finrank K (cohomology d n) = 0 := by
  have h1 := finrank_cohomology_add_finrank_coboundaries hd n
  have h2 : finrank K (cocycles d n) ≤ finrank K (C n) := Submodule.finrank_le _
  have h3 : finrank K (C n) = 0 := Module.finrank_zero_of_subsingleton
  omega

lemma finrank_coboundaries_eq_zero_of_subsingleton (n : ℤ) [Subsingleton (C (n - 1))] :
    finrank K (coboundaries d n) = 0 := by
  have h1 := LinearMap.finrank_range_add_finrank_ker (d (n - 1) n)
  have h3 : finrank K (C (n - 1)) = 0 := Module.finrank_zero_of_subsingleton
  have h4 : finrank K (LinearMap.range (d (n - 1) n)) = 0 := by omega
  exact h4

lemma finrank_coboundaries_eq_zero_of_subsingleton' (n : ℤ)
    [Subsingleton (C n)] : finrank K (coboundaries d n) = 0 := by
  have h2 : finrank K (coboundaries d n) ≤ finrank K (C n) := Submodule.finrank_le _
  have h3 : finrank K (C n) = 0 := Module.finrank_zero_of_subsingleton
  omega

/-- The telescoping term `(−1)^n dim B^n`. -/
private noncomputable def eulerBoundary (d : ∀ m n : ℤ, C m →ₗ[K] C n) (n : ℤ) : ℤ :=
  (n.negOnePow : ℤ) * finrank K (coboundaries d n)

private lemma term_eq_telescope (hd : IsComplex d) (n : ℤ) :
    (n.negOnePow : ℤ) * finrank K (C n) - (n.negOnePow : ℤ) * finrank K (cohomology d n)
      = eulerBoundary d n - eulerBoundary d (n + 1) := by
  have h1 : (finrank K (C n) : ℤ)
      = finrank K (coboundaries d (n + 1)) + finrank K (cocycles d n) := by
    exact_mod_cast (finrank_coboundaries_add_finrank_cocycles (d := d) n).symm
  have h2 : (finrank K (cohomology d n) : ℤ)
      = finrank K (cocycles d n) - finrank K (coboundaries d n) := by
    have := finrank_cohomology_add_finrank_coboundaries hd n
    omega
  have h3 : (((n + 1).negOnePow : ℤˣ) : ℤ) = -((n.negOnePow : ℤˣ) : ℤ) := by
    rw [Int.negOnePow_succ, Units.val_neg]
  simp only [eulerBoundary, h1, h2, h3]
  ring

private lemma sum_Ico_telescope (F : ℤ → ℤ) {a b : ℤ} (hab : a ≤ b) :
    ∑ n ∈ Finset.Ico a b, (F n - F (n + 1)) = F a - F b := by
  induction b, hab using Int.leInduction with
  | base => simp
  | succ b hb ih =>
      have hins : Finset.Ico a (b + 1) = insert b (Finset.Ico a b) := by
        ext n
        simp only [Finset.mem_Ico, Finset.mem_insert]
        omega
      rw [hins, Finset.sum_insert (by simp), ih]
      ring

/-- **Euler–Poincaré principle**, card item (1).

If `(C^•, d)` is a `ℤ`-graded cochain complex of finite-dimensional `K`-vector spaces which
vanishes in degrees `a - 1` and `b`, then the alternating sums of dimensions over the degrees
`a, …, b-1` of the complex and of its cohomology agree.  `C^{a-1} = 0` and `C^b = 0` are the
sharp hypotheses: they are exactly what makes the two boundary terms of the telescoping sum
vanish.  The card's "only finitely many `C^n ≠ 0`" version is `euler_poincare_finsum`. -/
theorem euler_poincare (hd : IsComplex d) {a b : ℤ} (hab : a ≤ b)
    [Subsingleton (C (a - 1))] [Subsingleton (C b)] :
    ∑ n ∈ Finset.Ico a b, (n.negOnePow : ℤ) * finrank K (C n)
      = ∑ n ∈ Finset.Ico a b, (n.negOnePow : ℤ) * finrank K (cohomology d n) := by
  have hba : eulerBoundary d a = 0 := by
    simp [eulerBoundary, finrank_coboundaries_eq_zero_of_subsingleton (d := d) a]
  have hbb : eulerBoundary d b = 0 := by
    simp [eulerBoundary, finrank_coboundaries_eq_zero_of_subsingleton' (d := d) b]
  have hsum : ∑ n ∈ Finset.Ico a b,
      ((n.negOnePow : ℤ) * finrank K (C n)
        - (n.negOnePow : ℤ) * finrank K (cohomology d n)) = 0 := by
    rw [Finset.sum_congr rfl (fun n _ => term_eq_telescope hd n),
      sum_Ico_telescope (eulerBoundary d) hab, hba, hbb, sub_zero]
  rw [← sub_eq_zero, ← Finset.sum_sub_distrib]
  exact hsum

/-- **Euler–Poincaré principle, sum over all degrees.**  Same as `euler_poincare`, but with the
two alternating sums taken over all of `ℤ` as `finsum`s; the hypothesis is the card's "only
finitely many `C^n` are nonzero", in the form "`C^n = 0` for `n ∉ [a, b)`". -/
theorem euler_poincare_finsum (hd : IsComplex d) {a b : ℤ} (hab : a ≤ b)
    (hvanish : ∀ n, n ∉ Finset.Ico a b → Subsingleton (C n)) :
    ∑ᶠ n, (n.negOnePow : ℤ) * finrank K (C n)
      = ∑ᶠ n, (n.negOnePow : ℤ) * finrank K (cohomology d n) := by
  have ha : Subsingleton (C (a - 1)) := hvanish _ (by simp)
  have hb : Subsingleton (C b) := hvanish _ (by simp)
  have hsuppC : Function.support (fun n : ℤ => (n.negOnePow : ℤ) * (finrank K (C n) : ℤ))
      ⊆ (Finset.Ico a b : Set ℤ) := by
    intro n hn
    by_contra hmem
    have := hvanish n (by simpa using hmem)
    exact hn (by simp [Module.finrank_zero_of_subsingleton])
  have hsuppH :
      Function.support (fun n : ℤ => (n.negOnePow : ℤ) * (finrank K (cohomology d n) : ℤ))
      ⊆ (Finset.Ico a b : Set ℤ) := by
    intro n hn
    by_contra hmem
    have := hvanish n (by simpa using hmem)
    exact hn (by simp [finrank_cohomology_eq_zero_of_subsingleton hd n])
  rw [finsum_eq_finsetSum_of_support_subset _ hsuppC,
    finsum_eq_finsetSum_of_support_subset _ hsuppH]
  exact euler_poincare hd hab

/-- The card's "特别地" clause: if the cohomology is concentrated in degree `0`, its dimension
is the alternating sum of the dimensions of the complex. -/
theorem finrank_cohomology_zero_eq (hd : IsComplex d) {a b : ℤ} (h0 : (0 : ℤ) ∈ Finset.Ico a b)
    [Subsingleton (C (a - 1))] [Subsingleton (C b)]
    (hac : ∀ n : ℤ, n ≠ 0 → Subsingleton (cohomology d n)) :
    (finrank K (cohomology d 0) : ℤ)
      = ∑ n ∈ Finset.Ico a b, (n.negOnePow : ℤ) * finrank K (C n) := by
  have hab : a ≤ b := by
    rw [Finset.mem_Ico] at h0
    omega
  rw [euler_poincare hd hab]
  have hone : ∑ n ∈ Finset.Ico a b, (n.negOnePow : ℤ) * finrank K (cohomology d n)
      = (((0 : ℤ).negOnePow : ℤˣ) : ℤ) * finrank K (cohomology d 0) := by
    refine Finset.sum_eq_single_of_mem 0 h0 ?_
    intro n _ hn
    have := hac n hn
    simp [Module.finrank_zero_of_subsingleton]
  rw [hone]
  simp

end Finite

section Graded

/-!
## The graded (formal character) version

Card item (2).  The input is a family of complexes indexed by the weights `Λ`; the conclusion
is an identity of *formal characters*, i.e. of elements of `Λ → ℤ`, where the character of a
weight-graded space is the function sending a weight to the dimension of that weight space.
As the card itself says, (2) is (1) applied weight by weight, and that is exactly the proof.

A `Λ`-dependent pair of vanishing degrees is allowed at the level of the *pointwise*
statement, which is literally `euler_poincare (d := dg l)`; the packaged character statement
below uses one uniform pair `a, b`.
-/

variable {Λ : Type*} {Cg : Λ → ℤ → Type*}
  [∀ l n, AddCommGroup (Cg l n)] [∀ l n, Module K (Cg l n)]
  [∀ l n, FiniteDimensional K (Cg l n)]
  {dg : ∀ l : Λ, ∀ m n : ℤ, Cg l m →ₗ[K] Cg l n}

/-- **Euler–Poincaré principle, graded version** (card item (2)): the alternating sums of the
formal characters `ch C^n = (λ ↦ dim C^n_λ)` and `ch H^n = (λ ↦ dim H^n_λ)` agree as elements
of `Λ → ℤ`. -/
theorem euler_poincare_graded (hdg : ∀ l, IsComplex (dg l)) {a b : ℤ} (hab : a ≤ b)
    (ha : ∀ l, Subsingleton (Cg l (a - 1))) (hb : ∀ l, Subsingleton (Cg l b)) :
    (∑ n ∈ Finset.Ico a b, fun l : Λ => (n.negOnePow : ℤ) * finrank K (Cg l n))
      = ∑ n ∈ Finset.Ico a b,
          fun l : Λ => (n.negOnePow : ℤ) * finrank K (cohomology (dg l) n) := by
  funext l
  have := ha l
  have := hb l
  simpa using euler_poincare (d := dg l) (hdg l) hab

end Graded

end StringFormal.EulerPoincare
