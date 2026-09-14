/-
Graph node: `worldsheet.bc-ghost-central-charge-lambda-two`
Conventions: `conv.virasoro-standard`, `conv.worldsheet-complex-coords`,
`conv.ghost-normal-ordering-sl2c`.

# The `λ = 2` `bc` ghost system has central charge `c^g = −26`

Let `b, c : ℤ → Module.End R M` satisfy the `λ = 2` anticommutation relations
`{b_m, c_n} = δ_{m+n,0}`, `{b_m, b_n} = {c_m, c_n} = 0` (`IsBCSystem`) on a *restricted* module
`M` (every vector is killed by `b_n` and `c_n` for `n` large, `IsRestricted`).  Define the
`SL(2,ℂ)`-normal-ordered generators

  `L^g_k = Σ_{p ∈ ℤ} (2k − p) :b_p c_{k−p}: = Σ_{n ∈ ℤ} (k − n) :b_{k+n} c_{−n}:`  (`Lop`)

(the two forms are related by `p = k + n`, see `ghostTerm_shift_apply` / `Lop_apply_shift`).
`SL(2,ℂ)` ordering means the annihilators — `b_n` for `n ≥ −1` and `c_n` for `n ≥ 2` — are moved
to the right with a fermionic sign, so `:b_p c_q: = b_p c_q` for `p ≤ −2` and `= −c_q b_p` for
`p ≥ −1` (`nord`).

Main results:
* `nord_bracket` — the `gl(∞)` cocycle plus the normal-ordering anomaly `χ(p) − χ(r)`;
* `six_mul_ghostAnom` — `6 z(m) = −13 (m³ − m)`, i.e. `z(m) = (−26/12)(m³ − m)` (pure arithmetic);
* `ghostVirCoeff_eq` / `ghostVirCoeff_eq_centralTerm` — **the central charge is `−26`**;
* `lie_Lop_Lop` — `[L^g_m, L^g_n] = (m − n) L^g_{m+n} + (−26/12)(m³ − m) δ_{m+n,0}`.

Everything holds over an arbitrary `CommRing R` except the final division by `12`, which needs
`[Algebra ℚ R]`.

Mathematical gaps (not claimed here): no *nonzero* model of `IsBCSystem` on a restricted module
is constructed, so the theorems are conditional on such a module being given (the semi-infinite
wedge of FGZ is one; it is not formalised).  The only thing imported from
`StringFormal.NoGhost.Sugawara` is the generic helper `lsumLocFin` (locally finite sums of
endomorphisms); no bosonic Fock space content is used.

Complete, no `sorry`; axioms are `propext`, `Classical.choice`, `Quot.sound` only.
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Data.Int.Interval
import Mathlib.Tactic.NoncommRing
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.Module
import StringFormal.NoGhost.Sugawara

namespace StringFormal.NoGhost.Ghost

/-! ### The `SL(2,ℂ)` annihilation indicator and the Kronecker delta -/

/-- Kronecker delta `δ_{i,0}` as an integer. -/
def kd (i : ℤ) : ℤ := if i = 0 then 1 else 0

lemma kd_add_comm (x y : ℤ) : kd (x + y) = kd (y + x) := by rw [add_comm]

@[simp] lemma kd_of_eq_zero {i : ℤ} (h : i = 0) : kd i = 1 := if_pos h

@[simp] lemma kd_of_ne_zero {i : ℤ} (h : i ≠ 0) : kd i = 0 := if_neg h

/-- `χ p = 1` exactly when `b_p` is an `SL(2,ℂ)` annihilation operator, i.e. `p ≥ −1`.
(The `SL(2,ℂ)` annihilators of the `λ = 2` ghost system are `b_n` for `n ≥ −1` and `c_n` for
`n ≥ 2`; this is `conv.ghost-normal-ordering-sl2c`.) -/
def chi (p : ℤ) : ℤ := if -1 ≤ p then 1 else 0

/-- The summand of the ghost anomaly: the coefficient picked up at `p` when the double sum for
`[L^g_m, L^g_{-m}]` is normal-ordered. -/
def anomSummand (m p : ℤ) : ℤ := (2 * m - p) * (-m - p) * (chi p - chi (p - m))

/-- The ghost anomaly `z(m)`: the scalar multiplying the identity in `[L^g_m, L^g_{-m}]`.
The window `[-(|m|+1), |m|+1]` contains the (finite) support of `anomSummand m`. -/
def ghostAnom (m : ℤ) : ℤ :=
  ∑ p ∈ Finset.Icc (-((m.natAbs : ℤ) + 1)) ((m.natAbs : ℤ) + 1), anomSummand m p

/-! ### Elementary sum identities -/

private lemma sum_Icc_eq_sum_range (a : ℤ) (N : ℕ) (f : ℤ → ℤ) :
    ∑ p ∈ Finset.Icc a (a + (N : ℤ) - 1), f p = ∑ j ∈ Finset.range N, f (a + (j : ℤ)) := by
  refine Finset.sum_nbij' (fun p => (p - a).toNat) (fun j => a + (j : ℤ)) ?_ ?_ ?_ ?_ ?_
  · intro x hx
    simp only [Finset.mem_Icc] at hx
    simp only [Finset.mem_range]
    omega
  · intro x hx
    simp only [Finset.mem_range] at hx
    simp only [Finset.mem_Icc]
    omega
  · intro x hx
    simp only [Finset.mem_Icc] at hx
    omega
  · intro x hx
    simp only [Finset.mem_range] at hx
    omega
  · intro x hx
    simp only [Finset.mem_Icc] at hx
    congr 1
    omega

/-- `6 Σ_{j < N} (A+j)(B+j)` in closed form. -/
private lemma six_mul_sum_range_quad (A B : ℤ) (N : ℕ) :
    6 * ∑ j ∈ Finset.range N, (A + (j : ℤ)) * (B + (j : ℤ))
      = 6 * (N : ℤ) * A * B + 3 * (A + B) * ((N : ℤ) * ((N : ℤ) - 1))
        + (N : ℤ) * ((N : ℤ) - 1) * (2 * (N : ℤ) - 1) := by
  induction N with
  | zero => simp
  | succ k ih =>
      rw [Finset.sum_range_succ, mul_add, ih]
      push_cast
      ring

