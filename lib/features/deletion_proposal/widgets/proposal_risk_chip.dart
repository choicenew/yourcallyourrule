import 'package:flutter/material.dart';
import 'package:yourcallyourrule/theme/dopamine_theme_extension.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/risk_level.dart';

/// 删除提议风险等级 Chip 组件（100% 强类型 RiskLevel 枚举）
class ProposalRiskChip extends StatelessWidget {
  final RiskLevel riskLevel;

  const ProposalRiskChip({super.key, required this.riskLevel});

  @override
  Widget build(BuildContext context) {
    final color = riskLevel.getColor(context);
    final label = riskLevel.getLocalizedLabel(context);

    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.shield_outlined, size: 13, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
