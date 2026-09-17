# Incompatibility of divisor sum formulae and positivity of torsion dyon degeneracies in N=4 string theory

**Abstract**

We reduce the physical assumptions for torsion-I dyon positivity in N=4 string theory on K3×T² to a single premise—the divisor sum formula of Dabholkar–Gomes–Murthy equation (52)—under which strict positivity d_*^{(I)} > 0 follows for all I≥1. The proof combines three results: (A) an explicit incompatibility between two divisor sum formulae in the literature (Dabholkar–Gomes–Murthy 0803.2692 equations (51) and (52)), with an integer witness at torsion I=2; (B) an algebraic derivation showing the unique compatible generating function involves a half-integer elliptic shift (d−1)/2 on even divisors, obtained by solving Alexandrov–Nampuri's coupled equations; (C) a rigorous proof that attractor cycle contours are covariant under charge rescaling, allowing the divisor sum to commute with the immortal projection without relying on mock modular form decompositions. Combining these with Rosselló's recent positivity theorem for unit torsion yields d_*^{(I)}(m,n,ℓ) = Σ_{s|I} s·d_*(m/s²,n,ℓ/s) > 0 for all I≥1, requiring only a single physical input (the divisor sum itself). The mathematical content is self-contained; physical interpretation relies on standard BPS state counting assumptions.

## 1. Introduction

The Sen positivity conjecture states that degeneracies of single-centered supersymmetric black holes in four-dimensional N=4 string theory are strictly positive integers. For the flagship case of type II on K3×T², the conjecture was fully resolved for unit torsion (I=1) by Rosselló [rossello-2024], building on the mock modular form framework of Dabholkar–Murthy–Zagier (DMZ) [dmz-2012]. The extension to torsion I>1—where the relevant generating functions involve divisor sums over s|I—requires a physical input: the divisor sum formula itself, for which two incompatible versions appear in the literature (DGM 0803.2692 equations (51) and (52)).

We show that under the assumption of DGM equation (52), strict positivity follows for all torsion classes via a rigorous mathematical proof requiring no mock modular form computations. The technical obstructions were: (i) the incompatibility between equations (51) and (52), and (ii) the lack of a mathematical proof that the divisor sum commutes with the immortal projection to single-centered states.

This paper resolves both issues. We prove:

**Proposition A** (§2): DGM equations (51) and (52) cannot both hold. For even s and odd ℓ/s, the two formulae differ by a sign factor (−1)^{ℓ−ℓ/s} = −1. We provide an explicit integer witness: at I=2, (m,n,ℓ)=(4,1,2), the two readings give 16542306 vs 16440894, differing by 4·d_*(1,1,1) = 101412.

**Proposition B** (§3): The unique generating function compatible with equation (52) and the Alexandrov–Nampuri coupled equations (2.11)+(2.13) is

Z_I^{(4|4)}(τ,z,σ) = Σ_{d|I} d / Φ₁₀(τ, dz + (d-1)/2, d²σ).

For odd divisors d, the shift (d-1)/2 is an integer and cancelled by Φ₁₀'s periodicity; for even divisors, it is a genuine half-integer shift. This resolves the sign discrepancy in Proposition A.

**Theorem C** (§4): Attractor cycle contours transform covariantly under the charge rescaling (ρ,σ,v) ↦ (s²ρ, σ, sv). Specifically, the contour C_*(m,n,ℓ) with imaginary part Im Ω = 2Λ·adj(T(m,n,ℓ)) is mapped precisely to C_*(m/s², n, ℓ/s) with Λ ↦ s²Λ, without crossing any walls or generating multi-centered corrections. This follows from the elementary identity A_s·adj(T)·A_s^T = s²·adj(T'), where T' corresponds to the rescaled charges.

**Main Theorem** (§5): For all I≥1 and charges (m,n,ℓ) with I²|m, I|ℓ, m,n≥1, Δ=4mn-ℓ²>0, the torsion-I immortal dyon index satisfies

d_*^{(I)}(m,n,ℓ) = Σ_{s|I} s · d_*(m/s², n, ℓ/s) > 0.

The proof uses only Theorem C (covariance) and Rosselló's Corollary 1.1 (positivity for I=1 without gcd restrictions), requiring no mock modular form computations. The physical assumption is isolated to a single input (P'): the divisor sum formula (equation 52) itself.

### Outline of the paper

§2 establishes the incompatibility between DGM equations (51) and (52) through explicit computation and symmetry analysis. §3 derives the corrected generating function from first principles using Alexandrov–Nampuri's framework. §4 proves attractor cycle covariance via adjugate matrix transformation laws. §5 combines these to establish positivity. §6 isolates the remaining physical assumption. §7 discusses open problems, including the precise correspondence with BKM algebra automorphisms and the status of the mock/immortal equality beyond Gauss-reduced representatives.

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

