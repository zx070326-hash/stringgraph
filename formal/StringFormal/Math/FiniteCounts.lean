/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import Mathlib.Data.Nat.Choose.Sum
import Mathlib.Data.ZMod.Basic
import Mathlib.Data.Finset.Powerset

/-!
# Finite decidable counts appearing in string consistency arguments

Lean island 2, arithmetic corner. Everything here is a *finite, decidable* computation:
the statements are closed formulas over explicit finite index sets, settled by `decide`.
No physics enters; the physics is carried by the graph nodes named in each docstring,
which quote these numbers.

This file imports only Mathlib.

## Contents

* `hexagon_odd_twist_count` — graph node `math.hexagon-odd-twist-count`.
* namespace `SuperstringSectors` — the `(ℤ₂)⁴` sector-label exhaustion of Polchinski
  vol. 2 §10.6 (eqs. (10.6.1)–(10.6.6)): graph node
  `worldsheet.superstring-sector-consistency-solutions`.
-/

namespace StringFormal.Math

open Finset

/-- **The "32" of the type I hexagon.**

In the hexagon anomaly diagram of Green–Schwarz (1984) each of the six internal
open-string propagators of the hexagon may or may not be twisted, and the diagrams
contributing to the non-orientable amplitude are those with an **odd** number of twisted
internal lines. The number of such twist assignments is
`∑_{k odd, k ≤ 6} C(6, k) = C(6,1) + C(6,3) + C(6,5) = 6 + 20 + 6 = 32`,
the relative factor `32` between the planar and non-orientable hexagons, i.e. the factor
that singles out `n = 32` for `SO(n)` (Green–Schwarz 1984, eq. (12c); GSW vol. 2, p. 165).

The identity is the odd half of the binomial theorem: `∑_{k odd} C(n,k) = 2^(n-1)` for
`n ≥ 1`, here `2^5 = 32`. Only the arithmetic is formalised; that this count is the
combinatorial origin of the coefficient in (12c) is the content of the graph node
`math.hexagon-odd-twist-count` and is *not* proved here. -/
theorem hexagon_odd_twist_count :
    ∑ k ∈ (range 7).filter Odd, Nat.choose 6 k = 32 := by
  decide

/-!
## The `(ℤ₂)⁴` sector exhaustion of the ten-dimensional closed superstring

Polchinski vol. 2 §10.6, eqs. (10.6.1)–(10.6.6) (literature record
`literature/extractions/polchinski-1998-v2.md`, items E40–E44). Graph node
`worldsheet.superstring-sector-consistency-solutions`.

A closed-superstring sector is labelled by `(α, F, α̃, F̃) ∈ (ℤ₂)⁴`, where `α = 1 − 2ν`
is `1` in the R sector and `0` in the NS sector, and `exp(πiF)` is the world-sheet
fermion-number phase; "both `α` and `F` are defined only mod 2". The four left-moving
labels are written `NS±`, `R±` with the sign being `exp(πiF) = ±1`, i.e. `F = 0` resp.
`F = 1`.

Polchinski's three conditions on the set `S` of sectors present in the spectrum are
formalised here as:

* **level matching** (the remark "six of these sectors are empty"): `NS−` has half-integer
  `L₀ − α'p²/4` while `NS+`, `R+`, `R−` have integer level, so `L₀ = L̃₀` is impossible
  unless `NS−` is paired with `NS−`. This leaves the 10-element set `sectors`, whence
  Polchinski's "potentially `2¹⁰` combinations of sectors". Here it is a *definition*
  (`LevelMatched`) — the level computation itself is a separate graph node.
* **(a) mutual locality** (10.6.5): the phase `F₁α₂ − F₂α₁ − F̃₁α̃₂ + F̃₂α̃₁ ∈ 2ℤ`.
  This is `MutuallyLocal`, written in `ZMod 2` where the signs drop out; the bridge to the
  literal integer statement of (10.6.5) is `mutuallyLocal_iff_even`.
* **(b) OPE closure** (10.6.6): `S` is closed under addition (`FusionClosed`). Together
  with `S.Nonempty` this says `S` is a subgroup of `(ℤ₂)⁴` — note that closure *inside*
  `sectors` is a real constraint, e.g. `(R+,NS+) + (NS−,NS−) = (R−,NS−)` is an empty
  sector, so those two cannot coexist.
* **(c)** at least one left-moving and one right-moving R sector (`HasBothRamond`). This
  is Polchinski's "one simple necessary condition" extracted from modular invariance; that
  it *is* necessary is not proved here (§10.7, a separate graph node).

