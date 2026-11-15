---
name: veherego-onboarding-initial-setup-protocol
description: >-
  VehereGo 用户引导 (User Guide / Onboarding)、初始化向导 (Initial Setup Wizard) 
  与商业化开屏门禁 (PyroAppLaunchGuard) 无缝集成规范手册。
  定义了 3 步初始化向导（欢迎界面 -> 用户教程指引 -> 规则/在线订阅 100% 复用装配）、
  6 大领域小 Widget 指引卡片架构（权限保活、取件码/快递、出行车票、会员卡券/PKPass、灵动胶囊、课程表/地理围栏）、
  去品牌化与抽象脱敏红线（严禁包含星巴克/瑞幸/美团等具体商业品牌）、
  100% 国际化 (i18n) 无硬编码约束，以及常驻 Settings 作为帮助手册复用的完整 SOP。
---

# VehereGo 用户引导、初始化向导与开屏门禁集成规范 (Onboarding, Initial Setup & Launch Guard Protocol)

本规范定义了 `VehereGo` 系统中**用户引导教程 (`user_guide`)**、**初始化向导 (`initial_setup`)** 与**商业化开屏门禁 (`pyro_app_launch_guard`)** 的核心理念、架构串联、小组件拆分 SOP 与开发加固铁律。

用于指导任何 Agent 或开发者快速构建、扩展、维护与审查应用冷启动引导及帮助手册逻辑。

---

## 🛑 一、 核心架构理念与加固铁律 (Core Architectural Principles)

### 1. 商业化门禁中台对接 (Zero-Impact Commercial Launch Pipeline)
* **开屏与 Splash 零自定义控制**：严禁在 `initial_setup` 或 UI 内部手写开屏倒计时、自定义 Splash 定时器或手动路由切换逻辑。
* **管线接管机制**：开屏 Splash、开屏广告（`appOpenAd` 带 2.5s 硬超时）及引导触发全权交由商业化微包 `wallpaper/packages/commercial/pyro_app_launch_guard` 的 `PyroAppLaunchGuard` 统一调度。
* **门禁装配规范**：主 App 在 `MaterialApp.builder` 或 `main.dart` 挂载 `PyroAppLaunchGuard.builder`，将 `InitialSetupWizardPage` 直接作为 `onboardingBuilder` 供给门禁中台：
  ```dart
  PyroAppLaunchGuard.builder(
    config: LaunchConfig(
      shouldShowOnboardingCheck: () async {
        return !(await settingsRepo.getSetting('has_completed_initial_setup', false));
      },
      onOnboardingCompletedSaveCallback: () async {
        await settingsRepo.setSetting('has_completed_initial_setup', true);
      },
    ),
    onboardingBuilder: (context, onComplete) {
      return InitialSetupWizardPage(onComplete: onComplete);
    },
  );
  ```

### 2. 初始化向导 3 步平滑流转 (3-Step Initial Setup Wizard)
初始化向导必须遵循层层递进、逻辑顺畅的 3 步结构：
* **Step 1: 欢迎与理念 (Welcome)**：展现应用核心端侧离线优先、零云端追踪与纯数据驱动的隐私理念；
* **Step 2: Onboarding 交互教程 (User Guide)**：挂载 `UserGuidePage` 的 6 大解耦指引卡片，指导用户如何使用各个核心功能；
* **Step 3: 规则与在线订阅装配 (Subscription & Rules)**：100% 复用 `vehere_rules_subscription_ui`（规则订阅商店），引导用户勾选开通需要的规则源；
* **完成解挂**：点击“完成”触发 `onComplete()`，`PyroAppLaunchGuard` 会自动执行写盘落盘并推进至开屏广告与主 App 正式界面。

