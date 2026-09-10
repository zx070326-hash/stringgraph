# formal/ — Lean 4 形式化岛

Lean `v4.33.1`，Mathlib 固定在 tag `v4.33.1`。工程名 `StringFormal`。

## 构建

```bash
cd formal
lake exe cache get      # 首次：拉 Mathlib 预编译缓存（需网络，数 GB）
lake build              # 构建全部
lake build StringFormal.Virasoro.Basic   # 只构建一个模块
```

### 在 worktree 里构建

worktree 没有 `.lake/`，重新下载 Mathlib 不现实，而 sandbox 禁止建符号链接。做法：在 worktree 的 `formal/.lake/package-overrides.json` 里把全部依赖改成指向主仓库 `D:/physics/string/formal/.lake/packages/<name>` 的 path 包（该文件被 gitignore，不会提交）；编译产物仍写在 worktree 本地。

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
  Virasoro/Witt.lean        Witt 代数（`ℤ →₀ R` 上的 LieRing/LieAlgebra 实例，任意交换环）
  Virasoro/Basic.lean       Virasoro 代数（Witt 的中心扩张，基于 Mathlib `LieAlgebra.ofTwoCocycle`）
  Virasoro/Verma.lean       Verma 模 V(c,h)：U(Vir) 商构造、最高权向量、万有性质、L_0 分级（无 PBW 基，V≠0 未证，见 TODO `pbw-verma`）
  Virasoro/VermaPBW.lean    有序词（分拆）张成 Verma 模 level 片，dim V_N ≤ p(N)；线性无关（PBW）未做
  Virasoro/ATTRIBUTION.md   本目录派生自何处（Kytölä `VirasoroProject`、Carnahan 的 Mathlib 文件）
  NoGhost/Fock.lean         D 个玻色振子的代数 Fock 空间、level 分级、CCR、η 诱导的对称双线性型（无零模，见文件头 gaps）
  NoGhost/FockSigned.lean   有序环上 Fock 形式不定（D ≥ 2），每个 level 都有负模态
  NoGhost/Sugawara.lean     L_n = ½Σ:α·α:、[L_m,α_p] = -p α_{m+p}、Virasoro 关系与 c = D（lie_Lop_Lop）、L_0 = α'k²+N；零模为标量参数
  NoGhost/PhysicalStates.lean  H_phys 子模、L_m^† = L_{-m}（pairing_Lop_left）、L_n 齐次性与 H_phys 的 level 分级、零模态/伪态、level 1 与 a₀=1 光子零模态
  NoGhost/Statement.lean    无鬼定理陈述（待 Fock 空间、Sugawara、DDF 就绪）
```

复用既有形式化的调研记录见 `NOTES-virasoro-reuse.md`。

分解任务见 `TODO.md`。

## 规则

- `autoImplicit` 已关闭。所有变量显式声明。
- 优先复用 Mathlib，其次 Physlib；引入 Physlib 依赖需要单独提交并说明版本。
- 一个岛一个子目录，岛之间不互相 import（Virasoro 是共享基础，例外）。
- 文件头写：对应图节点 id、使用的约定、当前状态。
- 命名遵循 Mathlib 风格：类型 `UpperCamel`，定理 `snake_case`。
