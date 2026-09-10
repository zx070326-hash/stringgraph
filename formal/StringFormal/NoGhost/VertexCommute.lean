/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.VertexWeight

/-!
# Vertex operators with orthogonal momenta commute

Graph node: `worldsheet.ddf-transverse-oscillator-algebra`; `formal/TODO.md` item
`ddf-operators`, sub-item (5).  This is the **first step** towards the DDF transverse
oscillator algebra `[A^ε_m, A^δ_n] = m (ε·δ) δ_{m+n,0}`: before one can compute the bracket
of two DDF operators one needs to know that the two vertex operators
`V^{(m)}(z) = :e^{i m k_0·X}:` and `V^{(n)}(w) = :e^{i n k_0·X}:` entering them commute,
which for a light-like reference vector (`k_0² = 0`) they do, *without* any `z ≠ w`
prescription and without normal-ordering corrections.

## Conventions

`conv.metric-mostly-plus`, `conv.alpha-prime-regge`, as in `StringFormal/NoGhost/DDF.lean`;
`b^μ = (2α')^{1/2} c^μ` is the rescaled vertex momentum of
`StringFormal/NoGhost/VertexOperator.lean`, and `dotVec η x y = Σ_μ η_μ x^μ y^μ` is the
spacetime contraction of `StringFormal/NoGhost/DDF.lean`.

## Status

Skeleton: contents are added one declaration per commit.  No `sorry` at any point.
-/

namespace StringFormal.NoGhost

open MvPolynomial

namespace Fock

section OrthogonalMomenta

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

/-- Cancelling a nonzero natural scalar in a module over a `ℚ`-algebra. -/
private lemma natCast_smul_left_cancel {A : Type*} [AddCommMonoid A] [Module R A] {n : ℕ}
    (hn : n ≠ 0) {x y : A} (h : (n : R) • x = (n : R) • y) : x = y := by
  have h1 : (invNat R n * (n : R)) • x = (invNat R n * (n : R)) • y := by
    rw [← smul_smul, ← smul_smul, h]
  rwa [mul_comm, natCast_mul_invNat hn, one_smul, one_smul] at h1