```
 [冷启动] ➔ PyroAppLaunchGuard ➔ initializing (Splash)
                                        │
                                        ▼ shouldShowOnboardingCheck == true
                           ┌─────────────────────────┐
                           │ InitialSetupWizardPage  │
                           ├─────────────────────────┤
                           │ Step 1: Welcome         │
                           │ Step 2: User Guide      │
                           │ Step 3: Subscription    │
                           └────────────┬────────────┘
                                        │ onComplete()
                                        ▼
                           PyroAppLaunchGuard ➔ appOpenAd ➔ completed (Main App)
```

### 3. 一举两得：Onboarding 向导 ➔ Settings 常驻手册 (Dual-Purpose Reusability)
* `user_guide` 模块放置于 `veherego/lib/features/user_guide/`，包含主页面 `UserGuidePage` 和 6 大小卡片 Widget；
* **双向复用**：既在 `initial_setup` 步骤中作为冷启动教程使用，又通过 `UserGuideCardWidget` 挂载在 `SettingsPage` 设置面板中，作为“帮助与用户手册”随时供用户二次打开查阅。避免代码一次性浪费。

### 4. 彻底去品牌化与脱敏红线 (De-branding & Anonymization Rule)
* **绝对禁止使用真实商业品牌名称**：严禁在教程文案、卡片示例或截图占位中包含具体的品牌名称（如禁止出现“星巴克”、“瑞幸”、“美团”、“顺丰”等）；
* **强制使用泛化抽象占位符**：必须统一采用抽象名称（如“XX咖啡”、“XX外卖”、“XX快递”、“XX智能柜”）；
* **票务与单号脱敏**：车票/机票车次号、快递运单号等可使用通用示例号（如 `G1234`、`3-2-8012`、`#A882`）。

### 5. 100% 国际化 (i18n) 零硬编码
* **禁止中英文硬编码**：所有教程标题、说明段落、快捷例句与卡片标签，必须 100% 写入 `.arb` 资产并通过 `AppLocalizations.of(context)` 动态获取；
* 每当增加新的指引卡片或步骤，必须同步补充 `app_zh.arb` 与 `app_en.arb` 并更新生成的 `AppLocalizations`。

### 6. 小 Widget 模块化解耦 (Single File < 300 Lines)
* **严禁巨石代码**：每个指引卡片 Widget 必须独立为单文件（位于 `lib/features/user_guide/presentation/widgets/`），单个文件控制在 300 行以内；
* **零交叉依赖**：小 Widget 卡片之间无横向依赖，方便后续版本随时灵活增删与扩充。

---

## 📦 二、 6 大指引卡片模块设计规范 (Modular Guide Cards Spec)

`veherego/lib/features/user_guide/presentation/widgets/` 下包含 6 大核心领域的极简解耦卡片：

| 卡片文件名 | 负责指引领域 | 包含的核心指引内容 |
| :--- | :--- | :--- |
| **`permission_guide_card.dart`** | 系统权限与后台保活 | 通知读取权限授权、厂商自启动保活策略、忽略电池优化（无限制模式）与多任务卡片加锁提示。 |
| **`pickup_guide_card.dart`** | 快递/外卖/取件码 | 自动捕获短信与通知中的取件码、快递柜 PIN 与外卖餐号（示例采用“XX快递”、“XX咖啡”）。 |
| **`ticket_guide_card.dart`** | 出行车票/机票/高铁 | 自动解析火车票、机票登机牌与客运行程，配合地理围栏到店/到站自动提醒。 |
| **`identity_pass_guide_card.dart`**| 会员卡/卡券/PKPass | 汇总收纳会员卡、优惠券与 Apple Wallet (.pkpass) 凭证包，支持收银台一键展示扫码。 |
| **`live_capsule_guide_card.dart`** | 灵动岛与实时胶囊 | 状态栏与灵动岛实时追踪外卖进度、打车 ETA 与通话胶囊动态。 |
| **`schedule_geofence_guide_card.dart`**| 智能课表与地理围栏 | 智能课程表下课顺路取件提醒，以及靠近驿站/门店 150 米自动唤醒自提码。 |

