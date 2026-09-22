"""P1 attack, sandbox: verify the "rank-2 core" of Lemma 5.2's tower version.

Setting (see research/attempts/borcherds-rank-one-noghost/scoping.md, claim.md):
  hl = span(b, e_+) is the light-cone 2-plane, e_+ := a - b, so that
    eta(b,b) = 0, eta(e_+,e_+) = 0, eta(b,e_+) = 1   (a genuine hyperbolic pair).
  K_n  := b·alpha_n     (n in Z)   -- Borcherds' K_i, D1 of scoping.md
  Kt_n := e_+·alpha_n   (n in Z)   -- the "missing" conjugate longitudinal oscillator

  [K_m, Kt_n] = m * delta_{m+n,0}      (all m,n in Z; both same-species brackets vanish)
  K_0  = eta(b, v_j)   = 1             (v_j = a+jb, ALWAYS, by condition (S))
  Kt_0 = eta(e_+, v_j) = j+1           (write x := j+1, ranges over all integers)

  L_{-m}^hl := sum_n :K_{-m-n} Kt_n:   (Sugawara stress tensor restricted to the
                                        2-oscillator light-cone plane; central charge 2)

Claim under test ("rank-2 core", the pure-hl case of Borcherds Lemma 5.2 / P1 with V
taken to be the trivial 1-dimensional vertex algebra):

  For every level M >= 0, the vectors
      { L_{-m_1}^hl ... L_{-m_s}^hl  K_{-n_1} ... K_{-n_t} |0;v_j> :  s,t >= 0, m_i,n_i >= 1 }
  span the WHOLE level-M subspace of F_hl(v_j)  (dimension = p_2(M), the number of
  2-colored partitions of M), for EVERY integer x = j+1 (no genericity needed).

This script builds the monomial (K,Kt)-Fock space explicitly at level M, computes the
matrix of {L,K}-monomials of total weight M applied to |0;v_j>, expressed in the
(K,Kt)-monomial basis, and checks its RANK against dim F_hl,M = p_2(M), for several
integer AND non-integer rational values of x.  All arithmetic is EXACT (fractions.Fraction).

Run:
  cd "D:/physics/string/.claude/worktrees/agent-a250452a479ac93fd"
  PYTHONIOENCODING=utf-8 uv run python research/sandbox/rank2-core-check.py
"""

from fractions import Fraction as Q
from itertools import product


# ---------------------------------------------------------------------------
# Vector representation: a "vector" is a dict {monomial: coeff}, where a
# monomial is a tuple of (species, n) pairs, species in {'K','T'} ('T' = Kt),
# n >= 1, SORTED so that equal monomials compare equal.  Level of a monomial
# = sum of the n's.
# ---------------------------------------------------------------------------

def level_of(mono):
    return sum(n for _, n in mono)


def add_factor(mono, species, n):
    """Insert one creation factor (species, n) into a monomial (n >= 1)."""
    lst = list(mono) + [(species, n)]
    lst.sort()
    return tuple(lst)


def apply_K(p, v):
    """Apply K_p to vector v.  p<0: creation.  p=0: scalar K_0=1.  p>0: annihilate
    against Kt_{-p} factors (coefficient p * multiplicity)."""
    if p < 0:
        n = -p
        out = {}
        for mono, c in v.items():
            newm = add_factor(mono, 'K', n)
            out[newm] = out.get(newm, Q(0)) + c
        return out
    if p == 0:
        return dict(v)  # K_0 = 1
    # p > 0: annihilation against Kt_{-p}
    out = {}
    for mono, c in v.items():
        lst = list(mono)
        mult = lst.count(('T', p))
        if mult == 0:
            continue
        lst.remove(('T', p))
        newm = tuple(sorted(lst))
        coeff = c * p * mult
        out[newm] = out.get(newm, Q(0)) + coeff
    return {m: c for m, c in out.items() if c != 0}


