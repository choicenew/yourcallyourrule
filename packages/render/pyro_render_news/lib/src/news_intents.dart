import 'package:pyro_action_protocol/pyro_action_protocol.dart';

export 'package:pyro_action_protocol/pyro_action_protocol.dart'
    show NewsOCRIntent, NewsTranslateAIIntent;

class NewsReadIntent extends UserIntent {
  const NewsReadIntent(super.contentId);
}

class NewsShareIntent extends UserIntent {
  const NewsShareIntent(super.contentId);
}

class NewsTranslateEngineIntent extends UserIntent {
  const NewsTranslateEngineIntent(super.contentId);
}
