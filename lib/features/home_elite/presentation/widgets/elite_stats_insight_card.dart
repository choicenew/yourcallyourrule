import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/features/call_statistic/data/services/call_statistics_provider.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class EliteStatsInsightCard extends ConsumerStatefulWidget {
  const EliteStatsInsightCard({super.key});

  @override
  ConsumerState<EliteStatsInsightCard> createState() => _EliteStatsInsightCardState();
}

class _EliteStatsInsightCardState extends ConsumerState<EliteStatsInsightCard> {
  String _selectedRange = 'Week';

  @override
  Widget build(BuildContext context) {
    final stats = ref.watch(callStatisticsProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    final totalBlocked = stats.blockedCallsCount;
    final filteredSms = stats.filteredSmsCount;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: EliteDopamineTheme.dopamineCardDecoration(
        context: context,
        glowColor: EliteDopamineTheme.sunsetOrange,
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题与时间切换
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: EliteDopamineTheme.statsCardGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.insights_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n?.statistics ?? 'Defense Insights',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'Time saved: ~${(totalBlocked * 3.5).toInt()} mins',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: EliteDopamineTheme.sunsetOrange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Week / Month 切换胶囊
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withValues(alpha: 0.06) : Colors.grey[200],
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    _buildRangePill('Week', isDark),
                    _buildRangePill('Month', isDark),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // 多巴胺拦截成就柱状/比例条
          Row(
            children: [
              Expanded(
                child: _buildInsightMetric(
                  label: 'Calls Shielded',
                  count: '$totalBlocked',
                  color: EliteDopamineTheme.sunsetOrange,
                  icon: Icons.phone_disabled_rounded,
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInsightMetric(
                  label: 'SMS Filtered',
                  count: '$filteredSms',
                  color: EliteDopamineTheme.electricViolet,
                  icon: Icons.mark_chat_read_rounded,
                  isDark: isDark,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // 拦截类型分布多巴胺进度条
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Interception Type Breakdown',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                  Text(
                    'Live Telemetry',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.grey[500] : Colors.grey[400],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 10,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 60,
                        child: Container(color: EliteDopamineTheme.coralPink),
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        flex: 25,
                        child: Container(color: EliteDopamineTheme.sunsetOrange),
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        flex: 15,
                        child: Container(color: EliteDopamineTheme.neonCyan),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLegendDot('Scam (60%)', EliteDopamineTheme.coralPink, isDark),
                  _buildLegendDot('Spam (25%)', EliteDopamineTheme.sunsetOrange, isDark),
                  _buildLegendDot('Robocall (15%)', EliteDopamineTheme.neonCyan, isDark),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 底部跳转详情
          Center(
            child: TextButton.icon(
              onPressed: () => context.push('/call-statistics'),
              icon: const Icon(Icons.bar_chart_rounded, size: 16),
              label: const Text('Open Detailed Analytics', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
              style: TextButton.styleFrom(
                foregroundColor: EliteDopamineTheme.sunsetOrange,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRangePill(String title, bool isDark) {
    final isSelected = _selectedRange == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRange = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? const Color(0xFF2C2C3E) : Colors.white)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                  ),
                ]
              : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
            color: isSelected
                ? (isDark ? Colors.white : Colors.black87)
                : (isDark ? Colors.grey[400] : Colors.grey[600]),
          ),
        ),
      ),
    );
  }

  Widget _buildInsightMetric({
    required String label,
    required String count,
    required Color color,
    required IconData icon,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.03) : Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  count,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
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

  Widget _buildLegendDot(String label, Color color, bool isDark) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
