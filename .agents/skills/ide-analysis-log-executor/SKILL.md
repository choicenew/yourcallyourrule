---
name: ide-analysis-log-executor
description: 强制禁止使用任何 flutter 命令行工具。强制直接读取 IDE 后台 Analysis Server 实时诊断日志，格式化提炼报错列表，按文件与报错类型定点外科手术式精细修清，直到 IDE 后台 Log 报错彻底归零。
---

# IDE 后台实时诊断日志驱动与全量爆红清零执行协议 (IDE Analysis Log Executor Protocol)

本协议是解决代码爆红与诊断报错的最高执行门禁。所有 AI Agent 在任何诊断、修改与重构过程中，必须 100% 恪守本协议。

---

## 一、 铁律禁令 (Absolute Prohibitions)

1. **100% 严禁使用任何 `flutter` 命令行**：
   - 严禁运行 `flutter analyze`、`flutter pub`、`flutter run` 等任何 `flutter` 命令行工具；
   - 绝不重复冷启动 Dart VM 进程，绝不浪费耗费系统 CPU 与算力。

2. **严禁凭空断言“修改完成”**：
   - 在 IDE 后台分析器日志中依然存在报错时，绝对禁止对用户声称“修改完成”或“爆红已清零”；
   - 只有在 IDE 后台实时 Log 中确认 0 个 Error 时，方可终止流程。

---

## 二、 执行流程 SOP (Standard Operating Procedure)

### 步骤 1：读取并格式化 IDE 后台诊断日志 (Extract & Format IDE Log)
- 直接读取/获取 IDE 内存中常驻的 Analysis Server 实时诊断日志（或利用 IDE 内置检查接口 `analyze_file`）；
- 将日志输出格式化为清晰的报错大盘：
  ```
  [ErrorCode] | [FilePath]:[Line]:[Column] - [ErrorDescription]
  ```

### 步骤 2：按文件定点外科手术式修清 (Surgical Fix File-by-File)
- **拒绝粗暴批量正则**：禁止使用不分青红皂白的简单全局正则表达式；
- **精准阅读与拯救**：使用 `read_file` 查看报错行上下文，识别语法断裂（ missing `;` or `}`），外科手术式修复；
- **微包强类型替换**：优先使用对应 Package 导出的 Protocol 强类型实体与 Hub/ControlCenter。

### 步骤 3：循环校验与终极归零 (Loop Until Zero Errors)
- 每次修改后，重新查询 IDE 后台分析日志；
- 循环重复【提取 -> 格式化 -> 定点修复】流程，直到 IDE 后台日志报告中 **0 Errors**。
