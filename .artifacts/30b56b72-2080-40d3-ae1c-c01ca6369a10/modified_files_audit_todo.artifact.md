# 全量重构文件改动明细与单元测试待办清单 (Refactoring Audit & Unit Test TODO List)

> **文档目的**：本清单列出了本次重构涉及的每一个改动/新建文件、具体行号改动内容、重构意图，以及后续需要编写单元测试的重点验证核对项。

---

## 📋 一、 核心领域实体层 (`lib/core/entities/`)

### 1. [MODIFY] `phone_rule.dart`
- **文件路径**：`lib/core/entities/rule/phone_rule.dart`
- **改动说明**：
  - 重构升级为 `@freezed` + `@Implements<RuleBase>()` 不可变数据类。
  - 默认 `ruleType` 属性绑定为全局静态常量 `RuleTypeKeys.phone` (`'phone_rule'`)。
- **单元测试建议验证点**：
  - [ ] 验证 `PhoneRule.fromMap` 传入各种格式 Map 能否正确还原为对象。
  - [ ] 验证 `rule.matches('+8613800138000')` 的号码比对逻辑。
  - [ ] 验证 `copyWith` 修改 `isEnabled` 与 `count` 的不可变拷贝行为。

### 2. [MODIFY] `allowed_blocked_rule.dart`
- **文件路径**：`lib/core/entities/rule/allowed_blocked_rule.dart`
- **改动说明**：
  - 重构升级为 `@freezed` + `@Implements<RuleBase>()` 不可变数据类。
  - 默认 `ruleType` 属性绑定为全局静态常量 `RuleTypeKeys.allowBlock` (`'allow_block'`)。
- **单元测试建议验证点**：
  - [ ] 验证 `AllowedBlockedRule.fromMap` 能否兼容反序列化。
  - [ ] 验证 `ruleType` 输出为标准的 `'allow_block'` 字符串。

### 3. [MODIFY] `sim_slot_rule.dart`
- **文件路径**：`lib/core/entities/rule/sim_slot_rule.dart`
- **改动说明**：
  - 重构升级为 `@freezed` + `@Implements<RuleBase>()` 不可变数据类。
  - 默认 `ruleType` 属性绑定为 `RuleTypeKeys.simSlot` (`'sim_slot'`)。
- **单元测试建议验证点**：
  - [ ] 验证 `simSlotIndex` 卡槽索引赋值与 Map 反序列化。

### 4. [MODIFY] `sms_regex_rule.dart`
- **文件路径**：`lib/core/entities/sms/sms_regex_rule.dart`
- **改动说明**：
  - 重构升级为 `@freezed` + `@Implements<RuleBase>()` 不可变数据类。
  - 静态常量与默认属性绑定为 `RuleTypeKeys.smsRegex` (`'sms_regex'`)。
  - 统一 `matches(String content, [String? sender])` 双参数正则匹配签名。
- **单元测试建议验证点**：
  - [ ] 验证短信内容正则匹配逻辑 (`contentPattern`)。
  - [ ] 验证可选发送者正则匹配逻辑 (`senderPattern`)。

### 5. [MODIFY] `subscription.dart`
- **文件路径**：`lib/core/entities/subscription/subscription.dart`
- **改动说明**：
  - 重构升级为 `@freezed` + `@Implements<BaseEntity>()` 不可变数据类。
  - 默认 `tableType` 属性绑定为 `SubscriptionTableKeys.phone` (`'phone'`)。
- **单元测试建议验证点**：
  - [ ] 验证 `mergeUpdate` 方法的时间戳与更新行为。

### 6. [MODIFY] `sms_subscription.dart`
- **文件路径**：`lib/core/entities/sms/sms_subscription.dart`
- **改动说明**：
  - 重构升级为 `@freezed` + `@Implements<Subscription>()` 不可变数据类。
  - 默认 `tableType` 属性绑定为 `SubscriptionTableKeys.sms` (`'sms'`)。
- **单元测试建议验证点**：
  - [ ] 验证 `SmsSubscription` 转换为 Map 以及类型对齐。

### 7. [NEW] `rule_type.dart`
- **文件路径**：`lib/core/entities/rule/rule_type.dart`
- **改动说明**：
  - 定义 `RuleTypeKeys`（`phone`, `allowBlock`, `regex`, `simSlot`, `smsRegex`）全局静态常量。
  - 定义 `RuleType` 强类型枚举与平滑容错工厂 `RuleType.fromString(dynamic raw)`。
