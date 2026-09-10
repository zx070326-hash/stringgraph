/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring
import Mathlib.Tactic.LinearCombination

/-!
# Ten-dimensional anomaly twelve-forms: the purely algebraic content

Lean island 2. Standalone: imports only Mathlib, nothing from `StringFormal`.

Two facts are isolated here, both of which the physics literature *asserts* without
displaying the arithmetic:

1. Polchinski's factorized `N = 1` twelve-form (12.2.27)+(12.2.28a,b) is the *same
   polynomial* as the term-by-term form obtained from (12.2.11)+(12.2.12).
2. The three integer conditions of Polchinski (12.2.14) (IIB gravitational anomaly
   cancellation) have exactly the one-parameter solution family
   `n_{3/2} = 2 n_A`, `n_{1/2} = -2 n_A`.

## What is a variable here, and what is not

The six traces `tr R₂²`, `tr R₂⁴`, `tr R₂⁶`, `Tr_a F₂²`, `Tr_a F₂⁴`, `Tr_a F₂⁶` are
treated as six **independent commuting scalars** over a field of characteristic zero,
and `n` (the dimension of the representation, `n = Tr(1)`; for the adjoint, the number
of gauge generators) as a seventh. This is legitimate *for the identity being proved*
because both sides are polynomials in exactly those symbols with rational coefficients
and no relation among them is used.

It is **not** legitimate as a model of the twelve-forms themselves: the actual objects
are differential forms, `tr R₂⁶` etc. are wedge monomials, and for any *specific* Lie
algebra there are trace identities (e.g. `math.so-usp-adjoint-fundamental-trace-identities`)
relating them. Those identities are separate graph nodes and are deliberately not used.
Consequently nothing here says whether the anomaly *cancels* for any particular group;
it only says the two published forms of the polynomial agree.

Everything upstream — that these polynomials *are* the anomalies, the descent
equations, the normalisation `-i/(2π)⁵` of (12.2.10) — is physics carried by the graph
(`consistency.*`), not by this file. Polchinski is explicit that the twelve-forms
(12.2.11)–(12.2.13) are quoted, not derived: "The anomaly polynomials have been
calculated."

## Contents

* `anomaly_polynomial_factorized_eq_expanded` — Polchinski (12.2.27)+(12.2.28a,b)
  equals (12.2.11)+(12.2.12) assembled per (12.2.27)'s first line.
  Second source: Anastasopoulos–Dijkstra–Trincherini (ADT 2010) eq. (7)+(8), which the
  extraction record verifies is term-by-term identical to (12.2.27)+(12.2.28).
* `iib_gravitational_anomaly_cancels` — Polchinski (12.2.14), the type IIB content
  `(n_{3/2}, n_{1/2}, n_A) = (2, -2, 1)` gives zero.
* `iib_gravitational_anomaly_solutions` — the three integer conditions of (12.2.14)
  hold iff `n_{3/2} = 2 n_A` and `n_{1/2} = -2 n_A`.
* `iib_anomaly_polynomial_vanishes_iff`, `iib_gravitational_anomaly_free_iff` — those
  three conditions are exactly identical vanishing of the twelve-form.
* `gs_gravitational_twelve_form_eq_polchinski` — the gravitational part of Polchinski
  (12.2.27) is `-1/96` times Green–Schwarz (1984) eq. (20). A cross-check between two
  independent sources, not part of either A8 or A9.

## Conventions

Polchinski's §12.2 conventions, as transcribed in
`literature/extractions/polchinski-1998-v2-ch12.md`:
`tr` is the trace in the vector (tangent-space) representation for `R₂`;
`Tr_a` is the trace in the adjoint for `F₂`; wedge products are suppressed throughout
§12.2, so juxtaposition means `∧`.
-/

namespace StringFormal.Math

variable {K : Type*} [Field K] [CharZero K]

/-- Polchinski (12.2.11), the anomaly twelve-form of a Majorana–Weyl **8** in a
representation `r` of dimension `n = Tr(1)`, transcribed verbatim:

