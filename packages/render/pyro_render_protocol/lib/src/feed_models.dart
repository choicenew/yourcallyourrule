import 'package:flutter/widgets.dart';
import 'package:pyro_media_models/pyro_media_models.dart';

enum QuickActionType { like, favorite, share, comment }

/// 全局 Feed 流中的条目契约 (完全对齐 8 大渲染微包与算法微包契约)
class FeedItem {
  final String id;
  final Object type;           // 建议渲染类型: MediaType, RouteToken, or 'ad'
  final String? category;      // 业务分类: trending, favorite, history...
  final double? rank;          // 推荐权重
  
  /// 强类型 MediaEntity 媒体实体载荷 (100% 编译期安全)
  final MediaEntity? entity;

  /// 核心数据负载 Map (对齐 8 大渲染微包与算法微包)
  final Map<String, dynamic> data;

  const FeedItem({
    required this.id,
    required this.type,
    this.category,
    this.rank,
    this.entity,
    required this.data,
  });

  /// 广告数据节点强类型 Getter (0 字符串 item.type 校验)
  bool get isAdNode => data['isAdNode'] == true;

  /// 快捷获取展示标题 (优先使用 entity 属性，退回 data 载荷与 id)
  String get displayTitle {
    if (entity != null) return entity!.displayTitle;
    final title = data['title']?.toString();
    if (title != null && title.trim().isNotEmpty) return title;
    return id;
  }

  /// 快捷获取封面图片 URL (优先使用 entity 属性)
  String? get coverUrl {
    if (entity != null) return entity!.coverUrl;
    return data['cover']?.toString() ?? data['coverUrl']?.toString();
  }

  /// 广告节点构造函数
  factory FeedItem.adNode({required Object id, required int tierLevel}) {
    return FeedItem(
      id: 'ad_$id',
      type: 'ad',
      data: {
        'isAdNode': true,
        'tierLevel': tierLevel,
      },
    );
  }

  /// 快捷获取创作者列表
  Map<String, String> get creators {
    if (entity != null) return entity!.creators;
    final raw = data['creators'];
    if (raw is Map) return Map<String, String>.from(raw);
    final oldAuthor = data['author'] ?? data['authors'];
    if (oldAuthor != null) return {'author': oldAuthor.toString()};
    return const {};
  }
}

typedef FeedItemRouteCallback = void Function(String itemId);

abstract class FeedSensorDelegate {
  void onExposure(String itemId, double exposureRatio, Duration dwellTime);
  void onQuickAction(String itemId, QuickActionType action);
}

abstract class FeedRoutingDelegate {
  void onItemClick(String itemId, String itemType);
  void onAuthorClick(String authorId, {String? role});
}

/// [ARCH-FIX] 唯一的 ItemBuilder 定义，解决跨包编译冲突
typedef ItemBuilder = Widget Function(BuildContext context, FeedItem item);

/// 全局 Feed 数据控制器基类
abstract class IFeedDataController extends ChangeNotifier {
  List<FeedItem> get items;
  bool get isLoading;
  bool get hasMore;
}
