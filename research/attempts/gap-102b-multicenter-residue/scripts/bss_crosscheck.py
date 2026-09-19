"""
Independent cross-check of the BSS 2311.16252 sec.5.3 worked numerical example
against THIS PROJECT's own already-reviewed Fourier-coefficient engine.

DISCLOSURE (mandatory, see research/CLAUDE.md discipline on reused code):
  `coefficients_upstream_copy.py` in this same directory is a byte-for-byte
  copy of research/attempts/torsion-immortal-positivity-hecke/scripts/coefficients.py
  (read there, copied here because I only have write access to
  research/attempts/gap-102b-multicenter-residue/**). I did NOT re-derive its
  algorithm; I am re-using an existing, already self-tested engine of this
  project (its own selftest: |c_1(1,0)| = 50064, matches the known literature
  degeneracy for Q^2=P^2=2, Q.P=0) as an independent oracle to check a claim
  transcribed from an external paper (BSS). This is exactly the "disclose any
  reused engine" situation flagged as mandatory by the task brief.

What is being checked:
  BSS 2311.16252 (arXiv, "Mock Modularity in CHL Models") Sec 5.3, p.51,
  states (N=1 case): "naive coefficient c_5^F(10,14) = 2023536" -- in BSS's
  OWN convention, where their index m_B := N Q^2/2 = Q^2/2 (electric) is
  attached to the FIRST (tau) Siegel variable, and their "n_B" := P^2/2
  (magnetic) is attached to sigma.

  This project's own convention (Rossello 2403.19630, adopted throughout
  torsion-immortal-positivity-hecke/claim.md sec 1.1) attaches index "m" to
  rho and m := P^2/2 (MAGNETIC), n := Q^2/2 (ELECTRIC).

  Cross-paper variable-role analysis (documented in proof.md of this attempt)
  establishes: BSS's tau plays the role of Rossello's sigma, and BSS's sigma
  plays the role of Rossello's rho (a swap of which Siegel variable is which,
  NOT just a relabelling of m/n) -- see proof.md Lemma (Variable Roles).
  Combined with Phi_10's rho<->sigma exchange symmetry (Phi_10(rho,sigma,v) =
  Phi_10(sigma,rho,v), standard fact, m<->n symmetric product formula), BSS's
  "SET A" object c_{m_B}^F(n_B, ell) [index m_B=Q^2/2] translates into THIS
  PROJECT's own m-indexed family evaluated at the SWAPPED slot:

      BSS's c_{m_B=5}^F(n_B=10, ell=14)   <-->   Rossello/upstream's c_{m=10}^F(n=5, ell=14)

  i.e. index m=10 (=BSS's n_B, magnetic P^2/2=20), Fourier labels (n=5,ell=14)
  (n=5 =BSS's m_B, electric Q^2/2=10).

  This script computes Rossello/upstream's c_{m=10}^F(n=5,ell=14) directly via
  the trusted engine and compares its SIGN and MAGNITUDE to BSS's claimed
  "2023536".
"""

import sys
import os

sys.path.insert(0, os.path.dirname(__file__))
import coefficients_upstream_copy as C

# We need m up to 10, n up to 5 (well inside range) -- use the module's own
# defaults (NMAX=10, MARGIN=2) which the module already exercises up to
# MMAX=4 in its own __main__ block; here we push MMAX to 10.

MMAX = 10
psis, F, P, phis = C.compute(MMAX)

print("=== BSS sec 5.3 cross-check ===")
print("Rossello/upstream convention: c_m^F(n,l), m attached to rho (magnetic P^2/2)")
print()

val_pos = F[10].get((5, 14), 0)
val_neg = F[10].get((5, -14), 0)
print("computed c_{m=10}^F(n=5, l=+14) =", val_pos)
print("computed c_{m=10}^F(n=5, l=-14) =", val_neg, "(should equal +14 value: c_m^F even in l)")

print()
print("BSS's claimed raw value (their own convention, sec 5.3, p.51): c_5^F(10,14) = 2023536")
print()

if val_pos == 2023536:
    verdict = "EXACT MATCH (same sign, same magnitude)"
elif val_pos == -2023536:
    verdict = "MAGNITUDE MATCHES, SIGN FLIPPED relative to BSS's reported raw value"
elif abs(val_pos) == 2023536:
    verdict = "magnitude matches up to abs(), unexpected sign bookkeeping"
else:
    verdict = "NO MATCH -- magnitude itself differs from BSS's claim (2023536); " \
              "either the m<->n / rho<->sigma correspondence used above is wrong, " \
              "or there is a transcription error, or BSS's number itself needs re-reading"
print("VERDICT:", verdict)

# Also print the naive d* BSS would form from THIS number using their own
# (-1)^(ell+1) convention, for cross-reference against their stated
# "d*_DMZ = -2023536":
naive_bss_style = (-1) ** (14 + 1) * val_pos
print()
print("(-1)^(l+1) * computed value =", naive_bss_style,
      " -- BSS report this naive d*_DMZ as -2023536")
