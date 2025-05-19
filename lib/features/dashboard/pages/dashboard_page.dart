import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_service.dart';
import 'package:yourcallyourrule/features/rules/services/blacklist_whitelist_service.dart';
import 'package:yourcallyourrule/features/call_statistic/data/repositories/call_statistics_repository_impl.dart';
import 'package:yourcallyourrule/features/call_statistic/domain/repositories/blocked_call_repository.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/block_type_analysis.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/statistic_card.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/statistic_chart.dart';
import 'package:yourcallyourrule/features/common/widgets/bottom_navigation.dart';

/// 数据分析仪表盘页面
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _isLoading = true;
  List<CallLog> _callLogs = [];
  int _blockedCallsCount = 0;
  int _filteredSmsCount = 0;
  int _whitelistCount = 0;
  int _blacklistCount = 0;
  List<double> _weeklyData = [0, 0, 0, 0, 0, 0, 0]; // 最近7天的数据
  String _selectedTimeRange = '周';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 加载通话记录
      final callLogService = Provider.of<CallLogService>(context, listen: false);
      await callLogService.initialize();
      
      // 加载黑白名单数据
      final blacklistWhitelistService = Provider.of<BlacklistWhitelistService>(context, listen: false);
      final blacklistRules = await blacklistWhitelistService.getAllBlacklistRules();
      final whitelistRules = await blacklistWhitelistService.getAllWhitelistRules();
      
      // 监听通话记录流
      callLogService.logsStream.listen((logs) {
        if (mounted) {
          setState(() {
            _callLogs = logs;
            
            // 使用CallStatisticsRepositoryImpl获取统计数据
            final List<RuleBase> allRules = [...blacklistRules, ...whitelistRules];
            final repository = CallStatisticsRepositoryImpl(_callLogs, allRules);
            
            // 获取各种统计数据
            _blockedCallsCount = repository.getWeeklyBlockedCallsCount();
            _filteredSmsCount = repository.getWeeklyFilteredSmsCount();
            _blacklistCount = repository.getBlacklistRulesCount();
            _whitelistCount = repository.getWhitelistRulesCount();
            
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
      final callStatisticsRepository = CallStatisticsRepositoryImpl(_callLogs, [...blacklistRules, ...whitelistRules]);
      final filteredSmsCount = callStatisticsRepository.getWeeklyFilteredSmsCount();
      
      setState(() {
        _blacklistCount = blacklistRules.length;
        _whitelistCount = whitelistRules.length;
        _filteredSmsCount = filteredSmsCount;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('加载数据失败: $e'),
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
        title: const Text('数据分析'),
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
            color: Colors.black.withOpacity(0.1),
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
                    '本月总计',
                    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$_blockedCallsCount',
                    style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
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
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: _weeklyData.asMap().entries.map((entry) {
                      return FlSpot(entry.key.toDouble(), entry.value);
                    }).toList(),
                    isCurved: true,
                    color: Colors.white.withOpacity(0.8),
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                ],
                lineTouchData: LineTouchData(enabled: false),
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF6D365), Color(0xFFFDA085)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: const [
          Text(
            'Google Ad 展示位置',
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            '这里可以集成 Google AdMob 广告',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
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
            backgroundColor: Colors.blue.withOpacity(0.1),
            title: '$_blockedCallsCount',
            subtitle: '拦截电话',
            period: '本周',
          ),
          StatisticCard(
            icon: Icons.sms_failed,
            iconColor: Colors.purple,
            backgroundColor: Colors.purple.withOpacity(0.1),
            title: '$_filteredSmsCount',
            subtitle: '过滤短信',
            period: '本周',
          ),
          StatisticCard(
            icon: Icons.person_add,
            iconColor: Colors.green,
            backgroundColor: Colors.green.withOpacity(0.1),
            title: '$_whitelistCount',
            subtitle: '白名单',
            period: '总计',
          ),
          StatisticCard(
            icon: Icons.person_remove,
            iconColor: Colors.red,
            backgroundColor: Colors.red.withOpacity(0.1),
            title: '$_blacklistCount',
            subtitle: '黑名单',
            period: '总计',
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
            color: Colors.black.withOpacity(0.05),
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
              const Text(
                '拦截趋势',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  _buildTimeRangeButton('周', isSelected: _selectedTimeRange == '周'),
                  const SizedBox(width: 8),
                  _buildTimeRangeButton('月', isSelected: _selectedTimeRange == '月'),
                  const SizedBox(width: 8),
                  _buildTimeRangeButton('年', isSelected: _selectedTimeRange == '年'),
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
          color: isSelected ? const Color(0xFFFFB74D).withOpacity(0.1) : Colors.transparent,
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
    return BlockTypeAnalysis();
  }

  Widget _buildExportButton() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          // 导出统计数据
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('统计数据导出功能即将上线'),
          ));
        },
        icon: const Icon(Icons.file_download),
        label: const Text('导出统计数据'),
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