/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.VertexProduct
import StringFormal.NoGhost.DDFOperatorAll

/-!
# Step (5b) of the DDF transverse algebra: the index-weighted sum of vertex products

Graph node: `worldsheet.ddf-transverse-oscillator-algebra`; `formal/TODO.md` item
`ddf-operators`, sub-item (5b).

**`Σ_j j V^{(m)}_j V^{(n)}_{-j} = m δ_{m+n,0}`** on the DDF momentum tower of a light-like
reference vector (`k_0² = 0`) normalised by `2α' k_0·p = 1`
(`sum_weighted_towerVertex_towerVertex`).  Together with the transversality step (4) and the
same-point product (5a, `StringFormal/NoGhost/VertexProduct.lean`) this is the analytic heart
of the DDF bracket `[A^ε_m, A^δ_n] = m (ε·δ) δ_{m+n,0}`.

## Conventions

`conv.metric-mostly-plus`, `conv.alpha-prime-regge`, as in `StringFormal/NoGhost/DDF.lean`;
`dotVec η x y = Σ_μ η_μ x^μ y^μ` and `b^μ = (2α')^{1/2} k_0^μ`.

## The algebraic route (this file replaces the contour-integral argument)

The physics statement is a residue computation: `:(k_0·∂X) e^{i(m+n)k_0·X}:` is a total
derivative for `m + n ≠ 0` and degenerates to `k_0·∂X` for `m + n = 0`, whose residue is
`k_0·α_0 = 2α' k_0·p = 1`.  Purely algebraically the same content is:

1. **`Fock.vertexOsc_zero_momentum`** — `V^{(0)}_K = δ_{K,0}`: the zero-momentum vertex
   operator is the identity (this is the degeneration at `m + n = 0`).
2. **`Fock.dotMode`** — the contracted current `c·α_{-J} = Σ_μ η_μ c^μ α^μ_{-J}`, indexed so
   that it raises the oscillator level by `J`, matching the `Fock.vertexOsc` convention.
   For `c·b = 0` it **commutes** with `V^{(b)}_K` (`Fock.dotMode_vertexOsc_comm`).
3. **`Fock.vertexCurrent_eq`** — the **weight identity**
   `Σ_J (b·α_{-J}) V^{(b)}_{L-J} = (L + b·a) V^{(b)}_L` for `b·b = 0`.  This is the algebraic
   form of `z ∂_z :e^{i b·X}: = :(i b· z∂_z X) e^{i b·X}:` and is the missing atom of (5b).
   The proof is the rigidity argument: the two sides satisfy the *same* creation-mode
   recursion (`Fock.vertexCurrent_X_mul`, whose extra commutator term `k b^μ V_{L+k}` is
   exactly the derivative of the prefactor `L`) and agree on the vacuum, where the current
   sum is the Euler recursion `Fock.sum_mode_creaExp_eq_smul` for the coherent state.
4. **`towerCurrentVertex_eq`** — the tower form `m Σ_J (k_0·α_{-J}) V^{(m)}_{K-J} = K V^{(m)}_K`.
   The constant `b·a = m` of the single-Fock statement is precisely the rung shift already
   built into `towerVertex`, so on the tower the eigenvalue is just `K`.
5. **`sum_weighted_towerVertex_towerVertex`** — step (5b).  Expand `j V^{(m)}_j`, pull the
   current out of the `j`-sum (it commutes with both vertex operators), fuse the exponentials
   with (5a), and apply the weight identity a second time at momentum `m+n` and index `0`:
   `(m+n) Σ_J (k_0·α_{-J}) V^{(m+n)}_{-J} = 0 · V^{(m+n)}_0 = 0`.  Over a `ℚ`-algebra this
   kills the sum unless `m + n = 0`, and that is the total-derivative statement.

## Mathematical remarks (for the dependency graph)

1. **(5b) is not a corollary of (5a).**  The obvious attempt — apply `⁅L_0, V_K⁆ = K V_K` to
   the same-point product — gives `T_L + U_L = L S_L` with two unknowns, and degenerates to
   `0 = 0` at `L = 0`: `L_0` acts on a product by Leibniz and only sees the *sum* of the two
   weights, while (5b) puts the weight on one factor.  The current `k_0·∂X` must be
   introduced as a new object; that is what `Fock.dotMode` is for.  (Independently
   re-derived here; it confirms the note left in `formal/TODO.md`.)
2. **Where `k_0² = 0` is used in this file.**  Three times, all essential: the weight identity
   itself (`Fock.vertexCurrent_eq` assumes `b·b = 0`; otherwise the contraction of `b·∂X`
   with `e^{ib·X}` adds a `b²/z` term and the identity acquires an anomalous piece), the
   commutation of the current with the vertex operators, and — through the latter — the
   locally finite window of the current-vertex product.
3. **Where `2α' k_0·p = 1` is used.**  Only once, in `towerCurrent_zero_of_normalized`: it
   makes `k_0·α_0 = 1` on *every* rung of the tower, which is consistent precisely because
   `k_0² = 0` (`dotVec_towerMomentum_right_of_isotropic`).  This is the single place where
   the `m` on the right-hand side of `[A^ε_m, A^δ_n] = m (ε·δ) δ_{m+n,0}` comes from.
4. **`ℚ`-algebra is needed**, not just for the coherent-state coefficients, but for the final
   division by `m + n` (`eq_zero_of_intCast_smul_eq_zero`).  Over `ℤ` one gets only
   `(m+n) · Σ_j j V^{(m)}_j V^{(n)}_{-j} = 0`.

## Status

Complete as stated, no `sorry`; axioms are `propext`, `Classical.choice`, `Quot.sound` only.
Still missing for the full DDF bracket: the Leibniz assembly of
`[A^ε_m, A^δ_n] = Σ_{j,l} ⁅α^ε_j, α^δ_l⁆ V^{(m)}_j V^{(n)}_l` out of the doubly locally finite
sums (see `formal/TODO.md`).
-/

namespace StringFormal.NoGhost

open MvPolynomial

namespace Fock

/-! ### The zero-momentum vertex operator is the identity

`:e^{i·0·X(z)}: = 1`, so the only nonvanishing Laurent coefficient is `V^{(0)}_0 = 1`.
Algebraically this is immediate from the rigidity theorem `Fock.vertexOsc_unique`: the
constant family `J ↦ δ_{J,0}` satisfies the creation-mode recursion for `b = 0` (the
correction term carries the factor `b^μ = 0`) and takes the right values on the vacuum. -/

section ZeroMomentum

variable {D : ℕ} {R : Type*} [CommRing R]

