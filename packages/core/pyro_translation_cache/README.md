# pyro_translation_cache

专有高性能翻译双级缓存与后台预翻译调度微包 (Dual-Tier Translation Cache & Pre-Translation Engine).

## 特性 (Features)

1. **双级缓存架构 (Dual-Tier Caching)**：
   - **L1 内存级 LRU 缓存**：极速微秒级同步响应，内存智能淘汰。
   - **L2 磁盘级持久化缓存**：零丢失落盘机制，支持 TTL 过期清理与文件尺寸上限剪裁。

2. **后台预翻译并发调度器 (Pre-Translation Concurrency Scheduler)**：
   - 异步队列管理，支持 `High` / `Normal` / `Low` 三级优先级打标。
   - 请求去重与防抖合并 (Deduplication)，相同文本与目标语种零重复计算。

3. **零死锁与线程安全 (Thread-Safe & Non-blocking)**：
   - 异步平滑下沉写盘，绝对不卡顿 Flutter UI 主线程。
