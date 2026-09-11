/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import Mathlib.LinearAlgebra.Matrix.Rank
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.LinearAlgebra.Matrix.Notation
import Mathlib.Tactic.FinCases
import Mathlib.Tactic.LinearCombination

/-!
# IIB gravitational anomaly cancellation: the full linear algebra

Graph node: `consistency.iib-anomaly-solution-unique` (TODO item A8′).
Lean island 2 (`Math/`), standalone: imports only Mathlib.

## What is proved

Bilal, *Lectures on Anomalies* (2008), §12.2 eq. (12.4) writes the three conditions for
cancellation of the purely gravitational `d = 10` anomaly of a chiral field content
`(n_{3/2}, n_{1/2}, n_A)` — gravitini **56**, Majorana–Weyl fermions **8**, self-dual
tensors `[5]₊`, each net of parity conjugates — as the linear system `A · n = 0` with

```
A = ⎛ -495   1   992 ⎞
    ⎜  225   1  -448 ⎟
    ⎝  -63   1   128 ⎠
```

(the same system as Polchinski (12.2.11)–(12.2.14); see
`StringFormal/Math/AnomalyPolynomial.lean`, where these rows appear as the coefficients
of the three independent monomials `tr R₂⁶`, `tr R₂⁴ tr R₂²`, `[tr R₂²]³`).

* `iib_rows_relation` — the explicit linear dependence `2·row₀ + 3·row₁ − 5·row₂ = 0`.
* `iib_det_zero` — hence `det A = 0`, over any commutative ring.
* `iib_kernel_eq` / `iib_kernel_eq_int` — `A · x = 0 ↔ x = t · (2, −2, 1)` over `ℚ`,
  resp. over `ℤ`. This is the uniqueness statement: the solution set is *exactly* the
  ray through the IIB content, nothing else.
* `iib_ker_mulVecLin` — the same as an equality of submodules, `ker A = span {(2,−2,1)}`.
* `iib_rank_eq_two` — `A.rank = 2`.
* `iib_kernel_eq_of_field` / `iib_ker_mulVecLin_of_field` / `iib_rank_eq_two_of_field` — the
  same three statements over an arbitrary field of characteristic zero, of which the `ℚ`
  versions are instances.  The proofs need only `(720 : K) ≠ 0`
  (`iib_kernel_eq_of_720_ne_zero`, `iib_rank_eq_two_of_720_ne_zero`); see the note before
  the `Field` section for what happens in small characteristic.
* `iib_minor_01_01_det` — a witnessing nonvanishing 2×2 minor, `−720`.

## Why this is worth stating

Both standard references *assert* the degeneracy without exhibiting it. Bilal writes
"Amazingly, these three equations are not linearly independent"; Polchinski writes that
"the coefficients of these conspire to produce zero total anomaly" and calls the
cancellation accidental. Neither displays the linear relation, the rank, or a uniqueness
claim. `iib_rows_relation` is that relation, with integer coefficients `(2, 3, −5)`.

The rank being **2, not 3**, means the bookkeeping "three conditions on three unknowns,
so generically only the zero solution" overstates the miracle: a one-dimensional solution
space is what a rank-2 system on three unknowns must have. What is genuinely special is
that the ray passes through the small integers `(2, −2, 1)` realised by IIB supergravity,
and that this vector is primitive (`gcd = 1`), so over `ℤ` there is no divisibility
obstruction — `iib_kernel_eq_int` gives the integer solutions as exactly `ℤ · (2,−2,1)`.

## Scope

Purely a fact about a `3 × 3` integer matrix. Nothing here says the rows *are* the
gravitational anomaly coefficients: that input is physics (index theorem plus the `Î`
polynomials), recorded in `AnomalyPolynomial.lean` and in the graph node, and is not
re-derived here.
-/

namespace StringFormal.Math

open Matrix

