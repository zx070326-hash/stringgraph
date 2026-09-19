#!/usr/bin/env python3
"""Leading-coefficient probe for research/attempts/s6-injectivity-level-six.

This is the computational counterpart of Lemma A / Lemma B in proof.md (the
"single-oscillator recursion" argument).  For u = c_mu * alpha^mu_{-1}|0;p>
ranging over the level-1 slice, it extracts the coefficient of the SAME-INDEX
single-oscillator basis vector

    x4 * u  ->  coefficient of alpha^nu_{-5}|0;p>
    y3 * u  ->  coefficient of alpha^nu_{-4}|0;p>

as a D x D matrix M[nu][mu], for several D.  The claim proved by hand in
proof.md (Lemma A + Lemma B) is that this matrix is EXACTLY

    M = -408 * Identity_D   (for x4)
    M = +30  * Identity_D   (for y3)

for every D >= 1 and every choice of admissible momentum p (the matrix does not
even depend on p).  This script checks that numerically for several D (using
the same rung j=-6 Fock realization as verify_s6_injectivity.py) as a
consistency check on the hand computation; it is NOT itself the proof (the
proof is the hand recursion in proof.md, Lemma A/B, which covers every D at
once and does not need this script) -- it exists only to catch arithmetic
slips in the hand derivation.

Usage:
    python verify_leading_coefficient.py           # checks D = 6, 8, 10, 12
    python verify_leading_coefficient.py 6 8 10 12 20   # custom D list
"""

import sys
import os
sys.path.insert(0, os.path.dirname(__file__))
from verify_s6_injectivity import build, make_ops, make_L, addd, scale  # noqa: E402
from fractions import Fraction as F  # noqa: E402


def single_osc_matrix(D, which, target_n):
    """Coefficient of alpha^nu_{-target_n}|0;p> in Z(alpha^mu_{-1}|0;p>),
    Z in {x4, y3}, as a D x D matrix M[nu][mu]."""
    eta, p = build(D)
    creat, dot = make_ops(D, eta, p)
    L = make_L(dot)

    def opw(ns, st):
        e = st
        for n in reversed(ns):
            e = L(-n, e)
        return e

    y3 = lambda s: addd(scale(12, opw([3], s)), scale(6, opw([2, 1], s)), opw([1, 1, 1], s))
    x4 = lambda s: addd(
        scale(-76, opw([4], s)), scale(-52, opw([3, 1], s)), scale(-12, opw([2, 2], s)),
        scale(-20, opw([2, 1, 1], s)), scale(-3, opw([1, 1, 1, 1], s)))
    vac = {(): F(1)}
    M = [[F(0)] * D for _ in range(D)]
    for mu in range(D):
        um = creat(mu, 1, vac)
        Zm = (x4 if which == 'x4' else y3)(um)
        for nu in range(D):
            key = ((target_n, nu),)
            M[nu][mu] = Zm.get(key, F(0))
    return M


def check(D, verbose=True):
    Mx = single_osc_matrix(D, 'x4', 5)
    My = single_osc_matrix(D, 'y3', 4)
    ok = True
    for nu in range(D):
        for mu in range(D):
            expect_x = F(-408) if nu == mu else F(0)
            expect_y = F(30) if nu == mu else F(0)
            if Mx[nu][mu] != expect_x:
                ok = False
                print(f"  MISMATCH x4 D={D} nu={nu} mu={mu}: got {Mx[nu][mu]}, expected {expect_x}")
            if My[nu][mu] != expect_y:
                ok = False
                print(f"  MISMATCH y3 D={D} nu={nu} mu={mu}: got {My[nu][mu]}, expected {expect_y}")
    if verbose:
        status = "MATCHES Lemma A/B exactly (-408*Id, +30*Id)" if ok else "DOES NOT MATCH -- investigate"
        print(f"D = {D:3d} : {status}")
    return ok


if __name__ == "__main__":
    ds = [int(x) for x in sys.argv[1:]] or [6, 8, 10, 12]
    all_ok = all(check(d) for d in ds)
    print()
    print("All checked D match Lemma A/B exactly." if all_ok else "MISMATCH FOUND -- see above.")
