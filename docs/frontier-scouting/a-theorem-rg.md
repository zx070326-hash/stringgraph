# 领域侦察：a-定理 / RG 单调性（RG 流不可逆）

> 侦察 sub 出品，方向 = "物理前沿·高含金量"研究线选靶。目标：区分**已严格证明 / 物理论证 / 真开放**，并挑出最合"我们方法"（精确代数 + 解析不等式 → 机器可验证严格；外加隔离 research/ 纸面原创）的候选靶子。
>
> **出处纪律**：每条论断标 ⟨lit⟩（文献直接支持）/ ⟨judgment⟩（本 sub 判断）/ 待核（arXiv 号或作者名未逐一核对）。**不夸大严格程度**，每条"证明"写明依赖假设。这是侦察备忘，不是图节点；不碰 `graph/`、`research/`、`formal/`、`literature/`，不标任何东西 formalized。

---

## 0. 什么是"RG 单调性"，为什么高含金量

一个可重整量子场论（QFT）沿重整化群（RG）流从紫外（UV）不动点流到红外（IR）不动点。**RG 单调性 / 不可逆定理**断言：存在一个"计自由度个数"的量 $C$，满足 $C_{\rm UV}\ge C_{\rm IR}$（弱版本），甚至沿整条流单调不增（强版本），只在不动点驻定。物理含义：粗粒化不可逆，信息只减不增。地位对标热力学第二定律，是 QFT 结构性支柱之一，也是弦论/全息（AdS 半径方向 = RG 尺度）里 c-函数、全息纠缠熵的根。

**"我们方法"的匹配标准**（用于打分）：
- **合方法度（fit）**：能否归约成*有限步*的精确代数 / 计数 / 解析不等式，其对象在 Mathlib 射程内（导数、凸性、正定型、SSA 型不等式），从而可 Lean 形式化，或至少可写成 research/ 纸面级严格论证。
- **脆度（brittleness）**：陈述本身是否"脆"——严格状态开放或含糊、依赖的连续 QFT 假设是否可被显式隔离为前提（形式化"蕴含"而非"对象存在性"）。

---

## 1. 领域地图（谱系速查表）

| 维度 | 单调量 | 严格状态 | 关键作者/年份 | 核心假设 |
|---|---|---|---|---|
| 2d | 中心荷 $c$（Zamolodchikov $C$-函数） | **rigorous**（强版本：沿流单调 + 梯度流） | Zamolodchikov 1986 | Poincaré、幺正=反射正性、可重整 |
| 2d | 熵版 $c(R)=R\,S'(R)$ | **rigorous**（物理意义上，含 EE 正则化假设） | Casini–Huerta 2004/2007 | Lorentz 不变 + EE 强次可加性（SSA） |
| 3d | 球自由能 $F=-\log Z_{S^3}$ 有限部（熵版 $\mathcal F$） | **rigorous**（含 EE 正则化假设） | Casini–Huerta 2012 | Lorentz + SSA + 存在 Lorentz 不变 EE 正则化 |
| 4d | Euler 反常系数 $a$ | **弱版 physical-argument**（"proof" 依赖分析性 + ε-猜想）；强/最强版仅微扰 | Cardy 1988（猜想）；Komargodski–Schwimmer 2011（弱版"证明"） | Lorentz、幺正、dilaton 有效作用分析性、dilaton IR 解耦 |
| 4d | $a$（熵版） | **physical-argument**（含 EE 假设 + Markov 性质） | Casini–Testé–Torroba 2017 | Lorentz + SSA + CFT 真空 Markov 性质 + EE 正则化 |
| 任意 d（全息） | 全息 $a$-函数 | **rigorous**（经典 GR 内，条件于全息） | FGPW 1999；Myers–Sinha 2010 | Einstein 方程 + 零能条件（NEC）；仅在全息对偶成立时对偶到 QFT |
| 6d | $a$（SUSY 张量支流） | **rigorous**（SUSY 张量支流）；Higgs 支无穷类已证 | Córdova–Dumitrescu–Intriligator 2015；双仿射 Grassmann 2023 | $\mathcal N=(1,0)$ SUSY、反常匹配、dilaton WZ 项 |
| 6d | $a$（一般/非 SUSY） | **真开放** | — | — |
| 连续 d | $\tilde F=\sin(\pi d/2)\log Z_{S^d}$ | **真开放**（猜想；仅 d=2,3,4 整数点已证，微扰下成立） | Giombi–Klebanov 2014；Fei–Giombi–Klebanov–Tarnopolsky 2015 | 维数解析延拓、球自由能 |
| 奇数 d ≥ 5 / 一般偶 d ≥ 6 | 单调量存在性 | **真开放** | — | — |

