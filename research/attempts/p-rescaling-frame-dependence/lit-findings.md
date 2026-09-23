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

### F3b (L1, pp. 17–19 of the PDF = printed pp. 16–18, §4.1) — **the decisive finding of this attempt**

DGM do not merely restrict to the (I,1,1,1) frame in §2; in §4.1 they **prove the Γ⁰(I)
invariance and state outright that their partition function is not SL(2,ℤ)-invariant**.
Verbatim, printed p. 18:

> "This defines the embedding of the physical duality group into the Sp(2,ℤ). **The partition
> function 𝒵_I is however not invariant under the full SL(2,ℤ) but only under a congruence
> subgroup Γ⁰(I) defined by matrices**
>
>   h = (a b; c d) ∈ SL(2,ℤ)   b = 0 mod I .   (4.5)
>
> To see the invariance of the partition function under this subgroup, we consider the
> transformation properties under each of the terms (3.27) under h. Note that
>
>   (s²ρ′ sv′; sv′ σ′) = (d −sc; −b/s a)(s²ρ sv; sv σ)(d −b/s; −sc a)   (4.6)
>
> Using the fact that b = 0 mod (I) and using the modular properties of Φ₁₀(ρ,σ,v) under
> Sp(2,ℤ), it is easy to see that Φ₁₀(s²ρ′,σ′,sv′) = Φ₁₀(s²ρ,σ,sv).  (4.7)"

and, continuing on the same page and the next (printed pp. 18–19):

> "We therefore see that the degeneracy defined by (3.26) is manifestly invariant under
> Γ⁰(I). The complete spectrum of dyons should of course be invariant under the full SL(2,ℤ)
> which is the physical duality group. To exhibit this duality invariance we proceed as
> follows. Consider the coset
>
>   SL(2,ℤ)/Γ⁰(I) ≡ {g₀, g₁, … g_k},   (4.12)
>
> where k is the order of Γ⁰(I) in SL(2,ℤ) and g₀ is the identity element. **The function 𝒵_I
> is not invariant under the full SL(2,ℤ). Under the action of an element g_l it will
> transform to a new function which we denote by 𝒵_I^{(l)}** with the convention that
> 𝒵_I^{(0)} = 𝒵_I. The charge vector Γ of the dyon will also transform under this element to
> a new charge vector Γ^{(l)}. The invariants of this transformed charge vector will no longer
> be of the form (r₁,r₂,r₃,u₁) = (I,1,1,1). **However, the degeneracy of these dyons Γ^{(l)}
> can be defined simply by using the transformed partition function 𝒵_I^{(l)}.** With these
> definitions, the resulting spectrum is thus manifestly duality invariant under the full
> duality group SL(2,ℤ)."

**Consequences — these narrow this project's claim and must be reported, not resisted.**

1. DGM's (4.6) is, term by term, the matrix identity that `proof.md` Theorem C proves:
   the *s*-th summand is carried to the *s*-th summand by the integral matrix
   (d, −b/s; −sc, a), which is integral **iff s | b**. My Theorem C is therefore
   **not new mathematics**; it is DGM (4.5)–(4.7) restated on the charge side. What is new
   here is only (i) the exact-integer *measurement* of how much the value moves between
   cosets, and (ii) the transfer of the statement to the P-rescaling operator.
2. **DGM state explicitly that their formula is attached to the (I,1,1,1) frame and that a
   different function 𝒵_I^{(l)} must be used on the other SL(2,ℤ)/Γ⁰(I) cosets.** So the
   "frame dependence" of the divisor sum is *the content of DGM §4.1*, not a defect DGM
   overlooked. What (3.28) does, and all it does, is drop that hypothesis from the notation
   by writing the left side as a function of (Q²/2, P²/2, Q·P) alone.
3. Hence for the 甲/乙/丙 classification, **DGM itself is (乙)**: the formula is stated —
   in the same paper, two pages later — only on the adapted orbit, with the non-adapted
   orbits handled by a different function. Any claim that DGM's result is *wrong* because of
   frame dependence does not survive reading §4.1.

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

