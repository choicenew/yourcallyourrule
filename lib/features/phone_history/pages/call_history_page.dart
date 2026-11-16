import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_call_history_protocol/pyro_phone_call_history_protocol.dart';
import 'package:pyro_phone_call_history_hub/pyro_phone_call_history_hub.dart';
import 'package:pyro_phone_call_history_ui/pyro_phone_call_history_ui.dart' as history_pkg_ui;
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_timeline_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

final callLogsStreamProvider = StreamProvider.autoDispose<List<CallLogEntry>>((ref) async* {
  final initial = await CallHistoryControlCenter.instance.getAllLogs();
  yield initial;
});

/// 真实包裹 GenericTimelinePage 时间线框架与广告流的 CallHistoryPage
class CallHistoryPage extends ConsumerStatefulWidget {
  const CallHistoryPage({super.key});

  @override
  ConsumerState<CallHistoryPage> createState() => _CallHistoryPageState();
}

class _CallHistoryPageState extends ConsumerState<CallHistoryPage> {
  String _searchKeyword = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final historyLogsAsync = ref.watch(callLogsStreamProvider);

    final historyLogs = historyLogsAsync.value ?? [];
    final isLoading = historyLogsAsync.isLoading && historyLogs.isEmpty;

    final filteredLogs = _searchKeyword.isEmpty
        ? historyLogs
        : historyLogs.where((log) {
            final phone = log.phoneNumber;
            final name = (log.name ?? '').toLowerCase();
            final keyword = _searchKeyword.toLowerCase();
            return phone.contains(keyword) || name.contains(keyword);
          }).toList();

    return GenericTimelinePage<CallLogEntry>(
      title: l10n.callHistory,
      items: filteredLogs,
      isLoading: isLoading,
      onRefresh: () async => ref.refresh(callLogsStreamProvider),
      onSearchChanged: (keyword) {
        setState(() {
          _searchKeyword = keyword;
        });
      },
      searchHintText: l10n.search,
      displayMode: ListDisplayMode.timeline,
      getItemTimestamp: (entry) => entry.timestamp != null
          ? DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)
          : DateTime.now(),
      emptyText: l10n.noCallRecords,
      emptyIcon: Icons.phone_missed_rounded,
      adInterval: 3,
      adBuilder: () => const AdsInlineBanner(),
      itemBuilder: (context, entry) => history_pkg_ui.PyroCallLogCardWidget(
        entry: entry,
        onTap: () {},
      ),
      getItemId: (entry) => entry.id,
    );
  }
}
