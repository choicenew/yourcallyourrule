import 'package:material_ui/material_ui.dart';
import 'package:pyro_action_hub/pyro_action_hub.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

import 'news_action_provider.dart';
import 'news_card.dart';
import 'news_detail_screen.dart';
import 'news_reader_screen.dart';
import 'news_shelf_tile_delegate.dart';

/// 新闻资讯渲染器注册中心 (100% 强类型 MediaEntity 驱动)
class NewsRenderer {
  static final NewsActions provider = NewsActions();

  static void register() {
    registerCard(MediaType.news, (entity, {isSelected = false}) {
      return NewsCard(entity: entity, isSelected: isSelected);
    });

    registerReader(MediaType.news, (context, entity) {
      return NewsReaderScreen(entity: entity);
    });

    registerDashboard(MediaType.news, (context, entity) {
      return NewsDetailScreen(entity: entity);
    });

    registerRoute(MediaType.news, (context, entity) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => NewsDetailScreen(entity: entity),
        ),
      );
    });

    registerRoute(RouteToken.newsDetail, (context, entity) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => NewsDetailScreen(entity: entity),
        ),
      );
    });

    registerActionProvider(MediaType.news, provider);
    registerActionProvider(MediaTypeToken.news, provider);

    registerShelfTileDelegate(NewsShelfTileDelegate());
  }
}
