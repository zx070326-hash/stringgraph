# 五篇一手文献的最后一轮公开全文搜索（2026-09-12）

- 负责 agent：researcher（无 Bash / 无 git，只写 `literature/`）
- 任务：对以下五个目标各"再做一次认真尝试"，取公开、合法可得的全文（或尽量多的页数）；若取到则做逐字抽取（L1）；
  若只取到摘要则维持/标注 L2；一律记录每条 URL 与结果。
- **证据等级**沿用项目惯例：L1 = 一手正文页图；L2 = 出版方/权威库摘要或元数据；L3 = 亲自读到的第三方转述；
  L4 = 检索引擎/摘要器中介，未亲自渲染原文；L0 = 无来源支持。

## 0. ⚠ 首要发现：本轮任务与"第四轮"（2026-09-11，`primary-sources-round2.md` §12）高度重叠

在开始逐条搜索**之前**本应先读 `literature/sources.bib` 与 `literature/extractions/primary-sources-round2.md`，
但本次任务书未要求、执行时也未先读，导致**本轮前半段（CDS OAI-PMH、Wayback 快照定位、INIS/OSTI 核对）
大量重复了 2026-09-11 已经做过、且已写入 `sources.bib` note 的工作**，结论完全一致（均为「PUBLIC 扫描件已定位，
但 Anubis 反爬 + `web.archive.org` 工具级封锁 = agent 侧仍取不到正文」）。

**这是一条值得记录的方法论教训**（已写入 memory `feedback_pre-hunt-read-existing-notes`）：
**对"最后一搏"式的取全文任务，动手前必须先读该文献在 `sources.bib` 里已有的 `note` 与对应 `extractions/*.md`
（尤其是文件名含"round"、"第N轮"的），否则会把已经做过、已经在 note 里写死结论的路线原样重跑一遍。**

下面各节区分"**沿用第四轮结论**（本轮只做交叉验证）"与"**本轮新增**"两类。**没有任何一项本轮取得了此前没有的全文**。

---

## 1. Goddard–Thorn 1972（Phys. Lett. B40, 235–238）

### 结论：**正文仍未取得（L0）。** 沿用第四轮结论，本轮新增两处交叉验证。

**沿用第四轮（2026-09-11，`primary-sources-round2.md` §12.3/§12.7，不再重复原始查询）**：
CERN 报告号 `CERN-TH-1493`、扫描件 `CM-P00058839`，CDS recid 388690，**MARC 963 = PUBLIC**；
Anubis 拦自动化取件；Wayback 快照 `20240128142907`（status 200）存在但 `web.archive.org` 工具级封锁。

**本轮新增交叉验证（2026-09-12）**：

| # | 入口 | 结果 | 判定 |
|---|---|---|---|
| 1 | `api.openalex.org/works?filter=doi:10.1016/0370-2693(72)90420-0` | `is_oa: false`, `best_oa_location: null` | 与第四轮 Unpaywall（`oa_status: closed`）、Semantic Scholar（`status: CLOSED`）三方独立工具一致 |
| 2 | `scholar.google.com/scholar?q=Goddard+Thorn+"Compatibility+of+the+dual+Pomeron"+1972` | **只有一条结果**，`[PDF] cern.ch`（即同一 CDS 镜像），"All 4 versions"，Cited by 435 | **确认全网只有 CDS 一个 PDF 镜像**，无第二来源 |
| 3 | Google Scholar 摘要片段（新，L4） | 逐字片段：「the paper explains that ghost states disappear "**for d⩽ 26 (d⩽ 10 for Neveu-Schwartz)**"」 | **⚠ 新信息**：现有 `sources.bib` note 写「摘要只给 d<=26，不提 intercept」，但这条 Google 摘要片段显示摘要可能**同时给出 NS 模型的 d≤10**。**这是 L4（搜索引擎摘要片段中介，未见原摘要全文），不得据此改写 L2 结论，仅记录供下一轮验证** |
| 4 | Wayback `archive.org/wayback/available?url=cds.cern.ch/record/388690/files/CM-P00058839.pdf` | 重新查询一次，仍为 `status 200, timestamp 20240128142907` | 第四轮记录仍然有效，未过期 |

