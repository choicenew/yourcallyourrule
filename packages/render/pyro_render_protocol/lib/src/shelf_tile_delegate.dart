import 'package:flutter/widgets.dart';
import 'package:pyro_media_models/pyro_media_models.dart';

/// 纯书架卡片渲染代理协议 (Shelf Tile Delegate Contract)
/// 8 大 packages/render/* 微包各自实现此接口，注入属于自己媒体类型的特质 Shelf Tile
abstract class ShelfTileDelegate {
  /// 声明自己负责的媒体类型 (如 MediaType.novel, MediaType.academic, MediaType.manga, MediaType.audio, MediaType.video, MediaType.wallpaper, MediaType.news)
  Object get contentType;

  /// 由各自 Render Package 内部实现特定媒体的专属 Widget 绘制
  Widget buildShelfTile(BuildContext context, MediaEntity entity, {VoidCallback? onTap});
}
