import 'package:material_ui/material_ui.dart';
import 'l10n/generated/app_localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_action_hub/pyro_action_hub.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

import 'news_intents.dart';

part 'news_action_provider.g.dart';

@Riverpod(keepAlive: true)
class NewsActions extends _$NewsActions implements ActionProvider {
  final Map<String, ActionStatus> _ocrStatuses = {};

  MediaEntity? _getCachedEntity(String cid) {
    return TemporaryCache.getEntity(CacheKeyToken.mediaPrecache(cid));
  }

  @override
  List<UserAction> build(String contentId) {
    final cachedEntity = _getCachedEntity(contentId);

    final translateSubActions = [
      UserAction(
        id: ActionId.newsTranslateAi,
        icon: Icons.auto_awesome_rounded,
        label: ActionId.newsTranslateAi.name,
        intent: NewsTranslateAIIntent(contentId),
      ),
      UserAction(
        id: ActionId.newsTranslateEngine,
        icon: Icons.g_translate_rounded,
        label: ActionId.newsTranslateEngine.name,
        intent: NewsTranslateEngineIntent(contentId),
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
            type: MediaType.news,
            sourceId: const UserActionSourceToken().toString(),
            contentUrl: contentId,
            createTime: DateTime.now(),
            updateTime: DateTime.now(),
          ),
        ),
      ),
      UserAction(
        id: ActionId.share,
        icon: Icons.share_rounded,
        label: ActionId.share.name,
        order: 800,
        intent: NewsShareIntent(contentId),
      ),
      UserAction(
        id: ActionId.translate,
        icon: Icons.translate_rounded,
        label: ActionId.translate.name,
        order: 700,
        subActions: translateSubActions,
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
    } else if (intent is NewsReadIntent) {
      emitActionEffect(
        ToastEffect((context) => AppLocalizations.of(context)?.read ?? 'Read'),
      );
    } else if (intent is NewsShareIntent) {
      emitActionEffect(
        ToastEffect((context) => AppLocalizations.of(context)?.share ?? 'Share'),
      );
    } else if (intent is NewsOCRIntent) {
      _ocrStatuses[contentId] = ActionStatus.idle;
      ref.invalidateSelf();
      emitActionEffect(
        ToastEffect((context) => AppLocalizations.of(context)?.ocr ?? 'OCR'),
      );
    } else if (intent is NewsTranslateAIIntent || intent is NewsTranslateEngineIntent) {
      emitActionEffect(
        ToastEffect((context) => AppLocalizations.of(context)?.translate ?? 'Translate'),
      );
    }
  }
}
