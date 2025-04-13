// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_config_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BackupConfigEntity _$BackupConfigEntityFromJson(Map<String, dynamic> json) =>
    BackupConfigEntity(
      keepAllVersions: json['keepAllVersions'] as bool? ?? false,
      deviceName: json['deviceName'] as String,
      customSyncFolderName: json['customSyncFolderName'] as String?,
      localBackupPath: json['localBackupPath'] as String,
      automaticBackupInterval: json['automaticBackupInterval'] == null
          ? null
          : Duration(
              microseconds: (json['automaticBackupInterval'] as num).toInt()),
      encryptionEnabled: json['encryptionEnabled'] as bool? ?? false,
    );

Map<String, dynamic> _$BackupConfigEntityToJson(BackupConfigEntity instance) =>
    <String, dynamic>{
      'keepAllVersions': instance.keepAllVersions,
      'deviceName': instance.deviceName,
      'customSyncFolderName': instance.customSyncFolderName,
      'localBackupPath': instance.localBackupPath,
      'automaticBackupInterval':
          instance.automaticBackupInterval?.inMicroseconds,
      'encryptionEnabled': instance.encryptionEnabled,
    };
