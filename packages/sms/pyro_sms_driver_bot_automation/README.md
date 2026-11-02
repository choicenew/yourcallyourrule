# Pyro SMS Driver Bot Automation (`pyro_sms_driver_bot_automation`)

## 概述 (Overview)
`pyro_sms_driver_bot_automation` 是负责 **Trigger-Action 自动化响应工作流**的独立驱动微包。
- **职责**：当短信被判定为高危欺诈时，自动触发 Webhook HTTP POST 警报抛送、转发至企业网关或联动系统告警。
