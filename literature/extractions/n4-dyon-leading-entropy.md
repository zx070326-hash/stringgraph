# 抽取记录：n4-dyon-leading-entropy

- 文献：多源综合记录（见各条目的 sources）
- 抽取者：researcher agent
- 日期：2026-09-20
- 覆盖范围：N=4 弦论 1/4-BPS dyon 的领头阶黑洞熵公式

## §0 任务背景与核心问题

本记录回应 lead 于 2026-09-20 的派工：

> **`S_BH = π√Δ` 这条领头阶熵公式，在 703 个图节点里没有任何一个承载它。**

任务要求逐字抽取：
1. 公式本身的精确形式与系数（`π`、`2π`、或别的）
2. 它的来源（Bekenstein–Hawking 面积律 / Cardy 公式 / 对偶论证）
3. 文献自称的严格程度
4. 适用范围与修正项

**核心发现（先说结论）**：
- **未能取得任何文献的逐字公式 `S_BH = π√Δ`**（WebFetch 对 arXiv 全域失效）
- 从已有抽取记录与文献元数据推断：该公式以**隐式形式**存在于多篇文献，但**系数与归一化约定在不同文献间不统一**
- 本记录给出**能确认的部分**、**推断但未逐字核实的部分**、**完全未取得的部分**

---

## §1 约定

N=4 弦论有多种实现：
- Type IIA/IIB on K3×T²
- 杂化弦 on T⁶
- 四维，电磁荷 (Q, P) ∈ Γ^{6,6} 或 Γ^{22,6}

电荷不变量：
- `Δ := 4mn − ℓ²`（整数电荷 `m = Q²/2, n = P²/2, ℓ = Q·P`）
- 或 `Δ = Q²P² − (Q·P)²`（连续归一化）

**警告**：不同文献的 `Q²/P²/Q·P` 归一化相差因子 2、4、8 等，必须逐篇核对。

---

## 陈述

### E1 Strominger–Vafa 1996：D1-D5 系统的 `S = 2π√(Q₁Q₅n)` 【5维，1/2-BPS】

- 位置：hep-th/9601029（Strominger–Vafa 1996）
- 类型：proposition
- **本轮获取状态**：**未取得原文**（WebFetch 失败）；以下基于 `strominger-vafa-1996.md` 已有抽取记录（lead 于 2026-09-14 直接抽取，L1）
- 原文陈述（转述自已有抽取记录 E1）：
  > 五维极端 BPS 黑洞（type IIA on K3×S¹，Q₁ 根 D1-brane、Q₅ 根 D5-brane、动量 n）的 Bekenstein–Hawking 熵为
  > `S_BH = 2π √(Q₁ Q₅ n)`
  > 与 D-brane 微观态计数（Cardy 公式）给出的
  > `S_micro = 2π √(Q₁ Q₅ n)`
  > 精确相等。
- 文献自称的严格程度："exact agreement"；依赖 BPS 非重整化（指标不受耦合修正）
- 文献列出的依赖：Bekenstein–Hawking 面积公式 `S = A/(4G)`；D-brane 有效场论；Cardy 公式
- 备注：
  1. **这是 5维、1/2-BPS 情形**，不是 4维 1/4-BPS dyon。
  2. 系数是 `2π`，不是 `π`。
  3. 电荷组合是 `√(Q₁Q₅n)`，不是 `√Δ` 形式。
  4. 已有抽取记录（`strominger-vafa-1996.md`）未给出式号，只说"pp. 1–4, 式 (1)–(8)"。

**判定**：**此文不直接给出 4维 N=4 dyon 的 `S_BH = π√Δ` 公式**。

---

### E2 Dijkgraaf–Verlinde–Verlinde 1997：围道积分设定，无显式熵公式【arXiv:hep-th/9607026】