/-- The `m ≥ 0` window sum. -/
private lemma six_mul_sum_window (m : ℤ) (hm : 0 ≤ m) :
    6 * ∑ p ∈ Finset.Icc (-1 : ℤ) (m - 2), (2 * m - p) * (-m - p) = -13 * (m ^ 3 - m) := by
  have hN : ((m.toNat : ℕ) : ℤ) = m := Int.toNat_of_nonneg hm
  have hset : Finset.Icc (-1 : ℤ) (m - 2)
      = Finset.Icc (-1 : ℤ) (-1 + ((m.toNat : ℕ) : ℤ) - 1) := by
    congr 1
    omega
  rw [hset, sum_Icc_eq_sum_range]
  have hcongr : ∀ j ∈ Finset.range m.toNat,
      (2 * m - (-1 + (j : ℤ))) * (-m - (-1 + (j : ℤ)))
        = ((-2 * m - 1) + (j : ℤ)) * ((m - 1) + (j : ℤ)) := fun j _ => by ring
  rw [Finset.sum_congr rfl hcongr, six_mul_sum_range_quad, hN]
  ring

/-- The `m < 0` window sum. -/
private lemma six_mul_sum_window_neg (m : ℤ) (hm : m < 0) :
    6 * ∑ p ∈ Finset.Icc (m - 1) (-2 : ℤ), (2 * m - p) * (-m - p) = 13 * (m ^ 3 - m) := by
  have hN : ((((-m).toNat) : ℕ) : ℤ) = -m := Int.toNat_of_nonneg (by omega)
  have hset : Finset.Icc (m - 1) (-2 : ℤ)
      = Finset.Icc (m - 1) ((m - 1) + ((((-m).toNat) : ℕ) : ℤ) - 1) := by
    congr 1
    omega
  rw [hset, sum_Icc_eq_sum_range]
  have hcongr : ∀ j ∈ Finset.range (-m).toNat,
      (2 * m - ((m - 1) + (j : ℤ))) * (-m - ((m - 1) + (j : ℤ)))
        = ((-m - 1) + (j : ℤ)) * ((-2 * -m - 1) + (j : ℤ)) := fun j _ => by ring
  rw [Finset.sum_congr rfl hcongr, six_mul_sum_range_quad, hN]
  ring

/-! ### The value of the ghost anomaly -/

lemma anomSummand_eq_zero_of_notMem_pos {m p : ℤ} (hm : 0 ≤ m)
    (hp : p ∉ Finset.Icc (-1 : ℤ) (m - 2)) : anomSummand m p = 0 := by
  simp only [Finset.mem_Icc, not_and_or, not_le] at hp
  have h : chi p - chi (p - m) = 0 := by
    simp only [chi]; split_ifs <;> omega
  simp [anomSummand, h]

lemma anomSummand_eq_zero_of_notMem_neg {m p : ℤ} (hm : m < 0)
    (hp : p ∉ Finset.Icc (m - 1) (-2 : ℤ)) : anomSummand m p = 0 := by
  simp only [Finset.mem_Icc, not_and_or, not_le] at hp
  have h : chi p - chi (p - m) = 0 := by
    simp only [chi]; split_ifs <;> omega
  simp [anomSummand, h]

/-- **The ghost anomaly is `−13 (m³ − m)/6 = (−26/12)(m³ − m)`**: the central charge of the
`λ = 2` `bc` system is `c = −26`. -/
theorem six_mul_ghostAnom (m : ℤ) : 6 * ghostAnom m = -13 * (m ^ 3 - m) := by
  by_cases hm : 0 ≤ m
  · have hsub : Finset.Icc (-1 : ℤ) (m - 2)
        ⊆ Finset.Icc (-((m.natAbs : ℤ) + 1)) ((m.natAbs : ℤ) + 1) :=
      Finset.Icc_subset_Icc (by omega) (by omega)
    have h1 : ghostAnom m = ∑ p ∈ Finset.Icc (-1 : ℤ) (m - 2), anomSummand m p :=
      (Finset.sum_subset hsub fun x _ hx => anomSummand_eq_zero_of_notMem_pos hm hx).symm
    have h2 : ∀ p ∈ Finset.Icc (-1 : ℤ) (m - 2), anomSummand m p = (2 * m - p) * (-m - p) := by
      intro p hp
      simp only [Finset.mem_Icc] at hp
      have h : chi p - chi (p - m) = 1 := by simp only [chi]; split_ifs <;> omega
      simp [anomSummand, h]
    rw [h1, Finset.sum_congr rfl h2]
    exact six_mul_sum_window m hm
  · replace hm : m < 0 := by omega
    have hsub : Finset.Icc (m - 1) (-2 : ℤ)
        ⊆ Finset.Icc (-((m.natAbs : ℤ) + 1)) ((m.natAbs : ℤ) + 1) :=
      Finset.Icc_subset_Icc (by omega) (by omega)
    have h1 : ghostAnom m = ∑ p ∈ Finset.Icc (m - 1) (-2 : ℤ), anomSummand m p :=
      (Finset.sum_subset hsub fun x _ hx => anomSummand_eq_zero_of_notMem_neg hm hx).symm
    have h2 : ∀ p ∈ Finset.Icc (m - 1) (-2 : ℤ),
        anomSummand m p = -((2 * m - p) * (-m - p)) := by
      intro p hp
      simp only [Finset.mem_Icc] at hp
      have h : chi p - chi (p - m) = -1 := by simp only [chi]; split_ifs <;> omega
      simp [anomSummand, h]
    rw [h1, Finset.sum_congr rfl h2, Finset.sum_neg_distrib]
    have := six_mul_sum_window_neg m hm
    linear_combination -this

/-! ### Numerical sanity checks on the anomaly

These are independent of `six_mul_ghostAnom` (they are `decide` on the defining finite sum) and
pin the sign: `z(2) = −13 = c/2` is the textbook `⟨0|L^g_2 L^g_{-2}|0⟩` for `c^g = −26`. -/

lemma ghostAnom_one : ghostAnom 1 = 0 := by decide

lemma ghostAnom_two : ghostAnom 2 = -13 := by decide

lemma ghostAnom_three : ghostAnom 3 = -52 := by decide

lemma ghostAnom_neg_two : ghostAnom (-2) = 13 := by decide

/-! ### The `bc` system and its `SL(2,ℂ)`-normal-ordered bilinears -/

section Operators

variable {R : Type*} [CommRing R] {M : Type*} [AddCommGroup M] [Module R M]

