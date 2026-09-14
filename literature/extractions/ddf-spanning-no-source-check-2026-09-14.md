# DDF 张成完整性「查无此证明」核实与裁定（researcher，task #18，2026-09-14）

> **任务**：判断「DDF 态张成完整物理子空间」（图节点 `worldsheet.ddf-spanning-hypothesis`，
> 现 status = open）在**任何公开文献**里是否已有严格证明，据此裁定是否要在 `research/` 下开原创证明轨道。
> **纪律警告（CLAUDE.md）**：不得在「其实有人证过、只是没读到」的情况下误判为 genuinely-open；宁可标 conditional，不轻率宣布 open。
> **本文件只追加**；不改动任何既有抽取记录，对既有文件的引用以交叉引用形式给出。
> 证据等级沿用 `math-sources.md` §0 / `brst-cohomology-sources.md` §0（L1 = 本人读原刊页图/重排本）。

---

## 0. 必须先分清的两件事（(A) vs (B)）

许多文献把下面两条都叫「无鬼定理」，但它们是不同命题，`ddf-spanning-hypothesis` 只关心 (B)：

- **(A) 物理 + 正范数**：DDF 态是物理态且内积半正定（无负范数鬼）。这是 Goddard-Thorn 1972 被反复引用的主内容。
- **(B) 张成 / 完整性**：DDF 态**张成整个**物理子空间——即 H_phys ⊆ D(Ε) + H_null，或等价地
  「物理态模零态」到「横向/DDF 空间」的映射是**满射**（维数配平、计数）。这正是 `ddf-spanning-hypothesis`。

图把 (A) 挂在无鬼定理节点、把 (B) 单列为 open 的假设，判断是对的：许多物理文献证 (A) 时把 (B) 当显然或跳过。
核实的关键在：**(B) 是否在某处被严格证明（而不仅是被断言或作为维数配平的推论默认）。**

## 1. 逐源对 (B) 的处理

| 文献 | 对 (B) 的处理 | 位置 | 自称严格程度 | 证据级 |
|---|---|---|---|---|
| **Borcherds 1992**（Invent. Math. 109, 405–444） | **给出 (B) 的完整证明**：Theorem 5.1「P¹_r/(形式零化空间) ≅ V^{1−(r,r)/2}」是**双向同构**（含满射=张成）；证明 Lemmas 5.1–5.5，其中 **Lemma 5.5「P¹ = T¹ ⊕ N¹」**直接是张成分解。作者注明这是 Goddard-Thorn 1972 原始证明的复述 | §5 Thm 5.1 + Lem 5.1–5.5 | **严格**（Fields 奖工作所含的期刊编号定理，带完整证明） | **L1**（作者重排本逐页读图，见 `borcherds-1992.md`）|
| **FGZ 1986**（PNAS 83, 8442–8446） | **给出 (B) 的等价陈述 + 维数**：Theorem 2.8 **第二个同构** `T ∩ P ≅ P/rad P`（横向空间 ≅ 物理态模零态），三空间正定、维数 `p_{(24)}(1−p·p/2)`；FGZ 自注「The second isomorphism … is known as the no-ghost theorem in the physics literature (8,9)」（8=GT1972, 9=Brower1972）。维数配平即完整性 | Thm 2.8（第二同构）+ Thm 2.7(ii)（维数）+ Thm 1.12（消灭） | **严格**（PNAS 编号定理，I. M. Singer 推荐；证明梗概，完整长文未获取） | **L1**（`brst-cohomology-sources.md` §1.3）|
| **Goddard-Thorn 1972**（Phys. Lett. B40, 235–238） | (B) 的**原始**证明（DDF 算子直接构造横向态并证张成）。Borcherds 1992 §5 明写「the original proof of Goddard and Thorn works … we give a quick sketch of their proof」，其 Lemmas 5.1–5.5 即 GT 论证的复述 | 无编号定理（快报体裁） | **严格**（原始来源；但本项目至今**未取得全文**，逐字未核） | **L2/L0**（经 Borcherds 背书 + 复述；GT 原文未获取）|
| **Polchinski 1998 Vol.1** | §4.4 BRST 版无鬼定理 coh(Q_B) ≅ Ker(S)；把 OCQ 物理态嵌入并讨论 BRST 类。给出 (B) 的教科书论证，但 §4.1 OCQ 版与 §4.4 BRST 版的等价性本身需另证 | §4.4 | 教科书级（物理严格） | L1（`polchinski-1998-v1.md` E58/E68）|
| **Gebert-Nicolai 1995 / GSW 1987** | 断言型：「no-ghost theorem tells us that the states … account for **ALL** physical states (including null)」——明确陈述 (B) 但作为引用他人（GT/Brower）的结论，不自证 | GSW §2.3.3；GN 1995 p.599 | 引用型（不自证） | L1（`gsw-1987-v1.md`）|
| **Borcherds 1986**（PNAS 83, 3068–3071） | 只提「Frenkel used the no-ghost theorem to prove this stronger upper bound when R is 26 dimensional and Lorentzian」；无编号定理，把无鬼定理当**工具**引用 | Section 5 | 引用型（不自证） | L1（`math-sources.md` §36.2）|

## 2. 关键判据：(B) 是否被「严格证明」而非「默认/推论」

