import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_sim_slot_rules_protocol/pyro_phone_sim_slot_rules_protocol.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/common/dialogs/filter_dialogs.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_page.dart';
import 'package:yourcallyourrule/features/phone_rules/utils/rule_action_display_utils.dart';
import 'package:yourcallyourrule/features/phone_rules/widgets/rule_list_card.dart';
import 'package:yourcallyourrule/features/sim_slot_rules/providers/sim_slot_rule_page_provider.dart';
import 'package:yourcallyourrule/features/sim_slot_rules/widgets/sim_slot_rule_edit_dialog.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// SIM卡槽位规则管理页面 - 100% 对齐 elite-ui 的 GenericListWithAdsPage 规范
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
  final Set<String> _selectedRuleIds = {};
  bool _isMultiSelectMode = false;

  SimSlotRulePage get notifier => ref.read(simSlotRulePageProvider(widget.simSlotIndex).notifier);

  void _showAddRuleDialog() {
    SimSlotRuleEditDialog.showAdd(
      context,
      simSlotIndex: widget.simSlotIndex,
      onRuleUpdated: () => notifier.refresh(),
      themeColor: const Color(0xFFFF9500),
    );
  }

  void _showMoreOptions() {
    final l10n = AppLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.filter_list),
            title: Text(l10n.filterByAction),
            onTap: () {
              Navigator.pop(ctx);
              showActionFilterDialog(context, (type) => notifier.setActionFilter(type));
            },
          ),
          ListTile(
            leading: const Icon(Icons.label),
            title: Text(l10n.filterByLabel),
            onTap: () {
              Navigator.pop(ctx);
              showLabelFilterDialog(context, (labelId) => notifier.setLabelFilter(labelId), themeColor: const Color(0xFFFF9500));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, dynamic rule, SimSlotRulePageState pageState) {
    final ruleAction = RuleActionDisplayUtils.parseActionType(rule.actionType);

    return RuleListCard(
      id: rule.id,
      name: rule.name,
      phoneNumber: PhoneNumber(rule.phoneNumber),
      labelId: rule.labelId ?? '',
      avatar: null,
      isEnabled: rule.isEnabled,
      action: ruleAction,
      labelIdToTextMap: pageState.labelIdToTextMap,
      isMultiSelectMode: _isMultiSelectMode,
      isSelected: _selectedRuleIds.contains(rule.id),
      onToggleStatus: (ruleId, isEnabled) => notifier.toggleRuleStatus(ruleId, isEnabled),
      onEdit: () {
        final entity = rule is SimSlotRuleEntity
            ? rule
            : SimSlotRuleEntity(
                id: rule.id,
                name: rule.name,
                phoneNumber: rule.phoneNumber,
                simSlotIndex: widget.simSlotIndex,
                actionType: rule.actionType,
                priority: rule.priority,
                isEnabled: rule.isEnabled,
              );
        SimSlotRuleEditDialog.showEdit(
          context,
          entity,
          onRuleUpdated: () => notifier.refresh(),
          themeColor: const Color(0xFFFF9500),
        );
      },
      onDelete: () => notifier.deleteRule(rule.id),
      themeColor: const Color(0xFFFF9500),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final pageStateAsync = ref.watch(simSlotRulePageProvider(widget.simSlotIndex));

    return pageStateAsync.when(
      data: (pageState) => GenericListPage<dynamic>(
        title: '${l10n.simSlot} ${widget.simSlotIndex + 1} ${l10n.simSlotRuleManagement}',
        items: pageState.filteredRules,
        itemBuilder: (context, rule) => _buildItem(context, rule, pageState),
        adBuilder: () => const AdsInlineBanner(),
        adInterval: 3,
        emptyText: l10n.simRulesNotFound,
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
        searchHintText: l10n.searchByNameOrPhoneNumber,
        infoCard: Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.colorScheme.outlineVariant,
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
                    l10n.simSlotRules,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                l10n.simRuleInstructions,
                style: TextStyle(
                  fontSize: 13,
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
      loading: () => Scaffold(
        appBar: AppBar(title: Text('${l10n.simSlot} ${widget.simSlotIndex + 1}')),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, st) => Scaffold(
        appBar: AppBar(title: Text('${l10n.simSlot} ${widget.simSlotIndex + 1}')),
        body: Center(child: Text('Error: $e')),
      ),
    );
  }
}

