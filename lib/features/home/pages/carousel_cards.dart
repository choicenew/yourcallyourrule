// -----------------------------------------------------------------------------
// 文件: carousel_cards.dart
// 描述: 主页的轮播卡片组件。
//
// 【本次修改核心目标】:
//  - 在现有的轮播卡片中，无缝集成一个新的“社区贡献统计”卡片。
//  - 这个新卡片拥有自己独立的数据源 (来自 proposalStatisticsProvider)。
//  - 在不破坏现有结构和不重复UI代码的前提下，优雅地处理新卡片自身的加载、成功、失败状态。
// -----------------------------------------------------------------------------

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// --- 依赖项导入 ---
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/features/call/caller_id/presentation/widgets/callerid_overlay_mock.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// 1. 【新增】: 导入社区贡献统计所需的数据 Provider。
// 这是我们新卡片的数据来源。
import 'package:yourcallyourrule/features/deletion_proposal/providers/statistics_provider.dart';

// 2. 【新增】: 导入主页统计的数据 Provider。
// 这是原有卡片的数据来源。
import '../di/home_stats_provider.dart';


// ------------------- Widget 定义 -------------------

class CarouselCards extends ConsumerStatefulWidget {
  const CarouselCards({super.key});

  @override
  ConsumerState<CarouselCards> createState() => _CarouselCardsState();
}

class _CarouselCardsState extends ConsumerState<CarouselCards> {
  // --- 状态管理 ---
  final PageController _pageController = PageController();
  Timer? _autoPlayTimer; // 用于控制卡片自动轮播

  @override
  void dispose() {
    // 组件销毁时，清理资源，防止内存泄漏。
    _pageController.dispose();
    _autoPlayTimer?.cancel();
    super.dispose();
  }

  // --- 自动播放逻辑 ---
  
