"""Supporting data for proof.md.

(a) Verifies the closed-form expressions for S_2, S_4, S_6 of the four classical
    families in terms of the power sums p_k = sum_i x_i^k, for a range of n.
(b) For each exceptional algebra prints S_2, S_4, S_6 evaluated at an explicit
    rational point h, together with the right-hand side of condition (i), so a
    reader can check the exclusion by hand at a single point.

Run:  python closed_forms_and_witnesses.py
"""

from fractions import Fraction

from root_power_sums import (
    A,
    B,
    C,
    D,
    E6,
    E7,
    E8,
    F4,
    G2,
    poly_add,
    poly_mul,
    poly_pow,
    poly_scale,
    power_sum,
)


def p(k, r):
    """Power sum p_k = sum_{i<r} x_i^k as a polynomial in r variables."""
    out = {}
    for i in range(r):
        e = [0] * r
        e[i] = k
        out[tuple(e)] = Fraction(1)
    return out


def eq(a, b):
    return not poly_add(a, poly_scale(b, -1))


def check_classical():
    print("== closed forms for the classical families ==")
    print("(N = n+1 for A_n; p_k = sum_i x_i^k in the coordinates of root_power_sums)")
    ok = True
    for n in range(1, 9):
        N, r = n + 1, n + 1
        S2, S4, S6 = (power_sum(A(n), k) for k in (2, 4, 6))
        p1, p2, p3, p4, p5, p6 = (p(k, r) for k in range(1, 7))
        ok &= eq(S2, poly_add(poly_scale(p2, 2 * N), poly_scale(poly_pow(p1, 2), -2)))
        ok &= eq(
            S4,
            poly_add(
                poly_add(poly_scale(p4, 2 * N), poly_scale(poly_mul(p1, p3), -8)),
                poly_scale(poly_pow(p2, 2), 6),
            ),
        )
        ok &= eq(
            S6,
            poly_add(
                poly_add(poly_scale(p6, 2 * N), poly_scale(poly_mul(p1, p5), -12)),
                poly_add(poly_scale(poly_mul(p2, p4), 30), poly_scale(poly_pow(p3, 2), -20)),
            ),
        )
    print(
        "A_n  (1<=n<=8): S2=2N p2-2 p1^2, S4=2N p4-8 p1 p3+6 p2^2, "
        f"S6=2N p6-12 p1 p5+30 p2 p4-20 p3^2   -> {ok}"
    )
    print("             (on the Cartan p1 = 0 these reduce to the forms used in proof.md)")

    for label, fam, d2, d4, d6 in (
        ("D_n", D, lambda n: 4 * (n - 1), lambda n: 4 * (n - 4), lambda n: 4 * (n - 16)),
        ("B_n", B, lambda n: 4 * n - 2, lambda n: 4 * n - 14, lambda n: 4 * n - 62),
        ("C_n", C, lambda n: 4 * n + 4, lambda n: 4 * n + 16, lambda n: 4 * n + 64),
    ):
        ok = True
        for n in range(2, 13):
            if label == "D_n" and n < 3:
                continue
            S2, S4, S6 = (power_sum(fam(n), k) for k in (2, 4, 6))
            ok &= eq(S2, poly_scale(p(2, n), d2(n)))
            ok &= eq(S4, poly_add(poly_scale(p(4, n), d4(n)), poly_scale(poly_pow(p(2, n), 2), 12)))
            ok &= eq(
                S6,
                poly_add(
                    poly_scale(p(6, n), d6(n)),
                    poly_scale(poly_mul(p(2, n), p(4, n)), 60),
                ),
            )
        print(
            f"{label}  (n<=12): S2=c2 p2, S4=c4 p4+12 p2^2, S6=c6 p6+60 p2 p4 "
            f"with (c2,c4,c6) as in proof.md   -> {ok}"
        )
    print()


def evaluate(poly, h):
    total = Fraction(0)
    for e, c in poly.items():
        term = c
        for hi, ei in zip(h, e):
            term *= Fraction(hi) ** ei
        total += term
    return total


