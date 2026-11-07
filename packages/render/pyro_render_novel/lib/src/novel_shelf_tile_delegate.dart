import 'package:material_ui/material_ui.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

/// 小说/书籍特质书架卡片渲染代理
class NovelShelfTileDelegate implements ShelfTileDelegate {
  @override
  Object get contentType => MediaType.novel;

  @override
  Widget buildShelfTile(
    BuildContext context,
    MediaEntity entity, {
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primaryColor = colorScheme.primary;
    final titleText = entity.displayTitle;
    final authorText = entity.creators['author'] ?? entity.publisher ?? 'Novel';
    final cover = entity.coverUrl ?? entity.thumbUrl ?? '';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: colorScheme.outlineVariant.withValues(alpha: 0.5),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: double.infinity,
                    color: primaryColor.withValues(alpha: 0.12),
                    child: SafeImageBuilder.buildSafeCoverImage(
                      url: cover,
                      fit: BoxFit.cover,
                      fallbackWidget: Center(
                        child: Icon(
                          Icons.import_contacts_rounded,
                          size: 38,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                titleText,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.person_outline_rounded,
                    size: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      authorText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookShelfTileDelegate extends NovelShelfTileDelegate {
  @override
  Object get contentType => MediaType.book;
}
