# The *P*-rescaling torsion divisor sum: invariance group, frame dependence, and blast radius

**Slug**: `p-rescaling-frame-dependence`
**State**: draft (see `status.yaml`). Nothing here has been reviewed; nothing here may be
depended on by `graph/`.
**Companion files**: `claim.md` (the precise propositions), `lit-findings.md` (every
literature quotation, each tagged L1 = page image read by me / L3 = transcribed),
`scripts/` (exact-integer verification), `scripts/run_output.txt`,
`scripts/lattice_frames_output.txt`.

---

## 0. Notation and standing conventions

Λ is the charge lattice of type II on K3 × T² (even, self-dual, signature (6,22)); only a
rank-2 primitive sublattice matters below. A **frame** is an ordered basis (Q,P) of a rank-2
sublattice L = ℤQ + ℤP ⊆ Λ. Its **invariants** are

> m = Q²/2,  n = P²/2,  ℓ = Q·P,  T = [[m, ℓ/2],[ℓ/2, n]],  Δ = 4mn − ℓ² = 4 det T.

A change of frame is (Q,P) ↦ (Q′,P′) = (aQ + bP, cQ + dP) with U = [[a,b],[c,d]] ∈ SL(2,ℤ),
under which T ↦ T′ = U T Uᵀ, i.e.

> m′ = a²m + abℓ + b²n,  n′ = c²m + cdℓ + d²n,  ℓ′ = 2acm + (ad+bc)ℓ + 2bdn.   (0.1)

**Torsion** I = gcd(Q ∧ P), the largest r with Q ∧ P ∈ r·(Λ ∧ Λ). It depends on L, not on
the frame.

A frame is **Q-adapted** if Q ∈ IΛ, and **P-adapted** if P ∈ IΛ.
Q-adapted ⟹ I²|m and I|ℓ; P-adapted ⟹ I²|n and I|ℓ. *The converses are false and that is
the entire content of this note.*

`d_*(m,n,ℓ)` is the immortal (single-centred) index defined by the attractor-contour integral
of §2 of `research/papers/torsion-dyon-shift-positivity/paper.md`. The two divisor-sum
operators that occur in the literature are

> **(Q-rescaling)**  D_I(m,n,ℓ) := Σ_{s|I} s · d_*(m/s², n, ℓ/s)
> **(P-rescaling)**  D′_I(m,n,ℓ) := Σ_{s|I} s · d_*(m, n/s², ℓ/s)

with the convention that a summand is **omitted** when s² ∤ (the rescaled slot) or s ∤ ℓ.
Both are defined for an arbitrary GL(2,ℤ)-class function f in place of d_*; where that
matters I write D_I[f], D′_I[f].

A third operator, the **signed** one, is derived in §8:

> D̃_I(m,n,ℓ) := Σ_{s|I} s (−1)^{ℓ − ℓ/s} d_*(m/s², n, ℓ/s).

**Which charge is divided is the only safe identifier.** Letter conventions differ across the
literature: DGM 0803.2692 and Cardoso–Nampuri–Rosselló 2007.10302 divide the *electric*
invariant Q²/2 by s²; Alexandrov–Nampuri 2009.01172 and Bossard–Cosnier-Horeau–Pioline
1806.03330 divide the *magnetic* invariant P²/2, even though AN's letters (n = Q²/2,
m = P²/2) make (2.13) *look* like DGM's (3.28) when read left-to-right. All classifications
in `lit-findings.md` were made on the "which slot carries s²" criterion, never on letters.

---

## 1. Results, and an honest statement of what is new

| | statement | status | novelty |
|---|---|---|---|
| Lemma 2.1 | d_* is a GL(2,ℤ)-class function | proved in `paper.md` Prop A.1; re-verified here | not new |
| **Theorem A** | D′_I(m,n,ℓ) = D_I(n,m,ℓ) | proved §3 | new as a statement, trivial as mathematics; it is the precise form of BCP's "in agreement with [41,72]" |
| **Theorem C** | D_I is Γ⁰(I)-invariant; D′_I is Γ₀(I)-invariant | proved §4 | **not new**: this is DGM (4.5)–(4.7) restated on the charge side, and CNR App. A (A.9)–(A.11) |
| **Prop. 5.1** | the Q-adapted frames of a fixed L are *exactly* one Γ⁰(I)-coset; likewise P-adapted / Γ₀(I) | proved §5 | I have not found it stated; it is implicit in Banerjee–Sen 0801.0149 |
| **Theorem B** | two frames of one torsion-2 lattice, both passing the arithmetic hypotheses (I²\|n, I\|ℓ), give different D′_2 | proved §6, exact integers | the *measurement* is new; the phenomenon is DGM §4.1 |
| **Theorem D** | the immortal index is **not** a function of (m,n,ℓ,I) at I = 2; the gap at (4,8,8) is 305 754 336 | proved §7 from DGM + S-duality | qualitatively known (BSS 0802.0544 §6.3: three T-duality orbits at fixed (Q²,P²,Q·P)); the number is new |
| **Theorem E** | the signed sum D̃_I is *also* Γ⁰(I)-invariant, and BSS (7) is the signed sum | proved §8 | new |

