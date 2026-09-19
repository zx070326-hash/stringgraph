#!/usr/bin/env python3
"""S6-injectivity probe for research/attempts/s6-injectivity-level-six.

Question (rung j = -6, level 1): let u = c_mu alpha^mu_{-1}|0;p_{-6}> range over the
WHOLE level-1 slice V_{-6,1} (dimension D, no seed/orthogonality condition on c).
Compute x4*u and y3*u as literal vectors in the free-boson Fock space (built on the
rung -6 vacuum) and ask: does

    x4*u = 0  AND  y3*u = 0   (as literal Fock-space vectors, not just "annihilated by
                                 positive Virasoro modes")

force c = 0?

This is the computational core of the S6-injectivity claim in
research/attempts/s6-injectivity-level-six/claim.md.  It reuses the exact same
oscillator/Virasoro machinery as formal/scripts/verify_n6_seed_criterion.py (same
conventions: alpha' = 1/2, eta = diag(-1,+1,...,+1), a.a=2, a.b=1, b.b=0, p_j = a+j*b),
but reads off coefficients of the RAW vectors x4*u, y3*u directly, instead of first
projecting onto the "annihilated by L_m, m>=1" condition.

Convention check: p_{-6}.p_{-6} must equal -10 (2*(j+1) at j=-6), matching
verify_n6_seed_criterion.py exactly, so the two scripts' Fock realizations agree.

All arithmetic is exact (fractions.Fraction).
"""

from collections import defaultdict
from fractions import Fraction as F
import sys


def build(D):
    eta = [F(-1)] + [F(1)] * (D - 1)
    a = [F(0)] * D
    a[1] = F(1)
    a[2] = F(1)
    b = [F(0)] * D
    b[0] = F(1)
    b[1] = F(1)
    p = [a[i] - 6 * b[i] for i in range(D)]
    assert sum(eta[i] * p[i] * p[i] for i in range(D)) == -10, "p_{-6}^2 must be -10"
    return eta, p


def make_ops(D, eta, p):
    def creat(mu, n, st):
        out = defaultdict(F)
        for w, c in st.items():
            out[tuple(sorted(w + ((n, mu),)))] += c
        return out

    def annih(mu, n, st):  # n >= 1
        out = defaultdict(F)
        for w, c in st.items():
            k = w.count((n, mu))
            if k:
                w2 = list(w)
                w2.remove((n, mu))
                out[tuple(w2)] += c * k * n * eta[mu]
        return out

    def alpha(mu, k, st):
        if k < 0:
            return creat(mu, -k, st)
        if k == 0:
            return {w: c * p[mu] for w, c in st.items()}
        return annih(mu, k, st)

    def dot(k1, k2, st):
        out = defaultdict(F)
        for mu in range(D):
            for w, c in alpha(mu, k1, alpha(mu, k2, st)).items():
                out[w] += eta[mu] * c
        return {w: c for w, c in out.items() if c != 0}

    return creat, dot


def addd(*xs):
    r = defaultdict(F)
    for x in xs:
        for w, c in x.items():
            r[w] += c
    return {w: c for w, c in r.items() if c != 0}


def scale(k, x):
    return {w: F(k) * c for w, c in x.items() if F(k) * c != 0}


def lvl(st):
    return max((sum(n for n, _ in w) for w in st), default=0)


def make_L(dot):
    def L(m, st):
        if not st:
            return {}
        t = []
        if m > 0:
            for j in range(0, m + 1):
                t.append(scale(F(1, 2), dot(m - j, j, st)))
            for k in range(1, lvl(st) + 1):
                t.append(dot(-k, m + k, st))
        elif m == 0:
            t.append(scale(F(1, 2), dot(0, 0, st)))
            for k in range(1, lvl(st) + 1):
                t.append(dot(-k, k, st))
        else:
            M = -m
            for j in range(0, M + 1):
                t.append(scale(F(1, 2), dot(-M + j, -j, st)))
            for k in range(1, lvl(st) + 1):
                t.append(dot(-M - k, k, st))
        return addd(*t)

    return L


def rank_exact(rows, D):
    M = [list(r) for r in rows if any(r)]
    r = 0
    piv = []
    for col in range(D):
        pr = next((i for i in range(r, len(M)) if M[i][col] != 0), None)
        if pr is None:
            continue
        M[r], M[pr] = M[pr], M[r]
        pv = M[r][col]
        for i in range(len(M)):
            if i != r and M[i][col] != 0:
                f = M[i][col] / pv
                M[i] = [M[i][j] - f * M[r][j] for j in range(D)]
        piv.append(col)
        r += 1
    return r, piv, M


def run(D, verbose=False):
    eta, p = build(D)
    creat, dot = make_ops(D, eta, p)
    L = make_L(dot)

    def opw(ns, st):
        e = st
        for n in reversed(ns):
            e = L(-n, e)
        return e

    y3 = lambda s: addd(scale(12, opw([3], s)), scale(6, opw([2, 1], s)), opw([1, 1, 1], s))  # noqa: E731
    x4 = lambda s: addd(  # noqa: E731
        scale(-76, opw([4], s)), scale(-52, opw([3, 1], s)), scale(-12, opw([2, 2], s)),
        scale(-20, opw([2, 1, 1], s)), scale(-3, opw([1, 1, 1, 1], s)))

    vac = {(): F(1)}

    # rows[word][mu] = coefficient of `word` in Y(alpha^mu_{-1}|0;p>) resp X(...),
    # i.e. the literal Fock-space vector, NOT projected through any further L_m.
    rows = defaultdict(lambda: [F(0)] * D)
    for mu in range(D):
        um = creat(mu, 1, vac)
        Ym, Xm = y3(um), x4(um)
        for w, cc in Ym.items():
            rows[('Y', w)][mu] += cc
        for w, cc in Xm.items():
            rows[('X', w)][mu] += cc

    r, piv, M = rank_exact(list(rows.values()), D)
    null = D - r
    status = "INJECTIVE (kernel = 0)" if null == 0 else f"NOT injective, kernel dim = {null}"
    print(f"D = {D:3d} :  distinct monomials touched = {len(rows):5d}  rank = {r:3d}  "
          f"nullity = {null:3d}   {status}")
    if verbose and null > 0:
        # print a basis vector of the kernel via free columns
        free_cols = [c for c in range(D) if c not in piv]
        print(f"  free columns (0-indexed mu): {free_cols}")
    return null


if __name__ == "__main__":
    ds = [int(x) for x in sys.argv[1:]] or [2, 3, 4, 5, 10, 25, 26, 27, 30, 50]
    results = {d: run(d, verbose=True) for d in ds}
    print("\nSummary: D -> nullity(ker S6)")
    for d, n in results.items():
        print(f"  {d}: {n}")
    bad = [d for d, n in results.items() if n != 0]
    if bad:
        print(f"\nNOT injective at D = {bad}")
    else:
        print("\nInjective at every tested D.")
