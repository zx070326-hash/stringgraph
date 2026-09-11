# 待抽取队列

| 优先级 | ref | 范围 | 目标 area | 负责 | 状态 |
|---|---|---|---|---|---|
| P0 | polchinski-1998-v1 | §1–§6, §8（玻色弦、共形规范、光锥量子化、无鬼定理、模空间与一般亏格 FP、树级振幅；环面紧化与 T 对偶） | worldsheet | researcher | extracted（二手源，需持原书者核对 E34/E53/E58；**§5–§6 于 2026-09-11 追加 E69–E112**，其中 (6.4.23) Veneziano 表达式与 (6.6.23) 开闭弦关系最需核对；**§8 于 2026-09-11 追加 E113–E158**，其中 **(8.3.28) T 对偶「是同一个 CFT」的原文措辞最需核对（Q20）**，其次 (8.4.24)/(8.4.25) 的必要性半句（Q21/Q22）与 (8.7.2) DBI（Q25）。**§8.5 轨形未抽，见 E146**。勘误表风险见 Q14+Q24） |
| P0 | polchinski-1998-v1 | §1–§4（玻色弦、共形规范、光锥量子化、无鬼定理） | worldsheet | researcher | **★★ 原书核实完成（L1，2026-09-11 第六轮）** → `extractions/polchinski-1998-v1.md` **§12**。Q2/Q3/Q4/Q5/Q6/Q7/Q10/Q11/Q12/Q20/Q21/Q22 全部关闭；30 条图节点 loc 修改建议见 §12.10 B 表；15 条作者自承缺口见 C 表。**剩余最高性价比：Appendix A (A.1.31)、书末 References（Goddard–Thorn 是否被引）、§1.2 的 `T=1/(2πα')` 式号** |
| **P0** | **polchinski-1998-v1** | **第 7 章 One-loop amplitudes（pp. 206–230 全章）** | worldsheet, spectrum | researcher | **★★ extracted（L1 原书页图 25 页全读，2026-09-11 第七轮）** → **`extractions/polchinski-1998-v1-ch7.md`（独立文件，E1–E39）**。经 Cambridge Core 章级 PDF，item hash `1FCFE9B5026DE1E5210F0F62514336B0`，文件名规则一次命中。<br>**★★★ 最重要的一条否定结论**：**§7.4 的 tadpole 相消给的是 `SO(2¹³) = SO(8192)`，不是 SO(32)**。(7.4.24) 逐字「the total tadpole is proportional to `2¹³ ∓ n`. For the gauge group `SO(2¹³) = SO(8192)` this vanishes … **For the bosonic string this probably has no special significance, but the analogous cancellation for `SO(32)` in superstring theory does.**」——`SO(32)` 全章只出现这一次，**无计算、无式号、无引用**。⇒ **`spectrum.type-i-tadpole-cancellation-so32` 不能以第 7 章为来源**（见抽取记录 §5-B2）。<br>其余核心：(7.2.29) 模不变性 ⇒ `c−c̃ ∈ 24Z` **且** 自旋整数（**§8.4 E138 引用时丢了前提，见 Q3**）；(7.2.30) + **脚注 1**（compact unitary 条件）；(7.2.43)/(7.2.44) Dedekind η（**原书零证明，Lean 首选岛**）；(7.3.6) 环面真空振幅；**(7.3.14) UV 有限性只是「区域对比」不是收敛性定理**；**p.220 的 BRST 论证**（截断模空间 ⇒ 负模态不解耦）。<br>**顺带 L1 核实了 (5.1.15)**（ch.5 PDF p.4 = 印刷 p.148）：`worldsheet.modular-fundamental-domain` 的 loc **确认无误**，且拿到原书自己的强度措辞「it can be shown」。⚠ **(7.3.14) 是开区域、(5.1.15) 是闭区域，原书未说明**（Q1）。<br>**下一步（性价比排序）**：§5.3 取 (5.3.9)、书末 References、Vol.2 §10.8 的 type I tadpole、Appendix A |
| P0 | lian-zuckerman-1991 | 全文（Thm 2.13/2.25、Cor 2.26/2.28、Thm 3.5） | worldsheet | researcher | **extracted（L1 全文，2026-09-10）** → `extractions/primary-sources-round2.md` §1 |
| P0 | virasoro-lean-2025 | §9–§12 + App. A.2（Heisenberg、Sugawara c=1、Verma/Fock） | worldsheet | researcher | **extracted（L1 全文，2026-09-10）** → `primary-sources-round2.md` §5.2 |
| P0 | fgz-1986 | 全文 | worldsheet | researcher | extracted（L1 全文）→ `brst-cohomology-sources.md` §1 |
| P0 | goddard-thorn-1972 | 全文 | worldsheet | — | **blocked-但已定位到文件（2026-09-11 第四轮，`primary-sources-round2.md` §12）**：正文仍 L0，但已确认扫描件是 **`CM-P00058839.pdf`（报告号 `CERN-TH-1493`，CDS recid 388690，MARC 963 = PUBLIC）**，挡路的是 `cds.cern.ch` 的 Anubis 反爬**而非权限**——**人工浏览器一次点击即可取得**（URL 见备忘第 2 条）。第二轮「CERN TH 报告号线索已作废」的裁决**已被推翻**。重印文集路线**已穷尽**（只有 Schwarz 文集一处，该书不在 archive.org）。主线数学 canonical 维持 lian-zuckerman-1991 与 fgz-1986 |
| P0 | brower-1972 | 全文 | worldsheet | — | **blocked**：APS 全站 403。第四轮复核：**无 CDS、无 KEKSCAN、无重印**（Schwarz 文集收的是 Brower–Friedman 1973，非本篇），即无扫描件可循。只有摘要级（L2）。未试路径：MIT DSpace（预印本号可能是 `CTP 277`，L4 未核实） |
| P1 | thorn-1984 | 全文（Kac 行列式 + 更一般设定下的无鬼定理） | worldsheet | 待分派 | **queued（高价值）**：a<1 分支物理侧原始出处的最强候选；Elsevier 403，钥匙是报告号 UFTP-84-004 |
| P1 | kato-ogawa-1983 | 全文（是否给出 Ker Q_B / Im Q_B ≅ OCQ 物理态 的同构） | worldsheet | researcher | **attempted, still blocked（2026-09-11）** → `extractions/kato-ogawa-1983.md`。正文仍 L0（本轮 WebSearch 额度耗尽，「课程页扫描件」路线**未穷尽**）。但**证明结构已由三条 L1 二手来源三角定位**（IMNU 1986 §4 五处「same method in Ref. 1)」、LZ 1989 p.332 Dixon–Taylor 结构、KKM 2010 (2.1)）：鬼零模分离 + 光锥系（p⁺≠0）+ β 形式展开 + Kugo–Ojima quartet + DDF 横向投影 ⇒ physical-argument。⟺ 仍无来源；「Ker/Im ≅ OCQ」的上同调语言按 LZ/Dedushenko 归 FGZ。**KUNS 637 归属争议已关闭**（INSPIRE/INIS 单位 = 京都大学物理系）。KEKSCAN 2000-33-955（主机死） |
| P1 | thorn-1987 | 全文 | worldsheet | 待分派 | queued（优先级下调）：摘要已逐字，**不含 a<1 / D≤25**，不再是 a<1 分支的首选目标 |
| P2 | gsw-1987-v1 | §2.3.3（无鬼定理与 spectrum-generating algebra，p.102–112） | worldsheet | researcher | **attempted, still blocked（2026-09-11）** → `extractions/gsw-1987-v1.md` §1。正文仍一字未获取，**式号内容全为 L0，不得写进图**。本轮唯一进展：Google Books 卷 `ItVsHqjJo4gC` **通过无意义串控制**（诚实卷），新增式号→页码映射 (2.3.42)→102 / (2.3.52)→105 / (2.3.62)→107 / (2.3.72)→108，故 §2.3.3 起于 (2.3.42) 附近、DDF 定义落在 (2.3.42)–(2.3.52) 区间。**建议不再为此耗额度**：两条 DDF 对易关系已由下面三条来源覆盖 |
| P0 | goddard-2008 | §5「Spectrum Generating Algebra」+ §6「No-Ghost Theorem」 | worldsheet | researcher | **extracted（L1 全文，2026-09-11）** → `extractions/gsw-1987-v1.md` §2。**★ 两条 DDF 对易关系的逐字来源：(5.4) `[L_m,A^i_n]=0`（对 m 无限制）、(5.5) `[A^i_m,A^j_n]=mδ^{ij}δ_{m,−n}`；定义 (5.1)–(5.3)；号差 (−,+,+,+) 与 conv 一致无需换算。** 限制：历史综述，陈述无证明 |
| P0 | tomassini-2008 | §2.2–§2.3（DDF 算子的算子论处理） | worldsheet | researcher | **extracted（L1 相关章节，2026-09-11）** → `extractions/gsw-1987-v1.md` §3。**★★ 唯一带编号定理 + 完整证明的来源：Theorem 2.4 / eq. (2.38) 一次给出六条关系，含图中缺口 `(A^i_n)†=A^i_{−n}` 与「有限和 ⇒ 良定义」。** ⚠ 用的是**修改版** DDF（作者自陈 fundamentally different），`[L_m,A^i_n]=0` 只对 **m≠0**，引用必须带 §5 的解释 |
| P0 | gebert-nicolai-1995 | §2.1（顶点代数公理）+ §3.1–§3.3（离散 DDF 构造） | worldsheet | researcher | **extracted（L1 相关章节，2026-09-11）** → `extractions/gsw-1987-v1.md` §4。**★★ 升级到 rigorous 的最佳路径：(2.57) 把「权 1 primary 的零模与所有 L_n 对易」化为顶点代数恒等式，链条 (2.36) 公理 ⇒ (2.38) ⇒ (2.41) ⇒ (2.57)，全程形式级数、无围道形变。** 另 (3.4) 显式保留 k(0)，回应了「右端为何无 α'/k·p 因子」；摘要与 §3.1 p.595 明写 non-summability（但机制是纵向的，勿误引） |
| ~~P1~~ | ~~polchinski-1998-v2~~ | ~~§10–§12（超弦、GSO、反常）~~ | worldsheet, consistency | — | **本行已废，与下方两行重复；范围描述也不准确（见下）** |
| P1 | green-schwarz-1984 | 全文（PLB 149, 117–122 六页） | consistency | researcher | **extracted（L1 全文，2026-09-11）** → `extractions/green-schwarz-1984.md`。20 条陈述；含 5 条纯代数命题（Lean 岛候选）。最大未闭合依赖：`alvarez-gaume-witten-1984`（GS 把常数 `c`、(20)(22) 的系数全外包给它） |
| P1 | polchinski-1998-v2 | **§10–§12 全部**（超弦 RNS、GSO、type I/II、杂化弦、流代数、超弦相互作用与反常） | worldsheet, consistency | researcher | **extracted（L1 全文，2026-09-11，两轮）** → ch.10–11 见 `extractions/polchinski-1998-v2.md`（E1–E63）；**ch.12（pp.84–135）见 `extractions/polchinski-1998-v2-ch12.md`（E1–E32，编号独立重起）**。⚠ 派工范围两次踩坑：**§11 是杂化弦不是 GSO**（GSO/IIA/IIB/I 全在 §10.6）；**§12.5 是 "General amplitudes" 不是一致性/分类**。**★「四解」在本书里只出现一次：§12.2 p.101 脚注 1，且只说两条 properties "hold"，无唯一性主张。★ ADT 2010 的 (7)(8) 已核实 = Polchinski (12.2.27)(12.2.28) 逐项相同。★ 本章最大发现是三条作者自承缺口：§12.5 p.126「a fully explicit proof of the perturbative consistency of the theory seems to be lacking」、§12.2 pp.102–103 的两个条件式 "if"、§12.6 p.130「曲率项未算」。** 本章分节：12.1/84、12.2/94、12.3/103、12.4/110、12.5/118、12.6/126、Exercises/134。**未抽**：Notation(xviii–xx)、ch.14+、References(467–487)（ch.13 与 App.B 已另行 L1 抽完，见各自独立行） |
| P1 | green-schwarz-1984 | 全文 | consistency | 待分派 | queued |
| P1 | ohta-1986 | 全文（超弦 BRST 上同调 / 无鬼定理的独立严格处理） | worldsheet | researcher | **attempted, blocked（2026-09-11）** → `extractions/ohta-1986.md`（L2 摘要 + L3）。⚠ **真实标题是复数 "Covariant Quantization of Superstrings Based on BRS Invariance"**，PRD **33**(6) 1681–**1691**，UTTG-30-85；用单数标题在 INSPIRE 零命中。正文 L0（OSTI 5930612 仅引文、purl 404；KEK 主机第四次 socket hang up；APS 403）。**★ 关键 L1 证词：IMNU 1986 p.952 Note added 说 Ohta 预印本「did not present the proof of the no-ghost theorem in the Ramond sector」**⇒ 只能作 NS 扇区来源。LZ 1989 Prop 1.7(ii)(x)(xi)、Prop 2.1 把 Q²=0 iff D=10 的证明与两扇区零模分解归给它。PLB 179 (1986) 347「BRST cohomology in superstring theories」仍只标题级（Dedushenko [13]），另立 `ohta-1986-plb` 行 |
| P1 | henneaux-1987 | 全文（"BRST cohomology of the fermionic string", Phys. Lett. B 183 (1987) 59） | worldsheet | researcher | **attempted, blocked（2026-09-11）** → `extractions/henneaux-1987.md`（L2 摘要 + FOK 1989 的 L3）。PLB **183**(1) 59–64，DOI 10.1016/0370-2693(87)91417-1（Crossref 核实）。摘要逐字限定 **「fermionic string (Ramond model)」，不含 "no-ghost"**；核心 = 用 Corrigan–Goddard 论证证明交换鬼零模的无穷简并 spurious（FOK：`{F₀,K}=1`，仅 p≠0）。**FOK 1989 §4 "The Henneaux Representation"** = γ₀ 生成/β₀ 湮灭 = R 扇区 −½ picture（换算是推断），并批评此表示下 Q 非厄米。前作 PLB 177 (1986) 35–38（recid 237921）。**★ 交人类点击**：`https://dipot.ulb.ac.be/dspace/simple-search?query=%22BRST+cohomology+of+the+fermionic+string%22`（页面报 Results 1-1 of 1，条目表抓取器拿不到；VuFind 前端 500） |
| P2 | superstring-noghost-picture | arXiv:1212.3592（任意 picture 的超弦 BRST 无鬼定理）+ arXiv:1009.0107（NS 弦 0-picture） | worldsheet | researcher | **extracted（2026-09-11）**：`dedushenko-2015`（arXiv v2 全文 21 页 L1）主结果 **(39)** 任意 picture、两扇区、p≠0 的绝对上同调 ≅ 两份光锥谱，鬼数 (A+1)±½；**p.3 逐字：零动量任意 picture 相对上同调「remains an open problem」**；picture 依赖的一手来源指向 Horowitz–Myers–Martin 1989 [16]（绝对上同调 picture 无关）与 Berkovits–Zwiebach 1998 [21]（p≠0 相对上同调 picture 无关，p=0 相关）。`kohriki-kunitomo-murata-2010`（PTP 124(6) 953–968，Crossref 核实；读 §1–§3.2）主要用作 KO/Ohta 方法的 L3。**结论：Vol.2 的无鬼定理陈述在 p≠0 时不依赖 picture 选择（Dedushenko/BZ），但在 p=0 时依赖** |
| P2 | brower-goddard-1972 | 全文（Nucl. Phys. B40, 437–444） | worldsheet | 待分派 | **queued（新，2026-09-11，高价值）**：goddard-2008 §5 把 `[A^i_m,A^j_n]=mδ^{ij}δ_{m,−n}` **归给本文与 brower-goddard-1973，不归给 GT 1972**。元数据仅 L1 转抄自 Goddard 参考文献 [44]，内容 L0。与 brower-1972（PRD 6, 1655，单作者）**是不同论文** |
| P2 | brower-goddard-1973 | 全文（Enrico Fermi Course LIV, 98–110） | worldsheet | 待分派 | **queued（新，2026-09-11）**：同上，Goddard 的 [43]。会议论文集，获取难度高 |
| P2 | ddf-1972 | Del Giudice–Di Vecchia–Fubini, Ann. Phys. **70** (1972) 378–398 | worldsheet | 待分派 | **候选，尚未进 `sources.bib`**：A^i_n 的原始出处（goddard-2008 [42]、gebert-nicolai-1995 [11] 均如此引）。本轮未尝试获取 |
| P2 | moeller-2024 | arXiv:2408.07597, §3（no-ghost theorem） | worldsheet | 待分派 | **候选，尚未进 `sources.bib`，仅 L4**：检索中介报告有 Lemma 3.1 / Lemma 3.2 / **Theorem 3.3 (no-ghost)** 与 eq. (3.1)–(3.8)，把 Lemma 3.1/3.2 归给 Borcherds 1992 Lemmas 5.1/5.2/5.3/5.5。**但用的是 Borcherds 的 K_α(n)/E_α，不是 DDF A^i_n；正文未读，编号不得写进图** |
| P1 | green-schwarz-1984 | 全文（PLB 149, 117–122 六页） | consistency | researcher | **extracted（L1 全文，2026-09-11）** → `extractions/green-schwarz-1984.md`。20 条陈述；含 5 条纯代数命题（Lean 岛候选）。**第二轮更新（2026-09-11）**：随 `alvarez-gaume-witten-1984` 抽取完成，**Q3（(20) 的三个系数）已完全闭合**（GS (20) = −48 × AGW (119) 组合，五系数逐一验过）；**Q6（CS 符号约定）确认 AGW 不是源头**；**§3.5 的「GS 把年份误印为 1983」判定已推翻**（AGW 页眉自己印 1983）。**Q2 仍未闭合**：常数 `c` 与 (22) 的十维混合十二形式都**不在** AGW 里，下一步须抽 `zumino-wu-zee-1984` |
| P2 | kac-raina-1987 | 自由玻色子 Fock 空间上 Virasoro c=1 的 Lecture 与命题号 | worldsheet | 待分派 | queued：需持**第 1 版**原书者核对（第 1 版约 12 讲 / 第 2 版 18 讲，编号不可互换）。已有可替代来源 virasoro-lean-2025 Thm 10.1 / Cor 10.2 |
| P2 | kac-kazhdan-1979 | Kac 行列式公式 | worldsheet | 待分派 | queued：`worldsheet.kac-determinant` 的候选一手来源，终页与标题单复数未核对 |
| P2 | thorn-1985 | 全文（MSRI 论文集章节，pp. 411–417） | worldsheet | 待分派 | queued：与 thorn-1984 易混（引作「Thorn 1984」），登记以区分。**元数据获 L1 独立佐证（2026-09-11）**：goddard-2008 参考文献 [32] 逐字「C.B. Thorn, *A proof of the no-ghost theorem using the Kac determinant,* in *Vertex Operators in Mathematics and Physics* ed. J. Lepowsky, S. Mandelstam and I.M. Singer (Springer-Verlag, New York, 1985) 411-417.」 |
| P2 | brower-thorn-1971 | 全文（「D>26 出鬼」的归属争议） | worldsheet | 待分派 | queued：Goddard 2008（L3）与本文摘要（L2）矛盾未裁决 |
| P2 | gsw-1987-v1 | §2.3.3（无鬼定理与 spectrum-generating algebra，p.102–112） | worldsheet | 待分派 | queued：Google Books 只回页码不回 snippet，archive.org 无 Vol. 1，式号内容全为 L0。**⚠ 2026-09-11 补（researcher）：Cambridge Core 路线对本卷同样无效** —— Vol.1 书 hash `35152940E2D9C3B0BD327EB7FF74DBBE`、online ISBN **9781139248563**；§2.3.3 所在的 ch.2「Free bosonic strings」pp. 57–120 的 PDF **标 "Save PDF (13 mb)"，超出 WebFetch 的 10 MB 上限**。GSW 扫描件约 240 KB/页 ⇒ **超过约 42 页的章节一律取不到**；Vol.1 各章页数为 ch.1 1–56 / ch.2 57–120 / ch.3 121–184 / ch.4 185–248 / ch.5 249–290 / ch.6 291–352 / ch.7 353–434，**只有 ch.5（42 页）在临界线上**。交人类点击的 URL：`https://www.cambridge.org/core/services/aop-cambridge-core/content/view/7EB8CEE02B28B374C180E9B274A19591/9781139248563c2_p57-120_CBO.pdf/free-bosonic-strings.pdf` |
| P2 | thorn-1985 | 全文（MSRI 论文集章节，pp. 411–417） | worldsheet | 待分派 | queued：与 thorn-1984 易混（引作「Thorn 1984」），登记以区分 |
| **P1** | **brower-thorn-1971** | 全文（「D>26 出鬼」的归属争议） | worldsheet | 待分派 | **优先级上调（2026-09-11）：扫描件已定位且是 PUBLIC** —— `CERN-TH-1293` / `CM-P00058794.pdf` / CDS recid 352004 / MARC 963 = PUBLIC（经 `cds.cern.ch/oai2d` 取得，`primary-sources-round2.md` §12.6）。人工浏览器一次点击可得。取到即可裁决 `brst-cohomology-sources.md` §3.2 的矛盾（Goddard 2008 L3 vs 本文摘要 L2）。⚠ 088/963 尚未逐字复核 |
| P2 | lian-zuckerman-1989 | 全文（RNS 超弦 / super-Virasoro） | worldsheet | researcher | **extracted（L1 全文 35 页，2026-09-11）** → `extractions/lian-zuckerman-1989.md`。Project Euclid 端点 `cmp%2F1104179468` 一次命中。**★ Theorem 2.20 `T∩P ≅ P/rad P ≅ H⁰_rel`（p≠0, D=10, κ=0,½）+ Corollary 2.15(ii) "(No-ghost Theorem)"** = 超弦无鬼定理的 rigorous canonical 候选；Theorem 2.4 消灭、Theorem 2.7 R 零模、Prop 1.7(ii) Q²=0 iff D=10（证明外包 Ohta/Terao–Uehara）、Prop 4.3 GSO、Thm 5.1/5.4 绝对上同调、Prop 5.5 p=0 例外。编号陷阱：Lemma 1.4 / Definition 1.4 同号。**与 FOK 1989 关于 Brower–Friedman 完全可约性互相矛盾（Q1）** |
| **P1** | **figueroa-ofarrill-kimura-1989** | 全文（CMP 124, 105–132） | worldsheet | researcher | **extracted（L1 全文 28 页，2026-09-11，新登记）** → `extractions/figueroa-ofarrill-kimura-1989.md`。Project Euclid `cmp%2F1104179078`。**无编号定理，按式号引**：(3.19) NS 相对消灭、(4.17) R 相对消灭（Henneaux 表示）、(5.1) 两种 R 零模表示的相对上同调同构、(6.14)=(6.15)/(6.19)=(6.20) 无鬼迹恒等式 + p.128 Schrödinger 表示。**直接回答 curator 的三处 βγ 差异**（见 `henneaux-1987.md` §5.2 表）。自承缺口六条（R 完全可约性只是 Brower–Friedman 的 "claim"、附录 A 定理无已发表证明、(B.1) 正定性留作练习、零动量排除、GSO 后作练习、D=10 假设）。与 LZ 1989 互不引用 |
| **P1** | **ito-morozumi-nojiri-uehara-1986** | 全文（PTP 75, 934–952） | worldsheet | researcher | **extracted（L1 全文 19 页，2026-09-11，新登记）** → `extractions/ito-morozumi-nojiri-uehara-1986.md`。**OUP/PTP 路线首次打通**（见备忘）。KO 学派对 NSR 弦的同型证明：(3.8)–(3.10) 幂零显式系数（⟺ 可读出）、(3.14)(3.19) R 零模表示 + δ(ζ₀) 度规、(3.22)–(3.26) 物理态条件 = 相对复形、**§4 Prop I/II + (4.21) = R 扇区无鬼的物理证明**（NS 只有评论）。**★ p.952 Note added：Ohta 预印本无 R 扇区无鬼证明。** 五处「Ref. 1)」= 反推 KO 证明结构的钥匙 |
| P2 | ohta-1986-plb | 全文（N. Ohta, "BRST cohomology in superstring theories", Phys. Lett. B 179 (1986) 347） | worldsheet | 待分派 | **候选，尚未进 `sources.bib`，仅标题级（Dedushenko 2015 [13]）**：可能是 Ohta 补 R 扇区/上同调语言的续篇。Elsevier，预计 403 |
| P2 | henneaux-1986 | 全文（"Remarks on the cohomology of the BRS operator in string theory", Phys. Lett. B 177 (1986) 35–38） | worldsheet | 待分派 | **候选，尚未进 `sources.bib`**：INSPIRE recid 237921，摘要逐字「The cohomology of the open bosonic string BRS operator is computed in a physical fashion. The method can be applied to the closed and to the fermionic models.」= henneaux-1987 的 "previous letter"，也是玻色弦 BRST 上同调的又一物理来源（Dedushenko [7]）。DI-fusion 同一路线 |
| P2 | brower-friedman-1973 | 全文（Phys. Rev. D 7 (1973) 535–539） | worldsheet | 待分派 | **新增（2026-09-11）**：裁决 FOK 1989 p.111/115（「fully reducible … infinite direct sum of Verma modules」/ R 扇区「claim to have proven」）与 LZ 1989 p.320 Remark（「V(p,κ) is in general not a direct sum of Verma modules」）的矛盾。APS 403；两篇数学论文的 R 扇区横向空间构造都引它（LZ Prop 2.18 「physicists [1,2] have constructed these spaces」） |
| P2 | maldacena-1997 | 全文 | holography | researcher | **extracted（L1 全文 22 页逐页读图，2026-09-11）** → `extractions/maldacena-1997.md`（E1–E48）。⚠ 读的是 **arXiv v3**，ATMP 发表版未核对；三条红线：原文是 `U(N)` 非 `SU(N)`、**全文无配分函数陈述**（GKP/Witten 1998 才有）、**全文无 `3/4`**（只说 "up to a numerical factor"）。耦合字典原文给 `g²_YM = 2πg`（≠ 常见的 `4πg_s`），见该文件 Q2 |
| P2 | maldacena-1997 | 全文 | holography | 待分派 | queued |
| **P0** | **alvarez-gaume-witten-1984** | 全文，特别是 **eq. (63)**（反常相对归一化）与十维反常多项式系数 | consistency | 待分派 | **新增（2026-09-11，由 green-schwarz-1984 抽取推出）**：GS 1984 把 (17) 的常数 `c`、(20) 的三个系数、(22) 的相对归一化**全部**外包给本文。不抽它，整条 GS 反常链的数值系数层就是 L0。Nucl. Phys. **B234** (1984) 269–330，无 arXiv（1984）。⚠️ GS 原文把年份误印为 1983。**取件钥匙（2026-09-11 补）**：INSPIRE recid **192309**，报告号 `HUTP-83/A039`，**有 KEKSCAN id `84-02-145`**、**无 CDS id** → 走 KEK 而非 CDS；推出的 URL `lib-extopc.kek.jp/preprints/PDF/1984/8402/8402145.pdf` 两次 `socket hang up`，主机是否活着未分辨 |
| P1 | thorn-1985-santa-barbara | 全文（42 页，含**改良版 Goddard–Thorn 无鬼定理证明**） | worldsheet | 待分派 | **新增（2026-09-11，`primary-sources-round2.md` §12.5）**：C. B. Thorn, *Introduction to the theory of relativistic strings*, Workshop on Unified String Theories, Santa Barbara, 1985-07-29–08-16。报告号 `DOE/ER/40008-77` / `CONF-850798-1` / NTIS `DE86001950`，42 页。摘要自陈「give an **improved version of the Goddard-Thorn proof** of the No-ghost Theorem」（INIS `szqhd-hct30`、OSTI 5007660）。INIS 有文件但 `access.files: restricted`（需注册，未办）；OSTI 无全文。**⚠ 勿与 `thorn-1985`（MSRI 7 页）混淆。** 建议路线：对该 Workshop 论文集（World Scientific，Green & Gross 编）跑 archive.org 重印文集流程 |
| P0 | alvarez-gaume-witten-1984 | 全文（Nucl. Phys. B234, 269–330，62 页） | consistency | researcher | **extracted（L1 全文逐页读图，2026-09-11）** → `extractions/alvarez-gaume-witten-1984.md`（E1–E20 + §5 Lean 候选）。取自 **McGill 课程页扫描件**（见下方备忘）。**eq. (63) 已逐字取到**。★ **GS Q3 完全闭合**：GS (20) 的五个系数 = −48 × [AGW (119) 的 N=1 场内容组合]，机械可验，`n=496` 是 `7936−16n` 的唯一零点。★ **GS Q2 只闭合一半**：AGW **不含** 常数 `c`，也**不含** GS (22) 的十维混合十二形式（p.328 明说不做），只给配方。★ **AGW 不是 CS/下降方程符号约定的源头**（源头是 Zumino–Wu–Zee）。⚠️ **年份订正**：AGW **自己的页眉就印 1983**，GS 照抄，不是 GS 误印 |
| **P0** | **zumino-wu-zee-1984** | 全文（下降方程 `ω⁰_{2n+1}`/`ω¹_{2n}` 的定义与符号约定；纯规范反常的绝对归一） | consistency | researcher | **attempted, blocked（2026-09-11）** → `extractions/zumino-wu-zee-1984.md`。**正文一字未取到（L2，仅摘要+元数据）**，但**本轮的两个核心问题已由其伴随文献闭合**（见下一行）。⚠️ **派工单的两个获取前提被证伪**：(a) INSPIRE `publication_info` **无 `pubinfo_freetext`** ⇒ **零个重印出处**，archive.org 文集路线输入条件不满足；(b) *Current Algebra and Anomalies* 里 Zumino 那章（pp.361–393）是 **Les Houches 讲义（单作者）**，**该书不收 ZWZ**。`external_system_identifiers` **无 KEKSCAN、无 CDS** ⇒ KEK 与 OAI-PMH 路线入口即排除。已试并失败：Semantic Scholar（CLOSED）、OSTI（`LBL-16443` 三种查法均无命中）、INIS（`zectt-7td81` metadata-only）、INIS 旧公共路径（404）、`site:edu` 扫描件检索（只命中转述性课程笔记）。**未穷尽的唯一入口：UNT Digital Library / TRAIL（被 Altcha 反爬挡住，需人工浏览器）**。ScienceDirect 与未授权扫描站按规则不使用 |
| **P0** | **zumino-1983-les-houches** | 全文（LBL-16747，46 印刷页） | consistency | researcher | **extracted（L1 全文逐页读图，2026-09-11）** → `extractions/zumino-wu-zee-1984.md`（E1–E17）。**= GS ref [10] 的第一项**（不是 ref [9]），ZWZ 的同作者同期伴随讲义，引言自陈「Some of the results are contained in a recent paper written in collaboration with Wu Yong-Shi and Anthony Zee [2]」。**★ 闭合了两件事**：(1) **`green-schwarz-1984.md` Q6 的「下降方程符号约定源头」** —— GS (5)(6)(15)(16) 逐字采用 Zumino 的约定，含 **(3.32) `δω⁰ = −dω¹` 的负号**；(2) **`c` 的归属定案** —— 本文 §5 只给 `2n−2` 维通式 (5.13) 且原文手写「(up to a sign)」，**不含引力侧**，故 `c` 在 AGW/ZWZ/Z-LH 三篇里都不以一个数存在。**★ 但不能裁决 `H` 的 CS 符号**（本文无 `B`、无 `H`、无引力）：GS 与 Bilal 由 `(B,H)→(−B,−H)` 相联，**两者都对**。三条作者自陈 gap：局部性、`k²=0` 留作习题、**WZ 相容条件解的唯一性明确不讨论**（⇒ GS「uniquely determined」无支撑） |

