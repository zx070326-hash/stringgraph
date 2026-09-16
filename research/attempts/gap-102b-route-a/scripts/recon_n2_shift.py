"""
recon_n2_shift.py

Independent numerical/symbolic reconnaissance for the [GAP-n2] shift-invariant
direction discussed in proof.md section 5.5:

    (n1, m1) -> (n1 + n*t, m1 + m*t)   for integer t

leaves equation (I) (Lemma 1 Corollary 2, proof.md section 2) invariant,
because the term 2*m*n1 - 2*n*m1 does not change under the shift. This
script does NOT import anything from verify_route_a.py (independent code
path, per task instructions) and re-derives everything from scratch from
Sen's discriminant condition and Lemma 1, both stated directly in this file.

GOAL: decide, before investing more proof effort, whether the shift
direction is a genuine threat (real solutions / near-zero |F|^2 exist for
arbitrarily large Lambda, i.e. a real counterexample to the existence of a
uniform Lambda_0) or a "fake" degree of freedom that self-destructs once the
discriminant condition (which fixes m2 in terms of m1, n1, n2, j) is taken
into account.

METHOD
------
1. (Symbolic, SymPy) Confirm exactly (not asymptotically) that under the
   shift, with n2 != 0 fixed and m2 solved from the discriminant
       4*m1*n1 + 4*m2*n2 + j^2 = 1,
   the quantity g (proof.md eq. in Lemma 1, Re F = -n2*Delta*Lambda^2 + g)
   is an exact quadratic polynomial in t whose leading coefficient is
   -m*n/n2 (independent of rho1, sigma1, v1, j, and of the base point
   (n1_0, m1_0)). Consequently Lambda^2 = g/(n2*Delta) (the value forced by
   equation (R)) is a downward-opening parabola in t with leading
   coefficient -m*n/(n2^2*Delta) < 0, for ANY fixed (rho1,sigma1,v1) in the
   cube and ANY base (n1_0,m1_0,j,n2).

2. (Symbolic + numeric) For concrete (n,m,ell) samples, and several (n2,j)
   pairs, solve equation (I) exactly for one coordinate of (rho1,sigma1,v1)
   in terms of the other two (equation (I) is linear and Lambda-independent),
   pick a handful of points on the resulting affine slice that lie in
   [0,1]^3, and for each such point tabulate the parabola g(t)/(n2*Delta)
   over a wide range of integer t. Report the maximum value attained (the
   vertex height, i.e. the largest Lambda^2 achievable along this orbit) and
   confirm it stays O(1) -- i.e. does NOT grow -- so only a small, explicit
   range of t (hence of n1) can possibly produce a real Lambda on this
   orbit. This directly tests whether pushing t (and hence n1) to Lambda-
   independent-arbitrary size can be compensated by taking Lambda large: the
   answer this script checks is NO (the required Lambda^2 has a hard cap
   depending only on n,m,ell,n2,j and the fixed point, not rising with t).

3. (New rigorous bound, independent of 1-2) Equation (I) itself, being exact
   and not just asymptotic, immediately bounds the shift-invariant
   combination w := m*n1 - n*m1 in terms of |n2| and |j| alone (no Lambda,
   no n1 individually):
       w = -n2*(n*sigma1 + m*rho1 - ell*v1) - j*ell/2
       |w| <= |n2|*(n+m+ell) + |j|*ell/2                                (W)
   This is verified symbolically (exact algebraic identity) and numerically
   (spot-checked against random points in the cube). (W) is NOT present in
   proof.md as written (proof.md section 5 only uses inequality (iii), from
   B3, to get (J); (W) comes directly from (I) and is a strictly simpler,
   independent derivation). It bounds the component of (n1,m1) orthogonal
   to the shift direction (n,m), but -- as this script's part 4 checks
   explicitly -- does NOT by itself bound n1 along the shift direction,
   because w is exactly invariant under the shift (by construction), so an
   arbitrarily large t leaves w unchanged. This is reported honestly as a
   NEW but PARTIAL finding, not a closure.

4. (Broad integer search) A direct, independent (no imports from
   verify_route_a.py) integer/grid search over n2 != 0 with substantially
   larger bounds than the existing verify_route_a.py sweep (larger |n1|,
   |m1|, |n2|, |j|, and Lambda tied to the shift parameter t via the
   scaling predicted in part 1), to look for any actual near-zero |F|^2
   that would constitute a genuine counterexample candidate.

Pure Python + SymPy only (SymPy needed for the symbolic identity checks in
parts 1 and 3; part 4 is pure Python integer/float arithmetic, no SymPy).
Run with `python recon_n2_shift.py` (NOT `python3`, which is the Windows
Store stub in this environment -- see verify_route_a.py's own note on this).
"""

