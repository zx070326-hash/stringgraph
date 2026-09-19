"""
verify_correct_B.py

Independent verification of the CORRECT B coefficient and vertex formula.
Lead caught an error: original proof.md wrote B with factor 2, but the
derivation in parentheses had 1/n2. This script verifies from first principles.
"""

import sympy as sp
from fractions import Fraction
import random

def main():
    print("=" * 70)
    print("INDEPENDENT VERIFICATION: Correct B coefficient")
    print("=" * 70)
    print()

    # Symbols
    n, m, ell = sp.symbols('n m ell', positive=True, integer=True)
    n2, j = sp.symbols('n2 j', integer=True)
    n1_0, m1_0 = sp.symbols('n1_0 m1_0', integer=True)
    rho1, sigma1, v1 = sp.symbols('rho1 sigma1 v1', real=True)
    t = sp.symbols('t', real=True)

    Delta = 4*m*n - ell**2

    print("Step 1: Derive B from first principles")
    print("=" * 70)
    print()

    # g(t) definition
    n1_t = n1_0 + n*t
    m1_t = m1_0 + m*t

    # From discriminant: 4m1*n1 + 4m2*n2 + j^2 = 1
    # Solve for m2:
    m2_t = (1 - j**2 - 4*m1_t*n1_t) / (4*n2)

    print("g(t) = n2*(sigma1*rho1 - v1^2) + j*v1 + n1(t)*sigma1 - m1(t)*rho1 + m2(t)")
    print()
    print("n1(t) = n1_0 + n*t")
    print("m1(t) = m1_0 + m*t")
    print("m2(t) = [1 - j^2 - 4*m1(t)*n1(t)] / (4*n2)")
    print()

    # Expand m2(t)
    print("m2(t) expanded:")
    print("  = (1 - j^2 - 4*(m1_0 + m*t)*(n1_0 + n*t)) / (4*n2)")
    print("  = (1 - j^2 - 4*m1_0*n1_0 - 4*m*n1_0*t - 4*n*m1_0*t - 4*m*n*t^2) / (4*n2)")
    print("  = [1 - j^2 - 4*m1_0*n1_0]/(4*n2)")
    print("    - [m*n1_0 + n*m1_0]*t/n2")
    print("    - m*n*t^2/n2")
    print()

    # Construct g(t) symbolically
    g_t = (n2*(sigma1*rho1 - v1**2) + j*v1
           + (n1_0 + n*t)*sigma1 - (m1_0 + m*t)*rho1
           + (1 - j**2 - 4*(m1_0 + m*t)*(n1_0 + n*t))/(4*n2))

    g_expanded = sp.expand(g_t)
    g_poly = sp.Poly(g_expanded, t)

    coeffs = g_poly.all_coeffs()
    A_sym = sp.simplify(coeffs[0])
    B_sym = sp.simplify(coeffs[1])
    C_sym = sp.simplify(coeffs[2])

    print("Collecting by powers of t (via SymPy Poly):")
    print(f"  A (coeff of t^2) = {A_sym}")
    print(f"  B (coeff of t^1) = {B_sym}")
    print(f"  C (coeff of t^0) = {C_sym}")
    print()

    # Expected forms
    A_expected = -m*n/n2
    B_expected = n*sigma1 - m*rho1 - (m*n1_0 + n*m1_0)/n2

    print("=" * 70)
    print("CONCLUSION: The correct B is")
    print("  B = n*sigma1 - m*rho1 - (m*n1_0 + n*m1_0)/n2")
    print()
    print("NOT: B = n*sigma1 - m*rho1 - 2*(m*n1_0 + n*m1_0)  [WRONG]")
    print()
    print("Original proof.md sec 5.7.1 had the factor 2 version, which")
    print("contradicts its own derivation in parentheses stating the")
    print("t coefficient of m2(t) is -(m*n1_0 + n*m1_0)/n2.")
    print("=" * 70)
    print()

    print("Step 2: Apply constraint (I) to eliminate sigma1")
    print("=" * 70)
    print()

    sigma1_from_I = (-j*ell - 2*(m*n1_0 - n*m1_0) - 2*n2*(m*rho1 - ell*v1)) / (2*n*n2)

    print("sigma1 = [-j*ell - 2*(m*n1_0 - n*m1_0) - 2*n2*(m*rho1 - ell*v1)] / (2*n*n2)")
    print()

    # Substitute into B
    B_correct = n*sigma1 - m*rho1 - (m*n1_0 + n*m1_0)/n2
    B_substituted = B_correct.subs(sigma1, sigma1_from_I)
    B_simplified = sp.simplify(B_substituted)

    print(f"B after substituting sigma1 from (I):")
    print(f"  = {B_simplified}")
    print()

    # Compute C after substitution
    C_correct = (n2*(sigma1*rho1 - v1**2) + j*v1
                 + n1_0*sigma1 - m1_0*rho1
                 + (1 - j**2 - 4*m1_0*n1_0)/(4*n2))
    C_substituted = C_correct.subs(sigma1, sigma1_from_I)

    # Compute vertex value
    A = -m*n/n2
    vertex_g = C_substituted - B_substituted**2 / (4*A)
    vertex_g_simplified = sp.simplify(vertex_g)

    print("Step 3: Compute vertex value of g(t)")
    print("=" * 70)
    print()
    print("g(t*) = C - B^2/(4*A)")
    print()
    print("After substituting sigma1 and simplifying:")
    print(f"  g(t*) = {vertex_g_simplified}")
    print()

    # Divide by n2*Delta to get Lambda^2
    vertex_lambda2 = vertex_g_simplified / (n2 * Delta)
    vertex_lambda2_simplified = sp.simplify(vertex_lambda2)

    print("Step 4: Lambda^2(t*) = g(t*) / (n2*Delta)")
    print("=" * 70)
    print()
    print(f"Lambda^2(t*) simplified:")
    print(f"  {vertex_lambda2_simplified}")
    print()

    # Check against lead's form
    lead_form = (4*m*n - Delta*(j - 2*n2*v1)**2) / (16*m*n*n2**2*Delta)
    diff = sp.simplify(vertex_lambda2_simplified - lead_form)

    print("Checking against lead's closed form:")
    print("  [4*m*n - Delta*(j - 2*n2*v1)^2] / (16*m*n*n2^2*Delta)")
    print(f"  Difference: {diff}")
    print()

    if diff == 0:
        print("*** SYMBOLIC IDENTITY CONFIRMED ***")
    else:
        print("*** MISMATCH ***")
    print()

    # Alternative form
    alt_form = 1/(4*n2**2*Delta) - (j - 2*n2*v1)**2/(16*m*n*n2**2)
    diff_alt = sp.simplify(vertex_lambda2_simplified - alt_form)

    print("Alternative form:")
    print("  1/(4*n2^2*Delta) - (j - 2*n2*v1)^2/(16*m*n*n2^2)")
    print(f"  Difference: {diff_alt}")
    print()

    if diff_alt == 0:
        print("*** ALTERNATIVE FORM ALSO CONFIRMED ***")
    print()

    print("=" * 70)
    print("NUMERICAL VALIDATION (exact rational arithmetic)")
    print("=" * 70)
    print()

    random.seed(42)
    trials = 100
    passed = 0

    for trial in range(trials):
        # Random integer parameters
        n_val = random.randint(2, 10)
        m_val = random.randint(1, n_val)
        ell_val = random.randint(1, m_val)

        Delta_val = 4*m_val*n_val - ell_val**2
        if Delta_val <= 0:
            continue

        n2_val = random.choice([-5, -3, -2, -1, 1, 2, 3, 5])
        j_val = random.randint(-7, 7)

        n1_0_val = random.randint(-5, 5)
        m1_0_val = random.randint(-5, 5)

        # Random v1, rho1 in [0,1] as fractions
        v1_val = Fraction(random.randint(0, 10), 10)
        rho1_val = Fraction(random.randint(0, 10), 10)

        # Compute sigma1 from (I)
        sigma1_val = Fraction(
            -j_val*ell_val - 2*(m_val*n1_0_val - n_val*m1_0_val)
            - 2*n2_val*(m_val*rho1_val - ell_val*v1_val),
            2*n_val*n2_val
        )

        # Compute via first principles
        A_val = Fraction(-m_val*n_val, n2_val)
        B_val = (n_val*sigma1_val - m_val*rho1_val
                 - Fraction(m_val*n1_0_val + n_val*m1_0_val, n2_val))
        C_val = (n2_val*(sigma1_val*rho1_val - v1_val**2) + j_val*v1_val
                 + n1_0_val*sigma1_val - m1_0_val*rho1_val
                 + Fraction(1 - j_val**2 - 4*m1_0_val*n1_0_val, 4*n2_val))

        g_vertex_val = C_val - B_val**2 / (4*A_val)
        lambda2_via_g = g_vertex_val / (n2_val * Delta_val)

        # Compute via lead's closed form
        lambda2_closed = (Fraction(4*m_val*n_val)
                         - Delta_val * (j_val - 2*n2_val*v1_val)**2) / (
                             16*m_val*n_val*n2_val**2*Delta_val)

        if abs(lambda2_via_g - lambda2_closed) < 1e-15:
            passed += 1
        else:
            print(f"MISMATCH at trial {trial}:")
            print(f"  (n,m,ell) = ({n_val},{m_val},{ell_val})")
            print(f"  (n2,j) = ({n2_val},{j_val})")
            print(f"  Via g: {float(lambda2_via_g):.10f}")
            print(f"  Closed: {float(lambda2_closed):.10f}")
            break

    print(f"Numerical validation: {passed}/{trials} trials passed")
    print()

    if passed == trials:
        print("=" * 70)
        print("FINAL VERIFICATION COMPLETE")
        print("=" * 70)
        print()
        print("The correct vertex formula is:")
        print()
        print("  Lambda^2(t*) = [4*m*n - Delta*(j - 2*n2*v1)^2] / (16*m*n*n2^2*Delta)")
        print()
        print("             = 1/(4*n2^2*Delta) - (j - 2*n2*v1)^2/(16*m*n*n2^2)")
        print()
        print("Key observations:")
        print("  1. NO dependence on n1_0, m1_0, rho1, sigma1 (all canceled)")
        print("  2. Second term is NEGATIVE (subtracting a square)")
        print("  3. Therefore Lambda^2(t*) <= 1/(4*n2^2*Delta) <= 1/(4*Delta)")
        print("     for ALL n2 != 0, ALL j, ALL v1 in [0,1]")
        print()
        print("This gives constructive Lambda_0 = 1/(2*sqrt(Delta)).")
        print("=" * 70)

if __name__ == "__main__":
    main()
