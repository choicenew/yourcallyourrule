import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_call_statistic_protocol/pyro_phone_call_statistic_protocol.dart';
import 'package:pyro_phone_call_statistic_hub/pyro_phone_call_statistic_hub.dart';
import 'package:pyro_phone_call_statistic_ui/pyro_phone_call_statistic_ui.dart' as stat_pkg_ui;
import 'package:yourcallyourrule/ads/ad_widgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class BlockedCallsPage extends ConsumerWidget {
  const BlockedCallsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final statData = ref.watch(phoneCallStatisticControlCenterProvider).statisticData;

    return GenericListWithAdsPage<PhoneCallStatisticData>(
      title: l10n.blockedCallsTitle,
      items: [statData],
      emptyText: l10n.noBlockedCallsFound,
      adInterval: 3,
      adBuilder: () => const InlineAdaptiveAd(),
      itemBuilder: (context, data) => stat_pkg_ui.PyroPhoneCallStatisticCardWidget(
        data: data,
        onTap: () => ref.read(phoneCallStatisticControlCenterProvider).refreshStatistics(),
      ),
      getItemId: (data) => data.blockedCalls.toString(),
      onRefresh: () => ref.read(phoneCallStatisticControlCenterProvider).refreshStatistics(),
    );
  }
}