def apply_Kt(p, v, x):
    """Apply Kt_p to vector v.  p<0: creation.  p=0: scalar Kt_0 = x.  p>0:
    annihilate against K_{-p} factors (coefficient p * multiplicity)."""
    if p < 0:
        n = -p
        out = {}
        for mono, c in v.items():
            newm = add_factor(mono, 'T', n)
            out[newm] = out.get(newm, Q(0)) + c
        return out
    if p == 0:
        return {m: c * x for m, c in v.items() if c * x != 0}
    out = {}
    for mono, c in v.items():
        lst = list(mono)
        mult = lst.count(('K', p))
        if mult == 0:
            continue
        lst.remove(('K', p))
        newm = tuple(sorted(lst))
        coeff = c * p * mult
        out[newm] = out.get(newm, Q(0)) + coeff
    return {m: c for m, c in out.items() if c != 0}


def apply_bilinear(a, b, v, x):
    """Apply the normal-ordered product :K_a Kt_b: to v (creation modes leftmost)."""
    if a < 0:
        # K_a is creation -> goes left in normal order -> apply Kt_b FIRST, then K_a
        v1 = apply_Kt(b, v, x)
        return apply_K(a, v1)
    elif b < 0:
        # Kt_b creation, K_a annihilation/scalar -> apply K_a first, then Kt_b
        v1 = apply_K(a, v)
        return apply_Kt(b, v1, x)
    else:
        # both a>=0, b>=0 (annihilation/scalar): commute (disjoint species slots)
        v1 = apply_K(a, v)
        return apply_Kt(b, v1, x)


def L_minus(m, v, x):
    """Apply L_{-m}^hl (m >= 1) to level-homogeneous vector v."""
    assert m >= 1
    if not v:
        return {}
    Mp = level_of(next(iter(v)))  # input level (v assumed homogeneous)
    lo = -(Mp + m)
    hi = Mp
    out = {}
    for n in range(lo, hi + 1):
        a = -m - n
        term = apply_bilinear(a, n, v, x)
        for mono, c in term.items():
            out[mono] = out.get(mono, Q(0)) + c
    return {mm: c for mm, c in out.items() if c != 0}


VAC = {(): Q(1)}


def apply_monomial_to_vac(ops, x):
    """ops: list of ('L', m) or ('K', n), m,n >= 1, applied so that ops[0] is
    applied FIRST (closest to vacuum)."""
    v = VAC
    for kind, n in ops:
        if kind == 'K':
            v = apply_K(-n, v)
        elif kind == 'L':
            v = L_minus(n, v, x)
        else:
            raise ValueError(kind)
    return v


# ---------------------------------------------------------------------------
# Basis of level-M subspace: all 2-colored partitions of M.
# ---------------------------------------------------------------------------

def two_colored_partitions(M):
    def rec(remaining, max_part):
        if remaining == 0:
            yield ()
            return
        for part in range(min(remaining, max_part), 0, -1):
            for color in ('K', 'T'):
                for rest in rec(remaining - part, part):
                    yield ((color, part),) + rest
    seen = set()
    for mono in rec(M, M):
        seen.add(tuple(sorted(mono)))
    return sorted(seen)


def rank_over_Q(rows, ncols):
    rows = [list(r) for r in rows]
    r = 0
    nrows = len(rows)
    for c in range(ncols):
        piv = None
        for i in range(r, nrows):
            if rows[i][c] != 0:
                piv = i
                break
        if piv is None:
            continue
        rows[r], rows[piv] = rows[piv], rows[r]
        pr = rows[r]
        for i in range(nrows):
            if i != r and rows[i][c] != 0:
                f = rows[i][c] / pr[c]
                rows[i] = [aa - f * bb for aa, bb in zip(rows[i], pr)]
        r += 1
        if r == nrows:
            break
    return r


def generator_monomials(M):
    """All sequences of ('L',m)/('K',n) generators (m,n>=1) with total weight M,
    ops[0] applied FIRST (closest to vacuum)."""
    def rec(remaining):
        if remaining == 0:
            yield ()
            return
        for part in range(1, remaining + 1):
            for kind in ('L', 'K'):
                for rest in rec(remaining - part):
                    yield ((kind, part),) + rest
    return list(rec(M))


def test_level(M, x_values):
    basis = two_colored_partitions(M)
    dim = len(basis)
    index = {b: i for i, b in enumerate(basis)}
    gens = generator_monomials(M)
    results = []
    for x in x_values:
        rows = []
        for ops in gens:
            v = apply_monomial_to_vac(ops, x)
            row = [Q(0)] * dim
            for mono, c in v.items():
                row[index[mono]] = c
            rows.append(row)
        r = rank_over_Q(rows, dim)
        results.append((x, r))
    return dim, len(gens), results


