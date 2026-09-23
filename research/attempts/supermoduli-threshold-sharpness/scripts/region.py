#!/usr/bin/env python3
"""Enumerate the (g, n, r) region for the compactified punctured supermoduli
superstack  Sbar_{g; n, 2r}  and print which claim of ../proof.md covers each cell.

Conventions (identical to ../claim.md section 0):
    stability          2g - 2 + n + 2r > 0
    dim Sbar           (3g - 3 + n + 2r  |  2g - 2 + n + r)
    D := 3g - 3 + n + 2r          bosonic dimension
    d := 2g - 2 + n + r           odd rank = rank T_-

Run:
    python scripts/region.py            # table up to g<=4, n<=8, r<=4
    python scripts/region.py 6 12 6     # custom bounds

The script proves nothing; it is the finite bookkeeping behind
Corollary 1.3, Theorem 5.1 and the table of proof.md section 5.3, and it
checks the two arithmetic assertions made there:
  (A) no stable triple with g>=2 has d<=1;
  (B) (g,n,r)=(0,4,0) is the unique stable triple with D==1 and d==2,
      hence the unique cell reachable by the degree argument of section 4.
"""

import sys


def stable(g, n, r):
    return 2 * g - 2 + n + 2 * r > 0


def D(g, n, r):  # bosonic dimension
    return 3 * g - 3 + n + 2 * r


def d(g, n, r):  # odd rank
    return 2 * g - 2 + n + r


def verdict(g, n, r):
    """Return (verdict, reason) exactly as justified in ../proof.md."""
    if g >= 2:
        if g >= 3 or n + 2 * r >= 2:
            return "non-projected", "Thm 3.3 via K5 (paper.md Cor 8.5)"
        if (n, r) == (1, 0):
            return "non-projected", "Thm 3.3 via Prop 3.1 (K3 [DW 1.2] + Lem 2.1)"
        if (n, r) == (0, 0):
            return "non-projected", "Thm 3.3 via Prop 3.2 (K4 [CN 1.1(2)])"
        raise AssertionError("unreachable: g>=2 case analysis is exhaustive")
    if d(g, n, r) <= 1:
        return "split", "Cor 1.3 (odd rank <= 1, Lem 1.1)"
    if (g, n, r) == (0, 4, 0):
        return "split", "Thm 4.5 (omega_2 = 0 on the mu_2-root stack, rank 2)"
    return "OPEN", "-"


def main(gmax=4, nmax=8, rmax=4):
    rows = []
    for g in range(0, gmax + 1):
        for n in range(0, nmax + 1):
            for r in range(0, rmax + 1):
                if not stable(g, n, r):
                    continue
                v, why = verdict(g, n, r)
                rows.append((g, n, r, D(g, n, r), d(g, n, r), v, why))

    # ---- assertion (A): g>=2 never has odd rank <= 1
    bad = [t for t in rows if t[0] >= 2 and t[4] <= 1]
    assert not bad, f"(A) failed: {bad}"

    # ---- assertion (B): (0,4,0) is the unique stable cell with D==1 and d==2
    degree_method = [t[:3] for t in rows if t[3] == 1 and t[4] == 2]
    assert degree_method == [(0, 4, 0)], f"(B) failed: {degree_method}"

    # ---- the stable cells of bosonic dimension <= 1 (Theorem 5.1)
    lowdim = [t for t in rows if t[3] <= 1]
    assert all(t[5] == "split" for t in lowdim), "Thm 5.1 broken"

    # ---- the rank-2 locus, where [CN, Prop 2.2] gives an iff criterion
    rank2 = [t for t in rows if t[4] == 2]

    print("g   n  2r    D    d   verdict          reason")
    print("-" * 78)
    for g, n, r, DD, dd, v, why in rows:
        flag = "  <<<" if v == "OPEN" else ""
        print(f"{g}  {n:2d}  {2*r:2d}  {DD:3d}  {dd:3d}   {v:14s}  {why}{flag}")

    print()
    print("Stable cells with bosonic dimension <= 1 (all split, Thm 5.1):")
    for g, n, r, DD, dd, v, why in lowdim:
        print(f"   (g;n,2r) = ({g};{n},{2*r})   dim = ({DD}|{dd})   {why}")

    print()
    print("Rank-2 locus 2g-2+n+r == 2  (the only place [CN, Prop 2.2] is an iff):")
    for g, n, r, DD, dd, v, why in rank2:
        tag = {"split": "SETTLED split", "non-projected": "SETTLED non-proj",
               "OPEN": "OPEN"}[v]
        print(f"   (g;n,2r) = ({g};{n},{2*r})   bosonic dim = {DD}   {tag}")

    nopen = sum(1 for t in rows if t[5] == "OPEN")
    print()
    print(f"total stable cells listed: {len(rows)};  open: {nopen}")
    print("assertions (A) and (B) of the docstring: PASS")


if __name__ == "__main__":
    args = [int(a) for a in sys.argv[1:]]
    main(*args) if args else main()
