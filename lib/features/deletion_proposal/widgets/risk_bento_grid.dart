import 'package:flutter/material.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 系统主题 · 风险等级 3D 异形 Bento 三宫格独立微组件
class RiskBentoGrid extends StatelessWidget {
  final int highRisk;
  final int mediumRisk;
  final int lowRisk;

  const RiskBentoGrid({
    super.key,
    required this.highRisk,
    required this.mediumRisk,
    required this.lowRisk,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Row(
      children: [
        Expanded(
          child: _buildRiskBentoCard(
            context,
            l10n.highRisk,
            highRisk,
            l10n.scamFraud,
            '>80%',
            'P0',
            Icons.warning_amber_rounded,
            theme.colorScheme.error,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildRiskBentoCard(
            context,
            l10n.mediumRisk,
            mediumRisk,
            l10n.aiMarketing,
            '>50%',
            'P1',
            Icons.info_outline_rounded,
            theme.colorScheme.tertiary,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildRiskBentoCard(
            context,
            l10n.lowRisk,
            lowRisk,
            l10n.falsePositiveClean,
            'OK',
            'P2',
            Icons.check_circle_outline_rounded,
            theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildRiskBentoCard(
    BuildContext context,
    String title,
    int count,
    String typeLabel,
    String thresholdLabel,
    String priorityTag,
    IconData icon,
    Color color,
  ) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: color.withValues(alpha: 0.25),
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 16,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  priorityTag,
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: theme.colorScheme.onSurface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            typeLabel,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
