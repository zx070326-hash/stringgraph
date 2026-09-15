from math import comb


def p7(m):
    return (m + 3*m*m + 3*m*comb(m+1, 2) + m**3 + 2*m*comb(m+2, 3)
            + m*m*comb(m+1, 2) + m*comb(m+3, 4) + comb(m+1, 2)*comb(m+2, 3)
            + m*comb(m+4, 5) + comb(m+6, 7))


def p6(m):
    return (m + 2*m*m + m*comb(m+1, 2) + comb(m+1, 2) + m**3 + m*comb(m+2, 3)
            + comb(m+2, 3) + comb(m+1, 2)**2 + m*comb(m+3, 4) + comb(m+5, 6))


def p5(m):
    return m + 2*m*m + 2*m*comb(m+1, 2) + m*comb(m+2, 3) + comb(m+4, 5)


for m in range(0, 8):
    lhs = p7(m+1) + comb(m+3, 2)
    rhs = p7(m) + p6(m+1) + p5(m+1)
    print(m, lhs, rhs, lhs == rhs)