# ---------------------------------------------------------------------------
# T_j^hl check: dim of {physical (L_m=0, m>=1) AND K-primary (K_i=0, i>0)}
# at each level, i.e. the kernel of ALL raising operators {L_1,...,L_M,K_1,...,K_M}
# acting within the level-M subspace.  Theorem A (proof.md) only needs |0> in T_j,
# but Borcherds' Lemma 5.3 picture (T ~= Ve^r) predicts this kernel is EXACTLY
# 1-dimensional (= R|0>) in this pure light-cone (D=2) case.  Verified here for
# M=0..4 and several x -- NOT proven by hand in proof.md (marked [GAP]).
# ---------------------------------------------------------------------------

def L_plus(m, v, x):
    """Apply the RAISING operator L_m (m >= 1) to level-homogeneous v."""
    if not v:
        return {}
    Mp = level_of(next(iter(v)))
    out = {}
    for n in range(-(Mp + abs(m) + 2), Mp + abs(m) + 3):
        a = m - n
        term = apply_bilinear(a, n, v, x)
        for mono, c in term.items():
            out[mono] = out.get(mono, Q(0)) + c
    return {mm: c for mm, c in out.items() if c != 0}


def Tj_hl_dimension(M, x):
    """dim of ker(L_1,...,L_M, K_1,...,K_M) restricted to level M of F_hl(v_j)."""
    basis = two_colored_partitions(M)
    dim = len(basis)
    if dim == 0:
        return 0
    big = [[] for _ in basis]
    for m in range(1, M + 1):
        target_basis = two_colored_partitions(M - m)
        tindex = {b: j for j, b in enumerate(target_basis)}
        for bi, mono in enumerate(basis):
            img = L_plus(m, {mono: Q(1)}, x)
            col = [Q(0)] * len(target_basis)
            for tm, c in img.items():
                col[tindex[tm]] = c
            big[bi].extend(col)
    for i in range(1, M + 1):
        target_basis = two_colored_partitions(M - i)
        tindex = {b: j for j, b in enumerate(target_basis)}
        for bi, mono in enumerate(basis):
            img = apply_K(i, {mono: Q(1)})
            col = [Q(0)] * len(target_basis)
            for tm, c in img.items():
                col[tindex[tm]] = c
            big[bi].extend(col)
    ncols = len(big[0]) if big and big[0] else 0
    r = rank_over_Q(big, ncols)
    return dim - r


if __name__ == '__main__':
    print("=" * 78)
    print("Rank-2 core check: do {L_{-m}, K_{-n}} monomials span F_hl(v_j) at each level?")
    print("=" * 78)
    x_values = [Q(0), Q(1), Q(-1), Q(2), Q(-2), Q(3), Q(1, 2), Q(-1, 3), Q(5)]
    for M in range(0, 7):
        dim, ngens, results = test_level(M, x_values)
        all_full = all(r == dim for _, r in results)
        print(f"\nlevel M = {M}: dim F_hl,{M} = {dim}  (#generator monomials = {ngens})")
        for x, r in results:
            flag = "OK" if r == dim else "**RANK DEFICIENT**"
            print(f"    x = {str(x):>6}  rank = {r:3d} / {dim:3d}   {flag}")
        print(f"  ==> {'FULL RANK for all tested x' if all_full else 'FAILS for some x!'}")
    print()
    print("=" * 78)
    print("T_j^hl dimension check: is ker(L_{m>0}, K_{i>0}) exactly R|0> at level M>=1?")
    print("(Borcherds Lemma 5.3 picture predicts YES -- 1-dim'l per momentum, T~=Ve^r.)")
    print("=" * 78)
    for x in (Q(0), Q(1), Q(-2), Q(1, 2)):
        print(f"\n  x = {x}:")
        for M in range(1, 5):
            d = Tj_hl_dimension(M, x)
            flag = "OK (= C|0>)" if d == 0 else "**EXTRA T_j ELEMENTS FOUND**"
            print(f"    level M = {M}:  dim T_j^hl = {d}   {flag}")
    print()
    print("=" * 78)
