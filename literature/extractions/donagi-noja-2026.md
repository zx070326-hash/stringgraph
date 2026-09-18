# 抽取记录：donagi-noja-2026

- 文献：Ron Donagi and Simone Noja, "Genus 4 Supermoduli Space Is Not Projected", arXiv:2608.24996v2 (2026)
- 抽取者：researcher (agent/researcher/supermoduli-post-2024)
- 日期：2026-09-18
- 覆盖范围：全文（16 页），逐页 L1 直接读取（Read 工具渲染 PDF 页面），非摘要/非二手转述

## 约定

无穿孔（unpunctured）超模叠 𝔐_g，偶/奇自旋结构分量分别记 𝔐_g^± 或按论文记号 𝔐_g^ε（ε∈{+,−}）。
使用 P. Green 1982 的第一障碍类（primary obstruction / Green obstruction）ω₂(𝔛) ∈ H¹(X, T_X ⊗ Λ²T_-^∨𝔛)，
与既有图节点 `math.supermoduli-space-not-projected`（Donagi–Witten 2013）用的是同一套约定，本文明确说明沿用
Donagi–Witten 的障碍理论框架（"we use Green's obstruction theory in the form recalled by Donagi–Witten"，
与 correa-noja-2026 用词几乎一致，两篇论文共享同一位第二作者 Noja）。

## 陈述

### E1 主定理 Theorem 1.1（亏格 4 偶自旋分量不可投影）
- 位置：p.1，Theorem 1.1（Main theorem）
- 类型：proposition
- 原文陈述（逐字，L1 直接读取）：
  "Let 𝔐₄^+ denote the moduli superstack of unpunctured super Riemann surfaces of genus four with even
  spin structure. Then 𝔐₄^+ is non-projected. More precisely, ω₂(𝔐₄^+) ≠ 0."
  （原文措辞据 PDF 页面直读复原，下同；本抽取未逐字符对照 TeX 源码，允许极小的排版误差，但数学内容、
  量词、条件已核实无误。）
- 文献自称的严格程度：定理（"Main theorem"），证明性文章，非猜测；§2–§5 给出完整证明。
- 文献列出的依赖：P. Green 1982（第一障碍类定义）；Donagi–Witten arXiv:1304.7798（障碍理论框架、
  Compatibility Lemma 式论证工具）；Bryan–Donagi 2002（参考文献 [1]，提供论文所用的显式测试曲线/
  自同构构造的先驱例子，见 E3 勘误条目）。
- 备注：**这条定理只直接断言偶自旋分量 𝔐₄^+ 不可投影**，不直接处理奇自旋分量 𝔐₄^-。

### E2 摘要级逻辑推论：整个 𝔐₄ 不可投影（非文献直接定理，是显然的不交并逻辑）
- 位置：摘要（Abstract）与标题
- 类型：proposition（推论性质，非独立证明）
- 原文陈述（忠实转述，非逐字）：论文标题与摘要断言"genus 4 supermoduli space is not projected"，不带分量
  限定词；这依赖于"一个不交并空间可投影当且仅当每个分量都可投影"这一显然事实——𝔐₄ = 𝔐₄^+ ⊔ 𝔐₄^-，
  证明了 𝔐₄^+ 不可投影即足以推出整个 𝔐₄ 不可投影，不需要单独处理 𝔐₄^-。
- 文献自称的严格程度：论文正文（§2–§5）只给出 𝔐₄^+ 分量的显式计算；摘要/标题层面的"整个 𝔐₄"断言依赖
  于上述显然逻辑，论文本身未专门论证或强调这一步（因为足够显然）。
- 文献列出的依赖：E1。
- 备注：**这是本抽取者的显式逻辑补充说明，不是论文自己写出的推导步骤**，但逻辑本身在数学上是平凡且
  正确的（不交并的可投影性定义逐分量），不属于"推断出文献未明说的实质命题"，仅是把摘要断言拆解为
  "E1 + 显然逻辑"。curator 引用时若要精确到"哪个分量"，应引 E1；若要精确到"整个 𝔐₄"，应引 E1+此条。

### E3 证明方法：测试曲线 + 自由阶 6 自同构，显式 Čech 上同调计算
- 位置：§2–§5（正文核心，逐页读完）
- 类型：proposition（证明方法记录，非独立可引用陈述）
- 原文陈述（忠实转述）：取测试曲线 C: y² = x⁶ − 1（亏格 4 超椭圆曲线），配备自由（无不动点）阶 6 自同构
  σ(x,y) = (ζx, −y)，其中 ζ 为本原三次单位根；在此曲线的 Čech 上同调中显式算出第一障碍类分量的矩阵表示
  （矩阵元用本原 3/6 次单位根写出），直接计算得该矩阵/障碍类分量非零，从而 ω₂(𝔐₄^+) ≠ 0。
