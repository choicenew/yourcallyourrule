import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:pyro_phone_rules_ui/pyro_phone_rules_ui.dart' as rules_pkg_ui;
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/common/dialogs/filter_dialogs.dart';
import 'package:yourcallyourrule/features/phone_rules/services/allowed_blocked_service.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

final allowedRulesListProvider = FutureProvider.autoDispose<List<PhoneRuleEntity>>((ref) async {
  final allowedBlockedSvc = ref.watch(allowedBlockedServiceProvider);
  return await allowedBlockedSvc.getAllAllowedRules();
});

class AllowedBlockedPage extends ConsumerStatefulWidget {
  const AllowedBlockedPage({super.key});

  @override
  ConsumerState<AllowedBlockedPage> createState() => _AllowedBlockedPageState();
}

class _AllowedBlockedPageState extends ConsumerState<AllowedBlockedPage> {
  String _searchKeyword = '';
  final Set<String> _selectedRuleIds = {};
  bool _isMultiSelectMode = false;
  RuleActionType? _selectedActionType;
  String? _selectedLabelIdFilter;

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
              showActionFilterDialog(context, (type) {
                setState(() => _selectedActionType = type);
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.label),
            title: Text(l10n.filterByLabel),
            onTap: () {
              Navigator.pop(ctx);
              showLabelFilterDialog(context, (labelId) {
                setState(() => _selectedLabelIdFilter = labelId);
              });
            },
          ),
        ],
      ),
    );
  }

  Future<void> _deleteSelectedRules() async {
    final service = ref.read(allowedBlockedServiceProvider);
    for (final id in _selectedRuleIds) {
      await service.removeRule(id);
    }
    setState(() {
      _selectedRuleIds.clear();
      _isMultiSelectMode = false;
    });
    ref.invalidate(allowedRulesListProvider);
  }

  void _showAddRuleDialog(BuildContext context) {
    final phoneController = TextEditingController();
    final nameController = TextEditingController();
    String? selectedLabelId;
    bool isAllowed = true;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(AppLocalizations.of(context).allowedBlockedRuleManagement),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).phoneNumber,
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).ruleName,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                PublicSelectLabel(
                  initialLabelId: selectedLabelId,
                  onLabelIdChanged: (labelId) {
                    selectedLabelId = labelId;
                  },
                ),
                const SizedBox(height: 12),
                SegmentedButton<bool>(
                  segments: [
                    ButtonSegment(value: true, label: Text(AppLocalizations.of(context).allow)),
                    ButtonSegment(value: false, label: Text(AppLocalizations.of(context).block)),
                  ],
                  selected: {isAllowed},
                  onSelectionChanged: (selected) {
                    setDialogState(() => isAllowed = selected.first);
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context).cancelButton),
            ),
            ElevatedButton(
              onPressed: () async {
                final phone = phoneController.text.trim();
                final name = nameController.text.trim();
                if (phone.isNotEmpty) {
                  final service = ref.read(allowedBlockedServiceProvider);
                  await service.addAllowedBlockedRule(
                    name.isNotEmpty ? name : phone,
                    PhoneNumber(phone),
                    isAllowed ? RuleAction.allow : RuleAction.block,
                  );
                  ref.invalidate(allowedRulesListProvider);
                  if (context.mounted) Navigator.pop(context);
                }
              },
              child: Text(AppLocalizations.of(context).add),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteRule(PhoneRuleEntity rule) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deleteRule),
        content: Text(l10n.confirmDeleteRuleMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancelButton),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(l10n.deleteButton),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final service = ref.read(allowedBlockedServiceProvider);
      await service.removeRule(rule.id);
      ref.invalidate(allowedRulesListProvider);
    }
  }

  Widget _buildInfoCard(BuildContext context, AppLocalizations l10n) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.15),
          width: 1.1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(
              Icons.verified_user_rounded,
              color: primaryColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.allowedBlockedRuleManagement,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.allowedBlockedRulesInfo,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final rulesAsync = ref.watch(allowedRulesListProvider);

    final rulesList = rulesAsync.value ?? [];
    final isLoading = rulesAsync.isLoading && rulesList.isEmpty;

    final filteredList = rulesList.where((rule) {
      if (_selectedActionType != null && rule.actionType != _selectedActionType?.name) {
        return false;
      }
      if (_selectedLabelIdFilter != null && rule.labelId != _selectedLabelIdFilter) {
        return false;
      }
      if (_searchKeyword.isNotEmpty) {
        final name = rule.name.toLowerCase();
        final phone = rule.phoneNumber;
        final keyword = _searchKeyword.toLowerCase();
        return name.contains(keyword) || phone.contains(keyword);
      }
      return true;
    }).toList();

    return GenericListPage<PhoneRuleEntity>(
      title: l10n.allowedBlockedRuleManagement,
      items: filteredList,
      isLoading: isLoading,
      headerContent: _buildInfoCard(context, l10n),
      onRefresh: () async => ref.invalidate(allowedRulesListProvider),
      onAdd: () => _showAddRuleDialog(context),
      onMoreOptions: _showMoreOptions,
      onSearchChanged: (kw) => setState(() => _searchKeyword = kw),
      searchHintText: l10n.search,
      emptyText: l10n.noData,
      emptyIcon: Icons.verified_user_outlined,
      adInterval: 3,
      adBuilder: () => const AdsInlineBanner(),
      isMultiSelectMode: _isMultiSelectMode,
      selectedItemIds: _selectedRuleIds,
      onToggleMultiSelectMode: () => setState(() {
        _isMultiSelectMode = !_isMultiSelectMode;
        if (!_isMultiSelectMode) {
          _selectedRuleIds.clear();
        }
      }),
      onDeleteSelected: _deleteSelectedRules,
      onToggleItemSelection: (ruleId) => setState(() {
        if (_selectedRuleIds.contains(ruleId)) {
          _selectedRuleIds.remove(ruleId);
        } else {
          _selectedRuleIds.add(ruleId);
        }
      }),
      itemBuilder: (context, rule) => rules_pkg_ui.PyroPhoneRuleCardWidget(
        rule: rule,
        onTap: () {
          if (_isMultiSelectMode) {
            setState(() {
              if (_selectedRuleIds.contains(rule.id)) {
                _selectedRuleIds.remove(rule.id);
              } else {
                _selectedRuleIds.add(rule.id);
              }
            });
          } else {
            _deleteRule(rule);
          }
        },
      ),
      getItemId: (rule) => rule.id,
    );
  }
}

/// 兼容别名：100% 对齐 elite-ui 路由与命名规范
typedef AllowedBlockedPageWithAds = AllowedBlockedPage;
