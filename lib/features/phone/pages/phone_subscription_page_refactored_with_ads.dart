import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_subscription_protocol/pyro_phone_subscription_protocol.dart';
import 'package:pyro_phone_subscription_hub/pyro_phone_subscription_hub.dart';
import 'package:pyro_phone_subscription_ui/pyro_phone_subscription_ui.dart' as sub_pkg_ui;
import 'package:yourcallyourrule/ads/ad_widgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class PhoneSubscriptionPageRefactoredWithAds extends ConsumerWidget {
  const PhoneSubscriptionPageRefactoredWithAds({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final subscriptions = ref.watch(phoneSubscriptionControlCenterProvider).subscriptions;

    return GenericListWithAdsPage<PhoneSubscriptionPayload>(
      title: l10n.phoneSubscriptionTitle,
      items: subscriptions,
      emptyText: l10n.noSubscriptionsFound,
      adInterval: 3,
      adBuilder: () => const InlineAdaptiveAd(),
      itemBuilder: (context, sub) => sub_pkg_ui.PyroPhoneSubscriptionCardWidget(
        payload: sub,
        onTap: () => ref.read(phoneSubscriptionControlCenterProvider).syncSubscription(sub),
      ),
      getItemId: (sub) => sub.payloadId,
      onRefresh: () => ref.read(phoneSubscriptionControlCenterProvider).refreshAll(),
    );
  }
}
