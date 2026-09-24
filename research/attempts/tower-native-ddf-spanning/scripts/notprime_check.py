"""notprime_check.py -- exact rational machine checks for proof-no-tprime.md.

Independent re-implementation (NOT an import of tower_check.py) of the tower Fock model
with the transversality-to-`a` condition (T') eta(eps_i, a) = 0 **dropped**.

Setting (claim-no-tprime.md 1):  h = R^D with basis (a, b, eps_1, .., eps_{D-2}) and Gram

        [ eta(a,a)  1   c^T ]        c_i := eta(eps_i, a)   (arbitrary)
  G =   [    1      0    0  ]        (N) eta(b,b)=0, (S) eta(a,b)=1,
        [    c      0    I  ]        (T) eta(eps_i,b)=0, (O) eta(eps_i,eps_j)=delta

(A) eta(a,a) = 2 unless overridden.  (T') is the special case c = 0.

Index convention in the code: A = 0 <-> a (Lambda), A = 1 <-> b (K), A = 2+i <-> eps_i (E^i).

Checks
  [DUAL]   G^{-1} as written in proof-no-tprime.md Lemma 1' is really the inverse.
  [AB0]    A^b_n = 0 for n != 0   (Lemma B, the heart of the no-(T') proof)
  [SHIFT]  A^{eps_i}_n = A^{eps_i - c_i b}_n for n != 0   (Corollary B.1)
  [FRAME]  the shifted frame eps'_i := eps_i - c_i b satisfies (N)(S)(A)(T)(T')(O)
  [LEAD]   Lemma 6': mult by Lambda_{-m} is still the unique top-weight part of L_{-m}
  [LonW]   Lemma 7': L_m(W) in W, and L_m - m d/dK_{-m} never *lowers* the K-degree
  [DDFonW] Lemma 9'/10'(c): A^eps_n|_W = sum_r E_{n+r} Phi_r, and = E_n mod I
  [T1]     Theorem 1' (freeness) with c != 0
  [T2]     Theorem 2' (T^1 = D(E), rank p_{D-2}(N)) with c != 0
  [MAIN]   Theorem 3' on the antidiagonal slice, with c != 0 (equality iff D = 26)

Run:  python notprime_check.py            (default suite)
      python notprime_check.py --heavy    (adds D = 24..27 at level 2)
"""

import sys
from fractions import Fraction as Q

ONE = ()

# ----------------------------------------------------------------- Gram data


def make_G(D, c, aa=Q(2)):
    """Gram of (a, b, eps_1..eps_{D-2}) in the order A = 0,1,2,...,D-1."""
    assert len(c) == D - 2
    G = [[Q(0)] * D for _ in range(D)]
    G[0][0] = Q(aa)
    if D >= 2:
        G[0][1] = G[1][0] = Q(1)
        G[1][1] = Q(0)
    for i in range(D - 2):
        G[0][2 + i] = G[2 + i][0] = Q(c[i])
        G[2 + i][2 + i] = Q(1)
    return G


def make_Ginv(D, c, aa=Q(2)):
    """Inverse Gram, i.e. the coefficients of the dual basis:
         a*     = b
         b*     = a - (eta(a,a) - |c|^2) b - sum_i c_i eps_i
         eps_i* = eps_i - c_i b
    (proof-no-tprime.md Lemma 1')."""
    cc = sum(Q(x) * Q(x) for x in c) if c else Q(0)
    Ahat = Q(aa) - cc
    Gi = [[Q(0)] * D for _ in range(D)]
    Gi[0][1] = Gi[1][0] = Q(1)          # a* = b ; b* has coefficient 1 on a
    Gi[1][1] = -Ahat
    for i in range(D - 2):
        Gi[1][2 + i] = Gi[2 + i][1] = -Q(c[i])
        Gi[2 + i][2 + i] = Q(1)
    return Gi


def matmul(X, Y):
    n = len(X)
    return [[sum(X[i][k] * Y[k][j] for k in range(n)) for j in range(n)] for i in range(n)]


def is_identity(M):
    n = len(M)
    return all(M[i][j] == (1 if i == j else 0) for i in range(n) for j in range(n))


# ----------------------------------------------------------------- linear algebra


