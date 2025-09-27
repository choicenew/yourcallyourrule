import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/features/call/caller_id/presentation/widgets/callerid_overlay_mock.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import '../di/home_stats_provider.dart';

class CarouselCards extends ConsumerStatefulWidget {
  const CarouselCards({super.key});

  @override
  ConsumerState<CarouselCards> createState() => _CarouselCardsState();
}

class _CarouselCardsState extends ConsumerState<CarouselCards> {
  final PageController _pageController = PageController();
  Timer? _autoPlayTimer;

  @override
  void dispose() {
    _pageController.dispose();
    _autoPlayTimer?.cancel();
    super.dispose();
  }

  // 【修改】: 将 Timer 的启动和停止逻辑分离，以便在不同状态下调用
  void _stopAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = null;
  }

  void _startAutoPlay(int totalPages) {
    _stopAutoPlay(); // 先停止，避免创建多个 Timer
    if (totalPages <= 1) return; // 如果只有一页或没有，则不启动

    _autoPlayTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!mounted) return;
      
      final currentPage = _pageController.page?.round() ?? 0;
      final nextPage = (currentPage + 1) % totalPages;
      
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // 在 build 方法顶部只 watch 一次 provider，以优化性能
    final asyncHomeStats = ref.watch(homeStatsProvider);

    return Container(
      height: 180,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: asyncHomeStats.when(
        data: (stats) {
          // 【核心修改】: 动态构建卡片列表，不再硬编码数量
          final List<Widget> cards = [
            _buildCarouselCard(
              title: AppLocalizations.of(context)!.callBlocking,
              description: AppLocalizations.of(context)!.blockedSpamCalls,
              value: '${stats.blockedCalls}',
              color: const Color(0xFFE57373),
              icon: Icons.call_end,
            ),
            _buildCarouselCard(
              title: AppLocalizations.of(context)!.ruleManagement,
              description: AppLocalizations.of(context)!.createdRules,
              value: '${stats.totalRules}',
              color: const Color(0xFF64B5F6),
              icon: Icons.rule,
            ),
            _buildCarouselCard(
              title: AppLocalizations.of(context)!.callStatistics,
              description: AppLocalizations.of(context)!.monthlyCallCount,
              value: '${stats.totalCalls}',
              color: const Color(0xFF81C784),
              icon: Icons.insert_chart,
            ),
            const InlineAdaptiveBannerAdWidget(
              adInfo: AdManager.adaptiveBannerAd,
            ),
            _buildCarouselCard(
              title: AppLocalizations.of(context)!.dataSourceReminder,
              description: AppLocalizations.of(context)!.selectTrustedDataSource,
              value: AppLocalizations.of(context)!.important,
              color: const Color(0xFFFFA726),
              icon: Icons.warning_amber_rounded,
            ),
            _buildCallerIdMockCard(),
            const InlineAdaptiveBannerAdWidget(
              adInfo: AdManager.adaptiveBannerAd,
            ),
            _buildPromotionCard(),
          ];

          // 【关键】: 在 build 之后延迟一帧启动 Timer，确保 PageView 已构建
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_autoPlayTimer == null && cards.isNotEmpty) {
               _startAutoPlay(cards.length);
            }
          });

          return PageView(
            controller: _pageController,
            children: cards,
          );
        },
        loading: () {
          _stopAutoPlay(); // 在加载时停止 Timer
          return _buildLoadingCard();
        },
        error: (error, stack) {
          _stopAutoPlay(); // 在出错时停止 Timer
          return _buildErrorCard(AppLocalizations.of(context)!.statistics);
        },
      ),
    );
  }

  // --- 以下是您原来的辅助方法，保持完整，没有省略 ---

  Widget _buildCarouselCard({
    required String title,
    required String description,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color.withOpacity(0.8), color],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(icon, color: Colors.white),
              ],
            ),
            const Spacer(),
            Text(
              description,
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCallerIdMockCard() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF9575CD), Color(0xFF7986CB)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 4.0),
              child: Text(
                AppLocalizations.of(context)!.callerIdPreview,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: Center(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: const CallerIdSample(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromotionCard() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF26A69A), Color(0xFF00897B)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.ourOtherApps,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.apps, color: Colors.white),
              ],
            ),
            const Spacer(),
            Center(
              child: Image.asset(
                'assets/images/app_promo.png',
                height: 60,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 60,
                    width: 60,
                    color: Colors.white24,
                    child: const Icon(Icons.image_not_supported,
                        color: Colors.white),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
  
  Widget _buildLoadingCard() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.grey.shade300, Colors.grey.shade400],
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
  
  Widget _buildErrorCard(String title) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE57373), Color(0xFFEF5350)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              AppLocalizations.of(context)!.loadDataFailed,
              style: const TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}