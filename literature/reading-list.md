# 待抽取队列

| 优先级 | ref | 范围 | 目标 area | 负责 | 状态 |
|---|---|---|---|---|---|
| P0 | polchinski-1998-v1 | §1–§6（玻色弦、共形规范、光锥量子化、无鬼定理、模空间与一般亏格 FP、树级振幅） | worldsheet | researcher | extracted（二手源，需持原书者核对 E34/E53/E58；**§5–§6 于 2026-09-11 追加 E69–E112**，其中 (6.4.23) Veneziano 表达式与 (6.6.23) 开闭弦关系最需核对，见 Q14 勘误表风险） |
| P0 | lian-zuckerman-1991 | 全文（Thm 2.13/2.25、Cor 2.26/2.28、Thm 3.5） | worldsheet | researcher | **extracted（L1 全文，2026-09-10）** → `extractions/primary-sources-round2.md` §1 |
| P0 | virasoro-lean-2025 | §9–§12 + App. A.2（Heisenberg、Sugawara c=1、Verma/Fock） | worldsheet | researcher | **extracted（L1 全文，2026-09-10）** → `primary-sources-round2.md` §5.2 |
| P0 | fgz-1986 | 全文 | worldsheet | researcher | extracted（L1 全文）→ `brst-cohomology-sources.md` §1 |
| P0 | goddard-thorn-1972 | 全文 | worldsheet | — | **blocked**（2026-09-10 复核维持，见下方备忘第 1 条与 `extractions/primary-sources-round2.md` §2）：十条路径累计失败（ScienceDirect 403 / CDS Anubis + api Socket closed / KEK 域名被拦 / OSTI / Semantic Scholar / archive.org 无重印本 / INSPIRE 无 documents-urls-report_numbers）。只有摘要级（L2）。主线数学 canonical 建议改用 lian-zuckerman-1991 与 fgz-1986 |
| P0 | brower-1972 | 全文 | worldsheet | — | **blocked**：APS 全站 403，INSPIRE 无 preprint。只有摘要级（L2） |
| P1 | thorn-1984 | 全文（Kac 行列式 + 更一般设定下的无鬼定理） | worldsheet | 待分派 | **queued（高价值）**：a<1 分支物理侧原始出处的最强候选；Elsevier 403，钥匙是报告号 UFTP-84-004 |
| P1 | kato-ogawa-1983 | 全文（是否给出 Ker Q_B / Im Q_B ≅ OCQ 物理态 的同构） | worldsheet | 待分派 | queued：ScienceDirect 403，未找到扫描件；钥匙是报告号 KUNS 637。摘要已逐字（L2） |
| P1 | thorn-1987 | 全文 | worldsheet | 待分派 | queued（优先级下调）：摘要已逐字，**不含 a<1 / D≤25**，不再是 a<1 分支的首选目标 |
| P2 | gsw-1987-v1 | §2.3.3（无鬼定理与 spectrum-generating algebra，p.102–112） | worldsheet | researcher | **attempted, still blocked（2026-09-11）** → `extractions/gsw-1987-v1.md` §1。正文仍一字未获取，**式号内容全为 L0，不得写进图**。本轮唯一进展：Google Books 卷 `ItVsHqjJo4gC` **通过无意义串控制**（诚实卷），新增式号→页码映射 (2.3.42)→102 / (2.3.52)→105 / (2.3.62)→107 / (2.3.72)→108，故 §2.3.3 起于 (2.3.42) 附近、DDF 定义落在 (2.3.42)–(2.3.52) 区间。**建议不再为此耗额度**：两条 DDF 对易关系已由下面三条来源覆盖 |
| P0 | goddard-2008 | §5「Spectrum Generating Algebra」+ §6「No-Ghost Theorem」 | worldsheet | researcher | **extracted（L1 全文，2026-09-11）** → `extractions/gsw-1987-v1.md` §2。**★ 两条 DDF 对易关系的逐字来源：(5.4) `[L_m,A^i_n]=0`（对 m 无限制）、(5.5) `[A^i_m,A^j_n]=mδ^{ij}δ_{m,−n}`；定义 (5.1)–(5.3)；号差 (−,+,+,+) 与 conv 一致无需换算。** 限制：历史综述，陈述无证明 |
| P0 | tomassini-2008 | §2.2–§2.3（DDF 算子的算子论处理） | worldsheet | researcher | **extracted（L1 相关章节，2026-09-11）** → `extractions/gsw-1987-v1.md` §3。**★★ 唯一带编号定理 + 完整证明的来源：Theorem 2.4 / eq. (2.38) 一次给出六条关系，含图中缺口 `(A^i_n)†=A^i_{−n}` 与「有限和 ⇒ 良定义」。** ⚠ 用的是**修改版** DDF（作者自陈 fundamentally different），`[L_m,A^i_n]=0` 只对 **m≠0**，引用必须带 §5 的解释 |
| P0 | gebert-nicolai-1995 | §2.1（顶点代数公理）+ §3.1–§3.3（离散 DDF 构造） | worldsheet | researcher | **extracted（L1 相关章节，2026-09-11）** → `extractions/gsw-1987-v1.md` §4。**★★ 升级到 rigorous 的最佳路径：(2.57) 把「权 1 primary 的零模与所有 L_n 对易」化为顶点代数恒等式，链条 (2.36) 公理 ⇒ (2.38) ⇒ (2.41) ⇒ (2.57)，全程形式级数、无围道形变。** 另 (3.4) 显式保留 k(0)，回应了「右端为何无 α'/k·p 因子」；摘要与 §3.1 p.595 明写 non-summability（但机制是纵向的，勿误引） |
| P1 | polchinski-1998-v2 | §10–§12（超弦、GSO、反常） | worldsheet, consistency | 待分派 | queued |
| P1 | green-schwarz-1984 | 全文 | consistency | 待分派 | queued |
| P2 | brower-goddard-1972 | 全文（Nucl. Phys. B40, 437–444） | worldsheet | 待分派 | **queued（新，2026-09-11，高价值）**：goddard-2008 §5 把 `[A^i_m,A^j_n]=mδ^{ij}δ_{m,−n}` **归给本文与 brower-goddard-1973，不归给 GT 1972**。元数据仅 L1 转抄自 Goddard 参考文献 [44]，内容 L0。与 brower-1972（PRD 6, 1655，单作者）**是不同论文** |
| P2 | brower-goddard-1973 | 全文（Enrico Fermi Course LIV, 98–110） | worldsheet | 待分派 | **queued（新，2026-09-11）**：同上，Goddard 的 [43]。会议论文集，获取难度高 |
| P2 | ddf-1972 | Del Giudice–Di Vecchia–Fubini, Ann. Phys. **70** (1972) 378–398 | worldsheet | 待分派 | **候选，尚未进 `sources.bib`**：A^i_n 的原始出处（goddard-2008 [42]、gebert-nicolai-1995 [11] 均如此引）。本轮未尝试获取 |
| P2 | moeller-2024 | arXiv:2408.07597, §3（no-ghost theorem） | worldsheet | 待分派 | **候选，尚未进 `sources.bib`，仅 L4**：检索中介报告有 Lemma 3.1 / Lemma 3.2 / **Theorem 3.3 (no-ghost)** 与 eq. (3.1)–(3.8)，把 Lemma 3.1/3.2 归给 Borcherds 1992 Lemmas 5.1/5.2/5.3/5.5。**但用的是 Borcherds 的 K_α(n)/E_α，不是 DDF A^i_n；正文未读，编号不得写进图** |
| P2 | kac-raina-1987 | 自由玻色子 Fock 空间上 Virasoro c=1 的 Lecture 与命题号 | worldsheet | 待分派 | queued：需持**第 1 版**原书者核对（第 1 版约 12 讲 / 第 2 版 18 讲，编号不可互换）。已有可替代来源 virasoro-lean-2025 Thm 10.1 / Cor 10.2 |
| P2 | kac-kazhdan-1979 | Kac 行列式公式 | worldsheet | 待分派 | queued：`worldsheet.kac-determinant` 的候选一手来源，终页与标题单复数未核对 |
| P2 | thorn-1985 | 全文（MSRI 论文集章节，pp. 411–417） | worldsheet | 待分派 | queued：与 thorn-1984 易混（引作「Thorn 1984」），登记以区分。**元数据获 L1 独立佐证（2026-09-11）**：goddard-2008 参考文献 [32] 逐字「C.B. Thorn, *A proof of the no-ghost theorem using the Kac determinant,* in *Vertex Operators in Mathematics and Physics* ed. J. Lepowsky, S. Mandelstam and I.M. Singer (Springer-Verlag, New York, 1985) 411-417.」 |
| P2 | brower-thorn-1971 | 全文（「D>26 出鬼」的归属争议） | worldsheet | 待分派 | queued：Goddard 2008（L3）与本文摘要（L2）矛盾未裁决 |
| P2 | lian-zuckerman-1989 | 全文（RNS 超弦 / super-Virasoro） | worldsheet | 待分派 | queued：Springer 登录墙；**注意它不能用于玻色弦结论**。可试 lian-zuckerman-1991 成功用的 Project Euclid 端点 `journalArticle/Download?urlId=cmp%2F1104179468` |
| P2 | maldacena-1997 | 全文 | holography | 待分派 | queued |

