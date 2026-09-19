"""Exact-arithmetic check of the Lambda^2 / Sym^2 route to the so(N)/usp(N)
adjoint-trace identities (graph card math.so-usp-adjoint-fundamental-trace-identities).

Provenance: written and run by lead, 2026-09-19, to de-risk the one step that
the scouting agent (souspscout) explicitly reported as NOT checked -- namely the
"basis-matching bridge": that the abstract tensor formula

    Tr_{Lambda^2}(F)^k = 1/2 [ sum_m C(k,m) tr(F^m) tr(F^{k-m}) - 2^k tr(F^k) ]
    Tr_{Sym^2}  (F)^k = 1/2 [ sum_m C(k,m) tr(F^m) tr(F^{k-m}) + 2^k tr(F^k) ]

really does equal Tr((ad F)^k) on the LITERAL matrix Lie algebra as Mathlib's
`Algebra/Lie/Classical.lean` defines it (antisymmetric / J-antisymmetric matrices,
ad(F)(X) = F X - X F).  The scout verified the tensor side by hand; nothing had
verified that it lands on ad.  This script builds ad(F) as an explicit matrix in
an explicit basis of the algebra and compares exact integer traces.

Method: integer matrices throughout (exact); Fractions only inside the linear
solve that re-expresses ad(F)(X) in the chosen basis.  The solve asserts the
image stays inside the algebra, which is itself a check that the basis is right.

Result when run: so(N) for N = 3..8 and sp(2n) for N = 2,4,6,8, two random
elements each, k = 2,4,6 -> 60 checks, 60 exact matches, 0 mismatches.

Run:  python docs/frontier-scouting/so-usp-adjoint-trace-check.py
"""
from fractions import Fraction as F
import itertools, random

def matmul(A,B):
    n=len(A); m=len(B[0]); k=len(B)
    return [[sum(A[i][t]*B[t][j] for t in range(k)) for j in range(m)] for i in range(n)]
def tr(A): return sum(A[i][i] for i in range(len(A)))
def sub(A,B): return [[A[i][j]-B[i][j] for j in range(len(A))] for i in range(len(A))]
def mpow(A,k):
    n=len(A); R=[[1 if i==j else 0 for j in range(n)] for i in range(n)]
    for _ in range(k): R=matmul(R,A)
    return R

def ad_matrix(Fm, basis):
    # express ad(F)(X) = F X - X F in terms of `basis` (list of matrices, lin indep)
    d=len(basis); N=len(Fm)
    # flatten basis into columns, solve by exact gaussian elim
    cols=[[b[i][j] for i in range(N) for j in range(N)] for b in basis]
    M=[]
    for b in basis:
        img=sub(matmul(Fm,b), matmul(b,Fm))
        M.append([img[i][j] for i in range(N) for j in range(N)])
    # solve cols^T c = img for each img
    A=[[F(cols[c][r]) for c in range(d)] for r in range(N*N)]
    out=[[F(0)]*d for _ in range(d)]
    for bi,rhs in enumerate(M):
        aug=[row[:]+[F(rhs[r])] for r,row in enumerate(A)]
        # gaussian
        piv=[]; r=0
        for c in range(d):
            p=None
            for rr in range(r,len(aug)):
                if aug[rr][c]!=0: p=rr; break
            if p is None: continue
            aug[r],aug[p]=aug[p],aug[r]
            pv=aug[r][c]
            aug[r]=[x/pv for x in aug[r]]
            for rr in range(len(aug)):
                if rr!=r and aug[rr][c]!=0:
                    f=aug[rr][c]
                    aug[rr]=[x-f*y for x,y in zip(aug[rr],aug[r])]
            piv.append(c); r+=1
        for rr in range(r,len(aug)):
            assert aug[rr][d]==0, "inconsistent: image left the algebra"
        sol=[F(0)]*d
        for i,c in enumerate(piv): sol[c]=aug[i][d]
        for c in range(d): out[c][bi]=sol[c]   # column bi
    return out

def so_basis(N):
    B=[]
    for i in range(N):
        for j in range(i+1,N):
            m=[[0]*N for _ in range(N)]; m[i][j]=1; m[j][i]=-1; B.append(m)
    return B
def sp_basis(n):
    N=2*n
    J=[[0]*N for _ in range(N)]
    for i in range(n): J[i][n+i]=1; J[n+i][i]=-1
    B=[]
    for i in range(N):
        for j in range(i,N):
            S=[[0]*N for _ in range(N)]; S[i][j]=1; S[j][i]=1
            B.append(matmul(J,S))
    return B,J

def rand_in_span(basis,seed):
    rnd=random.Random(seed); N=len(basis[0])
    Fm=[[0]*N for _ in range(N)]
    for b in basis:
        c=rnd.randint(-3,3)
        for i in range(N):
            for j in range(N): Fm[i][j]+=c*b[i][j]
    return Fm

def predict(N,sign,t2,t4,t6):
    return {2:(N+sign*2)*t2,
            4:(N+sign*8)*t4+3*t2*t2,
            6:(N+sign*32)*t6+15*t2*t4}

print("=== so(N): adjoint = Lambda^2, predicted sign -1 ===")
ok=0; bad=0
for N in [3,4,5,6,7,8]:
    B=so_basis(N)
    for s in range(2):
        Fm=rand_in_span(B,1000*N+s)
        A=ad_matrix(Fm,B)
        t2,t4,t6=tr(mpow(Fm,2)),tr(mpow(Fm,4)),tr(mpow(Fm,6))
        pred=predict(N,-1,t2,t4,t6)
        for k in (2,4,6):
            got=tr(mpow(A,k))
            m = (got==pred[k])
            ok+=m; bad+= (not m)
            print(f"  N={N} s={s} k={k}: Tr(adF)^k={got}  formula={pred[k]}  {'OK' if m else '*** MISMATCH ***'}")

print("=== usp(N=2n): adjoint = Sym^2, predicted sign +1 ===")
for n in [1,2,3,4]:
    B,J=sp_basis(n); N=2*n
    for s in range(2):
        Fm=rand_in_span(B,2000*n+s)
        A=ad_matrix(Fm,B)
        t2,t4,t6=tr(mpow(Fm,2)),tr(mpow(Fm,4)),tr(mpow(Fm,6))
        pred=predict(N,+1,t2,t4,t6)
        for k in (2,4,6):
            got=tr(mpow(A,k))
            m=(got==pred[k])
            ok+=m; bad+=(not m)
            print(f"  N={N} s={s} k={k}: Tr(adF)^k={got}  formula={pred[k]}  {'OK' if m else '*** MISMATCH ***'}")
print(f"\nTOTAL ok={ok} bad={bad}")
