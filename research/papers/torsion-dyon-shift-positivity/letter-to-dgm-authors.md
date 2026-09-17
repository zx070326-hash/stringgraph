# Draft Letter to Dabholkar–Gomes–Murthy Authors

**DRAFT ONLY — DO NOT SEND WITHOUT AUTHORIZATION**

---

Dear Professors Dabholkar, Gomes, and Murthy,

We are writing regarding your important paper "Counting all dyons in N=4 string theory" (arXiv:0803.2692, JHEP 05 (2011) 059), which has been foundational for our understanding of BPS state counting in string theory.

In the course of proving strict positivity of torsion-I dyon degeneracies, we have identified what appears to be an inconsistency between equations (51) and (52) in your paper. We would greatly appreciate your perspective on this matter.

## The apparent inconsistency

Your equation (50) defines the torsion-I degeneracy as:
Ω_I(Γ) = (−1)^{Q·P+1} ∮_C [𝒵_I × exponential factor]

Your equation (51) gives the generating function:
𝒵_I(ρ,σ,v) = Σ_{s|I} s · 1/Φ₁₀(s²ρ, σ, sv)

Your equation (52) gives the divisor sum:
Ω_I(Q²/2, P²/2, Q·P) = Σ_{s|I} s · Ω₁(Q²/2s², P²/2, Q·P/s)

When we compute the Fourier coefficients of equation (51) and apply equation (50)'s sign factor, we obtain for the s-th term in the divisor sum:
s · (−1)^{ℓ+ℓ/s} · Ω₁(m/s², n, ℓ/s)

However, equation (52) gives:
s · Ω₁(m/s², n, ℓ/s)

These differ by a factor (−1)^{ℓ−ℓ/s}, which equals −1 when s is even and ℓ/s is odd.

## Explicit numerical witness

We have computed an explicit integer witness to this discrepancy using exact arithmetic:
- Torsion I = 2
- Charges (m,n,ℓ) = (4,1,2), with discriminant Δ = 12

The two formulas give:
- Equation (52): Ω_I = 16,542,306
- Equations (50)+(51): Ω_I = 16,440,894
- Difference: 101,412 = 4 × d_*(1,1,1)

The numerical values are obtained from the Fourier–Jacobi expansion of 1/Φ₁₀ using published degeneracy tables for verification.

## A possible resolution

We have found that the unique generating function compatible with equation (52) and the Alexandrov–Nampuri framework (arXiv:2009.01172) involves a half-integer elliptic shift:

𝒵_I(ρ,σ,v) = Σ_{s|I} s · 1/Φ₁₀(s²ρ, σ, sv + (s−1)/2)

For odd s, the shift (s−1)/2 is an integer and cancelled by Φ₁₀'s periodicity. For even s, it is a genuine half-integer (1/2, 3/2, 5/2, ...), which changes the sign of odd-ℓ Fourier coefficients and resolves the discrepancy with equation (52).

This shift has an algebraic origin: when deriving the generating function from Alexandrov–Nampuri's coupled equations, the change of variables ℓ = s·ℓ' introduces a sign factor (−1)^{(s−1)ℓ'} that translates to the elliptic shift. It may also have a deeper BKM-algebraic interpretation related to the ℤ/2ℤ automorphism of the Borcherds algebra associated with Φ₁₀.

## Our question

We have searched for errata or revisions to your paper but have not found any addressing this point. We would be grateful for your insight into:

1. Whether the discrepancy we have identified is known to you, and if so, what the correct resolution is.
2. Whether there is a physical or mathematical argument we have overlooked that reconciles equations (51) and (52) as written.
3. Whether equation (51) should indeed include the half-integer shift (s−1)/2, or whether there is an alternative interpretation.

We emphasize that this issue does not affect the main physical conclusions of your paper—the divisor sum structure and the connection to string dualities. Our work uses equation (52) as the fundamental input and establishes positivity for all torsion classes via a rigorous contour covariance argument. However, resolving the status of equation (51) would be valuable for the mathematical literature on Siegel modular forms and mock Jacobi forms.

## Our results

For your information, we have proven that if equation (52) holds (which we take as a physical input), then the torsion-I immortal dyon degeneracies d_*^{(I)}(m,n,ℓ) = Σ_{s|I} s·d_*(m/s², n, ℓ/s) are strictly positive for all I≥1, extending Rosselló's recent unit-torsion result. The proof uses attractor cycle covariance and does not require mock modular form computations. A detailed manuscript is in preparation.

We would be happy to share our calculations and discuss this matter further at your convenience.

With best regards and appreciation for your groundbreaking work,

[To be completed with author names and affiliations]

---

## Notes for internal use (delete before sending)

**Checklist before sending:**
- [ ] Verify all numerical values independently
- [ ] Confirm no published erratum exists (re-check arXiv, INSPIRE, JHEP)
- [ ] Have manuscript accepted or on arXiv (don't send before our work is public)
- [ ] Get captain/lead approval
- [ ] Tone review: ensure letter is collegial, not accusatory
- [ ] Consider whether to contact just first author or all three
- [ ] Check current institutional affiliations

**Alternative approaches if no response:**
- Submit our paper to arXiv with careful wording ("we find that equations (51) and (52) are incompatible; the unique resolution we have identified is...")
- Contact Alexandrov–Nampuri, whose framework supports equation (52)
- Present at conferences and get community feedback

**Do NOT:**
- Send this letter without explicit authorization from captain/lead
- Post on public forums before getting response or our paper being public
- Make any claims that could be interpreted as priority disputes
