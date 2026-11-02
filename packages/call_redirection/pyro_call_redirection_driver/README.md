# Call Redirection Driver (`pyro_call_redirection_driver`)

## 概述 (Overview)
`pyro_call_redirection_driver` 是实现 Android `ROLE_CALL_REDIRECTION` 呼出拦截与 MethodChannel 桥接的驱动微包。
- **职责**：实现 `ICallRedirectionAdapter`，在拨出高危/付费/诈骗号码前拦截并弹出确认或挂断。包含 `CallRedirectionDriver.register()` 自注册钩子。
