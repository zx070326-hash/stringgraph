"""
Final end-to-end sanity check of Theorem 9 (bkm-shift-explanation/proof.md
section 9), reproducing the merged "Weyl vector route" derivation from
scratch, independently of weyl_shift_check.py, as a last check before
committing the merge.
"""
import sympy as sp

d, ell, z = sp.symbols('d ell z', integer=False)
d_int, ell_int = sp.symbols('d ell', integer=True, positive=True)
I_pi = sp.pi

rho_Wz = sp.Rational(1, 2)

# Lemma 9.2 (literal reading, corrected): V_d(tau,z,sigma) = (tau, d z, d^2 sigma)
# effective new Weyl vector after pairing with rho_W = (1/2,1/2,1/2):
tau_s, z_s, sigma_s, d_s = sp.symbols('tau z sigma d')
pairing_after = sp.Rational(1,2)*tau_s + sp.Rational(1,2)*(d_s*z_s) + sp.Rational(1,2)*(d_s**2*sigma_s)
print("Lemma 9.2: (rho_W, V_d Z) =", sp.expand(pairing_after))
print("  => effective Weyl vector (1/2, d/2, d^2/2):",
      sp.expand(pairing_after) == sp.Rational(1,2)*tau_s + (d_s/2)*z_s + (d_s**2/2)*sigma_s)
print()

# Lemma 9.3: (-1)^ell = exp(2 pi i * rho_Wz * ell) -- trivial identity check
lhs = sp.exp(sp.I*sp.pi*ell_int)
rhs = sp.exp(2*sp.I*sp.pi*rho_Wz*ell_int)
print("Lemma 9.3 core identity (-1)^ell == exp(2 pi i * (1/2) * ell):",
      sp.simplify(lhs - rhs) == 0)
print()

# Theorem 9 derivation, symbolic d:
# Z_I(z) = Ztilde_I(z + 1/2) = sum_d d * Ztilde_1(d*(z+1/2))
#        = sum_d d * Z_1( d*(z+1/2) - 1/2 )
w = sp.symbols('w')
arg_before_lemma93_inverse = d_s*(w + rho_Wz)  # argument fed to Ztilde_1
z_new = sp.expand(arg_before_lemma93_inverse - rho_Wz)  # apply Ztilde_1(w)=Z_1(w-1/2)
target = d_s*w + (d_s - 1)*sp.Rational(1,2)
print("Theorem 9: z_new =", z_new, "  target d*z+(d-1)/2 =", sp.expand(target))
print("Match:", sp.simplify(z_new - target) == 0)
print()

# Cross-check with epsilon = -i (section 9.7), general formula e^{-i*pi*rho_Wz}
eps = sp.simplify(sp.exp(-sp.I*sp.pi*rho_Wz))
print("epsilon = exp(-i*pi*rho_Wz) with rho_Wz=1/2:", eps, "  matches -i:", sp.simplify(eps+sp.I)==0)
print()
print("ALL SANITY CHECKS FOR MERGED THEOREM 9 PASSED." if (
    sp.expand(pairing_after) == sp.Rational(1,2)*tau_s + (d_s/2)*z_s + (d_s**2/2)*sigma_s
    and sp.simplify(lhs - rhs) == 0
    and sp.simplify(z_new - target) == 0
    and sp.simplify(eps + sp.I) == 0
) else "MISMATCH -- investigate.")
