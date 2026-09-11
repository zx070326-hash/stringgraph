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

## 3. Related work

**Kytölä, *VirasoroProject* (arXiv:2510.21741).** A Lean 4 development of the Witt
algebra, its universal central extension (Virasoro), the Heisenberg algebra, Verma
modules, and a single-component (`c = 1`) Sugawara construction. This is the primary
prior work for the representation-theoretic layer we build on: our `Virasoro/` files
import his Witt/Verma objects rather than redefining them (`formal/StringFormal/
Virasoro/ATTRIBUTION.md`), and our abstract in §1 explicitly attributes the Virasoro
algebra itself to this project. Kytölä's own §1.3 and his 2025-06-14 Zulip announcement
state he is not aware of prior formalizations in this area and list the Shapovalov form,
Kac determinant, Lorentzian/indefinite signature, and DDF/no-ghost material as outside
his project's scope — the basis for our A-list claims in §2.

**Carnahan, `vertexAlg` (Mathlib PR #20206, merged; PR #25822, open WIP "testbed").**
A complete, zero-`sorry` `VertexAlgebra` class merged into Mathlib, plus an open PR
extending it. Its README TODO list names "invariant inner products", "vertex operators
attached to Lie algebra elements", and "no-ghost theorem" as future goals — we build
toward exactly these, from the DDF/Shapovalov side rather than the general
vertex-algebra-axiomatic side. Our `NoGhost/VertexOperator.lean` (the concrete
`:e^{ic·X}:` exponential operator) is a different, more concrete object than Carnahan's
abstract vertex algebra and is not claimed to instantiate it.

**Mathlib `Algebra/Vertex/`.** Contains `HVertexOperator.lean` and `VertexOperator.lean`
with the locality and residue-product API still marked TODO upstream; we do not depend
on this directory.

**Methodology.** Our statement/derivation/status separation and audit-surface discipline
follow the leanblueprint ecosystem (as used by the Flat Torus, FLT, and Prove2Me
projects; see `docs/METHODOLOGY.md`). We note honestly that leanblueprint is *already* a
status-bearing dependency DAG — node = LaTeX environment, edge = `\uses`, colour = the
formalization-pipeline stage (`stated`/`can_state`/`proved`/`mathlibok`, etc.). The actual
difference is in the semantics of the status axis: leanblueprint's colour tracks distance
from being Lean-checked, while stringgraph's `status` tracks the epistemic strength of the
*underlying physics argument itself* (rigorous proof vs. physical argument vs. conjecture),
propagated by taking the minimum over the graph (`docs/STATUS_LEVELS.md`). We do not claim
prior work in this space is "merely static documentation."

## 4. Structure of the formalization

The development lives under `formal/StringFormal/` (Lean 4.33.1, Mathlib pinned to the
same tag) in three islands that do not import each other except where `Virasoro/` is a
shared base for `NoGhost/`.

**`Math/`.** Self-contained number-theory and root-system lemmas not specific to string
representation theory: Euler's partition generating function (`EulerPartition.lean`), the
Dedekind eta S/T transforms and their `SL(2,ℤ)`-invariance (`DedekindEtaS/T/Modular.lean`),
the modular-group generators and `(ST)^3 = -1` (`ModularGroupGenerators.lean`), the torus
measure's modular invariance (`TorusMeasure.lean`), Möbius three-point Jacobians and
Mandelstam identities (`MobiusJacobian.lean`), GSO sector counts (`FiniteCounts.lean`),
the Green–Schwarz factorization identity and IIB anomaly-matrix kernel
(`GreenSchwarzAlgebraGen.lean`, `AnomalyPolynomial.lean`, `IIBAnomalyUnique.lean`), and
the `E₈` root power sums (`E8Roots.lean`).

**`Virasoro/`.** The Witt/Virasoro algebras (`Witt.lean`, `Basic.lean`, built on
Mathlib's `LieAlgebra.ofTwoCocycle`), Verma modules and their ordered-word spanning set
(`Verma.lean`, `VermaPBW.lean`; PBW linear independence itself is open), Witt/Virasoro
perfectness (`WittPerfect.lean`), and the Shapovalov form with Kac-determinant instances
at `N ≤ 4` (`Shapovalov.lean`, `ShapovalovLevel{Three,Four}.lean`,
`GenericIndependence.lean`) — this is where C1–C2 from §2 live.

**`NoGhost/`.** The bulk of the development: the `D`-component Lorentzian Fock space and
Sugawara construction (`Fock.lean`, `FockSigned.lean`, `Sugawara.lean`, giving C4), the
exponential vertex operator and its mode algebra (`VertexOperator.lean`,
`VertexWeight*.lean`, `VertexProduct.lean`, `VertexAdjoint.lean`), the momentum-graded
"tower" Fock space `TowerFock D R = ℤ →₀ Fock D R` on which the DDF operators and their
full algebra are built (`DDF.lean`, `DDFOperator*.lean`, `DDFAlgebra.lean`, giving C3),
the Goddard longitudinal `K` operators (`Longitudinal.lean`), the light-cone frame and
`ddfSpan` (`LightCone.lean`), and the tower-level spurious/null-state quotient
construction (`TowerNull.lean`, `QuotientForm.lean`). `NoGhost/Statement.lean` is
deliberately left as a stub: the no-ghost theorem's full statement cannot be written down
until the quotient form is in place (see §5).

**What Mathlib provided directly**, reused rather than redefined: the two-cocycle
central-extension construction for Lie algebras (`LieAlgebra.ofTwoCocycle`, underlying
`Virasoro/Basic.lean`); `ModularForm.eta` and `ModularForm.eta_comp_eq_csqrt_I_inv`
(underlying the eta-function transforms); `SpecialLinearGroup.SL2Z_generators`
(underlying the modular-group generation result); `SMulInvariantMeasure (GL (Fin 2) ℝ) ℍ
volume` (underlying the torus-measure invariance).

**The `StringFormal.Bridge` rule.** Project policy (`formal/CLAUDE.md`) forbids
redefining an object Mathlib already has. Where a graph card's wording needs to match a
Mathlib theorem verbatim, `Math/MathlibBridges.lean` restates it inside
`namespace StringFormal.Bridge` with a `rfl`/`simp`-level proof, and the card's
`formal.lean_decl` points at the bridge declaration, not at Mathlib directly. Two
instances exist today: `math.dedekind-eta-function` (expanding `ModularForm.eta` into
the string-theory `q^{1/24}∏(1-q^n)` form with the `q = e^{2πiτ}` branch convention) and
`worldsheet.modular-group-psl2z` (giving `Z(SL(2,ℤ)) = {±I}`, `center_eq_pm_one`, not
previously in Mathlib or this project, and the descent of the Möbius action to
`PSL(2,ℤ)`).

**The `ℤ →₀ k` quotient-instance obstacle.** The tower-level null-state quotient
construction needed to state the no-ghost theorem requires a `Submodule R (ℤ →₀ R)`
quotient. `TowerNull.lean`'s header records that Lean's `HasQuotient` instance synthesis
for this fails directly on `TowerFock`, because `ℤ →₀ k` simultaneously carries an
`AddMonoidAlgebra` structure that confuses instance search; the fix taken is to build the
quotient machinery abstractly first (for an arbitrary `R`-module `M`, bilinear form `B`,
and submodule `P` — `radicalIn`, `QuotRadical`, `quotRadicalForm`) and instantiate it
second, rather than working with the quotient instance directly on `TowerFock`. This is
tracked as a reproducible Mathlib-level issue (TODO tag `noghost-c1`,
`formal/MATHLIB-ISSUE-quotient-finsupp.md`).

## 5. What remains for the no-ghost theorem

The blueprint (`formal/BLUEPRINT-noghost.md`) splits the remaining work into a
longitudinal-operator track, a spanning/light-cone track, and an assembly step.

**Longitudinal operators: done.** The project uses Goddard–Thorn's `K_m = k_0·α_m`
rather than Brower's `A^L_n`, because `K_m` is "almost free" — most of its algebra
follows by specializing existing DDF lemmas to the polarization `ε := b`. All six
relations are proved with no `sorry`: `⁅L_m,K_n⁆ = -nK_{m+n}`, `⁅K_m,K_n⁆ = 0`, `K_0 = 1`,
`K_m^† = K_{-m}`, and — the one requiring genuine new work rather than specialization —
`⁅K_m,A^ε_n⁆ = 0` (`lie_kOp_ddfOp`, `NoGhost/Longitudinal.lean`).

**Spanning: partial.** `NoGhost/LightCone.lean` defines the DDF-span submodule
`ddfSpan` and proves the `N = 1` case of the spanning statement,
`towerPhys_bigrade_one_le_ddfSpan_sup_spurious` (physical states at bigrade 1 lie in
`ddfSpan ⊔ spurious`), with `D = 26` not appearing anywhere in this argument. The general
spanning lemma — a unitriangular change of basis between the naive oscillator basis and
the DDF+longitudinal+transverse basis, at every level `N` — is open.
[verify: exact current frontier beyond N=1; several background Lean agents were active
on adjacent files (`DDFGram.lean`, `TowerNull.lean`) at the time this outline was written
and may have advanced this further.]

**Assembly and the `(B-26)` step: open.** The final assembly combining spanning,
positivity of the transverse Gram matrix, and the quotient by null/spurious states is not
yet written; `NoGhost/Statement.lean` remains a stub for exactly this reason. Critically,
`D = 26` enters the no-ghost argument at exactly one step — the blueprint's `(B-26)` —
where, outside the transverse subspace, the `p_{D-1}(N) - p_{D-2}(N)` extra directions
are shown to be exactly the null states. This step is sourced only to Goddard 2008
(6.4)'s one-line, unproven citation of Goddard–Thorn 1972 and Brower 1972 (primary texts
not obtained, see §6); formalizing it requires committing to one of the two original
mechanisms (Brower's, needing `A^L_n`, or GT's, needing a K-condition balancing argument)
neither of which the current codebase implements. `D = 26` does **not** appear in
character/dimension counting, the DDF algebra, DDF adjoints, or transverse-Gram
positivity — only at this one step.
