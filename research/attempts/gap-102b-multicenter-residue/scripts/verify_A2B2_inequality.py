"""
Independent verification of the completing-the-square inequality underlying
BSS 2311.16252 Appendix B.4's proof that B2 subseteq B (the step this attempt's
proof.md S2 item 3 cites and relies on).

Written from scratch by this agent -- does NOT import or reuse
coefficients_upstream_copy.py, bss_crosscheck.py, or any code from
gap-102b-route-a. Pure Python + the standard `fractions` module for exact
rational arithmetic (no numpy/scipy dependency, matching this project's
existing convention of dependency-free verification scripts).

Claim being checked (BSS's own completing-the-square argument, as summarised
in proof.md S2 item 3, restated in elementary terms):

  For any ODD integer j, any NONZERO integer m1, and any real number a with
  |a| <= 1:

      j^2 + 4*a*j*m1 + 4*m1^2 - 1  >=  0.

  BSS's proof strategy: bound the LHS below by (|j| - 2|m1|)^2 - 1, then show
  that quantity is >= 0 because |j|-2|m1| is an ODD integer (hence has
  absolute value >= 1).

Two independent checks are performed:

  (A) Exact-arithmetic check that |j - 2*m1| is odd, hence >= 1, hence
      (|j|-2|m1|)^2 - 1 >= 0, for all odd j and nonzero integer m1 in a wide
      range (exhaustive over the tested range, exact integer arithmetic).

  (B) Exact-rational-arithmetic check that
          j^2 + 4*a*j*m1 + 4*m1^2 - 1  >=  (|j|-2|m1|)^2 - 1
      for a wide grid of rationals a in [-1,1] and the same (j, m1) range.
      This reduces algebraically to  a*j*m1 >= -|j*m1|, which is checked
      exactly (Fraction arithmetic, no floating point) rather than assumed.

  (C) A short symbolic argument (plain algebra, printed, not just asserted)
      for why (B) holds for ALL real a in [-1,1], not just the tested grid.
"""

from fractions import Fraction

J_RANGE = range(-41, 42, 2)          # odd j from -41 to 41
J_RANGE = [j for j in J_RANGE if j % 2 != 0]
M1_RANGE = [m for m in range(-20, 21) if m != 0]
A_GRID = [Fraction(k, 20) for k in range(-20, 21)]   # a = -1, -0.95, ..., 1

print("=== Check (A): |j - 2*m1| is odd, hence (|j|-2|m1|)^2 - 1 >= 0 ===")
fail_A = []
for j in J_RANGE:
    for m1 in M1_RANGE:
        diff = abs(j) - 2 * abs(m1)
        if diff % 2 == 0:
            fail_A.append((j, m1, diff))
        if diff * diff - 1 < 0:
            fail_A.append(("square-negative", j, m1, diff))
print("  tested", len(J_RANGE) * len(M1_RANGE), "pairs (j odd in [-41,41], m1 in [-20,20]\\{0})")
print("  failures:", fail_A if fail_A else "none")

print()
print("=== Check (B): j^2+4ajm1+4m1^2-1 >= (|j|-2|m1|)^2 - 1, for |a|<=1 (rational grid) ===")
fail_B = []
cnt = 0
for j in J_RANGE:
    for m1 in M1_RANGE:
        rhs = (abs(j) - 2 * abs(m1)) ** 2 - 1
        for a in A_GRID:
            lhs = j * j + 4 * a * j * m1 + 4 * m1 * m1 - 1
            cnt += 1
            if lhs < rhs:
                fail_B.append((j, m1, a, lhs, rhs))
print("  tested", cnt, "(j,m1,a) triples, exact Fraction arithmetic")
print("  failures:", fail_B[:5] if fail_B else "none")

print()
print("=== Check (C): symbolic reduction of (B) to a*j*m1 >= -|j*m1| ===")
print("  j^2+4ajm1+4m1^2-1 - [(|j|-2|m1|)^2-1]")
print("    = j^2+4ajm1+4m1^2 - (j^2 - 4|j||m1| + 4m1^2)")
print("    = 4ajm1 + 4|j||m1|")
print("    = 4( a*j*m1 + |j*m1| )")
print("  This is >= 0  <=>  a*j*m1 >= -|j*m1|.")
print("  Since j*m1 = sign(j*m1)*|j*m1|, this reads a*sign(j*m1) >= -1,")
print("  which holds for every real a with |a|<=1 (as a*sign(...) >= -|a| >= -1).")
print("  Hence (B) holds for ALL real a in [-1,1], not merely the tested grid --")
print("  the grid check above is a sanity check of this closed-form argument,")
print("  not a substitute for it.")

print()
ok = not fail_A and not fail_B
print("OVERALL:", "PASS -- no counterexamples found; symbolic argument in (C) is exact and general"
      if ok else "FAIL -- see failures above")
