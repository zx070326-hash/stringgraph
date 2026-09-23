# Literature findings: who rescales what, and what they actually claim

**Attempt**: `research/attempts/p-rescaling-frame-dependence`
**Compiled**: 2026-09-23
**Evidence level convention**: **L1** = I downloaded the arXiv PDF and read the rendered page
image myself, equation numbers taken from the PDF's own compiled numbering. **L3** =
transcribed from another record (project extraction file or secondary source) without my own
page check. Every numbered item below carries its level.

> Standing project hazard, re-confirmed here: ar5iv/HTML equation numbers for these papers
> are not the compiled numbers (see `literature/extractions/dabholkar-gomes-murthy-2008.md`
> correction C2). Everything below that is marked L1 uses the PDF numbering.

---

## 0. The single most important correction: which papers rescale *which* charge

The question posed was "the literature's *P*-rescaling formulae". Determining who rescales
what cannot be done by the variable's *name* (ρ, σ, τ, σ̌ …) — every paper uses a different
name for the same slot. The only safe criterion is: **read the paper's own Fourier phase and
see which physical invariant sits in the slot that gets multiplied by s².**

| paper | slot carrying Q²/2 | slot carrying P²/2 | slot scaled by s² | **so it rescales** |
|---|---|---|---|---|
| DGM 0803.2692 | ρ | σ | ρ | **Q** |
| BSS 0802.1556 | σ̌ | ρ̌ | σ̌ | **Q** |
| BSS 0802.0544 | σ̌ (eq (1), eq (7.2)) | ρ̌ | — (no divisor sum at all; see F5c) | **neither** |
| Alexandrov–Nampuri 2009.01172 | τ (index n) | σ (index m) | σ | **P** |
| this project's paper.md | ρ (=m) | σ (=n) | ρ | **Q** |

### F0 (L1) — the paper's §9 parenthetical is factually wrong about BSS

`paper.md` line 350 says the other summation formulae in the literature "rescale P rather
than Q". For the Banerjee–Sen–Srivastava papers this is **false**: they rescale σ̌, and σ̌ is
their chemical potential for **Q²**, not P². The statement appears to descend from
`literature/extractions/dgm-eq51-eq52-third-party-crosscheck.md` §E3, which compared the
*letters* ρ vs σ across DGM and BSS and concluded the two are related by a duality frame
change ρ↔σ. They are not: both scale the Q²-slot; only the letter differs.

The paper's §9 sentence is however *accidentally* pointing at something real, because there
**is** a genuine P-rescaling formula in the literature — it is **Alexandrov–Nampuri
eq (2.13)**, which the paper itself uses as the main input of §4. See F5 and F6.

---

## 1. DGM, arXiv:0803.2692 — the Q-rescaling original

### F1 (L1, p. 5, §2.2, first paragraph)

> "We will see that for each orbit labeled by the discrete invariant I, the degeneracies of
> dyons are summarized in terms of a dyon partition function 𝒵_I(ρ,σ,v) of three complex
> variables (ρ,σ,v), which can be thought of as the three (complexified) chemical potentials
> for the three T-duality invariant integers (Q²/2, P²/2, Q·P) **respectively**."

⇒ **ρ ↔ Q²/2, σ ↔ P²/2, v ↔ Q·P.** (Cross-checked against eq (3.26), whose phase is
exp(−iπ Γᵗ [[ρ,v],[v,σ]] Γ) with Γ = (Q,P), i.e. ρQ² + 2v Q·P + σP².)

### F2 (L1, p. 16, §3.4) — the three equations, PDF numbering

- **(3.26)** Ω_I(Γ) = (−1)^{Q·P+1} ∮_𝒞 dσ dρ dv exp(−iπ Γᵗ·[[ρ,v],[v,σ]]·Γ) 𝒵_I(τ)
- **(3.27)** 𝒵_I(ρ,σ,v) = Σ_{s|I} s · 1/Φ₁₀(s²ρ, σ, sv)     ← **ρ scaled, i.e. Q**
- **(3.28)** Ω_I(Q²/2, P²/2, Q·P) = Σ_{s|I} s · Ω₁(Q²/(2s²), P²/2, (Q·P)/s)

