import 'package:flutter/foundation.dart';
import '../core/entities/rule/rule_base.dart';
import '../core/value_objects/phone_number.dart';

/// 设备实体类，用于多设备同步
class DeviceEntity {
  final String id;
  final String name;
  final String model;
  final String platform;
  final DateTime lastSyncTime;
  final bool isCurrentDevice;

  DeviceEntity({
    required this.id,
    required this.name,
    required this.model,
    required this.platform,
    required this.lastSyncTime,
    this.isCurrentDevice = false,
  });

  factory DeviceEntity.fromJson(Map<String, dynamic> json) {
    return DeviceEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      model: json['model'] as String,
      platform: json['platform'] as String,
      lastSyncTime: DateTime.parse(json['lastSyncTime'] as String),
      isCurrentDevice: json['isCurrentDevice'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'model': model,
      'platform': platform,
      'lastSyncTime': lastSyncTime.toIso8601String(),
      'isCurrentDevice': isCurrentDevice,
    };
  }

  DeviceEntity copyWith({
    String? id,
    String? name,
    String? model,
    String? platform,
    DateTime? lastSyncTime,
    bool? isCurrentDevice,
  }) {
    return DeviceEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      model: model ?? this.model,
      platform: platform ?? this.platform,
      lastSyncTime: lastSyncTime ?? this.lastSyncTime,
      isCurrentDevice: isCurrentDevice ?? this.isCurrentDevice,
    );
  }
}

/// 云同步服务接口
abstract class CloudSyncService {
  final SyncConflictResolver conflictResolver;
  final IncrementalSyncManager syncManager;
  final SyncProgressTracker progressTracker;

  /// 初始化云同步服务
  Future<void> initialize(Map<String, dynamic> config);
  
  /// 检查服务是否已配置
  Future<bool> isConfigured();
  
  /// 连接到云服务
  Future<bool> connect(Map<String, dynamic> credentials);
  
  /// 断开云服务连接
  Future<bool> disconnect();
  
  /// 同步规则到云端
  Future<bool> syncRules(List<RuleBase> rules);
  
  /// 从云端获取规则
  Future<List<RuleBase>> getRulesFromCloud();
  
  /// 同步应用设置到云端
  Future<bool> syncSettings(Map<String, dynamic> settings);
  
  /// 从云端获取应用设置
  Future<Map<String, dynamic>?> getSettingsFromCloud();
  
  /// 同步通话和短信记录到云端
  Future<bool> syncHistory(List<Map<String, dynamic>> history);
  
  /// 从云端获取通话和短信记录
  Future<List<Map<String, dynamic>>> getHistoryFromCloud();
  
  /// 设置自动同步
  Future<bool> scheduleAutomaticSync(Duration interval);
  
  /// 取消自动同步
  Future<bool> cancelAutomaticSync();
  
  /// 解决同步冲突
  Future<Map<String, dynamic>> resolveSyncConflicts(Map<String, dynamic> conflicts) async {
    return conflictResolver.resolveConflicts(conflicts);
  }
  
  /// 获取同步状态
  Future<Map<String, dynamic>> getSyncStatus();
  
  /// 注册设备用于多设备同步
  Future<bool> registerDeviceForSync(DeviceEntity device);
  
  /// 从云端获取已注册设备
  Future<List<DeviceEntity>> getRegisteredDevicesFromCloud();
  
  /// 同步设备信息到云端
  Future<bool> syncDeviceInfo(DeviceEntity device);
  
  /// 从云端同步设备信息到本地
  Future<bool> syncDevicesFromCloud();
  
  /// 获取服务类型标识符（WebDAV、OneDrive、Google Drive等）
  String get serviceType;

  /// 执行增量同步
  Future<void> performIncrementalSync();

  /// 获取同步进度流
  Stream<double> get syncProgress;

  /// 注册设备同步监听
  void registerDeviceSyncListener(DeviceEntity device);
  
  /// 获取服务的用户友好名称
  String get serviceName;
}