/-- Every monomial weight of the zero-momentum coherent state vanishes except the constant
one: each generator contributes a factor `(η_μ · 0)^{d v} = 0`. -/
lemma expWeight_zero_momentum [Algebra ℚ R] (η : Fin D → R) {d : Osc D →₀ ℕ} (hd : d ≠ 0) :
    expWeight η (0 : Fin D → R) d = 0 := by
  classical
  obtain ⟨v, hv⟩ := Finsupp.support_nonempty_iff.mpr hd
  refine Finset.prod_eq_zero hv ?_
  have hdv : d v ≠ 0 := Finsupp.mem_support_iff.mp hv
  simp only [Pi.zero_apply, mul_zero, zero_pow hdv, zero_mul]

/-- The zero-momentum creation exponential is `1`: `E_-(0, z) = 1`. -/
theorem creaExp_zero_momentum [Algebra ℚ R] (η : Fin D → R) (j : ℤ) :
    creaExp η (0 : Fin D → R) j = if j = 0 then 1 else 0 := by
  classical
  rcases eq_or_ne j 0 with rfl | hj
  · rw [if_pos rfl, creaExp_zero]
  · rw [if_neg hj]
    refine MvPolynomial.ext _ _ fun d => ?_
    rw [coeff_creaExp, coeff_zero]
    rcases eq_or_ne ((level D d : ℤ)) j with hl | hl
    · rw [if_pos hl]
      refine expWeight_zero_momentum η fun hd => hj ?_
      rw [hd, level_zero] at hl
      omega
    · rw [if_neg hl]

/-- **The zero-momentum vertex operator is the identity.**  `V^{(0)}_K = δ_{K,0}`.

This is the algebraic form of "`:e^{i·0·X}: = 1`", and it is the degeneration used in step
(5b): for `m + n = 0` the fused exponential `V^{(m+n)}` disappears and only the current
`k_0·∂X` is left, whose residue is the zero mode `k_0·α_0 = 2α' k_0·p`. -/
theorem vertexOsc_zero_momentum [Algebra ℚ R] (η : Fin D → R) (K : ℤ) :
    vertexOsc η (0 : Fin D → R) K = if K = 0 then 1 else 0 := by
  classical
  refine (vertexOsc_unique η (0 : Fin D → R)
    (fun J => if J = 0 then 1 else 0) ?_ ?_ K).symm
  · intro v J P
    rw [Pi.zero_apply, zero_smul, sub_zero]
    rcases eq_or_ne J 0 with rfl | hJ
    · rw [if_pos rfl, Module.End.one_apply, Module.End.one_apply]
    · rw [if_neg hJ, LinearMap.zero_apply, LinearMap.zero_apply, mul_zero]
  · intro J
    rw [creaExp_zero_momentum]
    rcases eq_or_ne J 0 with rfl | hJ
    · rw [if_pos rfl, if_pos rfl, Module.End.one_apply]
    · rw [if_neg hJ, if_neg hJ, LinearMap.zero_apply]

end ZeroMomentum

/-! ### The contracted current mode `c·α_{-J}`

`dotMode η c a J = Σ_μ η_μ c^μ α^μ_{-J}` is the `z^J` Laurent coefficient of `c·(z∂_z X)(z)`
in the conventions of `Fock.mode` (level-raising index `J`, matching the `vertexOsc` index).
Two facts make it the right tool for step (5b):

* for `c·b = 0` it **commutes** with `V^{(b)}_K` for every `J` and `K`
  (`Fock.lie_dotMode_vertexOsc_of_dotVec_zero`); on the DDF tower `c = k_0`, `b = m k_0`
  and `k_0² = 0`, so this is the light-like assumption doing work again;
* its `J = 0` component is the scalar `c·a`, which under the DDF normalisation
  `2α' k_0·p = 1` is exactly `1`.
-/

section DotMode

variable {D : ℕ} {R : Type*} [CommRing R]

/-- `c·α_{-J} = Σ_μ η_μ c^μ α^μ_{-J}`, the `z^J` Laurent coefficient of the contracted
current, in the index convention of `Fock.vertexOsc` (raising the level by `J`). -/
noncomputable def dotMode (η c a : Fin D → R) (J : ℤ) : Module.End R (Fock D R) :=
  ∑ μ : Fin D, (η μ * c μ) • mode η a μ (-J)

lemma dotMode_apply (η c a : Fin D → R) (J : ℤ) (P : Fock D R) :
    dotMode η c a J P = ∑ μ : Fin D, (η μ * c μ) • mode η a μ (-J) P := by
  rw [dotMode, LinearMap.sum_apply]
  exact Finset.sum_congr rfl fun μ _ => LinearMap.smul_apply _ _ _

/-- The current is linear in the contraction vector; on the DDF tower the vertex momentum is
`m k_0`, so the current contracted with it is `m` times the one contracted with `k_0`. -/
lemma dotMode_vertexMomentum (η b a : Fin D → R) (m J : ℤ) :
    dotMode η (vertexMomentum b m) a J = (m : R) • dotMode η b a J := by
  rw [dotMode, dotMode, Finset.smul_sum]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [smul_smul, vertexMomentum_apply]
  congr 1
  ring

/-- The zero mode of the current is the scalar `c·a`. -/
@[simp]
lemma dotMode_zero (η c a : Fin D → R) :
    dotMode η c a 0 = dotVec η c a • (LinearMap.id : Module.End R (Fock D R)) := by
  rw [dotMode, neg_zero, dotVec, Finset.sum_smul]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [mode_zero, smul_smul, mul_assoc]

/-- Annihilation cut-off: `c·α_{-J}` kills `P` as soon as `-J` exceeds the mode bound. -/
lemma dotMode_apply_eq_zero_of_modeBound_lt (η c a : Fin D → R) {P : Fock D R} {J : ℤ}
    (h : (modeBound P : ℤ) < -J) : dotMode η c a J P = 0 := by
  rw [dotMode_apply]
  exact Finset.sum_eq_zero fun μ _ => by
    rw [mode_apply_eq_zero_of_modeBound_lt η a μ h, smul_zero]

