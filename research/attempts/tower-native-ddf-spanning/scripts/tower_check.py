"""tower_check.py -- exact rational machine checks for research/attempts/tower-native-ddf-spanning.

Model (claim.md 1.2):  F(p_j) = R[ u_A(-n) : A = 0..D-1, n >= 1 ]  with the basis
u_0 = a (written Lambda), u_1 = b (written K), u_{2+i} = eps_i (written E^i) of h = R^D, and

    [u_A(m), u_B(n)] = m G[A][B] delta_{m+n,0},      u_A(0)|_{F(p_j)} = (G[A][0] + j G[A][1]) id,

where G = Gram of (a,b,eps) under eta:  G[0][0]=2, G[0][1]=G[1][0]=1, G[1][1]=0, G[i][i]=1 (i>=2).
That is exactly the hypotheses (N) eta(b,b)=0, (S) eta(a,b)=1, (A) eta(a,a)=2,
(T) eta(eps,b)=0, (T') eta(eps,a)=0, (O) eta(eps_i,eps_j)=delta, (C) basis.

Sugawara:  L_m = 1/2 sum_k :alpha_{m-k} . alpha_k:,  alpha_p . alpha_q = sum_{A,B} Ginv[A][B] u_A(p) u_B(q).

Vertex / DDF (project definition, StringFormal.NoGhost.{vertexOsc, towerVertex, ddfOp}):
    E_-(z) = exp( sum_{m>=1} (nb).alpha_{-m}/m z^m ),   E_+(z) = exp( - sum_{l>=1} (nb).alpha_l/l z^{-l} )
    vertexOsc(nb)_M = [z^M] E_- E_+,   V^{(n)}_K = S_n o vertexOsc(nb)_{K-n},   A^eps_n = sum_i alpha^eps_i V^{(n)}_i.

Run:   python tower_check.py            (default suite, a couple of minutes)
       python tower_check.py --heavy    (adds the D=26 level-2 check)
"""

import sys
from fractions import Fraction as Q
from itertools import combinations_with_replacement

# ----------------------------------------------------------------- linear algebra


def make_G(D):
    G = [[Q(0)] * D for _ in range(D)]
    G[0][0] = Q(2)
    if D >= 2:
        G[0][1] = Q(1)
        G[1][0] = Q(1)
        G[1][1] = Q(0)
    for i in range(2, D):
        G[i][i] = Q(1)
    return G


def make_Ginv(D):
    # inverse of [[2,1],[1,0]] is [[0,1],[1,-2]]; identity on the transverse block
    Gi = [[Q(0)] * D for _ in range(D)]
    Gi[0][0] = Q(0)
    if D >= 2:
        Gi[0][1] = Q(1)
        Gi[1][0] = Q(1)
        Gi[1][1] = Q(-2)
    for i in range(2, D):
        Gi[i][i] = Q(1)
    return Gi


def rank(rows, ncols):
    """Exact rank of a list of dense Fraction rows."""
    rows = [list(r) for r in rows]
    piv_row = 0
    for c in range(ncols):
        p = None
        for r in range(piv_row, len(rows)):
            if rows[r][c] != 0:
                p = r
                break
        if p is None:
            continue
        rows[piv_row], rows[p] = rows[p], rows[piv_row]
        pv = rows[piv_row][c]
        for r in range(piv_row + 1, len(rows)):
            if rows[r][c] != 0:
                f = rows[r][c] / pv
                rr = rows[r]
                pr = rows[piv_row]
                for k in range(c, ncols):
                    if pr[k] != 0:
                        rr[k] -= f * pr[k]
        piv_row += 1
        if piv_row == len(rows):
            break
    return piv_row


def kernel_dim(rows, ncols):
    return ncols - rank(rows, ncols)


# ----------------------------------------------------------------- Fock model

# monomial: tuple of ((A, n), e) sorted, e > 0.   vector: dict monomial -> Fraction
ONE = ()


