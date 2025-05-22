import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/provider/call_logs_provider.dart';
import 'package:yourcallyourrule/core/provider/rules_provider.dart';
import 'package:yourcallyourrule/features/call_statistic/data/repositories/call_statistics_repository_impl.dart';
import 'package:yourcallyourrule/features/call_statistic/domain/repositories/blocked_call_repository.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/statistic_chart.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/statistic_card.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/block_type_analysis.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class CallStatisticsPage extends ConsumerStatefulWidget {
  const CallStatisticsPage({super.key});

  @override
  ConsumerState<CallStatisticsPage> createState() => _CallStatisticsPageState();
}

class _CallStatisticsPageState extends ConsumerState<CallStatisticsPage> {
  String _selectedPeriod = '周'; // 默认选择周期
  final BlockedCallRepository _repository = BlockedCallRepository();

  @override
  Widget build(BuildContext context) {
    final callLogsAsync = ref.watch(callLogsProvider);
    final rulesAsync = ref.watch(rulesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.statisticsPageTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              // 日期选择功能
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // 通知功能
            },
          ),
        ],
      ),
      body: callLogsAsync.when(
        data: (callLogs) => rulesAsync.when(
          data: (rules) => _buildStatisticsContent(context, callLogs, rules),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('加载规则失败: $error')),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('加载通话记录失败: $error')),
      ),
    );
  }

  Widget _buildStatisticsContent(BuildContext context, List<CallLog> callLogs, List<RuleBase> rules) {
    // 创建repository实例
    final repository = CallStatisticsRepositoryImpl(callLogs, rules);
    
    // 获取实际统计数据
    final int totalBlocked = repository.getTotalBlockedCount();
    final int blockedCalls = repository.getWeeklyBlockedCallsCount();
    final int filteredSms = repository.getWeeklyFilteredSmsCount();
    final int whitelistCount = repository.getWhitelistRulesCount();
    final int blacklistCount = repository.getBlacklistRulesCount();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 总览卡片
            _buildOverviewCard(totalBlocked),
            
            // 广告位
            const SizedBox(height: 16),
            const InlineAdaptiveBannerAdWidget(adInfo: AdManager.adaptiveBannerAd),
            
            // 统计卡片网格
            const SizedBox(height: 16),
            _buildStatisticsGrid(blockedCalls, filteredSms, whitelistCount, blacklistCount),
            
            // 详细图表
            const SizedBox(height: 16),
            _buildTrendChart(),
            
            // 拦截类型分析
            const SizedBox(height: 16),
            const BlockTypeAnalysis(),
            
            // 导出数据按钮
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // 导出统计数据功能
                },
                icon: const Icon(Icons.file_download),
                label: const Text('导出统计数据'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard(int totalBlocked) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFB74D), Color(0xFFFF7043)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '本月总计',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$totalBlocked',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    '已拦截通讯',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '+12.5%',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 60,
            child: StatisticChart(repository: _repository),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsGrid(int blockedCalls, int filteredSms, int whitelistCount, int blacklistCount) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        StatisticCard(
          icon: Icons.phone_disabled,
          iconColor: Colors.blue,
          backgroundColor: Colors.blue.withOpacity(0.1),
          title: '$blockedCalls',
          subtitle: '拦截电话',
          period: '本周',
        ),
        StatisticCard(
          icon: Icons.sms_failed,
          iconColor: Colors.purple,
          backgroundColor: Colors.purple.withOpacity(0.1),
          title: '$filteredSms',
          subtitle: '过滤短信',
          period: '本周',
        ),
        StatisticCard(
          icon: Icons.person_outline,
          iconColor: Colors.green,
          backgroundColor: Colors.green.withOpacity(0.1),
          title: '$whitelistCount',
          subtitle: '白名单',
          period: '总计',
        ),
        StatisticCard(
          icon: Icons.person_off,
          iconColor: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.1),
          title: '$blacklistCount',
          subtitle: '黑名单',
          period: '总计',
        ),
      ],
    );
  }

  Widget _buildTrendChart() {
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '拦截趋势',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  _periodButton('周', isSelected: _selectedPeriod == '周'),
                  const SizedBox(width: 8),
                  _periodButton('月', isSelected: _selectedPeriod == '月'),
                  const SizedBox(width: 8),
                  _periodButton('年', isSelected: _selectedPeriod == '年'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: StatisticChart(
              repository: _repository,
              showDetailedChart: true,
              period: _selectedPeriod,
            ),
          ),
        ],
      ),
    );
  }

  Widget _periodButton(String text, {required bool isSelected}) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedPeriod = text;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFB74D).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? const Color(0xFFFFB74D) : Colors.grey,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}