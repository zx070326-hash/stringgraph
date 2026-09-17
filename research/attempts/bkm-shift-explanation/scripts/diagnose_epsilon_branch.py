"""
Independent diagnostic for [GAP-S3-分支]: ε origin analysis.

Task: Determine whether the ε ∈ {+i, -i} factor in Den_ω = ε·ψ₅(τ,z+½,σ) comes from:
  (A) The non-trivial quadratic character ν: Sp₄(ℤ) → {±1} of ψ₅ (modular form theory), OR
  (B) The principal branch cut of (qrs)^{1/2} (multi-valued square root).

Methodology:
  1. Use the explicit formula from proof.md line 400: Den_ω = e^{πi(τ+z+σ)} · P(-r)
     This uses exp(πi(τ+z+σ)) — a SINGLE-VALUED function — not (qrs)^{1/2}.
  2. Compare with ψ₅(τ,z+½,σ) = (q·(-r)·s)^{1/2} · P(-r) (proof.md line 404)
     The second uses (q·(-r)·s)^{1/2} — a MULTI-VALUED square root via **0.5.
  3. Track where ε flips relative to branch cuts of the square root operation.

Key insight from proof.md lines 400 vs 394:
  - Den_ω uses e^{πi(τ+z+σ)} — single-valued exponential, no branch choice
  - ψ₅ uses (qrs)^{1/2} — multi-valued, branch-dependent
This inconsistency is likely the ENTIRE source of ε ambiguity.

Independent code path: pure Python + cmath, no imports from proof.md or other agents.
"""
import cmath
import math


def q_of(tau):
    return cmath.exp(2j * math.pi * tau)


def r_of(z):
    return cmath.exp(2j * math.pi * z)


def s_of(sigma):
    return cmath.exp(2j * math.pi * sigma)


# Toy finite product (same as verify_s3_weight_mismatch.py for consistency)
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


def den_omega_explicit(tau, z, sigma):
    """Den_ω using proof.md line 400 EXPLICIT form: e^{πi(τ+z+σ)} · P(-r).
    This is SINGLE-VALUED — no branch ambiguity."""
    q, r, s = q_of(tau), r_of(z), s_of(sigma)
    prefac = cmath.exp(1j * math.pi * (tau + z + sigma))
    return prefac * P(-r, q, s)


def psi5_shifted_via_sqrt(tau, z, sigma):
    """ψ₅(τ, z+½, σ) using (q·(-r)·s)^{1/2} via Python's **0.5 (MULTI-VALUED).
    Python's complex **0.5 uses principal branch: arg ∈ (-π, π]."""
    q = q_of(tau)
    r_shifted = r_of(z + 0.5)  # = e^{2πi(z+½)} = e^{iπ} · e^{2πiz} = -r_of(z)
    s = s_of(sigma)

    # Multi-valued square root via **0.5
    qrs_product = q * r_shifted * s
    sqrt_qrs = qrs_product ** 0.5

    return sqrt_qrs * P(r_shifted, q, s)


def psi5_shifted_via_exp(tau, z, sigma):
    """ψ₅(τ, z+½, σ) using SINGLE-VALUED exp(πi(τ+z+1+σ)).
    This matches Den_ω's definition style (proof.md line 400)."""
    q, s = q_of(tau), s_of(sigma)
    r_shifted = r_of(z + 0.5)

    # Single-valued exponential: (q·r_shifted·s)^{1/2} = e^{πi(τ + z+½ + σ)}
    prefac = cmath.exp(1j * math.pi * (tau + z + 0.5 + sigma))

    return prefac * P(r_shifted, q, s)


def arg_degrees(z):
    """Argument in degrees, normalized to (-180, 180]."""
    return math.degrees(cmath.phase(z))


def close(a, b, tol=1e-8):
    return abs(a - b) < tol * max(1.0, abs(a), abs(b))


SAMPLES = [
    (0.3 + 0.21j, 0.11 - 0.05j, 0.07 + 0.13j),
    (0.5 + 0.40j, -0.20 + 0.30j, 0.90 + 0.60j),
    (1.3 + 0.21j, 0.11 - 0.05j, 0.07 + 0.13j),  # tau -> tau+1
    (0.17 + 0.55j, 0.31 + 0.12j, 0.44 + 0.29j),
]