```
Î_8(F₂,R₂) = − Tr(F₂⁶)/1440
             + Tr(F₂⁴)tr(R₂²)/2304 − Tr(F₂²)tr(R₂⁴)/23040 − Tr(F₂²)[tr(R₂²)]²/18432
             + n tr(R₂⁶)/725760 + n tr(R₂⁴)tr(R₂²)/552960 + n [tr(R₂²)]³/1327104
```
-/
noncomputable def Ihat8 (n trR2 trR4 trR6 TrF2 TrF4 TrF6 : K) : K :=
  -TrF6 / 1440
    + TrF4 * trR2 / 2304 - TrF2 * trR4 / 23040 - TrF2 * trR2 ^ 2 / 18432
    + n * trR6 / 725760 + n * trR4 * trR2 / 552960 + n * trR2 ^ 3 / 1327104

/-- Polchinski (12.2.12), the anomaly twelve-form of a Majorana–Weyl gravitino **56**,
transcribed verbatim:

```
Î_56(F₂,R₂) = −495 tr(R₂⁶)/725760 + 225 tr(R₂⁴)tr(R₂²)/552960 − 63 [tr(R₂²)]³/1327104
```

(The book writes the argument as `Î_56(F₂,R₂)` here but as `Î_56(R₂)` in (12.2.14) and
(12.2.27); only `R₂` occurs, so we take the latter.) -/
noncomputable def Ihat56 (trR2 trR4 trR6 : K) : K :=
  -495 * trR6 / 725760 + 225 * trR4 * trR2 / 552960 - 63 * trR2 ^ 3 / 1327104

/-- Polchinski (12.2.28a): `Y₄ = tr(R₂²) − (1/30)Tr_a(F₂²)`. -/
noncomputable def Y4 (trR2 TrF2 : K) : K := trR2 - TrF2 / 30

/-- Polchinski (12.2.28b), transcribed verbatim:

```
X₈ = tr(R₂⁴) + [tr(R₂²)]²/4 − Tr_a(F₂²)tr(R₂²)/30 + Tr_a(F₂⁴)/3 − [Tr_a(F₂²)]²/900
```

This is the earliest *explicit* textbook formula for the eight-form `X₈`; the symbol
does not occur in Green–Schwarz (1984). -/
noncomputable def X8 (trR2 trR4 TrF2 TrF4 : K) : K :=
  trR4 + trR2 ^ 2 / 4 - TrF2 * trR2 / 30 + TrF4 / 3 - TrF2 ^ 2 / 900

/-- The total `d = 10`, `N = 1` anomaly twelve-form in **expanded** form: the first line
of Polchinski (12.2.27),

```
Î_I = Î_56(R₂) − Î_8(R₂) + Î_8(F₂,R₂)
```

with (12.2.11) and (12.2.12) substituted. The chiral content is the gravitino **56**, a
neutral fermion **8′**, and an **8** gaugino in the adjoint.

The neutral fermion enters as `Ihat8` with vanishing gauge traces and `n = 1`: `n = Tr(1)`
is the dimension of the representation and a neutral field sits in the trivial
representation. Polchinski does not write this step out — it is `inferred` in the graph
sense — but it is forced by his own definition of `n` and is what makes the `n − 496`
bookkeeping of (12.2.27) come out (`(n − 1) − 495 = n − 496`). -/
noncomputable def IhatN1Expanded (n trR2 trR4 trR6 TrF2 TrF4 TrF6 : K) : K :=
  Ihat56 trR2 trR4 trR6 - Ihat8 1 trR2 trR4 trR6 0 0 0
    + Ihat8 n trR2 trR4 trR6 TrF2 TrF4 TrF6

/-- The total `d = 10`, `N = 1` anomaly twelve-form in **factorized** form, Polchinski
(12.2.27), transcribed verbatim:

```
Î_I = (1/1440){ −Tr_a(F₂⁶) + (1/48)Tr_a(F₂²)Tr_a(F₂⁴) − [Tr_a(F₂²)]³/14400 }
      + (n − 496){ tr(R₂⁶)/725760 + tr(R₂⁴)tr(R₂²)/552960 + [tr(R₂²)]³/1327104 }
      + Y₄X₈/768
```

