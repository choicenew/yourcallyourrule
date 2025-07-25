import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/regex/regex_pattern.dart';
import 'package:yourcallyourrule/core/entities/rule/regex_rule.dart';
import 'package:yourcallyourrule/core/services/import_export_service.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/services/import_export_service_component.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_rule_page.dart';
import 'package:yourcallyourrule/features/rules/services/regex_service.dart';
import 'package:yourcallyourrule/features/rules/widgets/rule_action_selector.dart';
import 'package:yourcallyourrule/features/rules/utils/rule_action_display_utils.dart';
import 'package:yourcallyourrule/core/provider/providers/regex_service_provider.dart';
import 'package:yourcallyourrule/features/rules/services/regex_rule_import_export_adapter.dart';

import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 重构后的正则规则管理页面
/// 使用通用的GenericRulePage组件减少重复代码
class RegexRulePage extends ConsumerWidget {
  const RegexRulePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final regexService = ref.read(regexServiceProvider);

    // 创建导入导出组件
    final importExportComponent =
        ImportExportServiceComponent<RegexRule, String>(
      importExportService: RegexRuleImportExportAdapter(regexService.importExportService),
      entityTypeName: AppLocalizations.of(context)!.regexRule,
      onEntitiesImported: (rules) async {
        // 使用服务类的公共方法保存规则
        for (final rule in rules) {
          await regexService.updateRegexRule(rule);
        }
      },
      getEntitiesToExport: () => regexService.getAllRegexRules(),
    );

    return GenericRulePage<RegexRule, RegexService>(
      serviceProvider: regexServiceProvider,
      title: AppLocalizations.of(context)!.regexRuleManagement,
      themeColor: const Color(0xFFF5A623),
      emptyText: AppLocalizations.of(context)!.regexRule,
      emptyIcon: Icons.code,
      addButtonText: AppLocalizations.of(context)!.addRegexRule,
      buildRuleCard: _buildRuleCard,
      showAddDialog: _showAddRuleDialog,
      getAllRules: (service) => service.getAllRegexRules(),
      toggleRule: (service, ruleId, isEnabled) =>
          service.toggleRegexRule(ruleId, isEnabled),
      deleteRule: (service, ruleId) => service.removeRegexRule(ruleId),
      importExportComponent: importExportComponent,
      useActionFilter: true,
      getRuleAction: (rule) => rule.action,
    );
  }

  /// 构建规则卡片
  Widget _buildRuleCard(RegexRule rule) {
    final actionText = _getActionText(rule.action);
    final actionColor = _getActionColor(rule.action);

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: actionColor.withValues(alpha:0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.code,
                    color: actionColor,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rule.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        rule.pattern,
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontFamily: 'monospace'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Chip(
                label: Text(actionText),
                backgroundColor: actionColor.withValues(alpha:0.1),
                labelStyle: TextStyle(color: actionColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 显示添加规则对话框
  void _showAddRuleDialog(
      BuildContext context, RegexService service, Function refreshCallback) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController patternController = TextEditingController();
    RuleAction selectedAction = RuleAction.block;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.addRegexRule),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.ruleName,
                  hintText: AppLocalizations.of(context)!.exampleBlock400Prefix,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: patternController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.regexPattern,
                  hintText: "${AppLocalizations.of(context)!.exampleRegex400Prefix}:'^400\\d{7}\$'",
                ),
              ),
              const SizedBox(height: 16),
              // 使用RuleActionSelector组件替换简单的下拉选择框
              RuleActionSelector(
                initialAction: selectedAction,
                onActionChanged: (action) {
                  setState(() {
                    selectedAction = action;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () async {
                if (nameController.text.isEmpty ||
                    patternController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(AppLocalizations.of(context)!.regexRuleNamePatternRequired),
                    backgroundColor: Colors.red,
                  ));
                  return;
                }

                try {
                  // 验证正则表达式
                  if (!service.isValidRegex(patternController.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(AppLocalizations.of(context)!.invalidRegexPattern),
                      backgroundColor: Colors.red,
                    ));
                    return;
                  }

                  // 创建正则模式
                  final pattern = RegExPattern(
                    name: nameController.text,
                    pattern: patternController.text,
                    action: selectedAction,
                  );

                  // 添加规则
                  await service.addRegexRule(pattern);

                  // 刷新规则列表
                  Navigator.pop(context);
                  refreshCallback();

                  // 显示成功提示
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(AppLocalizations.of(context)!.regexRuleAddSuccess),
                    backgroundColor: Colors.green,
                  ));
                } catch (e) {
                  // 显示错误提示
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(AppLocalizations.of(context)!.regexRuleAddFailed(e.toString())),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              child: Text(AppLocalizations.of(context)!.save),
            ),
          ],
        ),
      ),
    );
  }

  /// 获取动作文本
  String _getActionText(RuleAction action) {
    return RuleActionDisplayUtils.getActionTypeName(action.type);
  }

  /// 获取动作颜色
  Color _getActionColor(RuleAction action) {
    return RuleActionDisplayUtils.getActionTypeColor(action.type);
  }
}
