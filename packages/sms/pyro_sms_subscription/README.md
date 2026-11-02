# Pyro SMS Subscription (`pyro_sms_subscription`)

## 概述 (Overview)
`pyro_sms_subscription` 是 Pyro SMS 防护包组中专门负责**外部威胁情报源与黑名单数据订阅、增量同步、HTTP 下载与本地持久化缓存**的核心数据管线包。

---

## 🚀 `feed.txt` 数据加载与同步全流程解析 (How `feed.txt` is loaded & synced)

许多开发者会问：**“外链或 `feed.txt` 到底是如何被加载进来的？”**
本包通过以下 4 个步骤实现全自动的 `feed.txt` 订阅与内存 $O(1)$ 索引：

### 步骤 1：HTTP 异步拉取 (`FeedDownloader`)
- `FeedDownloader` 使用 Dart 原生 `HttpClient` 异步请求官方开源的 OpenPhish 实时威胁 Feed 地址：
  `https://raw.githubusercontent.com/openphish/public_feed/refs/heads/main/feed.txt`
- 成功响应 HTTP 200 后，通过 `utf8.decoder` 将文本流读取为纯文本字符串。

### 步骤 2：逐行清洗与域名提取 (`FeedRepository`)
- `FeedRepository.instance.syncOpenPhishFeed()` 接收纯文本内容后，按换行符 `\n` 分割成单行：
  - 自动跳过空行与 `#` 开头的注释行；
  - 对每一行文本通过 `Uri.tryParse()` 进行标准化处理（自动补齐 `http://` 协议前缀）；
  - 提取出标准的顶级域名 (`domain.toLowerCase()`)。

### 步骤 3：内存高速哈希存储 (`_feedDomainStore`)
- 提取出的数万个高危钓鱼域名被存入 `_feedDomainStore['openphish']`（内部为高性能 `HashSet<String>`）。
- 确保后续在拦截短信 URL 时，能够在 **$O(1)$ 时间复杂度**内完成毫秒级威胁判定。

### 步骤 4：驱动无感消费 (`OpenPhishDriver`)
- `OpenPhishDriver` 在运行时直接调用 `FeedRepository.instance.getFeedDomains('openphish')` 获取已同步的高危域名集合，实现数据管线与检测驱动的完全解耦。

---

## 📦 核心 API
- `FeedDownloader`: 负责远程 HTTP 文本拉取。
- `FeedRepository.instance.syncOpenPhishFeed()`: 执行全量同步与解析。
- `FeedRepository.instance.getFeedDomains(feedKey)`: 获取内存中的高危域名集合。
