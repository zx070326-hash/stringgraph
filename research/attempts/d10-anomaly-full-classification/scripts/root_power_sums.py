"""Exact check of the D=10 anomaly condition

    Tr F^6 = (1/48) Tr F^4 Tr F^2 - (1/14400) (Tr F^2)^3

on every compact simple Lie algebra, by Chevalley restriction to a Cartan
subalgebra.  For H in the Cartan, ad(H) has eigenvalues {alpha(H) : alpha in Phi}
plus rank-many zeros, so

    Tr_adj H^k = S_k(H) := sum_{alpha in Phi} alpha(H)^k .

Everything below is exact rational arithmetic on multivariate polynomials; no
external dependencies.

Run:  python root_power_sums.py
"""

from fractions import Fraction
from itertools import combinations, product

# ---------------------------------------------------------------- polynomials
# A polynomial in r variables is a dict {exponent tuple: Fraction}.


def poly_add(a, b):
    out = dict(a)
    for k, v in b.items():
        nv = out.get(k, Fraction(0)) + v
        if nv:
            out[k] = nv
        else:
            out.pop(k, None)
    return out


def poly_scale(a, c):
    c = Fraction(c)
    if c == 0:
        return {}
    return {k: v * c for k, v in a.items()}


def poly_mul(a, b):
    out = {}
    for ka, va in a.items():
        for kb, vb in b.items():
            k = tuple(x + y for x, y in zip(ka, kb))
            nv = out.get(k, Fraction(0)) + va * vb
            if nv:
                out[k] = nv
            else:
                out.pop(k, None)
    return out


def poly_pow(a, n):
    r = len(next(iter(a))) if a else 0
    out = {(0,) * r: Fraction(1)}
    for _ in range(n):
        out = poly_mul(out, a)
    return out


def linear(coeffs):
    """The linear form sum_i coeffs[i] * h_i."""
    r = len(coeffs)
    out = {}
    for i, c in enumerate(coeffs):
        c = Fraction(c)
        if c:
            e = [0] * r
            e[i] = 1
            out[tuple(e)] = c
    return out


def power_sum(roots, k):
    """S_k = sum over roots of alpha(h)^k, as a polynomial in h_1..h_r."""
    r = len(roots[0])
    total = {}
    for a in roots:
        total = poly_add(total, poly_pow(linear(a), k))
    if not total:
        total = {}
    return total


# ------------------------------------------------------------- root systems
# Any faithful linear realization of the root system works: the identity
# "P(h) = 0 for all h in t" is invariant under a linear change of coordinates
# on t, and S_k(h) depends only on the projection of h onto span(Phi), so
# letting h range over all of R^r is equivalent to letting it range over
# span(Phi).  Coordinates below follow Bourbaki, Planches I-IX.

H = Fraction(1, 2)


def A(n):
    """A_n = su(n+1): roots e_i - e_j, i != j, in R^{n+1}."""
    N = n + 1
    out = []
    for i in range(N):
        for j in range(N):
            if i != j:
                v = [0] * N
                v[i], v[j] = 1, -1
                out.append(tuple(v))
    return out


def D(n):
    """D_n = so(2n): roots +-e_i +- e_j, i < j."""
    out = []
    for i, j in combinations(range(n), 2):
        for si, sj in product((1, -1), repeat=2):
            v = [0] * n
            v[i], v[j] = si, sj
            out.append(tuple(v))
    return out


def B(n):
    """B_n = so(2n+1): D_n roots plus +-e_i."""
    out = D(n)
    for i in range(n):
        for s in (1, -1):
            v = [0] * n
            v[i] = s
            out.append(tuple(v))
    return out


def C(n):
    """C_n = usp(2n): D_n roots plus +-2 e_i."""
    out = D(n)
    for i in range(n):
        for s in (1, -1):
            v = [0] * n
            v[i] = 2 * s
            out.append(tuple(v))
    return out


def G2():
    """G_2 inside the plane sum(x)=0 of R^3: short +-(e_i-e_j),
    long +-(2e_i-e_j-e_k)."""
    out = []
    for i, j in combinations(range(3), 2):
        for s in (1, -1):
            v = [0] * 3
            v[i], v[j] = s, -s
            out.append(tuple(v))
    for i in range(3):
        for s in (1, -1):
            v = [-s] * 3
            v[i] = 2 * s
            out.append(tuple(v))
    return out


def F4():
    """F_4: +-e_i, +-e_i+-e_j (i<j), (+-e_1+-e_2+-e_3+-e_4)/2."""
    out = D(4)
    for i in range(4):
        for s in (1, -1):
            v = [0] * 4
            v[i] = s
            out.append(tuple(v))
    for signs in product((H, -H), repeat=4):
        out.append(tuple(signs))
    return out


def E8():
    """E_8: +-e_i+-e_j (i<j), and (1/2) sum +- e_i with an even number of minus
    signs."""
    out = D(8)
    for signs in product((1, -1), repeat=8):
        if signs.count(-1) % 2 == 0:
            out.append(tuple(Fraction(s, 2) for s in signs))
    return out