/-- The `λ = 2` `bc` anticommutation relations
`{b_m, c_n} = δ_{m+n,0}`, `{b_m, b_n} = 0`, `{c_m, c_n} = 0`
(`1 : Module.End R M` is the identity operator). -/
structure IsBCSystem (b c : ℤ → Module.End R M) : Prop where
  anticomm_bc : ∀ m n : ℤ, b m * c n + c n * b m = if m + n = 0 then 1 else 0
  anticomm_bb : ∀ m n : ℤ, b m * b n + b n * b m = 0
  anticomm_cc : ∀ m n : ℤ, c m * c n + c n * c m = 0

variable (b c : ℤ → Module.End R M)

lemma anticomm_bc' (hbc : IsBCSystem b c) (p q : ℤ) :
    c q * b p = ((kd (p + q) : ℤ) : R) • (1 : Module.End R M) - b p * c q := by
  refine eq_sub_of_add_eq' ?_
  rw [hbc.anticomm_bc p q]
  by_cases hpq : p + q = 0 <;> simp [kd, hpq]

lemma anticomm_bb' (hbc : IsBCSystem b c) (p r : ℤ) : b r * b p = -(b p * b r) :=
  eq_neg_of_add_eq_zero_left (hbc.anticomm_bb r p)

lemma anticomm_cc' (hbc : IsBCSystem b c) (q s : ℤ) : c s * c q = -(c q * c s) :=
  eq_neg_of_add_eq_zero_left (hbc.anticomm_cc s q)

/-- The `SL(2,ℂ)`-normal-ordered pair `:b_p c_q:` (convention `conv.ghost-normal-ordering-sl2c`).
Annihilation operators are moved to the right at the cost of a fermionic sign: `b_p` annihilates
the `SL(2,ℂ)` vacuum exactly when `p ≥ -1`, so `:b_p c_q: = -c_q b_p` in that range, while for
`p ≤ -2` the operator `b_p` is a creation operator and `:b_p c_q: = b_p c_q`. -/
def nord (p q : ℤ) : Module.End R M := if p ≤ -2 then b p * c q else -(c q * b p)

/-- Normal ordering subtracts a multiple of the identity from the naive product; the multiple is
nonzero only for the "diagonal" pairs `p + q = 0`, and then only when `b_p` is an annihilator. -/
lemma nord_eq (hbc : IsBCSystem b c) (p q : ℤ) :
    nord b c p q = b p * c q - ((chi p * kd (p + q) : ℤ) : R) • (1 : Module.End R M) := by
  by_cases hp : p ≤ -2
  · rw [nord, if_pos hp, chi, if_neg (by omega : ¬ (-1 : ℤ) ≤ p)]
    simp
  · rw [nord, if_neg hp, chi, if_pos (by omega : (-1 : ℤ) ≤ p), anticomm_bc' b c hbc p q,
      neg_sub, one_mul]

/-- The `gl(∞)` commutator of the *naive* bilinears: no central term. -/
lemma bc_mul_bc_sub (hbc : IsBCSystem b c) (p q r s : ℤ) :
    b p * c q * (b r * c s) - b r * c s * (b p * c q)
      = ((kd (q + r) : ℤ) : R) • (b p * c s) - ((kd (p + s) : ℤ) : R) • (b r * c q) := by
  have hbb : b r * b p = -(b p * b r) := anticomm_bb' b c hbc p r
  have hcc : c s * c q = -(c q * c s) := anticomm_cc' b c hbc q s
  have hqr : c q * b r = ((kd (q + r) : ℤ) : R) • (1 : Module.End R M) - b r * c q := by
    rw [kd_add_comm q r]; exact anticomm_bc' b c hbc r q
  have hsp : c s * b p = ((kd (p + s) : ℤ) : R) • (1 : Module.End R M) - b p * c s :=
    anticomm_bc' b c hbc p s
  calc b p * c q * (b r * c s) - b r * c s * (b p * c q)
      = b p * (c q * b r) * c s - b r * (c s * b p) * c q := by noncomm_ring
    _ = b p * (((kd (q + r) : ℤ) : R) • (1 : Module.End R M) - b r * c q) * c s
          - b r * (((kd (p + s) : ℤ) : R) • (1 : Module.End R M) - b p * c s) * c q := by
        rw [hqr, hsp]
    _ = ((kd (q + r) : ℤ) : R) • (b p * c s) - b p * b r * (c q * c s)
          - (((kd (p + s) : ℤ) : R) • (b r * c q) - b r * b p * (c s * c q)) := by
        simp only [mul_sub, sub_mul, mul_smul_comm, smul_mul_assoc, mul_one]
        rw [show b p * (b r * c q) * c s = b p * b r * (c q * c s) from by noncomm_ring,
          show b r * (b p * c s) * c q = b r * b p * (c s * c q) from by noncomm_ring]
    _ = ((kd (q + r) : ℤ) : R) • (b p * c s) - ((kd (p + s) : ℤ) : R) • (b r * c q) := by
        rw [hbb, hcc, neg_mul_neg]
        abel

/-- **The commutator of two normal-ordered bilinears**, with the normal-ordering anomaly.
This is the algebraic heart of the central charge: the last term is the `c`-number that the
`gl(∞)` cocycle acquires from the `SL(2,ℂ)` normal ordering. -/
theorem nord_bracket (hbc : IsBCSystem b c) (p q r s : ℤ) :
    nord b c p q * nord b c r s - nord b c r s * nord b c p q
      = ((kd (q + r) : ℤ) : R) • nord b c p s - ((kd (p + s) : ℤ) : R) • nord b c r q
        + ((kd (q + r) * kd (p + s) * (chi p - chi r) : ℤ) : R) • (1 : Module.End R M) := by
  have hLHS : nord b c p q * nord b c r s - nord b c r s * nord b c p q
      = b p * c q * (b r * c s) - b r * c s * (b p * c q) := by
    rw [nord_eq b c hbc p q, nord_eq b c hbc r s]
    simp only [mul_sub, sub_mul, smul_mul_assoc, mul_smul_comm, one_mul, mul_one, smul_sub]
    module
  rw [hLHS, bc_mul_bc_sub b c hbc, nord_eq b c hbc p s, nord_eq b c hbc r q, kd_add_comm r q]
  match_scalars <;> ring

/-! ### Restricted modules and the ghost Virasoro generators -/

