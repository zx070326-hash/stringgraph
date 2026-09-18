# 抽取记录：断言 (2) 第二轮候选核查——「物理正规序指数 = VOA 格点顶点算子结构映射」

- 任务：第二轮追查 `graph/statements/worldsheet/physical-exponential-equals-voa-vertex-operator.yaml`
  唯一瓶颈「断言 (2)」`:e^{i n k₀·X(z)}: = 𝒴(e^{n k₀}, z)` 的文献来源。上一轮（见
  `literature/extractions/assertion-2-lattice-vertex-physical-identification-2026-09-18.md`）查了三个纯数学
  候选（Frenkel 1985、Frenkel–Ben-Zvi 经其 Bourbaki 综述、FLM 1988），判定 (B) 查无。本轮换一批
  「物理学家写的 VOA / 数学物理桥梁」候选。
- 抽取者：researcher（本轮，第二次）
- 日期：2026-09-18
- 覆盖范围：见下逐候选记录。**本轮四个高优先级候选（Goddard–Olive 1986、Kac 1998 §5、
  Goddard 1989、Dong–Lepowsky 1993）全部在正文获取阶段被公开渠道（反爬 / 付费墙 / 无镜像）拦下，
  维持 L0**；Kac–Raina–Rozhkovskaya 2013（候选 5）同样 L0；唯一拿到全文的是意外检索命中的
  Nikolov–Todorov 2004（候选 7，不在原任务书名单内），L1 通读但判定不承载。

## 判据重申（照抄任务书，逐条核对时用）

文献必须**同时**：
1. **写出**物理侧对象——`X^μ(z)`（或等价的自由玻色场模展开 `α^μ_n`）与正规序记号 `: :`；
   只在散文里**提到** "free bosonic conformal field theory" **不算**；
2. 把它与 VOA 侧结构映射 `Y(e^α,z)` / `𝒴(e^α,z)` **划等号**（不是"显然"/"well known"带过）。

---

## 候选 1（★最高优先级）：P. Goddard, D. I. Olive, *Kac-Moody and Virasoro Algebras in Relation to
Quantum Physics*, Int. J. Mod. Phys. A**1** (1986) 303–414. 新登记 bib key `goddard-olive-1986`。

### E1 穷尽公开渠道核实结果：全部失败，正文维持 L0
- 位置：N/A（记录的是"查无"过程，不是文献内容）
- 类型：（方法论记录，穷尽尝试清单）
- 尝试的公开渠道与结果：
  1. **CERN Document Server**（`cds.cern.ch/record/168465?ln=en`，INSPIRE 记录 18583 证实对应
     Cambridge 预印本 **DAMTP-86-5**）：本环境对该域名的**一切**请求路径
     （`?ln=en`、`/files/CM-P00058591.pdf`、`/files/`、`/export/hx`）均返回**同一份 7591 字节的
     Anubis 反爬工作量证明挑战页**（`<title>Making sure you're not a bot!</title>`），HTTP 200
     但内容是 JS challenge，非正文，curl（带浏览器 UA）与 WebFetch 均未能穿透。
  2. **INSPIRE-HEP**（`inspirehep.net/literature/18583`，API 直查）：`documents` 与 `urls` 字段
     **均为空**——INSPIRE 自己也没有托管全文或外部链接，只有 `report_numbers: DAMTP-86-5`。
  3. **World Scientific**（该文后被重印为 *Kac-Moody and Virasoro Algebras: A Reprint Volume for
     Physicists* 的 Introduction 一章，`worldscientific.com/doi/10.1142/9789812798398_0001`；
     书本身页 `worldscientific.com/worldscibooks/10.1142/0485`）：**两个 URL 均返回 Cloudflare
     质询页**（`<title>Just a moment...</title>`，`challenges.cloudflare.com`），WebFetch 直接 403，
     curl 带浏览器 UA 拿到的仍是 Cloudflare JS 挑战页（非正文）。
  4. **Google Books**（对该重印文集尝试了 volume id `Wpk6Q-gFTmwC` 与 `VXHFCwAAQBAJ` 两个候选）：
     `books.google.com/books?id=<ID>&q=<短语>` 的检索本轮**全部触发 429 或验证码重定向**
     （`google.com/sorry/index?...`），Google Books 官方 Custom Search API 本轮**配额已耗尽**
     （`RESOURCE_EXHAUSTED`），**未能执行任何一次带控制组的页码定位查询**（对照本项目既有方法论
     `math-sources.md §9.2/§15.3` 的「先跑无意义串控制查询」纪律——本轮连控制查询都没跑成）。
  5. **Semantic Scholar API**（DOI 直查 `10.1142/S0217751X86000149`）：**成功返回**，逐字确认
     `"isOpenAccess": false, "openAccessPdf": {"url": "", "status": "CLOSED", "license": null}`。
     这是**独立于本项目手气的、索引层面的确认**：全网范围内也没有被 Semantic Scholar 收录到任何
     合法免费全文。