def E7():
    """E_7 (Bourbaki): +-e_i+-e_j for i<j<=6; +-(e_7-e_8);
    +-(1/2)(e_7-e_8+sum_{i<=6} (-1)^{nu_i} e_i) with sum nu_i odd."""
    out = []
    for i, j in combinations(range(6), 2):
        for si, sj in product((1, -1), repeat=2):
            v = [0] * 8
            v[i], v[j] = si, sj
            out.append(tuple(v))
    for s in (1, -1):
        v = [0] * 8
        v[6], v[7] = s, -s
        out.append(tuple(v))
    for nu in product((0, 1), repeat=6):
        if sum(nu) % 2 == 1:
            body = [Fraction((-1) ** n, 2) for n in nu] + [H, -H]
            out.append(tuple(body))
            out.append(tuple(-x for x in body))
    return out


def E6():
    """E_6 (Bourbaki): +-e_i+-e_j for i<j<=5;
    +-(1/2)(e_8-e_7-e_6+sum_{i<=5} (-1)^{nu_i} e_i) with sum nu_i even."""
    out = []
    for i, j in combinations(range(5), 2):
        for si, sj in product((1, -1), repeat=2):
            v = [0] * 8
            v[i], v[j] = si, sj
            out.append(tuple(v))
    for nu in product((0, 1), repeat=5):
        if sum(nu) % 2 == 0:
            body = [Fraction((-1) ** n, 2) for n in nu] + [-H, -H, H]
            out.append(tuple(body))
            out.append(tuple(-x for x in body))
    return out


# ------------------------------------------------------------------ the test


def analyse(name, roots, rank, dim):
    assert len(roots) + rank == dim, (name, len(roots), rank, dim)
    S2 = power_sum(roots, 2)
    S4 = power_sum(roots, 4)
    S6 = power_sum(roots, 6)

    # (i)  S6 - (1/48) S4 S2 + (1/14400) S2^3 == 0
    resid = poly_add(
        poly_add(S6, poly_scale(poly_mul(S4, S2), Fraction(-1, 48))),
        poly_scale(poly_pow(S2, 3), Fraction(1, 14400)),
    )
    sat_i = not resid

    # strong pair (needed of every factor when there are two simple factors)
    sat_4 = not poly_add(S4, poly_scale(poly_pow(S2, 2), Fraction(-1, 100)))
    sat_6 = not poly_add(S6, poly_scale(poly_pow(S2, 3), Fraction(-1, 7200)))
    return sat_i, sat_4 and sat_6, len(resid)


def main():
    # Complete non-redundant Killing-Cartan list of compact simple Lie algebras
    # of dimension <= 496.  The ranges below are forced by dim <= 496:
    #   A_n: n(n+2) <= 496  => n <= 21      B_n: n(2n+1) <= 496 => n <= 15
    #   C_n: n(2n+1) <= 496 => n <= 15      D_n: n(2n-1) <= 496 => n <= 16
    # (A_n n>=1, B_n n>=2, C_n n>=3, D_n n>=4 avoids the low-rank coincidences
    #  B_1=C_1=A_1, C_2=B_2, D_2=A_1+A_1, D_3=A_3.)
    cases = []
    for n in range(1, 22):
        cases.append((f"A_{n} = su({n+1})", A(n), n, n * (n + 2)))
    for n in range(2, 16):
        cases.append((f"B_{n} = so({2*n+1})", B(n), n, n * (2 * n + 1)))
    for n in range(3, 16):
        cases.append((f"C_{n} = usp({2*n})", C(n), n, n * (2 * n + 1)))
    for n in range(4, 17):
        cases.append((f"D_{n} = so({2*n})", D(n), n, n * (2 * n - 1)))
    cases.append(("G_2", G2(), 2, 14))
    cases.append(("F_4", F4(), 4, 52))
    cases.append(("E_6", E6(), 6, 78))
    cases.append(("E_7", E7(), 7, 133))
    cases.append(("E_8", E8(), 8, 248))
    assert all(dim <= 496 for _, _, _, dim in cases)

    print(f"{'algebra':16} {'dim':>5} {'#roots':>7}  cond(i)  strong-pair")
    sols_i, sols_pair = [], []
    for name, roots, rank, dim in cases:
        sat_i, sat_pair, nres = analyse(name, roots, rank, dim)
        print(
            f"{name:16} {dim:5d} {len(roots):7d}  "
            f"{'YES' if sat_i else 'no ':>7}  {'YES' if sat_pair else 'no ':>11}"
        )
        if sat_i:
            sols_i.append((name, dim))
        if sat_pair:
            sols_pair.append((name, dim))
    print()
    print(f"{len(cases)} compact simple Lie algebras of dim <= 496 examined")
    print("satisfying (i)         :", sols_i)
    print("satisfying strong pair :", sols_pair)
    print()

    # Final assembly: g = g_1 + ... + g_r + u(1)^m with dim = 496.
    # r = 0, or r = 1 with g_1 satisfying (i), or r = 2 with both factors
    # satisfying the strong pair (Lemmas 3 and 4 of proof.md).
    answers = ["u(1)^496"]
    for name, dim in sols_i:
        answers.append(f"{name} + u(1)^{496 - dim}" if dim < 496 else name)
    for i, (n1, d1) in enumerate(sols_pair):
        for n2, d2 in sols_pair[i:]:
            if d1 + d2 <= 496:
                m = 496 - d1 - d2
                answers.append(f"{n1} + {n2}" + (f" + u(1)^{m}" if m else ""))
    print("solutions of (i) & (ii):")
    for a in answers:
        print("   ", a)


if __name__ == "__main__":
    main()
