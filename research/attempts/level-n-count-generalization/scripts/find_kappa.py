"""Determine the correction term kappa_N(m) in the recursion

    p_{m+1}(N-1) + p_{m+1}(N-2) + p_m(N) = p_{m+1}(N) + kappa_N(m)

for N = 2..10 and a range of m, using the independently-verified p_m(N)
(three-way cross-checked in verify_level_n.py).  Also cross-check against
the m -> m+1 convolution identity

    p_{m+1}(N) = sum_{k=0}^{N} p(k) * p_m(N-k)      (p = p_1, ordinary partitions)

which holds unconditionally because the generating function ratio
F_{m+1}(x)/F_m(x) = prod_n (1-x^n)^{-1} is independent of m.
"""
from math import comb
import sys
sys.path.insert(0, 'research/attempts/level-n-count-generalization/scripts')
from verify_level_n import p_via_generating_function as p


def pN(m, N):
    if N < 0:
        return 0
    return p(m, N)


print("N  m   p_m(N)  p_{m+1}(N-1)  p_{m+1}(N-2)  p_{m+1}(N)   kappa=p_m(N)+p_{m+1}(N-1)+p_{m+1}(N-2)-p_{m+1}(N)")
for N in range(2, 11):
    row = []
    for m in range(1, 8):
        a = pN(m, N)
        b = pN(m + 1, N - 1)
        c = pN(m + 1, N - 2)
        d = pN(m + 1, N)
        kappa_val = a + b + c - d
        row.append(kappa_val)
    print(f"N={N:2d}  kappa(m=1..7) = {row}")

# Cross-check the exact convolution identity with ordinary partitions p(k)=p_1(k)
print()
print("Cross-check: p_{m+1}(N) = sum_k p(k) p_m(N-k)")
ok = True
for N in range(0, 11):
    for m in range(1, 6):
        lhs = pN(m + 1, N)
        rhs = sum(pN(1, k) * pN(m, N - k) for k in range(0, N + 1))
        if lhs != rhs:
            ok = False
            print("MISMATCH", N, m, lhs, rhs)
print("convolution identity holds for all tested (N,m):", ok)
