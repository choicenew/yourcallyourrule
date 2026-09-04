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
    final total = supportCount + opposeCount;
    if (total == 0) return const SizedBox.shrink();

    return Column(
      children: [
        Row(
          children: [
            if (supportCount > 0)
              Expanded(
                flex: supportCount,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: EliteDopamineTheme.freshMint,
                    borderRadius: BorderRadius.horizontal(
                      left: const Radius.circular(2),
                      right: opposeCount == 0 ? const Radius.circular(2) : Radius.zero,
                    ),
                  ),
                ),
              ),
            if (opposeCount > 0)
              Expanded(
                flex: opposeCount,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.horizontal(
                      left: supportCount == 0 ? const Radius.circular(2) : Radius.zero,
                      right: const Radius.circular(2),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${AppLocalizations.of(context)!.support}: $supportCount',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${AppLocalizations.of(context)!.oppose}: $opposeCount',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
