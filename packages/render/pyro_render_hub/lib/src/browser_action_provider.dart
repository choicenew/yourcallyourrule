import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_action_hub/pyro_action_hub.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:share_plus/share_plus.dart';

part 'browser_action_provider.g.dart';

enum BrowserActionType {
  dictionary,
  translate,
  translateDom,
  translateExtract,
  aiQa,
  share,
}

class BrowserActionIntent extends UserIntent {
  final BrowserActionType actionType;
  const BrowserActionIntent(super.contentId, this.actionType);
}

class BrowserActionEvent extends ActionEffect {
  final String contentId;
  final BrowserActionType action;

  const BrowserActionEvent(this.contentId, this.action);
}

/// 浏览器专属的动作提供者，符合统一的 ActionProvider 协议 (Riverpod 3 自动生成 Notifier)
@Riverpod(keepAlive: true)
class BrowserActions extends _$BrowserActions implements ActionProvider {
  @override
  List<UserAction> build(String contentId) {
    return [
      UserAction(
        id: ActionId.browserDictionary,
        icon: Icons.menu_book_rounded,
        label: 'Dictionary Lookup',
        order: 100,
        intent: BrowserActionIntent(contentId, BrowserActionType.dictionary),
      ),
      UserAction(
        id: ActionId.browserTranslateDom,
        icon: Icons.g_translate_rounded,
        label: 'Bilingual Page Translation',
        order: 90,
        intent: BrowserActionIntent(contentId, BrowserActionType.translateDom),
      ),
      UserAction(
        id: ActionId.browserTranslateExtract,
        icon: Icons.article_outlined,
        label: 'Extract & Translate Content',
        order: 85,
        intent: BrowserActionIntent(contentId, BrowserActionType.translateExtract),
      ),
      UserAction(
        id: ActionId.browserAiQa,
        icon: Icons.smart_toy_outlined,
        label: 'AI Deep Analysis',
        order: 80,
        intent: BrowserActionIntent(contentId, BrowserActionType.aiQa),
      ),
      UserAction(
        id: ActionId.browserShare,
        icon: Icons.share_outlined,
        label: 'Share Web Page',
        order: 10,
        intent: BrowserActionIntent(contentId, BrowserActionType.share),
      ),
    ];
  }

  @override
  Stream<List<UserAction>> watchActions(String contentId, {MediaEntity? entity}) {
    return Stream.value(build(contentId));
  }

  @override
  void handleIntent(UserIntent intent) async {
    final contentId = intent.contentId;
    if (intent is BrowserActionIntent) {
      switch (intent.actionType) {
        case BrowserActionType.share:
          Share.share(contentId);
          break;
        case BrowserActionType.dictionary:
          emitActionEffect(BrowserActionEvent(contentId, BrowserActionType.dictionary));
          break;
        case BrowserActionType.translate:
        case BrowserActionType.translateDom:
          emitActionEffect(BrowserActionEvent(contentId, BrowserActionType.translateDom));
          break;
        case BrowserActionType.translateExtract:
          emitActionEffect(BrowserActionEvent(contentId, BrowserActionType.translateExtract));
          break;
        case BrowserActionType.aiQa:
          emitActionEffect(BrowserActionEvent(contentId, BrowserActionType.aiQa));
          break;
      }
    }
  }
}
