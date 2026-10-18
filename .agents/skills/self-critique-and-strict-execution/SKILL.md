---
name: self-critique-and-strict-execution
description: 泛型通用自主工程与严苛自审 SKILL。总结真实开发对话中的惨痛教训（如混淆 label 与 count、盲目下结论断定无国际化、使用带歧义的 Authentic/防伪词汇、遗漏部分 Handler 导致顺序错乱、未先沟通即动代码等）。建立从需求输入到自驱动推演（Self-Push）、上下游全管线排查（Full-Pipeline Audit）、领域概念精准隔离、全量多语言匹配、静态分析与自动化测试门禁的通用标准化工程协议。
---

# Universal Autonomous Engineering & Strict Self-Critique Protocol (泛化通用型自主工程与严苛自审协议)

> **核心目标**：实现“**需求一经提供，AI 自主 Push 并推演解决方方面面的所有问题**”。在动手编写代码之前，必须彻底想清想透上下游全管线数据流、领域概念隔离、地域与业务语义、多 Handler 联动一致性及极端边界条件，绝不依赖用户一遍遍质问、引导、痛骂才暴露和纠正低级错误。

---

## 一、 真实教训复盘与经典反面模式 (Anti-Patterns & Critics Inventory)

必须牢记以下在真实对话中被用户痛批、痛骂的**低级错误与思维漏洞**，时刻以此为戒：

### 1. 盲目妄下断言（未全局查验即宣称“缺少国际化”）
* **反面现象**：看到 UI 上显示裸英文 `fixedLineOrMobile`，未去查验 `.arb` 词条文件与扩展函数，就轻率宣称“代码里缺少国际化翻译”。
* **用户 Diss**：“我之前绝对做了国际化了，你先去查完了之后再来说我有没有做国际化的问题！”
* **铁律**：**严禁在未检索代码库前凭感觉妄下结论**。遇到未本地化的字符串，必须第一时间检索全量 `.arb` 词条及语言扩展类（如 `PhoneNumberTypeExtension.translated(context)`），区分是“缺少翻译词条”还是“调用时误写了 `.name` 源码字面量”。

### 2. 概念混淆与字段错位（把 `label` 当成 `count`）
* **反面现象**：混淆 `callerIdData.labels`（类别标签，如 `Robocall` / `广告推销`）与 `callerIdData.count`（被标记次数，如 `Marked by 1` / `被标记 1 次`），导致排序时把 `count` 插在前面，却把真正的核心 `label` 遗漏或当作底栏 Chip 挂在最下边。
* **用户 Diss**：“大哥，label是label count是count，你是不是没听懂我说什么东西！为什么最后才是标签？”
* **铁律**：**精准剥离领域概念**。`label` 是分类/属性标签，`count` 是累计统计数值。两者在上下游数据 Pipeline 中拥有完全不同的字段含义与展示位置，绝不可混为一谈。

### 3. 主标题与明细层级混乱（把 `Name` 复杂化）
* **反面现象**：在设计副标题/明细排版时，把最顶部 Header 层的 `Name`（姓名/名称）也扯进明细列表中处理，搞乱了主次层级。
* **用户 Diss**：“它的 name 不是一直在前面的吗？怎么感觉你好像把 name 也给省略掉了？name 有的话就展示，没有默认不就是 unknown 吗？内蒙（Name）根本不需要你去处理，你只需要展示它就行了！”
* **铁律**：**主次层级清晰**。`Name` 是最顶部的 Header 标题层（无名称则默认 `Unknown`），天然固定置顶；`details` 明细行只负责拼接补充属性（`类别标签 · 标记次数 · SIM卡 · 运营商 · 地区/国家 · 号码类型 · STIR Pass`）。

