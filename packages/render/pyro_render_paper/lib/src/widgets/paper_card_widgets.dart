import 'package:material_ui/material_ui.dart';

/// 学术论文卡片头部组件
class PaperCardHeader extends StatelessWidget {
  final String title;
  final String venue;
  final String year;

  const PaperCardHeader({
    super.key,
    required this.title,
    required this.venue,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (venue.isNotEmpty || year.isNotEmpty) ...[
          Row(
            children: [
              if (venue.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    venue,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
              if (venue.isNotEmpty && year.isNotEmpty) const SizedBox(width: 6),
              if (year.isNotEmpty)
                Text(
                  year,
                  style: TextStyle(
                    fontSize: 11,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
        ],
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
            height: 1.3,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
