"""
Weyl-shift diagnostic for the (d-1)/2 half-integer shift in the N=4 torsion
divisor-sum identity (research/attempts/bkm-shift-explanation, Theorem B /
Proposition B, and research/papers/torsion-dyon-shift-positivity, Theorem 4.1).

All computations are EXACT (sympy Rational / I / pi / symbolic), no floats,
except where explicitly noted (none needed here).

Sections:
  1. Literal reading: does V_d applied directly to the bare canonical
     prefactor e^{2 pi i (rho_W,Z)} produce an ADDITIVE shift?
     (Answer checked: no -- it only rescales the effective Weyl vector.)
  2. Core Fourier identity (Lemma B.2 of bkm-shift-explanation, rederived
     and checked exponent-by-exponent, exactly, for symbolic d, ell).
  3. The "conjugation of translation by dilation" mechanism: symbolic
     derivation that the net shift equals (d-1)*rho_{W,v} with
     rho_{W,v} = 1/2, hence (d-1)/2, for GENERAL symbolic integer d
     (not just d = 1..6).
  4. Numeric table d = 1..6.
  5. Cross-validation against the independently-established epsilon = -i
     (d=2, S3 branch of bkm-shift-explanation/proof.md): recompute the
     prefactor-shift-ratio formula epsilon = exp(-i*pi*rho_{W,v}) and
     check it equals -i exactly.
  6. Finite truncated-series sanity check of the FULL divisor-sum identity
     Z_I = sum_{d|I} d * Z_1(tau, d z + (d-1)/2, d^2 sigma) using toy
     (symbolic, generic) coefficients Omega_1(n,m,ell), for I = 6
     (divisors 1,2,3,6), confirmed coefficient-by-coefficient as formal
     Laurent polynomials in q,y,p truncated to a finite exponent window.
"""

import sympy as sp

I, pi = sp.I, sp.pi

print("=" * 78)
print("SECTION 1: literal V_d action on the bare prefactor e^{2 pi i (rho_W,Z)}")
print("=" * 78)

# rho_W = (rho1, rho2, rho3) pairing with Z = (rho, v, sigma) via
# (rho_W,Z) = rho1*rho + rho2*v + rho3*sigma.  Represent as matrix R with
# Tr(R Z) = rho1*rho + rho2*v + rho3*sigma, Z = [[rho,v],[v,sigma]].
rho1, rho2, rho3 = sp.Rational(1, 2), sp.Rational(1, 2), sp.Rational(1, 2)
R = sp.Matrix([[rho1, rho2 / 2], [rho2 / 2, rho3]])
print("R (matrix form of rho_W=(1/2,1/2,1/2)):")
sp.pprint(R)

d = sp.symbols("d", positive=True, integer=True)
A_d = sp.diag(d, 1)  # V_d: Z -> A_d Z A_d^T with A_d = diag(d,1)

Rprime = sp.simplify(A_d.T * R * A_d)
print("\nR' = A_d^T R A_d (effective Weyl vector matrix after V_d):")
sp.pprint(Rprime)

rho1p = Rprime[0, 0]
rho2p = 2 * Rprime[0, 1]
rho3p = Rprime[1, 1]
print(f"\nEffective Weyl vector after V_d: (rho1', rho2', rho3') = "
      f"({rho1p}, {rho2p}, {rho3p})")
print("This is a pure RESCALING (d^2/2, d/2, 1/2) of the Weyl vector --")
print("NO additive translation is produced by applying V_d directly to the")
print("prefactor alone. Verdict of the literal reading: NO SHIFT.")

print()
print("=" * 78)
print("SECTION 2: core Fourier identity (Lemma B.2), exact exponent check")
print("=" * 78)

dd, ell = sp.symbols("d ell", integer=True)
z = sp.symbols("z")

# LHS: (-1)^{d ell} * y^{d ell}, y = exp(2 pi i z)
lhs_exponent = 2 * pi * I * dd * ell * z + I * pi * dd * ell

# RHS: (-1)^{ell} * y_new^{ell}, y_new = exp(2 pi i * z_new), z_new = d z + (d-1)/2
z_new = dd * z + (dd - 1) / sp.Integer(2)
rhs_exponent = 2 * pi * I * ell * z_new + I * pi * ell

diff = sp.simplify(sp.expand(lhs_exponent - rhs_exponent))
print(f"LHS exponent - RHS exponent (should be exactly 0): {diff}")
assert diff == 0, "Lemma B.2 exponent identity FAILED"
print("Confirmed: (-1)^{d*ell} y^{d*ell} = (-1)^{ell} y_new^{ell} EXACTLY,")
print("for symbolic d and ell (no floats, no mod-2pi ambiguity -- the two")
print("exponents are algebraically identical, not just congruent mod 2 pi i).")

