import 'package:flutter/material.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/primary_filter/defense_strategy_item.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 选中的策略详情看板条组件
class PrimaryFilterInfoBanner extends StatelessWidget {
  final DefenseStrategyItem currentOption;
  final AppLocalizations l10n;
  final VoidCallback onNavigateSimRules;

  const PrimaryFilterInfoBanner({
    super.key,
    required this.currentOption,
    required this.l10n,
    required this.onNavigateSimRules,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: currentOption.activeColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: currentOption.activeColor.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: 16,
            color: currentOption.activeColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentOption.title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: EliteDopamineTheme.textPrimary,
                  ),
                ),
                Text(
                  currentOption.detailedDesc,
                  style: const TextStyle(
                    fontSize: 9.5,
                    height: 1.2,
                    fontWeight: FontWeight.w500,
                    color: EliteDopamineTheme.textBody,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: onNavigateSimRules,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: EliteDopamineTheme.sunsetTangerine.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.sim_card_outlined,
                    size: 12,
                    color: EliteDopamineTheme.sunsetTangerine,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    l10n.simSlotRules,
                    style: const TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w800,
                      color: EliteDopamineTheme.sunsetTangerine,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
