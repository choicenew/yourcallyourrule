import 'package:flutter/material.dart';

import 'package:yourcallyourrule/core/base/base_entity.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/services/import_export_service_component.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 通用规则管理组件
/// 用于处理各种类型的规则管理，包括添加、编辑、启用/禁用、删除规则等功能
/// [T] 是规则实体类型
class RuleManagementWidget<T extends BaseEntity> extends StatefulWidget {
  /// 规则列表
  final List<T> rules;
  
  /// 是否正在加载
  final bool isLoading;
  
  /// 加载规则的回调
  final Future<void> Function() onLoadRules;
  
  /// 构建规则卡片的回调
  final Widget Function(T rule) buildRuleCard;
  
  /// 添加规则的回调
  final void Function() onAddRule;
  
  /// 编辑规则的回调
  final void Function(T rule)? onEditRule;
  
  /// 切换规则状态的回调
  final Future<void> Function(String ruleId, bool isEnabled) onToggleRule;
  
  /// 删除规则的回调
  final Future<void> Function(String ruleId) onDeleteRule;
  
  /// 导入导出服务组件
  final ImportExportServiceComponent? importExportComponent;
  
  /// 页面标题
  final String title;
  
  /// 空状态图标
  final IconData emptyIcon;
  
  /// 空状态文本
  final String emptyText;
  
  /// 添加按钮文本
  final String addButtonText;
  
  /// 主题颜色
  final Color themeColor;
  
  /// 是否使用标签筛选
  final bool useLabelFilter;
  
  /// 当前选中的标签ID
  final String? selectedLabelId;
  
  /// 标签筛选回调
  final void Function()? onShowLabelFilter;
  
  /// 清除标签筛选回调
  final void Function()? onClearLabelFilter;
  
  /// 是否使用动作筛选
  final bool useActionFilter;
  
  /// 当前选中的动作类型
  final RuleActionType? selectedActionType;
  
  /// 动作筛选回调
  final void Function()? onShowActionFilter;
  
  /// 清除动作筛选回调
  final void Function()? onClearActionFilter;

  const RuleManagementWidget({
    super.key,
    required this.rules,
    required this.isLoading,
    required this.onLoadRules,
    required this.buildRuleCard,
    required this.onAddRule,
    this.onEditRule,
    required this.onToggleRule,
    required this.onDeleteRule,
    this.importExportComponent,
    required this.title,
    required this.emptyIcon,
    required this.emptyText,
    required this.addButtonText,
    this.themeColor = const Color(0xFFF5A623),
    this.useLabelFilter = false,
    this.selectedLabelId,
    this.onShowLabelFilter,
    this.onClearLabelFilter,
    this.useActionFilter = false,
    this.selectedActionType,
    this.onShowActionFilter,
    this.onClearActionFilter,
  });

  @override
  State<RuleManagementWidget<T>> createState() => _RuleManagementWidgetState<T>();
}

class _RuleManagementWidgetState<T extends BaseEntity> extends State<RuleManagementWidget<T>> {
  /// 获取动作类型名称
  String _getActionTypeName(RuleActionType type) {
    switch (type) {
      case RuleActionType.allow:
        return AppLocalizations.of(context)!.actionAllow;
      case RuleActionType.block:
        return AppLocalizations.of(context)!.actionBlock;
      case RuleActionType.silence:
        return AppLocalizations.of(context)!.actionSilence;
      case RuleActionType.none:
        return AppLocalizations.of(context)!.actionNone;
      default:
        return AppLocalizations.of(context)!.actionUnknown;
    }
  }
  
