import 'package:pyro_action_protocol/pyro_action_protocol.dart';

class AudioPlayIntent extends UserIntent {
  const AudioPlayIntent(super.contentId);
}

class AudioLikeIntent extends UserIntent {
  const AudioLikeIntent(super.contentId);
}

class AudioDownloadIntent extends UserIntent {
  const AudioDownloadIntent(super.contentId);
}
