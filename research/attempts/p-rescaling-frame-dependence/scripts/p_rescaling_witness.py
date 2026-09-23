"""
Exact-integer witnesses for the P-rescaling torsion divisor sum.

Everything is exact integer arithmetic (Python ints); no floats enter any assertion.
Floats appear only in the final "relative size" printout, which is commentary.

Definitions used (paper.md notation: m = Q^2/2, n = P^2/2, l = Q.P):

    d_*(m,n,l)   immortal / attractor-contour index.  GL(2,Z)-class function of the
                 binary quadratic form [m,l,n]  (paper.md Prop A.1).  Computed as
                 (-1)^{l+1} c_m^F(n,l) AFTER Gauss reduction (outside the reduced
                 domain that identification is false -- see torsion_divisor_sum.py).

    D_I (m,n,l) = sum_{s|I} s * d_*(m/s^2, n, l/s)    "Q-rescaling"  = DGM (3.28)
    D'_I(m,n,l) = sum_{s|I} s * d_*(m, n/s^2, l/s)    "P-rescaling"  = AN  (2.13)

Terms with s^2 not dividing the rescaled slot, or s not dividing l, are omitted (0).

Run:   python p_rescaling_witness.py
(from this directory; it adds the hecke attempt's scripts dir to sys.path)
"""

import os
import sys

_HERE = os.path.dirname(os.path.abspath(__file__))
_HECKE = os.path.abspath(
    os.path.join(_HERE, "..", "..", "torsion-immortal-positivity-hecke", "scripts")
)
sys.path.insert(0, _HECKE)

import coefficients as C                      # noqa: E402
from torsion_divisor_sum import reduce_form   # noqa: E402

MMAX = 12      # max m index of the Fourier-Jacobi coefficient psi_m
NMAXv = 14     # q-order; usable n is NMAXv - MARGIN
LMAXv = 120
LMINv = -60


def divisors(k):
    return [d for d in range(1, k + 1) if k % d == 0]


def sl2_equivalent(f1, f2):
    """Both forms positive definite; equal iff same Gauss-reduced representative."""
    return reduce_form(*f1) == reduce_form(*f2)


def act(U, m, n, l):
    """New invariants of the frame (Q',P') = (aQ+bP, cQ+dP), U = [[a,b],[c,d]].

    m' = Q'^2/2 = a^2 m + a b l + b^2 n
    n' = P'^2/2 = c^2 m + c d l + d^2 n
    l' = Q'.P'  = 2 a c m + (a d + b c) l + 2 b d n
    """
    a, b, c, d = U
    return (a * a * m + a * b * l + b * b * n,
            c * c * m + c * d * l + d * d * n,
            2 * a * c * m + (a * d + b * c) * l + 2 * b * d * n)