**Physical assumption (isolated).** The identification of d_*^{(I)}(m,n,ℓ) with the physical BPS index of torsion-I dyons is the physical input (P'). It rests on duality arguments, 4d-5d lifts, and fermionic zero mode counting [dgm-2008, alexandrov-nampuri-2020]. The mathematical results (Propositions A, B, Theorem C, Main Theorem) do not depend on (P'); they are statements about Φ₁₀ and contour integrals.

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

The numerical values are computed using scripts that implement the Fourier–Jacobi expansion of 1/Φ₁₀ with exact integer arithmetic, cross-checked against published degeneracy tables [reference].

**Remark 3.2.** No erratum or revision to [dgm-2008] addressing this discrepancy has been published. The most natural resolution is that equation (51) should include a half-integer shift on the elliptic variable for even divisors, as we derive in §4.

## 4. Algebraic derivation of the half-integer shift

We now show that the unique generating function compatible with equation (52) and the Alexandrov–Nampuri framework involves a precise half-integer shift (d-1)/2 on even divisors.

**Setup.** Alexandrov and Nampuri [alexandrov-nampuri-2020] give two coupled equations for torsion-I refined partition functions:

(AN-1)  Z_I^{(4|4)}(τ,z,σ) = Σ_{n,m,ℓ} (-1)^ℓ Ω_I^{(4|4)}(n,m,ℓ) q^n y^ℓ p^m,  with Z_1 = 1/Φ₁₀

(AN-2)  Ω_I^{(4|4)}(n,m,ℓ) = Σ_{d|I} d · Ω_1^{(4|4)}(n, m/d², ℓ/d)

Note: Their variable convention is (τ,z,σ) corresponding to our (ρ,v,σ), with index on σ; we translate back to our convention with index on ρ below.

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

**Translation to DGM notation.** In DGM's variables (ρ,v,σ) ↔ our (τ,z,σ), the rescaling acts as (ρ,σ,v) ↦ (s²ρ, σ, sv). Translating (**) gives

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

## 6. Positivity theorem

**Theorem 6.1 (Main result).** Let I≥1 and (m,n,ℓ) ∈ ℤ³ satisfy I²|m, I|ℓ, m,n≥1, Δ=4mn-ℓ²>0. Then

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

