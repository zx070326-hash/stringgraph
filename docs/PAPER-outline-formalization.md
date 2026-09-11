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

## 2. Contributions

Each row: Lean declaration, file, hypothesis set (typeclasses / geometric side
conditions), and the first-formalization verdict from
`literature/extractions/prior-formalizations.md` (the "A-list", section "可宣称首次的清单").

**(C1) Shapovalov (contravariant) form on Virasoro Verma modules.**
`Virasoro.exists_isContravariant_iff_hwv_ne_zero`, `Virasoro.eq_of_isContravariant`
(`formal/StringFormal/Virasoro/Shapovalov.lean`). Hypotheses: `[Field K] [CharZero K]`
for the existence-over-a-field direction; the anti-involution/uniqueness/level-orthogonality
lemmas hold over an arbitrary `[CommRing R] [Algebra ℚ R]`. **First formalization: yes.**
Evidence (prior-formalizations.md A1): Kytölä's Table 1 and 21 filenames contain no
Shapovalov/invariant-form object and lists Feigin–Fuks structure theory as future work
(§14); Mathlib's `Algebra/Lie/` (46 entries, fully enumerated) and AFP's algebra topic
index (107 entries, fully enumerated) contain none; Carnahan's `vertexAlg` README lists
"invariant inner products" under TODO.

**(C2) Kac determinant, instances at `N ≤ 4`.**
`IsContravariant.gram_level_four_det_eq_kac` (5×5 Gram determinant equals Kac's factored
product `K₄·(h-h₁₁)³·((h-h₁₂)(h-h₂₁))²·(h-h₁₃)(h-h₃₁)·(h-h₂₂)·(h-h₁₄)(h-h₄₁)`),
`IsContravariant.finrank_levelSpan_four` (`dim V₄ = 5 = p(4)` at generic `(c,h)`), and the
`N = 2, 3` analogues, all in `formal/StringFormal/Virasoro/{ShapovalovLevelThree,
ShapovalovLevelFour,GenericIndependence}.lean`. Hypotheses: `[Field K]`, a nonvanishing
determinant hypothesis discharged by the explicit factorization, `B (hwv K c h) (hwv K c h)
= 1`. **First formalization: yes, worded as "instances", not the general theorem** —
prior-formalizations.md A2: no Kac-determinant object found anywhere on GitHub except a
non-formal Python script; Kytölä §14 explicitly defers the general Feigin–Fuks result.

**(C3) Transverse DDF operator algebra on the momentum-tower Fock space.**
`lie_ddfOp_ddfOp` (`⁅Aᵉₘ,Aᵟₙ⁆ = m(ε·δ)δ_{m+n,0}·id`, `NoGhost/DDFAlgebra.lean`),
`lie_towerLop_ddfOp` (`⁅Lₘ,Aᵉₙ⁆ = 0` for **every** `m : ℤ`, `NoGhost/DDFOperatorAll.lean`),
`towerPairing_ddfOp_left` (`(Aᵉₙ)† = Aᵉ₋ₙ`, `NoGhost/VertexAdjoint.lean`),
`lie_kOp_ddfOp` (`⁅Kₘ,Aᵉₙ⁆ = 0`, `NoGhost/Longitudinal.lean`) and the general Heisenberg
Gram lemma `gram_of_heisenberg_family` (`NoGhost/HeisenbergGram.lean`, arbitrary `R`-module
carrier). Hypotheses throughout: `[CommRing R]` (`[Algebra ℚ R]` where a bracket needs a
`1/m`-free rescaling), a diagonal metric `hη : ∀ μ, η μ * η μ = 1`, light-likeness
`hbb : dotVec η b b = 0`, DDF normalization `hba : dotVec η b a = 1`, transversality
`hεb/hδb : dotVec η ε b = 0`. **First formalization: yes.** Evidence (A3): Carnahan's
`vertexAlg` README lists "vertex operators attached to Lie algebra elements" and
"no-ghost theorem" under TODO; arXiv search for DDF operators intersected with proof
assistants returns only physics papers.

**(C4) `D`-component Lorentzian Fock space with `c = D` Sugawara construction.**
`Fock` and its `η`-induced indefinite bilinear form (`NoGhost/Fock.lean`), negative-norm
witnesses at every level (`NoGhost/FockSigned.lean`), and `lie_Lop_Lop` giving the Virasoro
relations with central charge `c = D` (`NoGhost/Sugawara.lean`). Hypotheses:
`[CommRing R]`, diagonal metric `η : Fin D → R` with `hη`, arbitrary momentum zero-mode
`a : Fin D → R`. **First formalization: yes.** Evidence (A4): Kytölä's own Zulip
announcement (2025-06-14, quoted in prior-formalizations.md §E.1) states his Sugawara
construction is single-component, `c = 1`; Lorentzian/indefinite signature is listed as
outside his project's assumptions.

**(C5) Green–Schwarz factorization algebra and IIB uniqueness.**
`GreenSchwarzAlgebraGen` results (twelve-form factorization over `[CommRing R]
[Algebra ℚ R]`, `formal/StringFormal/Math/GreenSchwarzAlgebraGen.lean`),
`AnomalyPolynomial.lean` (Polchinski (12.2.27)+(12.2.28) ≡ (12.2.11)+(12.2.12) by `ring`;
IIB integer-solution ray), and `IIBAnomalyUnique.lean`
(`ker A = ℚ·(2,-2,1)` for Bilal's 3×3 anomaly matrix, rank 2, over an arbitrary
`[CommRing R]` for the rank-independent parts). **First formalization: yes, limited to the
algebraic-identity layer** (no index theorem, no hexagon diagram, no descent equations in
Lean). Evidence (A5): Physlib's `AnomalyCancellation` modules are all 4d (QFT/StandardModel/
RHN/QED); its `StringTheory/` directory contains only `Basic.lean` and an F-theory SU(5)
subdirectory; a full 99-topic enumeration of the Lean Zulip `PhysLean` stream contains zero
hits for `string`/`anomaly`/`Green–Schwarz`.

**(C6) `E₈` root power sums.**
`e8_power_sum_two/four/six` (`Σ_{α∈Φ}(α·x)^k` for `k=2,4,6` on the explicit 240-root list,
`formal/StringFormal/Math/E8Roots.lean`), over arbitrary `x ∈ ℚ⁸`. Hypotheses: none beyond
`ℚ`-linear algebra; the roots are listed by cases (112 `±εᵢ±εⱼ` plus 128 even-sign
half-sum vectors), not derived from a general root-system API. **First formalization:
likely yes, unverified beyond a local check** — lead's local `grep` of
`Mathlib/LinearAlgebra/RootSystem/` found no file mentioning `E8`/`E₈`
(prior-formalizations.md, "lead 本地复核" note). `[verify: no dedicated E8-root-system
search of non-Mathlib Lean repositories was performed]`.