def main():
    C.NMAX, C.LMAX, C.LMIN, C.MARGIN = NMAXv, LMAXv, LMINv, 2
    psis, F, P, phis = C.compute(MMAX)
    NREP = C.NMAX - C.MARGIN

    def mock(m, n, l):
        return (-1) ** ((l + 1) % 2) * F[m].get((n, abs(l)), 0)

    def total(m, n, l):
        return (-1) ** ((l + 1) % 2) * psis[m].get((n, abs(l)), 0)

    def _reduced_lookup(g, m, n, l):
        if 4 * m * n - l * l <= 0 or m < 1 or n < 1:
            return None
        m0, n0, l0 = reduce_form(m, n, l)
        if m0 > MMAX or n0 > NREP:
            return None
        return g(m0, n0, l0)

    def dstar(m, n, l):
        return _reduced_lookup(mock, m, n, l)

    def dtot(m, n, l):
        """Total (immortal + 2-centred) index, read at the ATTRACTOR chamber, i.e.
        again reduced first.  Used only as a second class function, to show the
        phenomenon is not an artifact of choosing d_*."""
        return _reduced_lookup(total, m, n, l)

    def DQ(f, I, m, n, l):
        """Q-rescaling divisor sum built from an arbitrary class function f."""
        tot = 0
        for s in divisors(I):
            if l % s or m % (s * s):
                continue
            t = f(m // (s * s), n, l // s)
            if t is None:
                return None
            tot += s * t
        return tot

    def DP(f, I, m, n, l):
        """P-rescaling divisor sum built from an arbitrary class function f."""
        tot = 0
        for s in divisors(I):
            if l % s or n % (s * s):
                continue
            t = f(m, n // (s * s), l // s)
            if t is None:
                return None
            tot += s * t
        return tot

    print("=" * 96)
    print("PART 0 -- sanity: d_* is a GL(2,Z) class function, and is m<->n symmetric")
    print("=" * 96)
    bad = []
    for m in range(1, 7):
        for n in range(1, 7):
            for l in range(-6, 7):
                if 4 * m * n - l * l <= 0:
                    continue
                a = dstar(m, n, l)
                for U in [(1, 1, 0, 1), (1, 0, 1, 1), (0, 1, -1, 0), (1, -1, 0, 1),
                          (-1, 0, -1, -1), (2, 1, 1, 1)]:
                    mm, nn, ll = act(U, m, n, l)
                    b = dstar(mm, nn, ll)
                    if b is not None and a is not None and a != b:
                        bad.append((m, n, l, U, a, b))
                if a is not None and dstar(n, m, l) is not None and a != dstar(n, m, l):
                    bad.append((m, n, l, "swap", a, dstar(n, m, l)))
    print(f"   violations of d_*(U.T) = d_*(T) or of d_*(m,n,l) = d_*(n,m,l): {len(bad)}")
    if bad:
        print("   ", bad[:5])

    print()
    print("=" * 96)
    print("PART 1 -- Theorem A:  D'_I(m,n,l) = D_I(n,m,l)   (reflection transfer)")
    print("=" * 96)
    checked, viol = 0, []
    for I in (1, 2, 3, 4, 6):
        for m in range(1, MMAX + 1):
            for n in range(1, NREP + 1):
                for l in range(0, 2 * (m + n) + 1):
                    if 4 * m * n - l * l <= 0:
                        continue
                    lhs = DP(dstar, I, m, n, l)
                    rhs = DQ(dstar, I, n, m, l)
                    if lhs is None or rhs is None:
                        continue
                    checked += 1
                    if lhs != rhs:
                        viol.append((I, m, n, l, lhs, rhs))
    print(f"   instances checked: {checked}    violations: {len(viol)}")
    if viol:
        print("   ", viol[:5])

    print()
    print("=" * 96)
    print("PART 2 -- Theorem B: two frames of ONE lattice, both P-adapted-compatible,")
    print("          on which the P-rescaling divisor sum D'_2 takes different values")
    print("=" * 96)
    I = 2
    base = (4, 4, 0)                   # (m,n,l);  Delta = 64
    U = (1, 0, 1, 1)                   # (Q,P) -> (Q, Q+P) in SL(2,Z)
    other = act(U, *base)
    print(f"   frame 1: (m,n,l) = {base}      Delta = {4*base[0]*base[1]-base[2]**2}")
    print(f"   frame 2: (m,n,l) = {other}      Delta = {4*other[0]*other[1]-other[2]**2}"
          f"   [ U = [[{U[0]},{U[1]}],[{U[2]},{U[3]}]], det = {U[0]*U[3]-U[1]*U[2]} ]")
    print(f"   SL(2,Z)-equivalent forms?  {sl2_equivalent(base, other)}"
          f"   (reduced rep = {reduce_form(*base)})")
    for name, (m, n, l) in (("frame 1", base), ("frame 2", other)):
        print(f"   {name}: I^2 | n ? {n % (I*I) == 0}    I | l ? {l % I == 0}"
              f"    [the hypotheses under which the P-rescaling formula is stated]")
    v1 = DP(dstar, I, *base)
    v2 = DP(dstar, I, *other)
    print()
    print(f"   d_*{base}               = {dstar(*base):>20d}")
    print(f"   d_*({base[0]},{base[1]//4},{base[2]//2})                 = {dstar(base[0], base[1]//4, base[2]//2):>20d}"
          f"     [ s = 2 term, reduced rep {reduce_form(base[0], base[1]//4, base[2]//2)} ]")
    print(f"   d_*{other}             = {dstar(*other):>20d}")
    o2 = (other[0], other[1] // 4, other[2] // 2)
    print(f"   d_*{o2}                 = {dstar(*o2):>20d}"
          f"     [ s = 2 term, reduced rep {reduce_form(*o2)} ]")
    print()
    print(f"   D'_2{base}  = {v1:>20d}")
    print(f"   D'_2{other} = {v2:>20d}")
    print(f"   difference               = {v1 - v2:>20d}")
    print(f"   equal? {v1 == v2}")
    if v1 != v2:
        print(f"   relative size |diff| / max  ~ {abs(v1-v2)/max(abs(v1),abs(v2)):.3e}   (commentary only)")
    # transpose cross-check against the Q-rescaling witness of paper.md Remark 6.3
    print()
    print("   transpose cross-check (paper.md Remark 6.3, Q-rescaling):")
    for (m, n, l) in ((base[1], base[0], base[2]), (other[1], other[0], other[2])):
        print(f"      D_2({m},{n},{l}) = {DQ(dstar, I, m, n, l):>20d}")

    print()
    print("=" * 96)
    print("PART 3 -- DGM (3.28) vs AN (2.13) at the SAME (m,n,l,I):  minimal witness")
    print("=" * 96)
    print("   domain: I^2|m AND I^2|n AND I|l  (both formulae's hypotheses hold simultaneously)")
    print(f"   {'I':>2} {'m':>3} {'n':>3} {'l':>3} {'Delta':>6}  {'D_I  (DGM)':>22} {'D_I  (AN)':>22} {'diff':>14}")
    found = []
    for I in (2, 3):
        for m in range(I * I, MMAX + 1, I * I):
            for n in range(I * I, NREP + 1, I * I):
                for l in range(0, 2 * (m + n) + 1, I):
                    if 4 * m * n - l * l <= 0:
                        continue
                    a = DQ(dstar, I, m, n, l)
                    b = DP(dstar, I, m, n, l)
                    if a is None or b is None:
                        continue
                    if a != b:
                        found.append((4 * m * n - l * l, I, m, n, l, a, b))
    found.sort()
    for D, I, m, n, l, a, b in found[:8]:
        print(f"   {I:>2} {m:>3} {n:>3} {l:>3} {D:>6}  {a:>22d} {b:>22d} {a-b:>14d}")
    print(f"   total disagreeing points in range: {len(found)}")
    if found:
        D, I, m, n, l, a, b = found[0]
        print()
        print("   MINIMAL WITNESS (smallest Delta, then smallest m):")
        print(f"      I = {I},  (m,n,l) = ({m},{n},{l}),  Delta = {D}")
        print(f"      DGM (3.28):  sum_s s d_*(m/s^2, n, l/s) = ", end="")
        print(" + ".join(f"{s}*d_*({m//(s*s)},{n},{l//s})"
                         for s in divisors(I) if m % (s*s) == 0 and l % s == 0),
              f"= {a}")
        print(f"      AN  (2.13):  sum_s s d_*(m, n/s^2, l/s) = ", end="")
        print(" + ".join(f"{s}*d_*({m},{n//(s*s)},{l//s})"
                         for s in divisors(I) if n % (s*s) == 0 and l % s == 0),
              f"= {b}")
        print(f"      the two s>1 arguments reduce to inequivalent forms:")
        for s in divisors(I)[1:]:
            if m % (s*s) == 0 and l % s == 0:
                print(f"         [{m//(s*s)},{l//s},{n}]  ->  {reduce_form(m//(s*s), n, l//s)}"
                      f"   d_* = {dstar(m//(s*s), n, l//s)}")
            if n % (s*s) == 0 and l % s == 0:
                print(f"         [{m},{l//s},{n//(s*s)}]  ->  {reduce_form(m, n//(s*s), l//s)}"
                      f"   d_* = {dstar(m, n//(s*s), l//s)}")
        print(f"      difference = {a-b}")

    print()
    print("=" * 96)
    print("PART 5 -- Theorem C:  D_I is invariant under Gamma^0(I) = {b = 0 mod I},")
    print("          D'_I is invariant under Gamma_0(I) = {c = 0 mod I}, and no more.")
    print("=" * 96)
    SL2 = [(a, b, c, d)
           for a in range(-4, 5) for b in range(-4, 5)
           for c in range(-4, 5) for d in range(-4, 5)
           if a * d - b * c == 1]
    print(f"   SL(2,Z) elements with entries in [-4,4]: {len(SL2)}")
    for I in (2, 3, 4):
        okQ = badQ = okP = badP = 0
        viol_in, viol_out = [], []
        for m in range(I * I, MMAX + 1, I * I):
            for n in range(1, NREP + 1):
                for l in range(0, 2 * (m + n) + 1, I):
                    if 4 * m * n - l * l <= 0:
                        continue
                    v0 = DQ(dstar, I, m, n, l)
                    if v0 is None:
                        continue
                    for (a, b, c, d) in SL2:
                        mm, nn, ll = act((a, b, c, d), m, n, l)
                        if mm < 1 or nn < 1 or mm % (I * I) or ll % I:
                            continue
                        v1 = DQ(dstar, I, mm, nn, ll)
                        if v1 is None:
                            continue
                        if b % I == 0:
                            if v1 == v0:
                                okQ += 1
                            else:
                                badQ += 1
                                viol_in.append((m, n, l, (a, b, c, d), v0, v1))
                        else:
                            if v1 != v0:
                                okP += 1
                                viol_out.append((m, n, l, (a, b, c, d), v0, v1))
                            else:
                                badP += 1
        print(f"   I = {I}:  b = 0 mod I  -> D_I preserved in {okQ} cases, VIOLATED in {badQ}")
        if viol_in:
            print(f"            !! counterexample to Theorem C: {viol_in[0]}")
        print(f"            b != 0 mod I -> D_I changed in {okP} cases, "
              f"happened to agree in {badP}")
        if viol_out:
            print(f"            e.g. {viol_out[0][:4]}: {viol_out[0][4]} -> {viol_out[0][5]}")

    print()
    print("   how many distinct values does D_2 take on the SL(2,Z)-orbit of (4,4,0)?")
    vals = {}
    for (a, b, c, d) in SL2:
        mm, nn, ll = act((a, b, c, d), 4, 4, 0)
        if mm < 1 or nn < 1 or mm % 4 or ll % 2:
            continue
        v = DQ(dstar, 2, mm, nn, ll)
        if v is None:
            continue
        vals.setdefault(v, []).append((a, b, c, d, mm, nn, ll))
    for v, reps in sorted(vals.items(), reverse=True):
        a, b, c, d, mm, nn, ll = reps[0]
        print(f"      D_2 = {v:>20d}   (e.g. U=[[{a},{b}],[{c},{d}]] -> ({mm},{nn},{ll}),"
              f"  b mod 2 = {b % 2},  {len(reps)} matrices)")
    print(f"      distinct values: {len(vals)}   [SL(2,Z):Gamma^0(2)] = 3,"
          f" the third coset is arithmetically inadmissible (4 does not divide m)")

    print()
    print("   value count over the SL(2,Z) orbit, for several I=2 base points")
    print("   (coset invariant of Gamma^0(2)\\SL(2,Z) is the top row (a,b) mod 2)")
    for base_pt in [(4, 4, 0), (4, 8, 0), (4, 8, 4), (8, 4, 4), (4, 12, 4), (12, 4, 4)]:
        m0, n0, l0 = base_pt
        if 4 * m0 * n0 - l0 * l0 <= 0 or m0 % 4 or l0 % 2:
            continue
        by_coset = {}
        for (a, b, c, d) in SL2:
            mm, nn, ll = act((a, b, c, d), m0, n0, l0)
            if mm < 1 or nn < 1 or mm % 4 or ll % 2:
                continue
            v = DQ(dstar, 2, mm, nn, ll)
            if v is None:
                continue
            by_coset.setdefault((a % 2, b % 2), set()).add(v)
        allv = set().union(*by_coset.values()) if by_coset else set()
        print(f"      base {base_pt}: {len(allv)} distinct D_2 values; per coset "
              + ", ".join(f"{k}->{sorted(v)}" for k, v in sorted(by_coset.items())))

    print()
    print("=" * 96)
    print("PART 4 -- the phenomenon is not special to d_*: same witness with the TOTAL index")
    print("=" * 96)
    if found:
        D, I, m, n, l, a, b = found[0]
        at = DQ(dtot, I, m, n, l)
        bt = DP(dtot, I, m, n, l)
        print(f"   at I={I}, (m,n,l)=({m},{n},{l}):  D_I[total] = {at},  D'_I[total] = {bt},"
              f"  differ? {at != bt}")
    v1t = DP(dtot, 2, *base)
    v2t = DP(dtot, 2, *other)
    print(f"   Theorem B witness with total index: {v1t} vs {v2t}, differ? {v1t != v2t}")
    print()
    print("   (Lemma: for ANY GL(2,Z)-class function f, D_I[f] and D'_I[f] disagree at")
    print("    (m,n,l,I) as soon as f separates the classes of [m/s^2, l/s, n] and")
    print("    [m, l/s, n/s^2] for some s|I, s>1.  d_* and the total index are two such f.)")

    print()
    print("=" * 96)
    print("PART 6 -- Theorem E: the SIGNED divisor sum (the DGM (3.26)+(3.27) / BSS (7) side)")
    print("          Dt_I = sum_s s (-1)^(l - l/s) d_*(m/s^2, n, l/s)")
    print("          Is it also Gamma^0(I)-invariant, or does the sign break it?")
    print("=" * 96)

    def DQ_signed(f, I, m, n, l):
        tot = 0
        for s in divisors(I):
            if l % s or m % (s * s):
                continue
            t = f(m // (s * s), n, l // s)
            if t is None:
                return None
            tot += s * (-1) ** ((l - l // s) % 2) * t
        return tot

    for I in (2, 3):
        ok = bad_ct = 0
        ex = None
        for m in range(I * I, 13, 1):
            for n in range(1, 13):
                for l in range(-12, 13):
                    if m % (I * I) or l % I or 4 * m * n - l * l <= 0:
                        continue
                    v0 = DQ_signed(dstar, I, m, n, l)
                    if v0 is None:
                        continue
                    for U in SL2:
                        if U[1] % I:
                            continue
                        mm, nn, ll = act(U, m, n, l)
                        v1 = DQ_signed(dstar, I, mm, nn, ll)
                        if v1 is None:
                            continue
                        if v0 == v1:
                            ok += 1
                        else:
                            bad_ct += 1
                            if ex is None:
                                ex = (m, n, l, U, v0, v1)
        print(f"   I = {I}:  b = 0 mod I  -> Dt_I preserved in {ok} cases, VIOLATED in {bad_ct}")
        if ex:
            print(f"            first violation: (m,n,l)={ex[:3]}, U={ex[3]}: {ex[4]} -> {ex[5]}")
    print()
    print("   parity check underlying the result: for U with I|b and I^2|m, I|l,")
    print("   is (-1)^(l' - l'/s) = (-1)^(l - l/s) for every s|I?")
    par_bad = 0
    for I in (2, 3, 4, 6):
        for m in range(I * I, 30, 1):
            for n in range(1, 30):
                for l in range(-20, 21):
                    if m % (I * I) or l % I or 4 * m * n - l * l <= 0:
                        continue
                    for U in SL2:
                        if U[1] % I:
                            continue
                        mm, nn, ll = act(U, m, n, l)
                        for s in divisors(I):
                            if mm % (s * s) or ll % s:
                                continue
                            if (ll - ll // s) % 2 != (l - l // s) % 2:
                                par_bad += 1
    print(f"      parity mismatches found: {par_bad}")


if __name__ == "__main__":
    main()
