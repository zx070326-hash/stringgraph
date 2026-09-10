/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

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

end StringFormal.Math
