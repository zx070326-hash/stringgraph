/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import Mathlib.Algebra.Polynomial.Basic
import Mathlib.Algebra.Polynomial.Eval.Degree
import Mathlib.Algebra.Order.Interval.Finset.Basic
import StringFormal.NoGhost.Sugawara

/-!
# The oscillator part of the exponential vertex operator `:e^{i c·X(z)}:`

Graph node: `worldsheet.ddf-operators-v5 (definition; commutation relations now separate propositions ddf-commute-with-virasoro, ddf-transverse-oscillator-algebra)`; `formal/TODO.md` item `ddf-operators`.
The momentum (zero-mode) half of the construction is in `StringFormal/NoGhost/DDF.lean`.

## Conventions

`conv.metric-mostly-plus`, `conv.alpha-prime-regge`, as in `StringFormal/NoGhost/Sugawara.lean`.
Throughout, `b : Fin D → R` is the *rescaled vertex momentum* `b^μ = (2α')^{1/2} c^μ`, chosen so
that the oscillator algebra takes the normalisation-free form

  `[α^μ_p, V_K] = b^μ V_{K-p}`,

where `V_K` (`Fock.vertexOsc η b K`) is the `z^K` Laurent coefficient of the oscillator part.
Splitting the normal-ordered exponential as `E_- E_+` with

  `E_-(z) = exp(Σ_{m ≥ 1} (b·α_{-m}/m) z^m)`,  `E_+(z) = exp(-Σ_{l ≥ 1} (b·α_l/l) z^{-l})`,

both halves become elementary on the *algebraic* Fock space `Fock D R = MvPolynomial (Osc D) R`:

* `E_-` is multiplication by an explicit element of the commutative ring `Fock D R`
  (`Fock.creaExp`), whose monomial coefficients are the classical exponential weights
  `∏ (η_μ b^μ)^{d(v)} / (v.2^{d(v)} d(v)!)` (`Fock.expWeight`);
* `E_+` is the exponential of a *constant-coefficient derivation*, hence a **translation of
  the variables** `X_{μ,l} ↦ X_{μ,l} - b^μ T^l` (`Fock.vertexSub`), where the auxiliary
  polynomial variable `T` records `z^{-1}`.  So `E_+` needs no analysis at all: it is an
  algebra map into `Polynomial (Fock D R)` and its `z^{-L}` coefficient
  (`Fock.vertexAnn`) is polynomial coefficient extraction.

The product `V_K = Σ_L Φ_{K+L} Ψ_L` is then a *locally finite* sum (`lsumLocFin`, from
Sugawara.lean): on each Fock vector only the finitely many `L` below the `T`-degree of the
translate contribute.  No convergence hypothesis is used anywhere.

## Main definitions

* `Fock.expWeight`, `Fock.creaExp` — the Laurent coefficients `Φ_j` of `E_-`, an explicit
  finite sum of monomials of level `j` (zero for `j < 0`).
* `Fock.vertexSub` — the translation `X_v ↦ X_v - b^{v.1} T^{v.2}` as an `R`-algebra map
  `Fock D R →ₐ[R] Polynomial (Fock D R)`; `Fock.vertexAnn b L` its `T^L` coefficient `Ψ_L`.
* `Fock.vertexOsc η b K` — **the `z^K` Laurent coefficient of `:e^{i c·X(z)}:` (oscillator
  part)**.

## Main statements

* `Fock.pderiv_creaExp`, `Fock.annihilation_creaExp` — `[α^μ_m, E_-] = b^μ z^m E_-`.
* `Fock.vertexAnn_mul_X` — `[α^μ_{-l}, E_+] = b^μ z^{-l} E_+`; `Fock.pderiv_vertexAnn` —
  `[α^μ_l, E_+] = 0` for `l > 0`.
* `Fock.creation_vertexOsc_sub`, `Fock.annihilation_vertexOsc_sub`,
  **`Fock.lie_mode_vertexOsc`** — `[α^μ_p, V_K] = b^μ V_{K-p}` for every `p ≠ 0`.
* `Fock.lie_mode_zero_vertexOsc` — for `p = 0` the bracket *vanishes* on a single Fock space:
  the physical relation needs the momentum shift, i.e. the tower of `DDF.lean`.
* **`Fock.mode_vertexOsc_sub`** — the two-momentum form, valid for *all* `p` including `0`:
  `α^μ_p` with parameter `a + b` on the left, with parameter `a` on the right.
* `Fock.lie_mode_vertexOsc_of_eq_zero` — transversality (`b^μ = 0` ⟹ commutes with every mode).
* `Fock.vertexOsc_mem_levelSubmodule`, `Fock.vertexOsc_apply_eq_zero_of_level` — `V_K` raises
  the oscillator level by exactly `K`, and kills level-`N` states when `N + K < 0`.
* **`Fock.vertexOsc_unique`** — rigidity: the family `V_K` is the unique one satisfying the
  creation-mode relation with the prescribed vacuum values.  This is the inductive step that
  reduces any vertex-operator identity to its restriction to the vacuum.

## Mathematical gaps (for the dependency graph)

1. **No `[L_m, V_K]`.**  The conformal-weight identity
   `L_m^{(a+b)} V_J - V_J L_m^{(a)} = (J + b·a - m + (m+1)·½ b·b) V_{J-m}`
   is *not* proved.  By `Fock.mode_vertexOsc_sub` plus `Fock.lie_Lop_mode` its two sides
   satisfy the same creation recursion, so `Fock.eq_zero_of_vertex_recursion` reduces it to
   the single identity on the vacuum, i.e. to computing `L_m` on the coherent-state
   coefficients `creaExp`; that computation is not done.  In particular the statement
   "`e^{i k_0·X}` has conformal weight `0` when `k_0² = 0`" is **not** formalised.
2. **No operator products.**  `V(b, z) V(b', w)` and hence `[A^i_m, A^j_n]` are untouched.
3. **`R`-bilinear, not sesquilinear**; no adjointness of `V_K` for `Fock.pairing` is proved
   (the expected `V(b)_J^† = V(-b)_{-J}` for `b·b = 0` would need the reordering `E_+ E_-`).
4. **`hη : η^{μμ} η_{μμ} = 1` is assumed** wherever the metric contracts spacetime indices,
   exactly as in `Sugawara.lean`.

## Status

Complete, no `sorry`; axioms are `propext`, `Classical.choice`, `Quot.sound` only.
-/

