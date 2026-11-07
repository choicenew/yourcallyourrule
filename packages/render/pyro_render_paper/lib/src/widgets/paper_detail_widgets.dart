import 'package:material_ui/material_ui.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

/// 顶部学术海报 Header 卡片
class PaperDetailHeaderCard extends StatelessWidget {
  final String title;
  final String venue;
  final String doi;
  final String year;
  final String coverUrl;

  const PaperDetailHeaderCard({
    super.key,
    required this.title,
    required this.venue,
    required this.doi,
    required this.year,
    required this.coverUrl,
  });

  Widget _buildFallbackCover(ColorScheme colorScheme, String title) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer.withValues(alpha: 0.6),
            colorScheme.surfaceContainerHighest,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10,
            bottom: -10,
            child: Icon(
              Icons.school_rounded,
              size: 80,
              color: colorScheme.primary.withValues(alpha: 0.12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.school_outlined,
                color: colorScheme.primary,
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textPrim = colorScheme.onSurface;
    final textSec = colorScheme.onSurfaceVariant;
    final accentColor = colorScheme.primary;

    return RepaintBoundary(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.surfaceContainerHigh,
              colorScheme.surfaceContainer,
            ],
          ),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: AspectRatio(
                aspectRatio: 2.2,
                child: SafeImageBuilder.buildSafeCoverImage(
                  url: coverUrl,
                  fallbackWidget: _buildFallbackCover(colorScheme, title),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (venue.isNotEmpty || doi.isNotEmpty || year.isNotEmpty) ...[
              Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  if (venue.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: accentColor.withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        venue,
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  if (year.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFF3B82F6).withValues(alpha: 0.35)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.calendar_today_rounded, size: 11, color: Color(0xFF3B82F6)),
                          const SizedBox(width: 4),
                          Text(
                            year,
                            style: const TextStyle(
                              color: Color(0xFF3B82F6),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (doi.isNotEmpty)
                    Text(
                      '${ActionLocalizerScope.translate(context, id: "doiLabel", defaultText: "DOI: ")}$doi',
                      style: TextStyle(
                        color: textSec,
                        fontSize: 11,
                        fontFamily: 'monospace',
                        letterSpacing: -0.2,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
            ],
            if (title.isNotEmpty)
              Text(
                title,
                style: TextStyle(
                  color: textPrim,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                  letterSpacing: -0.3,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// 顶级学者名片组件
class PaperDetailAuthorBar extends StatelessWidget {
  final String authorName;
  final String authorAvatar;
  final Map<String, dynamic> authorParams;
  final Map<String, dynamic> parentParams;

  const PaperDetailAuthorBar({
    super.key,
    required this.authorName,
    required this.authorAvatar,
    required this.authorParams,
    required this.parentParams,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textPrim = colorScheme.onSurface;
    final textSec = colorScheme.onSurfaceVariant;
    final accentColor = colorScheme.primary;
    final goldAccent = colorScheme.tertiary;

    if (authorName.isEmpty) return const SizedBox.shrink();

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        final Map<String, dynamic> navParams = Map<String, dynamic>.from(authorParams);
        if (parentParams['sourceId'] != null) {
          navParams['sourceId'] = parentParams['sourceId'];
        }
        if (parentParams['pluginId'] != null) {
          navParams['pluginId'] = parentParams['pluginId'];
        }

        context.navigate(
          RouteToken.authorProfile,
          MediaEntity(
            id: navParams['id']?.toString() ?? authorName,
            type: MediaType.academic,
            title: authorName,
            coverUrl: authorAvatar,
            sourceId: parentParams['sourceId']?.toString() ?? '',
            contentUrl: '',
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: goldAccent.withValues(alpha: 0.5), width: 1.5),
              ),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: accentColor.withValues(alpha: 0.15),
                backgroundImage: authorAvatar.trim().isNotEmpty ? NetworkImage(authorAvatar.trim()) : null,
                onBackgroundImageError: authorAvatar.trim().isNotEmpty ? (_, __) {} : null,
                child: (authorAvatar.trim().isEmpty || authorName.trim().isNotEmpty)
                    ? Text(
                        authorName.trim().isNotEmpty ? authorName.trim()[0].toUpperCase() : 'A',
                        style: TextStyle(
                          color: accentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ActionLocalizerScope.translate(context, id: ActionId.read.name, defaultText: 'Author'),
                    style: TextStyle(
                      color: textSec,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    authorName,
                    style: TextStyle(
                      color: textPrim,
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_forward_ios_rounded, size: 13, color: accentColor),
            ),
          ],
        ),
      ),
    );
  }
}

/// 学术摘要卡片
class PaperDetailAbstractCard extends StatelessWidget {
  final String abstractText;

  const PaperDetailAbstractCard({
    super.key,
    required this.abstractText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textPrim = colorScheme.onSurface;
    final accentColor = colorScheme.primary;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.auto_stories_rounded, color: accentColor, size: 18),
              ),
              const SizedBox(width: 12),
              Text(
                ActionLocalizerScope.translate(context, id: 'abstractTitle', defaultText: 'Abstract'),
                style: TextStyle(
                  color: textPrim,
                  fontSize: 16.5,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            abstractText,
            style: TextStyle(
              color: textPrim.withValues(alpha: 0.88),
              fontSize: 14,
              height: 1.7,
              letterSpacing: -0.1,
            ),
          ),
          const SizedBox(height: 90),
        ],
      ),
    );
  }
}
