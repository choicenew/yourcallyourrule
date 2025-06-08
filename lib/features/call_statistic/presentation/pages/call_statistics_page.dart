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
import 'package:yourcallyourrule/features/call_statistic/domain/entities/statistics_data.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class CallStatisticsPage extends ConsumerStatefulWidget {
  const CallStatisticsPage({super.key});

  @override
  ConsumerState<CallStatisticsPage> createState() => _CallStatisticsPageState();
}

class _CallStatisticsPageState extends ConsumerState<CallStatisticsPage> {
  String _selectedPeriod = 'Week'; // 默认选择周期
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
              // 实现日期选择功能
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(AppLocalizations.of(context)!.selectPeriod),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Text(AppLocalizations.of(context)!.week),
                        leading: Radio<String>(
                          value: 'Week',
                          groupValue: _selectedPeriod,
                          onChanged: (value) {
                            setState(() {
                              _selectedPeriod = value!;
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(AppLocalizations.of(context)!.month),
                        leading: Radio<String>(
                          value: 'Month',
                          groupValue: _selectedPeriod,
                          onChanged: (value) {
                            setState(() {
                              _selectedPeriod = value!;
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(AppLocalizations.of(context)!.year),
                        leading: Radio<String>(
                          value: 'Year',
                          groupValue: _selectedPeriod,
                          onChanged: (value) {
                            setState(() {
                              _selectedPeriod = value!;
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // 实现通知功能
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(AppLocalizations.of(context)!.notifications),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.notifications_active, color: Colors.green),
                        title: Text(AppLocalizations.of(context)!.enableStatisticsNotifications),
                        subtitle: Text(AppLocalizations.of(context)!.receiveWeeklyStatistics),
                        trailing: Switch(
                          value: false, // 这里应该使用一个状态变量，暂时使用false
                          onChanged: (value) {
                            // 这里应该保存用户的选择
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(AppLocalizations.of(context)!.notificationSettingsSaved)),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(AppLocalizations.of(context)!.close),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: callLogsAsync.when(
        data: (callLogs) => rulesAsync.when(
          data: (rules) => _buildStatisticsContent(context, callLogs, rules),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text(AppLocalizations.of(context)!.loadRulesFailed(error.toString()))),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(AppLocalizations.of(context)!.callHistoryRefreshFailed(error.toString()))),
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
    
    // 获取增长率数据
    final statisticsData = StatisticsData(
      growthRate: repository.calculateMonthlyGrowthRate(),
    );

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 总览卡片
            _buildOverviewCard(totalBlocked, statisticsData),
            
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
                label: Text(AppLocalizations.of(context)!.exportStatisticsData),
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

  Widget _buildOverviewCard(int totalBlocked, StatisticsData statisticsData) {
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
            color: Colors.grey.withValues(alpha:0.3),
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
                  Text(
                    AppLocalizations.of(context)!.monthlyTotalLabel,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
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
                  Text(
                    AppLocalizations.of(context)!.blockedCommunications,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
              // 从数据中获取增长率，如果有的话
              if (statisticsData?.growthRate != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha:0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${statisticsData!.growthRate > 0 ? '+' : ''}${statisticsData!.growthRate}%',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
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
          backgroundColor: Colors.blue.withValues(alpha:0.1),
          title: '$blockedCalls',
          subtitle: AppLocalizations.of(context)!.blockedPhoneLabel,
          period: AppLocalizations.of(context)!.periodWeek,
        ),
        StatisticCard(
          icon: Icons.sms_failed,
          iconColor: Colors.purple,
          backgroundColor: Colors.purple.withValues(alpha:0.1),
          title: '$filteredSms',
          subtitle: AppLocalizations.of(context)!.filteredSmsLabel,
          period: AppLocalizations.of(context)!.periodWeek,
        ),
        StatisticCard(
          icon: Icons.person_outline,
          iconColor: Colors.green,
          backgroundColor: Colors.green.withValues(alpha:0.1),
          title: '$whitelistCount',
          subtitle: AppLocalizations.of(context)!.whitelistLabel,
          period: AppLocalizations.of(context)!.tabAll,
        ),
        StatisticCard(
          icon: Icons.person_off,
          iconColor: Colors.red,
          backgroundColor: Colors.red.withValues(alpha:0.1),
          title: '$blacklistCount',
          subtitle: AppLocalizations.of(context)!.blacklistLabel,
          period: AppLocalizations.of(context)!.tabAll,
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
            color: Colors.grey.withValues(alpha:0.1),
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
              Text(
                AppLocalizations.of(context)!.blockingTrend,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () {
                      _showDateRangePicker(context);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {
                      _showNotificationSettings(context);
                    },
                  ),
                  const SizedBox(width: 8),
                  _periodButton(AppLocalizations.of(context)!.periodWeek, isSelected: _selectedPeriod == 'Week'),
                  const SizedBox(width: 8),
                  _periodButton(AppLocalizations.of(context)!.periodMonth, isSelected: _selectedPeriod == 'Month'),
                  const SizedBox(width: 8),
                  _periodButton(AppLocalizations.of(context)!.periodYear, isSelected: _selectedPeriod == 'Year'),
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
          color: isSelected ? const Color(0xFFFFB74D).withValues(alpha:0.1) : Colors.transparent,
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

  // 日期选择功能
  Future<void> _showDateRangePicker(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 7)),
      end: DateTime.now(),
    );
    
    final pickedDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: initialDateRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFFFB74D),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (pickedDateRange != null) {
      // 处理选择的日期范围
      setState(() {
        // 这里可以更新日期范围并刷新数据
        // 例如：_startDate = pickedDateRange.start;
        //      _endDate = pickedDateRange.end;
        // 然后重新加载数据
      });
      
      // 显示选择的日期范围
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${AppLocalizations.of(context)!.selectedDateRange}: '
            '${pickedDateRange.start.toString().substring(0, 10)} - '
            '${pickedDateRange.end.toString().substring(0, 10)}',
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  // 通知功能
  void _showNotificationSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.notificationSettings),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: Text(AppLocalizations.of(context)!.dailyStatistics),
              subtitle: Text(AppLocalizations.of(context)!.dailyStatisticsDesc),
              value: true, // 这里应该从设置中获取实际值
              onChanged: (value) {
                // 保存设置
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppLocalizations.of(context)!.settingsSaved),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
            SwitchListTile(
              title: Text(AppLocalizations.of(context)!.weeklyReport),
              subtitle: Text(AppLocalizations.of(context)!.weeklyReportDesc),
              value: false, // 这里应该从设置中获取实际值
              onChanged: (value) {
                // 保存设置
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppLocalizations.of(context)!.settingsSaved),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () {
              // 保存所有设置
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppLocalizations.of(context)!.settingsSaved),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: Text(AppLocalizations.of(context)!.save),
          ),
        ],
      ),
    );
  }
}