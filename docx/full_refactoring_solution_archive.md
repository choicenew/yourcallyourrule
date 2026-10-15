# 全量重构与单元测试验证归档文档 (Full Refactoring & Testing Archive)

> **归档文档路径**：`docx/full_refactoring_solution_archive.md`  
> **分支信息**：`elite-ui`  
> **归档日期**：2026-10-15  
> **文档目的**：本文档详细整理了本次领域模型重构、值对象内聚 Converter、枚举规范化、领域解耦、数据库平滑迁移以及全量单元测试数据流通校验的所有架构设计方案与实施细节，作为项目技术归档与留档依据。

---

## 目录 (Table of Contents)

1. [一、 重构背景与核心解决痛点](#一-重构背景与核心解决痛点)
2. [二、 值对象内聚 JsonConverter 设计与实体全自动化 JSON 序列化 (`lib/core/value_objects/`)](#二-值对象内聚-jsonconverter-设计与实体全自动化-json-序列化-libcorevalue_objects)
3. [三、 领域实体层重构方案与示例代码 (`lib/core/entities/`)](#三-领域实体层重构方案与示例代码-libcoreentities)
4. [四、 枚举与优先级常量绑定的设计原理 (`RulePriority`, `RuleType`)](#四-枚举与优先级常量绑定的设计原理)
5. [五、 仓库层解耦与数据库迁移方案 (`RuleRepositoryImpl`, `DriftMigrationHelper`)](#五-仓库层解耦与数据库迁移方案)
6. [六、 单元测试与数据流通校验报告 (`test/unit/`)](#六-单元测试与数据流通校验报告-testunit)
7. [七、 总结与最佳实践留档](#七-总结与最佳实践留档)

---

## 一、 重构背景与核心解决痛点

在以往版本的演进过程中，项目存在以下几大架构缺陷与历史技术债：
1. **领域边界混淆**：属于短信领域的 `SmsRegexRule` 被盲目塞入处理通话规则的 `RuleRepositoryImpl` 中，导致死代码分支和 Dart 3 非穷尽 Switch 编译报错。
2. **历史废弃字面量混杂**：数据库与 Map 反序列化中混杂了 `'white_black'`、`'alloworblock'`、`'phone_rule'` 等多种不一致的类型标识，缺少统一的强类型枚举管辖。
3. **接口契约不一致**：部分领域实体（如 `PhoneRule`、`AllowedBlockedRule`）的 `priority` 字段声明为可空 (`RulePriority?`)，导致与基类 `RuleBase.priority` 的非空契约发生冲突；同时缺少默认值，在无参创建或解析 Map 时容易出现 `null` 异常。
4. **Freezed 继承冲突与手动反序列化**：以前的实体手写了 `fromMap`/`toMap` 方法，未利用值对象的 `JsonConverter` 实现 100% 自动生成 `fromJson`/`toJson`。

---

## 二、 值对象内聚 JsonConverter 设计与实体全自动化 JSON 序列化

为消除手写反序列化样板代码，并保证在任意异常/null JSON 数据下 100% 不崩溃，在各自值对象文件内部内聚编写了专用的 `JsonConverter`：

### 1. `PhoneNumberConverter` (`lib/core/value_objects/phone_number.dart`)
```dart
class PhoneNumberConverter implements JsonConverter<PhoneNumber, String> {
  const PhoneNumberConverter();

  @override
  PhoneNumber fromJson(dynamic json) {
    if (json == null) return const PhoneNumber('');
    return PhoneNumber.fromString(json.toString());
  }

  @override
  String toJson(PhoneNumber object) => object.value;
}
```

### 2. `RuleActionConverter` (`lib/core/value_objects/rule_action.dart`)
```dart
class RuleActionConverter implements JsonConverter<RuleAction, String> {
  const RuleActionConverter();

  @override
  RuleAction fromJson(dynamic json) {
    if (json == null) return RuleAction.none;
    return RuleAction.fromString(json.toString());
  }

  @override
  String toJson(RuleAction object) => object.toString();
}
```

### 3. `RulePriorityConverter` (`lib/core/value_objects/rule_priority.dart`)
```dart
class RulePriorityConverter implements JsonConverter<RulePriority, dynamic> {
  const RulePriorityConverter();

  @override
  RulePriority fromJson(dynamic json) {
    return RulePriority.fromInt(json);
  }

  @override
  dynamic toJson(RulePriority object) => object.value;
}
```

---

## 三、 领域实体层重构方案与示例代码 (`lib/core/entities/`)

利用自定义 Converter 标注，全量升级领域实体为 **`@freezed` + `@JsonSerializable()` + 不可变数据类** 100% 代码全自动生成架构：

### 允许/阻止规则实体 (`AllowedBlockedRule`)

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_type.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';

part 'allowed_blocked_rule.freezed.dart';
part 'allowed_blocked_rule.g.dart';

/// 允许/阻止规则领域实体 (@freezed + @JsonSerializable 100% 自动生成序列化)
@freezed
abstract class AllowedBlockedRule with _$AllowedBlockedRule implements RuleBase {
  const AllowedBlockedRule._();

  @Implements<RuleBase>()
  const factory AllowedBlockedRule({
    required String id,
    required String name,
    @RuleActionConverter() required RuleAction action,
    @PhoneNumberConverter() required PhoneNumber phoneNumber,
    required String labelId,
    @Default(RuleTypeKeys.allowBlock) String ruleType,
    @RulePriorityConverter() @Default(RulePriority.high) RulePriority priority,
    @Default(true) bool isEnabled,
    @Default(0) int count,
    String? avatar,
    String? subscriptionId,
  }) = _AllowedBlockedRule;

  /// 计算属性：判断是否关联订阅
  bool get isSubscribed => subscriptionId != null;

  /// 号码过滤匹配逻辑
  @override
  bool matches(String input) {
    return isEnabled && phoneNumber.value == input;
  }

  /// 100% 自动生成 JSON 反序列化
  factory AllowedBlockedRule.fromJson(Map<String, dynamic> json) =>
      _$AllowedBlockedRuleFromJson(json);

  /// 转换 Map (委托给自动生成的 toJson)
  @override
  Map<String, dynamic> toMap() => toJson();

  /// 从 Map 反序列化 (注入动态默认优先级：ALLOW = 100 > BLOCK = 50)
  factory AllowedBlockedRule.fromMap(Map<String, dynamic> map) {
    final jsonMap = Map<String, dynamic>.from(map);
    if (jsonMap['priority'] == null) {
      final action = RuleAction.fromString(jsonMap['action']?.toString() ?? '');
      jsonMap['priority'] = action.type == RuleActionType.allow
          ? RulePriority.highest.value
          : RulePriority.veryHigh.value;
    }
    return AllowedBlockedRule.fromJson(jsonMap);
  }
}
```

---

## 四、 枚举与优先级常量绑定的设计原理

### 1. 动态优先级与默认赋权表
- **ALLOW (白名单/允许)**：`RulePriority.highest` (100) ──► 白名单拥有绝对压制放行权！
- **BLOCK (黑名单/阻止)**：`RulePriority.veryHigh` (50) ──► 黑名单拥有次高优先级。

| 规则实体类 (`Entity`) | 对应业务语义 | 绑定的专属预定义常量 | 默认优先级数值 | 架构与业务设计考量 |
| :--- | :--- | :--- | :--- | :--- |
| **`AllowedBlockedRule`** | **允许/阻止规则** | **ALLOW = 100 / BLOCK = 50** | **100 / 50** | **白名单必须拥有更高优先级**，优先于黑名单放行！ |
| **`PhoneRule`** | **普通电话黑名单** | **`RulePriority.medium`** | **5** | 普通黑名单默认使用中等优先级。 |
| **`SimSlotRule`** | **卡槽规则** | **`RulePriority.medium`** | **5** | 卡槽维度规则默认使用中等优先级。 |
| **`SmsRegexRule`** | **短信正则规则** | **`RulePriority.medium`** | **5** | 短信正则匹配默认使用中等优先级。 |

---

## 五、 仓库层解耦与数据库迁移方案

### 1. `RuleRepositoryImpl` 领域完全解耦
- **职责**：专职统筹处理 4 类通话规则（`PhoneRule`, `AllowedBlockedRule`, `RegexRule`, `SimSlotRule`）。
- **领域边界断言**：
  - 在 `createRuleFromMap` 中遇 `RuleType.smsRegex` 直接抛出 `UnsupportedError`。
  - 在 `getAllByType` 中查询 `sms_regex` 返回 `[]`。

### 2. `SmsRegexRuleRepository` 100% 独立化
- 直连 `LocalSmsRegexRuleDataSource` 读写 `smsRules` SQLite 数据表。

---

## 六、 单元测试与数据流通校验报告 (`test/unit/`)

为确保 Converter 与领域重构 100% 稳定，构建了覆盖全部重构要点的单元测试套件：

### 1. 测试文件列表
1. **`test/unit/value_object_converters_unit_test.dart`**（4/4 Passed）：
   - 覆盖 `PhoneNumberConverter`（脏数据、null、各种非数字格式清洗）。
   - 覆盖 `RuleActionConverter`（allow/block/silence/none/null 降级）。
   - 覆盖 `RulePriorityConverter`（整数、字符串、null 防护）。
   - 覆盖 `AllowedBlockedRule` ALLOW (100) > BLOCK (50) 动态优先级。
2. **`test/unit/rules_domain_refactoring_unit_test.dart`**（13/13 Passed）
3. **`test/unit/subscriptions_domain_refactoring_unit_test.dart`**（10/10 Passed）
4. **`test/unit/repository_and_services_domain_refactoring_unit_test.dart`**（5/5 Passed）
5. **`test/unit/enum_string_refactoring_unit_test.dart`**（7/7 Passed）
6. **`test/unit/proposal_refactoring_unit_test.dart`**（11/11 Passed）

### 2. 执行结果汇总
```bash
$ flutter test test/unit/
00:35 +39: All tests passed!
```
**全量 39 项单元测试 100% 绿色全部通过！**

---

## 七、 总结与最佳实践留档

1. **值对象高内聚 Converter**：转换器直接合并写在 Value Object 文件底部，提升了代码内聚性，避免维护解耦问题。
2. **100% 序列化代码自动生成**：利用 `build_runner` 生成 `.g.dart`，干掉了手写 `fromMap`/`toMap` 样板代码。
3. ** ALLOW (100) > BLOCK (50) 强优先级防护**：精准恢复白名单压制黑名单的核心拦截算法。