**The mathematical finding.** Conditions (a)(b)(c) *as literally stated* have **ten**
solutions, not six: the six that Polchinski lists (`consistentSpectra_eq`,
`consistentSpectra_card`) plus four spurious ones, `halfSpectra`, each consisting of
`(NS+,NS+)` together with a single R–R sector. Those four satisfy (a), (b) and (c) but are
*proper subgroups* of the listed solutions (`halfSpectra_ssubset_maximal`). Polchinski's
enumeration therefore uses an unstated fourth condition: the spectrum is **maximal**, i.e.
one keeps *all* sectors compatible with the ones present — which is exactly how the GSO
projection is phrased at (10.6.9)–(10.6.11) ("keeping all sectors with …"). Modulo that,
the exhaustion is exactly right: the maximal solutions are the six
`typeIIB, typeIIA, typeIIAprime, typeIIBprime, typeZeroA, typeZeroB`
(`mem_maximalSpectra_iff`), the four containing an R–NS sector are the type II ones and are
tachyon-free (`tachyonSector_notMem_of_hasRamondNeveuSchwarz`), and the two without are the
type 0 theories, which do contain the tachyon (`tachyonSector_mem_of_not_hasRamondNeveuSchwarz`).

**Not formalised here**: that these labels exhaust the sectors of the RNS string; the level
computation behind `LevelMatched`; the necessity of (c); that the spacetime reflection
(10.6.7) identifies `IIA' ≅ IIA` and `IIB' ≅ IIB` (so that the four type II solutions are
two physically distinct theories); and that the type 0 solutions are modular invariant.
-/

namespace SuperstringSectors

/-- A closed-superstring **sector label** `(α, F, α̃, F̃) ∈ (ℤ₂)⁴` (Polchinski (10.6.3)). -/
abbrev Sector := ZMod 2 × ZMod 2 × ZMod 2 × ZMod 2

/-- `α`: `1` in the left-moving R sector, `0` in the left-moving NS sector. -/
def alphaL (s : Sector) : ZMod 2 := s.1

/-- `F`: the left-moving world-sheet fermion number mod 2, `exp(πiF) = (−1)^F`. -/
def fermL (s : Sector) : ZMod 2 := s.2.1

/-- `α̃`: the right-moving R/NS label. -/
def alphaR (s : Sector) : ZMod 2 := s.2.2.1

/-- `F̃`: the right-moving world-sheet fermion number mod 2. -/
def fermR (s : Sector) : ZMod 2 := s.2.2.2

/-- Build a sector from a left-moving label `(α, F)` and a right-moving label `(α̃, F̃)`. -/
def sector (left right : ZMod 2 × ZMod 2) : Sector := (left.1, left.2, right.1, right.2)

/-- The NS sector with `exp(πiF) = +1`. -/
def NSplus : ZMod 2 × ZMod 2 := (0, 0)

/-- The NS sector with `exp(πiF) = −1`; this is where the tachyon lives, and it is the
one with half-integer level. -/
def NSminus : ZMod 2 × ZMod 2 := (0, 1)

/-- The R sector with `exp(πiF) = +1`. -/
def Rplus : ZMod 2 × ZMod 2 := (1, 0)

/-- The R sector with `exp(πiF) = −1`. -/
def Rminus : ZMod 2 × ZMod 2 := (1, 1)

/-- The closed-string tachyon sector `(NS−,NS−)`. -/
def tachyonSector : Sector := sector NSminus NSminus

/-- Level matching `L₀ = L̃₀` is possible only if `NS−` is paired with `NS−`: in `NS−` the
level `L₀ − α'p²/4` is half-integer, in `NS+`, `R+`, `R−` it is an integer. -/
def LevelMatched (s : Sector) : Prop :=
  (alphaL s = 0 ∧ fermL s = 1) ↔ (alphaR s = 0 ∧ fermR s = 1)

instance (s : Sector) : Decidable (LevelMatched s) :=
  inferInstanceAs (Decidable ((alphaL s = 0 ∧ fermL s = 1) ↔ (alphaR s = 0 ∧ fermR s = 1)))

/-- The non-empty sectors: 10 of the 16 labels survive level matching, giving Polchinski's
"potentially `2¹⁰` combinations of sectors". -/
def sectors : Finset Sector := univ.filter LevelMatched

/-- Polchinski (10.6.5), condition (a): the phase picked up when one vertex operator
circles another, `F₁α₂ − F₂α₁ − F̃₁α̃₂ + F̃₂α̃₁`, is even. Stated in `ZMod 2`, where the
signs are irrelevant; see `mutuallyLocal_iff_even`. -/
def MutuallyLocal (x y : Sector) : Prop :=
  fermL x * alphaL y + fermL y * alphaL x + fermR x * alphaR y + fermR y * alphaR x = 0

