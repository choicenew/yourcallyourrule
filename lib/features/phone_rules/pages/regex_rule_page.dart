import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/common/router/app_router.dart';
import 'package:yourcallyourrule/features/common/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_page.dart';
import 'package:yourcallyourrule/features/phone_rules/services/regex_service.dart';
import 'package:yourcallyourrule/features/phone_rules/utils/rule_action_display_utils.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

final regexRulesListProvider = FutureProvider.autoDispose<List<RegexRuleEntity>>((ref) async {
  final service = ref.watch(regexServiceProvider);
  return await service.getAllRegexRules();
});

/// 100% 国际化、对齐 elite-ui 完整架构的正则规则管理页面 (RegexRulePage)
class RegexRulePage extends ConsumerStatefulWidget {
  const RegexRulePage({super.key});

  @override
  ConsumerState<RegexRulePage> createState() => _RegexRulePageState();
}

class _RegexRulePageState extends ConsumerState<RegexRulePage> {
  String _searchKeyword = '';
  final Set<String> _selectedRuleIds = {};
  bool _isMultiSelectMode = false;

  void _onSearchChanged(String keyword) {
    setState(() {
      _searchKeyword = keyword;
    });
  }

  Future<void> _deleteSelectedRules() async {
    final service = ref.read(regexServiceProvider);
    for (final id in _selectedRuleIds) {
      await service.removeRegexRule(id);
    }
    setState(() {
      _selectedRuleIds.clear();
      _isMultiSelectMode = false;
    });
    ref.invalidate(regexRulesListProvider);
  }

