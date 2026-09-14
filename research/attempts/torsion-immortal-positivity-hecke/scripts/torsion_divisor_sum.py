"""
Torsion divisor sums for the immortal index: DGM eq(51) vs eq(52).

Conventions as in coefficients.py (Rossello):
    1/Phi_10(rho,sigma,v) = sum_m psi_m(sigma,v) p^m,  psi_m = sum c_m(n,l) q^n y^l.

d_*(m,n,l) is the ATTRACTOR-contour Fourier coefficient (Rossello (R4)/(R5)).  It is
invariant under the S-duality action T -> A^t T A of SL(2,Z) on T = [[m,l/2],[l/2,n]]
(because Phi_10 is, and the attractor contour Im Omega = 2 Lambda adj(T) is covariant),
and on GAUSS-REDUCED forms (0 <= l <= m <= n) it equals (-1)^{l+1} c_m^F(n,l)
(Rossello Thm 1's domain is exactly the set of reduced forms).

*** Outside the reduced domain the identification FAILS ***: c_m^F(n,l) depends only on
(Delta, l mod 2m), which is NOT an SL(2,Z)-invariant labelling.  Example produced below:
(m,n,l) = (5,1,4) is SL(2,Z)-equivalent to (1,1,0), so d_* = 50064, whereas
(-1)^{l+1} c_5^F(1,4) = -2023536 < 0.  This is the "with some restrictions" caveat of
arXiv:2510.05219.  Hence every d_* below is computed by FIRST reducing the form.

Two readings of the torsion-I reduction of Dabholkar-Gomes-Murthy (arXiv:0803.2692):

(A)  eq(52):  d_*^{(I)}(m,n,l) = sum_{s|I} s * d_*(m/s^2, n, l/s)
     Generating function  G_I = sum_{s|I} s G(s^2 rho, sigma, s v),
     G = 1/Phi_10(rho,sigma,v+1/2).  Positive weights only.

(B)  eq(50)+(51):  Z_I = sum_{s|I} s/Phi_10(s^2 rho, sigma, s v), index = (-1)^{l+1} x coeff
     =>  d_*^{(I)}(m,n,l) = sum_{s|I} s * (-1)^{l - l/s} * d_*(m/s^2, n, l/s)
     The weight is NEGATIVE exactly when s is even and l/s is odd.

Run:  python torsion_divisor_sum.py
"""

import coefficients as C


def divisors(k):
    return [d for d in range(1, k + 1) if k % d == 0]


def reduce_form(m, n, l):
    """Gauss-reduce the positive definite form [m, l, n] (Delta = 4mn - l^2 > 0).
    Returns (m0, n0, l0) with 0 <= l0 <= m0 <= n0 and the same SL(2,Z)-orbit
    (up to l -> -l, which is a symmetry of Phi_10)."""
    assert 4 * m * n - l * l > 0 and m > 0 and n > 0
    for _ in range(10000):
        if n < m:
            m, n, l = n, m, -l
            continue
        if l > m or l < -m:
            r = (l + m) // (2 * m)          # nearest: puts l into (-m, m]
            m, n, l = m, r * r * m - r * l + n, l - 2 * r * m
            continue
        break
    else:
        raise RuntimeError("reduction did not terminate")
    if l < 0:
        l = -l
    assert 0 <= l <= m <= n, (m, n, l)
    return m, n, l


