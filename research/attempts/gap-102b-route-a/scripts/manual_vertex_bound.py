"""
manual_vertex_bound.py

Manual analysis of the vertex height formula discovered by vertex_analysis.py.
The key insight: after substituting sigma1 from (I), the vertex height becomes
a rational function where BOTH numerator and denominator have n2^2, suggesting
the n2 dependence cancels in the leading order.
"""

import sympy as sp

def main():
    print("=== Manual vertex height bound analysis ===")
    print()
    
    # From vertex_analysis.py output (before it crashed on Poly):
    # Numerator: ell^2*j^2/16 - ell^2*j*n2*v1/4 + ell^2*n2^2*v1^2/4 
    #            - j^2*m*n/4 + j*m*n*n2*v1 - m*n*n2^2*v1^2 + m*n/4
    # Denominator: m*n*n2^2*(-ell^2 + 4*m*n) = m*n*n2^2*Delta
    
    n, m, ell = sp.symbols('n m ell', positive=True)
    n2, j = sp.symbols('n2 j', integer=True)
    v1 = sp.symbols('v1', real=True)
    
    Delta = 4*m*n - ell**2
    
    # The numerator (from SymPy output)
    numerator = (ell**2*j**2/16 - ell**2*j*n2*v1/4 + ell**2*n2**2*v1**2/4 
                 - j**2*m*n/4 + j*m*n*n2*v1 - m*n*n2**2*v1**2 + m*n/4)
    
    denominator = m*n*n2**2*Delta
    
    vertex_lambda2 = numerator / denominator
    
    print("Vertex Lambda^2 (after substituting sigma1 from (I)):")
    print(f"  Numerator: {numerator}")
    print(f"  Denominator: {denominator}")
    print()
    
    # Collect numerator by powers of n2
    num_expanded = sp.expand(numerator)
    print("Numerator expanded and collected by n2:")
    
    # Manual extraction of coefficients
    # Coefficient of n2^2:
    coeff_n2_2 = ell**2*v1**2/4 - m*n*v1**2
    coeff_n2_2_simplified = sp.simplify(coeff_n2_2)
    print(f"  Coeff of n2^2: {coeff_n2_2_simplified}")
    print(f"    = {sp.factor(coeff_n2_2_simplified)}")
    
    # Coefficient of n2^1:
    coeff_n2_1 = -ell**2*j*v1/4 + j*m*n*v1
    coeff_n2_1_simplified = sp.simplify(coeff_n2_1)
    print(f"  Coeff of n2^1: {coeff_n2_1_simplified}")
    print(f"    = {sp.factor(coeff_n2_1_simplified)}")
    
    # Coefficient of n2^0:
    coeff_n2_0 = ell**2*j**2/16 - j**2*m*n/4 + m*n/4
    coeff_n2_0_simplified = sp.simplify(coeff_n2_0)
    print(f"  Coeff of n2^0: {coeff_n2_0_simplified}")
    print(f"    = {sp.factor(coeff_n2_0_simplified)}")
    print()
    
    # Now divide by n2^2*m*n*Delta to get Lambda^2
    print("After dividing by n2^2 * m*n*Delta:")
    print(f"  Lambda^2 = [coeff_n2^2/1 + coeff_n2^1/n2 + coeff_n2^0/n2^2] / (m*n*Delta)")
    print()
    
    # Leading term (constant in n2):
    leading_term = coeff_n2_2_simplified / (m*n*Delta)
    leading_simplified = sp.simplify(leading_term)
    print(f"Leading term (coeff of n2^0 in Lambda^2):")
    print(f"  {leading_simplified}")
    print()
    
    # Check bounds assuming v1 in [0,1], 0 < ell <= m <= n
    print("Bounding the leading term:")
    print(f"  Numerator: v1^2 * (ell^2/4 - m*n) = v1^2 * (ell^2 - 4mn)/4")
    print(f"  Since Delta = 4mn - ell^2 > 0, we have ell^2 - 4mn = -Delta < 0")
    print(f"  So numerator = -v1^2 * Delta / 4")
    print(f"  Leading term = [-v1^2 * Delta / 4] / (m*n*Delta)")
    print(f"               = -v1^2 / (4mn)")
    print()
    print(f"  With v1 in [0,1], |leading term| <= 1/(4mn)")
    print()
    
    # The O(1/n2) term
    next_term = coeff_n2_1_simplified / (m*n*Delta*n2)
    next_simplified = sp.simplify(next_term)
    print(f"Next term (coeff of 1/n2 in Lambda^2):")
    print(f"  {next_simplified}")
    print(f"  = j*v1*(4mn - ell^2) / [4 * m*n*Delta*n2]")
    print(f"  = j*v1*Delta / [4*m*n*Delta*n2]")
    print(f"  = j*v1 / [4*m*n*n2]")
    print(f"  With |j*v1| bounded by |j|, this is O(|j|/n2)")
    print()
    
    # The O(1/n2^2) term  
    last_term = coeff_n2_0_simplified / (m*n*Delta*n2**2)
    last_simplified = sp.simplify(last_term)
    print(f"Last term (coeff of 1/n2^2 in Lambda^2):")
    print(f"  {last_simplified}")
    print(f"  This is O(1/n2^2)")
    print()
    
    print("=" * 70)
    print("CONCLUSION:")
    print("  Vertex Lambda^2 = -v1^2/(4mn) + O(1/n2)")
    print()
    print("  The LEADING term (independent of n2) is BOUNDED:")
    print("    |Lambda^2(t*)| <= 1/(4mn) + O(|j|/|n2|)")
    print()
    print("  For any fixed (m,n), as |n2| -> infinity:")
    print("    Lambda^2(t*) -> -v1^2/(4mn) in [-1/(4mn), 0]")
    print()
    print("  This is EXACTLY what the numerical evidence (proof.md sec 5.6.2)")
    print("  showed: vertex height ~ O(1), NOT growing with n2.")
    print()
    print("  The key cancellation: B^2*n2 term in C + B^2*n2/(4mn) contains")
    print("  a term proportional to n2^2, but C also contains n2^2 terms (from")
    print("  m2 = (1-j^2-4m1*n1)/(4n2) when m1,n1 ~ O(n2)), and they EXACTLY")
    print("  cancel in the leading order after applying constraint (I).")
    print("=" * 70)

if __name__ == "__main__":
    main()