def mono_mul_var(mon, var):
    d = dict(mon)
    d[var] = d.get(var, 0) + 1
    return tuple(sorted(d.items()))


def mono_del_var(mon, var):
    d = dict(mon)
    e = d[var]
    if e == 1:
        del d[var]
    else:
        d[var] = e - 1
    return tuple(sorted(d.items())), e


def vadd(dst, src, c=Q(1)):
    for m, v in src.items():
        w = dst.get(m, Q(0)) + c * v
        if w == 0:
            dst.pop(m, None)
        else:
            dst[m] = w
    return dst


def vscale(v, c):
    if c == 0:
        return {}
    return {m: c * x for m, x in v.items()}


def vmul(v, w):
    """product in the polynomial ring"""
    out = {}
    for m1, c1 in v.items():
        for m2, c2 in w.items():
            d = dict(m1)
            for var, e in m2:
                d[var] = d.get(var, 0) + e
            m = tuple(sorted(d.items()))
            x = out.get(m, Q(0)) + c1 * c2
            if x == 0:
                out.pop(m, None)
            else:
                out[m] = x
    return out


def level(mon):
    return sum(n * e for (A, n), e in mon)


def maxmode(v):
    r = 0
    for m in v:
        for (A, n), e in m:
            r = max(r, n)
    return r


def maxlevel(v):
    return max((level(m) for m in v), default=0)


class Tower:
    def __init__(self, D):
        self.D = D
        self.G = make_G(D)
        self.Gi = make_Ginv(D)

    # ---- modes
    def mode(self, A, n, j, v):
        """u_A(n) acting on a vector living on rung j."""
        if not v:
            return {}
        if n < 0:
            var = (A, -n)
            out = {}
            for m, c in v.items():
                out[mono_mul_var(m, var)] = out.get(mono_mul_var(m, var), Q(0)) + c
            return {k: x for k, x in out.items() if x != 0}
        if n == 0:
            s = self.G[A][0] + Q(j) * self.G[A][1]
            return vscale(v, s)
        out = {}
        for m, c in v.items():
            for B in range(self.D):
                g = self.G[A][B]
                if g == 0:
                    continue
                var = (B, n)
                if dict(m).get(var, 0) == 0:
                    continue
                m2, e = mono_del_var(m, var)
                x = c * Q(e) * Q(n) * g
                out[m2] = out.get(m2, Q(0)) + x
        return {k: x for k, x in out.items() if x != 0}

    def contraction(self, p, q, j, v):
        """(alpha_p . alpha_q) v with the more negative index applied last (normal ordering)."""
        lo, hi = (p, q) if p <= q else (q, p)
        out = {}
        for B in range(self.D):
            # apply u_B(hi) first
            vb = self.mode(B, hi, j, v)
            if not vb:
                continue
            for A in range(self.D):
                g = self.Gi[A][B]
                if g == 0:
                    continue
                va = self.mode(A, lo, j, vb)
                if va:
                    vadd(out, va, g)
        return {k: x for k, x in out.items() if x != 0}

    def Lop(self, m, j, v):
        if not v:
            return {}
        KM = maxlevel(v) + abs(m) + 3
        out = {}
        for k in range(-KM, KM + 1):
            t = self.contraction(m - k, k, j, v)
            if t:
                vadd(out, t, Q(1, 2))
        return {k2: x for k2, x in out.items() if x != 0}

    # ---- vertex operator / DDF
    def creaExp(self, n, R):
        """Phi_0..Phi_R with sum_r Phi_r z^r = exp( n sum_{m>=1} K_{-m} z^m / m ), K_{-m} = var (1,m)."""
        Phi = [{ONE: Q(1)}]
        for r in range(1, R + 1):
            acc = {}
            for mm in range(1, r + 1):
                term = vmul({(((1, mm), 1),): Q(1)}, Phi[r - mm])
                vadd(acc, term, Q(n))
            Phi.append(vscale(acc, Q(1, r)))
        return Phi

    def annExp(self, n, j, v, Lmax):
        """Psi_0..Psi_Lmax applied to v: sum_L Psi_L z^{-L} = exp( - n sum_{l>=1} K_l z^{-l} / l )."""
        Psi = [v]
        for L in range(1, Lmax + 1):
            acc = {}
            for l in range(1, L + 1):
                t = self.mode(1, l, j, Psi[L - l])
                if t:
                    vadd(acc, t, Q(-n))
            Psi.append(vscale(acc, Q(1, L)))
        return Psi

    def vertexOsc(self, n, M, j, v):
        """[z^M] E_-E_+ for vertex momentum n*b, acting on rung j (no rung shift)."""
        if not v:
            return {}
        N = maxlevel(v)
        Psi = self.annExp(n, j, v, N)
        Rmax = M + N
        if Rmax < 0:
            return {}
        Phi = self.creaExp(n, max(Rmax, 0))
        out = {}
        for L in range(0, N + 1):
            if M + L < 0:
                continue
            t = vmul(Phi[M + L], Psi[L])
            if t:
                vadd(out, t)
        return {k: x for k, x in out.items() if x != 0}

    def ddf(self, i_eps, n, j, v):
        """A^{eps_i}_n on rung j; returns (j+n, vector).  eps index i_eps in 0..D-3."""
        A = 2 + i_eps
        N = maxlevel(v)
        MM = maxmode(v)
        out = {}
        for i in range(n - N - 1, MM + abs(n) + 3):
            w = self.vertexOsc(n, i - n, j, v)
            if not w:
                continue
            w = self.mode(A, i, j + n, w)
            if w:
                vadd(out, w)
        return j + n, {k: x for k, x in out.items() if x != 0}


