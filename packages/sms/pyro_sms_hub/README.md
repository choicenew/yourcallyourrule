# Pyro SMS Hub (`pyro_sms_hub`)

## 概述 (Overview)
`pyro_sms_hub` 是 Pyro SMS 防护包组中的**纯 IoC 服务定位器（Service Locator）与多阶段 Pipeline 调度引擎单例**。
- **架构红线**：`pyro_sms_hub` 仅依赖 `pyro_sms_protocol`，**绝对不依赖任何具体的 Driver 实现包**。
- **职责**：维护单例 `SmsHub.instance` 动态注册表，提供 `registerFilter()`、`registerLinkThreatAdapter()` 等注册接口，并运行 `SmsScreeningPipeline` 多阶段拦截评估。
