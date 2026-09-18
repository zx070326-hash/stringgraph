"""
Scratch check (not part of the diagnostic's main evidentiary script) verifying
a suspected slot-alignment bug in Lemma D.1 of weyl-shift-diagnostic/proof.md.

paper.md's ground-truth definition (Torsion I generating functions section):
  Omega = [[rho, v], [v, sigma]],  A_d = diag(d, 1),  V_d(Omega) := A_d Omega A_d^T
  which gives (rho, sigma, v) -> (d^2 rho, sigma, d v)   -- matches
  paper.md's own displayed formula V_d F(rho,sigma,v) = F(d^2 rho, sigma, d v).

Corrected AN <-> DGM dictionary (bkm-shift-explanation/proof.md section 6,
fixed 2026-09-18, commit 1708ac0):
  rho_DGM <-> sigma_AN   (the variable scaled by d^2)
  v_DGM   <-> z_AN       (the variable scaled by d, and shifted)
  sigma_DGM <-> tau_AN   (the unscaled spectator)

Question: does applying A_d = diag(d,1) directly to the AN-ORDERED matrix
Z = [[tau, z], [z, sigma]] (as Lemma D.1 does) correctly represent V_d, or
does it silently swap the roles of tau and sigma?
"""
import sympy as sp

d = sp.symbols('d', positive=True, integer=True)
tau, z, sigma = sp.symbols('tau z sigma')
rho, v, sig = sp.symbols('rho v sig')

Adiag = sp.diag(d, 1)

# 1. paper.md ground truth in DGM variables
Om = sp.Matrix([[rho, v], [v, sig]])
Om2 = Adiag * Om * Adiag.T
print('DGM ground truth: A_d [[rho,v],[v,sigma]] A_d^T =', Om2.tolist())
assert Om2[0, 0] == d**2 * rho and Om2[0, 1] == d * v and Om2[1, 1] == sig
print('  Confirmed: (rho,sigma,v) -> (d^2 rho, sigma, d v).  Matches paper.md.')
print()

# 2. AN-native matrix built with CORRECT role alignment (rho-role = sigma_AN,
#    sigma-role = tau_AN), i.e. Z' = [[sigma_AN, z_AN],[z_AN, tau_AN]]
Zp = sp.Matrix([[sigma, z], [z, tau]])
Zp2 = Adiag * Zp * Adiag.T
print("Correct AN-role-aligned matrix: A_d [[sigma,z],[z,tau]] A_d^T =", Zp2.tolist())
print('  => (sigma,z,tau) -> (%s, %s, %s)' % (Zp2[0, 0], Zp2[0, 1], Zp2[1, 1]))
ok = (Zp2[1, 1] == tau) and (Zp2[0, 1] == d * z) and (Zp2[0, 0] == d**2 * sigma)
print('  i.e. (tau,z,sigma) -> (tau, d*z, d^2*sigma):', ok)
print()

# 3. Diagnostic Lemma D.1's literal construction: Z = [[tau,z],[z,sigma]]
#    (AN's OWN positional order, tau first) with A_d = diag(d,1) applied directly
Zd = sp.Matrix([[tau, z], [z, sigma]])
Zd2 = Adiag * Zd * Adiag.T
print('Diagnostic Lemma D.1 literal matrix: A_d [[tau,z],[z,sigma]] A_d^T =', Zd2.tolist())
print('  => (tau,z,sigma) -> (%s, %s, %s)' % (Zd2[0, 0], Zd2[0, 1], Zd2[1, 1]))
bug = (Zd2[0, 0] == d**2 * tau) and (Zd2[1, 1] == sigma)
print('  This scales TAU by d^2 and leaves SIGMA fixed -- role-swapped relative to')
print('  the correct dictionary (which requires SIGMA scaled by d^2, TAU fixed).')
print('  Bug confirmed:', bug)
print()

# 4. Effect on the "effective Weyl vector" claim in Lemma D.1
rho_W = sp.Rational(1, 2)
print('Weyl-vector pairing (rho_W,Z) with rho_W=(1/2,1/2,1/2), evaluated at the')
print('CORRECT dilation (tau,z,sigma) -> (tau, d*z, d^2*sigma):')
pairing_correct = rho_W * tau + rho_W * (d * z) + rho_W * (d**2 * sigma)
print('  =', sp.expand(pairing_correct), '  => effective Weyl vector (1/2, d/2, d^2/2)')
print()
print('Diagnostic Lemma D.1 as literally written claims effective Weyl vector')
print('  (d^2/2, d/2, 1/2)  [tau-component scaled by d^2, sigma-component fixed]')
print('vs. the CORRECT   (1/2, d/2, d^2/2)  [tau fixed, sigma-component scaled by d^2].')
print('These are related by swapping the tau- and sigma- components -- exactly the')
print('same class of rho<->sigma slot-alignment bug already found and fixed in')
print('bkm-shift-explanation/proof.md Corollary B1 (commit 1708ac0, same day).')
print()
print('Qualitative verdict of Lemma D.1 (pure multiplicative rescaling of the Weyl')
print('vector, no additive shift => Proposition P is false) is UNCHANGED by this')
print('fix, since swapping which two components equal (1/2, ...) vs (...*d^2) does')
print('not turn a multiplicative rescaling into an additive shift in EITHER version.')
