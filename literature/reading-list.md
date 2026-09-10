# 待抽取队列

| 优先级 | ref | 范围 | 目标 area | 负责 | 状态 |
|---|---|---|---|---|---|
| P0 | polchinski-1998-v1 | §1–§4（玻色弦、共形规范、光锥量子化、无鬼定理） | worldsheet | researcher | extracted（二手源）。**⚠ 2026-09-11：Cambridge Core 路线已证可取 Vol.1 正文 PDF（见下方备忘），建议派一轮把 §3 未核实清单（E34 的 `c=D`、E53 的 §3.4 式号、E58 的无鬼定理措辞、(2.1.1) 的 Wick 旋转、(2.7.21) 的表达式）全部升到 L1** |
| P0 | lian-zuckerman-1991 | 全文（Thm 2.13/2.25、Cor 2.26/2.28、Thm 3.5） | worldsheet | researcher | **extracted（L1 全文，2026-09-10）** → `extractions/primary-sources-round2.md` §1 |
| P0 | virasoro-lean-2025 | §9–§12 + App. A.2（Heisenberg、Sugawara c=1、Verma/Fock） | worldsheet | researcher | **extracted（L1 全文，2026-09-10）** → `primary-sources-round2.md` §5.2 |
| P0 | fgz-1986 | 全文 | worldsheet | researcher | extracted（L1 全文）→ `brst-cohomology-sources.md` §1 |
| P0 | goddard-thorn-1972 | 全文 | worldsheet | — | **blocked**（2026-09-10 复核维持，见下方备忘第 1 条与 `extractions/primary-sources-round2.md` §2）：十条路径累计失败（ScienceDirect 403 / CDS Anubis + api Socket closed / KEK 域名被拦 / OSTI / Semantic Scholar / archive.org 无重印本 / INSPIRE 无 documents-urls-report_numbers）。只有摘要级（L2）。主线数学 canonical 建议改用 lian-zuckerman-1991 与 fgz-1986 |
| P0 | brower-1972 | 全文 | worldsheet | — | **blocked**：APS 全站 403，INSPIRE 无 preprint。只有摘要级（L2） |
| P1 | thorn-1984 | 全文（Kac 行列式 + 更一般设定下的无鬼定理） | worldsheet | 待分派 | **queued（高价值）**：a<1 分支物理侧原始出处的最强候选；Elsevier 403，钥匙是报告号 UFTP-84-004 |
| P1 | kato-ogawa-1983 | 全文（是否给出 Ker Q_B / Im Q_B ≅ OCQ 物理态 的同构） | worldsheet | 待分派 | queued：ScienceDirect 403，未找到扫描件；钥匙是报告号 KUNS 637。摘要已逐字（L2） |
| P1 | thorn-1987 | 全文 | worldsheet | 待分派 | queued（优先级下调）：摘要已逐字，**不含 a<1 / D≤25**，不再是 a<1 分支的首选目标 |
| P1 | polchinski-1998-v2 | **§10–§11**（超弦 RNS、GSO、type I/II、杂化弦、流代数） | worldsheet, consistency | researcher | **extracted（L1 全文，2026-09-11）** → `extractions/polchinski-1998-v2.md`。⚠ 原范围写「§10–§12（超弦、GSO、反常）」**不准确**：§11 是杂化弦，§12 才是超弦相互作用+反常；GSO/IIA/IIB/I 全在 **§10.6**。§12、附录 B 未抽 |
| P1 | green-schwarz-1984 | 全文 | consistency | 待分派 | queued |
| P1 | ohta-1986 | 全文（超弦 BRST 上同调 / 无鬼定理的独立严格处理） | worldsheet | 待分派 | **queued（新增 2026-09-11）**：Polchinski Vol.2 §10.5 的超弦无鬼定理只有一句「The proof is a direct imitation of the bosonic argument of chapter 4」，**不给证明、不引文献**。候选：Phys. Rev. D 33 (1986) 1681「Covariant quantization of superstrings based on BRS invariance」与 Phys. Lett. B 179 (1986) 347「BRST cohomology in superstring theories」。⚠ 均只到标题级，尚未核实卷期页 |
| P1 | henneaux-1987 | 全文（"BRST cohomology of the fermionic string", Phys. Lett. B 183 (1987) 59） | worldsheet | 待分派 | **queued（新增 2026-09-11）**：同上，超弦无鬼定理的独立来源候选。⚠ 只到标题级 |
| P2 | superstring-noghost-picture | arXiv:1212.3592（任意 picture 的超弦 BRST 无鬼定理）+ arXiv:1009.0107（NS 弦 0-picture） | worldsheet | 待分派 | **queued（新增 2026-09-11）**：现代处理，且涉及一个 Polchinski 完全没提的问题——**picture number 是否影响 BRST 上同调**。若影响，Vol.2 的无鬼定理陈述隐含了 picture 选择 |
| P2 | kac-raina-1987 | 自由玻色子 Fock 空间上 Virasoro c=1 的 Lecture 与命题号 | worldsheet | 待分派 | queued：需持**第 1 版**原书者核对（第 1 版约 12 讲 / 第 2 版 18 讲，编号不可互换）。已有可替代来源 virasoro-lean-2025 Thm 10.1 / Cor 10.2 |
| P2 | kac-kazhdan-1979 | Kac 行列式公式 | worldsheet | 待分派 | queued：`worldsheet.kac-determinant` 的候选一手来源，终页与标题单复数未核对 |
| P2 | gsw-1987-v1 | §2.3.3（无鬼定理与 spectrum-generating algebra，p.102–112） | worldsheet | 待分派 | queued：Google Books 只回页码不回 snippet，archive.org 无 Vol. 1，式号内容全为 L0 |
| P2 | thorn-1985 | 全文（MSRI 论文集章节，pp. 411–417） | worldsheet | 待分派 | queued：与 thorn-1984 易混（引作「Thorn 1984」），登记以区分 |
| P2 | brower-thorn-1971 | 全文（「D>26 出鬼」的归属争议） | worldsheet | 待分派 | queued：Goddard 2008（L3）与本文摘要（L2）矛盾未裁决 |
| P2 | lian-zuckerman-1989 | 全文（RNS 超弦 / super-Virasoro） | worldsheet | 待分派 | queued：Springer 登录墙；**注意它不能用于玻色弦结论**。可试 lian-zuckerman-1991 成功用的 Project Euclid 端点 `journalArticle/Download?urlId=cmp%2F1104179468` |
| P2 | maldacena-1997 | 全文 | holography | 待分派 | queued |

## 已知获取路线备忘

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
  ⚠ 注意 `assets.cambridge.org/.../frontmatter/*.pdf` 仍然 **Socket is closed**（与旧记录一致）；**要走 Core 的 `/services/` 端点**。
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
