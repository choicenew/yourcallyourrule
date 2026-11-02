# Pyro SMS Driver Telephony Fallback (`pyro_sms_driver_telephony_fallback`)

## 概述 (Overview)
`pyro_sms_driver_telephony_fallback` 是面向 **F-Droid / 侧载高权限场景**的原生 Telephony 垫片驱动微包。
- **职责**：直接对接 Android `SMS_RECEIVED` BroadcastReceiver 与 `Telephony.Sms.CONTENT_URI` 数据库进行深度物理拦截。包含 `TelephonyFallbackDriver.register()` 自注册钩子。
