import 'package:material_ui/material_ui.dart';
import 'package:yourcallyourrule/features/call_filter/presentation/widgets/call_filter_settings_widget.dart';
import 'package:yourcallyourrule/features/local_filter/presentation/widgets/local_filter_settings_widget.dart';
import 'package:yourcallyourrule/features/remote_filter/presentation/widgets/remote_filter_settings_widget.dart';
import 'package:yourcallyourrule/features/call_time_interception/presentation/widgets/time_interceptor_settings_widget.dart';
import 'package:yourcallyourrule/features/sim_slot_rules/widgets/sim_slot_rule_widget.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 动态 UI 描述符：包含多语言标题构建器、内容 Widget 构建器与图标
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

/// 主 App 胶水层 UI 动态注册映射工厂 (位于 lib/core/coordinator/)
class FilterUiRegistry {
  static final Map<String, FilterUiSpec> _specs = {};

  static void register(String filterId, FilterUiSpec spec) {
    _specs[filterId] = spec;
  }

  static FilterUiSpec? get(String filterId) => _specs[filterId];

  /// 主 App 启动装配集中注册
  static void init() {
    register('basicRule', FilterUiSpec(
      titleBuilder: (ctx) => AppLocalizations.of(ctx).basicRuleFilter,
      contentBuilder: (ctx) => const CallFilterSettingsWidget(),
      icon: Icons.rule_rounded,
    ));
    register('timeWindow', FilterUiSpec(
      titleBuilder: (ctx) => AppLocalizations.of(ctx).timeInterceptorSettingsTitle,
      contentBuilder: (ctx) => const TimeInterceptorSettingsWidget(),
      icon: Icons.access_time_rounded,
    ));
    register('localCountThreshold', FilterUiSpec(
      titleBuilder: (ctx) => AppLocalizations.of(ctx).localCountFilter,
      contentBuilder: (ctx) => const LocalFilterSettingsWidget(),
      icon: Icons.filter_alt_rounded,
    ));
    register('remoteRisk', FilterUiSpec(
      titleBuilder: (ctx) => AppLocalizations.of(ctx).remoteFilterSettings,
      contentBuilder: (ctx) => const RemoteFilterSettingsWidget(),
      icon: Icons.cloud_done_rounded,
    ));
    register('simSlot', FilterUiSpec(
      titleBuilder: (ctx) => AppLocalizations.of(ctx).simSlotRuleManagement,
      contentBuilder: (ctx) => const SimSlotRuleWidget(simSlotIndex: 0, onTap: _nop),
      icon: Icons.sim_card_rounded,
    ));
  }

  static void _nop() {}
}