---

## 2. A 类：已严格证明（rigorous）

### 2.1 2d c-定理（Zamolodchikov 1986）— 谱系的黄金标准
⟨lit⟩ **精确陈述**：二维可重整幺正 QFT 中存在函数 $C(g_i,\mu)$：(1) 在每个 RG 不动点等于对应 CFT 的中心荷 $c$；(2) 沿任意 RG 流单调不增；(3) 只在不动点驻定。这是"最强版本"（沿流单调 + 梯度流结构）。

⟨lit⟩ **证明骨架**（脆命题核心，全解析）：用应力张量二点函数的三个标量结构 $F,G,H$（对应 $\langle TT\rangle,\langle \Theta T\rangle,\langle\Theta\Theta\rangle$，$\Theta$ 为迹）。守恒律给出它们的标度导数关系；定义
$$C = 2\big(F-\tfrac12 G-\tfrac{3}{16}H\big),\qquad \dot C = -\tfrac34 H,$$
（$\dot{} = z\bar z\,\tfrac{d}{d(z\bar z)}$）。幺正（反射正性）$\Rightarrow H\ge0\Rightarrow \dot C\le0$。不动点处 $\Theta=0$，$C\to c$。

⟨lit⟩ **假设强度**：Poincaré（平移+转动）、反射正性（= 欧氏幺正）、可重整性。仅需*二维*的特殊性（应力张量分量的共形结构 + 守恒把三函数锁成一个）。Zamolodchikov 的技巧"只在 D=2 灵验"。

⟨judgment⟩ **地位/脆度**：地位极高但严格状态**已闭**（是定理，不是开放问题）。价值在**形式化演示**而非填空。合方法度高（有限步代数不等式），但对象是"交互 2d QFT 里的应力张量关联子 + 反射正性公理"——非 Mathlib 现成对象，需公理化关联子结构与正性。属"安全岛形式化"候选，类比无鬼定理。

### 2.2 2d/3d 熵版 c/F-定理（Casini–Huerta）— 重点评估可形式化性
⟨lit⟩ **2d（Casini–Huerta 2004/2007）**：对区间定义真空纠缠熵 $S(R)$，Lorentz 不变把它写成固有长度 $R$ 的函数。SSA 直接给
$$c(R)\equiv R\,\frac{dS}{dR},\qquad c'(R)\le 0,$$
$R\to0,\infty$ 极限分别回到 $c_{\rm UV},c_{\rm IR}$，得 $c_{\rm IR}\le c_{\rm UV}$。证明"一句话可写完"。

⟨lit⟩ **3d F-定理（Casini–Huerta 2012, arXiv:1202.5650）**：圆盘纠缠熵是凹函数。构造为把一族在公共光锥上的 boost 后圆盘（其并/交逼近半径 $R,r$ 的圆盘）代入 SSA，得重整化纠缠熵 $\mathcal F$（面积项系数减、常数项 = 球自由能 $F$ 增反号）单调。对偶于全息 c-定理与 $S^3$ 配分函数 F-猜想。

⟨lit⟩ **假设强度（关键脆点）**：定理成立**依赖两条 EE 正则化假设**：(a) 存在一个 Lorentz 不变的纠缠熵正则化，对"边界光滑但在光锥/光面上有有限个角"的区域有定义；(b) 该正则熵对相互切割生成新光面角的集合满足 SSA。这两条在物理上被接受，但**不是从第一性原理严格建立的数学事实**（连续 QFT 的 EE 本身 UV 发散、需正则化）。

