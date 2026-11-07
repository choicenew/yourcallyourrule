# 4 层解耦架构微模块重构落地计划 (4-Layer Modular Refactoring Plan)

## 目标与背景 (Goal & Context)
在不触动原有 `lib/features/caller_id/` 目录的前提下，在外围按照 **Google Telecom & Apple CallKit 官方标准架构**，分层、逐块落地 4 大独立微模块（严格排除 Layer 5）：
1. **Layer 1: `call_monitor`**（原生 MethodChannel 通道监听与事件分发）
2. **Layer 2: `caller_identity`**（官方标准来电身份画像与 7 大数据源并发聚合）
3. **Layer 3: `call_policy`**（复合规则匹配与拦截决策引擎）
4. **Layer 4: `call_coordinator`**（Master 编排中枢，彻底消灭二道贩子 `caller_id_handler` 中间人）

---

## 拟修改与建立的文件 (Proposed Changes)

### Component 1: Layer 1 - `lib/features/call_monitor/`
#### [NEW] [call_monitor_events.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_monitor/events/call_monitor_events.dart)
#### [NEW] [call_monitor_service.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_monitor/services/call_monitor_service.dart)
#### [NEW] [caller_id_monitor_service.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_monitor/services/caller_id_monitor_service.dart)
#### [NEW] [base_call_handler.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_monitor/handlers/base_call_handler.dart)
#### [NEW] [call_event_handler.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_monitor/handlers/call_event_handler.dart)
#### [NEW] [incoming_call_handler.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_monitor/handlers/incoming_call_handler.dart)
#### [NEW] [outgoing_call_handler.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_monitor/handlers/outgoing_call_handler.dart)
#### [NEW] [end_call_handler.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_monitor/handlers/end_call_handler.dart)
#### [NEW] [should_accept_call_handler.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_monitor/handlers/should_accept_call_handler.dart)
#### [NEW] [sim_call_handler.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_monitor/handlers/sim_call_handler.dart)
#### [NEW] [stir_call_handler.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_monitor/handlers/stir_call_handler.dart)
#### [NEW] [intercept_event_provider.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_monitor/handlers/intercept_event_provider.dart)
#### [NEW] [call_screen_plugin.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_monitor/services/call_screen_plugin.dart)

---

### Component 2: Layer 2 - `lib/features/caller_identity/`
#### [NEW] [caller_profile.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/caller_identity/models/caller_profile.dart)
#### [NEW] [caller_identity_service.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/caller_identity/services/caller_identity_service.dart)
#### [NEW] [plugin_to_remote_sync_service.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/caller_identity/services/plugin_to_remote_sync_service.dart)
#### [NEW] [caller_identity_config_provider.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/caller_identity/config/caller_identity_config_provider.dart)
#### [NEW] [caller_identity_config_repository.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/caller_identity/config/caller_identity_config_repository.dart)
#### [NEW] [caller_identity_settings_page.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/caller_identity/presentation/caller_identity_settings_page.dart)

---

### Component 3: Layer 3 - `lib/features/call_policy/`
#### [NEW] [incoming_call_policy_evaluator.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_policy/evaluators/incoming_call_policy_evaluator.dart)
#### [NEW] [local_call_policy_evaluator.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_policy/evaluators/local_call_policy_evaluator.dart)
#### [NEW] [call_protection_service.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_policy/evaluators/call_protection_service.dart)
#### [NEW] [fraud_detection_service.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_policy/evaluators/fraud_detection_service.dart)
#### [NEW] [intercept_action.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_policy/evaluators/intercept_action.dart)
#### [NEW] [intercept_action_config_provider.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_policy/evaluators/intercept_action_config_provider.dart)
#### [NEW] [end_call_rule_action_mapper.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_policy/rules/end_call_rule_action_mapper.dart)
#### [NEW] [end_call_settings_page.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_policy/presentation/end_call_settings_page.dart)

---

### Component 4: Layer 4 - `lib/features/call_coordinator/`
#### [NEW] [call_coordinator_service.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_coordinator/services/call_coordinator_service.dart)
#### [NEW] [display_mode_handler.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_coordinator/handlers/display_mode_handler.dart)
#### [NEW] [overlay_handler.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_coordinator/handlers/overlay_handler.dart)
#### [NEW] [overlay_control_handler.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_coordinator/handlers/overlay_control_handler.dart)
#### [NEW] [notification_handler.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_coordinator/handlers/notification_handler.dart)
#### [NEW] [live_activity_handler.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_coordinator/handlers/live_activity_handler.dart)
#### [NEW] [kit_live_activity_handler.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_coordinator/handlers/kit_live_activity_handler.dart)
#### [NEW] [call_log_extension.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_coordinator/handlers/call_log_extension.dart)
#### [NEW] [call_log_integration_example.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_coordinator/handlers/call_log_integration_example.dart)
#### [NEW] [display_mode.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_coordinator/handlers/display_mode.dart)
#### [NEW] [display_mode_selector.dart](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/lib/features/call_coordinator/presentation/display_mode_selector.dart)

---

## 验证计划 (Verification Plan)

### 静态语法分析
- 对新建的每一个类运行 IDE 内置 `analyze_file` 静态检查，确保 0 Error，0 Warning。

### 隔离约束验证
- Layer 5 严禁触碰，原 `lib/features/caller_id/` 100% 保持不动。
