import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'backup_restore_service.dart';
import 'backup_encryption_service.dart';
import '../core/entities/rule/rule_base.dart';

/// 备份恢复状态
class BackupRestoreState {
  /// 备份配置
  final BackupConfigEntity config;
  
  /// 备份版本列表
  final List<BackupVersionEntity> backupVersions;
  
  /// 是否正在备份
  final bool isBackingUp;
  
  /// 是否正在恢复
  final bool isRestoring;
  
  /// 备份进度（0-100）
  final int backupProgress;
  
  /// 恢复进度（0-100）
  final int restoreProgress;
  
  /// 状态消息
  final String? statusMessage;
  
  /// 是否有错误
  final bool hasError;
  
  /// 错误消息
  final String? errorMessage;
  
  /// 构造函数
  BackupRestoreState({
    required this.config,
    this.backupVersions = const [],
    this.isBackingUp = false,
    this.isRestoring = false,
    this.backupProgress = 0,
    this.restoreProgress = 0,
    this.statusMessage,
    this.hasError = false,
    this.errorMessage,
  });
  
  /// 创建初始状态
  factory BackupRestoreState.initial() {
    return BackupRestoreState(
      config: BackupConfigEntity(),
    );
  }
  
  /// 复制并修改
  BackupRestoreState copyWith({
    BackupConfigEntity? config,
    List<BackupVersionEntity>? backupVersions,
    bool? isBackingUp,
    bool? isRestoring,
    int? backupProgress,
    int? restoreProgress,
    String? statusMessage,
    bool? hasError,
    String? errorMessage,
  }) {
    return BackupRestoreState(
      config: config ?? this.config,
      backupVersions: backupVersions ?? this.backupVersions,
      isBackingUp: isBackingUp ?? this.isBackingUp,
      isRestoring: isRestoring ?? this.isRestoring,
      backupProgress: backupProgress ?? this.backupProgress,
      restoreProgress: restoreProgress ?? this.restoreProgress,
      statusMessage: statusMessage ?? this.statusMessage,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// 备份恢复服务实现
class BackupRestoreServiceImpl implements BackupRestoreService {
  final BackupEncryptionService _encryptionService;
  bool _isInitialized = false;
  
  BackupConfigEntity _config = BackupConfigEntity();
  final List<BackupVersionEntity> _backupVersions = [];
  
  /// 构造函数
  BackupRestoreServiceImpl(this._encryptionService);
  
  @override
  Future<void> initialize(Map<String, dynamic> config) async {
    if (_isInitialized) return;
    
    // 初始化加密服务
    await _encryptionService.initialize();
    
    // 加载备份配置
    // 实际实现应该从存储中加载配置
    _config = BackupConfigEntity(
      autoBackupEnabled: config['autoBackupEnabled'] as bool? ?? false,
      autoBackupIntervalHours: config['autoBackupIntervalHours'] as int? ?? 24,
      maxBackupVersions: config['maxBackupVersions'] as int? ?? 5,
      encryptionEnabled: await _encryptionService.isEncryptionEnabled(),
      backupDestination: config['backupDestination'] as String?,
      lastBackupTime: config['lastBackupTime'] != null
          ? DateTime.parse(config['lastBackupTime'] as String)
          : null,
    );
    
    _isInitialized = true;
  }
  
  @override
  Future<bool> isConfigured() async {
    return _isInitialized;
  }
  
  @override
  Future<BackupConfigEntity> getBackupConfig() async {
    return _config;
  }
  
  @override
  Future<void> updateBackupConfig(BackupConfigEntity config) async {
    _config = config;
    // 实际实现应该将配置保存到存储中
  }
  
  @override
  Future<List<BackupVersionEntity>> getBackupVersions() async {
    // 实际实现应该从存储中加载备份版本列表
    return _backupVersions;
  }
  
  @override
  Future<bool> isEncryptionEnabled() async {
    return await _encryptionService.isEncryptionEnabled();
  }
  
  @override
  Future<void> setEncryptionEnabled(bool enabled) async {
    await _encryptionService.setEncryptionEnabled(enabled);
    _config = _config.copyWith(encryptionEnabled: enabled);
    // 实际实现应该将配置保存到存储中
  }
  
  @override
  Future<void> setEncryptionPassword(String password) async {
    await _encryptionService.setEncryptionPassword(password);
  }
  
  @override
  Future<bool> validateEncryptionPassword(String password) async {
    return await _encryptionService.validateEncryptionPassword(password);
  }
  
  @override
  Future<void> clearEncryptionSettings() async {
    await _encryptionService.clearEncryptionSettings();
    _config = _config.copyWith(encryptionEnabled: false);
    // 实际实现应该将配置保存到存储中
  }
  
  @override
  Future<String> backupRules(List<RuleBase> rules, String destination) async {
    // 实际实现应该将规则序列化为JSON，然后保存到指定目标
    // 如果启用了加密，应该加密数据
    
    // 创建备份版本记录
    final versionId = DateTime.now().millisecondsSinceEpoch.toString();
    final version = BackupVersionEntity(
      id: versionId,
      createdAt: DateTime.now(),
      filePath: destination,
      size: 0, // 实际实现应该计算文件大小
      description: '规则备份',
      isEncrypted: _config.encryptionEnabled,
    );
    
    // 添加到备份版本列表
    _backupVersions.add(version);
    
    // 限制备份版本数量
    if (_backupVersions.length > _config.maxBackupVersions) {
      _backupVersions.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      _backupVersions.removeRange(_config.maxBackupVersions, _backupVersions.length);
    }
    
    // 更新上次备份时间
    _config = _config.copyWith(lastBackupTime: DateTime.now());
    
    return destination;
  }
  
  @override
  Future<List<RuleBase>> restoreRules(String source) async {
    // 实际实现应该从指定源加载规则数据
    // 如果数据已加密，应该解密数据
    
    // 这里简单返回空列表
    return [];
  }
  
  @override
  Future<String> backupSettings(String destination) async {
    // 实际实现应该将设置序列化为JSON，然后保存到指定目标
    // 如果启用了加密，应该加密数据
    
    return destination;
  }
  
  @override
  Future<bool> restoreSettings(String source) async {
    // 实际实现应该从指定源加载设置数据
    // 如果数据已加密，应该解密数据
    
    return true;
  }
  
  @override
  Future<String> backupHistory(String destination, {DateTime? startDate, DateTime? endDate}) async {
    // 实际实现应该将历史记录序列化为JSON，然后保存到指定目标
    // 如果启用了加密，应该加密数据
    
    return destination;
  }
  
  @override
  Future<bool> restoreHistory(String source) async {
    // 实际实现应该从指定源加载历史记录数据
    // 如果数据已加密，应该解密数据
    
    return true;
  }
  
  @override
  Future<bool> scheduleAutomaticBackup(Duration interval, String destination) async {
    _config = _config.copyWith(
      autoBackupEnabled: true,
      autoBackupIntervalHours: interval.inHours,
      backupDestination: destination,
    );
    
    // 实际实现应该设置定时任务
    
    return true;
  }
  
  @override
  Future<bool> cancelAutomaticBackup() async {
    _config = _config.copyWith(autoBackupEnabled: false);
    
    // 实际实现应该取消定时任务
    
    return true;
  }
  
  @override
  Future<List<String>> getAvailableBackups() async {
    // 实际实现应该扫描备份目录
    return _backupVersions.map((v) => v.filePath).toList();
  }
  
  @override
  Future<String> selectBackupFile() async {
    // 实际实现应该调用系统文件选择器
    return '';
  }
  
  @override
  Future<String> selectBackupDestination() async {
    // 实际实现应该调用系统文件选择器
    return '';
  }
  
  @override
  String get serviceType => 'LocalBackupRestore';
  
  @override
  String get serviceName => '本地备份恢复';
}

/// 备份恢复提供者
class BackupRestoreProvider extends StateNotifier<BackupRestoreState> {
  /// 备份恢复服务实例
  final BackupRestoreService _service;
  
  /// 构造函数
  BackupRestoreProvider(this._service) : super(BackupRestoreState.initial()) {
    _initialize();
  }
  
  /// 初始化
  Future<void> _initialize() async {
    try {
      await _service.initialize({});
      final config = await _service.getBackupConfig();
      final versions = await _service.getBackupVersions();
      
      state = state.copyWith(
        config: config,
        backupVersions: versions,
      );
    } catch (e) {
      state = state.copyWith(
        hasError: true,
        errorMessage: '初始化备份恢复服务失败: $e',
      );
    }
  }
  
  /// 更新备份配置
  Future<void> updateBackupConfig(BackupConfigEntity config) async {
    try {
      await _service.updateBackupConfig(config);
      
      state = state.copyWith(
        config: config,
        hasError: false,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        hasError: true,
        errorMessage: '更新备份配置失败: $e',
      );
    }
  }
  
  /// 启用或禁用加密
  Future<void> setEncryptionEnabled(bool enabled) async {
    try {
      state = state.copyWith(
        statusMessage: enabled ? '正在启用加密...' : '正在禁用加密...',
      );
      
      await _service.setEncryptionEnabled(enabled);
      final config = await _service.getBackupConfig();
      
      state = state.copyWith(
        config: config,
        statusMessage: enabled ? '已启用加密' : '已禁用加密',
        hasError: false,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        hasError: true,
        errorMessage: '${enabled ? '启用' : '禁用'}加密失败: $e',
      );
    }
  }
  
  /// 设置加密密码
  Future<void> setEncryptionPassword(String password) async {
    try {
      state = state.copyWith(
        statusMessage: '正在设置加密密码...',
      );
      
      await _service.setEncryptionPassword(password);
      
      state = state.copyWith(
        statusMessage: '已设置加密密码',
        hasError: false,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        hasError: true,
        errorMessage: '设置加密密码失败: $e',
      );
    }
  }
  
  /// 验证加密密码
  Future<bool> validateEncryptionPassword(String password) async {
    try {
      state = state.copyWith(
        statusMessage: '正在验证加密密码...',
      );
      
      final isValid = await _service.validateEncryptionPassword(password);
      
      state = state.copyWith(
        statusMessage: isValid ? '加密密码验证成功' : '加密密码验证失败',
        hasError: !isValid,
        errorMessage: isValid ? null : '加密密码验证失败',
      );
      
      return isValid;
    } catch (e) {
      state = state.copyWith(
        hasError: true,
        errorMessage: '验证加密密码失败: $e',
      );
      return false;
    }
  }
  
  /// 备份规则
  Future<String?> backupRules(List<dynamic> rules, String destination) async {
    try {
      state = state.copyWith(
        isBackingUp: true,
        backupProgress: 0,
        statusMessage: '正在备份规则...',
      );
      
      final result = await _service.backupRules(rules.cast<RuleBase>(), destination);
      final versions = await _service.getBackupVersions();
      final config = await _service.getBackupConfig();
      
      state = state.copyWith(
        config: config,
        backupVersions: versions,
        isBackingUp: false,
        backupProgress: 100,
        statusMessage: '规则备份完成',
        hasError: false,
        errorMessage: null,
      );
      
      return result;
    } catch (e) {
      state = state.copyWith(
        isBackingUp: false,
        hasError: true,
        errorMessage: '备份规则失败: $e',
      );
      return null;
    }
  }
  
  /// 恢复规则
  Future<List<dynamic>> restoreRules(String source) async {
    try {
      state = state.copyWith(
        isRestoring: true,
        restoreProgress: 0,
        statusMessage: '正在恢复规则...',
      );
      
      final rules = await _service.restoreRules(source);
      
      state = state.copyWith(
        isRestoring: false,
        restoreProgress: 100,
        statusMessage: '规则恢复完成',
        hasError: false,
        errorMessage: null,
      );
      
      return rules;
    } catch (e) {
      state = state.copyWith(
        isRestoring: false,
        hasError: true,
        errorMessage: '恢复规则失败: $e',
      );
      return [];
    }
  }
  
  /// 设置自动备份
  Future<bool> scheduleAutomaticBackup(Duration interval, String destination) async {
    try {
      state = state.copyWith(
        statusMessage: '正在设置自动备份...',
      );
      
      final success = await _service.scheduleAutomaticBackup(interval, destination);
      final config = await _service.getBackupConfig();
      
      state = state.copyWith(
        config: config,
        statusMessage: success ? '已设置自动备份' : '设置自动备份失败',
        hasError: !success,
        errorMessage: success ? null : '设置自动备份失败',
      );
      
      return success;
    } catch (e) {
      state = state.copyWith(
        hasError: true,
        errorMessage: '设置自动备份失败: $e',
      );
      return false;
    }
  }
  
  /// 取消自动备份
  Future<bool> cancelAutomaticBackup() async {
    try {
      state = state.copyWith(
        statusMessage: '正在取消自动备份...',
      );
      
      final success = await _service.cancelAutomaticBackup();
      final config = await _service.getBackupConfig();
      
      state = state.copyWith(
        config: config,
        statusMessage: success ? '已取消自动备份' : '取消自动备份失败',
        hasError: !success,
        errorMessage: success ? null : '取消自动备份失败',
      );
      
      return success;
    } catch (e) {
      state = state.copyWith(
        hasError: true,
        errorMessage: '取消自动备份失败: $e',
      );
      return false;
    }
  }
}

/// 备份恢复提供者
final backupRestoreProvider = StateNotifierProvider<BackupRestoreProvider, BackupRestoreState>((ref) {
  final encryptionService = BackupEncryptionServiceImpl();
  final backupRestoreService = BackupRestoreServiceImpl(encryptionService);
  return BackupRestoreProvider(backupRestoreService);
});

/// 备份恢复服务提供者
final backupRestoreServiceProvider = Provider<BackupRestoreService>((ref) {
  final encryptionService = BackupEncryptionServiceImpl();
  return BackupRestoreServiceImpl(encryptionService);
});