Here SL(2,ℤ) acts on τ, AN's **electric** variable. On the charge side (see `proof.md`
Theorem C) the stabiliser of the *Q*-adapted condition under (Q,P) ↦ (aQ+bP, cQ+dP) is
b ≡ 0 (mod I) = Γ⁰(I); the stabiliser of the *P*-adapted condition is c ≡ 0 (mod I) = Γ₀(I).
AN pair a P-rescaling divisor sum (2.13) with the label Γ⁰(I) (2.16), taken over from [26].

**How far this goes — stated carefully.** DGM's Γ⁰(I) (their (4.5), F3b below) is a
statement about the charge-space action (4.1) (Q,P) ↦ h(Q,P), and DGM's divisor sum divides
Q²/2, so for DGM Γ⁰(I) = {b ≡ 0} is the *correct* group. AN's divisor sum divides P²/2, so
the corresponding charge-space stabiliser is Γ₀(I) = {c ≡ 0}. If (2.16)'s SL(2,ℤ) is meant
to be the same charge-space S-duality as DGM's (4.1), then (2.13)+(2.16) are mutually
inconsistent. If instead (2.16)'s SL(2,ℤ) is the Jacobi-modular group acting on (τ,z) at
fixed index — which is the group under which "the coefficients are Jacobi forms" is the
natural phrasing — then it is not the same group as (4.1) and no comparison of Γ⁰ with Γ₀
is meaningful without redoing the Sp(4,ℤ) embedding.
**[GAP: which SL(2,ℤ) AN mean in (2.16) is not determined by the text I have read.]**
What is certain and frame-independent is F7b: (2.13) divides the magnetic slot and (3.28)
divides the electric one, so the two are different statements about charges; `proof.md`
Theorem D exhibits an (m,n,ℓ,I) at which they give different integers.

### F7d — consequence for `paper.md` §4

`paper.md` §4 builds its "variable dictionary" ρ ↔ σ_AN, v ↔ z_AN, σ ↔ τ_AN by asking which
AN variable carries the s² factor. That identification of *slots* is correct. But the paper's
ρ carries Q²/2 (its §2) while AN's σ carries P²/2 (F7a), so the dictionary silently identifies
the electric with the magnetic invariant. The consequences are analysed in `proof.md` §5:
Theorem 4.1 of the paper survives as an identity about Φ₁₀, but the sentence "This differs
from DGM equation (51) precisely by the half-integer shift" compares two formulae that live
on different charge slots, and the claim that AN's framework *corrects DGM* does not follow
from AN alone.

---

## 6. The P-rescaling family is larger than AN, and its second member gets it right

### F8 (L1, arXiv:1806.03330 p. 64, eqs (5.79)–(5.81))

Bossard–Cosnier-Horeau–Pioline, *Exact effective interactions and 1/4-BPS dyons in heterotic
CHL orbifolds*, SciPost. Verbatim:

> "For example in the maximal rank case, all primitive charges (Q,P) are in the U-duality
> orbit of a charge of the form **[71]**
>
>   Q = e₁ + q e₂ ,   P = p e₂ ,   Q ∧ P = p e₁ ∧ e₂ ,   (5.79)
>
> with e₁ and e₂ primitive in Λ_{22,6}. **The integer p is sometimes known as the 'torsion'.**
> In that case (5.74) simplifies to
>
>   C̄(Q,P;Ω⋆₂) = Σ_{d≥1, d|p} d · C[ ( Q²      QP/d  ) , (1 0; 0 d) Ω⋆₂ (1 0; 0 d) ] ,  (5.80)
>                                     ( QP/d    P²/d² )
>
> in agreement with the prescription in **[41, 72]**, with additional fineprint on the contour
> of integration."

Reference resolution (L1, BCP bibliography pp. 151, 153): **[71] = Banerjee–Sen 0801.0149**,
**[41] = BSS 0802.1556**, **[72] = DGM 0803.2692**.

Three things follow, and they are the cleanest data points in this file.

1. **(5.80) is a P-rescaling divisor sum.** The Gram argument is (Q², QP/d; QP/d, P²/d²):
   it is **P² that is divided by d²**. In the (m,n,ℓ) = (Q²/2, P²/2, Q·P) notation of
   `claim.md` this is exactly D′_I. So the P-rescaling family has at least two members:
   AN (2.13) and BCP (5.80)–(5.81).