- 文献自称的严格程度：N/A（正文未获取）
- 文献列出的依赖：N/A
- 备注：⚠ **这是本轮任务书标注的最高优先级候选，也是穷尽尝试最多渠道、结论最明确的一条
  "查无法获取"**——五条独立渠道（CDS、INSPIRE、World Scientific 官方页、Google Books、
  Semantic Scholar 索引确认）全部指向同一结论：**该文正文没有任何合法公开可读途径**，
  不是本项目检索技巧不够，是全网范围内确实没有开放获取。

### 小结（Goddard–Olive 1986 → 断言 (2)）

**完全 L0，无法判定。** 这是本轮最大的残余风险——任务书判断它"最可能承载"，
但本轮**穷尽了五种独立公开渠道**仍未拿到只字正文，**不能算作"读过了、确认不承载"**，
只能算"确认无法访问"。若未来某高校图书馆代理、CDS 反爬策略变化、或作者/出版社放出
促销预览，应第一时间重查。

---

## 候选 2：V. Kac, *Vertex Algebras for Beginners*, AMS University Lecture Series **10**
（第 2 版，1998）§5 "Examples of vertex algebras and their applications"。bib key 已存在
`kac-1998`（2026-09-11 首次登记，本轮追加 note）。

### E2 本轮新增核实：任务书给的「§5」编号定位本身核实为对，但子节/定理号仍不可得
- 位置：AMS 官方书目 + WebSearch 转述的 Stanford SearchWorks 目录（L4，非正文）
- 类型：（元信息，目录）
- 原文陈述（转述，非逐字——本轮未拿到扫描目录页，只有检索后端摘要的转述）：
  目录五章：「1. Wightman axioms and vertex algebras / 2. Calculus of formal distributions /
  3. Local fields / 4. Structure theory of vertex algebras / **5. Examples of vertex algebras
  and their applications**」。
- 文献自称的严格程度：N/A（目录）
- 文献列出的依赖：N/A
- 备注：任务书写「§5（格点顶点代数）」——**章节号本身大方向不错**（格点顶点代数与自由场实现
  确实归在第 5 章"Examples"），但**具体子节号、命题号完全未核实**（与本卡此前已确认的 §2–§4
  编号情况一致：此前 researcher 靠 Kac 本人的勘误表 `kac-1999-corrections`（arXiv:math/9901070）
  L1 确认了 §3.2/§3.3/§4.2/§4.4/§4.5/§4.6/§4.8/§4.11 等编号，但**勘误表完全不涉及第 5 章**，
  第 5 章没有独立的编号来源）。