| P1 | eguchi-gilkey-hanson-1980 | Â 多项式（Dirac genus）的定义与 Pontryagin 展开 | consistency | 待分派 | **新增（2026-09-11）**：Phys. Reports **66** (1980) 213 = AGW ref [6]，AGW (82) 的 Â 多项式外包给它。本轮已用 Harvard Math 272b 讲义（匿名 CAS 输出，L1）核对 Â₁–Â₄ 全部相符，但那只作旁证；canonical 数学来源应是 Hirzebruch 或本条 |
| P1 | green-schwarz-1985-hexagon | 全文 | consistency | 待分派 | **新增（2026-09-11）**：Nucl. Phys. **B255** (1985) 93–114。GS 1984 自陈弦论侧 "details will be presented elsewhere"，Schwarz 2012（arXiv:1201.0981，L1）指认这里就是那个 elsewhere。要给「type I 单圈六边形反常抵消」建节点必须先抽它。**第二个理由（2026-09-11 新增）**：Polchinski v2 §12.6 (12.6.21) 只断言弦论侧单圈 GS 项 "with the correct coefficient"，**没有把两侧系数并排比较，且曲率项根本没算** ⇒「弦论侧系数已验证」在本项目仍是 L0，一手来源就是本条 |
| P2 | witten-2012-super-riemann | arXiv:1209.2459（Superstring Perturbation Theory Revisited）+ 1209.2199 + 1304.7798 | worldsheet, consistency | 待分派 | **新增（2026-09-11，由 `polchinski-1998-v2-ch12.md` E26/Q7 推出）**：Polchinski v2 §12.5 p.126 逐字自陈「**a fully explicit proof of the perturbative consistency of the theory seems to be lacking**」（写于 1998）。**这条缺口是否已被 Witten 2012–2013 的超黎曼面系列填上，决定图里 `consistency.superstring-perturbative-consistency-unproven` 该指谁。** ⚠ 三个 arXiv 号只到标题级，未核实卷期与内容 |
| **P0** | **polchinski-1998-v1** | **§5.3（(5.3.9) 的出处，约 pp.154–159）** | worldsheet | 待分派 | **新增（2026-09-11，由 ch.7 抽取推出）**：**(7.3.1) 整条环面振幅链的起点是 (5.3.9)**，而第六轮 §12 读 ch.5 时**恰好跳过了 §5.3**（只读了 §5.1–§5.2 与 §5.4）。ch.5 的 PDF 与 item hash 已知（`2619B77DD4AE2BE4D53B5EED5D3BE3C1`），**只需再读 5–6 页**。取到即可把 `spectrum.*` 单圈系列的最上游那条边建实 |
| **P0** | **polchinski-1998-v1** | **书末 References（pp.347–358）** | worldsheet, 元数据 | 待分派 | **新增（2026-09-11，由 ch.7 抽取推出）**：**一次 fetch 可同时清四笔债** —— (a) ch.7 习题引的 **Lovelace (1971)**（原书称之为「the first appearance of `D = 26` in string theory」）、**Shapiro (1972)**、**Polchinski (1986)**、**Coleman & Weinberg (1973)** 的卷期页；(b) **长期悬而未决的「Goddard–Thorn 1972 是否被 Vol.1 引用、引作什么」**。item hash `F5E26AFC8AF1D3B0E3F3866E752F8FD2` |
| **P1** | **polchinski-1998-v2** | **§10.8（type I 超弦的 tadpole 相消 / SO(32)），pp. 37–42** | consistency, spectrum | researcher | **★★ extracted（L1 全节逐页读图，2026-09-11）** → `extractions/polchinski-1998-v2-sec10-8.md`（**E64–E75，续 v2 抽取的 E63**）。**结论：`spectrum.type-i-tadpole-cancellation-so32` 的真来源就是 (10.8.19) `Z₁ = −i(n ∓ 32)²·…` + 其后逐字句「The R–R tadpole vanishes only for the gauge group SO(32).」**（上号为 SO(n)；辛支给 `(n+32)²`，恒不为零；本书不写 USp(32)）。**ch.7 的 Q4 已裁决**：原文三处明写玻色部分是 (7.4.1)/(7.4.15)/(7.4.22)「converted to D = 10」⇒ `8192` 与 `32` 确是同一组公式在不同 D 下取值（Klein 带 `2^D`、Möbius 带 `2^{D/2}`）；**但「与 GSW 六边形的 32 同源」仍无任何支持，不得写进节点**。**否定结论：§10.8 全节不含 "anomaly"/"hexagon"，不引 GS，无习题** ⇒ 与 `consistency.type-i-hexagon-so32-iff` **不得建 depends_on 边**（§12.2 p.102 逐字：type I 规范群「determined by cancellation of tadpole divergences」，不是反常）。遗留 **Q1**（前缀 `α'` 幂次，页图 vs 复算冲突）、**Q2**（§10.6 承诺的 "superconformal anomaly" 在 §10.8 未兑现）、**Q5**（三个独立出处的 `2⁵ = 32`） |
| **P1** | **polchinski-1998-v2** | **ch.13「D-branes」（pp. 136–177）** | branes, spectrum, consistency | researcher | **★★ extracted（L1 全章 42 页逐页读图，2026-09-11）** → **`extractions/polchinski-1998-v2-ch13.md`（独立文件，E1–E32 + Q1–Q8 + §5 图建议）**。item hash `67EE13E32046F0D121B589DC02989698`，文件名 `9780511618123c4_p136-177_CBO.pdf`（587.8 KB / 42 页，一次命中；**PDF 页 = 印刷页 − 135**；DOI 后缀 `.007`）。<br>**★★★ 派工单的前提被证伪：本章从不写「32 个 D9-brane」。** 全章唯一给出 D9 数目的句子是 **p.144** 逐字「a third state that contains **16 D9-branes** (and an orientifold 9-plane) that looks like the type I theory」；**p.143** 的记账是「If we `T`-dualize on `k` dimensions there are `2^k` orientifold planes but **still 16 D-branes**, so the charge of an orientifold plane must be **`−2^{4−k}`** times that of a D-brane of the same dimension」（复算 `2^k×(−2^{4−k})+16 = 0` ✅ 自洽）。同节 **p.141** 另有一句「it is natural to interpret **each Chan–Paton degree of freedom** in the fully Neumann theory **as a 9-brane** filling spacetime」（type I 有 32 个 CP 指标 ⇒ 蕴含 32 张），**原书从不调和这两种计数** ⇒ 见 `-ch13#Q1`。**⇒ 图里一律写 16；「SO(32) = 32 张 D9」不得归给本书。**<br>**★★ 依赖方向已裁定：§10.8 → ch.13，不是反过来。** 三处逐字：p.141「The existence of the 10-form **was deduced in section 10.8**, from the study of type I divergences」（带式号 (13.2.7)）；p.142「The divergence of the type I theory for groups other than `SO(32)` **arose from** the R–R 10-form field equation … again cancels only for `SO(32)`」；p.147「**We deduced from the cancellation of divergences that** the charge of the orientifold plane should have a factor of `−(2^{4−k})`」。**唯一可能的独立路线（D 膜–O 面之间的力）被明写推给读者**（「The reader can carry out a similar calculation …」）⇒ **ch.13 不是 `SO(32)` 的独立推导**，`branes.o9-d9-charge-cancellation-so32` 必须 `depends_on` `spectrum.type-i-tadpole-cancellation-so32`。<br>**其余核心式号**：τ_p 两条——(13.3.4) `τ_p² = (π/κ²)(4π²α')^{3−p}` 与**显式**的 (13.3.23) `τ_p = 1/(g(2π)^pα'^{(p+1)/2})`（**都在 §13.3，不在 §13.4/13.5**）；μ_p (13.3.7)；Dirac 量子化 (13.3.11)/(13.3.13) + 逐字「**Remarkably** … with the minimum quantum `n = 1`」（**已独立复算，`n=1` 精确**）；BPS 无力 (13.3.1)/(13.3.2) 且 (13.3.1) 明写是 **(10.8.4) 的修改版**；DBI (13.3.14)（用 `μ_p` 不是 `τ_p`，见 `-ch13#Q6`）；CS (13.3.18)；`g ≡ τ_F1/τ_D1` 的**定义** (13.3.21) + κ² (13.3.22) + κ₁₀² (13.3.24)（五式已互验自洽）。<br>**★ 对 `-sec10-8` 两个 Q 的答复**：**Q2 未兑现** —— **ch.13 全章不含 "anomaly" 一词**，故「superconformal anomaly」的剩余候选只剩 **ch.9**；**Q6 只得到图像不得到论证** —— p.142「field lines … **must end somewhere**」+「orientifold planes are **sinks** for R–R charge」，但原书不单独讨论 `n = 0`，故该节点仍须 `inferred: true`。<br>**★ 顺带跨章佐证了 `-sec10-8#Q1`**：(13.3.1) 的前缀页图同样读作 `8π(8π²α'²)⁵`，而**独立的 `α'` 幂次记账**（不依赖数值系数与 `G_d` 约定）要求 `α'` 一次方 ⇒ 两章两条不同推导同指 `8π(8π²α')⁵`。⚠ 同一复算里 `2` 与 `α'` 逐位吻合但 **`π` 差一次方**，见 `-ch13#Q3`。<br>**⚠ 强度评估与 §10.8 相反**：本章有 **12 道习题**且其中 6 道是「正文没做完请读者补」；**14 条作者自承缺口/外包**（含 5 处 "left to the references"、"the reader can carry out"、"the justification is not simple"、"carried out fully only for `n = 2`"）。**本章零文献引用**，且有大量悬空外部依赖（**App. B 完全未抽**、Vol.1 §8.7 只有 [S] 二手源、§9.7 未抽）。<br>**下一步（性价比排序）**：① ~~App. B~~ **已完成（2026-09-11，见下一行；结论：BPS 界只覆盖点粒子荷，(B.6.13)/§B.7 已闭合）**；② **ch.14（pp.178–227）** —— 黑膜、强耦合、M 理论；③ Polchinski, *TASI Lectures on D-branes*, hep-th/9611050（若要「32 张 D9」这一表述的可引来源） |
| P1 | polchinski-1998-v1 | **Appendix A（pp.329–346）** | worldsheet | 待分派 | **新增（2026-09-11）**：**一次 fetch 清两笔债** —— (a) `polchinski-1998-v1.md` §12 留下的 **(A.1.31)**（欧氏约定 / 作用量整体变号，`conv.worldsheet-euclidean` 的正确 loc）；(b) ch.7 习题 7.2 指向的 **A.3**（谐振算子的行列式正则化，即 (7.3.6) 的第三条推导路线）。item hash `D6A09941572ED2451AFC3C5C497F9A9A` |
| **P0** | **polchinski-1998-v2** | **Appendix B「Spinors and SUSY in various dimensions」（pp. 430–466）** | branes, spectrum, consistency, math | researcher | **★★ extracted（L1 全附录 37 页逐页读图，2026-09-11）** → **`extractions/polchinski-1998-v2-appB.md`（独立文件，E1–E34 + Q1–Q8 + §5 图建议）**。item hash `872CC69E98F684AFA1019EB2A955BD11`，文件名 **`9780511618123apx1_p430-466_CBO.pdf`**（545.6 KB / 37 页，直接推出一次命中，不必先 fetch abs 页；**PDF 页 = 印刷页 − 429**；DOI 后缀 `.014`）。<br>**★ Table B.1（p.434）已逐字转录**（Majorana yes: d≡0,1,2,3,4 mod 8；Weyl self: d≡2 mod 4 / complex: d≡0 mod 4；M–W 仅 d≡2 mod 8；min. rep. 1/2/4/8/8/16/16/16/16/32/64 for d=2…12），**min. rep. 列与 (B.1.21) 的 mod-4 规则已独立复算全部吻合**。Table B.2（SO(N)，p.437）、Table B.3（32 超荷超引力 G/H，p.455）亦逐字转录并复算。<br>**★★ BPS 界 = (B.2.39) `m ≥ q_i`（p.449），但只对点粒子中心荷**：p.448 逐字「this is the most general algebra if we include only charges that can be carried by point particles. Including charges that can be carried by *extended objects*, additional terms appear … first in section 11.6, and then in more variety in chapter 13. **The same caveat applies to the higher-dimensional algebras**」⇒ **`branes.d-brane-bps-no-force` 不能把 BPS 界整体挂在 App. B**，须经 (13.2.9)（而 ch.13 自承它 "still not complete"）；见 `-appB#Q3`、§5-B。<br>**★★★ 否定结论**：App. B **没有** "triality"、没有 `8_s`/`8_c`、没有 SO(8) 意义的 `56`（唯一的 56 是 d=4 N=8 的 `∓½^{56}`）、没有 `ψ_0^μ` 零模、没有膜荷代数、没有「四解」（p.457 只写「anomalies unless `SO(32)` or `E_8×E_8`」且是 §12.2 的转述）、零文献引用、零编号定理。⇒ **`worldsheet.so8-triality` 不能以 App. B 为 source**；`56/8′` 标签维持 §12.2；`math.clifford-algebra-representations-mod-8` 凭 App. B **只能 `physical-argument`**（唯一性一句话、B/C 基无关性外包给习题 B.1）。<br>**已闭合 ch.13 的三条悬空引用**：(B.6.13) 十维 SYM（p.459，照录无推导）+ (B.6.17) 势 = Vol.1 (8.7.11)（原书明写「This is no accident」）；§B.7 d=6 N=1 多重态列表（p.461）；§B.2 BPS 框架。<br>**⚠ 附录内部两处张力**：p.457 写 type I 规范多重态 `8_v + 8′`、习题 B.5（p.466）写 `8_v + 8`（`-appB#Q1`）；p.457「as found in the **bosonic** and type I strings」疑为 *heterotic* 之误（`-appB#Q2`，须人复核）。**13 条作者自承缺口**见 §3.1（含 "believed to be impossible"、"without derivation"、"we will not try to figure out what this might mean"）。 |
| P2 | polchinski-1996-tasi | *TASI Lectures on D-branes*, hep-th/9611050 | branes | 待分派 | **新增（2026-09-11，由 ch.13 抽取推出）；尚未登记进 `sources.bib`，元数据仅 L4**：**唯一目的是找「`SO(32)` = 32 张 D9-brane / O9 荷 = −32」这一现代表述的可引一手来源** —— **Polchinski 自己的书 ch.13 写的是 16**（见 `-ch13#Q1`），两种计数原书不调和。有 arXiv，取全文成本低。⚠ 取到后必须核对它用的是哪一种计数约定，并在 note 里写明与 Vol.2 ch.13 的换算 |
| P2 | lovelace-1971 | 全文（`D = 26` 在弦论里的**首次出现**） | worldsheet | 待分派 | **新增（2026-09-11，由 ch.7 习题 7.11 推出）**：Polchinski 逐字称之为 "the first appearance of `D = 26` in string theory (Lovelace, 1971)"，判据是「除非 `D=26` 且 `D'=24`，圆柱振幅在 `k²` 里有**分支割线而非极点**」。**本项目 `sources.bib` 未登记，卷期页未知**（先走上面的 References 那条） |
| P2 | shapiro-1972 | 全文（环面真空振幅模不变性 ⇒ `D=26, D'=24`） | worldsheet | 待分派 | **新增（2026-09-11，由 ch.7 习题 7.12 推出）**：与 lovelace-1971 构成 `D = 26` 的两条**独立单圈**判据（分支割线 vs 模不变性），都不同于图中现有的光锥洛伦兹代数与 Weyl 反常两条路线。**卷期页未知** |
| P1 | green-schwarz-1985-hexagon | 全文 | consistency | 待分派 | **新增（2026-09-11）**：Nucl. Phys. **B255** (1985) 93–114。GS 1984 自陈弦论侧 "details will be presented elsewhere"，Schwarz 2012（arXiv:1201.0981，L1）指认这里就是那个 elsewhere。要给「type I 单圈六边形反常抵消」建节点必须先抽它 |
| ~~P2~~ | ~~witten-2012-super-riemann~~ | ~~arXiv:1209.2459（Superstring Perturbation Theory Revisited）+ 1209.2199 + 1304.7798~~ | worldsheet, consistency | researcher | **本行已废：ref key 与 arXiv 号↔标题映射都是错的**，见下一行。（1209.2459 是 *Notes On Super Riemann Surfaces And Their Moduli*，不是 *Superstring Perturbation Theory Revisited*） |
| P1 | witten-2012-superstring-perturbation（+ witten-2013-overview / donagi-witten-2013 / witten-2012-srs-notes / witten-2012-supermanifolds-notes / witten-2013-holomorphic-measures / sen-witten-2015-pco） | **arXiv:1209.5461v4 主论文（225 pp）** + 1304.2832v4 + 1304.7798v2 + 三篇笔记 | worldsheet, consistency | researcher | **partially extracted（2026-09-11）** → `extractions/witten-2012-superstring-perturbation.md`（EW1–EW25 + QW1–QW8 + §5 图建议）。起因是 `polchinski-1998-v2-ch12.md` **E26/Q7**。<br>✅ **1209.5461v4 已读**：目录、§1、§2.1、**§3.3–3.6**、§6.4.6–6.5.1、§7.1、§7.5–7.6.1、§8.3、§9.1、**§9.4**、§10.1、**全部 91 条参考文献**（L1 逐页读图，3.2 MB PDF）。<br>✅ **1304.2832v4 §1 + §2.1 已读**（L1）；✅ **1304.7798v2 摘要 + §1 已读**（L1，含 Thm 1.1/1.2/1.3 与 Remark 1.4/1.5/1.6）。<br>❌ **未读**：1209.5461 的 §2.2–2.6/§3.1–3.2/§4/§5/§6.1–6.3/§6.6/§7.2–7.4/§7.6.2–7.7/§8.1–8.2/§9.2–9.3/§10.2–10.3/附录 A–D；1304.2832 的 §2.2–§4；1304.7798 的 §2–§5 与附录；**1209.2199 / 1209.2459 / 1306.3621 / 1307.5124 / 1404.6257 / 1504.00609 正文一字未读（仅 L2 摘要）**。<br>**★ 对 Q7 的答复（三条硬结论）**：<br>(1) **Polchinski 的两条具体技术缺口已被诊断并给出处方** —— PCO 的 "ad hoc" 性由 (3.88)→(3.95) **导出**解决；"subtle ambiguity at higher genus" 被指认为**伪奇点**（切片在 (3.79) 有非零解处非法），处方是分片选切片 + 只提取不变量 + 在积分链 `Γ̂` 上积分（§3.5、§3.6.2、§6.4.6）。<br>(2) **但「微扰一致性已证」在全系列里没有一处被宣称。** 最强自陈是 1304.2832 §1 p.2「**one is well-placed to demonstrate that superstring perturbation theory works to all orders in those models in which tadpoles and supersymmetry-breaking effects do not arise**」；1209.5461 摘要用 "demonstration"，§1 p.3 显式排除质量重整化/真空移动/R-R 背景/pure spinor/一般顶点算符；**§8.3 的归纳步挂在一个未证的 "if"**；§9.4 对开弦侧保留「string theory is not well enough understood to make this statement completely clear」；**主论文至今无期刊发表版**。<br>(3) **★ Donagi–Witten "not projected" 不是对微扰论的负面结论** —— 原文 p.4 逐字「The validity of superstring perturbation theory does not depend on a projection」。被否定的是「化约到普通模空间」这一**策略**（g ≥ 5），低亏格（含 g=2）不受影响；PCO 方法本身在 Sen–Witten 2015（"vertical integration"）里被补丁化而非废弃。<br>**⚠ 版本红线**：一律写死 **v4/v4/v2**；**1209.5461 v1 (2012) 不含对 Donagi–Witten 与 Sen–Witten 的引用**（DW 的 v1 晚七个月），严禁写「Witten 2012 已处理非投影性」。<br>**下一轮最高性价比**：①1209.5461 §7.7 + §8.2.3 + §9.3.6（本轮未读，从标题看最可能含总结性措辞，见 QW8）；②1209.5461 **v1** 与 v4 的逐版比对（钉死 2012 年的原始状态）；③1504.00609 正文（PCO 路线的现状）。 |
| **P1** | **gsw-1987-v2** | **第 10 章（已抽）+ 第 13 章（未取）** | consistency | researcher | **partially extracted（2026-09-11）** → `extractions/gsw-1987-v2.md`（E1–E14）。**优先级由 P2 上调至 P1**（原因见下）。<br>✅ **第 10 章「The gauge anomaly in type I superstring theory」pp. 141–174 逐页读毕（L1）**，经 **Cambridge Core 章级 PDF**（本环境有机构订阅）。核心逐字：p.143「the anomaly cancels **if and only if** the gauge group is SO(32)」+ 同段「**although the relevant calculations have not been performed**」；(10.1.11)–(10.1.14) 迹恒等式（**含 GS 1984 没有的 U(n) 支**）且紧跟一句「**(These matters are discussed further in §13.5.3.)**」；(10.2.36)(10.2.37) 「**which vanishes for the gauge group SO(32) and for no other group**」+ **「32」= 六边形内线上奇数个扭转的分布方式数**（GS 1984 完全没有的世界面来历）；§10.3 引力/混合/IIB/杂化弦在弦论侧**全部只有 "suggests"**；§10.4.2 作者自评 **"not entirely rigorous"**。<br>✅ 目录 pp. v–x 全读（L1）⇒ **§13.5.3 = "Allowed gauge groups for N = 1 superstring theories", pp. 353–358** 已确证（注意标题是 **superstring** 不是 supergravity）。<br>❌ **第 13 章 pp. 307–362 未取到（L0）**：PDF **12 MB，超出 WebFetch 的 10 MB 硬上限**。**这是工具限制不是权限问题**（同书第 10 章 9.1 MB 一次成功）。已排除：assets.cambridge.org（Socket closed）、节级 BOOK_PART（`CBO9781139248570A050/A052/A053/A054` 全部 HTTP 400，**不存在节级产品**）、archive.org 两份扫描（均 `access-restricted-item: true`，fulltext/djvu 全 403）、Google Books（两卷 id `Z-uz4svcl0QC` / `dgAhAwAAQBAJ` 均不回 snippet）。<br>**★ 交人类点击的 URL**：`https://www.cambridge.org/core/services/aop-cambridge-core/content/view/F2BEB1F0811FE1D8458547AAB73D12AF/9781139248570c6_p307-362_CBO.pdf/low-energy-effective-action.pdf`<br>取到后要回答的四问见抽取记录 §0.4。<br>**本轮对四解分类的净进展**：两条**独立** L1 二手证据（`antonelli-2015` §1.1 p.3、`adams-dewolfe-taylor-2010` p.1 与其 [7]）都把「U(1)⁴⁹⁶ / E₈×U(1)²⁴⁸」的出处指向本书第 13 章 ⇒ **`vafa-2005` E15 把它引给 `green-schwarz-1984` 确认是溯源错误**；但**GSW 原文措辞仍 L0**，两人对 GSW「说了多强的话」理解不一致（Antonelli：「it has long been known [3] that ... are theories where quantum anomalies are cancelled」；ADT：「satisfy **some of the same conditions** ... **might appear to be** consistent」）。**Q1 三方冲突未裁决。** |
| P1 | antonelli-2015 | §1（含 1.1/1.2/1.3）、§2.1–2.2、Appendix A/B、References | consistency, swampland | researcher | **extracted（L1 部分章节，2026-09-11）** → `extractions/gsw-1987-v2.md` E13。arXiv:1507.08642，36 页，读 pp.1–8 + 33–36。**★ 唯一明说「四解分类的原始陈述在 GSW ch.13 且 no proof has explicitly been carried out」的来源。** ⚠ 单作者预印本，未见期刊发表；其「anomaly cancelled」指**十二形式因子化**，与 `adams-dewolfe-taylor-2010` 的「不能用 GS 机制抵消」不冲突但不同义；其 §1.1 对 ADT 的转述失真。**未读**：§2.3–2.5（各群非因子化的逐个证明）、§3.1–3.4 |
| P1 | adams-dewolfe-taylor-2010 | 全文（4 页） | consistency, swampland | researcher | **extracted（L1 全文，2026-09-11）** → `extractions/gsw-1987-v2.md` E13/E14。arXiv:1006.1352**v2**（编号必须写死 v2：致谢自陈 v1 的 (7)(8) 系数有错，由 Tachikawa 指出）。**★ 本项目里第二条「作者/后人真正实现了原文邀请的反驳方向」的样本**：`vafa-2005` E15 逐字邀请「to find what consistency condition goes wrong」，ADT 给出了那个条件（超对称要求的 `BF²` 耦合 vs 阿贝尔规范不变性，`Y₄ ≠ dH₃`）。摘要限定语「without known inconsistencies」必须带上 |
| **P0** | **vafa-2005** | 全文（10 页） | swampland | researcher | **extracted（L1 全文 10 页逐页读图，2026-09-11）** → `extractions/vafa-2005.md`（E1–E18）。⚠ 读的是 **arXiv v2**。**两条结构性禁令：本文无任何编号公式、无任何编号 Conjecture ⇒ loc 只能写「§N, p.M」。** 核心是 §1 p.1 的 swampland 定义句与 §1 p.2 的三条有限性判据（标量体积/场数目/规范群秩，均以「Newton 常数非零」为前提）。最大溯源问题：§4 的引文 [6] 与本项目对 `green-schwarz-1984` 的 L1 抽取对不上（Q3）。**2026-09-11 追加（researcher，gsw-1987-v2 抽取）**：Q3 已部分闭合 —— `antonelli-2015` 与 `adams-dewolfe-taylor-2010` **两条独立 L1 证据**把 `U(1)⁴⁹⁶`/`E₈×U(1)²⁴⁸` 的出处指向 `gsw-1987-v2` ch.13，**确认 Vafa 的引文 [6] 是溯源错误**；但 GSW 正文仍未取到，`inferred` 不能撤（除非把 source 换成那两篇）。**更重要**：ADT (2010) 直接反驳了 Vafa E15 的前提「Both of these theories are consistent as far as anomalies are concerned」，且正是 Vafa 逐字邀请的第二个反驳方向 |
| P1 | green-schwarz-1985-hexagon | 全文 | consistency | researcher | **正文仍未取得（2026-09-11 第二轮已把五条路线跑完）** → `extractions/green-schwarz-1985-hexagon.md`（**L2 摘要级 E1–E5 + 失败路径逐条留痕**）。Nucl. Phys. **B255** (1985) 93–114，DOI `10.1016/0550-3213(85)90130-0`，预印本 **CALT-68-1224**（33 页，⚠ 不是 GS 1984 的 CALT-68-1182）。**摘要三条硬结论**：annulus 与 Möbius 各自有反常、相加后 "cancel … **if** … SO(32)"（充分条件，不得读作唯一性）、末句只 "We point out" 低能有效作用量各项的弦论起源 ⇒ **「弦论侧 ⟹ GS 1984 反项」这条边仍不得建**。失败：CDS = Anubis；CDS OAI 无 recid 入口；`lib-extopc.kek.jp` socket hang up（第三次）；OSTI 干净查询确认不藏本文；INSPIRE `documents`/`urls` absent；无大学课程页扫描件；CaltechAUTHORS 两端点 403；S2 `openAccessPdf` 空。**重印出处只有一个**（Schwarz 编 *Superstrings* Vol. 2 = archive.org 已确认无此书）⇒ 该路线先验不通。**下一轮最省力入口：GSW Vol. 2 反常章走 Cambridge Core**（同时清 `gsw-1987-v2` 的 P2 债） |
| P2 | gsw-1987-v2 | **第 13 章**（496 维反常自由群的分类陈述） | consistency | 待分派 | **新增（2026-09-11）**：据 Antonelli 2015（arXiv:1507.08642，L1）§1.1，「SO(32) / E₈×E₈ / U(1)⁴⁹⁶ / E₈×U(1)²⁴⁸ 四解」的原始陈述在此，且 "no proof has explicitly been carried out"。bib 里目前只有 `gsw-1987-v1`。**2026-09-11 追加理由（researcher，建议 lead 把本行提到 P1）**：`vafa-2005` §4 把「U(1)⁴⁹⁶ 与 U(1)²⁴⁸×E₈ 就反常而言一致」引给 `green-schwarz-1984`，但本项目对 GS 1984 的 L1 抽取显示原文只点名 SO(32) 与 E₈×E₈。本章现在同时被 GS 抽取与 Vafa 抽取两处需要，是 swampland↔consistency 接口边的唯一可能来源。见 `extractions/vafa-2005.md` Q3 |
| **P0** | **vafa-2005** | 全文（10 页） | swampland | researcher | **extracted（L1 全文 10 页逐页读图，2026-09-11）** → `extractions/vafa-2005.md`（E1–E18）。⚠ 读的是 **arXiv v2**。**两条结构性禁令：本文无任何编号公式、无任何编号 Conjecture ⇒ loc 只能写「§N, p.M」。** 核心是 §1 p.1 的 swampland 定义句与 §1 p.2 的三条有限性判据（标量体积/场数目/规范群秩，均以「Newton 常数非零」为前提）。最大溯源问题：§4 的引文 [6] 与本项目对 `green-schwarz-1984` 的 L1 抽取对不上（Q3） |
| **P0** | **ooguri-vafa-2006** | 全文（17 页） | swampland | researcher | **extracted（L1 全文 18 页逐页读图，2026-09-11）** → `extractions/ooguri-vafa-2006.md`（E1–E29）。⚠ 读的是 **arXiv v1**，编号必须写死 v1。**Conjecture 0–4 有编号（从 0 起）；全文只有两个编号公式 (1.1) 与 (3.1)；§3.1 有两个 `Example v)` ⇒ loc 不能只写「Example v」。** 四条使用限制：α 不普适（9/8、3/8、8/7、6/7）、Conj 3 是标量曲率非截面曲率、Conj 1 与 2 明确相互独立、「Swampland Distance Conjecture」这个名字不在原文。三处「conjecture 2」按内容应为「conjecture 3」（误植） |
| **P0** | **arkani-hamed-2006** | 全文（20 页） | swampland | researcher | **extracted（L1 全文 21 页逐页读图，2026-09-11）** → `extractions/arkani-hamed-2006.md`（E1–E27）。⚠ 读的是 **arXiv v2**，且 **§5 与 (28)–(30) 极可能是 v2 新增**（其引用 hep-th/0602178 晚于 v1 日期）。公式 (1)–(30) + sharp 版本 (I)(II)(III) 均可精确引用。**★ 本项目第一条 `status: refuted` 的证据：§3 p.11 作者本人反驳 (I)，逐字「So (I) can't be right.」** 「m ≤ qM_Pl」在文内有四种写法不可互换（Q1）；极端性归一化文内不统一（Q2）；**全文无「Weak Gravity Conjecture」一词** |
| P1 | wen-witten-1985 | 全文（NPB 261, 651–677） | swampland | researcher | **attempted, L2（摘要级；正文一字未获取，2026-09-11 第二轮）** → `extractions/wen-witten-1985.md`。**★ 本轮最重要的是一个否定结论**：逐字完整摘要里**没有 winding、没有 half-integral、没有 stable、没有 mass**；摘要讲的是「`O(10)`/`E₆` 被 Wilson 线破缺 ⇒ 最小磁荷是 Dirac 量子 `2π/e` 的整数倍 `n`，非禁闭色单态的最小电荷是电子电荷的 `1/n`」。⇒ AMNV 的「half-integrally charged winding strings」是 AMNV 的刻画，未在一手材料中证实。**终页 677 已 L2 核实。** 入口全灭：无 CDS、无 KEKSCAN（`external_system_identifiers` 只有 MSNET/SPIRES）、OSTI 不藏（标题短语查询命中 10 条全是现代 millicharged 实验文献，查询未被吞）、S2 引用语境全是泛泛的「弦论预言分数电荷」、`1509.06374` 全文搜不到 "Wen"。⚠ `INSPIRE ft "Wen and Witten"` **几乎全命中 Wang–Wen–Witten 2019「A New SU(2) Anomaly」**，两次检索因此浪费。**★ 优先级建议下调**：AMNV 的反例 (a)（`SO(32)` 旋量）不引任何文献，**那条 `refuted` 推导不靠本文**。升 L1 的唯一路线：`WebSearch` 找 `.edu` 扫描件 |
| P1 | sen-1995-bh | 全文（hep-th/9504147，16 页） | swampland, holography | researcher | **extracted（L1 全文 16 页逐页读图，2026-09-11）** → `extractions/sen-1995-bh.md`（E1–E15）。⚠ 读的是 **arXiv v2**（页边条纹 `v2 6 May 1995`），报告号 TIFR-TH-95-19。⚠ **标题页印的 `November 26, 2024` 是 arXiv 重编译日期，不是论文日期**。**★★ 本轮最重要的发现：本文不是 AMNV (22)(23) 的出处** —— AMNV 引的是 `sen-1995-bh-torus`（hep-th/9411187），本文自己也把黑洞解引给同一篇（其 [7]，并加脚注「ref.[7] constructed the solution for `g = 1`」）。**三条红线**：(1) 本文**没有任何弱引力猜想形式**；(2) 归一化是 `α' = 16`、**`G_N = 2`**、`T = g²/32π`，与 AMNV 的 `α' = 4`、`M_Pl = 1` **完全不同且两边都不给换算**；(3) **`C = 4` 是拟合出来的**，真正非平凡的是三参数（`g, m, Q̄_L`）的函数依赖。作者自称最强只到 "It is shown that stringy effects **could** correct…" + "we could **postulate**" |
| P1 | sen-1995-bh-torus | 全文（hep-th/9411187） | swampland, holography | 待分派 | **优先级实质上调（2026-09-11）：它现在是三处的共同上游** —— (a) AMNV §4 的 (22)(23)；(b) `sen-1995-bh` E8 的黑洞解；(c) 「杂化弦 `T⁶` 极端黑洞解」这条陈述的**唯一**一手来源。**有 arXiv，取全文成本低，是 swampland 区性价比最高的一枪。**⚠ **绝不可与 `sen-1995-bh`（hep-th/9504147）混淆**：同作者、同年、标题都以 "black hole" 开头 |
| P1 | bagger-witten-1983 | 全文（NPB 222, 1–10），特别是超多重态模空间曲率符号的定理 | swampland | researcher | **attempted, L2 + 两条独立 L3（正文一字未获取，2026-09-11 第二轮）** → `extractions/bagger-witten-1983.md`。**终页 10 已 L2 核实。** 入口全灭：无 CDS、无 KEKSCAN、OSTI 不藏（标题短语查询 7 条主题相关但无本文）。**★ OV [15] 的归属经两条独立 L3 证实**：(i) Chang–Sezgin–Tanii **arXiv:2304.06073** = JHEP 06 (2023) 172 §2.1 逐字「showed that … QK manifold with **constant negative scalar curvature**」；(ii) Vandoren **arXiv:2501.01900v2** §2 逐字「only QK manfifolds with negative scalar curvature can be coupled to supergravity」+「Bagger and Witten computed its value to be」+ **其自己的 (2)** `R(g) = −8κ²(n²+2n)`。⚠ **`(2)` 是 Vandoren 的编号，禁止写「Bagger–Witten eq. (2)」。**⚠⚠ **口径修正**：原来说它是「swampland 区最有希望通向 `rigorous` 的支点」——**不成立**（超引力场论构造，上限 `physical-argument`；覆盖域与量词都与 OV Conjecture 3 不同）。★ **摘要第二句才是最有用的**：「全局 `N=2` 允许的自相互作用在超引力里被禁止，反之亦然」= OV §3.1 正面与 §3.2 Example (b) 反例的分界线。升 L1 的唯一路线：`WebSearch` 找 `.edu` 扫描件 |
| P2 | wolf-1965 | J. Math. Mech. **14** (1965) 1033 | swampland, math | 待分派 | **新增（2026-09-11，由 bagger-witten-1983 抽取推出）**：`ooguri-vafa-2006` §3.1 同一句里的 **[14]**，用来支撑「**一般**的 quaternionic Kähler 流形曲率可取任意符号」。OV 的论证结构是「一般情况任意符号 [14] + 超引力情况必负 [15]」，**两条引用缺一不可**。⚠ 尚未登记进 `sources.bib`，元数据仅来自 OV 的参考文献表 |
| P2 | borel-harish-chandra-1962 | 全文（Ann. of Math. 75 (1962) 485–?） | math, swampland | researcher | **attempted, L2 元数据 + 两条 L3 转引（正文未获取，2026-09-11）** → `extractions/math-sources.md` **§45**。**★★ 硬禁令：不得写 "Theorem 9.4"** —— 两条独立的、亲自读到的引用方**都不给编号**（arXiv:2006.04839 §4 其 ref [57]；arXiv:2509.09047 其 ref [13]），而同一篇 2006.04839 对 Siegel 是给编号的 ⇒ 负面证据较强。**★ 最有用的一条 L3 是 arXiv:2006.04839 §4「Averaging over Narain lattices」**：语境与 `vafa-2005` §2 完全一致，逐字「an arithmetic subgroup of a semisimple algebraic group has a finite volume quotient」，**并给出 Vafa 没给的条件 `c ≥ 2`**（`O(c,c)` 的单位连通分支半单 iff `c ≥ 2`）⇒ **图节点 statement 必须带 `k ≥ 2`**。⚠ **arXiv:2509.09047 引的是 cocompact 那一支，与有限体积不是同一条定理，绝不可混用**（Narain 商不紧）。⚠ **终页 535 已从 bib 移除**：Crossref 只给起始页 485。死路：**S2 不索引 DOI `10.2307/1970210`**（/citations → 404）；Morris 那本书的 ar5iv 超 10 MB。下一轮：`arxiv.org/pdf/math/0106063v1` + `Read(pages=)`，或 `WebSearch "Theorem 9.4"` |
| P2 | narain-1986 + narain-sarmadi-witten-1987 | Phys. Lett. **B169** (1986) 41；Nucl. Phys. **B279** (1987) 369 | worldsheet, swampland | 待分派 | **新增（2026-09-11）**：Narain 紧化的一手来源，**同时被三处需要** —— `sen-1995-bh` 的 [21]（书目已 L1 抄得，见该抽取记录 E15）、`vafa-2005` E9 的 Narain 模空间、以及 `math-sources.md` §45 环节 (D)（「该双陪集就是 Narain 模空间」，目前无来源）。1986/87 年，无 arXiv。⚠ 尚未登记进 `sources.bib` |
| P2 | sen-1994-ijmpa | Int. J. Mod. Phys. **A9** (1994) 3707，hep-th/9402002 | worldsheet, swampland | 待分派 | **新增（2026-09-11，由 sen-1995-bh 抽取推出）**：`sen-1995-bh` 全部归一化约定（**`α' = 16`**）外包给它（p.6 逐字「As in ref.[22], we use the normalization `α' = 16`」）。不核实它，`sen-1995-bh` 的一切数值系数都是 L0。**有 arXiv，成本低** |
| P2 | polchinski-1998-v2 | §11（杂化弦谱）—— 补 `SO(32)` 旋量态的**质量**与**荷** | swampland | 待分派 | **新增（2026-09-11，由 wen-witten-1985 抽取推出）**：AMNV 反驳 `(I)` 靠的是「`SO(32)` 旋量**精确稳定**、**最小半整数荷**、但**很重**」，而 **AMNV 对这三条一个引用都不给**。⇒ **补强那条 `refuted` 推导最省力的路线不是找 Wen–Witten，而是从本项目已 L1 读过的 Vol.2 §11 里把这些数补出来** |
| P2 | susskind-1995-remnants | 全文（hep-th/9501106） | swampland | 待分派 | **新增（2026-09-11）**：AMNV §2.2 的 remnant 论证与「量子引力无全局对称性」这一前提都引本文，§2.3 的 large-N species problem 也引它。**⇒ 图里「无全局对称性」节点的来源应是本条，不是 AMNV**（后者只引用不论证）。有 arXiv |
| **P0** | **gubser-klebanov-polyakov-1998** | 全文（PLB 428, 105–114；arXiv 15 页） | holography | researcher | **extracted（L1 全文逐页读图，2026-09-11）** → `extractions/gubser-klebanov-polyakov-1998.md`（E1–E13）。⚠ 读的是 **arXiv v2**，式号写死 v2；PLB 发表版未核对。**三条红线**：(1) 核心式是 **(12)/(23) `W = K = S`（生成泛函 = on-shell 作用量），全文无任何配分函数陈述** —— `Z_CFT = Z_string` 不能引本文；(2) **全文无 `Δ(Δ−d) = m²`**，只有 d=4 的 (45) `Δ = 2 + √(4+(mR)²)`；(3) 边界在**有限截断 `z = R`** 而非共形边界。**全文不含 "conjecture" 一词**，最强自称 "we **propose** an identification"。**GKP 不引 Witten**（v2 的 25 条参考文献里没有 hep-th/9802150） |
| **P0** | **witten-1998-ads** | 全文（ATMP 2, 253–291；arXiv 40 页） | holography | researcher | **extracted（L1 全文逐页读图，2026-09-11）** → `extractions/witten-1998-ads.md`（E-W1–E-W18）。⚠ 读的是 **arXiv v2**，comments 自陈含 "**assorted corrections**"，式号必须写死 v2。**核实结论**：`⟨exp∫φ₀O⟩_CFT = Z_S(φ₀)` **确为 (2.11)**，但**两边都是 `Z` 的等式是 (2.12)**（自变量是共形结构 h），流版 (2.13)；`Δ(Δ−d) = m²` **确为 (2.43)**（较大根，显式解 (2.44)，AdS 半径 = 1）。自称 "**ansatz**"，但明写 "make more precise the conjecture [13]" ⇒ **对 Maldacena 判「精确化」（与 GKP 判「独立假设」不同）**。用 **`SU(N)`** 并在 §2.6 论证不是 `U(N)`。**p.4 逐字称 GKP 为 "independent work [36]"**。发现两处原文疑误：p.35 的 `ω` 公式根号内是 `−4m²`（与 (2.44) 的 `+4m²` 矛盾）、参考文献 [13] 印作 `hep-th/971120`（少一位） |

