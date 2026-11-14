import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_call_filter_hub/pyro_phone_call_filter_hub.dart';
import 'package:pyro_phone_call_filter_protocol/pyro_phone_call_filter_protocol.dart';
import 'package:yourcallyourrule/features/call_filter/presentation/widgets/call_filter_settings_widget.dart';
import 'package:yourcallyourrule/features/call_filter/presentation/widgets/sim_slot_rule_filter_widget.dart';
import 'package:yourcallyourrule/features/local_filter/presentation/widgets/local_filter_settings_widget.dart';
import 'package:yourcallyourrule/features/remote_filter/presentation/widgets/remote_filter_settings_widget.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 动态组合过滤器配置组件 (EnhancedCompositeFilterSettingsWidget)
/// 遵照 DATA_DRIVEN_ENTITY_SPEC.md 规范：采用强类型 CallFilterType 值对象判等，100% 嵌入包内真实属性调节组件
class EnhancedCompositeFilterSettingsWidget extends ConsumerStatefulWidget {
  const EnhancedCompositeFilterSettingsWidget({super.key});

  @override
  EnhancedCompositeFilterSettingsWidgetState createState() => EnhancedCompositeFilterSettingsWidgetState();
}

class EnhancedCompositeFilterSettingsWidgetState extends ConsumerState<EnhancedCompositeFilterSettingsWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filters = EnhancedCompositeFilterService.instance.filters;

    if (filters.isEmpty) {
      return const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: CallFilterSettingsWidget(),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: filters.length,
      itemBuilder: (context, index) {
        final filter = filters[index];
        return _buildDynamicFilterCard(context, theme, filter);
      },
    );
  }

  Widget _buildDynamicFilterCard(BuildContext context, ThemeData theme, CallFilterInterface filter) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant, width: 1.0),
      ),
      child: ExpansionTile(
        initiallyExpanded: true,
        leading: Icon(
          Icons.shield_outlined,
          color: theme.colorScheme.primary,
        ),
        title: Text(
          _getFilterTitle(context, filter.filterType),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          'Filter ID: ${filter.filterType.id}',
          style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: _buildSpecificFilterContent(filter.filterType),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecificFilterContent(CallFilterType type) {
    // 遵照 DATA_DRIVEN_ENTITY_SPEC.md 规范：无裸字符串，全强类型值对象比对
    if (type == CallFilterType.basicRule) {
      return const CallFilterSettingsWidget();
    } else if (type == CallFilterType.localCount || type.id == 'localCountThreshold' || type.id == 'timeWindow') {
      return const LocalFilterSettingsWidget();
    } else if (type == CallFilterType.remoteNumber || type.id == 'remoteRisk') {
      return const RemoteFilterSettingsWidget();
    } else if (type == CallFilterType.simSlot) {
      return const SimSlotRuleFilterWidget(simSlotIndex: 0);
    }
    return const LocalFilterSettingsWidget();
  }

  String _getFilterTitle(BuildContext context, CallFilterType type) {
    final l10n = AppLocalizations.of(context);
    if (type == CallFilterType.basicRule) {
      return l10n.basicRuleFilter;
    } else if (type == CallFilterType.localCount || type.id == 'localCountThreshold' || type.id == 'timeWindow') {
      return l10n.localFilterSettings;
    } else if (type == CallFilterType.remoteNumber || type.id == 'remoteRisk') {
      return l10n.remoteFilterSettings;
    } else if (type == CallFilterType.simSlot) {
      return l10n.simSlotRuleManagement;
    }
    return type.id;
  }
}
