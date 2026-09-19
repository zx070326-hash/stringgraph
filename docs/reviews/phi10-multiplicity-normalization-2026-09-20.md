# 规范化备忘：Φ₁₀ 零点重数订正的 v2 卡文本与重定向计划

**作者**：physics-auditor，2026-09-20
**依据裁决见**：`docs/reviews/phi10-zero-multiplicity-defect-2026-09-20.md`
（该文件已追加我的裁决小节；本文件只写落地方案，不重复取证与裁决理由）

**授权范围提醒**：本文件只出**规范表述**与**计划**，不落地。v2 卡的实际创建（新建
`graph/statements/holography/igusa-cusp-form-phi10-v2.yaml`、
`graph/statements/holography/phi10-wall-crossing-poles-v2.yaml`，
旧卡加 `superseded_by`，以及本文件第 3 节列出的依赖边重定向）由 lead 另派 curator 执行。

---

## 0. 裁决结论摘要（完整论证见另一份缺陷报告的裁决小节）

1. **Φ₁₀ 零点重数为 2（二重零点），不是 1**。三条独立证据一致：GN1996 代数恒等式
   Div(Φ₁₀)=2·Div(Δ₅)=2H₁、Sen 2008 (C.25)/(C.26) 独立物理推导给出 v² 阶零点、
   本项目内 `holography.dvv-wall-crossing-identification` 的 Δd∝Q·P 公式经 Laurent
   级数留数计算独立核验只与二重极点自洽（简单极点给出 Res=f(0) 是常数，二重极点给出
   Res=f'(0)，对指数核 f(w)=e^{-2πi(Q·P)w} 恰好线性正比 Q·P）。**判定：wrong**（该分句
   断言了与已登记一手来源矛盾的事实）。
2. **Sp(4,ℤ)-轨道是否覆盖 n2≠0 的二次壁分支：证据不足以判定**。不强判"覆盖"也不强判
   "不覆盖"。建议现有措辞维持不变，v2 卡 notes 追加开放性说明。
3. **额外发现（原缺陷报告未列出）**：`graph/derivations/holography/phi10-wall-crossing-poles--via-siegel-modular-analysis.yaml`
   本身在 `summary` 字段里也写了"单零点"（"Borcherds 乘积公式直接给出零点超曲面
   {mρ+nσ+lv∈ℤ，4mn−l²=1}（单零点）"），且其第 2 步的留数论证语言
   （"Res_{ρ=0}(1/Φ₁₀) 由 Φ₁₀ 对 ρ 的首阶系数给出"）隐含**简单极点**的 Laurent 系数
   逻辑，与订正后的二重极点结构不自洽——这是本备忘新增的**第四处**错误位置，原缺陷报告
   的"三处"清单未列入。此卡是 `graph/derivations/**`，不在我的写入范围，转交 curator。

---

## 1. 两张卡 v2 的逐字规范 statement 文本

### 1.1 `holography.igusa-cusp-form-phi10-v2`

只改最后一句（重数），其余原文不变（definition 卡，唯一性、Borcherds 公式等其余内容
未受影响，无需改动）。**建议整卡 `statement` 字段**：

```
Igusa 尖点形式 Φ₁₀(Ω) 是 Sp(4,ℤ)（整 Siegel 模群）的权 10 尖点形式，其中
Ω = [[ρ, v], [v, σ]] 为 Siegel 上半空间（度 2）中的变量（ρ,σ ∈ ℍ，v ∈ ℂ，Im Ω > 0）。
它由 Borcherds 升举公式给出：
  Φ₁₀(Ω) = e^{2πi(ρ+σ+v)} ∏_{(m,n,l)>0} (1 − e^{2πi(mρ+nσ+lv)})^{c(4mn−l²)}，
其中 c(k) 为 K3 椭圆亏格 χ_{K3}(τ,z)（权 0 指标 1 弱 Jacobi 形式，满足 c(k)=24 对 k=0，
c(k)=EG K3 系数，c(k)=0 对 k<−1）的傅里叶系数，排列顺序 (m,n,l)>0 指：
m>0；或 m=0, n>0；或 m=n=0, l<0。
Φ₁₀ 在 Sp(4,ℤ) 权 10 尖点形式空间中（至多差标量倍数意义下）唯一；
其零点除子（在 Siegel 上半空间中）位于超曲面 {mρ + nσ + lv ∈ ℤ，4mn−l²=1} 的
Sp(4,ℤ)-轨道上（即判别式 1 的 Humbert 曲面 H₁），沿该轨道为**二重**零点：
Div(Φ₁₀) = 2H₁。
```

