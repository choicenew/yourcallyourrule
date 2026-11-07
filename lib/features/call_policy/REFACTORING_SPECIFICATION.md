# 4 层微模块重构与 `caller_id` 拆分规范文档 (Refactoring & Specification)

> **生成时间**：2026-11-05  
> **使用对象**：接手的 AI 代理（AI Agents）与核心开发团队  
> **硬性约束**：原 `lib/features/caller_id/` 目录 100% 完好保留作为对照标杆，严禁修改或删除！

---

## 目录
1. [重构目标与 4 层解耦架构定义](#1-重构目标与-4-层解耦架构定义)
2. [消除中间人与命名规范（Google & Apple 官方标准）](#2-消除中间人与命名规范google--apple-官方标准)
3. [33 个原文件外科手术式拆分与归位全量对照大表](#3-33-个原文件外科手术式拆分与归位全量对照大表)
4. [避坑指南：先前拆分出现的报错点与根治方案](#4-避坑指南先前拆分出现的报错点与根治方案)
5. [给后续 AI 代理的 100% 严格执行 Step-by-Step SOP](#5-给后续-ai-代理的-100-严格执行-step-by-step-sop)

---

## 1. 重构目标与 4 层解耦架构定义

本重构旨在消除原 `caller_id` 大杂烩神类的严重耦合，在外围搭建符合 **Google Android Telecom 与 Apple iOS CallKit 官方标准** 的 4 大独立微模块：

```text
lib/features/
├── call_monitor/               # Layer 1: 纯原生通道监听器 (接收 Native 原始 MethodCall)
│   ├── events/call_monitor_events.dart
│   ├── handlers/               # 9 个事件 Handler (1:1 保持原名)
│   └── services/caller_id_monitor_service.dart
│
├── caller_identity/            # Layer 2: 官方标准来电身份画像 (对齐 Google / Apple 规范)
│   ├── models/caller_profile.dart            # (CallerProfile 强类型模型)
│   ├── services/caller_identity_service.dart # (7 大数据源聚合与双路增量 Stream 刷新)
│   └── config/                               # 查号与身份配置
│
├── call_policy/                # Layer 3: 纯拦截决策引擎 (黑白名单 + 双卡 + 时间段)
│   ├── evaluators/                           # 本地策略评估器、时间段静音、拦截动作
│   └── rules/                                # 挂断规则映射
│
└── call_coordinator/           # Layer 4: Master 编排中枢 (彻底消灭二道贩子 caller_id_handler 中间人!)
    ├── services/call_coordinator_service.dart # 串联: Monitor -> Policy -> Identity -> UI/Log
    └── handlers/                             # 9 个 UI/通知/灵动岛 Handler (1:1 保持原名)
```

---

## 2. 消除中间人与命名规范（Google & Apple 官方标准）

1. **彻底消灭 `caller_id_handler.dart` 中间人**：
   * 在原版中，`caller_id_handler.dart` 充当了“二道贩子”，夹在通道和 UI 之间硬等 500ms，手伸得很长。
   * **新架构规则**：由 `CallCoordinatorService` 中枢直接接收 `call_monitor` 事件，直接调用 `caller_identity` 查号，并驱动 `display_mode_handler` 弹窗。彻底消灭 `caller_id_handler`！

2. **对齐 Google & Apple 官方命名 `caller_identity`**：
   * **Android Telecom 规范**：使用 `Caller Identity` / `CallerInfo` 表示查出的身份。
   * **iOS CallKit 规范**：使用 `CXCallDirectoryManager` / `Caller Identification` 表示识别标示。
   * 原先名字叫 `caller_id` 容易造成歧义，正式对齐更名为 **`caller_identity`**（模型命名为 `CallerProfile`）。

3. **切禁乱改原名规则**：
   * 原名清晰的类/服务（如 `TimeInterceptorService`、`SimSlotRuleFilterService`、`IncomingCallHandler`），**100% 保持原名，严禁瞎改**！

---

## 3. 33 个原文件外科手术式拆分与归位全量对照大表

| 序号 | 原 `lib/features/caller_id/` 文件相对路径 | 文件内包含的具体功能点 | 切分归位后的新目标路径 | 目标路径下的文件名 (1:1 保持原名) |
| :---: | :--- | :--- | :--- | :--- |
| **1** | `services/caller_id_monitor_service.dart` | 纯原生 MethodChannel 监听与事件广播 | `lib/features/call_monitor/services/` | `caller_id_monitor_service.dart` |
| **2** | `services/call_handlers/base_call_handler.dart` | 抽象 Handler 接口与 Factory | `lib/features/call_monitor/handlers/` | `base_call_handler.dart` |
| **3** | `services/call_handlers/call_event_handler.dart` | `onIncomingCall`/`onOutgoingCall` 原生事件路由 | `lib/features/call_monitor/handlers/` | `call_event_handler.dart` |
| **4** | `services/call_handlers/incoming_call_handler.dart` | **【切片 1】**：通道交互与 `sendDecision` 回调 | `lib/features/call_monitor/handlers/` | `incoming_call_handler.dart` |
| **—** | 👆 *(同上 `incoming_call_handler.dart`)* | **【切片 2】**：卡槽与时间段拦截计算 | `lib/features/call_policy/evaluators/` | `incoming_call_policy_evaluator.dart` |
| **5** | `services/call_handlers/outgoing_call_handler.dart` | 去电原生响应与状态通知 | `lib/features/call_monitor/handlers/` | `outgoing_call_handler.dart` |
| **6** | `services/call_handlers/end_call_handler.dart` | 挂断与 `interceptAction` 执行 | `lib/features/call_monitor/handlers/` | `end_call_handler.dart` |
| **7** | `services/call_handlers/should_accept_call_handler.dart`| `shouldAcceptCall` 单次决策 Completer 通道 | `lib/features/call_monitor/handlers/` | `should_accept_call_handler.dart` |
| **8** | `services/call_handlers/sim_call_handler.dart` | SIM 卡槽 500ms 竞态提取与 `SimInfo` 状态 | `lib/features/call_monitor/handlers/` | `sim_call_handler.dart` |
| **9** | `services/call_handlers/stir_call_handler.dart` | STIR 防伪 500ms 竞态提取与 `StirInfo` 状态 | `lib/features/call_monitor/handlers/` | `stir_call_handler.dart` |
| **10**| `services/call_handlers/intercept_event_provider.dart` | 拦截事件 StreamController | `lib/features/call_monitor/handlers/` | `intercept_event_provider.dart` |
| **11**| `services/call_screen_plugin.dart` | 门禁插件底层通信工具 | `lib/features/call_monitor/services/` | `call_screen_plugin.dart` |
| **12**| `services/caller_id_service.dart` | 7 大数据源并发拉取、归属地、预定义标签兜底 | `lib/features/caller_identity/services/` | `caller_identity_service.dart` |
| **13**| `services/plugin_to_remote_sync_service.dart` | 插件数据遥测落库与同步 | `lib/features/caller_identity/services/` | `plugin_to_remote_sync_service.dart` |
| **14**| `config/caller_id_config_provider.dart` | 显示模式与通知配置 Notifier | `lib/features/caller_identity/config/` | `caller_identity_config_provider.dart` |
| **15**| `config/caller_id_config_repository.dart` | SharedPreferences 配置持久化仓库 | `lib/features/caller_identity/config/` | `caller_identity_config_repository.dart` |
| **16**| `presentation/pages/caller_id_settings_page.dart` | 查号与显示模式设置页面 | `lib/features/caller_identity/presentation/` | `caller_identity_settings_page.dart` |
| **17**| `services/call_protection_service.dart` | 防护开启状态检查 | `lib/features/call_policy/evaluators/` | `call_protection_service.dart` |
| **18**| `services/fraud_detection_service.dart` | 诈骗标签识别与警示触发器 | `lib/features/call_policy/evaluators/` | `fraud_detection_service.dart` |
| **19**| `services/end_call_rule_action_mapper.dart` | 挂断规则动作映射 | `lib/features/call_policy/rules/` | `end_call_rule_action_mapper.dart` |
| **20**| `config/intercept_action.dart` | 拦截动作枚举 | `lib/features/call_policy/evaluators/` | `intercept_action.dart` |
| **21**| `config/intercept_action_config_provider.dart` | 默认拦截动作 Provider | `lib/features/call_policy/evaluators/` | `intercept_action_config_provider.dart` |
| **22**| `presentation/pages/end_call_settings_page.dart` | 挂断拦截方式设置页面 | `lib/features/call_policy/presentation/` | `end_call_settings_page.dart` |
| **23**| `services/call_handlers/overlay_handler.dart` | `FloatingWindowAndroid` 悬浮窗弹窗与显示 | `lib/features/call_coordinator/handlers/` | `overlay_handler.dart` |
| **24**| `services/call_handlers/overlay_control_handler.dart` | 接听/挂断/拦截时自动关闭悬浮窗 | `lib/features/call_coordinator/handlers/` | `overlay_control_handler.dart` |
| **25**| `services/call_handlers/notification_handler.dart` | `NotificationService` 拦截/诈骗/STIR 通知 | `lib/features/call_coordinator/handlers/` | `notification_handler.dart` |
| **26**| `services/call_handlers/live_activity_handler.dart` | 标准 iOS Live Activity 灵动岛驱动 | `lib/features/call_coordinator/handlers/` | `live_activity_handler.dart` |
| **27**| `services/call_handlers/kit_live_activity_handler.dart`| 现代 iOS 灵动岛多形态节点渲染 | `lib/features/call_coordinator/handlers/` | `kit_live_activity_handler.dart` |
| **28**| `services/call_handlers/display_mode_handler.dart` | 悬浮窗/通知/灵动岛三态显示模式路由 | `lib/features/call_coordinator/handlers/` | `display_mode_handler.dart` |
| **29**| **`services/call_handlers/caller_id_handler.dart`** | **🔥 彻底删掉 (不复存在)** | **消灭中间人** | **无需迁移** |
| **30**| `services/call_handlers/caller_id_handler_extension.dart`| `CallLogRecorder` 通话日志写入扩展 | `lib/features/call_coordinator/handlers/` | `call_log_extension.dart` |
| **31**| `services/call_handlers/call_log_integration_example.dart`| 通话日志集成示例 | `lib/features/call_coordinator/handlers/` | `call_log_integration_example.dart` |
| **32**| `config/display_mode.dart` | 显示模式枚举 | `lib/features/call_coordinator/handlers/` | `display_mode.dart` |
| **33**| `presentation/widgets/caller_id_display_mode_selector.dart`| 显示模式选择器 Widget | `lib/features/call_coordinator/presentation/`| `display_mode_selector.dart` |

---

## 4. 避坑指南：先前拆分出现的报错点与根治方案

1. **`dlibphonenumber.Locale` 类型冲突问题**：
   * **问题**：`caller_identity_service.dart` 里的 `getCallerId(phoneNumber, Locale locale)`，其 `locale` 类型**必须使用** `import 'package:dlibphonenumber/dlibphonenumber.dart';` 的 `Locale`，**严禁引入 `dart:ui` 的 `Locale`**（`dart:ui` 的 `Locale` 无 `.country` 属性）。
   * **写法**：
     ```dart
     import 'package:dlibphonenumber/dlibphonenumber.dart';
     import 'package:flutter/material.dart' hide Locale;
     ```

2. **`notificationServiceProvider` 未定义报错**：
   * **问题**：在 `notification_handler.dart` 中，必须明确导入 notification 模块的真实 Provider 文件：
     ```dart
     import 'package:yourcallyourrule/features/notifications/providers/notification_providers.dart';
     ```

3. **依赖路径纠正**：
   * 所有迁移到新目录下的 Handler，必须将其顶部的相对路径 `import '../../config/...'` 统一修正为完整的 package 路径 `import 'package:yourcallyourrule/features/...'`。

---

## 5. 给后续 AI 代理的 100% 严格执行 Step-by-Step SOP

1. **Step 1 (验证底线)**：确认原 `lib/features/caller_id/` 目录 100% 保持不动。
2. **Step 2 (复制代码)**：严格对照上表，将原文件 1:1 复制落盘到对应的 4 个新微模块目录中。
3. **Step 3 (修复 import 路径)**：
   * 修复 `notification_handler.dart` 中的 `notification_providers.dart` 导入。
   * 修复 `caller_identity_service.dart` 中的 `dlibphonenumber.Locale` 导入。
4. **Step 4 (静态过检)**：使用 `analyze_file` 对新建的每一个文件进行检查，确保 0 Error。
