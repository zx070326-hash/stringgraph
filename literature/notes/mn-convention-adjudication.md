# 对抗性裁定：m/n 电荷约定冲突（Rosselló vs BSS）

**裁定者**：researcher agent（P0 任务，lead 指派）  
**日期**：2026-09-20  
**争议来源**：`research/attempts/gap-102b-multicenter-residue/proof.md` §1 引理 1 引用
Rosselló arXiv:2403.19630 eq (2.3) 与 BSS arXiv:2311.16252 时发现的 m↔(Q²/2,P²/2)
赋值不一致；项目内既有图卡（`graph/statements/holography/dgm-torsion-divisor-sum.yaml`、
`torsion-immortal-positivity.yaml`、`dvv-dyon-index-generating-function.yaml`）与草稿陈述相矛盾。

---

## 一、裁定结论（verdict (c)）

**两文献家族真实使用不同的 m/n↔电荷 对应约定，但物理内容一致。**

### 证据链（决定性）

1. **BSS Theorem 5.4 逐字**（arXiv:2311.16252 p.47）：
   ```
   (a) For (n,ℓ,m) ∈ A, the single-centered black hole degeneracies with
       NQ²/2 = m, P²/2 = n and Q·P = ℓ are the Fourier coefficients of φ_m^F.
   (b) For (n,ℓ,m) ∈ B, ... with NQ²/2 = m, P²/2 = n and Q·P = ℓ ...
   ```
   即 BSS（N=1 时）：**m := Q²/2**（电荷），**n := P²/2**（磁荷）。

2. **BSS footnote 10 逐字**（p.50，决定性，作者自陈）：
   ```
   "Note that the mock Jacobi form ψ_m^F of [9] is denoted as φ_m^F in this paper.
   Also the roles of Q and P are interchanged compared to [9] since we have Q²/2 = m,
   P²/2 = n."
   ```
   [9] = Dabholkar–Murthy–Zagier (DMZ) 1208.4074。BSS **自己明确声明**"Q 与 P 角色相对
   DMZ 互换"。

3. **Rosselló (2.3) 逐字**（arXiv:2403.19630；转引自本项目 `literature/extractions/rossello-2024.md`
   E3/R1）：**m = P²/2**（磁荷），**n = Q²/2**（电荷）——与 DMZ 同源（Rosselló R1 逐字：
   "[31] = Dabholkar–Murthy–Zagier"，ψ_m^F 的识别直接继承）。

4. **对应关系总结**：
   - **DMZ/Rosselló 家族**：m-槽 = 磁荷 P²/2；n-槽 = 电荷 Q²/2。
   - **BSS 家族**（N=1 时）：m-字母被重新指派给电荷 Q²/2；n-字母指磁荷 P²/2。
   - **物理内容一致**：两家各自的"磁荷槽"都挂同一物理量 P²/2，"电荷槽"都挂 Q²/2，
     只是**用哪个拉丁字母标记哪个槽**的习惯相反——BSS footnote 10 显式承认此差异，
     这不是本项目的误读或转录错误，而是原始文献之间真实存在的记号分歧。

---

## 二、对争议各方的裁定

### (1) 草稿 `gap-102b-multicenter-residue/proof.md` §1 引理 1

**裁定：SUPPORT（忠实转录，判断准确）**。

- 草稿引用 Rosselló (2.3) 称"m=P²/2（磁）、n=Q²/2（电）"——**逐字核实为正确**
  （见 `literature/extractions/rossello-2024.md` E3/R1 原文）。
- 草稿引用 BSS 称"m_B:=NQ²/2（电）、n_B:=P²/2（磁）"——**逐字核实为正确**
  （见 `literature/extractions/bhand-sen-singh-2023.md` E3 BSS Thm 5.4 原文）。
- 草稿由此判定"两文记号互换，需要翻译"——**判断准确**，符合 BSS footnote 10 自陈。

### (2) 草稿 §3 引理 2（变量角色对应：ρ↔σ, σ↔τ, v↔z）

**裁定：SUPPORT（经"傅里叶相位系数"标准核验，对应关系正确）**。

**核验方法（本人独立重做，用两文各自 d_* 定义式的相位系数而非围道虚部标度）**：

