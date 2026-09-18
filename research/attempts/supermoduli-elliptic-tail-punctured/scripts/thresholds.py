#!/usr/bin/env python3
"""
穷举检验 proof.md §5 的门槛推导与 §6.2 的自洽性检验。

这不是证明的一部分，而是对**整数算术**部分的机器复核：
定理 M 的前提是 (P1) h>=2 与 (P2) 2a-2+(n+1)+2r>0，结论关于 g=h+a。
本脚本在有限范围内穷举 (h,a,n,r)，把"被定理 M 覆盖的 (g,n,r)"集合算出来，
并与 proof.md §5.1 声称的闭式判据逐点对照；同时检验 §6.2 的两条"必须碰不到"。

运行：
    python research/attempts/supermoduli-elliptic-tail-punctured/scripts/thresholds.py
预期输出：全部 OK，退出码 0。（实际输出见本文件末尾的 EXPECTED OUTPUT 注释。）
"""

G_MAX, N_MAX, R_MAX, A_MAX = 8, 6, 4, 6


def covered_by_construction(g, n, r):
    """存在 (h,a) 使 h>=2, a>=0, h+a=g, 且尾巴稳定 2a-2+(n+1)+2r>0 吗？
    返回被证实可用的 (h,a) 列表。"""
    out = []
    for a in range(0, min(A_MAX, g) + 1):
        h = g - a
        if h < 2:                      # (P1)
            continue
        if 2 * a - 2 + (n + 1) + 2 * r <= 0:   # (P2) 尾巴稳定性
            continue
        out.append((h, a))
    return out


def closed_form(g, n, r):
    """proof.md §5.1 的闭式判据：g>=3，或 (g==2 且 n+2r>=2)。"""
    return g >= 3 or (g == 2 and n + 2 * r >= 2)


def parity_reachable(g, n):
    """r=0 时，本方法能到达哪些宇称分量？
    a=1 尾巴（亏格1自旋，N^2=O_E）：两种宇称；a=0 尾巴（N=O(-1)）：只有偶。"""
    eps = set()
    for h, a in covered_by_construction(g, n, 0):
        if a == 0:
            eps.add("+")           # O_{P^1}(-1)，h^0=0，偶
        elif a == 1:
            eps.update({"+", "-"})  # 平凡 theta 特征为奇，三个非平凡 2-挠为偶
        else:
            eps.update({"+", "-"})  # a>=2 的自旋曲线两种宇称都有
    return eps