def rank(rows, ncols):
    rows = [list(r) for r in rows]
    piv_row = 0
    for col in range(ncols):
        p = None
        for r in range(piv_row, len(rows)):
            if rows[r][col] != 0:
                p = r
                break
        if p is None:
            continue
        rows[piv_row], rows[p] = rows[p], rows[piv_row]
        pv = rows[piv_row][col]
        for r in range(piv_row + 1, len(rows)):
            if rows[r][col] != 0:
                f = rows[r][col] / pv
                rr, pr = rows[r], rows[piv_row]
                for k in range(col, ncols):
                    if pr[k] != 0:
                        rr[k] -= f * pr[k]
        piv_row += 1
        if piv_row == len(rows):
            break
    return piv_row


def kernel_dim(rows, ncols):
    return ncols - rank(rows, ncols)


def row_basis(rows, ncols):
    out, piv = [], []
    for r in rows:
        r = list(r)
        for (pc, pr) in zip(piv, out):
            if r[pc] != 0:
                f = r[pc] / pr[pc]
                for k in range(pc, ncols):
                    if pr[k] != 0:
                        r[k] -= f * pr[k]
        col = next((k for k in range(ncols) if r[k] != 0), None)
        if col is not None:
            out.append(r)
            piv.append(col)
    return out


# ----------------------------------------------------------------- Fock model

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


def vadd(dst, src, coef=Q(1)):
    for m, v in src.items():
        w = dst.get(m, Q(0)) + coef * v
        if w == 0:
            dst.pop(m, None)
        else:
            dst[m] = w
    return dst


def vscale(v, coef):
    if coef == 0:
        return {}
    return {m: coef * x for m, x in v.items()}


def vmul(v, w):
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


def lam_kap(mon):
    """(Lambda-degree, K-degree); A = 0 is a, A = 1 is b."""
    lam = sum(e for (A, n), e in mon if A == 0)
    kap = sum(e for (A, n), e in mon if A == 1)
    return lam, kap


def weight(mon, M):
    lam, kap = lam_kap(mon)
    return M * lam - kap


class Tower:
    """F(p_j) = R[u_A(-n)], p_j = a + j b, with Gram G (no (T') assumed)."""

    def __init__(self, D, c, aa=Q(2)):
        self.D = D
        self.c = [Q(x) for x in c]
        self.G = make_G(D, c, aa)
        self.Gi = make_Ginv(D, c, aa)

    # ---- single modes u_A(n)
    def mode(self, A, n, j, v):
        if not v:
            return {}
        if n < 0:
            var = (A, -n)
            out = {}
            for m, coef in v.items():
                mm = mono_mul_var(m, var)
                out[mm] = out.get(mm, Q(0)) + coef
            return {k: x for k, x in out.items() if x != 0}
        if n == 0:
            return vscale(v, self.G[A][0] + Q(j) * self.G[A][1])
        out = {}
        for m, coef in v.items():
            for B in range(self.D):
                g = self.G[A][B]
                if g == 0:
                    continue
                var = (B, n)
                if dict(m).get(var, 0) == 0:
                    continue
                m2, e = mono_del_var(m, var)
                out[m2] = out.get(m2, Q(0)) + coef * Q(e) * Q(n) * g
        return {k: x for k, x in out.items() if x != 0}

    def polmode(self, pol, n, j, v):
        """(sum_A pol[A] u_A)(n) applied to v."""
        out = {}
        for A, coef in enumerate(pol):
            if coef == 0:
                continue
            t = self.mode(A, n, j, v)
            if t:
                vadd(out, t, Q(coef))
        return {k: x for k, x in out.items() if x != 0}

    # ---- Sugawara
    def contraction(self, p, q, j, v):
        lo, hi = (p, q) if p <= q else (q, p)
        out = {}
        for B in range(self.D):
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

    # ---- vertex / DDF (momentum n*b always; only the polarization varies)
    def creaExp(self, n, Rmax):
        """Phi_0..Phi_Rmax,  sum_r Phi_r z^r = exp( n sum_{m>=1} K_{-m} z^m / m )."""
        Phi = [{ONE: Q(1)}]
        for r in range(1, Rmax + 1):
            acc = {}
            for mm in range(1, r + 1):
                vadd(acc, vmul({(((1, mm), 1),): Q(1)}, Phi[r - mm]), Q(n))
            Phi.append(vscale(acc, Q(1, r)))
        return Phi

    def annExp(self, n, j, v, Lmax):
        """Psi_0..Psi_Lmax applied to v, sum_L Psi_L z^{-L} = exp(- n sum_{l>=1} K_l z^{-l}/l)."""
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
        if not v:
            return {}
        N = maxlevel(v)
        Psi = self.annExp(n, j, v, N)
        out = {}
        Rmax = M + N
        if Rmax < 0:
            return {}
        Phi = self.creaExp(n, max(Rmax, 0))
        for L in range(0, N + 1):
            if M + L < 0:
                continue
            t = vmul(Phi[M + L], Psi[L])
            if t:
                vadd(out, t)
        return {k: x for k, x in out.items() if x != 0}

    def ddf_pol(self, pol, n, j, v, pad=3):
        """A^{pol}_n on rung j.  Returns (j+n, vector).  `pol` in the (a,b,eps) basis.

        Requires eta(pol, b) = 0 for the upper cut-off to exist."""
        assert sum(Q(pol[A]) * self.G[A][1] for A in range(self.D)) == 0, \
            "polarisation not transverse to b"
        N = maxlevel(v)
        MM = maxmode(v)
        out = {}
        for i in range(n - N - 1, MM + abs(n) + pad):
            w = self.vertexOsc(n, i - n, j, v)
            if not w:
                continue
            w = self.polmode(pol, i, j + n, w)
            if w:
                vadd(out, w)
        return j + n, {k: x for k, x in out.items() if x != 0}

    def ddf(self, i_eps, n, j, v):
        pol = [Q(0)] * self.D
        pol[2 + i_eps] = Q(1)
        return self.ddf_pol(pol, n, j, v)