- 位置：hep-th/9607026（DVV 1997）
- 类型：proposition
- **本轮获取状态**：**未取得原文**；以下基于 `dijkgraaf-verlinde-verlinde-1997.md` 已有抽取记录（lead 于 2026-09-14 直接抽取，L1）
- 原文陈述（转述自已有抽取记录）：
  - **E5（核心补充，2026-09-20）**：围道积分公式 **(3.10)**
    ```
    d(qₑ,qₘ) = ∮ dρdσdv e^{iπ(q²ₘρ+q²ₑσ+2qₑ·qₘv)} / Φ(ρ,σ,v)
    ```
  - **E6（补充，2026-09-20）**：v→0 极限的半-BPS 因子化 **(2.7)**
    ```
    e^{iπq·Ω·q} / Φ(Ω)  →  (1/v²) · (e^{iπρq²ₘ}/η(ρ)²⁴) · (e^{iπσq²ₑ}/η(σ)²⁴)    as v→0
    ```
- 文献自称的严格程度："announced result"（围道积分）；v→0 极限是渐近行为
- 文献列出的依赖：E2（生成函数识别 `1/Φ₁₀` 的傅里叶系数 = dyon 指标，physical-argument）
- **关键观察**（引自已有抽取记录 E5 备注）：
  > DVV 1997 未给出"1/Φ₁₀ 在极点的留数因子化闭式" —— (3.10) 只给围道积分设定，(2.7) 只给 v→0 渐近行为；**留数的中间因子化表达式需从 Sen 2007 或后续文献补充**。
- 备注：**DVV 1997 不含显式的黑洞熵公式 `S_BH = ...`**。它给的是 dyon 指标的生成函数，不是黑洞几何的熵。

**判定**：**DVV 1997 不是 `S_BH = π√Δ` 公式的直接出处**。

---

### E3 Sen 1995（hep-th/9504147）：极端黑洞与弦态对应，熵匹配【4维杂化弦】

- 位置：hep-th/9504147（Sen 1995, `sen-1995-bh`）
- 类型：proposition
- **本轮获取状态**：**未取得原文**；以下基于 `sen-1995-bh.md` 已有抽取记录（researcher agent 于 2026-09-11 抽取，L1 逐页读毕）
- 原文陈述（转述自已有抽取记录 E11、E12）：
  - **拉伸视界熵** **(37)**：
    ```
    S_{B.H.} = (2πC/g)√(m² − Q̄_L²/(8g²))
    ```
    其中 `C` 是"拉伸视界"定义中的纯数因子。
  - **弦态熵** **(48)**：
    ```
    S_{E.S.} ≃ (8π/g)√(m² − Q̄_L²/(8g²))
    ```
  - 匹配条件：取 `C = 4` 后两式相等。
- 文献自称的严格程度："we define"（(37) 是定义）；"agree if we make the choice"（`C = 4` 是拟合）
- 文献列出的依赖：
  - 拉伸视界假设（**原文自称 "postulate"**，见已有抽取记录 E5）
  - 杂化弦 T⁶ 极端黑洞解（引其 [7] = hep-th/9411187）
  - 弦态计数 `d_{E.S.} ≃ exp(4π√N_L)`（引其 [5] = hep-th/9405117）
- 备注（引自已有抽取记录 §1.2、§5.4）：
  1. **归一化**：`α' = 16`、`G_N = 2`（不是标准的 `α' = 4`、`M_Pl = 1`）
  2. **`C = 4` 是拟合出来的**，不是独立算出的（见已有抽取记录 Q2）
  3. **拉伸视界本身是假设**（"postulate"），不是推导（见已有抽取记录 E5）
  4. **事件视界面积为零**（该族极端黑洞），所以用拉伸视界代替（见已有抽取记录 E4）

**判定**：**Sen 1995 给的是特殊归一化下的熵匹配，不是标准的 `S_BH = π√Δ` 形式**。

---

### E4 推断：N=4 超引力的面积律 `S = π√I₄`（未取得逐字来源）

