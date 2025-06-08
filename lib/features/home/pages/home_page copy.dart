import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/features/home/widgets/filter_management_widget.dart';
import 'package:yourcallyourrule/features/search/services/search_service.dart';
import 'package:yourcallyourrule/features/search/widgets/search_result_item.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/presentation/verification_page.dart';
import 'package:yourcallyourrule/features/call/caller_id/presentation/widgets/callerid_overlay_mock.dart';

import '../providers/home_stats_provider.dart';
import 'package:yourcallyourrule/features/common/widgets/bottom_navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSearchVisible = false;
  int _currentCardIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  final PageController _pageController = PageController();
  Timer? _autoPlayTimer;
  int _currentIndex = 0; // 当前选中的底部导航项
  List<SearchResult> _searchResults = [];
  Timer? _searchDebounceTimer;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();

    // 加载真实数据
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeStatsProvider>(context, listen: false).loadHomeStats();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _pageController.dispose();
    _autoPlayTimer?.cancel();
    _searchDebounceTimer?.cancel();
    super.dispose();
  }

  void _performSearch(String query) async {
    final searchService = Provider.of<SearchService>(context, listen: false);
    try {
      final results = await searchService.searchPhoneNumber(query);
      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      debugPrint('${AppLocalizations.of(context)!.operationFailure}: $e');
    }
  }

  void _startAutoPlay() {
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentCardIndex < 5) {
        // 修改为6个卡片
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
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF9),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            if (_isSearchVisible && _searchResults.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final result = _searchResults[index];
                    return SearchResultItem(
                      result: result,
                      onTap: () {
                        // 直接处理搜索结果
                        // 关闭搜索框并清除结果
                        setState(() {
                          _isSearchVisible = false;
                          _searchController.clear();
                          _searchResults.clear();
                        });
                        // 导航到搜索页面并传递当前结果的电话号码
                        context.push('/search', extra: result.phoneNumber);
                      },
                    );
                  },
                ),
              )
            else
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildCarouselCards(),
                      _buildRuleVerification(),
                      _buildRuleManagement(),
                      _buildFeatureCenter(),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigation(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        AppRouter.handleNavigation(context, index);
      },
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: _isSearchVisible
                ? TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.search,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            _isSearchVisible = false;
                            _searchController.clear();
                            _searchResults.clear();
                          });
                        },
                      ),
                    ),
                    onChanged: (value) {
                      _searchDebounceTimer?.cancel();
                      _searchDebounceTimer =
                          Timer(const Duration(milliseconds: 500), () {
                        if (value.isNotEmpty) {
                          _performSearch(value); // 保留实时搜索功能，显示可能存在的号码
                        } else {
                          setState(() {
                            _searchResults.clear();
                          });
                        }
                      });
                    },
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        _navigateToSearchPage(value); // 提交搜索时跳转到搜索页面
                      }
                    },
                  )
                : Row(
                    children: [
                      Image.asset(
                        'assets/app_logo.png',
                        width: 32,
                        height: 32,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'YourCall YourRule',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
          ),
          IconButton(
            icon: Icon(_isSearchVisible ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearchVisible = !_isSearchVisible;
                if (!_isSearchVisible) {
                  _searchController.clear();
                  _searchResults.clear();
                }
              });
            },
          ),
          if (_isSearchVisible)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                final searchText = _searchController.text.trim();
                if (searchText.isNotEmpty) {
                  _navigateToSearchPage(searchText); // 点击搜索按钮时跳转到搜索页面
                }
              },
            ),
          if (!_isSearchVisible)
            IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: () {
                // 导航到通知页面
                context.push('/notifications');
              },
            ),
        ],
      ),
    );
  }

  // 导航到搜索页面
  void _navigateToSearchPage(String searchText) {
    // 使用 GoRouter 导航到搜索页面，并传递搜索文本
    context.push('/search', extra: searchText);
  }

  Widget _buildCarouselCards() {
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
          
          //广告卡片
          const InlineAdaptiveBannerAdWidget(
            adInfo: AdManager.adaptiveBannerAd,
            //width: 300,
          ),

          // 添加数据源提醒卡片
          _buildCarouselCard(
            title: AppLocalizations.of(context)!.dataSourceReminder,
            description: AppLocalizations.of(context)!.selectTrustedDataSource,
            value: AppLocalizations.of(context)!.important,
            color: const Color(0xFFFFA726),
            icon: Icons.warning_amber_rounded,
          ),
          // 添加来电显示模拟卡片
          _buildCallerIdMockCard(),
                   //广告卡片
         const InlineAdaptiveBannerAdWidget(
           adInfo: AdManager.adaptiveBannerAd,
           //width: 300,
         ),
          // 添加应用推广卡片
          _buildPromotionCard(),
        ],
      ),
    );
  }

  // 来电显示模拟卡片
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
            // 使用Expanded确保CallerIdSample可以适应卡片大小
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

  // 应用推广卡片
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
            // 应用图片展示
            Center(
              child: Image.asset(
                'assets/images/app_promo.png', // 确保有这个资源文件
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

  Widget _buildRuleVerification() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Text(
              AppLocalizations.of(context)!.ruleVerification,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.enterPhoneNumberToVerify,
                prefixIcon: const Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // 导航到验证页面
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VerificationPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  AppLocalizations.of(context)!.verify,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRuleManagement() {
    // 使用新的FilterManagementWidget替代原有的规则管理UI
    return const FilterManagementWidget();
  }

  Widget _buildRuleItem({
    required String title,
    required IconData icon,
    required Color color,
    required int count,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$count',
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }

  /// 构建带开关的规则项
  Widget _buildRuleItemWithSwitch({
    required String title,
    required IconData icon,
    required Color color,
    required int count,
    required bool isEnabled,
    required Function(bool) onToggle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$count',
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 8),
            Switch(
              value: isEnabled,
              onChanged: onToggle,
              activeColor: color,
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCenter() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.featureCenter,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildFeatureItem(
                  title: AppLocalizations.of(context)!.labelManagement,
                  icon: Icons.label,
                  onTap: () => context.push('/label-management'),
                ),
                _buildFeatureItem(
                  title: AppLocalizations.of(context)!.pluginManagement,
                  icon: Icons.extension,
                  onTap: () => context.push('/plugin-management'),
                ),
                _buildFeatureItem(
                  title: AppLocalizations.of(context)!.allowBlock,
                  icon: Icons.block,
                  onTap: () => context.push('/allowed-blocked'),
                ),
                _buildFeatureItem(
                  title: AppLocalizations.of(context)!.blackWhiteList,
                  icon: Icons.list,
                  onTap: () => context.push('/blacklist-whitelist'),
                ),
                _buildFeatureItem(
                  title: AppLocalizations.of(context)!.regexRules,
                  icon: Icons.code,
                  onTap: () => context.push('/regex-rule'),
                ),
                _buildFeatureItem(
                  title: AppLocalizations.of(context)!.phoneSubscription,
                  icon: Icons.phone_callback,
                  onTap: () => context.push('/phone-subscription'),
                ),
                _buildFeatureItem(
                  title: AppLocalizations.of(context)!.smsSubscription,
                  icon: Icons.sms,
                  onTap: () => context.push('/sms-subscription'),
                ),
                _buildFeatureItem(
                  title: AppLocalizations.of(context)!.smsManagement,
                  icon: Icons.message,
                  onTap: () => context.push('/sms-management'),
                ),
                _buildFeatureItem(
                  title: AppLocalizations.of(context)!.callHistory,
                  icon: Icons.call,
                  onTap: () => context.push('/call-logs'),
                ),
                _buildFeatureItem(
                  title: AppLocalizations.of(context)!.contacts,
                  icon: Icons.contacts,
                  onTap: () => context.push('/contacts'),
                ),
                _buildFeatureItem(
                  title: AppLocalizations.of(context)!.statistics,
                  icon: Icons.bar_chart,
                  onTap: () => context.push('/statistics'),
                ),
                _buildFeatureItem(
                  title: AppLocalizations.of(context)!.settings,
                  icon: Icons.settings,
                  onTap: () => context.push('/settings'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Theme.of(context).primaryColor),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
