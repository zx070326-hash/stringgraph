"""
Lattice-theoretic verification of the frame-dependence diagnosis.

Everything is exact integer arithmetic inside the even unimodular lattice

    N = U + U  (rank 4, signature (2,2)),   basis e1, f1, e2, f2,
    <e_i, f_i> = 1,  <e_i,e_j> = <f_i,f_j> = 0,

which embeds primitively as a direct summand into Gamma^{6,22} (the N=4 charge lattice);
a primitive sublattice of N stays primitive in N + R for any complement R, so all
primitivity/torsion statements below hold verbatim in Gamma^{6,22}.

Notation for a charge pair (Q,P):
    m = Q^2/2, n = P^2/2, l = Q.P,   T = [[m,l/2],[l/2,n]],
    L = ZQ + ZP,  M = saturation of L in the ambient lattice,
    I = gcd(Q ^ P) = gcd of the 2x2 minors of the 2 x rank matrix of (Q,P).

Verified claims:
  (V1) I = [M : L]                                   (Lemma 1 of proof.md)
  (V2) Witness A charges are realizable with I = 2, in both frames.
  (V3) Frame 2 of witness A is admissible (I^2|m, I|l) but NOT adapted (Q/2 not in the
       lattice); the lattice <Q'/2, P'> it implicitly uses is not contained in the
       ambient lattice at all.
  (V4) Two charge pairs with IDENTICAL (m,n,l,I) = (8,4,8,2) but non-isometric
       saturations M (Gram classes (1,4,0) and (2,2,0)); the second one HAS an adapted
       frame with these very invariants.

Run:  python lattice_witness.py
"""

from math import gcd
from itertools import combinations

from frame_search import reduce_form

# ---------------------------------------------------------------- ambient lattice
# vectors are 4-tuples of integers in the basis (e1,f1,e2,f2)
def ip(x, y):
    """<x,y> in U + U."""
    return x[0] * y[1] + x[1] * y[0] + x[2] * y[3] + x[3] * y[2]


