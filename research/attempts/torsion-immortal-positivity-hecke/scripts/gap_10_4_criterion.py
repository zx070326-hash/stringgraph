"""
GAP 10.4.a -- pin down the EXACT failure criterion of the identity
    d_*(m,n,l) = (-1)^{l+1} c_m^F(n,l)     (0 <= l <= m, Delta=4mn-l^2 > 0)

Two candidate criteria disagree on e.g. (m,n,l)=(5,1,2): l^2=4 < mn=5  but  n=1 < m=5.

  naive(m,n,l)     = (-1)^{l+1} c_m^F(n,l)              (STD finite-part coeff, at original)
  invariant(m,n,l) = (-1)^{l0+1} c_{m0}^F(n0,l0)        (at the Gauss-reduced form; = true d_*)

Integer-exact, independent reconstruction (imports only my own chamber module, which
itself imports no author/mock code).  Prints the full disagreement set and checks it
against BOTH candidate criteria (l^2 <= mn) and (n >= m).
"""

import gap_10_4_chamber_diagnosis as C

MMAX = 6
NREP = C.NMAX - 2      # reliable q-order for reduced representatives

psS, FS, PS, phiS = C.compute_chamber(MMAX, "STD")


def cF(m, n, l):
    return FS[m].get((n, abs(l)), 0)


def naive(m, n, l):
    return (-1) ** (l + 1) * cF(m, n, l)


def invariant(m, n, l):
    m0, n0, l0 = C.reduce_form(m, n, l)
    if m0 > MMAX or n0 > NREP:
        return None
    return (-1) ** (l0 + 1) * cF(m0, n0, l0)


rows = []
for m in range(1, MMAX + 1):
    for n in range(1, NREP + 1):
        for l in range(0, m + 1):          # 0 <= l <= m
            D = 4 * m * n - l * l
            if D <= 0:
                continue
            inv = invariant(m, n, l)
            if inv is None:
                continue
            nv = naive(m, n, l)
            rows.append((m, n, l, D, nv, inv, nv == inv))

hold = [r for r in rows if r[6]]
fail = [r for r in rows if not r[6]]

print("Scanned %d points (0<=l<=m, Delta>0, reduced rep within range)." % len(rows))
print("  identity HOLDS: %d    FAILS: %d" % (len(hold), len(fail)))
print()

# ---- test candidate criterion A:  identity holds  <=>  l^2 <= mn ----
A_ok = all((r[2] ** 2 <= r[0] * r[1]) == r[6] for r in rows)
# ---- test candidate criterion B:  identity holds  <=>  n >= m ----
B_ok = all((r[1] >= r[0]) == r[6] for r in rows)
print("Criterion A  [ holds  <=>  l^2 <= mn ] :  %s" % ("CONFIRMED" if A_ok else "REFUTED"))
print("Criterion B  [ holds  <=>  n  >= m   ] :  %s" % ("CONFIRMED" if B_ok else "REFUTED"))
print()

# show the discriminating points where the two criteria disagree
disc = [r for r in rows if (r[2] ** 2 <= r[0] * r[1]) != (r[1] >= r[0])]
print("Points where the two criteria DISAGREE (l^2<=mn XOR n>=m):")
print("   (m,n,l)  Delta   naive        invariant     holds?  l^2<=mn  n>=m")
for m, n, l, D, nv, inv, ok in disc:
    print("   (%d,%d,%d)  %3d  %11d  %11d   %-5s   %-5s   %-5s"
          % (m, n, l, D, nv, inv, ok, l * l <= m * n, n >= m))

print()
print("All FAILING points (identity broken):")
print("   (m,n,l)  Delta   naive        invariant     l^2  mn   l^2>mn  n<m")
for m, n, l, D, nv, inv, ok in fail:
    print("   (%d,%d,%d)  %3d  %11d  %11d   %3d  %3d   %-5s   %-5s"
          % (m, n, l, D, nv, inv, l * l, m * n, l * l > m * n, n < m))

# HOLDING points that nonetheless have l^2 > mn  (these refute criterion A)
hold_lg = [r for r in rows if r[6] and r[2] ** 2 > r[0] * r[1]]
print()
print("HOLDING points with l^2 > mn (refute 'holds <=> l^2<=mn'):")
if not hold_lg:
    print("   (none)")
for m, n, l, D, nv, inv, ok in hold_lg:
    m0, n0, l0 = C.reduce_form(m, n, l)
    print("   (%d,%d,%d)  Delta=%d  l^2=%d mn=%d  reduced=(%d,%d,%d)  n<m=%s"
          % (m, n, l, D, l * l, m * n, m0, n0, l0, n < m))

# Characterise failing points by the REDUCED form: is it exactly 'not already reduced'?
print()
print("Reduced-form test:  identity holds  <=>  (m,n,l) already Gauss-reduced (n>=m and 0<=l<=m)?")


def is_reduced(m, n, l):
    return (0 <= l <= m <= n)


R_ok = all(is_reduced(r[0], r[1], r[2]) == r[6] for r in rows)
print("Criterion R  [ holds <=> (0<=l<=m<=n) ] :  %s" % ("CONFIRMED" if R_ok else "REFUTED"))
badR = [r for r in rows if is_reduced(r[0], r[1], r[2]) != r[6]]
for m, n, l, D, nv, inv, ok in badR[:40]:
    print("   MISMATCH (%d,%d,%d) holds=%s is_reduced=%s l^2=%d mn=%d"
          % (m, n, l, ok, is_reduced(m, n, l), l * l, m * n))

