import 'package:material_ui/material_ui.dart';
import 'package:pyro_action_hub/pyro_action_hub.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

import 'audio_action_provider.dart';
import 'audio_card.dart';
import 'audio_detail_screen.dart';
import 'audio_player_screen.dart';
import 'audio_shelf_tile_delegate.dart';

/// 音频渲染器注册中心 (100% 强类型 MediaEntity 驱动)
class AudioRenderer {
  static final AudioActions provider = AudioActions();

  static void register() {
    registerCard(MediaType.audio, (entity, {isSelected = false}) {
      return AudioCard(entity: entity, isSelected: isSelected);
    });

    registerReader(MediaType.audio, (context, entity) {
      return AudioPlayerScreen(entity: entity);
    });

    registerDashboard(MediaType.audio, (context, entity) {
      return AudioDetailScreen(entity: entity);
    });

    registerRoute(MediaType.audio, (context, entity) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AudioDetailScreen(entity: entity),
        ),
      );
    });

    registerRoute(RouteToken.audioDetail, (context, entity) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AudioDetailScreen(entity: entity),
        ),
      );
    });

    registerActionProvider(MediaType.audio, provider);

    registerShelfTileDelegate(AudioShelfTileDelegate());
  }
}
