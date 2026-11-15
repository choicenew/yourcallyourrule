# 🏛️ 主 App 纯数据驱动架构解耦整改落地报告 (Walkthrough)

## 概要

根据严格的四大架构红线与 100% 纯数据驱动解耦规范，成功消除了主 App 中所有写死的魔鬼字符串、写死 `switch-case` 以及违规跨包 import，完成了全量 Connector 与 UI 工厂的零耦合归位。

---

## 🛑 四大架构红线与底线落地核对

| 架构红线编号 | 规范铁律要求 | 本次落地整改验证结果 |
| :--- | :--- | :--- |
| **红线 1：物理位置红线** | `Coordinator`、`Connector` 与 UI 工厂必须 100% 位于 `lib/core/coordinator/`，严禁存放在 `lib/features/` | ✅ 创建 `lib/core/coordinator/filter_ui_registry.dart`，UI 注册映射集中归位于主 App 底层胶水层。 |
| **红线 2：零魔鬼字符串与零 switch-case** | 容器大盘 `EnhancedCompositeFilterSettingsWidget` 绝对禁止硬编码 `basicRule`, `timeWindow`, `localCountThreshold`, `remoteRisk`, `simSlot` 等魔鬼字符串 | ✅ `EnhancedCompositeFilterSettingsWidget` 源码做到 **0 个子包 Widget import，0 个魔鬼字符串，0 个 switch-case**，纯依靠 `FilterUiRegistry.get(filterId)` 动态驱动。 |
| **红线 3：微包零横向依赖** | 子微包之间绝对零横向 `import`；子微包不反向依赖 `call_filter_protocol`；`call_filter` 不显式 import 具体子包 Widget | ✅ `pyro_phone_call_filter` 保持 100% 纯哑中枢，所有 Cross-Import 统一收拢于主 App `lib/core/coordinator/` 唯一的 Mediator 胶水层。 |
| **红线 4：Riverpod 0ms 乐观更新** | 高频交互禁止设置 `state = const AsyncValue.loading()` | ✅ 重构 5 大 Config Notifier 为 **0ms 乐观更新 (`state = AsyncValue.data(newState)`)**，避免手势断连与 `ErrorWidget` 灰屏崩溃。 |

---

## 📁 关键修改文件汇总

### 1. 主 App 胶水层 UI 动态工厂 (`lib/core/coordinator/filter_ui_registry.dart`) [NEW]
- 定义 `FilterUiSpec` 与 `FilterUiRegistry`，在中枢初始化管道中集中注册 `basicRule`, `timeWindow`, `localCountThreshold`, `remoteRisk`, `simSlot` 的 UI 描述符。

### 2. 纯数据驱动大盘容器 (`lib/features/call_filter/presentation/widgets/enhanced_composite_filter_settings_widget.dart`) [MODIFY]
- 清理所有子包组件的硬编码 `import`；
- 清理所有 `switch-case` 与硬编码字符串分支；
- 动态读取 `EnhancedCompositeFilterService.instance.filters` 内存列表并调起 `FilterUiRegistry.get(filterId)`，未来增加 20 个新 Filter 插件，大盘容器代码**一字不用修改**。

### 3. 应用中枢管道 (`lib/core/coordinator/app_hub_exchange_connector.dart` & `package_connectors_initializer.dart`) [MODIFY]
- 一键调起 `FilterUiRegistry.init()`，完成逻辑驱动自注册与主 App UI 工厂动态装配双闭环。

---

## 物理文件规范文档

1. `packages/CALL_FILTER_AUTO_REGISTRATION_SPEC.md`
2. `packages/HOST_APP_DECOUPLING_REDLINES_SPEC.md`

全量修改均已通过静态代码分析门禁（0 Error, 0 Warning）。
