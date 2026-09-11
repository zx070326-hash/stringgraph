# Paper outline: Lean 4 islands for Virasoro representation theory and the DDF construction

Status: draft skeleton, ITP/CPP-style. Every claim below points at a file or a Lean
declaration in `formal/StringFormal/`; unverified claims are marked `[verify: ...]`.

## 1. Title candidates and abstract

**Title candidates**

1. *DDF Operators and the Shapovalov Form, Formally: Lean 4 Islands for Bosonic
   String Representation Theory*
2. *Formalizing the Algebraic Core of the Goddard–Thorn Construction: Kac
   Determinants, DDF Operators, and Green–Schwarz Factorization in Lean 4*
3. *Towards a Machine-Checked No-Ghost Theorem: Six Formalized Components in Virasoro and
   Vertex-Operator Representation Theory*

**Abstract**

We report a Lean 4 / Mathlib development of four representation-theoretic components
(C1–C4) used in the Goddard–Thorn no-ghost theorem of bosonic string theory, plus two
independent components (C5, C6) formalizing Green–Schwarz/IIB anomaly factorization and
`E₈` root power sums.
Concretely, we formalize: (i) the Shapovalov (contravariant) form on
Virasoro Verma modules — uniqueness and level orthogonality unconditionally, and
existence whenever the highest-weight vector is nonzero; (ii) the Kac determinant formula verified as instances at
levels `N ≤ 4`, matching Kac's factored product form; (iii) the algebra of transverse
DDF operators on a momentum-graded ("tower") Fock space over an arbitrary commutative
`ℚ`-algebra — commutation with every Virasoro mode, mutual adjointness, the oscillator
bracket `⁅Aᵉₘ, Aᵟₙ⁆ = m(ε·δ)δ_{m+n,0}`, and commutation with the Goddard longitudinal
operators `Kₙ`; (iv) a `D`-component Fock space carrying a Lorentzian (indefinite)
`η`-form together with a Sugawara construction whose central charge is `c = D` for
arbitrary `D`; (v) the Green–Schwarz twelve-form factorization identity over an arbitrary
commutative `ℚ`-algebra, and the uniqueness of the integer solution to the type IIB
anomaly-cancellation conditions over an arbitrary field of characteristic `0`; and
(vi) explicit power-sum identities for the 240 roots of `E₈`. The 86 declarations linked
from the dependency graph (§7) compile without `sorry`, depending only on `propext`,
`Classical.choice`, `Quot.sound` (`uv run stringgraph check-axioms`, main, 2026-09-11);
not every declaration in `formal/StringFormal/` is covered, only graph-linked ones.

