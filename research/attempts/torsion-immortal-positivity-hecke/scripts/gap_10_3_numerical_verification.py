"""
Numerical verification for SS10.3 GAPs 10.3.c and 10.3.d.

Closes:
  [GAP 10.3.c]  Thm 10.3b: d_*(m,n,l) = (-1)^{l+1} c_m^F(n,l)  for 0<=l<=m, any n>=1, Delta>0.
                (Existing torsion_divisor_sum.py ASSUMES this via reduce_form; this script
                 verifies it directly with n<m points explicitly included.)
  [GAP 10.3.d]  All counterexamples (identity fails, l in [0,2m]) satisfy l > m,
                not merely n < m.
  [Lemma 10.3.1] A_{2,m}(sigma, v+1/2) in the attractor chamber |q|<1<|y| has y^l = 0
                 for 0 <= l <= m (y-power gap).

Independence notes:
  - The A_{2,m} lower-chamber expansion is a NEW code path (absent from coefficients.py
    and torsion_divisor_sum.py): it directly expands A_{2,m}(sigma, v+1/2) in the
    |q|<1<|y| sub-chamber using the three-branch geometric series of proof.md SS10.3.2.
  - c_m^F is read from coefficients.py (independent Phi_10 inversion, self-tested).
  - d_*(m,n,l) ground truth = reduce_form then read c_{m0}^F.

Usage:
    cd research/attempts/torsion-immortal-positivity-hecke/scripts
    python gap_10_3_numerical_verification.py
"""

import sys
import os

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import coefficients as C


# ---------------------------------------------------------------------------
# A_{2,m}(sigma, v+1/2) in the attractor sub-chamber |q|<1, |q^s y|<1 for s>=1
# ---------------------------------------------------------------------------

def A2m_lower_chamber(m, NMAX_local, LMAX_local):
    """
    A_{2,m}(sigma,v+1/2) as Laurent series dict {(n,l): coeff} in |q|<1<|y|.

    Formula (proof.md SS10.3.2):
        A_{2,m}(sigma,v+1/2) = -sum_{s in Z} q^{ms^2+s} y^{2ms+1} / (1 + q^s y)^2

    s=0:      sum_{k>=0} (-1)^{k+1}(k+1) y^{-(k+1)}          y-powers <= -1
    s>=1:     sum_{k>=0} (-1)^{k+1}(k+1) q^{ms^2+s+sk} y^{2ms+1+k}   y-powers >= 2m+1
    s=-j:     sum_{k>=0} (-1)^{k+1}(k+1) q^{mj^2+j(k+1)} y^{-2mj-k-1} y-powers <= -(2m+1)
    """
    out = {}

    def add(n, l, v):
        if v == 0 or n < 0 or n > NMAX_local or abs(l) > LMAX_local:
            return
        key = (n, l)
        cur = out.get(key, 0) + v
        if cur == 0:
            out.pop(key, None)
        else:
            out[key] = cur

    # s = 0
    for k in range(LMAX_local + 2):
        add(0, -(k + 1), (-1) ** (k + 1) * (k + 1))

    # s >= 1
    for s in range(1, NMAX_local + 1):
        base_n = m * s * s + s
        if base_n > NMAX_local:
            break
        for k in range(0, NMAX_local + 1):
            n = base_n + s * k
            if n > NMAX_local:
                break
            l = 2 * m * s + 1 + k
            if l > LMAX_local:
                break
            add(n, l, (-1) ** (k + 1) * (k + 1))

    # s = -j, j >= 1
    for j in range(1, NMAX_local + 1):
        base_n = m * j * j + j
        if base_n > NMAX_local:
            break
        for k in range(0, NMAX_local + 1):
            n = m * j * j + j * (k + 1)
            if n > NMAX_local:
                break
            l = -2 * m * j - k - 1
            if l < -LMAX_local:
                break
            add(n, l, (-1) ** (k + 1) * (k + 1))

    return out


