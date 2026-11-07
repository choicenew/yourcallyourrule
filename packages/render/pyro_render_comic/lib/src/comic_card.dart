import 'package:material_ui/material_ui.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

/// 漫画/画集高颜值瀑布流海报卡片 (基于 MediaEntity 强类型，0 三元运算，100% 标准国际化)
class ComicCard extends StatelessWidget {
  final MediaEntity entity;
  final bool isSelected;

  const ComicCard({
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

  @override
  Widget build(BuildContext context) {
    final title = entity.title;
    final authorStr = AuthorFormatter.formatAuthorName(entity.creators, defaultName: '');
    final authorAvatar = AuthorFormatter.formatAuthorAvatar(entity.creators);
    final authorParams = AuthorFormatter.formatAuthorParams(entity.creators);
    final coverUrl = entity.coverUrl ?? entity.thumbUrl ?? '';
    final typeTag = _resolveTypeTag(context);
    final desc = entity.description ?? '';
    final dateStr = _extractDisplayDate();
    final sourceName = _resolveSourceName();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final cardBg = colorScheme.surfaceContainerLow;
    final borderCol = colorScheme.outlineVariant;
    final textPrimary = colorScheme.onSurface;
    final textSecondary = colorScheme.onSurfaceVariant;

    Widget? avatarChild;
    if (authorAvatar.isEmpty) {
      String initial = '';
      if (authorStr.isNotEmpty) {
        initial = authorStr[0].toUpperCase();
      }
      avatarChild = Text(
        initial,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: colorScheme.primary,
        ),
      );
    }

    ImageProvider? avatarBg;
    if (authorAvatar.isNotEmpty) {
      avatarBg = NetworkImage(authorAvatar);
    }

    return GestureDetector(
      onTap: () {
        context.navigateEntity(entity, RouteToken.comicDetail);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primaryContainer.withValues(alpha: 0.25)
              : cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? colorScheme.primary : borderCol.withValues(alpha: 0.6),
            width: isSelected ? 1.2 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? colorScheme.primary.withValues(alpha: 0.12)
                  : colorScheme.shadow.withValues(alpha: 0.08),
              blurRadius: isSelected ? 10 : 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 0.85,
                    child: SafeImageBuilder.buildSafeCoverImage(
                      url: coverUrl,
                      fallbackWidget: _buildFallbackCover(),
                    ),
                  ),
                  if (typeTag.isNotEmpty)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.65),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.palette_rounded,
                              size: 12,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              typeTag.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (dateStr.isNotEmpty)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.65),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          dateStr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        height: 1.25,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (desc.isNotEmpty) ...[
                      const SizedBox(height: 4),
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
                    const SizedBox(height: 8),

                    if (authorStr.isNotEmpty)
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          final Map<String, dynamic> navParams = Map<String, dynamic>.from(authorParams);
                          navParams[RenderActionTokens.paramSourceId] = entity.sourceId;
                          navParams[RenderActionTokens.paramContentType] = entity.type.name;

                          String authorId = authorStr;
                          final rawId = navParams[RenderActionTokens.paramId];
                          if (rawId != null) {
                            authorId = rawId.toString();
                          }

                          context.navigate(
                            RouteToken.authorProfile,
                            MediaEntity(
                              id: authorId,
                              type: entity.type,
                              title: authorStr,
                              coverUrl: authorAvatar,
                              sourceId: entity.sourceId,
                              contentUrl: entity.contentUrl,
                            ),
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 13,
                              backgroundColor: colorScheme.primary.withValues(alpha: 0.25),
                              backgroundImage: avatarBg,
                              child: avatarChild,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                authorStr,
                                style: TextStyle(
                                  color: textSecondary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),

                    if (sourceName.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.source_rounded, size: 11, color: textSecondary),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              sourceName,
                              style: TextStyle(
                                color: textSecondary,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackCover() {
    return Builder(
      builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colorScheme.surfaceContainerHigh, colorScheme.surfaceContainerLow],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Icon(
              Icons.auto_awesome_motion_rounded,
              color: colorScheme.primary,
              size: 36,
            ),
          ),
        );
      },
    );
  }
}