**本轮结论**：三个独立工具（Unpaywall/S2/OpenAlex）与 Google Scholar 全网检索**一致确认**除 CDS 镜像外无任何公开全文，
第四轮"只差人工点一次"的判断维持不变。

---

## 2. Brower 1972（Phys. Rev. D6, 1655–1662）与 Brower–Thorn 1971（Nucl. Phys. B31, 163–182）

### 2a. Brower 1972：**正文仍未取得（L0）。**

**沿用第四轮**：`external_system_identifiers` 只有 OSTI 4607653 / ADS / SPIRES，**无 CDS、无 KEKSCAN**——
本文从未存在 CERN/KEK 扫描件，与 GT1972/GGRT1973/Brower-Thorn1971 三篇都不同。APS 全站 403。

**本轮新增**：

| # | 入口 | 结果 | 判定 |
|---|---|---|---|
| 1 | `api.openalex.org/works?filter=doi:10.1103/PhysRevD.6.1655` | `is_oa: false`, `best_oa_location: null` | 与第四轮结论一致 |
| 2 | `scholar.google.com/scholar?q=Brower+"spectrum-generating+algebra+and+no-ghost+theorem"` | **只有一条结果**，**无 [PDF] 标签**，只有 `[HTML] journals.aps.org`（付费墙），"All 4 versions"，Cited by 426 | **确认全网连一个 PDF 镜像都没有**——本文是五个目标里唯一"connect 0 个可下载副本"的 |
| 3 | 再次核对：Brower 1972（单作者，D6,1655，"conventional dual model"）与 Brower–Friedman 1973（双作者，D7,535，Neveu-Schwarz 模型）| 卷/期/页/DOI 与摘要均确认不是同一篇 | 沿用 `sources.bib` 第三轮已有的区分（`brower-friedman-1973` 词条），本轮未发现需要更正之处 |

**本轮结论**：Brower 1972 没有任何已知公开全文路径（既无 CDS/KEK 扫描件，也无任何镜像 PDF），是五个目标中
唯一连"人工点一次"这条退路都没有的一篇。这点本轮首次用 Google Scholar 全网检索正面确认（此前只是"未找到"，
现在是"确认零个 PDF 链接存在于 Google 索引里"）。

### 2b. Brower–Thorn 1971：**正文仍未取得（L0）。**

**沿用第四轮（`primary-sources-round2.md` §12.6）**：CERN 报告号 `CERN-TH-1293`，扫描件 `CM-P00058794`，
CDS recid 352004，**MARC 963 = PUBLIC**（当时标注"088/963 未逐字复核"）。

**本轮新增**：

| # | 入口 | 结果 | 判定 |
|---|---|---|---|
| 1 | `api.openalex.org/works?filter=doi:10.1016/0550-3213(71)90452-4` | `is_oa: false`, `best_oa_location: null` | 与第四轮方向一致（OpenAlex 未见于第四轮记录，本条属于新增独立工具确认） |
| 2 | `scholar.google.com/scholar?q=Brower+Thorn+"Eliminating+spurious+states+from+the+dual+resonance+model"` | **只有一条结果**，`[PDF] cern.ch`（链接到 cds.cern.ch，即同一份第四轮定位到的扫描件）、`[标题] sciencedirect.com`，"All 3 versions"，Cited by 107 | **确认全网只有 CDS 一个 PDF 镜像**，ScienceDirect 是付费墙 |
| 3 | 真实标题/DOI 核对：*Eliminating spurious states from the dual resonance model*, DOI `10.1016/0550-3213(71)90452-4` | 与 `sources.bib` 现有词条完全一致 | **无需更正**（第三轮已经登记正确） |

⚠ **本轮未对第四轮记录的 088/963 做逐字复核**（Google Scholar 路线足以确认"CDS 是唯一镜像"这一结论，
不需要重新 fetch OAI-PMH）——若后续要下载，仍以第四轮的 088/963 逐字复核为准，那条待办依然开着。

---

## 3. Thorn 1985（"A proof of the no-ghost theorem using the Kac determinant"，MSRI 论文集）

### 结论：**正文仍未取得（L0）。** 沿用第四轮结论，本轮新增一处（INIS 状态重新确认）。