/-- **The current commutes with the vertex operator when `c·b = 0`.**  For `J ≠ 0` this is
`Fock.lie_mode_vertexOsc` contracted with `c`, giving `(c·b) V^{(b)}_{K+J} = 0`; for `J = 0`
the current is a scalar.  On the DDF tower `c = k_0` and `b = m k_0`, so the hypothesis is
`k_0² = 0`. -/
theorem dotMode_vertexOsc_comm [Algebra ℚ R] (η c a b : Fin D → R)
    (hη : ∀ μ, η μ * η μ = 1) (hcb : dotVec η c b = 0) (J K : ℤ) (P : Fock D R) :
    dotMode η c a J (vertexOsc η b K P) = vertexOsc η b K (dotMode η c a J P) := by
  rcases eq_or_ne J 0 with rfl | hJ
  · rw [dotMode_zero, LinearMap.smul_apply, LinearMap.id_coe, id_eq, LinearMap.smul_apply,
      LinearMap.id_coe, id_eq, map_smul]
  · rw [dotMode_apply, dotMode_apply, map_sum]
    have hterm : ∀ μ : Fin D, (η μ * c μ) • mode η a μ (-J) (vertexOsc η b K P)
        = vertexOsc η b K ((η μ * c μ) • mode η a μ (-J) P)
          + (η μ * c μ * b μ) • vertexOsc η b (K + J) P := by
      intro μ
      have h := congrArg (fun T : Module.End R (Fock D R) => T P)
        (lie_mode_vertexOsc η a b hη μ (by omega : -J ≠ 0) K)
      simp only [LieRing.of_associative_ring_bracket, LinearMap.sub_apply,
        Module.End.mul_apply, LinearMap.smul_apply, show K - -J = K + J from by ring] at h
      rw [sub_eq_iff_eq_add.mp h, smul_add, smul_smul, map_smul]
      exact add_comm _ _
    rw [Finset.sum_congr rfl fun μ _ => hterm μ, Finset.sum_add_distrib, ← Finset.sum_smul]
    have hd : ∑ μ : Fin D, η μ * c μ * b μ = dotVec η c b := rfl
    rw [hd, hcb, zero_smul, add_zero]

/-- The bracket form of `Fock.dotMode_vertexOsc_comm`. -/
theorem lie_dotMode_vertexOsc_of_dotVec_zero [Algebra ℚ R] (η c a b : Fin D → R)
    (hη : ∀ μ, η μ * η μ = 1) (hcb : dotVec η c b = 0) (J K : ℤ) :
    ⁅dotMode η c a J, vertexOsc η b K⁆ = 0 := by
  refine LinearMap.ext fun P => ?_
  rw [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
    Module.End.mul_apply, dotMode_vertexOsc_comm η c a b hη hcb J K P, sub_self,
    LinearMap.zero_apply]

