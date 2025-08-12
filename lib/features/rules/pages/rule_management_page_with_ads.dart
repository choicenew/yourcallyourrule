import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/core/entities/list/list_entry.dart';
import 'package:yourcallyourrule/core/entities/rule/phone_rule.dart';
import 'package:yourcallyourrule/core/provider/providers/rule_management_service_provider.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/services/import_export_service_component.dart';
import 'package:yourcallyourrule/features/common/widgets/dialogs/phone_rule_edit_dialog.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/rules/services/phone_rule_import_export_adapter.dart';
import 'package:yourcallyourrule/features/rules/services/rule_management_service.dart';
import 'package:yourcallyourrule/features/rules/utils/rule_action_display_utils.dart';
import 'package:yourcallyourrule/features/rules/widgets/rule_action_selector.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';

/// 规则管理页面 - 带广告版本
/// 使用GenericListWithAdsPage组件实现带广告的列表页面
class RuleManagementPageWithAds extends ConsumerStatefulWidget {
  const RuleManagementPageWithAds({super.key});

  @override
  ConsumerState<RuleManagementPageWithAds> createState() => _RuleManagementPageWithAdsState();
}

class _RuleManagementPageWithAdsState extends ConsumerState<RuleManagementPageWithAds> {
  List<PhoneRule> _rules = [];
  bool _isLoading = true;
  String? _selectedLabelId;
  RuleActionType? _selectedActionType;
  Set<String> _selectedRuleIds = {};
  bool _isMultiSelectMode = false;

  @override
  void initState() {
    super.initState();
    _loadRules();
  }

  Future<void> _loadRules() async {
    setState(() {
      _isLoading = true;
    });

    final service = ref.read(ruleManagementServiceProvider);
    final rules = await service.getAllRulesByActionType(null);

    // 应用筛选条件
    final filteredRules = rules.where((rule) {
      // 标签筛选
      if (_selectedLabelId != null && rule.labelId != _selectedLabelId) {
        return false;
      }

      // 动作类型筛选
      if (_selectedActionType != null && rule.action.type != _selectedActionType) {
        return false;
      }

      return true;
    }).toList();

    setState(() {
      _rules = filteredRules;
      _isLoading = false;
    });
  }

  void _toggleRuleStatus(String ruleId, bool isEnabled) async {
    final service = ref.read(ruleManagementServiceProvider);
    await service.toggleRuleStatus(ruleId, isEnabled);
    _loadRules();
  }

  void _deleteRule(String ruleId) async {
    final service = ref.read(ruleManagementServiceProvider);
    await service.removeRule(ruleId);
    _loadRules();
  }

  void _deleteSelectedRules() async {
    final service = ref.read(ruleManagementServiceProvider);
    for (final ruleId in _selectedRuleIds) {
      await service.removeRule(ruleId);
    }
    
    setState(() {
      _selectedRuleIds = {};
      _isMultiSelectMode = false;
    });
    
    _loadRules();
  }

  void _toggleMultiSelectMode() {
    setState(() {
      _isMultiSelectMode = !_isMultiSelectMode;
      if (!_isMultiSelectMode) {
        _selectedRuleIds = {};
      }
    });
  }

  void _toggleItemSelection(String ruleId) {
    setState(() {
      if (_selectedRuleIds.contains(ruleId)) {
        _selectedRuleIds.remove(ruleId);
      } else {
        _selectedRuleIds.add(ruleId);
      }
    });
  }

  void _filterByAction(RuleActionType? actionType) {
    setState(() {
      _selectedActionType = actionType;
    });
    _loadRules();
  }

  void _filterByLabel(String? labelId) {
    setState(() {
      _selectedLabelId = labelId;
    });
    _loadRules();
  }

  void _showMoreOptions(BuildContext context) {
    final ruleManagementService = ref.read(ruleManagementServiceProvider);
    
    // 创建导入导出组件
    final importExportComponent =
        ImportExportServiceComponent<PhoneRule, String>(
      importExportService: PhoneRuleImportExportAdapter(ruleManagementService.importExportService),
      entityTypeName: AppLocalizations.of(context)!.phoneRule,
      onEntitiesImported: (rules) async {
        // 使用服务类的公共方法保存规则
        for (final rule in rules) {
          await ruleManagementService.updatePhoneNumberRule(rule);
        }
        _loadRules();
      },
      getEntitiesToExport: () => ruleManagementService.getAllRulesByActionType(null),
    );

    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.filter_list),
            title: Text(AppLocalizations.of(context)!.filterByAction),
            onTap: () {
              Navigator.pop(context);
              _showActionFilterDialog(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.label),
            title: Text(AppLocalizations.of(context)!.filterByLabel),
            onTap: () {
              Navigator.pop(context);
              _showLabelFilterDialog(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.import_export),
            title: Text(AppLocalizations.of(context)!.importExport),
            onTap: () {
              Navigator.pop(context);
              importExportComponent.showImportExportDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _showActionFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.filterByAction),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(AppLocalizations.of(context)!.all),
              onTap: () {
                _filterByAction(null);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.allow),
              onTap: () {
                _filterByAction(RuleActionType.allow);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.block),
              onTap: () {
                _filterByAction(RuleActionType.block);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.silence),
              onTap: () {
                _filterByAction(RuleActionType.silence);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLabelFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.filterByLabel),
        content: SizedBox(
          width: double.maxFinite,
          child: PublicSelectLabel(
            onLabelIdChanged: (labelId) {
              _filterByLabel(labelId);
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
              _filterByLabel(null);
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context)!.clearFilter),
          ),
        ],
      ),
    );
  }

  void _showAddRuleDialog(BuildContext context) {
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
                  final service = ref.read(ruleManagementServiceProvider);
                  
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
                  _loadRules();
                  
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

  @override
  Widget build(BuildContext context) {
    return GenericListWithAdsPage<PhoneRule>(
      title: AppLocalizations.of(context)!.phoneRuleManagement,
      items: _rules,
      itemBuilder: (context, rule) => _buildRuleCard(context, rule),
      adBuilder: () => GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
      adInterval: 3,
      emptyText: AppLocalizations.of(context)!.noPhoneRules,
      emptyIcon: Icons.phone,
      themeColor: Colors.green,
      isLoading: _isLoading,
      onRefresh: _loadRules,
      onAdd: () => _showAddRuleDialog(context),
      onMoreOptions: () => _showMoreOptions(context),
      onMultiSelect: (selectedRules) {},
      getItemId: (rule) => rule.id,
      isMultiSelectMode: _isMultiSelectMode,
      selectedItemIds: _selectedRuleIds,
      onToggleMultiSelectMode: _toggleMultiSelectMode,
      onDeleteSelected: _deleteSelectedRules,
      onToggleItemSelection: _toggleItemSelection,
    );
  }

  Widget _buildRuleCard(BuildContext context, PhoneRule rule) {
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
                Switch(
                  value: rule.isEnabled,
                  onChanged: (value) => _toggleRuleStatus(rule.id, value),
                  activeColor: Colors.green,
                ),
                if (!_isMultiSelectMode)
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      PhoneRuleEditDialog.show(
                        context, 
                        rule, 
                        onRuleUpdated: _loadRules,
                      );
                    },
                  ),
                if (!_isMultiSelectMode)
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteRule(rule.id),
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
                    Chip(
                      label: Text('${AppLocalizations.of(context)!.label}: ${rule.labelId}'),
                      backgroundColor: Colors.green.withValues(alpha:0.1),
                      labelStyle: const TextStyle(color: Colors.green),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}