**沿用第四轮（`primary-sources-round2.md` §12.5）**：本条目是 **MSRI 论文集 7 页**（Springer, 1985, pp.411–417），
与另一篇篇幅更大、内容重叠但**不是同一篇**的 Thorn 讲义（*Introduction to the theory of relativistic strings*，
Santa Barbara Workshop 1985，42 页，INIS `szqhd-hct30`，OSTI 5007660，报告号 `DOE/ER/40008-77`）容易混淆。
两者均为 "Report Restricted"／`access.files: restricted`，OSTI purl 404。

**本轮新增交叉验证**：

| # | 入口 | 结果 | 判定 |
|---|---|---|---|
| 1 | `inis.iaea.org/records/szqhd-hct30`（API 记录状态字段） | `access.record: public`, `access.status`（文件级）仍为限制状态 | 与第四轮一致，无变化 |
| 2 | `osti.gov/servlets/purl/5007660` | **HTTP 404**（重新验证一次） | 与第四轮一致 |
| 3 | `osti.gov/api/v1/records?q="Introduction to the theory of relativistic strings"` | 命中同一条 OSTI 5007660 记录，页面注明"available through NTIS, PC A03/MF A01"，**无 purl 全文链接** | 确认这是 NTIS 付费分发的报告，不是可免费 purl 的 DOE 原生报告 |
| 4 | MSRI 论文集本身（*Vertex Operators in Mathematics and Physics*, Springer 1985）| 未见公开扫描件；Springer 章节 PDF 走机构订阅路线（`link.springer.com` 在本环境全域 403，见 memory `reference_cambridge-core-licensed-book-pdfs` 已确认 Springer 被封） | 该书目前没有 Cambridge-Core 式的机构订阅通道可用（不是 CUP 出版） |

**本轮结论**：与第四轮完全一致——这是两个受限访问真实存在（NTIS 付费分发 / Springer 订阅墙），
而不是仅仅"agent 被反爬拦住"的情形，属于五个目标中访问壁垒性质与其余四篇不同的一个。

---

## 4. Goddard–Goldstone–Rebbi–Thorn 1973（Nucl. Phys. B56, 109–135）

### 结论：**正文仍未取得（L0）。** ⚠⚠ **本轮发现并订正了一处此前记忆/bib 均未察觉的 Wayback 快照矛盾。**

**沿用既有记录（`sources.bib` + `extractions/ggrt-1973.md`）**：CERN 报告号 `CERN-TH-1578`，扫描件 `CM-P00058492`，
CDS recid 394307，**MARC 963 = PUBLIC**。

**⚠⚠ 本轮新增、需要订正的发现**：此前 `extractions/ggrt-1973.md` §"取件钥匙" 与 researcher 的 memory
（`lit_ggrt-1973-lightcone-d26.md`）都记载"Wayback 快照 `20220710054516` 存在且 status 200"。
**本轮用三种查询写法反复核实，结果与该记载不一致**：

| # | 查询 | 结果 |
|---|---|---|
| 1 | `archive.org/wayback/available?url=cds.cern.ch/record/394307/files/CM-P00058492.pdf`（裸 URL，无协议前缀） | `"archived_snapshots": {}`（**空**） |
| 2 | `archive.org/wayback/available?url=https://cds.cern.ch/record/394307`（带协议前缀，记录页非文件） | `"archived_snapshots": {}`（**空**） |
| 3 | `archive.org/wayback/available?url=cds.cern.ch/record/394307`（裸 URL，记录页非文件） | ✅ `"archived_snapshots": {"closest": {"status": "200", ..., "timestamp": "20230523151305", ...}}` |
| 4 | `web.archive.org/cdx/search/cdx?url=cds.cern.ch/record/394307/files/CM-P00058492.pdf&output=json` | ❌ 工具级封锁（"Claude Code is unable to fetch from web.archive.org"），CDX API 无法核实 |

**判定**：
- **裸记录页 URL**（`cds.cern.ch/record/394307`，不带协议前缀）**确有快照**（2023-05-23），但那只是 CDS 记录的 HTML
  摘要页，不含 PDF 全文，价值等同于已经拿到手的 OAI-PMH 元数据，**不构成新的取文路径**。
