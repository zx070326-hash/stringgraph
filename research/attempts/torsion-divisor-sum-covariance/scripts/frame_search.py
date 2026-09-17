"""
Frame-dependence search for the DGM/A-N torsion divisor sum.

Setting.  A 1/4-BPS dyon of N=4 string theory has charge pair (Q,P); S-duality acts by
(Q,P) -> (Q,P) U with U in SL(2,Z), i.e. on the Gram matrix

        T = [[ m , l/2 ], [ l/2 , n ]],   m = Q^2/2, n = P^2/2, l = Q.P

by T -> U^t T U.  The torsion I = gcd(Q^&P) is S-duality invariant, and so is the
physical index Omega_I.  DGM 0803.2692 eq(52) (equivalently Alexandrov-Nampuri
2009.01172 eq(2.13)) asserts

        Omega_I(m,n,l) = sum_{s | I} s * Omega_1(m/s^2, n, l/s).                (52)

The right-hand side only makes sense when s^2 | m and s | l for every s | I; call such a
frame ADMISSIBLE for I.  Admissibility is NOT an S-duality invariant condition.

This script answers, by exact integer arithmetic on binary quadratic forms:

  (Q-a) does every SL(2,Z)-orbit contain frames that are admissible and frames that are
        not?  (yes, trivially)
  (Q-b) THE SHARP QUESTION: are there two ADMISSIBLE frames T, T'' = U^t T U in the same
        orbit for which the right-hand side of (52) takes different values?

For (Q-b) we use that the immortal index d_*(m,n,l) is a class function for the full
GL(2,Z)-action (it is SL(2,Z)-invariant, and l -> -l is a symmetry of Phi_10); therefore
the RHS of (52) is determined by the multiset of GL(2,Z)-classes

        { reduce(m/s^2, n, l/s) : s | I }   with multiplicities s.

If two admissible frames of one orbit give DIFFERENT multisets of classes, the two RHS
values are different unless an accidental numerical coincidence of d_* occurs; the
companion script divisor_sum_values.py then evaluates the actual integers.

No third-party dependencies.  Exact integer arithmetic only.

Run:  python frame_search.py
"""


def reduce_form(m, n, l):
    """Gauss-reduce the positive definite form (m, l, n) = m x^2 + l xy + n y^2.

    Returns the canonical representative (m0, n0, l0) with 0 <= l0 <= m0 <= n0 of the
    GL(2,Z)-class (SL(2,Z)-class up to l -> -l).  Delta = 4mn - l^2 is preserved.
    """
    assert m > 0 and n > 0 and 4 * m * n - l * l > 0, (m, n, l)
    for _ in range(10000):
        if n < m:
            m, n, l = n, m, -l
            continue
        if l > m or l < -m:
            r = (l + m) // (2 * m)
            m, n, l = m, r * r * m - r * l + n, l - 2 * r * m
            continue
        break
    else:
        raise RuntimeError("reduction did not terminate")
    if l < 0:
        l = -l
    assert 0 <= l <= m <= n
    return (m, n, l)


def act(T, U):
    """T -> U^t T U for T = (m,n,l) (half-integral Gram) and U = (a,b,c,d) in GL(2,Z).

    Writing T = [[m, l/2],[l/2, n]] and U = [[a,b],[c,d]]:
        m'' = m a^2 + l a c + n c^2
        n'' = m b^2 + l b d + n d^2
        l'' = 2 m a b + l (a d + b c) + 2 n c d
    All entries stay integral, so the image is again a legal charge frame.
    """
    m, n, l = T
    a, b, c, d = U
    return (m * a * a + l * a * c + n * c * c,
            m * b * b + l * b * d + n * d * d,
            2 * m * a * b + l * (a * d + b * c) + 2 * n * c * d)


def divisors(k):
    return [d for d in range(1, k + 1) if k % d == 0]


def admissible(T, I):
    m, n, l = T
    return m % (I * I) == 0 and l % I == 0 and m > 0 and n > 0 and 4 * m * n - l * l > 0


def class_multiset(T, I):
    """The multiset {(s, reduced class of the s-th term)} that determines RHS of eq(52)."""
    m, n, l = T
    out = []
    for s in divisors(I):
        ms, ns, ls = m // (s * s), n, l // s
        if ms < 1 or ns < 1 or 4 * ms * ns - ls * ls <= 0:
            out.append((s, None))
        else:
            out.append((s, reduce_form(ms, ns, ls)))
    return tuple(out)


def sl2_ball(R):
    """All U in SL(2,Z) with |entries| <= R."""
    out = []
    for a in range(-R, R + 1):
        for b in range(-R, R + 1):
            for c in range(-R, R + 1):
                for d in range(-R, R + 1):
                    if a * d - b * c == 1:
                        out.append((a, b, c, d))
    return out


def main():
    print("=" * 100)
    print("PART 1.  Admissibility is not S-duality invariant (elementary).")
    print("=" * 100)
    T = (4, 1, 2)
    U = (1, 0, 1, 1)          # (Q,P) -> (Q+P, P)
    T2 = act(T, U)
    print(f"  T   = (m,n,l) = {T},  Delta = {4*T[0]*T[1]-T[2]**2},  admissible for I=2: {admissible(T,2)}")
    print(f"  U   = [[1,0],[1,1]]  i.e.  (Q,P) -> (Q+P, P);  torsion is preserved.")
    print(f"  T'' = U^t T U = {T2},  Delta = {4*T2[0]*T2[1]-T2[2]**2},  admissible for I=2: {admissible(T2,2)}")
    print(f"  same GL(2,Z) class:  {reduce_form(*T)} == {reduce_form(*T2)}  ->  {reduce_form(*T)==reduce_form(*T2)}")
    print()

    print("=" * 100)
    print("PART 2.  Two ADMISSIBLE frames in one orbit with different eq(52) right-hand sides.")
    print("=" * 100)
    Us = sl2_ball(2)
    for I in (2, 3, 4):
        found = []
        for m in range(I * I, 40 * I * I + 1, I * I):
            for n in range(1, 25):
                for l in range(0, 4 * m + 1, I):
                    T = (m, n, l)
                    if not admissible(T, I):
                        continue
                    cm = class_multiset(T, I)
                    for U in Us:
                        T2 = act(T, U)
                        if T2[0] < 1 or T2[1] < 1:
                            continue
                        if not admissible(T2, I):
                            continue
                        cm2 = class_multiset(T2, I)
                        if cm2 != cm:
                            found.append((T, U, T2, cm, cm2))
                    if len(found) >= 12:
                        break
                if len(found) >= 12:
                    break
            if len(found) >= 12:
                break
        print(f"\n--- I = {I}:  {len(found)} witness pair(s) found (search truncated at 12) ---")
        for (T, U, T2, cm, cm2) in found[:12]:
            print(f"   T={T} -> U={U} -> T''={T2}   class(T)={reduce_form(*T)}")
            print(f"       terms(T)  = {cm}")
            print(f"       terms(T'')= {cm2}")


if __name__ == "__main__":
    main()
