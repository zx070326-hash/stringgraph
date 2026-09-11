/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer

Written from scratch against Mathlib `v4.33.1`; not a port of any existing formalisation.
-/
import StringFormal.NoGhost.TowerVirasoro
import StringFormal.NoGhost.SliceRank

/-!
# Null seeds: the two families of `L`-descendant null states, and where `D = 26` enters

Graph nodes: `worldsheet.ddf-spanning-hypothesis`, `worldsheet.no-ghost-theorem-v4`
(the `ddf-spans` gap `(B-26)`), `worldsheet.open-string-intercept`.  This is **PR5b′ of
blueprint §B″** in `formal/BLUEPRINT-noghost.md`, the designated *falsification point* of the
whole `(B-26)` route.

## What this file is for

Blueprint §B″.2.1 isolates two families of zero-norm physical states, both built out of the
lowering operators `L_{-1}`, `L_{-2}` alone (no DDF operators, no light-cone frame):

* **Type 1**: `L_{-1} φ` for `φ` with `L_n φ = 0` (`n ≥ 1`) and `L_0 φ = 0`;
* **Type 2**: `𝒟₂ φ := (2 L_{-2} + 3 L_{-1}²) φ` for `φ` with `L_n φ = 0` (`n ≥ 1`) and
  `L_0 φ = -φ`.

`towerSpurious_inf_towerPhys_le_towerNull` turns "spurious and physical" into "null", so the
content is entirely the *physicality* of these two vectors, and that is where the two numbers of
the open bosonic string appear — **each in exactly one equation, and the two equations are
independent**:

```
L_1 (2 L_{-2} + 3 L_{-1}²) φ = 12 (h + 1) • L_{-1} φ           -- intercept: a₀ = 1 ⟺ h + 1 = 0
L_2 (2 L_{-2} + 3 L_{-1}²) φ = (26 h + c) • φ = (D - 26) • φ   -- at h = -1: critical dimension
```

The second line is **the only place in the entire no-ghost chain where `D - 26` can be written
down as an equation** (blueprint §B″.8); every other lemma of the `ddf-spans` thread (`Glue`,
`Assembly`, `SliceRank`, `SliceDim`, `SpuriousElimination`) is `D`-independent by design.  Its
arithmetic twin on the Kac side is `Fock.kacDet2_massShell_two`
(`Virasoro/FockFreeLowLevel.lean`), which pins `2(c - 26)` as the on-shell level-2 Kac
determinant.

**The computation came out exactly as blueprint §B″.2 predicted by hand**: the coefficient of
the `L_2` equation is `26 h + c`, hence `c - 26` at `h = -1`, and the `L_1` equation is
`12 (h + 1)` with no `c` in it.  No correction to §B″ was needed.

## Main definitions

* `descTwo η a b` — the operator `𝒟₂ = 2 L_{-2} + 3 L_{-1}²` on `TowerFock D R`.

## Main results

* `towerLop_neg_one_mem_towerNullSubmodule` — **Type 1**; `D`-independent, intercept `1`.
* `towerLop_one_apply_descTwo` — the **intercept equation** `L_1 𝒟₂ φ = 12(h+1) L_{-1} φ`.
* `towerLop_two_apply_descTwo_of_eigenvalue` / `towerLop_two_apply_descTwo` — the **critical
  dimension equation** `L_2 𝒟₂ φ = (26h + D) φ`, i.e. `(D - 26) φ` on the `N = 2` shell.
* `towerLop_zero_apply_descTwo`, `towerLop_apply_descTwo_of_three_le` — the remaining Virasoro
  conditions, both unconditional in `D`.
* `descTwo_mem_towerSpuriousSubmodule`, `descTwo_mem_towerPhysSubmodule`,
  `descTwo_mem_towerNullSubmodule` — **Type 2**, the last two under `(D : R) = 26`.
* `towerLop_two_apply_descTwo_eq_zero_iff`, `descTwo_mem_towerPhysSubmodule_iff` — over a domain
  and for a nonzero seed, `D = 26` is **necessary** as well as sufficient: the Type-2 vector is
  physical *iff* `(D : R) = 26`.  (Kac-side twin: `Fock.kacDet2_massShell_two_eq_zero_iff`.)
* `descTwo_mem_towerBigrade` — `𝒟₂` has bidegree `(0, +2)` on the tower.
* `towerLop_neg_one_mem_towerNullSubmodule_of_mem_towerBigrade`,
  `descTwo_mem_towerNullSubmodule_of_mem_towerBigrade_neg_two`,
  `descTwo_single_mem_towerNullSubmodule` — the seed hypotheses discharged **on a slice** at
  intercept `a₀ = 1` (`k·k = 2`), including the fully concrete `N = 2` Type-2 state
  `(2 L_{-2} + 3 L_{-1}²)|0; p_{-2}⟩`.

