/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import Mathlib.Algebra.Lie.OfAssociative
import Mathlib.Data.Finset.NoncommProd
import Mathlib.Data.Finsupp.Multiset
import Mathlib.LinearAlgebra.BilinearForm.Orthogonal

/-!
# The Gram matrix of an abstract Heisenberg family

Graph node: `worldsheet.transverse-ddf-fock-gram-matrix`.  This is §C.3 of
`formal/BLUEPRINT-noghost.md`.

## What this file is for

`StringFormal/NoGhost/FockGram.lean` proves the same Gram matrix, but only on the *worldsheet
oscillator Fock space* `Fock D R = MvPolynomial (Osc D) R`, and its conditional version
`Fock.pairing_creationMonomial_of_hypotheses` goes through `Fock.pairing_unique`, i.e. through the
fact that the creation monomials are a *basis of a polynomial ring*.  That proof cannot be
instantiated at the DDF operators `A^ε_n`, whose carrier is the momentum tower.  The `fock-gram`
item of `formal/TODO.md` records this as gap (a).

Here the recursion is redone with no assumption whatsoever on the carrier: `M` is an arbitrary
`R`-module and the only inputs are the four hypotheses of the graph card.

## Main definitions

* `heisCreation A v` — the creation operator `A^i_{-n}` for `v = (i, n) : ι × ℕ+`.
* `heisMonomialOp`, `heisMonomial` — the ordered product `∏ (A^i_{-n})^{d(i,n)}` and the state it
  produces from the vacuum.  Well definedness (independence of the order) is exactly
  `commute_heisCreation`, so the construction takes the commutation proof as an argument and uses
  `Multiset.noncommProd`.
* `heisNorm R d = ∏_{(i,n)} n^{d(i,n)} · d(i,n)!` — the diagonal entry.

## Main statements

* `finsupp_addSingle_induction` — induction on `α →₀ ℕ` adjoining **one** generator at a time.
  Mathlib's `Finsupp.induction` adjoins a whole `single a b`, which does not fit the
  creation-operator recursion.  Proved by transport along `Multiset.toFinsupp`.
* `commute_heisCreation` — **hypothesis (H1) of the card is a theorem**, not an assumption: two
  creation operators have modes of the same sign, so `m + n ≠ 0` and the central term vanishes.
* `heisAnnihilation_heisMonomial` — **step (1)**, the Leibniz rule
  `A^i_n ∏ (A_{-m})^d Ω = n · d(i,n) · ∏ (A_{-m})^{d - δ} Ω` for `n > 0`.
* `gram_of_heisenberg_family` — **the Gram matrix**:
  `⟨mono d, mono e⟩ = δ_{d,e} ∏ n^{d(i,n)} d(i,n)!`, with `gram_of_heisenberg_family_of_ne` and
  `gram_of_heisenberg_family_self` the two halves.
* `heisNorm_pos`, `heisNorm_ne_zero` — positivity over an ordered ring, nonvanishing over a field
  of characteristic zero.
