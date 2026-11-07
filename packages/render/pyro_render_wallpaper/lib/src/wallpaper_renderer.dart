import 'package:material_ui/material_ui.dart';
import 'package:pyro_action_hub/pyro_action_hub.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

import 'wallpaper_action_provider.dart';
import 'wallpaper_card.dart';
import 'wallpaper_detail_screen.dart';
import 'wallpaper_preview_screen.dart';
import 'wallpaper_shelf_tile_delegate.dart';

/// 壁纸渲染器注册中心 (100% 强类型 MediaEntity 驱动)
class WallpaperRenderer {
  static final WallpaperActions provider = WallpaperActions();

  static void register() {
    registerCard(MediaType.wallpaper, (entity, {isSelected = false}) {
      return WallpaperCard(entity: entity, isSelected: isSelected);
    });

    registerReader(MediaType.wallpaper, (context, entity) {
      return WallpaperPreviewScreen(entity: entity);
    });

    registerDashboard(MediaType.wallpaper, (context, entity) {
      return WallpaperDetailScreen(entity: entity);
    });

    registerRoute(MediaType.wallpaper, (context, entity) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => WallpaperDetailScreen(entity: entity),
        ),
      );
    });

    registerRoute(RouteToken.wallpaperDetail, (context, entity) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => WallpaperDetailScreen(entity: entity),
        ),
      );
    });

    registerActionProvider(MediaType.wallpaper, provider);
    registerActionProvider(MediaTypeToken.wallpaper, provider);

    registerShelfTileDelegate(WallpaperShelfTileDelegate());
  }
}