/-- `M` is a **restricted** module for the `bc` system: every vector is annihilated by `b_n` and
`c_n` for all sufficiently large `n`.  (This is the one-sided condition; the parenthetical gloss
in the graph node's `statement` is too strong, see that node's notes (B).) -/
def IsRestricted (b c : ℤ → Module.End R M) : Prop :=
  ∀ v : M, ∃ N : ℕ, ∀ n : ℤ, (N : ℤ) < n → b n v = 0 ∧ c n v = 0

variable {b c}

/-- A choice of mode bound for each vector of a restricted module. -/
noncomputable def gbound (hres : IsRestricted b c) (v : M) : ℕ := (hres v).choose

lemma b_apply_eq_zero {hres : IsRestricted b c} {v : M} {p : ℤ}
    (hp : (gbound hres v : ℤ) < p) : b p v = 0 := ((hres v).choose_spec p hp).1

lemma c_apply_eq_zero {hres : IsRestricted b c} {v : M} {p : ℤ}
    (hp : (gbound hres v : ℤ) < p) : c p v = 0 := ((hres v).choose_spec p hp).2

/-- The window outside which `:b_p c_{k-p}:` annihilates `v`.  Note both ends are needed: for
`p ≥ -1` the operator `b_p` sits on the right and kills `v` once `p` is large, while for
`p ≤ -2` the operator `c_{k-p}` sits on the right and kills `v` once `-p` is large. -/
noncomputable def nordWindow (hres : IsRestricted b c) (k : ℤ) (v : M) : Finset ℤ :=
  Finset.Icc (min (-1) (k - (gbound hres v : ℤ))) (gbound hres v : ℤ)

lemma nord_apply_eq_zero_of_notMem (hres : IsRestricted b c) (k p : ℤ) (v : M)
    (hp : p ∉ nordWindow hres k v) : nord b c p (k - p) v = 0 := by
  rw [nordWindow, Finset.mem_Icc, not_and_or, not_le, not_le] at hp
  rcases hp with hp | hp
  · rw [nord, if_pos (by omega : p ≤ -2), Module.End.mul_apply,
      c_apply_eq_zero (hres := hres) (by omega), map_zero]
  · rw [nord, if_neg (by omega : ¬ p ≤ -2), LinearMap.neg_apply, Module.End.mul_apply,
      b_apply_eq_zero (hres := hres) (by omega), map_zero, neg_zero]

/-- The `p`-th term of `L^g_k = Σ_p (2k − p) :b_p c_{k−p}:`. -/
noncomputable def ghostTerm (b c : ℤ → Module.End R M) (k p : ℤ) : Module.End R M :=
  ((2 * k - p : ℤ) : R) • nord b c p (k - p)

lemma ghostTerm_apply (k p : ℤ) (v : M) :
    ghostTerm b c k p v = ((2 * k - p : ℤ) : R) • nord b c p (k - p) v := rfl

lemma ghostTerm_apply_eq_zero_of_notMem (hres : IsRestricted b c) (k p : ℤ) (v : M)
    (hp : p ∉ nordWindow hres k v) : ghostTerm b c k p v = 0 := by
  rw [ghostTerm_apply, nord_apply_eq_zero_of_notMem hres k p v hp, smul_zero]

/-- **The ghost Virasoro generators** `L^g_k = Σ_{p ∈ ℤ} (2k − p) :b_p c_{k−p}:`, which is the
card's `Σ_{n ∈ ℤ} (k − n) :b_{k+n} c_{−n}:` after `p = k + n`.  The formally infinite sum is a
finite sum on every vector because the module is restricted. -/
noncomputable def Lop (hres : IsRestricted b c) (k : ℤ) : Module.End R M :=
  lsumLocFin (fun p => ghostTerm b c k p) (nordWindow hres k)
    (fun v p hp => ghostTerm_apply_eq_zero_of_notMem hres k p v hp)

/-- `L^g_k` is computed by *any* finite window large enough for the given vector. -/
lemma Lop_apply (hres : IsRestricted b c) (k : ℤ) (v : M) {s : Finset ℤ}
    (hs : ∀ p ∉ s, ghostTerm b c k p v = 0) :
    Lop hres k v = ∑ p ∈ s, ghostTerm b c k p v :=
  lsumLocFin_apply _ _ _ v hs

/-- The index dictionary between the two ways of writing the ghost generator: the `p = k + n`
term of `Σ_p (2k − p) :b_p c_{k−p}:` is the `n`-th term of `Σ_n (k − n) :b_{k+n} c_{−n}:`, which
is the form used in the graph node (and in FGZ Prop. 2.1(ii)). -/
lemma ghostTerm_shift_apply (k n : ℤ) (v : M) :
    ghostTerm b c k (k + n) v = ((k - n : ℤ) : R) • nord b c (k + n) (-n) v := by
  rw [ghostTerm_apply, show (2 * k - (k + n) : ℤ) = k - n by ring, show k - (k + n) = -n by ring]

/-- `L^g_k` in the graph node's own indexing: `L^g_k v = Σ_n (k − n) :b_{k+n} c_{−n}: v`, the sum
over any finite set of `n` large enough for `v`. -/
lemma Lop_apply_shift (hres : IsRestricted b c) (k : ℤ) (v : M) {s : Finset ℤ}
    (hs : ∀ n ∉ s, ghostTerm b c k (k + n) v = 0) :
    Lop hres k v = ∑ n ∈ s, ((k - n : ℤ) : R) • nord b c (k + n) (-n) v := by
  have himg : Lop hres k v = ∑ p ∈ s.image (fun n => k + n), ghostTerm b c k p v := by
    refine Lop_apply hres k v fun p hp => ?_
    have hns : p - k ∉ s := fun h => hp (Finset.mem_image.2 ⟨p - k, h, by ring⟩)
    have h := hs (p - k) hns
    rwa [show k + (p - k) = p by ring] at h
  rw [himg, Finset.sum_image (fun x _ y _ h => by omega)]
  exact Finset.sum_congr rfl fun n _ => ghostTerm_shift_apply k n v

/-! ### The commutator of two ghost terms -/

lemma ghostTerm_mul (k l p r : ℤ) :
    ghostTerm b c k p * ghostTerm b c l r
      = (((2 * k - p) * (2 * l - r) : ℤ) : R) • (nord b c p (k - p) * nord b c r (l - r)) := by
  rw [ghostTerm, ghostTerm, smul_mul_assoc, mul_smul_comm, smul_smul]
  congr 1
  push_cast
  ring