- 位置：**未取得**
- 类型：proposition（推断）
- **本轮获取状态**：
  - WebSearch 返回多条文献元数据（见 §0 search results）提到"S ∝ √I₄"，其中 I₄ 是 E₇(₇) 的 quartic invariant
  - 未能 WebFetch 任何一篇原文（arXiv 全域失效）
  - 从 `research/attempts/attractor-contour-threshold-entropy/status.yaml`（theorem-prover 于 2026-09-20 记录）得知：
    > **[GAP-Step2]**: Did NOT obtain verbatim literature source for S_BH = π√Δ.
    > Dimensional argument S_BH ∝ √Δ is standard from supergravity (area ∝ √I₄
    > where I₄ is the quartic invariant), but exact coefficient π requires verification
    > from Sen 2008 §5, DVV 1997, or dedicated N=4 entropy literature.
- 推断的公式形式（**未逐字核实**）：
  ```
  S_BH = π√I₄
  ```
  其中 I₄ 是 N=4 超引力（E₇(₇) 对偶群）的 quartic invariant，对 1/4-BPS dyon：
  ```
  I₄ = Δ = 4mn − ℓ² = Q²P² − (Q·P)²
  ```
  （在适当归一化下）
- 推断的来源：
  1. Bekenstein–Hawking 面积公式 `S = A/(4G_N)`
  2. N=4 超引力极端黑洞的视界面积 `A ∝ √I₄`（attractor 机制）
  3. 归一化约定使比例系数为 `4πG_N = 1` ⇒ `S = π√I₄`
- **严格程度**：**未知**（未取得原文）
- 文献列出的依赖：**未知**
- 备注：
  1. **本条是推断，不是逐字抽取**。
  2. **系数 `π` 依赖归一化约定**：不同文献的 `G_N`、`α'`、电荷归一化可使系数变为 `2π`、`π/2`、`4π` 等。
  3. **建议的核查来源**（来自 theorem-prover 的 GAP 记录）：Sen 2008 (arXiv:0708.1270) §5、DVV 1997、Cardoso–de Wit–Käppeli–Mohaupt (hep-th/0412287)

**判定**：**此公式在多篇文献中以隐式形式存在，但本轮未取得任何一篇的逐字公式**。

---

## §2 未能取得的关键文献

| arXiv id | 标题（推断） | 尝试的 URL 形式 | 失败原因 |
|---|---|---|---|
| 0708.1270 | Sen 2008, Black Hole Entropy Function | `arxiv.org/pdf/0708.1270`、`/pdf/0708.1270v4`、`export.arxiv.org/pdf/0708.1270` | WebFetch: "Unable to verify if domain ... is safe" |
| hep-th/9607026 | DVV 1997, Counting Dyons | （未尝试，已有 L1 抽取记录） | — |
| hep-th/9601029 | Strominger–Vafa 1996 | （未尝试，已有 L1 抽取记录） | — |
| hep-th/0412287 | Cardoso–de Wit–Käppeli–Mohaupt 2004 | 未尝试 | WebSearch 只返回元数据 |
| hep-th/0701118 | (未知标题) | `arxiv.org/pdf/hep-th/0701118v1` | WebFetch 失败 |
| repository.ias.ac.in/44083/1/128-auth.pdf | (Sen 的某篇综述？) | `repository.ias.ac.in/44083/1/128-auth.pdf` | WebFetch: "Unable to verify" |

**Coordinator 于本任务中途补充的情报**（2026-09-20）：
> 昨天另一个 agent（theorem-prover）报告「WebFetch to arXiv blocked」，但同一天另一个 researcher **成功**用 WebFetch 下载 arXiv:0708.1270v4 官方 PDF、再用 Read 工具读页面图像。

**本轮实测**：WebFetch 对 arXiv.org、export.arxiv.org 全部返回 "Unable to verify if domain ... is safe"，**不是 HTTP 错误，是工具的域安全检查拒绝**。

**结论**：**arXiv 原文在本会话中不可达**。