- **Borcherds 1992 Theorem 5.1 是决定性的一手证据。** 其结论「P¹_r 模零化空间 ≅ V^{1−(r,r)/2}」是
  **自然同构**，同构必含满射；满射 = V^{1−(r,r)/2}（横向/DDF 空间）的每个元素都来自某物理态模零态
  = **DDF 态张成完整物理子空间**。证明是自足的（Lemmas 5.1–5.5，每步给了理由），发表在 Invent. Math.，
  是 Monstrous Moonshine（Fields 奖）证明所依赖的定理。**这不是「维数配平的默认推论」，而是带证明的编号定理。**
- **FGZ 1986 Theorem 2.8 第二个同构**给出同一结论的半无限上同调版本，并把维数算成 `p_{(24)}(1−p·p/2)`
  （即横向 24 维振子 Fock 空间在动量 p、级别 1−p²/2 处的维数），**且 FGZ 自己指认这第二个同构就是物理无鬼定理**。
- 两条相互独立（VOA 计数 vs 半无限上同调），且都追溯到 **Goddard-Thorn 1972 原始证明**——Borcherds 明说
  GT 的证明「经平凡修改即适用」，FGZ 把 GT 列为该定理的物理来源。**故 (B) 的严格证明不是孤例，而是有
  一条 GT 1972 → {Borcherds 1992 / FGZ 1986 / Frenkel 1985 / LZ 1991} 的、多份独立复述与推广的证明谱系。**

## 3. 为什么图仍把 `ddf-spanning-hypothesis` 标 open —— 这是形式化选择，不是数学未知

图节点 notes 已写明：该假设等价于「逐级别 N 的秩不等式」，N≤5 的切片已在 Lean 里封闭，N≥6 open。
这说明图要的是一份**在本项目自己的 DDF 算子框架下、能逐级别 N 匹配 Lean 陈述的秩不等式证明**，
而不是「数学界不知道 DDF 是否张成」。文献里的证明（Borcherds/FGZ/GT）用的是横向空间同构或半无限上同调，
**结论等价但形式不是本项目 Lean 目标要的那个逐 N 秩不等式形式**。这是「已发表结果 ↔ 本项目形式化载体」
的适配缺口，属**策展/形式化**问题，不是**查无此证明**问题。

## 4. 三选一裁定

**裁定：proven-in-literature（文献中已有严格证明）。**

理由：
1. Borcherds 1992 §5 Theorem 5.1（**L1 一手已读**）以带证明的期刊编号定理形式给出 (B)——物理态模零态与
   横向/DDF 空间的**自然（含满射）同构**，Lemma 5.5 即张成分解。
2. FGZ 1986 Theorem 2.8 第二同构（**L1 已读**）独立给出等价陈述与精确维数，且 FGZ 自认这就是无鬼定理。
3. 二者都复述/推广自 Goddard-Thorn 1972 的原始严格证明（Borcherds 明确背书其可用性）。
4. 不存在「无人证过」的情形；相反有多份独立的发表证明。

**对是否开 `research/` 原创证明轨道的建议：不开。** 开轨道会重复造轮子，重造一个 1972 年已证、
1992 年获 Fields 奖工作再证的著名定理。**正确动作是策展**：把 Borcherds 1992 Thm 5.1 / FGZ 1986 Thm 2.8
第二同构作为 (B) 的严格来源，交 curator 挂到 `ddf-spanning-hypothesis` 上（附下节的适配警示），
使该节点从 open 升为有严格来源支撑（或至少 conditional，取决于 curator 对「DDF 框架逐字对应」的取舍）。

## 5. 交给 curator 的适配警示（挂节点时必读）

1. **算子字典缺口（须标 `inferred`）**：Borcherds 的横向算子 K_i、FGZ 的横向空间 T，与本项目
   `worldsheet.ddf-operators` 的 A^ε_n 在物理上同族，但**逐字算子对应未在任何一手文献成文**。
   curator 把 Thm 5.1 / Thm 2.8 挂到 DDF 框架节点时，「K_i/T = DDF 张成 D(Ε)」这一步须标 `inferred: true` 并留 note。
2. **形式不匹配**：文献给的是「横向空间同构」，本项目 Lean 目标是「逐级别 N 秩不等式」。二者等价但需一步翻译；
   若图要严格闭合，该翻译本身要么另找来源，要么标 inferred。
3. **GT 1972 原文仍未获取**：DDF 框架下的**原始逐字**证明未到手；Borcherds 1992 §5 是自足替代（发表、带证明、可引）。
4. **D=26 的地位吻合**：Borcherds Thm 5.1 假设中心荷 24（横向）、张 II_{1,1} 后为 26；Lemma 5.4 证明用到「V 上 24 / H 上 26」。
   与图「D=26 只在 `ddf-spanning-hypothesis` 进入」的判断一致，可作正面佐证。

## 6. 产出与访问日志

- 新登记：`sources.bib` 增 `@article{borcherds-1992}`（Invent. Math. 109, 405–444, DOI 10.1007/BF01232032）。
- 新抽取：`extractions/borcherds-1992.md`（§5 Thm 5.1 + Lem 5.1–5.5 逐字要点，L1）。
- 交叉引用（未改动）：`brst-cohomology-sources.md` §1.3（FGZ Thm 2.8）、`math-sources.md` §36.2（Borcherds 1986）、
  `gsw-1987-v1.md`（GN 1995 / GSW §2.3.3）、`polchinski-1998-v1.md`（§4.4 BRST）。
- 取件：Borcherds 1992 = 作者主页 `https://math.berkeley.edu/~reb/papers/monster/monster.pdf`
  经 WebFetch 落盘后 Read 带 pages 读图（裸文本层 FlateDecode 压缩不可 grep，须渲染读图；重排本页码 ≠ 期刊页 405–444）。
