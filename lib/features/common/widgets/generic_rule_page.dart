import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/common/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/services/import_export_service_component.dart';
import 'package:yourcallyourrule/features/common/widgets/rule_management_widget.dart';
import 'package:yourcallyourrule/features/phone_rules/utils/rule_action_display_utils.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class GenericRulePage<T, S> extends ConsumerStatefulWidget {
  final String title;
  final Color? themeColor;
  final String emptyText;
  final IconData emptyIcon;
  final String addButtonText;
  final bool useLabelFilter;
  final bool useActionFilter;
  final RuleAction? Function(T rule)? getRuleAction;
  final String Function(T rule) getItemId;
  final Widget Function(BuildContext context, T rule) buildRuleCard;
  final void Function(BuildContext context, S service, Function refreshCallback) showAddDialog;
  final void Function(BuildContext context, S service, T rule, Function refreshCallback)? showEditDialog;
  final Future<List<T>> Function(S service) getAllRules;
  final Future<void> Function(S service, String ruleId) deleteRule;
  final Future<void> Function(S service, String ruleId, bool isEnabled) toggleRuleStatus;
  final List<T> Function(List<T> rules, String query) searchRules;
  final List<T> Function(List<T> rules, String labelId)? filterRulesByLabel;
  final List<T> Function(List<T> rules, RuleActionType actionType)? filterRulesByAction;
  final AlwaysAliveProviderBase<S> serviceProvider;
  final ImportExportServiceComponent<T, String>? importExportComponent;

  const GenericRulePage({
    super.key,
    required this.title,
    this.themeColor,
    required this.emptyText,
    required this.emptyIcon,
    required this.addButtonText,
    this.useLabelFilter = true,
    this.useActionFilter = false,
    this.getRuleAction,
    required this.getItemId,
    required this.buildRuleCard,
    required this.showAddDialog,
    this.showEditDialog,
    required this.getAllRules,
    required this.deleteRule,
    required this.toggleRuleStatus,
    required this.searchRules,
    this.filterRulesByLabel,
    this.filterRulesByAction,
    required this.serviceProvider,
    this.importExportComponent,
  });

  @override
  ConsumerState<GenericRulePage<T, S>> createState() => _GenericRulePageState<T, S>();
}

class _GenericRulePageState<T, S> extends ConsumerState<GenericRulePage<T, S>> {
  @override
  Widget build(BuildContext context) {
    final service = ref.watch(widget.serviceProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.themeColor,
      ),
      body: RuleManagementWidget<T>(
        title: widget.title,
        emptyText: widget.emptyText,
        emptyIcon: widget.emptyIcon,
        addButtonText: widget.addButtonText,
        useLabelFilter: widget.useLabelFilter,
        useActionFilter: widget.useActionFilter,
        getItemId: widget.getItemId,
        buildRuleCard: (context, rule) => widget.buildRuleCard(context, rule),
        onAddPressed: () => widget.showAddDialog(context, service, () => setState(() {})),
        getAllRules: () => widget.getAllRules(service),
        deleteRule: (id) => widget.deleteRule(service, id),
        toggleRuleStatus: (id, isEnabled) => widget.toggleRuleStatus(service, id, isEnabled),
        searchRules: widget.searchRules,
        filterRulesByLabel: widget.filterRulesByLabel,
        filterRulesByAction: widget.filterRulesByAction,
        importExportComponent: widget.importExportComponent,
      ),
    );
  }
}
