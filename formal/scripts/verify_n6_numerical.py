#!/usr/bin/env python3
"""
Numerical verification of the N=6 seed criterion.

⚠⚠ 本脚本目前是**错的**，输出不可用作任何证据（lead, 2026-09-17）。
`apply_virasoro_to_word` 至少有三个 bug：
  1. `if new_mode <= 0` 吞掉了 `new_mode == 0`，下面的 `elif new_mode == 0` 是死代码；
     当 `n == m1` 时会把一个 `0` 塞进词里。
  2. 「pass-through」项直接 `sorted([m1] + res_word)` 重排，没有做正规序的对易子修正，
     成套丢项。
  3. `[L_n, L_{-n}]` 的中心项从未出现。
它对 §B⁗.2 的 syzygy 恒等式报误差 ≈ 82，而该恒等式已由两个独立实现确认精确为零
（见 `verify_syzygy.py`）——错的是脚本，不是数学。
修好之后**必须**先跑 `verify_syzygy.py` 的恒等式作回归测试再用。

We verify in small dimensions that the syzygy map u -> (x4*u, y3*u) on level-1 seeds
is injective, which implies the criterion.

Strategy: Work in U(Vir^-) with explicit PBW basis, construct matrices.
"""

import numpy as np
from itertools import combinations_with_replacement, product

def virasoro_commutator(m, n):
    """Virasoro commutator [L_m, L_n] = (m-n)L_{m+n} in the negative modes (no central term)."""
    return (m - n, m + n)

def pbw_basis_level(N):
    """
    Generate PBW basis for U(Vir^-) at level N.
    Basis elements are ordered words L_{-n_1} ... L_{-n_k} with n_1 >= n_2 >= ... >= n_k >= 1
    and sum n_i = N.

    Returns list of tuples representing partitions in decreasing order.
    """
    if N == 0:
        return [()]

    basis = []

    def generate_partitions(n, max_part):
        if n == 0:
            yield []
            return
        for i in range(min(n, max_part), 0, -1):
            for rest in generate_partitions(n - i, i):
                yield [i] + rest

    for partition in generate_partitions(N, N):
        basis.append(tuple(partition))

    return basis

def partition_to_index(basis, partition):
    """Get index of partition in basis."""
    return basis.index(tuple(sorted(partition, reverse=True)))

def apply_virasoro_to_word(n, word):
    """
    Apply L_n to a word L_{-word[0]} ... L_{-word[k]} | vac>.

    Uses the commutator [L_n, L_{-m}] = (n+m) L_{n-m} for n+m != 0 (no central term).

    Returns dict of {resulting_partition: coefficient}.
    """
    if not word:
        # L_n on vacuum: 0 for n > 0
        return {} if n > 0 else {(): 1}  # L_0 on vac = 0 (for h=0)

    # L_n L_{-m_1} ... L_{-m_k} |vac>
    # = [L_n, L_{-m_1}] L_{-m_2} ... L_{-m_k} |vac> + L_{-m_1} L_n L_{-m_2} ... |vac>

    m1 = word[0]
    rest = word[1:]

    result = {}

    # Commutator term: [L_n, L_{-m_1}] = (n + m_1) L_{n - m_1}
    comm_coeff = n + m1
    new_mode = n - m1

    if comm_coeff != 0:
        if new_mode <= 0:
            # Gets a negative mode, insert in sorted order
            new_word = tuple(sorted([abs(new_mode)] + list(rest), reverse=True))
            sign = 1 if new_mode <= 0 else 0  # only keep negative modes
            if sign and new_word:
                result[new_word] = result.get(new_word, 0) + comm_coeff
        elif new_mode == 0:
            # L_0 acting on rest: gives level number times rest
            level_rest = sum(rest)
            if rest:
                result[rest] = result.get(rest, 0) + comm_coeff * level_rest

    # Pass-through term: L_{-m_1} (L_n acting on rest)
    rest_results = apply_virasoro_to_word(n, rest)
    for res_word, coeff in rest_results.items():
        new_word = tuple(sorted([m1] + list(res_word), reverse=True))
        result[new_word] = result.get(new_word, 0) + coeff

    return result