# ----------------------------------------------------------------- bases


def monomials_of_level(D, N, types=None):
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


def partitions_upto(N):
    for ell in range(0, N + 1):
        for pi in partitions(ell):
            yield pi


def colored_partitions_count(N, colors):
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
    for m, coef in v.items():
        row[index[m]] = coef
    return row


def W_basis(D, N):
    return monomials_of_level(D, N, types=list(range(1, D)))


# ----------------------------------------------------------------- checks


def check_dual(D, c, aa=Q(2), verbose=True):
    G, Gi = make_G(D, c, aa), make_Ginv(D, c, aa)
    ok = is_identity(matmul(Gi, G)) and is_identity(matmul(G, Gi))
    if verbose:
        print(f"  [DUAL] D={D} c={c} eta(a,a)={aa}: G^-1 G = G G^-1 = I ? {ok}")
    return ok


def check_frame_shift(D, c, aa=Q(2), verbose=True):
    """eps'_i := eps_i - c_i b satisfies (T),(T'),(O); a, b untouched."""
    G = make_G(D, c, aa)

    def eta(u, v):
        return sum(Q(u[A]) * G[A][B] * Q(v[B]) for A in range(D) for B in range(D))

    a = [Q(1)] + [Q(0)] * (D - 1)
    b = [Q(0), Q(1)] + [Q(0)] * (D - 2)
    eps = []
    for i in range(D - 2):
        e = [Q(0)] * D
        e[2 + i] = Q(1)
        e[1] = -Q(c[i])
        eps.append(e)
    ok = eta(b, b) == 0 and eta(a, b) == 1 and eta(a, a) == aa
    for i in range(D - 2):
        ok = ok and eta(eps[i], b) == 0 and eta(eps[i], a) == 0
        for k in range(D - 2):
            ok = ok and eta(eps[i], eps[k]) == (1 if i == k else 0)
    if verbose:
        print(f"  [FRAME] D={D} c={c}: shifted frame satisfies (N)(S)(A)(T)(T')(O) ? {ok}")
    return ok


def check_Ab_zero(D, c, j, N, nmax=4, verbose=True):
    """Lemma B:  A^b_n = 0 on F(p_j)_N for every n != 0 ; and A^b_0 = id."""
    T = Tower(D, c)
    pol = [Q(0)] * D
    pol[1] = Q(1)                                  # polarisation = b
    bad = None
    for x in monomials_of_level(D, N):
        v = {x: Q(1)}
        for n in range(-nmax, nmax + 1):
            _, w = T.ddf_pol(pol, n, j, v)
            if n == 0:
                if w != v:
                    bad = (x, n, "A^b_0 != id")
            elif w:
                bad = (x, n, w)
            if bad:
                break
        if bad:
            break
    if verbose:
        if bad:
            print(f"  [AB0] FAIL D={D} c={c} j={j} N={N}: {bad}")
        else:
            print(f"  [AB0] D={D} c={c} j={j} N={N}: A^b_n = 0 for 0<|n|<={nmax}, "
                  f"A^b_0 = id -> OK")
    return bad is None


