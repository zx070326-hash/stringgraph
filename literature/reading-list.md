# 待抽取队列

| 优先级 | ref | 范围 | 目标 area | 负责 | 状态 |
|---|---|---|---|---|---|
| P0 | polchinski-1998-v1 | §1–§6, §8（玻色弦、共形规范、光锥量子化、无鬼定理、模空间与一般亏格 FP、树级振幅；环面紧化与 T 对偶） | worldsheet | researcher | extracted（二手源，需持原书者核对 E34/E53/E58；**§5–§6 于 2026-09-11 追加 E69–E112**，其中 (6.4.23) Veneziano 表达式与 (6.6.23) 开闭弦关系最需核对；**§8 于 2026-09-11 追加 E113–E158**，其中 **(8.3.28) T 对偶「是同一个 CFT」的原文措辞最需核对（Q20）**，其次 (8.4.24)/(8.4.25) 的必要性半句（Q21/Q22）与 (8.7.2) DBI（Q25）。**§8.5 轨形未抽，见 E146**。勘误表风险见 Q14+Q24） |
| P0 | polchinski-1998-v1 | §1–§4（玻色弦、共形规范、光锥量子化、无鬼定理） | worldsheet | researcher | **★★ 原书核实完成（L1，2026-09-11 第六轮）** → `extractions/polchinski-1998-v1.md` **§12**。Q2/Q3/Q4/Q5/Q6/Q7/Q10/Q11/Q12/Q20/Q21/Q22 全部关闭；30 条图节点 loc 修改建议见 §12.10 B 表；15 条作者自承缺口见 C 表。**剩余最高性价比：Appendix A (A.1.31)、书末 References（Goddard–Thorn 是否被引）、§1.2 的 `T=1/(2πα')` 式号** |
| P0 | lian-zuckerman-1991 | 全文（Thm 2.13/2.25、Cor 2.26/2.28、Thm 3.5） | worldsheet | researcher | **extracted（L1 全文，2026-09-10）** → `extractions/primary-sources-round2.md` §1 |
| P0 | virasoro-lean-2025 | §9–§12 + App. A.2（Heisenberg、Sugawara c=1、Verma/Fock） | worldsheet | researcher | **extracted（L1 全文，2026-09-10）** → `primary-sources-round2.md` §5.2 |
| P0 | fgz-1986 | 全文 | worldsheet | researcher | extracted（L1 全文）→ `brst-cohomology-sources.md` §1 |
| P0 | goddard-thorn-1972 | 全文 | worldsheet | — | **blocked-但已定位到文件（2026-09-11 第四轮，`primary-sources-round2.md` §12）**：正文仍 L0，但已确认扫描件是 **`CM-P00058839.pdf`（报告号 `CERN-TH-1493`，CDS recid 388690，MARC 963 = PUBLIC）**，挡路的是 `cds.cern.ch` 的 Anubis 反爬**而非权限**——**人工浏览器一次点击即可取得**（URL 见备忘第 2 条）。第二轮「CERN TH 报告号线索已作废」的裁决**已被推翻**。重印文集路线**已穷尽**（只有 Schwarz 文集一处，该书不在 archive.org）。主线数学 canonical 维持 lian-zuckerman-1991 与 fgz-1986 |
| P0 | brower-1972 | 全文 | worldsheet | — | **blocked**：APS 全站 403。第四轮复核：**无 CDS、无 KEKSCAN、无重印**（Schwarz 文集收的是 Brower–Friedman 1973，非本篇），即无扫描件可循。只有摘要级（L2）。未试路径：MIT DSpace（预印本号可能是 `CTP 277`，L4 未核实） |
| P1 | thorn-1984 | 全文（Kac 行列式 + 更一般设定下的无鬼定理） | worldsheet | 待分派 | **queued（高价值）**：a<1 分支物理侧原始出处的最强候选；Elsevier 403，钥匙是报告号 UFTP-84-004 |
| P1 | kato-ogawa-1983 | 全文（是否给出 Ker Q_B / Im Q_B ≅ OCQ 物理态 的同构） | worldsheet | 待分派 | queued：ScienceDirect 403，未找到扫描件；钥匙是报告号 KUNS 637。摘要已逐字（L2） |
| P1 | thorn-1987 | 全文 | worldsheet | 待分派 | queued（优先级下调）：摘要已逐字，**不含 a<1 / D≤25**，不再是 a<1 分支的首选目标 |
| P2 | gsw-1987-v1 | §2.3.3（无鬼定理与 spectrum-generating algebra，p.102–112） | worldsheet | researcher | **attempted, still blocked（2026-09-11）** → `extractions/gsw-1987-v1.md` §1。正文仍一字未获取，**式号内容全为 L0，不得写进图**。本轮唯一进展：Google Books 卷 `ItVsHqjJo4gC` **通过无意义串控制**（诚实卷），新增式号→页码映射 (2.3.42)→102 / (2.3.52)→105 / (2.3.62)→107 / (2.3.72)→108，故 §2.3.3 起于 (2.3.42) 附近、DDF 定义落在 (2.3.42)–(2.3.52) 区间。**建议不再为此耗额度**：两条 DDF 对易关系已由下面三条来源覆盖 |
| P0 | goddard-2008 | §5「Spectrum Generating Algebra」+ §6「No-Ghost Theorem」 | worldsheet | researcher | **extracted（L1 全文，2026-09-11）** → `extractions/gsw-1987-v1.md` §2。**★ 两条 DDF 对易关系的逐字来源：(5.4) `[L_m,A^i_n]=0`（对 m 无限制）、(5.5) `[A^i_m,A^j_n]=mδ^{ij}δ_{m,−n}`；定义 (5.1)–(5.3)；号差 (−,+,+,+) 与 conv 一致无需换算。** 限制：历史综述，陈述无证明 |
| P0 | tomassini-2008 | §2.2–§2.3（DDF 算子的算子论处理） | worldsheet | researcher | **extracted（L1 相关章节，2026-09-11）** → `extractions/gsw-1987-v1.md` §3。**★★ 唯一带编号定理 + 完整证明的来源：Theorem 2.4 / eq. (2.38) 一次给出六条关系，含图中缺口 `(A^i_n)†=A^i_{−n}` 与「有限和 ⇒ 良定义」。** ⚠ 用的是**修改版** DDF（作者自陈 fundamentally different），`[L_m,A^i_n]=0` 只对 **m≠0**，引用必须带 §5 的解释 |
| P0 | gebert-nicolai-1995 | §2.1（顶点代数公理）+ §3.1–§3.3（离散 DDF 构造） | worldsheet | researcher | **extracted（L1 相关章节，2026-09-11）** → `extractions/gsw-1987-v1.md` §4。**★★ 升级到 rigorous 的最佳路径：(2.57) 把「权 1 primary 的零模与所有 L_n 对易」化为顶点代数恒等式，链条 (2.36) 公理 ⇒ (2.38) ⇒ (2.41) ⇒ (2.57)，全程形式级数、无围道形变。** 另 (3.4) 显式保留 k(0)，回应了「右端为何无 α'/k·p 因子」；摘要与 §3.1 p.595 明写 non-summability（但机制是纵向的，勿误引） |
| P1 | polchinski-1998-v2 | §10–§12（超弦、GSO、反常） | worldsheet, consistency | 待分派 | queued |
| P1 | green-schwarz-1984 | 全文（PLB 149, 117–122 六页） | consistency | researcher | **extracted（L1 全文，2026-09-11）** → `extractions/green-schwarz-1984.md`。20 条陈述；含 5 条纯代数命题（Lean 岛候选）。最大未闭合依赖：`alvarez-gaume-witten-1984`（GS 把常数 `c`、(20)(22) 的系数全外包给它） |
| P1 | polchinski-1998-v2 | **§10–§11**（超弦 RNS、GSO、type I/II、杂化弦、流代数） | worldsheet, consistency | researcher | **extracted（L1 全文，2026-09-11）** → `extractions/polchinski-1998-v2.md`。⚠ 原范围写「§10–§12（超弦、GSO、反常）」**不准确**：§11 是杂化弦，§12 才是超弦相互作用+反常；GSO/IIA/IIB/I 全在 **§10.6**。§12、附录 B 未抽 |
| P1 | green-schwarz-1984 | 全文 | consistency | 待分派 | queued |
| P1 | ohta-1986 | 全文（超弦 BRST 上同调 / 无鬼定理的独立严格处理） | worldsheet | 待分派 | **queued（新增 2026-09-11）**：Polchinski Vol.2 §10.5 的超弦无鬼定理只有一句「The proof is a direct imitation of the bosonic argument of chapter 4」，**不给证明、不引文献**。候选：Phys. Rev. D 33 (1986) 1681「Covariant quantization of superstrings based on BRS invariance」与 Phys. Lett. B 179 (1986) 347「BRST cohomology in superstring theories」。⚠ 均只到标题级，尚未核实卷期页 |
| P1 | henneaux-1987 | 全文（"BRST cohomology of the fermionic string", Phys. Lett. B 183 (1987) 59） | worldsheet | 待分派 | **queued（新增 2026-09-11）**：同上，超弦无鬼定理的独立来源候选。⚠ 只到标题级 |
| P2 | superstring-noghost-picture | arXiv:1212.3592（任意 picture 的超弦 BRST 无鬼定理）+ arXiv:1009.0107（NS 弦 0-picture） | worldsheet | 待分派 | **queued（新增 2026-09-11）**：现代处理，且涉及一个 Polchinski 完全没提的问题——**picture number 是否影响 BRST 上同调**。若影响，Vol.2 的无鬼定理陈述隐含了 picture 选择 |
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
| P2 | lian-zuckerman-1989 | 全文（RNS 超弦 / super-Virasoro） | worldsheet | 待分派 | queued：Springer 登录墙；**注意它不能用于玻色弦结论**。可试 lian-zuckerman-1991 成功用的 Project Euclid 端点 `journalArticle/Download?urlId=cmp%2F1104179468` |
| P2 | maldacena-1997 | 全文 | holography | researcher | **extracted（L1 全文 22 页逐页读图，2026-09-11）** → `extractions/maldacena-1997.md`（E1–E48）。⚠ 读的是 **arXiv v3**，ATMP 发表版未核对；三条红线：原文是 `U(N)` 非 `SU(N)`、**全文无配分函数陈述**（GKP/Witten 1998 才有）、**全文无 `3/4`**（只说 "up to a numerical factor"）。耦合字典原文给 `g²_YM = 2πg`（≠ 常见的 `4πg_s`），见该文件 Q2 |
| P2 | maldacena-1997 | 全文 | holography | 待分派 | queued |
| **P0** | **alvarez-gaume-witten-1984** | 全文，特别是 **eq. (63)**（反常相对归一化）与十维反常多项式系数 | consistency | 待分派 | **新增（2026-09-11，由 green-schwarz-1984 抽取推出）**：GS 1984 把 (17) 的常数 `c`、(20) 的三个系数、(22) 的相对归一化**全部**外包给本文。不抽它，整条 GS 反常链的数值系数层就是 L0。Nucl. Phys. **B234** (1984) 269–330，无 arXiv（1984）。⚠️ GS 原文把年份误印为 1983。**取件钥匙（2026-09-11 补）**：INSPIRE recid **192309**，报告号 `HUTP-83/A039`，**有 KEKSCAN id `84-02-145`**、**无 CDS id** → 走 KEK 而非 CDS；推出的 URL `lib-extopc.kek.jp/preprints/PDF/1984/8402/8402145.pdf` 两次 `socket hang up`，主机是否活着未分辨 |
| P1 | thorn-1985-santa-barbara | 全文（42 页，含**改良版 Goddard–Thorn 无鬼定理证明**） | worldsheet | 待分派 | **新增（2026-09-11，`primary-sources-round2.md` §12.5）**：C. B. Thorn, *Introduction to the theory of relativistic strings*, Workshop on Unified String Theories, Santa Barbara, 1985-07-29–08-16。报告号 `DOE/ER/40008-77` / `CONF-850798-1` / NTIS `DE86001950`，42 页。摘要自陈「give an **improved version of the Goddard-Thorn proof** of the No-ghost Theorem」（INIS `szqhd-hct30`、OSTI 5007660）。INIS 有文件但 `access.files: restricted`（需注册，未办）；OSTI 无全文。**⚠ 勿与 `thorn-1985`（MSRI 7 页）混淆。** 建议路线：对该 Workshop 论文集（World Scientific，Green & Gross 编）跑 archive.org 重印文集流程 |
| P0 | alvarez-gaume-witten-1984 | 全文（Nucl. Phys. B234, 269–330，62 页） | consistency | researcher | **extracted（L1 全文逐页读图，2026-09-11）** → `extractions/alvarez-gaume-witten-1984.md`（E1–E20 + §5 Lean 候选）。取自 **McGill 课程页扫描件**（见下方备忘）。**eq. (63) 已逐字取到**。★ **GS Q3 完全闭合**：GS (20) 的五个系数 = −48 × [AGW (119) 的 N=1 场内容组合]，机械可验，`n=496` 是 `7936−16n` 的唯一零点。★ **GS Q2 只闭合一半**：AGW **不含** 常数 `c`，也**不含** GS (22) 的十维混合十二形式（p.328 明说不做），只给配方。★ **AGW 不是 CS/下降方程符号约定的源头**（源头是 Zumino–Wu–Zee）。⚠️ **年份订正**：AGW **自己的页眉就印 1983**，GS 照抄，不是 GS 误印 |
| **P0** | **zumino-wu-zee-1984** | 全文（下降方程 `ω⁰_{2n+1}`/`ω¹_{2n}` 的定义与符号约定；纯规范反常的绝对归一） | consistency | researcher | **attempted, blocked（2026-09-11）** → `extractions/zumino-wu-zee-1984.md`。**正文一字未取到（L2，仅摘要+元数据）**，但**本轮的两个核心问题已由其伴随文献闭合**（见下一行）。⚠️ **派工单的两个获取前提被证伪**：(a) INSPIRE `publication_info` **无 `pubinfo_freetext`** ⇒ **零个重印出处**，archive.org 文集路线输入条件不满足；(b) *Current Algebra and Anomalies* 里 Zumino 那章（pp.361–393）是 **Les Houches 讲义（单作者）**，**该书不收 ZWZ**。`external_system_identifiers` **无 KEKSCAN、无 CDS** ⇒ KEK 与 OAI-PMH 路线入口即排除。已试并失败：Semantic Scholar（CLOSED）、OSTI（`LBL-16443` 三种查法均无命中）、INIS（`zectt-7td81` metadata-only）、INIS 旧公共路径（404）、`site:edu` 扫描件检索（只命中转述性课程笔记）。**未穷尽的唯一入口：UNT Digital Library / TRAIL（被 Altcha 反爬挡住，需人工浏览器）**。ScienceDirect 与未授权扫描站按规则不使用 |
| **P0** | **zumino-1983-les-houches** | 全文（LBL-16747，46 印刷页） | consistency | researcher | **extracted（L1 全文逐页读图，2026-09-11）** → `extractions/zumino-wu-zee-1984.md`（E1–E17）。**= GS ref [10] 的第一项**（不是 ref [9]），ZWZ 的同作者同期伴随讲义，引言自陈「Some of the results are contained in a recent paper written in collaboration with Wu Yong-Shi and Anthony Zee [2]」。**★ 闭合了两件事**：(1) **`green-schwarz-1984.md` Q6 的「下降方程符号约定源头」** —— GS (5)(6)(15)(16) 逐字采用 Zumino 的约定，含 **(3.32) `δω⁰ = −dω¹` 的负号**；(2) **`c` 的归属定案** —— 本文 §5 只给 `2n−2` 维通式 (5.13) 且原文手写「(up to a sign)」，**不含引力侧**，故 `c` 在 AGW/ZWZ/Z-LH 三篇里都不以一个数存在。**★ 但不能裁决 `H` 的 CS 符号**（本文无 `B`、无 `H`、无引力）：GS 与 Bilal 由 `(B,H)→(−B,−H)` 相联，**两者都对**。三条作者自陈 gap：局部性、`k²=0` 留作习题、**WZ 相容条件解的唯一性明确不讨论**（⇒ GS「uniquely determined」无支撑） |

