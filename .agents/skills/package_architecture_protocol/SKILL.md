---
name: package-architecture-protocol
description: VehereGo / Mix 多包拆分与架构对齐规范 (Package Architecture Protocol Specification)。定义子系统（如 notification, commercial, clouddrive 等）按 protocol, hub, drivers, connector, ui 进行五层极简彻底解耦的拆分原则与强铁律。
---

# Package Architecture Protocol Specification (多包拆分与五层彻底解耦契约)

本规范定义了 VehereGo / Mix 项目中所有模块化包组（例如 `packages/notification/`、`packages/commercial/`、`packages/clouddrive/` 等）的标准架构拆分原则与解耦铁律。

---

## 🏗️ 架构五层标准职责分工

所有的子系统包组**必须且只能**划分为以下五层结构，严禁层级越界与职责混淆：

```
                         ┌──────────────────────────────────────────────┐
                         │                 *_protocol                   │
                         │    (定义抽象 Driver 契约 & 领域实体 Entity)    │
                         └──────────────────────┬───────────────────────┘
                                                │ 依赖契约
                                                ▼
┌──────────────────────────────────────────────────────────────────────────────────────────────┐
│                                           *_hub                                              │
│               (纯粹控制中枢 / 评估评估引擎 / IoC 控制反转容器 / 零 UI 依赖)                              │
└───────────────────────────────────────────────┬──────────────────────────────────────────────┘
                                                ▲ 依赖注入 (*_connector)
                                                │
┌───────────────────────────────────────────────┴──────────────────────────────────────────────┐
│                                          *_driver / *_filter_*                               │
│                   (具体原生/平台适配器 Driver：Android Kotlin / iOS Swift 插件)                 │
└───────────────────────────────────────────────┬──────────────────────────────────────────────┘
                                                │ 提供驱动支持
                                                ▼
┌──────────────────────────────────────────────────────────────────────────────────────────────┐
│                                            *_ui                                              │
│                  (集中承载所有用户交互界面：Pages, Widgets, BottomSheets, Notifiers)                  │
└──────────────────────────────────────────────────────────────────────────────────────────────┘
```

---

## 📌 各层级严密规则与禁令

### 1. `*_protocol` (协议契约层)
* **核心职责**：定义整个子系统所需的领域数据模型（Entities）与 Driver 抽象接口契约（Abstract Driver Contracts）。
* **严禁红线**：
  * 绝对禁止依赖 `flutter/material.dart` 或任何 UI 库；
  * 绝对禁止包含 Isar/SQLite 数据库的具体持久化代码；
  * 绝对禁止包含任何平台原生（MethodChannel / EventChannel）实现代码。

### 2. `*_hub` (中控与调度层)
* **核心职责**：充当整个子系统的**中控台（Control Center）**与**业务逻辑流转中枢**（纯逻辑/评估引擎/EventDispatcher）。
* **设计原则**：
  * 使用 IoC（控制反转）模式，仅持有 `*_protocol` 中定义的抽象 Driver 接口引用（`register*Driver`）；
  * 承载纯确定性评估引擎（`EvaluateUseCase`）、动作派发（`ExecuteActionUseCase`）、防抖事件分发与离线规则 Manifest 资产；
* **严禁红线**：
  * **绝对禁止混入任何 UI 界面、Widgets、Pages、Dialogs 或 BuildContext**；
  * **绝对禁止直接编写 MethodChannel 原生平台硬编码调用**，必须全部委托给 Driver。

### 3. `*_driver` / `*_filter_*` (驱动适配器层)
* **核心职责**：实现 `*_protocol` 中定义的抽象 Driver 接口。承载 Android Kotlin、iOS Swift 等底层原生 Plugin 逻辑或第三方 SDK 适配；
* **规范要求**：
  * 每个 Android 原生驱动子包必须是合规的 Flutter Android Plugin（包含 `pubspec.yaml` plugin 声明、`build.gradle`、`AndroidManifest.xml` 与 `*Plugin.kt`）；
* **严禁红线**：
  * 绝对禁止编写具体的业务中控调度与全局规则评估引擎。

### 4. `*_connector` (装配连接器层)
* **核心职责**：作为外观模式（Facade）装配线，通过静态方法（如 `registerAll()`）将所有的 Driver 实例注入到 `*_hub` 实例中，实现零侵入式的插拔解耦。

### 5. `*_ui` (视图与交互层)
* **核心职责**：集中管理所有的 UI 页面（Pages）、挂载组件（Widgets）、弹窗（Sheets）以及 Riverpod 状态管理器（Notifiers）；
* **依赖规范**：依赖 `*_protocol` 读取数据结构，依赖 `*_hub` 触发中控调配，依赖 `*_connector` 完成环境初始化。

---

## 💡 为什么必须采用五层拆分架构？

1. **彻底解耦与可插拔性**：UI、中控、平台原生驱动彼此独立，后续更换原生驱动或跨平台移植时，中控引擎与 UI 零需变动。
2. **高可测试性**：`*_hub` 剥离了 UI 与原生平台依赖，使得单元测试（Unit Tests）可以 100% 在纯 Dart 环境下秒级完成。
3. **架构一致性**：`commercial`、`clouddrive` 与 `notification` 保持完全一致的架构规范，降低项目维护与接管成本。
