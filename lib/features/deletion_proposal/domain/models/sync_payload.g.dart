// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NumberUpdatePayload _$NumberUpdatePayloadFromJson(Map<String, dynamic> json) =>
    NumberUpdatePayload(
      phoneNumber: json['phoneNumber'] as String,
      label: json['label'] as String,
      action: (json['action'] as num).toInt(),
      count: (json['count'] as num?)?.toInt(),
      countryIsoCode: json['countryIsoCode'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$NumberUpdatePayloadToJson(
  NumberUpdatePayload instance,
) => <String, dynamic>{
  'phoneNumber': instance.phoneNumber,
  'label': instance.label,
  'action': instance.action,
  'count': instance.count,
  'countryIsoCode': instance.countryIsoCode,
  'runtimeType': instance.$type,
};

ProposeDeletionPayload _$ProposeDeletionPayloadFromJson(
  Map<String, dynamic> json,
) => ProposeDeletionPayload(
  report: ServerVerificationReport.fromJson(
    json['report'] as Map<String, dynamic>,
  ),
  timestamp: json['timestamp'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$ProposeDeletionPayloadToJson(
  ProposeDeletionPayload instance,
) => <String, dynamic>{
  'report': instance.report,
  'timestamp': instance.timestamp,
  'runtimeType': instance.$type,
};

VoteDeletionPayload _$VoteDeletionPayloadFromJson(Map<String, dynamic> json) =>
    VoteDeletionPayload(
      voteType: json['voteType'] as String,
      additionalData: json['additionalData'] as Map<String, dynamic>?,
      timestamp: json['timestamp'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$VoteDeletionPayloadToJson(
  VoteDeletionPayload instance,
) => <String, dynamic>{
  'voteType': instance.voteType,
  'additionalData': instance.additionalData,
  'timestamp': instance.timestamp,
  'runtimeType': instance.$type,
};