**必须新增的 `sources` 条目**（重数句的直接依据，原卡缺失）：

```yaml
  - ref: gritsenko-nikulin-1996
    loc: "p.7（环生成元列表，χ₁₀=Φ₁₀=Δ₅² 恒等式）+ 正文几何结果段（Div(Δ₅)=H₁，
          判别式1 Humbert 曲面 H₁={z₂=0}）；重数 2 由 Div(Φ₁₀)=Div(Δ₅²)=2·Div(Δ₅)=2H₁
          直接代数推出。见 literature/sources.bib gritsenko-nikulin-1996 条目 note，
          抽取记录 extractions/gritsenko-nikulin-1996-phi10.md（H1–H7）。"
  - ref: sen-2008-precision-counting
    loc: "arXiv:0708.1270v4 Appendix C, (C.25)/(C.26)：Φ̂(ρ,σ,v)=−4π²v²g(ρ)g(σ)+O(v⁴)——
          v=0（Humbert 面 H₁）附近显式 v² 阶零点，独立物理 threshold-integral 推导，
          非引用 GN，仅作交叉验证（本项目 note 明确标注'非引用 GN'）。"
```

**notes 建议追加一段**（对应本备忘 §0.2 的开放性说明）：

```
【重数订正与开放性说明，physics-auditor 2026-09-20，见
docs/reviews/phi10-zero-multiplicity-defect-2026-09-20.md 与
docs/reviews/phi10-multiplicity-normalization-2026-09-20.md】
本卡是 holography.igusa-cusp-form-phi10 的 v2：唯一实质改动是把重数从
"单零点"订正为"二重零点"（Div(Φ₁₀)=2H₁），依据见上方 sources。
【未解决，明确留白】"Sp(4,ℤ)-轨道覆盖整个 Div(Φ₁₀)"这一描述沿用自旧卡与经典文献语言
（GN1996 式的 Humbert 曲面构造），但 Sen 2008 (D.19) 给出的更一般五参数
(m1,n1,m2,n2,j) 零点参数化中 n2≠0 的"二次壁"分支是否确实落在同一条
{mρ+nσ+lv∈ℤ}-型线性代表元的 Sp(4,ℤ)-轨道内，本项目审计认为**证据不足以判定**
（既非 GN1996 明确证实，也未被本项目自己已审查的
research/attempts/gap-102b-route-a/ 证明——该 attempt 把 n2≠0 明确列为未闭合的
[GAP-n2]）。本卡措辞维持"Sp(4,ℤ)-轨道"这一标准提法不变，但读者应知晓覆盖性本身
是开放问题，非本卡断言的一部分。
```

### 1.2 `holography.phi10-wall-crossing-poles-v2`

只改 (a) 中判别式后半句；(b)(c) 内容不变（(b) 的具体表达式本身已在旧卡 notes 里被标注
"需对照原文核实"，其留数语言与二重极点的不自洽属于**另一处需要 curator 单独处理的
遗留问题**，见 §2 末尾说明，本次不强行改写 (b)，避免在缺乏原文核实的情况下杜撰新公式）。

**建议整卡 `statement` 字段**：

```
Igusa 尖点形式 Φ₁₀(ρ,σ,v) 在 Siegel 上半空间中的零点（即 1/Φ₁₀ 的极点）满足：
(a) 极点位于超平面族 {mρ + nσ + lv ≡ 0 (mod ℤ)} 的 Sp(4,ℤ)-轨道上，
    其中 (m,n,l) ∈ ℤ³，gcd(m,n,l)=1，判别式 4mn−l²=1；沿该轨道 Φ₁₀ 为**二重**零点，
    故 1/Φ₁₀ 在此处为**二阶极点**（非单极点）；
(b) 在 {ρ=0} 超平面（标准代表元）附近，留数因子化为
      Res_{ρ=0} (1/Φ₁₀) = f(σ,v) · g(σ,v)，
    其中 f, g 是各自对应两个 1/2-BPS 子系统的权 −2 椭圆亏格函数（Jacobi 形式），
    即 1/(η(σ)²⁴ · φ_{0,1}(σ,v)) 型结构（具体形式待原文核实，见来源注记）；
(c) 系数跳变（围道穿越极点）= 两个留数因子乘积，与两个半-BPS 简并度之积一致
    （识别②的数学前提，但识别本身是 physical-argument）。
```

