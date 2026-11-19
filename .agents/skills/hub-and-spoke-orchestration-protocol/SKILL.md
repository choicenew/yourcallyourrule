---
name: hub-and-spoke-orchestration-protocol
description: 星型中枢单向编排架构规范：微包（Packages）100% 货架化即插即用可移植、业务层（Features）零横向依赖、中枢（Connector/Coordinator）单向胶水路由分发治理标准。
---

# 星型中枢单向编排架构规范 (Hub-and-Spoke Orchestration Protocol)

在现代复杂跨平台工程中，随着业务规模的膨胀与底层硬件/系统能力的深入，传统的“单体巨石应用（Monolith）”会迅速陷入模块互相纠缠、循环依赖、改一处崩全局、无法独立测试的**“泥潭架构”**。更致命的是，花费大量心血研发的底层能力（如电信拦截、短信识别、SIM 卡管理、磁贴通信、规则订阅），由于被业务逻辑严重污染，**无法被抽离复用到下一个新产品中**。

本规范确立了**“星型中枢单向编排架构（Hub-and-Spoke Unidirectional Orchestration Architecture）”**，旨在实现底层能力的**“100% 货架化、即插即用与跨工程零摩擦复用”**，并规范主 App 协调层作为统一数据路由中心的标准实现。

---

## 一、 核心哲学：软件资产货架化 (Plug-and-Play Assetization)

### 1. 为什么必须将底层功能封装为自闭环独立微包？
- **现实痛点**：今天在 App A 中写好了电话拦截、SIM 卡识别；明天公司要启动一个轻量级的“短信清理助手”或“智能拨号盘”App B。如果代码写在 `lib/` 内部，到处杂糅着 App A 的用户登录、数据库表结构和特定 UI，你**根本无法将这段代码扣出来**，只能被迫重写或复制后忍受双份代码维护的痛苦。
- **货架化哲学（Off-The-Shelf Component）**：
  - 每一个 `packages/<domain>` 是一个纯粹的、自闭环的**“工业级零件/独立微引擎”**；
  - 它自带独立的依赖清单（`pubspec.yaml`）、跨平台强类型契约（Pigeon）、原生混淆规则（`consumer-rules.pro`）与脱机单测（Dart + JVM Test）；
  - **在未来的任何新 App 中，只需将该 Package 拷过去或通过 Git 引入，不需要修改内部任何一行代码，即可 100% 即插即用！**

---

## 二、 架构三层拓扑模型 (Three-Tier Topology)

系统在物理与逻辑上严格划分为三层，数据流动必须遵循**单向星型拓扑**：

```
┌─────────────────────────────────────────────────────────────┐
│                      第三层：主 App 协调层                   │
│         AppCoordinator & AppHubExchangeConnector            │
│                 (航空管制塔台 / 唯一胶水与总机)               │
└───────────────▲─────────────────────────────┬───────────────┘
                │ ① 上报事件/数据             │ ② 分发/编排动作
                │ (通过 Adapter 端口)         │ (通过 Provider 状态)
    ┌───────────┴──────────┐       ┌──────────▼───────────┐
    │  第一层：底层自闭环微包│       │ 第二层：业务场景特性呈现│
    │  - pyro_sim_driver   │       │  - lib/features/sim  │
    │  - pyro_sms_driver   │       │  - lib/features/sms  │
    │  - pyro_telephony    │       │  - Database / Cloud  │
    └──────────────────────┘       └──────────────────────┘
     (纯粹引擎，不知外部世界)        (业务消费，彼此零横向引用)
```

### 1. 第一层：底层自闭环微包 (Autonomous Packages)
- **角色**：能力的纯粹执行者与数据产出源（如读取 SIM 卡槽状态、监听原生系统通知、执行正则匹配算法）。
- **对外暴露**：领域实体（`Entity`）、适配器抽象（`Adapter`）、模块中枢（`Hub`）。
- **绝对盲区**：**它不知道外部谁在使用它，不知道主 App 的存在，不知道数据库存到哪，不知道 UI 怎么画**。

### 2. 第二层：业务场景呈现 (Application Features)
- **角色**：位于主 App `lib/features/<domain>/`，负责特定的用户交互、页面路由与 ViewModel 状态管理。
- **边界红线**：**Feature 之间 100% 严禁横向相互 import**（如 `sms` 绝对禁止 import `contacts` 或 `settings`）。所有跨 Feature 的数据索取，必须向第三层中枢索取。

