import 'package:material_ui/material_ui.dart';
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
        final isLoading = snapshot.connectionState == ConnectionState.waiting;
        final rules = snapshot.data ?? [];
        return GenericListPage<RegexRuleEntity>(
          title: l10n.regexRules,
          items: rules,
          isLoading: isLoading,
          emptyText: l10n.noRegexRules,
          emptyIcon: Icons.rule_folder_outlined,
          adInterval: 3,
          adBuilder: () => const AdsInlineBanner(),
          itemBuilder: (context, rule) => ListTile(
            title: Text(rule.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(rule.pattern),
            leading: const Icon(Icons.code_rounded),
          ),
          getItemId: (rule) => rule.id,
        );
      },
    );
  }
}
