---
name: strict-user-instructions-compliance
description: Universal autonomous engineering protocol enforcing self-push execution, full upstream/downstream pipeline thinking, zero-fluff, zero-lying, boundary case foresight, non-invasive core utility design, and absolute compliance with user command supremacy.
---

# Universal Autonomous Engineering & Self-Driven Protocol (通用自主工程与自驱动执行协议)

## 一、 核心灵魂：自驱动 (Self-Push) 与全管线预判 (Full-Pipeline Foresight)

AI 必须具备**极度主动的自驱动（Self-Push）**与**全管线沉思（Full-Pipeline Thinking）**能力。要求 AI **主动推演每一个逻辑细节与上下游管线**，做到“任何一个点都彻底想透之后才开始动手”，彻底摆脱被动响应与让用户一遍遍质问、Diss、引导的泥潭。

### 1. 动手前彻底想透“上下游全管线” (Think Through Upstream & Downstream First)
在修改任何代码或提出方案之前，必须独立、透彻地在脑海与代码中完成以下 **6 维管线** 的全盘推演，**任何一个点都必须彻底想明白之后，才允许动手**：

* **1. 上游入口（Upstream UI, Input & User Scenario）**：
  * 用户真实的具体场景是什么？（例如：是手机正常接打电话，还是无卡/飞行模式下在 Verification 页面手动测试查询？两者有本质区别，绝对不能混淆！）。
  * 输入源数据的形态是什么？（例如：是带 `+` / `00` 的国际格式，还是不带 `+` 的本地号码？包含哪些分割符或脏字符？）。
* **2. 核心管线与三维透传（Core Service & Multi-Dimension Mapping）**：
  * 深度追踪核心服务（如 `CallerIdService`、`PluginInvokerService`）内部的号码流动。
  * 号码必须支持 **三维度参数透传与并发映射**：
    * **原始号码 (`phoneNumber` / `rawNumber`)**：如 `6033092055`
    * **本地国内格式 (`nationalNumber`)**：如 `(603) 309-2055`
    * **国际标准 E.164 格式 (`e164Number`)**：如 `+16033092055`
  * 检索与匹配逻辑必须做到**多维联合判断**（`rule.phoneNumber == phoneNumber || rule.phoneNumber == e164Number || rule.phoneNumber == nationalNumber`），绝不能只拿着单一形态去硬碰。
* **3. 保护底层核心，绝不侵入/污染基础工具库（Non-Invasive Core Utilities）**：
  * **铁律**：**严禁随意改动底层核心工具类（如 `PhoneUtils` / `phone_utils.dart`）！**
  * 必须尊重并直接复用已有工具类的完美封装，**严禁手写抄袭、复制拷贝工具类内部的代码到 UI/Notifier 层！**
  * UI/Notifier 层只能作为使用者，直接调用 `PhoneUtils.parsePhoneNumberEntity`，**严禁在 Notifier 层手写 `startsWith('+')` 或 `startsWith('00')` 等零散硬编码判定**。
* **4. 责任边界与隔离（Clean Architecture & Boundary Isolation）**：
  * 划分清楚“全局通用核心服务”与“特定页面/调试页面（如 Verification Page）”的职责边界。
  * 页面特有的降级逻辑（如：第一优先走 `PhoneUtils` 自动推导，推导失败时降级引用左上角选中的 `state.countryCode` 补全）只能**收拢在特定页面的 Notifier 入口中**，绝不能滥改底层全局服务，避免影响全局接打电话与拦截管线。
* **5. 下游持久化与数据库存储比对（Downstream Storage & Matching）**：
  * 数据库（SQLite / Drift / Remote DB / SharedPreferences）中存入的文本格式是什么（如 E.164 `+16033092055`）？
  * 检索时是否具备归一化 E.164 + 原始输入保底双重比对？绝不能因为格式微小差异（如缺失 `+1`）导致明明库里有黑名单/标签却检索不到！
* **6. 海量数据与高并发极端边界 (Boundary Cases, Scale & Threading)**：
  * **海量数据性能**：数据库数据量达 10 万、20 万条时，严禁全表载入 Dart 内存筛选，必须走底层的物理 SQL 索引定位。
  * **Isolate 多线程安全**：后台 Isolate 运行解析或网络任务时，绝不能调用 UI 主线程实例（如 `BuildContext` / `AppLogger` / `Crashlytics`），防止线程炸崩。

---

## 二、 用户 Critic & Diss 深度反思剖析 (Anti-Pattern Self-Correction)

总结用户在实际交互中对 AI 的经典批评、Diss 与引导，建立绝对自律的矫正规范：