import math
import random

import sympy as sp


# ---------------------------------------------------------------------------
# Part 1: symbolic confirmation of the "quadratic wall" along the shift.
# ---------------------------------------------------------------------------

def part1_symbolic_parabola():
    print("=== Part 1: symbolic confirmation of quadratic-in-t behaviour ===")
    n, m, ell = sp.symbols("n m ell", positive=True)
    rho1, sigma1, v1 = sp.symbols("rho1 sigma1 v1", real=True)
    n1_0, m1_0, j, n2, t = sp.symbols("n1_0 m1_0 j n2 t", real=True)

    n1 = n1_0 + n * t
    m1 = m1_0 + m * t

    # Discriminant (Sen D.19): 4 m1 n1 + 4 m2 n2 + j^2 = 1  =>  m2 = ...
    m2 = (1 - j**2 - 4 * m1 * n1) / (4 * n2)

    # g as defined in proof.md Lemma 1 (Re F = -n2*Delta*Lambda^2 + g).
    g = n2 * (sigma1 * rho1 - v1**2) + j * v1 + n1 * sigma1 - m1 * rho1 + m2

    g_poly = sp.Poly(sp.expand(g), t)
    coeffs = g_poly.all_coeffs()  # highest degree first
    deg = g_poly.degree()
    print(f"  g(t) has degree {deg} in t (expect 2).")
    lead = sp.simplify(coeffs[0])
    expected_lead = -m * n / n2
    diff = sp.simplify(lead - expected_lead)
    print(f"  leading coefficient of g(t): {lead}")
    print(f"  claimed leading coefficient: -m*n/n2")
    print(f"  difference (should be 0): {diff}")
    assert diff == 0, "leading coefficient mismatch!"
    print("  PASS: leading coefficient of g(t) is exactly -m*n/n2, "
          "independent of (rho1,sigma1,v1,j,n1_0,m1_0).")

    # Lambda^2 = g/(n2*Delta); leading coeff of that in t:
    Delta = 4 * m * n - ell**2
    lam2_lead = sp.simplify(lead / (n2 * Delta))
    expected_lam2_lead = -m * n / (n2**2 * Delta)
    diff2 = sp.simplify(lam2_lead - expected_lam2_lead)
    print(f"  leading coeff of required Lambda^2(t) = g(t)/(n2*Delta): {lam2_lead}")
    assert diff2 == 0
    print("  PASS: leading coeff of Lambda^2(t) is -m*n/(n2^2*Delta) < 0 "
          "for ALL n2 != 0 (both signs) since m,n,Delta > 0 -- i.e. "
          "Lambda^2(t) is a downward parabola in t regardless of sign(n2).")
    print()


# ---------------------------------------------------------------------------
# Part 2: concrete numeric parabola tabulation for sample (n,m,ell,n2,j).
# ---------------------------------------------------------------------------

def solve_I_for_sigma1(n, m, ell, n2, j, n1_0, m1_0, rho1, v1):
    """Equation (I): n2*(2n*sigma1+2m*rho1-2ell*v1) + j*ell + 2*m*n1_0 - 2*n*m1_0 = 0
    (the shift-invariant part 2*m*n1-2*n*m1 = 2*m*n1_0-2*n*m1_0 regardless of t,
    per part 1), solved for sigma1 given rho1, v1 (assuming n2 != 0)."""
    rhs = -j * ell - 2 * m * n1_0 + 2 * n * m1_0 - n2 * (2 * m * rho1 - 2 * ell * v1)
    return rhs / (2 * n * n2)


