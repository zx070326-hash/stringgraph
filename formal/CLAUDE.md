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
  Math/DedekindEtaS.lean    η 的 S 变换 `η(−1/τ) = (−iτ)^{1/2}η(τ)`（把 Mathlib 的 `(√i)⁻¹√z` 归一化到弦论形状）
  Math/DedekindEtaT.lean    η 的 T 变换 `η(τ+1) = e^{iπ/12}η(τ)`（Mathlib 无；从定义直接证）。**无条件成立，
                            不需要 Im z > 0**；含 `τ₂|η|⁴` 的 T 不变性，与 S 版合成两个生成元
  Math/DedekindEtaModular.lean  `τ₂|η(τ)|⁴` 在**整个 SL(2,ℤ)** 下不变（对 `Subgroup.closure` 归纳，
                            谓词必须取 `∀ τ` 形，因为 inv 分支在 `g⁻¹•τ` 用归纳假设）；
                            `τ₂ⁿ|η|⁴ⁿ` 与 `τ₂¹²|η|⁴⁸`（玻色单圈被积函数的倒数）。**乘子系统仍缺**；
                            测度 `d²τ/τ₂²` 的不变性已移到 `Math/TorusMeasure.lean`（本文件 η-only）
  Math/ModularGroupGenerators.lean  S、T 生成 `PSL(2,ℤ)` 且 `S² = (ST)³ = 1`（图卡
                            `worldsheet.modular-group-generated-by-s-and-t`）。`SL(2,ℤ)` 层的生成定理
                            是 Mathlib 的 `SpecialLinearGroup.SL2Z_generators`（本项目只再导出），
                            新做的是 `(ST)³ = −1` 与到 `SL/Z` 的搬运。**不**证 presentation
                            （`PSL ≅ ℤ/2 ∗ ℤ/3`）；`Z(SL(2,ℤ)) = {±1}` 在
                            `Math/MathlibBridges.lean` 的 `center_eq_pm_one`
  Math/TorusMeasure.lean    测度 `dτ dτ̄/τ₂²` 的 `SL(2,ℤ)` 不变性（图卡
                            `spectrum.torus-measure-modular-invariant`）。两层：逐点层从头证
                            `mobius_deriv`（dτ'/dτ = 1/(cτ+d)²）、`im_smul_mul_normSq`（τ₂'|cτ+d|² = τ₂）
                            → `measure_density_modular_invariant`；测度层把 Mathlib 的
                            `SMulInvariantMeasure (GL (Fin 2) ℝ) ℍ volume` 搬到 `SL(2,ℤ)` 得
                            `measure_smul_eq`（任意子集，无可测性假设），并用
                            `volume_eq_lintegral_inv_im_sq` 把 Mathlib 权重 `(1/‖y‖₊)²` 钉成 `1/τ₂²`。
                            η-free；**取向版（带符号的 2-形式 dτ ∧ dτ̄）未形式化**
  Math/MathlibBridges.lean  **桥层**（`namespace StringFormal.Bridge`）：`math.dedekind-eta-function`
                            与 `worldsheet.modular-group-psl2z` 两张定义卡。η 侧把 Mathlib 的
                            `ModularForm.eta` 逐字展开成 `q^{1/24}∏(1−q^n)` 并接上分支约定
                            `q = e^{2πiτ}`、`q^{1/24} = e^{πiτ/12}`；PSL 侧给出 `(aτ+b)/(cτ+d)`、
                            `Im(γτ) = Imτ/|cτ+d|²`、S/T 的作用、**`Z(SL(2,ℤ)) = {±I}`**
                            （`center_eq_pm_one`，Mathlib 与本项目此前都没有）与作用降到
                            `PSL(2,ℤ)`（`MulAction PSL2Z ℍ`）
  Virasoro/Witt.lean        Witt 代数（`ℤ →₀ R` 上的 LieRing/LieAlgebra 实例，任意交换环）
  Virasoro/Basic.lean       Virasoro 代数（Witt 的中心扩张，基于 Mathlib `LieAlgebra.ofTwoCocycle`）
  Virasoro/Verma.lean       Verma 模 V(c,h)：U(Vir) 商构造、最高权向量、万有性质、L_0 分级（无 PBW 基，V≠0 未证，见 TODO `pbw-verma`）
  Virasoro/VermaPBW.lean    有序词（分拆）张成 Verma 模 level 片，dim V_N ≤ p(N)；线性无关（PBW）未做
  Virasoro/WittPerfect.lean  Witt 完美 ⟺ 2 可逆（derivedSeries_one_eq_top_iff）；ℚ-代数上 Witt 与 Virasoro 完美（isPerfect），C = 2[L₂,L₋₂] − 4[L₁,L₋₁]
  Virasoro/DescendantGrading.lean  任意 Virasoro 模上 L_0 对词作用的本征值公式（只需 L_0 v = h v）；wordActOn、vermaLift_wordAct
  Virasoro/Shapovalov.lean   Shapovalov（逆变）形式：反对合 σ、唯一性/对称性/level 正交（无条件）、存在性 ⟺ V(c,h)≠0、N≤2 Gram（det₂ = 2h(16h²+2h(c−5)+c)）
  Virasoro/ShapovalovLevelThree.lean  N=3 Gram（3×3，det₃ = 48h²(…)(…)）**与 Kac 形式相等在 Lean 内**（清分母对称函数，与 √ 分支无关）
  Virasoro/ShapovalovLevelFour.lean   N=4 Gram（5×5，60 声明；det₄ = 384h³(8h+c−1)(…)²(…)(…)；⟨L₋₂²v,L₋₂²v⟩ 含 c²/2 是 N≤4 唯一非整系数项；c=1 退化非完全平方）
  Virasoro/ShapovalovLevelThree.lean   level-3 Gram（9 个内积）与 det₃ = 48h²(16h²+2h(c−5)+c)(3h²+h(c−7)+c+2)，及其与 Kac 公式 N=3 乘积形 2304(h−h₁₁)²(h−h₁₂)(h−h₂₁)(h−h₁₃)(h−h₃₁) 的等同
  Virasoro/ATTRIBUTION.md   本目录派生自何处（Kytölä `VirasoroProject`、Carnahan 的 Mathlib 文件）
  Math/MobiusJacobian.lean   Möbius 三点固定 Jacobian（Vandermonde n=3，det = −z₁₂z₁₃z₂₃）；Mandelstam s+t+u = Σm²（任意对称双线性型）
  Math/FiniteCounts.lean    六边形奇数扭转数 Σ_{k odd} C(6,k) = 32（GS (12c) 的"32"）；**GSO 扇区穷举**（Polchinski §10.6 (a)(b)(c) 字面有 10 解，maximal 者恰 6 个 = IIA/IIB/IIA′/IIB′/0A/0B——"maximality" 是原书未明说的第四条件）
  Math/AnomalyPolynomial.lean  Polchinski (12.2.27)+(12.2.28) ≡ (12.2.11)+(12.2.12)（`ring`，同时验证 ADT (7)）；IIB 引力反常整数解 (2,−2,1) 射线（三式秩 2 非 3）；GS (20) = −96 × Polchinski 引力部分
  Math/IIBAnomalyUnique.lean  Bilal (12.4) 的 3×3 整数矩阵 A（行 = tr R⁶ / tr R⁴tr R² / (tr R²)³ 的系数）：**显式线性关系 2r₁+3r₂−5r₃ = 0**（两本书都只说"线性相关"不给关系）、det = 0、2×2 子式 −720（三者对**任意交换环**）、**ker A = ℚ·(2,−2,1)** 与整数版 ker_ℤ A = ℤ·(2,−2,1)、`rank_ℚ A = 2`（秩–零化度，非子式）。独立于 AnomalyPolynomial.lean 重证核，只 import Mathlib
  Math/DedekindEtaS.lean           η(−1/τ) = (−iτ)^{1/2}η(τ)（cpow 主分支，无假设）由 Mathlib `ModularForm.eta_comp_eq_csqrt_I_inv` + 自证 `csqrt_neg_I_mul`；τ₂|η|⁴ 的 S 不变性
  Math/E8Roots.lean       E₈ 240 根显式列表；幂和 Σ(α·x)^k = 60Σx² / 36(Σx²)² / 30(Σx²)³ 对**任意 x ∈ ℚ⁸**（分块 + 符号二项展开，避免 240 项 ring）；⇒ (12b′)(12c′)。**Tr₂₄₈ = 根幂和 + Chevalley 限制**是 docstring 假设不在 Lean 内
  Math/GreenSchwarzAlgebraGen.lean  GS 因子化在**任意交换 ℚ-代数**上（scope 修正：Ω 形式活在带幂零元的环，非域；技巧：`h48 : 48 * algebraMap ℚ R (1/48) = 1` 由 `map_ofNat`+`norm_num`，再 `linear_combination`）；`mixed_anomaly_so_each_gives_32`、`tr_f6_usp_ge_33`
  NoGhost/FockGram.lean            创生单项式 Gram 矩阵对角、`∏ n^d d!`；条件版 `pairing_creationMonomial_of_hypotheses`（任意双线性型 + (H2)(H3)(H4)）；`ZMod 2` 退化反例（需特征零）
  Virasoro/GenericIndependence.lean  `linearIndependent_of_gram_det_ne_zero`（任意交换整环、任意双线性型）；N≤4 Kac 行列式非零 ⇒ p(N) 个标准子态线性无关；**`finrank_levelSpan_{two,three,four}` = 2/3/5**（上界靠 `ordWord_sum_{three,four}` 枚举有序词，**不需要 `Nat.Partition` 计数**）；c=1,h=1/4 零向量 (L₋₂−L₋₁²)v
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
  NoGhost/DDFOperatorAll.lean  塔版 lie_towerLop_towerVertex（**每个 m ∈ ℤ**，由 Fock.lie_Lop_vertexOsc 搬运）；**lie_towerLop_ddfOp：[L_m, A^ε_n] = 0 对一切 m**（m = 0 时窗口余量为 0，边带为空，逐项自消）；**ddfOp_mem_towerL0Submodule / ddfOp_mem_towerPhysSubmodule**（A^ε_n 保持塔上物理子空间）
  NoGhost/TowerPhysical.lean  塔上物理子模 towerPositiveModeSubmodule / towerL0Submodule / towerPhysSubmodule（**统一截距 a₀**：塔上 L_0 在层 j 已用该层动量，条件 α'k² + j + N = a₀ 选出反对角线）；**ddfOp_mem_towerPositiveModeSubmodule**（A^ε_n 保持正模条件）；保持 L_0 条件见 DDFOperatorAll.lean
  NoGhost/VertexCommute.lean  b·b′ = 0 ⇒ 顶点算子对易（vertexOsc_comm_of_dotVec_zero；E₊ 穿过 E₋ 只在此用正交性，E₋E₋ = E₋(b+b′) 对任意动量）；塔上 k_0²=0 ⇒ towerVertex 对易（**k_0² ≠ 0 时有单值性因子，不对易**）；[A,A] 剩同点乘积局部有限性 + 全导数留数
  NoGhost/VertexProduct.lean  b·b′=0 ⇒ 同点乘积 Σ_{J+K=L} V^{(b)}_J V^{(b′)}_K = V^{(b+b′)}_L（vertexProduct_eq_vertexOsc_add；levelBound_vertexAnn_le 对 M 一致）；塔版 sum_towerVertex_towerVertex_of_isotropic。**b·b′≠0 时为假**（(1−w/z)^{−b·b′} 混合所有指标）。(5b) Σ_j j V_j V_{−j} = mδ **不是** (5a) 推论（L_0 Leibniz 只见权和）
  NoGhost/VertexAdjoint.lean  Fock 配对下顶点算子伴随 pairing (V(b)_K v) w = pairing v (V(−b)_{−K} w)（**任意 b，不需 b·b=0，无重排序步**——E₋E₊ 的伴随本身正规序）；塔版 (V^{(n)}_K)† = V^{(−n)}_{−K}；**(A^ε_n)† = A^ε_{−n}**（towerPairing_ddfOp_left）。同动量版本被证伪（2b=0）
  NoGhost/VertexWeightedSum.lean  (5b) Σ_j j V^{(m)}_j V^{(n)}_{−j} = m δ_{m+n,0}（塔上）；关键原子**电流权恒等式** Σ_J (b·α_{−J}) V^{(b)}_{L−J} = (L + b·a) V^{(b)}_L（vertexCurrent_eq；常数含 b·a）；"全导数" = 权恒等式用两次；k_0²=0 用三次、2α'k_0·p=1 用一次（给出 m）；ℚ-代数必需（除 m+n）。剩 [A,A] 的 Leibniz 组装
  NoGhost/DDFAlgebra.lean   **横向 DDF 振子代数 ⁅A^ε_m, A^δ_n⁆ = m(ε·δ)δ_{m+n,0}**（lie_ddfOp_ddfOp，一切 m,n ∈ ℤ）：塔上 CCR lie_towerMode_towerMode、偏振 CCR **lie_towerModeVec_towerModeVec**（三个度规因子塌成一个，**η²=1 首次进中心项**）、二重有限和 ddfOp_mul_ddfOp_apply。两个横向性**各用一次**（δ·k_0 在正序、ε·k_0 在反序）；窗口用 `Finset.biUnion` 绕开对 α^δ_l V^{(n)}_l x 的显式 level/mode 界，公共指标集取 U = V ∪ (−V)。`Module.End` 上 `sub_mul` / `← LieRing.of_associative_ring_bracket` 的 `rw` 匹配不上（实例路径不同），一律 congrArg 到向量层再 simp
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
- **桥层规则**：Mathlib 已有的定义/定理，**不要在本项目里重新定义**（重定义等于凭空多一份未经
  验证的副本，还要自己证两者相等）。做法是在 `StringFormal/Math/MathlibBridges.lean` 的
  `namespace StringFormal.Bridge` 下写一条**逐字重述定理**——陈述完全照图卡的公式，证明是
  `rfl` / `simp [定义]` / 直接引用 Mathlib 引理——卡的 `formal.lean_decl` 指桥层那条。
  这样 `lean_file` 落在 `formal/` 下（工具要求），而数学内容仍然 100% 是 Mathlib 的。
  桥层定理的 docstring 必须点名它对应哪张卡、引用的是哪条 Mathlib 声明。
- 一个岛一个子目录，岛之间不互相 import（Virasoro 是共享基础，例外）。
- 文件头写：对应图节点 id、使用的约定、当前状态。
- 命名遵循 Mathlib 风格：类型 `UpperCamel`，定理 `snake_case`。