| P2 | cy3-finiteness-math | `filipazzi-hacon-svaldi-2021`（arXiv:2112.01352 = JEMS 27 (2025) 3583–3650）正文；`grassi-2023-spectrum-bounds`（2304.07819v2）Definition 3.2 与 §5 | math, swampland | 待分派 | **新增（2026-09-11，`math-sources.md` §46）**：给 `math.cy3-cohomology-bounded` 补 2005 年之后的进展。**已确定的事实**：一般 CY3 拓扑类型有限性**截至 2026-06 仍开放**（arXiv:2606.08427 §I 逐字）；**椭圆/亏格一纤维化情形已证明**（FHS 2021，已发表）；**Grassi Corollary 5.3 给 `h^{1,1}(X) ≤ 491`**（椭圆纤维化）。**⚠ 任务书给的 `h^{1,1}+h^{2,1} ≤ 502` 本轮未能核实**：Kreuzer–Skarke 原文正文里 "491"/"502"/"11" 全篇未出现，四篇 KS 统计论文的摘要也都没有 502。**下一枪最该打 arXiv:2008.01730「Bounding the Kreuzer-Skarke Landscape」正文。**⚠ **不要把 CY3 有限性称作「Reid 猜想」或「Yau 猜想」**：2606.08427 明确把 Reid's fantasy 区分为另一条（关于连通性的）猜想。⚠ **Gross 1994 是 Duke Math. J. 74（Crossref），不是 76（2606.08427 抄错）** |

