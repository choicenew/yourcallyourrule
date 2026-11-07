import 'package:material_ui/material_ui.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

/// 小说详情 Header
class NovelDetailHeader extends StatelessWidget {
  final String title;
  final String author;
  final String coverUrl;

  const NovelDetailHeader({
    super.key,
    required this.title,
    required this.author,
    required this.coverUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: 110,
            height: 150,
            child: SafeImageBuilder.buildSafeCoverImage(
              url: coverUrl,
              fallbackWidget: Container(
                color: colorScheme.surfaceContainerHigh,
                child: Icon(Icons.book_rounded, size: 48, color: colorScheme.primary.withValues(alpha: 0.5)),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colorScheme.onSurface),
              ),
              if (author.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  author,
                  style: TextStyle(fontSize: 13, color: colorScheme.onSurfaceVariant),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
