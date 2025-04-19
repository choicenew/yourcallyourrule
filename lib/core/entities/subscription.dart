// 订阅实体类，表示用户的订阅信息

import '../base/base_entity.dart';

// 订阅实体类，用于管理远程黑白名单订阅
import 'package:yourcallyourrule/core/value_objects/url.dart';

// 补充实体方法
class Subscription extends BaseEntity {
  final String name;
  final Url url;
  final bool isEnabled;
  final bool isWhitelist;
  final bool isBlacklist;
  final DateTime lastUpdated;
  final bool autoUpdate;

  const Subscription({
    required super.id,
    required this.name,
    required this.url,
    required this.isEnabled,
    required this.isWhitelist,
    required this.isBlacklist,
    required this.lastUpdated,
    required this.autoUpdate,
  });

  // 转换为Map
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'url': url.toString(),
      'isEnabled': isEnabled,
      'isWhitelist': isWhitelist,
      'isBlacklist': isBlacklist,
      'lastUpdated': lastUpdated.toIso8601String(),
      'autoUpdate': autoUpdate,
    };
  }

  // 从Map创建实体
  factory Subscription.fromMap(Map<String, dynamic> map) {
    return Subscription(
      id: map['id'],
      name: map['name'],
      url: Url.fromString(map['url']),
      isEnabled: map['isEnabled'],
      isWhitelist: map['isWhitelist'],
      isBlacklist: map['isBlacklist'],
      lastUpdated: DateTime.parse(map['lastUpdated']),
      autoUpdate: map['autoUpdate'],
    );
  }

  // 添加合并更新方法
  Subscription mergeUpdate(Subscription newSubscription) {
    return copyWith(
      isEnabled: newSubscription.isEnabled,
      lastUpdated: DateTime.now(),
      autoUpdate: newSubscription.autoUpdate,
    );
  }

  Subscription copyWith({
    bool? isEnabled,
    bool? autoUpdate,
    DateTime? lastUpdated,
  }) {
    return Subscription(
      id: id,
      name: name,
      url: url,
      isEnabled: isEnabled ?? this.isEnabled,
      isWhitelist: isWhitelist,
      isBlacklist: isBlacklist,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      autoUpdate: autoUpdate ?? this.autoUpdate,
    );
  }
}