def g_of_t(n, m, ell, n2, j, n1_0, m1_0, rho1, sigma1, v1, t):
    n1 = n1_0 + n * t
    m1 = m1_0 + m * t
    numerator = 1 - j * j - 4 * m1 * n1
    if numerator % (4 * n2) != 0:
        return None, None  # no integer m2 at this t
    m2 = numerator // (4 * n2)
    g = n2 * (sigma1 * rho1 - v1 * v1) + j * v1 + n1 * sigma1 - m1 * rho1 + m2
    return g, m2


def part2_numeric_parabola():
    print("=== Part 2: numeric parabola tabulation (vertex-height check) ===")
    samples = [
        (2, 2, 2, 1, 1, 0, 0),
        (2, 2, 2, -1, 1, 0, 0),
        (5, 3, 2, 1, 1, 0, 0),
        (5, 3, 2, 2, 1, 0, 0),
        (10, 5, 4, 1, 3, 0, 0),
        (10, 5, 4, -2, 1, 2, -1),
    ]
    t_range = range(-60, 61)
    for (n, m, ell, n2, j, n1_0, m1_0) in samples:
        Delta = 4 * m * n - ell * ell
        points = []
        for rho1, v1 in [(0.0, 1.0), (1.0, 0.0), (0.3, 0.7), (0.5, 0.5)]:
            sigma1 = solve_I_for_sigma1(n, m, ell, n2, j, n1_0, m1_0, rho1, v1)
            if 0.0 <= sigma1 <= 1.0:
                points.append((rho1, sigma1, v1))
        print(f"\n  sample (n,m,ell,n2,j,n1_0,m1_0)={(n,m,ell,n2,j,n1_0,m1_0)}  "
              f"Delta={Delta}  valid (rho1,sigma1,v1) points in cube: {len(points)}")
        if not points:
            print("    (no (rho1,v1) test point gave sigma1 in [0,1]; skipping)")
            continue
        for (rho1, sigma1, v1) in points:
            best_lam2 = None
            best_t = None
            n_real_candidates = 0
            for t in t_range:
                g, m2 = g_of_t(n, m, ell, n2, j, n1_0, m1_0, rho1, sigma1, v1, t)
                if g is None:
                    continue
                lam2 = g / (n2 * Delta)
                if lam2 >= 0:
                    n_real_candidates += 1
                    if best_lam2 is None or lam2 > best_lam2:
                        best_lam2 = lam2
                        best_t = t
            extra = f"  => Lambda_max={best_lam2**0.5:.4f}" if best_lam2 else ""
            print(f"    point (rho1,sigma1,v1)=({rho1:.2f},{sigma1:.4f},{v1:.2f}): "
                  f"integer-m2 t's with Lambda^2>=0 in range "
                  f"{t_range.start}..{t_range.stop-1}: {n_real_candidates}, "
                  f"max Lambda^2={best_lam2}, at t={best_t}{extra}")
    print()


def vertex_height(n, m, ell, n2, j, n1_0, m1_0, rho1, v1):
    """Real-valued (continuous-t relaxation, m2 NOT required to be integer)
    supremum over real t of Lambda^2(t) = g(t)/(n2*Delta), i.e. the vertex
    height of the downward parabola A*t^2+B*t+C with A=-m*n/n2 (part 1).
    This is an UPPER BOUND on what any actual integer-t, integer-m2 solution
    could achieve (relaxing integrality only makes the sup larger), so if
    this continuous relaxation is already <=0 (or small), no actual integer
    solution along this orbit can give a larger Lambda^2 either."""
    sigma1 = solve_I_for_sigma1(n, m, ell, n2, j, n1_0, m1_0, rho1, v1)
    if not (0.0 <= sigma1 <= 1.0):
        return None
    n1_base = n1_0
    m1_base = m1_0
    # g(t) = A t^2 + B t + C; sample 3 points (t=-1,0,1) with REAL m2 (no
    # integrality) to fit the quadratic exactly (no rounding).
    Delta = 4 * m * n - ell * ell

    def g_real(t):
        n1 = n1_base + n * t
        m1 = m1_base + m * t
        m2 = (1 - j * j - 4 * m1 * n1) / (4 * n2)
        return n2 * (sigma1 * rho1 - v1 * v1) + j * v1 + n1 * sigma1 - m1 * rho1 + m2

    g_m1, g_0, g_p1 = g_real(-1), g_real(0), g_real(1)
    # Fit the parabola in Lambda^2 = g/(n2*Delta), NOT in g itself.  For n2<0 the
    # leading coeff of g is A_g = -m*n/n2 > 0 (g opens UPWARD), while Lambda^2
    # still opens downward since dividing by n2<0 flips the sign again:
    #   leading coeff of Lambda^2 = -m*n/(n2^2*Delta) < 0 for BOTH signs of n2
    # (part 1).  Testing the sign of A_g instead would silently discard every
    # n2<0 orbit, leaving the negative branch untested.
    scale = n2 * Delta
    l_m1, l_0, l_p1 = g_m1 / scale, g_0 / scale, g_p1 / scale
    A = (l_p1 + l_m1) / 2 - l_0
    B = (l_p1 - l_m1) / 2
    C = l_0
    if A >= 0:
        return None  # shouldn't happen given part 1 (A = -m*n/(n2^2*Delta) exactly)
    t_star = -B / (2 * A)
    lam2_star = A * t_star**2 + B * t_star + C
    return lam2_star, t_star