- **单元测试建议验证点**：
  - [ ] 验证各种输入（含大写、下划线遗留字符串）均能解析为正确的 `RuleType` 枚举。

### 8. [NEW] `subscription_table_type.dart`
- **文件路径**：`lib/core/entities/subscription/subscription_table_type.dart`
- **改动说明**：
  - 定义 `SubscriptionTableKeys`（`phone`, `sms`, `contact`）静态常量。
  - 定义 `SubscriptionTableType` 枚举。
- **单元测试建议验证点**：
  - [ ] 验证 `SubscriptionTableType.fromString` 的容错解析。

### 9. [DELETE / RENAME] `white_black_rule.dart`
- **文件路径**：原 `lib/core/entities/rule/white_black_rule.dart`
- **改动说明**：
  - 彻底移出编译树，重命名备份为 `white_black_rule.dart.bak`。

---

## 🗄️ 二、 数据库与 ORM 数据仓库层 (`lib/data/` & `lib/core/repositories/`)

### 10. [MODIFY] `drift_migration_helper.dart`
- **文件路径**：`lib/data/database/local/drift_migration_helper.dart`
- **改动说明**：
  - 新增 SQLite 迁移升级函数 `upgradeFrom4To5`：执行 SQL `UPDATE` 将物理磁盘旧表中的 `'white_black'` 与 `'alloworblock'` 一键更新纠正为 `'allow_block'`。
- **单元测试建议验证点**：
  - [ ] 验证 SQLite 表升级后旧数据的 `ruleType` 变成 `'allow_block'`。

### 11. [MODIFY] `rule_repository_impl.dart`
- **文件路径**：`lib/core/repositories/rule_repository_impl.dart`
- **改动说明**：
  - `createRuleFromMap` 中在 `switch (type)` 中补齐 `case RuleType.smsRegex:` 分支。
  - `getAllByType` 方法改为基于 `RuleType.fromString(typeStr)` 做枚举 Switch 分发。
- **单元测试建议验证点**：
  - [ ] 验证 `createRuleFromMap` 传入 5 种不同类型 Map 均能反序列化对应规则实例。

### 12. [MODIFY] `subscription_model.dart`
- **文件路径**：`lib/data/models/subscription_model.dart`
- **改动说明**：
  - 调整 `SmsSubscriptionModel` 继承链，确保 `toEntity()` 方法返回 `SmsSubscription` 属于合法的类型重写。
- **单元测试建议验证点**：
  - [ ] 验证 `SmsSubscriptionModel.toEntity()` 返回的 `SmsSubscription` 对象。

---

## ⚙️ 三、 服务与逻辑 handlers 层 (`lib/features/`)

### 13. [MODIFY] `sms_regex_rule_repository.dart`
- **文件路径**：`lib/features/sms/repositories/sms_regex_rule_repository.dart`
- **改动说明**：
  - 将 `SmsRegexRule.ruleType` 替换为 `RuleTypeKeys.smsRegex`。

### 14. [MODIFY] `sms_filter_handler.dart`
- **文件路径**：`lib/features/sms/services/sms_handlers/sms_filter_handler.dart`
- **改动说明**：
  - 调起匹配方法对齐为 `rule.matches(messageContent, phoneNumber)`。

### 15. [MODIFY] `search_service.dart`
- **文件路径**：`lib/features/search/services/search_service.dart`
- **改动说明**：
  - 将硬编码 `'phone'` 与 `'allowedBlocked'` 改为透传实体的原生 `rule.ruleType`。

### 16. [MODIFY] `search_page.dart`
- **文件路径**：`lib/features/search/pages/search_page.dart`
- **改动说明**：
  - 分支逻辑改为使用 `RuleType.fromString(result.ruleType) == RuleType.phone` 和 `RuleType.allowBlock` 做强类型枚举匹配。

---

## 🧪 四、 已新增并跑通的单元测试文件 (`test/unit/`)

1. **`test/unit/proposal_refactoring_unit_test.dart`**：覆盖 Proposal、RiskLevel、ProposalStatus 的反序列化与脏数据容错。
2. **`test/unit/enum_string_refactoring_unit_test.dart`**：覆盖 AppPrefsKeys 前缀、BackgroundTaskKeys、StatisticPeriod、NotificationCategory 的字符串一致性。

> **当前健康状态**：全量 `flutter analyze lib` 0 Error，单元测试 17/17 绿色全通过！