**The single most important finding of this attempt is negative and narrowing**: DGM
0803.2692 §4.1 *state and prove* the Γ⁰(I) restriction themselves, and say in as many words
that a **different** partition function 𝒵_I^{(l)} must be used on each other coset
(`lit-findings.md` F3b, L1, printed pp. 18–19). The frame dependence reported by
`paper.md` Remark 6.3 is therefore not an oversight in the literature; it is the content of
DGM §4.1, dropped from the notation when (3.28) writes the left-hand side as a function of
(Q²/2, P²/2, Q·P) alone. Everything below is written in that light.

---

## 2. The class-function lemma

**Lemma 2.1.** For every V ∈ GL(2,ℤ) and every positive-definite T = [[m, ℓ/2],[ℓ/2, n]]
with m, n ∈ ℤ, ℓ ∈ ℤ, Δ = 4mn − ℓ² > 0,

> d_*(V T Vᵀ) = d_*(T).

In particular d_*(m,n,ℓ) = d_*(n,m,ℓ) (take V = [[0,1],[1,0]], det = −1) and
d_*(m,n,ℓ) = d_*(m,n,−ℓ) (take V = diag(1,−1)).

*Proof.* The SL(2,ℤ) part is Proposition A.1 of `paper.md`, proved there from the Sp(4,ℤ)
modularity of Φ₁₀ together with the covariance of the attractor contour Im Ω = 2Λ₀·adj T
(Theorem 5.2 of the same). GL(2,ℤ) = SL(2,ℤ) ⋊ ⟨diag(1,−1)⟩, and conjugation by diag(1,−1)
sends (m,n,ℓ) ↦ (m,n,−ℓ), which fixes d_* because 𝒢(ρ,σ,v) = −1/Φ₁₀(ρ,σ,v+½) is even in v
(Φ₁₀ is odd in v, and v ↦ −v combined with v ↦ v+1 periodicity fixes v+½ up to sign). ∎

*Machine check.* `scripts/run_output.txt` PART 0: over all 1 ≤ m,n ≤ 6, |ℓ| ≤ 6 with Δ > 0,
six generators of GL(2,ℤ) including the swap — **0 violations**.

---

## 3. Theorem A: the two published operators are reflections of one another

**Theorem A.** For every integer I ≥ 1 and every (m,n,ℓ) with m,n ≥ 1 and Δ > 0,

> D′_I(m,n,ℓ) = D_I(n,m,ℓ).

*Proof.* Compare term by term. The s-th summand of the left side is present iff s²|n and
s|ℓ, and equals s·d_*(m, n/s², ℓ/s). The s-th summand of D_I(n,m,ℓ) is obtained by
substituting (m,n,ℓ) → (n,m,ℓ) into Σ_{s|I} s·d_*(m/s², n, ℓ/s); it is therefore present iff
s²|n and s|ℓ — the same condition — and equals s·d_*(n/s², m, ℓ/s). By Lemma 2.1,
d_*(n/s², m, ℓ/s) = d_*(m, n/s², ℓ/s). The two sums have the same index set and equal
summands. ∎

**Machine check.** PART 1: I ∈ {1,2,3,4,6}, 1 ≤ m ≤ 12, 1 ≤ n ≤ 12, 0 ≤ ℓ ≤ 2(m+n),
Δ > 0 — **8750 instances checked, 0 violations**.

