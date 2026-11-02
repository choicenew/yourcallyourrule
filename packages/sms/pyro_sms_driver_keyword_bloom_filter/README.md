# Pyro SMS Driver Keyword Bloom Filter (`pyro_sms_driver_keyword_bloom_filter`)

## 概述 (Overview)
`pyro_sms_driver_keyword_bloom_filter` 是集成**纯 Dart 实现的布隆过滤器（Bloom Filter）与 Aho-Corasick（AC 自动机）**的高性能检索驱动微包。
- **职责**：针对 10 万+ 海量黑名单词库，通过位图快速过滤与单次扫描 $O(n)$ 多模式匹配，实现超高速无卡顿检索。包含 `KeywordBloomFilterDriver.register()` 自注册钩子。
