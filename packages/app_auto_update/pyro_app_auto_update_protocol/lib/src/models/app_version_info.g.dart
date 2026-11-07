// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppVersionInfo _$AppVersionInfoFromJson(Map<String, dynamic> json) =>
    _AppVersionInfo(
      latestVersion: json['latestVersion'] as String,
      versionCode: (json['versionCode'] as num).toInt(),
      downloadUrl: json['downloadUrl'] as String,
      releaseNotes: json['releaseNotes'] as String?,
      isForceUpdate: json['isForceUpdate'] as bool? ?? false,
    );

Map<String, dynamic> _$AppVersionInfoToJson(_AppVersionInfo instance) =>
    <String, dynamic>{
      'latestVersion': instance.latestVersion,
      'versionCode': instance.versionCode,
      'downloadUrl': instance.downloadUrl,
      'releaseNotes': instance.releaseNotes,
      'isForceUpdate': instance.isForceUpdate,
    };
