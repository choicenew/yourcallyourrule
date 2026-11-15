import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_call_history_protocol/pyro_phone_call_history_protocol.dart';
import 'package:pyro_phone_call_history_hub/pyro_phone_call_history_hub.dart';
import 'package:pyro_phone_call_history_ui/pyro_phone_call_history_ui.dart' as history_pkg_ui;
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_timeline_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 真实包裹 GenericTimelinePage 时间线框架与广告流的 CallHistoryPage
class CallHistoryPage extends ConsumerStatefulWidget {
  const CallHistoryPage({super.key});

  @override
  ConsumerState<CallHistoryPage> createState() => _CallHistoryPageState();
}

class _CallHistoryPageState extends ConsumerState<CallHistoryPage> {
  late Future<List<CallLogEntry>> _historyFuture;
  String _searchKeyword = '';

  @override
  void initState() {
    super.initState();
    _historyFuture = CallHistoryControlCenter.instance.getAllLogs();
  }

  void _refreshLogs() {
    setState(() {
      _historyFuture = CallHistoryControlCenter.instance.getAllLogs();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return FutureBuilder<List<CallLogEntry>>(
      future: _historyFuture,
      builder: (context, snapshot) {
        final isLoading = snapshot.connectionState == ConnectionState.waiting;
        final historyLogs = snapshot.data ?? [];
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
          onRefresh: _refreshLogs,
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
      },
    );
  }
}
