import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_call_history_ui/pyro_phone_call_history_ui.dart' as history_pkg_ui;
import 'package:yourcallyourrule/features/call_history/providers/call_logs_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class CallHistoryPage extends ConsumerWidget {
  const CallHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final historyLogsAsync = ref.watch(callLogsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.callHistory),
      ),
      body: historyLogsAsync.when(
        data: (logs) {
          if (logs.isEmpty) {
            return Center(child: Text(l10n.callHistoryInfoDesc));
          }
          return ListView.builder(
            itemCount: logs.length,
            itemBuilder: (context, index) {
              final log = logs[index];
              return history_pkg_ui.PyroCallLogCardWidget(
                entry: log,
                onTap: () {},
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
