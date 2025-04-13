import 'package:json_annotation/json_annotation.dart';

part 'backup_version_entity.g.dart';

@JsonSerializable()
class BackupVersionEntity {
  /// 备份版本号
  final String version;
  
  /// 备份时间
  final DateTime backupTime;
  
  /// 设备标识名称
  final String deviceName;
  
  /// 备份文件路径
  final String filePath;
  
  /// 备份类型（规则/设置/通知历史）
  final String backupType;
  
  const BackupVersionEntity({
    required this.version,
    required this.backupTime,
    required this.deviceName,
    required this.filePath,
    required this.backupType,
  });
  
  factory BackupVersionEntity.fromJson(Map<String, dynamic> json) =>
      _$BackupVersionEntityFromJson(json);
  
  Map<String, dynamic> toJson() => _$BackupVersionEntityToJson(this);
}