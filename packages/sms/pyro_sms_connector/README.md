# Pyro SMS Connector (`pyro_sms_connector`)

## 概述 (Overview)
`pyro_sms_connector` 是 Pyro SMS 防护包组的**装配与即插即用（Plug-and-Play）自注册中台**。
- **职责**：同时依赖 Hub、Protocol 和所有 Driver 微包。在应用启动时，宿主 App 仅需调用一行 `SmsConnectors.ensureMounted()`，即可自动完成全量 SMS 驱动的注册与挂载。
