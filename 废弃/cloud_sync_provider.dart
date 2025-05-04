import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'cloud_sync_service.dart';
import 'google_drive/google_drive_sync_service.dart';
import 'webdav/webdav_sync_service.dart';
import 'sync_conflict_resolver.dart';
import 'backup_restore_service.dart';
import 'backup_encryption_service.dart';

/// 云同步服务类型枚举
enum CloudSyncServiceType {
  /// Google Drive
  googleDrive,
  
  /// WebDAV
  webdav,
  
  /// OneDrive (待实现)
  onedrive,
}

/// 云同步状态
class CloudSyncState {
  /// 当前选择的服务类型
  final CloudSyncServiceType? selectedServiceType;
  
  /// 是否已连接
  final bool isConnected;
  
  /// 是否正在同步
  final bool isSyncing;
  
  /// 上次同步时间
  final DateTime? lastSyncTime;
  
  /// 同步进度（0-100）
  final int syncProgress;
  
  /// 同步状态消息
  final String? statusMessage;
  
  /// 是否有错误
  final bool hasError;
  
  /// 错误消息
  final String? errorMessage;
  
  /// 已注册的设备列表
  final List<DeviceEntity> registeredDevices;
  
  /// 构造函数
  CloudSyncState({
    this.selectedServiceType,
    this.isConnected = false,
    this.isSyncing = false,
    this.lastSyncTime,
    this.syncProgress = 0,
    this.statusMessage,
    this.hasError = false,
    this.errorMessage,
    this.registeredDevices = const [],
  });
  
  /// 创建初始状态
  factory CloudSyncState.initial() {
    return CloudSyncState();
  }
  
  /// 复制并修改
  CloudSyncState copyWith({
    CloudSyncServiceType? selectedServiceType,
    bool? isConnected,
    bool? isSyncing,
    DateTime? lastSyncTime,
    int? syncProgress,
    String? statusMessage,
    bool? hasError,
    String? errorMessage,
    List<DeviceEntity>? registeredDevices,
  }) {
    return CloudSyncState(
      selectedServiceType: selectedServiceType ?? this.selectedServiceType,
      isConnected: isConnected ?? this.isConnected,
      isSyncing: isSyncing ?? this.isSyncing,
      lastSyncTime: lastSyncTime ?? this.lastSyncTime,
      syncProgress: syncProgress ?? this.syncProgress,
      statusMessage: statusMessage ?? this.statusMessage,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      registeredDevices: registeredDevices ?? this.registeredDevices,
    );
  }
}

/// 云同步提供者
class CloudSyncProvider extends StateNotifier<CloudSyncState> {
  /// 云同步服务实例
  CloudSyncService? _syncService;
  
  /// 备份加密服务实例
  final BackupEncryptionService _encryptionService;
  
  /// 构造函数
  CloudSyncProvider(this._encryptionService) : super(CloudSyncState.initial());
  
  /// 获取当前云同步服务
  CloudSyncService? get syncService => _syncService;
  
  /// 选择云同步服务类型
  Future<bool> selectServiceType(CloudSyncServiceType serviceType) async {
    try {
      // 如果已经有服务实例，先断开连接
      if (_syncService != null) {
        await _syncService!.disconnect();
      }
      
      // 创建新的服务实例
      switch (serviceType) {
        case CloudSyncServiceType.googleDrive:
          _syncService = GoogleDriveSyncService(
            defaultStrategy: ConflictResolutionStrategy.merge,
          );
          break;
        case CloudSyncServiceType.webdav:
          _syncService = WebDAVSyncService(
            defaultStrategy: ConflictResolutionStrategy.merge,
          );
          break;
        case CloudSyncServiceType.onedrive:
          // OneDrive服务待实现
          state = state.copyWith(
            hasError: true,
            errorMessage: 'OneDrive同步服务尚未实现',
          );
          return false;
      }
      
      // 初始化服务
      await _syncService!.initialize({});
      
      // 更新状态
      state = state.copyWith(
        selectedServiceType: serviceType,
        isConnected: false,
        hasError: false,
        errorMessage: null,
      );
      
      return true;
    } catch (e) {
      state = state.copyWith(
        hasError: true,
        errorMessage: '选择同步服务失败: $e',
      );
      return false;
    }
  }
  