**必须新增的 `sources` 条目**：同 §1.1 的 gritsenko-nikulin-1996 + sen-2008-precision-counting
两条（本卡是姐妹卡，重数依据相同）。

**notes 必须追加的警告段**（这是本备忘发现的额外问题，不能省略）：

```
【二阶极点与 (b) 的内部不自洽，physics-auditor 2026-09-20 发现，留给 curator 处理，
不在本轮授权范围内改写】(a) 订正为二阶极点后，(b) 的表达式
"Res_{ρ=0}(1/Φ₁₀) = f(σ,v)·g(σ,v)" 字面上是**简单极点**的留数写法（单个乘积，
无导数项）。对二阶极点 1/(w²h(Ω)) 的标准 Laurent 展开，"留数"（围道跳变系数）一般
应包含 h 的一阶导数项（∝ ∂_w，对应对偶方向的线性因子），而不是单纯的乘积
f(σ,v)·g(σ,v)。本卡旧版 notes 已自行标注"(b) 中的精确表达式需对照原文核实……具体
椭圆亏格函数可能有不同的归一化约定"，本次订正只是让这处已知不确定性变得更加突出：
(a)(b) 现在字面上互相矛盾（二阶极点 vs 简单极点留数公式），需要 curator 回 DVV 1997 §4
或 Sen 2007 §2 原文逐字核对 (b) 的精确形式后再定 v3（或在 v2 落地时一并处理，不要
只做 s/单零点/二重零点/ 式的文字替换）。这是本备忘除重数本身外的第二个必须传达给
curator 的事实性问题。
```

---

## 2. 17 个引用 `igusa-cusp-form-phi10` 的文件：逐个重定向判据

**判据**：该引用的论证是否**实际用到**了"重数=1 还是=2"这一具体数值（而不仅是
Φ₁₀ 的存在性/唯一性/Sp(4,ℤ) 模性/偶权/Fourier 展开在有理格点等与重数无关的性质）。

### 必须优先重定向到 v2（3 个，内容依赖重数/极点阶数）

| 文件 | 理由 |
|---|---|
| `graph/statements/holography/dvv-wall-crossing-identification.yaml` | 自身 `statement` 内嵌 Δd=(−1)^{Q·P+1}(Q·P)·d_{1/2}·d_{1/2} 公式，其线性 Q·P 因子的数学根据正是二阶极点的留数导数项（见 §0.3 论证），且 `uses` 直接列出两张旧卡 |
| `graph/derivations/holography/dvv-wall-crossing-identification--via-sen-denef-moore.yaml` | 同上卡的推导节点，`summary` 明确写"从 phi10-wall-crossing-poles（严格复分析）已知 1/Φ₁₀ 有留数因子化"，`depends_on` 两张旧卡 |
| `graph/derivations/holography/phi10-wall-crossing-poles--via-siegel-modular-analysis.yaml` | **本身就是 phi10-wall-crossing-poles 的现有推导**，target 字段随主卡换代必须重新指向 v2；且其 summary 自身写着"单零点"与简单极点留数逻辑，需要连同 §1.2 提到的 (b) 问题一并重写，不是简单改指针 |

### 可以暂留 v1（9 个，只用到 Φ₁₀ 的存在性/模性/偶权/Fourier 展开，与重数无关）

