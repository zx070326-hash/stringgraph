"""Adversarial test: x4 and y3 injective on the level-1 slice F(p)_1 for ARBITRARY eta and p.

PROVENANCE: written by the LEAD (2026-09-19). It replaces a script of the same intent
reported by the graph-reviewer agent (`s6review`) as review finding 7. That script was
transmitted to the lead only as chat text (the reviewer is read-only and had written it
to /tmp, outside the repo). When the lead preserved and ran it, it did not execute: it
called `make_ops(D)` and unpacked `(alpha, ladder)`, whereas the engine in
`verify_s6_injectivity.py` exports `make_ops(D, eta, p) -> (creat, dot)` and
`make_L(dot)`. The quoted transcript therefore cannot have come from the quoted source.
The reviewer's finding-7 CLAIM is not thereby refuted -- but its artifact was not
reproducible, so the lead re-derived the test from scratch against the real API. The
result below is the lead's own run, not a transcription.

WHY THIS TEST EXISTS: all three of the prover's scripts call `build(D)`, which hardcodes
the Lorentzian eta = diag(-1,1,...,1) AND the single rung momentum p_{-6} = a - 6b (it
even asserts p*p == -10). The theorem in claim.md quantifies over EVERY eta with
eta_mu^2 = 1 and EVERY p, with no constraint on p whatsoever. That is the claim's
distinctive strength, and it is exactly what would fail first if Lemma A/B secretly
leaned on an unstated property of the light-cone frame. Nothing in the prover's own
test suite probes it. This script does.

COVERAGE BEYOND THE PROVER'S SUITE:
  * random rational momenta bearing no relation to the light-cone frame (D = 4, 5, 6);
  * the degenerate p = 0 (D = 4, 6), where p*p = 0, excluded by build()'s own assert;
  * non-Lorentzian signatures: all-plus Euclidean, two timelike, all-minus -- every
    eta with eta_mu^2 = 1 is in scope of the theorem, and only one of them is tested
    anywhere else in this directory.
It tests x4 and y3 SEPARATELY (the claim is that each alone is injective; joint
injectivity of S6 is the weaker corollary) and reports the rank over Q exactly.

HONEST LIMIT, inherited: this reuses the engine of `verify_s6_injectivity.py`
(make_ops / make_L / addd / scale). It is a fourth exercise of that one engine at
harder inputs, NOT an independent re-implementation. No from-scratch symbolic Fock
simulator sharing no code with that engine has been written by anyone on this attempt
-- prover or reviewer. A bug in the shared engine would be invisible to all four.
"""
import os, sys, random
from fractions import Fraction as F

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from verify_s6_injectivity import make_ops, make_L, addd, scale, rank_exact


def check(D, eta, p, label):
    """Return (rank_x4, rank_y3); each should equal D for injectivity on F(p)_1."""
    creat, dot = make_ops(D, eta, p)
    L = make_L(dot)

    def opw(ns, st):
        e = st
        for n in reversed(ns):
            e = L(-n, e)
        return e

    def y3(s):
        return addd(scale(12, opw([3], s)), scale(6, opw([2, 1], s)), opw([1, 1, 1], s))

    def x4(s):
        return addd(scale(-76, opw([4], s)), scale(-52, opw([3, 1], s)),
                    scale(-12, opw([2, 2], s)), scale(-20, opw([2, 1, 1], s)),
                    scale(-3, opw([1, 1, 1, 1], s)))

    vac = {(): F(1)}
    out = []
    for name, op in (("x4", x4), ("y3", y3)):
        rows = {}
        for mu in range(D):
            for w, cc in op(creat(mu, 1, vac)).items():
                rows.setdefault(w, [F(0)] * D)[mu] += cc
        r, _, _ = rank_exact(list(rows.values()), D)
        out.append(r)
        flag = "INJECTIVE" if r == D else f"*** KERNEL dim {D - r} ***"
        print(f"  {label:28s} {name}: rank {r}/{D}  {flag}")
    return out


def main():
    random.seed(20260919)
    bad = 0

    print("random rational momenta, Lorentzian eta (prover tests only p = a - 6b):")
    for D in (4, 5, 6):
        for t in range(3):
            eta = [F(-1)] + [F(1)] * (D - 1)
            p = [F(random.randint(-9, 9), random.randint(1, 6)) for _ in range(D)]
            bad += sum(1 for r in check(D, eta, p, f"D={D} random#{t}") if r != D)

    print("zero momentum (p*p = 0; build()'s assert forbids this case):")
    for D in (4, 6):
        eta = [F(-1)] + [F(1)] * (D - 1)
        bad += sum(1 for r in check(D, eta, [F(0)] * D, f"D={D} p=0") if r != D)

    print("non-Lorentzian signatures (theorem allows any eta with eta_mu^2 = 1):")
    sigs = {"euclidean": lambda D: [F(1)] * D,
            "two-timelike": lambda D: [F(-1), F(-1)] + [F(1)] * (D - 2),
            "all-minus": lambda D: [F(-1)] * D}
    for name, mk in sigs.items():
        for D in (4, 6):
            eta = mk(D)
            p = [F(random.randint(-5, 5), random.randint(1, 4)) for _ in range(D)]
            bad += sum(1 for r in check(D, eta, p, f"D={D} {name}") if r != D)

    print(f"\n{'ALL CASES INJECTIVE' if bad == 0 else f'{bad} FAILURES'}")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
