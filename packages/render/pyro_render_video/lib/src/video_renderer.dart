import 'package:material_ui/material_ui.dart';
import 'package:pyro_action_hub/pyro_action_hub.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

import 'video_action_provider.dart';
import 'video_card.dart';
import 'video_detail_screen.dart';
import 'video_player_screen.dart';
import 'video_shelf_tile_delegate.dart';

/// 视频渲染器注册中心 (100% 强类型 MediaEntity 驱动)
class VideoRenderer {
  static final VideoActions provider = VideoActions();

  static void register() {
    registerCard(MediaType.video, (entity, {isSelected = false}) {
      return VideoCard(entity: entity, isSelected: isSelected);
    });

    registerReader(MediaType.video, (context, entity) {
      return VideoPlayerScreen(entity: entity);
    });

    registerDashboard(MediaType.video, (context, entity) {
      return VideoDetailScreen(entity: entity);
    });

    registerRoute(MediaType.video, (context, entity) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => VideoDetailScreen(entity: entity),
        ),
      );
    });

    registerRoute(RouteToken.videoDetail, (context, entity) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => VideoDetailScreen(entity: entity),
        ),
      );
    });

    registerActionProvider(MediaType.video, provider);
    registerActionProvider(MediaTypeToken.video, provider);

    registerShelfTileDelegate(VideoShelfTileDelegate());
  }
}