namespace StringFormal.NoGhost

open MvPolynomial

section Aux

variable {ι : Type*} [DecidableEq ι]

/-- Splitting a `Finsupp.prod` off the factor at `v`, simultaneously for `d` and
`d + single v 1`.  The common factor `Q` is what makes the one-step comparison of exponential
weights possible without dividing by anything. -/
lemma prod_split_add_single {M : Type*} [CommMonoid M] (h : ι → ℕ → M) (hz : ∀ u, h u 0 = 1)
    (d : ι →₀ ℕ) (v : ι) :
    ∃ Q : M, d.prod h = h v (d v) * Q ∧
      (d + Finsupp.single v 1).prod h = h v (d v + 1) * Q := by
  classical
  have hvs : v ∈ insert v d.support := Finset.mem_insert_self _ _
  have hsub : (d + Finsupp.single v 1).support ⊆ insert v d.support := by
    refine Finsupp.support_add.trans (Finset.union_subset (Finset.subset_insert _ _) ?_)
    intro x hx
    have hxv : x = v := by simpa using Finsupp.support_single_subset hx
    exact hxv ▸ hvs
  refine ⟨∏ u ∈ (insert v d.support).erase v, h u (d u), ?_, ?_⟩
  · rw [Finsupp.prod_of_support_subset d (Finset.subset_insert _ _) h fun i _ => hz i,
      ← Finset.mul_prod_erase _ (fun u => h u (d u)) hvs]
  · rw [Finsupp.prod_of_support_subset _ hsub h fun i _ => hz i,
      ← Finset.mul_prod_erase _
        (fun u : ι => h u ((d + Finsupp.single v 1 : ι →₀ ℕ) u)) hvs]
    have hv : (d + Finsupp.single v 1 : ι →₀ ℕ) v = d v + 1 := by simp
    rw [hv]
    congr 1
    refine Finset.prod_congr rfl fun u hu => ?_
    have hne : u ≠ v := Finset.ne_of_mem_erase hu
    rw [show (d + Finsupp.single v 1 : ι →₀ ℕ) u = d u by
      simp only [Finsupp.add_apply, Finsupp.single_apply, if_neg (Ne.symm hne), add_zero]]

end Aux

section InvNat

variable (R : Type*) [CommRing R] [Algebra ℚ R]

/-- `1/n` in a commutative `ℚ`-algebra (junk value `0` for `n = 0`). -/
noncomputable def invNat (n : ℕ) : R := algebraMap ℚ R ((n : ℚ)⁻¹)

variable {R}

lemma natCast_mul_invNat {n : ℕ} (hn : n ≠ 0) : (n : R) * invNat R n = 1 := by
  have hq : ((n : ℚ)) ≠ 0 := Nat.cast_ne_zero.mpr hn
  rw [invNat, ← map_natCast (algebraMap ℚ R) n, ← map_mul, mul_inv_cancel₀ hq, map_one]

variable (R) in
/-- `1/(m^k k!)`: the coefficient of `X_{μ,m}^k` in the expansion of the creation exponential. -/
noncomputable def expScal (m k : ℕ) : R := algebraMap ℚ R (((m : ℚ) ^ k * (k.factorial : ℚ))⁻¹)

@[simp]
lemma expScal_zero_right (m : ℕ) : expScal R m 0 = 1 := by
  rw [expScal]
  norm_num

/-- The one-step recursion satisfied by `expScal`. -/
lemma expScal_succ_mul (m k : ℕ) :
    expScal R m (k + 1) * ((k : R) + 1) = expScal R m k * invNat R m := by
  have hk1 : ((k : ℚ) + 1) ≠ 0 := by
    have hk0 : (0 : ℚ) ≤ (k : ℚ) := Nat.cast_nonneg k
    intro hc
    linarith
  have hA : ((m : ℚ) ^ (k + 1) * (((k + 1).factorial : ℕ) : ℚ))
      = ((k : ℚ) + 1) * (((m : ℚ) ^ k * ((k.factorial : ℕ) : ℚ)) * (m : ℚ)) := by
    rw [Nat.factorial_succ]
    push_cast
    rw [pow_succ]
    ring
  have hq : (((m : ℚ) ^ (k + 1) * (((k + 1).factorial : ℕ) : ℚ))⁻¹ * ((k : ℚ) + 1))
      = (((m : ℚ) ^ k * ((k.factorial : ℕ) : ℚ))⁻¹ * ((m : ℚ))⁻¹) := by
    rw [hA, mul_inv, mul_right_comm, inv_mul_cancel₀ hk1, one_mul, ← mul_inv]
  have hcast : ((k : R) + 1) = algebraMap ℚ R ((k : ℚ) + 1) := by
    rw [map_add, map_natCast, map_one]
  rw [expScal, expScal, invNat, hcast, ← map_mul, ← map_mul, hq]

end InvNat

namespace Fock

variable {D : ℕ} {R : Type*} [CommRing R]

/-! ### The creation half of the vertex operator -/

section CreaExp

variable [Algebra ℚ R]

/-- The coefficient of the monomial `X^d` in the creation exponential. -/
noncomputable def expWeight (η b : Fin D → R) (d : Osc D →₀ ℕ) : R :=
  d.prod fun v k => (η v.1 * b v.1) ^ k * expScal R ((v.2 : ℕ)) k

@[simp]
lemma expWeight_zero (η b : Fin D → R) : expWeight η b (0 : Osc D →₀ ℕ) = 1 :=
  Finsupp.prod_zero_index