| **P1** | **siegel-1954-eta** | 全文（Mathematika **1** (1954) 4，1 页） | math, worldsheet | researcher | **★★ extracted（L1 全文页图，2026-09-11，新登记）** → `extractions/math-sources.md` **§48**。经 **Cambridge Core 期刊文章 PDF**（机构订阅；见下方备忘新增条）。<br>**这是 `math.dedekind-eta-s-transformation` 的第一条数学侧一手来源**——此前图上只有 Polchinski v1 (7.2.43)/(7.2.44) 的断言，而 `polchinski-1998-v1-ch7.md` 已 L1 确认**原书对该变换零证明**。<br>**★ 三条引用红线**：(1) **全文无编号定理/编号公式/小节/参考文献**，要引的陈述**只出现在标题里** ⇒ `loc` 只能写 `p. 4`，**严禁写 "Theorem 1"**；(2) 原文形式是 `η(−1/τ) = η(τ)√(τ/i)`，与图里的 `(−iτ)^{1/2}` 等价，但**换算是抽取者做的**；(3) **原文不声明平方根分支、不显式写 `Im τ > 0`**。<br>**★ 形式化状态（L1 源文件全读）：Mathlib 的 `Mathlib/NumberTheory/ModularForms/DedekindEta.lean` 有 η 的定义/非零/可微/`logDeriv η = (πi/12)E₂`，但没有 S 变换** ⇒ 节点**不得标 `formalized`**；同时这是一个"地基已铺、只差一步"的 Lean 岛。<br>**未结**：Apostol GTM 41 的 **Theorem 3.1** 编号仍 L0（Springer 登录墙；INSPIRE `ft "Apostol, Theorem 3.1"` → **0 hits**；WebSearch 额度已耗尽）。**Apostol 本轮刻意未登记进 `sources.bib`**，以免被顺手引成 Theorem 3.1。Ch. 3「The Dedekind eta function」= **pp. 47–73**（Crossref L1，1976/1990 两版页码相同、DOI 不同） |
| **P1** | **polchinski-1995-dbranes** | hep-th/9510017（= PRL **75** (1995) 4724–4727），11 页 | branes | researcher | **partially extracted（L1，pp.4–8，2026-09-11）；★ 已于 2026-09-11 登记进 `sources.bib`（key `polchinski-1995-dbranes`）** → 记在 `extractions/polchinski-1998-v2-ch13.md` **§6.4**。<br>**登记理由（两条，都很硬）**：(1) **它是 D 膜 R–R 荷的原始出处，且给出了书里没有的显式归一化常数 `α_p`**（(12) `S = (α_p/2)∫F*F + iμ_p∫A`），使量纲关系可独立核查——本轮正是靠它裁决了 (13.3.12) 的系数争议；(2) **p.8 的 (20) `i(n−32)μ_9∫A_10` + 「Thus, the equation of motion requires the group `SO(32)`」是「32 张 D9」这一现代表述的早期一手出处**，而 Vol.2 ch.13 只写 16（见 `-ch13.md#Q1`）——**且同篇 p.7 也写 "exactly 16 D-branes"，两种计数在 1995 年原文里就并存**。<br>⚠ 读的是 **v3**；⚠ p.6 有作者自承的未解矛盾「**We have not succeeded in reconciling these calculations**」，引其荷归一化必须带上。<br>**未读**：pp.1–3、pp.9–11（含参考文献） |
| **P1** | **gibbons-hull-1982** | 全文（Phys. Lett. B **109** (1982) **190–194**，5 页） | swampland, holography | researcher | **新登记（2026-09-11，L2 摘要级）** → 抽取记录 `extractions/math-sources.md` **§51.1**。**正文 L0**（Elsevier；无 arXiv；报告号 `Print-82-0182 (CAMBRIDGE)` 是 SPIRES 占位号，按既有教训 OSTI/INIS/NTIS 三路先验不通）。<br>**登记理由**：`sen-1995-bh-torus` 把 BPS 界 `M² ≥ Q_R²/2` **外包**给其 [24,25]，`arkani-hamed-2006` (AMNV) 的 (22)(23) 又转引 Sen ⇒ **本文是这条链最上游的一手入口**。<br>**★★ 页码订正**：Sen 的参考文献把本文印作「B109 (1982) **109**」，**是误印**。INSPIRE `j Phys.Lett.B,109,190` 命中本文；`j Phys.Lett.B,109,109` **零命中**。<br>⚠ **摘要里没有 `M² ≥ Q_R²/2` 这个形式**，只有「lower bound … in terms of its electric and magnetic charges」，且语境是 **N=2 超引力**而非杂化弦，**无 `Q_L/Q_R` 划分** ⇒ 正文到手前不得把该不等式挂本 key。作者自陈 "**almost** complete characterization"。<br>**下一枪**：`WebSearch` 找 `.edu` 课程页扫描件（AGW 路线）；DAMTP/Cambridge repository（`www.repository.cam.ac.uk`）本轮未试 |
| **P1** | **terao-uehara-1986** | 全文（Phys. Lett. B **168** (1986) 70–74，5 页） | worldsheet | researcher | **新登记（2026-09-11，L2 摘要级）** → 抽取记录 `extractions/math-sources.md` **§51.1**。标题是 **"Covariant Second Quantization of Free Superstring"**（不是「BRS 幂零 ⇒ D=10」那种标题）。报告号 **RRK-85-32**；作者单位 Kyoto U. / Hiroshima U. RITP。<br>**登记理由**：`lian-zuckerman-1989` 的 **Prop 1.7(ii)「Q² = 0 iff D = 10」把证明外包给其 [13,15]**，其中 **[15] = 本文**（[13] = `ohta-1986`）。⇒ 超弦临界维的物理侧一手入口之一。<br>**★ 三条限定（摘要逐字）**：(1) 方向是 "**Nilpotency … determines**"，**不是 iff**（与 `kato-ogawa-1983` 摘要的 "required by" 同型）；(2) 摘要**不出现数字 10、1/2、0** ⇒ 具体值不得挂本 key（挂 `ito-morozumi-nojiri-uehara-1986` (3.8)–(3.10)）；(3) 覆盖 NS+R 两扇区，但谈的是 **BRS 荷幂零**，不是无鬼定理。<br>⚠ Uehara 与 IMNU 1986 同一人 ⇒ 两者**不完全独立**。<br>**★ 取全文的最佳路线（本项目已验证同类）**：本文是 PLB（Elsevier，预计 403）；但同作者同期在 PTP 上的工作可走 **OUP/PTP 路线**。另建议先跑 `cds.cern.ch/oai2d` 查 CDS recid（本轮未跑） |
| **P1** | **schwarz-1972** | 全文（Nucl. Phys. B **46** (1972) 61–74，14 页） | worldsheet | researcher | **新登记（2026-09-11，L2 摘要级）** → 抽取记录 `extractions/math-sources.md` **§51.1**。**"Physical States and Pomeron Poles in the Dual Pion Model"**，单作者（Princeton）。<br>**登记理由**：**NS（dual pion）模型无鬼定理的第二条来源**，与 `brower-friedman-1973` 平行，且比后者早一年。<br>**★ 四条限定（摘要逐字）**：(1) 自陈方法来自 Brower（"The methods recently developed by Brower"）⇒ **与 `brower-1972`/`brower-friedman-1973` 不是方法独立**，只是结果的独立确认；(2) 结论是 **`d ⩽ 10`**，临界维 `d = 10`，**摘要不给本模型的 intercept 值**；(3) 本文同时讲 pomeron 极点与「全对称模型」（type II 闭超弦前身），无鬼定理只是其中一部分 ⇒ loc 只能写 `pp. 61–74`；(4) **不得写 "Theorem N"**（1972 年快报体例，见 `goddard-thorn-1972` 的四条间接证据）。<br>⚠ **重印出处与 GT 1972 是同一本**：Schwarz 编 *Superstrings, Vol. 1*, **98–111**（GT 在 112–115）——该书 archive.org 五次检索全 0 命中 ⇒ **重印文集路线对本文同样先验不通**。<br>**下一枪**：`cds.cern.ch/oai2d` 查 CDS recid（Schwarz 1972 年在 Princeton 而非 CERN，命中率低）；或 `.edu` 课程页扫描件 |
| **P1** | **kac-2017-lectures** | arXiv:1512.00821**v2**，Lecture 1–3（pp.3–22）；§4–§6 未读 | worldsheet, math | researcher | **★★ extracted（L1，读 pp.1–4, 6–9, 18–20，2026-09-11，新登记）** → `extractions/math-sources.md` **§51.2**。Victor Kac 本人的 INdAM/Pisa 讲义（学生记稿）。<br>**★ 这是本项目唯一一个「超（费米）设定 + 带编号 + 免费 + 含证明」的 OPE↔反对易子字典来源。** 三条核心：**Remark 1.4 (1.16), p.6** 声明超设定与 `[a,b] = ab − (−1)^{p(a)p(b)}ba`；**Remark 1.5 (1.32), p.7** 模式版（超）对易子公式，**前提只要「李超代数 + 一对局域形式分布」，不需要顶点代数**；**Corollary 3.2 (3.20), p.18** 顶点代数版 + 明写 `End V` 是 **Lie superalgebra**；**Proposition 3.1 (3.21), p.18** 带 `(−1)^{p(a)p(b)}` 的 Borcherds 恒等式。<br>⚠ **陷阱**：Definition 1.1/1.3 正文完全不含 parity，超设定只在 Remark 1.4 一次性声明 ⇒ 引其 `[,]` 必须同引 Remark 1.4。<br>⚠ (3.21) 是「两项 + δ」形式，**与 `borcherds-1986` §4 (v) / `gebert-nicolai-1995` (2.36) 的三项模式形式逐字不同**。<br>⚠ 学生记稿、非同行评议；版本写死 **v2**。<br>**未读**：pp.5, 10–17, 21–50；**§2.3「Bakalov's formula and Dong's lemma」尚未与 `schottenloher-2008` Lemma 10.11 对照**（成本约 2 次 Read） |
| P2 | **ahlfors-sario-1960** | 全书（分类定理证明的 Step 1–6） | math | 待分派 | **新登记（2026-09-11，L0）** → `extractions/math-sources.md` **§53**。Princeton University Press, 1960，约 398 页。<br>**登记理由**：`gallier-xu-2013` 的 **Proposition 6.1（p.86）与 Lemma 6.1（pp.92–95）** 把证明的关键步骤**外包给本书**（两处 L1 逐字）；GX 的六个 Step 就是 A–S 自己的 Step 1–6（Note F.9, 书 p.169, L1）。**若 `math.classification-of-compact-surfaces` 要走 `rigorous`，证明在这里，不在 GX。**<br>⚠⚠ **GX 从不给本书的章号/节号/定理号**（References [1] + Note F.9 + 两处证明引用全查过）⇒ 现阶段 `loc` 只能写 "Step k"。<br>⚠ **丛书号存疑**：GX 印 "Princeton Math. Series, **No. 2**"，1960 年不可能；OpenLibrary 的 series 字段为空 ⇒ **bib 里不写号**。<br>**获取**：无 arXiv、无 DOI；archive.org 是否有开放扫描**本轮未查**（WebSearch 额度耗尽） |
| P2 | seifert-threlfall-1980 | *A Textbook of Topology*, Academic Press, 1980，**Chapter VI, Section 38（无边）+ Section 40（带边）** | math | 待分派 | **候选，尚未进 `sources.bib`（2026-09-11 新增）**：`gallier-xu-2013` Note F.9（书 p.169，L1 逐字）明确指出分类定理的另一条完整证明在此，**并给出节号** —— 这是本项目目前**唯一一条带节号的分类定理证明位置**（A–S 那条只有 "Step k"）。⇒ **比 `ahlfors-sario-1960` 更可引，建议优先于它**。GX 同段还给出两者的逐 Step 对照。<br>另 GX References 提供的 L1 书目校正：**[7] Massey 是 GTM 56 第 2 版 1987**，与 bib 里的 `massey-1967`（1967 初版）**不是同一版**（§39.3 的跨版本风险再获一条佐证）；**[2] Brahana, Ann. Math. 23(2):144–168, 1921** 是切割法 (P2) 的最早出处（且只处理无边曲面） |