/-- The coefficient matrix of the three IIB gravitational anomaly cancellation
conditions, Bilal (12.4), acting on `(n_{3/2}, n_{1/2}, n_A)`. -/
def iibAnomalyMatrix (R : Type*) [CommRing R] : Matrix (Fin 3) (Fin 3) R :=
  !![-495, 1, 992; 225, 1, -448; -63, 1, 128]

/-- The type IIB chiral field content `(n_{3/2}, n_{1/2}, n_A) = (2, -2, 1)`. -/
def iibSolutionVector (R : Type*) [CommRing R] : Fin 3 → R := ![2, -2, 1]

@[simp] theorem iibSolutionVector_zero (R : Type*) [CommRing R] :
    iibSolutionVector R 0 = 2 := rfl

@[simp] theorem iibSolutionVector_one (R : Type*) [CommRing R] :
    iibSolutionVector R 1 = -2 := rfl

@[simp] theorem iibSolutionVector_two (R : Type*) [CommRing R] :
    iibSolutionVector R 2 = 1 := rfl

/-- **The linear relation Bilal asserts but does not display.** The three rows of the
IIB anomaly matrix satisfy `2·row₀ + 3·row₁ − 5·row₂ = 0`. -/
theorem iib_rows_relation (R : Type*) [CommRing R] :
    (2 : R) • iibAnomalyMatrix R 0 + (3 : R) • iibAnomalyMatrix R 1
      - (5 : R) • iibAnomalyMatrix R 2 = 0 := by
  funext j
  fin_cases j <;> simp [iibAnomalyMatrix] <;> ring

/-- The IIB anomaly matrix is singular, over any commutative ring. -/
theorem iib_det_zero (R : Type*) [CommRing R] : (iibAnomalyMatrix R).det = 0 := by
  simp [iibAnomalyMatrix, Matrix.det_fin_three]
  ring

/-- The upper-left `2 × 2` minor has determinant `-720`; together with `iib_det_zero`
this pins the rank at exactly two (over a ring where `720 ≠ 0`). -/
theorem iib_minor_01_01_det (R : Type*) [CommRing R] :
    iibAnomalyMatrix R 0 0 * iibAnomalyMatrix R 1 1
      - iibAnomalyMatrix R 0 1 * iibAnomalyMatrix R 1 0 = -720 := by
  simp [iibAnomalyMatrix]
  ring

/-- The matrix-vector product, written out. -/
theorem iib_mulVec_apply {R : Type*} [CommRing R] (x : Fin 3 → R) :
    iibAnomalyMatrix R *ᵥ x =
      ![-495 * x 0 + x 1 + 992 * x 2,
        225 * x 0 + x 1 - 448 * x 2,
        -63 * x 0 + x 1 + 128 * x 2] := by
  funext i
  fin_cases i <;>
    (simp [iibAnomalyMatrix, Matrix.mulVec, dotProduct, Fin.sum_univ_three]; try ring)

/-- `A · x = 0` unpacked into the three scalar conditions of Bilal (12.4). -/
theorem iib_mulVec_eq_zero_iff {R : Type*} [CommRing R] (x : Fin 3 → R) :
    iibAnomalyMatrix R *ᵥ x = 0 ↔
      (-495 * x 0 + x 1 + 992 * x 2 = 0 ∧ 225 * x 0 + x 1 - 448 * x 2 = 0
        ∧ -63 * x 0 + x 1 + 128 * x 2 = 0) := by
  rw [iib_mulVec_apply, funext_iff]
  constructor
  · intro h
    exact ⟨by simpa using h 0, by simpa using h 1, by simpa using h 2⟩
  · rintro ⟨h1, h2, h3⟩ i
    fin_cases i
    · simpa using h1
    · simpa using h2
    · simpa using h3

/-! ### Over an arbitrary field

Nothing in the argument is about `ℚ`.  Rows `0` and `1` differ by `-720 · (x₀ - 2x₂)`, so the
whole computation goes through over any field in which `720 = 2⁴·3²·5` is invertible, and the
`CharZero` hypothesis below is only a convenient sufficient condition for that.

