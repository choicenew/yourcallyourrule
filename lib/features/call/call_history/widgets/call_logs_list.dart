import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/provider/providers/call_log_service_provider.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/call_log_card.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/info_card.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class CallLogsList extends ConsumerWidget {
  final String? selectedLabel;
  final VoidCallback onRefresh;
  final VoidCallback? onClearFilter;

  const CallLogsList({
    super.key,
    this.selectedLabel,
    required this.onRefresh,
    this.onClearFilter,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final callLogService = ref.watch(callLogServiceProvider);
    return StreamBuilder<List<CallLog>>(
      stream: callLogService.logsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(AppLocalizations.of(context)!.dataLoadFailure(snapshot.error.toString())),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: onRefresh,
                  child: Text(AppLocalizations.of(context)!.retry),
                ),
              ],
            ),
          );
        }
        
        var logs = snapshot.data ?? [];
        
        // 根据标签筛选
        if (selectedLabel != null) {
          logs = logs.where((log) => log.labelIds?.contains(selectedLabel) ?? false).toList();
        }
        
        if (logs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.call, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  selectedLabel != null ? AppLocalizations.of(context)!.noMatchingRecords : AppLocalizations.of(context)!.noRecords,
                  style: const TextStyle(fontSize: 18, color: Colors.grey)
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  icon: const Icon(Icons.refresh),
                  label: Text(AppLocalizations.of(context)!.refresh),
                  onPressed: onRefresh,
                ),
                if (selectedLabel != null && onClearFilter != null)
                  TextButton(
                    onPressed: onClearFilter,
                    child: Text(AppLocalizations.of(context)!.clearLabelFilter),
                  ),
              ],
            ),
          );
        }
        
        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: logs.length + 1, // +1 for the info card
          itemBuilder: (context, index) {
            if (index == 0) {
              return const InfoCard();
            }
            
            final log = logs[index - 1];
            return CallLogCard(log: log);
          },
        );
      },
    );
  }
  }