## 已知获取路线备忘

- **`goddard-thorn-1972` 全文：状态 blocked（2026-09-10 复核，维持）。** 第二轮又试**四条新路径，全部失败**：
  (1) INSPIRE 记录 74899 的 `documents` / `urls` / `report_numbers` **三个字段均不存在**（即 INSPIRE 侧无全文，
  且「CERN TH.1471 左右的报告号」这条旧线索**无证据支持，已作废**）；(2) `cds.cern.ch/api/records/388690` → `Socket is closed`；
  (3) KEK：`www-lib.kek.jp` 域名被环境拦截，`lib-extopc.kek.jp/preprints/PDF/...` 这套 URL 虽可被索引但 1972 年未命中（KEK 扫描库 pre-1975 覆盖很薄）；
  (4) archive.org 高级检索 Schwarz 编 *Superstrings: The First 15 Years*（内含本文重印 pp.112–115）与 GSW Vol. 1，均 `numFound: 0`。
  **详见 `extractions/primary-sources-round2.md` §2。** 现有只到摘要级（L2）；
  「本快报无编号定理」已有四条独立间接证据（FGZ ref 8、Goddard 2008、LZ 1991 正文引用不给编号、刊物体例）。
  主线数学 canonical 建议改用 `lian-zuckerman-1991` Theorem 3.5 与 `fgz-1986`。
