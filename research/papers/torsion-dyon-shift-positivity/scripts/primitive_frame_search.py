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

import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)

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


def sublattice_bases(I):
    """All L with L subset M, [M:L] = I, M/L cyclic, in Hermite normal form.

    Basis vectors are given in coordinates with respect to (w,u).  For I squarefree
    every index-I sublattice has cyclic quotient, so this is all of them; there are
    psi(I) = I * prod_{p|I} (1 + 1/p) of them (3 for I=2, 4 for I=3).
    """
    out = []
    for a in divisors(I):
        d = I // a
        for c in range(a):
            B = ((a, 0), (c, d))
            if gcd(gcd(a, 0), gcd(c, d)) == 1:          # M/L cyclic
                out.append(B)
    return out


def contains(outer, v):
    """Is v (in (w,u) coordinates) in the lattice spanned by the pair `outer`?"""
    (p1, p2) = outer
    det = p1[0] * p2[1] - p1[1] * p2[0]
    x = v[0] * p2[1] - v[1] * p2[0]
    y = p1[0] * v[1] - p1[1] * v[0]
    return x % det == 0 and y % det == 0


def true_multiset_general(mu, nu, lam, B, I):
    """{(s, class of T_{L'})} over the canonical intermediate lattices L subset L' subset M.

    L' is the unique sublattice of index I/s in M containing L; uniqueness is what
    makes the multiset frame-independent (M/L is cyclic, so it has one subgroup per
    divisor).  Returns None if L is not of index I with cyclic quotient.
    """
    (b1, b2) = B
    out = []
    for s in divisors(I):
        cand = [X for X in sublattice_bases(I // s)
                if contains(X, b1) and contains(X, b2)]
        if len(cand) != 1:
            return None
        (p1, p2) = cand[0]
        out.append((s, reduce_form(q_form(mu, nu, lam, *p1),
                                   q_form(mu, nu, lam, *p2),
                                   bilin(mu, nu, lam, p1, p2))))
    return tuple(out)


def m_classes(D):
    """All GL(2,Z) classes of positive definite integral binary forms of discriminant D.

    Imprimitive forms included: the saturation M is an arbitrary rank-2 positive
    definite lattice, so no primitivity is imposed on its Gram form.
    """
    out = set()
    for mu in range(1, D + 1):
        for lam in range(-mu, mu + 1):
            if (lam * lam + D) % (4 * mu):
                continue
            nu = (lam * lam + D) // (4 * mu)
            if nu >= mu:
                out.add(reduce_form(mu, nu, lam))
    return sorted(out)


def frame_dependent_count(mu, nu, lam, B, I, R, require_primitive):
    """Number of admissible frames of L on which eq(52) differs from the canonical sum."""
    truth = true_multiset_general(mu, nu, lam, B, I)
    if truth is None:
        return None
    (b1, b2) = B
    hits = 0
    for (a, b, c, d) in sl2_ball(R):
        Q = (a * b1[0] + c * b2[0], a * b1[1] + c * b2[1])
        P = (b * b1[0] + d * b2[0], b * b1[1] + d * b2[1])
        if require_primitive and (gcd(*map(abs, Q)) != 1 or gcd(*map(abs, P)) != 1):
            continue
        m = q_form(mu, nu, lam, *Q)
        n = q_form(mu, nu, lam, *P)
        l = bilin(mu, nu, lam, Q, P)
        if m < 1 or n < 1 or 4 * m * n - l * l <= 0:
            continue
        if m % (I * I) or l % I:                        # admissibility
            continue
        if dgm_multiset(m, n, l, I) != truth:
            hits += 1
    return hits


def sweep(DMAX=24, R=6, Is=(2, 3)):
    """The systematic search behind Remark 6.8.

    For every discriminant Delta_M <= DMAX, every GL(2,Z) class of M of that
    discriminant, every sublattice L of index I with cyclic quotient, and every frame
    in the SL(2,Z) ball of radius R: does some admissible frame of L make eq(52)
    disagree with the canonical intermediate-lattice sum?  Run both with the
    both-primitive requirement and without it.
    """
    rows = []
    for D in range(3, DMAX + 1):
        cls = m_classes(D)
        if not cls:
            continue
        for I in Is:
            for (mu, nu, lam) in cls:
                for B in sublattice_bases(I):
                    prim = frame_dependent_count(mu, nu, lam, B, I, R, True)
                    if prim is None:
                        continue
                    anyf = frame_dependent_count(mu, nu, lam, B, I, R, False)
                    rows.append(dict(D=D, H=len(cls), I=I, cls=(mu, nu, lam),
                                     L=B, prim=prim, any=anyf))
    return rows


def verify_prop_69(DMAX=40, R=7, primes=(2, 3, 5)):
    """Proposition 6.9: for L = Z(p w) + Z u of index p in M, if p does not divide
    nu = u^2/2 then the s=p term of eq(52) lies in the class of M on EVERY admissible
    frame, hence D_p is frame-independent.

    The proof is unconditional: admissibility forces c = p c', and then
    V = [[a, p b], [c', d]] has det 1, so (a w + c' u, p b w + d u) is an SL(2,Z)
    basis of M whose Gram form is exactly (m/p^2, n, l/p).

    This routine checks the conclusion directly, and separately records that the
    hypothesis is not vacuous and that it is genuinely needed (i.e. that violations
    appear as soon as p | nu).
    """
    held = held_bad = 0
    failed = failed_dep = 0
    for p in primes:
        for D in range(3, DMAX + 1):
            for (mu, nu, lam) in m_classes(D):
                canon = reduce_form(mu, nu, lam)
                dep = False
                for (a, b, c, d) in sl2_ball(R):
                    Q, P = (p * a, c), (p * b, d)
                    m = q_form(mu, nu, lam, *Q)
                    n = q_form(mu, nu, lam, *P)
                    l = bilin(mu, nu, lam, Q, P)
                    if m < 1 or n < 1 or 4 * m * n - l * l <= 0:
                        continue
                    if m % (p * p) or l % p:
                        continue
                    if reduce_form(m // (p * p), n, l // p) != canon:
                        dep = True
                        break
                if nu % p:
                    held += 1
                    held_bad += 1 if dep else 0
                else:
                    failed += 1
                    failed_dep += 1 if dep else 0
    return dict(held=held, held_bad=held_bad, failed=failed, failed_dep=failed_dep)


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

    DMAX, R = 24, 6
    print("=" * 100)
    print(f"Systematic sweep of Remark 6.8: Delta_M <= {DMAX}, all GL(2,Z) classes of M,")
    print(f"all index-I sublattices L with M/L cyclic, SL(2,Z) ball of radius {R}.")
    print("'prim' counts frames with Q,P both primitive; 'any' drops that requirement.")
    print("=" * 100)
    rows = sweep(DMAX, R)
    print(f"\n{'Delta_M':>7} {'H':>2} {'I':>2}  {'class of M':>12}  {'L basis':>18} "
          f"{'prim':>5} {'any':>5}")
    for r in rows:
        mark = "   <== FRAME-DEPENDENT" if r["any"] else ""
        print(f"{r['D']:>7} {r['H']:>2} {r['I']:>2}  {str(r['cls']):>12}  "
              f"{str(r['L']):>18} {r['prim']:>5} {r['any']:>5}{mark}")

    print("\n--- conclusions drawn in Remark 6.8 ---")
    for I in (2, 3):
        hit_D = sorted({r["D"] for r in rows if r["I"] == I and r["any"]})
        print(f"  I = {I}: discriminants Delta_M <= {DMAX} admitting a frame-dependent "
              f"L: {hit_D}")
        print(f"         smallest = {hit_D[0] if hit_D else None}; dropping primitivity "
              f"adds none: "
              f"{sorted({r['D'] for r in rows if r['I']==I and r['prim']}) == hit_D}")
    bad = sorted({r["D"] for r in rows if r["H"] >= 2 and not r["any"]}
                 - {r["D"] for r in rows if r["any"]})
    print(f"  H(Delta_M) >= 2 but NO frame-dependent L at either I: {bad}")
    print("     -> the converse of Proposition 6.5 is false.")
    for D in sorted({r["D"] for r in rows if r["any"]}):
        for I in (2, 3):
            per = [(r["cls"], r["L"], r["any"]) for r in rows if r["D"] == D and r["I"] == I]
            if not any(p[2] for p in per):
                continue
            tot = {}
            for c, L, a in per:
                tot.setdefault(c, [0, 0])
                tot[c][0] += 1 if a else 0
                tot[c][1] += 1
            desc = ", ".join(f"{c}: {v[0]} of {v[1]}" for c, v in tot.items())
            print(f"  Delta_M = {D}, I = {I}: frame-dependent sublattices per class -- {desc}")
    print("     -> the deciding datum is the pair L subset M, not M alone.")

    print("\n" + "=" * 100)
    print("Proposition 6.9: L = Z(p w) + Z u of index p in M.  If p does not divide")
    print("nu = u^2/2, then D_p is frame-independent.  p in {2,3,5}, Delta_M <= 40.")
    print("=" * 100)
    v = verify_prop_69()
    print(f"  (p,M) pairs where the hypothesis p does not divide nu HOLDS : {v['held']}")
    print(f"     of these, frame-DEPENDENT (must be 0)                    : {v['held_bad']}")
    print(f"  (p,M) pairs where it FAILS                                  : {v['failed']}")
    print(f"     of these, frame-dependent (shows the hypothesis is needed): {v['failed_dep']}")
    print(f"  RESULT: {'ALL OK' if v['held_bad'] == 0 and v['failed_dep'] > 0 else 'MISMATCH'}")


if __name__ == "__main__":
    main()