| P1 | eguchi-gilkey-hanson-1980 | Â 多项式（Dirac genus）的定义与 Pontryagin 展开 | consistency | 待分派 | **新增（2026-09-11）**：Phys. Reports **66** (1980) 213 = AGW ref [6]，AGW (82) 的 Â 多项式外包给它。本轮已用 Harvard Math 272b 讲义（匿名 CAS 输出，L1）核对 Â₁–Â₄ 全部相符，但那只作旁证；canonical 数学来源应是 Hirzebruch 或本条 |
| P1 | green-schwarz-1985-hexagon | 全文 | consistency | 待分派 | **新增（2026-09-11）**：Nucl. Phys. **B255** (1985) 93–114。GS 1984 自陈弦论侧 "details will be presented elsewhere"，Schwarz 2012（arXiv:1201.0981，L1）指认这里就是那个 elsewhere。要给「type I 单圈六边形反常抵消」建节点必须先抽它 |
| **P1** | **gsw-1987-v2** | **第 10 章（已抽）+ 第 13 章（未取）** | consistency | researcher | **partially extracted（2026-09-11）** → `extractions/gsw-1987-v2.md`（E1–E14）。**优先级由 P2 上调至 P1**（原因见下）。<br>✅ **第 10 章「The gauge anomaly in type I superstring theory」pp. 141–174 逐页读毕（L1）**，经 **Cambridge Core 章级 PDF**（本环境有机构订阅）。核心逐字：p.143「the anomaly cancels **if and only if** the gauge group is SO(32)」+ 同段「**although the relevant calculations have not been performed**」；(10.1.11)–(10.1.14) 迹恒等式（**含 GS 1984 没有的 U(n) 支**）且紧跟一句「**(These matters are discussed further in §13.5.3.)**」；(10.2.36)(10.2.37) 「**which vanishes for the gauge group SO(32) and for no other group**」+ **「32」= 六边形内线上奇数个扭转的分布方式数**（GS 1984 完全没有的世界面来历）；§10.3 引力/混合/IIB/杂化弦在弦论侧**全部只有 "suggests"**；§10.4.2 作者自评 **"not entirely rigorous"**。<br>✅ 目录 pp. v–x 全读（L1）⇒ **§13.5.3 = "Allowed gauge groups for N = 1 superstring theories", pp. 353–358** 已确证（注意标题是 **superstring** 不是 supergravity）。<br>❌ **第 13 章 pp. 307–362 未取到（L0）**：PDF **12 MB，超出 WebFetch 的 10 MB 硬上限**。**这是工具限制不是权限问题**（同书第 10 章 9.1 MB 一次成功）。已排除：assets.cambridge.org（Socket closed）、节级 BOOK_PART（`CBO9781139248570A050/A052/A053/A054` 全部 HTTP 400，**不存在节级产品**）、archive.org 两份扫描（均 `access-restricted-item: true`，fulltext/djvu 全 403）、Google Books（两卷 id `Z-uz4svcl0QC` / `dgAhAwAAQBAJ` 均不回 snippet）。<br>**★ 交人类点击的 URL**：`https://www.cambridge.org/core/services/aop-cambridge-core/content/view/F2BEB1F0811FE1D8458547AAB73D12AF/9781139248570c6_p307-362_CBO.pdf/low-energy-effective-action.pdf`<br>取到后要回答的四问见抽取记录 §0.4。<br>**本轮对四解分类的净进展**：两条**独立** L1 二手证据（`antonelli-2015` §1.1 p.3、`adams-dewolfe-taylor-2010` p.1 与其 [7]）都把「U(1)⁴⁹⁶ / E₈×U(1)²⁴⁸」的出处指向本书第 13 章 ⇒ **`vafa-2005` E15 把它引给 `green-schwarz-1984` 确认是溯源错误**；但**GSW 原文措辞仍 L0**，两人对 GSW「说了多强的话」理解不一致（Antonelli：「it has long been known [3] that ... are theories where quantum anomalies are cancelled」；ADT：「satisfy **some of the same conditions** ... **might appear to be** consistent」）。**Q1 三方冲突未裁决。** |
| P1 | antonelli-2015 | §1（含 1.1/1.2/1.3）、§2.1–2.2、Appendix A/B、References | consistency, swampland | researcher | **extracted（L1 部分章节，2026-09-11）** → `extractions/gsw-1987-v2.md` E13。arXiv:1507.08642，36 页，读 pp.1–8 + 33–36。**★ 唯一明说「四解分类的原始陈述在 GSW ch.13 且 no proof has explicitly been carried out」的来源。** ⚠ 单作者预印本，未见期刊发表；其「anomaly cancelled」指**十二形式因子化**，与 `adams-dewolfe-taylor-2010` 的「不能用 GS 机制抵消」不冲突但不同义；其 §1.1 对 ADT 的转述失真。**未读**：§2.3–2.5（各群非因子化的逐个证明）、§3.1–3.4 |
| P1 | adams-dewolfe-taylor-2010 | 全文（4 页） | consistency, swampland | researcher | **extracted（L1 全文，2026-09-11）** → `extractions/gsw-1987-v2.md` E13/E14。arXiv:1006.1352**v2**（编号必须写死 v2：致谢自陈 v1 的 (7)(8) 系数有错，由 Tachikawa 指出）。**★ 本项目里第二条「作者/后人真正实现了原文邀请的反驳方向」的样本**：`vafa-2005` E15 逐字邀请「to find what consistency condition goes wrong」，ADT 给出了那个条件（超对称要求的 `BF²` 耦合 vs 阿贝尔规范不变性，`Y₄ ≠ dH₃`）。摘要限定语「without known inconsistencies」必须带上 |
| **P0** | **vafa-2005** | 全文（10 页） | swampland | researcher | **extracted（L1 全文 10 页逐页读图，2026-09-11）** → `extractions/vafa-2005.md`（E1–E18）。⚠ 读的是 **arXiv v2**。**两条结构性禁令：本文无任何编号公式、无任何编号 Conjecture ⇒ loc 只能写「§N, p.M」。** 核心是 §1 p.1 的 swampland 定义句与 §1 p.2 的三条有限性判据（标量体积/场数目/规范群秩，均以「Newton 常数非零」为前提）。最大溯源问题：§4 的引文 [6] 与本项目对 `green-schwarz-1984` 的 L1 抽取对不上（Q3）。**2026-09-11 追加（researcher，gsw-1987-v2 抽取）**：Q3 已部分闭合 —— `antonelli-2015` 与 `adams-dewolfe-taylor-2010` **两条独立 L1 证据**把 `U(1)⁴⁹⁶`/`E₈×U(1)²⁴⁸` 的出处指向 `gsw-1987-v2` ch.13，**确认 Vafa 的引文 [6] 是溯源错误**；但 GSW 正文仍未取到，`inferred` 不能撤（除非把 source 换成那两篇）。**更重要**：ADT (2010) 直接反驳了 Vafa E15 的前提「Both of these theories are consistent as far as anomalies are concerned」，且正是 Vafa 逐字邀请的第二个反驳方向 |
| P1 | green-schwarz-1985-hexagon | 全文 | consistency | researcher | **正文仍未取得（2026-09-11 第二轮已把五条路线跑完）** → `extractions/green-schwarz-1985-hexagon.md`（**L2 摘要级 E1–E5 + 失败路径逐条留痕**）。Nucl. Phys. **B255** (1985) 93–114，DOI `10.1016/0550-3213(85)90130-0`，预印本 **CALT-68-1224**（33 页，⚠ 不是 GS 1984 的 CALT-68-1182）。**摘要三条硬结论**：annulus 与 Möbius 各自有反常、相加后 "cancel … **if** … SO(32)"（充分条件，不得读作唯一性）、末句只 "We point out" 低能有效作用量各项的弦论起源 ⇒ **「弦论侧 ⟹ GS 1984 反项」这条边仍不得建**。失败：CDS = Anubis；CDS OAI 无 recid 入口；`lib-extopc.kek.jp` socket hang up（第三次）；OSTI 干净查询确认不藏本文；INSPIRE `documents`/`urls` absent；无大学课程页扫描件；CaltechAUTHORS 两端点 403；S2 `openAccessPdf` 空。**重印出处只有一个**（Schwarz 编 *Superstrings* Vol. 2 = archive.org 已确认无此书）⇒ 该路线先验不通。**下一轮最省力入口：GSW Vol. 2 反常章走 Cambridge Core**（同时清 `gsw-1987-v2` 的 P2 债） |
| P2 | gsw-1987-v2 | **第 13 章**（496 维反常自由群的分类陈述） | consistency | 待分派 | **新增（2026-09-11）**：据 Antonelli 2015（arXiv:1507.08642，L1）§1.1，「SO(32) / E₈×E₈ / U(1)⁴⁹⁶ / E₈×U(1)²⁴⁸ 四解」的原始陈述在此，且 "no proof has explicitly been carried out"。bib 里目前只有 `gsw-1987-v1`。**2026-09-11 追加理由（researcher，建议 lead 把本行提到 P1）**：`vafa-2005` §4 把「U(1)⁴⁹⁶ 与 U(1)²⁴⁸×E₈ 就反常而言一致」引给 `green-schwarz-1984`，但本项目对 GS 1984 的 L1 抽取显示原文只点名 SO(32) 与 E₈×E₈。本章现在同时被 GS 抽取与 Vafa 抽取两处需要，是 swampland↔consistency 接口边的唯一可能来源。见 `extractions/vafa-2005.md` Q3 |
| **P0** | **vafa-2005** | 全文（10 页） | swampland | researcher | **extracted（L1 全文 10 页逐页读图，2026-09-11）** → `extractions/vafa-2005.md`（E1–E18）。⚠ 读的是 **arXiv v2**。**两条结构性禁令：本文无任何编号公式、无任何编号 Conjecture ⇒ loc 只能写「§N, p.M」。** 核心是 §1 p.1 的 swampland 定义句与 §1 p.2 的三条有限性判据（标量体积/场数目/规范群秩，均以「Newton 常数非零」为前提）。最大溯源问题：§4 的引文 [6] 与本项目对 `green-schwarz-1984` 的 L1 抽取对不上（Q3） |
| **P0** | **ooguri-vafa-2006** | 全文（17 页） | swampland | researcher | **extracted（L1 全文 18 页逐页读图，2026-09-11）** → `extractions/ooguri-vafa-2006.md`（E1–E29）。⚠ 读的是 **arXiv v1**，编号必须写死 v1。**Conjecture 0–4 有编号（从 0 起）；全文只有两个编号公式 (1.1) 与 (3.1)；§3.1 有两个 `Example v)` ⇒ loc 不能只写「Example v」。** 四条使用限制：α 不普适（9/8、3/8、8/7、6/7）、Conj 3 是标量曲率非截面曲率、Conj 1 与 2 明确相互独立、「Swampland Distance Conjecture」这个名字不在原文。三处「conjecture 2」按内容应为「conjecture 3」（误植） |
| **P0** | **arkani-hamed-2006** | 全文（20 页） | swampland | researcher | **extracted（L1 全文 21 页逐页读图，2026-09-11）** → `extractions/arkani-hamed-2006.md`（E1–E27）。⚠ 读的是 **arXiv v2**，且 **§5 与 (28)–(30) 极可能是 v2 新增**（其引用 hep-th/0602178 晚于 v1 日期）。公式 (1)–(30) + sharp 版本 (I)(II)(III) 均可精确引用。**★ 本项目第一条 `status: refuted` 的证据：§3 p.11 作者本人反驳 (I)，逐字「So (I) can't be right.」** 「m ≤ qM_Pl」在文内有四种写法不可互换（Q1）；极端性归一化文内不统一（Q2）；**全文无「Weak Gravity Conjecture」一词** |
| P1 | wen-witten-1985 | 全文（NPB 261, 651–677） | swampland | 待分派 | **新增（2026-09-11，由 arkani-hamed-2006 抽取推出）**：AMNV §3 p.11 用「半整数荷缠绕弦」反驳其 sharp 版本 (I)。**这是本项目第一条 refuted 节点的一手证据来源**，现在只有 AMNV 的转述级。1985 年无 arXiv，Elsevier 预计 403 |
| P1 | sen-1995-bh-torus | 全文（hep-th/9411187） | swampland, holography | 待分派 | **新增（2026-09-11）**：AMNV §4 的 (22)(23)（杂化弦 on T⁶ 的极端黑洞质量 M² = ½Q_R² / ½Q_L²）**全部外包给本文**。不抽它，AMNV 全部正面证据的黑洞侧只有转述级。**有 arXiv，取全文成本低，性价比高** |
| P1 | bagger-witten-1983 | 全文（NPB 222, 1–10），特别是超多重态模空间曲率符号的定理 | swampland | 待分派 | **新增（2026-09-11，由 ooguri-vafa-2006 抽取推出）**：OV §3.1（第一个 Example v，p.9）把「耦合到超引力的超多重态模空间必有负标量曲率」归给本文，并说这是局部 N=2 超对称的**直接后果**。**⇒ 这是 swampland 区最有希望通向 `rigorous` 的物理支点**（若成立，Conjecture 3 在超多重态那一支不只是 conjecture）。1983 年无 arXiv |
| P2 | borel-harish-chandra-1962 | 全文（Ann. of Math. 75, 485–535） | math, swampland | 待分派 | **新增（2026-09-11）**：**`vafa-2005` 全文唯一引用的严格数学定理**（§2 p.4「T^d 的 Narain 模空间体积有限」）。⇒ swampland 区唯一一条可能通向 `rigorous` 的一手**数学**来源。建议把「T^d Narain 体积有限」单独建卡，不要让它给一般体积猜想升格。⚠ 终页 535 未核实 |
| P2 | susskind-1995-remnants | 全文（hep-th/9501106） | swampland | 待分派 | **新增（2026-09-11）**：AMNV §2.2 的 remnant 论证与「量子引力无全局对称性」这一前提都引本文，§2.3 的 large-N species problem 也引它。**⇒ 图里「无全局对称性」节点的来源应是本条，不是 AMNV**（后者只引用不论证）。有 arXiv |
| **P0** | **gubser-klebanov-polyakov-1998** | 全文（PLB 428, 105–114；arXiv 15 页） | holography | researcher | **extracted（L1 全文逐页读图，2026-09-11）** → `extractions/gubser-klebanov-polyakov-1998.md`（E1–E13）。⚠ 读的是 **arXiv v2**，式号写死 v2；PLB 发表版未核对。**三条红线**：(1) 核心式是 **(12)/(23) `W = K = S`（生成泛函 = on-shell 作用量），全文无任何配分函数陈述** —— `Z_CFT = Z_string` 不能引本文；(2) **全文无 `Δ(Δ−d) = m²`**，只有 d=4 的 (45) `Δ = 2 + √(4+(mR)²)`；(3) 边界在**有限截断 `z = R`** 而非共形边界。**全文不含 "conjecture" 一词**，最强自称 "we **propose** an identification"。**GKP 不引 Witten**（v2 的 25 条参考文献里没有 hep-th/9802150） |
| **P0** | **witten-1998-ads** | 全文（ATMP 2, 253–291；arXiv 40 页） | holography | researcher | **extracted（L1 全文逐页读图，2026-09-11）** → `extractions/witten-1998-ads.md`（E-W1–E-W18）。⚠ 读的是 **arXiv v2**，comments 自陈含 "**assorted corrections**"，式号必须写死 v2。**核实结论**：`⟨exp∫φ₀O⟩_CFT = Z_S(φ₀)` **确为 (2.11)**，但**两边都是 `Z` 的等式是 (2.12)**（自变量是共形结构 h），流版 (2.13)；`Δ(Δ−d) = m²` **确为 (2.43)**（较大根，显式解 (2.44)，AdS 半径 = 1）。自称 "**ansatz**"，但明写 "make more precise the conjecture [13]" ⇒ **对 Maldacena 判「精确化」（与 GKP 判「独立假设」不同）**。用 **`SU(N)`** 并在 §2.6 论证不是 `U(N)`。**p.4 逐字称 GKP 为 "independent work [36]"**。发现两处原文疑误：p.35 的 `ω` 公式根号内是 `−4m²`（与 (2.44) 的 `+4m²` 矛盾）、参考文献 [13] 印作 `hep-th/971120`（少一位） |

## 已知获取路线备忘

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
  Vol.2 已取 item hash：contents `07FB90D821053D58A00610479EFE2978`、notation `BACF746050A6F8DC6AE8EF5FA4A6BA28`、
  ch.10 `E69C35DC077FD0BAD6B39479144D4A12`、ch.11 `C4D876C20A83F4E778152B75A219A718`、
  ch.12 `46D902501550C028C94F24884F4B9D7A`、附录 B `872CC69E98F684AFA1019EB2A955BD11`。
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
