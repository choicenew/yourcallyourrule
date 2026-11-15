import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_subscription_protocol/pyro_phone_subscription_protocol.dart';
import 'package:pyro_phone_subscription_hub/pyro_phone_subscription_hub.dart';
import 'package:pyro_phone_subscription_ui/pyro_phone_subscription_ui.dart' as sub_pkg_ui;
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/features/phone_subscription/services/phone_subscription_service.dart';

final phoneSubscriptionsListProvider = FutureProvider.autoDispose<List<PhoneSubscriptionPayload>>((ref) async {
  final service = ref.watch(phoneSubscriptionServiceProvider);
  return await service.getAll();
});

class PhoneSubscriptionPageRefactored extends ConsumerWidget {
  const PhoneSubscriptionPageRefactored({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final subsAsync = ref.watch(phoneSubscriptionsListProvider);

    return subsAsync.when(
      data: (subscriptions) => GenericListPage<PhoneSubscriptionPayload>(
        title: l10n.phoneSubscription,
        items: subscriptions,
        isLoading: false,
        onRefresh: () async {
          ref.invalidate(phoneSubscriptionsListProvider);
        },
        emptyText: l10n.noSubscriptions,
        emptyIcon: Icons.rss_feed_rounded,
        adInterval: 3,
        adBuilder: () => const AdsInlineBanner(),
        itemBuilder: (context, sub) => sub_pkg_ui.PyroPhoneSubscriptionCardWidget(
          payload: sub,
          onTap: () => PhoneRulesSubscriptionControlCenter.instance.dispatchPayload(sub),
        ),
        getItemId: (sub) => sub.payloadId,
      ),
      loading: () => Scaffold(
        appBar: AppBar(title: Text(l10n.phoneSubscription)),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (err, st) => Scaffold(
        appBar: AppBar(title: Text(l10n.phoneSubscription)),
        body: Center(child: Text('Error: $err')),
      ),
    );
  }
}
