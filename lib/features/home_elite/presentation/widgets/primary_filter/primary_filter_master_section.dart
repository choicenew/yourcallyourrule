import 'package:flutter/material.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/primary_filter/defense_strategy_item.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 第二层级：4 个总控与特例胶囊网格组件 (标题软折行防截断排版)
class PrimaryFilterMasterOverridesSection extends StatelessWidget {
  final List<DefenseStrategyItem> masterOptions;
  final int selectedIndex;
  final AppLocalizations l10n;
  final ValueChanged<int> onCardSelected;

  const PrimaryFilterMasterOverridesSection({
    super.key,
    required this.masterOptions,
    required this.selectedIndex,
    required this.l10n,
    required this.onCardSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: EliteDopamineTheme.slateSurface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: EliteDopamineTheme.slateBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.masterAndOverrides,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: EliteDopamineTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            l10n.masterAndOverridesDesc,
            style: const TextStyle(
              fontSize: 9.5,
              color: EliteDopamineTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildPillItem(masterOptions[0])),
              const SizedBox(width: 6),
              Expanded(child: _buildPillItem(masterOptions[1])),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(child: _buildPillItem(masterOptions[2])),
              const SizedBox(width: 6),
              Expanded(child: _buildPillItem(masterOptions[3])),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPillItem(DefenseStrategyItem item) {
    final isSelected = selectedIndex == item.index;

    return GestureDetector(
      onTap: () => onCardSelected(item.index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected
              ? item.activeColor.withValues(alpha: 0.15)
              : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? item.activeColor : EliteDopamineTheme.slateBorder,
            width: isSelected ? 1.6 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: item.activeColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(item.icon, color: item.activeColor, size: 14),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 2,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 10,
                      height: 1.12,
                      fontWeight: FontWeight.w800,
                      color: EliteDopamineTheme.textPrimary,
                    ),
                  ),
                  Text(
                    item.subtitle,
                    maxLines: 2,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 8.5,
                      height: 1.15,
                      color: EliteDopamineTheme.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Transform.scale(
              scale: 0.65,
              child: Switch.adaptive(
                value: item.isEnabled,
                activeColor: item.activeColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: item.onToggle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