def check_ddf_shift(D, c, j, N, nmax=3, verbose=True):
    """Corollary B.1:  A^{eps_i}_n = A^{eps_i - c_i b}_n for n != 0."""
    T = Tower(D, c)
    for i in range(D - 2):
        pol0 = [Q(0)] * D
        pol0[2 + i] = Q(1)
        pol1 = list(pol0)
        pol1[1] = -Q(c[i])
        for x in monomials_of_level(D, N):
            v = {x: Q(1)}
            for n in range(-nmax, nmax + 1):
                if n == 0:
                    continue
                _, w0 = T.ddf_pol(pol0, n, j, v)
                _, w1 = T.ddf_pol(pol1, n, j, v)
                if w0 != w1:
                    if verbose:
                        print(f"  [SHIFT] FAIL D={D} c={c} j={j} N={N} i={i} n={n} x={x}")
                    return False
    if verbose:
        print(f"  [SHIFT] D={D} c={c} j={j} N={N}: A^eps_n = A^(eps-c b)_n for "
              f"0<|n|<={nmax} -> OK")
    return True


def check_leading_term(D, c, j, N, verbose=True):
    """Lemma 6':  L_{-m} = (mult by Lambda_{-m}) + terms of weight excess <= M-1."""
    T = Tower(D, c)
    M = N + 1
    worst = None
    for m in range(1, N + 1):
        for x in monomials_of_level(D, N - m):
            v = {x: Q(1)}
            lhs = T.Lop(-m, j, v)
            rest = dict(lhs)
            vadd(rest, {mono_mul_var(x, (0, m)): Q(1)}, Q(-1))
            wx = weight(x, M)
            for mon in rest:
                dw = weight(mon, M) - wx
                worst = dw if worst is None else max(worst, dw)
                if dw > M - 1:
                    if verbose:
                        print(f"  [LEAD] FAIL D={D} c={c} j={j} N={N} m={m} x={x} dw={dw}")
                    return False
    if verbose:
        print(f"  [LEAD] D={D} c={c} j={j} N={N}: max excess = {worst} "
              f"(bound M-1 = {M-1}) -> OK")
    return True


def check_Lm_on_W(D, c, j, N, verbose=True):
    """Lemma 7':  L_m(W) in W, and R_m := L_m - m d/dK_{-m} never LOWERS the K-degree.

    Also reports whether R_m actually raises kappa somewhere (it does iff c != 0),
    which is exactly the difference from the (T') version."""
    T = Tower(D, c)
    raised = False
    for m in range(1, N + 1):
        for x in monomials_of_level(D, N, types=list(range(1, D))):
            v = {x: Q(1)}
            lhs = T.Lop(m, j, v)
            for mon in lhs:
                if any(A == 0 for (A, n), e in mon):
                    if verbose:
                        print(f"  [LonW] FAIL leaves W: D={D} c={c} j={j} N={N} m={m} x={x}")
                    return False
            rest = dict(lhs)
            var = (1, m)
            if dict(x).get(var, 0) > 0:
                m2, e = mono_del_var(x, var)
                vadd(rest, {m2: Q(1)}, Q(-m) * Q(e))
            kx = lam_kap(x)[1]
            for mon in rest:
                km = lam_kap(mon)[1]
                if km < kx:
                    if verbose:
                        print(f"  [LonW] FAIL R_m lowers kappa: D={D} c={c} j={j} N={N} "
                              f"m={m} x={x} -> {mon}")
                    return False
                if km > kx:
                    raised = True
    if verbose:
        print(f"  [LonW] D={D} c={c} j={j} N={N}: L_m(W) in W, R_m does not lower kappa "
              f"(raises somewhere: {raised}) -> OK")
    return True


def check_ddf_on_W(D, c, j, N, nmax=3, verbose=True):
    """Lemma 9'/10'(c) with c != 0."""
    if D < 3:
        return True
    T = Tower(D, c)
    for x in monomials_of_level(D, N, types=list(range(1, D))):
        v = {x: Q(1)}
        for n in range(-nmax, nmax + 1):
            jj, lhs = T.ddf(0, n, j, v)
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
            rhs = {k: co for k, co in rhs.items() if co != 0}
            if lhs != rhs:
                if verbose:
                    print(f"  [DDFonW] FAIL (4.3') D={D} c={c} j={j} N={N} n={n} x={x}")
                return False
            kx = lam_kap(x)[1]
            rest = dict(lhs)
            vadd(rest, T.mode(2, n, jj, v), Q(-1))
            for mon in rest:
                if lam_kap(mon)[1] <= kx:
                    if verbose:
                        print(f"  [DDFonW] FAIL congruence D={D} c={c} j={j} N={N} n={n} "
                              f"x={x} -> {mon}")
                    return False
    if verbose:
        print(f"  [DDFonW] D={D} c={c} j={j} N={N}: A^eps_n|_W = sum_r E_(n+r) Phi_r and "
              f"= E_n mod I, |n|<={nmax} -> OK")
    return True