omit [Algebra ℚ R] in
/-- One `μ`-sum of the Euler recursion, pushed through the translation `E_+(b)`.  The
substitution `X_{μ,l} ↦ X_{μ,l} - b^μ T^l` changes `Σ_μ η_μ b'^μ α^μ_{-l} Q` by the
*contraction* `-(b'·b) T^l Q`; for orthogonal momenta that correction vanishes, and this is
the only place in this file where `b'·b = 0` is used. -/
private lemma vertexSub_sum_creation_mul (η b b' : Fin D → R) (hdot : dotVec η b' b = 0)
    (n : ℕ+) (Q : Fock D R) :
    ∑ μ : Fin D, (η μ * b' μ) • (vertexSub b (X ((μ, n) : Osc D)) * Polynomial.C Q)
      = Polynomial.C (∑ μ : Fin D, (η μ * b' μ) • (X ((μ, n) : Osc D) * Q)) := by
  have hsm : ∀ (r : R) (Z : Polynomial (Fock D R)),
      r • Z = Polynomial.C (C r : Fock D R) * Z := by
    intro r Z
    rw [Algebra.smul_def, Polynomial.algebraMap_apply, MvPolynomial.algebraMap_eq]
  have hterm : ∀ μ : Fin D,
      (η μ * b' μ) • (vertexSub b (X ((μ, n) : Osc D)) * Polynomial.C Q)
        = Polynomial.C ((η μ * b' μ) • (X ((μ, n) : Osc D) * Q))
          - Polynomial.C ((η μ * b' μ * b μ) • Q) * Polynomial.X ^ ((n : ℕ)) := by
    intro μ
    simp only [vertexSub_X, hsm, MvPolynomial.smul_eq_C_mul, map_mul]
    ring
  have hdot' : (∑ μ : Fin D, η μ * b' μ * b μ) = 0 := hdot
  rw [Finset.sum_congr rfl fun μ _ => hterm μ, Finset.sum_sub_distrib, ← Finset.sum_mul,
    ← map_sum, ← map_sum, ← Finset.sum_smul, hdot', zero_smul, map_zero, zero_mul, sub_zero]

/-- **No contraction between orthogonal momenta.**  The annihilation half `E_+(b)` of one
vertex operator passes through the creation half `E_-(b')` of another one unchanged as soon
as `b·b' = 0`: the translation `X_{μ,l} ↦ X_{μ,l} - b^μ T^l` fixes the coherent-state
coefficients `Φ^{b'}_j`, i.e. `vertexSub b (Φ^{b'}_j)` is `T`-independent.

This is the coefficient form of the classical contraction formula
`E_+(b, z) E_-(b', w) = exp((b·b') Σ_{l ≥ 1} (w/z)^l / l) E_-(b', w) E_+(b, z)`: here the
scalar factor is `1`.  The proof is the Euler recursion `Fock.creaExp_euler` for `Φ^{b'}`
together with `vertexSub_sum_creation_mul`; no exponential identity is needed. -/
theorem vertexSub_creaExp_of_dotVec_zero (η b b' : Fin D → R) (hdot : dotVec η b' b = 0)
    (j : ℤ) : vertexSub b (creaExp η b' j) = Polynomial.C (creaExp η b' j) := by
  suffices h : ∀ M : ℕ, ∀ i : ℤ, i ≤ (M : ℤ) →
      vertexSub b (creaExp η b' i) = Polynomial.C (creaExp η b' i) by
    rcases lt_or_ge j 0 with hj | hj
    · rw [creaExp_of_neg η b' hj, map_zero, map_zero]
    · exact h j.toNat j (by omega)
  intro M
  induction M with
  | zero =>
      intro i hi
      rcases lt_or_ge i 0 with hneg | hnn
      · rw [creaExp_of_neg η b' hneg, map_zero, map_zero]
      · have hi0 : i = 0 := by omega
        subst hi0
        rw [creaExp_zero, map_one, map_one]
  | succ M ih =>
      intro i hi
      rcases le_or_gt i (M : ℤ) with hle | hgt
      · exact ih i hle
      · have hiM : i = ((M + 1 : ℕ) : ℤ) := by omega
        subst hiM
        have heuler := creaExp_euler η b' (M + 1)
        have key : vertexSub b (((M + 1 : ℕ) : R) • creaExp η b' ((M + 1 : ℕ) : ℤ))
            = Polynomial.C (((M + 1 : ℕ) : R) • creaExp η b' ((M + 1 : ℕ) : ℤ)) := by
          conv_lhs => rw [heuler]
          conv_rhs => rw [heuler]
          rw [map_sum, map_sum]
          refine Finset.sum_congr rfl fun l _ => ?_
          rw [map_sum]
          have hterm : ∀ μ : Fin D,
              vertexSub b ((η μ * b' μ) • creation R μ l.succPNat
                  (creaExp η b' (((M + 1 : ℕ) : ℤ) - ((l : ℤ) + 1))))
                = (η μ * b' μ) • (vertexSub b (X ((μ, l.succPNat) : Osc D)) *
                    Polynomial.C (creaExp η b' (((M + 1 : ℕ) : ℤ) - ((l : ℤ) + 1)))) := by
            intro μ
            rw [map_smul, creation_apply, map_mul,
              ih (((M + 1 : ℕ) : ℤ) - ((l : ℤ) + 1)) (by omega)]
          rw [Finset.sum_congr rfl fun μ _ => hterm μ,
            vertexSub_sum_creation_mul η b b' hdot l.succPNat _]
          exact congrArg Polynomial.C
            (Finset.sum_congr rfl fun μ _ => by rw [creation_apply])
        rw [map_smul, ← Polynomial.smul_C] at key
        exact natCast_smul_left_cancel (Nat.succ_ne_zero M) key

/-- **`E_+(b)` and `E_-(b')` commute for orthogonal momenta.**  In the present realisation
`E_-(b')` is *multiplication* by the coherent-state coefficient `Φ^{b'}_j = creaExp η b' j`
and `E_+(b)` is the coefficient extraction `vertexAnn b L`, so the statement
`E_+(b)_L ∘ E_-(b')_j = E_-(b')_j ∘ E_+(b)_L` reads as follows.  It is the operator form of
`vertexSub_creaExp_of_dotVec_zero`: all the contractions `[α_l·b, α_{-l}·b'] = l (b·b')`
vanish. -/
theorem vertexAnn_creaExp_mul_of_dotVec_zero (η b b' : Fin D → R) (hdot : dotVec η b' b = 0)
    (j L : ℤ) (P : Fock D R) :
    vertexAnn b L (creaExp η b' j * P) = creaExp η b' j * vertexAnn b L P := by
  rcases lt_or_ge L 0 with hL | hL
  · rw [vertexAnn_of_neg b hL, LinearMap.zero_apply, LinearMap.zero_apply, mul_zero]
  · rw [vertexAnn_of_nonneg b hL, vertexAnn_of_nonneg b hL, map_mul,
      vertexSub_creaExp_of_dotVec_zero η b b' hdot j, Polynomial.coeff_C_mul]

/-- `E_+(b)` acting on the coherent state `Φ^{b'}_j` of an orthogonal momentum: only the
`z^0` coefficient survives, and it acts as the identity. -/
theorem vertexAnn_creaExp_of_dotVec_zero (η b b' : Fin D → R) (hdot : dotVec η b' b = 0)
    (j L : ℤ) :
    vertexAnn b L (creaExp η b' j) = if L = 0 then creaExp η b' j else 0 := by
  have h := vertexAnn_creaExp_mul_of_dotVec_zero η b b' hdot j L 1
  rw [mul_one, vertexAnn_one] at h
  rw [h]
  by_cases hL : L = 0
  · rw [if_pos hL, if_pos hL, mul_one]
  · rw [if_neg hL, if_neg hL, mul_zero]

end OrthogonalMomenta

end Fock

end StringFormal.NoGhost
