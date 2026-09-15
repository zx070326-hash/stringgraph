"""
verify_route_a.py

Numerical verification (illustrative support, NOT a substitute for the
analytic proof) for research/attempts/gap-102b-route-a/proof.md.

For a list of (n,m,ell) attractor-contour samples (including boundary cases
n=m, ell=0, ell=m) and a grid of Lambda values in [1,100], this script
searches integer 5-tuples (m1,n1,m2,n2,j) satisfying Sen's discriminant
condition 4*m1*n1+4*m2*n2+j^2=1 (j odd, Sen 2008 eq. D.19), within bounded
search ranges, and for each candidate tuple does a coarse grid search over
the real cube (rho1,sigma1,v1) in [0,1]^3 to estimate min|F|^2, where

    F = n2*(sigma*rho - v**2) + j*v + n1*sigma - m1*rho + m2

is evaluated at the attractor point

    rho   = rho1   + i*2*n*Lambda
    sigma = sigma1 + i*2*m*Lambda
    v     = v1     + i*ell*Lambda           (Lambda > 0, epsilon=+1 convention)

per proof.md section 2 (Lemma 1, exact Re/Im decomposition).

Pure Python only -- no numpy/scipy available in this environment (verified
at the start of this attempt: both `uv run python -c "import numpy"` and
bare `python3 -c "import numpy"` fail with ModuleNotFoundError).

SCOPE AND LIMITS OF THIS SCRIPT (read before interpreting output):
  - It CONFIRMS the ell=0 exact hit (proof.md section 3): the trivial tuple
    (m1,n1,m2,n2,j)=(0,0,0,0,1) gives F=v exactly, and v1=0 is a grid point,
    so |F|^2=0 is found exactly whenever ell=0, for every Lambda tested.
  - It is CONSISTENT WITH (does not, and cannot, independently re-derive) the
    analytic closure of the n2=0 branch for 0<ell<=m<=n (proof.md section 4,
    Theorem 4): the search only considers INTEGER (m1,n1) satisfying the
    discriminant, so it will simply not find any n2=0 candidate for those
    samples (matching the proof that none exist).
  - It CANNOT confirm or refute the open n2!=0 gap (proof.md section 5,
    GAP-n2): a coarse grid + bounded tuple search finding no near-zero
    |F|^2 is expected regardless of whether the analytic gap is eventually
    closed, or a genuine counterexample exists outside these bounds. This
    is explicitly NOT proof of anything for n2!=0; it is a sanity check
    that nothing embarrassingly small is missed within the tested range.

SEPARATE ALGEBRA CHECK (proof.md section 5.1): `compute_B1B2B3()` below is
an independent SymPy symbolic verification that the attractor-coordinate
forms of B1, B2, B3 quoted in proof.md section 5.1 are exactly (not just
approximately) equal to Sen's general (D.7)-derived expressions after
substituting rho2=2*n*Lambda, sigma2=2*m*Lambda, v2=ell*Lambda. This uses
`sympy` (confirmed importable in this environment via `python`, unlike
numpy/scipy; `python3` is the WindowsApps stub and must not be used -- see
the note in the "运行记录" section of proof.md section 6). It is unrelated
to, and independent of, the pure-Python numeric tuple/grid search in the
rest of this file, which needs no external dependency. It is called from
`__main__` before the numeric samples run.
"""

import itertools

try:
    import sympy as _sp
except ImportError:  # pragma: no cover - sympy is expected to be present
    _sp = None