lemma ghostTerm_bracket_apply (hbc : IsBCSystem b c) (k l p r : ℤ) (v : M) :
    ghostTerm b c k p (ghostTerm b c l r v) - ghostTerm b c l r (ghostTerm b c k p v)
      = (((2 * k - p) * (2 * l - r) * kd ((k - p) + r) : ℤ) : R) • nord b c p (l - r) v
        - (((2 * k - p) * (2 * l - r) * kd (p + (l - r)) : ℤ) : R) • nord b c r (k - p) v
        + (((2 * k - p) * (2 * l - r)
            * (kd ((k - p) + r) * kd (p + (l - r)) * (chi p - chi r)) : ℤ) : R) • v := by
  have hop : ghostTerm b c k p * ghostTerm b c l r - ghostTerm b c l r * ghostTerm b c k p
      = (((2 * k - p) * (2 * l - r) : ℤ) : R) •
          (((kd ((k - p) + r) : ℤ) : R) • nord b c p (l - r)
            - ((kd (p + (l - r)) : ℤ) : R) • nord b c r (k - p)
            + ((kd ((k - p) + r) * kd (p + (l - r)) * (chi p - chi r) : ℤ) : R)
                • (1 : Module.End R M)) := by
    rw [ghostTerm_mul, ghostTerm_mul,
      show ((2 * l - r) * (2 * k - p) : ℤ) = ((2 * k - p) * (2 * l - r) : ℤ) from mul_comm _ _,
      ← smul_sub, nord_bracket b c hbc p (k - p) r (l - r)]
  have happ := congrArg (fun X : Module.End R M => X v) hop
  simp only [LinearMap.sub_apply, Module.End.mul_apply, LinearMap.add_apply,
    LinearMap.smul_apply, Module.End.one_apply, smul_sub, smul_add, smul_smul] at happ
  rw [happ]
  push_cast
  module

/-! ### Collapsing the double sum -/

/-- The `δ_{(k−p)+r,0}` term of the double sum for `[L^g_m, L^g_n]`. -/
private noncomputable def uTerm (b c : ℤ → Module.End R M) (m n p r : ℤ) (v : M) : M :=
  (((2 * m - p) * (2 * n - r) * kd ((m - p) + r) : ℤ) : R) • nord b c p (n - r) v

/-- The `δ_{p+(n−r),0}` term of the double sum for `[L^g_m, L^g_n]`. -/
private noncomputable def vTerm (b c : ℤ → Module.End R M) (m n p r : ℤ) (v : M) : M :=
  (((2 * m - p) * (2 * n - r) * kd (p + (n - r)) : ℤ) : R) • nord b c r (m - p) v

/-- The normal-ordering (central) term of the double sum for `[L^g_m, L^g_n]`. -/
private noncomputable def wTerm (_b _c : ℤ → Module.End R M) (m n p r : ℤ) (v : M) : M :=
  (((2 * m - p) * (2 * n - r)
      * (kd ((m - p) + r) * kd (p + (n - r)) * (chi p - chi r)) : ℤ) : R) • v

private lemma bracket_eq_terms (hbc : IsBCSystem b c) (m n p r : ℤ) (v : M) :
    ghostTerm b c m p (ghostTerm b c n r v) - ghostTerm b c n r (ghostTerm b c m p v)
      = uTerm b c m n p r v - vTerm b c m n p r v + wTerm b c m n p r v :=
  ghostTerm_bracket_apply hbc m n p r v

/-- The inner sum of the first term collapses to `r = p − m`, i.e. to the `p`-th mode of
`L^g_{m+n}`. -/
private lemma sum_uTerm (m n : ℤ) (v : M) (K p : ℤ) (hp1 : -K ≤ p) (hp2 : p ≤ K)
    (hedge : ∀ q : ℤ, -K ≤ q → q ≤ K → (q - m < -K ∨ K < q - m) →
        nord b c q ((m + n) - q) v = 0) :
    ∑ r ∈ Finset.Icc (-K) K, uTerm b c m n p r v
      = (((2 * m - p) * (2 * n + m - p) : ℤ) : R) • nord b c p ((m + n) - p) v := by
  have hcollapse : ∑ r ∈ Finset.Icc (-K) K, uTerm b c m n p r v
      = if p - m ∈ Finset.Icc (-K) K then
          (((2 * m - p) * (2 * n - (p - m)) : ℤ) : R) • nord b c p (n - (p - m)) v else 0 := by
    rw [← Finset.sum_ite_eq' (Finset.Icc (-K) K) (p - m)
      (fun r => (((2 * m - p) * (2 * n - r) : ℤ) : R) • nord b c p (n - r) v)]
    refine Finset.sum_congr rfl fun r _ => ?_
    by_cases hr : r = p - m
    · rw [uTerm, kd_of_eq_zero (show (m - p) + r = 0 by omega), if_pos hr]
      congr 1
      push_cast
      ring
    · rw [if_neg hr, uTerm, kd_of_ne_zero (show (m - p) + r ≠ 0 by omega)]
      simp
  rw [hcollapse]
  have hidx : n - (p - m) = (m + n) - p := by ring
  have hcoef : ((2 * m - p) * (2 * n - (p - m)) : ℤ) = ((2 * m - p) * (2 * n + m - p) : ℤ) := by
    ring
  by_cases hmem : p - m ∈ Finset.Icc (-K) K
  · rw [if_pos hmem, hidx, hcoef]
  · rw [if_neg hmem, hedge p hp1 hp2 (by simp only [Finset.mem_Icc] at hmem; omega), smul_zero]

/-- The inner sum of the second term collapses to `p = r − n`, again to the `r`-th mode of
`L^g_{m+n}`. -/
private lemma sum_vTerm (m n : ℤ) (v : M) (K r : ℤ) (hr1 : -K ≤ r) (hr2 : r ≤ K)
    (hedge : ∀ q : ℤ, -K ≤ q → q ≤ K → (q - n < -K ∨ K < q - n) →
        nord b c q ((m + n) - q) v = 0) :
    ∑ p ∈ Finset.Icc (-K) K, vTerm b c m n p r v
      = (((2 * m + n - r) * (2 * n - r) : ℤ) : R) • nord b c r ((m + n) - r) v := by
  have hcollapse : ∑ p ∈ Finset.Icc (-K) K, vTerm b c m n p r v
      = if r - n ∈ Finset.Icc (-K) K then
          (((2 * m - (r - n)) * (2 * n - r) : ℤ) : R) • nord b c r (m - (r - n)) v else 0 := by
    rw [← Finset.sum_ite_eq' (Finset.Icc (-K) K) (r - n)
      (fun p => (((2 * m - p) * (2 * n - r) : ℤ) : R) • nord b c r (m - p) v)]
    refine Finset.sum_congr rfl fun p _ => ?_
    by_cases hp : p = r - n
    · rw [vTerm, kd_of_eq_zero (show p + (n - r) = 0 by omega), if_pos hp]
      congr 1
      push_cast
      ring
    · rw [if_neg hp, vTerm, kd_of_ne_zero (show p + (n - r) ≠ 0 by omega)]
      simp
  rw [hcollapse]
  have hidx : m - (r - n) = (m + n) - r := by ring
  have hcoef : ((2 * m - (r - n)) * (2 * n - r) : ℤ) = ((2 * m + n - r) * (2 * n - r) : ℤ) := by
    ring
  by_cases hmem : r - n ∈ Finset.Icc (-K) K
  · rw [if_pos hmem, hidx, hcoef]
  · rw [if_neg hmem, hedge r hr1 hr2 (by simp only [Finset.mem_Icc] at hmem; omega), smul_zero]

