# pyro_crowdsourcing_arbiter (通用社区众包共识与规则注册表引擎)

## 一、 核心架构定位 (Architecture Positioning)

`pyro_crowdsourcing_arbiter` 是 PyroMagma 体系下的**去中心化公共配置、众包规则与社区共识注册表引擎**。

本微包专门用于处理所有**公用、非个人隐私、由社区成员共同贡献、投票校验与全网同步分发**的公共数据。

---

## 二、 三大铁律原则 (Three Core Principles)

1. **公用规则与元数据 (Public Rule & Metadata Only)**：
   - 本系统**只流转纯结构化规则定义、关键词 List、配置 JSON、Tag 映射与置信度点数**。
   - **绝对不流转个人隐私数据**，也**不包含任何流媒体大文件**。

2. **通用靶向契约模型 (Universal Target Model)**：
   - 彻底摆脱老系统中硬编码电话号码 (`phoneNumber`) 的弊端。
   - 采用 **`Domain` (业务域) + `EntityKey` (领域内唯一标识)** 复合主键，全面支持外卖动态 UI 展示规则关键词、小说社区标签修正、音乐元数据标校、全网清洗过滤规则、号码风险标记等任意业务形态。

3. **Isar NoSQL 高性能本地引擎 (Isar Document Storage)**：
   - 全面抛弃传统 SQL 关系表的繁琐限制，基于 Isar 提供的百万级并发与动态 Document/JSON 支持，做到极速本地查询与异构数据兼容。

---

## 三、 数据模型设计 (Data Models)

### 1. `CrowdsourcedItem` (通用众包共识实体)

```text
CrowdsourcedItem
├── compositeKey: String  // 复合主键 (如 "takeout_rule:meituan_keywords_v1")
├── domain: String        // 业务域 (如 'takeout_dynamic_rule', 'novel_tag', 'cleaner_rule')
├── entityKey: String     // 领域Key (如 'meituan_keywords_v1')
├── payloadJson: String   // 泛化负载 JSON (包含 keywords 数组、正则、标签配置等)
├── supportVotes: int     // 赞成票 / 好用数
├── opposeVotes: int      // 反对票 / 报错数
├── confidence: double    // 社区共识置信度 (0.0 ~ 1.0)
└── status: String        // 'pending' | 'community_consensus' | 'rejected' | 'deprecated'
```

### 2. 置信度评分计算公式 (Confidence Score Algorithm)

$$\text{Confidence} = \frac{\text{SupportVotes} + 1.0}{\text{SupportVotes} + \text{OpposeVotes} + 2.0} \times \left(1 - e^{-\frac{\text{SupportVotes} + \text{OpposeVotes}}{5.0}}\right)$$

该公式综合拉普拉斯平滑与样本量惩罚，防止低投票数下的虚高评分。

---

## 四、 典型使用场景 (Use Cases)

| 业务场景 | `domain` | `entityKey` | `payloadJson` 内容 | 社区共识逻辑 |
| :--- | :--- | :--- | :--- | :--- |
| **外卖动态展示规则** | `takeout_rule` | `meituan_promo` | `{"keywords": ["大额券", "满减"], "action": "highlight"}` | 众包提取优惠关键词，社区投票防失效 |
| **小说社区标签修正** | `novel_tag` | `book_10023` | `{"customTags": ["穿越", "无敌流"], "rating": 9.2}` | 纠正分类标签，补全评分信息 |
| **音乐元数据与歌词校准**| `music_metadata` | `song_m8839` | `{"lrcOffsetMs": -250, "verifiedArtist": "周杰伦"}` | 众包校准歌词时间轴与歌手信息 |
| **公共清洗/拦截规则** | `cleaner_rule` | `ad_rule_site_a` | `{"cssSelectors": [".ad-banner"], "urlPattern": "..."}` | 众包屏蔽黑名单，全量下载生效 |

---

## 五、 与 Cloudflare 同步微包的协同

`pyro_crowdsourcing_arbiter` 仅负责本地 Isar 规则引擎与置信度裁决，网络同步层通过导出 `SyncOperation` 接入 `pyro_sync_cloudflare` 微包，由后者定期与 Cloudflare Worker + D1 数据库进行 Push / Pull 增量同步。
