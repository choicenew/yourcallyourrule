# Pyro SMS Protocol (`pyro_sms_protocol`)

## 概述 (Overview)
`pyro_sms_protocol` 是 Pyro SMS 防护包组中唯一的**纯抽象契约与数据语言包**。
- **物理红线**：仅允许依赖 `flutter` SDK，绝对禁止引入任何第三方重型 SDK、数据库、UI 或 Hub。
- **职责**：定义所有领域数据模型（`SmsMessageEntity`、`PhishingUrlItem`、`SmsEvidenceItem`、`ProtectedAppInfo`）、枚举（`SmsFilterAction`、`SmsRiskLevel`、`SmsCategory`）以及抽象接口适配器（`SmsFilterAdapter`、`SmsLinkThreatAdapter`、`SmsNotificationListenerAdapter` 等）。
