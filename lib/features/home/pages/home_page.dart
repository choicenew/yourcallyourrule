import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../models/home_stats_model.dart';
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
  bool _isRuleManagementExpanded = false;
  final TextEditingController _searchController = TextEditingController();
  final PageController _pageController = PageController();
  Timer? _autoPlayTimer;
  int _currentIndex = 0; // 当前选中的底部导航项

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
    super.dispose();
  }

  void _startAutoPlay() {
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentCardIndex < 2) {
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
                      hintText: '搜索...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            _isSearchVisible = false;
                            _searchController.clear();
                          });
                        },
                      ),
                    ),
                  )
                : Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/app_logo.svg',
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
            icon: Icon(_isSearchVisible ? Icons.search : Icons.search),
            onPressed: () {
              setState(() {
                _isSearchVisible = !_isSearchVisible;
              });
            },
          ),
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
            title: '来电拦截',
            description: '已拦截垃圾来电',
            value: '${Provider.of<HomeStatsProvider>(context).stats.blockedCalls}',
            color: const Color(0xFFE57373),
            icon: Icons.call_end,
          ),
          _buildCarouselCard(
            title: '规则管理',
            description: '已创建规则',
            value: '${Provider.of<HomeStatsProvider>(context).stats.totalRules}',
            color: const Color(0xFF64B5F6),
            icon: Icons.rule,
          ),
          _buildCarouselCard(
            title: '通话统计',
            description: '本月通话',
            value: '${Provider.of<HomeStatsProvider>(context).stats.totalCalls}',
            color: const Color(0xFF81C784),
            icon: Icons.insert_chart,
          ),
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
            colors: [color.withValues(alpha:0.8), color],
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
            const Text(
              '规则验证',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: '输入电话号码进行验证',
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
                  // 验证规则逻辑
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  '验证',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRuleManagement() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          ListTile(
            title: const Text(
              '规则管理',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            trailing: IconButton(
              icon: Icon(_isRuleManagementExpanded
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down),
              onPressed: () {
                setState(() {
                  _isRuleManagementExpanded = !_isRuleManagementExpanded;
                });
              },
            ),
          ),
          if (_isRuleManagementExpanded)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildRuleItem(
                    title: '黑名单',
                    icon: Icons.block,
                    color: Colors.red,
                    count: Provider.of<HomeStatsProvider>(context).stats.blacklistRules,
                    onTap: () => context.push('/rules/blacklist'),
                  ),
                  const SizedBox(height: 16),
                  _buildRuleItem(
                    title: '白名单',
                    icon: Icons.check_circle,
                    color: Colors.green,
                    count: Provider.of<HomeStatsProvider>(context).stats.whitelistRules,
                    onTap: () => context.push('/rules/whitelist'),
                  ),
                  const SizedBox(height: 16),
                  _buildRuleItem(
                    title: '时间规则',
                    icon: Icons.access_time,
                    color: Colors.orange,
                    count: Provider.of<HomeStatsProvider>(context).stats.timeRules,
                    onTap: () => context.push('/rules/time'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
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
          color: color.withValues(alpha:0.1),
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
                color: color.withValues(alpha:0.2),
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

  Widget _buildFeatureCenter() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '功能中心',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  title: '通话记录',
                  icon: Icons.call,
                  onTap: () => context.push('/call-logs'),
                ),
                _buildFeatureItem(
                  title: '联系人',
                  icon: Icons.contacts,
                  onTap: () => context.push('/contacts'),
                ),
                _buildFeatureItem(
                  title: '短信',
                  icon: Icons.message,
                  onTap: () => context.push('/messages'),
                ),
                _buildFeatureItem(
                  title: '统计分析',
                  icon: Icons.bar_chart,
                  onTap: () => context.push('/statistics'),
                ),
                _buildFeatureItem(
                  title: '设置',
                  icon: Icons.settings,
                  onTap: () => context.push('/settings'),
                ),
                _buildFeatureItem(
                  title: '更多',
                  icon: Icons.more_horiz,
                  onTap: () => context.push('/more'),
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
          color: Colors.grey.withValues(alpha:0.1),
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