import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_call_statistic_protocol/pyro_phone_call_statistic_protocol.dart';
import 'package:pyro_phone_call_statistic_hub/pyro_phone_call_statistic_hub.dart';
import 'package:pyro_phone_call_statistic_ui/pyro_phone_call_statistic_ui.dart' as stat_pkg_ui;
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class BlockedCallsPage extends ConsumerWidget {
  const BlockedCallsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return FutureBuilder<PhoneCallStatisticData>(
      future: PhoneCallStatisticControlCenter.instance.getStatistics(),
      builder: (context, snapshot) {
        final statData = snapshot.data ?? const PhoneCallStatisticData();
        return GenericListPage<PhoneCallStatisticData>(
          title: l10n.blockedCallsTitle,
          items: [statData],
          emptyText: l10n.noData,
          adInterval: 3,
          adBuilder: () => const AdsInlineBanner(),
          itemBuilder: (context, data) => stat_pkg_ui.PyroPhoneCallStatisticCardWidget(
            data: data,
            onTap: () {},
          ),
          getItemId: (data) => data.blockedCalls.toString(),
          onRefresh: () async {},
        );
      },
    );
  }
}