  Future<void> _showAddOrEditRegexDialog({RegexRuleEntity? rule}) async {
    final l10n = AppLocalizations.of(context);
    final nameController = TextEditingController(text: rule?.name ?? '');
    final patternController = TextEditingController(text: rule?.pattern ?? '');
    final isEditing = rule != null;
    RuleAction selectedAction = rule != null
        ? RuleActionDisplayUtils.parseActionType(rule.actionType)
        : RuleAction.block;

    await showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(isEditing ? l10n.editRule : l10n.addRegexRule),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: l10n.ruleName,
                    hintText: l10n.enterRuleNameHint,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: patternController,
                  decoration: InputDecoration(
                    labelText: l10n.regexPattern,
                    hintText: '^1[3-9]\\d{9}\$',
                    border: const OutlineInputBorder(),
                  ),
                  style: const TextStyle(fontFamily: 'monospace'),
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<RuleActionType>(
                  value: selectedAction.type,
                  decoration: InputDecoration(
                    labelText: l10n.ruleAction,
                    border: const OutlineInputBorder(),
                  ),
                  items: RuleActionType.values.map((type) {
                    return DropdownMenuItem<RuleActionType>(
                      value: type,
                      child: Text(RuleActionDisplayUtils.getActionTypeName(context, type)),
                    );
                  }).toList(),
                  onChanged: (newType) {
                    if (newType != null) {
                      setDialogState(() {
                        selectedAction = RuleAction(type: newType);
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.cancelButton),
            ),
            FilledButton(
              onPressed: () async {
                final name = nameController.text.trim();
                final pattern = patternController.text.trim();
                if (name.isEmpty || pattern.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.regexRuleNamePatternRequired)),
                  );
                  return;
                }

                final service = ref.read(regexServiceProvider);
                if (!service.isValidRegex(pattern)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.invalidRegexPattern),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                try {
                  if (isEditing) {
                    final updatedRule = rule.copyWith(
                      name: name,
                      pattern: pattern,
                      actionType: selectedAction.type.name,
                    );
                    await service.updateRegexRule(updatedRule);
                  } else {
                    await service.addRegexRule(name, pattern, selectedAction);
                  }
                  ref.invalidate(regexRulesListProvider);
                  if (mounted) Navigator.pop(ctx);
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${isEditing ? l10n.ruleUpdateFailed(e.toString()) : l10n.regexRuleAddFailed(e.toString())}: $e')),
                    );
                  }
                }
              },
              child: Text(isEditing ? l10n.save : l10n.add),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteRule(String ruleId) async {
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
      final service = ref.read(regexServiceProvider);
      await service.removeRegexRule(ruleId);
      ref.invalidate(regexRulesListProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.deleteSuccess)),
        );
      }
    }
  }

  Future<void> _toggleRule(RegexRuleEntity rule, bool enabled) async {
    final service = ref.read(regexServiceProvider);
    final updated = rule.copyWith(isEnabled: enabled);
    await service.updateRegexRule(updated);
    ref.invalidate(regexRulesListProvider);
  }

  void _showMoreOptions() {
    final l10n = AppLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.science_outlined),
              title: Text(l10n.regexTesterTitle),
              onTap: () {
                Navigator.pop(ctx);
                context.pushNamed(AppRouter.regexTest);
              },
            ),
          ],
        ),
      ),
    );
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
              Icons.code_rounded,
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
                  l10n.regexRuleManagement,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.regexRulesInfo,
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

  Widget _buildRuleCard(BuildContext context, RegexRuleEntity rule, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final action = RuleActionDisplayUtils.parseActionType(rule.actionType);
    final actionText = RuleActionDisplayUtils.getActionTypeName(context, action.type);
    final actionColor = RuleActionDisplayUtils.getActionTypeColor(action.type);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showAddOrEditRegexDialog(rule: rule),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: actionColor.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.code_rounded, color: actionColor, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          rule.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          rule.pattern,
                          style: TextStyle(
                            fontSize: 13,
                            color: colorScheme.onSurfaceVariant,
                            fontFamily: 'monospace',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Switch.adaptive(
                    value: rule.isEnabled,
                    activeTrackColor: colorScheme.primary,
                    onChanged: (val) => _toggleRule(rule, val),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: actionColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      actionText,
                      style: TextStyle(
                        fontSize: 11,
                        color: actionColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(Icons.delete_outline_rounded, size: 20, color: colorScheme.error),
                    onPressed: () => _deleteRule(rule.id),
                    tooltip: l10n.deleteButton,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final rulesAsync = ref.watch(regexRulesListProvider);

    return rulesAsync.when(
      data: (rules) {
        final filteredRules = _searchKeyword.isEmpty
            ? rules
            : rules.where((r) {
                final name = r.name.toLowerCase();
                final pattern = r.pattern.toLowerCase();
                final kw = _searchKeyword.toLowerCase();
                return name.contains(kw) || pattern.contains(kw);
              }).toList();

        return GenericListPage<RegexRuleEntity>(
          title: l10n.regexRuleManagement,
          items: filteredRules,
          isLoading: false,
          headerContent: _buildInfoCard(context, l10n),
          onAdd: () => _showAddOrEditRegexDialog(),
          onRefresh: () async {
            ref.invalidate(regexRulesListProvider);
          },
          onSearchChanged: _onSearchChanged,
          searchHintText: l10n.searchRegexRulesHint,
          emptyText: l10n.noRegexRules,
          emptyIcon: Icons.code_rounded,
          adInterval: 3,
          adBuilder: () => const AdsInlineBanner(),
          onMoreOptions: _showMoreOptions,
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
          itemBuilder: (context, rule) => _buildRuleCard(context, rule, l10n),
          getItemId: (rule) => rule.id,
        );
      },
      loading: () => Scaffold(
        appBar: AppBar(title: Text(l10n.regexRuleManagement)),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (err, st) => Scaffold(
        appBar: AppBar(title: Text(l10n.regexRuleManagement)),
        body: Center(child: Text('Error: $err')),
      ),
    );
  }
}

/// 兼容别名：100% 对齐 elite-ui 路由与命名规范
typedef RegexRulePageWithAds = RegexRulePage;
