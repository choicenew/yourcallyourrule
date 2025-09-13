// lib/features/call/call_history/widgets/call_timeline_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
// 【关键修改】导入我们最终版的标准卡片
import 'package:yourcallyourrule/features/call/call_history/widgets/call_log_card.dart'; 
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// “瘦身”后的通话记录时间轴视图组件
/// 它只负责时间轴布局，并使用标准的 CallLogCard 来显示内容。
class CallTimelineView extends ConsumerWidget {
  final List<CallLog> logs;
  final Function() onRefresh;
  final Function()? onClearFilter;
  final String? selectedLabel;
  final String selectedTab;
  final bool isLoading;
  final bool hasMore;
  final VoidCallback? onLoadMore;

  const CallTimelineView({
    super.key,
    required this.logs,
    required this.onRefresh,
    this.onClearFilter,
    this.selectedLabel,
    required this.selectedTab,
    this.isLoading = false,
    this.hasMore = false,
    this.onLoadMore,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (logs.isEmpty && !isLoading) {
      // 空状态视图 (代码保持不变)
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.call, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              selectedTab != AppLocalizations.of(context)!.tabAll || selectedLabel != null 
                ? AppLocalizations.of(context)!.noMatchingRecords 
                : AppLocalizations.of(context)!.noCallRecords, 
              style: const TextStyle(fontSize: 18, color: Colors.grey)
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: Text(AppLocalizations.of(context)!.refresh),
              onPressed: onRefresh,
            ),
            if (selectedLabel != null)
              TextButton(
                onPressed: onClearFilter,
                child: Text(AppLocalizations.of(context)!.clearLabelFilter),
              ),
          ],
        ),
      );
    }
    
    // 计算统计数据 (代码保持不变)
    final blockedCount = logs.where((log) => log.callType == 'blocked').length;
    final answeredCount = logs.where((log) => log.callType == 'incoming').length;
    
    // 使用 ListView.builder 提高长列表性能
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // 统计卡片
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 2.0, // 【保留修复】调整宽高比防止溢出
          children: [
            _buildStatCard(context, AppLocalizations.of(context)!.statBlocked, blockedCount.toString(), Colors.red),
            _buildStatCard(context, AppLocalizations.of(context)!.statAnswered, answeredCount.toString(), Colors.green),
          ],
        ),
        const SizedBox(height: 24),
        
        // 时间轴布局
        _buildTimelineLayout(context, logs),
        
        // 加载更多按钮
        if (hasMore)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: isLoading 
                ? const CircularProgressIndicator()
                : TextButton.icon(
                    icon: const Icon(Icons.expand_more),
                    label: Text(AppLocalizations.of(context)!.loadMore),
                    onPressed: onLoadMore,
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor,
                    ),
                  ),
            ),
          ),
      ],
    );
  }
  
  // 统计卡片 (代码保持不变)
  Widget _buildStatCard(BuildContext context, String title, String value, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  // 时间轴布局 (代码保持不变)
  Widget _buildTimelineLayout(BuildContext context, List<CallLog> logs) {
    final Map<String, List<CallLog>> groupedLogs = {};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    
    for (final log in logs) {
      final logDate = DateTime.fromMillisecondsSinceEpoch(log.timestamp.millisecondsSinceEpoch);
      final logDay = DateTime(logDate.year, logDate.month, logDate.day);
      
      String groupKey;
      if (logDay == today) {
        groupKey = AppLocalizations.of(context)!.today;
      } else if (logDay == yesterday) {
        groupKey = AppLocalizations.of(context)!.yesterday;
      } else {
        groupKey = AppLocalizations.of(context)!.earlier;
      }
      
      if (!groupedLogs.containsKey(groupKey)) groupedLogs[groupKey] = [];
      groupedLogs[groupKey]!.add(log);
    }
    
    // 按日期分组显示
    final List<Widget> timelineGroups = [];
    
    // 排序日期组：今天、昨天、更早
    final sortedKeys = groupedLogs.keys.toList()
      ..sort((a, b) {
        final order = {AppLocalizations.of(context)!.today: 0, AppLocalizations.of(context)!.yesterday: 1, AppLocalizations.of(context)!.earlier: 2};
        return order[a]!.compareTo(order[b]!);
      });
    
    for (final groupKey in sortedKeys) {
      final groupLogs = groupedLogs[groupKey]!;
      
      timelineGroups.add(
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 8.0, left: 28.0),
          child: Text(
            groupKey,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ),
      );
      
      for (final log in groupLogs) {
        timelineGroups.add(_buildTimelineItem(context, log));
      }
    }
    
    return Stack(
      children: [
        // 时间轴线
        Positioned(
          left: 5,
          top: 0,
          bottom: 0,
          width: 2,
          child: Container(color: Colors.grey[300]),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: timelineGroups),
      ],
    );
  }

  /// 【关键修改】此方法被极大简化，现在只负责布局并将渲染工作委托给 CallLogCard
  Widget _buildTimelineItem(BuildContext context, CallLog log) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 时间轴节点
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: -5),
            child: _buildTimelineNode(context),
          ),
          const SizedBox(width: 16),
          // 直接使用我们最终版的标准 CallLogCard
          Expanded(
            child: CallLogCard(log: log),
          ),
        ],
      ),
    );
  }
  
  // 时间轴节点 (代码保持不变)
  Widget _buildTimelineNode(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
    );
  }
}