**Corollary 3.1 (what BCP's "in agreement" means).** Bossard–Cosnier-Horeau–Pioline
1806.03330 write the P-rescaling sum (5.80) on the P-adapted frame Q = e₁ + q e₂, P = p e₂
(their (5.79)) and say it is "in agreement with the prescription in [41, 72]" = BSS
0802.1556 and DGM 0803.2692, which are Q-rescaling (`lit-findings.md` F8, L1 p. 64). That
sentence is **correct**, and Theorem A is its precise form: the P-rescaling statement on a
P-adapted frame and the Q-rescaling statement on a Q-adapted frame are the same statement,
conjugated by the S-duality element S = [[0,1],[−1,0]] : (Q,P) ↦ (P,−Q). This is developed
in §7.

---

## 4. Theorem C: the exact invariance group

Write, for s | I,

> T_s := W_s T W_sᵀ with W_s := diag(1/s, 1),  so  T_s = [[m/s², ℓ/(2s)],[ℓ/(2s), n]],

i.e. T_s is the Gram matrix of the form (m/s², ℓ/s, n) appearing in the s-th summand of D_I.
Let S_s(m,n,ℓ) denote the support condition "s²|m and s|ℓ", which is exactly the condition
that T_s be the Gram matrix of an integral binary quadratic form.

**Theorem C.** Let U = [[a,b],[c,d]] ∈ SL(2,ℤ) with **I | b**, and let (m′,n′,ℓ′) be given by
(0.1). Then for every s | I:

1. V_s := W_s U W_s^{−1} = [[a, b/s],[cs, d]] lies in SL(2,ℤ);
2. S_s(m′,n′,ℓ′) ⟺ S_s(m,n,ℓ);
3. when they hold, d_*(T′_s) = d_*(T_s).

Consequently D_I(m′,n′,ℓ′) = D_I(m,n,ℓ) for every U ∈ Γ⁰(I) := {U ∈ SL(2,ℤ) : b ≡ 0 mod I}.
The same holds for D_I[f] with any GL(2,ℤ)-class function f in place of d_*. By Theorem A,
D′_I is invariant under Γ₀(I) := {U ∈ SL(2,ℤ) : c ≡ 0 mod I}.

*Proof.*
(1) V_s = diag(1/s,1)·[[a,b],[c,d]]·diag(s,1) = [[a, b/s],[cs, d]]. Since s | I | b, the entry
b/s ∈ ℤ, so V_s is integral; det V_s = ad − (b/s)(cs) = ad − bc = 1.

(3) and (2). From T′ = U T Uᵀ,

> T′_s = W_s U T Uᵀ W_sᵀ = (W_s U W_s^{−1})(W_s T W_sᵀ)(W_s U W_s^{−1})ᵀ = V_s T_s V_sᵀ.  (4.1)

If S_s(m,n,ℓ) holds then T_s is the Gram matrix of an integral form; V_s ∈ SL(2,ℤ) by (1), so
V_s T_s V_sᵀ is again the Gram matrix of an integral form, i.e. S_s(m′,n′,ℓ′) holds. The
converse follows by applying the same argument to U^{−1} = [[d,−b],[−c,a]], which also has
upper-right entry ≡ 0 mod I, with V_s^{−1} = [[d, −b/s],[−cs, a]]. Given S_s, Lemma 2.1
applied to (4.1) gives d_*(T′_s) = d_*(T_s). Summing over s | I with weights s gives the
displayed consequence. The Γ₀(I) statement for D′_I follows by substituting (m,n,ℓ) ↦
(n,m,ℓ) in Theorem A, which conjugates U ↦ [[d,c],[b,a]] and so exchanges the roles of b and
c. ∎

**Prior art — this theorem is not new.** Identity (4.1) is, term for term, DGM 0803.2692
(4.6) transported from the period-matrix side to the charge side. DGM write (L1, printed
p. 18, `lit-findings.md` F3b):

> "The partition function 𝒵_I is however not invariant under the full SL(2,ℤ) but only under
> a congruence subgroup Γ⁰(I) defined by matrices h = (a b; c d) ∈ SL(2,ℤ), b = 0 mod I.
> (4.5) … (s²ρ′ sv′; sv′ σ′) = (d −sc; −b/s a)(s²ρ sv; sv σ)(d −b/s; −sc a) (4.6) … Using
> the fact that b = 0 mod (I) … Φ₁₀(s²ρ′,σ′,sv′) = Φ₁₀(s²ρ,σ,sv). (4.7)"

The matrix (d, −sc; −b/s, a) is V_s^{−ᵀ} up to the standard period/charge transpose, and
"integral iff s | b" is the same observation. The same computation appears again in
Cardoso–Nampuri–Rosselló 2007.10302 App. A (A.9)–(A.11) (L1 p. 30): "Demanding m_γ ∈ ℤ,
n_γ ∈ t²ℤ, ℓ_γ ∈ tℤ implies that q is a multiple of t, and hence γ lies in the subgroup
Γ⁰(t) ⊂ PSL(2,ℤ)." (Their γ = (p q; r s) is my U conjugated by the swap, which fixes the
upper-right entry, so "q ≡ 0 mod t" and "b ≡ 0 mod I" are the same condition — this
cross-check matters, because the ρ/σ/v slot trap has a group-theoretic twin.)

