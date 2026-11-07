import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';

export 'package:pyro_action_protocol/pyro_action_protocol.dart'
    show NovelTranslateAIIntent;

class NovelReadIntent extends UserIntent {
  const NovelReadIntent(super.contentId);
}

class NovelShelfIntent extends UserIntent {
  final MediaEntity? entity;
  const NovelShelfIntent(super.contentId, {this.entity});
}

class NovelTranslateEngineIntent extends UserIntent {
  const NovelTranslateEngineIntent(super.contentId);
}
