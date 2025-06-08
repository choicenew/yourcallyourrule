import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/features/call/caller_id/presentation/widgets/callerid_overlay_mock.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import '../providers/home_stats_provider.dart';

class CarouselCards extends StatefulWidget {
  const CarouselCards({super.key});

  @override
  State<CarouselCards> createState() => _CarouselCardsState();
}

class _CarouselCardsState extends State<CarouselCards> {
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
          _buildCarouselCard(
            title: AppLocalizations.of(context)!.callBlocking,
            description: AppLocalizations.of(context)!.blockedSpamCalls,
            value:
                '${Provider.of<HomeStatsProvider>(context).stats.blockedCalls}',
            color: const Color(0xFFE57373),
            icon: Icons.call_end,
          ),
          _buildCarouselCard(
            title: AppLocalizations.of(context)!.ruleManagement,
            description: AppLocalizations.of(context)!.createdRules,
            value:
                '${Provider.of<HomeStatsProvider>(context).stats.totalRules}',
            color: const Color(0xFF64B5F6),
            icon: Icons.rule,
          ),
          _buildCarouselCard(
            title: AppLocalizations.of(context)!.callStatistics,
            description: AppLocalizations.of(context)!.monthlyCallCount,
            value:
                '${Provider.of<HomeStatsProvider>(context).stats.totalCalls}',
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
}