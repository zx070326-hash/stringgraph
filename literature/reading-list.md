# 待抽取队列

| 优先级 | ref | 范围 | 目标 area | 负责 | 状态 |
|---|---|---|---|---|---|
| P0 | polchinski-1998-v1 | §1–§6, §8（玻色弦、共形规范、光锥量子化、无鬼定理、模空间与一般亏格 FP、树级振幅；环面紧化与 T 对偶） | worldsheet | researcher | extracted（二手源，需持原书者核对 E34/E53/E58；**§5–§6 于 2026-09-11 追加 E69–E112**，其中 (6.4.23) Veneziano 表达式与 (6.6.23) 开闭弦关系最需核对；**§8 于 2026-09-11 追加 E113–E158**，其中 **(8.3.28) T 对偶「是同一个 CFT」的原文措辞最需核对（Q20）**，其次 (8.4.24)/(8.4.25) 的必要性半句（Q21/Q22）与 (8.7.2) DBI（Q25）。**§8.5 轨形未抽，见 E146**。勘误表风险见 Q14+Q24） |
| P0 | lian-zuckerman-1991 | 全文（Thm 2.13/2.25、Cor 2.26/2.28、Thm 3.5） | worldsheet | researcher | **extracted（L1 全文，2026-09-10）** → `extractions/primary-sources-round2.md` §1 |
| P0 | virasoro-lean-2025 | §9–§12 + App. A.2（Heisenberg、Sugawara c=1、Verma/Fock） | worldsheet | researcher | **extracted（L1 全文，2026-09-10）** → `primary-sources-round2.md` §5.2 |
| P0 | fgz-1986 | 全文 | worldsheet | researcher | extracted（L1 全文）→ `brst-cohomology-sources.md` §1 |
| P0 | goddard-thorn-1972 | 全文 | worldsheet | — | **blocked**（2026-09-10 复核维持，见下方备忘第 1 条与 `extractions/primary-sources-round2.md` §2）：十条路径累计失败（ScienceDirect 403 / CDS Anubis + api Socket closed / KEK 域名被拦 / OSTI / Semantic Scholar / archive.org 无重印本 / INSPIRE 无 documents-urls-report_numbers）。只有摘要级（L2）。主线数学 canonical 建议改用 lian-zuckerman-1991 与 fgz-1986 |
| P0 | brower-1972 | 全文 | worldsheet | — | **blocked**：APS 全站 403，INSPIRE 无 preprint。只有摘要级（L2） |
| P1 | thorn-1984 | 全文（Kac 行列式 + 更一般设定下的无鬼定理） | worldsheet | 待分派 | **queued（高价值）**：a<1 分支物理侧原始出处的最强候选；Elsevier 403，钥匙是报告号 UFTP-84-004 |
| P1 | kato-ogawa-1983 | 全文（是否给出 Ker Q_B / Im Q_B ≅ OCQ 物理态 的同构） | worldsheet | 待分派 | queued：ScienceDirect 403，未找到扫描件；钥匙是报告号 KUNS 637。摘要已逐字（L2） |
| P1 | thorn-1987 | 全文 | worldsheet | 待分派 | queued（优先级下调）：摘要已逐字，**不含 a<1 / D≤25**，不再是 a<1 分支的首选目标 |
| P1 | polchinski-1998-v2 | §10–§12（超弦、GSO、反常） | worldsheet, consistency | 待分派 | queued |
| P1 | green-schwarz-1984 | 全文 | consistency | 待分派 | queued |
| P2 | kac-raina-1987 | 自由玻色子 Fock 空间上 Virasoro c=1 的 Lecture 与命题号 | worldsheet | 待分派 | queued：需持**第 1 版**原书者核对（第 1 版约 12 讲 / 第 2 版 18 讲，编号不可互换）。已有可替代来源 virasoro-lean-2025 Thm 10.1 / Cor 10.2 |
| P2 | kac-kazhdan-1979 | Kac 行列式公式 | worldsheet | 待分派 | queued：`worldsheet.kac-determinant` 的候选一手来源，终页与标题单复数未核对 |
| P2 | gsw-1987-v1 | §2.3.3（无鬼定理与 spectrum-generating algebra，p.102–112） | worldsheet | 待分派 | queued：Google Books 只回页码不回 snippet，archive.org 无 Vol. 1，式号内容全为 L0 |
| P2 | thorn-1985 | 全文（MSRI 论文集章节，pp. 411–417） | worldsheet | 待分派 | queued：与 thorn-1984 易混（引作「Thorn 1984」），登记以区分 |
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
