"""
GAP 10.4.a -- the DECISIVE test (efficient version).

Honest attractor contour integral of the ACTUAL function psi_m, evaluated pointwise
via the finite p-recursion from the HOLOMORPHIC phi_M = phi_{10,1}|V_M.  No v-chamber
Laurent choice is ever made.  See gap_10_4_honest_integral.py header for the full
statement of what is being decided.

Decision for (5,1,4):  is the honest integral  50064 (GL(2,Z)-invariant, Prop 4.4)
                       or  -2023536 ((-1)^{l+1} c_m^F = the formal annulus coefficient)?
"""

import numpy as np
from math import isqrt, comb


def _gcd(a, b):
    a, b = abs(a), abs(b)
    while b:
        a, b = b, a % b
    return a


def divisors(k):
    k = abs(k)
    return [d for d in range(1, k + 1) if k % d == 0]


def build_C1(Nc):
    LB = 2 * isqrt(Nc) + 4

    def mul(f, g):
        out = {}
        for (n1, l1), a in f.items():
            for (n2, l2), b in g.items():
                n = n1 + n2
                if n > Nc:
                    continue
                l = l1 + l2
                if abs(l) > LB:
                    continue
                out[(n, l)] = out.get((n, l), 0) + a * b
        return {k: v for k, v in out.items() if v}

    def fac(a, c, e):
        out = {}
        for j in range(e + 1):
            n, l = a * j, c * j
            if n > Nc or abs(l) > LB:
                continue
            out[(n, l)] = out.get((n, l), 0) + (-1) ** j * comb(e, j)
        return {k: v for k, v in out.items() if v}

    f = {(1, 1): 1, (1, 0): -2, (1, -1): 1}
    for b in range(1, Nc + 1):
        f = mul(f, fac(b, 0, 20))
        f = mul(f, fac(b, 1, 2))
        f = mul(f, fac(b, -1, 2))
    C1 = {}
    for (n, l), v in f.items():
        D = 4 * n - l * l
        if D > 0:
            C1[D] = v
    return C1


def phiM_terms(C1, M, Nmax):
    terms = []
    for n in range(1, Nmax + 1):
        lb = isqrt(4 * n * M) + 1
        for l in range(-lb, lb + 1):
            D = 4 * M * n - l * l
            if D <= 0:
                continue
            g = _gcd(_gcd(M, n), l)
            tot = 0
            for d in divisors(g):
                if D % (d * d) == 0:
                    tot += d ** 9 * C1.get(D // (d * d), 0)
            if tot:
                terms.append((n, l, float(tot)))
    return terms


class PsiEvaluator:
    def __init__(self, m, Nmax=8):
        self.m = m
        self.Nmax = Nmax
        # psi_m = B_{m+1}; recursion B_j = -B_0 sum_{i=1}^{j} phi_{i+1} B_{j-i}
        # with j up to m+1 needs phi_M up to M = m+2.
        Nc = 4 * (m + 2) * Nmax + 8
        C1 = build_C1(Nc)
        self.terms = {M: phiM_terms(C1, M, Nmax) for M in range(1, m + 3)}

    def eval(self, sigma, v):
        q = np.exp(2j * np.pi * sigma)
        y = np.exp(2j * np.pi * v)
        logq = 2j * np.pi * sigma
        logy = 2j * np.pi * v
        phis = {}
        for M, terms in self.terms.items():
            acc = np.zeros_like(q, dtype=complex)
            for (n, l, c) in terms:
                acc += c * np.exp(n * logq + l * logy)
            phis[M] = acc
        m = self.m
        B = {0: 1.0 / phis[1]}
        for j in range(1, m + 2):
            acc = np.zeros_like(q, dtype=complex)
            for i in range(1, j + 1):
                if (i + 1) in phis:
                    acc = acc + phis[i + 1] * B[j - i]
            B[j] = -B[0] * acc
        return B[m + 1]


def dstar_honest(ev, n, l, Lam, K=96):
    m = ev.m
    x = (np.arange(K) + 0.5) / K
    RS, RV = np.meshgrid(x, x, indexing="ij")
    sigma = RS + 1j * (2 * m * Lam)
    v = RV + 1j * (-l * Lam)
    psi = ev.eval(sigma, v + 0.5)                 # psi_m(sigma, v+1/2)
    phase = np.exp(-2j * np.pi * (n * sigma + l * v))
    return -(psi * phase).mean()


if __name__ == "__main__":
    print("Honest 2D attractor-contour integral of the ACTUAL function psi_m.")
    print("(pointwise p-recursion from holomorphic phi_M; no |y|<1 vs |y|>1 choice)")
    print()
    cases = [
        # NB: l=0 has a pole at Re v=1/2 (|y|=1 on the shifted contour); this real
        # Riemann sum does NOT converge for l=0 (K-dependent garbage below) -- expected.
        (1, 1, 0, "50064 reduced -- l=0, DIVERGES here (pole at Re v=1/2)"),
        (1, 1, 1, "25353 reduced"),
        (2, 2, 2, "3859456 reduced"),
        (5, 1, 2, "185738352  (l^2=4<mn=5, identity holds)"),
        (5, 1, 4, ">>> 50064 (invariant) vs -2023536 (formal) <<<  l^2=16>mn=5"),
    ]
    for m, n, l, label in cases:
        ev = PsiEvaluator(m, Nmax=8)
        print("-" * 72)
        print("  (m,n,l)=(%d,%d,%d)   expected %s" % (m, n, l, label))
        # smaller Lam keeps |y|=e^{2*pi*l*Lam} moderate; large l needs small Lam
        # or float cancellation swamps the Fourier extraction.
        Lams = (0.12, 0.18) if l >= 3 else (0.20, 0.30)
        for Lam in Lams:
            for K in (128, 192):
                val = dstar_honest(ev, n, l, Lam, K=K)
                print("    Lam=%.2f K=%3d :  d_* = % 16.3f  %+.2e i"
                      % (Lam, K, val.real, val.imag))