**Sharpness (machine, PART 5).** Γ⁰(I) is contained in the stabiliser by the theorem; it is
not properly contained, at least at generic points. Over all SL(2,ℤ) matrices with entries in
[−4,4] (180 of them) and all admissible (m,n,ℓ) in the computed range:

- I = 2: b ≡ 0 mod 2 → D_2 preserved in **15686** cases, violated in **0**;
  b ≢ 0 mod 2 → D_2 **changed** in 4776 cases, coincidentally equal in 3036.
- I = 3: preserved 3100 / violated 0; changed 280 / coincidentally equal 540.

Since D_I factors through the coset space Γ⁰(I)\SL(2,ℤ), whose invariant is the top row
(a,b) mod I, the sharpest possible witness is a base point on which all [SL(2,ℤ):Γ⁰(2)] = 3
cosets give distinct values. **Base (m,n,ℓ) = (4,8,0), I = 2** does exactly that:

| coset (a,b) mod 2 | D_2 |
|---|---|
| (0,1) | 479 643 211 429 797 888 |
| (1,0) | 479 644 528 841 797 440 |
| (1,1) | 479 643 201 102 715 656 |

so at that point the stabiliser is **exactly** Γ⁰(2) and the factorisation through
Γ⁰(2)\SL(2,ℤ) is injective. (At other base points two cosets can coincide numerically; e.g.
(4,4,0) gives values A, A, B. That is an accident of the particular d_* values, not a larger
invariance group.)

---

## 5. Which frames are adapted: exactly one coset

**Proposition 5.1.** Let L ⊆ Λ be a rank-2 primitive sublattice of torsion I, and suppose
L admits at least one Q-adapted frame (Q₀,P₀), i.e. Q₀ ∈ IΛ. Then a frame
(Q,P) = (aQ₀ + bP₀, cQ₀ + dP₀), U ∈ SL(2,ℤ), is Q-adapted **iff** I | b. Hence the set of
Q-adapted frames of L is exactly the coset Γ⁰(I)·(Q₀,P₀). Dually, the set of P-adapted
frames of a lattice admitting one is exactly a Γ₀(I)-coset.

*Proof.* Write Q₀ = I·Q̃ with Q̃ ∈ Λ. Then Q₀ ∧ P₀ = I·(Q̃ ∧ P₀), so
I = gcd(Q₀ ∧ P₀) = I·gcd(Q̃ ∧ P₀), whence gcd(Q̃ ∧ P₀) = 1. In particular **P₀ is primitive
in Λ**: if P₀ = k·P̃ with k > 1 then k | gcd(Q̃ ∧ P₀).

Q = aQ₀ + bP₀ with Q₀ ∈ IΛ, so Q ∈ IΛ ⟺ bP₀ ∈ IΛ. Since Λ is unimodular and P₀ primitive,
there is λ ∈ Λ with P₀·λ = 1. If bP₀ ∈ IΛ then b = b(P₀·λ) = (bP₀)·λ ∈ Iℤ. Conversely if
I | b then bP₀ ∈ IΛ trivially. The dual statement follows by applying this to the frame
(P,−Q) (the S-duality element S), under which "Q-adapted" ↔ "P-adapted" and Γ⁰(I) ↔ Γ₀(I). ∎

**Corollary 5.2 (the formulae *are* well posed — just not as functions of (m,n,ℓ,I)).**
Combining Proposition 5.1 with Theorem C: D_I takes a single value on *all* Q-adapted frames
of a fixed L, and D′_I takes a single value on all P-adapted frames of a fixed L. So both
published formulae are well defined as functions of

> (the lattice L, a choice of adapted type),

and what fails is only the further step of dropping the adaptedness from the notation.

**Machine check (`scripts/lattice_frames_output.txt`, block L1).** The rank-2 lattice
L = ℤQ + ℤP inside U ⊕ U ⊂ Λ with

> Q = 4f₁ + e₂ + 4f₂,  P = 2e₁ + 4f₁

has torsion I = 2, P ∈ 2Λ (P-adapted), Q ∉ 2Λ, and invariants (m,n,ℓ) = (4,8,8). The frame
(Q, P − Q) of the *same* L (U = [[1,0],[−1,1]], c = −1 ≢ 0 mod 2, so outside Γ₀(2) as
Proposition 5.1 requires) has invariants (4,4,0) and is **neither** Q- nor P-adapted.

---

## 6. Theorem B: frame dependence of the *P*-rescaling sum, with exact integers