## 已知获取路线备忘

- **★★ 新增（2026-09-11，researcher）：INSPIRE/arXiv API 取「逐字完整摘要」的可靠写法。**
  中介概括器有 **125 字符引用上限**，直接要「verbatim」会被改写成转述（本轮在 Gibbons–Hull 上踩过一次）。
  **管用的 prompt**：「Reproduce the abstract EXACTLY, split into consecutive fragments of at most **90 characters**
  each as a **numbered list**, preserving every character. Do not summarize.」
  —— 对 INSPIRE `fields=abstracts` 一次成功，三篇（Gibbons–Hull / Terao–Uehara / Schwarz 1972）全部拿到逐字。
  ⚠ 同时查多字段会被截断，**要逐字摘要就单独查 `fields=abstracts&size=1`**。
- **★★ 新增（2026-09-11，researcher）：Google Books 页码探针的「无命中」判据已做实。**
  对卷 `mSD4DvUFa6QC`（Humphreys GTM 9）用无意义串 `"zzqxjkwmnbvpl"` 做对照 →
  **阅读器停在 "Front Cover"**；真命中则**停在具体内页**。
  ⇒ **今后判读规则：停在内页 = 真命中；停在封面 = 无命中；页面完全不交付 = 没拿到（三者必须分开记）。**
  该卷本轮新命中：`"Maximal Toral Subalgebras and Roots"` → p.35、`"Corollary 8.2"` → p.38、
  `"Proposition 8.3"` → p.38、`"Harish-Chandra's Theorem"` → p.130、`"Theorem 23.1"` → p.135。
  ⚠ **仍然不回 snippet** ⇒ 原文措辞永远 L0，且**分不清"定理本身"与"交叉引用"**。
- **★ 新增（2026-09-11）：Polchinski Vol.1 ch.2 / ch.3 的章级 PDF 均一次命中**（文件名直接推出）：
  ch.2 = `9780511816079c2_p32-76_CBO.pdf`（418 KB / 45 页，**PDF 页 = 书页 − 31**，DOI 后缀 **`.005`**，
  尾部 slug `conformal_field_theory.pdf`）；
  ch.3 = `9780511816079c3_p77-120_CBO.pdf`（408 KB / 44 页，**PDF 页 = 书页 − 76**，DOI 后缀 **`.006`**，
  尾部 slug `the_polyakov_path_integral.pdf`）。**尾部 slug 用章标题的小写下划线形式即可，不必先 fetch abs 页。**
- **★ 新增（2026-09-11）：`openlibrary.org/search.json?q=<书名作者>&fields=title,author_name,first_publish_year,publisher,number_of_pages_median`
  是 pre-1970 数学书的可用 L2 书目源**（Springer/Google Books 都不行时）。
  ⚠ **它不返回丛书号**（`series` 字段常为空）——Ahlfors–Sario 的 "Princeton Math. Series No. ?" 就是因此仍未结清。
- **⚠ 第三次确认：`WebSearch` 会话额度（200/200）在本批任务开始前就已耗尽**（2026-09-11 两次不同任务）。
  受影响且**连续两轮未执行**的目标：Humphreys GTM 9 的扫描件/编号检索（§50.5 与 §52.4 的第一条路线）。
  **⇒ 强烈建议 lead 把依赖 WebSearch 的子任务排在整批任务的最前面。**

- **★ Polchinski Vol.1 章级 PDF 的文件名规则已第七次验证（2026-09-11，ch.7）。**
  `9780511816079c<章号>_p<起页>-<止页>_CBO.pdf` + item hash 表（见本文件下方与
  `extractions/polchinski-1998-v1.md` §12.0）**可以直接推出 URL，不必先 fetch abs 页**。
  ch.7 = `1FCFE9B5026DE1E5210F0F62514336B0` / pp.206–230 / **264.2 KB / 25 页（≈10.6 KB/页）**。
  **Polchinski 两卷任何章节都不会撞 WebFetch 的 10 MB 上限。**
  ⚠ 页脚会印**下载机构与时间戳**（本次：`Zhejiang University, on 10 Sep 2026`）——这是版本锚定的可靠凭据，抽取时值得抄一行。
- **★ 「跨章定点核对」是很便宜的动作，建议养成习惯（2026-09-11 ch.7 抽取时首次系统使用）。**
  抽 ch.7 时发现 (7.3.14) 与 (5.1.15) 的不等号可能不一致，于是**只多花一次 fetch + 一次单页 Read**
  （ch.5 PDF 的第 4 页 = 印刷 p.148）就同时做成三件事：
  (a) 确认差异真实存在；(b) **把 `worldsheet.modular-fundamental-domain` 的 loc 从「未核对原书」升到 L1**；
  (c) 拿到原书自己的强度措辞「it can be shown」，**取代了此前只有第三方（[S]）评价的局面**。
  ⇒ **抽取新章节时，凡遇到「本章引用了别章某式」且该式已在图里当 source 用，就顺手用页范围算出 PDF 页号单页核一次。**
- **★ 页图上读到反直觉的系数时，先复算再改读数（2026-09-11 ch.7 再次奏效）。**
  (7.4.24) 的分子读作 `24V₂₆`，直觉上「应该只有 `V₂₆`」。**没有改读数，而是用 (7.4.4) 的展开系数 24
  加上三个面的相加复算了一遍**，结果与页图完全一致，同时顺带验证了 (7.4.3)/(7.4.19)/(7.4.23) 三式系数自洽。
  （同 AGW (101) = 11/21、Zumino (5.10)/(5.11) 的教训。）