  /// 连接到云服务
  Future<bool> connect(Map<String, dynamic> credentials) async {
    if (_syncService == null) {
      state = state.copyWith(
        hasError: true,
        errorMessage: '请先选择同步服务类型',
      );
      return false;
    }
    
    try {
      state = state.copyWith(
        isSyncing: true,
        statusMessage: '正在连接到${_syncService!.serviceName}...',
      );
      
      final success = await _syncService!.connect(credentials);
      
      if (success) {
        // 连接成功后获取已注册设备
        final devices = await _syncService!.getRegisteredDevicesFromCloud();
        
        state = state.copyWith(
          isConnected: true,
          isSyncing: false,
          statusMessage: '已连接到${_syncService!.serviceName}',
          hasError: false,
          errorMessage: null,
          registeredDevices: devices,
        );
      } else {
        state = state.copyWith(
          isConnected: false,
          isSyncing: false,
          hasError: true,
          errorMessage: '连接到${_syncService!.serviceName}失败',
        );
      }
      
      return success;
    } catch (e) {
      state = state.copyWith(
        isConnected: false,
        isSyncing: false,
        hasError: true,
        errorMessage: '连接到云服务失败: $e',
      );
      return false;
    }
  }
  
  /// 断开云服务连接
  Future<bool> disconnect() async {
    if (_syncService == null || !state.isConnected) {
      return true;
    }
    
    try {
      state = state.copyWith(
        isSyncing: true,
        statusMessage: '正在断开${_syncService!.serviceName}连接...',
      );
      
      final success = await _syncService!.disconnect();
      
      state = state.copyWith(
        isConnected: !success,
        isSyncing: false,
        statusMessage: success ? '已断开${_syncService!.serviceName}连接' : null,
        hasError: !success,
        errorMessage: success ? null : '断开${_syncService!.serviceName}连接失败',
      );
      
      return success;
    } catch (e) {
      state = state.copyWith(
        isSyncing: false,
        hasError: true,
        errorMessage: '断开云服务连接失败: $e',
      );
      return false;
    }
  }
  
  /// 同步规则
  Future<bool> syncRules(List<dynamic> rules) async {
    if (_syncService == null || !state.isConnected) {
      state = state.copyWith(
        hasError: true,
        errorMessage: '未连接到云服务',
      );
      return false;
    }
    
    try {
      state = state.copyWith(
        isSyncing: true,
        syncProgress: 0,
        statusMessage: '正在同步规则...',
      );
      
      final success = await _syncService!.syncRules(rules.cast<RuleBase>());
      
      state = state.copyWith(
        isSyncing: false,
        syncProgress: 100,
        lastSyncTime: success ? DateTime.now() : state.lastSyncTime,
        statusMessage: success ? '规则同步完成' : null,
        hasError: !success,
        errorMessage: success ? null : '同步规则失败',
      );
      
      return success;
    } catch (e) {
      state = state.copyWith(
        isSyncing: false,
        hasError: true,
        errorMessage: '同步规则失败: $e',
      );
      return false;
    }
  }
  
  /// 从云端获取规则
  Future<List<dynamic>> getRulesFromCloud() async {
    if (_syncService == null || !state.isConnected) {
      state = state.copyWith(
        hasError: true,
        errorMessage: '未连接到云服务',
      );
      return [];
    }
    
    try {
      state = state.copyWith(
        isSyncing: true,
        syncProgress: 0,
        statusMessage: '正在从云端获取规则...',
      );
      
      final rules = await _syncService!.getRulesFromCloud();
      
      state = state.copyWith(
        isSyncing: false,
        syncProgress: 100,
        statusMessage: '已从云端获取${rules.length}条规则',
        hasError: false,
        errorMessage: null,
      );
      
      return rules;
    } catch (e) {
      state = state.copyWith(
        isSyncing: false,
        hasError: true,
        errorMessage: '从云端获取规则失败: $e',
      );
      return [];
    }
  }
  
  /// 同步设置
  Future<bool> syncSettings(Map<String, dynamic> settings) async {
    if (_syncService == null || !state.isConnected) {
      state = state.copyWith(
        hasError: true,
        errorMessage: '未连接到云服务',
      );
      return false;
    }
    
    try {
      state = state.copyWith(
        isSyncing: true,
        syncProgress: 0,
        statusMessage: '正在同步设置...',
      );
      
      final success = await _syncService!.syncSettings(settings);
      
      state = state.copyWith(
        isSyncing: false,
        syncProgress: 100,
        lastSyncTime: success ? DateTime.now() : state.lastSyncTime,
        statusMessage: success ? '设置同步完成' : null,
        hasError: !success,
        errorMessage: success ? null : '同步设置失败',
      );
      
      return success;
    } catch (e) {
      state = state.copyWith(
        isSyncing: false,
        hasError: true,
        errorMessage: '同步设置失败: $e',
      );
      return false;
    }
  }
  