| 文件 | 用到的性质 |
|---|---|
| `graph/statements/holography/torsion-index-divisor-operator.yaml` | 𝒢:=−1/Φ₁₀(ρ,σ,v+1/2) 的定义，只用 Φ₁₀ 本身的存在与 Fourier 结构 |
| `graph/derivations/holography/attractor-contour-covariance--via-adjoint-covariance.yaml` | 周期性 F(Ω+S)=F(Ω) 来自"Fourier 展开只含半整 T"，与重数无关 |
| `graph/derivations/holography/dgm-torsion-divisor-sum--via-dgm-duality-argument.yaml` | 重标 ρ→s²ρ,v→sv 的合法性依赖 Sp(4,ℤ) 模性，非重数 |
| `graph/derivations/holography/dstar-sduality-invariant--via-contour-covariance.yaml` | GL(2,ℤ) 不变性依赖 Sp(4,ℤ) 模性 + 偶权，非重数 |
| `graph/derivations/holography/mock-jacobi-coefficient-positivity--via-bringmann-murthy-rossello.yaml` | 推广步依赖"Φ₁₀ 属于 Sp(4,ℤ) 权 10 尖点形式"+"偶权"，非重数 |
| `graph/derivations/holography/dmz-mock-jacobi-decomposition--via-dmz-theorem.yaml` | "Φ₁₀ 的极点结构"仅指极点在有理格点这一定位信息，DMZ 分解定理的假设是阶数≤2（已容纳二重），不依赖具体数值 |
| `graph/statements/holography/dmz-mock-jacobi-decomposition.yaml` | 同上；本卡自身 `statement` 已写"阶数 ≤ 2"，本就与二重极点相容，无需改 |
| `graph/statements/holography/dvv-dyon-index-generating-function.yaml` | DVV 识别①，只用 1/Φ₁₀ 的 Fourier 展开存在性，不涉及重数 |
| `graph/derivations/holography/dvv-dyon-index-generating-function--via-dvv-proposal.yaml` | 同上 |

### 无正式图边、只是文本提及冲突的（2 个，无需重定向）

| 文件 | 说明 |
|---|---|
| `graph/statements/holography/attractor-contour-hits-phi10-zero-at-ell-zero.yaml` | `uses: []`；notes 里主动讨论了与旧卡的冲突并刻意不接边，避免继承错误重数——这是正确做法，**建议 curator 在 v2 落地后把 notes 里"两张已有卡与本卡引用的 GN1996/Sen 2008 在零点重数上直接冲突"这句改为"已订正为一致"**，但这是文字维护，不紧急 |
| `graph/statements/holography/attractor-contour-avoids-phi10-linear-wall.yaml` | 同上，`uses: []`，notes 讨论冲突但未接边 |

**总计**：3 必须 + 9 可留 + 2 无边 = 14（third-party 引用文件数）+ 2 张自身被替换的旧卡
+ 1 个我已处理的里程碑 = 17，与缺陷报告统计一致。

---

## 3. 下游物理结论是否需要改动：核实结果

**核实：不需要改动，lead 的判断成立。** 具体证据：

1. `holography.dmz-mock-jacobi-decomposition.yaml` 的 `statement` 字段本身已把 DMZ
   分解定理的假设写成"极点仅在 z∈ℚτ+ℚ 处……**阶数 ≤ 2**"——这不是本次订正新加的话，
   是该卡原有文本，说明当初立卡时就已经预留了二阶极点的可能性，与现在订正后的
   "Φ₁₀ 为二重零点"完全相容，无需改动。
2. `holography.dvv-wall-crossing-identification.yaml` 的 Δd 公式（线性正比 Q·P）本来就
   只和二阶极点自洽（见 §0.3），说明这条物理公式从写下的那一刻起事实上就是"按二重极点"
   的隐含假设写的，只是没人把这个假设显式写成"Φ₁₀ 是二重零点"，现在补上因果链条，
   结论数值不变。
3. `holography.mock-jacobi-coefficient-positivity` 及其依赖的 Rosselló 2024 / Bringmann-Murthy 2012
   两篇原始文献本身对 Φ₁₀ 极点结构的处理来自它们自己（原始论文正确知道是二重极点/权 −10
   的模性），图内只是转述其正性结论数值，不受本项目图层这处笔误影响。

**结论**：需要改的只是"为什么"这一层的因果链上游断言（Φ₁₀ 重数 1→2）和它的两个直接
消费者（wall-crossing identification 一支），末端数值结论（黑洞熵计数公式、mock Jacobi
正性定理的数值断言）全部不变。
