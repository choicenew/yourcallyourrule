import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/call_statistic/data/services/call_statistics_provider.dart';
import 'package:yourcallyourrule/features/call_statistic/domain/statistic_period.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/statistic_chart.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/features/deletion_proposal/providers/statistics_provider.dart';

class CarouselCards extends ConsumerStatefulWidget {
  const CarouselCards({super.key});

  @override
  ConsumerState<CarouselCards> createState() => _CarouselCardsState();
}

class _CarouselCardsState extends ConsumerState<CarouselCards> {
  final PageController _pageController = PageController(viewportFraction: 0.88);
  int _currentPage = 0;
  Timer? _timer;
  String _selectedTimeRange = 'Week';

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!_pageController.hasClients) return;
      final nextPage = (_currentPage + 1) % 5;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(callStatisticsProvider);
    final asyncCommunityStats = ref.watch(proposalStatisticsProvider);

    final List<Widget> cards = [
      _buildCarouselCard(
        title: AppLocalizations.of(context).callBlocking,
        icon: Icons.call_end,
        color: const Color(0xFFE57373),
        description: AppLocalizations.of(context).blockedSpamCalls,
        value: '${state.blockedCallsCount}',
      ),
      asyncCommunityStats.when(
        data: (communityStats) => _buildCarouselCard(
          title: AppLocalizations.of(context).proposalStatistics,
          icon: Icons.groups,
          color: const Color(0xFF4DB6AC),
          onTap: () => GoRouter.of(context).push('/deletions'),
          customContent: _buildCommunityCardContent(communityStats),
        ),
        loading: () => _buildLoadingCard(),
        error: (_, __) => _buildErrorCard(AppLocalizations.of(context).proposalStatistics),
      ),
      const AdsInlineBanner(),
      _buildCarouselCard(
        title: AppLocalizations.of(context).ruleManagement,
        icon: Icons.rule,
        color: const Color(0xFF64B5F6),
        description: AppLocalizations.of(context).createdRules,
        value: '${state.blockRulesCount + state.allowRulesCount}',
      ),
      _buildCarouselCard(
        title: AppLocalizations.of(context).blockingTrend,
        icon: Icons.show_chart,
        color: const Color(0xFF7986CB),
        customContent: _buildTrendChartCardContent(state),
      ),
    ];

    return SizedBox(
      height: 220,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _currentPage = index),
        itemCount: cards.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: cards[index],
        ),
      ),
    );
  }

  Widget _buildCarouselCard({
    required String title,
    required IconData icon,
    required Color color,
    String? description,
    String? value,
    Widget? customContent,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.white, size: 24),
                const SizedBox(width: 8),
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 12),
            if (customContent != null)
              Expanded(child: customContent)
            else ...[
              Text(value ?? '', style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(description ?? '', style: const TextStyle(color: Colors.white70, fontSize: 13)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCommunityCardContent(Map<String, int> stats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Total Proposals: ${stats['totalPending'] ?? 0}', style: const TextStyle(color: Colors.white, fontSize: 14)),
        const SizedBox(height: 4),
        Text('High Risk: ${stats['highRisk'] ?? 0}', style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  Widget _buildTrendChartCardContent(CallStatisticsState state) {
    return SizedBox(
      height: 120,
      child: StatisticChart(
        showDetailedChart: false,
        chartData: state.chartData,
      ),
    );
  }

  Widget _buildLoadingCard() {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(20)),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildErrorCard(String title) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(20)),
      child: Center(child: Text(title, style: const TextStyle(color: Colors.white))),
    );
  }
}