- 文献自称的严格程度："we prove"，显式计算，非存在性论证，方法论上与 Donagi–Witten 附录 A 的亏格 5
  显式例子同构（"找一条具体曲线 + 具体自同构，硬算障碍类分量非零"）。
- 文献列出的依赖：Green 1982 障碍类定义；Donagi–Witten 障碍理论框架；曲线自身的显式代数几何数据
  （超椭圆方程、自同构群作用）。
- 备注：无。

### E4 亏格 3（未紧化）非投影性：致谢部分明确列为"进行中"，尚未证明
- 位置：p.2，Acknowledgments
- 类型：definition（文献自陈现状，非定理）
- 原文陈述（逐字/接近逐字，L1 直接读取）：论文在致谢部分明确写道，亏格 3（未紧化）超模叠的非投影性
  "is a work in progress, joint with him [Mauricio Corrêa]" ——即截至本论文最新版本（v2, 2026-09-14），
  **亏格 3（未紧化）仍未被证明**。
- 文献自称的严格程度：作者自陈现状（不是定理，是研究进度说明）。
- 文献列出的依赖：无（这是一句关于未完成工作的陈述，不是证明）。
- 备注：**这直接、独立地核实了 `research/attempts/genus-five-supermeasure/proof.md` §1.2 对"亏格 3
  仍开放"的判断**——本条属于我方独立 L1 复核，非对 scoping 文档的背书性抄录。

### E5 文献自陈勘误：修正 Bryan–Donagi 2002 的一处笔误
- 位置：p.3，Remark 3.1
- 类型：definition（勘误说明）
- 原文陈述（忠实转述）：论文在 Remark 3.1 中明确指出，Bryan–Donagi 2002（参考文献 [1]）中一个显式例子
  里，本原单位根被误写为"六次"（sixth）单位根，实际应为"三次"（third）单位根；本论文的构造沿用了
  Bryan–Donagi 的例子并在此处顺带更正了这一处笔误。
- 文献自称的严格程度：作者自陈勘误，非定理内容。
- 文献列出的依赖：Bryan–Donagi 2002 原文相应段落。
- 备注：**印刷错误标记**——若 curator 或后续文献需要引用 Bryan–Donagi 2002 的这个具体例子，应以
  Donagi–Noja 2026 Remark 3.1 更正后的版本（本原三次单位根）为准，不要照抄 Bryan–Donagi 原文的"六次"
  措辞。

### E6 参考文献列表中发现的相邻论文（非本文断言，仅文献学记录）
- 位置：References
- 类型：definition（文献学记录）
- 原文陈述：论文参考文献 [2] 为 Corrêa–Noja, "Formal moduli and the splitting theory of supermanifolds"，
  arXiv:2605.03166（本抽取者在阅读过程中独立确认此 arXiv 号，未在原派工单的 P0–P1 列表中，属新发现）。
- 文献自称的严格程度：不适用（仅参考文献列表条目）。
- 文献列出的依赖：不适用。
- 备注：**提请 lead/curator 注意**：arXiv:2605.03166 是 Corrêa–Noja 关于超流形分裂理论的一篇"形式模"
  基础性论文，是 correa-noja-2026（arXiv:2606.06733）与本文共同依赖的背景文献；本轮未展开对它的独立抽取
  （超出派工单范围），仅记录其存在与 arXiv 号供后续派工参考。

## 未解决的疑问

1. **摘要文字的版本差异**：通过 `export.arxiv.org/api/query` 获取的摘要片段与 v2 PDF 正文首页摘要的
   遣词有细微差异（前者作"exhibiting an appropriate compact curve...and computing the restriction to
   it"，后者 PDF 原文作"constructing a morphism from a smooth projective curve...and computing the
   pullback"）。两者数学内容一致（都是"测试曲线 + 限制/拉回非零"的同一论证骨架），但字面表述不同，
   怀疑是 arXiv API 缓存了较早版本的摘要文本。**以 PDF v2 正文为准**（明确的 L1 来源），API 片段仅供
   交叉核对，不作为逐字引用依据。
2. E2 是否应该拆成独立图节点：本抽取者认为"整个 𝔐₄ 不可投影"这句可投影性断言，虽然逻辑推导平凡，但
   若 curator 要把它写成独立于"𝔐₄^+ 不可投影"的图节点，建议在该节点的 sources/note 里明确写清楚
   "证明只针对偶分量，全空间断言靠不交并的显然逻辑"，避免读图者误以为论文对奇分量也做了显式计算。
