/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.VertexOperator

/-!
# The DDF momentum tower and the vertex operator on it

Graph node: `worldsheet.ddf-operators-v4`; `formal/TODO.md` item `ddf-operators`.
This file supplies the *momentum* half of the DDF construction, which
`StringFormal/NoGhost/Fock.lean` and `StringFormal/NoGhost/Sugawara.lean` deliberately left
out: there the momentum is an inert parameter `a : Fin D → R` standing for
`a^μ = α^μ_0 = (2α')^{1/2} k^μ`, and there is no operator `x^μ`.  A DDF operator changes the
momentum, so it cannot be an endomorphism of a single Fock space.

## What is here

* `TowerFock D R = ℤ →₀ Fock D R` — the **momentum tower** `⨁_{j ∈ ℤ} F(a + j·b)`, where
  `b^μ = (2α')^{1/2} k_0^μ` is the (rescaled) light-like reference vector of
  `worldsheet.ddf-operators-v4`.  Rung `j` carries momentum parameter
  `towerMomentum a b j = a + j·b`.
  **Index convention.**  The graph node indexes the tower by the oscillator level `N` with
  momenta `k - N k_0`; here the index is `j = -N`, so that the vertex operator of
  `e^{i n k_0·X}` shifts `j ↦ j + n` (`towerShift`).  The dictionary is `j = -N`.
* `towerShift n` — the zero-mode operator `e^{i n k_0·x}`, realised as the shift of rungs.
  This is the piece that is *absent* on a single Fock space and that supplies the `p = 0`
  case of the oscillator algebra.
* `towerDiag f` — an operator acting on rung `j` by `f j`; used for `towerMode` (`α^μ_p`)
  and `towerLop` (`L_n`), which do not move momentum.
* `towerVertex η b n K` — the `z^K` Laurent coefficient of the full vertex operator
  `:e^{i n k_0·X(z)}:` on the tower, i.e. `towerShift n` composed with the oscillator part
  `vertexOsc` of `StringFormal/NoGhost/VertexOperator.lean`.  The index shift `K ↦ K - n`
  inside is the monodromy factor `z^{2α' n k_0·p} = z^n`, which is a *fixed integer power*
  on the whole tower exactly because of the normalisation `2α' k_0·p = 1` together with
  `k_0² = 0`; see `dotVec_towerMomentum_right_of_isotropic`.

## Main statements

