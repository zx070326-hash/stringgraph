# The torsion dyon divisor sum is not a function of the charge, and positivity survives

**Abstract**

Degeneracies of torsion-I dyons in N=4 string theory on K3×T² are computed in the literature from a divisor sum over s|I, in the form given by Dabholkar–Gomes–Murthy (0803.2692) equation (52). **We show that this expression is not a function of the charge.** One and the same lattice of torsion I=2, presented in two SL(2,ℤ)-related bases each of which satisfies the standard hypotheses, gives

  D_2(4,4,0) = 7999541469408   and   D_2(8,4,8) = 7999235715072.

Since the physical index is S-duality invariant, the usual reading of (52) — as an identity between a single-centered degeneracy and a function of the invariants (m,n,ℓ,I) — cannot hold. The failure is sharply localised rather than diffuse: the individual immortal indices d_* *are* GL(2,ℤ)-invariant (Appendix A), and the entire discrepancy sits in the s=2 term, where the two frames produce index-2 superlattices of the same discriminant lying in *different classes*. The divisor sum therefore reads off the GL(2,ℤ) class of a sublattice of index s, which (m,n,ℓ,I) does not determine. It is invisible whenever every discriminant Δ/s² that occurs admits only a single class of positive definite integral binary quadratic forms, imprimitive ones included — which is the case for every small example tabulated in the literature, and is why the formula has stood unchallenged.

We locate the error that makes the failure visible, and show what survives. (A) DGM equations (51) and (52) are mutually incompatible, with an explicit integer witness at torsion I=2. (B) The unique generating function compatible with (52) and with Alexandrov–Nampuri's coupled equations carries a half-integer elliptic shift (d−1)/2 on even divisors; this resolves the sign discrepancy in (A). (C) Attractor cycle contours are covariant under charge rescaling, so the divisor sum commutes with the immortal projection with no appeal to mock modular decompositions. Replacing the untenable premise by the strictly weaker (P′_ad) — asserted only on *adapted* frames Q ∈ IΛ — and combining (C) with Rosselló's unit-torsion positivity theorem then yields strict positivity of single-centered degeneracies for **all** torsion classes I ≥ 1, on a charge domain that is itself S-duality invariant and strictly larger than the triple domain to which the formula literally applies. The premise is weaker than the one it replaces and the conclusion is stronger.

The mathematical content is elementary and self-contained (Fourier series, linear algebra on symmetric matrices, contour integration); physical interpretation relies on standard BPS state counting assumptions, isolated in a single premise.

## 1. Introduction

The Sen positivity conjecture states that degeneracies of single-centered supersymmetric black holes in four-dimensional N=4 string theory are strictly positive integers. For the flagship case of type II on K3×T², the conjecture was fully resolved for unit torsion (I=1) by Rosselló [rossello-2024], building on the mock modular form framework of Dabholkar–Murthy–Zagier (DMZ) [dmz-2012]. The extension to torsion I>1—where the relevant generating functions involve divisor sums over s|I—requires a physical input: the divisor sum formula itself, for which two incompatible versions appear in the literature (DGM 0803.2692 equations (51) and (52)).

We show that a suitable form of DGM equation (52) yields strict positivity for all torsion classes via a rigorous mathematical proof requiring no mock modular form computations. The technical obstructions we set out to remove were: (i) the incompatibility between equations (51) and (52), and (ii) the lack of a mathematical proof that the divisor sum commutes with the immortal projection to single-centered states.

A third issue, which we did not anticipate and which turns out to be the most consequential of the three, is that **the divisor sum is not a well-defined function of the charge at all** (Theorem 6.3). We give it first billing in the abstract and in the title, and state here why it, rather than the positivity theorem, is what a reader should take from this paper. Positivity for torsion I>1 is the expected continuation of a programme whose I=1 case is settled; it confirms what the field already believes. The frame dependence does not: a quantity that appears throughout the torsion-dyon literature, and that is read there as a function of (m,n,ℓ,I), demonstrably takes two values on one charge. The witness is a pair of explicit integers, reproducible by anyone in a few lines, and the mechanism behind it is completely identified (§6, Theorem 6.3). It is the kind of statement that can be checked and, if wrong, refuted outright — and it is the reason the physical premise of this paper had to be rewritten rather than merely cited.

This paper resolves all three. Our results, in the order of importance we would defend rather than the order in which they are proved:

**Theorem 6.3** (§6): The right-hand side of equation (52), call it D_I(m,n,ℓ) = Σ_{s|I} s·d_*(m/s², n, ℓ/s), is not a function of the charge. One lattice L ⊆ U⊕U of torsion I=2, presented in two SL(2,ℤ)-related bases both of which satisfy I²|m and I|ℓ, has invariants (4,4,0) and (8,4,8) with

D_2(4,4,0) = 7999541469408,  D_2(8,4,8) = 7999235715072.

Two further witnesses are given, one in which the two bases are related by the S-duality generator S itself, and one at I = 3. The individual immortal indices d_* *are* GL(2,ℤ)-invariant (Appendix A); the failure sits entirely in the s = I term, where the two frames produce index-I superlattices of the same discriminant lying in different classes (Proposition 6.1). Since the physical index is S-duality invariant, this rules out the usual reading of (52) as a statement about charges. Proposition 6.5 gives a sufficient condition — one class per relevant discriminant — under which the failure is invisible, which is why it has gone unnoticed.

**Theorem 6.4** (§6): More basically, (m,n,ℓ,I) is not a complete invariant of a torsion-I charge pair at all: two pairs are exhibited with identical (m,n,ℓ,I) and non-isometric saturations. No function of those four integers can recover the lattice.

**Proposition 3.1** (§3): DGM equations (51) and (52) cannot both hold. For even s and odd ℓ/s, the two formulae differ by a sign factor (−1)^{ℓ−ℓ/s} = −1. We provide an explicit integer witness: at I=2, (m,n,ℓ)=(4,1,2), the two readings give 16542306 vs 16440894, differing by 4·d_*(1,1,1) = 101412.

**Theorem 4.1** (§4): The unique generating function compatible with equation (52) and the Alexandrov–Nampuri coupled equations (2.11)+(2.13) is

Z_I^{(4|4)}(τ,z,σ) = Σ_{d|I} d / Φ₁₀(τ, dz + (d-1)/2, d²σ).

For odd divisors d, the shift (d-1)/2 is an integer and cancelled by Φ₁₀'s periodicity; for even divisors, it is a genuine half-integer shift. This resolves the sign discrepancy in Proposition 3.1.