# ----------------------------------------------------------------- bases


def monomials_of_level(D, N, types=None):
    """all monomials of level N in the variables (A,n), A in `types` (default all), n>=1."""
    if types is None:
        types = list(range(D))
    res = []

    def rec(rem, minvar, acc):
        if rem == 0:
            res.append(tuple(sorted(acc.items())))
            return
        for n in range(1, rem + 1):
            for A in types:
                var = (A, n)
                if var < minvar:
                    continue
                acc2 = dict(acc)
                acc2[var] = acc2.get(var, 0) + 1
                rec(rem - n, var, acc2)

    rec(N, (0, 0), {})
    # dedupe
    return sorted(set(res))


def partitions(N):
    if N == 0:
        yield ()
        return

    def rec(rem, mx):
        if rem == 0:
            yield ()
            return
        for p in range(min(rem, mx), 0, -1):
            for t in rec(rem - p, p):
                yield (p,) + t

    yield from rec(N, N)


def colored_partitions_count(N, colors):
    """p_colors(N) = # of partitions of N into parts with `colors` colors."""
    dp = [0] * (N + 1)
    dp[0] = 1
    for n in range(1, N + 1):
        for _ in range(colors):
            new = dp[:]
            for k in range(n, N + 1):
                new[k] += new[k - n]
            dp = new
    return dp[N]


def to_dense(v, index):
    row = [Q(0)] * len(index)
    for m, c in v.items():
        row[index[m]] = c
    return row


# ----------------------------------------------------------------- the checks


def lam_kap(mon):
    """(Lambda-degree, K-degree) of a monomial: type 0 = a, type 1 = b."""
    lam = sum(e for (A, n), e in mon if A == 0)
    kap = sum(e for (A, n), e in mon if A == 1)
    return lam, kap


def weight(mon, M):
    lam, kap = lam_kap(mon)
    return M * lam - kap