---

## 🛠️ 三、 商业化 PyroAppLaunchGuard 对接 SOP

当主 App 接入冷启动门禁向导时，按以下 SOP 步骤操作：

### 步骤 1：引入微包
在 `veherego/pubspec.yaml` 或 `pubspec_overrides.yaml` 中配置商业化门禁依赖：
```yaml
dependencies:
  pyro_app_launch_guard:
    path: ../wallpaper/packages/commercial/pyro_app_launch_guard
```

### 步骤 2：在 App Shell 中挂载门禁 Builder
在 `veherego/lib/features/app_shell/presentation/pages/main_tab_scaffold.dart` 或 `main.dart` 的 `MaterialApp.builder` 中注入：

```dart
import 'package:pyro_app_launch_guard/pyro_app_launch_guard.dart';
import 'package:veherego/features/initial_setup/presentation/pages/initial_setup_wizard_page.dart';

MaterialApp(
  // ...
  builder: PyroAppLaunchGuard.builder(
    config: LaunchConfig(
      initTimeout: const Duration(milliseconds: 2500),
      adTimeout: const Duration(milliseconds: 2500),
      shouldShowOnboardingCheck: () async {
        final settingsRepo = ref.read(settingsRepoProvider);
        return !(await settingsRepo.getSetting('has_completed_initial_setup', false));
      },
      onOnboardingCompletedSaveCallback: () async {
        final settingsRepo = ref.read(settingsRepoProvider);
        await settingsRepo.setSetting('has_completed_initial_setup', true);
      },
    ),
    onboardingBuilder: (context, onComplete) {
      return InitialSetupWizardPage(onComplete: onComplete);
    },
  ),
);
```

### 步骤 3：在 InitialSetupWizardPage 中完成闭环
向导最后一步点击“完成”时，显式调用 `widget.onComplete?.call()`：
```dart
void _finishSetup() {
  // 触发 PyroAppLaunchGuard 自动写盘落盘，并推进管线至开屏广告与主 App 解挂
  widget.onComplete?.call();
}
```

---

## ⚙️ 四、 Settings 常驻帮助手册入口 SOP

为保证用户在主 App 中随时可再次查看教程，必须在 `SettingsPage` 中暴露常驻入口：

```dart
// 在 veherego/lib/features/settings/presentation/widgets/user_guide_card_widget.dart 中实现：
class UserGuideCardWidget extends StatelessWidget {
  const UserGuideCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Card(
      child: ListTile(
        leading: const Icon(Icons.menu_book_rounded),
        title: Text(l10n.guideHubTitle), // "用户指南与使用手册"
        subtitle: const Text('查看完整的权限保活、取件码与行程卡片交互指引'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const UserGuidePage()),
          );
        },
      ),
    );
  }
}
```

---

## 🔍 五、 开发者与 Agent 自检自查清单 (Audit Checklist)

在提交或修改 `user_guide` 与 `initial_setup` 相关代码时，必须执行以下审查：

- [ ] **零硬编码**：全量文案走 `.arb` 国际化资产，无硬编码中英文；
- [ ] **零具体品牌**：全文无“星巴克/瑞幸/美团/顺丰”等具体品牌，100% 使用“XX咖啡/XX外卖/XX快递”；
- [ ] **小文件规范**：指引卡片拆分为独立 Widget 文件，单个文件行数 < 300 行；
- [ ] **100% 规则复用**：向导 Step 3 直接复用 `packages/subscription/vehere_rules_subscription_ui`，无重复代码；
- [ ] **门禁配合**：未手写 Splash 定时器或路由重定向，100% 交由 `PyroAppLaunchGuard` 管线调度；
- [ ] **常驻 Settings**：`SettingsPage` 包含 `UserGuideCardWidget` 入口；
- [ ] **代码质量**：运行 `analyze_file` 确认 0 Error / 0 Warning。
