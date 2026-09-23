"""
Experiments for research/attempts/divisor-sum-frame-dependence.

All arithmetic is exact (Python ints).  Nothing here needs d_*; the statements tested are
statements about which *lattices* the divisor sum evaluates d_* on.  A separate script,
dstar_witnesses.py, plugs in the actual integers.

Run:  python experiments.py [section...]
      sections: selftest witness scan criterion tables lambda   (default: all)
"""

import sys
from math import gcd

from frame_structure import (
    act, admissible_frames, all_reduced_forms, chain, class_number, content,
    disc, divisors, frame_from_primitive, gl_classes, is_admissible, is_ambiguous,
    prime_form, reduce_gl, reduce_sl, reduced_primitive_forms, value_classes,
)


def hline(t=""):
    print("\n" + "=" * 100)
    if t:
        print(t)
        print("=" * 100)


# --------------------------------------------------------------------------- #
def sec_selftest():
    hline("SELF-TESTS")
    # reduction is a class function and idempotent
    import random
    random.seed(1)
    bad = 0
    for _ in range(4000):
        a = random.randint(1, 30)
        b = random.randint(-30, 30)
        c = random.randint(1, 30)
        if b * b - 4 * a * c >= 0:
            continue
        f = (a, b, c)
        r = reduce_gl(f)
        assert disc(r) == disc(f)
        assert reduce_gl(r) == r
        # a random SL(2,Z) change of frame must not move the class
        for _ in range(3):
            k = random.randint(-3, 3)
            f2 = act(f, (1, k, 0, 1))
            f3 = act(f2, (0, -1, 1, 0))
            if reduce_gl(f3) != r:
                bad += 1
    print("  reduce_gl is an SL(2,Z)-class function and idempotent:", "OK" if bad == 0 else "FAIL %d" % bad)

    # content is a class invariant
    bad = 0
    for _ in range(2000):
        a, b, c = random.randint(1, 20), random.randint(-20, 20), random.randint(1, 20)
        if b * b - 4 * a * c >= 0:
            continue
        f = (a, b, c)
        g = act(f, (1, 2, 1, 3))         # det = 1
        if content(f) != content(g):
            bad += 1
    print("  content is a class invariant:", "OK" if bad == 0 else "FAIL %d" % bad)

    # admissibility and the chain depend only on H = <(x,y) mod I>, not on the lift
    bad = []
    for f in [(4, 0, 4), (4, 4, 6), (3, 3, 18), (9, 6, 6), (8, 4, 10), (16, 8, 5)]:
        for I in (2, 3, 4, 6):
            vc = value_classes(f, I, box=4 * I + 5)
            for H, classes in vc.items():
                if len(classes) != 1:
                    bad.append((f, I, H, classes))
    print("  chain class depends only on H (not on the lift of (x,y)):",
          "OK" if not bad else "FAIL %s" % bad[:2])

    # class numbers against known values
    known = {-3: 1, -4: 1, -7: 1, -8: 1, -11: 1, -15: 2, -20: 2, -23: 3, -47: 5,
             -71: 7, -163: 1, -427: 2}
    bad = [(D, class_number(D), h) for D, h in known.items() if class_number(D) != h]
    print("  class numbers h(D) match tables:", "OK" if not bad else "FAIL %s" % bad)


