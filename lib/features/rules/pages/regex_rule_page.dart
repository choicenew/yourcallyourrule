import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:pyro_phone_rules_hub/pyro_phone_rules_hub.dart';
import 'package:pyro_phone_rules_ui/pyro_phone_rules_ui.dart' as rules_pkg_ui;
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 使用 GenericListWithAdsPage 挂载 Package 视图的正则规则管理页面
class RegexRulePage extends ConsumerWidget {
  const RegexRulePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final rules = ref.watch(phoneRulesControlCenterProvider).regexRules;

    return GenericListWithAdsPage<PhoneRuleEntity>(
      title: l10n.regexRuleManagement,
      items: rules,
      emptyText: l10n.noRulesFound ?? 'No Regex Rules',
      adInterval: 3,
      adBuilder: () => const InlineAdaptiveAd(),
      itemBuilder: (context, rule) => rules_pkg_ui.PyroPhoneRuleCardWidget(
        rule: rule,
        onTap: () => ref.read(phoneRulesControlCenterProvider).editRule(rule),
      ),
      getItemId: (rule) => rule.id,
      onAdd: () => ref.read(phoneRulesControlCenterProvider).openAddDialog(context, ruleType: 'regex'),
      onSearchChanged: (query) => ref.read(phoneRulesControlCenterProvider).searchRegexRules(query),
      onDeleteSelected: () => ref.read(phoneRulesControlCenterProvider).deleteSelected(),
    );
  }
}

      toggleRule: (service, ruleId, isEnabled) =>
          service.toggleRegexRule(ruleId, isEnabled),
      deleteRule: (service, ruleId) => service.removeRegexRule(ruleId),
      importExportComponent: importExportComponent,
      useActionFilter: true,
      getRuleAction: (rule) => rule.action,
    );
  }

  /// 构建规则卡片
  Widget _buildRuleCard(BuildContext context, RegexRule rule) {
    final actionText = _getActionText(context, rule.action);
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

  /// 显示添加规则对话�?
  void _showAddRuleDialog(
      BuildContext context, RegexService service, Function refreshCallback) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController patternController = TextEditingController();
    RuleAction selectedAction = RuleAction.block;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)!.addRegexRule),
              const RegexPatternExplanationButton(),
            ],
          ),
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
              // 使用RuleActionSelector组件替换简单的下拉选择�?
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
              child: Text(AppLocalizations.of(context)!.cancelButton),
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
                  // 验证正则表达�?
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
  String _getActionText(BuildContext context, RuleAction action) {
    return RuleActionDisplayUtils.getActionTypeName(context, action.type);
  }

  /// 获取动作颜色
  Color _getActionColor(RuleAction action) {
    return RuleActionDisplayUtils.getActionTypeColor(action.type);
  }
}