### E3 穷尽公开渠道核实结果：正文全部拿不到，本轮零进展
- 位置：N/A（方法论记录）
- 尝试的渠道：`bookstore.ams.org/ulect-10-r`（403，此前已知）；`w3.impa.br` 讲义镜像（403，此前已知）；
  本轮新试 WebSearch 关键词组合「course notes / lecture notes / chapter 5 / free field realization」
  寻找大学课程页单章镜像——**未命中任何 .edu/.ac 域名挂出的章节 PDF**（唯一相关的是 Oxford
  Joyce 2021 课程与 ETH Keller 课程，两者都只是**引用** Kac 的书作为参考文献，不转载内容）；
  Google Books 卷 `e-jxBwAAQBAJ` 的 `&q=` 检索因本轮 Google Books 429/验证码故障（见候选 1 E1.4）
  **同样未能执行**。
- 备注：**§5 的具体内容（含可能承载断言 (2) 的 free field realization / 物理正规序对应段落）
  本轮维持完全 L0**，没有任何进展——不是没找，是找了但公开渠道全部不通。

### 小结（Kac 1998 §5 → 断言 (2)）

**完全 L0，无法判定。** 与候选 1 同样性质的残余风险：不是"读过了没有"，是"完全拿不到"。

---

## 候选 3：P. Goddard, *Meromorphic Conformal Field Theory*, in *Infinite Dimensional Lie
Algebras and Lie Groups* (Proc. CIRM-Luminy 1988, ed. V. Kac), World Scientific 1989, pp. 556–587.

### E4 快速核实：同源问题，未深挖（按任务书优先级裁决，时间预算给 1、2）
- 位置：N/A
- 类型：（方法论记录）
- 备注：WebSearch 确认该文预印本号为 **Cambridge DAMTP-89-1**，正式出版于同一家出版社
  （World Scientific）旗下的会议论文集。**未找到任何免费 PDF、CDS 记录或作者主页镜像**——
  且发表场所（World Scientific 会议论文集）与候选 1 是**同一出版社**，基于候选 1 的实测结果
  （World Scientific 全站 Cloudflare 拦截），**判断大概率同样不可得，未做逐一验证请求**
  （任务书明确「时间不够就把 1、2 做扎实，3–6 标 L0 并说明，不要六个都浅尝辄止」）。
  维持 **L0**。

---

## 候选 4：C. Dong, J. Lepowsky, *Generalized Vertex Algebras and Relative Vertex Operators*,
Progress in Mathematics **112**, Birkhäuser, 1993.

### E5 快速核实：确认无免费公开全文
- 位置：N/A
- 类型：（方法论记录）
- 备注：WebSearch 确认官方托管在 `link.springer.com/book/10.1007/978-1-4612-0353-7`，页面
  逐字显示「This is a preview of subscription content, log in via an institution to check
  access」——**订阅墙**。未找到作者主页镜像或 arXiv 前身（本书早于 arXiv 广泛使用格点顶点
  代数文献的年代，此类专著通常无 arXiv 版）。维持 **L0**，未做逐一验证请求（同上，时间预算
  优先给 1、2）。

---

## 候选 5：V. Kac, A. Raina, N. Rozhkovskaya, *Bombay Lectures on Highest Weight Representations
of Infinite Dimensional Lie Algebras*，第 2 版，Adv. Ser. Math. Phys. **29**, World Scientific,
2013. 新登记 bib key `kac-raina-rozhkovskaya-2013`（**注意版本陷阱**：与已登记的第 1 版
`kac-raina-1987` 是不同的书，第 2 版新增「Part II: Vertex algebras」）。

### E6 核实结果：作者主页无 PDF，出版社页同域名已知被拦
- 位置：`math.ksu.edu/~rozhkovs/book_bombay.html`（Rozhkovskaya 本人主页，L1 读取成功）
- 类型：（元信息）
- 原文陈述（转述，页面内容摘要）：页面只有书封面图、作者/出版社/年份/ISBN 元数据、
  俄译版链接，**没有任何 PDF 下载链接、样章、或目录**，具体内容一律指向出版社页面。
