import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:pyro_phone_rules_ui/pyro_phone_rules_ui.dart' as rules_pkg_ui;
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/common/dialogs/filter_dialogs.dart';
import 'package:yourcallyourrule/features/phone_rules/services/rule_management_service.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

final allRulesListProvider = FutureProvider.autoDispose<List<PhoneRuleEntity>>((ref) async {
  final ruleSvc = ref.watch(ruleManagementServiceProvider);
  return await ruleSvc.getAllRules();
});

class RuleManagementPage extends ConsumerStatefulWidget {
  const RuleManagementPage({super.key});

  @override
  ConsumerState<RuleManagementPage> createState() => _RuleManagementPageState();
}

class _RuleManagementPageState extends ConsumerState<RuleManagementPage> {
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
    final ruleSvc = ref.read(ruleManagementServiceProvider);
    for (final id in _selectedRuleIds) {
      await ruleSvc.removeRule(id);
    }
    setState(() {
      _selectedRuleIds.clear();
      _isMultiSelectMode = false;
    });
    ref.invalidate(allRulesListProvider);
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
      final ruleSvc = ref.read(ruleManagementServiceProvider);
      await ruleSvc.removeRule(rule.id);
      ref.invalidate(allRulesListProvider);
    }
  }

  void _showEditRuleDialog(BuildContext context, PhoneRuleEntity rule) {
    final phoneController = TextEditingController(text: rule.phoneNumber);
    final nameController = TextEditingController(text: rule.name);
    String? selectedLabelId = rule.labelId;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).editRule),
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
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteRule(rule);
            },
            style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
            child: Text(AppLocalizations.of(context).delete),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context).cancelButton),
          ),
          ElevatedButton(
            onPressed: () async {
              final phone = phoneController.text.trim();
              final name = nameController.text.trim();
              if (phone.isNotEmpty) {
                final ruleSvc = ref.read(ruleManagementServiceProvider);
                final updated = rule.copyWith(
                  name: name.isNotEmpty ? name : phone,
                  phoneNumber: phone,
                  labelId: selectedLabelId ?? '',
                );
                await ruleSvc.updatePhoneNumberRule(updated);
                ref.invalidate(allRulesListProvider);
                if (context.mounted) Navigator.pop(context);
              }
            },
            child: Text(AppLocalizations.of(context).save),
          ),
        ],
      ),
    );
  }

  void _showAddRuleDialog(BuildContext context) {
    final phoneController = TextEditingController();
    final nameController = TextEditingController();
    String? selectedLabelId;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).ruleManagement),
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
                final ruleSvc = ref.read(ruleManagementServiceProvider);
                await ruleSvc.addPhoneRule(
                  name.isNotEmpty ? name : phone,
                  PhoneNumber(phone),
                  RuleAction.allow,
                );
                ref.invalidate(allRulesListProvider);
                if (context.mounted) Navigator.pop(context);
              }
            },
            child: Text(AppLocalizations.of(context).add),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final rulesAsync = ref.watch(allRulesListProvider);

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
      title: l10n.ruleManagement,
      items: filteredList,
      isLoading: isLoading,
      onRefresh: () async => ref.invalidate(allRulesListProvider),
      onAdd: () => _showAddRuleDialog(context),
      onMoreOptions: _showMoreOptions,
      onSearchChanged: (kw) => setState(() => _searchKeyword = kw),
      searchHintText: l10n.search,
      emptyText: l10n.noData,
      emptyIcon: Icons.shield_outlined,
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
            _showEditRuleDialog(context, rule);
          }
        },
      ),
      getItemId: (rule) => rule.id,
    );
  }
}
