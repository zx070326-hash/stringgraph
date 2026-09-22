"""P1 attack, sandbox: does the FULL Borcherds Lemma 5.2 tower version (not just its
D=2 "rank-2 core" shadow) hold, once we add ONE transverse free boson (D=3)?

Species: 'K' = b.alpha_n, 'T' = e_+.alpha_n (Kt), 'J' = one transverse direction
(eta(J,J)=1, commutes with K,Kt).  Commutators (all m,n in Z):
  [K_m,T_n] = m delta_{m+n,0}      [K_m,K_n]=0   [T_m,T_n]=0
  [J_m,J_n] = m delta_{m+n,0}      [J_m,K_n]=[J_m,T_n]=0
  K_0 = 1 (always), T_0 = x (x = j+1, free rational parameter), J_0 = 0 (zero
  transverse momentum -- WLOG frame adapted to span(a,b), see proof.md).

Full Sugawara:  L_{-m} = sum_n :K_{-m-n} T_n:  +  (1/2) sum_n :J_{-m-n} J_n:

T_j (Borcherds' target spanning-generator subspace) = {physical (L_m f =0, m>=1)
AND K-primary (K_i f = 0, i>0) states}.  We do NOT try to characterize T_j
explicitly (that was the flawed part of the by-hand attempt, see proof.md); instead
we test the SAME "claim (*) direct" strategy that worked for the rank-2 core:
build a spanning set for F(v_j) directly out of {L_{-m}, K_{-n}}-monomials applied
to the *single* vector |0;v_j> (which is trivially in T_j) and check its rank
against the full level-M dimension.

NOTE: this is a STRICTLY WEAKER check than "monomials on all of T_j span" (it only
uses monomials on |0>, a single element of T_j, not all of T_j) -- so a FULL RANK
result here is already an unconditional, self-contained partial verification of
P1's spanning claim (a fortiori, since |0> in T_j and monomials-on-a-subset-of-T_j
spanning implies monomials-on-T_j spans too).  A rank DEFICIT here would NOT refute
P1 (T_j may contain more than |0>), so this check can only supply positive evidence.

Run:
  cd "D:/physics/string/.claude/worktrees/agent-a250452a479ac93fd"
  PYTHONIOENCODING=utf-8 uv run python research/sandbox/rank3-full-check.py
"""

from fractions import Fraction as Q


def level_of(mono):
    return sum(n for _, n in mono)


def add_factor(mono, species, n):
    lst = list(mono) + [(species, n)]
    lst.sort()
    return tuple(lst)


def apply_species(species, conj_species, p, v, zero_mode_value):
    """Generic single-species-pair annihilation/creation, mirrors apply_K/apply_Kt
    from rank2-core-check.py.  species creates factors of its own letter; to
    annihilate it looks for conj_species factors (K<->T pairing) UNLESS
    species==conj_species (self-paired, e.g. J), in which case it annihilates its
    own letter."""
    if p < 0:
        n = -p
        out = {}
        for mono, c in v.items():
            newm = add_factor(mono, species, n)
            out[newm] = out.get(newm, Q(0)) + c
        return out
    if p == 0:
        if zero_mode_value == 0:
            return {}
        return {m: c * zero_mode_value for m, c in v.items() if c * zero_mode_value != 0}
    # p > 0: annihilate against conj_species factor at mode p
    out = {}
    for mono, c in v.items():
        lst = list(mono)
        mult = lst.count((conj_species, p))
        if mult == 0:
            continue
        lst.remove((conj_species, p))
        newm = tuple(sorted(lst))
        coeff = c * p * mult
        out[newm] = out.get(newm, Q(0)) + coeff
    return {m: c for m, c in out.items() if c != 0}


def apply_K(p, v):
    return apply_species('K', 'T', p, v, zero_mode_value=Q(1))


def apply_T(p, v, x):
    return apply_species('T', 'K', p, v, zero_mode_value=x)


def apply_J(p, v):
    return apply_species('J', 'J', p, v, zero_mode_value=Q(0))


def apply_bilinear_hl(a, b, v, x):
    """:K_a T_b:  (a=K-index, b=T-index)."""
    if a < 0:
        return apply_K(a, apply_T(b, v, x))
    else:
        v1 = apply_K(a, v)
        return apply_T(b, v1, x)


def apply_bilinear_J(a, b, v):
    """:J_a J_b:."""
    if a < 0:
        return apply_J(a, apply_J(b, v))
    else:
        return apply_J(a, apply_J(b, v))


def add_vec(v, w, scale=Q(1)):
    out = dict(v)
    for mono, c in w.items():
        out[mono] = out.get(mono, Q(0)) + scale * c
    return {m: c for m, c in out.items() if c != 0}


def L_minus(m, v, x):
    """Full L_{-m} = sum_n :K_{-m-n}T_n:  +  (1/2) sum_n :J_{-m-n}J_n:,
    acting on a level-homogeneous vector v."""
    assert m >= 1
    if not v:
        return {}
    Mp = level_of(next(iter(v)))
    lo = -(Mp + m)
    hi = Mp
    out = {}
    for n in range(lo, hi + 1):
        a = -m - n
        term_hl = apply_bilinear_hl(a, n, v, x)
        out = add_vec(out, term_hl)
        term_J = apply_bilinear_J(a, n, v)
        out = add_vec(out, term_J, scale=Q(1, 2))
    return {mm: c for mm, c in out.items() if c != 0}


VAC = {(): Q(1)}


def apply_monomial_to_vac(ops, x):
    v = VAC
    for kind, n in ops:
        if kind == 'K':
            v = apply_K(-n, v)
        elif kind == 'L':
            v = L_minus(n, v, x)
        else:
            raise ValueError(kind)
    return v


def three_colored_partitions(M):
    """Basis of level-M subspace: monomials in creation letters K,T,J of total
    weight M (order within a monomial irrelevant -- they commute up to the
    normal-ordering already baked into the vector representation)."""
    def rec(remaining, max_part):
        if remaining == 0:
            yield ()
            return
        for part in range(min(remaining, max_part), 0, -1):
            for color in ('K', 'T', 'J'):
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
    basis = three_colored_partitions(M)
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


if __name__ == '__main__':
    print("=" * 78)
    print("FULL P1 check (D=3, one transverse boson): do {L_{-m},K_{-n}} monomials")
    print("applied to |0;v_j> ALONE span F(v_j) at each level?")
    print("(Weaker than 'monomials on all of T_j span', hence any full-rank result")
    print(" here is unconditional positive evidence for P1 itself, not just a shadow.)")
    print("=" * 78)
    x_values = [Q(0), Q(1), Q(-1), Q(2), Q(1, 2), Q(-1, 3)]
    for M in range(0, 5):
        dim, ngens, results = test_level(M, x_values)
        all_full = all(r == dim for _, r in results)
        print(f"\nlevel M = {M}: dim F_{{D=3}},{M} = {dim}  (#generator monomials = {ngens})")
        for x, r in results:
            flag = "OK" if r == dim else "**RANK DEFICIENT**"
            print(f"    x = {str(x):>6}  rank = {r:3d} / {dim:3d}   {flag}")
        print(f"  ==> {'FULL RANK for all tested x' if all_full else 'FAILS for some x!'}")
    print()
    print("=" * 78)