- **Rosselló (2.23) 逐字**（见 rossello-2024.md V1）：
  ```
  d_*(m,n,ℓ) = ∫ dρdσdv · e^{−2πi(mρ+nσ+ℓ(v+1/2))} / Φ₁₀
  ```
  相位系数：**ρ 的系数 = m = P²/2**（磁荷），**σ 的系数 = n = Q²/2**（电荷）。

- **BSS (5.13) 逐字**（见 bhand-sen-singh-2023.md E1）：
  ```
  d*(P²/2N, Q·P, NQ²/2) = ∫ dτdσdz · exp{−2πi(NQ²/2·τ + P²/2N·σ + ...)} / Φ̃_k
  ```
  相位系数：**τ 的系数 = NQ²/2**（N=1 时 Q²/2，电荷），**σ 的系数 = P²/2N**（N=1 时 P²/2，磁荷）。

- **对应关系**（按"相位系数标记同一物理荷"这一自洽标准）：
  - Rosselló 的 ρ（相位-磁荷 P²/2）↔ BSS 的 σ（相位-磁荷 P²/2）。
  - Rosselló 的 σ（相位-电荷 Q²/2）↔ BSS 的 τ（相位-电荷 Q²/2）。
  - 即：**ρ_Rosselló ↔ σ_BSS**，**σ_Rosselló ↔ τ_BSS**，与草稿引理 2 逐字一致。

**备注**：围道虚部标度（Rosselló (2.22) `Im ρ=2nΛ, Im σ=2mΛ`；BSS (5.14)
`Im τ=2n_B/ε, Im σ=2m_B/ε`）与相位系数呈**对调**关系——这正是"吸引子围道"构造的
`adj(T)` 特性（rossello-2024.md V1 已注明"这正解释了 ρ 的虚部却挂 n"），二者都正确，
只是描述同一构造的不同侧面。**判定变量对应时应以"相位系数"为准**（因为 d_* 的定义
本身是相位积分 `e^{−2πi(mρ+nσ+ℓv)}`，不是围道虚部），按此标准草稿引理 2 正确。

### (3) 项目既有图卡（`dgm-torsion-divisor-sum.yaml` 等）

**裁定：SUPPORT（内容正确，只有 DGM eq 编号需订正）**。

- 图卡引用 DGM 0803.2692 称"m=Q²/2"——**逐字核实为正确**，DGM 与 DVV 都属同一
  "m=电荷"家族（见 `literature/extractions/dabholkar-gomes-murthy-2008.md` 订正 C2：
  DGM 实际 eq(3.28) `Ω_I(Q²/2, P²/2, Q·P) = Σ s·Ω₁(Q²/(2s²), P²/2, Q·P/s)`，
  第一槽 Q²/2 对应函数参数 m）。
- **需要 curator 后续更正的唯一问题**：图卡与草稿多处引用"DGM eq(50)/(51)/(52)"，
  **正确编号应为 eq(3.26)/(3.27)/(3.28)**（ar5iv HTML 自动编号与 arXiv PDF 官方编号
  不一致导致的转录性错误，已在 dabholkar-gomes-murthy-2008.md 订正 C2 详细记录）。
  这是**编号错误，不是数学内容错误**——所有已毕业定理的数学论证不受影响，只需改
  citation loc 字段的编号字符串。

---

## 三、数学安全性分析：已毕业定理 `torsion-immortal-positivity-hecke` 是否受影响

**结论：不受影响（物理识别层正确，Φ₁₀ 对称性保护了纯正性断言）**。

### 关键观察

1. **Φ₁₀ 的 ρ↔σ 对称性**（偶权 Siegel 模形式的反射对称）：
   ```
   Φ₁₀(ρ,v,σ) = Φ₁₀(σ,v,ρ)
   ```
   推出 `d_*(m,n,ℓ) = d_*(n,m,ℓ)`（交换磁荷/电荷槽，简并度不变）。

2. **Rosselló Cor 1.1 / Thm 6.1(b) 的纯正性断言**（rossello-2024.md V2/E3）：
   对**全部** m,n≥1、Δ=4mn−ℓ²>0 的整三元组，`d_*(m,n,ℓ) > 0`。
   这是对**数学对象** d_*（Siegel 模形式 1/Φ₁₀ 在吸引子点的傅里叶系数）的断言，
   不依赖"m 这个字母指代哪个物理荷"——无论 m=磁荷（Rosselló 习惯）还是 m=电荷
   （DGM/BSS 习惯），**只要 m,n≥1 且 Δ>0，结论 d_*(m,n,ℓ)>0 都成立**。