def main(MMAX=16, NMAXv=6, LMAXv=120, LMINv=-60):
    C.NMAX, C.LMAX, C.LMIN, C.MARGIN = NMAXv, LMAXv, LMINv, 2
    psis, F, P, phis = C.compute(MMAX)
    NREP = C.NMAX - C.MARGIN

    def mock(m, n, l):
        return (-1) ** (l + 1) * F[m].get((n, abs(l)), 0)

    def dstar(m, n, l):
        """attractor / immortal index: reduce first, then read the mock coefficient."""
        if 4 * m * n - l * l <= 0 or m < 1 or n < 1:
            return None
        m0, n0, l0 = reduce_form(m, n, l)
        if m0 > MMAX or n0 > NREP:
            return None
        return mock(m0, n0, l0)

    print("d_*(m,n,l) at small charges (reduced first):")
    for (m, n, l) in [(1, 1, 0), (1, 1, 1), (1, 2, 0), (1, 2, 1),
                      (2, 2, 0), (2, 2, 1), (2, 2, 2), (5, 1, 4), (4, 1, 2), (9, 1, 3)]:
        v = dstar(m, n, l)
        print(f"   d_*({m},{n},{l}) = {v!s:>16}   Delta={4*m*n-l*l:>4}"
              f"   reduced={reduce_form(m,n,l)}   naive mock={mock(m,n,l) if m<=MMAX and n<=NREP else '-'}")

    print()
    print("--- total index vs immortal index: the divisor sum must act on the IMMORTAL part ---")
    def tot(m, n, l):
        return (-1) ** (l + 1) * psis[m].get((n, abs(l)), 0)
    hits = []
    for m in range(1, MMAX + 1):
        for n in range(m, NREP + 1):
            for l in range(0, 2 * m + 1):
                if 4 * m * n - l * l <= 0:
                    continue
                if tot(m, n, l) < 0 < mock(m, n, l):
                    hits.append((m, n, l, 4 * m * n - l * l, tot(m, n, l), mock(m, n, l)))
    print("   (m,n,l,Delta, total, immortal) with total < 0 < immortal:")
    for h in hits[:6]:
        print("     ", h)
    print("     count in range:", len(hits))

    print()
    print("--- where does  (-1)^{l+1} c_m^F(n,l) = d_*(m,n,l) ?  (scan) ---")
    agree, disagree = 0, []
    for m in range(1, MMAX + 1):
        for n in range(1, NREP + 1):
            for l in range(0, 2 * m + 1):
                if 4 * m * n - l * l <= 0:
                    continue
                v = dstar(m, n, l)
                if v is None:
                    continue
                if mock(m, n, l) == v:
                    agree += 1
                else:
                    disagree.append((m, n, l, mock(m, n, l), v))
    print(f"   agree: {agree}   disagree: {len(disagree)}")
    print(f"   all disagreements have n < m ? "
          f"{all(r[1] < r[0] for r in disagree)}   (reduced forms need n >= m)")
    print(f"   e.g. {disagree[:4]}")

    print()
    print("=" * 104)
    print("Torsion divisor sums.  Domain: I^2|m, I|l, m,n>=1, Delta=4mn-l^2>0.")
    print("=" * 104)
    print(f"{'I':>2} {'m':>4} {'n':>3} {'l':>4} {'Delta':>6}  {'(A) eq(52)':>24} {'(B) eq(51)':>24}  {'A=B':>5} {'A>0':>5} {'B>0':>5}")
    differ, negA, negB, rows, skipped = [], [], [], 0, 0
    for I in (1, 2, 3, 4, 6):
        for m in range(I * I, MMAX + 1, I * I):
            for n in range(1, NREP + 1):
                for l in range(0, 4 * m + 1, I):
                    D = 4 * m * n - l * l
                    if D <= 0:
                        continue
                    A = B = 0
                    ok = True
                    for s in divisors(I):
                        t = dstar(m // (s * s), n, l // s)
                        if t is None:
                            ok = False
                            break
                        A += s * t
                        B += s * (-1) ** (l - l // s) * t
                    if not ok:
                        skipped += 1
                        continue
                    rows += 1
                    same = (A == B)
                    if not same:
                        differ.append((I, m, n, l, D, A, B))
                    if A <= 0:
                        negA.append((I, m, n, l, D, A, B))
                    if B <= 0:
                        negB.append((I, m, n, l, D, A, B))
                    if I > 1 and not same:
                        print(f"{I:>2} {m:>4} {n:>3} {l:>4} {D:>6}  {A:>24d} {B:>24d}  "
                              f"{str(same):>5} {str(A>0):>5} {str(B>0):>5}")

    print()
    print(f"rows tested: {rows}   (skipped, out of computed range: {skipped})")
    print(f"rows with (A) != (B): {len(differ)}")
    print(f"rows with (A) <= 0  : {len(negA)}   -> {negA[:3] if negA else 'none  [Prop C]'}")
    print(f"rows with (B) <= 0  : {len(negB)}   -> {negB[:3] if negB else 'none found in range'}")
    if differ:
        I, m, n, l, D, A, B = min(differ, key=lambda r: (r[4], r[1]))
        print()
        print("Minimal witness that eq(52) and eq(51) give different integers:")
        print(f"   I={I}, (m,n,l)=({m},{n},{l}), Delta={D}")
        print(f"   (A) eq(52) = {A}")
        print(f"   (B) eq(51) = {B}")
        print(f"   A - B      = {A-B} = 4 * d_*({m//4},{n},{l//2}) = {4*dstar(m//4,n,l//2)}")


if __name__ == "__main__":
    main()