**Theorem B.** There is a rank-2 sublattice L ⊆ Λ of torsion I = 2 with two frames whose
invariants both satisfy the arithmetic hypotheses I²|n and I|ℓ under which the P-rescaling
formulae are stated in the literature, but on which D′_2 takes different values.

*Proof.* Take L, Q, P as in §5. The two frames are (Q,P) and (Q, P−Q), with invariants
(4,8,8) and (4,4,0). Both satisfy 4 | n and 2 | ℓ. The relevant d_* values, computed exactly
(PART 2):

| form | reduced representative | d_* |
|---|---|---|
| (m,n,ℓ) = (4,8,8) | (4,4,0) | 7 999 169 992 704 |
| (m, n/4, ℓ/2) = (4,2,4) | (2,2,0) | 32 861 184 |
| (m,n,ℓ) = (4,4,0) | (4,4,0) | 7 999 169 992 704 |
| (m, n/4, ℓ/2) = (4,1,0) | (1,4,0) | 185 738 352 |

Hence

> D′_2(4,8,8) = 7 999 169 992 704 + 2·32 861 184  = **7 999 235 715 072**
> D′_2(4,4,0) = 7 999 169 992 704 + 2·185 738 352 = **7 999 541 469 408**
> difference = **305 754 336**  (relative size ≈ 3.8 × 10⁻⁵).

The s = 1 terms agree because (4,8,8) and (4,4,0) are SL(2,ℤ)-equivalent forms (both reduce
to (4,4,0)) and d_* is a class function. The s = 2 terms differ because *rescaling does not
commute with the change of frame*: (4,2,4) and (4,1,0) reduce to (2,2,0) and (1,4,0), the two
inequivalent classes of discriminant −16 (class number h(−16) = 2). ∎

This is the exact transpose of `paper.md` Remark 6.3, as Theorem A predicts: PART 2 also
prints D_2(4,4,0) = 7 999 541 469 408 and D_2(8,4,8) = 7 999 235 715 072.

**Not an artefact of choosing d_*.** PART 4 repeats the computation with the *total* 1/4-BPS
index read at the attractor chamber and obtains the same two numbers. More generally: for any
GL(2,ℤ)-class function f, D_I[f] and D′_I[f] disagree at (m,n,ℓ,I) as soon as f separates the
classes of (m/s², ℓ/s, n) and (m, ℓ/s, n/s²) for some s | I, s > 1. The frame dependence is a
statement about the *operator*, not about the particular index.

---

## 7. Theorem D: the immortal index is not a function of (m,n,ℓ,I)

This is the physically meaningful form of the result, and it does **not** require trusting
the P-rescaling papers independently: it follows from DGM plus S-duality.

**Hypotheses.**
(H1) [DGM 0803.2692, on its own stated domain] For a torsion-I dyon possessing a Q-adapted
frame, with invariants (m,n,ℓ) in that frame, the index is D_I(m,n,ℓ).
(H2) [S-duality] The index is invariant under (Q,P) ↦ (aQ+bP, cQ+dP), U ∈ SL(2,ℤ), evaluated
at the attractor contour. For d_* this is `paper.md` Theorem 5.2 + Prop A.1.

**Lemma 7.1.** Under (H1)+(H2), a torsion-I dyon possessing a **P**-adapted frame, with
invariants (m,n,ℓ) in that frame, has index D′_I(m,n,ℓ).

*Proof.* Apply S = [[0,1],[−1,0]] : (Q,P) ↦ (P,−Q). The image frame has Q′ = P ∈ IΛ, i.e. it
is Q-adapted, with invariants (m′,n′,ℓ′) = (n, m, −ℓ). By (H2) the index is unchanged; by
(H1) it equals D_I(n,m,−ℓ). Each summand of D_I(n,m,−ℓ) is s·d_*(n/s², m, −ℓ/s) =
s·d_*(m, n/s², ℓ/s) by Lemma 2.1, so D_I(n,m,−ℓ) = D′_I(m,n,ℓ) (this is Theorem A together
with evenness in ℓ). ∎

**Theorem D.** Under (H1)+(H2) the 1/4-BPS immortal index is **not** a function of
(m,n,ℓ,I). Explicitly, at (m,n,ℓ,I) = (4,8,8,2) there exist both a Q-adapted and a P-adapted
torsion-2 lattice in Λ, and their indices are

> Q-adapted:  D_2(4,8,8)  = d_*(4,8,8) + 2 d_*(1,8,4) = **7 999 541 469 408**
> P-adapted:  D′_2(4,8,8) = d_*(4,8,8) + 2 d_*(4,2,4) = **7 999 235 715 072**
> difference = **305 754 336**.

