import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:pyro_phone_rules_hub/pyro_phone_rules_hub.dart';
import 'package:pyro_phone_rules_ui/pyro_phone_rules_ui.dart' as rules_pkg_ui;
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 使用 GenericListWithAdsPage 挂载 Package 视图的正则规则管理页面
class RegexRulePage extends ConsumerWidget {
  const RegexRulePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final rules = ref.watch(phoneRulesControlCenterProvider).regexRules;

    return GenericListWithAdsPage<RegexRuleEntity>(
      title: l10n.regexRuleManagement,
      items: rules,
      emptyText: l10n.noRulesFound,
      adInterval: 3,
      adBuilder: () => const AdsInlineBanner(),
      itemBuilder: (context, rule) => rules_pkg_ui.PyroPhoneRuleCardWidget(
        rule: PhoneRuleEntity(
          id: rule.id,
          name: rule.name,
          phoneNumber: rule.pattern,
          actionType: rule.actionType,
          priority: rule.priority,
          isEnabled: rule.isEnabled,
        ),
        onTap: () => ref.read(phoneRulesControlCenterProvider).editRegexRule(rule),
      ),
      getItemId: (rule) => rule.id,
      onAdd: () => ref.read(phoneRulesControlCenterProvider).openAddDialog(context, ruleType: 'regex'),
      onSearchChanged: (query) => ref.read(phoneRulesControlCenterProvider).searchRegexRules(query),
      onDeleteSelected: () => ref.read(phoneRulesControlCenterProvider).deleteSelected(),
    );
  }
}