## What is **not** here (blueprint §B″ status after this file)

`B26 2` is **not** closed, and neither is `ddfSpans_bigrade_neg_two_two`.  What is missing is
purely the *counting* half of blueprint §B″.2, and it is not cheap:

1. The 25 Type-1 seeds `L_{-1}((v · α_{-1})|p_{-2}⟩)` with `v · p_{-2} = 0` are not
   constructed, and their linear independence (injectivity of `v ↦ χ_v` on the hyperplane
   `v · p = 0`, which needs the `α_{-2}`-component of `Fock.Lop_neg_one_apply_polState`) is not
   proved.
2. `descTwo y ≠ 0` is not proved.  The cheap Gram criterion cannot give it: at `c = 26`,
   `h = -1` the level-2 Kac determinant is exactly `0`
   (`Fock.kacDet2_massShell_two`/`kacDet2_massShell_26`), so
   `Fock.linearIndependent_fockDesc2` is vacuous there — *that vanishing is the very reason a
   null state exists*.  Nonvanishing needs an explicit `MvPolynomial` coefficient: the
   `X_{(μ,2)}`-coefficient of `𝒟₂|0;p⟩` is `5 η_μ p^μ`, nonzero for some `μ` because
   `p · p = -2 ≠ 0` in characteristic zero.
3. Even with 26 independent null states in hand, `B26 2` needs
   `card {d | level d = 2 ∧ conjDeg d = 0} - card {ddf level-2 occupations} = 26`, i.e.
   `p_{D-1}(2) - p_{D-2}(2) = D`.  Both cardinalities are deliberately **never evaluated** in
   `SpuriousElimination.lean` and `SliceDim.lean` (blueprint §B′.8); evaluating their difference
   is a genuine `Finsupp`-counting task, not a `decide`.

So this file delivers the *operator* content of PR5b′ (both families, and the two equations that
carry `a₀ = 1` and `D = 26`) and leaves the *dimension count* of §B″.2 open.  The falsification
test the blueprint asked for has been run and passed.
-/

namespace StringFormal.NoGhost

/-! ### Two values of the Virasoro central term -/

section CentralValues

variable (R : Type*) [CommRing R] [Algebra ℚ R]

/-- `centralTerm R 1 = 0`: there is no central term in `⁅L_1, L_{-1}⁆`.  This is why the
Type-1 family of blueprint §B″.2.1 is `D`-independent. -/
lemma centralTerm_one_eq_zero : Virasoro.centralTerm R 1 = 0 := by
  simp [Virasoro.centralTerm]

/-- `2 · centralTerm R 2 = 1`, i.e. `⁅L_2, L_{-2}⁆ = 4 L_0 + c/2`.  This is the coefficient
that carries the central charge into the `L_2` equation of `descTwo`. -/
lemma two_mul_centralTerm_two_eq_one : (2 : R) * Virasoro.centralTerm R 2 = 1 := by
  rw [Virasoro.centralTerm, show ((2 ^ 3 - 2 : ℤ) : R) = 6 by push_cast; ring,
    show (2 : R) * (Virasoro.inv12 R * 6) = 12 * Virasoro.inv12 R by ring,
    Virasoro.twelve_mul_inv12]

end CentralValues

/-! ### The six atoms: `L_m L_{-n} φ` for `m ∈ {0, 1, 2}`, `n ∈ {1, 2}` on a seed `φ`

Throughout, `φ` is a *seed*: `L_n φ = 0` for every `n ≥ 1`, and `L_0 φ = h φ`.  Each atom is a
single application of `towerLop_apply_towerLop`.  Blueprint §B″.2 computes the same six numbers
as Gram entries of the `D + 1` spurious generators; here they are operator identities, which is
what the physicality proofs need. -/

section Atoms

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] (η a b : Fin D → R)
variable (hη : ∀ μ, η μ * η μ = 1) {h : R} {φ : TowerFock D R}
variable (hpos : ∀ n : ℤ, 0 < n → towerLop η a b n φ = 0)
variable (h0 : towerLop η a b 0 φ = h • φ)

include hη hpos h0 in
/-- `L_1 L_{-1} φ = 2h φ` (blueprint §B″.2: `⟨χ_v, χ_u⟩` comes from this with `2L_0`). -/
lemma towerLop_one_apply_towerLop_neg_one :
    towerLop η a b 1 (towerLop η a b (-1) φ) = (2 * h) • φ := by
  rw [towerLop_apply_towerLop_neg η a b hη 1 φ, hpos 1 one_pos, map_zero, zero_add, h0,
    centralTerm_one_eq_zero, mul_zero, zero_smul, add_zero]
  match_scalars
  ring