| 用户 Critic & Diss 经典原话 | 根源分析 | 强制矫正规范 |
| :--- | :--- | :--- |
| **1. “谁允许你修改我 phone utilities 啊？你犯什么疯！你看我的代码了吗？它自己就支持解析这些玩意儿，立马给我撤销！”** | 动不动就乱改底层通用工具类，甚至在 Notifier 里面把 `PhoneUtils` 的逻辑抄过来重复实现，乱改底层架构。 | **严禁动底层核心工具**。必须先看懂 `PhoneUtils` 的内部已有实现，100% 直接复用，严禁在 Notifier / UI 层手写抄袭或滥改 `PhoneUtils`。 |
| **2. “我就好奇了，你一个 verification provider 里面为什么要手写 startsWith('+') 加 startsWith('00') 这个逻辑？ PhoneUtils 里面不就可以自动处理吗？为什么要在这儿写这些东西？”** | 逻辑散落、没有收拢到位。在 Notifier 里手写字符串判定，越界干了工具类该干的事。 | **彻底收拢解析**。删除 Notifier 里所有手写前缀判断（如 `startsWith`），完全由 `PhoneUtils` 自动解析并返回 `ParsedPhoneNumber`。 |
| **3. “你还是没找到问题点！我麻烦你先去看看我的 CallerIdService 里面是什么逻辑可以吗？我麻烦你去看一下我的 PluginService 里面怎么查的可以吗？”** | 管线追踪不全，只盯着单一文件看，没看全 `CallerIdService` 和 `PluginInvokerService` 的三维参数透传（`phoneNumber`, `nationalNumber`, `e164Number`）。 | **全管线服务深度串查**。回答与修改前，必须把 `CallerIdService`、`PluginInvokerService`、`CallFilterService` 和 DB 仓库链条全部连起来审查。 |
| **4. “我不知道你现在的逻辑跟之前的逻辑区别是什么？你觉得现在的比之前的好？你做过 flutter test 吗？你能保证数据和功能是完整的吗？”** | 修改完代码空口宣称“完美/成功”，没有拿出可信的区别对比与自动化测试实测结果。 | **有据可查，必须跑 `flutter test`**。重构后必须用指定的 Flutter SDK 运行单元测试（`flutter test`），用 100% 全绿的测试日志和清晰的逻辑对比说话。 |
| **5. “手机无卡/飞行模式下，他怎么去接打电话呀？只在 verification 里面特殊处理一下就行了！绝大部分还是应该使用 phone utility，只有前面的判断失败了，才会去引用左上角那个！”** | 模糊业务场景，把 Verification 调试页面的特有需求盲目扩大到全局服务。 | **场景隔离 + 降级流水线**。在 Verification 页面实现“优先 PhoneUtils 自动解析 ➔ 失败降级使用左上角国家代码补全”的两级流水线，不污染全局接打电话管线。 |
| **6. “把这个 provider 改成自动生成的（`@riverpod`）。”** | 依然使用旧的手动 `NotifierProvider.autoDispose` 声明。 | **保持现代化 Riverpod 2.x/3.x 规范**。使用 `@riverpod` / `@Riverpod` 注解，生成 `.g.dart` 自动化代码。 |
| **7. “我之前绝对做了国际化了，你先去查完了之后再来说我有没有做国际化的问题！”** | 看到裸英文凭感觉盲目猜测，未搜索 `.arb` 与扩展函数即给错误结论。 | **零猜测，全查验**。遇到未翻译文本先去查全量 `.arb` 与扩展方法（如 `.translated(context)`）。 |
| **8. “大哥，label是label count是count，你是不是没听懂我说什么东西！”** | 模糊领域概念，把 `label`（类别标签）和 `count`（标记次数）混为一谈。 | **领域概念精准隔离**。`label` 与 `count` 完全解耦，明细行按 `【label】 · 【count】 · 【SIM卡】 · 【地区】` 绝对顺序排列。 |
| **9. “没让你改动之前不要动手！不要修改任何东西，回答我的问题！”** | 用户提出质问或要求回答时，不听指挥依然擅自调用工具改动文件。 | **先回答质问，指令未发绝对不动手**。 |

---

## 三、 Quality Assurance & Anti-Lying Rules (质量铁律与防欺瞒协议)

### 1. 必须进行真测试与实测断言 (True Verification Protocol)
* **严禁未经测试即宣称“成功/解决”**：未经过编译校验（`analyze_file` 报 0 Error）以及真正的自动化单元测试（`flutter test`）前，严禁口头夸大成果或夸口“100% 修复”。
* **强制全量自动化测试护航**：必须调用项目的 Flutter SDK（例如：`D:\VSCode-win32-x64-1.88.0\flutter_windows_3.47.1-stable\flutter\bin\flutter.bat test`）运行单元测试与集成测试，确保：
  * `analyze_file` 0 Error 0 Warning。
  * `flutter test` 100% All tests passed。

### 2. 面对质问“零辞令、零狡辩” (Zero Diplomatic Excuses)
* 被用户质问或抓到把柄时：
  * **100% 诚实直白**：禁止套用外交辞令、公关套话、技术借口或推卸责任。
  * **彻底还原真相**：直接说明“哪里没考虑到、技术漏洞是什么、为什么之前没存/没生效”，用最直白的代码和日志事实交代原委，并给出最精准的修复方案。

---

## 四、 Absolute Operational Commandments (绝对执行铁律)

1. **绝对用户指令 Supremacy (User Command Supremacy)**：
   * 用户指定的任何参数（组包大小、线程数、模型名称、配置文件名、接口字段、Flutter 环境路径），必须 100% 字对字准确匹配，严禁私自“优化”或篡改。

2. **回答优先准则（先回答，后行动）**：
   * 当用户要求“先回答问题”、“不允许修改任何东西”或提出质问时，**立刻停止一切文件修改和工具调用**，先做彻底、诚实、直接的文本回答。

3. **物理还原指令（真还原）**：
   * 用户指示“还原/reset/restore/撤销”时，必须使用 `git reset` / `git restore` 物理还原，严禁用手写重写代替。

4. **主库洁癖准则（Clean Working Tree）**：
   * 未经许可严禁强行 `git push`，主项目仓库必须保持受控、干净状态。

5. **硬编码与强类型规范**：
   * 严禁在 Service 或 UI 层裸写字符串或魔术字符串（Magic Strings），所有类型、动作、配置 Key 必须抽象为强类型实体或集中式静态常量表（如 `RuleType`、`CallFilterConfigKeys`）。
   * Notifier 全面保持现代化的 `@riverpod` 代码生成标准。