*Proof.* Existence of both frames is verified in `scripts/lattice_frames_output.txt` block L2
inside U ⊕ U ⊂ Λ:

> Q-adapted: Q = 2e₁ + 2f₁ ∈ 2Λ,  P = 4e₁ + e₂ + 8f₂;  torsion 2, invariants (4,8,8).
> P-adapted: Q = 4f₁ + e₂ + 4f₂,  P = 2e₁ + 4f₁ ∈ 2Λ;  torsion 2, invariants (4,8,8).

Both arithmetic hypotheses hold simultaneously there: 4 | m, 4 | n, 2 | ℓ. The values are
(H1) and Lemma 7.1 respectively. The two s = 2 arguments are (1,8,4) → reduced (1,4,0) and
(4,2,4) → reduced (2,2,0): inequivalent classes of discriminant −16, with d_* equal to
185 738 352 and 32 861 184. ∎

**This is consistent with, and quantifies, a result of 2008.** Banerjee–Sen–Srivastava
0802.0544 §6.3 (L1 p. 35, `lit-findings.md` F5b) state that at torsion 2 there are **three**
T-duality orbits at fixed (Q², P², Q·P) — Q ∈ 2Λ, P ∈ 2Λ, and both primitive with
Q ± P ∈ 2Λ — and give a separate partition function for each (F5d). Theorem D says these
orbits carry *different* indices, and supplies the difference for the first two of them. The
third orbit is exhibited concretely in `lattice_frames_output.txt` block L3; its index is
**[GAP: the third orbit's index is not computed here.** BSS 0802.0544 eq (1.23) gives a third
partition function; extracting its coefficients requires implementing that function, which
this attempt did not do. The divisor-sum operators D_I and D′_I do not cover it.**]**

**Consequence for Question 2 of the task.** The P-rescaling formulae *are* likewise frame
dependent, and by exactly the same mechanism — the mechanism is Theorem C plus the failure of
the converse "I²|n and I|ℓ ⟹ P-adapted". Question 2 is answered in the affirmative, with an
explicit integer witness.

---

## 8. Theorem E: the signed divisor sum, and which side of the sign question BSS is on

### 8.1 What BSS (7) actually is

BSS 0802.1556 (L1 p. 4, `lit-findings.md` F4d) reduce their proposal to

> d(Q,P) = (−1)^{Q·P+1} Σ_{s|r} g(s) s³ ∫ dρ̌ ∫_{1/s²} dσ̌ ∫_{1/s} dv̌
>          e^{−iπ(σ̌Q² + ρ̌P² + 2v̌ Q·P)} Φ₁₀(ρ̌, s²σ̌, s v̌)^{−1},   (BSS 7)

with g(s) = s (their (5)), and with the Fourier convention (their (1))
1/Φ̌ = Σ (−1)^{Q·P+1} f(Q²,P²,Q·P) e^{iπ(σ̌Q² + ρ̌P² + 2v̌ Q·P)}, so σ̌ ↔ Q²/2, ρ̌ ↔ P²/2,
v̌ ↔ Q·P (F4b). **This is Q-rescaling**: the σ̌ slot, which pairs with Q², carries s².

**Proposition 8.1.** (BSS 7) equals Σ_{s|r} s (−1)^{ℓ − ℓ/s} f(m/s², n, ℓ/s), i.e. the
**signed** divisor sum D̃_r[f], where f is BSS's positive-convention coefficient.

*Proof.* Substitute σ̃ = s²σ̌ and ṽ = s v̌ in the s-th term. The Jacobian is
dσ̌ dṽ̌ = s^{−3} dσ̃ dṽ, cancelling the explicit s³, and the integration ranges 1/s², 1/s
become full unit periods. The exponent becomes
−iπ(σ̃·Q²/s² + ρ̌P² + 2ṽ·(Q·P)/s), so the s-th term extracts the Fourier coefficient of
1/Φ₁₀ at (Q²/(2s²), P²/2, (Q·P)/s) = (m/s², n, ℓ/s). By (1) that coefficient carries the sign
(−1)^{ℓ/s+1}. Multiplying by the overall prefactor (−1)^{ℓ+1} and by g(s) = s gives the
weight s·(−1)^{ℓ+1}(−1)^{ℓ/s+1} = s·(−1)^{ℓ+ℓ/s} = s·(−1)^{ℓ−ℓ/s}. ∎

So **BSS lands on the DGM (3.26)+(3.27) side** of the sign question, not on the bare (3.28)
side. (This settles "Theorem D" as posed in `claim.md`; it is renumbered here to avoid a
clash with §7.)

