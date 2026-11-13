import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_call_filter_hub/pyro_call_filter_hub.dart';
import 'package:pyro_call_filter_protocol/pyro_call_filter_protocol.dart';
import 'package:yourcallyourrule/features/call_filter/presentation/widgets/call_filter_settings_widget.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 动态组合过滤器配置组件 (EnhancedCompositeFilterSettingsWidget)
/// 基于主 App 在协调层注册装载的 `EnhancedCompositeFilterService.instance.filters` 集合进行动态呈现
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
    final filterId = filter.filterType.id;

    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant, width: 1.0),
      ),
      child: ExpansionTile(
        leading: Icon(
          Icons.shield_outlined,
          color: theme.colorScheme.primary,
        ),
        title: Text(
          _getFilterTitle(context, filterId),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          'Filter ID: $filterId',
          style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: filterId == 'basicRule'
                ? const CallFilterSettingsWidget()
                : Text(
                    '${AppLocalizations.of(context).configureSimCardFilterRules}: $filterId',
                    style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                  ),
          ),
        ],
      ),
    );
  }

  String _getFilterTitle(BuildContext context, String filterId) {
    final l10n = AppLocalizations.of(context);
    switch (filterId) {
      case 'basicRule':
        return l10n.basicRuleFilter;
      case 'localCount':
        return l10n.localFilterSettings;
      case 'remoteNumber':
        return l10n.remoteFilterSettings;
      case 'simSlot':
        return l10n.simSlotRuleManagement;
      default:
        return filterId;
    }
  }
}
