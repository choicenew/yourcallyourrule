import 'package:flutter/material.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class ProposalRiskChip extends StatelessWidget {
  final int riskLevel;

  const ProposalRiskChip({super.key, required this.riskLevel});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Color color;
    String label;

    switch (riskLevel) {
      case 5:
        color = Colors.redAccent;
        label = l10n.riskLevelCritical;
        break;
      case 4:
        color = Colors.orangeAccent;
        label = l10n.riskLevelHigh;
        break;
      case 3:
        color = Colors.amber;
        label = l10n.riskLevelMedium;
        break;
      case 2:
        color = Colors.lightGreen;
        label = l10n.riskLevelLow;
        break;
      case 1:
        color = EliteDopamineTheme.freshMint;
        label = l10n.riskLevelVeryLow;
        break;
      default:
        color = Colors.grey;
        label = l10n.unknown;
    }

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
