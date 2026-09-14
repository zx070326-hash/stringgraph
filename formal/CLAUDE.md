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
  Math/PartitionCard.lean   `p(n) = Fintype.card (Nat.Partition n)` 的显式值（n = 2,3,4,5 为 2,3,5,7）。
                            Mathlib 无任何 `Nat.Partition` 基数引理，且 `decide` 化不开（实例经
                            `Fintype.ofSurjective` → `Composition` → `Finset.sort` → `List.mergeSort`，
                            良基递归）。桥引理 `card_partition_eq_card` 把计数搬到显式
                            `Finset (Multiset ℕ)` 字面量上（那里 `decide` 可用），穷尽性靠剥一个
                            部分 + 对总和递归。使 `finrank_levelSpan_le_card_partition` 可在 N ≤ 5 取数值
  Math/EulerPoincare.lean   **Euler–Poincaré 原理** Σ(−1)ⁿ dim Cⁿ = Σ(−1)ⁿ dim Hⁿ（图卡 `math.euler-poincare-principle`）。
                            **Mathlib 只有定义没有定理**：`Algebra/Homology/EulerCharacteristic.lean` 给了
                            `eulerChar` / `homologyEulerChar` 与它们的 finsum↔Finset 搬运，**没有**
                            `eulerChar = homologyEulerChar`，所以不走桥层。索引照 `HomologicalComplex`
                            用**双索引** `d m n : C m →ₗ C n`（`n ≠ m+1` 时为 0），使
                            `cocycles = ker (d n (n+1))` 与 `coboundaries = range (d (n-1) n)` 同为
                            `Submodule K (C n)`，**全程无 cast**；`IsComplex.comp_eq_zero` 故意对**任意三元组**
                            `l m n` 陈述（非相邻时由 shape 自动成立），这样在 `(n-1,n,n+1)` 处用它不需任何指标运算。
                            **分次是真的 ℤ**：符号用 Mathlib 的 `Int.negOnePow`，求和在 `Finset.Ico a b`，
                            电报项 `F n = (−1)ⁿ dim Bⁿ`。`n+1-1 = n` 这一步用
                            `congrArg (fun m => range (d m (n+1)))`（该函数的值域 `Submodule K (C (n+1))`
                            不依赖 m，故无需 dependent rewrite；`simp only [h]` 在此处会失败）。
                            声明：`euler_poincare`（卡面 (1)，前件 `Subsingleton (C (a-1))` 与 `Subsingleton (C b)`）、
                            `euler_poincare_finsum`（全分次 `∑ᶠ`，前件是卡面的「只有有限多个 Cⁿ ≠ 0」）、
                            `finrank_cohomology_zero_eq`（卡面「特别地」）、`euler_poincare_graded`
                            （卡面 (2)，特征标等式在 `Λ → ℤ` 里）。**不做**号差版（卡面 (a) 自己排除）、
                            `Hⁿ(C) = ⊕_λ Hⁿ(C_λ)` 的分解、与 Mathlib `HomologicalComplex.homology` 的桥
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
                            与 `worldsheet.modular-group-psl2z` 两张定义卡，外加 **ζ(−1) 节**。η 侧把 Mathlib 的
                            `ModularForm.eta` 逐字展开成 `q^{1/24}∏(1−q^n)` 并接上分支约定
                            `q = e^{2πiτ}`、`q^{1/24} = e^{πiτ/12}`；PSL 侧给出 `(aτ+b)/(cτ+d)`、
                            `Im(γτ) = Imτ/|cτ+d|²`、S/T 的作用、**`Z(SL(2,ℤ)) = {±I}`**
                            （`center_eq_pm_one`，Mathlib 与本项目此前都没有）与作用降到
                            `PSL(2,ℤ)`（`MulAction PSL2Z ℍ`）；ζ 侧 **`riemannZeta_neg_one : ζ(−1) = −1/12`**
                            （Mathlib 只有一般式 `riemannZeta_neg_nat_eq_bernoulli`，**没有**具名的 ζ(−1)）
                            与卡 `worldsheet.light-cone-normal-ordering-constant` 的算术部分
                            `lightCone_normalOrderingConstant : ((D−2)/2)·ζ(−1) = −(D−2)/24`（D=26 版给 −1）。
                            ⚠ 这些**不**触及 `worldsheet.zeta-regularized-sum-of-integers`：那张卡多主张
                            「有限部分就是物理零点能」，Lean 里无对应物，不因此升档
  Math/RegulatedSum.lean    指数截断和（图卡 `worldsheet.regulated-sum-laurent-expansion`）：
                            闭式 `Σ_{n≥1} n e^{−un} = e^{−u}/(1−e^{−u})² = 1/(4 sinh²(u/2))`（`u>0`）、
                            **sinh 的三阶 Taylor 界** `|sinh x −(x+x³/6)| ≤ |x|⁵/100`（|x|≤1，由 Mathlib
                            `Real.exp_bound` n=5，偶次项在 sinh 里抵消）、**Laurent 常数项**
                            `Σ_{n≥1} n e^{−un} − 1/u² → −1/12 (u→0⁺)`（精确分解
                            `1/(4s²)−1/u² = [(u−2s)/u³]·[1+2s/u]·[(2s/u)⁻¹]²`，三因子极限 −1/24、2、1，
                            只用一次 squeeze）、形式幂级数版 `(Σ n Xⁿ)(1−X)² = X`（任意交换环，
                            由 Mathlib `mk_add_choose_mul_one_sub_pow_eq_one` d=1 加位移）。
                            **未做**：`O(u²)` 余项（只给极限）、u 的 `LaurentSeries` 版、θ-推广
  Virasoro/Witt.lean        Witt 代数（`ℤ →₀ R` 上的 LieRing/LieAlgebra 实例，任意交换环）
  Virasoro/Basic.lean       Virasoro 代数（Witt 的中心扩张，基于 Mathlib `LieAlgebra.ofTwoCocycle`）
  Virasoro/Verma.lean       Verma 模 V(c,h)：U(Vir) 商构造、最高权向量、万有性质、L_0 分级（无 PBW 基，V≠0 未证，见 TODO `pbw-verma`）
  Virasoro/VermaPBW.lean    有序词（分拆）张成 Verma 模 level 片，dim V_N ≤ p(N)；线性无关（PBW）未做
  Virasoro/WittPerfect.lean  Witt 完美 ⟺ 2 可逆（derivedSeries_one_eq_top_iff）；ℚ-代数上 Witt 与 Virasoro 完美（isPerfect），C = 2[L₂,L₋₂] − 4[L₁,L₋₁]
  Virasoro/WittCohomologyH1.lean  **H¹(W, k) = 0（平凡系数）+ 字典「完美 ⟺ H¹ = 0」**（图卡
                            `math.witt-algebra-perfect` 的 (2) 与 (1)⟺(2)）。按卡面定义逐字做：
                            `oneCocyclesTrivial` = {f : 𝓛 →ₗ k | f⁅x,y⁆ = 0}、`oneCoboundariesTrivial` = ⊥、
                            `H1Trivial` = Z¹/B¹。**不是凭空定义**：补上 Mathlib 缺的 0 次
                            Chevalley–Eilenberg 微分 `LieCohomology.d₀₁`（`Algebra/Lie/Cochain.lean`
                            只有 `d₁₂`/`d₂₃`，上边缘与上同调在它自己的 TODO 里）与 `d₁₂ ∘ₗ d₀₁ = 0`，
                            再证平凡模上 `d₀₁ = 0`、`ker d₁₂ = {f | f⁅x,y⁆=0}`，故两条卡面定义都是定理。
                            字典半走 Mathlib 对偶：`Z¹ = ann[𝓛,𝓛]`、`h1TrivialEquivDualQuot`
                            （`H¹ ≃ₗ (𝓛/[𝓛,𝓛])^*`）、**域上** `oneCocyclesTrivial_eq_bot_iff`。
                            ⚠ **两条数学结论**：(i) `H¹ = 0` 只要 **2 是非零因子**，比完美性（2 可逆）弱；
                            (ii) **字典在 ℤ 上为假**（`witt_int_h1_vanishes_but_not_perfect`：
                            `Z¹(W(ℤ),ℤ) = 0` 但 `⁅W,W⁆ ≠ W`），故卡面「对任意李代数 𝓛 与平凡模 k」
                            里的 **k 必须是域**。特征 2 反例是 `coord 0`。
                            `↥Z ⧸ B` 的 `HasQuotient` 在 `L →ₗ[R] R` 上合成失败（同
                            `MATHLIB-ISSUE-quotient-finsupp.md`），解法同 TowerNull：先抽象（`SubQuot`）再实例化
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
  NoGhost/HeisenbergGram.lean      **抽象** Heisenberg 族的 Gram（任意 R-模 M）：`gram_of_heisenberg_family`
                            `⟨mono d, mono e⟩ = δ_{d,e} ∏ n^d d!`，只用 CCR/伴随/真空归一/真空湮灭；
                            (H1) 由 CCR 推出（`commute_heisCreation`）；单项式用 `Multiset.noncommProd`；
                            附 `finsupp_addSingle_induction`（Mathlib 缺）、`heisNorm_pos/_ne_zero`、
                            `linearIndependent_heisMonomial`。**中心项归一成 `m δ_{ij}`（正交归一/横向）**，
                            故 `FockGram.lean`（不定 η）**不是**它的实例，两者互补
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
  NoGhost/TowerNull.lean    塔上伪态/零模态/商形式（蓝图 §C.1）。**通用层**（任意 R-模 M、双线性型 B、
                            子模 P）：radicalIn / QuotRadical / quotRadicalForm（只需 `IsRefl B`）；
                            塔层：towerOrthComplement（= Mathlib `BilinForm.orthogonal`）、
                            towerSpuriousSubmodule、towerNullSubmodule、伪态⊥物理态、
                            spurious ∩ phys ⊆ null、TowerPhysQuot / towerQuotientPairing。
                            **必须先抽象再实例化**：`ℤ →₀ k` 同时是 AddMonoidAlgebra，
                            `HasQuotient ↥P (Submodule R ↥P)` 实例合成在 TowerFock 上直接失败
                            （纯 Mathlib 可复现，见 TODO `noghost-c1`）
  NoGhost/SpuriousShell.lean  带壳伪态 spuriousShell = S ⊓ ker(L_0 − a₀)、零态 nullStates、nullStates_eq、nullStates ≤ nullSubmodule
  NoGhost/LevelTwo.lean      level-2 标量物理态闭式 (4a₀−9)²⟨ψ₂,ψ₂⟩ = 2(D−1)[16a₀²+(2D−74)a₀+84−3D]；a₀=1、D>26 有序域上存在负模物理态（exists_mem_physSubmodule_pairing_self_neg）
  NoGhost/Witness.lean      **四条几何假设的可满足性见证**（蓝图 §C.2）：`D ≥ 3`、任意交换 ℚ-代数上的显式
                            光锥标架 η=diag(−1,1,…)、b=(1,1,0,…)、a=(1/2,3/2,0,…)、b̃=(1/2,−1/2,0,…)、
                            ε_i=Pi.single i 1 同时满足 hη∧hbb∧hba∧hεb（外加 b·b̃=−1、b̃·b̃=0、
                            横向 Gram = δ_ij、快子壳 α'k²=1）。**b·a=1 与 a·a=2 一起强制 a=(1/2,3/2,…)**，
                            所以 ℚ-代数不是偷懒（⚠ 只对该标架成立；WitnessInt.lean 给出 ℤ 见证，ℚ 只因 (M) 写法与 ddfOp 构造）。含可复用的 dotVec 双线性/Pi.single 收缩引理
  NoGhost/Longitudinal.lean **纵向 GT 算子 K_m = k_0·α_m = towerModeVec η a b b m**（偏振取 b 自身；
                            蓝图 §A.1/§A.2，Goddard 2008 (6.2)(6.3)）：⁅L_m,K_n⁆=−n K_{m+n}（只需 hη）、
                            ⁅K_m,K_n⁆=0（hbb 消中心项）、**K_0 = 1**（逐层，靠 k_0·p 沿塔不变 + hba）、
                            K_m†=K_{−m}、**⁅K_m,A^ε_n⁆=0（无望远镜求和，逐项对易，窗口取并集）**；
                            towerKerK = ⋂_{n>0} ker K_n 与 ddfCharacterization = phys ⊓ towerKerK
                            （**只是定义**，「= DDF 张成」是 ddf-spans，未做）。**不**做 Brower 的 A^L_n（§A.3）
  NoGhost/LightCone.lean    **塔上分次 + 光锥标架 + ddfSpan + 蓝图 §B.6 的 N = 1**：towerVacuum；
                            towerRungSubmodule / towerLevelSubmodule / **towerBigrade**（= 两者之交，
                            每片 Module.Finite）；**massShell_of_mem_towerBigrade**（质壳把双分次压成
                            反对角线 α'k²+j+N = a₀，需 NoZeroDivisors）；结构 LightConeFrame（b·b̃=−1）与
                            TransverseFrame（D−2 个正交归一横向偏振，横向性打包进结构因为它是 ddfOp 的
                            定义参数）；光锥振子代数 ⁅α^b_m,α^b̃_n⁆=−m δ 等；**conjCoeff_eq_neg_dotVec**
                            （b̃-分量 = −(b·v)，把 L_{−n} 的领头系数钉成 −1）与 L_{−1}/L_{−2} 在层真空上的
                            领头项；**ddfOp_neg_one_apply_towerVacuum**（A^ε_{−1}|0;k⟩ = α^ε_{−1}|0;k−k_0⟩
                            **精确**，但**需要额外假设 ε·k = 0**，四条标准假设推不出）；ddfSpan 与
                            ddfSpan ≤ towerPhys / towerKerK / ddfCharacterization；
                            **towerPhys_bigrade_one_le_ddfSpan_sup_spurious**（§B.6 的 N = 1，D = 26 不出现）；
                            witnessLightConeFrame / witnessTransverseFrame（**非空性**）与
                            witness_frameSpansOrthogonal ⟹ 显式标架上 N = 1 无条件。
                            **FrameSpansOrthogonal（标架完备性）不是 TransverseFrame 的推论**，是独立假设
  NoGhost/LightConeFrame.lean **DDFLightConeFrame**：把 worldsheet.ddf-light-cone-frame 卡的 (F1)–(F8)
                            打包成单个结构（frame : LightConeFrame + trans : TransverseFrame 承担
                            F2/F4 一半/F5/F7；hη/hba/hconjSpan/hεa/hspan 分别是 F1/F3/F4 另一半/F6/F8）；
                            witnessDDFLightConeFrame 用 Witness.lean 的显式标架实例化（非空性），
                            期间补了 witnessConjugate 的三条分量引理与
                            witnessConjugate_eq_neg_witnessMomentum_add_witnessLight（该标架上 b̃=b−a）；
                            **(F9) bonus**：dotVec_polarization_conj_eq_zero（纯双线性，η(ε,b̃)=0）+
                            DDFLightConeFrame.lie_conjOp_transOp（**从标架数据直接消去 lie_conjOp_transOp
                            原本松散的 hεconj 假设**）。**bonus (ii)**：DDFLightConeFrame.dotVec_self_eq_two
                            （`[Field R]`）证出卡 notes 里 (F6)(F7)(F8)⟹η(a,a)=2，走秩零化度
                            （v^⊥ 余维一 + {ε_i} 张成维数 ≤ D−2 的界）；不改卡的条件表，(F8) 仍是假设
  NoGhost/WitnessInt.lean   **整数见证**（reviewer-batch26）：η=diag(−1,1,…)、b=(1,1,0,…)、a=(0,1,1,0,…)、
                            ε=e₂ 在**任意交换环（含 ℤ）**上满足四条假设 + ε·ε=1 + 质壳的去分母形式
                            zeroModeSq η a = 2。Witness.lean 的「ℚ-代数不是偷懒」只对**它那个**标架成立。
                            D ≥ 4 版另给 ε·a = 0。**只说假设集可满足**；DDF 算子本身仍需 Algebra ℚ
  NoGhost/LevelTwoSpan.lean **蓝图 §B.6 的 N = 2 两条卡点**：(a) 产生指数的显式分量
                            `creaExp_one`（Φ₁ = b·α₋₁）、`two_smul_creaExp_two`（2Φ₂ = (b·α₋₁)²+b·α₋₂），
                            `vertexOsc_apply_polState`，由此 **A^ε_{−2}|0;k⟩ = [ε·α₋₂ − 2(ε·α₋₁)(k₀·α₋₁)]|…⟩**
                            与 **A^ε_{−1}A^δ_{−1}|0;k⟩ = [(ε·α₋₁)(δ·α₋₁) + ½(ε·δ)((k₀·α₋₁)²−k₀·α₋₂)]|…⟩**
                            （窗口是 {−2,−1,0,1}，j=1 项就是 DDF 代数的中心项；修正对 ε↔δ 对称）；
                            (b) **level-2 物理态的完整刻画**：`level_two_cases`（单项式两形，靠删一个振子
                            降到 level 1）、`levelTwoGen`/`exists_levelTwoGen_of_mem_levelSubmodule_two`、
                            `Lop_one/two_apply_levelTwoGen` ⇒ `mem_physSubmodule_inf_levelSubmodule_two_iff`
                            与塔版 `mem_towerPhys_bigrade_two_iff`（质壳 + D 条 + 1 条线性约束）。
                            **N = 2 的张成 (c) 未做**（缺消元）；`ε·k = 0` 在 N = 2 仍是必需的额外假设
  NoGhost/DDFGram.lean      **DDF 态的 Gram（蓝图 §C.4）**：把 HeisenbergGram 的 gram_of_heisenberg_family；rung 分次：`ddfOp` 移 rung +n（纯运动学，只需 hη/hεb），`|d⟩` 在 rung −N(d)（`frameMonomial_mem_towerRungSubmodule`），`ddfSpan_eq_iSup_rung`；rung 与 level 联动未做
                            实例化到 A^ε_n。补上两条小引理 **Fock.towerPairing_towerVacuum_self**（(H3)）与
                            **ddfOp_towerVacuum_of_pos**（(H4)，一行：ddfWindow n vac = Icc n 0 = ∅）；
                            ddfFamily 打包 + 四条前件 ddfFamily_ccr/_adj/_ann（ccr 由 lie_ddfOp_ddfOp
                            **加标架正交归一** 得到——正交归一是真前件，不是横向性的推论）；
                            主定理 **ddf_gram_diagonal**（⟨d,e⟩ = δ_{d,e} ∏ n^d d!，任意交换 ℚ-代数）、
                            ddf_gram_pos（有序环）、**linearIndependent_ddfMonomial**（特征 0 域）、
                            ddfMonomial_mem_towerPhysSubmodule（截距 a₀ = α'k² 由真空定死，非自由参数）。
                            标架层：frameMonomial（ι = Fin (D−2)，用 LightCone 的 TransverseFrame）、
                            **ddfSpan_eq_span_range_frameMonomial**（列表生成集 = 占据数生成集）与
                            **ddf_span_pos**（全序域上 ddfSpan 里非零向量模长 > 0 —— 蓝图 §C.5 的正定性输入）
  NoGhost/Assembly.lean     **无鬼定理的条件版组装（蓝图 §C.5）**：`DDFSpans`（`H_phys ≤ ddfSpan ⊔ H_null`，
                            截距 `a₀ = α'k²`）**作为假设不证**，分片版 `DDFSpansOn … W`；
                            `towerPairing_self_nonneg_…_of_spans`（无负模）、
                            `towerPairing_self_eq_zero_iff_mem_towerNullSubmodule_of_spans`（零模 ⟺ null）、
                            **`no_ghost_of_spans`（`TowerPhysQuot` 上的形式正定）**。
                            `mem_ddfSpan_sup_null_of_mem_ddfSpan_sup_spurious` 把 §B.6 的
                            「模伪态」结论升级成「模 null」，据此
                            **`ddfSpans_bigrade_neg_one_one`** 在光子片 `(rung −1, level 1)` 上
                            **无条件于 `D`** 关闭 `DDFSpansOn`。**`D = 26` 在本文件一次都不出现**——
                            它全部被吸收进 `DDFSpans`（蓝图 §B.5）
  NoGhost/Glue.lean         **蓝图 §B 的「逐片 ⇒ 全体」**：双分次投影 `towerBigradeProj j N`
                            （`x ↦ single j ((x j)_N)`，基于 `Fock.levelComponent`；**刻意不建
                            `DirectSum.Decomposition`**，直和性从未被断言）；`L_m` 的双分次齐次性
                            （`(j,N) ↦ (j,N−m)`，level `< m` 被杀）与交换关系
                            `towerBigradeProj_towerLop`；**`towerBigradeProj_mem_towerPhysSubmodule`**
                            （物理态的每个双分次分量仍物理，对 η,a,b 无假设）⇒
                            **`towerPhys_le_iSup_bigrade`**；主引理 **`ddfSpans_of_forall_slice`**
                            （每片 `DDFSpansOn` ⇒ `DDFSpans`；非格论平凡，因为 `⨆` 不对 `⊓` 分配）、
                            质壳压缩量词的 `ddfSpans_of_forall_antidiagonal_slice(_int)`
                            （`CharZero` 下只剩单条反对角线 `j = −N`）与 level 截断版
                            `towerLevelLESubmodule` / `ddfSpansOn_towerLevelLE(_of_antidiagonal)`
                            （§B.6 部分归纳的可陈述全局形式）；**`ddfSpansOn_towerLevelLE_one`**
                            ——level `≤ 1` 整块（所有 rung）上张成引理**无条件于 `D`** 成立
                            （`(0,0)` 片由新引理 `Fock.eq_C_of_mem_levelSubmodule_zero`
                            「level-0 = 常数」给出）。**`D = 26` 同样一次不出现**
  Virasoro/FockFreeLowLevel.lean  **Fock 模在 `Vir⁻` 下于层 `N ≤ 4` 自由**（固定动量）。`FockVir` 把
                            Sugawara `virRep` 做成 `LieRingModule/LieModule` 实例（类型同义词必需：
                            作用依赖 `η,a`）；真空是权 `(D, α'k²)` 的最高权向量，Verma 万有性质给
                            `vermaToFock`，拉回 `pairing` 得 Verma 上的归一化逆变型，故 Fock Gram 行列式
                            = `(D, α'k²)` 处 Kac 行列式（`gram_det_fockDesc{1,2,3,4}`）⇒
                            `linearIndependent_fockDesc{1,2,3,4}`。副产品：**`hwv_ne_zero_of_two_le`**
                            （`V(c,h) ≠ 0` 对任意自然数 `c ≥ 2` 与任意 `h`，洛伦兹见证）与
                            **`kacDet{1,2,3,4}_massShell_26`**（`D=26, a₀=1` 下 `h = 1-N`：
                            `N=1,2` 行列式为零——判据在零模态所在层空转；`N=3,4` 为 `2304` / `2649563136`）。
                            **`kacDet2_massShell_two`（蓝图 §B″.0(2)）**：`kacDet2 c (1−2) = 2(c−26)`
                            对**任意** `c`——把「在 26 处为零」加强为「零点只有 26」，是 `D = 26`
                            临界性的最小机检见证；`kacDet2_massShell_two_eq_zero_iff`（特征零域）。
                            一般 `N` 仍需 Kac 行列式（见蓝图 §B.2），对无鬼瓶颈无影响
  NoGhost/NullDescend.lean  **蓝图 §B′ PR0**：`ddfOp_mem_towerNullSubmodule`——`A^ε_n` 把零态送到零态
                            （`ddfOp_mem_towerPhysSubmodule` + `(A^ε_n)† = A^ε_{−n}`，两者都已有）。
                            **对任意截距 `a₀` 成立**（蓝图只写了 `a₀ = α'k²`，是无成本的加强）。
                            它是 (B-26) 构造式路线的乘法结构：把「片上造 `p_{D−1}(N)−p_{D−2}(N)` 个
                            线性无关零态」降成「每个 `m` 造 `p(m)` 个纵向种子」
  NoGhost/SliceRank.lean    **蓝图 §B′ PR1**：把 `ddf-spans` 的最后一步压成**一条秩不等式**。
                            `ddfSpan_inf_towerNullSubmodule_eq_bot`（DDF 扇区与零态只交于零，
                            全序域上由 `ddf_span_pos` 得；**对任意截距 `a₀`**）；抽象判据
                            `eq_sup_of_finrank_le`（`S,T ≤ H`、`S⊓T=⊥`、`dim H ≤ dim S + dim T`
                            ⇒ `H = S ⊔ T`，纯线性代数）；**`def B26`**——反对角片上
                            `dim(H_phys⊓V_N) ≤ dim(ddfSpan⊓V_N) + dim(H_null⊓V_N)`；
                            **`ddfSpansOn_bigrade_of_b26`** 与 **`ddfSpans_of_forall_b26`**
                            （接 `Glue.ddfSpans_of_forall_antidiagonal_slice_int`）。
                            **`D = 26` 一次不出现**，它全部落进 `B26` 这条 `Prop`。
                            §B′ 订正：蓝图写的 `iff` 的「⟹」半边**不免费**（要 `ddfSpan` 与
                            `towerNullSubmodule` 对双分次齐次），故拆到 `SliceDim.lean`，
                            PR1→PR2 与 §B′.7 画的方向相反
  NoGhost/SliceDim.lean     **蓝图 §B′ PR2**：算出 `B26` 右边第一项。**`frameMonomial_mem_towerBigrade`**
                            关掉 `DDFGram.lean` 自报的「rung 与 level 联动未做」——**不算 `ddfOp` 的 level**，
                            而是「|d⟩ 在 rung −N(d) 且物理」+ `Glue.towerBigradeProj_mem_towerPhysSubmodule`
                            + `massShell_of_mem_towerBigrade` 逼出只有 level N(d) 的分量非零；
                            `ddfSpan_inf_towerBigrade_eq_span`（片上 = level N 的 DDF 单项式张成）；
                            **`ddfLevelFintype`**（level 固定的占据函数有限，编码进
                            `ι × Fin N → Fin (N+1)`，`min` 只为避开依值证明）与
                            `finrank_ddfSpan_inf_towerBigrade`（= 指标集基数 = `p_{D−2}(N)`，
                            **永不求值**，与 §B′.8 一致）。另有**片间正交**
                            `towerPairing_towerBigradeProj_left/_right`（新原子
                            `Fock.pairing_levelComponent_right`）与由它得到的齐次性
                            `towerBigradeProj_mem_ddfSpan` / `_mem_towerNullSubmodule`，
                            据此给出 PR1 那条 `iff` 的「⟹」半边
                            （`b26_of_ddfSpansOn_bigrade`）与 **`ddfSpansOn_bigrade_iff_b26`**
                            ——`B26` 是 (B-26) 的**等价改写**，不是加强。`D = 26` 不出现
  NoGhost/LightConeResolution.lean  **蓝图 §B′ PR3 的标架半边**（分支 `noghost-n2-finish`）：
                            `DDFLightConeFrame.conj_eq_light_sub_momentum`（`b̃ = b − a`）与
                            `DDFLightConeFrame.resolution`（显式单位分解），均需
                            `[Field R] [Algebra ℚ R]` 与 `hD : 2 ≤ D`；把 `LevelTwoElim.lean` 的
                            `FrameSpansFull`（`hFullSpan`）从假设升为定理
  NoGhost/LightConeResolutionGen.lean  **蓝图 §B′ PR3 的一般 `N` 半边**：光锥产生算子
                            `lcCrea η w n = Σ_μ η_μ w^μ X_{(μ,n)}`（`n = 1` 就是 `Fock.polState`，
                            `rfl`；`lcCreaₗ` 是打包的线性映射）、`X_eq_lcCrea_single`
                            （`LevelTwoElim.X_one_eq_polState_single` 的一般 `n`）、方向表
                            `frameVec`（`0 ↦ b`、`1 ↦ b̃`、`μ ↦ ε_{μ−2}` 的 `dite`，只要 `2 ≤ D`，
                            **不建 `Fin D ≃ Unit ⊕ Unit ⊕ Fin (D−2)` 的双射**，故光锥单项式与
                            普通单项式**共用指标集 `Osc D`**）、`span_range_frameVec_eq_top`、
                            `lcMonomial` / `lcSpan` 的乘法性与主定理
                            **`levelSubmodule_eq_span_lcMonomial`**（level `N` 的光锥单项式张成
                            `Fock.levelSubmodule D R N`，**任意 `[CommRing R]`**）。
                            **只做张成，不做线性无关**（§B′.9 第 2 条）。
                            **推广**：`DDFLightConeFrame.exists_frame_decomp` 与
                            `frame_decomp_coeff`（分解存在 + 系数唯一且显式）在**任意交换环、
                            任意 `D`** 上成立——`resolution` 的 `[Field]`/`[Algebra ℚ]`/`hD`
                            三条假设全部可去，因为 (F4)+(F3) 直接给 `β = −1`，于是
                            `a − b = (γ−1)•b − b̃` 已落在 `span{b, b̃}` 里，**不必知道 `γ`**。
                            真正要 `(2:R) ≠ 0` 的只有 `b̃ = b − a` 那一条（标架只给
                            `2γ = η(a,a)`，见 `two_mul_conjSpan_coeff_right`）。
                            另有 `dotVec_conj_towerMomentum`（`b̃·p_j = −1 − j`，**随 rung 变**，
                            §B′.9 第 1(b) 条的陷阱）与 `dotVec_trans_towerMomentum`（`ε_i·p_j = 0`）。
                            `D = 26` 与整个塔（rung / `towerBigrade`）在本文件一次不出现
  NoGhost/SpuriousElimination.lean  **蓝图 §B′ PR4**：`b̃`-次数消元与 (P3) 上界。
                            **`D = 26` 一次不出现**，截距只以 `a₀ = α'k²` 出现。85 条声明。
                            (1) **两个次数**：`conjDeg`（β，`b̃` 行总次数）与 `conjWt`（ω，加权次数），
                            都用 `Finsupp.weight` 实现故加性免费；归纳量
                            `lcMeasure hD N d = β(d)(N+1) + ω(d)`；三个记账张成
                            `lcBound` / `lcLow` / `lcSeed` 与 `conjFree` / **`conjFreeSlice`**。
                            (2) **Sugawara 输入**：`oscPair_eq_lightCone`（两个产生算子的度规收缩
                            换成标架：`Σ_μ η_μ α^μ_{−r}α^μ_{−s} = −α^b_{−r}α^{b̃}_{−s}
                            − α^{b̃}_{−r}α^b_{−s} + Σ_i α^{ε_i}_{−r}α^{ε_i}_{−s}`）与
                            **`Lop_neg_apply_one`**（**任意 `n ≥ 1`** 的层真空公式
                            `L_{−n}|0;p⟩ = α^p_{−n}|0;p⟩ + ½Σ_{l=1}^{n−1}Σ_μ η_μ α^μ_{−(n−l)}α^μ_{−l}|0;p⟩`；
                            仓库此前只有 `n = 1, 2`）。
                            (3) **领头项引理** `towerLop_neg_conjDegree_leading` /
                            `lcMonomial_conj_add_Lop_mem_lcLow`：`α^{b̃}_{−n}m(d′) = −L_{−n}m(d′)
                            + （测度严格更小的光锥单项式）`，**对每个 `n`**（§B′.9 点名的最可能卡点）。
                            **关键简化**：不去算 `L_{−n}` 作用在一般单项式上，而是用
                            `[L_{−n}, α^w_{−r}] = r α^w_{−(n+r)}` 把它**穿过**所有产生算子，
                            于是唯一的 Sugawara 计算落在真空上，**湮灭算子从不作用在光锥单项式上**。
                            (4) **消元** `towerBigrade_le_conjFreeSlice_sup_towerSpurious`：
                            反对角片模伪态由不含 `b̃` 的光锥单项式张成（对 `lcMeasure` 强归纳）。
                            (5) **非退化**：`Fock.monomialNorm_ne_zero`、
                            `Fock.eq_zero_of_pairing_left_eq_zero`、
                            `Fock.eq_zero_of_towerPairing_left_eq_zero`（特征零、无零因子），
                            关掉 `TowerNull.lean` 自报的 gaps 第 2 条；`eq_zero_of_mem_towerBigrade_of_orthogonal`
                            （片上无根基）。
                            (6) **`towerPhys_inf_towerBigrade_eq_towerOrthComplement`**：反对角片上
                            「物理」⟺「与全部伪态正交」（`L_0` 条件在反对角上自动；不需要光锥标架）。
                            (7) **(P3)** `finrank_towerPhys_inf_towerBigrade_le`：
                            `dim(H_phys ⊓ V_N) ≤ #{d | level d = N ∧ β(d) = 0}`（即 `p_{D−1}(N)`，
                            **永不求值**）。证法是**嵌入对偶**（`x ↦ ⟨x,·⟩|_{conjFreeSlice}` 单射），
                            不用 `BilinForm.finrank_orthogonal`（那条要有限维环境空间，塔不是）。
                            (8) **附赠**（Goddard (6.2) 的一半）`single_lcMonomial_mem_towerKerK` /
                            `conjFreeSlice_le_towerKerK_inf_towerBigrade`：不含 `b̃` ⟹ 满足 K-条件
                            （`K_n` 与 `α^w_{−r}` 对易当 `b·w = 0`）。**反向包含未做**（要线性无关，
                            §B′.9 第 2 条）。
                            (9) **任意片 `(j, M)` 版**（PR6′ 前置）：`conjFreeSliceAt`、
                            `towerBigrade_le_conjFreeSliceAt_sup_towerSpurious`、
                            `towerPositiveMode_inf_towerBigrade_eq_towerOrthComplement`（`Q_{j,M} = S^⊥ ⊓ V_{j,M}`，
                            无 `L_0` 条件）、`finrank_towerPositiveMode_inf_towerBigrade_le`（`dim Q_{j,M} ≤ p_{D−1}(M)`）。
                            未做：(B-26)（PR5，`D = 26` 唯一入口）、`conjFreeSlice ⊓ spurious = ⊥`
  NoGhost/TowerVirasoro.lean **塔上的 Virasoro 关系**（蓝图 §B″.8 点名的唯一前置缺件）：
                            `lie_towerLop_towerLop`（`⁅L_m,L_n⁆ = (m−n)L_{m+n} + D·centralTerm(m)·δ`，
                            `Fock.lie_Lop_Lop` 的逐纤维提升，`Finsupp.lhom_ext`；**中心荷与 rung 无关**，
                            `p_j` 只进 `L_0` 的本征值）与三条使用形式
                            `towerLop_apply_towerLop`（把 `L_m` 移到 `L_n` 右边）/
                            `_of_ne_zero`（无中心项）/ `_neg`（`n = −m`，中心项显式）。
                            此前仓库只有 `lie_towerLop_towerMode`（塔上 L 对 α），塔上 L 对 L 没有
  NoGhost/NullSeedsTwo.lean **蓝图 §B″ PR5b′：`(B-26)` 路线的证伪点，也是全链 `D = 26` 的唯一入口**。
                            两族零态（都只用 `L_{−1}`、`L_{−2}`，不需要 DDF 算子和光锥标架）：
                            **Type 1** `towerLop_neg_one_mem_towerNullSubmodule`（`L_0φ=0` 的种子，
                            `D` 不出现，因为 `centralTerm 1 = 0`；截距被 `L_0(L_{−1}φ)=L_{−1}φ` 钉成 1，
                            **不能**像 PR0/PR1 那样放宽）；**Type 2** `descTwo = 2L_{−2}+3L_{−1}²`。
                            ⭐ 两条方程（手算 §B″.2 **逐字复核通过，无订正**）：
                            `towerLop_one_apply_descTwo : L_1𝒟₂φ = 12(h+1)•L_{−1}φ`（**截距**，无 `c`）
                            与 `towerLop_two_apply_descTwo_of_eigenvalue : L_2𝒟₂φ = (26h+D)•φ`
                            ⇒ `towerLop_two_apply_descTwo : = (D−26)•φ`（`h = −1`）。
                            **`D = 26` 还被证明是必要的**：`towerLop_two_apply_descTwo_eq_zero_iff` /
                            `descTwo_mem_towerPhysSubmodule_iff`（整环 + 种子非零 ⟹ 物理 ⟺ `(D:R)=26`），
                            Kac 侧孪生是 `Fock.kacDet2_massShell_two_eq_zero_iff`。
                            另有六条原子 `towerLop_{zero,one,two}_apply_towerLop_neg_{one,two}`
                            （= §B″.2 那张 Gram 的六个条目，但是算子等式）、`centralTerm_one_eq_zero`、
                            `two_mul_centralTerm_two_eq_one`、分次记账 `descTwo_mem_towerBigrade`
                            （bidegree `(0,+2)`）与片上版本（`k·k = 2` 把截距求值成 1）：
                            `towerLop_neg_one_mem_towerNullSubmodule_of_mem_towerBigrade`
                            （`j+N = −1` 的片）、`descTwo_mem_towerNullSubmodule_of_mem_towerBigrade_neg_two`、
                            `descTwo_single_mem_towerNullSubmodule`（`𝒟₂|0;p₋₂⟩` 具体态）。
                            **未做**（见文件头）：25 个 Type-1 种子及其线性无关；`𝒟₂y ≠ 0`
                            （Gram 判据在此处**必然**空转——`kacDet2 26 (−1) = 0` 正是零态存在的原因，
                            要走 `MvPolynomial` 系数：`X_{(μ,2)}` 系数是 `5η_μp^μ`）；
                            `p_{D−1}(2) − p_{D−2}(2) = D` 的计数。故 **`B26 2` 与
                            `ddfSpans_bigrade_neg_two_two` 仍未关闭**（**已于
                            `NoGhost/LevelTwoCount.lean` 关闭**）
  NoGhost/LevelTwoCount.lean **蓝图 §B″ PR5b 在 `N = 2` 上收尾——`B26 2` 与
                            `ddfSpans_bigrade_neg_two_two` 关闭**，是全链**第一处**被机检的
                            张成结论真正消费 `D = 26` 的地方（`N ≤ 1` 无条件于 `D`）。三块：
                            (1) **计数**（全部 `D`-无关）：`Finsupp.oscWeight_eq_two_cases`
                            （level-2 占据函数只有 `single (i,2) 1` 与
                            `single (i,1)1 + single (j,1)1` 两形，对任意指标类型 `ι`，
                            同时服务 `p_{D−1}` 与 `p_{D−2}` 两侧）、`card_ddfLevel_two_ge`
                            （`ι ⊕ Sym2 ι ↪ {d | N(d)=2}`，只要下界）、`card_conjFree_two_le`
                            （`κ ⊕ Sym2 κ ↠ {d | level=2 ∧ β=0}`，`κ = {μ | μ ≠ b̃}`，只要上界；
                            **两侧各只需单向，故不必造双射**）与 **`levelTwo_count_identity`**
                            （`(D−1)+C(D,2) = (D−2)+C(D−1,2)+D`，**纯 Pascal 恒等式，对一切 `D`**
                            ——这坐实了蓝图 §B′.8「计数一步永远看不见 26」）；合成
                            `finrank_towerPhys_inf_towerBigrade_two_le`
                            （`dim(H_phys⊓V_2) ≤ dim(ddfSpan⊓V_2) + D`）与
                            `b26_two_of_finrank_towerNull`（`B26 2` ⟸ `dim(H_null⊓V_2) ≥ D`）。
                            **`decide` 在 `Osc D →₀ ℕ` 上化不开**（同 `Math/PartitionCard.lean`），
                            全部走显式分类。
                            (2) **零态**：`alphaTwoCoeff`（`α^ν_{−2}` 分量的线性泛函）+
                            `coeff_single_two_mul_of_mem_levelSubmodule_one`（两个 `α_{−1}` 之积
                            没有 `α_{−2}` 分量，**只需左因子齐次**）；`typeOneTwo` /
                            `typeOneTwo_mem_towerNullSubmodule`（Type 1 落到片上）；
                            **`nullFamilyTwo`**——`D` 个零态 = `D−2` 个横向 Type-1 +
                            **1 个沿 `a = b − b̃` 的 Type-1** + 1 个 Type-2；
                            **`linearIndependent_nullFamilyTwo`（独立性不需要 `D = 26`）**，
                            证法是三角性：先用 `α_{−2}` 分量把关系压成向量方程，再与 `p_{−2}` 配对
                            （`p·p = −2 ≠ 0`）杀掉 Type-2 系数，最后与 `b`/`ε_j` 配对杀掉 Type-1；
                            `le_finrank_towerNullSubmodule_inf_towerBigrade_two`。
                            (3) **主定理** `b26_two_of_D26` 与 `ddfSpans_bigrade_neg_two_two`。
                            **附赠**：`descTwo_single_neg_two_ne_zero`（`𝒟₂|0;p₋₂⟩ ≠ 0`，蓝图
                            §B″ 订正列为未决且明说 Gram 判据无能为力——`α_{−2}` 分量是 `5p`，
                            由 `p·p = −2` 逼出某分量非零）与
                            `descTwo_single_mem_towerPhysSubmodule_iff`（该具体态物理 ⟺ `(D:K)=26`）。
                            **未做**：`¬ B26 2`（`D ≠ 26`）的维数版——要把两个计数界升成等式并给
                            `dim(H_null⊓V_2)` 上界；一般 `N`
  NoGhost/TypeOneFamily.lean **蓝图 §B‴ PR6′：`D`-无关的零态下界 `dim(H_null ⊓ V_{N+1}) ≥ p_{D−1}(N)`
                            对一切 `N`**（`le_finrank_towerNull_inf_towerBigrade_succ`；`N−1` 写法在 `1 ≤ N` 下）。
                            **`D = 26` 一次不出现**；截距 `a₀ = 1`（`k·k = 2`）只在最后一步（Type-1 零态）进入。
                            四块：(a) **`towerLop_neg_one_injective`**——`L_{−1}` 在每个双分次片 `(j, M)` 上单射，
                            只用 `K` 代数 `⁅L_{−1},K_1⁆ = −K_0 = −1` ⇒ `L_{−1}K_1^{k+1}x = −(k+1)K_1^k x` 与
                            `K_1^{M+1} = 0`，**不需要 `CharZero`**（ℚ-代数里 `k•y=0 ⇒ y=0`，
                            `eq_zero_of_natCast_smul_eq_zero`）；(b) **通用 straightening**
                            `straighten` / `apply_mem_ordSpanOn_of_mem`——对任意满足负模 Witt 关系的族
                            `L : ℤ → Module.End R W`（`IsNegWitt`）作用在任意向量上，把
                            `VermaPBW.straighten` 从 Verma 模最高权向量解放出来（结构逐字，≈110 行；
                            `isNegWitt_towerLop` 实例化）；(c) **(F-1) 张成半**
                            `towerBigrade_le_ordSeedSpan`——每个片由 `L_{−λ} m(c)`（`λ` 有序分拆、`c` 不含 `b̃`）张成，
                            外层对 level 强归纳 + 内层 PR4 的测度归纳（伪态项不再丢弃）；**(F-2) 单射半**
                            `seedIndexPosEmbed_injective`（`(λ,c) ↦ c + wordOcc λ`，有序表由重数唯一确定：
                            `List.Perm.eq_of_pairwise'`），故 `dim(非空词族) ≤ p_D(M) − p_{D−1}(M)`；
                            `finrank_towerBigrade : dim V_{j,M} = #{level = M}`（Mathlib `basisRestrictSupport`）；
                            (d) **`towerSeed` / `le_finrank_towerSeed`**：`Q_{j,M} = 正模核 ⊓ 片` 有
                            `dim ≥ p_{D−1}(M)`，秩–零化度（`V_{j,M} → (非空词族)^*` 的核落在 `Q_{j,M}`），
                            **不用片上非退化**；与 `SpuriousElimination.finrank_towerPositiveMode_inf_towerBigrade_le`
                            合成 **`dim Q_{j,M} = p_{D−1}(M)` 精确**（§B″.4.1 (F-4) 第二行，无需基）。
                            **订正**：蓝图 §B‴.9 的 `N−1` 陈述在 `N = 0` 为假（真空物理非零）。
                            **未做**：(B-26) 本身——缺的 `p_{D−1}(N+1) − p_{D−2}(N+1) − p_{D−1}(N)` 个零态是
                            Type-2 族（`N+1 ≥ 12` 起还要新奇异向量族），全是 `D = 26` 依赖；词族线性无关 (F-3)
  NoGhost/LevelThreeCount.lean **蓝图 §B‴.5 的 `N = 3` 账——`B26 3` 与
                            `ddfSpans_bigrade_neg_three_three` 关闭**（第三条反对角片；`N ≤ 1` 无条件、
                            `N = 2` 见 `LevelTwoCount.lean`）。三块：
                            (1) ⭐ **绕开 §B‴.5「领头指标撞车」的新分离泛函**：不是领头项，而是
                            **反对称化的 `α_{-2}α_{-1}` 系数** `A_ε(2)A_δ(1)x − A_δ(2)A_ε(1)x`
                            （`A_ε(p) = towerModeVec`）。`L_{-1}`-像的该张量是 `p ⊗ w + 2T` 而 `T`
                            **对称**（两个 `α_{-1}` 对易），`𝒟₂`-像是 `5 p⊗v + 6 v⊗p`（`5 ≠ 6`），
                            反对称部分不相消。与 `α_{-3}` 系数 `A_ε(3)` 联立消去 `φ` 得
                            `(ε·p)(δ·e) = (δ·p)(ε·e)`，再由 `p_{-3}·p_{-3} = -4 ≠ 0` 得 `e = 0`：
                            **`eq_zero_of_towerLop_neg_one_add_descTwo_oneSeed`**（对任意 rung，
                            只要 `p_j·p_j ≠ 0`；**`D` 与「物理/零态」一次不出现**，纯振子对易子代数，
                            无系数提取、无基）。工具箱 `towerModeVec_apply_towerLop`
                            （`A_ε(p)L_n = L_n A_ε(p) + p A_ε(n+p)`）+ 四条 `A` 穿过 `L_{-1}/L_{-2}/𝒟₂`
                            的求值引理。
                            (2) **零态下界** `le_finrank_towerNull_inf_towerBigrade_three`：
                            `dim(H_null ⊓ V_3) ≥ dim Q_{-3,2} + (D−1)`。Type-2 定义域取
                            `ker(e ↦ e·p_{-3})`（`finrank_ker_transFunctional`，秩–零化度给 `D−1`，
                            **不选基**——⚠ `a` 在 rung `-3` 上**不**横向，`a·p_{-3} = -1`，
                            与 `N = 2` 不同）；`D = 26` 只经新的任意-rung 版
                            `descTwo_mem_towerNullSubmodule_of_mem_towerBigrade`（条件 `j + N = -2`）
                            → `NullSeedsTwo.towerLop_two_apply_descTwo`。
                            (3) **计数**：`Finsupp.exists_peel`（剥一个振子 + 对 level 递归）使
                            `oscWeight_eq_three_cases` 只要 12 行（`oscWeight_eq_two_cases` 用了 80）；
                            指标 `ι ⊕ (ι×ι) ⊕ Sym ι 3`（`[2,1]` 是**有序**对）经
                            `Multiset.toFinsupp` + `mapDomain`，`Sym.card_sym_eq_choose` 给 `C(m+2,3)`；
                            **通用桥 `conjFreeEmbed`**（`κ = {μ ≠ b̃} ↪ Fin D` 的 `mapDomain`，保 level、
                            `conjDeg = 0`、单射）给**每个 level** 的 `conjFree` 下界，其 `N = 2` 实例
                            `card_conjFree_two_ge` 补上 §B″ 只做了的上界；主恒等式
                            **`levelThree_count_identity`** `p_{D−1}(3) = p_{D−2}(3) + p_{D−1}(2) + (D−1)`
                            （Pascal，**对一切 `D`**；`D = 26` 时 `3575 = 3200 + 350 + 25`）——
                            第二条证据支持 §B′.8「计数看不见 26」。
                            **未做**：一般 `N`（`B26 4` 已于 `NoGhost/LevelFourCount.lean` 关闭）
  NoGhost/LevelFourCount.lean **蓝图 §B‴ 订正第 5 条的 `N = 4` 账——`B26 4` 与
                            `ddfSpans_bigrade_neg_four_four` 关闭**（第四条反对角片；至此
                            `ddf-spans` 在 `N ≤ 4` 上全部机检）。四块：
                            (1) ⭐ **力矩非退化**（可复用，与 `N` 无关）：
                            `Fock.eq_zero_of_annihilation_eq_zero`（level `N ≥ 1` 的多项式被全部
                            `α^μ_n` 湮灭 ⟹ 为零；走 `Fock.coeff_annihilation` 提系数，**不需要**
                            `levelSubmodule_eq_span_lcMonomial`，比蓝图估计的路线短得多）与塔版
                            `eq_zero_of_towerModeVec_eq_zero`（`ε := e_ν` 把 `A_ε(p)` 变回
                            `η_ν α^ν_p`，`towerModeVec_pi_single`）。
                            (2) **四条力矩方程**（任意 rung、任意 `D`）：`towerModeVec_four_*`、
                            `towerModeVec_three_one_*`、`towerModeVec_two_two_*`、
                            **`towerModeVec_two_one_one_*`**（各两条，Type-1 / Type-2）。
                            新原子两条：`towerModeVec_two_descTwo_of_level_zero`（`A_ε(2)𝒟₂z = 10(ε·p)z`）
                            与 **`towerModeVec_one_apply_towerModeVec_neg_one`**
                            （`⁅A_δ(1),A_ρ(-1)⁆ = (δ·ρ)`——振子中心项在 `N = 4` 的账里**首次**出现，
                            正是它给出反对称化后的 `2(δ·ρ)m_ε` 项）。蓝图手算的四条方程
                            **逐字复核通过，无订正**。
                            (3) ⭐⭐ **横截性** `moment_relations_of_towerLop_neg_one_add_descTwo`
                            （输出 `n` 的解出式与反对称化恒等式
                            `3[(δ·ρ)m_ε−(ε·ρ)m_δ] = 4(ρ·p)[(δ·p)m_ε−(ε·p)m_δ]`，即蓝图那条乘 3/2）
                            与 `eq_zero_of_towerLop_neg_one_add_descTwo_at_four`。消元全部由
                            `linear_combination (norm := module)` 完成（三步解出式 `a = -11m`、
                            `b = -8n - (7/3)(δ·p)m`、`n = (2/3)[(δ·p)m_ε+(ε·p)m_δ]`，再一条
                            十项组合）。数值输入只有 `3 - 4p² ≠ 0`（`p² = -6` 时为 27）与 `p² ≠ 0`。
                            **`D` 与物理性一次不出现**；⚠ 需要 `3 ≤ D`（要一个 `u·p = 0`、`u·u = 1`
                            的横向偏振），这是与 `N ≤ 3` 的唯一前件差别。
                            (4) **计数**：`Finsupp.oscWeight_eq_four_cases`（五形，靠 `exists_peel`
                            只用 40 行）、指标 `ι ⊕ (ι×ι) ⊕ Sym ι 2 ⊕ (ι × Sym ι 2) ⊕ Sym ι 4`、
                            **`modeCount`（模数计数不变量）**把 `levelFourIndex_injective` 的 25 个 case
                            压成 20 个一行 + 5 个真证明（五形的模数轮廓
                            `(0,0,0,1) (1,0,1,0) (0,2,0,0) (2,1,0,0) (4,0,0,0)` 两两不同）；
                            `card_ddfLevel_four_ge` / `card_conjFree_four_le` /
                            `card_conjFree_three_ge` 与主恒等式 **`levelFour_count_identity`**
                            `p_{D−1}(4) = p_{D−2}(4) + p_{D−1}(3) + p_{D−1}(2)`（Pascal，**对一切 `D`**；
                            `D = 26` 时 `29575 = 25650 + 3575 + 350`）——第三条证据支持
                            §B′.8「计数看不见 26」。
                            **未做**：`N ≥ 5`（两族在计数上不再够用，超出量是五边形数；力矩机器本身
                            与 `N` 无关，可复用）；`¬ B26 N`（`D ≠ 26`）的维数版
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
