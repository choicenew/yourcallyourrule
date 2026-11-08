import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/common/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/services/import_export_service_component.dart';
import 'package:yourcallyourrule/features/common/widgets/rule_management_widget.dart';
import 'package:yourcallyourrule/features/rules/utils/rule_action_display_utils.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 通用规则管理页面组件
/// 用于处理各种类型的规则管理页面，包括黑白名单、允�?阻止规则、正则规则等
/// [T] 是规则实体类�?
/// [S] 是规则服务类�?
class GenericRulePage<T, S> extends ConsumerStatefulWidget {
  /// 页面标题
  final String title;
  
  /// 主题颜色（可选）
  final Color? themeColor;
  
  /// 空状态文�?
  final String emptyText;
  
  /// 空状态图�?
  final IconData emptyIcon;
  
  /// 添加按钮文本
  final String addButtonText;
  
  /// 是否使用标签筛�?
  final bool useLabelFilter;
  
  /// 是否使用动作筛�?
  final bool useActionFilter;
  
  /// 获取规则动作的函�?
  final RuleAction? Function(T rule)? getRuleAction;

  /// 获取规则 ID 函数
  final String Function(T rule) getItemId;
  
  /// 规则卡片构建函数
  final Widget Function(BuildContext context, T rule) buildRuleCard;
  
  /// 添加规则对话框函�?
  final void Function(BuildContext context, S service, Function refreshCallback) showAddDialog;
  
  /// 编辑规则对话框函�?
  final void Function(BuildContext context, S service, T rule, Function refreshCallback)? showEditDialog;
  
  /// 获取所有规则函�?
  final Future<List<T>> Function(S service) getAllRules;
  
  /// 删除规则函数
  final Future<void> Function(S service, String ruleId) deleteRule;
  
  /// 切换规则状态函�?
  final Future<void> Function(S service, String ruleId, bool isEnabled) toggleRuleStatus;
  
  /// 搜索规则函数
  final List<T> Function(List<T> rules, String query) searchRules;
  
  /// 按标签筛选规则函�?
  final List<T> Function(List<T> rules, String labelId)? filterRulesByLabel;
  
  /// 按动作类型筛选规则函�?
  final List<T> Function(List<T> rules, RuleActionType actionType)? filterRulesByAction;
  
  /// 获取服务提供者函�?
  final AlwaysAliveProviderBase<S> serviceProvider;
  
  /// 导入导出服务组件（可选）
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
