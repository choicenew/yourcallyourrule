import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/features/home/di/home_stats_provider.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class EliteHeroShieldCard extends ConsumerStatefulWidget {
  const EliteHeroShieldCard({super.key});

  @override
  ConsumerState<EliteHeroShieldCard> createState() => _EliteHeroShieldCardState();
}

class _EliteHeroShieldCardState extends ConsumerState<EliteHeroShieldCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncStats = ref.watch(homeStatsProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    final blockedToday = asyncStats.value?.blockedCallsCount ?? 0;
    final totalRules = asyncStats.value?.totalRulesCount ?? 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: EliteDopamineTheme.dopamineCardDecoration(
        context: context,
        glowColor: EliteDopamineTheme.emeraldGreen,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // 背景多巴胺渐变光斑
            Positioned(
              top: -60,
              right: -60,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: EliteDopamineTheme.emeraldGreen.withValues(alpha: isDark ? 0.15 : 0.2),
                ),
              ),
            ),
            Positioned(
              bottom: -40,
              left: -40,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: EliteDopamineTheme.neonCyan.withValues(alpha: isDark ? 0.12 : 0.18),
                ),
              ),
            ),

            // 主体内容
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 上部：动态能量环 + 状态描述
                  Row(
                    children: [
                      // 动态脉冲能量环
                      AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _pulseAnimation.value,
                            child: Container(
                              width: 68,
                              height: 68,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: EliteDopamineTheme.shieldActiveGradient,
                                boxShadow: [
                                  BoxShadow(
                                    color: EliteDopamineTheme.emeraldGreen.withValues(alpha: 0.45),
                                    blurRadius: 18,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.verified_user_rounded,
                                  color: Colors.white,
                                  size: 34,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 18),

                      // 状态文字与标签
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: EliteDopamineTheme.emeraldGreen.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.bolt_rounded,
                                    size: 14,
                                    color: EliteDopamineTheme.emeraldGreen,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'ACTIVE SHIELD',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w900,
                                      color: EliteDopamineTheme.emeraldGreen,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              l10n?.securityDashboardTitle ?? 'Real-time Call Shield',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Live protection running in background',
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark ? Colors.grey[400] : Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // 中部：今日拦截与激活规则成就胶囊
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricTile(
                          context: context,
                          label: 'Blocked Calls',
                          value: '$blockedToday',
                          icon: Icons.shield_outlined,
                          accentColor: EliteDopamineTheme.coralPink,
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildMetricTile(
                          context: context,
                          label: 'Active Rules',
                          value: '$totalRules',
                          icon: Icons.rule_folder_outlined,
                          accentColor: EliteDopamineTheme.neonCyan,
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // 底部：极速查号搜索框（直观搜索验证）
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.black.withValues(alpha: 0.25)
                          : Colors.grey[100],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.08)
                            : Colors.grey[300]!,
                      ),
                    ),
                    child: TextField(
                      controller: _searchController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Quick search or test phone number...',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: isDark ? Colors.grey[500] : Colors.grey[400],
                        ),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          size: 20,
                          color: EliteDopamineTheme.neonCyan,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.arrow_forward_rounded,
                            size: 18,
                            color: EliteDopamineTheme.emeraldGreen,
                          ),
                          onPressed: () {
                            if (_searchController.text.trim().isNotEmpty) {
                              context.push('/search?query=${Uri.encodeComponent(_searchController.text.trim())}');
                            } else {
                              context.push('/verification-page');
                            }
                          },
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      ),
                      onSubmitted: (value) {
                        if (value.trim().isNotEmpty) {
                          context.push('/search?query=${Uri.encodeComponent(value.trim())}');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricTile({
    required BuildContext context,
    required String label,
    required String value,
    required IconData icon,
    required Color accentColor,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: accentColor, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
