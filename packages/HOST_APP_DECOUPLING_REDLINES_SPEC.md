# 🏛️ 主 App 架构解耦、胶水装配与四大不可逾越红线规范

文件位置：`packages/HOST_APP_DECOUPLING_REDLINES_SPEC.md`

---

## 🛑 一、 四大不可逾越的架构红线与底线 (Architectural Red Lines)

本规范为 VehereGo / Mix 架构管线的底线纪律，全局任何工程人员与 AI 必须 100% 恪守：

### 红线 1：【物理位置红线】Coordinator、Connector 与 UI 工厂必须 100% 位于主 App 胶水层 (`lib/core/coordinator/`)
- **禁止事项**：严禁在 `lib/features/` 目录下或子微包内创建或存放系统级 `Coordinator`、`Connector` 或 `Registry`。
- **强制原则**：所有的中枢协调器 (`AppCoordinator`)、能力连接器 (`AppHubExchangeConnector` / `package_connectors_initializer.dart`) 以及 UI 工厂 (`FilterUiRegistry`)，**物理文件位置必须 100% 存放于 `lib/core/coordinator/` 下**。

### 红线 2：【零魔鬼字符串与零 switch-case 红线】UI 大盘容器绝对禁止硬编码魔鬼字符串与条件分支
- **禁止事项**：大盘容器 (`EnhancedCompositeFilterSettingsWidget`) **绝对禁止出现 `case 'basicRule'`, `case 'timeWindow'`, `case 'localCountThreshold'`, `case 'remoteRisk'`, `case 'simSlot'` 等硬编码 Magic Strings 与 `switch-case` 分支**。
- **强制原则**：容器页面必须是 100% 纯骨架。所有的卡片标题 (`titleBuilder`)、内容 Widget (`contentBuilder`) 和图标只能从 `FilterUiRegistry.get(filterId)` 动态抓取。未来哪怕增加 20 个全新 Filter 插件，大盘容器代码**一字不用改**。

### 红线 3：【微包零横向依赖红线】子微包之间、Feature 与 Feature 之间绝对零横向 `import`
- **禁止事项**：微包与微包之间（如 `phone_time_interceptor` 与 `phone_call_filter`）绝对禁止相互 `import`；子微包绝不能反向 `import` `pyro_phone_call_filter_protocol`；`call_filter` 微包内部绝不能显式 `import` 具体子包的 Widget。
- **强制原则**：只有**主 App (`lib/core/coordinator/`) 具备全局视野**，允许作为唯一的 Mediator（中介者）进行单向跨包装配与 UI 工厂绑定。

### 红线 4：【Riverpod 0ms 乐观更新红线】高频交互禁止设置 `state = const AsyncValue.loading()`
- **禁止事项**：在 Slider 拖动、Switch 切换、TextField 输入等高频 UI 交互中，**绝对禁止在 update 保存操作中强行将 `state` 设为 `const AsyncValue.loading()`**。
- **强制原则**：必须采用**乐观更新（Optimistic Update）**：`state = AsyncValue.data(newState)` 0 毫秒优先更新内存 UI 状态，后台静默落盘。彻底杜绝手势断连与 `ErrorWidget` 大灰框崩溃。

---

## 二、 架构各层物理职责划分矩阵

| 架构层级 | 物理路径 | 允许依赖的方向 | 职责与红线限制 |
| :--- | :--- | :--- | :--- |
| **主 App 胶水层 (Mediator)** | `lib/core/coordinator/` | 允许 `import` 所有子包 | 唯一的集中装配中枢。负责初始化 Connector、注册 `FilterUiRegistry` 工厂、中转 CDC 数据流。 |
| **主 App UI 页面层 (Host Pages)**| `lib/features/` | 允许 `import` `lib/core/coordinator/` | 纯 UI 渲染层。大盘容器页面依靠 `FilterUiRegistry` 纯动态获取 UI，**严禁手写 `switch-case` 或 Magic Strings**。 |
| **控制中枢微包 (Hub Package)** | `packages/phone_call_filter/` | 仅依赖对应 Protocol 包 | 纯哑中枢。维护 `EnhancedCompositeFilterService.instance.filters` 动态数组，**绝对零依赖下层具体 Driver 与 UI**。 |
| **子微包 (Sub-Packages)** | `packages/phone_count_filter/` 等 | 仅依赖对应 Protocol 包 | 纯功能与 UI 孤岛。自提供 Driver 与原生 Widget，**绝对零依赖其他子微包**。 |

---

## 三、 主 App UI 动态工厂落地机制

1. **注册表文件**：`lib/core/coordinator/filter_ui_registry.dart`
2. **初始化调起**：`lib/core/coordinator/app_hub_exchange_connector.dart` 中的 `_registerAllFilterConnectors()`
3. **大盘容器渲染**：`lib/features/call_filter/presentation/widgets/enhanced_composite_filter_settings_widget.dart`

凡遵守本规范之代码，方可合入主干分支。