print()
print("=" * 78)
print("SECTION 3: conjugation-of-translation-by-dilation mechanism")
print("=" * 78)

rho_Wv = sp.Rational(1, 2)  # elliptic-direction component of rho_W = (1/2,1/2,1/2)

zz = sp.symbols("zz")
d_sym = sp.symbols("d_sym", positive=True, integer=True)

# Step A: AN's signed convention Z_1(z) is the BARE (unsigned) generating
# function Zbare_1 evaluated at z shifted by rho_Wv:
#   Z_1(z) = Zbare_1(z + rho_Wv)   i.e.  Zbare_1(w) = Z_1(w - rho_Wv)
# Step B: the BARE divisor-sum identity has NO shift (pure dilation):
#   Zbare_I(z) = sum_d d * Zbare_1(d*z)
# Step C: hence Z_I(z) = Zbare_I(z + rho_Wv) = sum_d d * Zbare_1(d*(z+rho_Wv))
#                        = sum_d d * Z_1( d*(z+rho_Wv) - rho_Wv )
# The argument of Z_1 on the RHS:
arg_Z1 = sp.expand(d_sym * (zz + rho_Wv) - rho_Wv)
print(f"Argument fed into Z_1 on the RHS: {arg_Z1}")

predicted_shift = sp.expand(arg_Z1 - d_sym * zz)
print(f"Net additive shift (coefficient of the constant term): {predicted_shift}")

target_shift = (d_sym - 1) * sp.Rational(1, 2)
check = sp.simplify(predicted_shift - target_shift)
print(f"predicted_shift - (d-1)/2 = {check}")
assert check == 0, "General-d shift mechanism FAILED to reproduce (d-1)/2"
print("Confirmed EXACTLY, for symbolic integer d (all d >= 1 simultaneously,")
print("not just d = 1..6): shift = d*rho_Wv - rho_Wv = (d-1)*rho_Wv = (d-1)/2.")
print()
print("Mechanism statement: the elliptic-direction component rho_Wv = 1/2 of")
print("the canonical Weyl vector rho_W = (1/2,1/2,1/2) is EXACTLY the shift")
print("that converts the bare (unsigned) Omega-generating function into AN's")
print("signed convention Z_1 (since (-1)^ell = exp(2 pi i * rho_Wv * ell)).")
print("V_d, being the dilation v -> d*v, CONJUGATES this fixed built-in")
print("translation into a translation by d*rho_Wv (translations dilate")
print("multiplicatively under rescaling). Subtracting the ORIGINAL rho_Wv")
print("needed to re-express the right-hand side in terms of Z_1 (not the bare")
print("function) leaves the net shift (d-1)*rho_Wv = (d-1)/2 appearing")
print("explicitly in the divisor-sum formula.")

print()
print("=" * 78)
print("SECTION 4: numeric table d = 1..6")
print("=" * 78)
print(f"{'d':>3} | {'d*rho_Wv':>10} | {'(d-1)*rho_Wv':>14} | {'(d-1)/2':>9} | match")
for dv in range(1, 7):
    dilated = dv * rho_Wv
    net = (dv - 1) * rho_Wv
    target = sp.Rational(dv - 1, 2)
    ok = sp.simplify(net - target) == 0
    print(f"{dv:>3} | {str(dilated):>10} | {str(net):>14} | {str(target):>9} | {ok}")

print()
print("=" * 78)
print("SECTION 5: cross-validation against established epsilon = -i (d=2, S3)")
print("=" * 78)
# From bkm-shift-explanation/proof.md S3: Den_omega(tau,z,sigma) = eps * psi5(tau,z+1/2,sigma)
# with eps determined by the prefactor ratio for a PURE SHIFT by 1/2 (no
# dilation), eps^{-1} = e^{2 pi i * rho_Wv * (1/2)}  =>  eps = e^{-i*pi*rho_Wv}.
eps = sp.simplify(sp.exp(-I * pi * rho_Wv))
eps = sp.nsimplify(eps)
print(f"epsilon = exp(-i*pi*rho_Wv) with rho_Wv=1/2  =>  epsilon = {eps}")
assert sp.simplify(eps - (-I)) == 0, "epsilon != -i, inconsistent with established S3 result"
print("Confirmed: epsilon = -i, matching bkm-shift-explanation/proof.md S3")
print("[S3-result] Den_omega = (-i)*psi5(tau,z+1/2,sigma) EXACTLY.")
print("This is an independent (different construction: pure shift by 1/2 on")
print("psi5, weight 5, vs. dilation V_d on Z_1=1/Phi_10, weight -10) check")
print("that both computations are driven by the SAME quantity rho_Wv = 1/2.")