include hη h0 in
/-- `L_0 L_{-1} φ = (h + 1) L_{-1} φ`. -/
lemma towerLop_zero_apply_towerLop_neg_one :
    towerLop η a b 0 (towerLop η a b (-1) φ) = (h + 1) • towerLop η a b (-1) φ := by
  rw [towerLop_apply_towerLop_of_ne_zero η a b hη (by decide : (0 : ℤ) + -1 ≠ 0) φ, h0,
    show (0 : ℤ) + -1 = -1 by decide, map_smul]
  match_scalars
  ring

include hη h0 in
/-- `L_0 L_{-2} φ = (h + 2) L_{-2} φ`. -/
lemma towerLop_zero_apply_towerLop_neg_two :
    towerLop η a b 0 (towerLop η a b (-2) φ) = (h + 2) • towerLop η a b (-2) φ := by
  rw [towerLop_apply_towerLop_of_ne_zero η a b hη (by decide : (0 : ℤ) + -2 ≠ 0) φ, h0,
    show (0 : ℤ) + -2 = -2 by decide, map_smul]
  match_scalars
  ring

include hη hpos in
/-- `L_1 L_{-2} φ = 3 L_{-1} φ`, from `⁅L_1, L_{-2}⁆ = 3 L_{-1}` (blueprint §B″.2:
`⟨χ_v, χ_0⟩ = 3(v·p)`). -/
lemma towerLop_one_apply_towerLop_neg_two :
    towerLop η a b 1 (towerLop η a b (-2) φ) = (3 : R) • towerLop η a b (-1) φ := by
  rw [towerLop_apply_towerLop_of_ne_zero η a b hη (by decide : (1 : ℤ) + -2 ≠ 0) φ,
    hpos 1 one_pos, map_zero, zero_add, show (1 : ℤ) + -2 = -1 by decide]
  match_scalars
  ring

include hη hpos in
/-- `L_2 L_{-1} φ = 0`, because `⁅L_2, L_{-1}⁆ = 3 L_1` annihilates `φ`. -/
lemma towerLop_two_apply_towerLop_neg_one :
    towerLop η a b 2 (towerLop η a b (-1) φ) = 0 := by
  rw [towerLop_apply_towerLop_of_ne_zero η a b hη (by decide : (2 : ℤ) + -1 ≠ 0) φ,
    hpos 2 (by decide), map_zero, zero_add, show (2 : ℤ) + -1 = 1 by decide,
    hpos 1 one_pos, smul_zero]

include hη hpos h0 in
/-- `L_2 L_{-2} φ = (4h + c/2) φ` with `c = D`: the Gram entry that carries the central charge
(blueprint §B″.2: `⟨χ_0, χ_0⟩ = 4h + c/2`). -/
lemma towerLop_two_apply_towerLop_neg_two :
    towerLop η a b 2 (towerLop η a b (-2) φ)
      = (4 * h) • φ + ((D : R) * Virasoro.centralTerm R 2) • φ := by
  rw [towerLop_apply_towerLop_neg η a b hη 2 φ, hpos 2 (by decide), map_zero, zero_add, h0]
  match_scalars
  ring

end Atoms

/-! ### Type 1: `L_{-1}` applied to an `L_0`-weight-zero seed -/

section TypeOne

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] {η a b : Fin D → R}

/-- **Type 1 of blueprint §B″.2.1.**  If `φ` is annihilated by every `L_n` (`n ≥ 1`) and has
`L_0`-eigenvalue `0`, then `L_{-1} φ` is a null (zero-norm) physical state at intercept `1`.

`D` does **not** appear: the central term of `⁅L_1, L_{-1}⁆` vanishes
(`centralTerm_one_eq_zero`).  The intercept, on the other hand, is forced to be exactly `1` by
`L_0 (L_{-1} φ) = L_{-1} φ`, so unlike `NullDescend.ddfOp_mem_towerNullSubmodule` this cannot be
stated for a general `a₀`.

