# Pyro SMS Driver Notification Listener (`pyro_sms_driver_notification_listener`)

## 概述 (Overview)
`pyro_sms_driver_notification_listener` 是实现**免 SMS 权限通知级拦截与 Evidence 证据采集**的独立驱动微包。
- **职责**：通过 Android `NotificationListenerService` 监听默认短信、WhatsApp、Telegram 等消息通知，匹配黑名单时调用 `cancelNotification` 隐蔽消除通知。包含 `SmsNotificationListenerDriver.register()` 自注册钩子。
