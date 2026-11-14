import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:pyro_phone_rules_ui/pyro_phone_rules_ui.dart' as rules_pkg_ui;
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/phone_rules/services/rule_management_service.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class RuleManagementPage extends ConsumerWidget {
  const RuleManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final ruleSvc = ref.watch(ruleManagementServiceProvider);

    return FutureBuilder<List<PhoneRuleEntity>>(
      future: ruleSvc.getAllRules(),
      builder: (context, snapshot) {
        final rules = snapshot.data ?? [];
        return GenericListPage<PhoneRuleEntity>(
          title: l10n.ruleManagement,
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
