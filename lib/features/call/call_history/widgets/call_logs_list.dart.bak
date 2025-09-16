import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/provider/providers/call_log_service_provider.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/call_log_card.dart';

import 'package:yourcallyourrule/generated/app_localizations.dart';

class CallLogsList extends ConsumerWidget {
  final String? selectedLabel;
  // 1. 添加 onRefresh 和 onClearFilter 成员变量
  final Future<void> Function() onRefresh;
  final VoidCallback? onClearFilter;

  // 2. 在构造函数中接收这些参数
  const CallLogsList({
    super.key,
    this.selectedLabel,
    required this.onRefresh,
    this.onClearFilter,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsStream = ref.watch(callLogServiceProvider).logsStream;

    return StreamBuilder<List<CallLog>>(
      stream: logsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // 错误状态：最好在界面中心显示一个持久的提示，并允许用户通过下拉刷新重试
        if (snapshot.hasError) {
          return RefreshIndicator(
            onRefresh: onRefresh, // 允许在错误页面也进行刷新
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Center(
                      child: Text(AppLocalizations.of(context)!.dataLoadFailure(snapshot.error.toString())),
                    ),
                  ),
                );
              },
            ),
          );
        }

        final allLogs = snapshot.data ?? [];
        final filteredLogs = selectedLabel == null
            ? allLogs
            : allLogs.where((log) => log.labelIds?.contains(selectedLabel) ?? false).toList();

        // 空状态：同样提供下拉刷新功能
        if (filteredLogs.isEmpty) {
          return RefreshIndicator(
            onRefresh: onRefresh,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Center(
                      child: Text(AppLocalizations.of(context)!.noCallLogs),
                    ),
                  ),
                );
              },
            ),
          );
        }

        // 3. 使用 RefreshIndicator 包裹列表来实现下拉刷新
        return RefreshIndicator(
          onRefresh: onRefresh,
          child: Column(
            children: [
              // 4. 当有筛选器时，显示一个可点击的 Chip 来清除它
              if (onClearFilter != null && selectedLabel != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Chip(
                    label: Text('筛选: "$selectedLabel"'),
                    onDeleted: onClearFilter, // 点击删除图标时调用 onClearFilter
                  ),
                ),
              
              // 5. 将 ListView 放入 Expanded 中，使其填满 Column 的剩余空间
              Expanded(
                child: ListView.builder(
                  itemCount: filteredLogs.length,
                  itemBuilder: (context, index) {
                    final log = filteredLogs[index];
                    return CallLogCard(log: log);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