At `N = 2` (rung `-2`, level `2`) blueprint §B″.2.1 gets `D - 1 = 25` of these, from
`φ = (v · α_{-1})|p_{-2}⟩` with `v · p_{-2} = 0`; that construction is *not* in this file (see
the module docstring). -/
theorem towerLop_neg_one_mem_towerNullSubmodule (hη : ∀ μ, η μ * η μ = 1)
    {φ : TowerFock D R} (hpos : ∀ n : ℤ, 0 < n → towerLop η a b n φ = 0)
    (hzero : towerLop η a b 0 φ = 0) :
    towerLop η a b (-1) φ ∈ towerNullSubmodule η a b (1 : R) := by
  have h0 : towerLop η a b 0 φ = (0 : R) • φ := by rw [hzero, zero_smul]
  refine towerSpurious_inf_towerPhys_le_towerNull η a b (1 : R) (Submodule.mem_inf.2
    ⟨towerLop_neg_mem_towerSpuriousSubmodule one_pos φ, mem_towerPhysSubmodule.2 ⟨?_, ?_⟩⟩)
  · rw [towerLop_zero_apply_towerLop_neg_one η a b hη h0, zero_add]
  · intro m hm
    by_cases hm1 : m = 1
    · subst hm1
      rw [towerLop_one_apply_towerLop_neg_one η a b hη hpos h0, mul_zero, zero_smul]
    · rw [towerLop_apply_towerLop_of_ne_zero η a b hη (by omega : m + -1 ≠ 0) φ, hpos m hm,
        map_zero, zero_add, hpos (m + -1) (by omega), smul_zero]

end TypeOne

/-! ### Type 2: the operator `𝒟₂ = 2 L_{-2} + 3 L_{-1}²` -/

section TypeTwo

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R]

/-- **The Type-2 descendant operator** `𝒟₂ = 2 L_{-2} + 3 L_{-1}²` of blueprint §B″.2.1.

The relative coefficient `2 : 3` is the unique one (up to scale) that makes `L_1 𝒟₂ φ`
proportional to `L_{-1} φ` with a coefficient vanishing at `h = -1`, and simultaneously makes
`L_2 𝒟₂ φ` proportional to `φ` with a coefficient vanishing at `c = 26`.  It is the level-2
singular vector of the Verma module `V(26, -1)`. -/
noncomputable def descTwo (η a b : Fin D → R) : Module.End R (TowerFock D R) :=
  (2 : R) • towerLop η a b (-2) + (3 : R) • (towerLop η a b (-1) * towerLop η a b (-1))

variable (η a b : Fin D → R)

lemma descTwo_apply (ψ : TowerFock D R) :
    descTwo η a b ψ
      = (2 : R) • towerLop η a b (-2) ψ
        + (3 : R) • towerLop η a b (-1) (towerLop η a b (-1) ψ) := rfl

/-- `𝒟₂ φ` is a spurious state: it is a combination of `L_{-2}`- and `L_{-1}`-images.  No
hypothesis on `φ` at all. -/
theorem descTwo_mem_towerSpuriousSubmodule (ψ : TowerFock D R) :
    descTwo η a b ψ ∈ towerSpuriousSubmodule η a b := by
  rw [descTwo_apply]
  exact Submodule.add_mem _
    (Submodule.smul_mem _ _ (towerLop_neg_mem_towerSpuriousSubmodule (by decide) ψ))
    (Submodule.smul_mem _ _
      (towerLop_neg_mem_towerSpuriousSubmodule one_pos (towerLop η a b (-1) ψ)))

variable (hη : ∀ μ, η μ * η μ = 1) {h : R} {φ : TowerFock D R}
variable (hpos : ∀ n : ℤ, 0 < n → towerLop η a b n φ = 0)

include hη hpos in
/-- ⭐ **The intercept equation of blueprint §B″.2.1**:

`L_1 (2 L_{-2} + 3 L_{-1}²) φ = 12 (h + 1) · L_{-1} φ`.

The central charge does **not** appear.  The right-hand side vanishes exactly when `h = -1`,
which on the `N = 2` antidiagonal slice (`h = a₀ - 2`) says `a₀ = 1`: this is where the
open-string intercept `worldsheet.open-string-intercept` is consumed by the `(B-26)` route. -/
theorem towerLop_one_apply_descTwo (h0 : towerLop η a b 0 φ = h • φ) :
    towerLop η a b 1 (descTwo η a b φ) = (12 * (h + 1)) • towerLop η a b (-1) φ := by
  have hB : towerLop η a b 1 (towerLop η a b (-1) (towerLop η a b (-1) φ))
      = (4 * h + 2) • towerLop η a b (-1) φ := by
    rw [towerLop_apply_towerLop_neg η a b hη 1 (towerLop η a b (-1) φ),
      towerLop_one_apply_towerLop_neg_one η a b hη hpos h0,
      towerLop_zero_apply_towerLop_neg_one η a b hη h0,
      centralTerm_one_eq_zero, mul_zero, zero_smul, add_zero, map_smul]
    match_scalars
    ring
  rw [descTwo_apply, map_add, map_smul, map_smul,
    towerLop_one_apply_towerLop_neg_two η a b hη hpos, hB]
  match_scalars
  ring