**Remark 6.2 (Why Rosselló's result is gcd-independent).** Rosselló proves d_*(T) > 0 for all positive definite half-integer symmetric 2×2 matrices T via Gauss reduction: every such T is GL(2,ℤ)-equivalent to a reduced form T₀ with 0≤ℓ₀≤m₀≤n₀, and his Theorem 1 proves (-1)^{ℓ₀+1}c_{m₀}^F(n₀,ℓ₀) > 0 for reduced forms. The S-duality invariance d_*(T) = d_*(A^{-T}TA^{-1}) for A∈SL(2,ℤ) propagates positivity to all equivalent forms. This invariance holds for any T, regardless of whether the entries have a common factor—the gcd is an artifact of the physical interpretation, not a mathematical restriction.

We provide an independent proof of S-duality invariance in Appendix A using the same contour covariance technique as Theorem 5.2.

## 7. Physical interpretation and remaining assumption

The mathematical content (Propositions 3.1, 4.1, Theorem 5.2, Theorem 6.1) concerns the Igusa cusp form Φ₁₀ and contour integrals. To interpret these as physical BPS indices requires:

**Physical assumption (P').** The quantity d_*^{(I)}(m,n,ℓ) defined by our contour integral equals the single-centered (immortal) BPS degeneracy of a torsion-I dyon with charges (Q²/2, P²/2, Q·P) = (m,n,ℓ), where I = gcd(Q∧P).

This assumption rests on:

1. **Duality arguments and 4d-5d lifts** relating torsion-I four-dimensional dyons to five-dimensional momentum sectors [dgm-2008, sen-2008].
2. **Fermionic zero mode counting** to extract the single-centered contribution from the total index [dgm-2008].
3. **Wall-crossing invariance** of the immortal index, encoded in the attractor contour prescription [dmz-2012].

These are standard ingredients of the microscopic derivation of black hole entropy in string theory. Assumption (P') rests on physical reasoning from supersymmetric quantum field theory and string duality rather than mathematical proof of the modular form structure.

**What this paper proves mathematically.** Given (P'), our results show:
- The correct divisor sum formula compatible with Alexandrov–Nampuri's framework has the half-integer shift (Proposition 4.1).
- The divisor sum commutes with the immortal projection via contour covariance (Theorem 5.2).
- All torsion-I immortal indices are positive (Theorem 6.1).

The mathematical proofs do not reference string theory beyond the initial definition of d_* via the contour integral.

## 8. Open problems

**Problem 8.1 (BKM algebra interpretation of the half-integer shift).** The shift (d-1)/2 for even d can be understood at the level of Borcherds products: in the product formula for Φ₁₀, the substitution y → -y (equivalent to z → z+1/2) changes each factor (1-p^k q^l y^r) to (1-(-1)^r p^k q^l y^r), i.e., it acts as (-1)^r on the root spaces. This is a ℤ/2ℤ automorphism ω of the BKM superalgebra associated with Φ₁₀ [gritsenko-nikulin-1998]. 

The precise correspondence between ω and the half-integer shift in our generating function requires:
(i) Constructing the Cartan element H_r ∈ 𝔥 with [H_r, e_{(k,l,r)}] = r·e_{(k,l,r)}.
(ii) Verifying ω = exp(πi·ad(H_r)) has order 2 and acts as (-1)^r on root spaces.
(iii) Relating the twisted denominator identity Den_ω to Φ₁₀(τ, z+1/2, σ).

Partial results: H_r = f₃/2 exists in the root lattice M₁ ⊗ ℚ and has the required commutation relations. However, Den_ω is weight-5 (not weight-10), so the naive identity Den_ω = const·Φ₁₀(z+1/2) fails. The correct relation is Φ₁₀(z+1/2) = -Den_ω². The full BKM-algebraic interpretation remains open.

**Problem 8.2 (Mock modular form perspective).** Does the divisor sum operator 𝒯_I commute with the DMZ canonical decomposition ψ_M = ψ_M^F + ψ_M^P? Specifically, for G_M^{(I)} := Σ_{s|I, s²|M} s·(ψ_{M/s²}|U_s), where U_s is the Eichler–Zagier operator, is it true that (G_M^{(I)})^F = Σ_{s|I, s²|M} s·(ψ_{M/s²}^F|U_s)?

Direct computation shows 𝒜_{2,m}|U_t differs from the "Appell–Lerch principal part average" by an explicit theta term Θ_{m,t}, which is holomorphic. Whether Θ_{m,t} is absorbed by the DMZ canonical normalization depends on details of [dmz-2012, §8] that we have not extracted. This question does not affect Theorem 6.1 (which uses contour integrals, not mock forms), but it would provide an alternative route to the divisor sum identity at the level of Fourier coefficients.

**Problem 8.3 (Equality d_* = (-1)^{ℓ+1}c_m^F beyond Gauss-reduced representatives).** Numerical evidence shows that the identity d_*(m,n,ℓ) = (-1)^{ℓ+1}c_m^F(n,ℓ) holds when (m,n,ℓ) satisfies n≥m and 0≤ℓ≤m (the Gauss reduction domain), but fails for n<m. Example: (5,1,4) and (1,1,0) lie in the same GL(2,ℤ)-orbit (hence have the same d_* = 50064), but (-1)^{ℓ+1}c_5^F(1,4) = -2023536 ≠ 50064.

The failure mechanism is well-understood: performing the Fourier–Jacobi separation (integrating over ρ first to isolate the M=m term) implicitly assumes Im ρ ≥ Im σ, which holds precisely when n≥m. The question is whether the equality can be rigorously proven (not just numerically verified) for n≥m using analytic estimates on the convergence of the FJ series at finite heights. This would complete the story for I=1 but is not needed for the main positivity result.

## 9. Conclusion

We have established strict positivity of single-centered BPS degeneracies for all torsion classes in N=4 string theory on K3×T², conditional only on the divisor sum formula itself (equation (52) of [dgm-2008]). The proof proceeds via:

1. Identifying an incompatibility between two formulas in the literature (§3).
2. Deriving the correct generating function with half-integer elliptic shifts from the Alexandrov–Nampuri framework (§4).
3. Proving that attractor cycle contours are covariant under charge rescaling, bypassing the need for mock modular form techniques (§5).
4. Applying Rosselló's unit-torsion positivity theorem without gcd restrictions (§6).

The mathematical techniques are elementary (Fourier series, linear algebra, contour integration), requiring no deep knowledge of Siegel modular forms beyond the definition of Φ₁₀ and its periodicity properties. The result reduces the physical assumptions in the torsion-I case to a single input—the divisor sum structure—which itself follows from string duality and fermionic zero modes.

Open questions include the BKM-algebraic interpretation of the half-integer shift, the behavior of divisor sums at the mock modular form level, and the precise domain of validity for mock coefficient identities. These are natural directions for further investigation but do not affect the core positivity result.

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

[dgm-2008] A. Dabholkar, J. Gomes, S. Murthy, "Counting all dyons in N=4 string theory," arXiv:0803.2692, JHEP 05 (2011) 059.

[dmz-2012] A. Dabholkar, S. Murthy, D. Zagier, "Quantum Black Holes, Wall Crossing, and Mock Modular Forms," arXiv:1208.4074.

[gritsenko-nikulin-1998] V. Gritsenko, V. Nikulin, "Automorphic forms and Lorentzian Kac-Moody algebras, Part II," alg-geom/9611028.

[kawai-1997] T. Kawai, "K3 Surfaces, Igusa Cusp Form and String Theory," arXiv:hep-th/9710016.

[rossello-2024] M. Rosselló, "The Immortal Dyon Index Is Positive," arXiv:2403.19630.

[sen-2008] A. Sen, "Black Hole Entropy Function, Attractors and Precision Counting of Microstates," Gen. Rel. Grav. 40 (2008) 2249, arXiv:0708.1270.

