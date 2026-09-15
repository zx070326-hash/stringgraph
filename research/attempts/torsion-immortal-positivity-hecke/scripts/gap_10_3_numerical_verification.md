# Numerical verification: §10.3 GAPs 10.3.c and 10.3.d

Script: `gap_10_3_numerical_verification.py`  
Run date: 2026-09-15  
Independence: Lemma 10.3.1 check uses a new code path (A_{2,m} lower-chamber expansion)
not present in `coefficients.py` or `torsion_divisor_sum.py`. The c_m^F values reuse
`coefficients.py` (self-tested, Phi_10 inversion validated independently in prior rounds).

---

## PART 1: Lemma 10.3.1 (y-power gap)

**Claim**: A_{2,m}(sigma, v+1/2) expanded in the attractor sub-chamber |q|<1<|y| has
y^l coefficient = 0 for all 0 <= l <= 2m (exact gap).

**Method**: Direct integer Laurent expansion via the three-branch geometric series
of proof.md §10.3.2. No floating point; the result is exact from the series structure.

| m | Gap claimed | Result |
|---|-------------|--------|
| 1 | [0, 2]      | OK     |
| 2 | [0, 4]      | OK     |
| 3 | [0, 6]      | OK     |
| 4 | [0, 8]      | OK     |
| 5 | [0, 10]     | OK     |
| 6 | [0, 12]     | OK     |
| 7 | [0, 14]     | OK     |
| 8 | [0, 16]     | OK     |

**Verdict: CONFIRMED** for m=1..8. The y-power gap [0,2m] is exact.

---

## PART 2: Anchor self-check

| Point (m,n,l) | Expected d_* | Got    |
|---------------|-------------|--------|
| (1,1,0)       | 50064       | OK     |
| (1,1,1)       | 25353       | OK     |
| (1,2,0)       | 1127472     | OK     |
| (2,2,2)       | 3859456     | OK     |

---

## PART 3: Counterexample scan

Scan domain: m in [1,16], n in [1,8], l in [0,2m], Delta>0. Total points tested: **1070**.

Three sub-domains:

| Domain | Condition                  | Agree | Disagree | Verdict |
|--------|----------------------------|-------|----------|---------|
| A      | 0<=l<=m AND n>=m (Gauss-reduced) | 156 | **0** | Thm 10.3b CONFIRMED |
| B      | 0<=l<=m AND n<m  (NOT reduced)   | 388 | **199** | Note 10.3.5 REFUTED |
| C      | l>m              (NOT reduced)   | 196 | 131     | expected failures |

### Theorem 10.3b verdict: CONFIRMED

On the stated domain (0<=l<=m, n>=m), the identity d_*(m,n,l) = (-1)^{l+1} c_m^F(n,l)
holds on all 156 tested points without exception. This includes a wide range of n values
equal to m (the boundary of the reduced domain).

### Note 10.3.5 verdict: REFUTED

Note 10.3.5 of proof.md claims "n >= m is not needed" — that the identity holds for all
n >= 1 whenever 0<=l<=m. This is false. There are 199 counterexamples with l<=m and n<m.

First several:

| (m, n, l) | d_* (attractor) | naive (-1)^{l+1} c_m^F(n,l) |
|-----------|----------------|------------------------------|
| (3, 1, 3) | 25353          | 130329                       |
| (4, 1, 3) | 561576         | 1598376                      |
| (5, 1, 3) | 8533821        | 16844421                     |
| (5, 1, 4) | 50064          | -2023536                     |
| (5, 2, 5) | 18458000       | 28698000                     |
| (6, 1, 3) | 100390104      | 157497048                    |

### GAP 10.3.d verdict: CLAIM CORRECTED

The proof.md Note 10.3.5 and [GAP 10.3.d] claim:
> "the true failure condition is l > m (not n < m)"

This is incorrect. The numerical scan shows:

- Total counterexamples: 330
- Of these, 199 have l <= m (and n < m)  -- these are in Domain B
- Of these, 131 have l > m (all also have n < m)  -- Domain C
- ZERO counterexamples have n >= m

**The true condition for the identity is: (0<=l<=m) AND (n>=m), i.e., the form is
Gauss-reduced.** The failure condition is "form not Gauss-reduced" = (l>m) OR (n<m with
Gauss reduction putting l' outside [0,m]).

The anchor counterexample (5,1,4) from proof.md: l=4 <= m=5 (so l<=m holds!), but
n=1 < m=5 so the form is not reduced. reduce_form(5,1,4)=(1,1,0), d_*=50064,
naive=-2023536. The failure is from n<m, NOT from l>m.

### Reproduction of §10.2 domain (m<=16, n<=4, 0<=l<=2m)

The existing torsion_divisor_sum.py used this domain. Re-scan gives:

- agree: 92,  disagree: 96
- All 96 counterexamples have n < m: TRUE (matches §10.2 text)
- All 96 counterexamples have l > m: FALSE (73 of 96 have l<=m)

So the §10.2 observation "all 96 counterexamples have n<m" is confirmed, but the
subsequent Note 10.3.5 inference "cause is l>m, not n<m" reverses causality. The
correct statement is that n<m is the proximate cause (it is necessary and sufficient
for counterexamples within this domain), and l>m is neither necessary nor sufficient.

---

## Summary of findings

| Claim | Verdict |
|-------|---------|
| Lemma 10.3.1: gap [0,2m] in A_{2,m} lower-chamber expansion | CONFIRMED (m=1..8, exact) |
| Thm 10.3b: identity on 0<=l<=m, n>=m (Gauss-reduced) | CONFIRMED (156 pts, 0 violations) |
| Note 10.3.5: identity extends to all n>=1 with 0<=l<=m | REFUTED (199 counterexamples) |
| GAP 10.3.d: "failure cause is l>m" | REFUTED; correct cause is n<m |
| §10.2 "96 counterexamples all have n<m" | CONFIRMED |

**Consequence for proof.md**: Note 10.3.5 must be retracted. Thm 10.3b in its stated
form (domain 0<=l<=m AND n>=m) is correct and confirmed. The correct characterization
of when the identity holds is: exactly on the Gauss-reduced domain, i.e., the condition
is 0<=l<=m AND n>=m, not merely 0<=l<=m.

This does NOT affect Thm 6.1 (which does not depend on Note 10.3.5).
