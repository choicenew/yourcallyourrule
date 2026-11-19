import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_call_filter_hub/pyro_phone_call_filter_hub.dart';
import 'package:pyro_phone_call_filter_protocol/pyro_phone_call_filter_protocol.dart';
import 'package:yourcallyourrule/core/coordinator/filter_ui_registry.dart';

/// 100% 纯框架、零子包 import、零魔鬼字符串、零 switch-case 的大盘容器组件
class EnhancedCompositeFilterSettingsWidget extends ConsumerWidget {
  const EnhancedCompositeFilterSettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final filters = EnhancedCompositeFilterService.instance.filters;

    if (filters.isEmpty) {
      return const SizedBox.shrink();
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
    final uiSpec = FilterUiRegistry.get(filterId);

    if (uiSpec == null) {
      return const SizedBox.shrink();
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant, width: 1.0),
      ),
      child: ExpansionTile(
        initiallyExpanded: false,
        leading: Icon(
          uiSpec.icon,
          color: theme.colorScheme.primary,
        ),
        title: Text(
          uiSpec.titleBuilder(context),
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
            padding: const EdgeInsets.all(12.0),
            child: uiSpec.contentBuilder(context),
          ),
        ],
      ),
    );
  }
}