def compute_B1B2B3():
    """Symbolically verify the attractor-coordinate B1, B2, B3 formulas
    quoted in proof.md section 5.1, by substituting
    rho2 = 2*n*Lambda, sigma2 = 2*m*Lambda, v2 = ell*Lambda
    into Sen's general (D.7)-derived expressions for B1, B2, B3 and
    simplifying the difference against the claimed closed forms

        B1 = n2*Delta*Lambda**2 + g
        B2 = Lambda*b2
        B3 = j/2 + (ell/(2*n))*(n1 + n2*rho1) - n2*v1

    to exactly zero.

    Returns True and prints "PASS" for each of B1, B2, B3 if the algebra
    checks out exactly; raises AssertionError otherwise. This is a
    cross-check of the *proof.md substitution algebra* in section 5.1,
    not a re-derivation of Sen's (D.6)/(D.7) identities themselves (those
    are taken as given from the literature, per claim.md section 3).
    """
    if _sp is None:
        raise RuntimeError(
            "sympy is required for compute_B1B2B3() but is not importable "
            "in this environment"
        )

    m, n, ell, Lam = _sp.symbols("m n ell Lam", positive=True)
    rho1, sigma1, v1 = _sp.symbols("rho1 sigma1 v1", real=True)
    m1, n1, m2, n2, j = _sp.symbols("m1 n1 m2 n2 j", real=True)

    rho2 = 2 * n * Lam
    sigma2 = 2 * m * Lam
    v2 = ell * Lam

    # Sen's general B1, B2, B3 (D.7), before substituting attractor coords
    # (proof.md section 5.1, "其中" block).
    B1 = (
        m2
        + n2 * (sigma2 * rho2 + sigma1 * rho1 - v1**2 - v2**2)
        - m1 * rho1
        + n1 * sigma1
        + j * v1
    )
    B2 = (
        n2
        * (
            sigma1 * rho2
            - sigma2 * rho1
            + 2 * v1 * v2
            - 2 * v2**2 * rho1 / rho2
        )
        + m1 * rho2
        + n1 * (sigma2 - 2 * v2**2 / rho2)
        - j * v2
    )
    B3 = _sp.Rational(1, 2) * j + n1 * (v2 / rho2) - n2 * v1 + n2 * (v2 * rho1 / rho2)

    Delta = 4 * m * n - ell**2
    g = n2 * (sigma1 * rho1 - v1**2) + j * v1 + n1 * sigma1 - m1 * rho1 + m2

    claimed_B1 = n2 * Delta * Lam**2 + g
    diff_B1 = _sp.simplify(B1 - claimed_B1)
    assert diff_B1 == 0, f"B1 mismatch: {diff_B1}"
    print("compute_B1B2B3: B1 == n2*Delta*Lambda^2 + g          -- PASS (diff=0)")

    b2 = (
        n2 * (2 * n * sigma1 - 2 * m * rho1 + 2 * ell * v1 - ell**2 * rho1 / n)
        + 2 * n * m1
        + 2 * m * n1
        - n1 * ell**2 / n
        - j * ell
    )
    claimed_B2 = Lam * b2
    diff_B2 = _sp.simplify(B2 - claimed_B2)
    assert diff_B2 == 0, f"B2 mismatch: {diff_B2}"
    print("compute_B1B2B3: B2 == Lambda*b2                       -- PASS (diff=0)")

    claimed_B3 = _sp.Rational(1, 2) * j + (ell / (2 * n)) * (n1 + n2 * rho1) - n2 * v1
    diff_B3 = _sp.simplify(B3 - claimed_B3)
    assert diff_B3 == 0, f"B3 mismatch: {diff_B3}"
    print("compute_B1B2B3: B3 == j/2+(ell/2n)(n1+n2*rho1)-n2*v1  -- PASS (diff=0)")

    return True


def f_squared(n, m, ell, Lam, rho1, sigma1, v1, m1, n1, m2, n2, j):
    """Exact |F|^2 at the attractor point, via direct Re/Im computation
    (no use of the Lemma-1 shortcut, so this independently cross-checks
    the algebra in proof.md section 2)."""
    rho2 = 2 * n * Lam
    sigma2 = 2 * m * Lam
    v2 = ell * Lam

    re_sigma_rho = sigma1 * rho1 - sigma2 * rho2
    im_sigma_rho = sigma1 * rho2 + sigma2 * rho1
    re_v2 = v1 * v1 - v2 * v2
    im_v2 = 2 * v1 * v2

    reF = n2 * (re_sigma_rho - re_v2) + j * v1 + n1 * sigma1 - m1 * rho1 + m2
    imF = n2 * (im_sigma_rho - im_v2) + j * v2 + n1 * sigma2 - m1 * rho2
    return reF * reF + imF * imF, reF, imF


def grid_points(k):
    if k <= 1:
        return [0.0]
    return [i / (k - 1) for i in range(k)]


def min_over_cube(n, m, ell, Lam, m1, n1, m2, n2, j, grid_k=5):
    best = None
    for rho1 in grid_points(grid_k):
        for sigma1 in grid_points(grid_k):
            for v1 in grid_points(grid_k):
                val, reF, imF = f_squared(
                    n, m, ell, Lam, rho1, sigma1, v1, m1, n1, m2, n2, j
                )
                if best is None or val < best[0]:
                    best = (val, rho1, sigma1, v1, reF, imF)
    return best


