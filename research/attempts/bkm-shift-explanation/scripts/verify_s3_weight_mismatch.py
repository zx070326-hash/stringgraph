"""
Independent numerical check of GAP-BKM S3 (bkm-shift-explanation attempt).

Claim to check (S3-result in proof.md):
  psi5(tau,z,sigma)      = (q r s)^(1/2) * P(r)
      where P(r) = prod_{(n,l,m)>0} (1 - q^n r^l s^m)^{f1(nm,l)}
  Den_omega(tau,z,sigma) = e^{i pi (tau+z+sigma)} * P(-r)
      [every root space picks up eigenvalue (-1)^l under omega, and
       q^n r^l s^m -> q^n (-r)^l s^m is exactly P evaluated at r -> -r]

Claimed identity:   Den_omega(tau,z,sigma) = (-i) * psi5(tau, z+1/2, sigma)
Consequence:        Phi10(tau,z+1/2,sigma) = psi5(tau,z+1/2,sigma)^2 = - Den_omega(tau,z,sigma)^2

This checks the *phase/weight bookkeeping* claimed in proof.md S3 independently of the
(unspecified) actual f1(nm,l) root multiplicities: the argument never uses their specific
values, only that P(r)|_{r->-r} appears identically on both sides. We use a toy finite
index set with arbitrary integer exponents and concrete complex (tau,z,sigma) -- this is
an independent code path (no import from proof.md or any other agent's script), pure
Python + cmath, no numpy/sympy needed.
"""
import cmath
import math


def q_of(tau):
    return cmath.exp(2j * math.pi * tau)


def r_of(z):
    return cmath.exp(2j * math.pi * z)


def s_of(sigma):
    return cmath.exp(2j * math.pi * sigma)


# toy finite index set (n, l, m, exponent) -- arbitrary, stands in for f1(nm,l)
TERMS = [
    (1, 0, 1, 3),
    (0, 1, 1, -2),
    (1, 1, 1, 5),
    (2, -1, 1, 1),
    (1, 2, 2, -4),
    (0, 3, 1, 2),
]


def P(r, q, s):
    val = 1 + 0j
    for (n, l, m, e) in TERMS:
        val *= (1 - q**n * r**l * s**m) ** e
    return val


def psi5(tau, z, sigma):
    q, r, s = q_of(tau), r_of(z), s_of(sigma)
    return (q * r * s) ** 0.5 * P(r, q, s)


def den_omega(tau, z, sigma):
    q, r, s = q_of(tau), r_of(z), s_of(sigma)
    prefac = cmath.exp(1j * math.pi * (tau + z + sigma))
    return prefac * P(-r, q, s)


def close(a, b, tol=1e-8):
    return abs(a - b) < tol * max(1.0, abs(a), abs(b))


SAMPLES = [
    (0.3 + 0.21j, 0.11 - 0.05j, 0.07 + 0.13j),
    (0.5 + 0.40j, -0.20 + 0.30j, 0.90 + 0.60j),
    (1.3 + 0.21j, 0.11 - 0.05j, 0.07 + 0.13j),  # tau -> tau+1 relative to sample 1
    (0.17 + 0.55j, 0.31 + 0.12j, 0.44 + 0.29j),
]


def main():
    # (A) squared identity Phi10(z+1/2) = -Den_omega^2, at every sample point.
    #     This is the branch-independent statement and the one the proof relies on.
    print("(A) corrected (squared) identity  Phi10(tau,z+1/2,sigma) = -Den_omega(tau,z,sigma)^2")
    squared_ok = True
    for i, (tau, z, sigma) in enumerate(SAMPLES, 1):
        phi10_shift = psi5(tau, z + 0.5, sigma) ** 2
        neg_den2 = -den_omega(tau, z, sigma) ** 2
        ok = close(phi10_shift, neg_den2)
        squared_ok = squared_ok and ok
        print(f"  point {i}: Phi10={phi10_shift!r}")
        print(f"           -Den^2={neg_den2!r}   holds: {ok}")
    print("  => squared identity holds at ALL sample points:", squared_ok)

    # (B) UNsquared form Den_omega = eps * psi5(z+1/2): eps is NOT a universal constant.
    #     psi5 carries the non-trivial quadratic character v (GN1996 §1 p.7), and the
    #     (qrs)^(1/2) branch choice realizes that +-1 ambiguity, so eps flips between +-i.
    print()
    print("(B) unsquared form  Den_omega = eps * psi5(tau,z+1/2,sigma):  eps per point")
    eps_values = []
    for i, (tau, z, sigma) in enumerate(SAMPLES, 1):
        eps = den_omega(tau, z, sigma) / psi5(tau, z + 0.5, sigma)
        eps_values.append(eps)
        label = "+i" if close(eps, 1j, tol=1e-6) else ("-i" if close(eps, -1j, tol=1e-6) else "??")
        print(f"  point {i}: eps={eps!r}  ~ {label}")
    all_same = all(close(e, eps_values[0], tol=1e-6) for e in eps_values)
    print("  => eps is the same at every sample point:", all_same)
    print("     (False is the EXPECTED outcome: see [GAP-S3-branch] in proof.md sec. 7)")

    # (C) Sanity check the ORIGINAL (refuted) claim Den_omega = C*Phi10(z+1/2), C constant:
    #     if true, Den_omega/Phi10(z+1/2) must be the same number at every (tau,z,sigma).
    print()
    print("(C) refuted claim  Den_omega = C * Phi10(tau,z+1/2,sigma), C a constant")
    ratios = []
    for i, (tau, z, sigma) in enumerate(SAMPLES, 1):
        ratio = den_omega(tau, z, sigma) / psi5(tau, z + 0.5, sigma) ** 2
        ratios.append(ratio)
        print(f"  point {i}: Den_omega/Phi10(z+1/2) = {ratio!r}")
    ratio_const = all(close(r, ratios[0], tol=1e-3) for r in ratios)
    print("  => ratio constant across points:", ratio_const)

    print()
    print("Expected outcome:")
    print("  (A) True   -- squared identity is the correct, branch-independent statement")
    print("  (B) False  -- eps flips with the branch; NOT a universal constant")
    print("  (C) False  -- weight 5 vs weight 10: Den_omega = C*Phi10 cannot hold")
    print(f"Actual: (A)={squared_ok}  (B)={all_same}  (C)={ratio_const}")


if __name__ == "__main__":
    main()