/-- The inner sum of the central term collapses to `r = p − m`; the surviving `δ_{m+n,0}` is what
restricts the anomaly to `n = −m`. -/
private lemma sum_wTerm (m n : ℤ) (v : M) (K p : ℤ) (hp1 : -K ≤ p) (hp2 : p ≤ K)
    (hedge : ∀ q : ℤ, -K ≤ q → q ≤ K → (q - m < -K ∨ K < q - m) → chi q - chi (q - m) = 0) :
    ∑ r ∈ Finset.Icc (-K) K, wTerm b c m n p r v
      = (((2 * m - p) * (2 * n + m - p) * kd (m + n) * (chi p - chi (p - m)) : ℤ) : R) • v := by
  have hcollapse : ∑ r ∈ Finset.Icc (-K) K, wTerm b c m n p r v
      = if p - m ∈ Finset.Icc (-K) K then
          (((2 * m - p) * (2 * n + m - p) * kd (m + n) * (chi p - chi (p - m)) : ℤ) : R) • v
        else 0 := by
    rw [← Finset.sum_ite_eq' (Finset.Icc (-K) K) (p - m)
      (fun _ => (((2 * m - p) * (2 * n + m - p) * kd (m + n)
        * (chi p - chi (p - m)) : ℤ) : R) • v)]
    refine Finset.sum_congr rfl fun r _ => ?_
    by_cases hr : r = p - m
    · rw [wTerm, kd_of_eq_zero (show (m - p) + r = 0 by omega),
        show p + (n - r) = m + n by omega, if_pos hr, hr]
      congr 1
      push_cast
      ring
    · rw [if_neg hr, wTerm, kd_of_ne_zero (show (m - p) + r ≠ 0 by omega)]
      simp
  rw [hcollapse]
  by_cases hmem : p - m ∈ Finset.Icc (-K) K
  · rw [if_pos hmem]
  · rw [if_neg hmem, hedge p hp1 hp2 (by simp only [Finset.mem_Icc] at hmem; omega)]
    simp

/-- The anomaly sum does not depend on the window, as long as the window is large enough. -/
lemma sum_anomSummand_eq_ghostAnom (m K : ℤ) (hK : (m.natAbs : ℤ) + 1 ≤ K) :
    ∑ p ∈ Finset.Icc (-K) K, anomSummand m p = ghostAnom m := by
  refine (Finset.sum_subset (Finset.Icc_subset_Icc (by omega) (by omega)) ?_).symm
  intro x _ hx
  simp only [Finset.mem_Icc] at hx
  by_cases hm : 0 ≤ m
  · exact anomSummand_eq_zero_of_notMem_pos hm (by simp only [Finset.mem_Icc]; omega)
  · exact anomSummand_eq_zero_of_notMem_neg (by omega) (by simp only [Finset.mem_Icc]; omega)

private lemma sum_sum_wTerm (m n : ℤ) (v : M) (K : ℤ) (hK : (m.natAbs : ℤ) + 1 ≤ K)
    (hedge : ∀ q : ℤ, -K ≤ q → q ≤ K → (q - m < -K ∨ K < q - m) → chi q - chi (q - m) = 0) :
    ∑ p ∈ Finset.Icc (-K) K, ∑ r ∈ Finset.Icc (-K) K, wTerm b c m n p r v
      = ((kd (m + n) * ghostAnom m : ℤ) : R) • v := by
  rw [Finset.sum_congr rfl fun p hp => by
    simp only [Finset.mem_Icc] at hp
    exact sum_wTerm (b := b) (c := c) m n v K p hp.1 hp.2 hedge]
  by_cases hmn : m + n = 0
  · have hn : n = -m := by omega
    subst hn
    rw [kd_of_eq_zero (show m + -m = 0 by omega), ← Finset.sum_smul,
      ← sum_anomSummand_eq_ghostAnom m K hK, one_mul]
    congr 1
    push_cast
    refine Finset.sum_congr rfl fun p _ => ?_
    rw [anomSummand]
    push_cast
    ring
  · simp [kd_of_ne_zero hmn]

/-- The two non-central sums combine into `(m − n) L^g_{m+n}`. -/
private lemma sum_sub_sum_eq (m n : ℤ) (v : M) (K : ℤ) :
    (∑ x ∈ Finset.Icc (-K) K,
        (((2 * m - x) * (2 * n + m - x) : ℤ) : R) • nord b c x ((m + n) - x) v)
      - (∑ x ∈ Finset.Icc (-K) K,
        (((2 * m + n - x) * (2 * n - x) : ℤ) : R) • nord b c x ((m + n) - x) v)
      = ((m - n : ℤ) : R) • ∑ x ∈ Finset.Icc (-K) K, ghostTerm b c (m + n) x v := by
  rw [← Finset.sum_sub_distrib, Finset.smul_sum]
  refine Finset.sum_congr rfl fun x _ => ?_
  rw [ghostTerm_apply, smul_smul, ← sub_smul]
  congr 1
  push_cast
  ring

/-! ### The Virasoro relations for the ghost system -/

/-- The central coefficient of the ghost Virasoro bracket, as it comes out of the computation:
`z(m,n) = δ_{m+n,0} · (the normal-ordering anomaly sum)`. -/
noncomputable def ghostVirCoeff (R : Type*) [CommRing R] (m n : ℤ) : R :=
  ((kd (m + n) * ghostAnom m : ℤ) : R)

