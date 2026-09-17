"""
Frame-dependence of the DGM/A-N torsion divisor sum, with BOTH charge vectors PRIMITIVE.

Why this script exists.  The first witnesses (frame_search.py / lattice_witness.py) use a
frame in which one of Q, P is a non-primitive lattice vector.  Parts of the literature
(e.g. Banerjee-Sen-Srivastava 0802.0544) restrict attention to Q, P both primitive, so a
sceptic could say the witness is outside the intended scope.  Here we search for witnesses
with Q and P both primitive.

Set-up (pure lattice theory, exact integers).  Let

    M   = saturated rank-2 sublattice of the charge lattice, basis (w,u),
          Gram  w^2/2 = mu,  u^2/2 = nu,  w.u = lam,   positive definite;
    L   = Z(I w) + Z u  subset of  M,     so  M/L = Z/I  (cyclic)  and  [M:L] = I.

Every pair (Q,P) that is a BASIS of L ("frame") is (Q,P) = (a Q0 + c P0, b Q0 + d P0) with
(Q0,P0) = (I w, u) and [[a,b],[c,d]] in SL(2,Z).  Write coordinates in the basis (w,u):
    Q = (aI, c),   P = (bI, d).
Primitivity of a vector in M (equivalently in the ambient lattice, M being saturated) is
gcd of its coordinates = 1.

Two quantities are compared for each frame:

  DGM(frame) = sum_{s|I} s * d_*( m/s^2 , n , l/s )          [eq(52) read literally]
  TRUE       = sum_{s|I} s * d_*( T_{L_s} ),  L_s = Z((I/s) w) + Z u    [intermediate lattices]

TRUE is frame-independent by construction (the L_s are the canonical intermediate lattices
L subset L' subset M, indexed by the subgroups of M/L = Z/I).  In an ADAPTED frame -- one
with Q in I*M, i.e. c = 0 mod I -- the two agree term by term.  The script looks for frames
where they DISAGREE while Q and P are both primitive and the frame is admissible
(I^2 | m and I | l, which is the hypothesis of the paper's Theorem 6.1).

No third-party dependencies.  Exact integer arithmetic only.

Run:  python primitive_frame_search.py
"""

from math import gcd

from frame_search import reduce_form, divisors, sl2_ball


def q_form(mu, nu, lam, x, y):
    """(x w + y u)^2 / 2."""
    return mu * x * x + lam * x * y + nu * y * y


def bilin(mu, nu, lam, v1, v2):
    """(x1 w + y1 u) . (x2 w + y2 u)."""
    x1, y1 = v1
    x2, y2 = v2
    return 2 * mu * x1 * x2 + lam * (x1 * y2 + x2 * y1) + 2 * nu * y1 * y2


def true_multiset(mu, nu, lam, I):
    """{(s, class of T_{L_s})} for the canonical intermediate lattices L subset L' subset M."""
    out = []
    for s in divisors(I):
        t = I // s
        out.append((s, reduce_form(t * t * mu, nu, t * lam)))
    return tuple(out)


def dgm_multiset(m, n, l, I):
    """{(s, class of (m/s^2, n, l/s))} -- eq(52) read literally in this frame."""
    out = []
    for s in divisors(I):
        if m % (s * s) or l % s:
            out.append((s, None))
            continue
        ms, ls = m // (s * s), l // s
        if ms < 1 or n < 1 or 4 * ms * n - ls * ls <= 0:
            out.append((s, None))
        else:
            out.append((s, reduce_form(ms, n, ls)))
    return tuple(out)


def search(I, MAXPAR=6, R=3, want=6):
    """Search for admissible frames with Q,P primitive whose eq(52) terms differ from TRUE."""
    hits = []
    Us = sl2_ball(R)
    for mu in range(1, MAXPAR + 1):
        for nu in range(1, MAXPAR + 1):
            for lam in range(-2 * MAXPAR, 2 * MAXPAR + 1):
                if 4 * mu * nu - lam * lam <= 0:
                    continue
                truth = true_multiset(mu, nu, lam, I)
                for (a, b, c, d) in Us:
                    Qc, Pc = (a * I, c), (b * I, d)
                    if gcd(abs(Qc[0]), abs(Qc[1])) != 1:
                        continue
                    if gcd(abs(Pc[0]), abs(Pc[1])) != 1:
                        continue
                    m = q_form(mu, nu, lam, *Qc)
                    n = q_form(mu, nu, lam, *Pc)
                    l = bilin(mu, nu, lam, Qc, Pc)
                    if m < 1 or n < 1 or 4 * m * n - l * l <= 0:
                        continue
                    if m % (I * I) or l % I:          # admissibility = Thm 6.1 hypothesis
                        continue
                    got = dgm_multiset(m, n, l, I)
                    if got != truth:
                        hits.append(dict(mu=mu, nu=nu, lam=lam, U=(a, b, c, d),
                                         T=(m, n, l), dgm=got, truth=truth,
                                         adapted=(c % I == 0)))
                        if len(hits) >= want:
                            return hits
    return hits


def main():
    print("=" * 100)
    print("Witnesses with BOTH Q and P primitive, frame admissible (I^2|m, I|l),")
    print("eq(52) read literally  !=  canonical intermediate-lattice sum.")
    print("=" * 100)
    for I in (2, 3):
        hits = search(I)
        print(f"\n--- I = {I}: {len(hits)} witness(es) (search truncated) ---")
        for h in hits:
            mu, nu, lam = h["mu"], h["nu"], h["lam"]
            a, b, c, d = h["U"]
            print(f"  M = (mu,nu,lam) = {(mu,nu,lam)}  class {reduce_form(mu,nu,lam)}  "
                  f"Delta_M = {4*mu*nu-lam*lam}")
            print(f"  U = [[{a},{b}],[{c},{d}]]   Q = {a*I} w + {c} u   P = {b*I} w + {d} u"
                  f"   (adapted? {h['adapted']})")
            print(f"  frame invariants (m,n,l) = {h['T']}   Delta = "
                  f"{4*h['T'][0]*h['T'][1]-h['T'][2]**2}")
            print(f"     eq(52) terms : {h['dgm']}")
            print(f"     true   terms : {h['truth']}")
            print()


if __name__ == "__main__":
    main()