The restriction is not vacuous: in characteristic `2` all three rows reduce to `(1, 1, 0)` and
in characteristic `3` all three reduce to `(0, 1, 2)`, so there the rank is `1` and the kernel
is a *plane*, strictly bigger than the line through `(2, -2, 1)` — both statements below are
genuinely false in characteristics `2` and `3`.  Characteristic `5`, on the other hand, divides
`720` but is harmless: rows `0` and `2` stay independent mod `5`, so rank `2` and the kernel
still hold, just not by this proof.  Hence `(720 : K) ≠ 0` is sufficient but not necessary; the
sharp condition is `ringChar K ∉ {2, 3}`, which is not formalised here. -/

section Field

variable {K : Type*} [Field K]

/-- **The kernel over any field where `720` is invertible.**  The only division performed in the
uniqueness argument is by `720`, the `(0,1)`-minor of `A` (see `iib_minor_01_01_det`): the
difference of the first two conditions is `-720 · (x₀ - 2x₂)`. -/
theorem iib_kernel_eq_of_720_ne_zero (h720 : (720 : K) ≠ 0) (x : Fin 3 → K) :
    iibAnomalyMatrix K *ᵥ x = 0 ↔ ∃ t : K, x = t • iibSolutionVector K := by
  rw [iib_mulVec_eq_zero_iff]
  constructor
  · rintro ⟨h1, h2, h3⟩
    refine ⟨x 2, ?_⟩
    have hsub : (720 : K) * (x 0 - 2 * x 2) = 0 := by linear_combination h2 - h1
    have hx0 : x 0 = 2 * x 2 := by
      have h := (mul_eq_zero.mp hsub).resolve_left h720
      linear_combination h
    have hx1 : x 1 = -2 * x 2 := by linear_combination h2 - 225 * hx0
    funext i
    fin_cases i <;> simp [hx0, hx1] <;> ring
  · rintro ⟨t, rfl⟩
    refine ⟨by simp; ring, by simp; ring, by simp; ring⟩

/-- `(2, -2, 1)` is nonzero over any field (only `(1 : K) ≠ 0` is used). -/
theorem iibSolutionVector_ne_zero_of_field : iibSolutionVector K ≠ 0 := by
  intro h
  have h2 := congrFun h 2
  simp at h2

/-- The kernel as a submodule, over any field where `720` is invertible. -/
theorem iib_ker_mulVecLin_of_720_ne_zero (h720 : (720 : K) ≠ 0) :
    LinearMap.ker (iibAnomalyMatrix K).mulVecLin
      = Submodule.span K {iibSolutionVector K} := by
  ext x
  rw [LinearMap.mem_ker, Matrix.mulVecLin_apply, iib_kernel_eq_of_720_ne_zero h720,
    Submodule.mem_span_singleton]
  exact ⟨fun ⟨t, ht⟩ => ⟨t, ht.symm⟩, fun ⟨t, ht⟩ => ⟨t, ht.symm⟩⟩

/-- **Rank two over any field where `720` is invertible**, by rank–nullity: the kernel is a line
by `iib_ker_mulVecLin_of_720_ne_zero`, and `3 - 1 = 2`.  No minor computation is used (though
`iib_minor_01_01_det` gives the same bound directly). -/
theorem iib_rank_eq_two_of_720_ne_zero (h720 : (720 : K) ≠ 0) :
    (iibAnomalyMatrix K).rank = 2 := by
  have hker : Module.finrank K (LinearMap.ker (iibAnomalyMatrix K).mulVecLin) = 1 := by
    rw [iib_ker_mulVecLin_of_720_ne_zero h720]
    exact finrank_span_singleton iibSolutionVector_ne_zero_of_field
  have h := (iibAnomalyMatrix K).mulVecLin.finrank_range_add_finrank_ker
  rw [hker] at h
  have h3 : Module.finrank K (Fin 3 → K) = 3 := by simp
  rw [h3] at h
  rw [Matrix.rank]
  omega

section CharZero

variable [CharZero K]

