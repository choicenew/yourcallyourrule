import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class ElitePrimaryFilterCard extends ConsumerStatefulWidget {
  const ElitePrimaryFilterCard({super.key});

  @override
  ConsumerState<ElitePrimaryFilterCard> createState() => _ElitePrimaryFilterCardState();
}

class _ElitePrimaryFilterCardState extends ConsumerState<ElitePrimaryFilterCard> {
  int _selectedDefenseLevel = 0; // 0: Smart Shield, 1: Strict Defense, 2: Silent Tag

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: EliteDopamineTheme.dopamineCardDecoration(
        context: context,
        glowColor: EliteDopamineTheme.electricViolet,
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题与管理跳转
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [EliteDopamineTheme.electricViolet, EliteDopamineTheme.neonCyan],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.tune_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n?.filterControlTitle ?? 'Defense Mode',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'Direct level-1 protection profile',
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: () => context.push('/filter-settings'),
                icon: const Icon(Icons.settings_suggest_rounded, size: 16),
                label: const Text('Custom', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                style: TextButton.styleFrom(
                  foregroundColor: EliteDopamineTheme.neonCyan,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 三大直观防御档位选择器（去折叠化一级 UI）
          Row(
            children: [
              Expanded(
                child: _buildDefenseOption(
                  index: 0,
                  title: 'Smart Shield',
                  subtitle: 'Auto Scam & Spam',
                  icon: Icons.shield_rounded,
                  activeColor: EliteDopamineTheme.emeraldGreen,
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildDefenseOption(
                  index: 1,
                  title: 'Strict Mode',
                  subtitle: 'Block Unknowns',
                  icon: Icons.gpp_bad_rounded,
                  activeColor: EliteDopamineTheme.sunsetOrange,
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildDefenseOption(
                  index: 2,
                  title: 'Tag & Silence',
                  subtitle: 'Mute & Log Only',
                  icon: Icons.notifications_paused_rounded,
                  activeColor: EliteDopamineTheme.neonCyan,
                  isDark: isDark,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // 底部当前生效策略简报与 SIM 卡快捷入口
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withValues(alpha: 0.04) : Colors.grey[100],
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline_rounded,
                  size: 16,
                  color: EliteDopamineTheme.neonCyan,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _selectedDefenseLevel == 0
                        ? 'Standard defense: Cloud AI + community database active'
                        : _selectedDefenseLevel == 1
                            ? 'Strict defense: Automatically rejecting high frequency unknown calls'
                            : 'Silent defense: Show notifications and log without hanging up',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.grey[300] : Colors.grey[700],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => context.push('/sim-slot-rule-with-ads/0'),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.sim_card_outlined, size: 14, color: EliteDopamineTheme.electricViolet),
                        SizedBox(width: 2),
                        Text(
                          'SIM Rules',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: EliteDopamineTheme.electricViolet,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefenseOption({
    required int index,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color activeColor,
    required bool isDark,
  }) {
    final isSelected = _selectedDefenseLevel == index;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedDefenseLevel = index;
          });
        },
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? activeColor.withValues(alpha: isDark ? 0.2 : 0.12)
                : (isDark ? Colors.white.withValues(alpha: 0.03) : Colors.grey[50]),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? activeColor
                  : (isDark ? Colors.white.withValues(alpha: 0.08) : Colors.grey[300]!),
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: activeColor.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected
                    ? activeColor
                    : (isDark ? Colors.grey[400] : Colors.grey[600]),
                size: 24,
              ),
              const SizedBox(height: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: isSelected
                      ? (isDark ? Colors.white : Colors.black87)
                      : (isDark ? Colors.grey[300] : Colors.grey[700]),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.grey[400] : Colors.grey[500],
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