We explicitly do **not** claim: the no-ghost theorem itself (the assembly step is now a
proved conditional theorem, but the spanning hypothesis `DDFSpans` it is conditioned on
remains open beyond level `N = 1`; see §5); the Virasoro algebra as a central extension of
the Witt algebra or its
representation theory in general (Kytölä, arXiv:2510.21741); the Poincaré–Birkhoff–Witt
theorem (open in Mathlib and in every prior Lean vertex-algebra project we are aware of);
the S-transformation property of the Dedekind eta function (Mathlib's
`eta_comp_eq_csqrt_I_inv`, authored by Chris Birkbeck) or the generation of the modular
group by `S, T` (Mathlib's `SpecialLinearGroup.SL2Z_generators`, the Mathlib community).
Our `eta_T` and `(ST)^3 = -1` results are minor derivations from these, not headlined.
These attributions are detailed in §2–§3.

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
product `K₄·(h-h₁₁)³·((h-h₁₂)(h-h₂₁))²·(h-h₁₃)(h-h₃₁)·(h-h₂₂)·(h-h₁₄)(h-h₄₁)`) holds over
`[CommRing R] [Algebra ℚ R]`, given `IsContravariant R c h B`, `B (hwv R c h)(hwv R c h) =
1`, and eight explicit level-≤4 Gram-entry equations. `IsContravariant.finrank_levelSpan_four`
(`dim V₄ = 5 = p(4)` at generic `(c,h)`) holds over `[Field K] [CharZero K]`, with the
nonvanishing-determinant genericity condition (`hdet`) an unproven hypothesis, not
discharged by the factorization. `N = 2, 3` analogues: `formal/StringFormal/Virasoro/
{ShapovalovLevelThree,ShapovalovLevelFour,GenericIndependence}.lean`. **First
formalization: yes, worded as "instances", not the general theorem** —
prior-formalizations.md A2: no repository-level GitHub hit for a Kac-determinant object
(code-content search unavailable this round; only repo-name/README search ran); Kytölä
§14 defers the general Feigin–Fuks result.
**Byproduct (`formal/StringFormal/Virasoro/FockFreeLowLevel.lean`):** transporting the Gram
determinant along the Verma-to-Fock map `Fock.vermaToFock` (built from the Fock vacuum being
a highest-weight vector of weight `(c,h) = (D, ½α₀²)`) shows the `p(N)` standard descendants
`L₋₁|k⟩, …` of the `D`-boson Fock space are linearly independent whenever the Kac
determinant at `(D, ½α₀²)` is nonzero, for `N ≤ 4`
(`Fock.linearIndependent_fockDesc{1,2,3,4}`) — i.e. the Fock module is free over `U(Vir⁻)`
in degrees `≤ 4`, for every `D` and every momentum. A further byproduct,
`Fock.hwv_ne_zero_of_two_le`, gives `V(c,h) ≠ 0` for every natural `c ≥ 2` and **every** `h`
(via the Lorentzian Fock realization), strengthening C1's existence-conditional-on-`hwv ≠ 0`
result to an unconditional one on this weight family.

**(C3) Transverse DDF operator algebra on the momentum-tower Fock space.**
`lie_ddfOp_ddfOp` (`⁅Aᵉₘ,Aᵟₙ⁆ = m(ε·δ)δ_{m+n,0}·id`, `NoGhost/DDFAlgebra.lean`),
`lie_towerLop_ddfOp` (`⁅Lₘ,Aᵉₙ⁆ = 0` for **every** `m : ℤ`, `NoGhost/DDFOperatorAll.lean`),
`towerPairing_ddfOp_left` (`(Aᵉₙ)† = Aᵉ₋ₙ`, `NoGhost/VertexAdjoint.lean`),
`lie_kOp_ddfOp` (`⁅Kₘ,Aᵉₙ⁆ = 0`, `NoGhost/Longitudinal.lean`) need `[CommRing R]
[Algebra ℚ R]`; the Heisenberg Gram lemma `gram_of_heisenberg_family`
(`NoGhost/HeisenbergGram.lean`) needs only plain `[CommRing R]`. Geometric hypotheses
vary by lemma: diagonal metric `hη : ∀ μ, η μ * η μ = 1`, light-likeness
`hbb : dotVec η b b = 0`, DDF normalization `hba : dotVec η b a = 1`, transversality
`hεb/hδb : dotVec η ε b = 0` — `towerPairing_ddfOp_left` needs only `hη`, `hεb`.
**First formalization: yes.** Evidence (A3): Carnahan's `vertexAlg` README lists "vertex
operators attached to Lie algebra elements" and "no-ghost theorem" under TODO; arXiv
search for DDF operators intersected with proof assistants returns only physics papers.

**(C4) `D`-component Lorentzian Fock space with `c = D` Sugawara construction.**
`Fock` and its `η`-induced indefinite bilinear form (`NoGhost/Fock.lean`), negative-norm
witnesses at every level, requiring `[CommRing R] [PartialOrder R] [IsStrictOrderedRing R]`
(`NoGhost/FockSigned.lean`), and `lie_Lop_Lop` giving the Virasoro relations with central
charge `c = D`, requiring `[Algebra ℚ R]` (`NoGhost/Sugawara.lean`). Common hypotheses:
diagonal metric `η : Fin D → R` with `hη`, arbitrary momentum zero-mode `a : Fin D → R`.
**First formalization: yes.** Evidence (A4): Kytölä's Zulip announcement (2025-06-14,
§E.1) states his Sugawara construction is single-component, `c = 1`; the
Lorentzian-indefinite gap is our own reading of his source, not his claim (§3,
`formal/NOTES-virasoro-reuse.md`).

