# Paper outline: Lean 4 islands for Virasoro representation theory and the DDF construction

Status: draft skeleton, ITP/CPP-style. Every claim below points at a file or a Lean
declaration in `formal/StringFormal/`; unverified claims are marked `[verify: ...]`.

## 1. Title candidates and abstract

**Title candidates**

1. *DDF Operators and the Shapovalov Form, Formally: Lean 4 Islands for Bosonic
   String Representation Theory*
2. *Formalizing the Algebraic Core of the Goddard–Thorn Construction: Kac
   Determinants, DDF Operators, and Green–Schwarz Factorization in Lean 4*
3. *Towards a Machine-Checked No-Ghost Theorem: Six Lean 4 Islands in Virasoro and
   Vertex-Operator Representation Theory*

**Abstract**

We report a Lean 4 / Mathlib development of six representation-theoretic components
used in the Goddard–Thorn no-ghost theorem of bosonic string theory, together with an
independent island formalizing the algebraic core of Green–Schwarz anomaly
factorization. Concretely, we formalize: (i) the Shapovalov (contravariant) form on
Virasoro Verma modules — existence, uniqueness, and level orthogonality, unconditional
in the highest-weight vector; (ii) the Kac determinant formula verified as instances at
levels `N ≤ 4`, matching Kac's factored product form; (iii) the algebra of transverse
DDF operators on a momentum-graded ("tower") Fock space over an arbitrary commutative
`ℚ`-algebra — commutation with every Virasoro mode, mutual adjointness, the oscillator
bracket `⁅Aᵉₘ, Aᵟₙ⁆ = m(ε·δ)δ_{m+n,0}`, and commutation with the Goddard longitudinal
operators `Kₙ`; (iv) a `D`-component Fock space carrying a Lorentzian (indefinite)
`η`-form together with a Sugawara construction whose central charge is `c = D` for
arbitrary `D`; (v) the Green–Schwarz twelve-form factorization identity and the
uniqueness of the integer solution to the type IIB gravitational-anomaly cancellation
conditions, both as algebraic identities over an arbitrary commutative `ℚ`-algebra; and
(vi) explicit power-sum identities for the 240 roots of `E₈`. All declarations compile
without `sorry` and depend only on `propext`, `Classical.choice`, `Quot.sound`.

We explicitly do **not** claim: the no-ghost theorem itself (the spanning/assembly step
is open, see §5); the Virasoro algebra as a central extension of the Witt algebra or its
representation theory in general (Kytölä, arXiv:2510.21741); the Poincaré–Birkhoff–Witt
theorem (open in Mathlib and in every prior Lean vertex-algebra project we are aware of);
the S/T transformation properties of the Dedekind eta function or generation of the
modular group by `S, T` (both supplied by Mathlib, via Scott Carnahan's and the Mathlib
community's prior work). These attributions are detailed in §2–§3.
