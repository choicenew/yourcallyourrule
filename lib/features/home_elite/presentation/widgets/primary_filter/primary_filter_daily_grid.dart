import 'package:flutter/material.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/widgets/primary_filter/defense_strategy_item.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';

/// 第一层级：5 个常用策略大卡片网格 (精细化字号与内外边距，确保长文案完整展示)
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
            const SizedBox(width: 6),
            Expanded(child: _buildCardItem(dailyOptions[1])),
            const SizedBox(width: 6),
            Expanded(child: _buildCardItem(dailyOptions[2])),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(child: _buildCardItem(dailyOptions[3])),
            const SizedBox(width: 6),
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
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? item.activeColor.withValues(alpha: 0.12)
              : EliteDopamineTheme.slateSurface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? item.activeColor : EliteDopamineTheme.slateBorder,
            width: isSelected ? 1.6 : 1,
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
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? item.activeColor
                        : item.activeColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    item.icon,
                    color: isSelected ? Colors.white : item.activeColor,
                    size: 14,
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
            const SizedBox(height: 4),
            Text(
              item.title,
              maxLines: 2,
              softWrap: true,
              style: TextStyle(
                fontSize: 10,
                height: 1.12,
                fontWeight: FontWeight.w800,
                color: isSelected ? EliteDopamineTheme.textPrimary : EliteDopamineTheme.textBody,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              item.subtitle,
              maxLines: 2,
              softWrap: true,
              style: const TextStyle(
                fontSize: 8.5,
                height: 1.15,
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
