import 'package:flutter/material.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/primary_filter/defense_strategy_item.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';

/// 第一层级：5 个常用策略大卡片网格
class PrimaryFilterDailyGrid extends StatelessWidget {
  final List<DefenseStrategyItem> dailyOptions;
  final int selectedIndex;
  final ValueChanged<int> onCardSelected;

  const PrimaryFilterDailyGrid({
    super.key,
    required this.dailyOptions,
    required this.selectedIndex,
    required this.onCardSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: _buildCardItem(dailyOptions[0])),
            const SizedBox(width: 8),
            Expanded(child: _buildCardItem(dailyOptions[1])),
            const SizedBox(width: 8),
            Expanded(child: _buildCardItem(dailyOptions[2])),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _buildCardItem(dailyOptions[3])),
            const SizedBox(width: 8),
            Expanded(child: _buildCardItem(dailyOptions[4])),
          ],
        ),
      ],
    );
  }

  Widget _buildCardItem(DefenseStrategyItem item) {
    final isSelected = selectedIndex == item.index;

    return GestureDetector(
      onTap: () => onCardSelected(item.index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected
              ? item.activeColor.withValues(alpha: 0.12)
              : EliteDopamineTheme.slateSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? item.activeColor : EliteDopamineTheme.slateBorder,
            width: isSelected ? 1.8 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: item.activeColor.withValues(alpha: 0.16),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? item.activeColor
                        : item.activeColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Icon(
                    item.icon,
                    color: isSelected ? Colors.white : item.activeColor,
                    size: 15,
                  ),
                ),
                Transform.scale(
                  scale: 0.75,
                  child: Switch.adaptive(
                    value: item.isEnabled,
                    activeColor: item.activeColor,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: item.onToggle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              item.title,
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                height: 1.1,
                fontWeight: FontWeight.w900,
                color: isSelected ? EliteDopamineTheme.textPrimary : EliteDopamineTheme.textBody,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              item.subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 9,
                height: 1.2,
                fontWeight: FontWeight.w500,
                color: EliteDopamineTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