def check_freeness(D, c, j, N, verbose=True):
    T = Tower(D, c)
    basisF = monomials_of_level(D, N)
    index = {m: i for i, m in enumerate(basisF)}
    rows, count = [], 0
    for pi in partitions_upto(N):
        ell = sum(pi)
        for w in monomials_of_level(D, N - ell, types=list(range(1, D))):
            v = {w: Q(1)}
            for m in reversed(sorted(pi)):
                v = T.Lop(-m, j, v)
            rows.append(to_dense(v, index))
            count += 1
    r = rank(rows, len(basisF))
    ok = (r == len(basisF)) and (count == len(basisF))
    if verbose:
        print(f"  [T1] D={D} c={c} j={j} N={N}: dim F={len(basisF)} #gen={count} rank={r} "
              f"-> {'OK' if ok else 'FAIL'}")
    return ok


def transverse_dim(D, c, j, N):
    T = Tower(D, c)
    Wb = W_basis(D, N)
    if not Wb:
        return 0
    cols = len(Wb)
    cons = []
    for m in range(1, N + 1):
        tgt = monomials_of_level(D, N - m)
        idx = {mo: i for i, mo in enumerate(tgt)}
        img = [to_dense(T.Lop(m, j, {w: Q(1)}), idx) for w in Wb]
        for t in range(len(tgt)):
            cons.append([img[k][t] for k in range(cols)])
    return kernel_dim(cons, cols) if cons else cols


def ddf_states(D, c, N):
    T = Tower(D, c)
    ncol = D - 2
    words = []
    gens = [(i, n) for n in range(1, N + 1) for i in range(ncol)]

    def rec(rem, start, acc):
        if rem == 0:
            words.append(tuple(acc))
            return
        for gi in range(start, len(gens)):
            i, n = gens[gi]
            if n <= rem:
                rec(rem - n, gi, acc + [(i, n)])

    rec(N, 0, [])
    vecs = []
    for word in words:
        j, v = 0, {ONE: Q(1)}
        for (i, n) in word:
            j, v = T.ddf(i, -n, j, v)
        assert j == -N
        vecs.append(v)
    return vecs


def check_ddf_equals_transverse(D, c, N, verbose=True):
    T = Tower(D, c)
    vecs = ddf_states(D, c, N)
    basisF = monomials_of_level(D, N)
    index = {m: i for i, m in enumerate(basisF)}
    rD = rank([to_dense(v, index) for v in vecs], len(basisF))
    dT = transverse_dim(D, c, -N, N)
    pc = colored_partitions_count(N, D - 2)
    inW = all(not T.mode(1, m, -N, v) for v in vecs for m in range(1, N + 1))
    ok = (rD == pc == dT) and inW and (len(vecs) == pc)
    if verbose:
        print(f"  [T2] D={D} c={c} N={N}: #DDF={len(vecs)} rank D(E)={rD} dim T^1={dT} "
              f"p_(D-2)(N)={pc} DDF in W: {inW} -> {'OK' if ok else 'FAIL'}")
    return ok


def physical_dim(D, c, j, N):
    T = Tower(D, c)
    basisF = monomials_of_level(D, N)
    cols = len(basisF)
    rows = []
    for m in range(1, N + 1):
        tgt = monomials_of_level(D, N - m)
        idx = {mo: i for i, mo in enumerate(tgt)}
        img = [to_dense(T.Lop(m, j, {w: Q(1)}), idx) for w in basisF]
        for t in range(len(tgt)):
            rows.append([img[k][t] for k in range(cols)])
    return (kernel_dim(rows, cols) if rows else cols), basisF


