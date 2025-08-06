import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/native_ads.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/features/home/pages/carousel_cards.dart';
import 'package:yourcallyourrule/features/home/pages/feature_center.dart';
import 'package:yourcallyourrule/features/home/pages/home_app_bar.dart';
import 'package:yourcallyourrule/features/home/pages/rule_verification_card.dart';
import 'package:yourcallyourrule/features/home/di/home_stats_provider.dart';
import 'package:yourcallyourrule/features/common/widgets/bottom_navigation.dart';
import 'package:yourcallyourrule/features/search/pages/search_page.dart';
import 'package:yourcallyourrule/features/search/widgets/search_widget.dart';


import 'package:yourcallyourrule/features/home/widgets/filter_management_widget.dart';



class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentIndex = 0; // 当前选中的底部导航项

  @override
  void initState() {
    super.initState();

    // 加载真实数据
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeStatsProvider.notifier).loadHomeStats();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF9),
      body: SafeArea(
        child: Column(
          children: [
            const HomeAppBar(),
          //  const SearchWidget(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const CarouselCards(),
                    GoogleAdWidget(adInfo: AdManager.bannerAd),
                    const RuleVerificationCard(),
                                        GoogleAdWidget(adInfo: AdManager.bannerAd),
                    const FilterManagementWidget(),
                                        GoogleAdWidget(adInfo: AdManager.bannerAd),
                    const FeatureCenter(),
                    nativeAdWidgetMedium(adWidth: 320, adHeight: 320)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          AppRouter.handleNavigation(context, index);
        },
      ),
    );
  }
}