Here `n` is the total number of gauge generators (the dimension of the adjoint).
Identical, term by term and coefficient by coefficient, to ADT (2010) eq. (7). -/
noncomputable def IhatN1Factorized (n trR2 trR4 trR6 TrF2 TrF4 TrF6 : K) : K :=
  (1 / 1440) * (-TrF6 + (1 / 48) * TrF2 * TrF4 - TrF2 ^ 3 / 14400)
    + (n - 496) * (trR6 / 725760 + trR4 * trR2 / 552960 + trR2 ^ 3 / 1327104)
    + Y4 trR2 TrF2 * X8 trR2 trR4 TrF2 TrF4 / 768

/-- **Polchinski (12.2.27)+(12.2.28a,b) = (12.2.11)+(12.2.12).**

The factorized twelve-form and the term-by-term twelve-form are the same polynomial in
the six trace monomials and the generator count `n`.

Polchinski asserts the rearrangement without displaying it ("The anomaly has been
organized into a sum of three terms"). It is a genuine identity only because of three
cancellations that are invisible in the printed formulas:

* `Tr_a(F₂²)Tr_a(F₂⁴)`: `+(1/1440)(1/48) = +1/69120` against `−1/(30·3·768) = −1/69120`;
* `[Tr_a(F₂²)]³`: `−(1/1440)(1/14400)` against `+1/(30·900·768)`, both `1/20736000`;
* `[Tr_a(F₂²)]² tr(R₂²)`: the two contributions `+1/900` and `−1/900` cancel *inside*
  `Y₄X₈`, which is why (12.2.27) correctly has no such term.

Since this holds for arbitrary independent `trR2 … TrF6` and arbitrary `n`, it also
certifies ADT (7)+(8) against Polchinski (12.2.11)+(12.2.12). -/
theorem anomaly_polynomial_factorized_eq_expanded (n trR2 trR4 trR6 TrF2 TrF4 TrF6 : K) :
    IhatN1Factorized n trR2 trR4 trR6 TrF2 TrF4 TrF6
      = IhatN1Expanded n trR2 trR4 trR6 TrF2 TrF4 TrF6 := by
  unfold IhatN1Factorized IhatN1Expanded Ihat8 Ihat56 Y4 X8
  ring

/-! ### Type IIB: the gravitational anomaly (Polchinski (12.2.13), (12.2.14)) -/

/-- Polchinski (12.2.13), the anomaly twelve-form of a self-dual five-form field strength
`[5]₊`, transcribed verbatim:

```
Î_SD(R₂) = 992 tr(R₂⁶)/725760 − 448 tr(R₂⁴)tr(R₂²)/552960 + 128 [tr(R₂²)]³/1327104
```
-/
noncomputable def IhatSD (trR2 trR4 trR6 : K) : K :=
  992 * trR6 / 725760 - 448 * trR4 * trR2 / 552960 + 128 * trR2 ^ 3 / 1327104

/-- The purely gravitational twelve-form of a `d = 10` chiral field content consisting of
`n32` gravitinos **56**, `n12` Majorana–Weyl fermions **8** and `nA` self-dual tensors
`[5]₊`, all counted *net* of their parity conjugates (a **8′** counts as `-1` towards
`n12`, etc., since "parity interchanges the two fields in each pair so these make
opposite contributions to the anomaly").

The fermion term is `Ihat8` at `n = 1` and vanishing gauge traces: type IIB has no gauge
fields, and a neutral field sits in the trivial representation so `n = Tr(1) = 1`. -/
noncomputable def IhatIIB (n32 n12 nA trR2 trR4 trR6 : K) : K :=
  n12 * Ihat8 1 trR2 trR4 trR6 0 0 0 + n32 * Ihat56 trR2 trR4 trR6
    + nA * IhatSD trR2 trR4 trR6

/-- **Polchinski (12.2.14).** Type IIB supergravity has "two **8′**s, two **56**s, and one
`[5]₊`", i.e. `n32 = 2`, `n12 = -2`, `nA = 1`, and

```
Î_IIB(R₂) = −2Î_8(R₂) + 2Î_56(R₂) + Î_SD(R₂) = 0 .
```

Polchinski asserts this without displaying the arithmetic ("the coefficients of these
conspire to produce zero total anomaly"). The three coefficients are
`(-2 - 990 + 992)/725760`, `(-2 + 450 - 448)/552960`, `(-2 - 126 + 128)/1327104`. -/
theorem iib_gravitational_anomaly_cancels (trR2 trR4 trR6 : K) :
    IhatIIB 2 (-2) 1 trR2 trR4 trR6 = 0 := by
  unfold IhatIIB Ihat8 Ihat56 IhatSD
  ring

/-- **The three integer conditions of Polchinski (12.2.14) have exactly a one-parameter
family of solutions.**

For a purely gravitational `d = 10` anomaly, requiring each of the three monomials
`tr R₂⁶`, `tr R₂⁴ tr R₂²`, `[tr R₂²]³` to cancel gives three linear conditions on the net
field counts `a = n_{3/2}` (gravitinos **56**), `b = n_{1/2}` (fermions **8**),
`c = n_A` (self-dual tensors). They are equivalent to `a = 2c` and `b = -2c`.

The coefficients are the numerators of (12.2.11) at `n = 1`, (12.2.12), (12.2.13) over
their respective common denominators `725760`, `552960`, `1327104`. Bilal's lectures give
the same system in the same normalisation, e.g. `-495 n_{3/2} + n_{1/2} + 992 n_A = 0`.

Two things worth recording. First, the system has **rank two, not three** — any two of the
three equations already force `a = 2c`, and the third is then automatic; so the "three
conditions, three parameters" counting that makes Polchinski call the cancellation
"miraculous" and "accidental" is slightly generous to the miracle: there are effectively
two conditions on three parameters, and a one-dimensional solution space is expected.
What is *not* automatic is that the solution has the small integer content `(2, -2, 1)`
realised by IIB supergravity. Second, the solution family is genuinely a **lattice**: no
divisibility obstruction appears, so every integer multiple of `(2, -2, 1)` solves it and
nothing else does. -/
theorem iib_gravitational_anomaly_solutions (a b c : ℤ) :
    (-495 * a + b + 992 * c = 0 ∧ 225 * a + b - 448 * c = 0 ∧ -63 * a + b + 128 * c = 0)
      ↔ (a = 2 * c ∧ b = -2 * c) := by
  omega

/-- The three linear conditions of `iib_gravitational_anomaly_solutions` really are the
condition that the twelve-form *vanish as a polynomial*, not merely a convenient
repackaging: the three monomials `tr R₂⁶`, `tr R₂⁴ tr R₂²`, `[tr R₂²]³` are independent,
so `Î` vanishes for all values of the traces exactly when all three coefficients do.

The forward direction is by evaluation at `(tr R₂², tr R₂⁴, tr R₂⁶) = (0,0,1), (1,1,0),
(1,0,0)`. Note this is a statement about the *formal* twelve-form. For a fixed spacetime
dimension the wedge monomials of a curvature two-form need not be pointwise independent;
the physics argument treats them as independent, and that is what is formalised. -/
theorem iib_anomaly_polynomial_vanishes_iff (a b c : K) :
    (∀ trR2 trR4 trR6 : K, IhatIIB a b c trR2 trR4 trR6 = 0)
      ↔ (-495 * a + b + 992 * c = 0 ∧ 225 * a + b - 448 * c = 0
          ∧ -63 * a + b + 128 * c = 0) := by
  constructor
  · intro h
    have h1 := h 0 0 1
    have h2 := h 1 1 0
    have h3 := h 1 0 0
    unfold IhatIIB Ihat8 Ihat56 IhatSD at h1 h2 h3
    refine ⟨by linear_combination 725760 * h1, ?_, by linear_combination 1327104 * h3⟩
    linear_combination 552960 * h2 - 552960 * h3
  · rintro ⟨e1, e2, e3⟩ trR2 trR4 trR6
    unfold IhatIIB Ihat8 Ihat56 IhatSD
    linear_combination (trR6 / 725760) * e1 + (trR4 * trR2 / 552960) * e2
      + (trR2 ^ 3 / 1327104) * e3

/-- **The complete statement of Polchinski (12.2.14).** For an integer chiral field
content — `a` gravitinos **56**, `b` Majorana–Weyl fermions **8**, `c` self-dual tensors
`[5]₊`, each counted net of parity conjugates — the total `d = 10` purely gravitational
anomaly twelve-form vanishes identically **iff** `a = 2c` and `b = -2c`.

Type IIB is the case `c = 1`, and `iib_gravitational_anomaly_cancels` is that instance. -/
theorem iib_gravitational_anomaly_free_iff (a b c : ℤ) :
    (∀ trR2 trR4 trR6 : K, IhatIIB (a : K) (b : K) (c : K) trR2 trR4 trR6 = 0)
      ↔ (a = 2 * c ∧ b = -2 * c) := by
  rw [iib_anomaly_polynomial_vanishes_iff, ← iib_gravitational_anomaly_solutions a b c]
  constructor
  · rintro ⟨h1, h2, h3⟩
    exact ⟨by exact_mod_cast h1, by exact_mod_cast h2, by exact_mod_cast h3⟩
  · rintro ⟨h1, h2, h3⟩
    exact ⟨by exact_mod_cast h1, by exact_mod_cast h2, by exact_mod_cast h3⟩

/-! ### Cross-check against Green–Schwarz (1984) eq. (20) -/

/-- Green–Schwarz (1984) eq. (20), the purely gravitational twelve-form of `d = 10`,
`N = 1` supergravity coupled to super Yang–Mills with `n` matter fermions, transcribed
from `consistency.gravitational-anomaly-polynomial-d10`:

```
− [ 1/32 + (n − 496)/13824 ] (tr R²)³
− [ 1/8  + (n − 496)/5760  ] tr R² tr R⁴
− [        (n − 496)/7560  ] tr R⁶
```

Same chiral content as Polchinski's `Î_I`: one left-handed spin-3/2 gravitino, one
right-handed spin-1/2 field, and `n` left-handed spin-1/2 fields in the adjoint, `n`
being the dimension of the gauge group. -/
noncomputable def GS20Gravitational (n trR2 trR4 trR6 : K) : K :=
  -(1 / 32 + (n - 496) / 13824) * trR2 ^ 3
    - (1 / 8 + (n - 496) / 5760) * trR2 * trR4
    - ((n - 496) / 7560) * trR6

/-- **Green–Schwarz (1984) eq. (20) and Polchinski (12.2.27) are the same polynomial up to
the single overall factor `-1/96`.**

Setting the gauge traces to zero in `IhatN1Factorized` leaves the purely gravitational
twelve-form, and it agrees with GS (20) *coefficient by coefficient* — all five
coefficients, including the two `n`-independent ones (`1/8` and `1/32`) that come from
`Y₄X₈/768` on Polchinski's side and are not visible as such in GS's presentation.

This is a genuine cross-check between two independent sources whose overall
normalisations the graph deliberately does not identify: GS 1984 outsources the constant
`c` (and hence the overall scale) to Alvarez-Gaumé–Witten, whereas Polchinski fixes
`-i/(2π)⁵` in (12.2.10) without saying where it comes from. That the *whole* gravitational
polynomial matches with one constant — rather than requiring separate rescalings for the
`n`-dependent and `n`-independent parts — is evidence that the two normalisations differ
only by that constant.

Note this is *stronger* than the `3/4` bracket-ratio cross-check against Bilal (2008)
recorded in the notes of `consistency.gravitational-anomaly-polynomial-d10`: that
comparison rescales the bracket contents, so it does not test the `n`-independent terms
against the `n`-dependent ones at a fixed overall scale. Here a single constant `-1/96`
does all five. -/
theorem gs_gravitational_twelve_form_eq_polchinski (n trR2 trR4 trR6 : K) :
    IhatN1Factorized n trR2 trR4 trR6 0 0 0
      = -(1 / 96) * GS20Gravitational n trR2 trR4 trR6 := by
  unfold IhatN1Factorized GS20Gravitational Y4 X8
  ring

end StringFormal.Math
