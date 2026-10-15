---
name: strict-string-context-verification
description: 强制执行字符串字面量重构前必须 100% 追踪完整上下文与上下游数据管线（Upstream & Downstream Data Pipeline）的严苛审计规范。严禁凭空发明新常量，严禁无证据修改。
---

# 字符串字面量重构与上下游上下文严苛审计规范

> **核心原则**：任何字符串字面量的重构，必须建立在 **100% 完全摸清其源头（Upstream）与去向（Downstream）** 的基础之上。没有证据的修改一律判定为虚假重构与违规破坏！

---

## 🛑 第一条：无上下文证据，绝对严禁改动 (No Context, No Refactoring)

在看到代码中的任何硬编码字符串字面量时：
1. **严禁凭空假设**：绝对不允许直接假设该字符串是孤立的，更**严禁顺手发明一个新常量**把它打包。
2. **强制全路径检索**：必须使用 `grep` 或 `find_usages`，把该字符串在整个项目 `lib/` 目录下的所有出现位置彻底摸清。

---

## 🔍 第二条：上下游数据管道双向必查机制 (Upstream & Downstream Pipeline Trace)

在提出任何重构方案前，必须对目标字符串做以下 **双向管道审查**：

### 1. 溯源上游 (Upstream Trace)
- **数据从哪里来？**：该字符串是源自核心领域实体（如 `PhoneRule`）、数据库 Drift 表定义、原生 PlatformChannel、还是 QuickJS 插件？
- **是否存在已有标准？**：原作者是否因为偷懒，没有使用项目里**已经定义好的标准常量或枚举**（例如用 `'phone'` 替代了标准的 `'phone_rule'`）？

### 2. 追踪下游 (Downstream Trace)
- **数据去哪里？**：该字符串在下游是被 UI 的 `if` 条件分支读取？还是用来拼接 SharedPreferences 的 `config_` 键名？还是打包成 JSON 发给 Cloudflare D1 远程同步？
- **改动影响范围多大？**：如果上游改动了字符串，下游所有依赖该字符串的分支（如 `search_page.dart`）是否需要同步精准纠正？

---

## 🚫 第三条：严禁将非标准代码打包为新常量 (Never Standardize Technical Debt)

如果上游代码是因为原作者随手手滑，捏造了一个非标准字符串（例如用 `'phone'` 替代了标准的 `'phone_rule'`，用 `'allowedBlocked'` 替代了 `'allow_block'`）：
- **绝对禁止**：顺水推舟新建一个 `ruleTypePhone = 'phone'` 这种无意义的伪常量！
- **必须执行**：**上下一体重构**！将产生端与消费端同步替换为项目**早已定义好的标准核心实体常量/枚举**（例如 `PhoneRule` 原生的 `ruleType` = `'phone_rule'`）。

---

## ⚠️ 第四条：五大网络与存储边界绝对红线 (Boundaries Not To Touch)

遇到以下 5 类字符串，必须保持物理隔离，**绝对不许擅自改动其传输值**：
1. **Cloudflare Worker & D1 增量同步 RPC 节点**（`'INSERT'`, `'UPDATE'`, `'DELETE'`, `'VOTE'`）。
2. **QuickJS 插件桥接通道与 Handler 名称**（`'TestPageChannel'`, `'PluginResultChannel'`）。
3. **Android Native / iOS PlatformChannel** 接口与方法名。
4. **SharedPreferences 带 `config_` 前缀的云备份 Key**。
5. **UI 帮助弹窗里的展示性正则/说明文本示例**。

---

## 📋 第五条：Skill 强制激活与证明协议 (Mandatory Activation)

任何 AI 代理在试图审查、提议或重构项目中任何字符串之前，**必须在回复的第一行强制输出**：
`“Activate Skill: strict-string-context-verification.”`

并在文本中提供以下 **三要素书面证据**：
1. **【上游源头】**：该字符串在源头实体/类中的定义依据（附带文件与行号）。
2. **【下游去向】**：该字符串在消费端/UI 处的读取依据（附带文件与行号）。
3. **【对齐方案】**：说明是引用已有标准常量，还是上下一体同步修正。

**没有书面证据的修改提议，一律判定为违规！**
