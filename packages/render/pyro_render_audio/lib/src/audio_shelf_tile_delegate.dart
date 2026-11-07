import 'package:material_ui/material_ui.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

/// 音频/音乐/播客特质书架卡片渲染代理
class AudioShelfTileDelegate implements ShelfTileDelegate {
  @override
  Object get contentType => MediaType.audio;

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
    final artistText = entity.creators['singer'] ?? entity.creators['author'] ?? entity.album ?? 'Audio';
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
                          Icons.graphic_eq_rounded,
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
                    Icons.music_note_rounded,
                    size: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      artistText,
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