def check_leading_term(D, j, N, verbose=True):
    """Lemma 6 / (2.3), checked directly:

    for every monomial x of level N-m and every 1 <= m <= N,
        L_{-m} x  -  Lambda_{-m} * x
    consists only of monomials of weight <= w(x) + M - 1, where M = N+1.

    This is the statement that multiplication by Lambda_{-m} is the *unique*
    top-weight part of L_{-m}, with coefficient exactly 1.
    """
    T = Tower(D)
    M = N + 1
    worst = None
    for m in range(1, N + 1):
        for x in monomials_of_level(D, N - m):
            v = {x: Q(1)}
            lhs = T.Lop(-m, j, v)
            lead = {mono_mul_var(x, (0, m)): Q(1)}
            rest = dict(lhs)
            vadd(rest, lead, Q(-1))
            wx = weight(x, M)
            for mon in rest:
                dw = weight(mon, M) - wx
                worst = dw if worst is None else max(worst, dw)
                if dw > M - 1:
                    if verbose:
                        print("  [LEAD] FAIL D=%d j=%d N=%d m=%d x=%s dw=%d" % (D, j, N, m, x, dw))
                    return False
    if verbose:
        print("  [LEAD] D=%d j=%d N=%d: max excess weight of (L_{-m} - mult Lambda_{-m}) = %s"
              " (bound M-1 = %d) -> OK" % (D, j, N, worst, M - 1))
    return True


def check_Lm_on_W(D, j, N, verbose=True):
    """Lemma 7, checked directly: for w in W (no Lambda variables) and m >= 1,
        (i)  L_m w  lies in W  (no Lambda variables appear);
        (ii) L_m w - m * d/dK_{-m} w  is homogeneous of the *same* K-degree as w.
    """
    T = Tower(D)
    for m in range(1, N + 1):
        for x in monomials_of_level(D, N, types=list(range(1, D))):
            v = {x: Q(1)}
            lhs = T.Lop(m, j, v)
            # (i)
            for mon in lhs:
                if any(A == 0 for (A, n), e in mon):
                    if verbose:
                        print("  [LonW] FAIL (leaves W) D=%d j=%d N=%d m=%d x=%s" % (D, j, N, m, x))
                    return False
            # (ii) subtract m * d/dK_{-m}
            rest = dict(lhs)
            var = (1, m)
            if dict(x).get(var, 0) > 0:
                m2, e = mono_del_var(x, var)
                vadd(rest, {m2: Q(1)}, Q(-m) * Q(e))
            kx = lam_kap(x)[1]
            for mon in rest:
                if lam_kap(mon)[1] != kx:
                    if verbose:
                        print("  [LonW] FAIL (K-degree moved) D=%d j=%d N=%d m=%d x=%s -> %s"
                              % (D, j, N, m, x, mon))
                    return False
    if verbose:
        print("  [LonW] D=%d j=%d N=%d: L_m(W) in W and L_m - m d/dK_{-m} is K-degree "
              "preserving, all 1<=m<=N -> OK" % (D, j, N))
    return True


def check_ddf_on_W(D, j, N, nmax=3, verbose=True):
    """Lemma 9 / (4.3), checked directly: for w in W,
        A^eps_n w  ==  sum_{r>=0} eps(n+r) . Phi^{(n)}_r . w ,
    i.e. the annihilating half E_+ of the vertex operator acts as the identity on W.
    Also checks the congruence A^eps_n w = eps(n) w mod I (Lemma 10c).
    """
    if D < 3:
        return True
    T = Tower(D)
    for x in monomials_of_level(D, N, types=list(range(1, D))):
        v = {x: Q(1)}
        for n in range(-nmax, nmax + 1):
            jj, lhs = T.ddf(0, n, j, v)
            # right-hand side of (4.3)
            Rmax = N + abs(n) + 2
            Phi = T.creaExp(n, Rmax)
            rhs = {}
            for r in range(0, Rmax + 1):
                t = vmul(Phi[r], v)
                if not t:
                    continue
                t = T.mode(2, n + r, jj, t)
                if t:
                    vadd(rhs, t)
            rhs = {k: c for k, c in rhs.items() if c != 0}
            if lhs != rhs:
                if verbose:
                    print("  [DDFonW] FAIL D=%d j=%d N=%d n=%d x=%s" % (D, j, N, n, x))
                return False
            # congruence mod I: A^eps_n w - eps(n) w has K-degree > kappa(x)
            kx = lam_kap(x)[1]
            r0 = T.mode(2, n, jj, v)
            rest = dict(lhs)
            vadd(rest, r0, Q(-1))
            for mon in rest:
                if lam_kap(mon)[1] <= kx:
                    if verbose:
                        print("  [DDFonW] FAIL congruence D=%d j=%d N=%d n=%d x=%s -> %s"
                              % (D, j, N, n, x, mon))
                    return False
    if verbose:
        print("  [DDFonW] D=%d j=%d N=%d: A^eps_n|_W = sum_r E_{n+r} Phi_r and "
              "A^eps_n = E_n mod I, |n|<=%d -> OK" % (D, j, N, nmax))
    return True


