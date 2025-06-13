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
  int _currentCardIndex = 0;
  final PageController _pageController = PageController();
  Timer? _autoPlayTimer;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoPlayTimer?.cancel();
    super.dispose();
  }

  void _startAutoPlay() {
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentCardIndex < 5) {
        _pageController.animateToPage(
          _currentCardIndex + 1,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentCardIndex = index;
          });
        },
        children: [
          ref.watch(homeStatsProvider).when(
            data: (stats) => _buildCarouselCard(
              title: AppLocalizations.of(context)!.callBlocking,
              description: AppLocalizations.of(context)!.blockedSpamCalls,
              value: '${stats.blockedCalls}',
              color: const Color(0xFFE57373),
              icon: Icons.call_end,
            ),
            loading: () => _buildLoadingCard(),
            error: (_, __) => _buildErrorCard(AppLocalizations.of(context)!.callBlocking),
          ),
          ref.watch(homeStatsProvider).when(
            data: (stats) => _buildCarouselCard(
              title: AppLocalizations.of(context)!.ruleManagement,
              description: AppLocalizations.of(context)!.createdRules,
              value: '${stats.totalRules}',
              color: const Color(0xFF64B5F6),
              icon: Icons.rule,
            ),
            loading: () => _buildLoadingCard(),
            error: (_, __) => _buildErrorCard(AppLocalizations.of(context)!.ruleManagement),
          ),
          ref.watch(homeStatsProvider).when(
            data: (stats) => _buildCarouselCard(
              title: AppLocalizations.of(context)!.callStatistics,
              description: AppLocalizations.of(context)!.monthlyCallCount,
              value: '${stats.totalCalls}',
              color: const Color(0xFF81C784),
              icon: Icons.insert_chart,
            ),
            loading: () => _buildLoadingCard(),
            error: (_, __) => _buildErrorCard(AppLocalizations.of(context)!.callStatistics),
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
        ],
      ),
    );
  }

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
            colors: [color.withValues(alpha: 0.8), color],
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