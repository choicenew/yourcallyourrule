import 'package:json_annotation/json_annotation.dart';

part 'backup_config_entity.g.dart';

@JsonSerializable()
class BackupConfigEntity {
  /// 备份版本管理策略
  final bool keepAllVersions;
  
  /// 设备标识名称
  final String deviceName;
  
  /// 自定义同步文件夹名称
  final String? customSyncFolderName;
  
  /// 本地备份目录
  final String localBackupPath;
  
  /// 自动备份间隔
  final Duration? automaticBackupInterval;
  
  /// 是否启用加密
  final bool encryptionEnabled;
  
  const BackupConfigEntity({
    this.keepAllVersions = false,
    required this.deviceName,
    this.customSyncFolderName,
    required this.localBackupPath,
    this.automaticBackupInterval,
    this.encryptionEnabled = false,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'keepAllVersions': keepAllVersions,
      'deviceName': deviceName,
      'localBackupPath': localBackupPath,
      'automaticBackupInterval': automaticBackupInterval?.inMilliseconds,
      'encryptionEnabled': encryptionEnabled,
    };
  }
  
  factory BackupConfigEntity.fromJson(Map<String, dynamic> json) {
    return BackupConfigEntity(
      keepAllVersions: json['keepAllVersions'] as bool,
      deviceName: json['deviceName'] as String,
      localBackupPath: json['localBackupPath'] as String,
      automaticBackupInterval: json['automaticBackupInterval'] != null
          ? Duration(milliseconds: json['automaticBackupInterval'] as int)
          : null,
      encryptionEnabled: json['encryptionEnabled'] as bool? ?? false,
    );
  }
}