⟨judgment⟩ **地位/脆度**：物理意义上"相对严格"，逻辑核心（SSA + Lorentz ⇒ 单调）是**纯不等式/微积分论证，极合我们方法**。真正的脆点 = 那两条 EE 假设是否真成立、以及 4d 是否需额外输入（见 §3.2）。**诚实的形式化路径**：形式化"**条件蕴含**"——"给定满足 SSA + Lorentz 协变公理的熵泛函，则熵版 $c$-函数单调"，把 EE 存在性/SSA 作为**显式前提（axiom 卡）**，绝不宣称证明了 EE 本身。这样产出的是真·机器验证的"RG 单调性 ⇐ SSA + Lorentz"，且诚实标注假设。**这是全领域里 fit×honesty 最高的靶。**

### 2.3 全息 c-定理（FGPW 1999；Myers–Sinha 2010）— 最干净的 ODE 不等式 + 弦连接
⟨lit⟩ **陈述**：RG 流实现为 AdS 中的畴壁几何 $ds^2=e^{2A(r)}dx_\mu^2+dr^2$。Einstein 方程 + 体内**零能条件（NEC）**保证构造的全息 $a$-函数沿 $r$（= RG 尺度）单调。FGPW 给 SUSY 畴壁 + c-定理；Myers–Sinha 推广到任意维、给 $a$-型中心荷并连接全息纠缠熵。

