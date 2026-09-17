#!/usr/bin/env python3
"""
Numerical verification of the N=6 seed criterion (Blueprint §B⁗.7).

Target: For level-1 state u = sum_μ c_μ α^μ_{-1}|0;p_{-6}⟩, show that
  x₄u ∈ Q_{-6,5} and y₃u ∈ Q_{-6,4} imply u ∈ Q_{-6,1}.

This means: L_m(x₄u) = 0 and L_m(y₃u) = 0 for m ≥ 1 imply L_m(u) = 0 for m ≥ 1.

Strategy:
1. Compute L_1(x₄u) and L_2(x₄u) explicitly for general level-1 u.
2. Compute L_1(y₃u) and L_2(y₃u) explicitly.
3. Show these equations imply L_1(u) = 0 and L_2(u) = 0.
"""

import sympy as sp
from sympy import symbols, expand, simplify, Matrix, solve
from itertools import combinations_with_replacement

# Setup: We work on a Fock space with D dimensions (take D=26 numerically but keep symbolic)
D_sym = sp.Symbol('D', integer=True, positive=True)

# For level-1 state u = sum_μ c_μ α^μ_{-1}|0;p⟩, we need to track the coefficients
# Let's work with a finite-dimensional example first, then verify the pattern

def compute_virasoro_on_vacuum(n, momentum_sq):
    """
    Compute L_n acting on vacuum |0;p⟩ where α'p² = momentum_sq.

    For n ≥ 1: L_n|0;p⟩ = 0 (annihilation)
    For n = 0: L_0|0;p⟩ = (α'p² + N)|0;p⟩ where N is the oscillator number
    """
    if n >= 1:
        return 0
    elif n == 0:
        return momentum_sq  # The level-0 contribution
    else:
        # n < 0: gives creation operators, not relevant for this check
        return None

def test_n6_criterion_level1():
    """
    Test the N=6 criterion for level-1 states numerically.

    At rung j=-6, the momentum is p_{-6} = a - 6b where b² = 0, a·b = 1.
    With mass-shell condition α'k² + j + N = a₀ = 1, at (j,N) = (-6,1) we have α'k² = 6.

    Level-1 state: u = sum_μ c_μ α^μ_{-1}|0;p_{-6}⟩

    The condition u ∈ Q_{-6,1} means L_m u = 0 for all m ≥ 1.
    """
    print("=" * 80)
    print("N=6 Seed Criterion Verification")
    print("=" * 80)

    # For a level-1 state u = c_μ α^μ_{-1}|vac⟩, we have:
    # L_1 u = L_1 (c_μ α^μ_{-1}|vac⟩)
    #       = c_μ [L_1, α^μ_{-1}]|vac⟩ + c_μ α^μ_{-1} L_1|vac⟩
    #       = c_μ (-1) α^μ_0 |vac⟩ + 0
    #       = -c_μ p^μ |vac⟩
    # So L_1 u = 0 ⟺ c_μ p^μ = 0 (i.e., c ⊥ p)

    # L_2 u = L_2 (c_μ α^μ_{-1}|vac⟩)
    #       = c_μ [L_2, α^μ_{-1}]|vac⟩
    #       = c_μ (-2) α^μ_1 |vac⟩
    #       = 0  (since α^μ_1 annihilates the vacuum)
    # So L_2 u = 0 is automatic for level-1 states.

    # Similarly, L_m u = 0 for m ≥ 2 is automatic (gives annihilation operators on vacuum).

    # Therefore: u ∈ Q_{-6,1} ⟺ c · p_{-6} = 0

    print("\nFor level-1 state u = c_μ α^μ_{-1}|0;p_{-6}⟩:")
    print("  u ∈ Q_{-6,1} ⟺ c · p_{-6} = 0")
    print()

    # Now we need to show: x₄u ∈ Q_{-6,5} and y₃u ∈ Q_{-6,4} ⟹ c · p_{-6} = 0

    # The key insight from blueprint §B⁗.7:
    # "这是一条 L_1、L_2 与 x₄, y₃ 的对易子计算，N 无关"

    # We need to compute:
    # (1) What does L_1(x₄ u) = 0 tell us?
    # (2) What does L_1(y₃ u) = 0 tell us?
    # (3) Do these imply c · p = 0?

    print("Strategy:")
    print("  x₄ and y₃ satisfy the syzygy: L_{-1}x₄ + 𝒟₂y₃ = 0")
    print("  where 𝒟₂ = 2L_{-2} + 3L_{-1}²")
    print()
    print("  If x₄u ∈ Q_{-6,5}, then L_m(x₄u) = 0 for m ≥ 1")
    print("  If y₃u ∈ Q_{-6,4}, then L_m(y₃u) = 0 for m ≥ 1")
    print()
    print("  Key observation: Use the syzygy to relate these conditions.")
    print("  Apply L_1 to both sides of L_{-1}x₄ + 𝒟₂y₃ = 0:")
    print("    L_1 L_{-1}(x₄u) + L_1 𝒟₂(y₃u) = 0")
    print()
    print("  Use [L_1, L_{-1}] = 2L_0 (Virasoro commutator, no central term):")
    print("    [L_1, L_{-1}](x₄u) + L_{-1}L_1(x₄u) + L_1𝒟₂(y₃u) = 0")
    print("    2L_0(x₄u) + 0 + L_1𝒟₂(y₃u) = 0   (since L_1(x₄u) = 0)")
    print()
    print("  Now x₄u is level-5, so L_0(x₄u) = (α'p² + 5)(x₄u) = (6 + 5)(x₄u) = 11(x₄u)")
    print("  Thus: 22(x₄u) + L_1𝒟₂(y₃u) = 0")
    print()
    print("  This shows x₄u is determined by derivatives of y₃u.")
    print("  The criterion follows from analyzing commutators [L_m, x₄] and [L_m, y₃]")
    print("  applied to the level-1 seed u.")

    return True

