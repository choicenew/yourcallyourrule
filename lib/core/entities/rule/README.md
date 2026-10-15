# 规则领域实体 (Rule Domain Entities) 架构说明文档

> **目录作用**：本目录存储应用核心领域层（Domain Layer）的所有规则实体定义（`RuleBase` 及其派生子类）。

---

## 🏛️ 1. 核心实体结构

所有的规则实体均继承自 `RuleBase` 抽象基类：

1. **`PhoneRule`** (`phone_rule.dart`)：
   - 规则类型：`RuleTypeKeys.phone` (`'phone_rule'`)
   - 职责：基本的电话号码拦截与标记规则。
2. **`AllowedBlockedRule`** (`allowed_blocked_rule.dart`)：
   - 规则类型：`RuleTypeKeys.allowBlock` (`'allow_block'`)
   - 职责：符合包容性规范的允许/阻止黑白名单规则。
3. **`SimSlotRule`** (`sim_slot_rule.dart`)：
   - 规则类型：`RuleTypeKeys.simSlot` (`'sim_slot'`)
   - 职责：基于多 SIM 卡槽索引的专属拦截规则。
4. **`RegexRule`** (`regex_rule.dart`)：
   - 规则类型：`RuleTypeKeys.regex` (`'regex'`)
   - 职责：基于正则表达式模式的号码与文本匹配规则。

---

## 🚫 2. 关于历史遗留文件 `white_black_rule.dart.bak`

- 历史上的 `WhiteBlackRule`（`'white_black'`）属于包容性命名规范（Inclusive Language）建立前的不合规表述。
- 现已彻底由 **`AllowedBlockedRule` (`'allow_block'`)** 完整替代。
- 原 `white_black_rule.dart` 已物理重命名为 **`white_black_rule.dart.bak`** 移出活跃编译树。
- SQLite 本地数据库中的遗留 `'white_black'` 记录在数据库打开时，通过 `drift_migration_helper.dart` 的 **`upgradeFrom4To5`** 迁移函数自动进行 SQL 一键纠正更新：
  ```sql
  UPDATE rules SET ruleType = 'allow_block' WHERE ruleType = 'white_black' OR ruleType = 'alloworblock';
  UPDATE phone_rules SET ruleType = 'allow_block' WHERE ruleType = 'white_black' OR ruleType = 'alloworblock';
  ```

---

## 🔑 3. 强类型枚举与静态常量 (`rule_type.dart`)

所有规则类型的字符串标识统一归建在 `lib/core/entities/rule/rule_type.dart`：
- `RuleTypeKeys.phone` = `'phone_rule'`
- `RuleTypeKeys.allowBlock` = `'allow_block'`
- `RuleTypeKeys.regex` = `'regex'`
- `RuleTypeKeys.simSlot` = `'sim_slot'`

严禁在任何 Service 或 UI 层手写硬编码字符串，统一使用 `RuleType` 枚举或 `RuleTypeKeys` 常量！