/-- The one-step recursion for the exponential weights. -/
lemma expWeight_add_single (η b : Fin D → R) (d : Osc D →₀ ℕ) (v : Osc D) :
    expWeight η b (d + Finsupp.single v 1) * ((d v : R) + 1)
      = (η v.1 * b v.1 * invNat R ((v.2 : ℕ))) * expWeight η b d := by
  classical
  obtain ⟨Q, hQ1, hQ2⟩ :=
    prod_split_add_single
      (fun v : Osc D => fun k => (η v.1 * b v.1) ^ k * expScal R ((v.2 : ℕ)) k)
      (fun u => by simp) d v
  have hkey : ((η v.1 * b v.1) ^ (d v + 1) * expScal R ((v.2 : ℕ)) (d v + 1)) * ((d v : R) + 1)
      = (η v.1 * b v.1 * invNat R ((v.2 : ℕ))) * ((η v.1 * b v.1) ^ (d v) *
          expScal R ((v.2 : ℕ)) (d v)) := by
    calc ((η v.1 * b v.1) ^ (d v + 1) * expScal R ((v.2 : ℕ)) (d v + 1)) * ((d v : R) + 1)
        = (η v.1 * b v.1) ^ (d v + 1) *
            (expScal R ((v.2 : ℕ)) (d v + 1) * ((d v : R) + 1)) := by ring
      _ = (η v.1 * b v.1) ^ (d v + 1) *
            (expScal R ((v.2 : ℕ)) (d v) * invNat R ((v.2 : ℕ))) := by rw [expScal_succ_mul]
      _ = _ := by rw [pow_succ]; ring
  have h1 : expWeight η b d
      = (η v.1 * b v.1) ^ (d v) * expScal R ((v.2 : ℕ)) (d v) * Q := hQ1
  have h2 : expWeight η b (d + Finsupp.single v 1)
      = (η v.1 * b v.1) ^ (d v + 1) * expScal R ((v.2 : ℕ)) (d v + 1) * Q := hQ2
  rw [h1, h2, mul_right_comm, hkey]
  ring

/-- The level-`M` coefficient of the creation exponential. -/
noncomputable def creaExpNat (η b : Fin D → R) (M : ℕ) : Fock D R :=
  ∑ d ∈ (finite_setOf_level_eq D M).toFinset, monomial d (expWeight η b d)

/-- The `z^j` Laurent coefficient of the creation exponential; zero for `j < 0`. -/
noncomputable def creaExp (η b : Fin D → R) (j : ℤ) : Fock D R :=
  if 0 ≤ j then creaExpNat η b j.toNat else 0

lemma creaExp_of_neg (η b : Fin D → R) {j : ℤ} (hj : j < 0) : creaExp η b j = 0 := by
  rw [creaExp, if_neg (by omega)]

theorem coeff_creaExp (η b : Fin D → R) (j : ℤ) (d : Osc D →₀ ℕ) :
    coeff d (creaExp η b j) = if ((level D d : ℤ)) = j then expWeight η b d else 0 := by
  classical
  rcases lt_or_ge j 0 with hj | hj
  · rw [creaExp_of_neg η b hj, coeff_zero, if_neg (by omega)]
  · rw [creaExp, if_pos hj, creaExpNat, coeff_sum,
      Finset.sum_congr rfl fun e _ => coeff_monomial d e (expWeight η b e),
      Finset.sum_ite_eq' ((finite_setOf_level_eq D j.toNat).toFinset)
        d (fun e => expWeight η b e)]
    by_cases h : ((level D d : ℤ)) = j
    · have hmem : d ∈ (finite_setOf_level_eq D j.toNat).toFinset := by
        rw [Set.Finite.mem_toFinset]
        show level D d = j.toNat
        omega
      rw [if_pos hmem, if_pos h]
    · have hmem : d ∉ (finite_setOf_level_eq D j.toNat).toFinset := by
        rw [Set.Finite.mem_toFinset]
        intro hc
        have hc' : level D d = j.toNat := hc
        exact h (by omega)
      rw [if_neg hmem, if_neg h]

@[simp]
theorem creaExp_zero (η b : Fin D → R) : creaExp η b 0 = 1 := by
  classical
  refine MvPolynomial.ext _ _ fun d => ?_
  rw [coeff_creaExp, coeff_one]
  by_cases h : d = 0
  · subst h
    rw [if_pos (by simp), if_pos rfl]
    exact expWeight_zero η b
  · have hne : ¬ ((level D d : ℤ)) = 0 := by
      intro hlev
      refine h (Finsupp.ext fun v => ?_)
      have hz : level D d = 0 := by omega
      have hle := apply_le_of_level_eq hz v
      simpa using Nat.le_zero.mp hle
    rw [if_neg hne, if_neg (Ne.symm h)]

theorem creaExp_mem_levelSubmodule (η b : Fin D → R) {N : ℕ} {j : ℤ} (hj : (N : ℤ) = j) :
    creaExp η b j ∈ levelSubmodule D R N := by
  rw [mem_levelSubmodule]
  intro d hd
  rw [coeff_creaExp] at hd
  by_cases h : ((level D d : ℤ)) = j
  · omega
  · rw [if_neg h] at hd
    exact absurd rfl hd

/-- **The defining property of the creation exponential.** -/
theorem pderiv_creaExp (η b : Fin D → R) (μ : Fin D) (m : ℕ+) (j : ℤ) :
    pderiv ((μ, m) : Osc D) (creaExp η b j)
      = (η μ * b μ * invNat R ((m : ℕ))) • creaExp η b (j - (m : ℕ)) := by
  classical
  refine MvPolynomial.ext _ _ fun d => ?_
  rw [coeff_pderiv, coeff_creaExp, coeff_smul, coeff_creaExp, smul_eq_mul]
  have hlev : ((level D (d + Finsupp.single ((μ, m) : Osc D) 1) : ℤ))
      = (level D d : ℤ) + (m : ℕ) := by
    rw [level_add, level_single]
    push_cast
    simp [oscLevel]
  rw [hlev]
  by_cases h : ((level D d : ℤ)) = j - (m : ℕ)
  · rw [if_pos (by omega), if_pos h]
    exact expWeight_add_single η b d ((μ, m) : Osc D)
  · rw [if_neg (by omega), if_neg h, zero_mul, mul_zero]

