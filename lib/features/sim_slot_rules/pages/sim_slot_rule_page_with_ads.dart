import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/rule/sim_slot_rule.dart';
import 'package:yourcallyourrule/core/provider/providers/predefined_label_service_provider.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/services/import_export_service_component.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';

import 'package:yourcallyourrule/features/common/dialogs/filter_dialogs.dart';
import 'package:yourcallyourrule/features/rules/widgets/rule_list_card.dart';
import 'package:yourcallyourrule/features/sim_slot_rules/providers/sim_slot_rule_page_provider.dart';
import 'package:yourcallyourrule/features/sim_slot_rules/services/sim_slot_rule_import_export_adapter.dart';
import 'package:yourcallyourrule/features/sim_slot_rules/services/sim_slot_rule_service.dart';
import 'package:yourcallyourrule/features/sim_slot_rules/widgets/sim_slot_rule_edit_dialog.dart';
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

  // [修正]: 恢复被我错误删除的 createState 方法。这是 StatefulWidget 的核心。
  @override
  ConsumerState<SimSlotRulePageWithAds> createState() => _SimSlotRulePageWithAdsState();
}

// [重构]: 将 _MultiSelectWrapper 的逻辑合并回页面的 State 类，简化结构。
class _SimSlotRulePageWithAdsState extends ConsumerState<SimSlotRulePageWithAds> {
  // [注释]: 像多选这样的纯UI状态，适合保留在 State 中。
  Set<String> _selectedRuleIds = {};
  bool _isMultiSelectMode = false;

  // [注释]: 获取 Notifier 的便捷方法
  SimSlotRulePage get notifier => ref.read(simSlotRulePageProvider(widget.simSlotIndex).notifier);

  void _showAddRuleDialog() {
    SimSlotRuleEditDialog.showAdd(
      context,
     
      onRuleUpdated: () => notifier.refresh(),
      themeColor: Colors.amber,
    );
  }

  void _showMoreOptions() {
    final simSlotService = ref.read(simSlotRuleServiceProvider);
    final importExportComponent = ImportExportServiceComponent<SimSlotRule, String>(
      importExportService: SimSlotRuleImportExportAdapter(simSlotService.importExportService),
      entityTypeName: AppLocalizations.of(context)!.simSlotRules,
      onEntitiesImported: (rules) async {
        await Future.wait(rules.map((rule) => simSlotService.updateSimSlotRule(rule)));
        notifier.refresh();
      },
      getEntitiesToExport: () => simSlotService.getAllSimSlotRules(),
    );

    showModalBottomSheet(
      context: context,
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.filter_list),
            title: Text(AppLocalizations.of(context)!.filterByAction),
            onTap: () {
              Navigator.pop(ctx);
              showActionFilterDialog(context, (type) => notifier.setActionFilter(type));
            },
          ),
          ListTile(
            leading: const Icon(Icons.label),
            title: Text(AppLocalizations.of(context)!.filterByLabel),
            onTap: () {
              Navigator.pop(ctx);
              showLabelFilterDialog(context, (labelId) => notifier.setLabelFilter(labelId), themeColor: Colors.amber);
            },
          ),
          ListTile(
            leading: const Icon(Icons.import_export),
            title: Text(AppLocalizations.of(context)!.importExport),
            onTap: () {
              Navigator.pop(ctx);
              importExportComponent.showImportExportDialog(context);
            },
          ),
        ],
      ),
    );
  }

  // [注释]: 构建列表项的独立子函数
  Widget _buildItem(BuildContext context, SimSlotRule rule, SimSlotRulePageState pageState) {
    return RuleListCard(
      id: rule.id,
      name: rule.name,
      phoneNumber: rule.phoneNumber,
      labelId: rule.labelId,
      avatar: rule.avatar,
      isEnabled: rule.isEnabled,
      action: rule.action,
      labelIdToTextMap: pageState.labelIdToTextMap,
      isMultiSelectMode: _isMultiSelectMode,
      isSelected: _selectedRuleIds.contains(rule.id),
      onToggleStatus: (ruleId, isEnabled) => notifier.toggleRuleStatus(ruleId, isEnabled),
      onEdit: () => SimSlotRuleEditDialog.showEdit(context, rule, onRuleUpdated: () => notifier.refresh(), themeColor: Colors.amber),
      onDelete: () => notifier.deleteRule(rule.id),
      themeColor: Colors.amber,
    );
  }

  @override
  Widget build(BuildContext context) {
    // [重构]: 监听 Notifier 的状态。
    final pageStateAsync = ref.watch(simSlotRulePageProvider(widget.simSlotIndex));

    return pageStateAsync.when(
      data: (pageState) => GenericListWithAdsPage<SimSlotRule>(
        title: '${AppLocalizations.of(context)!.simSlot} ${widget.simSlotIndex + 1} ${AppLocalizations.of(context)!.simSlotRuleManagement}',
        items: pageState.filteredRules,
        itemBuilder: (context, rule) => _buildItem(context, rule, pageState),
        adBuilder: () => GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
        adInterval: 3,
        emptyText: AppLocalizations.of(context)!.simRulesNotFound,
        emptyIcon: Icons.sim_card_rounded,
        themeColor: const Color(0xFFFF9500),
        isLoading: pageStateAsync.isReloading,
        onRefresh: () => notifier.refresh(),
        onAdd: _showAddRuleDialog,
        onMoreOptions: _showMoreOptions,
        getItemId: (rule) => rule.id,
        isMultiSelectMode: _isMultiSelectMode,
        selectedItemIds: _selectedRuleIds,
        onToggleMultiSelectMode: () => setState(() {
          _isMultiSelectMode = !_isMultiSelectMode;
          if (!_isMultiSelectMode) {
            _selectedRuleIds.clear();
          }
        }),
        onDeleteSelected: () async {
          await notifier.deleteSelectedRules(_selectedRuleIds);
          setState(() {
            _selectedRuleIds.clear();
            _isMultiSelectMode = false;
          });
        },
        onToggleItemSelection: (ruleId) => setState(() {
          if (_selectedRuleIds.contains(ruleId)) {
            _selectedRuleIds.remove(ruleId);
          } else {
            _selectedRuleIds.add(ruleId);
          }
        }),
        onSearchChanged: (keyword) => notifier.setSearchKeyword(keyword),
        searchHintText: AppLocalizations.of(context)!.searchByNameOrPhoneNumber,
        infoCard: Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFEDE8DF),
              width: 1.1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF9500).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.sim_card_rounded, color: Color(0xFFFF9500), size: 20),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    AppLocalizations.of(context)!.simSlotRules,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black87),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.simRuleInstructions,
                style: const TextStyle(fontSize: 13, color: Colors.black54, height: 1.4),
              ),
            ],
          ),
        ),
      ),
      loading: () => Scaffold(
        appBar: AppBar(title: Text('${AppLocalizations.of(context)!.simSlot} ${widget.simSlotIndex + 1}')),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, st) => Scaffold(
        appBar: AppBar(title: Text('${AppLocalizations.of(context)!.simSlot} ${widget.simSlotIndex + 1}')),
        body: Center(child: Text('Error: $e')),
      ),
    );
  }
}