// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_subscription_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PhoneSubscriptionPayload _$PhoneSubscriptionPayloadFromJson(
  Map<String, dynamic> json,
) => _PhoneSubscriptionPayload(
  payloadId: json['payloadId'] as String,
  kind: PhoneSubscriptionKind.fromJson(json['kind'] as Map<String, dynamic>),
  rawJsonMap: json['rawJsonMap'] as Map<String, dynamic>,
  timestamp: (json['timestamp'] as num?)?.toInt(),
);

Map<String, dynamic> _$PhoneSubscriptionPayloadToJson(
  _PhoneSubscriptionPayload instance,
) => <String, dynamic>{
  'payloadId': instance.payloadId,
  'kind': instance.kind,
  'rawJsonMap': instance.rawJsonMap,
  'timestamp': instance.timestamp,
};