# --------------------------------------------------------------------------- #
def sec_witness():
    hline("THE PAPER'S WITNESS (Remark 6.3):  L = (m,l,n) = (4,0,4), I = 2")
    f = (4, 0, 4)
    print("  disc f = %d,  Delta = %d,  content = %d" % (disc(f), -disc(f), content(f)))
    vc = value_classes(f, 2)
    fr = admissible_frames(f, 2)
    print("  |C_2(L)| = %d admissible subgroups H" % len(vc))
    for H, lst in sorted(fr.items()):
        x, y, g, ch = lst[0]
        classes = sorted(value_classes(f, 2)[H])[0]
        print("    H = <(%d,%d) mod 2>   sample frame form (m,l,n) = %s" % (x % 2, y % 2, g))
        print("        chain N_s (s=1,2) as forms: %s  ->  GL-classes %s"
              % (list(ch), list(classes)))
    allcl = set()
    for H in vc:
        allcl |= vc[H]
    print("  distinct chains over all admissible frames: %d  -> %s" % (len(allcl), sorted(allcl)))
    print("  => frame dependent" if len(allcl) > 1 else "  => frame independent")
    print("  classes of discriminant -Delta/4 = %d: %s (h_prim = %d, total = %d)"
          % (disc(f) // 4, all_reduced_forms(disc(f) // 4),
             class_number(disc(f) // 4), len(all_reduced_forms(disc(f) // 4))))


# --------------------------------------------------------------------------- #
def sec_scan(DMAX=400, IMAX=6):
    hline("SCAN: frame dependence vs. class number, all reduced forms with Delta <= %d" % DMAX)
    rows = []
    for Delta in range(3, DMAX + 1):
        D = -Delta
        if D % 4 not in (0, 1):
            continue
        for f in gl_classes(D):
            for I in range(2, IMAX + 1):
                vc = value_classes(f, I, box=4 * I + 5)
                if not vc:
                    continue
                allcl = set()
                for H in vc:
                    allcl |= vc[H]
                dep = len(allcl) > 1
                # the paper's predicate, three readings of "class number of Delta/s^2":
                #   (tot) all SL classes of that discriminant (primitive + imprimitive)
                #   (gl)  all GL classes = isometry classes of even lattices of det Delta/s^2
                #   (prim) only primitive SL classes
                hs, hsp = [], []
                ok = True
                for s in divisors(I):
                    if s == 1:
                        continue
                    if Delta % (s * s):
                        ok = False
                        break
                    hs.append(len(gl_classes(-Delta // (s * s))))
                    hsp.append(class_number(-Delta // (s * s)))
                if not ok:
                    continue
                paper = any(h > 1 for h in hs)
                paper_prim = any(h > 1 for h in hsp)
                rows.append((Delta, f, I, len(vc), len(allcl), dep, tuple(hs), paper,
                             tuple(hsp), paper_prim))

    n = len(rows)
    tt = [r for r in rows if r[5] and r[7]]
    tf = [r for r in rows if r[5] and not r[7]]
    ft = [r for r in rows if not r[5] and r[7]]
    ff = [r for r in rows if not r[5] and not r[7]]
    print("  cases (L, I) with at least one admissible frame: %d" % n)
    print("  %-34s %6s %6s" % ("", "h>1", "all h=1"))
    print("  %-34s %6d %6d" % ("frame DEPENDENT", len(tt), len(tf)))
    print("  %-34s %6d %6d" % ("frame INDEPENDENT", len(ft), len(ff)))
    print()
    print("  'frame dependent AND all h = 1' must be empty  (this is the TRUE direction "
          "of the paper's claim): %s" % ("EMPTY - confirmed" if not tf else "NONEMPTY %s" % tf[:3]))
    print("  'frame independent AND h > 1' is the counterexample box to 'exactly when': %d cases"
          % len(ft))
    print("     smallest 12 counterexamples (Delta, f, I, |C_I|, #values, h(Delta/s^2)):")
    for r in sorted(ft, key=lambda r: (r[0], r[2], r[1]))[:12]:
        print("       Delta=%-4d f=%-14s I=%d  |C_I|=%d  #values=%d  h=%s"
              % (r[0], str(r[1]), r[2], r[3], r[4], list(r[6])))
    print()
    print("     of those, the ones with |C_I| >= 2 (genuinely several admissible frames, "
          "all giving the SAME value):")
    hard = [r for r in ft if r[3] >= 2]
    for r in sorted(hard, key=lambda r: (r[0], r[2]))[:12]:
        print("       Delta=%-4d f=%-14s I=%d  |C_I|=%d  #values=%d  h=%s"
              % (r[0], str(r[1]), r[2], r[3], r[4], list(r[6])))
    print("     total with |C_I| >= 2: %d" % len(hard))

    print()
    print("  --- the other reading: 'class number' = number of PRIMITIVE classes ---")
    tf2 = [r for r in rows if r[5] and not r[9]]
    print("  frame DEPENDENT with all primitive class numbers = 1: %d cases" % len(tf2))
    print("  (under this reading even the 'if' direction of the paper's claim fails;")
    print("   the paper's own witness is among these)")
    for r in sorted(tf2, key=lambda r: (r[0], r[2]))[:8]:
        print("       Delta=%-4d f=%-14s I=%d  |C_I|=%d  #values=%d  h_prim=%s  h_tot=%s"
              % (r[0], str(r[1]), r[2], r[3], r[4], list(r[8]), list(r[6])))

    print()
    print("  --- frame DEPENDENT cases, smallest 12 ---")
    for r in sorted(tt, key=lambda r: (r[0], r[2]))[:12]:
        print("       Delta=%-4d f=%-14s I=%d  |C_I|=%d  #values=%d  h_tot=%s"
              % (r[0], str(r[1]), r[2], r[3], r[4], list(r[6])))
    print("  maximum number of distinct values of D_I observed: %d"
          % max(r[4] for r in rows))
    for r in sorted(rows, key=lambda r: -r[4])[:3]:
        print("       Delta=%-4d f=%-14s I=%d  |C_I|=%d  #values=%d"
              % (r[0], str(r[1]), r[2], r[3], r[4]))
    return rows


# --------------------------------------------------------------------------- #
def sec_criterion(DMAX=3000):
    hline("CRITERION TEST (odd p, v_p(content) = 1):  independent  <=>  [f1]^2=1 or [p]^2=1")
    print("  f = p*c'*f1 with f1 primitive of disc D1;  p splits in O_{D1};  |C_p| = 2.")
    tested = 0
    bad = []
    examples = []
    for p in (3, 5, 7, 11, 13):
        for Delta in range(3, DMAX + 1):
            D = -Delta
            if D % 4 not in (0, 1):
                continue
            if Delta % (p * p):
                continue
            for f in all_reduced_forms(D):
                cf = content(f)
                if cf % p != 0 or cf % (p * p) == 0:
                    continue                      # need v_p(content) == 1
                vc = value_classes(f, p, box=4 * p + 5)
                if len(vc) != 2:
                    continue
                allcl = set()
                for H in vc:
                    allcl |= vc[H]
                dep = len(allcl) > 1
                cprime = cf // p
                f1 = tuple(t // cf for t in f)
                D1 = disc(f1)
                pf = prime_form(p, D1)
                if pf is None:
                    bad.append(("p does not split", p, f))
                    continue
                pred = is_ambiguous(f1) or is_ambiguous(pf)
                tested += 1
                if pred == dep:                   # predicted independent <=> not dep
                    bad.append((p, f, f1, D1, dep, pred, sorted(allcl)))
                else:
                    examples.append((p, Delta, f, f1, D1, class_number(D1),
                                     is_ambiguous(f1), is_ambiguous(pf), dep))
    print("  cases tested: %d" % tested)
    print("  mismatches  : %d %s" % (len(bad), "" if not bad else bad[:3]))
    print()
    print("  sample: (p, Delta, f, f1, D1, h(D1), [f1] amb?, [p] amb?, frame-dependent?)")
    seen = set()
    for e in examples:
        key = (e[0], e[6], e[7], e[8])
        if key in seen:
            continue
        seen.add(key)
        print("    ", e)
    print()
    print("  KEY POINT: h(D1) is unbounded in the 'independent' rows -> class NUMBER is not")
    print("  the criterion.  Largest h(D1) among frame-INDEPENDENT rows: %s"
          % max([e[5] for e in examples if not e[8]] or [0]))
    print("  Largest h(D1) among frame-DEPENDENT rows:     %s"
          % max([e[5] for e in examples if e[8]] or [0]))


# --------------------------------------------------------------------------- #
def sec_tables(DMAX=2000):
    hline("CLAIM D: the size of C_p(L) from local data (odd p)")
    print("  alpha = v_p(content f), beta = v_p(Delta) - alpha;  p splits/inert in O_{-Delta/p^2}")
    for p in (3, 5, 7):
        tab = {}
        for Delta in range(3, DMAX + 1):
            D = -Delta
            if D % 4 not in (0, 1):
                continue
            for f in all_reduced_forms(D):
                al = 0
                cf = content(f)
                while cf % p == 0:
                    al += 1
                    cf //= p
                vD = 0
                t = Delta
                while t % p == 0:
                    vD += 1
                    t //= p
                be = vD - al
                vc = value_classes(f, p, box=4 * p + 5)
                if al == 1 and be == 1:
                    Dov = -Delta // (p * p)
                    split = prime_form(p, Dov) is not None
                    key = (al, be, "split" if split else "inert")
                else:
                    key = (al, min(be, 2))
                tab.setdefault(key, set()).add(len(vc))
        print("  p = %d" % p)
        for k in sorted(tab, key=str):
            print("     alpha,beta%-22s -> |C_p| in %s" % (str(k), sorted(tab[k])))

    hline("CLAIM D3: p = 2")
    tab = {}
    for Delta in range(3, DMAX + 1):
        D = -Delta
        if D % 4 not in (0, 1):
            continue
        for f in all_reduced_forms(D):
            m, l, n = f
            pred = 0 if l % 2 else sum(1 for v in (m, n, m + l + n) if v % 4 == 0)
            got = len(value_classes(f, 2, box=13))
            tab.setdefault(pred == got, 0)
            tab[pred == got] += 1
    print("  #{v in {m,n,m+l+n} : 4|v}  (and l even) predicts |C_2(L)| :",
          "OK on %d forms" % tab.get(True, 0) if not tab.get(False) else "FAIL %d" % tab[False])


# --------------------------------------------------------------------------- #
def sec_lambda():
    hline("CLAIM B: the non-adapted frame evaluates d_* on a lattice OUTSIDE Lambda")
    # Lambda = U + U, basis e1,f1,e2,f2;  e_i . f_i = 1, all other products 0.
    G = [[0, 1, 0, 0], [1, 0, 0, 0], [0, 0, 0, 1], [0, 0, 1, 0]]

    def ip(u, v):
        return sum(u[i] * G[i][j] * v[j] for i in range(4) for j in range(4))

    w = (1, 1, 0, 0)                     # primitive, w^2 = 2
    Q = tuple(2 * t for t in w)          # Q = 2w,  Q^2 = 8  -> m = 4
    P = (0, 0, 1, 4)                     # P^2 = 8 -> n = 4 ;  Q.P = 0
    m, n, l = ip(Q, Q) // 2, ip(P, P) // 2, ip(Q, P)
    print("  Lambda = U + U;  Q = 2(e1+f1),  P = e2+4f2")
    print("  (m,n,l) = (%d,%d,%d),  Delta = %d" % (m, n, l, 4 * m * n - l * l))

    # torsion I = gcd of the 2x2 minors of the matrix with rows Q, P
    minors = []
    for i in range(4):
        for j in range(i + 1, 4):
            minors.append(Q[i] * P[j] - Q[j] * P[i])
    I = 0
    for t in minors:
        I = gcd(I, abs(t))
    print("  torsion I = gcd(Q^P) = %d" % I)

    def in_lambda(vec):                  # vec given as rational 4-tuple (num, den)
        num, den = vec
        return all(t % den == 0 for t in num)

    print()
    print("  frame 1 (adapted):   (Q, P)      -> (m,n,l) = (%d,%d,%d)" % (m, n, l))
    print("     N_2 = Z(Q/2)+ZP,  Q/2 = %s  in Lambda? %s" % (w, in_lambda((Q, 2))))
    Q2 = tuple(-a - b for a, b in zip(Q, P))
    P2 = tuple(-b for b in P)
    m2, n2, l2 = ip(Q2, Q2) // 2, ip(P2, P2) // 2, ip(Q2, P2)
    print("  frame 2 (NOT adapted): (-Q-P, -P) -> (m,n,l) = (%d,%d,%d)" % (m2, n2, l2))
    print("     N_2' = Z(Q2/2)+ZP2,  Q2/2 = %s/2  in Lambda? %s"
          % (str(Q2), in_lambda((Q2, 2))))
    print()
    print("  So the s=2 term of the second frame is d_* of a lattice that is NOT a sublattice")
    print("  of the charge lattice Lambda.  That is the whole mechanism of Remark 6.3.")
    print()
    print("  chains as forms:")
    print("     frame 1: %s -> classes %s"
          % (list(chain((m, l, n), 2)), [reduce_gl(t) for t in chain((m, l, n), 2)]))
    print("     frame 2: %s -> classes %s"
          % (list(chain((m2, l2, n2), 2)), [reduce_gl(t) for t in chain((m2, l2, n2), 2)]))


# --------------------------------------------------------------------------- #
if __name__ == "__main__":
    secs = sys.argv[1:] or ["selftest", "witness", "lambda", "scan", "criterion", "tables"]
    for s in secs:
        globals()["sec_" + s]()