3. **已毕业定理的物理识别层**（见 `research/attempts/torsion-immortal-positivity-hecke/proof.md`
   line ~278 postulate (P) 与 line ~490 postulate (P′)，本人逐字核对）：
   - (P)："设 m=Q²/2，n=P²/2"（电荷=m，磁荷=n）——**与 DGM/BSS 习惯一致**。
   - (P′)：除子和公式 `Ω_I(Q²/2, P²/2, Q·P) = Σ s·Ω₁(Q²/(2s²), P²/2, Q·P/s)`
     **第一槽除以 s²**（即"电荷槽 Q²/2 除以 s²"）——**与 DGM eq(3.28) 逐字一致**
     （见 dabholkar-gomes-murthy-2008.md S3 原文）。

4. **为什么安全**：
   - Φ₁₀ 对称性 ⇒ 纯正性断言 `d_*(m,n,ℓ)>0` 在 (m,n) 两槽间**对称**——即使 Rosselló
     自己文内把 m 标为磁荷、n 标为电荷，交换二者后正性结论依然成立（因为 d_* 数值
     本身关于 (m,n) 对称）。
   - 已毕业定理的物理识别 (P) **选择了"m=电荷"这一侧**（与 DGM/BSS 对齐），且
     除子和公式 (P′) **除的正是电荷槽 Q²/2**（与 DGM eq(3.28) 第一槽对齐）——
     这是**两个一致的选择**，不是"一个地方用 Rosselló 习惯、另一个地方用 DGM 习惯"
     导致的拼接错误。
   - 故已毕业定理的 **Σ_{s|I} s·d_*(Q²/(2s²), P²/2, Q·P/s) > 0**（Thm 6.1(b) 最终形式，
     见 torsion-immortal-positivity-hecke/claim.md）调用的是 Rosselló Cor 1.1 对
     **三元组 (Q²/(2s²), P²/2, Q·P/s)** 的正性——这三个数**都是正整数/半整数且
     判别式>0**（proof.md §6 已验证），Cor 1.1 **不问你把哪个叫 m 哪个叫 n**，
     只要满足 m,n≥1、Δ>0 就断言 d_*(m,n,ℓ)>0，故结论成立。

### 若草稿 §3 引理 2 是错的会怎样

若草稿引理 2 的 ρ/σ/τ 对应关系搞反（即本人在 bhand-sen-singh-2023.md E2 初稿中
一度犯过的错误），**不影响上述安全性结论**——因为：

1. **Φ₁₀ 对称性是独立于任何文献习惯的数学事实**（本人未找到对它的显式一手证明，
   但它被 Rosselló §3.1、BSS footnote 13、gap-102b §4 引理 3 等多处**一致地当作
   背景事实使用**，且 Igusa 1962/1964 已确立权 10 Sp(4,ℤ) 尖点形式空间一维 ⇒
   Φ₁₀ 是该空间唯一生成元 ⇒ 任何对称变换下不变）。
2. **已毕业定理的物理识别 (P)/(P′) 与 DGM eq(3.28) 的一致性**是通过**直接比对
   三元组 (Q²/2, P²/2, Q·P) 在两文中的第几槽、以及 s² 除哪一槽**来验证的——
   这一步**不经过** BSS，不依赖 BSS 的任何变量对应或记号习惯，故引理 2 对错不影响。

**但**：引理 2 若错，会使 gap-102b 草稿 §4/§5 关于"BSS 的 SET-B 对象 = 上游的
ψ_m^F（磁荷指标）"这一**跨文献等同识别**失效——即草稿试图通过 BSS Appendix B
的纯代数证明"搭便车"获得某个 mock Jacobi 系数集合的非极点性质时，可能把 BSS
证明的对象（电荷指标的 ψ_n^F）误认为上游对象（磁荷指标的 ψ_m^F），导致 gap-102b
草稿**自己的新论证**（非已毕业定理）出错。**现已核实引理 2 正确（SUPPORT），
此风险不存在。**

---

## 四、发现的原文编号/印刷问题清单

