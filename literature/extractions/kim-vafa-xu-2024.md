# 抽取记录：kim-vafa-xu-2024

- 文献：Hee-Cheol Kim, Cumrun Vafa, Kai Xu, "Finite Landscape of 6d N=(1,0) Supergravity", arXiv:2411.19155**v3** [hep-th], 23 Jun 2025（初投 2024-11）。Prepared for submission to JHEP.
- 抽取者：researcher agent
- 日期：2026-09-13
- 覆盖范围：标题页（摘要逐字）、目录
- 取件方式：`arxiv.org/pdf/2411.19155` → WebFetch 落盘 → `Read(pages=1-2)`。**证据等级 L1（原文页图），但仅覆盖摘要与目录。**

## 约定

未抽取（只读到摘要与目录）。

## 陈述

### E1 有限性主张与精确数值界
- 位置：摘要，论文标题页
- 类型：proposition
- 原文陈述（**逐字**）：「We present a **bottom-up argument** showing that the number of massless fields in six-dimensional quantum gravitational theories with eight supercharges is uniformly bounded. Specifically, we show that the number of tensor multiplets is bounded by `T ≤ 193`, and the rank of the gauge group is restricted to `r(V) ≤ 480`. Given that F-theory compactifications on elliptic CY 3-folds are a subset, this provides a bound on the Hodge numbers of elliptic CY 3-folds: `h^{1,1}(CY_3) ≤ 491`, `h^{1,1}(Base) ≤ 194` which are saturated by special elliptic CY 3-folds. This establishes that our bounds are sharp and also provides further evidence for the string lamppost principle. These results are derived by a comprehensive examination of the boundaries of the tensor moduli branch, showing that any consistent supergravity theory with `T ≠ 0` must include a BPS string in its spectrum corresponding to a "little string theory" (LST) or a critical heterotic string. From this tensor branch analysis, we establish a containment relationship between SCFTs and LSTs embedded within a gravitational theory. Combined with the classification of 6d SCFTs and LSTs, this then leads to the above bounds. **Together with previous works, this establishes the finiteness of the supergravity landscape for `d ≥ 6`.**」
- 文献自称的严格程度：自称 "bottom-up **argument**"、"we show"。**依赖 6d SCFT 与 LST 的分类**（那本身是物理论证级的分类，非数学定理）⇒ 整体上限 `physical-argument`。
- 备注：**★ `h^{1,1}(CY_3) ≤ 491` 在此被当作推论给出**，与本项目记忆中「`h^{1,1} ≤ 491` 安全、`h^{11}+h^{21} ≤ 502` 查不到出处」一致，可作为该数值的又一条独立佐证（但注意这里的 491 是**椭圆纤维化** CY3，不是一般 CY3）。

### E2 目录结构（可供日后定位）
- 位置：目录，论文 p.1
- 类型：结构记录
- §3 "Proof of Boundedness"（p.10）含 §3.1 `C_i·C_j ≥ 0`、§3.2 Blowdowns and the presence of H-strings、§3.3 SCFTs contained in LST、§3.4 Bound on Tensor multiplets；§4 "Precise bounds on the number of Tensors, Vectors and Hypers"（p.25）含 §4.1 Exact bound on Tensors、§4.2 Exact bound on Vectors（含 §4.2.1 `T=9` with `b_0=0` theories、§4.2.2 `T=0` theories）、§4.3 Exact bound on Neutral hypermultiplets、**§4.4 Swampland Examples**；附录 C "Abelian gauge algebras"。

## 未解决的疑问

1. 正文全部未读。§3 自称 "Proof of Boundedness"，但其依赖的 6d SCFT/LST 分类的严格性等级未核实。
2. **版本陷阱**：取到的是 **v3（2025-06-23）**，摘要里的 `T ≤ 193`/`r(V) ≤ 480`/`491`/`194` 必须写死 v3；v1（2024-11）是否同数未查。
3. bib 条目未登记（本次无内容进图）。