- 文献自称的严格程度：N/A
- 文献列出的依赖：N/A
- 备注：出版社页 `worldscientific.com/worldscibooks/10.1142/8882` 与候选 1 核实为
  Cloudflare 拦截的 `10.1142/0485` **同域名**，判断大概率同样受阻，未单独发起请求核实
  （与候选 3/4 同样的时间预算裁决）。**正文完全 L0**。据出版社简介，第 2 版 Part II
  覆盖"normal ordered product""untwisted and twisted representations"等主题，方向对口，
  但内容本轮**完全无法核实**。

---

## 候选 6：FLM 1988 Ch. 8——**上一轮已穷尽五种公开渠道核实为完全 L0**
（见 `assertion-2-lattice-vertex-physical-identification-2026-09-18.md` E11），
任务书明确要求"不要重复它试过的那五个渠道"，且指出的新途径（Semantic Scholar / CiteSeerX
章节 PDF、作者个人主页及后续论文对 Ch.8 公式的逐字转引）本轮**未及执行**（时间预算优先给
1、2）；标记为**未尝试的新途径，留给下一轮**，不计入本轮 L0 结论的"已尝试"部分。

---

## 候选 7（意外命中，不在原任务书名单）：N. M. Nikolov, I. T. Todorov, *Lectures on Elliptic
Functions and Modular Forms in Conformal Field Theory*, arXiv:math-ph/0412039. 新登记 bib key
`nikolov-todorov-2004`。

**发现方式**：WebSearch 检索候选 1/2 关键词组合时，摘要器带出本文 §5.2 的公式片段作为
"物理式 `Y_α(z)` 公式"的命中结果，遂追加全文核实（`arxiv.org/pdf/math-ph/0412039` 200，
`pdftotext -layout` 落盘 5443 行，**L1 全文可得**）。

### E7 §5.2 "Lattice vertex algebras"：Heisenberg 振子构造 + VOA 记号 `Y(·,z)` 并置
- 位置：PDF 文本行 3266 起（对应刊印页 52–55），公式 (5.41)–(5.63)
- 类型：definition/proposition
- 原文陈述（逐字摘录，`pdftotext` 因数学符号丢失产生乱码处已用方括号说明，其余照抄）：
  > Introduce the Heisenberg current Lie algebra `h_C` with generators `h_n` for `n ∈ Z` and
  > `h ∈ h_C` such that `[h_n, h'_m] = n δ_{n,-m} ⟨h,h'⟩` ... (5.41)
  >
  > A system of mutually local fields whose modes generate `A_h` is given by the abelian currents
  > `h(z) ≡ Y(h,z) = Σ_{n∈Z} h_n z^{-n-1}` for `h ∈ h_C` ... (5.49)
  >
  > The fields whose modes will contain the operators `E_α` are defined as follows:
  > `Y_α(z) ≡ Y(E_α, z) := E_α z^{α_0} exp(Σ_{n<0} (α_n/n) z^{-n}) exp(Σ_{n>0} (α_n/n) z^{-n})` (5.51)
  >
  > where `α_n` are the modes in `h_C` corresponding to an element `α ∈ Q ⊂ h`. Note that if we
  > introduce the "integral" field `φ_α(z)` by `φ_α(z) := -Σ_{n≠0} (α_n/n) z^{-n}` ... (5.52)
  > then (5.51) is, by definition the Wick normal ordered exponent
  > `Y_α(z) = E_α z^{α_0} :e^{φ_α(z)}:` (5.53)
- 文献自称的严格程度：构造性定义，随后 (5.54)–(5.63) 推导对易关系、OPE (5.55)（引用 Weyl 型
  正规序恒等式 (5.56)）、局域性条件 (5.57)–(5.58)、Sugawara 应力张量 (5.59)–(5.61)——是完整推导，
  非猜想或断言式陈述。
- 文献列出的依赖：`h(z)`（E5-类比结构，(5.49)）；局域性判据引 Kac 存在性定理「[32] Chapt. 4」
  （= `kac-1998` 第 4 章，与本图候选 2 是同一部书，未展开引用细节）。