Immediately preceding (3.26), verbatim: "In terms of the invariants (Q², P², Q.P) and
I = gcd(Q∧P) of the charge vector Γ (3.4), we can rewrite this formula as". Immediately
preceding (3.28): "The degeneracy can also be expressed as".

Upstream, **(3.23)** (L1, p. 16): ĉ^{4d}(Q₁,Q₅,n,l;I) = Σ_{s|I, s|n, s|l} s·ĉ^{4d}(Q₁,Q₅, nI/s², l/s; 1),
and **(3.24)** exhibits the change of variables explicitly, with contours 𝒞_s given in **(3.25)**:
0 ≤ Re(σ) ≤ 1, 0 ≤ Re(ρ) ≤ 1/s², 0 ≤ Re(v) ≤ 1/s. Here n (5d momentum) sits in the ρ slot and
Q₁Q₅ in the σ slot, confirming again that the divisor sum acts on the **electric** invariant.

### F3 (L1, pp. 4–5, §2.1) — DGM state the frame data themselves

- **(2.4)**–**(2.5)**: a basis (e₁,e₂) of the rank-2 sublattice Λ₀ can be chosen with
  Q = r₁e₁, P = r₂(u₁e₁ + r₃e₂), r₁,r₂,r₃,u₁ ∈ ℤ⁺, gcd(r₁,r₂)=gcd(u₁,r₃)=1, 1 ≤ u₁ ≤ r₃.
- verbatim: "The integers r₁, r₂, r₃, u₁ together with Q², P², and Q·P can be shown to be
  the complete set of T-duality invariants [15]."
- verbatim: "Note that the discrete U-duality invariant I is simply the product r₁r₂r₃. It
  can be shown [16,17] that a general set of discrete invariants (r₁,r₂,r₃,u₁) can be mapped
  to a representative in this orbit of the form (I,1,1,1) by an SL(2,ℤ) transformation.
  Moreover, this choice of the representative is invariant under the congruence subgroup
  **Γ⁰(I)** of the SL(2,ℤ). It will therefore suffice to compute the degeneracy in each
  family with the discrete invariants fixed to (I,1,1,1), which is expected to exhibit the
  Γ⁰(I) symmetry."

