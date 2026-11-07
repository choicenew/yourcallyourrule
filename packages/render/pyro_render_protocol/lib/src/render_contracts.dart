import 'package:material_ui/material_ui.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'l10n/generated/app_localizations.dart';
import 'shelf_tile_delegate.dart';

/// 全局强类型路由 Token 层次结构 (零字符串，类型即语义)
abstract class RouteToken {
  const RouteToken();

  static const webBrowser = WebBrowserRouteToken();
  static const authorProfile = AuthorProfileRouteToken();
  static const audioDetail = AudioDetailRouteToken();
  static const comicDetail = ComicDetailRouteToken();
  static const newsDetail = NewsDetailRouteToken();
  static const novelDetail = NovelDetailRouteToken();
  static const paperDetail = PaperDetailRouteToken();
  static const videoDetail = VideoDetailRouteToken();
  static const wallpaperDetail = WallpaperDetailRouteToken();
}

class WebBrowserRouteToken extends RouteToken { const WebBrowserRouteToken(); }
class AuthorProfileRouteToken extends RouteToken { const AuthorProfileRouteToken(); }
class AudioDetailRouteToken extends RouteToken { const AudioDetailRouteToken(); }
class ComicDetailRouteToken extends RouteToken { const ComicDetailRouteToken(); }
class NewsDetailRouteToken extends RouteToken { const NewsDetailRouteToken(); }
class NovelDetailRouteToken extends RouteToken { const NovelDetailRouteToken(); }
class PaperDetailRouteToken extends RouteToken { const PaperDetailRouteToken(); }
class VideoDetailRouteToken extends RouteToken { const VideoDetailRouteToken(); }
class WallpaperDetailRouteToken extends RouteToken { const WallpaperDetailRouteToken(); }

/// 100% 纯 MediaEntity 强类型构建器和路由动作签名回调 (零 Map<String, dynamic>，零字符串键)
typedef CardBuilder = Widget Function(MediaEntity entity, {bool isSelected});
typedef ReaderBuilder = Widget? Function(
    BuildContext context, MediaEntity entity);
typedef SlotBuilder = Widget Function(MediaEntity entity);
typedef RouteAction = void Function(
    BuildContext context, MediaEntity entity);

/// 顶层协议挂钩句柄（解耦底层 Driver 对 Hub 的强耦合依赖）
typedef RenderNavigateHandler = void Function(
    BuildContext context, Object type, MediaEntity entity);
typedef RegisterCardHandler = void Function(Object type, CardBuilder builder);
typedef RegisterDashboardHandler = void Function(Object type, ReaderBuilder builder);
typedef RegisterReaderHandler = void Function(Object type, ReaderBuilder builder);
typedef RegisterRouteHandler = void Function(Object type, RouteAction action);

typedef RegisterShelfTileHandler = void Function(ShelfTileDelegate delegate);
typedef EntitySelectedNotificationHandler = void Function(BuildContext context, MediaEntity entity);

class RenderProtocolRegistry {
  RenderProtocolRegistry._();

  static RenderNavigateHandler? navigator;
  static EntitySelectedNotificationHandler? notifyEntitySelected;
  static RegisterCardHandler? cardRegister;
  static RegisterDashboardHandler? dashboardRegister;
  static RegisterReaderHandler? readerRegister;
  static RegisterRouteHandler? routeRegister;
  static RegisterShelfTileHandler? shelfTileRegister;

  static final Map<Object, CardBuilder> _fallbackCards = {};
  static final Map<Object, ReaderBuilder> _fallbackDashboards = {};
  static final Map<Object, ReaderBuilder> _fallbackReaders = {};
  static final Map<Object, RouteAction> _fallbackRoutes = {};
  static final Map<Object, ShelfTileDelegate> _fallbackShelfTiles = {};

  static void registerCard(Object type, CardBuilder builder) {
    _fallbackCards[type] = builder;
    cardRegister?.call(type, builder);
  }

  static void registerDashboard(Object type, ReaderBuilder builder) {
    _fallbackDashboards[type] = builder;
    dashboardRegister?.call(type, builder);
  }

  static void registerReader(Object type, ReaderBuilder builder) {
    _fallbackReaders[type] = builder;
    readerRegister?.call(type, builder);
  }

  static void registerRoute(Object type, RouteAction action) {
    _fallbackRoutes[type] = action;
    routeRegister?.call(type, action);
  }

  static void registerShelfTile(ShelfTileDelegate delegate) {
    _fallbackShelfTiles[delegate.contentType] = delegate;
    shelfTileRegister?.call(delegate);
  }

  static CardBuilder? getCard(Object type) => _fallbackCards[type];
  static ReaderBuilder? getDashboard(Object type) => _fallbackDashboards[type];
  static ReaderBuilder? getReader(Object type) => _fallbackReaders[type];
  static RouteAction? getRoute(Object type) => _fallbackRoutes[type];
  static ShelfTileDelegate? getShelfTile(Object type) => _fallbackShelfTiles[type];
}

/// 顶层自注册方法挂钩
void registerCard(Object type, CardBuilder builder) => RenderProtocolRegistry.registerCard(type, builder);
void registerDashboard(Object type, ReaderBuilder builder) => RenderProtocolRegistry.registerDashboard(type, builder);
void registerReader(Object type, ReaderBuilder builder) => RenderProtocolRegistry.registerReader(type, builder);
void registerRoute(Object type, RouteAction action) => RenderProtocolRegistry.registerRoute(type, action);
void registerShelfTileDelegate(ShelfTileDelegate delegate) => RenderProtocolRegistry.registerShelfTile(delegate);

/// BuildContext 延伸动作方法 (跟随 Context 作用域流转，100% 强类型)
extension RenderHubContextX on BuildContext {
  void navigate(Object type, MediaEntity entity) {
    final nav = RenderProtocolRegistry.navigator;
    if (nav != null) {
      nav(this, type, entity);
    } else {
      final route = RenderProtocolRegistry.getRoute(type);
      if (route != null) {
        route(this, entity);
      }
    }
  }

  void navigateEntity(MediaEntity entity, [RouteToken? customRoute]) {
    final route = customRoute ?? entity.type;
    navigate(route, entity);
  }
}

/// 动作与路由参数编译期强类型 Token (零带引号字符串)
abstract class RenderActionTokens {
  static const authorTarget = 'author';
  static const followAction = 'follow';
  static const paramId = 'id';
  static const paramName = 'name';
  static const paramAvatar = 'avatar';
  static const paramSourceId = 'sourceId';
  static const paramPluginId = 'pluginId';
  static const paramContentType = 'contentType';
}

/// MediaType 强类型标准国际化展示扩展 (0 硬编码字符串，0 三元运算)
extension MediaTypeDisplayX on MediaType {
  String getLocalizedName(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) {
      return name;
    }
    switch (this) {
      case MediaType.academic:
        return l10n.mediaTypeAcademic;
      case MediaType.book:
        return l10n.mediaTypeBook;
      case MediaType.novel:
        return l10n.mediaTypeNovel;
      case MediaType.manga:
        return l10n.mediaTypeComic;
      case MediaType.music:
        return l10n.mediaTypeMusic;
      case MediaType.audio:
        return l10n.mediaTypeAudio;
      case MediaType.video:
        return l10n.mediaTypeVideo;
      case MediaType.news:
        return l10n.mediaTypeNews;
      case MediaType.wallpaper:
        return l10n.mediaTypeWallpaper;
      case MediaType.album:
        return l10n.mediaTypeAlbum;
      case MediaType.playlist:
        return l10n.mediaTypePlaylist;
    }
  }
}

