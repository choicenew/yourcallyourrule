import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/features/call/services/call_log_service.dart';
import 'package:yourcallyourrule/features/rules/services/blacklist_whitelist_service.dart';

/// 数据分析仪表盘页面
class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

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
      
      // 计算统计数据
      final now = DateTime.now();
      final oneMonthAgo = DateTime(now.year, now.month - 1, now.day);
      
      // 监听通话记录流
      callLogService.logsStream.listen((logs) {
        if (mounted) {
          setState(() {
            _callLogs = logs;
            _calculateStats();
            _isLoading = false;
          });
        }
      });
      
      setState(() {
        _blacklistCount = blacklistRules.length;
        _whitelistCount = whitelistRules.length;
        // 这里的短信过滤数量是模拟数据，实际应用中应该从短信服务获取
        _filteredSmsCount = 56;
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
          _buildStatCard(
            icon: Icons.phone_disabled,
            iconColor: Colors.blue,
            title: '$_blockedCallsCount',
            subtitle: '拦截电话',
            period: '本周',
          ),
          _buildStatCard(
            icon: Icons.sms_failed,
            iconColor: Colors.purple,
            title: '$_filteredSmsCount',
            subtitle: '过滤短信',
            period: '本周',
          ),
          _buildStatCard(
            icon: Icons.person_add,
            iconColor: Colors.green,
            title: '$_whitelistCount',
            subtitle: '白名单',
            period: '总计',
          ),
          _buildStatCard(
            icon: Icons.person_remove,
            iconColor: Colors.red,
            title: '$_blacklistCount',
            subtitle: '黑名单',
            period: '总计',
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String period,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: iconColor),
              Text(
                period,
                style: TextStyle(fontSize: 12, color: iconColor.withOpacity(0.7)),
              ),
            ],
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
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
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: _weeklyData.isEmpty ? 1 : _weeklyData.reduce((a, b) => a > b ? a : b) * 1.2,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const titles = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
                        final index = value.toInt();
                        if (index >= 0 && index < titles.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              titles[index],
                              style: const TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(
                  show: true,
                  horizontalInterval: 1,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey.withOpacity(0.1),
                    strokeWidth: 1,
                  ),
                  drawVerticalLine: false,
                ),
                borderData: FlBorderData(show: false),
                barGroups: _weeklyData.asMap().entries.map((entry) {
                  return BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: entry.value,
                        color: const Color(0xFFFFB74D),
                        width: 12,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '拦截类型分析',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildBlockTypeItem(
            icon: Icons.android,
            iconColor: Colors.red,
            title: '骚扰电话',
            percentage: 45,
            color: Colors.red,
          ),
          const SizedBox(height: 12),
          _buildBlockTypeItem(
            icon: Icons.campaign,
            iconColor: Colors.amber,
            title: '推销电话',
            percentage: 30,
            color: Colors.amber,
          ),
          const SizedBox(height: 12),
          _buildBlockTypeItem(
            icon: Icons.sms_failed,
            iconColor: Colors.purple,
            title: '垃圾短信',
            percentage: 25,
            color: Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildBlockTypeItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required int percentage,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: iconColor, size: 16),
        ),
        const SizedBox(width: 12),
        Text(title, style: const TextStyle(fontSize: 14)),
        const Spacer(),
        Text('$percentage%', style: const TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(width: 12),
        SizedBox(
          width: 80,
          height: 8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ),
      ],
    );
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