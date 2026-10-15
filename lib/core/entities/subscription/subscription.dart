import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yourcallyourrule/core/base/base_entity.dart';
import 'package:yourcallyourrule/core/value_objects/url.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/entities/subscription/subscription_table_type.dart';

part 'subscription.freezed.dart';

/// 订阅实体类 (@freezed 自动生成不可变数据类)
@freezed
abstract class Subscription with _$Subscription implements BaseEntity {
  const Subscription._();

  @Implements<BaseEntity>()
  const factory Subscription({
    required String id,
    required String name,
    required Url url,
    @Default(true) bool isEnabled,
    @Default(RuleAction.block) RuleAction action,
    required DateTime lastUpdated,
    @Default(false) bool autoUpdate,
    @Default(SubscriptionTableKeys.phone) String tableType,
  }) = _Subscription;

  /// 合并更新方法
  Subscription mergeUpdate(Subscription newSubscription) {
    return copyWith(
      isEnabled: newSubscription.isEnabled,
      action: newSubscription.action,
      lastUpdated: DateTime.now(),
      autoUpdate: newSubscription.autoUpdate,
      tableType: newSubscription.tableType,
    );
  }

  /// 转换为 Map
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
      'tableType': tableType,
    };
  }

  /// 从 Map 反序列化生成实体
  factory Subscription.fromMap(Map<String, dynamic> map) {
    return Subscription(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      url: Url.fromString(map['url']?.toString() ?? ''),
      isEnabled: (map['isEnabled'] ?? 1) == 1 || map['isEnabled'] == true,
      action: RuleAction.fromString(map['action']),
      lastUpdated: map['lastUpdated'] != null
          ? DateTime.tryParse(map['lastUpdated'].toString()) ?? DateTime.now()
          : DateTime.now(),
      autoUpdate: (map['autoUpdate'] ?? 0) == 1 || map['autoUpdate'] == true,
      tableType: map['tableType']?.toString() ?? SubscriptionTableKeys.phone,
    );
  }
}