---

## §3 我亲自逐字核实了什么 / 我转述信任了什么 / 我未取得什么

### 我亲自逐字核实了什么（L1）
**无**。本轮所有 arXiv 原文 WebFetch 均失败。

### 我转述信任了什么（L3，基于本项目已有 L1 抽取记录）
1. **Strominger–Vafa 1996 的 `S = 2π√(Q₁Q₅n)`**（来自 `strominger-vafa-1996.md` E1，lead 于 2026-09-14 直接抽取，L1）
2. **DVV 1997 的围道积分公式与 v→0 极限**（来自 `dijkgraaf-verlinde-verlinde-1997.md` E5/E6，lead 于 2026-09-14 补充，L1）
3. **Sen 1995 的拉伸视界熵与弦态熵匹配**（来自 `sen-1995-bh.md` E11/E12，researcher agent 于 2026-09-11 抽取，L1）

### 我未取得什么（L0）
1. **`S_BH = π√Δ` 的任何逐字公式**（任何文献、任何归一化）
2. **Sen 2008 (arXiv:0708.1270) 的任何页面**（WebFetch 全域失效）
3. **Cardoso–de Wit–Käppeli–Mohaupt 2004 (hep-th/0412287) 的原文**
4. **任何明确给出"系数是 `π` 而非 `2π` 或 `π/2`"的文献**

---

## §4 对 `S_BH = π√Δ` 的裁定

### 公式存在性
**CANNOT CONFIRM**（本轮未取得逐字来源）。

### 系数 `π` vs `2π` vs 其他
**CANNOT DETERMINE**（本轮未取得原文）。

从已有记录推断：
- Strominger–Vafa 1996（5维 1/2-BPS）：系数 `2π`
- Sen 1995（4维杂化弦，特殊归一化 `α'=16, G_N=2`）：系数形式复杂，依赖拟合参数 `C=4`
- 推断的标准形式（未核实）：`S = π√I₄`，其中比例系数依赖 `G_N` 与电荷归一化约定

**结论**：**系数在不同文献/归一化下不统一；`π` 这个具体值未在本轮找到逐字来源。**

### 来源（Bekenstein–Hawking / Cardy / 对偶论证）
从已有记录推断：
1. **宏观侧**：Bekenstein–Hawking 面积公式 `S = A/(4G_N)` + N=4 超引力极端黑洞解的视界面积 `A ∝ √I₄`（attractor 机制）
2. **微观侧**：dyon 指标计数（DVV 1997 的生成函数方法 / Cardy 公式 / D-brane 微观态）
3. **识别**：宏观黑洞 ↔ 微观 BPS 态（physical-argument，不是数学定理）

**严格程度**：**physical-argument**（基于对偶论证与 BPS 非重整化假设）。

### 适用范围与修正项
从已有记录与 WebSearch 结果推断：
- **适用范围**：N=4 弦论（type II on K3×T² / 杂化 on T⁶），1/4-BPS dyon，大电荷极限（Δ ≫ 1）
- **领头阶**：`S_BH ∝ √Δ`（本记录关注的部分）
- **次领头阶**：存在 `O(log Δ)` 修正项（Gauss–Bonnet 项、Wald 熵修正、量子修正）；多篇文献（Sen 2008、Cardoso 等）计算了这些修正，但本轮未取得原文

---

## §5 建议的后续行动

1. **立即行动**：lead 手动访问 arXiv:0708.1270v4（Sen 2008），逐字抽取 §5 或附录中关于熵公式的部分。
   - 优先查：式号带"entropy"或"S_BH"的公式
   - 核对：系数是 `π`、`2π`、还是别的
   - 核对：电荷归一化约定（`Q²/2 = m` 还是 `Q² = 2m`）

2. **补充来源**：抽取 hep-th/0412287（Cardoso–de Wit–Käppeli–Mohaupt 2004），该文被 WebSearch 描述为"asymptotic degeneracy of dyonic N = 4 string states and black hole entropy"

