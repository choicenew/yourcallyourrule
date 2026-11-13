import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/phone_rules/services/regex_service.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class RegexRulePage extends ConsumerWidget {
  const RegexRulePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final regexSvc = ref.watch(regexServiceProvider);

    return FutureBuilder<List<RegexRuleEntity>>(
      future: regexSvc.getAllRegexRules(),
      builder: (context, snapshot) {
        final rules = snapshot.data ?? [];
        return GenericListPage<RegexRuleEntity>(
          title: (l10n as dynamic)?.regexRulesTitle as String? ?? 'Regex Rules',
          items: rules,
          emptyText: l10n.noData,
          adInterval: 3,
          adBuilder: () => const AdsInlineBanner(),
          itemBuilder: (context, rule) => ListTile(
            title: Text(rule.name),
            subtitle: Text(rule.pattern),
          ),
          getItemId: (rule) => rule.id,
        );
      },
    );
  }
}
