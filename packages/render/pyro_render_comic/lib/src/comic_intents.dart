import 'package:pyro_action_protocol/pyro_action_protocol.dart';

export 'package:pyro_action_protocol/pyro_action_protocol.dart'
    show
        ComicReadIntent,
        ComicShelfIntent,
        ComicOCRIntent,
        ComicTranslateAIIntent;

class ComicTranslateEngineIntent extends UserIntent {
  const ComicTranslateEngineIntent(super.contentId);
}