def check_freeness(D, j, N, verbose=True):
    """Theorem 1: {L_{-m_1}...L_{-m_r} w} is a basis of F(p_j)_N."""
    T = Tower(D)
    basisF = monomials_of_level(D, N)
    index = {m: i for i, m in enumerate(basisF)}
    rows = []
    count = 0
    for pi in partitions_upto(N):
        ell = sum(pi)
        for w in monomials_of_level(D, N - ell, types=list(range(1, D))):
            v = {w: Q(1)}
            for m in reversed(sorted(pi)):  # apply smallest first, build L_{-m1}...L_{-mr}
                v = T.Lop(-m, j, v)
            rows.append(to_dense(v, index))
            count += 1
    r = rank(rows, len(basisF))
    ok = (r == len(basisF)) and (count == len(basisF))
    if verbose:
        print(f"  [T1] D={D} j={j} N={N}: dim F={len(basisF)} #generators={count} rank={r} -> {'OK' if ok else 'FAIL'}")
    return ok


def partitions_upto(N):
    for ell in range(0, N + 1):
        for pi in partitions(ell):
            yield pi


def W_basis(D, N):
    return monomials_of_level(D, N, types=list(range(1, D)))


def transverse_dim(D, j, N, verbose=True):
    """dim of T_j at level N  =  dim ( W_j(N) cap ker L_{m>0} )."""
    T = Tower(D)
    Wb = W_basis(D, N)
    if not Wb:
        return 0
    rows = []  # constraints: for each L_m, the image coordinates
    cols = len(Wb)
    constraint_rows = []
    for m in range(1, N + 1):
        tgt = monomials_of_level(D, N - m)
        idx = {mo: i for i, mo in enumerate(tgt)}
        img = []
        for w in Wb:
            img.append(to_dense(T.Lop(m, j, {w: Q(1)}), idx))
        # img is cols x len(tgt); constraints are its columns
        for t in range(len(tgt)):
            constraint_rows.append([img[c][t] for c in range(cols)])
    d = kernel_dim(constraint_rows, cols) if constraint_rows else cols
    if verbose:
        print(f"  [T2] D={D} j={j} N={N}: dim W={cols} dim T={d}")
    return d


def ddf_states(D, N, verbose=True):
    """the DDF monomials of total level N applied to |0;a> (rung 0 -> rung -N)."""
    T = Tower(D)
    ncol = D - 2
    out = []
    # multisets of (i, n) with sum n = N
    gens = [(i, n) for n in range(1, N + 1) for i in range(ncol)]

    def rec(rem, start, acc):
        if rem == 0:
            out.append(tuple(acc))
            return
        for gi in range(start, len(gens)):
            i, n = gens[gi]
            if n <= rem:
                rec(rem - n, gi, acc + [(i, n)])

    rec(N, 0, [])
    vecs = []
    for word in out:
        j, v = 0, {ONE: Q(1)}
        for (i, n) in word:
            j, v = T.ddf(i, -n, j, v)
        assert j == -N
        vecs.append(v)
    return vecs