**Consequence.** (I,1,1,1) means Q = I·e₁, P = e₂, i.e. **Q ∈ IΛ — DGM's entire derivation
runs in a Q-adapted frame**, and DGM say so. They also state outright that (Q²,P²,Q·P) is
*not* a complete set of T-duality invariants; (r₁,r₂,r₃,u₁) is needed too. The
adapted-frame restriction of (P'_ad) is therefore **present in DGM's own §2**, and what
(3.28) does is drop it from the *notation* by writing the left side as a function of
(Q²/2,P²/2,Q·P) alone.

---

## 2. Banerjee–Sen–Srivastava, arXiv:0802.1556 ("torsion > 1") — also Q-rescaling

All items L1, pp. 2–4.

### F4a — the set on which the formula is asserted (p. 2, verbatim)

> "We consider the set 𝓑 of all dyons of charge vectors (Q,P) in heterotic string theory on
> T⁶, with **Q being r times a primitive vector, P a primitive vector**, and Q/r and P
> admitting a primitive embedding in the Narain lattice […] These dyons have torsion r, i.e.
> gcd(Q∧P) = r. It was shown in [21,22] that given any pair (Q,P) of this type with the same
> values of Q², P² and Q·P, they are related by T-duality transformation."

⇒ 𝓑 is exactly the **Q-adapted** set Q ∈ rΛ, and BSS's f is defined only on 𝓑.

### F4b — the partition function conventions (p. 2)

- **(1)**: 1/Φ̌(ρ̌,σ̌,v̌) = Σ_{Q²,P²,Q·P} (−1)^{Q·P+1} f(Q²,P²,Q·P) e^{iπ(σ̌Q² + ρ̌P² + 2v̌ Q·P)}
  ⇒ **σ̌ ↔ Q²/2, ρ̌ ↔ P²/2, v̌ ↔ Q·P.**
- **(2)**: Q²/2 ∈ r²ℤ, P²/2 ∈ ℤ, Q·P ∈ rℤ — the arithmetic shadow of Q-adaptedness.
- **(3)**: the inversion integral, with ρ̌ over a period 1, σ̌ over 1/r², v̌ over 1/r.

### F4c — the proposal (p. 3)

- **(4)**: Φ̌(ρ̌,σ̌,v̌)^{−1} = Σ_{s∈ℤ, s|r ; s̄ ≡ r/s} g(s) (1/s̄³) Σ_{k=0}^{s̄²−1} Σ_{l=0}^{s̄−1}
  Φ₁₀(ρ̌, s²σ̌ + k/s̄², s v̌ + l/s̄)^{−1}
- **(5)**: g(s) = s
- verbatim after (4): "The sum over k and l in (4) makes Φ̌ periodic under σ̌ → σ̌ + (1/r²)
  and v̌ → v̌ + (1/r) as required."

**The k,l sums are a periodisation, not an elliptic shift.** This corrects
`literature/extractions/dgm-eq51-eq52-third-party-crosscheck.md` §E1/E2, which read the
l = 1, s̄ = 2 term's "v̌ + 1/2" as independent support for a half-integer shift of the type
derived in the paper's §4. It is not: it is one term of a finite average whose only function
is to project onto r²|(Q²/2) and r|(Q·P). BSS themselves say so in the sentence just quoted,
and they then *carry out* the projection — see F4d.

### F4d — BSS's own reduced form (p. 4, eq (7)), the decisive item

- **(7)**: d(Q,P) = (−1)^{Q·P+1} Σ_{s|r} g(s) s³ ∫_{iM₁−1/2}^{iM₁+1/2} dρ̌
  ∫_{iM₂−1/(2s²)}^{iM₂+1/(2s²)} dσ̌ ∫_{iM₃−1/(2s)}^{iM₃+1/(2s)} dv̌
  e^{−iπ(σ̌Q² + ρ̌P² + 2v̌Q·P)} Φ₁₀(ρ̌, s²σ̌, s v̌)^{−1}

introduced verbatim by: "Substituting (4) into (3), extending the ranges of σ̌ and v̌ integral
with the help of the sums over k and l, and using the periodicity of Φ₁₀ under integer shifts
of its arguments we can get a simpler expression for the index".

**No shift survives.** BSS's reduced formula is, slot for slot, DGM's (3.26)+(3.27) — the
Q²-slot scaled by s², the elliptic slot scaled by s, no additive shift, and a single global
sign (−1)^{Q·P+1}. See §4 of `proof.md` for the sign consequence.

### F4e — BSS are explicitly frame-aware (p. 4)

- **(8)**: Φ̌ is invariant under [[ρ̌',v̌'],[v̌',σ̌']] = [[d,b],[c,a]] [[ρ̌,v̌],[v̌,σ̌]] [[d,c],[b,a]]
  for a,c,d ∈ ℤ, **b ∈ rℤ**, ad − bc = 1, introduced by: "The set of dyons considered above
  contains only a subset of dyons of torsion r. This subset is known to be invariant under a
  **Γ⁰(r)** subgroup of the S-duality group [22]."
- verbatim, immediately after: "On the other hand a general S-duality transformation matrix
  [[a,b],[c,d]] outside Γ⁰(r) **will take us to dyons of torsion r outside the set 𝓑** [22].
  Thus with the help of these S-duality transformations on Φ̌ we can determine the partition
  function for other sets of torsion r dyons lying outside the set 𝓑 considered above."
- **(9)**: (Q,P) = (aQ' + bP', cQ' + dP'), [[a,b],[c,d]] ∈ SL(2,ℤ)
- **(10)**: Φ̌'(ρ̌',σ̌',v̌') = Φ̌(ρ̌,σ̌,v̌) for the same matrix conjugation as (8).

**BSS therefore assign a *different* partition function Φ̌' to each Γ⁰(r)-coset of frames,
and give the transformation rule relating them.** They never assert that the Fourier
coefficient of a single Φ̌ at (Q²/2,P²/2,Q·P) is the index of every torsion-r dyon with those
invariants. This is classification **(乙)**, and it is (乙) by explicit construction, not by
accident.