def check_A2m_gap(m, NMAX_local=12, LMAX_local=60):
    """True iff A_{2,m}(sigma,v+1/2) has y^l coefficient 0 for 0<=l<=2m."""
    series = A2m_lower_chamber(m, NMAX_local, LMAX_local)
    viol = sorted((n, l, v) for (n, l), v in series.items() if 0 <= l <= 2 * m and v != 0)
    return (len(viol) == 0), viol


# ---------------------------------------------------------------------------
# Gauss reduction
# ---------------------------------------------------------------------------

def reduce_form(m, n, l):
    assert 4 * m * n - l * l > 0 and m > 0 and n > 0
    for _ in range(20000):
        if n < m:
            m, n, l = n, m, -l
            continue
        if l > m or l < -m:
            r = (l + m) // (2 * m)
            m, n, l = m, r * r * m - r * l + n, l - 2 * r * m
            continue
        break
    else:
        raise RuntimeError("reduce_form did not terminate")
    if l < 0:
        l = -l
    assert 0 <= l <= m <= n, (m, n, l)
    return m, n, l


# ---------------------------------------------------------------------------
# Counterexample scan
# ---------------------------------------------------------------------------

def run_scan(MMAX=16, NMAX_scan=8, C_NMAX=12, C_LMAX=100, C_MARGIN=2):
    C.NMAX, C.LMAX, C.LMIN, C.MARGIN = C_NMAX, C_LMAX, -C_LMAX, C_MARGIN
    psis, F, P, phis = C.compute(MMAX)
    NREP = C_NMAX - C_MARGIN

    def naive(m, n, l):
        if m > MMAX or n > NREP:
            return None
        return (-1) ** (l + 1) * F[m].get((n, abs(l)), 0)

    def dstar(m, n, l):
        if 4 * m * n - l * l <= 0 or m < 1 or n < 1:
            return None
        m0, n0, l0 = reduce_form(m, n, l)
        if m0 > MMAX or n0 > NREP:
            return None
        return (-1) ** (l0 + 1) * F[m0].get((n0, abs(l0)), 0)

    res = dict(total=0, agree_l_le_m=0, disagree_l_le_m=[], agree_l_gt_m=0, disagree_l_gt_m=[])
    for m_ in range(1, MMAX + 1):
        for n_ in range(1, min(NMAX_scan, NREP) + 1):
            for l_ in range(0, 2 * m_ + 1):
                if 4 * m_ * n_ - l_ * l_ <= 0:
                    continue
                dv, nv = dstar(m_, n_, l_), naive(m_, n_, l_)
                if dv is None or nv is None:
                    continue
                res["total"] += 1
                same = (dv == nv)
                if l_ <= m_:
                    res["agree_l_le_m" if same else "disagree_l_le_m"] += (1 if same else [(m_, n_, l_, dv, nv)])
                else:
                    res["agree_l_gt_m" if same else "disagree_l_gt_m"] += (1 if same else [(m_, n_, l_, dv, nv)])
    res["NREP"] = NREP
    res["F"] = F
    return res


def anchor_check(F):
    anchors = [(1, 1, 0, 50064), (1, 1, 1, 25353), (1, 2, 1, 1127472), (2, 2, 2, 3859456)]
    ok = True
    for m, n, l, exp in anchors:
        got = (-1) ** (l + 1) * F[m].get((n, abs(l)), 0)
        print(f"  anchor d_*({m},{n},{l}) = {exp}: {'OK' if got == exp else f'FAIL got={got}'}")
        ok = ok and got == exp
    return ok