/-- The annihilation operator applied to the creation exponential. -/
theorem annihilation_creaExp (η b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (μ : Fin D) (m : ℕ+)
    (j : ℤ) :
    annihilation η μ m (creaExp η b j) = b μ • creaExp η b (j - (m : ℕ)) := by
  rw [annihilation_apply, pderiv_creaExp, smul_smul, oscWeight_apply]
  congr 1
  have hm : ((m : ℕ) : R) * invNat R ((m : ℕ)) = 1 := natCast_mul_invNat m.ne_zero
  calc ((m : ℕ) : R) * η μ * (η μ * b μ * invNat R ((m : ℕ)))
      = (η μ * η μ) * b μ * (((m : ℕ) : R) * invNat R ((m : ℕ))) := by ring
    _ = b μ := by rw [hη μ, hm, one_mul, mul_one]

end CreaExp

/-! ### The annihilation half of the vertex operator -/

section VertexSub

/-- Substitution `X_{μ,l} ↦ X_{μ,l} - b^μ T^l`, where the auxiliary variable `T` records
`z^{-1}`.  This is the annihilation half `exp(-Σ_{l ≥ 1} (b·α_l / l) z^{-l})` of the vertex
operator: modulo `η^{μμ} η_{μμ} = 1` the exponent is the constant-coefficient derivation
`-Σ_{l,μ} b^μ z^{-l} ∂/∂X_{μ,l}`, whose exponential is a translation of the variables. -/
noncomputable def vertexSub (b : Fin D → R) : Fock D R →ₐ[R] Polynomial (Fock D R) :=
  MvPolynomial.aeval fun v : Osc D =>
    Polynomial.C (X v) - Polynomial.C (C (b v.1)) * Polynomial.X ^ ((v.2 : ℕ))

lemma vertexSub_X (b : Fin D → R) (v : Osc D) :
    vertexSub b (X v)
      = Polynomial.C (X v) - Polynomial.C (C (b v.1)) * Polynomial.X ^ ((v.2 : ℕ)) :=
  MvPolynomial.aeval_X _ _

/-- The `T^L` coefficient of the substitution, for `L : ℕ`. -/
noncomputable def vertexAnnNat (b : Fin D → R) (L : ℕ) : Fock D R →ₗ[R] Fock D R where
  toFun P := (vertexSub b P).coeff L
  map_add' P Q := by rw [map_add, Polynomial.coeff_add]
  map_smul' r P := by
    rw [RingHom.id_apply, ← Polynomial.coeff_smul]
    congr 1
    exact map_smul (vertexSub b).toLinearMap r P

@[simp]
lemma vertexAnnNat_apply (b : Fin D → R) (L : ℕ) (P : Fock D R) :
    vertexAnnNat b L P = (vertexSub b P).coeff L := rfl

/-- The `z^{-L}` Laurent coefficient of the annihilation half; zero for `L < 0`. -/
noncomputable def vertexAnn (b : Fin D → R) (L : ℤ) : Fock D R →ₗ[R] Fock D R :=
  if 0 ≤ L then vertexAnnNat b L.toNat else 0

lemma vertexAnn_of_neg (b : Fin D → R) {L : ℤ} (hL : L < 0) : vertexAnn b L = 0 := by
  rw [vertexAnn, if_neg (by omega)]

lemma vertexAnn_of_nonneg (b : Fin D → R) {L : ℤ} (hL : 0 ≤ L) (P : Fock D R) :
    vertexAnn b L P = (vertexSub b P).coeff L.toNat := by
  rw [vertexAnn, if_pos hL, vertexAnnNat_apply]

@[simp]
lemma vertexAnn_one (b : Fin D → R) (L : ℤ) :
    vertexAnn b L (1 : Fock D R) = if L = 0 then 1 else 0 := by
  rcases lt_or_ge L 0 with hL | hL
  · rw [vertexAnn_of_neg b hL, LinearMap.zero_apply, if_neg (by omega)]
  · rw [vertexAnn_of_nonneg b hL, map_one, Polynomial.coeff_one]
    by_cases h : L = 0
    · rw [if_pos h, if_pos (by omega)]
    · rw [if_neg h, if_neg (by omega)]

lemma vertexAnn_apply_eq_zero_of_natDegree_lt (b : Fin D → R) (P : Fock D R) {L : ℤ}
    (h : ((vertexSub b P).natDegree : ℤ) < L) : vertexAnn b L P = 0 := by
  have hL : 0 ≤ L := le_trans (by positivity) h.le
  rw [vertexAnn_of_nonneg b hL]
  exact Polynomial.coeff_eq_zero_of_natDegree_lt (by omega)

/-- **The key algebraic property of the annihilation half**: it intertwines multiplication by
a creation operator up to a shift, `[α^μ_{-l}, E_+] = b^μ z^{-l} E_+`. -/
theorem vertexAnn_mul_X (b : Fin D → R) (L : ℤ) (P : Fock D R) (u : Osc D) :
    vertexAnn b L (P * X u)
      = vertexAnn b L P * X u - b u.1 • vertexAnn b (L - ((u.2 : ℕ) : ℤ)) P := by
  classical
  rcases lt_or_ge L 0 with hL | hL
  · rw [vertexAnn_of_neg b hL, vertexAnn_of_neg b (show L - ((u.2 : ℕ) : ℤ) < 0 by omega)]
    simp
  · have hsub : vertexSub b (P * X u)
        = vertexSub b P * Polynomial.C (X u)
          - vertexSub b P * Polynomial.C (C (b u.1)) * Polynomial.X ^ ((u.2 : ℕ)) := by
      rw [map_mul, vertexSub_X, mul_sub, mul_assoc]
    rw [vertexAnn_of_nonneg b hL, hsub, Polynomial.coeff_sub, Polynomial.coeff_mul_C,
      Polynomial.coeff_mul_X_pow', Polynomial.coeff_mul_C, vertexAnn_of_nonneg b hL]
    by_cases hle : ((u.2 : ℕ)) ≤ L.toNat
    · rw [if_pos hle,
        vertexAnn_of_nonneg b (show (0 : ℤ) ≤ L - ((u.2 : ℕ) : ℤ) by omega),
        show (L - ((u.2 : ℕ) : ℤ)).toNat = L.toNat - (u.2 : ℕ) by omega]
      congr 1
      rw [MvPolynomial.smul_eq_C_mul, mul_comm]
    · rw [if_neg hle, vertexAnn_of_neg b (show L - ((u.2 : ℕ) : ℤ) < 0 by omega)]
      simp

/-- The annihilation half commutes with every `∂/∂X_v`, i.e. `[α^μ_l, E_+] = 0` for `l > 0`. -/
theorem pderiv_vertexAnn (b : Fin D → R) (v : Osc D) (L : ℤ) (P : Fock D R) :
    pderiv v (vertexAnn b L P) = vertexAnn b L (pderiv v P) := by
  classical
  induction P using MvPolynomial.induction_on generalizing L with
  | C a =>
      have hCa : (C a : Fock D R) = a • 1 := by rw [MvPolynomial.smul_eq_C_mul, mul_one]
      have h2 : (pderiv v) (vertexAnn b L (C a : Fock D R)) = 0 := by
        rw [hCa, map_smul, vertexAnn_one]
        by_cases h : L = 0
        · rw [if_pos h, MvPolynomial.smul_eq_C_mul, mul_one]
          exact pderiv_C
        · rw [if_neg h, smul_zero, map_zero]
      rw [h2, pderiv_C, map_zero]
  | add p q hp hq => rw [map_add, map_add, map_add, map_add, hp, hq]
  | mul_X p u hp =>
      have hLHS : (pderiv v) (vertexAnn b L (p * X u))
          = vertexAnn b L ((pderiv v) p) * X u + vertexAnn b L p * ((pderiv v) (X u))
            - b u.1 • vertexAnn b (L - ((u.2 : ℕ) : ℤ)) ((pderiv v) p) := by
        rw [vertexAnn_mul_X, map_sub, Derivation.map_smul, pderiv_mul, hp, hp]
      have hRHS : vertexAnn b L ((pderiv v) (p * X u))
          = (vertexAnn b L ((pderiv v) p) * X u
              - b u.1 • vertexAnn b (L - ((u.2 : ℕ) : ℤ)) ((pderiv v) p))
            + vertexAnn b L (p * ((pderiv v) (X u))) := by
        rw [pderiv_mul, map_add, vertexAnn_mul_X]
      rw [hLHS, hRHS]
      by_cases h : v = u
      · rw [pderiv_X, Pi.single_apply, if_pos h.symm, mul_one, mul_one]
        ring
      · rw [pderiv_X, Pi.single_apply, if_neg (fun hc => h hc.symm), mul_zero, mul_zero,
          map_zero]
        ring

end VertexSub

/-! ### The Laurent coefficients of the vertex operator -/

section VertexOsc

variable [Algebra ℚ R]

/-- The finite index set outside which the `L`-th annihilation coefficient kills `P`. -/
noncomputable def vertexIdx (b : Fin D → R) (P : Fock D R) : Finset ℤ :=
  Finset.Icc 0 ((vertexSub b P).natDegree : ℤ)

omit [Algebra ℚ R] in
lemma vertexAnn_apply_eq_zero_of_notMem_vertexIdx (b : Fin D → R) (P : Fock D R) {L : ℤ}
    (hL : L ∉ vertexIdx b P) : vertexAnn b L P = 0 := by
  rw [vertexIdx, Finset.mem_Icc, not_and_or] at hL
  rcases hL with h | h
  · rw [vertexAnn_of_neg b (by omega), LinearMap.zero_apply]
  · exact vertexAnn_apply_eq_zero_of_natDegree_lt b P (by omega)

/-- **The `z^K` Laurent coefficient of the oscillator part of the vertex operator**
`:e^{i c·X(z)}:`, with `b^μ = (2α&apos;)^{1/2} c^μ`.  It is the locally finite sum
`Σ_{L} Φ_{K+L} Ψ_L` of (creation exponential coefficient) ∘ (annihilation coefficient);
on each vector only finitely many `L` contribute because `Ψ_L` is a polynomial coefficient. -/
noncomputable def vertexOsc (η b : Fin D → R) (K : ℤ) : Module.End R (Fock D R) :=
  lsumLocFin (fun L : ℤ => LinearMap.mulLeft R (creaExp η b (K + L)) ∘ₗ vertexAnn b L)
    (vertexIdx b)
    (fun P L hL => by
      rw [LinearMap.comp_apply, vertexAnn_apply_eq_zero_of_notMem_vertexIdx b P hL, map_zero])

/-- `vertexOsc` is computed by any sufficiently large finite index set. -/
theorem vertexOsc_apply (η b : Fin D → R) (K : ℤ) (P : Fock D R) {s : Finset ℤ}
    (hs : ∀ L ∉ s, vertexAnn b L P = 0) :
    vertexOsc η b K P = ∑ L ∈ s, creaExp η b (K + L) * vertexAnn b L P := by
  rw [vertexOsc, lsumLocFin_apply _ _ _ P (fun L hL => by
    rw [LinearMap.comp_apply, hs L hL, map_zero])]
  exact Finset.sum_congr rfl fun L _ => by
    rw [LinearMap.comp_apply, LinearMap.mulLeft_apply]

@[simp]
theorem vertexOsc_apply_one (η b : Fin D → R) (K : ℤ) :
    vertexOsc η b K (1 : Fock D R) = creaExp η b K := by
  classical
  rw [vertexOsc_apply η b K 1 (s := {0}) (fun L hL => by
    rw [vertexAnn_one, if_neg (by simpa using hL)]),
    Finset.sum_singleton, vertexAnn_one, if_pos rfl, mul_one, add_zero]

omit [Algebra ℚ R] in
lemma annihilation_mul (η : Fin D → R) (μ : Fin D) (m : ℕ+) (A B : Fock D R) :
    annihilation η μ m (A * B) = annihilation η μ m A * B + A * annihilation η μ m B := by
  rw [annihilation_apply, annihilation_apply, annihilation_apply, pderiv_mul, smul_add,
    smul_mul_assoc, mul_smul_comm]

omit [Algebra ℚ R] in
lemma annihilation_vertexAnn (η b : Fin D → R) (μ : Fin D) (m : ℕ+) (L : ℤ) (P : Fock D R) :
    annihilation η μ m (vertexAnn b L P) = vertexAnn b L (annihilation η μ m P) := by
  rw [annihilation_apply, annihilation_apply, map_smul, pderiv_vertexAnn]

/-- **`[α^μ_{-m}, V_K] = b^μ V_{K+m}`**: the creation modes shift the Laurent index. -/
theorem creation_vertexOsc_sub (η b : Fin D → R) (μ : Fin D) (m : ℕ+) (K : ℤ) (P : Fock D R) :
    creation R μ m (vertexOsc η b K P) - vertexOsc η b K (creation R μ m P)
      = b μ • vertexOsc η b (K + ((m : ℕ) : ℤ)) P := by
  classical
  set N : ℤ := ((vertexSub b P).natDegree : ℤ)
    + ((vertexSub b (X ((μ, m) : Osc D) * P)).natDegree : ℤ) + ((m : ℕ) : ℤ) with hN
  have hdeg1 : (0 : ℤ) ≤ ((vertexSub b P).natDegree : ℤ) := Int.natCast_nonneg _
  have hdeg2 : (0 : ℤ) ≤ ((vertexSub b (X ((μ, m) : Osc D) * P)).natDegree : ℤ) :=
    Int.natCast_nonneg _
  have hm0 : (0 : ℤ) < ((m : ℕ) : ℤ) := by exact_mod_cast m.pos
  have hsP : ∀ L ∉ Finset.Icc (0 : ℤ) N, vertexAnn b L P = 0 := by
    intro L hL
    rw [Finset.mem_Icc, not_and_or] at hL
    rcases hL with h | h
    · rw [vertexAnn_of_neg b (by omega), LinearMap.zero_apply]
    · exact vertexAnn_apply_eq_zero_of_natDegree_lt b P (by omega)
  have hsXP : ∀ L ∉ Finset.Icc (0 : ℤ) N, vertexAnn b L (X ((μ, m) : Osc D) * P) = 0 := by
    intro L hL
    rw [Finset.mem_Icc, not_and_or] at hL
    rcases hL with h | h
    · rw [vertexAnn_of_neg b (by omega), LinearMap.zero_apply]
    · exact vertexAnn_apply_eq_zero_of_natDegree_lt b (X ((μ, m) : Osc D) * P) (by omega)
  have hs'P : ∀ L ∉ Finset.Icc (-((m : ℕ) : ℤ)) (N - ((m : ℕ) : ℤ)), vertexAnn b L P = 0 := by
    intro L hL
    rw [Finset.mem_Icc, not_and_or] at hL
    rcases hL with h | h
    · rw [vertexAnn_of_neg b (by omega), LinearMap.zero_apply]
    · exact vertexAnn_apply_eq_zero_of_natDegree_lt b P (by omega)
  have hshift : ∑ L ∈ Finset.Icc (0 : ℤ) N,
        creaExp η b (K + L) * vertexAnn b (L - ((m : ℕ) : ℤ)) P
      = ∑ L ∈ Finset.Icc (-((m : ℕ) : ℤ)) (N - ((m : ℕ) : ℤ)),
        creaExp η b ((K + ((m : ℕ) : ℤ)) + L) * vertexAnn b L P := by
    refine Finset.sum_equiv (Equiv.subRight ((m : ℕ) : ℤ)) (fun L => ?_) (fun L _ => ?_)
    · simp only [Equiv.subRight_apply, Finset.mem_Icc]
      omega
    · simp only [Equiv.subRight_apply]
      rw [show K + ((m : ℕ) : ℤ) + (L - ((m : ℕ) : ℤ)) = K + L from by ring]
  simp only [creation_apply]
  rw [vertexOsc_apply η b K P hsP,
    vertexOsc_apply η b K (X ((μ, m) : Osc D) * P) hsXP,
    vertexOsc_apply η b (K + ((m : ℕ) : ℤ)) P hs'P, ← hshift, Finset.mul_sum, Finset.smul_sum,
    ← Finset.sum_sub_distrib]
  refine Finset.sum_congr rfl fun L _ => ?_
  rw [show (X ((μ, m) : Osc D) * P : Fock D R) = P * X ((μ, m) : Osc D) from mul_comm _ _,
    vertexAnn_mul_X]
  simp only [MvPolynomial.smul_eq_C_mul, mul_sub]
  ring

/-- **`[α^μ_m, V_K] = b^μ V_{K-m}`**: the annihilation modes shift the Laurent index the other
way.  Uses `η^{μμ} η_{μμ} = 1` (the metric enters both the mode normalisation and the
contraction of spacetime indices). -/
theorem annihilation_vertexOsc_sub (η b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (μ : Fin D)
    (m : ℕ+) (K : ℤ) (P : Fock D R) :
    annihilation η μ m (vertexOsc η b K P) - vertexOsc η b K (annihilation η μ m P)
      = b μ • vertexOsc η b (K - ((m : ℕ) : ℤ)) P := by
  classical
  set N : ℤ := ((vertexSub b P).natDegree : ℤ)
    + ((vertexSub b (annihilation η μ m P)).natDegree : ℤ) with hN
  have hdeg1 : (0 : ℤ) ≤ ((vertexSub b P).natDegree : ℤ) := Int.natCast_nonneg _
  have hdeg2 : (0 : ℤ) ≤ ((vertexSub b (annihilation η μ m P)).natDegree : ℤ) :=
    Int.natCast_nonneg _
  have hsP : ∀ L ∉ Finset.Icc (0 : ℤ) N, vertexAnn b L P = 0 := by
    intro L hL
    rw [Finset.mem_Icc, not_and_or] at hL
    rcases hL with h | h
    · rw [vertexAnn_of_neg b (by omega), LinearMap.zero_apply]
    · exact vertexAnn_apply_eq_zero_of_natDegree_lt b P (by omega)
  have hsAP : ∀ L ∉ Finset.Icc (0 : ℤ) N, vertexAnn b L (annihilation η μ m P) = 0 := by
    intro L hL
    rw [Finset.mem_Icc, not_and_or] at hL
    rcases hL with h | h
    · rw [vertexAnn_of_neg b (by omega), LinearMap.zero_apply]
    · exact vertexAnn_apply_eq_zero_of_natDegree_lt b (annihilation η μ m P) (by omega)
  rw [vertexOsc_apply η b K P hsP, vertexOsc_apply η b K (annihilation η μ m P) hsAP,
    vertexOsc_apply η b (K - ((m : ℕ) : ℤ)) P hsP, map_sum, Finset.smul_sum,
    ← Finset.sum_sub_distrib]
  refine Finset.sum_congr rfl fun L _ => ?_
  rw [annihilation_mul, annihilation_creaExp η b hη, annihilation_vertexAnn,
    show K + L - ((m : ℕ) : ℤ) = K - ((m : ℕ) : ℤ) + L from by ring]
  simp only [MvPolynomial.smul_eq_C_mul]
  ring

/-! ### The level grading: `V_K` raises the level by exactly `K` -/

/-- The creation-mode relation in the form used for the induction over monomials. -/
theorem vertexOsc_X_mul (η b : Fin D → R) (v : Osc D) (K : ℤ) (P : Fock D R) :
    vertexOsc η b K (X v * P)
      = X v * vertexOsc η b K P - b v.1 • vertexOsc η b (K + (((v.2 : ℕ)) : ℤ)) P := by
  obtain ⟨μ, m⟩ := v
  have h := creation_vertexOsc_sub η b μ m K P
  simp only [creation_apply] at h
  rw [← h]
  ring

private lemma vertexOsc_monomial_aux (η b : Fin D → R) :
    ∀ (N : ℕ) (d : Osc D →₀ ℕ), level D d = N → ∀ (c : R) (K : ℤ),
      (∀ M : ℕ, (M : ℤ) = (N : ℤ) + K →
        vertexOsc η b K (monomial d c) ∈ levelSubmodule D R M)
      ∧ ((N : ℤ) + K < 0 → vertexOsc η b K (monomial d c) = 0) := by
  classical
  intro N
  induction N using Nat.strong_induction_on with
  | _ N ih =>
    intro d hd c K
    rcases eq_or_ne d 0 with rfl | hdne
    · have hN : N = 0 := by rw [← hd, level_zero]
      subst hN
      have hmon : (monomial (0 : Osc D →₀ ℕ) c : Fock D R) = c • 1 := by
        rw [MvPolynomial.smul_eq_C_mul, mul_one, monomial_zero']
      rw [hmon, map_smul, vertexOsc_apply_one]
      refine ⟨fun M hM => Submodule.smul_mem _ _ ?_, fun hK => ?_⟩
      · exact creaExp_mem_levelSubmodule η b (by omega)
      · rw [creaExp_of_neg η b (by omega), smul_zero]
    · obtain ⟨v, hv⟩ := Finsupp.support_nonempty_iff.mpr hdne
      have hv' : d v ≠ 0 := Finsupp.mem_support_iff.mp hv
      have hsplit : Finsupp.single v 1 + (d - Finsupp.single v 1) = d :=
        single_add_tsub_single hv'
      set d' : Osc D →₀ ℕ := d - Finsupp.single v 1 with hd'def
      have hlev : ((v.2 : ℕ)) + level D d' = N := by
        conv_lhs => rw [show ((v.2 : ℕ)) = level D (Finsupp.single v 1) by
          rw [level_single]; simp [oscLevel]]
        rw [← level_add, hsplit, hd]
      have hmon : (monomial d c : Fock D R) = X v * monomial d' c := by
        conv_lhs => rw [← hsplit]
        rw [monomial_single_add, pow_one]
      have hvpos : 0 < ((v.2 : ℕ)) := v.2.pos
      have hlt : level D d' < N := by omega
      have ihd' := fun (K' : ℤ) => ih (level D d') hlt d' rfl c K'
      rw [hmon]
      constructor
      · intro M hM
        rw [vertexOsc_X_mul]
        refine Submodule.sub_mem _ ?_ (Submodule.smul_mem _ _ ?_)
        · rcases lt_or_ge ((level D d' : ℤ) + K) 0 with hneg | hpos
          · rw [(ihd' K).2 hneg, mul_zero]
            exact Submodule.zero_mem _
          · obtain ⟨M', hM'⟩ : ∃ M' : ℕ, (M' : ℤ) = (level D d' : ℤ) + K :=
              ⟨((level D d' : ℤ) + K).toNat, by omega⟩
            have hmem := (ihd' K).1 M' hM'
            have := creation_mem_levelSubmodule (R := R) v.1 v.2 hmem
            rw [creation_apply] at this
            have hMM : ((v.2 : ℕ)) + M' = M := by omega
            rwa [hMM] at this
        · exact (ihd' (K + ((v.2 : ℕ) : ℤ))).1 M (by omega)
      · intro hK
        rw [vertexOsc_X_mul, (ihd' K).2 (by omega),
          (ihd' (K + ((v.2 : ℕ) : ℤ))).2 (by omega), mul_zero, smul_zero, sub_zero]

/-- **`V_K` maps the level-`N` piece into the level-`(N+K)` piece.** -/
theorem vertexOsc_mem_levelSubmodule (η b : Fin D → R) {N : ℕ} {P : Fock D R}
    (hP : P ∈ levelSubmodule D R N) {K : ℤ} {M : ℕ} (hM : (M : ℤ) = (N : ℤ) + K) :
    vertexOsc η b K P ∈ levelSubmodule D R M := by
  classical
  have hPsum : vertexOsc η b K P
      = ∑ d ∈ P.support, vertexOsc η b K (monomial d (coeff d P)) := by
    conv_lhs => rw [P.as_sum]
    rw [map_sum]
  rw [hPsum]
  refine Submodule.sum_mem _ fun d hd => ?_
  have hlev : level D d = N := hP (mem_support_iff.mp hd)
  exact (vertexOsc_monomial_aux η b N d hlev (coeff d P) K).1 M hM

/-- **`V_K` annihilates the level-`N` piece as soon as `N + K < 0`**: the vertex operator
cannot lower the level below the vacuum.  This is the finiteness that makes DDF-type contour
integrals well defined. -/
theorem vertexOsc_apply_eq_zero_of_level (η b : Fin D → R) {N : ℕ} {P : Fock D R}
    (hP : P ∈ levelSubmodule D R N) {K : ℤ} (hK : (N : ℤ) + K < 0) :
    vertexOsc η b K P = 0 := by
  classical
  have hPsum : vertexOsc η b K P
      = ∑ d ∈ P.support, vertexOsc η b K (monomial d (coeff d P)) := by
    conv_lhs => rw [P.as_sum]
    rw [map_sum]
  rw [hPsum]
  refine Finset.sum_eq_zero fun d hd => ?_
  have hlev : level D d = N := hP (mem_support_iff.mp hd)
  exact (vertexOsc_monomial_aux η b N d hlev (coeff d P) K).2 hK

/-! ### The mode algebra of the vertex operator -/

/-- **`[α^μ_p, V_K] = b^μ V_{K-p}` for every nonzero mode `p`.**  This is the defining
property of the (oscillator part of the) exponential vertex operator: it is a "coherent state"
for the oscillator algebra.  For `p = 0` the analogous identity fails on a *single* Fock space
(see `lie_mode_zero_vertexOsc`); it holds only after the momentum zero mode `x^μ` is added,
i.e. on the momentum tower, where `e^{i c·x}` shifts `p ↦ p + c`. -/
theorem lie_mode_vertexOsc (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (μ : Fin D) {p : ℤ}
    (hp : p ≠ 0) (K : ℤ) :
    ⁅mode η a μ p, vertexOsc η b K⁆ = b μ • vertexOsc η b (K - p) := by
  refine LinearMap.ext fun P => ?_
  rw [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
    Module.End.mul_apply, LinearMap.smul_apply]
  rcases hp.lt_or_gt with hneg | hpos
  · have hn : ((((-p).toNat.toPNat' : ℕ+) : ℕ) : ℤ) = -p := by
      rw [toPNat'_coe_of_pos (by omega : (0 : ℤ) < -p)]
      omega
    have hcr := creation_vertexOsc_sub η b μ ((-p).toNat.toPNat') K P
    rw [hn, show K + -p = K - p from by ring] at hcr
    rw [mode_of_neg η a hneg]
    exact hcr
  · have hn : ((((p).toNat.toPNat' : ℕ+) : ℕ) : ℤ) = p := by
      rw [toPNat'_coe_of_pos hpos]
      omega
    have han := annihilation_vertexOsc_sub η b hη μ (p.toNat.toPNat') K P
    rw [hn] at han
    rw [mode_of_pos η a hpos]
    exact han

/-- On a single Fock space the zero mode is a scalar, so it commutes with the vertex operator.
This is *not* the physical statement `[α^μ_0, V] = b^μ V`: the missing piece is exactly the
momentum shift `p ↦ p + c` carried by `e^{i c·x}`, which needs the momentum tower. -/
theorem lie_mode_zero_vertexOsc (η a b : Fin D → R) (μ : Fin D) (K : ℤ) :
    ⁅mode η a μ 0, vertexOsc η b K⁆ = 0 := by
  rw [mode_zero]
  exact lie_smul_id_left _ _

/-- **Transversality.**  If the vertex momentum `b` has no component in the direction `μ`
(`ε·k_0 = 0` in the DDF construction), then `α^μ_p` commutes with the vertex operator for
*every* `p`, including `p = 0`.  This is what makes the DDF contour integral a finite sum. -/
theorem lie_mode_vertexOsc_of_eq_zero (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    {μ : Fin D} (hb : b μ = 0) (p : ℤ) (K : ℤ) :
    ⁅mode η a μ p, vertexOsc η b K⁆ = 0 := by
  rcases eq_or_ne p 0 with rfl | hp
  · exact lie_mode_zero_vertexOsc η a b μ K
  · rw [lie_mode_vertexOsc η a b hη μ hp K, hb, zero_smul]

/-- **The two-momentum form of the mode algebra**, valid for *every* `q : ℤ`.  The vertex
operator maps the momentum-`a` Fock space to the momentum-`(a+b)` one; realising both as the
same `Fock D R` and letting the zero mode act with the appropriate parameter on each side,
the relation `[α^μ_q, V_K] = b^μ V_{K-q}` holds without exception.  This is the same content
as `lie_towerMode_towerVertex` in `StringFormal/NoGhost/DDF.lean`, packaged without the
momentum tower. -/
theorem mode_vertexOsc_sub (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (μ : Fin D) (q K : ℤ)
    (P : Fock D R) :
    mode η (a + b) μ q (vertexOsc η b K P) - vertexOsc η b K (mode η a μ q P)
      = b μ • vertexOsc η b (K - q) P := by
  rcases eq_or_ne q 0 with rfl | hq
  · rw [mode_zero, mode_zero]
    simp only [LinearMap.smul_apply, LinearMap.id_coe, id_eq, map_smul, sub_zero, Pi.add_apply]
    rw [← sub_smul]
    congr 1
    ring
  · have hmode : mode η (a + b) μ q = mode η a μ q := by
      rcases hq.lt_or_gt with hneg | hpos
      · rw [mode_of_neg _ _ hneg, mode_of_neg _ _ hneg]
      · rw [mode_of_pos _ _ hpos, mode_of_pos _ _ hpos]
    rw [hmode]
    have h := lie_mode_vertexOsc η a b hη μ hq K
    have h' := congrArg (fun T : Module.End R (Fock D R) => T P) h
    simpa [LieRing.of_associative_ring_bracket] using h'

/-! ### Rigidity: the vertex operator is determined by its value on the vacuum -/

omit [Algebra ℚ R] in
/-- A family of endomorphisms obeying the creation-mode recursion of the vertex operator and
killing the vacuum is identically zero.  The proof is a plain induction over monomials: the
recursion trades one creation operator for a shift of the Laurent index.

This is the *inductive step* of any identity of the shape "`W_J` satisfies the vertex-operator
commutation relations": it reduces such an identity to its restriction to the vacuum. -/
theorem eq_zero_of_vertex_recursion (b : Fin D → R) (W : ℤ → Module.End R (Fock D R))
    (hrec : ∀ (v : Osc D) (J : ℤ) (P : Fock D R),
      W J (X v * P) = X v * W J P - b v.1 • W (J + (((v.2 : ℕ)) : ℤ)) P)
    (hvac : ∀ J : ℤ, W J (1 : Fock D R) = 0) (J : ℤ) : W J = 0 := by
  have key : ∀ (P : Fock D R) (J : ℤ), W J P = 0 := by
    intro P
    induction P using MvPolynomial.induction_on with
    | C a =>
        intro J
        rw [show (C a : Fock D R) = a • 1 by rw [MvPolynomial.smul_eq_C_mul, mul_one],
          map_smul, hvac, smul_zero]
    | add p q hp hq =>
        intro J
        rw [map_add, hp, hq, add_zero]
    | mul_X p v hp =>
        intro J
        rw [mul_comm, hrec, hp, hp, mul_zero, smul_zero, sub_zero]
  exact LinearMap.ext fun P => by rw [key P J, LinearMap.zero_apply]

/-- **Rigidity of the vertex operator.**  Its Laurent coefficients are the *unique* family of
endomorphisms satisfying the creation-mode relation `[α^μ_{-l}, W_J] = b^μ W_{J+l}` and taking
the prescribed values `creaExp η b J` on the vacuum. -/
theorem vertexOsc_unique (η b : Fin D → R) (W : ℤ → Module.End R (Fock D R))
    (hrec : ∀ (v : Osc D) (J : ℤ) (P : Fock D R),
      W J (X v * P) = X v * W J P - b v.1 • W (J + (((v.2 : ℕ)) : ℤ)) P)
    (hvac : ∀ J : ℤ, W J (1 : Fock D R) = creaExp η b J) (J : ℤ) :
    W J = vertexOsc η b J := by
  have hzero := eq_zero_of_vertex_recursion b (fun J => W J - vertexOsc η b J) ?_ ?_ J
  · rwa [sub_eq_zero] at hzero
  · intro v J P
    simp only [LinearMap.sub_apply, hrec v J P, vertexOsc_X_mul η b v J P]
    rw [smul_sub, mul_sub]
    ring
  · intro J
    simp only [LinearMap.sub_apply, hvac J, vertexOsc_apply_one, sub_self]

end VertexOsc

end Fock

end StringFormal.NoGhost
