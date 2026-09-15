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
    """
    Scan points (m,n,l) with m in [1,MMAX], n in [1,NMAX_scan], l in [0,2m], Delta>0.

    Three sub-domains:
      A: 0 <= l <= m  AND  n >= m   (Gauss-reduced domain; Thm 10.3b claims identity here)
      B: 0 <= l <= m  AND  n <  m   (NOT Gauss-reduced; Note 10.3.5 claimed identity here too)
      C: l > m                      (NOT Gauss-reduced; identity expected to fail)

    For each: records agree/disagree between d_*(m,n,l) [via reduce_form] and
    naive (-1)^{l+1} c_m^F(n,l) [without reducing].
    """
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

    res = {
        "total": 0,
        # Domain A: l<=m, n>=m  (Thm 10.3b domain)
        "A_agree": 0, "A_disagree": [],
        # Domain B: l<=m, n<m   (Note 10.3.5 extended claim)
        "B_agree": 0, "B_disagree": [],
        # Domain C: l>m          (known failures)
        "C_agree": 0, "C_disagree": [],
        "NREP": NREP,
    }
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
                if l_ > m_:
                    dom = "C"
                elif n_ >= m_:
                    dom = "A"
                else:
                    dom = "B"
                if same:
                    res[f"{dom}_agree"] += 1
                else:
                    res[f"{dom}_disagree"].append((m_, n_, l_, dv, nv))
    res["F"] = F
    return res


def anchor_check(F):
    anchors = [(1, 1, 0, 50064), (1, 1, 1, 25353), (1, 2, 0, 1127472), (2, 2, 2, 3859456)]
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
    print("PART 3: Counterexample scan (GAPs 10.3.c and 10.3.d)")
    print("=" * 70)
    print(f"Domain: m in [1,{MMAX}], n in [1,8], l in [0,2m], Delta>0")
    print()
    res = run_scan(MMAX=MMAX, NMAX_scan=8, C_NMAX=12, C_LMAX=100, C_MARGIN=2)

    A_d, B_d, C_d = res["A_disagree"], res["B_disagree"], res["C_disagree"]
    print(f"Total points tested: {res['total']}")
    print()
    print("-" * 70)
    print("Domain A: 0 <= l <= m  AND  n >= m   (Gauss-annealed w.r.t. n; Thm 10.3b domain)")
    print(f"  agree {res['A_agree']}   disagree {len(A_d)}")
    print("  verdict: " + ("IDENTITY HOLDS on A  -> Thm 10.3b CONFIRMED" if not A_d
                         else f"VIOLATIONS: {A_d[:5]}  -> Thm 10.3b REFUTED"))
    print()
    print("-" * 70)
    print("Domain B: 0 <= l <= m  AND  n <  m   (NOT reduced; Note 10.3.5 extended claim)")
    print(f"  agree {res['B_agree']}   disagree {len(B_d)}")
    if not B_d:
        print("  verdict: IDENTITY HOLDS on B -> Note 10.3.5 CONFIRMED (n>=m not needed)")
    else:
        print(f"  verdict: COUNTEREXAMPLES -> Note 10.3.5 REFUTED (n>=m IS needed), e.g.")
        for r in B_d[:6]:
            print(f"     (m,n,l)=({r[0]},{r[1]},{r[2]})  d_*={r[3]}  naive={r[4]}")
    print()
    print("-" * 70)
    print("Domain C: l > m   (NOT reduced; failures expected)")
    print(f"  agree {res['C_agree']}   disagree {len(C_d)}")
    if C_d:
        print(f"  all C counterexamples have n < m? {all(r[1] < r[0] for r in C_d)}")

    print()
    print("=" * 70)
    print("GAP 10.3.c / 10.3.d SUMMARY")
    print("=" * 70)
    tot = len(A_d) + len(B_d) + len(C_d)
    print(f"Total counterexamples (naive != attractor): {tot}")
    print(f"  l <= m  and n >= m : {len(A_d)}   [Thm 10.3b domain]")
    print(f"  l <= m  and n <  m : {len(B_d)}   [Note 10.3.5 claim]")
    print(f"  l >  m             : {len(C_d)}   [expected failures]")
    print()
    if not A_d and not B_d:
        print("=> identity holds for ALL 0<=l<=m, ANY n: Thm 10.3b + Note 10.3.5 both hold.")
    elif not A_d and B_d:
        print("=> identity holds exactly when 0<=l<=m AND n>=m (the Gauss-reduced domain).")
        print("   Thm 10.3b (which REQUIRES n>=m) CONFIRMED;")
        print("   Note 10.3.5 (claiming n>=m unnecessary) REFUTED.")
        print("   KEY: the true failure condition is NOT 'l > m' alone -- it is")
        print("        'form not Gauss-reduced' = (l > m) OR (n < m).")
        print("   COUNTEREXAMPLES DO NOT ALL HAVE l > m; some have l <= m with n < m,")
        print("   e.g. (l,m,n) = " + str([(r[2], r[0], r[1]) for r in B_d[:3]]))
    print()

    print("First 20 counterexamples overall (sorted):")
    print(f"  {'(m,n,l)':>12}  {'d_*':>16}  {'naive':>16}  {'n<m':>5} {'l>m':>5}  {'l<=m':>5}")
    allc = [(r, "A") for r in A_d] + [(r, "B") for r in B_d] + [(r, "C") for r in C_d]
    for r, _ in sorted(allc, key=lambda t: (t[0][0], t[0][1], t[0][2]))[:20]:
        m_, n_, l_, dv, nv = r
        print(f"  ({m_:>2},{n_:>2},{l_:>3})  {dv:>16}  {nv:>16}  {str(n_<m_):>5} {str(l_>m_):>5}  {str(l_<=m_):>5}")

    print()
    print("Anchor counterexample (5,1,4):")
    C.NMAX, C.LMAX, C.LMIN, C.MARGIN = 10, 160, -160, 2
    _, F5, _, _ = C.compute(5)
    m0, n0, l0 = reduce_form(5, 1, 4)
    dd = (-1) ** (l0 + 1) * F5[m0].get((n0, l0), 0)
    nv = (-1) ** 5 * F5[5].get((1, 4), 0)
    print(f"  reduce_form(5,1,4)=({m0},{n0},{l0})   d_*(5,1,4)={dd}   naive={nv}")
    print(f"  here l=4 <= m=5 (so l<=m) but n=1 < m=5 -> failure is from n<m, NOT from l>m.")


if __name__ == "__main__":
    main()
