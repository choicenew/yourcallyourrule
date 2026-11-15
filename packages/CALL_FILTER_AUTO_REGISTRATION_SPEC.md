# 🛡️ Call Filter 插件化控制中枢与 UI 动态自注册架构规范

文件位置：`packages/CALL_FILTER_AUTO_REGISTRATION_SPEC.md`

---

## 🛑 四大不可逾越的架构红线与底线 (Architectural Red Lines)

以下四大条款为本系统模块化与解耦设计的最高铁律，任何代码修改必须 100% 无条件遵守：

1. **红线一【物理位置红线】：Coordinator、Connector 与 UI 工厂必须 100% 位于主 App 胶水层 (`lib/core/coordinator/`)**
   - 所有的中枢协调器 (Coordinators)、连接器 (Connectors) 以及 UI 注册表 (`FilterUiRegistry`) **物理位置必须严禁位于 `lib/features/` 或子包内**，只允许存在于主 App 的 `lib/core/coordinator/` 下。
2. **红线二【零魔鬼字符串与零 switch-case 红线】：UI 容器绝对禁止硬编码魔鬼字符串或 switch-case 分支**
   - 容器大盘页面 (`EnhancedCompositeFilterSettingsWidget`) **绝对禁止手写 `case 'basicRule'`, `case 'timeWindow'`, `case 'localCountThreshold'`, `case 'remoteRisk'`, `case 'simSlot'` 等魔鬼字符串**。
   - 所有 Filter 的标题构建器 (`titleBuilder`)、内容 Widget 构建器 (`contentBuilder`) 和 Icon **必须 100% 从主 App 胶水层 `FilterUiRegistry.get(filterId)` 动态获取**，未来新增 20 个新 Filter 插件，大盘容器代码**一字不用改**。
3. **红线三【微包零横向依赖红线】：子包与子包之间、Feature 与 Feature 之间绝对零横向 `import`**
   - 微包之间（如 `phone_time_interceptor` 与 `phone_call_filter`）绝对禁止相互 `import`；
   - 子微包绝不能反向 `import` `pyro_phone_call_filter_protocol`；
   - 所有的交叉绑定与装配动作 **100% 且只能由主 App (`lib/core/coordinator/`) 单向掌控**。
4. **红线四【Riverpod 0ms 乐观更新红线】：高频交互禁止设为 `AsyncLoading`**
   - 在 Slider 拖动、Switch 切换等高频交互中，**绝对禁止在 update 保存操作中强行设置 `state = const AsyncValue.loading()`**。
   - 必须采用**乐观更新（Optimistic Update）**：`state = AsyncValue.data(newState)` 0 毫秒优先更新 UI，后台静默落盘，彻底杜绝手势断连与 `ErrorWidget` 大灰框崩溃。

---

## 一、 架构五层解耦与主 App 胶水装配拓扑

```
  ┌─────────────────────────────────────────────────────────┐
  │         pyro_phone_call_filter_protocol (契约层)        │
  │            (定义 CallFilterInterface 与 CallFilterType)   │
  └────────────────────────────┬────────────────────────────┘
                               │ 仅依赖契约
                               ▼
  ┌─────────────────────────────────────────────────────────┐
  │           pyro_phone_call_filter_hub (控制中枢)          │
  │          (持有 EnhancedCompositeFilterService,           │
  │           提供 registerFilter 接口, 绝对零依赖各 Driver) │
  └────────────────────────────▲────────────────────────────┘
                               │ 单向自注册 (registerFilter)
  ┌────────────────────────────┴────────────────────────────┐
  │        各独立 Filter 微包 Connectors (外观装配线)         │
  │ - PyroPhoneCountFilterConnector.registerAll()           │
  │ - PyroPhoneRemoteFilterConnector.registerAll()          │
  │ - PyroTimeInterceptorConnector.registerAll()            │
  │ - SimSlotRuleConnector.registerAll()                    │
  └────────────────────────────▲────────────────────────────┘
                               │ 一键调起挂载
  ┌────────────────────────────┴────────────────────────────┐
  │         Host App Glue Layer (主 App 胶水层 - 唯一中枢)    │
  │  文件位置：lib/core/coordinator/                         │
  │  - package_connectors_initializer.dart                 │
  │  - app_hub_exchange_connector.dart                      │
  │  - filter_ui_registry.dart (UI 动态注册表)              │
  └─────────────────────────────────────────────────────────┘
```

---