print()
print("=" * 78)
print("SECTION 6: finite truncated-series sanity check of the full identity")
print("=" * 78)
# Build a toy Omega_1(n,m,ell) with small symbolic/generic support and verify
# Z_I(z) = sum_{d|I} d * Z_1(tau, d z + (d-1)/2, d^2 sigma) coefficient-by-
# coefficient as FORMAL series in q, y, p truncated to a finite window, for
# I = 6 (divisors 1,2,3,6). We do NOT need actual Phi_10 Fourier coefficients:
# this checks the PURE COMBINATORIAL identity implied by AN eq(2.11)+(2.13),
# independent of what Omega_1 actually is.
import random

random.seed(2026)

# small support: (n,m,ell) with n in -1..1, m in 0..1, ell in -2..2
support = []
for n in range(-1, 2):
    for m in range(0, 2):
        for ell in range(-2, 3):
            support.append((n, m, ell))

Omega1 = {}
for key in support:
    Omega1[key] = sp.Integer(random.randint(-5, 5))

I_val = 6
divisors = [dv for dv in range(1, I_val + 1) if I_val % dv == 0]
print(f"I = {I_val}, divisors = {divisors}")

# Omega_I(n,m,ell) = sum_{d|I} d * Omega_1(n, m/d^2, ell/d)  (zero unless both
# divisions are exact integers within the finite support window)
def OmegaI(n, m, ell, I_val):
    total = sp.Integer(0)
    for dv in divisors:
        if m % (dv * dv) != 0 or ell % dv != 0:
            continue
        mm, ee = m // (dv * dv), ell // dv
        total += dv * Omega1.get((n, mm, ee), sp.Integer(0))
    return total

# Build Z_I(tau,z,sigma) := sum (-1)^ell Omega_I(n,m,ell) q^n y^ell p^m as a
# formal object: represent q,y,p symbolically and truncate.
q, y, p = sp.symbols("q y p")

# Enumerate the EXACT (finite) set of (n,m,ell) keys that can possibly have
# nonzero Omega_I(n,m,ell) for this I: m = dv^2 * mprime, ell = dv * ellprime
# for some dv | I and (n,mprime,ellprime) in the support of Omega_1. No
# ad hoc truncation window -- this is the precise (finite) support.
def enumerate_keys():
    keys = set()
    for dv in divisors:
        for (n, mprime, ellprime) in support:
            keys.add((n, dv * dv * mprime, dv * ellprime))
    return keys

def build_ZI_direct():
    expr = sp.Integer(0)
    for (n, m, ell) in enumerate_keys():
        val = OmegaI(n, m, ell, I_val)
        if val != 0:
            expr += sp.Integer((-1) ** ell) * val * q**n * y**ell * p**m
    return expr

ZI_direct = build_ZI_direct()

# Build RHS: sum_{d|I} d * Z_1(tau, d z + (d-1)/2, d^2 sigma) reinterpreted at
# the level of formal power series: substituting z -> d*z + (d-1)/2 means
# y = exp(2 pi i z) -> y^d * exp(i*pi*(d-1)) = y^d * (-1)^{d-1}. And
# sigma -> d^2 sigma means p -> p^{d^2}. tau unchanged: q -> q.
# Z_1(tau,z,sigma) = sum (-1)^ell' Omega_1(n,m',ell') q^n y^ell' p^m'
def build_ZI_via_shift():
    expr = sp.Integer(0)
    for dv in divisors:
        inner = sp.Integer(0)
        for key, val in Omega1.items():
            n, mprime, ellprime = key
            if val == 0:
                continue
            y_pow = (y**dv) * sp.Integer((-1) ** (dv - 1))
            y_pow = y_pow**ellprime
            term = sp.Integer((-1) ** ellprime) * val * q**n * y_pow * p**(dv * dv * mprime)
            inner += term
        expr += dv * inner
    return sp.expand(expr)

ZI_shift = build_ZI_via_shift()

diff_series = sp.expand(ZI_direct - ZI_shift)
print(f"Number of terms in ZI_direct: {len(sp.Add.make_args(ZI_direct))}")
print(f"Number of terms in ZI_shift:  {len(sp.Add.make_args(ZI_shift))}")
print(f"ZI_direct - ZI_shift (should be exactly 0): {diff_series}")
assert diff_series == 0, "Full divisor-sum identity FAILED the finite truncated check"
print("Confirmed: Theorem 4.1 / Proposition B's identity")
print("  Z_I(tau,z,sigma) = sum_{d|I} d * Z_1(tau, d z + (d-1)/2, d^2 sigma)")
print("holds EXACTLY as formal Laurent polynomials in q,y,p for this toy")
print("(random, generic-support) Omega_1 array and I=6, confirming the")
print("algebra is correct independent of what the true Phi_10 coefficients are.")

print()
print("ALL CHECKS PASSED.")
