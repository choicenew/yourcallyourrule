import 'package:material_ui/material_ui.dart';
import 'package:pyro_action_hub/pyro_action_hub.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

import 'paper_action_provider.dart';
import 'paper_card.dart';
import 'paper_detail_screen.dart';
import 'paper_reader_screen.dart';
import 'paper_shelf_tile_delegate.dart';

/// 学术文献渲染器注册中心 (100% 强类型 MediaEntity 驱动)
class PaperRenderer {
  static final PaperActions provider = PaperActions();

  static void register() {
    registerCard(MediaType.academic, (entity, {isSelected = false}) {
      return PaperCard(entity: entity, isSelected: isSelected);
    });

    registerReader(MediaType.academic, (context, entity) {
      return PaperReaderScreen(entity: entity);
    });

    registerDashboard(MediaType.academic, (context, entity) {
      return PaperDetailScreen(entity: entity);
    });

    registerRoute(MediaType.academic, (context, entity) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PaperDetailScreen(entity: entity),
        ),
      );
    });

    registerRoute(RouteToken.paperDetail, (context, entity) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PaperDetailScreen(entity: entity),
        ),
      );
    });

    registerActionProvider(MediaType.academic, provider);
    registerActionProvider(MediaTypeToken.paper, provider);

    registerShelfTileDelegate(PaperShelfTileDelegate());
  }
}
