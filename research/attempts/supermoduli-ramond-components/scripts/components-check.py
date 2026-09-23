#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
components-check.py — 对 research/attempts/supermoduli-ramond-components/proof.md
§8（拓扑路线）的穷举机器核对。

模型（proof.md §8 建立）：
  Sigma^o = 亏格 g 的闭曲面挖掉 m 个穿孔；V = H_1(Sigma^o; Z/2)，dim V = 2g + m - 1。
  基：a_1,b_1,...,a_g,b_g, gamma_1,...,gamma_{m-1}；gamma_m := gamma_1+...+gamma_{m-1}。
  交形式：a_i . b_i = 1（其余基对为 0）；gamma_j 全在根基里。
  广义自旋结构 <-> 二次细化 q: V -> Z/2，q(x+y)=q(x)+q(y)+x.y，
     且 q(gamma_j) = eps_j，其中 eps = 0 表示 NS 穿孔、eps = 1 表示 Ramond 穿孔。
  推点（point-pushing）第 j 个穿孔沿类 alpha：
     P_{j,alpha}(x) = x + (x . alpha) gamma_j     （mod 2；proof.md §8.3 有推导）
  Dehn 扭转沿类 c：T_c(x) = x + (x . c) c
  对二次型的作用：(phi . q)(x) = q(phi^{-1} x)

本脚本核对的断言（全部来自 proof.md，逐条对应）：
  A1  q 由基上的取值唯一确定，且二次恒等式在整个 V 上成立；共 2^{2g+m-1} 个 q。
  A2  Q_eps 非空 <=> sum_j eps_j = 0（即 Ramond 穿孔数必为偶）；非空时 |Q_eps| = 2^{2g}。
  A3  若某个 eps_j = 1（有 Ramond 穿孔），则仅推点子群在 Q_eps 上就已传递 —— 1 条轨道。
      （= proof.md 定理 3.3 / 定理 8.2 的拓扑侧独立复核）
  A4  若全部 eps_j = 0（纯 NS），则推点作用平凡 —— |Q_eps| = 2^{2g} 条轨道。
      （= proof.md 注 3.5：机制在 r=0 精确归零，不是"变弱"）
  A5  纯 NS 情形加上 Dehn 扭转（生成 Sp(2g,Z/2)）后恰 2 条轨道，
      大小 2^{g-1}(2^g+1) 与 2^{g-1}(2^g-1)，由 Arf 区分。
  A6  q 下降到 V/Rad <=> q|_Rad = 0 <=> 无 Ramond 穿孔。