* `dotVec_towerMomentum_right_of_isotropic` — `k_0·p` is constant along the tower when
  `k_0² = 0`: this is claim (b) of `worldsheet.ddf-operators-v4` ("one rescaling of `k_0`
  covers the whole tower").
* `invTwo_mul_zeroModeSq_towerMomentum` — `α' p_j² = α' k² + j`, i.e. `α'(k - N k_0)² =
  α' k² - N`: the mass-shell bookkeeping used in `worldsheet.no-ghost-theorem-v4` (1b).
* `lie_towerLop_towerMode` — `[L_m, α^ν_p] = -p α^ν_{m+p}` on the tower.
* **`lie_towerMode_towerVertex`** — `[α^μ_p, V^{(n)}_K] = n b^μ V^{(n)}_{K-p}` for **every**
  `p : ℤ`, the zero mode included.  On a single Fock space the `p = 0` case is false (see
  `Fock.lie_mode_zero_vertexOsc`); it is the rung shift that repairs it.
* `lie_towerMode_towerVertex_of_eq_zero` — transversality: if `b^μ = 0` then `α^μ_p` commutes
  with the vertex operator for every `p`.  This is `ε·k_0 = 0` in
  `worldsheet.ddf-operators-v4`, and it is what makes the DDF contour integral
  `A^i_n = Σ_m α^i_m V^{(n)}_m` a *finite* sum on each state.

## What is NOT here (gaps for the dependency graph)

1. **The DDF operators themselves.**  `A^i_n = Σ_{m ∈ ℤ} α^i_m ∘ V^{(n)}_m` is not defined.
   The local finiteness of that sum follows from
   `lie_towerMode_towerVertex_of_eq_zero` (transversality lets one move `α^i_m` to the right,
   where it kills the state for `m` large) together with
   `Fock.vertexOsc_apply_eq_zero_of_level`, but neither the assembly nor
   `[A^i_m, A^j_n] = m δ^{ij} δ_{m+n,0}` is formalised.
2. **`[L_m, A^i_n] = 0`.**  The conformal-weight identity behind it is
   `L_m^{(a+b)} ∘ V_J - V_J ∘ L_m^{(a)} = (J + b·a - m + (m+1)·½ b·b) V_{J-m}`, whose
   weight is `h = ½ b·b = α' k_0² = 0` for a light-like reference vector.  Its *inductive
   step* is available — both sides obey the creation recursion by `Fock.mode_vertexOsc_sub`
   and `Fock.lie_Lop_mode`, so `Fock.eq_zero_of_vertex_recursion` reduces the identity to the
   vacuum — but the **base case** (`L_m` applied to the coherent-state coefficients
   `Fock.creaExp`) is not proved.  Consequently nothing about `L_m` and the vertex operator
   is asserted here.
3. **`x^μ` as an operator.**  `towerShift` is the *unitary* `e^{i n k_0·x}` only; the
   Heisenberg pair `[x^μ, p^ν]` is not formalised, and the tower is built over one fixed
   `a` and one fixed `b` rather than over the full momentum space.
4. **Normalisation as a hypothesis.**  The condition `2α' k_0·p = 1` enters as the explicit
   hypothesis `dotVec η b a = 1` where it is needed, not as part of the definitions; and
   `k_0² = 0` enters as `dotVec η b b = 0`.  No statement here *derives* the existence of a
   light-like `k_0` with `k_0·p ≠ 0` (that is a statement about the real quadratic form and
   is false over a general ring).

## Status

Complete, no `sorry`.
-/

namespace StringFormal.NoGhost

open MvPolynomial

section Dot

variable {D : ℕ} {R : Type*} [CommRing R]

/-- The spacetime contraction `x·y = η_{μν} x^μ y^ν` for the diagonal metric `η`
(`conv.metric-mostly-plus`). -/
def dotVec (η x y : Fin D → R) : R := ∑ μ : Fin D, η μ * x μ * y μ

lemma dotVec_comm (η x y : Fin D → R) : dotVec η x y = dotVec η y x := by
  refine Finset.sum_congr rfl fun μ _ => ?_
  ring

lemma zeroModeSq_eq_dotVec (η a : Fin D → R) : Fock.zeroModeSq η a = dotVec η a a := rfl

/-- The momentum parameter on rung `j` of the tower: `a + j·b`, i.e. `α^μ_0 = a^μ + j b^μ`.
With `a^μ = (2α')^{1/2} k^μ` and `b^μ = (2α')^{1/2} k_0^μ` this is the momentum `k + j k_0`;
the graph node `worldsheet.ddf-operators-v4` writes the same tower as `k - N k_0`, so `j = -N`. -/
def towerMomentum (a b : Fin D → R) (j : ℤ) : Fin D → R := fun μ => a μ + (j : R) * b μ

@[simp]
lemma towerMomentum_apply (a b : Fin D → R) (j : ℤ) (μ : Fin D) :
    towerMomentum a b j μ = a μ + (j : R) * b μ := rfl

@[simp]
lemma towerMomentum_zero (a b : Fin D → R) : towerMomentum a b 0 = a := by
  funext μ
  simp [towerMomentum]

/-- `k_0·p` along the tower: `b·(a + j·b) = b·a + j (b·b)`. -/
lemma dotVec_towerMomentum_right (η a b : Fin D → R) (j : ℤ) :
    dotVec η b (towerMomentum a b j) = dotVec η b a + (j : R) * dotVec η b b := by
  rw [dotVec, dotVec, dotVec, Finset.mul_sum, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun μ _ => ?_
  simp only [towerMomentum_apply]
  ring

/-- **Claim (b) of `worldsheet.ddf-operators-v4`**: if the reference vector is light-like
(`k_0² = 0`) then the normalisation condition `2α' k_0·p = 1` is preserved along the whole
DDF tower, so one rescaling of `k_0` covers the entire tower. -/
theorem dotVec_towerMomentum_right_of_isotropic (η a b : Fin D → R)
    (hbb : dotVec η b b = 0) (j : ℤ) :
    dotVec η b (towerMomentum a b j) = dotVec η b a := by
  rw [dotVec_towerMomentum_right, hbb, mul_zero, add_zero]

lemma zeroModeSq_towerMomentum (η a b : Fin D → R) (j : ℤ) :
    Fock.zeroModeSq η (towerMomentum a b j)
      = Fock.zeroModeSq η a + 2 * (j : R) * dotVec η b a + (j : R) ^ 2 * dotVec η b b := by
  rw [Fock.zeroModeSq, Fock.zeroModeSq, dotVec, dotVec, Finset.mul_sum, Finset.mul_sum,
    ← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun μ _ => ?_
  simp only [towerMomentum_apply]
  ring

/-- **The mass-shell bookkeeping of `worldsheet.no-ghost-theorem-v4` (1b)**:
`α'(k + j k_0)² = α' k² + j` when `k_0² = 0` and the DDF normalisation `2α' k_0·k = 1` holds.
In the level indexing of the graph node (`j = -N`, momentum `k - N k_0`) this reads
`α'(k - N k_0)² = α' k² - N`, which is why a state of that momentum sits at oscillator
level `N` on the mass shell. -/
theorem invTwo_mul_zeroModeSq_towerMomentum [Algebra ℚ R] (η a b : Fin D → R)
    (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1) (j : ℤ) :
    invTwo R * Fock.zeroModeSq η (towerMomentum a b j)
      = invTwo R * Fock.zeroModeSq η a + (j : R) := by
  rw [zeroModeSq_towerMomentum, hbb, hba, mul_zero, add_zero, mul_one, mul_add]
  congr 1
  calc invTwo R * (2 * (j : R)) = (invTwo R * 2) * (j : R) := by ring
    _ = (j : R) := by rw [invTwo_mul_two, one_mul]

end Dot

/-! ### The momentum tower -/

section Tower

variable {D : ℕ} {R : Type*} [CommRing R]

/-- **The DDF momentum tower** `⨁_{j ∈ ℤ} F(a + j·b)`.  Rung `j` is a copy of the
oscillator Fock space `Fock D R` carrying momentum parameter `towerMomentum a b j`. -/
abbrev TowerFock (D : ℕ) (R : Type*) [CommRing R] : Type _ := ℤ →₀ Fock D R

/-- The zero-mode operator `e^{i n k_0·x}`: it shifts the momentum by `n·b`, i.e. moves
rung `j` to rung `j + n`.  This is precisely the ingredient missing from the single-momentum
Fock space of `StringFormal/NoGhost/Fock.lean`. -/
noncomputable def towerShift (D : ℕ) (R : Type*) [CommRing R] (n : ℤ) :
    Module.End R (TowerFock D R) :=
  Finsupp.lmapDomain (Fock D R) R (fun j => j + n)

@[simp]
lemma towerShift_single (n j : ℤ) (P : Fock D R) :
    towerShift D R n (Finsupp.single j P) = Finsupp.single (j + n) P := by
  rw [towerShift, Finsupp.lmapDomain_apply, Finsupp.mapDomain_single]

@[simp]
lemma towerShift_zero : towerShift D R 0 = LinearMap.id := by
  refine Finsupp.lhom_ext fun j P => ?_
  rw [towerShift_single, add_zero, LinearMap.id_apply]

lemma towerShift_comp (m n : ℤ) :
    towerShift D R m ∘ₗ towerShift D R n = towerShift D R (n + m) := by
  refine Finsupp.lhom_ext fun j P => ?_
  rw [LinearMap.comp_apply, towerShift_single, towerShift_single, towerShift_single, add_assoc]

/-- An operator acting on rung `j` by `f j`; the momentum-preserving operators
(`α^μ_p`, `L_n`) are of this form. -/
noncomputable def towerDiag (f : ℤ → Module.End R (Fock D R)) :
    Module.End R (TowerFock D R) :=
  Finsupp.lsum R fun j => (Finsupp.lsingle j).comp (f j)

@[simp]
lemma towerDiag_single (f : ℤ → Module.End R (Fock D R)) (j : ℤ) (P : Fock D R) :
    towerDiag f (Finsupp.single j P) = Finsupp.single j (f j P) := by
  rw [towerDiag, Finsupp.lsum_single, LinearMap.comp_apply, Finsupp.lsingle_apply]

/-- The mode `α^μ_p` on the tower: it does not move the momentum, but for `p = 0` its
eigenvalue depends on the rung. -/
noncomputable def towerMode (η a b : Fin D → R) (μ : Fin D) (p : ℤ) :
    Module.End R (TowerFock D R) :=
  towerDiag fun j => Fock.mode η (towerMomentum a b j) μ p

@[simp]
lemma towerMode_single (η a b : Fin D → R) (μ : Fin D) (p : ℤ) (j : ℤ) (P : Fock D R) :
    towerMode η a b μ p (Finsupp.single j P)
      = Finsupp.single j (Fock.mode η (towerMomentum a b j) μ p P) :=
  towerDiag_single _ _ _

/-- The Virasoro generator `L_n` on the tower. -/
noncomputable def towerLop [Algebra ℚ R] (η a b : Fin D → R) (n : ℤ) :
    Module.End R (TowerFock D R) :=
  towerDiag fun j => Fock.Lop η (towerMomentum a b j) n

@[simp]
lemma towerLop_single [Algebra ℚ R] (η a b : Fin D → R) (n : ℤ) (j : ℤ) (P : Fock D R) :
    towerLop η a b n (Finsupp.single j P)
      = Finsupp.single j (Fock.Lop η (towerMomentum a b j) n P) :=
  towerDiag_single _ _ _

/-- The Virasoro relations with the modes, transported to the tower. -/
theorem lie_towerLop_towerMode [Algebra ℚ R] (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (m : ℤ) (ν : Fin D) (p : ℤ) :
    ⁅towerLop η a b m, towerMode η a b ν p⁆ = (-(p : R)) • towerMode η a b ν (m + p) := by
  refine Finsupp.lhom_ext fun j P => ?_
  rw [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
    Module.End.mul_apply, towerMode_single, towerLop_single, towerLop_single, towerMode_single,
    LinearMap.smul_apply, towerMode_single, ← Finsupp.single_sub, Finsupp.smul_single]
  congr 1
  have h := Fock.lie_Lop_mode η (towerMomentum a b j) hη m ν p
  have h' := congrArg (fun T : Module.End R (Fock D R) => T P) h
  simpa [LieRing.of_associative_ring_bracket] using h'

end Tower

/-! ### The vertex operator on the tower -/

section TowerVertex

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

/-- The rescaled vertex momentum `n·b`, i.e. `(2α')^{1/2} (n k_0)^μ`. -/
def vertexMomentum (b : Fin D → R) (n : ℤ) : Fin D → R := fun μ => (n : R) * b μ

omit [Algebra ℚ R] in
@[simp]
lemma vertexMomentum_apply (b : Fin D → R) (n : ℤ) (μ : Fin D) :
    vertexMomentum b n μ = (n : R) * b μ := rfl

/-- **The `z^K` Laurent coefficient of the vertex operator `:e^{i n k_0·X(z)}:` on the DDF
momentum tower.**  It is the composite of

* the oscillator part `Fock.vertexOsc η (n·b)` of `StringFormal/NoGhost/VertexOperator.lean`,
  acting on each rung, with Laurent index shifted by the monodromy exponent `n`
  (`z^{2α' n k_0·p} = z^n` under the DDF normalisation `2α' k_0·p = 1`, which by
  `dotVec_towerMomentum_right_of_isotropic` is the *same* integer on every rung);
* the zero-mode shift `towerShift n`, i.e. `e^{i n k_0·x}`, which moves rung `j` to `j + n`. -/
noncomputable def towerVertex (η b : Fin D → R) (n : ℤ) (K : ℤ) :
    Module.End R (TowerFock D R) :=
  towerShift D R n ∘ₗ towerDiag fun _ => Fock.vertexOsc η (vertexMomentum b n) (K - n)

@[simp]
lemma towerVertex_single (η b : Fin D → R) (n K : ℤ) (j : ℤ) (P : Fock D R) :
    towerVertex η b n K (Finsupp.single j P)
      = Finsupp.single (j + n) (Fock.vertexOsc η (vertexMomentum b n) (K - n) P) := by
  rw [towerVertex, LinearMap.comp_apply, towerDiag_single, towerShift_single]

/-- **The oscillator algebra of the vertex operator, zero mode included.**
`[α^μ_p, V^{(n)}_K] = (n b^μ) V^{(n)}_{K-p}` for every `p : ℤ`.

For `p ≠ 0` this is `Fock.lie_mode_vertexOsc` applied rung by rung.  For `p = 0` it is
*false* on a single Fock space (`Fock.lie_mode_zero_vertexOsc`: there the zero mode is a
scalar and the bracket vanishes); on the tower the rung shift changes the zero-mode
eigenvalue from `a + j·b` to `a + (j+n)·b`, and the difference is exactly `n b^μ`.  This is
the precise sense in which the DDF vertex operator "carries momentum `n k_0`". -/
theorem lie_towerMode_towerVertex (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (μ : Fin D)
    (n K p : ℤ) :
    ⁅towerMode η a b μ p, towerVertex η b n K⁆
      = ((n : R) * b μ) • towerVertex η b n (K - p) := by
  refine Finsupp.lhom_ext fun j P => ?_
  rw [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
    Module.End.mul_apply, towerVertex_single, towerMode_single, towerMode_single,
    towerVertex_single, LinearMap.smul_apply, towerVertex_single, ← Finsupp.single_sub,
    Finsupp.smul_single]
  congr 1
  rcases eq_or_ne p 0 with rfl | hp
  · -- the zero mode: the whole content is the shift of the momentum eigenvalue
    rw [Fock.mode_zero, Fock.mode_zero]
    simp only [LinearMap.smul_apply, LinearMap.id_coe, id_eq, map_smul, sub_zero]
    rw [← sub_smul]
    congr 1
    simp only [towerMomentum_apply]
    push_cast
    ring
  · -- a nonzero mode: momentum-independent, so this is the single-Fock-space statement
    have hmode : Fock.mode η (towerMomentum a b (j + n)) μ p
        = Fock.mode η (towerMomentum a b j) μ p := by
      rcases hp.lt_or_gt with hneg | hpos
      · rw [Fock.mode_of_neg _ _ hneg, Fock.mode_of_neg _ _ hneg]
      · rw [Fock.mode_of_pos _ _ hpos, Fock.mode_of_pos _ _ hpos]
    rw [hmode]
    have h := Fock.lie_mode_vertexOsc η (towerMomentum a b j) (vertexMomentum b n) hη μ hp
      (K - n)
    have h' := congrArg (fun T : Module.End R (Fock D R) => T P) h
    simp only [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
      LinearMap.smul_apply, vertexMomentum_apply] at h'
    rw [h', show K - n - p = K - p - n from by ring]

/-- **Transversality.**  If the polarisation direction `μ` is orthogonal to the reference
vector (`b^μ = 0`, i.e. `ε·k_0 = 0` in `worldsheet.ddf-operators-v4`), then `α^μ_p` commutes
with the vertex operator for *every* `p`.  This is what makes the DDF contour integral
`A^i_n = Σ_m α^i_m V^{(n)}_m` a finite sum on each state: with transversality one may move
`α^i_m` past `V^{(n)}_m` to the right, where it annihilates the state for `m` larger than its
oscillator level. -/
theorem lie_towerMode_towerVertex_of_eq_zero (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    {μ : Fin D} (hb : b μ = 0) (n K p : ℤ) :
    ⁅towerMode η a b μ p, towerVertex η b n K⁆ = 0 := by
  rw [lie_towerMode_towerVertex η a b hη μ n K p, hb, mul_zero, zero_smul]

/-- The vertex operator kills a rung vector whose oscillator level is too small: `V^{(n)}_K`
raises the level by `K - n`, and the level cannot go below `0`. -/
theorem towerVertex_single_eq_zero_of_level (η b : Fin D → R) (n K : ℤ) (j : ℤ) {N : ℕ}
    {P : Fock D R} (hP : P ∈ Fock.levelSubmodule D R N) (hK : (N : ℤ) + (K - n) < 0) :
    towerVertex η b n K (Finsupp.single j P) = 0 := by
  rw [towerVertex_single, Fock.vertexOsc_apply_eq_zero_of_level η _ hP hK, Finsupp.single_zero]

/-- The vertex operator moves rung `j` to rung `j + n` and raises the oscillator level by
`K - n`. -/
theorem towerVertex_single_mem_levelSubmodule (η b : Fin D → R) (n K : ℤ) (j : ℤ) {N M : ℕ}
    {P : Fock D R} (hP : P ∈ Fock.levelSubmodule D R N) (hM : (M : ℤ) = (N : ℤ) + (K - n)) :
    towerVertex η b n K (Finsupp.single j P)
      = Finsupp.single (j + n) (Fock.vertexOsc η (vertexMomentum b n) (K - n) P) ∧
        Fock.vertexOsc η (vertexMomentum b n) (K - n) P ∈ Fock.levelSubmodule D R M :=
  ⟨towerVertex_single η b n K j P, Fock.vertexOsc_mem_levelSubmodule η _ hP hM⟩

end TowerVertex

end StringFormal.NoGhost
