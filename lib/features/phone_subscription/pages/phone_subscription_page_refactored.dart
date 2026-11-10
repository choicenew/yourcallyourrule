import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_subscription_protocol/pyro_phone_subscription_protocol.dart';
import 'package:pyro_phone_subscription_hub/pyro_phone_subscription_hub.dart';
import 'package:pyro_phone_subscription_ui/pyro_phone_subscription_ui.dart' as sub_pkg_ui;
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class PhoneSubscriptionPageRefactored extends ConsumerWidget {
  const PhoneSubscriptionPageRefactored({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final controlCenter = ref.watch(phoneRulesSubscriptionControlCenterProvider);

    return GenericListWithAdsPage<PhoneSubscriptionPayload>(
      title: l10n.subscription,
      items: const [],
      emptyText: l10n.noData,
      adInterval: 3,
      adBuilder: () => const AdsInlineBanner(),
      itemBuilder: (context, sub) => sub_pkg_ui.PyroPhoneSubscriptionCardWidget(
        payload: sub,
        onTap: () => controlCenter.dispatchPayload(sub),
      ),
      getItemId: (sub) => sub.payloadId,
    );
  }
}