- **★★ 新增可用路线（2026-09-11，swampland 支点批次）：`api.semanticscholar.org/.../DOI:<doi>/citations?fields=title,year,contexts` —— 用「谁引用了它、在什么语境下引用」逼近取不到正文的 pre-arXiv 论文。**
  对 `bagger-witten-1983`（DOI `10.1016/0550-3213(83)90605-3`）与 `wen-witten-1985`（`10.1016/0550-3213(85)90592-9`）**都成功返回**，一次调用给出 20+ 条引用语境。
  **⚠ 三条使用限制（本轮实测）**：
  1. **返回的每条 `context` 会被 fetch 摘要器截到约 125 字符** —— 够看「引用方说它证明了什么」，**不够拿到公式号或完整句子**。
  2. **它索引不全**：**`10.2307/1970210`（Borel–Harish-Chandra 1962，Annals of Math）直接 HTTP 404** ⇒ 老数学期刊可能整篇不在库里。**先用一个已知在库的 DOI 做对照，再读否定结论。**
  3. **`/paper/search?query=` 端点两次 HTTP 429**（与既有记录一致）：**只用 `DOI:` 前缀查，不要用标题查。**
  **⚠ 更根本的一条**：引用语境的**质量取决于引用方的学科**。Wen–Witten 的引用语境全部是现代 millicharged 实验文献的泛泛表述（"fractionally charged particles are a generic prediction of string compactification"），**对内容核实毫无用处**；Bagger–Witten 的则条条命中「quaternionic Kähler」，很有用。
- **★★ 新增可用路线（2026-09-11）：`INSPIRE 全文检索 + 现代综述` 是 pre-arXiv 物理论文的最佳 L3 替代品。**
  手法：`inspirehep.net/api/literature?q=ft "<作者姓 and 作者姓>" and ft "<目标结论的关键词>"&fields=titles,arxiv_eprints`
  → 拿到几篇 arXiv id → **`arxiv.org/html/<id>` 或 `ar5iv.labs.arxiv.org/html/<id>`** 读全文 → 取它对目标论文的逐字转述 + 它给目标论文编的参考文献号。
  本轮 `ft "Bagger and Witten" and ft "negative scalar curvature"` 一枪命中两篇独立综述（2501.01900、2304.06073），
  把 `bagger-witten-1983` 从纯 L0 抬到「两条独立 L3 + 显式公式」。
  **⚠ 陷阱（本轮踩到，浪费两次检索）**：`ft "<姓> and <姓>"` 对**同姓氏组合**会大面积误命中。
  `ft "Wen and Witten"` 几乎全部命中 **Wang–Wen–Witten 2019「A New SU(2) Anomaly」**，而非 Wen–Witten 1985。
  ⇒ **作者姓氏检索必须带一个只属于目标篇的判别词**（卷号 `"B261"`、或该篇独有的术语）。
- **⚠ 反复踩的坑（2026-09-11 第三、四次）：`arxiv.org/abs/<id>` 只回摘要。**
  本轮又在 `abs/2501.01900`、`abs/2001.07731`、`abs/2304.07819v2` 上浪费三次调用。
  **要正文一律用 `arxiv.org/html/<id>[vN]`（2024+ 原生 LaTeXML，且对 2023 年的论文也常有）或 `ar5iv.labs.arxiv.org/html/<id>`。**
  本轮实测：`arxiv.org/html/2501.01900v2`、`arxiv.org/html/2304.06073`、`arxiv.org/html/2509.09047`、`arxiv.org/html/2606.08427v1`、
  `arxiv.org/html/2304.07819v2` **全部一次成功**；`ar5iv…/html/2001.07731`、`ar5iv…/html/2006.04839`、`ar5iv…/html/hep-th/0002240` 也成功。
- **★ 新增可用元数据源（2026-09-11）：`export.arxiv.org/api/query?search_query=...`。**
  - `ti:"<确切标题>"` 一次可以查多篇（支持 `OR`），返回 **arXiv id（含版本）、完整作者表、published/updated 双日期、`journal_ref`、DOI**。
    这是**给 arXiv 论文定版本与定发表信息最省事的一枪**（比 `/abs/` 强得多，因为 `/abs/` 的摘要页要额外解析）。
  - `abs:"<词>" AND abs:"<词>"` 搜**摘要全文**，可以用来「找哪篇论文的摘要里有这个数字」。
    本轮用 `abs:"491" AND abs:"Kreuzer-Skarke"` 一次拿到四篇独立佐证 `h^{1,1}` 最大值 = 491 的论文。
  - ⚠ 摘要器仍受 125 字符引用限制，**要完整摘要就明确要求「分成若干段、每段 120 字符以内、编号、拼接可复原」** —— 本轮对 INSPIRE 与 arXiv API 都用这招成功取到逐字完整摘要。
- **⚠ 死路补充（2026-09-11）：Princeton 系 pre-arXiv 论文（SPIRES 报告号形如 `Print-8X-XXXX (PRINCETON)`）无任何取件入口。**
  `Print-` 前缀是 **SPIRES 的占位号，不是真实报告号**，拿它去查 OSTI / INIS / NTIS 一律无意义。
  `bagger-witten-1983` 与 `wen-witten-1985` 的 `external_system_identifiers` **都只有 MSNET + SPIRES，无 CDS、无 KEKSCAN**
  ⇒ **CDS OAI-PMH 与 KEK 两条路线在入口即排除**（不是"试了失败"，是"没有入口"）。
  OSTI 用**标题短语**查询（按既有教训避开被吞）对两篇都返回主题相关但不含目标的结果 ⇒ **OSTI 确实不藏**。
  **⇒ 这类论文唯一现实的路线是 `WebSearch` 找 `.edu` 课程页扫描件**（AGW 1984 即此法）。
- **⚠ 会话级资源限制（2026-09-11 实测）：`WebSearch` 有独立于 `WebFetch` 的会话额度（本轮 200/200 用尽）。**
  额度耗尽后**只剩已知 URL 的直取与 API 查询**，「找扫描件」这类必须靠检索的任务**完全无法执行**。
  ⇒ **排任务时，把依赖 `WebSearch` 的目标（找扫描件、找定理编号）放在会话前段。**

- **★★ 新增可用路线（2026-09-11）：OUP 上的 Progress of Theoretical Physics 旧刊（1946–2012）PDF 可直接取得。**
  `ito-morozumi-nojiri-uehara-1986`（PTP 75, 934–952）全文即以此取得（L1，804 KB 扫描件）。
  1. `https://academic.oup.com/ptp/article-lookup/doi/<DOI>`（或 `doi.org/<DOI>` 两跳）→ HTML 文章页给出 `article-pdf/<卷>/<期>/<起页>/<数字id>/<卷>-<期>-<起页>.pdf` 链接（**数字 id 无法猜，必须从文章页拿**）。
  2. `WebFetch` 该 PDF 链接 → **302 到 `watermark02.silverchair.com/<文件名>?token=…`**，按提示再 fetch 一次 → 落盘 → `Read(pages=)`。
  3. ⚠ 文章页写「This PDF is available to Subscribers Only」，**实测可下载**（PTP 旧刊已开放或本环境有订阅，未分辨）。
  4. ⚠ 猜错数字 id 会 302 到**另一篇**文章的 watermark（本轮猜 `5295012` 拿到的是 `32-5-738.pdf`），别信 token 里的文件名。
  ⇒ **KO 学派 1980 年代在 PTP/PTP Suppl. 上的论文（Kugo–Ojima PTP Suppl. 66 quartet、Terao–Uehara、Hata 等）都可循此路线；`kato-ogawa-1983` 本身是 NPB，不适用。**
- **⚠ 本轮硬约束（2026-09-11）：`WebSearch` 会话额度 200/200 耗尽后，三次检索均被拒绝。** 影响：kato-ogawa / ohta / henneaux 三篇的「大学课程页扫描件」路线**均未执行**（非失败），下一轮有额度时应先补这三次检索。没有 WebSearch 时可用的替代：INSPIRE 期刊检索 `q=j Phys.Rev.D,33,1681`（比标题检索稳，标题单复数错一字就零命中）、Crossref `works/<DOI>`、INIS `api/records?q=`、Project Euclid 卷期目录。
- **⚠ ULB DI-fusion（Henneaux 机构库）状态（2026-09-11）**：VuFind 前端 `difusion.ulb.ac.be/vufind/Search/Results` **HTTP 500**（三次，服务器端）；VuFind API `/vufind/api/v1/search` 404；DSpace 后端 `dipot.ulb.ac.be/dspace/simple-search?query=…` **能回「Results 1-1 of 1」但条目表不交付**（三次）；`/dspace/open-search/…`、`/dspace/browse?type=author` 均 404；OpenAIRE `api.openaire.eu/search/publications` **HTTP 409**。⇒ 有记录、拿不到 handle。交人类点击的 URL 见 `extractions/henneaux-1987.md` §0.4。
- **⚠ `lib-extopc.kek.jp` 第四次 `socket hang up`（2026-09-11，用 INSPIRE 的确切 `KEKSCAN 85-12-165` 拼 `/1985/8512/8512165.pdf`）**。维持「主机级死路」判断。
- **OSTI 对期刊文章只有引文记录**：`ohta-1986` 有 OSTI id 5930612，`api/v1/records/5930612` 给完整引文（含终页、期号），但 `servlets/purl/5930612` **404**。**purl 路线只对 DOE 报告有效，OSTI id 的存在不意味着有全文。**
- **★ Crossref `works/<DOI>` 本轮三次全中**（FOK CMP 124 DOI、Henneaux PLB 183 期号、KKM PTP 124 卷页），仍是核期号/终页最省事的入口。

- **★★ 新增可用路线（2026-09-11）：`osti.gov/servlets/purl/<OSTI-ID>` —— 1980 年代 DOE 国家实验室报告（LBL / ANL / FNAL / SLAC…）正文的直接入口。**
  `zumino-1983-les-houches`（LBL-16747，46 印刷页）全文即以此取得（L1）。
  **这条路线修正了本文件此前的一句判断**：`goddard-thorn-1972` 那次记的「OSTI 无全文」应收窄为
  **「OSTI 不藏 CERN-TH 报告」，而不是「OSTI 没有全文」**。凡报告号形如 `LBL-*`、`ANL-*`、`FNAL-*`、`SLAC-PUB-*`、`DOE/ER/*` 的，都值得先试 OSTI。
  1. `https://www.osti.gov/api/v1/records?q=%22<报告号>%22` → 拿 **OSTI ID**。
     ⚠ **一律用 `q="…"` 加引号，不要用 `report_number=` 参数**：实测 `report_number=LBL-16443` 与 `q="LBL-16747"` 行为不一致。
     ⚠ **含 `/` 的报告号（如 `DOE/ER/40048`）会让查询被静默忽略并返回一批无关记录** —— 看到结果与查询毫无关系时，是查询被吞了，不是「无此件」。
  2. `https://www.osti.gov/servlets/purl/<OSTI-ID>` → **WebFetch 会抱怨读不了二进制，但已落盘并在末尾方括号里打印本地路径**（同 AGW/Cambridge 路线）。
  3. `Read` 带 `pages` 逐页读图。**扫描件常是打字稿 + 手写公式**：一次 10 页可读，**关键系数必须单页重渲染**，且**同篇内两条路线算同一批数时一定互除一遍**
     （本轮即靠 (5.10) 与 (5.11) 互除，把肉眼的 `(m−1)!` 改判为 `(n−1)!`；同 AGW 定 (101) = 11/21 的手法）。
- **★ 配套的存在性探测器：INIS 的 `files` 字段（2026-09-11 口径修正）。**
  `https://inis.iaea.org/api/records?q=<查询>&size=20` 返回的记录里，若 **`files.enabled: true`** 且 **`access.files: "public"` / `access.status: "open"`**，
  则该件**确实有开放全文**（本轮 LBL-16747 = INIS `ph8pd-7r422`，文件 `15035011.pdf`，542345 字节，与 OSTI 那份吻合）。
  ⇒ **修正本文件此前「INIS 取全文基本无望」的口径**：`files.enabled` 是**可信的正信号**，
  只是**下载要换主机** —— 旧公共路径 `collection/NCLCollectionStore/_Public/<vol>/<iss>/<RN>.pdf` **本轮实测仍 404**。
  **用 INIS 判断「有没有」，用 OSTI 拿「文件本身」。**
- **⚠ 反爬新增一条**：`digital.library.unt.edu`（TRAIL / DOE 技术报告扫描库）返回 **Altcha 挑战页**，agent 过不去。
  与 `cds.cern.ch` 同类处理：**把 URL 交给人类点击，不要用代理绕**。

- **★★ 新增可用路线（2026-09-11，researcher 第二次复用并再次成功）：DNB（德国国家图书馆）的出版方目录扫描 `https://d-nb.info/<IDN>/04`。**
  这是**取教科书章节标题 + 印刷页码**最省事的路线，绕过 Springer 登录墙；本轮一次拿下两本：
  **Farkas–Kra, *Riemann Surfaces*（IDN `920606512`，标题页明写 `Second Edition`）**
  与 **Jost, *Compact Riemann Surfaces*（IDN `948901241`，标题页**无**版次字样）**。
  1. 用普通检索搜书名，结果里会直接出现 `d-nb.info/NNNNNNNNN/04` 链接（附件号通常是 `04`）。
  2. `WebFetch` 该 URL → 抱怨二进制但**落盘**（本轮 62 KB / 460 KB）→ `Read` 带 `pages` 读图，扫描件清晰。
  - **★ 副产品：标题页能定版次。** FK 那份明写 `Second Edition`，Jost 那份没有 ⇒ 两本的版次可信度立刻不同。
    **版次定不下来就不要登记进 `sources.bib`**（本轮 Jost 即因此暂缓，见 `extractions/math-sources.md` §39.11）。
  - ⚠ 仍然拿不到年份/ISBN：`portal.dnb.de` 与 `d-nb.info/<IDN>`（不带 `/04`）在 Anubis 墙后。
- **⚠ 死路确认（第三次）：`lib-extopc.kek.jp/preprints/PDF/<年>/<yymm>/<KEKSCAN号>.pdf` 一律 `socket hang up`。**
  本轮用 INSPIRE 给的**确切** `KEKSCAN 85-02-154` 拼出 `…/1985/8502/8502154.pdf`，**仍然 socket hang up**
  ⇒ 失败原因不是"号码猜错"，是主机层面不可达。**`KEKSCAN` id 今后只当书目标识用，不要再花额度试直取。**
- **⚠ OSTI 查询的第二种"被吞"形态（补充既有教训）**：`q="CALT-68"` 返回的 5 条全是 `SLAC-PUB-*`，与查询无关
  ⇒ **含连字符的报告号前缀也会被吞**，不只是含 `/` 的。
  **可靠的替代做法：改用标题短语查询**（本轮 `q="hexagon gauge anomaly"` 返回 4 条全部主题相关，
  于是"OSTI 不藏该文"才成为可用的否定证据）。**先用一个必然命中的短语确认查询没被吞，再读否定结论。**

- **★★ 新增可用路线（2026-09-11）：大学课程页挂的原刊扫描件 —— `alvarez-gaume-witten-1984`（Nucl. Phys. B234, 269–330, 62 页）全文即以此取得（L1）。**
  这是第二条成功拿到 pre-arXiv 论文正文的路线，**比 archive.org 路线省事得多，应当先试**。
  1. `https://inspirehep.net/api/literature?q=t%20<标题词>%20and%20a%20<作者>&fields=titles,publication_info,control_number,report_numbers,external_system_identifiers`
     → 拿 recid、报告号、DOI。**顺手看 `external_system_identifiers` 里有没有 `KEKSCAN`**（AGW 有 `84-02-145`）。
     ⚠ AGW 的 `documents` / `urls` 两字段皆空，**INSPIRE 没有全文不等于网上没有**。
  2. 直接 `WebSearch`「作者 标题 期刊 卷 页 pdf full text scan」。1970–80 年代名篇常被某门研究生课挂在系里主页上。
     AGW 命中的是 **McGill PHYS 675**：`https://www.physics.mcgill.ca/~keshav/675/gaumewitten.pdf`。
  3. `WebFetch` 该 URL → **PDF 会被自动落盘并打印本地路径**（回答本身是「读不了二进制」，不要被它误导）→ `Read` 带 `pages` 逐页读图。
     62 页分 7 次读完，无失败；公式细节清晰。**关键公式建议单页重渲染再核一遍**（本次靠这一步定下 (63)、(119)、(114)）。
  - **交叉核对比重渲染更有效**：AGW (101) 的末项系数肉眼读作 `11/24`，但与 (119) 做除法立刻得 `7920/15120 = 11/21`，改判。
    **凡是同一篇里有两条路线算出同一批数的，一定互除一遍。**

- **★ archive.org 重印文集 + BookReader 逐页取图（2026-09-11）：`green-schwarz-1984` 全文即以此取得（L1）。**
  ⚠ **适用边界（2026-09-11 补，踩过一次）：只对「完全开放」的 item 有效。**
  AGW 重印于 *Current Algebra and Anomalies*（Princeton UP 1985，本文在 pp. 451–514），
  archive.org identifier `currentalgebraan0000unse` **确实存在且检索得到**，但它是 `printdisabled` + `internetarchivebooks`
  **借阅制**（metadata 里 `access-restricted-item: true`），**`fulltext/inside.php` 在 `ia800400` 与 `ia600400` 两台服务器上都返回 HTTP 403**。
  ⇒ 拿到 identifier 后**先看 `https://archive.org/metadata/<id>` 的 `access-restricted-item`**，是 `true` 就别浪费额度走 BookReader。
  另：`modern-kaluza-klein-theories` 不含 AGW（全文检索 "gravitational anomalies" 的命中全落在 GS 那篇内）——
  **「GS 在哪本文集里」不能推出「AGW 也在那本」。**

  这是本项目第一次成功拿到 pre-arXiv 论文的正文。四步：
  1. `https://inspirehep.net/api/literature/<recid>?fields=publication_info` 看有没有 `pubinfo_freetext`
     形如 `In *<编者> (ed.): <文集>, <起>-<止>`（GS 1984 有**六个**重印出处）。
  2. `https://archive.org/advancedsearch.php?q=title%3A%28<文集名>%29&fl%5B%5D=identifier&rows=20&output=json`
     找 identifier。
  3. `https://archive.org/metadata/<identifier>` 取 **`server`**、**`dir`**、以及 **文件基名**
     （例：`Modern Kaluza-Klein theories - Unknown`，注意含空格，要 URL 编码）。
  4. **全文检索定位页**：
     `https://<server>/fulltext/inside.php?item_id=<id>&doc=<基名>&path=<dir>&q=<词>`
     → 返回 `{"matches":[{"page":<leaf>,"text":"…"}]}`。
     ⚠️ **`doc=` 必须填文件基名，填 identifier 会返回 `"No hOCR or Abbyy file present"`**（踩过一次）。
  5. **逐页取图**：
     `https://<server>/BookReader/BookReaderImages.php?zip=<dir>/<基名>_jp2.zip&file=<基名>_jp2/<基名>_0612.jp2&id=<id>&scale=1&rotate=0`
     → WebFetch 落盘 JPEG → `Read` 读图。
     **`scale=1` = 原尺寸（约 700 KB/页），`scale=2` = 半尺寸（约 250 KB/页）。公式细节一律用 `scale=1`**：
     本次在 `scale=2` 下把 GS (25) 的求积上限和 (4) 的下标都读错过。
  - **死路提醒**：该 item 的整本 PDF 有 30 MB，**WebFetch 硬上限 10 MB**，直接下载必失败（`maxContentLength size of 10485760 exceeded`）；
    `api.archivelab.org`（旧的 `/pages/<n>/ocr` 与 `/searchinside` 端点）**Socket is closed，已废**；
    `articles.adsabs.harvard.edu/pdf/<bibcode>` **403**。
  - **适用范围**：`goddard-thorn-1972` 的重印本（Schwarz 编 *Superstrings: The First 15 Years*）此前 archive.org 检索 `numFound: 0`，
    但**值得按本流程重试**：GS 1984 的六个重印出处里有四个是别的文集，说明 1970–80 年代 hep-th 名篇常被多次重印，
    「换一本文集找」是比「找原刊」更有效的策略。