**Theorem 5.2** (§5): Attractor cycle contours transform covariantly under the charge rescaling (ρ,σ,v) ↦ (s²ρ, σ, sv). Specifically, the contour C_*(m,n,ℓ) with imaginary part Im Ω = 2Λ·adj(T(m,n,ℓ)) is mapped precisely to C_*(m/s², n, ℓ/s) with Λ ↦ s²Λ, without crossing any walls or generating multi-centered corrections. This follows from the elementary identity A_s·adj(T)·A_s^T = s²·adj(T'), where T' corresponds to the rescaled charges.

**Theorem 7.1** (§7): For all I≥1 and triples (m,n,ℓ) with I²|m, I|ℓ, m,n≥1, Δ=4mn-ℓ²>0, the torsion-I immortal dyon index satisfies

d_*^{(I)}(m,n,ℓ) = Σ_{s|I} s · d_*(m/s², n, ℓ/s) > 0.

The proof uses only Theorem 5.2 (covariance) and Rosselló's Corollary 1.1 (positivity for I=1 without gcd restrictions), requiring no mock modular form computations.

**Corollary 8.1** (§8): §8 states the physical premise on *adapted* frames only (Q ∈ IΛ), as Theorem 6.3 requires, and derives strict positivity of single-centered degeneracies for every torsion class on a charge domain that is S-duality invariant and strictly larger than the triple domain of Theorem 7.1.

### Outline of the paper

§2 fixes conventions and defines adapted frames. §3 establishes the incompatibility between DGM equations (51) and (52) through explicit computation and symmetry analysis, and notes why the natural small witness cannot see the frame dependence. §4 derives the corrected generating function from first principles using Alexandrov–Nampuri's framework, including an explicit variable dictionary. §5 proves attractor cycle covariance via adjugate matrix transformation laws. §6 — logically independent of §§3–5, and the section a reader short of time should read — identifies what the s-th term of the divisor sum actually computes, exhibits the three frame-dependence witnesses, and proves the criterion under which the phenomenon is invisible. §7 combines §§4–5 to establish positivity on the triple domain. §8 isolates and corrects the remaining physical assumption, and restates positivity over charges. §9 discusses open problems, including the precise correspondence with BKM algebra automorphisms and the status of the mock/immortal equality beyond Gauss-reduced representatives. §10 concludes.

The mathematical techniques are elementary: Fourier series manipulations, change of variables, and linear algebra on symmetric matrices. No deep modular form theory is required beyond citing Rosselló's result as a black box.

## 2. Notation and conventions

We work in N=4 string theory (type II on K3×T²) with standard conventions following [rossello-2024]. The charge vector is (Q,P) with invariants (m,n,ℓ) = (Q²/2, P²/2, Q·P) and torsion I = gcd(Q∧P). The discriminant is Δ = 4mn - ℓ².

**Siegel modular forms.** Let Ω = [[ρ,v],[v,σ]] ∈ ℍ₂ (Siegel upper half-space of degree 2). We write p = e^{2πiρ}, q = e^{2πiσ}, y = e^{2πiv}. The Igusa cusp form Φ₁₀ is the unique (up to scalar) weight-10 cusp form for Sp(4,ℤ), with Fourier–Jacobi expansion

1/Φ₁₀(ρ,σ,v) = Σ_{M≥-1} ψ_M(σ,v) p^M,

where ψ_M is a meromorphic Jacobi form of weight -10 and index M.

**Critical convention (index placement).** Following Rosselló [rossello-2024], we use the Fourier–Jacobi expansion in the p-variable, so the index M is carried by the variable ρ. This differs from DMZ [dmz-2012], who expand in q with index on σ. The two conventions are related by ρ↔σ exchange; formulas must be translated carefully. In this paper, "index m" always refers to the ρ-direction.

**Attractor cycles and immortal indices (I=1).** For charges (m,n,ℓ) with m,n≥1, Δ>0, the attractor cycle C_*(m,n,ℓ;Λ) is defined by

C_* = {Ω ∈ ℍ₂ : Re ρ, Re σ, Re v ∈ [0,1],  Im Ω = 2Λ·adj(T)},

where T = [[m, ℓ/2], [ℓ/2, n]] and adj(T) = [[n, -ℓ/2], [-ℓ/2, m]]. The immortal (single-centered) index is

d_*(m,n,ℓ) = ∫_{C_*} 𝒢(Ω) e^{-2πi(mρ+nσ+ℓv)} dρ dσ dv,

where 𝒢(ρ,σ,v) = -1/Φ₁₀(ρ,σ,v+1/2) (the half-period shift and overall sign are chosen so that 𝒢's Fourier coefficients match d_*). For Λ sufficiently large, the contour avoids all poles and the integral is independent of Λ.

**Torsion I generating functions.** For I≥1, define the rescaling operator 𝒱_s by (𝒱_s F)(ρ,σ,v) = F(s²ρ, σ, sv) and the divisor sum operator 𝒯_I = Σ_{s|I} s·𝒱_s. The torsion-I generating function is

𝒢_I := 𝒯_I 𝒢 = -Σ_{s|I} s/Φ₁₀(s²ρ, σ, sv + 1/2).

The torsion-I immortal index is defined by the same contour integral formula:

d_*^{(I)}(m,n,ℓ) = ∫_{C_*(m,n,ℓ;Λ)} 𝒢_I(Ω) e^{-2πi(mρ+nσ+ℓv)} dρ dσ dv.

**Adapted frames.** A basis of the rank-2 sublattice L = ℤQ + ℤP ⊆ Λ is *adapted* (to the torsion I) if Q ∈ IΛ. Adapted bases exist iff the quotient M/L is cyclic, where M = (L ⊗ ℚ) ∩ Λ is the saturation — in particular whenever Q or P is primitive — and any two of them are related by (Q,P) ↦ (aQ + cP, bQ + dP) with ad − bc = 1 and I | c, i.e. they form a single orbit of the level-I congruence subgroup Γ₀(I) = {I | c} (the S-conjugate of the Γ⁰(I) that appears in the sources, which divide P rather than Q). In an adapted basis the invariants automatically satisfy I²|m and I|ℓ, which is exactly the hypothesis domain of Theorem 7.1. The converse fails: (m,n,ℓ,I) does not determine the GL(2,ℤ) class of L, so "I²|m, I|ℓ" is a statement about a *frame*, not about a charge.

Two structural consequences are worth recording, because they are easy to overlook and both matter below. First, every adapted frame has the shape (Iw, u) with (w,u) a basis of M: from Q = Iw one gets w ∈ M, and ℤw + ℤP already has index I in M, hence equals M. Second, therefore, **for I ≥ 2 the vector Q in an adapted frame is never primitive**. Equation (52) can only be read in a frame in which Q fails to be primitive — which is presumably why treatments that insist on keeping both charge vectors primitive arrive at summation formulae carrying fractional shifts rather than at the shape of (52). See Problem 9.2.

**Physical assumption (isolated).** The identification of d_*^{(I)}(m,n,ℓ) with the physical BPS index of torsion-I dyons, asserted *on adapted frames*, is the physical input (P'_ad); see §8. It rests on duality arguments, 4d-5d lifts, and fermionic zero mode counting [dgm-2008, alexandrov-nampuri-2020]. The frame restriction is not a technicality: the unrestricted version (P') is false, with an explicit integer counterexample given in Theorem 6.3. The mathematical results (Propositions 3.1 and 6.1, Theorems 4.1, 5.2, 6.3, 6.4 and 7.1, Proposition 6.5) do not depend on (P'_ad); they are statements about Φ₁₀, contour integrals, and lattices.

## 3. Incompatibility of DGM equations (51) and (52)

**Setup.** Dabholkar–Gomes–Murthy [dgm-2008] give two formulas relating torsion-I degeneracies to I=1 data. In their notation (translated to ours):

- Equation (50): Ω_I(m,n,ℓ) = (-1)^{ℓ+1} × [Fourier coefficient of 𝒵_I at (m,n,ℓ)]
- Equation (51): 𝒵_I(ρ,σ,v) = Σ_{s|I} s/Φ₁₀(s²ρ, σ, sv)  (no shift)
- Equation (52): Ω_I(m,n,ℓ) = Σ_{s|I} s·Ω₁(m/s², n, ℓ/s)

Here Ω₁(m',n',ℓ') = (-1)^{ℓ'+1}·[coefficient of 1/Φ₁₀ at (m',n',ℓ')] is the I=1 degeneracy.

**Proposition 3.1 (Incompatibility).** Equations (50)+(51) and equation (52) cannot both hold. Specifically, the s-th term in the divisor sum differs by a factor (-1)^{ℓ-ℓ/s}, which equals -1 when s is even and ℓ/s is odd.

*Proof.* From (50)+(51), the Fourier coefficient of 𝒵_I = Σ_{s|I} s/Φ₁₀(s²ρ,σ,sv) at (m,n,ℓ) is

Σ_{s|I, s²|m, s|ℓ} s · [coeff of 1/Φ₁₀ at (m/s², n, ℓ/s)] = Σ_{s|I} s·(-1)^{ℓ/s+1}·Ω₁(m/s², n, ℓ/s).

(The change of variables in the Fourier series is elementary: p^m q^n y^ℓ under (ρ,σ,v)↦(s²ρ,σ,sv) becomes (p^{s²})^{m/s²} q^n (y^s)^{ℓ/s}.)

Applying (50) gives Ω_I = (-1)^{ℓ+1} × [above] = Σ_{s|I} s·(-1)^{ℓ+ℓ/s}·Ω₁(m/s²,n,ℓ/s).

But (-1)^{ℓ+ℓ/s} = (-1)^{ℓ-ℓ/s} (since ℓ = s·(ℓ/s) makes (-1)^{2ℓ/s} = 1). This differs from (52) by the factor (-1)^{ℓ-ℓ/s} in each term. When s is odd, ℓ ≡ ℓ/s (mod 2), so the factor is +1. When s is even and ℓ/s is odd, ℓ is even but ℓ-ℓ/s is odd, giving factor -1. ∎

**Explicit witness.** Take I=2, (m,n,ℓ) = (4,1,2). Then I²|m, I|ℓ, Δ=12>0. The divisor sum has two terms (s=1,2):

- s=1: Both readings give 1·Ω₁(4,1,2) = d_*(4,1,2) = 16491600.
- s=2: ℓ/s = 1 (odd), so (-1)^{ℓ-ℓ/s} = (-1)^{2-1} = -1.
  - Equation (52): 2·Ω₁(1,1,1) = 2·d_*(1,1,1) = 2×25353 = 50706.
  - Equation (50)+(51): 2·(-1)^{2-1}·Ω₁(1,1,1) = -50706.

Total: (52) gives 16491600 + 50706 = 16542306; (50)+(51) gives 16491600 - 50706 = 16440894.
Difference: 101412 = 4·d_*(1,1,1).

The numerical values are computed using scripts that implement the Fourier–Jacobi expansion of 1/Φ₁₀ with exact integer arithmetic (bundled as ancillary files; see the note at the end of §6). The implementation was calibrated against five charge points at which the total index coincides with the immortal index, so that they do test d_* itself:

  d_*(1,1,0) = 50064,  d_*(2,2,0) = 32861184,  d_*(3,2,0) = 632078672,
  d_*(4,2,0) = 9337042944,  d_*(5,2,0) = 113477152800,

corresponding to (Q²,P²) = (2,2), (4,4), (6,4), (8,4), (10,4) with Q·P = 0, together with d_*(1,1,1) = 25353 and d_*(4,1,2) = 16491600 used above. These values are the ones that circulate in the literature on 1/4-BPS degeneracies; we have not been able to verify a specific table number in a citable published source, and state them here as computed values reproduced by our implementation rather than as quotations.

**Remark 3.2.** No erratum or revision to [dgm-2008] addressing this discrepancy has been published. The most natural resolution is that equation (51) should include a half-integer shift on the elliptic variable for even divisors, as we derive in §4.

**Remark 3.3 (why the witness above cannot detect frame dependence).** The witness (4,1,2) has Δ = 12, so the s=2 term of the divisor sum sees the form of discriminant Δ/s² = 3, and there is exactly one GL(2,ℤ) class of binary quadratic forms of discriminant 3. Consequently the divisor sum evaluated at this charge is insensitive to the choice of basis for L, and the sign discrepancy of Proposition 3.1 is the only pathology visible here. This is a blind spot, not a general feature: once the relevant discriminant admits more than one class, the divisor sum is genuinely basis-dependent, which is the content of §6 (Theorem 6.3 and Proposition 6.5).

## 4. Algebraic derivation of the half-integer shift

We now show that the unique generating function compatible with equation (52) and the Alexandrov–Nampuri framework involves a precise half-integer shift (d-1)/2 on even divisors.

**Setup.** Alexandrov and Nampuri [alexandrov-nampuri-2020] give two coupled equations for torsion-I refined partition functions:

(AN-1)  Z_I^{(4|4)}(τ,z,σ) = Σ_{n,m,ℓ} (-1)^ℓ Ω_I^{(4|4)}(n,m,ℓ) q^n y^ℓ p^m,  with Z_1 = 1/Φ₁₀

(AN-2)  Ω_I^{(4|4)}(n,m,ℓ) = Σ_{d|I} d · Ω_1^{(4|4)}(n, m/d², ℓ/d)

**Variable dictionary.** Alexandrov–Nampuri write their Siegel variables in the order (τ,z,σ) with the rescaled index carried by σ; we write ours in the order (ρ,σ,v) with the index carried by ρ. The correspondence is *not* the left-to-right one, and getting it wrong is easy: the two triples are ordered differently and the elliptic variable sits in different slots. It is fixed unambiguously by which variable the divisor s acts on, as follows.

| role under 𝒱_s | this paper | Alexandrov–Nampuri | DGM |
|---|---|---|---|
| index variable, scaled by s² | ρ | σ | ρ |
| elliptic variable, scaled by s (plus the shift) | v | z | v |
| spectator, unscaled | σ | τ | σ |

So the dictionary is ρ ↔ σ_AN, v ↔ z_AN, σ ↔ τ_AN. Our convention agrees with DGM's slot-by-slot; only the AN reference requires the reordering. In particular the AN formula (**) below, read literally, scales its *third* argument by d², and that third argument is our ρ.

**Theorem 4.1 (Half-integer shift formula).** Solving equations (AN-1)+(AN-2) for Z_I gives

Z_I^{(4|4)}(τ,z,σ) = Σ_{d|I} d/Φ₁₀(τ, dz + (d-1)/2, d²σ).  (**)

*Proof.* Substitute (AN-2) into (AN-1):

Z_I = Σ_{n,m,ℓ} (-1)^ℓ [Σ_{d|I} d·Ω_1(n, m/d², ℓ/d)] q^n y^ℓ p^m.

Exchange the order of summation (finite sum over d, formal power series in q,y,p):

= Σ_{d|I} d · Σ_{n,m,ℓ} (-1)^ℓ Ω_1(n, m/d², ℓ/d) q^n y^ℓ p^m.

The inner sum runs only over (n,m,ℓ) where d²|m and d|ℓ (else Ω_1 vanishes by integrality). Change variables: m = d²m', ℓ = dℓ' (ranging over all integers m', ℓ' where Ω_1(n,m',ℓ')≠0):

= Σ_{d|I} d · Σ_{n,m',ℓ'} (-1)^{dℓ'} Ω_1(n,m',ℓ') q^n y^{dℓ'} p^{d²m'}.

**Key identity.** We need to rewrite (-1)^{dℓ'} · y^{dℓ'} as (-1)^{ℓ'} · (y_new)^{ℓ'} for some y_new. Direct computation:

(-1)^{dℓ'} · y^{dℓ'} = (-1)^{ℓ'+(d-1)ℓ'} · y^{dℓ'} = (-1)^{ℓ'} · [(-1)^{(d-1)ℓ'} · y^{dℓ'}]
                     = (-1)^{ℓ'} · [e^{iπ(d-1)ℓ'} · e^{2πizdℓ'}]
                     = (-1)^{ℓ'} · e^{2πi[dz + (d-1)/2]ℓ'}.

Setting z_new = dz + (d-1)/2 and y_new = e^{2πiz_new}, we have

(-1)^{dℓ'} y^{dℓ'} = (-1)^{ℓ'} y_new^{ℓ'}.

Similarly, p^{d²m'} = (p^{d²})^{m'} = p_new^{m'} where p_new = e^{2πid²σ}. Therefore:

Z_I = Σ_{d|I} d · Σ_{n,m',ℓ'} (-1)^{ℓ'} Ω_1(n,m',ℓ') q^n y_new^{ℓ'} p_new^{m'}
    = Σ_{d|I} d · Z_1(τ, z_new, d²σ)     [by (AN-1) with I=1]
    = Σ_{d|I} d/Φ₁₀(τ, dz + (d-1)/2, d²σ). ∎

**Corollary 4.2 (Parity analysis).** 
- When d is odd: (d-1)/2 ∈ ℤ. By Φ₁₀'s integer periodicity in z (proven in [kawai-1997] via the Borcherds product formula, where all y-exponents are integers), the shift is cancelled.
- When d is even: (d-1)/2 is a half-integer (e.g., 1/2, 3/2, 5/2 for d=2,4,6). The shift is genuine and non-trivial.

**Translation to DGM notation.** Applying the dictionary of §4 (ρ ↔ σ_AN, v ↔ z_AN, σ ↔ τ_AN) to (**) — so that the argument scaled by d², namely AN's third slot, becomes our ρ, and AN's elliptic variable z becomes our v — the rescaling acts as (ρ,σ,v) ↦ (s²ρ, σ, sv) and (**) becomes

𝒵_I(ρ,σ,v) = Σ_{s|I} s/Φ₁₀(s²ρ, σ, sv + (s-1)/2).

This differs from DGM equation (51) precisely by the half-integer shift (s-1)/2 for even s, resolving the sign discrepancy in Proposition 3.1.

## 5. Attractor cycle covariance

We now prove that attractor cycle contours transform covariantly under charge rescaling, allowing the divisor sum to commute with the immortal projection without invoking mock modular form decompositions.

**Lemma 5.1 (Adjugate covariance).** Let T = [[m, ℓ/2], [ℓ/2, n]] with det(T) ≠ 0, and A_s = diag(s,1). Set T' = A_s^{-1} T A_s^{-T}. Then:
(a) T' = [[m/s², ℓ/(2s)], [ℓ/(2s), n]]  (the Gram matrix for charges (m/s², n, ℓ/s))
(b) A_s · adj(T) · A_s^T = s² · adj(T')
(c) det(T') = det(T)/s²

*Proof.* (a) and (c) are direct computation. For (b), use adj(X) = det(X)·X^{-1} for invertible 2×2 matrices:

adj(T') = det(T') · (T')^{-1} = (det(T)/s²) · (A_s^T T^{-1} A_s)
        = (1/s²) · A_s^T adj(T) A_s.

Multiply both sides by s² and use A_s^T = A_s. ∎

**Theorem 5.2 (Attractor cycle covariance).** Let F be meromorphic on ℍ₂ and satisfy F(Ω+S) = F(Ω) for all integer symmetric S. Let (m,n,ℓ) satisfy m,n≥1, Δ>0, and s≥1. Define the rescaled charges (m',n',ℓ') = (m/s², n, ℓ/s) and Λ' = s²Λ. If the contour C_*(m',n',ℓ';Λ') avoids the poles of F, then:

(a) If s²|m and s|ℓ: ∫_{C_*(m,n,ℓ;Λ)} F(s²ρ,σ,sv) e^{-2πi(mρ+nσ+ℓv)} dρdσdv = ∫_{C_*(m',n',ℓ';Λ')} F(Ω) e^{-2πi(m'ρ+n'σ+ℓ'v)} dρdσdv

(b) Otherwise, the left side equals 0.

*Proof.* Change variables (ρ,σ,v) ↦ (ρ',σ',v') = (s²ρ, σ, sv). On C_*(m,n,ℓ;Λ), we have Im Ω = 2Λ·adj(T), hence the image satisfies

Im Ω' = A_s(2Λ adj T)A_s^T = 2Λ·s²·adj(T') = 2Λ'·adj(T')  [by Lemma 5.1(b)],

which is precisely the defining condition for C_*(m',n',ℓ';Λ'). The real parts map [0,1]³ to [0,s²]×[0,1]×[0,s]. The phase factor satisfies

mρ + nσ + ℓv = (m/s²)·(s²ρ) + n·σ + (ℓ/s)·(sv) = m'ρ' + n'σ' + ℓ'v'

as a complex identity (valid for rational m',ℓ'). The Jacobian is s³.

*Case (a): s²|m, s|ℓ.* Then m',ℓ' ∈ ℤ. The integrand F(Ω')·exp(...) has integer periods in ρ₁,v₁, so

∫_{[0,s²]×[0,1]×[0,s]} = s²·1·s · ∫_{[0,1]³} = s³ · [RHS of (a)].

The Jacobian s³ cancels, giving (a).

*Case (b): s²∤m or s∤ℓ.* Then the integrand has fractional periods 1/s² in ρ₁ or 1/s in v₁. Expanding F|_{C_*} in Fourier series, the coefficient at (m,n,ℓ) vanishes by the fractional period conditions. ∎

**Corollary 5.3.** For F = 𝒢 (which satisfies the hypotheses of Theorem 5.2), and charges satisfying the integrality conditions:

∫_{C_*(m,n,ℓ;Λ)} 𝒱_s 𝒢 · e^{-2πi(mρ+nσ+ℓv)} dρdσdv = d_*(m/s², n, ℓ/s).

*Proof.* Direct application of Theorem 5.2(a) with F=𝒢, noting that 𝒢 avoids poles for Λ sufficiently large by the Sen attractor prescription, and the right side is the definition of d_*. ∎

**Remark 5.4.** This is the key technical result. It shows that the rescaling operator 𝒱_s on the generating function corresponds exactly to rescaling the charges in the immortal index, with no multi-centered corrections. The proof uses only linear algebra (adjugate transformation) and Cauchy's theorem (contour independence for holomorphic integrands). No mock modular form decomposition is required.

## 6. The divisor sum is not a function of the charge

This section is logically independent of §§3–5: it uses only the definition of d_* from §2 and the class-function property proved in Appendix A. Its conclusion is what forces the physical premise of §8 to be stated on frames rather than on charges.

**Terminology.** A *frame* of a rank-2 sublattice L ⊆ Λ is an ordered basis (Q,P) of L. We write (m,n,ℓ) = (Q²/2, P²/2, Q·P) for its invariants, Δ = 4mn − ℓ², M = (L⊗ℚ) ∩ Λ for the saturation and I = gcd(Q∧P) = [M:L] for the torsion. A frame is *admissible for I* if I²|m and I|ℓ — i.e. if it lies in the hypothesis domain of Theorem 7.1 — and *adapted* if Q ∈ IΛ. Adapted implies admissible (§2); this section is about the gap between the two.

**A counting convention.** For D > 0 let H(D) denote the number of GL(2,ℤ)-equivalence classes of positive definite integral binary quadratic forms of discriminant −D, *imprimitive forms included*: H(D) = Σ_{f²|D} h(−D/f²) with SL(2,ℤ) classes related by ℓ ↦ −ℓ identified. This is the count that matters below, and it is not the usual class number: for instance H(16) = 2, the two classes being (m,n,ℓ) = (1,4,0) and (2,2,0), of which the second is imprimitive, whereas the primitive class number h(−16) is 1. Likewise H(3) = H(4) = 1, H(23) = 2, and H(32) = 3.

Write

D_I(m,n,ℓ) := Σ_{s|I} s · d_*(m/s², n, ℓ/s)

for the right-hand side of DGM equation (52), a term being present exactly when its arguments are integral (automatic on an admissible frame). Theorem 7.1 says d_*^{(I)}(m,n,ℓ) = D_I(m,n,ℓ) on every admissible frame.

### 6.1 What the s-th term computes

**Proposition 6.1.** Let (Q,P) be a frame of L with invariants (m,n,ℓ), and let s ≥ 1 satisfy s²|m and s|ℓ. Inside L ⊗ ℚ put L^{(s)} := ℤ(Q/s) + ℤP. Then:

(a) L ⊆ L^{(s)} and [L^{(s)} : L] = s.

(b) The Gram triple of L^{(s)} in the basis (Q/s, P) is (m/s², n, ℓ/s), of discriminant Δ/s². Consequently the s-th term of D_I is s·d_*(T_{L^{(s)}}): the divisor sum is a weighted sum of immortal indices of *superlattices* of L obtained by dividing Q, not P.

(c) L^{(s)} ⊆ Λ if and only if Q/s ∈ M.

(d) If the frame is adapted then M/L is cyclic of order I and, for every s|I, L^{(s)} = L_s, the unique intermediate lattice L ⊆ L_s ⊆ M of index s.

(e) If the frame is admissible but not adapted, then L^{(s)} ⊄ Λ for at least one s|I. For that s, L^{(s)} and L_s are two positive definite lattices of the same discriminant Δ/s² which need not be GL(2,ℤ)-equivalent.

*Proof.* (a) Q = s·(Q/s) and P lie in L^{(s)}, so L ⊆ L^{(s)}; comparing Gram determinants, det T_{L^{(s)}} = (det T)/s², so the index is s. The hypotheses s²|m, s|ℓ are exactly what makes T_{L^{(s)}} integral with even diagonal.

(b) (Q/s)²/2 = m/s², P²/2 = n, (Q/s)·P = ℓ/s, and 4(m/s²)n − (ℓ/s)² = Δ/s². That the s-th term is an immortal index of the lattice rather than of the chosen basis is Proposition A.1: d_* is a function of the GL(2,ℤ) class of the Gram matrix.

(c) L^{(s)} ⊆ Λ ⟺ Q/s ∈ Λ; and Q/s ∈ L ⊗ ℚ, so this says Q/s ∈ (L⊗ℚ) ∩ Λ = M.

(d) If Q ∈ IΛ then Q/I ∈ M by (c), hence Q/s ∈ M for all s|I. Cyclicity of M/L is the standard fact recalled in §2 (it is equivalent to the existence of an adapted frame). Then L ⊆ L^{(s)} ⊆ M with [L^{(s)}:L] = s, and in a cyclic group of order I there is exactly one subgroup of order s, so L^{(s)} = L_s.

(e) If Q/s ∈ M held for every s|I, then in particular Q/I ∈ M ⊆ Λ, i.e. Q ∈ IΛ and the frame would be adapted. The discriminant claim is (b); inequivalence is exhibited in Theorem 6.3. ∎

**Remark 6.2 (this is exactly what the DGM derivation does).** The route to equation (52) proceeds by rescaling the generating function, ρ ↦ s²ρ and v ↦ sv — the operator 𝒱_s of §2, whose contour-side content is Theorem 5.2. Proposition 6.1 identifies its charge-side content: *divide Q by s*. That operation stays inside the charge lattice precisely when the frame is adapted. Equation (52) is therefore not, on its face, an identity between functions of (m,n,ℓ,I); it is an identity attached to a frame. Whether the frame dependence is actually visible is the subject of Theorem 6.3 and Proposition 6.5.

### 6.2 The witnesses

All lattices below live in U ⊕ U ⊆ Λ, where U is the even unimodular hyperbolic plane. We use coordinates (x₀,x₁,x₂,x₃) with respect to a basis e₁, f₁, e₂, f₂ and the pairing ⟨x,y⟩ = x₀y₁ + x₁y₀ + x₂y₃ + x₃y₂.

**Remark (realizability in the physical charge lattice).** The charge lattice of the theory is Λ ≅ Γ^{6,22} ≅ U³ ⊕ E₈(−1)², in which U ⊕ U is an orthogonal — in particular primitive — direct summand; the same Γ^{6,22} carries the charges in the heterotic-on-T⁶ and the type II-on-K3×T² descriptions, which are related by string–string duality. Hence every sublattice exhibited below, together with its saturation, occurs as an honest pair of 1/4-BPS charge vectors, with the torsion computed in Λ agreeing with the torsion computed in U ⊕ U. The signature of U ⊕ U is (2,2), which is what allows the positive definite rank-2 sublattices used here.

**Theorem 6.3 (frame dependence).** There exist a rank-2 positive definite sublattice L ⊆ Λ and two frames of L, related by an element of SL(2,ℤ) and both admissible for I = [M:L], on which D_I takes different values. Three witnesses:

**(A) I = 2, minimal discriminant.** Let w = e₁ + f₁ and u = e₂ + 4f₂, so that M := ℤw + ℤu has Gram triple (1,4,0) and Δ_M = 16, and set L := ℤ(2w) + ℤu, so [M:L] = 2 and I = 2. The two frames

| | frame 1 (adapted) | frame 2 (not adapted) |
|---|---|---|
| Q | 2w = (2,2,0,0) | −2w−u = (−2,−2,−1,−4), **primitive** |
| P | u = (0,0,1,4) | −u = (0,0,−1,−4), **primitive** |
| (m,n,ℓ) | (4,4,0) | (8,4,8) |
| Δ | 64 | 64 |
| admissible (4\|m, 2\|ℓ) | yes | yes |

are related by U = [[−1,0],[−1,−1]] ∈ SL(2,ℤ), i.e. (Q,P) ↦ (−Q−P, −P); they span the same L, with the same torsion, and (4,4,0) ∼ (8,4,8) in GL(2,ℤ). Yet

D₂(4,4,0) = d_*(4,4,0) + 2·d_*(1,4,0) = 7999169992704 + 2 × 185738352 = **7999541469408**,
D₂(8,4,8) = d_*(8,4,8) + 2·d_*(2,4,4) = 7999169992704 + 2 × 32861184 = **7999235715072**,

differing by 305754336. Note that in frame 2 *both* charge vectors are primitive, so the discrepancy cannot be explained away as an artefact of a non-primitive charge.

**(B) I = 2, the two frames related by the S-duality generator itself.** Let w = e₁ + f₁, u = e₂ + 8f₂, L := ℤ(2w) + ℤu, so the adapted frame has T = (4,8,0), Δ = 128, I = 2. Apply S = [[0,−1],[1,0]], i.e. (Q,P) ↦ (P,−Q), giving T″ = (8,4,0), again admissible. Then

D₂(4,8,0) = 479643192755712000 + 2 × 668043042720 = **479644528841797440**,
D₂(8,4,0) = 479643192755712000 + 2 × 9337042944 = **479643211429797888**,

differing by 1317411999552. This witness is the conceptually cleanest of the three: equation (52) rescales Q only, whereas S exchanges Q and P.

**(C) I = 3, so the phenomenon is not 2-torsion-specific.** Let w = e₁ + f₁ and u = −f₁ + e₂ + 6f₂, so M := ℤw + ℤu has Gram triple (1,6,−1) and Δ_M = 23; set L := ℤ(3w) + ℤu, giving the adapted frame T = (9,6,−3) with Δ = 207 and I = 3. With U = [[−2,−1],[−1,−1]] ∈ SL(2,ℤ) the second frame is T″ = (36,12,39), admissible (9|36, 3|39), with both charge vectors primitive. Then

D₃(9,6,−3) = 4315653393218540262504 + 3 × 8203464720 = **4315653393243150656664**,
D₃(36,12,39) = 4315653393218540262504 + 3 × 392427528 = **4315653393219717545088**,

differing by 23433111576.

*Proof.* The lattice-theoretic assertions — that the two frames of each witness span the same L, have the same torsion, and are both admissible — are finite integer computations in U ⊕ U, carried out in `scripts/lattice_witness.py` by Smith normal form and reproduced by hand in a few lines. That the two invariant triples of each witness are GL(2,ℤ)-equivalent (so that the s = 1 terms agree) is Gauss reduction. It remains to locate the discrepancy and to evaluate the integers.

By Proposition 6.1(b), the s-th terms are immortal indices of forms of discriminant Δ/s². In witness (A), Δ/s² = 16 for s = 2, and H(16) = 2: the adapted frame gives L^{(2)} = ℤw + ℤu = M of class (1,4,0), while the non-adapted frame gives the triple (8/4, 4, 8/2) = (2,4,4) ∼ (2,2,0), the *other* class. In witness (B), Δ/s² = 32 and H(32) = 3, the two frames landing in the classes (1,8,0) and (2,4,0). In witness (C), Δ/s² = 23 and H(23) = 2, the two frames landing in (1,6,1) and (2,3,1). In each case the s = 1 terms coincide and the entire discrepancy sits in the s = I term, as the displayed arithmetic shows.

The values of d_* are exact integers computed by `scripts/divisor_sum_values.py` (bundled; pure standard-library integer arithmetic, no floating point) from the Fourier coefficients of 1/Φ₁₀. That engine reproduces, exactly, the published unit-torsion degeneracies at the five charges (Q²,P²) = (2,2), (4,4), (6,4), (8,4), (10,4) with Q·P = 0 — namely 50064, 32861184, 632078672, 9337042944, 113477152800 — at which the total and immortal indices coincide, and it satisfies Rosselló's Theorem 1 and Corollary 1.1 on every charge in its computed range (86 and 171 tests respectively, no violations). A control run with U = identity returns difference 0, confirming that the nonzero differences are produced by a genuinely non-trivial change of basis and not by the script. ∎

**Theorem 6.4 ((m,n,ℓ,I) is not a complete invariant of a charge pair).** There exist two charge pairs in U ⊕ U with identical (m,n,ℓ,I) whose saturations are not isometric:

| | charge (a) | charge (b) |
|---|---|---|
| Q | (−2,−2,−1,−4) | (2,4,0,0) |
| P | (0,0,−1,−4) | (1,2,1,2) |
| (m,n,ℓ) | (8,4,8) | (8,4,8) |
| I = gcd(Q∧P) = [M:L] | 2 | 2 |
| Gram class of M | (1,4,0) | (2,2,0) |
| frame adapted? | no | yes |

*Proof.* The invariants and the torsion are direct computations; the saturations are computed by Smith normal form (`scripts/lattice_witness.py`). The form (1,4,0) represents 1 and is primitive, while (2,2,0) has content 2; hence the two saturations are not isometric. ∎

Theorem 6.4 is stronger than Theorem 6.3 in one respect and weaker in another: it shows that no function of (m,n,ℓ,I) whatsoever can recover the lattice-theoretic data of a torsion-I charge, independently of any formula; but on its own it does not show that the *specific* expression D_I fails to be such a function. Theorem 6.3 does that.

### 6.3 Why the failure went unnoticed

**Proposition 6.5.** Fix L with torsion I and discriminant Δ. If H(Δ/s²) = 1 for every s|I, then D_I takes the same value on every admissible frame of L.

*Proof.* By Proposition 6.1(b), on any admissible frame the s-th term of D_I is s·d_* of a positive definite integral form of discriminant Δ/s². If H(Δ/s²) = 1, all such forms are GL(2,ℤ)-equivalent, and d_* is a class function (Proposition A.1), so the s-th term is the same on every admissible frame. Summing over s|I gives the claim. ∎

This is a sufficient condition, and we do not claim it is necessary; see §10.

**Remark 6.6.** Proposition 6.5 explains why the discrepancy has survived in the literature. The witness used in §3 to separate DGM (51) from (52) is I = 2 with (m,n,ℓ) = (4,1,2), so Δ = 12 and the s = 2 term has discriminant Δ/4 = 3, where H(3) = 1: that charge lies in the blind spot, and no change of admissible frame can move its divisor sum (Remark 3.3). The same is true of the small tabulated examples we are aware of. Detecting the failure requires H(Δ/s²) ≥ 2 for some s|I, and the witnesses of Theorem 6.3 were selected on exactly that criterion — (A) and (C) being the smallest-discriminant instances found by a systematic search over frames in which both charge vectors remain primitive.

**Remark 6.7 (what this forces, and what it leaves standing).** Since the single-centered index of a given dyon is one number and S-duality is an exact symmetry, Theorem 6.3 rules out reading equation (52) as an identity between that index and a function of (m,n,ℓ,I). §8 therefore asserts the physical identification only on adapted frames, premise (P′_ad), and recovers positivity on a charge domain that is S-duality invariant (Corollary 8.1). Nothing in §§3–5 or §7 is affected: those are statements about triples, and they remain correct exactly as stated — indeed Theorem 6.3 uses Theorem 7.1's own hypothesis domain to produce its two frames.

**Ancillary files.** Three scripts accompany this paper: `coefficients.py` (Fourier coefficients of 1/Φ₁₀ from the Fourier–Jacobi expansion, together with its own tests of Rosselló's Theorem 1 and Corollary 1.1), `divisor_sum_values.py` (the reference values and all five frame pairs of §6.2, including the identity control), and `lattice_witness.py` (Smith normal form verification of the torsion, saturation and primitivity claims of Theorems 6.3 and 6.4). They use exact integer arithmetic and the Python standard library only. Every integer displayed in this section is printed verbatim by one of them.

## 7. Positivity theorem

**Theorem 7.1 (Main result).** Let I≥1 and (m,n,ℓ) ∈ ℤ³ satisfy I²|m, I|ℓ, m,n≥1, Δ=4mn-ℓ²>0. Then

d_*^{(I)}(m,n,ℓ) = Σ_{s|I} s · d_*(m/s², n, ℓ/s) > 0.

*Proof.* By definition, d_*^{(I)} = ∫_{C_*} 𝒢_I · e^{-2πi(mρ+nσ+ℓv)}. Since 𝒢_I = Σ_{s|I} s·𝒱_s𝒢 is a finite sum and integration is linear:

d_*^{(I)}(m,n,ℓ) = Σ_{s|I} s · ∫_{C_*} 𝒱_s𝒢 · e^{-2πi(mρ+nσ+ℓv)}.

For each term, apply Corollary 5.3. The integrality conditions s²|m, s|ℓ hold because s|I implies s²|I²|m and s|I|ℓ. Therefore:

d_*^{(I)}(m,n,ℓ) = Σ_{s|I} s · d_*(m/s², n, ℓ/s).

For positivity, verify that each term satisfies the hypotheses of Rosselló's Corollary 1.1 [rossello-2024]:
- m/s² ≥ 1 (since s²|m and m≥1)
- n ≥ 1 (unchanged by rescaling)
- Δ/s² = (4mn-ℓ²)/s² = 4(m/s²)n - (ℓ/s)² > 0 (by Lemma 5.1(c))

Crucially, Rosselló's Corollary 1.1 requires no gcd condition. The corollary states: for any m,n,ℓ ∈ ℤ with m,n≥1 and Δ>0, the immortal index d_*(m,n,ℓ) > 0. This applies to rescaled charges (m/s², n, ℓ/s) even when gcd(m/s², n, ℓ/s) > 1.

Therefore each term s·d_*(m/s², n, ℓ/s) is a positive weight times a positive quantity, and the sum is positive. ∎

**Remark 7.2 (Why Rosselló's result is gcd-independent).** Rosselló proves d_*(T) > 0 for all positive definite half-integer symmetric 2×2 matrices T via Gauss reduction: every such T is GL(2,ℤ)-equivalent to a reduced form T₀ with 0≤ℓ₀≤m₀≤n₀, and his Theorem 1 proves (-1)^{ℓ₀+1}c_{m₀}^F(n₀,ℓ₀) > 0 for reduced forms. The S-duality invariance d_*(T) = d_*(A^{-T}TA^{-1}) for A∈SL(2,ℤ) propagates positivity to all equivalent forms. This invariance holds for any T, regardless of whether the entries have a common factor—the gcd is an artifact of the physical interpretation, not a mathematical restriction.

We provide an independent proof of S-duality invariance in Appendix A using the same contour covariance technique as Theorem 5.2.

## 8. Physical interpretation and remaining assumption

The mathematical content (Propositions 3.1, 4.1, Theorem 5.2, Theorem 7.1) concerns the Igusa cusp form Φ₁₀ and contour integrals. To interpret these as physical BPS indices requires an identification of d_*^{(I)} with a degeneracy. The naive form of that identification is:

**Physical assumption (P'), false as stated.** The quantity d_*^{(I)}(m,n,ℓ) defined by our contour integral equals the single-centered (immortal) BPS degeneracy of a torsion-I dyon with charges (Q²/2, P²/2, Q·P) = (m,n,ℓ), where I = gcd(Q∧P).

By Theorem 7.1, d_*^{(I)}(m,n,ℓ) = D_I(m,n,ℓ) on the stated domain, and by Theorem 6.3 the function D_I takes two different values on two SL(2,ℤ)-related presentations of one and the same charge lattice, both of which satisfy the hypotheses. The immortal index of a given dyon is a single number, and S-duality is an exact symmetry of the theory, so (P') is untenable. We therefore replace it by the following strictly weaker statement.

**Physical assumption (P'_ad).** Let (Q,P) be a charge pair with torsion I = gcd(Q∧P), presented in an *adapted* frame, i.e. one in which Q ∈ IΛ (§2). Then d_*^{(I)}(Q²/2, P²/2, Q·P) equals the single-centered (immortal) BPS degeneracy of that dyon.

Three remarks on why this is the right replacement rather than an ad hoc patch.

1. **It is what the derivation actually supports.** The DGM route to equation (52) proceeds by the rescaling ρ ↦ s²ρ, v ↦ sv, which is the statement that Q is divisible by s inside Λ — an adapted-frame statement. Likewise Alexandrov–Nampuri's equation (2.16) and Banerjee–Sen [banerjee-sen-2008] restrict to a congruence subgroup of level I, written Γ⁰(I) in both sources; that is the S-conjugate of the group Γ₀(I) = {c ≡ 0 mod I} acting on frames here, the difference being only whether one divides Q or P, and adapted frames form precisely one Γ₀(I) orbit (§2). The frame restriction was implicit in the sources; making it explicit is what removes the counterexample.
2. **It costs nothing in generality of the conclusion.** Adapted frames exist whenever the saturation quotient M/L is cyclic, in particular whenever Q or P is primitive. So (P'_ad) still pins down the immortal index of essentially every charge of interest; it merely declines to assert that the triple (m,n,ℓ) read off from an arbitrary frame is a complete label.
3. **It makes the positivity conclusion S-duality invariant.** See Corollary 8.1.

**Corollary 8.1 (positivity, stated over charges).** Assume (P'_ad). Let (Q,P) be a charge pair in Λ with torsion I ≥ 1, write (m,n,ℓ) = (Q²/2, P²/2, Q·P) and Δ = 4mn - ℓ², and suppose m ≥ 1, n ≥ 1, Δ > 0, and that M/L is cyclic (automatic if Q or P is primitive). Then the single-centered degeneracy of (Q,P) is strictly positive.

*Proof.* Cyclicity gives an adapted frame (§2), in which the invariants satisfy I²|m and I|ℓ. The hypotheses m,n ≥ 1 and Δ > 0 are GL(2,ℤ)-invariant, hence hold in that frame. Apply Theorem 7.1 there, then (P'_ad). ∎

Note that the hypothesis of Corollary 8.1 is a condition on the charge pair, invariant under S-duality, whereas the hypothesis of Theorem 7.1 is a condition on a frame. The set of charges covered is strictly larger than the set of triples satisfying I²|m, I|ℓ: every charge with Q or P primitive qualifies, however its invariants happen to be presented.

(P'_ad) rests on:

1. **Duality arguments and 4d-5d lifts** relating torsion-I four-dimensional dyons to five-dimensional momentum sectors [dgm-2008, sen-2008].
2. **Fermionic zero mode counting** to extract the single-centered contribution from the total index [dgm-2008].
3. **Wall-crossing invariance** of the immortal index, encoded in the attractor contour prescription [dmz-2012].

These are standard ingredients of the microscopic derivation of black hole entropy in string theory. Assumption (P'_ad) rests on physical reasoning from supersymmetric quantum field theory and string duality rather than mathematical proof, and we do not prove it here. It remains the single physical input of the paper. [GAP: (P'_ad) unproven.]

**What this paper proves mathematically.** Independently of any physical assumption:
- The correct divisor sum formula compatible with Alexandrov–Nampuri's framework has the half-integer shift (Theorem 4.1), and DGM equations (51) and (52) as printed are incompatible (Proposition 3.1).
- The divisor sum commutes with the immortal projection via contour covariance (Theorem 5.2).
- Σ_{s|I} s·d_*(m/s², n, ℓ/s) > 0 on the domain of Theorem 7.1.
- That same expression is not a function of (m,n,ℓ,I), with an explicit integer witness (Theorem 6.3).

Given (P'_ad), these yield strict positivity of single-centered degeneracies for all torsion classes (Corollary 8.1).

The mathematical proofs do not reference string theory beyond the initial definition of d_* via the contour integral.

## 9. Open problems

**Problem 9.1 (the sharp criterion, and the invariant object behind D_I).** Proposition 6.5 gives a sufficient condition for the divisor sum to be frame-independent on a given orbit: H(Δ/s²) = 1 for every s|I. Is it necessary? Equivalently: given L with H(Δ/s²) ≥ 2 for some s|I, do there always exist two admissible frames of L whose superlattices L^{(s)} fall in different classes? Proposition 6.1(e) shows that a non-adapted admissible frame produces an L^{(s)} outside Λ, but not that its class must differ from that of L_s.

A positive answer would upgrade the counterexamples of §6 to a structure theorem, and would presumably come with the object we are really after: the S-duality-invariant function of the charge whose restriction to adapted frames is D_I. Proposition 6.1(d) suggests the candidate

𝔇(L) := Σ_{L ⊆ L' ⊆ M} [L' : L] · d_*(T_{L'}),

a sum over *all* intermediate lattices rather than over divisors of I. On a cyclic M/L with an adapted frame this reproduces D_I term by term, and it is manifestly a function of L alone, hence S-duality invariant; whether it is the physically correct extension when M/L is non-cyclic (so no adapted frame exists) we do not know. Note that positivity is insensitive to this choice: 𝔇(L) is a positive-weight sum of immortal indices, so Corollary 8.1 holds for it verbatim.

**Problem 9.2 (do the fractional-shift formulae fail in the same way?).** The summation formulae for torsion dyons that rescale P rather than Q, and carry fractional shifts on the projected variables, have a different structure: Proposition 6.1 applies to the superlattice obtained by dividing Q, and does not transfer. If those formulae *are* frame-covariant, they, rather than equation (52), would be the correct general statement, with (52) their specialisation to adapted frames. We have not checked this, and regard it as the most useful next test of the present analysis.

**Problem 9.3 (BKM algebra interpretation of the half-integer shift).** The shift (d-1)/2 for even d can be understood at the level of Borcherds products: in the product formula for Φ₁₀, the substitution y → -y (equivalent to z → z+1/2) changes each factor (1-p^k q^l y^r) to (1-(-1)^r p^k q^l y^r), i.e., it acts as (-1)^r on the root spaces. This is a ℤ/2ℤ automorphism ω of the BKM superalgebra associated with Φ₁₀ [gritsenko-nikulin-1998]. 

The precise correspondence between ω and the half-integer shift in our generating function requires:
(i) Constructing the Cartan element H_r ∈ 𝔥 with [H_r, e_{(k,l,r)}] = r·e_{(k,l,r)}.
(ii) Verifying ω = exp(πi·ad(H_r)) has order 2 and acts as (-1)^r on root spaces.
(iii) Relating the twisted denominator identity Den_ω to Φ₁₀(τ, z+1/2, σ).

Partial results: H_r = f₃/2 exists in the root lattice M₁ ⊗ ℚ and has the required commutation relations. However, Den_ω is weight-5 (not weight-10), so the naive identity Den_ω = const·Φ₁₀(z+1/2) fails. The correct relation is Φ₁₀(z+1/2) = -Den_ω². The full BKM-algebraic interpretation remains open.

**Problem 9.4 (Mock modular form perspective).** Does the divisor sum operator 𝒯_I commute with the DMZ canonical decomposition ψ_M = ψ_M^F + ψ_M^P? Specifically, for G_M^{(I)} := Σ_{s|I, s²|M} s·(ψ_{M/s²}|U_s), where U_s is the Eichler–Zagier operator, is it true that (G_M^{(I)})^F = Σ_{s|I, s²|M} s·(ψ_{M/s²}^F|U_s)?

Direct computation shows 𝒜_{2,m}|U_t differs from the "Appell–Lerch principal part average" by an explicit theta term Θ_{m,t}, which is holomorphic. Whether Θ_{m,t} is absorbed by the DMZ canonical normalization depends on details of [dmz-2012, §8] that we have not extracted. This question does not affect Theorem 7.1 (which uses contour integrals, not mock forms), but it would provide an alternative route to the divisor sum identity at the level of Fourier coefficients.

**Problem 9.5 (Equality d_* = (-1)^{ℓ+1}c_m^F beyond Gauss-reduced representatives).** Numerical evidence shows that the identity d_*(m,n,ℓ) = (-1)^{ℓ+1}c_m^F(n,ℓ) holds when (m,n,ℓ) satisfies n≥m and 0≤ℓ≤m (the Gauss reduction domain), but fails for n<m. Example: (5,1,4) and (1,1,0) lie in the same GL(2,ℤ)-orbit (hence have the same d_* = 50064), but (-1)^{ℓ+1}c_5^F(1,4) = -2023536 ≠ 50064.

The failure mechanism is well-understood: performing the Fourier–Jacobi separation (integrating over ρ first to isolate the M=m term) implicitly assumes Im ρ ≥ Im σ, which holds precisely when n≥m. The question is whether the equality can be rigorously proven (not just numerically verified) for n≥m using analytic estimates on the convergence of the FJ series at finite heights. This would complete the story for I=1 but is not needed for the main positivity result.

## 10. Conclusion

We have shown that the right-hand side of the torsion divisor sum formula is not a function of the charge, and that the premise under which it is normally read is therefore untenable; and we have shown that strict positivity of single-centered BPS degeneracies survives for all torsion classes in N=4 string theory on K3×T², conditional on the repaired premise (P'_ad) — the identification of the contour integral d_*^{(I)} with a degeneracy, asserted on adapted frames only. The route was:

1. Identifying an incompatibility between two formulas in the literature (§3).
2. Deriving the correct generating function with half-integer elliptic shifts from the Alexandrov–Nampuri framework (§4).
3. Proving that attractor cycle contours are covariant under charge rescaling, bypassing the need for mock modular form techniques (§5).
4. Identifying the s-th term of the divisor sum as the immortal index of an index-s superlattice, and exhibiting three frame pairs on which the sum takes two values (§6).
5. Applying Rosselló's unit-torsion positivity theorem without gcd restrictions (§7).
6. Replacing (P') by (P'_ad) and restating positivity over an S-duality invariant set of charges (§8).

The mathematical techniques are elementary (Fourier series, linear algebra on lattices and symmetric matrices, contour integration), requiring no deep knowledge of Siegel modular forms beyond the definition of Φ₁₀ and its periodicity properties.

Two features of the final statement deserve emphasis. First, the premise is *weaker* than the one it replaces, and the conclusion is *stronger*: Corollary 8.1 covers a charge set closed under S-duality, strictly containing the triples to which Theorem 7.1 literally applies. Second, the frame dependence exposed in Theorem 6.3 is invisible whenever H(Δ/s²) = 1 for every s|I (Proposition 6.5) — a condition satisfied by every small example we are aware of in the literature, which we believe accounts for the formula having stood unchallenged. We do not claim the converse. Whether H(Δ/s²) = 1 is also *necessary* for invisibility — i.e. whether every charge admitting two admissible frames whose superlattices could a priori fall in different classes actually exhibits a discrepancy — is not settled here; the witnesses of Theorem 6.3 show only that H = 2 suffices to produce one. Establishing the sharp criterion, and with it the correct S-duality-invariant object of which D_I on adapted frames is the restriction, would turn the counterexamples of §6 into a structure theorem; we regard this as the most valuable open problem raised by this paper.

That the invariants (Q²/2, P²/2, Q·P) are insufficient to label torsion-I dyons is not itself new: Banerjee and Sen observed in 2008 that for torsion r only the subgroup Γ⁰(r) of the S-duality group acts manifestly on these invariants [banerjee-sen-2008]. What is new here is the sharp form of the failure — explicit integer witnesses, the identification of the mechanism as the class of an index-s superlattice (Proposition 6.1), a sufficient condition under which the failure is invisible (Proposition 6.5), and the lattice-theoretic criterion Q ∈ IΛ that repairs it — together with the covariant rewriting under which positivity survives.

The open questions we consider most pressing are the sharp criterion for frame dependence and the invariant object behind D_I (Problem 9.1), and whether the fractional-shift summation formulae fail in the same way (Problem 9.2); beyond those, the BKM-algebraic interpretation of the half-integer shift, the behavior of divisor sums at the mock modular form level, the precise domain of validity for mock coefficient identities, and of course a proof of (P'_ad) itself. None of these affects the core positivity result.

## Acknowledgments

We thank [to be completed] for discussions and correspondence regarding the divisor sum formulas in [dgm-2008] and related work on BKM algebras and mock modular forms.

## Appendix A. S-duality invariance of d_*

For completeness, we provide an independent proof that d_*(T) depends only on the GL(2,ℤ)-equivalence class of T, using the same contour covariance technique as Theorem 5.2.

**Proposition A.1.** For A ∈ SL(2,ℤ) and T a positive definite half-integer symmetric 2×2 matrix, 

d_*(A^{-T}TA^{-1}) = d_*(T).

*Proof.* We use the contour integral definition. Under the transformation Ω' = AΩA^T (which is the Sp(4,ℤ) action [[A,0],[0,(A^T)^{-1}]] on ℍ₂), the function 𝒢 is invariant: 𝒢(AΩA^T) = 𝒢(Ω) because Φ₁₀ is Sp(4,ℤ)-invariant and the half-period shift [[0,1/2],[1/2,0]] satisfies A·(half-period)·A^T = (integer symmetric matrix) modulo the half-period itself.

The phase factor transforms as Tr(ΩT) = Tr(A^{-1}Ω'A^{-T}·T) = Tr(Ω'·A^{-T}TA^{-1}). The contour transforms as Im Ω' = A(2Λ adj T)A^T. By the identity

adj(A^{-T}TA^{-1}) = det(A^{-T}TA^{-1})·(A^{-T}TA^{-1})^{-1} 
                    = (det A)^{-2} det T · (AT^{-1}A^T)
                    = det T · A(T^{-1})A^T     [using det A = 1]
                    = A adj(T) A^T,

we have Im Ω' = 2Λ·adj(T') where T' := A^{-T}TA^{-1}. The Jacobian determinant of Ω↦AΩA^T on Sym₂(ℝ) is 1 (since A∈SL(2,ℤ) acts volume-preservingly), and the map sends the fundamental domain to itself. Therefore:

d_*(T') = ∫_{C_*(T';Λ)} 𝒢(Ω) e^{-2πi Tr(ΩT')} dΩ
        = ∫_{C_*(T;Λ)} 𝒢(AΩA^T) e^{-2πi Tr(AΩA^T·T')} dΩ    [change of variables]
        = ∫_{C_*(T;Λ)} 𝒢(Ω) e^{-2πi Tr(ΩT)} dΩ                [by invariance of 𝒢 and phase]
        = d_*(T). ∎

This proves S-duality invariance independently of [rossello-2024], using only the contour covariance framework developed in §5.

## References

[alexandrov-nampuri-2020] S. Alexandrov, S. Nampuri, "Refinement and modularity of immortal dyons," arXiv:2009.01172, JHEP 01 (2021) 147.

[banerjee-sen-2008] S. Banerjee, A. Sen, "Duality Orbits, Dyon Spectrum and Gauge Theory Limit of Heterotic String Theory on T^6," arXiv:0801.0149, JHEP 03 (2008) 022.

[dgm-2008] A. Dabholkar, J. Gomes, S. Murthy, "Counting all dyons in N=4 string theory," arXiv:0803.2692, JHEP 05 (2011) 059.

[dmz-2012] A. Dabholkar, S. Murthy, D. Zagier, "Quantum Black Holes, Wall Crossing, and Mock Modular Forms," arXiv:1208.4074.

[gritsenko-nikulin-1998] V. Gritsenko, V. Nikulin, "Automorphic forms and Lorentzian Kac-Moody algebras, Part II," alg-geom/9611028.

[kawai-1997] T. Kawai, "K3 Surfaces, Igusa Cusp Form and String Theory," arXiv:hep-th/9710016.

[rossello-2024] M. Rosselló, "The Immortal Dyon Index Is Positive," arXiv:2403.19630.

[sen-2008] A. Sen, "Black Hole Entropy Function, Attractors and Precision Counting of Microstates," Gen. Rel. Grav. 40 (2008) 2249, arXiv:0708.1270.