include hη hpos in
/-- ⭐⭐ **The critical-dimension equation of blueprint §B″.2.1**, general `h`:

`L_2 (2 L_{-2} + 3 L_{-1}²) φ = (26 h + c) · φ`,  `c = D`.

Together with `Fock.kacDet2_massShell_two` (`2(c - 26)` is the on-shell level-2 Kac
determinant) this is the whole of `D = 26` in the Goddard–Thorn chain. -/
theorem towerLop_two_apply_descTwo_of_eigenvalue (h0 : towerLop η a b 0 φ = h • φ) :
    towerLop η a b 2 (descTwo η a b φ) = (26 * h + (D : R)) • φ := by
  have hB : towerLop η a b 2 (towerLop η a b (-1) (towerLop η a b (-1) φ)) = (6 * h) • φ := by
    rw [towerLop_apply_towerLop_of_ne_zero η a b hη (by decide : (2 : ℤ) + -1 ≠ 0)
        (towerLop η a b (-1) φ),
      towerLop_two_apply_towerLop_neg_one η a b hη hpos, map_zero, zero_add,
      show (2 : ℤ) + -1 = 1 by decide,
      towerLop_one_apply_towerLop_neg_one η a b hη hpos h0]
    match_scalars
    ring
  rw [descTwo_apply, map_add, map_smul, map_smul,
    towerLop_two_apply_towerLop_neg_two η a b hη hpos h0, hB]
  match_scalars
  linear_combination (D : R) * two_mul_centralTerm_two_eq_one R

include hη hpos in
/-- ⭐⭐ **`L_2 𝒟₂ φ = (D - 26) φ`** — blueprint §B″.8's "the unique consumer of `D = 26`",
specialised to the `N = 2` mass shell `L_0 φ = -φ` (i.e. `h = a₀ - 2 = -1` at `a₀ = 1`).

