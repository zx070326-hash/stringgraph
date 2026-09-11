# 页图核对裁决（physics-auditor，2026-09-12）

> 三项页图复核 + 对图的指令。证据等级沿用 `math-sources.md` §0 / `brst-cohomology-sources.md` §0（L1 = 本人读原刊页图）。
> 取件：MRC 1986 全文 PDF（Project Euclid `download/pdf_1/euclid.cmp/1104116024`，3.35 MB，32 页；
> **裸 curl 被 Incapsula 拦，需 Chrome UA + `Accept: application/pdf` + Referer 才放行**）；
> FGZ p.8445 页图（`cdn.ncbi.nlm.nih.gov/pmc/blobs/a950/386946/275fe5e6b989/pnas00326-0018.png`，816×1076）；
> LZ 1989 全文 PDF（同站 `journalArticle/Download?urlId=cmp%2F1104179468`，2.66 MB，36 页，同样需浏览器头，且第一次会被拦、隔几秒重试才成功）。
> 页图用 PyMuPDF 4× 渲染后裁切放大读取（`.claude/worktrees/pagecheck-tmp/`，已 gitignore）。
> 本文件**只追加**；对既有抽取记录的更正以「复核段」形式追加到各自文件末尾，旧行一字不改。

---

## 1. MRC 1986 CMP 107, p.274 eqs (7)–(9) + Prop 3.6 的 p̂ 定义

### 1.1 逐字读数（L1，4× 渲染 + 局部 2× 放大，每处读两遍）

**引出句**（与 §55.3 一致，无更正）：「Let `r, s ∈ ½ℕ`, `r ≦ s`. Set, for 𝔤 = n̂s」

```
h^±_{r,s}(c) = −(1/8)[ (r²+s²)(5−c) ± √(c²−10c+9) (r²−s²) − 8rs − ½ + ½c ]                (7)   [𝔤 = n̂s]
h^±_{r,s}(c) = −(1/8)[ (r²+s²)(5−c) ± √(c²−10c+9) (r²−s²) − 8rs − ½ + ½c ] − 1/16          (7′)  [𝔤 = r̂]
```

「Also, set, for `r ≠ s`, `ψ_{r,s}(h,c) = (h − h⁺_{r,s}(c))(h − h⁻_{r,s}(c))`, and, for 𝔤 = n̂s,
`ψ_{r,r}(h,c) = h + (1/16)(1−c)(4r²−1)`. Let **`p̂(i)`** be as in Proposition 3.6. Then, if 𝔤 = n̂s,」

```
det( , )_{h,c,n}   =  ∏_{2rs ≦ n, r−s ∈ ℤ}      ψ_{r,s}(h,c)^{p̂(n−2rs)} ,  [14]                     (8)
```

「and, for 𝔤 = r̂,」

```
det( , )_{h,c,n,γ} = ( h + c/16 )^{½ p̂(n)}  ∏_{2rs ≦ n, r−s ∈ ½+ℤ}  ψ_{r,s}(h,c)^{p̂(n−2rs)}          (9)
```

「if `n ≧ 0`, and `det( , )_{h,c,0,0̄} = 1`, `det( , )_{h,c,0,1̄} = h + c/16` [7, 8].」
「*Note.* The nonzero constant depending on the choice of a basis of M(V(λ)) has been omitted in (8), (9).」

**对 §55.3 四个待复核点的裁定：**

| §55.3 疑点 | 页图读数 | 裁定 |
|---|---|---|
| (a) (9) 指数上的 `±` | **没有 `±`**。指数是 `½ p̂(n)`，γ = 0̄ / 1̄ 两支同一指数 | §55.3 的 `±(1/2)p̃(n)` 是误读，**删 ±** |
| (b) 两个乘积的指标条件 | (8) `2rs ≦ n, r − s ∈ ℤ`；(9) `2rs ≦ n, r − s ∈ ½ + ℤ` | **与 §55.3 一致** |
| (c) (7) 方括号尾 | `− 8rs − ½ + ½c ]`，(7′) 在方括号外再 `− 1/16` | **与 §55.3 一致** |
| (d) `p̃` 的头 | p.274 全部印 **`p̂`（尖帽）**："Let p̂(i) be as in Proposition 3.6"，(8)(9) 指数亦为 `p̂` | §55.3 写的波浪号 `p̃` **是错的**；`p̃` 是 Prop 3.6 里的另一个函数（见 1.2） |

