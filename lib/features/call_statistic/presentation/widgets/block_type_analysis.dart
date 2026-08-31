import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/call/local_call_type.dart';
import 'package:yourcallyourrule/features/call_statistic/data/services/call_statistics_provider.dart';

import 'package:yourcallyourrule/generated/app_localizations.dart';

class BlockTypeAnalysis extends ConsumerWidget {
  const BlockTypeAnalysis({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 消费 CallStatisticsNotifier 的状态
    final statisticsState = ref.watch(callStatisticsProvider);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFEDE8DF),
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.blockTypeAnalysisTitle,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black87),
          ),
          const SizedBox(height: 16),
          // 加载和错误状态由父 Widget (CallStatisticsPage) 处理
          if (statisticsState.blockTypeAnalysis.isEmpty && !statisticsState.isLoading)
            Center(child: Text(AppLocalizations.of(context)!.noBlockedTypeData, style: const TextStyle(color: Colors.grey)))
          else
            _buildAnalysisContent(context, statisticsState.blockTypeAnalysis),
        ],
      ),
    );
  }

  Widget _buildAnalysisContent(BuildContext context, Map<String, double> typeAnalysis) {
    final blockTypes = typeAnalysis.entries.map((entry) {
      return BlockTypeData.fromCallTypeName(context, entry.key, entry.value.round());
    }).toList();
    
    blockTypes.sort((a, b) => b.percentage.compareTo(a.percentage));

    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 350;
        return Column(
          children: blockTypes.map((type) => _buildTypeItem(type, isSmallScreen)).toList(),
        );
      },
    );
  }

  Widget _buildTypeItem(BlockTypeData data, bool isSmallScreen) {
    final textStyle = TextStyle(fontSize: isSmallScreen ? 14 : 16);
    final percentageStyle = TextStyle(color: Colors.grey, fontSize: isSmallScreen ? 12 : 14);
    final iconSize = isSmallScreen ? 16.0 : 18.0;
    final containerSize = isSmallScreen ? 32.0 : 36.0;
    final progressBarWidth = isSmallScreen ? 60.0 : 80.0;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            width: containerSize, height: containerSize,
            decoration: BoxDecoration(color: data.backgroundColor, borderRadius: BorderRadius.circular(containerSize / 2)),
            child: Icon(data.icon, color: data.iconColor, size: iconSize),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(data.label, style: textStyle, overflow: TextOverflow.ellipsis)),
          Text('${data.percentage}%', style: percentageStyle),
          const SizedBox(width: 12),
          SizedBox(
            width: progressBarWidth, height: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: data.percentage / 100,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(data.iconColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BlockTypeData {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String label;
  final int percentage;

  BlockTypeData({
    required this.icon, required this.iconColor, required this.backgroundColor,
    required this.label, required this.percentage,
  });

  factory BlockTypeData.fromCallTypeName(BuildContext context, String callTypeName, int percentage) {
    IconData icon = Icons.block;
    Color iconColor = Colors.grey;
    String label = callTypeName;
    final localizations = AppLocalizations.of(context)!;

    if (callTypeName == LocalCallType.rejected.name) {
      label = localizations.callTypeRejected;
      icon = Icons.call_end;
      iconColor = Colors.red;
    } else if (callTypeName == LocalCallType.blocked.name) {
      label = localizations.callTypeBlocked;
      icon = Icons.shield;
      iconColor = Colors.orange;
    } else if (callTypeName == LocalCallType.silenced.name) {
      label = localizations.callTypeSilenced;
      icon = Icons.vibration;
      iconColor = Colors.blue;
    }

    return BlockTypeData(
      icon: icon,
      iconColor: iconColor,
      backgroundColor: iconColor.withOpacity(0.15),
      label: label,
      percentage: percentage,
    );
  }
}