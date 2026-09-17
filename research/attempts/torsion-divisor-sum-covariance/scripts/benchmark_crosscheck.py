"""
External cross-check of the project's Fourier engine against a published degeneracy table.

A table of N=4 dyon degeneracies d_micro as a function of the two charge invariants
D1 = Q^2, D2 = P^2 (at Q.P = 0) circulates in A. Sen's lectures/reviews on black holes in
string theory, with the entries

    (D1,D2) = (2,2)  -> 50064
              (4,4)  -> 32861184
              (6,4)  -> 632078672
              (8,4)  -> 9337042944
              (10,4) -> 113477152800

In our labels (m,n,l) = (Q^2/2, P^2/2, Q.P) these are (1,1,0), (2,2,0), (3,2,0), (4,2,0),
(5,2,0) -- careful: (D1,D2)=(8,4) is (m,n)=(4,2), and d_* is symmetric in m<->n, so the
script prints both the (m,n,l) triple and the (D1,D2) pair.

The script checks two things at once:

  (i) the engine reproduces all five published integers exactly;
  (ii) at these charges the TOTAL index and the IMMORTAL index coincide, i.e. the
       Appell-Lerch (two-centered) subtraction vanishes.  Without (ii) the published
       numbers would not be a legitimate cross-check of d_*, since the tables report the
       total (wall-crossing dependent) degeneracy.

Run:  python benchmark_crosscheck.py
"""

import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
SIB = os.path.normpath(os.path.join(HERE, "..", "..",
                                    "torsion-immortal-positivity-hecke", "scripts"))
sys.path.insert(0, SIB)
import coefficients as C  # noqa: E402

PUBLISHED = {            # (D1, D2) -> d_micro   (Q.P = 0)
    (2, 2): 50064,
    (4, 4): 32861184,
    (6, 4): 632078672,
    (8, 4): 9337042944,
    (10, 4): 113477152800,
}


def main():
    C.NMAX, C.LMAX, C.LMIN, C.MARGIN = 12, 240, -60, 2
    psis, F, P, phis = C.compute(6)

    def total(m, n, l):
        return (-1) ** (l + 1) * psis[m].get((n, abs(l)), 0)

    def immortal(m, n, l):
        return (-1) ** (l + 1) * F[m].get((n, abs(l)), 0)

    print(f"{'(D1,D2)':>9} {'(m,n,l)':>10} {'published':>16} {'total':>16} {'immortal':>16}"
          f"  {'tot=imm':>8} {'match':>6}")
    ok = True
    for (D1, D2), val in sorted(PUBLISHED.items()):
        m, n, l = D1 // 2, D2 // 2, 0
        t, i = total(m, n, l), immortal(m, n, l)
        match = (i == val)
        ok = ok and match and (t == i)
        print(f"{str((D1,D2)):>9} {str((m,n,l)):>10} {val:>16} {t:>16} {i:>16}"
              f"  {str(t==i):>8} {str(match):>6}")
    print()
    print("ALL FIVE ENTRIES REPRODUCED AND total == immortal:" , ok)


if __name__ == "__main__":
    main()