def check_ddf_equals_transverse(D, N, verbose=True):
    """Theorem 2 at rung -N, level N."""
    T = Tower(D)
    vecs = ddf_states(D, N, verbose=False)
    basisF = monomials_of_level(D, N)
    index = {m: i for i, m in enumerate(basisF)}
    rows = [to_dense(v, index) for v in vecs]
    rD = rank(rows, len(basisF))
    dT = transverse_dim(D, -N, N, verbose=False)
    pc = colored_partitions_count(N, D - 2)
    # DDF states are in W?  (K_m kills them)
    inW = True
    for v in vecs:
        for m in range(1, N + 1):
            if T.mode(1, m, -N, v):
                inW = False
    ok = (rD == pc == dT) and inW and (len(vecs) == pc)
    if verbose:
        print(f"  [T3] D={D} N={N}: #DDF={len(vecs)} rank D(E)={rD} dim T^1={dT} p_(D-2)(N)={pc} "
              f"DDF in W: {inW} -> {'OK' if ok else 'FAIL'}")
    return ok


def check_c26_null(D, verbose=True):
    """Lemma: (L_{-2}+3/2 L_{-1}^2)|0;a-2b> is physical iff D=26.  L_2 of it = (D/2-13)|chi>."""
    T = Tower(D)
    j = -2
    chi = {ONE: Q(1)}  # rung -2, level 0, L_0 = (1+j)+0 = -1
    psi = T.Lop(-2, j, chi)
    tmp = T.Lop(-1, j, T.Lop(-1, j, chi))
    vadd(psi, tmp, Q(3, 2))
    a1 = T.Lop(1, j, psi)
    a2 = T.Lop(2, j, psi)
    c1 = (a1 == {})
    expected = Q(D, 2) - 13
    c2 = a2.get(ONE, Q(0)) == expected and set(a2.keys()) <= {ONE}
    if verbose:
        print(f"  [C26] D={D}: L_1 g2.chi = 0 ? {c1};  L_2 g2.chi = ({expected}) chi ? {c2}")
    return c1 and c2


def physical_dim(D, j, N):
    T = Tower(D)
    basisF = monomials_of_level(D, N)
    cols = len(basisF)
    rows = []
    for m in range(1, N + 1):
        tgt = monomials_of_level(D, N - m)
        idx = {mo: i for i, mo in enumerate(tgt)}
        img = [to_dense(T.Lop(m, j, {w: Q(1)}), idx) for w in basisF]
        for t in range(len(tgt)):
            rows.append([img[c][t] for c in range(cols)])
    return (kernel_dim(rows, cols) if rows else cols), basisF


def spurious_rows(D, j, N):
    """spanning set of S_j at level N: L_{-m} (level N-m)."""
    T = Tower(D)
    basisF = monomials_of_level(D, N)
    index = {m: i for i, m in enumerate(basisF)}
    rows = []
    for m in range(1, N + 1):
        for w in monomials_of_level(D, N - m):
            rows.append(to_dense(T.Lop(-m, j, {w: Q(1)}), index))
    return rows, basisF, index


