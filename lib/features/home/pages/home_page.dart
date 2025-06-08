import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/features/home/pages/carousel_cards.dart';
import 'package:yourcallyourrule/features/home/pages/feature_center.dart';
import 'package:yourcallyourrule/features/home/pages/home_app_bar.dart';
import 'package:yourcallyourrule/features/home/pages/rule_verification_card.dart';
import 'package:yourcallyourrule/features/home/providers/home_stats_provider.dart';
import 'package:yourcallyourrule/features/common/widgets/bottom_navigation.dart';


import 'package:yourcallyourrule/features/home/widgets/filter_management_widget.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // 当前选中的底部导航项

  @override
  void initState() {
    super.initState();

    // 加载真实数据
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeStatsProvider>(context, listen: false).loadHomeStats();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF9),
      body: const SafeArea(
        child: Column(
          children: [
            HomeAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CarouselCards(),
                    RuleVerificationCard(),
                    FilterManagementWidget(),
                    FeatureCenter(),
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