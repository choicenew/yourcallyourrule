# pyro_cloud_drive_hub

全局云盘驱动注册中心与宿主上下文合成中枢。

## 💡 核心职责

维护纯 Dart 静态单例 `CloudDriveHub.instance`（Service Locator模式）：

1. **驱动挂载与动态工厂 (`register`, `registerBuilder`)**:
   - 动态管理 `webdav`, `onedrive`, `google_drive` 等底层驱动实例与配置表单元数据 `CloudServiceUIConfig`。
2. **影子账户与宿主上下文隔离 (`configureHostContext`, `computeRootPath`)**:
   - 结合当前宿主 App 名称与当前激活的影子账户 ID (Shadow Account Context)，智能推算云端隔离根路径：`/{appName}/{accountId}`，实现多账户/多 APP 的云端物理隔离。
3. **首选驱动切换与状态管理**:
   - 提供 `setActiveProvider()`, `currentDriver`, `availableProviders`，支持运行时一键切换默认网盘。