---

## 3. Banerjee–Sen–Srivastava, arXiv:0802.0544 — the three orbits, stated in 2008

Title page (L1, p. 1): S. Banerjee, A. Sen, Y. K. Srivastava, **"Generalities of Quarter BPS
Dyon Partition Function and Dyons of Torsion Two"**, arXiv:0802.0544v2 [hep-th], 12 Feb 2008,
Harish-Chandra Research Institute. Abstract, verbatim in part: "We use our analysis to
constrain the dyon partition function for two hitherto unknown cases – the partition function
of dyons of torsion two (i.e. gcd(Q ∧ P)=2) in heterotic string theory on T⁶ and …".

### F5 (L1, p. 3, §1, around eq (1.1))

> "In order to define the dyon partition function we first need to identify a suitable
> infinite subset 𝓑 of dyons in the theory with the property that if we have two pairs of
> charges (Q,P) ∈ 𝓑 and (Q',P') ∈ 𝓑 with Q² = Q'², P² = P'² and Q·P = Q'·P', then they must
> be related by a T-duality transformation. […] d(Q,P) = f(Q²,P²,Q·P).  (1.1)
>
> **Note that for (1.1) to hold it is necessary to choose 𝓑 in the way we have described. In
> particular if 𝓑 had contained two elements with same Q², P² and Q·P but not related by a
> T-duality transformation, then d(Q,P) can be different for these two elements and (1.1)
> will not hold.**"

This is the caveat of the paper's Remark 6.3 / (P'_ad), stated in the source literature in
February 2008, in the same words modulo notation. The honest reading is that the paper's
Remark 6.3 supplies an explicit *integer* witness for a phenomenon that BSS had already
flagged as a logical possibility and guarded against by construction — and, as F5c now
shows, had also asserted **as a fact** for r = 2.

### F5b (L1, p. 35, §6.3) — **the decisive sentence: three T-duality orbits at fixed (Q²,P²,Q·P)**

§6.3 fixes the family 𝒜 of charge vectors (6.3.1) with Q, P as explicit integer 4-vectors,
computes (6.3.2) Q² = 4(m+1), P² = 4(K−J), Q·P = 2(K+J−m+1), notes gcd{Q_iP_j − Q_jP_i} = 2,
and then says, **verbatim**:

> "It was shown in [42][20] that for r = 2 **there are three T-duality orbits for given
> (Q², P², Q·P)** – in the first Q is twice a primitive lattice vector, in the second P is
> twice a primitive lattice vector, and in the third both Q and P are primitive but Q ± P
> are twice primitive lattice vectors. The dyon charges given in (6.3.1) are clearly of the
> third kind. In the notation of [20] the discrete T-duality invariants of these charges are
> (r₁ = 1, r₂ = 1, r₃ = 2, u₁ = 1)."

with (L1, p. 61 and p. 63 of the same PDF) **[20] = S. Banerjee, A. Sen, "S-duality Action on
Discrete T-duality Invariants," arXiv:0801.0149** and **[42] = S. Banerjee, A. Sen, "Duality
Orbits, Dyon Spectrum and Gauge Theory Limit of Heterotic String Theory on T⁶,"
arXiv:0712.0043**. (This also settles F6c at L1: the title "Duality Orbits …" belongs to
0712.0043, not to 0801.0149.)

**This is the whole question, answered in the source literature.** At torsion 2 the triple
(Q²,P²,Q·P) does *not* determine the T-duality orbit; there are three, and they are
distinguished exactly by *which* of Q, P, or Q ± P is the non-primitive one — i.e. by
**Q-adapted / P-adapted / neither**. Any formula asserting that the index is a function of
(Q²/2, P²/2, Q·P, I) alone is therefore, at r = 2, asserting that these three orbits carry
equal indices — a statement that nothing in DGM or AN establishes, and that F5d shows BSS
believed to be false.

### F5c (L1, pp. 48–49, §7) — BSS's torsion-two partition function is **not** a divisor sum