  // 停止自动播放计时器
  void _stopAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = null;
  }

  // 启动自动播放计时器
  void _startAutoPlay(int totalPages) {
    _stopAutoPlay(); // 先停止已有的，确保只有一个计时器在运行。
    if (totalPages <= 1) return; // 如果只有一页或没有，则无需自动播放。

    _autoPlayTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!mounted) return; // 如果组件已卸载，则不执行后续操作。
      
      final currentPage = _pageController.page?.round() ?? 0;
      final nextPage = (currentPage + 1) % totalPages;
      
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }


  // --- 构建UI ---

  @override
  Widget build(BuildContext context) {
    // 3. 【核心修改点 A】: 在 build 方法顶部，同时监听(watch)所有需要的数据源。
    // `ref.watch` 会自动订阅 Provider 的变化，并在数据更新时重建此组件。
    final asyncHomeStats = ref.watch(homeStatsProvider);           // 主数据源，用于渲染大部分统计卡片。
    final asyncCommunityStats = ref.watch(proposalStatisticsProvider); // 新增的数据源，仅用于渲染社区贡献卡片。

    return Container(
      height: 180, // 固定轮播区域的高度
      margin: const EdgeInsets.symmetric(vertical: 16),
      
      // 4. 【结构】: 使用外层 `when` 来处理“主数据源”的状态。
      // 这个 `when` 决定了整个轮播组件是显示内容、加载动画还是错误信息。
      child: asyncHomeStats.when(
        
        // --- 状态一: 主数据加载成功 ---
        data: (homeStats) {
          // 主数据已就绪，我们可以构建轮播卡片的列表了。
          final List<Widget> cards = [

            // 卡片 1: 电话拦截 (数据来自 `homeStats`)
            _buildCarouselCard(
              title: AppLocalizations.of(context)!.callBlocking,
              description: AppLocalizations.of(context)!.blockedSpamCalls,
              value: '${homeStats.blockedCalls}',
              color: const Color(0xFFE57373),
              icon: Icons.call_end,
            ),
            
            // 5. 【核心修改点 B】: 集成新的“社区贡献”卡片。
            // 我们在这里使用一个内联的 `when` 表达式来处理 `asyncCommunityStats` 的状态。
            // 这使得这张卡片可以拥有自己独立的生命周期（加载/成功/失败），而不影响其他卡片。
            asyncCommunityStats.when(
              // 状态 B.1: 社区数据加载成功
              data: (communityStats) => _buildCarouselCard(
                title: AppLocalizations.of(context)!.proposalStatistics,
                description: AppLocalizations.of(context)!.pendingProposals,
                value: '${communityStats['totalPending'] ?? 0}',
                color: const Color(0xFF4DB6AC), // 为新卡片选择一个独特的主题色
                icon: Icons.groups,
                onTap: () => GoRouter.of(context).push('/deletions'), // 添加点击跳转功能
              ),
              // 状态 B.2: 社区数据正在加载
              loading: () => _buildLoadingCard(),
              // 状态 B.3: 社区数据加载失败
              error: (_, __) => _buildErrorCard(AppLocalizations.of(context)!.proposalStatistics),
            ),

            // 卡片 3: 规则管理 (数据来自 `homeStats`)
            _buildCarouselCard(
              title: AppLocalizations.of(context)!.ruleManagement,
              description: AppLocalizations.of(context)!.createdRules,
              value: '${homeStats.totalRules}',
              color: const Color(0xFF64B5F6),
              icon: Icons.rule,
            ),

            // 卡片 4: 通话统计 (数据来自 `homeStats`)
            _buildCarouselCard(
              title: AppLocalizations.of(context)!.callStatistics,
              description: AppLocalizations.of(context)!.monthlyCallCount,
              value: '${homeStats.totalCalls}',
              color: const Color(0xFF81C784),
              icon: Icons.insert_chart,
            ),

            // 后续卡片保持不变
            const InlineAdaptiveBannerAdWidget(adInfo: AdManager.adaptiveBannerAd),
            
            _buildCarouselCard(
              title: AppLocalizations.of(context)!.dataSourceReminder,
              description: AppLocalizations.of(context)!.selectTrustedDataSource,
              value: AppLocalizations.of(context)!.important,
              color: const Color(0xFFFFA726),
              icon: Icons.warning_amber_rounded,
            ),

            _buildCallerIdMockCard(),

            const InlineAdaptiveBannerAdWidget(adInfo: AdManager.adaptiveBannerAd),

            _buildPromotionCard(),
          ];

          // 6. 【逻辑】: 在UI构建完成后，启动自动播放。
          // `addPostFrameCallback` 确保在 Widget 渲染完成后再执行，避免状态问题。
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && _autoPlayTimer == null && cards.isNotEmpty) {
               _startAutoPlay(cards.length);
            }
          });

          // 返回最终的轮播视图
          return PageView(
            controller: _pageController,
            children: cards,
          );
        },
        
        // --- 状态二: 主数据正在加载 ---
        loading: () {
          _stopAutoPlay(); // 加载时停止轮播
          // 整个组件显示一个统一的加载动画
          return _buildLoadingCard();
        },
        
        // --- 状态三: 主数据加载失败 ---
        error: (error, stack) {
          _stopAutoPlay(); // 出错时停止轮播
          // 整个组件显示一个统一的错误提示
          return _buildErrorCard(AppLocalizations.of(context)!.statistics);
        },
      ),
    );
  }


  // --------------------------------------------------------------------------
  // --- UI 构建辅助方法 ---
  // 这些是您原来就有的方法，它们被完美地复用了，无需任何修改。
  // 唯一的微小改动是在 _buildCarouselCard 中增加了 onTap 参数以支持点击。
  // --------------------------------------------------------------------------

  Widget _buildCarouselCard({
    required String title,
    required String description,
    required String value,
    required Color color,
    required IconData icon,
    VoidCallback? onTap, // 【微调】: 增加一个可选的 onTap 回调函数
  }) {
    return GestureDetector( // 【微调】: 使用 GestureDetector 包裹以响应点击
      onTap: onTap,
      child: Card(
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
      ),
    );
  }

  // --- 其他卡片构建方法 (完全保持不变) ---

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
            const Expanded(
              child: Center(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    width: 300, // 给一个固定宽度以优化显示
                    child: CallerIdSample(),
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
          child: CircularProgressIndicator(color: Colors.white),
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