/-- In characteristic zero `720` is invertible. -/
theorem iib_720_ne_zero : (720 : K) ≠ 0 := by norm_num

/-- **Main result over an arbitrary characteristic-zero field.**  The solutions of Bilal (12.4)
are exactly the multiples of the IIB content `(2, -2, 1)`. -/
theorem iib_kernel_eq_of_field (x : Fin 3 → K) :
    iibAnomalyMatrix K *ᵥ x = 0 ↔ ∃ t : K, x = t • iibSolutionVector K :=
  iib_kernel_eq_of_720_ne_zero iib_720_ne_zero x

/-- `iib_kernel_eq_of_field` as an equality of submodules. -/
theorem iib_ker_mulVecLin_of_field :
    LinearMap.ker (iibAnomalyMatrix K).mulVecLin
      = Submodule.span K {iibSolutionVector K} :=
  iib_ker_mulVecLin_of_720_ne_zero iib_720_ne_zero

/-- **The rank is two, not three**, over any characteristic-zero field. -/
theorem iib_rank_eq_two_of_field : (iibAnomalyMatrix K).rank = 2 :=
  iib_rank_eq_two_of_720_ne_zero iib_720_ne_zero

end CharZero

end Field

/-- **Main result (rational version).** The solutions of the IIB gravitational anomaly
cancellation conditions are *exactly* the multiples of the type IIB content `(2, -2, 1)`.

The `←` direction is the classical cancellation check (cf.
`iib_gravitational_anomaly_cancels` in `AnomalyPolynomial.lean`); the `→` direction is
the uniqueness that neither Bilal nor Polchinski states: rows `0` and `1` alone already
force `x₀ = 2x₂` (their difference is `-720·(x₀ - 2x₂)`), and then `x₁ = -2x₂`, after
which row `2` is automatic by `iib_rows_relation`. -/
theorem iib_kernel_eq (x : Fin 3 → ℚ) :
    iibAnomalyMatrix ℚ *ᵥ x = 0 ↔ ∃ t : ℚ, x = t • iibSolutionVector ℚ :=
  iib_kernel_eq_of_field x

/-- **Main result (integer version).** Bilal's `n`'s are net counts of fields, hence
integers. The integer solutions are exactly `ℤ · (2, -2, 1)`: the solution ray meets the
lattice in a full rank-one sublattice, with no divisibility obstruction, because
`(2, -2, 1)` is primitive. -/
theorem iib_kernel_eq_int (x : Fin 3 → ℤ) :
    iibAnomalyMatrix ℤ *ᵥ x = 0 ↔ ∃ t : ℤ, x = t • iibSolutionVector ℤ := by
  rw [iib_mulVec_eq_zero_iff]
  constructor
  · rintro ⟨h1, h2, h3⟩
    refine ⟨x 2, ?_⟩
    have hx0 : x 0 = 2 * x 2 := by omega
    have hx1 : x 1 = -2 * x 2 := by omega
    funext i
    fin_cases i <;> simp [hx0, hx1] <;> ring
  · rintro ⟨t, rfl⟩
    refine ⟨by simp; ring, by simp; ring, by simp; ring⟩

/-- `(2, -2, 1)` is not the zero vector. -/
theorem iibSolutionVector_ne_zero : iibSolutionVector ℚ ≠ 0 :=
  iibSolutionVector_ne_zero_of_field

/-- `iib_kernel_eq` as an equality of submodules: the kernel of the IIB anomaly matrix
is the line spanned by the IIB field content. -/
theorem iib_ker_mulVecLin :
    LinearMap.ker (iibAnomalyMatrix ℚ).mulVecLin
      = Submodule.span ℚ {iibSolutionVector ℚ} :=
  iib_ker_mulVecLin_of_field

/-- **The rank is two, not three.** Hence "three conditions on three unknowns" is the
wrong count: a one-parameter solution family is forced, and is not a coincidence. -/
theorem iib_rank_eq_two : (iibAnomalyMatrix ℚ).rank = 2 :=
  iib_rank_eq_two_of_field

end StringFormal.Math
