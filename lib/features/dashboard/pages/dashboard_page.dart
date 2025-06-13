import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/provider/providers/call_log_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/rule_management_service_provider.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_service.dart';
import 'package:yourcallyourrule/features/rules/services/rule_management_service.dart';
import 'package:yourcallyourrule/features/call_statistic/data/repositories/call_statistics_repository_impl.dart';
import 'package:yourcallyourrule/features/call_statistic/domain/repositories/blocked_call_repository.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/block_type_analysis.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/statistic_card.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/statistic_chart.dart';
import 'package:yourcallyourrule/features/common/widgets/bottom_navigation.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// Data Analysis Dashboard Page
class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  bool _isLoading = true;
  List<CallLog> _callLogs = [];
  int _blockedCallsCount = 0;
  int _filteredSmsCount = 0;
  // 四种action类型的规则数量
  int _allowRulesCount = 0;
  int _blockRulesCount = 0;
  int _silenceRulesCount = 0;
  int _noneRulesCount = 0;
  List<double> _weeklyData = [0, 0, 0, 0, 0, 0, 0]; // 最近7天的数据
  String _selectedTimeRange = 'week'; // 默认值，直接在UI中使用翻译

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // 移除didChangeDependencies中的翻译设置，改为在UI中直接使用翻译
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 加载通话记录
      final callLogService = ref.read(callLogServiceProvider);
      await callLogService.initialize();
      
      // 加载规则数据 - 获取四种action类型的规则
      final ruleManagementService = ref.read(ruleManagementServiceProvider);
      final blockRules = await ruleManagementService.getAllRulesByActionType(RuleActionType.block);
      final allowRules = await ruleManagementService.getAllRulesByActionType(RuleActionType.allow);
      final silenceRules = await ruleManagementService.getAllRulesByActionType(RuleActionType.silence);
      final noneRules = await ruleManagementService.getAllRulesByActionType(RuleActionType.none);
      
      // 监听通话记录流
      callLogService.logsStream.listen((logs) {
        if (mounted) {
          setState(() {
            _callLogs = logs;
            
            // 使用CallStatisticsRepositoryImpl获取统计数据
            final List<RuleBase> allRules = [...blockRules, ...allowRules, ...silenceRules, ...noneRules];
            final repository = CallStatisticsRepositoryImpl(_callLogs, allRules);
            
            // 获取各种统计数据
            _blockedCallsCount = repository.getWeeklyBlockedCallsCount();
            _filteredSmsCount = repository.getWeeklyFilteredSmsCount();
            _blockRulesCount = repository.getBlockRulesCount();
            _allowRulesCount = repository.getAllowRulesCount();
            _silenceRulesCount = repository.getSilenceRulesCount();
            _noneRulesCount = repository.getNoneRulesCount();
            
            // 获取每周数据
            final now = DateTime.now();
            final weeklyData = repository.getBlockedCallsByDate(_selectedTimeRange);
            _weeklyData = List.generate(7, (index) {
              final day = now.subtract(Duration(days: index));
              final dateKey = DateTime(day.year, day.month, day.day);
              return (weeklyData[dateKey] ?? 0).toDouble();
            });
            
            _isLoading = false;
          });
        }
      });
      
      // 获取短信过滤数量
      final callStatisticsRepository = CallStatisticsRepositoryImpl(_callLogs, [...blockRules, ...allowRules, ...silenceRules, ...noneRules]);
      final filteredSmsCount = callStatisticsRepository.getWeeklyFilteredSmsCount();
      
      setState(() {
        _blockRulesCount = blockRules.length;
        _allowRulesCount = allowRules.length;
        _silenceRulesCount = silenceRules.length;
        _noneRulesCount = noneRules.length;
        _filteredSmsCount = filteredSmsCount;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${AppLocalizations.of(context)!.loadDataFailed}: $e'),
          backgroundColor: Colors.red,
        ));
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _calculateStats() {
    // 计算被拦截的通话数量
    _blockedCallsCount = _callLogs.where((log) => log.callType == 'blocked').length;
    
    // 计算每周数据
    final now = DateTime.now();
    for (int i = 0; i < 7; i++) {
      final day = now.subtract(Duration(days: i));
      final count = _callLogs.where((log) => 
        log.callType == 'blocked' && 
        log.timestamp.year == day.year && 
        log.timestamp.month == day.month && 
        log.timestamp.day == day.day
      ).length.toDouble();
      
      if (i < _weeklyData.length) {
        _weeklyData[i] = count;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.dataAnalysis),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today, color: Colors.grey),
            onPressed: () {
              // 显示日期选择器
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.grey),
            onPressed: () {
              // 显示通知
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildDashboardContent(),
      bottomNavigationBar: BottomNavigation(
        currentIndex: 3, // 仪表盘选项卡
        onTap: (index) => AppRouter.handleNavigation(context, index),
      ),
    );
  }

  Widget _buildDashboardContent() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Color(0xFFF5F5F5)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 总览卡片
            _buildOverviewCard(),
            
            // 广告位
            _buildAdPlaceholder(),
            
            // 统计卡片网格
            _buildStatsGrid(),
            
            // 拦截趋势图表
            _buildTrendChart(),
            
            // 拦截类型分析
            _buildBlockTypeAnalysis(),
            
            // 导出数据按钮
            _buildExportButton(),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFB74D), Color(0xFFFF7043)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black..withValues(alpha:0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
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
                    AppLocalizations.of(context)!.monthlyTotal,
                    style: TextStyle(color: Colors.white..withValues(alpha:0.8), fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$_blockedCallsCount',
                    style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    AppLocalizations.of(context)!.blockedCommunications,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white..withValues(alpha:0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '+12.5%',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 60,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: _weeklyData.asMap().entries.map((entry) {
                      return FlSpot(entry.key.toDouble(), entry.value);
                    }).toList(),
                    isCurved: true,
                    color: Colors.white..withValues(alpha:0.8),
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.white..withValues(alpha:0.1),
                    ),
                  ),
                ],
                lineTouchData: const LineTouchData(enabled: false),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdPlaceholder() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: const GoogleAdWidget(adInfo: AdManager.bannerAd),
    );
  }

  Widget _buildStatsGrid() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // 使用call_statistic中的StatisticCard组件
          StatisticCard(
            icon: Icons.phone_disabled,
            iconColor: Colors.blue,
            backgroundColor: Colors.blue..withValues(alpha:0.1),
            title: '$_blockedCallsCount',
            subtitle: AppLocalizations.of(context)!.blockCalls,
            period: AppLocalizations.of(context)!.thisWeek,
          ),
          StatisticCard(
            icon: Icons.sms_failed,
            iconColor: Colors.purple,
            backgroundColor: Colors.purple..withValues(alpha:0.1),
            title: '$_filteredSmsCount',
            subtitle: AppLocalizations.of(context)!.filterSMS,
            period: AppLocalizations.of(context)!.thisWeek,
          ),
          StatisticCard(
            icon: Icons.person_add,
            iconColor: Colors.green,
            backgroundColor: Colors.green..withValues(alpha:0.1),
            title: '$_allowRulesCount',
            subtitle: AppLocalizations.of(context)!.allowRules,
            period: AppLocalizations.of(context)!.total,
          ),
          StatisticCard(
            icon: Icons.person_remove,
            iconColor: Colors.red,
            backgroundColor: Colors.red..withValues(alpha:0.1),
            title: '$_blockRulesCount',
            subtitle: AppLocalizations.of(context)!.blockRules,
            period: AppLocalizations.of(context)!.total,
          ),
          // 添加静音规则和无动作规则的统计卡片
          StatisticCard(
            icon: Icons.volume_off,
            iconColor: Colors.orange,
            backgroundColor: Colors.orange..withValues(alpha:0.1),
            title: '$_silenceRulesCount',
            subtitle: AppLocalizations.of(context)!.silentRules,
            period: AppLocalizations.of(context)!.total,
          ),
          StatisticCard(
            icon: Icons.do_not_disturb_alt,
            iconColor: Colors.grey,
            backgroundColor: Colors.grey..withValues(alpha:0.1),
            title: '$_noneRulesCount',
            subtitle: AppLocalizations.of(context)!.noActionRules,
            period: AppLocalizations.of(context)!.total,
          ),
        ],
      ),
    );
  }

  Widget _buildTrendChart() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black..withValues(alpha:0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
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
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  _buildTimeRangeButton(AppLocalizations.of(context)!.week, isSelected: _selectedTimeRange == 'week'),
                  const SizedBox(width: 8),
                  _buildTimeRangeButton(AppLocalizations.of(context)!.month, isSelected: _selectedTimeRange == 'month'),
                  const SizedBox(width: 8),
                  _buildTimeRangeButton(AppLocalizations.of(context)!.year, isSelected: _selectedTimeRange == 'year'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // 使用call_statistic中的StatisticChart组件
          StatisticChart(
            repository: BlockedCallRepository(),
            showDetailedChart: true,
            period: _selectedTimeRange,
          ),
        ],
      ),
    );
  }

  Widget _buildTimeRangeButton(String text, {required bool isSelected}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTimeRange = text;
          _loadData(); // 切换时间范围时重新加载数据
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
            fontSize: 12,
            color: isSelected ? const Color(0xFFFFB74D) : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildBlockTypeAnalysis() {
    // 使用call_statistic中的BlockTypeAnalysis组件
    return const BlockTypeAnalysis();
  }

  Widget _buildExportButton() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          // 导出统计数据
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)!.statisticsExportFeatureComingSoon),
          ));
        },
        icon: const Icon(Icons.file_download),
        label: Text(AppLocalizations.of(context)!.exportStatisticsData),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFB74D),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 5,
        ),
      ),
    );
  }
}