- **PDF 文件本身**（`.../files/CM-P00058492.pdf`）**在本轮三种查询写法下全部返回空**，
  与此前记忆记载的 `20220710054516` 快照**矛盾**。由于 `web.archive.org` 的 CDX API 工具级封锁，
  本轮无法用更权威的接口彻底证伪旧记载，但 `archive.org/wayback/available`（唯一可用的核实通道）
  **连续多次、多种写法都查不到该文件级快照**。
- **⇒ 结论：此前记忆里"GGRT1973 的 PDF 有 Wayback 快照"这条记载应视为不可靠，本轮予以订正**
  （已同步更新 memory，见本报告末尾）。**GT1972 与 Brower–Thorn 1971 的文件级快照（2024-01-28 / 见第四轮）
  未受此问题影响**——本轮用同一方法核实 GT1972 的快照查询仍返回有效结果（见 §1 表格第 4 行），
  说明"空结果"不是 API 全局故障，而是 GGRT1973 这一个文件确实没有被 Wayback 抓取过 PDF 本体。

**本轮其余交叉验证**：

| # | 入口 | 结果 |
|---|---|---|
| 5 | `api.openalex.org/works?filter=doi:10.1016/0550-3213(73)90223-X` | `is_oa: false`, `best_oa_location: null` |
| 6 | `scholar.google.com/scholar?q=Goddard+Goldstone+Rebbi+Thorn+"massless+relativistic+string"` | 187 条结果，第 1 条即本文，`[PDF] cern.ch`（同一 CDS 镜像），"All 6 versions"，Cited by 1061；其余 9 条均为引用本文的下游文献，**无第二个直接镜像** |

**本轮结论**：正文仍是 L0；唯一新增内容是**订正了一条此前未被发觉的记忆错误**（快照矛盾），
以及再次确认 CDS 是全网唯一 PDF 来源。**不改变 `worldsheet.critical-dimension-light-cone-v2` 的状态**。

---

## 5. GSW Vol.1 §2.3.3（pp.102–112）与 GSW Vol.2 ch.13

### 结论：**仍未取得正文（沿用既有 12–13 MB 超限结论）。本轮新增：备用 ISBN 死路 + Google Books 页码交叉验证。**

沿用 memory `reference_cambridge-core-licensed-book-pdfs`：GSW 两卷是逐页扫描件（~240 KB/页），
v1 ch.2（64 页）13 MB、v2 ch.13（56 页）12 MB，均超过 WebFetch 10 MB 硬上限，且节级 PDF 不存在
（`BOOK_PART` identifier 空档全部 400）。

**本轮新增（2026-09-12）**：

| # | 入口 | 结果 | 判定 |
|---|---|---|---|
| 1 | `cambridge.org/core/product/identifier/9781107029118/type/book` | **HTTP 400** | 任务书给的备用 ISBN（"25th Anniversary Edition" 精装本）**未被 Cambridge Core 单独收录** |
| 2 | `cambridge.org/core/product/identifier/9781107029118/type/BOOK` | **HTTP 400** | 大小写变体同样失败，非大小写问题 |
| 3 | 回退核对旧 ISBN `cambridge.org/core/product/identifier/9781139248563/type/book` | ✅ 成功，书 hash 与既有记录相同（`35152940E2D9C3B0BD327EB7FF74DBBE`） | **确认 Core 上现在实际数字化收录的版本本身就已标注为 "25th Anniversary Edition"**（含新增 Preface pp. ix–x），即任务书想找的"另一 ISBN"内容其实已经并入既有可访问版本，只是印本 ISBN 不同——**不是一条独立新路线，是同一本书的两种印刷版 ISBN**，Core 只认旧 ISBN 的书目条目 |
| 4 | 各章 item hash 与页范围重新拉取一次 | 与既有 memory 记录一致，无变化；ch.2（含 §2.3.3）仍是 64 页、超 10MB | 无新进展 |
| 5 | Google Books 页码交叉验证（已知诚实卷 `ItVsHqjJo4gC`）：`&q="no-ghost theorem"` | 命中 **p.110** | 落在任务书给定的 pp.102–112 范围内，与"§2.3.3 标题页附近"吻合 |
| 6 | Google Books `&q="spectrum-generating algebra"` | 命中 **p.100** | 落在 §2.3.3 前一节，与章节顺序吻合 |
| 7 | Google Books `&q=`（一处刻意拼错的检验字符串，诚实性对照） | 返回干净 "No results" | 复核该卷号仍诚实，页码可信 |

