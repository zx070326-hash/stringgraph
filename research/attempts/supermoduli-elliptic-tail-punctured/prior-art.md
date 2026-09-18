# Prior-art gate — 椭圆尾粘接技术推广到「紧化 + 穿孔」超模叠

**日期**：2026-09-18
**执行者**：theorem-prover (`agent/prover/supermoduli-elliptic-tail-punctured`)
**目的**：本轮的目标是把 Corrêa–Noja (以下 **CN**, arXiv:2606.06733) 的**椭圆尾 NS 粘接**技术推广
到**带穿孔**的紧化超模叠，从而把非投影性的亏格门槛压到**种子界以下**。开工前必须核实：
(a) 这件事是否已经有人做了；(b) **CN 自己有没有在文末预告「穿孔情形可以类似处理」**——任务书明确
指出，若作者本人写了这句话，本轮的定位完全改变。

本文件逐条记录检索式与命中/未命中，不做事后筛选。

---

## 结论（先说结论）

1. **「紧化 + 穿孔」象限仍然是空的。** 与上一轮 `supermoduli-compactified-punctured/prior-art.md`
   的结论一致，且本轮用不同的检索式与一手全文重新独立核实了一遍。
2. **⭐ CN 论文根本没有 outlook / further directions 一节。** §8 "Proof of the main theorem" 的证明
   在 p.24 结束，紧接着就是 References。**全文不存在任何形如「the punctured case can be handled
   similarly」「we will treat this elsewhere」的句子，也不存在任何 "puncture" 相关的展望**。因此
   任务书担心的"定位崩塌"场景**没有发生**：本轮要做的推广是作者本人没有声称做过、也没有声称将要做的。
3. **CN 的原文已完整获取并逐页读完（24 页，无付费墙）**，其椭圆尾论证的每一步（§2 工具、§5 一点
   障碍族、§6 粘接构造、§7 存活性、§8 组装）都已逐字抽出，见 `proof.md` §1。任务书列为"全轮成败
   所在"的前置条件已满足。
4. **风险信号（如实记录）**：Simone Noja 个人主页的 "In preparation" 列表中有一条
   **"Supermoduli spaces (with M. Corrêa, R. Donagi)"**，无摘要、无范围说明。这条未公开的工作
   **有可能**覆盖本轮的内容（也可能是一本综述/讲义）。无法排除，如实标注为本轮最大的"被抢先"风险。

---

## §1 一手全文获取记录（本轮亲自下载并逐页读取，非检索摘要转述）

| 文献 | 获取方式 | 读取范围 | 用途 |
|---|---|---|---|
| **CN** = Corrêa–Noja, "Compactified Supermoduli Space is Almost Never Projected", arXiv:2606.06733v1 | `curl` 直接下载 PDF（`Content-Length: 329794`，与本地字节数逐字节一致，确认未截断） | **全部 24 页，逐页 Read 渲染** | 本轮推广的**对象**；`proof.md` §1 的忠实重述全部来自此次读取 |
| **FKP-A** = Felder–Kazhdan–Polishchuk, "The Moduli Space of Stable Supercurves and Its Canonical Line Bundle", arXiv:2006.13271v3 (= Amer. J. Math. **145** (2023) 1777–1886；CN 参考文献 [9]) | `curl` 下载 PDF + `pdftotext -layout` 抽文本 | §2.6、§7.5（Lemmas 7.9/7.10 与粘接态射 (7.8)/(7.9)）、Example 8.9（p.57 逐字渲染为图像读取）、§9.1 含式 (9.6)、§9.3 | CN 椭圆尾构造的**地基**；本轮推广的关键在于 FKP 的粘接态射**本来就是带穿孔的一般形式** |
| **DN4** = Donagi–Noja, "Genus 4 Supermoduli Space Is Not Projected", arXiv:2608.24996v2 | `curl` + `pdftotext` | 全文文本，重点搜 `puncture\|compactif\|in preparation` | 核查是否有穿孔/紧化预告 |
| **Wang** = arXiv:2512.15727 | `curl` + `pdftotext` | 全文文本，grep `compactif\|stable supercurve\|boundary\|elliptic tail\|future work\|elsewhere` | 核查是否有紧化预告；**零命中** |

### 关于 CN PDF 页数的一处工具假警报（如实记录，非数学问题）