instance (x y : Sector) : Decidable (MutuallyLocal x y) :=
  inferInstanceAs (Decidable
    (fermL x * alphaL y + fermL y * alphaL x + fermR x * alphaR y + fermR y * alphaR x = 0))

/-- Polchinski (10.6.6), condition (b): the spectrum is closed under the OPE, i.e. under
addition of labels. -/
def FusionClosed (S : Finset Sector) : Prop := ∀ x ∈ S, ∀ y ∈ S, x + y ∈ S

instance (S : Finset Sector) : Decidable (FusionClosed S) :=
  inferInstanceAs (Decidable (∀ x ∈ S, ∀ y ∈ S, x + y ∈ S))

/-- Condition (a) for a whole spectrum. -/
def MutuallyLocalSpectrum (S : Finset Sector) : Prop := ∀ x ∈ S, ∀ y ∈ S, MutuallyLocal x y

instance (S : Finset Sector) : Decidable (MutuallyLocalSpectrum S) :=
  inferInstanceAs (Decidable (∀ x ∈ S, ∀ y ∈ S, MutuallyLocal x y))

/-- Polchinski's condition (c): at least one left-moving and one right-moving R sector. -/
def HasBothRamond (S : Finset Sector) : Prop :=
  (∃ x ∈ S, alphaL x = 1) ∧ (∃ x ∈ S, alphaR x = 1)

instance (S : Finset Sector) : Decidable (HasBothRamond S) :=
  inferInstanceAs (Decidable ((∃ x ∈ S, alphaL x = 1) ∧ (∃ x ∈ S, alphaR x = 1)))

/-- A spectrum has spacetime fermions iff it contains an R–NS sector, `(α, α̃) = (1, 0)`.
Polchinski organises the exhaustion by first assuming such a sector exists. -/
def HasRamondNeveuSchwarz (S : Finset Sector) : Prop := ∃ x ∈ S, alphaL x = 1 ∧ alphaR x = 0

instance (S : Finset Sector) : Decidable (HasRamondNeveuSchwarz S) :=
  inferInstanceAs (Decidable (∃ x ∈ S, alphaL x = 1 ∧ alphaR x = 0))

/-- The three consistency conditions of Polchinski §10.6, on a non-empty set of non-empty
sectors. -/
def IsConsistentSpectrum (S : Finset Sector) : Prop :=
  S.Nonempty ∧ FusionClosed S ∧ MutuallyLocalSpectrum S ∧ HasBothRamond S

instance (S : Finset Sector) : Decidable (IsConsistentSpectrum S) :=
  inferInstanceAs (Decidable
    (S.Nonempty ∧ FusionClosed S ∧ MutuallyLocalSpectrum S ∧ HasBothRamond S))

/-- All subsets of the 10 non-empty sectors satisfying (a), (b), (c). -/
def consistentSpectra : Finset (Finset Sector) := sectors.powerset.filter IsConsistentSpectrum

/-- `IIB`: `(NS+,NS+) (R+,NS+) (NS+,R+) (R+,R+)`. -/
def typeIIB : Finset Sector :=
  {sector NSplus NSplus, sector Rplus NSplus, sector NSplus Rplus, sector Rplus Rplus}

/-- `IIA`: `(NS+,NS+) (R+,NS+) (NS+,R−) (R+,R−)`. -/
def typeIIA : Finset Sector :=
  {sector NSplus NSplus, sector Rplus NSplus, sector NSplus Rminus, sector Rplus Rminus}

/-- `IIA′`: `(NS+,NS+) (R−,NS+) (NS+,R+) (R−,R+)`; related to `IIA` by the spacetime
reflection (10.6.7). -/
def typeIIAprime : Finset Sector :=
  {sector NSplus NSplus, sector Rminus NSplus, sector NSplus Rplus, sector Rminus Rplus}

/-- `IIB′`: `(NS+,NS+) (R−,NS+) (NS+,R−) (R−,R−)`; related to `IIB` by (10.6.7). -/
def typeIIBprime : Finset Sector :=
  {sector NSplus NSplus, sector Rminus NSplus, sector NSplus Rminus, sector Rminus Rminus}

/-- `0A`: `(NS+,NS+) (NS−,NS−) (R+,R−) (R−,R+)`. -/
def typeZeroA : Finset Sector :=
  {sector NSplus NSplus, sector NSminus NSminus, sector Rplus Rminus, sector Rminus Rplus}

/-- `0B`: `(NS+,NS+) (NS−,NS−) (R+,R+) (R−,R−)`. -/
def typeZeroB : Finset Sector :=
  {sector NSplus NSplus, sector NSminus NSminus, sector Rplus Rplus, sector Rminus Rminus}