### 3. 第三层：中枢装配与路由调度 (Coordinator & ExchangeConnector)
- **角色**：整个应用的大脑与航空管制塔台（Control Tower）。
- **职责**：
  1. **装配微包**：在应用启动阶段，通过依赖注入把具体的 Driver 装配（mount/register）进各个微包的 Hub 中；
  2. **事件路由**：监听微包产生的底层硬件/通信事件，并根据应用整体业务规则，分发调度给数据库持久化、云端同步以及对应 Feature 的 Provider。

---

## 三、 守护“100% 可复用性”的五大防污染红线

任何一条微包若想保持**“随时能搬到其他 App 并且 100% 正常工作”**，必须绝对死守以下 5 条红线：

| 红线编号 | 致命反模式 (Anti-Pattern) | 严重后果 | 标准规范做法 (Best Practice) |
| :--- | :--- | :--- | :--- |
| **红线 1** | **微包内反向 import 宿主 App**<br>（如 `import 'package:main_app/...'`） | 微包与宿主死锁，换个 App 连编译都过不去。 | 微包只能引用自身的子包或公共三方基础库，对外部世界的诉求全部定义为抽象 `Adapter` 接口。 |
| **红线 2** | **微包内依赖具体用户/业务状态**<br>（如直接读取 `currentUserId` 或 App 特定 Token） | 业务状态变更时微包崩溃，无法在无登录态下复用。 | 将业务参数全部作为方法的明确入参传入，微包本身保持无状态（Stateless）。 |
| **红线 3** | **微包内弹 UI / 绑定特定弹窗**<br>（如直接调用 `showDialog` 或特定主题 Toast） | 破坏新 App 的设计规范，甚至在后台 Service 运行时引发无上下文崩溃。 | 微包只输出结构化数据与事件流，由上层 Connector 接收后交给业务层决定如何渲染。 |
| **红线 4** | **滥用全局静态单例 (`Class.instance`)** | 无法支持多实例共存，脱机单元测试严重互相污染。 | 构造函数支持实例注入，微包生命周期由外部 DI 容器（如 Riverpod Provider）统一托管。 |
| **红线 5** | **忽略平台混淆与原生构建自闭环** | 打 Release 包时原生反射崩溃，需要主 App 人工补配混淆规则。 | 原生端必须配置独立 `consumer-rules.pro`，构建体系完全自闭环。 |

---

## 四、 跨包数据中转与分发的完整运行链路

以**“系统状态栏拦截到一条验证码短信”**为例，展示中枢路由是如何做到零横向依赖分发的：

```
[Android 系统原生通知]
       │ (1. 捕获系统事件)
       ▼
[pyro_sms_driver_notification_listener]
       │ (2. Pigeon 强类型回传，构建 SmsMessageEntity)
       ▼
[pyro_sms_hub] (管道筛选)
       │ (3. 回调给监听端，无任何数据库/UI代码)
       ▼
[AppHubExchangeConnector] <── 航空管制塔 (主 App 中枢)
   ├── 任务 A: 调用 [pyro_phone_rules] 检查是否匹配安全白名单
   ├── 任务 B: 匹配失败，调用 [central_database] 将拦截记录落库
   ├── 任务 C: 通知 [smsFilterServiceProvider] 刷新未读拦截角标
   └── 任务 D: 调用 [pyro_overlay] 弹出轻量悬浮提示
```

**解耦效果验证**：
- `pyro_sms` 根本不知道数据库长什么样；
- `central_database` 根本不知道短信拦截驱动的存在；
- `pyro_overlay` 纯粹只负责画窗口；
- **如果明天要把悬浮窗换成震动通知，或者把数据库换成云端存储，只需修改 Connector 中的一行路由代码，底层 4 个 Package 完全不用做任何变动！**

---

## 五、 如何将微包移植到全新 App 的极速 SOP

当需要在未来的新项目（App B）中复用此模块时，标准流程仅需 4 步：

1. **直接拷贝/引用模块**：
   将 `packages/<domain>/` 整体移动至新工程，或在 `pubspec.yaml` 中通过 Git Submodule / 路径引用：
   ```yaml
   dependencies:
     pyro_sim_driver:
       path: ../packages/sim/pyro_sim_driver
     pyro_sim_hub:
       path: ../packages/sim/pyro_sim_hub
   ```
2. **在新工程的装配层注入**：
   在 App B 的 Riverpod 或 DI 容器中创建 Hub 实例：
   ```dart
   final appBSimHubProvider = Provider<SimHub>((ref) {
     final hub = SimHub();
     hub.registerAdapter(SimDriver());
     return hub;
   });
   ```
3. **在新工程的业务页面直接消费数据**：
   ```dart
   final simCards = await ref.watch(appBSimHubProvider).getActiveSimCards();
   ```
4. **验证完成**：从引入到跑通只需 5 分钟，原有的单元测试和 Pigeon 通信通道 100% 即插即用！