3. **对抗性核查**（给 curator 的红线清单）：
   - **不得臆造系数**：在取得逐字来源之前，任何写进 `graph/` 的熵公式必须标注"系数未核实"
   - **不得混淆 5维/4维、1/2-BPS/1/4-BPS**：Strominger–Vafa 的 `2π√(Q₁Q₅n)` 不是 4维 N=4 dyon 的公式
   - **不得忽略归一化约定**：Sen 1995 的系数依赖 `α'=16, G_N=2`；标准归一化（`α'=4, M_Pl=1`）下系数不同

4. **curator 若要立卡，建议的 `gaps` 字段**：
   ```yaml
   gaps:
     - "领头阶熵公式 S_BH = π√Δ 的逐字来源未在公开文献中定位（researcher 于 2026-09-20 报告 arXiv WebFetch 失效）"
     - "系数 π 依赖归一化约定；Strominger–Vafa 1996 给的是 2π（5维情形），Sen 1995 给的形式更复杂（4维但特殊归一化）"
     - "公式的宏观推导（Bekenstein–Hawking + attractor）与微观推导（dyon 计数 + Cardy）的识别是 physical-argument"
   ```

---

## 未解决的疑问

1. **Q1**：`S_BH = π√Δ` 这个精确形式是否真的在某篇文献里逐字出现？还是它只以 `S ∝ √I₄` 的形式出现，系数由归一化约定隐式确定？

2. **Q2**：如果系数确实是 `π`（而非 `2π`），它对应什么归一化约定？（`G_N = ?`, `α' = ?`, `Q²/2 = m` 还是 `Q² = 2m`？）

3. **Q3**：DVV 1997 的围道积分公式 (3.10) 与 Bekenstein–Hawking 熵公式之间有没有文献给出显式的推导？还是它们被当作"两条独立的输入、通过匹配来识别"？

4. **Q4**：Sen 2008 (arXiv:0708.1270) §5 是否是"标准引用出处"？多篇后续文献（包括本项目的 `research/` 记录）都提到它，但本轮未能读到。

---

## 附录：WebSearch 返回的相关文献元数据（未取得全文）

以下文献在 WebSearch 中被描述为相关，但本轮未取得全文：

1. **arXiv:0708.1270** (Sen 2008): "Black Hole Entropy Function, Attractors and Precision Counting of Microstates"
2. **arXiv:hep-th/0412287** (Cardoso et al. 2004): "Asymptotic degeneracy of dyonic N = 4 string states and black hole entropy"
3. **arXiv:hep-th/0701118** (未知作者, 2007): "Entropy-Area law for Extremal Blackhole in Four Dimensions"
4. **arXiv:0810.3472**: "Asymptotic Expansion of the N=4 Dyon Degeneracy"
5. **arXiv:hep-th/9610046**: "Entropy of Four-Dimensional Rotating BPS Dyons"

**建议 lead 手动检索以上文献（尤其前两篇）。**

---

## §6 最终报告（给 lead）

### 抽取了哪些条目
- **E1**：Strominger–Vafa 1996 的 `S = 2π√(Q₁Q₅n)`（5维 1/2-BPS）
- **E2**：DVV 1997 的围道积分设定（无显式熵公式）
- **E3**：Sen 1995 的拉伸视界熵匹配（4维杂化弦，特殊归一化）
- **E4**：推断的 `S = π√I₄`（**未逐字核实**）

### 每条的忠实度 / 裁定
- **E1–E3**：SUPPORT（转述自本项目已有 L1 抽取记录，忠实）
- **E4**：**无定论**（推断合理，但未取得逐字来源；系数未确定）

### 发现的原文疑点
1. **DVV 1997 不给黑洞熵公式**：它给的是 dyon 指标生成函数，未明确写出"此即黑洞熵"
2. **Sen 1995 的拉伸视界是假设**（原文自称"postulate"），且 `C=4` 是拟合出来的
3. **Strominger–Vafa 1996 的系数是 `2π`**（5维情形），与推断的 4维公式系数 `π` 不同

