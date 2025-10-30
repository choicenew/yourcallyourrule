// -----------------------------------------------------------------------------
// 文件: carousel_cards.dart
// 描述: 主页的轮播卡片组件。
//
// 【最终架构方案】
// 采纳了您的“最大化复用”建议，对核心的 `_buildCarouselCard` 方法进行了重构。
//
// 1.  `_buildCarouselCard` 现在是一个通用的“卡片外壳”模板。
//     它负责所有卡片共有的UI元素：背景、圆角、标题、图标和点击事件。
//
// 2.  新增了一个可选的 `customContent` (Widget) 参数。
//     - 对于内容简单的“标准卡片”，我们像以前一样传递 `description` 和 `value`。
//     - 对于内容复杂的“自定义卡片”（如社区统计），我们则传递一个 `customContent` Widget。
//
// 3.  这种设计兼具了代码的高度复用性和布局的极大灵活性，是最佳的解决方案。
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
import 'package:yourcallyourrule/features/deletion_proposal/providers/statistics_provider.dart';
import '../di/home_stats_provider.dart';


// ------------------- Widget 定义 -------------------

class CarouselCards extends ConsumerStatefulWidget {
  const CarouselCards({super.key});

  @override
  ConsumerState<CarouselCards> createState() => _CarouselCardsState();
}

class _CarouselCardsState extends ConsumerState<CarouselCards> {
  // --- 状态和逻辑 (保持不变) ---
  final PageController _pageController = PageController();
  Timer? _autoPlayTimer;

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
    // 监听所有需要的数据源
    final asyncHomeStats = ref.watch(homeStatsProvider);
    final asyncCommunityStats = ref.watch(proposalStatisticsProvider);

