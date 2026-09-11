/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.DDFOperatorAll
import StringFormal.NoGhost.DDFAlgebra
import StringFormal.NoGhost.VertexAdjoint

/-!
# The longitudinal Goddard–Thorn operator `K_m = k_0 · α_m`

Graph node (suggested): `worldsheet.gt-longitudinal-k-algebra`; blueprint
`formal/BLUEPRINT-noghost.md` §A.1 and §A.2.  Source: Goddard, *The work of Richard Brower*
(2008) §6, equations (6.2)–(6.3), recorded as extraction E7 in
`literature/extractions/gsw-1987-v1.md`.

The Goddard–Thorn proof does **not** use Brower's longitudinal operator `A^L_n = Ã_n + F_n`;
it uses the much simpler `K_n = k_0 · α_n`, whose extended algebra with the Virasoro
generators is

```
[L_m, K_n] = -n K_{m+n},    [K_m, K_n] = 0,    K_0 = 1,    K_m† = K_{-m}.
```

**The key observation of this file is that `K_m` is already present in the repository**: it is
the polarised mode `towerModeVec η a b b m`, i.e. the DDF polarisation specialised to the
light-like reference vector `b = k_0` itself.  The light-like condition
`hbb : dotVec η b b = 0` *is* the statement that `b` is transverse to itself, so every lemma
of the DDF island whose key hypothesis is transversality `dotVec η ε b = 0` applies verbatim
at `ε := b`.

## Main results

* `kOp` — the definition `K_m = towerModeVec η a b b m`.
* `lie_towerLop_kOp` — `⁅L_m, K_n⁆ = -n K_{m+n}` (Goddard (6.3)); no geometric hypothesis
  beyond `hη`.
* `lie_kOp_kOp` — `⁅K_m, K_n⁆ = 0`; the central term is `m (k_0·k_0) δ_{m+n,0}` and this is the
  **only** place in the algebra where `k_0² = 0` is used.
* `kOp_zero_eq_id` / `kOp_zero_eq_one` — `K_0 = 1`.  This is stronger than "`K_0` is a
  scalar": the DDF normalisation `2α' k_0·k = 1` holds on *every* rung of the tower
  (`dotVec_towerMomentum_right_of_isotropic`), so the zero mode is the identity operator.
* `towerPairing_kOp_left` — `K_m† = K_{-m}`.
* `kOp_mul_towerVertex` — `K_p` commutes with the DDF vertex operators (uses `k_0² = 0`).
* `lie_kOp_ddfOp` — **`⁅K_m, A^ε_n⁆ = 0`**: the longitudinal operator commutes with the
  transverse DDF operators.  Both geometric inputs are used exactly once: `hbb` to move `K`
  through the vertex operator and `hεb` to move it through `α^ε_j`.
* `kOp_apply_single_vacuum_of_pos` — `K_n |0; k + j k_0⟩ = 0` for `n > 0`, on every rung.
* `towerKerK`, `ddfCharacterization` — the submodule `⋂_{n>0} ker K_n` of Goddard (6.2) and,
  intersected with the physical-state conditions, the Goddard–Thorn characterisation of the
  DDF subspace; `ddfOp_mem_towerKerK` and `ddfOp_mem_ddfCharacterization` say that the DDF
  operators preserve them.

## Scope and gaps

* `ddfCharacterization` is a **definition**, not a theorem: that it *equals* the span of the
  DDF states (Goddard (6.2) read as an equality) is the spanning lemma `ddf-spans` of
  blueprint §B and is **not** proved here.  What is proved is one inclusion's worth of
  infrastructure: the DDF operators preserve `ddfCharacterization`, and every rung vacuum
  lies in `towerKerK`.
* Brower's `A^L_n` is deliberately **not** formalised; see blueprint §A.3 for the cost
  estimate (the mode sum of `Ã_n` is not locally finite on the algebraic Fock space, because
  `dotVec η b̃ b = -1 ≠ 0` destroys exactly the transversality cut-off that makes `ddfOp`
  exist).
-/

namespace StringFormal.NoGhost

section Longitudinal

variable {D : ℕ} {R : Type*} [CommRing R]

/-- **The longitudinal (Goddard–Thorn) operator** `K_m = k_0 · α_m = Σ_μ η_μ b^μ α^μ_m`
(Goddard 2008 (6.2)).  It is the polarised DDF mode with polarisation the reference vector
`b = k_0` itself; the light-like condition `dotVec η b b = 0` makes `b` transverse to
itself. -/
noncomputable def kOp (η a b : Fin D → R) (m : ℤ) : Module.End R (TowerFock D R) :=
  towerModeVec η a b b m