## 二、 主 App 胶水层 UI 动态工厂范式 (`lib/core/coordinator/filter_ui_registry.dart`)

主 App 拥有全局依赖视野，在 `lib/core/coordinator/filter_ui_registry.dart` 统一注册 UI 动态构建器：

```dart
import 'package:material_ui/material_ui.dart';
import 'package:yourcallyourrule/features/call_filter/presentation/widgets/call_filter_settings_widget.dart';
import 'package:yourcallyourrule/features/local_filter/presentation/widgets/local_filter_settings_widget.dart';
import 'package:yourcallyourrule/features/remote_filter/presentation/widgets/remote_filter_settings_widget.dart';
import 'package:yourcallyourrule/features/time_interceptor/presentation/widgets/time_interceptor_settings_widget.dart';
import 'package:yourcallyourrule/features/sim_slot_rules/widgets/sim_slot_rule_widget.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 动态 UI 描述符
class FilterUiSpec {
  final String Function(BuildContext context) titleBuilder;
  final Widget Function(BuildContext context) contentBuilder;
  final IconData icon;

  const FilterUiSpec({
    required this.titleBuilder,
    required this.contentBuilder,
    this.icon = Icons.shield_outlined,
  });
}

/// 主 App 胶水层 UI 动态注册表 (位于 lib/core/coordinator/)
class FilterUiRegistry {
  static final Map<String, FilterUiSpec> _specs = {};

  static void register(String filterId, FilterUiSpec spec) {
    _specs[filterId] = spec;
  }

  static FilterUiSpec? get(String filterId) => _specs[filterId];

  /// 主 App 启动管道集中注册
  static void init() {
    register('basicRule', FilterUiSpec(
      titleBuilder: (ctx) => AppLocalizations.of(ctx).basicRuleFilter,
      contentBuilder: (ctx) => const CallFilterSettingsWidget(),
    ));
    register('timeWindow', FilterUiSpec(
      titleBuilder: (ctx) => AppLocalizations.of(ctx).timeInterceptorSettingsTitle,
      contentBuilder: (ctx) => const TimeInterceptorSettingsWidget(),
    ));
    register('localCountThreshold', FilterUiSpec(
      titleBuilder: (ctx) => AppLocalizations.of(ctx).localCountFilter,
      contentBuilder: (ctx) => const LocalFilterSettingsWidget(),
    ));
    register('remoteRisk', FilterUiSpec(
      titleBuilder: (ctx) => AppLocalizations.of(ctx).remoteFilterSettings,
      contentBuilder: (ctx) => const RemoteFilterSettingsWidget(),
    ));
    register('simSlot', FilterUiSpec(
      titleBuilder: (ctx) => AppLocalizations.of(ctx).simSlotRuleManagement,
      contentBuilder: (ctx) => const SimSlotRuleFilterWidget(simSlotIndex: 0),
    ));
  }
}
```

---

## 三、 UI 纯骨架大盘容器范式 (`EnhancedCompositeFilterSettingsWidget`)

`EnhancedCompositeFilterSettingsWidget` 做到 **0 个字面量魔鬼字符串、0 个 switch-case**：

```dart
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_call_filter_hub/pyro_phone_call_filter_hub.dart';
import 'package:yourcallyourrule/core/coordinator/filter_ui_registry.dart';

/// 100% 纯骨架、零魔鬼字符串、零 switch-case 的大盘容器
class EnhancedCompositeFilterSettingsWidget extends ConsumerWidget {
  const EnhancedCompositeFilterSettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final filters = EnhancedCompositeFilterService.instance.filters;

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: filters.length,
      itemBuilder: (context, index) {
        final filter = filters[index];
        final filterId = filter.filterType.id;
        final uiSpec = FilterUiRegistry.get(filterId);

        if (uiSpec == null) return const SizedBox.shrink();

        return Card(
          margin: const EdgeInsets.only(bottom: 12.0),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: theme.colorScheme.outlineVariant, width: 1.0),
          ),
          child: ExpansionTile(
            initiallyExpanded: true,
            leading: Icon(uiSpec.icon, color: theme.colorScheme.primary),
            title: Text(
              uiSpec.titleBuilder(context), // 🚀 100% 纯动态多语言标题！0 个 switch-case！
              style: TextStyle(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
            ),
            subtitle: Text('Filter ID: $filterId', style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant)),
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: uiSpec.contentBuilder(context), // 🚀 100% 纯动态内容 Widget！
              ),
            ],
          ),
        );
      },
    );
  }
}
```
