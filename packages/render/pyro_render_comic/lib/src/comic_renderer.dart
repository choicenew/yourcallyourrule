import 'package:material_ui/material_ui.dart';
import 'package:pyro_action_hub/pyro_action_hub.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

import 'comic_action_provider.dart';
import 'comic_card.dart';
import 'comic_detail_screen.dart';
import 'comic_reader_screen.dart';
import 'comic_shelf_tile_delegate.dart';

/// 漫画渲染器注册中心 (100% 强类型 MediaEntity 驱动)
class ComicRenderer {
  static final ComicActions provider = ComicActions();

  static void register() {
    registerCard(MediaType.manga, (entity, {isSelected = false}) {
      return ComicCard(entity: entity, isSelected: isSelected);
    });

    registerReader(MediaType.manga, (context, entity) {
      return ComicReaderScreen(entity: entity);
    });

    registerDashboard(MediaType.manga, (context, entity) {
      return ComicDetailScreen(entity: entity);
    });

    registerRoute(MediaType.manga, (context, entity) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ComicDetailScreen(entity: entity),
        ),
      );
    });

    registerRoute(RouteToken.comicDetail, (context, entity) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ComicDetailScreen(entity: entity),
        ),
      );
    });

    registerActionProvider(MediaType.manga, provider);
    registerActionProvider(MediaTypeToken.comic, provider);

    registerShelfTileDelegate(ComicShelfTileDelegate());
  }
}
