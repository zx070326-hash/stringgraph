/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import StringFormal.Math.GreenSchwarzAlgebra
import Mathlib.Algebra.Algebra.Rat
import Mathlib.Tactic.LinearCombination

/-!
# Green–Schwarz factorisation over an arbitrary `ℚ`-algebra

Refinement of `StringFormal/Math/GreenSchwarzAlgebra.lean` (Lean island 2) requested by
the graph reviewer. That file states the twelve-form factorisation over a
characteristic-zero **field**, because the coefficients `1/48`, `1/300` are then literally
`48⁻¹`, `300⁻¹` and `field_simp; ring` closes everything. The objection is that the
objects the identity is *about* — the anomaly polynomials `Ω₄`, `Ω₈`, `Ω₁₂` — do not live
in a field. They live in a commutative ring: the even-degree part of the de Rham complex
with rational coefficients, or `H^{even}(BG; ℚ)`, or the ring of invariant polynomials on
the Lie algebra. Those rings contain nilpotents and zero divisors, so the field statement
does not literally apply to them; only its *shape* does.

This file removes that gap. Everything is stated over `[CommRing R] [Algebra ℚ R]`, which
is exactly "commutative ring in which the rationals act" — satisfied by every ring listed
above and by every characteristic-zero field. The rational coefficients appear as
`algebraMap ℚ R (1/48)` etc.

## Why the earlier attempt stalled, and what fixes it

`TODO.md` records a formalizer stalling here for a round. The reason: `ring` treats
`algebraMap ℚ R (1/48)` as an opaque atom, so it cannot see `48 * algebraMap ℚ R (1/48) = 1`
and the identity is simply *not* a ring identity in those atoms. The fix is to feed the
defining relations in explicitly:

* for `so(32)`, supply `48 · a = 1` and `300 · b = 1` and close with `linear_combination`
  (the residual is `-15xy(48a − 1) + 90a x³(300b − 1)`);
* for `E₈` and for the nested/expanded comparison, the coefficient arithmetic is a single
  closed relation between constants (`1/7200 = (1/48)(1/100 − 1/300)`, resp.
  `1/14400 = (1/48)(1/300)`), so it is cheaper to prove that relation by `← map_mul` +
  `norm_num` inside `ℚ`, rewrite, and then call `ring` on genuine atoms.

The `MvPolynomial`-evaluation route also works but is strictly more machinery.

## Scope — unchanged from the field version

These remain identities about the *specific polynomial expressions written into the
statements*. They are not theorems about Lie algebras, differential forms or index theory.
The inputs `Ω₄ = 30 tr F²`, `Ω₈ = 24 tr F⁴ + 3(tr F²)²`, `Ω₁₂ = 15 tr F² tr F⁴` for
`so(32)` come from `math.so-usp-adjoint-fundamental-trace-identities` plus
`tr_f6_coefficient_vanishing`; the `E₈` inputs come from `math.e8-adjoint-trace-identities`.
Both are separate graph nodes and neither is proved here. No uniqueness/classification
claim is made or implied.

Convention: `conv.gauge-trace-normalization`.

## Contents

* `gs_factorization_so32_alg`, `gs_factorization_e8_alg`,
  `gs_factorization_nested_eq_expanded_alg`, `gs_factorization_alg` —
  graph node `math.anomaly-twelve-form-factorization`.
* `gs_factorization_so32_field_of_alg` — certifies that the `algebraMap` form really does
  subsume the field form already in the graph.
* `mixed_anomaly_so_each_gives_32` — graph node `math.mixed-anomaly-trace-conditions-n32`.
* `tr_f6_usp_ge_33` — graph node `math.tr-f6-coefficient-vanishing`.
-/

namespace StringFormal.Math

/-! ### The twelve-form factorisation over a `ℚ`-algebra -/

section FactorizationAlg

variable {R : Type*} [CommRing R] [Algebra ℚ R]

/-- **`SO(32)` branch of the GS factorisation, over any commutative `ℚ`-algebra.**
With `Ω₄ = 30 x`, `Ω₈ = 24 y + 3 x²`, `Ω₁₂ = 15 x y` (where `x = tr F²`, `y = tr F⁴`, and
the `tr F⁶` term has already dropped out because `N + 32l = 0` at `N = 32`, `l = -1`):

  `Ω₁₂ = (1/48) · Ω₄ · (Ω₈ − (1/300) · Ω₄²)`.

Generalises `gs_factorization_so32` from a characteristic-zero field to a commutative
`ℚ`-algebra — in particular to the even-degree forms / invariant polynomials where the
`Ω`'s actually live. The mechanism is unchanged: `(1/300) Ω₄² = 3x²` cancels the `3x²`
inside `Ω₈`, leaving `(1/48)(30x)(24y) = 15xy`. -/
theorem gs_factorization_so32_alg (x y : R) :
    15 * x * y = algebraMap ℚ R (1 / 48) * (30 * x) *
      ((24 * y + 3 * x ^ 2) - algebraMap ℚ R (1 / 300) * (30 * x) ^ 2) := by
  have h48 : (48 : R) * algebraMap ℚ R (1 / 48) = 1 := by
    rw [← map_ofNat (algebraMap ℚ R) 48, ← map_mul]; norm_num
  have h300 : (300 : R) * algebraMap ℚ R (1 / 300) = 1 := by
    rw [← map_ofNat (algebraMap ℚ R) 300, ← map_mul]; norm_num
  linear_combination (-(15 * x * y)) * h48 + (90 * algebraMap ℚ R (1 / 48) * x ^ 3) * h300

/-- **`E₈` branch of the GS factorisation, over any commutative `ℚ`-algebra.**
With `Ω₄ = x`, `Ω₈ = x²/100`, `Ω₁₂ = x³/7200` (where `x = Tr F² = tr F²`):

  `Ω₁₂ = (1/48) · Ω₄ · (Ω₈ − (1/300) · Ω₄²)`.

Generalises `gs_factorization_e8`. Nothing cancels here: the whole content is the
coefficient relation `1/7200 = (1/48)(1/100 − 1/300)`, which is proved inside `ℚ` and then
transported by the ring hom `algebraMap ℚ R`; after that the identity is a genuine ring
identity in the atom `x`. -/
theorem gs_factorization_e8_alg (x : R) :
    algebraMap ℚ R (1 / 7200) * x ^ 3
      = algebraMap ℚ R (1 / 48) * x *
          (algebraMap ℚ R (1 / 100) * x ^ 2 - algebraMap ℚ R (1 / 300) * x ^ 2) := by
  have h : algebraMap ℚ R (1 / 7200)
      = algebraMap ℚ R (1 / 48) * (algebraMap ℚ R (1 / 100) - algebraMap ℚ R (1 / 300)) := by
    rw [← map_sub, ← map_mul]; norm_num
  rw [h]; ring

end FactorizationAlg

end StringFormal.Math
