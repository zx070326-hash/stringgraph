/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.DDF

/-!
# The Virasoro relations on the momentum tower

Graph node: `worldsheet.free-boson-central-charge-d` (the tower version), convention
`conv.virasoro-standard`.  This is the **prerequisite of blueprint §B″.7 / §B″.8** in
`formal/BLUEPRINT-noghost.md`: that section observes that the repository had the Virasoro
relations `⁅L_m, L_n⁆` only on a *single* Fock space (`Fock.lie_Lop_Lop`, with central charge
`c = D`) and the tower relations only *against the modes* (`lie_towerLop_towerMode`), so none of
the three `descTwo` equations of PR5b could even be stated.  This file supplies the missing
bracket.

There is no new mathematics: `towerLop` is `towerDiag`, i.e. it acts on rung `j` by
`Fock.Lop η (towerMomentum a b j)`, so the tower relation is the fibrewise relation transported
by `Finsupp.lhom_ext`, exactly as `lie_towerLop_towerMode` in `NoGhost/DDF.lean`.  The central
charge is the same `c = D` on every rung — the rung-dependent momentum `p_j = a + j b` only
enters `L_0`'s eigenvalue, never the central term.

## Main results

* `lie_towerLop_towerLop` — `⁅L_m, L_n⁆ = (m - n) L_{m+n} + D·centralTerm(m)·δ_{m+n,0}` on
  `TowerFock D R`.
* `towerLop_apply_towerLop` — the same relation in "moved to the right" form
  `L_m (L_n x) = L_n (L_m x) + (m - n) • L_{m+n} x + c·δ • x`, which is the form every
  computation with descendants actually uses.
* `towerLop_apply_towerLop_of_ne_zero` / `towerLop_apply_towerLop_neg` — the two cases of the
  `if`, so that callers never have to `by_cases` on `m + n = 0`.
-/

namespace StringFormal.NoGhost

section TowerVirasoro

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

/-- **The Virasoro relations on the momentum tower**, with central charge `c = D`:

`⁅L_m, L_n⁆ = (m - n) L_{m+n} + (D/12) m(m² - 1) δ_{m+n,0}`.

Graph node `worldsheet.free-boson-central-charge-d`, convention `conv.virasoro-standard`;
`Virasoro.centralTerm R m = (m³ - m)/12`.  This is the fibrewise transport of
`Fock.lie_Lop_Lop`: it is *not* affected by the fact that rung `j` carries its own momentum
`towerMomentum a b j`, because the central term of `Fock.lie_Lop_Lop` is momentum-independent.

Blueprint §B″.8 names this the one missing prerequisite of PR5b. -/
theorem lie_towerLop_towerLop (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (m n : ℤ) :
    ⁅towerLop η a b m, towerLop η a b n⁆
      = ((m : R) - n) • towerLop η a b (m + n)
        + (if m + n = 0 then (D : R) * Virasoro.centralTerm R m else 0)
          • (LinearMap.id : Module.End R (TowerFock D R)) := by
  refine Finsupp.lhom_ext fun j P => ?_
  have h := congrArg (fun T : Module.End R (Fock D R) => T P)
    (Fock.lie_Lop_Lop η (towerMomentum a b j) hη m n)
  simp only [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
    LinearMap.add_apply, LinearMap.smul_apply, LinearMap.id_coe, id_eq, towerLop_single,
    ← Finsupp.single_sub, Finsupp.smul_single, ← Finsupp.single_add] at h ⊢
  rw [h]

/-- The "move `L_m` past `L_n`" form of `lie_towerLop_towerLop`, which is what the descendant
computations of blueprint §B″.2.1 use:

`L_m (L_n x) = L_n (L_m x) + (m - n) • L_{m+n} x + D·centralTerm(m)·δ_{m+n,0} • x`. -/
theorem towerLop_apply_towerLop (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (m n : ℤ)
    (x : TowerFock D R) :
    towerLop η a b m (towerLop η a b n x)
      = towerLop η a b n (towerLop η a b m x)
        + (((m : R) - n) • towerLop η a b (m + n) x
          + (if m + n = 0 then (D : R) * Virasoro.centralTerm R m else 0) • x) := by
  have h := congrArg (fun T : Module.End R (TowerFock D R) => T x)
    (lie_towerLop_towerLop η a b hη m n)
  simp only [LieRing.of_associative_ring_bracket, LinearMap.sub_apply, Module.End.mul_apply,
    LinearMap.add_apply, LinearMap.smul_apply, LinearMap.id_coe, id_eq] at h
  exact sub_eq_iff_eq_add'.mp h

/-- `lie_towerLop_towerLop` away from the central term (`m + n ≠ 0`). -/
theorem towerLop_apply_towerLop_of_ne_zero (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1)
    {m n : ℤ} (hmn : m + n ≠ 0) (x : TowerFock D R) :
    towerLop η a b m (towerLop η a b n x)
      = towerLop η a b n (towerLop η a b m x) + ((m : R) - n) • towerLop η a b (m + n) x := by
  rw [towerLop_apply_towerLop η a b hη m n x, if_neg hmn, zero_smul, add_zero]

/-- `lie_towerLop_towerLop` on the central diagonal (`n = -m`). -/
theorem towerLop_apply_towerLop_neg (η a b : Fin D → R) (hη : ∀ μ, η μ * η μ = 1) (m : ℤ)
    (x : TowerFock D R) :
    towerLop η a b m (towerLop η a b (-m) x)
      = towerLop η a b (-m) (towerLop η a b m x)
        + ((2 * (m : R)) • towerLop η a b 0 x + ((D : R) * Virasoro.centralTerm R m) • x) := by
  have h := towerLop_apply_towerLop η a b hη m (-m) x
  rw [show m + -m = (0 : ℤ) from add_neg_cancel m, if_pos rfl] at h
  rw [h, show ((m : R) - ((-m : ℤ) : R)) = 2 * (m : R) by push_cast; ring]

end TowerVirasoro

end StringFormal.NoGhost