/-- **Moving a creation generator past the current.**  `[c·α_{-J}, α^μ_{-k}] = k c^μ δ_{J,-k}`
by the canonical commutation relations; the Kronecker delta is what makes the weighted sum
work: exactly one index `J` of the current sum feels a given creation operator. -/
lemma dotMode_X_mul (η c a : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (v : Osc D) (J : ℤ)
    (Y : Fock D R) :
    dotMode η c a J (X v * Y)
      = X v * dotMode η c a J Y
        + (if J = -((v.2 : ℕ) : ℤ) then ((v.2 : ℕ) : R) * c v.1 else 0) • Y := by
  classical
  obtain ⟨μ, k⟩ := v
  have hX : ∀ Z : Fock D R, X ((μ, k) : Osc D) * Z = mode η a μ (-((k : ℕ) : ℤ)) Z := by
    intro Z
    rw [mode_neg_pnat, creation_apply]
  rw [hX, hX, dotMode_apply, dotMode_apply, map_sum]
  have hterm : ∀ ν : Fin D,
      (η ν * c ν) • mode η a ν (-J) (mode η a μ (-((k : ℕ) : ℤ)) Y)
        = mode η a μ (-((k : ℕ) : ℤ)) ((η ν * c ν) • mode η a ν (-J) Y)
          + ((η ν * c ν) *
              (if -J + -((k : ℕ) : ℤ) = 0 ∧ ν = μ then ((-J : ℤ) : R) * η ν else 0)) • Y := by
    intro ν
    have h := congrArg (fun T : Module.End R (Fock D R) => T Y)
      (lie_mode_mode η a ν μ (-J) (-((k : ℕ) : ℤ)))
    simp only [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
      LinearMap.smul_apply, LinearMap.id_coe, id_eq] at h
    rw [sub_eq_iff_eq_add.mp h, smul_add, smul_smul, map_smul]
    exact add_comm _ _
  rw [Finset.sum_congr rfl fun ν _ => hterm ν, Finset.sum_add_distrib, ← Finset.sum_smul]
  congr 2
  rcases eq_or_ne J (-((k : ℕ) : ℤ)) with hJk | hJk
  · rw [if_pos hJk]
    have hcond : ∀ ν : Fin D,
        (η ν * c ν) * (if -J + -((k : ℕ) : ℤ) = 0 ∧ ν = μ then ((-J : ℤ) : R) * η ν else 0)
          = if ν = μ then ((k : ℕ) : R) * c μ else 0 := by
      intro ν
      rcases eq_or_ne ν μ with rfl | hν
      · rw [if_pos ⟨by omega, rfl⟩, if_pos rfl, hJk]
        have : ((-(-((k : ℕ) : ℤ)) : ℤ) : R) = ((k : ℕ) : R) := by push_cast; ring
        rw [this]
        calc (η ν * c ν) * (((k : ℕ) : R) * η ν)
            = (η ν * η ν) * (((k : ℕ) : R) * c ν) := by ring
          _ = ((k : ℕ) : R) * c ν := by rw [hη ν, one_mul]
      · rw [if_neg (fun h => hν h.2), if_neg hν, mul_zero]
    rw [Finset.sum_congr rfl fun ν _ => hcond ν]
    simp
  · rw [if_neg hJk]
    refine Finset.sum_eq_zero fun ν _ => ?_
    rw [if_neg (fun h => hJk (by omega : J = -((k : ℕ) : ℤ))), mul_zero]

end DotMode

/-! ### The same-point product of the current with the vertex operator

`W^{(b)}_L = Σ_J (b·α_{-J}) V^{(b)}_{L-J}` is the `z^L` coefficient of
`(b·z∂_z X)(z) :e^{i b·X(z)}:`.  For `b² = 0` there is no contraction between the two
factors, so the product needs no normal ordering and the two factors commute
(`Fock.dotMode_vertexOsc_comm`).  That commutation is also what makes the sum *locally
finite*: run the `J`-sum with the current on the right to bound `J` from below (the current
is an annihilation operator for `J < 0`) and with the current on the left to bound it from
above (the vertex operator cannot lower the level indefinitely). -/

section Current

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

/-- The two-sided window `-modeBound P ≤ J ≤ L + levelBound P` of the current-vertex
product. -/
noncomputable def currentIdx (L : ℤ) (P : Fock D R) : Finset ℤ :=
  Finset.Icc (-(modeBound P : ℤ)) (L + (levelBound P : ℤ))

/-- Outside the window the summand vanishes.  The *upper* end is the level bound on
`V^{(b)}_{L-J}P`; the *lower* end needs the commutation `Fock.dotMode_vertexOsc_comm`, i.e.
`b² = 0`. -/
theorem dotMode_vertexOsc_apply_eq_zero_of_notMem (η a c b : Fin D → R)
    (hη : ∀ μ, η μ * η μ = 1) (hcb : dotVec η c b = 0) (L : ℤ) (P : Fock D R) {J : ℤ}
    (hJ : J ∉ currentIdx L P) :
    dotMode η c a J (vertexOsc η b (L - J) P) = 0 := by
  rw [currentIdx, Finset.mem_Icc, not_and_or] at hJ
  rcases hJ with h | h
  · rw [dotMode_vertexOsc_comm η c a b hη hcb,
      dotMode_apply_eq_zero_of_modeBound_lt η c a (by omega : (modeBound P : ℤ) < -J),
      map_zero]
  · rw [vertexOsc_apply_eq_zero_of_levelBound_lt η b
      (by omega : (levelBound P : ℤ) + (L - J) < 0), map_zero]

/-- **The current-vertex product** `W^{(b)}_L = Σ_J (b·α_{-J}) V^{(b)}_{L-J}`, assembled as a
locally finite sum. -/
noncomputable def vertexCurrent (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (L : ℤ) : Module.End R (Fock D R) :=
  lsumLocFin (fun J => dotMode η b a J ∘ₗ vertexOsc η b (L - J)) (currentIdx L)
    (fun P J hJ => by
      rw [LinearMap.comp_apply]
      exact dotMode_vertexOsc_apply_eq_zero_of_notMem η a b b hη hbb L P hJ)

/-- `vertexCurrent` is computed by any index set containing the window. -/
theorem vertexCurrent_apply (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (L : ℤ) (P : Fock D R) {s : Finset ℤ}
    (hs : ∀ J : ℤ, -(modeBound P : ℤ) ≤ J → J ≤ L + (levelBound P : ℤ) → J ∈ s) :
    vertexCurrent η a b hη hbb L P
      = ∑ J ∈ s, dotMode η b a J (vertexOsc η b (L - J) P) := by
  rw [vertexCurrent, lsumLocFin_apply _ _ _ P (fun J hJ => by
    rw [LinearMap.comp_apply]
    refine dotMode_vertexOsc_apply_eq_zero_of_notMem η a b b hη hbb L P (fun hmem => hJ ?_)
    rw [currentIdx, Finset.mem_Icc] at hmem
    exact hs J hmem.1 hmem.2)]
  exact Finset.sum_congr rfl fun J _ => rfl

/-- **The vacuum value.**  Only `J ≥ 0` contributes; the `J = 0` term is the scalar `b·a`
and the `J ≥ 1` tail is the Euler recursion `Fock.sum_mode_creaExp_eq_smul` for the coherent
state.  Hence `W^{(b)}_L |0⟩ = (L + b·a) Φ^b_L`. -/
theorem vertexCurrent_apply_one (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (L : ℤ) :
    vertexCurrent η a b hη hbb L (1 : Fock D R)
      = ((L : R) + dotVec η b a) • creaExp η b L := by
  classical
  have hmem : (0 : ℤ) ∉ Finset.Ioc (0 : ℤ) (max L 0) := by simp
  rw [vertexCurrent_apply η a b hη hbb L 1
      (s := insert (0 : ℤ) (Finset.Ioc (0 : ℤ) (max L 0))) (fun J h1 h2 => ?_),
    Finset.sum_insert hmem]
  · have hzero : dotMode η b a 0 (vertexOsc η b (L - 0) (1 : Fock D R))
        = dotVec η b a • creaExp η b L := by
      rw [sub_zero, vertexOsc_apply_one, dotMode_zero, LinearMap.smul_apply,
        LinearMap.id_coe, id_eq]
    have htail : ∑ J ∈ Finset.Ioc (0 : ℤ) (max L 0),
        dotMode η b a J (vertexOsc η b (L - J) (1 : Fock D R))
        = (L : R) • creaExp η b L := by
      rw [← sum_mode_creaExp_eq_smul η a b (le_max_left L 0)]
      refine Finset.sum_congr rfl fun J _ => ?_
      rw [vertexOsc_apply_one, dotMode_apply]
    rw [hzero, htail, add_comm, add_smul]
  · rw [modeBound_one] at h1
    rw [levelBound_one] at h2
    rw [Finset.mem_insert, Finset.mem_Ioc]
    rcases eq_or_ne J 0 with rfl | hJ
    · exact Or.inl rfl
    · exact Or.inr ⟨by omega, le_trans (by omega) (le_max_left L 0)⟩

/-- **The creation recursion for the current-vertex product.**  Compared with the vertex
operator's own recursion (`Fock.vertexOsc_X_mul`) there is one extra term, coming from the
commutator of the creation generator with the current; it carries the factor `k` of the
oscillator mode, and this is exactly the extra term produced by differentiating the
prefactor `L` in `(L + b·a) V_L`.  The two cancel in `Fock.vertexCurrent_eq`. -/
theorem vertexCurrent_X_mul (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (v : Osc D) (L : ℤ) (P : Fock D R) :
    vertexCurrent η a b hη hbb L (X v * P)
      = X v * vertexCurrent η a b hη hbb L P
        - b v.1 • vertexCurrent η a b hη hbb (L + ((v.2 : ℕ) : ℤ)) P
        + (((v.2 : ℕ) : R) * b v.1) • vertexOsc η b (L + ((v.2 : ℕ) : ℤ)) P := by
  classical
  set k : ℤ := ((v.2 : ℕ) : ℤ) with hk
  set s : Finset ℤ :=
    ((currentIdx L (X v * P) ∪ currentIdx L P) ∪ currentIdx (L + k) P) ∪ {-k} with hsdef
  have hsub : ∀ (L' : ℤ) (Q : Fock D R), currentIdx L' Q ⊆ s →
      ∀ J : ℤ, -(modeBound Q : ℤ) ≤ J → J ≤ L' + (levelBound Q : ℤ) → J ∈ s := by
    intro L' Q hQ J h1 h2
    exact hQ (by rw [currentIdx, Finset.mem_Icc]; exact ⟨h1, h2⟩)
  have hs1 : currentIdx L (X v * P) ⊆ s := fun y hy => by
    simp only [hsdef, Finset.mem_union]; exact Or.inl (Or.inl (Or.inl hy))
  have hs2 : currentIdx L P ⊆ s := fun y hy => by
    simp only [hsdef, Finset.mem_union]; exact Or.inl (Or.inl (Or.inr hy))
  have hs3 : currentIdx (L + k) P ⊆ s := fun y hy => by
    simp only [hsdef, Finset.mem_union]; exact Or.inl (Or.inr hy)
  have hs4 : (-k) ∈ s := by
    simp [hsdef]
  rw [vertexCurrent_apply η a b hη hbb L (X v * P) (hsub L _ hs1),
    vertexCurrent_apply η a b hη hbb L P (hsub L _ hs2),
    vertexCurrent_apply η a b hη hbb (L + k) P (hsub (L + k) _ hs3)]
  have hterm : ∀ J : ℤ, dotMode η b a J (vertexOsc η b (L - J) (X v * P))
      = X v * dotMode η b a J (vertexOsc η b (L - J) P)
        + (if J = -k then ((v.2 : ℕ) : R) * b v.1 else 0) • vertexOsc η b (L - J) P
        - b v.1 • dotMode η b a J (vertexOsc η b ((L + k) - J) P) := by
    intro J
    rw [vertexOsc_X_mul η b v (L - J) P, ← hk, map_sub, dotMode_X_mul η b a hη v J,
      map_smul, show L - J + k = L + k - J from by ring]
  rw [Finset.sum_congr rfl fun J _ => hterm J, Finset.sum_sub_distrib, Finset.sum_add_distrib,
    ← Finset.mul_sum, ← Finset.smul_sum]
  have hsingle : ∑ J ∈ s, (if J = -k then ((v.2 : ℕ) : R) * b v.1 else 0) •
      vertexOsc η b (L - J) P
      = (((v.2 : ℕ) : R) * b v.1) • vertexOsc η b (L + k) P := by
    rw [Finset.sum_eq_single (-k) (fun J _ hJ => by rw [if_neg hJ, zero_smul])
      (fun hns => absurd hs4 hns), if_pos rfl, show L - -k = L + k from by ring]
  rw [hsingle]
  abel

/-- **The weight identity for the vertex operator** (step (5b)'s missing atom).

For a light-like vertex momentum (`b·b = 0`),
`Σ_J (b·α_{-J}) V^{(b)}_L-J = (L + b·a) V^{(b)}_L`.

This is the algebraic content of `z ∂_z :e^{i b·X}: = :(i b·z∂_z X) e^{i b·X}:`.  The
prefactor `b·a = 2α' b·k` is the monodromy exponent of the vertex operator on a Fock space
of momentum `k`; on the DDF tower it is the rung shift already built into `towerVertex`, so
there the identity reads simply `K V^{(m)}_K = m Σ_J (k_0·α_{-J}) V^{(m)}_{K-J}`.

Note that this is **not** a consequence of the conformal-weight identity
`⁅L_0, V_J⁆ = J V_J` together with the same-point product: `L_0` acts on a product by
Leibniz and only sees the *sum* of the two weights, whereas the weighted sum of (5b) puts
the weight on *one* factor.  The current `b·α` has to be introduced by hand. -/
theorem vertexCurrent_eq (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (L : ℤ) :
    vertexCurrent η a b hη hbb L = ((L : R) + dotVec η b a) • vertexOsc η b L := by
  have hzero := eq_zero_of_vertex_recursion b
    (fun J => vertexCurrent η a b hη hbb J - ((J : R) + dotVec η b a) • vertexOsc η b J) ?_ ?_ L
  · rwa [sub_eq_zero] at hzero
  · intro v J P
    simp only [LinearMap.sub_apply, LinearMap.smul_apply, LinearMap.sub_apply]
    rw [vertexCurrent_X_mul η a b hη hbb v J P, vertexOsc_X_mul η b v J P,
      smul_sub, mul_sub, mul_smul_comm]
    push_cast
    module
  · intro J
    simp only [LinearMap.sub_apply, LinearMap.smul_apply]
    rw [vertexCurrent_apply_one η a b hη hbb J, vertexOsc_apply_one, sub_self]

/-- The weight identity as an identity between honest finite sums. -/
theorem sum_dotMode_vertexOsc (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (L : ℤ) (P : Fock D R) {s : Finset ℤ}
    (hs : ∀ J : ℤ, -(modeBound P : ℤ) ≤ J → J ≤ L + (levelBound P : ℤ) → J ∈ s) :
    ∑ J ∈ s, dotMode η b a J (vertexOsc η b (L - J) P)
      = ((L : R) + dotVec η b a) • vertexOsc η b L P := by
  rw [← vertexCurrent_apply η a b hη hbb L P hs, vertexCurrent_eq η a b hη hbb L,
    LinearMap.smul_apply]

end Current

end Fock

/-! ### The current on the DDF momentum tower

`towerCurrent η a b J` is `k_0·α_{-J}` acting rung by rung, each rung carrying its own
zero-mode momentum `a + j k_0`.  Under the DDF hypotheses (`k_0² = 0`, `2α' k_0·p = 1`) the
zero mode `J = 0` is the *same* scalar `1` on every rung
(`dotVec_towerMomentum_right_of_isotropic`), which is where the normalisation finally enters
the calculation. -/

section TowerCurrent

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

omit [Algebra ℚ R] in
lemma dotVec_vertexMomentum_left (η b y : Fin D → R) (n : ℤ) :
    dotVec η (vertexMomentum b n) y = (n : R) * dotVec η b y := by
  rw [dotVec, dotVec, Finset.mul_sum]
  exact Finset.sum_congr rfl fun μ _ => by simp only [vertexMomentum_apply]; ring

omit [Algebra ℚ R] in
lemma dotVec_vertexMomentum_right (η b y : Fin D → R) (n : ℤ) :
    dotVec η y (vertexMomentum b n) = (n : R) * dotVec η y b := by
  rw [dotVec_comm, dotVec_vertexMomentum_left, dotVec_comm]

/-- The contracted current `k_0·α_{-J}` on the momentum tower. -/
noncomputable def towerCurrent (η a b : Fin D → R) (J : ℤ) :
    Module.End R (TowerFock D R) :=
  towerDiag fun j => Fock.dotMode η b (towerMomentum a b j) J

omit [Algebra ℚ R] in
@[simp]
lemma towerCurrent_single (η a b : Fin D → R) (J j : ℤ) (P : Fock D R) :
    towerCurrent η a b J (Finsupp.single j P)
      = Finsupp.single j (Fock.dotMode η b (towerMomentum a b j) J P) :=
  towerDiag_single _ _ _

omit [Algebra ℚ R] in
/-- **The DDF normalisation makes the zero mode of the current the identity.**
`k_0·α_0 = 2α' k_0·(k + j k_0) = 2α' k_0·k = 1` on *every* rung, because `k_0² = 0`. -/
theorem towerCurrent_zero_of_normalized (η a b : Fin D → R) (hbb : dotVec η b b = 0)
    (hba : dotVec η b a = 1) :
    towerCurrent η a b 0 = (LinearMap.id : Module.End R (TowerFock D R)) := by
  refine Finsupp.lhom_ext fun j P => ?_
  rw [towerCurrent_single, Fock.dotMode_zero, LinearMap.smul_apply, LinearMap.id_coe, id_eq,
    dotVec_towerMomentum_right_of_isotropic η a b hbb, hba, one_smul, LinearMap.id_apply]

omit [Algebra ℚ R] in
/-- The current kills a tower vector once the annihilation index exceeds the mode bound. -/
theorem towerCurrent_apply_eq_zero_of_lt (η a b : Fin D → R) (J : ℤ) (x : TowerFock D R)
    (h : (towerModeBound x : ℤ) < -J) : towerCurrent η a b J x = 0 := by
  classical
  conv_lhs => rw [← sum_single_eq x]
  rw [map_sum]
  refine Finset.sum_eq_zero fun j hj => ?_
  have hle : (Fock.modeBound (x j) : ℤ) ≤ (towerModeBound x : ℤ) := by
    exact_mod_cast Finset.le_sup (f := fun j => Fock.modeBound (x j)) hj
  rw [towerCurrent_single,
    Fock.dotMode_apply_eq_zero_of_modeBound_lt η b (towerMomentum a b j) (by omega),
    Finsupp.single_zero]

/-- **The current commutes with every tower vertex operator** when `k_0² = 0`.

Two separate facts conspire: for `J ≠ 0` the mode `α^μ_{-J}` does not see the rung shift and
the bracket is `(k_0 · n k_0) V = n k_0² V = 0`; for `J = 0` the current is the scalar
`k_0·(a + j k_0) = k_0·a`, which is the *same* on the rung before and after the shift, again
because `k_0² = 0`.  This is what gives the `J`-sum of the weighted product a cut-off that
does not depend on the other summation index. -/
theorem towerCurrent_towerVertex_comm (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (J n K : ℤ) :
    towerCurrent η a b J * towerVertex η b n K
      = towerVertex η b n K * towerCurrent η a b J := by
  refine Finsupp.lhom_ext fun j P => ?_
  rw [Module.End.mul_apply, Module.End.mul_apply, towerVertex_single, towerCurrent_single,
    towerCurrent_single, towerVertex_single]
  congr 1
  have hpar : Fock.dotMode η b (towerMomentum a b (j + n)) J
      = Fock.dotMode η b (towerMomentum a b j) J := by
    rcases eq_or_ne J 0 with rfl | hJ
    · rw [Fock.dotMode_zero, Fock.dotMode_zero,
        dotVec_towerMomentum_right_of_isotropic η a b hbb,
        dotVec_towerMomentum_right_of_isotropic η a b hbb]
    · rw [Fock.dotMode, Fock.dotMode]
      refine Finset.sum_congr rfl fun μ _ => ?_
      congr 1
      rcases (by omega : -J < 0 ∨ 0 < -J) with h | h
      · rw [Fock.mode_of_neg _ _ h, Fock.mode_of_neg _ _ h]
      · rw [Fock.mode_of_pos _ _ h, Fock.mode_of_pos _ _ h]
  rw [hpar]
  exact Fock.dotMode_vertexOsc_comm η b (towerMomentum a b j) (vertexMomentum b n) hη
    (by rw [dotVec_vertexMomentum_right, hbb, mul_zero]) J (K - n) P

/-- The two-sided window of the current-vertex product on the tower.  The lower end does not
depend on the vertex index because the current commutes through
(`towerCurrent_towerVertex_comm`). -/
noncomputable def towerCurrentIdx (m K : ℤ) (x : TowerFock D R) : Finset ℤ :=
  Finset.Icc (-(towerModeBound x : ℤ)) ((K - m) + (towerLevelBound x : ℤ))

theorem towerCurrent_towerVertex_apply_eq_zero_of_notMem (η a b : Fin D → R)
    (hη : ∀ μ, η μ * η μ = 1) (hbb : dotVec η b b = 0) (m K : ℤ) (x : TowerFock D R) {J : ℤ}
    (hJ : J ∉ towerCurrentIdx m K x) :
    towerCurrent η a b J (towerVertex η b m (K - J) x) = 0 := by
  rw [towerCurrentIdx, Finset.mem_Icc, not_and_or] at hJ
  rcases hJ with h | h
  · rw [← Module.End.mul_apply, towerCurrent_towerVertex_comm η a b hη hbb,
      Module.End.mul_apply, towerCurrent_apply_eq_zero_of_lt η a b J x (by omega), map_zero]
  · rw [towerVertex_apply_eq_zero_of_lt η b m (K - J) x (by omega), map_zero]

/-- **The current-vertex product on the tower**, `Σ_J (k_0·α_{-J}) V^{(m)}_{K-J}`. -/
noncomputable def towerCurrentVertex (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (m K : ℤ) : Module.End R (TowerFock D R) :=
  lsumLocFin (fun J => towerCurrent η a b J ∘ₗ towerVertex η b m (K - J))
    (towerCurrentIdx m K)
    (fun x J hJ => by
      rw [LinearMap.comp_apply]
      exact towerCurrent_towerVertex_apply_eq_zero_of_notMem η a b hη hbb m K x hJ)

theorem towerCurrentVertex_apply (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (m K : ℤ) (x : TowerFock D R) {s : Finset ℤ}
    (hs : ∀ J ∉ s, towerCurrent η a b J (towerVertex η b m (K - J) x) = 0) :
    towerCurrentVertex η a b hη hbb m K x
      = ∑ J ∈ s, towerCurrent η a b J (towerVertex η b m (K - J) x) := by
  rw [towerCurrentVertex, lsumLocFin_apply _ _ _ x (fun J hJ => by
    rw [LinearMap.comp_apply]
    exact hs J hJ)]
  exact Finset.sum_congr rfl fun J _ => rfl

/-- **The weight identity on the DDF tower.**
`m Σ_J (k_0·α_{-J}) V^{(m)}_{K-J} = K V^{(m)}_K`.

This is `Fock.vertexCurrent_eq` transported rung by rung.  The monodromy shift `b·a = m` of
the single-Fock statement is exactly the rung shift already built into `towerVertex`, so the
tower form has no extra constant: the eigenvalue of `z ∂_z` on `V^{(m)}_K` is `K`, in
agreement with the conformal-weight identity `⁅L_0, V^{(m)}_K⁆ = K V^{(m)}_K` of
`lie_towerLop_towerVertex`.  Here the normalisation `2α' k_0·p = 1` is used for the first
time. -/
theorem towerCurrentVertex_eq (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1) (m K : ℤ) :
    (m : R) • towerCurrentVertex η a b hη hbb m K = (K : R) • towerVertex η b m K := by
  classical
  have hcb : dotVec η b (vertexMomentum b m) = 0 := by
    rw [dotVec_vertexMomentum_right, hbb, mul_zero]
  have hb'b' : dotVec η (vertexMomentum b m) (vertexMomentum b m) = 0 := by
    rw [dotVec_vertexMomentum, hbb, mul_zero]
  refine Finsupp.lhom_ext fun j P => ?_
  have hvan : ∀ J ∉ Fock.currentIdx (K - m) P,
      towerCurrent η a b J (towerVertex η b m (K - J) (Finsupp.single j P)) = 0 := by
    intro J hJ
    rw [towerVertex_single, towerCurrent_single, show K - J - m = K - m - J from by ring,
      Fock.dotMode_vertexOsc_apply_eq_zero_of_notMem η (towerMomentum a b (j + m)) b
        (vertexMomentum b m) hη hcb (K - m) P hJ, Finsupp.single_zero]
  have hterm : ∀ J : ℤ,
      towerCurrent η a b J (towerVertex η b m (K - J) (Finsupp.single j P))
        = Finsupp.single (j + m) (Fock.dotMode η b (towerMomentum a b (j + m)) J
            (Fock.vertexOsc η (vertexMomentum b m) (K - m - J) P)) := by
    intro J
    rw [towerVertex_single, towerCurrent_single, show K - J - m = K - m - J from by ring]
  rw [LinearMap.smul_apply, LinearMap.smul_apply,
    towerCurrentVertex_apply η a b hη hbb m K _ hvan,
    Finset.sum_congr rfl fun J _ => hterm J, ← Finsupp.single_finsetSum, Finsupp.smul_single,
    towerVertex_single, Finsupp.smul_single]
  congr 1
  rw [Finset.smul_sum]
  have hres : ∀ J : ℤ, (m : R) • Fock.dotMode η b (towerMomentum a b (j + m)) J
        (Fock.vertexOsc η (vertexMomentum b m) (K - m - J) P)
      = Fock.dotMode η (vertexMomentum b m) (towerMomentum a b (j + m)) J
          (Fock.vertexOsc η (vertexMomentum b m) (K - m - J) P) := by
    intro J
    rw [Fock.dotMode_vertexMomentum, LinearMap.smul_apply]
  rw [Finset.sum_congr rfl fun J _ => hres J,
    Fock.sum_dotMode_vertexOsc η (towerMomentum a b (j + m)) (vertexMomentum b m) hη hb'b'
      (K - m) P (fun J h1 h2 => by rw [Fock.currentIdx, Finset.mem_Icc]; exact ⟨h1, h2⟩),
    dotVec_vertexMomentum_left, dotVec_towerMomentum_right_of_isotropic η a b hbb, hba,
    mul_one]
  congr 1
  push_cast
  ring

/-- **The zero-momentum tower vertex operator is the identity**, `V^{(0)}_K = δ_{K,0}`. -/
theorem towerVertex_zero_momentum (η b : Fin D → R) (K : ℤ) :
    towerVertex η b 0 K = if K = 0 then 1 else 0 := by
  have h0 : vertexMomentum b (0 : ℤ) = (0 : Fin D → R) := by
    funext μ
    rw [vertexMomentum_apply, Int.cast_zero, zero_mul, Pi.zero_apply]
  refine Finsupp.lhom_ext fun j P => ?_
  rw [towerVertex_single, add_zero, sub_zero, h0, Fock.vertexOsc_zero_momentum]
  rcases eq_or_ne K 0 with rfl | hK
  · rw [if_pos rfl, if_pos rfl, Module.End.one_apply, Module.End.one_apply]
  · rw [if_neg hK, if_neg hK, LinearMap.zero_apply, LinearMap.zero_apply, Finsupp.single_zero]

/-- In a `ℚ`-algebra a nonzero integer scalar may be cancelled. -/
lemma eq_zero_of_intCast_smul_eq_zero {M : Type*} [AddCommGroup M] [Module R M] {k : ℤ}
    (hk : k ≠ 0) {y : M} (h : (k : R) • y = 0) : y = 0 := by
  have hq : (algebraMap ℚ R ((k : ℚ)⁻¹)) * (k : R) = 1 := by
    rw [show ((k : ℤ) : R) = algebraMap ℚ R ((k : ℤ) : ℚ) from (map_intCast _ k).symm,
      ← map_mul, inv_mul_cancel₀ (by exact_mod_cast hk : ((k : ℚ)) ≠ 0), map_one]
  calc y = (1 : R) • y := (one_smul R y).symm
    _ = ((algebraMap ℚ R ((k : ℚ)⁻¹)) * (k : R)) • y := by rw [hq]
    _ = (algebraMap ℚ R ((k : ℚ)⁻¹)) • ((k : R) • y) := mul_smul _ _ _
    _ = 0 := by rw [h, smul_zero]

end TowerCurrent

/-! ### Step (5b): the index-weighted sum of two tower vertex operators

`Σ_j j V^{(m)}_j V^{(n)}_{-j} = m δ_{m+n,0}`.

The proof is the algebraic form of the residue argument.  Writing `j V^{(m)}_j` as
`m Σ_J (k_0·α_{-J}) V^{(m)}_{j-J}` (the weight identity `towerCurrentVertex_eq`), pulling the
current out of the `j`-sum (it commutes with everything, `towerCurrent_towerVertex_comm`) and
fusing the two exponentials with the same-point product (5a,
`sum_towerVertex_towerVertex_of_isotropic`) turns the whole expression into
`m Σ_J (k_0·α_{-J}) V^{(m+n)}_{-J}`.  Applying the weight identity *again*, now at momentum
`m+n` and index `K = 0`, gives `(m+n) Σ_J (k_0·α_{-J}) V^{(m+n)}_{-J} = 0`: this is the
"total derivative has no residue" step, and over a `ℚ`-algebra it forces the sum to vanish
whenever `m + n ≠ 0`.  For `m + n = 0` the exponential degenerates to the identity
(`towerVertex_zero_momentum`) and only the zero mode `k_0·α_0 = 2α' k_0·p = 1` survives,
leaving `m`. -/

section WeightedSum

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

/-- The composite of two tower vertex operators vanishes as soon as the *outer* Laurent index
is low enough, **uniformly in the inner index**.  This is the tower form of
`Fock.vertexOsc_vertexOsc_apply_eq_zero_of_gt` and it needs `k_0² = 0`. -/
theorem towerVertex_towerVertex_apply_eq_zero_of_lt (η b : Fin D → R)
    (hbb : dotVec η b b = 0) (m n A B : ℤ) (x : TowerFock D R)
    (hA : A < m - (towerLevelBound x : ℤ)) :
    towerVertex η b m A (towerVertex η b n B x) = 0 := by
  classical
  have hdot : dotVec η (vertexMomentum b n) (vertexMomentum b m) = 0 := by
    rw [dotVec_vertexMomentum, hbb, mul_zero]
  conv_lhs => rw [← sum_single_eq x]
  rw [map_sum, map_sum]
  refine Finset.sum_eq_zero fun j hj => ?_
  have hle : (Fock.levelBound (x j) : ℤ) ≤ (towerLevelBound x : ℤ) := by
    exact_mod_cast Finset.le_sup (f := fun j => Fock.levelBound (x j)) hj
  rw [towerVertex_single, towerVertex_single,
    Fock.vertexOsc_vertexOsc_apply_eq_zero_of_gt η (vertexMomentum b m) (vertexMomentum b n)
      hdot (B - n) (by omega : (Fock.levelBound (x j) : ℤ) + (A - m) < 0),
    Finsupp.single_zero]

/-- **Step (5b) of the DDF transverse algebra.**  On the momentum tower of a light-like
reference vector normalised by `2α' k_0·p = 1`,
`Σ_j j V^{(m)}_j V^{(n)}_{-j} = m δ_{m+n,0}`.

The index set `s` may be any finite set containing the window
`m - levelBound - modeBound ≤ j ≤ levelBound - n`.  (The summand itself already vanishes for
`j < m - levelBound`; the extra `modeBound` of slack is what the intermediate double sum
needs, and costs the caller nothing.) -/
theorem sum_weighted_towerVertex_towerVertex (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1) (m n : ℤ) (x : TowerFock D R)
    {s : Finset ℤ}
    (hs : ∀ j : ℤ, m - (towerLevelBound x : ℤ) - (towerModeBound x : ℤ) ≤ j →
      j ≤ (towerLevelBound x : ℤ) - n → j ∈ s) :
    ∑ j ∈ s, (j : R) • (towerVertex η b m j * towerVertex η b n (-j)) x
      = (if m + n = 0 then (m : R) else 0) • x := by
  classical
  set N : ℤ := (towerLevelBound x : ℤ) with hN
  set M : ℤ := (towerModeBound x : ℤ) with hM
  set T : Finset ℤ := Finset.Icc (-M) (2 * N - m - n) with hT
  have hcomm : ∀ (J p K : ℤ) (y : TowerFock D R),
      towerCurrent η a b J (towerVertex η b p K y)
        = towerVertex η b p K (towerCurrent η a b J y) := by
    intro J p K y
    have h := congrArg (fun (E : Module.End R (TowerFock D R)) => E y)
      (towerCurrent_towerVertex_comm η a b hη hbb J p K)
    simpa only [Module.End.mul_apply] using h
  -- the summand of the intermediate double sum vanishes outside `T`, uniformly in `j`
  have hvan : ∀ j : ℤ, ∀ J ∉ T,
      towerCurrent η a b J (towerVertex η b m (j - J) (towerVertex η b n (-j) x)) = 0 := by
    intro j J hJ
    rw [hT, Finset.mem_Icc, not_and_or] at hJ
    rcases hJ with h | h
    · rw [hcomm, hcomm, towerCurrent_apply_eq_zero_of_lt η a b J x (by omega), map_zero,
        map_zero]
    · rcases le_or_gt j (N - n) with hj | hj
      · rw [towerVertex_towerVertex_apply_eq_zero_of_lt η b hbb m n (j - J) (-j) x
          (by omega), map_zero]
      · rw [towerVertex_apply_eq_zero_of_lt η b n (-j) x (by omega), map_zero, map_zero]
  -- (1) replace `j V^{(m)}_j` by `m Σ_J (k_0·α_{-J}) V^{(m)}_{j-J}`
  have hstep1 : ∀ j ∈ s, (j : R) • (towerVertex η b m j * towerVertex η b n (-j)) x
      = (m : R) • ∑ J ∈ T, towerCurrent η a b J
          (towerVertex η b m (j - J) (towerVertex η b n (-j) x)) := by
    intro j _
    rw [Module.End.mul_apply, ← LinearMap.smul_apply,
      ← towerCurrentVertex_eq η a b hη hbb hba m j, LinearMap.smul_apply,
      towerCurrentVertex_apply η a b hη hbb m j _ (hvan j)]
  -- (2) exchange the two sums and fuse the exponentials with (5a)
  have hstep2 : ∀ J ∈ T, ∑ j ∈ s, towerCurrent η a b J
        (towerVertex η b m (j - J) (towerVertex η b n (-j) x))
      = towerCurrent η a b J (towerVertex η b (m + n) (0 - J) x) := by
    intro J hJ
    rw [hT, Finset.mem_Icc] at hJ
    rw [← map_sum]
    congr 1
    have himg : ∑ K ∈ s.image (fun j => -j),
          (towerVertex η b m ((0 - J) - K) * towerVertex η b n K) x
        = ∑ j ∈ s, towerVertex η b m (j - J) (towerVertex η b n (-j) x) := by
      rw [Finset.sum_image (fun p _ q _ h => by omega)]
      refine Finset.sum_congr rfl fun j _ => ?_
      rw [Module.End.mul_apply, show (0 - J) - -j = j - J from by ring]
    rw [← himg]
    refine sum_towerVertex_towerVertex_of_isotropic η b hbb m n (0 - J) x
      (fun K h1 h2 => ?_)
    rw [Finset.mem_image]
    exact ⟨-K, hs (-K) (by omega) (by omega), by omega⟩
  rw [Finset.sum_congr rfl hstep1, ← Finset.smul_sum, Finset.sum_comm,
    Finset.sum_congr rfl hstep2]
  -- (3) the residue: total derivative for `m + n ≠ 0`, zero mode for `m + n = 0`
  rcases eq_or_ne (m + n) 0 with hmn | hmn
  · have h0T : (0 : ℤ) ∈ T := by rw [hT, Finset.mem_Icc]; omega
    have hz : ∀ J ∈ T, towerCurrent η a b J (towerVertex η b (m + n) (0 - J) x)
        = if J = 0 then x else 0 := by
      intro J _
      rw [hmn, towerVertex_zero_momentum]
      rcases eq_or_ne J 0 with rfl | hJ
      · rw [sub_zero, if_pos rfl, Module.End.one_apply,
          towerCurrent_zero_of_normalized η a b hbb hba, LinearMap.id_apply, if_pos rfl]
      · rw [if_neg (by omega : ¬ (0 - J = 0)), if_neg hJ, LinearMap.zero_apply, map_zero]
    rw [if_pos hmn, Finset.sum_congr rfl hz]
    congr 1
    simp [h0T]
  · have hvan0 : ∀ J ∉ T, towerCurrent η a b J (towerVertex η b (m + n) (0 - J) x) = 0 := by
      intro J hJ
      rw [hT, Finset.mem_Icc, not_and_or] at hJ
      rcases hJ with h | h
      · rw [hcomm, towerCurrent_apply_eq_zero_of_lt η a b J x (by omega), map_zero]
      · rw [towerVertex_apply_eq_zero_of_lt η b (m + n) (0 - J) x (by omega), map_zero]
    rw [if_neg hmn, zero_smul,
      ← towerCurrentVertex_apply η a b hη hbb (m + n) 0 x hvan0]
    have hkey := congrArg (fun (E : Module.End R (TowerFock D R)) => E x)
      (towerCurrentVertex_eq η a b hη hbb hba (m + n) 0)
    simp only [LinearMap.smul_apply, Int.cast_zero, zero_smul] at hkey
    rw [eq_zero_of_intCast_smul_eq_zero hmn hkey, smul_zero]

end WeightedSum

end StringFormal.NoGhost