def enumerate_tuples(bound_lin=5, bound_n2=1, bound_j=5):
    """Yield integer (m1,n1,m2,n2,j), j odd, |m1|,|n1|<=bound_lin,
    |n2|<=bound_n2, |j|<=bound_j, satisfying Sen's discriminant condition
    4*m1*n1 + 4*m2*n2 + j^2 = 1.

    For n2 != 0: m2 is uniquely determined (kept only if integer).
    For n2 == 0: m2 does not appear in the discriminant (free); we scan a
    small range for m2 since it shifts where the (n2=0, affine) wall sits
    within the real cube.
    """
    for n2 in range(-bound_n2, bound_n2 + 1):
        for j in range(-bound_j, bound_j + 1):
            if j % 2 == 0:
                continue
            for m1 in range(-bound_lin, bound_lin + 1):
                for n1 in range(-bound_lin, bound_lin + 1):
                    rhs = 1 - 4 * m1 * n1 - j * j
                    if n2 == 0:
                        if rhs == 0:
                            for m2 in range(-3, 4):
                                yield (m1, n1, m2, n2, j)
                        # rhs != 0 and n2 == 0 -> no valid m2, skip
                    else:
                        if rhs % (4 * n2) == 0:
                            m2 = rhs // (4 * n2)
                            yield (m1, n1, m2, n2, j)


def run_sample(n, m, ell, lambdas, grid_k=5, bound_lin=5, bound_n2=1, bound_j=5):
    assert n >= m >= 1 and ell >= 0
    Delta = 4 * m * n - ell * ell
    print(f"\n=== sample (n,m,ell)=({n},{m},{ell})  Delta={Delta} ===")
    if Delta <= 0:
        print("  Delta<=0, skipped (outside claim.md hypothesis)")
        return

    tuples = list(enumerate_tuples(bound_lin, bound_n2, bound_j))
    print(f"  tuple search space size: {len(tuples)}")

    overall_best = None
    for Lam in lambdas:
        best_here = None
        for (m1, n1, m2, n2, j) in tuples:
            res = min_over_cube(n, m, ell, Lam, m1, n1, m2, n2, j, grid_k)
            val = res[0]
            if best_here is None or val < best_here[0]:
                best_here = (val, (m1, n1, m2, n2, j), res)
        val, tup, res = best_here
        flag = "  <-- NEAR-ZERO (|F|^2 < 1e-9)" if val < 1e-9 else ""
        print(
            f"  Lambda={Lam:6.2f}  min|F|^2={val:.6e}  "
            f"argmin tuple={tup}  (rho1,sigma1,v1)={res[1:4]}{flag}"
        )
        if overall_best is None or val < overall_best[0]:
            overall_best = (val, Lam, tup, res)

    val, Lam, tup, res = overall_best
    print(
        f"  >>> GLOBAL min over this Lambda grid: |F|^2={val:.6e} at "
        f"Lambda={Lam}, tuple={tup}"
    )
    if val < 1e-9:
        print(
            f"  >>> VIOLATION (contour meets a zero) at Lambda={Lam}: "
            f"tuple={tup}, point={res[1:4]}"
        )
    else:
        print(
            "  >>> no violation found in this search "
            "(does NOT prove absence outside search bounds; see proof.md GAP-n2)"
        )


if __name__ == "__main__":
    print("=== SymPy algebra check: proof.md section 5.1 B1/B2/B3 formulas ===")
    compute_B1B2B3()
    print()

    lambdas = [1, 2, 5, 10, 20, 50, 100]

    samples = [
        (1, 1, 1, "n=m=1, ell=m=1 (odd, parity-excluded for n2=0)"),
        (2, 2, 2, "n=m=2, ell=m=2 (even boundary)"),
        (2, 2, 1, "n=m=2, ell=1 (odd)"),
        (2, 2, 0, "n=m=2, ell=0 (boundary counterexample expected)"),
        (3, 2, 2, "n=3,m=2, ell=2=m (even boundary)"),
        (3, 2, 1, "n=3,m=2, ell=1 (odd)"),
        (5, 3, 0, "n=5,m=3, ell=0 (boundary counterexample expected)"),
        (5, 3, 2, "n=5,m=3, ell=2 (even, 0<ell<m)"),
        (10, 5, 4, "n=10,m=5, ell=4=m (even boundary)"),
        (10, 1, 0, "n=10,m=1, ell=0 (boundary counterexample expected, m=1)"),
    ]

    print("Route A numerical verification -- pure Python, no numpy/scipy.")
    print(f"Lambda grid: {lambdas}")
    print(
        "Tuple search bounds: |m1|,|n1|<=5, |n2|<=1, |j|<=5, m2 solved "
        "from discriminant (n2!=0) or scanned in [-3,3] (n2=0)."
    )
    print("Cube grid: 5x5x5 uniform points in [0,1]^3 per (tuple, Lambda).")

    for (n, m, ell, desc) in samples:
        print(f"\n[{desc}]")
        run_sample(n, m, ell, lambdas)
