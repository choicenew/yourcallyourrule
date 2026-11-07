import 'package:material_ui/material_ui.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';

/// 作者主页 Header 头部卡片与背景横幅
class AuthorProfileHeader extends StatelessWidget {
  final String name;
  final String avatarUrl;
  final String bannerUrl;
  final String bio;
  final bool isFollowed;
  final VoidCallback? onFollowTap;

  const AuthorProfileHeader({
    super.key,
    required this.name,
    required this.avatarUrl,
    required this.bannerUrl,
    required this.bio,
    this.isFollowed = false,
    this.onFollowTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final followText = ActionLocalizerScope.translate(context, id: ActionId.follow.name, defaultText: 'Follow');
    final followingText = ActionLocalizerScope.translate(context, id: 'following', defaultText: 'Following');

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHigh,
            image: bannerUrl.isNotEmpty
                ? DecorationImage(
                    image: NetworkImage(bannerUrl),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          top: 115,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: colorScheme.primary.withValues(alpha: 0.15),
                  backgroundImage: avatarUrl.isNotEmpty ? NetworkImage(avatarUrl) : null,
                  child: avatarUrl.isEmpty
                      ? Text(
                          name.isNotEmpty ? name[0].toUpperCase() : 'A',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        )
                      : null,
                ),
              ),
              if (onFollowTap != null)
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isFollowed ? colorScheme.surfaceContainerHighest : colorScheme.primary,
                    foregroundColor: isFollowed ? colorScheme.onSurfaceVariant : colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: onFollowTap,
                  icon: Icon(isFollowed ? Icons.check_rounded : Icons.add_rounded, size: 18),
                  label: Text(isFollowed ? followingText : followText),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 作者主页数据统计看板栏
class AuthorProfileStatsBar extends StatelessWidget {
  final int worksCount;
  final int followersCount;
  final String rating;

  const AuthorProfileStatsBar({
    super.key,
    this.worksCount = 0,
    this.followersCount = 0,
    this.rating = '4.9',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final worksLabel = ActionLocalizerScope.translate(context, id: 'authorWorks', defaultText: 'Works');
    final followersLabel = ActionLocalizerScope.translate(context, id: 'authorFollowers', defaultText: 'Followers');
    final ratingLabel = ActionLocalizerScope.translate(context, id: 'authorRating', defaultText: 'Rating');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(context, worksLabel, worksCount.toString()),
          _buildDivider(colorScheme),
          _buildStatItem(context, followersLabel, followersCount > 1000 ? '${(followersCount / 1000).toStringAsFixed(1)}k' : followersCount.toString()),
          _buildDivider(colorScheme),
          _buildStatItem(context, ratingLabel, rating),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider(ColorScheme colorScheme) {
    return Container(
      height: 24,
      width: 1,
      color: colorScheme.outlineVariant.withValues(alpha: 0.4),
    );
  }
}