Two corrections to earlier project notes follow, and both are recorded in `lit-findings.md`:

- The k, l sums in BSS (4) are a **periodisation**, not an elliptic shift: BSS say so
  ("The sum over k and l in (4) makes Φ̌ periodic under σ̌ → σ̌ + 1/r² and v̌ → v̌ + 1/r as
  required") and then carry the projection out, obtaining (7) with **no surviving shift**.
  This corrects `literature/extractions/dgm-eq51-eq52-third-party-crosscheck.md` §E1/E2,
  which read the l = 1, s̄ = 2 term's "v̌ + 1/2" as independent support for a half-integer
  shift. It is not: it is one term of a finite average.
- Hence "Theorem C" as posed in `claim.md` (that the k,l average is a projector returning 0
  off the adapted arithmetic) is **false as stated**: the average is undone inside BSS's own
  derivation, and (7) is an honest divisor sum on the set 𝓑 (= Q-adapted, F4a).

### 8.2 The sign does not break the invariance

**Theorem E.** Let U = [[a,b],[c,d]] ∈ SL(2,ℤ) with I | b, and let (m,n,ℓ) satisfy I²|m and
I|ℓ. Then for every s | I with s²|m, s|ℓ,

> ℓ′ − ℓ′/s ≡ ℓ − ℓ/s  (mod 2),

and consequently D̃_I[f](m′,n′,ℓ′) = D̃_I[f](m,n,ℓ) for every GL(2,ℤ)-class function f.

*Proof.* By (0.1), ℓ′ = 2acm + (ad+bc)ℓ + 2bdn, so

> ℓ′ ≡ (ad+bc)·ℓ  (mod 2).   (8.1)

Applying (0.1) to the s-th rescaled triple (m/s², n, ℓ/s) with the matrix V_s = [[a, b/s],
[cs, d]] of Theorem C, and using T′_s = V_s T_s V_sᵀ,

> ℓ′/s = 2·a·(cs)·(m/s²) + (a d + (b/s)(cs))·(ℓ/s) + 2·(b/s)·d·n
>      = 2·(acm/s) + (ad+bc)·(ℓ/s) + 2·(bd n/s).

Both bracketed quantities are integers: acm/s = acs·(m/s²) ∈ ℤ because s²|m, and
bdn/s = (b/s)·dn ∈ ℤ because s | I | b. Hence

> ℓ′/s ≡ (ad+bc)·(ℓ/s)  (mod 2).   (8.2)

Subtracting (8.2) from (8.1), ℓ′ − ℓ′/s ≡ (ad+bc)(ℓ − ℓ/s) mod 2. Finally ad − bc = 1 gives
ad + bc = 1 + 2bc, which is **odd**. Therefore ℓ′ − ℓ′/s ≡ ℓ − ℓ/s mod 2. The signs in
D̃_I therefore match summand by summand, the supports match by Theorem C(2), and the values
match by Theorem C(3). ∎

**Machine check (PART 6).** I = 2: 24 304 cases with I|b, **0 violations**. I = 3: 4 700
cases, **0 violations**. The parity statement itself, checked directly for I ∈ {2,3,4,6},
m < 30, n < 30, |ℓ| ≤ 20: **0 mismatches**.

*(This check originally reported thousands of spurious violations produced by a Python
`(-1) ** k` with negative k returning a float. The bug is recorded here because the
conclusion was inverted by it for one revision; the fix is `(-1) ** (k % 2)`, commit
`a504e31`.)*

**Reading.** The sign convention is irrelevant to the frame question. Both the (3.28)-type
and the (3.26)+(3.27)-type sums are Γ⁰(I)-invariant and neither is SL(2,ℤ)-invariant, so the
unresolved DGM eq(51)/eq(52) sign discrepancy tracked elsewhere in this project is
**orthogonal** to the frame-dependence question, and neither resolves the other.

---

## 9. Answers to the three questions of the task

**Q1 (which literature formulae are P-rescaling).** Not BSS — that was the working hypothesis
in `claim.md` §1 and it is **refuted**: BSS 0802.1556 (1)–(2) put Q²/2 in the σ̌ slot which
carries s², so BSS is Q-rescaling (F4b, F4d). The P-rescaling family, identified by which
charge sits in the slot divided by s², is:

- **Alexandrov–Nampuri 2009.01172 eq (2.13)**: Ω_I(n,m,ℓ) = Σ_{d|I} d Ω_1(n, m/d², ℓ/d) with
  their (2.6) fixing m = P²/2 — so the **magnetic** invariant is divided. Attributed by AN to
  DGM 0803.2692, which divides the electric one. (L1, F7a/F7b.)
- **Bossard–Cosnier-Horeau–Pioline 1806.03330 eq (5.80)**: Gram argument
  (Q², QP/d; QP/d, P²/d²) — **P²** divided by d², stated on the explicitly P-adapted frame
  (5.79) Q = e₁ + q e₂, P = p e₂, with the attractor contour transformed alongside. (L1, F8.)

Everything else located divides the electric invariant: DGM (3.27)/(3.28), BSS (7),
CNR 2007.10302 (3.40) (their letters m = ½Q_m², n = ½Q_e² make it *look* like AN's).

**Q2 (are they likewise basis dependent).** Yes. Theorem B gives the explicit integer
witness; Theorem C identifies the exact invariance group as Γ₀(I) (rather than Γ⁰(I)) for the
P-rescaling operator; Proposition 5.1 identifies the domain on which it is nonetheless well
posed; Theorem D converts this into the physical statement that the index is not a function
of (m,n,ℓ,I).

**Q3 (blast radius).** The classified table is `lit-findings.md` §7 and is not duplicated
here. Summary: of the eight located papers that write a torsion divisor sum, **six are (乙)**
— they state it on an explicitly adapted or explicitly fixed frame — **including DGM itself**,
whose §4.1 proves the Γ⁰(I) restriction and supplies a distinct 𝒵_I^{(l)} per coset. Two are
**(甲) narrowly**: AN 2009.01172 (2.13) and CNR 2007.10302 §3.7, each requiring **one
sentence's hypothesis to be tightened** (add "on a P-adapted frame" / "on a Q-adapted
frame"); no computed number in either paper is wrong, because both compute on adapted frames
in practice. Four more papers are **(丙)**: they restrict to I = 1 and cite the torsion
literature only as the reason for doing so.

**The blast radius is small, and smaller than the shape of the negative result suggests.**
That is the honest answer and it should be reported as such rather than inflated.

---

## 10. Open gaps

- **[GAP: AN's Γ⁰(I) in (2.16).]** AN pair a P-rescaling divisor sum (2.13) with the label
  Γ⁰(I) (2.16), taken over from DGM. If (2.16)'s SL(2,ℤ) is the charge-space S-duality, the
  pairing is inconsistent (Theorem C says the P-rescaling stabiliser is Γ₀(I)). If it is the
  Jacobi-modular group on (τ,z), no comparison is meaningful without redoing the Sp(4,ℤ)
  embedding. **The text I have read does not determine which.** See `lit-findings.md` F7c.
  This is the only place where a (甲) classification could move to (乙).
- **[GAP: third torsion-2 orbit.]** §7: the index of the both-primitive orbit
  (Q, P primitive, Q ± P ∈ 2Λ) is not computed. It is not given by D_2 or D′_2.
- **[GAP: survey completeness.]** The 98 INSPIRE records citing DGM were triaged by full-text
  search for "torsion" on the nine most likely candidates only. Records without an arXiv
  eprint, and papers reaching the divisor sum through BSS or Banerjee–Sen rather than DGM,
  were not enumerated. `lit-findings.md` §7 carries the same note.
- **[GAP: (H2) at torsion I > 1.]** Lemma 7.1 assumes S-duality invariance of the *immortal*
  index at the attractor contour for I > 1. `paper.md` Theorem 5.2 + Prop A.1 give this for
  d_* as defined by the attractor contour; whether the physical single-centred index is
  exactly that d_* at I > 1 is the standing question of `holography.torsion-immortal-positivity`
  and is **not** settled here. PART 4 shows Theorem D's conclusion is unchanged if the total
  index is used instead, so the conclusion does not hinge on this — but the specific integers
  attached to "the immortal index" do.
- **Not a gap, but a scope limit.** Nothing here touches whether DGM eq(51) or eq(52) is the
  correct sign convention; §8.2 shows that question is orthogonal.

---

## 11. Reproduction

```
cd research/attempts/p-rescaling-frame-dependence/scripts
python p_rescaling_witness.py        # PARTS 0-6; output committed as run_output.txt
python lattice_frames.py             # explicit lattice frames; asserts every claim
```

`p_rescaling_witness.py` imports the exact-integer Fourier machinery from
`research/attempts/torsion-immortal-positivity-hecke/scripts/{coefficients.py,
torsion_divisor_sum.py}` (read-only from here) and re-runs it rather than trusting cached
numbers. All arithmetic is Python `int`; the only float printed anywhere is the commentary
line "relative size ≈ 3.822e-05" in PART 2, which enters no assertion.
