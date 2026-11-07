import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:pyro_phone_rules_hub/pyro_phone_rules_hub.dart';
import 'package:pyro_phone_rules_ui/pyro_phone_rules_ui.dart' as rules_pkg_ui;
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class AllowedBlockedPage extends ConsumerWidget {
  const AllowedBlockedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final rules = ref.watch(phoneRulesControlCenterProvider).rules;

    return GenericListWithAdsPage<PhoneRuleEntity>(
      title: l10n.allowedBlockedTitle,
      items: rules,
      emptyText: l10n.noRulesFound,
      adInterval: 3,
      adBuilder: () => const InlineAdaptiveAd(),
      itemBuilder: (context, rule) => rules_pkg_ui.PyroPhoneRuleCardWidget(
        rule: rule,
        onTap: () => ref.read(phoneRulesControlCenterProvider).editRule(rule),
      ),
      getItemId: (rule) => rule.id,
      onAdd: () => ref.read(phoneRulesControlCenterProvider).openAddDialog(context),
      onSearchChanged: (query) => ref.read(phoneRulesControlCenterProvider).search(query),
      onDeleteSelected: () => ref.read(phoneRulesControlCenterProvider).deleteSelected(),
    );
  }
}
