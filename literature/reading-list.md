# 待抽取队列

| 优先级 | ref | 范围 | 目标 area | 负责 | 状态 |
|---|---|---|---|---|---|
| P0 | polchinski-1998-v1 | §1–§6, §8（玻色弦、共形规范、光锥量子化、无鬼定理、模空间与一般亏格 FP、树级振幅；环面紧化与 T 对偶） | worldsheet | researcher | extracted（二手源，需持原书者核对 E34/E53/E58；**§5–§6 于 2026-09-11 追加 E69–E112**，其中 (6.4.23) Veneziano 表达式与 (6.6.23) 开闭弦关系最需核对；**§8 于 2026-09-11 追加 E113–E158**，其中 **(8.3.28) T 对偶「是同一个 CFT」的原文措辞最需核对（Q20）**，其次 (8.4.24)/(8.4.25) 的必要性半句（Q21/Q22）与 (8.7.2) DBI（Q25）。**§8.5 轨形未抽，见 E146**。勘误表风险见 Q14+Q24） |
| P0 | polchinski-1998-v1 | §1–§4（玻色弦、共形规范、光锥量子化、无鬼定理） | worldsheet | researcher | **★★ 原书核实完成（L1，2026-09-11 第六轮）** → `extractions/polchinski-1998-v1.md` **§12**。Q2/Q3/Q4/Q5/Q6/Q7/Q10/Q11/Q12/Q20/Q21/Q22 全部关闭；30 条图节点 loc 修改建议见 §12.10 B 表；15 条作者自承缺口见 C 表。**剩余最高性价比：Appendix A (A.1.31)、书末 References（Goddard–Thorn 是否被引）、§1.2 的 `T=1/(2πα')` 式号** |
| P0 | lian-zuckerman-1991 | 全文（Thm 2.13/2.25、Cor 2.26/2.28、Thm 3.5） | worldsheet | researcher | **extracted（L1 全文，2026-09-10）** → `extractions/primary-sources-round2.md` §1 |
| P0 | virasoro-lean-2025 | §9–§12 + App. A.2（Heisenberg、Sugawara c=1、Verma/Fock） | worldsheet | researcher | **extracted（L1 全文，2026-09-10）** → `primary-sources-round2.md` §5.2 |
| P0 | fgz-1986 | 全文 | worldsheet | researcher | extracted（L1 全文）→ `brst-cohomology-sources.md` §1 |
| P0 | goddard-thorn-1972 | 全文 | worldsheet | — | **blocked**（2026-09-10 复核维持，见下方备忘第 1 条与 `extractions/primary-sources-round2.md` §2）：十条路径累计失败（ScienceDirect 403 / CDS Anubis + api Socket closed / KEK 域名被拦 / OSTI / Semantic Scholar / archive.org 无重印本 / INSPIRE 无 documents-urls-report_numbers）。只有摘要级（L2）。主线数学 canonical 建议改用 lian-zuckerman-1991 与 fgz-1986 |
| P0 | brower-1972 | 全文 | worldsheet | — | **blocked**：APS 全站 403，INSPIRE 无 preprint。只有摘要级（L2） |
| P1 | thorn-1984 | 全文（Kac 行列式 + 更一般设定下的无鬼定理） | worldsheet | 待分派 | **queued（高价值）**：a<1 分支物理侧原始出处的最强候选；Elsevier 403，钥匙是报告号 UFTP-84-004 |
| P1 | kato-ogawa-1983 | 全文（是否给出 Ker Q_B / Im Q_B ≅ OCQ 物理态 的同构） | worldsheet | 待分派 | queued：ScienceDirect 403，未找到扫描件；钥匙是报告号 KUNS 637。摘要已逐字（L2） |
| P1 | thorn-1987 | 全文 | worldsheet | 待分派 | queued（优先级下调）：摘要已逐字，**不含 a<1 / D≤25**，不再是 a<1 分支的首选目标 |
| P1 | polchinski-1998-v2 | §10–§12（超弦、GSO、反常） | worldsheet, consistency | 待分派 | queued |
| P1 | green-schwarz-1984 | 全文（PLB 149, 117–122 六页） | consistency | researcher | **extracted（L1 全文，2026-09-11）** → `extractions/green-schwarz-1984.md`。20 条陈述；含 5 条纯代数命题（Lean 岛候选）。最大未闭合依赖：`alvarez-gaume-witten-1984`（GS 把常数 `c`、(20)(22) 的系数全外包给它） |
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
| P2 | maldacena-1997 | 全文 | holography | researcher | **extracted（L1 全文 22 页逐页读图，2026-09-11）** → `extractions/maldacena-1997.md`（E1–E48）。⚠ 读的是 **arXiv v3**，ATMP 发表版未核对；三条红线：原文是 `U(N)` 非 `SU(N)`、**全文无配分函数陈述**（GKP/Witten 1998 才有）、**全文无 `3/4`**（只说 "up to a numerical factor"）。耦合字典原文给 `g²_YM = 2πg`（≠ 常见的 `4πg_s`），见该文件 Q2 |
| P2 | maldacena-1997 | 全文 | holography | 待分派 | queued |
| **P0** | **alvarez-gaume-witten-1984** | 全文，特别是 **eq. (63)**（反常相对归一化）与十维反常多项式系数 | consistency | 待分派 | **新增（2026-09-11，由 green-schwarz-1984 抽取推出）**：GS 1984 把 (17) 的常数 `c`、(20) 的三个系数、(22) 的相对归一化**全部**外包给本文。不抽它，整条 GS 反常链的数值系数层就是 L0。Nucl. Phys. **B234** (1984) 269–330，无 arXiv（1984）。⚠️ GS 原文把年份误印为 1983 |
| P1 | green-schwarz-1985-hexagon | 全文 | consistency | 待分派 | **新增（2026-09-11）**：Nucl. Phys. **B255** (1985) 93–114。GS 1984 自陈弦论侧 "details will be presented elsewhere"，Schwarz 2012（arXiv:1201.0981，L1）指认这里就是那个 elsewhere。要给「type I 单圈六边形反常抵消」建节点必须先抽它 |
| P2 | gsw-1987-v2 | **第 13 章**（496 维反常自由群的分类陈述） | consistency | 待分派 | **新增（2026-09-11）**：据 Antonelli 2015（arXiv:1507.08642，L1）§1.1，「SO(32) / E₈×E₈ / U(1)⁴⁹⁶ / E₈×U(1)²⁴⁸ 四解」的原始陈述在此，且 "no proof has explicitly been carried out"。bib 里目前只有 `gsw-1987-v1` |

## 已知获取路线备忘

- **★ 新增可用路线（2026-09-11）：archive.org 重印文集 + BookReader 逐页取图 —— `green-schwarz-1984` 全文即以此取得（L1）。**
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
