import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_subscription_protocol/pyro_phone_subscription_protocol.dart';
import 'package:pyro_phone_subscription_hub/pyro_phone_subscription_hub.dart';
import 'package:pyro_phone_subscription_ui/pyro_phone_subscription_ui.dart' as sub_pkg_ui;
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

import 'package:yourcallyourrule/features/phone_subscription/services/phone_subscription_service.dart';

class PhoneSubscriptionPageRefactored extends ConsumerStatefulWidget {
  const PhoneSubscriptionPageRefactored({super.key});

  @override
  ConsumerState<PhoneSubscriptionPageRefactored> createState() => _PhoneSubscriptionPageRefactoredState();
}

class _PhoneSubscriptionPageRefactoredState extends ConsumerState<PhoneSubscriptionPageRefactored> {
  List<PhoneSubscriptionPayload> _subscriptions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSubscriptions();
  }

  Future<void> _loadSubscriptions() async {
    setState(() => _isLoading = true);
    try {
      final service = ref.read(phoneSubscriptionServiceProvider);
      final list = await service.getAll();
      if (mounted) {
        setState(() {
          _subscriptions = list;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return GenericListPage<PhoneSubscriptionPayload>(
      title: l10n.phoneSubscription,
      items: _subscriptions,
      isLoading: _isLoading,
      onRefresh: _loadSubscriptions,
      emptyText: l10n.noSubscriptions,
      emptyIcon: Icons.rss_feed_rounded,
      adInterval: 3,
      adBuilder: () => const AdsInlineBanner(),
      itemBuilder: (context, sub) => sub_pkg_ui.PyroPhoneSubscriptionCardWidget(
        payload: sub,
        onTap: () => PhoneRulesSubscriptionControlCenter.instance.dispatchPayload(sub),
      ),
      getItemId: (sub) => sub.payloadId,
    );
  }
}