⟨judgment⟩ **证明结构**：NEC $\Rightarrow A''(r)\le0 \Rightarrow$ 定义的 $a(r)\propto (A'(r))^{-(d-1)}$ 满足 $a'(r)\ge0$——一个从 Einstein 方程 + 一条几何不等式推出的**初等 ODE 单调性**。⟨lit⟩ 各向异性/非相对论流里 NEC 单独不足以保证（需 UV 数据额外条件）。

⟨judgment⟩ **地位/脆度**：**经典 GR 内完全严格**（是定理），且合方法度**极高**（有限步微分几何 + 不等式，Mathlib 分析够用），并且**唯一与弦论图直接相连**的靶（AdS/CFT、全息 RG 已在图内）。脆度低（结论稳），价值 = 形式化 + 图内接线。缺点：物理内容只在"全息对偶成立 + 经典体 + NEC"这一层为真，是条件命题。属"安全岛形式化"的强候选，与无鬼定理路线气质最像。

### 2.4 6d a-定理（SUSY 情形）
⟨lit⟩ **张量支流（Córdova–Dumitrescu–Intriligator 2015, 待核 arXiv:1506.03807）**：6d $\mathcal N=(1,0)$ SCFT 中 $a$-型 Weyl 反常与 R-对称/引力 't Hooft 反常系数成线性关系；沿张量支流（共形对称自发破缺）SUSY 把 $\Delta a$ 关联到 dilaton 四导数相互作用的平方，从而 $\Delta a>0$。**对所有张量支流已证**（这是 6d SCFT 仅有的保 SUSY 流之一）。
⟨lit⟩ **Higgs 支流（双仿射 Grassmann 2023, arXiv:2312.17178, 作者待核）**：对无穷类 A-型 orbi-instanton 6d $(1,0)$ SCFT，Higgs 支 RG 流层级 = $E_8$ 双仿射 Grassmann 某些 strata/transverse slice 的 Hasse 图，用其上的偏序证 a-定理。号称"任意偶维 SUSY c-定理的最后一块"。

⟨judgment⟩ **地位/脆度**：地位高。张量支证明用反常匹配 + dilaton WZ 项（physical-argument 气质，但 SUSY 把它锁得很紧）。**双仿射 Grassmann 证明是组合/偏序论证**（Hasse 图 + 偏序），比其余 6d 论证更接近"我们方法"，且 6d $(1,0)$ SCFT 本身是弦论对象（F-理论构造），有弦连接。缺点：深表示论，形式化成本高。

---

## 3. B 类：物理论证（有推导但不严格 / 依赖强假设）

### 3.1 4d 弱 a-定理（Komargodski–Schwimmer 2011）— 被广泛接受但有假设缺口
⟨lit⟩ **陈述**：4d Weyl 反常 Euler 密度系数 $a$ 满足 $a_{\rm UV}>a_{\rm IR}$（弱版，只管端点）。Cardy 1988 猜想。
⟨lit⟩ **证明骨架**：把破坏共形的质量参数提为 dilaton $\tau(x)$ 的函数恢复共形不变；$a$-反常"非阿贝尔"，给 dilaton $2\to2$ 散射振幅一个正定普适项，其系数 = $\Delta a=a_{\rm UV}-a_{\rm IR}$。前向极限色散关系 + 幺正性（光学定理，$\mathrm{Im}A\ge0$）给
$$\Delta a=\frac{f^4}{4\pi}\int_0^\infty ds\,\frac{\mathrm{Im}A(s,0)}{s^3}>0.$$
⟨lit⟩ **假设强度（脆点）**：(1) 幺正；(2) dilaton 四点振幅的**分析性**（色散关系成立）；(3) **ε-猜想 = dilaton 在 IR 与其余理论解耦**——这条被后续文献质疑，若成立则同时蕴含"4d 标度不变 ⟹ 共形不变"（另一条长期猜想）。故 KS 的最一般版"证明"**未完全闭合**：它把不可逆性归约到一条尚未严格建立的解耦假设。

⟨judgment⟩ **诚实定级**：按本项目 STATUS_LEVELS，"论证骨架 + 关键步骤为分析性/解耦假设"应记 **physical-argument**（gaps 逐条写明），而非 rigorous——尽管社区默认"a-定理已被 KS 证明"。⟨judgment⟩ **合方法度低**：S-矩阵分析性、色散关系在交互 QFT 里不是严格数学对象，形式化几乎不可行；开放缺口（ε-猜想）是物理猜想，不是靠代数能补的洞。

### 3.2 4d 熵版 a-定理（Casini–Testé–Torroba 2017, arXiv:1704.01870）
⟨lit⟩ 用 SSA + Lorentz + **CFT 真空 Markov 性质**（companion arXiv:1703.10656：光面上区域的模哈密顿量是应力张量的局部积分，构成无穷维 Lie 代数）给 d=4 a-定理独立证明，统一 d=2,3,4 的 c/F/a 定理为同一熵机制。
⟨lit⟩ **假设强度**：同 §2.2 的 EE 正则化假设 + Markov 性质（CFT 特有的 SSA 饱和条件）。
⟨judgment⟩ **定级**：比 2d/3d 多一层（Markov 性质），且仍挂在 EE 正则化假设上，故物理意义上"相对严格"但含软输入。合方法度：Markov 性质本身是代数 QFT 陈述，可作前提；但形式化整链成本明显高于 2d/3d。

### 3.3 4d 强/最强 a-定理（Jack–Osborn；局部 RG / Weyl 一致性条件）
⟨lit⟩ **层级**：弱版（端点 $a_{\rm UV}>a_{\rm IR}$，KS）< 强版（沿流单调 $a$-函数）< 最强版（RG 流是 $a$-函数关于正定度规的梯度流 $\beta^I=G^{IJ}\partial_J a$，$G>0$）。
⟨lit⟩ Jack–Osborn（1990）/ Osborn（1991）用弯曲背景 + 时空依赖耦合的局部 RG 方程 + Weyl（Wess–Zumino）一致性条件，**微扰**证明了强版 + 梯度公式 $\partial_I\tilde A=T_{IJ}\beta^J$。
⟨lit⟩ **开放缺口**：(1) 一致性条件给出梯度流*结构*，但**不保证度规 $G$ 正定**（论证对非幺正理论也成立，故正定性未导出）——正定性正是单调性所需，仅微扰下成立。(2) **极限环**存在（Jack–Osborn 的 S-函数；四维幺正规范理论里有 recurrent 轨道的 CFT），说明*精确*梯度流不能普适成立——但 a-定理仍控制流的渐近行为。

⟨judgment⟩ **脆度高、地位高**：非微扰的、带正定度规的单调 a-定理是"长期追寻"的开放问题。⟨judgment⟩ 合方法度**中低**：微扰 Weyl 一致性条件是形式的图/重整化计算，正定性缺口是连续 QFT 难题，非有限步代数可闭。

### 3.4 a-极大化（Intriligator–Wecht 2003, hep-th/0304128）
⟨lit⟩ **陈述**：4d $\mathcal N=1$ SCFT 的超共形 R-对称是（局部）极大化 $a_{\rm trial}(R)=\tfrac{1}{32}(9\,\mathrm{Tr}\,R^3-3\,\mathrm{Tr}\,R)$ 的那个；极大值 = 中心荷 $a$（Anselmi 等）。⟨lit⟩ 几乎立刻蕴含相关形变下 $a$ 减小（在更小的 R-对称子集上极大化）。后续 $\tau_{RR}$ 极小化（Barnes–Gorbatov–Intriligator–Sudano–Wright）给更本质的等价表述。
⟨lit⟩ **假设**：'t Hooft 反常公式；"局部极大"限定；算子撞幺正界解耦的处理。
⟨judgment⟩ **定级/脆度**：确定 $a$ 的强工具，证据充分，但本身不是单调性定理（是 §3.3"最强版"的 SUSY 证据，经 Kutasov 沿流推广后给单调 $a$-函数）。合方法度：反常公式的代数是有限的，但"哪个 R-对称、哪些算子解耦"依赖 SCFT 谱知识，形式化价值有限。

---

## 4. C 类：真开放（无严格证明）

- ⟨lit⟩ **6d 一般/非 SUSY a-定理**：无证明。微扰 $\phi^3$ 里 $\tilde a$ 反而*增*（Grinstein–Stergiou–Stone–Zhong "Challenge to the a-theorem in 6d", arXiv:1406.3626，作者待核）——但非真反例（流不连接两个真不动点，只出自平凡 Gauss 不动点；6d 无已知非 SUSY 交互 CFT）。无反例但无证明。
- ⟨lit⟩ **广义 F-定理（连续 d，Giombi–Klebanov 2014 / Fei–Giombi–Klebanov–Tarnopolsky 2015, arXiv:1507.01960）**：$\tilde F=\sin(\pi d/2)\log Z_{S^d}$ 猜想沿流单调。仅微扰（弱相关形变）+ 大量例子（自由场、大 N 双迹、Wilson–Fisher、QED_d）验证；连续 d 无证明，严格证明只在 d=2,3,4 整数点。
- ⟨lit⟩ **非微扰强/最强 4d a-定理**：理论空间度规正定性 + 极限环障碍（§3.3），非微扰开放。
- ⟨judgment⟩ **奇数 d≥5 / 一般偶 d≥6 单调量存在性**：纠缠熵跨球给候选 C-函数（任意维），但单调性只在 d=2,3（及 d=4 熵路线）证得。一般维单调量的存在性开放。

---

## 5. 候选靶子评估（合方法度 × 脆度）

| # | 靶子 | 严格状态 | 合方法度 | 脆度 | 形式化 vs research/ | 弦连接 |
|---|---|---|---|---|---|---|
| **T1** | **熵版 2d c / 3d F 定理的条件形式化**（SSA + Lorentz ⇒ 单调 C，EE 存在性作前提） | 物理上 rigorous，含 EE 假设 | **高**（纯不等式/微积分） | 中（EE 假设是显式前提，正是"脆"处） | **形式化**（条件蕴含）；EE 公理进 axiom 卡 | 弱（纯相对论 QFT） |
| **T2** | **全息 c-定理**（NEC ⇒ 全息 a-函数单调，FGPW/Myers–Sinha） | 经典 GR 内 rigorous | **高**（ODE + 微分几何不等式） | 低（结论稳，条件于全息） | **形式化**（安全岛，气质近无鬼定理） | **强**（AdS/CFT 在图内） |
| T3 | 2d Zamolodchikov c-定理（应力张量版） | rigorous（已闭） | 高（代数），但需公理化关联子+反射正性 | 低 | 形式化（安全岛） | 弱 |
| T4 | 6d a-定理（一般/非 SUSY） | **真开放** | 低（需全套连续 QFT） | **高**（最高地位开放） | research/（但射程外） | 中（6d SCFT 是弦对象） |
| T5 | 6d SUSY Higgs 支（双仿射 Grassmann 偏序论证） | rigorous（无穷类） | 中（组合/偏序，但深表示论） | 中 | 形式化（远期，成本高） | 中（F-理论） |
| T6 | 广义 F-定理（连续 d） | 真开放（猜想） | 低（维数延拓非严格对象） | 高 | research/（射程外） | 弱 |
| T7 | 4d 弱 a-定理（KS） | physical-argument（ε-猜想缺口） | 低（S-矩阵分析性） | 高（缺口是物理猜想） | 皆难 | 中 |

---

## 6. 推荐与自我攻击

### 最推荐单一靶：T1 —— 熵版 c/F 定理的**条件形式化**
⟨judgment⟩ **理由**：它是全领域里"**不等式论证 + Lean**"匹配度与**诚实度**同时最高的靶。逻辑核心（SSA + Lorentz 协变 ⇒ $c(R)=R\,S'(R)$ 单调）是纯微积分/凸性不等式，Mathlib 现成；而我们**不**假装证明连续 QFT 的纠缠熵存在或其 SSA——把"存在满足 SSA 的 Lorentz 不变正则熵泛函"作为**显式 axiom 前提**，产出一条真·机器验证的定理"RG 单调性 ⇐ 这些前提"。这恰好把领域里最"脆"的部分（EE 正则化假设是否成立、4d 是否需 Markov 额外输入）暴露成图上可审计的前提集合，是本项目"精确回答某结论建立在多少条假设上"使命的教科书样例。

⟨judgment⟩ **并列强推 T2（全息 c-定理）**作"安全岛"备选：若优先要一个**与弦论图直接相连**、结论完全稳、纯 ODE 的形式化岛，T2 比 T1 更"干净"（无需公理化熵泛函，只需 Einstein 方程 + NEC + 初等分析），气质最接近现有无鬼定理路线。二者可先做**可行性对比**再定。

### 建议第一步
⟨judgment⟩ 取 Casini–Huerta 2d 论证，**在纸上抽出其不等式骨架并列出最小假设集**：把 $S(R)$、SSA、Lorentz 协变各归约成对熵泛函的抽象公理（如 $S:\mathbb R_{>0}\to\mathbb R$、由 SSA 导出的 $S''(R)\le 0$ 型二阶不等式），验证"$c(R)=R S'(R)$ 单调、端点回中心荷"仅需哪几条公理，判断这些公理在 Lean 里表述的代价。这一步纯纸面、零风险，直接决定 T1 是否值得起 formal/ 岛或 research/ 卡。

### 自我攻击（诚实边界）
- ⟨judgment⟩ **整个领域偏纯 QFT / 引力，离本项目的弦论世界面图较远**。最近的连接是 T2（AdS/CFT）与 T4/T5（6d SCFT = F-理论对象）；T1/T3（熵版、Zamolodchikov）是纯相对论 QFT，进图后会是"孤岛"，除非项目愿意开一个 RG/全息子图。
- ⟨judgment⟩ **T1/T3/T4 的严格性都卡在难以形式化的连续 QFT 假设上**：交互 QFT 的应力张量关联子、纠缠熵及其 SSA、S-矩阵分析性——这些在 Mathlib 里都无严格对象。我们能诚实做的只是"**条件蕴含**"的形式化（把假设显式化为前提），**不能**宣称证明了物理定理本身。任何把 T1/T2 标成"a-定理已 formalized"的做法都是虚高，必须写清"formalized 的是 <假设> ⇒ <单调性> 这条蕴含"。
- ⟨judgment⟩ **最高地位的开放问题（T4 一般 6d、T6 广义 F）恰恰最不合我们方法**：它们真开放、含金量最高，但攻克需要连续 QFT/SCFT 的完整机器，超出"有限步代数 + 不等式"的射程，不建议作 research/ 原创靶（会重蹈"造不出对象"的覆辙）。
- ⟨judgment⟩ **KS 弱 a-定理（T7）社区默认"已证"，但严格看有 ε-猜想缺口**——若项目将来在图里登记 4d a-定理，应按 physical-argument + gaps 记，别被"a-theorem was proved" 的通俗说法带成 rigorous。

---

## 7. 关键文献（作者 + 年份；arXiv 号标"待核"者需落地前逐一核对）

- Zamolodchikov 1986, *JETP Lett.* **43**, 730（2d c-定理，pre-arXiv）⟨lit⟩
- Cardy 1988, *Phys. Lett.* **B215**, 749（4d a-猜想）⟨lit⟩
- Casini–Huerta 2004, *Phys. Lett.* **B600**, 142（hep-th/0405111 待核）+ 2007, *J. Phys. A* **40**, 7031（熵版 2d c-定理）⟨lit⟩
- Casini–Huerta 2012, *Phys. Rev. D* **85**, 125016, arXiv:1202.5650（熵版 3d F-定理）⟨lit⟩
- Casini–Testé–Torroba 2017, *PRL* **118**, 261602, arXiv:1704.01870（熵版 4d a-定理）+ companion arXiv:1703.10656（Markov 性质 / 光面模哈密顿量）⟨lit⟩
- Komargodski–Schwimmer 2011, *JHEP* **12**, 099, arXiv:1107.3987（4d 弱 a-定理，dilaton）⟨lit⟩；后续 Komargodski arXiv:1112.4538（待核）
- Luty–Polchinski–Rattazzi arXiv:1204.5221（a-定理与 4d QFT 渐近；标度 vs 共形）待核；Dymarsky–Komargodski–Schwimmer–Theisen arXiv:1309.2921（4d 标度 vs 共形）待核 ⟨lit⟩
- Jack–Osborn 1990, *Nucl. Phys.* **B343**, 647；Osborn 1991, *Nucl. Phys.* **B363**, 486（局部 RG / Weyl 一致性条件；微扰强 a-定理）待核卷号 ⟨lit⟩
- Freedman–Gubser–Pilch–Warner 1999, *ATMP* **3**, 363, hep-th/9904017（全息 c-定理）⟨lit⟩
- Myers–Sinha 2010, *Phys. Rev. D* **82**, 046006, arXiv:1006.1263；2011, *JHEP* **01**, 125, arXiv:1011.5819（任意维全息 c-定理）⟨lit⟩
- Córdova–Dumitrescu–Intriligator 2015/16（6d $(1,0)$ 反常与 a-定理，张量支）arXiv:1506.03807 待核 ⟨lit⟩
- Elvang–Freedman–Hung–Kiermaier–Myers–Theisen 2012, *JHEP* **10**, 011（6d RG 流与 a-定理，dilaton）arXiv:1205.3994 待核 ⟨lit⟩
- Grinstein–Stergiou–Stone–Zhong 2014, "Challenge to the a-theorem in six dimensions", arXiv:1406.3626（作者顺序待核）⟨lit⟩
- 双仿射 Grassmann 6d a-定理 2023, arXiv:2312.17178（作者待核）⟨lit⟩
- Giombi–Klebanov 2014, "Interpolating between a and F", arXiv:1409.1937 待核；Fei–Giombi–Klebanov–Tarnopolsky 2015, arXiv:1507.01960（广义 F-定理与 ε 展开）⟨lit⟩
- Intriligator–Wecht 2003, *Nucl. Phys.* **B667**, 183, hep-th/0304128（a-极大化）⟨lit⟩

> 侦察结论一句话：**若要一条既高地位又能真正做到机器验证严格的线，走"熵版 c/F 定理条件形式化（T1）"或"全息 c-定理 NEC 不等式（T2）"；真开放的高含金量（一般 6d a-定理、广义 F-定理）地位最高但离我们方法最远，不宜作原创攻坚靶。**
