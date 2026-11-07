import 'package:material_ui/material_ui.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

class AudioCard extends StatelessWidget {
  final MediaEntity entity;
  final bool isSelected;

  const AudioCard({
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

  String _resolveSubtitle(String artist, String album) {
    if (artist.isNotEmpty && album.isNotEmpty) {
      return '$artist • $album';
    }
    if (artist.isNotEmpty) {
      return artist;
    }
    return album;
  }

  @override
  Widget build(BuildContext context) {
    final title = entity.title;
    final artist = AuthorFormatter.formatAuthorName(entity.creators, defaultName: '');
    final album = entity.album ?? '';
    final desc = entity.description ?? '';
    final dateStr = _extractDisplayDate();

    final typeTag = _resolveTypeTag(context);
    final sourceName = _resolveSourceName();
    final subTitle = _resolveSubtitle(artist, album);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final cardBg = colorScheme.surfaceContainerLow;
    final borderCol = colorScheme.outlineVariant;
    final textPrimary = colorScheme.onSurface;
    final textSecondary = colorScheme.onSurfaceVariant;

    VoidCallback? onArtistTap;
    if (artist.isNotEmpty) {
      onArtistTap = () {
        final authorParams = AuthorFormatter.formatAuthorParams(entity.creators);
        authorParams[RenderActionTokens.paramSourceId] = entity.sourceId;
        authorParams[RenderActionTokens.paramContentType] = entity.type.name;

        String authorId = artist;
        final rawId = authorParams[RenderActionTokens.paramId];
        if (rawId != null) {
          authorId = rawId.toString();
        }

        String? coverUrlStr;
        final rawAvatar = authorParams[RenderActionTokens.paramAvatar];
        if (rawAvatar != null) {
          coverUrlStr = rawAvatar.toString();
        }

        context.navigate(
          RouteToken.authorProfile,
          MediaEntity(
            id: authorId,
            type: entity.type,
            title: artist,
            coverUrl: coverUrlStr,
            sourceId: entity.sourceId,
            contentUrl: entity.contentUrl,
          ),
        );
      };
    }

    return GestureDetector(
      onTap: () {
        context.navigateEntity(entity, RouteToken.audioDetail);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderCol.withValues(alpha: 0.6)),
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
                  child: Icon(Icons.music_note_rounded, color: colorScheme.primary, size: 28),
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
                      if (subTitle.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: onArtistTap,
                          child: Text(
                            subTitle,
                            style: TextStyle(color: textSecondary, fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
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
