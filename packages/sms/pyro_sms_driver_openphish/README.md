# Pyro SMS Driver OpenPhish (`pyro_sms_driver_openphish`)

## 概述 (Overview)
`pyro_sms_driver_openphish` 是集成 OpenPhish 实时威胁情报的**独立驱动微包**。
- **职责**：实现 `SmsLinkThreatAdapter`，配合 `pyro_sms_subscription` 提供的高危域名集合，在本地进行 $O(1)$ 毫秒级钓鱼链接阻断。包含 `OpenPhishDriver.register()` 自注册钩子。
