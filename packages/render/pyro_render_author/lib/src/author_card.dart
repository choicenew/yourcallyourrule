import 'package:material_ui/material_ui.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

/// 高质感创作者/作者卡片 Widget (基于 MediaEntity 强类型，0 三元运算，100% 标准国际化)
class AuthorCard extends StatelessWidget {
  final MediaEntity entity;
  final bool isSelected;

  const AuthorCard({
    super.key,
    required this.entity,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final name = entity.title;
    final bio = entity.description ?? '';
    final worksCount = entity.totalChapters ?? 0;
    final followersCount = entity.wordCount ?? 0;

    String avatar = '';
    if (entity.coverUrl != null && entity.coverUrl!.isNotEmpty) {
      avatar = entity.coverUrl!;
    } else if (entity.thumbUrl != null) {
      avatar = entity.thumbUrl!;
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final cardBg = colorScheme.surfaceContainerLow;
    final borderCol = colorScheme.outlineVariant;
    final textPrimary = colorScheme.onSurface;
    final textSecondary = colorScheme.onSurfaceVariant;

    Widget? avatarChild;
    if (avatar.isEmpty) {
      String firstLetter = '';
      if (name.isNotEmpty) {
        firstLetter = name[0].toUpperCase();
      }
      avatarChild = Text(
        firstLetter,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: colorScheme.primary,
        ),
      );
    }

    ImageProvider? avatarBg;
    if (avatar.isNotEmpty) {
      avatarBg = NetworkImage(avatar);
    }

    return GestureDetector(
      onTap: () {
        context.navigateEntity(entity, RouteToken.authorProfile);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderCol.withValues(alpha: 0.5)),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: colorScheme.primary.withValues(alpha: 0.15),
              backgroundImage: avatarBg,
              child: avatarChild,
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(width: 4),
                const Icon(Icons.verified, size: 14, color: Color(0xFFFF8C00)),
              ],
            ),

            if (bio.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                bio,
                style: TextStyle(fontSize: 12, color: textSecondary, height: 1.3),
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],

            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem('$worksCount', textPrimary, textSecondary),
                Container(width: 1, height: 20, color: borderCol),
                _buildStatItem('$followersCount', textPrimary, textSecondary),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, Color valColor, Color labelColor) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: valColor)),
      ],
    );
  }
}
