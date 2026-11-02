# Pyro SMS Driver OTP Guard (`pyro_sms_driver_otp_guard`)

## 概述 (Overview)
`pyro_sms_driver_otp_guard` 是专职负责 **2FA 验证码隐私安全与生命周期管理**的独立驱动微包。
- **职责**：正则精准提取短信中的 2FA 验证码、进行掩码脱敏（如 `849201` ➔ `84****`）、管理 5 分钟内存自动销毁、以及复制后 5 分钟自动清空系统剪贴板防窃取。包含 `OtpGuardDriver.register()` 自注册钩子。
