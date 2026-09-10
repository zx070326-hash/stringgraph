/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import Mathlib.Algebra.MvPolynomial.CommRing
import StringFormal.NoGhost.TowerPairing
import StringFormal.NoGhost.VertexOperator
import StringFormal.NoGhost.DDFOperator

/-!
# The adjoint of the vertex operator, on a Fock space and on the DDF tower

Graph nodes: `worldsheet.vertex-operator-adjoint`, `worldsheet.ddf-operators-adjoint`.
This file closes gap (3) of `StringFormal/NoGhost/VertexOperator.lean` ("no adjointness of
`V_K` for `Fock.pairing` is proved") and gap (2) of `StringFormal/NoGhost/TowerPairing.lean`
("the adjointness of the DDF operators `A^i_n` is not available").

## Conventions

`conv.metric-mostly-plus`, `conv.alpha-prime-regge`, as in `StringFormal/NoGhost/Fock.lean`.
`b^μ = (2α')^{1/2} c^μ` is the rescaled vertex momentum.  The form `Fock.pairing η` is
**`R`-bilinear, not sesquilinear**: nothing is conjugated anywhere, so "adjoint" means
`⟨A v, w⟩ = ⟨v, A^† w⟩` for the bilinear form.  The only standing hypothesis is
`hη : ∀ μ, η μ * η μ = 1`, exactly as in `Sugawara.lean`.

## Main statements

* `Fock.pairing_creaExp_left` — `Φ_j(b)^† = Ψ_j(-b)`: multiplication by the `z^j` coefficient
  of the creation exponential `E_-(b)` is adjoint to the `z^{-j}` coefficient of the
  annihilation exponential `E_+(-b)`.
* `Fock.pairing_vertexAnn_left` — the mirror statement `Ψ_L(b)^† = Φ_L(-b)`.
* **`Fock.pairing_vertexOsc_left`** — `⟨V(b)_K v, w⟩ = ⟨v, V(-b)_{-K} w⟩`, the adjoint of the
  oscillator part of `:e^{i c·X(z)}:` on a single Fock space.
* **`Fock.towerPairing_towerVertex_left`** — `(V^{(n)}_K)^† = V^{(-n)}_{-K}` on the DDF
  momentum tower.
* **`Fock.towerPairing_ddfOp_left`** — `(A^ε_n)^† = A^ε_{-n}` for the transverse DDF
  operators.
* `Fock.add_self_eq_zero_of_pairing_vertexOsc_same_momentum` — an *audit* lemma: the sign
  flip `b ↦ -b` above is forced.  If `⟨V(b)_K v, w⟩ = ⟨v, V(b)_{-K} w⟩` held for one `b`,
  then `2b = 0`.

## Two corrections to the folklore statement

1. **No isotropy hypothesis is needed.**  One expects the reordering `E_+ E_- ↦ E_- E_+` in
   the adjoint to generate a self-contraction `exp(Σ_l (b·b)/l ⋯)`, hence to require
   `b·b = 0`.  It does not.  The adjoint of the *normal-ordered* product `E_-(b) E_+(b)` is
   `E_+(b)^† E_-(b)^† = E_-(-b) E_+(-b)`, which is again normal ordered — the creation factor
   ends up on the left by itself.  So `pairing_vertexOsc_left` holds for arbitrary `b`, and
   `pairing_vertexOsc_left_of_dotVec_zero` (the `b·b = 0` form asked for by the graph node) is
   a trivial specialisation.  *Consequence for the dependency graph*: the adjointness of the
   DDF operators does **not** depend on `k_0² = 0`.
2. **The vertex momentum flips sign; `b` alone is wrong.**  Since the form is bilinear one
   might argue that no coefficient can change, so `V(b)^†` should again involve `b`.  That
   argument fails because the two halves of `:e^{i c·X}:` carry *opposite* signs in the
   exponent, `E_-(z) = exp(+Σ_{m>0} b·α_{-m} z^m/m)` versus
   `E_+(z) = exp(-Σ_{l>0} b·α_l z^{-l}/l)`, so the map `α^μ_m ↦ α^μ_{-m}` sends `E_-(b)` to
   `E_+(-b)`, not to `E_+(b)`.  On the tower this is invisible, because `-(n b)` is
   `(-n) b`: the Fock-level sign flip is exactly the `n ↦ -n` of `e^{i n k_0·x}`, and the
   familiar `(V^{(n)}_J)^† = V^{(-n)}_{-J}` comes out unchanged.

## Remaining gaps

* Still `R`-bilinear, not Hermitian; no positivity, no completion, no zero modes beyond the
  tower.  In particular *nothing here says the DDF states have positive norm*; the no-ghost
  theorem needs `⟨A^{i_1}_{-n_1} ⋯ |0⟩, ⋯⟩` to be computed from `(A^ε_n)^† = A^ε_{-n}`
  **together with** the DDF commutation relations, which are in
  `StringFormal/NoGhost/DDFOperatorAll.lean`.  That assembly is not done here.
* `towerPairing_ddfOp_left` uses `dotVec η ε b = 0` only because `ddfOp` does; the underlying
  `towerPairing_towerVertex_left` needs no transversality.

## Status

Complete, no `sorry`; axioms are `propext`, `Classical.choice`, `Quot.sound` only.
-/
namespace StringFormal.NoGhost

open MvPolynomial

section TowerApply

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

/-- Pointwise formula for the DDF vertex operator: rung `j` of `V^{(n)}_K w` is the oscillator
vertex operator applied to rung `j - n` of `w`. -/
lemma towerVertex_apply (η b : Fin D → R) (n K : ℤ) (w : TowerFock D R) (j : ℤ) :
    towerVertex η b n K w j
      = Fock.vertexOsc η (vertexMomentum b n) (K - n) (w (j - n)) := by
  rw [towerVertex, LinearMap.comp_apply, towerShift_apply, towerDiag_apply]

end TowerApply

namespace Fock

variable {D : ℕ} {R : Type*} [CommRing R]

/-- Pairing against the vacuum extracts the constant term. -/
lemma pairing_one_left (η : Fin D → R) (Q : Fock D R) :
    pairing η (1 : Fock D R) Q = coeff 0 Q := by
  have h : (1 : Fock D R) = monomial (0 : Osc D →₀ ℕ) 1 := by rw [monomial_zero', C_1]
  rw [h, pairing_monomial_left, monomialNorm_zero, one_mul, one_mul]

private lemma coeff_zero_mul_X (Q : Fock D R) (u : Osc D) :
    coeff (0 : Osc D →₀ ℕ) (Q * X u) = 0 := by
  classical
  rw [coeff_mul_X', if_neg (by simp)]

section CreaExpAdjoint

variable [Algebra ℚ R]

/-- **The vacuum matrix element of the creation exponential.**  `⟨Φ_j(b), w⟩ = ` the constant
term of `Ψ_j(-b) w`.  This is the one computation behind every adjointness statement in this
file; both sides satisfy the same recursion in `w`. -/
theorem pairing_creaExp_one_left (η b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (j : ℤ)
    (w : Fock D R) :
    pairing η (creaExp η b j) w = coeff 0 (vertexAnn (-b) j w) := by
  classical
  induction w using MvPolynomial.induction_on generalizing j with
  | C a =>
      have hCa : (C a : Fock D R) = a • (1 : Fock D R) := by
        rw [MvPolynomial.smul_eq_C_mul, mul_one]
      rw [hCa, map_smul, smul_eq_mul, map_smul, coeff_smul, smul_eq_mul, vertexAnn_one,
        pairing_comm, pairing_one_left, coeff_creaExp]
      by_cases h : j = 0
      · subst h
        rw [if_pos rfl, if_pos (by simp), expWeight_zero, coeff_one, if_pos rfl]
      · rw [if_neg h, if_neg (fun hc => h hc.symm), coeff_zero]
  | add p q hp hq =>
      rw [map_add (pairing η (creaExp η b j)), map_add (vertexAnn (-b) j), coeff_add, hp, hq]
  | mul_X p u hp =>
      have hcre : (p * X u : Fock D R) = creation R u.1 u.2 p := by
        rw [creation_apply, mul_comm]
      rw [hcre, pairing_creation_right, annihilation_creaExp η b hη, map_smul,
        LinearMap.smul_apply, smul_eq_mul, hp, ← hcre, vertexAnn_mul_X, coeff_sub,
        coeff_zero_mul_X, coeff_smul, smul_eq_mul, Pi.neg_apply]
      ring

/-- **The creation half of the vertex operator is adjoint to the annihilation half of the
*opposite* momentum**: `Φ_j(b)^† = Ψ_j(-b)`, where `Φ_j(b)` acts by multiplication by
`creaExp η b j` and `Ψ_j(c) = vertexAnn c j`.

The sign flip `b ↦ -b` is *not* an artefact of a missing complex conjugation (the form is
`R`-bilinear, so no coefficient is conjugated): it is forced by the relative minus sign
between the two halves of the normal-ordered exponential,
`E_-(z) = exp(+Σ_{m>0} b·α_{-m} z^m/m)` versus `E_+(z) = exp(-Σ_{l>0} b·α_l z^{-l}/l)`.
Under `α^μ_m ↦ α^μ_{-m}` the first becomes the second with `b` replaced by `-b`. -/
theorem pairing_creaExp_left (η b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (j : ℤ)
    (v w : Fock D R) :
    pairing η (creaExp η b j * v) w = pairing η v (vertexAnn (-b) j w) := by
  classical
  induction v using MvPolynomial.induction_on generalizing j w with
  | C a =>
      have h1 : (creaExp η b j * C a : Fock D R) = a • creaExp η b j := by
        rw [MvPolynomial.smul_eq_C_mul]; exact mul_comm _ _
      have h2 : (C a : Fock D R) = a • (1 : Fock D R) := by
        rw [MvPolynomial.smul_eq_C_mul, mul_one]
      rw [h1, h2, map_smul, LinearMap.smul_apply, smul_eq_mul, map_smul,
        LinearMap.smul_apply, smul_eq_mul, pairing_creaExp_one_left η b hη,
        pairing_one_left]
  | add p q hp hq =>
      rw [mul_add, map_add (pairing η), LinearMap.add_apply, hp, hq,
        map_add (pairing η), LinearMap.add_apply]
  | mul_X p u hp =>
      have hL : (creaExp η b j * (p * X u) : Fock D R)
          = creation R u.1 u.2 (creaExp η b j * p) := by
        rw [creation_apply]; ring
      have hR : (p * X u : Fock D R) = creation R u.1 u.2 p := by
        rw [creation_apply, mul_comm]
      rw [hL, pairing_creation_left, hp, hR, pairing_creation_left, annihilation_vertexAnn]

/-- **The annihilation half is adjoint to the creation half of the opposite momentum**:
`Ψ_L(b)^† = Φ_L(-b)`.  Obtained from `pairing_creaExp_left` by symmetry of the form. -/
theorem pairing_vertexAnn_left (η b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (L : ℤ)
    (v w : Fock D R) :
    pairing η (vertexAnn b L v) w = pairing η v (creaExp η (-b) L * w) := by
  have h := pairing_creaExp_left η (-b) hη L w v
  rw [neg_neg] at h
  rw [pairing_comm η v, h, pairing_comm]

/-! ### The adjoint of the vertex operator on a single Fock space -/

/-- **`V(b)_K^† = V(-b)_{-K}`** for the Fock form.

Written out: `⟨V(b)_K v, w⟩ = ⟨v, V(-b)_{-K} w⟩`, where `V(b)_K = Fock.vertexOsc η b K` is the
`z^K` Laurent coefficient of the oscillator part of `:e^{i c·X(z)}:` with `b = (2α')^{1/2} c`.

Three remarks, all of them corrections to the folklore statement.

* **No isotropy hypothesis.**  One might expect the reordering `E_+ E_- ↦ E_- E_+` to produce a
  self-contraction `exp(Σ_l (b·b)/l …)` and hence to need `b·b = 0`.  It does not: the adjoint
  of the *normal-ordered* product `E_-(b) E_+(b)` is `E_+(b)^† E_-(b)^† = E_-(-b) E_+(-b)`,
  which is *again* normal ordered.  So the identity holds for arbitrary `b`, and the only
  hypothesis is `hη`, the same one every spacetime-index contraction in this development uses.
* **The momentum flips sign.**  See `pairing_creaExp_left` for why `-b` and not `b`: the two
  halves of the normal-ordered exponential carry opposite signs in the exponent.
* **The Laurent index flips sign with no shift.**  `V_K` here is the plain `z^K` coefficient,
  with no conformal-weight normalisation, so the usual `z^{-2h}` of radial quantisation does
  not appear.  The DDF bookkeeping `(V^{(n)}_J)^† = V^{(-n)}_{-J}` is recovered on the tower
  (`towerPairing_towerVertex_left`), where `b ↦ -b` is absorbed into `n ↦ -n`. -/
theorem pairing_vertexOsc_left (η b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (K : ℤ)
    (v w : Fock D R) :
    pairing η (vertexOsc η b K v) w = pairing η v (vertexOsc η (-b) (-K) w) := by
  classical
  set s : Finset ℤ := vertexIdx b v ∪ (vertexIdx (-b) w).image (fun M => M - K) with hsdef
  have hsv : ∀ L ∉ s, vertexAnn b L v = 0 := fun L hL =>
    vertexAnn_apply_eq_zero_of_notMem_vertexIdx b v
      (fun hc => hL (Finset.mem_union_left _ hc))
  have hsw : ∀ M ∉ s.image (fun L => K + L), vertexAnn (-b) M w = 0 := by
    intro M hM
    refine vertexAnn_apply_eq_zero_of_notMem_vertexIdx (-b) w fun hc => hM ?_
    refine Finset.mem_image.mpr ⟨M - K, ?_, by ring⟩
    exact Finset.mem_union_right _ (Finset.mem_image.mpr ⟨M, hc, rfl⟩)
  have hLHS : pairing η (vertexOsc η b K v) w
      = ∑ L ∈ s, pairing η v (creaExp η (-b) L * vertexAnn (-b) (K + L) w) := by
    rw [vertexOsc_apply η b K v hsv, map_sum, LinearMap.sum_apply]
    exact Finset.sum_congr rfl fun L _ => by
      rw [pairing_creaExp_left η b hη, pairing_vertexAnn_left η b hη]
  have hRHS : pairing η v (vertexOsc η (-b) (-K) w)
      = ∑ L ∈ s, pairing η v (creaExp η (-b) L * vertexAnn (-b) (K + L) w) := by
    rw [vertexOsc_apply η (-b) (-K) w hsw, map_sum,
      Finset.sum_image (fun x _ y _ h => by omega)]
    exact Finset.sum_congr rfl fun L _ => by rw [show -K + (K + L) = L from by ring]
  rw [hLHS, hRHS]

/-- `⟨v, V(b)_K w⟩ = ⟨V(-b)_{-K} v, w⟩`. -/
theorem pairing_vertexOsc_right (η b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (K : ℤ)
    (v w : Fock D R) :
    pairing η v (vertexOsc η b K w) = pairing η (vertexOsc η (-b) (-K) v) w := by
  rw [pairing_vertexOsc_left η (-b) hη (-K), neg_neg, neg_neg]

/-- The special case `b · b = 0` singled out by the graph node
`worldsheet.vertex-operator-adjoint`: for an isotropic vertex momentum the adjoint relation
holds — but so it does for every `b`, see `pairing_vertexOsc_left`. -/
theorem pairing_vertexOsc_left_of_dotVec_zero (η b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (_hbb : dotVec η b b = 0) (K : ℤ) (v w : Fock D R) :
    pairing η (vertexOsc η b K v) w = pairing η v (vertexOsc η (-b) (-K) w) :=
  pairing_vertexOsc_left η b hη K v w

/-! ### The sign of the vertex momentum is not a matter of convention -/

omit [Algebra ℚ R] in
/-- Closed form for the annihilation half on a one-oscillator state:
`Ψ_L(b) α^μ_{-m}|0⟩ = δ_{L,0} α^μ_{-m}|0⟩ - δ_{L,m} b^μ |0⟩`. -/
lemma vertexAnn_X (b : Fin D → R) (L : ℤ) (u : Osc D) :
    vertexAnn b L (X u)
      = (if L = 0 then X u else 0)
        - b u.1 • (if L = ((u.2 : ℕ) : ℤ) then (1 : Fock D R) else 0) := by
  have h := vertexAnn_mul_X b L (1 : Fock D R) u
  rw [one_mul, vertexAnn_one, vertexAnn_one] at h
  rw [h]
  congr 1
  · by_cases hL : L = 0
    · rw [if_pos hL, if_pos hL, one_mul]
    · rw [if_neg hL, if_neg hL, zero_mul]
  · congr 1
    by_cases hL : L = ((u.2 : ℕ) : ℤ)
    · rw [if_pos (by omega), if_pos hL]
    · rw [if_neg (by omega), if_neg hL]

/-- **The `b ↦ -b` in `pairing_vertexOsc_left` is forced, not conventional.**  If the naive
"same momentum" adjoint relation `⟨V(b)_K v, w⟩ = ⟨v, V(b)_{-K} w⟩` held for a single `b`,
then `2 b = 0`.

The witness is the lowest nontrivial matrix element: with `v = |0⟩`, `w = α^μ_{-1}|0⟩` and
`K = 1`, one computes `⟨V(b)_1 |0⟩, α^μ_{-1}|0⟩⟩ = b^μ` but
`⟨|0⟩, V(b)_{-1} α^μ_{-1}|0⟩⟩ = -b^μ`. -/
theorem add_self_eq_zero_of_pairing_vertexOsc_same_momentum (η b : Fin D → R)
    (hη : ∀ μ, η μ * η μ = 1)
    (h : ∀ (K : ℤ) (v w : Fock D R),
      pairing η (vertexOsc η b K v) w = pairing η v (vertexOsc η b (-K) w))
    (μ : Fin D) : b μ + b μ = 0 := by
  classical
  set u : Osc D := (μ, 1) with hu
  have hlhs : pairing η (vertexOsc η b 1 (1 : Fock D R)) (X u) = b μ := by
    rw [vertexOsc_apply_one, pairing_creaExp_one_left η b hη, vertexAnn_X]
    simp [hu]
  have hann : vertexAnn b 1 (X u) = C (-b μ) := by
    rw [vertexAnn_X]
    simp [hu, MvPolynomial.smul_eq_C_mul]
  have hrhs : pairing η (1 : Fock D R) (vertexOsc η b (-1) (X u)) = -b μ := by
    rw [vertexOsc_apply η b (-1) (X u) (s := {0, 1}) (fun L hL => by
      rw [vertexAnn_X]
      simp only [Finset.mem_insert, Finset.mem_singleton, not_or] at hL
      rw [if_neg hL.1, if_neg (by simpa [hu] using hL.2), smul_zero, sub_zero])]
    rw [Finset.sum_insert (by simp), Finset.sum_singleton,
      creaExp_of_neg η b (by norm_num : (-1 : ℤ) + 0 < 0), zero_mul, zero_add,
      show (-1 : ℤ) + 1 = 0 from by ring, creaExp_zero, one_mul, hann, pairing_one_left,
      coeff_C, if_pos rfl]
  have := h 1 (1 : Fock D R) (X u)
  rw [hlhs, hrhs] at this
  linear_combination this

end CreaExpAdjoint

/-! ### The adjoint of the vertex operator on the DDF momentum tower -/

section TowerVertexAdjoint

variable [Algebra ℚ R]

/-- **`(V^{(n)}_K)^† = V^{(-n)}_{-K}`** for the tower form: the DDF vertex operator carrying
momentum `n k_0` is adjoint to the one carrying `-n k_0`, with the Laurent index reflected.

This is the statement of the graph node `worldsheet.vertex-operator-adjoint`.  It combines two
independent halves: `towerPairing_towerShift_left` for the zero-mode factor `e^{i n k_0·x}`
(which is what turns `n` into `-n`), and `pairing_vertexOsc_left` for the oscillator factor
(which turns the vertex momentum `n b` into `-n b`, i.e. again `n ↦ -n`).  Only `hη` is
needed: neither `k_0² = 0` nor `2α' k_0·p = 1` enters. -/
theorem towerPairing_towerVertex_left (η b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (n K : ℤ)
    (v w : TowerFock D R) :
    towerPairing η (towerVertex η b n K v) w
      = towerPairing η v (towerVertex η b (-n) (-K) w) := by
  have hneg : vertexMomentum b (-n) = -vertexMomentum b n := by
    funext μ
    simp only [vertexMomentum_apply, Pi.neg_apply]
    push_cast
    ring
  have key : ((towerPairing η).flip w).comp (towerVertex η b n K)
      = (towerPairing η).flip (towerVertex η b (-n) (-K) w) := by
    refine Finsupp.lhom_ext fun i P => ?_
    simp only [LinearMap.comp_apply, LinearMap.flip_apply, towerVertex_single,
      towerPairing_single_left, towerVertex_apply, hneg]
    rw [show (-K : ℤ) - -n = -(K - n) from by ring, show i - (-n) = i + n from by ring]
    exact pairing_vertexOsc_left η (vertexMomentum b n) hη (K - n) P (w (i + n))
  exact LinearMap.congr_fun key v

/-- `⟨v, V^{(n)}_K w⟩ = ⟨V^{(-n)}_{-K} v, w⟩` on the tower. -/
theorem towerPairing_towerVertex_right (η b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (n K : ℤ)
    (v w : TowerFock D R) :
    towerPairing η v (towerVertex η b n K w)
      = towerPairing η (towerVertex η b (-n) (-K) v) w := by
  rw [towerPairing_towerVertex_left η b hη (-n) (-K), neg_neg, neg_neg]

/-! ### The adjoint of the DDF operators -/

omit [Algebra ℚ R] in
/-- `(α^ε_p)^† = α^ε_{-p}` for the polarised mode. -/
theorem towerPairing_towerModeVec_left (η a b ε : Fin D → R) (p : ℤ) (v w : TowerFock D R) :
    towerPairing η (towerModeVec η a b ε p v) w
      = towerPairing η v (towerModeVec η a b ε (-p) w) := by
  simp only [towerModeVec, LinearMap.sum_apply, map_sum, LinearMap.smul_apply, map_smul,
    smul_eq_mul]
  exact Finset.sum_congr rfl fun μ _ => by rw [towerPairing_towerMode_left η a b μ p]

/-- `(α^ε_j V^{(n)}_j)^† = α^ε_{-j} V^{(-n)}_{-j}`: the adjoint of a single DDF summand.
Transversality `ε·k_0 = 0` is used to put the adjoint back into the order "mode times vertex
operator" in which the DDF sum is written. -/
theorem towerPairing_ddfSummand_left (η a b ε : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hεb : dotVec η ε b = 0) (n j : ℤ) (v w : TowerFock D R) :
    towerPairing η (ddfSummand η a b ε n j v) w
      = towerPairing η v (ddfSummand η a b ε (-n) (-j) w) := by
  simp only [ddfSummand, Module.End.mul_apply]
  rw [towerPairing_towerModeVec_left, towerPairing_towerVertex_left η b hη]
  congr 1
  have hcomm := LinearMap.congr_fun
    (towerModeVec_mul_towerVertex_of_transverse η a b ε hη hεb (-n) (-j) (-j)) w
  simpa only [Module.End.mul_apply] using hcomm.symm

/-- **`(A^ε_n)^† = A^ε_{-n}`**: the transverse DDF operators are adjoint in pairs for the
tower form.  Graph node `worldsheet.ddf-operators-adjoint`.

Hypotheses: only `hη` (the metric squares to one, as everywhere in this development) and the
DDF transversality `ε·k_0 = 0`, which is already an argument of `ddfOp`.  In particular
neither `k_0² = 0` nor the normalisation `2α' k_0·p = 1` is needed — those are what make
`A^ε_n` commute with the Virasoro generators, not what makes it have an adjoint. -/
theorem towerPairing_ddfOp_left (η a b ε : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hεb : dotVec η ε b = 0) (n : ℤ) (v w : TowerFock D R) :
    towerPairing η (ddfOp η a b ε hη hεb n v) w
      = towerPairing η v (ddfOp η a b ε hη hεb (-n) w) := by
  classical
  set s : Finset ℤ := ddfWindow n v ∪ (ddfWindow (-n) w).image (fun j => -j) with hsdef
  have hsv : ∀ j ∉ s, ddfSummand η a b ε n j v = 0 := fun j hj =>
    ddfSummand_apply_eq_zero_of_notMem_window η a b ε hη hεb n v j
      (fun hc => hj (Finset.mem_union_left _ hc))
  have hsw : ∀ j ∉ s.image (fun i => -i), ddfSummand η a b ε (-n) j w = 0 := by
    intro j hj
    refine ddfSummand_apply_eq_zero_of_notMem_window η a b ε hη hεb (-n) w j fun hc => hj ?_
    refine Finset.mem_image.mpr ⟨-j, ?_, neg_neg j⟩
    exact Finset.mem_union_right _ (Finset.mem_image.mpr ⟨j, hc, rfl⟩)
  rw [ddfOp_apply η a b ε hη hεb n v hsv, ddfOp_apply η a b ε hη hεb (-n) w hsw,
    map_sum, LinearMap.sum_apply, map_sum, Finset.sum_image (fun x _ y _ h => by omega)]
  exact Finset.sum_congr rfl fun j _ =>
    towerPairing_ddfSummand_left η a b ε hη hεb n j v w

/-- `⟨v, A^ε_n w⟩ = ⟨A^ε_{-n} v, w⟩`. -/
theorem towerPairing_ddfOp_right (η a b ε : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hεb : dotVec η ε b = 0) (n : ℤ) (v w : TowerFock D R) :
    towerPairing η v (ddfOp η a b ε hη hεb n w)
      = towerPairing η (ddfOp η a b ε hη hεb (-n) v) w := by
  rw [towerPairing_ddfOp_left η a b ε hη hεb (-n), neg_neg]

end TowerVertexAdjoint

end Fock

end StringFormal.NoGhost
