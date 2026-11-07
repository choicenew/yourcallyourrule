import 'package:material_ui/material_ui.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

/// 资讯文章详情页 Header
class NewsDetailHeader extends StatelessWidget {
  final String title;
  final String author;
  final String date;
  final String coverUrl;

  const NewsDetailHeader({
    super.key,
    required this.title,
    required this.author,
    required this.date,
    required this.coverUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: SafeImageBuilder.buildSafeCoverImage(
              url: coverUrl,
              fallbackWidget: Container(
                color: colorScheme.surfaceContainerHigh,
                child: Icon(Icons.newspaper_rounded, size: 48, color: colorScheme.primary.withValues(alpha: 0.5)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: colorScheme.onSurface),
        ),
        if (author.isNotEmpty || date.isNotEmpty) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              if (author.isNotEmpty)
                Text(author, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: colorScheme.primary)),
              if (author.isNotEmpty && date.isNotEmpty) const SizedBox(width: 8),
              if (date.isNotEmpty)
                Text(date, style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant)),
            ],
          ),
        ],
      ],
    );
  }
}
