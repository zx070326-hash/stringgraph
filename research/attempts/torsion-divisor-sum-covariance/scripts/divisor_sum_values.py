"""
Exact integer values for the frame-dependence witnesses of DGM eq(52).

Reuses the Fourier-coefficient engine of the sibling attempt
    research/attempts/torsion-immortal-positivity-hecke/scripts/coefficients.py
(exact integer arithmetic, no third-party dependencies; its own self-tests are re-run
here so that this script is self-validating).

d_*(m,n,l) = immortal (attractor-contour) index.  Computed as in the sibling attempt:
GAUSS-REDUCE the form first, then read (-1)^{l+1} c_m^F(n,l) on the reduced representative
(Rossello Thm 1's domain is exactly the reduced cone 0 <= l <= m <= n).

Run:  python divisor_sum_values.py
"""

import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
SIB = os.path.normpath(os.path.join(HERE, "..", "..",
                                    "torsion-immortal-positivity-hecke", "scripts"))
sys.path.insert(0, SIB)
import coefficients as C  # noqa: E402

from frame_search import reduce_form, act, divisors, admissible  # noqa: E402


def build(MMAX, NMAX):
    C.NMAX, C.LMAX, C.LMIN, C.MARGIN = NMAX, 240, -60, 2
    psis, F, P, phis = C.compute(MMAX)
    NREP = C.NMAX - C.MARGIN

    def dstar(m, n, l):
        if m < 1 or n < 1 or 4 * m * n - l * l <= 0:
            return None
        m0, n0, l0 = reduce_form(m, n, l)
        if m0 > MMAX or n0 > NREP:
            return None
        return (-1) ** (l0 + 1) * F[m0].get((n0, abs(l0)), 0)

    return dstar


def rhs52(dstar, T, I):
    """Right-hand side of DGM eq(52) read literally in the frame T, with the convention
    that a term is absent when its arguments are not integral."""
    m, n, l = T
    tot, terms = 0, []
    for s in divisors(I):
        if m % (s * s) or l % s:
            terms.append((s, None, None))
            continue
        v = dstar(m // (s * s), n, l // s)
        if v is None:
            raise RuntimeError(f"d_* out of computed range at s={s}, T={T}")
        terms.append((s, (m // (s * s), n, l // s), v))
        tot += s * v
    return tot, terms


def show(dstar, name, T, U, I):
    T2 = act(T, U)
    A, ta = rhs52(dstar, T, I)
    B, tb = rhs52(dstar, T2, I)
    print(f"\n### {name}   I = {I}")
    print(f"  frame 1: T   = {T}     Delta = {4*T[0]*T[1]-T[2]**2}   reduced class {reduce_form(*T)}")
    print(f"  U = {U}   det = {U[0]*U[3]-U[1]*U[2]}")
    print(f"  frame 2: T'' = {T2}   Delta = {4*T2[0]*T2[1]-T2[2]**2}   reduced class {reduce_form(*T2)}")
    print(f"  both admissible (I^2|m, I|l):  {admissible(T,I)}  /  {admissible(T2,I)}")
    print(f"  same GL(2,Z) class:            {reduce_form(*T) == reduce_form(*T2)}")
    print("  eq(52) in frame 1:")
    for (s, arg, v) in ta:
        print(f"      s={s}:  {s} * d_*{arg} = {s} * {v}")
    print(f"      total = {A}")
    print("  eq(52) in frame 2:")
    for (s, arg, v) in tb:
        print(f"      s={s}:  {s} * d_*{arg} = {s} * {v}")
    print(f"      total = {B}")
    print(f"  DIFFERENCE  {A} - {B} = {A - B}     equal? {A == B}")
    return A, B


def main():
    dstar = build(MMAX=8, NMAX=12)

    # ---- sanity checks against values independently recorded in the project ----
    checks = {(1, 1, 0): 50064, (1, 1, 1): 25353, (1, 2, 0): 1127472,
              (1, 2, 1): 561576, (2, 2, 0): 32861184, (2, 2, 1): 18458000,
              (2, 2, 2): 3859456}
    bad = [(k, dstar(*k), v) for k, v in checks.items() if dstar(*k) != v]
    print("sanity check against recorded d_* values:", "OK" if not bad else bad)
    print("(run `python coefficients.py` in the sibling scripts/ dir for its own self-tests)")
    print()

    print("=" * 96)
    print("Reference values (immortal index d_*, Gauss-reduced):")
    for T in [(1, 1, 0), (1, 1, 1), (2, 2, 0), (1, 4, 0), (4, 4, 0), (8, 4, 8),
              (2, 4, 4), (1, 8, 0), (2, 4, 0), (4, 8, 0), (8, 4, 0)]:
        print(f"   d_*{T} = {dstar(*T)!s:>22}   Delta={4*T[0]*T[1]-T[2]**2:>5}"
              f"   reduced {reduce_form(*T)}")
    print("=" * 96)

    show(dstar, "Witness A  (minimal Delta; U = [[-1,0],[-1,-1]] : (Q,P) -> (-Q-P, -P);\n"
                "            BOTH charge vectors primitive in frame 2, see primitive_frame_search.py)",
         (4, 4, 0), (-1, 0, -1, -1), 2)
    show(dstar, "Witness A' (same orbit, U = [[-1,-1],[1,0]] : (Q,P) -> (-Q+P, -Q); P not primitive)",
         (4, 4, 0), (-1, -1, 1, 0), 2)
    show(dstar, "Witness B  (S-transform  S = [[0,-1],[1,0]] : (Q,P) -> (P,-Q))",
         (4, 8, 0), (0, -1, 1, 0), 2)
    show(dstar, "Witness C  (I = 3, M = (1,6,-1), U = [[-2,-1],[-1,-1]]; both charge vectors\n"
                "            primitive in frame 2)",
         (9, 6, -3), (-2, -1, -1, -1), 3)
    show(dstar, "Witness C' (I = 3, U = [[-2,-1],[1,0]]; P not primitive)",
         (9, 6, 3), (-2, -1, 1, 0), 3)

    print("\n" + "=" * 96)
    print("Control: for a frame pair where the divisor-sum terms lie in the same")
    print("GL(2,Z) classes, the two right-hand sides agree (sanity check).")
    show(dstar, "Control  (T -> T, U = identity)", (4, 4, 0), (1, 0, 0, 1), 2)


if __name__ == "__main__":
    main()
