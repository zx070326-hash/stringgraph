# scripts/ — 本 attempt 的辅助脚本

两个脚本，互不依赖。

## `extract_pdf.py` — PDF 逐页抽文本 + 渲染

**为什么不用 `pdftotext`**：本项目既往判例——`pdftotext` 曾吞掉 `e^α` 因子并把 `∆` 印成 `ψ`。
本项目纪律是 **PDF 一律用 PyMuPDF**，且任何承载裁定的公式还要用 `Read` 打开**渲染图**二次核对。

做两件事：`page.get_text("text", sort=True)` → `page-NN.txt`；`page.get_pixmap(dpi=200)` → `page-NN.png`。

```bash
cd "D:/physics/string"
uv run --with pymupdf python research/attempts/borcherds-rank-one-noghost/scripts/extract_pdf.py \
    <input.pdf> <outdir>
```

本轮用的输入是 Borcherds 主页重排本 `https://math.berkeley.edu/~reb/papers/monster/monster.pdf`
（41 页；§3 在 p.12–13，§5 在 p.19–21）。
**⚠ 重排本页码 ≠ 期刊页 405–444**；页码只用于抽取记录内部定位，图节点 `loc:` 一律写节号/定理号。

抽出来的逐字内容已写进 `literature/extractions/borcherds-1992.md` 的追加节 E4–E8
（含文本层压平上下标的已知失真与按渲染图还原的对照表）。

## `slice_dims.py` — 核验 `scoping.md` §5.4 的反例

纯标准库（`fractions`），**精确有理数**，无第三方依赖、无数值近似。

```bash
cd "D:/physics/string"
PYTHONIOENCODING=utf-8 uv run python research/attempts/borcherds-rank-one-noghost/scripts/slice_dims.py
```

（Windows 上不加 `PYTHONIOENCODING=utf-8` 会因 GBK 控制台编码在打印 `a₀` 时报
`UnicodeEncodeError`；脚本本身与编码无关。）

核验的对象是动量塔的**一个双分次片** `(rung, level) = (−1, 1)`，在这片上
`H_phys`、`D(Ε)`、`H_null` 三者都退化成 `R^D` 的子空间，可以显式写出矩阵：

- `H_phys ∩ 片 ≅ v^⊥`（`v := a − b`），维数 `D−1`；
- `D(Ε) ∩ 片 ≅ span(Ε)`，维数 `D−2`（**这个上界无条件**：落在该片的 DDF 单项式只能是单个
  `A^{ε_i}_{−1}`，共 `D−2` 个，与 `A^ε_n` 的具体展开无关）；
- `H_null ∩ 片 ≅ rad(η|_{v^⊥}) = v^⊥ ∩ Rv`，即 `η(v,v) = 2(a₀−1) = 0` 时为 1 维、否则为 0。

输出逐例覆盖 `D ∈ {3, 4, 26}` × `a₀ ∈ {1, 2, 3}`，外加 `scoping.md` §5.4 逐字写出的那组数，
以及 §5.4 末尾「前件 (C) ⟹ `a₀ = 1`」的逐例核验。所有断言内嵌在脚本里（`assert`），
非零退出即核验失败。

结论：`a₀ = 1` 时 `D−1 = (D−2) + 1` 恰好平衡；`a₀ ≠ 1` 时零态维数掉到 0，
`D−1 > D−2`，`worldsheet.ddf-spanning-hypothesis` 按字面为假。