**「if n ≧ 0」与 n = 0 单列值的张力（新发现，§55 未记）**：页图印的是 `n ≧ 0`，但紧接着单列了 n = 0 的两个值。按 (9) 在 n = 0 处指数为 `½ p̂(0) = ½`（Prop 3.6 给 p̂(0) = 1），非整数，(9) 在 n = 0 **字面上不成立**；故 (9) 的实际适用范围是 **n ≥ 1**，n = 0 由单列值给出。(8) 在 n = 0 时乘积为空、det = 1，与 M^λ = ℂv_λ、(v_λ,v_λ) = 1 一致，无此问题。**建卡时写「(9) 对 n ∈ ℤ, n ≥ 1；n = 0 两值单列」，并在 note 里记原文印 `n ≧ 0`。**

### 1.2 Prop 3.6 的 p̂ / p̃ 定义（p.270–271，L1 逐字）——(8)(9) 的指数由此才可独立解读

p.270 定义段逐字：
> 「We denote by `p(n)` the number of partitions of `n` and by `p(S, n)` the number of partitions of `n` that belong to the subset `S` of the set of all partitions. For a subset `H` of the set of positive integers, we denote by "`H`" the set of all partitions with parts in `H`, and by "`H`"(≦ d) the set of all partitions with parts in `H`, in which no part appears more than `d` times. Let `H₀` (respectively `H₁`) denote the even (respectively odd) positive integers. Finally, let `p_e(𝒟, n)` [respectively `p_o(𝒟, n)`] be the number of partitions of `n` into an even (respectively odd) number of distinct parts, and let `p(𝒟, n)` be the number of partitions of `n` into distinct parts.」

> 「**Proposition 3.6.** *Let* `λ ∈ 𝔥*`,
> `dim M(ℂ(λ))^{λ−nδ} = p̂(n) = p̃(2n)`,   (1)
> *where* `p̃(0) = 1, p̃(s) = Σ_{i=0}^{s} p("H₀", i) p("H₁"(≦1), s−i), s > 0`;
> `dim M(R(λ))^{λ−nδ}_γ = p̂(n)`,   (2)
> *where* `p̂(0) = 1, p̂(n) = Σ_{i=0}^{n} p(i) p(𝒟, n−i), n > 0, γ ∈ ℤ₂`;
> *If* `λ(e₀) = −λ(e₀⁺)/16`, *then* `dim M(S(λ))^{λ−nδ}_γ = ½ p̂(n)` *for* `n > 0`, `p̂(n)` *as in* (2).   (3)」

**读数：**
- **`p̂` 的定义依扇区而异**：NS 用 (1)，`p̂(n) = p̃(2n)`，n ∈ ½ℤ₊（偶数部分任意重数 × 奇数部分不重复 = 玻色 L 模 × 费米 G 模，2n 是加倍后的整数级）；R 用 (2)，`p̂(n) = Σ p(i) p(𝒟, n−i)`，n ∈ ℤ₊，是**每个 γ 分量**的维数（R(λ) 二维，两分量各得 p̂(n)）。
- **(3) 直接解释 (9) 的指数 `½ p̂(n)`**：h = −c/16 时 R(λ) 的一维商 S(λ) 生成半 Verma 模，每个 γ 分量维数 `½ p̂(n)`。p.283 Prop 4.10 证明里也逐字说「the number of such `e_I v_λ` is equal to the number of such `e_K e₀⁻ v_λ` and is equal ½ p̂(n)」——`(h + c/16)` 因子来自含 `e₀⁻` 的那一半基，故指数 `½ p̂(n)`，两个 γ 相同，**无 ±**。
- **`ℕ` 不含 0**（解读，非原文明写）：若允许 r = 0，则 (8)(9) 对一切 n 都会多出 `ψ_{0,s}^{p̂(n)}` 的伪因子，且 Prop 4.10 的 `d̂(0) = #{(r,s) | 2rs = 0}` 为无穷。反面校验：n = ½ 时 (8) 只有 (r,s) = (½,½)，det = ψ_{½,½} = h，与 Prop 3.6 给的 dim = p̃(1) = 1 及 (G_{−½}v, G_{−½}v) ∝ h 一致。

