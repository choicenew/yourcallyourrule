import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/core/entities/list/list_entry.dart';
import 'package:yourcallyourrule/core/entities/rule/sim_slot_rule.dart';
import 'package:yourcallyourrule/core/provider/providers/predefined_label_service_provider.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/services/import_export_service_component.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';

import 'package:yourcallyourrule/features/common/dialogs/filter_dialogs.dart';
import 'package:yourcallyourrule/features/rules/widgets/rule_list_card.dart';
import 'package:yourcallyourrule/features/sim_slot/services/sim_slot_rule_import_export_adapter.dart';
import 'package:yourcallyourrule/features/sim_slot/services/sim_slot_rule_service.dart';
import 'package:yourcallyourrule/features/sim_slot/widgets/sim_slot_rule_edit_dialog.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';

/// SIM卡槽位规则管理页面 - 带广告版本
/// 使用GenericListWithAdsPage组件实现带广告的列表页面
class SimSlotRulePageWithAds extends ConsumerStatefulWidget {
  final int simSlotIndex;
  
  const SimSlotRulePageWithAds({
    super.key,
    required this.simSlotIndex,
  });

  @override
  ConsumerState<SimSlotRulePageWithAds> createState() => _SimSlotRulePageWithAdsState();
}

class _SimSlotRulePageWithAdsState extends ConsumerState<SimSlotRulePageWithAds> {
  List<SimSlotRule> _rules = [];
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

  List<SimSlotRule> get _filteredRules {
    if (_searchKeyword.isEmpty) {
      return _rules;
    }
    final keyword = _searchKeyword.toLowerCase();
    return _rules.where((rule) {
      final nameMatch = rule.name.toLowerCase().contains(keyword);
      final phoneMatch = rule.phoneNumber.value.toLowerCase().contains(keyword);
      return nameMatch || phoneMatch;
    }).toList();
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

    final service = ref.read(simSlotRuleServiceProvider);
    final rules = await service.getSimSlotRules(widget.simSlotIndex);
    
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

  Future<void> _addRule(ListEntry entry, RuleAction action) async {
    final service = ref.read(simSlotRuleServiceProvider);
    await service.addSimSlotRule(entry, widget.simSlotIndex, action: action);
    _loadRules();
  }

  Future<void> _deleteRule(String ruleId) async {
    final service = ref.read(simSlotRuleServiceProvider);
    await service.removeSimSlotRule(ruleId);
    _loadRules();
  }

  Future<void> _deleteSelectedRules() async {
    final service = ref.read(simSlotRuleServiceProvider);
    for (final ruleId in _selectedRuleIds) {
      await service.removeSimSlotRule(ruleId);
    }
    setState(() {
      _selectedRuleIds.clear();
      _isMultiSelectMode = false;
    });
    _loadRules();
  }

  Future<void> _toggleRuleStatus(String ruleId, bool isEnabled) async {
    final service = ref.read(simSlotRuleServiceProvider);
    await service.toggleRuleStatus(ruleId, isEnabled);
    _loadRules();
  }

  void _toggleMultiSelectMode() {
    setState(() {
      _isMultiSelectMode = !_isMultiSelectMode;
      if (!_isMultiSelectMode) {
        _selectedRuleIds.clear();
      }
    });
  }

  void _toggleRuleSelection(String ruleId) {
    setState(() {
      if (_selectedRuleIds.contains(ruleId)) {
        _selectedRuleIds.remove(ruleId);
      } else {
        _selectedRuleIds.add(ruleId);
      }
    });
  }

  Future<void> _showAddRuleDialog() async {
    SimSlotRuleEditDialog.showAdd(
      context,
      widget.simSlotIndex,
      onRuleUpdated: _loadRules,
      themeColor: Colors.amber,
    );
  }

  // 移除未使用的过滤/导入导出对话框方法，直接在底部弹窗中调用通用组件

  void _showMoreOptions(BuildContext context) {
    final simSlotService = ref.read(simSlotRuleServiceProvider);

    final importExportComponent =
        ImportExportServiceComponent<SimSlotRule, String>(
      importExportService: SimSlotRuleImportExportAdapter(simSlotService.importExportService),
      entityTypeName: AppLocalizations.of(context)!.simSlotRules,
      onEntitiesImported: (rules) async {
        for (final rule in rules) {
          await simSlotService.updateSimSlotRule(rule);
        }
        _loadRules();
      },
      getEntitiesToExport: () => simSlotService.getAllSimSlotRules(),
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
              showActionFilterDialog(context, (type) {
                setState(() => _selectedActionType = type);
                _loadRules();
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.label),
            title: Text(AppLocalizations.of(context)!.filterByLabel),
            onTap: () {
              Navigator.pop(context);
              showLabelFilterDialog(context, (labelId) {
                setState(() => _selectedLabelId = labelId);
                _loadRules();
              }, themeColor: Colors.amber);
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

  @override
  Widget build(BuildContext context) {

    
    return GenericListWithAdsPage<SimSlotRule>(
      title: '${AppLocalizations.of(context)!.simSlot} ${widget.simSlotIndex + 1} ${AppLocalizations.of(context)!.simSlotRuleManagement}',
      items: _filteredRules,
      itemBuilder: (context, rule) => _buildRuleCard(context, rule),
      adBuilder: () => GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
      adInterval: 3,
      emptyText: AppLocalizations.of(context).simRulesNotFound,
      emptyIcon: Icons.sim_card,
      themeColor: Colors.amber,
      isLoading: _isLoading,
      onRefresh: _loadRules,
      onAdd: () => _showAddRuleDialog(),
      onMoreOptions: () => _showMoreOptions(context),
      onMultiSelect: (selectedRules) {},
      getItemId: (rule) => rule.id,
      isMultiSelectMode: _isMultiSelectMode,
      selectedItemIds: _selectedRuleIds,
      onToggleMultiSelectMode: _toggleMultiSelectMode,
      onDeleteSelected: _deleteSelectedRules,
      onToggleItemSelection: _toggleRuleSelection,
      onSearchChanged: _onSearchChanged,
      searchHintText: AppLocalizations.of(context)!.searchByNameOrPhoneNumber,
      infoCard: _buildInfoCard(),
    );
  }

  Widget _buildRuleCard(BuildContext context, SimSlotRule rule) {
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
        SimSlotRuleEditDialog.showEdit(
          context,
          rule,
          onRuleUpdated: _loadRules,
          themeColor: Colors.amber,
        );
      },
      onDelete: () => _deleteRule(rule.id),
      // onToggleSelection: _toggleRuleSelection,
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
              AppLocalizations.of(context)!.simSlotRules,
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