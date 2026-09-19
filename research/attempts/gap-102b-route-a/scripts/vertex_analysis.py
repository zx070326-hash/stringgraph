"""
vertex_analysis.py

Symbolic analysis of the vertex height to find cancellation mechanism.
"""

import sympy as sp

def main():
    print("=== Vertex value symbolic expansion ===")
    print()

    # Symbols
    n, m, ell = sp.symbols('n m ell', positive=True, integer=True)
    n2, j = sp.symbols('n2 j', integer=True)
    n1_0, m1_0 = sp.symbols('n1_0 m1_0', integer=True)
    rho1, sigma1, v1 = sp.symbols('rho1 sigma1 v1', real=True)
    t = sp.symbols('t', real=True)

    Delta = 4*m*n - ell**2

    # Shift
    n1 = n1_0 + n*t
    m1 = m1_0 + m*t

    # Discriminant forces m2
    m2 = (1 - j**2 - 4*m1*n1) / (4*n2)

    # g(t) from proof.md Lemma 1
    g = n2*(sigma1*rho1 - v1**2) + j*v1 + n1*sigma1 - m1*rho1 + m2

    # Expand g as polynomial in t
    g_expanded = sp.expand(g)
    g_poly = sp.Poly(g_expanded, t)

    print("g(t) as polynomial in t:")
    print(f"  degree: {g_poly.degree()}")
    coeffs = g_poly.all_coeffs()

    A_g = sp.simplify(coeffs[0])
    B_g = sp.simplify(coeffs[1]) if len(coeffs) > 1 else 0
    C_g = sp.simplify(coeffs[2]) if len(coeffs) > 2 else 0

    print(f"  A (t^2): {A_g}")
    print(f"  B (t^1): {B_g}")
    print(f"  C (t^0): {C_g}")
    print()

    # Verify A
    expected_A = -m*n/n2
    assert sp.simplify(A_g - expected_A) == 0
    print("Check: A = -mn/n2 (proof.md sec 5.6.1)")
    print()

    # Vertex value of g(t) = C - B^2/(4A)
    vertex_g = C_g - B_g**2 / (4*A_g)
    vertex_g_simplified = sp.simplify(vertex_g)

    print("Vertex value of g(t) = C - B^2/(4A):")
    print(f"  {vertex_g_simplified}")
    print()

    # Vertex height in Lambda^2 = g(t*)/(n2*Delta)
    vertex_lambda2 = vertex_g_simplified / (n2 * Delta)
    vertex_lambda2_simplified = sp.simplify(vertex_lambda2)

    print("Vertex height Lambda^2 = [C - B^2/(4A)] / (n2*Delta):")
    print(f"  {vertex_lambda2_simplified}")
    print()

    # Use equation (I) to eliminate sigma1
    sigma1_from_I = (-j*ell - 2*m*n1_0 + 2*n*m1_0 - n2*(2*m*rho1 - 2*ell*v1)) / (2*n*n2)

    print("Substituting sigma1 from equation (I)...")
    vertex_with_I = vertex_lambda2_simplified.subs(sigma1, sigma1_from_I)
    vertex_with_I_simplified = sp.simplify(vertex_with_I)

    print("After substitution and simplification:")
    print(f"  {vertex_with_I_simplified}")
    print()

    # Check scaling with n2
    print("Analyzing scaling with n2:")
    vertex_expanded = sp.expand(vertex_with_I_simplified)
    vertex_poly_n2 = sp.Poly(vertex_expanded, n2)
    
    print(f"  Degree in n2: {vertex_poly_n2.degree()}")
    
    if vertex_poly_n2.degree() >= 0:
        coeffs_n2 = vertex_poly_n2.all_coeffs()
        for i, coeff in enumerate(coeffs_n2):
            power = vertex_poly_n2.degree() - i
            simplified_coeff = sp.simplify(coeff)
            print(f"  Coeff of n2^{power}: {simplified_coeff}")
    print()

    print("=" * 70)
    print("CONCLUSION:")
    if vertex_poly_n2.degree() > 0:
        leading = sp.simplify(coeffs_n2[0])
        print(f"  Leading power of n2: {vertex_poly_n2.degree()}")
        print(f"  Leading coefficient: {leading}")
        print()
        print("  Analysis: If nonzero and unbounded in (n1_0, m1_0),")
        print("  vertex height grows with n2. Need to bound this term.")
    elif vertex_poly_n2.degree() == 0:
        print(f"  Vertex height is independent of n2!")
        print(f"  Constant term: {sp.simplify(coeffs_n2[0])}")
        print("  This directly bounds Lambda^2, proving [GAP-n2].")
    else:
        print(f"  Vertex height decays as O(1/n2^k) for some k > 0.")
        print("  This also bounds Lambda^2, proving [GAP-n2].")
    print("=" * 70)

if __name__ == "__main__":
    main()
