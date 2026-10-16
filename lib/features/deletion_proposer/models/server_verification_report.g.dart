// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_verification_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ServerVerificationReport _$ServerVerificationReportFromJson(
  Map<String, dynamic> json,
) => _ServerVerificationReport(
  simState: json['simState'] as String,
  finalRisk: json['finalRisk'] as String,
  deviceId: json['deviceId'] as String?,
  isRoaming: json['isRoaming'] as bool? ?? false,
  simCountry: json['simCountry'] as String?,
  ipCountry: json['ipCountry'] as String?,
  isNumberMatch: json['isNumberMatch'] as bool? ?? false,
  riskScore: (json['riskScore'] as num?)?.toInt(),
);

Map<String, dynamic> _$ServerVerificationReportToJson(
  _ServerVerificationReport instance,
) => <String, dynamic>{
  'simState': instance.simState,
  'finalRisk': instance.finalRisk,
  'deviceId': instance.deviceId,
  'isRoaming': instance.isRoaming,
  'simCountry': instance.simCountry,
  'ipCountry': instance.ipCountry,
  'isNumberMatch': instance.isNumberMatch,
  'riskScore': instance.riskScore,
};
