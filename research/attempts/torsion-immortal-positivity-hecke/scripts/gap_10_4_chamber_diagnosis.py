"""
GAP 10.4.a decisive diagnosis: is psi_m^F chamber-independent, and which link of
the Cauchy/holomorphic-deformation argument (proof.md SS10.3.4 step (1)) breaks
when l^2 > mn ?

This is a FRESH, standalone reconstruction (does NOT import coefficients.py or any
author module).  Exact integer arithmetic.

We reconstruct the p^m Fourier-Jacobi coefficient psi_m(sigma,v) of 1/Phi_10 in TWO
v-chambers and the DMZ Appell-Lerch polar part psi_m^P in the same two chambers:

    STD chamber  |q| < |y| < 1        (0 < Im v < Im sigma):  the ring where c_m^F is DEFINED
    ANN chamber  1 < |y| < |q|^{-1}   (-Im sigma < Im v < 0):  the ring the attractor contour
                                                                 (Im v = -l*Lambda, 0<l<=m<2m) sits in

The ONLY v-chamber dependence in both psi_m and A_{2,m} is the single meromorphic
factor  y/(1-y)^2 = (y - 2 + 1/y)^{-1}  (the s=0 Appell term / the leading factor of
1/phi_{10,1}), which has a DOUBLE POLE at y=1 sitting on the wall |y|=1:

    STD:  y/(1-y)^2 = sum_{j>=1} j y^{ j}     (converges for |y|<1)
    ANN:  y/(1-y)^2 = sum_{j>=1} j y^{-j}     (converges for |y|>1)

Everything else (the q^b-factors, b>=1) has identical expansion in both rings.

Notation (Rossello): p=e^{2pi i rho}, q=e^{2pi i sigma}, y=e^{2pi i v},
    Phi_10 = sum_{M>=1} phi_M(sigma,v) p^M,  phi_M = phi_{10,1} | V_M  (HOLOMORPHIC, chamber-free)
    1/Phi_10 = sum_{m>=-1} psi_m(sigma,v) p^m
    psi_m^P  = (p24(m+1)/Delta_cusp(sigma)) * A_{2,m}(sigma,v)
    A_{2,m}  = sum_{s in Z} q^{m s^2 + s} y^{2 m s + 1} / (1 - q^s y)^2

Series are dicts {(n,l): int}, n = q-power (>= -1), l = y-power.
"""

from math import comb, isqrt

# global truncation
NMAX = 8          # q-order cutoff
LMAX = 80         # keep y-powers up to +LMAX
LMIN = -200       # keep y-powers down to LMIN (annulus needs deep negative powers)


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
    """(1 - q^a y^c)^e truncated, a >= 1 (so no y-chamber ambiguity)."""
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


def y_leading(chamber):
    """y/(1-y)^2  =  (y-2+1/y)^{-1}, expanded in the requested ring."""
    out = {}
    if chamber == "STD":            # |y|<1 : sum_{j>=1} j y^j
        for j in range(1, LMAX + 1):
            out[(0, j)] = j
    elif chamber == "ANN":          # |y|>1 : sum_{j>=1} j y^{-j}
        for j in range(1, -LMIN + 1):
            out[(0, -j)] = j
    else:
        raise ValueError(chamber)
    return out


# --------------------------------------------------------------------------- #
# phi_{10,1} and its Hecke images phi_M = phi_{10,1}|V_M  (holomorphic; chamber-free)
# --------------------------------------------------------------------------- #
def _gcd(a, b):
    a, b = abs(a), abs(b)
    while b:
        a, b = b, a % b
    return a


def divisors(k):
    k = abs(k)
    return [d for d in range(1, k + 1) if k % d == 0]


def build_C1(Nc):
    """C1[D] = coeff of phi_{10,1}, depends only on D=4n-l^2>0."""
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

    f = {(1, 1): 1, (1, 0): -2, (1, -1): 1}          # q(y-2+1/y)
    for b in range(1, Nc + 1):
        f = mul(f, fac(b, 0, 20))
        f = mul(f, fac(b, 1, 2))
        f = mul(f, fac(b, -1, 2))
    C1 = {}
    for (n, l), v in f.items():
        D = 4 * n - l * l
        if D <= 0:
            continue
        C1[D] = v
    C1["_Dmax"] = 4 * Nc
    return C1


