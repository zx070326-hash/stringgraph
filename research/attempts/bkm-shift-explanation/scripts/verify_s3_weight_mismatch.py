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


def main():
    tau = 0.3 + 0.21j
    z = 0.11 - 0.05j
    sigma = 0.07 + 0.13j

    lhs = den_omega(tau, z, sigma)
    rhs = (-1j) * psi5(tau, z + 0.5, sigma)
    print("Den_omega                =", lhs)
    print("-i * psi5(z+1/2)         =", rhs)
    print("[S3-result] Den_omega = -i*psi5(z+1/2):", close(lhs, rhs))

    phi10_shift = psi5(tau, z + 0.5, sigma) ** 2
    neg_den2 = -den_omega(tau, z, sigma) ** 2
    print()
    print("Phi10(z+1/2) = psi5(z+1/2)^2 =", phi10_shift)
    print("-Den_omega^2                 =", neg_den2)
    print("corrected identity Phi10(z+1/2) = -Den_omega^2:", close(phi10_shift, neg_den2))

    # Sanity check the ORIGINAL (refuted) claim Den_omega = C*Phi10(z+1/2), C constant:
    # if true, Den_omega/Phi10(z+1/2) must be the same number at every (tau,z,sigma).
    tau2, z2, sigma2 = 0.5 + 0.4j, -0.2 + 0.3j, 0.9 + 0.6j
    ratio1 = den_omega(tau, z, sigma) / phi10_shift
    ratio2 = den_omega(tau2, z2, sigma2) / psi5(tau2, z2 + 0.5, sigma2) ** 2
    print()
    print("Den_omega/Phi10(z+1/2) at point 1:", ratio1)
    print("Den_omega/Phi10(z+1/2) at point 2:", ratio2)
    print(
        "ratio constant across points (would support the REFUTED claim)?",
        close(ratio1, ratio2, tol=1e-3),
    )
    print(
        "\nExpected: [S3-result] and corrected identity both True; "
        "'ratio constant' check False (confirms Den_omega=C*Phi10 cannot hold in general)."
    )


if __name__ == "__main__":
    main()