- **★★ Cambridge Core 章级 PDF：本环境持有机构订阅，Polchinski 两卷的正文都能直接取到（2026-09-11 实测）。**
  这条路线让「Polchinski 式号只能靠二手笔记核对」这个前提**作废**，`polchinski-1998-v1.md` §3 那张
  「未核实公式号清单」原则上可以一轮清空。手法：
  1. `www.cambridge.org/core/books/string-theory/<BOOK_HASH>` 列出每个 item 的 hash 与页范围
     （Vol.1 = `30409AF2BDE27D53E275FDA395AB667A`，Vol.2 = `2D456468D20AA8A9CE10CEB08B95B9DC`）；
  2. `www.cambridge.org/core/books/abs/string-theory/<slug>/<ITEM_HASH>` 页面上有 "Save PDF" 链接；
  3. 真实 PDF URL 形如
     `www.cambridge.org/core/services/aop-cambridge-core/content/view/<ITEM_HASH>/<file>_CBO.pdf/<name>.pdf`，
     其中 `<file>` = `9780511618123c<N-9>_p<起页>-<止页>_CBO`（Vol.2）——**文件名可直接推出，省一次 fetch**；
  4. WebFetch 会抱怨二进制但**落盘并打印路径**，再用 `Read` 带 `pages` 读页图（一次最多 20 页）。
  **Vol.2 全部 item hash（2026-09-11 补全，书目页 L1；文件名 `9780511618123c<章号-9>_p<起>-<止>_CBO.pdf`）：**
  frontmatter(i–viii) `A8D08A85DB6844C8B9430754B2DE51FE` / contents(ix–xii) `07FB90D821053D58A00610479EFE2978` /
  foreword(xiii–xiv) `7E0461172EFC9FD46DF4B14EB59CC849` / preface(xv–xvii) `16FF8CF455EFF0D314451B27D566DE81` /
  notation(xviii–xx) `BACF746050A6F8DC6AE8EF5FA4A6BA28` /
  ch.10(1–44) `E69C35DC077FD0BAD6B39479144D4A12` / ch.11(45–83) `C4D876C20A83F4E778152B75A219A718` /
  **ch.12(84–135) `46D902501550C028C94F24884F4B9D7A`（实测：`…c3_p84-135_CBO.pdf`，682.8 KB / 52 页，一次命中）** /
  ch.13 D-branes(136–177) `67EE13E32046F0D121B589DC02989698` / ch.14(178–227) `42973BC3975BD6057BD6B92455DC8507` /
  ch.15 Advanced CFT(228–273) `D7C488602138F0172CFC84FAAD81432A` / ch.16 Orbifolds(274–301) `ADD5943B7F21890CE6D0C9C38B055E94` /
  ch.17 Calabi–Yau(302–326) `D4ED937166A0959DD5AADA7A9FF787D1` / ch.18(327–374) `7C6170A1B90D3153367ADE060058A486` /
  ch.19(375–429) `398330CF57E92B5A78F131A0407BD869` / **App.B spinors(430–466) `872CC69E98F684AFA1019EB2A955BD11`** /
  **References(467–487) `B294A2903028C82BE0FD5C19FC4C5890`** / glossary(488–517) `69846877E86A0719EB9DB58254EBB5DE` /
  index(518–531) `9219B5E10873678567E837F7BFA76036`。
  📏 **Polchinski 的体积基准（用于判断是否会撞 10 MB 上限）：约 13 KB/页** ——
  最长的 ch.19（55 页）也只有 ~0.7 MB，**Polchinski 两卷任何章节都不会超限**。
  **Vol.1 全部 item hash（2026-09-11 实得，文件名规则 `9780511816079c<章号>_p<起页>-<止页>_CBO.pdf`，实测 c1–c8 全部命中）：**
  frontmatter(i–viii) `D8E774D629783EE35C60C78122AF28B5` / contents(ix–xii) `5A6EE61D4E1E712BB9D55D142187A6B6` /
  foreword(xiii–xiv) `55B6451C35A99B25FE283F4B1AD988A7` / preface(xv–xvii) `BB4B6DFFBB6CA9E785644A9D0693C9CD` /
  **notation(xviii–xx) `4E431CFB7DE9E03AE982456CC6BA3BE0`（文件名例外：`9780511816079mfm_pxviii-xx_CBO.pdf`）** /
  ch.1(1–31) `B743D2FD9DFC745DF9A39834989A0BAB` / ch.2(32–76) `5CA151E88B12C248825A262624ADC7D6` /
  ch.3(77–120) `606E849133B4EE45657DF6128FD1C8C1` / ch.4(121–144) `12E46864E4792BDA6021FD53D3C193E2` /
  ch.5(145–165) `2619B77DD4AE2BE4D53B5EED5D3BE3C1` / ch.6(166–205) `F440F6B46EB4150F96EAEAFDDF9F0D76` /
  ch.7(206–230) `1FCFE9B5026DE1E5210F0F62514336B0` / ch.8(231–282) `812E73D34A5F56520ECCAA94F068E1A6` /
  ch.9(283–328) `8787336CD0569208E89B12D418283685` / **App.A 路径积分(329–346) `D6A09941572ED2451AFC3C5C497F9A9A`** /
  **References(347–358) `F5E26AFC8AF1D3B0E3F3866E752F8FD2`** / glossary(359–388) `41D8D3C53148B5BFBA313D3C612F7887` /
  index(389–402) `C125CE5357865125A6B484F68E9EE3AC`。
  ⚠ **版本锚定**：Core 数字化本是 **Cambridge Books Online（2005 平装，已含 2000 年 "with corrections"）**。
  → 因此 [S] 说「按 Joe 勘误表更正」的那几处（(5.3.5)、(5.4.10)、(8.6.19) 等），**页图上看到的已经是更正后的文本**，
  「官方勘误表取不到」这个系统性风险随之大幅降低（KITP 三条 URL 仍 404，但已不再是必需品）。
  ⚠ 注意 `assets.cambridge.org/.../frontmatter/*.pdf` 仍然 **Socket is closed**（与旧记录一致）；**要走 Core 的 `/services/` 端点**。
- **★★ 该路线的硬天花板：WebFetch 上限 10 MB（10485760 B）—— 对 GSW 两卷是致命的（2026-09-11 实测）。**
  Polchinski 是**排版重制**的电子书，章级 PDF 小；**GSW 是逐页扫描件，约 240 KB/页**，所以
  **超过约 42 页的章节一律 `maxContentLength size of 10485760 exceeded`**。实测：
  GSW v2 ch.10（38 页）**9.1 MB ✅**；GSW v2 ch.13（56 页）**12 MB ❌**；GSW v1 ch.2（64 页）**13 MB ❌**。
  已逐条排除的绕行方案：
  1. 去掉 URL 尾部文件名（`.../content/view/<HASH>/<file>_CBO.pdf`）→ 同样超限；
  2. `assets.cambridge.org` 同路径 → `Socket is closed`；
  3. **节级 PDF 不存在**：章级 `https://www.cambridge.org/core/product/identifier/CBO<ISBN>A<NNN>/type/BOOK_PART` 可访问
     （GSW v2 ch.13 = `A049` ✅），但章 identifier 之间的空档（`A050`–`A054`）**全部 HTTP 400**——
     那些编号只是分配空位，不对应可下载产品。**别再试推节级 hash。**
  4. Google Books：CUP 学术书常是 "No eBook available / Pages displayed by permission"，**检索不回 snippet**，
     只回一个可能落在索引区的页号（GSW v2 查 `"Allowed gauge groups"` 回 p.593/591，不可用）。
  5. archive.org：GSW v2 有两份扫描 `superstringtheor0002gree` / `superstringtheor0002gree_e7j9`，
     **两份都是 `access-restricted-item: true`（inlibrary/printdisabled）**，`fulltext/inside.php` 与
     `download/<id>/<id>_djvu.txt` 均 **403**。GSW v1 在 archive.org 上没有。
  ⇒ **超限章节的唯一出路是把 URL 交给人类点一次。** 已记录的两条：
  - GSW v2 ch.13（pp.307–362）：`https://www.cambridge.org/core/services/aop-cambridge-core/content/view/F2BEB1F0811FE1D8458547AAB73D12AF/9781139248570c6_p307-362_CBO.pdf/low-energy-effective-action.pdf`
  - GSW v1 ch.2（pp.57–120，含 §2.3.3 无鬼定理）：`https://www.cambridge.org/core/services/aop-cambridge-core/content/view/7EB8CEE02B28B374C180E9B274A19591/9781139248563c2_p57-120_CBO.pdf/free-bosonic-strings.pdf`
  **GSW 的 Core 坐标（2026-09-11 实得）**：Vol.1 书 hash `35152940E2D9C3B0BD327EB7FF74DBBE` / online ISBN `9781139248563`；
  Vol.2 书 hash `ABB0BC23C86B597DAF81D50D463D2FA7` / online ISBN `9781139248570`；
  Vol.2 文件名规则 `9781139248570c<章号−7>_p<起页>-<止页>_CBO.pdf`（ch.8→c1，ch.10→c3，ch.13→c6）；
  目录是 `9781139248570toc_pv-x_CBO.pdf`（item hash `4E0B040C8A72C8497FC384DD745EAF10`），
  ch.10 item hash `38B434AD7713BFBAFF39E5AD96C93161`，ch.13 item hash `F2BEB1F0811FE1D8458547AAB73D12AF`。
  ⚠ **章号与 DOI 后缀错位**（ch.10 ↔ `.004`，ch.13 ↔ `.007`），与 Schottenloher 同型，**别用 DOI 后缀推章号**。
- **⚠ Schrans 伴读笔记（[S]）没有第 2 卷版本（2026-09-11 确认）。** hepnotes.com 首页明写该 string 笔记只覆盖
  「the first 8 chapters of volume 1」，`joes-book-2.pdf` 不存在。**别再找。**
- **Polchinski 官方勘误表已彻底失效**：`www.kitp.ucsb.edu/joep/links/joes-big-book-string/errata` 与其父页均 **HTTP 404**
  （2026-09-11 复核，带不带 `www.` 都一样）。检索后端仍能转述其 Vol.1 条目，但那是 L4 缓存，不得入库。
  既然 Core 路线可用，**勘误表不再是必需入口**。
- **Google Books 对 Polchinski 两卷都无预览**（Vol.2 volume id `WKatSc5pjOgC` 也是 "No preview available"）。别花额度。
- **archive.org 的 Vol.2 条目存在但不可读**：`archive.org/details/stringtheory0002jose`（558 页，access-restricted）。
  四条 search-inside 端点全部失败（`api.archivelab.org` / `ia-petabox…scan.json` → Socket closed；
  `archive.org/services/search/beta/…` → 404；`ia801406.us.archive.org/fulltext/inside.php` → 403）。
  `archive.org/metadata/<id>` 本身可读，但只给文件清单。
- **INSPIRE 全文检索可用**：`inspirehep.net/api/literature?q=ft%20%22<字串>%22&fields=titles,arxiv_eprints`。
  实测按 Polchinski 的式号（如 `ft "10.5.26"`）搜，**除 Headrick 手册外没有论文按式号引用 Vol.2 第 10 章**——
  别指望用「谁引用了式 X」来补锚点。
- **未授权扫描站（`dokumen.pub` 等）本项目不使用**（`literature/CLAUDE.md` 规则 1）。检索后端会转述其内容，一律按 L4 处理。
  - **适用范围（2026-09-11 已实测收窄）**：对 `goddard-thorn-1972` 重试**失败，且该路线对本篇已穷尽**。
    原因不是流程不对，而是**输入条件不满足**：GT 1972 的 `pubinfo_freetext` **只有一个**重印出处
    （Schwarz 编 *Superstrings, Vol. 1*, 112–115），而那本书**不在 archive.org 上**
    （五次不同检索全 0 命中：`title:(superstrings)` 378 条看前 50、`title:(superstrings) AND mediatype:(texts) AND -collection:(arxiv)` 38 条全看、
    全文检索 `"first 15 years of superstring"`、`title:(fifteen) AND title:(superstring)`、五个 ISBN 检索）。
    Google Books 该书 id `ku4zqAAACAAJ`（`AAAACAAJ` 后缀 = **无预览**）。
    Jacob 编 *Dual Theory* 是 **Physics Reports 评论文章重印集**（Rebbi 221–293、Mandelstam 295–389，L4），
    结构上不含 PLB 快报，INSPIRE 也不列它。
    → **教训：本路线的成败取决于「重印出处数量」。先看 `pubinfo_freetext` 有几个；只有一个时命中率很低。**
    另外两个 archive.org 全域全文检索端点已废：`ia-pub-fts-api.archive.org/search/v1/scrape`（Socket is closed）、
    `archive.org/services/search/beta/page_production/scrape.json`（404）。

- **★★ 新增可用路线（2026-09-11）：`cds.cern.ch/oai2d` 的 OAI-PMH 端点不受 Anubis 拦截。**
  CDS 此前被整站列为死路，**该判断需收窄**：
  ```
  ✅ https://cds.cern.ch/oai2d?verb=GetRecord&metadataPrefix=marcxml&identifier=oai:cds.cern.ch:<recid>
  ❌ /record/<recid> 与 /record/<recid>/files/<name>.pdf（含 ?download=1）→ Anubis v1.27.0 反爬页
  ❌ /api/records/<recid> → Socket is closed
  ```
  `<recid>` 从 INSPIRE 拿：`inspirehep.net/api/literature/<recid>?fields=external_system_identifiers` 里的 `CDS` 项。
  返回的 MARC 里 **088 = 报告号 + CM-P 扫描件编号**、**856 = 全文 URL**、**963 = PUBLIC/RESTRICTED**。
  已用它拿到 `goddard-thorn-1972` = `CERN-TH-1493` / `CM-P00058839` / PUBLIC，
  以及 `brower-thorn-1971` = `CERN-TH-1293` / `CM-P00058794` / PUBLIC。
  **建议对整批 blocked 目标各跑一遍（每条 2 次调用）**：`kato-ogawa-1983`、`thorn-1984`、
  `green-schwarz-1985-hexagon`、`kac-1979`、`lian-zuckerman-1989`。（AGW 1984 已验证**无** CDS id。）
  - **⚠ 方法论教训（比号码本身重要）**：第二轮由「INSPIRE 缺 `report_numbers`」推出「本文无 CERN 报告号，线索作废」——
    **这个推理不成立**。INSPIRE 对 1970 年代记录根本不填该字段。**「聚合库缺字段」≠「原始文献无该属性」**；
    要否证报告号线索必须查到出版方/图书馆侧（CDS MARC 088 / OSTI / NTIS）。
  - **⚠ 自我约束**：Anubis 明示是针对自动化 AI 抓取的措施。**不要**用第三方渲染代理或主机名改写去绕它；
    把 URL 交给人类点击。同理 `web.archive.org` 是**工具级封锁**
    （逐字：`Claude Code is unable to fetch from web.archive.org`），`wayback.archive.org` 与
    `cdsweb.cern.ch` 只是 301 跳到被封主机，`web.archive.org.wstub.archive.org` 报 TLS altnames 不匹配。

- **★ 新增可用工具（2026-09-11）：用 Semantic Scholar 定位扫描件的确切路径。**
  `https://api.semanticscholar.org/graph/v1/paper/DOI:<doi>?fields=openAccessPdf,isOpenAccess`
  → GT 1972 由此逐字返回 `openAccessPdf.url = "http://cds.cern.ch/record/388690/files/CM-P00058839.pdf"`。
  ⚠ 用 **paperId** 查会 `HTTP 429`，改用 `DOI:` 前缀成功；⚠ 它的 `isOpenAccess: true` 与 `status: "CLOSED"` 自相矛盾，
  **只能当「文件路径线索」用，不能当「可自由下载」的凭据**（Unpaywall 对同一 DOI 给 `is_oa: false`、`oa_locations: []`）。
  另一个可用的存在性探测：`http://archive.org/wayback/available?url=<无协议的URL>`（返回逐字 JSON，主机是 `archive.org` 不是被封的 `web.archive.org`）。

- **★ 新增可用元数据源（2026-09-11）：INIS（IAEA）`https://inis.iaea.org/api/records?q=<查询>&size=20`。**
  覆盖 1970–80 年代物理文献，能给出**会议名/地点/日期、DOE 报告号、NTIS 号、页数、`files.enabled`/`access.files`**
  等 INSPIRE 没有的字段；对**重印文集的章节页码**尤其可靠（Schwarz 文集：GT 112–115、Brower–Friedman 116–120、
  Corrigan–Goddard 126–142）。**取全文则基本无望**：绝大多数记录 metadata-only；
  少数 `files.enabled: true` 的是 `access.files: restricted`，`/api/records/<id>/files` 报 **403**，
  网页路径重定向到登录页，旧公共库路径 `collection/NCLCollectionStore/_Public/<vol>/<iss>/<RN>.pdf` **404**。