- **Project Euclid（CMP 旧卷）**：文章 `.full` 页会说「no online version」，但
  `https://projecteuclid.org/journalArticle/Download?urlId=cmp%2F<ID>` 无需登录即可下载 PDF；
  WebFetch 会把 PDF 落盘并打印路径，再用 `Read` 带 `pages` 逐页读图。**lian-zuckerman-1991 即以此取得全文。**
- **arXiv**：想要正文别打 `/abs/`（只回摘要）；用 `arxiv.org/pdf/<id>` 落盘后 `Read`。
- **INSPIRE 逐字摘要**：`inspirehep.net/api/literature?q=doi%20<DOI>&fields=abstracts`，
  **单独查 `abstracts` 字段**才能拿到完整逐字摘要；一次查多字段会被截断。
- **Crossref 章节元数据**：`api.crossref.org/works/<DOI>`（thorn-1985 即以此逐条核实）。
- 死路（勿再耗额度）：`cds.cern.ch`（含 `/api`）、`journals.aps.org`、`sciencedirect.com`、
  `www-lib.kek.jp`（域名被环境拦截）、`worldscientific.com`（403）、`assets.cambridge.org`（Socket closed）、
  `bookstore.ams.org`（403）、`proofwiki.org`（403）。
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
- **★ 当前性价比最高的待取资源：Polchinski 官方勘误表。**
  抽取 §5–§6 时发现 **至少六处**式子依赖它（(5.3.5)、习题 3.6、(5.4.10)、(6.3.6)、(6.4.2)、Stirling 公式），
  且 Schrans 称它「otherwise, is very complete」。KITP 三条 URL（`kitp.ucsb.edu/joep`、`…/joes-big-book-string`、`…/errata`）
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
