# 基于截图的功能对比：本应用 (Your Call Your Rule) 缺失功能全量清单

本文档针对用户提供的 4 张 UI 截图中的**每一个开关、选择器和功能项**，对照我们应用 **Your Call Your Rule (`yourcallyourrule`)** 的源代码进行逐一核查，盘点出**我们目前缺失的全部功能**。

---

## 一、 截图 1：订阅与自定义数据源 (Blocklist Subscriptions) 缺失项

| 截图功能项 | 截图中的定义与机制 | 本 App 源代码现状 | 缺失结论 |
| :--- | :--- | :--- | :--- |
| **1. 订阅自定义 URL 预检预览 (`Preview` 按钮)** | 输入 `Blocklist URL` 和 `Label` 后，点击 `Preview` 预览即将导入的规则条数、增量变动与格式合法性，校验无误后再点击 `Apply` 部署。 | 源码 `subscription_service.dart` 仅有直接下载导入，缺少导入前的预检预览 (Preview) 环节。 | ❌ **缺失 `Preview` 预检预览功能** |
| **2. 增量变动与同步差异指示 (`+14 / -0 last sync`)** | 规则卡片上直观展示上次同步增加/删除的规则条数（如 `+14 / -0`），以及上次同步的相对时间（如 `Last updated: 4 minutes ago`）。 | 源码 `subscription.dart` 仅有 `lastUpdated` 时间戳，缺乏增量变动（`added` / `removed`）统计指示。 | ❌ **缺失同步增量 (Diff) 统计指示** |

---

## 二、 截图 2：高级防护与检测细节 (Advanced Screening) 缺失项

| 截图功能项 | 截图中的定义与机制 | 本 App 源代码现状 | 缺失结论 |
| :--- | :--- | :--- | :--- |
| **3. PhishTank 域名级钓鱼校验 (`Check links with PhishTank`)** | 提取短信正文中的 URL，仅将域名部分发送至 PhishTank API 校验，保护短信上下文隐私。 | 代码库中无任何 PhishTank API 对接与域名提取逻辑。 | ❌ **完全缺失** |
| **4. OpenPhish 本地离线校验 (`Check links with OpenPhish`)** | 在端侧利用离线钓鱼黑名单直接比对，0 联网 0 隐私泄露风险。 | 代码库中无 OpenPhish 离线数据库与比对逻辑。 | ❌ **完全缺失** |
| **5. 动态实时号码补全 (`Live caller enrichment / SkipCalls`)** | 本地判定为低置信度疑似号码时，可选将号码匿名发送至 `SkipCalls` 在线 API 补全最新众包标记。 | 本 App 仅有 `flutter_js` 静态反查脚本，缺少拦截过程中的低置信度动态实时补全逻辑。 | ❌ **完全缺失** |
| **6. 短信轰炸与爆破防护 (`SMS burst protection`)** | 自动检测未知发送方在短时间内的频次爆破并触发防轰炸拦截。 | 代码库中无 SMS 频次爆破与轰炸防御算法。 | ❌ **完全缺失** |
| **7. 重复来电阈值自动封禁 (`Repeat caller auto-block`)** | 设定阈值选择器（如 `3 calls`），非联系人在指定时间内连续打入 N 次后升格封禁。 | 缺少专用的“N 次重复未接通自动封禁”累加计数器与阈值选择器。 | ❌ **完全缺失 (含 3+ 阈值选择器)** |
| **8. 端侧 ML 垃圾打分器 (`ML spam scorer`)** | 端侧无网运行轻量级 Gradient-Boosted ML 梯度提升树模型计算 Spam Score。 | 代码库中无端侧 ML 模型或 20 维特征向量提取算法。 | ❌ **完全缺失** |
| **9. 号码前缀自动拓展 (`Database prefix expansion`)** | 自动识别相同黑产号段，对已知黑号提取共同前缀自动生成野生通配规则。 | 缺少黑号同源前缀自动拓展（Prefix Expansion）算法。 | ❌ **完全缺失** |
| **10. 消息通知筛选 (`Message notification screening`)** | 选择受保护应用（Google Messages, WhatsApp, Telegram 等），通过 NotificationListener 筛选消息。 | 源码仍依赖传统 SMS 广播（且已在 Manifest 注释），缺少多应用消息通知筛选能力。 | ❌ **完全缺失** |
| **11. 通知拦截证据留存 (`Notification evidence`)** | 捕捉并记录拦截到的消息样本证据，供后续分析。 | 无通知拦截证据（Evidence）捕获与存留流。 | ❌ **完全缺失** |

