import 'package:pyro_action_protocol/pyro_action_protocol.dart';

class VideoPlayIntent extends UserIntent {
  const VideoPlayIntent(super.contentId);
}

class VideoLikeIntent extends UserIntent {
  const VideoLikeIntent(super.contentId);
}

class VideoDownloadIntent extends UserIntent {
  const VideoDownloadIntent(super.contentId);
}
