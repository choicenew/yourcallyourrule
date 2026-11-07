// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_call_statistic_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PhoneCallStatisticData _$PhoneCallStatisticDataFromJson(
  Map<String, dynamic> json,
) => _PhoneCallStatisticData(
  totalCalls: (json['totalCalls'] as num?)?.toInt() ?? 0,
  blockedCalls: (json['blockedCalls'] as num?)?.toInt() ?? 0,
  allowedCalls: (json['allowedCalls'] as num?)?.toInt() ?? 0,
  silencedCalls: (json['silencedCalls'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$PhoneCallStatisticDataToJson(
  _PhoneCallStatisticData instance,
) => <String, dynamic>{
  'totalCalls': instance.totalCalls,
  'blockedCalls': instance.blockedCalls,
  'allowedCalls': instance.allowedCalls,
  'silencedCalls': instance.silencedCalls,
};
