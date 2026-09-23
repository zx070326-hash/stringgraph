# Claim: frame-dependence of the *P*-rescaling torsion divisor-sum formulae, and the blast radius of the finding

**Slug**: `p-rescaling-frame-dependence`
**Opened**: 2026-09-23
**Origin**: `research/papers/torsion-dyon-shift-positivity/paper.md` §9 (line 350) explicitly defers this:

> "whether the related fractional-shift summation formulae for torsion dyons in the literature
> are likewise frame-dependent (**those rescale P rather than Q**, so the analysis of Remark 6.3
> does not transfer directly and would need to be redone)"

---

## 0. Notation (fixed once; every later statement is read in it)

Λ = the charge lattice of type II on K3×T² (even, self-dual, signature (6,22); only the
rank-2 sublattice matters below). A **frame** is an ordered basis (Q,P) of a rank-2
sublattice L = ℤQ + ℤP ⊆ Λ. Its **invariants** are

  m = Q²/2,  n = P²/2,  ℓ = Q·P,  T(m,n,ℓ) = [[m, ℓ/2],[ℓ/2, n]],  Δ = 4mn − ℓ² = 4·det T.

**Torsion** I = gcd(Q∧P) = the largest integer r such that Q∧P ∈ r·Λ∧Λ. It is an invariant
of L, not of the frame.

`d_*(m,n,ℓ)` is the immortal (single-centred) index defined by the attractor-cycle contour
integral of §2 of the paper:

  d_*(m,n,ℓ) = ∫_{C_*(m,n,ℓ;Λ_0)} 𝒢(Ω) e^{−2πi(mρ+nσ+ℓv)} dρ dσ dv,  𝒢 = −1/Φ₁₀(ρ,σ,v+1/2),

with Ω = [[ρ,v],[v,σ]] and Im Ω = 2Λ_0·adj T. By Proposition A.1 of the paper (proved there
independently of Rosselló) d_* is a **class function on binary quadratic forms**:
d_*(A^{−T} T A^{−1}) = d_*(T) for A ∈ SL(2,ℤ), and (as a consequence of the y ↦ 1/y symmetry
of Φ₁₀ together with the swap) d_*(m,n,ℓ) = d_*(n,m,ℓ) = d_*(m,n,−ℓ).

Two divisor-sum operators, both appearing in the literature:

  **(Q-rescaling)**  D_I(m,n,ℓ) := Σ_{s|I} s · d_*(m/s², n, ℓ/s)   ← DGM 0803.2692 eq(3.28)
  **(P-rescaling)**  D'_I(m,n,ℓ) := Σ_{s|I} s · d_*(m, n/s², ℓ/s)  ← the Banerjee–Sen–Srivastava family

(terms with s²∤m resp. s²∤n, or s∤ℓ, are set to 0; this matches the contour-integral
convention of Theorem 5.2(b) of the paper).

A frame is **Q-adapted** if Q ∈ IΛ, and **P-adapted** if P ∈ IΛ. Q-adapted ⟹ I²|m, I|ℓ;
P-adapted ⟹ I²|n, I|ℓ. The converses are false, and that is the whole point.

---

## 1. What is to be established

### Claim 1 (literature, empirical — answers Question 1)

There is a well-defined "P-rescaling" family in the literature, consisting of at least
Banerjee–Sen–Srivastava arXiv:0802.0544 and arXiv:0802.1556. For each member I will record,
**verbatim from the arXiv PDF page image** (L1) and with the *PDF-compiled* equation number
(not ar5iv's): the formula, the quantifier attached to it, and whether the paper treats the
result as a function of (m,n,ℓ,I) or of a frame.

This is a research question, not a theorem; the deliverable is a citation table with an
explicit L1/L3 column.

### Claim 2 (mathematics — answers Question 2)

**Theorem A (reflection transfer).** For all integers I ≥ 1 and all (m,n,ℓ) with
m,n ≥ 1 and Δ > 0,

  D'_I(m,n,ℓ) = D_I(n,m,ℓ).

**Theorem B (P-rescaling frame dependence).** There exists a rank-2 sublattice L ⊆ Λ of
torsion I = 2 and two frames (Q₁,P₁), (Q₂,P₂) of *the same* L, both satisfying the
divisibility hypotheses I²|n and I|ℓ under which the P-rescaling formulae are stated, whose
invariants (m_i,n_i,ℓ_i) satisfy

  D'_2(m₁,n₁,ℓ₁) ≠ D'_2(m₂,n₂,ℓ₂).

Explicitly (to be confirmed by exact integer computation): frames with invariants (4,4,0)
and (4,8,8), giving 7999541469408 and 7999235715072.

**Theorem C (the literature formula is worse than the naive divisor sum).** The BSS
partition function of arXiv:0802.1556 is not the bare divisor sum: it carries an average
over the shifts k/s̄², l/s̄. I will compute its Fourier coefficients exactly and determine
(i) which divisor sum it actually produces, including the sign convention, and (ii) what it
returns on non-adapted frames. [The expected answer — to be proved, not assumed — is that
the k,l-average acts as a projector onto I²|n, I|ℓ, so that the formula returns **0** on
frames violating those conditions, which is a *stronger* form of frame dependence than
Remark 6.3's.]

**Theorem D (sign structure).** Determine whether the BSS formulae, read literally in their
own sign convention, reproduce the "eq(3.28)-type" divisor sum (all weights +s) or the
"eq(3.26)+(3.27)-type" one (weights s·(−1)^{ℓ−ℓ/s}), i.e. on which side of the
Proposition 3.1 incompatibility the P-rescaling family falls.

### Claim 3 (blast radius — answers Question 3)

A table of every located paper that writes down D_I or D'_I, classified:

- **(甲) load-bearing**: a stated conclusion of that paper would need restating if the
  divisor sum is not a charge function;
- **(乙) adapted-frame only**: the paper's use is covered by (P'_ad) and is unaffected;
- **(丙) transcription only**: the formula is quoted, nothing is deduced from it.

**I am not committed to any particular distribution.** A finding that the entire literature
is (乙)/(丙) is an acceptable and useful outcome; it would narrow the paper's claim, and
that narrowing must be reported rather than resisted.

---

## 2. Bricks used (all internal to this project, all already `verified` or proved in the paper)

- Proposition A.1 of `research/papers/torsion-dyon-shift-positivity/paper.md`
  (GL(2,ℤ)-invariance of d_*) — used for Theorem A and for the witness construction.
- Theorem 5.2 of the same (attractor-contour covariance) — used to justify setting the
  non-divisible terms to zero.
- The exact-integer implementation in
  `research/attempts/torsion-immortal-positivity-hecke/scripts/{coefficients.py,torsion_divisor_sum.py}`
  (Gauss reduction + DMZ finite part), re-run here rather than trusted.

No `conjecture`-status brick is used for Theorems A–D. Claim 1 and Claim 3 are empirical
literature statements and carry L1/L3 labels individually.

---

## 3. Explicitly out of scope

- The truth of the physical premise (P'_ad). Untouched.
- Whether DGM eq(3.27) or eq(3.28) is "the correct one". Settled elsewhere; here I only
  ask which side the P-family lands on.
- Any edit to `research/papers/**`. This attempt only reports; the paper edit, if any, is
  the lead's call.
