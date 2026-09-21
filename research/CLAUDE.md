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

## sandbox/ 的真实用法（不是偷懒）

想开 attempt 前先在 `sandbox/` 乱算，**推荐做法**，不是偷懒。写得进去的：
- 一个 .md 文件，想到哪写到哪；
- 能跑就跑的代码/Lean 片段（不要求编译通过）；
- 「此路不通，因为 X」一句话，然后就可以扔那儿。

毕业标准：**有一个能立成图节点的命题**。在那之前全是草稿，零规则、零校验、零生命周期。

## 生命周期

1. **draft**：`theorem-prover` agent 起草/推进，claim.md + proof.md 逐步填充。
2. **under-review**：prover 自认为完成，请求 `graph-reviewer` 做对抗性审查（检查证明每一步是否严格跟随前提、是否有跳跃、边界情形是否遗漏）。
3. **verified** / **refuted**：graph-reviewer 裁定并写入 `status.yaml`，附具体理由。**判 `verified` 即结项**——除非根 CLAUDE.md 原则 8 的四种"必须审"情形出现，否则**不再回头复审**。想继续投入就去开新命题。`captain_confirmed` 仍记在卡上，但它**只在里程碑签字与对外发表两处是真门**，不阻塞毕业、不阻塞被建设（见根 CLAUDE.md「图是仪器，不是产品」）。
4. **毕业**：`verified` 的尝试即允许 `graph-curator` 按正常 `add-statement` 流程把结论写回 `graph/statements/`，**不必等 `captain_confirmed`**。此时 `sources` 指向本目录下的 `proof.md`，并在 `note` 里显式声明"本项目原创证明，非已发表文献，见 research/attempts/<slug>/proof.md"。`kind: proof`，`status` 按证明严格程度定（通常 `rigorous`；若已过 Lean 形式化验证走正常 `formal/` 流程升 `formalized`）。
5. **abandoned**：此路不通或被证伪，如实记录，不要删除（负面结果也是结果，省得后人重复踩坑）。

## 纪律

（只对 `research/attempts/**` 生效。`research/sandbox/**` 无任何规则——不校验、不需要 `claim.md`、不需要 `status.yaml`、不进生命周期、想删就删。开 attempt 之前先去 sandbox 乱算是推荐做法。）

- `claim.md` 要有精确到量词的命题表述，**但它的到期点是 `under-review`，不是开工**。先算、先试，等你确信有东西了再回头把命题写准。「没写 claim 就不算开始证明」这条规则挡住的是开始。
- **允许在猜想上施工。** 引用 `conjecture` / `physical-argument` 节点作砖块是正当研究——理论物理本来就是这么做的。工具会自动把结论的 `effective` 压到最弱砖块的档位（`propagate.py` 的 `_combine_deps`），**不需要你额外自律，也不需要标红**。唯一禁止的是毕业时把结论**标高**。
- `[GAP]` 标注是诚实记录，不是失败——宁可卡住也不要用含糊语言掩盖跳步。
- **放弃一条路只需一行**「此路不通，因为 X」，`state: abandoned`。不需要 post-mortem、不需要写进 ROADMAP。负面结果保留目录不删，省得后人重踩。
- 没有 pre-commit schema 校验（这里不是 YAML 图节点），但毕业进图前必须过一次正常的 `uv run stringgraph validate`。