lemma kOp_eq_towerModeVec (η a b : Fin D → R) (m : ℤ) :
    kOp η a b m = towerModeVec η a b b m := rfl

/-! ### The extended algebra (Goddard 2008 (6.3)) -/

/-- **`⁅L_m, K_n⁆ = -n K_{m+n}`** (Goddard 2008 (6.3), second relation).  Note that this needs
*no* geometric hypothesis beyond `η_μ² = 1`: neither `k_0² = 0` nor the normalisation
`2α' k_0·k = 1` enters, because `K` transforms as a weight-one current for any polarisation. -/
theorem lie_towerLop_kOp [Algebra ℚ R] (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (m n : ℤ) :
    ⁅towerLop η a b m, kOp η a b n⁆ = (-(n : R)) • kOp η a b (m + n) :=
  lie_towerLop_towerModeVec η a b b hη m n

/-- **`⁅K_m, K_n⁆ = 0`** (Goddard 2008 (6.3), third relation).  The polarised canonical
commutation relation gives the central term `m (k_0·k_0) δ_{m+n,0}`, which vanishes precisely
because `k_0` is light-like: this is the only use of `hbb` in the `K`-algebra. -/
theorem lie_kOp_kOp (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (hbb : dotVec η b b = 0)
    (m n : ℤ) : ⁅kOp η a b m, kOp η a b n⁆ = 0 := by
  classical
  rw [kOp, kOp, lie_towerModeVec_towerModeVec η a b b b hη m n, hbb, mul_zero, ite_self,
    zero_smul]

/-- **`K_0 = 1`** (Goddard 2008 (6.2)).  On rung `j` the zero mode acts by the scalar
`k_0 · (k + j k_0) = k_0 · k`, which is *independent of the rung* because `k_0² = 0`
(`dotVec_towerMomentum_right_of_isotropic`), and equals `1` by the DDF normalisation
`2α' k_0 · k = 1`.  So `K_0` is the identity operator of the whole tower, not merely a scalar
on each rung. -/
theorem kOp_zero_eq_id (η a b : Fin D → R) (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1) :
    kOp η a b 0 = LinearMap.id := by
  refine Finsupp.lhom_ext fun j P => ?_
  rw [kOp, towerModeVec, LinearMap.sum_apply]
  have hterm : ∀ μ : Fin D, ((η μ * b μ) • towerMode η a b μ 0) (Finsupp.single j P)
      = Finsupp.single j ((η μ * b μ * towerMomentum a b j μ) • P) := by
    intro μ
    rw [LinearMap.smul_apply, towerMode_single, Fock.mode_zero_apply, Finsupp.smul_single,
      smul_smul]
  rw [Finset.sum_congr rfl fun μ _ => hterm μ, ← Finsupp.single_finsetSum, ← Finset.sum_smul,
    ← dotVec, dotVec_towerMomentum_right_of_isotropic η a b hbb, hba, one_smul,
    LinearMap.id_apply]

/-- `K_0 = 1` in the ring `Module.End R (TowerFock D R)`. -/
theorem kOp_zero_eq_one (η a b : Fin D → R) (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1) :
    kOp η a b 0 = 1 := by
  rw [kOp_zero_eq_id η a b hbb hba, Module.End.one_eq_id]

/-- **`K_m† = K_{-m}`** with respect to the tower form `towerPairing`. -/
theorem towerPairing_kOp_left (η a b : Fin D → R) (m : ℤ) (v w : TowerFock D R) :
    Fock.towerPairing η (kOp η a b m v) w = Fock.towerPairing η v (kOp η a b (-m) w) :=
  Fock.towerPairing_towerModeVec_left η a b b m v w

/-! ### `K` commutes with the DDF operators -/

/-- `K_p` commutes with the DDF vertex operator `V^{(n)}_K`.  The commutator is
`n (k_0·k_0) V^{(n)}_{K-p}`, so this is exactly the light-like condition again; it is the
`ε := b` case of `towerModeVec_mul_towerVertex_of_transverse`. -/
theorem kOp_mul_towerVertex [Algebra ℚ R] (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (n K p : ℤ) :
    kOp η a b p * towerVertex η b n K = towerVertex η b n K * kOp η a b p :=
  towerModeVec_mul_towerVertex_of_transverse η a b b hη hbb n K p

/-- `K_p` commutes with a transverse polarised mode `α^ε_j`: the central term of the polarised
canonical commutation relation is `p (k_0·ε) δ_{p+j,0}`, which vanishes by transversality. -/
theorem kOp_mul_towerModeVec (η a b ε : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hεb : dotVec η ε b = 0) (p j : ℤ) :
    kOp η a b p * towerModeVec η a b ε j = towerModeVec η a b ε j * kOp η a b p := by
  classical
  have h := lie_towerModeVec_towerModeVec η a b b ε hη p j
  rw [dotVec_comm η b ε, hεb, mul_zero, ite_self, zero_smul,
    LieRing.of_associative_ring_bracket, sub_eq_zero] at h
  exact h

/-- `K_p` commutes with each summand `α^ε_j V^{(n)}_j` of the DDF operator. -/
theorem kOp_mul_ddfSummand [Algebra ℚ R] (η a b ε : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (hεb : dotVec η ε b = 0) (n j p : ℤ) :
    kOp η a b p * ddfSummand η a b ε n j = ddfSummand η a b ε n j * kOp η a b p := by
  rw [ddfSummand, ← mul_assoc, kOp_mul_towerModeVec η a b ε hη hεb p j, mul_assoc,
    kOp_mul_towerVertex η a b hη hbb n j p, ← mul_assoc]

/-- **`⁅K_m, A^ε_n⁆ = 0`**: the longitudinal operator commutes with the transverse DDF
operators (the compatibility that makes the `K`-conditions of Goddard (6.2) a condition *on
the DDF states*).

Unlike `⁅L_m, A^ε_n⁆ = 0`, there is no telescoping and no boundary term: `K_m` commutes with
every individual summand `α^ε_j V^{(n)}_j`, so it suffices to evaluate the locally finite sum
on a window large enough for both `x` and `K_m x`.  The two geometric inputs are used exactly
once each: `hbb` moves `K_m` through `V^{(n)}_j`, `hεb` moves it through `α^ε_j`. -/
theorem lie_kOp_ddfOp [Algebra ℚ R] (η a b ε : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (hεb : dotVec η ε b = 0) (m n : ℤ) :
    ⁅kOp η a b m, ddfOp η a b ε hη hεb n⁆ = 0 := by
  classical
  refine LinearMap.ext fun x => ?_
  have hx : ∀ j ∉ ddfWindow n x ∪ ddfWindow n (kOp η a b m x),
      ddfSummand η a b ε n j x = 0 := fun j hj =>
    ddfSummand_apply_eq_zero_of_notMem_window η a b ε hη hεb n x j
      (fun h => hj (Finset.mem_union_left _ h))
  have hy : ∀ j ∉ ddfWindow n x ∪ ddfWindow n (kOp η a b m x),
      ddfSummand η a b ε n j (kOp η a b m x) = 0 := fun j hj =>
    ddfSummand_apply_eq_zero_of_notMem_window η a b ε hη hεb n (kOp η a b m x) j
      (fun h => hj (Finset.mem_union_right _ h))
  rw [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
    Module.End.mul_apply, LinearMap.zero_apply, ddfOp_apply η a b ε hη hεb n x hx,
    ddfOp_apply η a b ε hη hεb n (kOp η a b m x) hy, map_sum, sub_eq_zero]
  refine Finset.sum_congr rfl fun j _ => ?_
  have h := congrArg (fun T : Module.End R (TowerFock D R) => T x)
    (kOp_mul_ddfSummand η a b ε hη hbb hεb n j m)
  simpa only [Module.End.mul_apply] using h

/-- The operator form of `⁅K_m, A^ε_n⁆ = 0`. -/
theorem kOp_mul_ddfOp [Algebra ℚ R] (η a b ε : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (hεb : dotVec η ε b = 0) (m n : ℤ) :
    kOp η a b m * ddfOp η a b ε hη hεb n = ddfOp η a b ε hη hεb n * kOp η a b m := by
  have h := lie_kOp_ddfOp η a b ε hη hbb hεb m n
  rwa [LieRing.of_associative_ring_bracket, sub_eq_zero] at h

/-! ### The `K`-conditions of Goddard (6.2) -/

/-- **`K_n` annihilates the vacuum of every rung** for `n > 0`: each component `α^μ_n` of
`K_n = Σ_μ η_μ b^μ α^μ_n` is an annihilation operator.  (The tower vacuum `|0; k⟩` is the
case `j = 0`.) -/
theorem kOp_apply_single_vacuum_of_pos (η a b : Fin D → R) {n : ℤ} (hn : 0 < n) (j : ℤ) :
    kOp η a b n (Finsupp.single j (Fock.vacuum D R)) = 0 := by
  rw [kOp, towerModeVec, LinearMap.sum_apply]
  refine Finset.sum_eq_zero fun μ _ => ?_
  rw [LinearMap.smul_apply, towerMode_single, Fock.vacuum_def,
    Fock.mode_apply_one_eq_zero η (towerMomentum a b j) hn μ, Finsupp.single_zero, smul_zero]

/-- **The `K`-condition subspace** `⋂_{n>0} ker K_n` (Goddard 2008 (6.2)). -/
noncomputable def towerKerK (η a b : Fin D → R) : Submodule R (TowerFock D R) :=
  ⨅ n : ℤ, ⨅ _ : 0 < n, LinearMap.ker (kOp η a b n)

lemma mem_towerKerK {η a b : Fin D → R} {x : TowerFock D R} :
    x ∈ towerKerK η a b ↔ ∀ n : ℤ, 0 < n → kOp η a b n x = 0 := by
  simp only [towerKerK, Submodule.mem_iInf, LinearMap.mem_ker]

/-- Every rung vacuum satisfies the `K`-conditions. -/
theorem single_vacuum_mem_towerKerK (η a b : Fin D → R) (j : ℤ) :
    Finsupp.single j (Fock.vacuum D R) ∈ towerKerK η a b :=
  mem_towerKerK.2 fun _ hn => kOp_apply_single_vacuum_of_pos η a b hn j

/-- **The DDF operators preserve the `K`-conditions**, by `⁅K_m, A^ε_n⁆ = 0`.  Together with
`single_vacuum_mem_towerKerK` this gives, by induction on DDF monomials, the inclusion
"DDF states satisfy the `K`-conditions" of Goddard (6.2); the converse inclusion is the
spanning lemma and is not proved here. -/
theorem ddfOp_mem_towerKerK [Algebra ℚ R] (η a b ε : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    (hbb : dotVec η b b = 0) (hεb : dotVec η ε b = 0) (n : ℤ) {x : TowerFock D R}
    (hx : x ∈ towerKerK η a b) : ddfOp η a b ε hη hεb n x ∈ towerKerK η a b := by
  refine mem_towerKerK.2 fun m hm => ?_
  have h := congrArg (fun T : Module.End R (TowerFock D R) => T x)
    (kOp_mul_ddfOp η a b ε hη hbb hεb m n)
  simp only [Module.End.mul_apply] at h
  rw [h, mem_towerKerK.1 hx m hm, map_zero]

/-- **The Goddard–Thorn characterisation of the DDF subspace** (Goddard 2008 (6.2)): the
physical states of the tower (intercept `a₀`) that are in addition annihilated by every `K_n`,
`n > 0`.

This is a *definition*.  Goddard's sentence "the space generated by the DDF states can be
specified by imposing the conditions `K_n|ψ⟩ = 0, n > 0` in addition to the physical state
conditions" asserts that this submodule **equals** the span of the DDF states; that equality
is the spanning lemma `ddf-spans` (blueprint §B) and is not formalised. -/
noncomputable def ddfCharacterization [Algebra ℚ R] (η a b : Fin D → R) (a₀ : R) :
    Submodule R (TowerFock D R) :=
  towerPhysSubmodule η a b a₀ ⊓ towerKerK η a b

lemma mem_ddfCharacterization [Algebra ℚ R] {η a b : Fin D → R} {a₀ : R}
    {x : TowerFock D R} :
    x ∈ ddfCharacterization η a b a₀ ↔
      x ∈ towerPhysSubmodule η a b a₀ ∧ ∀ n : ℤ, 0 < n → kOp η a b n x = 0 := by
  rw [ddfCharacterization, Submodule.mem_inf, mem_towerKerK]

/-- **The DDF operators preserve the Goddard–Thorn characterisation**: they preserve the
physical-state conditions (`ddfOp_mem_towerPhysSubmodule`) and the `K`-conditions
(`ddfOp_mem_towerKerK`). -/
theorem ddfOp_mem_ddfCharacterization [Algebra ℚ R] (η a b ε : Fin D → R)
    (hη : ∀ μ, η μ * η μ = 1) (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1)
    (hεb : dotVec η ε b = 0) {a₀ : R} (n : ℤ) {Ψ : TowerFock D R}
    (hΨ : Ψ ∈ ddfCharacterization η a b a₀) :
    ddfOp η a b ε hη hεb n Ψ ∈ ddfCharacterization η a b a₀ :=
  Submodule.mem_inf.2
    ⟨ddfOp_mem_towerPhysSubmodule η a b ε hη hbb hba hεb n (Submodule.mem_inf.1 hΨ).1,
      ddfOp_mem_towerKerK η a b ε hη hbb hεb n (Submodule.mem_inf.1 hΨ).2⟩

end Longitudinal

end StringFormal.NoGhost
