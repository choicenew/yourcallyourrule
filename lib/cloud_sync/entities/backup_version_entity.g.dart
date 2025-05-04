// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_version_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BackupVersionEntity _$BackupVersionEntityFromJson(Map<String, dynamic> json) =>
    BackupVersionEntity(
      version: json['version'] as String,
      backupTime: DateTime.parse(json['backupTime'] as String),
      deviceName: json['deviceName'] as String,
      filePath: json['filePath'] as String,
      backupType: json['backupType'] as String,
    );

Map<String, dynamic> _$BackupVersionEntityToJson(
        BackupVersionEntity instance) =>
    <String, dynamic>{
      'version': instance.version,
      'backupTime': instance.backupTime.toIso8601String(),
      'deviceName': instance.deviceName,
      'filePath': instance.filePath,
      'backupType': instance.backupType,
    };
