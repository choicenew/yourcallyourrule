import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yourcallyourrule/core/base/base_entity.dart';
import 'package:yourcallyourrule/core/entities/subscription/subscription_table_type.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/url.dart';

part 'sms_subscription.freezed.dart';

/// 短信订阅实体 (@freezed 自动生成不可变数据类)
@freezed
abstract class SmsSubscription with _$SmsSubscription implements BaseEntity {
  const SmsSubscription._();

  @Implements<BaseEntity>()
  const factory SmsSubscription({
    required String id,
    required String name,
    required Url url,
    @Default(true) bool isEnabled,
    @Default(RuleAction.block) RuleAction action,
    required DateTime lastUpdated,
    @Default(false) bool autoUpdate,
    @Default(SubscriptionTableKeys.sms) String tableType,
  }) = _SmsSubscription;

  @override
  Map<String, dynamic> toJson() => toMap();

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
  factory SmsSubscription.fromMap(Map<String, dynamic> map) {
    return SmsSubscription(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      url: Url.fromString(map['url']?.toString() ?? ''),
      isEnabled: (map['isEnabled'] ?? 1) == 1 || map['isEnabled'] == true,
      action: RuleAction.fromString(map['action']),
      lastUpdated: map['lastUpdated'] != null
          ? DateTime.tryParse(map['lastUpdated'].toString()) ?? DateTime.now()
          : DateTime.now(),
      autoUpdate: (map['autoUpdate'] ?? 0) == 1 || map['autoUpdate'] == true,
      tableType: map['tableType']?.toString() ?? SubscriptionTableKeys.sms,
    );
  }
}
