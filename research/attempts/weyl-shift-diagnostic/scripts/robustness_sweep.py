"""
Robustness sweep for the full divisor-sum identity (Theorem 9 / Theorem D /
Proposition B):

    Z_I(tau,z,sigma) = sum_{d|I} d * Z_1(tau, d*z + (d-1)/2, d^2*sigma)

checked as an exact identity of formal Laurent polynomials in q,y,p, for a
toy random-integer Omega_1 array, across I in {1,2,3,4,5,6,8,9,12} and 3
independent random seeds each (27 configurations total). This reproduces
the "extra robustness checks" reported inline (not as a saved script) in
the original weyl-shift-diagnostic/proof.md section 6; saved here as an
actual script for reproducibility when merging into bkm-shift-explanation.

Run: python robustness_sweep.py
"""
import random
import sympy as sp

q, y, p = sp.symbols("q y p")


def run_one(I_val, seed):
    random.seed(seed)
    support = []
    for n in range(-1, 2):
        for m in range(0, 2):
            for ell in range(-2, 3):
                support.append((n, m, ell))
    Omega1 = {key: sp.Integer(random.randint(-5, 5)) for key in support}

    divisors = [dv for dv in range(1, I_val + 1) if I_val % dv == 0]

    def OmegaI(n, m, ell):
        total = sp.Integer(0)
        for dv in divisors:
            if m % (dv * dv) != 0 or ell % dv != 0:
                continue
            mm, ee = m // (dv * dv), ell // dv
            total += dv * Omega1.get((n, mm, ee), sp.Integer(0))
        return total

    def enumerate_keys():
        keys = set()
        for dv in divisors:
            for (n, mprime, ellprime) in support:
                keys.add((n, dv * dv * mprime, dv * ellprime))
        return keys

    ZI_direct = sp.Integer(0)
    for (n, m, ell) in enumerate_keys():
        val = OmegaI(n, m, ell)
        if val != 0:
            ZI_direct += sp.Integer((-1) ** ell) * val * q**n * y**ell * p**m

    ZI_shift = sp.Integer(0)
    for dv in divisors:
        inner = sp.Integer(0)
        for key, val in Omega1.items():
            n, mprime, ellprime = key
            if val == 0:
                continue
            y_pow = ((y**dv) * sp.Integer((-1) ** (dv - 1))) ** ellprime
            term = sp.Integer((-1) ** ellprime) * val * q**n * y_pow * p**(dv * dv * mprime)
            inner += term
        ZI_shift += dv * inner
    ZI_shift = sp.expand(ZI_shift)

    diff = sp.expand(ZI_direct - ZI_shift)
    return diff


if __name__ == "__main__":
    I_values = [1, 2, 3, 4, 5, 6, 8, 9, 12]
    all_ok = True
    for I_val in I_values:
        for seed in (1, 2, 3):
            diff = run_one(I_val, seed)
            ok = (diff == 0)
            all_ok &= ok
            print(f"I={I_val} seed={seed}: diff={diff}  {'OK' if ok else 'FAIL'}")
    print()
    if all_ok:
        print("ALL 27/27 CONFIGURATIONS PASSED (diff == 0 exactly).")
    else:
        print("SOME CONFIGURATIONS FAILED -- investigate.")
