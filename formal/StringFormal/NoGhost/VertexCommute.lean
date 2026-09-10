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

## Main statements

* `Fock.vertexSub_creaExp_of_dotVec_zero` — **no contraction**: the translation `E_+(b)`
  fixes the coherent-state coefficients `Φ^{b'}_j` when `b·b' = 0`.  Coefficient form of
  `E_+(b,z) E_-(b',w) = exp((b·b') Σ_{l ≥ 1} (w/z)^l / l) E_-(b',w) E_+(b,z)` with the
  scalar factor equal to `1`.  Proved from the Euler recursion `Fock.creaExp_euler`; no
  exponential identity, no convergence.
* `Fock.vertexAnn_creaExp_mul_of_dotVec_zero`, `Fock.vertexAnn_creaExp_of_dotVec_zero` —
  operator form of the same fact: `E_+(b)_L` commutes with multiplication by `Φ^{b'}_j`.
* `Fock.vertexOsc_apply_creaExp_of_dotVec_zero` — the vacuum value
  `V^{(b)}_J Φ^{b'}_K = Φ^b_J Φ^{b'}_K`, manifestly symmetric in `(b, J)` and `(b', K)`.
* `Fock.eq_zero_of_vertex_recursion₂` — two-index rigidity, the inductive step.
* **`Fock.vertexOsc_comm_of_dotVec_zero`**, `Fock.lie_vertexOsc_vertexOsc_of_dotVec_zero` —
  `b·b' = 0` ⟹ `V^{(b)}_J V^{(b')}_K = V^{(b')}_K V^{(b)}_J`, with no `z ≠ w` prescription
  and no monodromy factor.
* **`towerVertex_comm_of_isotropic`**, `lie_towerVertex_towerVertex_of_isotropic` — on the
  DDF momentum tower, `k_0² = 0` ⟹ `V^{(m)}_J` and `V^{(n)}_K` commute.

## Mathematical remarks (for the dependency graph)

1. **`k_0² = 0` is essential**, not a convenience: for `k_0² ≠ 0` the contraction produces
   the monodromy factor `(w/z)^{mn k_0²} ≠ 1` and the tower vertex operators do *not*
   commute.  This is the second place (after the tower conformal weight,
   `lie_towerLop_towerVertex_of_pos`) where light-likeness of the reference vector does real
   work.
2. **What is still missing for `[A^ε_m, A^δ_n]`.**  Two further steps, neither of which is
   in this file:
   (a) the *same-point product* `Σ_{J+K=L} V^{(b)}_J V^{(b')}_K = V^{(b+b')}_L` — needs the
   addition formula `Φ^{b+b'}_M = Σ_{j+k=M} Φ^b_j Φ^{b'}_k` (true for *all* momenta, it is
   `E_-(b)E_-(b') = E_-(b+b')`), plus local finiteness of the `K`-sum, for which the naive
   level count is *not* enough: one must first pull `Φ^{b'}` out to the left using
   `Fock.vertexOsc_creaExp_mul_of_dotVec_zero`;
   (b) the *weighted* sum `Σ_j j V^{(m)}_j V^{(n)}_{-j} = m δ_{m+n,0}`, whose `δ_{m+n,0}`
   is a total-derivative (residue) statement and whose `m` is where the DDF normalisation
   `2α' k_0·p = 1` first enters.
3. **`hη : η^{μμ} η_{μμ} = 1` is not needed here.**  Unlike the mode algebra of
   `StringFormal/NoGhost/VertexOperator.lean`, nothing in this file contracts a spacetime
   index against the metric twice, so no hypothesis on `η` appears.

## Status

Complete as far as it goes, no `sorry`; axioms are `propext`, `Classical.choice`,
`Quot.sound` only.
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

