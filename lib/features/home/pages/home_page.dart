import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/home/pages/carousel_cards.dart';
import 'package:yourcallyourrule/features/home/pages/feature_center.dart';
import 'package:yourcallyourrule/features/home/pages/home_app_bar.dart';
import 'package:yourcallyourrule/features/home/pages/rule_verification_card.dart';
import 'package:yourcallyourrule/features/common/router/app_router.dart';
import 'package:yourcallyourrule/features/common/widgets/bottom_navigation.dart';
import 'package:yourcallyourrule/features/home/widgets/vip_promotion_card.dart';
import 'package:yourcallyourrule/features/home/widgets/filter_management_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const HomeAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    CarouselCards(),
                    RuleVerificationCard(),
                    FilterManagementWidget(),
                    FeatureCenter(),
                    VipPromotionCard(),
                    AdsInlineBanner(),
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
          AppRouter.navigateToTab(context, index);
        },
      ),
    );
  }
}
