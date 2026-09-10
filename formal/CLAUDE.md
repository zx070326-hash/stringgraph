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

worktree 没有 `.lake/`，重新下载 Mathlib 不现实，而 sandbox 禁止建符号链接。做法：在 worktree 的 `formal/.lake/package-overrides.json` 里把全部依赖改成指向主仓库 `D:/physics/string/formal/.lake/packages/<name>` 的 path 包（该文件被 gitignore，不会提交）；编译产物仍写在 worktree 本地。**再把主仓库的 `formal/.lake/build/`（约 45 MB，StringFormal 自身的 olean）整目录复制到 worktree 的 `formal/.lake/build/`**，这样 `lake build` 只增量编译你新加的模块，几秒完成；否则要从头编 StringFormal 全部模块（约 10 分钟），两名 formalizer 曾因此在开工阶段停摆。

**`package-overrides.json` 的格式是 lake manifest 的片段，不是 `{"名字": "路径"}` 映射**（写错格式 lake 会静默忽略/报 `property not found: schemaVersion`，然后**从 github 重新 clone 2.2 GB 的 mathlib 并从源码开始编译**，一名 formalizer 因此空转 40 分钟）：

```json
{"schemaVersion": "1.2.0",
 "packages": [
   {"type": "path", "name": "mathlib", "scope": "",
    "dir": "D:/physics/string/formal/.lake/packages/mathlib",
    "inherited": false, "configFile": "lakefile.lean",
    "manifestFile": "lake-manifest.json"},
   ...其余 8 个：plausible / LeanSearchClient / importGraph / proofwidgets /
      aesop / Qq / batteries（scope "leanprover-community"）与 Cli（scope "leanprover"），
      inherited 均为 true，configFile 照抄 lake-manifest.json（proofwidgets 是 lakefile.lean，
      其余是 lakefile.toml）
 ]}
```

`name` / `scope` / `configFile` 必须与 `formal/lake-manifest.json` 里对应条目一致。写好后若 worktree 里已经有被误 clone 的 `formal/.lake/packages/`，要先 `rm -rf` 掉，lake 才会走 override。验证成功的标志：`lake build` 打印的 `LEAN_PATH` 里 mathlib 指向 `D:\physics\string\formal\.lake\packages\...`，且构建在 10 秒内完成。

### 读大文件的纪律

`Sugawara.lean`（约 1400 行）、`VertexOperator.lean`（约 800 行）、`PhysicalStates.lean`（约 800 行）**不要整文件 Read**：三名 formalizer 曾在"读源文件"阶段停摆。一律 `grep -n "<声明名>"` 定位，再 `sed -n a,bp` 读几十行。任务拆小：一个声明一次提交。

## 与图的关系

- 图节点通过 `formal.lean_decl` 与 `formal.lean_file` 指向这里的声明。`stringgraph validate` 检查文件存在。
- 只有 **无 sorry、无新增公理** 编译通过的声明才能让对应推导标 `formalized`。检查方式（先 `lake build`）：
  ```bash
  cd formal
  lake env lean --run scripts/check_axioms.lean StringFormal.NoGhost.Fock.lie_Lop_Lop
  lake env lean --run scripts/check_axioms.lean --all < names.txt   # 名字表从 stdin 读
  ```
  输出每行 `<ok|bad|missing>\t<声明名>\t<公理集合>`；只要出现 `propext`、`Classical.choice`、
  `Quot.sound` 之外的公理（`sorryAx` 也是公理）或声明不存在，就退出 1。交互式开发时
  `#print axioms <DeclName>` 仍然更快。
- 全图一次过：`uv run stringgraph check-axioms`（可加 `--json` / `--formalized-only` / `--decl NAME`），
  它把上面脚本的结论映回节点 id，非标准公理会指名是哪个陈述卡和哪条 `formalized` 推导。
  这条命令**不在** `validate` 和 pre-commit 里（要起 Lean，太慢），改完 Lean 后自己跑。
- **禁止**为了让 `validate` 通过而写带 `sorry` 的陈述。没准备好就不写声明，像 `NoGhost/Statement.lean` 那样在文件头写清楚。