/-- The six spectra Polchinski lists: IIB, IIA, IIA′, IIB′, 0A, 0B. -/
def maximalSpectra : Finset (Finset Sector) :=
  {typeIIB, typeIIA, typeIIAprime, typeIIBprime, typeZeroA, typeZeroB}

/-- The four solutions of (a)(b)(c) that Polchinski does *not* list: `(NS+,NS+)` together
with one R–R sector. They are proper subgroups of the six above. -/
def halfSpectra : Finset (Finset Sector) :=
  {{sector NSplus NSplus, sector Rplus Rplus}, {sector NSplus NSplus, sector Rplus Rminus},
    {sector NSplus NSplus, sector Rminus Rplus}, {sector NSplus NSplus, sector Rminus Rminus}}

/-- Ten of the sixteen labels `(α, F, α̃, F̃)` describe a non-empty sector; this is the
`2¹⁰` of "there are potentially `2¹⁰` combinations of sectors" (Polchinski §10.6). -/
theorem sectors_card : sectors.card = 10 := by decide

/-- The `ZMod 2` form of condition (a) used here agrees with the literal integer statement
of Polchinski (10.6.5), `F₁α₂ − F₂α₁ − F̃₁α̃₂ + F̃₂α̃₁ ∈ 2ℤ`. -/
theorem mutuallyLocal_iff_even : ∀ x y : Sector,
    (((fermL x).val * (alphaL y).val - (fermL y).val * (alphaL x).val
        - (fermR x).val * (alphaR y).val + (fermR y).val * (alphaR x).val : ℤ) % 2 = 0)
      ↔ MutuallyLocal x y := by
  decide

set_option maxRecDepth 100000 in
/-- **The exhaustion.** The subsets of the ten non-empty sectors satisfying Polchinski's
three conditions (a), (b), (c) of §10.6 are exactly the six spectra he lists together with
four proper subgroups of them (see `halfSpectra`, `halfSpectra_ssubset_maximal`). -/
theorem consistentSpectra_eq : consistentSpectra = maximalSpectra ∪ halfSpectra := by
  decide +kernel

/-- Ten solutions, not six: the gap in the textbook enumeration is exactly the four
non-maximal ones. -/
theorem consistentSpectra_card : consistentSpectra.card = 10 := by
  rw [consistentSpectra_eq]; decide

/-- Polchinski's six. -/
theorem maximalSpectra_card : maximalSpectra.card = 6 := by decide

/-- Each of the four extra solutions is strictly contained in one of the six. -/
theorem halfSpectra_ssubset_maximal : ∀ S ∈ halfSpectra, ∃ T ∈ maximalSpectra, S ⊂ T := by
  decide

/-- **Polchinski's list is exactly the set of maximal solutions.** Adding "the spectrum
contains every sector compatible with those it contains" — the form in which the GSO
projection is stated at (10.6.9)–(10.6.11) — turns the three conditions into an exhaustion
with exactly the six listed solutions. -/
theorem mem_maximalSpectra_iff : ∀ S ∈ consistentSpectra,
    ((∀ T ∈ consistentSpectra, S ⊆ T → T = S) ↔ S ∈ maximalSpectra) := by
  rw [consistentSpectra_eq]; decide

/-- The maximal solutions with an R–NS sector (equivalently, with spacetime fermions) are
the four type II ones. -/
theorem maximalSpectra_filter_hasRamondNeveuSchwarz :
    maximalSpectra.filter HasRamondNeveuSchwarz =
      {typeIIB, typeIIA, typeIIAprime, typeIIBprime} := by
  decide

/-- The maximal solutions without an R–NS sector are the two type 0 ones. -/
theorem maximalSpectra_filter_not_hasRamondNeveuSchwarz :
    maximalSpectra.filter (fun S => ¬ HasRamondNeveuSchwarz S) = {typeZeroA, typeZeroB} := by
  decide

/-- **No tachyon in type II.** Polchinski's "none of these theories contains the tachyon,
which lives in the sector `(NS−,NS−)`": the tachyon is absent from every maximal solution
that has an R–NS sector. In this formulation the tachyon is removed by the consistency
conditions themselves, not by a separately postulated GSO projection. -/
theorem tachyonSector_notMem_of_hasRamondNeveuSchwarz :
    ∀ S ∈ maximalSpectra, HasRamondNeveuSchwarz S → tachyonSector ∉ S := by
  decide

/-- Conversely the two maximal solutions without spacetime fermions — the type 0 theories —
both contain the tachyon. -/
theorem tachyonSector_mem_of_not_hasRamondNeveuSchwarz :
    ∀ S ∈ maximalSpectra, ¬ HasRamondNeveuSchwarz S → tachyonSector ∈ S := by
  decide

end SuperstringSectors

end StringFormal.Math