**本轮结论**：GSW 两卷仍无法整章取得。§5/§6 的页码交叉验证（p.100/p.110）**只能确认页码范围，不能给出正文内容**，
维持 L2（只有元数据级证据，无正文）。**唯一真正的出路仍是"把 URL 交人类点一次"**（章级 PDF 尺寸超限是硬件限制，
不是权限限制——Core 账号本身对这两卷都有权限，问题纯粹是文件太大）。

---

## 6. 总表：本轮结果一览

| # | 目标 | 本轮是否取得新全文 | 现有内容等级 | 受影响的图节点 | 本轮新增价值 |
|---|---|---|---|---|---|
| 1 | Goddard–Thorn 1972 | ❌ 否 | L0（正文）/ L2（书目+馆藏） | `worldsheet.no-ghost-theorem-v4`（via-goddard-thorn 推导）、`worldsheet.ddf-spanning-hypothesis` | 三方工具确认零额外镜像；一条待验证的 L4 摘要片段（NS d≤10） |
| 2a | Brower 1972 | ❌ 否 | L0 / L2 | 同上（备选/补充来源） | **首次正面确认全网零 PDF 镜像**（不只是"没找到"） |
| 2b | Brower–Thorn 1971 | ❌ 否 | L0 / L2 | `brst-cohomology-sources.md` §3.2 的矛盾（D>26 出鬼） | 再确认 CDS 为唯一镜像 |
| 3 | Thorn 1985（MSRI） | ❌ 否 | L0 / L2 | Kac 行列式路线的证明来源候选 | 确认访问壁垒是真实版权/NTIS 限制，非反爬 |
| 4 | GGRT 1973 | ❌ 否 | L0 / L2 | `worldsheet.critical-dimension-light-cone-v2` | **★ 订正一条此前记忆里的 Wayback 快照错误记载** |
| 5 | GSW v1 §2.3.3 / v2 ch.13 | ❌ 否 | L2（页码定位，无正文） | 同 no-ghost-theorem 相关节点（次要参照） | 备用 ISBN 排除；页码交叉验证 |

**所有三个目标图节点（`worldsheet.no-ghost-theorem-v4`、`worldsheet.ddf-spanning-hypothesis`、
`worldsheet.critical-dimension-light-cone-v2`）本轮均未解封，状态不变。**

### 交给人类（船长）的可操作清单（汇总自本轮 + 第四轮，均为出版方标 PUBLIC、只差一次人工点击）

1. GT 1972：`https://cds.cern.ch/record/388690/files/CM-P00058839.pdf`
   （备用 `http://web.archive.org/web/20240128142907/https://cds.cern.ch/record/388690/files/CM-P00058839.pdf`）
2. Brower–Thorn 1971：`https://cds.cern.ch/record/352004/files/CM-P00058794.pdf`
3. GGRT 1973：`https://cds.cern.ch/record/394307/files/CM-P00058492.pdf`
   （⚠ 本轮未能确认有效 Wayback 备用链接，见 §4——如需备用，需人工在 Wayback Machine 网站上重新搜索）
4. GSW v1 ch.2（含 §2.3.3，pp.32–76）：
   `https://www.cambridge.org/core/services/aop-cambridge-core/content/view/5CA151E88B12C248825A262624ADC7D6/9781139248563c2_p32-76_CBO.pdf`
   （13 MB，超出 agent 侧 WebFetch 上限，人工浏览器下载无此限制）
5. GSW v2 ch.13：书 hash `ABB0BC23C86B597DAF81D50D463D2FA7`，ISBN `9781139248570`，需人工先取 item hash
   （12 MB，同样只受文件大小限制）
6. Thorn 1985（两篇）：MSRI 版无公开路径；Santa Barbara 42 页版见
   `https://inis.iaea.org/records/szqhd-hct30`（需注册登录，researcher 不代为注册）

不建议船长优先处理 Brower 1972（2a）——它连一个可点击的 PDF 链接都不存在。