    return Container(
      // 调整高度以适应内容更丰富的卡片
      height: 200, 
      margin: const EdgeInsets.symmetric(vertical: 16),
      
      // 4. 【结构】: 使用外层 `when` 来处理“主数据源”的状态。
      // 这个 `when` 决定了整个轮播组件是显示内容、加载动画还是错误信息。
      child: asyncHomeStats.when(
        
        // --- 状态一: 主数据加载成功 ---
        data: (homeStats) {
          // 主数据已就绪，我们可以构建轮播卡片的列表了。
          final List<Widget> cards = [
            
            // --- 调用方式 1: 构建“标准卡片” ---
            // 只需提供 description 和 value，`_buildCarouselCard` 内部会自动处理布局。
            _buildCarouselCard(
              title: AppLocalizations.of(context)!.callBlocking,
              icon: Icons.call_end,
              color: const Color(0xFFE57373),
              description: AppLocalizations.of(context)!.blockedSpamCalls,
              value: '${homeStats.blockedCalls}',
            ),

            // --- 调用方式 2: 构建“自定义内容卡片” ---
            // 通过 `asyncCommunityStats.when` 来动态决定卡片内容。
            asyncCommunityStats.when(
              data: (communityStats) => _buildCarouselCard(
                title: AppLocalizations.of(context)!.proposalStatistics,
                icon: Icons.groups,
                color: const Color(0xFF4DB6AC),
                onTap: () => GoRouter.of(context).push('/deletions'),
                // 关键点: 我们不传 description/value，而是传入一个由 `_buildCommunityCardContent` 方法构建的自定义Widget。
                customContent: _buildCommunityCardContent(communityStats),
              ),
              loading: () => _buildLoadingCard(height: 200),
              error: (_, __) => _buildErrorCard(AppLocalizations.of(context)!.proposalStatistics, height: 200),
            ),
   // 后续卡片保持不变
   const InlineAdaptiveBannerAdWidget(adInfo: AdManager.adaptiveBannerAd),
            // 再次调用“标准卡片”，展示其复用性。
            _buildCarouselCard(
              title: AppLocalizations.of(context)!.ruleManagement,
              icon: Icons.rule,
              color: const Color(0xFF64B5F6),
              description: AppLocalizations.of(context)!.createdRules,
              value: '${homeStats.totalRules}',
            ),
            
            // 其他卡片保持不变
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
  // --------------------------------------------------------------------------

  /// 【核心重构】: 通用的卡片“外壳”构建方法。
  ///
  /// 它现在接受可选的 `description`/`value` 或一个可选的 `customContent` Widget。
  /// 这使得它既能构建简单的标准卡片，也能容纳复杂的自定义布局。
  Widget _buildCarouselCard({
    required String title,
    required IconData icon,
    required Color color,
    VoidCallback? onTap,
    String? description,
    String? value,
    Widget? customContent,
  }) {
    // 这个断言确保了组件被正确使用：要么提供标准内容，要么提供自定义内容，但不能同时提供或都不提供。
    assert((description != null && value != null && customContent == null) ||
           (customContent != null && description == null && value == null),
           'Either provide (description and value) OR provide customContent. Not both, not neither.');

    return GestureDetector(
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
              // --- 1. 顶部标题栏 (所有卡片共用) ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  Icon(icon, color: Colors.white),
                ],
              ),
              
              // --- 2. 动态内容区 (核心逻辑) ---
              Expanded(
                // 如果 `customContent` 不为空，就渲染它。
                child: customContent ?? 
                // 否则，渲染由 `description` 和 `value` 构成的标准布局。
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Text(description!, style: const TextStyle(color: Colors.white70)),
                    const SizedBox(height: 8),
                    Text(value!, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 【新增】: 专门构建社区卡片“内容”的辅助方法。
  ///
  /// 这个方法只负责构建卡片的“内心”，它返回的Widget将被注入到 `_buildCarouselCard` 的 `customContent` 中。
  /// 为了匹配图片，背景色改为透明或白色系，因为背景渐变由外壳提供。
  Widget _buildCommunityCardContent(Map<String, dynamic> stats) {
    // 从数据中安全地提取值
    final highRisk = stats['highRisk'] ?? 0;
    final mediumRisk = stats['mediumRisk'] ?? 0;
    final lowRisk = stats['lowRisk'] ?? 0;
    final totalPending = stats['totalPending'] ?? 0;
    
    // 使用白色或半透明白色作为文本颜色，以确保在渐变背景上清晰可见。
    const textColor = Colors.white;
    final subTextColor = Colors.white.withOpacity(0.8);

    return SingleChildScrollView( // 使用 SingleChildScrollView 防止内容在小屏幕上溢出
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0), // 与标题留出间距
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 总览区域
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.totalPendingProposals,
                  style: TextStyle(color: subTextColor, fontSize: 14),
                ),
                const Spacer(),
                Text(
                  '$totalPending',
                  style: const TextStyle(color: textColor, fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(color: Colors.white.withOpacity(0.2)),
            const SizedBox(height: 10),
            // 风险分布区域
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildRiskColumn(label: AppLocalizations.of(context)!.highRisk, value: '$highRisk', color: const Color(0xFFFFCDD2)), // 浅红色
                _buildRiskColumn(label: AppLocalizations.of(context)!.mediumRisk, value: '$mediumRisk', color: const Color(0xFFFFE0B2)), // 浅橙色
                _buildRiskColumn(label: AppLocalizations.of(context)!.lowRisk, value: '$lowRisk', color: const Color(0xFFC8E6C9)), // 浅绿色
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 构建风险分布列的辅助方法
  Widget _buildRiskColumn({required String label, required String value, required Color color}) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }

  // --- 其他辅助方法 (完整无省略) ---
  
  Widget _buildLoadingCard({double? height}) {
    return SizedBox(
      height: height,
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
              colors: [Colors.grey.shade300, Colors.grey.shade400],
            ),
          ),
          child: const Center(child: CircularProgressIndicator(color: Colors.white)),
        ),
      ),
    );
  }
  
  Widget _buildErrorCard(String title, {double? height}) {
    return SizedBox(
      height: height,
      child: Card(
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
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(AppLocalizations.of(context)!.loadDataFailed, style: const TextStyle(color: Colors.white70), textAlign: TextAlign.center),
            ],
          ),
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
}