2. **BCP state it on an explicitly P-adapted frame.** (5.79) has P = p e₂ ∈ pΛ with torsion
   p, so P ∈ IΛ by construction; the formula is never applied to a bare triple (m,n,ℓ,I).
   Compare DGM, whose (I,1,1,1) normal form has Q = I e₁ ∈ IΛ. Both papers pick the adapted
   frame for the charge *they* divide; they pick *opposite* charges, and each is right in
   its own frame.
3. **BCP also carry the contour.** The second argument of C is Ω⋆₂ ↦ diag(1,d) Ω⋆₂ diag(1,d),
   i.e. the attractor contour is transformed along with the Gram matrix. The bare operators
   D_I, D′_I drop this; Theorem 5.2 of the project paper is the statement that dropping it is
   legitimate on the attractor contour, and BCP's own "with additional fineprint on the
   contour of integration" is an acknowledgement of the same point.

BCP's sentence "in agreement with the prescription in [41, 72]" is, read through `proof.md`
Theorem A (D′_I(m,n,ℓ) = D_I(n,m,ℓ)), **correct**: their P-rescaling statement on a P-adapted
frame and DGM's Q-rescaling statement on a Q-adapted frame are the same statement, conjugated
by the S-duality element (Q,P) ↦ (P,−Q). Theorem A is the precise form of that agreement.

### F9 (L1, arXiv:2007.10302 pp. 19, 30, §3.7 and App. A) — Cardoso–Nampuri–Rosselló

*Arithmetic of decay walls through continued fractions*. Their letters are **m = ½Q_m²
(magnetic), n = ½Q_e² (electric)** (their (A.7), L1 p. 30), so their divisor sum divides the
**electric** slot: it is the same physical statement as DGM. Verbatim, p. 19:

> "**3.7 Decadent dyons with torsion I > 1.** The extension of our solution to the dyon
> counting problem for I ≠ 1 in heterotic string theory on T⁶ is quite straightforward. We
> again restrict to 0 ≤ ℓ ≤ m with m > 0. The dyonic degeneracy, d_I(m,n,ℓ) for general I is
> expressed in terms **[17, 18]** of the dyonic degeneracy of states d(m,n,ℓ) for I = 1 as
>
>   d_I(m,n,ℓ) = Σ_{t|I} t d(m, n/t², ℓ/t) .   (3.40)
>
> Each summand in (3.40) is computed by (2.19) via the continued fraction approach to
> generating decay walls. However, note that only those decay walls contribute to (2.19) that
> correspond to n_γ, ℓ_γ t = 0 mod t². This condition implies that the dyonic walls correspond
> to a subset of the PSL(2,ℤ) group, which as we show in the appendix, is the subgroup
>
>   Γ⁰(t) = { (a b; c d) ∈ PSL(2,ℤ) | b = 0 mod t } .   (3.41)
>
> Hence, choosing only Γ⁰(t) matrices from the continued fraction algorithm, we can perform an
> exact computation of d_I, using (3.40)."

([17] = BSS 0802.1556, [18] = DGM 0803.2692, L1 p. 33.) And Appendix A, p. 30, verbatim:

> "Next, we consider decadent dyons (m,n,ℓ) in the N = 1 CHL model with arbitrary torsion I.
> This requires the charge bilinears to be quantized according to
>
>   m ∈ ℤ ,  n ∈ t²ℤ ,  ℓ ∈ tℤ ,   (A.9)
>
> with t|I. … Under a transformation γ ∈ SL(2,ℤ), (m,n,ℓ) transform as
>
>   m_γ = mp² − ℓpr + nr² ,  n_γ = mq² − ℓqs + ns² ,  ℓ_γ = −2mpq − 2nrs + ℓ(ps+qr) .  (A.11)
>
> **Demanding m_γ ∈ ℤ, n_γ ∈ t²ℤ, ℓ_γ ∈ tℤ implies that q is a multiple of t, and hence γ lies
> in the subgroup Γ⁰(t) ⊂ PSL(2,ℤ).**"

