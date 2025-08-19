// 订阅实体类，表示用户的订阅信息

import '../../base/base_entity.dart';

// 订阅实体类，用于管理远程黑白名单订阅
import 'package:yourcallyourrule/core/value_objects/url.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';

// 补充实体方法
class Subscription extends BaseEntity {
  final String name;
  final Url url;
  final bool isEnabled;
  final RuleAction action; // 使用 action 属性表示规则类型
  final DateTime lastUpdated;
  final bool autoUpdate;
  final String tableType; // 添加表类型字段

  const Subscription({
    required super.id,
    required this.name,
    required this.url,
    required this.isEnabled,
    required this.action,
    required this.lastUpdated,
    required this.autoUpdate,
    this.tableType = 'phone', // 默认为phone类型
  });

  // 转换为Map
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'url': url.toString(),
      'isEnabled': isEnabled ? 1 : 0,
      'action': action.toString(),
      'lastUpdated': lastUpdated.toIso8601String(),
      'autoUpdate': autoUpdate ? 1 : 0,
      'table_type': tableType, // 添加表类型字段
    };
  }

  // 从Map创建实体
  factory Subscription.fromMap(Map<String, dynamic> map) {
    // 处理 action 字段
    RuleAction action = RuleAction.fromString(map['action']);
    
    return Subscription(
      id: map['id'],
      name: map['name'],
      url: Url.fromString(map['url']),
      isEnabled: (map['isEnabled'] ?? 1) == 1,
      action: action,
      lastUpdated: DateTime.parse(map['lastUpdated']),
      autoUpdate: (map['autoUpdate'] ?? 0) == 1,
      tableType: map['table_type'] ?? 'phone', // 从map中获取表类型
    );
  }

  // 添加合并更新方法
  Subscription mergeUpdate(Subscription newSubscription) {
    return copyWith(
      isEnabled: newSubscription.isEnabled,
      action: newSubscription.action,
      lastUpdated: DateTime.now(),
      autoUpdate: newSubscription.autoUpdate,
      tableType: newSubscription.tableType, // 更新表类型
    );
  }

  Subscription copyWith({
    String? name,
    Url? url,
    bool? isEnabled,
    RuleAction? action,
    bool? autoUpdate,
    DateTime? lastUpdated,
    String? tableType, // 添加表类型参数
  }) {
    return Subscription(
      id: id,
      name: name ?? this.name,
      url: url ?? this.url,
      isEnabled: isEnabled ?? this.isEnabled,
      action: action ?? this.action,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      autoUpdate: autoUpdate ?? this.autoUpdate,
      tableType: tableType ?? this.tableType, // 使用新的表类型或保留原有的
    );
  }
  
  // 便捷方法，判断是否为白名单订阅
 // bool get isWhitelistSubscription => action == RuleAction.allow;
  
  // 便捷方法，判断是否为黑名单订阅
 // bool get isBlacklistSubscription => action == RuleAction.block;
}