`file cn.pdf` 报 "PDF document, version 1.7, **9 page(s)**"，与既有抽取记录 `correa-noja-2026.md`
的"全文 24 页"矛盾，一度让本轮怀疑下载被截断。核实方式：`curl -sIL` 返回的 `Content-Length: 329794`
与本地文件字节数**完全相等**，且 Read 工具成功渲染了第 10–24 页（内容连贯，p.24 以 References 结尾）。
结论：文件完整，`file` 的页数统计不可靠（线性化 PDF 的 `/Count` 解析问题）。**与数学无关，记录在此
以免后续 agent 重复踩同一个坑。**

---

## §2 ⭐ 特别核查：CN 有没有预告穿孔情形？（任务书指定的关键核查）

**核查方法**：不依赖检索摘要，直接读 CN 全文最后几页。

**结果（逐字记录 p.21–24 的结构）**：

- p.21 开篇："Proof of Theorem 1.1. The first assertion is precisely Theorem 3.5 ... We now prove
  the higher-genus assertion. Fix ε ∈ {+,−}. Let g ≥ 3, and put h := g−1 ≥ 2."
- pp.21–24：证明正文（选无效偶 theta 特征、构造测试态射、用 Theorem 2.6 比较障碍类、两种宇称的
  椭圆尾）。
- p.24 证明的最后一句："Therefore both 𝔐̄_g^+ and 𝔐̄_g^− are non-projected for every g ≥ 3."
- **紧接着就是 "References"**。

**判定**：**CN 没有 outlook / further directions / concluding remarks 一节，一句都没有。** 论文以
主定理证明的最后一行结束。因此：

- ❌ 不存在「the punctured case can be handled similarly」
- ❌ 不存在「we will treat punctures in future work」
- ❌ 全文（24 页逐页读完）**不出现 "puncture"、"Ramond"、"NS puncture" 作为研究对象的展望**
  （"NS" 只作为"NS 节点 / NS 边界因子 / NS 粘接映射"这一技术术语出现，指的是紧化边界上的节点类型，
  不是模空间上的穿孔标记）。

⚠ **一处必须讲清楚的细微之处，以免将来有人误判本轮是重复劳动**：CN 的构造里**确实出现了带一个 NS
穿孔的超模叠 𝔐⁺_{h,1}**（一点障碍族 X_η 映到它）。但那个 NS 穿孔是**被粘接消耗掉的**——它就是将来
要跟椭圆尾的穿孔粘成 NS 节点的那个点。CN 的**结论**（Theorem 1.1）讲的是 𝔐̄_g^±，**无穿孔**。
也就是说：CN 用了带穿孔的模空间当**中间工具**，但从未断言任何关于带穿孔模空间本身可投影性的结果。
**「工具里出现穿孔」≠「结果覆盖穿孔情形」**，本轮要做的正是把穿孔留在**结果**里。

---

## §3 检索记录（逐条，含未命中）

### WebSearch

1. `elliptic tail gluing supermoduli punctures non-projected compactified` — 命中 CN、Donagi–Ott、
   DW 的摘要级转述；**未命中**任何把椭圆尾/边界粘接技术用在带穿孔紧化模叠上的论文。
2. `supermoduli space Ramond punctures compactified projectedness 2026` — 搜索结果本身给出一句
   明确的负面陈述（转述）："no paper appears to combine Ramond punctures with the projectedness of
   the compactified stack"。**零正面命中。**
3. `Correa Noja supermoduli future work punctures "will be treated"` — **未命中**任何预告句；命中的
   都是已知的三篇（CN、DN4、companion 形式模论文 arXiv:2605.03166）。
4. `Felder Kazhdan Polishchuk gluing morphism NS puncture psi line normal bundle` — 命中 FKP-A 的
   Theorem C 与 §9 的转述，确认其 Ψ-线与法丛公式；**未命中**任何用它做投影性论证的后续工作
   （除 CN 本身）。
5. `spin curve rational tail theta characteristic punctures moduli non-projected` — **未命中**；
   命中的是普通（非超）自旋模空间的边界几何文献，与可投影性无关。
6. `supermoduli genus 2 punctures compactified split non-projected 2026 new preprint` — 命中
   FKP arXiv:2408.11136（亏格 2，紧化，**无穿孔**）与 CN；**未命中**带穿孔的紧化结果。

### 直接查一手页面（WebFetch / PDF）