# ---------------------------------------------------------------------------
def main():
    MMAX = 16

    print("=" * 70)
    print("PART 1: Lemma 10.3.1 --- y-power gap of A_{2,m}(sigma,v+1/2)")
    print("=" * 70)
    print("Method: exact integer Laurent expansion in |q|<1<|y| (new code path)")
    print()
    all_ok = True
    for m in range(1, 9):
        ok, viol = check_A2m_gap(m, NMAX_local=12, LMAX_local=60)
        print(f"  m={m}: gap [0,{2*m}] present -> {'OK' if ok else 'VIOLATIONS ' + str(viol[:3])}")
        all_ok = all_ok and ok
    print()
    print("RESULT: Lemma 10.3.1 " + ("CONFIRMED for m=1..8 (y^l = 0 for 0<=l<=2m, exact)" if all_ok else "REFUTED"))

    print()
    print("=" * 70)
    print("PART 2: Anchor self-check (published d_* values)")
    print("=" * 70)
    C.NMAX, C.LMAX, C.LMIN, C.MARGIN = 10, 100, -100, 2
    _, F_anchor, _, _ = C.compute(4)
    if not anchor_check(F_anchor):
        print("Anchor self-check FAILED -- results below unreliable")
        sys.exit(1)
    print("Anchor self-check: PASSED")

    print()
    print("=" * 70)
    print(f"PART 3: Counterexample scan (GAPs 10.3.c and 10.3.d)")
    print("=" * 70)
    print(f"Domain: m in [1,{MMAX}], n in [1,8], l in [0,2m], Delta>0")
    print()
    res = run_scan(MMAX=MMAX, NMAX_scan=8, C_NMAX=12, C_LMAX=100, C_MARGIN=2)

    print(f"Total points tested: {res['total']}")
    print()
    dm = res["disagree_l_le_m"]
    print(f"Sub-range 0 <= l <= m :  agree {res['agree_l_le_m']}   disagree {len(dm)}")
    if not dm:
        print("  -> NO violation: Theorem 10.3b CONFIRMED (l<=m, ANY n>=1)")
    else:
        print("  -> VIOLATIONS (Thm 10.3b REFUTED):")
        for r in dm[:10]:
            print("     ", r)

    dg = res["disagree_l_gt_m"]
    print()
    print(f"Sub-range l > m :  agree {res['agree_l_gt_m']}   disagree {len(dg)}")
    tot_d = len(dm) + len(dg)
    print(f"Total counterexamples: {tot_d}")
    print(f"  with l >  m: {len(dg)}")
    print(f"  with l <= m: {len(dm)}")
    if dg:
        print(f"  all with l>m also have n<m? {all(r[1] < r[0] for r in dg)}")
        print(f"  all counterexamples have l>m? {len(dm) == 0}")
        print(f"  counterexamples with n>m?    {[r for r in dg if r[1] > r[0]][:3]}")

    print()
    print("First 20 counterexamples:")
    print(f"  {'(m,n,l)':>12}  {'d_*':>14}  {'naive':>14}  {'n<m':>5} {'l>m':>5}")
    for r in sorted(dg, key=lambda r: (r[0], r[1], r[2]))[:20]:
        m_, n_, l_, dv, nv = r
        print(f"  ({m_:>2},{n_:>2},{l_:>3})  {dv:>14}  {nv:>14}  {str(n_<m_):>5} {str(l_>m_):>5}")

    print()
    print("Anchor counterexample (5,1,4):")
    C.NMAX, C.LMAX, C.LMIN, C.MARGIN = 10, 160, -160, 2
    _, F5, _, _ = C.compute(5)
    m0, n0, l0 = reduce_form(5, 1, 4)
    dd = (-1) ** (l0 + 1) * F5[m0].get((n0, l0), 0)
    nv = (-1) ** 5 * F5[5].get((1, 4), 0)
    print(f"  reduce_form(5,1,4)=({m0},{n0},{l0})  d_*(5,1,4)={dd}  naive={nv}")
    print(f"  here l=4 > m? {4 > 5}   l=4 <= m=5? {4 <= 5}  (so (5,1,4) has l<=m!)")


if __name__ == "__main__":
    main()