def invariants(Q, P):
    m2, n2, l = ip(Q, Q), ip(P, P), ip(Q, P)
    assert m2 % 2 == 0 and n2 % 2 == 0, "ambient lattice is even"
    return (m2 // 2, n2 // 2, l)


def torsion(Q, P):
    """gcd of the 2x2 minors of the 2x4 matrix with rows Q,P  =  gcd(Q ^ P)."""
    mins = [Q[i] * P[j] - Q[j] * P[i] for i, j in combinations(range(4), 2)]
    g = 0
    for v in mins:
        g = gcd(g, v)
    return g


# ---------------------------------------------------------------- Smith normal form
def smith(A):
    """Smith normal form of an integer matrix A (list of rows).
    Returns (D, U, V) with D = U A V, U and V unimodular.  Naive but exact."""
    A = [row[:] for row in A]
    r, c = len(A), len(A[0])
    U = [[int(i == j) for j in range(r)] for i in range(r)]
    V = [[int(i == j) for j in range(c)] for i in range(c)]

    def swap_rows(i, j):
        A[i], A[j] = A[j], A[i]
        U[i], U[j] = U[j], U[i]

    def swap_cols(i, j):
        for row in A:
            row[i], row[j] = row[j], row[i]
        for row in V:
            row[i], row[j] = row[j], row[i]

    def addrow(i, j, k):           # row_i += k * row_j
        A[i] = [a + k * b for a, b in zip(A[i], A[j])]
        U[i] = [a + k * b for a, b in zip(U[i], U[j])]

    def addcol(i, j, k):           # col_i += k * col_j
        for row in A:
            row[i] += k * row[j]
        for row in V:
            row[i] += k * row[j]

    t = 0
    while t < min(r, c):
        # find a pivot
        piv = None
        for i in range(t, r):
            for j in range(t, c):
                if A[i][j] != 0:
                    piv = (i, j)
                    break
            if piv:
                break
        if piv is None:
            break
        swap_rows(t, piv[0])
        swap_cols(t, piv[1])
        done = False
        while not done:
            done = True
            for i in range(t + 1, r):
                if A[i][t]:
                    addrow(i, t, -(A[i][t] // A[t][t]))
                    if A[i][t]:
                        swap_rows(t, i)
                        done = False
            for j in range(t + 1, c):
                if A[t][j]:
                    addcol(j, t, -(A[t][j] // A[t][t]))
                    if A[t][j]:
                        swap_cols(t, j)
                        done = False
        t += 1
    return A, U, V


def inv_unimodular(V):
    """Inverse of a unimodular integer matrix, by exact fraction-free elimination."""
    n = len(V)
    M = [V[i][:] + [int(i == j) for j in range(n)] for i in range(n)]
    col = 0
    for row in range(n):
        p = next(i for i in range(row, n) if M[i][col] != 0)
        M[row], M[p] = M[p], M[row]
        if M[row][col] < 0:
            M[row] = [-x for x in M[row]]
        for i in range(n):
            if i != row and M[i][col]:
                # integer elimination is enough because det = +-1
                f = M[i][col] // M[row][col]
                M[i] = [a - f * b for a, b in zip(M[i], M[row])]
                while M[i][col]:
                    M[row], M[i] = M[i], M[row]
                    f = M[i][col] // M[row][col]
                    M[i] = [a - f * b for a, b in zip(M[i], M[row])]
        col += 1
    out = []
    for i in range(n):
        assert M[i][i] in (1, -1), M
        s = M[i][i]
        out.append([s * x for x in M[i][n:]])
    return out


def saturation(Q, P):
    """Basis of M = saturation of ZQ + ZP, and the index [M : ZQ+ZP]."""
    A = [list(Q), list(P)]
    D, U, V = smith(A)
    d1, d2 = D[0][0], D[1][1]
    Vinv = inv_unimodular(V)                     # rows w_i, D = U A V  =>  A = U^-1 D V^-1
    w1, w2 = tuple(Vinv[0]), tuple(Vinv[1])
    return (w1, w2), abs(d1 * d2)


def gram_class(u, v):
    m2, n2, l = ip(u, u), ip(v, v), ip(u, v)
    return reduce_form(m2 // 2, n2 // 2, l)


def report(name, Q, P):
    m, n, l = invariants(Q, P)
    I = torsion(Q, P)
    (u, v), idx = saturation(Q, P)
    print(f"\n{name}")
    print(f"   Q = {Q}   P = {P}")
    print(f"   (m,n,l) = {(m,n,l)}   Delta = {4*m*n-l*l}   class {reduce_form(m,n,l)}")
    print(f"   I = gcd(Q^P) = {I}      [M:L] from Smith normal form = {idx}      (V1) {I == idx}")
    print(f"   saturation basis  u = {u},  v = {v}")
    print(f"   Gram class of M  = {gram_class(u,v)}   (Delta/I^2 = {(4*m*n-l*l)//(I*I)})")
    print(f"   admissible for I (I^2|m, I|l): {m % (I*I) == 0 and l % I == 0}")
    div = all(x % I == 0 for x in Q)
    print(f"   adapted (Q in I*Lattice):      {div}")
    return (m, n, l, I), gram_class(u, v)


def main():
    e1, f1, e2, f2 = (1, 0, 0, 0), (0, 1, 0, 0), (0, 0, 1, 0), (0, 0, 0, 1)

    def add(*vs):
        return tuple(sum(c) for c in zip(*vs))

    def mul(k, v):
        return tuple(k * x for x in v)

    print("=" * 96)
    print("WITNESS A -- one physical charge, two S-duality frames")
    print("=" * 96)
    Q = mul(2, add(e1, f1))                 # 2(e1+f1)
    P = add(e2, mul(4, f2))                 # e2 + 4 f2
    invA1, clsA1 = report("frame 1  (adapted)", Q, P)

    # S-duality U = [[-1,-1],[1,0]] :  (Q,P) -> (-Q+P, -Q)
    Q2 = add(mul(-1, Q), P)
    P2 = mul(-1, Q)
    invA2, clsA2 = report("frame 2  (admissible, NOT adapted)", Q2, P2)
    print(f"\n   same lattice L in both frames: {sorted([Q2,P2]) != sorted([Q,P])} "
          f"(different bases)   same saturation class: {clsA1 == clsA2}")
    print(f"   invariants differ: {invA1} vs {invA2}, both admissible for I=2")

    print("\n" + "=" * 96)
    print("WITNESS D -- two charges with identical (m,n,l,I) but non-isometric saturations")
    print("=" * 96)
    # charge (a) = frame 2 of witness A:  invariants (8,4,8), I=2, saturation class (1,4,0)
    report("charge (a)  [= witness A frame 2]", Q2, P2)
    # charge (b):  u = e1+2f1, v = e2+2f2;  L~ = <2u, u+v>
    u = add(e1, mul(2, f1))
    v = add(e2, mul(2, f2))
    Qb, Pb = mul(2, u), add(u, v)
    invb, clsb = report("charge (b)", Qb, Pb)
    print(f"\n   identical invariants (m,n,l,I): {invA2 == invb}")
    print(f"   saturation classes:  (a) {clsA2}   vs   (b) {clsb}   ->  isometric? {clsA2 == clsb}")
    print("   ((1,4,0) represents 1 and is primitive; (2,2,0) is imprimitive -- "
          "so the two saturations are NOT isometric.)")


if __name__ == "__main__":
    main()