def main():
    print("=" * 80)
    print("DIAGNOSTIC: [GAP-S3-branch] -- Origin of epsilon in Den_omega = epsilon*psi5(z+1/2)")
    print("=" * 80)
    print()
    print("Hypothesis A: epsilon comes from modular character nu (modular form theory)")
    print("Hypothesis B: epsilon comes from principal branch of (qrs)^(1/2)")
    print()
    print("Test: Compare three computations at each sample point:")
    print("  (1) Den_omega via exp(pi*i*(tau+z+sigma)) -- single-valued (proof.md line 400)")
    print("  (2) psi5(z+1/2) via (q*(-r)*s)^(0.5) -- multi-valued via Python **0.5")
    print("  (3) psi5(z+1/2) via exp(pi*i*(tau+z+1/2+sigma)) -- single-valued (consistent with Den_omega)")
    print()
    print("If Hypothesis B is correct:")
    print("  - epsilon = Den_omega / (2) should flip when arg(q*(-r)*s) crosses branch cut")
    print("  - Den_omega / (3) should be CONSTANT (both use same single-valued exp)")
    print()
    print("-" * 80)

    eps_via_sqrt = []
    eps_via_exp = []
    qrs_args = []

    for i, (tau, z, sigma) in enumerate(SAMPLES, 1):
        print(f"\nPoint {i}: τ={tau}, z={z}, σ={sigma}")

        den = den_omega_explicit(tau, z, sigma)
        psi_sqrt = psi5_shifted_via_sqrt(tau, z, sigma)
        psi_exp = psi5_shifted_via_exp(tau, z, sigma)

        # Compute ε via both methods
        eps1 = den / psi_sqrt
        eps2 = den / psi_exp

        eps_via_sqrt.append(eps1)
        eps_via_exp.append(eps2)

        # Track argument of qrs product (branch cut location)
        q = q_of(tau)
        r_shifted = r_of(z + 0.5)
        s = s_of(sigma)
        qrs = q * r_shifted * s
        qrs_arg = arg_degrees(qrs)
        qrs_args.append(qrs_arg)

        # Determine epsilon labels
        label1 = "+i" if close(eps1, 1j, tol=1e-6) else ("-i" if close(eps1, -1j, tol=1e-6) else "other")
        label2 = "+i" if close(eps2, 1j, tol=1e-6) else ("-i" if close(eps2, -1j, tol=1e-6) else "other")

        print(f"  arg(q*(-r)*s) = {qrs_arg:+7.2f} deg {'[near +/-180 deg branch cut]' if abs(qrs_arg) > 150 else ''}")
        print(f"  epsilon via **0.5 sqrt:   {eps1:>20}  ~ {label1}")
        print(f"  epsilon via exp formula:  {eps2:>20}  ~ {label2}")
        print(f"  |Den_omega| = {abs(den):.6e}")

    print()
    print("=" * 80)
    print("ANALYSIS")
    print("=" * 80)

    # Check if epsilon via sqrt flips
    eps_sqrt_constant = all(close(e, eps_via_sqrt[0], tol=1e-6) for e in eps_via_sqrt)
    print(f"\n(A) epsilon via **0.5 sqrt is constant across samples: {eps_sqrt_constant}")
    if not eps_sqrt_constant:
        print("     epsilon values:", [f"{e:.4f}" for e in eps_via_sqrt])

    # Check if epsilon via exp is constant
    eps_exp_constant = all(close(e, eps_via_exp[0], tol=1e-6) for e in eps_via_exp)
    print(f"\n(B) epsilon via exp formula is constant across samples: {eps_exp_constant}")
    if eps_exp_constant:
        print(f"     Constant value: {eps_via_exp[0]:.6f}")
    else:
        print("     epsilon values:", [f"{e:.4f}" for e in eps_via_exp])

    # Correlation with branch cut
    print(f"\n(C) arg(q*(-r)*s) range: {min(qrs_args):.1f} deg to {max(qrs_args):.1f} deg")
    crosses_branch = any(abs(arg) > 150 for arg in qrs_args)
    print(f"    Crosses +/-180 deg branch cut: {crosses_branch}")

    print()
    print("-" * 80)
    print("VERDICT:")
    print("-" * 80)

    if eps_exp_constant and not eps_sqrt_constant:
        print()
        print("HYPOTHESIS B CONFIRMED:")
        print()
        print("  The epsilon ambiguity comes from the PRINCIPAL BRANCH of (qrs)^(1/2).")
        print()
        print("  Evidence:")
        print("    1. Den_omega / psi5(z+1/2) FLIPS when both use multi-valued **0.5 sqrt")
        print("    2. Den_omega / psi5(z+1/2) is CONSTANT when both use single-valued exp")
        print()
        print("  Root cause (proof.md line 400 vs 394 inconsistency):")
        print("    - Den_omega defined as exp(pi*i*(tau+z+sigma)) * P(-r) -- SINGLE-VALUED")
        print("    - psi5 defined as (qrs)^(1/2) * P(r) -- MULTI-VALUED")
        print()
        print("  Consequence for [GAP-S3-branch]:")
        print("    The 'non-trivial character nu' is NOT the source of epsilon ambiguity in")
        print("    the Den_omega = epsilon*psi5(z+1/2) identity. The ambiguity is an artifact of")
        print("    mixing single-valued (Den_omega) and multi-valued (psi5) definitions.")
        print()
        print("  FIX: Use consistent single-valued definition for both:")
        print("    Den_omega(tau,z,sigma) = exp(pi*i*(tau+z+sigma)) * P(-r)")
        print("    psi5(tau,z,sigma)      = exp(pi*i*(tau+z+sigma)) * P(r)")
        print("    Then: Den_omega = exp(pi*i*(tau+z+sigma)) P(-r) = exp(pi*i*(tau+z+sigma)) P(exp(i*pi)r)")
        print("          psi5(z+1/2) = exp(pi*i*(tau+z+1/2+sigma)) P(-r)")
        print("    =>  Den_omega / psi5(z+1/2) = exp(pi*i*(tau+z+sigma)) / exp(pi*i*(tau+z+1/2+sigma))")
        print("                                 = exp(-pi*i/2) = -i  (UNIVERSAL CONSTANT)")
        print()
    elif not eps_exp_constant:
        print()
        print("HYPOTHESIS A POSSIBLE (needs character theory check):")
        print()
        print("  Even with single-valued exp, ε still varies.")
        print("  This suggests modular character ν may be involved.")
        print()
    else:
        print()
        print("UNEXPECTED: Both methods give constant ε.")
        print("  Further investigation needed.")
        print()

    print("=" * 80)


if __name__ == "__main__":
    main()
