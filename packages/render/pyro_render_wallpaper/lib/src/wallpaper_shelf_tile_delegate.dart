import 'package:material_ui/material_ui.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

/// 壁纸/图片特质书架卡片渲染代理
class WallpaperShelfTileDelegate implements ShelfTileDelegate {
  @override
  Object get contentType => MediaType.wallpaper;

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
    final cover = entity.coverUrl ?? entity.thumbUrl ?? entity.contentUrl;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Positioned.fill(
                  child: SafeImageBuilder.buildSafeCoverImage(
                    url: cover,
                    fit: BoxFit.cover,
                    fallbackWidget: Container(
                      color: colorScheme.surfaceContainerHigh,
                      child: Center(
                        child: Icon(
                          Icons.image_rounded,
                          size: 38,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.8),
                        ],
                        stops: const [0.4, 1.0],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titleText,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                        if (entity.resolution != null && entity.resolution!.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            entity.resolution!,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