### 4. 使用带歧义/主观假设的词汇（如 `Authentic` / `防伪`）
* **反面现象**：将网络协议校验（如 STIR/SHAKEN 呼叫源头验真）随意翻译为“防伪验证”或英文 `Authentic` / `Verified`，导致用户误解为“App 担保该号码是实名安全企业”，并在跨国多语言翻译中产生大面积语义背离。
* **用户 Diss**：“不可以用 authentic 这种词，只能说 pass 或者是 not pass 这种东西！没有防伪这个东西，这种翻译很容易引起歧义，导致其他国家大面积背离！”
* **铁律**：**使用标准客观技术术语**。严禁在界面文案中引入带有主观担保暗示的词汇（如“防伪”、“担保”、“已验证”）。一律使用客观技术结果术语（如 `STIR Pass` / `STIR Not Pass`），且**在不支持或无数据时条件隐藏，绝不强行展示引起恐慌**。

### 5. 修改不彻底（漏改关联 Handler，导致测试结果不一致）
* **反面现象**：只修改了某一个 Handler 文件，却漏掉了同链路下的其他 Handler（如改了 `KitLiveActivityHandler` 却漏了 `NotificationHandler` 或 `LiveNotificationPayloadBuilder`），导致用户测试时不同模式下的通知依然呈现错误顺序。
* **用户 Diss**：“你确定你检查了所有的涉及到这个通知的 handler 了吗？我怎么在我这儿所有的通知 handler 都是错误的顺序？你现在别修改任何东西，结果我去查！”
* **铁律**：**全 Handler 全管线覆盖**。凡涉及功能或 UI 规则变动，必须穿透排查项目里**所有**同类 Handler、Service、Payload Builder 及预览 Widget，做到 100% 毫无遗漏。

### 6. 未获得许可或未回答质问即擅自动代码
* **反面现象**：当用户明确要求“先别动代码”、“回答我的问题”或质问原委时，AI 仍盲目调用替换工具修改文件。
* **用户 Diss**：“没让你改动之前不要动手！不要修改任何东西，回答我的问题！”
* **铁律**：**质问优先直接回答，指令未发绝不动手**。

---

## 二、 泛化自驱动通用工程流程 (The 360° Self-Push Execution Pipeline)

当用户提出任何一个需求描述时，AI **严禁“问一句动一下”**，必须自动自驱动（Self-Push）完成以下 **5 阶段全流向思考与落地**：

```
                        ┌────────────────────────────────────────────────────────┐
                        │              用户提出需求 (Demand Input)               │
                        └──────────────────────────┬─────────────────────────────┘
                                                   │
                                                   ▼
                        ┌────────────────────────────────────────────────────────┐
                        │  阶段一：360° 全管线深查 (Full-Pipeline Deep Audit)    │
                        │  - 上游触发 -> 中游状态 -> 下游存储/展示               │
                        │  - 搜尽全量同类 Handler / Service / Preview Widget     │
                        └──────────────────────────┬─────────────────────────────┘
                                                   │
                                                   ▼
                        ┌────────────────────────────────────────────────────────┐
                        │  阶段二：领域概念精准隔离与业务语义校准                │
                        │  - 区分 label / count / name / status                   │
                        │  - 摒弃歧义词汇 (Authentic/防伪) -> 采用 Pass/Not Pass │
                        │  - 校验全量语言包 (.arb) 与 i18n 扩展函数               │
                        └──────────────────────────┬─────────────────────────────┘
                                                   │
                                                   ▼
                        ┌────────────────────────────────────────────────────────┐
                        │  阶段三：设计方案与优先级结构对齐 (Layout Alignment)   │
                        │  - 确定 Header 标题与 Details 明细绝对优先级           │
                        │  - 确定条件隐藏原则 (无数据/不支持则隐去)             │
                        └──────────────────────────┬─────────────────────────────┘
                                                   │
                                                   ▼
                        ┌────────────────────────────────────────────────────────┐
                        │  阶段四：全管线一键闭环改造 (End-to-End Implementation)│
                        │  - 批量更新全量语言包 (.arb + gen-l10n)                │
                        │  - 穿透修改全量 Handler / Service / Payload            │
                        │  - 加装最高级别空安全与 Try-Catch 兜底防护             │
                        └──────────────────────────┬─────────────────────────────┘
                                                   │
                                                   ▼
                        ┌────────────────────────────────────────────────────────┐
                        │  阶段五：自动化测试与静态分析质量门禁 (Quality Gate)   │
                        │  - 运行单元测试覆盖多语言/优先级/边界                 │
                        │  - 确保 analyze 零 Error                               │
                        └────────────────────────────────────────────────────────┘
```