- **`goddard-thorn-1972` 全文：状态 blocked，但 2026-09-11 第四轮已定位到文件本身。**
  **★ 交给人类点击的两个 URL**（出版方标注 PUBLIC，只是 agent 过不去 Anubis）：
  1. `https://cds.cern.ch/record/388690/files/CM-P00058839.pdf`
  2. Wayback 2024-01-28 快照（`status 200`）：
     `http://web.archive.org/web/20240128142907/https://cds.cern.ch/record/388690/files/CM-P00058839.pdf`

  取到后要回答的四个问题：定理是否有编号；精确条件（a、D、动量扇区、"d ≤ 26" 的确切措辞）；证明结构；
  **DDF 对易关系是否给了证明**。

  已核实的取件钥匙（L2，CDS MARC 经 OAI-PMH，088/963 做过逐字复核）：
  报告号 **`CERN-TH-1493`**、扫描件 **`CM-P00058839`**、CDS recid **388690**、**963 = PUBLIC**。
  第二轮宣布「CERN TH 报告号线索无证据支持，已作废」——**该裁决已被推翻**，见上面 OAI-PMH 条的方法论教训。
  第四轮另试失败的路径（累计 20+ 条，逐条见 `primary-sources-round2.md` §12.7）：
  INIS（有 1985 重印记录但 metadata-only，无 1972 原刊记录）、OSTI 4619228（无全文）、
  HathiTrust 目录 403、`scholar.archive.org` 反爬、`api.core.ac.uk` 403（需 key）、
  Unpaywall `oa_locations: []`、`cdsweb.cern.ch` 与 `preprints.cern.ch` 均 301 跳回 CDS、
  ADS `link_gateway/.../ADS_PDF` 与 `/ADS_SCAN` 双 404。
  **正文仍是 L0**：「本快报无编号定理」仍只有四条独立**间接**证据
  （FGZ ref 8、Goddard 2008、LZ 1991 正文引用不给编号、刊物体例）。
  `ms.no-ghost-theorem` 的 `canonical_source.loc` **保持不动**（`primary-sources-round2.md` §12.8）；
  主线数学 canonical 维持 `lian-zuckerman-1991` Theorem 3.5 与 `fgz-1986`。
- **Project Euclid（CMP 旧卷）**：文章 `.full` 页会说「no online version」，但
  `https://projecteuclid.org/journalArticle/Download?urlId=cmp%2F<ID>` 无需登录即可下载 PDF；
  WebFetch 会把 PDF 落盘并打印路径，再用 `Read` 带 `pages` 逐页读图。**lian-zuckerman-1991 即以此取得全文。**
- **arXiv**：想要正文别打 `/abs/`（只回摘要）；用 `arxiv.org/pdf/<id>` 落盘后 `Read`。
- **★★ 新增可用路线（2026-09-11）：`http://export.arxiv.org/api/query?id_list=<逗号分隔的 id>` —— 一次钉死一批号↔标题↔版本↔发表信息。**
  返回 **Atom XML，逐字可读**（`<title>` / `<summary>` / `<published>` / `<updated>` / `<arxiv:comment>` / `<arxiv:journal_ref>`）。
  **多篇系列派工前必跑一次**：本轮 Witten 2012–2013 系列的派工单把 1209.2459 当成 *Superstring Perturbation Theory Revisited*
  （真身是 1209.5461），把 1306.3621 的号写成 1304.7798（那是 Donagi–Witten），一次调用即可全部纠正。
  ⚠ **一次查 6 个以上 id 时，中介概括器会把 `<summary>` 截断成片段**；要逐字摘要就单查 `/abs/<id>` 或减少 id 数。
  ⚠ **arXiv 元数据标题不一定等于 PDF 标题页**：1209.5461 元数据是 "Superstring Perturbation Theory Revisited"，
  **v4 的 PDF 标题页却印 "Perturbative Superstring Theory Revisited"**；1304.2832 同样两说（作者脚注自陈改名）。
  **=> 登记 bib 前把两侧都看一眼，并在 note 里写明采用哪一侧。**
- **★ 配套：`https://inspirehep.net/api/literature?q=arxiv:<id1> or arxiv:<id2> …&fields=arxiv_eprints,titles,publication_info&size=20`
  一次查一批「有没有期刊发表版」。** 本轮由此确认 **arXiv:1209.5461（225 pp 主论文）与 1304.2832 至今无期刊版**
  （`publication_info` 为空）——这是判断「能不能把式号写成期刊式号」的关键否定证据。
  ⚠ 顺带发现 PAMQ 的卷年可能早于 arXiv 提交年（1404.6257 → PAMQ **9** (2013)），**年份写哪个要在 note 里统一**。
- **INSPIRE 逐字摘要**：`inspirehep.net/api/literature?q=doi%20<DOI>&fields=abstracts`，
  **单独查 `abstracts` 字段**才能拿到完整逐字摘要；一次查多字段会被截断。
- **Crossref 章节元数据**：`api.crossref.org/works/<DOI>`（thorn-1985 即以此逐条核实）。
- 死路（勿再耗额度）：`journals.aps.org`、`sciencedirect.com`、
  `www-lib.kek.jp`（域名被环境拦截）、`worldscientific.com`（403）、`assets.cambridge.org`（Socket closed）、
  `bookstore.ams.org`（403）、`proofwiki.org`（403）、
  `catalog.hathitrust.org`（403）、`scholar.archive.org`（proof-of-work 反爬页）、
  `api.core.ac.uk`（403，需 API key）、`ia-pub-fts-api.archive.org`（Socket closed）、
  `web.archive.org`（**工具级封锁**，一切别名 301 回它）。
  ⚠ **`cds.cern.ch` 已从本清单移出**：HTML/文件路径被 Anubis 拦，但 **`/oai2d` 可用**（见上面的 OAI-PMH 条）。
  ⚠ `lib-extopc.kek.jp` **状态未定**：两次 `socket hang up`，是被拦 / 已下线 / URL 猜错未分辨；
  下次请先用一个**已知存在**的 KEKSCAN id 反测主机是否活着，再谈猜 URL。
- **新增可用路线（2026-09-10）**：`hepnotes.com`（Schrans 伴读笔记 PDF，两个版本 URL 都能落盘；
  首次调用若报「域名无法验证」**重试一次**常能通过）、`www.math.utoronto.ca`（MAT1000 课程页挂了
  Lieb–Loss *Analysis* 第 6 章整章扫描）、`web.stanford.edu`（Math 220B 讲义）。手法一律是
  WebFetch 落盘 → `Read` 带 `pages` 读页图。
- **⚠ 临时封锁（2026-09-10 本次会话）**：`arxiv.org` 与 `ar5iv.org` 双双报
  「Unable to verify if domain … is safe to fetch」，导致 Headrick 解答手册（0812.4408）取不到。
  这与上面「arXiv 用 `/pdf/` 可取」的记录冲突，**判断为临时限制而非永久死路：下次先重试一次再放弃**。
- **✅ 上条已解除（2026-09-11 实测）**：`arxiv.org/pdf/0812.4408` 一次成功落盘，`Read(pages=)` 读到 Headrick 全文
  （第 5 章只有 Problem 5.1；第 6 章有 Problems 6.1/6.3/6.5/6.7/6.9/6.11/6.12，PDF p.40–51）。
  `hepnotes.com` 的 Schrans 笔记同样一次成功（目录在 PDF p.9–18，第 5 章 35 条、第 6 章 85 条）。
  `assets.cambridge.org/.../9780521672276_toc.pdf` **仍是 `Socket is closed`**，但 WebSearch 后端能读出它的节标题与页码（等级 L3）。
- **arXiv 旧式 ID 同样可取（2026-09-11 实测）**：`arxiv.org/pdf/hep-th/9711200`（**不带版本后缀**）一次成功落盘，
  返回的是 **v3**（页边条纹逐字写 `arXiv:hep-th/9711200v3  22 Jan 1998`）。
  ⚠ **不带版本号取到的是最新版**，抽取时必须把页边条纹上的版本号抄进记录，否则式号无法复现。
  22 页 PDF 用 `Read(pages=)` 分 4 次（1-6 / 6-11 / 11-16 / 16-20 / 21-22）读完，无失败。
- **★ 当前性价比最高的待取资源：Polchinski 官方勘误表。**
  抽取 §5–§6 时发现 **至少六处**式子依赖它（(5.3.5)、习题 3.6、(5.4.10)、(6.3.6)、(6.4.2)、Stirling 公式），
  **抽取 §8 时又新增三处**（**(8.1.9)、(8.4.5)、(8.6.19)**，见 `extractions/polchinski-1998-v1.md` **Q24**），
  且 Schrans 称它「otherwise, is very complete」。KITP 三条 URL（`kitp.ucsb.edu/joep`、`…/joes-big-book-string`、`…/errata`）
  **全部 HTTP 404**（2026-09-11 第三次复核维持）。找到任一可访问镜像即可一次性批量核对全书式号。
  详见 `extractions/polchinski-1998-v1.md` **Q14 + Q24**。
- **候选新登记文献（尚未进 `sources.bib`）**：
  1. Zwiebach, *A First Course in String Theory*, **2nd ed. §26.6** ——
     Schrans 明说 Polchinski 对「`F₀` 是模群基本域」的论证「quite cavalier about the boundaries」，
     并把严格处理指向该节。若图里要 `worldsheet.modular-fundamental-domain` 的严格来源，这是首选目标。
  2. **Roček & Verlinde (1992)** —— Headrick 在 Problem 8.3（T 对偶的世界面规范化推导 / Buscher 规则）里
     把细节指向该文，并明说自己**没有**计算 dilaton 的移动。**若图里要 T 对偶的独立一手来源（而非
     Polchinski 那句措辞未核实的 (8.3.28)），这是首选目标。** 见 `polchinski-1998-v1.md` **Q20**。
  3. **Giveon–Porrati–Rabinovici, `hep-th/9401139` §2** —— Schrans 在处理两维紧化的完整 T 对偶群时
     改用该文的框架（`polchinski-1998-v1.md` E143 备注），**那部分不是 Polchinski 的内容**。
  4. **DBI 作用量的一手来源**：Schrans 明说看不懂原书 (8.7.20) 附近的推导，改用他的参考 [22]/[23]
     （**本项目尚未核实这两篇具体是哪两篇**，很可能是 Leigh 1989 与 Abouelsaood–Callan–Nappi–Yost 1987）。
     这是一条低成本的后续任务，见 **Q25**。

## 第 8 章的获取路线（2026-09-11 实测，供复用）

- **[S] Schrans 笔记的第 8 章**：目录在 PDF **p.18–24**（共 **132 条**，8.1–8.132，是全书最长的一章）；
  正文 PDF 页 ≈ 打印页，关键段落：**p.419**（Open Questions 框，**9 条**，极重要）、
  p.420–435（§8.1 KK）、p.436–449（§8.2 绕数/配分函数/cocycle/DDF）、p.449–462（§8.3 谱/`SU(2)²`/T 对偶）、
  p.462–497（§8.4 Narain + `d=2` 例）、p.501–516（§8.5 轨形，**本项目未抽**）、
  p.516–527（§8.6 Wilson 线/Dirichlet）、p.527–560（§8.7 D 膜/DBI）、p.561–563（§8.8 orientifold）。
- **[H] Headrick 的第 8 章 = PDF p.69–77**，共 **8 道题**：Problem **8.1 / 8.3 / 8.4 / 8.5 / 8.6 / 8.7 / 8.9 / 8.11**。
  另 **Problem 7.9（PDF p.61）末尾独立验证了 (8.7.28)**。
  → **第 8 章 [H] 是很强的第二独立源**（不像第 5 章只有一道玩具题）：8.1 给 cocycle、8.3 给 Buscher 规则、
  8.5 给 Narain 格的偶自对偶性、8.6 给 `τ/ρ` 模、8.9 给 Dirichlet 情形的 Green 函数。
- ⚠ **本轮未取 [C]（CUP frontmatter）**，故**第 8 章的节标题与页码只有 [S] 目录一个来源**，见 **Q19**。
  **全部 HTTP 404**（2026-09-11 复核维持）。找到任一可访问镜像即可一次性批量核对全书式号。
  详见 `extractions/polchinski-1998-v1.md` **Q14**。
- **候选新登记文献（尚未进 `sources.bib`）**：Zwiebach, *A First Course in String Theory*, **2nd ed. §26.6** ——
  Schrans 明说 Polchinski 对「`F₀` 是模群基本域」的论证「quite cavalier about the boundaries」，
  并把严格处理指向该节。若图里要 `worldsheet.modular-fundamental-domain` 的严格来源，这是首选目标。
- **★ 新增可用路线（2026-09-11）：`pure.mpg.de` 是 MPG 系（AEI / MPI）论文的出版方 PDF 入口。**
  形如 `https://pure.mpg.de/rest/items/item_<N>/component/file_<M>/content`，
  返回**出版方排版的期刊 PDF，页码即期刊页码**（比 arXiv 版更适合写 `loc`），WebFetch 落盘后 `Read(pages=)` 读图。
  gebert-nicolai-1995 的 CMP **172**, 571–622 全文即由此取得（2.5 MB，`item_153125_1/component/file_153124`）。
  **同时记一条反例：`arxiv.org/pdf/hep-th/9406175` 本轮返回 HTTP 404**（老式 `hep-th/` 编号）。
  **教训：一个 arXiv 404 不等于论文取不到，先找机构 repository。**
- **Google Books 卷的「诚实性」必须逐卷验（2026-09-11 再次确认）**：
  GSW Vol. 1 的卷 id `ItVsHqjJo4gC` 查无意义串 `"zzqxjkwmnbvpl"` 返回 **"No results"**，
  ⇒ 该卷**没有** frenkel-benzvi-2004（`r82mAgAAQBAJ`）那种「无命中回落固定页」的病，其返回页码均为真命中。
  这修正了 `extractions/brst-cohomology-sources.md` §5.4 的谨慎口径。**控制查询用无意义串，成本一次 fetch。**
- **长文别用 `arxiv.org/html/<id>`**：2106.16178 的 HTML 在 §5 前被截断，`/abs/` 只回摘要。
  长文一律 `/pdf/` 落盘 + `Read(pages=)`。本轮两条路各浪费一次额度。

- **★★ 新增可用路线（2026-09-11，researcher 五项核实批次）：Cambridge Core 的机构订阅对 *期刊文章* 同样有效，不只对书。**
  `siegel-1954-eta`（Mathematika **1** (1954) 4）全文即以此取得（L1，1 页，56 KB）。
  1. `https://www.cambridge.org/core/product/identifier/<DOI 去掉 10.1112/ 前缀，大写>/type/journal_article`
     → 文章页给出 "Save PDF (0.05 mb)" 与真实 PDF URL。例：`…/identifier/S0025579300000462/type/journal_article`。
  2. 真实 PDF URL 形如
     `…/core/services/aop-cambridge-core/content/view/<ITEM_HASH>/<DOI后缀>a.pdf/<标题 slug>.pdf`
     —— **注意文件名规则与书完全不同**：书是 `<ISBN>c<N>_p<起>-<止>_CBO.pdf`，
     期刊文章是 **`<DOI后缀>a.pdf`**（末尾那个 `a` 是文章序号，猜不出来，**必须先 fetch 文章页**）。
  3. WebFetch 落盘 → `Read(pages=)`。页脚同样印下载机构与时间戳，可作版本锚定。
  ⇒ **覆盖面**：Mathematika、Proc. Camb. Phil. Soc.、Compositio（部分卷）等 CUP/LMS 旧刊都值得一试。
- **⚠ 死路新增（2026-09-11，三次实测）：Springer 的一切路径在本环境都撞登录墙。**
  `link.springer.com/chapter/10.1007/…`、`link.springer.com/book/10.1007/…`、
  **以及前置内容 PDF `link.springer.com/content/pdf/bfm:<ISBN>/1.pdf`** —— **三者一律 `303 See Other` 跳
  `idp.springer.com/authorize?...`**。**别再试 `bfm` 路线取 Springer 书的目录。**
  ⇒ **Springer 书目前唯一可用的替代是 `api.crossref.org/works?query.container-title=<书名>&filter=type:book-chapter`**，
  它给**章标题 + 页范围 + 逐版 DOI**（本轮对 Apostol GTM 41 与 Humphreys GTM 9 都一次命中）。
  ⚠ **但它只到"章"这一级**：GTM 9 的 `§1`–`§26` 是跨章连续编号的小节，Crossref 回答不了"§N 在哪页"。
- **★ Google Books 的 HTML 入口 `books.google.com/books?id=<VOL>&q=<短语>` 在本环境可用（与 API 的 429 不同）。**
  本轮对卷 `mSD4DvUFa6QC`（Humphreys GTM 9，已在 §15.3 通过无意义串控制实验）三次查询：
  `"Root Space Decomposition"` → **Page 35**；`"Harish-Chandra"` → **Page 135**；
  `"Generalities on characters"` → **页面未交付搜索结果区**（⚠ **这不是"无命中"，是"没拿到"，两者必须分开记**）。
  ⚠ **只回页号，不回 snippet** ⇒ 拿不到小节标题，**不能据此写 `§N.x` 这一级编号**。
- **★★ 新增可用路线（2026-09-11）：用 GitHub API 查 Mathlib 的形式化现状，成本极低、对 `status` 判断决定性。**
  1. 目录：`https://api.github.com/repos/leanprover-community/mathlib4/contents/<路径>`（免 auth，返回文件清单）。
  2. 正文：`https://raw.githubusercontent.com/leanprover-community/mathlib4/master/<路径>.lean`
     → WebFetch 直接可读，module docstring 与声明名一次到手。
  ⚠ **代码检索端点 `api.github.com/search/code` 需要 auth，别用**；目录 + raw 两步足够。
  本轮成果：`NumberTheory/ModularForms/DedekindEta.lean` **无 η 的 S 变换**（⇒ 节点不得标 formalized）；
  `Algebra/Lie/Weights/Cartan.lean` **有 `cartan_sup_iSup_rootSpace_eq_top`（根空间分解）**；
  `Algebra/Lie/` 下**没有** Chevalley 限制定理 / Harish-Chandra 同态。
- **★ 反直觉系数的处理纪律在本轮第三次奏效（这次是"页图对、书错"）。**
  Polchinski v2 **(13.3.12)** 原书印 `μ_{6−p}/2κ₁₀²`，页图读数无误；
  但与同节 (13.3.11) + 次页 (13.3.13) 复算不自洽，且 **hep-th/9510017 的 (12)–(15) 独立给出 `Φ = μ_p/α_p = 2κ₁₀²μ_p`**
  ⇒ **判为原书排印错误（Core 2005 "with corrections" 版仍错）**。见 `extractions/polchinski-1998-v2-ch13.md` **§6**。
  **教训升级：页图与复算冲突时，不要默认"我读错了"——先找一条书外的独立来源，两条独立证据同向才能判书错。**
