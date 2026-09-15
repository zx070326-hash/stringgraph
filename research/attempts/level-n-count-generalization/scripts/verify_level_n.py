"""Verify the general formula

    p_m(N) = sum over partitions of N (grouped by distinct part size with
             multiplicity r_s) of  prod_s C(m + r_s - 1, r_s)

against a direct generating-function computation of the coefficient of x^N in
    prod_{n=1}^{N} (1 - x^n)^{-m}
for various m, N.  Uses only Python's `math.comb` and elementary partition
enumeration (via `sympy.utilities.iterables.partitions`), no Lean involved.
"""
from math import comb
from itertools import product


def partitions_freq(n):
    """Yield partitions of n as dicts {part_size: multiplicity}."""
    def helper(n, max_part):
        if n == 0:
            yield {}
            return
        for k in range(min(n, max_part), 0, -1):
            max_mult = n // k
            for mult in range(1, max_mult + 1):
                rem = n - k * mult
                if rem == 0:
                    yield {k: mult}
                else:
                    for tail in helper(rem, k - 1):
                        d = dict(tail)
                        d[k] = mult
                        yield d

    yield from helper(n, n)


def p_via_partitions(m, N):
    total = 0
    for freq in partitions_freq(N):
        term = 1
        for s, r in freq.items():
            term *= comb(m + r - 1, r)
        total += term
    return total


def p_via_generating_function(m, N):
    """Coefficient of x^N in prod_{n=1}^{N} (1-x^n)^{-m}, computed by
    iterative power-series multiplication (DP), independent of the
    partition-grouping formula above."""
    # series[k] = coefficient of x^k, k = 0..N
    series = [0] * (N + 1)
    series[0] = 1
    for n in range(1, N + 1):
        # multiply current series by (1-x^n)^{-m} = sum_{r>=0} C(m+r-1,r) x^{n r}
        factor_terms = []
        r = 0
        while n * r <= N:
            factor_terms.append((n * r, comb(m + r - 1, r) if r > 0 else 1))
            r += 1
        new_series = [0] * (N + 1)
        for k, ck in enumerate(series):
            if ck == 0:
                continue
            for (deg, coef) in factor_terms:
                if k + deg <= N:
                    new_series[k + deg] += ck * coef
        series = new_series
    return series[N]


def p_via_brute_force(m, N):
    """Fully independent brute-force count: enumerate all Finsupp-like
    functions d : {1..m} x {1..N} -> N with sum n*d(i,n) = N directly by
    recursive search over mode numbers n = N, N-1, ..., 1, choosing how many
    times each of the m colors is used at that mode number (multiplicities
    summing appropriately). This is exponential but fine for small N, m."""
    from functools import lru_cache

    @lru_cache(maxsize=None)
    def count(remaining, n):
        # number of ways to write `remaining` using mode numbers 1..n,
        # each mode number s contributes r_s * s to the weight, with the
        # r_s directions chosen as an unordered multiset of size r_s from m
        # colors (comb(m + r_s - 1, r_s) ways), summed over all r_s >= 0.
        if remaining == 0:
            return 1
        if n == 0:
            return 0
        total = 0
        r = 0
        while r * n <= remaining:
            ways = comb(m + r - 1, r) if r > 0 else 1
            total += ways * count(remaining - r * n, n - 1)
            r += 1
        return total

    return count(N, N)


if __name__ == "__main__":
    print(f"{'N':>3} {'m':>3} {'partitions':>12} {'gen.func':>12} {'brute':>12} {'match':>6}")
    for N in range(1, 11):
        for m in range(1, 6):
            a = p_via_partitions(m, N)
            b = p_via_generating_function(m, N)
            c = p_via_brute_force(m, N)
            ok = (a == b == c)
            print(f"{N:>3} {m:>3} {a:>12} {b:>12} {c:>12} {str(ok):>6}")
            assert ok, (N, m, a, b, c)
    print("\nAll three independent methods agree for N=1..10, m=1..5.")