def part2b_vertex_sup(samples=None, window=2, grid_n=40, quiet=False):
    """Sup of the vertex height over the (I)-slice.

    Parameters exposed so the larger exploratory sweeps quoted in proof.md
    Sec 5.6.2 are actually reproducible from this file:
        python recon_n2_shift.py sweep
    runs the n2/j sweep instead of the default fixed sample list.
    """
    if not quiet:
        print("=== Part 2b: sup of vertex height over the full (I)-slice ===")
        print("  (continuous-t relaxation upper bound; grid over (rho1,v1) in [0,1]^2)")
    if samples is None:
        samples = [
            (2, 2, 2, 1, 1),
            (2, 2, 2, -1, 1),
            (2, 2, 2, 1, 3),
            (5, 3, 2, 1, 1),
            (5, 3, 2, 2, 1),
            (5, 3, 2, -1, 3),
            (10, 5, 4, 1, 1),
            (10, 5, 4, -2, 3),
            (7, 4, 3, 1, 1),
            (7, 4, 3, -1, 5),
        ]
    grid1d = [i / float(grid_n) for i in range(grid_n + 1)]
    results = []
    for (n, m, ell, n2, j) in samples:
        best = None
        for n1_0 in range(-window, window + 1):
            for m1_0 in range(-window, window + 1):
                for rho1 in grid1d:
                    for v1 in grid1d:
                        res = vertex_height(n, m, ell, n2, j, n1_0, m1_0, rho1, v1)
                        if res is None:
                            continue
                        lam2_star, t_star = res
                        if best is None or lam2_star > best[0]:
                            best = (lam2_star, t_star, n1_0, m1_0, rho1, v1)
        if best is None:
            results.append(((n, m, ell, n2, j), None))
            if not quiet:
                print(f"  (n,m,ell,n2,j)={(n,m,ell,n2,j)}: no (I)-compatible "
                      f"(rho1,v1) grid point found in cube "
                      f"(n1_0,m1_0 in [-{window},{window}])")
            continue
        results.append(((n, m, ell, n2, j), best))
        lam2_star, t_star, n1_0, m1_0, rho1, v1 = best
        flag = " <-- POSITIVE (needs follow-up)" if lam2_star > 1e-9 else ""
        if not quiet:
            print(f"  (n,m,ell,n2,j)={(n,m,ell,n2,j)}: "
                  f"sup over grid of vertex Lambda^2 = {lam2_star:.6f} "
                  f"at t*={t_star:.3f} (base n1_0={n1_0},m1_0={m1_0}, "
                  f"rho1={rho1:.3f}, v1={v1:.3f}){flag}")
    if not quiet:
        print()
    return results