### 仍未取得的来源
- **arXiv:0708.1270**（Sen 2008）：WebFetch 全域失效（域安全检查拒绝）
- **arXiv:hep-th/0412287**（Cardoso et al. 2004）：同上
- **任何给出 `S_BH = π√Δ` 逐字公式的文献**

### 分支名与 commit
- **分支名**：`worktree-agent-a5b4a1fac8947c84a`（coordinator 自动分配的 worktree）
- **commit**：见下一步

---

## 建议的 `literature/sources.bib` 新增条目（供 lead 落盘）

由于本轮未能直接抽取新文献，以下是**建议新增**但**本轮未逐字核实**的条目：

```bibtex
@article{cardoso-dewit-kappeli-mohaupt-2004,
  author    = {Cardoso, Gabriel Lopes and de Wit, Bernard and K{\"a}ppeli, Joachim and Mohaupt, Thomas},
  title     = {Asymptotic degeneracy of dyonic N = 4 string states and black hole entropy},
  journal   = {JHEP},
  year      = {2004},
  month     = {12},
  eprint    = {hep-th/0412287},
  note      = {arXiv:hep-th/0412287. （本项目未抽取，2026-09-20 researcher 报告未取得全文）}
}
```

**注**：Sen 2008 (arXiv:0708.1270) 已在 `sources.bib` 中登记为 `sen-2008-precision-counting`（另一个 agent 正在写它的抽取记录，本任务不许碰）。

---

**文件结束**。下一步：commit 本文件，向 lead 报告。

---

# 【[GAP-Step2] 已关闭：逐字取得 S_BH = π√Δ —— lead 2026-09-20】

上文（researcher 本轮）的结论「未能取得任何文献的逐字公式 `S_BH = π√Δ`，系数 π 未核实」
**已被推翻**。lead 于同日取得逐字原文。记录如下，上文其余内容保留不动。

## 取得方式（重要：不是网络）

researcher 与更早的 theorem-prover 都报告「WebFetch 对 arXiv 全域失效」。**该报告属实**
——lead 亲自从主会话试 `https://arxiv.org/abs/0708.1270`，同样返回
`Unable to verify if domain arxiv.org is safe to fetch`。这是**环境级网络限制**，
不是 agent 的失误，也不是「换个 URL 写法就能绕过」。

但 **PDF 早已落在本地**：另一个 researcher 在当日早些时候（arXiv 尚可达时）下载了
`sen2008.pdf`（1.88 MB，196 页）到自己的 worktree。lead 直接用 **PyMuPDF** 读取该本地
文件取得逐字原文。

**教训（写给后续 agent）**：
1. arXiv 不可达时，**先查本地是否已有 PDF**（`find . -iname "*.pdf"`、以及
   `%TEMP%` 下历史 agent 留下的文件），不要直接判「未取得」。
2. **不要用 `pdftotext` 核对含系数的公式**。实测它会**静默丢弃 π 和 √**：
   本文 (5.6.32) 附近的 `e^{−π√(Q²P²−(Q·P)²)}` 被 pdftotext 输出成
   `e- . Q2P 2-(Q·P)2`——π 和 √ 全部消失。**用 pdftotext 去判定「系数是 π 还是 2π」
   会得到系统性的错误结论。** 请改用 PyMuPDF（`fitz`）或 Read 工具读页面图像。
3. 在 `/tmp` 下建 `struct.py` 之类与标准库同名的脚本会 shadow stdlib，导致
   `import fitz` 失败；换一个干净目录跑。

## E-LEAD-1（★核心，逐字）Sen 2008 eq. (3.1.23)：超对称分支

- 位置：arXiv:0708.1270v4，**PDF 第 39 页**（§3.1，"Black hole entropy from the
  entropy function formalism" 一节末尾），紧接 (3.1.22)。
