import 'package:flutter/material.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/services/import_export_service_component.dart';

/// 规则管理通用 UI 挂载组件
class RuleManagementWidget<T> extends StatefulWidget {
  final String title;
  final String emptyText;
  final IconData emptyIcon;
  final String addButtonText;
  final bool useLabelFilter;
  final bool useActionFilter;
  final String Function(T item) getItemId;
  final Widget Function(BuildContext context, T item) buildRuleCard;
  final VoidCallback onAddPressed;
  final Future<List<T>> Function() getAllRules;
  final Future<void> Function(String id) deleteRule;
  final Future<void> Function(String id, bool isEnabled) toggleRuleStatus;
  final List<T> Function(List<T> items, String query) searchRules;
  final List<T> Function(List<T> items, String labelId)? filterRulesByLabel;
  final List<T> Function(List<T> items, RuleActionType actionType)? filterRulesByAction;
  final ImportExportServiceComponent<T, String>? importExportComponent;

  const RuleManagementWidget({
    super.key,
    required this.title,
    required this.emptyText,
    required this.emptyIcon,
    required this.addButtonText,
    this.useLabelFilter = true,
    this.useActionFilter = false,
    required this.getItemId,
    required this.buildRuleCard,
    required this.onAddPressed,
    required this.getAllRules,
    required this.deleteRule,
    required this.toggleRuleStatus,
    required this.searchRules,
    this.filterRulesByLabel,
    this.filterRulesByAction,
    this.importExportComponent,
  });

  @override
  State<RuleManagementWidget<T>> createState() => _RuleManagementWidgetState<T>();
}

class _RuleManagementWidgetState<T> extends State<RuleManagementWidget<T>> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: widget.getAllRules(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final items = snapshot.data ?? [];
        if (items.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget.emptyIcon, size: 64, color: Theme.of(context).colorScheme.outline),
                const SizedBox(height: 16),
                Text(widget.emptyText),
              ],
            ),
          );
        }
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return widget.buildRuleCard(context, item);
          },
        );
      },
    );
  }
}