## 目录

```
StringFormal/
  Math/EulerPartition.lean  Euler 分拆生成函数 Σ p(N) X^N = ∏_{n≥1}(1-X^n)^{-1}（`PowerSeries`，
                            无逆元形式对任意交换环成立；域上给 `⁻¹` 形式）。独立小岛，不 import 其他子目录
  Virasoro/Witt.lean        Witt 代数（`ℤ →₀ R` 上的 LieRing/LieAlgebra 实例，任意交换环）
  Virasoro/Basic.lean       Virasoro 代数（Witt 的中心扩张，基于 Mathlib `LieAlgebra.ofTwoCocycle`）
  Virasoro/Verma.lean       Verma 模 V(c,h)：U(Vir) 商构造、最高权向量、万有性质、L_0 分级（无 PBW 基，V≠0 未证，见 TODO `pbw-verma`）
  Virasoro/VermaPBW.lean    有序词（分拆）张成 Verma 模 level 片，dim V_N ≤ p(N)；线性无关（PBW）未做
  Virasoro/WittPerfect.lean  Witt 完美 ⟺ 2 可逆（derivedSeries_one_eq_top_iff）；ℚ-代数上 Witt 与 Virasoro 完美（isPerfect），C = 2[L₂,L₋₂] − 4[L₁,L₋₁]
  Virasoro/DescendantGrading.lean  任意 Virasoro 模上 L_0 对词作用的本征值公式（只需 L_0 v = h v）；wordActOn、vermaLift_wordAct
  Virasoro/Shapovalov.lean   Shapovalov（逆变）形式：反对合 σ、唯一性/对称性/level 正交（无条件）、存在性 ⟺ V(c,h)≠0、N≤2 Gram（det₂ = 2h(16h²+2h(c−5)+c)）
  Virasoro/ATTRIBUTION.md   本目录派生自何处（Kytölä `VirasoroProject`、Carnahan 的 Mathlib 文件）
  Math/MobiusJacobian.lean   Möbius 三点固定 Jacobian（Vandermonde n=3，det = −z₁₂z₁₃z₂₃）；Mandelstam s+t+u = Σm²（任意对称双线性型）
  NoGhost/Fock.lean         D 个玻色振子的代数 Fock 空间、level 分级、CCR、η 诱导的对称双线性型（无零模，见文件头 gaps）
  NoGhost/FockSigned.lean   有序环上 Fock 形式不定（D ≥ 2），每个 level 都有负模态
  NoGhost/Sugawara.lean     L_n = ½Σ:α·α:、[L_m,α_p] = -p α_{m+p}、Virasoro 关系与 c = D（lie_Lop_Lop）、L_0 = α'k²+N；零模为标量参数
  NoGhost/PhysicalStates.lean  H_phys 子模、L_m^† = L_{-m}（pairing_Lop_left）、L_n 齐次性与 H_phys 的 level 分级、零模态/伪态、level 1 与 a₀=1 光子零模态
  NoGhost/LevelTwo.lean     level-2 标量态 ψ₂ = [α_{-1}·α_{-1}+c₂(a·α_{-2})+c₃(a·α_{-1})²]|k⟩：
                            L₁/L₂ 物理态条件、闭式模 (4a₀-9)²⟨ψ₂,ψ₂⟩=2(D-1)[16a₀²+(2D-74)a₀+84-3D]、
                            有序域上 D>26 的显式负模物理态（见文件头 gaps）
  NoGhost/VertexOperator.lean  指数顶点算子 :e^{ic·X}: 的振子部分：产生半 = 乘以 creaExp、
                            湮灭半 = 变量平移 vertexSub；vertexOsc η b K 的模态代数
                            [α^μ_p, V_K] = b^μ V_{K-p}、level 分级、刚性（见文件头 gaps）
  NoGhost/DDF.lean          DDF 动量塔 ℤ →₀ Fock D R、移位算子 e^{i n k_0·x}、塔上的
                            α^μ_p / L_n / 顶点算子；含 p=0 的模态代数与横向性；
                            无 [L_m, V]，无 A^i_n 本身（见文件头 gaps）
  NoGhost/TowerPairing.lean   动量塔上的双线性型 towerPairing = Σ_j ⟨·_j,·_j⟩（BilinForm）：层间正交、
                            对称、towerShift/towerMode/towerLop 的伴随（见文件头 gaps）
  NoGhost/VertexWeight.lean   顶点算子共形权：creaExp 欧拉递推、真空上 L_m Φ_J（m ≥ 0）、**m ≥ 1 的 [L_m, V_J] 恒等式**（lie_Lop_vertexOsc_of_pos）与塔上版本（k_0²=0 时 [L_m, V^{(n)}_K] = (K−m)V^{(n)}_{K−m}）
  NoGhost/VertexWeightNeg.lean  **m < 0 半**：L_m 真空显式和、Φ_J 真空关系、lie_Lop_vertexOsc_of_neg；合并版 lie_Lop_vertexOsc_of_ne（m ≠ 0）
  NoGhost/VertexWeightZero.lean  m = 0：lie_Lop_vertexOsc_zero；**合并版 lie_Lop_vertexOsc（每个 m ∈ ℤ，同一多项式系数）**。m = 0 只是真空引理不同（差 ½a·a，在对易子里抵消）
  NoGhost/DDFOperatorNeg.lean  塔版 lie_towerLop_towerVertex_of_ne（m ≠ 0）；**lie_towerLop_ddfOp_of_ne：[L_m, A^ε_n] = 0 对所有 m ≠ 0**（窗口两端各留 |m| 余量）；剩塔版 m = 0
  NoGhost/DDFOperator.lean  横向 DDF 算子 A^ε_n = Σ_j α^ε_j V^{(n)}_j：偏振收缩 towerModeVec、
                            level/mode 上界（Fock.levelBound、towerLevelBound、towerModeBound）、
                            **局部有限性 ddfSummand_apply_eq_zero_of_notMem_window**（横向性给上端截断）、
                            lsumLocFin 组装的 ddfOp、**⁅L_m, A^ε_n⁆ = 0（m ≥ 1）**；
                            m ≤ 0、[A,A] 振子代数、保物理子空间均未做（见文件头 gaps）
  NoGhost/QuotientForm.lean   H_phys/H_null 上诱导形式：pairing_add_null、nullInPhys、PhysQuot、
                            quotientPairing（两次 liftQ）与 quotientPairing_mk（见文件头 gaps）
  NoGhost/SpuriousShell.lean  带壳伪态 spuriousShell = S ⊓ ker(L_0 − a₀)、零态 nullStates、nullStates_eq、nullStates ≤ nullSubmodule
  NoGhost/LevelTwo.lean      level-2 标量物理态闭式 (4a₀−9)²⟨ψ₂,ψ₂⟩ = 2(D−1)[16a₀²+(2D−74)a₀+84−3D]；a₀=1、D>26 有序域上存在负模物理态（exists_mem_physSubmodule_pairing_self_neg）
  NoGhost/Statement.lean    无鬼定理陈述（待 Fock 空间、Sugawara、DDF 就绪）
scripts/
  check_axioms.lean         公理审计：给定声明名输出其公理集合，出现非标准公理或声明不存在则退出 1
```

复用既有形式化的调研记录见 `NOTES-virasoro-reuse.md`。

分解任务见 `TODO.md`。挑下一个目标用 `uv run stringgraph report` 末尾的 **formalization frontier**（所有依赖已 formalized、自身未形式化的节点），比 TODO 更实时。

## 规则

- `autoImplicit` 已关闭。所有变量显式声明。
- 优先复用 Mathlib，其次 Physlib；引入 Physlib 依赖需要单独提交并说明版本。
- 一个岛一个子目录，岛之间不互相 import（Virasoro 是共享基础，例外）。
- 文件头写：对应图节点 id、使用的约定、当前状态。
- 命名遵循 Mathlib 风格：类型 `UpperCamel`，定理 `snake_case`。