### 1.3 证明的位置（L1，Sect. 4）

- **Proposition 4.10**（p.283）逐字：「*For* `i ∈ ½ℕ`, *set* `d̂(i) = #{(r,s) | 2rs = i, r,s ∈ ½ℕ, r − s ∈ ℤ}` *if* 𝔤 = n̂s, *and* `d̂(i) = #{(r,s) | 2rs = i, r,s ∈ ½ℕ, r − s ∈ ½ + ℤ}` *if* 𝔤 = r̂. *Then* (1) `h-deg det( , )_{h,c,n} = Σ_{i ∈ ½ℕ, i ≦ n} p̂(n−i) d̂(i)` *if* 𝔤 = n̂s; (2) `h-deg det( , )_{h,c,n,γ} = ½ p̂(n) + Σ_{i=1}^{n} p̂(n−i) d̂(i)` *if* 𝔤 = r̂.」（d̂ 数**有序对**，不带 r ≦ s，与 ψ_{r,s}（r<s）h-次数 2、ψ_{r,r} 次数 1 相符。）
- **Proposition 4.13**（p.286）逐字：「*Let* `h, c ∈ ℂ, γ ∈ ℤ₂`. *Let* `r, s ∈ ½ℕ, r ≦ s`, *and* `r − s ∈ ℤ` *if* 𝔤 = n̂s, `r − s ∈ ½ + ℤ` *if* 𝔤 = r̂. *Then* `det( , )_{h,c,2rs,γ}` *vanishes on* `𝒱_{r,s}`. *Furthermore, if* 𝔤 = r̂, `n ∈ ℤ₊`, *then* `det( , )_{h,c,n,γ}` *vanishes on* `𝒱_{0,0}`.」
- **「Proof of the Determinant Formulas」**（pp.286–287，无编号段）：对 n 归纳，末句逐字「This, (38) and Proposition 13 show that `ψ_{r,s}(h,c)^{p̂(n−2rs)}` divides `det( , )_{h,c,n,γ}`. The degree computation of Proposition 4.10 gives (8) and (9). Q.E.D.」——**注意原文印 "Proposition 13"，是 "Proposition 4.13" 的漏号**；引用时写 4.13 并注明。
- ⇒ §55.8 的 **Q55.1、Q55.2 结清；Q55.3 结清**（Prop 4.10 / 4.13 逐字已取）。Q55.4–Q55.6 不在本轮范围。

### 1.4 内部一致性校验（**auditor 自算，非原文**）

