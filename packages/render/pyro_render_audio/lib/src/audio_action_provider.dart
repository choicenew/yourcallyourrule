import 'package:material_ui/material_ui.dart';
import 'l10n/generated/app_localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_action_hub/pyro_action_hub.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

import 'audio_intents.dart';

part 'audio_action_provider.g.dart';

@Riverpod(keepAlive: true)
class AudioActions extends _$AudioActions implements ActionProvider {
  final Map<String, bool> _likes = {};
  final Map<String, ActionStatus> _downloadStatuses = {};

  MediaEntity? _getCachedEntity(String cid) {
    return TemporaryCache.getEntity(CacheKeyToken.mediaPrecache(cid));
  }

  @override
  List<UserAction> build(String contentId) {
    final isLiked = _likes[contentId] ?? false;
    final downloadStatus = _downloadStatuses[contentId] ?? ActionStatus.idle;
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
            type: MediaType.audio,
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
        order: 900,
        intent: AudioLikeIntent(contentId),
      ),
      UserAction(
        id: ActionId.share,
        icon: Icons.share_rounded,
        label: ActionId.share.name,
        order: 800,
        intent: GenericCustomIntent(MediaType.audio, contentId),
      ),
      UserAction(
        id: ActionId.play,
        icon: Icons.play_arrow_rounded,
        label: ActionId.play.name,
        status: downloadStatus,
        order: 700,
        intent: AudioPlayIntent(contentId),
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
      ref.invalidateSelf();
    } else if (intent is AudioPlayIntent) {
      emitActionEffect(
        ToastEffect((context) => AppLocalizations.of(context)?.play ?? 'Play'),
      );
    } else if (intent is AudioLikeIntent) {
      _likes[contentId] = !(_likes[contentId] ?? false);
      ref.invalidateSelf();
      emitActionEffect(
        ToastEffect(
          (context) => AppLocalizations.of(context)?.like ?? 'Like',
        ),
      );
    } else if (intent is AudioDownloadIntent) {
      _downloadStatuses[contentId] = ActionStatus.idle;
      ref.invalidateSelf();
      emitActionEffect(
        ToastEffect((context) => AppLocalizations.of(context)?.play ?? 'Play'),
      );
    }
  }
}