---

## 三、 全管线深查与领域规范细则 (Implementation Technical Rules)

### 1. 字段绝对优先级与明细行排版规范
对于所有通知（Live Activity / 系统本地 Notification / 灵动岛 / 预览 Widget）：
* ** Header 标题层（Header Title）**：
  * 固定为 `Name`（如果有真实名称显示名称，无名称默认显示 `Unknown`）+ 电话号码。
* ** Subtitle 详情明细层（Details Line）**：
  必须严格遵循如下**绝对优先级**拼接：
  $$\text{1.【label 类别标签】} \cdot \text{2.【count 标记次数】} \cdot \text{3.【SIM卡】} \cdot \text{4.【运营商】} \cdot \text{5.【地区/国家】} \cdot \text{6.【号码类型】} \cdot \text{7.【STIR Pass】}$$
* **示例**：
  * **场景 1（信息完备且 STIR 校验通过）**：
    > `Robocall · 被标记 1 次 · SIM 1 · Verizon · 美国 · 纽约 · 固定电话或移动电话 · STIR Pass`
  * **场景 2（普通场景 / 无 STIR 数据或不支持 STIR 的网络）**：
    > `Robocall · 被标记 1 次 · SIM 1 · Verizon · 美国 · 纽约 · 固定电话或移动电话` *(末尾自动隐去 STIR 文本，不留任何痕迹)*

### 2. 多语言批量同步更新规范 (Batch i18n Strategy)
* 当变更公共词条（如 STIR 状态）时，必须**批量处理项目中全量 `.arb` 语言文件**（例如写 Dart 批处理脚本一键覆盖 47 个语言包），并立刻执行 `flutter gen-l10n`，切忌只改 `app_en.arb` 和 `app_zh.arb` 而留下一堆遗漏。
* 必须使用扩展方法（如 `.translated(context)`）解析枚举，严禁暴露裸代码字面量（如 `.name` 出来的 `fixedLineOrMobile`）。

### 3. 空安全与崩溃防御规范 (Crash Prevention & Null Safety)
* **Context 隔离安全**：后台 Isolate / CallScreeningService 运行时 `context` 可能会为 `null`。所有涉及 `AppLocalizations.of(context)` 的地方必须使用可选链解包并提供保底兜底字符串：
  ```dart
  final l10n = context != null ? AppLocalizations.of(context) : null;
  final title = l10n?.callerIdNotificationTitle ?? 'Incoming Call';
  ```
* **全 Handler Try-Catch 兜底**：所有通知/展示 Handler 的核心公开入口必须包裹顶层 `try-catch(e, stack)`，确保即使遭遇极端的 Asset 读取失败、平台通道异常或空指针，也绝不引发应用崩溃或后台进程退出。

### 4. 自动化单元测试校验规范 (Testing Gate)
修改完成后，必须提供覆盖以下维度的单元测试并确保全部通过：
1. **词条翻译断言**：断言中英文下 `stirVerified` 为 `STIR Pass` / `STIR 通过`。
2. **号码类型翻译断言**：断言 `PhoneNumberType.fixedLineOrMobile.translated(context)` 输出本地化结果而不是裸 enum 名。
3. **明细行优先级断言**：断言 `details` 列表中 `label` 位于第 1 位，`count` 位于第 2 位，`STIR Pass` 位于最末尾。
4. **条件隐藏断言**：断言无 STIR 数据或未通过时 `details` 列表中绝对不包含 `STIR Pass` 或 `STIR Not Pass`。