* `linearIndependent_heisMonomial` — over a field of characteristic zero the creation monomials
  are linearly independent (via Mathlib's `BilinForm.linearIndependent_of_iIsOrtho`).

## Mathematical notes (for the dependency graph)

1. **This is the orthonormal (transverse) case, by design.**  The central term is normalised to
   `m δ_{m+n,0} δ_{ij}`, matching `worldsheet.transverse-ddf-fock-gram-matrix` with an
   orthonormal transverse frame.  The worldsheet oscillators `α^μ_m` satisfy
   `⁅α^μ_m, α^ν_n⁆ = m η^{μν} δ_{m+n,0}` with an **indefinite** `η`, so `FockGram.lean` is *not*
   an instance of this theorem; the two files cover complementary situations, and the card should
   say which normalisation it means.  Instantiating at a transverse frame (`ε_i · ε_j = δ_{ij}`)
   is exactly what makes the DDF sector positive definite.
2. **Characteristic zero is doing real work** in `heisNorm_ne_zero` and hence in
   `linearIndependent_heisMonomial`: `Fock.pairing_creationMonomial_self_eq_zero_zmod_two`
   exhibits a monomial of norm `2! = 0` over `ZMod 2`.  Conclusion (1) of the card (orthogonality
   and the diagonal formula) needs no such hypothesis and is proved here over any commutative
   ring.
3. Only modes in `ℕ+` appear as creation labels; the family `A : ι → ℤ → Module.End R M` is
   otherwise unconstrained, and `A^i_0` is never used.

## Gaps

1. **The DDF instantiation is not here.**  That is §C.4 of the blueprint and needs two small
   facts that do not yet exist: `Fock.towerPairing η towerVacuum towerVacuum = 1` and
   `A^ε_n towerVacuum = 0` for `n > 0`, plus a transverse frame turning `lie_ddfOp_ddfOp`'s
   `m (ε·δ) δ_{m+n,0}` into `m δ_{ij}`.  So gap (a) of the `fock-gram` TODO item is closed on the
   abstract side only.
2. **No completeness.**  Nothing here says the creation monomials span `M`; that is the
   `ddf-spans` obligation and is the hard half of the no-ghost theorem.
3. **No canonical `heisMonomial` API.**  The commutation proof `hcomm` is an explicit argument of
   the definition (it is what makes the ordered product independent of the order), so every
   statement carries it.  Bundling `(A, Ω, B)` with its hypotheses into a structure would be
   tidier and is left undone.
4. **`FockGram.lean` is not refactored**; see note 1 for why it cannot simply be replaced.
-/

namespace StringFormal

/-! ### An induction principle for `ℕ`-valued finitely supported functions -/

/-- Induction on `α →₀ ℕ` by adjoining **one** generator at a time.  Mathlib's `Finsupp.induction`
adjoins a whole `single a b`; the creation-operator recursion needs `single a 1` steps.  Proved by
transport along `Multiset.toFinsupp`. -/
theorem finsupp_addSingle_induction {α : Type*} [DecidableEq α] {p : (α →₀ ℕ) → Prop}
    (h0 : p 0) (hstep : ∀ (d : α →₀ ℕ) (v : α), p d → p (d + Finsupp.single v 1))
    (d : α →₀ ℕ) : p d := by
  classical
  have key : ∀ s : Multiset α, p (Multiset.toFinsupp s) := by
    intro s
    induction s using Multiset.induction_on with
    | empty => simpa using h0
    | cons a s ih =>
      have h : Multiset.toFinsupp (a ::ₘ s) = Multiset.toFinsupp s + Finsupp.single a 1 := by
        rw [← Multiset.singleton_add, Multiset.toFinsupp_add, Multiset.toFinsupp_singleton,
          add_comm]
      rw [h]
      exact hstep _ _ ih
  have h2 : Multiset.toFinsupp (Finsupp.toMultiset d) = d := by simp
  simpa [h2] using key (Finsupp.toMultiset d)

/-! ### The Heisenberg family and its creation monomials -/

section Heisenberg

variable {R M ι : Type*} [CommRing R] [AddCommGroup M] [Module R M] [DecidableEq ι]

/-- The creation operator attached to `(i, n) : ι × ℕ+`, namely `A^i_{-n}`. -/
noncomputable def heisCreation (A : ι → ℤ → Module.End R M) (v : ι × ℕ+) : Module.End R M :=
  A v.1 (-((v.2 : ℕ) : ℤ))

/-- The canonical commutation relations, turned into a rewriting rule on vectors:
`A^i_m A^j_n x = A^j_n A^i_m x + m δ_{m+n,0} δ_{ij} x`. -/
theorem heis_apply_apply {A : ι → ℤ → Module.End R M}
    (hccr : ∀ (i j : ι) (m n : ℤ), ⁅A i m, A j n⁆
      = (if m + n = 0 ∧ i = j then (m : R) else 0) • (LinearMap.id : Module.End R M))
    (i j : ι) (m n : ℤ) (x : M) :
    A i m (A j n x)
      = A j n (A i m x) + (if m + n = 0 ∧ i = j then (m : R) else 0) • x := by
  have h := congrArg (fun T : Module.End R M => T x) (hccr i j m n)
  simp only [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
    LinearMap.smul_apply, LinearMap.id_apply] at h
  exact sub_eq_iff_eq_add'.mp h

/-- **Hypothesis (H1) is a consequence of the commutation relations**, not an extra assumption:
two creation operators have modes of the same (negative) sign, so `m + n ≠ 0` and the central
term drops out.  This is what makes the creation monomial below well defined. -/
theorem commute_heisCreation {A : ι → ℤ → Module.End R M}
    (hccr : ∀ (i j : ι) (m n : ℤ), ⁅A i m, A j n⁆
      = (if m + n = 0 ∧ i = j then (m : R) else 0) • (LinearMap.id : Module.End R M))
    (u v : ι × ℕ+) : Commute (heisCreation A u) (heisCreation A v) := by
  have hne : ¬ (-((u.2 : ℕ) : ℤ) + -((v.2 : ℕ) : ℤ) = 0 ∧ u.1 = v.1) := by
    rintro ⟨h, -⟩
    have hu : 0 < ((u.2 : ℕ) : ℤ) := by exact_mod_cast u.2.pos
    have hv : 0 < ((v.2 : ℕ) : ℤ) := by exact_mod_cast v.2.pos
    omega
  show heisCreation A u * heisCreation A v = heisCreation A v * heisCreation A u
  refine LinearMap.ext fun x => ?_
  simp only [Module.End.mul_apply, heisCreation]
  rw [heis_apply_apply hccr, if_neg hne, zero_smul, add_zero]

/-! ### Finsupp bookkeeping -/

private theorem noncommProd_eq_of_eq {α : Type*} [Monoid α] {s t : Multiset α}
    (hs : {x | x ∈ s}.Pairwise Commute) (ht : {x | x ∈ t}.Pairwise Commute) (h : s = t) :
    s.noncommProd hs = t.noncommProd ht := by
  subst h; rfl

variable {α : Type*} [DecidableEq α]

private theorem add_single_sub_single (d : α →₀ ℕ) (u : α) :
    d + Finsupp.single u 1 - Finsupp.single u 1 = d := by
  ext x
  by_cases h : x = u <;> simp [h]

private theorem sub_single_add_single {d : α →₀ ℕ} {u : α} (hu : d u ≠ 0) :
    d - Finsupp.single u 1 + Finsupp.single u 1 = d := by
  ext x
  by_cases h : x = u
  · subst h; simp only [Finsupp.add_apply, Finsupp.tsub_apply, Finsupp.single_eq_same]; omega
  · simp [h]

omit [DecidableEq α] in
private theorem add_single_apply_of_ne {d : α →₀ ℕ} {u w : α} (h : u ≠ w) :
    ((d + Finsupp.single u 1 : α →₀ ℕ)) w = d w := by
  simp [h]

private theorem add_single_sub_single_comm (d : α →₀ ℕ) {u w : α} (h : u ≠ w) :
    d + Finsupp.single u 1 - Finsupp.single w 1
      = d - Finsupp.single w 1 + Finsupp.single u 1 := by
  ext x
  simp only [Finsupp.add_apply, Finsupp.tsub_apply, Finsupp.single_apply]
  rcases eq_or_ne u x with rfl | h1
  · rw [if_pos rfl, if_neg (Ne.symm h)]; omega
  · rw [if_neg h1]
    rcases eq_or_ne w x with rfl | h2
    · rw [if_pos rfl]; omega
    · rw [if_neg h2]; omega

/-! ### The creation monomials -/

variable {A : ι → ℤ → Module.End R M}

omit [DecidableEq ι] in
/-- Any multiset of creation operators is pairwise commuting. -/
theorem pairwise_commute_heisCreation_map
    (hcomm : ∀ u v : ι × ℕ+, Commute (heisCreation A u) (heisCreation A v))
    (s : Multiset (ι × ℕ+)) :
    {x | x ∈ s.map (heisCreation A)}.Pairwise Commute := by
  rintro x hx y hy -
  obtain ⟨u, -, rfl⟩ := Multiset.mem_map.mp hx
  obtain ⟨v, -, rfl⟩ := Multiset.mem_map.mp hy
  exact hcomm u v

/-- The ordered product of creation operators recorded by `d`.  Well defined because the creation
operators commute (`commute_heisCreation`), which is why `hcomm` is an argument. -/
noncomputable def heisMonomialOp (A : ι → ℤ → Module.End R M)
    (hcomm : ∀ u v : ι × ℕ+, Commute (heisCreation A u) (heisCreation A v))
    (d : (ι × ℕ+) →₀ ℕ) : Module.End R M :=
  ((Finsupp.toMultiset d).map (heisCreation A)).noncommProd
    (pairwise_commute_heisCreation_map hcomm _)

/-- **The creation monomial** `∏_{(i,n)} (A^i_{-n})^{d(i,n)} Ω`. -/
noncomputable def heisMonomial (A : ι → ℤ → Module.End R M) (Ω : M)
    (hcomm : ∀ u v : ι × ℕ+, Commute (heisCreation A u) (heisCreation A v))
    (d : (ι × ℕ+) →₀ ℕ) : M :=
  heisMonomialOp A hcomm d Ω

omit [DecidableEq ι] in
@[simp]
theorem heisMonomial_zero (Ω : M)
    (hcomm : ∀ u v : ι × ℕ+, Commute (heisCreation A u) (heisCreation A v)) :
    heisMonomial A Ω hcomm 0 = Ω := by
  have h : (Finsupp.toMultiset (0 : (ι × ℕ+) →₀ ℕ)).map (heisCreation A) = 0 := by simp
  have hs := pairwise_commute_heisCreation_map hcomm (Finsupp.toMultiset (0 : (ι × ℕ+) →₀ ℕ))
  have hop : heisMonomialOp A hcomm 0 = 1 :=
    (noncommProd_eq_of_eq hs (h ▸ hs) h).trans (Multiset.noncommProd_empty _)
  show heisMonomialOp A hcomm 0 Ω = Ω
  rw [hop]
  rfl

omit [DecidableEq ι] in
/-- Adjoining one more creation operator.  Together with `heisMonomial_zero` this characterises
`heisMonomial` recursively, and it is the only property of it used below. -/
theorem heisMonomial_add_single (Ω : M)
    (hcomm : ∀ u v : ι × ℕ+, Commute (heisCreation A u) (heisCreation A v))
    (d : (ι × ℕ+) →₀ ℕ) (v : ι × ℕ+) :
    heisMonomial A Ω hcomm (d + Finsupp.single v 1)
      = heisCreation A v (heisMonomial A Ω hcomm d) := by
  have h : (Finsupp.toMultiset (d + Finsupp.single v 1)).map (heisCreation A)
      = heisCreation A v ::ₘ (Finsupp.toMultiset d).map (heisCreation A) := by
    rw [add_comm, map_add, Finsupp.toMultiset_single, one_nsmul, Multiset.singleton_add,
      Multiset.map_cons]
  have hs := pairwise_commute_heisCreation_map hcomm
    (Finsupp.toMultiset (d + Finsupp.single v 1))
  have hop : heisMonomialOp A hcomm (d + Finsupp.single v 1)
      = heisCreation A v * heisMonomialOp A hcomm d :=
    (noncommProd_eq_of_eq hs (h ▸ hs) h).trans (Multiset.noncommProd_cons _ _ _)
  show heisMonomialOp A hcomm (d + Finsupp.single v 1) Ω = _
  rw [hop]
  rfl

/-! ### Commuting an annihilation operator through a creation monomial -/

/-- **Step (1) of the Gram computation** (the Leibniz rule): because the commutator
`⁅A^i_n, A^j_{-m}⁆ = n δ_{nm} δ_{ij}` is central, moving `A^i_n` (`n > 0`) through a string of
creation operators leaves exactly the `d(i,n)` contracted terms, each contributing `n`. -/
theorem heisAnnihilation_heisMonomial {Ω : M}
    (hccr : ∀ (i j : ι) (m n : ℤ), ⁅A i m, A j n⁆
      = (if m + n = 0 ∧ i = j then (m : R) else 0) • (LinearMap.id : Module.End R M))
    (hann : ∀ (i : ι) (n : ℤ), 0 < n → A i n Ω = 0)
    (hcomm : ∀ u v : ι × ℕ+, Commute (heisCreation A u) (heisCreation A v))
    (v : ι × ℕ+) (d : (ι × ℕ+) →₀ ℕ) :
    A v.1 ((v.2 : ℕ) : ℤ) (heisMonomial A Ω hcomm d)
      = (((v.2 : ℕ) : R) * (d v : R)) • heisMonomial A Ω hcomm (d - Finsupp.single v 1) := by
  classical
  induction d using finsupp_addSingle_induction with
  | h0 =>
    rw [heisMonomial_zero, hann v.1 _ (by exact_mod_cast v.2.pos)]
    simp
  | hstep d u ih =>
    rw [heisMonomial_add_single]
    show A v.1 ((v.2 : ℕ) : ℤ) (A u.1 (-((u.2 : ℕ) : ℤ)) (heisMonomial A Ω hcomm d)) = _
    rw [heis_apply_apply hccr, ih, map_smul]
    have hfold : A u.1 (-((u.2 : ℕ) : ℤ)) (heisMonomial A Ω hcomm (d - Finsupp.single v 1))
        = heisMonomial A Ω hcomm (d - Finsupp.single v 1 + Finsupp.single u 1) :=
      (heisMonomial_add_single Ω hcomm _ u).symm
    rw [hfold]
    rcases eq_or_ne u v with rfl | hne
    · have hpos : ((u.2 : ℕ) : ℤ) + -((u.2 : ℕ) : ℤ) = 0 ∧ u.1 = u.1 := ⟨by omega, rfl⟩
      rw [if_pos hpos, add_single_sub_single, Finsupp.add_apply, Finsupp.single_eq_same]
      rcases eq_or_ne (d u) 0 with hzero | hzero
      · rw [hzero]
        push_cast
        simp
      · rw [sub_single_add_single hzero, ← add_smul]
        congr 1
        push_cast
        ring
    · have hfalse : ¬ (((v.2 : ℕ) : ℤ) + -((u.2 : ℕ) : ℤ) = 0 ∧ v.1 = u.1) := by
        rintro ⟨h1, h2⟩
        refine hne (Prod.ext h2.symm ?_)
        have h3 : ((u.2 : ℕ) : ℤ) = ((v.2 : ℕ) : ℤ) := by omega
        exact_mod_cast h3
      rw [if_neg hfalse, zero_smul, add_zero, add_single_apply_of_ne hne,
        add_single_sub_single_comm d hne]

/-! ### The diagonal entries -/

/-- The diagonal entry `∏_{(i,n)} n^{d(i,n)} · d(i,n)!` of the Gram matrix. -/
noncomputable def heisNorm (R : Type*) [CommRing R] {ι : Type*} (d : (ι × ℕ+) →₀ ℕ) : R :=
  d.prod fun v k => ((v.2 : ℕ) : R) ^ k * (k.factorial : R)

omit [DecidableEq ι] in
@[simp]
theorem heisNorm_zero : heisNorm R (0 : (ι × ℕ+) →₀ ℕ) = 1 :=
  Finsupp.prod_zero_index

theorem heisNorm_add_single (d : (ι × ℕ+) →₀ ℕ) (v : ι × ℕ+) :
    heisNorm R (d + Finsupp.single v 1)
      = ((v.2 : ℕ) : R) * ((d v : R) + 1) * heisNorm R d := by
  classical
  set g : (ι × ℕ+) → ℕ → R := fun u k => ((u.2 : ℕ) : R) ^ k * (k.factorial : R) with hg
  have hz : ∀ u : ι × ℕ+, g u 0 = 1 := by intro u; simp [hg]
  have hsub : (d + Finsupp.single v 1).support ⊆ insert v d.support := by
    intro u hu
    rcases eq_or_ne u v with rfl | hne
    · exact Finset.mem_insert_self _ _
    · refine Finset.mem_insert_of_mem ?_
      rw [Finsupp.mem_support_iff] at hu ⊢
      rwa [add_single_apply_of_ne (Ne.symm hne)] at hu
  have h1 : heisNorm R (d + Finsupp.single v 1)
      = ∏ u ∈ insert v d.support, g u ((d + Finsupp.single v 1 : (ι × ℕ+) →₀ ℕ) u) :=
    Finsupp.prod_of_support_subset _ hsub _ fun u _ => hz u
  have h2 : heisNorm R d = ∏ u ∈ insert v d.support, g u (d u) :=
    Finsupp.prod_of_support_subset _ (Finset.subset_insert _ _) _ fun u _ => hz u
  have hmem : v ∈ insert v d.support := Finset.mem_insert_self _ _
  rw [h1, h2, ← Finset.mul_prod_erase _ _ hmem, ← Finset.mul_prod_erase _ _ hmem]
  have he : ∀ u ∈ (insert v d.support).erase v,
      g u ((d + Finsupp.single v 1 : (ι × ℕ+) →₀ ℕ) u) = g u (d u) := by
    intro u hu
    rw [add_single_apply_of_ne (Ne.symm (Finset.ne_of_mem_erase hu))]
  rw [Finset.prod_congr rfl he, Finsupp.add_apply, Finsupp.single_eq_same]
  have hstep : g v (d v + 1) = ((v.2 : ℕ) : R) * ((d v : R) + 1) * g v (d v) := by
    simp only [hg, pow_succ, Nat.factorial_succ]
    push_cast
    ring
  rw [hstep]
  ring

/-! ### The Gram matrix -/

/-- **The Gram matrix of an abstract Heisenberg family.**  Under (H1)-(H4) — canonical
commutation relations `⁅A^i_m, A^j_n⁆ = m δ_{m+n,0} δ_{ij}`, mutual adjointness
`(A^i_n)^† = A^i_{-n}`, vacuum normalisation `⟨Ω,Ω⟩ = 1`, and the vacuum condition
`A^i_n Ω = 0` for `n > 0` — the creation monomials are pairwise orthogonal with diagonal entries
`∏ n^{d(i,n)} d(i,n)!`.

This is the graph card `worldsheet.transverse-ddf-fock-gram-matrix` in its intended generality:
the carrier `M` is an arbitrary `R`-module, so the statement applies verbatim to the DDF operators
`A^ε_n` on the momentum tower, not only to the worldsheet oscillators.  Note that (H1) (creation
operators commute) is **not** assumed: it is `commute_heisCreation`, a consequence of `hccr`. -/
theorem gram_of_heisenberg_family {Ω : M} {B : LinearMap.BilinForm R M}
    (hccr : ∀ (i j : ι) (m n : ℤ), ⁅A i m, A j n⁆
      = (if m + n = 0 ∧ i = j then (m : R) else 0) • (LinearMap.id : Module.End R M))
    (hadj : ∀ (i : ι) (n : ℤ) (x y : M), B (A i n x) y = B x (A i (-n) y))
    (hvac : B Ω Ω = 1)
    (hann : ∀ (i : ι) (n : ℤ), 0 < n → A i n Ω = 0)
    (hcomm : ∀ u v : ι × ℕ+, Commute (heisCreation A u) (heisCreation A v))
    (d e : (ι × ℕ+) →₀ ℕ) :
    B (heisMonomial A Ω hcomm d) (heisMonomial A Ω hcomm e)
      = if d = e then heisNorm R d else 0 := by
  classical
  induction d using finsupp_addSingle_induction generalizing e with
  | h0 =>
    rw [heisMonomial_zero]
    rcases eq_or_ne (0 : (ι × ℕ+) →₀ ℕ) e with rfl | hne
    · rw [if_pos rfl, heisMonomial_zero, heisNorm_zero, hvac]
    · rw [if_neg hne]
      obtain ⟨w, hw⟩ : ∃ w, e w ≠ 0 := by
        by_contra hcon
        refine hne (Finsupp.ext fun u => ?_)
        simpa using (not_not.mp (not_exists.mp hcon u)).symm
      rw [show e = e - Finsupp.single w 1 + Finsupp.single w 1 from
        (sub_single_add_single hw).symm, heisMonomial_add_single]
      show B Ω (A w.1 (-((w.2 : ℕ) : ℤ)) (heisMonomial A Ω hcomm (e - Finsupp.single w 1))) = 0
      rw [← hadj w.1 ((w.2 : ℕ) : ℤ), hann w.1 _ (by exact_mod_cast w.2.pos), map_zero,
        LinearMap.zero_apply]
  | hstep d v ih =>
    rw [heisMonomial_add_single]
    show B (A v.1 (-((v.2 : ℕ) : ℤ)) (heisMonomial A Ω hcomm d)) (heisMonomial A Ω hcomm e) = _
    rw [hadj v.1 (-((v.2 : ℕ) : ℤ)), neg_neg,
      heisAnnihilation_heisMonomial hccr hann hcomm v e, map_smul, smul_eq_mul, ih]
    rcases eq_or_ne (e v) 0 with hzero | hzero
    · have hne : d + Finsupp.single v 1 ≠ e := by
        intro hcon
        rw [← hcon, Finsupp.add_apply, Finsupp.single_eq_same] at hzero
        omega
      rw [if_neg hne, hzero]
      simp
    · have hiff : d = e - Finsupp.single v 1 ↔ d + Finsupp.single v 1 = e := by
        constructor
        · rintro rfl
          exact sub_single_add_single hzero
        · rintro rfl
          exact (add_single_sub_single d v).symm
      by_cases hcon : d + Finsupp.single v 1 = e
      · rw [if_pos (hiff.mpr hcon), if_pos hcon, heisNorm_add_single, ← hcon,
          Finsupp.add_apply, Finsupp.single_eq_same]
        push_cast
        ring
      · rw [if_neg (fun h => hcon (hiff.mp h)), if_neg hcon, mul_zero]

/-- Orthogonality of distinct creation monomials. -/
theorem gram_of_heisenberg_family_of_ne {Ω : M} {B : LinearMap.BilinForm R M}
    (hccr : ∀ (i j : ι) (m n : ℤ), ⁅A i m, A j n⁆
      = (if m + n = 0 ∧ i = j then (m : R) else 0) • (LinearMap.id : Module.End R M))
    (hadj : ∀ (i : ι) (n : ℤ) (x y : M), B (A i n x) y = B x (A i (-n) y))
    (hvac : B Ω Ω = 1)
    (hann : ∀ (i : ι) (n : ℤ), 0 < n → A i n Ω = 0)
    (hcomm : ∀ u v : ι × ℕ+, Commute (heisCreation A u) (heisCreation A v))
    {d e : (ι × ℕ+) →₀ ℕ} (hde : d ≠ e) :
    B (heisMonomial A Ω hcomm d) (heisMonomial A Ω hcomm e) = 0 := by
  classical
  rw [gram_of_heisenberg_family hccr hadj hvac hann hcomm, if_neg hde]

/-- The diagonal entries `∏ n^{d(i,n)} d(i,n)!`. -/
theorem gram_of_heisenberg_family_self {Ω : M} {B : LinearMap.BilinForm R M}
    (hccr : ∀ (i j : ι) (m n : ℤ), ⁅A i m, A j n⁆
      = (if m + n = 0 ∧ i = j then (m : R) else 0) • (LinearMap.id : Module.End R M))
    (hadj : ∀ (i : ι) (n : ℤ) (x y : M), B (A i n x) y = B x (A i (-n) y))
    (hvac : B Ω Ω = 1)
    (hann : ∀ (i : ι) (n : ℤ), 0 < n → A i n Ω = 0)
    (hcomm : ∀ u v : ι × ℕ+, Commute (heisCreation A u) (heisCreation A v))
    (d : (ι × ℕ+) →₀ ℕ) :
    B (heisMonomial A Ω hcomm d) (heisMonomial A Ω hcomm d) = heisNorm R d := by
  classical
  rw [gram_of_heisenberg_family hccr hadj hvac hann hcomm, if_pos rfl]

end Heisenberg

/-! ### Nonvanishing and positivity of the diagonal -/

section Diagonal

variable {ι : Type*}

/-- Over an ordered ring every diagonal entry is positive: the Heisenberg Fock space built on a
positive vacuum is positive definite on the span of the creation monomials. -/
theorem heisNorm_pos {R : Type*} [CommRing R] [PartialOrder R] [IsStrictOrderedRing R]
    (d : (ι × ℕ+) →₀ ℕ) : 0 < heisNorm R d := by
  rw [heisNorm, Finsupp.prod]
  refine Finset.prod_pos fun v _ => ?_
  refine mul_pos (pow_pos ?_ _) ?_
  · exact_mod_cast v.2.pos
  · exact_mod_cast (d v).factorial_pos

/-- Over a field of characteristic zero every diagonal entry is nonzero.  Characteristic zero is
**necessary**, not decoration: `Fock.pairing_creationMonomial_self_eq_zero_zmod_two` in
`FockGram.lean` exhibits a creation monomial of norm `2! = 0` over `ZMod 2`. -/
theorem heisNorm_ne_zero {K : Type*} [Field K] [CharZero K] (d : (ι × ℕ+) →₀ ℕ) :
    heisNorm K d ≠ 0 := by
  rw [heisNorm, Finsupp.prod, Finset.prod_ne_zero_iff]
  intro v _
  refine mul_ne_zero (pow_ne_zero _ ?_) ?_
  · exact_mod_cast v.2.pos.ne'
  · exact_mod_cast (d v).factorial_ne_zero

end Diagonal

section Independence

variable {K V ι : Type*} [Field K] [AddCommGroup V] [Module K V] [DecidableEq ι]
variable {A : ι → ℤ → Module.End K V}

/-- **The creation monomials of a Heisenberg family are linearly independent** over a field of
characteristic zero: the Gram matrix is diagonal with nonzero entries.  Instantiated at the DDF
operators this is the statement that the transverse DDF states form a basis of their span. -/
theorem linearIndependent_heisMonomial [CharZero K] {Ω : V} {B : LinearMap.BilinForm K V}
    (hccr : ∀ (i j : ι) (m n : ℤ), ⁅A i m, A j n⁆
      = (if m + n = 0 ∧ i = j then (m : K) else 0) • (LinearMap.id : Module.End K V))
    (hadj : ∀ (i : ι) (n : ℤ) (x y : V), B (A i n x) y = B x (A i (-n) y))
    (hvac : B Ω Ω = 1)
    (hann : ∀ (i : ι) (n : ℤ), 0 < n → A i n Ω = 0)
    (hcomm : ∀ u v : ι × ℕ+, Commute (heisCreation A u) (heisCreation A v)) :
    LinearIndependent K (heisMonomial A Ω hcomm) := by
  refine LinearMap.BilinForm.linearIndependent_of_iIsOrtho (B := B) (fun d e hde => ?_)
    (fun d => ?_)
  · exact gram_of_heisenberg_family_of_ne hccr hadj hvac hann hcomm hde
  · rw [gram_of_heisenberg_family_self hccr hadj hvac hann hcomm]
    exact heisNorm_ne_zero d

end Independence

end StringFormal
