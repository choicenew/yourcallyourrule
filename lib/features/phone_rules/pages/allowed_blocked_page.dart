import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:pyro_phone_rules_ui/pyro_phone_rules_ui.dart' as rules_pkg_ui;
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
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
                  segments: const [
                    ButtonSegment(value: true, label: Text('Allow')),
                    ButtonSegment(value: false, label: Text('Block')),
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final rulesAsync = ref.watch(allowedRulesListProvider);

    final rulesList = rulesAsync.value ?? [];
    final isLoading = rulesAsync.isLoading && rulesList.isEmpty;

    final filteredList = _searchKeyword.isEmpty
        ? rulesList
        : rulesList.where((rule) {
            final name = rule.name.toLowerCase();
            final phone = rule.phoneNumber;
            final keyword = _searchKeyword.toLowerCase();
            return name.contains(keyword) || phone.contains(keyword);
          }).toList();

    return GenericListPage<PhoneRuleEntity>(
      title: l10n.allowedBlockedRuleManagement,
      items: filteredList,
      isLoading: isLoading,
      onRefresh: () async => ref.invalidate(allowedRulesListProvider),
      onAdd: () => _showAddRuleDialog(context),
      onSearchChanged: (kw) => setState(() => _searchKeyword = kw),
      searchHintText: l10n.search,
      emptyText: l10n.noData,
      emptyIcon: Icons.verified_user_outlined,
      adInterval: 3,
      adBuilder: () => const AdsInlineBanner(),
      itemBuilder: (context, rule) => rules_pkg_ui.PyroPhoneRuleCardWidget(
        rule: rule,
        onTap: () {},
      ),
      getItemId: (rule) => rule.id,
    );
  }
}