This is the *same computation* as `proof.md` Theorem C and DGM (4.6): the transformed divided
slot is n_γ = q²m − qsℓ + s²n, and integrality of n_γ/t² forces t | q. (Their γ = (p q; r s)
is my U conjugated by the swap J, γ ↦ JγᵀJ, which fixes the upper-right entry — so their
"q ≡ 0 mod t" and my "b ≡ 0 mod I" are the same condition and both groups are Γ⁰ in the
standard labelling. This cross-check matters: the ρ/σ/v trap has a group-theoretic twin.)

**Classification.** CNR know the Γ⁰(t) condition and use it — but they use it to restrict the
**decay-wall matrices** summed over inside a *fixed* frame, not to restrict the frame in which
(m,n,ℓ) is presented. Their §3.7 conclusion ("We have thus solved the decadent dyon counting
problem for all negative and zero discriminant 1/4-BPS states in N = 4 heterotic string theory
on T⁶", p. 19) is asserted for d_I(m,n,ℓ) on the arithmetic hypothesis (A.9) alone. By
`proof.md` Theorems B and C that hypothesis is not sufficient to pin the value; an adaptedness
(equivalently, a Γ⁰(I)-coset) hypothesis has to be added. This is a **hypothesis-tightening,
not an arithmetic error**: on Q-adapted frames their numbers are what DGM's formula gives.

### F10 (L1, arXiv:2403.19630 p. 7, eqs (2.1)–(2.3))

*The Immortal Dyon Index Is Positive*. Verbatim:

> "A state with unit torsion, I = 1, is completely specified by the charge bilinears Q⃗², P⃗²,
> Q⃗·P⃗ [51]. **From now on we focus on this class of states, since the degeneracies of dyons
> with torsion greater than one are related to the degeneracies of unit torsion dyons
> [52–54].**"

and (2.3): m = P⃗²/2, n = Q⃗²/2, ℓ = Q⃗·P⃗ (the AN/DMZ letter assignment). The torsion
divisor sum is **never written down** and nothing is deduced from it; it is cited only as the
reason for restricting to I = 1. → **(丙)**.

### F11 (triage level — my own text extraction of the arXiv PDFs, **not** page images)

Triaged from the 98 INSPIRE records citing DGM 0803.2692 by searching the full text for
"torsion"; only the papers below mention it at all outside a bibliography.

- **arXiv:0804.0651** (Sen, *U-duality Invariant Dyon Spectrum in type II on T⁶*), p. 5:
  "A formula for the index B₁₄ for unit torsion dyons has been written down in [7,8,4], but
  since the charge vector (9) has torsion Q₅, **we cannot use the results of [7,8,4] directly.
  We shall now show however that by a suitable U-duality transformation we can map the charge
  vector (9) to another charge vector of unit torsion**, and then use the result of [4]."
  → no divisor sum is used at all; the torsion is removed by an explicit duality map. **(乙)**,
  and methodologically the safest treatment in the survey.
- **arXiv:1912.06562**, p. 9 footnote 2: "Here and in the following, we refer to dyons with
  torsion 1, i.e. gcd{Q_iP_j − Q_jP_i} = 1. A similar story for generic dyons [25,26] should
  follow along the same lines." → **(丙)**.
- **arXiv:1702.05095** (*No More Walls!*), p. 55: "Throughout this paper, we have focused on
  'torsion-free' dyons, i.e. dyons with the discrete T-duality invariant I ≡ gcd(Q∧P) = 1. In
  several cases, dyons with more general I have been counted [18,49,50] … **It would be
  interesting to find the counting functions for all I for our CHL models**." → **(丙)**,
  explicitly out of scope.
- **arXiv:2005.07712** (Fischbach–Klemm–Nega): unit torsion throughout; the only mention of
  I > 1 is footnote 12 on p. 5 ("in [44] these constraints were also used to propose the
  correct partition function of dyons with torsion greater than one for the unorbifolded
  theory"). → **(丙)**.
- **arXiv:2205.08726** (*Positivity of discrete information for CHL black holes*): the string
  "torsion" does not occur in the document at all. → not in the family.
- **arXiv:1002.3857** (*Discrete Information from CHL Black Holes*): "torsion" occurs only in
  the titles of refs [22],[23] in its bibliography. → not in the family (its "discrete
  information" is the CHL twisted/untwisted residue data, not gcd(Q∧P)).

---

## 7. Answer to Question 3 — the blast radius, classified

Criterion, as set in `claim.md`: **(甲)** a stated conclusion would need restating if the
divisor sum is not a function of (m,n,ℓ,I); **(乙)** the use is on adapted frames (or an
explicitly fixed frame) and is unaffected; **(丙)** the formula is transcribed or cited,
nothing is deduced from it.

| paper | eq. | rescales | used for | class | why |
|---|---|---|---|---|---|
| DGM 0803.2692 | (3.27),(3.28) | **Q** | the paper's main result | **乙** | §2.1 fixes the (I,1,1,1) = Q-adapted frame; §4.1 (4.5)–(4.12) proves only Γ⁰(I)-invariance and supplies a *different* 𝒵_I^{(l)} per coset. F3, F3b. |
| BSS 0802.1556 | (3),(7),(10) | **Q** | torsion-r partition function | **乙** | the set 𝓑 is the adapted set by construction, and (10) gives a different Φ̌′ per Γ⁰(r)-coset. F4d, F4e. |
| BSS 0802.0544 | — | — | three orbits at torsion 2 | **乙** | writes no divisor sum; gives three separate partition functions, one per T-duality orbit. F5b, F5c, F5d. |
| Banerjee–Sen 0801.0149 | (2),(3),(11),(12) | — | S-duality on (r₁,r₂,r₃,u₁) | **乙** | this is the *source* of the correct statement: the stabiliser is Γ⁰(r) and the rest is an SL(2,ℤ)/Γ⁰(r) coset. F6. |
| BCP 1806.03330 | (5.79)–(5.81) | **P** | 1/4-BPS couplings in D = 3 | **乙** | frame written out explicitly, P = p e₂ ∈ pΛ; contour transformed too. F8. |
| Alexandrov–Nampuri 2009.01172 | (2.13), (4.27)–(4.28) | **P** | consistency check of the generalized holomorphic anomaly eq (4.26) | **甲, narrowly** | (2.13) is asserted for Ω_I(n,m,ℓ) with no frame hypothesis and attributed to DGM (3.28), which divides the *other* charge. F7b; see the GAP in F7c. |
| Cardoso–Nampuri–Rosselló 2007.10302 | (2.3), (3.40)–(3.41), (A.9)–(A.11) | **Q** | §3.7's extension of the decadent-dyon count to I > 1 | **甲, narrowly** | d_I(m,n,ℓ) asserted on the arithmetic hypothesis (A.9) alone; an adaptedness/coset hypothesis must be added. Their App. A already contains the needed Γ⁰(t) computation. F9. |
| Sen 0804.0651 | — | — | B₁₄ for a torsion-Q₅ charge | **乙** | maps to unit torsion by an explicit U-duality instead. F11. |
| 1912.06562, 1702.05095, 2005.07712, 2403.19630 | — | — | — | **丙** | restrict to I = 1 and cite the torsion literature only as a reason to do so. F10, F11. |

**Honest summary of the blast radius: it is small, and smaller than the shape of the negative
result suggests.** Of the eight papers that actually write a torsion divisor sum, six state it
on an explicitly adapted or explicitly fixed frame — including DGM itself, which proves the
Γ⁰(I) restriction in its own §4.1. The two (甲) entries are **hypothesis-tightenings of one
sentence each**, not defects in any computed number. The modern positivity literature
(2403.19630, 2205.08726) does not touch the formula at all.

**[GAP: not surveyed.]** The 98 INSPIRE records citing DGM were triaged by full-text search
for the string "torsion" on the nine most likely candidates only; records without an arXiv
eprint, and papers reaching the divisor sum through BSS or Banerjee–Sen rather than DGM, were
not enumerated. A complete survey would also search the citation sets of 0801.0149 (52),
0802.0544 (53) and 0802.1556 (77).
