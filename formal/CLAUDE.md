# formal/ — Lean 4 形式化岛

Lean `v4.33.1`，Mathlib 固定在 tag `v4.33.1`。工程名 `StringFormal`。

## 构建

```bash
cd formal
lake exe cache get      # 首次：拉 Mathlib 预编译缓存（需网络，数 GB）
lake build              # 构建全部
lake build StringFormal.Virasoro.Basic   # 只构建一个模块
```

## 与图的关系

- 图节点通过 `formal.lean_decl` 与 `formal.lean_file` 指向这里的声明。`stringgraph validate` 检查文件存在。
- 只有 **无 sorry、无新增公理** 编译通过的声明才能让对应推导标 `formalized`。检查方式：
  ```bash
  lake env lean --run scripts/check_axioms.lean <DeclName>   # 待写
  ```
  在此之前，用 `#print axioms <DeclName>` 手工确认只出现 `propext`、`Classical.choice`、`Quot.sound`。
- **禁止**为了让 `validate` 通过而写带 `sorry` 的陈述。没准备好就不写声明，像 `NoGhost/Statement.lean` 那样在文件头写清楚。

## 目录

```
StringFormal/
  Virasoro/Basic.lean       Virasoro 代数（占位，待换成真正的 LieAlgebra 实例或复用 arXiv:2510.21741）
  NoGhost/Statement.lean    无鬼定理陈述（待 Fock 空间、Sugawara、DDF 就绪）
```

分解任务见 `TODO.md`。

## 规则

- `autoImplicit` 已关闭。所有变量显式声明。
- 优先复用 Mathlib，其次 Physlib；引入 Physlib 依赖需要单独提交并说明版本。
- 一个岛一个子目录，岛之间不互相 import（Virasoro 是共享基础，例外）。
- 文件头写：对应图节点 id、使用的约定、当前状态。
- 命名遵循 Mathlib 风格：类型 `UpperCamel`，定理 `snake_case`。
