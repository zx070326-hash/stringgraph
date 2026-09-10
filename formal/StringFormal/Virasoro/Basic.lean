/-
# Virasoro algebra

Graph node: `worldsheet.virasoro-algebra`
Convention: `conv.virasoro-standard`
  [L_m, L_n] = (m - n) L_{m+n} + (c/12) m (m^2 - 1) δ_{m+n,0}

## Status

Skeleton only. The definition below is a placeholder structure recording the
bracket law as data, so that downstream files have a stable name to import.
The real target is to reuse (or upstream to Mathlib/Physlib) the construction in
arXiv:2510.21741 ("Virasoro algebra and Sugawara constructions formally in Lean").
Replacing this placeholder with a genuine `LieAlgebra` instance is task
`formal/TODO.md#virasoro-lie-instance`.

Do NOT add `sorry` to this file; the graph tool treats any file listed in
`formal.lean_file` as build-gated.
-/

import Mathlib.Algebra.Lie.Basic

namespace StringFormal.Virasoro

/-- Placeholder carrier for the Virasoro algebra: a formal `ℤ`-indexed family of
generators together with a central element, over a commutative ring `R`.
This is *not yet* a Lie algebra instance. -/
structure VirasoroAlgebra (R : Type*) [CommRing R] where
  /-- The generators `L n`, `n : ℤ`. -/
  L : ℤ → R
  /-- The central charge. -/
  c : R

/-- The structure constants of the standard Virasoro bracket, as a function.
`bracketCoeff m n` is the coefficient of `L (m+n)`; `centralCoeff m n` is the
coefficient of `c` (nonzero only when `m + n = 0`). -/
def bracketCoeff (R : Type*) [CommRing R] (m n : ℤ) : R := ((m - n : ℤ) : R)

/-- Central term `(1/12) m (m² − 1) δ_{m+n,0}`, written without division by
returning `m (m² − 1)` when `m + n = 0` and `0` otherwise. The factor `1/12` is
to be supplied by the field `R` when it is a `ℚ`-algebra. -/
def centralNumerator (R : Type*) [CommRing R] (m n : ℤ) : R :=
  if m + n = 0 then ((m * (m ^ 2 - 1) : ℤ) : R) else 0

theorem centralNumerator_of_ne (R : Type*) [CommRing R] {m n : ℤ} (h : m + n ≠ 0) :
    centralNumerator R m n = 0 := by
  unfold centralNumerator
  simp [h]

end StringFormal.Virasoro
