import 'package:material_ui/material_ui.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

class VideoCard extends StatelessWidget {
  final MediaEntity entity;
  final bool isSelected;

  const VideoCard({
    super.key,
    required this.entity,
    this.isSelected = false,
  });

  String _extractDisplayDate() {
    final pubDate = entity.publishDate?.trim() ?? '';
    if (pubDate.isNotEmpty) {
      return pubDate;
    }
    final updateTime = entity.updateTime ?? entity.createTime;
    if (updateTime != null) {
      return updateTime.toIso8601String().split('T').first;
    }
    return '';
  }

  String _resolveTypeTag(BuildContext context) {
    final category = entity.category?.trim() ?? '';
    if (category.isNotEmpty) {
      return category;
    }
    return entity.type.getLocalizedName(context);
  }

  String _resolveSourceName() {
    final publisher = entity.publisher?.trim() ?? '';
    if (publisher.isNotEmpty) {
      return publisher;
    }
    return entity.sourceId.trim();
  }

  String _resolveDuration() {
    final d = entity.duration;
    if (d == null) {
      return '';
    }
    final minutes = d.inMinutes;
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final title = entity.title;
    final duration = _resolveDuration();
    final author = AuthorFormatter.formatAuthorName(entity.creators, defaultName: '');
    final desc = entity.description ?? '';
    final dateStr = _extractDisplayDate();
    final typeTag = _resolveTypeTag(context);
    final sourceName = _resolveSourceName();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final cardBg = colorScheme.surfaceContainerLow;
    final borderCol = colorScheme.outlineVariant;
    final textPrimary = colorScheme.onSurface;
    final textSecondary = colorScheme.onSurfaceVariant;

    VoidCallback? onAuthorTap;
    if (author.isNotEmpty) {
      onAuthorTap = () {
        final authorParams = AuthorFormatter.formatAuthorParams(entity.creators);
        authorParams[RenderActionTokens.paramSourceId] = entity.sourceId;
        authorParams[RenderActionTokens.paramContentType] = entity.type.name;

        String authorId = author;
        final rawId = authorParams[RenderActionTokens.paramId];
        if (rawId != null) {
          authorId = rawId.toString();
        }

        String? avatarStr;
        final rawAvatar = authorParams[RenderActionTokens.paramAvatar];
        if (rawAvatar != null) {
          avatarStr = rawAvatar.toString();
        }

        context.navigate(
          RouteToken.authorProfile,
          MediaEntity(
            id: authorId,
            type: entity.type,
            title: author,
            coverUrl: avatarStr,
            sourceId: entity.sourceId,
            contentUrl: entity.contentUrl,
          ),
        );
      };
    }

    return GestureDetector(
      onTap: () {
        context.navigateEntity(entity, RouteToken.videoDetail);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderCol.withValues(alpha: 0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.play_arrow_rounded, color: colorScheme.primary, size: 28),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (typeTag.isNotEmpty)
                            Container(
                              margin: const EdgeInsets.only(right: 6),
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: colorScheme.primary.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                typeTag.toUpperCase(),
                                style: TextStyle(
                                  color: colorScheme.primary,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          Expanded(
                            child: Text(
                              title,
                              style: TextStyle(
                                color: textPrimary,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      if (author.isNotEmpty || duration.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            if (author.isNotEmpty)
                              Expanded(
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: onAuthorTap,
                                  child: Text(
                                    author,
                                    style: TextStyle(color: textSecondary, fontSize: 12),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            if (duration.isNotEmpty)
                              Text(
                                duration,
                                style: TextStyle(color: textSecondary, fontSize: 11),
                              ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                if (dateStr.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      dateStr,
                      style: TextStyle(
                        color: textSecondary,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            if (desc.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                desc,
                style: TextStyle(
                  color: textSecondary,
                  fontSize: 11,
                  height: 1.3,
                ),
                maxLines: 15,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (sourceName.isNotEmpty) ...[
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(Icons.source_rounded, size: 11, color: textSecondary),
                  const SizedBox(width: 4),
                  Text(
                    sourceName,
                    style: TextStyle(
                      color: textSecondary,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
