import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/ads/adwidgets/native_ads.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/features/home/pages/carousel_cards.dart';
import 'package:yourcallyourrule/features/home/pages/feature_center.dart';
import 'package:yourcallyourrule/features/home/pages/home_app_bar.dart';
import 'package:yourcallyourrule/features/home/pages/rule_verification_card.dart';
import 'package:yourcallyourrule/features/common/widgets/bottom_navigation.dart';
import 'package:yourcallyourrule/features/home/widgets/vip_promotion_card.dart';

import 'package:yourcallyourrule/features/home/widgets/filter_management_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentIndex = 0; // 当前选中的底部导航项

  /*
 // 【修改】initState 方法被完全移除。
  @override
  void initState() {
    super.initState();

  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    const RuleVerificationCard(),
                    const FilterManagementWidget(),
                    const FeatureCenter(),
                    //插入显示购买页
                    const VipPromotionCard(),

                    nativeAdWidgetMedium(adWidth: 400, adHeight: 320),
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
          BottomNavigationHandler.handleNavigation(context, index);
        },
      ),
    );
  }
}
