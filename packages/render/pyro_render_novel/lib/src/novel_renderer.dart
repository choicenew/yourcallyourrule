import 'package:material_ui/material_ui.dart';
import 'package:pyro_action_hub/pyro_action_hub.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

import 'novel_action_provider.dart';
import 'novel_card.dart';
import 'novel_detail_screen.dart';
import 'novel_reader_screen.dart';
import 'novel_shelf_tile_delegate.dart';

/// 小说/图书渲染器注册中心 (100% 强类型 MediaEntity 驱动)
class NovelRenderer {
  static final NovelActions provider = NovelActions();

  static void register() {
    registerCard(MediaType.novel, (entity, {isSelected = false}) {
      return NovelCard(entity: entity, isSelected: isSelected);
    });

    registerCard(MediaType.book, (entity, {isSelected = false}) {
      return NovelCard(entity: entity, isSelected: isSelected);
    });

    registerReader(MediaType.novel, (context, entity) {
      return NovelReaderScreen(entity: entity);
    });

    registerReader(MediaType.book, (context, entity) {
      return NovelReaderScreen(entity: entity);
    });

    registerDashboard(MediaType.novel, (context, entity) {
      return NovelDetailScreen(entity: entity);
    });

    registerDashboard(MediaType.book, (context, entity) {
      return NovelDetailScreen(entity: entity);
    });

    registerRoute(MediaType.novel, (context, entity) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => NovelDetailScreen(entity: entity),
        ),
      );
    });

    registerRoute(MediaType.book, (context, entity) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => NovelDetailScreen(entity: entity),
        ),
      );
    });

    registerRoute(RouteToken.novelDetail, (context, entity) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => NovelDetailScreen(entity: entity),
        ),
      );
    });

    registerActionProvider(MediaType.novel, provider);
    registerActionProvider(MediaType.book, provider);
    registerActionProvider(MediaTypeToken.novel, provider);

    registerShelfTileDelegate(NovelShelfTileDelegate());
    registerShelfTileDelegate(BookShelfTileDelegate());
  }
}
