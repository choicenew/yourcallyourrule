import 'package:material_ui/material_ui.dart';
import 'l10n/generated/app_localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_action_hub/pyro_action_hub.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

import 'novel_intents.dart';

part 'novel_action_provider.g.dart';

@Riverpod(keepAlive: true)
class NovelActions extends _$NovelActions implements ActionProvider {
  final Map<String, bool> _inShelf = {};
  final Map<String, ActionStatus> _translateStatus = {};

  MediaEntity? _getCachedEntity(String cid) {
    return TemporaryCache.getEntity(CacheKeyToken.mediaPrecache(cid));
  }

  @override
  List<UserAction> build(String contentId) {
    final inShelf = _inShelf[contentId] ?? false;
    final transStatus = _translateStatus[contentId] ?? ActionStatus.idle;
    final cachedEntity = _getCachedEntity(contentId);

    final translateSubActions = [
      UserAction(
        id: ActionId.novelTranslateAi,
        icon: Icons.auto_awesome_rounded,
        label: ActionId.novelTranslateAi.name,
        intent: NovelTranslateAIIntent(contentId),
      ),
      UserAction(
        id: ActionId.novelTranslateEngine,
        icon: Icons.g_translate_rounded,
        label: ActionId.novelTranslateEngine.name,
        intent: NovelTranslateEngineIntent(contentId),
      ),
    ];

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
            type: MediaType.novel,
            sourceId: const UserActionSourceToken().toString(),
            contentUrl: contentId,
            createTime: DateTime.now(),
            updateTime: DateTime.now(),
          ),
        ),
      ),
      UserAction(
        id: ActionId.shelf,
        icon: inShelf ? Icons.bookmark_added_rounded : Icons.bookmark_add_rounded,
        label: ActionId.shelf.name,
        isActive: inShelf,
        order: 900,
        intent: NovelShelfIntent(contentId, entity: cachedEntity),
      ),
      UserAction(
        id: ActionId.translate,
        icon: Icons.translate_rounded,
        label: ActionId.translate.name,
        status: transStatus,
        order: 800,
        subActions: translateSubActions,
      ),
      UserAction(
        id: ActionId.share,
        icon: Icons.share_rounded,
        label: ActionId.share.name,
        order: 700,
        intent: GenericShareIntent(contentId),
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
    } else if (intent is NovelReadIntent) {
      emitActionEffect(
        ToastEffect((context) => AppLocalizations.of(context)?.read ?? 'Read'),
      );
    } else if (intent is NovelShelfIntent) {
      _inShelf[contentId] = !(_inShelf[contentId] ?? false);
      ref.invalidateSelf();
      final cachedEntity = _getCachedEntity(contentId);
      ActionHub.instance.dispatchIntent(
        MediaType.novel,
        GenericLikeIntent(contentId),
        entity: intent.entity ?? cachedEntity,
      );
    } else if (intent is NovelTranslateAIIntent || intent is NovelTranslateEngineIntent) {
      _runTranslation(contentId);
    }
  }

  void _runTranslation(String contentId) {
    _translateStatus[contentId] = ActionStatus.idle;
    ref.invalidateSelf();
    emitActionEffect(
      ToastEffect((context) => AppLocalizations.of(context)?.translate ?? 'Translate'),
    );
  }
}
