import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_call_history_protocol/pyro_phone_call_history_protocol.dart';
import 'package:pyro_phone_call_history_hub/pyro_phone_call_history_hub.dart';
import 'package:pyro_phone_call_history_ui/pyro_phone_call_history_ui.dart' as history_pkg_ui;
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_timeline_with_ads_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class CallHistoryPage extends ConsumerWidget {
  const CallHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final historyLogs = ref.watch(callHistoryControlCenterProvider).logs;

    return GenericTimelineListWithAdsPage<CallLogEntry>(
      title: l10n.callHistoryTitle,
      items: historyLogs,
      displayMode: ListDisplayMode.timeline,
      getItemTimestamp: (entry) => entry.timestamp != null
          ? DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)
          : null,
      emptyText: l10n.noCallHistoryFound,
      adInterval: 3,
      adBuilder: () => const InlineAdaptiveAd(),
      itemBuilder: (context, entry) => history_pkg_ui.PyroCallLogCardWidget(
        entry: entry,
        onTap: () => ref.read(callHistoryControlCenterProvider).showDetail(entry),
      ),
      getItemId: (entry) => entry.id,
      onSearchChanged: (query) => ref.read(callHistoryControlCenterProvider).searchLogs(query),
      onDeleteSelected: () => ref.read(callHistoryControlCenterProvider).deleteSelected(),
    );
  }
}
