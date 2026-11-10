import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pyro_phone_subscription_protocol/src/models/phone_subscription_kind.dart';

part 'phone_subscription_payload.freezed.dart';
part 'phone_subscription_payload.g.dart';

/// 纯数据驱动电话在线订阅载荷强实体 (PhoneSubscriptionPayload)
@freezed
abstract class PhoneSubscriptionPayload with _$PhoneSubscriptionPayload {
  const PhoneSubscriptionPayload._();

  const factory PhoneSubscriptionPayload({
    required String payloadId,
    required PhoneSubscriptionKind kind,
    required Map<String, dynamic> rawJsonMap,
    int? timestamp,
  }) = _PhoneSubscriptionPayload;

  factory PhoneSubscriptionPayload.fromJson(Map<String, dynamic> json) => _$PhoneSubscriptionPayloadFromJson(json);

  factory PhoneSubscriptionPayload.fromMap(Map<String, dynamic> map) => PhoneSubscriptionPayload.fromJson(map);

  Map<String, dynamic> toMap() => toJson();

  String get id => payloadId;
  String? get displayName => rawJsonMap['displayName'] as String? ?? rawJsonMap['name'] as String?;
  String? get downloadUrl => rawJsonMap['downloadUrl'] as String? ?? rawJsonMap['url'] as String?;
}