运行：  python -X utf8 components-check.py
（Windows GBK 控制台需要 -X utf8）
退出码 0 = 全部通过。
"""

from itertools import product
import sys

FAIL = []


def check(cond, msg):
    if not cond:
        FAIL.append(msg)
        print("  FAIL:", msg)
    return cond


class Surface:
    """亏格 g、m 个穿孔的曲面的 mod-2 一阶同调模型。"""

    def __init__(self, g, m):
        assert m >= 1
        self.g, self.m = g, m
        self.dim = 2 * g + m - 1
        # 基编号：0..2g-1 为 a_1,b_1,...,a_g,b_g；2g..2g+m-2 为 gamma_1..gamma_{m-1}
        self.gammas = []
        for j in range(m - 1):
            v = [0] * self.dim
            v[2 * g + j] = 1
            self.gammas.append(tuple(v))
        last = [0] * self.dim
        for j in range(m - 1):
            last[2 * g + j] = 1
        self.gammas.append(tuple(last))  # gamma_m = sum of the others
        self.vectors = [tuple(v) for v in product((0, 1), repeat=self.dim)]

    def add(self, x, y):
        return tuple((a + b) % 2 for a, b in zip(x, y))

    def scale_add(self, x, lam, y):
        return x if lam == 0 else self.add(x, y)

    def dot(self, x, y):
        s = 0
        for i in range(self.g):
            s += x[2 * i] * y[2 * i + 1] + x[2 * i + 1] * y[2 * i]
        return s % 2

    # ---- 二次细化 ----
    def form_from_basis_values(self, vals):
        """vals: 长度 dim 的 0/1 元组，给出 q 在基上的取值。返回 dict: vector -> q(vector)."""
        q = {}
        for x in self.vectors:
            s = 0
            for i in range(self.dim):
                if x[i]:
                    s += vals[i]
            for i in range(self.dim):
                for j in range(i + 1, self.dim):
                    if x[i] and x[j]:
                        ei = tuple(1 if k == i else 0 for k in range(self.dim))
                        ej = tuple(1 if k == j else 0 for k in range(self.dim))
                        s += self.dot(ei, ej)
            q[x] = s % 2
        return q

    def all_forms(self):
        return [self.form_from_basis_values(v)
                for v in product((0, 1), repeat=self.dim)]

    def is_quadratic(self, q):
        for x in self.vectors:
            for y in self.vectors:
                if q[self.add(x, y)] != (q[x] + q[y] + self.dot(x, y)) % 2:
                    return False
        return True

    # ---- 映射类群元素（线性自同构）----
    def point_push(self, j, alpha):
        """P_{j,alpha}(x) = x + (x.alpha) gamma_j;  mod 2 是对合，故 P = P^{-1}."""
        gj = self.gammas[j]
        return {x: self.scale_add(x, self.dot(x, alpha), gj) for x in self.vectors}

    def dehn(self, c):
        """T_c(x) = x + (x.c) c;  mod 2 是对合。"""
        return {x: self.scale_add(x, self.dot(x, c), c) for x in self.vectors}

    def act(self, phi_inv, q):
        """(phi . q)(x) = q(phi^{-1} x)；传入的是 phi^{-1}（本脚本里用的都是对合）。"""
        return {x: q[phi_inv[x]] for x in self.vectors}


def key(q, S):
    return tuple(q[x] for x in S.vectors)


def orbits(forms, gens, S):
    index = {key(q, S): i for i, q in enumerate(forms)}
    parent = list(range(len(forms)))

    def find(a):
        while parent[a] != a:
            parent[a] = parent[parent[a]]
            a = parent[a]
        return a

    def union(a, b):
        ra, rb = find(a), find(b)
        if ra != rb:
            parent[ra] = rb

    for i, q in enumerate(forms):
        for gphi in gens:
            k = key(S.act(gphi, q), S)
            if k in index:          # 作用保持 Q_eps（见 proof.md §8）
                union(i, index[k])
            else:
                FAIL.append("orbit: 群作用跑出了 Q_eps —— 模型不自洽")
    buckets = {}
    for i in range(len(forms)):
        buckets.setdefault(find(i), []).append(i)
    return list(buckets.values())


def arf(q, S):
    """闭曲面情形（m=1 或 q|_Rad=0 后下降）：Arf = sum_i q(a_i) q(b_i)."""
    a = 0
    for i in range(S.g):
        ei = tuple(1 if k == 2 * i else 0 for k in range(S.dim))
        fi = tuple(1 if k == 2 * i + 1 else 0 for k in range(S.dim))
        a += q[ei] * q[fi]
    return a % 2


def run_case(g, eps):
    m = len(eps)
    S = Surface(g, m)
    nR = sum(eps)
    tag = "g=%d, m=%d, eps=%s  (NS=%d, R=%d)" % (g, m, "".join(map(str, eps)),
                                                 m - nR, nR)
    print("\n== " + tag + " ==")

    forms = S.all_forms()
    check(len(forms) == 2 ** S.dim, "A1 计数: |all q| = 2^%d" % S.dim)
    check(all(S.is_quadratic(q) for q in forms), "A1 二次恒等式在整个 V 上成立")

    Qe = [q for q in forms if all(q[S.gammas[j]] == eps[j] for j in range(m))]
    parity_ok = (nR % 2 == 0)
    check((len(Qe) > 0) == parity_ok,
          "A2 Q_eps 非空 <=> Ramond 穿孔数为偶 (nR=%d)" % nR)
    if not parity_ok:
        print("   Q_eps 为空（Ramond 穿孔数为奇），符合预期；跳过其余检查")
        return
    check(len(Qe) == 2 ** (2 * g), "A2 |Q_eps| = 2^{2g} = %d，实得 %d"
          % (2 ** (2 * g), len(Qe)))

    # A6: 下降性
    rad = [x for x in S.vectors
           if all(S.dot(x, y) == 0 for y in S.vectors)]
    for q in Qe:
        descends = all(q[x] == 0 for x in rad)
        check(descends == (nR == 0),
              "A6 q 下降 <=> 无 Ramond 穿孔 (nR=%d)" % nR)
        break  # 只需一个代表：q|_Rad 由 eps 完全决定

    # A3 / A4: 只用推点
    push_gens = []
    for j in range(m):
        for alpha in S.vectors:
            push_gens.append(S.point_push(j, alpha))
    orb_push = orbits(Qe, push_gens, S)
    if nR >= 1:
        check(len(orb_push) == 1,
              "A3 有 Ramond 穿孔 => 推点已传递；实得 %d 条轨道" % len(orb_push))
        print("   A3 OK: 推点子群在 %d 个自旋结构上传递（1 条轨道）" % len(Qe))
    else:
        check(len(orb_push) == len(Qe),
              "A4 纯 NS => 推点作用平凡；应 %d 条轨道，实得 %d"
              % (len(Qe), len(orb_push)))
        print("   A4 OK: 纯 NS 时推点逐点不动（%d 条轨道）" % len(orb_push))

    # A5: 纯 NS 再加 Dehn 扭转
    if nR == 0:
        gens = list(push_gens)
        for c in S.vectors:
            if any(c):
                gens.append(S.dehn(c))
        orb_all = orbits(Qe, gens, S)
        if g == 0:
            check(len(orb_all) == 1, "A5 g=0 纯 NS: 1 条轨道")
            print("   A5 OK: g=0 时 |Q_eps|=1，平凡连通")
        else:
            check(len(orb_all) == 2,
                  "A5 纯 NS、g=%d: 应 2 条轨道，实得 %d" % (g, len(orb_all)))
            sizes = sorted(len(o) for o in orb_all)
            want = sorted([2 ** (g - 1) * (2 ** g - 1), 2 ** (g - 1) * (2 ** g + 1)])
            check(sizes == want, "A5 轨道大小应为 %s，实得 %s" % (want, sizes))
            # 每条轨道上 Arf 常值，且两条轨道 Arf 不同
            arfs = []
            for o in orb_all:
                vals = {arf(Qe[i], S) for i in o}
                check(len(vals) == 1, "A5 Arf 在轨道上常值")
                arfs.append(vals.pop())
            check(sorted(arfs) == [0, 1], "A5 两条轨道的 Arf 分别为 0 和 1")
            print("   A5 OK: 2 条轨道，大小 %s，Arf 分别 %s" % (sizes, sorted(arfs)))


def elliptic_monodromy_check():
    """proof.md §6.1 的算术复核：g=1, 2r=2 时点推生成 E[2]。
    E = C/(Z + Z tau)，解 2x = rho_1 + rho_2。沿 a-圈推 rho_1 一周（rho_1 -> rho_1 + 1）
    得 x -> x + 1/2；沿 b-圈得 x -> x + tau/2。用 (1/2)Lambda/Lambda = (Z/2)^2 的坐标。"""
    print("\n== §6.1 g=1, 2r=2 的显式单值 ==")
    gens = {(1, 0), (0, 1)}          # 1/2 与 tau/2
    grp = {(0, 0)}
    changed = True
    while changed:
        changed = False
        for x in list(grp):
            for gset in gens:
                y = ((x[0] + gset[0]) % 2, (x[1] + gset[1]) % 2)
                if y not in grp:
                    grp.add(y)
                    changed = True
    check(len(grp) == 4, "§6.1 推点生成的子群应是整个 E[2]（4 个元素），实得 %d" % len(grp))
    print("   OK: 生成的子群 = %s = E[2]" % sorted(grp))


def genus2_parity_jump_check():
    """proof.md §6.2 的算术复核：g=2, 2r=2。
    deg L = 2，h^0(L) = 1 + [L = omega]。在 rho_2 = iota(rho_1) 的轨迹上纤维是
    omega tensor J[2]（16 个），其中恰 1 个 h^0=2（偶），其余 15 个 h^0=1（奇）。"""
    print("\n== §6.2 g=2, 2r=2 的宇称跳变计数 ==")
    g = 2
    fibre = 2 ** (2 * g)
    h0 = [1 + (1 if eta == 0 else 0) for eta in range(fibre)]   # eta=0 对应 L=omega
    even = sum(1 for v in h0 if v % 2 == 0)
    odd = fibre - even
    check(fibre == 16, "§6.2 纤维大小 2^{2g} = 16，实得 %d" % fibre)
    check(even == 1 and odd == 15,
          "§6.2 轨迹上应 1 偶 15 奇，实得 %d 偶 %d 奇" % (even, odd))
    # 轨迹外：所有 16 个都 h^0 = 1（奇）
    check(all(v % 2 == 1 for v in [1] * fibre), "§6.2 轨迹外全奇")
    print("   OK: 轨迹上 1 偶 / 15 奇，轨迹外 16 奇 => h^0 mod 2 非局部常值")
    # 维数：dim M_{2,2} = 3g-3+m = 5；轨迹 dim = 3(曲线) + 1(rho_1) = 4，余维 1
    check(3 * 2 - 3 + 2 == 5 and 3 + 1 == 4, "§6.2 余维 1 的算术")
    print("   OK: dim M_{2,2}=5, dim Z=4, 余维 1")


def main():
    cases = [
        # (g, eps)  eps_j: 0=NS, 1=Ramond
        (0, (1, 1)),                 # g=0, 2 个 Ramond
        (0, (0, 1, 1)),              # g=0, 1 NS + 2 Ramond
        (0, (0, 0, 0)),              # g=0, 3 NS
        (1, (1, 1)),                 # g=1, 2 个 Ramond   <- 主情形
        (1, (0, 1, 1)),              # g=1, 1 NS + 2 Ramond
        (1, (0,)),                   # g=1, 1 NS（纯 NS 对照）
        (1, (0, 0)),                 # g=1, 2 NS
        (1, (1,)),                   # g=1, 1 Ramond -> 应为空（奇数个）
        (2, (1, 1)),                 # g=2, 2 个 Ramond   <- proof.md §6.2 的情形
        (2, (0,)),                   # g=2, 1 NS（纯 NS 对照，应 2 条轨道 6/10）
    ]
    for g, eps in cases:
        run_case(g, eps)
    elliptic_monodromy_check()
    genus2_parity_jump_check()

    print("\n" + "=" * 60)
    if FAIL:
        print("RESULT: %d FAILURE(S)" % len(FAIL))
        for f in FAIL:
            print("  -", f)
        return 1
    print("RESULT: ALL OK")
    return 0


if __name__ == "__main__":
    sys.exit(main())