---

## 三、 截图 3：阻断动作与挂断控制 (Block Actions & Handling) 缺失项

| 截图功能项 | 截图中的定义与机制 | 本 App 源代码现状 | 缺失结论 |
| :--- | :--- | :--- | :--- |
| **12. 无声语音信箱模式 (`Silent voicemail mode`)** | 被拦截电话无声转移至语音信箱，主叫听正常响铃，本机保持完全静音。 | 源码 `MyCallScreeningService.kt` 仅有简单的 `setSilenceCall(true)`，缺失无声转信箱模式组合控制。 | ❌ **缺失无声转信箱模式** |
| **13. 低置信度自动静音转信箱 (`Auto-mute low-confidence blocks`)** | 针对置信度得分处于中立临界区的呼叫，自动降级转入语音信箱供事后审核。 | 缺少分值临界区自动降级转语音信箱机制。 | ❌ **完全缺失** |
| **14. 挂断延时秒数微调选择器 (`Hang up after X seconds`)** | 提供 `Hang up after 1 second` 等加减按钮/滑块，微调接通后延迟挂断的秒数。 | 源码 `MyCallScreeningService.kt` 中延时为固定硬编码，UI 侧无可加减的延时秒数选择器。 | ❌ **缺失挂断延时秒数选择器** |

---

## 四、 截图 4：基于分类的细粒度策略矩阵 (Category Call Action Matrix) 缺失项

| 截图功能项 | 截图中的定义与机制 | 本 App 源代码现状 | 缺失结论 |
| :--- | :--- | :--- | :--- |
| **15. 基于分类的四态策略控制面板 (`Category call actions sheet`)** | 针对 `Debt collector` (催收)、`Political` (政治)、`Robocall` (机器人外呼)、`Scam` (诈骗)、`Phishing` (钓鱼) 等分类，提供分类独立的四态控制：<br>`Inherit` (继承全局) \| `Allow` (放行) \| `Voicemail` (转信箱) \| `Block` (阻断)。 | 源码 `predefined_labels.dart` 中有分类标签，但完全没有分类级别的四态策略面板。目前动作只能全局设定或按单条规则设定，无法按分类配置。 | ❌ **完全缺失基于分类的四态策略矩阵面板** |

---

## 五、 总结

根据对 4 张 UI 截图的逐项对照，我们应用 **Your Call Your Rule** 目前**共有 15 项微观功能完全缺失**：

1. **订阅侧**: `Preview` 预检预览、`+14/-0` 增量 Diff 指示。
2. **检测侧**: PhishTank 链接核验、OpenPhish 本地核验、SkipCalls 在线补全、SMS Burst 轰炸防护、Repeat Caller 3+ 阈值封禁、ML Spam Scorer 本地模型、Database Prefix Expansion 前缀拓展、Message Notification Screening 多应用筛选、Notification Evidence 证据流。
3. **动作控制侧**: Silent Voicemail 模式、Auto-mute 临界降级信箱、`Hang up after X seconds` 挂断延时选择器。
4. **分类策略侧**: 基于分类（催收/政治/机器人/诈骗/钓鱼）的 `Inherit / Allow / Voicemail / Block` 四态策略控制面板。

---

*文件存盘位置: `docs/MISSING_FEATURES_FROM_SCREENSHOTS.md`*
