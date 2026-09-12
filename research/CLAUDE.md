# research/ — 原创证明工作区

这里存放**尚未发表、尚未验证**的原创证明尝试草稿。与 `graph/`（已发表结果的依赖图）物理隔离：`graph/` 里任何节点的 `depends_on` / `sources` 都**不得**指向这个目录下尚未毕业的内容。

## 为什么需要这个目录

`graph/` 的校验管道要求每条边可追溯到已发表来源（根 `CLAUDE.md` 原则 5）。原创证明没有"已发表来源"——证明本身就是产出。把未经验证的自证结果直接写进 `graph/` 会污染 `effective` 状态传播（别的节点可能已经在依赖一个其实还没审查过的结论）。`research/` 给这类工作一个独立的生命周期：草稿 → 审查 → 毕业，毕业后才允许进入 `graph/`。

## 结构

```
research/attempts/<slug>/
  claim.md      # 要证的精确命题：前提、记号、量词、断言本身，引用图中已有的 rigorous/formalized 节点作为已知砖块
  proof.md      # 论文级证明正文，人类可读，允许标 [GAP: ...] 未完成点
  status.yaml   # {state: draft|under-review|verified|refuted|abandoned, reviewer, verdict, notes, captain_confirmed}
  scripts/      # 可选：辅助穷举/验证用的脚本
  scratch.lean  # 可选：Lean 草稿实验，不受 formal/ 的 sorry 约束
```

## 生命周期

1. **draft**：`theorem-prover` agent 起草/推进，claim.md + proof.md 逐步填充。
2. **under-review**：prover 自认为完成，请求 `graph-reviewer` 做对抗性审查（检查证明每一步是否严格跟随前提、是否有跳跃、边界情形是否遗漏）。
3. **verified** / **refuted**：graph-reviewer 裁定并写入 `status.yaml`，附具体理由。`verified` 仍建议加 `captain_confirmed: false`，等人类船长最终确认后改 `true`（效仿里程碑 `audit.status: approved` 专属船长的先例）。
4. **毕业**：只有 `verified`（且最好 `captain_confirmed: true`）的尝试，才允许 `graph-curator` 按正常 `add-statement` 流程把结论写回 `graph/statements/`。此时 `sources` 指向本目录下的 `proof.md`，并在 `note` 里显式声明"本项目原创证明，非已发表文献，见 research/attempts/<slug>/proof.md"。`kind: proof`，`status` 按证明严格程度定（通常 `rigorous`；若已过 Lean 形式化验证走正常 `formal/` 流程升 `formalized`）。
5. **abandoned**：此路不通或被证伪，如实记录，不要删除（负面结果也是结果，省得后人重复踩坑）。

## 纪律

- `claim.md` 必须先于 `proof.md` 写清楚：没有精确到量词的命题表述，不算开始证明。
- 证明只能引用图里 `effective status` 为 `rigorous`/`formalized` 的节点作为砖块；引用 `conjecture`/`physical-argument` 节点等于在猜想上叠猜想，必须标红。
- `[GAP]` 标注是诚实记录，不是失败——宁可卡住也不要用含糊语言掩盖跳步。
- 没有 pre-commit schema 校验（这里不是 YAML 图节点），但毕业进图前必须过一次正常的 `uv run stringgraph validate`。