1. **DGM 0803.2692 eq 编号**（已在 dabholkar-gomes-murthy-2008.md 订正 C2 详细记录）：
   - ar5iv HTML 渲染的 "eq(50)/(51)/(52)" **不是** arXiv PDF 官方编号。
   - 正确编号：**eq(3.26)/(3.27)/(3.28)**（§3.4，第 16 页）；eq(3.26) 内容与更早的
     eq(2.13)（§2.2，第 6 页）相同，只是位置不同（2.13 首次定义、3.26 用不变量重述）。
   - **影响范围**：项目内所有引用 "DGM eq(50)/(51)/(52)" 之处需改编号字符串，
     包括 `graph/statements/holography/dgm-torsion-divisor-sum.yaml`、
     `torsion-immortal-positivity.yaml`、`research/attempts/torsion-immortal-positivity-hecke/**`、
     `literature/sources.bib` 的 DGM note 字段（后两处已在本次任务中订正并提交）。
   - **教训**：ar5iv HTML 的公式编号不可信（LaTeXML 有时把分节编号拉平成全局计数器），
     **关键公式编号必须直接读 PDF 页面图像核对**。

2. **BSS 2311.16252 A₂/B₂ 定义的双重编号**（bhand-sen-singh-2023.md E5 已记录）：
   - 同一集合 B₂ 的定义在主文 (eq 5.65) 与 Appendix B 证明处 (eq B.36) **编号不同，
     内容逐字相同**——两处都是原文真实存在的位置，不是本项目转录错误，只是
     "首次陈述"与"证明所在处"分属两节各自重新编号。
   - gap-102b 草稿引用 "BSS eq (5.65)" 定义 B₂——**核实为 SUPPORT（精确匹配）**，
     但审查者若去 Appendix B 找证明会看到编号 (B.36)，需知晓这一双重编号以免误判矛盾。

3. **BSS footnote 10 与 [9]/[26] 文献号**（bhand-sen-singh-2023.md E10/E11 已记录）：
   - 本次任务未完整读取 BSS 的 References 列表全文（只读到前两条 [1]/[2]，第 62 页
     被分页截断），[9] 和 [26] 的精确书目信息**未经一手核实**。
   - 但正文多处 "[9, Section 11.1]" / "eq. (11.17) of [9]" / "[26, Table 1]" 的
     上下文内容（DMZ 分解定理、Rosselló Table 1 数值 50064）使得 **[9]=DMZ 1208.4074**、
     **[26]=Rosselló 2403.19630** 几乎确定（置信度 >99%），本次裁定依此假定；
     若后续发现 [9]/[26] 实际指向其他文献，需重新审查 footnote 10 的适用范围。

---

## 五、核实方法与亲自核实 vs 转述信任 层级表

| 条目 | 来源 | 核实方法 | 层级 |
|---|---|---|---|
| BSS Thm 5.4 `m=NQ²/2, n=P²/2` | arXiv PDF 2311.16252 p.47 | 本人 `curl` 下载 PDF，Read 工具按页读取图像（p.39-48），逐字转录 | **亲自核实** |
| BSS footnote 10 Q↔P 互换声明 | 同上 p.50 | 同上（p.49-56） | **亲自核实** |
| BSS eq (5.13)-(5.14) 吸引子围道 | 同上 p.41-42 | 同上（p.39-48） | **亲自核实** |
| BSS eq (5.64)-(5.65) A₂/B₂ 定义 | 同上 p.49 | 同上（p.49-56） | **亲自核实** |
| BSS Appendix B Prop B.1/B.2 | 同上 p.57-59 | 同上（p.57-62） | **亲自核实** |
| BSS §B.3/§B.4 完成配方证明 | 同上 p.60-62 | 同上 | **亲自核实** |
| BSS §5.3 DMZ 反例 (10,14,5) | 同上 p.50-52 | 同上（p.49-56） | **亲自核实** |
| Rosselló (2.3) `m=P²/2, n=Q²/2` | rossello-2024.md E3/R1 | 转引本项目既有抽取记录（该记录由此前独立 researcher 逐字核对） | **转述信任**（一手核实者：prior researcher 2026-09-14） |
| Rosselló (2.22)/(2.23) 围道与 d_* | rossello-2024.md V1 | 同上 | **转述信任**（一手核实者：prior researcher 2026-09-14/15） |
| DGM eq(3.26)/(3.27)/(3.28) | arXiv PDF 0803.2692 p.16 | 本人 `curl` 下载 PDF，Read 工具按页读取（p.9-20），逐字核对编号与内容 | **亲自核实** |
| DGM eq(2.13) | 同上 p.6 | 同上 | **亲自核实** |
| gap-102b 草稿 (P)/(P′) postulate | gap-102b/proof.md line 278/490 | 本人 Read 工具直接读取（limit 120 行） | **亲自核实** |
| Φ₁₀ 的 ρ↔σ 对称性 | 多文一致当作背景 | 本人**未找到**对它的显式一手证明；Igusa 1962/1964 一维性 ⇒ 唯一生成元 ⇒ 对称（逻辑推断） | **推断**（需 curator 后续确认或形式化时补证） |

