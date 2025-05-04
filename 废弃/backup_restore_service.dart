import '../core/entities/rule/rule_base.dart';

/// 备份配置实体
class BackupConfigEntity {
  /// 是否启用自动备份
  final bool autoBackupEnabled;
  
  /// 自动备份间隔（小时）
  final int autoBackupIntervalHours;
  
  /// 最大备份版本数
  final int maxBackupVersions;
  final bool keepAllVersions;
  final String deviceName;
  final String localBackupPath;
  final Duration? automaticBackupInterval;
  
  /// 是否启用加密
  final bool encryptionEnabled;
  
  /// 备份目标路径
  final String? backupDestination;
  
  /// 上次备份时间
  final DateTime? lastBackupTime;
  
  /// 构造函数
  BackupConfigEntity({
    this.autoBackupEnabled = false,
    this.autoBackupIntervalHours = 24,
    this.maxBackupVersions = 5,
    this.encryptionEnabled = false,
    this.backupDestination,
    this.lastBackupTime,
  });
  
  /// 从JSON创建
  factory BackupConfigEntity.fromJson(Map<String, dynamic> json) {
    return BackupConfigEntity(
      autoBackupEnabled: json['autoBackupEnabled'] as bool? ?? false,
      autoBackupIntervalHours: json['autoBackupIntervalHours'] as int? ?? 24,
      maxBackupVersions: json['maxBackupVersions'] as int? ?? 5,
      keepAllVersions: json['keepAllVersions'] as bool? ?? false,
      deviceName: json['deviceName'] as String,
      localBackupPath: json['localBackupPath'] as String,
      automaticBackupInterval: json['automaticBackupInterval'] != null ? Duration(milliseconds: json['automaticBackupInterval'] as int) : null,
      encryptionEnabled: json['encryptionEnabled'] as bool? ?? false,
      backupDestination: json['backupDestination'] as String?,
      lastBackupTime: json['lastBackupTime'] != null
          ? DateTime.parse(json['lastBackupTime'] as String)
          : null,
    );
  }
  
  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'autoBackupEnabled': autoBackupEnabled,
      'autoBackupIntervalHours': autoBackupIntervalHours,
      'maxBackupVersions': maxBackupVersions,
      'encryptionEnabled': encryptionEnabled,
      'backupDestination': backupDestination,
      'lastBackupTime': lastBackupTime?.toIso8601String(),
    };
  }
  
  /// 复制并修改
  BackupConfigEntity copyWith({
    bool? autoBackupEnabled,
    int? autoBackupIntervalHours,
    int? maxBackupVersions,
    bool? encryptionEnabled,
    String? backupDestination,
    DateTime? lastBackupTime,
  }) {
    return BackupConfigEntity(
      autoBackupEnabled: autoBackupEnabled ?? this.autoBackupEnabled,
      autoBackupIntervalHours: autoBackupIntervalHours ?? this.autoBackupIntervalHours,
      maxBackupVersions: maxBackupVersions ?? this.maxBackupVersions,
      encryptionEnabled: encryptionEnabled ?? this.encryptionEnabled,
      backupDestination: backupDestination ?? this.backupDestination,
      lastBackupTime: lastBackupTime ?? this.lastBackupTime,
    );
  }
}

/// 备份版本实体
class BackupVersionEntity {
  /// 版本ID
  final String id;
  
  /// 创建时间
  final DateTime createdAt;
  
  /// 备份文件路径
  final String filePath;
  
  /// 备份大小（字节）
  final int size;
  
  /// 备份描述
  final String? description;
  
  /// 是否加密
  final bool isEncrypted;
  
  /// 构造函数
  BackupVersionEntity({
    required this.id,
    required this.createdAt,
    required this.filePath,
    required this.size,
    this.description,
    this.isEncrypted = false,
  });
  
  /// 从JSON创建
  factory BackupVersionEntity.fromJson(Map<String, dynamic> json) {
    return BackupVersionEntity(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      filePath: json['filePath'] as String,
      size: json['size'] as int,
      description: json['description'] as String?,
      isEncrypted: json['isEncrypted'] as bool? ?? false,
    );
  }
  
  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'filePath': filePath,
      'size': size,
      'description': description,
      'isEncrypted': isEncrypted,
    };
  }
}

/// 备份和恢复服务接口
abstract class BackupRestoreService {
  final CloudDataConverter dataConverter;
  final SyncConflictResolver conflictResolver;

  BackupRestoreService(this.dataConverter, this.conflictResolver);
  /// 初始化备份服务
  Future<void> initialize(Map<String, dynamic> config);
  
  /// 检查服务是否已配置
  Future<bool> isConfigured();
  
  /// 获取备份配置
  Future<BackupConfigEntity> getBackupConfig();
  
  /// 更新备份配置
  Future<void> updateBackupConfig(BackupConfigEntity config) async {
    final serialized = dataConverter.serializeBackupConfig(config);
    return _saveConfigToCloud(serialized);
  }
  
  /// 获取备份版本历史
  Future<List<BackupVersionEntity>> getBackupVersions();
  
  /// 检查备份加密是否启用
  Future<bool> isEncryptionEnabled();
  
  /// 启用或禁用备份加密
  Future<void> setEncryptionEnabled(bool enabled);
  
  /// 设置加密密码
  Future<void> setEncryptionPassword(String password);
  
  /// 验证加密密码
  Future<bool> validateEncryptionPassword(String password);
  
  /// 清除加密设置
  Future<void> clearEncryptionSettings();
  
  /// 备份规则到文件
  Future<String> backupRules(List<RuleBase> rules, String destination);
  
  /// 从文件恢复规则
  Future<List<RuleBase>> restoreRules(String source) async {
    final cloudData = await _performRestore(source);
    final localData = await dataConverter.getLocalRulesSnapshot();
    final resolved = await conflictResolver.resolveConflicts({
      'backup': {'local': localData, 'cloud': cloudData}
    });
    return dataConverter.deserializeRules(resolved['backup']);
  }
  
  /// 备份应用设置
  Future<String> backupSettings(String destination);
  
  /// 恢复应用设置
  Future<bool> restoreSettings(String source);
  
  /// 备份通话和短信历史记录
  Future<String> backupHistory(String destination, {DateTime? startDate, DateTime? endDate});
  
  /// 恢复通话和短信历史记录
  Future<bool> restoreHistory(String source);
  
  /// 设置自动备份
  Future<bool> scheduleAutomaticBackup(Duration interval, String destination);
  
  /// 取消自动备份
  Future<bool> cancelAutomaticBackup();
  
  /// 获取可用备份文件列表
  Future<List<String>> getAvailableBackups();
  
  /// 使用系统文件选择器选择备份文件
  Future<String> selectBackupFile();
  
  /// 使用系统文件选择器选择备份目标
  Future<String> selectBackupDestination();
  
  /// 获取服务类型标识符
  String get serviceType;
  
  /// 获取服务的用户友好名称
  String get serviceName;
}