  /// 从云端获取设置
  Future<Map<String, dynamic>?> getSettingsFromCloud() async {
    if (_syncService == null || !state.isConnected) {
      state = state.copyWith(
        hasError: true,
        errorMessage: '未连接到云服务',
      );
      return null;
    }
    
    try {
      state = state.copyWith(
        isSyncing: true,
        syncProgress: 0,
        statusMessage: '正在从云端获取设置...',
      );
      
      final settings = await _syncService!.getSettingsFromCloud();
      
      state = state.copyWith(
        isSyncing: false,
        syncProgress: 100,
        statusMessage: '已从云端获取设置',
        hasError: false,
        errorMessage: null,
      );
      
      return settings;
    } catch (e) {
      state = state.copyWith(
        isSyncing: false,
        hasError: true,
        errorMessage: '从云端获取设置失败: $e',
      );
      return null;
    }
  }
  
  /// 注册设备
  Future<bool> registerDevice(DeviceEntity device) async {
    if (_syncService == null || !state.isConnected) {
      state = state.copyWith(
        hasError: true,
        errorMessage: '未连接到云服务',
      );
      return false;
    }
    
    try {
      state = state.copyWith(
        isSyncing: true,
        syncProgress: 0,
        statusMessage: '正在注册设备...',
      );
      
      final success = await _syncService!.registerDeviceForSync(device);
      
      if (success) {
        // 更新设备列表
        final devices = await _syncService!.getRegisteredDevicesFromCloud();
        
        state = state.copyWith(
          isSyncing: false,
          syncProgress: 100,
          statusMessage: '设备注册完成',
          hasError: false,
          errorMessage: null,
          registeredDevices: devices,
        );
      } else {
        state = state.copyWith(
          isSyncing: false,
          syncProgress: 0,
          hasError: true,
          errorMessage: '注册设备失败',
        );
      }
      
      return success;
    } catch (e) {
      state = state.copyWith(
        isSyncing: false,
        hasError: true,
        errorMessage: '注册设备失败: $e',
      );
      return false;
    }
  }
  
  /// 设置自动同步
  Future<bool> scheduleAutomaticSync(Duration interval) async {
    if (_syncService == null || !state.isConnected) {
      state = state.copyWith(
        hasError: true,
        errorMessage: '未连接到云服务',
      );
      return false;
    }
    
    try {
      state = state.copyWith(
        isSyncing: true,
        statusMessage: '正在设置自动同步...',
      );
      
      final success = await _syncService!.scheduleAutomaticSync(interval);
      
      state = state.copyWith(
        isSyncing: false,
        statusMessage: success ? '已设置自动同步' : null,
        hasError: !success,
        errorMessage: success ? null : '设置自动同步失败',
      );
      
      return success;
    } catch (e) {
      state = state.copyWith(
        isSyncing: false,
        hasError: true,
        errorMessage: '设置自动同步失败: $e',
      );
      return false;
    }
  }
  
  /// 取消自动同步
  Future<bool> cancelAutomaticSync() async {
    if (_syncService == null || !state.isConnected) {
      state = state.copyWith(
        hasError: true,
        errorMessage: '未连接到云服务',
      );
      return false;
    }
    
    try {
      state = state.copyWith(
        isSyncing: true,
        statusMessage: '正在取消自动同步...',
      );
      
      final success = await _syncService!.cancelAutomaticSync();
      
      state = state.copyWith(
        isSyncing: false,
        statusMessage: success ? '已取消自动同步' : null,
        hasError: !success,
        errorMessage: success ? null : '取消自动同步失败',
      );
      
      return success;
    } catch (e) {
      state = state.copyWith(
        isSyncing: false,
        hasError: true,
        errorMessage: '取消自动同步失败: $e',
      );
      return false;
    }
  }
}

/// 云同步提供者
final cloudSyncProvider = StateNotifierProvider<CloudSyncProvider, CloudSyncState>((ref) {
  final encryptionService = BackupEncryptionServiceImpl();
  return CloudSyncProvider(encryptionService);
});

/// 云同步服务提供者
final cloudSyncServiceProvider = Provider<CloudSyncService?>((ref) {
  final provider = ref.watch(cloudSyncProvider.notifier);
  return provider.syncService;
});