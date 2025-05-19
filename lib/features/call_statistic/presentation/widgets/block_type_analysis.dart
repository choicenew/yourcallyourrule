import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/provider/call_logs_provider.dart';
import 'package:yourcallyourrule/core/provider/rules_provider.dart';
import 'package:yourcallyourrule/features/call_statistic/data/repositories/call_statistics_repository_impl.dart';
import 'package:yourcallyourrule/features/labels/utils/label_text_utils.dart';

class BlockTypeAnalysis extends ConsumerStatefulWidget {
  const BlockTypeAnalysis({super.key});

  @override
  ConsumerState<BlockTypeAnalysis> createState() => _BlockTypeAnalysisState();
}

class _BlockTypeAnalysisState extends ConsumerState<BlockTypeAnalysis> {

  @override
  Widget build(BuildContext context) {
    final callLogsAsync = ref.watch(callLogsProvider);
    final rulesAsync = ref.watch(rulesProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '拦截类型分析',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          callLogsAsync.when(
            data: (callLogs) => rulesAsync.when(
              data: (rules) => _buildAnalysisContent(context, callLogs, rules),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('加载规则失败: $error')),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('加载通话记录失败: $error')),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisContent(BuildContext context, List<CallLog> callLogs, List<RuleBase> rules) {
    // 创建repository实例并获取拦截类型分析数据
    final repository = CallStatisticsRepositoryImpl(callLogs, rules);
    final typeAnalysis = repository.getBlockTypeAnalysis();
    
    // 转换数据为BlockTypeData列表
    final List<BlockTypeData> blockTypes = [];
    
    // 动态处理所有拦截类型
    for (final entry in typeAnalysis.entries) {
      final labelId = entry.key;
      final percentage = entry.value.round();
      
      // 异步获取标签文本
      _getLabelDisplayText(context, labelId).then((labelText) {
        // 动态获取图标和颜色，避免硬编码
        IconData icon;
        Color iconColor;
        Color backgroundColor;
        
        // 根据标签ID的内容动态选择图标和颜色
        if (labelId.toLowerCase().contains('fraud') || labelId.toLowerCase().contains('scam')) {
          icon = Icons.warning;
          iconColor = Colors.red;
          backgroundColor = Colors.red.shade100;
        } else if (labelId.toLowerCase().contains('spam')) {
          icon = Icons.report_problem;
          iconColor = Colors.orange;
          backgroundColor = Colors.orange.shade100;
        } else if (labelId.toLowerCase().contains('telemarketing')) {
          icon = Icons.campaign;
          iconColor = Colors.amber;
          backgroundColor = Colors.amber.shade100;
        } else if (labelId.toLowerCase().contains('sms')) {
          icon = Icons.sms_failed;
          iconColor = Colors.purple;
          backgroundColor = Colors.purple.shade100;
        } else if (labelId.toLowerCase().contains('robot') || labelId.toLowerCase().contains('robo')) {
          icon = Icons.smart_toy;
          iconColor = Colors.blue;
          backgroundColor = Colors.blue.shade100;
        } else if (labelId.toLowerCase().contains('delivery') || labelId.toLowerCase().contains('takeaway')) {
          icon = Icons.delivery_dining;
          iconColor = Colors.green;
          backgroundColor = Colors.green.shade100;
        } else if (labelId.toLowerCase().contains('service')) {
          icon = Icons.support_agent;
          iconColor = Colors.teal;
          backgroundColor = Colors.teal.shade100;
        } else {
          // 默认图标和颜色
          icon = Icons.label;
          iconColor = Colors.blue;
          backgroundColor = Colors.blue.shade100;
        }
        
        // 添加到列表
        setState(() {
          blockTypes.add(BlockTypeData(
            icon: icon,
            iconColor: iconColor,
            backgroundColor: backgroundColor,
            label: labelText,
            percentage: percentage,
          ));
        });
      });
    }
    
    // 如果没有数据，显示提示信息
    if (typeAnalysis.isEmpty) {
      return const Center(
        child: Text('暂无拦截类型数据', style: TextStyle(color: Colors.grey)),
      );
    }

    return Column(
      children: blockTypes.map((type) => _buildTypeItem(type)).toList(),
    );
  }

  // 获取标签显示文本
  Future<String> _getLabelDisplayText(BuildContext context, String labelId) async {
    try {
      // 使用LabelTextUtils获取标签文本
      final labelText = await LabelTextUtils.getLabelTextById(context, labelId);
      return labelText ?? labelId;
    } catch (e) {
      // 如果获取失败，返回标签ID作为显示文本
      return labelId;
    }
  }

  Widget _buildTypeItem(BlockTypeData data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          // 图标
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: data.backgroundColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(data.icon, color: data.iconColor, size: 18),
          ),
          const SizedBox(width: 12),
          
          // 标签
          Text(
            data.label,
            style: const TextStyle(fontSize: 16),
          ),
          
          const Spacer(),
          
          // 百分比
          Text(
            '${data.percentage}%',
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(width: 12),
          
          // 进度条
          SizedBox(
            width: 80,
            height: 4,
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
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.label,
    required this.percentage,
  });
}