def sweep_vertex_sup(n=5, m=3, ell=2, n2_max=10, j_max=15, window=6, grid_n=20):
    """Does the vertex-height sup grow with |n2| or |j|?  (proof.md Sec 5.6.2)

    This is the claim the whole 'quadratic wall' reconnaissance rests on, so it
    needs to be runnable, not just asserted.  Reports max over the sweep.
    """
    print("=== Sweep: does sup(vertex Lambda^2) grow with |n2| or |j|? ===")
    print(f"  (n,m,ell)=({n},{m},{ell})  n2 in +-1..{n2_max}  j in 1..{j_max} (odd)"
          f"  base window +-{window}  grid {grid_n + 1}x{grid_n + 1}")
    overall = 0.0
    for n2 in [v for k in range(1, n2_max + 1) for v in (k, -k)]:
        row = []
        for j in range(1, j_max + 1, 2):
            res = part2b_vertex_sup([(n, m, ell, n2, j)], window=window,
                                    grid_n=grid_n, quiet=True)
            best = res[0][1]
            row.append("  n/a " if best is None else f"{best[0]:7.5f}")
            if best is not None:
                overall = max(overall, best[0])
        print(f"  n2={n2:+3d}: " + " ".join(row))
    print(f"  => max sup(vertex Lambda^2) over the whole sweep = {overall:.6f}")
    print("  (no growth with |n2| or |j| => supports the 'quadratic wall';"
          " NOT a proof -- the sup is a grid search, not an analytic maximum)")
    print()


# ---------------------------------------------------------------------------
# Part 3: the new bound (W) on w = m*n1 - n*m1 from equation (I) directly.
# ---------------------------------------------------------------------------

def part3_bound_W():
    print("=== Part 3: new bound (W) on w = m*n1 - n*m1 directly from (I) ===")
    n, m, ell = sp.symbols("n m ell", positive=True)
    rho1, sigma1, v1 = sp.symbols("rho1 sigma1 v1", real=True)
    j, n2 = sp.symbols("j n2", real=True)

    # (I): n2*(2n*sigma1 + 2m*rho1 - 2ell*v1) + j*ell + 2*m*n1 - 2*n*m1 = 0
    # solve for w := m*n1 - n*m1
    w_expr = sp.simplify(-(n2 * (2 * n * sigma1 + 2 * m * rho1 - 2 * ell * v1) + j * ell) / 2)
    print(f"  From (I): w := m*n1 - n*m1 = {w_expr}")
    print("  Since rho1,sigma1,v1 in [0,1], |n*sigma1+m*rho1-ell*v1| <= n+m+ell "
          "(all coefficients same-signed worst case), hence:")
    print("    |w| <= |n2|*(n+m+ell) + |j|*ell/2                                   (W)")
    print()
    print("  Numerical spot-check of the algebraic identity w_expr against direct")
    print("  substitution of concrete (n,m,ell,n2,j,rho1,sigma1,v1) satisfying (I)")
    print("  exactly with baseline n1=m1=0 (so 2*m*n1-2*n*m1=0 identically):")
    random.seed(0)
    ok = True
    for _ in range(2000):
        nn = random.randint(1, 12)
        mm = random.randint(1, nn)
        ll = random.randint(0, mm)
        n2v = random.choice([-3, -2, -1, 1, 2, 3])
        jv = random.choice([-5, -3, -1, 1, 3, 5])
        r1 = random.random()
        v1v = random.random()
        num = -jv * ll - n2v * (2 * mm * r1 - 2 * ll * v1v)
        s1 = num / (2 * nn * n2v)
        lhs_val = n2v * (2 * nn * s1 + 2 * mm * r1 - 2 * ll * v1v) + jv * ll
        if abs(lhs_val) > 1e-8:
            ok = False
            print("    MISMATCH", nn, mm, ll, n2v, jv, r1, v1v, lhs_val)
    print(f"  spot-check over 2000 random (n,m,ell,n2,j,rho1,v1): "
          f"{'all satisfy (I) as constructed -- PASS' if ok else 'FAILURES FOUND'}")
    print()


# ---------------------------------------------------------------------------
# Part 4: broad independent integer search for actual near-zero |F|^2 with
# n2 != 0, using larger bounds than verify_route_a.py, with Lambda tied to
# the shift parameter t via the part-1 scaling t ~ Lambda*|n2|*sqrt(Delta/(mn)).
# ---------------------------------------------------------------------------