def check_main(D, N, verbose=True):
    """Theorem 3 on the slice (rung -N, level N):  dim P^1 = dim T^1 + dim N^1 ?"""
    T = Tower(D)
    j = -N
    dP, basisF = physical_dim(D, j, N)
    index = {m: i for i, m in enumerate(basisF)}
    srows, _, _ = spurious_rows(D, j, N)
    dS = rank(srows, len(basisF))
    dT = transverse_dim(D, j, N, verbose=False)
    # dim N^1 = dim (P cap S) = dim P + dim S - dim (P + S);  P + S: need vectors of P.
    # easier: dim S = dim F - dim W (Cor 1.1) and dim(P cap S) = dim P - dim T  iff P = T + (P cap S).
    dF = len(basisF)
    dW = len(W_basis(D, N))
    ok_cor11 = (dS == dF - dW)
    # compute dim (P cap S) honestly: P cap S = S cap ker L_{m>0}
    rowsS = srows
    # basis of S
    Sb = row_basis(rowsS, dF)
    # constraints L_m on S
    cons = []
    for m in range(1, N + 1):
        tgt = monomials_of_level(D, N - m)
        idx = {mo: i for i, mo in enumerate(tgt)}
        img = []
        for r in Sb:
            v = {basisF[i]: r[i] for i in range(dF) if r[i] != 0}
            img.append(to_dense(T.Lop(m, j, v), idx))
        for t in range(len(tgt)):
            cons.append([img[c][t] for c in range(len(Sb))])
    dN = kernel_dim(cons, len(Sb)) if cons else len(Sb)
    ok = (dP == dT + dN)
    if verbose:
        print(f"  [MAIN] D={D} N={N}: dim F={dF} dim P^1={dP} dim T^1={dT} dim N^1={dN} "
              f"T+N={dT+dN} {'==' if ok else '!='} P  | Cor1.1 (dim S = dim F - dim W): {ok_cor11}")
    return ok


def row_basis(rows, ncols):
    """return a list of independent rows spanning the same space (echelon form rows)."""
    rows = [list(r) for r in rows]
    out = []
    piv = []
    for r in rows:
        r = r[:]
        for (pc, pr) in zip(piv, out):
            if r[pc] != 0:
                f = r[pc] / pr[pc]
                for k in range(pc, ncols):
                    if pr[k] != 0:
                        r[k] -= f * pr[k]
        c = next((k for k in range(ncols) if r[k] != 0), None)
        if c is not None:
            out.append(r)
            piv.append(c)
    return out


def main():
    heavy = "--heavy" in sys.argv
    print("== Lemma 6 / (2.3): mult by Lambda_{-m} is the unique top-weight part of L_{-m}")
    for D in (2, 3, 4, 5):
        for j in (0, -1, -2, 1):
            for N in range(1, 5 if D <= 4 else 4):
                assert check_leading_term(D, j, N)
    print("== Lemma 7: L_m(W) subset W, and L_m - m d/dK_{-m} preserves the K-degree")
    for D in (2, 3, 4, 5, 6):
        for j in (0, -1, -3):
            for N in range(1, 5):
                assert check_Lm_on_W(D, j, N)
    print("== Lemma 9/10c: A^eps_n|_W = sum_r E_{n+r} Phi_r, and = E_n mod I")
    for D in (3, 4, 5):
        for j in (0, -1, -2):
            for N in range(0, 4):
                assert check_ddf_on_W(D, j, N)
    print("== Theorem 1 (freeness of F(p_j) over U(Vir_{<0}) with generators W_j)")
    for D in (2, 3, 4, 5):
        for j in (0, -1, -2, 1):
            for N in range(0, 5 if D <= 4 else 4):
                assert check_freeness(D, j, N)
    print("== Theorem 2 (T^1 = D(E), dim = p_{D-2}(N))")
    for D in (2, 3, 4, 5, 6):
        for N in range(0, 5 if D <= 4 else 4):
            assert check_ddf_equals_transverse(D, N)
    print("== c=26 lemma  (L_{-2} + 3/2 L_{-1}^2) on a weight -1 physical vector")
    for D in (3, 10, 25, 26, 27):
        r = check_c26_null(D)
        assert r
    print("== Theorem 3 on the antidiagonal slice (expect equality iff D = 26)")
    for N in (1, 2):
        for D in (3, 4, 5, 6, 24, 25, 26, 27):
            if N >= 2 and D >= 24 and not heavy:
                continue
            check_main(D, N)
    for D in (3, 4, 5):
        check_main(D, 3)
    print("done")


if __name__ == "__main__":
    main()
