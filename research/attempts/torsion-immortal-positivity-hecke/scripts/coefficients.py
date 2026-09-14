"""
Fourier coefficients of 1/Phi_10 and of the DMZ mock (finite) part psi_m^F.

From scratch, exact integer arithmetic, no third-party dependencies.

Conventions (Rossello arXiv:2403.19630):
    Omega = [[rho, v],[v, sigma]],  p = e^{2 pi i rho}, q = e^{2 pi i sigma}, y = e^{2 pi i v}
    1/Phi_10(rho,sigma,v) = sum_{m>=-1} psi_m(sigma,v) p^m
    psi_m(sigma,v)        = sum_{n,l} c_m(n,l) q^n y^l          (Jacobi index m in v)
    Delta = 4 m n - l^2

Expansion chamber: |q| < |y| < 1  (0 < Im v < Im sigma).  The SAME chamber is used for
psi_m and for the Appell-Lerch polar part psi_m^P, so the difference c_m^F = c_m - c_m^P
is chamber independent (psi_m^F is holomorphic in v).

Phi_10 = Saito-Kurokawa / Maass lift of the weight-10 index-1 Jacobi cusp form
    phi_{10,1} = q (y - 2 + 1/y) prod_{b>=1}(1-q^b)^20 (1-q^b y)^2 (1-q^b/y)^2
    c_m(n,l) of phi_{10,1}|V_m  =  sum_{d | (n,l,m)} d^9 * C1( (4 n m - l^2) / d^2 )
with C1(D) the coefficients of phi_{10,1} (they depend only on D = 4n-l^2).
Normalisation: Phi_10 = p*phi_{10,1} + O(p^2), i.e. Phi_10 ~ -4 pi^2 v^2 Dl(rho) Dl(sigma)
near v = 0 -- exactly the normalisation for which DMZ's polar formula holds as written.

DMZ canonical decomposition (arXiv:1208.4074, Thm 8.3):
    psi_m^P(sigma,v) = (p24(m+1)/Dl(sigma)) * A_{2,m}(sigma,v)
    A_{2,m}(sigma,v) = sum_{s in Z} q^{m s^2 + s} y^{2 m s + 1} / (1 - q^s y)^2

Self-tests (run with --selftest):
  * Phi_10 * (1/Phi_10) = 1 to the reported order   (validates the inversion)
  * |c_1(1,0)| = 50064                              (known Q^2=P^2=2, Q.P=0 degeneracy)
  * psi_m^F coefficients obey the DMZ "optimal growth" bound Delta = 4mn-l^2 >= -1
    (a strong, non-trivial check of both the psi_m and the Appell-Lerch computation)

Usage:
    python coefficients.py --selftest
    python coefficients.py --check       # truncation-stability in NMAX
"""

import sys
from math import comb, isqrt

# --------------------------------------------------------------------------- #
# global truncation
# --------------------------------------------------------------------------- #
NMAX = 10        # internal q-order cutoff
MARGIN = 2       # report only n <= NMAX - MARGIN
LMAX = 240       # y-powers kept above
LMIN = -60       # y-powers kept below


def smul(f, g):
    out = {}
    for (n1, l1), a in f.items():
        for (n2, l2), b in g.items():
            n = n1 + n2
            if n > NMAX:
                continue
            l = l1 + l2
            if l > LMAX or l < LMIN:
                continue
            k = (n, l)
            out[k] = out.get(k, 0) + a * b
    return {k: v for k, v in out.items() if v}


def sadd(f, g, c=1):
    out = dict(f)
    for k, v in g.items():
        out[k] = out.get(k, 0) + c * v
        if out[k] == 0:
            del out[k]
    return out


def factor_pow(a, c, e):
    """(1 - q^a y^c)^e, truncated at the global bounds; a >= 1."""
    out = {}
    if e >= 0:
        for j in range(e + 1):
            n, l = a * j, c * j
            if n > NMAX or l > LMAX or l < LMIN:
                continue
            out[(n, l)] = out.get((n, l), 0) + (-1) ** j * comb(e, j)
    else:
        E = -e
        j = 0
        while a * j <= NMAX:
            n, l = a * j, c * j
            if LMIN <= l <= LMAX:
                out[(n, l)] = out.get((n, l), 0) + comb(j + E - 1, E - 1)
            j += 1
    return {k: v for k, v in out.items() if v}


def _gcd(a, b):
    a, b = abs(a), abs(b)
    while b:
        a, b = b, a % b
    return a


def divisors(k):
    k = abs(k)
    return [d for d in range(1, k + 1) if k % d == 0]


