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
| P1 | polchinski-1998-v2 | §10–§12（超弦、GSO、反常） | worldsheet, consistency | 待分派 | queued |
| P1 | green-schwarz-1984 | 全文（PLB 149, 117–122 六页） | consistency | researcher | **extracted（L1 全文，2026-09-11）** → `extractions/green-schwarz-1984.md`。20 条陈述；含 5 条纯代数命题（Lean 岛候选）。**第二轮更新（2026-09-11）**：随 `alvarez-gaume-witten-1984` 抽取完成，**Q3（(20) 的三个系数）已完全闭合**（GS (20) = −48 × AGW (119) 组合，五系数逐一验过）；**Q6（CS 符号约定）确认 AGW 不是源头**；**§3.5 的「GS 把年份误印为 1983」判定已推翻**（AGW 页眉自己印 1983）。**Q2 仍未闭合**：常数 `c` 与 (22) 的十维混合十二形式都**不在** AGW 里，下一步须抽 `zumino-wu-zee-1984` |
| P2 | kac-raina-1987 | 自由玻色子 Fock 空间上 Virasoro c=1 的 Lecture 与命题号 | worldsheet | 待分派 | queued：需持**第 1 版**原书者核对（第 1 版约 12 讲 / 第 2 版 18 讲，编号不可互换）。已有可替代来源 virasoro-lean-2025 Thm 10.1 / Cor 10.2 |
| P2 | kac-kazhdan-1979 | Kac 行列式公式 | worldsheet | 待分派 | queued：`worldsheet.kac-determinant` 的候选一手来源，终页与标题单复数未核对 |
| P2 | gsw-1987-v1 | §2.3.3（无鬼定理与 spectrum-generating algebra，p.102–112） | worldsheet | 待分派 | queued：Google Books 只回页码不回 snippet，archive.org 无 Vol. 1，式号内容全为 L0 |
| P2 | thorn-1985 | 全文（MSRI 论文集章节，pp. 411–417） | worldsheet | 待分派 | queued：与 thorn-1984 易混（引作「Thorn 1984」），登记以区分 |
| P2 | brower-thorn-1971 | 全文（「D>26 出鬼」的归属争议） | worldsheet | 待分派 | queued：Goddard 2008（L3）与本文摘要（L2）矛盾未裁决 |
| P2 | lian-zuckerman-1989 | 全文（RNS 超弦 / super-Virasoro） | worldsheet | 待分派 | queued：Springer 登录墙；**注意它不能用于玻色弦结论**。可试 lian-zuckerman-1991 成功用的 Project Euclid 端点 `journalArticle/Download?urlId=cmp%2F1104179468` |
| P2 | maldacena-1997 | 全文 | holography | researcher | **extracted（L1 全文 22 页逐页读图，2026-09-11）** → `extractions/maldacena-1997.md`（E1–E48）。⚠ 读的是 **arXiv v3**，ATMP 发表版未核对；三条红线：原文是 `U(N)` 非 `SU(N)`、**全文无配分函数陈述**（GKP/Witten 1998 才有）、**全文无 `3/4`**（只说 "up to a numerical factor"）。耦合字典原文给 `g²_YM = 2πg`（≠ 常见的 `4πg_s`），见该文件 Q2 |
| P2 | maldacena-1997 | 全文 | holography | 待分派 | queued |
| P0 | alvarez-gaume-witten-1984 | 全文（Nucl. Phys. B234, 269–330，62 页） | consistency | researcher | **extracted（L1 全文逐页读图，2026-09-11）** → `extractions/alvarez-gaume-witten-1984.md`（E1–E20 + §5 Lean 候选）。取自 **McGill 课程页扫描件**（见下方备忘）。**eq. (63) 已逐字取到**。★ **GS Q3 完全闭合**：GS (20) 的五个系数 = −48 × [AGW (119) 的 N=1 场内容组合]，机械可验，`n=496` 是 `7936−16n` 的唯一零点。★ **GS Q2 只闭合一半**：AGW **不含** 常数 `c`，也**不含** GS (22) 的十维混合十二形式（p.328 明说不做），只给配方。★ **AGW 不是 CS/下降方程符号约定的源头**（源头是 Zumino–Wu–Zee）。⚠️ **年份订正**：AGW **自己的页眉就印 1983**，GS 照抄，不是 GS 误印 |
| **P0** | **zumino-wu-zee-1984** | 全文（下降方程 `ω⁰_{2n+1}`/`ω¹_{2n}` 的定义与符号约定；纯规范反常的绝对归一） | consistency | 待分派 | **新增（2026-09-11，由 alvarez-gaume-witten-1984 抽取推出，优先级 P0）**：B. Zumino, Y.-S. Wu, A. Zee, Nucl. Phys. **B239** (1984) 477 = GS ref [9] = AGW ref [7] 的「Univ. Washington preprint, 1983」。**AGW 全文没有下降方程**，所以 (a) GS 常数 `c` 的另一半依赖、(b) `H = dB + ω⁰_{3Y} − ω⁰_{3L}` 的符号约定源头，**都只能在这里**。抽了它，GS 链的数值系数层才可能全闭合。无 arXiv |
| P1 | eguchi-gilkey-hanson-1980 | Â 多项式（Dirac genus）的定义与 Pontryagin 展开 | consistency | 待分派 | **新增（2026-09-11）**：Phys. Reports **66** (1980) 213 = AGW ref [6]，AGW (82) 的 Â 多项式外包给它。本轮已用 Harvard Math 272b 讲义（匿名 CAS 输出，L1）核对 Â₁–Â₄ 全部相符，但那只作旁证；canonical 数学来源应是 Hirzebruch 或本条 |
| P1 | green-schwarz-1985-hexagon | 全文 | consistency | 待分派 | **新增（2026-09-11）**：Nucl. Phys. **B255** (1985) 93–114。GS 1984 自陈弦论侧 "details will be presented elsewhere"，Schwarz 2012（arXiv:1201.0981，L1）指认这里就是那个 elsewhere。要给「type I 单圈六边形反常抵消」建节点必须先抽它 |
| P2 | gsw-1987-v2 | **第 13 章**（496 维反常自由群的分类陈述） | consistency | 待分派 | **新增（2026-09-11）**：据 Antonelli 2015（arXiv:1507.08642，L1）§1.1，「SO(32) / E₈×E₈ / U(1)⁴⁹⁶ / E₈×U(1)²⁴⁸ 四解」的原始陈述在此，且 "no proof has explicitly been carried out"。bib 里目前只有 `gsw-1987-v1` |

## 已知获取路线备忘

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
  且 Schrans 称它「otherwise, is very complete」。KITP 三条 URL（`kitp.ucsb.edu/joep`、`…/joes-big-book-string`、`…/errata`）
  **全部 HTTP 404**（2026-09-11 复核维持）。找到任一可访问镜像即可一次性批量核对全书式号。
  详见 `extractions/polchinski-1998-v1.md` **Q14**。
- **候选新登记文献（尚未进 `sources.bib`）**：Zwiebach, *A First Course in String Theory*, **2nd ed. §26.6** ——
  Schrans 明说 Polchinski 对「`F₀` 是模群基本域」的论证「quite cavalier about the boundaries」，
  并把严格处理指向该节。若图里要 `worldsheet.modular-fundamental-domain` 的严格来源，这是首选目标。
