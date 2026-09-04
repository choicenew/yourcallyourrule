import 'package:flutter/material.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class VoteProgressBar extends StatelessWidget {
  final int supportCount;
  final int opposeCount;

  const VoteProgressBar({
    super.key,
    required this.supportCount,
    required this.opposeCount,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final total = supportCount + opposeCount;
    if (total == 0) return const SizedBox.shrink();

    final supportRatio = supportCount / total;

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Container(
            height: 6,
            color: Colors.redAccent.withValues(alpha: 0.25),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: supportRatio,
              child: Container(
                color: EliteDopamineTheme.freshMint,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.supportCount(supportCount),
              style: const TextStyle(
                color: EliteDopamineTheme.freshMint,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              l10n.opposeCount(opposeCount),
              style: const TextStyle(
                color: Colors.redAccent,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