- 逐字（verbatim，PyMuPDF 提取）：

  > The black hole entropy, given by the value of E for this configuration, is
  >
  > **S_BH = π √( Q²P² − (Q·P)² )**    (3.1.23)
  >
  > Although this formula has been derived under the condition P² > 0, Q² > 0,
  > P²Q² > (Q·P)², the final result for the entropy also holds for arbitrary
  > P², Q² as long as P²Q² > (Q·P)².

- **系数逐字为 π**（不是 2π，不是 π/2）。

## E-LEAD-2（逐字）Sen 2008 eq. (3.1.24)：非超对称分支

- 位置：**PDF 第 40 页**开头。
- 逐字：

  > The entropy function formalism also allows us to calculate the entropy of extremal
  > black holes with P²Q² < (Q·P)². We shall not go through the analysis here, but just
  > quote the final result:
  >
  > **S_BH = π √( (Q·P)² − Q²P² )**    (3.1.24)

- 即两分支合起来是 `S_BH = π√|Q²P² − (Q·P)²|`。

## 与本项目 Δ 记号的对应（这一步是代数，不是引用）

本项目（route-a / ell-zero / n₂-wall 各卡）用 `m = Q²/2`、`n = P²/2`、`ℓ = Q·P`，
`Δ := 4mn − ℓ²`。代入：

    Δ = 4·(Q²/2)·(P²/2) − (Q·P)² = Q²P² − (Q·P)²

**故 (3.1.23) 在本项目记号下逐字就是 `S_BH = π√Δ`。** 归一化完全对上，无待定因子。
（注意：这依赖 `m=Q²/2, n=P²/2` 这套归一化；researcher 上文 §1 的警告——
不同文献 Q²/P²/Q·P 差因子 2、4、8——是对的，但本项目已固定用这一套。）

## 适用范围与严格程度（诚实定档）

- **适用范围**：(3.1.19) 给出推导条件 `P²>0, Q²>0, (Q·P)² < Q²P²`；Sen 明说最终结果
  对任意 P², Q² 成立只要 `P²Q² > (Q·P)²`，即 **Δ > 0**。这正是本项目各卡的 Δ>0 条件。
- **推导途径**：§3.1 的 **entropy function formalism，两导数有效作用量**（3.1.3）
  ——即经典超引力的 Bekenstein–Hawking 熵，通过把 E 对 v₁,v₂,u_S,u_a 取极值得到
  ((3.1.20)→(3.1.22)→(3.1.23))。**这是领头阶**，高导数修正是 Sen 这篇综述后面整章的主题。
- **严格程度**：`physical-argument`。理由：它是超引力有效作用量上的 attractor/entropy-function
  计算，不是数学定理；且 Sen 本人在 p.40 就 (3.1.24) 那一支写道
  "black holes with P²Q² > (Q·P)² are known to be supersymmetric **although we cannot
  see this in our analysis**"。**不得**因为「公式取到了逐字原文」就定 rigorous——
  逐字取到的是一条物理推导的结论，不是它的严格性。

## 对下游的影响

1. **[GAP-Step2] 关闭**：`research/attempts/attractor-contour-threshold-entropy/status.yaml`
   记的「`S_BH = π√Δ` 未取得逐字来源」不再成立。该 attempt 的结论（Λ₀ = π/(2S_BH)
   基本是量纲强制的假深刻）**不因此改变**——它本来就声明「结论不依赖确切系数」。
   现在可以说得更强：系数确实是 π，所以 `Λ₀ = 1/(2√Δ) = π/(2S_BH)` 的数值形式**成立**，
   而它**依然**是量纲重写，依然不值得毕业进图。
2. **可以立卡了**：这条公式此前在 703 个图节点里无任何承载（lead 2026-09-20 grep 全图确认）。
   现在有了逐字来源 + 明确适用范围 + 诚实档位，具备立卡条件。