- (7) 在 r = s 处：`h_{r,r} = −(1/8)[2r²(5−c) − 8r² − ½ + ½c] = −(1/16)(1−c)(4r²−1)`，故 `h − h_{r,r} = h + (1/16)(1−c)(4r²−1) = ψ_{r,r}` ✓——(7) 的方括号尾 `− ½ + ½c` 与 ψ_{r,r} 的单独定义**互相锁定**，转录可信。
- (9) 里 r − s ∈ ½+ℤ 保证 r ≠ s，故 R 扇区不需要 ψ_{r,r}，与「ψ_{r,r} 只对 n̂s 定义」相符 ✓。
- **与主流 c/12 归一化的字典（inferred，建卡时须标 `inferred: true`）**：由 p.263 括号（`[L_i,L_j] = (j−i)L_{i+j} + δ (i³−i)/8 L′₀`，`[G_i,G_j] = −2L_{i+j} + δ ½(i²−¼)L′₀`）与标准 `[L_m,L_n] = (m−n)L + (c/12)(m³−m)δ`、`{G_r,G_s} = 2L + (c/3)(r²−¼)δ` 比对：`L^{MRC}_i = −L^{std}_i`，`G^{MRC} = G^{std}`，**`c^{MRC} = (2/3) c^{std}`**，且（若 e₀⁺ = L₀^{MRC}）**`h^{MRC} = −h^{std}`**，`(r,s)^{MRC} = ½ (r,s)^{std}`。四条独立校验：(i) [L,L] 与 [G,G] 两条中心项都给 L′₀ = (2/3)c；(ii) 判别式 `c²−10c+9 = (c−1)(c−9)` 的分支点 c^{MRC} = 1, 9 ↔ c^{std} = 3/2, 27/2 ✓；(iii) c^{MRC} = 1 时 (7) 给 `h^{MRC}_{r,s} = −(r−s)²/2`，标准 NS 公式 m → ∞ 极限给 `h^{std} = (r_std − s_std)²/8 = (r−s)²/2` ✓（反向字典 `L^M_i = L^s_{−i}`, `h^M = h^s`, `c^M = −(2/3)c^s` 在此校验下 ✗）；(iv) R 因子 `h^M + c^M/16 = −(h^{std} − c^{std}/24)` ✓。⚠ **Sect. 2 对 e₀^± 的定义本轮未读**，`h = λ(e₀⁺)` 与 L₀ 的关系只由 (iii)(iv) 间接支撑。

### 1.5 裁定：**NS/R 扇区 Kac 行列式公式可建卡**

- **loc**：`Sect. 3, eqs. (7)–(9), p. 274`（陈述，无定理号）；`Proposition 3.6, p. 270, eqs. (1)–(3)`（p̂ 定义）；证明 `Proposition 4.10, p. 283` + `Proposition 4.13, p. 286` + `"Proof of the Determinant Formulas", pp. 286–287`。ref `meurman-rocha-caridi-1986`。
- **statement 必须含**：r, s ∈ ½ℕ（ℕ ∌ 0，注明是解读）、r ≦ s；NS：n ∈ ½ℤ₊、r − s ∈ ℤ、指数 p̂(n−2rs) = p̃(2(n−2rs))；R：γ ∈ ℤ₂、n ≥ 1、r − s ∈ ½+ℤ、前因子 `(h + c/16)^{½ p̂(n)}`（**无 ±**）、n = 0 两值单列；「等式相差一个依基底选择的非零常数」（Note 逐字，**不得写 α_N**）。
- **约定**：用 MRC 自己的变量（h = λ(e₀⁺), c = λ(e₀′)，p.263 括号），字典按 1.4 标 inferred；**不得**直接套本图 `worldsheet.kac-determinant-v2` 的 c/12 变量。
- **status**：`rigorous`（Sect. 4 印出完整证明）。
- **对图的指令**：
  1. 建 `worldsheet.super-virasoro-kac-determinant`（NS/R 两扇区一卡或两卡均可，但 p̂ 的两个定义要分开写）。
  2. `graph/derivations/worldsheet/rns-fock-module-free-over-negative-super-virasoro--via-lian-zuckerman-1989.yaml` gaps 第一条 (a) 的「(9) 式的 ± 与指标条件待 auditor 页图复核」**可关**；建卡后把 [22] 那条边接上。该 gap 的 (b)(c)(d) 不受本轮影响。
  3. `literature/extractions/math-sources.md` §55.3 的 `p̃`、`±(1/2)p̃(n)` 两处读数**作废**，以本文件 1.1 为准（复核段已追加到该文件末尾）。
