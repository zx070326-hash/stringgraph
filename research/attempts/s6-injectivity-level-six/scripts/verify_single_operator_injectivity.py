#!/usr/bin/env python3
"""Single-operator injectivity probe for research/attempts/s6-injectivity-level-six.

Companion check to verify_s6_injectivity.py: tests whether x4 ALONE, or y3
ALONE (without pairing them), is already injective on the level-1 slice
V_{-6,1}.  This is a strictly stronger fact than S6-injectivity (a fortiori
S6 = (x4,.) x (y3,.) is injective if either factor alone is), and it is
exactly what Lemma A/B in proof.md proves by hand for every D.  This script
is the brute-force (literal Fock-space vector, full word expansion, not just
the leading single-oscillator term) cross-check.

Usage:
    python verify_single_operator_injectivity.py            # D = 3,4,5,10,26,27
    python verify_single_operator_injectivity.py 3 4 5 6 7   # custom D list
"""

import sys
import os
sys.path.insert(0, os.path.dirname(__file__))
from verify_s6_injectivity import build, make_ops, make_L, addd, scale, rank_exact  # noqa: E402
from fractions import Fraction as F  # noqa: E402
from collections import defaultdict  # noqa: E402


def run_single(D, which, verbose=True):
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
    rows = defaultdict(lambda: [F(0)] * D)
    for mu in range(D):
        um = creat(mu, 1, vac)
        Zm = (x4 if which == 'x4' else y3)(um)
        for w, cc in Zm.items():
            rows[w][mu] += cc
    r, piv, M = rank_exact(list(rows.values()), D)
    null = D - r
    if verbose:
        status = "INJECTIVE" if null == 0 else f"NOT injective, kernel dim = {null}"
        print(f"D={D:3d} which={which}: rank={r:3d} nullity={null:3d}  {status}")
    return null


if __name__ == "__main__":
    ds = [int(x) for x in sys.argv[1:]] or [3, 4, 5, 10, 26, 27]
    results = {(d, w): run_single(d, w) for d in ds for w in ('x4', 'y3')}
    bad = [k for k, v in results.items() if v != 0]
    print()
    if bad:
        print(f"NOT injective at: {bad}")
    else:
        print("x4 alone and y3 alone are each injective at every tested D.")
