import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yourcallyourrule/core/base/base_entity.dart';
import 'package:yourcallyourrule/core/value_objects/url.dart';
import 'package:yourcallyourrule/core/entities/subscription/subscription_table_type.dart';

part 'contact_subscription.freezed.dart';

/// 联系人订阅领域实体 (@freezed 自动生成不可变数据类)
@freezed
abstract class ContactSubscription with _$ContactSubscription implements BaseEntity {
  const ContactSubscription._();

  @Implements<BaseEntity>()
  const factory ContactSubscription({
    required String id,
    required String name,
    required Url url,
    @Default(true) bool isEnabled,
    @Default(false) bool autoUpdate,
    required DateTime lastUpdated,
    @Default(SubscriptionTableKeys.contact) String tableType,
  }) = _ContactSubscription;

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
      'autoUpdate': autoUpdate ? 1 : 0,
      'lastUpdated': lastUpdated.toIso8601String(),
      'tableType': tableType,
    };
  }

  /// 从 Map 反序列化生成实体
  factory ContactSubscription.fromMap(Map<String, dynamic> map) {
    return ContactSubscription(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      url: Url.fromString(map['url']?.toString() ?? ''),
      isEnabled: (map['isEnabled'] ?? 1) == 1 || map['isEnabled'] == true,
      autoUpdate: (map['autoUpdate'] ?? 0) == 1 || map['autoUpdate'] == true,
      lastUpdated: map['lastUpdated'] != null
          ? DateTime.tryParse(map['lastUpdated'].toString()) ?? DateTime.now()
          : DateTime.now(),
      tableType: map['tableType']?.toString() ?? SubscriptionTableKeys.contact,
    );
  }
}