**(C5) Green–Schwarz factorization algebra and IIB uniqueness.**
`GreenSchwarzAlgebraGen` results (twelve-form factorization over `[CommRing R]
[Algebra ℚ R]`, `formal/StringFormal/Math/GreenSchwarzAlgebraGen.lean`);
`AnomalyPolynomial.lean` (Polchinski (12.2.27)+(12.2.28) ≡ (12.2.11)+(12.2.12) by `ring`)
over `[Field K] [CharZero K]`; and `IIBAnomalyUnique.lean`'s
`iib_rank_eq_two` (`ker A = ℚ·(2,-2,1)` for Bilal's 3×3 anomaly matrix, rank 2), which
needs `[Field K]` plus the explicit hypothesis `(720 : K) ≠ 0` — only the matrix
definition, the rows-relation, and the determinant-is-zero lemma are stated over a plain
`[CommRing R]`. **First formalization: yes, limited to the algebraic-identity layer** (no
index theorem, no hexagon diagram, no descent equations in Lean). Evidence (A5):
Physlib's `AnomalyCancellation` modules are all 4d; `StringTheory/` has only `Basic.lean`
plus an F-theory SU(5) subdirectory; a 99-topic Zulip `PhysLean` enumeration has zero
hits for `string`/`anomaly`/`Green–Schwarz`.

**(C6) `E₈` root power sums.**
`e8_power_sum_two/four/six` (`Σ_{α∈Φ}(α·x)^k` for `k=2,4,6` on the explicit 240-root list,
`formal/StringFormal/Math/E8Roots.lean`), over arbitrary `x ∈ ℚ⁸`. Hypotheses: none beyond
`ℚ`-linear algebra; the roots are listed by cases (112 `±εᵢ±εⱼ` plus 128 even-sign
half-sum vectors), not derived from a general root-system API. Mathlib does contain the
`E₈` Cartan matrix (`CartanMatrix.E₈`, `Mathlib/LinearAlgebra/Matrix/Cartan.lean:74`) and
a generic Serre-construction Lie algebra (`Algebra/Lie/SerreConstruction.lean`), but no
root-system object carrying the 240 explicit roots or these power-sum identities.
**First formalization: likely yes, unverified beyond a local check** — lead's local
`grep` of `Mathlib/LinearAlgebra/RootSystem/` found no file mentioning `E8`/`E₈`
(prior-formalizations.md, "lead 本地复核" note). `[verify: no dedicated E8-root-system
search of non-Mathlib Lean repositories was performed]`.

## 3. Related work

**Kytölä, *VirasoroProject* (arXiv:2510.21741).** A Lean 4 development of the Witt
algebra, its universal central extension (Virasoro), the Heisenberg algebra, Verma
modules, and a single-component (`c = 1`) Sugawara construction — the primary prior work
for the representation-theoretic layer we build on. No file from `VirasoroProject` is
copied into this repository and it is not a `lake-manifest.json` dependency
(`formal/StringFormal/Virasoro/ATTRIBUTION.md`); our `Virasoro/` files re-derive the
Witt/Verma objects over weaker hypotheses (`[CommRing R] [Algebra ℚ R]` in place of
Kytölä's `[Field 𝕜] [CharZero 𝕜]`). Kytölä's §1.3 and his 2025-06-14 Zulip announcement
say he is not aware of prior formalizations in this area; his Table 1 and 21-file list
contain no Shapovalov form, Kac determinant, or DDF/no-ghost object, and §14 defers
Feigin–Fuks structure theory to future work — the basis for our A-list claims in §2. That
his Sugawara construction lacks a Lorentzian inner product, a `c = D` multi-component
case, and DDF operators is our own reading of his source (`formal/NOTES-virasoro-reuse.md`),
not a scope disclaimer he makes himself.

**Carnahan, `vertexAlg` (personal repo) and Mathlib PR #20206.** Carnahan's personal
`ScottCarnahan/vertexAlg` repository (active 2026-05-15 through 2026-08-31) contains a
complete, zero-`sorry` `VertexAlgebra` class, but it is **not** merged into Mathlib.
Carnahan's actual merged Mathlib contribution, PR #20206, is `LieAlgebra.ofTwoCocycle`
(two-cocycle central extensions of Lie algebras, underlying our own `Virasoro/Basic.lean`,
§4) — Lie-extension machinery, not a vertex-algebra class. A second PR, #25822, is an open
WIP "testbed" whose author has asked reviewers not to review it yet. The `vertexAlg`
README TODO lists "invariant inner products", "vertex operators attached to Lie algebra
elements", and "no-ghost theorem" as future goals — we build toward exactly these, from
the DDF/Shapovalov side rather than the general vertex-algebra-axiomatic side. Our
`NoGhost/VertexOperator.lean` (the concrete `:e^{ic·X}:` operator) is a different, more
concrete object, not claimed to instantiate Carnahan's abstract vertex algebra.

**Mathlib `Algebra/Vertex/`.** Contains `HVertexOperator.lean` and `VertexOperator.lean`
with the locality and residue-product API still marked TODO upstream; we do not depend
on this directory.

**Methodology.** Our statement/derivation/status separation and audit-surface discipline
follow the leanblueprint ecosystem (as used by the FLT and Prove2Me projects; see
`docs/METHODOLOGY.md`). We note honestly that leanblueprint is *already* a status-bearing
dependency DAG — node = LaTeX environment, edge = `\uses`, colour = formalization-pipeline
stage. The colour vocabulary has eight keys: `stated`, `can_state`, `not_ready`, `proved`,
`can_prove`, `defined`, `fully_proved`, `mathlib` (`\mathlibok` is a separate display macro,
not a colour key itself). The real difference is in the status axis's semantics:
leanblueprint's colour tracks distance from being Lean-checked, while stringgraph's
`status` tracks the epistemic strength of the *underlying physics argument* (rigorous
proof vs. physical argument vs. conjecture), propagated by minimum over the graph
(`docs/STATUS_LEVELS.md`).

## 4. Structure of the formalization

The development lives under `formal/StringFormal/` (Lean 4.33.1, Mathlib pinned to the
same tag) in three source-tree islands — `Math/`, `Virasoro/`, `NoGhost/` — not to be
confused with the six C1–C6 components of §2: C1–C2 live in `Virasoro/`, C3–C4 in
`NoGhost/`, C5–C6 both in `Math/`. Islands do not import each other except where
`Virasoro/` is a shared base for `NoGhost/`.

**`Math/`.** Self-contained number-theory and root-system lemmas not specific to string
representation theory: Euler's partition generating function (`EulerPartition.lean`), the
Dedekind eta S/T transforms and their `SL(2,ℤ)`-invariance (`DedekindEtaS/T/Modular.lean`),
the modular-group generators and `(ST)^3 = -1` (`ModularGroupGenerators.lean`), the torus
measure's modular invariance (`TorusMeasure.lean`), Möbius three-point Jacobians and
Mandelstam identities (`MobiusJacobian.lean`), GSO sector counts (`FiniteCounts.lean`),
the Green–Schwarz factorization identity and IIB anomaly-matrix kernel
(`GreenSchwarzAlgebraGen.lean`, `AnomalyPolynomial.lean`, `IIBAnomalyUnique.lean`), and
the `E₈` root power sums (`E8Roots.lean`). Two general-purpose additions not tied to a
specific C1–C6 component: the graded Euler–Poincaré principle for cochain complexes
(`EulerPoincare.lean`, `finrank`-additivity of a complex's Euler characteristic across
cohomology and coboundaries) and the zeta-regularized value of the divergent oscillator
sum `Σ_n n e^{-un} - 1/u² → -1/12` as `u → 0⁺` (`RegulatedSum.lean`), bridged to Mathlib's
`riemannZeta (-1) = -1/12` (`Bridge.riemannZeta_neg_one`, `Math/MathlibBridges.lean`) —
support lemmas for the light-cone zero-point-energy computation elsewhere in the graph, not
part of C1–C6 themselves.

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
"tower" Fock space `TowerFock D R = ℤ →₀ Fock D R` on which the DDF operators'
commutation, adjoint, and oscillator relations are built (`DDF.lean`, `DDFOperator*.lean`,
`DDFAlgebra.lean`, giving C3),
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
`worldsheet.modular-group-psl2z` (giving `Z(SL(2,ℤ)) = {±I}`, `center_eq_pm_one`, a
10-line specialization of Mathlib's `Matrix.SpecialLinearGroup.mem_center_iff`
(`SpecialLinearGroup.lean:256`) to `n = 2` over `ℤ`, and the descent of the Möbius action
to `PSL(2,ℤ)`).

**The `ℤ →₀ k` quotient-instance obstacle.** The tower-level null-state quotient
construction needed to state the no-ghost theorem requires forming `P ⧸ Q` for
`P : Submodule R (ℤ →₀ R)` and `Q : Submodule R P` — a quotient of a submodule by a
submodule of itself, not of the ambient module directly. `TowerNull.lean`'s header records
that Lean's `HasQuotient` instance synthesis fails for this shape on `TowerFock`, because
`ℤ →₀ R` carries an `AddMonoidAlgebra` structure that confuses instance search; the fix is
to build the quotient machinery abstractly first (arbitrary `R`-module `M`, bilinear form
`B`, submodule `P` — `radicalIn`, `QuotRadical`, `quotRadicalForm`) and instantiate it
second. The construction is done (TODO tag `noghost-c1`, `formal/TODO.md`); a draft,
not-yet-filed Mathlib issue with a minimal reproduction is at
`formal/MATHLIB-ISSUE-quotient-finsupp.md` (checked against Mathlib `v4.33.1`, 2026-09-11;
filing is the captain's call).

## 5. What remains for the no-ghost theorem

The blueprint (`formal/BLUEPRINT-noghost.md`) splits the work into a longitudinal-operator
track, a spanning/light-cone track, and an assembly step. The assembly step is now done, as
a conditional theorem; what remains open is entirely inside the spanning hypothesis it is
conditioned on.

**Longitudinal operators: done.** The project uses Goddard–Thorn's `K_m = k_0·α_m`
(Goddard 2008 lecture-notes self-report; primary 1972 text not obtained, §6) rather than
Brower's `A^L_n`, because `K_m` is "almost free" — most of its algebra follows by
specializing existing DDF lemmas to the polarization `ε := b`. All six relations are
proved with no `sorry`: `⁅L_m,K_n⁆ = -nK_{m+n}` (`lie_towerLop_kOp`), `⁅K_m,K_n⁆ = 0`
(`lie_kOp_kOp`), `K_0 = 1` (`kOp_zero_eq_id`/`kOp_zero_eq_one`), `K_m^† = K_{-m}`
(`towerPairing_kOp_left`), `K` commutes with the DDF vertex operator via `k_0^2 = 0`
(`kOp_mul_towerVertex`), and — the one requiring genuine new work rather than
specialization — `⁅K_m,A^ε_n⁆ = 0` (`lie_kOp_ddfOp`, `NoGhost/Longitudinal.lean`).
(`kOp_apply_single_vacuum_of_pos` is a further proved fact, not counted among these six.)

**Assembly: done, conditional on the spanning hypothesis `DDFSpans`.**
`NoGhost/Assembly.lean`'s `no_ghost_of_spans` proves that *if* `DDFSpans`
(`H_phys ≤ ddfSpan ⊔ H_null` at the ground-state intercept `a₀ = α'k²`) holds, then the
bilinear form induced on `H_phys ⧸ H_null` of the momentum tower is positive definite:
every class has non-negative norm, and only the zero class has norm zero. This combines
spanning, positivity of the transverse Gram matrix, and the null-state quotient into a
single theorem, for every `D` and over any ordered field — `D = 26` does not appear in the
statement or proof, because it is entirely absorbed into `DDFSpans` itself (blueprint
§B.5: the DDF states have transverse character `φ(q)^{-(D-2)}`, the physical-mod-null
states have the covariant one, and the two agree only at `D = 26`, `a₀ = 1`).
`NoGhost/Statement.lean` remains the deliberately-empty stub described in §4 — the
conditional theorem lives in `Assembly.lean`, not yet wired to that stub. No isometry
`ddfSpan ≃ₗ H_phys ⧸ H_null` is constructed either; injectivity follows from
`ddf_span_pos`, but surjectivity is `DDFSpans` again, so such an equivalence would carry
no further information.

**Spanning (`DDFSpans`): reduced to a slice-by-slice induction; `N = 1` closed, `N = 2`
open.** `NoGhost/LightCone.lean` defines the DDF-span submodule `ddfSpan` and proves the
`N = 1` case of the spanning statement, `towerPhys_bigrade_one_le_ddfSpan_sup_spurious`,
under the hypotheses `Ε : TransverseFrame η b` (a chosen transverse frame),
`hεa : ∀ i, dotVec η (Ε.vec i) a = 0`, and `hspan : FrameSpansOrthogonal η Ε
(towerMomentum a b (-1))`; `hspan` is discharged only for one explicit witness frame
(`witness_frameSpansOrthogonal`, requiring `[Algebra ℚ R]` and `hD : 3 ≤ D`).
`NoGhost/Assembly.lean`'s `ddfSpans_bigrade_neg_one_one` packages this into the `(-1,1)`
bigraded slice of `DDFSpans` unconditionally in `D`. `NoGhost/Glue.lean`'s
`ddfSpans_of_forall_slice` proves the general reduction: if `DDFSpansOn` holds on *every*
bigraded slice `towerBigrade D R j N`, then `DDFSpans` holds — because `H_phys` is itself
spanned by its bigraded pieces (`towerPhys_le_iSup_bigrade`, from `L_0`/`L_m` being
homogeneous for the bigrading). This turns "prove `DDFSpans`" into a level-by-level
induction. `NoGhost/LevelTwoSpan.lean` (54 top-level declarations, no `sorry`) resolves the
two named blockers previously recorded for the `N = 2` step: the explicit level-one and
level-two Laurent coefficients of the creation exponential, and the *complete* (not just
`SO(D-1)`-scalar) solution of `L_1ψ = L_2ψ = 0` on the level-two slice, both for a single
Fock space and on the tower. The `N = 2` slice of `DDFSpans` itself
(`towerPhys_bigrade_two_le_ddfSpan_sup_spurious`) is not yet proved — this is now
unblocked rather than obstructed, but still open, and the general-`N` case remains a fully
open unitriangular change-of-basis argument. `D = 26` continues to enter the no-ghost
argument at exactly one place — proving `DDFSpans` at every slice, the blueprint's
`(B-26)` — sourced only to Goddard 2008 (6.4)'s one-line, unproven citation of
Goddard–Thorn 1972 and Brower 1972 (primary texts not obtained, see §6); formalizing the
general case requires committing to one of the two original mechanisms (Brower's, needing
`A^L_n`, or GT's, needing a K-condition balancing argument), neither of which the current
codebase implements. `D = 26` does **not** appear in character/dimension counting, the DDF
algebra, DDF adjoints, or transverse-Gram positivity, nor in the assembly theorem above —
only in this one remaining step.

## 6. Threats to validity

**All review is by AI agents.** Every Lean declaration, graph-card wording check, and
back-translation audit to date has been performed by Claude-based agents
(`physics-auditor`, `graph-reviewer`); no human mathematician or string theorist has
checked the milestone statements or Lean signatures against the physics literature
(`docs/ROADMAP.md`, "发表路线", "待船长"). This is the largest threat to validity:
agent-only review catches internal inconsistency and misquotation but cannot confirm a
formalized statement is the *mathematically correct* rendering of a physical claim.

**Primary sources not obtained.** Goddard–Thorn (1972) and Brower (1972), the two
original no-ghost-theorem papers, have not been obtained by any agent in this project;
all sourcing for the `(B-26)` step (§5) currently routes through a secondary,
unproven one-line citation in Goddard's 2008 lecture notes.

**Extraction records are in Chinese.** All files under `literature/extractions/` —
including `prior-formalizations.md`, the source for every first-formalization claim in
§2 — are written in Chinese. An external reviewer without Chinese will need machine
translation to audit the evidence trail.

**Axiom check.** `uv run stringgraph check-axioms` most recently reported (main,
2026-09-11 daytime, before the Lean-island-1 merge landed) **82 declarations checked: 82
ok, 0 non-standard axioms, 0 missing, 0 errors** for the graph-linked declarations, all
closing over only `propext`, `Classical.choice`, `Quot.sound`. After merging the
no-ghost-conditional/level-two-span/Fock-free-low-level/Euler–Poincaré/regulated-sum work
into `main` (2026-09-11), the graph now references **86** unique `formal.lean_decl`
values (`collect_decls` over the merged graph, counted directly rather than re-running the
Lean checker — this pass does not run `lake build`); the individual islands that
contributed the new 4 declarations each passed `check_axioms --all` on their own branch
before merge (`formal/TODO.md` per-island axiom log), but an aggregate rerun over all 86
has not been performed since the merge. This count covers only the declarations
referenced from a graph card's `formal.lean_decl` field, not every declaration in
`formal/StringFormal/`. Not part of `validate` or the pre-commit hook (needs a full
`lake build`, too slow per-commit); `lead` runs it manually before each merge into
`main`; rerun the aggregate check before camera-ready.

## 7. Artifact

**Layout.** `graph/` (YAML statements/derivations/milestones/conventions), `tools/
stringgraph/` (validator, status propagation, reports), `formal/StringFormal/` (this
paper's Lean content), `literature/` (source registry and extraction records), `docs/`
(vision, methodology, status semantics, roadmap), `tests/` (pytest for the tools).
`pyproject.toml` names the package `stringgraph`.

**Reproducing.** `uv sync`; `uv run stringgraph validate` (schema, id resolution,
acyclicity, convention consistency); `cd formal && lake exe cache get && lake build`;
`uv run stringgraph check-axioms` (cross-checks every `formal.lean_decl` against a clean
axiom set, §6); `uv run stringgraph report` for the summary statistics below.

**Current graph size** (`uv run stringgraph report`, main, 2026-09-11 after the
Lean-island-1 merge): 617 statements, 510 derivations, 3 milestones, 22 conventions; by
kind, 116 definitions and 501 propositions; by effective status, 80 formalized, 110
rigorous, 358 physical-argument, 29 conjecture, 1 refuted, 39 open. The graph is under
continuous concurrent edit by parallel agents, so these are a snapshot, not a fixed
count; rerun before camera-ready.

## Revision log

Response to `reviewer-paper-outline-1` (2026-09-11). C = confirmed, P = plausible.

| # | Issue | Fix |
|---|---|---|
| C1 | Carnahan PR #20206 called merged `VertexAlgebra` class | §3: class is in unmerged personal repo; #20206 = Lie extensions; #25822 open WIP |
| C2 | Eta S/T both credited to Carnahan | Abstract: S=Birkbeck/Mathlib; our T/`(ST)^3=-1` not headlined |
| C3 | "import his Witt/Verma objects" | §3: no file copied, not a lake dep, re-derived over weaker hypotheses |
| C4 | C2 hypotheses omitted `Algebra ℚ R` + 8 Gram eqns; `hdet` said discharged | §2 C2: full list added; `hdet` marked unproven |
| C5 | C3 "Hypotheses throughout: CommRing" | §2 C3: 4 lemmas need `Algebra ℚ R`; only Heisenberg-Gram plain; adjoint needs only `hη`/`hεb` |
| C6 | C4 omitted `Algebra ℚ R`, order hypotheses | §2 C4: both added per lemma |
| C7 | GS/IIB both "arbitrary commutative ℚ-algebra" | Abstract, §2 C5: GS=CommRing/Algebra; IIB=Field+char 0 |
| C8 | "six components" vs "three islands" | Title/abstract split 4+2; §4 disambiguates |
| C9 | Cited nonexistent MATHLIB-ISSUE file | §4: file now exists; cited as draft/not-filed |
| C10 | `center_eq_pm_one` "not previously in Mathlib" | §4: cites Mathlib `mem_center_iff` specialization |
| C11 | Kytölä misquoted re: scope; Zulip over-cited | §3: "absent from Table 1", §14 defers; Zulip narrowed to `c=1` |
| C12 | "no Kac object anywhere on GitHub" | §2 C2: "no repo-level hit, code search unavailable" |
| C13 | "Six relations" lists five | §5: added `kOp_mul_towerVertex` |
| C14 | Stale/contradictory counts | §6, §7: fresh 2026-09-11 numbers |
| C15 | Meta-sentence re: "static documentation" | §3: deleted |
| P1 | C1 existence "unconditional in hwv" | Abstract: existence iff hwv `≠ 0` |
| P2 | Axiom claim over "all declarations" | Abstract: scoped to graph-linked decls (82 at review time, 86 after the 2026-09-11 merge, §6) |
| P3 | C6 omitted `E₈` Cartan matrix | §2 C6: `CartanMatrix.E₈` caveat added |
| P4 | leanblueprint colours listed as 4 | §3: full 8-key list |
| P5 | GT `K_m` self-report qualifier missing | §5: added |
| P6 | Spanning N=1 hypotheses omitted | §5: `TransverseFrame`/`hεa`/`hspan` added |
| P7 | "their full algebra" overclaim | §4: softened |
| P8 | Duplicated axiom text, irrelevant detail | §6: merged, cleaned |
| P9 | Quotient-obstacle wording imprecise | §4: `P⧸Q` for `P:Submodule R(ℤ→₀R)`, `Q:Submodule R P` |

### Post-merge update (2026-09-11, recovery after API outage)

The branch was recovered mid-edit after an API outage killed the agent applying the
`reviewer-paper-outline-1` fixes above; all 15 confirmed + 9 plausible items were already
applied to the working tree and are committed as-is. This pass additionally merged `main`
(bringing in the no-ghost-conditional/level-two-span/Fock-free-low-level/Euler–Poincaré/
regulated-sum Lean work landed since the review), refreshed every count against the
merged graph, and updated the no-ghost-theorem narrative in §5 and the abstract to
reflect that the assembly step is now a proved conditional theorem.

| # | Change | Where |
|---|---|---|
| M1 | Graph/Lean counts stale after merge (611/504/21/82 → 617/510/22/86) | Abstract, §6, §7: `uv run stringgraph report` rerun on the merged graph; unique `formal.lean_decl` count rerun via `collect_decls`, not a fresh `check-axioms`/`lake build` (none run this pass) |
| M2 | Assembly step said "open" but is now a proved conditional theorem (`no_ghost_of_spans`) | Abstract, §5: rewritten — assembly done conditional on `DDFSpans`; only the spanning hypothesis itself (open beyond `N=1`) remains |
| M3 | Spanning section didn't mention the slice-to-total glue lemma or `N=2` progress | §5: added `Glue.lean`'s `ddfSpans_of_forall_slice` and `LevelTwoSpan.lean`'s resolution of the two named `N=2` blockers (the `N=2` spanning proof itself remains open) |
| M4 | C2 (Kac determinant) didn't mention the Fock-freeness byproduct | §2 C2: added `FockFreeLowLevel.lean` (`N≤4` Fock-module freeness; `hwv_ne_zero_of_two_le` strengthens C1's existence result) |
| M5 | §4 `Math/` file list omitted two newly merged general-purpose lemma files | §4: added `EulerPoincare.lean`, `RegulatedSum.lean`, and the `Bridge.riemannZeta_neg_one` bridge, flagged as not part of C1–C6 |