def check_main(D, c, N, verbose=True):
    T = Tower(D, c)
    j = -N
    dP, basisF = physical_dim(D, c, j, N)
    index = {m: i for i, m in enumerate(basisF)}
    dF = len(basisF)
    srows = []
    for m in range(1, N + 1):
        for w in monomials_of_level(D, N - m):
            srows.append(to_dense(T.Lop(-m, j, {w: Q(1)}), index))
    dS = rank(srows, dF)
    dW = len(W_basis(D, N))
    ok_cor11 = (dS == dF - dW)
    dT = transverse_dim(D, c, j, N)
    Sb = row_basis(srows, dF)
    cons = []
    for m in range(1, N + 1):
        tgt = monomials_of_level(D, N - m)
        idx = {mo: i for i, mo in enumerate(tgt)}
        img = []
        for r in Sb:
            v = {basisF[i]: r[i] for i in range(dF) if r[i] != 0}
            img.append(to_dense(T.Lop(m, j, v), idx))
        for t in range(len(tgt)):
            cons.append([img[k][t] for k in range(len(Sb))])
    dN = kernel_dim(cons, len(Sb)) if cons else len(Sb)
    ok = (dP == dT + dN)
    if verbose:
        print(f"  [MAIN] D={D} c={c} N={N}: dim F={dF} dim P^1={dP} dim T^1={dT} "
              f"dim N^1={dN} T+N={dT+dN} {'==' if ok else '!='} P | Cor1.1: {ok_cor11}")
    return ok


# ----------------------------------------------------------------- driver

# a few (D, c) configurations with c != 0; the first is the explicit
# D = 6 configuration used in the target card's frame discussion.
CONFIGS = [
    (6, (Q(1), Q(0), Q(0), Q(0))),
    (4, (Q(1), Q(0))),
    (4, (Q(1), Q(-2))),
    (5, (Q(1, 2), Q(3), Q(0))),
    (3, (Q(7, 3),)),
]


def main():
    heavy = "--heavy" in sys.argv
    print("== [DUAL] the dual basis of Lemma 1' (no (T'))")
    for D, c in CONFIGS:
        assert check_dual(D, c)
    assert check_dual(4, (Q(1), Q(-2)), aa=Q(5))

    print("== [FRAME] eps'_i = eps_i - c_i b restores (T')")
    for D, c in CONFIGS:
        assert check_frame_shift(D, c)

    print("== [AB0] Lemma B: A^b_n = 0 for n != 0  (the heart of the no-(T') proof)")
    for D, c in CONFIGS:
        for j in (0, -1, -2, 1):
            for N in range(0, 3):
                assert check_Ab_zero(D, c, j, N)
    # the (T') case too: A^b_n = 0 does not need c != 0
    assert check_Ab_zero(4, (Q(0), Q(0)), -1, 2)

    print("== [SHIFT] A^eps_n = A^(eps - c b)_n for n != 0")
    for D, c in CONFIGS[:4]:
        for j in (0, -1, 1):
            for N in range(0, 3):
                assert check_ddf_shift(D, c, j, N)

    print("== [LEAD] Lemma 6' with c != 0")
    for D, c in CONFIGS:
        for j in (0, -1, -2, 1):
            for N in range(1, 4):
                assert check_leading_term(D, c, j, N)

    print("== [LonW] Lemma 7' with c != 0 (R_m does not LOWER kappa)")
    for D, c in CONFIGS:
        for j in (0, -1, -3):
            for N in range(1, 4):
                assert check_Lm_on_W(D, c, j, N)

    print("== [DDFonW] Lemma 9'/10'(c) with c != 0")
    for D, c in CONFIGS:
        if D < 3:
            continue
        for j in (0, -1, -2):
            for N in range(0, 3):
                assert check_ddf_on_W(D, c, j, N)

    print("== [T1] Theorem 1' (freeness) with c != 0")
    for D, c in CONFIGS:
        for j in (0, -1, 1):
            for N in range(0, 4):
                assert check_freeness(D, c, j, N)

    print("== [T2] Theorem 2' (T^1 = D(E)) with c != 0")
    for D, c in CONFIGS:
        for N in range(0, 4):
            assert check_ddf_equals_transverse(D, c, N)

    print("== [MAIN] Theorem 3' on the antidiagonal slice, c != 0 (equality iff D = 26)")
    for N in (1, 2):
        for D, c in CONFIGS:
            check_main(D, c, N)
    if heavy:
        for D in (24, 25, 26, 27):
            c = tuple([Q(1)] + [Q(0)] * (D - 3))
            check_main(D, c, 2)
    print("done")


if __name__ == "__main__":
    main()
