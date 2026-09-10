# 方法论：从 Prove2Me / FLT / Navier–Stokes 项目学到什么

调研日期 2026-09-10。来源列在文末。

## 直接沿用的机制

| 机制 | 来源 | 在本项目中的形态 |
|---|---|---|
| 陈述与证明分离，陈述不可变 | Prove2Me | `graph/statements/` 与 `graph/derivations/` 分开；改陈述即新建节点 |
| 审计面固定在核心 | Prove2Me | 只有 `graph/milestones/` 需要人确认 |
| 证明草图可导入未证陈述，得到条件结果 | Prove2Me "proof sketch" | 一条 derivation 可以依赖 `conjecture` 状态的节点；有效状态自动降级 |
| 回译审计 | Prove2Me | `physics-auditor` agent 只看形式陈述/YAML，翻回自然语言，人比对原文 |
| 里程碑作为规范化约定，防分叉 | Prove2Me "milestone" | 同一引理多种不兼容表述时，里程碑给出唯一规范版本 |
| 先搜后提，引用计入贡献 | Prove2Me "Formalpedia" | `stringgraph search`；每条 derivation 记录 `author` |
| 支持反证 | Prove2Me | `status: refuted`，`derivations` 可以是 `kind: refutation` |
| 只编译局部 | Prove2Me | 校验按文件增量；Lean 岛之间不互相依赖 |
| DAG 作为 agent 的外部记忆 | Anthropic FLT | agent 从 `stringgraph report --open` 挑任务，不靠自身上下文记项目状态 |
| 建在已有人类基础设施上 | Anthropic FLT（Imperial FLT、flt-regular） | Lean 岛建在 Mathlib + Physlib + 已有 Virasoro 形式化之上 |
| 把大目标拆成可证/可反证变体并行 | OpenAI NS | 沼泽地类猜想同时挂"成立"与"反例"两个方向的 derivation |
| 先攻跳板问题再播种 | OpenAI NS（先 Euler 后 NS） | 先无鬼定理，再反常消除 |

## 已知失败模式及对策

| 失败模式 | 来源 | 对策 |
|---|---|---|
| agent 丢失项目状态、停止协作 | Anthropic FLT 第一次尝试 | 图是唯一真相源；agent 每次从图读取状态 |
| 共享文件填 sorry 引发重编译级联 | Prove2Me 论文 | 一节点一文件；Lean 岛独立 |
| Git 中心化 PR 队列成为瓶颈 | Prove2Me 论文 | 每 agent 一 worktree，lead 合并；图文件粒度细，冲突少 |
| AI 生成的已证陈述只有约 43% 忠实原意 | Prove2Me 论文引用的审计 | 里程碑强制回译审计；非里程碑节点由 reviewer 抽查 |
| 多 agent 对同一引理给出不兼容表述 | Prove2Me | 里程碑规范化 + `conventions/` 显式约定 |
| 未发表工作的归属争议 | OpenAI NS / Buckmaster–Alpöge | 全部公开、每条节点有 author 与 source；不使用私有草稿 |

## 必须改的一处

Prove2Me 的组合性保证依赖每条边被 Lean 内核验证。弦论图里多数边做不到。所以节点状态不是二元的，而是有序等级（见 `STATUS_LEVELS.md`），一个节点的**有效状态**是它所有依赖的最低等级与自身状态的最小值，沿图向上传播。工具而不是人来算这个值。

## 来源

- Anthropic, "Formalizing Fermat's Last Theorem", 2026-09-04. https://www.anthropic.com/research/formalizing-fermats-last-theorem
- Chen, Marwaha, Lu, Yuen, Peng, "Prove2Me: An Open Collaborative Platform for Scaling Math Formalization", arXiv:2608.28433. https://arxiv.org/abs/2608.28433
- OpenAI, "On the Navier–Stokes Millennium Prize Problem", 2026-09-08. https://openai.com/index/navier-stokes-solution/
- TheoremGraph, arXiv:2606.25363（arXiv 数学文献的陈述级依赖抽取）
- LEAP, arXiv:2606.03303（DAG 作为证明记忆的消融实验）
- Physlib (leanprover-community/physlib)，原 PhysLean/HepLean
- "Virasoro algebra and Sugawara constructions formally in Lean", arXiv:2510.21741