§7 is titled "A proposal for the partition function of dyons of torsion two" and opens
(verbatim, p. 48):

> "In this section we shall consider the set of dyons described in §6.3, carrying charge
> vectors (Q,P) with torsion 2, **Q, P primitive** and Q²/2, P²/2 even, and propose a form of
> the partition function that satisfies all the constraints derived in §6.3."

- **(7.1)** (pp. 48–49): 1/Φ̌(ρ̌,σ̌,v̌) = (1/16)[ 16 terms 1/Φ₁₀(ρ̌+b₁, σ̌+b₂, v̌+b₃) with
  (b₁,b₂,b₃) running over a set of 0, ½, ¼, ¾ shifts ] + [ 1/Φ₁₀(ρ̌+σ̌+2v̌, ρ̌+σ̌−2v̌, σ̌−ρ̌)
  + 1/Φ₁₀(ρ̌+σ̌+2v̌+½, ρ̌+σ̌−2v̌+½, σ̌−ρ̌+½) ].
- **(7.2)**: d(Q,P) = ¼(−1)^{Q·P+1} ∫_𝒞 dρ̌_s dσ̌_s dv̌_s e^{−iπ/4(σ̌_s Q² + ρ̌_s P² + 2v̌_s Q·P)}
  /Φ̌(ρ̌,σ̌,v̌), with (ρ̌_s,σ̌_s,v̌_s) ≡ (4ρ̌,4σ̌,4v̌). **⇒ σ̌ again carries Q²/2**, consistent
  with 0802.1556 eq (1); see the table in §0.
- verbatim after (7.3), p. 49: "Note that the sixteen terms inside the first square bracket
  in (7.1) together gives the partition function of dyons of unit torsion subject to the
  constraint that Q²/2, P²/2, Q·P are even and Q² + P² − 2Q·P is a multiple of 8. **The
  second term is new and reflects the effect of considering states with torsion two.**"

**No term of (7.1) has the shape 1/Φ₁₀(ρ̌, s²σ̌, sv̌).** The torsion-2 content sits in the
second bracket, which is a *linear* change of variables (ρ̌+σ̌±2v̌, σ̌−ρ̌), not a divisor
rescaling. So BSS's formula for this orbit is structurally unrelated to the divisor sum:
the divisor sum is simply not the right object on the both-primitive orbit.

### F5d (L1, p. 10 eq (1.23) and p. 11 top) — BSS give **three different** partition functions, one per orbit

Correction to my own earlier note and to `dgm-eq51-eq52-third-party-crosscheck.md` §E1:
**(1.23) is a genuine compiled equation number**, living in the introduction §1 (p. 10), not
an ar5iv artifact. p. 55 verbatim: "Since (7.1) and (7.32) contains information about all the
torsion two dyons with primitive (Q,P), the full partition function for such dyons is
obtained by taking the sum of these two functions. This gives the result quoted in (1.23)."

- **(1.23)** (p. 10) = (1/8)[8 terms 1/Φ₁₀(ρ̌+b₁,σ̌+b₂,v̌+b₃), shifts in {0,½,¼,¾}]
  + 2/Φ₁₀(ρ̌+σ̌+2v̌, ρ̌+σ̌−2v̌, σ̌−ρ̌), introduced verbatim by: "The formula for the partition
  function when **Q and P are both primitive but (Q ± P) are twice primitive vectors** is".
- verbatim, p. 11, immediately after (1.25):

  > "**There are two more classes of dyons of torsion two, – one where Q is primitive and P is
  > twice a primitive vector and the other where P is primitive and Q is twice a primitive
  > vector. The partition functions for these dyons can be recovered from the one given above
  > by S-duality transformations (Q,P) → (Q, P−Q) and (Q,P) → (Q−P, P) respectively [20].
  > This amount to making replacements (ρ̌,σ̌,v̌) → (ρ̌, σ̌+ρ̌+2v̌, v̌+ρ̌) and
  > (ρ̌,σ̌,v̌) → (ρ̌+σ̌+2v̌, σ̌, v̌+σ̌) respectively in eq.(1.23).**"