def phi_m_series(C1, m):
    """phi_{10,1}|V_m: weight-10 index-m HOLOMORPHIC Jacobi cusp form (chamber-free)."""
    Dmax = C1["_Dmax"]
    out = {}
    for n in range(1, NMAX + 1):
        lb = isqrt(4 * n * m) + 1
        for l in range(-lb, lb + 1):
            D = 4 * n * m - l * l
            if D <= 0:
                continue
            assert D <= Dmax, ("C1 too short", D, Dmax)
            g = _gcd(_gcd(m, n), l)
            tot = 0
            for d in divisors(g):
                if D % (d * d) == 0:
                    tot += d ** 9 * C1.get(D // (d * d), 0)
            if tot and LMIN <= l <= LMAX:
                out[(n, l)] = tot
    return out


# --------------------------------------------------------------------------- #
# 1/phi_{10,1} in a chamber, then psi_m by inversion recursion
# --------------------------------------------------------------------------- #
def inv_phi101(chamber):
    """1/phi_{10,1} = q^{-1} (y/(1-y)^2) prod_{b>=1}(1-q^b)^{-20}(1-q^b y)^{-2}(1-q^b/y)^{-2}."""
    f = {(n - 1, l): v for (n, l), v in y_leading(chamber).items()}   # q^{-1} * y-leading
    for b in range(1, NMAX + 2):
        f = smul(f, factor_pow(b, 0, -20))
        f = smul(f, factor_pow(b, 1, -2))
        f = smul(f, factor_pow(b, -1, -2))
    return f


def psi_series(C1, MMAX, chamber):
    """psi_m for m=-1..MMAX in the given chamber."""
    B0 = inv_phi101(chamber)                    # psi_{-1}
    phis = {i: phi_m_series(C1, i) for i in range(1, MMAX + 3)}
    B = {0: B0}
    for j in range(1, MMAX + 2):
        acc = {}
        for i in range(1, j + 1):
            acc = sadd(acc, smul(phis[i + 1], B[j - i]))
        B[j] = smul(B0, {k: -v for k, v in acc.items()})
    return {j - 1: B[j] for j in range(0, MMAX + 2)}, phis


# --------------------------------------------------------------------------- #
# Appell-Lerch polar part in a chamber
# --------------------------------------------------------------------------- #
def p24_list(K):
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
    """1/Delta_cusp(sigma) = q^{-1} sum p24(k) q^k (chamber-free; sigma only)."""
    f = {(-1, 0): 1}
    for b in range(1, NMAX + 2):
        f = smul(f, factor_pow(b, 0, -24))
    return f


def A2m_series(m, chamber):
    """A_{2,m}(sigma,v) in the given v-chamber.  Only the s=0 term differs by chamber."""
    out = {}

    def add(n, l, v):
        if n > NMAX or l > LMAX or l < LMIN:
            return
        out[(n, l)] = out.get((n, l), 0) + v

    # s = 0 :  y/(1-y)^2
    if chamber == "STD":
        for j in range(1, LMAX + 1):
            add(0, j, j)
    else:                                       # ANN
        for j in range(1, -LMIN + 1):
            add(0, -j, j)

    # s >= 1 : |q^s y| < 1 (both chambers) -> positive geometric series
    s = 1
    while m * s * s + s <= NMAX:
        base = m * s * s + s
        k = 0
        while base + s * k <= NMAX:
            add(base + s * k, 2 * m * s + 1 + k, k + 1)
            k += 1
        s += 1

    # s <= -1 : |q^s y| > 1 (both chambers) -> negative geometric series
    s = -1
    while m * s * s + abs(s) <= NMAX:
        base = m * s * s + s
        k = 0
        while base - s * (k + 2) <= NMAX:
            add(base - s * (k + 2), 2 * m * s + 1 - k - 2, k + 1)
            k += 1
        s -= 1
    return {k: v for k, v in out.items() if v}


def compute_chamber(MMAX, chamber, Nc=None):
    C1 = build_C1(Nc or (NMAX * (MMAX + 2) + 8))
    psis, phis = psi_series(C1, MMAX, chamber)
    iD = inv_delta()
    p24 = {k: v for k, v in enumerate(p24_list(MMAX + 2))}
    F, P = {}, {}
    for m in range(1, MMAX + 1):
        pol = smul({(0, 0): p24[m + 1]}, smul(iD, A2m_series(m, chamber)))
        P[m] = pol
        F[m] = sadd(psis[m], pol, -1)          # psi_m^F = psi_m - psi_m^P (in this chamber)
    return psis, F, P, phis


# --------------------------------------------------------------------------- #
def reduce_form(m, n, l):
    """Gauss reduce a positive-definite [[m,l/2],[l/2,n]] to 0<=l<=m<=n."""
    assert 4 * m * n - l * l > 0 and m > 0 and n > 0
    for _ in range(20000):
        if n < m:
            m, n, l = n, m, -l
            continue
        if l > m or l < -m:
            r = (l + m) // (2 * m)
            m, n, l = m, r * r * m - r * l + n, l - 2 * r * m
            continue
        break
    if l < 0:
        l = -l
    return m, n, l


if __name__ == "__main__":
    MMAX = 6
    print("Reconstructing psi_m in STD and ANN chambers (MMAX=%d, NMAX=%d)..." % (MMAX, NMAX))
    psS, FS, PS, phiS = compute_chamber(MMAX, "STD")
    psA, FA, PA, phiA = compute_chamber(MMAX, "ANN")

    # sanity: phi_M holomorphic pieces identical in both chambers
    same_phi = all(phiS[i] == phiA[i] for i in phiS)
    print("  phi_M chamber-free:", same_phi)

    # sanity: known degeneracy c_1(1,0) = -50064 in STD
    print("  STD psi_1(1,0) =", psS[1].get((1, 0), 0), "(expect -50064)")

    print()
    print("=" * 78)
    print("TEST 1: is the FINITE PART psi_m^F chamber-independent?")
    print("        compare STD coeff c_m^F(n,l) vs ANN coeff of psi_m^F, 0<=l<=m")
    print("=" * 78)
    NREP = NMAX - 2
    diffs = []
    for m in range(1, MMAX + 1):
        for n in range(1, NREP + 1):
            for l in range(0, m + 1):
                cs = FS[m].get((n, l), 0)
                ca = FA[m].get((n, l), 0)
                if cs != ca:
                    diffs.append((m, n, l, cs, ca, 4 * m * n - l * l))
    if not diffs:
        print("  psi_m^F IS chamber-independent on 0<=l<=m (no differences found).")
    else:
        print("  psi_m^F is NOT chamber-independent.  Differences (m,n,l | STD | ANN | Delta):")
        for m, n, l, cs, ca, D in diffs[:30]:
            tag = " <-- Delta<0 (l^2>mn)" if D < 0 else ""
            print("    (%d,%d,%d)  STD=%d  ANN=%d  Delta=%d%s" % (m, n, l, cs, ca, D, tag))
        print("  total differing entries:", len(diffs),
              "| all with Delta<0 ?", all(d[5] < 0 for d in diffs))

    print()
    print("=" * 78)
    print("TEST 2: Lemma 10.3.1 in the ANN chamber -- does psi_m^P really vanish there?")
    print("        (report ANN-chamber y^l coeff of A_{2,m} and of psi_m^P for 0<=l<=2m)")
    print("=" * 78)
    for m in range(1, MMAX + 1):
        badA = sorted((n, l, v) for (n, l), v in A2m_series(m, "ANN").items()
                      if 0 <= l <= 2 * m and v != 0)
        badP = sorted((n, l, v) for (n, l), v in PA[m].items()
                      if 0 <= l <= 2 * m and n <= NREP and v != 0)
        print("  m=%d: A_{2,m} y^l(0<=l<=2m) nonzero: %s | psi_m^P nonzero: %s"
              % (m, badA[:3] if badA else "none", badP[:3] if badP else "none"))

    print()
    print("=" * 78)
    print("TEST 3: attractor contour value  d_* = (-1)^{l+1} * [ANN coeff of psi_m]")
    print("        vs Gauss-reduced ground truth,  for 0<=l<=m")
    print("=" * 78)
    print("  psi_m ANN coeff = full psi_m (poles included) Laurent coeff in 1<|y|<|q|^-1")
    print("  d_*(m,n,l) reduced = (-1)^{l0+1} c_{m0}^F(n0,l0) at Gauss-reduced (m0,n0,l0)")
    print()
    print("   (m,n,l)   Delta   ANN[psi_m]   d_*_attr=(-1)^{l+1}ANN   d_*_reduced   match")
    rows = []
    for m in range(1, MMAX + 1):
        for n in range(1, NREP + 1):
            for l in range(0, m + 1):
                D = 4 * m * n - l * l
                if D <= 0:
                    continue
                ann_psi = psA[m].get((n, l), 0)
                dattr = (-1) ** (l + 1) * ann_psi
                m0, n0, l0 = reduce_form(m, n, l)
                if m0 > MMAX or n0 > NREP:
                    dred = None
                else:
                    dred = (-1) ** (l0 + 1) * FS[m0].get((n0, abs(l0)), 0)
                match = (dred is not None and dattr == dred)
                rows.append((m, n, l, D, ann_psi, dattr, dred, match))
    # show anchor and a few reduced/unreduced
    show = [r for r in rows if r[0] == 5 and r[1] == 1 and r[2] == 4]
    show += [r for r in rows if (r[0], r[1], r[2]) in
             [(1, 1, 0), (1, 1, 1), (2, 2, 2), (5, 1, 0), (5, 1, 2), (5, 2, 4), (3, 1, 2), (4, 1, 2)]]
    seen = set()
    for m, n, l, D, ap, da, dr, mt in show:
        if (m, n, l) in seen:
            continue
        seen.add((m, n, l))
        print("   (%d,%d,%d)  %4d  %11d  %20d  %11s   %s"
              % (m, n, l, D, ap, da, str(dr), "OK" if mt else "DIFF"))

    ndiff = sum(1 for r in rows if r[6] is not None and not r[7])
    ntot = sum(1 for r in rows if r[6] is not None)
    print()
    print("  attractor(ANN) vs reduced ground truth:  %d/%d match, %d differ"
          % (ntot - ndiff, ntot, ndiff))
    print("  of the differing points, all have Delta = 4mn-l^2 < 0 (l^2>mn) ? %s"
          % all(r[3] < 0 for r in rows if r[6] is not None and not r[7]))
