import 'package:material_ui/material_ui.dart';
import 'l10n/generated/app_localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_action_hub/pyro_action_hub.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

import 'wallpaper_intents.dart';

part 'wallpaper_action_provider.g.dart';

@Riverpod(keepAlive: true)
class WallpaperActions extends _$WallpaperActions implements ActionProvider {
  final Map<String, ActionStatus> _downloadStatuses = {};
  final Map<String, bool> _likes = {};
  final Set<String> _precachedIds = {};

  MediaEntity? _getCachedEntity(String cid) {
    return TemporaryCache.getEntity(CacheKeyToken.mediaPrecache(cid));
  }

  @override
  List<UserAction> build(String contentId) {
    final downloadStatus = _downloadStatuses[contentId] ?? ActionStatus.idle;
    final isLiked = _likes[contentId] ?? false;
    final cachedEntity = _getCachedEntity(contentId);

    return [
      UserAction(
        id: ActionId.push,
        icon: Icons.cloud_upload_rounded,
        label: ActionId.push.name,
        order: 1000,
        intent: GenericPushIntent(
          contentId,
          entity: cachedEntity ?? MediaEntity(
            id: contentId,
            title: contentId,
            type: MediaType.wallpaper,
            sourceId: const UserActionSourceToken().toString(),
            contentUrl: contentId,
            createTime: DateTime.now(),
            updateTime: DateTime.now(),
          ),
        ),
      ),
      UserAction(
        id: ActionId.like,
        icon: isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
        label: ActionId.like.name,
        isActive: isLiked,
        intent: WallpaperLikeIntent(contentId),
        order: 900,
      ),
      UserAction(
        id: ActionId.apply,
        icon: Icons.wallpaper_rounded,
        label: ActionId.apply.name,
        intent: WallpaperApplyIntent(contentId),
        order: 800,
      ),
      UserAction(
        id: ActionId.download,
        icon: Icons.file_download_rounded,
        label: ActionId.download.name,
        status: downloadStatus,
        intent: WallpaperDownloadIntent(contentId),
        order: 700,
      ),
      UserAction(
        id: ActionId.share,
        icon: Icons.share_rounded,
        label: ActionId.share.name,
        intent: GenericShareIntent(contentId),
        order: 600,
      ),
    ];
  }

  @override
  Stream<List<UserAction>> watchActions(String contentId, {MediaEntity? entity}) {
    if (entity != null) {
      TemporaryCache.setEntity(CacheKeyToken.mediaPrecache(contentId), entity);
    }
    return Stream.value(build(contentId));
  }

  @override
  void handleIntent(UserIntent intent) {
    final contentId = intent.contentId;

    if (intent is PrecacheIntent && intent.entity != null) {
      TemporaryCache.setEntity(
        CacheKeyToken.mediaPrecache(contentId),
        intent.entity!,
      );
      if (!_precachedIds.contains(contentId)) {
        _precachedIds.add(contentId);
        if (_precachedIds.length > 500) {
          _precachedIds.remove(_precachedIds.first);
        }
      }
      ref.invalidateSelf();
    } else if (intent is WallpaperLikeIntent) {
      _likes[contentId] = !(_likes[contentId] ?? false);
      ref.invalidateSelf();
      emitActionEffect(
        ToastEffect((context) => AppLocalizations.of(context)?.like ?? 'Like'),
      );
    } else if (intent is WallpaperDownloadIntent) {
      _downloadStatuses[contentId] = ActionStatus.idle;
      ref.invalidateSelf();
      emitActionEffect(
        ToastEffect((context) => AppLocalizations.of(context)?.download ?? 'Download'),
      );
    }
  }
}
