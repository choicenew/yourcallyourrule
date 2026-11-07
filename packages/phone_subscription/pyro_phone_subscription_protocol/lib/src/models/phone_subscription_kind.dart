import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_subscription_kind.freezed.dart';
part 'phone_subscription_kind.g.dart';

/// 纯数据驱动电话订阅类型领域值对象 (PhoneSubscriptionKind)
@freezed
abstract class PhoneSubscriptionKind with _$PhoneSubscriptionKind {
  const PhoneSubscriptionKind._();

  const factory PhoneSubscriptionKind({
    required String id,
  }) = _PhoneSubscriptionKind;

  static const PhoneSubscriptionKind phoneRules = PhoneSubscriptionKind(id: 'phoneRules');
  static const PhoneSubscriptionKind smartDictionary = PhoneSubscriptionKind(id: 'smartDictionary');
  static const PhoneSubscriptionKind deletionRules = PhoneSubscriptionKind(id: 'deletionRules');

  factory PhoneSubscriptionKind.fromJson(Map<String, dynamic> json) => _$PhoneSubscriptionKindFromJson(json);

  factory PhoneSubscriptionKind.fromMap(Map<String, dynamic> map) => PhoneSubscriptionKind.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
