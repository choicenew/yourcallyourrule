import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/providers/rule_management_service_provider.dart';
import 'package:yourcallyourrule/core/entities/list/list_entry.dart';
import 'package:yourcallyourrule/core/entities/rule/phone_rule.dart';
import 'package:yourcallyourrule/core/services/import_export_service.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/services/import_export_service_component.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_rule_page.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/rules/services/rule_management_service.dart';
import 'package:yourcallyourrule/features/rules/widgets/rule_action_selector.dart';
import 'package:yourcallyourrule/features/rules/utils/rule_action_display_utils.dart';
import 'package:yourcallyourrule/features/common/widgets/dialogs/phone_rule_edit_dialog.dart';
import 'package:yourcallyourrule/features/rules/services/phone_rule_import_export_adapter.dart';

import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 规则管理页面
/// 使用通用的GenericRulePage组件减少重复代码
class RuleManagementPage extends ConsumerWidget {
  const RuleManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ruleManagementService = ref.read(ruleManagementServiceProvider);

    // 创建导入导出组件
    final importExportComponent =
        ImportExportServiceComponent<PhoneRule, String>(
      importExportService: PhoneRuleImportExportAdapter(ruleManagementService.importExportService),
      entityTypeName: AppLocalizations.of(context)!.phoneRule,
      onEntitiesImported: (rules) async {
        // 使用服务类的公共方法保存规则
        for (final rule in rules) {
          // 使用服务类的公共方法而不是直接访问私有成员
          await ruleManagementService.updatePhoneNumberRule(rule);
        }
      },
       // 从动作的角度获取所有规则，包括allow、block、silence和none四种类型
      getEntitiesToExport: () => ruleManagementService.getAllRulesByActionType(null),
    );

    return GenericRulePage<PhoneRule, RuleManagementService>(
      serviceProvider: ruleManagementServiceProvider,
      title: AppLocalizations.of(context)!.phoneRuleManagement,
      themeColor: Colors.green,
      emptyText: AppLocalizations.of(context)!.phoneRule,
      emptyIcon: Icons.phone,
      addButtonText: AppLocalizations.of(context)!.addRule,
      buildRuleCard: _buildRuleCard,
      showAddDialog: _showAddRuleDialog,
      showEditDialog: _showEditRuleDialog,
      getAllRules: (service) => service.getAllRulesByActionType(null),// 从动作的角度获取所有规则，包括allow、block、silence和none四种类型
      toggleRule: (service, ruleId, isEnabled) =>
          service.toggleRuleStatus(ruleId, isEnabled),
      deleteRule: (service, ruleId) => service.removeRule(ruleId),
      importExportComponent: importExportComponent,
      useActionFilter: true,
      getRuleAction: (rule) => rule.action,
      useLabelFilter: true,
      showLabelFilterDialog: _showLabelFilterDialog,
    );
  }

  /// 构建规则卡片
  Widget _buildRuleCard(PhoneRule rule) {
    final actionText = RuleActionDisplayUtils.getActionTypeName(rule.action.type);
    final actionColor = RuleActionDisplayUtils.getActionTypeColor(rule.action.type);

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
                    rule.action.type == RuleActionType.allow ? Icons.check_circle_outline : Icons.block,
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
                        rule.phoneNumber.value,
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Wrap(
                spacing: 8,
                children: [
                  // 动作标签
                  Chip(
                    label: Text(actionText),
                    backgroundColor: actionColor.withValues(alpha:0.1),
                    labelStyle: TextStyle(color: actionColor),
                  ),
                  // 如果有标签，显示标签
                  if (rule.labelId.isNotEmpty)
                    Builder(builder: (context) => Chip(
                      label: Text('${AppLocalizations.of(context)!.label}: ${rule.labelId}'),
                      backgroundColor: Colors.green.withValues(alpha:0.1),
                      labelStyle: const TextStyle(color: Colors.green),
                    )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 显示添加规则对话框
  void _showAddRuleDialog(
      BuildContext context, RuleManagementService service, Function refreshCallback) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    String? selectedLabelId;
    RuleAction selectedAction = RuleAction.block;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.addPhoneNumberRule),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.ruleName,
                  hintText: AppLocalizations.of(context)!.ruleNameHint,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.phoneNumber,
                  hintText: AppLocalizations.of(context)!.phoneNumberHint,
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              // 标签选择器
              PublicSelectLabel(
                onLabelIdChanged: (labelId) {
                  selectedLabelId = labelId;
                },
                themeColor: Colors.green,
              ),
              
              const SizedBox(height: 16),
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
                if (nameController.text.isEmpty || phoneController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(AppLocalizations.of(context)!.ruleNameRequired),
                    backgroundColor: Colors.red,
                  ));
                  return;
                }
                
                try {
                  // 创建列表条目
                  final entry = ListEntry(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: nameController.text,
                    phoneNumber: PhoneNumber.fromString(phoneController.text),
                    labelId: selectedLabelId ?? '',
                    avatar: null,
                  );
                  
                  // 添加规则
                  await service.addPhoneRule(entry, selectedAction);
                  
                  // 刷新规则列表
                  Navigator.pop(context);
                  refreshCallback();
                  
                  // 显示成功提示
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(AppLocalizations.of(context)!.ruleAddSuccess),
                    backgroundColor: Colors.green,
                  ));
                } catch (e) {
                  // 显示错误提示
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(AppLocalizations.of(context)!.addRuleFailed(e.toString())),
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

  /// 显示标签筛选对话框
  void _showLabelFilterDialog(BuildContext context, Function(String?) onLabelSelected) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.filterByLabel),
        content: SizedBox(
          width: double.maxFinite,
          child: PublicSelectLabel(
            onLabelIdChanged: (labelId) {
              onLabelSelected(labelId);
              Navigator.pop(context);
            },
            themeColor: Colors.green,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancelButton),
          ),
          TextButton(
            onPressed: () {
              onLabelSelected(null);
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context)!.clearFilter),
          ),
        ],
      ),
    );
  }
  
  /// 显示编辑规则对话框
  void _showEditRuleDialog(
      BuildContext context, RuleManagementService service, PhoneRule rule, Function refreshCallback) {
    PhoneRuleEditDialog.show(context, rule, onRuleUpdated: refreshCallback);
  }
}