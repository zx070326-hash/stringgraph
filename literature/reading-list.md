# 待抽取队列

| 优先级 | ref | 范围 | 目标 area | 负责 | 状态 |
|---|---|---|---|---|---|
| P0 | polchinski-1998-v1 | §1–§4（玻色弦、共形规范、光锥量子化、无鬼定理） | worldsheet | researcher | extracted（二手源，需持原书者核对 E34/E53/E58） |
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
