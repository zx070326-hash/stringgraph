# 路线图

## Phase 0：骨架与种子数据（当前）

- [x] 目录结构、CLAUDE.md、agent 角色、skill
- [x] 节点/边/里程碑 schema
- [x] 校验、状态传播、报告、搜索、dot 导出工具
- [x] 种子节点：从 Virasoro 代数到无鬼定理的最短链
- [x] Lean 工程能 `lake build`（2026-09-10 验证：929 jobs 全过）
- [x] 第一次完整 `validate` + `report` 通过并提交

## Phase 1：世界面理论子图（目标：约 150 个节点）

覆盖 Polchinski 第一卷第 1–4 章和第二卷第 10–12 章能陈述为命题的内容：
- 玻色弦：Nambu–Goto / Polyakov 作用量、共形规范、Virasoro 约束、光锥量子化、临界维数、无鬼定理、树级振幅
- 超弦：RNS、GSO 投影、旋量场、临界维数 10
- 里程碑：`no-ghost-theorem`、`critical-dimension-bosonic`、`critical-dimension-superstring`

同步：Lean 岛 1 无鬼定理形式化。

## Phase 2：一致性与对偶子图

- Green–Schwarz 反常消除、T 对偶（环面）、S 对偶（猜想）、五种超弦与 M 理论关系
- 这一阶段的目的是让报告第一次显示"哪些结论压在哪些猜想上"
- Lean 岛 2：Green–Schwarz 反常多项式的因子化（代数部分）

## Phase 3：全息与黑洞

- AdS/CFT（作为 axiom/conjecture 双轨）、Strominger–Vafa 熵、Ryu–Takayanagi、岛公式
- 目标产出：一份公开报告，列出全息扇区每条主要结论的猜想依赖集合

## Phase 4：沼泽地

- 每条沼泽地猜想双轨挂载（成立方向 / 反例方向）
- 与观测约束（暗能量演化等）的接口节点

## 长期

- 与 TheoremGraph / Physlib 对接，导入导出
- 向 Prove2Me 提交里程碑作为 mission

## 待裁决（来自第一批 agent 的建议，lead 尚未决定）

- **`worldsheet.ope-convergence` 公理节点**（researcher Q3）：Polchinski 用围道变形从 OPE 推 Virasoro 代数，书中不证 OPE 收敛。图里现有的 `virasoro-algebra` 是抽象李代数定义，本身 rigorous，不受影响；受影响的是尚未建立的"自由玻色子的 Sugawara 构造满足 Virasoro 关系"一类节点。建 Sugawara 节点时再决定是否挂此公理。
- **`worldsheet.virasoro-algebra` 拆卡**（formalizer）：定义部分已形式化，"唯一非平凡中心扩张"未形式化。拆成定义卡（可标 formalized）+ 唯一性命题卡。
- **a<1 分支的文献出处**：GT 1972 / Brower 1972 只覆盖 a=1。候选 Thorn 1987（已登记 `thorn-1987`）。
- **原书核对**：Polchinski v1 抽取全部依赖二手源；E34（c=D 锚点）、E53、E58 三条主线陈述需持原书者核对。GT 1972 与 Brower 1972 正文在付费墙后。