/-- **The ghost Virasoro relations, evaluated on a vector.**
`[L^g_m, L^g_n] v = (m − n) L^g_{m+n} v + z(m,n) v`. -/
theorem lie_Lop_Lop_apply (hbc : IsBCSystem b c) (hres : IsRestricted b c) (m n : ℤ) (v : M) :
    Lop hres m (Lop hres n v) - Lop hres n (Lop hres m v)
      = ((m - n : ℤ) : R) • Lop hres (m + n) v + ghostVirCoeff R m n • v := by
  obtain ⟨K, hK1, hK2, hK3, hK4, hK5, hK6, hK7, hK8⟩ :
      ∃ K : ℤ, nordWindow hres n v ⊆ Finset.Icc (-K) K
        ∧ nordWindow hres m v ⊆ Finset.Icc (-K) K
        ∧ nordWindow hres m (Lop hres n v) ⊆ Finset.Icc (-K) K
        ∧ nordWindow hres n (Lop hres m v) ⊆ Finset.Icc (-K) K
        ∧ nordWindow hres (m + n) v ⊆ Finset.Icc (-K) K
        ∧ (∀ q : ℤ, -K ≤ q → q ≤ K → (q - m < -K ∨ K < q - m) →
              nord b c q ((m + n) - q) v = 0 ∧ chi q - chi (q - m) = 0)
        ∧ (∀ q : ℤ, -K ≤ q → q ≤ K → (q - n < -K ∨ K < q - n) →
              nord b c q ((m + n) - q) v = 0)
        ∧ (m.natAbs : ℤ) + 1 ≤ K := by
    refine ⟨(gbound hres v : ℤ) + (gbound hres (Lop hres n v) : ℤ)
        + (gbound hres (Lop hres m v) : ℤ) + 2 * ((m.natAbs : ℤ) + (n.natAbs : ℤ)) + 2,
      ?_, ?_, ?_, ?_, ?_, ?_, ?_, by omega⟩
    · simp only [nordWindow]; exact Finset.Icc_subset_Icc (by omega) (by omega)
    · simp only [nordWindow]; exact Finset.Icc_subset_Icc (by omega) (by omega)
    · simp only [nordWindow]; exact Finset.Icc_subset_Icc (by omega) (by omega)
    · simp only [nordWindow]; exact Finset.Icc_subset_Icc (by omega) (by omega)
    · simp only [nordWindow]; exact Finset.Icc_subset_Icc (by omega) (by omega)
    · intro q h1 h2 h3
      refine ⟨nord_apply_eq_zero_of_notMem hres (m + n) q v ?_, ?_⟩
      · simp only [nordWindow, Finset.mem_Icc]; omega
      · simp only [chi]; split_ifs <;> omega
    · intro q h1 h2 h3
      refine nord_apply_eq_zero_of_notMem hres (m + n) q v ?_
      simp only [nordWindow, Finset.mem_Icc]; omega
  have hP : ∀ (k : ℤ) (w : M), nordWindow hres k w ⊆ Finset.Icc (-K) K →
      Lop hres k w = ∑ p ∈ Finset.Icc (-K) K, ghostTerm b c k p w := fun k w hw =>
    Lop_apply hres k w fun p hp =>
      ghostTerm_apply_eq_zero_of_notMem hres k p w fun hmem => hp (hw hmem)
  have hwn : Lop hres n v = ∑ r ∈ Finset.Icc (-K) K, ghostTerm b c n r v := hP n v hK1
  have hwm : Lop hres m v = ∑ p ∈ Finset.Icc (-K) K, ghostTerm b c m p v := hP m v hK2
  have hwmn : Lop hres (m + n) v = ∑ p ∈ Finset.Icc (-K) K, ghostTerm b c (m + n) p v :=
    hP (m + n) v hK5
  have hd1 : Lop hres m (Lop hres n v)
      = ∑ p ∈ Finset.Icc (-K) K, ∑ r ∈ Finset.Icc (-K) K,
          ghostTerm b c m p (ghostTerm b c n r v) := by
    rw [hP m (Lop hres n v) hK3]
    exact Finset.sum_congr rfl fun p _ => by rw [hwn, map_sum]
  have hd2 : Lop hres n (Lop hres m v)
      = ∑ p ∈ Finset.Icc (-K) K, ∑ r ∈ Finset.Icc (-K) K,
          ghostTerm b c n r (ghostTerm b c m p v) := by
    rw [Finset.sum_comm, hP n (Lop hres m v) hK4]
    exact Finset.sum_congr rfl fun r _ => by rw [hwm, map_sum]
  have hsplit : Lop hres m (Lop hres n v) - Lop hres n (Lop hres m v)
      = (∑ p ∈ Finset.Icc (-K) K, ∑ r ∈ Finset.Icc (-K) K, uTerm b c m n p r v)
        - (∑ p ∈ Finset.Icc (-K) K, ∑ r ∈ Finset.Icc (-K) K, vTerm b c m n p r v)
        + ∑ p ∈ Finset.Icc (-K) K, ∑ r ∈ Finset.Icc (-K) K, wTerm b c m n p r v := by
    have h0 : ∑ p ∈ Finset.Icc (-K) K, ∑ r ∈ Finset.Icc (-K) K,
          (uTerm b c m n p r v - vTerm b c m n p r v + wTerm b c m n p r v)
        = (∑ p ∈ Finset.Icc (-K) K, ∑ r ∈ Finset.Icc (-K) K, uTerm b c m n p r v)
          - (∑ p ∈ Finset.Icc (-K) K, ∑ r ∈ Finset.Icc (-K) K, vTerm b c m n p r v)
          + ∑ p ∈ Finset.Icc (-K) K, ∑ r ∈ Finset.Icc (-K) K, wTerm b c m n p r v := by
      simp only [Finset.sum_add_distrib, Finset.sum_sub_distrib]
    rw [hd1, hd2, ← h0, ← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl fun p _ => ?_
    rw [← Finset.sum_sub_distrib]
    exact Finset.sum_congr rfl fun r _ => bracket_eq_terms hbc m n p r v
  have hu : (∑ p ∈ Finset.Icc (-K) K, ∑ r ∈ Finset.Icc (-K) K, uTerm b c m n p r v)
      = ∑ x ∈ Finset.Icc (-K) K,
          (((2 * m - x) * (2 * n + m - x) : ℤ) : R) • nord b c x ((m + n) - x) v :=
    Finset.sum_congr rfl fun p hp => by
      simp only [Finset.mem_Icc] at hp
      exact sum_uTerm m n v K p hp.1 hp.2 fun q h1 h2 h3 => (hK6 q h1 h2 h3).1
  have hv : (∑ p ∈ Finset.Icc (-K) K, ∑ r ∈ Finset.Icc (-K) K, vTerm b c m n p r v)
      = ∑ x ∈ Finset.Icc (-K) K,
          (((2 * m + n - x) * (2 * n - x) : ℤ) : R) • nord b c x ((m + n) - x) v := by
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun r hr => by
      simp only [Finset.mem_Icc] at hr
      exact sum_vTerm m n v K r hr.1 hr.2 hK7
  have hw : (∑ p ∈ Finset.Icc (-K) K, ∑ r ∈ Finset.Icc (-K) K, wTerm b c m n p r v)
      = ((kd (m + n) * ghostAnom m : ℤ) : R) • v :=
    sum_sum_wTerm m n v K hK8 fun q h1 h2 h3 => (hK6 q h1 h2 h3).2
  rw [hsplit, hu, hv, hw, sum_sub_sum_eq, hwmn, ghostVirCoeff]

/-- **The ghost Virasoro relations as an operator identity.** -/
theorem lie_Lop_Lop_coeff (hbc : IsBCSystem b c) (hres : IsRestricted b c) (m n : ℤ) :
    ⁅Lop hres m, Lop hres n⁆
      = ((m - n : ℤ) : R) • Lop hres (m + n)
        + ghostVirCoeff R m n • (1 : Module.End R M) := by
  ext v
  rw [LieRing.of_associative_ring_bracket]
  simp only [LinearMap.sub_apply, Module.End.mul_apply, LinearMap.add_apply,
    LinearMap.smul_apply, Module.End.one_apply]
  exact lie_Lop_Lop_apply hbc hres m n v

end Operators

/-! ### The central charge is `−26` -/

section CentralCharge

variable {R : Type*} [CommRing R] [Algebra ℚ R] {M : Type*} [AddCommGroup M] [Module R M]
variable {b c : ℤ → Module.End R M}

/-- **The central charge of the `λ = 2` `bc` ghost system is `c^g = −26`.**

The scalar occurring in `[L^g_m, L^g_n]` is `(−26/12) (m³ − m) δ_{m+n,0}`, i.e. exactly the
Virasoro central term of `conv.virasoro-standard` at `c = −26`
(graph node `worldsheet.bc-ghost-central-charge-lambda-two`, normal ordering
`conv.ghost-normal-ordering-sl2c`). -/
theorem ghostVirCoeff_eq (m n : ℤ) :
    ghostVirCoeff R m n
      = if m + n = 0 then algebraMap ℚ R (-26 / 12) * ((m ^ 3 - m : ℤ) : R) else 0 := by
  rw [ghostVirCoeff]
  by_cases hmn : m + n = 0
  · rw [if_pos hmn, kd_of_eq_zero hmn, one_mul]
    have h6 : (6 : R) * ((ghostAnom m : ℤ) : R) = -13 * ((m ^ 3 - m : ℤ) : R) := by
      have h := congrArg (fun z : ℤ => (z : R)) (six_mul_ghostAnom m)
      push_cast at h ⊢
      linear_combination h
    have hinv : (6 : R) * algebraMap ℚ R (1 / 6) = 1 := by
      rw [← map_ofNat (algebraMap ℚ R) 6, ← map_mul, show (6 : ℚ) * (1 / 6) = 1 by norm_num,
        map_one]
    have h13 : algebraMap ℚ R (-13) = (-13 : R) := by
      rw [show (-13 : ℚ) = ((-13 : ℤ) : ℚ) by norm_num, map_intCast]
      norm_num
    have hstep : algebraMap ℚ R (-26 / 12) = algebraMap ℚ R (1 / 6) * (-13 : R) := by
      rw [← h13, ← map_mul]
      congr 1
      norm_num
    calc ((ghostAnom m : ℤ) : R)
        = algebraMap ℚ R (1 / 6) * ((6 : R) * ((ghostAnom m : ℤ) : R)) := by
          rw [← mul_assoc, mul_comm (algebraMap ℚ R (1 / 6)) (6 : R), hinv, one_mul]
      _ = algebraMap ℚ R (1 / 6) * (-13 * ((m ^ 3 - m : ℤ) : R)) := by rw [h6]
      _ = algebraMap ℚ R (-26 / 12) * ((m ^ 3 - m : ℤ) : R) := by rw [hstep, mul_assoc]
  · rw [if_neg hmn, kd_of_ne_zero hmn]
    simp

/-- The same statement in the repository's Virasoro normalisation:
`Virasoro.centralTerm R m = (m³ − m)/12`, so the central charge is the scalar `−26`. -/
theorem ghostVirCoeff_eq_centralTerm (m n : ℤ) :
    ghostVirCoeff R m n = if m + n = 0 then (-26 : R) * Virasoro.centralTerm R m else 0 := by
  rw [ghostVirCoeff_eq]
  by_cases hmn : m + n = 0
  · rw [if_pos hmn, if_pos hmn, Virasoro.centralTerm, Virasoro.inv12, ← mul_assoc]
    congr 1
    rw [show (-26 : R) = algebraMap ℚ R (-26) by
      rw [show (-26 : ℚ) = ((-26 : ℤ) : ℚ) by norm_num, map_intCast]; norm_num, ← map_mul]
    congr 1
    norm_num
  · rw [if_neg hmn, if_neg hmn]

/-- **The `λ = 2` `bc` ghost system satisfies the Virasoro algebra with `c^g = −26`**
(graph node `worldsheet.bc-ghost-central-charge-lambda-two`):
`[L^g_m, L^g_n] = (m − n) L^g_{m+n} + (−26/12)(m³ − m) δ_{m+n,0}`. -/
theorem lie_Lop_Lop (hbc : IsBCSystem b c) (hres : IsRestricted b c) (m n : ℤ) :
    ⁅Lop hres m, Lop hres n⁆
      = ((m - n : ℤ) : R) • Lop hres (m + n)
        + (if m + n = 0 then algebraMap ℚ R (-26 / 12) * ((m ^ 3 - m : ℤ) : R) else 0)
          • (1 : Module.End R M) := by
  rw [lie_Lop_Lop_coeff hbc hres, ghostVirCoeff_eq]

end CentralCharge

end StringFormal.NoGhost.Ghost
