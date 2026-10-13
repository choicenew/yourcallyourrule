// -----------------------------------------------------------------------------
// 文件: elite_hero_shield_card.dart
// 描述: Elite 极简通透防护盾牌卡片。使用官方 intl 库处理数值与时间格式化，保持 UI 纯净。
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/features/auto_update/di/auto_update_service_provider.dart';
import 'package:yourcallyourrule/features/caller_id/config/intercept_action.dart';
import 'package:yourcallyourrule/features/caller_id/config/intercept_action_config_provider.dart';
import 'package:yourcallyourrule/features/home/di/home_stats_provider.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// ------------------- Widget 定义 -------------------

class EliteHeroShieldCard extends ConsumerStatefulWidget {
  const EliteHeroShieldCard({super.key});

  @override
  ConsumerState<EliteHeroShieldCard> createState() => _EliteHeroShieldCardState();
}

class _EliteHeroShieldCardState extends ConsumerState<EliteHeroShieldCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;
  final TextEditingController _searchController = TextEditingController();
  
  bool _isRefreshing = false;
  DateTime? _lastUpdatedTime;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.96, end: 1.04).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearchSubmit(String query) {
    final trimmed = query.trim();
    context.pushNamed(
      AppRouter.verificationPage,
      extra: trimmed.isNotEmpty ? trimmed : null,
    );
  }

  Future<void> _handleRefresh() async {
    if (_isRefreshing) return;
    setState(() {
      _isRefreshing = true;
    });

    try {
      final autoUpdateService = ref.read(autoUpdateServiceProvider);
      await autoUpdateService.updateAll();
      ref.invalidate(homeStatsProvider);
      if (mounted) {
        setState(() {
          _lastUpdatedTime = DateTime.now();
        });
      }
    } catch (e) {
      debugPrint('Error updating all subscriptions: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isRefreshing = false;
        });
      }
    }
  }

  String _getActionTitle(BuildContext context, InterceptAction action) {
    final l10n = AppLocalizations.of(context)!;
    switch (action) {
      case InterceptAction.endCall:
        return l10n.endCallImmediately;
      case InterceptAction.answerThenHangup:
        return l10n.answerThenHangup;
      case InterceptAction.silenceNoAnswer:
        return l10n.silenceAndNoAnswer;
    }
  }

  String _getActionDescription(BuildContext context, InterceptAction action) {
    final l10n = AppLocalizations.of(context)!;
    switch (action) {
      case InterceptAction.endCall:
        return l10n.blockActionDescription;
      case InterceptAction.answerThenHangup:
        return l10n.answerThenHangupDescription;
      case InterceptAction.silenceNoAnswer:
        return l10n.silenceActionDescription;
    }
  }

  Color _getActionColor(InterceptAction action) {
    switch (action) {
      case InterceptAction.endCall:
        return EliteDopamineTheme.vibrantCoral;
      case InterceptAction.answerThenHangup:
        return EliteDopamineTheme.sunsetTangerine;
      case InterceptAction.silenceNoAnswer:
        return EliteDopamineTheme.skyAzure;
    }
  }

  IconData _getActionIcon(InterceptAction action) {
    switch (action) {
      case InterceptAction.endCall:
        return Icons.phone_disabled_rounded;
      case InterceptAction.answerThenHangup:
        return Icons.call_end_rounded;
      case InterceptAction.silenceNoAnswer:
        return Icons.notifications_off_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncStats = ref.watch(homeStatsProvider);
    final currentAction = ref.watch(interceptActionConfigProvider);
    final l10n = AppLocalizations.of(context)!;

    final blockedToday = asyncStats.value?.todayBlocked ?? 0;
    final totalRules = asyncStats.value?.totalRules ?? 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      decoration: EliteDopamineTheme.cleanCardDecoration(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 顶部：能量盾 + 国际化标题 + 真实数据库规则统计与全量更新按钮
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 动态脉冲盾牌（左侧）
                  AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _pulseAnimation.value,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: EliteDopamineTheme.shieldMintGradient,
                            boxShadow: [
                              BoxShadow(
                                color: EliteDopamineTheme.freshMint.withValues(alpha: 0.30),
                                blurRadius: 16,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.verified_user_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 14),
                  // 右侧动态信息栏
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.smartCallerId,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: EliteDopamineTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          l10n.callFilterRulesDescription,
                          style: const TextStyle(
                            fontSize: 11,
                            color: EliteDopamineTheme.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // 动态数据指标与全量更新按钮 (使用标准 intl 库处理数值格式化)
                        Row(
                          children: [
                            // 今日拦截数
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: EliteDopamineTheme.redBadgeBg,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.block_rounded,
                                size: 14,
                                color: EliteDopamineTheme.redIcon,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  NumberFormat.decimalPattern().format(blockedToday),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: EliteDopamineTheme.textPrimary,
                                    height: 1.0,
                                  ),
                                ),
                                Text(
                                  l10n.blockedCalls,
                                  style: const TextStyle(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.w600,
                                    color: EliteDopamineTheme.textSecondary,
                                    height: 1.1,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 12),
                            // 真实规则总数 (来自数据库 totalRules)
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: EliteDopamineTheme.amberBadgeBg,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.inventory_2_rounded,
                                size: 14,
                                color: EliteDopamineTheme.amberIcon,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    NumberFormat.decimalPattern().format(totalRules),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                      color: EliteDopamineTheme.textPrimary,
                                      height: 1.0,
                                    ),
                                  ),
                                  Text(
                                    l10n.phoneRuleManagement,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w600,
                                      color: EliteDopamineTheme.textSecondary,
                                      height: 1.1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 4),
                            // 全量更新按钮
                            Tooltip(
                              message: l10n.updateAllNow,
                              child: InkWell(
                                onTap: _handleRefresh,
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: EliteDopamineTheme.slateSubtle,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: EliteDopamineTheme.slateBorder,
                                      width: 1,
                                    ),
                                  ),
                                  child: _isRefreshing
                                      ? const SizedBox(
                                          width: 14,
                                          height: 14,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                              EliteDopamineTheme.sunsetTangerine,
                                            ),
                                          ),
                                        )
                                      : const Icon(
                                          Icons.refresh_rounded,
                                          size: 14,
                                          color: EliteDopamineTheme.textSecondary,
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // 国际化最后更新时间标记
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: EliteDopamineTheme.slateSubtle,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: EliteDopamineTheme.slateBorder,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.schedule_rounded,
                                size: 11,
                                color: EliteDopamineTheme.textSecondary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                l10n.lastUpdated(DateFormat.Hm().format(_lastUpdatedTime ?? DateTime.now())),
                                style: const TextStyle(
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.w600,
                                  color: EliteDopamineTheme.textBody,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // 拦截动作快捷控制台：使用规范主题与 Slate 面板 Token
              Container(
                margin: const EdgeInsets.only(top: 14),
                padding: const EdgeInsets.all(12),
                decoration: EliteDopamineTheme.insetConsoleDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.interceptionActionSettingsTitle,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: EliteDopamineTheme.textPrimary,
                          ),
                        ),
                        Text(
                          _getActionTitle(context, currentAction),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: _getActionColor(currentAction),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // 3 块并排选择器
                    Row(
                      children: InterceptAction.values.map((action) {
                        final isSelected = action == currentAction;
                        final color = _getActionColor(action);
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => ref
                                .read(interceptActionConfigProvider.notifier)
                                .setInterceptAction(action),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                              decoration: BoxDecoration(
                                color: isSelected ? EliteDopamineTheme.cardSurface : EliteDopamineTheme.slateSubtle,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: isSelected ? color : EliteDopamineTheme.slateMediumBorder,
                                  width: isSelected ? 1.5 : 1,
                                ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: color.withValues(alpha: 0.15),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  if (isSelected)
                                    Positioned(
                                      top: -4,
                                      right: -2,
                                      child: Container(
                                        width: 14,
                                        height: 14,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: color,
                                        ),
                                        child: const Icon(
                                          Icons.check_rounded,
                                          size: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          _getActionIcon(action),
                                          size: 20,
                                          color: isSelected ? color : EliteDopamineTheme.textSecondary,
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          _getActionTitle(context, action),
                                          maxLines: 2,
                                          softWrap: true,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 11,
                                            height: 1.15,
                                            fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                                            color: isSelected ? color : EliteDopamineTheme.textBody,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 8),
                    // 底部联动解释条
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                      decoration: BoxDecoration(
                        color: _getActionColor(currentAction).withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _getActionColor(currentAction).withValues(alpha: 0.18),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            size: 14,
                            color: _getActionColor(currentAction),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              _getActionDescription(context, currentAction),
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: EliteDopamineTheme.textBody,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // 底部：极速查号搜索框 (使用 EliteDopamineTheme 主题装饰)
              Container(
                height: 46,
                decoration: EliteDopamineTheme.amberSearchBoxDecoration(),
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.search_rounded,
                      size: 20,
                      color: EliteDopamineTheme.amberIcon,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(fontSize: 12, color: EliteDopamineTheme.textPrimary),
                        decoration: InputDecoration(
                          hintText: l10n.enterPhoneNumberToStartSearch,
                          hintStyle: const TextStyle(
                            fontSize: 12,
                            color: EliteDopamineTheme.textMuted,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        onSubmitted: _handleSearchSubmit,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _handleSearchSubmit(_searchController.text),
                      child: Container(
                        width: 32,
                        height: 32,
                        margin: const EdgeInsets.only(right: 6),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: EliteDopamineTheme.orangeActionGradient,
                        ),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------- Widget Previewer 支持 -------------------

@Preview(name: 'Hero Shield Card', group: 'Elite Showcase')
Widget previewEliteHeroShieldCard() {
  return const ProviderScope(
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        backgroundColor: EliteDopamineTheme.warmCanvasBackground,
        body: SafeArea(
          child: SingleChildScrollView(
            child: EliteHeroShieldCard(),
          ),
        ),
      ),
    ),
  );
}
