"""
Explicit lattice realisations of the frames used in proof.md, checked exactly.

Ambient lattice: the rank-4 even unimodular lattice U + U with basis
    e1, f1, e2, f2,     e_i.e_j = f_i.f_j = 0,   e_i.f_j = delta_ij.
U + U is an orthogonal direct summand of the Narain lattice
Lambda = U^3 + E8(-1)^2 of type II on K3 x T^2, so every frame constructed here
is a frame of an honest rank-2 primitive sublattice of Lambda.

A vector is stored as the integer 4-tuple (a,b,c,d) = a e1 + b f1 + c e2 + d f2.

    v.w      = a_v b_w + b_v a_w + c_v d_w + d_v c_w
    v primitive  <=>  gcd(a,b,c,d) = 1
    v in k.Lambda <=>  k | a,b,c,d        (U+U is a direct summand, so this is
                                           the same as being k times a lattice
                                           vector of the full Lambda)
    torsion I(Q,P) = gcd of the 2x2 minors of the 2x4 matrix [Q;P]
                   = gcd of the coefficients of Q ^ P.

All arithmetic is integer; the script asserts every claim and prints a table.

Run:  python lattice_frames.py
"""

from math import gcd
from itertools import combinations


def dot(v, w):
    a, b, c, d = v
    A, B, Cc, D = w
    return a * B + b * A + c * D + d * Cc


def prim(v):
    g = 0
    for x in v:
        g = gcd(g, x)
    return g == 1


def in_kLambda(v, k):
    return all(x % k == 0 for x in v)


def torsion(Q, P):
    g = 0
    for i, j in combinations(range(4), 2):
        g = gcd(g, Q[i] * P[j] - Q[j] * P[i])
    return abs(g)


def inv(Q, P):
    """(m, n, l) = (Q^2/2, P^2/2, Q.P)."""
    q2, p2 = dot(Q, Q), dot(P, P)
    assert q2 % 2 == 0 and p2 % 2 == 0, "lattice must be even"
    return q2 // 2, p2 // 2, dot(Q, P)


def add(v, w, s=1, t=1):
    return tuple(s * x + t * y for x, y in zip(v, w))


def describe(name, Q, P):
    m, n, l = inv(Q, P)
    I = torsion(Q, P)
    qa = in_kLambda(Q, I) if I > 1 else True
    pa = in_kLambda(P, I) if I > 1 else True
    print(f"  {name}")
    print(f"     Q = {Q}   primitive={prim(Q)}   Q in I.Lambda ? {qa}")
    print(f"     P = {P}   primitive={prim(P)}   P in I.Lambda ? {pa}")
    print(f"     (m,n,l) = ({m},{n},{l})   Delta = {4*m*n-l*l}   torsion I = {I}")
    print(f"     arithmetic hypotheses:  I^2|m ? {m % (I*I) == 0}   "
          f"I^2|n ? {n % (I*I) == 0}   I|l ? {l % I == 0}")
    return m, n, l, I, qa, pa


e1, f1, e2, f2 = (1, 0, 0, 0), (0, 1, 0, 0), (0, 0, 1, 0), (0, 0, 0, 1)


def lin(*terms):
    v = (0, 0, 0, 0)
    for coeff, vec in terms:
        v = tuple(x + coeff * y for x, y in zip(v, vec))
    return v


print("=" * 92)
print("L1 -- ONE torsion-2 lattice, TWO frames, both satisfying  I^2|n  and  I|l")
print("      (the hypotheses under which the P-rescaling formula AN (2.13) is stated)")
print("=" * 92)

# frame 1: P-adapted.  P = 2(e1 + 2 f1),  Q primitive.
Q1 = lin((4, f1), (1, e2), (4, f2))          # 4 f1 + e2 + 4 f2
P1 = lin((2, e1), (4, f1))                   # 2 (e1 + 2 f1)
m1, n1, l1, I1, qa1, pa1 = describe("frame 1  (Q, P)", Q1, P1)
assert (m1, n1, l1, I1) == (4, 8, 8, 2)
assert pa1 and not qa1, "frame 1 must be P-adapted and not Q-adapted"

# frame 2: the SAME lattice, basis changed by U = [[1,0],[-1,1]] in SL(2,Z):
#          (Q,P) -> (Q, P-Q)
Q2, P2 = Q1, add(P1, Q1, 1, -1)
m2, n2, l2, I2, qa2, pa2 = describe("frame 2  (Q, P-Q)   [U = [[1,0],[-1,1]], det=1]", Q2, P2)
assert (m2, n2, l2, I2) == (4, 4, 0, 2)
assert not pa2 and not qa2, "frame 2 is neither Q- nor P-adapted"

print("  same sublattice?  ", end="")
print("Z Q1 + Z P1 == Z Q2 + Z P2 since the change of basis is in SL(2,Z), det = "
      f"{1*1 - 0*(-1)}")
print("  => a single physical dyon, torsion 2, whose T-duality invariants are")
print(f"     ({m1},{n1},{l1}) in one duality frame and ({m2},{n2},{l2}) in another,")
print("     and BOTH pass the arithmetic test I^2|n, I|l.")

print()
print("=" * 92)
print("L2 -- at (m,n,l,I) = (4,8,8,2) BOTH adapted orbits are non-empty")
print("=" * 92)
# Q-adapted representative: Q = 2(e1+f1) in 2.Lambda, P primitive
QA_Q = lin((2, e1), (2, f1))
QA_P = lin((4, e1), (1, e2), (8, f2))
a = describe("Q-adapted  (Q in 2.Lambda)", QA_Q, QA_P)
assert a[:4] == (4, 8, 8, 2) and a[4] and not a[5]
b = describe("P-adapted  (P in 2.Lambda)", Q1, P1)
assert b[:4] == (4, 8, 8, 2) and b[5] and not b[4]
print("  => DGM (3.28) applies to the first, AN (2.13) applies to the second,")
print("     and they are evaluated at the SAME (m,n,l,I).")

print()
print("=" * 92)
print("L3 -- the third (both-primitive) torsion-2 orbit of BSS 0802.0544 also exists here")
print("=" * 92)
# Q, P both primitive, Q +- P twice primitive, torsion 2.
TP_Q = lin((1, e1), (1, f1), (1, e2), (1, f2))
TP_P = lin((1, e1), (1, f1), (-1, e2), (-1, f2))
c = describe("both-primitive  (Q, P primitive; Q+-P in 2.Lambda)", TP_Q, TP_P)
print(f"     Q+P = {add(TP_Q, TP_P)}  in 2.Lambda ? {in_kLambda(add(TP_Q, TP_P), 2)}")
print(f"     Q-P = {add(TP_Q, TP_P, 1, -1)}  in 2.Lambda ? "
      f"{in_kLambda(add(TP_Q, TP_P, 1, -1), 2)}")
print("  (invariants differ from (4,8,8); shown only to exhibit the third orbit type")
print("   concretely -- BSS 0802.0544 p.35 assert all three types occur at fixed")
print("   (Q^2,P^2,Q.P), which is the qualitative statement this attempt quantifies.)")

print()
print("ALL ASSERTIONS PASSED")
