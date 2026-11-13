import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:pyro_phone_rules_ui/pyro_phone_rules_ui.dart' as rules_pkg_ui;
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/phone_rules/services/allowed_blocked_service.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class AllowedBlockedPage extends ConsumerWidget {
  const AllowedBlockedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final allowedBlockedSvc = ref.watch(allowedBlockedServiceProvider);

    return FutureBuilder<List<PhoneRuleEntity>>(
      future: allowedBlockedSvc.getAllAllowedRules(),
      builder: (context, snapshot) {
        final rules = snapshot.data ?? [];
        return GenericListPage<PhoneRuleEntity>(
          title: l10n.allowedBlockedRuleManagement,
          items: rules,
          emptyText: l10n.noData,
          adInterval: 3,
          adBuilder: () => const AdsInlineBanner(),
          itemBuilder: (context, rule) => rules_pkg_ui.PyroPhoneRuleCardWidget(
            rule: rule,
            onTap: () {},
          ),
          getItemId: (rule) => rule.id,
        );
      },
    );
  }
}
