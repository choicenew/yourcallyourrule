import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/features/call_statistic/data/services/call_statistics_provider.dart';

import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/block_type_analysis.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/statistic_card.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/statistic_chart.dart';
import 'package:yourcallyourrule/features/common/widgets/bottom_navigation.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class CallStatisticsPage extends ConsumerStatefulWidget {
  const CallStatisticsPage({super.key});

  @override
  ConsumerState<CallStatisticsPage> createState() => _CallStatisticsPageState();
}

class _CallStatisticsPageState extends ConsumerState<CallStatisticsPage> {
  String _selectedPeriod = 'Week';

  @override
  Widget build(BuildContext context) {
    final statisticsState = ref.watch(callStatisticsProvider);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      bottomNavigationBar: BottomNavigation(
        currentIndex: 3,
        onTap: (index) => BottomNavigationHandler.handleNavigation(context, index),
      ),
      appBar: AppBar(title: Text(localizations.statisticsPageTitle)),
      body: statisticsState.isLoading && statisticsState.chartData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : (statisticsState.error != null
              ? Center(child: Text(statisticsState.error!))
              : _buildStatisticsContent(context, statisticsState, localizations)),
    );
  }

  Widget _buildStatisticsContent(BuildContext context, CallStatisticsState state, AppLocalizations localizations) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFFFB74D), Color(0xFFFF7043)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(localizations.totalBlocked, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(state.blockedCallsCount.toString(), style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  // 【修复】传递 period 参数
                  SizedBox(height: 60, child: StatisticChart(period: _selectedPeriod)),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            const InlineAdaptiveBannerAdWidget(adInfo: AdManager.adaptiveBannerAd),
            
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16,
              shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
              children: [
                StatisticCard(icon: Icons.phone_disabled, iconColor: Colors.blue, backgroundColor: Colors.blue.withOpacity(0.1),
                  title: state.blockedCallsCount.toString(), subtitle: localizations.blockedPhoneLabel, period: localizations.periodWeek),
               // StatisticCard(icon: Icons.sms_failed, iconColor: Colors.purple, backgroundColor: Colors.purple.withOpacity(0.1),
             //     title: state.filteredSmsCount.toString(), subtitle: localizations.filteredSmsLabel, period: localizations.periodWeek),
                StatisticCard(icon: Icons.person_outline, iconColor: Colors.green, backgroundColor: Colors.green.withOpacity(0.1),
                  title: state.allowRulesCount.toString(), subtitle: localizations.whitelistLabel, period: localizations.tabAll),
                StatisticCard(icon: Icons.person_off, iconColor: Colors.red, backgroundColor: Colors.red.withOpacity(0.1),
                  title: state.blockRulesCount.toString(), subtitle: localizations.blacklistLabel, period: localizations.tabAll),
             StatisticCard(icon: Icons.volume_off, iconColor: Colors.orange, backgroundColor: Colors.orange.withOpacity(0.1), title: '${state.silenceRulesCount}', subtitle: AppLocalizations.of(context)!.silentRules, period: AppLocalizations.of(context)!.total),
              ],
            ),
            
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(localizations.blockingTrend, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      _buildPeriodSelector(localizations),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // 【修复】传递 period 参数
                  SizedBox(height: 200, child: StatisticChart(period: _selectedPeriod, showDetailedChart: true)),
                ],
              ),
            ),

            const SizedBox(height: 16),
            const BlockTypeAnalysis(),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector(AppLocalizations localizations) {
    return Row(
      children: [
        _periodButton(localizations.periodWeek, 'Week'),
        const SizedBox(width: 8),
        _periodButton(localizations.periodMonth, 'Month'),
        const SizedBox(width: 8),
        _periodButton(localizations.periodYear, 'Year'),
      ],
    );
  }

  Widget _periodButton(String text, String periodValue) {
    final isSelected = _selectedPeriod == periodValue;
    return InkWell(
      onTap: () {
        if (_selectedPeriod != periodValue) {
            setState(() => _selectedPeriod = periodValue);
            // 调用 Notifier 的方法来刷新数据
            ref.read(callStatisticsProvider.notifier).updateTimeRange(periodValue);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(text, style: TextStyle(color: isSelected ? Theme.of(context).primaryColor : Colors.grey)),
      ),
    );
  }
}