# --------------------------------------------------------------------------- #
# phi_{10,1}:  computed with its OWN bounds, up to q-order Nc.
# Coefficients vanish unless 4n - l^2 > 0, so |l| < 2 sqrt(n).
# --------------------------------------------------------------------------- #
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
        if D <= 0:
            assert v == 0 or abs(l) > 2 * isqrt(n) , ("cusp form violated", n, l, v)
            continue
        if D in C1:
            assert C1[D] == v, ("index-1 inconsistency at", n, l, D, v, C1[D])
        else:
            C1[D] = v
    C1["_Dmax"] = 4 * Nc
    return C1


def phi_m_series(C1, m):
    """phi_{10,1}|V_m: holomorphic Jacobi cusp form, weight 10, index m."""
    Dmax = C1["_Dmax"]
    out = {}
    for n in range(1, NMAX + 1):
        lb = isqrt(4 * n * m) + 1
        for l in range(-lb, lb + 1):
            D = 4 * n * m - l * l
            if D <= 0:
                continue
            assert D <= Dmax, ("C1 table too short: need D=%d, have %d" % (D, Dmax))
            g = _gcd(_gcd(m, n), l)
            tot = 0
            for d in divisors(g):
                if D % (d * d) == 0:
                    tot += d ** 9 * C1.get(D // (d * d), 0)
            if tot and LMIN <= l <= LMAX:
                out[(n, l)] = tot
    return out


# --------------------------------------------------------------------------- #
# psi_m
# --------------------------------------------------------------------------- #
def inv_phi101():
    """1/phi_{10,1} in the chamber |q| < |y| < 1."""
    f = {(-1, j): j for j in range(1, LMAX + 1)}   # q^{-1} * y/(1-y)^2
    for b in range(1, NMAX + 2):
        f = smul(f, factor_pow(b, 0, -20))
        f = smul(f, factor_pow(b, 1, -2))
        f = smul(f, factor_pow(b, -1, -2))
    return f


def psi_series(C1, MMAX):
    B0 = inv_phi101()                      # = psi_{-1}
    phis = {i: phi_m_series(C1, i) for i in range(1, MMAX + 3)}
    B = {0: B0}
    for j in range(1, MMAX + 2):
        acc = {}
        for i in range(1, j + 1):
            acc = sadd(acc, smul(phis[i + 1], B[j - i]))
        B[j] = smul(B0, {k: -v for k, v in acc.items()})
    return {j - 1: B[j] for j in range(0, MMAX + 2)}, phis


# --------------------------------------------------------------------------- #
# Appell-Lerch polar part
# --------------------------------------------------------------------------- #
def p24_list(K):
    """p24(k) = coeff of q^k in prod_{n>=1}(1-q^n)^{-24};  1/Dl = sum_{n>=-1} p24(n+1) q^n."""
    a = [0] * (K + 1)
    a[0] = 1
    for n in range(1, K + 1):
        b = [0] * (K + 1)
        for j in range(0, K // n + 1):
            c = comb(j + 23, 23)
            for k in range(0, K + 1 - n * j):
                if a[k]:
                    b[k + n * j] += c * a[k]
        a = b
    return a


def inv_delta():
    """1/Delta_cusp(sigma) = sum_{n>=-1} p24(n+1) q^n."""
    f = {(-1, 0): 1}
    for b in range(1, NMAX + 2):
        f = smul(f, factor_pow(b, 0, -24))
    return f


def A2m_series(m):
    """A_{2,m} in the chamber |q| < |y| < 1."""
    out = {}

    def add(n, l, v):
        if n > NMAX or l > LMAX or l < LMIN:
            return
        out[(n, l)] = out.get((n, l), 0) + v

    for j in range(0, LMAX):                       # s = 0
        add(0, j + 1, j + 1)

    s = 1                                          # s >= 1
    while m * s * s + s <= NMAX:
        base = m * s * s + s
        j = 0
        while base + s * j <= NMAX:
            add(base + s * j, 2 * m * s + 1 + j, j + 1)
            j += 1
        s += 1

    s = -1                                         # s <= -1
    while m * s * s + abs(s) <= NMAX:
        base = m * s * s + s
        j = 0
        while base - s * (j + 2) <= NMAX:
            add(base - s * (j + 2), 2 * m * s + 1 - j - 2, j + 1)
            j += 1
        s -= 1
    return {k: v for k, v in out.items() if v}


def compute(MMAX, Nc=None):
    C1 = build_C1(Nc or (NMAX * (MMAX + 2) + 8))
    psis, phis = psi_series(C1, MMAX)
    iD = inv_delta()
    p24 = {k: v for k, v in enumerate(p24_list(MMAX + 2))}
    F, P = {}, {}
    for m in range(1, MMAX + 1):
        pol = smul({(0, 0): p24[m + 1]}, smul(iD, A2m_series(m)))
        P[m] = pol
        F[m] = sadd(psis[m], pol, -1)
    return psis, F, P, phis


def dstar(F, m, n, l):
    """d_*(m,n,l) := (-1)^{l+1} c_m^F(n,l)  (c^F is even in l)."""
    return (-1) ** (l + 1) * F[m].get((n, abs(l)), 0)


# --------------------------------------------------------------------------- #
if __name__ == "__main__":
    if "--check" in sys.argv:
        vals = {}
        for nm in (8, 10, 12, 14):
            NMAX = nm
            psis, F, P, phis = compute(4)
            for m in (1, 2, 4):
                for n in range(1, 8 - MARGIN + 1):
                    for l in range(0, 2 * m + 1):
                        vals.setdefault((m, n, l), {})[nm] = F[m].get((n, l), 0)
        unstable = [(k, [v[nm] for nm in sorted(v)]) for k, v in sorted(vals.items())
                    if len(set(v.values())) != 1]
        print("truncation-stability of c_m^F(n,l), NMAX in {8,10,12,14}")
        print("  entries compared:", len(vals))
        print("  UNSTABLE:", unstable if unstable else "none")
        sys.exit(0)

    MMAX = 4
    psis, F, P, phis = compute(MMAX)
    NREP = NMAX - MARGIN

    print("C1(D) for phi_{10,1}, D <= 20:",
          {D: C1v for D, C1v in sorted(build_C1(8).items(), key=lambda t: (t[0] == "_Dmax", t[0]))
           if D != "_Dmax" and D <= 20})

    # ---- self-test 1: Phi_10 * (1/Phi_10) = 1 -------------------------------
    prod = {}
    for i in range(1, MMAX + 3):
        for j in range(-1, MMAX + 1):
            if i + j > MMAX:
                continue
            t = smul(phis[i], psis[j])
            for k, v in t.items():
                key = (i + j, k)
                prod[key] = prod.get(key, 0) + v
    resid = {k: v for k, v in prod.items() if v and not (k[0] == 0 and k[1] == (0, 0))}
    resid = {k: v for k, v in resid.items()
             if k[1][0] <= NREP and LMIN + 20 <= k[1][1] <= LMAX - 20}
    print("\nselftest 1: Phi_10 * 1/Phi_10 - 1 (n <= %d, m <= %d):" % (NREP, MMAX),
          "OK" if not resid else list(resid.items())[:6])
    print("            constant term =", prod.get((0, (0, 0))))

    # ---- self-test 2: known degeneracy --------------------------------------
    print("selftest 2: c_1(1,0) =", psis[1].get((1, 0), 0), "(expect -50064)")

    # ---- self-test 3: ellipticity of the finite part -------------------------
    # psi_m^F is HOLOMORPHIC in v and elliptic of index m, hence its coefficients
    # depend only on (Delta, l mod 2m) and are even in l.  psi_m itself does NOT
    # have this property in a fixed chamber, so this is a sharp test that the
    # Appell-Lerch subtraction is correct.
    viol = []
    for m in range(1, MMAX + 1):
        cls = {}
        for (n, l), v in F[m].items():
            if n > NREP or abs(l) > 4 * m + 6:
                continue
            key = (4 * m * n - l * l, l % (2 * m))
            if key in cls and cls[key] != v:
                viol.append((m, key, cls[key], v))
            cls[key] = v
        for (n, l), v in F[m].items():
            if n > NREP or abs(l) > 4 * m + 6:
                continue
            w = F[m].get((n, -l), 0)
            if w != v:
                viol.append(("even", m, n, l, v, w))
    print("selftest 3: c_m^F depends only on (Delta, l mod 2m) and is even in l :",
          "OK" if not viol else ("VIOLATIONS %d, e.g. %s" % (len(viol), viol[:4])))

    # ---- Rossello ------------------------------------------------------------
    print("\n--- Rossello Thm 1: (-1)^(l+1) c_m^F(n,l) > 0 for m>0, n>=m, 0<=l<=m ---")
    bad, cnt = [], 0
    for m in range(1, MMAX + 1):
        for n in range(m, NREP + 1):
            for l in range(0, m + 1):
                cnt += 1
                if dstar(F, m, n, l) <= 0:
                    bad.append((m, n, l, dstar(F, m, n, l)))
    print("  tested %d, violations:" % cnt, bad if bad else "none")

    print("\n--- Rossello Cor 1.1: d_*(m,n,l) > 0 for m,n>=1, Delta>0 ---")
    bad2, cnt = [], 0
    for m in range(1, MMAX + 1):
        for n in range(1, NREP + 1):
            for l in range(0, 2 * m + 1):
                if 4 * m * n - l * l <= 0:
                    continue
                cnt += 1
                if dstar(F, m, n, l) <= 0:
                    bad2.append((m, n, l, 4 * m * n - l * l, dstar(F, m, n, l)))
    print("  tested %d, violations:" % cnt, bad2 if bad2 else "none")
