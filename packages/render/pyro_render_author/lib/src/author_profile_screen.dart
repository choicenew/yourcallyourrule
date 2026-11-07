import 'package:material_ui/material_ui.dart';
import 'package:pyro_action_hub/pyro_action_hub.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

import 'widgets/author_profile_widgets.dart';

/// 全模态创作者/作者主页页面 (基于大一统 MediaEntity 强类型，零硬编码文本)
class AuthorProfileScreen extends StatefulWidget {
  final String authorId;
  final MediaEntity? entity;
  final Map<String, dynamic> initialAuthorData;
  final Map<String, dynamic>? slotParams;
  final VoidCallback? onFollowTap;

  const AuthorProfileScreen({
    super.key,
    required this.authorId,
    this.entity,
    this.initialAuthorData = const {},
    this.slotParams,
    this.onFollowTap,
  });

  @override
  State<AuthorProfileScreen> createState() => _AuthorProfileScreenState();
}

class _AuthorProfileScreenState extends State<AuthorProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final entity = widget.entity ?? MediaEntityMapper.fromMap(widget.initialAuthorData);

    final name = entity.title.isNotEmpty
        ? entity.title
        : widget.authorId;

    final avatar = entity.coverUrl ?? entity.thumbUrl ?? '';
    final banner = entity.coverUrl ?? '';
    final bio = entity.description ?? '';
    final worksCount = entity.totalChapters ?? 0;
    final followersCount = entity.wordCount ?? 0;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return StreamBuilder<List<UserAction>>(
      stream: ActionHub.instance.watchActions(MediaTypeToken.author, widget.authorId),
      builder: (context, snapshot) {
        final actions = snapshot.data ?? [];
        final followAction = actions.where((a) => a.id == ActionId.follow).firstOrNull;
        final isFollowing = followAction?.isActive ?? false;

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppBar(
            title: Text(name),
            elevation: 0,
            backgroundColor: colorScheme.surface,
          ),
          body: ListView(
            padding: EdgeInsets.zero,
            children: [
              AuthorProfileHeader(
                name: name,
                avatarUrl: avatar,
                bannerUrl: banner,
                bio: bio,
                isFollowed: isFollowing,
                onFollowTap: widget.onFollowTap ??
                    () {
                      if (followAction?.intent != null) {
                        ActionHub.instance.dispatchIntent(MediaTypeToken.author, followAction!.intent!);
                      }
                    },
              ),
              const SizedBox(height: 70),
              AuthorProfileStatsBar(
                worksCount: worksCount,
                followersCount: followersCount,
              ),
              if (bio.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Text(
                    bio,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