The hand computation of blueprint §B″.2 is confirmed verbatim: the coefficient is `D - 26`,
with no correction. -/
theorem towerLop_two_apply_descTwo (h0 : towerLop η a b 0 φ = -φ) :
    towerLop η a b 2 (descTwo η a b φ) = ((D : R) - 26) • φ := by
  have h0' : towerLop η a b 0 φ = (-1 : R) • φ := by rw [h0, neg_one_smul]
  rw [towerLop_two_apply_descTwo_of_eigenvalue η a b hη hpos h0']
  match_scalars
  ring

include hη in
/-- `L_0 𝒟₂ φ = 𝒟₂ φ`: on the `N = 2` shell the Type-2 vector has `L_0`-eigenvalue `1`, i.e. it
lives at intercept `a₀ = 1`.  Unconditional in `D`. -/
theorem towerLop_zero_apply_descTwo (h0 : towerLop η a b 0 φ = -φ) :
    towerLop η a b 0 (descTwo η a b φ) = descTwo η a b φ := by
  have h0' : towerLop η a b 0 φ = (-1 : R) • φ := by rw [h0, neg_one_smul]
  have hψ : towerLop η a b 0 (towerLop η a b (-1) φ) = 0 := by
    rw [towerLop_zero_apply_towerLop_neg_one η a b hη h0']
    match_scalars
    ring
  have hA : towerLop η a b 0 (towerLop η a b (-2) φ) = towerLop η a b (-2) φ := by
    rw [towerLop_zero_apply_towerLop_neg_two η a b hη h0']
    match_scalars
    ring
  have hB : towerLop η a b 0 (towerLop η a b (-1) (towerLop η a b (-1) φ))
      = towerLop η a b (-1) (towerLop η a b (-1) φ) := by
    rw [towerLop_apply_towerLop_of_ne_zero η a b hη (by decide : (0 : ℤ) + -1 ≠ 0)
      (towerLop η a b (-1) φ), hψ, map_zero, zero_add, show (0 : ℤ) + -1 = -1 by decide]
    match_scalars
    ring
  rw [descTwo_apply, map_add, map_smul, map_smul, hA, hB]

include hη hpos in
/-- `L_n 𝒟₂ φ = 0` for `n ≥ 3`: the grading kills these automatically.  Unconditional in `D`
and in the intercept. -/
theorem towerLop_apply_descTwo_of_three_le {n : ℤ} (hn : 3 ≤ n) :
    towerLop η a b n (descTwo η a b φ) = 0 := by
  have hA : towerLop η a b n (towerLop η a b (-2) φ) = 0 := by
    rw [towerLop_apply_towerLop_of_ne_zero η a b hη (by omega : n + -2 ≠ 0) φ,
      hpos n (by omega), map_zero, zero_add, hpos (n + -2) (by omega), smul_zero]
  have hB : towerLop η a b n (towerLop η a b (-1) φ) = 0 := by
    rw [towerLop_apply_towerLop_of_ne_zero η a b hη (by omega : n + -1 ≠ 0) φ,
      hpos n (by omega), map_zero, zero_add, hpos (n + -1) (by omega), smul_zero]
  have hC : towerLop η a b n (towerLop η a b (-1) (towerLop η a b (-1) φ)) = 0 := by
    have hD1 : towerLop η a b (n + -1) (towerLop η a b (-1) φ) = 0 := by
      rw [towerLop_apply_towerLop_of_ne_zero η a b hη (by omega : n + -1 + -1 ≠ 0) φ,
        hpos (n + -1) (by omega), map_zero, zero_add, hpos (n + -1 + -1) (by omega), smul_zero]
    rw [towerLop_apply_towerLop_of_ne_zero η a b hη (by omega : n + -1 ≠ 0)
      (towerLop η a b (-1) φ), hB, map_zero, zero_add, hD1, smul_zero]
  rw [descTwo_apply, map_add, map_smul, map_smul, hA, hC, smul_zero, smul_zero, add_zero]

include hη hpos in
/-- **Type 2 of blueprint §B″.2.1 is physical, exactly at `D = 26`.**

All four Virasoro conditions: `L_0` gives the intercept `1` unconditionally
(`towerLop_zero_apply_descTwo`), `L_1` vanishes because `h = -1`
(`towerLop_one_apply_descTwo`), `L_n` for `n ≥ 3` vanishes by grading, and **`L_2` vanishes iff
`D = 26`** (`towerLop_two_apply_descTwo`).  Blueprint §B″.8: this is the unique consumer of the
critical dimension in the whole `ddf-spans` thread. -/
theorem descTwo_mem_towerPhysSubmodule (hD26 : (D : R) = 26)
    (h0 : towerLop η a b 0 φ = -φ) :
    descTwo η a b φ ∈ towerPhysSubmodule η a b (1 : R) := by
  have h0' : towerLop η a b 0 φ = (-1 : R) • φ := by rw [h0, neg_one_smul]
  refine mem_towerPhysSubmodule.2 ⟨?_, fun m hm => ?_⟩
  · rw [towerLop_zero_apply_descTwo η a b hη h0, one_smul]
  · rcases lt_trichotomy m 2 with hm2 | hm2 | hm2
    · have hm1 : m = 1 := by omega
      subst hm1
      rw [towerLop_one_apply_descTwo η a b hη hpos h0']
      simp
    · subst hm2
      rw [towerLop_two_apply_descTwo η a b hη hpos h0, hD26, sub_self, zero_smul]
    · exact towerLop_apply_descTwo_of_three_le η a b hη hpos (by omega)

include hη hpos in
/-- **Type 2 gives a null state at `D = 26`.**  Spurious (`descTwo_mem_towerSpuriousSubmodule`)
and physical (`descTwo_mem_towerPhysSubmodule`), hence of zero norm and orthogonal to every
physical state by `towerSpurious_inf_towerPhys_le_towerNull`.

This is the single Type-2 seed that blueprint §B″.2.1 adds to the 25 Type-1 seeds to make up the
`26 = p_{25}(2) - p_{24}(2)` null states of the `N = 2` slice. -/
theorem descTwo_mem_towerNullSubmodule (hD26 : (D : R) = 26)
    (h0 : towerLop η a b 0 φ = -φ) :
    descTwo η a b φ ∈ towerNullSubmodule η a b (1 : R) :=
  towerSpurious_inf_towerPhys_le_towerNull η a b (1 : R)
    (Submodule.mem_inf.2 ⟨descTwo_mem_towerSpuriousSubmodule η a b φ,
      descTwo_mem_towerPhysSubmodule η a b hη hpos hD26 h0⟩)

include hη hpos in
/-- ⭐⭐ **`D = 26` is *necessary*, not merely sufficient.**  Over a domain, for a nonzero seed on
the `N = 2` shell, `L_2 𝒟₂ φ = 0` **iff** `(D : R) = 26`.

This is the sharp form of blueprint §B″.2's claim that `B26 2` is *equivalent* to `D = 26`, at
the operator level: the Kac side of the same statement is
`Fock.kacDet2_massShell_two_eq_zero_iff`. -/
theorem towerLop_two_apply_descTwo_eq_zero_iff [NoZeroDivisors R]
    (h0 : towerLop η a b 0 φ = -φ) (hφ : φ ≠ 0) :
    towerLop η a b 2 (descTwo η a b φ) = 0 ↔ (D : R) = 26 := by
  rw [towerLop_two_apply_descTwo η a b hη hpos h0, smul_eq_zero, sub_eq_zero]
  exact or_iff_left hφ

include hη hpos in
/-- ⭐⭐ **The Type-2 vector is physical exactly in the critical dimension.**

Over a domain and for a nonzero `N = 2` seed, `(2 L_{-2} + 3 L_{-1}²) φ ∈ H_phys` **iff**
`(D : R) = 26`.  The `L_0`, `L_1` and `L_{n ≥ 3}` conditions hold for every `D`; only `L_2` sees
the dimension.  Blueprint §B″.8. -/
theorem descTwo_mem_towerPhysSubmodule_iff [NoZeroDivisors R]
    (h0 : towerLop η a b 0 φ = -φ) (hφ : φ ≠ 0) :
    descTwo η a b φ ∈ towerPhysSubmodule η a b (1 : R) ↔ (D : R) = 26 := by
  refine ⟨fun hmem => ?_, fun hD26 => descTwo_mem_towerPhysSubmodule η a b hη hpos hD26 h0⟩
  exact (towerLop_two_apply_descTwo_eq_zero_iff η a b hη hpos h0 hφ).1
    ((mem_towerPhysSubmodule.1 hmem).2 2 (by decide))

end TypeTwo

/-! ### Bidegree bookkeeping and the concrete `N = 2` seeds

Both families raise the oscillator level and leave the rung alone, so they map the slice
`(rung j, level N)` into `(rung j, level N + 1)` resp. `(rung j, level N + 2)`.  Combined with
`towerLop_zero_apply_of_mem_towerBigrade` (`L_0 = α'k² + j + N` on a slice) this turns the
abstract seed hypotheses `hpos` / `h0` of the previous two sections into *slice* hypotheses,
which is the form blueprint §B″.2 uses: at intercept `a₀ = 1` (i.e. `k·k = 2`), a Type-1 seed
lives on a slice with `j + N = -1` and a Type-2 seed on one with `j + N = -2`.

For the `N = 2` antidiagonal slice `(rung -2, level 2)` of blueprint §B″.2 this gives the Type-2
state from the rung-`(-2)` oscillator vacuum, and the Type-1 states from level-1 seeds on rung
`-2`.  The 25 Type-1 seeds themselves (`(v · α_{-1})|0; p_{-2}⟩` with `v · p_{-2} = 0`) and the
linear independence of the resulting 26 null states are **not** constructed here; see the module
docstring. -/

section Slices

variable {D : ℕ} {R : Type*} [CommRing R] [Algebra ℚ R] (η a b : Fin D → R)

/-- **`𝒟₂` has bidegree `(0, +2)`**: it preserves the rung and raises the oscillator level by
two, since `L_{-2}` and `L_{-1}²` both do. -/
theorem descTwo_mem_towerBigrade {j : ℤ} {N : ℕ} {y : TowerFock D R}
    (hy : y ∈ towerBigrade D R j N) {N' : ℕ} (hN' : (N' : ℤ) = (N : ℤ) + 2) :
    descTwo η a b y ∈ towerBigrade D R j N' := by
  rw [descTwo_apply]
  refine Submodule.add_mem _ (Submodule.smul_mem _ _ ?_) (Submodule.smul_mem _ _ ?_)
  · exact towerLop_mem_towerBigrade η a b hy (by omega)
  · exact towerLop_mem_towerBigrade η a b
      (towerLop_mem_towerBigrade (N' := N + 1) η a b hy (by push_cast; ring))
      (by push_cast; omega)

variable (hη : ∀ μ, η μ * η μ = 1) (hbb : dotVec η b b = 0) (hba : dotVec η b a = 1)
variable (haa : Fock.zeroModeSq η a = 2)

include hη hbb hba haa in
/-- On a slice, at intercept `a₀ = 1` (which is what `k·k = 2` means), `L_0` acts by `1 + j + N`.
This is `towerLop_zero_apply_of_mem_towerBigrade` with the intercept evaluated. -/
lemma towerLop_zero_apply_of_mem_towerBigrade_of_zeroModeSq_eq_two {j : ℤ} {N : ℕ}
    {y : TowerFock D R} (hy : y ∈ towerBigrade D R j N) :
    towerLop η a b 0 y = ((1 : R) + (j : R) + (N : R)) • y := by
  rw [towerLop_zero_apply_of_mem_towerBigrade η a b hη hbb hba hy, haa, invTwo_mul_two]

include hη hbb hba haa in
/-- **Type 1 on a slice** (blueprint §B″.2.1): a seed on `(rung j, level N)` with `j + N = -1`
that is annihilated by all positive modes produces a null state on `(rung j, level N + 1)`.

`D` does not appear.  At `(j, N) = (-1, 0)` this is the photon null state `L_{-1}|0; p_{-1}⟩`
(compare `Assembly.ddfSpans_bigrade_neg_one_one`, which reaches the same slice by the DDF route);
at `(j, N) = (-2, 1)` it is the family that supplies `D - 1 = 25` of the 26 null states of the
`N = 2` slice. -/
theorem towerLop_neg_one_mem_towerNullSubmodule_of_mem_towerBigrade {j : ℤ} {N : ℕ}
    (hjN : j + (N : ℤ) = -1) {y : TowerFock D R} (hy : y ∈ towerBigrade D R j N)
    (hpos : ∀ n : ℤ, 0 < n → towerLop η a b n y = 0) :
    towerLop η a b (-1) y
      ∈ towerNullSubmodule η a b (1 : R) ⊓ towerBigrade D R j (N + 1) := by
  have hs : (1 : R) + (j : R) + (N : R) = 0 := by
    have hc : ((j + (N : ℤ) : ℤ) : R) = ((-1 : ℤ) : R) := by rw [hjN]
    push_cast at hc
    linear_combination hc
  have h0 : towerLop η a b 0 y = 0 := by
    rw [towerLop_zero_apply_of_mem_towerBigrade_of_zeroModeSq_eq_two η a b hη hbb hba haa hy, hs,
      zero_smul]
  exact Submodule.mem_inf.2
    ⟨towerLop_neg_one_mem_towerNullSubmodule hη hpos h0,
      towerLop_mem_towerBigrade η a b hy (by push_cast; ring)⟩

include hη hbb hba haa in
/-- **Type 2 on a level-`0` slice, i.e. the concrete `N = 2` null state of blueprint §B″.2.1.**

A rung-`(-2)` level-`0` vector automatically satisfies both seed hypotheses: the positive modes
annihilate it by grading, and `L_0` acts by `1 + (-2) + 0 = -1`.  Hence at `D = 26` the vector
`𝒟₂ y = (2 L_{-2} + 3 L_{-1}²) y` is a null physical state lying in the antidiagonal slice
`(rung -2, level 2)`.

This is the one Type-2 state that blueprint §B″.2.1 adds to the 25 Type-1 states; it is where
`D = 26` is consumed. -/
theorem descTwo_mem_towerNullSubmodule_of_mem_towerBigrade_neg_two (hD26 : (D : R) = 26)
    {y : TowerFock D R} (hy : y ∈ towerBigrade D R (-2) 0) :
    descTwo η a b y ∈ towerNullSubmodule η a b (1 : R) ⊓ towerBigrade D R (-2) 2 := by
  have hpos : ∀ n : ℤ, 0 < n → towerLop η a b n y = 0 := fun n hn =>
    towerLop_apply_eq_zero_of_mem_towerBigrade_of_lt η a b hy (by exact_mod_cast hn)
  have h0 : towerLop η a b 0 y = -y := by
    rw [towerLop_zero_apply_of_mem_towerBigrade_of_zeroModeSq_eq_two η a b hη hbb hba haa hy]
    push_cast
    module
  exact Submodule.mem_inf.2
    ⟨descTwo_mem_towerNullSubmodule η a b hη hpos hD26 h0,
      descTwo_mem_towerBigrade η a b hy (by norm_num)⟩

include hη hbb hba haa in
/-- The fully concrete instance: the rung-`(-2)` oscillator vacuum `|0; p_{-2}⟩` is a Type-2 seed,
so at `D = 26` and `k·k = 2` the state `(2 L_{-2} + 3 L_{-1}²)|0; p_{-2}⟩` is a null physical
state of the `N = 2` slice.  (Whether it is *nonzero* is not proved here; see the module
docstring.) -/
theorem descTwo_single_mem_towerNullSubmodule (hD26 : (D : R) = 26) :
    descTwo η a b (Finsupp.single (-2) (1 : Fock D R))
      ∈ towerNullSubmodule η a b (1 : R) ⊓ towerBigrade D R (-2) 2 :=
  descTwo_mem_towerNullSubmodule_of_mem_towerBigrade_neg_two η a b hη hbb hba haa hD26
    (single_mem_towerBigrade (Fock.one_mem_levelSubmodule D R))

end Slices

end StringFormal.NoGhost