def compute_leading_terms():
    """
    Compute the leading terms of x₄ and y₃.

    From blueprint §B⁗.7:
    - y₃ = 12L_{-3} + 6L_{-2}L_{-1} + L_{-1}³
    - x₄ has leading term -3L_{-1}⁴
    """
    print("\n" + "=" * 80)
    print("Leading Terms Analysis")
    print("=" * 80)

    print("\ny₃ = 12L_{-3} + 6L_{-2}L_{-1} + L_{-1}³")
    print("  (This is the (3,1) singular vector, independent of (c,h))")
    print()
    print("x₄ = -76L_{-4} - 52L_{-3}L_{-1} - 12L_{-2}² - 20L_{-2}L_{-1}² - 3L_{-1}⁴")
    print("  Leading term: -3L_{-1}⁴")
    print()
    print("Syzygy check: L_{-1}x₄ + (2L_{-2} + 3L_{-1}²)y₃ = 0")
    print("  Verified in blueprint §B⁗.2")

    return True

if __name__ == "__main__":
    print("Numerical Verification Script for N=6 Seed Criterion")
    print()

    test_n6_criterion_level1()
    compute_leading_terms()

    print("\n" + "=" * 80)
    print("CONCLUSION")
    print("=" * 80)
    print()
    print("The N=6 criterion requires commutator calculations [L_m, x₄] and [L_m, y₃].")
    print("Blueprint §B⁗.7 states this is 'a level-1 calculation, independent of N'.")
    print()
    print("For N=6 specifically: Since p_D(N-7) = p_D(-1) = 0, the s=7 pair does not")
    print("appear, so we only need the s=5 pair (x₄, y₃) already computed in §B⁗.2.")
    print()
    print("The proof strategy is:")
    print("1. Show L_1(x₄u) = 0 and L_1(y₃u) = 0 together imply L_1(u) = 0")
    print("2. This follows from analyzing how L_1 commutes with x₄ and y₃")
    print("3. The key is that x₄ contains L_{-1}⁴ and y₃ contains L_{-3},")
    print("   so their commutators with L_1 produce terms proportional to u")
    print()
    print("STATUS: Numerical framework set up. Detailed commutator calculation needed.")