/-- **The vertex operator acts on the coherent state of an orthogonal momentum by plain
multiplication**: `V^{(b)}_J Φ^{b'}_K = Φ^b_J Φ^{b'}_K`.  Equivalently, on the vacuum,
`V^{(b)}_J V^{(b')}_K |0⟩ = Φ^b_J Φ^{b'}_K`, which is visibly symmetric in `(b, J)` and
`(b', K)`; this is the base case of the commutation theorem below. -/
theorem vertexOsc_apply_creaExp_of_dotVec_zero (η b b' : Fin D → R)
    (hdot : dotVec η b' b = 0) (J K : ℤ) :
    vertexOsc η b J (creaExp η b' K) = creaExp η b J * creaExp η b' K := by
  classical
  rw [vertexOsc_apply η b J (creaExp η b' K) (s := {0}) (fun L hL => by
      rw [vertexAnn_creaExp_of_dotVec_zero η b b' hdot K L, if_neg (by simpa using hL)]),
    Finset.sum_singleton, vertexAnn_creaExp_of_dotVec_zero η b b' hdot K 0, if_pos rfl,
    add_zero]

/-- `V^{(b)}_J` commutes with multiplication by the coherent-state coefficient `Φ^{b'}_c` of
an orthogonal momentum.  (For `P = 1` this specialises to
`vertexOsc_apply_creaExp_of_dotVec_zero`.)  This is the form in which the no-contraction
lemma will be used to bound the support of the same-point product
`Σ_{J+K=L} V^{(b)}_J V^{(b')}_K`. -/
theorem vertexOsc_creaExp_mul_of_dotVec_zero (η b b' : Fin D → R) (hdot : dotVec η b' b = 0)
    (c J : ℤ) (P : Fock D R) :
    vertexOsc η b J (creaExp η b' c * P) = creaExp η b' c * vertexOsc η b J P := by
  classical
  rw [vertexOsc_apply η b J (creaExp η b' c * P) (s := vertexIdx b P) (fun L hL => by
        rw [vertexAnn_creaExp_mul_of_dotVec_zero η b b' hdot c L P,
          vertexAnn_apply_eq_zero_of_notMem_vertexIdx b P hL, mul_zero]),
    vertexOsc_apply η b J P (fun L hL => vertexAnn_apply_eq_zero_of_notMem_vertexIdx b P hL),
    Finset.mul_sum]
  exact Finset.sum_congr rfl fun L _ => by
    rw [vertexAnn_creaExp_mul_of_dotVec_zero η b b' hdot c L P]
    ring

omit [Algebra ℚ R] in
/-- **Two-index form of `Fock.eq_zero_of_vertex_recursion`.**  A doubly indexed family of
endomorphisms obeying the creation-mode recursion of a *product* of two vertex operators
(with momenta `b` and `b'`, each shifting its own Laurent index) and killing the vacuum is
identically zero.  As in the one-index case the proof is a plain induction over monomials;
this is the inductive step that reduces the commutation theorem to the vacuum. -/
theorem eq_zero_of_vertex_recursion₂ (b b' : Fin D → R)
    (W : ℤ → ℤ → Module.End R (Fock D R))
    (hrec : ∀ (v : Osc D) (J K : ℤ) (P : Fock D R),
      W J K (X v * P) = X v * W J K P - b v.1 • W (J + (((v.2 : ℕ)) : ℤ)) K P
        - b' v.1 • W J (K + (((v.2 : ℕ)) : ℤ)) P)
    (hvac : ∀ J K : ℤ, W J K (1 : Fock D R) = 0) (J K : ℤ) : W J K = 0 := by
  have key : ∀ (P : Fock D R) (J K : ℤ), W J K P = 0 := by
    intro P
    induction P using MvPolynomial.induction_on with
    | C a =>
        intro J K
        rw [show (C a : Fock D R) = a • 1 by rw [MvPolynomial.smul_eq_C_mul, mul_one],
          map_smul, hvac, smul_zero]
    | add p q hp hq =>
        intro J K
        rw [map_add, hp, hq, add_zero]
    | mul_X p v hp =>
        intro J K
        rw [mul_comm, hrec, hp, hp, hp, mul_zero, smul_zero, smul_zero, sub_zero, sub_zero]
  exact LinearMap.ext fun P => by rw [key P J K, LinearMap.zero_apply]

/-- **Vertex operators with orthogonal momenta commute.**  If `b·b' = 0` then every Laurent
coefficient of `:e^{i c·X(z)}:` commutes with every Laurent coefficient of `:e^{i c'·X(w)}:`,
with *no* `z ≠ w` prescription and no scalar (monodromy) factor: the only obstruction to
reordering `E_+(b)` past `E_-(b')` is the contraction `Σ_{l ≥ 1} (b·b') (w/z)^l / l`, which
vanishes identically.

Proof: both sides obey the same two-index creation-mode recursion (from
`Fock.vertexOsc_X_mul` for each factor), so by `eq_zero_of_vertex_recursion₂` the difference
is determined by its value on the vacuum, where it is
`Φ^b_J Φ^{b'}_K - Φ^{b'}_K Φ^b_J = 0` (`vertexOsc_apply_creaExp_of_dotVec_zero`). -/
theorem vertexOsc_comm_of_dotVec_zero (η b b' : Fin D → R) (hdot : dotVec η b b' = 0)
    (J K : ℤ) (P : Fock D R) :
    vertexOsc η b J (vertexOsc η b' K P) = vertexOsc η b' K (vertexOsc η b J P) := by
  have hdot' : dotVec η b' b = 0 := by rw [dotVec_comm]; exact hdot
  have hrec : ∀ (v : Osc D) (J K : ℤ) (Q : Fock D R),
      (vertexOsc η b J * vertexOsc η b' K - vertexOsc η b' K * vertexOsc η b J) (X v * Q)
        = X v * (vertexOsc η b J * vertexOsc η b' K
              - vertexOsc η b' K * vertexOsc η b J) Q
          - b v.1 • (vertexOsc η b (J + (((v.2 : ℕ)) : ℤ)) * vertexOsc η b' K
              - vertexOsc η b' K * vertexOsc η b (J + (((v.2 : ℕ)) : ℤ))) Q
          - b' v.1 • (vertexOsc η b J * vertexOsc η b' (K + (((v.2 : ℕ)) : ℤ))
              - vertexOsc η b' (K + (((v.2 : ℕ)) : ℤ)) * vertexOsc η b J) Q := by
    intro v J K Q
    simp only [LinearMap.sub_apply, Module.End.mul_apply,
      vertexOsc_X_mul η b' v K Q, vertexOsc_X_mul η b v J Q, map_sub, map_smul,
      vertexOsc_X_mul η b v J (vertexOsc η b' K Q),
      vertexOsc_X_mul η b' v K (vertexOsc η b J Q), mul_sub, smul_sub]
    abel
  have hvac : ∀ J K : ℤ,
      (vertexOsc η b J * vertexOsc η b' K - vertexOsc η b' K * vertexOsc η b J)
        (1 : Fock D R) = 0 := by
    intro J K
    simp only [LinearMap.sub_apply, Module.End.mul_apply, vertexOsc_apply_one]
    rw [vertexOsc_apply_creaExp_of_dotVec_zero η b b' hdot' J K,
      vertexOsc_apply_creaExp_of_dotVec_zero η b' b hdot K J, mul_comm, sub_self]
  have h := eq_zero_of_vertex_recursion₂ b b'
    (fun J K => vertexOsc η b J * vertexOsc η b' K - vertexOsc η b' K * vertexOsc η b J)
    hrec hvac J K
  have h' := congrArg (fun T : Module.End R (Fock D R) => T P) h
  simp only [LinearMap.sub_apply, Module.End.mul_apply, LinearMap.zero_apply] at h'
  exact sub_eq_zero.mp h'

/-- Operator form of `vertexOsc_comm_of_dotVec_zero`: the Lie bracket vanishes. -/
theorem lie_vertexOsc_vertexOsc_of_dotVec_zero (η b b' : Fin D → R)
    (hdot : dotVec η b b' = 0) (J K : ℤ) :
    ⁅vertexOsc η b J, vertexOsc η b' K⁆ = 0 := by
  refine LinearMap.ext fun P => ?_
  rw [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
    Module.End.mul_apply, vertexOsc_comm_of_dotVec_zero η b b' hdot J K P, sub_self,
    LinearMap.zero_apply]

end OrthogonalMomenta

/-! ### The addition formula for coherent-state coefficients

`E_-(b) E_-(b') = E_-(b+b')`.  This holds for *arbitrary* momenta — no orthogonality — and is
the vacuum input for the same-point product of two vertex operators. -/

section CreaExpAdd

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

/-- The convolution `Σ_{p+q=j} Φ^b_p Φ^{b'}_q` of two families of coherent-state
coefficients.  Only `0 ≤ p ≤ j` contributes, so the sum is finite and vanishes for `j < 0`. -/
noncomputable def creaExpPair (η b b' : Fin D → R) (j : ℤ) : Fock D R :=
  ∑ p ∈ Finset.Icc (0 : ℤ) j, creaExp η b p * creaExp η b' (j - p)

/-- Any window containing `[0, j]` computes the convolution. -/
lemma creaExpPair_eq_sum_Icc (η b b' : Fin D → R) {j u v : ℤ} (hu : u ≤ 0) (hv : j ≤ v) :
    ∑ p ∈ Finset.Icc u v, creaExp η b p * creaExp η b' (j - p) = creaExpPair η b b' j := by
  classical
  refine (Finset.sum_subset (Finset.Icc_subset_Icc hu hv) ?_).symm
  intro p _ hp'
  simp only [Finset.mem_Icc, not_and, not_le] at hp'
  rcases lt_or_ge p 0 with h | h
  · rw [creaExp_of_neg η b h, zero_mul]
  · rw [creaExp_of_neg η b' (by have := hp' h; omega : j - p < 0), mul_zero]

@[simp]
lemma creaExpPair_zero (η b b' : Fin D → R) : creaExpPair η b b' 0 = 1 := by
  rw [creaExpPair, show Finset.Icc (0 : ℤ) 0 = {0} from rfl, Finset.sum_singleton, sub_zero,
    creaExp_zero, creaExp_zero, mul_one]

lemma creaExpPair_of_neg (η b b' : Fin D → R) {j : ℤ} (hj : j < 0) :
    creaExpPair η b b' j = 0 := by
  rw [creaExpPair, Finset.Icc_eq_empty (by omega), Finset.sum_empty]

/-- **The convolution obeys the same Euler recursion as `Φ^{b+b'}`.**  Splitting the weight
`j = p + (j - p)` and applying `Fock.sum_mode_creaExp_eq_smul` to each factor produces the
creation modes of `b` on the left and of `b'` on the right; both reassemble into the
convolution at the shifted index, and the two coefficients add up to `b + b'`. -/
lemma sum_mode_creaExpPair_eq_smul (η a b b' : Fin D → R) {j N : ℤ} (hjN : j ≤ N) :
    ∑ l ∈ Finset.Ioc (0 : ℤ) N, ∑ μ : Fin D,
        (η μ * (b + b') μ) • mode η a μ (-l) (creaExpPair η b b' (j - l))
      = (j : R) • creaExpPair η b b' j := by
  classical
  have hmulL : ∀ (μ : Fin D) (l : ℤ), 0 < l → ∀ A B : Fock D R,
      mode η a μ (-l) A * B = mode η a μ (-l) (A * B) := by
    intro μ l hl A B
    rw [mode_of_neg η a (by omega : -l < 0), creation_apply, creation_apply, mul_assoc]
  have hmulR : ∀ (μ : Fin D) (l : ℤ), 0 < l → ∀ A B : Fock D R,
      A * mode η a μ (-l) B = mode η a μ (-l) (A * B) := by
    intro μ l hl A B
    rw [mode_of_neg η a (by omega : -l < 0), creation_apply, creation_apply, mul_left_comm]
  have hsplit : ∀ p ∈ Finset.Icc (0 : ℤ) j,
      (j : R) • (creaExp η b p * creaExp η b' (j - p))
        = (((p : ℤ) : R) • creaExp η b p) * creaExp η b' (j - p)
          + creaExp η b p * (((j - p : ℤ) : R) • creaExp η b' (j - p)) := by
    intro p _
    rw [smul_mul_assoc, mul_smul_comm, ← add_smul]
    congr 1
    push_cast
    ring
  have hE1 : ∀ p ∈ Finset.Icc (0 : ℤ) j,
      (((p : ℤ) : R) • creaExp η b p) * creaExp η b' (j - p)
        = ∑ l ∈ Finset.Ioc (0 : ℤ) N, ∑ μ : Fin D,
            (η μ * b μ) • mode η a μ (-l) (creaExp η b (p - l) * creaExp η b' (j - p)) := by
    intro p hp
    rw [Finset.mem_Icc] at hp
    rw [← sum_mode_creaExp_eq_smul η a b (K := p) (N := N) (by omega), Finset.sum_mul]
    refine Finset.sum_congr rfl fun l hl => ?_
    rw [Finset.mem_Ioc] at hl
    rw [Finset.sum_mul]
    exact Finset.sum_congr rfl fun μ _ => by rw [smul_mul_assoc, hmulL μ l hl.1]
  have hE2 : ∀ p ∈ Finset.Icc (0 : ℤ) j,
      creaExp η b p * (((j - p : ℤ) : R) • creaExp η b' (j - p))
        = ∑ l ∈ Finset.Ioc (0 : ℤ) N, ∑ μ : Fin D,
            (η μ * b' μ) • mode η a μ (-l) (creaExp η b p * creaExp η b' (j - p - l)) := by
    intro p hp
    rw [Finset.mem_Icc] at hp
    rw [← sum_mode_creaExp_eq_smul η a b' (K := j - p) (N := N) (by omega), Finset.mul_sum]
    refine Finset.sum_congr rfl fun l hl => ?_
    rw [Finset.mem_Ioc] at hl
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun μ _ => by rw [mul_smul_comm, hmulR μ l hl.1]
  have hcomb : ∀ p ∈ Finset.Icc (0 : ℤ) j,
      (j : R) • (creaExp η b p * creaExp η b' (j - p))
        = ∑ l ∈ Finset.Ioc (0 : ℤ) N, ∑ μ : Fin D,
            ((η μ * b μ) • mode η a μ (-l) (creaExp η b (p - l) * creaExp η b' (j - p))
              + (η μ * b' μ) • mode η a μ (-l)
                  (creaExp η b p * creaExp η b' (j - p - l))) := by
    intro p hp
    rw [hsplit p hp, hE1 p hp, hE2 p hp, ← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun l _ => Finset.sum_add_distrib.symm
  symm
  calc (j : R) • creaExpPair η b b' j
      = ∑ p ∈ Finset.Icc (0 : ℤ) j, (j : R) • (creaExp η b p * creaExp η b' (j - p)) := by
        rw [creaExpPair, Finset.smul_sum]
    _ = ∑ p ∈ Finset.Icc (0 : ℤ) j, ∑ l ∈ Finset.Ioc (0 : ℤ) N, ∑ μ : Fin D,
            ((η μ * b μ) • mode η a μ (-l) (creaExp η b (p - l) * creaExp η b' (j - p))
              + (η μ * b' μ) • mode η a μ (-l)
                  (creaExp η b p * creaExp η b' (j - p - l))) :=
        Finset.sum_congr rfl hcomb
    _ = ∑ l ∈ Finset.Ioc (0 : ℤ) N, ∑ p ∈ Finset.Icc (0 : ℤ) j, ∑ μ : Fin D,
            ((η μ * b μ) • mode η a μ (-l) (creaExp η b (p - l) * creaExp η b' (j - p))
              + (η μ * b' μ) • mode η a μ (-l)
                  (creaExp η b p * creaExp η b' (j - p - l))) := Finset.sum_comm
    _ = ∑ l ∈ Finset.Ioc (0 : ℤ) N, ∑ μ : Fin D,
            (η μ * (b + b') μ) • mode η a μ (-l) (creaExpPair η b b' (j - l)) := by
        refine Finset.sum_congr rfl fun l hl => ?_
        rw [Finset.mem_Ioc] at hl
        rw [Finset.sum_comm]
        refine Finset.sum_congr rfl fun μ _ => ?_
        have hre1 : ∑ p ∈ Finset.Icc (0 : ℤ) j, creaExp η b (p - l) * creaExp η b' (j - p)
            = creaExpPair η b b' (j - l) := by
          rw [← creaExpPair_eq_sum_Icc η b b' (u := -l) (v := j - l) (by omega) (le_refl _)]
          refine Finset.sum_equiv (Equiv.subRight l) (fun p => ?_) (fun p _ => ?_)
          · simp only [Equiv.subRight_apply, Finset.mem_Icc]
            omega
          · simp only [Equiv.subRight_apply]
            rw [show j - l - (p - l) = j - p from by ring]
        have hre2 : ∑ p ∈ Finset.Icc (0 : ℤ) j, creaExp η b p * creaExp η b' (j - p - l)
            = creaExpPair η b b' (j - l) := by
          rw [← creaExpPair_eq_sum_Icc η b b' (u := 0) (v := j) (le_refl _) (by omega)]
          exact Finset.sum_congr rfl fun p _ => by
            rw [show j - l - p = j - p - l from by ring]
        rw [Finset.sum_add_distrib, ← Finset.smul_sum, ← Finset.smul_sum, ← map_sum,
          ← map_sum, hre1, hre2, ← add_smul]
        congr 1
        simp only [Pi.add_apply]
        ring

/-- **The addition formula for coherent-state coefficients**, `E_-(b) E_-(b') = E_-(b+b')`:
`Φ^{b+b'}_j = Σ_{p+q=j} Φ^b_p Φ^{b'}_q`.  No hypothesis on the momenta is needed — the
creation halves of two vertex operators always commute and multiply by adding momenta; it is
only the *annihilation* half that produces a contraction.

The proof is uniqueness for the Euler recursion: `sum_mode_creaExpPair_eq_smul` and
`Fock.sum_mode_creaExp_eq_smul` are the same recursion for the momentum `b + b'`, the two
sides agree at `j = 0`, and in a `ℚ`-algebra the scalar `j ≠ 0` can be cancelled. -/
theorem creaExpPair_eq_creaExp_add (η b b' : Fin D → R) (j : ℤ) :
    creaExpPair η b b' j = creaExp η (b + b') j := by
  suffices h : ∀ M : ℕ, ∀ i : ℤ, i ≤ (M : ℤ) → creaExpPair η b b' i = creaExp η (b + b') i by
    rcases lt_or_ge j 0 with hj | hj
    · rw [creaExpPair_of_neg η b b' hj, creaExp_of_neg η (b + b') hj]
    · exact h j.toNat j (by omega)
  intro M
  induction M with
  | zero =>
      intro i hi
      rcases lt_or_ge i 0 with hneg | hnn
      · rw [creaExpPair_of_neg η b b' hneg, creaExp_of_neg η (b + b') hneg]
      · have hi0 : i = 0 := by omega
        subst hi0
        rw [creaExpPair_zero, creaExp_zero]
  | succ M ih =>
      intro i hi
      rcases le_or_gt i (M : ℤ) with hle | hgt
      · exact ih i hle
      · have hkey : (i : R) • creaExpPair η b b' i = (i : R) • creaExp η (b + b') i := by
          rw [← sum_mode_creaExpPair_eq_smul η b b b' (j := i) (N := i) (le_refl _),
            ← sum_mode_creaExp_eq_smul η b (b + b') (K := i) (N := i) (le_refl _)]
          refine Finset.sum_congr rfl fun l hl => ?_
          rw [Finset.mem_Ioc] at hl
          exact Finset.sum_congr rfl fun μ _ => by rw [ih (i - l) (by omega)]
        have hipos : (0 : ℤ) < i := by omega
        obtain ⟨n, hn⟩ : ∃ n : ℕ, i = ((n + 1 : ℕ) : ℤ) :=
          ⟨i.toNat - 1, by omega⟩
        subst hn
        rw [show ((((n + 1 : ℕ) : ℤ)) : R) = ((n + 1 : ℕ) : R) from by push_cast; ring]
          at hkey
        exact natCast_smul_left_cancel (Nat.succ_ne_zero n) hkey

end CreaExpAdd

end Fock

/-! ### The vertex operators of a light-like tower commute -/

section TowerCommute

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

omit [Algebra ℚ R] in
/-- The momenta of the DDF tower are all proportional to the reference vector, so their
contractions are `(m n) k_0²`. -/
lemma dotVec_vertexMomentum (η b : Fin D → R) (m n : ℤ) :
    dotVec η (vertexMomentum b m) (vertexMomentum b n)
      = ((m : R) * (n : R)) * dotVec η b b := by
  rw [dotVec, dotVec, Finset.mul_sum]
  exact Finset.sum_congr rfl fun μ _ => by simp only [vertexMomentum_apply]; ring

/-- **The vertex operators of a light-like DDF tower commute.**  For `k_0² = 0` the momenta
`n k_0` of the tower vertex operators are pairwise orthogonal (`(m k_0)·(n k_0) = mn k_0²`),
so the oscillator parts commute by `Fock.vertexOsc_comm_of_dotVec_zero`, while the zero-mode
factors `e^{i m k_0·x}`, `e^{i n k_0·x}` are rung shifts and commute trivially.

This is the operator input for the second step of the DDF transverse algebra: in
`[A^ε_m, A^δ_n]` the whole bracket comes from the transverse oscillators `α^ε_j`, never from
the exponentials — provided the reference vector is light-like.  For `k_0² ≠ 0` the statement
is false already for the oscillator parts (the contraction produces the monodromy factor
`(w/z)^{mn k_0²}`, which is not `1`). -/
theorem towerVertex_comm_of_isotropic (η b : Fin D → R) (hbb : dotVec η b b = 0)
    (m n J K : ℤ) :
    towerVertex η b m J * towerVertex η b n K = towerVertex η b n K * towerVertex η b m J := by
  have hdot : dotVec η (vertexMomentum b m) (vertexMomentum b n) = 0 := by
    rw [dotVec_vertexMomentum, hbb, mul_zero]
  refine Finsupp.lhom_ext fun j P => ?_
  rw [Module.End.mul_apply, Module.End.mul_apply, towerVertex_single, towerVertex_single,
    towerVertex_single, towerVertex_single,
    Fock.vertexOsc_comm_of_dotVec_zero η (vertexMomentum b m) (vertexMomentum b n) hdot
      (J - m) (K - n) P,
    show j + n + m = j + m + n from by ring]

/-- Lie-bracket form of `towerVertex_comm_of_isotropic`. -/
theorem lie_towerVertex_towerVertex_of_isotropic (η b : Fin D → R) (hbb : dotVec η b b = 0)
    (m n J K : ℤ) : ⁅towerVertex η b m J, towerVertex η b n K⁆ = 0 := by
  rw [LieRing.of_associative_ring_bracket, towerVertex_comm_of_isotropic η b hbb m n J K,
    sub_self]

end TowerCommute

end StringFormal.NoGhost
