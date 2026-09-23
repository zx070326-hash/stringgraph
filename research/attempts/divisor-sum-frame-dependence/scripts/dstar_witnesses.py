"""
Numerical witnesses: actual integer values of  D_I = sum_{s|I} s d_*(m/s^2, n, l/s)
on the frames enumerated by frame_structure.py.

d_* is taken from the existing implementation in
    research/attempts/torsion-immortal-positivity-hecke/scripts/coefficients.py
(read-only import; sys.dont_write_bytecode is set so nothing is written outside this
directory).  d_*(m,n,l) is computed by Gauss-reducing the form FIRST and then reading the
DMZ finite-part coefficient, as in that attempt's torsion_divisor_sum.py -- the mock
coefficient c_m^F(n,l) itself is not a class function outside the reduced domain.

Run:  python dstar_witnesses.py
"""

import os
import sys

sys.dont_write_bytecode = True

HERE = os.path.dirname(os.path.abspath(__file__))
HECKE = os.path.abspath(os.path.join(
    HERE, "..", "..", "torsion-immortal-positivity-hecke", "scripts"))
sys.path.insert(0, HERE)
sys.path.insert(0, HECKE)

import coefficients as C                                    # noqa: E402
from frame_structure import (                               # noqa: E402
    admissible_frames, chain, content, disc, divisors, gl_classes, reduce_gl,
)

MMAX = 9
C.NMAX, C.LMAX, C.LMIN, C.MARGIN = 12, 120, -60, 2

print("building 1/Phi_10 Fourier data: MMAX=%d, NMAX=%d ..." % (MMAX, C.NMAX))
_psis, _F, _P, _phis = C.compute(MMAX)
NREP = C.NMAX - C.MARGIN
print("done.\n")


def reduce_mnl(m, n, l):
    """Gauss-reduce (m,n,l) as the form (m,l,n); return (m0,n0,l0) with 0<=l0<=m0<=n0."""
    a, b, c = reduce_gl((m, l, n))
    return a, c, b


def dstar(m, n, l):
    if 4 * m * n - l * l <= 0 or m < 1 or n < 1:
        return None
    m0, n0, l0 = reduce_mnl(m, n, l)
    if m0 > MMAX or n0 > NREP:
        return None
    return (-1) ** (l0 + 1) * _F[m0].get((n0, abs(l0)), 0)


def D_I(m, n, l, I):
    tot = 0
    terms = []
    for s in divisors(I):
        t = dstar(m // (s * s), n, l // s)
        if t is None:
            return None, None
        terms.append((s, (m // (s * s), n, l // s), t))
        tot += s * t
    return tot, terms


def report(f, I, title):
    print("=" * 100)
    print(title)
    print("  form f = (m,l,n) = %s,  Delta = %d,  content = %d, torsion I = %d"
          % (str(f), -disc(f), content(f), I))
    fr = admissible_frames(f, I)
    vals = {}
    for H in sorted(fr):
        # pick the frame with the smallest max entry, for readability
        x, y, g, ch = min(fr[H], key=lambda t: max(abs(v) for v in t[2]))
        m, l, n = g
        tot, terms = D_I(m, n, l, I)
        cls = [reduce_gl(t) for t in ch]
        print("  H = <(%s) mod %d>   frame invariants (m,n,l) = (%d,%d,%d)"
              % (",".join(str(v % I) for v in (x, y)), I, m, n, l))
        for (s, t, v) in (terms or []):
            r = reduce_mnl(*t)
            print("      s=%d: d_*(m,n,l)=%-22s = d_*%-14s = %s"
                  % (s, str(t), str(r), v))
        if terms is None:
            print("      [out of the tabulated range of 1/Phi_10 coefficients]")
        print("      chain classes %s" % cls)
        print("      D_%d = %s" % (I, tot))
        vals.setdefault(tot, []).append(tuple(cls))
    print("  distinct integer values of D_%d over all admissible frames: %d  -> %s"
          % (I, len(vals), sorted(v for v in vals if v is not None)))
    print()
    return vals


if __name__ == "__main__":
    # 1. the paper's witness, reproduced
    report((4, 0, 4), 2,
           "WITNESS (paper Remark 6.3): frame DEPENDENT, h_prim(Delta/4 = 16) = 1")

    # 2. counterexample type (b): several admissible frames, all giving the SAME value,
    #    while h(Delta/4) > 1  -> refutes the 'only if' half of 'exactly when'
    report((2, 2, 8), 2,
           "COUNTEREXAMPLE (b): |C_2| = 2 but ONE value, while h(-15) = 2 > 1")
    report((4, 4, 4), 2,
           "COUNTEREXAMPLE (b'): |C_2| = 3 but ONE value, while h(-12) = 2 > 1")

    # 3. counterexample type (a): only one admissible H at all, h(Delta/4) = 2
    report((3, 0, 4), 2,
           "COUNTEREXAMPLE (a): |C_2| = 1, nothing to compare, while h(-12) = 2 > 1")

    # 4. odd p = 3, class-group mechanism, both with h(Delta/9) > 1:
    #    (6,6,9): [f1] = [(2,2,3)] ambiguous -> INDEPENDENT although h(-20) = 2
    #    (6,3,9): [f1] = [(2,-1,3)] not ambiguous, [p] not ambiguous -> DEPENDENT
    report((6, 6, 9), 3,
           "ODD p=3, [f1]^2 = 1 -> INDEPENDENT even though h(-20) = 2 (Delta = 180)")
    report((6, 3, 9), 3,
           "ODD p=3, [f1]^2 != 1 != [p]^2 -> DEPENDENT (Delta = 207, h(-23) = 3)")

    # 5. a second, smaller I=2 dependent case (not the paper's)
    report((4, 2, 6), 2,
           "SECOND DEPENDENT CASE: Delta = 92, I = 2, |C_2| = 2")

    print("=" * 100)
    print("classes of the relevant discriminants (GL classes, all contents):")
    for D in (-16, -15, -12, -20, -23):
        print("   disc %-5d : %s" % (D, gl_classes(D)))
