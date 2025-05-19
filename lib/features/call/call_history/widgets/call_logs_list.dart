import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_service.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/call_log_card.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/info_card.dart';

class CallLogsList extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Consumer<CallLogService>(
      builder: (context, callLogService, child) {
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
                    Text('加载失败: ${snapshot.error}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: onRefresh,
                      child: const Text('重试'),
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
                      selectedLabel != null ? '没有匹配的通话记录' : '暂无通话记录', 
                      style: const TextStyle(fontSize: 18, color: Colors.grey)
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.refresh),
                      label: const Text('刷新'),
                      onPressed: onRefresh,
                    ),
                    if (selectedLabel != null && onClearFilter != null)
                      TextButton(
                        onPressed: onClearFilter,
                        child: const Text('清除标签筛选'),
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
      },
    );
  }
}