7. **Simone Noja 个人主页**（`WebFetch`）：
   - "Preprints" 列表中与超模叠可投影性相关的条目只有三条：arXiv:2606.06733（CN，紧化**无穿孔**）、
     arXiv:2608.24996（DN4，亏格 4，**未紧化无穿孔**）、以及一条本项目 `literature/` 里**尚未登记**的
     新预印本 **"Schottky vs super Schottky in genus 4", arXiv:2609.16131 (2026)**（标题看不出与
     可投影性/穿孔相关，但同一作者同一时期，建议 lead 登记以防遗漏）。
   - "In preparation" 列表中有 **"Supermoduli spaces (with M. Corrêa, R. Donagi)"**，**无任何范围
     说明**。⚠ 见 §4 风险评估。
   - **没有任何条目的标题或描述提到 punctures / Ramond / marked points。**
8. **Donagi–Noja arXiv:2608.24996 全文**：致谢中唯一的预告句是 "A work in progress, joint with him
   [Corrêa], examines the non-projectedness of 𝔐₃"——**这是未紧化、无穿孔的亏格 3**（填补 DW 留下的
   g=3 缺口），与本轮象限无关。全文无 "puncture" 作为研究对象出现。
9. **Wang arXiv:2512.15727 全文文本**：grep `compactif|stable supercurve|boundary|elliptic tail|
   future work|elsewhere` → **零命中**。Wang 完全不处理紧化，也没有任何预告句。
   🔴 提醒：Wang 这张图卡 (`math.supermoduli-ns-ramond-punctures-not-projected`) 的 status 是
   **`physical-argument`**（论文自陈 "preliminary draft"）。本轮的主结论**不使用 Wang 作为输入**
   （见 `claim.md` §0），因此**不继承**这个天花板——这与上一轮推论 C 的处境不同。
10. **FKP-A arXiv:2006.13271 全文文本**：搜索 `project|split`——该文讨论的是**典范线丛与 Mumford
    同构**，**从不讨论 projectedness/splitness**。它是本轮的**地基**（提供带任意 (n_NS, n_R) 的
    紧化超模叠、粘接态射与 Ψ-线公式），但它自己不覆盖本象限，也不试图覆盖。

---

## §4 风险评估：本轮会不会是重复劳动？

| 风险源 | 评估 | 处置 |
|---|---|---|
| CN 自己预告过穿孔情形 | **已排除**（§2，全文无 outlook 节） | 无 |
| DN4 的 "work in progress" | **已排除**（是未紧化无穿孔的 𝔐₃） | 无 |
| Wang 深处有紧化段落 | **已排除**（全文 grep 零命中） | 无 |
| FKP 的两篇论文之一含投影性+穿孔结果 | **已排除**（2006.13271 只做典范线丛；2408.11136 只做亏格 2 无穿孔） | 无 |
| **Noja 主页 "In preparation: Supermoduli spaces (with M. Corrêa, R. Donagi)"** | ⚠ **无法排除**。无标题以外的信息，可能是综述/专著，也可能正是"带穿孔的紧化"论文 | 如实记录；本轮继续推进（未公开的工作按 `literature/CLAUDE.md` 规则 1 本来就不可引用），若将来该文出现且覆盖本轮结论，本尝试应按"被超越/独立重现"而非"被推翻"处理 |
| arXiv:2609.16131 未登记 | 程序性 | 移交 lead（见 `status.yaml`） |

**综合判定：本轮可以开工。** 「椭圆尾粘接 + 穿孔 + 紧化」在 2026-09-18 的公开文献中确认零覆盖。

---

## §5 本轮相对上一轮（`supermoduli-compactified-punctured`）的定位

上一轮用"紧化提升引理"（开子叠限制）把已知的未紧化带穿孔结果搬进紧化范畴，其 §6 自检**诚实承认**：
该方法只能达到**种子门槛**（无穿孔情形只到 DW 的 g≥5，够不到 CN 的 g≥3），并把
`[GAP-ELLIPTIC-TAIL]` 列为"唯一真正硬的开放问题"。

**本轮就是去做那条 GAP。** 判别标准很明确：本轮的产出必须在某个 (g,n,r) 区域给出**上一轮拿不到的**
非投影性结论，否则本轮没有新增价值。`claim.md` §4 给出逐格对照表。

**本轮不修改、不引用上一轮的任何结论作为证明步骤**——上一轮的引理 1.1（开子叠限制）在本轮的论证里
**完全用不到**：本轮是直接在紧化叠上计算障碍类，不经过"先在未紧化叠上证，再提升"这条路。两轮的结果
逻辑独立。