- 备注：**这是本轮找到的、同时使用两套记号密度最高的文献**——(5.51)/(5.53) 左端标为
  `Y_α(z)`（VOA 结构映射记号），右端却是纯 Wick 正规序指数 `E_α z^{α_0} :e^{φ_α(z)}:`，
  `φ_α(z)` 的构造（产生模求和 + 湮灭模求和的正规序拆分）与断言 (2) 左端
  `:e^{i n k₀·X(z)}:` 的 E₋·零模·E₊ 分解**结构逐项同构**（`φ_α(z)` 起 `n k₀·X(z)` 的作用）。

### E8 为什么 E7 仍不满足判据（严格核对）
- 位置：同上，另加 p.57 (Remark 5.3，PDF 行 3542–3562) 与全文关键词检索
- 类型：（判据核对，非文献陈述）
- 备注（逐条对照任务书判据）：
  1. **判据条件 2 的关键是"两个独立构造的对象之间划等号"**，而 (5.51)/(5.53) 是**单一定义**：
     作者先写 `Y_α(z) := (公式)`（用 `:=`，定义符号），再指出"按定义这就是 Wick 正规序指数"，
     是"同一构造的两种写法"，不是"物理侧独立构造出一个对象、再证明它等于 VOA 结构映射"。
     这与 Li–Wang (3.10)（VOA 侧内部展开公式）、Frenkel–Bourbaki §3.3 (E6，`Y(1_λ,z)` 的显式公式）
     是**同一类型**：VOA 映射自身的构造性展开，不是跨框架的翻译句。
  2. **全文没有 `X^μ(z)`、没有显式时空指标 `μ`**：本文的 `h ∈ h_C` 是抽象 `r` 维实向量空间
     （对应 rank-`r` 阿贝尔流代数），不是 D 维时空动量；`φ_α(z)` 没有被称为"弦坐标场"或
     等价说法。
  3. **全文没有 "worldsheet" / "string theory" 出现在正文推导中**——唯一涉及弦的段落是
     Remark 5.3（p.57）：「there are unique (isomorphism classes of) even self-dual lattices of
     type (25,1) and (9,1) corresponding to bosonic and super-string theories, respectively.」
     这句话**只是格论旁注**（说明 (25,1)/(9,1) 型偶自对偶格的存在唯一性与玻色/超弦对应），
     **没有接回 `Y_α(z)` 与任何物理场的等式**，也不满足判据条件 1（未写出 `X^μ(z)` 公式）。
  4. **接缝 (b)(c) 完全未处理**：全文的格 `Q` 从头到尾固定，没有连续动量的 Fock 塔；
     `(α,β)` 归一化因子在 (5.45)–(5.48) 里作为 2-cocycle 抽象讨论，未与任何物理
     `⟨p|p'⟩ = δ^D(p-p')` 型归一化对照。

### 小结（Nikolov–Todorov 2004 → 断言 (2)）

**不承载，是本轮（含上一轮）迄今找到的"两套记号密度最接近"但仍不合格的一篇**——判据条件 1
不满足（无 `X^μ(z)`，只有抽象 Heisenberg 振子），判据条件 2 表面上写了 `Y_α(z)` 但那是
**定义符号**而非**跨框架恒等式**。登记原因：为下一轮提供"这条路线大概率走不通"的负面证据，
且其严谨推导方式（(5.54)–(5.63) 完整给出局域性、OPE、Sugawara 张量）可作为断言 (2) 若要做成
"原创证明"时的方法论参考（Wick 定理正规序恒等式 (5.56) 是标准工具）。

---

## 未解决的疑问 / 残余风险（本轮结束时的状态）

1. **Goddard–Olive 1986（候选 1，任务书最高优先级）完全 L0**——五渠道穷尽仍拿不到正文。
   这是本轮**最大的残余风险**：任务书判断它"几乎必然同时出现"两套记号，本轮**没能验证也没能证伪**。
2. **Kac 1998 §5（候选 2）完全 L0**——具体子节/定理号仍未核实，正文完全拿不到。
3. **候选 3（Goddard 1989）、候选 4（Dong–Lepowsky 1993）、候选 5（Kac–Raina–Rozhkovskaya 2013）**：
   均只做了轻量级可得性核实（未逐一发起下载请求验证 403/Cloudflare），**按任务书优先级裁决为
   合理的时间分配，但严格说这三条的"L0"结论比候选 1/2 弱一档**（候选 1/2 是"五渠道逐一实测失败"，
   candidates 3–5 是"基于同出版社/同域名的合理外推 + 轻量 WebSearch"）。下一轮若要坐实，
   应对这三条也做逐渠道实测。
4. **候选 6（FLM 1988 Ch.8）**：任务书指出的新途径（转引论文里的逐字公式转抄、Semantic Scholar/
   CiteSeerX 章节 PDF）本轮**完全未执行**，纯粹因为时间预算全部给了候选 1/2。这是**明确未尝试**
   的部分，不计入"已核查排除"。
5. **Google Books 检索渠道本轮整体故障**（429 + 验证码 + API 配额耗尽），影响了候选 1、2 两条
   本应可以尝试的"页码定位法"（`math-sources.md §9.2/§15.3` 记录的既有方法论）。这是**环境层面
   的暂时性故障**，不是候选文献本身不可得的证据——下一轮若 Google Books 渠道恢复，应对候选 1、2
   重跑一次带控制组的页码定位查询。
6. **CERN Document Server 的 Anubis 反爬对 `cds.cern.ch` 全站生效**（不止本文一条记录），这意味着
   本项目此后任何候选文献若托管在 CDS，都应预期同样的失败模式，不必逐一重试基础访问方式。
7. **World Scientific 全站 Cloudflare 拦截**同理——候选 1（重印文集）、候选 3（会议论文集）、
   候选 5（第 2 版）三个候选**共享同一出版社/同一反爬防线**，这不是巧合，是结构性障碍：
   凡是格点顶点代数相关的、World Scientific 出版的经典文献（Goddard–Olive 系的整条出版脉络），
   本项目目前**没有任何公开渠道能读到正文**。

---

## ★★★ 结论（三选一）

### (B) 确认查无此证明——但**不同于上一轮**，本轮的 (B) 是**"穷尽公开渠道仍拿不到正文"意义上
的查无**，而非"读到正文后确认不承载"意义上的查无。

依据：
- **候选 1（Goddard–Olive 1986，最高优先级）**：五条独立公开渠道（CDS、INSPIRE、World Scientific
  官方页、Google Books、Semantic Scholar 开放获取索引）**全部证实或指向"无法获取正文"**。
  **这不是本轮判定"不承载"，是判定"完全无法核实"**——按任务书的判据说明，这条应算作
  **"我没能读到"意义上的残余风险**，与"确认查无此证明"性质不同。
- **候选 2（Kac 1998 §5）**：同样完全 L0，具体内容未核实。
- **候选 3–5**：轻量级核实，L0，判断基于合理外推（同出版社反爬防线）而非逐一实测。
- **候选 6（FLM 1988 Ch.8）**：延续上一轮的 L0，任务书指出的新途径本轮未及尝试。
- **候选 7（Nikolov–Todorov 2004，意外命中）**：**唯一被 L1 通读到底的候选**，判据条件 1、2
  均不满足，**明确判定不承载**——这是本轮唯一一条真正"读过了、确认没有"的候选。

**因此本轮结论只能是 (C) 部分/混合，不能简单归为 (A) 或 (B)：**
- 对**候选 1、2（本轮最高优先级）**：**无法判定**（完全 L0，访问渠道穷尽仍失败）——
  这是本轮任务的**主要残余风险**，必须显式标注，不能与"读过了、确认不承载"混为一谈。
- 对**候选 7**：**确认不承载**（L1 通读，判据条件 1、2 均不满足，理由见 E8）。
- 对**候选 3、4、5**：**轻度核实为 L0**，结论强度弱于候选 1、2。
- 对**候选 6**：**沿用上一轮 L0**，新途径未尝试。

⚠ **两轮加总的诚实账本**：跨两轮共核查了 8 篇候选文献（`frenkel-1985`、`frenkel-2000-bourbaki`、
`frenkel-benzvi-2004`、`flm-1988`、`goddard-olive-1986`、`kac-1998`、`goddard-1989`（未独立登记 bib）、
`dong-lepowsky-1993`（未独立登记 bib）、`kac-raina-rozhkovskaya-2013`、`nikolov-todorov-2004`），
其中**真正 L1 读到底、可以下"不承载"结论的只有 5 篇**（Frenkel 1985、Frenkel Bourbaki 综述、
Li–Wang 2008、Gebert–Nicolai 1995、Nikolov–Todorov 2004），**其余全部因公开渠道访问失败停在 L0**。
**在开原创轨道之前，lead 应当意识到：这不是"文献可能真的没有这一步"的强证据，更多是"格点顶点
代数这条数学物理交叉主题的经典文献（Goddard–Olive、Kac 各版本、Goddard 1989、Dong–Lepowsky）
恰好集中托管在几个反爬极严的平台（CDS Anubis、World Scientific Cloudflare、AMS bookstore）"
这一结构性障碍造成的访问困境。** 若 lead 决定基于当前证据开原创轨道，应在 research/ 的
文档里如实注明这一残余风险，而不是宣称"已排除所有物理侧桥梁文献"。

**建议下一轮（若还要在文献侧继续投入）**：
(i) 等待或换网络环境重试 CDS/World Scientific（两者都是可能随时段/IP 变化的反爬策略，
    非本文献永久不可得）；
(ii) Google Books 渠道故障是本轮的环境噪声，配额或验证码可能在后续会话恢复，值得重跑；
(iii) 候选 6 FLM 1988 的"转引论文逐字转抄公式"新途径完全未试，是性价比可能最高的剩余选项；
(iv) 若以上全部继续受阻，才应认真考虑候选 1/2 系永久不可得，转而完全依赖候选 7 类型的
     "近似但不合格"证据来支持"这一步在物理文献中即使存在也从未被以数学期望的方式陈述过"
     这一更弱、但可能才是诚实的结论。

---

## bib

- `goddard-olive-1986`：**本轮新登记**，note 记录五渠道穷尽失败过程（E1）。
- `kac-1998`：**本轮追加 note**（不新建条目），记录 §5 编号核实进展与访问失败（E2/E3）。
- `kac-raina-rozhkovskaya-2013`：**本轮新登记**（第 2 版，注意与 `kac-raina-1987` 第 1 版的版本陷阱）。
- `nikolov-todorov-2004`：**本轮新登记**，note 概括 E7/E8 的核心发现与不合格理由。
- `goddard-1989`（候选 3）、`dong-lepowsky-1993`（候选 4）：**本轮未登记 bib**——按本项目既有纪律
  （`math-sources.md §17` "编号没核实的一律不入 bib，只在这里留档"沿用的同类原则，此处是
  "正文完全未获取、只有轻量级可得性核实"，登记 bib 意义不大），仅在本抽取记录留档供下一轮查阅：
  - Goddard 1989: *Meromorphic Conformal Field Theory*, in *Infinite Dimensional Lie Algebras and
    Lie Groups* (CIRM-Luminy 1988, ed. Kac), World Scientific 1989, pp.556–587；预印本号
    Cambridge DAMTP-89-1。
  - Dong–Lepowsky 1993: *Generalized Vertex Algebras and Relative Vertex Operators*, Progress in
    Mathematics 112, Birkhäuser；Springer 链接 `link.springer.com/book/10.1007/978-1-4612-0353-7`
    （订阅墙）。
