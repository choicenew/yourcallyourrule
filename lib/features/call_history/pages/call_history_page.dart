import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_call_history_protocol/pyro_phone_call_history_protocol.dart';
import 'package:pyro_phone_call_history_hub/pyro_phone_call_history_hub.dart';
import 'package:pyro_phone_call_history_ui/pyro_phone_call_history_ui.dart' as history_pkg_ui;
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_timeline_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class CallHistoryPage extends ConsumerWidget {
  const CallHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return FutureBuilder<List<CallLogEntry>>(
      future: CallHistoryControlCenter.instance.getAllLogs(),
      builder: (context, snapshot) {
        final historyLogs = snapshot.data ?? [];
        return GenericTimelinePage<CallLogEntry>(
          title: (l10n as dynamic)?.callHistoryTitle as String? ?? 'Call History',
          items: historyLogs,
          displayMode: ListDisplayMode.timeline,
          getItemTimestamp: (entry) => entry.timestamp != null
              ? DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)
              : null,
          emptyText: (l10n as dynamic)?.noCallHistoryFound as String? ?? 'No call history found',
          adInterval: 3,
          adBuilder: () => const AdsInlineBanner(),
          itemBuilder: (context, entry) => history_pkg_ui.PyroCallLogCardWidget(
            entry: entry,
            onTap: () {},
          ),
          getItemId: (entry) => entry.id,
        );
      },
    );
  }
}
