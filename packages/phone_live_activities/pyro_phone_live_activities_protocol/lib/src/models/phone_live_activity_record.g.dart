// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_live_activity_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PhoneLiveActivityRecord _$PhoneLiveActivityRecordFromJson(
  Map<String, dynamic> json,
) => _PhoneLiveActivityRecord(
  activityId: json['activityId'] as String,
  phoneNumber: json['phoneNumber'] as String,
  title: json['title'] as String,
  subtitle: json['subtitle'] as String?,
  status: json['status'] as String? ?? 'active',
  timestamp: (json['timestamp'] as num?)?.toInt(),
);

Map<String, dynamic> _$PhoneLiveActivityRecordToJson(
  _PhoneLiveActivityRecord instance,
) => <String, dynamic>{
  'activityId': instance.activityId,
  'phoneNumber': instance.phoneNumber,
  'title': instance.title,
  'subtitle': instance.subtitle,
  'status': instance.status,
  'timestamp': instance.timestamp,
};
