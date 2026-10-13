// -----------------------------------------------------------------------------
// 文件: elite_hero_shield_card.dart
// 描述: Elite 极简通透防护盾牌卡片。刷新按钮融入 Updated 时间条后侧，不挤压顶部统计文本。
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
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/professional_shield_radar.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// ------------------- Widget 定义 -------------------

class EliteHeroShieldCard extends ConsumerStatefulWidget {
  const EliteHeroShieldCard({super.key});

  @override
  ConsumerState<EliteHeroShieldCard> createState() => _EliteHeroShieldCardState();
}

class _EliteHeroShieldCardState extends ConsumerState<EliteHeroShieldCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  DateTime? _lastUpdatedTime;
  bool _isRefreshing = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _lastUpdatedTime = DateTime.now();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.98, end: 1.02).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _searchController.dispose();
    super.dispose();
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
    } catch (e) {
      debugPrint('一键更新规则失败: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isRefreshing = false;
          _lastUpdatedTime = DateTime.now();
        });
      }
    }
  }

  void _handleSearchSubmit(String value) {
    final query = value.trim();
    if (query.isNotEmpty) {
      context.pushNamed(
        AppRouter.callHistory,
        queryParameters: {'query': query},
      );
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
        return l10n.silenceNoAnswer;
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

  Color _getActionColor(BuildContext context, InterceptAction action) {
    final theme = Theme.of(context);
    switch (action) {
      case InterceptAction.endCall:
        return theme.colorScheme.error;
      case InterceptAction.answerThenHangup:
        return theme.colorScheme.primary;
      case InterceptAction.silenceNoAnswer:
        return theme.colorScheme.secondary;
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
    final theme = Theme.of(context);

    final blockedToday = asyncStats.value?.todayBlocked ?? 0;
    final totalRules = asyncStats.value?.totalRules ?? 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ScaleTransition(
                    scale: _pulseAnimation,
                    child: const ProfessionalShieldRadar(),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.smartCallerId,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          l10n.callFilterRulesDescription,
                          style: TextStyle(
                            fontSize: 11,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.errorContainer.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.block_rounded,
                                size: 14,
                                color: theme.colorScheme.error,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  NumberFormat.decimalPattern().format(blockedToday),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: theme.colorScheme.onSurface,
                                    height: 1.0,
                                  ),
                                ),
                                Text(
                                  l10n.blockedCalls,
                                  style: TextStyle(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.w600,
                                    color: theme.colorScheme.onSurfaceVariant,
                                    height: 1.1,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 14),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.inventory_2_rounded,
                                size: 14,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    NumberFormat.decimalPattern().format(totalRules),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                      color: theme.colorScheme.onSurface,
                                      height: 1.0,
                                    ),
                                  ),
                                  Text(
                                    l10n.phoneRuleManagement,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w600,
                                      color: theme.colorScheme.onSurfaceVariant,
                                      height: 1.1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: theme.colorScheme.outlineVariant,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.schedule_rounded,
                                    size: 11,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    l10n.lastUpdated(DateFormat.Hm().format(_lastUpdatedTime ?? DateTime.now())),
                                    style: TextStyle(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w600,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 6),
                            Tooltip(
                              message: l10n.updateAllNow,
                              child: InkWell(
                                onTap: _handleRefresh,
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.surfaceContainerHighest,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: theme.colorScheme.outlineVariant,
                                      width: 1,
                                    ),
                                  ),
                                  child: _isRefreshing
                                      ? SizedBox(
                                          width: 13,
                                          height: 13,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                              theme.colorScheme.primary,
                                            ),
                                          ),
                                        )
                                      : Icon(
                                          Icons.refresh_rounded,
                                          size: 13,
                                          color: theme.colorScheme.onSurfaceVariant,
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Container(
                margin: const EdgeInsets.only(top: 14),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: theme.colorScheme.outlineVariant,
                    width: 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.interceptionActionSettingsTitle,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          _getActionTitle(context, currentAction),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: _getActionColor(context, currentAction),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: InterceptAction.values.map((action) {
                        final isSelected = action == currentAction;
                        final color = _getActionColor(context, action);
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
                                color: isSelected ? theme.colorScheme.surface : theme.colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: isSelected ? color : theme.colorScheme.outlineVariant,
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
                                          color: isSelected ? color : theme.colorScheme.onSurfaceVariant,
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
                                            color: isSelected ? color : theme.colorScheme.onSurface,
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
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                      decoration: BoxDecoration(
                        color: _getActionColor(context, currentAction).withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _getActionColor(context, currentAction).withValues(alpha: 0.18),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            size: 14,
                            color: _getActionColor(context, currentAction),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              _getActionDescription(context, currentAction),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: theme.colorScheme.onSurface,
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

              Container(
                height: 46,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: theme.colorScheme.primary,
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withValues(alpha: 0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    Icon(
                      Icons.search_rounded,
                      size: 20,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface),
                        decoration: InputDecoration(
                          hintText: l10n.enterPhoneNumberToStartSearch,
                          hintStyle: TextStyle(
                            fontSize: 12,
                            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
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
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.colorScheme.primary,
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: EliteHeroShieldCard(),
          ),
        ),
      ),
    ),
  );
}
