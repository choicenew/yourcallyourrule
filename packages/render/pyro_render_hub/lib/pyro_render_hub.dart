library pyro_render_hub;

import 'package:material_ui/material_ui.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

export 'package:pyro_media_mapper/pyro_media_mapper.dart';
export 'package:pyro_media_models/pyro_media_models.dart';
export 'package:pyro_render_protocol/pyro_render_protocol.dart';
export 'src/app_web_browser_screen.dart';
export 'src/browser_action_provider.dart';

/// 100% 强类型 MediaEntity 驱动的渲染中台 (零 Map<String, dynamic>，零手写字符串 Key)
class RenderHub {
  RenderHub._() {
    _bindProtocolRegistry();
  }

  static final RenderHub instance = RenderHub._();

  void _bindProtocolRegistry() {
    RenderProtocolRegistry.navigator = (context, type, entity) => navigate(context, type, entity);
    RenderProtocolRegistry.cardRegister = (type, builder) => registerCard(type, builder);
    RenderProtocolRegistry.dashboardRegister = (type, builder) => registerDashboard(type, builder);
    RenderProtocolRegistry.readerRegister = (type, builder) => registerReader(type, builder);
    RenderProtocolRegistry.routeRegister = (type, action) => registerRoute(type, action);
    RenderProtocolRegistry.shelfTileRegister = (delegate) => registerShelfTileDelegate(delegate);
  }

  final Map<Object, CardBuilder> _cards = {};
  final Map<Object, ReaderBuilder> _readers = {};
  final Map<Object, SlotBuilder> _slots = {};
  final Map<Object, ReaderBuilder> _dashboards = {};
  final Map<Object, RouteAction> _routes = {};
  final Map<Object, ShelfTileDelegate> _shelfTileDelegates = {};

  // --- 注册接口 ---

  void registerShelfTileDelegate(ShelfTileDelegate delegate) {
    _shelfTileDelegates[delegate.contentType] = delegate;
  }

  void unregisterShelfTileDelegate(Object type) {
    _shelfTileDelegates.remove(type);
  }

  void registerDashboard(Object type, ReaderBuilder builder) {
    _dashboards[type] = builder;
  }

  void unregisterDashboard(Object type) {
    _dashboards.remove(type);
  }

  void registerCard(Object type, CardBuilder builder) {
    _cards[type] = builder;
  }

  void unregisterCard(Object type) {
    _cards.remove(type);
  }

  void registerReader(Object type, ReaderBuilder builder) {
    _readers[type] = builder;
  }

  void unregisterReader(Object type) {
    _readers.remove(type);
  }

  void registerSlot(Object name, SlotBuilder builder) {
    _slots[name] = builder;
  }

  void unregisterSlot(Object name) {
    _slots.remove(name);
  }

  void registerRoute(Object type, RouteAction action) {
    _routes[type] = action;
  }

  void unregisterRoute(Object type) {
    _routes.remove(type);
  }

  void clear() {
    _cards.clear();
    _readers.clear();
    _slots.clear();
    _routes.clear();
    _shelfTileDelegates.clear();
  }

  // --- 消费接口 ---

  List<Object> get registeredCardTypes => _cards.keys.toList();
  List<Object> get registeredReaderTypes => _readers.keys.toList();
  List<Object> get registeredSlotNames => _slots.keys.toList();
  List<Object> get registeredRouteTypes => _routes.keys.toList();

  /// 依据 MediaEntity.type 动态构建微包自洽注入的 Shelf Tile 卡片
  Widget buildShelfTile(BuildContext context, MediaEntity entity, {VoidCallback? onTap}) {
    final delegate = _shelfTileDelegates[entity.type];
    if (delegate != null) {
      return delegate.buildShelfTile(context, entity, onTap: onTap);
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primaryColor = colorScheme.primary;
    final titleText = entity.displayTitle;
    final subTitleText = (entity.creators.isNotEmpty
            ? entity.creators.values.first
            : (entity.description ?? entity.abstract ?? entity.type.name))
        .trim();
    final cover = entity.coverUrl ?? entity.thumbUrl ?? '';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: colorScheme.outlineVariant.withValues(alpha: 0.5),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: double.infinity,
                    color: primaryColor.withValues(alpha: 0.12),
                    child: SafeImageBuilder.buildSafeCoverImage(
                      url: cover,
                      fit: BoxFit.cover,
                      fallbackWidget: Center(
                        child: Icon(
                          Icons.menu_book_rounded,
                          size: 36,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                titleText,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: colorScheme.onSurface,
                ),
              ),
              if (subTitleText.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  subTitleText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(Object type, MediaEntity entity, {bool isSelected = false}) {
    final builder = _cards[type] ?? RenderProtocolRegistry.getCard(type);
    if (builder == null) {
      return const SizedBox.shrink();
    }
    return builder(entity, isSelected: isSelected);
  }

  Widget? buildReader(
      BuildContext context, Object type, MediaEntity entity) {
    final builder = _readers[type] ?? RenderProtocolRegistry.getReader(type);
    if (builder == null) {
      return null;
    }
    return builder(context, entity);
  }

  bool openReader(
      BuildContext context, Object type, MediaEntity entity) {
    final builder = _readers[type] ?? RenderProtocolRegistry.getReader(type);
    if (builder != null) {
      final widget = builder(context, entity);
      if (widget != null) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => widget),
        );
        return true;
      }
    }
    return false;
  }

  Widget buildSlot(Object name, MediaEntity entity) {
    final builder = _slots[name];
    if (builder == null) {
      return const SizedBox.shrink();
    }
    return builder(entity);
  }

  Widget? buildDashboard(
      BuildContext context, Object type, MediaEntity entity) {
    final builder = _dashboards[type] ?? RenderProtocolRegistry.getDashboard(type);
    if (builder == null) {
      return null;
    }
    return builder(context, entity);
  }

  void navigate(
      BuildContext context, Object type, MediaEntity entity) {
    final mq = MediaQuery.maybeOf(context);
    final isLandscape = mq?.orientation == Orientation.landscape ||
        (mq?.size.width ?? 0) >= 840;

    if (isLandscape) {
      RenderProtocolRegistry.notifyEntitySelected?.call(context, entity);
      return;
    }

    final action = _routes[type] ?? RenderProtocolRegistry.getRoute(type);
    if (action != null) {
      action(context, entity);
    }
  }
}
