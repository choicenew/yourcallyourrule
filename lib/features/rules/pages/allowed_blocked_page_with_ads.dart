import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/core/entities/list/list_entry.dart';
import 'package:yourcallyourrule/core/entities/rule/allowed_blocked_rule.dart';
import 'package:yourcallyourrule/core/provider/providers/allowed_blocked_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/predefined_label_service_provider.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/services/import_export_service_component.dart';
import 'package:yourcallyourrule/features/common/widgets/dialogs/allowed_blocked_rule_edit_dialog.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/rules/services/allowed_blocked_rule_import_export_adapter.dart';
import 'package:yourcallyourrule/features/common/dialogs/filter_dialogs.dart';
import 'package:yourcallyourrule/features/rules/widgets/rule_action_selector.dart';
import 'package:yourcallyourrule/features/rules/widgets/rule_list_card.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';

/// 允许/阻止规则管理页面 - 带广告版本
/// 使用GenericListWithAdsPage组件实现带广告的列表页面
class AllowedBlockedPageWithAds extends ConsumerStatefulWidget {
  const AllowedBlockedPageWithAds({super.key});

  @override
  ConsumerState<AllowedBlockedPageWithAds> createState() => _AllowedBlockedPageWithAdsState();
}

class _AllowedBlockedPageWithAdsState extends ConsumerState<AllowedBlockedPageWithAds> {
  List<AllowedBlockedRule> _rules = [];
  bool _isLoading = true;
  String? _selectedLabelId;
  Map<String, String> _labelIdToTextMap = {};
  RuleActionType? _selectedActionType;
  Set<String> _selectedRuleIds = {};
  bool _isMultiSelectMode = false;
  String _searchKeyword = '';

  @override
  void initState() {
    super.initState();
    _loadRules();
  }

  List<AllowedBlockedRule> get _filteredRules {
    var filtered = _rules;

    if (_searchKeyword.isNotEmpty) {
      final keyword = _searchKeyword.toLowerCase();
      filtered = filtered.where((rule) {
        final nameMatch = rule.name.toLowerCase().contains(keyword);
        final phoneMatch = rule.phoneNumber.contains(_searchKeyword);
        return nameMatch || phoneMatch;
      }).toList();
    }

    return filtered;
  }

  void _onSearchChanged(String keyword) {
    setState(() {
      _searchKeyword = keyword;
    });
  }

  Future<void> _loadRules() async {
    setState(() {
      _isLoading = true;
    });

    final service = ref.read(allowedBlockedServiceProvider);
    final rules = await service.getAllAllowedBlockedRules();

    final predefinedLabelService = ref.read(predefinedLabelServiceProvider);
    final allLabels = await predefinedLabelService.getAllLabels();
    final labelMap = {for (var label in allLabels) label.id: label.text};

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
      _labelIdToTextMap = labelMap;
    });
  }

  void _toggleRuleStatus(String ruleId, bool isEnabled) async {
    final service = ref.read(allowedBlockedServiceProvider);
    await service.toggleRuleStatus(ruleId, isEnabled);
    _loadRules();
  }

  void _deleteRule(String ruleId) async {
    final service = ref.read(allowedBlockedServiceProvider);
    await service.removeRule(ruleId);
    _loadRules();
  }

  void _deleteSelectedRules() async {
    final service = ref.read(allowedBlockedServiceProvider);
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
    final allowedBlockedService = ref.read(allowedBlockedServiceProvider);
    
    // 创建导入导出组件
    final importExportComponent =
        ImportExportServiceComponent<AllowedBlockedRule, String>(
      importExportService: AllowedBlockedRuleImportExportAdapter(allowedBlockedService.importExportService),
      entityTypeName: AppLocalizations.of(context)!.allowedBlockedRule,
      onEntitiesImported: (rules) async {
        // 保存导入的规则
        for (final rule in rules) {
          await allowedBlockedService.updateAllowedBlockedRule(rule);
        }
        _loadRules();
      },
      getEntitiesToExport: () => allowedBlockedService.getAllAllowedBlockedRules(),
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
              showActionFilterDialog(context, _filterByAction);
            },
          ),
          ListTile(
            leading: const Icon(Icons.label),
            title: Text(AppLocalizations.of(context)!.filterByLabel),
            onTap: () {
              Navigator.pop(context);
              showLabelFilterDialog(context, _filterByLabel, themeColor: Colors.amber);
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

  void _showAddRuleDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    String? selectedLabelId;
    RuleAction selectedAction = RuleAction.block;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.addAllowedBlockedRule),
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
                themeColor: Colors.amber,
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
                  final service = ref.read(allowedBlockedServiceProvider);
                  
                  // 创建列表条目
                  final entry = ListEntry(
                    id: const Uuid().v4(),
                    name: nameController.text,
                    phoneNumber: PhoneNumber.fromString(phoneController.text),
                    labelId: selectedLabelId ?? '',
                    avatar: null,
                  );
                  
                  // 添加规则
                  await service.addAllowedBlockedRule(entry, selectedAction);
                  
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
    return GenericListWithAdsPage<AllowedBlockedRule>(
      title: AppLocalizations.of(context)!.allowedBlockedRuleManagement,
      items: _filteredRules,
      itemBuilder: (context, rule) => _buildRuleCard(context, rule),
      adBuilder: () => GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
      adInterval: 3,
      emptyText: AppLocalizations.of(context)!.noAllowedBlockedRules,
      emptyIcon: Icons.person,
      themeColor: Colors.amber,
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
      onSearchChanged: _onSearchChanged,
      searchHintText: AppLocalizations.of(context)!.searchByNameOrPhoneNumber,
      infoCard: _buildInfoCard(),
    );
  }

  Widget _buildRuleCard(BuildContext context, AllowedBlockedRule rule) {
    return RuleListCard(
      id: rule.id,
      name: rule.name,
      phoneNumber: rule.phoneNumber,
      labelId: rule.labelId,
      avatar: rule.avatar,
      isEnabled: rule.isEnabled,
      action: rule.action,
      labelIdToTextMap: _labelIdToTextMap,
      isMultiSelectMode: _isMultiSelectMode,
      isSelected: _selectedRuleIds.contains(rule.id),
      onToggleStatus: _toggleRuleStatus,
      onEdit: () {
        AllowedBlockedRuleEditDialog.show(
          context,
          rule,
          onRuleUpdated: _loadRules,
        );
      },
      onDelete: () => _deleteRule(rule.id),
     // onToggleSelection: _toggleItemSelection,
      themeColor: Colors.amber,
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.allowedBlockedRuleManagement,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.allowedBlockedRulesInfo,
            ),
          ],
        ),
      ),
    );
  }


}