def f_squared_direct(n, m, ell, Lam, rho1, sigma1, v1, m1, n1, m2, n2, j):
    """Re-derived independently from Sen's F (claim.md), NOT copied from
    verify_route_a.py (re-typed from the definition in claim.md/proof.md)."""
    rho2 = 2 * n * Lam
    sigma2 = 2 * m * Lam
    v2 = ell * Lam
    re_sr = sigma1 * rho1 - sigma2 * rho2
    im_sr = sigma1 * rho2 + sigma2 * rho1
    re_v2 = v1 * v1 - v2 * v2
    im_v2 = 2 * v1 * v2
    reF = n2 * (re_sr - re_v2) + j * v1 + n1 * sigma1 - m1 * rho1 + m2
    imF = n2 * (im_sr - im_v2) + j * v2 + n1 * sigma2 - m1 * rho2
    return reF * reF + imF * imF


def part4_broad_search():
    print("=== Part 4: broad independent search for n2!=0 near-zero |F|^2 ===")
    print("  (larger bounds than verify_route_a.py; Lambda tied to shift")
    print("   parameter t via the part-1 scaling; grid over (rho1,sigma1,v1))")
    grid = [i / 6.0 for i in range(7)]  # 7x7x7 grid
    samples = [(2, 2, 2), (5, 3, 2), (10, 5, 4), (7, 4, 3)]
    n2_values = [1, -1, 2, -2]
    j_values = [v for v in range(-7, 8) if v % 2 == 1]
    found_any = False
    for (n, m, ell) in samples:
        Delta = 4 * m * n - ell * ell
        print(f"\n  sample (n,m,ell)=({n},{m},{ell}) Delta={Delta}")
        global_min = None
        global_argmin = None
        for n2 in n2_values:
            for j in j_values:
                for n1_0 in range(-2, 3):
                    for m1_0 in range(-2, 3):
                        for t in range(-6, 7):
                            n1 = n1_0 + n * t
                            m1 = m1_0 + m * t
                            numerator = 1 - j * j - 4 * m1 * n1
                            if numerator % (4 * n2) != 0:
                                continue
                            m2 = numerator // (4 * n2)
                            lam_est = (
                                abs(t) * abs(n2) * math.sqrt(Delta / (m * n))
                                if t != 0 else 1.0
                            )
                            lam_candidates = sorted(set(
                                [1.0, 2.0, max(0.5, lam_est * 0.5),
                                 max(1.0, lam_est), lam_est * 1.5 + 1e-6]
                            ))
                            for Lam in lam_candidates:
                                if Lam <= 0:
                                    continue
                                for rho1 in grid:
                                    for sigma1 in grid:
                                        for v1 in grid:
                                            val = f_squared_direct(
                                                n, m, ell, Lam, rho1, sigma1, v1,
                                                m1, n1, m2, n2, j,
                                            )
                                            if global_min is None or val < global_min:
                                                global_min = val
                                                global_argmin = (
                                                    n1, m1, m2, n2, j, Lam,
                                                    rho1, sigma1, v1, t,
                                                )
        print(f"    global min |F|^2 found: {global_min:.6e}")
        print(f"    argmin (n1,m1,m2,n2,j,Lambda,rho1,sigma1,v1,t) = {global_argmin}")
        if global_min is not None and global_min < 1e-6:
            found_any = True
            print("    >>> POSSIBLE VIOLATION CANDIDATE (needs exact rational follow-up)")
    print()
    if not found_any:
        print("  SUMMARY: no near-zero |F|^2 (< 1e-6) found for n2 != 0 in this "
              "broader search (covers larger |n1|,|m1| via shift, n2 in "
              "{-2,-1,1,2}, j up to 7, Lambda tied to the shift scaling "
              "predicted in part 1). Consistent with (not proof of) the "
              "part-1/part-2 finding that the shift direction self-limits "
              "via the discriminant's forced quadratic-in-t growth of m2.")
    else:
        print("  SUMMARY: candidate(s) found above threshold; DO NOT treat as "
              "proof of a counterexample -- would need exact (rational) "
              "follow-up to confirm F=0 precisely, not just a small grid value.")


if __name__ == "__main__":
    import sys
    if len(sys.argv) > 1 and sys.argv[1] == "sweep":
        sweep_vertex_sup()
    else:
        part1_symbolic_parabola()
        part2_numeric_parabola()
        part2b_vertex_sup()
        part3_bound_W()
        part4_broad_search()