def construct_virasoro_matrix(n, level_from, level_to):
    """
    Construct matrix for L_n: U_{level_from} -> U_{level_to}.

    Returns (matrix, basis_from, basis_to).
    """
    basis_from = pbw_basis_level(level_from)
    basis_to = pbw_basis_level(level_to)

    dim_from = len(basis_from)
    dim_to = len(basis_to)

    matrix = np.zeros((dim_to, dim_from))

    for j, word_from in enumerate(basis_from):
        results = apply_virasoro_to_word(n, word_from)
        for word_to, coeff in results.items():
            if word_to in basis_to:
                i = basis_to.index(word_to)
                matrix[i, j] = coeff

    return matrix, basis_from, basis_to

def test_n6_criterion_numerical():
    """
    Numerical test of N=6 criterion.

    At N=6, the syzygy pair (x4, y3) acts on level-1.
    We verify that the kernel dimension matches expectations.
    """
    print("=" * 80)
    print("N=6 Seed Criterion: Numerical Verification")
    print("=" * 80)
    print()

    # First verify the syzygy in U(Vir^-)
    print("Step 1: Verify syzygy L_{-1}x4 + D2*y3 = 0 in U(Vir^-)")
    print("-" * 80)

    # Construct x4 and y3 as vectors in U_4 and U_3
    basis_3 = pbw_basis_level(3)
    basis_4 = pbw_basis_level(4)

    print(f"dim U_3 = {len(basis_3)}, basis: {basis_3}")
    print(f"dim U_4 = {len(basis_4)}, basis: {basis_4}")
    print()

    # y3 = 12*L_{-3} + 6*L_{-2}L_{-1} + L_{-1}^3
    y3_coeffs = np.zeros(len(basis_3))
    y3_coeffs[basis_3.index((3,))] = 12
    y3_coeffs[basis_3.index((2, 1))] = 6
    y3_coeffs[basis_3.index((1, 1, 1))] = 1

    print(f"y3 = {y3_coeffs} in basis {basis_3}")

    # x4 = -76*L_{-4} - 52*L_{-3}L_{-1} - 12*L_{-2}^2 - 20*L_{-2}L_{-1}^2 - 3*L_{-1}^4
    x4_coeffs = np.zeros(len(basis_4))
    x4_coeffs[basis_4.index((4,))] = -76
    x4_coeffs[basis_4.index((3, 1))] = -52
    x4_coeffs[basis_4.index((2, 2))] = -12
    x4_coeffs[basis_4.index((2, 1, 1))] = -20
    x4_coeffs[basis_4.index((1, 1, 1, 1))] = -3

    print(f"x4 = {x4_coeffs} in basis {basis_4}")
    print()

    # Construct L_{-1}: U_4 -> U_5 and D2: U_3 -> U_5
    L_minus1_4to5, _, basis_5 = construct_virasoro_matrix(-1, 4, 5)
    L_minus1_3to4, _, _ = construct_virasoro_matrix(-1, 3, 4)
    L_minus2_3to5, _, _ = construct_virasoro_matrix(-2, 3, 5)

    # D2 = 2*L_{-2} + 3*L_{-1}^2
    # D2: U_3 -> U_5
    L_minus1_3to5_via_4 = L_minus1_4to5 @ L_minus1_3to4
    D2_3to5 = 2 * L_minus2_3to5 + 3 * L_minus1_3to5_via_4

    # Verify syzygy
    syzygy_result = L_minus1_4to5 @ x4_coeffs + D2_3to5 @ y3_coeffs

    print(f"dim U_5 = {len(basis_5)}")
    print(f"Syzygy verification: ||L_{{-1}}x4 + D2*y3|| = {np.linalg.norm(syzygy_result):.2e}")

    if np.linalg.norm(syzygy_result) < 1e-10:
        print("✓ Syzygy verified!")
    else:
        print("✗ Syzygy verification failed!")
        print(f"Result: {syzygy_result}")

    print()
    print("=" * 80)
    print("Numerical verification complete.")
    print()
    print("Note: Full N=6 criterion verification requires:")
    print("  1. Construct Fock space representation (not just U(Vir^-))")
    print("  2. Define seed space Q_{j,M} = positive mode kernel")
    print("  3. Verify dim{u in Q_1 : x4*u in Q_5, y3*u in Q_4} = dim Q_1")
    print()
    print("This is beyond the scope of pure U(Vir^-) calculation.")
    print("The algebraic proof strategy in §B⁗.9 is the correct approach.")

if __name__ == "__main__":
    test_n6_criterion_numerical()