def main():
    fail = 0

    # --- 检验 1：穷举覆盖集 == 闭式判据 -------------------------------------
    for g in range(0, G_MAX + 1):
        for n in range(0, N_MAX + 1):
            for r in range(0, R_MAX + 1):
                got = bool(covered_by_construction(g, n, r))
                want = closed_form(g, n, r)
                if got != want:
                    print(f"FAIL closed-form mismatch at (g,n,r)=({g},{n},{r}): "
                          f"enumeration={got} closed_form={want}")
                    fail += 1
    print("[1] 闭式判据 'g>=3 or (g==2 and n+2r>=2)' 与穷举一致：",
          "OK" if fail == 0 else "FAIL")

    # --- 检验 2：§6.2 本方法必须碰不到 (g,n,r)=(2,0,0) ----------------------
    # 若碰得到就与 CN Theorem 1.1(1)（M̄_2^- 分裂）以及 (P1)(P2) 的设计意图冲突。
    if covered_by_construction(2, 0, 0):
        print("FAIL (2,0,0) is reachable — contradicts CN Thm 1.1(1) design check")
        fail += 1
    else:
        print("[2] (g,n,r)=(2,0,0) 不可达（与 CN 的 bar-M_2^- 分裂性相容）：OK")

    # --- 检验 3：§6.2 g=2 只能到偶宇称 --------------------------------------
    bad = [(2, n) for n in range(0, N_MAX + 1) if "-" in parity_reachable(2, n)]
    if bad:
        print(f"FAIL g=2 odd parity reachable at n={[n for _, n in bad]}")
        fail += 1
    else:
        print("[3] g=2 时只能到达偶宇称分量（结构上碰不到奇分量）：OK")

    # --- 检验 4：§6.1 退化到 CN：n=r=0 时最小可达亏格是 3，且 g=3 只能用 a=1 --
    # （g>=4 时 a>=2 的尾巴也稳定，但给出的 g 更大，被 a=1 包含——见 proof.md §5.3）
    reach = [g for g in range(0, G_MAX + 1) if covered_by_construction(g, 0, 0)]
    ok4 = (reach == list(range(3, G_MAX + 1))
           and covered_by_construction(3, 0, 0) == [(2, 1)])
    if not ok4:
        print(f"FAIL n=r=0: reachable g = {reach}, g=3 options = "
              f"{covered_by_construction(3, 0, 0)}")
        fail += 1
    else:
        print("[4] n=r=0 时恰好覆盖 g>=3，且 g=3 只能用 a=1（椭圆）尾巴 "
              "= CN 的定理：OK")

    # --- 检验 5：与种子界的严格改进（claim.md §4 的两张表） -----------------
    # 5a. DW 的 n<=g-1 限制被去掉：存在 n>=g 的格点被本方法覆盖
    new_ns = [(g, n) for g in range(3, G_MAX + 1) for n in range(g, N_MAX + 1)
              if closed_form(g, n, 0)]
    print(f"[5a] DW 覆盖不到的 n>=g 区域中，本方法覆盖 {len(new_ns)} 个格点"
          f"（如 {new_ns[:4]}）：OK" if new_ns else "[5a] FAIL")
    if not new_ns:
        fail += 1

    # 5b. Donagi-Ott g>=5r+1 (n=0, r>0) 被 g>=2 取代
    do_gain = [(g, r) for r in range(1, R_MAX + 1) for g in range(2, 5 * r + 1)
               if closed_form(g, 0, r)]
    print(f"[5b] Donagi–Ott 的 g>=5r+1 之下（n=0,r>0），本方法新覆盖 "
          f"{len(do_gain)} 个格点（如 {do_gain[:4]}）：OK" if do_gain else "[5b] FAIL")
    if not do_gain:
        fail += 1

    # 5c. 本方法不覆盖 (2,1,0)（claim.md §4.3 明确声明的不覆盖点）
    if closed_form(2, 1, 0):
        print("FAIL (2,1,0) should NOT be covered (claim.md §4.3)")
        fail += 1
    else:
        print("[5c] (g,n,r)=(2,1,0) 如声明般不被覆盖（与上一轮互不包含）：OK")

    print("\nRESULT:", "ALL OK" if fail == 0 else f"{fail} FAILURE(S)")
    return 1 if fail else 0


if __name__ == "__main__":
    raise SystemExit(main())

# EXPECTED OUTPUT（2026-09-18 实跑）：
# [1] 闭式判据 'g>=3 or (g==2 and n+2r>=2)' 与穷举一致： OK
# [2] (g,n,r)=(2,0,0) 不可达（与 CN 的 bar-M_2^- 分裂性相容）：OK
# [3] g=2 时只能到达偶宇称分量（结构上碰不到奇分量）：OK
# [4] n=r=0 时恰好覆盖 g>=3，且 g=3 只能用 a=1（椭圆）尾巴 = CN 的定理：OK
# [5a] DW 覆盖不到的 n>=g 区域中，本方法覆盖 10 个格点（如 [(3, 3), (3, 4), (3, 5), (3, 6)]）：OK
# [5b] Donagi–Ott 的 g>=5r+1 之下（n=0,r>0），本方法新覆盖 46 个格点
#      （如 [(2, 1), (3, 1), (4, 1), (5, 1)]）：OK
# [5c] (g,n,r)=(2,1,0) 如声明般不被覆盖（与上一轮互不包含）：OK
# RESULT: ALL OK
#
# 注：Windows 控制台为 GBK 编码时，请用 `python -X utf8` 或
#     `PYTHONIOENCODING=utf-8 python ...` 运行以正确显示中文。