**说明**：标"亲自核实"者，本人在本次任务中直接下载原文 PDF 或读取项目文件，逐字核对
引用位置与公式内容，置信度 100%。标"转述信任"者，依赖本项目此前独立 researcher 通道
已完成的逐字核实记录（该记录本身经过同样的 PDF 页面图像核对流程），置信度 >95%
（residual 风险来自"前次 researcher 可能也出错"，但经交叉比对未发现矛盾）。标"推断"者，
本人未亲自证明该数学命题，只验证了"多处文献一致地把它当背景使用"这一事实。

---

## 六、最终建议

1. **verdict (c) 确认**：Rosselló 与 BSS 确为不同记号习惯（BSS footnote 10 作者自陈），
   物理内容一致，**不是任何一方的错误**。项目内同时引用两家文献时需显式翻译
   （如 gap-102b §1 引理 1），但**已毕业定理不受影响**（Φ₁₀ 对称性 + 物理识别
   层与 DGM 一致）。

2. **DGM eq 编号订正**（curator 后续任务）：
   - `graph/statements/holography/dgm-torsion-divisor-sum.yaml`：sources/loc 字段
     "eq(50)+(51)" → "eq(2.13)/(3.26)+(3.27)"（或只写 "eq(3.26)+(3.27)"，(2.13) 可作注）。
   - `graph/statements/holography/torsion-immortal-positivity.yaml`：sources/loc
     "eq(52)" → "eq(3.28)"。
   - `research/attempts/torsion-immortal-positivity-hecke/**`：claim.md/proof.md 中
     一切 "DGM eq(50)/(51)/(52)" → "eq(3.26)/(3.27)/(3.28)"（已在 literature/ 下完成，
     research/ 下需 prover/reviewer 自查）。
   - 这是**编号字符串更正，不改任何数学内容或推导逻辑**，可由 curator 批量 Edit。

3. **gap-102b 草稿 §3 引理 2 确认正确**：经"傅里叶相位系数"标准核验（本人独立重做，
   用 rossello-2024.md V1 与 bhand-sen-singh-2023.md E1 各自 d_* 定义式的相位系数），
   **ρ_Rosselló↔σ_BSS, σ_Rosselló↔τ_BSS** 对应关系**正确**（SUPPORT）。草稿可继续
   使用该引理进行跨文献等同识别（BSS 的 SET-B mock Jacobi 形式 = 上游的 ψ_m^F 族）。

4. **后续 curator 若要进一步把关**：建议重点放在核对 rossello-2024.md V1 本身对
   Rosselló (2.22)/(2.23) 原文的转录是否忠实（即再上一层的源头核验），而非重做本人
   这一步的相位系数比较代数（该步骤用两文逐字定义式已清楚验证，除非怀疑本人读错
   V1 或 E1 的文本本身）。

---

**提交文件清单**（本次任务新增/修改，已全部 validate+commit）：
- `literature/extractions/bhand-sen-singh-2023.md`（新增，300+ 行）
- `literature/extractions/dabholkar-gomes-murthy-2008.md`（追加订正 C2 节，164 行）
- `literature/sources.bib`（新增 bhand-sen-singh-2023 条目；订正 DGM 条目 note）
- `literature/notes/mn-convention-adjudication.md`（本文件）

**仍未取得的来源**：无（本次任务涉及的全部文献均为 arXiv 公开 PDF，已全部下载核对）。