**Read this carefully.** BSS assert that the three torsion-2 orbits have **three different
partition functions**, related by *substitutions of the chemical potentials* — and a
substitution of the chemical potentials is exactly a relabelling of which (Q²/2, P²/2, Q·P)
each Fourier coefficient sits at. Two dyons in different orbits with the *same*
(Q²/2, P²/2, Q·P) therefore read off coefficients of *different* functions at the same point,
and BSS nowhere claim those coefficients agree.

Note also the direction: (1.23) is the both-primitive orbit; (ρ̌,σ̌,v̌) → (ρ̌+σ̌+2v̌, σ̌, v̌+σ̌)
gives the orbit with **Q twice primitive** (Q-adapted, DGM's), and
(ρ̌,σ̌,v̌) → (ρ̌, σ̌+ρ̌+2v̌, v̌+ρ̌) gives the orbit with **P twice primitive** (P-adapted). The
two substitutions are exchanged by ρ̌ ↔ σ̌, i.e. by Q ↔ P — which is precisely the reflection
relating D_I and D'_I in `proof.md` Theorem A.

---

## 4. Banerjee–Sen, arXiv:0801.0149 — the structural prior art

### F6 (L1, p. 1, abstract, verbatim)

> "In heterotic string theory compactified on T⁶, the T-duality orbits of dyons of charge
> (Q,P) are characterized by O(6,22;ℝ) invariants Q², P² and Q·P together with a set of
> invariants of the discrete T-duality group O(6,22;ℤ). We study the action of S-duality
> group on the discrete T-duality invariants and study its consequence for the dyon
> degeneracy formula. In particular we find that **for dyons with torsion r, the degeneracy
> formula, expressed as a function of Q², P² and Q·P, is required to be manifestly invariant
> under only a subgroup of the S-duality group. This subgroup is isomorphic to Γ⁰(r).** Our
> analysis also shows that for a given torsion r, all other discrete T-duality invariants are
> characterized by the elements of the coset SL(2,ℤ)/Γ⁰(r)."

### F6b (L1, pp. 2–3, eqs (2), (3), (11), (12))

- **(2)**: Q = r₁e₁, P = r₂(u₁e₁ + r₃e₂) — same normal form as DGM (2.4).
- **(3)**: the S-duality action is Q → aQ + bP, P → cQ + dP.
- **(11)**–**(12)**: an explicit SL(2,ℤ) element brings any (r₁,r₂,r₃,u₁) to
  Q' = r₁r₂r₃ e₁', P' = e₁' + e₂', i.e. (r₁',r₂',r₃',u₁') = (r₁r₂r₃,1,1,1).
  Since r = r₁r₂r₃, this is again **Q' ∈ rΛ: a Q-adapted frame.**

**Note on the congruence subgroup.** With the action (3), the condition "Q ∈ rΛ is preserved"
is b ≡ 0 (mod r), i.e. **Γ⁰(r)**, in agreement with DGM (F3), BSS (F4e) and AN (2.16). The
paper's §2 and §7 remark 1 say "Γ₀(I)" in three places and attribute "Γ₀(I)" to AN (2.16);
AN (2.16) literally reads Γ⁰(I) = {[[a,b],[c,d]] ∈ SL(2,ℤ) : b = 0 mod I} (L1, see F7c).
This is a naming slip in the paper, not a mathematical error in its theorems.

### F6c — bibliography defect in `paper.md`

`paper.md` reference `[banerjee-sen-2008]` reads

> S. Banerjee, A. Sen, "Duality Orbits, Dyon Spectrum and Gauge Theory Limit of Heterotic
> String Theory on T^6," arXiv:0801.0149, JHEP 03 (2008) 022.

The title, arXiv number and journal reference belong to **two different papers**:
- "Duality orbits, dyon spectrum and gauge theory limit …", JHEP 03 (2008) 022 = **arXiv:0712.0043**;
- "S-duality Action on Discrete T-duality Invariants", JHEP 04 (2008) 012 = **arXiv:0801.0149**.
(Both L1 from AN's reference list, entries [21] and [22], cross-checked against the title page
of 0801.0149 which I read directly.) The statement the paper attributes to it in §9 — Γ⁰(r)
acting on the invariants — is the abstract of **0801.0149**, so the arXiv number is the right
one and the title/journal line is the wrong one.

---

## 5. Alexandrov–Nampuri, arXiv:2009.01172 — the actual P-rescaling formula

### F7a (L1, p. 5, eq (2.6)) — the charge dictionary, decisive

> n = ½Q² = ½ Q_I η^{IJ} Q_J,  m = ½P² = ½ P_I η^{IJ} P_J,  ℓ = Q·P,  Δ = 4mn − ℓ².  (2.6)

⇒ in AN, **n is the electric invariant Q²/2 and m is the magnetic invariant P²/2** (the
DMZ convention; the opposite of DGM's letters).

Also (2.7): I(γ) = gcd{Q_I P_J − Q_J P_I} — the same torsion.

### F7b (L1, p. 6, eqs (2.11)–(2.13))

- **(2.11)**: Z_I^{(4|4)}(τ,z,σ) = Σ_{n,m,ℓ} (−1)^ℓ Ω_I^{(4|4)}(n,m,ℓ) q^n y^ℓ p^m,
  y = e^{2πiz}, p = e^{2πiσ}, q = e^{2πiτ}.
- **(2.12)**: Z_1^{(4|4)}(τ,z,σ) = 1/Φ₁₀(τ,z,σ).
- **(2.13)**: Ω_I^{(4|4)}(n,m,ℓ) = Σ_{d|I} d · Ω_1^{(4|4)}(n, m/d², ℓ/d),
  introduced verbatim by: "The degeneracies of ¼-BPS states with I > 1 have been found in
  **[26]** and can be expressed through those with I = 1 determined by (2.12),"
  with **[26] = A. Dabholkar, J. Gomes, S. Murthy, "Counting all dyons in N=4 string theory,"
  0803.2692** (L1, AN reference list p. 30).

**⇒ AN (2.13) divides m = P²/2 by d². It is the P-rescaling formula, and it is explicitly
attributed to DGM (3.28), which divides Q²/2 by s².** The two published formulae are the
Q↔P transpose of one another. See `proof.md` Theorem 3 for the exact integer witness that
they are inequivalent as statements about (Q²/2, P²/2, Q·P, I).

### F7c (L1, p. 7, eq (2.16))

> Γ⁰(I) = { [[a,b],[c,d]] ∈ SL(2,ℤ) : b = 0 mod I }.  (2.16)

with the surrounding text: "Note that if we considered the generating function Z_I^{(4|4)}
with I > 1 and performed a similar expansion, due to (2.13) the corresponding coefficients
would be Jacobi forms only with respect to a congruence subgroup Γ⁰(I) ⊂ SL(2,ℤ) [26]".

Here SL(2,ℤ) acts on τ, AN's **electric** variable. The stabiliser of the *Q*-adapted
condition under Q → aQ + bP is b ≡ 0 (mod r) = Γ⁰(r); the stabiliser of the *P*-adapted
condition is c ≡ 0 (mod r) = Γ₀(r). AN pair a P-rescaling divisor sum (2.13) with the
Q-adapted congruence subgroup Γ⁰(I) (2.16). That combination is internally inconsistent, and
is the clearest evidence that (2.13) is a transcription of DGM (3.28) in which the rescaled
slot was matched by *position in the letter triple* rather than by *which charge it carries*.

### F7d — consequence for `paper.md` §4

`paper.md` §4 builds its "variable dictionary" ρ ↔ σ_AN, v ↔ z_AN, σ ↔ τ_AN by asking which
AN variable carries the s² factor. That identification of *slots* is correct. But the paper's
ρ carries Q²/2 (its §2) while AN's σ carries P²/2 (F7a), so the dictionary silently identifies
the electric with the magnetic invariant. The consequences are analysed in `proof.md` §5:
Theorem 4.1 of the paper survives as an identity about Φ₁₀, but the sentence "This differs
from DGM equation (51) precisely by the half-integer shift" compares two formulae that live
on different charge slots, and the claim that AN's framework *corrects DGM* does not follow
from AN alone.