  /// 获取动作类型颜色
  Color _getActionTypeColor(RuleActionType type) {
    switch (type) {
      case RuleActionType.allow:
        return Colors.green;
      case RuleActionType.block:
        return Colors.red;
      case RuleActionType.silence:
        return Colors.orange;
      case RuleActionType.none:
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.themeColor,
        elevation: 0,
        actions: [
          if (widget.useLabelFilter)
            IconButton(
              icon: const Icon(Icons.label),
              onPressed: widget.onShowLabelFilter,
              tooltip: AppLocalizations.of(context)!.labelFilterTooltip,
            ),
          if (widget.useActionFilter)
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: widget.onShowActionFilter,
              tooltip: AppLocalizations.of(context)!.actionFilterTooltip,
            ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: widget.onLoadRules,
            tooltip: AppLocalizations.of(context)!.refreshTooltip,
          ),
          if (widget.importExportComponent != null)
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'import') {
                  widget.importExportComponent!.importFromFile(context);
                } else if (value == 'export') {
                  widget.importExportComponent!.exportToFile(context);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem<String>(
                  value: 'import',
                  child: Row(
                    children: [
                      const Icon(Icons.file_upload, color: Color(0xFFF5A623)),
                      const SizedBox(width: 8),
                      Text(AppLocalizations.of(context)!.importRules),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'export',
                  child: Row(
                    children: [
                      const Icon(Icons.file_download, color: Color(0xFFF5A623)),
                      const SizedBox(width: 8),
                      Text(AppLocalizations.of(context)!.exportRules),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
      body: Column(
        children: [
          // 显示当前筛选条件
          if ((widget.useLabelFilter && widget.selectedLabelId != null) ||
              (widget.useActionFilter && widget.selectedActionType != null))
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 8.0,
                children: [
                  // 标签筛选条件
                  if (widget.useLabelFilter && widget.selectedLabelId != null)
                    Chip(
                      label: Text(AppLocalizations.of(context)!.labelTag(widget.selectedLabelId!)),
                      backgroundColor: Colors.blue.withAlpha(25),
                      labelStyle: const TextStyle(color: Colors.blue),
                      deleteIcon: const Icon(Icons.close, size: 18),
                      onDeleted: widget.onClearLabelFilter,
                    ),
                  // 动作筛选条件
                  if (widget.useActionFilter && widget.selectedActionType != null)
                    Chip(
                      label: Text(AppLocalizations.of(context)!.actionTag(_getActionTypeName(widget.selectedActionType!))),
                      backgroundColor: _getActionTypeColor(widget.selectedActionType!).withAlpha(25),
                      labelStyle: TextStyle(color: _getActionTypeColor(widget.selectedActionType!)),
                      deleteIcon: const Icon(Icons.close, size: 18),
                      onDeleted: widget.onClearActionFilter,
                    ),
                ],
              ),
            ),
          // 规则列表
          Expanded(
            child: widget.isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildRulesList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.onAddRule,
        backgroundColor: widget.themeColor,
        tooltip: AppLocalizations.of(context)!.addRuleTooltip,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildRulesList() {
    if (widget.rules.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.emptyIcon,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              (widget.selectedLabelId != null || widget.selectedActionType != null)
                  ? AppLocalizations.of(context)!.noMatchingRules(widget.emptyText)
                  : AppLocalizations.of(context)!.noRules(widget.emptyText),
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: widget.onAddRule,
              icon: const Icon(Icons.add),
              label: Text(widget.addButtonText),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.themeColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            if (widget.importExportComponent != null) ...[  
              const SizedBox(height: 16),
              widget.importExportComponent!.buildImportExportButtons(context),
            ],
            if (widget.useLabelFilter && widget.selectedLabelId != null)
              TextButton(
                onPressed: widget.onClearLabelFilter,
                child: Text(AppLocalizations.of(context)!.clearLabelFilterButton),
              ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.rules.length,
      itemBuilder: (context, index) {
        final rule = widget.rules[index];
        // 如果提供了编辑回调，则使规则卡片可点击进行编辑
        if (widget.onEditRule != null) {
          return InkWell(
            onTap: () => widget.onEditRule!(rule),
            child: widget.buildRuleCard(rule),
          );
        } else {
          return widget.buildRuleCard(rule);
        }
      },
    );
  }

  /// 显示确认对话框
  Future<bool> showConfirmDialog({
    required String title,
    required String content,
    required String confirmText,
    Color confirmColor = Colors.red,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(confirmText, style: TextStyle(color: confirmColor)),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}