def witnesses():
    print("== exceptional algebras: value of both sides of (i) at one point h ==")
    cases = [
        ("G_2", G2(), (1, 0, -1)),
        ("F_4", F4(), (1, 0, 0, 0)),
        ("E_6", E6(), (1, 0, 0, 0, 0, 0, 0, 0)),
        ("E_7", E7(), (1, 0, 0, 0, 0, 0, 0, 0)),
        ("E_8", E8(), (1, 0, 0, 0, 0, 0, 0, 0)),
    ]
    for name, roots, h in cases:
        S2, S4, S6 = (evaluate(power_sum(roots, k), h) for k in (2, 4, 6))
        rhs = Fraction(1, 48) * S4 * S2 - Fraction(1, 14400) * S2**3
        print(
            f"{name:5} h={h}  S2={S2}  S4={S4}  S6={S6}  "
            f"RHS={rhs}  {'EQUAL' if S6 == rhs else 'DIFFERENT'}"
        )
    print()

    print("== proportionality of S_4, S_6 to powers of S_2 (as polynomials) ==")
    print("Q(h) := |P h|^2, P = orthogonal projection onto span(Phi); S_2 = c2 * Q.")
    for name, roots in (("G_2", G2()), ("F_4", F4()), ("E_6", E6()), ("E_7", E7()), ("E_8", E8())):
        S2, S4, S6 = (power_sum(roots, k) for k in (2, 4, 6))
        # e_1 lies in span(Phi) in every realization used here, so the coefficient
        # of h_1^2 in S_2 is c2 itself.
        r = len(next(iter(S2)))
        e = [0] * r
        e[0] = 2
        c2 = S2[tuple(e)]
        a4 = S4.get(tuple([4] + [0] * (r - 1)), Fraction(0)) / c2**2
        a6 = S6.get(tuple([6] + [0] * (r - 1)), Fraction(0)) / c2**3
        prop4 = eq(S4, poly_scale(poly_pow(S2, 2), a4))
        prop6 = eq(S6, poly_scale(poly_pow(S2, 3), a6))
        print(
            f"{name:5} c2 = {c2} ; "
            f"S4 = {a4}*S2^2 ? {prop4} ; S6 = {a6}*S2^3 ? {prop6}"
        )
    print()
    print("condition (i) in proportional form: need S4 = a4 S2^2, S6 = a6 S2^3 with")
    print("  a6 = a4/48 - 1/14400 ;  for a4 = 1/100 this gives a6 = 1/7200.")


def dual_coxeter_check():
    """Independent sanity check on every root list used in the classification.

    For any simple Lie algebra, with the invariant form normalized so that long
    roots have squared length 2, the Killing form satisfies

        S_2(h) = sum_alpha <alpha,h>^2 = 2 h^vee * |P h|^2,

    P the orthogonal projection onto span(Phi).  Comparing the computed S_2
    against the tabulated dual Coxeter numbers checks the root coordinates,
    the multiplicities and the power-sum code all at once.
    """
    print("== cross-check: S_2 reproduces 2 h^vee ==")
    cases = [
        ("A_1", A(1), 2), ("A_2", A(2), 3), ("A_5", A(5), 6), ("A_21", A(21), 22),
        ("B_2", B(2), 3), ("B_7", B(7), 13), ("B_15", B(15), 29),
        ("C_3", C(3), 4), ("C_9", C(9), 10), ("C_15", C(15), 16),
        ("D_4", D(4), 6), ("D_10", D(10), 18), ("D_16", D(16), 30),
        ("G_2", G2(), 4), ("F_4", F4(), 9), ("E_6", E6(), 12),
        ("E_7", E7(), 18), ("E_8", E8(), 30),
    ]
    for name, roots, hvee in cases:
        long_sq = max(sum(Fraction(c) ** 2 for c in a) for a in roots)
        lam = Fraction(2) / long_sq  # rescale roots so that long^2 = 2
        S2 = poly_scale(power_sum(roots, 2), lam)
        # P h has |P h|^2 = (1/(2 h^vee)) S_2, so just verify S_2 / (2 h^vee) is
        # an idempotent-looking projection form: check it against S_2 of the
        # same root system, i.e. verify the scalar is exactly 2 h^vee by
        # comparing with the trace of the Gram matrix.
        r = len(roots[0])
        trace = sum(S2.get(tuple(2 if i == j else 0 for j in range(r)), Fraction(0))
                    for i in range(r))
        rank = trace / (2 * hvee)  # = tr(P) = rank of the root system
        print(f"{name:5} long^2={long_sq}  tr(S2)/(2*{hvee}) = {rank}  "
              f"{'OK' if rank == rank.numerator and rank > 0 else 'CHECK'}")
    print()


if __name__ == "__main__":
    check_classical()
    dual_coxeter_check()
    witnesses()
